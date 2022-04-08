################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/arc/lv_example_arc_1.c \
../lvgl/examples/widgets/arc/lv_example_arc_2.c 

C_DEPS += \
./lvgl/examples/widgets/arc/lv_example_arc_1.d \
./lvgl/examples/widgets/arc/lv_example_arc_2.d 

OBJS += \
./lvgl/examples/widgets/arc/lv_example_arc_1.o \
./lvgl/examples/widgets/arc/lv_example_arc_2.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/arc/%.o: ../lvgl/examples/widgets/arc/%.c lvgl/examples/widgets/arc/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-arc

clean-lvgl-2f-examples-2f-widgets-2f-arc:
	-$(RM) ./lvgl/examples/widgets/arc/lv_example_arc_1.d ./lvgl/examples/widgets/arc/lv_example_arc_1.o ./lvgl/examples/widgets/arc/lv_example_arc_2.d ./lvgl/examples/widgets/arc/lv_example_arc_2.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-arc

