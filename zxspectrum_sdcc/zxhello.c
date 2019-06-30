#include "zxromservices.h"

void zx_output_string(char*);

void main()
{
    zx_output_channel_set(2);
    zx_output_string("Hello, World!\r");
}

void zx_output_string(char *str)
{
    int i;
    char c;
    for(i=0;c=str[i];++i)
        zx_output_char(c);
}
