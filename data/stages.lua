-- Minlevel and multiplier are MANDATORY
-- Maxlevel is OPTIONAL, but is considered infinite by default
-- Create a stage with minlevel 1 and no maxlevel to disable stages
experienceStages = {
	{
		minlevel = 1,
		maxlevel = 8,
		multiplier = 5,
	},
	{
		minlevel = 9,
		multiplier = 2,
    }
}

skillsStages = {
	{
		minlevel = 10,
		multiplier = 1,
	},
	
}

magicLevelStages = {
	{
		minlevel = 0,
		multiplier = 1,
	},
	
}
