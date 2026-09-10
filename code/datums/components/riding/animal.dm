/datum/component/riding/creature/pig/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list(0, 4, OBJ_LAYER),
		TEXT_SOUTH = list(0, 4, ABOVE_MOB_LAYER),
		TEXT_EAST = list(-2, 4, OBJ_LAYER),
		TEXT_WEST = list(2, 4, OBJ_LAYER)
	)

/datum/component/riding/creature/gator/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return  list(
		TEXT_NORTH = list(0, 25, OBJ_LAYER),
		TEXT_SOUTH = list(2, 25, OBJ_LAYER),
		TEXT_EAST = list(8, 20, OBJ_LAYER),
		TEXT_WEST = list(0, 20, OBJ_LAYER)
	)

/datum/component/riding/creature/direbear/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list(16, 14, OBJ_LAYER),
		TEXT_SOUTH = list(12, 8, OBJ_LAYER),
		TEXT_EAST = list(7, 12, OBJ_LAYER),
		TEXT_WEST = list(14, 12, OBJ_LAYER)
	)

/datum/component/riding/creature/mole/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return  list(
		TEXT_NORTH = list(6, 25, OBJ_LAYER),
		TEXT_SOUTH = list(12, 25, ABOVE_MOB_LAYER),
		TEXT_EAST = list(15, 25, OBJ_LAYER),
		TEXT_WEST = list(30, 25, OBJ_LAYER)
	)

/datum/component/riding/creature/gote/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list(0, 6, OBJ_LAYER),
		TEXT_SOUTH = list(0, 6, OBJ_LAYER),
		TEXT_EAST = list(-2, 6, OBJ_LAYER),
		TEXT_WEST = list(2, 6, OBJ_LAYER)
	)

/datum/component/riding/creature/pig/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list(0, 4, OBJ_LAYER),
		TEXT_SOUTH = list(0, 4, ABOVE_MOB_LAYER),
		TEXT_EAST = list(-2, 4, OBJ_LAYER),
		TEXT_WEST = list(2, 4, OBJ_LAYER)
	)

/datum/component/riding/creature/saiga/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	if(pass_index >= 2)
		return list(
			TEXT_NORTH = list(0, 2, ABOVE_MOB_LAYER),
			TEXT_SOUTH = list(0, 14, OBJ_LAYER),
			TEXT_EAST = list(-8, 6, OBJ_LAYER),
			TEXT_WEST = list(8, 6, OBJ_LAYER)
		)
	return list(
		TEXT_NORTH = list(0, 8, OBJ_LAYER),
		TEXT_SOUTH = list(0, 8, ABOVE_MOB_LAYER),
		TEXT_EAST = list(-2, 8, OBJ_LAYER),
		TEXT_WEST = list(2, 8, OBJ_LAYER)
	)

/datum/component/riding/creature/saiga/driver_move(atom/movable/movable_parent, mob/living/user, direction, actual_move_delay)
	var/atom/movable/ridden = parent
	if(LAZYLEN(ridden.buckled_mobs) && ridden.buckled_mobs[1] != user)
		if(COOLDOWN_FINISHED(src, vehicle_move_cooldown))
			to_chat(user, span_warning("I am a passenger on [ridden]. I am not steering."))
			COOLDOWN_START(src, vehicle_move_cooldown, 1.5 SECONDS)
		return COMPONENT_DRIVER_BLOCK_MOVE
	return ..()

/datum/component/riding/creature/equestria/get_rider_offsets_and_layers(pass_index, mob/offsetter)
	return list(
		TEXT_NORTH = list(0, 0, OBJ_LAYER),
		TEXT_SOUTH = list(0, 4, ABOVE_MOB_LAYER),
		TEXT_EAST = list(0, 4, OBJ_LAYER),
		TEXT_WEST = list(0, 4, OBJ_LAYER)
	)
