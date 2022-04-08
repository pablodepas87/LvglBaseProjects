################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/examples/layouts/grid/lv_example_grid_1.c \
../lvgl/examples/layouts/grid/lv_example_grid_2.c \
../lvgl/examples/layouts/grid/lv_example_grid_3.c \
../lvgl/examples/layouts/grid/lv_example_grid_4.c \
../lvgl/examples/layouts/grid/lv_example_grid_5.c \
../lvgl/examples/layouts/grid/lv_example_grid_6.c 

C_DEPS += \
./lvgl/examples/layouts/grid/lv_example_grid_1.d \
./lvgl/examples/layouts/grid/lv_example_grid_2.d \
./lvgl/examples/layouts/grid/lv_example_grid_3.d \
./lvgl/examples/layouts/grid/lv_example_grid_4.d \
./lvgl/examples/layouts/grid/lv_example_grid_5.d \
./lvgl/examples/layouts/grid/lv_example_grid_6.d 

OBJS += \
./lvgl/examples/layouts/grid/lv_example_grid_1.o \
./lvgl/examples/layouts/grid/lv_example_grid_2.o \
./lvgl/examples/layouts/grid/lv_example_grid_3.o \
./lvgl/examples/layouts/grid/lv_example_grid_4.o \
./lvgl/examples/layouts/grid/lv_example_grid_5.o \
./lvgl/examples/layouts/grid/lv_example_grid_6.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/examples/layouts/grid/%.o: ../lvgl/examples/layouts/grid/%.c lvgl/examples/layouts/grid/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-examples-2f-layouts-2f-grid

clean-lvgl-2f-examples-2f-layouts-2f-grid:
	-$(RM) ./lvgl/examples/layouts/grid/lv_example_grid_1.d ./lvgl/examples/layouts/grid/lv_example_grid_1.o ./lvgl/examples/layouts/grid/lv_example_grid_2.d ./lvgl/examples/layouts/grid/lv_example_grid_2.o ./lvgl/examples/layouts/grid/lv_example_grid_3.d ./lvgl/examples/layouts/grid/lv_example_grid_3.o ./lvgl/examples/layouts/grid/lv_example_grid_4.d ./lvgl/examples/layouts/grid/lv_example_grid_4.o ./lvgl/examples/layouts/grid/lv_example_grid_5.d ./lvgl/examples/layouts/grid/lv_example_grid_5.o ./lvgl/examples/layouts/grid/lv_example_grid_6.d ./lvgl/examples/layouts/grid/lv_example_grid_6.o

.PHONY: clean-lvgl-2f-examples-2f-layouts-2f-grid

