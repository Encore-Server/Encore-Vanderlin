/datum/repeatable_crafting_recipe/arcyne
	abstract_type = /datum/repeatable_crafting_recipe/arcyne
	skillcraft = /datum/attribute/skill/magic/arcane
	craftdiff = 0
	category = "Arcyne"
	allow_inverse_start = TRUE

/datum/repeatable_crafting_recipe/arcyne/mana_chalk
	name = "mana infused chalk"
	requirements = list(
		/obj/item/ore/cinnabar = 1,
	)
	reagent_requirements = list(
		/datum/reagent/medicine/manapot/weak = 15,
	)
	starting_atom = /obj/item/ore/cinnabar
	attacked_atom = /obj/item/reagent_containers/glass
	output = /obj/item/chalk
	output_amount = 1
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/arcyne/mana_chalk_natural
	name = "natural mana infused chalk"
	requirements = list(
		/obj/item/reagent_containers/powder/manabloom = 1,
		/obj/item/mana_battery/mana_crystal/small = 1
	)
	starting_atom = /obj/item/reagent_containers/powder/manabloom
	attacked_atom = /obj/item/mana_battery/mana_crystal/small
	output = /obj/item/chalk/natural
	output_amount = 1
	craft_time = 1 SECONDS
	subtypes_allowed = TRUE

/datum/repeatable_crafting_recipe/arcyne/ritechalk
	name = "ritual chalk"
	output = /obj/item/ritechalk
	output_amount = 1
	requirements = list(
		/obj/item/reagent_containers/lux = 1,
		/obj/item/natural/stone = 1,
		/obj/item/fertilizer/ash = 1,
		/obj/item/reagent_containers/powder/herbs = 1,
	)
	starting_atom = /obj/item/reagent_containers/lux
	attacked_atom = /obj/item/natural/stone
	allow_inverse_start = TRUE
	craft_time = 4 SECONDS
	craftdiff = 0
	subtypes_allowed = TRUE
	crafting_message = "mixes life with the elements"
	skillcraft = /datum/attribute/skill/magic/ritual
