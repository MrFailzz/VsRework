#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>
#include <sdktools_sound>

#define PLUGIN_VERSION "1.4"
#define DANG "ui/pickup_secret01.wav"

bool g_FinaleStarted;

public Plugin myinfo = 
{
	name = "L4D2 Tank Announcer",
	author = "Visor, Forgetest, xoxo",
	description = "Announce in chat and via a sound when a Tank has spawned",
	version = PLUGIN_VERSION,
	url = "https://github.com/SirPlease/L4D2-Competitive-Rework"
};

public void OnPluginStart()
{
	HookEvent("finale_radio_start", Event_FinaleStart);
	g_FinaleStarted = false;
}

public void OnMapStart()
{
	PrecacheSound(DANG);
}

public Action Event_FinaleStart(Event event, const char[] name, bool dontBroadcast)
{
	g_FinaleStarted = true;
}

public void L4D_OnSpawnTank_Post(int client, const float vecPos[3], const float vecAng[3])
{
	EmitSoundToAll(DANG);

	SpawnHintTarget(client, vecPos);

}

public void SpawnHintTarget(int client, const float vecPos[3])
{
	//Create hint target
	int iHintTargetEntity = CreateEntityByName("info_target_instructor_hint");
	char sHintTargetName[32] = "_tank_announce_hint_target";
	DispatchKeyValue(iHintTargetEntity, "targetname", sHintTargetName);
	DispatchSpawn(iHintTargetEntity);
	SetEntPropString(iHintTargetEntity, Prop_Data, "m_iName", sHintTargetName);

	//Set its position
	//On normal maps, spawns at tank's position. On finales spawn at radio's positiob
	float fTargetOrigin[3];

	fTargetOrigin = vecPos;

	//Detect finale, if it exists set hint position to radio entity
	if (g_FinaleStarted == true)
	{
		int triggerFinale = -1;
		while ((triggerFinale = FindEntityByClassname(triggerFinale, "trigger_finale")) != -1)
		{
			GetEntPropVector(triggerFinale, Prop_Send, "m_vecOrigin", fTargetOrigin);
		}
	}

	TeleportEntity(iHintTargetEntity, fTargetOrigin, NULL_VECTOR, NULL_VECTOR);

	//Spawn the hint after a delay
	CreateTimer(3.0, SpawnHint, _, TIMER_FLAG_NO_MAPCHANGE);
}

public Action SpawnHint(Handle timer)
{
	//hint_target, hint_timeout, hint_icon_offset, hint_range, hint_static, hint_nooffscreen, hint_icon_onscreen, hint_icon_offscreen,
	//hint_binding, hint_forcecaption, hint_color, hint_caption
	//See https://developer.valvesoftware.com/wiki/Env_instructor_hint
	DisplayInstructorHint("_tank_announce_hint_target", 10.0, 0.0, 0.0, 1.0, 0.0, "zombie_team_tank", "zombie_team_tank", "", 1.0, {255, 255, 255}, "Be ready to fight the Tank");
	//tip_tank = You are becoming tank icon
	//zombie_team_tank = Tank with rock silloutte icon

	//Alternative method
	/*Handle event = CreateEvent("instructor_server_hint_create", true);
	SetEventString(event, "hint_name", "RandomHint");
	SetEventString(event, "hint_replace_key", "RandomHint");
	SetEventInt(event, "hint_target", "_tank_announce_hint_target");
	SetEventInt(event, "hint_activator_userid", 0);
	SetEventInt(event, "hint_timeout", 10 );
	SetEventString(event, "hint_icon_onscreen", "tip_tank");
	SetEventString(event, "hint_icon_offscreen", "tip_tank");
	SetEventString(event, "hint_caption", "Be ready to fight the Tank");
	SetEventString(event, "hint_activator_caption", "Be ready to fight the Tank");
	SetEventString(event, "hint_color", "255 255 255");
	SetEventFloat(event, "hint_icon_offset", 0.0 );
	SetEventFloat(event, "hint_range", 0.0 );
	SetEventInt(event, "hint_flags", 1);// Change it..
	SetEventString(event, "hint_binding", "");
	SetEventBool(event, "hint_allow_nodraw_target", true);
	SetEventBool(event, "hint_nooffscreen", false);
	SetEventBool(event, "hint_forcecaption", false);
	SetEventBool(event, "hint_local_player_only", false);
	FireEvent(event);*/

	return Plugin_Stop;
}

stock void DisplayInstructorHint(char[] iTargetEntity, float fTime, float fHeight, float fRange, float bFollow, float bShowOffScreen, char[] sIconOnScreen, char[] sIconOffScreen, char[] sCmd, float bShowTextAlways, int iColor[3], char sText[100])  
{
	//Instructor hint
	int iEntity = CreateEntityByName("env_instructor_hint");

	if(iEntity <= 0)
	{
		return;
	}

	char sBuffer[32];
	//FormatEx(sBuffer, sizeof(sBuffer), "%d", iTargetEntity);
	FormatEx(sBuffer, sizeof(sBuffer), "%s", iTargetEntity);

	// Target
	//DispatchKeyValue(iTargetEntity, "targetname", sBuffer);
	DispatchKeyValue(iEntity, "hint_target", sBuffer);

	// Static
	FormatEx(sBuffer, sizeof(sBuffer), "%f", !bFollow);
	DispatchKeyValue(iEntity, "hint_static", sBuffer);

	// Timeout
	FormatEx(sBuffer, sizeof(sBuffer), "%f", RoundToFloor(fTime));
	DispatchKeyValue(iEntity, "hint_timeout", sBuffer);
	if(fTime > 0.0)
	{
		RemoveEntity2(iEntity, fTime);
	}

	// Height
	FormatEx(sBuffer, sizeof(sBuffer), "%f", RoundToFloor(fHeight));
	DispatchKeyValue(iEntity, "hint_icon_offset", sBuffer);

	// Range
	FormatEx(sBuffer, sizeof(sBuffer), "%f", RoundToFloor(fRange));
	DispatchKeyValue(iEntity, "hint_range", sBuffer);

	// Show off screen
	FormatEx(sBuffer, sizeof(sBuffer), "%f", !bShowOffScreen);
	DispatchKeyValue(iEntity, "hint_nooffscreen", sBuffer);

	// Icons
	DispatchKeyValue(iEntity, "hint_icon_onscreen", sIconOnScreen);
	DispatchKeyValue(iEntity, "hint_icon_offscreen", sIconOffScreen);

	// Command binding
	DispatchKeyValue(iEntity, "hint_binding", sCmd);

	// Show text behind walls
	FormatEx(sBuffer, sizeof(sBuffer), "%f", bShowTextAlways);
	DispatchKeyValue(iEntity, "hint_forcecaption", sBuffer);

	// Text color
	FormatEx(sBuffer, sizeof(sBuffer), "%d %d %d", iColor[0], iColor[1], iColor[2]);
	DispatchKeyValue(iEntity, "hint_color", sBuffer);

	//Text
	ReplaceString(sText, sizeof(sText), "\n", " ");
	DispatchKeyValue(iEntity, "hint_caption", sText);

	DispatchSpawn(iEntity);
	AcceptEntityInput(iEntity, "ShowHint");
}

stock void RemoveEntity2(int entity, float time = 0.0)
{
	if (time == 0.0)
	{
		if (IsValidEntity(entity))
		{
			char edictname[32];
			GetEdictClassname(entity, edictname, 32);

			if (!StrEqual(edictname, "player")){
				AcceptEntityInput(entity, "kill");
			}
		}
	}
	else if(time > 0.0)
	{
		CreateTimer(time, RemoveEntity2Timer, EntIndexToEntRef(entity), TIMER_FLAG_NO_MAPCHANGE);
	}
}

public Action RemoveEntity2Timer(Handle Timer, any entityRef)
{
	int entity = EntRefToEntIndex(entityRef);
	if (entity != INVALID_ENT_REFERENCE)
	{
		RemoveEntity2(entity); // RemoveEntity2(...) is capable of handling references
	}

	return (Plugin_Stop);
}