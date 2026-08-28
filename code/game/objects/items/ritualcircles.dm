/obj/structure/ritualcircle
	name = "ritual circle"
	desc = ""
	icon = 'icons/roguetown/misc/rituals.dmi'
	icon_state = "ritual_base"
	layer = BELOW_OBJ_LAYER
	density = FALSE
	anchored = TRUE
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF

	var/special_rites = list()

/obj/structure/ritualcircle/proc/reset_icon()
    if(QDELETED(src))
        return
    icon_state = initial(icon_state)

/obj/structure/ritualcircle/attack_hand_secondary(mob/living/carbon/human/user)
	user.visible_message(span_warning("[user] begins wiping away the rune"))
	if(do_after(user, 15))
		playsound(loc, 'sound/foley/cloth_wipe (1).ogg', 100, TRUE)
		qdel(src)

/obj/structure/ritualcircle/attack_hand(mob/living/user)
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know the proper rites for this..."))
		return

	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user, span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return

/obj/structure/ritualcircle/astrata
	name = "Rune of the Sun"
	icon_state = "astrata_chalky"
	desc = "A Sun Rune. Reading it leaves you feeling warm."
	special_rites = list("Guiding Light")

/obj/structure/ritualcircle/astrata/proc/guidinglight()
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/guidinglight)
		to_chat(target,span_cultsmall("Astrata's light guides me forward, drawn to me by the Ritualist's pyre!"))
		playsound(target, 'sound/magic/holyshield.ogg', 80, FALSE, -1)

/obj/structure/ritualcircle/astrata/attack_hand(mob/living/user)
	if(!..())
		return

	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = GLOB.all_rituals[RUNE_SUN]["level"]

	if(user_skill < req_skill)
		to_chat(user, span_smallred("I lack the knowledge to invoke this rite."))
		return

	var/riteselection = input(user, "Rituals of the Sun", src) as null|anything in special_rites
	switch(riteselection)
		if("Guiding Light")
			if(do_after(user, 50))
				user.say("I beseech the she-form of the Twinned God!!")
				if(do_after(user, 50))
					user.say("To bring Order to a world of naught!!")
					if(do_after(user, 50))
						user.say("Place your gaze upon me, oh Radiant one!!")
						to_chat(user,span_danger("You feel the eye of the Sun turned upon you. Her warmth dances upon your cheek. You feel yourself warming up...")) // A bunch of flavor stuff, slow incanting.
						icon_state = "astrata_active"
						loc.visible_message(span_warning("[user]'s bursts to flames! Embraced by Her Warmth wholly!"))
						playsound(loc, 'sound/combat/hits/burn (1).ogg', 100, FALSE, -1)
						user.adjust_fire_stacks(10)
						user.IgniteMob()
						user.flash_fullscreen("redflash3")
						user.emote("firescream")
						guidinglight(src) // Actually starts the proc for applying the buff
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
						addtimer(CALLBACK(src, PROC_REF(reset_icon)), 12 SECONDS)
						icon_state = "astrata_chalky"


/obj/structure/ritualcircle/noc
	name = "Rune of the Moon"
	icon_state = "noc_chalky"
	desc = "A Holy Rune of Noc"
	special_rites = list("Moonlight Dance") // list for more to be added later

/obj/structure/ritualcircle/noc/proc/moonlightdance(src)
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/moonlightdance)

/obj/structure/ritualcircle/noc/attack_hand(mob/living/user)
	if(!..())
		return

	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = GLOB.all_rituals[RUNE_MOON]["level"]

	if(user_skill < req_skill)
		to_chat(user, span_smallred("I lack the knowledge to invoke this rite."))
		return

	var/riteselection = input(user, "Rituals of the Moon", src) as null|anything in special_rites
	switch(riteselection) // put ur rite selection here
		if("Moonlight Dance")
			if(do_after(user, 50))
				user.say("I beseech the he-form of the Twinned God!!")
				if(do_after(user, 50))
					user.say("To bring Wisdom to a world of naught!!")
					if(do_after(user, 50))
						user.say("Place your gaze upon me, oh wise one!!")
						to_chat(user,span_cultsmall("The waning half of the Twin-God carries but one eye. With some effort, it can be drawn upon supplicants."))
						playsound(loc, 'sound/magic/holyshield.ogg', 80, FALSE, -1)
						moonlightdance(src)
						user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)

/obj/structure/ritualcircle/pestra
	name = "Rune of Plague"
	desc = "A Rune of Disease. Looking at it makes you feel sick."
	icon_state = "pestra_chalky"
	special_rites = list("Flylord's Triage")

/obj/structure/ritualcircle/pestra/proc/flylords_triage(src)
	var/ritualtargets = view(0, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		to_chat(target,span_userdanger("You feel them crawling into your wounds and pores. Their horrific hum rings through your ears as they do their work!"))
		target.flash_fullscreen("redflash3")
		target.emote("agony")
		target.Stun(200)
		target.Knockdown(200)
		to_chat(target, span_userdanger("UNIMAGINABLE PAIN!"))
		target.apply_status_effect(/datum/status_effect/buff/flylordstriage)

/obj/structure/ritualcircle/pestra/attack_hand(mob/living/user)
	if(!..())
		return

	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = GLOB.all_rituals[RUNE_PLAGUE]["level"]

	if(user_skill < req_skill)
		to_chat(user, span_smallred("I lack the knowledge to invoke this rite."))
		return

	var/riteselection = input(user, "Rituals of Plague", src) as null|anything in special_rites
	switch(riteselection) // put ur rite selection here
		if("Flylord's Triage")
			if(do_after(user, 50))
				user.say("O Queen of Blight, whose breath is plague,")
				if(do_after(user, 50))
					user.say("Whose kiss is rot, whose will is vague.")
					if(do_after(user, 50))
						user.say("Let blood run thin and pulses cease,")
						to_chat(user,span_danger("A hush falls. You feel the world reel — as if something ancient stirs beneath your skin...."))
						if(do_after(user, 30))
							icon_state = "pestra_active"
							user.say("And birth through me thy swarm's release")
							to_chat(user,span_cultsmall("My devotion to the Plague Queen allowing, her servants crawl up from my throat. Come now, father fly..."))
							loc.visible_message(span_warning("[user] gasps — and a torrent of flies erupts from their throat, wings screaming like bells of pestilence!"))
							playsound(loc, 'sound/misc/fliesloop.ogg', 100, FALSE, -1)
							flylords_triage(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							addtimer(CALLBACK(src, PROC_REF(reset_icon)), 12 SECONDS)
							icon_state = "pestra_chalky"

/obj/structure/ritualcircle/dendor
	name = "Rune of Beasts"
	desc = "A Holy Rune of Dendor"
	icon_state = "dendor_chalky"
	special_rites = list("Rite of the Lesser Wolf")

/obj/structure/ritualcircle/dendor/proc/lesser_wolf(src)
	var/ritualtargets = view(1, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/lesserwolf)

/obj/structure/ritualcircle/dendor/attack_hand(mob/living/user)
	if(!..())
		return

	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = GLOB.all_rituals[RUNE_BEAST]["level"]

	if(user_skill < req_skill)
		to_chat(user, span_smallred("I lack the knowledge to invoke this rite."))
		return

	var/riteselection = input(user, "Rituals of Beasts", src) as null|anything in special_rites
	switch(riteselection) // put ur rite selection here
		if("Rite of the Lesser Wolf")
			if(do_after(user, 50))
				user.say("Beast brothers, answer my call!")
				playsound(loc, 'sound/vo/mobs/vw/idle (1).ogg', 100, FALSE, -1)
				if(do_after(user, 50))
					user.say("All of you, strong, tough, or small!")
					playsound(loc, 'sound/vo/mobs/vw/idle (4).ogg', 100, FALSE, -1)
					if(do_after(user, 50))
						loc.visible_message(span_warning("[user] snaps and snarls at the rune. Drool runs down their lip..."))
						playsound(loc, 'sound/vo/mobs/vw/bark (1).ogg', 100, FALSE, -1)
						if(do_after(user, 30))
							icon_state = "dendor_active"
							loc.visible_message(span_warning("[user] snaps their head upward, they let out a howl!"))
							playsound(loc, 'sound/vo/mobs/wwolf/howl (2).ogg', 100, FALSE, -1)
							lesser_wolf(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							addtimer(CALLBACK(src, PROC_REF(reset_icon)), 12 SECONDS)
							icon_state = "dendor_chalky"

/obj/structure/ritualcircle/death
	name = "Rune of Death"
	desc = "A Rue of Death. Looking at it makes you feel uncomfortable."
	icon_state = "necra_chalky"
	special_rites = list("Undermaiden's Bargain")

/obj/structure/ritualcircle/death/proc/undermaiden_bargain(src)
	var/ritualtargets = view(7, loc)
	for(var/mob/living/carbon/human/target in ritualtargets)
		target.apply_status_effect(/datum/status_effect/buff/undermaidenbargain)

/obj/structure/ritualcircle/death/attack_hand(mob/living/user)
	if(!..())
		return

	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = GLOB.all_rituals[RUNE_DEATH]["level"]

	if(user_skill < req_skill)
		to_chat(user, span_smallred("I lack the knowledge to invoke this rite."))
		return

	var/riteselection = input(user, "Rituals of Death", src) as null|anything in special_rites
	switch(riteselection)
		if("Undermaiden's Bargain")
			loc.visible_message(span_warning("[user] sways before the rune, they open their mouth, though no words come out..."))
			playsound(user, 'sound/vo/mobs/ghost/whisper (3).ogg', 100, FALSE, -1)

			if(do_after(user, 60))
				loc.visible_message(span_warning("[user] silently weeps, yet their tears do not flow..."))
				playsound(user, 'sound/vo/mobs/ghost/whisper (1).ogg', 100, FALSE, -1)

				if(do_after(user, 60))
					loc.visible_message(span_warning("[user] shudders, the scent of dirt filling the air."))
					to_chat(user, span_danger("You feel cold breath on the back of your neck..."))
					playsound(user, 'sound/vo/mobs/ghost/death.ogg', 100, FALSE, -1)

					if(do_after(user, 60))
						loc.visible_message(span_warning("[user]'s eyes roll back into their head. Was this a good idea?"))
						to_chat(user, span_cultsmall("A whisper. A scream. A pact has been made."))
						playsound(user, 'sound/vo/mobs/ghost/whisper (2).ogg', 100, FALSE, -1)

						if(do_after(user, 20))
							icon_state = "necra_active"
							user.say("Forgive me, the bargain is intoned!")
							to_chat(user, span_cultsmall("My devotion to the dark has allowed me to strike a bargain for these souls, but who will pay the price?"))
							playsound(loc, 'sound/misc/deadbell.ogg', 100, FALSE, -1)
							loc.visible_message(span_warning("The bell tolls, but not for ye!"))
							undermaiden_bargain(src)
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)

							addtimer(CALLBACK(src, PROC_REF(reset_icon)), 12 SECONDS)
							icon_state = "necra_chalky"

/obj/structure/ritualcircle/eora
    name = "Rune of Love"
    desc = "A Holy Rune of Eora"
    icon_state = "eora_chalky"
    special_rites = list("Rite of Pacification", "Rite of Oblivion") // Added Rite of Oblivion

/obj/structure/ritualcircle/eora/proc/pacify(src)
    var/ritualtargets = view(0, loc)
    for(var/mob/living/carbon/human/target in ritualtargets)
        loc.visible_message(span_warning("[target] sways like windchimes in the wind..."))
        target.visible_message(span_green("I feel the burdens of my heart lifting. Something feels very wrong... I don't mind at all..."))
        target.apply_status_effect(/datum/status_effect/buff/pacify)

/obj/structure/ritualcircle/eora/proc/rite_of_oblivion(obj/structure/ritualcircle/eora/src, mob/living/user, emotion_to_change, memory_suggestion)
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

/obj/structure/ritualcircle/eora/attack_hand(mob/living/user)
	if(!..())
		return

	var/user_skill = GET_MOB_SKILL_VALUE(user, /datum/attribute/skill/magic/ritual) || 0
	var/req_skill = GLOB.all_rituals[RUNE_LOVE]["level"]

	if(user_skill < req_skill)
		to_chat(user, span_smallred("I lack the knowledge to invoke this rite."))
		return

	var/riteselection = input(user, "Rituals of Love", src) as null | anything in special_rites
	switch(riteselection)
		if ("Rite of Pacification")  // Rite of Pacification Logic
			if (do_after(user, 50))
				user.say("#Blessed be your weary head...")
				if (do_after(user, 50))
					user.say("#Full of strife and pain...")
					if (do_after(user, 50))
						user.say("#Let Her ease your fear...")
						if (do_after(user, 50))
							icon_state = "eora_active"
							pacify(src)  // Apply Pacify Effect
							user.apply_status_effect(/datum/status_effect/debuff/ritesexpended)
							addtimer(CALLBACK(src, PROC_REF(reset_icon)), 12 SECONDS)
							icon_state = "eora_chalky"

		if ("Rite of Oblivion")
			loc.visible_message(span_warning("[user]'s eyes roll back as they begin to chant, the air thickening around them."))
			user.say("Slip through cracks where time won't tread,")
			playsound(user, 'sound/vo/mobs/ghost/whisper (3).ogg', 100, FALSE, -1)

			if (do_after(user, 60))
				user.say("Pluck the strings from thoughts long dead")
				playsound(user, 'sound/vo/mobs/ghost/whisper (1).ogg', 100, FALSE, -1)
				to_chat(user, span_danger("Your worst memories come flooding back - why do they seem suddenly sweet?"))

			if (do_after(user, 60))
				user.say("With velvet voice and rose-thorn grace.")
				to_chat(user, span_danger("You hear a woman's laugh echoing throughout your mind..."))
				playsound(user, 'sound/vo/mobs/ghost/death.ogg', 100, FALSE, -1)

			if (do_after(user, 60))
				user.say("Unlace the love, erase the face.")
				loc.visible_message(span_warning("[user]'s voice grows fuzzy and faint."))
				loc.visible_message(span_warning("An image of a laughing woman enters your mind. Old and young and wrong."))
				playsound(user, 'sound/vo/mobs/ghost/whisper (2).ogg', 100, FALSE, -1)

			if (do_after(user, 60))
				icon_state = "eora_active"
				user.say("Hush now… hush… it's gone, it's done—")
				loc.visible_message(span_warning("Is she laughing or crying? A hand stretches out. The fingers clench around something."))
				playsound(loc, 'sound/vo/female/old/laugh (1).ogg', 100, FALSE, -1)

			if (do_after(user, 20))
				user.say("The name, the touch, the setting sun.")
				loc.visible_message(span_warning("Another presence has entered the circle."))

                // EMOTION PHASE - Where things get a bit more complicated
				var/emotion_to_change = input(user, "Which feelings do you wish to alter? The closer you are to the associated memory, the more likely it'll be to work!", "Emotion Selection") as null | text
				if (!emotion_to_change) return

				var/ritualtargets = view(0, loc)
				for (var/mob/living/carbon/human/target in ritualtargets)
					to_chat(target, span_warning("Nails scrape against your feelings of [emotion_to_change]... something foreign brushes against your thoughts."))
					target.flash_fullscreen("redflash3")
					target.emote("agony")
					target.Stun(200)
					target.Knockdown(200)
					to_chat(target, span_userdanger("Her touch slices deep!"))

				if (do_after(user, 20))
					user.visible_message("[user] begins to speak faster, their voice tinged with power...")
					if (do_after(user, 40))
						user.say("With threads unseen, I begin to weave...")
						if (do_after(user, 50))
							user.say("Soft and slow, through the soul I cleave...")

				if (do_after(user, 40))
					user.say("Now, I will plant a seed in your mind...")
					if (do_after(user, 40))
						user.say("It is time for your memory to shift into a different kind...")

                // Memory suggestion input and final ritual actions
				var/memory_suggestion = input(user, "What memory would you like to alter?", "Memory Suggestion") as null | text
				if (!memory_suggestion) return

				if (do_after(user, 60))
					user.say("'[memory_suggestion]'.")
					if (do_after(user, 90))
						user.say("See it done! Feast on your fill!.")
						playsound(loc, 'sound/misc/bell.ogg', 80, FALSE, -1)

						rite_of_oblivion(src, user, emotion_to_change, memory_suggestion)
						addtimer(CALLBACK(src, PROC_REF(reset_icon)), 12 SECONDS)
						icon_state = "eora_chalky"
