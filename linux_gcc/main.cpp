#include <syscall.h>

inline void syscall(int service, auto b)
{
    __asm__ (
    "int $0x80\n\t"
    :
    : "a" (service), "b" (b)
    );
}

inline void syscall(int service, auto b, auto c, auto d)
{
    __asm__ (
    "int $0x80\n\t"
    :
    : "a" (service), "b" (b), "c" (c), "d" (d)
    );
}

extern "C" void _start()
{
    syscall(__NR_write, 1, "Hello, World!\n", 14);
    syscall(__NR_exit, 0);
}
