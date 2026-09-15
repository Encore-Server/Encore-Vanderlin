/datum/quirk/attribute_adjuster
	abstract_type = /datum/quirk/attribute_adjuster
	quirk_category = QUIRK_ATTRIBUTEADJUSTER
	/// Attribute point value, reducing an attribute increases this. Lowering decreases
	var/adjusted_attribute = 0

/datum/quirk/attribute_adjuster/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	var/adjusted_str = null
	var/adjusted_end = null
	var/adjusted_int = null
	var/adjusted_per = null
	var/adjusted_con = null
	var/adjusted_for = null
	var/adjusted_speed = null

	H.set_stat_modifier(STATMOD_ADJUSTEDATTRIBUTES, list(
		STAT_STRENGTH = "[adjusted_str]",
		STAT_ENDURANCE = "[adjusted_end]",
		STAT_ENDURANCE = "[adjusted_int]",
		STAT_ENDURANCE = "[adjusted_per]",
		STAT_ENDURANCE = "[adjusted_con]",
		STAT_ENDURANCE = "[adjusted_for]",
		STAT_ENDURANCE = "[adjusted_speed]",
	))

//Add strength, reduce point
/datum/quirk/attribute_adjuster/strength
	name = "Add Strength"
	desc = "Adds strength at the cost of points."
	customization_label = "Adjust Strength"
	customization_options = list(
		1,
		2,
		3,
	)
	incompatible_quirks = list(/datum/quirk/attribute_adjuster/strength_remove)

/datum/quirk/attribute_adjuster/strength/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	attribute_point_value = "-[customization_value]"
	H.set_stat_modifier(STATMOD_ADJUSTEDATTRIBUTES, list(
		STAT_STRENGTH = "[customization_value]"
	))

//Remove strength, add point
/datum/quirk/attribute_adjuster/strength_remove
	name = "Remove Strength"
	desc = "Removes strength and grants points."
	customization_label = "Adjust Strength"
	customization_options = list(
		1,
		2,
		3,
	)
	incompatible_quirks = list(/datum/quirk/attribute_adjuster/strength)

/datum/quirk/attribute_adjuster/strength_remove/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	attribute_point_value = "[customization_value]"
	H.set_stat_modifier(STATMOD_ADJUSTEDATTRIBUTES, list(
		STAT_STRENGTH = "-[customization_value]"
	))

/datum/preferences/proc/calculate_attribute_balance()
	var/attributebalance = STARTING_ATTRIBUTEPOINTS
	for(var/datum/quirk/attribute_adjuster/adjustedattribute in quirks)
		attributebalance += initial(adjustedattribute.attribute_point_value)
	return attributebalance
