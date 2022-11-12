Msg("Beginning Lighthouse Scavenge.\n")

DirectorOptions <-
{
	CommonLimit = 15
	MobSpawnMinTime = 8
	MobSpawnMaxTime = 8
	MobMinSize = 5
	MobMaxSize = 8
	SustainPeakMinTime = 3
	SustainPeakMaxTime = 3
	IntensityRelaxThreshold = 0.90
	RelaxMinInterval = 5
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 400
	SpecialRespawnInterval = 30
	LockTempo = false
	PreferredMobDirection = SPAWN_ANYWHERE
	PanicForever = true
}

Director.ResetMobTimer()