################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../lvgl/src/gpu/lv_gpu_nxp_pxp.c \
../lvgl/src/gpu/lv_gpu_nxp_pxp_osa.c \
../lvgl/src/gpu/lv_gpu_nxp_vglite.c \
../lvgl/src/gpu/lv_gpu_stm32_dma2d.c 

C_DEPS += \
./lvgl/src/gpu/lv_gpu_nxp_pxp.d \
./lvgl/src/gpu/lv_gpu_nxp_pxp_osa.d \
./lvgl/src/gpu/lv_gpu_nxp_vglite.d \
./lvgl/src/gpu/lv_gpu_stm32_dma2d.d 

OBJS += \
./lvgl/src/gpu/lv_gpu_nxp_pxp.o \
./lvgl/src/gpu/lv_gpu_nxp_pxp_osa.o \
./lvgl/src/gpu/lv_gpu_nxp_vglite.o \
./lvgl/src/gpu/lv_gpu_stm32_dma2d.o 


# Each subdirectory must supply rules for building sources it contributes
lvgl/src/gpu/%.o: ../lvgl/src/gpu/%.c lvgl/src/gpu/subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C Compiler'
	gcc -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean-lvgl-2f-src-2f-gpu

clean-lvgl-2f-src-2f-gpu:
	-$(RM) ./lvgl/src/gpu/lv_gpu_nxp_pxp.d ./lvgl/src/gpu/lv_gpu_nxp_pxp.o ./lvgl/src/gpu/lv_gpu_nxp_pxp_osa.d ./lvgl/src/gpu/lv_gpu_nxp_pxp_osa.o ./lvgl/src/gpu/lv_gpu_nxp_vglite.d ./lvgl/src/gpu/lv_gpu_nxp_vglite.o ./lvgl/src/gpu/lv_gpu_stm32_dma2d.d ./lvgl/src/gpu/lv_gpu_stm32_dma2d.o

.PHONY: clean-lvgl-2f-src-2f-gpu

