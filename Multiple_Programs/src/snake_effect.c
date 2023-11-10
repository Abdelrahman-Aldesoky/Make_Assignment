#include "../inc/LBit_Math.h"
#include "../inc/LSTD_Types.h"
#include "../lib/MDIO_Interface.h"
#include <util/delay.h>

int main(void)
{
    u8 snake_effect = 15;
    DIO_voidSetPortDirection(PORTA_REG, PORT_DIRECTION_OUTPUT);

    while (1)
    {
        snake_effect = 15;
        for (int i = 0; i < 8; i++)
        {
            DIO_voidSetPortValue(PORTA_REG, snake_effect);
            _delay_ms(500);
            snake_effect = (snake_effect << 1) | (snake_effect >> 7);
        }
    }
    return 0;
}