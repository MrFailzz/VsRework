//-----------------------------------------------------
local PANIC = 0
local TANK = 1
local DELAY = 2
//-----------------------------------------------------

Msg("Initiating c2m4_minifinale\n");


DirectorOptions <-
{
	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 4

	PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
	MegaMobSize = 50
}