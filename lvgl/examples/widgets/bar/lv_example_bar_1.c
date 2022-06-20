#include "../../lv_examples.h"
#if LV_USE_BAR && LV_BUILD_EXAMPLES

void lv_example_bar_1(void)
{
    lv_obj_t * bar1 = lv_bar_create(lv_scr_act());
    lv_obj_set_size(bar1, 20, 200);
    lv_obj_align(bar1, LV_ALIGN_LEFT_MID, 10, 0);
    lv_bar_set_value(bar1, 70, LV_ANIM_OFF);
}

#endif
