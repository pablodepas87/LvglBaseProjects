################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/src/draw/lv_draw_arc.c \
../lvgl/src/draw/lv_draw_blend.c \
../lvgl/src/draw/lv_draw_img.c \
../lvgl/src/draw/lv_draw_label.c \
../lvgl/src/draw/lv_draw_line.c \
../lvgl/src/draw/lv_draw_mask.c \
../lvgl/src/draw/lv_draw_rect.c \
../lvgl/src/draw/lv_draw_triangle.c \
../lvgl/src/draw/lv_img_buf.c \
../lvgl/src/draw/lv_img_cache.c \
../lvgl/src/draw/lv_img_decoder.c 

C_DEPS += \
./lvgl/src/draw/lv_draw_arc.d \
./lvgl/src/draw/lv_draw_blend.d \
./lvgl/src/draw/lv_draw_img.d \
./lvgl/src/draw/lv_draw_label.d \
./lvgl/src/draw/lv_draw_line.d \
./lvgl/src/draw/lv_draw_mask.d \
./lvgl/src/draw/lv_draw_rect.d \
./lvgl/src/draw/lv_draw_triangle.d \
./lvgl/src/draw/lv_img_buf.d \
./lvgl/src/draw/lv_img_cache.d \
./lvgl/src/draw/lv_img_decoder.d 

OBJS += \
./lvgl/src/draw/lv_draw_arc.o \
./lvgl/src/draw/lv_draw_blend.o \
./lvgl/src/draw/lv_draw_img.o \
./lvgl/src/draw/lv_draw_label.o \
./lvgl/src/draw/lv_draw_line.o \
./lvgl/src/draw/lv_draw_mask.o \
./lvgl/src/draw/lv_draw_rect.o \
./lvgl/src/draw/lv_draw_triangle.o \
./lvgl/src/draw/lv_img_buf.o \
./lvgl/src/draw/lv_img_cache.o \
./lvgl/src/draw/lv_img_decoder.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/src/draw/%.o: ../lvgl/src/draw/%.c lvgl/src/draw/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-src-2f-draw

clean-lvgl-2f-src-2f-draw:
	-$(RM) ./lvgl/src/draw/lv_draw_arc.d ./lvgl/src/draw/lv_draw_arc.o ./lvgl/src/draw/lv_draw_blend.d ./lvgl/src/draw/lv_draw_blend.o ./lvgl/src/draw/lv_draw_img.d ./lvgl/src/draw/lv_draw_img.o ./lvgl/src/draw/lv_draw_label.d ./lvgl/src/draw/lv_draw_label.o ./lvgl/src/draw/lv_draw_line.d ./lvgl/src/draw/lv_draw_line.o ./lvgl/src/draw/lv_draw_mask.d ./lvgl/src/draw/lv_draw_mask.o ./lvgl/src/draw/lv_draw_rect.d ./lvgl/src/draw/lv_draw_rect.o ./lvgl/src/draw/lv_draw_triangle.d ./lvgl/src/draw/lv_draw_triangle.o ./lvgl/src/draw/lv_img_buf.d ./lvgl/src/draw/lv_img_buf.o ./lvgl/src/draw/lv_img_cache.d ./lvgl/src/draw/lv_img_cache.o ./lvgl/src/draw/lv_img_decoder.d ./lvgl/src/draw/lv_img_decoder.o

.PHONY: clean-lvgl-2f-src-2f-draw

