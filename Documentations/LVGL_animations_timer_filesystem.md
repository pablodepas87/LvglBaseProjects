# File system

LVGL has a 'File system' abstraction module that enables you to attach any type of file system. A file system is identified by an assigned drive letter. For example, if an SD card is associated with the letter `'S'`, a file can be reached using `"S:path/to/file.txt"`.

## Ready to use drivers

The [lv_fs_if](https://github.com/lvgl/lv_fs_if) repository contains prepared drivers using POSIX, standard C and the [FATFS](http://elm-chan.org/fsw/ff/00index_e.html) API.

VGL has a [File system](https://docs.lvgl.io/master/overview/file-system.html) module to attach memories which can manipulate with files. Here you can find interfaces to

- FATFS
- PC (Linux and Windows using C standard function .e.g fopen, fread)
- POSIX (Linux and Windows using POSIX function .e.g open, read) file systems.

You still need to provide the drivers and libraries, this repo gives "only" the bridge between FATFS/PC/etc and LittlevGL.

## Usage

1. Add these lines to you `lv_conf.h`:

```
/*File system interface*/
#define LV_USE_FS_IF	1
#if LV_USE_FS_IF
#  define LV_FS_IF_FATFS    '\0'
#  define LV_FS_IF_PC       '\0'
#  define LV_FS_IF_POSIX    '\0'
#endif  /*LV_USE_FS_IF*/
```

1. Enable an interface you need by changing `'\0'` to letter you want to use for that drive. E.g. `'S'` for SD card with FATFS.
2. Call `lv_fs_if_init()` (after `lv_init()`) to register the enabled interfaces.

## Adding a driver

### Registering a driver

To add a driver, a `lv_fs_drv_t` needs to be initialized like below. The `lv_fs_drv_t` needs to be static, global or dynamically allocated and not a local variable.

```
static lv_fs_drv_t drv;                   /*Needs to be static or global*/
lv_fs_drv_init(&drv);                     /*Basic initialization*/

drv.letter = 'S';                         /*An uppercase letter to identify the drive */
drv.cache_size = my_cache_size;           /*Cache size for reading in bytes. 0 to not cache.*/

drv.ready_cb = my_ready_cb;               /*Callback to tell if the drive is ready to use */
drv.open_cb = my_open_cb;                 /*Callback to open a file */
drv.close_cb = my_close_cb;               /*Callback to close a file */
drv.read_cb = my_read_cb;                 /*Callback to read a file */
drv.write_cb = my_write_cb;               /*Callback to write a file */
drv.seek_cb = my_seek_cb;                 /*Callback to seek in a file (Move cursor) */
drv.tell_cb = my_tell_cb;                 /*Callback to tell the cursor position  */

drv.dir_open_cb = my_dir_open_cb;         /*Callback to open directory to read its content */
drv.dir_read_cb = my_dir_read_cb;         /*Callback to read a directory's content */
drv.dir_close_cb = my_dir_close_cb;       /*Callback to close a directory */

drv.user_data = my_user_data;             /*Any custom data if required*/

lv_fs_drv_register(&drv);                 /*Finally register the drive*/
```

Any of the callbacks can be `NULL` to indicate that operation is not supported.

### Implementing the callbacks

#### Open callback

The prototype of `open_cb` looks like this:

```
void * (*open_cb)(lv_fs_drv_t * drv, const char * path, lv_fs_mode_t mode);
```

`path` is the path after the drive letter (e.g. "S:path/to/file.txt" -> "path/to/file.txt"). `mode` can be `LV_FS_MODE_WR` or `LV_FS_MODE_RD` to open for writes or reads.

The return value is a pointer to a *file object* that describes the opened file or `NULL` if there were any issues (e.g. the file wasn't found). The returned file object will be passed to other file system related callbacks. (see below)

### Other callbacks

The other callbacks are quite similar. For example `write_cb` looks like this:

```
lv_fs_res_t (*write_cb)(lv_fs_drv_t * drv, void * file_p, const void * buf, uint32_t btw, uint32_t * bw);
```

For `file_p`, LVGL passes the return value of `open_cb`, `buf` is the data to write, `btw` is the Bytes To Write, `bw` is the actually written bytes.

For a template of these callbacks see [lv_fs_template.c](https://github.com/lvgl/lvgl/blob/master/examples/porting/lv_port_fs_template.c).

## Usage example

The example below shows how to read from a file:

```
lv_fs_file_t f;
lv_fs_res_t res;
res = lv_fs_open(&f, "S:folder/file.txt", LV_FS_MODE_RD);
if(res != LV_FS_RES_OK) my_error_handling();

uint32_t read_num;
uint8_t buf[8];
res = lv_fs_read(&f, buf, 8, &read_num);
if(res != LV_FS_RES_OK || read_num != 8) my_error_handling();

lv_fs_close(&f);
```

*The mode in `lv_fs_open` can be `LV_FS_MODE_WR` to open for writes only or `LV_FS_MODE_RD | LV_FS_MODE_WR` for both*

This example shows how to read a directory's content. It's up to the  driver how to mark directories in the result but it can be a good  practice to insert a `'/'` in front of each directory name.

```
lv_fs_dir_t dir;
lv_fs_res_t res;
res = lv_fs_dir_open(&dir, "S:/folder");
if(res != LV_FS_RES_OK) my_error_handling();

char fn[256];
while(1) {
    res = lv_fs_dir_read(&dir, fn);
    if(res != LV_FS_RES_OK) {
        my_error_handling();
        break;
    }

    /*fn is empty, if not more files to read*/
    if(strlen(fn) == 0) {
        break;
    }

    printf("%s\n", fn);
}

lv_fs_dir_close(&dir);
```

## Use drives for images

[Image](https://docs.lvgl.io/master/widgets/core/img.html) objects can be opened from files too (besides variables stored in the compiled program).

To use files in image widgets the following callbacks are required:

- open
- close
- read
- seek
- tell

# Timers

LVGL has a built-in timer system. You can register a function to have it be called periodically. The timers are handled and called in `lv_timer_handler()`, which needs to be called every few milliseconds.

Timers are non-preemptive, which means a timer cannot interrupt  another timer. Therefore, you can call any LVGL related function in a  timer.

## Create a timer

To create a new timer, use `lv_timer_create(timer_cb, period_ms, user_data)`. It will create an `lv_timer_t *` variable, which can be used later to modify the parameters of the timer. `lv_timer_create_basic()` can also be used. This allows you to create a new timer without specifying any parameters.

A timer callback should have a `void (*lv_timer_cb_t)(lv_timer_t *);` prototype.

For example:

```
void my_timer(lv_timer_t * timer)
{
  /*Use the user_data*/
  uint32_t * user_data = timer->user_data;
  printf("my_timer called with user data: %d\n", *user_data);

  /*Do something with LVGL*/
  if(something_happened) {
    something_happened = false;
    lv_btn_create(lv_scr_act(), NULL);
  }
}

...

static uint32_t user_data = 10;
lv_timer_t * timer = lv_timer_create(my_timer, 500,  &user_data);
```

## Ready and Reset

`lv_timer_ready(timer)` makes a timer run on the next call of `lv_timer_handler()`.

`lv_timer_reset(timer)` resets the period of a timer. It will be called again after the defined period of milliseconds has elapsed.

## Set parameters

You can modify some timer parameters later:

- `lv_timer_set_cb(timer, new_cb)`
- `lv_timer_set_period(timer, new_period)`

## Repeat count

You can make a timer repeat only a given number of times with `lv_timer_set_repeat_count(timer, count)`. The timer will automatically be deleted after it's called the defined number of times. Set the count to `-1` to repeat indefinitely.

## Measure idle time

You can get the idle percentage time of `lv_timer_handler` with `lv_timer_get_idle()`. Note that, it doesn't measure the idle time of the overall system, only `lv_timer_handler`. It can be misleading if you use an operating system and call `lv_timer_handler` in a timer, as it won't actually measure the time the OS spends in an idle thread.

## Measure idle time

You can get the idle percentage time of `lv_timer_handler` with `lv_timer_get_idle()`. Note that, it doesn't measure the idle time of the overall system, only `lv_timer_handler`. It can be misleading if you use an operating system and call `lv_timer_handler` in a timer, as it won't actually measure the time the OS spends in an idle thread.

## Asynchronous calls

In some cases, you can't perform an action immediately. For example,  you can't delete an object because something else is still using it, or  you don't want to block the execution now. For these cases, `lv_async_call(my_function, data_p)` can be used to call `my_function` on the next invocation of `lv_timer_handler`. `data_p` will be passed to the function when it's called. Note that only the data pointer is saved, so you need to ensure that the variable will be "alive" while the function is called. It can be *static*, global or dynamically allocated data.

For example:

```
void my_screen_clean_up(void * scr)
{
  /*Free some resources related to `scr`*/

  /*Finally delete the screen*/
  lv_obj_del(scr);
}

...

/*Do something with the object on the current screen*/

/*Delete screen on next call of `lv_timer_handler`, not right now.*/
lv_async_call(my_screen_clean_up, lv_scr_act());

/*The screen is still valid so you can do other things with it*/
```

If you just want to delete an object and don't need to clean anything up in `my_screen_cleanup` you could just use `lv_obj_del_async` which will delete the object on the next call to `lv_timer_handler`.

# Animations

You can automatically change the value of a variable between a start and an end value using animations. Animation will happen by periodically calling an "animator" function with the corresponding value parameter.

The *animator* functions have the following prototype:

```
void func(void * var, lv_anim_var_t value);
```

This prototype is compatible with the majority of the property *set* functions in LVGL. For example `lv_obj_set_x(obj, value)` or `lv_obj_set_width(obj, value)`

## Create an animation

To create an animation an `lv_anim_t` variable has to be initialized and configured with `lv_anim_set_...()` functions.

o create an animation an `lv_anim_t` variable has to be initialized and configured with `lv_anim_set_...()` functions.

```
/* INITIALIZE AN ANIMATION
 *-----------------------*/

lv_anim_t a;
lv_anim_init(&a);

/* MANDATORY SETTINGS
 *------------------*/

/*Set the "animator" function*/
lv_anim_set_exec_cb(&a, (lv_anim_exec_xcb_t) lv_obj_set_x);

/*Set target of the animation*/
lv_anim_set_var(&a, obj);

/*Length of the animation [ms]*/
lv_anim_set_time(&a, duration);

/*Set start and end values. E.g. 0, 150*/
lv_anim_set_values(&a, start, end);

/* OPTIONAL SETTINGS
 *------------------*/

/*Time to wait before starting the animation [ms]*/
lv_anim_set_delay(&a, delay);

/*Set path (curve). Default is linear*/
lv_anim_set_path(&a, lv_anim_path_ease_in);

/*Set a callback to indicate when the animation is ready (idle).*/
lv_anim_set_ready_cb(&a, ready_cb);

/*Set a callback to indicate when the animation is started (after delay).*/
lv_anim_set_start_cb(&a, start_cb);

/*When ready, play the animation backward with this duration. Default is 0 (disabled) [ms]*/
lv_anim_set_playback_time(&a, time);

/*Delay before playback. Default is 0 (disabled) [ms]*/
lv_anim_set_playback_delay(&a, delay);

/*Number of repetitions. Default is 1. LV_ANIM_REPEAT_INFINITE for infinite repetition*/
lv_anim_set_repeat_count(&a, cnt);

/*Delay before repeat. Default is 0 (disabled) [ms]*/
lv_anim_set_repeat_delay(&a, delay);

/*true (default): apply the start value immediately, false: apply start value after delay when the anim. really starts. */
lv_anim_set_early_apply(&a, true/false);

/* START THE ANIMATION
 *------------------*/
lv_anim_start(&a);                             /*Start the animation*/
```

You can apply multiple different animations on the same variable at the same time. For example, animate the x and y coordinates with `lv_obj_set_x` and `lv_obj_set_y`. However, only one animation can exist with a given variable and function pair and `lv_anim_start()` will remove any existing animations for such a pair.

## Animation path

You can control the path of an animation. The most simple case is linear, meaning the current value between *start* and *end* is changed with fixed steps. A *path* is a function which calculates the next value to set  based on the current state of the animation. Currently, there are the  following built-in path functions:

- `lv_anim_path_linear` linear animation
- `lv_anim_path_step` change in one step at the end
- `lv_anim_path_ease_in` slow at the beginning
- `lv_anim_path_ease_out` slow at the end
- `lv_anim_path_ease_in_out` slow at the beginning and end
- `lv_anim_path_overshoot` overshoot the end value
- `lv_anim_path_bounce` bounce back a little from the end value (like hitting a wall)

## Speed vs time

By default, you set the animation time directly. But in some cases, setting the animation speed is more practical.

The `lv_anim_speed_to_time(speed, start, end)` function calculates the required time in milliseconds to reach the end value from a start value with the given speed. The speed is interpreted in *unit/sec* dimension. For example,  `lv_anim_speed_to_time(20,0,100)` will yield 5000 milliseconds. For example, in the case of `lv_obj_set_x` *unit* is pixels so *20* means *20 px/sec* speed.

## Delete animations

You can delete an animation with `lv_anim_del(var, func)` if you provide the animated variable and its animator function.

## Timeline

A timeline is a collection of multiple animations which makes it easy to create complex composite animations.

Firstly, create an animation element but don’t call `lv_anim_start()`.

Secondly, create an animation timeline object by calling `lv_anim_timeline_create()`.

Thirdly, add animation elements to the animation timeline by calling `lv_anim_timeline_add(at, start_time, &a)`. `start_time` is the start time of the animation on the timeline. Note that `start_time` will override the value of `delay`.

Finally, call `lv_anim_timeline_start(at)` to start the animation timeline.

It supports forward and backward playback of the entire animation group, using `lv_anim_timeline_set_reverse(at, reverse)`.

Call `lv_anim_timeline_stop(at)` to stop the animation timeline.

Call `lv_anim_timeline_set_progress(at, progress)` function to set the state of the object corresponding to the progress of the timeline.

Call `lv_anim_timeline_get_playtime(at)` function to get the total duration of the entire animation timeline.

Call `lv_anim_timeline_get_reverse(at)` function to get whether to reverse the animation timeline.

Call `lv_anim_timeline_del(at)` function to delete the animation timeline.

![../_images/anim-timeline.png](https://docs.lvgl.io/master/_images/anim-timeline.png)