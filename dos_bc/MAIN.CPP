void dos_str_out(char* str);

void main()
{
    dos_str_out("Hello, World!\n$");
}

void dos_str_out(char* str)
{
    asm {
        mov     dx, str
        mov     ah, 9
        int     21h
    }
}
