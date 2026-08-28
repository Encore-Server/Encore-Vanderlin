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
	var/rune_level = GLOB.all_rituals[choose_rune]["level"]
	var/user_level = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	if(rune_level > user_level)
		to_chat(user, span_warning("I don't have the skill to inscribe /the [choose_rune]"))
		return

	var/turf/step_turf = get_step(get_turf(user), user.dir)

	switch(choose_rune)
		if(RUNE_SUN)
			to_chat(user,span_cultsmall("I begin inscribing the rune of cold Radiance...light will guide them."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/astrata(step_turf)
		if(RUNE_MOON)
			to_chat(user, span_cultsmall("I begin inscribing the rune of bitter Wisdom"))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/noc(step_turf)
		if(RUNE_BEAST)
			to_chat(user,span_cultsmall("I begin inscribing the rune of feral Madness...a way to transform others into beasts."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/dendor(step_turf)
		if("Rune of Death")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Embrace...I will keep them from death's door."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/death(step_turf)
		if("Rune of Plague")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Plague...rot brings cleansing."))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/pestra(step_turf)
		if("Rune of Love")
			to_chat(user,span_cultsmall("I begin inscribing the rune of Her Love...I will change those who will not change themselves"))
			if(do_after(user, 30, src))
				playsound(src, 'sound/foley/scribble.ogg', 40, TRUE)
				new /obj/structure/ritualcircle/eora(step_turf)
