//-----------------------------------------------------
//
//
//-----------------------------------------------------
Msg("SQUIRREL c14m1_junkyard script\n");

JunkyardCommonLimit <- 20	// use a lower common limit to combat infected related perf issues

if ( Director.IsPlayingOnConsole() )
{
	JunkyardCommonLimit <- 20
}


DirectorOptions <-
{
	CommonLimit = JunkyardCommonLimit	
}
