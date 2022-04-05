//-----------------------------------------------------
local PANIC = 0
local TANK = 1
local DELAY = 2
local ONSLAUGHT = 3
//-----------------------------------------------------

Msg("Initiating c2m5_minifinale\n");

local spawnedTank = false


DirectorOptions <-
{
	A_CustomFinale_StageCount = 9

	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 1
	A_CustomFinale2 = PANIC
	A_CustomFinaleValue2 = 1
	A_CustomFinale3 = DELAY
	A_CustomFinaleValue3 = 10
	A_CustomFinale4 = DELAY
	A_CustomFinaleValue4 = 5	

	PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
}

function OnBeginCustomFinaleStage( num, type )
{
	if ( developer() > 0 )
		printl( "Beginning custom finale stage " + num + " of type " + type );

	if ( num == 3 && spawnedTank == false)
	{
		spawnedTank = true
		EntFire( "spawn_door_tank_versus", "SpawnZombie" );
		EntFire( "director", "EndScript" );
	}
}