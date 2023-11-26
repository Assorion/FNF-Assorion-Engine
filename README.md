# Friday Night Funkin' Assorion Engine!

![LOGO](art/assorione.png)

-------------------------------------------------------------
 <div align="center">
 <a href="#"><img src="https://img.shields.io/github/repo-size/Assorion/FNF-Assorion-Engine?style=for-the-badge&color=06b59c"/></a>
 <a href="https://github.com/Assorion/FNF-Assorion-Engine/graphs/commit-activity"><img src="https://img.shields.io/github/commit-activity/m/Assorion/FNF-Assorion-Engine?style=for-the-badge&color=06b59c"/</a> 
 <a href="https://github.com/Assorion/FNF-Assorion-Engine/releases"><img src="https://img.shields.io/github/v/release/Assorion/FNF-Assorion-Engine?style=for-the-badge&color=06b59c"/></a>
 </div>
 <div align="center">
 <a href="https://github.com/Assorion/FNF-Assorion-Engine/releases"><img src="https://img.shields.io/badge/Windows_Build-Released-blue?style=for-the-badge&color=e1b100"/></a>
 <a href="https://github.com/Assorion/FNF-Assorion-Engine/releases"><img src="https://img.shields.io/badge/Linux_Build-Released-blue?style=for-the-badge&color=e1b100"/></a>
 <a href="https://github.com/Assorion/FNF-Assorion-Engine/actions/workflows/HTML5.yml"><img src="https://img.shields.io/badge/Web_Build-Testing-blue?style=for-the-badge&color=e1b100"/></a>  
 </div>

-------------------------------------------------------------
<div align="center">
 
**Table of Contents**
</div>
<div align="center">
 
┃ [**`• What is Assorion?`**](#--what-is-assorion-engine) ┃ [**`• Important Notes`**](#%EF%B8%8F--important-notesroadmap) ┃ [**`• Compiling`**](#--compiling) ┃ [**`• Min Reqs`**](#--minimum-requirements) ┃ <a href="https://assorion.github.io/wiki/">**`• Wiki`**</a> ┃ 
</div>

-------------------------------------------------------------

# ⚝ | What is Assorion Engine?

Assorion Engine is effectively the Linux of <a href="https://ninja-muffin24.itch.io/funkin">Friday Night Funkin'</a> Engines. 
All original base Friday Night Funkin' code has been replaced with more efficient, optimized code. 

Assorion Engine doesn't have mods folder capabilities planned nor will it be implemented. 
In addition, things such as cutscenes, events, discordRPC, etc, will have to be added yourself. 
Though, Assorion Engine does have several <a href="https://github.com/Assorion/FNF-Assorion-Engine#branches">branches</a> planned with more features soon.

## ⚡ | Why choose Assorion Engine?

1. Assorion Engine is incredibly fast and stable
2. Assorion's Code is much better streamlined, and much easier to mod
3. Assorion takes up less than ~70mb
4. Assorion frequently has many bug fixes and consistently gets improvements compared to the original game and many other engines

# 🗒️ | Important Notes/RoadMap

### **Note for Developers**
> [!NOTE] 
> Please use the <a href="https://github.com/Assorion/FNF-Assorion-Engine/releases"><ins>**latest release**</ins></a> source code, not the cloned or downloaded source code at the top. Mainly because of working on a lot of things throughout the source code during the weeks; Which will necessitate numerous commits.
>
> Thus inevitably exists the potential that something may be broken if you use the most recent **source** code, as opposed to the most recent <a href="https://github.com/Assorion/FNF-Assorion-Engine/releases"><ins>**release**</ins></a> code.

#
  **Other Notes**   
-	There has been a complete overhaul of Chartingstate. Therefore, it will probably have new bugs and will be partially confusing at first glance
-	The characters in the song are entirely un-hardcoded. Thus you can define 2 or 4 characters instead of 3. Notes have a `player` value that makes this work
-	Charts are handled differently to the base game. Absolute positions are used instead of millisecond values. In addition, notes have player values in the chart
-	Assorion Engine based off <a href="https://github.com/FunkinCrew/Funkin/releases/tag/v0.2.6">`0.2.6`</a> version of the base game, though has been radically altered
-	The Songs and Data folder have been merged into the `songs-data` folder
- Pressing the F12 key juring gameplay uses an experimental screenshot feature. When pressed, a folder and file will be created
- Web build compiles, but is full of bugs still. These will be fixed later.
  
 **RoadMap**
* [x]	Offset wizard
* [X]	Web build
* [ ]	Improvements to the chart editor
* [ ]	Events System
* [ ]	Portuguese translation
* [ ]	Fixes for newer Flixel

#### **Branches**
| `Assorion Branch's`                                | `Windows` | `Linux` | `HTML5 (WEB)`     |
|--------------------------------------------------|---------|-------|-----------------|
| <a href="#">Assorion-Main</a>                                    | ✓       | ✓     | ⍻              |
| <a href="#">Assorion-Plus</a>                                    | ☓       | ☓     | ☓              |
| <a href="#">Assorion-Minimun</a>                                 | ☓       | ☓     | ☓              |
| <a href="#">Assorion-Base</a>                                    | ☓       | ☓     | ☓              |
| <a href="#">Assorion-3D</a>                                      | ☓       | ☓     | ☓              |

## 🖼️ | Screenshots

Take a look at <a href="https://github.com/Assorion/FNF-Assorion-Engine/blob/main/art/screenshots.md">`art/screenshots.md`</a>. 

# 🛠 | Compiling

#### **Libraries:**  
Read ahead to your OS and read those instructions. Then come back here.

Run `haxelib setup <library name>` replacing `<library name>` with these libraries below:
- `hxcpp`
- `lime 7.9.0` or `lime 8.0.0`
- `openfl 9.2.1`
- `flixel 4.9.0` or `flixel 5.2.2`
- `flixel-addons 3.0.2`
- `flixel-ui 2.5.0`

#### **For Windows:**
- Install <a href="https://haxe.org/">`Haxe`</a>
- Run `haxelib setup` in CMD. Using the defaults is fine
- Install libraries above
- Run `haxelib run lime setup`. It will install extra stuff, but you should be fine
- Setup MinGW-w64 and make sure the PATH is set correctly
- Test to make sure both the `gcc` and `g++` commands work in CMD
- Run `lime test windows -D HXCPP_MINGW` in CMD. Make sure it's in the project root folder, not the source folder

#### **For Linux:**
- Install Haxe using your package manager
- Run `haxelib setup` in your terminal
- Install libraries above
- Run `haxelib run lime setup`.
- Test to make sure both `gcc` and `g++` commands work. They should already be installed in your distro
- Run `lime test linux` in your terminal

#### **If you're confused:**  
Follow a YouTube guide, or the base game instructions on compiling. Do NOT use Visual Studio's Clang-Compiler, please use MinGW-w64.  
Remember to install the library versions listed above though.

> [!WARNING] 
> Assorion has been tested with the latest versions of Lime & Flixel. These recent versions cause issues with compiling, cameras, etc. I advise that you downgrade Flixel & Lime to the versions listed above to make sure Assorion works as intended.
>
> 
> Every version of the libraries listed before are the versions that Assorion has been tested / built with, so using those versions will gurantee that Assorion will compile and behave correctly. Fixes for these issues will hopefully be implemented soon.

## 💻 | Minimum Requirements

The minimum essentials stated below are necessary to run this optimized engine on an operating system.

- **OS**: Windows Vista 64-Bit or Higher
- **Processor**: Core 2 Solo or Higher
- **Memory**: 512MB - 1GB of Ram. 256mb or Higher of VRAM
- **Storage**: 36MB - 70MB Available Space

<details>
<summary>OS - Details</summary>
Modern versions of both Haxe, and HXCPP do not compile to anything older than Windows Vista. There are no 32-bit builds (yet), as such the lowest requirement is Windows Vista 64-bit.  

> [!WARNING]
> This can actually be false. I have tried 32-bit Funkin' on 32-bit Vista, however I have not tested 64-bit versions. I do not own a legal copy of Vista x64.
> Therefore I can not actually confirm if this is true.  

> Tested with: Windows XP x64 and x86, Windows Vista x86, Windows 7 x64
</details>

<details>
<summary>CPU - Details</summary>
The Core 2 series of chips (or higher) are the only ones that can run this build of Assorion. Most Pentium 4s and Celerons are not 64-bit compatible. Even with a 32-bit build though, Lime.ndll causes issues with those
processors as it relies on special instructions such as ```sse3```, ```sse4```. This causes the game to error out with illegal instructions.

Once again, I cannot confirm if a 64-bit Pentium 4 would work. However I doubt it would since the lack of `sse4`.  

> Tested with: Socket 478 Pentium 4 @ 2.26ghz
</details>

<details>
<summary>RAM - Details</summary>
The game averages from 360mb - 400mb (and a little higher) of RAM. You technically only need 512mb of spare ram to run the game. However running with caching options enabled will put it over this threshold.  
Without caching, the game does not need anything higher.  

> Tested with: 2 sticks of 1gb RAM (2gb total)
</details>

<details>
<summary>VRAM - Details</summary>
Simple. Any less and most sprites will not be-able to get rendered, making them invisible.  

> Tested with: Nvidia FX-5200 with 128mb of VRAM, Nvidia GS-7300 with 256mb of VRAM
</details>

<details>
<summary>Disk space - Details</summary>
The `ZIP` file is only 36mb, while the `TAR.GZ` is around 40mb. These files expand up to ~70mb of space. 

Almost all of the base game assets are removed, so the engine itself is tiny.  

> Tested with: Right-Click > Properties > Size
</details>