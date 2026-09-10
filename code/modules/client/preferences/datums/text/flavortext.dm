/datum/preference/text/flavortext
	savefile_key = "flavortext"
	savefile_identifier = PREF_CHARACTER
	category = "character_ooc"
	can_randomize = FALSE
	maximum_value_length = 1024
	should_strip_html = FALSE
	should_update_preview = FALSE

/datum/preference/text/flavortext/deserialize(input, datum/preferences/prefs)
	return copytext("[input]", 1, maximum_value_length)

/datum/preference/text/flavortext/apply_to_human(mob/living/carbon/human/H, value, datum/preferences/prefs)
	H.flavortext = value
	var/ft = format_flavor_html(value)
	H.flavortext_display = ft
	prefs?.write_preference(/datum/preference/text/flavortext_display, ft)

/datum/preference/text/flavortext/handle_link(datum/preferences/prefs, mob/user)
	to_chat(user, span_notice("["<span class='bold'>Flavortext should not include nonphysical nonsensory attributes such as backstory or the character's internal thoughts. NSFW descriptions are prohibited.</span>"]"))
	var/new_flavortext = input(user, "Input your character description", "DESCRIBE YOURSELF", prefs.read_preference(/datum/preference/text/flavortext)) as message|null
	if(new_flavortext == null)
		return
	if(new_flavortext == "")
		prefs.write_preference(/datum/preference/text/flavortext, null)
		prefs.write_preference(/datum/preference/text/flavortext_display, null)
		prefs.update_menu_data(user)
		return
	prefs.write_preference(/datum/preference/text/flavortext, new_flavortext)
	prefs.write_preference(/datum/preference/text/flavortext_display, format_flavor_html(prefs.read_preference(/datum/preference/text/flavortext)))
	to_chat(user, span_notice("Successfully updated flavortext"))
	log_game("[user] has set their flavortext'.")
