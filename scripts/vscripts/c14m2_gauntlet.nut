Msg("Beginning Lighthouse Scavenge.\n")

DirectorOptions <-
{
	CommonLimit = 10
	MobSpawnMinTime = 8
	MobSpawnMaxTime = 12
	MobSpawnSize = 5
	MobMaxPending = 8
	IntensityRelaxThreshold = 0.80
	RelaxMinInterval = 15
	RelaxMaxInterval = 15
	SpecialRespawnInterval = 30
	LockTempo = false
	PreferredMobDirection = SPAWN_ANYWHERE
	PanicForever = true
}

Director.ResetMobTimer();