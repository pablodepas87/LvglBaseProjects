################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/canvas/lv_example_canvas_1.c \
../lvgl/examples/widgets/canvas/lv_example_canvas_2.c 

C_DEPS += \
./lvgl/examples/widgets/canvas/lv_example_canvas_1.d \
./lvgl/examples/widgets/canvas/lv_example_canvas_2.d 

OBJS += \
./lvgl/examples/widgets/canvas/lv_example_canvas_1.o \
./lvgl/examples/widgets/canvas/lv_example_canvas_2.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/canvas/%.o: ../lvgl/examples/widgets/canvas/%.c lvgl/examples/widgets/canvas/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-canvas

clean-lvgl-2f-examples-2f-widgets-2f-canvas:
	-$(RM) ./lvgl/examples/widgets/canvas/lv_example_canvas_1.d ./lvgl/examples/widgets/canvas/lv_example_canvas_1.o ./lvgl/examples/widgets/canvas/lv_example_canvas_2.d ./lvgl/examples/widgets/canvas/lv_example_canvas_2.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-canvas

