//-----------------------------------------------------
local PANIC = 0
local TANK = 1
local DELAY = 2
//-----------------------------------------------------

Msg("Initiating c4m3_minifinale\n");


DirectorOptions <-
{
	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 1

	PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
}