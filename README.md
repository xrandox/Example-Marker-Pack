# Example-Marker-Pack

This pack is meant to be a guide/follow-along for new pack makers to get their feet on the ground. Eventually I plan to have a video/series of videos to go along with it but for now it will just be with text.

## **Contents**
* [Getting Started](#getting-started)
   * [Useful Documentation](#useful-documentation)
   * [Useful Tools](#useful-tools)
   * [Understanding A Marker Pack](#understanding-a-marker-pack)
   * [Making Your Base XML](#making-your-base-xml)
   * [Using Your Categories in TacO](#using-your-categories-in-taco)
* [Markers 101](#markers-101)
   * [Placing Your First Markers With TacO](#placing-your-first-markers-with-taco)
   * [Understanding TacO Exporting](#understanding-taco-exporting)
   * [How to Edit Existing Markers](#how-to-edit-existing-markers)
   * [Proper Attribute Assigning and Category Heirarchy](#proper-attribute-assigning-and-category-heirarchy)
* [Trail Time](#trail-time)
   * [Trailing with TacO](#trailing-with-taco)
   * [How I Trail - The Process](#how-i-trail---the-process)
   * [Trailing in TrlTool](#trailing-in-trltool)
   * [Adding Trails To Your Pack](#adding-trails-to-your-pack)
* [Closing Remarks](#closing-remarks)
* [Acknowledgements](#acknowledgements)

# Getting Started

### Useful Documentation
* [BHUD Attribute Docs](https://blishhud.com/docs/markers/development/attributes/) - Extensive documentation of all the attributes currently supported by BHUD. Highly recommend referencing this for any attribute questions.
* [TacO Pack Documentation](https://www.gw2taco.com/2016/01/how-to-create-your-own-marker-pack.html) - Outdated documentation on how to create a marker pack directly from the creator of TacO. This info is outdated and working with the old editor, but it is still useful to read up on.

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

Markers..trails..what are those?

The tl;dr is this:
Markers - a point in the 3D game world, plotted with XYZ coordinates. At their most simple form, they are just a floating picture at a fixed coordinate. 
Trails - a collection of points in the game world, connected to form a line. Think of it as plotting points on a really big piece of graph paper.
Attributes - tags that can be used to customize and give further functionality to categories, markers and trails.

***

### Making Your Base XML
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
Time to learn about attributes!

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
            <!--This is an example of a trail nested in a category
                 |                                             Trails use the texture attribute instead of iconFile 
				         |                                                       |                                 Trails also require fadeNear and fadeFar
				         |                                                       |                                             |               |
				         V                                                       V                                             V               V  --> 
            <MarkerCategory name="extrail" DisplayName="Example Trail" texture="Data/ExamplePack/Markers/Trail.png" fadeNear="3000" fadeFar="3500"/>
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

Well, there are a few ways of doing this, however there's one approach in particular I prefer. I like to zip up my XML and Data file (you can use the build.bat file for this) and then drop that zip into my POIs folder just like you would a normal pack.

Then start up TacO, and you should see the options there in the editor. Congrats! You've done arguably the hardest part of pack making. Now on to the fun stuff!

***

# Markers 101

### Placing Your First Markers With TacO
When it comes to markers, the current tool of choice is TacO's marker editor. When you first fire it up, there's a lot of info thrown at you, but don't let it overwhelm you. Let's go through it together.

Open up TacO, click on `Open Marker Editor`, then go to settings -> turn on window edit mode, and rescale the box to fit all the info.

Before you really get going with anything, you need to set your keybinds. Some are under Marker Editor -> Rebind Keys and some are under Settings -> Rebind Keys. Get your keybinds all set up and then you can click on the numbered buttons below "Select Default Marker Types" in the marker editor to change your default markers. Now pressing those keys will automatically drop the marker you have assigned to it. 

Now, press the key you assigned to "Add new marker (Default Category 1)" to place your first marker. After you've placed the marker, you can click on it and it's attribute information will appear in your marker editor. Let's take a look at some of the basics of the editor:
![editor image one](https://imgur.com/wVsPiM3.png)
1. This button is one of the most used and will allow you to change the category of the selected marker
2. This button deletes the selected marker
3. All of the rest of these fields are attributes, which alter the visuals or behavior of a marker. I won't get into attributes too much here. I personally think TacO is incentivizing bad habits by including all the attributes here, but if you do end up needing marker-specific attributes, you can set them here. More on attributes later.
4. In order to toggle an attribute, the box next to it must be checked.

You can also click and drag on the different planes or arrows of the marker to move it around in the game world.

At this point you know now how to add markers, change their category, delete them, move them around, and how to toggle different attributes (although you may not know what those attributes do quite yet, but thats okay!). This is pretty much all of the knowledge you need to be able to place markers for your pack. 

***

### Understanding TacO Exporting
Now that you know how to place markers, you need to know how to find them. For that we go back to `poidata.xml`. Every time you place a marker in-game, TacO will automatically save that marker and it's attributes to poidata.xml. It also includes the category information in the top as well. However, I personally find this to be just unnecessary bulk. After adding a marker, you should see something like this:
```xml
<!-- extra catagory info up here we dont care about -->

<!-- begin POIs! this is where are markers are at -->
<POIs>
<!-- Every Marker starts with POI -->
<!-- |   MapID tells us what map that marker is on. You don't necessarily need to know what map ID is which. In this case, 50 is Lion's Arch -->
<!-- |   |        xpos/ypos/zpos are the xyz coordinates that the marker is located at. They are truncated to 6 digits and can be negative and positive -->
<!-- |   |          |               |              |   the type attribute tells us what category this marker belongs to, using the name attributes in MarkerCategory -->
<!-- |   |          |               |              |              | the GUID attribute is a unique identifier that is used for tracking certain behaviors(hide/unhide) -->
<!-- |   |          |               |              |              |                  | -->
<!-- V   V          V               V              V              V                  V -->
  <POI MapID="50" xpos="-563.204" ypos="26.6099" zpos="94.5559" type="ep.exmarker" GUID="fEvVAceiaUanEsb/Rrea6A=="/>
</POIs>
```
The above attributes are the standard attributes that every marker should have. 

Now all you need to do to add that marker to your pack is to copy and paste that POI into your main `ExamplePack.xml` in the POIs section. 

***

### How to Edit Existing Markers
The easiest way I've found to edit markers with the new editor is to copy all of your markers from within POI's (or if you have a big pack, for the map you are working in), paste into the `poidata.xml`, edit as you would like, and then copy and overwrite the POI's in your XML. The reason I do this instead of using was TacO generates for me is because TacO removes all commenting and whitespace on export, and I personally prefer having my own comments and formatting because it helps me when working within the XML. When BHUD's editor comes out and we no longer need to work directly with the XML this may change, but for now this is how I do it.

***

### Proper Attribute Assigning and Category Heirarchy
Now that we've covered how to place and edit your own markers, we need to have a talk about attribute assigning and category heirarchy. This is very important and is something that I think TacO's editor creates bad habits for. With TacO's editor, if I wanted to change the fadeFar attribute to be shorter (the marker will disappear at a shorter range), I could do that by simply click the box for fadeFar and putting in some value, say 3500. This would add the attribute `fadeFar="3500"` to the marker. However, what if I want all of my markers to have a closer fadeFar? TacO's tool might incentivize you to do that for each and every marker. However there is a far superior way.

Remember back to MarkerCategory's? Those can have attributes too, and anything within those categories *also* will have those attributes, *unless overridden*. And thus we have the proper way to assign attributes -- at a categorical level. To wrap back to our fadeFar example, if I want *all* of my markers to have a different fadeFar, lets just add that to our master marker category, like so:
```xml
    <MarkerCategory name="ep" DisplayName="Example Pack">

        <!--                                 fadeFar will now apply to anything within this category -->
        <!--                                              |  -->
        <!--                                              V  -->
        <MarkerCategory name="m" DisplayName="Markers" fadeFar="3500">
            <MarkerCategory name="exm" DisplayName="Example Marker" iconFile="Data/ExamplePack/Markers/ExampleMarker.png"/>
            <!--and if I have a specific marker I want to have a different fadeFar for, I can override it on the lower level, like this -->
            <!--                                                                                                                | -->
            <!--                                                                                                                V -->
            <MarkerCategory name="exm2" DisplayName="Example Marker 2" iconFile="Data/ExamplePack/Markers/ExampleMarker2.png" fadeFar="3000"/>
        </MarkerCategory>

        <!--Trails remain unaffected because they are not within that category-->
        <MarkerCategory name="t" DisplayName="Trails">
            <MarkerCategory name="extrail" DisplayName="Example Trail" texture="Data/ExamplePack/Markers/Trail.png"/>
        </MarkerCategory>
        
    </MarkerCategory>
```

As you can see, you can do the vast majority of attribute assigning on the categorical level and save yourself a lot of headache. When possible, you should always try to do attributes this way. Some exceptions are things like `copy` or `info` that may be marker specific.

This is also why setting up a good category heirarchy for your pack is important, not just for your users but also for attribute assigning. 

***

 # Trail Time

### Trailing with TacO
Now, I will make it entirely clear that it is 100% possible to do everything with TacO's trail editor. Some people may even prefer it. I on the other hand, am not such a big fan. The selling point -- and biggest fault -- of TacO's trail recorder is that it records _everything_ you do. You can just turn it on and be on your merry way recording a trail. However, it records _everything_. That bump you hit while going max speed on a beetle and sent you flying? Yep. Every time you leap on your raptor? Yep. Get knocked around by a mob while trying to record a detailed trail? Yep. Every twist and turn while going mach jesus on a griffon? You betcha. And this is my issue with TacO's editor. Can you get nice trails that are smooth and rounded and pretty? Absolutely. Does it take forever and a day of ironing out bumps and jumps and everything in between? Absolutely.

So, I will briefly touch on how to record with TacO, and then I will move on to using TrlTool and how to use them in combination for the best effect. 

For TacO, lets take a look at the trail editing buttons quickly:
![trail editing buttons](https://imgur.com/sgO87sD.png)
1. This starts the recording of a new trail. Pressing it again will dump everything you've recorded without saving anything. DONT PRESS AGAIN IN THE MIDDLE OF A TRAIL WITHOUT EXPORTING.
2. The pause button. This pauses the recording of the trail. You can have varying success with Pause -> Move -> Unpause -> Repeat. This gives you straight lines from point to point without worrying about what happens in between unpausing. It's how I recorded trails prior to TrlTool. Also allows you to use #3
3. Start a new trail section. This will create a break in the trail, meaning you can end a trail at one point, then create a new section of the same trl somewhere else without connecting the two. This means you dont have to make a bunch of different little trails every time you want to waypoint or something. 
4. Delete selected trail segment or last segment if no trail segment is selected. Pretty self-explanatory.
5. Save trail to .trl. **This is the most important button when trailing with TacO. SAVE OFTEN.** Do not make the mistake of being nearly done with a trail and then losing all progress because you accidentally hit start/stop instead of pause/unpause and you never exported. I have done it. It sucks. A lot. **SAVE ALL THE TIME**
6. Load an existing .trl. Self-explanatory. You must load a .trl to edit them, you cannot edit trl's inside of packs.
7./8. Change your selected trail segment. Somewhat useful if you want to go back in a trail to make a routing change or something. Not used much in my experience.

And that's really it for trailing with TacO. Once you export the trail you'll refer to the later section on how to add it to your pack, but TacO is pretty simple to use as far as trails goes. 

***

### How I Trail - The Process
If you don't care about being efficient, or you aren't trailing for something that really cares about speed or precision, then please feel free to skip to the next section. I'm including this because I often get asked it, and so I figured I might as well touch on it. Please understand this is coming from a speedrunner who will literally grind 10 different routes just to find one that save 8 seconds; take it for what you will. If it's something that you find value in please feel free to adopt it and make it your own. If you don't care for it, find your own way! Not everyone has to be a stopwatch racer.

With that said, here is essentially my step-by-step:
1. Trails get routed on paper first. Typically, I screenshot the map I'm working on, bring it into Photoshop, GIMP, or even the default windows photos + draw tool, and start layering on pathing. I prefer GIMP or PS since it allows me to create layers and draw multiple routes/make adjustments as I try things out. This is mostly by eye, and is pretty rough and usually ends up getting a lot of changes.
2. Next I go and physically run the route in-game. I don't typically 'break trail' during this as I find that I usually have to make a decent amount of changes as I go and try to follow my laid out lines. I add new layers onto the PS/GIMP picture to make route changes. This is the stage where I do a lot of testing. Highly recommend picking up livesplit if you want to get serious about min-maxing your routes. Time different routes, using different mounts, etc. Always take advantage of high cliffs for griff dives or long relatively flat ground for beetle. 
3. After I get pretty happy with the route, then I go and break trail for the first time, following the route I decided on in testing. I typically do the routing with TrlTool, importing it into TacO every now and then to make sure I didnt fluff something up horribly. I work on long trails, so if you're doing shorter trails it may not be necessary. TrlTool is why my trails are very sharp and pointy. I personally prefer that aesthetic. Some don't, so I guess you'll have to try it out and see. BHUD may have a trail smoother at some point in the future too.
4. After first trail is down, then I go and place markers along the trail. During this time I'm looking for any obvious issues with the trail, and fixing them while I do markers. Markers tend to take a while.
5. Finally, I do one last pass with everything complete and markers added to "certify" the trail. If it meets all my expectations and I see no further problems, it's ready to go and on to the next trail.

***

### Trailing in TrlTool
So I keep talking about this mysterious TrlTool, what the heck is it?

Well, as said in the Useful Tools section, TrlTool is a small program created by Freesnow to edit trails manually. It was never really intended to be used to create trails, but I liked it so much that I pretty much adapted it just for that use. It's super simple, so lets break it down real quick:
![freesnows trltool](https://imgur.com/WSIK6CT.png)
1. Open a .trl file. If you have an existing one you want to edit, this is how you open it.
2. Save .trl. If you've opened a .trl, this will overwrite the one you opened. 
3. Save a copy, this will give you the option to save a new .trl file instead of overwriting the one you open. Highly recommend doing this if you are editing a pre-existing trail. This can also be used if you're making a trail from scratch and need to save it.
4. Insert Map - This is used to start a new trail segment. The start of a trl file always starts with the Map ID, and whenever you need to make a new trail segment you need to insert the map again to show a break in the trail.
5. Insert Vector - This inserts a vector, or in TacO terms, a trail segment. This is hardcoded to `;` as a hotkey. Recommend binding a mousekey to that if you intend to create trails with it, works wonders.
6. Checking this box will make the window also on top. Useful if you have limited screen space and want to layer it on your game or something.
7. This is an example of 'Insert Map'. It will always be `M` followed by the map ID. In this case, it is Lion's Arch, which is ID 50.
8. Every line after this is a vector, stored as **X Z Y**. This is important to distinguish from the xml, which is X Y Z. Again the coordinates are stored as X Z Y.

As you can see, TrlTool is very simplistic and 'rudimentary'. However, if you want straight and sharp lines, it's much easier to just tap `;` every few seconds than mess with pausing and unpausing TacO. It's also a lot easier to go in between specific points and create new segments of trail, or remove large segments at a time. 

***

### Adding Trails To Your Pack
Now that we've discussed different ways to create trails, we need to talk about how to add them to your pack. Luckily, it's relatively easy. First of all, we need to take the generated `Trail.trl` and put it in our `\Data\` folder. Now I typically organized my data folders so the trail path is something along the lines of `\Data\ExamplePack\Trails\Trail.trl`. How exactly you organized your data file structure honestly doesn't matter to anyone but you. Do it however you want, no one else is ever going to see it.

Anyways, after throwing your freshly minted trail into the Data folder, you need to add a marker category and a Trail entry for it. We added a marker category already, so we get need to add a trail entry. Together, it would look something like this:
```xml
<OverlayData>
    <MarkerCategory name="ep" DisplayName="Example Pack">


        <MarkerCategory name="m" DisplayName="Markers" fadeFar="3500">
            <MarkerCategory name="exm" DisplayName="Example Marker" iconFile="Data/ExamplePack/Markers/ExampleMarker.png"/>
            <MarkerCategory name="exm2" DisplayName="Example Marker 2" iconFile="Data/ExamplePack/Markers/ExampleMarker2.png" fadeFar="3000"/>
        </MarkerCategory>

        <MarkerCategory name="t" DisplayName="Trails">
            <MarkerCategory name="extrail" DisplayName="Example Trail" texture="Data/ExamplePack/Markers/Trail.png"/>
        </MarkerCategory>
        
    </MarkerCategory>
  
    <POIs>
      <POI MapID="50" xpos="-563.204" ypos="26.6099" zpos="94.5559" type="ep.exmarker" GUID="fEvVAceiaUanEsb/Rrea6A=="/>
<!--   All trails start with a Trail prefix -->
<!--     |   the type attribute, just like in markers, leads to the category it belongs to in the MarkerCategory heirarchy, according to name  -->
<!--     |     |                 trailData gives us the path to the .trl file with the trail's data  -->
<!--     |     |                    |  -->
<!--     V     V                    V  -->
      <Trail type="ep.t.extrail" trailData="Data/ExamplePack/Trails/ExampleTrail.trl"/>
    </POIs>
</OverlayData>
```

And with that, you can run build.bat and you now have your first trail!

***

# Closing Remarks
Overall, pack making is more time consuming than it is hard. Contrary to how it may seem the first time you open up a giant XML, it's really not that technically challenging to do. It just takes a lot of time and dedication to put together a good end product, and there is an initial learning curve that most people don't quite get over. Hopefully this little guide well help some more people get over that first hump and onto creating some more awesome packs for the community. 

I will not be frequenting this repo, so please don't write on the issue board here for questions or comments etc. Instead, a much better and more reliable way to get ahold of me is by joining the [Teh's Trails Discord](https://discord.gg/bJV6VXT). Feel free to make use of our help desk and ask any questions you might have. I'm generally available most of the day, and always love to help out fresh blood. 

Cheers!

***

# Acknowledgements
* Blish Hud has revolutionized the overlay game again and again and continues to foster more and more progress. With his various tools and his amazing overlay I likely would have stopped trailing long ago, so I can't thank **Freesnow** enough for his work.
* None of this would have been possible without the original creation of TacO by **BoyC**.
* The many **contributors and trail testers in the Tehs Trails discord** have continously pushed me to refine my work and keep producing content. Their support has meant the world to keeping the project going. 
* Special thanks to **zotmer**, the other main developer of Tehs Trails who has provided countless improvements to my pack and always keeps me on my toes
* And thanks to **all the other pack developers**, who I'm sure through some way or another have improved my workflow and given me more reasons to keep pushing the limit.
* **And to you, future pack developer!** For having the heart to want to provide content for other people, and for having the willpower to get to this point in the guide 😆
