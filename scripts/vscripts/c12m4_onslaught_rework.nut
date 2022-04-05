Msg("Initiating Onslaught\n");

DirectorOptions <-
{
	// This turns off tanks and witches.
	ProhibitBosses = true

	MobSpawnMinTime = 5
	MobSpawnMaxTime = 10
	MobMinSize = 20
	MobMaxSize = 20
	SustainPeakMinTime = 1
	SustainPeakMaxTime = 3
	IntensityRelaxThreshold = 0.90
	RelaxMinInterval = 1
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 500
	PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
}

Director.ResetMobTimer()


