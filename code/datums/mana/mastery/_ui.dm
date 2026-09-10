/datum/spellbook
	var/mob/living/owner
	var/datum/spell_mastery/mastery
	///can we unlearn form and technique spells, kept within the form school though.
	var/unlearn_mode = FALSE
	/// If TRUE, this instance auto-closes the moment the owner stops sleeping
	var/require_sleeping = FALSE

/datum/spellbook/New(mob/living/owner, datum/spell_mastery/_mastery)
	src.owner = owner
	if(owner?.mana_pool)
		mastery = owner.mana_pool.get_mastery()
	if(_mastery)
		mastery = _mastery

/datum/spellbook/Destroy(force)
	owner = null
	mastery = null
	return ..()

/datum/spellbook/ui_state(mob/user)
	return GLOB.always_state

/datum/spellbook/ui_status(mob/user, datum/ui_state/state)
	if(require_sleeping && !is_owner_sleeping())
		return UI_CLOSE
	return ..()

/datum/spellbook/proc/is_owner_sleeping()
	if(!owner)
		return FALSE
	if(HAS_TRAIT(owner, TRAIT_VAMP_DREAMS))
		return TRUE
	return owner.IsSleeping()

/datum/spellbook/proc/open_unlearn(mob/user)
	unlearn_mode = TRUE
	ui_interact(user)

/datum/spellbook/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SpellBook")
		ui.open()

/datum/spellbook/ui_static_data(mob/user)
	var/list/data = list()
	data["techniques"] = GLOB.all_techniques
	data["forms"] = GLOB.all_forms
	return data

/datum/spellbook/ui_data(mob/user)
	var/list/data = list()
	if(!mastery)
		return data

	data["unspentFormPoints"] = mastery.unspent_form_points
	data["unspentTechniquePoints"] = mastery.unspent_technique_points
	data["unlearnMode"] = unlearn_mode
	data["hasSavedKit"] = !!length(preset_names(get_theme_presets()))

	var/list/form_modifiers = get_modifiers_by_form()
	var/list/technique_modifiers = get_modifiers_by_technique()

	var/list/technique_data = list()
	for(var/technique in GLOB.all_techniques)
		technique_data += list(list(
			"id" = technique,
			"name" = technique,
			"level" = mastery.get_technique_level(technique),
			"rank" = mastery.get_technique_rank_name(technique),
			"modifiers" = technique_modifiers[technique],
		))
	data["techniqueLevels"] = technique_data

	var/list/form_data = list()
	for(var/form in GLOB.all_forms)
		form_data += list(list(
			"id" = form,
			"name" = form,
			"level" = mastery.get_form_level(form),
			"rank" = mastery.get_form_rank_name(form),
			"modifiers" = form_modifiers[form],
		))
	data["formLevels"] = form_data

	var/list/spell_data = list()
	for(var/datum/action/cooldown/spell/spell_path as anything in subtypesof(/datum/action/cooldown/spell))
		if(IS_ABSTRACT(spell_path))
			continue
		if(!initial(spell_path.learnable))
			continue
		var/technique = initial(spell_path:required_technique)
		var/form = initial(spell_path:required_form)
		if(!form)
			continue
		var/is_unlocked = (spell_path in mastery.unlocked_spells)
		spell_data += list(list(
			"path" = "[spell_path]",
			"name" = initial(spell_path.name),
			"desc" = initial(spell_path.desc),
			"technique" = technique,
			"form" = form,
			"level" = initial(spell_path.required_level),
			"formCost" = form ? 1 : 0,
			"techniqueCost" = technique ? 1 : 0,
			"unlocked" = is_unlocked,
			"canLearn" = mastery.can_learn_spell(spell_path),
			"canUnlearn" = is_unlocked,
			"icon" = "[initial(spell_path.button_icon)]",
			"iconState" = initial(spell_path.button_icon_state),
		))
	data["spells"] = spell_data
	return data

/datum/spellbook/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	if(!mastery)
		return

	switch(action)
		if("invest_technique")
			var/technique = params["technique"]
			if(!(technique in GLOB.all_techniques))
				return
			. = mastery.invest_technique(technique, 1)

		if("invest_form")
			var/form = params["form"]
			if(!(form in GLOB.all_forms))
				return
			. = mastery.invest_form(form, 1)

		if("learn_spell")
			. = mastery.try_learn_spell(text2path(params["path"]))

		if("unlearn_spell")
			. = mastery.try_unlearn_spell(text2path(params["path"]))

		if("save_kit")
			spawn(0)
				save_spell_kit()
			. = TRUE

		if("load_kit")
			spawn(0)
				load_spell_kit()
			. = TRUE

		if("delete_kit")
			spawn(0)
				delete_spell_kit()
			. = TRUE

/datum/spellbook/proc/get_modifiers_by_form()
	return get_modifiers_by_key("form")

/datum/spellbook/proc/get_modifiers_by_technique()
	return get_modifiers_by_key("technique")

/datum/spellbook/proc/get_modifiers_by_key(key)
	if(!mastery?.parent)
		return list()
	var/list/modifiers = list()
	SEND_SIGNAL(mastery.parent, COMSIG_SPELL_REQUEST_MODIFIERS, modifiers)

	var/list/by_key = list()
	for(var/list/entry in modifiers)
		var/id = entry[key]
		if(!id)
			continue
		if(!by_key[id])
			by_key[id] = list(SPELLMOD_COST = 1, SPELLMOD_CASTSPEED = 1, SPELLMOD_MAGNITUDE = 0)
		by_key[id][SPELLMOD_COST] *= entry[SPELLMOD_COST]
		by_key[id][SPELLMOD_CASTSPEED] *= entry[SPELLMOD_CASTSPEED]
		by_key[id][SPELLMOD_MAGNITUDE] += entry[SPELLMOD_MAGNITUDE]
	return by_key

/datum/spellbook/proc/get_user()
	if(isliving(usr))
		return usr
	if(isliving(owner))
		return owner
	var/obj/item/spellbook/book = mastery.parent
	if(!istype(book))
		return null
	if(isliving(book.owner))
		return book.owner
	if(isliving(book.loc))
		return book.loc
	return null

/datum/spellbook/proc/get_prefs()
	var/mob/user = get_user()
	return user.client.prefs

/datum/spellbook/proc/theme_key()
	var/obj/item/spellbook/book = mastery?.parent
	if(istype(book) && book.themed_form)
		return book.themed_form
	return "innate"

/datum/spellbook/proc/get_saved_kits()
	var/datum/preferences/prefs = get_prefs()
	if(!prefs)
		return list()
	var/list/all_kits = prefs.read_preference(/datum/preference/list_type/saved_spell_kits)
	return islist(all_kits) ? all_kits : list()

/datum/spellbook/proc/get_theme_presets()
	var/list/theme_presets = get_saved_kits()[theme_key()]
	if(!islist(theme_presets))
		return list()
	return theme_presets

/datum/spellbook/proc/preset_names(list/theme_presets)
	var/list/names = list()
	for(var/name in theme_presets)
		if(copytext("[name]", 1, 2) == "_")
			continue
		names += name
	return names

/datum/spellbook/proc/write_kits(list/all_kits)
	var/datum/preferences/prefs = get_prefs()
	if(!prefs)
		return FALSE
	if(!prefs.write_preference(/datum/preference/list_type/saved_spell_kits, all_kits))
		return FALSE
	prefs.save_character()
	return TRUE

/datum/spellbook/proc/save_spell_kit()
	var/mob/user = get_user()
	var/datum/preferences/prefs = user.client.prefs
	if(!prefs || !mastery)
		to_chat(user, span_warning("I cannot save this preset."))
		return FALSE

	var/list/theme_presets = get_theme_presets()
	var/list/names = preset_names(theme_presets)

	var/preset_name = input(user, "Name this preset.", "Save Preset") as text | null
	if(!preset_name)
		return FALSE
	preset_name = trim(copytext(preset_name, 1, 33))
	if(!length(preset_name) || copytext(preset_name, 1, 2) == "_")
		to_chat(user, span_warning("That is not a fit name."))
		return FALSE

	if(preset_name in names)
		if(alert(user, "Overwrite '[preset_name]'?", "Save Preset", "Yes", "No") != "Yes")
			return FALSE
	else if(length(names) >= SPELL_KIT_MAX_PRESETS)
		to_chat(user, span_warning("I can only keep [SPELL_KIT_MAX_PRESETS] presets for this form. Delete one first."))
		return FALSE

	var/list/saved_spells = list()
	for(var/spell_path in mastery.unlocked_spells)
		saved_spells += "[spell_path]"

	var/list/all_kits = get_saved_kits()
	theme_presets[preset_name] = list(
		"form_levels" = mastery.form_levels.Copy(),
		"technique_levels" = mastery.technique_levels.Copy(),
		"unlocked_spells" = saved_spells,
	)
	all_kits[theme_key()] = theme_presets

	if(!write_kits(all_kits))
		to_chat(user, span_warning("The preset did not work."))
		return FALSE

	to_chat(user, span_notice("I commit the '[preset_name]' preset to memory."))
	return TRUE

/datum/spellbook/proc/load_spell_kit()
	var/mob/user = get_user()
	if(!mastery)
		to_chat(user, span_warning("I cannot recall this preset."))
		return FALSE

	var/list/theme_presets = get_theme_presets()
	var/list/names = preset_names(theme_presets)
	if(!length(names))
		to_chat(user, span_warning("I have no remembered preset for this form."))
		return FALSE

	var/preset_name = input(user, "Which preset?", "Load Preset") as null | anything in names
	if(!preset_name)
		return FALSE

	if(alert(user, "Replace this tome's preset with '[preset_name]'?", "Load Preset", "Yes", "No") != "Yes")
		return FALSE

	if(!apply_preset(theme_presets[preset_name]))
		return FALSE

	return TRUE

/datum/spellbook/proc/delete_spell_kit()
	var/mob/user = get_user()
	var/list/theme_presets = get_theme_presets()
	var/list/names = preset_names(theme_presets)
	if(!length(names))
		to_chat(user, span_warning("I have no preset for this form."))
		return FALSE

	var/preset_name = input(user, "Forget which preset?", "Delete Preset") as null | anything in names
	if(!preset_name)
		return FALSE

	if(alert(user, "Forget '[preset_name]'?", "Delete Preset", "Yes", "No") != "Yes")
		return FALSE

	theme_presets -= preset_name

	var/list/all_kits = get_saved_kits()
	all_kits[theme_key()] = theme_presets
	if(!write_kits(all_kits))
		return FALSE

	to_chat(user, span_notice("I delete the '[preset_name]' preset."))
	return TRUE

/datum/spellbook/proc/apply_preset(list/kit)
	if(!islist(kit) || !mastery)
		return FALSE

	for(var/spell_path in mastery.unlocked_spells.Copy())
		mastery.try_unlearn_spell(spell_path)

	var/list/saved_forms = kit["form_levels"]
	if(islist(saved_forms))
		for(var/form in saved_forms)
			var/want = saved_forms[form]
			if(!isnum(want))
				continue
			while(mastery.get_form_level(form) < want)
				if(!mastery.invest_form(form, 1))
					break

	var/list/saved_techniques = kit["technique_levels"]
	if(islist(saved_techniques))
		for(var/technique in saved_techniques)
			var/want = saved_techniques[technique]
			if(!isnum(want))
				continue
			while(mastery.get_technique_level(technique) < want)
				if(!mastery.invest_technique(technique, 1))
					break

	var/wanted_spells = 0
	var/learned_spells = 0
	var/list/saved_spells = kit["unlocked_spells"]
	if(islist(saved_spells))
		for(var/spell_path in saved_spells)
			if(istext(spell_path))
				spell_path = text2path(spell_path)
			if(!ispath(spell_path, /datum/action/cooldown/spell))
				continue
			wanted_spells++
			if(mastery.try_learn_spell(spell_path))
				learned_spells++

	mastery.recalculate_unspent_points()

	var/mob/user = get_user()
	if(wanted_spells && learned_spells < wanted_spells)
		to_chat(user, span_warning("I recall [learned_spells] of [wanted_spells] spells. This tome lacks the rest."))
	else
		to_chat(user, span_notice("I recall that preset."))
	return TRUE

/mob/living/proc/open_spellbook()
	set name = "Open Innate Spells"
	set category = "RoleUnique.Magic"

	var/datum/spellbook/book = new(src)
	book.ui_interact(src)
