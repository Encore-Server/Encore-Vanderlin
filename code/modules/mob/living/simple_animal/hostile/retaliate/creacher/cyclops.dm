/mob/living/simple_animal/hostile/retaliate/cyclops
	name = "manclops"
	desc = "A terrible beast. It has no features save for a monstrous gleaming eye and two bulky columns for locomotion. How such a thing survives in nature is a mystery..."
	faction = list("cyclops")

//Sprites
	icon = 'icons/roguetown/mob/monster/cyclops.dmi'
	icon_state = "peepers"
	icon_living = "peepers"
	icon_dead = "peepers-dead"
	pixel_x = -16

//Descriptors and emotes
	mob_size = MOB_SIZE_LARGE
	mob_biotypes = MOB_ORGANIC|MOB_BEAST
	footstep_type = FOOTSTEP_MOB_HEAVY
	emote_hear = null
	emote_see = null
	verb_say = "groans"
	verb_ask = "grunts"
	verb_exclaim = "shrieks"
	verb_yell = "screams"

//Audio
	attack_sound = list('sound/combat/wooshes/blunt/wooshhuge (1).ogg','sound/combat/wooshes/blunt/wooshhuge (2).ogg','sound/combat/wooshes/blunt/wooshhuge (3).ogg')

//Vision, aggro and ai control
	ai_controller = /datum/ai_controller/cyclops
	simple_detect_bonus = 50//its a walking eye
	see_in_dark = 9
	retreat_distance = 0
	minimum_distance = 0
	deaggroprob = 0
	retreat_health = 0
	food_max = 150

//Damages, health and resistances
	health = CYCLOPS_HEALTH
	maxHealth = CYCLOPS_HEALTH
	base_intents = list(/datum/intent/simple/hind_kick, /datum/intent/simple/headbutt)
	melee_damage_lower = 25
	melee_damage_upper = 45
	obj_damage = 50
	environment_smash = ENVIRONMENT_SMASH_WALLS

//Attributes
	base_constitution = 14
	base_strength = 18
	base_speed = 2
	base_endurance = 14

	defprob = 15
	defdrain = 5

	dodgetime = 25

/obj/effect/decal/remains/cyclops
	desc = "A withered husk of an old beast."
	icon = 'icons/roguetown/mob/monster/cyclops.dmi'
	icon_state = "bones"

/mob/living/simple_animal/hostile/retaliate/cyclops/Initialize()
	. = ..()
	AddComponent(/datum/component/ai_aggro_system)
	ADD_TRAIT(src, TRAIT_ACID_IMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_BLOODLOSS_IMMUNE, TRAIT_GENERIC)

/mob/living/simple_animal/hostile/retaliate/cyclops/get_sound(input)
	switch(input)
		if("aggro")
			return pick('sound/vo/mobs/troll/aggro1.ogg','sound/vo/mobs/troll/aggro2.ogg')
		if("pain")
			return pick('sound/vo/mobs/troll/pain1.ogg','sound/vo/mobs/troll/pain2.ogg')
		if("death")
			return pick('sound/vo/mobs/troll/death.ogg')
		if("idle")
			return pick('sound/vo/mobs/troll/idle1.ogg','sound/vo/mobs/troll/idle2.ogg')
		if("cidle")
			return pick('sound/vo/mobs/troll/cidle1.ogg','sound/vo/mobs/troll/aggro2.ogg')

/mob/living/simple_animal/hostile/retaliate/cyclops/death()
	..()
	gib()

/mob/living/simple_animal/hostile/retaliate/cyclops/teeth
	name = "chobbler"
	desc = "Incisors like marble gleam from healthy, well-cared-for gums. Being a maneater must do wonders for dental health."
	icon_state = "chompers"
	icon_living = "chompers"
	icon_dead = "chompers-dead"
	base_intents = list(/datum/intent/simple/bigbite)

/mob/living/simple_animal/hostile/retaliate/cyclops/nose
	name = "schnozclops"
	desc = "A frightening, mutated cyclops which has clearly exchanged its visual senses for the olfactory."
	icon_state = "schnozclops"
	icon_living = "schnozclops"
	icon_dead = "schnozclops-dead"

/mob/living/simple_animal/hostile/retaliate/cyclops/posh
	name = "sterling cyclops"
	desc = "A jolly good one, that."
	icon_state = "fine_chap"
	icon_living = "fine_chap"
	icon_dead = "fine_chap-dead"

/mob/living/simple_animal/hostile/retaliate/cyclops/flyer
	name = "bewildering eye"
	desc = "A terrible beast. Wriggling tendrils extend from a pudgy body blanketing the largest eye you have ever seen."
	icon_state = "gazer"
	icon_living = "gazer"
	icon_dead = "gazer-dead"
	ai_controller = /datum/ai_controller/cyclops_gazer
	spacewalk = TRUE
	base_intents = list(/datum/intent/simple/stab, /datum/intent/simple/spear)
	is_flying_animal = TRUE
	projectiletype = /obj/projectile/magic/repel
	projectilesound = 'sound/misc/explode/explosion.ogg'
	ranged_cooldown_time = 3
	ranged = 1
