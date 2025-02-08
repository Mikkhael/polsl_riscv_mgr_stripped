#define MEM(addr,type) (*((volatile type*)(addr)))
#define MEM_B(addr)  MEM(addr, char)
#define MEM_H(addr)  MEM(addr, short)
#define MEM_W(addr)  MEM(addr, int)
#define MEM_D(addr)  MEM(addr, long)
#define MEM_UB(addr) MEM(addr, unsigned char)
#define MEM_UH(addr) MEM(addr, unsigned long)
#define MEM_UW(addr) MEM(addr, unsigned long)
#define MEM_UD(addr) MEM(addr, unsigned long)

#define DEF_VAR_S(addr, type, name) static type* const name = (type*)(addr);
#define DEF_VAR(addr, type, name) type* const name = (type*)(addr);

#ifndef SP_INIT
#define SP_INIT 1024
#endif

#define STRINGIFY2(x) #x
#define STRINGIFY(x) STRINGIFY2(x)

#define ENTRY __attribute__((naked, section ("entry"))) void _start
#define RISCV_SETUP __asm__("nop\nli sp, " STRINGIFY(SP_INIT) );
#define RISCV_HALT  __asm__("xor x0,x0,x0\nnop\nnop\nnop");

