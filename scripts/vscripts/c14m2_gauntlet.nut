Msg("Initiating Onslaught\n");

DirectorOptions <-
{
	CommonLimit = 25
	MobSpawnMinTime = 20
	MobSpawnMaxTime = 30
	MobSpawnSize = 25
	MobMaxPending = 15
	ZombieSpawnRange = 3000
	PreferredMobDirection = SPAWN_LARGE_VOLUME
	PreferredSpecialDirection = SPAWN_LARGE_VOLUME
	LockTempo = false
	PanicForever = true
}

Director.ResetMobTimer();