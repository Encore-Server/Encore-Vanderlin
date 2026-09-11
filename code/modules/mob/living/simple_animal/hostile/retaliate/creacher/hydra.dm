/mob/living/simple_animal/hostile/retaliate/hydra
	name = "coral hydra"
	desc = "A clever ambush predator which cloaks itself in the surrounding coral. Bane of fish, but typically willing to partake in manflesh."
	faction = list("deepone")

//Sprites
	icon = 'icons/roguetown/mob/monster/hydra.dmi'
	icon_state = "hydra"
	icon_living = "hydra"
	icon_dead = "hydra_dead"

//Descriptors and emotes
	mob_size = MOB_SIZE_LARGE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	footstep_type = FOOTSTEP_MOB_SLIME
	emote_hear = null
	emote_see = null
	verb_say = "hisses"
	verb_ask = "snarls"
	verb_exclaim = "wails"
	verb_yell = "whines"
	speak_emote = list("borples")

//Vision, aggro and ai control
	ai_controller = /datum/ai_controller/hydra
	simple_detect_bonus = 45
	see_in_dark = 12
	retreat_distance = 3
	minimum_distance = 1
	deaggroprob = 0
	retreat_health = 90
	food_max = 100

//Damages, health and resistances
	health = HYDRA_HEALTH
	maxHealth = HYDRA_HEALTH
	base_intents = list(/datum/intent/simple/bigbite)
	melee_damage_lower = 35
	melee_damage_upper = 45
	obj_damage = 15
	environment_smash = ENVIRONMENT_SMASH_STRUCTURES
	limb_destroyer = 1

//Attributes
	base_constitution = 11
	base_strength = 12
	base_speed = 12
	base_endurance = 10

	defprob = 15
	defdrain = 5

	dodgetime = 65

//Butchering and remains
	botched_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 1,
		/obj/item/alch/viscera = 2,
	)
	butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish = 2,
		/obj/item/alch/sinew = 2,
		/obj/item/alch/viscera = 4,
	)
	perfect_butcher_results = list(
		/obj/item/reagent_containers/food/snacks/meat/mince/fish= 3,
		/obj/item/alch/sinew = 3,
		/obj/item/alch/viscera = 5,
	)

	animal_type = /datum/chimeric_table/triton

/mob/living/simple_animal/hostile/retaliate/hydra/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	add_traits(list(TRAIT_NODROWN, TRAIT_SWIMMER, TRAIT_BLOODLOSS_IMMUNE), INNATE_TRAIT)
