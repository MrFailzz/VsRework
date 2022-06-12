
//-----------------------------------------------------
local PANIC = 0
local TANK = 1
local DELAY = 2
//-----------------------------------------------------

DirectorOptions <-
{
	//-----------------------------------------------------

	// 3 waves of mobs in between tanks

	 A_CustomFinale_StageCount = 8
	 
	 A_CustomFinale1 = PANIC
	 A_CustomFinaleValue1 = 1
	 
	 A_CustomFinale2 = DELAY
	 A_CustomFinaleValue2 = 10
	 
	 A_CustomFinale3 = TANK
	 A_CustomFinaleValue3 = 1
	 
	 A_CustomFinale4 = DELAY
	 A_CustomFinaleValue4 = 10
	 
	 A_CustomFinale5 = PANIC
	 A_CustomFinaleValue5 = 1
	 
	 A_CustomFinale6 = DELAY
	 A_CustomFinaleValue6 = 10
	 
	 A_CustomFinale7 = TANK
	 A_CustomFinaleValue7 = 1
	 
	 A_CustomFinale8 = DELAY
	 A_CustomFinaleValue8 = 15
	 
	 
	HordeEscapeCommonLimit = 15
	CommonLimit = 20
	EscapeSpawnTanks = false
	SpecialRespawnInterval = 80
}


if ( "DirectorOptions" in LocalScript && "ProhibitBosses" in LocalScript.DirectorOptions )
{
	delete LocalScript.DirectorOptions.ProhibitBosses
}

/*
*/

function EnableEscapeTanks()
{
	printl( "Chase Tanks Enabled!" );
	
	MapScript.DirectorOptions.EscapeSpawnTanks <- true
}