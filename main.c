/*
 ============================================================================
 Name        : main.c
 Author      : Fabio Rapicano
 Version     : 1.0
 Copyright   : Tutti i diritti sono riservati e di proprietà di Fabio Rapicano
 Description : Base project to show LVGL basic features
 ============================================================================
 */
#define  _DEFAULT_SOURCE
#include <stdlib.h>
#include <unistd.h>
#define  SLD_MAIN_HANDLED
#include <SDL2/SDL.h>
#include "lvgl/lvgl.h"
#include "lv_drivers/sdl/sdl.h"
#include "lvgl/examples/lv_examples.h"

static void hal_init(void);

int main(int argc,char **argv) {

	(void)argc; /*Unused*/
	(void)argv; /*Unused*/

	/*Initialize LVGL*/
	lv_init();

	/*Initialize the HAL (display, input devices, tick) for LVGL*/
	hal_init();

	lv_example_scroll_6();


	while(1){
		/* Periodically call the lv_task handler.
		* It could be done in a timer interrupt or an OS task too.*/
		lv_timer_handler();
		usleep(5000);         // to create a 5ms task
	}

	return 0;
}


static void hal_init(void){

	/* Use the 'monitor' driver which creates window on PC's monitor to simulate a display*/
	sdl_init();

	 /***********Create a display *********************************
	 * 															  *
	 * https://docs.lvgl.io/8.0/porting/display.html			  *
	 * 															  *
	 * ***********************************************************/

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

	/* DEFAULT THEME FOR OBJ THAT HAVEN'T A THEME */
	lv_theme_t * th = lv_theme_default_init(disp, lv_palette_main(LV_PALETTE_GREY), lv_palette_main(LV_PALETTE_RED), LV_THEME_DEFAULT_DARK, LV_FONT_DEFAULT);
	lv_disp_set_theme(disp, th);

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


//	 /*Set a cursor for the mouse is OPTIONAL*/
//	 LV_IMG_DECLARE(mouse_cursor_icon); 						/*Declare the image file.*/
//	 lv_obj_t * cursor_obj = lv_img_create(lv_scr_act()); 		/*Create an image object for the cursor */
//	 lv_img_set_src(cursor_obj, &mouse_cursor_icon);           	/*Set the image source*/
//	 lv_indev_set_cursor(mouse_indev, cursor_obj);             	/*Connect the image  object to the driver*/

}
