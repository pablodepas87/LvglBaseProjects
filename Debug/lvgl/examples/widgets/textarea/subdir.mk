################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/textarea/lv_example_textarea_1.c \
../lvgl/examples/widgets/textarea/lv_example_textarea_2.c \
../lvgl/examples/widgets/textarea/lv_example_textarea_3.c 

C_DEPS += \
./lvgl/examples/widgets/textarea/lv_example_textarea_1.d \
./lvgl/examples/widgets/textarea/lv_example_textarea_2.d \
./lvgl/examples/widgets/textarea/lv_example_textarea_3.d 

OBJS += \
./lvgl/examples/widgets/textarea/lv_example_textarea_1.o \
./lvgl/examples/widgets/textarea/lv_example_textarea_2.o \
./lvgl/examples/widgets/textarea/lv_example_textarea_3.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/textarea/%.o: ../lvgl/examples/widgets/textarea/%.c lvgl/examples/widgets/textarea/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-textarea

clean-lvgl-2f-examples-2f-widgets-2f-textarea:
	-$(RM) ./lvgl/examples/widgets/textarea/lv_example_textarea_1.d ./lvgl/examples/widgets/textarea/lv_example_textarea_1.o ./lvgl/examples/widgets/textarea/lv_example_textarea_2.d ./lvgl/examples/widgets/textarea/lv_example_textarea_2.o ./lvgl/examples/widgets/textarea/lv_example_textarea_3.d ./lvgl/examples/widgets/textarea/lv_example_textarea_3.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-textarea

