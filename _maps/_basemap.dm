#ifndef ABSOLUTE_MINIMUM_MODE
#include "map_files\shared\CentCom.dmm" //this MUST be loaded no matter what for SSmapping's multi-z to work correctly
#else
#include "map_files\shared\CentCom_minimal.dmm"
#endif

#ifndef LOWMEMORYMODE
	#ifdef ALL_MAPS // I cry
		#include "map_files/domotan/old_doma_lowpop.dmm"
		#include "map_files/debug/roguetest.dmm"
		#include "map_files/domotan/north/northeast.dmm"
		#include "map_files/domotan/north/northwest.dmm"
		#include "map_files/domotan/north/southeast.dmm"
		#include "map_files/domotan/north/southwest.dmm"
		#include "map_files/domotan/south/northeast.dmm"
		#include "map_files/domotan/south/northwest.dmm"
		#include "map_files/domotan/south/southeast.dmm"
		#include "map_files/domotan/south/southwest.dmm"
		#include "map_files/domotan/east/north.dmm"
		#include "map_files/domotan/east/south.dmm"
		#include "map_files/domotan/west/north.dmm"
		#include "map_files/domotan/west/south.dmm"
		#include "map_files/domotan/necropolis_l1_dermus.dmm"
		#include "map_files/domotan/necropolis_l2_capillary.dmm"
	#endif
	#ifdef ALL_TEMPLATES
		#include "templates.dm"
	#endif
#endif
