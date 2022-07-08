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
<!-- |   MapID tells us what map that marker is on. You don't necessarily need to know what map ID is which. In this case, 50 is Lion's Arch
<!-- |   |        xpos/ypos/zpos are the xyz coordinates that the marker is located at. They are truncated to 6 digits and can be negative and positive
<!-- |   |          |               |              |   the type attribute tells us what category this marker belongs to, using the name attributes in MarkerCategory
<!-- |   |          |               |              |              | the GUID attribute is a unique identifier that is used for tracking certain behaviors(hide/unhide)
<!-- |   |          |               |              |              |                  |
<!-- V   V          V               V              V              V                  V
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
