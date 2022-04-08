# LVGL QUICK INTRODUCTION

## Add LVGL into your project

The following steps show how to setup LVGL on an embedded system with a display and a touchpad.

- [Download](https://github.com/lvgl/lvgl/archive/master.zip) or Clone the library from GitHub with `git clone https://github.com/lvgl/lvgl.git` and checkout to prefered version
- Copy the `lvgl` folder into your project
- Copy `lvgl/lv_conf_template.h` as `lv_conf.h` next to the `lvgl` folder, change the first `#if 0` to `1` to enable the file's content and set at least `LV_HOR_RES_MAX`, `LV_VER_RES_MAX` and `LV_COLOR_DEPTH` defines.
- Include `lvgl/lvgl.h` where you need to use LVGL related functions.
- Call `lv_tick_inc(x)` every `x` milliseconds **in a Timer or Task** (`x` should be between 1 and 10). It is required for the internal timing of LVGL. Alternatively, configure `LV_TICK_CUSTOM` (see `lv_conf.h`) so that LVGL can retrieve the current time directly.
- Call `lv_init()`
- Create a display buffer for LVGL. LVGL will render the graphics  here first, and seed the rendered image to the display. The buffer size  can be set freely but 1/10 screen size is a good starting point.

```
static lv_disp_buf_t disp_buf;
static lv_color_t buf[LV_HOR_RES_MAX * LV_VER_RES_MAX / 10];                     /*Declare a buffer for 1/10 screen size*/
lv_disp_buf_init(&disp_buf, buf, NULL, LV_HOR_RES_MAX * LV_VER_RES_MAX / 10);    /*Initialize the display buffer*/
```

- Implement and register a function which can **copy the rendered image** to an area of your display:

```
lv_disp_drv_t disp_drv;               /*Descriptor of a display driver*/
lv_disp_drv_init(&disp_drv);          /*Basic initialization*/
disp_drv.flush_cb = my_disp_flush;    /*Set your driver function*/
disp_drv.buffer = &disp_buf;          /*Assign the buffer to the display*/
lv_disp_drv_register(&disp_drv);      /*Finally register the driver*/
```

Call `lv_timer_handler()` periodically every few milliseconds in the main `while(1)` loop or in an operating system task. It will redraw the screen if required, handle input devices, animation etc.

### Widgets

The graphical elements like Buttons, Labels, Sliders, Charts etc. are called objects or widgets. Go to [Widgets](https://docs.lvgl.io/8.0/widgets/index.html) to see the full list of available widgets.

Every object has a parent object where it is created. For example if a label is created on a button, the button is the parent of label.

The child object moves with the parent and if the parent is deleted the children will be deleted too.

Children can be visible only on their parent. It other words, the parts of the children outside of the parent are clipped.

A Screen is the "root" parent. You can have any number of screens.

To get the current screen call `lv_scr_act()`, and to load a screen use `lv_scr_load(scr1)`.

You can create a new object with `lv_<type>_create(parent)`. It will return an `lv_obj_t *` variable that can be used as a reference to the object to set its parameters

For example:

```c
lv_obj_t * slider1 = lv_slider_create(lv_scr_act());
```

To set some basic attributes `lv_obj_set_<parameter_name>(obj, <value>)` functions can be used. For example:

```c
lv_obj_set_x(btn1, 30);
lv_obj_set_y(btn1, 10);
lv_obj_set_size(btn1, 200, 50);
```

The widgets have type specific parameters too which can be set by `lv_<widget_type>_set_<parameter_name>(obj, <value>)` functions. For example:

```c
lv_slider_set_value(slider1, 70, LV_ANIM_ON);
```

### Events

Events are used to inform the user that something has happened with  an object. You can assign one or more callbacks to an object which will be called  if the object is clicked, released, dragged, being deleted etc.

A callback is assigned like this:

```
lv_obj_add_event_cb(btn, btn_event_cb, LV_EVENT_CLICKED, NULL); /*Assign a callback to the button*/

...

void btn_event_cb(lv_event_t * e)
{
    printf("Clicked\n");
}
```

Instead of `LV_EVENT_CLICKED` `LV_EVENT_ALL` can be used too to call the callback for any event.

From `lv_event_t * e` the current event code can be get with

```
lv_event_code_t code = lv_event_get_code(e);
```

The object that triggered the event can be retrieved with

```
lv_obj_t * obj = lv_event_get_target(e);
```

### Parts

Widgets might be built from one or more *parts*. For example a button has only one part called `LV_PART_MAIN`. However, a [Slider](https://docs.lvgl.io/8.0/widgets/core/slider.html) has `LV_PART_MAIN`, `LV_PART_INDICATOR` and `LV_PART_KNOB`.

The following predefined parts exist in LVGL:

- `LV_PART_MAIN` A background like rectangle*/``
- `LV_PART_SCROLLBAR`  The scrollbar(s)
- `LV_PART_INDICATOR` Indicator, e.g. for slider, bar, switch, or the tick box of the checkbox
- `LV_PART_KNOB` Like a handle to grab to adjust the value*/
- `LV_PART_SELECTED` Indicate the currently selected option or section
- `LV_PART_ITEMS` Used if the widget has multiple similar elements (e.g. tabel cells)*/
- `LV_PART_TICKS` Ticks on scales e.g. for a chart or meter
- `LV_PART_CURSOR` Mark a specific place e.g. text area's or chart's cursor
- `LV_PART_CUSTOM_FIRST` Custom parts can be added from here.

### States

The objects can be in a combination of the following states:

- `LV_STATE_DEFAULT`  Normal, released state
- `LV_STATE_CHECKED`  Toggled or checked state
- `LV_STATE_FOCUSED` Focused via keypad or encoder or clicked via touchpad/mouse
- `LV_STATE_FOCUS_KEY`  Focused via keypad or encoder but not via touchpad/mouse
- `LV_STATE_EDITED` Edit by an encoder
- `LV_STATE_HOVERED` Hovered by mouse (not supported now)
- `LV_STATE_PRESSED` Being pressed
- `LV_STATE_SCROLLED` Being scrolled
- `LV_STATE_DISABLED` Disabled

For example, if you press an object it will automatically go to `LV_STATE_FOCUSED` and `LV_STATE_PRESSED` state and when you release it, the  `LV_STATE_PRESSED` state will be removed.

To check if an object is in a given state use `lv_obj_has_state(obj, LV_STATE_...)`. It will return `true` if the object is in that state at that time.

To manually add or remove states use

```
lv_obj_add_state(obj, LV_STATE_...);
lv_obj_clear_state(obj, LV_STATE_...);
```

### Styles

Styles contains properties such as background color, border width, font, etc to describe the appearance of the objects.

The styles are `lv_style_t` variables. Only their pointer is saved in the objects so they need to be static or global. Before using a style it needs to be initialized with `lv_style_init(&style1)`. After that properties can be added. For example:

```
static lv_style_t style1;
lv_style_init(&style1);
lv_style_set_bg_color(&style1, lv_color_hex(0xa03080))
lv_style_set_border_width(&style1, 2))
```

The styles are assigned to an object's part and state. For example to *"Use this style on the slider's indicator when the slider is pressed"*:

```c
lv_obj_add_style(slider1, &style1, LV_PART_INDICATOR | LV_STATE_PRESSED);
```

If the *part* is `LV_PART_MAIN` it can be omitted:

```c
lv_obj_add_style(btn1, &style1, LV_STATE_PRESSED); /*Equal to LV_PART_MAIN | LV_STATE_PRESSED*/
```

Similarly, `LV_STATE_DEFAULT` can be omitted too:

```c
lv_obj_add_style(slider1, &style1, LV_PART_INDICATOR); /*Equal to LV_PART_INDICATOR | LV_STATE_DEFAULT*/
```

For `LV_STATE_DEFAULT` and `LV_PART_MAIN` simply write `0`:

```c
lv_obj_add_style(btn1, &style1, 0); /*Equal to LV_PART_MAIN | LV_STATE_DEFAULT*/
```

The styles can be cascaded (similarly to CSS). It means you can add more styles to a part of an object. For example `style_btn` can set a default button appearance, and `style_btn_red` can overwrite the background color to make the button red:

```
lv_obj_add_style(btn1, &style_btn, 0);
lv_obj_add_style(btn1, &style1_btn_red, 0);
```

If a property is not set on for the current state the style with `LV_STATE_DEFAULT` will be used. If the property is not defined even in the default state a default value is used.

Some properties (typically the text-related ones) can be inherited.  It means if a property is not set in an object it will be searched in  its parents too. For example, you can set the font once in the screen's style and all  text on that screen will inherit it by default.

Local style properties also can be added to the objects. It creates a style which resides inside the object and which is used only by the  object:

```
lv_obj_set_style_bg_color(slider1, lv_color_hex(0x2080bb), LV_PART_INDICATOR | LV_STATE_PRESSED);
```

# Logging

LVGL has built-in *Log* module to inform the user about what is happening in the library.

## Log level

To enable logging, set `LV_USE_LOG 1` in `lv_conf.h` and set `LV_LOG_LEVEL` to one of the following values:

- `LV_LOG_LEVEL_TRACE` A lot of logs to give detailed information
- `LV_LOG_LEVEL_INFO`  Log important events
- `LV_LOG_LEVEL_WARN`  Log if something unwanted happened but didn't cause a problem
- `LV_LOG_LEVEL_ERROR` Only critical issues, where the system may fail
- `LV_LOG_LEVEL_USER` Only user messages
- `LV_LOG_LEVEL_NONE`  Do not log anything

The events which have a higher level than the set log level will be logged too. E.g. if you `LV_LOG_LEVEL_WARN`, errors will be also logged.

## Printing logs

### Logging with printf

If your system supports `printf`, you just need to enable `LV_LOG_PRINTF` in `lv_conf.h` to send the logs with `printf`.

### Custom log function

If you can't use `printf` or want to use a custom function to log, you can register a "logger" callback with `lv_log_register_print_cb()`.

For example:

```
void my_log_cb(const char * buf)
{
  serial_send(buf, strlen(buf));
}

...


lv_log_register_print_cb(my_log_cb);
```

## Add logs

You can also use the log module via the `LV_LOG_TRACE/INFO/WARN/ERROR/USER(text)` functions.

to find and read more information

*  https://docs.lvgl.io/8.0/get-started/index.html
*  https://docs.lvgl.io/8.0/porting/index.html

to read a quick overview [here](Documentaion/LVGL_quick_overview.md)

to read more about styles [here](Documentation/LVGL_styles.md)

to read more about events , input device and displays [here](Documentation/LVGL_events_indev_disp.md)

to read more about layers , fonts , colors and image [here](Documentation/LVGL_layers_fonts_colors_images.md)

to read more about file system, timers and animation [here](Documentation/LVGL_animations_timer_filesystem.md)

