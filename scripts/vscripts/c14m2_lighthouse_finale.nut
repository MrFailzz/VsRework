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

	A_CustomFinale2 = PANIC
	A_CustomFinaleValue2 = 1

	A_CustomFinale3 = ONSLAUGHT
	A_CustomFinaleValue3 = "c14m2_delay"
        
	A_CustomFinale4 = PANIC
	A_CustomFinaleValue4 = 1

	A_CustomFinale5 = ONSLAUGHT
	A_CustomFinaleValue5 = "c14m2_delay"

	A_CustomFinale6 = TANK
	A_CustomFinaleValue6 = 1

	A_CustomFinale7 = ONSLAUGHT
	A_CustomFinaleValue7 = "c14m2_delay"
 
 	A_CustomFinale8 = PANIC
	A_CustomFinaleValue8 = 1

	A_CustomFinale9 = ONSLAUGHT
	A_CustomFinaleValue9 = "c14m2_delay"
 
 	A_CustomFinale10 = PANIC
	A_CustomFinaleValue10 = 1

	A_CustomFinale11 = ONSLAUGHT
	A_CustomFinaleValue11 = "c14m2_delay"

	A_CustomFinale12 = PANIC
	A_CustomFinaleValue12 = 1
        
 	A_CustomFinale13 = ONSLAUGHT
	A_CustomFinaleValue13 = "c14m2_delay"
        
	A_CustomFinale14 = TANK
	A_CustomFinaleValue14 = 1   
        
 	A_CustomFinale15 = ONSLAUGHT
	A_CustomFinaleValue15 = "c14m2_delay"
        
	A_CustomFinale16 = PANIC
	A_CustomFinaleValue16 = 1  
                  
 	A_CustomFinale17 = ONSLAUGHT
	A_CustomFinaleValue17 = "c14m2_delay"    
                       
 	A_CustomFinale18 = PANIC
	A_CustomFinaleValue18 = 1  
	
 	A_CustomFinale19 = ONSLAUGHT
	A_CustomFinaleValue19 = "c14m2_delay"
        
	A_CustomFinale20 = PANIC
	A_CustomFinaleValue20 = 1   
        
 	A_CustomFinale21 = ONSLAUGHT
	A_CustomFinaleValue21 = "c14m2_delay"
        
	A_CustomFinale22 = TANK
	A_CustomFinaleValue22 = 1  
                  
 	A_CustomFinale23 = ONSLAUGHT
	A_CustomFinaleValue23 = "c14m2_delay"    
                       
 	A_CustomFinale24 = PANIC
	A_CustomFinaleValue24 = 1
															
 	A_CustomFinale25 = ONSLAUGHT
	A_CustomFinaleValue25 = "c14m2_delay"
        
	A_CustomFinale26 = PANIC
	A_CustomFinaleValue26 = 1   
        
 	A_CustomFinale27 = ONSLAUGHT
	A_CustomFinaleValue27 = "c14m2_delay"
        
	A_CustomFinale28 = PANIC
	A_CustomFinaleValue28 = 1  
                  
 	A_CustomFinale29 = ONSLAUGHT
	A_CustomFinaleValue29 = "c14m2_delay"    
                       
 	A_CustomFinale30 = PANIC
	A_CustomFinaleValue30 = 1

 	A_CustomFinale31 = ONSLAUGHT
	A_CustomFinaleValue31 = "c14m2_delay"
                      
	//-----------------------------------------------------

	PreferredMobDirection = SPAWN_LARGE_VOLUME
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

	MegaMobSize = 0 // randomized in OnBeginCustomFinaleStage
	MegaMobMinSize = 20
	MegaMobMaxSize = 30
	
	CommonLimit = 12
	
	SpecialRespawnInterval = 40
}

TankOptions <-
{
	ShouldAllowMobsWithTank = true
	ShouldAllowSpecialsWithTank = true

	MobSpawnMinTime = 10
	MobSpawnMaxTime = 20
	MobMinSize = 2
	MobMaxSize = 3

	CommonLimit = 5
	
	SpecialRespawnInterval = 60
}


DirectorOptions <- clone SharedOptions
{
}

//-----------------------------------------------------

// number of cans needed to escape.
NumCansNeeded <- 10

// duration of delay stage.
DelayMin <- 10
DelayMax <- 20

// Number of touches and/or pours allowed before a delay is aborted.
DelayPourThreshold <- 1
DelayTouchedOrPouredThreshold <- 2


// Once the delay is aborted, amount of time before it progresses to next stage.
AbortDelayMin <- 1
AbortDelayMax <- 3

// Number of touches and pours it takes to transition out of c1m4_finale_wave_1
GimmeThreshold <- 4


// console overrides
if ( Director.IsPlayingOnConsole() )
{
	DelayMin <- 20
	DelayMax <- 30
	
	// Number of touches and/or pours allowed before a delay is aborted.
	DelayPourThreshold <- 2
	DelayTouchedOrPouredThreshold <- 4
	
	TankOptions.ShouldAllowSpecialsWithTank = false
	
}

local difficulty = GetDifficulty();

//-----------------------------------------------------
//      INIT
//-----------------------------------------------------

GasCansTouched          <- 0
GasCansPoured           <- 0
DelayTouchedOrPoured    <- 0
DelayPoured             <- 0

EntFire( "timer_delay_end", "LowerRandomBound", DelayMin )
EntFire( "timer_delay_end", "UpperRandomBound", DelayMax )
EntFire( "timer_delay_abort", "LowerRandomBound", AbortDelayMin )
EntFire( "timer_delay_abort", "UpperRandomBound", AbortDelayMax )

EntFire( "progress_display", "SetTotalItems", NumCansNeeded )

function AbortDelay(){}  	// only defined during a delay, in c14m2_delay.nut
function EndDelay(){}		// only defined during a delay, in c14m2_delay.nut

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

function GasCanTouched()
{
    GasCansTouched++
    Msg(" Touched: " + GasCansTouched + "\n")   
     
    EvalGasCansPouredOrTouched()    
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

function EvalGasCansPouredOrTouched()
{
    TouchedOrPoured <- GasCansPoured + GasCansTouched
    Msg(" Poured or touched: " + TouchedOrPoured + "\n")

    DelayTouchedOrPoured++
    Msg(" DelayTouchedOrPoured: " + DelayTouchedOrPoured + "\n")
    Msg(" DelayPoured: " + DelayPoured + "\n")
    
    if (( DelayTouchedOrPoured >= DelayTouchedOrPouredThreshold ) || ( DelayPoured >= DelayPourThreshold ))
    {
        AbortDelay()
    }
    
    switch( TouchedOrPoured )
    {
        case GimmeThreshold:
            EntFire( "director", "EndCustomScriptedStage" )
            break
    }
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
		waveOptions.MegaMobSize = PanicOptions.MegaMobMinSize + rand()%( PanicOptions.MegaMobMaxSize - PanicOptions.MegaMobMinSize )
		
		Msg("*************************" + waveOptions.MegaMobSize + "\n")
		
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