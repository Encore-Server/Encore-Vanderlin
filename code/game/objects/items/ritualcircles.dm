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
	var/datum/circle_rite/inscribed

/obj/structure/ritualcircle/Initialize(mapload, datum/circle_rite/rite)
	. = ..()
	if(rite)
		inscribed = rite
		name = rite.name

/obj/structure/ritualcircle/proc/reset_icon()
	if(QDELETED(src))
		return
	icon_state = initial(icon_state)

/obj/structure/ritualcircle/proc/can_invoke(mob/living/user)
	if(!inscribed)
		return FALSE
	if(!HAS_TRAIT(user, TRAIT_RITUALIST))
		to_chat(user, span_smallred("I don't know the proper rites for this..."))
		return FALSE
	if(user.has_status_effect(/datum/status_effect/debuff/ritesexpended))
		to_chat(user, span_smallred("I have performed enough rituals for the day... I must rest before communing more."))
		return FALSE
	if(!inscribed.can_invoke(user, src))
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
	to_chat(user, "I begin invoking [inscribed.name]")
	if(!chant(user, inscribed.chants))
		return
	if(inscribed.perform(user, src))
		finish_rite(user)

/obj/structure/ritualcircle/astrata
	name = "Rune of the Sun"
	desc = "A Sun Rune. Reading it leaves you feeling warm."
	icon_state = "astrata_chalky"
	active_icon = "astrata_active"

/obj/structure/ritualcircle/noc
	name = "Rune of the Moon"
	desc = "A Holy Rune of Noc"
	icon_state = "noc_chalky"
	active_icon = "noc_active"

/obj/structure/ritualcircle/pestra
	name = "Rune of Plague"
	desc = "A Rune of Disease. Looking at it makes you feel sick."
	icon_state = "pestra_chalky"
	active_icon = "pestra_active"

/obj/structure/ritualcircle/dendor
	name = "Rune of Beasts"
	desc = "A Holy Rune of Dendor"
	icon_state = "dendor_chalky"
	active_icon = "dendor_active"

/obj/structure/ritualcircle/death
	name = "Rune of Death"
	desc = "A Rune of Death. Looking at it makes you feel uncomfortable."
	icon_state = "necra_chalky"
	active_icon = "necra_active"

/obj/structure/ritualcircle/eora
	name = "Rune of Love"
	desc = "A Holy Rune of Eora"
	icon_state = "eora_chalky"
	active_icon = "eora_active"
