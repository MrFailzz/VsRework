//-----------------------------------------------------
//
//
//-----------------------------------------------------
Msg("Initiating c11m5_runway_finale script\n");

//-----------------------------------------------------
ERROR		<- -1
PANIC 		<- 0
TANK 		<- 1
DELAY 		<- 2
SCRIPTED 	<- 3
//-----------------------------------------------------

StageDelay <- 0
PreEscapeDelay <- 0
if ( Director.GetGameModeBase() == "coop" || Director.GetGameModeBase() == "realism" )
{
	StageDelay <- 5
	PreEscapeDelay <- 5
}
else if ( Director.GetGameModeBase() == "versus" )
{
	StageDelay <- 10
	PreEscapeDelay <- 15
}

DirectorOptions <-
{	
	A_CustomFinale_StageCount = 8
	
	A_CustomFinale1 		= PANIC
	A_CustomFinaleValue1 	= 1
	A_CustomFinale2 		= DELAY
	A_CustomFinaleValue2 	= StageDelay
	A_CustomFinale3 		= TANK
	A_CustomFinaleValue3 	= 1
	A_CustomFinale4 		= DELAY
	A_CustomFinaleValue4 	= StageDelay
	A_CustomFinale5 		= PANIC
	A_CustomFinaleValue5 	= 2
	A_CustomFinaleMusic5 	= "Event.FinaleWave4"
	A_CustomFinale6 		= DELAY
	A_CustomFinaleValue6 	= StageDelay
	A_CustomFinale7 		= TANK
	A_CustomFinaleValue7 	= 1
	A_CustomFinale8 		= DELAY
	A_CustomFinaleValue8 	= PreEscapeDelay
	
	TankLimit = 1
	WitchLimit = 0
	CommonLimit = 30
	HordeEscapeCommonLimit = 15
	EscapeSpawnTanks = false
	//SpecialRespawnInterval = 80
	
	MusicDynamicMobSpawnSize = 8
	MusicDynamicMobStopSize = 2
	MusicDynamicMobScanStopSize = 1
}

function OnBeginCustomFinaleStage( num, type )
{
	//printl( "Beginning custom finale stage " + num + " of type " + type );
	
	if ( type == 2 )
		EntFire( "orator_plane_radio", "SpeakResponseConcept", "plane_radio_intransit" );
}

function EnableEscapeTanks()
{
	printl( "Chase Tanks Enabled!" );
	
	MapScript.DirectorOptions.EscapeSpawnTanks <- true
}