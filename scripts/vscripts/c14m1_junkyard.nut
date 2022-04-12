//-----------------------------------------------------
//
//
//-----------------------------------------------------
Msg("Initiating c14m1_junkyard script\n");

JunkyardCommonLimit <- 25	// use a lower common limit to combat infected related perf issues

if ( Director.IsPlayingOnConsole() )
{
	JunkyardCommonLimit <- 25
}


DirectorOptions <-
{
	CommonLimit = JunkyardCommonLimit	
}
