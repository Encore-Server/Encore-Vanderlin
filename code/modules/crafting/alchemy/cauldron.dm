/obj/machinery/essence/cauldron_node
	name = "cauldron essence node"
	desc = "An internal essence conduit."
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "cauldron1"
	density = FALSE
	anchored = TRUE
	accepts_input = TRUE
	accepts_output = TRUE
	mouse_opacity = MOUSE_OPACITY_TRANSPARENT
	var/obj/machinery/light/fueled/cauldron/owner

/obj/machinery/essence/cauldron_node/Initialize(mapload, obj/machinery/light/fueled/cauldron/parent)
	. = ..()
	owner = parent
	storage.max_total = 300
	storage.max_types = 6

/obj/machinery/essence/cauldron_node/Destroy()
	owner = null
	return ..()

/obj/machinery/essence/cauldron_node/push_to_linked(datum/essence_storage/from_storage)
	push_surplus_to_linked(from_storage)

/obj/machinery/essence/cauldron_node/build_allowed_types()
	if(!owner || QDELETED(owner))
		return list()

	var/datum/alch_cauldron_recipe/recipe = owner.selected_recipe
	if(!recipe)
		return list()

	// Keep accepting recipe essences for the whole brew so a pot
	// that started heating on the first splash can still finish filling.
	var/list/allowed = list()
	var/max_batches = owner.calculate_max_possible_batches(recipe)

	for(var/essence_type in recipe.required_essences)
		var/needed_total = recipe.required_essences[essence_type] * max_batches
		var/already_have = (owner.essence_contents[essence_type] || 0) + storage.get(essence_type)
		var/room = needed_total - already_have
		if(room > 0)
			allowed[essence_type] = room

	return allowed

/obj/machinery/essence/cauldron_node/show_link_beams()
	if(!links.len)
		return
	for(var/datum/essence_link/link in links)
		var/obj/machinery/essence/other = (link.source == src) ? link.sink : link.source
		if(!other || QDELETED(other))
			continue
		var/turf/other_turf = resolve_beam_turf(other)
		if(!other_turf)
			continue
		var/beam_color = (link.source == src) ? "#88CCFF" : "#FFAA44"
		owner.Beam(other_turf, icon_state = "light_beam", time = 1.5 SECONDS, beam_color = beam_color)

/obj/machinery/light/fueled/cauldron
	name = "cauldron"
	desc = "Bubble, Bubble, toil and trouble. A great iron cauldron for brewing potions from alchemical essences."
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "cauldron1"
	base_state = "cauldron"
	density = TRUE
	opacity = FALSE
	anchored = TRUE
	max_integrity = 300
	var/list/essence_contents = list()
	var/max_essence_types = 6
	var/brewing = 0
	var/datum/weakref/lastuser
	fueluse = 20 MINUTES
	crossfire = FALSE

	var/datum/alch_cauldron_recipe/selected_recipe = null
	var/obj/machinery/essence/cauldron_node/essence_node = null
	/// How many units of potion this brew is set to make (1-100). Water and essences scale from this.
	var/brew_units = 0

	/// Ticks of heat needed before a brew resolves.
	var/brew_time = 20

/obj/machinery/light/fueled/cauldron/Initialize()
	. = ..()
	if(reagents)
		QDEL_NULL(reagents)
	create_reagents(100, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	essence_node = new /obj/machinery/essence/cauldron_node(null, src) // nullspace

/obj/machinery/light/fueled/cauldron/Destroy()
	if(essence_node && !QDELETED(essence_node))
		qdel(essence_node)
	essence_node = null
	lastuser = null
	selected_recipe = null
	return ..()

/obj/machinery/light/fueled/cauldron/examine(mob/user)
	. = ..()
	if(selected_recipe)
		. += span_info("Recipe selected: [initial(selected_recipe.recipe_name)] ([brew_units] units)")
	else
		. += span_notice("No recipe selected. Click with empty hand to choose a potion and amount.")

	if(!on)
		. += span_warning("It is not lit. It will not boil until it is fueled and ignited.")
	else if(!has_water())
		. += span_warning("It needs [water_needed()] units of water to brew. Currently [reagents?.get_reagent_amount(/datum/reagent/water) || 0].")

	if(brewing > 0)
		. += span_notice("The mixture is boiling. ([brewing]/[brew_time])")

	if(selected_recipe)
		. += span_notice("Required essences:")
		for(var/essence_type in selected_recipe.required_essences)
			var/datum/thaumaturgical_essence/essence = new essence_type
			var/required = selected_recipe.required_essences[essence_type]
			var/current = essence_contents[essence_type] || 0
			. += span_notice("  - [essence.name]: [current]/[required]")
			qdel(essence)

		var/list/extras = extra_essence_types()
		if(length(extras))
			. += span_info("Unused essences will be returned to the conduit when the brew finishes.")

	if(essence_node && essence_node.links.len)
		. += span_notice("Essence links: [essence_node.links.len] connected.")

/obj/machinery/light/fueled/cauldron/attack_hand(mob/user)
	if(!user.default_can_use_topic(src))
		return
	show_recipe_menu(user)

/obj/machinery/light/fueled/cauldron/item_interaction(mob/living/user, obj/item/tool, list/modifiers)
	if(user.cmode)
		return NONE

	if(tool.reagents && (tool.is_open_container() || (tool.reagents.flags & OPENCONTAINER) || (tool.reagents.flags & DRAINABLE)))
		return handle_water_pour(user, tool)

	if(!istype(tool, /obj/item/essence_vial))
		return NONE

	var/obj/item/essence_vial/vial = tool
	if(!vial.contained_essence || vial.essence_amount <= 0)
		to_chat(user, span_warning("The vial is empty."))
		return ITEM_INTERACT_BLOCKING

	if(!selected_recipe)
		to_chat(user, span_warning("Select a recipe before pouring essences."))
		return ITEM_INTERACT_BLOCKING

	var/essence_type = vial.contained_essence.type
	var/essence_name = vial.contained_essence.name
	if(!(essence_type in selected_recipe.required_essences))
		to_chat(user, span_warning("[essence_name] is not used in [initial(selected_recipe.recipe_name)]."))
		return ITEM_INTERACT_BLOCKING

	var/room = essence_room_for(essence_type)
	if(room <= 0)
		to_chat(user, span_warning("The cauldron already has as much [essence_name] as the recipe needs."))
		return ITEM_INTERACT_BLOCKING

	if(essence_contents.len >= max_essence_types && !essence_contents[essence_type])
		to_chat(user, span_warning("The cauldron cannot hold any more essence types."))
		return ITEM_INTERACT_BLOCKING

	var/poured = min(vial.essence_amount, room)
	essence_contents[essence_type] = (essence_contents[essence_type] || 0) + poured
	vial.essence_amount -= poured
	if(vial.essence_amount <= 0)
		vial.contained_essence = null
		vial.essence_amount = 0
		to_chat(user, span_info("You pour the last of the [essence_name] into the cauldron."))
	else
		to_chat(user, span_info("You pour [poured] [essence_name] into the cauldron. The vial still holds [vial.essence_amount]."))
	vial.update_appearance(UPDATE_OVERLAYS)

	lastuser = WEAKREF(user)
	if(brewing >= brew_time)
		brewing = 0
	update_appearance(UPDATE_OVERLAYS)
	playsound(src, "bubbles", 100, TRUE)
	if(essence_node?.network)
		essence_node.network.invalidate_cache()
	return ITEM_INTERACT_SUCCESS

/obj/machinery/light/fueled/cauldron/proc/handle_water_pour(mob/living/user, obj/item/tool)
	if(!tool?.reagents || !reagents)
		return NONE

	var/water_in_tool = tool.reagents.get_reagent_amount(/datum/reagent/water)
	if(water_in_tool <= 0)
		return NONE

	sync_water_cap()
	var/room = water_room()
	if(room <= 0)
		if(selected_recipe)
			to_chat(user, span_warning("[src] already has the [water_needed()] water this brew needs."))
		else
			to_chat(user, span_warning("[src] cannot hold any more liquid."))
		return ITEM_INTERACT_BLOCKING

	var/transferred = tool.reagents.trans_id_to(src, /datum/reagent/water, room)
	if(transferred <= 0)
		return ITEM_INTERACT_BLOCKING

	to_chat(user, span_info("You pour [transferred] water into [src]. ([current_water()]/[selected_recipe ? water_needed() : 100])"))
	playsound(src, "bubbles", 50, TRUE)
	update_appearance(UPDATE_OVERLAYS)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/light/fueled/cauldron/item_interaction_secondary(mob/living/user, obj/item/tool, list/modifiers)
	if(user.cmode || !istype(tool, /obj/item/essence_connector))
		return NONE

	if(QDELETED(essence_node))
		to_chat(user, span_warning("The cauldron has no essence conduit."))
		return ITEM_INTERACT_BLOCKING

	essence_node.show_link_menu(user)
	return ITEM_INTERACT_SUCCESS

/obj/machinery/light/fueled/cauldron/proc/show_recipe_menu(mob/user)
	var/list/recipes = list()
	recipes["Clear Recipe"] = null

	for(var/recipe_path in subtypesof(/datum/alch_cauldron_recipe))
		var/datum/alch_cauldron_recipe/recipe = new recipe_path
		recipes[initial(recipe.recipe_name)] = recipe_path
		qdel(recipe)

	var/choice = input(user, "Select a recipe for the cauldron", "Cauldron Recipe") as null|anything in recipes
	if(!choice || !user.default_can_use_topic(src))
		return

	var/recipe_path = recipes[choice]
	if(!recipe_path)
		selected_recipe = null
		brew_units = 0
		to_chat(user, span_info("Recipe cleared."))
		on_recipe_changed()
		return

	var/units = tgui_input_number(user, "How many units of [choice] do you want to brew? A full pot is 100.", "Brew Amount", 100, 100, 1)
	if(!units || !user.default_can_use_topic(src))
		return
	units = clamp(round(units), 1, 100)

	selected_recipe = new recipe_path
	scale_recipe_to_units(selected_recipe, units)
	on_recipe_changed()
	sync_water_cap()
	to_chat(user, span_info("Recipe set to [initial(selected_recipe.recipe_name)] ([brew_units] units)."))
	to_chat(user, span_notice("It will need [water_needed()] water and the listed essences. Extra liquid and essence cannot be added."))

/obj/machinery/light/fueled/cauldron/proc/scale_recipe_to_units(datum/alch_cauldron_recipe/recipe, units)
	brew_units = units
	if(!recipe)
		return
	for(var/essence_type in recipe.required_essences)
		var/base_amount = recipe.required_essences[essence_type]
		recipe.required_essences[essence_type] = max(1, CEILING((base_amount * units) / 100, 1))
	for(var/reagent in recipe.output_reagents)
		recipe.output_reagents[reagent] = units

/obj/machinery/light/fueled/cauldron/proc/clear_recipe()
	selected_recipe = null
	brew_units = 0
	on_recipe_changed()
	sync_water_cap()

/obj/machinery/light/fueled/cauldron/proc/on_recipe_changed()
	brewing = 0
	// Push everything from essence_contents back into the node
	// so the network can redistribute what the new recipe doesn't need
	if(essence_node && !QDELETED(essence_node))
		return_essences_to_node()
		if(essence_node.network)
			essence_node.network.invalidate_cache()
		essence_node.push_surplus_to_linked(essence_node.storage)
	sync_water_cap()
	update_appearance(UPDATE_OVERLAYS)

/obj/machinery/light/fueled/cauldron/proc/return_essences_to_node()
	if(!essence_node || QDELETED(essence_node))
		essence_contents = list()
		return
	for(var/essence_type in essence_contents.Copy())
		var/amount = essence_contents[essence_type]
		if(!amount)
			essence_contents -= essence_type
			continue
		var/moved = essence_node.storage.add(essence_type, amount)
		essence_contents[essence_type] -= moved
		if(essence_contents[essence_type] <= 0)
			essence_contents -= essence_type

/obj/machinery/light/fueled/cauldron/proc/extra_essence_types()
	. = list()
	if(!selected_recipe)
		return
	for(var/essence_type in essence_contents)
		if(!(essence_type in selected_recipe.required_essences))
			. += essence_type

/obj/machinery/light/fueled/cauldron/update_overlays()
	. = ..()
	if(!reagents?.total_volume && !LAZYLEN(essence_contents))
		return
	var/mutable_appearance/filling
	if(on && brewing > 0)
		filling = mutable_appearance('icons/roguetown/misc/alchemy.dmi', "cauldron_boiling")
	else if(reagents?.total_volume || LAZYLEN(essence_contents))
		filling = mutable_appearance('icons/roguetown/misc/alchemy.dmi', "cauldron_full")
	if(!filling)
		return
	filling.color = calculate_mixture_color()
	. += filling

/obj/machinery/light/fueled/cauldron/burn_out()
	brewing = 0
	update_appearance(UPDATE_OVERLAYS)
	return ..()

/obj/machinery/light/fueled/cauldron/proc/desired_batch_count()
	if(!selected_recipe)
		return 0
	return 1

/obj/machinery/light/fueled/cauldron/proc/water_needed()
	if(!selected_recipe || brew_units <= 0)
		return 0
	return brew_units

/obj/machinery/light/fueled/cauldron/proc/essence_room_for(essence_type)
	if(!selected_recipe || !(essence_type in selected_recipe.required_essences))
		return 0
	var/needed = selected_recipe.required_essences[essence_type] * desired_batch_count()
	var/already = (essence_contents[essence_type] || 0)
	if(essence_node && !QDELETED(essence_node))
		already += essence_node.storage.get(essence_type)
	return max(0, needed - already)

/obj/machinery/light/fueled/cauldron/proc/drain_from_node()
	if(!essence_node || QDELETED(essence_node))
		return
	if(!selected_recipe)
		return

	var/datum/essence_storage/node_storage = essence_node.storage
	if(!node_storage || !node_storage.contents.len)
		return

	var/max_batches = calculate_max_possible_batches(selected_recipe)
	var/drained_any = FALSE

	for(var/essence_type in node_storage.contents.Copy())
		if(!(essence_type in selected_recipe.required_essences))
			continue
		var/available = node_storage.get(essence_type)
		if(!available)
			continue
		if(essence_contents.len >= max_essence_types && !essence_contents[essence_type])
			continue

		var/needed_total = selected_recipe.required_essences[essence_type] * max_batches
		var/already_have = essence_contents[essence_type] || 0
		var/to_drain = min(available, max(0, needed_total - already_have))
		if(to_drain <= 0)
			continue

		var/drained = node_storage.remove(essence_type, to_drain)
		if(drained <= 0)
			continue
		essence_contents[essence_type] = already_have + drained
		drained_any = TRUE

	if(node_storage.contents.len)
		essence_node.push_surplus_to_linked(node_storage)

	if(drained_any)
		if(essence_node.network)
			essence_node.network.invalidate_cache()
		update_appearance(UPDATE_OVERLAYS)

/obj/machinery/light/fueled/cauldron/proc/calculate_max_possible_batches(datum/alch_cauldron_recipe/recipe)
	if(!recipe || !recipe.required_essences.len)
		return 0
	return desired_batch_count()

/obj/machinery/light/fueled/cauldron/proc/has_required_essences()
	if(!selected_recipe)
		return FALSE
	for(var/essence_type in selected_recipe.required_essences)
		var/required = selected_recipe.required_essences[essence_type]
		var/current = essence_contents[essence_type] || 0
		if(current < required)
			return FALSE
	return TRUE

/obj/machinery/light/fueled/cauldron/proc/has_water()
	var/needed = water_needed()
	if(needed <= 0)
		return FALSE
	return reagents?.has_reagent(/datum/reagent/water, needed)

/obj/machinery/light/fueled/cauldron/proc/current_water()
	return reagents?.get_reagent_amount(/datum/reagent/water) || 0

/obj/machinery/light/fueled/cauldron/proc/water_room()
	if(selected_recipe)
		return max(0, water_needed() - current_water())
	if(!reagents)
		return 0
	return max(0, reagents.maximum_volume - reagents.total_volume)

/obj/machinery/light/fueled/cauldron/proc/sync_water_cap()
	if(!reagents)
		create_reagents(100, DRAINABLE | AMOUNT_VISIBLE | REFILLABLE)
	reagents.maximum_volume = 100
	var/allowed_water = selected_recipe ? water_needed() : 100
	var/extra_water = current_water() - allowed_water
	if(extra_water > 0)
		reagents.remove_reagent(/datum/reagent/water, extra_water)

/obj/machinery/light/fueled/cauldron/proc/consume_brew_water()
	if(!reagents)
		return
	var/water_in = current_water()
	if(water_in > 0)
		reagents.remove_reagent(/datum/reagent/water, water_in)

/obj/machinery/light/fueled/cauldron/process()
	. = ..()

	if(essence_node && !QDELETED(essence_node))
		essence_node.pull_from_linked(essence_node.storage)
		drain_from_node()

	if(!on)
		if(brewing > 0)
			brewing = 0
			update_appearance(UPDATE_OVERLAYS)
		return

	if(!length(essence_contents) || !has_water())
		if(brewing > 0)
			brewing = 0
			update_appearance(UPDATE_OVERLAYS)
		return

	// Heat as soon as there is water + any essence so the pot actually
	// looks and sounds like it is boiling. Completion still requires
	// the selected recipe's amounts.
	if(brewing < brew_time)
		var/was_idle = (brewing == 0)
		brewing++
		if(was_idle && essence_node?.network)
			essence_node.network.invalidate_cache()
		update_appearance(UPDATE_OVERLAYS)
		if(prob(10))
			playsound(src, "bubbles", 100, FALSE)
		return

	finish_brew()

/obj/machinery/light/fueled/cauldron/proc/finish_brew()
	var/list/recipe_result = find_matching_recipe_with_batches()
	if(!recipe_result)
		brewing = 0
		if(selected_recipe && !has_required_essences())
			// Still filling. Keep the essences, just wait for more heat.
			update_appearance(UPDATE_OVERLAYS)
			return
		visible_message(span_info("The essences in [src] fail to combine properly..."))
		playsound(src, 'sound/misc/smelter_fin.ogg', 30, FALSE)
		if(essence_node?.network)
			essence_node.network.invalidate_cache()
		update_appearance(UPDATE_OVERLAYS)
		return

	var/datum/alch_cauldron_recipe/found_recipe = recipe_result["recipe"]
	var/batch_count = recipe_result["batches"]

	consume_recipe_essences(found_recipe, batch_count)
	return_essences_to_node()

	consume_brew_water()

	if(found_recipe.output_reagents.len && reagents)
		reagents.maximum_volume = 100
		reagents.add_reagent_list(found_recipe.output_reagents.Copy())

	if(length(found_recipe.output_items))
		for(var/itempath in found_recipe.output_items)
			for(var/i = 1 to batch_count)
				new itempath(get_turf(src))

	if(batch_count > 1)
		visible_message(span_info("The cauldron finishes boiling [batch_count] batches with a strong [found_recipe.smells_like] smell."))
	else
		visible_message(span_info("The cauldron finishes boiling with a faint [found_recipe.smells_like] smell."))

	if(lastuser)
		var/mob/living/L = lastuser.resolve()
		if(L)
			record_featured_stat(FEATURED_STATS_ALCHEMISTS, L)
			record_round_statistic(STATS_POTIONS_BREWED, batch_count)
			var/boon = L.get_learning_boon(/datum/attribute/skill/craft/alchemy)
			var/amt2raise = GET_MOB_ATTRIBUTE_VALUE(L, STAT_INTELLIGENCE) * 2 * batch_count
			L.adjust_experience(/datum/attribute/skill/craft/alchemy, amt2raise * boon, FALSE)

	playsound(src, "bubbles", 100, TRUE)
	playsound(src, 'sound/misc/smelter_fin.ogg', 30, FALSE)

	brewing = 0
	update_appearance(UPDATE_OVERLAYS)
	essence_node?.network?.invalidate_cache()

/obj/machinery/light/fueled/cauldron/proc/consume_recipe_essences(datum/alch_cauldron_recipe/recipe, batch_count)
	if(!recipe)
		return
	for(var/essence_type in recipe.required_essences)
		var/used = recipe.required_essences[essence_type] * batch_count
		if(!essence_contents[essence_type])
			continue
		essence_contents[essence_type] -= used
		if(essence_contents[essence_type] <= 0)
			essence_contents -= essence_type

/obj/machinery/light/fueled/cauldron/proc/calculate_mixture_color()
	if(!length(essence_contents))
		return "#4A90E2"

	var/total_weight = 0
	var/r = 0
	var/g = 0
	var/b = 0

	for(var/essence_type in essence_contents)
		var/datum/thaumaturgical_essence/essence = new essence_type
		var/amount = essence_contents[essence_type]
		var/weight = amount * (essence.tier + 1)

		total_weight += weight
		var/color_string = essence.color
		if(length(color_string) >= 7)
			r += hex2num(copytext(color_string, 2, 4)) * weight
			g += hex2num(copytext(color_string, 4, 6)) * weight
			b += hex2num(copytext(color_string, 6, 8)) * weight
		qdel(essence)

	if(total_weight <= 0)
		return "#4A90E2"

	return rgb(FLOOR(r / total_weight, 1), FLOOR(g / total_weight, 1), FLOOR(b / total_weight, 1))

/obj/machinery/light/fueled/cauldron/proc/find_matching_recipe_with_batches()
	if(selected_recipe)
		var/batch_count = calculate_max_batches(selected_recipe)
		if(batch_count > 0)
			return list("recipe" = selected_recipe, "batches" = batch_count)
		return null

	for(var/recipe_path in subtypesof(/datum/alch_cauldron_recipe))
		var/datum/alch_cauldron_recipe/recipe = new recipe_path
		var/batch_count = calculate_max_batches(recipe)
		if(batch_count > 0)
			return list("recipe" = recipe, "batches" = batch_count)
		qdel(recipe)
	return null

/obj/machinery/light/fueled/cauldron/proc/calculate_max_batches(datum/alch_cauldron_recipe/recipe)
	if(!recipe || !recipe.required_essences.len)
		return 0
	if(!recipe.matches_essences(essence_contents))
		return 0

	var/min_batches = 999
	for(var/essence_type in recipe.required_essences)
		var/required_amount = recipe.required_essences[essence_type]
		if(required_amount <= 0)
			continue
		var/available_amount = essence_contents[essence_type]
		if(!available_amount || available_amount < required_amount)
			return 0
		min_batches = min(min_batches, FLOOR(available_amount / required_amount, 1))

	if(min_batches == 999)
		return 0
	if(selected_recipe)
		min_batches = min(min_batches, desired_batch_count())
	return min_batches
