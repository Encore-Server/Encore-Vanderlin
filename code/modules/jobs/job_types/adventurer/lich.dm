/datum/job/lich
	title = "Lich"
	tutorial = "A hell-touched undead spellcaster that rivals the necromantic prowess of even the Shirleighs. You rule Wey Whisperen from your sea fortress and exert your will on the town through your connection to the Smuggler's Den. Make deals, force your way of thinking onto the weak, and rule."
	department_flag = OUTSIDERS
	job_flags = (JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE | JOB_SHOW_IN_CREDITS)
	faction = FACTION_UNDEAD
	total_positions = 1
	spawn_positions = 1

	is_foreigner = FALSE
	job_reopens_slots_on_death = FALSE
	same_job_respawn_delay = 30 MINUTES

	can_have_apprentices = TRUE
	traits = list(TRAIT_NOAMBUSH, TRAIT_BANDITCAMP)
	antag_role = /datum/antagonist/lich
	cmode_music = 'sound/music/cmode/antag/combatskeleton.ogg'


/datum/job/lich/after_spawn(mob/living/carbon/human/spawned, client/player_client)
	..()
	if(!spawned.mind)
		return
	to_chat(spawned, span_boldwarning("Though you are an antagonist, that doesn't mean you must kill everyone you are near. Use your Smugglers Guild connection to peddle illicit goods to the people, drag the mortals into your castle and watch them cower, or do the classic lich thing and make an undead army. Above all, make the round interesting for everyone else!"))
	to_chat(spawned, span_boldwarning("In the same manner, you are NOT an adventurer."))
