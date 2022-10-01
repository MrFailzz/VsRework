Msg("Beginning Lighthouse Scavenge.\n")

DirectorOptions <-
{
	CommonLimit = 10
	MobSpawnMinTime = 8
	MobSpawnMaxTime = 12
	MobSpawnSize = 5
	MobMaxPending = 8
	IntensityRelaxThreshold = 0.99
	RelaxMinInterval = 5
	RelaxMaxInterval = 5
	SpecialRespawnInterval = 30
	LockTempo = false
	PreferredMobDirection = SPAWN_ANYWHERE
	PanicForever = true
}

Director.ResetMobTimer();