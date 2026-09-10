/datum/preference/text/ooc_notes_display
	savefile_key = "ooc_notes_display"
	savefile_identifier = PREF_CHARACTER
	category = "character_ooc"
	can_randomize = FALSE
	maximum_value_length = 2048
	should_strip_html = FALSE
	should_update_preview = FALSE

/datum/preference/text/ooc_notes_display/deserialize(input, datum/preferences/prefs)
	return copytext("[input]", 1, maximum_value_length)

/datum/preference/text/ooc_notes_display/apply_to_human(mob/living/carbon/human/H, value, datum/preferences/prefs)
	H.ooc_notes_display = value
