/datum/circle_rite/undermaiden_bargain
	name = "Undermaiden's Bargain"
	tradition = /datum/ritual_tradition/bog_witch
	circle_path = /obj/structure/ritualcircle/death
	chants = list(
		"Placeholder chant!",
		"Placeholder chant!",
		"Placeholder chant!",
	)

/datum/circle_rite/undermaiden_bargain/perform(mob/living/user, obj/structure/ritualcircle/circle)
	to_chat(user, span_cultsmall("My devotion to the dark has allowed me to strike a bargain for these souls, but who will pay the price?"))
	playsound(circle.loc, 'sound/misc/deadbell.ogg', 100, FALSE, -1)
	circle.loc.visible_message(span_warning("The bell tolls, but not for ye!"))
	for(var/mob/living/carbon/human/target in view(7, circle.loc))
		target.apply_status_effect(/datum/status_effect/buff/undermaidenbargain)
	return TRUE
