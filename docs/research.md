# Research

## What is Godot?

Godot is a cross-platform (Windows, Linux, MacOS, IOS, WebGL, ect.) 2D and 3D
free and open source game engine written in primarly C++ that uses a node based
system organised as trees in scenes. Godot supports a variety of programming
languages that can be used to program a game including GDScript, C++, and C#,
and blocks offcially supported with many others by the community. Godot only
currently supports rendering with OpenGL ES 2 and 3 with Vulkan support comming
in Godot 4 [[1]](https://en.wikipedia.org/wiki/Godot_(game_engine)). I will be
using GDScript because it's the recommended and default option and I am the
most familiar with that.

## What can Godot do?

Godot has been used by many people to make many popular 2D and 3D games with
notables ones being: 

- Carol Reed Mysteries
- City Game Studio
- Cruelty Squad
- Hardcoded
- Kingdoms of the Dump
- Rogue State Revolution
- Sonic Colors: Ultimate

I have never played any of them (I don't really play any games) but they all
seem to have mostly positive reviews, played by lots of people, and looks good
so they must be good.

Godot seems to have really good support for 2D with a tailored and custom 2D
physics engine and rendering pipeline but 3D support seems to be a bit lacking
due to a non complete renderer but that will improve in Godot 4.

## How can a game be made with Godot?

Godot works in a node based structured as a tree in scenes where nodes inherit
from other nodes giving them functionality of base nodes. For example the
sprite node inherits the CanvasLayer node which gives it drawing functionality.
Scenes can be used as main scenes for prefabs to put in to the main scenes.
The tree system can also be used to add more data in to a parent node. For
example a KinematicBody2D node can have a CollisionShape2D node which gives
collision data. Transforms also depend on the parents' transform.
[[2]](https://downloads.tuxfamily.org/godotengine/3.3.4/Godot_v3.3.4-stable_win64.exe.zip).

