# Events

Events are triggered in LVGL when something happens which might be interesting to the user, e.g. when an object

- is clicked
- is scrolled
- has its value changed
- is redrawn, etc.

## Add events to the object

The user can assign callback functions to an object to see its events. In practice, it looks like this:

```
lv_obj_t * btn = lv_btn_create(lv_scr_act());
lv_obj_add_event_cb(btn, my_event_cb, LV_EVENT_CLICKED, NULL);   /*Assign an event callback*/

...

static void my_event_cb(lv_event_t * event)
{
    printf("Clicked\n");
}
```

In the example `LV_EVENT_CLICKED` means that only the click event will call `my_event_cb`. See the [list of event codes](https://docs.lvgl.io/master/overview/event.html#event-codes) for all the options. `LV_EVENT_ALL` can be used to receive all events.

The last parameter of `lv_obj_add_event_cb` is a pointer to any custom data that will be available in the event. 

More events can be added to an objects like this:

```
lv_obj_add_event_cb(obj, my_event_cb_1, LV_EVENT_CLICKED, NULL);
lv_obj_add_event_cb(obj, my_event_cb_2, LV_EVENT_PRESSED, NULL);
lv_obj_add_event_cb(obj, my_event_cb_3, LV_EVENT_ALL, NULL);		/*No filtering, receive all events*/
```

Even the same callback event can be use on an objects with different `user_data`. For example:

```
lv_obj_add_event_cb(obj, increment_on_click, LV_EVENT_CLICKED, &num1);
lv_obj_add_event_cb(obj, increment_on_click, LV_EVENT_CLICKED, &num2);
```

The events will be called in order as they were added.

## Remove event(s) from an object

Events can be removed from an object with the `lv_obj_remove_event_cb(obj, event_cb)` function or `lv_obj_remove_event_dsc(obj, event_dsc)`. `event_dsc` is a pointer returned by `lv_obj_add_event_cb`.

## Event codes

The event codes can be grouped into these categories:

- Input device events
- Drawing events
- Other events
- Special events
- Custom events

All objects (such as Buttons/Labels/Sliders etc.) regardless their type receive the *Input device*, *Drawing* and *Other* events.

However the *Special events* are specific to a particular widget type

*Custom events* are added by the user and therefore these are never sent by LVGL.

he following event codes exist:

### Input device events

- `LV_EVENT_PRESSED`      The object has been pressed
- `LV_EVENT_PRESSING`     The object is being pressed (called continuously while pressing)
- `LV_EVENT_PRESS_LOST`   The object is still being pressed but slid cursor/finger off of the object
- `LV_EVENT_SHORT_CLICKED`    The object was pressed for a short period of time, then released it. Not called if scrolled.
- `LV_EVENT_LONG_PRESSED` Object has been pressed for at least the `long_press_time` specified in the input device driver.  Not called if scrolled.
- `LV_EVENT_LONG_PRESSED_REPEAT`  Called after `long_press_time` in every `long_press_repeat_time` ms.  Not called if scrolled.
- `LV_EVENT_CLICKED`      Called on release if the object did not scroll (regardless of long press)
- `LV_EVENT_RELEASED`     Called in every case when the object has been released
- `LV_EVENT_SCROLL_BEGIN` Scrolling begins. The event paramter is `NULL` or an `lv_anim_t *` with the scroll animation descriptor to modify if required.
- `LV_EVENT_SCROLL_END`   Scrolling ends.
- `LV_EVENT_SCROLL`       The object was scrolled
- `LV_EVENT_GESTURE`      A gesture is detected. Get the gesture with `lv_indev_get_gesture_dir(lv_indev_get_act());`
- `LV_EVENT_KEY`          A key is sent to the object. Get the key with `lv_indev_get_key(lv_indev_get_act());`
- `LV_EVENT_FOCUSED`      The object is focused
- `LV_EVENT_DEFOCUSED`    The object is defocused
- `LV_EVENT_LEAVE`        The object is defocused but still selected
- `LV_EVENT_HIT_TEST`     Perform advanced hit-testing. Use `lv_hit_test_info_t * a = lv_event_get_hit_test_info(e)` and check if `a->point` can click the object or not. If not set `a->res = false`

### Drawing events

- `LV_EVENT_COVER_CHECK` Check if the object fully covers an area. The event parameter is `lv_cover_check_info_t *`.
- `LV_EVENT_REFR_EXT_DRAW_SIZE`  Get the required extra draw area around the object (e.g. for shadow). The event parameter is `lv_coord_t *` to store the size. Overwrite it only with a larger value.
- `LV_EVENT_DRAW_MAIN_BEGIN` Starting the main drawing phase.
- `LV_EVENT_DRAW_MAIN`   Perform the main drawing
- `LV_EVENT_DRAW_MAIN_END`   Finishing the main drawing phase
- `LV_EVENT_DRAW_POST_BEGIN` Starting the post draw phase (when all children are drawn)
- `LV_EVENT_DRAW_POST`   Perform the post draw phase (when all children are drawn)
- `LV_EVENT_DRAW_POST_END`   Finishing the post draw phase (when all children are drawn)
- `LV_EVENT_DRAW_PART_BEGIN` Starting to draw a part. The event parameter is `lv_obj_draw_dsc_t *`. Learn more [here](https://docs.lvgl.io/8.0/overview/drawing.html).
- `LV_EVENT_DRAW_PART_END`   Finishing to draw a part. The event parameter is `lv_obj_draw_dsc_t *`. Learn more [here](https://docs.lvgl.io/8.0/overview/drawing.html).

### Other events

- `LV_EVENT_DELETE`       Object is being deleted
- `LV_EVENT_CHILD_CHANGED`    Child was removed/added
- `LV_EVENT_SIZE_CHANGED`    Object coordinates/size have changed
- `LV_EVENT_STYLE_CHANGED`    Object's style has changed
- `LV_EVENT_BASE_DIR_CHANGED` The base dir has changed
- `LV_EVENT_GET_SELF_SIZE`    Get the internal size of a widget

### Special events

- `LV_EVENT_VALUE_CHANGED`    The object's value has changed (i.e. slider moved)
- `LV_EVENT_INSERT`       A text is being inserted to the object. The event data is `char *` being inserted.
- `LV_EVENT_REFRESH`      Notify the object to refresh something on it (for the user)
- `LV_EVENT_READY`        A process has finished
- `LV_EVENT_CANCEL`       A process has been canceled

### Custom events

Any custom event codes can be registered by `uint32_t MY_EVENT_1 = lv_event_register_id();`

And can be sent to any object with `lv_event_send(obj, MY_EVENT_1, &some_data)`

## Sending events

To manually send events to an object, use `lv_event_send(obj, <EVENT_CODE> &some_data)`.

For example, this can be used to manually close a message box by  simulating a button press (although there are simpler ways to do this):

```
/*Simulate the press of the first button (indexes start from zero)*/
uint32_t btn_id = 0;
lv_event_send(mbox, LV_EVENT_VALUE_CHANGED, &btn_id);
```

### Refresh event

`LV_EVENT_REFRESH` is special event because it's designed to be used by the user to notify an object to refresh itself. Some examples:

- notify a label to refresh its text according to one or more variables (e.g. current time)
- refresh a label when the language changes
- enable a button if some conditions are met (e.g. the correct PIN is entered)
- add/remove styles to/from an object if a limit is exceeded, etc

## Fields of lv_event_t

`lv_event_t` is the only parameter passed to event callback and it contains all the  data about the event. The following values can be gotten from it:

- `lv_event_get_code(e)` get the event code
- `lv_event_get_target(e)` get the object to which the event is sent
- `lv_event_get_original_target(e)` get the object to which the event is sent originally sent (different from `lv_event_get_target` if [event bubbling](https://docs.lvgl.io/8.0/overview/event.html#event-bubbling) is enabled)
- `lv_event_get_user_data(e)` get the pointer passed as the last parameter of `lv_obj_add_event_cb`.
- `lv_event_get_param(e)` get the parameter passed as the last parameter of `lv_event_send`

## Event bubbling

If `lv_obj_add_flag(obj, LV_OBJ_FLAG_EVENT_BUBBLE)` is enabled all events will be sent to the object's parent too. If the parent also has `LV_OBJ_FLAG_EVENT_BUBBLE` enabled the event will be sent to its parent too, and so on.

The *target* parameter of the event is always the current target object, not the original object. To get the original target call `lv_event_get_original_target(e)` in the event handler.

If `lv_obj_add_flag(obj, LV_OBJ_FLAG_EVENT_BUBBLE)` is enabled all events will be sent to the object's parent too. If the parent also has `LV_OBJ_FLAG_EVENT_BUBBLE` enabled the event will be sent to its parent too, and so on.

# Input devices

An input device usually means:

- Pointer-like input device like touchpad or mouse
- Keypads like a normal keyboard or simple numeric keypad
- Encoders with left/right turn and push options
- External hardware buttons which are assigned to specific points on the screen

## Pointers

Pointer input devices (like a mouse) can have a cursor.

```
...
lv_indev_t * mouse_indev = lv_indev_drv_register(&indev_drv);

LV_IMG_DECLARE(mouse_cursor_icon);                          /*Declare the image file.*/
lv_obj_t * cursor_obj =  lv_img_create(lv_scr_act(), NULL); /*Create an image object for the cursor */
lv_img_set_src(cursor_obj, &mouse_cursor_icon);             /*Set the image source*/
lv_indev_set_cursor(mouse_indev, cursor_obj);               /*Connect the image  object to the driver*/
```

Note that the cursor object should have `lv_obj_set_click(cursor_obj, false)`. For images, *clicking* is disabled by default.

## Keypad and encoder

You can fully control the user interface without touchpad or mouse using a keypad or encoder(s). It works similar to the *TAB* key on the PC to select the element in an application or a web page.

### Groups

The objects, you want to control with keypad or encoder, needs to be added to a *Group*. In every group, there is exactly one focused object which receives the pressed keys or the encoder actions. For example, if a [Text area](https://docs.lvgl.io/8.0/widgets/core/textarea.html) is focused and you press some letter on a keyboard, the keys will be sent and inserted into the text area. Similarly, if a [Slider](https://docs.lvgl.io/8.0/widgets/core/slider.html) is focused and you press the left or right arrows, the slider's value will be changed.

You need to associate an input device with a group. An input device  can send the keys to only one group but, a group can receive data from  more than one input device too.

To create a group use `lv_group_t * g = lv_group_create()` and to add an object to the group use `lv_group_add_obj(g, obj)`.

To associate a group with an input device use `lv_indev_set_group(indev, g)`, where `indev` is the return value of `lv_indev_drv_register()`

#### Keys

There are some predefined keys which have special meaning:

- **LV_KEY_NEXT** Focus on the next object
- **LV_KEY_PREV** Focus on the previous object
- **LV_KEY_ENTER** Triggers `LV_EVENT_PRESSED/CLICKED/LONG_PRESSED` etc. events
- **LV_KEY_UP** Increase value or move upwards
- **LV_KEY_DOWN** Decrease value or move downwards
- **LV_KEY_RIGHT** Increase value or move the the right
- **LV_KEY_LEFT** Decrease value or move the the left
- **LV_KEY_ESC**  Close or exit (E.g. close a [Drop down list](https://docs.lvgl.io/8.0/widgets/core/dropdown.html))
- **LV_KEY_DEL**  Delete (E.g. a character on the right in a [Text area](https://docs.lvgl.io/8.0/widgets/core/textarea.html))
- **LV_KEY_BACKSPACE** Delete a character on the left (E.g. in a [Text area](https://docs.lvgl.io/8.0/widgets/core/textarea.html))
- **LV_KEY_HOME** Go to the beginning/top (E.g. in a [Text area](https://docs.lvgl.io/8.0/widgets/core/textarea.html))
- **LV_KEY_END** Go to the end (E.g. in a [Text area](https://docs.lvgl.io/8.0/widgets/core/textarea.html)))

The most important special keys are `LV_KEY_NEXT/PREV`, `LV_KEY_ENTER` and `LV_KEY_UP/DOWN/LEFT/RIGHT`. In your `read_cb` function, you should translate some of your keys to these special keys  to navigate in the group and interact with the selected object.

Usually, it's enough to use only `LV_KEY_LEFT/RIGHT` because most of the objects can be fully controlled with them.

With an encoder, you should use only `LV_KEY_LEFT`, `LV_KEY_RIGHT`, and `LV_KEY_ENTER`.

#### Edit and navigate mode

Since a keypad has plenty of keys, it's easy to navigate between the  objects and edit them using the keypad. But the encoders have a limited  number of "keys" and hence it is difficult to navigate using the default options. *Navigate* and *Edit* are created to avoid this problem with the encoders.

In *Navigate* mode, the encoders `LV_KEY_LEFT/RIGHT` is translated to `LV_KEY_NEXT/PREV`. Therefore the next or previous object will be selected by turning the encoder. Pressing `LV_KEY_ENTER` will change to *Edit* mode.

In *Edit* mode, `LV_KEY_NEXT/PREV` is usually used to edit the object. Depending on the object's type, a short or long press of `LV_KEY_ENTER` changes back to *Navigate* mode. Usually, an object which can not be pressed (like a [Slider](https://docs.lvgl.io/8.0/widgets/core/slider.html)) leaves *Edit* mode on short click. But with objects where short click has meaning (e.g. [Button](https://docs.lvgl.io/8.0/widgets/core/btn.html)), a long press is required.

#### Default group

Interactive widgets - such as buttons, checkboxes, sliders, etc - can be automatically added to a default group. Just create a group with `lv_group_t * g = lv_group_create();` and set the default group with `lv_group_set_default(g);`

Don't forget to assign the input device(s) to the default group with ` lv_indev_set_group(my_indev, g);`.

### Styling

If an object is focused either by clicking it via touchpad, or focused via an encoder or keypad it goes to `LV_STATE_FOCUSED`. Hence focused styles will be applied on it.

If the object goes to edit mode it goes to `LV_STATE_FOCUSED | LV_STATE_EDITED` state so these style properties will be shown.

# Displays

## Multiple display support

In LVGL, you can have multiple displays, each with their own driver  and objects. The only limitation is that every display needs to be have  same color depth (as defined in `LV_COLOR_DEPTH`). If the displays are different in this regard the rendered image can be converted to the correct format in the drivers `flush_cb`.

Creating more displays is easy: just initialize more display buffers and register another driver for every display. When you create the UI, use `lv_disp_set_default(disp)` to tell the library on which display to create objects.

Why would you want multi-display support? Here are some examples:

- Have a "normal" TFT display with local UI and create "virtual" screens on VNC on demand. (You need to add your VNC driver).
- Have a large TFT display and a small monochrome display.
- Have some smaller and simple displays in a large instrument or technology.
- Have two large TFT displays: one for a customer and one for the shop assistant.

### Mirror display

To mirror the image of the display to another display, you don't need to use the multi-display support. Just transfer the buffer received in `drv.flush_cb` to the other display too.

### Split image

You can create a larger display from smaller ones. You can create it as below:

1. Set the resolution of the displays to the large display's resolution.
2. In `drv.flush_cb`, truncate and modify the `area` parameter for each display.
3. Send the buffer's content to each display with the truncated area.

Every display has each set of [Screens](https://docs.lvgl.io/8.0/overview/overview/object#screen-the-most-basic-parent) and the object on the screens.

Be sure not to confuse displays and screens:

- **Displays** are the physical hardware drawing the pixels.
- **Screens** are the high-level root objects  associated with a particular display. One display can have multiple  screens associated with it, but not vice versa.

Screens can be considered the highest level containers which have no  parent. The screen's size is always equal to its display and size their position is (0;0). Therefore, the screens coordinates can't be changed, i.e. `lv_obj_set_pos()`, `lv_obj_set_size()` or similar functions can't be used on screens.

A screen can be created from any object type but the two most typical types are the [Base object](https://docs.lvgl.io/8.0/widgets/obj.html) and the [Image](https://docs.lvgl.io/8.0/widgets/core/img.html) (to create a wallpaper).

To create a screen, use `lv_obj_t * scr = lv_<type>_create(NULL, copy)`. `copy` can be an other screen to copy it.

To load a screen, use `lv_scr_load(scr)`. To get the active screen, use `lv_scr_act()`. These functions works on the default display. If you want to to specify which display to work on, use `lv_disp_get_scr_act(disp)` and `lv_disp_load_scr(disp, scr)`. Screen can be loaded with animations too. Read more [here](https://docs.lvgl.io/8.0/overview/object.html#load-screens).

Screens can be deleted with `lv_obj_del(scr)`, but ensure that you do not delete the currently loaded screen.

Usually, the opacity of the screen is `LV_OPA_COVER` to provide a solid background for its children. If it's not the case  (opacity < 100%) the display's background color or image will be  visible. See the [Display background](https://docs.lvgl.io/8.0/overview/display.html#display-background) section for more details. If the display's background opacity is also not `LV_OPA_COVER` LVGL has no solid background to draw.

This configuration (transparent screen and display) could be used to  create for example OSD menus where a video is played on a lower layer,  and a menu is overlayed on an upper layer.

To handle transparent displays special (slower) color mixing  algorithms need to be used by LVGL so this feature needs to enabled with `LV_COLOR_SCREEN_TRANSP` in `lv_conf.h`. As this mode operates on the Alpha channel of the pixels `LV_COLOR_DEPTH = 32` is also required. The Alpha channel of 32-bit colors will be 0 where  there are no objects and 255 where there are solid objects.

In summary, to enable transparent screen and displays to create OSD menu-like UIs:

- Enable `LV_COLOR_SCREEN_TRANSP` in `lv_conf.h`
- Be sure to use `LV_COLOR_DEPTH 32`
- Set the screens opacity to `LV_OPA_TRANSP` e.g. with `lv_obj_set_style_local_bg_opa(lv_scr_act(), LV_OBJMASK_PART_MAIN, LV_STATE_DEFAULT, LV_OPA_TRANSP)`
- Set the display opacity to `LV_OPA_TRANSP` with `lv_disp_set_bg_opa(NULL, LV_OPA_TRANSP);`

## Features of displays

### Inactivity

The user's inactivity is measured on each display. Every use of an [Input device](https://docs.lvgl.io/8.0/overview/indev.html) (if [associated with the display](https://docs.lvgl.io/porting/indev#other-features)) counts as an activity. To get time elapsed since the last activity, use `lv_disp_get_inactive_time(disp)`. If `NULL` is passed, the overall smallest inactivity time will be returned from all displays (**not the default display**).

You can manually trigger an activity using `lv_disp_trig_activity(disp)`. If `disp` is `NULL`, the default screen will be used (**and not all displays**).

### Background

Every display has background color, a background image and background opacity properties. They become visible when the current screen is  transparent or not positioned to cover the whole display.

Background color is a simple color to fill the display. It can be adjusted with `lv_disp_set_bg_color(disp, color)`;

Background image is a path to a file or a pointer to an `lv_img_dsc_t` variable (converted image) to be used as wallpaper. It can be set with `lv_disp_set_bg_color(disp, &my_img)`; If the background image is set (not `NULL`) the background won't be filled with `bg_color`.

The opacity of the background color or image can be adjusted with `lv_disp_set_bg_opa(disp, opa)`.

The `disp` parameter of these functions can be `NULL` to refer it to the default display.