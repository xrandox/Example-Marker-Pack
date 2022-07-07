# Example-Marker-Pack

This pack is meant to be a guide/follow-along for new pack makers to get their feet on the ground. Eventually I plan to have a video/series of videos to go along with it but for now it will just be with text.

## Getting Started

### Useful Tools
* [TacO](https://www.gw2taco.com/) - Right now BHUD does not have its own editor so while I recommend using packs in BHUD, TacO is required to create them. For small creators, you could potentially get away with JUST TacO, but some of the other tools may make your life easier. I mainly use TacO for marker placement and editing.
* [BlishHUD](https://blishhud.com/) - BHUD is a modular overlay with a UI that meshes beautifully with the game. It has many cool modules that provide different useful features. Some useful modules to pick up:
    * Mumble Info - This provides a TON of information that is exposed via MumbleLink. For us, the most useful thing is the coordinates of the player.
    * Pathing - This is what provides the marker pack support.
* [Notepad++](https://notepad-plus-plus.org/downloads/) - Think of this as a fancier version of notepad. It has nice things like syntax highlighting, a very extensive find and replace feature, and a ton of other things that you will probably never use. Fantastic for small-scale XML editing. 
* [TrlTool]() - This is a small program created by FreeSnow to help edit trails manually. Insert Map = New trail segment. Insert Vector = New point on the trail. Insert vector is hardcoded to `;`. Takes some getting used to as there is no immediate feedback on your screen, you have to save and then import into TacO to see it. But I personally prefer it over TacO's record feature.
* [build.bat]() - This is a small batch file I created that allows you to quickly zip up your XML and data folder and rename it to a .taco. Just need to edit it to your own file names. Totally not necessary, I'm just lazy and got tired of constantly zipping and renaming my stuff.
* [Visual Studio Code](https://code.visualstudio.com/) - This is an more advanced editor that can be paired with Github Desktop to allow for better version control. If you plan to distribute your pack I highly recommend setting up a repo for it and using VSC and GHD to make your life a lot easier.
* [Github Desktop](https://desktop.github.com/) - Again, this is a tool to help make repo management less intimidating to those who have never worked with repo's before. I won't be going super in-depth with how to set up a repo and use this, but there is plenty of documentation out there if you just look around.
