/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/active_icon
	var/rune_key
	var/special_rites = list()
	var/chants = list()

/obj/structure/ritualcircle/proc/perform_rite(mob/living/user, rite)
	return

/obj/structure/ritualcircle/proc/reset_icon()
	if(QDELETED(src))
		return
	icon_state = initial(icon_state)

/obj/structure/ritualcircle/proc/can_invoke(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know the proper rites for this..."))
		return FALSE
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user, span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return FALSE

	var/list/rune_data = GLOB.all_rituals[rune_key]
	if(!rune_data)
		return FALSE
	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = rune_data["level"] || 0
	if(user_skill < req_skill)
		to_chat(user, span_smallred("I lack the knowledge to invoke this rite."))
		return FALSE
	return TRUE

/obj/structure/ritualcircle/proc/finish_rite(mob/living/user)
	if(active_icon)
		icon_state = active_icon
		addtimer(CALLBACK(src, PROC_REF(reset_icon)), 12 SECONDS)
	user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)

/obj/structure/ritualcircle/proc/chant(mob/living/user, list/lines, chant_time = 5 SECONDS)
	for(var/line in lines)
		if(!do_after(user, chant_time, src))
			return FALSE
		user.say(line)
	return TRUE

/obj/structure/ritualcircle/attack_hand_secondary(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] begins wiping away the rune"))
	if(!do_after(user, 1.5 SECONDS))
		return
	if(QDELETED(src))
		return
	playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
	qdel(src)

/obj/structure/ritualcircle/attack_hand(mob/living/user)
	if(!can_invoke(user))
		return
	var/rite = (length(special_rites) == 1) ? special_rites[1] : input(user, "Rites", name) as null | anything in special_rites
	if(!rite)
		return
	to_chat(user, "I begin invoking [rite]")
	perform_rite(user, rite)

/obj/structure/ritualcircle/astrata
	name = "Rune of the Sun"
	icon_state = "astrata_chalky"
	active_icon = "astrata_active"
	desc = "A Sun Rune. Reading it leaves you feeling warm."
	special_rites = list("Guiding Light")
	rune_key = RUNE_SUN
	chants = list(
		"I beseech the she-form of the Twinned God!!",
		"To bring Order to a world of naught!!",
		"Place your gaze upon me, oh Radiant one!!",
	)

/obj/structure/ritualcircle/astrata/proc/guidinglight()
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/guidinglight)
		to_chat(target,span_cultsmall("Astrata's light guides me forward, drawn to me by the Ritualist's pyre!"))
		playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1)

/obj/structure/ritualcircle/astrata/perform_rite(mob/living/user, rite)
	if(rite != "Guiding Light")
		return
	if(!chant(user, chants))
		return
	to_chat(user,span_danger("You feel the eye of the Sun turned upon you. Her warmth dances upon your cheek. You feel yourself warming up...")) // A bunch of flavor stuff, slow incanting.
	loc.visible_message(span_warning("[user]'s bursts to flames! Embraced by Her Warmth wholly!"))
	playsound(loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
	user.adjust_fire_stacks(10)
	user.IgniteMob()
	user.flash_fullscreen("redflash3")
	user.emote("firescream")
	guidinglight() // Actually starts the proc for applying the buff
	finish_rite(user)

/obj/structure/ritualcircle/noc
	name = "Rune of the Moon"
	icon_state = "noc_chalky"
	active_icon = "noc_active"
	desc = "A Holy Rune of Noc"
	special_rites = list("Moonlight Dance") // list for more to be added later
	rune_key = RUNE_MOON
	chants = list(
		"I beseech the he-form of the Twinned God!!",
		"To bring Wisdom to a world of naught!!",
		"Place your gaze upon me, oh wise one!!",
	)

/obj/structure/ritualcircle/noc/proc/moonlightdance()
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/moonlightdance)

/obj/structure/ritualcircle/noc/perform_rite(mob/living/user, rite)
	if(rite != "Moonlight Dance")
		return
	if(!chant(user, chants))
		return
	to_chat(user,span_cultsmall("The waning half of the Twin-God carries but one eye. With some effort, it can be drawn upon supplicants."))
	playsound(loc, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
	moonlightdance()
	finish_rite(user)

/obj/structure/ritualcircle/pestra
	name = "Rune of Plague"
	desc = "A Rune of Disease. Looking at it makes you feel sick."
	icon_state = "pestra_chalky"
	active_icon = "pestra_active"
	special_rites = list("Flylord's Triage")
	rune_key = RUNE_PLAGUE
	chants = list(
		"O Queen of Blight, whose breath is plague,",
		"Whose kiss is rot, whose will is vague.",
		"Let blood run thin and pulses cease,",
		"And birth through me thy swarm's release",
	)

/obj/structure/ritualcircle/pestra/proc/flylords_triage()
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		to_chat(target,span_userdanger("You feel them crawling into your wounds and pores. Their horrific hum rings through your ears as they do their work!"))
		target.flash_fullscreen("redflash3")
		target.emote("agony")
		target.Stun(200)
		target.Knockdown(200)
		to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
		target.apply_status_effect(/datum/status_effect/buff/flylordstriage)

/obj/structure/ritualcircle/pestra/perform_rite(mob/living/user, rite)
	if(rite != "Flylord's Triage")
		return
	if(!chant(user, chants))
		return
	to_chat(user,span_cultsmall("My devotion to the Plague Queen allowing, her servants crawl up from my throat. Come now, father fly..."))
	loc.visible_message(span_warning("[user] gasps — and a torrent of flies erupts from their throat, wings screaming like bells of pestilence!"))
	playsound(loc, 'sound/misc/fliesloop.ogg', 100, FALSE, -1)
	flylords_triage()
	finish_rite(user)

/obj/structure/ritualcircle/dendor
	name = "Rune of Beasts"
	desc = "A Holy Rune of Dendor"
	icon_state = "dendor_chalky"
	active_icon = "dendor_active"
	special_rites = list("Rite of the Lesser Wolf")
	rune_key = RUNE_BEAST
	chants = list(
		"Beast brothers, answer my call!",
		"All of you, strong, tough, or small!",
	)

/obj/structure/ritualcircle/dendor/proc/lesser_wolf()
	var/ritualtargets = view(1, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/lesserwolf)

/obj/structure/ritualcircle/dendor/perform_rite(mob/living/user, rite)
	if(rite != "Rite of the Lesser Wolf")
		return
	if(!chant(user, chants))
		return
	loc.visible_message(span_warning("[user] snaps their head upward, they let out a howl!"))
	playsound(loc, 'sound/vo/mobs/wwolf/howl (2).ogg', 100, FALSE, -1)
	lesser_wolf()
	finish_rite(user)

/obj/structure/ritualcircle/death
	name = "Rune of Death"
	desc = "A Rune of Death. Looking at it makes you feel uncomfortable."
	icon_state = "necra_chalky"
	active_icon = "necra_active"
	rune_key = RUNE_DEATH
	special_rites = list("Undermaiden's Bargain")
	chants = list(
		"Placeholder chant!",
		"Placeholder chant!",
		"Placeholder chant!",
	)

/obj/structure/ritualcircle/death/proc/undermaiden_bargain()
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/undermaidenbargain)

/obj/structure/ritualcircle/death/perform_rite(mob/living/user, rite)
	if(rite != "Undermaiden's Bargain")
		return
	if(!chant(user, chants))
		return
	to_chat(user, span_cultsmall("My devotion to the dark has allowed me to strike a bargain for these souls, but who will pay the price?"))
	playsound(loc, 'sound/misc/deadbell.ogg', 100, FALSE, -1)
	loc.visible_message(span_warning("The bell tolls, but not for ye!"))
	undermaiden_bargain()
	finish_rite(user)

/obj/structure/ritualcircle/eora
	name = "Rune of Love"
	desc = "A Holy Rune of Eora"
	icon_state = "eora_chalky"
	active_icon = "eora_active"
	rune_key = RUNE_LOVE
	special_rites = list("Rite of Oblivion")
	chants = list(
		"Slip through cracks where time won't tread,",
		"Pluck the strings from thoughts long dead",
		"Unlace the love, erase the face.",
		"Hush now… hush… it's gone, it's done—",
		"The name, the touch, the setting sun.",
	)

/obj/structure/ritualcircle/eora/proc/oblivion(mob/living/caster)
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

/obj/structure/ritualcircle/eora/proc/split_memories(datum/mind/M)
	var/mem = list()
	if(!M?.memory)
		return
	for(var/entry in splittext(M.memory, "<BR>"))
		entry = trimtext(entry)
		if(entry)
			mem += entry
	return mem

/obj/structure/ritualcircle/eora/perform_rite(mob/living/user, rite)
	if(rite != "Rite of Oblivion")
		return
	if(!chant(user, chants))
		return

	if(!user.mind)
		to_chat(user, span_warning("You.. don't have a mind to cast this spell with."))
		finish_rite(user)
		return

	to_chat(user, span_cultsmall("You begin digging into the mind..."))
	playsound(loc, 'sound/misc/deadbell.ogg', 100, FALSE, -1)
	loc.visible_message(span_warning("There is an eerie feeling in the air..."))
	oblivion(user)
	finish_rite(user)
	return
