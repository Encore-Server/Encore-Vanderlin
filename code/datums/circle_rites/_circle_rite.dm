GLOBAL_LIST_INIT(circle_rites, init_circle_rites())

/proc/init_circle_rites()
	var/list/rites = list()
	for(var/datum/circle_rite/path as anything in subtypesof(/datum/circle_rite))
		if(IS_ABSTRACT(path))
			continue
		rites[path] = new path
	return rites

/proc/rituals_for_tradition(tradition_path)
	var/list/out = list()
	for(var/path in GLOB.circle_rites)
		var/datum/circle_rite/R = GLOB.circle_rites[path]
		if(R.tradition == tradition_path)
			out[R.name] = R
	return out

/datum/circle_rite
	abstract_type = /datum/circle_rite
	var/name
	var/desc
	var/datum/ritual_tradition/tradition = /datum/ritual_tradition/general
	var/circle_path = /obj/structure/ritualcircle
	var/list/chants = list()

/datum/circle_rite/proc/can_inscribe(mob/living/user)
	return HAS_TRAIT(user, TRAIT_RITUALIST)

/datum/circle_rite/proc/can_invoke(mob/living/user, obj/structure/ritualcircle/circle)
	return can_inscribe(user)

/datum/circle_rite/proc/perform(mob/living/user, obj/structure/ritualcircle/circle)
	return TRUE
