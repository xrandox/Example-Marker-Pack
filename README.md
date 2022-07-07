# Example-Marker-Pack

This pack is meant to be a guide/follow-along for new pack makers to get their feet on the ground. Eventually I plan to have a video/series of videos to go along with it but for now it will just be with text.

**Contents**
* [Getting Started](#getting-started)
   * [Useful Tools](#useful-tools)
   * [Understanding A Marker Pack](#understanding-a-marker-pack)
   * [Making a Useable XML](#making-a-useable-xml)
   * [Using Your Categories in TacO](#using-your-categories-in-taco)
* [Markers 101](#markers-101)

## Getting Started

### Useful Tools
* [TacO](https://www.gw2taco.com/) - Right now BHUD does not have its own editor so while I recommend using packs in BHUD, TacO is required to create them. For small creators, you could potentially get away with JUST TacO, but some of the other tools may make your life easier. I mainly use TacO for marker placement and editing.
* [BlishHUD](https://blishhud.com/) - BHUD is a modular overlay with a UI that meshes beautifully with the game. It has many cool modules that provide different useful features. Some useful modules to pick up:
    * Mumble Info - This provides a TON of information that is exposed via MumbleLink. For us, the most useful thing is the coordinates of the player.
    * Pathing - This is what provides the marker pack support.
* [Notepad++](https://notepad-plus-plus.org/downloads/) - Think of this as a fancier version of notepad. It has nice things like syntax highlighting, a very extensive find and replace feature, and a ton of other things that you will probably never use. Fantastic for small-scale XML editing. 
* [TrlTool](https://github.com/xrandox/Example-Marker-Pack/raw/main/TrlTool.exe) - This is a small program created by FreeSnow to help edit trails manually. Insert Map = New trail segment. Insert Vector = New point on the trail. Insert vector is hardcoded to `;`. Takes some getting used to as there is no immediate feedback on your screen, you have to save and then import into TacO to see it. But I personally prefer it over TacO's record feature.
* [build.bat](https://github.com/xrandox/Example-Marker-Pack/blob/main/build.bat) - This is a small batch file I created that allows you to quickly zip up your XML and data folder and rename it to a .taco. Just need to edit it to your own file names. Totally not necessary, I'm just lazy and got tired of constantly zipping and renaming my stuff. **REQUIRES WINRAR**
* [Visual Studio Code](https://code.visualstudio.com/) - This is an more advanced editor that can be paired with Github Desktop to allow for better version control. If you plan to distribute your pack I highly recommend setting up a repo for it and using VSC and GHD to make your life a lot easier.
* [Github Desktop](https://desktop.github.com/) - Again, this is a tool to help make repo management less intimidating to those who have never worked with repo's before. I won't be going super in-depth with how to set up a repo and use this, but there is plenty of documentation out there if you just look around.

***

### Understanding A Marker Pack
A marker pack is fairly simple. It is either a .zip or a .taco (which is just a renamed .zip, so people don't accidentally extract it) that contains two things:
* `\Data\YourPack\` folder - This folder contains all of the assets for the pack. That is, the marker images, trail images and the `Trail.trl` files, which hold the binary trail data.
* `YourPack.xml` - This XML is a storage file for your packs category organization, markers, and trails. 

***

### Making a Useable XML
Before you start placing markers and recording trails there is a little bit of ground work to do. Arguably you could do this after you have already placed some markers, but in my opinion it's best if you at least get something workable before you just jump into the game and save you a ton of time later on. 

XML can get kinda scary if you've never seen anything like it, but I promise it's not too bad. It's basically just a structured way to record information. An empty pack XML might look something like this:
```xml
<!-- You can make comments like this! -->
<!-- Everything for our pack must be encapsulated in these OverlayData tags -->
<OverlayData>
     
    <!-- These MarkerCategory tags denote where our category organization is -->
    <MarkerCategory>
    </MarkerCategory>
    
    <!-- These POIs tags denote where our marker and trail info is -->
    <POIs>
    </POIs>

</OverlayData>
```

So say we want to make our own category for our marker, how do we do that? 
Time to learn about attributes

Here would be an example:
```xml
<OverlayData>
    <!--        the name attribute is how the category is referenced internally...more on this later -->
    <!--              |       the DisplayName attribute is what will be shown to the user when looking through categories -->
    <!--              |            |  -->
    <!--              V            V  -->
    <MarkerCategory name="ep" DisplayName="Example Pack">
    
    </MarkerCategory>
    
    <POIs>
    </POIs>

</OverlayData>
```

So with that, we've created our first category, one that will toggle our whole pack on and off. 
When users open their markers in TacO or BHUD they would see
```
All Markers
     -> Example Pack
```
     
But you need more than just one category for a pack, so lets add a few more!

```xml
<OverlayData>

    <MarkerCategory name="ep" DisplayName="Example Pack">
    
        <!--This is a sub-category for markers-->
        <MarkerCategory name="m" DisplayName="Markers">
        </MarkerCategory>

        <!--This is another sub-category for trails-->
        <MarkerCategory name="t" DisplayName="Trails">
        </MarkerCategory>
        
    </MarkerCategory>
    
    <POIs>
    </POIs>

</OverlayData>
```

Now when a user looks through the marker menu, it will look like this:
```
All Markers
   -> Example Pack
       -> Markers
       -> Trails
```
         
The final step to making a usable XML is to add in the actual marker and trail categories. Every marker or trail must have a category!

```xml
<OverlayData>

    <MarkerCategory name="ep" DisplayName="Example Pack">
    
        <!--This is a marker with no sub-category-->
        <!--                                       The iconFile attribute is the path to what image will be used for that marker -->
        <!--                                                       |  -->
        <!--                                                       V  -->
        <MarkerCategory name="exm" DisplayName="Example Marker" iconFile="Data/ExamplePack/Markers/ExampleMarker.png"/>
        
        <MarkerCategory name="m" DisplayName="Markers">
            <!--This is an example of a nested marker-->
            <MarkerCategory name="exm2" DisplayName="Example Marker 2" iconFile="Data/ExamplePack/Markers/ExampleMarker2.png"/>
        </MarkerCategory>

        <MarkerCategory name="t" DisplayName="Trails">
            <!--This is an example of a trail nested in a category-->
            <!--                                        Trails use the texture attribute instead of iconFile -->
            <!--                                                          |   -->
            <!--                                                          V   -->
            <MarkerCategory name="extrail" DisplayName="Example Trail" texture="Data/ExamplePack/Markers/Trail.png"/>
        </MarkerCategory>
        
    </MarkerCategory>
    
    <POIs>
    </POIs>

</OverlayData>
```

And with that, our category organization would look something like this:
```
All Markers
    -> Example Pack
        [x] Example Marker
        -> Markers
            [x] Example Marker 2
        -> Trails
            [x] Example Trail
```
             
***

### Using your Categories in TacO
After getting together the basic categories for your pack, it's time to move over to TacO and start placing markers and trails...but you need to bring your categories along for the ride. So how do we do that?

Well, our xml is essentially just a unique `poidata.xml`, which you can find in the TacO directory. So, to use your categories, copy your whole xml and overwrite the contents of `poidata.xml`.

Then start up TacO, and you should see the options there in the editor. Tada!

***

## Markers 101
