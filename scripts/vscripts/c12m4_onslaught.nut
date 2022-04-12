Msg("Initiating Onslaught\n");

DirectorOptions <-
{
	CommonLimit = 30
	MobSpawnMinTime = 10
	MobSpawnMaxTime = 15
	MobSpawnSize = 30
	MobMaxPending = 20
	ZombieSpawnRange = 2000
	PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
	PreferredSpecialDirection = SPAWN_IN_FRONT_OF_SURVIVORS
	LockTempo = false
	PanicForever = true
}

Director.ResetMobTimer();