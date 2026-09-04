/datum/circle_rite/guiding_light
	name = "Guiding Light"
	tradition = /datum/ritual_tradition/clergy
	circle_path = /obj/structure/ritualcircle/astrata
	chants = list(
		"I beseech the she-form of the Twinned God!!",
		"To bring Order to a world of naught!!",
		"Place your gaze upon me, oh Radiant one!!",
	)

/datum/circle_rite/guiding_light/perform(mob/living/user, obj/structure/ritualcircle/circle)
	to_chat(user, span_danger("You feel the eye of the Sun turned upon you. Her warmth dances upon your cheek. You feel yourself warming up..."))
	circle.loc.visible_message(span_warning("[user]'s bursts to flames! Embraced by Her Warmth wholly!"))
	playsound(circle.loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
	user.adjust_fire_stacks(10)
	user.IgniteMob()
	user.flash_fullscreen("redflash3")
	user.emote("firescream")
	for(var/mob/living/carbon/human/target in view(7, circle.loc))
		target.apply_status_effect(/datum/status_effect/buff/guidinglight)
		to_chat(target, span_cultsmall("Astrata's light guides me forward, drawn to me by the Ritualist's pyre!"))
		playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
	return TRUE

/datum/circle_rite/moonlight_dance
	name = "Moonlight Dance"
	tradition = /datum/ritual_tradition/clergy
	circle_path = /obj/structure/ritualcircle/noc
	chants = list(
		"I beseech the he-form of the Twinned God!!",
		"To bring Wisdom to a world of naught!!",
		"Place your gaze upon me, oh wise one!!",
	)

/datum/circle_rite/moonlight_dance/perform(mob/living/user, obj/structure/ritualcircle/circle)
	to_chat(user, span_cultsmall("The waning half of the Twin-God carries but one eye. With some effort, it can be drawn upon supplicants."))
	playsound(circle.loc, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
	for(var/mob/living/carbon/human/target in view(7, circle.loc))
		target.apply_status_effect(/datum/status_effect/buff/moonlightdance)
	return TRUE

/datum/circle_rite/flylords_triage
	name = "Flylord's Triage"
	tradition = /datum/ritual_tradition/clergy
	circle_path = /obj/structure/ritualcircle/pestra
	chants = list(
		"O Queen of Blight, whose breath is plague,",
		"Whose kiss is rot, whose will is vague.",
		"Let blood run thin and pulses cease,",
		"And birth through me thy swarm's release",
	)

/datum/circle_rite/flylords_triage/perform(mob/living/user, obj/structure/ritualcircle/circle)
	to_chat(user, span_cultsmall("My devotion to the Plague Queen allowing, her servants crawl up from my throat. Come now, father fly..."))
	circle.loc.visible_message(span_warning("[user] gasps — and a torrent of flies erupts from their throat, wings screaming like bells of pestilence!"))
	playsound(circle.loc, 'sound/misc/fliesloop.ogg', 100, FALSE, -1)
	for(var/mob/living/carbon/human/target in view(0, circle.loc))
		to_chat(target, span_userdanger("You feel them crawling into your wounds and pores. Their horrific hum rings through your ears as they do their work!"))
		target.flash_fullscreen("redflash3")
		target.emote("agony")
		target.Stun(200)
		target.Knockdown(200)
		to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
		target.apply_status_effect(/datum/status_effect/buff/flylordstriage)
	return TRUE

/datum/circle_rite/rite_of_oblivion
	name = "Rite of Oblivion"
	tradition = /datum/ritual_tradition/clergy
	circle_path = /obj/structure/ritualcircle/eora
	chants = list(
		"Slip through cracks where time won't tread,",
		"Pluck the strings from thoughts long dead",
		"Unlace the love, erase the face.",
		"Hush… hush… it's gone, it's done—",
		"The name, the touch, the setting sun.",
	)

/datum/circle_rite/rite_of_oblivion/perform(mob/living/user, obj/structure/ritualcircle/circle)
	if(!user.mind)
		to_chat(user, span_warning("You.. don't have a mind to cast this spell with."))
		return TRUE
	to_chat(user, span_cultsmall("You begin digging into the mind..."))
	playsound(circle.loc, 'sound/misc/deadbell.ogg', 100, FALSE, -1)
	circle.loc.visible_message(span_warning("There is an eerie feeling in the air..."))
	oblivion(user)
	return TRUE

/datum/circle_rite/rite_of_oblivion/proc/oblivion(mob/living/caster)
	var/list/known = list()
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(H == caster || H.stat == DEAD || !H.mind)
			continue
		if(!caster.mind.knows(H.mind))
			continue
		known[H.real_name] = H

	if(!length(known))
		to_chat(caster, span_warning("I know of nobody whose memories I can alter."))
		return

	var/pick = input(caster, "Whom shall I alter the memories of?", "Rite of Oblivion") as null | anything in known
	if(!pick)
		return
	var/mob/living/carbon/human/tgt = known[pick]

	if(tgt == caster || tgt.stat == DEAD || !tgt.mind)
		to_chat(caster, span_warning("No idea how you did it, but you picked the <b>wrong</b> person."))
		return

	var/list/memories = split_memories(tgt.mind)
	if(!length(memories))
		to_chat(caster, span_warning("[tgt.real_name]'s mind is an enigma."))
		return

	var/old_memory = input(caster, "Which memory do you choose?", "Rite of Oblivion") as null | anything in memories
	if(!old_memory)
		return

	var/new_memory = input(caster, "Rewrite the memory.", "Rite of Oblivion", old_memory) as null | text
	if(!new_memory)
		return

	if(alert(tgt, "Someone is trying to change your mind...\n\nOld Memory: [old_memory]\n\nNew Memory: [new_memory]", "Memory Intrusion", "Accept", "Reject") != "Accept")
		to_chat(caster, span_warning("[tgt.real_name] rejects your memory."))
		to_chat(tgt, span_warning("You keep your old memory."))
		return

	var/index = memories.Find(old_memory)
	if(!index)
		to_chat(caster, span_warning("You were too late... the memory faded."))
		return

	memories[index] = new_memory
	tgt.mind.memory = null
	for(var/entry in memories)
		tgt.mind.store_memory(entry)

	to_chat(tgt, span_green("You feel your mind twist. Old has become new."))
	to_chat(caster, span_notice("[tgt.real_name] accepts the new memory."))
	log_admin("[key_name(caster)] rewrote a memory on [key_name(tgt)] with the Rite of Oblivion.")

/datum/circle_rite/rite_of_oblivion/proc/split_memories(datum/mind/M)
	var/list/mem = list()
	if(!M?.memory)
		return
	for(var/entry in splittext(M.memory, "<BR>"))
		entry = trimtext(entry)
		if(entry)
			mem += entry
	return mem
