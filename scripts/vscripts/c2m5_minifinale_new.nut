//-----------------------------------------------------
local PANIC = 0
local TANK = 1
local DELAY = 2
//-----------------------------------------------------

Msg("Initiating c2m5_minifinale\n");

local spawnedTank = false


DirectorOptions <-
{
	PreferredMobDirection = SPAWN_NO_PREFERENCE
	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 2
	A_CustomFinale2 = DELAY
	A_CustomFinaleValue2 = 10
	A_CustomFinale3 = DELAY
	A_CustomFinaleValue3 = 5	
}

function OnBeginCustomFinaleStage( num, type )
{
	if ( developer() > 0 )
		printl( "Beginning custom finale stage " + num + " of type " + type );

	if ( num == 3 && spawnedTank == false)
	{
		EntFire( "spawn_door_tank_versus", "SpawnZombie" );
		spawnedTank = true
	}
}