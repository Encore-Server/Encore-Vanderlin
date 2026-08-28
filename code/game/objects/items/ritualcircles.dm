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

	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = GLOB.all_rituals[rune_key]["level"] || 0
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
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

/obj/structure/ritualcircle/attack_hand(mob/living/user)
	if(!can_invoke(user))
		return
	return TRUE

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

/obj/structure/ritualcircle/astrata/attack_hand(mob/living/user)
	. = ..()
	if(!.)
		return

	var/rite = input(user, "Rites", name) as null | anything in special_rites
	if(!rite)
		return

	perform_rite(user, rite)

/obj/structure/ritualcircle/noc
	name = "Rune of the Moon"
	icon_state = "noc_chalky"
	desc = "A Holy Rune of Noc"
	special_rites = list("Moonlight Dance") // list for more to be added later
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

/obj/structure/ritualcircle/noc/attack_hand(mob/living/user)
	. = ..()
	if(!.)
		return

	var/rite = input(user, "Rites", name) as null | anything in special_rites
	if(!rite)
		return

	perform_rite(user, rite)

/obj/structure/ritualcircle/pestra
	name = "Rune of Plague"
	desc = "A Rune of Disease. Looking at it makes you feel sick."
	icon_state = "pestra_chalky"
	special_rites = list("Flylord's Triage")
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

/obj/structure/ritualcircle/pestra/attack_hand(mob/living/user)
	. = ..()
	if(!.)
		return

	var/rite = input(user, "Rites", name) as null | anything in special_rites
	if(!rite)
		return

	perform_rite(user, rite)

/obj/structure/ritualcircle/dendor
	name = "Rune of Beasts"
	desc = "A Holy Rune of Dendor"
	icon_state = "dendor_chalky"
	special_rites = list("Rite of the Lesser Wolf")
	chants = list(
		"Beast brothers, answer my call!",
		"All of you, strong, tough, or small!",
		"Snapping and snarling at the rune. Drool runs down one's lip..."
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

/obj/structure/ritualcircle/dendor/attack_hand(mob/living/user)
	. = ..()
	if(!.)
		return

	var/rite = input(user, "Rites", name) as null | anything in special_rites
	if(!rite)
		return

	perform_rite(user, rite)

/obj/structure/ritualcircle/death
	name = "Rune of Death"
	desc = "A Rue of Death. Looking at it makes you feel uncomfortable."
	icon_state = "necra_chalky"
	special_rites = list("Undermaiden's Bargain")
	chants = list(
		"They sway before the rune, they open their mouth, though no words come out...",
		"They silently weep, yet their tears do not flow...",
		"They shudder, the scent of dirt filling the air.",
		"Their eyes roll back into their head. Was this a good idea?",
		"Forgive me, the bargain is intoned!",
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

/obj/structure/ritualcircle/death/attack_hand(mob/living/user)
	. = ..()
	if(!.)
		return

	var/rite = input(user, "Rites", name) as null | anything in special_rites
	if(!rite)
		return

	perform_rite(user, rite)

/obj/structure/ritualcircle/eora
	name = "Rune of Love"
	desc = "A Holy Rune of Eora"
	icon_state = "eora_chalky"
	special_rites = list("Rite of Oblivion")
	chants = list(
		"Slip through cracks where time won't tread,",
		"Pluck the strings from thoughts long dead",
		"Unlace the love, erase the face.",
		"Hush now… hush… it's gone, it's done—",
		"The name, the touch, the setting sun.",
	)


/obj/structure/ritualcircle/eora/proc/rite_of_oblivion(mob/living/user, emotion_to_change, memory_suggestion)
	var/ritualtargets = view(0, loc)

	for(var/mob/living/carbon/human/target in ritualtargets)
		loc.visible_message(span_warning("[target] seems to fade from existence, their mind clearing of all burdens..."))
		target.visible_message(span_blue("You feel an eerie calm... Something stirs—a thought not your own."))

		// Ask the target if they accept the memory
		var/choice = input(target, "A foreign memory whispers into your thoughts. It seeks to implant the memory of '[memory_suggestion]' by focusing on your '[emotion_to_change]''. Do you accept it? The closer your memory and emotions align, the more difficult it is to fight!", "Memory Intrusion") in list("Accept", "Reject")

		if (choice == "Accept")
			to_chat(target, span_green("You embrace the feeling... Something new has taken root within."))
			to_chat(user, span_notice("[target.real_name] accepted your memory about '[memory_suggestion]'."))


		else
			to_chat(target, span_warning("You shudder and push the thought away—it wasn’t yours."))
			to_chat(user, span_warning("[target.real_name] rejected your memory about '[emotion_to_change]'."))

/obj/structure/ritualcircle/eora/perform_rite(mob/living/user, rite)
	if(rite != "Rite of Oblivion")
		return
	if(!chant(user, chants))
		return
	//todo : get target's memories and alter them
	finish_rite(user)

/obj/structure/ritualcircle/eora/attack_hand(mob/living/user)
	. = ..()
	if(!.)
		return

	var/rite = input(user, "Rites", name) as null | anything in special_rites
	if(!rite)
		return

	perform_rite(user, rite)
