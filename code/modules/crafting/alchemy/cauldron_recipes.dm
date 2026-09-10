/datum/alch_cauldron_recipe
	abstract_type = /datum/alch_cauldron_recipe
	var/category = "Potions"
	var/recipe_name = ""
	var/smells_like = "nothing"
	var/list/output_reagents = list()
	var/list/output_items
	var/list/required_essences = list()

/datum/alch_cauldron_recipe/proc/matches_essences(list/available_essences)
	if(!length(required_essences))
		return FALSE
	for(var/essence_type in required_essences)
		var/required_amount = required_essences[essence_type]
		var/available_amount = available_essences?[essence_type]
		if(!available_amount || available_amount < required_amount)
			return FALSE
	return TRUE

/*
The general idea is:
The more complex the recipe and cost
the better the potion should be
and vice versa
the better the potion/reagent
the more complex the recipe and cost

Keep them reasonable to make
*/


//Weak/Normal potions/elixirs

/datum/alch_cauldron_recipe/berrypoison
	recipe_name = "Berry Poison"
	smells_like = "charcoal"
	output_reagents = list(/datum/reagent/poison/berry = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/water = 36,
		/datum/thaumaturgical_essence/poison = 20,
	)

/datum/alch_cauldron_recipe/stam_poison
	recipe_name = "Stamina Poison"
	smells_like = "kicked up dust"
	output_reagents = list(/datum/reagent/poison/stamina = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/air = 36,
		/datum/thaumaturgical_essence/poison = 20,
	)

/datum/alch_cauldron_recipe/health_potion
	recipe_name = "Lifeblood Potion"
	smells_like = "metal"
	output_reagents = list(/datum/reagent/medicine/healthpot = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/order = 36,
		/datum/thaumaturgical_essence/life = 36,
	)

/datum/alch_cauldron_recipe/mana_potion
	recipe_name = "Mana"
	smells_like = "dry air"
	output_reagents = list(/datum/reagent/medicine/manapot = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/water = 36,
		/datum/thaumaturgical_essence/energia = 36,
	)

/datum/alch_cauldron_recipe/stamina_potion
	recipe_name = "Stamina Potion"
	smells_like = "wet grass"
	output_reagents = list(/datum/reagent/medicine/stampot = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/air = 36,
		/datum/thaumaturgical_essence/motion = 20
	)

/datum/alch_cauldron_recipe/antidote
	recipe_name = "Antidote"
	smells_like = "rotten cheese"
	output_reagents = list(/datum/reagent/medicine/antidote = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 20,
		/datum/thaumaturgical_essence/life = 36,
	)

//Strong Potions/Elixirs

/datum/alch_cauldron_recipe/doompoison
	recipe_name = "Doom Poison"
	smells_like = "charcoal"
	output_reagents = list(/datum/reagent/poison/doom = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/void = 48,
		/datum/thaumaturgical_essence/poison = 84,
	)

/datum/alch_cauldron_recipe/big_stam_poison
	recipe_name = "Strong Stamina Poison"
	smells_like = "stagnant cold air"
	output_reagents = list(/datum/reagent/poison/stamina_strong = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/frost = 48,
		/datum/thaumaturgical_essence/poison = 84,
	)

/datum/alch_cauldron_recipe/disease_cure
	recipe_name = "Disease Cure"
	smells_like = "saiga droppings"
	output_reagents = list(/datum/reagent/medicine/diseasecure = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/light = 20,
		/datum/thaumaturgical_essence/earth = 60,
		/datum/thaumaturgical_essence/life = 36,
	)

/datum/alch_cauldron_recipe/big_mana_potion
	recipe_name = "Strong Mana"
	smells_like = "crackling thunder"
	output_reagents = list(/datum/reagent/medicine/strongmana = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/energia = 20,
		/datum/thaumaturgical_essence/crystal = 20,
		/datum/thaumaturgical_essence/magic = 20,
	)

/datum/alch_cauldron_recipe/big_health_potion
	recipe_name = "Strong Lifeblood Potion"
	smells_like = "rich metal"
	output_reagents = list(/datum/reagent/medicine/stronghealth = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 16,
		/datum/thaumaturgical_essence/light = 36,
		/datum/thaumaturgical_essence/cycle = 36,
	)

/datum/alch_cauldron_recipe/big_stamina_potion
	recipe_name = "Strong Stamina Potion"
	smells_like = "freshly cut grass"
	output_reagents = list(/datum/reagent/medicine/strongstam = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/air = 36,
		/datum/thaumaturgical_essence/energia = 20,
		/datum/thaumaturgical_essence/cycle = 36,
	)

//meant to be difficult to craft
/datum/alch_cauldron_recipe/dread_death
	recipe_name = "Dread Death"
	smells_like = "cold fire"
	output_reagents = list(/datum/reagent/poison/dreaddeath = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/frost = 36,
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/magic = 20,
		/datum/thaumaturgical_essence/death = 72,
	)

// S.P.E.C.I.A.L. potions
/datum/alch_cauldron_recipe/str_potion
	recipe_name = "Strength of Troll Muscles"
	smells_like = "sour vomit"
	output_reagents = list(/datum/reagent/buff/strength = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 72,
		/datum/thaumaturgical_essence/order = 36,
		/datum/thaumaturgical_essence/crystal = 20,
		/datum/thaumaturgical_essence/magic = 48,
	)

/datum/alch_cauldron_recipe/per_potion
	recipe_name = "Perception of Cat Eyes"
	smells_like = "cat urine"
	output_reagents = list(/datum/reagent/buff/perception = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 72,
		/datum/thaumaturgical_essence/order = 36,
		/datum/thaumaturgical_essence/light = 20,
		/datum/thaumaturgical_essence/magic = 48,
	)

/datum/alch_cauldron_recipe/end_potion
	recipe_name = "Fortitude of Enduring Mountains"
	smells_like = "gote urine"
	output_reagents = list(/datum/reagent/buff/endurance = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 72,
		/datum/thaumaturgical_essence/fire = 36,
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/magic = 48,
	)

/datum/alch_cauldron_recipe/con_potion
	recipe_name = "Constitution of Stone Flesh"
	smells_like = "petrichor"
	output_reagents = list(/datum/reagent/buff/constitution = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 108,
		/datum/thaumaturgical_essence/crystal = 48,
		/datum/thaumaturgical_essence/magic = 48,
	)

/datum/alch_cauldron_recipe/int_potion
	recipe_name = "Intelligence of Ancient Minds"
	smells_like = "fresh moss"
	output_reagents = list(/datum/reagent/buff/intelligence = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/water = 72,
		/datum/thaumaturgical_essence/frost = 36,
		/datum/thaumaturgical_essence/order = 20,
		/datum/thaumaturgical_essence/magic = 48,
	)

/datum/alch_cauldron_recipe/spd_potion
	recipe_name = "Speed of Fleeting Spirits"
	smells_like = "sea salt"
	output_reagents = list(/datum/reagent/buff/speed = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/water = 72,
		/datum/thaumaturgical_essence/air = 36,
		/datum/thaumaturgical_essence/motion = 36,
		/datum/thaumaturgical_essence/magic = 48,
	)

/datum/alch_cauldron_recipe/lck_potion
	recipe_name = "Luck of Seven Clovers"
	smells_like = "rich compost"
	output_reagents = list(/datum/reagent/buff/fortune = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/chaos = 96,
		/datum/thaumaturgical_essence/energia = 72,
		/datum/thaumaturgical_essence/magic = 48,
	)

//Misc

/datum/alch_cauldron_recipe/gender_potion
	recipe_name = "Gender Potion"
	smells_like = "flowery nectars"
	output_reagents = list(/datum/reagent/medicine/gender_potion = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/chaos = 60,
		/datum/thaumaturgical_essence/order = 48,
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/poison = 20,
		/datum/thaumaturgical_essence/magic = 12,
	)

/datum/alch_cauldron_recipe/rosawater_potion
	recipe_name = "Artificial Rose Water"
	smells_like = "rosa"
	output_reagents = list(/datum/reagent/medicine/rosawater = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/energia = 36,
		/datum/thaumaturgical_essence/order = 36,
		/datum/thaumaturgical_essence/light = 36,
		/datum/thaumaturgical_essence/water = 36,
	)

/datum/alch_cauldron_recipe/blistergall_potion
	recipe_name = "Blistergall"
	smells_like = "acidic rot"
	output_reagents = list(/datum/reagent/poison/blistergall = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 36,
		/datum/thaumaturgical_essence/poison = 48,
		/datum/thaumaturgical_essence/chaos = 20,
	)

/datum/alch_cauldron_recipe/gloomvenom_potion
	recipe_name = "Gloomvenom"
	smells_like = "damp caves"
	output_reagents = list(/datum/reagent/poison/gloomvenom = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/void = 48,
		/datum/thaumaturgical_essence/poison = 36,
		/datum/thaumaturgical_essence/death = 20,
	)

/datum/alch_cauldron_recipe/hexblood_poison_potion
	recipe_name = "Hexblood Poison"
	smells_like = "burnt copper"
	output_reagents = list(/datum/reagent/poison/hexblood_poison = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/death = 36,
		/datum/thaumaturgical_essence/chaos = 36,
		/datum/thaumaturgical_essence/poison = 36,
	)

/datum/alch_cauldron_recipe/mirrorwaste_potion
	recipe_name = "Mirrorwaste"
	smells_like = "still air"
	output_reagents = list(/datum/reagent/poison/mirrorwaste = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/void = 48,
		/datum/thaumaturgical_essence/order = 36,
		/datum/thaumaturgical_essence/crystal = 36,
		/datum/thaumaturgical_essence/magic = 36,
	)

/datum/alch_cauldron_recipe/soulbane_ichor_potion
	recipe_name = "Soulbane Ichor"
	smells_like = "nothing and death"
	output_reagents = list(/datum/reagent/poison/soulbane_ichor = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/death = 84,
		/datum/thaumaturgical_essence/void = 48,
		/datum/thaumaturgical_essence/poison = 36,
		/datum/thaumaturgical_essence/magic = 36,
	)

/datum/alch_cauldron_recipe/quietdeath_potion
	recipe_name = "Quietdeath"
	smells_like = "nothing"
	output_reagents = list(/datum/reagent/poison/quietdeath = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/void = 36,
		/datum/thaumaturgical_essence/death = 48,
		/datum/thaumaturgical_essence/poison = 36,
		/datum/thaumaturgical_essence/order = 20,
	)

/datum/alch_cauldron_recipe/mirelung_brew_potion
	recipe_name = "Mirelung Brew"
	smells_like = "stagnant water"
	output_reagents = list(/datum/reagent/poison/mirelung_brew = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/water = 48,
		/datum/thaumaturgical_essence/poison = 36,
		/datum/thaumaturgical_essence/void = 20,
	)

/datum/alch_cauldron_recipe/ichor_of_mending_potion
	recipe_name = "Ichor of Mending"
	smells_like = "rendered tallow"
	output_reagents = list(/datum/reagent/medicine/ichor_of_mending = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 48,
		/datum/thaumaturgical_essence/earth = 36,
		/datum/thaumaturgical_essence/order = 20,
	)

/datum/alch_cauldron_recipe/ashbinders_salve_potion
	recipe_name = "Ashbinder's Salve"
	smells_like = "cooling embers"
	output_reagents = list(/datum/reagent/medicine/ashbinders_salve = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 36,
		/datum/thaumaturgical_essence/earth = 36,
		/datum/thaumaturgical_essence/life = 20,
	)

/datum/alch_cauldron_recipe/vitalroot_draught_potion
	recipe_name = "Vitalroot Draught"
	smells_like = "deep earth and mineral water"
	output_reagents = list(/datum/reagent/medicine/vitalroot_draught = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/water = 36,
		/datum/thaumaturgical_essence/earth = 20,
	)

/datum/alch_cauldron_recipe/tombsilt_tincture_potion
	recipe_name = "Tombsilt Tincture"
	smells_like = "old earth and spirits"
	output_reagents = list(/datum/reagent/medicine/tombsilt_tincture = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/death = 20,
		/datum/thaumaturgical_essence/earth = 36,
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/order = 20,
	)

/datum/alch_cauldron_recipe/pale_serum_potion
	recipe_name = "Pale Serum"
	smells_like = "clean sterility"
	output_reagents = list(/datum/reagent/medicine/pale_serum = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/order = 48,
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/crystal = 36,
	)

/datum/alch_cauldron_recipe/crystalline_lymph_potion
	recipe_name = "Crystalline Lymph"
	smells_like = "ionized air"
	output_reagents = list(/datum/reagent/medicine/crystalline_lymph = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/crystal = 36,
		/datum/thaumaturgical_essence/order = 36,
		/datum/thaumaturgical_essence/water = 36,
	)

/datum/alch_cauldron_recipe/bloodelder_wine_potion
	recipe_name = "Bloodelder Wine"
	smells_like = "fermented fruit and copper"
	output_reagents = list(/datum/reagent/medicine/bloodelder_wine = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 48,
		/datum/thaumaturgical_essence/chaos = 20,
		/datum/thaumaturgical_essence/water = 36,
	)

/datum/alch_cauldron_recipe/nervebind_extract_potion
	recipe_name = "Nervebind Extract"
	smells_like = "damp fungus"
	output_reagents = list(/datum/reagent/medicine/nervebind_extract = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/void = 36,
		/datum/thaumaturgical_essence/earth = 36,
		/datum/thaumaturgical_essence/order = 36,
	)

/datum/alch_cauldron_recipe/stonevein_broth_potion
	recipe_name = "Stonevein Broth"
	smells_like = "wet stone"
	output_reagents = list(/datum/reagent/medicine/stonevein_broth = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 72,
		/datum/thaumaturgical_essence/crystal = 36,
		/datum/thaumaturgical_essence/life = 20,
	)

/datum/alch_cauldron_recipe/fever_oil_potion
	recipe_name = "Fever Oil"
	smells_like = "burning spice"
	output_reagents = list(/datum/reagent/medicine/fever_oil = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 48,
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/chaos = 20,
	)

/datum/alch_cauldron_recipe/mindclear_tonic_potion
	recipe_name = "Mindclear Tonic"
	smells_like = "crisp water and crystal"
	output_reagents = list(/datum/reagent/medicine/mindclear_tonic = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/crystal = 36,
		/datum/thaumaturgical_essence/water = 36,
		/datum/thaumaturgical_essence/order = 36,
		/datum/thaumaturgical_essence/frost = 20,
	)

/datum/alch_cauldron_recipe/marrowbrew_potion
	recipe_name = "Marrowbrew"
	smells_like = "bone broth"
	output_reagents = list(/datum/reagent/medicine/marrowbrew = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 36,
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/cycle = 20,
	)

/datum/alch_cauldron_recipe/spiritwood_elixir_potion
	recipe_name = "Spiritwood Elixir"
	smells_like = "ancient forest"
	output_reagents = list(/datum/reagent/medicine/spiritwood_elixir = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 48,
		/datum/thaumaturgical_essence/cycle = 36,
		/datum/thaumaturgical_essence/magic = 20,
		/datum/thaumaturgical_essence/earth = 36,
	)

/datum/alch_cauldron_recipe/coldvein_compress_potion
	recipe_name = "Coldvein Compress"
	smells_like = "winter air"
	output_reagents = list(/datum/reagent/medicine/coldvein_compress = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/frost = 36,
		/datum/thaumaturgical_essence/water = 36,
		/datum/thaumaturgical_essence/life = 20,
	)

/datum/alch_cauldron_recipe/soulweave_distillate_potion
	recipe_name = "Soulweave Distillate"
	smells_like = "sunrise petals"
	output_reagents = list(/datum/reagent/medicine/soulweave_distillate = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/cycle = 48,
		/datum/thaumaturgical_essence/light = 36,
		/datum/thaumaturgical_essence/magic = 36,
	)

/datum/alch_cauldron_recipe/ashwarden_brew_potion
	recipe_name = "Ashwarden Brew"
	smells_like = "sulphurous fumes"
	output_reagents = list(/datum/reagent/medicine/ashwarden_brew = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/fire = 48,
		/datum/thaumaturgical_essence/earth = 36,
		/datum/thaumaturgical_essence/air = 36,
		/datum/thaumaturgical_essence/life = 20,
	)

/datum/alch_cauldron_recipe/thornmorrow_tincture_potion
	recipe_name = "Thornmorrow Tincture"
	smells_like = "briars and undergrowth"
	output_reagents = list(/datum/reagent/medicine/thornmorrow_tincture = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/life = 36,
		/datum/thaumaturgical_essence/cycle = 48,
		/datum/thaumaturgical_essence/earth = 20,
	)

/datum/alch_cauldron_recipe/phlogiston_elasticum
	recipe_name = "Phlogiston Elasticum"
	smells_like = "crackling static and wind"
	output_reagents = list(/datum/reagent/drug/phlogiston_elasticum = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/air = 72,
		/datum/thaumaturgical_essence/motion = 48,
		/datum/thaumaturgical_essence/energia = 36,
		/datum/thaumaturgical_essence/chaos = 20,
	)

/datum/alch_cauldron_recipe/gravitum_elixir
	recipe_name = "Gravitum Elixir"
	smells_like = "wet clay and stone"
	output_reagents = list(/datum/reagent/drug/gravitum_elixir = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 84,
		/datum/thaumaturgical_essence/crystal = 36,
		/datum/thaumaturgical_essence/order = 36,
	)

/datum/alch_cauldron_recipe/subtilum_tincture
	recipe_name = "Subtilum Tincture"
	smells_like = "thin mountain air"
	output_reagents = list(/datum/reagent/drug/subtilum_tincture = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/void = 60,
		/datum/thaumaturgical_essence/air = 36,
		/datum/thaumaturgical_essence/chaos = 36,
		/datum/thaumaturgical_essence/magic = 20,
	)

/datum/alch_cauldron_recipe/sal_petris
	recipe_name = "Sal Petris"
	smells_like = "chalk dust and still air"
	output_reagents = list(/datum/reagent/sal_petris = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/earth = 72,
		/datum/thaumaturgical_essence/order = 72,
		/datum/thaumaturgical_essence/crystal = 36,
	)

/datum/alch_cauldron_recipe/cryzaline_suspension
	recipe_name = "Cryzaline Suspension"
	smells_like = "biting frost"
	output_reagents = list(/datum/reagent/cryzaline_suspension = 100)
	required_essences = list(
		/datum/thaumaturgical_essence/frost = 84,
		/datum/thaumaturgical_essence/water = 36,
		/datum/thaumaturgical_essence/crystal = 36,
		/datum/thaumaturgical_essence/chaos = 20,
	)
