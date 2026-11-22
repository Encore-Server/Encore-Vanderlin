#define ROT_WARD "sanctified_slumber"

/datum/action/cooldown/spell/sanctified_slumber
	name = "Sanctified Slumber"
	desc = "Bless the dead to ward off further decay or rot for a time."
	button_icon_state = "psy"
	sound = 'sound/magic/holyshield.ogg'
	charge_sound = 'sound/magic/holycharging.ogg'

	cast_range = 2
	spell_type = SPELL_MIRACLE
	antimagic_flags = MAGIC_RESISTANCE_HOLY
	associated_skill = /datum/attribute/skill/magic/holy

	charge_time = 2 SECONDS
	charge_slowdown = 0.8
	cooldown_time = 2 MINUTES
	spell_cost = 20

	var/ward_time = 30 MINUTES

/datum/action/cooldown/spell/sanctified_slumber/is_valid_target(atom/cast_on)
	. = ..()
	if(!.)
		return FALSE

	if(!isliving(cast_on))
		return FALSE

	var/mob/living/body = cast_on
	if(body.stat != DEAD || IS_DEADITE(body))
		to_chat(owner, span_warning("Only the silent dead can be warded!"))
		return FALSE

	if(HAS_TRAIT(body, TRAIT_NO_ROT))
		to_chat(owner, span_warning("[body] is already warded or cannot rot!"))
		return FALSE

	var/obj/item/bodypart/chest = body.get_bodypart(BODY_ZONE_CHEST)
	var/obj/item/bodypart/head = body.get_bodypart(BODY_ZONE_HEAD)
	if(chest.skeletonized || head.skeletonized)
		to_chat(owner, span_warning("They are too far gone to be warded."))
		return FALSE

	return TRUE

/datum/action/cooldown/spell/sanctified_slumber/cast(mob/living/cast_on)
	. = ..()
	ADD_TRAIT(cast_on, TRAIT_NO_ROT, ROT_WARD)
	cast_on.visible_message(span_notice("[cast_on] is warded from rot by holy light!"))
	addtimer(CALLBACK(cast_on, PROC_REF(unward), WEAKREF(cast_on)), ward_time)

/datum/action/cooldown/spell/sanctified_slumber/proc/unward(datum/weakref/cast_on_ref)
	// if mob got deleted or already had the trait removed, skip the rest of the code
	var/mob/living/warded = cast_on_ref?.resolve()
	if(QDELETED(warded) || !HAS_TRAIT_FROM(warded, TRAIT_NO_ROT, ROT_WARD))
		return

	REMOVE_TRAITS_IN(warded, ROT_WARD)
	playsound(warded, "sound/magic/turntoflies.ogg", 80)
	warded.visible_message(span_warning("The holy ward around [warded] fades as they become vulnerable to rot once more."), span_warning("The holy ward around me fades! I become vulnerable to rot once more."))

#undef ROT_WARD
