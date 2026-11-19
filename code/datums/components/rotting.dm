/datum/component/rot
	var/amount = 0
	var/rot_amount_per_process = 10 //1 second
	var/last_process = 0
	var/datum/looping_sound/fliesloop/soundloop

/datum/component/rot/Initialize(new_amount)
	..()
	if(!isatom(parent))
		return COMPONENT_INCOMPATIBLE

	if(new_amount)
		amount = new_amount

	soundloop = new(parent, FALSE)

	START_PROCESSING(SSroguerot, src)

/datum/component/rot/Destroy()
	if(soundloop)
		QDEL_NULL(soundloop)
	return ..()

/datum/component/rot/process()
	if(HAS_TRAIT(parent, TRAIT_STASIS) || HAS_TRAIT(parent, TRAIT_NO_ROT)) // No rot
		return
	var/amt2add = rot_amount_per_process
	if(last_process)
		amt2add = ((world.time - last_process)/10) * amt2add
	last_process = world.time
	amount += amt2add

/datum/component/rot/corpse/Initialize()
	if(!iscarbon(parent))
		return COMPONENT_INCOMPATIBLE
	. = ..()

/datum/component/rot/corpse/process()
	if(HAS_TRAIT(parent, TRAIT_STASIS) || HAS_TRAIT(parent, TRAIT_NO_ROT)) // No rot
		return
	..()
	var/mob/living/carbon/C = parent
	var/is_zombie = IS_DEADITE(C)
	if(C.stat != DEAD && !is_zombie)
		qdel(src)
		return
	if(!(C.mob_biotypes & (MOB_ORGANIC|MOB_UNDEAD)))
		qdel(src)
		return

	if(!is_zombie && amount > 45 MINUTES && !is_in_roguetown(C))
		C.zombie_check()

	var/findonerotten = FALSE
	var/shouldupdate = FALSE
	for(var/obj/item/bodypart/B in C.bodyparts)
		if(!B.skeletonized && B.is_organic_limb())
			if(!HAS_TRAIT(B, TRAIT_ROTTEN))
				// if been a corpse for 40 minutes and limb is not rotted yet, force the bodyparts rotten
				if(amount > 40 MINUTES)
					B.kill_limb()
					findonerotten = TRUE
					shouldupdate = TRUE
					C.change_stat(STAT_CONSTITUTION, -8)
			else
				// if it's been over 90 minutes for players or 45 minutes for NPCs, any rotten bodyparts decay to bone
				if(amount > (C.mind ? 90 MINUTES : 45 MINUTES))
					if(!is_zombie)
						B.skeletonize()
						ADD_TRAIT(C, TRAIT_NOBLOOD, TRAIT_GENERIC)
						C.change_stat(STAT_CONSTITUTION, -99)
						shouldupdate = TRUE
				else
					findonerotten = TRUE
	if(findonerotten)
		// for first 16 minutes of a decaying corpse, if there are rotten bodyparts then make tile stinky and play rot sounds
		var/turf/open/T = C.loc
		if(istype(T) && amount < 16 MINUTES && !C.has_faction(FACTION_DECEIVERS))
			T.pollute_turf(/datum/pollutant/rot, 9)
			if(soundloop && soundloop.stopped && !is_zombie)
				soundloop.start()
		else
			if(soundloop && !soundloop.stopped)
				soundloop.stop()
	else
		if(soundloop && !soundloop.stopped)
			soundloop.stop()
	if(shouldupdate)
		if(findonerotten)
			if(ishuman(C))
				var/mob/living/carbon/human/H = C
				H.skin_tone = "878f79" //elf ears
			if(soundloop && soundloop.stopped && !is_zombie)
				soundloop.start()
		C.update_body()

/datum/component/rot/simple
	rot_amount_per_process = 5

/datum/component/rot/simple/process()
	..()
	if(HAS_TRAIT(parent, TRAIT_NO_ROT)) // No rot
		return
	var/mob/living/L = parent
	var/datum/component/rot/R = src
	if(L.stat != DEAD)
		qdel(R)
		return
	if(amount > 10 MINUTES)
		if(soundloop && soundloop.stopped)
			soundloop.start()
		var/turf/open/T = get_turf(L)
		if(istype(T)  && amount < 16 MINUTES && !L.has_faction(FACTION_DECEIVERS))
			T.pollute_turf(/datum/pollutant/rot, 9)
	if(amount > 20 MINUTES)
		qdel(R)
		return L.dust(drop_items=TRUE)

/datum/component/rot/gibs
	amount = 0.005

/datum/component/rot/stinky_person
	soundloop = null
	var/static/list/clean_moodlets = list(/datum/stress_event/clean, /datum/stress_event/clean_plus)

/datum/component/rot/stinky_person/process()
	..()
	var/mob/living/L = parent
	var/turf/open/T = L.loc
	if(istype(T))
		if(iscarbon(L))
			var/mob/living/carbon/stinky = L
			for(clean_moodlets in stinky.get_positive_stressors())
				return
		T.pollute_turf(/datum/pollutant/rot, 0.25)

/datum/looping_sound/fliesloop
	mid_sounds = list('sound/misc/fliesloop.ogg')
	mid_length = 60
	volume = 50
	extra_range = 0
