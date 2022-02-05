/*
	SourcePawn is Copyright (C) 2006-2015 AlliedModders LLC.  All rights reserved.
	SourceMod is Copyright (C) 2006-2015 AlliedModders LLC.  All rights reserved.
	Pawn and SMALL are Copyright (C) 1997-2015 ITB CompuPhase.
	Source is Copyright (C) Valve Corporation.
	All trademarks are property of their respective owners.

	This program is free software: you can redistribute it and/or modify it
	under the terms of the GNU General Public License as published by the
	Free Software Foundation, either version 3 of the License, or (at your
	option) any later version.

	This program is distributed in the hope that it will be useful, but
	WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	General Public License for more details.

	You should have received a copy of the GNU General Public License along
	with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <left4dhooks>
#include <l4d2util_stocks>

#define SURVIVOR_RUNSPEED 220.0
#define TEAM_SURVIVORS 2
#define TEAM_INFECTED 3
#define Z_TANK 8
#define DEBUG 0

ConVar
	hCvarSdPistolMod,
	hCvarSdDeagleMod,
	hCvarSdUziMod,
	hCvarSdMacMod,
	hCvarSdMP5Mod,
	hCvarSdAkMod,
	hCvarSdM4Mod,
	hCvarSdScarMod,
	hCvarSdSG552Mod,
	hCvarSdPumpMod,
	hCvarSdChromeMod,
	hCvarSdAutoMod,
	hCvarSdSpasMod,
	hCvarSdRifleMod,
	hCvarSdScoutMod,
	hCvarSdAWPMod,
	hCvarSdMilitaryMod,
	hCvarSdGunfireSi,
	hCvarSdGunfireTank,
	hCvarSdDecay,
	hCvarSdDecayDelay,
	hCvarSdInwaterTank,
	hCvarSdInwaterSurvivor,
	hCvarSdInwaterDuringTank,
	hCvarSurvivorLimpspeed,
	hCvarTankSpeedVS,
	hCvarCrouchSpeedMod,
	hCvarJockeyMinMoundedSpeed;

Handle
	g_hSlowdownDecay,
	g_hSlowdownDecayEnable;

int
	iSurvLimpHealth;

float
	fTankWaterSpeed,
	fSurvWaterSpeed,
	fSurvWaterSpeedDuringTank,
	fTankRunSpeed,
	fCrouchSpeedMod,
	fJockeyMinMountedSpeed,
	fTankSlowdownBuildup,
	fSlowdownDecay,
	fSlowdownDecayDelay;

bool
	tankInPlay = false,
	bFoundCrouchTrigger = false,
	bPlayerInCrouchTrigger[MAXPLAYERS + 1],
	bSlowdownCanDecay;

public Plugin myinfo =
{
	name = "L4D2 Slowdown Control",
	author = "Visor, Sir, darkid, Forgetest, A1m`, Derpduck",
	version = "2.7.1",
	description = "Manages the water/gunfire slowdown for both teams",
	url = "https://github.com/SirPlease/L4D2-Competitive-Rework"
};

public void OnPluginStart()
{
	hCvarSdGunfireSi = CreateConVar("l4d2_slowdown_gunfire_si", "0.0", "[Likely broken due to modifications, dont use] Maximum slowdown from gunfire for SI (-1: native slowdown; 0.0: No slowdown, 0.01-1.0: 1%%-100%% slowdown)", _, true, -1.0, true, 1.0);
	hCvarSdGunfireTank = CreateConVar("l4d2_slowdown_gunfire_tank", "0.2", "Cap max slowdown to this percentage (-1: native slowdown; 0.0: No slowdown, >0.0 - 1.0: Stacking slowdown per hit up to this amount)", _, true, -1.0, true, 1.0);
	hCvarSdDecay = CreateConVar("l4d2_slowdown_decay", "0.05", "How quickly slowdown on tank decays (X%% per 0.25s)", _, true, 0.0, true, 100.0);
	hCvarSdDecayDelay = CreateConVar("l4d2_slowdown_decay_delay", "0.2", "How long before slowdown starts decaying in seconds", _, true, 0.0, true, 100.0);
	hCvarSdInwaterTank = CreateConVar("l4d2_slowdown_water_tank", "-1", "Maximum tank speed in the water (-1: ignore setting; 0: default; 210: default Tank Speed)", _, true, -1.0);
	hCvarSdInwaterSurvivor = CreateConVar("l4d2_slowdown_water_survivors", "-1", "Maximum survivor speed in the water outside of Tank fights (-1: ignore setting; 0: default; 220: default Survivor speed)", _, true, -1.0);
	hCvarSdInwaterDuringTank = CreateConVar("l4d2_slowdown_water_survivors_during_tank", "0", "Maximum survivor speed in the water during Tank fights (0: ignore setting; 220: default Survivor speed)", _, true, 0.0);
	hCvarCrouchSpeedMod = CreateConVar("l4d2_slowdown_crouch_speed_mod", "1.0", "Modifier of player crouch speed when inside a designated trigger, 75 is the defualt for everyone (1: default speed)", _, true, 0.0);
	
	hCvarSdPistolMod = CreateConVar("l4d2_slowdown_pistol_percent", "0.0033", "Pistols cause this much slowdown per hit");
	hCvarSdDeagleMod = CreateConVar("l4d2_slowdown_deagle_percent", "0.01", "Deagles cause this much slowdown per hit");
	hCvarSdUziMod = CreateConVar("l4d2_slowdown_uzi_percent", "0.004", "Unsilenced uzis cause this much slowdown per hit");
	hCvarSdMacMod = CreateConVar("l4d2_slowdown_mac_percent", "0.004", "Silenced Uzis cause this much slowdown per hit");
	hCvarSdMP5Mod = CreateConVar("l4d2_slowdown_mp5_percent", "0.004", "MP5s cause this much slowdown per hit");
	hCvarSdAkMod = CreateConVar("l4d2_slowdown_ak_percent", "0.004", "AKs cause this much slowdown per hit");
	hCvarSdM4Mod = CreateConVar("l4d2_slowdown_m4_percent", "0.004", "M4s cause this much slowdown per hit");
	hCvarSdScarMod = CreateConVar("l4d2_slowdown_scar_percent", "0.004", "Scars cause this much slowdown per hit");
	hCvarSdSG552Mod = CreateConVar("l4d2_slowdown_sg552_percent", "0.004", "SG552 cause this much slowdown per hit");
	hCvarSdPumpMod = CreateConVar("l4d2_slowdown_pump_percent", "0.01", "Pump Shotguns cause this much slowdown per hit");
	hCvarSdChromeMod = CreateConVar("l4d2_slowdown_chrome_percent", "0.01", "Chrome Shotguns cause this much slowdown per hit");
	hCvarSdAutoMod = CreateConVar("l4d2_slowdown_auto_percent", "0.01", "Auto Shotguns cause this much slowdown per hit");
	hCvarSdSpasMod = CreateConVar("l4d2_slowdown_spas_percent", "0.01", "Spas Shotguns cause this much slowdown per hit");
	hCvarSdRifleMod = CreateConVar("l4d2_slowdown_rifle_percent", "0.01", "Hunting Rifles cause this much slowdown per hit");
	hCvarSdScoutMod = CreateConVar("l4d2_slowdown_scout_percent", "0.01", "Scouts cause this much slowdown per hit");
	hCvarSdAWPMod = CreateConVar("l4d2_slowdown_awp_percent", "0.01", "AWPs cause this much slowdown per hit");
	hCvarSdMilitaryMod = CreateConVar("l4d2_slowdown_military_percent", "0.01", "Military Rifles cause this much slowdown per hit");

	hCvarSurvivorLimpspeed = FindConVar("survivor_limp_health");
	hCvarTankSpeedVS = FindConVar("z_tank_speed_vs");
	hCvarJockeyMinMoundedSpeed = FindConVar("z_jockey_min_mounted_speed");
	
	hCvarSdInwaterTank.AddChangeHook(OnConVarChanged);
	hCvarSdInwaterSurvivor.AddChangeHook(OnConVarChanged);
	hCvarSdInwaterDuringTank.AddChangeHook(OnConVarChanged);
	hCvarSurvivorLimpspeed.AddChangeHook(OnConVarChanged);
	hCvarTankSpeedVS.AddChangeHook(OnConVarChanged);
	hCvarJockeyMinMoundedSpeed.AddChangeHook(OnConVarChanged);
	hCvarCrouchSpeedMod.AddChangeHook(OnConVarChanged);

	HookEvent("tank_spawn", TankSpawn, EventHookMode_PostNoCopy);
	HookEvent("round_start", RoundStart, EventHookMode_PostNoCopy);
	HookEvent("player_hurt", PlayerHurt);
	HookEvent("player_death", TankDeath);
}

public void OnConfigsExecuted()
{
	CvarsToType();
}

public void OnConVarChanged(ConVar convar, const char[] oldValue, const char[] newValue)
{
	CvarsToType();
}

void CvarsToType()
{
	fTankWaterSpeed = hCvarSdInwaterTank.FloatValue;
	fSurvWaterSpeed = hCvarSdInwaterSurvivor.FloatValue;
	fSurvWaterSpeedDuringTank = hCvarSdInwaterDuringTank.FloatValue;
	iSurvLimpHealth = hCvarSurvivorLimpspeed.IntValue;
	fTankRunSpeed = hCvarTankSpeedVS.FloatValue;
	fCrouchSpeedMod = hCvarCrouchSpeedMod.FloatValue;
	fJockeyMinMountedSpeed = hCvarJockeyMinMoundedSpeed.FloatValue;
	fSlowdownDecay = hCvarSdDecay.FloatValue;
	fSlowdownDecayDelay = hCvarSdDecayDelay.FloatValue;
}

public void TankSpawn(Event event, const char[] name, bool dontBroadcast) 
{
	if (!tankInPlay) {
		tankInPlay = true;
		fTankSlowdownBuildup = 0.0;
		bSlowdownCanDecay = false;
		g_hSlowdownDecay = CreateTimer(0.25, Timer_SlowdownDecay, _, TIMER_REPEAT);
		if (fSurvWaterSpeedDuringTank > 0.0) {
			PrintToChatAll("\x05Water Slowdown\x01 has been reduced while Tank is in play.");
		}
	}
}

public void TankDeath(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	if (client > 0 && IsInfected(client) && IsTank(client)) {
		CreateTimer(0.1, Timer_CheckTank);
	}
}

public void OnClientDisconnect(int client)
{
	// Was a bot tank kicked
	if (client > 0 && IsInfected(client) && IsTank(client) && IsFakeClient(client)) {
		CreateTimer(0.1, Timer_CheckTank);
	}
}

public Action Timer_CheckTank(Handle timer)
{
	int tankclient = FindTankClient();
	if (!tankclient || !IsPlayerAlive(tankclient)) {
		tankInPlay = false;
		fTankSlowdownBuildup = 0.0;
		bSlowdownCanDecay = false;
		TimerCleanUp();
		if (fSurvWaterSpeedDuringTank > 0.0) {
			PrintToChatAll("\x05Water Slowdown\x01 has been restored to normal.");
		}
	}

	return Plugin_Stop;
}

public void RoundStart(Event event, const char[] name, bool dontBroadcast)
{
	tankInPlay = false;
	fTankSlowdownBuildup = 0.0;
	bSlowdownCanDecay = false;
	HookCrouchTriggers();
	TimerCleanUp();
}

// Hook trigger_multiple entities that are named "l4d2_slowdown_crouch_speed"
public void HookCrouchTriggers()
{
	bFoundCrouchTrigger = false;

	// Reset array
	for (int i = 1; i <= MaxClients; i++) {
		bPlayerInCrouchTrigger[i] = false;
	}

	int iEntity = -1;
	char targetname[128];

	while ((iEntity = FindEntityByClassname(iEntity, "trigger_multiple")) != -1) {
		GetEntPropString(iEntity, Prop_Data, "m_iName", targetname, sizeof(targetname));

		if (StrEqual(targetname, "l4d2_slowdown_crouch_speed", false)) {
			HookSingleEntityOutput(iEntity, "OnStartTouch", CrouchSpeedStartTouch);
			HookSingleEntityOutput(iEntity, "OnEndTouch", CrouchSpeedEndTouch);

			bFoundCrouchTrigger = true;
		}
	}
}

public void CrouchSpeedStartTouch(const char[] output, int caller, int activator, float delay)
{
	if (0 < activator <= MaxClients && IsClientInGame(activator)) {
		bPlayerInCrouchTrigger[activator] = true;
	}
}

public void CrouchSpeedEndTouch(const char[] output, int caller, int activator, float delay)
{
	if (0 < activator <= MaxClients && IsClientInGame(activator)) {
		bPlayerInCrouchTrigger[activator] = false;
	}
}

/**
 *
 * Slowdown from gunfire: Tank & SI
 *
**/
public void PlayerHurt(Event event, const char[] name, bool dontBroadcast)
{
	int client = GetClientOfUserId(GetEventInt(event, "userid"));
	if (client > 0 && IsInfected(client)) {
		float slowdown = IsTank(client) ? GetActualValue(hCvarSdGunfireTank) : GetActualValue(hCvarSdGunfireSi);
		
		// For tank we use a new slowdown method
		if (IsTank(client)){
			if (slowdown > 0.0) {
				int damage = GetEventInt(event, "dmg_health");
				char weapon[64];
				GetEventString(event, "weapon", weapon, sizeof(weapon));

				// We dont use scale anymore
				float scale;
				float modifier;
				GetScaleAndModifier(scale, modifier, weapon, damage);
				fTankSlowdownBuildup += modifier;

				// Pause decay
				bSlowdownCanDecay = false;
				delete g_hSlowdownDecayEnable;
				g_hSlowdownDecayEnable = null;
				if (g_hSlowdownDecayEnable == null){
					g_hSlowdownDecayEnable = CreateTimer(fSlowdownDecayDelay, Timer_SlowdownDecayEnable, _, TIMER_FLAG_NO_MAPCHANGE);
				}

				ApplySlowdown(client, fTankSlowdownBuildup, hCvarSdGunfireTank.FloatValue);
			}
		} else {
			// For SI use original
			if (slowdown == 1.0) {
				ApplySlowdown(client, slowdown, hCvarSdGunfireSi.FloatValue);
			} else if (slowdown > 0.0) {
				int damage = GetEventInt(event, "dmg_health");
				char weapon[64];
				GetEventString(event, "weapon", weapon, sizeof(weapon));

				float scale;
				float modifier;
				GetScaleAndModifier(scale, modifier, weapon, damage);
				ApplySlowdown(client, 1 - modifier * scale * slowdown, hCvarSdGunfireSi.FloatValue);
			}
		}
	}
}

public Action Timer_SlowdownDecayEnable(Handle hTimer)
{
	if (!tankInPlay){
		g_hSlowdownDecayEnable = null;
		return Plugin_Stop;
	}

	bSlowdownCanDecay = true;

	#if DEBUG
		PrintToChatAll("Decay Enabled");
	#endif

	g_hSlowdownDecayEnable = null;
	return Plugin_Stop;
}

public Action Timer_SlowdownDecay(Handle hTimer)
{
	if (!tankInPlay){
		g_hSlowdownDecay = null;
		return Plugin_Stop;
	}

	if (fTankSlowdownBuildup<=0.0){
		return Plugin_Continue;
	}

	if (bSlowdownCanDecay){
		fTankSlowdownBuildup -= fSlowdownDecay;
		ApplySlowdown(FindTankClient(), fTankSlowdownBuildup, hCvarSdGunfireTank.FloatValue);
	}

	return Plugin_Continue;
}

public void TimerCleanUp()
{
	if (g_hSlowdownDecay != null){
		delete g_hSlowdownDecay;
		g_hSlowdownDecay = null;
	}

	if (g_hSlowdownDecayEnable != null){
		delete g_hSlowdownDecayEnable;
		g_hSlowdownDecayEnable = null;
	}
}

/**
 *
 * Slowdown from water: Tank & Survivors
 *
**/
public Action L4D_OnGetRunTopSpeed(int client, float &retVal)
{
	if (!IsClientInGame(client)) { 
		return Plugin_Continue;
	}
	
	if (~GetEntityFlags(client) & FL_INWATER) {
		return Plugin_Continue;
	}
	
	switch (GetClientTeam(client)) {
		case TEAM_SURVIVORS: {
			// Speed of tongue victim isn't affected by water,
			// only decided by ConVar "tongue_victim_max_speed".
			if (GetEntPropEnt(client, Prop_Send, "m_tongueOwner") != -1) {
				return Plugin_Continue;
			}
			
			float fHealth = L4D_GetTempHealth(client) + GetClientHealth(client);
			
			// Jockey victim gets slowdown by water, while we're not slowing down them.
			if (GetEntPropEnt(client, Prop_Send, "m_jockeyAttacker") != -1) {
				// Additionally check for g_pGameRules->m_bWaterSlowdownEnabled?
				// Perhaps unnecessary due to what's going to be done.
				
				if ((tankInPlay && fSurvWaterSpeedDuringTank != 0.0) || fSurvWaterSpeed != -1.0) {
					// TODO: As a reminder when we decide to normalize speed of jockeyed survivors
					// Speed = 220.0 * max(HP Rate, z_jockey_min_mounted_speed)
					float fRate = fHealth / GetEntProp(client, Prop_Send, "m_iMaxHealth");
					retVal = SURVIVOR_RUNSPEED * (fRate > fJockeyMinMountedSpeed ? fRate : fJockeyMinMountedSpeed);
					return Plugin_Handled;
				}
				
				return Plugin_Continue;
			}
			
			// Adrenaline = Don't care, don't mess with it.
			// Limping = 260 speed (both in water and on the ground)
			// Healthy = 260 speed (both in water and on the ground)
			bool bAdrenaline = !!GetEntProp(client, Prop_Send, "m_bAdrenalineActive");
			if (bAdrenaline || RoundToFloor(fHealth) < iSurvLimpHealth) {
				return Plugin_Continue;
			}
			
			// speed of survivors in water during Tank fights
			if (tankInPlay) {
				if (fSurvWaterSpeedDuringTank == 0.0) {
					return Plugin_Continue; // Vanilla YEEEEEEEEEEEEEEEs
				} else {
					retVal = fSurvWaterSpeedDuringTank;
					return Plugin_Handled;
				}
			} else if (fSurvWaterSpeed != -1.0) { // speed of survivors in water outside of Tank fights
				// slowdown off
				if (fSurvWaterSpeed == 0.0) {
					retVal = SURVIVOR_RUNSPEED;
					return Plugin_Handled;
				} else { // specific speed
					retVal = fSurvWaterSpeed;
					return Plugin_Handled;
				}
			}
		}
		case TEAM_INFECTED: {
			if (IsTank(client)) {
				// Only bother the actual speed if player is a tank moving in water
				if (fTankWaterSpeed != -1.0) {
					// slowdown off
					if (fTankWaterSpeed == 0.0) {
						retVal = fTankRunSpeed;
						return Plugin_Handled;
					} else {// specific speed
						retVal = fTankWaterSpeed;
						return Plugin_Handled;
					}
				}
			}
		}
	}
	
	return Plugin_Continue;
}

/**
 *
 * Slowdown from crouching: All players
 *
**/
public Action L4D_OnGetCrouchTopSpeed(int client, float &retVal)
{
	if (fCrouchSpeedMod == 1.0 || !bFoundCrouchTrigger || !IsClientInGame(client)) {
		return Plugin_Continue;
	}

	if (bPlayerInCrouchTrigger[client]) {
		if (GetEntityFlags(client) & FL_ONGROUND) {
			retVal *= fCrouchSpeedMod; // 75 * modifier
			return Plugin_Handled;
		}
	}

	return Plugin_Continue;
}

// The old slowdown plugin's cvars weren't quite intuitive, so I'll try to fix it this time
float GetActualValue(ConVar cvar)
{
	float value = GetConVarFloat(cvar);
	if (value == -1.0) { // native slowdown
		return -1.0;
	}
	
	if (value == 0.0) { // slowdown off
		return 1.0;
	}
	
	return L4D2Util_ClampFloat(value, 0.001, 1.0); // slowdown multiplier
}

void ApplySlowdown(int client, float value, float maxValue)
{
	if (client == 0) {
		return;
	}
	
	if (value == -1.0) {
		return;
	}

	if (value < 0.0) {
		value = 0.0;
		fTankSlowdownBuildup = value;
	} else if (value > maxValue){
		value = maxValue;
		fTankSlowdownBuildup = value;
	}

	value = 1 - value;

	SetEntPropFloat(client, Prop_Send, "m_flVelocityModifier", value);

	#if DEBUG
		float vVel[3];
		float speed;
		GetEntPropVector(client, Prop_Data, "m_vecAbsVelocity", vVel);
		speed = GetVectorLength(vVel);
		PrintToChatAll("Slowdown: %f / Speed: %f",value,speed);
	#endif
}

void GetScaleAndModifier(float &scale, float &modifier, const char[] weapon, int damage)
{
	// If max slowdown is 20%, and tank takes 10 damage from a chrome shotgun shell, they recieve:
	//// 1 - .5 * 0.434 * .2 = 0.9566 -> 95.6% base speed, or 4.4% slowdown.
	// If max slowdown is 20%, and tank takes 6 damage from a silenced uzi bullet, they recieve:
	//// 1 - .8 * 0.0625 * .2 = 0.99 -> 99% base speed, or 1% slowdown.

	// Weapon  | Max | Min
	// Pistol  | 32  | 9
	// Deagle  | 78  | 19
	// Uzi     | 19  | 9
	// Mac     | 24  | 0 <- Deals no damage at long range.
	// AK      | 57  | 0 <- Deals no damage at long range.
	// M4      | 32  | 0
	// Scar    | 43  | 1
	// Pump    | 13  | 2
	// Chrome  | 15  | 2
	// Auto    | 19  | 2
	// Spas    | 23  | 3
	// HR      | 90  | 90 <- No fall-off
	// Scout   | 90  | 90 <- No fall-off
	// Military| 90  | 90 <- No fall-off
	// SMGs and Shotguns are using quadratic scaling, meaning that shooting long ranged is punished more harshly.
	float fDamage = float(damage);
	if (strcmp(weapon, "melee") == 0) {
		// Melee damage scales with tank health, so don't bother handling it here.
		scale = 1.0;
		modifier = 0.0;
	} else if (strcmp(weapon, "pistol") == 0) {
		scale = fScaleFloat(fDamage, 9.0, 32.0);
		modifier = GetConVarFloat(hCvarSdPistolMod);
	} else if (strcmp(weapon, "pistol_magnum") == 0) {
		scale = fScaleFloat(fDamage, 19.0, 78.0);
		modifier = GetConVarFloat(hCvarSdDeagleMod);
	} else if (strcmp(weapon, "smg") == 0) {
		scale = fScaleFloat2(fDamage, 9.0, 19.0);
		modifier = GetConVarFloat(hCvarSdUziMod);
	} else if (strcmp(weapon, "smg_silenced") == 0) {
		scale = fScaleFloat2(fDamage, 0.0, 24.0);
		modifier = GetConVarFloat(hCvarSdMacMod);
	} else if (strcmp(weapon, "smg_mp5") == 0) {
		scale = fScaleFloat2(fDamage, 0.0, 24.0); // Copy of silenced SMG
		modifier = GetConVarFloat(hCvarSdMP5Mod);
	} else if (strcmp(weapon, "rifle_ak47") == 0) {
		scale = fScaleFloat2(fDamage, 0.0, 57.0);
		modifier = GetConVarFloat(hCvarSdAkMod);
	} else if (strcmp(weapon, "rifle") == 0) {
		scale = fScaleFloat2(fDamage, 0.0, 32.0);
		modifier = GetConVarFloat(hCvarSdM4Mod);
	} else if (strcmp(weapon, "rifle_desert") == 0) {
		scale = fScaleFloat2(fDamage, 1.0, 43.0);
		modifier = GetConVarFloat(hCvarSdSG552Mod);
	} else if (strcmp(weapon, "rifle_sg552") == 0) {
		scale = fScaleFloat2(fDamage, 0.0, 32.0); // Copy of rifle
		modifier = GetConVarFloat(hCvarSdScarMod);
	} else if (strcmp(weapon, "pumpshotgun") == 0) {
		scale = fScaleFloat2(fDamage, 2.0, 13.0);
		modifier = GetConVarFloat(hCvarSdPumpMod);
	} else if (strcmp(weapon, "shotgun_chrome") == 0) {
		scale = fScaleFloat2(fDamage, 2.0, 15.0);
		modifier = GetConVarFloat(hCvarSdChromeMod);
	} else if (strcmp(weapon, "autoshotgun") == 0) {
		scale = fScaleFloat2(fDamage, 2.0, 19.0);
		modifier = GetConVarFloat(hCvarSdSpasMod);
	} else if (strcmp(weapon, "shotgun_spas") == 0) {
		scale = fScaleFloat2(fDamage, 3.0, 23.0);
		modifier = GetConVarFloat(hCvarSdAutoMod);
	} else if (strcmp(weapon, "hunting_rifle") == 0) {
		scale = fScaleFloat(fDamage, 90.0, 90.0);
		modifier = GetConVarFloat(hCvarSdRifleMod);
	} else if (strcmp(weapon, "sniper_scout") == 0) {
		scale = fScaleFloat(fDamage, 90.0, 90.0);
		modifier = GetConVarFloat(hCvarSdScoutMod);
	} else if (strcmp(weapon, "sniper_awp") == 0) {
		scale = fScaleFloat(fDamage, 90.0, 90.0); // Copy of AWP
		modifier = GetConVarFloat(hCvarSdAWPMod);
	} else if (strcmp(weapon, "sniper_military") == 0) {
		scale = fScaleFloat(fDamage, 90.0, 90.0);
		modifier = GetConVarFloat(hCvarSdMilitaryMod);
	} else {
		scale = 1.0;
		modifier = 0.0;
	}

	if (fDamage <= 1.0)
	{
		modifier = 0.0;
	}
}

int FindTankClient()
{
	for (int i = 1; i <= MaxClients; i++) {
		if (!IsInfected(i) || !IsTank(i) || !IsPlayerAlive(i)) {
			continue;
		}
		
		return i; // Found tank, return
	}
	return 0;
}

bool IsInfected(int client)
{
	return (IsClientInGame(client) && GetClientTeam(client) == TEAM_INFECTED);
}

bool IsTank(int client)
{
	return (GetEntProp(client, Prop_Send, "m_zombieClass") == Z_TANK);
}

float fScaleFloat(float inc, float low, float high)
{
	/*
	 * This macros has been removed because it is considered unsafe.
	 * Besides, there are problems when assembling in sourcemod 1.11.
	 * The compiler ignores the data type when assembling.
	 *
	 * Linear scale %0 between %1 and %2.
	 * #define SCALE(%0,%1,%2) CLAMP((%0-%1)/(%2-%1), 0.0, 1.0)
	*/
	float fCalculations = ((inc - low) / (high - low));
	return L4D2Util_ClampFloat(fCalculations, 0.0, 1.0);
}

float fScaleFloat2(float inc, float low, float high)
{
	/*
	 * This macros has been removed because it is considered unsafe.
	 * Besides, there are problems when assembling in sourcemod 1.11.
	 * The compiler ignores the data type when assembling.
	 *
	 * Quadratic scale %0 between %1 and %2
	* #define SCALE2(%0,%1,%2) SCALE(%0*%0, %1*%1, %2*%2)
	*/
	return fScaleFloat((inc * inc), (low * low), (high * high));
}
