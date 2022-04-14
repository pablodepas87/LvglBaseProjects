#include "../lv_examples.h"
#if LV_BUILD_EXAMPLES && LV_USE_IMG

/**
 * Using the Size, Position and Padding style properties
 */
void lv_example_style_1(void)
{
     static lv_style_t style;
     lv_style_init(&style);
     //lv_style_set_radius(&style, 5);

     /*Make a gradient*/
     lv_style_set_width(&style, lv_pct(32));
     lv_style_set_height(&style, 60);

     lv_style_set_pad_ver(&style, 20);
     lv_style_set_pad_left(&style, 5);

     lv_style_set_x(&style, lv_pct(15));
     lv_style_set_y(&style, 30);

     /*Create an object with the new style*/
     lv_obj_t * obj = lv_obj_create(lv_scr_act());
     lv_obj_add_style(obj, &style, 0);

     lv_obj_t * label = lv_label_create(obj);
     lv_label_set_text(label, "Border Ex.");

     static lv_style_t styleLbl2;
     lv_style_init(&styleLbl2);

     /* Make a gradient */
     lv_style_set_width(&styleLbl2,lv_pct(32));
     lv_style_set_height(&styleLbl2,LV_SIZE_CONTENT);

     lv_style_set_x(&styleLbl2, lv_pct(53));
     lv_style_set_y(&styleLbl2, 30);

     //lv_style_set_pad_ver(&style, 20);
     //lv_style_set_pad_left(&style, 5);

     lv_obj_t *obj2 = lv_obj_create(lv_scr_act());
     lv_obj_add_style(obj2,&styleLbl2,0);

     lv_obj_t * lblBkg = lv_label_create(obj2);
     lv_label_set_text(lblBkg, "Background ex.");


}

#endif
