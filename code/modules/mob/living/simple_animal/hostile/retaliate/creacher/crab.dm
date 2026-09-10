/mob/living/simple_animal/hostile/retaliate/crab
	name = "dire crab"
	desc = "A gigantic crab. Its kind commonly inhabits the lush undergrowth within shallow water caverns."
	faction = list("deepone")

//Sprites
	icon = 'icons/roguetown/mob/monster/crab.dmi'
	icon_state = "crab"
	icon_living = "crab"
	icon_dead = "crab-dead"

//Descriptors and emotes
	mob_size = MOB_SIZE_LARGE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	footstep_type = null
	emote_hear = null
	emote_see = null
	verb_say = "chitters"
	verb_ask = "clacks"
	verb_exclaim = "shrieks"
	verb_yell = "shrieks"
	speak_emote = list("burbles")

//Audio
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')

//Vision, aggro and ai control
	ai_controller = /datum/ai_controller/crab
	simple_detect_bonus = 5
	see_in_dark = 4
	retreat_distance = 3
	minimum_distance = 1
	deaggroprob = 10
	retreat_health = 0
	food_max = 100

//Damages, health and resistances
	health = CRAB_HEALTH
	maxHealth = CRAB_HEALTH
	base_intents = list(/datum/intent/simple/claw/deepone_boss, /datum/intent/simple/claw/deepone_unarmed)
	melee_damage_lower = 25
	melee_damage_upper = 35
	obj_damage = 35
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	limb_destroyer = 1

//Attributes
	base_constitution = 14
	base_strength = 14
	base_speed = 8
	base_endurance = 12

	defprob = 35
	defdrain = 15

	dodgetime = 45

//Butchering and remains
	botched_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 2,
		/obj/item/alch/viscera = 2,
	)
	butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 4,
		/obj/item/alch/sinew = 4,
		/obj/item/alch/viscera = 4,
	)
	perfect_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish= 6,
		/obj/item/natural/hide = 4,
		/obj/item/alch/sinew = 5,
		/obj/item/alch/viscera = 4,
		/obj/item/carvedgem/rose/cutgem = 1,
	)

	remains_type = /obj/effect/decal/remains/crab
	animal_type = /datum/chimeric_table/triton

/obj/effect/decal/remains/crab
	desc = "The fading shell of a lost, massive crustacean."
	icon = 'icons/roguetown/mob/monster/crab.dmi'
	icon_state = "bones"

/mob/living/simple_animal/hostile/retaliate/crab/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	add_traits(list(TRAIT_NODROWN, TRAIT_SWIMMER, TRAIT_BLOODLOSS_IMMUNE), INNATE_TRAIT)

/mob/living/simple_animal/hostile/retaliate/crab/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/spider/aggro (1).ogg','sound/vo/mobs/spider/aggro (2).ogg','sound/vo/mobs/spider/aggro (3).ogg')
		if("pain")
			return pick('sound/vo/mobs/spider/pain.ogg')
		if("death")
			return pick('sound/vo/mobs/spider/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/spider/idle (1).ogg','sound/vo/mobs/spider/idle (2).ogg','sound/vo/mobs/spider/idle (3).ogg','sound/vo/mobs/spider/idle (4).ogg')


/mob/living/simple_animal/hostile/retaliate/crab/simple_limb_hit(zone)
	if(!zone)
		return ""
	switch(zone)
		if(BODY_ZONE_PRECISE_R_EYE)
			return "right eye"
		if(BODY_ZONE_PRECISE_L_EYE)
			return "left eye"
		if(BODY_ZONE_PRECISE_NOSE)
			return "mandibles"
		if(BODY_ZONE_PRECISE_MOUTH)
			return "stupid crab face"
		if(BODY_ZONE_PRECISE_SKULL)
			return "shell"
		if(BODY_ZONE_PRECISE_EARS)
			return "earhole"
		if(BODY_ZONE_PRECISE_NECK)
			return "filter gills"
		if(BODY_ZONE_PRECISE_L_HAND)
			return "left claw"
		if(BODY_ZONE_PRECISE_R_HAND)
			return "right claw"
		if(BODY_ZONE_PRECISE_L_FOOT)
			return "left flapper"
		if(BODY_ZONE_PRECISE_R_FOOT)
			return "right flapper"
		if(BODY_ZONE_PRECISE_STOMACH)
			return "soft belly"
		if(BODY_ZONE_PRECISE_GROIN)
			return "leg joints"
		if(BODY_ZONE_HEAD)
			return "top shell armor"
		if(BODY_ZONE_R_LEG)
			return "right rearleg"
		if(BODY_ZONE_L_LEG)
			return "left rearleg"
		if(BODY_ZONE_R_ARM)
			return "right foreleg"
		if(BODY_ZONE_L_ARM)
			return "left foreleg"
	return ..()

/mob/living/simple_animal/hostile/retaliate/crab/cannon//this will literally instakill. be careful
	name = "artillery crab"
	desc = "The tattered sail and hollow beast's skull can scarcely deter one from admiring this crab's massive artillery. It seems well able to make use of it..."
	icon_state = "big_crab"
	icon_living = "big_crab"
	icon_dead = "big_crab-dead"
	ai_controller = /datum/ai_controller/crab_cannon
	projectiletype = /obj/projectile/bullet/reusable/cannonball
	projectilesound = 'sound/misc/explode/explosion.ogg'
	ranged_cooldown_time = 45
	ranged = 1

/mob/living/simple_animal/hostile/retaliate/crab/cannon/shotgun//devious
	name = "dangerous artillery crab"
	desc = "The internals of its cannon rattle with a particular menace. This crab seems more than ready to stand on business."
	projectiletype = /obj/projectile/bullet/fragment
	rapid = 4//TALLY HO
	rapid_fire_delay = 1
