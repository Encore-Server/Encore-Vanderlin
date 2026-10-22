/datum/quirk/attribute_adjuster
	abstract_type = /datum/quirk/attribute_adjuster
	quirk_category = QUIRK_ATTRIBUTEADJUSTER

//Add 1 strength, reduce 1 point
/datum/quirk/attribute_adjuster/strength_add_1
	name = "Add 1 Strength"
	desc = "Adds 1 strength at the cost of 1 point."
	attribute_point_value = -1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/strength_remove_1,
	/datum/quirk/attribute_adjuster/strength_remove_2,
	/datum/quirk/attribute_adjuster/strength_remove_3
	)

/datum/quirk/attribute_adjuster/strength_add_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_STRENGTH_UP_1, list(
		STAT_STRENGTH = 1
	))

//Remove 1 strength, add 1 point
/datum/quirk/attribute_adjuster/strength_remove_1
	name = "Remove 1 Strength"
	desc = "Removes 1 strength to refund 1 point."
	attribute_point_value = 1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/strength_add_1,
	/datum/quirk/attribute_adjuster/strength_add_2,
	/datum/quirk/attribute_adjuster/strength_add_3
	)

/datum/quirk/attribute_adjuster/strength_remove_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_STRENGTH_DOWN_1, list(
		STAT_STRENGTH = -1
	))

//Add 2 strength, reduce 2 point
/datum/quirk/attribute_adjuster/strength_add_2
	name = "Add 2 Strength"
	desc = "Adds 2 strength at the cost of 2 points."
	attribute_point_value = -2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/strength_remove_1,
	/datum/quirk/attribute_adjuster/strength_remove_2,
	/datum/quirk/attribute_adjuster/strength_remove_3
	)

/datum/quirk/attribute_adjuster/strength_add_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_STRENGTH_UP_2, list(
		STAT_STRENGTH = 2
	))

//Remove 2 strength, add 2 point
/datum/quirk/attribute_adjuster/strength_remove_2
	name = "Remove 2 Strength"
	desc = "Removes 2 strength to refund 2 points."
	attribute_point_value = 2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/strength_add_1,
	/datum/quirk/attribute_adjuster/strength_add_2,
	/datum/quirk/attribute_adjuster/strength_add_3
	)

/datum/quirk/attribute_adjuster/strength_remove_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_STRENGTH_DOWN_2, list(
		STAT_STRENGTH = -2
	))

//Add 3 strength, reduce 3 point
/datum/quirk/attribute_adjuster/strength_add_3
	name = "Add 3 Strength"
	desc = "Adds 3 strength at the cost of 3 points."
	attribute_point_value = -3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/strength_remove_1,
	/datum/quirk/attribute_adjuster/strength_remove_2,
	/datum/quirk/attribute_adjuster/strength_remove_3
	)

/datum/quirk/attribute_adjuster/strength_add_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_STRENGTH_UP_3, list(
		STAT_STRENGTH = 3
	))

//Remove 3 strength, add 3 point
/datum/quirk/attribute_adjuster/strength_remove_3
	name = "Remove 3 Strength"
	desc = "Removes 3 strength to refund 3 points."
	attribute_point_value = 3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/strength_add_1,
	/datum/quirk/attribute_adjuster/strength_add_2,
	/datum/quirk/attribute_adjuster/strength_add_3
	)

/datum/quirk/attribute_adjuster/strength_remove_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_STRENGTH_DOWN_3, list(
		STAT_STRENGTH = -3
	))

//ENDURANCE
//Add 1 endurance, reduce 1 point
/datum/quirk/attribute_adjuster/endurance_add_1
	name = "Add 1 Endurance"
	desc = "Adds 1 endurance at the cost of 1 point."
	attribute_point_value = -1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/endurance_remove_1,
	/datum/quirk/attribute_adjuster/endurance_remove_2,
	/datum/quirk/attribute_adjuster/endurance_remove_3
	)

/datum/quirk/attribute_adjuster/endurance_add_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_ENDURANCE_UP_1, list(
		STAT_ENDURANCE = 1
	))

//Remove 1 endurance, add 1 point
/datum/quirk/attribute_adjuster/endurance_remove_1
	name = "Remove 1 Endurance"
	desc = "Removes 1 endurance to refund 1 point."
	attribute_point_value = 1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/endurance_add_1,
	/datum/quirk/attribute_adjuster/endurance_add_2,
	/datum/quirk/attribute_adjuster/endurance_add_3
	)

/datum/quirk/attribute_adjuster/endurance_remove_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_ENDURANCE_DOWN_1, list(
		STAT_ENDURANCE = -1
	))

//Add 2 endurance, reduce 2 point
/datum/quirk/attribute_adjuster/endurance_add_2
	name = "Add 2 Endurance"
	desc = "Adds 2 endurance at the cost of 2 points."
	attribute_point_value = -2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/endurance_remove_1,
	/datum/quirk/attribute_adjuster/endurance_remove_2,
	/datum/quirk/attribute_adjuster/endurance_remove_3
	)

/datum/quirk/attribute_adjuster/endurance_add_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_ENDURANCE_UP_2, list(
		STAT_ENDURANCE = 2
	))

//Remove 2 endurance, add 2 point
/datum/quirk/attribute_adjuster/endurance_remove_2
	name = "Remove 2 Endurance"
	desc = "Removes 2 endurance to refund 2 points."
	attribute_point_value = 2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/endurance_add_1,
	/datum/quirk/attribute_adjuster/endurance_add_2,
	/datum/quirk/attribute_adjuster/endurance_add_3
	)

/datum/quirk/attribute_adjuster/endurance_remove_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_ENDURANCE_DOWN_2, list(
		STAT_ENDURANCE = -2
	))

//Add 3 endurance, reduce 3 point
/datum/quirk/attribute_adjuster/endurance_add_3
	name = "Add 3 Endurance"
	desc = "Adds 3 endurance at the cost of 3 points."
	attribute_point_value = -3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/endurance_remove_1,
	/datum/quirk/attribute_adjuster/endurance_remove_2,
	/datum/quirk/attribute_adjuster/endurance_remove_3
	)

/datum/quirk/attribute_adjuster/endurance_add_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_ENDURANCE_UP_3, list(
		STAT_ENDURANCE = 3
	))

//Remove 3 endurance, add 3 point
/datum/quirk/attribute_adjuster/endurance_remove_3
	name = "Remove 3 Endurance"
	desc = "Removes 3 endurance to refund 3 points."
	attribute_point_value = 3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/endurance_add_1,
	/datum/quirk/attribute_adjuster/endurance_add_2,
	/datum/quirk/attribute_adjuster/endurance_add_3
	)

/datum/quirk/attribute_adjuster/endurance_remove_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_ENDURANCE_DOWN_3, list(
		STAT_ENDURANCE = -3
	))

//INTELLIGENCE
//Add 1 intelligence, reduce 1 point
/datum/quirk/attribute_adjuster/intelligence_add_1
	name = "Add 1 Intelligence"
	desc = "Adds 1 intelligence at the cost of 1 point."
	attribute_point_value = -1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/intelligence_remove_1,
	/datum/quirk/attribute_adjuster/intelligence_remove_2,
	/datum/quirk/attribute_adjuster/intelligence_remove_3
	)

/datum/quirk/attribute_adjuster/intelligence_add_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_INTELLIGENCE_UP_1, list(
		STAT_INTELLIGENCE = 1
	))

//Remove 1 intelligence, add 1 point
/datum/quirk/attribute_adjuster/intelligence_remove_1
	name = "Remove 1 Intelligence"
	desc = "Removes 1 intelligence to refund 1 point."
	attribute_point_value = 1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/intelligence_add_1,
	/datum/quirk/attribute_adjuster/intelligence_add_2,
	/datum/quirk/attribute_adjuster/intelligence_add_3
	)

/datum/quirk/attribute_adjuster/intelligence_remove_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_INTELLIGENCE_DOWN_1, list(
		STAT_INTELLIGENCE = -1
	))

//Add 2 intelligence, reduce 2 point
/datum/quirk/attribute_adjuster/intelligence_add_2
	name = "Add 2 Intelligence"
	desc = "Adds 2 intelligence at the cost of 2 points."
	attribute_point_value = -2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/intelligence_remove_1,
	/datum/quirk/attribute_adjuster/intelligence_remove_2,
	/datum/quirk/attribute_adjuster/intelligence_remove_3
	)

/datum/quirk/attribute_adjuster/intelligence_add_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_INTELLIGENCE_UP_2, list(
		STAT_INTELLIGENCE = 2
	))

//Remove 2 intelligence, add 2 point
/datum/quirk/attribute_adjuster/intelligence_remove_2
	name = "Remove 2 Intelligence"
	desc = "Removes 2 intelligence to refund 2 points."
	attribute_point_value = 2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/intelligence_add_1,
	/datum/quirk/attribute_adjuster/intelligence_add_2,
	/datum/quirk/attribute_adjuster/intelligence_add_3
	)

/datum/quirk/attribute_adjuster/intelligence_remove_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_INTELLIGENCE_DOWN_2, list(
		STAT_INTELLIGENCE = -2
	))

//Add 3 intelligence, reduce 3 point
/datum/quirk/attribute_adjuster/intelligence_add_3
	name = "Add 3 Intelligence"
	desc = "Adds 3 intelligence at the cost of 3 points."
	attribute_point_value = -3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/intelligence_remove_1,
	/datum/quirk/attribute_adjuster/intelligence_remove_2,
	/datum/quirk/attribute_adjuster/intelligence_remove_3
	)

/datum/quirk/attribute_adjuster/intelligence_add_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_INTELLIGENCE_UP_3, list(
		STAT_INTELLIGENCE = 3
	))

//Remove 3 intelligence, add 3 point
/datum/quirk/attribute_adjuster/intelligence_remove_3
	name = "Remove 3 Intelligence"
	desc = "Removes 3 intelligence to refund 3 points."
	attribute_point_value = 3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/intelligence_add_1,
	/datum/quirk/attribute_adjuster/intelligence_add_2,
	/datum/quirk/attribute_adjuster/intelligence_add_3
	)

/datum/quirk/attribute_adjuster/intelligence_remove_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_INTELLIGENCE_DOWN_3, list(
		STAT_INTELLIGENCE = -3
	))

//PERCEPTION
//Add 1 perception, reduce 1 point
/datum/quirk/attribute_adjuster/perception_add_1
	name = "Add 1 Perception"
	desc = "Adds 1 perception at the cost of 1 point."
	attribute_point_value = -1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/perception_remove_1,
	/datum/quirk/attribute_adjuster/perception_remove_2,
	/datum/quirk/attribute_adjuster/perception_remove_3
	)

/datum/quirk/attribute_adjuster/perception_add_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_PERCEPTION_UP_1, list(
		STAT_PERCEPTION = 1
	))

//Remove 1 perception, add 1 point
/datum/quirk/attribute_adjuster/perception_remove_1
	name = "Remove 1 Perception"
	desc = "Removes 1 perception to refund 1 point."
	attribute_point_value = 1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/perception_add_1,
	/datum/quirk/attribute_adjuster/perception_add_2,
	/datum/quirk/attribute_adjuster/perception_add_3
	)

/datum/quirk/attribute_adjuster/perception_remove_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_PERCEPTION_DOWN_1, list(
		STAT_PERCEPTION = -1
	))

//Add 2 perception, reduce 2 point
/datum/quirk/attribute_adjuster/perception_add_2
	name = "Add 2 Perception"
	desc = "Adds 2 perception at the cost of 2 points."
	attribute_point_value = -2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/perception_remove_1,
	/datum/quirk/attribute_adjuster/perception_remove_2,
	/datum/quirk/attribute_adjuster/perception_remove_3
	)

/datum/quirk/attribute_adjuster/perception_add_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_PERCEPTION_UP_2, list(
		STAT_PERCEPTION = 2
	))

//Remove 2 perception, add 2 point
/datum/quirk/attribute_adjuster/perception_remove_2
	name = "Remove 2 Perception"
	desc = "Removes 2 perception to refund 2 points."
	attribute_point_value = 2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/perception_add_1,
	/datum/quirk/attribute_adjuster/perception_add_2,
	/datum/quirk/attribute_adjuster/perception_add_3
	)

/datum/quirk/attribute_adjuster/perception_remove_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_PERCEPTION_DOWN_2, list(
		STAT_PERCEPTION = -2
	))

//Add 3 perception, reduce 3 point
/datum/quirk/attribute_adjuster/perception_add_3
	name = "Add 3 Perception"
	desc = "Adds 3 perception at the cost of 3 points."
	attribute_point_value = -3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/perception_remove_1,
	/datum/quirk/attribute_adjuster/perception_remove_2,
	/datum/quirk/attribute_adjuster/perception_remove_3
	)

/datum/quirk/attribute_adjuster/perception_add_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_PERCEPTION_UP_3, list(
		STAT_PERCEPTION = 3
	))

//Remove 3 perception, add 3 point
/datum/quirk/attribute_adjuster/perception_remove_3
	name = "Remove 3 Perception"
	desc = "Removes 3 perception to refund 3 points."
	attribute_point_value = 3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/perception_add_1,
	/datum/quirk/attribute_adjuster/perception_add_2,
	/datum/quirk/attribute_adjuster/perception_add_3
	)

/datum/quirk/attribute_adjuster/perception_remove_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_PERCEPTION_DOWN_3, list(
		STAT_PERCEPTION = -3
	))

//CONSTITUTION
//Add 1 constitution, reduce 1 point
/datum/quirk/attribute_adjuster/constitution_add_1
	name = "Add 1 Constitution"
	desc = "Adds 1 constitution at the cost of 1 point."
	attribute_point_value = -1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/constitution_remove_1,
	/datum/quirk/attribute_adjuster/constitution_remove_2,
	/datum/quirk/attribute_adjuster/constitution_remove_3
	)

/datum/quirk/attribute_adjuster/constitution_add_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_CONSTITUTION_UP_1, list(
		STAT_CONSTITUTION = 1
	))

//Remove 1 constitution, add 1 point
/datum/quirk/attribute_adjuster/constitution_remove_1
	name = "Remove 1 Constitution"
	desc = "Removes 1 constitution to refund 1 point."
	attribute_point_value = 1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/constitution_add_1,
	/datum/quirk/attribute_adjuster/constitution_add_2,
	/datum/quirk/attribute_adjuster/constitution_add_3
	)

/datum/quirk/attribute_adjuster/constitution_remove_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_CONSTITUTION_DOWN_1, list(
		STAT_CONSTITUTION = -1
	))

//Add 2 constitution, reduce 2 point
/datum/quirk/attribute_adjuster/constitution_add_2
	name = "Add 2 Constitution"
	desc = "Adds 2 constitution at the cost of 2 points."
	attribute_point_value = -2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/constitution_remove_1,
	/datum/quirk/attribute_adjuster/constitution_remove_2,
	/datum/quirk/attribute_adjuster/constitution_remove_3
	)

/datum/quirk/attribute_adjuster/constitution_add_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_CONSTITUTION_UP_2, list(
		STAT_CONSTITUTION = 2
	))

//Remove 2 constitution, add 2 point
/datum/quirk/attribute_adjuster/constitution_remove_2
	name = "Remove 2 Constitution"
	desc = "Removes 2 constitution to refund 2 points."
	attribute_point_value = 2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/constitution_add_1,
	/datum/quirk/attribute_adjuster/constitution_add_2,
	/datum/quirk/attribute_adjuster/constitution_add_3
	)

/datum/quirk/attribute_adjuster/constitution_remove_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_CONSTITUTION_DOWN_2, list(
		STAT_CONSTITUTION = -2
	))

//Add 3 constitution, reduce 3 point
/datum/quirk/attribute_adjuster/constitution_add_3
	name = "Add 3 Constitution"
	desc = "Adds 3 constitution at the cost of 3 points."
	attribute_point_value = -3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/constitution_remove_1,
	/datum/quirk/attribute_adjuster/constitution_remove_2,
	/datum/quirk/attribute_adjuster/constitution_remove_3
	)

/datum/quirk/attribute_adjuster/constitution_add_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_CONSTITUTION_UP_3, list(
		STAT_CONSTITUTION = 3
	))

//Remove 3 constitution, add 3 point
/datum/quirk/attribute_adjuster/constitution_remove_3
	name = "Remove 3 Constitution"
	desc = "Removes 3 constitution to refund 3 points."
	attribute_point_value = 3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/constitution_add_1,
	/datum/quirk/attribute_adjuster/constitution_add_2,
	/datum/quirk/attribute_adjuster/constitution_add_3
	)

/datum/quirk/attribute_adjuster/constitution_remove_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_CONSTITUTION_DOWN_3, list(
		STAT_CONSTITUTION = -3
	))

//FORTUNE
//Add 1 fortune, reduce 1 point
/datum/quirk/attribute_adjuster/fortune_add_1
	name = "Add 1 Fortune"
	desc = "Adds 1 fortune at the cost of 1 point."
	attribute_point_value = -1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/fortune_remove_1,
	/datum/quirk/attribute_adjuster/fortune_remove_2,
	/datum/quirk/attribute_adjuster/fortune_remove_3
	)

/datum/quirk/attribute_adjuster/fortune_add_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_FORTUNE_UP_1, list(
		STAT_FORTUNE = 1
	))

//Remove 1 fortune, add 1 point
/datum/quirk/attribute_adjuster/fortune_remove_1
	name = "Remove 1 Fortune"
	desc = "Removes 1 fortune to refund 1 point."
	attribute_point_value = 1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/fortune_add_1,
	/datum/quirk/attribute_adjuster/fortune_add_2,
	/datum/quirk/attribute_adjuster/fortune_add_3
	)

/datum/quirk/attribute_adjuster/fortune_remove_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_FORTUNE_DOWN_1, list(
		STAT_FORTUNE = -1
	))

//Add 2 fortune, reduce 2 point
/datum/quirk/attribute_adjuster/fortune_add_2
	name = "Add 2 Fortune"
	desc = "Adds 2 fortune at the cost of 2 points."
	attribute_point_value = -2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/fortune_remove_1,
	/datum/quirk/attribute_adjuster/fortune_remove_2,
	/datum/quirk/attribute_adjuster/fortune_remove_3
	)

/datum/quirk/attribute_adjuster/fortune_add_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_FORTUNE_UP_2, list(
		STAT_FORTUNE = 2
	))

//Remove 2 fortune, add 2 point
/datum/quirk/attribute_adjuster/fortune_remove_2
	name = "Remove 2 Fortune"
	desc = "Removes 2 fortune to refund 2 points."
	attribute_point_value = 2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/fortune_add_1,
	/datum/quirk/attribute_adjuster/fortune_add_2,
	/datum/quirk/attribute_adjuster/fortune_add_3
	)

/datum/quirk/attribute_adjuster/fortune_remove_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_FORTUNE_DOWN_2, list(
		STAT_FORTUNE = -2
	))

//Add 3 fortune, reduce 3 point
/datum/quirk/attribute_adjuster/fortune_add_3
	name = "Add 3 Fortune"
	desc = "Adds 3 fortune at the cost of 3 points."
	attribute_point_value = -3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/fortune_remove_1,
	/datum/quirk/attribute_adjuster/fortune_remove_2,
	/datum/quirk/attribute_adjuster/fortune_remove_3
	)

/datum/quirk/attribute_adjuster/fortune_add_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_FORTUNE_UP_3, list(
		STAT_FORTUNE = 3
	))

//Remove 3 fortune, add 3 point
/datum/quirk/attribute_adjuster/fortune_remove_3
	name = "Remove 3 Fortune"
	desc = "Removes 3 fortune to refund 3 points."
	attribute_point_value = 3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/fortune_add_1,
	/datum/quirk/attribute_adjuster/fortune_add_2,
	/datum/quirk/attribute_adjuster/fortune_add_3
	)

/datum/quirk/attribute_adjuster/fortune_remove_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_FORTUNE_DOWN_3, list(
		STAT_FORTUNE = -3
	))

//SPEED
//Add 1 speed, reduce 1 point
/datum/quirk/attribute_adjuster/speed_add_1
	name = "Add 1 speed"
	desc = "Adds 1 speed at the cost of 1 point."
	attribute_point_value = -1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/speed_remove_1,
	/datum/quirk/attribute_adjuster/speed_remove_2,
	/datum/quirk/attribute_adjuster/speed_remove_3
	)

/datum/quirk/attribute_adjuster/speed_add_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_SPEED_UP_1, list(
		STAT_SPEED = 1
	))

//Remove 1 speed, add 1 point
/datum/quirk/attribute_adjuster/speed_remove_1
	name = "Remove 1 speed"
	desc = "Removes 1 speed to refund 1 point."
	attribute_point_value = 1
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/speed_add_1,
	/datum/quirk/attribute_adjuster/speed_add_2,
	/datum/quirk/attribute_adjuster/speed_add_3
	)

/datum/quirk/attribute_adjuster/speed_remove_1/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_SPEED_DOWN_1, list(
		STAT_SPEED = -1
	))

//Add 2 speed, reduce 2 point
/datum/quirk/attribute_adjuster/speed_add_2
	name = "Add 2 speed"
	desc = "Adds 2 speed at the cost of 2 points."
	attribute_point_value = -2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/speed_remove_1,
	/datum/quirk/attribute_adjuster/speed_remove_2,
	/datum/quirk/attribute_adjuster/speed_remove_3
	)

/datum/quirk/attribute_adjuster/speed_add_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_SPEED_UP_2, list(
		STAT_SPEED = 2
	))

//Remove 2 speed, add 2 point
/datum/quirk/attribute_adjuster/speed_remove_2
	name = "Remove 2 speed"
	desc = "Removes 2 speed to refund 2 points."
	attribute_point_value = 2
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/speed_add_1,
	/datum/quirk/attribute_adjuster/speed_add_2,
	/datum/quirk/attribute_adjuster/speed_add_3
	)

/datum/quirk/attribute_adjuster/speed_remove_2/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_SPEED_DOWN_2, list(
		STAT_SPEED = -2
	))

//Add 3 speed, reduce 3 point
/datum/quirk/attribute_adjuster/speed_add_3
	name = "Add 3 speed"
	desc = "Adds 3 speed at the cost of 3 points."
	attribute_point_value = -3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/speed_remove_1,
	/datum/quirk/attribute_adjuster/speed_remove_2,
	/datum/quirk/attribute_adjuster/speed_remove_3
	)

/datum/quirk/attribute_adjuster/speed_add_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_SPEED_UP_3, list(
		STAT_SPEED = 3
	))

//Remove 3 speed, add 3 point
/datum/quirk/attribute_adjuster/speed_remove_3
	name = "Remove 3 speed"
	desc = "Removes 3 speed to refund 3 points."
	attribute_point_value = 3
	incompatible_quirks = list(
	/datum/quirk/attribute_adjuster/speed_add_1,
	/datum/quirk/attribute_adjuster/speed_add_2,
	/datum/quirk/attribute_adjuster/speed_add_3
	)

/datum/quirk/attribute_adjuster/speed_remove_3/on_spawn()
	. = ..()
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/H = owner
	H.set_stat_modifier(STATMOD_ADJUSTED_SPEED_DOWN_3, list(
		STAT_SPEED = -3
	))
