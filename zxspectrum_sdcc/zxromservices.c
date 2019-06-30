
void zx_output_channel_set(unsigned char v)
{
    v;
    __asm
    ld      hl, #2
    add     hl, sp
    ld      a, (hl)
    call 5633
    __endasm;
}

void zx_output_char(unsigned char v)
{
    v;
    __asm
    ld      hl, #2
    add     hl, sp
    ld      a, (hl)
    rst 16
    __endasm;
}
