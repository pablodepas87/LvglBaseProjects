# Layers

## Order of creation

By default, LVGL draws new objects on top of old objects.

For example, assume we add a button to a parent object named button1  and then another button named button2. Then button1 (along with its  child object(s)) will be in the background and can be covered by button2 and its children.

![../_images/layers.png](https://docs.lvgl.io/master/_images/layers.png)

```
/*Create a screen*/
lv_obj_t * scr = lv_obj_create(NULL, NULL);
lv_scr_load(scr);          /*Load the screen*/

/*Create 2 buttons*/
lv_obj_t * btn1 = lv_btn_create(scr, NULL);         /*Create a button on the screen*/
lv_btn_set_fit(btn1, true, true);                   /*Enable automatically setting the size according to content*/
lv_obj_set_pos(btn1, 60, 40);              	   /*Set the position of the button*/

lv_obj_t * btn2 = lv_btn_create(scr, btn1);         /*Copy the first button*/
lv_obj_set_pos(btn2, 180, 80);                    /*Set the position of the button*/

/*Add labels to the buttons*/
lv_obj_t * label1 = lv_label_create(btn1, NULL);	/*Create a label on the first button*/
lv_label_set_text(label1, "Button 1");          	/*Set the text of the label*/

lv_obj_t * label2 = lv_label_create(btn2, NULL);  	/*Create a label on the second button*/
lv_label_set_text(label2, "Button 2");            	/*Set the text of the label*/

/*Delete the second label*/
lv_obj_del(label2);
```

## Bring to the foreground

There are four explicit ways to bring an object to the foreground:

- Use `lv_obj_move_foreground(obj)` to bring an object to the foreground. Similarly, use `lv_obj_move_background(obj)` to move it to the background.
- Use `lv_obj_move_up(obj)` to move an object one position up in the hierarchy, Similarly, use `lv_obj_move_down(obj)` to move an object one position down in the hierarchy.
- Use `lv_obj_swap(obj1, obj2)` to swap the relative layer position of two objects.
- When `lv_obj_set_parent(obj, new_parent)` is used, `obj` will be on the foreground of the `new_parent`.

## Top and sys layers

LVGL uses two special layers named `layer_top` and `layer_sys`. Both are visible and common on all screens of a display. **They are not, however, shared among multiple physical displays.** The `layer_top` is always on top of the default screen (`lv_scr_act()`), and `layer_sys` is on top of `layer_top`.

The `layer_top` can be used by the user to create some content visible everywhere. For example, a menu bar, a pop-up, etc. If the `click` attribute is enabled, then `layer_top` will absorb all user clicks and acts as a modal.

```
lv_obj_add_flag(lv_layer_top(), LV_OBJ_FLAG_CLICKABLE);
```

The `layer_sys` is also used for similar purposes in LVGL. For example, it places the  mouse cursor above all layers to be sure it's always visible.

# Scroll

## Overview

In LVGL scrolling works very intuitively: if an object is outside its parent content area (the size without padding), the parent becomes  scrollable and scrollbar(s) will appear. That's it.

Any object can be scrollable including `lv_obj_t`, `lv_img`, `lv_btn`, `lv_meter`, etc

The object can either be scrolled horizontally or vertically in one stroke; diagonal scrolling is not possible.

### Scrollbar

#### Mode

Scrollbars are displayed according to a configured `mode`. The following `mode`s exist:

- `LV_SCROLLBAR_MODE_OFF`  Never show the scrollbars
- `LV_SCROLLBAR_MODE_ON`  Always show the scrollbars
- `LV_SCROLLBAR_MODE_ACTIVE` Show scroll bars while an object is being scrolled
- `LV_SCROLLBAR_MODE_AUTO`  Show scroll bars when the content is large enough to be scrolled

`lv_obj_set_scrollbar_mode(obj, LV_SCROLLBAR_MODE_...)` sets the scrollbar mode on an object.        

#### Styling

The scrollbars have their own dedicated part, called `LV_PART_SCROLLBAR`. For example a scrollbar can turn to red like this:

```
static lv_style_t style_red;
lv_style_init(&style_red);
lv_style_set_bg_color(&style_red, lv_color_red());

...

lv_obj_add_style(obj, &style_red, LV_PART_SCROLLBAR);
```

An object goes to the `LV_STATE_SCROLLED` state while it's being scrolled. This allows adding different styles to the scrollbar or the object itself when scrolled. This code makes the scrollbar blue when the object is scrolled:

```
static lv_style_t style_blue;
lv_style_init(&style_blue);
lv_style_set_bg_color(&style_blue, lv_color_blue());

...

lv_obj_add_style(obj, &style_blue, LV_STATE_SCROLLED | LV_PART_SCROLLBAR);
```

If the base direction of the `LV_PART_SCROLLBAR` is RTL (`LV_BASE_DIR_RTL`) the vertical scrollbar will be placed on the left. Note that, the `base_dir` style property is inherited. Therefore, it can be set directly on the `LV_PART_SCROLLBAR` part of an object or on the object's or any parent's main part to make a scrollbar inherit the base direction.

`pad_left/right/top/bottom` sets the spacing around the scrollbars and `width` sets the scrollbar's width.

### Events

The following events are related to scrolling:

- `LV_EVENT_SCROLL_BEGIN` Scrolling begins
- `LV_EVENT_SCROLL_END` Scrolling ends
- `LV_EVENT_SCROLL` Scroll happened. Triggered on every position change. Scroll events

## Features of scrolling

Besides, managing "normal" scrolling there are many interesting and useful additional features.

### Scrollable

It's possible to make an object non-scrollable with `lv_obj_clear_flag(obj, LV_OBJ_FLAG_SCROLLABLE)`.

Non-scrollable objects can still propagate the scrolling (chain) to their parents.

The direction in which scrolling happens can be controlled by `lv_obj_set_scroll_dir(obj, LV_DIR_...)`. The following values are possible for the direction:

- `LV_DIR_TOP` only scroll up
- `LV_DIR_LEFT` only scroll left
- `LV_DIR_BOTTOM` only scroll down
- `LV_DIR_RIGHT` only scroll right
- `LV_DIR_HOR` only scroll horizontally
- `LV_DIR_VER` only scroll vertically
- `LV_DIR_ALL` scroll any directions

OR-ed values are also possible. E.g. `LV_DIR_TOP | LV_DIR_LEFT`.

### Scroll chain

If an object can't be scrolled further (e.g. its content has reached  the bottom-most position) additional scrolling is propagated to its  parent. If the parent can be scrolled in that direction than it will be  scrolled instead. It continues propagating to the grandparent and grand-grandparents as  well.

The propagation on scrolling is called "scroll chaining" and it can be enabled/disabled with `LV_OBJ_FLAG_SCROLL_CHAIN_HOR/VER` flag. If chaining is disabled the propagation stops on the object and the parent(s) won't be scrolled.

### Scroll momentum

When the user scrolls an object and releases it, LVGL can emulate  inertial momentum for the scrolling. It's like the object was thrown and scrolling slows down smoothly.

The scroll momentum can be enabled/disabled with the `LV_OBJ_FLAG_SCROLL_MOMENTUM` flag.

### Elastic scroll

Normally an object can't be scrolled past the extremeties of its  content. That is the top side of the content can't be below the top side of the object.

However, with `LV_OBJ_FLAG_SCROLL_ELASTIC` a fancy effect is added when the user "over-scrolls" the content. The  scrolling slows down, and the content can be scrolled inside the object. When the object is released the content scrolled in it will be animated  back to the valid position.

### Snapping

The children of an object can be snapped according to specific rules  when scrolling ends. Children can be made snappable individually with  the `LV_OBJ_FLAG_SNAPPABLE` flag.

An object can align snapped children in four ways:

- `LV_SCROLL_SNAP_NONE` Snapping is disabled. (default)
- `LV_SCROLL_SNAP_START` Align the children to the left/top side of a scrolled object
- `LV_SCROLL_SNAP_END` Align the children to the right/bottom side of a scrolled object
- `LV_SCROLL_SNAP_CENTER` Align the children to the center of a scrolled object

Snap alignment is set with `lv_obj_set_scroll_snap_x/y(obj, LV_SCROLL_SNAP_...)`:

Under the hood the following happens:

1. User scrolls an object and releases the screen
2. LVGL calculates where the scroll would end considering scroll momentum
3. LVGL finds the nearest scroll point
4. LVGL scrolls to the snap point with an animation

### Scroll one

The "scroll one" feature tells LVGL to allow scrolling only one snappable child at a time. This requires making the children snappable and setting a scroll snap alignment different from `LV_SCROLL_SNAP_NONE`.

This feature can be enabled by the `LV_OBJ_FLAG_SCROLL_ONE` flag.

### Scroll on focus

Imagine that there a lot of objects in a group that are on a  scrollable object. Pressing the "Tab" button focuses the next object but it might be outside the visible area of the scrollable object. If the "scroll on focus" feature is enabled LVGL will automatically  scroll objects to bring their children into view. The scrolling happens recursively therefore even nested scrollable  objects are handled properly. The object will be scrolled into view even if it's on a different page  of a tabview.

## Scroll manually

The following API functions allow manual scrolling of objects:

- `lv_obj_scroll_by(obj, x, y, LV_ANIM_ON/OFF)` scroll by `x` and `y` values
- `lv_obj_scroll_to(obj, x, y, LV_ANIM_ON/OFF)` scroll to bring the given coordinate to the top left corner
- `lv_obj_scroll_to_x(obj, x, LV_ANIM_ON/OFF)` scroll to bring the given coordinate to the left side
- `lv_obj_scroll_to_y(obj, y, LV_ANIM_ON/OFF)` scroll to bring the given coordinate to the top side

From time to time you may need to retrieve the scroll position of an  element, either to restore it later, or to display dynamically some  elements according to the current scroll. Here is an example to see how to combine scroll event and store the  scroll top position.

```
static int scroll_value = 0;

static void store_scroll_value_event_cb(lv_event_t* e) {
  lv_obj_t* screen = lv_event_get_target(e);
  scroll_value = lv_obj_get_scroll_top(screen);
  printf("%d pixels are scrolled out on the top\n", scroll_value);
}

lv_obj_t* container = lv_obj_create(NULL);
lv_obj_add_event_cb(container, store_scroll_value_event_cb, LV_EVENT_SCROLL, NULL);
```

Scrool coordinates can be retrieve from differents axes with these functions:

- `lv_obj_get_scroll_x(obj)` Get the `x` coordinate of object
- `lv_obj_get_scroll_y(obj)` Get the `y` coordinate of object
- `lv_obj_get_scroll_top(obj)` Get the scroll coordinate from the top
- `lv_obj_get_scroll_bottom(obj)` Get the scroll coordinate from the bottom
- `lv_obj_get_scroll_left(obj)` Get the scroll coordinate from the left
- `lv_obj_get_scroll_right(obj)` Get the scroll coordinate from the right

# Fonts

In LVGL fonts are collections of bitmaps and other information required to render images of individual letters (glyph). A font is stored in a `lv_font_t` variable and can be set in a style's *text_font* field. For example:

```
lv_style_set_text_font(&my_style, &lv_font_montserrat_28);  /*Set a larger font*/
```

Fonts have a **bpp (bits per pixel)** property. It shows how many bits are used to describe a pixel in a font. The value stored  for a pixel determines the pixel's opacity. This way, with higher *bpp*, the edges of the letter can be smoother. The possible *bpp* values are 1, 2, 4 and 8 (higher values mean better quality).

The *bpp* property also affects the amount of memory needed to store a font. For example, *bpp = 4* makes a font nearly four times larger compared to *bpp = 1*.

## Unicode support

LVGL supports **UTF-8** encoded Unicode characters. Your editor needs to be configured to save your code/text as UTF-8 (usually this the default) and be sure that, `LV_TXT_ENC` is set to `LV_TXT_ENC_UTF8` in *lv_conf.h*. (This is the default value)

To test it try

```
lv_obj_t * label1 = lv_label_create(lv_scr_act(), NULL);
lv_label_set_text(label1, LV_SYMBOL_OK);
```

If all works well, a ✓ character should be displayed.

## Built-in fonts

There are several built-in fonts in different sizes, which can be enabled in `lv_conf.h` with *LV_FONT_...* defines.

### Normal fonts

Containing all the ASCII characters, the degree symbol (U+00B0), the  bullet symbol (U+2022) and the built-in symbols (see below).

- `LV_FONT_MONTSERRAT_12` 12 px font
- `LV_FONT_MONTSERRAT_14` 14 px font
- `LV_FONT_MONTSERRAT_16` 16 px font
- `LV_FONT_MONTSERRAT_18` 18 px font
- `LV_FONT_MONTSERRAT_20` 20 px font
- `LV_FONT_MONTSERRAT_22` 22 px font
- `LV_FONT_MONTSERRAT_24` 24 px font
- `LV_FONT_MONTSERRAT_26` 26 px font
- `LV_FONT_MONTSERRAT_28` 28 px font
- `LV_FONT_MONTSERRAT_30` 30 px font
- `LV_FONT_MONTSERRAT_32` 32 px font
- `LV_FONT_MONTSERRAT_34` 34 px font
- `LV_FONT_MONTSERRAT_36` 36 px font
- `LV_FONT_MONTSERRAT_38` 38 px font
- `LV_FONT_MONTSERRAT_40` 40 px font
- `LV_FONT_MONTSERRAT_42` 42 px font
- `LV_FONT_MONTSERRAT_44` 44 px font
- `LV_FONT_MONTSERRAT_46` 46 px font
- `LV_FONT_MONTSERRAT_48` 48 px font

The symbols can be used singly as:

```
lv_label_set_text(my_label, LV_SYMBOL_OK);
```

Or together with strings (compile time string concatenation):

```
lv_label_set_text(my_label, LV_SYMBOL_OK "Apply");
```

Or more symbols together:

```
lv_label_set_text(my_label, LV_SYMBOL_OK LV_SYMBOL_WIFI LV_SYMBOL_PLAY);
```

## Special features

### Bidirectional support

Most languages use a Left-to-Right (LTR for short) writing direction, however some languages (such as Hebrew, Persian or Arabic) use  Right-to-Left (RTL for short) direction.

LVGL not only supports RTL texts but supports mixed (a.k.a. bidirectional, BiDi) text rendering too. 

BiDi support is enabled by `LV_USE_BIDI` in *lv_conf.h*

All texts have a base direction (LTR or RTL) which determines some  rendering rules and the default alignment of the text (Left or Right). However, in LVGL, the base direction is not only applied to labels. It's a general property which can be set for every object. If not set then it will be inherited from the parent. This means it's enough to set the base direction of a screen and every  object will inherit it.

The default base direction for screens can be set by `LV_BIDI_BASE_DIR_DEF` in *lv_conf.h* and other objects inherit the base direction from their parent.

To set an object's base direction use `lv_obj_set_base_dir(obj, base_dir)`.  The possible base directions are:

- `LV_BIDI_DIR_LTR`: Left to Right base direction
- `LV_BIDI_DIR_RTL`: Right to Left base direction
- `LV_BIDI_DIR_AUTO`: Auto detect base direction
- `LV_BIDI_DIR_INHERIT`: Inherit base direction from the parent (or a default value for non-screen objects)

This list summarizes the effect of RTL base direction on objects:

- Create objects by default on the right
- `lv_tabview`: Displays tabs from right to left
- `lv_checkbox`: Shows the box on the right
- `lv_btnmatrix`: Shows buttons from right to left
- `lv_list`: Shows icons on the right
- `lv_dropdown`: Aligns options to the right
- The texts in `lv_table`, `lv_btnmatrix`, `lv_keyboard`, `lv_tabview`, `lv_dropdown`, `lv_roller` are "BiDi processed" to be displayed correctly

### Arabic and Persian support

There are some special rules to display Arabic and Persian characters: the *form* of a character depends on its position in the text. A different form of the same letter needs to be used when it is  isolated, at start, middle or end positions. Besides these, some  conjunction rules should also be taken into account.

LVGL supports these rules if `LV_USE_ARABIC_PERSIAN_CHARS` is enabled.

However, there are some limitations:

- Only displaying text is supported (e.g. on labels), text inputs (e.g. text area) don't support this feature.
- Static text (i.e. const) is not processed. E.g. texts set by `lv_label_set_text()` will be "Arabic processed" but `lv_lable_set_text_static()` won't.
- Text get functions (e.g. `lv_label_get_text()`) will return the processed text.

### Subpixel rendering

Subpixel rendering allows for tripling the horizontal resolution by  rendering anti-aliased edges on Red, Green and Blue channels instead of  at pixel level granularity. This takes advantage of the position of  physical color channels of each pixel, resulting in higher quality  letter anti-aliasing. Learn more [here](https://en.wikipedia.org/wiki/Subpixel_rendering).

For subpixel rendering, the fonts need to be generated with special settings:

- In the online converter tick the `Subpixel` box
- In the command line tool use `--lcd` flag. Note that the generated font needs about three times more memory.

Subpixel rendering works only if the color channels of the pixels  have a horizontal layout. That is the R, G, B channels are next to each  other and not above each other. The order of color channels also needs to match with the library  settings. By default, LVGL assumes `RGB` order, however this can be swapped by setting `LV_SUBPX_BGR 1` in *lv_conf.h*.

### Compressed fonts

The bitmaps of fonts can be compressed by

- ticking the `Compressed` check box in the online converter
- not passing the `--no-compress` flag to the offline converter (compression is applied by default)

Compression is more effective with larger fonts and higher bpp. However, it's about 30% slower to render compressed fonts. Therefore, it's recommended to compress only the largest fonts of a user interface, because

- they need the most memory
- they can be compressed better
- and probably they are used less frequently then the medium-sized fonts, so the performance cost is smaller.

## Add a new font

There are several ways to add a new font to your project:

1. The simplest method is to use the [Online font converter](https://lvgl.io/tools/fontconverter). Just set the parameters, click the *Convert* button, copy the font to your project and use it. **Be sure to carefully read the steps provided on that site or you will get an error while converting.**
2. Use the [Offline font converter](https://github.com/lvgl/lv_font_conv). (Requires Node.js to be installed)
3. If you want to create something like the built-in fonts  (Montserrat font and symbols) but in a different size and/or ranges, you can use the `built_in_font_gen.py` script in `lvgl/scripts/built_in_font` folder. (This requires Python and `lv_font_conv` to be installed)

To declare a font in a file, use `LV_FONT_DECLARE(my_font_name)`.

To make fonts globally available (like the built-in fonts), add them to `LV_FONT_CUSTOM_DECLARE` in *lv_conf.h*.

## Add new symbols

The built-in symbols are created from the [FontAwesome](https://fontawesome.com/) font.

1. Search for a symbol on https://fontawesome.com. For example the [USB symbol](https://fontawesome.com/icons/usb?style=brands). Copy its Unicode ID which is `0xf287` in this case.
2. Open the [Online font converter](https://lvgl.io/tools/fontconverter). Add [FontAwesome.woff](https://lvgl.io/assets/others/FontAwesome5-Solid+Brands+Regular.woff). .
3. Set the parameters such as Name, Size, BPP. You'll use this name to declare and use the font in your code.
4. Add the Unicode ID of the symbol to the range field. E.g.` 0xf287` for the USB symbol. More symbols can be enumerated with `,`.
5. Convert the font and copy the generated source code to your project. Make sure to compile the .c file of your font.
6. Declare the font using `extern lv_font_t my_font_name;` or simply use `LV_FONT_DECLARE(my_font_name);`.

**Using the symbol**

1. Convert the Unicode value to UTF8, for example on [this site](http://www.ltg.ed.ac.uk/~richard/utf-8.cgi?input=f287&mode=hex). For `0xf287` the *Hex UTF-8 bytes* are `EF 8A 87`.
2. Create a `define` string from the UTF8 values: `#define MY_USB_SYMBOL "\xEF\x8A\x87"`
3. Create a label and set the text. Eg. `lv_label_set_text(label, MY_USB_SYMBOL)`

Note - `lv_label_set_text(label, MY_USB_SYMBOL)` searches for this symbol in the font defined in `style.text.font` properties. To use the symbol you may need to change it. Eg ` style.text.font = my_font_name`

## Load a font at run-time

`lv_font_load` can be used to load a font from a file. The font needs to have a special binary format. (Not TTF or WOFF). Use [lv_font_conv](https://github.com/lvgl/lv_font_conv/) with the `--format bin` option to generate an LVGL compatible font file.

Note that to load a font [LVGL's filesystem](https://docs.lvgl.io/master/overview/file-system.html) needs to be enabled and a driver must be added.

## Add a new font engine

LVGL's font interface is designed to be very flexible but, even so,  you can add your own font engine in place of LVGL's internal one. For example, you can use [FreeType](https://www.freetype.org/) to real-time render glyphs from TTF fonts or use an external flash to  store the font's bitmap and read them when the library needs them.

A ready to use FreeType can be found in [lv_freetype](https://github.com/lvgl/lv_lib_freetype) repository.

To do this, a custom `lv_font_t` variable needs to be created:

# Colors

The color module handles all color-related functions like changing  color depth, creating colors from hex code, converting between color  depths, mixing colors, etc.

The type `lv_color_t` is used to store a color. Its fields are set according to `LV_COLOR_DEPTH` in `lv_conf.h`. (See below)

You may set `LV_COLOR_16_SWAP` in `lv_conf.h` to swap bytes of *RGB565* colors. You may need this when sending 16-bit colors via a  byte-oriented interface like SPI. As 16-bit numbers are stored in  little-endian format (lower byte at the lower address), the interface  will send the lower byte first. However, displays usually need the  higher byte first. A mismatch in the byte order will result in highly  distorted colors.

## Creating colors

### RGB

Create colors from Red, Green and Blue channel values:

```
//All channels are 0-255
lv_color_t c = lv_color_make(red, green, blue);

//From hex code 0x000000..0xFFFFFF interpreted as RED + GREEN + BLUE
lv_color_t c = lv_color_hex(0x123456);

//From 3 digits. Same as lv_color_hex(0x112233)
lv_color_t c = lv_color_hex3(0x123);
```

### HSV

Create colors from Hue, Saturation and Value values:

```
//h = 0..359, s = 0..100, v = 0..100
lv_color_t c = lv_color_hsv_to_rgb(h, s, v);

//All channels are 0-255
lv_color_hsv_t c_hsv = lv_color_rgb_to_hsv(r, g, b);


//From lv_color_t variable
lv_color_hsv_t c_hsv = lv_color_to_hsv(color);
```

### Palette

LVGL includes [Material Design's palette](https://vuetifyjs.com/en/styles/colors/#material-colors) of colors. In this system all named colors have a nominal main color as well as four darker and five lighter variants.

The names of the colors are as follows:

- `LV_PALETTE_RED`
- `LV_PALETTE_PINK`
- `LV_PALETTE_PURPLE`
- `LV_PALETTE_DEEP_PURPLE`
- `LV_PALETTE_INDIGO`
- `LV_PALETTE_BLUE`
- `LV_PALETTE_LIGHT_BLUE`
- `LV_PALETTE_CYAN`
- `LV_PALETTE_TEAL`
- `LV_PALETTE_GREEN`
- `LV_PALETTE_LIGHT_GREEN`
- `LV_PALETTE_LIME`
- `LV_PALETTE_YELLOW`
- `LV_PALETTE_AMBER`
- `LV_PALETTE_ORANGE`
- `LV_PALETTE_DEEP_ORANGE`
- `LV_PALETTE_BROWN`
- `LV_PALETTE_BLUE_GREY`
- `LV_PALETTE_GREY`

To get the main color use `lv_color_t c = lv_palette_main(LV_PALETTE_...)`.

For the lighter variants of a palette color use `lv_color_t c = lv_palette_lighten(LV_PALETTE_..., v)`. `v` can be 1..5. For the darker variants of a palette color use `lv_color_t c = lv_palette_darken(LV_PALETTE_..., v)`

### Modify and mix colors

The following functions can modify a color:

```
// Lighten a color. 0: no change, 255: white
lv_color_t c = lv_color_lighten(c, lvl);

// Darken a color. 0: no change, 255: black
lv_color_t c = lv_color_darken(lv_color_t c, lv_opa_t lvl);

// Lighten or darken a color. 0: black, 128: no change 255: white
lv_color_t c = lv_color_change_lightness(lv_color_t c, lv_opa_t lvl);


// Mix two colors with a given ratio 0: full c2, 255: full c1, 128: half c1 and half c2
lv_color_t c = lv_color_mix(c1, c2, ratio);
```

### Built-in colors

`lv_color_white()` and `lv_color_black()` return `0xFFFFFF` and `0x000000` respectively.

## Opacity

To describe opacity the `lv_opa_t` type is created from `uint8_t`. Some special purpose defines are also introduced:

- `LV_OPA_TRANSP` Value: 0, means no opacity making the color completely transparent
- `LV_OPA_10` Value: 25, means the color covers only a little
- `LV_OPA_20 ... OPA_80` follow logically
- `LV_OPA_90` Value: 229, means the color near completely covers
- `LV_OPA_COVER` Value: 255, means the color completely covers (full opacity)

You can also use the `LV_OPA_*` defines in `lv_color_mix()` as a mixing *ratio*.

## Color types

The following variable types are defined by the color module:

- `lv_color1_t` Monochrome color. Also has R, G, B fields for compatibility but they are always the same value (1 byte)
- `lv_color8_t` A structure to store R (3 bit),G (3 bit),B (2 bit) components for 8-bit colors (1 byte)
- `lv_color16_t` A structure to store R (5 bit),G (6 bit),B (5 bit) components for 16-bit colors (2 byte)
- `lv_color32_t` A structure to store R (8 bit),G (8 bit), B (8 bit) components for 24-bit colors (4 byte)
- `lv_color_t` Equal to `lv_color1/8/16/24_t` depending on the configured color depth setting
- `lv_color_int_t` `uint8_t`, `uint16_t` or `uint32_t` depending on the color depth setting. Used to build color arrays from plain numbers.
- `lv_opa_t` A simple `uint8_t` type to describe opacity.

The `lv_color_t`, `lv_color1_t`, `lv_color8_t`, `lv_color16_t` and `lv_color32_t` types have four fields:

- `ch.red` red channel
- `ch.green` green channel
- `ch.blue` blue channel
- `full*` red + green + blue as one number

You can set the current color depth in *lv_conf.h*, by setting the `LV_COLOR_DEPTH` define to 1 (monochrome), 8, 16 or 32.

### Convert color

You can convert a color from the current color depth to another. The  converter functions return with a number, so you have to use the `full` field to map a converted color back into a structure:

```
lv_color_t c;
c.red   = 0x38;
c.green = 0x70;
c.blue  = 0xCC;

lv_color1_t c1;
c1.full = lv_color_to1(c);	/*Return 1 for light colors, 0 for dark colors*/

lv_color8_t c8;
c8.full = lv_color_to8(c);	/*Give a 8 bit number with the converted color*/

lv_color16_t c16;
c16.full = lv_color_to16(c); /*Give a 16 bit number with the converted color*/

lv_color32_t c24;
c32.full = lv_color_to32(c);	/*Give a 32 bit number with the converted color*/
```

# Images

An image can be a file or a variable which stores the bitmap itself and some metadata.

## Store images

You can store images in two places

- as a variable in internal memory (RAM or ROM)
- as a file

### Variables

Images stored internally in a variable are composed mainly of an `lv_img_dsc_t` structure with the following fields:

- **header**
  - *cf* Color format. See [below](https://docs.lvgl.io/master/overview/image.html#color-format)
  - *w* width in pixels (<= 2048)
  - *h* height in pixels (<= 2048)
  - *always zero* 3 bits which need to be always zero
  - *reserved* reserved for future use
- **data** pointer to an array where the image itself is stored
- **data_size** length of `data` in bytes

These are usually stored within a project as C files. They are linked into the resulting executable like any other constant data.

### Files

To deal with files you need to add a storage *Drive* to LVGL. In short, a *Drive* is a collection of functions (*open*, *read*, *close*, etc.) registered in LVGL to make file operations. You can add an interface to a standard file system (FAT32 on SD card) or you create your simple file system to read data from an SPI Flash  memory. In every case, a *Drive* is just an abstraction to read and/or write data to memory. See the [File system](https://docs.lvgl.io/master/overview/file-system.html) section to learn more.

Images stored as files are not linked into the resulting executable,  and must be read into RAM before being drawn. As a result, they are not  as resource-friendly as images linked at compile time. However, they are easier to replace without needing to rebuild the main program.

## Color formats

Various built-in color formats are supported:

- **LV_IMG_CF_TRUE_COLOR** Simply stores the RGB colors (in whatever color depth LVGL is configured for).
- **LV_IMG_CF_TRUE_COLOR_ALPHA** Like `LV_IMG_CF_TRUE_COLOR` but it also adds an alpha (transparency) byte for every pixel.
- **LV_IMG_CF_TRUE_COLOR_CHROMA_KEYED** Like `LV_IMG_CF_TRUE_COLOR` but if a pixel has the `LV_COLOR_TRANSP` color (set in *lv_conf.h*) it will be transparent.
- **LV_IMG_CF_INDEXED_1/2/4/8BIT** Uses a palette with 2, 4, 16 or 256 colors and stores each pixel in 1, 2, 4 or 8 bits.
- **LV_IMG_CF_ALPHA_1/2/4/8BIT** **Only stores the Alpha value with 1, 2, 4 or 8 bits.** The pixels take the color of `style.img_recolor` and the set opacity. The source image has to be an alpha channel. This  is ideal for bitmaps similar to fonts where the whole image is one color that can be altered.

The bytes of `LV_IMG_CF_TRUE_COLOR` images are stored in the following order.

For 32-bit color depth:

- Byte 0: Blue
- Byte 1: Green
- Byte 2: Red
- Byte 3: Alpha

For 16-bit color depth:

- Byte 0: Green 3 lower bit, Blue 5 bit
- Byte 1: Red 5 bit, Green 3 higher bit
- Byte 2: Alpha byte (only with LV_IMG_CF_TRUE_COLOR_ALPHA)

For 8-bit color depth:

- Byte 0: Red 3 bit, Green 3 bit, Blue 2 bit
- Byte 2: Alpha byte (only with LV_IMG_CF_TRUE_COLOR_ALPHA)

You can store images in a *Raw* format to indicate that it's not encoded with one of the built-in color formats and an external [Image decoder](https://docs.lvgl.io/master/overview/image.html#image-decoder) needs to be used to decode the image.

- **LV_IMG_CF_RAW** Indicates a basic raw image (e.g. a PNG or JPG image).
- **LV_IMG_CF_RAW_ALPHA** Indicates that an image has alpha and an alpha byte is added for every pixel.
- **LV_IMG_CF_RAW_CHROMA_KEYED** Indicates that an image is chroma-keyed as described in `LV_IMG_CF_TRUE_COLOR_CHROMA_KEYED` above.

## Add and use images

You can add images to LVGL in two ways:

- using the online converter
- manually create images

### Online converter

The online Image converter is available here: https://lvgl.io/tools/imageconverter

Adding an image to LVGL via the online converter is easy.

1. You need to select a *BMP*, *PNG* or *JPG* image first.
2. Give the image a name that will be used within LVGL.
3. Select the [Color format](https://docs.lvgl.io/master/overview/image.html#color-formats).
4. Select the type of image you want. Choosing a binary will generate a `.bin` file that must be stored separately and read using the [file support](https://docs.lvgl.io/master/overview/image.html#files). Choosing a variable will generate a standard C file that can be linked into your project.
5. Hit the *Convert* button. Once the conversion is finished, your browser will automatically download the resulting file.

In the generated C arrays (variables), bitmaps for all the color  depths (1, 8, 16 or 32) are included in the C file, but only the color  depth that matches `LV_COLOR_DEPTH` in *lv_conf.h* will actually be linked into the resulting executable.

In the case of binary files, you need to specify the color format you want:

- RGB332 for 8-bit color depth
- RGB565 for 16-bit color depth
- RGB565 Swap for 16-bit color depth (two bytes are swapped)
- RGB888 for 32-bit color depth

### Manually create an image

If you are generating an image at run-time, you can craft an image variable to display it using LVGL. For example:

```
uint8_t my_img_data[] = {0x00, 0x01, 0x02, ...};

static lv_img_dsc_t my_img_dsc = {
    .header.always_zero = 0,
    .header.w = 80,
    .header.h = 60,
    .data_size = 80 * 60 * LV_COLOR_DEPTH / 8,
    .header.cf = LV_IMG_CF_TRUE_COLOR,          /*Set the color format*/
    .data = my_img_data,
};
```

If the color format is `LV_IMG_CF_TRUE_COLOR_ALPHA` you can set `data_size` like `80 * 60 * LV_IMG_PX_SIZE_ALPHA_BYTE`.

Another (possibly simpler) option to create and display an image at run-time is to use the [Canvas](https://docs.lvgl.io/master/widgets/core/canvas.html) object.

### Use images

The simplest way to use an image in LVGL is to display it with an [lv_img](https://docs.lvgl.io/master/widgets/core/img.html) object:

```
lv_obj_t * icon = lv_img_create(lv_scr_act(), NULL);

/*From variable*/
lv_img_set_src(icon, &my_icon_dsc);

/*From file*/
lv_img_set_src(icon, "S:my_icon.bin");
```

If the image was converted with the online converter, you should use `LV_IMG_DECLARE(my_icon_dsc)` to declare the image in the file where you want to use it.

## Image decoder

As you can see in the [Color formats](https://docs.lvgl.io/master/overview/image.html#color-formats) section, LVGL supports several built-in image formats. In many cases,  these will be all you need. LVGL doesn't directly support, however,  generic image formats like PNG or JPG.

To handle non-built-in image formats, you need to use external libraries and attach them to LVGL via the *Image decoder* interface.

An image decoder consists of 4 callbacks:

- **info** get some basic info about the image (width, height and color format).
- **open** open an image: either store a decoded image or set it to `NULL` to indicate the image can be read line-by-line.
- **read** if *open* didn't fully open an image this function should give some decoded data (max 1 line) from a given position.
- **close** close an opened image, free the allocated resources.

You can add any number of image decoders. When an image needs to be  drawn, the library will try all the registered image decoders until it  finds one which can open the image, i.e. one which knows that format.

The `LV_IMG_CF_TRUE_COLOR_...`, `LV_IMG_INDEXED_...` and `LV_IMG_ALPHA_...` formats (essentially, all non-`RAW` formats) are understood by the built-in decoder.

## Image caching

Sometimes it takes a lot of time to open an image. Continuously decoding a PNG image or loading images from a slow external memory would be inefficient and detrimental to the user experience.

Therefore, LVGL caches a given number of images. Caching means some  images will be left open, hence LVGL can quickly access them from `dsc->img_data` instead of needing to decode them again.

Of course, caching images is resource intensive as it uses more RAM  to store the decoded image. LVGL tries to optimize the process as much  as possible (see below), but you will still need to evaluate if this  would be beneficial for your platform or not. Image caching may not be  worth it if you have a deeply embedded target which decodes small images from a relatively fast storage medium.

### Cache size

The number of cache entries can be defined with `LV_IMG_CACHE_DEF_SIZE` in *lv_conf.h*. The default value is 1 so only the most recently used image will be left open.

The size of the cache can be changed at run-time with `lv_img_cache_set_size(entry_num)`.

### Value of images

When you use more images than cache entries, LVGL can't cache all the images. Instead, the library will close one of the cached images to  free space.

To decide which image to close, LVGL uses a measurement it previously made of how long it took to open the image. Cache entries that hold  slower-to-open images are considered more valuable and are kept in the  cache as long as possible.

If you want or need to override LVGL's measurement, you can manually set the *time to open* value in the decoder open function in `dsc->time_to_open = time_ms` to give a higher or lower value. (Leave it unchanged to let LVGL control it.)

Every cache entry has a *"life"* value. Every time an image is opened through the cache, the *life* value of all entries is decreased to make them older. When a cached image is used, its *life* value is increased by the *time to open* value to make it more alive.

If there is no more space in the cache, the entry with the lowest life value will be closed.

### Memory usage

Note that a cached image might continuously consume memory. For  example, if three PNG images are cached, they will consume memory while  they are open.

Therefore, it's the user's responsibility to be sure there is enough RAM to cache even the largest images at the same time.

### Clean the cache

Let's say you have loaded a PNG image into a `lv_img_dsc_t my_png` variable and use it in an `lv_img` object. If the image is already cached and you then change the  underlying PNG file, you need to notify LVGL to cache the image again.  Otherwise, there is no easy way of detecting that the underlying file  changed and LVGL will still draw the old image from cache.

To do this, use `lv_img_cache_invalidate_src(&my_png)`. If `NULL` is passed as a parameter, the whole cache will be cleaned.