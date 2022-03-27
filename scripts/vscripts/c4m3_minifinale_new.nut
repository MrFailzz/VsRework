//-----------------------------------------------------
local PANIC = 0
local TANK = 1
local DELAY = 2
//-----------------------------------------------------

Msg("Initiating c4m3_minifinale\n");


DirectorOptions <-
{
	PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
	PreferredSpecialDirection = SPAWN_BEHIND_SURVIVORS
	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 1
}