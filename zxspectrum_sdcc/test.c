#include "zxromservices.h"

void zx_output_string(char*);

void main()
{
    zx_output_chanel_set(2);
    zx_output_string("Hello, World!\r");
}

void zx_output_string(char *lstring)
{
    int i;
    char c;
    for(i=0;c=lstring[i];++i)
        zx_output_char(c);
}
