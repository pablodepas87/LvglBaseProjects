################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/btn/lv_example_btn_1.c \
../lvgl/examples/widgets/btn/lv_example_btn_2.c \
../lvgl/examples/widgets/btn/lv_example_btn_3.c 

C_DEPS += \
./lvgl/examples/widgets/btn/lv_example_btn_1.d \
./lvgl/examples/widgets/btn/lv_example_btn_2.d \
./lvgl/examples/widgets/btn/lv_example_btn_3.d 

OBJS += \
./lvgl/examples/widgets/btn/lv_example_btn_1.o \
./lvgl/examples/widgets/btn/lv_example_btn_2.o \
./lvgl/examples/widgets/btn/lv_example_btn_3.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/btn/%.o: ../lvgl/examples/widgets/btn/%.c lvgl/examples/widgets/btn/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-btn

clean-lvgl-2f-examples-2f-widgets-2f-btn:
	-$(RM) ./lvgl/examples/widgets/btn/lv_example_btn_1.d ./lvgl/examples/widgets/btn/lv_example_btn_1.o ./lvgl/examples/widgets/btn/lv_example_btn_2.d ./lvgl/examples/widgets/btn/lv_example_btn_2.o ./lvgl/examples/widgets/btn/lv_example_btn_3.d ./lvgl/examples/widgets/btn/lv_example_btn_3.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-btn

