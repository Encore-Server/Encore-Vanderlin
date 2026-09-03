/obj/item/ritechalk
	name = "Ritual Chalk"
	icon_state = "chalk"
	desc = "Simple white chalk. A useful tool for rites."
	icon = 'icons/roguetown/misc/rituals.dmi'
	w_class = WEIGHT_CLASS_TINY
	associated_skill = /datum/attribute/skill/magic/ritual

/obj/item/ritechalk/proc/available_rites(tradition_path, mob/living/user)
	var/list/out = list()
	for(var/rite_name in rituals_for_tradition(tradition_path))
		var/datum/circle_rite/R = rituals_for_tradition(tradition_path)[rite_name]
		if(R.can_inscribe(user))
			out[R.name] = R
	return out

/obj/item/ritechalk/attack_self(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know what I'm doing with this..."))
		return

	var/list/traditions = list()
	for(var/datum/ritual_tradition/path as anything in subtypesof(/datum/ritual_tradition))
		if(IS_ABSTRACT(path))
			continue
		if(!length(available_rites(path, user)))
			continue
		var/datum/ritual_tradition/T = path
		traditions[T::name] = path

	if(!length(traditions))
		to_chat(user, span_warning("I know no rites I can inscribe."))
		return

	var/picked_trad_name = input(user, "Which tradition?", src) as null | anything in traditions
	if(!picked_trad_name)
		return

	var/list/available = available_rites(traditions[picked_trad_name], user)
	var/picked_rite_name = input(user, "Which rite?", picked_trad_name) as null | anything in available
	if(!picked_rite_name)
		return

	var/datum/circle_rite/rite = available[picked_rite_name]
	var/turf/step_turf = get_step(get_turf(user), user.dir)
	if(!step_turf)
		to_chat(user, span_warning("There is nowhere to inscribe that rune."))
		return
	if(locate(/obj/structure/ritualcircle) in step_turf)
		to_chat(user, span_warning("There is already a rune inscribed there!"))
		return

	to_chat(user, span_cultsmall("I begin inscribing [rite.name]..."))
	if(!do_after(user, 3 SECONDS, src))
		return

	playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
	new rite.circle_path(step_turf, rite)
