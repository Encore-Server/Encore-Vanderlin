/proc/rituals_for_tradition(tradition_path)
	var/list/out = list()
	for(var/path in GLOB.ritual_datums)
		var/datum/circle_rite/R = GLOB.ritual_datums[path]
		if(R.tradition == tradition_path)
			out[R.name] = R
	return out

/datum/circle_rite
	abstract_type = /datum/circle_rite
	var/name
	var/desc
	var/datum/ritual_tradition/tradition = /datum/ritual_tradition/general
	var/skill_level = 1
	var/circle_path = /obj/structure/ritualcircle
	var/list/chants = list()

/datum/circle_rite/proc/can_inscribe(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		return FALSE
	var/user_level = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	return user_level >= skill_level

/datum/circle_rite/proc/can_invoke(mob/living/user, obj/structure/ritualcircle/circle)
	return can_inscribe(user)

/datum/circle_rite/proc/perform(mob/living/user, obj/structure/ritualcircle/circle)
	return TRUE
