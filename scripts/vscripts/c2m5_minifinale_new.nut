//-----------------------------------------------------
local PANIC = 0
local TANK = 1
local DELAY = 2
//-----------------------------------------------------

Msg("Initiating c2m5_minifinale\n");


DirectorOptions <-
{
	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 2
	
	PreferredMobDirection = SPAWN_LARGE_VOLUME
	PreferredSpecialDirection = SPAWN_LARGE_VOLUME
}