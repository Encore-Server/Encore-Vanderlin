/datum/circle_rite/lesser_wolf
	name = "Rite of the Lesser Wolf"
	tradition = /datum/ritual_tradition/general
	skill_level = 2
	circle_path = /obj/structure/ritualcircle/dendor
	chants = list(
		"Beast brothers, answer my call!",
		"All of you, strong, tough, or small!",
	)

/datum/circle_rite/lesser_wolf/perform(mob/living/user, obj/structure/ritualcircle/circle)
	circle.loc.visible_message(span_warning("[user] snaps their head upward, they let out a howl!"))
	playsound(circle.loc, 'sound/vo/mobs/wwolf/howl (2).ogg', 100, FALSE, -1)
	for(var/mob/living/carbon/human/target in view(1, circle.loc))
		target.apply_status_effect(/datum/status_effect/buff/lesserwolf)
	return TRUE
