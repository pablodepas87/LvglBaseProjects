# LVGLBaseProjects

Lvgl base projects is a repository to show how to work  C GUI library **LVGL** and how to configure it on Eclipse CDT IDE on Ubuntu OS. There will be , many simple widget base example , official **LVGL** examples and demo , and a global example with many **LVGL** features and widget used all in one project.

Every single project will be a branch of LVGLBaseProjects so to show the project that you would like to show checkout to corresponding branch. 

All the projects will be developed with **8.0 LVGL version** because at 5 April 2022 is the current version of MCUExpresso sdk 11.1.1 version

## IDE

 **Eclipse IDE for Embedded C/C++ Developers**  will be used to compile and debug all the projects on Ubuntu OS **without any development boards**. SDL driver will be used to simulate a board on PC. So :

To download eclipse https://www.eclipse.org/cdt/downloads.php 

To set SDL driver on **Ubuntu**:

1. Find the current version of SDL2: `apt-cache search libsdl2 (e.g. libsdl2-2.0-0)`
2. Install SDL2: `sudo apt-get install libsdl2-2.0-0` (replace with the found version)
3. Install SDL2 development package: `sudo apt-get install libsdl2-dev`
4. If build essentials are not installed yet: `sudo apt-get install build-essential`
5. If you don't have libpng install it with `sudo apt-get install -y libpng-dev`

To install on **Windows**:

If you are using **Windows** firstly you need to install MinGW ([64 bit version](http://mingw-w64.org/doku.php/download)). After installing MinGW, do the following steps to add SDL2:

1. Download the development libraries of SDL.
   Go to https://www.libsdl.org/download-2.0.php and download *Development Libraries: SDL2-devel-2.0.5-mingw.tar.gz*
2. Decompress the file and go to *x86_64-w64-mingw32* directory (for 64 bit MinGW) or to *i686-w64-mingw32* (for 32 bit MinGW)
3. Copy _...*mingw32/include/SDL2* folder to *C:/MinGW/.../x86_64-w64-mingw32/include*
4. Copy _...*mingw32/lib/* content to *C:/MinGW/.../x86_64-w64-mingw32/lib*
5. Copy _...*mingw32/bin/SDL2.dll* to *{eclipse_worksapce}/pc_simulator/Debug/*.  Do it later when Eclipse is installed.

Note: If you are using **Microsoft Visual Studio** instead of Eclipse then you don't have to install MinGW.

## LVGL GUI LIBRARY 

LVGL (Light and Versatile Graphics Library) is a free and open-source  graphics library providing everything you need to create embedded GUI  with easy-to-use graphical elements, beautiful visual effects and a low  memory footprint.

#### Requirements

Basically, every modern controller  (which is able to drive a display) is suitable to run LVGL. The minimal requirements are:

-  16, 32 or 64 bit microcontroller or processor
- \> 16 MHz clock speed is recommended
-  Flash/ROM: > 64 kB for the very essential components (> 180 kB is recommended)
-  RAM:   
  -  Static RAM usage: ~2 kB depending on the used features and objects types
  -  Stack: > 2kB (> 8 kB is recommended)
  -  Dynamic data (heap): > 4 KB (> 32 kB is recommended if using several objects).   Set by *LV_MEM_SIZE* in *lv_conf.h*. 
  -  Display buffer:  > *"Horizontal resolution"* pixels (> 10 × *"Horizontal resolution"* is recommended) 
  -  One frame buffer in the MCU or in external display controller
-  C99 or newer compiler
-  Basic C (or C++) knowledge:           [pointers](https://www.tutorialspoint.com/cprogramming/c_pointers.htm),           [structs](https://www.tutorialspoint.com/cprogramming/c_structures.htm),           [callbacks](https://www.geeksforgeeks.org/callbacks-in-c/).

#### Repository layout

All repositories of the LVGL project are hosted on GitHub: https://github.com/lvgl

You will find these repositories there:

- [lvgl](https://github.com/lvgl/lvgl) The library itself with many [examples](https://github.com/lvgl/lvgl/blob/master/examples/).
- [lv_demos](https://github.com/lvgl/lv_demos) Demos created with LVGL.
- [lv_drivers](https://github.com/lvgl/lv_drivers) Display and input device drivers
- [blog](https://github.com/lvgl/blog) Source of the blog's site (https://blog.lvgl.io)
- [sim](https://github.com/lvgl/sim) Source of the online simulator's site (https://sim.lvgl.io)
- [lv_sim_...](https://github.com/lvgl?q=lv_sim&type=&language=) Simulator projects for various IDEs and platforms
- [lv_port_...](https://github.com/lvgl?q=lv_port&type=&language=) LVGL ports to development boards
- [lv_binding_..](https://github.com/lvgl?q=lv_binding&type=&language=l) Bindings to other languages
- [lv_...](https://github.com/lvgl?q=lv_&type=&language=) Ports to other platforms

the official documentation of version 8.0  : https://docs.lvgl.io/8.0/

To read a quickly introduction on LVGL click [here](Documentations/LVGL_quickly_introduction.md)

**MOST IMPORTANT** if you will use a different LVGL version switch to properly documentation with the combobox on the top left on introduction web page  of LVGL.

## Pre-configured project

Each project is based on a Pre-configured project . You can find the latest one on [LVGL GitHub preconfigured base project](https://github.com/lvgl/lv_sim_eclipse_sdl). On it there are 2 submodules LVGL library code and lv_drivers that are important to set display driver and use SDL to show the app on Ubuntu desktop. These are set on the last version on LVGL , but for these repo will checkout to 8.0 release version , whit a git checkout command. 

On Eclipse IDE remember to set **Run Configuration** after compile the project that you want to start. 

To read more about Pre-configured project and base structure of all LVGLBaseProjects repo projects click [here](Documentations/BaseProject_introduction.md)