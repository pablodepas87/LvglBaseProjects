# Base Project introduction

It is a base code to all example projects , it is a simple main.c file where there are main and initialization of  the HAL (display, input devices, tick) for LVGL routines.

Every LVGL projects must to have the includes of LVGL library as like these :

`#include "lvgl/lvgl.h"`
`#include "lv_drivers/sdl/sdl.h"`

***lv_drivers*** will be to initialize the display.

We want to use SDL driver to simulate a TFT display on ubuntu desktop so we will include the library path *`#include <SDL2/SDL.h>`*  ( in EClipse settings libraries we must to add SDLmain e SDL2 library  otherwise the library doesn't work.)

After the includes we will to declare the `hal_init()` routine it will be call into **main routine** after `lvgl_init()`

### `static void hal_init(void)`

It is a routine where we going to define the hal device (display drivers and input device) following LVGL documentations. It is  defined in this way:

```c
// display definition 
....
    
    /*Create a display buffer*/

	static lv_disp_draw_buf_t disp_buf1;
	static lv_color_t buf1_1[SDL_HOR_RES*100];

	lv_disp_draw_buf_init(&disp_buf1, buf1_1, NULL, SDL_HOR_RES*100);

	/*Create a display driver */

	static lv_disp_drv_t disp_drv;
	lv_disp_drv_init(&disp_drv);  /*Basic initialization*/
	disp_drv.draw_buf = &disp_buf1;
	disp_drv.flush_cb = sdl_display_flush;
	disp_drv.hor_res = SDL_HOR_RES;
	disp_drv.ver_res = SDL_VER_RES;

	lv_disp_t * disp;
	disp = lv_disp_drv_register(&disp_drv); /*Register the driver and save the created display objects*/

    
....   
    
    
    
// input device definition 
    
....
    
  lv_group_t * g = lv_group_create();
	lv_group_set_default(g);

	 /***********Add input devices ********************************
	 * 															  *
	 * https://docs.lvgl.io/8.0/porting/indev.html				  *
	 * 															  *
	 * ***********************************************************/

	/* Add the mouse as input device
	 * Use the 'mouse' driver which reads the PC's mouse*/

	 static lv_indev_drv_t indev_drv_t1;
	 lv_indev_drv_init(&indev_drv_t1); /*Basic initialization*/

	 indev_drv_t1.type = LV_INDEV_TYPE_POINTER;  // define to set mouse
	 indev_drv_t1.read_cb = sdl_mouse_read;		 // This function will be called periodically (by the library) to get the mouse position and state

	 lv_indev_t *mouse_indev = lv_indev_drv_register(&indev_drv_t1);

	 static lv_indev_drv_t indev_drv_t2;
	 lv_indev_drv_init(&indev_drv_t2);			/*Basic initialization*/

	 indev_drv_t2.type = LV_INDEV_TYPE_KEYPAD;
	 indev_drv_t2.read_cb = sdl_keyboard_read;

	 lv_indev_t *keypad_indev = lv_indev_drv_register(&indev_drv_t2);

	 lv_indev_set_group(keypad_indev, g);

	 static lv_indev_drv_t indev_drv_t3;
	 lv_indev_drv_init(&indev_drv_t2);

	 indev_drv_t3.type = LV_INDEV_TYPE_ENCODER;
	 indev_drv_t3.read_cb = sdl_mousewheel_read;

	 lv_indev_t *enc_indev = lv_indev_drv_register(&indev_drv_t3);

	 lv_indev_set_group(enc_indev, g);  
    
....    
```

If we want to show a mouse icon it will be defined after input device definition  in this way:

```c
	 LV_IMG_DECLARE(mouse_cursor_icon); 						/*Declare the image file.*/
	 lv_obj_t * cursor_obj = lv_img_create(lv_scr_act()); 		/*Create an image object for the cursor */
	 lv_img_set_src(cursor_obj, &mouse_cursor_icon);           	/*Set the image source*/
	 lv_indev_set_cursor(mouse_indev, cursor_obj);             	/*Connect the image  object to the driver*/
```

### `int main(int argc,char **argv)`

base project is a simple hello world projects defined in this way:

```c
	
	(void)argc; /*Unused*/
	(void)argv; /*Unused*/

	/*Initialize LVGL*/
	lv_init();

	/*Initialize the HAL (display, input devices, tick) for LVGL*/
	hal_init();

	while(1){
		/* Periodically call the lv_task handler.
		* It could be done in a timer interrupt or an OS task too.*/
		lv_timer_handler();
		usleep(5000);         // to create a 5ms task
	}
```

this is a base code of every projects following LVGL documentation, to add hello world label we declared it between hal_init() and application loop 

```c
	/* create a style to apply at label*/
	static lv_style_t lbl_style;
	lv_style_init(&lbl_style);
	lv_style_set_text_color(&lbl_style, lv_palette_main(LV_PALETTE_GREY));
	lv_style_set_text_font(&lbl_style, &lv_font_montserrat_20);

	/* create a label obj widget */
	lv_obj_t *lbl_helloworld = lv_label_create(lv_scr_act());
	lv_obj_set_align(lbl_helloworld, LV_ALIGN_CENTER);
	lv_label_set_text(lbl_helloworld, "HELLO WORLD");
	lv_obj_add_style(lbl_helloworld, &lbl_style, 0);
```

