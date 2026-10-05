/datum/job/advclass/bandit/brigand/on_roundstart(mob/living/carbon/human/spawned, client/player_client)
	. = ..()
	var/static/list/weapons = list(
		"Battleaxe & Cudgel" = list(/obj/item/weapon/axe/battle, /obj/item/weapon/mace/cudgel),
		"Flail & Shield" = list(/obj/item/weapon/shield/wood, /obj/item/weapon/flail),
		"Glaive" = list(/obj/item/weapon/polearm/halberd/bardiche/glaive),
		"Warhammer & Shield" = list(/obj/item/weapon/shield/heater, /obj/item/weapon/mace/warhammer),
		"Maul" = list(/obj/item/weapon/mace/goden/maul),
		"Claws" = list(/obj/item/weapon/handclaw)
	)
	var/weapon_choice = tgui_input_list(player_client,"CHOOSE YOUR WEAPON.", "ARMS TO SLAY THE OPPRESSORS", weapons)
	switch(weapon_choice)
		if("Battleaxe & Cudgel")
			spawned.put_in_hands(new /obj/item/weapon/axe/battle)
			spawned.put_in_hands(new /obj/item/weapon/mace/cudgel)
		if("Flail & Shield")
			spawned.put_in_hands(new /obj/item/weapon/shield/wood)
			spawned.put_in_hands(new /obj/item/weapon/flail)
		if("Glaive")
			spawned.put_in_hands(new /obj/item/weapon/polearm/halberd/bardiche/glaive)
		if("Warhammer & Shield")
			spawned.put_in_hands(new /obj/item/weapon/shield/heater)
			spawned.put_in_hands(new /obj/item/weapon/mace/warhammer)
		if("Maul")
			spawned.put_in_hands(new /obj/item/weapon/mace/goden/maul)
		if("Claws")
			spawned.put_in_hands(new /obj/item/weapon/handclaw)
			spawned.attributes?.add_sheet(/datum/attribute_holder/sheet/job/brigand/unarmed)

	spawned.select_equippable(player_client, weapons, message = "Choose your weapon.", title = "TAKE UP ARMS.")
