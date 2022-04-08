# LVGL QUICK OVERVIEW

## Objects

In LVGL the **basic building blocks** of a user interface are the objects, also called *Widgets*. For example a [Button](https://docs.lvgl.io/8.0/widgets/core/btn.html), [Label](https://docs.lvgl.io/8.0/widgets/core/label.html), [Image](https://docs.lvgl.io/8.0/widgets/core/img.html), [List](https://docs.lvgl.io/8.0/widgets/extra/list.html), [Chart](https://docs.lvgl.io/8.0/widgets/extra/chart.html) or [Text area](https://docs.lvgl.io/8.0/widgets/core/textarea.html).

All objects are referenced using an `lv_obj_t` pointer as a handle. This pointer can later be used to set or get the attributes of the object.

## Attributes

### Basic attributes

All object types share some basic attributes:

- Position
- Size
- Parent
- Styles
- Event handlers
- Etc

You can set/get these attributes with `lv_obj_set_...` and `lv_obj_get_...` functions. For example:

```
/*Set basic object attributes*/
lv_obj_set_size(btn1, 100, 50);	  /*Set a button's size*/
lv_obj_set_pos(btn1, 20,30);      /*Set a button's position*/
```

### Specific attributes

The object types have special attributes too. For example, a slider has

- Minimum and maximum values
- Current value

For these special attributes, every object type may have unique API functions.

### Moving together

If the position of the parent changes the children will move with the parent. Therefore all positions are relative to the parent.

```
lv_obj_t * parent = lv_obj_create(lv_scr_act());   /*Create a parent object on the current screen*/
lv_obj_set_size(parent, 100, 80);	                 /*Set the size of the parent*/

lv_obj_t * obj1 = lv_obj_create(parent);	         /*Create an object on the previously created parent object*/
lv_obj_set_pos(obj1, 10, 10);	                     /*Set the position of the new object*/
```

Modify the position of the parent:

```
lv_obj_set_pos(parent, 50, 50);	/*Move the parent. The child will move with it.*/
```

### Visibility only on the parent

If a child is partially or fully out of its parent then the parts outside will not be visible.

```
lv_obj_set_x(obj1, -30);	/*Move the child a little bit off the parent*/
```

### Create and delete objects

In LVGL objects can be created and deleted dynamically in run time.  It means only the currently created (existing) objects consume RAM.

This allows for the creation of a screen just when a button is  clicked to open it, and for deletion of screens when a new screen is  loaded.

UIs can be created based on the current environment of the device.

Every widget has its own **create** function with a prototype like this:

```
lv_obj_t * lv_<widget>_create(lv_obj_t * parent, <other paramaters if any>);
```

In most of the cases the create functions have only a *parent* parameter that tells on which object create the new widget.

The return value is a pointer to the created object with `lv_obj_t *` type.

There is a common **delete** function for all object types. It deletes the object and all of its children.

```
void lv_obj_del(lv_obj_t * obj);
```

`lv_obj_del` will delete the object immediately. If for any reason you can't delete the object immediately you can use `lv_obj_del_async(obj)` that will perform the deletion on the next call of `lv_timer_handler()`. This is useful e.g. if you want to delete the parent of an object in the child's `LV_EVENT_DELETE` handler.

You can remove all the children of an object (but not the object itself) using `lv_obj_clean(obj)`.

## Screens

### Create screens

The screens are special objects which have no parent object. So they can be created like:

```
lv_obj_t * scr1 = lv_obj_create(NULL);
```

Screens can be created with any object type. 

### Get the active screen

There is always an active screen on each display. By default, the  library creates and loads a "Base object" as a screen for each display.

To get the currently active screen use the `lv_scr_act()` function.

### Load screens

To load a new screen, use `lv_scr_load(scr1)`

### Layers

There are two automatically generated layers:

- top layer
- system layer

They are independent of the screens and they will be shown on every screen. The *top layer* is above every object on the screen and the *system layer* is above the *top layer* too. You can add any pop-up windows to the *top layer* freely. But, the *system layer* is restricted to system-level things (e.g. mouse cursor will be placed here in `lv_indev_set_cursor()`).

The `lv_layer_top()` and `lv_layer_sys()` functions return pointers to the top and system layers respectively.

A new screen can be loaded with animation too using `lv_scr_load_anim(scr, transition_type, time, delay, auto_del)`. The following transition types exist:

- `LV_SCR_LOAD_ANIM_NONE`: switch immediately after `delay` milliseconds
- `LV_SCR_LOAD_ANIM_OVER_LEFT/RIGHT/TOP/BOTTOM` move the new screen over the current towards the given direction
- `LV_SCR_LOAD_ANIM_MOVE_LEFT/RIGHT/TOP/BOTTOM` move both the current and new screens towards the given direction
- `LV_SCR_LOAD_ANIM_FADE_ON` fade the new screen over the old screen

Setting `auto_del` to `true` will automatically delete the old screen when the animation is finished.

The new screen will become active (returned by `lv_scr_act()`) when the animations starts after `delay` time.

### Handling multiple displays

Screens are created on the currently selected *default display*. The *default display* is the last registered display with `lv_disp_drv_register` or you can explicitly select a new default display using `lv_disp_set_default(disp)`.

`lv_scr_act()`, `lv_scr_load()` and `lv_scr_load_anim()` operate on the default screen.

## Positions, sizes, and layouts

Similarly to many other parts of LVGL, the concept of setting the coordinates was inspired by CSS. 

In shorts this means:

- the set coordinates (size, position, layouts, etc) are stored in styles
- support min-width, max-width, min-height, max-height
- have pixel, percentage, and "content" units
- x=0; y=0 coordinate means the to top-left corner of the parent plus the left/top padding plus border width
- width/height means the full size, the "content area" is smaller with padding and border width
- a subset of flexbox and grid layouts are supported

### Units

- pixel: Simply a position in pixels. A simple integer always means pixel. E.g. `lv_obj_set_x(btn, 10)`
- percentage: The percentage of the size of the object or its parent (depending on the property). The `lv_pct(value)` converts a value to percentage. E.g. `lv_obj_set_width(btn, lv_pct(50))`
- `LV_SIZE_CONTENT`: Special value to set the width/height of an object to involve all the children. Its similar to `auto` in CSS.

### Boxing model

LVGL follows CSS's [border-box](https://developer.mozilla.org/en-US/docs/Web/CSS/box-sizing) model. An object's "box" is built from the following parts:

- bounding box: the width/height of the elements.
- border width: the width of the border.
- padding: space between the sides of the object and its children.
- content: the content area which size if the bounding box reduced by the border width and the size of the paddings.

![The box models of LVGL: The content area is smaller then the bounding box with the padding and border width](https://docs.lvgl.io/8.0/_images/boxmodel.png)

The border is drawn inside the bounding box. Inside the border LVGL keeps "padding size" to place the children.

The outline is drawn outside of the bounding box.

#### Postponed coordinate calculation

LVGL doesn't recalculate all the coordinate changes immediately. This is done to improve performance. Instead, the objects are marked as "dirty" and before redrawing the  screen LVGL checks if there are any "dirty" objects. If so it refreshes  their position, size and layout.

In other words, if you need to get the any coordinate of an object  and it the coordinates were just changed LVGL's needs to be forced to  recalculate the coordinates. To do this call `lv_obj_update_layout(obj)`.

The size and position might depend on the parent or layout. Therefore `lv_obj_update_layout` recalculates the coordinates of all objects on the screen of `obj`.

As it's described in the [Using styles](https://docs.lvgl.io/8.0/overview/coords.html#using-styles) section the coordinates can be set via style properties too. To be more precise under the hood every style coordinate related property is stored as style a property. If you use `lv_obj_set_x(obj, 20)` LVGL saves `x=20` in the local style of the object.

It's an internal mechanism and doesn't matter much as you use LVGL.  However, there is one case in which you need to aware of that. If the  style(s) of an object are removed by

```c
lv_obj_remove_style_all(obj)
```

or

```c
lv_obj_remove_style(obj, NULL, LV_PART_MAIN);
```

the earlier set coordinates will be removed as well.

## Position

### Simple way

To simple set the x and y coordinates of an object use

```
lv_obj_set_x(obj, 10);
lv_obj_set_y(obj, 20);
lv_obj_set_pos(obj, 10, 20); 	//Or in one function
```

By default the the x and y coordinates are measured from the top left corner of the parent's content area

if percentage values are calculated from the parents content area size.

```
lv_obj_set_x(btn, lv_pct(10)); //x = 10 % of parant content area width
```

### Align

In some cases it's convenient to change the origin of the positioning from the the default top left. If the origin is changed e.g. to  bottom-right, the (0,0) position means: align to the bottom-right  corner. To change the origin use:

```
lv_obj_set_align(obj, align);
```

To change the alignment and set new coordinates:

```
lv_obj_align(obj, align, x, y);
```

The following alignment options can be used:

- `LV_ALIGN_TOP_LEFT`
- `LV_ALIGN_TOP_MID`
- `LV_ALIGN_TOP_RIGHT`
- `LV_ALIGN_BOTTOM_LEFT`
- `LV_ALIGN_BOTTOM_MID`
- `LV_ALIGN_BOTTOM_RIGHT`
- `LV_ALIGN_LEFT_MID`
- `LV_ALIGN_RIGHT_MID`
- `LV_ALIGN_CENTER`

It quite common to align a children to the center of its parent, there fore is a dedicated function for it:

```
lv_obj_center(obj);

//Has the same effect
lv_obj_align(obj, LV_ALIGN_CENTER, 0, 0);
```

**If the parent's size changes the set alignment and position of the children is applied again automatically.**

The functions introduced above aligns the object to its parent.  However it's also possible to align an object to an arbitrary object.

```
lv_obj_align_to(obj_to_align, reference_obj, align, x, y);
```

Besides the alignments options above the following can be used to align the object outside of the reference object:

- `LV_ALIGN_OUT_TOP_LEFT`
- `LV_ALIGN_OUT_TOP_MID`
- `LV_ALIGN_OUT_TOP_RIGHT`
- `LV_ALIGN_OUT_BOTTOM_LEFT`
- `LV_ALIGN_OUT_BOTTOM_MID`
- `LV_ALIGN_OUT_BOTTOM_RIGHT`
- `LV_ALIGN_OUT_LEFT_TOP`
- `LV_ALIGN_OUT_LEFT_MID`
- `LV_ALIGN_OUT_LEFT_BOTTOM`
- `LV_ALIGN_OUT_RIGHT_TOP`
- `LV_ALIGN_OUT_RIGHT_MID`
- `LV_ALIGN_OUT_RIGHT_BOTTOM`

For example to align a label above a button and center the label horizontally:

```
lv_obj_align_to(label, btn, LV_ALIGN_OUT_TOP_MID, 0, -10);
```

Note that - unlike with `lv_obj_align()` - `lv_obj_align_to()` can not realign the object if its coordinates or the reference object's coordinates changes.

## Size

### Simple way

The width and the height of an object can be set easily as well:

```c
lv_obj_set_width(obj, 200);
lv_obj_set_height(obj, 100);
lv_obj_set_size(obj, 200, 100); 	//Or in one function
```

Percentage values are calculated based on the parent's content area size. 

```
lv_obj_set_height(obj, lv_pct(100));
```

Size setting supports a value: `LV_SIZE_CONTENT`. It means the object's size in the respective direction will be set to the size of its children.

Objects with `LV_OBJ_FLAG_HIDDEN` or `LV_OBJ_FLAG_FLOATING` will be ignored by the `LV_SIZE_CONTENT` calculation.

The above functions set the size of the bounding box of the object but the size of the content area can be set as well.

The above functions set the size of the bounding box of the object  but the size of the content area can be set as well. It means the  object's bounding box will be larger with the paddings than the set  size.

```
lv_obj_set_content_width(obj, 50); //The actual width: padding left + 50 + padding right
lv_obj_set_content_height(obj, 30); //The actual width: padding top + 30 + padding bottom
```

The size of the bounding box and the content area can be get with the following functions:

```
lv_coord_t w = lv_obj_get_width(obj);
lv_coord_t h = lv_obj_get_height(obj);
lv_coord_t content_w = lv_obj_get_content_width(obj);
lv_coord_t content_h = lv_obj_get_content_height(obj);
```

### Using styles

Under the hood the position, size and alignment properties are style  properties. The above described "simple functions" hide the style related code for  the sake of simplicity and set the position, size, and alignment  properties in the local styles of the obejct.

However, using styles as to set the coordinates has some great advantages:

- It makes it easy to set the width/height/etc for several objects together. E.g. make all the sliders 100x10 pixels sized.
- It also makes possible to modify the values in one place.
- The values can be overwritten by other styles. For example `style_btn` makes the object `100x50` by default but adding `style_full_width` overwrites only the width of the object.
- The object can have different position or size in different state. E.g. 100 px wide in `LV_STATE_DEFAULT` but 120 px in `LV_STATE_PRESSED`.
- Style transitions can be used to make the coordinate changes smooth.

Here are some examples to set an object's size using a style:

```
static lv_style_t style;
lv_style_init(&style);
lv_style_set_width(&style, 100);

lv_obj_t * btn = lv_btn_create(lv_scr_act());
lv_obj_add_style(btn, &style, LV_PART_MAIN);
```

## Translation

Let's say the there are 3 buttons next to each other. Their position is set as described above. Now you want to move a buttons up a little when it's pressed.

One way to achieve this is setting a new Y coordinate for pressed state:

```
static lv_style_t style_normal;
lv_style_init(&style_normal);
lv_style_set_y(&style_normal, 100);

static lv_style_t style_pressed;
lv_style_init(&style_pressed);
lv_style_set_y(&style_pressed, 80);

lv_obj_add_style(btn1, &style_normal, LV_STATE_DEFAULT);
lv_obj_add_style(btn1, &style_pressed, LV_STATE_PRESSED);

lv_obj_add_style(btn2, &style_normal, LV_STATE_DEFAULT);
lv_obj_add_style(btn2, &style_pressed, LV_STATE_PRESSED);

lv_obj_add_style(btn3, &style_normal, LV_STATE_DEFAULT);
lv_obj_add_style(btn3, &style_pressed, LV_STATE_PRESSED);
```

It works but it's not really flexible because the pressed coordinate is hard-coded. If the buttons are not at y=100 `style_pressed` won't work as expected. To solve this translations can be used:

```
static lv_style_t style_normal;
lv_style_init(&style_normal);
lv_style_set_y(&style_normal, 100);

static lv_style_t style_pressed;
lv_style_init(&style_pressed);
lv_style_set_translate_y(&style_pressed, -20);

lv_obj_add_style(btn1, &style_normal, LV_STATE_DEFAULT);
lv_obj_add_style(btn1, &style_pressed, LV_STATE_PRESSED);

lv_obj_add_style(btn2, &style_normal, LV_STATE_DEFAULT);
lv_obj_add_style(btn2, &style_pressed, LV_STATE_PRESSED);

lv_obj_add_style(btn3, &style_normal, LV_STATE_DEFAULT);
lv_obj_add_style(btn3, &style_pressed, LV_STATE_PRESSED);
```

Translation is applied from the current position of the object

## Transformation

Similarly to the position the size can be changed relative to the  current size as well. The transformed width and height are added on both sides of the object.  This means 10 px transformed width makes the object 2x10 pixel wider.

Unlike position translation, the size transformation doesn't make the object "really" larger. In other words scrollbars, layouts, `LV_SIZE_CONTENT` will not consider the transformed size. Hence size transformation if "only" a visual effect.

This code makes the a button larger when it's pressed:

```c
static lv_style_t style_pressed;
lv_style_init(&style_pressed);
lv_style_set_transform_width(&style_pressed, 10);
lv_style_set_transform_height(&style_pressed, 10);

lv_obj_add_style(btn, &style_pressed, LV_STATE_PRESSED);
```

### Min and Max size

Similarly to CSS, LVGL also support `min-width`, `max-width`, `min-height` and `max-height`. These are limits preventing an object's size to be smaller/larger then these values. They are especially useful if the size is set by percentage or `LV_SIZE_CONTENT`.

```c
static lv_style_t style_max_height;
lv_style_init(&style_max_height);
lv_style_set_y(&style_max_height, 200);

lv_obj_set_height(obj, lv_pct(100));
lv_obj_add_style(obj, &style_max_height, LV_STATE_DEFAULT); //Limit the  height to 200 px
```

Percentage values can be used as well which are relative to the size of the parent's content area size.

```c
static lv_style_t style_max_height;
lv_style_init(&style_max_height);
lv_style_set_y(&style_max_height, lv_pct(50));

lv_obj_set_height(obj, lv_pct(100));
lv_obj_add_style(obj, &style_max_height, LV_STATE_DEFAULT); //Limit the height to half parent height
```

## Layout

### Overview

Layouts can update the position and size of an object's children.  They can be used to automatically arrange the children into a line or  column, or in much more complicated forms.

The position and size set by the layout overwrites the "normal" x, y, width, and height settings.

There is only one function that is the same for every layout: `lv_obj_set_layout(obj, <LAYOUT_NAME>)` sets the layout on an object.

### Built-in layout

LVGL comes with two very powerful layouts:

- Flexbox
- Grid

Both are heavily inspired by the CSS layouts with the same name.

### Flags

There are some flags that can be used on object to affect how they behave with layouts:

- `LV_OBJ_FLAG_HIDDEN` Hidden object are ignored from layout calculations.
- `LV_OBJ_FLAG_IGNORE_LAYOUT` The object is simply ignored by the layouts. Its coordinates can be set as usual.
- `LV_OBJ_FLAG_FLOATING` Same as `LV_OBJ_FLAG_IGNORE_LAYOUT` but the object with `LV_OBJ_FLAG_FLOATING` will be ignored from `LV_SIZE_CONTENT` calculations.

These flags can be added/removed with `lv_obj_add/clear_flag(obj, FLAG);`

### Adding new layouts

LVGL can be freely extended by a custom layouts like this:

```
uint32_t MY_LAYOUT;

...

MY_LAYOUT = lv_layout_register(my_layout_update, &user_data);

...

void my_layout_update(lv_obj_t * obj, void * user_data)
{
	/*Will be called automatically if required to reposition/resize the children of "obj" */	
}
```

Custom style properties can be added too that can be get and used in the update callback. For example:

```
uint32_t MY_PROP;
...

LV_STYLE_MY_PROP = lv_style_register_prop();

...
static inline void lv_style_set_my_prop(lv_style_t * style, uint32_t value)
{
    lv_style_value_t v = {
        .num = (int32_t)value
    };
    lv_style_set_prop(style, LV_STYLE_MY_PROP, v);
}
```