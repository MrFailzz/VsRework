Msg("Initiating c2m5_concert_finale rework script\n");

//-----------------------------------------------------------------------------

PANIC <- 0
TANK <- 1
DELAY <- 2
ONSLAUGHT <- 3

//-----------------------------------------------------------------------------

SharedOptions <-
{
	A_CustomFinale_StageCount = 8
	A_CustomFinale1 = DELAY
	A_CustomFinaleValue1 = 0
	A_CustomFinale2 = DELAY
	A_CustomFinaleValue2 = 0
	A_CustomFinale3 = DELAY
	A_CustomFinaleValue3 = 0
	A_CustomFinale4 = DELAY
	A_CustomFinaleValue4 = 0
 	A_CustomFinale5 = PANIC
	A_CustomFinaleValue5 = 1
 	A_CustomFinale5 = PANIC
	A_CustomFinaleValue5 = 1
	A_CustomFinale6 = DELAY
	A_CustomFinaleValue6 = 15
	A_CustomFinale7 = TANK
	A_CustomFinaleValue7 = 1
	A_CustomFinaleMusic7 = ""
	A_CustomFinale8 = DELAY
	A_CustomFinaleValue8 = 15
	
	PreferredMobDirection = SPAWN_LARGE_VOLUME
	PreferredSpecialDirection = SPAWN_LARGE_VOLUME
	ShouldConstrainLargeVolumeSpawn = false

	ZombieSpawnRange = 3000
	
	SpecialRespawnInterval = 20
}

InitialPanicOptions <-
{
	ShouldConstrainLargeVolumeSpawn = true
}


PanicOptions <-
{
	CommonLimit = 25
}

TankOptions <-
{
	ShouldAllowSpecialsWithTank = true
	SpecialRespawnInterval = 30
}


DirectorOptions <- clone SharedOptions
{
}

//-----------------------------------------------------------------------------

function AddTableToTable( dest, src )
{
	foreach( key, val in src )
	{
		dest[key] <- val
	}
}

//-----------------------------------------------------------------------------

function OnBeginCustomFinaleStage( num, type )
{
	if ( developer() > 0 )
	{
		printl("========================================================");
		printl( "Beginning custom finale stage " + num + " of type " + type );
	}

	local waveOptions = null
	if ( num == 1 )
	{
		waveOptions = InitialPanicOptions
	}
	else if ( type == PANIC )
	{
		waveOptions = PanicOptions
		if ( "MegaMobMinSize" in PanicOptions )
		{
			waveOptions.MegaMobSize <- RandomInt( PanicOptions.MegaMobMinSize, MegaMobMaxSize )
		}
	}
	else if ( type == TANK )
	{
		waveOptions = TankOptions
	}
	
	//---------------------------------

	MapScript.DirectorOptions.clear()

	AddTableToTable( MapScript.DirectorOptions, SharedOptions );

	if ( waveOptions != null )
	{
		AddTableToTable( MapScript.DirectorOptions, waveOptions );
	}

	//---------------------------------

	if ( developer() > 0 )
	{
		Msg( "\n*****\nMapScript.DirectorOptions:\n" );
		foreach( key, value in MapScript.DirectorOptions )
		{
			Msg( "    " + key + " = " + value + "\n" );
		}

		if ( LocalScript.rawin( "DirectorOptions" ) )
		{
			Msg( "\n*****\nLocalScript.DirectorOptions:\n" );
			foreach( key, value in LocalScript.DirectorOptions )
			{
				Msg( "    " + key + " = " + value + "\n" );
			}
		}
		printl("========================================================");
	}
}