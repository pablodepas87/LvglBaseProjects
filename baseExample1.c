/*
 * baseExample1.c
 *
 *  Created on: 11 apr 2022
 *      Author: fabio
 */

#include "lvgl/lvgl.h"
#include  <stdio.h>


static void btn_event_cb(lv_event_t * e);

void screenExample(void){


	static lv_style_t style;
	lv_style_init(&style);

	lv_style_set_radius(&style, 3);

	lv_style_set_bg_opa(&style, LV_OPA_100);
	lv_style_set_bg_color(&style, lv_palette_main(LV_PALETTE_BLUE));
	lv_style_set_bg_grad_color(&style, lv_palette_darken(LV_PALETTE_BLUE, 2));
	lv_style_set_bg_grad_dir(&style, LV_GRAD_DIR_VER);

	lv_style_set_border_opa(&style, LV_OPA_40);
	lv_style_set_border_width(&style, 2);
	lv_style_set_border_color(&style, lv_palette_main(LV_PALETTE_GREY));

	lv_style_set_shadow_width(&style, 8);
	lv_style_set_shadow_color(&style, lv_palette_main(LV_PALETTE_GREY));
	lv_style_set_shadow_ofs_y(&style, 8);

	lv_style_set_outline_opa(&style, LV_OPA_COVER);
	lv_style_set_outline_color(&style, lv_palette_main(LV_PALETTE_BLUE));

	lv_style_set_text_color(&style, lv_color_white());
	lv_style_set_pad_all(&style, 10);

	lv_style_set_width(&style, 100);
	lv_style_set_height(&style, 50);


	lv_obj_t *btn1 = lv_btn_create(lv_scr_act());
	//lv_obj_remove_style_all(btn1);
	lv_obj_add_style(btn1, &style, LV_STATE_DEFAULT);
	lv_obj_align(btn1, LV_ALIGN_TOP_MID, 0, 20);
	lv_obj_add_event_cb(btn1, btn_event_cb, LV_EVENT_CLICKED, NULL);

}

static void btn_event_cb(lv_event_t * e){

	printf("Clicked\n");
	lv_event_code_t ev_code = lv_event_get_code(e);
	lv_obj_t *btn = lv_event_get_target(e);

	if( ev_code == LV_EVENT_CLICKED){
		printf("Clicked\n");
	}

}


