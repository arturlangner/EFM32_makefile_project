#include <SEGGER/SEGGER_RTT.h>
#include <em_cmu.h> //clock library
#include <em_gpio.h>
int main(void){
    SEGGER_RTT_WriteString(0, "Hello from EFM32!");
    CMU_ClockEnable(cmuClock_GPIO, true);
    GPIO_PinModeSet(gpioPortA, 4/*pin 4*/, gpioModePushPull /*push-pull output*/, 1/*output level*/);
    while(1){
        asm("bkpt #1");
        GPIO_PinOutToggle(gpioPortA, 4/*pin 4*/);
    }
    return 0;
}
