################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lv_drivers/sdl/sdl.c \
../lv_drivers/sdl/sdl_gpu.c 

C_DEPS += \
./lv_drivers/sdl/sdl.d \
./lv_drivers/sdl/sdl_gpu.d 

OBJS += \
./lv_drivers/sdl/sdl.o \
./lv_drivers/sdl/sdl_gpu.o 


# Each subdirectory must supply rules for building sources it contributes
lv_drivers/sdl/%.o: ../lv_drivers/sdl/%.c lv_drivers/sdl/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lv_drivers-2f-sdl

clean-lv_drivers-2f-sdl:
	-$(RM) ./lv_drivers/sdl/sdl.d ./lv_drivers/sdl/sdl.o ./lv_drivers/sdl/sdl_gpu.d ./lv_drivers/sdl/sdl_gpu.o

.PHONY: clean-lv_drivers-2f-sdl

