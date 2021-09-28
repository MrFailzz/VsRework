Msg("Initiating Onslaught\n");

DirectorOptions <-
{
	// This turns off tanks and witches.
	ProhibitBosses = false

	MobSpawnMinTime = 10
	MobSpawnMaxTime = 10
	MobMinSize = 12
	MobMaxSize = 12
	MobMaxPending = 8
	SustainPeakMinTime = 1
	SustainPeakMaxTime = 3
	IntensityRelaxThreshold = 0.90
	RelaxMinInterval = 5
	RelaxMaxInterval = 5
	RelaxMaxFlowTravel = 1000
	PreferredMobDirection = SPAWN_IN_FRONT_OF_SURVIVORS
	AlwaysAllowWanderers = 1
	NumReservedWanderers = 10
	ZombieSpawnRange = 2000
}

Director.ResetMobTimer()

