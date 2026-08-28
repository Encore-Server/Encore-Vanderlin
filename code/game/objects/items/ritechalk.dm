/obj/item/ritechalk
	name = "Ritual Chalk"
	icon_state = "chalk"
	desc = "Simple white chalk. A useful tool for rites."
	icon = 'icons/roguetown/misc/rituals.dmi'
	w_class = WEIGHT_CLASS_TINY
	associated_skill = /datum/attribute/skill/magic/ritual

/obj/item/ritechalk/attack_self(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know what I'm doing with this..."))
		return

	var/choose_rune = input(user, "Which rune shall I inscribe?", src) as null|anything in GLOB.all_rituals
	if(!choose_rune)
		return
	var/list/rune_data = GLOB.all_rituals[choose_rune]
	var/rune_path = rune_data["path"]
	var/rune_level = rune_data["level"]
	var/user_level = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	if(rune_level > user_level)
		to_chat(user, span_warning("I don't have the skill to inscribe \the [choose_rune]"))
		return

	var/turf/step_turf = get_step(get_turf(user), user.dir)
	if(!step_turf)
		to_chat(user, span_warning("I can't place \the [src] on \the [step_turf]"))
		return
	if(locate(/obj/structure/ritualcircle) in step_turf)
		to_chat(user, span_warning("There is already a rune inscribed there!"))
		return

	to_chat(user, span_cultsmall("I begin inscribing \the [choose_rune]..."))
	if(!do_after(user, 3 SECONDS, src))
		return

	playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
	new rune_path(step_turf)
