################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/tabview/lv_example_tabview_1.c \
../lvgl/examples/widgets/tabview/lv_example_tabview_2.c 

C_DEPS += \
./lvgl/examples/widgets/tabview/lv_example_tabview_1.d \
./lvgl/examples/widgets/tabview/lv_example_tabview_2.d 

OBJS += \
./lvgl/examples/widgets/tabview/lv_example_tabview_1.o \
./lvgl/examples/widgets/tabview/lv_example_tabview_2.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/tabview/%.o: ../lvgl/examples/widgets/tabview/%.c lvgl/examples/widgets/tabview/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-tabview

clean-lvgl-2f-examples-2f-widgets-2f-tabview:
	-$(RM) ./lvgl/examples/widgets/tabview/lv_example_tabview_1.d ./lvgl/examples/widgets/tabview/lv_example_tabview_1.o ./lvgl/examples/widgets/tabview/lv_example_tabview_2.d ./lvgl/examples/widgets/tabview/lv_example_tabview_2.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-tabview

