################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/widgets/dropdown/lv_example_dropdown_1.c \
../lvgl/examples/widgets/dropdown/lv_example_dropdown_2.c \
../lvgl/examples/widgets/dropdown/lv_example_dropdown_3.c 

C_DEPS += \
./lvgl/examples/widgets/dropdown/lv_example_dropdown_1.d \
./lvgl/examples/widgets/dropdown/lv_example_dropdown_2.d \
./lvgl/examples/widgets/dropdown/lv_example_dropdown_3.d 

OBJS += \
./lvgl/examples/widgets/dropdown/lv_example_dropdown_1.o \
./lvgl/examples/widgets/dropdown/lv_example_dropdown_2.o \
./lvgl/examples/widgets/dropdown/lv_example_dropdown_3.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/widgets/dropdown/%.o: ../lvgl/examples/widgets/dropdown/%.c lvgl/examples/widgets/dropdown/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-widgets-2f-dropdown

clean-lvgl-2f-examples-2f-widgets-2f-dropdown:
	-$(RM) ./lvgl/examples/widgets/dropdown/lv_example_dropdown_1.d ./lvgl/examples/widgets/dropdown/lv_example_dropdown_1.o ./lvgl/examples/widgets/dropdown/lv_example_dropdown_2.d ./lvgl/examples/widgets/dropdown/lv_example_dropdown_2.o ./lvgl/examples/widgets/dropdown/lv_example_dropdown_3.d ./lvgl/examples/widgets/dropdown/lv_example_dropdown_3.o

.PHONY: clean-lvgl-2f-examples-2f-widgets-2f-dropdown

