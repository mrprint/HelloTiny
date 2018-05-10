#include <windows.h>

int __stdcall entry() {
    DWORD bsent;
    HANDLE h = GetStdHandle(STD_OUTPUT_HANDLE);
    WriteConsole(h, "Hello, World!\n", 14, &bsent, 0);
    return 0;
}

