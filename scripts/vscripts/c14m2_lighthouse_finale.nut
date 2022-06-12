Msg("Initiating c14m2_lighthouse_finale script\n");

StageDelay <- 15
PreEscapeDelay <- 10

PANIC <- 0
TANK <- 1
DELAY <- 2
ONSLAUGHT <- 3
//-----------------------------------------------------

SharedOptions <-
{
 	A_CustomFinale1 = PANIC
	A_CustomFinaleValue1 = 1

	A_CustomFinale2 = DELAY
	A_CustomFinaleValue2 = 15

	A_CustomFinale3 = DELAY
	A_CustomFinaleValue3 = 10
        
	A_CustomFinale4 = PANIC
	A_CustomFinaleValue4 = 1

	A_CustomFinale5 = DELAY
	A_CustomFinaleValue5 = 10

	A_CustomFinale6 = PANIC
	A_CustomFinaleValue6 = 1

	A_CustomFinale7 = DELAY
	A_CustomFinaleValue7 = 10
 
 	A_CustomFinale8 = TANK
	A_CustomFinaleValue8 = 1

	A_CustomFinale9 = DELAY
	A_CustomFinaleValue9 = 15
 
 	A_CustomFinale10 = PANIC
	A_CustomFinaleValue10 = 1

	A_CustomFinale11 = DELAY
	A_CustomFinaleValue11 = 10

	A_CustomFinale12 = PANIC
	A_CustomFinaleValue12 = 1
        
 	A_CustomFinale13 = DELAY
	A_CustomFinaleValue13 = 10
        
	A_CustomFinale14 = TANK
	A_CustomFinaleValue14 = 1   
        
 	A_CustomFinale15 = DELAY
	A_CustomFinaleValue15 = 15
        
	A_CustomFinale16 = PANIC
	A_CustomFinaleValue16 = 1  
                  
 	A_CustomFinale17 = DELAY
	A_CustomFinaleValue17 = 10  
                       
 	A_CustomFinale18 = PANIC
	A_CustomFinaleValue18 = 1  
	
 	A_CustomFinale19 = DELAY
	A_CustomFinaleValue19 = 10
        
	A_CustomFinale20 = PANIC
	A_CustomFinaleValue20 = 1   
        
 	A_CustomFinale21 = DELAY
	A_CustomFinaleValue21 = 10
        
	A_CustomFinale22 = TANK
	A_CustomFinaleValue22 = 1  
                  
 	A_CustomFinale23 = DELAY
	A_CustomFinaleValue23 = 15  
                       
 	A_CustomFinale24 = PANIC
	A_CustomFinaleValue24 = 1
															
 	A_CustomFinale25 = DELAY
	A_CustomFinaleValue25 = 10
        
	A_CustomFinale26 = PANIC
	A_CustomFinaleValue26 = 1   
        
 	A_CustomFinale27 = DELAY
	A_CustomFinaleValue27 = 10
        
	A_CustomFinale28 = PANIC
	A_CustomFinaleValue28 = 1  
                  
 	A_CustomFinale29 = DELAY
	A_CustomFinaleValue29 = 10 
                       
 	A_CustomFinale30 = PANIC
	A_CustomFinaleValue30 = 1

 	A_CustomFinale31 = DELAY
	A_CustomFinaleValue31 = 10
                      
	//-----------------------------------------------------

	PreferredMobDirection = SPAWN_BEHIND_SURVIVORS
	PreferredSpecialDirection = SPAWN_LARGE_VOLUME

	ProhibitBosses = true
	ZombieSpawnRange = 3000
	MobRechargeRate = 0.5
	HordeEscapeCommonLimit = 15
	BileMobSize = 15
	
	MusicDynamicMobSpawnSize = 8
	MusicDynamicMobStopSize = 2
	MusicDynamicMobScanStopSize = 1
}

PanicOptions <-
{

	MegaMobSize = 50
	
	CommonLimit = 20
	
	SpecialRespawnInterval = 40
}

TankOptions <-
{
	ShouldAllowMobsWithTank = false
	ShouldAllowSpecialsWithTank = true
	
	SpecialRespawnInterval = 60
}


DirectorOptions <- clone SharedOptions
{
}

//-----------------------------------------------------

// number of cans needed to escape.
NumCansNeeded <- 10

local difficulty = GetDifficulty();

//-----------------------------------------------------
//      INIT
//-----------------------------------------------------

GasCansTouched          <- 0
GasCansPoured           <- 0
DelayTouchedOrPoured    <- 0
DelayPoured             <- 0

EntFire( "progress_display", "SetTotalItems", NumCansNeeded )

//-----------------------------------------------------

function SpawnScavengeCans( difficulty )
{
	local function SpawnCan( gascan )
	{
		local can_origin = gascan.GetOrigin();
		local can_angles = gascan.GetAngles();
		gascan.Kill();
		
		local kvs =
		{
			angles = can_angles.ToKVString()
			body = 0
			disableshadows = 1
			glowstate = 3
			model = "models/props_junk/gascan001a.mdl"
			skin = 2
			weaponskin = 2
			solid = 0
			spawnflags = 2
			targetname = "scavenge_gascans"
			origin = can_origin.ToKVString()
			connections =
			{
				OnItemPickedUp =
				{
					cmd1 = "directorRunScriptCodeDirectorScript.MapScript.LocalScript.GasCanTouched()0-1"
				}
			}
		}
		local can_spawner = SpawnEntityFromTable( "weapon_scavenge_item_spawn", kvs );
		if ( can_spawner )
			DoEntFire( "!self", "SpawnItem", "", 0, null, can_spawner );
	}
	
	switch( difficulty )
	{
		case 3:
		{
			local gascan = null;
			while ( gascan = Entities.FindByName( gascan, "gascans_finale_expert" ) )
			{
				if ( gascan.IsValid() )
					SpawnCan( gascan );
			}
		}
		case 2:
		{
			local gascan = null;
			while ( gascan = Entities.FindByName( gascan, "gascans_finale_advanced" ) )
			{
				if ( gascan.IsValid() )
					SpawnCan( gascan );
			}
		}
		case 1:
		{
			local gascan = null;
			while ( gascan = Entities.FindByName( gascan, "gascans_finale_normal" ) )
			{
				if ( gascan.IsValid() )
					SpawnCan( gascan );
			}
		}
		case 0:
		{
			local gascan = null;
			while ( gascan = Entities.FindByName( gascan, "gascans_finale_easy" ) )
			{
				if ( gascan.IsValid() )
					SpawnCan( gascan );
			}
			break;
		}
		default:
			break;
	}
	
	EntFire( "gascans_finale_*", "Kill" );
}

switch( difficulty )
{
	case 0:
	{
		EntFire( "relay_outro_easy", "Enable" );
		break;
	}
	case 1:
	{
		EntFire( "relay_outro_normal", "Enable" );
		break;
	}
	case 2:
	{
		EntFire( "relay_outro_advanced", "Enable" );
		break;
	}
	case 3:
	{
		EntFire( "relay_outro_expert", "Enable" );
		break;
	}
	default:
		break;
}

function GasCanPoured()
{
    GasCansPoured++
    DelayPoured++
    Msg(" Poured: " + GasCansPoured + "\n")

	if ( GasCansPoured == 1 )
		EntFire( "explain_fuel_generator", "Kill" );
	else if ( GasCansPoured == NumCansNeeded )
	{
		if ( developer() > 0 )
			Msg(" needed: " + NumCansNeeded + "\n");
		EntFire( "relay_start_boat", "Trigger", "", 45 )
		EntFire( "relay_generator_ready", "Trigger", "", 0.1 );
		EntFire( "weapon_scavenge_item_spawn", "TurnGlowsOff" );
		EntFire( "weapon_scavenge_item_spawn", "Kill" );
	}

    EvalGasCansPouredOrTouched()
}

//-----------------------------------------------------

function AddTableToTable( dest, src )
{
	foreach( key, val in src )
	{
		dest[key] <- val
	}
}

function OnBeginCustomFinaleStage( num, type )
{
	printl( "Beginning custom finale stage " + num + " of type " + type );
	
	local waveOptions = null
	if ( num == 2 )
	{
		EntFire( "relay_boat_coming2", "Trigger" );
		// Delay lasts 10 seconds, next stage turns off lights immediately
		EntFire( "lighthouse_light", "SetPattern", "mmamammmmammamamaaamammma", 7.0 );
		EntFire( "lighthouse_light", "SetPattern", "", 9.5 );
		EntFire( "lighthouse_light", "TurnOff", "", 10 );
		EntFire( "spotlight_beams", "LightOff", "", 7.0 );
		EntFire( "spotlight_glow", "HideSprite", "", 7.0 );
		EntFire( "brush_light", "Enable", "", 7.0 );
		EntFire( "spotlight_beams", "LightOn", "", 7.5 );
		EntFire( "spotlight_glow", "ShowSprite", "", 7.5 );
		EntFire( "brush_light", "Disable", "", 7.5 );
		EntFire( "spotlight_beams", "LightOff", "", 8.0 );
		EntFire( "spotlight_glow", "HideSprite", "", 8.0 );
		EntFire( "brush_light", "Enable", "", 8.0 );
		EntFire( "spotlight_beams", "LightOn", "", 8.5 );
		EntFire( "spotlight_glow", "ShowSprite", "", 8.5 );
		EntFire( "brush_light", "Disable", "", 8.5 );
	}
	else if ( type == PANIC )
	{
		waveOptions = PanicOptions
	}
	else if ( type == TANK )
	{
		waveOptions = TankOptions
	}
	else if ( num == 3 )
	{
		EntFire( "relay_lighthouse_off", "Trigger" );
		SpawnScavengeCans( difficulty );
	}
	
	//---------------------------------


	MapScript.DirectorOptions.clear()
	

	AddTableToTable( MapScript.DirectorOptions, SharedOptions );

	if ( waveOptions != null )
	{
		AddTableToTable( MapScript.DirectorOptions, waveOptions );
	}
	
	
	Director.ResetMobTimer()
	
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
	}
}