// Note: The Exe just says SCB, not Steam, and not the full game name.
state("SCB", "Current")
{
	float timer: "UnityPlayer.dll", 0x01CFE860, 0x138, 0x260, 0x50, 0x180, 0x0, 0xB8, 0x0;
}

state("SCB", "1.029")
{
	float timer: "UnityPlayer.dll", 0x01D1C1F0, 0x160, 0x38, 0xA8, 0x68, 0x28, 0x128, 0xFA0;
}

state("SCB", "1.015")
{
	float timer: "GameAssembly.dll", 0x033863E0, 0xD0, 0x48, 0x90, 0x3C0, 0x40, 0xB8, 0x0;
}

startup
{
	settings.Add("split_on_collectibles", false, "This setting is currently broken");
	if (timer.CurrentTimingMethod == TimingMethod.RealTime)
    {
        var answer = MessageBox.Show(
            "Hai :3, LiveSplit is currently comparing against real time. " +
            "However, this auto-splitter kinda requires comparing against game time.\n\n" +
            "Do you wanna switch now?",
            "SCB auto-splitter",
            MessageBoxButtons.YesNo);

        if (answer == DialogResult.Yes)
            timer.CurrentTimingMethod = TimingMethod.GameTime;
    }
}

// The timer
gameTime
{
	return TimeSpan.FromSeconds(current.timer);
}
// Loading or Pauses
isLoading
{
	if(current.timer == old.timer && current.timer != 0)
		return true;
	return false;
}
// Resetting
reset
{
	if(current.timer == 0 && current.timer == old.timer)
		return true;
	return false;
}
// Starting
start
{
	if(old.timer == 0 && current.timer != 0)
		return true;
}
// Collectible splits
split
{
	if(settings["split_on_collectibles"] && current.flagrante == (old.flagrante + 1))
		return true;
	if(settings["split_on_collectibles"] && current.quantum == (old.quantum + 1))
		return true;
}
