#ifndef ABSOLUTE_MINIMUM_MODE
#include "map_files\shared\CentCom.dmm" //this MUST be loaded no matter what for SSmapping's multi-z to work correctly
#else
#include "map_files\shared\CentCom_minimal.dmm"
#endif

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS // I cry
		#include "map_files/domotan/old_doma_lowpop.dmm"
		#include "map_files/domotan/north_northeast.dmm"
		#include "map_files/domotan/north_northwest.dmm"
		#include "map_files/domotan/north_southeast.dmm"
		#include "map_files/domotan/north_southwest.dmm"
		#include "map_files/domotan/south_northeast.dmm"
		#include "map_files/domotan/south_northwest.dmm"
		#include "map_files/domotan/south_southeast.dmm"
		#include "map_files/domotan/south_southwest.dmm"
		#include "map_files/domotan/east_north.dmm"
		#include "map_files/domotan/east_south.dmm"
		#include "map_files/domotan/west_north.dmm"
		#include "map_files/domotan/west_south.dmm"
	#endif
	#ifdef ALL_TEMPLATES
		#include "templates.dm"
	#endif
#endif
