#pragma semicolon 1
#pragma newdecls required;

#include <sourcemod>
#include <sdktools>
#define L4D2UTIL_STOCKS_ONLY 1
#include <l4d2util>

#define TEAM_SURVIVOR 2

ConVar hCvarReloadSpeedUzi;
ConVar hCvarReloadSpeedSilencedSmg;
ConVar hCvarReloadSpeedMP5SMG;
ConVar hCvarReloadSpeedScoutSniper;
ConVar hCvarReloadSpeedAWPSniper;
ConVar hCvarReloadSpeedHuntingRifle;
ConVar hCvarReloadSpeedMilitarySniper;
ConVar hCvarReloadSpeedAK47Rifle;
ConVar hCvarReloadSpeedDesertRifle;
ConVar hCvarReloadSpeedRifle;
ConVar hCvarReloadSpeedSG552Rifle;								  

public Plugin myinfo =
{
	name = "L4D2 SMG Reload Speed Tweaker",
	description = "Allows cvar'd control over the reload durations for both types of SMG",
	author = "Visor",
	version = "1.1.1",
	url = "https://github.com/SirPlease/L4D2-Competitive-Rework/"
};

public void OnPluginStart()
{
	hCvarReloadSpeedUzi = CreateConVar("l4d2_reload_speed_uzi", "0", "Reload duration of Uzi(normal SMG)", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedSilencedSmg = CreateConVar("l4d2_reload_speed_silenced_smg", "0", "Reload duration of Silenced SMG", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedMP5SMG = CreateConVar("l4d2_reload_speed_mp5_smg", "0", "Reload duration of MP5 SMG", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);	
	hCvarReloadSpeedScoutSniper = CreateConVar("l4d2_reload_speed_scout_sniper", "0", "Reload duration of Scout Sniper", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedAWPSniper = CreateConVar("l4d2_reload_speed_awp_sniper", "0", "Reload duration of AWP Sniper", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedHuntingRifle = CreateConVar("l4d2_reload_speed_hunting_rifle", "0", "Reload duration of Hunting Rifle", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedMilitarySniper = CreateConVar("l4d2_reload_speed_military_rifle", "0", "Reload duration of Military Rifle", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedAK47Rifle = CreateConVar("l4d2_reload_speed_ak47_rifle", "0", "Reload duration of Ak47 Rifle", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedDesertRifle = CreateConVar("l4d2_reload_speed_desert_rifle", "0", "Reload duration of Desert Rifle", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedRifle = CreateConVar("l4d2_reload_speed_rifle", "0", "Reload duration of Rifle", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	hCvarReloadSpeedSG552Rifle = CreateConVar("l4d2_reload_speed_sg552_rifle", "0", "Reload duration of SG552 Rifle", FCVAR_CHEAT|FCVAR_NOTIFY, true, 0.0, true, 10.0);
	
	HookEvent("weapon_reload", OnWeaponReload, EventHookMode_Post);
}

public void OnWeaponReload(Event hEvent, const char[] eName, bool dontBroadcast)
{
	int client = GetClientOfUserId(hEvent.GetInt("userid"));

	if (client < 1 || !IsSurvivor(client) || !IsPlayerAlive(client) || IsFakeClient(client)) {
		return;
	}
	
	float originalReloadDuration = 0.0, alteredReloadDuration = 0.0;

	int weapon = GetPlayerWeaponSlot(client, 0);
	int weaponId = IdentifyWeapon(weapon);

	switch (weaponId) {
		case WEPID_SMG: {
			originalReloadDuration = 2.25;
			alteredReloadDuration = hCvarReloadSpeedUzi.FloatValue;
		}
		case WEPID_SMG_SILENCED: {
			originalReloadDuration = 2.25;
			alteredReloadDuration = hCvarReloadSpeedSilencedSmg.FloatValue;
		}
		case WEPID_SMG_MP5: {
			originalReloadDuration = 3.05;
			alteredReloadDuration = hCvarReloadSpeedMP5SMG.FloatValue;
		}			
		case WEPID_SNIPER_SCOUT: {
			originalReloadDuration = 2.9;
			alteredReloadDuration = hCvarReloadSpeedScoutSniper.FloatValue;
		}
		case WEPID_SNIPER_AWP: {
			originalReloadDuration = 3.65;
			alteredReloadDuration = hCvarReloadSpeedAWPSniper.FloatValue;
		}
		case WEPID_HUNTING_RIFLE: {
			originalReloadDuration = 3.125;
			alteredReloadDuration = hCvarReloadSpeedHuntingRifle.FloatValue;
		}
		case WEPID_SNIPER_MILITARY: {
			originalReloadDuration = 3.3;
			alteredReloadDuration = hCvarReloadSpeedMilitarySniper.FloatValue;
		}		
		case WEPID_RIFLE_AK47: {
			originalReloadDuration = 2.35;
			alteredReloadDuration = hCvarReloadSpeedAK47Rifle.FloatValue;
		}		
		case WEPID_RIFLE_DESERT: {
			originalReloadDuration = 3.3;
			alteredReloadDuration = hCvarReloadSpeedDesertRifle.FloatValue;
		}
		case WEPID_RIFLE: {
			originalReloadDuration = 2.2;
			alteredReloadDuration = hCvarReloadSpeedRifle.FloatValue;
		}		
		case WEPID_RIFLE_SG552: {
			originalReloadDuration = 3.4;
			alteredReloadDuration = hCvarReloadSpeedSG552Rifle.FloatValue;
		}
		default: {
			return;
		}
	}
	
	if (alteredReloadDuration <= 0.0) {
		return;
	}

	float oldNextAttack = GetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", 0);
	float newNextAttack = oldNextAttack - originalReloadDuration + alteredReloadDuration;
	float playbackRate = originalReloadDuration / alteredReloadDuration;
	
	SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", newNextAttack);
	SetEntPropFloat(client, Prop_Send, "m_flNextAttack", newNextAttack);
	SetEntPropFloat(weapon, Prop_Send, "m_flPlaybackRate", playbackRate);
}

public Action OnPlayerRunCmd(int client, int &buttons)
{
	if (!(buttons & IN_ATTACK2)) {
		return Plugin_Continue;
	}
	
	if (!IsSurvivor(client) || !IsPlayerAlive(client) || IsFakeClient(client)) {
		return Plugin_Continue;
	}
	
	float originalReloadDuration = 0.0, alteredReloadDuration = 0.0;
	
	int weapon = GetPlayerWeaponSlot(client, 0);
	int weaponId = IdentifyWeapon(weapon);

	switch (weaponId) {
		case WEPID_SMG: {
			originalReloadDuration = 2.25;
			alteredReloadDuration = hCvarReloadSpeedUzi.FloatValue;
		}
		case WEPID_SMG_SILENCED: {
			originalReloadDuration = 2.25;
			alteredReloadDuration = hCvarReloadSpeedSilencedSmg.FloatValue;
		}
		case WEPID_SMG_MP5: {
			originalReloadDuration = 3.05;
			alteredReloadDuration = hCvarReloadSpeedMP5SMG.FloatValue;
		}		
		case WEPID_SNIPER_SCOUT: {
			originalReloadDuration = 2.9;
			alteredReloadDuration = hCvarReloadSpeedScoutSniper.FloatValue;
		}
		case WEPID_SNIPER_AWP: {
			originalReloadDuration = 3.65;
			alteredReloadDuration = hCvarReloadSpeedAWPSniper.FloatValue;
		}
		case WEPID_HUNTING_RIFLE: {
			originalReloadDuration = 3.125;
			alteredReloadDuration = hCvarReloadSpeedHuntingRifle.FloatValue;
		}
		case WEPID_SNIPER_MILITARY: {
			originalReloadDuration = 3.3;
			alteredReloadDuration = hCvarReloadSpeedMilitarySniper.FloatValue;
		}			
		case WEPID_RIFLE_AK47: {
			originalReloadDuration = 2.35;
			alteredReloadDuration = hCvarReloadSpeedAK47Rifle.FloatValue;
		}		
		case WEPID_RIFLE_DESERT: {
			originalReloadDuration = 3.3;
			alteredReloadDuration = hCvarReloadSpeedDesertRifle.FloatValue;
		}
		case WEPID_RIFLE: {
			originalReloadDuration = 2.2;
			alteredReloadDuration = hCvarReloadSpeedRifle.FloatValue;
		}		
		case WEPID_RIFLE_SG552: {
			originalReloadDuration = 3.4;
			alteredReloadDuration = hCvarReloadSpeedSG552Rifle.FloatValue;
		}
		default: {
			return Plugin_Continue;
		}
	}

	float playbackRate = originalReloadDuration / alteredReloadDuration;
	SetEntPropFloat(weapon, Prop_Send, "m_flPlaybackRate", playbackRate);
	
	return Plugin_Continue;
}
