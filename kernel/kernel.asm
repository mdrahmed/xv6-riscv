
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	18010113          	addi	sp,sp,384 # 80009180 <stack0>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	078000ef          	jal	ra,8000008e <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    8000001c:	1141                	addi	sp,sp,-16
    8000001e:	e422                	sd	s0,8(sp)
    80000020:	0800                	addi	s0,sp,16
// which hart (core) is this?
static inline uint64
r_mhartid()
{
  uint64 x;
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80000022:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    80000026:	0007869b          	sext.w	a3,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    8000002a:	0037979b          	slliw	a5,a5,0x3
    8000002e:	02004737          	lui	a4,0x2004
    80000032:	97ba                	add	a5,a5,a4
    80000034:	0200c737          	lui	a4,0x200c
    80000038:	ff873583          	ld	a1,-8(a4) # 200bff8 <_entry-0x7dff4008>
    8000003c:	000f4637          	lui	a2,0xf4
    80000040:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    80000044:	95b2                	add	a1,a1,a2
    80000046:	e38c                	sd	a1,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    80000048:	00269713          	slli	a4,a3,0x2
    8000004c:	9736                	add	a4,a4,a3
    8000004e:	00371693          	slli	a3,a4,0x3
    80000052:	00009717          	auipc	a4,0x9
    80000056:	fee70713          	addi	a4,a4,-18 # 80009040 <timer_scratch>
    8000005a:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    8000005c:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    8000005e:	f310                	sd	a2,32(a4)
}

static inline void 
w_mscratch(uint64 x)
{
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80000060:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80000064:	00006797          	auipc	a5,0x6
    80000068:	d1c78793          	addi	a5,a5,-740 # 80005d80 <timervec>
    8000006c:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000070:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    80000074:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    80000078:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    8000007c:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    80000080:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    80000084:	30479073          	csrw	mie,a5
}
    80000088:	6422                	ld	s0,8(sp)
    8000008a:	0141                	addi	sp,sp,16
    8000008c:	8082                	ret

000000008000008e <start>:
{
    8000008e:	1141                	addi	sp,sp,-16
    80000090:	e406                	sd	ra,8(sp)
    80000092:	e022                	sd	s0,0(sp)
    80000094:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    80000096:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    8000009a:	7779                	lui	a4,0xffffe
    8000009c:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd81a7>
    800000a0:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800000a2:	6705                	lui	a4,0x1
    800000a4:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800000a8:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800000aa:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800000ae:	00001797          	auipc	a5,0x1
    800000b2:	dcc78793          	addi	a5,a5,-564 # 80000e7a <main>
    800000b6:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800000ba:	4781                	li	a5,0
    800000bc:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800000c0:	67c1                	lui	a5,0x10
    800000c2:	17fd                	addi	a5,a5,-1
    800000c4:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800000c8:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    800000cc:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    800000d0:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    800000d4:	10479073          	csrw	sie,a5
  timerinit();
    800000d8:	00000097          	auipc	ra,0x0
    800000dc:	f44080e7          	jalr	-188(ra) # 8000001c <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    800000e0:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    800000e4:	2781                	sext.w	a5,a5
}

static inline void 
w_tp(uint64 x)
{
  asm volatile("mv tp, %0" : : "r" (x));
    800000e6:	823e                	mv	tp,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    800000e8:	57fd                	li	a5,-1
    800000ea:	83a9                	srli	a5,a5,0xa
    800000ec:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    800000f0:	47fd                	li	a5,31
    800000f2:	3a079073          	csrw	pmpcfg0,a5
  asm volatile("mret");
    800000f6:	30200073          	mret
}
    800000fa:	60a2                	ld	ra,8(sp)
    800000fc:	6402                	ld	s0,0(sp)
    800000fe:	0141                	addi	sp,sp,16
    80000100:	8082                	ret

0000000080000102 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80000102:	715d                	addi	sp,sp,-80
    80000104:	e486                	sd	ra,72(sp)
    80000106:	e0a2                	sd	s0,64(sp)
    80000108:	fc26                	sd	s1,56(sp)
    8000010a:	f84a                	sd	s2,48(sp)
    8000010c:	f44e                	sd	s3,40(sp)
    8000010e:	f052                	sd	s4,32(sp)
    80000110:	ec56                	sd	s5,24(sp)
    80000112:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80000114:	04c05663          	blez	a2,80000160 <consolewrite+0x5e>
    80000118:	8a2a                	mv	s4,a0
    8000011a:	84ae                	mv	s1,a1
    8000011c:	89b2                	mv	s3,a2
    8000011e:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80000120:	5afd                	li	s5,-1
    80000122:	4685                	li	a3,1
    80000124:	8626                	mv	a2,s1
    80000126:	85d2                	mv	a1,s4
    80000128:	fbf40513          	addi	a0,s0,-65
    8000012c:	00002097          	auipc	ra,0x2
    80000130:	3f4080e7          	jalr	1012(ra) # 80002520 <either_copyin>
    80000134:	01550c63          	beq	a0,s5,8000014c <consolewrite+0x4a>
      break;
    uartputc(c);
    80000138:	fbf44503          	lbu	a0,-65(s0)
    8000013c:	00000097          	auipc	ra,0x0
    80000140:	77a080e7          	jalr	1914(ra) # 800008b6 <uartputc>
  for(i = 0; i < n; i++){
    80000144:	2905                	addiw	s2,s2,1
    80000146:	0485                	addi	s1,s1,1
    80000148:	fd299de3          	bne	s3,s2,80000122 <consolewrite+0x20>
  }

  return i;
}
    8000014c:	854a                	mv	a0,s2
    8000014e:	60a6                	ld	ra,72(sp)
    80000150:	6406                	ld	s0,64(sp)
    80000152:	74e2                	ld	s1,56(sp)
    80000154:	7942                	ld	s2,48(sp)
    80000156:	79a2                	ld	s3,40(sp)
    80000158:	7a02                	ld	s4,32(sp)
    8000015a:	6ae2                	ld	s5,24(sp)
    8000015c:	6161                	addi	sp,sp,80
    8000015e:	8082                	ret
  for(i = 0; i < n; i++){
    80000160:	4901                	li	s2,0
    80000162:	b7ed                	j	8000014c <consolewrite+0x4a>

0000000080000164 <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    80000164:	7159                	addi	sp,sp,-112
    80000166:	f486                	sd	ra,104(sp)
    80000168:	f0a2                	sd	s0,96(sp)
    8000016a:	eca6                	sd	s1,88(sp)
    8000016c:	e8ca                	sd	s2,80(sp)
    8000016e:	e4ce                	sd	s3,72(sp)
    80000170:	e0d2                	sd	s4,64(sp)
    80000172:	fc56                	sd	s5,56(sp)
    80000174:	f85a                	sd	s6,48(sp)
    80000176:	f45e                	sd	s7,40(sp)
    80000178:	f062                	sd	s8,32(sp)
    8000017a:	ec66                	sd	s9,24(sp)
    8000017c:	e86a                	sd	s10,16(sp)
    8000017e:	1880                	addi	s0,sp,112
    80000180:	8aaa                	mv	s5,a0
    80000182:	8a2e                	mv	s4,a1
    80000184:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    80000186:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    8000018a:	00011517          	auipc	a0,0x11
    8000018e:	ff650513          	addi	a0,a0,-10 # 80011180 <cons>
    80000192:	00001097          	auipc	ra,0x1
    80000196:	a3e080e7          	jalr	-1474(ra) # 80000bd0 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    8000019a:	00011497          	auipc	s1,0x11
    8000019e:	fe648493          	addi	s1,s1,-26 # 80011180 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800001a2:	00011917          	auipc	s2,0x11
    800001a6:	07690913          	addi	s2,s2,118 # 80011218 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    800001aa:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800001ac:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800001ae:	4ca9                	li	s9,10
  while(n > 0){
    800001b0:	07305863          	blez	s3,80000220 <consoleread+0xbc>
    while(cons.r == cons.w){
    800001b4:	0984a783          	lw	a5,152(s1)
    800001b8:	09c4a703          	lw	a4,156(s1)
    800001bc:	02f71463          	bne	a4,a5,800001e4 <consoleread+0x80>
      if(myproc()->killed){
    800001c0:	00002097          	auipc	ra,0x2
    800001c4:	8a6080e7          	jalr	-1882(ra) # 80001a66 <myproc>
    800001c8:	551c                	lw	a5,40(a0)
    800001ca:	e7b5                	bnez	a5,80000236 <consoleread+0xd2>
      sleep(&cons.r, &cons.lock);
    800001cc:	85a6                	mv	a1,s1
    800001ce:	854a                	mv	a0,s2
    800001d0:	00002097          	auipc	ra,0x2
    800001d4:	f56080e7          	jalr	-170(ra) # 80002126 <sleep>
    while(cons.r == cons.w){
    800001d8:	0984a783          	lw	a5,152(s1)
    800001dc:	09c4a703          	lw	a4,156(s1)
    800001e0:	fef700e3          	beq	a4,a5,800001c0 <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF];
    800001e4:	0017871b          	addiw	a4,a5,1
    800001e8:	08e4ac23          	sw	a4,152(s1)
    800001ec:	07f7f713          	andi	a4,a5,127
    800001f0:	9726                	add	a4,a4,s1
    800001f2:	01874703          	lbu	a4,24(a4)
    800001f6:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    800001fa:	077d0563          	beq	s10,s7,80000264 <consoleread+0x100>
    cbuf = c;
    800001fe:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80000202:	4685                	li	a3,1
    80000204:	f9f40613          	addi	a2,s0,-97
    80000208:	85d2                	mv	a1,s4
    8000020a:	8556                	mv	a0,s5
    8000020c:	00002097          	auipc	ra,0x2
    80000210:	2be080e7          	jalr	702(ra) # 800024ca <either_copyout>
    80000214:	01850663          	beq	a0,s8,80000220 <consoleread+0xbc>
    dst++;
    80000218:	0a05                	addi	s4,s4,1
    --n;
    8000021a:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    8000021c:	f99d1ae3          	bne	s10,s9,800001b0 <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80000220:	00011517          	auipc	a0,0x11
    80000224:	f6050513          	addi	a0,a0,-160 # 80011180 <cons>
    80000228:	00001097          	auipc	ra,0x1
    8000022c:	a5c080e7          	jalr	-1444(ra) # 80000c84 <release>

  return target - n;
    80000230:	413b053b          	subw	a0,s6,s3
    80000234:	a811                	j	80000248 <consoleread+0xe4>
        release(&cons.lock);
    80000236:	00011517          	auipc	a0,0x11
    8000023a:	f4a50513          	addi	a0,a0,-182 # 80011180 <cons>
    8000023e:	00001097          	auipc	ra,0x1
    80000242:	a46080e7          	jalr	-1466(ra) # 80000c84 <release>
        return -1;
    80000246:	557d                	li	a0,-1
}
    80000248:	70a6                	ld	ra,104(sp)
    8000024a:	7406                	ld	s0,96(sp)
    8000024c:	64e6                	ld	s1,88(sp)
    8000024e:	6946                	ld	s2,80(sp)
    80000250:	69a6                	ld	s3,72(sp)
    80000252:	6a06                	ld	s4,64(sp)
    80000254:	7ae2                	ld	s5,56(sp)
    80000256:	7b42                	ld	s6,48(sp)
    80000258:	7ba2                	ld	s7,40(sp)
    8000025a:	7c02                	ld	s8,32(sp)
    8000025c:	6ce2                	ld	s9,24(sp)
    8000025e:	6d42                	ld	s10,16(sp)
    80000260:	6165                	addi	sp,sp,112
    80000262:	8082                	ret
      if(n < target){
    80000264:	0009871b          	sext.w	a4,s3
    80000268:	fb677ce3          	bgeu	a4,s6,80000220 <consoleread+0xbc>
        cons.r--;
    8000026c:	00011717          	auipc	a4,0x11
    80000270:	faf72623          	sw	a5,-84(a4) # 80011218 <cons+0x98>
    80000274:	b775                	j	80000220 <consoleread+0xbc>

0000000080000276 <consputc>:
{
    80000276:	1141                	addi	sp,sp,-16
    80000278:	e406                	sd	ra,8(sp)
    8000027a:	e022                	sd	s0,0(sp)
    8000027c:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    8000027e:	10000793          	li	a5,256
    80000282:	00f50a63          	beq	a0,a5,80000296 <consputc+0x20>
    uartputc_sync(c);
    80000286:	00000097          	auipc	ra,0x0
    8000028a:	55e080e7          	jalr	1374(ra) # 800007e4 <uartputc_sync>
}
    8000028e:	60a2                	ld	ra,8(sp)
    80000290:	6402                	ld	s0,0(sp)
    80000292:	0141                	addi	sp,sp,16
    80000294:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    80000296:	4521                	li	a0,8
    80000298:	00000097          	auipc	ra,0x0
    8000029c:	54c080e7          	jalr	1356(ra) # 800007e4 <uartputc_sync>
    800002a0:	02000513          	li	a0,32
    800002a4:	00000097          	auipc	ra,0x0
    800002a8:	540080e7          	jalr	1344(ra) # 800007e4 <uartputc_sync>
    800002ac:	4521                	li	a0,8
    800002ae:	00000097          	auipc	ra,0x0
    800002b2:	536080e7          	jalr	1334(ra) # 800007e4 <uartputc_sync>
    800002b6:	bfe1                	j	8000028e <consputc+0x18>

00000000800002b8 <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800002b8:	1101                	addi	sp,sp,-32
    800002ba:	ec06                	sd	ra,24(sp)
    800002bc:	e822                	sd	s0,16(sp)
    800002be:	e426                	sd	s1,8(sp)
    800002c0:	e04a                	sd	s2,0(sp)
    800002c2:	1000                	addi	s0,sp,32
    800002c4:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800002c6:	00011517          	auipc	a0,0x11
    800002ca:	eba50513          	addi	a0,a0,-326 # 80011180 <cons>
    800002ce:	00001097          	auipc	ra,0x1
    800002d2:	902080e7          	jalr	-1790(ra) # 80000bd0 <acquire>

  switch(c){
    800002d6:	47d5                	li	a5,21
    800002d8:	0af48663          	beq	s1,a5,80000384 <consoleintr+0xcc>
    800002dc:	0297ca63          	blt	a5,s1,80000310 <consoleintr+0x58>
    800002e0:	47a1                	li	a5,8
    800002e2:	0ef48763          	beq	s1,a5,800003d0 <consoleintr+0x118>
    800002e6:	47c1                	li	a5,16
    800002e8:	10f49a63          	bne	s1,a5,800003fc <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    800002ec:	00002097          	auipc	ra,0x2
    800002f0:	28a080e7          	jalr	650(ra) # 80002576 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    800002f4:	00011517          	auipc	a0,0x11
    800002f8:	e8c50513          	addi	a0,a0,-372 # 80011180 <cons>
    800002fc:	00001097          	auipc	ra,0x1
    80000300:	988080e7          	jalr	-1656(ra) # 80000c84 <release>
}
    80000304:	60e2                	ld	ra,24(sp)
    80000306:	6442                	ld	s0,16(sp)
    80000308:	64a2                	ld	s1,8(sp)
    8000030a:	6902                	ld	s2,0(sp)
    8000030c:	6105                	addi	sp,sp,32
    8000030e:	8082                	ret
  switch(c){
    80000310:	07f00793          	li	a5,127
    80000314:	0af48e63          	beq	s1,a5,800003d0 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80000318:	00011717          	auipc	a4,0x11
    8000031c:	e6870713          	addi	a4,a4,-408 # 80011180 <cons>
    80000320:	0a072783          	lw	a5,160(a4)
    80000324:	09872703          	lw	a4,152(a4)
    80000328:	9f99                	subw	a5,a5,a4
    8000032a:	07f00713          	li	a4,127
    8000032e:	fcf763e3          	bltu	a4,a5,800002f4 <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80000332:	47b5                	li	a5,13
    80000334:	0cf48763          	beq	s1,a5,80000402 <consoleintr+0x14a>
      consputc(c);
    80000338:	8526                	mv	a0,s1
    8000033a:	00000097          	auipc	ra,0x0
    8000033e:	f3c080e7          	jalr	-196(ra) # 80000276 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000342:	00011797          	auipc	a5,0x11
    80000346:	e3e78793          	addi	a5,a5,-450 # 80011180 <cons>
    8000034a:	0a07a703          	lw	a4,160(a5)
    8000034e:	0017069b          	addiw	a3,a4,1
    80000352:	0006861b          	sext.w	a2,a3
    80000356:	0ad7a023          	sw	a3,160(a5)
    8000035a:	07f77713          	andi	a4,a4,127
    8000035e:	97ba                	add	a5,a5,a4
    80000360:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80000364:	47a9                	li	a5,10
    80000366:	0cf48563          	beq	s1,a5,80000430 <consoleintr+0x178>
    8000036a:	4791                	li	a5,4
    8000036c:	0cf48263          	beq	s1,a5,80000430 <consoleintr+0x178>
    80000370:	00011797          	auipc	a5,0x11
    80000374:	ea87a783          	lw	a5,-344(a5) # 80011218 <cons+0x98>
    80000378:	0807879b          	addiw	a5,a5,128
    8000037c:	f6f61ce3          	bne	a2,a5,800002f4 <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80000380:	863e                	mv	a2,a5
    80000382:	a07d                	j	80000430 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80000384:	00011717          	auipc	a4,0x11
    80000388:	dfc70713          	addi	a4,a4,-516 # 80011180 <cons>
    8000038c:	0a072783          	lw	a5,160(a4)
    80000390:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80000394:	00011497          	auipc	s1,0x11
    80000398:	dec48493          	addi	s1,s1,-532 # 80011180 <cons>
    while(cons.e != cons.w &&
    8000039c:	4929                	li	s2,10
    8000039e:	f4f70be3          	beq	a4,a5,800002f4 <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    800003a2:	37fd                	addiw	a5,a5,-1
    800003a4:	07f7f713          	andi	a4,a5,127
    800003a8:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    800003aa:	01874703          	lbu	a4,24(a4)
    800003ae:	f52703e3          	beq	a4,s2,800002f4 <consoleintr+0x3c>
      cons.e--;
    800003b2:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    800003b6:	10000513          	li	a0,256
    800003ba:	00000097          	auipc	ra,0x0
    800003be:	ebc080e7          	jalr	-324(ra) # 80000276 <consputc>
    while(cons.e != cons.w &&
    800003c2:	0a04a783          	lw	a5,160(s1)
    800003c6:	09c4a703          	lw	a4,156(s1)
    800003ca:	fcf71ce3          	bne	a4,a5,800003a2 <consoleintr+0xea>
    800003ce:	b71d                	j	800002f4 <consoleintr+0x3c>
    if(cons.e != cons.w){
    800003d0:	00011717          	auipc	a4,0x11
    800003d4:	db070713          	addi	a4,a4,-592 # 80011180 <cons>
    800003d8:	0a072783          	lw	a5,160(a4)
    800003dc:	09c72703          	lw	a4,156(a4)
    800003e0:	f0f70ae3          	beq	a4,a5,800002f4 <consoleintr+0x3c>
      cons.e--;
    800003e4:	37fd                	addiw	a5,a5,-1
    800003e6:	00011717          	auipc	a4,0x11
    800003ea:	e2f72d23          	sw	a5,-454(a4) # 80011220 <cons+0xa0>
      consputc(BACKSPACE);
    800003ee:	10000513          	li	a0,256
    800003f2:	00000097          	auipc	ra,0x0
    800003f6:	e84080e7          	jalr	-380(ra) # 80000276 <consputc>
    800003fa:	bded                	j	800002f4 <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    800003fc:	ee048ce3          	beqz	s1,800002f4 <consoleintr+0x3c>
    80000400:	bf21                	j	80000318 <consoleintr+0x60>
      consputc(c);
    80000402:	4529                	li	a0,10
    80000404:	00000097          	auipc	ra,0x0
    80000408:	e72080e7          	jalr	-398(ra) # 80000276 <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    8000040c:	00011797          	auipc	a5,0x11
    80000410:	d7478793          	addi	a5,a5,-652 # 80011180 <cons>
    80000414:	0a07a703          	lw	a4,160(a5)
    80000418:	0017069b          	addiw	a3,a4,1
    8000041c:	0006861b          	sext.w	a2,a3
    80000420:	0ad7a023          	sw	a3,160(a5)
    80000424:	07f77713          	andi	a4,a4,127
    80000428:	97ba                	add	a5,a5,a4
    8000042a:	4729                	li	a4,10
    8000042c:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80000430:	00011797          	auipc	a5,0x11
    80000434:	dec7a623          	sw	a2,-532(a5) # 8001121c <cons+0x9c>
        wakeup(&cons.r);
    80000438:	00011517          	auipc	a0,0x11
    8000043c:	de050513          	addi	a0,a0,-544 # 80011218 <cons+0x98>
    80000440:	00002097          	auipc	ra,0x2
    80000444:	e72080e7          	jalr	-398(ra) # 800022b2 <wakeup>
    80000448:	b575                	j	800002f4 <consoleintr+0x3c>

000000008000044a <consoleinit>:

void
consoleinit(void)
{
    8000044a:	1141                	addi	sp,sp,-16
    8000044c:	e406                	sd	ra,8(sp)
    8000044e:	e022                	sd	s0,0(sp)
    80000450:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80000452:	00008597          	auipc	a1,0x8
    80000456:	bbe58593          	addi	a1,a1,-1090 # 80008010 <etext+0x10>
    8000045a:	00011517          	auipc	a0,0x11
    8000045e:	d2650513          	addi	a0,a0,-730 # 80011180 <cons>
    80000462:	00000097          	auipc	ra,0x0
    80000466:	6de080e7          	jalr	1758(ra) # 80000b40 <initlock>

  uartinit();
    8000046a:	00000097          	auipc	ra,0x0
    8000046e:	32a080e7          	jalr	810(ra) # 80000794 <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80000472:	00021797          	auipc	a5,0x21
    80000476:	ea678793          	addi	a5,a5,-346 # 80021318 <devsw>
    8000047a:	00000717          	auipc	a4,0x0
    8000047e:	cea70713          	addi	a4,a4,-790 # 80000164 <consoleread>
    80000482:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80000484:	00000717          	auipc	a4,0x0
    80000488:	c7e70713          	addi	a4,a4,-898 # 80000102 <consolewrite>
    8000048c:	ef98                	sd	a4,24(a5)
}
    8000048e:	60a2                	ld	ra,8(sp)
    80000490:	6402                	ld	s0,0(sp)
    80000492:	0141                	addi	sp,sp,16
    80000494:	8082                	ret

0000000080000496 <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80000496:	7179                	addi	sp,sp,-48
    80000498:	f406                	sd	ra,40(sp)
    8000049a:	f022                	sd	s0,32(sp)
    8000049c:	ec26                	sd	s1,24(sp)
    8000049e:	e84a                	sd	s2,16(sp)
    800004a0:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    800004a2:	c219                	beqz	a2,800004a8 <printint+0x12>
    800004a4:	08054663          	bltz	a0,80000530 <printint+0x9a>
    x = -xx;
  else
    x = xx;
    800004a8:	2501                	sext.w	a0,a0
    800004aa:	4881                	li	a7,0
    800004ac:	fd040693          	addi	a3,s0,-48

  i = 0;
    800004b0:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    800004b2:	2581                	sext.w	a1,a1
    800004b4:	00008617          	auipc	a2,0x8
    800004b8:	b8c60613          	addi	a2,a2,-1140 # 80008040 <digits>
    800004bc:	883a                	mv	a6,a4
    800004be:	2705                	addiw	a4,a4,1
    800004c0:	02b577bb          	remuw	a5,a0,a1
    800004c4:	1782                	slli	a5,a5,0x20
    800004c6:	9381                	srli	a5,a5,0x20
    800004c8:	97b2                	add	a5,a5,a2
    800004ca:	0007c783          	lbu	a5,0(a5)
    800004ce:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    800004d2:	0005079b          	sext.w	a5,a0
    800004d6:	02b5553b          	divuw	a0,a0,a1
    800004da:	0685                	addi	a3,a3,1
    800004dc:	feb7f0e3          	bgeu	a5,a1,800004bc <printint+0x26>

  if(sign)
    800004e0:	00088b63          	beqz	a7,800004f6 <printint+0x60>
    buf[i++] = '-';
    800004e4:	fe040793          	addi	a5,s0,-32
    800004e8:	973e                	add	a4,a4,a5
    800004ea:	02d00793          	li	a5,45
    800004ee:	fef70823          	sb	a5,-16(a4)
    800004f2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    800004f6:	02e05763          	blez	a4,80000524 <printint+0x8e>
    800004fa:	fd040793          	addi	a5,s0,-48
    800004fe:	00e784b3          	add	s1,a5,a4
    80000502:	fff78913          	addi	s2,a5,-1
    80000506:	993a                	add	s2,s2,a4
    80000508:	377d                	addiw	a4,a4,-1
    8000050a:	1702                	slli	a4,a4,0x20
    8000050c:	9301                	srli	a4,a4,0x20
    8000050e:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80000512:	fff4c503          	lbu	a0,-1(s1)
    80000516:	00000097          	auipc	ra,0x0
    8000051a:	d60080e7          	jalr	-672(ra) # 80000276 <consputc>
  while(--i >= 0)
    8000051e:	14fd                	addi	s1,s1,-1
    80000520:	ff2499e3          	bne	s1,s2,80000512 <printint+0x7c>
}
    80000524:	70a2                	ld	ra,40(sp)
    80000526:	7402                	ld	s0,32(sp)
    80000528:	64e2                	ld	s1,24(sp)
    8000052a:	6942                	ld	s2,16(sp)
    8000052c:	6145                	addi	sp,sp,48
    8000052e:	8082                	ret
    x = -xx;
    80000530:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80000534:	4885                	li	a7,1
    x = -xx;
    80000536:	bf9d                	j	800004ac <printint+0x16>

0000000080000538 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80000538:	1101                	addi	sp,sp,-32
    8000053a:	ec06                	sd	ra,24(sp)
    8000053c:	e822                	sd	s0,16(sp)
    8000053e:	e426                	sd	s1,8(sp)
    80000540:	1000                	addi	s0,sp,32
    80000542:	84aa                	mv	s1,a0
  pr.locking = 0;
    80000544:	00011797          	auipc	a5,0x11
    80000548:	ce07ae23          	sw	zero,-772(a5) # 80011240 <pr+0x18>
  printf("panic: ");
    8000054c:	00008517          	auipc	a0,0x8
    80000550:	acc50513          	addi	a0,a0,-1332 # 80008018 <etext+0x18>
    80000554:	00000097          	auipc	ra,0x0
    80000558:	02e080e7          	jalr	46(ra) # 80000582 <printf>
  printf(s);
    8000055c:	8526                	mv	a0,s1
    8000055e:	00000097          	auipc	ra,0x0
    80000562:	024080e7          	jalr	36(ra) # 80000582 <printf>
  printf("\n");
    80000566:	00008517          	auipc	a0,0x8
    8000056a:	33a50513          	addi	a0,a0,826 # 800088a0 <syscalls+0x470>
    8000056e:	00000097          	auipc	ra,0x0
    80000572:	014080e7          	jalr	20(ra) # 80000582 <printf>
  panicked = 1; // freeze uart output from other CPUs
    80000576:	4785                	li	a5,1
    80000578:	00009717          	auipc	a4,0x9
    8000057c:	a8f72423          	sw	a5,-1400(a4) # 80009000 <panicked>
  for(;;)
    80000580:	a001                	j	80000580 <panic+0x48>

0000000080000582 <printf>:
{
    80000582:	7131                	addi	sp,sp,-192
    80000584:	fc86                	sd	ra,120(sp)
    80000586:	f8a2                	sd	s0,112(sp)
    80000588:	f4a6                	sd	s1,104(sp)
    8000058a:	f0ca                	sd	s2,96(sp)
    8000058c:	ecce                	sd	s3,88(sp)
    8000058e:	e8d2                	sd	s4,80(sp)
    80000590:	e4d6                	sd	s5,72(sp)
    80000592:	e0da                	sd	s6,64(sp)
    80000594:	fc5e                	sd	s7,56(sp)
    80000596:	f862                	sd	s8,48(sp)
    80000598:	f466                	sd	s9,40(sp)
    8000059a:	f06a                	sd	s10,32(sp)
    8000059c:	ec6e                	sd	s11,24(sp)
    8000059e:	0100                	addi	s0,sp,128
    800005a0:	8a2a                	mv	s4,a0
    800005a2:	e40c                	sd	a1,8(s0)
    800005a4:	e810                	sd	a2,16(s0)
    800005a6:	ec14                	sd	a3,24(s0)
    800005a8:	f018                	sd	a4,32(s0)
    800005aa:	f41c                	sd	a5,40(s0)
    800005ac:	03043823          	sd	a6,48(s0)
    800005b0:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    800005b4:	00011d97          	auipc	s11,0x11
    800005b8:	c8cdad83          	lw	s11,-884(s11) # 80011240 <pr+0x18>
  if(locking)
    800005bc:	020d9b63          	bnez	s11,800005f2 <printf+0x70>
  if (fmt == 0)
    800005c0:	040a0263          	beqz	s4,80000604 <printf+0x82>
  va_start(ap, fmt);
    800005c4:	00840793          	addi	a5,s0,8
    800005c8:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    800005cc:	000a4503          	lbu	a0,0(s4)
    800005d0:	14050f63          	beqz	a0,8000072e <printf+0x1ac>
    800005d4:	4981                	li	s3,0
    if(c != '%'){
    800005d6:	02500a93          	li	s5,37
    switch(c){
    800005da:	07000b93          	li	s7,112
  consputc('x');
    800005de:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800005e0:	00008b17          	auipc	s6,0x8
    800005e4:	a60b0b13          	addi	s6,s6,-1440 # 80008040 <digits>
    switch(c){
    800005e8:	07300c93          	li	s9,115
    800005ec:	06400c13          	li	s8,100
    800005f0:	a82d                	j	8000062a <printf+0xa8>
    acquire(&pr.lock);
    800005f2:	00011517          	auipc	a0,0x11
    800005f6:	c3650513          	addi	a0,a0,-970 # 80011228 <pr>
    800005fa:	00000097          	auipc	ra,0x0
    800005fe:	5d6080e7          	jalr	1494(ra) # 80000bd0 <acquire>
    80000602:	bf7d                	j	800005c0 <printf+0x3e>
    panic("null fmt");
    80000604:	00008517          	auipc	a0,0x8
    80000608:	a2450513          	addi	a0,a0,-1500 # 80008028 <etext+0x28>
    8000060c:	00000097          	auipc	ra,0x0
    80000610:	f2c080e7          	jalr	-212(ra) # 80000538 <panic>
      consputc(c);
    80000614:	00000097          	auipc	ra,0x0
    80000618:	c62080e7          	jalr	-926(ra) # 80000276 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    8000061c:	2985                	addiw	s3,s3,1
    8000061e:	013a07b3          	add	a5,s4,s3
    80000622:	0007c503          	lbu	a0,0(a5)
    80000626:	10050463          	beqz	a0,8000072e <printf+0x1ac>
    if(c != '%'){
    8000062a:	ff5515e3          	bne	a0,s5,80000614 <printf+0x92>
    c = fmt[++i] & 0xff;
    8000062e:	2985                	addiw	s3,s3,1
    80000630:	013a07b3          	add	a5,s4,s3
    80000634:	0007c783          	lbu	a5,0(a5)
    80000638:	0007849b          	sext.w	s1,a5
    if(c == 0)
    8000063c:	cbed                	beqz	a5,8000072e <printf+0x1ac>
    switch(c){
    8000063e:	05778a63          	beq	a5,s7,80000692 <printf+0x110>
    80000642:	02fbf663          	bgeu	s7,a5,8000066e <printf+0xec>
    80000646:	09978863          	beq	a5,s9,800006d6 <printf+0x154>
    8000064a:	07800713          	li	a4,120
    8000064e:	0ce79563          	bne	a5,a4,80000718 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80000652:	f8843783          	ld	a5,-120(s0)
    80000656:	00878713          	addi	a4,a5,8
    8000065a:	f8e43423          	sd	a4,-120(s0)
    8000065e:	4605                	li	a2,1
    80000660:	85ea                	mv	a1,s10
    80000662:	4388                	lw	a0,0(a5)
    80000664:	00000097          	auipc	ra,0x0
    80000668:	e32080e7          	jalr	-462(ra) # 80000496 <printint>
      break;
    8000066c:	bf45                	j	8000061c <printf+0x9a>
    switch(c){
    8000066e:	09578f63          	beq	a5,s5,8000070c <printf+0x18a>
    80000672:	0b879363          	bne	a5,s8,80000718 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80000676:	f8843783          	ld	a5,-120(s0)
    8000067a:	00878713          	addi	a4,a5,8
    8000067e:	f8e43423          	sd	a4,-120(s0)
    80000682:	4605                	li	a2,1
    80000684:	45a9                	li	a1,10
    80000686:	4388                	lw	a0,0(a5)
    80000688:	00000097          	auipc	ra,0x0
    8000068c:	e0e080e7          	jalr	-498(ra) # 80000496 <printint>
      break;
    80000690:	b771                	j	8000061c <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80000692:	f8843783          	ld	a5,-120(s0)
    80000696:	00878713          	addi	a4,a5,8
    8000069a:	f8e43423          	sd	a4,-120(s0)
    8000069e:	0007b903          	ld	s2,0(a5)
  consputc('0');
    800006a2:	03000513          	li	a0,48
    800006a6:	00000097          	auipc	ra,0x0
    800006aa:	bd0080e7          	jalr	-1072(ra) # 80000276 <consputc>
  consputc('x');
    800006ae:	07800513          	li	a0,120
    800006b2:	00000097          	auipc	ra,0x0
    800006b6:	bc4080e7          	jalr	-1084(ra) # 80000276 <consputc>
    800006ba:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    800006bc:	03c95793          	srli	a5,s2,0x3c
    800006c0:	97da                	add	a5,a5,s6
    800006c2:	0007c503          	lbu	a0,0(a5)
    800006c6:	00000097          	auipc	ra,0x0
    800006ca:	bb0080e7          	jalr	-1104(ra) # 80000276 <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    800006ce:	0912                	slli	s2,s2,0x4
    800006d0:	34fd                	addiw	s1,s1,-1
    800006d2:	f4ed                	bnez	s1,800006bc <printf+0x13a>
    800006d4:	b7a1                	j	8000061c <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    800006d6:	f8843783          	ld	a5,-120(s0)
    800006da:	00878713          	addi	a4,a5,8
    800006de:	f8e43423          	sd	a4,-120(s0)
    800006e2:	6384                	ld	s1,0(a5)
    800006e4:	cc89                	beqz	s1,800006fe <printf+0x17c>
      for(; *s; s++)
    800006e6:	0004c503          	lbu	a0,0(s1)
    800006ea:	d90d                	beqz	a0,8000061c <printf+0x9a>
        consputc(*s);
    800006ec:	00000097          	auipc	ra,0x0
    800006f0:	b8a080e7          	jalr	-1142(ra) # 80000276 <consputc>
      for(; *s; s++)
    800006f4:	0485                	addi	s1,s1,1
    800006f6:	0004c503          	lbu	a0,0(s1)
    800006fa:	f96d                	bnez	a0,800006ec <printf+0x16a>
    800006fc:	b705                	j	8000061c <printf+0x9a>
        s = "(null)";
    800006fe:	00008497          	auipc	s1,0x8
    80000702:	92248493          	addi	s1,s1,-1758 # 80008020 <etext+0x20>
      for(; *s; s++)
    80000706:	02800513          	li	a0,40
    8000070a:	b7cd                	j	800006ec <printf+0x16a>
      consputc('%');
    8000070c:	8556                	mv	a0,s5
    8000070e:	00000097          	auipc	ra,0x0
    80000712:	b68080e7          	jalr	-1176(ra) # 80000276 <consputc>
      break;
    80000716:	b719                	j	8000061c <printf+0x9a>
      consputc('%');
    80000718:	8556                	mv	a0,s5
    8000071a:	00000097          	auipc	ra,0x0
    8000071e:	b5c080e7          	jalr	-1188(ra) # 80000276 <consputc>
      consputc(c);
    80000722:	8526                	mv	a0,s1
    80000724:	00000097          	auipc	ra,0x0
    80000728:	b52080e7          	jalr	-1198(ra) # 80000276 <consputc>
      break;
    8000072c:	bdc5                	j	8000061c <printf+0x9a>
  if(locking)
    8000072e:	020d9163          	bnez	s11,80000750 <printf+0x1ce>
}
    80000732:	70e6                	ld	ra,120(sp)
    80000734:	7446                	ld	s0,112(sp)
    80000736:	74a6                	ld	s1,104(sp)
    80000738:	7906                	ld	s2,96(sp)
    8000073a:	69e6                	ld	s3,88(sp)
    8000073c:	6a46                	ld	s4,80(sp)
    8000073e:	6aa6                	ld	s5,72(sp)
    80000740:	6b06                	ld	s6,64(sp)
    80000742:	7be2                	ld	s7,56(sp)
    80000744:	7c42                	ld	s8,48(sp)
    80000746:	7ca2                	ld	s9,40(sp)
    80000748:	7d02                	ld	s10,32(sp)
    8000074a:	6de2                	ld	s11,24(sp)
    8000074c:	6129                	addi	sp,sp,192
    8000074e:	8082                	ret
    release(&pr.lock);
    80000750:	00011517          	auipc	a0,0x11
    80000754:	ad850513          	addi	a0,a0,-1320 # 80011228 <pr>
    80000758:	00000097          	auipc	ra,0x0
    8000075c:	52c080e7          	jalr	1324(ra) # 80000c84 <release>
}
    80000760:	bfc9                	j	80000732 <printf+0x1b0>

0000000080000762 <printfinit>:
    ;
}

void
printfinit(void)
{
    80000762:	1101                	addi	sp,sp,-32
    80000764:	ec06                	sd	ra,24(sp)
    80000766:	e822                	sd	s0,16(sp)
    80000768:	e426                	sd	s1,8(sp)
    8000076a:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    8000076c:	00011497          	auipc	s1,0x11
    80000770:	abc48493          	addi	s1,s1,-1348 # 80011228 <pr>
    80000774:	00008597          	auipc	a1,0x8
    80000778:	8c458593          	addi	a1,a1,-1852 # 80008038 <etext+0x38>
    8000077c:	8526                	mv	a0,s1
    8000077e:	00000097          	auipc	ra,0x0
    80000782:	3c2080e7          	jalr	962(ra) # 80000b40 <initlock>
  pr.locking = 1;
    80000786:	4785                	li	a5,1
    80000788:	cc9c                	sw	a5,24(s1)
}
    8000078a:	60e2                	ld	ra,24(sp)
    8000078c:	6442                	ld	s0,16(sp)
    8000078e:	64a2                	ld	s1,8(sp)
    80000790:	6105                	addi	sp,sp,32
    80000792:	8082                	ret

0000000080000794 <uartinit>:

void uartstart();

void
uartinit(void)
{
    80000794:	1141                	addi	sp,sp,-16
    80000796:	e406                	sd	ra,8(sp)
    80000798:	e022                	sd	s0,0(sp)
    8000079a:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    8000079c:	100007b7          	lui	a5,0x10000
    800007a0:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    800007a4:	f8000713          	li	a4,-128
    800007a8:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    800007ac:	470d                	li	a4,3
    800007ae:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    800007b2:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    800007b6:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    800007ba:	469d                	li	a3,7
    800007bc:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    800007c0:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    800007c4:	00008597          	auipc	a1,0x8
    800007c8:	89458593          	addi	a1,a1,-1900 # 80008058 <digits+0x18>
    800007cc:	00011517          	auipc	a0,0x11
    800007d0:	a7c50513          	addi	a0,a0,-1412 # 80011248 <uart_tx_lock>
    800007d4:	00000097          	auipc	ra,0x0
    800007d8:	36c080e7          	jalr	876(ra) # 80000b40 <initlock>
}
    800007dc:	60a2                	ld	ra,8(sp)
    800007de:	6402                	ld	s0,0(sp)
    800007e0:	0141                	addi	sp,sp,16
    800007e2:	8082                	ret

00000000800007e4 <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    800007e4:	1101                	addi	sp,sp,-32
    800007e6:	ec06                	sd	ra,24(sp)
    800007e8:	e822                	sd	s0,16(sp)
    800007ea:	e426                	sd	s1,8(sp)
    800007ec:	1000                	addi	s0,sp,32
    800007ee:	84aa                	mv	s1,a0
  push_off();
    800007f0:	00000097          	auipc	ra,0x0
    800007f4:	394080e7          	jalr	916(ra) # 80000b84 <push_off>

  if(panicked){
    800007f8:	00009797          	auipc	a5,0x9
    800007fc:	8087a783          	lw	a5,-2040(a5) # 80009000 <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000800:	10000737          	lui	a4,0x10000
  if(panicked){
    80000804:	c391                	beqz	a5,80000808 <uartputc_sync+0x24>
    for(;;)
    80000806:	a001                	j	80000806 <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80000808:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    8000080c:	0207f793          	andi	a5,a5,32
    80000810:	dfe5                	beqz	a5,80000808 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80000812:	0ff4f513          	zext.b	a0,s1
    80000816:	100007b7          	lui	a5,0x10000
    8000081a:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    8000081e:	00000097          	auipc	ra,0x0
    80000822:	406080e7          	jalr	1030(ra) # 80000c24 <pop_off>
}
    80000826:	60e2                	ld	ra,24(sp)
    80000828:	6442                	ld	s0,16(sp)
    8000082a:	64a2                	ld	s1,8(sp)
    8000082c:	6105                	addi	sp,sp,32
    8000082e:	8082                	ret

0000000080000830 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80000830:	00008797          	auipc	a5,0x8
    80000834:	7d87b783          	ld	a5,2008(a5) # 80009008 <uart_tx_r>
    80000838:	00008717          	auipc	a4,0x8
    8000083c:	7d873703          	ld	a4,2008(a4) # 80009010 <uart_tx_w>
    80000840:	06f70a63          	beq	a4,a5,800008b4 <uartstart+0x84>
{
    80000844:	7139                	addi	sp,sp,-64
    80000846:	fc06                	sd	ra,56(sp)
    80000848:	f822                	sd	s0,48(sp)
    8000084a:	f426                	sd	s1,40(sp)
    8000084c:	f04a                	sd	s2,32(sp)
    8000084e:	ec4e                	sd	s3,24(sp)
    80000850:	e852                	sd	s4,16(sp)
    80000852:	e456                	sd	s5,8(sp)
    80000854:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000856:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000085a:	00011a17          	auipc	s4,0x11
    8000085e:	9eea0a13          	addi	s4,s4,-1554 # 80011248 <uart_tx_lock>
    uart_tx_r += 1;
    80000862:	00008497          	auipc	s1,0x8
    80000866:	7a648493          	addi	s1,s1,1958 # 80009008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    8000086a:	00008997          	auipc	s3,0x8
    8000086e:	7a698993          	addi	s3,s3,1958 # 80009010 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80000872:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80000876:	02077713          	andi	a4,a4,32
    8000087a:	c705                	beqz	a4,800008a2 <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    8000087c:	01f7f713          	andi	a4,a5,31
    80000880:	9752                	add	a4,a4,s4
    80000882:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80000886:	0785                	addi	a5,a5,1
    80000888:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    8000088a:	8526                	mv	a0,s1
    8000088c:	00002097          	auipc	ra,0x2
    80000890:	a26080e7          	jalr	-1498(ra) # 800022b2 <wakeup>
    
    WriteReg(THR, c);
    80000894:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80000898:	609c                	ld	a5,0(s1)
    8000089a:	0009b703          	ld	a4,0(s3)
    8000089e:	fcf71ae3          	bne	a4,a5,80000872 <uartstart+0x42>
  }
}
    800008a2:	70e2                	ld	ra,56(sp)
    800008a4:	7442                	ld	s0,48(sp)
    800008a6:	74a2                	ld	s1,40(sp)
    800008a8:	7902                	ld	s2,32(sp)
    800008aa:	69e2                	ld	s3,24(sp)
    800008ac:	6a42                	ld	s4,16(sp)
    800008ae:	6aa2                	ld	s5,8(sp)
    800008b0:	6121                	addi	sp,sp,64
    800008b2:	8082                	ret
    800008b4:	8082                	ret

00000000800008b6 <uartputc>:
{
    800008b6:	7179                	addi	sp,sp,-48
    800008b8:	f406                	sd	ra,40(sp)
    800008ba:	f022                	sd	s0,32(sp)
    800008bc:	ec26                	sd	s1,24(sp)
    800008be:	e84a                	sd	s2,16(sp)
    800008c0:	e44e                	sd	s3,8(sp)
    800008c2:	e052                	sd	s4,0(sp)
    800008c4:	1800                	addi	s0,sp,48
    800008c6:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    800008c8:	00011517          	auipc	a0,0x11
    800008cc:	98050513          	addi	a0,a0,-1664 # 80011248 <uart_tx_lock>
    800008d0:	00000097          	auipc	ra,0x0
    800008d4:	300080e7          	jalr	768(ra) # 80000bd0 <acquire>
  if(panicked){
    800008d8:	00008797          	auipc	a5,0x8
    800008dc:	7287a783          	lw	a5,1832(a5) # 80009000 <panicked>
    800008e0:	c391                	beqz	a5,800008e4 <uartputc+0x2e>
    for(;;)
    800008e2:	a001                	j	800008e2 <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    800008e4:	00008717          	auipc	a4,0x8
    800008e8:	72c73703          	ld	a4,1836(a4) # 80009010 <uart_tx_w>
    800008ec:	00008797          	auipc	a5,0x8
    800008f0:	71c7b783          	ld	a5,1820(a5) # 80009008 <uart_tx_r>
    800008f4:	02078793          	addi	a5,a5,32
    800008f8:	02e79b63          	bne	a5,a4,8000092e <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    800008fc:	00011997          	auipc	s3,0x11
    80000900:	94c98993          	addi	s3,s3,-1716 # 80011248 <uart_tx_lock>
    80000904:	00008497          	auipc	s1,0x8
    80000908:	70448493          	addi	s1,s1,1796 # 80009008 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000090c:	00008917          	auipc	s2,0x8
    80000910:	70490913          	addi	s2,s2,1796 # 80009010 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    80000914:	85ce                	mv	a1,s3
    80000916:	8526                	mv	a0,s1
    80000918:	00002097          	auipc	ra,0x2
    8000091c:	80e080e7          	jalr	-2034(ra) # 80002126 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80000920:	00093703          	ld	a4,0(s2)
    80000924:	609c                	ld	a5,0(s1)
    80000926:	02078793          	addi	a5,a5,32
    8000092a:	fee785e3          	beq	a5,a4,80000914 <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    8000092e:	00011497          	auipc	s1,0x11
    80000932:	91a48493          	addi	s1,s1,-1766 # 80011248 <uart_tx_lock>
    80000936:	01f77793          	andi	a5,a4,31
    8000093a:	97a6                	add	a5,a5,s1
    8000093c:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80000940:	0705                	addi	a4,a4,1
    80000942:	00008797          	auipc	a5,0x8
    80000946:	6ce7b723          	sd	a4,1742(a5) # 80009010 <uart_tx_w>
      uartstart();
    8000094a:	00000097          	auipc	ra,0x0
    8000094e:	ee6080e7          	jalr	-282(ra) # 80000830 <uartstart>
      release(&uart_tx_lock);
    80000952:	8526                	mv	a0,s1
    80000954:	00000097          	auipc	ra,0x0
    80000958:	330080e7          	jalr	816(ra) # 80000c84 <release>
}
    8000095c:	70a2                	ld	ra,40(sp)
    8000095e:	7402                	ld	s0,32(sp)
    80000960:	64e2                	ld	s1,24(sp)
    80000962:	6942                	ld	s2,16(sp)
    80000964:	69a2                	ld	s3,8(sp)
    80000966:	6a02                	ld	s4,0(sp)
    80000968:	6145                	addi	sp,sp,48
    8000096a:	8082                	ret

000000008000096c <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    8000096c:	1141                	addi	sp,sp,-16
    8000096e:	e422                	sd	s0,8(sp)
    80000970:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    80000972:	100007b7          	lui	a5,0x10000
    80000976:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    8000097a:	8b85                	andi	a5,a5,1
    8000097c:	cb91                	beqz	a5,80000990 <uartgetc+0x24>
    // input data is ready.
    return ReadReg(RHR);
    8000097e:	100007b7          	lui	a5,0x10000
    80000982:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
    80000986:	0ff57513          	zext.b	a0,a0
  } else {
    return -1;
  }
}
    8000098a:	6422                	ld	s0,8(sp)
    8000098c:	0141                	addi	sp,sp,16
    8000098e:	8082                	ret
    return -1;
    80000990:	557d                	li	a0,-1
    80000992:	bfe5                	j	8000098a <uartgetc+0x1e>

0000000080000994 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    80000994:	1101                	addi	sp,sp,-32
    80000996:	ec06                	sd	ra,24(sp)
    80000998:	e822                	sd	s0,16(sp)
    8000099a:	e426                	sd	s1,8(sp)
    8000099c:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    8000099e:	54fd                	li	s1,-1
    800009a0:	a029                	j	800009aa <uartintr+0x16>
      break;
    consoleintr(c);
    800009a2:	00000097          	auipc	ra,0x0
    800009a6:	916080e7          	jalr	-1770(ra) # 800002b8 <consoleintr>
    int c = uartgetc();
    800009aa:	00000097          	auipc	ra,0x0
    800009ae:	fc2080e7          	jalr	-62(ra) # 8000096c <uartgetc>
    if(c == -1)
    800009b2:	fe9518e3          	bne	a0,s1,800009a2 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800009b6:	00011497          	auipc	s1,0x11
    800009ba:	89248493          	addi	s1,s1,-1902 # 80011248 <uart_tx_lock>
    800009be:	8526                	mv	a0,s1
    800009c0:	00000097          	auipc	ra,0x0
    800009c4:	210080e7          	jalr	528(ra) # 80000bd0 <acquire>
  uartstart();
    800009c8:	00000097          	auipc	ra,0x0
    800009cc:	e68080e7          	jalr	-408(ra) # 80000830 <uartstart>
  release(&uart_tx_lock);
    800009d0:	8526                	mv	a0,s1
    800009d2:	00000097          	auipc	ra,0x0
    800009d6:	2b2080e7          	jalr	690(ra) # 80000c84 <release>
}
    800009da:	60e2                	ld	ra,24(sp)
    800009dc:	6442                	ld	s0,16(sp)
    800009de:	64a2                	ld	s1,8(sp)
    800009e0:	6105                	addi	sp,sp,32
    800009e2:	8082                	ret

00000000800009e4 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    800009e4:	1101                	addi	sp,sp,-32
    800009e6:	ec06                	sd	ra,24(sp)
    800009e8:	e822                	sd	s0,16(sp)
    800009ea:	e426                	sd	s1,8(sp)
    800009ec:	e04a                	sd	s2,0(sp)
    800009ee:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    800009f0:	03451793          	slli	a5,a0,0x34
    800009f4:	ebb9                	bnez	a5,80000a4a <kfree+0x66>
    800009f6:	84aa                	mv	s1,a0
    800009f8:	00026797          	auipc	a5,0x26
    800009fc:	c6078793          	addi	a5,a5,-928 # 80026658 <end>
    80000a00:	04f56563          	bltu	a0,a5,80000a4a <kfree+0x66>
    80000a04:	47c5                	li	a5,17
    80000a06:	07ee                	slli	a5,a5,0x1b
    80000a08:	04f57163          	bgeu	a0,a5,80000a4a <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000a0c:	6605                	lui	a2,0x1
    80000a0e:	4585                	li	a1,1
    80000a10:	00000097          	auipc	ra,0x0
    80000a14:	2bc080e7          	jalr	700(ra) # 80000ccc <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000a18:	00011917          	auipc	s2,0x11
    80000a1c:	86890913          	addi	s2,s2,-1944 # 80011280 <kmem>
    80000a20:	854a                	mv	a0,s2
    80000a22:	00000097          	auipc	ra,0x0
    80000a26:	1ae080e7          	jalr	430(ra) # 80000bd0 <acquire>
  r->next = kmem.freelist;
    80000a2a:	01893783          	ld	a5,24(s2)
    80000a2e:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000a30:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    80000a34:	854a                	mv	a0,s2
    80000a36:	00000097          	auipc	ra,0x0
    80000a3a:	24e080e7          	jalr	590(ra) # 80000c84 <release>
}
    80000a3e:	60e2                	ld	ra,24(sp)
    80000a40:	6442                	ld	s0,16(sp)
    80000a42:	64a2                	ld	s1,8(sp)
    80000a44:	6902                	ld	s2,0(sp)
    80000a46:	6105                	addi	sp,sp,32
    80000a48:	8082                	ret
    panic("kfree");
    80000a4a:	00007517          	auipc	a0,0x7
    80000a4e:	61650513          	addi	a0,a0,1558 # 80008060 <digits+0x20>
    80000a52:	00000097          	auipc	ra,0x0
    80000a56:	ae6080e7          	jalr	-1306(ra) # 80000538 <panic>

0000000080000a5a <freerange>:
{
    80000a5a:	7179                	addi	sp,sp,-48
    80000a5c:	f406                	sd	ra,40(sp)
    80000a5e:	f022                	sd	s0,32(sp)
    80000a60:	ec26                	sd	s1,24(sp)
    80000a62:	e84a                	sd	s2,16(sp)
    80000a64:	e44e                	sd	s3,8(sp)
    80000a66:	e052                	sd	s4,0(sp)
    80000a68:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    80000a6a:	6785                	lui	a5,0x1
    80000a6c:	fff78493          	addi	s1,a5,-1 # fff <_entry-0x7ffff001>
    80000a70:	94aa                	add	s1,s1,a0
    80000a72:	757d                	lui	a0,0xfffff
    80000a74:	8ce9                	and	s1,s1,a0
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a76:	94be                	add	s1,s1,a5
    80000a78:	0095ee63          	bltu	a1,s1,80000a94 <freerange+0x3a>
    80000a7c:	892e                	mv	s2,a1
    kfree(p);
    80000a7e:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a80:	6985                	lui	s3,0x1
    kfree(p);
    80000a82:	01448533          	add	a0,s1,s4
    80000a86:	00000097          	auipc	ra,0x0
    80000a8a:	f5e080e7          	jalr	-162(ra) # 800009e4 <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    80000a8e:	94ce                	add	s1,s1,s3
    80000a90:	fe9979e3          	bgeu	s2,s1,80000a82 <freerange+0x28>
}
    80000a94:	70a2                	ld	ra,40(sp)
    80000a96:	7402                	ld	s0,32(sp)
    80000a98:	64e2                	ld	s1,24(sp)
    80000a9a:	6942                	ld	s2,16(sp)
    80000a9c:	69a2                	ld	s3,8(sp)
    80000a9e:	6a02                	ld	s4,0(sp)
    80000aa0:	6145                	addi	sp,sp,48
    80000aa2:	8082                	ret

0000000080000aa4 <kinit>:
{
    80000aa4:	1141                	addi	sp,sp,-16
    80000aa6:	e406                	sd	ra,8(sp)
    80000aa8:	e022                	sd	s0,0(sp)
    80000aaa:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    80000aac:	00007597          	auipc	a1,0x7
    80000ab0:	5bc58593          	addi	a1,a1,1468 # 80008068 <digits+0x28>
    80000ab4:	00010517          	auipc	a0,0x10
    80000ab8:	7cc50513          	addi	a0,a0,1996 # 80011280 <kmem>
    80000abc:	00000097          	auipc	ra,0x0
    80000ac0:	084080e7          	jalr	132(ra) # 80000b40 <initlock>
  freerange(end, (void*)PHYSTOP);
    80000ac4:	45c5                	li	a1,17
    80000ac6:	05ee                	slli	a1,a1,0x1b
    80000ac8:	00026517          	auipc	a0,0x26
    80000acc:	b9050513          	addi	a0,a0,-1136 # 80026658 <end>
    80000ad0:	00000097          	auipc	ra,0x0
    80000ad4:	f8a080e7          	jalr	-118(ra) # 80000a5a <freerange>
}
    80000ad8:	60a2                	ld	ra,8(sp)
    80000ada:	6402                	ld	s0,0(sp)
    80000adc:	0141                	addi	sp,sp,16
    80000ade:	8082                	ret

0000000080000ae0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    80000ae0:	1101                	addi	sp,sp,-32
    80000ae2:	ec06                	sd	ra,24(sp)
    80000ae4:	e822                	sd	s0,16(sp)
    80000ae6:	e426                	sd	s1,8(sp)
    80000ae8:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000aea:	00010497          	auipc	s1,0x10
    80000aee:	79648493          	addi	s1,s1,1942 # 80011280 <kmem>
    80000af2:	8526                	mv	a0,s1
    80000af4:	00000097          	auipc	ra,0x0
    80000af8:	0dc080e7          	jalr	220(ra) # 80000bd0 <acquire>
  r = kmem.freelist;
    80000afc:	6c84                	ld	s1,24(s1)
  if(r)
    80000afe:	c885                	beqz	s1,80000b2e <kalloc+0x4e>
    kmem.freelist = r->next;
    80000b00:	609c                	ld	a5,0(s1)
    80000b02:	00010517          	auipc	a0,0x10
    80000b06:	77e50513          	addi	a0,a0,1918 # 80011280 <kmem>
    80000b0a:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000b0c:	00000097          	auipc	ra,0x0
    80000b10:	178080e7          	jalr	376(ra) # 80000c84 <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    80000b14:	6605                	lui	a2,0x1
    80000b16:	4595                	li	a1,5
    80000b18:	8526                	mv	a0,s1
    80000b1a:	00000097          	auipc	ra,0x0
    80000b1e:	1b2080e7          	jalr	434(ra) # 80000ccc <memset>
  return (void*)r;
}
    80000b22:	8526                	mv	a0,s1
    80000b24:	60e2                	ld	ra,24(sp)
    80000b26:	6442                	ld	s0,16(sp)
    80000b28:	64a2                	ld	s1,8(sp)
    80000b2a:	6105                	addi	sp,sp,32
    80000b2c:	8082                	ret
  release(&kmem.lock);
    80000b2e:	00010517          	auipc	a0,0x10
    80000b32:	75250513          	addi	a0,a0,1874 # 80011280 <kmem>
    80000b36:	00000097          	auipc	ra,0x0
    80000b3a:	14e080e7          	jalr	334(ra) # 80000c84 <release>
  if(r)
    80000b3e:	b7d5                	j	80000b22 <kalloc+0x42>

0000000080000b40 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80000b40:	1141                	addi	sp,sp,-16
    80000b42:	e422                	sd	s0,8(sp)
    80000b44:	0800                	addi	s0,sp,16
  lk->name = name;
    80000b46:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80000b48:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80000b4c:	00053823          	sd	zero,16(a0)
}
    80000b50:	6422                	ld	s0,8(sp)
    80000b52:	0141                	addi	sp,sp,16
    80000b54:	8082                	ret

0000000080000b56 <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    80000b56:	411c                	lw	a5,0(a0)
    80000b58:	e399                	bnez	a5,80000b5e <holding+0x8>
    80000b5a:	4501                	li	a0,0
  return r;
}
    80000b5c:	8082                	ret
{
    80000b5e:	1101                	addi	sp,sp,-32
    80000b60:	ec06                	sd	ra,24(sp)
    80000b62:	e822                	sd	s0,16(sp)
    80000b64:	e426                	sd	s1,8(sp)
    80000b66:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80000b68:	6904                	ld	s1,16(a0)
    80000b6a:	00001097          	auipc	ra,0x1
    80000b6e:	ee0080e7          	jalr	-288(ra) # 80001a4a <mycpu>
    80000b72:	40a48533          	sub	a0,s1,a0
    80000b76:	00153513          	seqz	a0,a0
}
    80000b7a:	60e2                	ld	ra,24(sp)
    80000b7c:	6442                	ld	s0,16(sp)
    80000b7e:	64a2                	ld	s1,8(sp)
    80000b80:	6105                	addi	sp,sp,32
    80000b82:	8082                	ret

0000000080000b84 <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    80000b84:	1101                	addi	sp,sp,-32
    80000b86:	ec06                	sd	ra,24(sp)
    80000b88:	e822                	sd	s0,16(sp)
    80000b8a:	e426                	sd	s1,8(sp)
    80000b8c:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000b8e:	100024f3          	csrr	s1,sstatus
    80000b92:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80000b96:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000b98:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80000b9c:	00001097          	auipc	ra,0x1
    80000ba0:	eae080e7          	jalr	-338(ra) # 80001a4a <mycpu>
    80000ba4:	5d3c                	lw	a5,120(a0)
    80000ba6:	cf89                	beqz	a5,80000bc0 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80000ba8:	00001097          	auipc	ra,0x1
    80000bac:	ea2080e7          	jalr	-350(ra) # 80001a4a <mycpu>
    80000bb0:	5d3c                	lw	a5,120(a0)
    80000bb2:	2785                	addiw	a5,a5,1
    80000bb4:	dd3c                	sw	a5,120(a0)
}
    80000bb6:	60e2                	ld	ra,24(sp)
    80000bb8:	6442                	ld	s0,16(sp)
    80000bba:	64a2                	ld	s1,8(sp)
    80000bbc:	6105                	addi	sp,sp,32
    80000bbe:	8082                	ret
    mycpu()->intena = old;
    80000bc0:	00001097          	auipc	ra,0x1
    80000bc4:	e8a080e7          	jalr	-374(ra) # 80001a4a <mycpu>
  return (x & SSTATUS_SIE) != 0;
    80000bc8:	8085                	srli	s1,s1,0x1
    80000bca:	8885                	andi	s1,s1,1
    80000bcc:	dd64                	sw	s1,124(a0)
    80000bce:	bfe9                	j	80000ba8 <push_off+0x24>

0000000080000bd0 <acquire>:
{
    80000bd0:	1101                	addi	sp,sp,-32
    80000bd2:	ec06                	sd	ra,24(sp)
    80000bd4:	e822                	sd	s0,16(sp)
    80000bd6:	e426                	sd	s1,8(sp)
    80000bd8:	1000                	addi	s0,sp,32
    80000bda:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    80000bdc:	00000097          	auipc	ra,0x0
    80000be0:	fa8080e7          	jalr	-88(ra) # 80000b84 <push_off>
  if(holding(lk))
    80000be4:	8526                	mv	a0,s1
    80000be6:	00000097          	auipc	ra,0x0
    80000bea:	f70080e7          	jalr	-144(ra) # 80000b56 <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bee:	4705                	li	a4,1
  if(holding(lk))
    80000bf0:	e115                	bnez	a0,80000c14 <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    80000bf2:	87ba                	mv	a5,a4
    80000bf4:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    80000bf8:	2781                	sext.w	a5,a5
    80000bfa:	ffe5                	bnez	a5,80000bf2 <acquire+0x22>
  __sync_synchronize();
    80000bfc:	0ff0000f          	fence
  lk->cpu = mycpu();
    80000c00:	00001097          	auipc	ra,0x1
    80000c04:	e4a080e7          	jalr	-438(ra) # 80001a4a <mycpu>
    80000c08:	e888                	sd	a0,16(s1)
}
    80000c0a:	60e2                	ld	ra,24(sp)
    80000c0c:	6442                	ld	s0,16(sp)
    80000c0e:	64a2                	ld	s1,8(sp)
    80000c10:	6105                	addi	sp,sp,32
    80000c12:	8082                	ret
    panic("acquire");
    80000c14:	00007517          	auipc	a0,0x7
    80000c18:	45c50513          	addi	a0,a0,1116 # 80008070 <digits+0x30>
    80000c1c:	00000097          	auipc	ra,0x0
    80000c20:	91c080e7          	jalr	-1764(ra) # 80000538 <panic>

0000000080000c24 <pop_off>:

void
pop_off(void)
{
    80000c24:	1141                	addi	sp,sp,-16
    80000c26:	e406                	sd	ra,8(sp)
    80000c28:	e022                	sd	s0,0(sp)
    80000c2a:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80000c2c:	00001097          	auipc	ra,0x1
    80000c30:	e1e080e7          	jalr	-482(ra) # 80001a4a <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c34:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80000c38:	8b89                	andi	a5,a5,2
  if(intr_get())
    80000c3a:	e78d                	bnez	a5,80000c64 <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80000c3c:	5d3c                	lw	a5,120(a0)
    80000c3e:	02f05b63          	blez	a5,80000c74 <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    80000c42:	37fd                	addiw	a5,a5,-1
    80000c44:	0007871b          	sext.w	a4,a5
    80000c48:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80000c4a:	eb09                	bnez	a4,80000c5c <pop_off+0x38>
    80000c4c:	5d7c                	lw	a5,124(a0)
    80000c4e:	c799                	beqz	a5,80000c5c <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80000c50:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80000c54:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80000c58:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80000c5c:	60a2                	ld	ra,8(sp)
    80000c5e:	6402                	ld	s0,0(sp)
    80000c60:	0141                	addi	sp,sp,16
    80000c62:	8082                	ret
    panic("pop_off - interruptible");
    80000c64:	00007517          	auipc	a0,0x7
    80000c68:	41450513          	addi	a0,a0,1044 # 80008078 <digits+0x38>
    80000c6c:	00000097          	auipc	ra,0x0
    80000c70:	8cc080e7          	jalr	-1844(ra) # 80000538 <panic>
    panic("pop_off");
    80000c74:	00007517          	auipc	a0,0x7
    80000c78:	41c50513          	addi	a0,a0,1052 # 80008090 <digits+0x50>
    80000c7c:	00000097          	auipc	ra,0x0
    80000c80:	8bc080e7          	jalr	-1860(ra) # 80000538 <panic>

0000000080000c84 <release>:
{
    80000c84:	1101                	addi	sp,sp,-32
    80000c86:	ec06                	sd	ra,24(sp)
    80000c88:	e822                	sd	s0,16(sp)
    80000c8a:	e426                	sd	s1,8(sp)
    80000c8c:	1000                	addi	s0,sp,32
    80000c8e:	84aa                	mv	s1,a0
  if(!holding(lk))
    80000c90:	00000097          	auipc	ra,0x0
    80000c94:	ec6080e7          	jalr	-314(ra) # 80000b56 <holding>
    80000c98:	c115                	beqz	a0,80000cbc <release+0x38>
  lk->cpu = 0;
    80000c9a:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80000c9e:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    80000ca2:	0f50000f          	fence	iorw,ow
    80000ca6:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80000caa:	00000097          	auipc	ra,0x0
    80000cae:	f7a080e7          	jalr	-134(ra) # 80000c24 <pop_off>
}
    80000cb2:	60e2                	ld	ra,24(sp)
    80000cb4:	6442                	ld	s0,16(sp)
    80000cb6:	64a2                	ld	s1,8(sp)
    80000cb8:	6105                	addi	sp,sp,32
    80000cba:	8082                	ret
    panic("release");
    80000cbc:	00007517          	auipc	a0,0x7
    80000cc0:	3dc50513          	addi	a0,a0,988 # 80008098 <digits+0x58>
    80000cc4:	00000097          	auipc	ra,0x0
    80000cc8:	874080e7          	jalr	-1932(ra) # 80000538 <panic>

0000000080000ccc <memset>:
#include "types.h"


void*
memset(void *dst, int c, uint n)
{
    80000ccc:	1141                	addi	sp,sp,-16
    80000cce:	e422                	sd	s0,8(sp)
    80000cd0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000cd2:	ca19                	beqz	a2,80000ce8 <memset+0x1c>
    80000cd4:	87aa                	mv	a5,a0
    80000cd6:	1602                	slli	a2,a2,0x20
    80000cd8:	9201                	srli	a2,a2,0x20
    80000cda:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    80000cde:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000ce2:	0785                	addi	a5,a5,1
    80000ce4:	fee79de3          	bne	a5,a4,80000cde <memset+0x12>
  }
  return dst;
}
    80000ce8:	6422                	ld	s0,8(sp)
    80000cea:	0141                	addi	sp,sp,16
    80000cec:	8082                	ret

0000000080000cee <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    80000cee:	1141                	addi	sp,sp,-16
    80000cf0:	e422                	sd	s0,8(sp)
    80000cf2:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    80000cf4:	ca05                	beqz	a2,80000d24 <memcmp+0x36>
    80000cf6:	fff6069b          	addiw	a3,a2,-1
    80000cfa:	1682                	slli	a3,a3,0x20
    80000cfc:	9281                	srli	a3,a3,0x20
    80000cfe:	0685                	addi	a3,a3,1
    80000d00:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    80000d02:	00054783          	lbu	a5,0(a0)
    80000d06:	0005c703          	lbu	a4,0(a1)
    80000d0a:	00e79863          	bne	a5,a4,80000d1a <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    80000d0e:	0505                	addi	a0,a0,1
    80000d10:	0585                	addi	a1,a1,1
  while(n-- > 0){
    80000d12:	fed518e3          	bne	a0,a3,80000d02 <memcmp+0x14>
  }

  return 0;
    80000d16:	4501                	li	a0,0
    80000d18:	a019                	j	80000d1e <memcmp+0x30>
      return *s1 - *s2;
    80000d1a:	40e7853b          	subw	a0,a5,a4
}
    80000d1e:	6422                	ld	s0,8(sp)
    80000d20:	0141                	addi	sp,sp,16
    80000d22:	8082                	ret
  return 0;
    80000d24:	4501                	li	a0,0
    80000d26:	bfe5                	j	80000d1e <memcmp+0x30>

0000000080000d28 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    80000d28:	1141                	addi	sp,sp,-16
    80000d2a:	e422                	sd	s0,8(sp)
    80000d2c:	0800                	addi	s0,sp,16
  char *d;

  s = src;
  d = dst;
  
  if(s < d && s + n > d){
    80000d2e:	02a5e563          	bltu	a1,a0,80000d58 <memmove+0x30>
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
    80000d32:	fff6069b          	addiw	a3,a2,-1
    80000d36:	ce11                	beqz	a2,80000d52 <memmove+0x2a>
    80000d38:	1682                	slli	a3,a3,0x20
    80000d3a:	9281                	srli	a3,a3,0x20
    80000d3c:	0685                	addi	a3,a3,1
    80000d3e:	96ae                	add	a3,a3,a1
    80000d40:	87aa                	mv	a5,a0
      *d++ = *s++;
    80000d42:	0585                	addi	a1,a1,1
    80000d44:	0785                	addi	a5,a5,1
    80000d46:	fff5c703          	lbu	a4,-1(a1)
    80000d4a:	fee78fa3          	sb	a4,-1(a5)
    while(n-- > 0)
    80000d4e:	fed59ae3          	bne	a1,a3,80000d42 <memmove+0x1a>

  return dst;
}
    80000d52:	6422                	ld	s0,8(sp)
    80000d54:	0141                	addi	sp,sp,16
    80000d56:	8082                	ret
  if(s < d && s + n > d){
    80000d58:	02061713          	slli	a4,a2,0x20
    80000d5c:	9301                	srli	a4,a4,0x20
    80000d5e:	00e587b3          	add	a5,a1,a4
    80000d62:	fcf578e3          	bgeu	a0,a5,80000d32 <memmove+0xa>
    d += n;
    80000d66:	972a                	add	a4,a4,a0
    while(n-- > 0)
    80000d68:	fff6069b          	addiw	a3,a2,-1
    80000d6c:	d27d                	beqz	a2,80000d52 <memmove+0x2a>
    80000d6e:	02069613          	slli	a2,a3,0x20
    80000d72:	9201                	srli	a2,a2,0x20
    80000d74:	fff64613          	not	a2,a2
    80000d78:	963e                	add	a2,a2,a5
      *--d = *--s;
    80000d7a:	17fd                	addi	a5,a5,-1
    80000d7c:	177d                	addi	a4,a4,-1
    80000d7e:	0007c683          	lbu	a3,0(a5)
    80000d82:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    80000d86:	fef61ae3          	bne	a2,a5,80000d7a <memmove+0x52>
    80000d8a:	b7e1                	j	80000d52 <memmove+0x2a>

0000000080000d8c <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000d8c:	1141                	addi	sp,sp,-16
    80000d8e:	e406                	sd	ra,8(sp)
    80000d90:	e022                	sd	s0,0(sp)
    80000d92:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    80000d94:	00000097          	auipc	ra,0x0
    80000d98:	f94080e7          	jalr	-108(ra) # 80000d28 <memmove>
}
    80000d9c:	60a2                	ld	ra,8(sp)
    80000d9e:	6402                	ld	s0,0(sp)
    80000da0:	0141                	addi	sp,sp,16
    80000da2:	8082                	ret

0000000080000da4 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    80000da4:	1141                	addi	sp,sp,-16
    80000da6:	e422                	sd	s0,8(sp)
    80000da8:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000daa:	ce11                	beqz	a2,80000dc6 <strncmp+0x22>
    80000dac:	00054783          	lbu	a5,0(a0)
    80000db0:	cf89                	beqz	a5,80000dca <strncmp+0x26>
    80000db2:	0005c703          	lbu	a4,0(a1)
    80000db6:	00f71a63          	bne	a4,a5,80000dca <strncmp+0x26>
    n--, p++, q++;
    80000dba:	367d                	addiw	a2,a2,-1
    80000dbc:	0505                	addi	a0,a0,1
    80000dbe:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000dc0:	f675                	bnez	a2,80000dac <strncmp+0x8>
  if(n == 0)
    return 0;
    80000dc2:	4501                	li	a0,0
    80000dc4:	a809                	j	80000dd6 <strncmp+0x32>
    80000dc6:	4501                	li	a0,0
    80000dc8:	a039                	j	80000dd6 <strncmp+0x32>
  if(n == 0)
    80000dca:	ca09                	beqz	a2,80000ddc <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000dcc:	00054503          	lbu	a0,0(a0)
    80000dd0:	0005c783          	lbu	a5,0(a1)
    80000dd4:	9d1d                	subw	a0,a0,a5
}
    80000dd6:	6422                	ld	s0,8(sp)
    80000dd8:	0141                	addi	sp,sp,16
    80000dda:	8082                	ret
    return 0;
    80000ddc:	4501                	li	a0,0
    80000dde:	bfe5                	j	80000dd6 <strncmp+0x32>

0000000080000de0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000de0:	1141                	addi	sp,sp,-16
    80000de2:	e422                	sd	s0,8(sp)
    80000de4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    80000de6:	872a                	mv	a4,a0
    80000de8:	8832                	mv	a6,a2
    80000dea:	367d                	addiw	a2,a2,-1
    80000dec:	01005963          	blez	a6,80000dfe <strncpy+0x1e>
    80000df0:	0705                	addi	a4,a4,1
    80000df2:	0005c783          	lbu	a5,0(a1)
    80000df6:	fef70fa3          	sb	a5,-1(a4)
    80000dfa:	0585                	addi	a1,a1,1
    80000dfc:	f7f5                	bnez	a5,80000de8 <strncpy+0x8>
    ;
  while(n-- > 0)
    80000dfe:	86ba                	mv	a3,a4
    80000e00:	00c05c63          	blez	a2,80000e18 <strncpy+0x38>
    *s++ = 0;
    80000e04:	0685                	addi	a3,a3,1
    80000e06:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    80000e0a:	fff6c793          	not	a5,a3
    80000e0e:	9fb9                	addw	a5,a5,a4
    80000e10:	010787bb          	addw	a5,a5,a6
    80000e14:	fef048e3          	bgtz	a5,80000e04 <strncpy+0x24>
  return os;
}
    80000e18:	6422                	ld	s0,8(sp)
    80000e1a:	0141                	addi	sp,sp,16
    80000e1c:	8082                	ret

0000000080000e1e <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    80000e1e:	1141                	addi	sp,sp,-16
    80000e20:	e422                	sd	s0,8(sp)
    80000e22:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    80000e24:	02c05363          	blez	a2,80000e4a <safestrcpy+0x2c>
    80000e28:	fff6069b          	addiw	a3,a2,-1
    80000e2c:	1682                	slli	a3,a3,0x20
    80000e2e:	9281                	srli	a3,a3,0x20
    80000e30:	96ae                	add	a3,a3,a1
    80000e32:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    80000e34:	00d58963          	beq	a1,a3,80000e46 <safestrcpy+0x28>
    80000e38:	0585                	addi	a1,a1,1
    80000e3a:	0785                	addi	a5,a5,1
    80000e3c:	fff5c703          	lbu	a4,-1(a1)
    80000e40:	fee78fa3          	sb	a4,-1(a5)
    80000e44:	fb65                	bnez	a4,80000e34 <safestrcpy+0x16>
    ;
  *s = 0;
    80000e46:	00078023          	sb	zero,0(a5)
  return os;
}
    80000e4a:	6422                	ld	s0,8(sp)
    80000e4c:	0141                	addi	sp,sp,16
    80000e4e:	8082                	ret

0000000080000e50 <strlen>:

int
strlen(const char *s)
{
    80000e50:	1141                	addi	sp,sp,-16
    80000e52:	e422                	sd	s0,8(sp)
    80000e54:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    80000e56:	00054783          	lbu	a5,0(a0)
    80000e5a:	cf91                	beqz	a5,80000e76 <strlen+0x26>
    80000e5c:	0505                	addi	a0,a0,1
    80000e5e:	87aa                	mv	a5,a0
    80000e60:	4685                	li	a3,1
    80000e62:	9e89                	subw	a3,a3,a0
    80000e64:	00f6853b          	addw	a0,a3,a5
    80000e68:	0785                	addi	a5,a5,1
    80000e6a:	fff7c703          	lbu	a4,-1(a5)
    80000e6e:	fb7d                	bnez	a4,80000e64 <strlen+0x14>
    ;
  return n;
}
    80000e70:	6422                	ld	s0,8(sp)
    80000e72:	0141                	addi	sp,sp,16
    80000e74:	8082                	ret
  for(n = 0; s[n]; n++)
    80000e76:	4501                	li	a0,0
    80000e78:	bfe5                	j	80000e70 <strlen+0x20>

0000000080000e7a <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000e7a:	1141                	addi	sp,sp,-16
    80000e7c:	e406                	sd	ra,8(sp)
    80000e7e:	e022                	sd	s0,0(sp)
    80000e80:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000e82:	00001097          	auipc	ra,0x1
    80000e86:	bb8080e7          	jalr	-1096(ra) # 80001a3a <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000e8a:	00008717          	auipc	a4,0x8
    80000e8e:	18e70713          	addi	a4,a4,398 # 80009018 <started>
  if(cpuid() == 0){
    80000e92:	c139                	beqz	a0,80000ed8 <main+0x5e>
    while(started == 0)
    80000e94:	431c                	lw	a5,0(a4)
    80000e96:	2781                	sext.w	a5,a5
    80000e98:	dff5                	beqz	a5,80000e94 <main+0x1a>
      ;
    __sync_synchronize();
    80000e9a:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000e9e:	00001097          	auipc	ra,0x1
    80000ea2:	b9c080e7          	jalr	-1124(ra) # 80001a3a <cpuid>
    80000ea6:	85aa                	mv	a1,a0
    80000ea8:	00007517          	auipc	a0,0x7
    80000eac:	21050513          	addi	a0,a0,528 # 800080b8 <digits+0x78>
    80000eb0:	fffff097          	auipc	ra,0xfffff
    80000eb4:	6d2080e7          	jalr	1746(ra) # 80000582 <printf>
    kvminithart();    // turn on paging
    80000eb8:	00000097          	auipc	ra,0x0
    80000ebc:	0d8080e7          	jalr	216(ra) # 80000f90 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000ec0:	00001097          	auipc	ra,0x1
    80000ec4:	7f8080e7          	jalr	2040(ra) # 800026b8 <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    80000ec8:	00005097          	auipc	ra,0x5
    80000ecc:	f14080e7          	jalr	-236(ra) # 80005ddc <plicinithart>
  }

  scheduler();        
    80000ed0:	00001097          	auipc	ra,0x1
    80000ed4:	0a4080e7          	jalr	164(ra) # 80001f74 <scheduler>
    consoleinit();
    80000ed8:	fffff097          	auipc	ra,0xfffff
    80000edc:	572080e7          	jalr	1394(ra) # 8000044a <consoleinit>
    printfinit();
    80000ee0:	00000097          	auipc	ra,0x0
    80000ee4:	882080e7          	jalr	-1918(ra) # 80000762 <printfinit>
    printf("\n");
    80000ee8:	00008517          	auipc	a0,0x8
    80000eec:	9b850513          	addi	a0,a0,-1608 # 800088a0 <syscalls+0x470>
    80000ef0:	fffff097          	auipc	ra,0xfffff
    80000ef4:	692080e7          	jalr	1682(ra) # 80000582 <printf>
    printf("xv6 kernel is booting\n");
    80000ef8:	00007517          	auipc	a0,0x7
    80000efc:	1a850513          	addi	a0,a0,424 # 800080a0 <digits+0x60>
    80000f00:	fffff097          	auipc	ra,0xfffff
    80000f04:	682080e7          	jalr	1666(ra) # 80000582 <printf>
    printf("\n");
    80000f08:	00008517          	auipc	a0,0x8
    80000f0c:	99850513          	addi	a0,a0,-1640 # 800088a0 <syscalls+0x470>
    80000f10:	fffff097          	auipc	ra,0xfffff
    80000f14:	672080e7          	jalr	1650(ra) # 80000582 <printf>
    kinit();         // physical page allocator
    80000f18:	00000097          	auipc	ra,0x0
    80000f1c:	b8c080e7          	jalr	-1140(ra) # 80000aa4 <kinit>
    kvminit();       // create kernel page table
    80000f20:	00000097          	auipc	ra,0x0
    80000f24:	310080e7          	jalr	784(ra) # 80001230 <kvminit>
    kvminithart();   // turn on paging
    80000f28:	00000097          	auipc	ra,0x0
    80000f2c:	068080e7          	jalr	104(ra) # 80000f90 <kvminithart>
    procinit();      // process table
    80000f30:	00001097          	auipc	ra,0x1
    80000f34:	a5a080e7          	jalr	-1446(ra) # 8000198a <procinit>
    trapinit();      // trap vectors
    80000f38:	00001097          	auipc	ra,0x1
    80000f3c:	758080e7          	jalr	1880(ra) # 80002690 <trapinit>
    trapinithart();  // install kernel trap vector
    80000f40:	00001097          	auipc	ra,0x1
    80000f44:	778080e7          	jalr	1912(ra) # 800026b8 <trapinithart>
    plicinit();      // set up interrupt controller
    80000f48:	00005097          	auipc	ra,0x5
    80000f4c:	e7e080e7          	jalr	-386(ra) # 80005dc6 <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    80000f50:	00005097          	auipc	ra,0x5
    80000f54:	e8c080e7          	jalr	-372(ra) # 80005ddc <plicinithart>
    binit();         // buffer cache
    80000f58:	00002097          	auipc	ra,0x2
    80000f5c:	ea0080e7          	jalr	-352(ra) # 80002df8 <binit>
    iinit();         // inode cache
    80000f60:	00002097          	auipc	ra,0x2
    80000f64:	532080e7          	jalr	1330(ra) # 80003492 <iinit>
    fileinit();      // file table
    80000f68:	00003097          	auipc	ra,0x3
    80000f6c:	4e0080e7          	jalr	1248(ra) # 80004448 <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000f70:	00005097          	auipc	ra,0x5
    80000f74:	f8e080e7          	jalr	-114(ra) # 80005efe <virtio_disk_init>
    userinit();      // first user process
    80000f78:	00001097          	auipc	ra,0x1
    80000f7c:	dc6080e7          	jalr	-570(ra) # 80001d3e <userinit>
    __sync_synchronize();
    80000f80:	0ff0000f          	fence
    started = 1;
    80000f84:	4785                	li	a5,1
    80000f86:	00008717          	auipc	a4,0x8
    80000f8a:	08f72923          	sw	a5,146(a4) # 80009018 <started>
    80000f8e:	b789                	j	80000ed0 <main+0x56>

0000000080000f90 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000f90:	1141                	addi	sp,sp,-16
    80000f92:	e422                	sd	s0,8(sp)
    80000f94:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    80000f96:	00008797          	auipc	a5,0x8
    80000f9a:	08a7b783          	ld	a5,138(a5) # 80009020 <kernel_pagetable>
    80000f9e:	83b1                	srli	a5,a5,0xc
    80000fa0:	577d                	li	a4,-1
    80000fa2:	177e                	slli	a4,a4,0x3f
    80000fa4:	8fd9                	or	a5,a5,a4
  asm volatile("csrw satp, %0" : : "r" (x));
    80000fa6:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000faa:	12000073          	sfence.vma
  sfence_vma();
}
    80000fae:	6422                	ld	s0,8(sp)
    80000fb0:	0141                	addi	sp,sp,16
    80000fb2:	8082                	ret

0000000080000fb4 <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    80000fb4:	7139                	addi	sp,sp,-64
    80000fb6:	fc06                	sd	ra,56(sp)
    80000fb8:	f822                	sd	s0,48(sp)
    80000fba:	f426                	sd	s1,40(sp)
    80000fbc:	f04a                	sd	s2,32(sp)
    80000fbe:	ec4e                	sd	s3,24(sp)
    80000fc0:	e852                	sd	s4,16(sp)
    80000fc2:	e456                	sd	s5,8(sp)
    80000fc4:	e05a                	sd	s6,0(sp)
    80000fc6:	0080                	addi	s0,sp,64
    80000fc8:	84aa                	mv	s1,a0
    80000fca:	89ae                	mv	s3,a1
    80000fcc:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000fce:	57fd                	li	a5,-1
    80000fd0:	83e9                	srli	a5,a5,0x1a
    80000fd2:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    80000fd4:	4b31                	li	s6,12
  if(va >= MAXVA)
    80000fd6:	04b7f263          	bgeu	a5,a1,8000101a <walk+0x66>
    panic("walk");
    80000fda:	00007517          	auipc	a0,0x7
    80000fde:	0f650513          	addi	a0,a0,246 # 800080d0 <digits+0x90>
    80000fe2:	fffff097          	auipc	ra,0xfffff
    80000fe6:	556080e7          	jalr	1366(ra) # 80000538 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000fea:	060a8663          	beqz	s5,80001056 <walk+0xa2>
    80000fee:	00000097          	auipc	ra,0x0
    80000ff2:	af2080e7          	jalr	-1294(ra) # 80000ae0 <kalloc>
    80000ff6:	84aa                	mv	s1,a0
    80000ff8:	c529                	beqz	a0,80001042 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    80000ffa:	6605                	lui	a2,0x1
    80000ffc:	4581                	li	a1,0
    80000ffe:	00000097          	auipc	ra,0x0
    80001002:	cce080e7          	jalr	-818(ra) # 80000ccc <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    80001006:	00c4d793          	srli	a5,s1,0xc
    8000100a:	07aa                	slli	a5,a5,0xa
    8000100c:	0017e793          	ori	a5,a5,1
    80001010:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    80001014:	3a5d                	addiw	s4,s4,-9
    80001016:	036a0063          	beq	s4,s6,80001036 <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    8000101a:	0149d933          	srl	s2,s3,s4
    8000101e:	1ff97913          	andi	s2,s2,511
    80001022:	090e                	slli	s2,s2,0x3
    80001024:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    80001026:	00093483          	ld	s1,0(s2)
    8000102a:	0014f793          	andi	a5,s1,1
    8000102e:	dfd5                	beqz	a5,80000fea <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    80001030:	80a9                	srli	s1,s1,0xa
    80001032:	04b2                	slli	s1,s1,0xc
    80001034:	b7c5                	j	80001014 <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    80001036:	00c9d513          	srli	a0,s3,0xc
    8000103a:	1ff57513          	andi	a0,a0,511
    8000103e:	050e                	slli	a0,a0,0x3
    80001040:	9526                	add	a0,a0,s1
}
    80001042:	70e2                	ld	ra,56(sp)
    80001044:	7442                	ld	s0,48(sp)
    80001046:	74a2                	ld	s1,40(sp)
    80001048:	7902                	ld	s2,32(sp)
    8000104a:	69e2                	ld	s3,24(sp)
    8000104c:	6a42                	ld	s4,16(sp)
    8000104e:	6aa2                	ld	s5,8(sp)
    80001050:	6b02                	ld	s6,0(sp)
    80001052:	6121                	addi	sp,sp,64
    80001054:	8082                	ret
        return 0;
    80001056:	4501                	li	a0,0
    80001058:	b7ed                	j	80001042 <walk+0x8e>

000000008000105a <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    8000105a:	57fd                	li	a5,-1
    8000105c:	83e9                	srli	a5,a5,0x1a
    8000105e:	00b7f463          	bgeu	a5,a1,80001066 <walkaddr+0xc>
    return 0;
    80001062:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    80001064:	8082                	ret
{
    80001066:	1141                	addi	sp,sp,-16
    80001068:	e406                	sd	ra,8(sp)
    8000106a:	e022                	sd	s0,0(sp)
    8000106c:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    8000106e:	4601                	li	a2,0
    80001070:	00000097          	auipc	ra,0x0
    80001074:	f44080e7          	jalr	-188(ra) # 80000fb4 <walk>
  if(pte == 0)
    80001078:	c105                	beqz	a0,80001098 <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    8000107a:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    8000107c:	0117f693          	andi	a3,a5,17
    80001080:	4745                	li	a4,17
    return 0;
    80001082:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    80001084:	00e68663          	beq	a3,a4,80001090 <walkaddr+0x36>
}
    80001088:	60a2                	ld	ra,8(sp)
    8000108a:	6402                	ld	s0,0(sp)
    8000108c:	0141                	addi	sp,sp,16
    8000108e:	8082                	ret
  pa = PTE2PA(*pte);
    80001090:	00a7d513          	srli	a0,a5,0xa
    80001094:	0532                	slli	a0,a0,0xc
  return pa;
    80001096:	bfcd                	j	80001088 <walkaddr+0x2e>
    return 0;
    80001098:	4501                	li	a0,0
    8000109a:	b7fd                	j	80001088 <walkaddr+0x2e>

000000008000109c <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    8000109c:	715d                	addi	sp,sp,-80
    8000109e:	e486                	sd	ra,72(sp)
    800010a0:	e0a2                	sd	s0,64(sp)
    800010a2:	fc26                	sd	s1,56(sp)
    800010a4:	f84a                	sd	s2,48(sp)
    800010a6:	f44e                	sd	s3,40(sp)
    800010a8:	f052                	sd	s4,32(sp)
    800010aa:	ec56                	sd	s5,24(sp)
    800010ac:	e85a                	sd	s6,16(sp)
    800010ae:	e45e                	sd	s7,8(sp)
    800010b0:	0880                	addi	s0,sp,80
    800010b2:	8aaa                	mv	s5,a0
    800010b4:	8b3a                	mv	s6,a4
  uint64 a, last;
  pte_t *pte;

  a = PGROUNDDOWN(va);
    800010b6:	777d                	lui	a4,0xfffff
    800010b8:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    800010bc:	167d                	addi	a2,a2,-1
    800010be:	00b609b3          	add	s3,a2,a1
    800010c2:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    800010c6:	893e                	mv	s2,a5
    800010c8:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    800010cc:	6b85                	lui	s7,0x1
    800010ce:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    800010d2:	4605                	li	a2,1
    800010d4:	85ca                	mv	a1,s2
    800010d6:	8556                	mv	a0,s5
    800010d8:	00000097          	auipc	ra,0x0
    800010dc:	edc080e7          	jalr	-292(ra) # 80000fb4 <walk>
    800010e0:	c51d                	beqz	a0,8000110e <mappages+0x72>
    if(*pte & PTE_V)
    800010e2:	611c                	ld	a5,0(a0)
    800010e4:	8b85                	andi	a5,a5,1
    800010e6:	ef81                	bnez	a5,800010fe <mappages+0x62>
    *pte = PA2PTE(pa) | perm | PTE_V;
    800010e8:	80b1                	srli	s1,s1,0xc
    800010ea:	04aa                	slli	s1,s1,0xa
    800010ec:	0164e4b3          	or	s1,s1,s6
    800010f0:	0014e493          	ori	s1,s1,1
    800010f4:	e104                	sd	s1,0(a0)
    if(a == last)
    800010f6:	03390863          	beq	s2,s3,80001126 <mappages+0x8a>
    a += PGSIZE;
    800010fa:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800010fc:	bfc9                	j	800010ce <mappages+0x32>
      panic("remap");
    800010fe:	00007517          	auipc	a0,0x7
    80001102:	fda50513          	addi	a0,a0,-38 # 800080d8 <digits+0x98>
    80001106:	fffff097          	auipc	ra,0xfffff
    8000110a:	432080e7          	jalr	1074(ra) # 80000538 <panic>
      return -1;
    8000110e:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    80001110:	60a6                	ld	ra,72(sp)
    80001112:	6406                	ld	s0,64(sp)
    80001114:	74e2                	ld	s1,56(sp)
    80001116:	7942                	ld	s2,48(sp)
    80001118:	79a2                	ld	s3,40(sp)
    8000111a:	7a02                	ld	s4,32(sp)
    8000111c:	6ae2                	ld	s5,24(sp)
    8000111e:	6b42                	ld	s6,16(sp)
    80001120:	6ba2                	ld	s7,8(sp)
    80001122:	6161                	addi	sp,sp,80
    80001124:	8082                	ret
  return 0;
    80001126:	4501                	li	a0,0
    80001128:	b7e5                	j	80001110 <mappages+0x74>

000000008000112a <kvmmap>:
{
    8000112a:	1141                	addi	sp,sp,-16
    8000112c:	e406                	sd	ra,8(sp)
    8000112e:	e022                	sd	s0,0(sp)
    80001130:	0800                	addi	s0,sp,16
    80001132:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    80001134:	86b2                	mv	a3,a2
    80001136:	863e                	mv	a2,a5
    80001138:	00000097          	auipc	ra,0x0
    8000113c:	f64080e7          	jalr	-156(ra) # 8000109c <mappages>
    80001140:	e509                	bnez	a0,8000114a <kvmmap+0x20>
}
    80001142:	60a2                	ld	ra,8(sp)
    80001144:	6402                	ld	s0,0(sp)
    80001146:	0141                	addi	sp,sp,16
    80001148:	8082                	ret
    panic("kvmmap");
    8000114a:	00007517          	auipc	a0,0x7
    8000114e:	f9650513          	addi	a0,a0,-106 # 800080e0 <digits+0xa0>
    80001152:	fffff097          	auipc	ra,0xfffff
    80001156:	3e6080e7          	jalr	998(ra) # 80000538 <panic>

000000008000115a <kvmmake>:
{
    8000115a:	1101                	addi	sp,sp,-32
    8000115c:	ec06                	sd	ra,24(sp)
    8000115e:	e822                	sd	s0,16(sp)
    80001160:	e426                	sd	s1,8(sp)
    80001162:	e04a                	sd	s2,0(sp)
    80001164:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    80001166:	00000097          	auipc	ra,0x0
    8000116a:	97a080e7          	jalr	-1670(ra) # 80000ae0 <kalloc>
    8000116e:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80001170:	6605                	lui	a2,0x1
    80001172:	4581                	li	a1,0
    80001174:	00000097          	auipc	ra,0x0
    80001178:	b58080e7          	jalr	-1192(ra) # 80000ccc <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    8000117c:	4719                	li	a4,6
    8000117e:	6685                	lui	a3,0x1
    80001180:	10000637          	lui	a2,0x10000
    80001184:	100005b7          	lui	a1,0x10000
    80001188:	8526                	mv	a0,s1
    8000118a:	00000097          	auipc	ra,0x0
    8000118e:	fa0080e7          	jalr	-96(ra) # 8000112a <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    80001192:	4719                	li	a4,6
    80001194:	6685                	lui	a3,0x1
    80001196:	10001637          	lui	a2,0x10001
    8000119a:	100015b7          	lui	a1,0x10001
    8000119e:	8526                	mv	a0,s1
    800011a0:	00000097          	auipc	ra,0x0
    800011a4:	f8a080e7          	jalr	-118(ra) # 8000112a <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    800011a8:	4719                	li	a4,6
    800011aa:	004006b7          	lui	a3,0x400
    800011ae:	0c000637          	lui	a2,0xc000
    800011b2:	0c0005b7          	lui	a1,0xc000
    800011b6:	8526                	mv	a0,s1
    800011b8:	00000097          	auipc	ra,0x0
    800011bc:	f72080e7          	jalr	-142(ra) # 8000112a <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    800011c0:	00007917          	auipc	s2,0x7
    800011c4:	e4090913          	addi	s2,s2,-448 # 80008000 <etext>
    800011c8:	4729                	li	a4,10
    800011ca:	80007697          	auipc	a3,0x80007
    800011ce:	e3668693          	addi	a3,a3,-458 # 8000 <_entry-0x7fff8000>
    800011d2:	4605                	li	a2,1
    800011d4:	067e                	slli	a2,a2,0x1f
    800011d6:	85b2                	mv	a1,a2
    800011d8:	8526                	mv	a0,s1
    800011da:	00000097          	auipc	ra,0x0
    800011de:	f50080e7          	jalr	-176(ra) # 8000112a <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    800011e2:	4719                	li	a4,6
    800011e4:	46c5                	li	a3,17
    800011e6:	06ee                	slli	a3,a3,0x1b
    800011e8:	412686b3          	sub	a3,a3,s2
    800011ec:	864a                	mv	a2,s2
    800011ee:	85ca                	mv	a1,s2
    800011f0:	8526                	mv	a0,s1
    800011f2:	00000097          	auipc	ra,0x0
    800011f6:	f38080e7          	jalr	-200(ra) # 8000112a <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800011fa:	4729                	li	a4,10
    800011fc:	6685                	lui	a3,0x1
    800011fe:	00006617          	auipc	a2,0x6
    80001202:	e0260613          	addi	a2,a2,-510 # 80007000 <_trampoline>
    80001206:	040005b7          	lui	a1,0x4000
    8000120a:	15fd                	addi	a1,a1,-1
    8000120c:	05b2                	slli	a1,a1,0xc
    8000120e:	8526                	mv	a0,s1
    80001210:	00000097          	auipc	ra,0x0
    80001214:	f1a080e7          	jalr	-230(ra) # 8000112a <kvmmap>
  proc_mapstacks(kpgtbl);
    80001218:	8526                	mv	a0,s1
    8000121a:	00000097          	auipc	ra,0x0
    8000121e:	6da080e7          	jalr	1754(ra) # 800018f4 <proc_mapstacks>
}
    80001222:	8526                	mv	a0,s1
    80001224:	60e2                	ld	ra,24(sp)
    80001226:	6442                	ld	s0,16(sp)
    80001228:	64a2                	ld	s1,8(sp)
    8000122a:	6902                	ld	s2,0(sp)
    8000122c:	6105                	addi	sp,sp,32
    8000122e:	8082                	ret

0000000080001230 <kvminit>:
{
    80001230:	1141                	addi	sp,sp,-16
    80001232:	e406                	sd	ra,8(sp)
    80001234:	e022                	sd	s0,0(sp)
    80001236:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    80001238:	00000097          	auipc	ra,0x0
    8000123c:	f22080e7          	jalr	-222(ra) # 8000115a <kvmmake>
    80001240:	00008797          	auipc	a5,0x8
    80001244:	dea7b023          	sd	a0,-544(a5) # 80009020 <kernel_pagetable>
}
    80001248:	60a2                	ld	ra,8(sp)
    8000124a:	6402                	ld	s0,0(sp)
    8000124c:	0141                	addi	sp,sp,16
    8000124e:	8082                	ret

0000000080001250 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80001250:	715d                	addi	sp,sp,-80
    80001252:	e486                	sd	ra,72(sp)
    80001254:	e0a2                	sd	s0,64(sp)
    80001256:	fc26                	sd	s1,56(sp)
    80001258:	f84a                	sd	s2,48(sp)
    8000125a:	f44e                	sd	s3,40(sp)
    8000125c:	f052                	sd	s4,32(sp)
    8000125e:	ec56                	sd	s5,24(sp)
    80001260:	e85a                	sd	s6,16(sp)
    80001262:	e45e                	sd	s7,8(sp)
    80001264:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    80001266:	03459793          	slli	a5,a1,0x34
    8000126a:	e795                	bnez	a5,80001296 <uvmunmap+0x46>
    8000126c:	8a2a                	mv	s4,a0
    8000126e:	892e                	mv	s2,a1
    80001270:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80001272:	0632                	slli	a2,a2,0xc
    80001274:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80001278:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000127a:	6b05                	lui	s6,0x1
    8000127c:	0735e263          	bltu	a1,s3,800012e0 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80001280:	60a6                	ld	ra,72(sp)
    80001282:	6406                	ld	s0,64(sp)
    80001284:	74e2                	ld	s1,56(sp)
    80001286:	7942                	ld	s2,48(sp)
    80001288:	79a2                	ld	s3,40(sp)
    8000128a:	7a02                	ld	s4,32(sp)
    8000128c:	6ae2                	ld	s5,24(sp)
    8000128e:	6b42                	ld	s6,16(sp)
    80001290:	6ba2                	ld	s7,8(sp)
    80001292:	6161                	addi	sp,sp,80
    80001294:	8082                	ret
    panic("uvmunmap: not aligned");
    80001296:	00007517          	auipc	a0,0x7
    8000129a:	e5250513          	addi	a0,a0,-430 # 800080e8 <digits+0xa8>
    8000129e:	fffff097          	auipc	ra,0xfffff
    800012a2:	29a080e7          	jalr	666(ra) # 80000538 <panic>
      panic("uvmunmap: walk");
    800012a6:	00007517          	auipc	a0,0x7
    800012aa:	e5a50513          	addi	a0,a0,-422 # 80008100 <digits+0xc0>
    800012ae:	fffff097          	auipc	ra,0xfffff
    800012b2:	28a080e7          	jalr	650(ra) # 80000538 <panic>
      panic("uvmunmap: not mapped");
    800012b6:	00007517          	auipc	a0,0x7
    800012ba:	e5a50513          	addi	a0,a0,-422 # 80008110 <digits+0xd0>
    800012be:	fffff097          	auipc	ra,0xfffff
    800012c2:	27a080e7          	jalr	634(ra) # 80000538 <panic>
      panic("uvmunmap: not a leaf");
    800012c6:	00007517          	auipc	a0,0x7
    800012ca:	e6250513          	addi	a0,a0,-414 # 80008128 <digits+0xe8>
    800012ce:	fffff097          	auipc	ra,0xfffff
    800012d2:	26a080e7          	jalr	618(ra) # 80000538 <panic>
    *pte = 0;
    800012d6:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    800012da:	995a                	add	s2,s2,s6
    800012dc:	fb3972e3          	bgeu	s2,s3,80001280 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    800012e0:	4601                	li	a2,0
    800012e2:	85ca                	mv	a1,s2
    800012e4:	8552                	mv	a0,s4
    800012e6:	00000097          	auipc	ra,0x0
    800012ea:	cce080e7          	jalr	-818(ra) # 80000fb4 <walk>
    800012ee:	84aa                	mv	s1,a0
    800012f0:	d95d                	beqz	a0,800012a6 <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800012f2:	6108                	ld	a0,0(a0)
    800012f4:	00157793          	andi	a5,a0,1
    800012f8:	dfdd                	beqz	a5,800012b6 <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800012fa:	3ff57793          	andi	a5,a0,1023
    800012fe:	fd7784e3          	beq	a5,s7,800012c6 <uvmunmap+0x76>
    if(do_free){
    80001302:	fc0a8ae3          	beqz	s5,800012d6 <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    80001306:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    80001308:	0532                	slli	a0,a0,0xc
    8000130a:	fffff097          	auipc	ra,0xfffff
    8000130e:	6da080e7          	jalr	1754(ra) # 800009e4 <kfree>
    80001312:	b7d1                	j	800012d6 <uvmunmap+0x86>

0000000080001314 <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    80001314:	1101                	addi	sp,sp,-32
    80001316:	ec06                	sd	ra,24(sp)
    80001318:	e822                	sd	s0,16(sp)
    8000131a:	e426                	sd	s1,8(sp)
    8000131c:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    8000131e:	fffff097          	auipc	ra,0xfffff
    80001322:	7c2080e7          	jalr	1986(ra) # 80000ae0 <kalloc>
    80001326:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001328:	c519                	beqz	a0,80001336 <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    8000132a:	6605                	lui	a2,0x1
    8000132c:	4581                	li	a1,0
    8000132e:	00000097          	auipc	ra,0x0
    80001332:	99e080e7          	jalr	-1634(ra) # 80000ccc <memset>
  return pagetable;
}
    80001336:	8526                	mv	a0,s1
    80001338:	60e2                	ld	ra,24(sp)
    8000133a:	6442                	ld	s0,16(sp)
    8000133c:	64a2                	ld	s1,8(sp)
    8000133e:	6105                	addi	sp,sp,32
    80001340:	8082                	ret

0000000080001342 <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    80001342:	7179                	addi	sp,sp,-48
    80001344:	f406                	sd	ra,40(sp)
    80001346:	f022                	sd	s0,32(sp)
    80001348:	ec26                	sd	s1,24(sp)
    8000134a:	e84a                	sd	s2,16(sp)
    8000134c:	e44e                	sd	s3,8(sp)
    8000134e:	e052                	sd	s4,0(sp)
    80001350:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    80001352:	6785                	lui	a5,0x1
    80001354:	04f67863          	bgeu	a2,a5,800013a4 <uvminit+0x62>
    80001358:	8a2a                	mv	s4,a0
    8000135a:	89ae                	mv	s3,a1
    8000135c:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    8000135e:	fffff097          	auipc	ra,0xfffff
    80001362:	782080e7          	jalr	1922(ra) # 80000ae0 <kalloc>
    80001366:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80001368:	6605                	lui	a2,0x1
    8000136a:	4581                	li	a1,0
    8000136c:	00000097          	auipc	ra,0x0
    80001370:	960080e7          	jalr	-1696(ra) # 80000ccc <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    80001374:	4779                	li	a4,30
    80001376:	86ca                	mv	a3,s2
    80001378:	6605                	lui	a2,0x1
    8000137a:	4581                	li	a1,0
    8000137c:	8552                	mv	a0,s4
    8000137e:	00000097          	auipc	ra,0x0
    80001382:	d1e080e7          	jalr	-738(ra) # 8000109c <mappages>
  memmove(mem, src, sz);
    80001386:	8626                	mv	a2,s1
    80001388:	85ce                	mv	a1,s3
    8000138a:	854a                	mv	a0,s2
    8000138c:	00000097          	auipc	ra,0x0
    80001390:	99c080e7          	jalr	-1636(ra) # 80000d28 <memmove>
}
    80001394:	70a2                	ld	ra,40(sp)
    80001396:	7402                	ld	s0,32(sp)
    80001398:	64e2                	ld	s1,24(sp)
    8000139a:	6942                	ld	s2,16(sp)
    8000139c:	69a2                	ld	s3,8(sp)
    8000139e:	6a02                	ld	s4,0(sp)
    800013a0:	6145                	addi	sp,sp,48
    800013a2:	8082                	ret
    panic("inituvm: more than a page");
    800013a4:	00007517          	auipc	a0,0x7
    800013a8:	d9c50513          	addi	a0,a0,-612 # 80008140 <digits+0x100>
    800013ac:	fffff097          	auipc	ra,0xfffff
    800013b0:	18c080e7          	jalr	396(ra) # 80000538 <panic>

00000000800013b4 <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    800013b4:	1101                	addi	sp,sp,-32
    800013b6:	ec06                	sd	ra,24(sp)
    800013b8:	e822                	sd	s0,16(sp)
    800013ba:	e426                	sd	s1,8(sp)
    800013bc:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    800013be:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    800013c0:	00b67d63          	bgeu	a2,a1,800013da <uvmdealloc+0x26>
    800013c4:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    800013c6:	6785                	lui	a5,0x1
    800013c8:	17fd                	addi	a5,a5,-1
    800013ca:	00f60733          	add	a4,a2,a5
    800013ce:	767d                	lui	a2,0xfffff
    800013d0:	8f71                	and	a4,a4,a2
    800013d2:	97ae                	add	a5,a5,a1
    800013d4:	8ff1                	and	a5,a5,a2
    800013d6:	00f76863          	bltu	a4,a5,800013e6 <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    800013da:	8526                	mv	a0,s1
    800013dc:	60e2                	ld	ra,24(sp)
    800013de:	6442                	ld	s0,16(sp)
    800013e0:	64a2                	ld	s1,8(sp)
    800013e2:	6105                	addi	sp,sp,32
    800013e4:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    800013e6:	8f99                	sub	a5,a5,a4
    800013e8:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800013ea:	4685                	li	a3,1
    800013ec:	0007861b          	sext.w	a2,a5
    800013f0:	85ba                	mv	a1,a4
    800013f2:	00000097          	auipc	ra,0x0
    800013f6:	e5e080e7          	jalr	-418(ra) # 80001250 <uvmunmap>
    800013fa:	b7c5                	j	800013da <uvmdealloc+0x26>

00000000800013fc <uvmalloc>:
  if(newsz < oldsz)
    800013fc:	0ab66163          	bltu	a2,a1,8000149e <uvmalloc+0xa2>
{
    80001400:	7139                	addi	sp,sp,-64
    80001402:	fc06                	sd	ra,56(sp)
    80001404:	f822                	sd	s0,48(sp)
    80001406:	f426                	sd	s1,40(sp)
    80001408:	f04a                	sd	s2,32(sp)
    8000140a:	ec4e                	sd	s3,24(sp)
    8000140c:	e852                	sd	s4,16(sp)
    8000140e:	e456                	sd	s5,8(sp)
    80001410:	0080                	addi	s0,sp,64
    80001412:	8aaa                	mv	s5,a0
    80001414:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    80001416:	6985                	lui	s3,0x1
    80001418:	19fd                	addi	s3,s3,-1
    8000141a:	95ce                	add	a1,a1,s3
    8000141c:	79fd                	lui	s3,0xfffff
    8000141e:	0135f9b3          	and	s3,a1,s3
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001422:	08c9f063          	bgeu	s3,a2,800014a2 <uvmalloc+0xa6>
    80001426:	894e                	mv	s2,s3
    mem = kalloc();
    80001428:	fffff097          	auipc	ra,0xfffff
    8000142c:	6b8080e7          	jalr	1720(ra) # 80000ae0 <kalloc>
    80001430:	84aa                	mv	s1,a0
    if(mem == 0){
    80001432:	c51d                	beqz	a0,80001460 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    80001434:	6605                	lui	a2,0x1
    80001436:	4581                	li	a1,0
    80001438:	00000097          	auipc	ra,0x0
    8000143c:	894080e7          	jalr	-1900(ra) # 80000ccc <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    80001440:	4779                	li	a4,30
    80001442:	86a6                	mv	a3,s1
    80001444:	6605                	lui	a2,0x1
    80001446:	85ca                	mv	a1,s2
    80001448:	8556                	mv	a0,s5
    8000144a:	00000097          	auipc	ra,0x0
    8000144e:	c52080e7          	jalr	-942(ra) # 8000109c <mappages>
    80001452:	e905                	bnez	a0,80001482 <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    80001454:	6785                	lui	a5,0x1
    80001456:	993e                	add	s2,s2,a5
    80001458:	fd4968e3          	bltu	s2,s4,80001428 <uvmalloc+0x2c>
  return newsz;
    8000145c:	8552                	mv	a0,s4
    8000145e:	a809                	j	80001470 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80001460:	864e                	mv	a2,s3
    80001462:	85ca                	mv	a1,s2
    80001464:	8556                	mv	a0,s5
    80001466:	00000097          	auipc	ra,0x0
    8000146a:	f4e080e7          	jalr	-178(ra) # 800013b4 <uvmdealloc>
      return 0;
    8000146e:	4501                	li	a0,0
}
    80001470:	70e2                	ld	ra,56(sp)
    80001472:	7442                	ld	s0,48(sp)
    80001474:	74a2                	ld	s1,40(sp)
    80001476:	7902                	ld	s2,32(sp)
    80001478:	69e2                	ld	s3,24(sp)
    8000147a:	6a42                	ld	s4,16(sp)
    8000147c:	6aa2                	ld	s5,8(sp)
    8000147e:	6121                	addi	sp,sp,64
    80001480:	8082                	ret
      kfree(mem);
    80001482:	8526                	mv	a0,s1
    80001484:	fffff097          	auipc	ra,0xfffff
    80001488:	560080e7          	jalr	1376(ra) # 800009e4 <kfree>
      uvmdealloc(pagetable, a, oldsz);
    8000148c:	864e                	mv	a2,s3
    8000148e:	85ca                	mv	a1,s2
    80001490:	8556                	mv	a0,s5
    80001492:	00000097          	auipc	ra,0x0
    80001496:	f22080e7          	jalr	-222(ra) # 800013b4 <uvmdealloc>
      return 0;
    8000149a:	4501                	li	a0,0
    8000149c:	bfd1                	j	80001470 <uvmalloc+0x74>
    return oldsz;
    8000149e:	852e                	mv	a0,a1
}
    800014a0:	8082                	ret
  return newsz;
    800014a2:	8532                	mv	a0,a2
    800014a4:	b7f1                	j	80001470 <uvmalloc+0x74>

00000000800014a6 <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    800014a6:	7179                	addi	sp,sp,-48
    800014a8:	f406                	sd	ra,40(sp)
    800014aa:	f022                	sd	s0,32(sp)
    800014ac:	ec26                	sd	s1,24(sp)
    800014ae:	e84a                	sd	s2,16(sp)
    800014b0:	e44e                	sd	s3,8(sp)
    800014b2:	e052                	sd	s4,0(sp)
    800014b4:	1800                	addi	s0,sp,48
    800014b6:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    800014b8:	84aa                	mv	s1,a0
    800014ba:	6905                	lui	s2,0x1
    800014bc:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014be:	4985                	li	s3,1
    800014c0:	a821                	j	800014d8 <freewalk+0x32>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    800014c2:	8129                	srli	a0,a0,0xa
      freewalk((pagetable_t)child);
    800014c4:	0532                	slli	a0,a0,0xc
    800014c6:	00000097          	auipc	ra,0x0
    800014ca:	fe0080e7          	jalr	-32(ra) # 800014a6 <freewalk>
      pagetable[i] = 0;
    800014ce:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    800014d2:	04a1                	addi	s1,s1,8
    800014d4:	03248163          	beq	s1,s2,800014f6 <freewalk+0x50>
    pte_t pte = pagetable[i];
    800014d8:	6088                	ld	a0,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    800014da:	00f57793          	andi	a5,a0,15
    800014de:	ff3782e3          	beq	a5,s3,800014c2 <freewalk+0x1c>
    } else if(pte & PTE_V){
    800014e2:	8905                	andi	a0,a0,1
    800014e4:	d57d                	beqz	a0,800014d2 <freewalk+0x2c>
      panic("freewalk: leaf");
    800014e6:	00007517          	auipc	a0,0x7
    800014ea:	c7a50513          	addi	a0,a0,-902 # 80008160 <digits+0x120>
    800014ee:	fffff097          	auipc	ra,0xfffff
    800014f2:	04a080e7          	jalr	74(ra) # 80000538 <panic>
    }
  }
  kfree((void*)pagetable);
    800014f6:	8552                	mv	a0,s4
    800014f8:	fffff097          	auipc	ra,0xfffff
    800014fc:	4ec080e7          	jalr	1260(ra) # 800009e4 <kfree>
}
    80001500:	70a2                	ld	ra,40(sp)
    80001502:	7402                	ld	s0,32(sp)
    80001504:	64e2                	ld	s1,24(sp)
    80001506:	6942                	ld	s2,16(sp)
    80001508:	69a2                	ld	s3,8(sp)
    8000150a:	6a02                	ld	s4,0(sp)
    8000150c:	6145                	addi	sp,sp,48
    8000150e:	8082                	ret

0000000080001510 <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    80001510:	1101                	addi	sp,sp,-32
    80001512:	ec06                	sd	ra,24(sp)
    80001514:	e822                	sd	s0,16(sp)
    80001516:	e426                	sd	s1,8(sp)
    80001518:	1000                	addi	s0,sp,32
    8000151a:	84aa                	mv	s1,a0
  if(sz > 0)
    8000151c:	e999                	bnez	a1,80001532 <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    8000151e:	8526                	mv	a0,s1
    80001520:	00000097          	auipc	ra,0x0
    80001524:	f86080e7          	jalr	-122(ra) # 800014a6 <freewalk>
}
    80001528:	60e2                	ld	ra,24(sp)
    8000152a:	6442                	ld	s0,16(sp)
    8000152c:	64a2                	ld	s1,8(sp)
    8000152e:	6105                	addi	sp,sp,32
    80001530:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    80001532:	6605                	lui	a2,0x1
    80001534:	167d                	addi	a2,a2,-1
    80001536:	962e                	add	a2,a2,a1
    80001538:	4685                	li	a3,1
    8000153a:	8231                	srli	a2,a2,0xc
    8000153c:	4581                	li	a1,0
    8000153e:	00000097          	auipc	ra,0x0
    80001542:	d12080e7          	jalr	-750(ra) # 80001250 <uvmunmap>
    80001546:	bfe1                	j	8000151e <uvmfree+0xe>

0000000080001548 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80001548:	c679                	beqz	a2,80001616 <uvmcopy+0xce>
{
    8000154a:	715d                	addi	sp,sp,-80
    8000154c:	e486                	sd	ra,72(sp)
    8000154e:	e0a2                	sd	s0,64(sp)
    80001550:	fc26                	sd	s1,56(sp)
    80001552:	f84a                	sd	s2,48(sp)
    80001554:	f44e                	sd	s3,40(sp)
    80001556:	f052                	sd	s4,32(sp)
    80001558:	ec56                	sd	s5,24(sp)
    8000155a:	e85a                	sd	s6,16(sp)
    8000155c:	e45e                	sd	s7,8(sp)
    8000155e:	0880                	addi	s0,sp,80
    80001560:	8b2a                	mv	s6,a0
    80001562:	8aae                	mv	s5,a1
    80001564:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80001566:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80001568:	4601                	li	a2,0
    8000156a:	85ce                	mv	a1,s3
    8000156c:	855a                	mv	a0,s6
    8000156e:	00000097          	auipc	ra,0x0
    80001572:	a46080e7          	jalr	-1466(ra) # 80000fb4 <walk>
    80001576:	c531                	beqz	a0,800015c2 <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80001578:	6118                	ld	a4,0(a0)
    8000157a:	00177793          	andi	a5,a4,1
    8000157e:	cbb1                	beqz	a5,800015d2 <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80001580:	00a75593          	srli	a1,a4,0xa
    80001584:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80001588:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    8000158c:	fffff097          	auipc	ra,0xfffff
    80001590:	554080e7          	jalr	1364(ra) # 80000ae0 <kalloc>
    80001594:	892a                	mv	s2,a0
    80001596:	c939                	beqz	a0,800015ec <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80001598:	6605                	lui	a2,0x1
    8000159a:	85de                	mv	a1,s7
    8000159c:	fffff097          	auipc	ra,0xfffff
    800015a0:	78c080e7          	jalr	1932(ra) # 80000d28 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    800015a4:	8726                	mv	a4,s1
    800015a6:	86ca                	mv	a3,s2
    800015a8:	6605                	lui	a2,0x1
    800015aa:	85ce                	mv	a1,s3
    800015ac:	8556                	mv	a0,s5
    800015ae:	00000097          	auipc	ra,0x0
    800015b2:	aee080e7          	jalr	-1298(ra) # 8000109c <mappages>
    800015b6:	e515                	bnez	a0,800015e2 <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    800015b8:	6785                	lui	a5,0x1
    800015ba:	99be                	add	s3,s3,a5
    800015bc:	fb49e6e3          	bltu	s3,s4,80001568 <uvmcopy+0x20>
    800015c0:	a081                	j	80001600 <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    800015c2:	00007517          	auipc	a0,0x7
    800015c6:	bae50513          	addi	a0,a0,-1106 # 80008170 <digits+0x130>
    800015ca:	fffff097          	auipc	ra,0xfffff
    800015ce:	f6e080e7          	jalr	-146(ra) # 80000538 <panic>
      panic("uvmcopy: page not present");
    800015d2:	00007517          	auipc	a0,0x7
    800015d6:	bbe50513          	addi	a0,a0,-1090 # 80008190 <digits+0x150>
    800015da:	fffff097          	auipc	ra,0xfffff
    800015de:	f5e080e7          	jalr	-162(ra) # 80000538 <panic>
      kfree(mem);
    800015e2:	854a                	mv	a0,s2
    800015e4:	fffff097          	auipc	ra,0xfffff
    800015e8:	400080e7          	jalr	1024(ra) # 800009e4 <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    800015ec:	4685                	li	a3,1
    800015ee:	00c9d613          	srli	a2,s3,0xc
    800015f2:	4581                	li	a1,0
    800015f4:	8556                	mv	a0,s5
    800015f6:	00000097          	auipc	ra,0x0
    800015fa:	c5a080e7          	jalr	-934(ra) # 80001250 <uvmunmap>
  return -1;
    800015fe:	557d                	li	a0,-1
}
    80001600:	60a6                	ld	ra,72(sp)
    80001602:	6406                	ld	s0,64(sp)
    80001604:	74e2                	ld	s1,56(sp)
    80001606:	7942                	ld	s2,48(sp)
    80001608:	79a2                	ld	s3,40(sp)
    8000160a:	7a02                	ld	s4,32(sp)
    8000160c:	6ae2                	ld	s5,24(sp)
    8000160e:	6b42                	ld	s6,16(sp)
    80001610:	6ba2                	ld	s7,8(sp)
    80001612:	6161                	addi	sp,sp,80
    80001614:	8082                	ret
  return 0;
    80001616:	4501                	li	a0,0
}
    80001618:	8082                	ret

000000008000161a <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    8000161a:	1141                	addi	sp,sp,-16
    8000161c:	e406                	sd	ra,8(sp)
    8000161e:	e022                	sd	s0,0(sp)
    80001620:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80001622:	4601                	li	a2,0
    80001624:	00000097          	auipc	ra,0x0
    80001628:	990080e7          	jalr	-1648(ra) # 80000fb4 <walk>
  if(pte == 0)
    8000162c:	c901                	beqz	a0,8000163c <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    8000162e:	611c                	ld	a5,0(a0)
    80001630:	9bbd                	andi	a5,a5,-17
    80001632:	e11c                	sd	a5,0(a0)
}
    80001634:	60a2                	ld	ra,8(sp)
    80001636:	6402                	ld	s0,0(sp)
    80001638:	0141                	addi	sp,sp,16
    8000163a:	8082                	ret
    panic("uvmclear");
    8000163c:	00007517          	auipc	a0,0x7
    80001640:	b7450513          	addi	a0,a0,-1164 # 800081b0 <digits+0x170>
    80001644:	fffff097          	auipc	ra,0xfffff
    80001648:	ef4080e7          	jalr	-268(ra) # 80000538 <panic>

000000008000164c <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    8000164c:	c6bd                	beqz	a3,800016ba <copyout+0x6e>
{
    8000164e:	715d                	addi	sp,sp,-80
    80001650:	e486                	sd	ra,72(sp)
    80001652:	e0a2                	sd	s0,64(sp)
    80001654:	fc26                	sd	s1,56(sp)
    80001656:	f84a                	sd	s2,48(sp)
    80001658:	f44e                	sd	s3,40(sp)
    8000165a:	f052                	sd	s4,32(sp)
    8000165c:	ec56                	sd	s5,24(sp)
    8000165e:	e85a                	sd	s6,16(sp)
    80001660:	e45e                	sd	s7,8(sp)
    80001662:	e062                	sd	s8,0(sp)
    80001664:	0880                	addi	s0,sp,80
    80001666:	8b2a                	mv	s6,a0
    80001668:	8c2e                	mv	s8,a1
    8000166a:	8a32                	mv	s4,a2
    8000166c:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    8000166e:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80001670:	6a85                	lui	s5,0x1
    80001672:	a015                	j	80001696 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80001674:	9562                	add	a0,a0,s8
    80001676:	0004861b          	sext.w	a2,s1
    8000167a:	85d2                	mv	a1,s4
    8000167c:	41250533          	sub	a0,a0,s2
    80001680:	fffff097          	auipc	ra,0xfffff
    80001684:	6a8080e7          	jalr	1704(ra) # 80000d28 <memmove>

    len -= n;
    80001688:	409989b3          	sub	s3,s3,s1
    src += n;
    8000168c:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    8000168e:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80001692:	02098263          	beqz	s3,800016b6 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80001696:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    8000169a:	85ca                	mv	a1,s2
    8000169c:	855a                	mv	a0,s6
    8000169e:	00000097          	auipc	ra,0x0
    800016a2:	9bc080e7          	jalr	-1604(ra) # 8000105a <walkaddr>
    if(pa0 == 0)
    800016a6:	cd01                	beqz	a0,800016be <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    800016a8:	418904b3          	sub	s1,s2,s8
    800016ac:	94d6                	add	s1,s1,s5
    if(n > len)
    800016ae:	fc99f3e3          	bgeu	s3,s1,80001674 <copyout+0x28>
    800016b2:	84ce                	mv	s1,s3
    800016b4:	b7c1                	j	80001674 <copyout+0x28>
  }
  return 0;
    800016b6:	4501                	li	a0,0
    800016b8:	a021                	j	800016c0 <copyout+0x74>
    800016ba:	4501                	li	a0,0
}
    800016bc:	8082                	ret
      return -1;
    800016be:	557d                	li	a0,-1
}
    800016c0:	60a6                	ld	ra,72(sp)
    800016c2:	6406                	ld	s0,64(sp)
    800016c4:	74e2                	ld	s1,56(sp)
    800016c6:	7942                	ld	s2,48(sp)
    800016c8:	79a2                	ld	s3,40(sp)
    800016ca:	7a02                	ld	s4,32(sp)
    800016cc:	6ae2                	ld	s5,24(sp)
    800016ce:	6b42                	ld	s6,16(sp)
    800016d0:	6ba2                	ld	s7,8(sp)
    800016d2:	6c02                	ld	s8,0(sp)
    800016d4:	6161                	addi	sp,sp,80
    800016d6:	8082                	ret

00000000800016d8 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    800016d8:	caa5                	beqz	a3,80001748 <copyin+0x70>
{
    800016da:	715d                	addi	sp,sp,-80
    800016dc:	e486                	sd	ra,72(sp)
    800016de:	e0a2                	sd	s0,64(sp)
    800016e0:	fc26                	sd	s1,56(sp)
    800016e2:	f84a                	sd	s2,48(sp)
    800016e4:	f44e                	sd	s3,40(sp)
    800016e6:	f052                	sd	s4,32(sp)
    800016e8:	ec56                	sd	s5,24(sp)
    800016ea:	e85a                	sd	s6,16(sp)
    800016ec:	e45e                	sd	s7,8(sp)
    800016ee:	e062                	sd	s8,0(sp)
    800016f0:	0880                	addi	s0,sp,80
    800016f2:	8b2a                	mv	s6,a0
    800016f4:	8a2e                	mv	s4,a1
    800016f6:	8c32                	mv	s8,a2
    800016f8:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    800016fa:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    800016fc:	6a85                	lui	s5,0x1
    800016fe:	a01d                	j	80001724 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80001700:	018505b3          	add	a1,a0,s8
    80001704:	0004861b          	sext.w	a2,s1
    80001708:	412585b3          	sub	a1,a1,s2
    8000170c:	8552                	mv	a0,s4
    8000170e:	fffff097          	auipc	ra,0xfffff
    80001712:	61a080e7          	jalr	1562(ra) # 80000d28 <memmove>

    len -= n;
    80001716:	409989b3          	sub	s3,s3,s1
    dst += n;
    8000171a:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    8000171c:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80001720:	02098263          	beqz	s3,80001744 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80001724:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80001728:	85ca                	mv	a1,s2
    8000172a:	855a                	mv	a0,s6
    8000172c:	00000097          	auipc	ra,0x0
    80001730:	92e080e7          	jalr	-1746(ra) # 8000105a <walkaddr>
    if(pa0 == 0)
    80001734:	cd01                	beqz	a0,8000174c <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80001736:	418904b3          	sub	s1,s2,s8
    8000173a:	94d6                	add	s1,s1,s5
    if(n > len)
    8000173c:	fc99f2e3          	bgeu	s3,s1,80001700 <copyin+0x28>
    80001740:	84ce                	mv	s1,s3
    80001742:	bf7d                	j	80001700 <copyin+0x28>
  }
  return 0;
    80001744:	4501                	li	a0,0
    80001746:	a021                	j	8000174e <copyin+0x76>
    80001748:	4501                	li	a0,0
}
    8000174a:	8082                	ret
      return -1;
    8000174c:	557d                	li	a0,-1
}
    8000174e:	60a6                	ld	ra,72(sp)
    80001750:	6406                	ld	s0,64(sp)
    80001752:	74e2                	ld	s1,56(sp)
    80001754:	7942                	ld	s2,48(sp)
    80001756:	79a2                	ld	s3,40(sp)
    80001758:	7a02                	ld	s4,32(sp)
    8000175a:	6ae2                	ld	s5,24(sp)
    8000175c:	6b42                	ld	s6,16(sp)
    8000175e:	6ba2                	ld	s7,8(sp)
    80001760:	6c02                	ld	s8,0(sp)
    80001762:	6161                	addi	sp,sp,80
    80001764:	8082                	ret

0000000080001766 <my_memmove>:

void*
my_memmove(void *dst, const void *src, uint n)
{
    80001766:	1141                	addi	sp,sp,-16
    80001768:	e422                	sd	s0,8(sp)
    8000176a:	0800                	addi	s0,sp,16
  u32 *d; */

  s = src;
  d = dst;

  if(s < d && s + (n*8) > d){
    8000176c:	06a5e163          	bltu	a1,a0,800017ce <my_memmove+0x68>
    d2 = (char*)d;
    while(n-- > 0)
      *--d2 = *--s2;
  } 
  else{
    while(n >= 8){
    80001770:	479d                	li	a5,7
    80001772:	04c7fb63          	bgeu	a5,a2,800017c8 <my_memmove+0x62>
    80001776:	ff86071b          	addiw	a4,a2,-8
    8000177a:	0037571b          	srliw	a4,a4,0x3
    8000177e:	2705                	addiw	a4,a4,1
    80001780:	02071793          	slli	a5,a4,0x20
    80001784:	01d7d713          	srli	a4,a5,0x1d
    80001788:	00e587b3          	add	a5,a1,a4
    8000178c:	86aa                	mv	a3,a0
      *d++ = *s++;
    8000178e:	05a1                	addi	a1,a1,8
    80001790:	06a1                	addi	a3,a3,8
    80001792:	ff85b803          	ld	a6,-8(a1) # 3fffff8 <_entry-0x7c000008>
    80001796:	ff06bc23          	sd	a6,-8(a3) # ff8 <_entry-0x7ffff008>
    while(n >= 8){
    8000179a:	fef59ae3          	bne	a1,a5,8000178e <my_memmove+0x28>
      *d++ = *s++;
    8000179e:	972a                	add	a4,a4,a0
      n -= 8;
    800017a0:	8a1d                	andi	a2,a2,7
    }
    const char *s2;
    char *d2;
    s2 = (const char*)s;
    d2 = (char*)d;
    while(n-- > 0){
    800017a2:	fff6069b          	addiw	a3,a2,-1
    800017a6:	ce11                	beqz	a2,800017c2 <my_memmove+0x5c>
    800017a8:	02069613          	slli	a2,a3,0x20
    800017ac:	9201                	srli	a2,a2,0x20
    800017ae:	0605                	addi	a2,a2,1
    800017b0:	963e                	add	a2,a2,a5
      *d2++ = *s2++;
    800017b2:	0785                	addi	a5,a5,1
    800017b4:	0705                	addi	a4,a4,1
    800017b6:	fff7c683          	lbu	a3,-1(a5) # fff <_entry-0x7ffff001>
    800017ba:	fed70fa3          	sb	a3,-1(a4) # ffffffffffffefff <end+0xffffffff7ffd89a7>
    while(n-- > 0){
    800017be:	fec79ae3          	bne	a5,a2,800017b2 <my_memmove+0x4c>
    }
  }

  return dst;
}
    800017c2:	6422                	ld	s0,8(sp)
    800017c4:	0141                	addi	sp,sp,16
    800017c6:	8082                	ret
    while(n >= 8){
    800017c8:	872a                	mv	a4,a0
    800017ca:	87ae                	mv	a5,a1
    800017cc:	bfd9                	j	800017a2 <my_memmove+0x3c>
  if(s < d && s + (n*8) > d){
    800017ce:	0036171b          	slliw	a4,a2,0x3
    800017d2:	1702                	slli	a4,a4,0x20
    800017d4:	9301                	srli	a4,a4,0x20
    800017d6:	070e                	slli	a4,a4,0x3
    800017d8:	00e586b3          	add	a3,a1,a4
    800017dc:	f8d57ae3          	bgeu	a0,a3,80001770 <my_memmove+0xa>
    d += (n*8);
    800017e0:	972a                	add	a4,a4,a0
    while(n >= 8){
    800017e2:	479d                	li	a5,7
    800017e4:	04c7fc63          	bgeu	a5,a2,8000183c <my_memmove+0xd6>
    800017e8:	ff86079b          	addiw	a5,a2,-8
    800017ec:	0037d79b          	srliw	a5,a5,0x3
    800017f0:	2785                	addiw	a5,a5,1
    800017f2:	02079593          	slli	a1,a5,0x20
    800017f6:	01d5d793          	srli	a5,a1,0x1d
    800017fa:	40f008b3          	neg	a7,a5
    800017fe:	40f687b3          	sub	a5,a3,a5
    d += (n*8);
    80001802:	85ba                	mv	a1,a4
      *--d = *--s;
    80001804:	16e1                	addi	a3,a3,-8
    80001806:	15e1                	addi	a1,a1,-8
    80001808:	0006b803          	ld	a6,0(a3)
    8000180c:	0105b023          	sd	a6,0(a1)
    while(n >= 8){
    80001810:	fef69ae3          	bne	a3,a5,80001804 <my_memmove+0x9e>
      *--d = *--s;
    80001814:	9746                	add	a4,a4,a7
      n -= 8;
    80001816:	8a1d                	andi	a2,a2,7
    while(n-- > 0)
    80001818:	fff6069b          	addiw	a3,a2,-1
    8000181c:	d25d                	beqz	a2,800017c2 <my_memmove+0x5c>
    8000181e:	02069613          	slli	a2,a3,0x20
    80001822:	9201                	srli	a2,a2,0x20
    80001824:	fff64613          	not	a2,a2
    80001828:	963e                	add	a2,a2,a5
      *--d2 = *--s2;
    8000182a:	17fd                	addi	a5,a5,-1
    8000182c:	177d                	addi	a4,a4,-1
    8000182e:	0007c683          	lbu	a3,0(a5)
    80001832:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    80001836:	fef61ae3          	bne	a2,a5,8000182a <my_memmove+0xc4>
    8000183a:	b761                	j	800017c2 <my_memmove+0x5c>
    s += (n*8);
    8000183c:	87b6                	mv	a5,a3
    8000183e:	bfe9                	j	80001818 <my_memmove+0xb2>

0000000080001840 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80001840:	c6c5                	beqz	a3,800018e8 <copyinstr+0xa8>
{
    80001842:	715d                	addi	sp,sp,-80
    80001844:	e486                	sd	ra,72(sp)
    80001846:	e0a2                	sd	s0,64(sp)
    80001848:	fc26                	sd	s1,56(sp)
    8000184a:	f84a                	sd	s2,48(sp)
    8000184c:	f44e                	sd	s3,40(sp)
    8000184e:	f052                	sd	s4,32(sp)
    80001850:	ec56                	sd	s5,24(sp)
    80001852:	e85a                	sd	s6,16(sp)
    80001854:	e45e                	sd	s7,8(sp)
    80001856:	0880                	addi	s0,sp,80
    80001858:	8a2a                	mv	s4,a0
    8000185a:	8b2e                	mv	s6,a1
    8000185c:	8bb2                	mv	s7,a2
    8000185e:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80001860:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80001862:	6985                	lui	s3,0x1
    80001864:	a035                	j	80001890 <copyinstr+0x50>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80001866:	00078023          	sb	zero,0(a5)
    8000186a:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    8000186c:	0017b793          	seqz	a5,a5
    80001870:	40f00533          	neg	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80001874:	60a6                	ld	ra,72(sp)
    80001876:	6406                	ld	s0,64(sp)
    80001878:	74e2                	ld	s1,56(sp)
    8000187a:	7942                	ld	s2,48(sp)
    8000187c:	79a2                	ld	s3,40(sp)
    8000187e:	7a02                	ld	s4,32(sp)
    80001880:	6ae2                	ld	s5,24(sp)
    80001882:	6b42                	ld	s6,16(sp)
    80001884:	6ba2                	ld	s7,8(sp)
    80001886:	6161                	addi	sp,sp,80
    80001888:	8082                	ret
    srcva = va0 + PGSIZE;
    8000188a:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    8000188e:	c8a9                	beqz	s1,800018e0 <copyinstr+0xa0>
    va0 = PGROUNDDOWN(srcva);
    80001890:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80001894:	85ca                	mv	a1,s2
    80001896:	8552                	mv	a0,s4
    80001898:	fffff097          	auipc	ra,0xfffff
    8000189c:	7c2080e7          	jalr	1986(ra) # 8000105a <walkaddr>
    if(pa0 == 0)
    800018a0:	c131                	beqz	a0,800018e4 <copyinstr+0xa4>
    n = PGSIZE - (srcva - va0);
    800018a2:	41790833          	sub	a6,s2,s7
    800018a6:	984e                	add	a6,a6,s3
    if(n > max)
    800018a8:	0104f363          	bgeu	s1,a6,800018ae <copyinstr+0x6e>
    800018ac:	8826                	mv	a6,s1
    char *p = (char *) (pa0 + (srcva - va0));
    800018ae:	955e                	add	a0,a0,s7
    800018b0:	41250533          	sub	a0,a0,s2
    while(n > 0){
    800018b4:	fc080be3          	beqz	a6,8000188a <copyinstr+0x4a>
    800018b8:	985a                	add	a6,a6,s6
    800018ba:	87da                	mv	a5,s6
      if(*p == '\0'){
    800018bc:	41650633          	sub	a2,a0,s6
    800018c0:	14fd                	addi	s1,s1,-1
    800018c2:	9b26                	add	s6,s6,s1
    800018c4:	00f60733          	add	a4,a2,a5
    800018c8:	00074703          	lbu	a4,0(a4)
    800018cc:	df49                	beqz	a4,80001866 <copyinstr+0x26>
        *dst = *p;
    800018ce:	00e78023          	sb	a4,0(a5)
      --max;
    800018d2:	40fb04b3          	sub	s1,s6,a5
      dst++;
    800018d6:	0785                	addi	a5,a5,1
    while(n > 0){
    800018d8:	ff0796e3          	bne	a5,a6,800018c4 <copyinstr+0x84>
      dst++;
    800018dc:	8b42                	mv	s6,a6
    800018de:	b775                	j	8000188a <copyinstr+0x4a>
    800018e0:	4781                	li	a5,0
    800018e2:	b769                	j	8000186c <copyinstr+0x2c>
      return -1;
    800018e4:	557d                	li	a0,-1
    800018e6:	b779                	j	80001874 <copyinstr+0x34>
  int got_null = 0;
    800018e8:	4781                	li	a5,0
  if(got_null){
    800018ea:	0017b793          	seqz	a5,a5
    800018ee:	40f00533          	neg	a0,a5
}
    800018f2:	8082                	ret

00000000800018f4 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    800018f4:	7139                	addi	sp,sp,-64
    800018f6:	fc06                	sd	ra,56(sp)
    800018f8:	f822                	sd	s0,48(sp)
    800018fa:	f426                	sd	s1,40(sp)
    800018fc:	f04a                	sd	s2,32(sp)
    800018fe:	ec4e                	sd	s3,24(sp)
    80001900:	e852                	sd	s4,16(sp)
    80001902:	e456                	sd	s5,8(sp)
    80001904:	e05a                	sd	s6,0(sp)
    80001906:	0080                	addi	s0,sp,64
    80001908:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    8000190a:	00010497          	auipc	s1,0x10
    8000190e:	dc648493          	addi	s1,s1,-570 # 800116d0 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80001912:	8b26                	mv	s6,s1
    80001914:	00006a97          	auipc	s5,0x6
    80001918:	6eca8a93          	addi	s5,s5,1772 # 80008000 <etext>
    8000191c:	04000937          	lui	s2,0x4000
    80001920:	197d                	addi	s2,s2,-1
    80001922:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80001924:	00015a17          	auipc	s4,0x15
    80001928:	7aca0a13          	addi	s4,s4,1964 # 800170d0 <tickslock>
    char *pa = kalloc();
    8000192c:	fffff097          	auipc	ra,0xfffff
    80001930:	1b4080e7          	jalr	436(ra) # 80000ae0 <kalloc>
    80001934:	862a                	mv	a2,a0
    if(pa == 0)
    80001936:	c131                	beqz	a0,8000197a <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80001938:	416485b3          	sub	a1,s1,s6
    8000193c:	858d                	srai	a1,a1,0x3
    8000193e:	000ab783          	ld	a5,0(s5)
    80001942:	02f585b3          	mul	a1,a1,a5
    80001946:	2585                	addiw	a1,a1,1
    80001948:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    8000194c:	4719                	li	a4,6
    8000194e:	6685                	lui	a3,0x1
    80001950:	40b905b3          	sub	a1,s2,a1
    80001954:	854e                	mv	a0,s3
    80001956:	fffff097          	auipc	ra,0xfffff
    8000195a:	7d4080e7          	jalr	2004(ra) # 8000112a <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    8000195e:	16848493          	addi	s1,s1,360
    80001962:	fd4495e3          	bne	s1,s4,8000192c <proc_mapstacks+0x38>
  }
}
    80001966:	70e2                	ld	ra,56(sp)
    80001968:	7442                	ld	s0,48(sp)
    8000196a:	74a2                	ld	s1,40(sp)
    8000196c:	7902                	ld	s2,32(sp)
    8000196e:	69e2                	ld	s3,24(sp)
    80001970:	6a42                	ld	s4,16(sp)
    80001972:	6aa2                	ld	s5,8(sp)
    80001974:	6b02                	ld	s6,0(sp)
    80001976:	6121                	addi	sp,sp,64
    80001978:	8082                	ret
      panic("kalloc");
    8000197a:	00007517          	auipc	a0,0x7
    8000197e:	84650513          	addi	a0,a0,-1978 # 800081c0 <digits+0x180>
    80001982:	fffff097          	auipc	ra,0xfffff
    80001986:	bb6080e7          	jalr	-1098(ra) # 80000538 <panic>

000000008000198a <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    8000198a:	7139                	addi	sp,sp,-64
    8000198c:	fc06                	sd	ra,56(sp)
    8000198e:	f822                	sd	s0,48(sp)
    80001990:	f426                	sd	s1,40(sp)
    80001992:	f04a                	sd	s2,32(sp)
    80001994:	ec4e                	sd	s3,24(sp)
    80001996:	e852                	sd	s4,16(sp)
    80001998:	e456                	sd	s5,8(sp)
    8000199a:	e05a                	sd	s6,0(sp)
    8000199c:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    8000199e:	00007597          	auipc	a1,0x7
    800019a2:	82a58593          	addi	a1,a1,-2006 # 800081c8 <digits+0x188>
    800019a6:	00010517          	auipc	a0,0x10
    800019aa:	8fa50513          	addi	a0,a0,-1798 # 800112a0 <pid_lock>
    800019ae:	fffff097          	auipc	ra,0xfffff
    800019b2:	192080e7          	jalr	402(ra) # 80000b40 <initlock>
  initlock(&wait_lock, "wait_lock");
    800019b6:	00007597          	auipc	a1,0x7
    800019ba:	81a58593          	addi	a1,a1,-2022 # 800081d0 <digits+0x190>
    800019be:	00010517          	auipc	a0,0x10
    800019c2:	8fa50513          	addi	a0,a0,-1798 # 800112b8 <wait_lock>
    800019c6:	fffff097          	auipc	ra,0xfffff
    800019ca:	17a080e7          	jalr	378(ra) # 80000b40 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    800019ce:	00010497          	auipc	s1,0x10
    800019d2:	d0248493          	addi	s1,s1,-766 # 800116d0 <proc>
      initlock(&p->lock, "proc");
    800019d6:	00007b17          	auipc	s6,0x7
    800019da:	80ab0b13          	addi	s6,s6,-2038 # 800081e0 <digits+0x1a0>
      p->kstack = KSTACK((int) (p - proc));
    800019de:	8aa6                	mv	s5,s1
    800019e0:	00006a17          	auipc	s4,0x6
    800019e4:	620a0a13          	addi	s4,s4,1568 # 80008000 <etext>
    800019e8:	04000937          	lui	s2,0x4000
    800019ec:	197d                	addi	s2,s2,-1
    800019ee:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    800019f0:	00015997          	auipc	s3,0x15
    800019f4:	6e098993          	addi	s3,s3,1760 # 800170d0 <tickslock>
      initlock(&p->lock, "proc");
    800019f8:	85da                	mv	a1,s6
    800019fa:	8526                	mv	a0,s1
    800019fc:	fffff097          	auipc	ra,0xfffff
    80001a00:	144080e7          	jalr	324(ra) # 80000b40 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80001a04:	415487b3          	sub	a5,s1,s5
    80001a08:	878d                	srai	a5,a5,0x3
    80001a0a:	000a3703          	ld	a4,0(s4)
    80001a0e:	02e787b3          	mul	a5,a5,a4
    80001a12:	2785                	addiw	a5,a5,1
    80001a14:	00d7979b          	slliw	a5,a5,0xd
    80001a18:	40f907b3          	sub	a5,s2,a5
    80001a1c:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80001a1e:	16848493          	addi	s1,s1,360
    80001a22:	fd349be3          	bne	s1,s3,800019f8 <procinit+0x6e>
  }
}
    80001a26:	70e2                	ld	ra,56(sp)
    80001a28:	7442                	ld	s0,48(sp)
    80001a2a:	74a2                	ld	s1,40(sp)
    80001a2c:	7902                	ld	s2,32(sp)
    80001a2e:	69e2                	ld	s3,24(sp)
    80001a30:	6a42                	ld	s4,16(sp)
    80001a32:	6aa2                	ld	s5,8(sp)
    80001a34:	6b02                	ld	s6,0(sp)
    80001a36:	6121                	addi	sp,sp,64
    80001a38:	8082                	ret

0000000080001a3a <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80001a3a:	1141                	addi	sp,sp,-16
    80001a3c:	e422                	sd	s0,8(sp)
    80001a3e:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80001a40:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80001a42:	2501                	sext.w	a0,a0
    80001a44:	6422                	ld	s0,8(sp)
    80001a46:	0141                	addi	sp,sp,16
    80001a48:	8082                	ret

0000000080001a4a <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80001a4a:	1141                	addi	sp,sp,-16
    80001a4c:	e422                	sd	s0,8(sp)
    80001a4e:	0800                	addi	s0,sp,16
    80001a50:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80001a52:	2781                	sext.w	a5,a5
    80001a54:	079e                	slli	a5,a5,0x7
  return c;
}
    80001a56:	00010517          	auipc	a0,0x10
    80001a5a:	87a50513          	addi	a0,a0,-1926 # 800112d0 <cpus>
    80001a5e:	953e                	add	a0,a0,a5
    80001a60:	6422                	ld	s0,8(sp)
    80001a62:	0141                	addi	sp,sp,16
    80001a64:	8082                	ret

0000000080001a66 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80001a66:	1101                	addi	sp,sp,-32
    80001a68:	ec06                	sd	ra,24(sp)
    80001a6a:	e822                	sd	s0,16(sp)
    80001a6c:	e426                	sd	s1,8(sp)
    80001a6e:	1000                	addi	s0,sp,32
  push_off();
    80001a70:	fffff097          	auipc	ra,0xfffff
    80001a74:	114080e7          	jalr	276(ra) # 80000b84 <push_off>
    80001a78:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80001a7a:	2781                	sext.w	a5,a5
    80001a7c:	079e                	slli	a5,a5,0x7
    80001a7e:	00010717          	auipc	a4,0x10
    80001a82:	82270713          	addi	a4,a4,-2014 # 800112a0 <pid_lock>
    80001a86:	97ba                	add	a5,a5,a4
    80001a88:	7b84                	ld	s1,48(a5)
  pop_off();
    80001a8a:	fffff097          	auipc	ra,0xfffff
    80001a8e:	19a080e7          	jalr	410(ra) # 80000c24 <pop_off>
  return p;
}
    80001a92:	8526                	mv	a0,s1
    80001a94:	60e2                	ld	ra,24(sp)
    80001a96:	6442                	ld	s0,16(sp)
    80001a98:	64a2                	ld	s1,8(sp)
    80001a9a:	6105                	addi	sp,sp,32
    80001a9c:	8082                	ret

0000000080001a9e <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80001a9e:	1141                	addi	sp,sp,-16
    80001aa0:	e406                	sd	ra,8(sp)
    80001aa2:	e022                	sd	s0,0(sp)
    80001aa4:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80001aa6:	00000097          	auipc	ra,0x0
    80001aaa:	fc0080e7          	jalr	-64(ra) # 80001a66 <myproc>
    80001aae:	fffff097          	auipc	ra,0xfffff
    80001ab2:	1d6080e7          	jalr	470(ra) # 80000c84 <release>

  if (first) {
    80001ab6:	00007797          	auipc	a5,0x7
    80001aba:	e6a7a783          	lw	a5,-406(a5) # 80008920 <first.1>
    80001abe:	eb89                	bnez	a5,80001ad0 <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80001ac0:	00001097          	auipc	ra,0x1
    80001ac4:	c10080e7          	jalr	-1008(ra) # 800026d0 <usertrapret>
}
    80001ac8:	60a2                	ld	ra,8(sp)
    80001aca:	6402                	ld	s0,0(sp)
    80001acc:	0141                	addi	sp,sp,16
    80001ace:	8082                	ret
    first = 0;
    80001ad0:	00007797          	auipc	a5,0x7
    80001ad4:	e407a823          	sw	zero,-432(a5) # 80008920 <first.1>
    fsinit(ROOTDEV);
    80001ad8:	4505                	li	a0,1
    80001ada:	00002097          	auipc	ra,0x2
    80001ade:	938080e7          	jalr	-1736(ra) # 80003412 <fsinit>
    80001ae2:	bff9                	j	80001ac0 <forkret+0x22>

0000000080001ae4 <allocpid>:
allocpid() {
    80001ae4:	1101                	addi	sp,sp,-32
    80001ae6:	ec06                	sd	ra,24(sp)
    80001ae8:	e822                	sd	s0,16(sp)
    80001aea:	e426                	sd	s1,8(sp)
    80001aec:	e04a                	sd	s2,0(sp)
    80001aee:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80001af0:	0000f917          	auipc	s2,0xf
    80001af4:	7b090913          	addi	s2,s2,1968 # 800112a0 <pid_lock>
    80001af8:	854a                	mv	a0,s2
    80001afa:	fffff097          	auipc	ra,0xfffff
    80001afe:	0d6080e7          	jalr	214(ra) # 80000bd0 <acquire>
  pid = nextpid;
    80001b02:	00007797          	auipc	a5,0x7
    80001b06:	e2278793          	addi	a5,a5,-478 # 80008924 <nextpid>
    80001b0a:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80001b0c:	0014871b          	addiw	a4,s1,1
    80001b10:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80001b12:	854a                	mv	a0,s2
    80001b14:	fffff097          	auipc	ra,0xfffff
    80001b18:	170080e7          	jalr	368(ra) # 80000c84 <release>
}
    80001b1c:	8526                	mv	a0,s1
    80001b1e:	60e2                	ld	ra,24(sp)
    80001b20:	6442                	ld	s0,16(sp)
    80001b22:	64a2                	ld	s1,8(sp)
    80001b24:	6902                	ld	s2,0(sp)
    80001b26:	6105                	addi	sp,sp,32
    80001b28:	8082                	ret

0000000080001b2a <proc_pagetable>:
{
    80001b2a:	1101                	addi	sp,sp,-32
    80001b2c:	ec06                	sd	ra,24(sp)
    80001b2e:	e822                	sd	s0,16(sp)
    80001b30:	e426                	sd	s1,8(sp)
    80001b32:	e04a                	sd	s2,0(sp)
    80001b34:	1000                	addi	s0,sp,32
    80001b36:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80001b38:	fffff097          	auipc	ra,0xfffff
    80001b3c:	7dc080e7          	jalr	2012(ra) # 80001314 <uvmcreate>
    80001b40:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80001b42:	c121                	beqz	a0,80001b82 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80001b44:	4729                	li	a4,10
    80001b46:	00005697          	auipc	a3,0x5
    80001b4a:	4ba68693          	addi	a3,a3,1210 # 80007000 <_trampoline>
    80001b4e:	6605                	lui	a2,0x1
    80001b50:	040005b7          	lui	a1,0x4000
    80001b54:	15fd                	addi	a1,a1,-1
    80001b56:	05b2                	slli	a1,a1,0xc
    80001b58:	fffff097          	auipc	ra,0xfffff
    80001b5c:	544080e7          	jalr	1348(ra) # 8000109c <mappages>
    80001b60:	02054863          	bltz	a0,80001b90 <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80001b64:	4719                	li	a4,6
    80001b66:	05893683          	ld	a3,88(s2)
    80001b6a:	6605                	lui	a2,0x1
    80001b6c:	020005b7          	lui	a1,0x2000
    80001b70:	15fd                	addi	a1,a1,-1
    80001b72:	05b6                	slli	a1,a1,0xd
    80001b74:	8526                	mv	a0,s1
    80001b76:	fffff097          	auipc	ra,0xfffff
    80001b7a:	526080e7          	jalr	1318(ra) # 8000109c <mappages>
    80001b7e:	02054163          	bltz	a0,80001ba0 <proc_pagetable+0x76>
}
    80001b82:	8526                	mv	a0,s1
    80001b84:	60e2                	ld	ra,24(sp)
    80001b86:	6442                	ld	s0,16(sp)
    80001b88:	64a2                	ld	s1,8(sp)
    80001b8a:	6902                	ld	s2,0(sp)
    80001b8c:	6105                	addi	sp,sp,32
    80001b8e:	8082                	ret
    uvmfree(pagetable, 0);
    80001b90:	4581                	li	a1,0
    80001b92:	8526                	mv	a0,s1
    80001b94:	00000097          	auipc	ra,0x0
    80001b98:	97c080e7          	jalr	-1668(ra) # 80001510 <uvmfree>
    return 0;
    80001b9c:	4481                	li	s1,0
    80001b9e:	b7d5                	j	80001b82 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001ba0:	4681                	li	a3,0
    80001ba2:	4605                	li	a2,1
    80001ba4:	040005b7          	lui	a1,0x4000
    80001ba8:	15fd                	addi	a1,a1,-1
    80001baa:	05b2                	slli	a1,a1,0xc
    80001bac:	8526                	mv	a0,s1
    80001bae:	fffff097          	auipc	ra,0xfffff
    80001bb2:	6a2080e7          	jalr	1698(ra) # 80001250 <uvmunmap>
    uvmfree(pagetable, 0);
    80001bb6:	4581                	li	a1,0
    80001bb8:	8526                	mv	a0,s1
    80001bba:	00000097          	auipc	ra,0x0
    80001bbe:	956080e7          	jalr	-1706(ra) # 80001510 <uvmfree>
    return 0;
    80001bc2:	4481                	li	s1,0
    80001bc4:	bf7d                	j	80001b82 <proc_pagetable+0x58>

0000000080001bc6 <proc_freepagetable>:
{
    80001bc6:	1101                	addi	sp,sp,-32
    80001bc8:	ec06                	sd	ra,24(sp)
    80001bca:	e822                	sd	s0,16(sp)
    80001bcc:	e426                	sd	s1,8(sp)
    80001bce:	e04a                	sd	s2,0(sp)
    80001bd0:	1000                	addi	s0,sp,32
    80001bd2:	84aa                	mv	s1,a0
    80001bd4:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80001bd6:	4681                	li	a3,0
    80001bd8:	4605                	li	a2,1
    80001bda:	040005b7          	lui	a1,0x4000
    80001bde:	15fd                	addi	a1,a1,-1
    80001be0:	05b2                	slli	a1,a1,0xc
    80001be2:	fffff097          	auipc	ra,0xfffff
    80001be6:	66e080e7          	jalr	1646(ra) # 80001250 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80001bea:	4681                	li	a3,0
    80001bec:	4605                	li	a2,1
    80001bee:	020005b7          	lui	a1,0x2000
    80001bf2:	15fd                	addi	a1,a1,-1
    80001bf4:	05b6                	slli	a1,a1,0xd
    80001bf6:	8526                	mv	a0,s1
    80001bf8:	fffff097          	auipc	ra,0xfffff
    80001bfc:	658080e7          	jalr	1624(ra) # 80001250 <uvmunmap>
  uvmfree(pagetable, sz);
    80001c00:	85ca                	mv	a1,s2
    80001c02:	8526                	mv	a0,s1
    80001c04:	00000097          	auipc	ra,0x0
    80001c08:	90c080e7          	jalr	-1780(ra) # 80001510 <uvmfree>
}
    80001c0c:	60e2                	ld	ra,24(sp)
    80001c0e:	6442                	ld	s0,16(sp)
    80001c10:	64a2                	ld	s1,8(sp)
    80001c12:	6902                	ld	s2,0(sp)
    80001c14:	6105                	addi	sp,sp,32
    80001c16:	8082                	ret

0000000080001c18 <freeproc>:
{
    80001c18:	1101                	addi	sp,sp,-32
    80001c1a:	ec06                	sd	ra,24(sp)
    80001c1c:	e822                	sd	s0,16(sp)
    80001c1e:	e426                	sd	s1,8(sp)
    80001c20:	1000                	addi	s0,sp,32
    80001c22:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001c24:	6d28                	ld	a0,88(a0)
    80001c26:	c509                	beqz	a0,80001c30 <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001c28:	fffff097          	auipc	ra,0xfffff
    80001c2c:	dbc080e7          	jalr	-580(ra) # 800009e4 <kfree>
  p->trapframe = 0;
    80001c30:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001c34:	68a8                	ld	a0,80(s1)
    80001c36:	c511                	beqz	a0,80001c42 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001c38:	64ac                	ld	a1,72(s1)
    80001c3a:	00000097          	auipc	ra,0x0
    80001c3e:	f8c080e7          	jalr	-116(ra) # 80001bc6 <proc_freepagetable>
  p->pagetable = 0;
    80001c42:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001c46:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001c4a:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    80001c4e:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001c52:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001c56:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001c5a:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    80001c5e:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001c62:	0004ac23          	sw	zero,24(s1)
}
    80001c66:	60e2                	ld	ra,24(sp)
    80001c68:	6442                	ld	s0,16(sp)
    80001c6a:	64a2                	ld	s1,8(sp)
    80001c6c:	6105                	addi	sp,sp,32
    80001c6e:	8082                	ret

0000000080001c70 <allocproc>:
{
    80001c70:	1101                	addi	sp,sp,-32
    80001c72:	ec06                	sd	ra,24(sp)
    80001c74:	e822                	sd	s0,16(sp)
    80001c76:	e426                	sd	s1,8(sp)
    80001c78:	e04a                	sd	s2,0(sp)
    80001c7a:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    80001c7c:	00010497          	auipc	s1,0x10
    80001c80:	a5448493          	addi	s1,s1,-1452 # 800116d0 <proc>
    80001c84:	00015917          	auipc	s2,0x15
    80001c88:	44c90913          	addi	s2,s2,1100 # 800170d0 <tickslock>
    acquire(&p->lock);
    80001c8c:	8526                	mv	a0,s1
    80001c8e:	fffff097          	auipc	ra,0xfffff
    80001c92:	f42080e7          	jalr	-190(ra) # 80000bd0 <acquire>
    if(p->state == UNUSED) {
    80001c96:	4c9c                	lw	a5,24(s1)
    80001c98:	cf81                	beqz	a5,80001cb0 <allocproc+0x40>
      release(&p->lock);
    80001c9a:	8526                	mv	a0,s1
    80001c9c:	fffff097          	auipc	ra,0xfffff
    80001ca0:	fe8080e7          	jalr	-24(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001ca4:	16848493          	addi	s1,s1,360
    80001ca8:	ff2492e3          	bne	s1,s2,80001c8c <allocproc+0x1c>
  return 0;
    80001cac:	4481                	li	s1,0
    80001cae:	a889                	j	80001d00 <allocproc+0x90>
  p->pid = allocpid();
    80001cb0:	00000097          	auipc	ra,0x0
    80001cb4:	e34080e7          	jalr	-460(ra) # 80001ae4 <allocpid>
    80001cb8:	d888                	sw	a0,48(s1)
  p->state = USED;
    80001cba:	4785                	li	a5,1
    80001cbc:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    80001cbe:	fffff097          	auipc	ra,0xfffff
    80001cc2:	e22080e7          	jalr	-478(ra) # 80000ae0 <kalloc>
    80001cc6:	892a                	mv	s2,a0
    80001cc8:	eca8                	sd	a0,88(s1)
    80001cca:	c131                	beqz	a0,80001d0e <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    80001ccc:	8526                	mv	a0,s1
    80001cce:	00000097          	auipc	ra,0x0
    80001cd2:	e5c080e7          	jalr	-420(ra) # 80001b2a <proc_pagetable>
    80001cd6:	892a                	mv	s2,a0
    80001cd8:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    80001cda:	c531                	beqz	a0,80001d26 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    80001cdc:	07000613          	li	a2,112
    80001ce0:	4581                	li	a1,0
    80001ce2:	06048513          	addi	a0,s1,96
    80001ce6:	fffff097          	auipc	ra,0xfffff
    80001cea:	fe6080e7          	jalr	-26(ra) # 80000ccc <memset>
  p->context.ra = (uint64)forkret;
    80001cee:	00000797          	auipc	a5,0x0
    80001cf2:	db078793          	addi	a5,a5,-592 # 80001a9e <forkret>
    80001cf6:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    80001cf8:	60bc                	ld	a5,64(s1)
    80001cfa:	6705                	lui	a4,0x1
    80001cfc:	97ba                	add	a5,a5,a4
    80001cfe:	f4bc                	sd	a5,104(s1)
}
    80001d00:	8526                	mv	a0,s1
    80001d02:	60e2                	ld	ra,24(sp)
    80001d04:	6442                	ld	s0,16(sp)
    80001d06:	64a2                	ld	s1,8(sp)
    80001d08:	6902                	ld	s2,0(sp)
    80001d0a:	6105                	addi	sp,sp,32
    80001d0c:	8082                	ret
    freeproc(p);
    80001d0e:	8526                	mv	a0,s1
    80001d10:	00000097          	auipc	ra,0x0
    80001d14:	f08080e7          	jalr	-248(ra) # 80001c18 <freeproc>
    release(&p->lock);
    80001d18:	8526                	mv	a0,s1
    80001d1a:	fffff097          	auipc	ra,0xfffff
    80001d1e:	f6a080e7          	jalr	-150(ra) # 80000c84 <release>
    return 0;
    80001d22:	84ca                	mv	s1,s2
    80001d24:	bff1                	j	80001d00 <allocproc+0x90>
    freeproc(p);
    80001d26:	8526                	mv	a0,s1
    80001d28:	00000097          	auipc	ra,0x0
    80001d2c:	ef0080e7          	jalr	-272(ra) # 80001c18 <freeproc>
    release(&p->lock);
    80001d30:	8526                	mv	a0,s1
    80001d32:	fffff097          	auipc	ra,0xfffff
    80001d36:	f52080e7          	jalr	-174(ra) # 80000c84 <release>
    return 0;
    80001d3a:	84ca                	mv	s1,s2
    80001d3c:	b7d1                	j	80001d00 <allocproc+0x90>

0000000080001d3e <userinit>:
{
    80001d3e:	1101                	addi	sp,sp,-32
    80001d40:	ec06                	sd	ra,24(sp)
    80001d42:	e822                	sd	s0,16(sp)
    80001d44:	e426                	sd	s1,8(sp)
    80001d46:	1000                	addi	s0,sp,32
  p = allocproc();
    80001d48:	00000097          	auipc	ra,0x0
    80001d4c:	f28080e7          	jalr	-216(ra) # 80001c70 <allocproc>
    80001d50:	84aa                	mv	s1,a0
  initproc = p;
    80001d52:	00007797          	auipc	a5,0x7
    80001d56:	2ca7bb23          	sd	a0,726(a5) # 80009028 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001d5a:	03400613          	li	a2,52
    80001d5e:	00007597          	auipc	a1,0x7
    80001d62:	bd258593          	addi	a1,a1,-1070 # 80008930 <initcode>
    80001d66:	6928                	ld	a0,80(a0)
    80001d68:	fffff097          	auipc	ra,0xfffff
    80001d6c:	5da080e7          	jalr	1498(ra) # 80001342 <uvminit>
  p->sz = PGSIZE;
    80001d70:	6785                	lui	a5,0x1
    80001d72:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001d74:	6cb8                	ld	a4,88(s1)
    80001d76:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001d7a:	6cb8                	ld	a4,88(s1)
    80001d7c:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    80001d7e:	4641                	li	a2,16
    80001d80:	00006597          	auipc	a1,0x6
    80001d84:	46858593          	addi	a1,a1,1128 # 800081e8 <digits+0x1a8>
    80001d88:	15848513          	addi	a0,s1,344
    80001d8c:	fffff097          	auipc	ra,0xfffff
    80001d90:	092080e7          	jalr	146(ra) # 80000e1e <safestrcpy>
  p->cwd = namei("/");
    80001d94:	00006517          	auipc	a0,0x6
    80001d98:	46450513          	addi	a0,a0,1124 # 800081f8 <digits+0x1b8>
    80001d9c:	00002097          	auipc	ra,0x2
    80001da0:	0a4080e7          	jalr	164(ra) # 80003e40 <namei>
    80001da4:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001da8:	478d                	li	a5,3
    80001daa:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    80001dac:	8526                	mv	a0,s1
    80001dae:	fffff097          	auipc	ra,0xfffff
    80001db2:	ed6080e7          	jalr	-298(ra) # 80000c84 <release>
}
    80001db6:	60e2                	ld	ra,24(sp)
    80001db8:	6442                	ld	s0,16(sp)
    80001dba:	64a2                	ld	s1,8(sp)
    80001dbc:	6105                	addi	sp,sp,32
    80001dbe:	8082                	ret

0000000080001dc0 <growproc>:
{
    80001dc0:	1101                	addi	sp,sp,-32
    80001dc2:	ec06                	sd	ra,24(sp)
    80001dc4:	e822                	sd	s0,16(sp)
    80001dc6:	e426                	sd	s1,8(sp)
    80001dc8:	e04a                	sd	s2,0(sp)
    80001dca:	1000                	addi	s0,sp,32
    80001dcc:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001dce:	00000097          	auipc	ra,0x0
    80001dd2:	c98080e7          	jalr	-872(ra) # 80001a66 <myproc>
    80001dd6:	892a                	mv	s2,a0
  sz = p->sz;
    80001dd8:	652c                	ld	a1,72(a0)
    80001dda:	0005861b          	sext.w	a2,a1
  if(n > 0){
    80001dde:	00904f63          	bgtz	s1,80001dfc <growproc+0x3c>
  } else if(n < 0){
    80001de2:	0204cc63          	bltz	s1,80001e1a <growproc+0x5a>
  p->sz = sz;
    80001de6:	1602                	slli	a2,a2,0x20
    80001de8:	9201                	srli	a2,a2,0x20
    80001dea:	04c93423          	sd	a2,72(s2)
  return 0;
    80001dee:	4501                	li	a0,0
}
    80001df0:	60e2                	ld	ra,24(sp)
    80001df2:	6442                	ld	s0,16(sp)
    80001df4:	64a2                	ld	s1,8(sp)
    80001df6:	6902                	ld	s2,0(sp)
    80001df8:	6105                	addi	sp,sp,32
    80001dfa:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    80001dfc:	9e25                	addw	a2,a2,s1
    80001dfe:	1602                	slli	a2,a2,0x20
    80001e00:	9201                	srli	a2,a2,0x20
    80001e02:	1582                	slli	a1,a1,0x20
    80001e04:	9181                	srli	a1,a1,0x20
    80001e06:	6928                	ld	a0,80(a0)
    80001e08:	fffff097          	auipc	ra,0xfffff
    80001e0c:	5f4080e7          	jalr	1524(ra) # 800013fc <uvmalloc>
    80001e10:	0005061b          	sext.w	a2,a0
    80001e14:	fa69                	bnez	a2,80001de6 <growproc+0x26>
      return -1;
    80001e16:	557d                	li	a0,-1
    80001e18:	bfe1                	j	80001df0 <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    80001e1a:	9e25                	addw	a2,a2,s1
    80001e1c:	1602                	slli	a2,a2,0x20
    80001e1e:	9201                	srli	a2,a2,0x20
    80001e20:	1582                	slli	a1,a1,0x20
    80001e22:	9181                	srli	a1,a1,0x20
    80001e24:	6928                	ld	a0,80(a0)
    80001e26:	fffff097          	auipc	ra,0xfffff
    80001e2a:	58e080e7          	jalr	1422(ra) # 800013b4 <uvmdealloc>
    80001e2e:	0005061b          	sext.w	a2,a0
    80001e32:	bf55                	j	80001de6 <growproc+0x26>

0000000080001e34 <fork>:
{
    80001e34:	7139                	addi	sp,sp,-64
    80001e36:	fc06                	sd	ra,56(sp)
    80001e38:	f822                	sd	s0,48(sp)
    80001e3a:	f426                	sd	s1,40(sp)
    80001e3c:	f04a                	sd	s2,32(sp)
    80001e3e:	ec4e                	sd	s3,24(sp)
    80001e40:	e852                	sd	s4,16(sp)
    80001e42:	e456                	sd	s5,8(sp)
    80001e44:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001e46:	00000097          	auipc	ra,0x0
    80001e4a:	c20080e7          	jalr	-992(ra) # 80001a66 <myproc>
    80001e4e:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001e50:	00000097          	auipc	ra,0x0
    80001e54:	e20080e7          	jalr	-480(ra) # 80001c70 <allocproc>
    80001e58:	10050c63          	beqz	a0,80001f70 <fork+0x13c>
    80001e5c:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001e5e:	048ab603          	ld	a2,72(s5)
    80001e62:	692c                	ld	a1,80(a0)
    80001e64:	050ab503          	ld	a0,80(s5)
    80001e68:	fffff097          	auipc	ra,0xfffff
    80001e6c:	6e0080e7          	jalr	1760(ra) # 80001548 <uvmcopy>
    80001e70:	04054863          	bltz	a0,80001ec0 <fork+0x8c>
  np->sz = p->sz;
    80001e74:	048ab783          	ld	a5,72(s5)
    80001e78:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    80001e7c:	058ab683          	ld	a3,88(s5)
    80001e80:	87b6                	mv	a5,a3
    80001e82:	058a3703          	ld	a4,88(s4)
    80001e86:	12068693          	addi	a3,a3,288
    80001e8a:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001e8e:	6788                	ld	a0,8(a5)
    80001e90:	6b8c                	ld	a1,16(a5)
    80001e92:	6f90                	ld	a2,24(a5)
    80001e94:	01073023          	sd	a6,0(a4)
    80001e98:	e708                	sd	a0,8(a4)
    80001e9a:	eb0c                	sd	a1,16(a4)
    80001e9c:	ef10                	sd	a2,24(a4)
    80001e9e:	02078793          	addi	a5,a5,32
    80001ea2:	02070713          	addi	a4,a4,32
    80001ea6:	fed792e3          	bne	a5,a3,80001e8a <fork+0x56>
  np->trapframe->a0 = 0;
    80001eaa:	058a3783          	ld	a5,88(s4)
    80001eae:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001eb2:	0d0a8493          	addi	s1,s5,208
    80001eb6:	0d0a0913          	addi	s2,s4,208
    80001eba:	150a8993          	addi	s3,s5,336
    80001ebe:	a00d                	j	80001ee0 <fork+0xac>
    freeproc(np);
    80001ec0:	8552                	mv	a0,s4
    80001ec2:	00000097          	auipc	ra,0x0
    80001ec6:	d56080e7          	jalr	-682(ra) # 80001c18 <freeproc>
    release(&np->lock);
    80001eca:	8552                	mv	a0,s4
    80001ecc:	fffff097          	auipc	ra,0xfffff
    80001ed0:	db8080e7          	jalr	-584(ra) # 80000c84 <release>
    return -1;
    80001ed4:	597d                	li	s2,-1
    80001ed6:	a059                	j	80001f5c <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    80001ed8:	04a1                	addi	s1,s1,8
    80001eda:	0921                	addi	s2,s2,8
    80001edc:	01348b63          	beq	s1,s3,80001ef2 <fork+0xbe>
    if(p->ofile[i])
    80001ee0:	6088                	ld	a0,0(s1)
    80001ee2:	d97d                	beqz	a0,80001ed8 <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    80001ee4:	00002097          	auipc	ra,0x2
    80001ee8:	5f6080e7          	jalr	1526(ra) # 800044da <filedup>
    80001eec:	00a93023          	sd	a0,0(s2)
    80001ef0:	b7e5                	j	80001ed8 <fork+0xa4>
  np->cwd = idup(p->cwd);
    80001ef2:	150ab503          	ld	a0,336(s5)
    80001ef6:	00001097          	auipc	ra,0x1
    80001efa:	756080e7          	jalr	1878(ra) # 8000364c <idup>
    80001efe:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    80001f02:	4641                	li	a2,16
    80001f04:	158a8593          	addi	a1,s5,344
    80001f08:	158a0513          	addi	a0,s4,344
    80001f0c:	fffff097          	auipc	ra,0xfffff
    80001f10:	f12080e7          	jalr	-238(ra) # 80000e1e <safestrcpy>
  pid = np->pid;
    80001f14:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    80001f18:	8552                	mv	a0,s4
    80001f1a:	fffff097          	auipc	ra,0xfffff
    80001f1e:	d6a080e7          	jalr	-662(ra) # 80000c84 <release>
  acquire(&wait_lock);
    80001f22:	0000f497          	auipc	s1,0xf
    80001f26:	39648493          	addi	s1,s1,918 # 800112b8 <wait_lock>
    80001f2a:	8526                	mv	a0,s1
    80001f2c:	fffff097          	auipc	ra,0xfffff
    80001f30:	ca4080e7          	jalr	-860(ra) # 80000bd0 <acquire>
  np->parent = p;
    80001f34:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    80001f38:	8526                	mv	a0,s1
    80001f3a:	fffff097          	auipc	ra,0xfffff
    80001f3e:	d4a080e7          	jalr	-694(ra) # 80000c84 <release>
  acquire(&np->lock);
    80001f42:	8552                	mv	a0,s4
    80001f44:	fffff097          	auipc	ra,0xfffff
    80001f48:	c8c080e7          	jalr	-884(ra) # 80000bd0 <acquire>
  np->state = RUNNABLE;
    80001f4c:	478d                	li	a5,3
    80001f4e:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001f52:	8552                	mv	a0,s4
    80001f54:	fffff097          	auipc	ra,0xfffff
    80001f58:	d30080e7          	jalr	-720(ra) # 80000c84 <release>
}
    80001f5c:	854a                	mv	a0,s2
    80001f5e:	70e2                	ld	ra,56(sp)
    80001f60:	7442                	ld	s0,48(sp)
    80001f62:	74a2                	ld	s1,40(sp)
    80001f64:	7902                	ld	s2,32(sp)
    80001f66:	69e2                	ld	s3,24(sp)
    80001f68:	6a42                	ld	s4,16(sp)
    80001f6a:	6aa2                	ld	s5,8(sp)
    80001f6c:	6121                	addi	sp,sp,64
    80001f6e:	8082                	ret
    return -1;
    80001f70:	597d                	li	s2,-1
    80001f72:	b7ed                	j	80001f5c <fork+0x128>

0000000080001f74 <scheduler>:
{
    80001f74:	7139                	addi	sp,sp,-64
    80001f76:	fc06                	sd	ra,56(sp)
    80001f78:	f822                	sd	s0,48(sp)
    80001f7a:	f426                	sd	s1,40(sp)
    80001f7c:	f04a                	sd	s2,32(sp)
    80001f7e:	ec4e                	sd	s3,24(sp)
    80001f80:	e852                	sd	s4,16(sp)
    80001f82:	e456                	sd	s5,8(sp)
    80001f84:	e05a                	sd	s6,0(sp)
    80001f86:	0080                	addi	s0,sp,64
    80001f88:	8792                	mv	a5,tp
  int id = r_tp();
    80001f8a:	2781                	sext.w	a5,a5
  c->proc = 0;
    80001f8c:	00779a93          	slli	s5,a5,0x7
    80001f90:	0000f717          	auipc	a4,0xf
    80001f94:	31070713          	addi	a4,a4,784 # 800112a0 <pid_lock>
    80001f98:	9756                	add	a4,a4,s5
    80001f9a:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001f9e:	0000f717          	auipc	a4,0xf
    80001fa2:	33a70713          	addi	a4,a4,826 # 800112d8 <cpus+0x8>
    80001fa6:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    80001fa8:	498d                	li	s3,3
        p->state = RUNNING;
    80001faa:	4b11                	li	s6,4
        c->proc = p;
    80001fac:	079e                	slli	a5,a5,0x7
    80001fae:	0000fa17          	auipc	s4,0xf
    80001fb2:	2f2a0a13          	addi	s4,s4,754 # 800112a0 <pid_lock>
    80001fb6:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    80001fb8:	00015917          	auipc	s2,0x15
    80001fbc:	11890913          	addi	s2,s2,280 # 800170d0 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001fc0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001fc4:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001fc8:	10079073          	csrw	sstatus,a5
    80001fcc:	0000f497          	auipc	s1,0xf
    80001fd0:	70448493          	addi	s1,s1,1796 # 800116d0 <proc>
    80001fd4:	a811                	j	80001fe8 <scheduler+0x74>
      release(&p->lock);
    80001fd6:	8526                	mv	a0,s1
    80001fd8:	fffff097          	auipc	ra,0xfffff
    80001fdc:	cac080e7          	jalr	-852(ra) # 80000c84 <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    80001fe0:	16848493          	addi	s1,s1,360
    80001fe4:	fd248ee3          	beq	s1,s2,80001fc0 <scheduler+0x4c>
      acquire(&p->lock);
    80001fe8:	8526                	mv	a0,s1
    80001fea:	fffff097          	auipc	ra,0xfffff
    80001fee:	be6080e7          	jalr	-1050(ra) # 80000bd0 <acquire>
      if(p->state == RUNNABLE) {
    80001ff2:	4c9c                	lw	a5,24(s1)
    80001ff4:	ff3791e3          	bne	a5,s3,80001fd6 <scheduler+0x62>
        p->state = RUNNING;
    80001ff8:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    80001ffc:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    80002000:	06048593          	addi	a1,s1,96
    80002004:	8556                	mv	a0,s5
    80002006:	00000097          	auipc	ra,0x0
    8000200a:	620080e7          	jalr	1568(ra) # 80002626 <swtch>
        c->proc = 0;
    8000200e:	020a3823          	sd	zero,48(s4)
    80002012:	b7d1                	j	80001fd6 <scheduler+0x62>

0000000080002014 <sched>:
{
    80002014:	7179                	addi	sp,sp,-48
    80002016:	f406                	sd	ra,40(sp)
    80002018:	f022                	sd	s0,32(sp)
    8000201a:	ec26                	sd	s1,24(sp)
    8000201c:	e84a                	sd	s2,16(sp)
    8000201e:	e44e                	sd	s3,8(sp)
    80002020:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80002022:	00000097          	auipc	ra,0x0
    80002026:	a44080e7          	jalr	-1468(ra) # 80001a66 <myproc>
    8000202a:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000202c:	fffff097          	auipc	ra,0xfffff
    80002030:	b2a080e7          	jalr	-1238(ra) # 80000b56 <holding>
    80002034:	c93d                	beqz	a0,800020aa <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80002036:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    80002038:	2781                	sext.w	a5,a5
    8000203a:	079e                	slli	a5,a5,0x7
    8000203c:	0000f717          	auipc	a4,0xf
    80002040:	26470713          	addi	a4,a4,612 # 800112a0 <pid_lock>
    80002044:	97ba                	add	a5,a5,a4
    80002046:	0a87a703          	lw	a4,168(a5)
    8000204a:	4785                	li	a5,1
    8000204c:	06f71763          	bne	a4,a5,800020ba <sched+0xa6>
  if(p->state == RUNNING)
    80002050:	4c98                	lw	a4,24(s1)
    80002052:	4791                	li	a5,4
    80002054:	06f70b63          	beq	a4,a5,800020ca <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002058:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000205c:	8b89                	andi	a5,a5,2
  if(intr_get())
    8000205e:	efb5                	bnez	a5,800020da <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80002060:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80002062:	0000f917          	auipc	s2,0xf
    80002066:	23e90913          	addi	s2,s2,574 # 800112a0 <pid_lock>
    8000206a:	2781                	sext.w	a5,a5
    8000206c:	079e                	slli	a5,a5,0x7
    8000206e:	97ca                	add	a5,a5,s2
    80002070:	0ac7a983          	lw	s3,172(a5)
    80002074:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80002076:	2781                	sext.w	a5,a5
    80002078:	079e                	slli	a5,a5,0x7
    8000207a:	0000f597          	auipc	a1,0xf
    8000207e:	25e58593          	addi	a1,a1,606 # 800112d8 <cpus+0x8>
    80002082:	95be                	add	a1,a1,a5
    80002084:	06048513          	addi	a0,s1,96
    80002088:	00000097          	auipc	ra,0x0
    8000208c:	59e080e7          	jalr	1438(ra) # 80002626 <swtch>
    80002090:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80002092:	2781                	sext.w	a5,a5
    80002094:	079e                	slli	a5,a5,0x7
    80002096:	97ca                	add	a5,a5,s2
    80002098:	0b37a623          	sw	s3,172(a5)
}
    8000209c:	70a2                	ld	ra,40(sp)
    8000209e:	7402                	ld	s0,32(sp)
    800020a0:	64e2                	ld	s1,24(sp)
    800020a2:	6942                	ld	s2,16(sp)
    800020a4:	69a2                	ld	s3,8(sp)
    800020a6:	6145                	addi	sp,sp,48
    800020a8:	8082                	ret
    panic("sched p->lock");
    800020aa:	00006517          	auipc	a0,0x6
    800020ae:	15650513          	addi	a0,a0,342 # 80008200 <digits+0x1c0>
    800020b2:	ffffe097          	auipc	ra,0xffffe
    800020b6:	486080e7          	jalr	1158(ra) # 80000538 <panic>
    panic("sched locks");
    800020ba:	00006517          	auipc	a0,0x6
    800020be:	15650513          	addi	a0,a0,342 # 80008210 <digits+0x1d0>
    800020c2:	ffffe097          	auipc	ra,0xffffe
    800020c6:	476080e7          	jalr	1142(ra) # 80000538 <panic>
    panic("sched running");
    800020ca:	00006517          	auipc	a0,0x6
    800020ce:	15650513          	addi	a0,a0,342 # 80008220 <digits+0x1e0>
    800020d2:	ffffe097          	auipc	ra,0xffffe
    800020d6:	466080e7          	jalr	1126(ra) # 80000538 <panic>
    panic("sched interruptible");
    800020da:	00006517          	auipc	a0,0x6
    800020de:	15650513          	addi	a0,a0,342 # 80008230 <digits+0x1f0>
    800020e2:	ffffe097          	auipc	ra,0xffffe
    800020e6:	456080e7          	jalr	1110(ra) # 80000538 <panic>

00000000800020ea <yield>:
{
    800020ea:	1101                	addi	sp,sp,-32
    800020ec:	ec06                	sd	ra,24(sp)
    800020ee:	e822                	sd	s0,16(sp)
    800020f0:	e426                	sd	s1,8(sp)
    800020f2:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800020f4:	00000097          	auipc	ra,0x0
    800020f8:	972080e7          	jalr	-1678(ra) # 80001a66 <myproc>
    800020fc:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800020fe:	fffff097          	auipc	ra,0xfffff
    80002102:	ad2080e7          	jalr	-1326(ra) # 80000bd0 <acquire>
  p->state = RUNNABLE;
    80002106:	478d                	li	a5,3
    80002108:	cc9c                	sw	a5,24(s1)
  sched();
    8000210a:	00000097          	auipc	ra,0x0
    8000210e:	f0a080e7          	jalr	-246(ra) # 80002014 <sched>
  release(&p->lock);
    80002112:	8526                	mv	a0,s1
    80002114:	fffff097          	auipc	ra,0xfffff
    80002118:	b70080e7          	jalr	-1168(ra) # 80000c84 <release>
}
    8000211c:	60e2                	ld	ra,24(sp)
    8000211e:	6442                	ld	s0,16(sp)
    80002120:	64a2                	ld	s1,8(sp)
    80002122:	6105                	addi	sp,sp,32
    80002124:	8082                	ret

0000000080002126 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80002126:	7179                	addi	sp,sp,-48
    80002128:	f406                	sd	ra,40(sp)
    8000212a:	f022                	sd	s0,32(sp)
    8000212c:	ec26                	sd	s1,24(sp)
    8000212e:	e84a                	sd	s2,16(sp)
    80002130:	e44e                	sd	s3,8(sp)
    80002132:	1800                	addi	s0,sp,48
    80002134:	89aa                	mv	s3,a0
    80002136:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002138:	00000097          	auipc	ra,0x0
    8000213c:	92e080e7          	jalr	-1746(ra) # 80001a66 <myproc>
    80002140:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80002142:	fffff097          	auipc	ra,0xfffff
    80002146:	a8e080e7          	jalr	-1394(ra) # 80000bd0 <acquire>
  release(lk);
    8000214a:	854a                	mv	a0,s2
    8000214c:	fffff097          	auipc	ra,0xfffff
    80002150:	b38080e7          	jalr	-1224(ra) # 80000c84 <release>

  // Go to sleep.
  p->chan = chan;
    80002154:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    80002158:	4789                	li	a5,2
    8000215a:	cc9c                	sw	a5,24(s1)

  sched();
    8000215c:	00000097          	auipc	ra,0x0
    80002160:	eb8080e7          	jalr	-328(ra) # 80002014 <sched>

  // Tidy up.
  p->chan = 0;
    80002164:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    80002168:	8526                	mv	a0,s1
    8000216a:	fffff097          	auipc	ra,0xfffff
    8000216e:	b1a080e7          	jalr	-1254(ra) # 80000c84 <release>
  acquire(lk);
    80002172:	854a                	mv	a0,s2
    80002174:	fffff097          	auipc	ra,0xfffff
    80002178:	a5c080e7          	jalr	-1444(ra) # 80000bd0 <acquire>
}
    8000217c:	70a2                	ld	ra,40(sp)
    8000217e:	7402                	ld	s0,32(sp)
    80002180:	64e2                	ld	s1,24(sp)
    80002182:	6942                	ld	s2,16(sp)
    80002184:	69a2                	ld	s3,8(sp)
    80002186:	6145                	addi	sp,sp,48
    80002188:	8082                	ret

000000008000218a <wait>:
{
    8000218a:	715d                	addi	sp,sp,-80
    8000218c:	e486                	sd	ra,72(sp)
    8000218e:	e0a2                	sd	s0,64(sp)
    80002190:	fc26                	sd	s1,56(sp)
    80002192:	f84a                	sd	s2,48(sp)
    80002194:	f44e                	sd	s3,40(sp)
    80002196:	f052                	sd	s4,32(sp)
    80002198:	ec56                	sd	s5,24(sp)
    8000219a:	e85a                	sd	s6,16(sp)
    8000219c:	e45e                	sd	s7,8(sp)
    8000219e:	e062                	sd	s8,0(sp)
    800021a0:	0880                	addi	s0,sp,80
    800021a2:	8b2a                	mv	s6,a0
  struct proc *p = myproc();
    800021a4:	00000097          	auipc	ra,0x0
    800021a8:	8c2080e7          	jalr	-1854(ra) # 80001a66 <myproc>
    800021ac:	892a                	mv	s2,a0
  acquire(&wait_lock);
    800021ae:	0000f517          	auipc	a0,0xf
    800021b2:	10a50513          	addi	a0,a0,266 # 800112b8 <wait_lock>
    800021b6:	fffff097          	auipc	ra,0xfffff
    800021ba:	a1a080e7          	jalr	-1510(ra) # 80000bd0 <acquire>
    havekids = 0;
    800021be:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800021c0:	4a15                	li	s4,5
        havekids = 1;
    800021c2:	4a85                	li	s5,1
    for(np = proc; np < &proc[NPROC]; np++){
    800021c4:	00015997          	auipc	s3,0x15
    800021c8:	f0c98993          	addi	s3,s3,-244 # 800170d0 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800021cc:	0000fc17          	auipc	s8,0xf
    800021d0:	0ecc0c13          	addi	s8,s8,236 # 800112b8 <wait_lock>
    havekids = 0;
    800021d4:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800021d6:	0000f497          	auipc	s1,0xf
    800021da:	4fa48493          	addi	s1,s1,1274 # 800116d0 <proc>
    800021de:	a0bd                	j	8000224c <wait+0xc2>
          pid = np->pid;
    800021e0:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800021e4:	000b0e63          	beqz	s6,80002200 <wait+0x76>
    800021e8:	4691                	li	a3,4
    800021ea:	02c48613          	addi	a2,s1,44
    800021ee:	85da                	mv	a1,s6
    800021f0:	05093503          	ld	a0,80(s2)
    800021f4:	fffff097          	auipc	ra,0xfffff
    800021f8:	458080e7          	jalr	1112(ra) # 8000164c <copyout>
    800021fc:	02054563          	bltz	a0,80002226 <wait+0x9c>
          freeproc(np);
    80002200:	8526                	mv	a0,s1
    80002202:	00000097          	auipc	ra,0x0
    80002206:	a16080e7          	jalr	-1514(ra) # 80001c18 <freeproc>
          release(&np->lock);
    8000220a:	8526                	mv	a0,s1
    8000220c:	fffff097          	auipc	ra,0xfffff
    80002210:	a78080e7          	jalr	-1416(ra) # 80000c84 <release>
          release(&wait_lock);
    80002214:	0000f517          	auipc	a0,0xf
    80002218:	0a450513          	addi	a0,a0,164 # 800112b8 <wait_lock>
    8000221c:	fffff097          	auipc	ra,0xfffff
    80002220:	a68080e7          	jalr	-1432(ra) # 80000c84 <release>
          return pid;
    80002224:	a09d                	j	8000228a <wait+0x100>
            release(&np->lock);
    80002226:	8526                	mv	a0,s1
    80002228:	fffff097          	auipc	ra,0xfffff
    8000222c:	a5c080e7          	jalr	-1444(ra) # 80000c84 <release>
            release(&wait_lock);
    80002230:	0000f517          	auipc	a0,0xf
    80002234:	08850513          	addi	a0,a0,136 # 800112b8 <wait_lock>
    80002238:	fffff097          	auipc	ra,0xfffff
    8000223c:	a4c080e7          	jalr	-1460(ra) # 80000c84 <release>
            return -1;
    80002240:	59fd                	li	s3,-1
    80002242:	a0a1                	j	8000228a <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80002244:	16848493          	addi	s1,s1,360
    80002248:	03348463          	beq	s1,s3,80002270 <wait+0xe6>
      if(np->parent == p){
    8000224c:	7c9c                	ld	a5,56(s1)
    8000224e:	ff279be3          	bne	a5,s2,80002244 <wait+0xba>
        acquire(&np->lock);
    80002252:	8526                	mv	a0,s1
    80002254:	fffff097          	auipc	ra,0xfffff
    80002258:	97c080e7          	jalr	-1668(ra) # 80000bd0 <acquire>
        if(np->state == ZOMBIE){
    8000225c:	4c9c                	lw	a5,24(s1)
    8000225e:	f94781e3          	beq	a5,s4,800021e0 <wait+0x56>
        release(&np->lock);
    80002262:	8526                	mv	a0,s1
    80002264:	fffff097          	auipc	ra,0xfffff
    80002268:	a20080e7          	jalr	-1504(ra) # 80000c84 <release>
        havekids = 1;
    8000226c:	8756                	mv	a4,s5
    8000226e:	bfd9                	j	80002244 <wait+0xba>
    if(!havekids || p->killed){
    80002270:	c701                	beqz	a4,80002278 <wait+0xee>
    80002272:	02892783          	lw	a5,40(s2)
    80002276:	c79d                	beqz	a5,800022a4 <wait+0x11a>
      release(&wait_lock);
    80002278:	0000f517          	auipc	a0,0xf
    8000227c:	04050513          	addi	a0,a0,64 # 800112b8 <wait_lock>
    80002280:	fffff097          	auipc	ra,0xfffff
    80002284:	a04080e7          	jalr	-1532(ra) # 80000c84 <release>
      return -1;
    80002288:	59fd                	li	s3,-1
}
    8000228a:	854e                	mv	a0,s3
    8000228c:	60a6                	ld	ra,72(sp)
    8000228e:	6406                	ld	s0,64(sp)
    80002290:	74e2                	ld	s1,56(sp)
    80002292:	7942                	ld	s2,48(sp)
    80002294:	79a2                	ld	s3,40(sp)
    80002296:	7a02                	ld	s4,32(sp)
    80002298:	6ae2                	ld	s5,24(sp)
    8000229a:	6b42                	ld	s6,16(sp)
    8000229c:	6ba2                	ld	s7,8(sp)
    8000229e:	6c02                	ld	s8,0(sp)
    800022a0:	6161                	addi	sp,sp,80
    800022a2:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800022a4:	85e2                	mv	a1,s8
    800022a6:	854a                	mv	a0,s2
    800022a8:	00000097          	auipc	ra,0x0
    800022ac:	e7e080e7          	jalr	-386(ra) # 80002126 <sleep>
    havekids = 0;
    800022b0:	b715                	j	800021d4 <wait+0x4a>

00000000800022b2 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    800022b2:	7139                	addi	sp,sp,-64
    800022b4:	fc06                	sd	ra,56(sp)
    800022b6:	f822                	sd	s0,48(sp)
    800022b8:	f426                	sd	s1,40(sp)
    800022ba:	f04a                	sd	s2,32(sp)
    800022bc:	ec4e                	sd	s3,24(sp)
    800022be:	e852                	sd	s4,16(sp)
    800022c0:	e456                	sd	s5,8(sp)
    800022c2:	0080                	addi	s0,sp,64
    800022c4:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800022c6:	0000f497          	auipc	s1,0xf
    800022ca:	40a48493          	addi	s1,s1,1034 # 800116d0 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800022ce:	4989                	li	s3,2
        p->state = RUNNABLE;
    800022d0:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800022d2:	00015917          	auipc	s2,0x15
    800022d6:	dfe90913          	addi	s2,s2,-514 # 800170d0 <tickslock>
    800022da:	a811                	j	800022ee <wakeup+0x3c>
      }
      release(&p->lock);
    800022dc:	8526                	mv	a0,s1
    800022de:	fffff097          	auipc	ra,0xfffff
    800022e2:	9a6080e7          	jalr	-1626(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800022e6:	16848493          	addi	s1,s1,360
    800022ea:	03248663          	beq	s1,s2,80002316 <wakeup+0x64>
    if(p != myproc()){
    800022ee:	fffff097          	auipc	ra,0xfffff
    800022f2:	778080e7          	jalr	1912(ra) # 80001a66 <myproc>
    800022f6:	fea488e3          	beq	s1,a0,800022e6 <wakeup+0x34>
      acquire(&p->lock);
    800022fa:	8526                	mv	a0,s1
    800022fc:	fffff097          	auipc	ra,0xfffff
    80002300:	8d4080e7          	jalr	-1836(ra) # 80000bd0 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    80002304:	4c9c                	lw	a5,24(s1)
    80002306:	fd379be3          	bne	a5,s3,800022dc <wakeup+0x2a>
    8000230a:	709c                	ld	a5,32(s1)
    8000230c:	fd4798e3          	bne	a5,s4,800022dc <wakeup+0x2a>
        p->state = RUNNABLE;
    80002310:	0154ac23          	sw	s5,24(s1)
    80002314:	b7e1                	j	800022dc <wakeup+0x2a>
    }
  }
}
    80002316:	70e2                	ld	ra,56(sp)
    80002318:	7442                	ld	s0,48(sp)
    8000231a:	74a2                	ld	s1,40(sp)
    8000231c:	7902                	ld	s2,32(sp)
    8000231e:	69e2                	ld	s3,24(sp)
    80002320:	6a42                	ld	s4,16(sp)
    80002322:	6aa2                	ld	s5,8(sp)
    80002324:	6121                	addi	sp,sp,64
    80002326:	8082                	ret

0000000080002328 <reparent>:
{
    80002328:	7179                	addi	sp,sp,-48
    8000232a:	f406                	sd	ra,40(sp)
    8000232c:	f022                	sd	s0,32(sp)
    8000232e:	ec26                	sd	s1,24(sp)
    80002330:	e84a                	sd	s2,16(sp)
    80002332:	e44e                	sd	s3,8(sp)
    80002334:	e052                	sd	s4,0(sp)
    80002336:	1800                	addi	s0,sp,48
    80002338:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000233a:	0000f497          	auipc	s1,0xf
    8000233e:	39648493          	addi	s1,s1,918 # 800116d0 <proc>
      pp->parent = initproc;
    80002342:	00007a17          	auipc	s4,0x7
    80002346:	ce6a0a13          	addi	s4,s4,-794 # 80009028 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000234a:	00015997          	auipc	s3,0x15
    8000234e:	d8698993          	addi	s3,s3,-634 # 800170d0 <tickslock>
    80002352:	a029                	j	8000235c <reparent+0x34>
    80002354:	16848493          	addi	s1,s1,360
    80002358:	01348d63          	beq	s1,s3,80002372 <reparent+0x4a>
    if(pp->parent == p){
    8000235c:	7c9c                	ld	a5,56(s1)
    8000235e:	ff279be3          	bne	a5,s2,80002354 <reparent+0x2c>
      pp->parent = initproc;
    80002362:	000a3503          	ld	a0,0(s4)
    80002366:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    80002368:	00000097          	auipc	ra,0x0
    8000236c:	f4a080e7          	jalr	-182(ra) # 800022b2 <wakeup>
    80002370:	b7d5                	j	80002354 <reparent+0x2c>
}
    80002372:	70a2                	ld	ra,40(sp)
    80002374:	7402                	ld	s0,32(sp)
    80002376:	64e2                	ld	s1,24(sp)
    80002378:	6942                	ld	s2,16(sp)
    8000237a:	69a2                	ld	s3,8(sp)
    8000237c:	6a02                	ld	s4,0(sp)
    8000237e:	6145                	addi	sp,sp,48
    80002380:	8082                	ret

0000000080002382 <exit>:
{
    80002382:	7179                	addi	sp,sp,-48
    80002384:	f406                	sd	ra,40(sp)
    80002386:	f022                	sd	s0,32(sp)
    80002388:	ec26                	sd	s1,24(sp)
    8000238a:	e84a                	sd	s2,16(sp)
    8000238c:	e44e                	sd	s3,8(sp)
    8000238e:	e052                	sd	s4,0(sp)
    80002390:	1800                	addi	s0,sp,48
    80002392:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80002394:	fffff097          	auipc	ra,0xfffff
    80002398:	6d2080e7          	jalr	1746(ra) # 80001a66 <myproc>
    8000239c:	89aa                	mv	s3,a0
  if(p == initproc)
    8000239e:	00007797          	auipc	a5,0x7
    800023a2:	c8a7b783          	ld	a5,-886(a5) # 80009028 <initproc>
    800023a6:	0d050493          	addi	s1,a0,208
    800023aa:	15050913          	addi	s2,a0,336
    800023ae:	02a79363          	bne	a5,a0,800023d4 <exit+0x52>
    panic("init exiting");
    800023b2:	00006517          	auipc	a0,0x6
    800023b6:	e9650513          	addi	a0,a0,-362 # 80008248 <digits+0x208>
    800023ba:	ffffe097          	auipc	ra,0xffffe
    800023be:	17e080e7          	jalr	382(ra) # 80000538 <panic>
      fileclose(f);
    800023c2:	00002097          	auipc	ra,0x2
    800023c6:	16a080e7          	jalr	362(ra) # 8000452c <fileclose>
      p->ofile[fd] = 0;
    800023ca:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800023ce:	04a1                	addi	s1,s1,8
    800023d0:	01248563          	beq	s1,s2,800023da <exit+0x58>
    if(p->ofile[fd]){
    800023d4:	6088                	ld	a0,0(s1)
    800023d6:	f575                	bnez	a0,800023c2 <exit+0x40>
    800023d8:	bfdd                	j	800023ce <exit+0x4c>
  begin_op();
    800023da:	00002097          	auipc	ra,0x2
    800023de:	c86080e7          	jalr	-890(ra) # 80004060 <begin_op>
  iput(p->cwd);
    800023e2:	1509b503          	ld	a0,336(s3)
    800023e6:	00001097          	auipc	ra,0x1
    800023ea:	45e080e7          	jalr	1118(ra) # 80003844 <iput>
  end_op();
    800023ee:	00002097          	auipc	ra,0x2
    800023f2:	cf2080e7          	jalr	-782(ra) # 800040e0 <end_op>
  p->cwd = 0;
    800023f6:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800023fa:	0000f497          	auipc	s1,0xf
    800023fe:	ebe48493          	addi	s1,s1,-322 # 800112b8 <wait_lock>
    80002402:	8526                	mv	a0,s1
    80002404:	ffffe097          	auipc	ra,0xffffe
    80002408:	7cc080e7          	jalr	1996(ra) # 80000bd0 <acquire>
  reparent(p);
    8000240c:	854e                	mv	a0,s3
    8000240e:	00000097          	auipc	ra,0x0
    80002412:	f1a080e7          	jalr	-230(ra) # 80002328 <reparent>
  wakeup(p->parent);
    80002416:	0389b503          	ld	a0,56(s3)
    8000241a:	00000097          	auipc	ra,0x0
    8000241e:	e98080e7          	jalr	-360(ra) # 800022b2 <wakeup>
  acquire(&p->lock);
    80002422:	854e                	mv	a0,s3
    80002424:	ffffe097          	auipc	ra,0xffffe
    80002428:	7ac080e7          	jalr	1964(ra) # 80000bd0 <acquire>
  p->xstate = status;
    8000242c:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80002430:	4795                	li	a5,5
    80002432:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80002436:	8526                	mv	a0,s1
    80002438:	fffff097          	auipc	ra,0xfffff
    8000243c:	84c080e7          	jalr	-1972(ra) # 80000c84 <release>
  sched();
    80002440:	00000097          	auipc	ra,0x0
    80002444:	bd4080e7          	jalr	-1068(ra) # 80002014 <sched>
  panic("zombie exit");
    80002448:	00006517          	auipc	a0,0x6
    8000244c:	e1050513          	addi	a0,a0,-496 # 80008258 <digits+0x218>
    80002450:	ffffe097          	auipc	ra,0xffffe
    80002454:	0e8080e7          	jalr	232(ra) # 80000538 <panic>

0000000080002458 <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    80002458:	7179                	addi	sp,sp,-48
    8000245a:	f406                	sd	ra,40(sp)
    8000245c:	f022                	sd	s0,32(sp)
    8000245e:	ec26                	sd	s1,24(sp)
    80002460:	e84a                	sd	s2,16(sp)
    80002462:	e44e                	sd	s3,8(sp)
    80002464:	1800                	addi	s0,sp,48
    80002466:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    80002468:	0000f497          	auipc	s1,0xf
    8000246c:	26848493          	addi	s1,s1,616 # 800116d0 <proc>
    80002470:	00015997          	auipc	s3,0x15
    80002474:	c6098993          	addi	s3,s3,-928 # 800170d0 <tickslock>
    acquire(&p->lock);
    80002478:	8526                	mv	a0,s1
    8000247a:	ffffe097          	auipc	ra,0xffffe
    8000247e:	756080e7          	jalr	1878(ra) # 80000bd0 <acquire>
    if(p->pid == pid){
    80002482:	589c                	lw	a5,48(s1)
    80002484:	01278d63          	beq	a5,s2,8000249e <kill+0x46>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    80002488:	8526                	mv	a0,s1
    8000248a:	ffffe097          	auipc	ra,0xffffe
    8000248e:	7fa080e7          	jalr	2042(ra) # 80000c84 <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80002492:	16848493          	addi	s1,s1,360
    80002496:	ff3491e3          	bne	s1,s3,80002478 <kill+0x20>
  }
  return -1;
    8000249a:	557d                	li	a0,-1
    8000249c:	a829                	j	800024b6 <kill+0x5e>
      p->killed = 1;
    8000249e:	4785                	li	a5,1
    800024a0:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    800024a2:	4c98                	lw	a4,24(s1)
    800024a4:	4789                	li	a5,2
    800024a6:	00f70f63          	beq	a4,a5,800024c4 <kill+0x6c>
      release(&p->lock);
    800024aa:	8526                	mv	a0,s1
    800024ac:	ffffe097          	auipc	ra,0xffffe
    800024b0:	7d8080e7          	jalr	2008(ra) # 80000c84 <release>
      return 0;
    800024b4:	4501                	li	a0,0
}
    800024b6:	70a2                	ld	ra,40(sp)
    800024b8:	7402                	ld	s0,32(sp)
    800024ba:	64e2                	ld	s1,24(sp)
    800024bc:	6942                	ld	s2,16(sp)
    800024be:	69a2                	ld	s3,8(sp)
    800024c0:	6145                	addi	sp,sp,48
    800024c2:	8082                	ret
        p->state = RUNNABLE;
    800024c4:	478d                	li	a5,3
    800024c6:	cc9c                	sw	a5,24(s1)
    800024c8:	b7cd                	j	800024aa <kill+0x52>

00000000800024ca <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800024ca:	7179                	addi	sp,sp,-48
    800024cc:	f406                	sd	ra,40(sp)
    800024ce:	f022                	sd	s0,32(sp)
    800024d0:	ec26                	sd	s1,24(sp)
    800024d2:	e84a                	sd	s2,16(sp)
    800024d4:	e44e                	sd	s3,8(sp)
    800024d6:	e052                	sd	s4,0(sp)
    800024d8:	1800                	addi	s0,sp,48
    800024da:	84aa                	mv	s1,a0
    800024dc:	892e                	mv	s2,a1
    800024de:	89b2                	mv	s3,a2
    800024e0:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800024e2:	fffff097          	auipc	ra,0xfffff
    800024e6:	584080e7          	jalr	1412(ra) # 80001a66 <myproc>
  if(user_dst){
    800024ea:	c08d                	beqz	s1,8000250c <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800024ec:	86d2                	mv	a3,s4
    800024ee:	864e                	mv	a2,s3
    800024f0:	85ca                	mv	a1,s2
    800024f2:	6928                	ld	a0,80(a0)
    800024f4:	fffff097          	auipc	ra,0xfffff
    800024f8:	158080e7          	jalr	344(ra) # 8000164c <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800024fc:	70a2                	ld	ra,40(sp)
    800024fe:	7402                	ld	s0,32(sp)
    80002500:	64e2                	ld	s1,24(sp)
    80002502:	6942                	ld	s2,16(sp)
    80002504:	69a2                	ld	s3,8(sp)
    80002506:	6a02                	ld	s4,0(sp)
    80002508:	6145                	addi	sp,sp,48
    8000250a:	8082                	ret
    memmove((char *)dst, src, len);
    8000250c:	000a061b          	sext.w	a2,s4
    80002510:	85ce                	mv	a1,s3
    80002512:	854a                	mv	a0,s2
    80002514:	fffff097          	auipc	ra,0xfffff
    80002518:	814080e7          	jalr	-2028(ra) # 80000d28 <memmove>
    return 0;
    8000251c:	8526                	mv	a0,s1
    8000251e:	bff9                	j	800024fc <either_copyout+0x32>

0000000080002520 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80002520:	7179                	addi	sp,sp,-48
    80002522:	f406                	sd	ra,40(sp)
    80002524:	f022                	sd	s0,32(sp)
    80002526:	ec26                	sd	s1,24(sp)
    80002528:	e84a                	sd	s2,16(sp)
    8000252a:	e44e                	sd	s3,8(sp)
    8000252c:	e052                	sd	s4,0(sp)
    8000252e:	1800                	addi	s0,sp,48
    80002530:	892a                	mv	s2,a0
    80002532:	84ae                	mv	s1,a1
    80002534:	89b2                	mv	s3,a2
    80002536:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    80002538:	fffff097          	auipc	ra,0xfffff
    8000253c:	52e080e7          	jalr	1326(ra) # 80001a66 <myproc>
  if(user_src){
    80002540:	c08d                	beqz	s1,80002562 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80002542:	86d2                	mv	a3,s4
    80002544:	864e                	mv	a2,s3
    80002546:	85ca                	mv	a1,s2
    80002548:	6928                	ld	a0,80(a0)
    8000254a:	fffff097          	auipc	ra,0xfffff
    8000254e:	18e080e7          	jalr	398(ra) # 800016d8 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80002552:	70a2                	ld	ra,40(sp)
    80002554:	7402                	ld	s0,32(sp)
    80002556:	64e2                	ld	s1,24(sp)
    80002558:	6942                	ld	s2,16(sp)
    8000255a:	69a2                	ld	s3,8(sp)
    8000255c:	6a02                	ld	s4,0(sp)
    8000255e:	6145                	addi	sp,sp,48
    80002560:	8082                	ret
    memmove(dst, (char*)src, len);
    80002562:	000a061b          	sext.w	a2,s4
    80002566:	85ce                	mv	a1,s3
    80002568:	854a                	mv	a0,s2
    8000256a:	ffffe097          	auipc	ra,0xffffe
    8000256e:	7be080e7          	jalr	1982(ra) # 80000d28 <memmove>
    return 0;
    80002572:	8526                	mv	a0,s1
    80002574:	bff9                	j	80002552 <either_copyin+0x32>

0000000080002576 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80002576:	715d                	addi	sp,sp,-80
    80002578:	e486                	sd	ra,72(sp)
    8000257a:	e0a2                	sd	s0,64(sp)
    8000257c:	fc26                	sd	s1,56(sp)
    8000257e:	f84a                	sd	s2,48(sp)
    80002580:	f44e                	sd	s3,40(sp)
    80002582:	f052                	sd	s4,32(sp)
    80002584:	ec56                	sd	s5,24(sp)
    80002586:	e85a                	sd	s6,16(sp)
    80002588:	e45e                	sd	s7,8(sp)
    8000258a:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000258c:	00006517          	auipc	a0,0x6
    80002590:	31450513          	addi	a0,a0,788 # 800088a0 <syscalls+0x470>
    80002594:	ffffe097          	auipc	ra,0xffffe
    80002598:	fee080e7          	jalr	-18(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000259c:	0000f497          	auipc	s1,0xf
    800025a0:	28c48493          	addi	s1,s1,652 # 80011828 <proc+0x158>
    800025a4:	00015917          	auipc	s2,0x15
    800025a8:	c8490913          	addi	s2,s2,-892 # 80017228 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800025ac:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    800025ae:	00006997          	auipc	s3,0x6
    800025b2:	cba98993          	addi	s3,s3,-838 # 80008268 <digits+0x228>
    printf("%d %s %s", p->pid, state, p->name);
    800025b6:	00006a97          	auipc	s5,0x6
    800025ba:	cbaa8a93          	addi	s5,s5,-838 # 80008270 <digits+0x230>
    printf("\n");
    800025be:	00006a17          	auipc	s4,0x6
    800025c2:	2e2a0a13          	addi	s4,s4,738 # 800088a0 <syscalls+0x470>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800025c6:	00006b97          	auipc	s7,0x6
    800025ca:	ce2b8b93          	addi	s7,s7,-798 # 800082a8 <states.0>
    800025ce:	a00d                	j	800025f0 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    800025d0:	ed86a583          	lw	a1,-296(a3)
    800025d4:	8556                	mv	a0,s5
    800025d6:	ffffe097          	auipc	ra,0xffffe
    800025da:	fac080e7          	jalr	-84(ra) # 80000582 <printf>
    printf("\n");
    800025de:	8552                	mv	a0,s4
    800025e0:	ffffe097          	auipc	ra,0xffffe
    800025e4:	fa2080e7          	jalr	-94(ra) # 80000582 <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800025e8:	16848493          	addi	s1,s1,360
    800025ec:	03248263          	beq	s1,s2,80002610 <procdump+0x9a>
    if(p->state == UNUSED)
    800025f0:	86a6                	mv	a3,s1
    800025f2:	ec04a783          	lw	a5,-320(s1)
    800025f6:	dbed                	beqz	a5,800025e8 <procdump+0x72>
      state = "???";
    800025f8:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800025fa:	fcfb6be3          	bltu	s6,a5,800025d0 <procdump+0x5a>
    800025fe:	02079713          	slli	a4,a5,0x20
    80002602:	01d75793          	srli	a5,a4,0x1d
    80002606:	97de                	add	a5,a5,s7
    80002608:	6390                	ld	a2,0(a5)
    8000260a:	f279                	bnez	a2,800025d0 <procdump+0x5a>
      state = "???";
    8000260c:	864e                	mv	a2,s3
    8000260e:	b7c9                	j	800025d0 <procdump+0x5a>
  }
}
    80002610:	60a6                	ld	ra,72(sp)
    80002612:	6406                	ld	s0,64(sp)
    80002614:	74e2                	ld	s1,56(sp)
    80002616:	7942                	ld	s2,48(sp)
    80002618:	79a2                	ld	s3,40(sp)
    8000261a:	7a02                	ld	s4,32(sp)
    8000261c:	6ae2                	ld	s5,24(sp)
    8000261e:	6b42                	ld	s6,16(sp)
    80002620:	6ba2                	ld	s7,8(sp)
    80002622:	6161                	addi	sp,sp,80
    80002624:	8082                	ret

0000000080002626 <swtch>:
    80002626:	00153023          	sd	ra,0(a0)
    8000262a:	00253423          	sd	sp,8(a0)
    8000262e:	e900                	sd	s0,16(a0)
    80002630:	ed04                	sd	s1,24(a0)
    80002632:	03253023          	sd	s2,32(a0)
    80002636:	03353423          	sd	s3,40(a0)
    8000263a:	03453823          	sd	s4,48(a0)
    8000263e:	03553c23          	sd	s5,56(a0)
    80002642:	05653023          	sd	s6,64(a0)
    80002646:	05753423          	sd	s7,72(a0)
    8000264a:	05853823          	sd	s8,80(a0)
    8000264e:	05953c23          	sd	s9,88(a0)
    80002652:	07a53023          	sd	s10,96(a0)
    80002656:	07b53423          	sd	s11,104(a0)
    8000265a:	0005b083          	ld	ra,0(a1)
    8000265e:	0085b103          	ld	sp,8(a1)
    80002662:	6980                	ld	s0,16(a1)
    80002664:	6d84                	ld	s1,24(a1)
    80002666:	0205b903          	ld	s2,32(a1)
    8000266a:	0285b983          	ld	s3,40(a1)
    8000266e:	0305ba03          	ld	s4,48(a1)
    80002672:	0385ba83          	ld	s5,56(a1)
    80002676:	0405bb03          	ld	s6,64(a1)
    8000267a:	0485bb83          	ld	s7,72(a1)
    8000267e:	0505bc03          	ld	s8,80(a1)
    80002682:	0585bc83          	ld	s9,88(a1)
    80002686:	0605bd03          	ld	s10,96(a1)
    8000268a:	0685bd83          	ld	s11,104(a1)
    8000268e:	8082                	ret

0000000080002690 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80002690:	1141                	addi	sp,sp,-16
    80002692:	e406                	sd	ra,8(sp)
    80002694:	e022                	sd	s0,0(sp)
    80002696:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80002698:	00006597          	auipc	a1,0x6
    8000269c:	c4058593          	addi	a1,a1,-960 # 800082d8 <states.0+0x30>
    800026a0:	00015517          	auipc	a0,0x15
    800026a4:	a3050513          	addi	a0,a0,-1488 # 800170d0 <tickslock>
    800026a8:	ffffe097          	auipc	ra,0xffffe
    800026ac:	498080e7          	jalr	1176(ra) # 80000b40 <initlock>
}
    800026b0:	60a2                	ld	ra,8(sp)
    800026b2:	6402                	ld	s0,0(sp)
    800026b4:	0141                	addi	sp,sp,16
    800026b6:	8082                	ret

00000000800026b8 <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    800026b8:	1141                	addi	sp,sp,-16
    800026ba:	e422                	sd	s0,8(sp)
    800026bc:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    800026be:	00003797          	auipc	a5,0x3
    800026c2:	63278793          	addi	a5,a5,1586 # 80005cf0 <kernelvec>
    800026c6:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    800026ca:	6422                	ld	s0,8(sp)
    800026cc:	0141                	addi	sp,sp,16
    800026ce:	8082                	ret

00000000800026d0 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    800026d0:	1141                	addi	sp,sp,-16
    800026d2:	e406                	sd	ra,8(sp)
    800026d4:	e022                	sd	s0,0(sp)
    800026d6:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    800026d8:	fffff097          	auipc	ra,0xfffff
    800026dc:	38e080e7          	jalr	910(ra) # 80001a66 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800026e0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    800026e4:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800026e6:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    800026ea:	00005617          	auipc	a2,0x5
    800026ee:	91660613          	addi	a2,a2,-1770 # 80007000 <_trampoline>
    800026f2:	00005697          	auipc	a3,0x5
    800026f6:	90e68693          	addi	a3,a3,-1778 # 80007000 <_trampoline>
    800026fa:	8e91                	sub	a3,a3,a2
    800026fc:	040007b7          	lui	a5,0x4000
    80002700:	17fd                	addi	a5,a5,-1
    80002702:	07b2                	slli	a5,a5,0xc
    80002704:	96be                	add	a3,a3,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80002706:	10569073          	csrw	stvec,a3

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    8000270a:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    8000270c:	180026f3          	csrr	a3,satp
    80002710:	e314                	sd	a3,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80002712:	6d38                	ld	a4,88(a0)
    80002714:	6134                	ld	a3,64(a0)
    80002716:	6585                	lui	a1,0x1
    80002718:	96ae                	add	a3,a3,a1
    8000271a:	e714                	sd	a3,8(a4)
  p->trapframe->kernel_trap = (uint64)usertrap;
    8000271c:	6d38                	ld	a4,88(a0)
    8000271e:	00000697          	auipc	a3,0x0
    80002722:	13868693          	addi	a3,a3,312 # 80002856 <usertrap>
    80002726:	eb14                	sd	a3,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80002728:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    8000272a:	8692                	mv	a3,tp
    8000272c:	f314                	sd	a3,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000272e:	100026f3          	csrr	a3,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80002732:	eff6f693          	andi	a3,a3,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80002736:	0206e693          	ori	a3,a3,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    8000273a:	10069073          	csrw	sstatus,a3
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    8000273e:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002740:	6f18                	ld	a4,24(a4)
    80002742:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80002746:	692c                	ld	a1,80(a0)
    80002748:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    8000274a:	00005717          	auipc	a4,0x5
    8000274e:	94670713          	addi	a4,a4,-1722 # 80007090 <userret>
    80002752:	8f11                	sub	a4,a4,a2
    80002754:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80002756:	577d                	li	a4,-1
    80002758:	177e                	slli	a4,a4,0x3f
    8000275a:	8dd9                	or	a1,a1,a4
    8000275c:	02000537          	lui	a0,0x2000
    80002760:	157d                	addi	a0,a0,-1
    80002762:	0536                	slli	a0,a0,0xd
    80002764:	9782                	jalr	a5
}
    80002766:	60a2                	ld	ra,8(sp)
    80002768:	6402                	ld	s0,0(sp)
    8000276a:	0141                	addi	sp,sp,16
    8000276c:	8082                	ret

000000008000276e <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    8000276e:	1101                	addi	sp,sp,-32
    80002770:	ec06                	sd	ra,24(sp)
    80002772:	e822                	sd	s0,16(sp)
    80002774:	e426                	sd	s1,8(sp)
    80002776:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80002778:	00015497          	auipc	s1,0x15
    8000277c:	95848493          	addi	s1,s1,-1704 # 800170d0 <tickslock>
    80002780:	8526                	mv	a0,s1
    80002782:	ffffe097          	auipc	ra,0xffffe
    80002786:	44e080e7          	jalr	1102(ra) # 80000bd0 <acquire>
  ticks++;
    8000278a:	00007517          	auipc	a0,0x7
    8000278e:	8a650513          	addi	a0,a0,-1882 # 80009030 <ticks>
    80002792:	411c                	lw	a5,0(a0)
    80002794:	2785                	addiw	a5,a5,1
    80002796:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80002798:	00000097          	auipc	ra,0x0
    8000279c:	b1a080e7          	jalr	-1254(ra) # 800022b2 <wakeup>
  release(&tickslock);
    800027a0:	8526                	mv	a0,s1
    800027a2:	ffffe097          	auipc	ra,0xffffe
    800027a6:	4e2080e7          	jalr	1250(ra) # 80000c84 <release>
}
    800027aa:	60e2                	ld	ra,24(sp)
    800027ac:	6442                	ld	s0,16(sp)
    800027ae:	64a2                	ld	s1,8(sp)
    800027b0:	6105                	addi	sp,sp,32
    800027b2:	8082                	ret

00000000800027b4 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    800027b4:	1101                	addi	sp,sp,-32
    800027b6:	ec06                	sd	ra,24(sp)
    800027b8:	e822                	sd	s0,16(sp)
    800027ba:	e426                	sd	s1,8(sp)
    800027bc:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    800027be:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    800027c2:	00074d63          	bltz	a4,800027dc <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    800027c6:	57fd                	li	a5,-1
    800027c8:	17fe                	slli	a5,a5,0x3f
    800027ca:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    800027cc:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    800027ce:	06f70363          	beq	a4,a5,80002834 <devintr+0x80>
  }
}
    800027d2:	60e2                	ld	ra,24(sp)
    800027d4:	6442                	ld	s0,16(sp)
    800027d6:	64a2                	ld	s1,8(sp)
    800027d8:	6105                	addi	sp,sp,32
    800027da:	8082                	ret
     (scause & 0xff) == 9){
    800027dc:	0ff77793          	zext.b	a5,a4
  if((scause & 0x8000000000000000L) &&
    800027e0:	46a5                	li	a3,9
    800027e2:	fed792e3          	bne	a5,a3,800027c6 <devintr+0x12>
    int irq = plic_claim();
    800027e6:	00003097          	auipc	ra,0x3
    800027ea:	62e080e7          	jalr	1582(ra) # 80005e14 <plic_claim>
    800027ee:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    800027f0:	47a9                	li	a5,10
    800027f2:	02f50763          	beq	a0,a5,80002820 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    800027f6:	4785                	li	a5,1
    800027f8:	02f50963          	beq	a0,a5,8000282a <devintr+0x76>
    return 1;
    800027fc:	4505                	li	a0,1
    } else if(irq){
    800027fe:	d8f1                	beqz	s1,800027d2 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80002800:	85a6                	mv	a1,s1
    80002802:	00006517          	auipc	a0,0x6
    80002806:	ade50513          	addi	a0,a0,-1314 # 800082e0 <states.0+0x38>
    8000280a:	ffffe097          	auipc	ra,0xffffe
    8000280e:	d78080e7          	jalr	-648(ra) # 80000582 <printf>
      plic_complete(irq);
    80002812:	8526                	mv	a0,s1
    80002814:	00003097          	auipc	ra,0x3
    80002818:	624080e7          	jalr	1572(ra) # 80005e38 <plic_complete>
    return 1;
    8000281c:	4505                	li	a0,1
    8000281e:	bf55                	j	800027d2 <devintr+0x1e>
      uartintr();
    80002820:	ffffe097          	auipc	ra,0xffffe
    80002824:	174080e7          	jalr	372(ra) # 80000994 <uartintr>
    80002828:	b7ed                	j	80002812 <devintr+0x5e>
      virtio_disk_intr();
    8000282a:	00004097          	auipc	ra,0x4
    8000282e:	aa0080e7          	jalr	-1376(ra) # 800062ca <virtio_disk_intr>
    80002832:	b7c5                	j	80002812 <devintr+0x5e>
    if(cpuid() == 0){
    80002834:	fffff097          	auipc	ra,0xfffff
    80002838:	206080e7          	jalr	518(ra) # 80001a3a <cpuid>
    8000283c:	c901                	beqz	a0,8000284c <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    8000283e:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80002842:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80002844:	14479073          	csrw	sip,a5
    return 2;
    80002848:	4509                	li	a0,2
    8000284a:	b761                	j	800027d2 <devintr+0x1e>
      clockintr();
    8000284c:	00000097          	auipc	ra,0x0
    80002850:	f22080e7          	jalr	-222(ra) # 8000276e <clockintr>
    80002854:	b7ed                	j	8000283e <devintr+0x8a>

0000000080002856 <usertrap>:
{
    80002856:	1101                	addi	sp,sp,-32
    80002858:	ec06                	sd	ra,24(sp)
    8000285a:	e822                	sd	s0,16(sp)
    8000285c:	e426                	sd	s1,8(sp)
    8000285e:	e04a                	sd	s2,0(sp)
    80002860:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80002862:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80002866:	1007f793          	andi	a5,a5,256
    8000286a:	e3ad                	bnez	a5,800028cc <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    8000286c:	00003797          	auipc	a5,0x3
    80002870:	48478793          	addi	a5,a5,1156 # 80005cf0 <kernelvec>
    80002874:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80002878:	fffff097          	auipc	ra,0xfffff
    8000287c:	1ee080e7          	jalr	494(ra) # 80001a66 <myproc>
    80002880:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80002882:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002884:	14102773          	csrr	a4,sepc
    80002888:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    8000288a:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    8000288e:	47a1                	li	a5,8
    80002890:	04f71c63          	bne	a4,a5,800028e8 <usertrap+0x92>
    if(p->killed)
    80002894:	551c                	lw	a5,40(a0)
    80002896:	e3b9                	bnez	a5,800028dc <usertrap+0x86>
    p->trapframe->epc += 4;
    80002898:	6cb8                	ld	a4,88(s1)
    8000289a:	6f1c                	ld	a5,24(a4)
    8000289c:	0791                	addi	a5,a5,4
    8000289e:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800028a0:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800028a4:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800028a8:	10079073          	csrw	sstatus,a5
    syscall();
    800028ac:	00000097          	auipc	ra,0x0
    800028b0:	2e0080e7          	jalr	736(ra) # 80002b8c <syscall>
  if(p->killed)
    800028b4:	549c                	lw	a5,40(s1)
    800028b6:	ebc1                	bnez	a5,80002946 <usertrap+0xf0>
  usertrapret();
    800028b8:	00000097          	auipc	ra,0x0
    800028bc:	e18080e7          	jalr	-488(ra) # 800026d0 <usertrapret>
}
    800028c0:	60e2                	ld	ra,24(sp)
    800028c2:	6442                	ld	s0,16(sp)
    800028c4:	64a2                	ld	s1,8(sp)
    800028c6:	6902                	ld	s2,0(sp)
    800028c8:	6105                	addi	sp,sp,32
    800028ca:	8082                	ret
    panic("usertrap: not from user mode");
    800028cc:	00006517          	auipc	a0,0x6
    800028d0:	a3450513          	addi	a0,a0,-1484 # 80008300 <states.0+0x58>
    800028d4:	ffffe097          	auipc	ra,0xffffe
    800028d8:	c64080e7          	jalr	-924(ra) # 80000538 <panic>
      exit(-1);
    800028dc:	557d                	li	a0,-1
    800028de:	00000097          	auipc	ra,0x0
    800028e2:	aa4080e7          	jalr	-1372(ra) # 80002382 <exit>
    800028e6:	bf4d                	j	80002898 <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    800028e8:	00000097          	auipc	ra,0x0
    800028ec:	ecc080e7          	jalr	-308(ra) # 800027b4 <devintr>
    800028f0:	892a                	mv	s2,a0
    800028f2:	c501                	beqz	a0,800028fa <usertrap+0xa4>
  if(p->killed)
    800028f4:	549c                	lw	a5,40(s1)
    800028f6:	c3a1                	beqz	a5,80002936 <usertrap+0xe0>
    800028f8:	a815                	j	8000292c <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    800028fa:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    800028fe:	5890                	lw	a2,48(s1)
    80002900:	00006517          	auipc	a0,0x6
    80002904:	a2050513          	addi	a0,a0,-1504 # 80008320 <states.0+0x78>
    80002908:	ffffe097          	auipc	ra,0xffffe
    8000290c:	c7a080e7          	jalr	-902(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002910:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80002914:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80002918:	00006517          	auipc	a0,0x6
    8000291c:	a3850513          	addi	a0,a0,-1480 # 80008350 <states.0+0xa8>
    80002920:	ffffe097          	auipc	ra,0xffffe
    80002924:	c62080e7          	jalr	-926(ra) # 80000582 <printf>
    p->killed = 1;
    80002928:	4785                	li	a5,1
    8000292a:	d49c                	sw	a5,40(s1)
    exit(-1);
    8000292c:	557d                	li	a0,-1
    8000292e:	00000097          	auipc	ra,0x0
    80002932:	a54080e7          	jalr	-1452(ra) # 80002382 <exit>
  if(which_dev == 2)
    80002936:	4789                	li	a5,2
    80002938:	f8f910e3          	bne	s2,a5,800028b8 <usertrap+0x62>
    yield();
    8000293c:	fffff097          	auipc	ra,0xfffff
    80002940:	7ae080e7          	jalr	1966(ra) # 800020ea <yield>
    80002944:	bf95                	j	800028b8 <usertrap+0x62>
  int which_dev = 0;
    80002946:	4901                	li	s2,0
    80002948:	b7d5                	j	8000292c <usertrap+0xd6>

000000008000294a <kerneltrap>:
{
    8000294a:	7179                	addi	sp,sp,-48
    8000294c:	f406                	sd	ra,40(sp)
    8000294e:	f022                	sd	s0,32(sp)
    80002950:	ec26                	sd	s1,24(sp)
    80002952:	e84a                	sd	s2,16(sp)
    80002954:	e44e                	sd	s3,8(sp)
    80002956:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80002958:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000295c:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80002960:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80002964:	1004f793          	andi	a5,s1,256
    80002968:	cb85                	beqz	a5,80002998 <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000296a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000296e:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80002970:	ef85                	bnez	a5,800029a8 <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80002972:	00000097          	auipc	ra,0x0
    80002976:	e42080e7          	jalr	-446(ra) # 800027b4 <devintr>
    8000297a:	cd1d                	beqz	a0,800029b8 <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    8000297c:	4789                	li	a5,2
    8000297e:	06f50a63          	beq	a0,a5,800029f2 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80002982:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80002986:	10049073          	csrw	sstatus,s1
}
    8000298a:	70a2                	ld	ra,40(sp)
    8000298c:	7402                	ld	s0,32(sp)
    8000298e:	64e2                	ld	s1,24(sp)
    80002990:	6942                	ld	s2,16(sp)
    80002992:	69a2                	ld	s3,8(sp)
    80002994:	6145                	addi	sp,sp,48
    80002996:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80002998:	00006517          	auipc	a0,0x6
    8000299c:	9d850513          	addi	a0,a0,-1576 # 80008370 <states.0+0xc8>
    800029a0:	ffffe097          	auipc	ra,0xffffe
    800029a4:	b98080e7          	jalr	-1128(ra) # 80000538 <panic>
    panic("kerneltrap: interrupts enabled");
    800029a8:	00006517          	auipc	a0,0x6
    800029ac:	9f050513          	addi	a0,a0,-1552 # 80008398 <states.0+0xf0>
    800029b0:	ffffe097          	auipc	ra,0xffffe
    800029b4:	b88080e7          	jalr	-1144(ra) # 80000538 <panic>
    printf("scause %p\n", scause);
    800029b8:	85ce                	mv	a1,s3
    800029ba:	00006517          	auipc	a0,0x6
    800029be:	9fe50513          	addi	a0,a0,-1538 # 800083b8 <states.0+0x110>
    800029c2:	ffffe097          	auipc	ra,0xffffe
    800029c6:	bc0080e7          	jalr	-1088(ra) # 80000582 <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    800029ca:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    800029ce:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    800029d2:	00006517          	auipc	a0,0x6
    800029d6:	9f650513          	addi	a0,a0,-1546 # 800083c8 <states.0+0x120>
    800029da:	ffffe097          	auipc	ra,0xffffe
    800029de:	ba8080e7          	jalr	-1112(ra) # 80000582 <printf>
    panic("kerneltrap");
    800029e2:	00006517          	auipc	a0,0x6
    800029e6:	9fe50513          	addi	a0,a0,-1538 # 800083e0 <states.0+0x138>
    800029ea:	ffffe097          	auipc	ra,0xffffe
    800029ee:	b4e080e7          	jalr	-1202(ra) # 80000538 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    800029f2:	fffff097          	auipc	ra,0xfffff
    800029f6:	074080e7          	jalr	116(ra) # 80001a66 <myproc>
    800029fa:	d541                	beqz	a0,80002982 <kerneltrap+0x38>
    800029fc:	fffff097          	auipc	ra,0xfffff
    80002a00:	06a080e7          	jalr	106(ra) # 80001a66 <myproc>
    80002a04:	4d18                	lw	a4,24(a0)
    80002a06:	4791                	li	a5,4
    80002a08:	f6f71de3          	bne	a4,a5,80002982 <kerneltrap+0x38>
    yield();
    80002a0c:	fffff097          	auipc	ra,0xfffff
    80002a10:	6de080e7          	jalr	1758(ra) # 800020ea <yield>
    80002a14:	b7bd                	j	80002982 <kerneltrap+0x38>

0000000080002a16 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80002a16:	1101                	addi	sp,sp,-32
    80002a18:	ec06                	sd	ra,24(sp)
    80002a1a:	e822                	sd	s0,16(sp)
    80002a1c:	e426                	sd	s1,8(sp)
    80002a1e:	1000                	addi	s0,sp,32
    80002a20:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80002a22:	fffff097          	auipc	ra,0xfffff
    80002a26:	044080e7          	jalr	68(ra) # 80001a66 <myproc>
  switch (n) {
    80002a2a:	4795                	li	a5,5
    80002a2c:	0497e163          	bltu	a5,s1,80002a6e <argraw+0x58>
    80002a30:	048a                	slli	s1,s1,0x2
    80002a32:	00006717          	auipc	a4,0x6
    80002a36:	9e670713          	addi	a4,a4,-1562 # 80008418 <states.0+0x170>
    80002a3a:	94ba                	add	s1,s1,a4
    80002a3c:	409c                	lw	a5,0(s1)
    80002a3e:	97ba                	add	a5,a5,a4
    80002a40:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80002a42:	6d3c                	ld	a5,88(a0)
    80002a44:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80002a46:	60e2                	ld	ra,24(sp)
    80002a48:	6442                	ld	s0,16(sp)
    80002a4a:	64a2                	ld	s1,8(sp)
    80002a4c:	6105                	addi	sp,sp,32
    80002a4e:	8082                	ret
    return p->trapframe->a1;
    80002a50:	6d3c                	ld	a5,88(a0)
    80002a52:	7fa8                	ld	a0,120(a5)
    80002a54:	bfcd                	j	80002a46 <argraw+0x30>
    return p->trapframe->a2;
    80002a56:	6d3c                	ld	a5,88(a0)
    80002a58:	63c8                	ld	a0,128(a5)
    80002a5a:	b7f5                	j	80002a46 <argraw+0x30>
    return p->trapframe->a3;
    80002a5c:	6d3c                	ld	a5,88(a0)
    80002a5e:	67c8                	ld	a0,136(a5)
    80002a60:	b7dd                	j	80002a46 <argraw+0x30>
    return p->trapframe->a4;
    80002a62:	6d3c                	ld	a5,88(a0)
    80002a64:	6bc8                	ld	a0,144(a5)
    80002a66:	b7c5                	j	80002a46 <argraw+0x30>
    return p->trapframe->a5;
    80002a68:	6d3c                	ld	a5,88(a0)
    80002a6a:	6fc8                	ld	a0,152(a5)
    80002a6c:	bfe9                	j	80002a46 <argraw+0x30>
  panic("argraw");
    80002a6e:	00006517          	auipc	a0,0x6
    80002a72:	98250513          	addi	a0,a0,-1662 # 800083f0 <states.0+0x148>
    80002a76:	ffffe097          	auipc	ra,0xffffe
    80002a7a:	ac2080e7          	jalr	-1342(ra) # 80000538 <panic>

0000000080002a7e <fetchaddr>:
{
    80002a7e:	1101                	addi	sp,sp,-32
    80002a80:	ec06                	sd	ra,24(sp)
    80002a82:	e822                	sd	s0,16(sp)
    80002a84:	e426                	sd	s1,8(sp)
    80002a86:	e04a                	sd	s2,0(sp)
    80002a88:	1000                	addi	s0,sp,32
    80002a8a:	84aa                	mv	s1,a0
    80002a8c:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80002a8e:	fffff097          	auipc	ra,0xfffff
    80002a92:	fd8080e7          	jalr	-40(ra) # 80001a66 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80002a96:	653c                	ld	a5,72(a0)
    80002a98:	02f4f863          	bgeu	s1,a5,80002ac8 <fetchaddr+0x4a>
    80002a9c:	00848713          	addi	a4,s1,8
    80002aa0:	02e7e663          	bltu	a5,a4,80002acc <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80002aa4:	46a1                	li	a3,8
    80002aa6:	8626                	mv	a2,s1
    80002aa8:	85ca                	mv	a1,s2
    80002aaa:	6928                	ld	a0,80(a0)
    80002aac:	fffff097          	auipc	ra,0xfffff
    80002ab0:	c2c080e7          	jalr	-980(ra) # 800016d8 <copyin>
    80002ab4:	00a03533          	snez	a0,a0
    80002ab8:	40a00533          	neg	a0,a0
}
    80002abc:	60e2                	ld	ra,24(sp)
    80002abe:	6442                	ld	s0,16(sp)
    80002ac0:	64a2                	ld	s1,8(sp)
    80002ac2:	6902                	ld	s2,0(sp)
    80002ac4:	6105                	addi	sp,sp,32
    80002ac6:	8082                	ret
    return -1;
    80002ac8:	557d                	li	a0,-1
    80002aca:	bfcd                	j	80002abc <fetchaddr+0x3e>
    80002acc:	557d                	li	a0,-1
    80002ace:	b7fd                	j	80002abc <fetchaddr+0x3e>

0000000080002ad0 <fetchstr>:
{
    80002ad0:	7179                	addi	sp,sp,-48
    80002ad2:	f406                	sd	ra,40(sp)
    80002ad4:	f022                	sd	s0,32(sp)
    80002ad6:	ec26                	sd	s1,24(sp)
    80002ad8:	e84a                	sd	s2,16(sp)
    80002ada:	e44e                	sd	s3,8(sp)
    80002adc:	1800                	addi	s0,sp,48
    80002ade:	892a                	mv	s2,a0
    80002ae0:	84ae                	mv	s1,a1
    80002ae2:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80002ae4:	fffff097          	auipc	ra,0xfffff
    80002ae8:	f82080e7          	jalr	-126(ra) # 80001a66 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80002aec:	86ce                	mv	a3,s3
    80002aee:	864a                	mv	a2,s2
    80002af0:	85a6                	mv	a1,s1
    80002af2:	6928                	ld	a0,80(a0)
    80002af4:	fffff097          	auipc	ra,0xfffff
    80002af8:	d4c080e7          	jalr	-692(ra) # 80001840 <copyinstr>
  if(err < 0)
    80002afc:	00054763          	bltz	a0,80002b0a <fetchstr+0x3a>
  return strlen(buf);
    80002b00:	8526                	mv	a0,s1
    80002b02:	ffffe097          	auipc	ra,0xffffe
    80002b06:	34e080e7          	jalr	846(ra) # 80000e50 <strlen>
}
    80002b0a:	70a2                	ld	ra,40(sp)
    80002b0c:	7402                	ld	s0,32(sp)
    80002b0e:	64e2                	ld	s1,24(sp)
    80002b10:	6942                	ld	s2,16(sp)
    80002b12:	69a2                	ld	s3,8(sp)
    80002b14:	6145                	addi	sp,sp,48
    80002b16:	8082                	ret

0000000080002b18 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80002b18:	1101                	addi	sp,sp,-32
    80002b1a:	ec06                	sd	ra,24(sp)
    80002b1c:	e822                	sd	s0,16(sp)
    80002b1e:	e426                	sd	s1,8(sp)
    80002b20:	1000                	addi	s0,sp,32
    80002b22:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002b24:	00000097          	auipc	ra,0x0
    80002b28:	ef2080e7          	jalr	-270(ra) # 80002a16 <argraw>
    80002b2c:	c088                	sw	a0,0(s1)
  return 0;
}
    80002b2e:	4501                	li	a0,0
    80002b30:	60e2                	ld	ra,24(sp)
    80002b32:	6442                	ld	s0,16(sp)
    80002b34:	64a2                	ld	s1,8(sp)
    80002b36:	6105                	addi	sp,sp,32
    80002b38:	8082                	ret

0000000080002b3a <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80002b3a:	1101                	addi	sp,sp,-32
    80002b3c:	ec06                	sd	ra,24(sp)
    80002b3e:	e822                	sd	s0,16(sp)
    80002b40:	e426                	sd	s1,8(sp)
    80002b42:	1000                	addi	s0,sp,32
    80002b44:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80002b46:	00000097          	auipc	ra,0x0
    80002b4a:	ed0080e7          	jalr	-304(ra) # 80002a16 <argraw>
    80002b4e:	e088                	sd	a0,0(s1)
  return 0;
}
    80002b50:	4501                	li	a0,0
    80002b52:	60e2                	ld	ra,24(sp)
    80002b54:	6442                	ld	s0,16(sp)
    80002b56:	64a2                	ld	s1,8(sp)
    80002b58:	6105                	addi	sp,sp,32
    80002b5a:	8082                	ret

0000000080002b5c <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80002b5c:	1101                	addi	sp,sp,-32
    80002b5e:	ec06                	sd	ra,24(sp)
    80002b60:	e822                	sd	s0,16(sp)
    80002b62:	e426                	sd	s1,8(sp)
    80002b64:	e04a                	sd	s2,0(sp)
    80002b66:	1000                	addi	s0,sp,32
    80002b68:	84ae                	mv	s1,a1
    80002b6a:	8932                	mv	s2,a2
  *ip = argraw(n);
    80002b6c:	00000097          	auipc	ra,0x0
    80002b70:	eaa080e7          	jalr	-342(ra) # 80002a16 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80002b74:	864a                	mv	a2,s2
    80002b76:	85a6                	mv	a1,s1
    80002b78:	00000097          	auipc	ra,0x0
    80002b7c:	f58080e7          	jalr	-168(ra) # 80002ad0 <fetchstr>
}
    80002b80:	60e2                	ld	ra,24(sp)
    80002b82:	6442                	ld	s0,16(sp)
    80002b84:	64a2                	ld	s1,8(sp)
    80002b86:	6902                	ld	s2,0(sp)
    80002b88:	6105                	addi	sp,sp,32
    80002b8a:	8082                	ret

0000000080002b8c <syscall>:
[SYS_ringbuf] sys_ringbuf,
};

void
syscall(void)
{
    80002b8c:	1101                	addi	sp,sp,-32
    80002b8e:	ec06                	sd	ra,24(sp)
    80002b90:	e822                	sd	s0,16(sp)
    80002b92:	e426                	sd	s1,8(sp)
    80002b94:	e04a                	sd	s2,0(sp)
    80002b96:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80002b98:	fffff097          	auipc	ra,0xfffff
    80002b9c:	ece080e7          	jalr	-306(ra) # 80001a66 <myproc>
    80002ba0:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80002ba2:	05853903          	ld	s2,88(a0)
    80002ba6:	0a893783          	ld	a5,168(s2)
    80002baa:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80002bae:	37fd                	addiw	a5,a5,-1
    80002bb0:	4755                	li	a4,21
    80002bb2:	00f76f63          	bltu	a4,a5,80002bd0 <syscall+0x44>
    80002bb6:	00369713          	slli	a4,a3,0x3
    80002bba:	00006797          	auipc	a5,0x6
    80002bbe:	87678793          	addi	a5,a5,-1930 # 80008430 <syscalls>
    80002bc2:	97ba                	add	a5,a5,a4
    80002bc4:	639c                	ld	a5,0(a5)
    80002bc6:	c789                	beqz	a5,80002bd0 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80002bc8:	9782                	jalr	a5
    80002bca:	06a93823          	sd	a0,112(s2)
    80002bce:	a839                	j	80002bec <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80002bd0:	15848613          	addi	a2,s1,344
    80002bd4:	588c                	lw	a1,48(s1)
    80002bd6:	00006517          	auipc	a0,0x6
    80002bda:	82250513          	addi	a0,a0,-2014 # 800083f8 <states.0+0x150>
    80002bde:	ffffe097          	auipc	ra,0xffffe
    80002be2:	9a4080e7          	jalr	-1628(ra) # 80000582 <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80002be6:	6cbc                	ld	a5,88(s1)
    80002be8:	577d                	li	a4,-1
    80002bea:	fbb8                	sd	a4,112(a5)
  }
}
    80002bec:	60e2                	ld	ra,24(sp)
    80002bee:	6442                	ld	s0,16(sp)
    80002bf0:	64a2                	ld	s1,8(sp)
    80002bf2:	6902                	ld	s2,0(sp)
    80002bf4:	6105                	addi	sp,sp,32
    80002bf6:	8082                	ret

0000000080002bf8 <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80002bf8:	1101                	addi	sp,sp,-32
    80002bfa:	ec06                	sd	ra,24(sp)
    80002bfc:	e822                	sd	s0,16(sp)
    80002bfe:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80002c00:	fec40593          	addi	a1,s0,-20
    80002c04:	4501                	li	a0,0
    80002c06:	00000097          	auipc	ra,0x0
    80002c0a:	f12080e7          	jalr	-238(ra) # 80002b18 <argint>
    return -1;
    80002c0e:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002c10:	00054963          	bltz	a0,80002c22 <sys_exit+0x2a>
  exit(n);
    80002c14:	fec42503          	lw	a0,-20(s0)
    80002c18:	fffff097          	auipc	ra,0xfffff
    80002c1c:	76a080e7          	jalr	1898(ra) # 80002382 <exit>
  return 0;  // not reached
    80002c20:	4781                	li	a5,0
}
    80002c22:	853e                	mv	a0,a5
    80002c24:	60e2                	ld	ra,24(sp)
    80002c26:	6442                	ld	s0,16(sp)
    80002c28:	6105                	addi	sp,sp,32
    80002c2a:	8082                	ret

0000000080002c2c <sys_getpid>:

uint64
sys_getpid(void)
{
    80002c2c:	1141                	addi	sp,sp,-16
    80002c2e:	e406                	sd	ra,8(sp)
    80002c30:	e022                	sd	s0,0(sp)
    80002c32:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002c34:	fffff097          	auipc	ra,0xfffff
    80002c38:	e32080e7          	jalr	-462(ra) # 80001a66 <myproc>
}
    80002c3c:	5908                	lw	a0,48(a0)
    80002c3e:	60a2                	ld	ra,8(sp)
    80002c40:	6402                	ld	s0,0(sp)
    80002c42:	0141                	addi	sp,sp,16
    80002c44:	8082                	ret

0000000080002c46 <sys_fork>:

uint64
sys_fork(void)
{
    80002c46:	1141                	addi	sp,sp,-16
    80002c48:	e406                	sd	ra,8(sp)
    80002c4a:	e022                	sd	s0,0(sp)
    80002c4c:	0800                	addi	s0,sp,16
  return fork();
    80002c4e:	fffff097          	auipc	ra,0xfffff
    80002c52:	1e6080e7          	jalr	486(ra) # 80001e34 <fork>
}
    80002c56:	60a2                	ld	ra,8(sp)
    80002c58:	6402                	ld	s0,0(sp)
    80002c5a:	0141                	addi	sp,sp,16
    80002c5c:	8082                	ret

0000000080002c5e <sys_wait>:

uint64
sys_wait(void)
{
    80002c5e:	1101                	addi	sp,sp,-32
    80002c60:	ec06                	sd	ra,24(sp)
    80002c62:	e822                	sd	s0,16(sp)
    80002c64:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002c66:	fe840593          	addi	a1,s0,-24
    80002c6a:	4501                	li	a0,0
    80002c6c:	00000097          	auipc	ra,0x0
    80002c70:	ece080e7          	jalr	-306(ra) # 80002b3a <argaddr>
    80002c74:	87aa                	mv	a5,a0
    return -1;
    80002c76:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    80002c78:	0007c863          	bltz	a5,80002c88 <sys_wait+0x2a>
  return wait(p);
    80002c7c:	fe843503          	ld	a0,-24(s0)
    80002c80:	fffff097          	auipc	ra,0xfffff
    80002c84:	50a080e7          	jalr	1290(ra) # 8000218a <wait>
}
    80002c88:	60e2                	ld	ra,24(sp)
    80002c8a:	6442                	ld	s0,16(sp)
    80002c8c:	6105                	addi	sp,sp,32
    80002c8e:	8082                	ret

0000000080002c90 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002c90:	7179                	addi	sp,sp,-48
    80002c92:	f406                	sd	ra,40(sp)
    80002c94:	f022                	sd	s0,32(sp)
    80002c96:	ec26                	sd	s1,24(sp)
    80002c98:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    80002c9a:	fdc40593          	addi	a1,s0,-36
    80002c9e:	4501                	li	a0,0
    80002ca0:	00000097          	auipc	ra,0x0
    80002ca4:	e78080e7          	jalr	-392(ra) # 80002b18 <argint>
    return -1;
    80002ca8:	54fd                	li	s1,-1
  if(argint(0, &n) < 0)
    80002caa:	00054f63          	bltz	a0,80002cc8 <sys_sbrk+0x38>
  addr = myproc()->sz;
    80002cae:	fffff097          	auipc	ra,0xfffff
    80002cb2:	db8080e7          	jalr	-584(ra) # 80001a66 <myproc>
    80002cb6:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    80002cb8:	fdc42503          	lw	a0,-36(s0)
    80002cbc:	fffff097          	auipc	ra,0xfffff
    80002cc0:	104080e7          	jalr	260(ra) # 80001dc0 <growproc>
    80002cc4:	00054863          	bltz	a0,80002cd4 <sys_sbrk+0x44>
    return -1;
  return addr;
}
    80002cc8:	8526                	mv	a0,s1
    80002cca:	70a2                	ld	ra,40(sp)
    80002ccc:	7402                	ld	s0,32(sp)
    80002cce:	64e2                	ld	s1,24(sp)
    80002cd0:	6145                	addi	sp,sp,48
    80002cd2:	8082                	ret
    return -1;
    80002cd4:	54fd                	li	s1,-1
    80002cd6:	bfcd                	j	80002cc8 <sys_sbrk+0x38>

0000000080002cd8 <sys_sleep>:

uint64
sys_sleep(void)
{
    80002cd8:	7139                	addi	sp,sp,-64
    80002cda:	fc06                	sd	ra,56(sp)
    80002cdc:	f822                	sd	s0,48(sp)
    80002cde:	f426                	sd	s1,40(sp)
    80002ce0:	f04a                	sd	s2,32(sp)
    80002ce2:	ec4e                	sd	s3,24(sp)
    80002ce4:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    80002ce6:	fcc40593          	addi	a1,s0,-52
    80002cea:	4501                	li	a0,0
    80002cec:	00000097          	auipc	ra,0x0
    80002cf0:	e2c080e7          	jalr	-468(ra) # 80002b18 <argint>
    return -1;
    80002cf4:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80002cf6:	06054563          	bltz	a0,80002d60 <sys_sleep+0x88>
  acquire(&tickslock);
    80002cfa:	00014517          	auipc	a0,0x14
    80002cfe:	3d650513          	addi	a0,a0,982 # 800170d0 <tickslock>
    80002d02:	ffffe097          	auipc	ra,0xffffe
    80002d06:	ece080e7          	jalr	-306(ra) # 80000bd0 <acquire>
  ticks0 = ticks;
    80002d0a:	00006917          	auipc	s2,0x6
    80002d0e:	32692903          	lw	s2,806(s2) # 80009030 <ticks>
  while(ticks - ticks0 < n){
    80002d12:	fcc42783          	lw	a5,-52(s0)
    80002d16:	cf85                	beqz	a5,80002d4e <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    80002d18:	00014997          	auipc	s3,0x14
    80002d1c:	3b898993          	addi	s3,s3,952 # 800170d0 <tickslock>
    80002d20:	00006497          	auipc	s1,0x6
    80002d24:	31048493          	addi	s1,s1,784 # 80009030 <ticks>
    if(myproc()->killed){
    80002d28:	fffff097          	auipc	ra,0xfffff
    80002d2c:	d3e080e7          	jalr	-706(ra) # 80001a66 <myproc>
    80002d30:	551c                	lw	a5,40(a0)
    80002d32:	ef9d                	bnez	a5,80002d70 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002d34:	85ce                	mv	a1,s3
    80002d36:	8526                	mv	a0,s1
    80002d38:	fffff097          	auipc	ra,0xfffff
    80002d3c:	3ee080e7          	jalr	1006(ra) # 80002126 <sleep>
  while(ticks - ticks0 < n){
    80002d40:	409c                	lw	a5,0(s1)
    80002d42:	412787bb          	subw	a5,a5,s2
    80002d46:	fcc42703          	lw	a4,-52(s0)
    80002d4a:	fce7efe3          	bltu	a5,a4,80002d28 <sys_sleep+0x50>
  }
  release(&tickslock);
    80002d4e:	00014517          	auipc	a0,0x14
    80002d52:	38250513          	addi	a0,a0,898 # 800170d0 <tickslock>
    80002d56:	ffffe097          	auipc	ra,0xffffe
    80002d5a:	f2e080e7          	jalr	-210(ra) # 80000c84 <release>
  return 0;
    80002d5e:	4781                	li	a5,0
}
    80002d60:	853e                	mv	a0,a5
    80002d62:	70e2                	ld	ra,56(sp)
    80002d64:	7442                	ld	s0,48(sp)
    80002d66:	74a2                	ld	s1,40(sp)
    80002d68:	7902                	ld	s2,32(sp)
    80002d6a:	69e2                	ld	s3,24(sp)
    80002d6c:	6121                	addi	sp,sp,64
    80002d6e:	8082                	ret
      release(&tickslock);
    80002d70:	00014517          	auipc	a0,0x14
    80002d74:	36050513          	addi	a0,a0,864 # 800170d0 <tickslock>
    80002d78:	ffffe097          	auipc	ra,0xffffe
    80002d7c:	f0c080e7          	jalr	-244(ra) # 80000c84 <release>
      return -1;
    80002d80:	57fd                	li	a5,-1
    80002d82:	bff9                	j	80002d60 <sys_sleep+0x88>

0000000080002d84 <sys_kill>:

uint64
sys_kill(void)
{
    80002d84:	1101                	addi	sp,sp,-32
    80002d86:	ec06                	sd	ra,24(sp)
    80002d88:	e822                	sd	s0,16(sp)
    80002d8a:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002d8c:	fec40593          	addi	a1,s0,-20
    80002d90:	4501                	li	a0,0
    80002d92:	00000097          	auipc	ra,0x0
    80002d96:	d86080e7          	jalr	-634(ra) # 80002b18 <argint>
    80002d9a:	87aa                	mv	a5,a0
    return -1;
    80002d9c:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002d9e:	0007c863          	bltz	a5,80002dae <sys_kill+0x2a>
  return kill(pid);
    80002da2:	fec42503          	lw	a0,-20(s0)
    80002da6:	fffff097          	auipc	ra,0xfffff
    80002daa:	6b2080e7          	jalr	1714(ra) # 80002458 <kill>
}
    80002dae:	60e2                	ld	ra,24(sp)
    80002db0:	6442                	ld	s0,16(sp)
    80002db2:	6105                	addi	sp,sp,32
    80002db4:	8082                	ret

0000000080002db6 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    80002db6:	1101                	addi	sp,sp,-32
    80002db8:	ec06                	sd	ra,24(sp)
    80002dba:	e822                	sd	s0,16(sp)
    80002dbc:	e426                	sd	s1,8(sp)
    80002dbe:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    80002dc0:	00014517          	auipc	a0,0x14
    80002dc4:	31050513          	addi	a0,a0,784 # 800170d0 <tickslock>
    80002dc8:	ffffe097          	auipc	ra,0xffffe
    80002dcc:	e08080e7          	jalr	-504(ra) # 80000bd0 <acquire>
  xticks = ticks;
    80002dd0:	00006497          	auipc	s1,0x6
    80002dd4:	2604a483          	lw	s1,608(s1) # 80009030 <ticks>
  release(&tickslock);
    80002dd8:	00014517          	auipc	a0,0x14
    80002ddc:	2f850513          	addi	a0,a0,760 # 800170d0 <tickslock>
    80002de0:	ffffe097          	auipc	ra,0xffffe
    80002de4:	ea4080e7          	jalr	-348(ra) # 80000c84 <release>
  return xticks;
}
    80002de8:	02049513          	slli	a0,s1,0x20
    80002dec:	9101                	srli	a0,a0,0x20
    80002dee:	60e2                	ld	ra,24(sp)
    80002df0:	6442                	ld	s0,16(sp)
    80002df2:	64a2                	ld	s1,8(sp)
    80002df4:	6105                	addi	sp,sp,32
    80002df6:	8082                	ret

0000000080002df8 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    80002df8:	7179                	addi	sp,sp,-48
    80002dfa:	f406                	sd	ra,40(sp)
    80002dfc:	f022                	sd	s0,32(sp)
    80002dfe:	ec26                	sd	s1,24(sp)
    80002e00:	e84a                	sd	s2,16(sp)
    80002e02:	e44e                	sd	s3,8(sp)
    80002e04:	e052                	sd	s4,0(sp)
    80002e06:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    80002e08:	00005597          	auipc	a1,0x5
    80002e0c:	6e058593          	addi	a1,a1,1760 # 800084e8 <syscalls+0xb8>
    80002e10:	00014517          	auipc	a0,0x14
    80002e14:	2d850513          	addi	a0,a0,728 # 800170e8 <bcache>
    80002e18:	ffffe097          	auipc	ra,0xffffe
    80002e1c:	d28080e7          	jalr	-728(ra) # 80000b40 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002e20:	0001c797          	auipc	a5,0x1c
    80002e24:	2c878793          	addi	a5,a5,712 # 8001f0e8 <bcache+0x8000>
    80002e28:	0001c717          	auipc	a4,0x1c
    80002e2c:	52870713          	addi	a4,a4,1320 # 8001f350 <bcache+0x8268>
    80002e30:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002e34:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002e38:	00014497          	auipc	s1,0x14
    80002e3c:	2c848493          	addi	s1,s1,712 # 80017100 <bcache+0x18>
    b->next = bcache.head.next;
    80002e40:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002e42:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002e44:	00005a17          	auipc	s4,0x5
    80002e48:	6aca0a13          	addi	s4,s4,1708 # 800084f0 <syscalls+0xc0>
    b->next = bcache.head.next;
    80002e4c:	2b893783          	ld	a5,696(s2)
    80002e50:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002e52:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    80002e56:	85d2                	mv	a1,s4
    80002e58:	01048513          	addi	a0,s1,16
    80002e5c:	00001097          	auipc	ra,0x1
    80002e60:	4c2080e7          	jalr	1218(ra) # 8000431e <initsleeplock>
    bcache.head.next->prev = b;
    80002e64:	2b893783          	ld	a5,696(s2)
    80002e68:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    80002e6a:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002e6e:	45848493          	addi	s1,s1,1112
    80002e72:	fd349de3          	bne	s1,s3,80002e4c <binit+0x54>
  }
}
    80002e76:	70a2                	ld	ra,40(sp)
    80002e78:	7402                	ld	s0,32(sp)
    80002e7a:	64e2                	ld	s1,24(sp)
    80002e7c:	6942                	ld	s2,16(sp)
    80002e7e:	69a2                	ld	s3,8(sp)
    80002e80:	6a02                	ld	s4,0(sp)
    80002e82:	6145                	addi	sp,sp,48
    80002e84:	8082                	ret

0000000080002e86 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    80002e86:	7179                	addi	sp,sp,-48
    80002e88:	f406                	sd	ra,40(sp)
    80002e8a:	f022                	sd	s0,32(sp)
    80002e8c:	ec26                	sd	s1,24(sp)
    80002e8e:	e84a                	sd	s2,16(sp)
    80002e90:	e44e                	sd	s3,8(sp)
    80002e92:	1800                	addi	s0,sp,48
    80002e94:	892a                	mv	s2,a0
    80002e96:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    80002e98:	00014517          	auipc	a0,0x14
    80002e9c:	25050513          	addi	a0,a0,592 # 800170e8 <bcache>
    80002ea0:	ffffe097          	auipc	ra,0xffffe
    80002ea4:	d30080e7          	jalr	-720(ra) # 80000bd0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    80002ea8:	0001c497          	auipc	s1,0x1c
    80002eac:	4f84b483          	ld	s1,1272(s1) # 8001f3a0 <bcache+0x82b8>
    80002eb0:	0001c797          	auipc	a5,0x1c
    80002eb4:	4a078793          	addi	a5,a5,1184 # 8001f350 <bcache+0x8268>
    80002eb8:	02f48f63          	beq	s1,a5,80002ef6 <bread+0x70>
    80002ebc:	873e                	mv	a4,a5
    80002ebe:	a021                	j	80002ec6 <bread+0x40>
    80002ec0:	68a4                	ld	s1,80(s1)
    80002ec2:	02e48a63          	beq	s1,a4,80002ef6 <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    80002ec6:	449c                	lw	a5,8(s1)
    80002ec8:	ff279ce3          	bne	a5,s2,80002ec0 <bread+0x3a>
    80002ecc:	44dc                	lw	a5,12(s1)
    80002ece:	ff3799e3          	bne	a5,s3,80002ec0 <bread+0x3a>
      b->refcnt++;
    80002ed2:	40bc                	lw	a5,64(s1)
    80002ed4:	2785                	addiw	a5,a5,1
    80002ed6:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002ed8:	00014517          	auipc	a0,0x14
    80002edc:	21050513          	addi	a0,a0,528 # 800170e8 <bcache>
    80002ee0:	ffffe097          	auipc	ra,0xffffe
    80002ee4:	da4080e7          	jalr	-604(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    80002ee8:	01048513          	addi	a0,s1,16
    80002eec:	00001097          	auipc	ra,0x1
    80002ef0:	46c080e7          	jalr	1132(ra) # 80004358 <acquiresleep>
      return b;
    80002ef4:	a8b9                	j	80002f52 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002ef6:	0001c497          	auipc	s1,0x1c
    80002efa:	4a24b483          	ld	s1,1186(s1) # 8001f398 <bcache+0x82b0>
    80002efe:	0001c797          	auipc	a5,0x1c
    80002f02:	45278793          	addi	a5,a5,1106 # 8001f350 <bcache+0x8268>
    80002f06:	00f48863          	beq	s1,a5,80002f16 <bread+0x90>
    80002f0a:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    80002f0c:	40bc                	lw	a5,64(s1)
    80002f0e:	cf81                	beqz	a5,80002f26 <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    80002f10:	64a4                	ld	s1,72(s1)
    80002f12:	fee49de3          	bne	s1,a4,80002f0c <bread+0x86>
  panic("bget: no buffers");
    80002f16:	00005517          	auipc	a0,0x5
    80002f1a:	5e250513          	addi	a0,a0,1506 # 800084f8 <syscalls+0xc8>
    80002f1e:	ffffd097          	auipc	ra,0xffffd
    80002f22:	61a080e7          	jalr	1562(ra) # 80000538 <panic>
      b->dev = dev;
    80002f26:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    80002f2a:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002f2e:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002f32:	4785                	li	a5,1
    80002f34:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    80002f36:	00014517          	auipc	a0,0x14
    80002f3a:	1b250513          	addi	a0,a0,434 # 800170e8 <bcache>
    80002f3e:	ffffe097          	auipc	ra,0xffffe
    80002f42:	d46080e7          	jalr	-698(ra) # 80000c84 <release>
      acquiresleep(&b->lock);
    80002f46:	01048513          	addi	a0,s1,16
    80002f4a:	00001097          	auipc	ra,0x1
    80002f4e:	40e080e7          	jalr	1038(ra) # 80004358 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002f52:	409c                	lw	a5,0(s1)
    80002f54:	cb89                	beqz	a5,80002f66 <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    80002f56:	8526                	mv	a0,s1
    80002f58:	70a2                	ld	ra,40(sp)
    80002f5a:	7402                	ld	s0,32(sp)
    80002f5c:	64e2                	ld	s1,24(sp)
    80002f5e:	6942                	ld	s2,16(sp)
    80002f60:	69a2                	ld	s3,8(sp)
    80002f62:	6145                	addi	sp,sp,48
    80002f64:	8082                	ret
    virtio_disk_rw(b, 0);
    80002f66:	4581                	li	a1,0
    80002f68:	8526                	mv	a0,s1
    80002f6a:	00003097          	auipc	ra,0x3
    80002f6e:	0d8080e7          	jalr	216(ra) # 80006042 <virtio_disk_rw>
    b->valid = 1;
    80002f72:	4785                	li	a5,1
    80002f74:	c09c                	sw	a5,0(s1)
  return b;
    80002f76:	b7c5                	j	80002f56 <bread+0xd0>

0000000080002f78 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    80002f78:	1101                	addi	sp,sp,-32
    80002f7a:	ec06                	sd	ra,24(sp)
    80002f7c:	e822                	sd	s0,16(sp)
    80002f7e:	e426                	sd	s1,8(sp)
    80002f80:	1000                	addi	s0,sp,32
    80002f82:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002f84:	0541                	addi	a0,a0,16
    80002f86:	00001097          	auipc	ra,0x1
    80002f8a:	46c080e7          	jalr	1132(ra) # 800043f2 <holdingsleep>
    80002f8e:	cd01                	beqz	a0,80002fa6 <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002f90:	4585                	li	a1,1
    80002f92:	8526                	mv	a0,s1
    80002f94:	00003097          	auipc	ra,0x3
    80002f98:	0ae080e7          	jalr	174(ra) # 80006042 <virtio_disk_rw>
}
    80002f9c:	60e2                	ld	ra,24(sp)
    80002f9e:	6442                	ld	s0,16(sp)
    80002fa0:	64a2                	ld	s1,8(sp)
    80002fa2:	6105                	addi	sp,sp,32
    80002fa4:	8082                	ret
    panic("bwrite");
    80002fa6:	00005517          	auipc	a0,0x5
    80002faa:	56a50513          	addi	a0,a0,1386 # 80008510 <syscalls+0xe0>
    80002fae:	ffffd097          	auipc	ra,0xffffd
    80002fb2:	58a080e7          	jalr	1418(ra) # 80000538 <panic>

0000000080002fb6 <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    80002fb6:	1101                	addi	sp,sp,-32
    80002fb8:	ec06                	sd	ra,24(sp)
    80002fba:	e822                	sd	s0,16(sp)
    80002fbc:	e426                	sd	s1,8(sp)
    80002fbe:	e04a                	sd	s2,0(sp)
    80002fc0:	1000                	addi	s0,sp,32
    80002fc2:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002fc4:	01050913          	addi	s2,a0,16
    80002fc8:	854a                	mv	a0,s2
    80002fca:	00001097          	auipc	ra,0x1
    80002fce:	428080e7          	jalr	1064(ra) # 800043f2 <holdingsleep>
    80002fd2:	c92d                	beqz	a0,80003044 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    80002fd4:	854a                	mv	a0,s2
    80002fd6:	00001097          	auipc	ra,0x1
    80002fda:	3d8080e7          	jalr	984(ra) # 800043ae <releasesleep>

  acquire(&bcache.lock);
    80002fde:	00014517          	auipc	a0,0x14
    80002fe2:	10a50513          	addi	a0,a0,266 # 800170e8 <bcache>
    80002fe6:	ffffe097          	auipc	ra,0xffffe
    80002fea:	bea080e7          	jalr	-1046(ra) # 80000bd0 <acquire>
  b->refcnt--;
    80002fee:	40bc                	lw	a5,64(s1)
    80002ff0:	37fd                	addiw	a5,a5,-1
    80002ff2:	0007871b          	sext.w	a4,a5
    80002ff6:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    80002ff8:	eb05                	bnez	a4,80003028 <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    80002ffa:	68bc                	ld	a5,80(s1)
    80002ffc:	64b8                	ld	a4,72(s1)
    80002ffe:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    80003000:	64bc                	ld	a5,72(s1)
    80003002:	68b8                	ld	a4,80(s1)
    80003004:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    80003006:	0001c797          	auipc	a5,0x1c
    8000300a:	0e278793          	addi	a5,a5,226 # 8001f0e8 <bcache+0x8000>
    8000300e:	2b87b703          	ld	a4,696(a5)
    80003012:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    80003014:	0001c717          	auipc	a4,0x1c
    80003018:	33c70713          	addi	a4,a4,828 # 8001f350 <bcache+0x8268>
    8000301c:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    8000301e:	2b87b703          	ld	a4,696(a5)
    80003022:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80003024:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    80003028:	00014517          	auipc	a0,0x14
    8000302c:	0c050513          	addi	a0,a0,192 # 800170e8 <bcache>
    80003030:	ffffe097          	auipc	ra,0xffffe
    80003034:	c54080e7          	jalr	-940(ra) # 80000c84 <release>
}
    80003038:	60e2                	ld	ra,24(sp)
    8000303a:	6442                	ld	s0,16(sp)
    8000303c:	64a2                	ld	s1,8(sp)
    8000303e:	6902                	ld	s2,0(sp)
    80003040:	6105                	addi	sp,sp,32
    80003042:	8082                	ret
    panic("brelse");
    80003044:	00005517          	auipc	a0,0x5
    80003048:	4d450513          	addi	a0,a0,1236 # 80008518 <syscalls+0xe8>
    8000304c:	ffffd097          	auipc	ra,0xffffd
    80003050:	4ec080e7          	jalr	1260(ra) # 80000538 <panic>

0000000080003054 <bpin>:

void
bpin(struct buf *b) {
    80003054:	1101                	addi	sp,sp,-32
    80003056:	ec06                	sd	ra,24(sp)
    80003058:	e822                	sd	s0,16(sp)
    8000305a:	e426                	sd	s1,8(sp)
    8000305c:	1000                	addi	s0,sp,32
    8000305e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80003060:	00014517          	auipc	a0,0x14
    80003064:	08850513          	addi	a0,a0,136 # 800170e8 <bcache>
    80003068:	ffffe097          	auipc	ra,0xffffe
    8000306c:	b68080e7          	jalr	-1176(ra) # 80000bd0 <acquire>
  b->refcnt++;
    80003070:	40bc                	lw	a5,64(s1)
    80003072:	2785                	addiw	a5,a5,1
    80003074:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80003076:	00014517          	auipc	a0,0x14
    8000307a:	07250513          	addi	a0,a0,114 # 800170e8 <bcache>
    8000307e:	ffffe097          	auipc	ra,0xffffe
    80003082:	c06080e7          	jalr	-1018(ra) # 80000c84 <release>
}
    80003086:	60e2                	ld	ra,24(sp)
    80003088:	6442                	ld	s0,16(sp)
    8000308a:	64a2                	ld	s1,8(sp)
    8000308c:	6105                	addi	sp,sp,32
    8000308e:	8082                	ret

0000000080003090 <bunpin>:

void
bunpin(struct buf *b) {
    80003090:	1101                	addi	sp,sp,-32
    80003092:	ec06                	sd	ra,24(sp)
    80003094:	e822                	sd	s0,16(sp)
    80003096:	e426                	sd	s1,8(sp)
    80003098:	1000                	addi	s0,sp,32
    8000309a:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    8000309c:	00014517          	auipc	a0,0x14
    800030a0:	04c50513          	addi	a0,a0,76 # 800170e8 <bcache>
    800030a4:	ffffe097          	auipc	ra,0xffffe
    800030a8:	b2c080e7          	jalr	-1236(ra) # 80000bd0 <acquire>
  b->refcnt--;
    800030ac:	40bc                	lw	a5,64(s1)
    800030ae:	37fd                	addiw	a5,a5,-1
    800030b0:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    800030b2:	00014517          	auipc	a0,0x14
    800030b6:	03650513          	addi	a0,a0,54 # 800170e8 <bcache>
    800030ba:	ffffe097          	auipc	ra,0xffffe
    800030be:	bca080e7          	jalr	-1078(ra) # 80000c84 <release>
}
    800030c2:	60e2                	ld	ra,24(sp)
    800030c4:	6442                	ld	s0,16(sp)
    800030c6:	64a2                	ld	s1,8(sp)
    800030c8:	6105                	addi	sp,sp,32
    800030ca:	8082                	ret

00000000800030cc <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800030cc:	1101                	addi	sp,sp,-32
    800030ce:	ec06                	sd	ra,24(sp)
    800030d0:	e822                	sd	s0,16(sp)
    800030d2:	e426                	sd	s1,8(sp)
    800030d4:	e04a                	sd	s2,0(sp)
    800030d6:	1000                	addi	s0,sp,32
    800030d8:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800030da:	00d5d59b          	srliw	a1,a1,0xd
    800030de:	0001c797          	auipc	a5,0x1c
    800030e2:	6e67a783          	lw	a5,1766(a5) # 8001f7c4 <sb+0x1c>
    800030e6:	9dbd                	addw	a1,a1,a5
    800030e8:	00000097          	auipc	ra,0x0
    800030ec:	d9e080e7          	jalr	-610(ra) # 80002e86 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800030f0:	0074f713          	andi	a4,s1,7
    800030f4:	4785                	li	a5,1
    800030f6:	00e797bb          	sllw	a5,a5,a4
  if((bp->data[bi/8] & m) == 0)
    800030fa:	14ce                	slli	s1,s1,0x33
    800030fc:	90d9                	srli	s1,s1,0x36
    800030fe:	00950733          	add	a4,a0,s1
    80003102:	05874703          	lbu	a4,88(a4)
    80003106:	00e7f6b3          	and	a3,a5,a4
    8000310a:	c69d                	beqz	a3,80003138 <bfree+0x6c>
    8000310c:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
    8000310e:	94aa                	add	s1,s1,a0
    80003110:	fff7c793          	not	a5,a5
    80003114:	8ff9                	and	a5,a5,a4
    80003116:	04f48c23          	sb	a5,88(s1)
  log_write(bp);
    8000311a:	00001097          	auipc	ra,0x1
    8000311e:	11e080e7          	jalr	286(ra) # 80004238 <log_write>
  brelse(bp);
    80003122:	854a                	mv	a0,s2
    80003124:	00000097          	auipc	ra,0x0
    80003128:	e92080e7          	jalr	-366(ra) # 80002fb6 <brelse>
}
    8000312c:	60e2                	ld	ra,24(sp)
    8000312e:	6442                	ld	s0,16(sp)
    80003130:	64a2                	ld	s1,8(sp)
    80003132:	6902                	ld	s2,0(sp)
    80003134:	6105                	addi	sp,sp,32
    80003136:	8082                	ret
    panic("freeing free block");
    80003138:	00005517          	auipc	a0,0x5
    8000313c:	3e850513          	addi	a0,a0,1000 # 80008520 <syscalls+0xf0>
    80003140:	ffffd097          	auipc	ra,0xffffd
    80003144:	3f8080e7          	jalr	1016(ra) # 80000538 <panic>

0000000080003148 <balloc>:
{
    80003148:	711d                	addi	sp,sp,-96
    8000314a:	ec86                	sd	ra,88(sp)
    8000314c:	e8a2                	sd	s0,80(sp)
    8000314e:	e4a6                	sd	s1,72(sp)
    80003150:	e0ca                	sd	s2,64(sp)
    80003152:	fc4e                	sd	s3,56(sp)
    80003154:	f852                	sd	s4,48(sp)
    80003156:	f456                	sd	s5,40(sp)
    80003158:	f05a                	sd	s6,32(sp)
    8000315a:	ec5e                	sd	s7,24(sp)
    8000315c:	e862                	sd	s8,16(sp)
    8000315e:	e466                	sd	s9,8(sp)
    80003160:	1080                	addi	s0,sp,96
  for(b = 0; b < sb.size; b += BPB){
    80003162:	0001c797          	auipc	a5,0x1c
    80003166:	64a7a783          	lw	a5,1610(a5) # 8001f7ac <sb+0x4>
    8000316a:	cbd1                	beqz	a5,800031fe <balloc+0xb6>
    8000316c:	8baa                	mv	s7,a0
    8000316e:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80003170:	0001cb17          	auipc	s6,0x1c
    80003174:	638b0b13          	addi	s6,s6,1592 # 8001f7a8 <sb>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    80003178:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000317a:	4985                	li	s3,1
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    8000317c:	6a09                	lui	s4,0x2
  for(b = 0; b < sb.size; b += BPB){
    8000317e:	6c89                	lui	s9,0x2
    80003180:	a831                	j	8000319c <balloc+0x54>
    brelse(bp);
    80003182:	854a                	mv	a0,s2
    80003184:	00000097          	auipc	ra,0x0
    80003188:	e32080e7          	jalr	-462(ra) # 80002fb6 <brelse>
  for(b = 0; b < sb.size; b += BPB){
    8000318c:	015c87bb          	addw	a5,s9,s5
    80003190:	00078a9b          	sext.w	s5,a5
    80003194:	004b2703          	lw	a4,4(s6)
    80003198:	06eaf363          	bgeu	s5,a4,800031fe <balloc+0xb6>
    bp = bread(dev, BBLOCK(b, sb));
    8000319c:	41fad79b          	sraiw	a5,s5,0x1f
    800031a0:	0137d79b          	srliw	a5,a5,0x13
    800031a4:	015787bb          	addw	a5,a5,s5
    800031a8:	40d7d79b          	sraiw	a5,a5,0xd
    800031ac:	01cb2583          	lw	a1,28(s6)
    800031b0:	9dbd                	addw	a1,a1,a5
    800031b2:	855e                	mv	a0,s7
    800031b4:	00000097          	auipc	ra,0x0
    800031b8:	cd2080e7          	jalr	-814(ra) # 80002e86 <bread>
    800031bc:	892a                	mv	s2,a0
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800031be:	004b2503          	lw	a0,4(s6)
    800031c2:	000a849b          	sext.w	s1,s5
    800031c6:	8662                	mv	a2,s8
    800031c8:	faa4fde3          	bgeu	s1,a0,80003182 <balloc+0x3a>
      m = 1 << (bi % 8);
    800031cc:	41f6579b          	sraiw	a5,a2,0x1f
    800031d0:	01d7d69b          	srliw	a3,a5,0x1d
    800031d4:	00c6873b          	addw	a4,a3,a2
    800031d8:	00777793          	andi	a5,a4,7
    800031dc:	9f95                	subw	a5,a5,a3
    800031de:	00f997bb          	sllw	a5,s3,a5
      if((bp->data[bi/8] & m) == 0){  // Is block free?
    800031e2:	4037571b          	sraiw	a4,a4,0x3
    800031e6:	00e906b3          	add	a3,s2,a4
    800031ea:	0586c683          	lbu	a3,88(a3)
    800031ee:	00d7f5b3          	and	a1,a5,a3
    800031f2:	cd91                	beqz	a1,8000320e <balloc+0xc6>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
    800031f4:	2605                	addiw	a2,a2,1
    800031f6:	2485                	addiw	s1,s1,1
    800031f8:	fd4618e3          	bne	a2,s4,800031c8 <balloc+0x80>
    800031fc:	b759                	j	80003182 <balloc+0x3a>
  panic("balloc: out of blocks");
    800031fe:	00005517          	auipc	a0,0x5
    80003202:	33a50513          	addi	a0,a0,826 # 80008538 <syscalls+0x108>
    80003206:	ffffd097          	auipc	ra,0xffffd
    8000320a:	332080e7          	jalr	818(ra) # 80000538 <panic>
        bp->data[bi/8] |= m;  // Mark block in use.
    8000320e:	974a                	add	a4,a4,s2
    80003210:	8fd5                	or	a5,a5,a3
    80003212:	04f70c23          	sb	a5,88(a4)
        log_write(bp);
    80003216:	854a                	mv	a0,s2
    80003218:	00001097          	auipc	ra,0x1
    8000321c:	020080e7          	jalr	32(ra) # 80004238 <log_write>
        brelse(bp);
    80003220:	854a                	mv	a0,s2
    80003222:	00000097          	auipc	ra,0x0
    80003226:	d94080e7          	jalr	-620(ra) # 80002fb6 <brelse>
  bp = bread(dev, bno);
    8000322a:	85a6                	mv	a1,s1
    8000322c:	855e                	mv	a0,s7
    8000322e:	00000097          	auipc	ra,0x0
    80003232:	c58080e7          	jalr	-936(ra) # 80002e86 <bread>
    80003236:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80003238:	40000613          	li	a2,1024
    8000323c:	4581                	li	a1,0
    8000323e:	05850513          	addi	a0,a0,88
    80003242:	ffffe097          	auipc	ra,0xffffe
    80003246:	a8a080e7          	jalr	-1398(ra) # 80000ccc <memset>
  log_write(bp);
    8000324a:	854a                	mv	a0,s2
    8000324c:	00001097          	auipc	ra,0x1
    80003250:	fec080e7          	jalr	-20(ra) # 80004238 <log_write>
  brelse(bp);
    80003254:	854a                	mv	a0,s2
    80003256:	00000097          	auipc	ra,0x0
    8000325a:	d60080e7          	jalr	-672(ra) # 80002fb6 <brelse>
}
    8000325e:	8526                	mv	a0,s1
    80003260:	60e6                	ld	ra,88(sp)
    80003262:	6446                	ld	s0,80(sp)
    80003264:	64a6                	ld	s1,72(sp)
    80003266:	6906                	ld	s2,64(sp)
    80003268:	79e2                	ld	s3,56(sp)
    8000326a:	7a42                	ld	s4,48(sp)
    8000326c:	7aa2                	ld	s5,40(sp)
    8000326e:	7b02                	ld	s6,32(sp)
    80003270:	6be2                	ld	s7,24(sp)
    80003272:	6c42                	ld	s8,16(sp)
    80003274:	6ca2                	ld	s9,8(sp)
    80003276:	6125                	addi	sp,sp,96
    80003278:	8082                	ret

000000008000327a <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
    8000327a:	7179                	addi	sp,sp,-48
    8000327c:	f406                	sd	ra,40(sp)
    8000327e:	f022                	sd	s0,32(sp)
    80003280:	ec26                	sd	s1,24(sp)
    80003282:	e84a                	sd	s2,16(sp)
    80003284:	e44e                	sd	s3,8(sp)
    80003286:	e052                	sd	s4,0(sp)
    80003288:	1800                	addi	s0,sp,48
    8000328a:	892a                	mv	s2,a0
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    8000328c:	47ad                	li	a5,11
    8000328e:	04b7fe63          	bgeu	a5,a1,800032ea <bmap+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
    80003292:	ff45849b          	addiw	s1,a1,-12
    80003296:	0004871b          	sext.w	a4,s1

  if(bn < NINDIRECT){
    8000329a:	0ff00793          	li	a5,255
    8000329e:	0ae7e463          	bltu	a5,a4,80003346 <bmap+0xcc>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
    800032a2:	08052583          	lw	a1,128(a0)
    800032a6:	c5b5                	beqz	a1,80003312 <bmap+0x98>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    800032a8:	00092503          	lw	a0,0(s2)
    800032ac:	00000097          	auipc	ra,0x0
    800032b0:	bda080e7          	jalr	-1062(ra) # 80002e86 <bread>
    800032b4:	8a2a                	mv	s4,a0
    a = (uint*)bp->data;
    800032b6:	05850793          	addi	a5,a0,88
    if((addr = a[bn]) == 0){
    800032ba:	02049713          	slli	a4,s1,0x20
    800032be:	01e75593          	srli	a1,a4,0x1e
    800032c2:	00b784b3          	add	s1,a5,a1
    800032c6:	0004a983          	lw	s3,0(s1)
    800032ca:	04098e63          	beqz	s3,80003326 <bmap+0xac>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800032ce:	8552                	mv	a0,s4
    800032d0:	00000097          	auipc	ra,0x0
    800032d4:	ce6080e7          	jalr	-794(ra) # 80002fb6 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
    800032d8:	854e                	mv	a0,s3
    800032da:	70a2                	ld	ra,40(sp)
    800032dc:	7402                	ld	s0,32(sp)
    800032de:	64e2                	ld	s1,24(sp)
    800032e0:	6942                	ld	s2,16(sp)
    800032e2:	69a2                	ld	s3,8(sp)
    800032e4:	6a02                	ld	s4,0(sp)
    800032e6:	6145                	addi	sp,sp,48
    800032e8:	8082                	ret
    if((addr = ip->addrs[bn]) == 0)
    800032ea:	02059793          	slli	a5,a1,0x20
    800032ee:	01e7d593          	srli	a1,a5,0x1e
    800032f2:	00b504b3          	add	s1,a0,a1
    800032f6:	0504a983          	lw	s3,80(s1)
    800032fa:	fc099fe3          	bnez	s3,800032d8 <bmap+0x5e>
      ip->addrs[bn] = addr = balloc(ip->dev);
    800032fe:	4108                	lw	a0,0(a0)
    80003300:	00000097          	auipc	ra,0x0
    80003304:	e48080e7          	jalr	-440(ra) # 80003148 <balloc>
    80003308:	0005099b          	sext.w	s3,a0
    8000330c:	0534a823          	sw	s3,80(s1)
    80003310:	b7e1                	j	800032d8 <bmap+0x5e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80003312:	4108                	lw	a0,0(a0)
    80003314:	00000097          	auipc	ra,0x0
    80003318:	e34080e7          	jalr	-460(ra) # 80003148 <balloc>
    8000331c:	0005059b          	sext.w	a1,a0
    80003320:	08b92023          	sw	a1,128(s2)
    80003324:	b751                	j	800032a8 <bmap+0x2e>
      a[bn] = addr = balloc(ip->dev);
    80003326:	00092503          	lw	a0,0(s2)
    8000332a:	00000097          	auipc	ra,0x0
    8000332e:	e1e080e7          	jalr	-482(ra) # 80003148 <balloc>
    80003332:	0005099b          	sext.w	s3,a0
    80003336:	0134a023          	sw	s3,0(s1)
      log_write(bp);
    8000333a:	8552                	mv	a0,s4
    8000333c:	00001097          	auipc	ra,0x1
    80003340:	efc080e7          	jalr	-260(ra) # 80004238 <log_write>
    80003344:	b769                	j	800032ce <bmap+0x54>
  panic("bmap: out of range");
    80003346:	00005517          	auipc	a0,0x5
    8000334a:	20a50513          	addi	a0,a0,522 # 80008550 <syscalls+0x120>
    8000334e:	ffffd097          	auipc	ra,0xffffd
    80003352:	1ea080e7          	jalr	490(ra) # 80000538 <panic>

0000000080003356 <iget>:
{
    80003356:	7179                	addi	sp,sp,-48
    80003358:	f406                	sd	ra,40(sp)
    8000335a:	f022                	sd	s0,32(sp)
    8000335c:	ec26                	sd	s1,24(sp)
    8000335e:	e84a                	sd	s2,16(sp)
    80003360:	e44e                	sd	s3,8(sp)
    80003362:	e052                	sd	s4,0(sp)
    80003364:	1800                	addi	s0,sp,48
    80003366:	89aa                	mv	s3,a0
    80003368:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    8000336a:	0001c517          	auipc	a0,0x1c
    8000336e:	45e50513          	addi	a0,a0,1118 # 8001f7c8 <itable>
    80003372:	ffffe097          	auipc	ra,0xffffe
    80003376:	85e080e7          	jalr	-1954(ra) # 80000bd0 <acquire>
  empty = 0;
    8000337a:	4901                	li	s2,0
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    8000337c:	0001c497          	auipc	s1,0x1c
    80003380:	46448493          	addi	s1,s1,1124 # 8001f7e0 <itable+0x18>
    80003384:	0001e697          	auipc	a3,0x1e
    80003388:	eec68693          	addi	a3,a3,-276 # 80021270 <log>
    8000338c:	a039                	j	8000339a <iget+0x44>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    8000338e:	02090b63          	beqz	s2,800033c4 <iget+0x6e>
  for(ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++){
    80003392:	08848493          	addi	s1,s1,136
    80003396:	02d48a63          	beq	s1,a3,800033ca <iget+0x74>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
    8000339a:	449c                	lw	a5,8(s1)
    8000339c:	fef059e3          	blez	a5,8000338e <iget+0x38>
    800033a0:	4098                	lw	a4,0(s1)
    800033a2:	ff3716e3          	bne	a4,s3,8000338e <iget+0x38>
    800033a6:	40d8                	lw	a4,4(s1)
    800033a8:	ff4713e3          	bne	a4,s4,8000338e <iget+0x38>
      ip->ref++;
    800033ac:	2785                	addiw	a5,a5,1
    800033ae:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    800033b0:	0001c517          	auipc	a0,0x1c
    800033b4:	41850513          	addi	a0,a0,1048 # 8001f7c8 <itable>
    800033b8:	ffffe097          	auipc	ra,0xffffe
    800033bc:	8cc080e7          	jalr	-1844(ra) # 80000c84 <release>
      return ip;
    800033c0:	8926                	mv	s2,s1
    800033c2:	a03d                	j	800033f0 <iget+0x9a>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
    800033c4:	f7f9                	bnez	a5,80003392 <iget+0x3c>
    800033c6:	8926                	mv	s2,s1
    800033c8:	b7e9                	j	80003392 <iget+0x3c>
  if(empty == 0)
    800033ca:	02090c63          	beqz	s2,80003402 <iget+0xac>
  ip->dev = dev;
    800033ce:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    800033d2:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    800033d6:	4785                	li	a5,1
    800033d8:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    800033dc:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    800033e0:	0001c517          	auipc	a0,0x1c
    800033e4:	3e850513          	addi	a0,a0,1000 # 8001f7c8 <itable>
    800033e8:	ffffe097          	auipc	ra,0xffffe
    800033ec:	89c080e7          	jalr	-1892(ra) # 80000c84 <release>
}
    800033f0:	854a                	mv	a0,s2
    800033f2:	70a2                	ld	ra,40(sp)
    800033f4:	7402                	ld	s0,32(sp)
    800033f6:	64e2                	ld	s1,24(sp)
    800033f8:	6942                	ld	s2,16(sp)
    800033fa:	69a2                	ld	s3,8(sp)
    800033fc:	6a02                	ld	s4,0(sp)
    800033fe:	6145                	addi	sp,sp,48
    80003400:	8082                	ret
    panic("iget: no inodes");
    80003402:	00005517          	auipc	a0,0x5
    80003406:	16650513          	addi	a0,a0,358 # 80008568 <syscalls+0x138>
    8000340a:	ffffd097          	auipc	ra,0xffffd
    8000340e:	12e080e7          	jalr	302(ra) # 80000538 <panic>

0000000080003412 <fsinit>:
fsinit(int dev) {
    80003412:	7179                	addi	sp,sp,-48
    80003414:	f406                	sd	ra,40(sp)
    80003416:	f022                	sd	s0,32(sp)
    80003418:	ec26                	sd	s1,24(sp)
    8000341a:	e84a                	sd	s2,16(sp)
    8000341c:	e44e                	sd	s3,8(sp)
    8000341e:	1800                	addi	s0,sp,48
    80003420:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    80003422:	4585                	li	a1,1
    80003424:	00000097          	auipc	ra,0x0
    80003428:	a62080e7          	jalr	-1438(ra) # 80002e86 <bread>
    8000342c:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    8000342e:	0001c997          	auipc	s3,0x1c
    80003432:	37a98993          	addi	s3,s3,890 # 8001f7a8 <sb>
    80003436:	02000613          	li	a2,32
    8000343a:	05850593          	addi	a1,a0,88
    8000343e:	854e                	mv	a0,s3
    80003440:	ffffe097          	auipc	ra,0xffffe
    80003444:	8e8080e7          	jalr	-1816(ra) # 80000d28 <memmove>
  brelse(bp);
    80003448:	8526                	mv	a0,s1
    8000344a:	00000097          	auipc	ra,0x0
    8000344e:	b6c080e7          	jalr	-1172(ra) # 80002fb6 <brelse>
  if(sb.magic != FSMAGIC)
    80003452:	0009a703          	lw	a4,0(s3)
    80003456:	102037b7          	lui	a5,0x10203
    8000345a:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    8000345e:	02f71263          	bne	a4,a5,80003482 <fsinit+0x70>
  initlog(dev, &sb);
    80003462:	0001c597          	auipc	a1,0x1c
    80003466:	34658593          	addi	a1,a1,838 # 8001f7a8 <sb>
    8000346a:	854a                	mv	a0,s2
    8000346c:	00001097          	auipc	ra,0x1
    80003470:	b4e080e7          	jalr	-1202(ra) # 80003fba <initlog>
}
    80003474:	70a2                	ld	ra,40(sp)
    80003476:	7402                	ld	s0,32(sp)
    80003478:	64e2                	ld	s1,24(sp)
    8000347a:	6942                	ld	s2,16(sp)
    8000347c:	69a2                	ld	s3,8(sp)
    8000347e:	6145                	addi	sp,sp,48
    80003480:	8082                	ret
    panic("invalid file system");
    80003482:	00005517          	auipc	a0,0x5
    80003486:	0f650513          	addi	a0,a0,246 # 80008578 <syscalls+0x148>
    8000348a:	ffffd097          	auipc	ra,0xffffd
    8000348e:	0ae080e7          	jalr	174(ra) # 80000538 <panic>

0000000080003492 <iinit>:
{
    80003492:	7179                	addi	sp,sp,-48
    80003494:	f406                	sd	ra,40(sp)
    80003496:	f022                	sd	s0,32(sp)
    80003498:	ec26                	sd	s1,24(sp)
    8000349a:	e84a                	sd	s2,16(sp)
    8000349c:	e44e                	sd	s3,8(sp)
    8000349e:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    800034a0:	00005597          	auipc	a1,0x5
    800034a4:	0f058593          	addi	a1,a1,240 # 80008590 <syscalls+0x160>
    800034a8:	0001c517          	auipc	a0,0x1c
    800034ac:	32050513          	addi	a0,a0,800 # 8001f7c8 <itable>
    800034b0:	ffffd097          	auipc	ra,0xffffd
    800034b4:	690080e7          	jalr	1680(ra) # 80000b40 <initlock>
  for(i = 0; i < NINODE; i++) {
    800034b8:	0001c497          	auipc	s1,0x1c
    800034bc:	33848493          	addi	s1,s1,824 # 8001f7f0 <itable+0x28>
    800034c0:	0001e997          	auipc	s3,0x1e
    800034c4:	dc098993          	addi	s3,s3,-576 # 80021280 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    800034c8:	00005917          	auipc	s2,0x5
    800034cc:	0d090913          	addi	s2,s2,208 # 80008598 <syscalls+0x168>
    800034d0:	85ca                	mv	a1,s2
    800034d2:	8526                	mv	a0,s1
    800034d4:	00001097          	auipc	ra,0x1
    800034d8:	e4a080e7          	jalr	-438(ra) # 8000431e <initsleeplock>
  for(i = 0; i < NINODE; i++) {
    800034dc:	08848493          	addi	s1,s1,136
    800034e0:	ff3498e3          	bne	s1,s3,800034d0 <iinit+0x3e>
}
    800034e4:	70a2                	ld	ra,40(sp)
    800034e6:	7402                	ld	s0,32(sp)
    800034e8:	64e2                	ld	s1,24(sp)
    800034ea:	6942                	ld	s2,16(sp)
    800034ec:	69a2                	ld	s3,8(sp)
    800034ee:	6145                	addi	sp,sp,48
    800034f0:	8082                	ret

00000000800034f2 <ialloc>:
{
    800034f2:	715d                	addi	sp,sp,-80
    800034f4:	e486                	sd	ra,72(sp)
    800034f6:	e0a2                	sd	s0,64(sp)
    800034f8:	fc26                	sd	s1,56(sp)
    800034fa:	f84a                	sd	s2,48(sp)
    800034fc:	f44e                	sd	s3,40(sp)
    800034fe:	f052                	sd	s4,32(sp)
    80003500:	ec56                	sd	s5,24(sp)
    80003502:	e85a                	sd	s6,16(sp)
    80003504:	e45e                	sd	s7,8(sp)
    80003506:	0880                	addi	s0,sp,80
  for(inum = 1; inum < sb.ninodes; inum++){
    80003508:	0001c717          	auipc	a4,0x1c
    8000350c:	2ac72703          	lw	a4,684(a4) # 8001f7b4 <sb+0xc>
    80003510:	4785                	li	a5,1
    80003512:	04e7fa63          	bgeu	a5,a4,80003566 <ialloc+0x74>
    80003516:	8aaa                	mv	s5,a0
    80003518:	8bae                	mv	s7,a1
    8000351a:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    8000351c:	0001ca17          	auipc	s4,0x1c
    80003520:	28ca0a13          	addi	s4,s4,652 # 8001f7a8 <sb>
    80003524:	00048b1b          	sext.w	s6,s1
    80003528:	0044d793          	srli	a5,s1,0x4
    8000352c:	018a2583          	lw	a1,24(s4)
    80003530:	9dbd                	addw	a1,a1,a5
    80003532:	8556                	mv	a0,s5
    80003534:	00000097          	auipc	ra,0x0
    80003538:	952080e7          	jalr	-1710(ra) # 80002e86 <bread>
    8000353c:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + inum%IPB;
    8000353e:	05850993          	addi	s3,a0,88
    80003542:	00f4f793          	andi	a5,s1,15
    80003546:	079a                	slli	a5,a5,0x6
    80003548:	99be                	add	s3,s3,a5
    if(dip->type == 0){  // a free inode
    8000354a:	00099783          	lh	a5,0(s3)
    8000354e:	c785                	beqz	a5,80003576 <ialloc+0x84>
    brelse(bp);
    80003550:	00000097          	auipc	ra,0x0
    80003554:	a66080e7          	jalr	-1434(ra) # 80002fb6 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
    80003558:	0485                	addi	s1,s1,1
    8000355a:	00ca2703          	lw	a4,12(s4)
    8000355e:	0004879b          	sext.w	a5,s1
    80003562:	fce7e1e3          	bltu	a5,a4,80003524 <ialloc+0x32>
  panic("ialloc: no inodes");
    80003566:	00005517          	auipc	a0,0x5
    8000356a:	03a50513          	addi	a0,a0,58 # 800085a0 <syscalls+0x170>
    8000356e:	ffffd097          	auipc	ra,0xffffd
    80003572:	fca080e7          	jalr	-54(ra) # 80000538 <panic>
      memset(dip, 0, sizeof(*dip));
    80003576:	04000613          	li	a2,64
    8000357a:	4581                	li	a1,0
    8000357c:	854e                	mv	a0,s3
    8000357e:	ffffd097          	auipc	ra,0xffffd
    80003582:	74e080e7          	jalr	1870(ra) # 80000ccc <memset>
      dip->type = type;
    80003586:	01799023          	sh	s7,0(s3)
      log_write(bp);   // mark it allocated on the disk
    8000358a:	854a                	mv	a0,s2
    8000358c:	00001097          	auipc	ra,0x1
    80003590:	cac080e7          	jalr	-852(ra) # 80004238 <log_write>
      brelse(bp);
    80003594:	854a                	mv	a0,s2
    80003596:	00000097          	auipc	ra,0x0
    8000359a:	a20080e7          	jalr	-1504(ra) # 80002fb6 <brelse>
      return iget(dev, inum);
    8000359e:	85da                	mv	a1,s6
    800035a0:	8556                	mv	a0,s5
    800035a2:	00000097          	auipc	ra,0x0
    800035a6:	db4080e7          	jalr	-588(ra) # 80003356 <iget>
}
    800035aa:	60a6                	ld	ra,72(sp)
    800035ac:	6406                	ld	s0,64(sp)
    800035ae:	74e2                	ld	s1,56(sp)
    800035b0:	7942                	ld	s2,48(sp)
    800035b2:	79a2                	ld	s3,40(sp)
    800035b4:	7a02                	ld	s4,32(sp)
    800035b6:	6ae2                	ld	s5,24(sp)
    800035b8:	6b42                	ld	s6,16(sp)
    800035ba:	6ba2                	ld	s7,8(sp)
    800035bc:	6161                	addi	sp,sp,80
    800035be:	8082                	ret

00000000800035c0 <iupdate>:
{
    800035c0:	1101                	addi	sp,sp,-32
    800035c2:	ec06                	sd	ra,24(sp)
    800035c4:	e822                	sd	s0,16(sp)
    800035c6:	e426                	sd	s1,8(sp)
    800035c8:	e04a                	sd	s2,0(sp)
    800035ca:	1000                	addi	s0,sp,32
    800035cc:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800035ce:	415c                	lw	a5,4(a0)
    800035d0:	0047d79b          	srliw	a5,a5,0x4
    800035d4:	0001c597          	auipc	a1,0x1c
    800035d8:	1ec5a583          	lw	a1,492(a1) # 8001f7c0 <sb+0x18>
    800035dc:	9dbd                	addw	a1,a1,a5
    800035de:	4108                	lw	a0,0(a0)
    800035e0:	00000097          	auipc	ra,0x0
    800035e4:	8a6080e7          	jalr	-1882(ra) # 80002e86 <bread>
    800035e8:	892a                	mv	s2,a0
  dip = (struct dinode*)bp->data + ip->inum%IPB;
    800035ea:	05850793          	addi	a5,a0,88
    800035ee:	40c8                	lw	a0,4(s1)
    800035f0:	893d                	andi	a0,a0,15
    800035f2:	051a                	slli	a0,a0,0x6
    800035f4:	953e                	add	a0,a0,a5
  dip->type = ip->type;
    800035f6:	04449703          	lh	a4,68(s1)
    800035fa:	00e51023          	sh	a4,0(a0)
  dip->major = ip->major;
    800035fe:	04649703          	lh	a4,70(s1)
    80003602:	00e51123          	sh	a4,2(a0)
  dip->minor = ip->minor;
    80003606:	04849703          	lh	a4,72(s1)
    8000360a:	00e51223          	sh	a4,4(a0)
  dip->nlink = ip->nlink;
    8000360e:	04a49703          	lh	a4,74(s1)
    80003612:	00e51323          	sh	a4,6(a0)
  dip->size = ip->size;
    80003616:	44f8                	lw	a4,76(s1)
    80003618:	c518                	sw	a4,8(a0)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
    8000361a:	03400613          	li	a2,52
    8000361e:	05048593          	addi	a1,s1,80
    80003622:	0531                	addi	a0,a0,12
    80003624:	ffffd097          	auipc	ra,0xffffd
    80003628:	704080e7          	jalr	1796(ra) # 80000d28 <memmove>
  log_write(bp);
    8000362c:	854a                	mv	a0,s2
    8000362e:	00001097          	auipc	ra,0x1
    80003632:	c0a080e7          	jalr	-1014(ra) # 80004238 <log_write>
  brelse(bp);
    80003636:	854a                	mv	a0,s2
    80003638:	00000097          	auipc	ra,0x0
    8000363c:	97e080e7          	jalr	-1666(ra) # 80002fb6 <brelse>
}
    80003640:	60e2                	ld	ra,24(sp)
    80003642:	6442                	ld	s0,16(sp)
    80003644:	64a2                	ld	s1,8(sp)
    80003646:	6902                	ld	s2,0(sp)
    80003648:	6105                	addi	sp,sp,32
    8000364a:	8082                	ret

000000008000364c <idup>:
{
    8000364c:	1101                	addi	sp,sp,-32
    8000364e:	ec06                	sd	ra,24(sp)
    80003650:	e822                	sd	s0,16(sp)
    80003652:	e426                	sd	s1,8(sp)
    80003654:	1000                	addi	s0,sp,32
    80003656:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003658:	0001c517          	auipc	a0,0x1c
    8000365c:	17050513          	addi	a0,a0,368 # 8001f7c8 <itable>
    80003660:	ffffd097          	auipc	ra,0xffffd
    80003664:	570080e7          	jalr	1392(ra) # 80000bd0 <acquire>
  ip->ref++;
    80003668:	449c                	lw	a5,8(s1)
    8000366a:	2785                	addiw	a5,a5,1
    8000366c:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    8000366e:	0001c517          	auipc	a0,0x1c
    80003672:	15a50513          	addi	a0,a0,346 # 8001f7c8 <itable>
    80003676:	ffffd097          	auipc	ra,0xffffd
    8000367a:	60e080e7          	jalr	1550(ra) # 80000c84 <release>
}
    8000367e:	8526                	mv	a0,s1
    80003680:	60e2                	ld	ra,24(sp)
    80003682:	6442                	ld	s0,16(sp)
    80003684:	64a2                	ld	s1,8(sp)
    80003686:	6105                	addi	sp,sp,32
    80003688:	8082                	ret

000000008000368a <ilock>:
{
    8000368a:	1101                	addi	sp,sp,-32
    8000368c:	ec06                	sd	ra,24(sp)
    8000368e:	e822                	sd	s0,16(sp)
    80003690:	e426                	sd	s1,8(sp)
    80003692:	e04a                	sd	s2,0(sp)
    80003694:	1000                	addi	s0,sp,32
  if(ip == 0 || ip->ref < 1)
    80003696:	c115                	beqz	a0,800036ba <ilock+0x30>
    80003698:	84aa                	mv	s1,a0
    8000369a:	451c                	lw	a5,8(a0)
    8000369c:	00f05f63          	blez	a5,800036ba <ilock+0x30>
  acquiresleep(&ip->lock);
    800036a0:	0541                	addi	a0,a0,16
    800036a2:	00001097          	auipc	ra,0x1
    800036a6:	cb6080e7          	jalr	-842(ra) # 80004358 <acquiresleep>
  if(ip->valid == 0){
    800036aa:	40bc                	lw	a5,64(s1)
    800036ac:	cf99                	beqz	a5,800036ca <ilock+0x40>
}
    800036ae:	60e2                	ld	ra,24(sp)
    800036b0:	6442                	ld	s0,16(sp)
    800036b2:	64a2                	ld	s1,8(sp)
    800036b4:	6902                	ld	s2,0(sp)
    800036b6:	6105                	addi	sp,sp,32
    800036b8:	8082                	ret
    panic("ilock");
    800036ba:	00005517          	auipc	a0,0x5
    800036be:	efe50513          	addi	a0,a0,-258 # 800085b8 <syscalls+0x188>
    800036c2:	ffffd097          	auipc	ra,0xffffd
    800036c6:	e76080e7          	jalr	-394(ra) # 80000538 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    800036ca:	40dc                	lw	a5,4(s1)
    800036cc:	0047d79b          	srliw	a5,a5,0x4
    800036d0:	0001c597          	auipc	a1,0x1c
    800036d4:	0f05a583          	lw	a1,240(a1) # 8001f7c0 <sb+0x18>
    800036d8:	9dbd                	addw	a1,a1,a5
    800036da:	4088                	lw	a0,0(s1)
    800036dc:	fffff097          	auipc	ra,0xfffff
    800036e0:	7aa080e7          	jalr	1962(ra) # 80002e86 <bread>
    800036e4:	892a                	mv	s2,a0
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    800036e6:	05850593          	addi	a1,a0,88
    800036ea:	40dc                	lw	a5,4(s1)
    800036ec:	8bbd                	andi	a5,a5,15
    800036ee:	079a                	slli	a5,a5,0x6
    800036f0:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    800036f2:	00059783          	lh	a5,0(a1)
    800036f6:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    800036fa:	00259783          	lh	a5,2(a1)
    800036fe:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80003702:	00459783          	lh	a5,4(a1)
    80003706:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    8000370a:	00659783          	lh	a5,6(a1)
    8000370e:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80003712:	459c                	lw	a5,8(a1)
    80003714:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80003716:	03400613          	li	a2,52
    8000371a:	05b1                	addi	a1,a1,12
    8000371c:	05048513          	addi	a0,s1,80
    80003720:	ffffd097          	auipc	ra,0xffffd
    80003724:	608080e7          	jalr	1544(ra) # 80000d28 <memmove>
    brelse(bp);
    80003728:	854a                	mv	a0,s2
    8000372a:	00000097          	auipc	ra,0x0
    8000372e:	88c080e7          	jalr	-1908(ra) # 80002fb6 <brelse>
    ip->valid = 1;
    80003732:	4785                	li	a5,1
    80003734:	c0bc                	sw	a5,64(s1)
    if(ip->type == 0)
    80003736:	04449783          	lh	a5,68(s1)
    8000373a:	fbb5                	bnez	a5,800036ae <ilock+0x24>
      panic("ilock: no type");
    8000373c:	00005517          	auipc	a0,0x5
    80003740:	e8450513          	addi	a0,a0,-380 # 800085c0 <syscalls+0x190>
    80003744:	ffffd097          	auipc	ra,0xffffd
    80003748:	df4080e7          	jalr	-524(ra) # 80000538 <panic>

000000008000374c <iunlock>:
{
    8000374c:	1101                	addi	sp,sp,-32
    8000374e:	ec06                	sd	ra,24(sp)
    80003750:	e822                	sd	s0,16(sp)
    80003752:	e426                	sd	s1,8(sp)
    80003754:	e04a                	sd	s2,0(sp)
    80003756:	1000                	addi	s0,sp,32
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80003758:	c905                	beqz	a0,80003788 <iunlock+0x3c>
    8000375a:	84aa                	mv	s1,a0
    8000375c:	01050913          	addi	s2,a0,16
    80003760:	854a                	mv	a0,s2
    80003762:	00001097          	auipc	ra,0x1
    80003766:	c90080e7          	jalr	-880(ra) # 800043f2 <holdingsleep>
    8000376a:	cd19                	beqz	a0,80003788 <iunlock+0x3c>
    8000376c:	449c                	lw	a5,8(s1)
    8000376e:	00f05d63          	blez	a5,80003788 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80003772:	854a                	mv	a0,s2
    80003774:	00001097          	auipc	ra,0x1
    80003778:	c3a080e7          	jalr	-966(ra) # 800043ae <releasesleep>
}
    8000377c:	60e2                	ld	ra,24(sp)
    8000377e:	6442                	ld	s0,16(sp)
    80003780:	64a2                	ld	s1,8(sp)
    80003782:	6902                	ld	s2,0(sp)
    80003784:	6105                	addi	sp,sp,32
    80003786:	8082                	ret
    panic("iunlock");
    80003788:	00005517          	auipc	a0,0x5
    8000378c:	e4850513          	addi	a0,a0,-440 # 800085d0 <syscalls+0x1a0>
    80003790:	ffffd097          	auipc	ra,0xffffd
    80003794:	da8080e7          	jalr	-600(ra) # 80000538 <panic>

0000000080003798 <itrunc>:

// Truncate inode (discard contents).
// Caller must hold ip->lock.
void
itrunc(struct inode *ip)
{
    80003798:	7179                	addi	sp,sp,-48
    8000379a:	f406                	sd	ra,40(sp)
    8000379c:	f022                	sd	s0,32(sp)
    8000379e:	ec26                	sd	s1,24(sp)
    800037a0:	e84a                	sd	s2,16(sp)
    800037a2:	e44e                	sd	s3,8(sp)
    800037a4:	e052                	sd	s4,0(sp)
    800037a6:	1800                	addi	s0,sp,48
    800037a8:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
    800037aa:	05050493          	addi	s1,a0,80
    800037ae:	08050913          	addi	s2,a0,128
    800037b2:	a021                	j	800037ba <itrunc+0x22>
    800037b4:	0491                	addi	s1,s1,4
    800037b6:	01248d63          	beq	s1,s2,800037d0 <itrunc+0x38>
    if(ip->addrs[i]){
    800037ba:	408c                	lw	a1,0(s1)
    800037bc:	dde5                	beqz	a1,800037b4 <itrunc+0x1c>
      bfree(ip->dev, ip->addrs[i]);
    800037be:	0009a503          	lw	a0,0(s3)
    800037c2:	00000097          	auipc	ra,0x0
    800037c6:	90a080e7          	jalr	-1782(ra) # 800030cc <bfree>
      ip->addrs[i] = 0;
    800037ca:	0004a023          	sw	zero,0(s1)
    800037ce:	b7dd                	j	800037b4 <itrunc+0x1c>
    }
  }

  if(ip->addrs[NDIRECT]){
    800037d0:	0809a583          	lw	a1,128(s3)
    800037d4:	e185                	bnez	a1,800037f4 <itrunc+0x5c>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
    800037d6:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    800037da:	854e                	mv	a0,s3
    800037dc:	00000097          	auipc	ra,0x0
    800037e0:	de4080e7          	jalr	-540(ra) # 800035c0 <iupdate>
}
    800037e4:	70a2                	ld	ra,40(sp)
    800037e6:	7402                	ld	s0,32(sp)
    800037e8:	64e2                	ld	s1,24(sp)
    800037ea:	6942                	ld	s2,16(sp)
    800037ec:	69a2                	ld	s3,8(sp)
    800037ee:	6a02                	ld	s4,0(sp)
    800037f0:	6145                	addi	sp,sp,48
    800037f2:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    800037f4:	0009a503          	lw	a0,0(s3)
    800037f8:	fffff097          	auipc	ra,0xfffff
    800037fc:	68e080e7          	jalr	1678(ra) # 80002e86 <bread>
    80003800:	8a2a                	mv	s4,a0
    for(j = 0; j < NINDIRECT; j++){
    80003802:	05850493          	addi	s1,a0,88
    80003806:	45850913          	addi	s2,a0,1112
    8000380a:	a021                	j	80003812 <itrunc+0x7a>
    8000380c:	0491                	addi	s1,s1,4
    8000380e:	01248b63          	beq	s1,s2,80003824 <itrunc+0x8c>
      if(a[j])
    80003812:	408c                	lw	a1,0(s1)
    80003814:	dde5                	beqz	a1,8000380c <itrunc+0x74>
        bfree(ip->dev, a[j]);
    80003816:	0009a503          	lw	a0,0(s3)
    8000381a:	00000097          	auipc	ra,0x0
    8000381e:	8b2080e7          	jalr	-1870(ra) # 800030cc <bfree>
    80003822:	b7ed                	j	8000380c <itrunc+0x74>
    brelse(bp);
    80003824:	8552                	mv	a0,s4
    80003826:	fffff097          	auipc	ra,0xfffff
    8000382a:	790080e7          	jalr	1936(ra) # 80002fb6 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    8000382e:	0809a583          	lw	a1,128(s3)
    80003832:	0009a503          	lw	a0,0(s3)
    80003836:	00000097          	auipc	ra,0x0
    8000383a:	896080e7          	jalr	-1898(ra) # 800030cc <bfree>
    ip->addrs[NDIRECT] = 0;
    8000383e:	0809a023          	sw	zero,128(s3)
    80003842:	bf51                	j	800037d6 <itrunc+0x3e>

0000000080003844 <iput>:
{
    80003844:	1101                	addi	sp,sp,-32
    80003846:	ec06                	sd	ra,24(sp)
    80003848:	e822                	sd	s0,16(sp)
    8000384a:	e426                	sd	s1,8(sp)
    8000384c:	e04a                	sd	s2,0(sp)
    8000384e:	1000                	addi	s0,sp,32
    80003850:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80003852:	0001c517          	auipc	a0,0x1c
    80003856:	f7650513          	addi	a0,a0,-138 # 8001f7c8 <itable>
    8000385a:	ffffd097          	auipc	ra,0xffffd
    8000385e:	376080e7          	jalr	886(ra) # 80000bd0 <acquire>
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    80003862:	4498                	lw	a4,8(s1)
    80003864:	4785                	li	a5,1
    80003866:	02f70363          	beq	a4,a5,8000388c <iput+0x48>
  ip->ref--;
    8000386a:	449c                	lw	a5,8(s1)
    8000386c:	37fd                	addiw	a5,a5,-1
    8000386e:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80003870:	0001c517          	auipc	a0,0x1c
    80003874:	f5850513          	addi	a0,a0,-168 # 8001f7c8 <itable>
    80003878:	ffffd097          	auipc	ra,0xffffd
    8000387c:	40c080e7          	jalr	1036(ra) # 80000c84 <release>
}
    80003880:	60e2                	ld	ra,24(sp)
    80003882:	6442                	ld	s0,16(sp)
    80003884:	64a2                	ld	s1,8(sp)
    80003886:	6902                	ld	s2,0(sp)
    80003888:	6105                	addi	sp,sp,32
    8000388a:	8082                	ret
  if(ip->ref == 1 && ip->valid && ip->nlink == 0){
    8000388c:	40bc                	lw	a5,64(s1)
    8000388e:	dff1                	beqz	a5,8000386a <iput+0x26>
    80003890:	04a49783          	lh	a5,74(s1)
    80003894:	fbf9                	bnez	a5,8000386a <iput+0x26>
    acquiresleep(&ip->lock);
    80003896:	01048913          	addi	s2,s1,16
    8000389a:	854a                	mv	a0,s2
    8000389c:	00001097          	auipc	ra,0x1
    800038a0:	abc080e7          	jalr	-1348(ra) # 80004358 <acquiresleep>
    release(&itable.lock);
    800038a4:	0001c517          	auipc	a0,0x1c
    800038a8:	f2450513          	addi	a0,a0,-220 # 8001f7c8 <itable>
    800038ac:	ffffd097          	auipc	ra,0xffffd
    800038b0:	3d8080e7          	jalr	984(ra) # 80000c84 <release>
    itrunc(ip);
    800038b4:	8526                	mv	a0,s1
    800038b6:	00000097          	auipc	ra,0x0
    800038ba:	ee2080e7          	jalr	-286(ra) # 80003798 <itrunc>
    ip->type = 0;
    800038be:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    800038c2:	8526                	mv	a0,s1
    800038c4:	00000097          	auipc	ra,0x0
    800038c8:	cfc080e7          	jalr	-772(ra) # 800035c0 <iupdate>
    ip->valid = 0;
    800038cc:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    800038d0:	854a                	mv	a0,s2
    800038d2:	00001097          	auipc	ra,0x1
    800038d6:	adc080e7          	jalr	-1316(ra) # 800043ae <releasesleep>
    acquire(&itable.lock);
    800038da:	0001c517          	auipc	a0,0x1c
    800038de:	eee50513          	addi	a0,a0,-274 # 8001f7c8 <itable>
    800038e2:	ffffd097          	auipc	ra,0xffffd
    800038e6:	2ee080e7          	jalr	750(ra) # 80000bd0 <acquire>
    800038ea:	b741                	j	8000386a <iput+0x26>

00000000800038ec <iunlockput>:
{
    800038ec:	1101                	addi	sp,sp,-32
    800038ee:	ec06                	sd	ra,24(sp)
    800038f0:	e822                	sd	s0,16(sp)
    800038f2:	e426                	sd	s1,8(sp)
    800038f4:	1000                	addi	s0,sp,32
    800038f6:	84aa                	mv	s1,a0
  iunlock(ip);
    800038f8:	00000097          	auipc	ra,0x0
    800038fc:	e54080e7          	jalr	-428(ra) # 8000374c <iunlock>
  iput(ip);
    80003900:	8526                	mv	a0,s1
    80003902:	00000097          	auipc	ra,0x0
    80003906:	f42080e7          	jalr	-190(ra) # 80003844 <iput>
}
    8000390a:	60e2                	ld	ra,24(sp)
    8000390c:	6442                	ld	s0,16(sp)
    8000390e:	64a2                	ld	s1,8(sp)
    80003910:	6105                	addi	sp,sp,32
    80003912:	8082                	ret

0000000080003914 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
    80003914:	1141                	addi	sp,sp,-16
    80003916:	e422                	sd	s0,8(sp)
    80003918:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    8000391a:	411c                	lw	a5,0(a0)
    8000391c:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    8000391e:	415c                	lw	a5,4(a0)
    80003920:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80003922:	04451783          	lh	a5,68(a0)
    80003926:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    8000392a:	04a51783          	lh	a5,74(a0)
    8000392e:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80003932:	04c56783          	lwu	a5,76(a0)
    80003936:	e99c                	sd	a5,16(a1)
}
    80003938:	6422                	ld	s0,8(sp)
    8000393a:	0141                	addi	sp,sp,16
    8000393c:	8082                	ret

000000008000393e <readi>:
readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    8000393e:	457c                	lw	a5,76(a0)
    80003940:	0ed7e963          	bltu	a5,a3,80003a32 <readi+0xf4>
{
    80003944:	7159                	addi	sp,sp,-112
    80003946:	f486                	sd	ra,104(sp)
    80003948:	f0a2                	sd	s0,96(sp)
    8000394a:	eca6                	sd	s1,88(sp)
    8000394c:	e8ca                	sd	s2,80(sp)
    8000394e:	e4ce                	sd	s3,72(sp)
    80003950:	e0d2                	sd	s4,64(sp)
    80003952:	fc56                	sd	s5,56(sp)
    80003954:	f85a                	sd	s6,48(sp)
    80003956:	f45e                	sd	s7,40(sp)
    80003958:	f062                	sd	s8,32(sp)
    8000395a:	ec66                	sd	s9,24(sp)
    8000395c:	e86a                	sd	s10,16(sp)
    8000395e:	e46e                	sd	s11,8(sp)
    80003960:	1880                	addi	s0,sp,112
    80003962:	8baa                	mv	s7,a0
    80003964:	8c2e                	mv	s8,a1
    80003966:	8ab2                	mv	s5,a2
    80003968:	84b6                	mv	s1,a3
    8000396a:	8b3a                	mv	s6,a4
  if(off > ip->size || off + n < off)
    8000396c:	9f35                	addw	a4,a4,a3
    return 0;
    8000396e:	4501                	li	a0,0
  if(off > ip->size || off + n < off)
    80003970:	0ad76063          	bltu	a4,a3,80003a10 <readi+0xd2>
  if(off + n > ip->size)
    80003974:	00e7f463          	bgeu	a5,a4,8000397c <readi+0x3e>
    n = ip->size - off;
    80003978:	40d78b3b          	subw	s6,a5,a3

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    8000397c:	0a0b0963          	beqz	s6,80003a2e <readi+0xf0>
    80003980:	4981                	li	s3,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003982:	40000d13          	li	s10,1024
    if(either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1) {
    80003986:	5cfd                	li	s9,-1
    80003988:	a82d                	j	800039c2 <readi+0x84>
    8000398a:	020a1d93          	slli	s11,s4,0x20
    8000398e:	020ddd93          	srli	s11,s11,0x20
    80003992:	05890793          	addi	a5,s2,88
    80003996:	86ee                	mv	a3,s11
    80003998:	963e                	add	a2,a2,a5
    8000399a:	85d6                	mv	a1,s5
    8000399c:	8562                	mv	a0,s8
    8000399e:	fffff097          	auipc	ra,0xfffff
    800039a2:	b2c080e7          	jalr	-1236(ra) # 800024ca <either_copyout>
    800039a6:	05950d63          	beq	a0,s9,80003a00 <readi+0xc2>
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    800039aa:	854a                	mv	a0,s2
    800039ac:	fffff097          	auipc	ra,0xfffff
    800039b0:	60a080e7          	jalr	1546(ra) # 80002fb6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    800039b4:	013a09bb          	addw	s3,s4,s3
    800039b8:	009a04bb          	addw	s1,s4,s1
    800039bc:	9aee                	add	s5,s5,s11
    800039be:	0569f763          	bgeu	s3,s6,80003a0c <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    800039c2:	000ba903          	lw	s2,0(s7)
    800039c6:	00a4d59b          	srliw	a1,s1,0xa
    800039ca:	855e                	mv	a0,s7
    800039cc:	00000097          	auipc	ra,0x0
    800039d0:	8ae080e7          	jalr	-1874(ra) # 8000327a <bmap>
    800039d4:	0005059b          	sext.w	a1,a0
    800039d8:	854a                	mv	a0,s2
    800039da:	fffff097          	auipc	ra,0xfffff
    800039de:	4ac080e7          	jalr	1196(ra) # 80002e86 <bread>
    800039e2:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    800039e4:	3ff4f613          	andi	a2,s1,1023
    800039e8:	40cd07bb          	subw	a5,s10,a2
    800039ec:	413b073b          	subw	a4,s6,s3
    800039f0:	8a3e                	mv	s4,a5
    800039f2:	2781                	sext.w	a5,a5
    800039f4:	0007069b          	sext.w	a3,a4
    800039f8:	f8f6f9e3          	bgeu	a3,a5,8000398a <readi+0x4c>
    800039fc:	8a3a                	mv	s4,a4
    800039fe:	b771                	j	8000398a <readi+0x4c>
      brelse(bp);
    80003a00:	854a                	mv	a0,s2
    80003a02:	fffff097          	auipc	ra,0xfffff
    80003a06:	5b4080e7          	jalr	1460(ra) # 80002fb6 <brelse>
      tot = -1;
    80003a0a:	59fd                	li	s3,-1
  }
  return tot;
    80003a0c:	0009851b          	sext.w	a0,s3
}
    80003a10:	70a6                	ld	ra,104(sp)
    80003a12:	7406                	ld	s0,96(sp)
    80003a14:	64e6                	ld	s1,88(sp)
    80003a16:	6946                	ld	s2,80(sp)
    80003a18:	69a6                	ld	s3,72(sp)
    80003a1a:	6a06                	ld	s4,64(sp)
    80003a1c:	7ae2                	ld	s5,56(sp)
    80003a1e:	7b42                	ld	s6,48(sp)
    80003a20:	7ba2                	ld	s7,40(sp)
    80003a22:	7c02                	ld	s8,32(sp)
    80003a24:	6ce2                	ld	s9,24(sp)
    80003a26:	6d42                	ld	s10,16(sp)
    80003a28:	6da2                	ld	s11,8(sp)
    80003a2a:	6165                	addi	sp,sp,112
    80003a2c:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    80003a2e:	89da                	mv	s3,s6
    80003a30:	bff1                	j	80003a0c <readi+0xce>
    return 0;
    80003a32:	4501                	li	a0,0
}
    80003a34:	8082                	ret

0000000080003a36 <writei>:
writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if(off > ip->size || off + n < off)
    80003a36:	457c                	lw	a5,76(a0)
    80003a38:	10d7e863          	bltu	a5,a3,80003b48 <writei+0x112>
{
    80003a3c:	7159                	addi	sp,sp,-112
    80003a3e:	f486                	sd	ra,104(sp)
    80003a40:	f0a2                	sd	s0,96(sp)
    80003a42:	eca6                	sd	s1,88(sp)
    80003a44:	e8ca                	sd	s2,80(sp)
    80003a46:	e4ce                	sd	s3,72(sp)
    80003a48:	e0d2                	sd	s4,64(sp)
    80003a4a:	fc56                	sd	s5,56(sp)
    80003a4c:	f85a                	sd	s6,48(sp)
    80003a4e:	f45e                	sd	s7,40(sp)
    80003a50:	f062                	sd	s8,32(sp)
    80003a52:	ec66                	sd	s9,24(sp)
    80003a54:	e86a                	sd	s10,16(sp)
    80003a56:	e46e                	sd	s11,8(sp)
    80003a58:	1880                	addi	s0,sp,112
    80003a5a:	8b2a                	mv	s6,a0
    80003a5c:	8c2e                	mv	s8,a1
    80003a5e:	8ab2                	mv	s5,a2
    80003a60:	8936                	mv	s2,a3
    80003a62:	8bba                	mv	s7,a4
  if(off > ip->size || off + n < off)
    80003a64:	00e687bb          	addw	a5,a3,a4
    80003a68:	0ed7e263          	bltu	a5,a3,80003b4c <writei+0x116>
    return -1;
  if(off + n > MAXFILE*BSIZE)
    80003a6c:	00043737          	lui	a4,0x43
    80003a70:	0ef76063          	bltu	a4,a5,80003b50 <writei+0x11a>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003a74:	0c0b8863          	beqz	s7,80003b44 <writei+0x10e>
    80003a78:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    80003a7a:	40000d13          	li	s10,1024
    if(either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80003a7e:	5cfd                	li	s9,-1
    80003a80:	a091                	j	80003ac4 <writei+0x8e>
    80003a82:	02099d93          	slli	s11,s3,0x20
    80003a86:	020ddd93          	srli	s11,s11,0x20
    80003a8a:	05848793          	addi	a5,s1,88
    80003a8e:	86ee                	mv	a3,s11
    80003a90:	8656                	mv	a2,s5
    80003a92:	85e2                	mv	a1,s8
    80003a94:	953e                	add	a0,a0,a5
    80003a96:	fffff097          	auipc	ra,0xfffff
    80003a9a:	a8a080e7          	jalr	-1398(ra) # 80002520 <either_copyin>
    80003a9e:	07950263          	beq	a0,s9,80003b02 <writei+0xcc>
      brelse(bp);
      break;
    }
    log_write(bp);
    80003aa2:	8526                	mv	a0,s1
    80003aa4:	00000097          	auipc	ra,0x0
    80003aa8:	794080e7          	jalr	1940(ra) # 80004238 <log_write>
    brelse(bp);
    80003aac:	8526                	mv	a0,s1
    80003aae:	fffff097          	auipc	ra,0xfffff
    80003ab2:	508080e7          	jalr	1288(ra) # 80002fb6 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003ab6:	01498a3b          	addw	s4,s3,s4
    80003aba:	0129893b          	addw	s2,s3,s2
    80003abe:	9aee                	add	s5,s5,s11
    80003ac0:	057a7663          	bgeu	s4,s7,80003b0c <writei+0xd6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    80003ac4:	000b2483          	lw	s1,0(s6)
    80003ac8:	00a9559b          	srliw	a1,s2,0xa
    80003acc:	855a                	mv	a0,s6
    80003ace:	fffff097          	auipc	ra,0xfffff
    80003ad2:	7ac080e7          	jalr	1964(ra) # 8000327a <bmap>
    80003ad6:	0005059b          	sext.w	a1,a0
    80003ada:	8526                	mv	a0,s1
    80003adc:	fffff097          	auipc	ra,0xfffff
    80003ae0:	3aa080e7          	jalr	938(ra) # 80002e86 <bread>
    80003ae4:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off%BSIZE);
    80003ae6:	3ff97513          	andi	a0,s2,1023
    80003aea:	40ad07bb          	subw	a5,s10,a0
    80003aee:	414b873b          	subw	a4,s7,s4
    80003af2:	89be                	mv	s3,a5
    80003af4:	2781                	sext.w	a5,a5
    80003af6:	0007069b          	sext.w	a3,a4
    80003afa:	f8f6f4e3          	bgeu	a3,a5,80003a82 <writei+0x4c>
    80003afe:	89ba                	mv	s3,a4
    80003b00:	b749                	j	80003a82 <writei+0x4c>
      brelse(bp);
    80003b02:	8526                	mv	a0,s1
    80003b04:	fffff097          	auipc	ra,0xfffff
    80003b08:	4b2080e7          	jalr	1202(ra) # 80002fb6 <brelse>
  }

  if(off > ip->size)
    80003b0c:	04cb2783          	lw	a5,76(s6)
    80003b10:	0127f463          	bgeu	a5,s2,80003b18 <writei+0xe2>
    ip->size = off;
    80003b14:	052b2623          	sw	s2,76(s6)

  // write the i-node back to disk even if the size didn't change
  // because the loop above might have called bmap() and added a new
  // block to ip->addrs[].
  iupdate(ip);
    80003b18:	855a                	mv	a0,s6
    80003b1a:	00000097          	auipc	ra,0x0
    80003b1e:	aa6080e7          	jalr	-1370(ra) # 800035c0 <iupdate>

  return tot;
    80003b22:	000a051b          	sext.w	a0,s4
}
    80003b26:	70a6                	ld	ra,104(sp)
    80003b28:	7406                	ld	s0,96(sp)
    80003b2a:	64e6                	ld	s1,88(sp)
    80003b2c:	6946                	ld	s2,80(sp)
    80003b2e:	69a6                	ld	s3,72(sp)
    80003b30:	6a06                	ld	s4,64(sp)
    80003b32:	7ae2                	ld	s5,56(sp)
    80003b34:	7b42                	ld	s6,48(sp)
    80003b36:	7ba2                	ld	s7,40(sp)
    80003b38:	7c02                	ld	s8,32(sp)
    80003b3a:	6ce2                	ld	s9,24(sp)
    80003b3c:	6d42                	ld	s10,16(sp)
    80003b3e:	6da2                	ld	s11,8(sp)
    80003b40:	6165                	addi	sp,sp,112
    80003b42:	8082                	ret
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    80003b44:	8a5e                	mv	s4,s7
    80003b46:	bfc9                	j	80003b18 <writei+0xe2>
    return -1;
    80003b48:	557d                	li	a0,-1
}
    80003b4a:	8082                	ret
    return -1;
    80003b4c:	557d                	li	a0,-1
    80003b4e:	bfe1                	j	80003b26 <writei+0xf0>
    return -1;
    80003b50:	557d                	li	a0,-1
    80003b52:	bfd1                	j	80003b26 <writei+0xf0>

0000000080003b54 <namecmp>:

// Directories

int
namecmp(const char *s, const char *t)
{
    80003b54:	1141                	addi	sp,sp,-16
    80003b56:	e406                	sd	ra,8(sp)
    80003b58:	e022                	sd	s0,0(sp)
    80003b5a:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    80003b5c:	4639                	li	a2,14
    80003b5e:	ffffd097          	auipc	ra,0xffffd
    80003b62:	246080e7          	jalr	582(ra) # 80000da4 <strncmp>
}
    80003b66:	60a2                	ld	ra,8(sp)
    80003b68:	6402                	ld	s0,0(sp)
    80003b6a:	0141                	addi	sp,sp,16
    80003b6c:	8082                	ret

0000000080003b6e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
    80003b6e:	7139                	addi	sp,sp,-64
    80003b70:	fc06                	sd	ra,56(sp)
    80003b72:	f822                	sd	s0,48(sp)
    80003b74:	f426                	sd	s1,40(sp)
    80003b76:	f04a                	sd	s2,32(sp)
    80003b78:	ec4e                	sd	s3,24(sp)
    80003b7a:	e852                	sd	s4,16(sp)
    80003b7c:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    80003b7e:	04451703          	lh	a4,68(a0)
    80003b82:	4785                	li	a5,1
    80003b84:	00f71a63          	bne	a4,a5,80003b98 <dirlookup+0x2a>
    80003b88:	892a                	mv	s2,a0
    80003b8a:	89ae                	mv	s3,a1
    80003b8c:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    80003b8e:	457c                	lw	a5,76(a0)
    80003b90:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    80003b92:	4501                	li	a0,0
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003b94:	e79d                	bnez	a5,80003bc2 <dirlookup+0x54>
    80003b96:	a8a5                	j	80003c0e <dirlookup+0xa0>
    panic("dirlookup not DIR");
    80003b98:	00005517          	auipc	a0,0x5
    80003b9c:	a4050513          	addi	a0,a0,-1472 # 800085d8 <syscalls+0x1a8>
    80003ba0:	ffffd097          	auipc	ra,0xffffd
    80003ba4:	998080e7          	jalr	-1640(ra) # 80000538 <panic>
      panic("dirlookup read");
    80003ba8:	00005517          	auipc	a0,0x5
    80003bac:	a4850513          	addi	a0,a0,-1464 # 800085f0 <syscalls+0x1c0>
    80003bb0:	ffffd097          	auipc	ra,0xffffd
    80003bb4:	988080e7          	jalr	-1656(ra) # 80000538 <panic>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003bb8:	24c1                	addiw	s1,s1,16
    80003bba:	04c92783          	lw	a5,76(s2)
    80003bbe:	04f4f763          	bgeu	s1,a5,80003c0c <dirlookup+0x9e>
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003bc2:	4741                	li	a4,16
    80003bc4:	86a6                	mv	a3,s1
    80003bc6:	fc040613          	addi	a2,s0,-64
    80003bca:	4581                	li	a1,0
    80003bcc:	854a                	mv	a0,s2
    80003bce:	00000097          	auipc	ra,0x0
    80003bd2:	d70080e7          	jalr	-656(ra) # 8000393e <readi>
    80003bd6:	47c1                	li	a5,16
    80003bd8:	fcf518e3          	bne	a0,a5,80003ba8 <dirlookup+0x3a>
    if(de.inum == 0)
    80003bdc:	fc045783          	lhu	a5,-64(s0)
    80003be0:	dfe1                	beqz	a5,80003bb8 <dirlookup+0x4a>
    if(namecmp(name, de.name) == 0){
    80003be2:	fc240593          	addi	a1,s0,-62
    80003be6:	854e                	mv	a0,s3
    80003be8:	00000097          	auipc	ra,0x0
    80003bec:	f6c080e7          	jalr	-148(ra) # 80003b54 <namecmp>
    80003bf0:	f561                	bnez	a0,80003bb8 <dirlookup+0x4a>
      if(poff)
    80003bf2:	000a0463          	beqz	s4,80003bfa <dirlookup+0x8c>
        *poff = off;
    80003bf6:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    80003bfa:	fc045583          	lhu	a1,-64(s0)
    80003bfe:	00092503          	lw	a0,0(s2)
    80003c02:	fffff097          	auipc	ra,0xfffff
    80003c06:	754080e7          	jalr	1876(ra) # 80003356 <iget>
    80003c0a:	a011                	j	80003c0e <dirlookup+0xa0>
  return 0;
    80003c0c:	4501                	li	a0,0
}
    80003c0e:	70e2                	ld	ra,56(sp)
    80003c10:	7442                	ld	s0,48(sp)
    80003c12:	74a2                	ld	s1,40(sp)
    80003c14:	7902                	ld	s2,32(sp)
    80003c16:	69e2                	ld	s3,24(sp)
    80003c18:	6a42                	ld	s4,16(sp)
    80003c1a:	6121                	addi	sp,sp,64
    80003c1c:	8082                	ret

0000000080003c1e <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
    80003c1e:	711d                	addi	sp,sp,-96
    80003c20:	ec86                	sd	ra,88(sp)
    80003c22:	e8a2                	sd	s0,80(sp)
    80003c24:	e4a6                	sd	s1,72(sp)
    80003c26:	e0ca                	sd	s2,64(sp)
    80003c28:	fc4e                	sd	s3,56(sp)
    80003c2a:	f852                	sd	s4,48(sp)
    80003c2c:	f456                	sd	s5,40(sp)
    80003c2e:	f05a                	sd	s6,32(sp)
    80003c30:	ec5e                	sd	s7,24(sp)
    80003c32:	e862                	sd	s8,16(sp)
    80003c34:	e466                	sd	s9,8(sp)
    80003c36:	1080                	addi	s0,sp,96
    80003c38:	84aa                	mv	s1,a0
    80003c3a:	8aae                	mv	s5,a1
    80003c3c:	8a32                	mv	s4,a2
  struct inode *ip, *next;

  if(*path == '/')
    80003c3e:	00054703          	lbu	a4,0(a0)
    80003c42:	02f00793          	li	a5,47
    80003c46:	02f70363          	beq	a4,a5,80003c6c <namex+0x4e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    80003c4a:	ffffe097          	auipc	ra,0xffffe
    80003c4e:	e1c080e7          	jalr	-484(ra) # 80001a66 <myproc>
    80003c52:	15053503          	ld	a0,336(a0)
    80003c56:	00000097          	auipc	ra,0x0
    80003c5a:	9f6080e7          	jalr	-1546(ra) # 8000364c <idup>
    80003c5e:	89aa                	mv	s3,a0
  while(*path == '/')
    80003c60:	02f00913          	li	s2,47
  len = path - s;
    80003c64:	4b01                	li	s6,0
  if(len >= DIRSIZ)
    80003c66:	4c35                	li	s8,13

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR){
    80003c68:	4b85                	li	s7,1
    80003c6a:	a865                	j	80003d22 <namex+0x104>
    ip = iget(ROOTDEV, ROOTINO);
    80003c6c:	4585                	li	a1,1
    80003c6e:	4505                	li	a0,1
    80003c70:	fffff097          	auipc	ra,0xfffff
    80003c74:	6e6080e7          	jalr	1766(ra) # 80003356 <iget>
    80003c78:	89aa                	mv	s3,a0
    80003c7a:	b7dd                	j	80003c60 <namex+0x42>
      iunlockput(ip);
    80003c7c:	854e                	mv	a0,s3
    80003c7e:	00000097          	auipc	ra,0x0
    80003c82:	c6e080e7          	jalr	-914(ra) # 800038ec <iunlockput>
      return 0;
    80003c86:	4981                	li	s3,0
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
    80003c88:	854e                	mv	a0,s3
    80003c8a:	60e6                	ld	ra,88(sp)
    80003c8c:	6446                	ld	s0,80(sp)
    80003c8e:	64a6                	ld	s1,72(sp)
    80003c90:	6906                	ld	s2,64(sp)
    80003c92:	79e2                	ld	s3,56(sp)
    80003c94:	7a42                	ld	s4,48(sp)
    80003c96:	7aa2                	ld	s5,40(sp)
    80003c98:	7b02                	ld	s6,32(sp)
    80003c9a:	6be2                	ld	s7,24(sp)
    80003c9c:	6c42                	ld	s8,16(sp)
    80003c9e:	6ca2                	ld	s9,8(sp)
    80003ca0:	6125                	addi	sp,sp,96
    80003ca2:	8082                	ret
      iunlock(ip);
    80003ca4:	854e                	mv	a0,s3
    80003ca6:	00000097          	auipc	ra,0x0
    80003caa:	aa6080e7          	jalr	-1370(ra) # 8000374c <iunlock>
      return ip;
    80003cae:	bfe9                	j	80003c88 <namex+0x6a>
      iunlockput(ip);
    80003cb0:	854e                	mv	a0,s3
    80003cb2:	00000097          	auipc	ra,0x0
    80003cb6:	c3a080e7          	jalr	-966(ra) # 800038ec <iunlockput>
      return 0;
    80003cba:	89e6                	mv	s3,s9
    80003cbc:	b7f1                	j	80003c88 <namex+0x6a>
  len = path - s;
    80003cbe:	40b48633          	sub	a2,s1,a1
    80003cc2:	00060c9b          	sext.w	s9,a2
  if(len >= DIRSIZ)
    80003cc6:	099c5463          	bge	s8,s9,80003d4e <namex+0x130>
    memmove(name, s, DIRSIZ);
    80003cca:	4639                	li	a2,14
    80003ccc:	8552                	mv	a0,s4
    80003cce:	ffffd097          	auipc	ra,0xffffd
    80003cd2:	05a080e7          	jalr	90(ra) # 80000d28 <memmove>
  while(*path == '/')
    80003cd6:	0004c783          	lbu	a5,0(s1)
    80003cda:	01279763          	bne	a5,s2,80003ce8 <namex+0xca>
    path++;
    80003cde:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003ce0:	0004c783          	lbu	a5,0(s1)
    80003ce4:	ff278de3          	beq	a5,s2,80003cde <namex+0xc0>
    ilock(ip);
    80003ce8:	854e                	mv	a0,s3
    80003cea:	00000097          	auipc	ra,0x0
    80003cee:	9a0080e7          	jalr	-1632(ra) # 8000368a <ilock>
    if(ip->type != T_DIR){
    80003cf2:	04499783          	lh	a5,68(s3)
    80003cf6:	f97793e3          	bne	a5,s7,80003c7c <namex+0x5e>
    if(nameiparent && *path == '\0'){
    80003cfa:	000a8563          	beqz	s5,80003d04 <namex+0xe6>
    80003cfe:	0004c783          	lbu	a5,0(s1)
    80003d02:	d3cd                	beqz	a5,80003ca4 <namex+0x86>
    if((next = dirlookup(ip, name, 0)) == 0){
    80003d04:	865a                	mv	a2,s6
    80003d06:	85d2                	mv	a1,s4
    80003d08:	854e                	mv	a0,s3
    80003d0a:	00000097          	auipc	ra,0x0
    80003d0e:	e64080e7          	jalr	-412(ra) # 80003b6e <dirlookup>
    80003d12:	8caa                	mv	s9,a0
    80003d14:	dd51                	beqz	a0,80003cb0 <namex+0x92>
    iunlockput(ip);
    80003d16:	854e                	mv	a0,s3
    80003d18:	00000097          	auipc	ra,0x0
    80003d1c:	bd4080e7          	jalr	-1068(ra) # 800038ec <iunlockput>
    ip = next;
    80003d20:	89e6                	mv	s3,s9
  while(*path == '/')
    80003d22:	0004c783          	lbu	a5,0(s1)
    80003d26:	05279763          	bne	a5,s2,80003d74 <namex+0x156>
    path++;
    80003d2a:	0485                	addi	s1,s1,1
  while(*path == '/')
    80003d2c:	0004c783          	lbu	a5,0(s1)
    80003d30:	ff278de3          	beq	a5,s2,80003d2a <namex+0x10c>
  if(*path == 0)
    80003d34:	c79d                	beqz	a5,80003d62 <namex+0x144>
    path++;
    80003d36:	85a6                	mv	a1,s1
  len = path - s;
    80003d38:	8cda                	mv	s9,s6
    80003d3a:	865a                	mv	a2,s6
  while(*path != '/' && *path != 0)
    80003d3c:	01278963          	beq	a5,s2,80003d4e <namex+0x130>
    80003d40:	dfbd                	beqz	a5,80003cbe <namex+0xa0>
    path++;
    80003d42:	0485                	addi	s1,s1,1
  while(*path != '/' && *path != 0)
    80003d44:	0004c783          	lbu	a5,0(s1)
    80003d48:	ff279ce3          	bne	a5,s2,80003d40 <namex+0x122>
    80003d4c:	bf8d                	j	80003cbe <namex+0xa0>
    memmove(name, s, len);
    80003d4e:	2601                	sext.w	a2,a2
    80003d50:	8552                	mv	a0,s4
    80003d52:	ffffd097          	auipc	ra,0xffffd
    80003d56:	fd6080e7          	jalr	-42(ra) # 80000d28 <memmove>
    name[len] = 0;
    80003d5a:	9cd2                	add	s9,s9,s4
    80003d5c:	000c8023          	sb	zero,0(s9) # 2000 <_entry-0x7fffe000>
    80003d60:	bf9d                	j	80003cd6 <namex+0xb8>
  if(nameiparent){
    80003d62:	f20a83e3          	beqz	s5,80003c88 <namex+0x6a>
    iput(ip);
    80003d66:	854e                	mv	a0,s3
    80003d68:	00000097          	auipc	ra,0x0
    80003d6c:	adc080e7          	jalr	-1316(ra) # 80003844 <iput>
    return 0;
    80003d70:	4981                	li	s3,0
    80003d72:	bf19                	j	80003c88 <namex+0x6a>
  if(*path == 0)
    80003d74:	d7fd                	beqz	a5,80003d62 <namex+0x144>
  while(*path != '/' && *path != 0)
    80003d76:	0004c783          	lbu	a5,0(s1)
    80003d7a:	85a6                	mv	a1,s1
    80003d7c:	b7d1                	j	80003d40 <namex+0x122>

0000000080003d7e <dirlink>:
{
    80003d7e:	7139                	addi	sp,sp,-64
    80003d80:	fc06                	sd	ra,56(sp)
    80003d82:	f822                	sd	s0,48(sp)
    80003d84:	f426                	sd	s1,40(sp)
    80003d86:	f04a                	sd	s2,32(sp)
    80003d88:	ec4e                	sd	s3,24(sp)
    80003d8a:	e852                	sd	s4,16(sp)
    80003d8c:	0080                	addi	s0,sp,64
    80003d8e:	892a                	mv	s2,a0
    80003d90:	8a2e                	mv	s4,a1
    80003d92:	89b2                	mv	s3,a2
  if((ip = dirlookup(dp, name, 0)) != 0){
    80003d94:	4601                	li	a2,0
    80003d96:	00000097          	auipc	ra,0x0
    80003d9a:	dd8080e7          	jalr	-552(ra) # 80003b6e <dirlookup>
    80003d9e:	e93d                	bnez	a0,80003e14 <dirlink+0x96>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003da0:	04c92483          	lw	s1,76(s2)
    80003da4:	c49d                	beqz	s1,80003dd2 <dirlink+0x54>
    80003da6:	4481                	li	s1,0
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003da8:	4741                	li	a4,16
    80003daa:	86a6                	mv	a3,s1
    80003dac:	fc040613          	addi	a2,s0,-64
    80003db0:	4581                	li	a1,0
    80003db2:	854a                	mv	a0,s2
    80003db4:	00000097          	auipc	ra,0x0
    80003db8:	b8a080e7          	jalr	-1142(ra) # 8000393e <readi>
    80003dbc:	47c1                	li	a5,16
    80003dbe:	06f51163          	bne	a0,a5,80003e20 <dirlink+0xa2>
    if(de.inum == 0)
    80003dc2:	fc045783          	lhu	a5,-64(s0)
    80003dc6:	c791                	beqz	a5,80003dd2 <dirlink+0x54>
  for(off = 0; off < dp->size; off += sizeof(de)){
    80003dc8:	24c1                	addiw	s1,s1,16
    80003dca:	04c92783          	lw	a5,76(s2)
    80003dce:	fcf4ede3          	bltu	s1,a5,80003da8 <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003dd2:	4639                	li	a2,14
    80003dd4:	85d2                	mv	a1,s4
    80003dd6:	fc240513          	addi	a0,s0,-62
    80003dda:	ffffd097          	auipc	ra,0xffffd
    80003dde:	006080e7          	jalr	6(ra) # 80000de0 <strncpy>
  de.inum = inum;
    80003de2:	fd341023          	sh	s3,-64(s0)
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003de6:	4741                	li	a4,16
    80003de8:	86a6                	mv	a3,s1
    80003dea:	fc040613          	addi	a2,s0,-64
    80003dee:	4581                	li	a1,0
    80003df0:	854a                	mv	a0,s2
    80003df2:	00000097          	auipc	ra,0x0
    80003df6:	c44080e7          	jalr	-956(ra) # 80003a36 <writei>
    80003dfa:	872a                	mv	a4,a0
    80003dfc:	47c1                	li	a5,16
  return 0;
    80003dfe:	4501                	li	a0,0
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003e00:	02f71863          	bne	a4,a5,80003e30 <dirlink+0xb2>
}
    80003e04:	70e2                	ld	ra,56(sp)
    80003e06:	7442                	ld	s0,48(sp)
    80003e08:	74a2                	ld	s1,40(sp)
    80003e0a:	7902                	ld	s2,32(sp)
    80003e0c:	69e2                	ld	s3,24(sp)
    80003e0e:	6a42                	ld	s4,16(sp)
    80003e10:	6121                	addi	sp,sp,64
    80003e12:	8082                	ret
    iput(ip);
    80003e14:	00000097          	auipc	ra,0x0
    80003e18:	a30080e7          	jalr	-1488(ra) # 80003844 <iput>
    return -1;
    80003e1c:	557d                	li	a0,-1
    80003e1e:	b7dd                	j	80003e04 <dirlink+0x86>
      panic("dirlink read");
    80003e20:	00004517          	auipc	a0,0x4
    80003e24:	7e050513          	addi	a0,a0,2016 # 80008600 <syscalls+0x1d0>
    80003e28:	ffffc097          	auipc	ra,0xffffc
    80003e2c:	710080e7          	jalr	1808(ra) # 80000538 <panic>
    panic("dirlink");
    80003e30:	00005517          	auipc	a0,0x5
    80003e34:	8e050513          	addi	a0,a0,-1824 # 80008710 <syscalls+0x2e0>
    80003e38:	ffffc097          	auipc	ra,0xffffc
    80003e3c:	700080e7          	jalr	1792(ra) # 80000538 <panic>

0000000080003e40 <namei>:

struct inode*
namei(char *path)
{
    80003e40:	1101                	addi	sp,sp,-32
    80003e42:	ec06                	sd	ra,24(sp)
    80003e44:	e822                	sd	s0,16(sp)
    80003e46:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    80003e48:	fe040613          	addi	a2,s0,-32
    80003e4c:	4581                	li	a1,0
    80003e4e:	00000097          	auipc	ra,0x0
    80003e52:	dd0080e7          	jalr	-560(ra) # 80003c1e <namex>
}
    80003e56:	60e2                	ld	ra,24(sp)
    80003e58:	6442                	ld	s0,16(sp)
    80003e5a:	6105                	addi	sp,sp,32
    80003e5c:	8082                	ret

0000000080003e5e <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
    80003e5e:	1141                	addi	sp,sp,-16
    80003e60:	e406                	sd	ra,8(sp)
    80003e62:	e022                	sd	s0,0(sp)
    80003e64:	0800                	addi	s0,sp,16
    80003e66:	862e                	mv	a2,a1
  return namex(path, 1, name);
    80003e68:	4585                	li	a1,1
    80003e6a:	00000097          	auipc	ra,0x0
    80003e6e:	db4080e7          	jalr	-588(ra) # 80003c1e <namex>
}
    80003e72:	60a2                	ld	ra,8(sp)
    80003e74:	6402                	ld	s0,0(sp)
    80003e76:	0141                	addi	sp,sp,16
    80003e78:	8082                	ret

0000000080003e7a <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    80003e7a:	1101                	addi	sp,sp,-32
    80003e7c:	ec06                	sd	ra,24(sp)
    80003e7e:	e822                	sd	s0,16(sp)
    80003e80:	e426                	sd	s1,8(sp)
    80003e82:	e04a                	sd	s2,0(sp)
    80003e84:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    80003e86:	0001d917          	auipc	s2,0x1d
    80003e8a:	3ea90913          	addi	s2,s2,1002 # 80021270 <log>
    80003e8e:	01892583          	lw	a1,24(s2)
    80003e92:	02892503          	lw	a0,40(s2)
    80003e96:	fffff097          	auipc	ra,0xfffff
    80003e9a:	ff0080e7          	jalr	-16(ra) # 80002e86 <bread>
    80003e9e:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    80003ea0:	02c92683          	lw	a3,44(s2)
    80003ea4:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    80003ea6:	02d05863          	blez	a3,80003ed6 <write_head+0x5c>
    80003eaa:	0001d797          	auipc	a5,0x1d
    80003eae:	3f678793          	addi	a5,a5,1014 # 800212a0 <log+0x30>
    80003eb2:	05c50713          	addi	a4,a0,92
    80003eb6:	36fd                	addiw	a3,a3,-1
    80003eb8:	02069613          	slli	a2,a3,0x20
    80003ebc:	01e65693          	srli	a3,a2,0x1e
    80003ec0:	0001d617          	auipc	a2,0x1d
    80003ec4:	3e460613          	addi	a2,a2,996 # 800212a4 <log+0x34>
    80003ec8:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003eca:	4390                	lw	a2,0(a5)
    80003ecc:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003ece:	0791                	addi	a5,a5,4
    80003ed0:	0711                	addi	a4,a4,4
    80003ed2:	fed79ce3          	bne	a5,a3,80003eca <write_head+0x50>
  }
  bwrite(buf);
    80003ed6:	8526                	mv	a0,s1
    80003ed8:	fffff097          	auipc	ra,0xfffff
    80003edc:	0a0080e7          	jalr	160(ra) # 80002f78 <bwrite>
  brelse(buf);
    80003ee0:	8526                	mv	a0,s1
    80003ee2:	fffff097          	auipc	ra,0xfffff
    80003ee6:	0d4080e7          	jalr	212(ra) # 80002fb6 <brelse>
}
    80003eea:	60e2                	ld	ra,24(sp)
    80003eec:	6442                	ld	s0,16(sp)
    80003eee:	64a2                	ld	s1,8(sp)
    80003ef0:	6902                	ld	s2,0(sp)
    80003ef2:	6105                	addi	sp,sp,32
    80003ef4:	8082                	ret

0000000080003ef6 <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    80003ef6:	0001d797          	auipc	a5,0x1d
    80003efa:	3a67a783          	lw	a5,934(a5) # 8002129c <log+0x2c>
    80003efe:	0af05d63          	blez	a5,80003fb8 <install_trans+0xc2>
{
    80003f02:	7139                	addi	sp,sp,-64
    80003f04:	fc06                	sd	ra,56(sp)
    80003f06:	f822                	sd	s0,48(sp)
    80003f08:	f426                	sd	s1,40(sp)
    80003f0a:	f04a                	sd	s2,32(sp)
    80003f0c:	ec4e                	sd	s3,24(sp)
    80003f0e:	e852                	sd	s4,16(sp)
    80003f10:	e456                	sd	s5,8(sp)
    80003f12:	e05a                	sd	s6,0(sp)
    80003f14:	0080                	addi	s0,sp,64
    80003f16:	8b2a                	mv	s6,a0
    80003f18:	0001da97          	auipc	s5,0x1d
    80003f1c:	388a8a93          	addi	s5,s5,904 # 800212a0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003f20:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003f22:	0001d997          	auipc	s3,0x1d
    80003f26:	34e98993          	addi	s3,s3,846 # 80021270 <log>
    80003f2a:	a00d                	j	80003f4c <install_trans+0x56>
    brelse(lbuf);
    80003f2c:	854a                	mv	a0,s2
    80003f2e:	fffff097          	auipc	ra,0xfffff
    80003f32:	088080e7          	jalr	136(ra) # 80002fb6 <brelse>
    brelse(dbuf);
    80003f36:	8526                	mv	a0,s1
    80003f38:	fffff097          	auipc	ra,0xfffff
    80003f3c:	07e080e7          	jalr	126(ra) # 80002fb6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003f40:	2a05                	addiw	s4,s4,1
    80003f42:	0a91                	addi	s5,s5,4
    80003f44:	02c9a783          	lw	a5,44(s3)
    80003f48:	04fa5e63          	bge	s4,a5,80003fa4 <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003f4c:	0189a583          	lw	a1,24(s3)
    80003f50:	014585bb          	addw	a1,a1,s4
    80003f54:	2585                	addiw	a1,a1,1
    80003f56:	0289a503          	lw	a0,40(s3)
    80003f5a:	fffff097          	auipc	ra,0xfffff
    80003f5e:	f2c080e7          	jalr	-212(ra) # 80002e86 <bread>
    80003f62:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    80003f64:	000aa583          	lw	a1,0(s5)
    80003f68:	0289a503          	lw	a0,40(s3)
    80003f6c:	fffff097          	auipc	ra,0xfffff
    80003f70:	f1a080e7          	jalr	-230(ra) # 80002e86 <bread>
    80003f74:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    80003f76:	40000613          	li	a2,1024
    80003f7a:	05890593          	addi	a1,s2,88
    80003f7e:	05850513          	addi	a0,a0,88
    80003f82:	ffffd097          	auipc	ra,0xffffd
    80003f86:	da6080e7          	jalr	-602(ra) # 80000d28 <memmove>
    bwrite(dbuf);  // write dst to disk
    80003f8a:	8526                	mv	a0,s1
    80003f8c:	fffff097          	auipc	ra,0xfffff
    80003f90:	fec080e7          	jalr	-20(ra) # 80002f78 <bwrite>
    if(recovering == 0)
    80003f94:	f80b1ce3          	bnez	s6,80003f2c <install_trans+0x36>
      bunpin(dbuf);
    80003f98:	8526                	mv	a0,s1
    80003f9a:	fffff097          	auipc	ra,0xfffff
    80003f9e:	0f6080e7          	jalr	246(ra) # 80003090 <bunpin>
    80003fa2:	b769                	j	80003f2c <install_trans+0x36>
}
    80003fa4:	70e2                	ld	ra,56(sp)
    80003fa6:	7442                	ld	s0,48(sp)
    80003fa8:	74a2                	ld	s1,40(sp)
    80003faa:	7902                	ld	s2,32(sp)
    80003fac:	69e2                	ld	s3,24(sp)
    80003fae:	6a42                	ld	s4,16(sp)
    80003fb0:	6aa2                	ld	s5,8(sp)
    80003fb2:	6b02                	ld	s6,0(sp)
    80003fb4:	6121                	addi	sp,sp,64
    80003fb6:	8082                	ret
    80003fb8:	8082                	ret

0000000080003fba <initlog>:
{
    80003fba:	7179                	addi	sp,sp,-48
    80003fbc:	f406                	sd	ra,40(sp)
    80003fbe:	f022                	sd	s0,32(sp)
    80003fc0:	ec26                	sd	s1,24(sp)
    80003fc2:	e84a                	sd	s2,16(sp)
    80003fc4:	e44e                	sd	s3,8(sp)
    80003fc6:	1800                	addi	s0,sp,48
    80003fc8:	892a                	mv	s2,a0
    80003fca:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003fcc:	0001d497          	auipc	s1,0x1d
    80003fd0:	2a448493          	addi	s1,s1,676 # 80021270 <log>
    80003fd4:	00004597          	auipc	a1,0x4
    80003fd8:	63c58593          	addi	a1,a1,1596 # 80008610 <syscalls+0x1e0>
    80003fdc:	8526                	mv	a0,s1
    80003fde:	ffffd097          	auipc	ra,0xffffd
    80003fe2:	b62080e7          	jalr	-1182(ra) # 80000b40 <initlock>
  log.start = sb->logstart;
    80003fe6:	0149a583          	lw	a1,20(s3)
    80003fea:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003fec:	0109a783          	lw	a5,16(s3)
    80003ff0:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003ff2:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    80003ff6:	854a                	mv	a0,s2
    80003ff8:	fffff097          	auipc	ra,0xfffff
    80003ffc:	e8e080e7          	jalr	-370(ra) # 80002e86 <bread>
  log.lh.n = lh->n;
    80004000:	4d34                	lw	a3,88(a0)
    80004002:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    80004004:	02d05663          	blez	a3,80004030 <initlog+0x76>
    80004008:	05c50793          	addi	a5,a0,92
    8000400c:	0001d717          	auipc	a4,0x1d
    80004010:	29470713          	addi	a4,a4,660 # 800212a0 <log+0x30>
    80004014:	36fd                	addiw	a3,a3,-1
    80004016:	02069613          	slli	a2,a3,0x20
    8000401a:	01e65693          	srli	a3,a2,0x1e
    8000401e:	06050613          	addi	a2,a0,96
    80004022:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    80004024:	4390                	lw	a2,0(a5)
    80004026:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80004028:	0791                	addi	a5,a5,4
    8000402a:	0711                	addi	a4,a4,4
    8000402c:	fed79ce3          	bne	a5,a3,80004024 <initlog+0x6a>
  brelse(buf);
    80004030:	fffff097          	auipc	ra,0xfffff
    80004034:	f86080e7          	jalr	-122(ra) # 80002fb6 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    80004038:	4505                	li	a0,1
    8000403a:	00000097          	auipc	ra,0x0
    8000403e:	ebc080e7          	jalr	-324(ra) # 80003ef6 <install_trans>
  log.lh.n = 0;
    80004042:	0001d797          	auipc	a5,0x1d
    80004046:	2407ad23          	sw	zero,602(a5) # 8002129c <log+0x2c>
  write_head(); // clear the log
    8000404a:	00000097          	auipc	ra,0x0
    8000404e:	e30080e7          	jalr	-464(ra) # 80003e7a <write_head>
}
    80004052:	70a2                	ld	ra,40(sp)
    80004054:	7402                	ld	s0,32(sp)
    80004056:	64e2                	ld	s1,24(sp)
    80004058:	6942                	ld	s2,16(sp)
    8000405a:	69a2                	ld	s3,8(sp)
    8000405c:	6145                	addi	sp,sp,48
    8000405e:	8082                	ret

0000000080004060 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80004060:	1101                	addi	sp,sp,-32
    80004062:	ec06                	sd	ra,24(sp)
    80004064:	e822                	sd	s0,16(sp)
    80004066:	e426                	sd	s1,8(sp)
    80004068:	e04a                	sd	s2,0(sp)
    8000406a:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    8000406c:	0001d517          	auipc	a0,0x1d
    80004070:	20450513          	addi	a0,a0,516 # 80021270 <log>
    80004074:	ffffd097          	auipc	ra,0xffffd
    80004078:	b5c080e7          	jalr	-1188(ra) # 80000bd0 <acquire>
  while(1){
    if(log.committing){
    8000407c:	0001d497          	auipc	s1,0x1d
    80004080:	1f448493          	addi	s1,s1,500 # 80021270 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004084:	4979                	li	s2,30
    80004086:	a039                	j	80004094 <begin_op+0x34>
      sleep(&log, &log.lock);
    80004088:	85a6                	mv	a1,s1
    8000408a:	8526                	mv	a0,s1
    8000408c:	ffffe097          	auipc	ra,0xffffe
    80004090:	09a080e7          	jalr	154(ra) # 80002126 <sleep>
    if(log.committing){
    80004094:	50dc                	lw	a5,36(s1)
    80004096:	fbed                	bnez	a5,80004088 <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    80004098:	509c                	lw	a5,32(s1)
    8000409a:	0017871b          	addiw	a4,a5,1
    8000409e:	0007069b          	sext.w	a3,a4
    800040a2:	0027179b          	slliw	a5,a4,0x2
    800040a6:	9fb9                	addw	a5,a5,a4
    800040a8:	0017979b          	slliw	a5,a5,0x1
    800040ac:	54d8                	lw	a4,44(s1)
    800040ae:	9fb9                	addw	a5,a5,a4
    800040b0:	00f95963          	bge	s2,a5,800040c2 <begin_op+0x62>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800040b4:	85a6                	mv	a1,s1
    800040b6:	8526                	mv	a0,s1
    800040b8:	ffffe097          	auipc	ra,0xffffe
    800040bc:	06e080e7          	jalr	110(ra) # 80002126 <sleep>
    800040c0:	bfd1                	j	80004094 <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800040c2:	0001d517          	auipc	a0,0x1d
    800040c6:	1ae50513          	addi	a0,a0,430 # 80021270 <log>
    800040ca:	d114                	sw	a3,32(a0)
      release(&log.lock);
    800040cc:	ffffd097          	auipc	ra,0xffffd
    800040d0:	bb8080e7          	jalr	-1096(ra) # 80000c84 <release>
      break;
    }
  }
}
    800040d4:	60e2                	ld	ra,24(sp)
    800040d6:	6442                	ld	s0,16(sp)
    800040d8:	64a2                	ld	s1,8(sp)
    800040da:	6902                	ld	s2,0(sp)
    800040dc:	6105                	addi	sp,sp,32
    800040de:	8082                	ret

00000000800040e0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    800040e0:	7139                	addi	sp,sp,-64
    800040e2:	fc06                	sd	ra,56(sp)
    800040e4:	f822                	sd	s0,48(sp)
    800040e6:	f426                	sd	s1,40(sp)
    800040e8:	f04a                	sd	s2,32(sp)
    800040ea:	ec4e                	sd	s3,24(sp)
    800040ec:	e852                	sd	s4,16(sp)
    800040ee:	e456                	sd	s5,8(sp)
    800040f0:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    800040f2:	0001d497          	auipc	s1,0x1d
    800040f6:	17e48493          	addi	s1,s1,382 # 80021270 <log>
    800040fa:	8526                	mv	a0,s1
    800040fc:	ffffd097          	auipc	ra,0xffffd
    80004100:	ad4080e7          	jalr	-1324(ra) # 80000bd0 <acquire>
  log.outstanding -= 1;
    80004104:	509c                	lw	a5,32(s1)
    80004106:	37fd                	addiw	a5,a5,-1
    80004108:	0007891b          	sext.w	s2,a5
    8000410c:	d09c                	sw	a5,32(s1)
  if(log.committing)
    8000410e:	50dc                	lw	a5,36(s1)
    80004110:	e7b9                	bnez	a5,8000415e <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    80004112:	04091e63          	bnez	s2,8000416e <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    80004116:	0001d497          	auipc	s1,0x1d
    8000411a:	15a48493          	addi	s1,s1,346 # 80021270 <log>
    8000411e:	4785                	li	a5,1
    80004120:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80004122:	8526                	mv	a0,s1
    80004124:	ffffd097          	auipc	ra,0xffffd
    80004128:	b60080e7          	jalr	-1184(ra) # 80000c84 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    8000412c:	54dc                	lw	a5,44(s1)
    8000412e:	06f04763          	bgtz	a5,8000419c <end_op+0xbc>
    acquire(&log.lock);
    80004132:	0001d497          	auipc	s1,0x1d
    80004136:	13e48493          	addi	s1,s1,318 # 80021270 <log>
    8000413a:	8526                	mv	a0,s1
    8000413c:	ffffd097          	auipc	ra,0xffffd
    80004140:	a94080e7          	jalr	-1388(ra) # 80000bd0 <acquire>
    log.committing = 0;
    80004144:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    80004148:	8526                	mv	a0,s1
    8000414a:	ffffe097          	auipc	ra,0xffffe
    8000414e:	168080e7          	jalr	360(ra) # 800022b2 <wakeup>
    release(&log.lock);
    80004152:	8526                	mv	a0,s1
    80004154:	ffffd097          	auipc	ra,0xffffd
    80004158:	b30080e7          	jalr	-1232(ra) # 80000c84 <release>
}
    8000415c:	a03d                	j	8000418a <end_op+0xaa>
    panic("log.committing");
    8000415e:	00004517          	auipc	a0,0x4
    80004162:	4ba50513          	addi	a0,a0,1210 # 80008618 <syscalls+0x1e8>
    80004166:	ffffc097          	auipc	ra,0xffffc
    8000416a:	3d2080e7          	jalr	978(ra) # 80000538 <panic>
    wakeup(&log);
    8000416e:	0001d497          	auipc	s1,0x1d
    80004172:	10248493          	addi	s1,s1,258 # 80021270 <log>
    80004176:	8526                	mv	a0,s1
    80004178:	ffffe097          	auipc	ra,0xffffe
    8000417c:	13a080e7          	jalr	314(ra) # 800022b2 <wakeup>
  release(&log.lock);
    80004180:	8526                	mv	a0,s1
    80004182:	ffffd097          	auipc	ra,0xffffd
    80004186:	b02080e7          	jalr	-1278(ra) # 80000c84 <release>
}
    8000418a:	70e2                	ld	ra,56(sp)
    8000418c:	7442                	ld	s0,48(sp)
    8000418e:	74a2                	ld	s1,40(sp)
    80004190:	7902                	ld	s2,32(sp)
    80004192:	69e2                	ld	s3,24(sp)
    80004194:	6a42                	ld	s4,16(sp)
    80004196:	6aa2                	ld	s5,8(sp)
    80004198:	6121                	addi	sp,sp,64
    8000419a:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    8000419c:	0001da97          	auipc	s5,0x1d
    800041a0:	104a8a93          	addi	s5,s5,260 # 800212a0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800041a4:	0001da17          	auipc	s4,0x1d
    800041a8:	0cca0a13          	addi	s4,s4,204 # 80021270 <log>
    800041ac:	018a2583          	lw	a1,24(s4)
    800041b0:	012585bb          	addw	a1,a1,s2
    800041b4:	2585                	addiw	a1,a1,1
    800041b6:	028a2503          	lw	a0,40(s4)
    800041ba:	fffff097          	auipc	ra,0xfffff
    800041be:	ccc080e7          	jalr	-820(ra) # 80002e86 <bread>
    800041c2:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800041c4:	000aa583          	lw	a1,0(s5)
    800041c8:	028a2503          	lw	a0,40(s4)
    800041cc:	fffff097          	auipc	ra,0xfffff
    800041d0:	cba080e7          	jalr	-838(ra) # 80002e86 <bread>
    800041d4:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    800041d6:	40000613          	li	a2,1024
    800041da:	05850593          	addi	a1,a0,88
    800041de:	05848513          	addi	a0,s1,88
    800041e2:	ffffd097          	auipc	ra,0xffffd
    800041e6:	b46080e7          	jalr	-1210(ra) # 80000d28 <memmove>
    bwrite(to);  // write the log
    800041ea:	8526                	mv	a0,s1
    800041ec:	fffff097          	auipc	ra,0xfffff
    800041f0:	d8c080e7          	jalr	-628(ra) # 80002f78 <bwrite>
    brelse(from);
    800041f4:	854e                	mv	a0,s3
    800041f6:	fffff097          	auipc	ra,0xfffff
    800041fa:	dc0080e7          	jalr	-576(ra) # 80002fb6 <brelse>
    brelse(to);
    800041fe:	8526                	mv	a0,s1
    80004200:	fffff097          	auipc	ra,0xfffff
    80004204:	db6080e7          	jalr	-586(ra) # 80002fb6 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80004208:	2905                	addiw	s2,s2,1
    8000420a:	0a91                	addi	s5,s5,4
    8000420c:	02ca2783          	lw	a5,44(s4)
    80004210:	f8f94ee3          	blt	s2,a5,800041ac <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80004214:	00000097          	auipc	ra,0x0
    80004218:	c66080e7          	jalr	-922(ra) # 80003e7a <write_head>
    install_trans(0); // Now install writes to home locations
    8000421c:	4501                	li	a0,0
    8000421e:	00000097          	auipc	ra,0x0
    80004222:	cd8080e7          	jalr	-808(ra) # 80003ef6 <install_trans>
    log.lh.n = 0;
    80004226:	0001d797          	auipc	a5,0x1d
    8000422a:	0607ab23          	sw	zero,118(a5) # 8002129c <log+0x2c>
    write_head();    // Erase the transaction from the log
    8000422e:	00000097          	auipc	ra,0x0
    80004232:	c4c080e7          	jalr	-948(ra) # 80003e7a <write_head>
    80004236:	bdf5                	j	80004132 <end_op+0x52>

0000000080004238 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    80004238:	1101                	addi	sp,sp,-32
    8000423a:	ec06                	sd	ra,24(sp)
    8000423c:	e822                	sd	s0,16(sp)
    8000423e:	e426                	sd	s1,8(sp)
    80004240:	e04a                	sd	s2,0(sp)
    80004242:	1000                	addi	s0,sp,32
    80004244:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    80004246:	0001d917          	auipc	s2,0x1d
    8000424a:	02a90913          	addi	s2,s2,42 # 80021270 <log>
    8000424e:	854a                	mv	a0,s2
    80004250:	ffffd097          	auipc	ra,0xffffd
    80004254:	980080e7          	jalr	-1664(ra) # 80000bd0 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    80004258:	02c92603          	lw	a2,44(s2)
    8000425c:	47f5                	li	a5,29
    8000425e:	06c7c563          	blt	a5,a2,800042c8 <log_write+0x90>
    80004262:	0001d797          	auipc	a5,0x1d
    80004266:	02a7a783          	lw	a5,42(a5) # 8002128c <log+0x1c>
    8000426a:	37fd                	addiw	a5,a5,-1
    8000426c:	04f65e63          	bge	a2,a5,800042c8 <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    80004270:	0001d797          	auipc	a5,0x1d
    80004274:	0207a783          	lw	a5,32(a5) # 80021290 <log+0x20>
    80004278:	06f05063          	blez	a5,800042d8 <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    8000427c:	4781                	li	a5,0
    8000427e:	06c05563          	blez	a2,800042e8 <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    80004282:	44cc                	lw	a1,12(s1)
    80004284:	0001d717          	auipc	a4,0x1d
    80004288:	01c70713          	addi	a4,a4,28 # 800212a0 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    8000428c:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorbtion
    8000428e:	4314                	lw	a3,0(a4)
    80004290:	04b68c63          	beq	a3,a1,800042e8 <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    80004294:	2785                	addiw	a5,a5,1
    80004296:	0711                	addi	a4,a4,4
    80004298:	fef61be3          	bne	a2,a5,8000428e <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    8000429c:	0621                	addi	a2,a2,8
    8000429e:	060a                	slli	a2,a2,0x2
    800042a0:	0001d797          	auipc	a5,0x1d
    800042a4:	fd078793          	addi	a5,a5,-48 # 80021270 <log>
    800042a8:	963e                	add	a2,a2,a5
    800042aa:	44dc                	lw	a5,12(s1)
    800042ac:	ca1c                	sw	a5,16(a2)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800042ae:	8526                	mv	a0,s1
    800042b0:	fffff097          	auipc	ra,0xfffff
    800042b4:	da4080e7          	jalr	-604(ra) # 80003054 <bpin>
    log.lh.n++;
    800042b8:	0001d717          	auipc	a4,0x1d
    800042bc:	fb870713          	addi	a4,a4,-72 # 80021270 <log>
    800042c0:	575c                	lw	a5,44(a4)
    800042c2:	2785                	addiw	a5,a5,1
    800042c4:	d75c                	sw	a5,44(a4)
    800042c6:	a835                	j	80004302 <log_write+0xca>
    panic("too big a transaction");
    800042c8:	00004517          	auipc	a0,0x4
    800042cc:	36050513          	addi	a0,a0,864 # 80008628 <syscalls+0x1f8>
    800042d0:	ffffc097          	auipc	ra,0xffffc
    800042d4:	268080e7          	jalr	616(ra) # 80000538 <panic>
    panic("log_write outside of trans");
    800042d8:	00004517          	auipc	a0,0x4
    800042dc:	36850513          	addi	a0,a0,872 # 80008640 <syscalls+0x210>
    800042e0:	ffffc097          	auipc	ra,0xffffc
    800042e4:	258080e7          	jalr	600(ra) # 80000538 <panic>
  log.lh.block[i] = b->blockno;
    800042e8:	00878713          	addi	a4,a5,8
    800042ec:	00271693          	slli	a3,a4,0x2
    800042f0:	0001d717          	auipc	a4,0x1d
    800042f4:	f8070713          	addi	a4,a4,-128 # 80021270 <log>
    800042f8:	9736                	add	a4,a4,a3
    800042fa:	44d4                	lw	a3,12(s1)
    800042fc:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    800042fe:	faf608e3          	beq	a2,a5,800042ae <log_write+0x76>
  }
  release(&log.lock);
    80004302:	0001d517          	auipc	a0,0x1d
    80004306:	f6e50513          	addi	a0,a0,-146 # 80021270 <log>
    8000430a:	ffffd097          	auipc	ra,0xffffd
    8000430e:	97a080e7          	jalr	-1670(ra) # 80000c84 <release>
}
    80004312:	60e2                	ld	ra,24(sp)
    80004314:	6442                	ld	s0,16(sp)
    80004316:	64a2                	ld	s1,8(sp)
    80004318:	6902                	ld	s2,0(sp)
    8000431a:	6105                	addi	sp,sp,32
    8000431c:	8082                	ret

000000008000431e <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    8000431e:	1101                	addi	sp,sp,-32
    80004320:	ec06                	sd	ra,24(sp)
    80004322:	e822                	sd	s0,16(sp)
    80004324:	e426                	sd	s1,8(sp)
    80004326:	e04a                	sd	s2,0(sp)
    80004328:	1000                	addi	s0,sp,32
    8000432a:	84aa                	mv	s1,a0
    8000432c:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    8000432e:	00004597          	auipc	a1,0x4
    80004332:	33258593          	addi	a1,a1,818 # 80008660 <syscalls+0x230>
    80004336:	0521                	addi	a0,a0,8
    80004338:	ffffd097          	auipc	ra,0xffffd
    8000433c:	808080e7          	jalr	-2040(ra) # 80000b40 <initlock>
  lk->name = name;
    80004340:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80004344:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80004348:	0204a423          	sw	zero,40(s1)
}
    8000434c:	60e2                	ld	ra,24(sp)
    8000434e:	6442                	ld	s0,16(sp)
    80004350:	64a2                	ld	s1,8(sp)
    80004352:	6902                	ld	s2,0(sp)
    80004354:	6105                	addi	sp,sp,32
    80004356:	8082                	ret

0000000080004358 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    80004358:	1101                	addi	sp,sp,-32
    8000435a:	ec06                	sd	ra,24(sp)
    8000435c:	e822                	sd	s0,16(sp)
    8000435e:	e426                	sd	s1,8(sp)
    80004360:	e04a                	sd	s2,0(sp)
    80004362:	1000                	addi	s0,sp,32
    80004364:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80004366:	00850913          	addi	s2,a0,8
    8000436a:	854a                	mv	a0,s2
    8000436c:	ffffd097          	auipc	ra,0xffffd
    80004370:	864080e7          	jalr	-1948(ra) # 80000bd0 <acquire>
  while (lk->locked) {
    80004374:	409c                	lw	a5,0(s1)
    80004376:	cb89                	beqz	a5,80004388 <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    80004378:	85ca                	mv	a1,s2
    8000437a:	8526                	mv	a0,s1
    8000437c:	ffffe097          	auipc	ra,0xffffe
    80004380:	daa080e7          	jalr	-598(ra) # 80002126 <sleep>
  while (lk->locked) {
    80004384:	409c                	lw	a5,0(s1)
    80004386:	fbed                	bnez	a5,80004378 <acquiresleep+0x20>
  }
  lk->locked = 1;
    80004388:	4785                	li	a5,1
    8000438a:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    8000438c:	ffffd097          	auipc	ra,0xffffd
    80004390:	6da080e7          	jalr	1754(ra) # 80001a66 <myproc>
    80004394:	591c                	lw	a5,48(a0)
    80004396:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    80004398:	854a                	mv	a0,s2
    8000439a:	ffffd097          	auipc	ra,0xffffd
    8000439e:	8ea080e7          	jalr	-1814(ra) # 80000c84 <release>
}
    800043a2:	60e2                	ld	ra,24(sp)
    800043a4:	6442                	ld	s0,16(sp)
    800043a6:	64a2                	ld	s1,8(sp)
    800043a8:	6902                	ld	s2,0(sp)
    800043aa:	6105                	addi	sp,sp,32
    800043ac:	8082                	ret

00000000800043ae <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800043ae:	1101                	addi	sp,sp,-32
    800043b0:	ec06                	sd	ra,24(sp)
    800043b2:	e822                	sd	s0,16(sp)
    800043b4:	e426                	sd	s1,8(sp)
    800043b6:	e04a                	sd	s2,0(sp)
    800043b8:	1000                	addi	s0,sp,32
    800043ba:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800043bc:	00850913          	addi	s2,a0,8
    800043c0:	854a                	mv	a0,s2
    800043c2:	ffffd097          	auipc	ra,0xffffd
    800043c6:	80e080e7          	jalr	-2034(ra) # 80000bd0 <acquire>
  lk->locked = 0;
    800043ca:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    800043ce:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    800043d2:	8526                	mv	a0,s1
    800043d4:	ffffe097          	auipc	ra,0xffffe
    800043d8:	ede080e7          	jalr	-290(ra) # 800022b2 <wakeup>
  release(&lk->lk);
    800043dc:	854a                	mv	a0,s2
    800043de:	ffffd097          	auipc	ra,0xffffd
    800043e2:	8a6080e7          	jalr	-1882(ra) # 80000c84 <release>
}
    800043e6:	60e2                	ld	ra,24(sp)
    800043e8:	6442                	ld	s0,16(sp)
    800043ea:	64a2                	ld	s1,8(sp)
    800043ec:	6902                	ld	s2,0(sp)
    800043ee:	6105                	addi	sp,sp,32
    800043f0:	8082                	ret

00000000800043f2 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    800043f2:	7179                	addi	sp,sp,-48
    800043f4:	f406                	sd	ra,40(sp)
    800043f6:	f022                	sd	s0,32(sp)
    800043f8:	ec26                	sd	s1,24(sp)
    800043fa:	e84a                	sd	s2,16(sp)
    800043fc:	e44e                	sd	s3,8(sp)
    800043fe:	1800                	addi	s0,sp,48
    80004400:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80004402:	00850913          	addi	s2,a0,8
    80004406:	854a                	mv	a0,s2
    80004408:	ffffc097          	auipc	ra,0xffffc
    8000440c:	7c8080e7          	jalr	1992(ra) # 80000bd0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80004410:	409c                	lw	a5,0(s1)
    80004412:	ef99                	bnez	a5,80004430 <holdingsleep+0x3e>
    80004414:	4481                	li	s1,0
  release(&lk->lk);
    80004416:	854a                	mv	a0,s2
    80004418:	ffffd097          	auipc	ra,0xffffd
    8000441c:	86c080e7          	jalr	-1940(ra) # 80000c84 <release>
  return r;
}
    80004420:	8526                	mv	a0,s1
    80004422:	70a2                	ld	ra,40(sp)
    80004424:	7402                	ld	s0,32(sp)
    80004426:	64e2                	ld	s1,24(sp)
    80004428:	6942                	ld	s2,16(sp)
    8000442a:	69a2                	ld	s3,8(sp)
    8000442c:	6145                	addi	sp,sp,48
    8000442e:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80004430:	0284a983          	lw	s3,40(s1)
    80004434:	ffffd097          	auipc	ra,0xffffd
    80004438:	632080e7          	jalr	1586(ra) # 80001a66 <myproc>
    8000443c:	5904                	lw	s1,48(a0)
    8000443e:	413484b3          	sub	s1,s1,s3
    80004442:	0014b493          	seqz	s1,s1
    80004446:	bfc1                	j	80004416 <holdingsleep+0x24>

0000000080004448 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    80004448:	1141                	addi	sp,sp,-16
    8000444a:	e406                	sd	ra,8(sp)
    8000444c:	e022                	sd	s0,0(sp)
    8000444e:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80004450:	00004597          	auipc	a1,0x4
    80004454:	22058593          	addi	a1,a1,544 # 80008670 <syscalls+0x240>
    80004458:	0001d517          	auipc	a0,0x1d
    8000445c:	f6050513          	addi	a0,a0,-160 # 800213b8 <ftable>
    80004460:	ffffc097          	auipc	ra,0xffffc
    80004464:	6e0080e7          	jalr	1760(ra) # 80000b40 <initlock>
}
    80004468:	60a2                	ld	ra,8(sp)
    8000446a:	6402                	ld	s0,0(sp)
    8000446c:	0141                	addi	sp,sp,16
    8000446e:	8082                	ret

0000000080004470 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    80004470:	1101                	addi	sp,sp,-32
    80004472:	ec06                	sd	ra,24(sp)
    80004474:	e822                	sd	s0,16(sp)
    80004476:	e426                	sd	s1,8(sp)
    80004478:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    8000447a:	0001d517          	auipc	a0,0x1d
    8000447e:	f3e50513          	addi	a0,a0,-194 # 800213b8 <ftable>
    80004482:	ffffc097          	auipc	ra,0xffffc
    80004486:	74e080e7          	jalr	1870(ra) # 80000bd0 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000448a:	0001d497          	auipc	s1,0x1d
    8000448e:	f4648493          	addi	s1,s1,-186 # 800213d0 <ftable+0x18>
    80004492:	0001e717          	auipc	a4,0x1e
    80004496:	ede70713          	addi	a4,a4,-290 # 80022370 <ftable+0xfb8>
    if(f->ref == 0){
    8000449a:	40dc                	lw	a5,4(s1)
    8000449c:	cf99                	beqz	a5,800044ba <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    8000449e:	02848493          	addi	s1,s1,40
    800044a2:	fee49ce3          	bne	s1,a4,8000449a <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800044a6:	0001d517          	auipc	a0,0x1d
    800044aa:	f1250513          	addi	a0,a0,-238 # 800213b8 <ftable>
    800044ae:	ffffc097          	auipc	ra,0xffffc
    800044b2:	7d6080e7          	jalr	2006(ra) # 80000c84 <release>
  return 0;
    800044b6:	4481                	li	s1,0
    800044b8:	a819                	j	800044ce <filealloc+0x5e>
      f->ref = 1;
    800044ba:	4785                	li	a5,1
    800044bc:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800044be:	0001d517          	auipc	a0,0x1d
    800044c2:	efa50513          	addi	a0,a0,-262 # 800213b8 <ftable>
    800044c6:	ffffc097          	auipc	ra,0xffffc
    800044ca:	7be080e7          	jalr	1982(ra) # 80000c84 <release>
}
    800044ce:	8526                	mv	a0,s1
    800044d0:	60e2                	ld	ra,24(sp)
    800044d2:	6442                	ld	s0,16(sp)
    800044d4:	64a2                	ld	s1,8(sp)
    800044d6:	6105                	addi	sp,sp,32
    800044d8:	8082                	ret

00000000800044da <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    800044da:	1101                	addi	sp,sp,-32
    800044dc:	ec06                	sd	ra,24(sp)
    800044de:	e822                	sd	s0,16(sp)
    800044e0:	e426                	sd	s1,8(sp)
    800044e2:	1000                	addi	s0,sp,32
    800044e4:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    800044e6:	0001d517          	auipc	a0,0x1d
    800044ea:	ed250513          	addi	a0,a0,-302 # 800213b8 <ftable>
    800044ee:	ffffc097          	auipc	ra,0xffffc
    800044f2:	6e2080e7          	jalr	1762(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    800044f6:	40dc                	lw	a5,4(s1)
    800044f8:	02f05263          	blez	a5,8000451c <filedup+0x42>
    panic("filedup");
  f->ref++;
    800044fc:	2785                	addiw	a5,a5,1
    800044fe:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80004500:	0001d517          	auipc	a0,0x1d
    80004504:	eb850513          	addi	a0,a0,-328 # 800213b8 <ftable>
    80004508:	ffffc097          	auipc	ra,0xffffc
    8000450c:	77c080e7          	jalr	1916(ra) # 80000c84 <release>
  return f;
}
    80004510:	8526                	mv	a0,s1
    80004512:	60e2                	ld	ra,24(sp)
    80004514:	6442                	ld	s0,16(sp)
    80004516:	64a2                	ld	s1,8(sp)
    80004518:	6105                	addi	sp,sp,32
    8000451a:	8082                	ret
    panic("filedup");
    8000451c:	00004517          	auipc	a0,0x4
    80004520:	15c50513          	addi	a0,a0,348 # 80008678 <syscalls+0x248>
    80004524:	ffffc097          	auipc	ra,0xffffc
    80004528:	014080e7          	jalr	20(ra) # 80000538 <panic>

000000008000452c <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    8000452c:	7139                	addi	sp,sp,-64
    8000452e:	fc06                	sd	ra,56(sp)
    80004530:	f822                	sd	s0,48(sp)
    80004532:	f426                	sd	s1,40(sp)
    80004534:	f04a                	sd	s2,32(sp)
    80004536:	ec4e                	sd	s3,24(sp)
    80004538:	e852                	sd	s4,16(sp)
    8000453a:	e456                	sd	s5,8(sp)
    8000453c:	0080                	addi	s0,sp,64
    8000453e:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80004540:	0001d517          	auipc	a0,0x1d
    80004544:	e7850513          	addi	a0,a0,-392 # 800213b8 <ftable>
    80004548:	ffffc097          	auipc	ra,0xffffc
    8000454c:	688080e7          	jalr	1672(ra) # 80000bd0 <acquire>
  if(f->ref < 1)
    80004550:	40dc                	lw	a5,4(s1)
    80004552:	06f05163          	blez	a5,800045b4 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80004556:	37fd                	addiw	a5,a5,-1
    80004558:	0007871b          	sext.w	a4,a5
    8000455c:	c0dc                	sw	a5,4(s1)
    8000455e:	06e04363          	bgtz	a4,800045c4 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80004562:	0004a903          	lw	s2,0(s1)
    80004566:	0094ca83          	lbu	s5,9(s1)
    8000456a:	0104ba03          	ld	s4,16(s1)
    8000456e:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80004572:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80004576:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    8000457a:	0001d517          	auipc	a0,0x1d
    8000457e:	e3e50513          	addi	a0,a0,-450 # 800213b8 <ftable>
    80004582:	ffffc097          	auipc	ra,0xffffc
    80004586:	702080e7          	jalr	1794(ra) # 80000c84 <release>

  if(ff.type == FD_PIPE){
    8000458a:	4785                	li	a5,1
    8000458c:	04f90d63          	beq	s2,a5,800045e6 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80004590:	3979                	addiw	s2,s2,-2
    80004592:	4785                	li	a5,1
    80004594:	0527e063          	bltu	a5,s2,800045d4 <fileclose+0xa8>
    begin_op();
    80004598:	00000097          	auipc	ra,0x0
    8000459c:	ac8080e7          	jalr	-1336(ra) # 80004060 <begin_op>
    iput(ff.ip);
    800045a0:	854e                	mv	a0,s3
    800045a2:	fffff097          	auipc	ra,0xfffff
    800045a6:	2a2080e7          	jalr	674(ra) # 80003844 <iput>
    end_op();
    800045aa:	00000097          	auipc	ra,0x0
    800045ae:	b36080e7          	jalr	-1226(ra) # 800040e0 <end_op>
    800045b2:	a00d                	j	800045d4 <fileclose+0xa8>
    panic("fileclose");
    800045b4:	00004517          	auipc	a0,0x4
    800045b8:	0cc50513          	addi	a0,a0,204 # 80008680 <syscalls+0x250>
    800045bc:	ffffc097          	auipc	ra,0xffffc
    800045c0:	f7c080e7          	jalr	-132(ra) # 80000538 <panic>
    release(&ftable.lock);
    800045c4:	0001d517          	auipc	a0,0x1d
    800045c8:	df450513          	addi	a0,a0,-524 # 800213b8 <ftable>
    800045cc:	ffffc097          	auipc	ra,0xffffc
    800045d0:	6b8080e7          	jalr	1720(ra) # 80000c84 <release>
  }
}
    800045d4:	70e2                	ld	ra,56(sp)
    800045d6:	7442                	ld	s0,48(sp)
    800045d8:	74a2                	ld	s1,40(sp)
    800045da:	7902                	ld	s2,32(sp)
    800045dc:	69e2                	ld	s3,24(sp)
    800045de:	6a42                	ld	s4,16(sp)
    800045e0:	6aa2                	ld	s5,8(sp)
    800045e2:	6121                	addi	sp,sp,64
    800045e4:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    800045e6:	85d6                	mv	a1,s5
    800045e8:	8552                	mv	a0,s4
    800045ea:	00000097          	auipc	ra,0x0
    800045ee:	34c080e7          	jalr	844(ra) # 80004936 <pipeclose>
    800045f2:	b7cd                	j	800045d4 <fileclose+0xa8>

00000000800045f4 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    800045f4:	715d                	addi	sp,sp,-80
    800045f6:	e486                	sd	ra,72(sp)
    800045f8:	e0a2                	sd	s0,64(sp)
    800045fa:	fc26                	sd	s1,56(sp)
    800045fc:	f84a                	sd	s2,48(sp)
    800045fe:	f44e                	sd	s3,40(sp)
    80004600:	0880                	addi	s0,sp,80
    80004602:	84aa                	mv	s1,a0
    80004604:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80004606:	ffffd097          	auipc	ra,0xffffd
    8000460a:	460080e7          	jalr	1120(ra) # 80001a66 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    8000460e:	409c                	lw	a5,0(s1)
    80004610:	37f9                	addiw	a5,a5,-2
    80004612:	4705                	li	a4,1
    80004614:	04f76763          	bltu	a4,a5,80004662 <filestat+0x6e>
    80004618:	892a                	mv	s2,a0
    ilock(f->ip);
    8000461a:	6c88                	ld	a0,24(s1)
    8000461c:	fffff097          	auipc	ra,0xfffff
    80004620:	06e080e7          	jalr	110(ra) # 8000368a <ilock>
    stati(f->ip, &st);
    80004624:	fb840593          	addi	a1,s0,-72
    80004628:	6c88                	ld	a0,24(s1)
    8000462a:	fffff097          	auipc	ra,0xfffff
    8000462e:	2ea080e7          	jalr	746(ra) # 80003914 <stati>
    iunlock(f->ip);
    80004632:	6c88                	ld	a0,24(s1)
    80004634:	fffff097          	auipc	ra,0xfffff
    80004638:	118080e7          	jalr	280(ra) # 8000374c <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    8000463c:	46e1                	li	a3,24
    8000463e:	fb840613          	addi	a2,s0,-72
    80004642:	85ce                	mv	a1,s3
    80004644:	05093503          	ld	a0,80(s2)
    80004648:	ffffd097          	auipc	ra,0xffffd
    8000464c:	004080e7          	jalr	4(ra) # 8000164c <copyout>
    80004650:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80004654:	60a6                	ld	ra,72(sp)
    80004656:	6406                	ld	s0,64(sp)
    80004658:	74e2                	ld	s1,56(sp)
    8000465a:	7942                	ld	s2,48(sp)
    8000465c:	79a2                	ld	s3,40(sp)
    8000465e:	6161                	addi	sp,sp,80
    80004660:	8082                	ret
  return -1;
    80004662:	557d                	li	a0,-1
    80004664:	bfc5                	j	80004654 <filestat+0x60>

0000000080004666 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80004666:	7179                	addi	sp,sp,-48
    80004668:	f406                	sd	ra,40(sp)
    8000466a:	f022                	sd	s0,32(sp)
    8000466c:	ec26                	sd	s1,24(sp)
    8000466e:	e84a                	sd	s2,16(sp)
    80004670:	e44e                	sd	s3,8(sp)
    80004672:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80004674:	00854783          	lbu	a5,8(a0)
    80004678:	c3d5                	beqz	a5,8000471c <fileread+0xb6>
    8000467a:	84aa                	mv	s1,a0
    8000467c:	89ae                	mv	s3,a1
    8000467e:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80004680:	411c                	lw	a5,0(a0)
    80004682:	4705                	li	a4,1
    80004684:	04e78963          	beq	a5,a4,800046d6 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004688:	470d                	li	a4,3
    8000468a:	04e78d63          	beq	a5,a4,800046e4 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    8000468e:	4709                	li	a4,2
    80004690:	06e79e63          	bne	a5,a4,8000470c <fileread+0xa6>
    ilock(f->ip);
    80004694:	6d08                	ld	a0,24(a0)
    80004696:	fffff097          	auipc	ra,0xfffff
    8000469a:	ff4080e7          	jalr	-12(ra) # 8000368a <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    8000469e:	874a                	mv	a4,s2
    800046a0:	5094                	lw	a3,32(s1)
    800046a2:	864e                	mv	a2,s3
    800046a4:	4585                	li	a1,1
    800046a6:	6c88                	ld	a0,24(s1)
    800046a8:	fffff097          	auipc	ra,0xfffff
    800046ac:	296080e7          	jalr	662(ra) # 8000393e <readi>
    800046b0:	892a                	mv	s2,a0
    800046b2:	00a05563          	blez	a0,800046bc <fileread+0x56>
      f->off += r;
    800046b6:	509c                	lw	a5,32(s1)
    800046b8:	9fa9                	addw	a5,a5,a0
    800046ba:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    800046bc:	6c88                	ld	a0,24(s1)
    800046be:	fffff097          	auipc	ra,0xfffff
    800046c2:	08e080e7          	jalr	142(ra) # 8000374c <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    800046c6:	854a                	mv	a0,s2
    800046c8:	70a2                	ld	ra,40(sp)
    800046ca:	7402                	ld	s0,32(sp)
    800046cc:	64e2                	ld	s1,24(sp)
    800046ce:	6942                	ld	s2,16(sp)
    800046d0:	69a2                	ld	s3,8(sp)
    800046d2:	6145                	addi	sp,sp,48
    800046d4:	8082                	ret
    r = piperead(f->pipe, addr, n);
    800046d6:	6908                	ld	a0,16(a0)
    800046d8:	00000097          	auipc	ra,0x0
    800046dc:	44c080e7          	jalr	1100(ra) # 80004b24 <piperead>
    800046e0:	892a                	mv	s2,a0
    800046e2:	b7d5                	j	800046c6 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    800046e4:	02451783          	lh	a5,36(a0)
    800046e8:	03079693          	slli	a3,a5,0x30
    800046ec:	92c1                	srli	a3,a3,0x30
    800046ee:	4725                	li	a4,9
    800046f0:	02d76863          	bltu	a4,a3,80004720 <fileread+0xba>
    800046f4:	0792                	slli	a5,a5,0x4
    800046f6:	0001d717          	auipc	a4,0x1d
    800046fa:	c2270713          	addi	a4,a4,-990 # 80021318 <devsw>
    800046fe:	97ba                	add	a5,a5,a4
    80004700:	639c                	ld	a5,0(a5)
    80004702:	c38d                	beqz	a5,80004724 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80004704:	4505                	li	a0,1
    80004706:	9782                	jalr	a5
    80004708:	892a                	mv	s2,a0
    8000470a:	bf75                	j	800046c6 <fileread+0x60>
    panic("fileread");
    8000470c:	00004517          	auipc	a0,0x4
    80004710:	f8450513          	addi	a0,a0,-124 # 80008690 <syscalls+0x260>
    80004714:	ffffc097          	auipc	ra,0xffffc
    80004718:	e24080e7          	jalr	-476(ra) # 80000538 <panic>
    return -1;
    8000471c:	597d                	li	s2,-1
    8000471e:	b765                	j	800046c6 <fileread+0x60>
      return -1;
    80004720:	597d                	li	s2,-1
    80004722:	b755                	j	800046c6 <fileread+0x60>
    80004724:	597d                	li	s2,-1
    80004726:	b745                	j	800046c6 <fileread+0x60>

0000000080004728 <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80004728:	715d                	addi	sp,sp,-80
    8000472a:	e486                	sd	ra,72(sp)
    8000472c:	e0a2                	sd	s0,64(sp)
    8000472e:	fc26                	sd	s1,56(sp)
    80004730:	f84a                	sd	s2,48(sp)
    80004732:	f44e                	sd	s3,40(sp)
    80004734:	f052                	sd	s4,32(sp)
    80004736:	ec56                	sd	s5,24(sp)
    80004738:	e85a                	sd	s6,16(sp)
    8000473a:	e45e                	sd	s7,8(sp)
    8000473c:	e062                	sd	s8,0(sp)
    8000473e:	0880                	addi	s0,sp,80
  int r, ret = 0;

  if(f->writable == 0)
    80004740:	00954783          	lbu	a5,9(a0)
    80004744:	10078663          	beqz	a5,80004850 <filewrite+0x128>
    80004748:	892a                	mv	s2,a0
    8000474a:	8aae                	mv	s5,a1
    8000474c:	8a32                	mv	s4,a2
    return -1;

  if(f->type == FD_PIPE){
    8000474e:	411c                	lw	a5,0(a0)
    80004750:	4705                	li	a4,1
    80004752:	02e78263          	beq	a5,a4,80004776 <filewrite+0x4e>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80004756:	470d                	li	a4,3
    80004758:	02e78663          	beq	a5,a4,80004784 <filewrite+0x5c>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
      return -1;
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    8000475c:	4709                	li	a4,2
    8000475e:	0ee79163          	bne	a5,a4,80004840 <filewrite+0x118>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80004762:	0ac05d63          	blez	a2,8000481c <filewrite+0xf4>
    int i = 0;
    80004766:	4981                	li	s3,0
    80004768:	6b05                	lui	s6,0x1
    8000476a:	c00b0b13          	addi	s6,s6,-1024 # c00 <_entry-0x7ffff400>
    8000476e:	6b85                	lui	s7,0x1
    80004770:	c00b8b9b          	addiw	s7,s7,-1024
    80004774:	a861                	j	8000480c <filewrite+0xe4>
    ret = pipewrite(f->pipe, addr, n);
    80004776:	6908                	ld	a0,16(a0)
    80004778:	00000097          	auipc	ra,0x0
    8000477c:	22e080e7          	jalr	558(ra) # 800049a6 <pipewrite>
    80004780:	8a2a                	mv	s4,a0
    80004782:	a045                	j	80004822 <filewrite+0xfa>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write)
    80004784:	02451783          	lh	a5,36(a0)
    80004788:	03079693          	slli	a3,a5,0x30
    8000478c:	92c1                	srli	a3,a3,0x30
    8000478e:	4725                	li	a4,9
    80004790:	0cd76263          	bltu	a4,a3,80004854 <filewrite+0x12c>
    80004794:	0792                	slli	a5,a5,0x4
    80004796:	0001d717          	auipc	a4,0x1d
    8000479a:	b8270713          	addi	a4,a4,-1150 # 80021318 <devsw>
    8000479e:	97ba                	add	a5,a5,a4
    800047a0:	679c                	ld	a5,8(a5)
    800047a2:	cbdd                	beqz	a5,80004858 <filewrite+0x130>
    ret = devsw[f->major].write(1, addr, n);
    800047a4:	4505                	li	a0,1
    800047a6:	9782                	jalr	a5
    800047a8:	8a2a                	mv	s4,a0
    800047aa:	a8a5                	j	80004822 <filewrite+0xfa>
    800047ac:	00048c1b          	sext.w	s8,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    800047b0:	00000097          	auipc	ra,0x0
    800047b4:	8b0080e7          	jalr	-1872(ra) # 80004060 <begin_op>
      ilock(f->ip);
    800047b8:	01893503          	ld	a0,24(s2)
    800047bc:	fffff097          	auipc	ra,0xfffff
    800047c0:	ece080e7          	jalr	-306(ra) # 8000368a <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    800047c4:	8762                	mv	a4,s8
    800047c6:	02092683          	lw	a3,32(s2)
    800047ca:	01598633          	add	a2,s3,s5
    800047ce:	4585                	li	a1,1
    800047d0:	01893503          	ld	a0,24(s2)
    800047d4:	fffff097          	auipc	ra,0xfffff
    800047d8:	262080e7          	jalr	610(ra) # 80003a36 <writei>
    800047dc:	84aa                	mv	s1,a0
    800047de:	00a05763          	blez	a0,800047ec <filewrite+0xc4>
        f->off += r;
    800047e2:	02092783          	lw	a5,32(s2)
    800047e6:	9fa9                	addw	a5,a5,a0
    800047e8:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    800047ec:	01893503          	ld	a0,24(s2)
    800047f0:	fffff097          	auipc	ra,0xfffff
    800047f4:	f5c080e7          	jalr	-164(ra) # 8000374c <iunlock>
      end_op();
    800047f8:	00000097          	auipc	ra,0x0
    800047fc:	8e8080e7          	jalr	-1816(ra) # 800040e0 <end_op>

      if(r != n1){
    80004800:	009c1f63          	bne	s8,s1,8000481e <filewrite+0xf6>
        // error from writei
        break;
      }
      i += r;
    80004804:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80004808:	0149db63          	bge	s3,s4,8000481e <filewrite+0xf6>
      int n1 = n - i;
    8000480c:	413a07bb          	subw	a5,s4,s3
      if(n1 > max)
    80004810:	84be                	mv	s1,a5
    80004812:	2781                	sext.w	a5,a5
    80004814:	f8fb5ce3          	bge	s6,a5,800047ac <filewrite+0x84>
    80004818:	84de                	mv	s1,s7
    8000481a:	bf49                	j	800047ac <filewrite+0x84>
    int i = 0;
    8000481c:	4981                	li	s3,0
    }
    ret = (i == n ? n : -1);
    8000481e:	013a1f63          	bne	s4,s3,8000483c <filewrite+0x114>
  } else {
    panic("filewrite");
  }

  return ret;
}
    80004822:	8552                	mv	a0,s4
    80004824:	60a6                	ld	ra,72(sp)
    80004826:	6406                	ld	s0,64(sp)
    80004828:	74e2                	ld	s1,56(sp)
    8000482a:	7942                	ld	s2,48(sp)
    8000482c:	79a2                	ld	s3,40(sp)
    8000482e:	7a02                	ld	s4,32(sp)
    80004830:	6ae2                	ld	s5,24(sp)
    80004832:	6b42                	ld	s6,16(sp)
    80004834:	6ba2                	ld	s7,8(sp)
    80004836:	6c02                	ld	s8,0(sp)
    80004838:	6161                	addi	sp,sp,80
    8000483a:	8082                	ret
    ret = (i == n ? n : -1);
    8000483c:	5a7d                	li	s4,-1
    8000483e:	b7d5                	j	80004822 <filewrite+0xfa>
    panic("filewrite");
    80004840:	00004517          	auipc	a0,0x4
    80004844:	e6050513          	addi	a0,a0,-416 # 800086a0 <syscalls+0x270>
    80004848:	ffffc097          	auipc	ra,0xffffc
    8000484c:	cf0080e7          	jalr	-784(ra) # 80000538 <panic>
    return -1;
    80004850:	5a7d                	li	s4,-1
    80004852:	bfc1                	j	80004822 <filewrite+0xfa>
      return -1;
    80004854:	5a7d                	li	s4,-1
    80004856:	b7f1                	j	80004822 <filewrite+0xfa>
    80004858:	5a7d                	li	s4,-1
    8000485a:	b7e1                	j	80004822 <filewrite+0xfa>

000000008000485c <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    8000485c:	7179                	addi	sp,sp,-48
    8000485e:	f406                	sd	ra,40(sp)
    80004860:	f022                	sd	s0,32(sp)
    80004862:	ec26                	sd	s1,24(sp)
    80004864:	e84a                	sd	s2,16(sp)
    80004866:	e44e                	sd	s3,8(sp)
    80004868:	e052                	sd	s4,0(sp)
    8000486a:	1800                	addi	s0,sp,48
    8000486c:	84aa                	mv	s1,a0
    8000486e:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80004870:	0005b023          	sd	zero,0(a1)
    80004874:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80004878:	00000097          	auipc	ra,0x0
    8000487c:	bf8080e7          	jalr	-1032(ra) # 80004470 <filealloc>
    80004880:	e088                	sd	a0,0(s1)
    80004882:	c551                	beqz	a0,8000490e <pipealloc+0xb2>
    80004884:	00000097          	auipc	ra,0x0
    80004888:	bec080e7          	jalr	-1044(ra) # 80004470 <filealloc>
    8000488c:	00aa3023          	sd	a0,0(s4)
    80004890:	c92d                	beqz	a0,80004902 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80004892:	ffffc097          	auipc	ra,0xffffc
    80004896:	24e080e7          	jalr	590(ra) # 80000ae0 <kalloc>
    8000489a:	892a                	mv	s2,a0
    8000489c:	c125                	beqz	a0,800048fc <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    8000489e:	4985                	li	s3,1
    800048a0:	43352023          	sw	s3,1056(a0)
  pi->writeopen = 1;
    800048a4:	43352223          	sw	s3,1060(a0)
  pi->nwrite = 0;
    800048a8:	40052e23          	sw	zero,1052(a0)
  pi->nread = 0;
    800048ac:	40052c23          	sw	zero,1048(a0)
  initlock(&pi->lock, "pipe");
    800048b0:	00004597          	auipc	a1,0x4
    800048b4:	e0058593          	addi	a1,a1,-512 # 800086b0 <syscalls+0x280>
    800048b8:	ffffc097          	auipc	ra,0xffffc
    800048bc:	288080e7          	jalr	648(ra) # 80000b40 <initlock>
  (*f0)->type = FD_PIPE;
    800048c0:	609c                	ld	a5,0(s1)
    800048c2:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    800048c6:	609c                	ld	a5,0(s1)
    800048c8:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    800048cc:	609c                	ld	a5,0(s1)
    800048ce:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    800048d2:	609c                	ld	a5,0(s1)
    800048d4:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    800048d8:	000a3783          	ld	a5,0(s4)
    800048dc:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    800048e0:	000a3783          	ld	a5,0(s4)
    800048e4:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    800048e8:	000a3783          	ld	a5,0(s4)
    800048ec:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    800048f0:	000a3783          	ld	a5,0(s4)
    800048f4:	0127b823          	sd	s2,16(a5)
  return 0;
    800048f8:	4501                	li	a0,0
    800048fa:	a025                	j	80004922 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    800048fc:	6088                	ld	a0,0(s1)
    800048fe:	e501                	bnez	a0,80004906 <pipealloc+0xaa>
    80004900:	a039                	j	8000490e <pipealloc+0xb2>
    80004902:	6088                	ld	a0,0(s1)
    80004904:	c51d                	beqz	a0,80004932 <pipealloc+0xd6>
    fileclose(*f0);
    80004906:	00000097          	auipc	ra,0x0
    8000490a:	c26080e7          	jalr	-986(ra) # 8000452c <fileclose>
  if(*f1)
    8000490e:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80004912:	557d                	li	a0,-1
  if(*f1)
    80004914:	c799                	beqz	a5,80004922 <pipealloc+0xc6>
    fileclose(*f1);
    80004916:	853e                	mv	a0,a5
    80004918:	00000097          	auipc	ra,0x0
    8000491c:	c14080e7          	jalr	-1004(ra) # 8000452c <fileclose>
  return -1;
    80004920:	557d                	li	a0,-1
}
    80004922:	70a2                	ld	ra,40(sp)
    80004924:	7402                	ld	s0,32(sp)
    80004926:	64e2                	ld	s1,24(sp)
    80004928:	6942                	ld	s2,16(sp)
    8000492a:	69a2                	ld	s3,8(sp)
    8000492c:	6a02                	ld	s4,0(sp)
    8000492e:	6145                	addi	sp,sp,48
    80004930:	8082                	ret
  return -1;
    80004932:	557d                	li	a0,-1
    80004934:	b7fd                	j	80004922 <pipealloc+0xc6>

0000000080004936 <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80004936:	1101                	addi	sp,sp,-32
    80004938:	ec06                	sd	ra,24(sp)
    8000493a:	e822                	sd	s0,16(sp)
    8000493c:	e426                	sd	s1,8(sp)
    8000493e:	e04a                	sd	s2,0(sp)
    80004940:	1000                	addi	s0,sp,32
    80004942:	84aa                	mv	s1,a0
    80004944:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80004946:	ffffc097          	auipc	ra,0xffffc
    8000494a:	28a080e7          	jalr	650(ra) # 80000bd0 <acquire>
  if(writable){
    8000494e:	02090d63          	beqz	s2,80004988 <pipeclose+0x52>
    pi->writeopen = 0;
    80004952:	4204a223          	sw	zero,1060(s1)
    wakeup(&pi->nread);
    80004956:	41848513          	addi	a0,s1,1048
    8000495a:	ffffe097          	auipc	ra,0xffffe
    8000495e:	958080e7          	jalr	-1704(ra) # 800022b2 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80004962:	4204b783          	ld	a5,1056(s1)
    80004966:	eb95                	bnez	a5,8000499a <pipeclose+0x64>
    release(&pi->lock);
    80004968:	8526                	mv	a0,s1
    8000496a:	ffffc097          	auipc	ra,0xffffc
    8000496e:	31a080e7          	jalr	794(ra) # 80000c84 <release>
    kfree((char*)pi);
    80004972:	8526                	mv	a0,s1
    80004974:	ffffc097          	auipc	ra,0xffffc
    80004978:	070080e7          	jalr	112(ra) # 800009e4 <kfree>
  } else
    release(&pi->lock);
}
    8000497c:	60e2                	ld	ra,24(sp)
    8000497e:	6442                	ld	s0,16(sp)
    80004980:	64a2                	ld	s1,8(sp)
    80004982:	6902                	ld	s2,0(sp)
    80004984:	6105                	addi	sp,sp,32
    80004986:	8082                	ret
    pi->readopen = 0;
    80004988:	4204a023          	sw	zero,1056(s1)
    wakeup(&pi->nwrite);
    8000498c:	41c48513          	addi	a0,s1,1052
    80004990:	ffffe097          	auipc	ra,0xffffe
    80004994:	922080e7          	jalr	-1758(ra) # 800022b2 <wakeup>
    80004998:	b7e9                	j	80004962 <pipeclose+0x2c>
    release(&pi->lock);
    8000499a:	8526                	mv	a0,s1
    8000499c:	ffffc097          	auipc	ra,0xffffc
    800049a0:	2e8080e7          	jalr	744(ra) # 80000c84 <release>
}
    800049a4:	bfe1                	j	8000497c <pipeclose+0x46>

00000000800049a6 <pipewrite>:


///My modification
int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    800049a6:	b9010113          	addi	sp,sp,-1136
    800049aa:	46113423          	sd	ra,1128(sp)
    800049ae:	46813023          	sd	s0,1120(sp)
    800049b2:	44913c23          	sd	s1,1112(sp)
    800049b6:	45213823          	sd	s2,1104(sp)
    800049ba:	45313423          	sd	s3,1096(sp)
    800049be:	45413023          	sd	s4,1088(sp)
    800049c2:	43513c23          	sd	s5,1080(sp)
    800049c6:	43613823          	sd	s6,1072(sp)
    800049ca:	43713423          	sd	s7,1064(sp)
    800049ce:	43813023          	sd	s8,1056(sp)
    800049d2:	41913c23          	sd	s9,1048(sp)
    800049d6:	41a13823          	sd	s10,1040(sp)
    800049da:	41b13423          	sd	s11,1032(sp)
    800049de:	47010413          	addi	s0,sp,1136
    800049e2:	892a                	mv	s2,a0
    800049e4:	8bae                	mv	s7,a1
    800049e6:	8b32                	mv	s6,a2
  int i = 0, cnt =n;
  struct proc *pr = myproc();
    800049e8:	ffffd097          	auipc	ra,0xffffd
    800049ec:	07e080e7          	jalr	126(ra) # 80001a66 <myproc>
    800049f0:	8aaa                	mv	s5,a0

  acquire(&pi->lock);
    800049f2:	854a                	mv	a0,s2
    800049f4:	ffffc097          	auipc	ra,0xffffc
    800049f8:	1dc080e7          	jalr	476(ra) # 80000bd0 <acquire>
  while(i < n){
    800049fc:	07605c63          	blez	s6,80004a74 <pipewrite+0xce>
  int i = 0, cnt =n;
    80004a00:	8a5a                	mv	s4,s6
    80004a02:	4981                	li	s3,0
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch[PIPESIZE];
      int k=PIPESIZE;
      if(cnt < PIPESIZE)
    80004a04:	3ff00c13          	li	s8,1023
        k = cnt;
      if(copyin(pr->pagetable, ch, addr + i, k) == -1)
    80004a08:	5cfd                	li	s9,-1
      wakeup(&pi->nread);
    80004a0a:	41890d93          	addi	s11,s2,1048
      sleep(&pi->nwrite, &pi->lock);
    80004a0e:	41c90d13          	addi	s10,s2,1052
    80004a12:	a8c1                	j	80004ae2 <pipewrite+0x13c>
      release(&pi->lock);
    80004a14:	854a                	mv	a0,s2
    80004a16:	ffffc097          	auipc	ra,0xffffc
    80004a1a:	26e080e7          	jalr	622(ra) # 80000c84 <release>
      return -1;
    80004a1e:	59fd                	li	s3,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80004a20:	854e                	mv	a0,s3
    80004a22:	46813083          	ld	ra,1128(sp)
    80004a26:	46013403          	ld	s0,1120(sp)
    80004a2a:	45813483          	ld	s1,1112(sp)
    80004a2e:	45013903          	ld	s2,1104(sp)
    80004a32:	44813983          	ld	s3,1096(sp)
    80004a36:	44013a03          	ld	s4,1088(sp)
    80004a3a:	43813a83          	ld	s5,1080(sp)
    80004a3e:	43013b03          	ld	s6,1072(sp)
    80004a42:	42813b83          	ld	s7,1064(sp)
    80004a46:	42013c03          	ld	s8,1056(sp)
    80004a4a:	41813c83          	ld	s9,1048(sp)
    80004a4e:	41013d03          	ld	s10,1040(sp)
    80004a52:	40813d83          	ld	s11,1032(sp)
    80004a56:	47010113          	addi	sp,sp,1136
    80004a5a:	8082                	ret
      wakeup(&pi->nread);
    80004a5c:	856e                	mv	a0,s11
    80004a5e:	ffffe097          	auipc	ra,0xffffe
    80004a62:	854080e7          	jalr	-1964(ra) # 800022b2 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80004a66:	85ca                	mv	a1,s2
    80004a68:	856a                	mv	a0,s10
    80004a6a:	ffffd097          	auipc	ra,0xffffd
    80004a6e:	6bc080e7          	jalr	1724(ra) # 80002126 <sleep>
    80004a72:	a0b5                	j	80004ade <pipewrite+0x138>
  int i = 0, cnt =n;
    80004a74:	4981                	li	s3,0
  wakeup(&pi->nread);
    80004a76:	41890513          	addi	a0,s2,1048
    80004a7a:	ffffe097          	auipc	ra,0xffffe
    80004a7e:	838080e7          	jalr	-1992(ra) # 800022b2 <wakeup>
  release(&pi->lock);
    80004a82:	854a                	mv	a0,s2
    80004a84:	ffffc097          	auipc	ra,0xffffc
    80004a88:	200080e7          	jalr	512(ra) # 80000c84 <release>
  return i;
    80004a8c:	bf51                	j	80004a20 <pipewrite+0x7a>
      if(copyin(pr->pagetable, ch, addr + i, k) == -1)
    80004a8e:	40000693          	li	a3,1024
    80004a92:	01798633          	add	a2,s3,s7
    80004a96:	b9040593          	addi	a1,s0,-1136
    80004a9a:	050ab503          	ld	a0,80(s5)
    80004a9e:	ffffd097          	auipc	ra,0xffffd
    80004aa2:	c3a080e7          	jalr	-966(ra) # 800016d8 <copyin>
    80004aa6:	fd9508e3          	beq	a0,s9,80004a76 <pipewrite+0xd0>
      int k=PIPESIZE;
    80004aaa:	40000593          	li	a1,1024
    80004aae:	41c92703          	lw	a4,1052(s2)
    80004ab2:	b9040693          	addi	a3,s0,-1136
        pi->data[pi->nwrite++ % PIPESIZE] = ch[j];
    80004ab6:	0007079b          	sext.w	a5,a4
    80004aba:	3ff7f793          	andi	a5,a5,1023
    80004abe:	2705                	addiw	a4,a4,1
    80004ac0:	97ca                	add	a5,a5,s2
    80004ac2:	0006c603          	lbu	a2,0(a3)
    80004ac6:	00c78c23          	sb	a2,24(a5)
      for(int j=0; j<k; j++){
    80004aca:	2485                	addiw	s1,s1,1
    80004acc:	0685                	addi	a3,a3,1
    80004ace:	feb4c4e3          	blt	s1,a1,80004ab6 <pipewrite+0x110>
    80004ad2:	40e92e23          	sw	a4,1052(s2)
      i+=k;
    80004ad6:	00b989bb          	addw	s3,s3,a1
      cnt -= k;
    80004ada:	40ba0a3b          	subw	s4,s4,a1
  while(i < n){
    80004ade:	f969dce3          	bge	s3,s6,80004a76 <pipewrite+0xd0>
    if(pi->readopen == 0 || pr->killed){
    80004ae2:	42092783          	lw	a5,1056(s2)
    80004ae6:	d79d                	beqz	a5,80004a14 <pipewrite+0x6e>
    80004ae8:	028aa483          	lw	s1,40(s5)
    80004aec:	f485                	bnez	s1,80004a14 <pipewrite+0x6e>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80004aee:	41892783          	lw	a5,1048(s2)
    80004af2:	41c92703          	lw	a4,1052(s2)
    80004af6:	4007879b          	addiw	a5,a5,1024
    80004afa:	f6f701e3          	beq	a4,a5,80004a5c <pipewrite+0xb6>
      if(cnt < PIPESIZE)
    80004afe:	f94c48e3          	blt	s8,s4,80004a8e <pipewrite+0xe8>
      if(copyin(pr->pagetable, ch, addr + i, k) == -1)
    80004b02:	86d2                	mv	a3,s4
    80004b04:	01798633          	add	a2,s3,s7
    80004b08:	b9040593          	addi	a1,s0,-1136
    80004b0c:	050ab503          	ld	a0,80(s5)
    80004b10:	ffffd097          	auipc	ra,0xffffd
    80004b14:	bc8080e7          	jalr	-1080(ra) # 800016d8 <copyin>
    80004b18:	f5950fe3          	beq	a0,s9,80004a76 <pipewrite+0xd0>
      for(int j=0; j<k; j++){
    80004b1c:	85d2                	mv	a1,s4
    80004b1e:	f94048e3          	bgtz	s4,80004aae <pipewrite+0x108>
    80004b22:	bf55                	j	80004ad6 <pipewrite+0x130>

0000000080004b24 <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    80004b24:	ba010113          	addi	sp,sp,-1120
    80004b28:	44113c23          	sd	ra,1112(sp)
    80004b2c:	44813823          	sd	s0,1104(sp)
    80004b30:	44913423          	sd	s1,1096(sp)
    80004b34:	45213023          	sd	s2,1088(sp)
    80004b38:	43313c23          	sd	s3,1080(sp)
    80004b3c:	43413823          	sd	s4,1072(sp)
    80004b40:	43513423          	sd	s5,1064(sp)
    80004b44:	43613023          	sd	s6,1056(sp)
    80004b48:	41713c23          	sd	s7,1048(sp)
    80004b4c:	41813823          	sd	s8,1040(sp)
    80004b50:	41913423          	sd	s9,1032(sp)
    80004b54:	46010413          	addi	s0,sp,1120
    80004b58:	84aa                	mv	s1,a0
    80004b5a:	8bae                	mv	s7,a1
    80004b5c:	8b32                	mv	s6,a2
  int i, cnt=n, k= PIPESIZE;
  struct proc *pr = myproc();
    80004b5e:	ffffd097          	auipc	ra,0xffffd
    80004b62:	f08080e7          	jalr	-248(ra) # 80001a66 <myproc>
    80004b66:	8aaa                	mv	s5,a0
  char ch[PIPESIZE];

  acquire(&pi->lock);
    80004b68:	8526                	mv	a0,s1
    80004b6a:	ffffc097          	auipc	ra,0xffffc
    80004b6e:	066080e7          	jalr	102(ra) # 80000bd0 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004b72:	4184a703          	lw	a4,1048(s1)
    80004b76:	41c4a783          	lw	a5,1052(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004b7a:	41848913          	addi	s2,s1,1048
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004b7e:	02f71463          	bne	a4,a5,80004ba6 <piperead+0x82>
    80004b82:	4244a783          	lw	a5,1060(s1)
    80004b86:	c385                	beqz	a5,80004ba6 <piperead+0x82>
    if(pr->killed){
    80004b88:	028aa783          	lw	a5,40(s5)
    80004b8c:	ebbd                	bnez	a5,80004c02 <piperead+0xde>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004b8e:	85a6                	mv	a1,s1
    80004b90:	854a                	mv	a0,s2
    80004b92:	ffffd097          	auipc	ra,0xffffd
    80004b96:	594080e7          	jalr	1428(ra) # 80002126 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004b9a:	4184a703          	lw	a4,1048(s1)
    80004b9e:	41c4a783          	lw	a5,1052(s1)
    80004ba2:	fef700e3          	beq	a4,a5,80004b82 <piperead+0x5e>
  }
  
  for(i = 0; i < n; i+=k){  //DOC: piperead-copy
    80004ba6:	8a5a                	mv	s4,s6
    80004ba8:	40000913          	li	s2,1024
    80004bac:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    if(cnt < PIPESIZE)
    80004bae:	3ff00c93          	li	s9,1023
    for(int j=0; j<k; j++){
	    ch[j] = pi->data[pi->nread++ % PIPESIZE];
    }
    cnt -= k;

	  if(copyout(pr->pagetable, addr + i, ch, k) == -1)
    80004bb2:	5c7d                	li	s8,-1
  for(i = 0; i < n; i+=k){  //DOC: piperead-copy
    80004bb4:	0b604863          	bgtz	s6,80004c64 <piperead+0x140>
	    break;
  }


  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    80004bb8:	41c48513          	addi	a0,s1,1052
    80004bbc:	ffffd097          	auipc	ra,0xffffd
    80004bc0:	6f6080e7          	jalr	1782(ra) # 800022b2 <wakeup>
  release(&pi->lock);
    80004bc4:	8526                	mv	a0,s1
    80004bc6:	ffffc097          	auipc	ra,0xffffc
    80004bca:	0be080e7          	jalr	190(ra) # 80000c84 <release>
  return i;
}
    80004bce:	854e                	mv	a0,s3
    80004bd0:	45813083          	ld	ra,1112(sp)
    80004bd4:	45013403          	ld	s0,1104(sp)
    80004bd8:	44813483          	ld	s1,1096(sp)
    80004bdc:	44013903          	ld	s2,1088(sp)
    80004be0:	43813983          	ld	s3,1080(sp)
    80004be4:	43013a03          	ld	s4,1072(sp)
    80004be8:	42813a83          	ld	s5,1064(sp)
    80004bec:	42013b03          	ld	s6,1056(sp)
    80004bf0:	41813b83          	ld	s7,1048(sp)
    80004bf4:	41013c03          	ld	s8,1040(sp)
    80004bf8:	40813c83          	ld	s9,1032(sp)
    80004bfc:	46010113          	addi	sp,sp,1120
    80004c00:	8082                	ret
      release(&pi->lock);
    80004c02:	8526                	mv	a0,s1
    80004c04:	ffffc097          	auipc	ra,0xffffc
    80004c08:	080080e7          	jalr	128(ra) # 80000c84 <release>
      return -1;
    80004c0c:	59fd                	li	s3,-1
    80004c0e:	b7c1                	j	80004bce <piperead+0xaa>
    for(int j=0; j<k; j++){
    80004c10:	03205763          	blez	s2,80004c3e <piperead+0x11a>
    80004c14:	ba040693          	addi	a3,s0,-1120
    80004c18:	00e905bb          	addw	a1,s2,a4
    80004c1c:	0005861b          	sext.w	a2,a1
	    ch[j] = pi->data[pi->nread++ % PIPESIZE];
    80004c20:	0007079b          	sext.w	a5,a4
    80004c24:	2705                	addiw	a4,a4,1
    80004c26:	3ff7f793          	andi	a5,a5,1023
    80004c2a:	97a6                	add	a5,a5,s1
    80004c2c:	0187c783          	lbu	a5,24(a5)
    80004c30:	00f68023          	sb	a5,0(a3)
    for(int j=0; j<k; j++){
    80004c34:	0685                	addi	a3,a3,1
    80004c36:	fec715e3          	bne	a4,a2,80004c20 <piperead+0xfc>
    80004c3a:	40b4ac23          	sw	a1,1048(s1)
    cnt -= k;
    80004c3e:	412a0a3b          	subw	s4,s4,s2
	  if(copyout(pr->pagetable, addr + i, ch, k) == -1)
    80004c42:	86ca                	mv	a3,s2
    80004c44:	ba040613          	addi	a2,s0,-1120
    80004c48:	017985b3          	add	a1,s3,s7
    80004c4c:	050ab503          	ld	a0,80(s5)
    80004c50:	ffffd097          	auipc	ra,0xffffd
    80004c54:	9fc080e7          	jalr	-1540(ra) # 8000164c <copyout>
    80004c58:	f78500e3          	beq	a0,s8,80004bb8 <piperead+0x94>
  for(i = 0; i < n; i+=k){  //DOC: piperead-copy
    80004c5c:	013909bb          	addw	s3,s2,s3
    80004c60:	f569dce3          	bge	s3,s6,80004bb8 <piperead+0x94>
    if(pi->nread == pi->nwrite)
    80004c64:	4184a703          	lw	a4,1048(s1)
    80004c68:	41c4a783          	lw	a5,1052(s1)
    80004c6c:	f4e786e3          	beq	a5,a4,80004bb8 <piperead+0x94>
    if(cnt < PIPESIZE)
    80004c70:	fb4cc0e3          	blt	s9,s4,80004c10 <piperead+0xec>
    80004c74:	8952                	mv	s2,s4
    80004c76:	bf69                	j	80004c10 <piperead+0xec>

0000000080004c78 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    80004c78:	de010113          	addi	sp,sp,-544
    80004c7c:	20113c23          	sd	ra,536(sp)
    80004c80:	20813823          	sd	s0,528(sp)
    80004c84:	20913423          	sd	s1,520(sp)
    80004c88:	21213023          	sd	s2,512(sp)
    80004c8c:	ffce                	sd	s3,504(sp)
    80004c8e:	fbd2                	sd	s4,496(sp)
    80004c90:	f7d6                	sd	s5,488(sp)
    80004c92:	f3da                	sd	s6,480(sp)
    80004c94:	efde                	sd	s7,472(sp)
    80004c96:	ebe2                	sd	s8,464(sp)
    80004c98:	e7e6                	sd	s9,456(sp)
    80004c9a:	e3ea                	sd	s10,448(sp)
    80004c9c:	ff6e                	sd	s11,440(sp)
    80004c9e:	1400                	addi	s0,sp,544
    80004ca0:	892a                	mv	s2,a0
    80004ca2:	dea43423          	sd	a0,-536(s0)
    80004ca6:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004caa:	ffffd097          	auipc	ra,0xffffd
    80004cae:	dbc080e7          	jalr	-580(ra) # 80001a66 <myproc>
    80004cb2:	84aa                	mv	s1,a0

  begin_op();
    80004cb4:	fffff097          	auipc	ra,0xfffff
    80004cb8:	3ac080e7          	jalr	940(ra) # 80004060 <begin_op>

  if((ip = namei(path)) == 0){
    80004cbc:	854a                	mv	a0,s2
    80004cbe:	fffff097          	auipc	ra,0xfffff
    80004cc2:	182080e7          	jalr	386(ra) # 80003e40 <namei>
    80004cc6:	c93d                	beqz	a0,80004d3c <exec+0xc4>
    80004cc8:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004cca:	fffff097          	auipc	ra,0xfffff
    80004cce:	9c0080e7          	jalr	-1600(ra) # 8000368a <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    80004cd2:	04000713          	li	a4,64
    80004cd6:	4681                	li	a3,0
    80004cd8:	e4840613          	addi	a2,s0,-440
    80004cdc:	4581                	li	a1,0
    80004cde:	8556                	mv	a0,s5
    80004ce0:	fffff097          	auipc	ra,0xfffff
    80004ce4:	c5e080e7          	jalr	-930(ra) # 8000393e <readi>
    80004ce8:	04000793          	li	a5,64
    80004cec:	00f51a63          	bne	a0,a5,80004d00 <exec+0x88>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    80004cf0:	e4842703          	lw	a4,-440(s0)
    80004cf4:	464c47b7          	lui	a5,0x464c4
    80004cf8:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004cfc:	04f70663          	beq	a4,a5,80004d48 <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    80004d00:	8556                	mv	a0,s5
    80004d02:	fffff097          	auipc	ra,0xfffff
    80004d06:	bea080e7          	jalr	-1046(ra) # 800038ec <iunlockput>
    end_op();
    80004d0a:	fffff097          	auipc	ra,0xfffff
    80004d0e:	3d6080e7          	jalr	982(ra) # 800040e0 <end_op>
  }
  return -1;
    80004d12:	557d                	li	a0,-1
}
    80004d14:	21813083          	ld	ra,536(sp)
    80004d18:	21013403          	ld	s0,528(sp)
    80004d1c:	20813483          	ld	s1,520(sp)
    80004d20:	20013903          	ld	s2,512(sp)
    80004d24:	79fe                	ld	s3,504(sp)
    80004d26:	7a5e                	ld	s4,496(sp)
    80004d28:	7abe                	ld	s5,488(sp)
    80004d2a:	7b1e                	ld	s6,480(sp)
    80004d2c:	6bfe                	ld	s7,472(sp)
    80004d2e:	6c5e                	ld	s8,464(sp)
    80004d30:	6cbe                	ld	s9,456(sp)
    80004d32:	6d1e                	ld	s10,448(sp)
    80004d34:	7dfa                	ld	s11,440(sp)
    80004d36:	22010113          	addi	sp,sp,544
    80004d3a:	8082                	ret
    end_op();
    80004d3c:	fffff097          	auipc	ra,0xfffff
    80004d40:	3a4080e7          	jalr	932(ra) # 800040e0 <end_op>
    return -1;
    80004d44:	557d                	li	a0,-1
    80004d46:	b7f9                	j	80004d14 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    80004d48:	8526                	mv	a0,s1
    80004d4a:	ffffd097          	auipc	ra,0xffffd
    80004d4e:	de0080e7          	jalr	-544(ra) # 80001b2a <proc_pagetable>
    80004d52:	8b2a                	mv	s6,a0
    80004d54:	d555                	beqz	a0,80004d00 <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004d56:	e6842783          	lw	a5,-408(s0)
    80004d5a:	e8045703          	lhu	a4,-384(s0)
    80004d5e:	c735                	beqz	a4,80004dca <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80004d60:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004d62:	e0043423          	sd	zero,-504(s0)
    if(ph.vaddr % PGSIZE != 0)
    80004d66:	6a05                	lui	s4,0x1
    80004d68:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    80004d6c:	dee43023          	sd	a4,-544(s0)
  uint64 pa;

  if((va % PGSIZE) != 0)
    panic("loadseg: va must be page aligned");

  for(i = 0; i < sz; i += PGSIZE){
    80004d70:	6d85                	lui	s11,0x1
    80004d72:	7d7d                	lui	s10,0xfffff
    80004d74:	ac1d                	j	80004faa <exec+0x332>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    80004d76:	00004517          	auipc	a0,0x4
    80004d7a:	94250513          	addi	a0,a0,-1726 # 800086b8 <syscalls+0x288>
    80004d7e:	ffffb097          	auipc	ra,0xffffb
    80004d82:	7ba080e7          	jalr	1978(ra) # 80000538 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004d86:	874a                	mv	a4,s2
    80004d88:	009c86bb          	addw	a3,s9,s1
    80004d8c:	4581                	li	a1,0
    80004d8e:	8556                	mv	a0,s5
    80004d90:	fffff097          	auipc	ra,0xfffff
    80004d94:	bae080e7          	jalr	-1106(ra) # 8000393e <readi>
    80004d98:	2501                	sext.w	a0,a0
    80004d9a:	1aa91863          	bne	s2,a0,80004f4a <exec+0x2d2>
  for(i = 0; i < sz; i += PGSIZE){
    80004d9e:	009d84bb          	addw	s1,s11,s1
    80004da2:	013d09bb          	addw	s3,s10,s3
    80004da6:	1f74f263          	bgeu	s1,s7,80004f8a <exec+0x312>
    pa = walkaddr(pagetable, va + i);
    80004daa:	02049593          	slli	a1,s1,0x20
    80004dae:	9181                	srli	a1,a1,0x20
    80004db0:	95e2                	add	a1,a1,s8
    80004db2:	855a                	mv	a0,s6
    80004db4:	ffffc097          	auipc	ra,0xffffc
    80004db8:	2a6080e7          	jalr	678(ra) # 8000105a <walkaddr>
    80004dbc:	862a                	mv	a2,a0
    if(pa == 0)
    80004dbe:	dd45                	beqz	a0,80004d76 <exec+0xfe>
      n = PGSIZE;
    80004dc0:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    80004dc2:	fd49f2e3          	bgeu	s3,s4,80004d86 <exec+0x10e>
      n = sz - i;
    80004dc6:	894e                	mv	s2,s3
    80004dc8:	bf7d                	j	80004d86 <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG+1], stackbase;
    80004dca:	4481                	li	s1,0
  iunlockput(ip);
    80004dcc:	8556                	mv	a0,s5
    80004dce:	fffff097          	auipc	ra,0xfffff
    80004dd2:	b1e080e7          	jalr	-1250(ra) # 800038ec <iunlockput>
  end_op();
    80004dd6:	fffff097          	auipc	ra,0xfffff
    80004dda:	30a080e7          	jalr	778(ra) # 800040e0 <end_op>
  p = myproc();
    80004dde:	ffffd097          	auipc	ra,0xffffd
    80004de2:	c88080e7          	jalr	-888(ra) # 80001a66 <myproc>
    80004de6:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004de8:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004dec:	6785                	lui	a5,0x1
    80004dee:	17fd                	addi	a5,a5,-1
    80004df0:	94be                	add	s1,s1,a5
    80004df2:	77fd                	lui	a5,0xfffff
    80004df4:	8fe5                	and	a5,a5,s1
    80004df6:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004dfa:	6609                	lui	a2,0x2
    80004dfc:	963e                	add	a2,a2,a5
    80004dfe:	85be                	mv	a1,a5
    80004e00:	855a                	mv	a0,s6
    80004e02:	ffffc097          	auipc	ra,0xffffc
    80004e06:	5fa080e7          	jalr	1530(ra) # 800013fc <uvmalloc>
    80004e0a:	8c2a                	mv	s8,a0
  ip = 0;
    80004e0c:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004e0e:	12050e63          	beqz	a0,80004f4a <exec+0x2d2>
  uvmclear(pagetable, sz-2*PGSIZE);
    80004e12:	75f9                	lui	a1,0xffffe
    80004e14:	95aa                	add	a1,a1,a0
    80004e16:	855a                	mv	a0,s6
    80004e18:	ffffd097          	auipc	ra,0xffffd
    80004e1c:	802080e7          	jalr	-2046(ra) # 8000161a <uvmclear>
  stackbase = sp - PGSIZE;
    80004e20:	7afd                	lui	s5,0xfffff
    80004e22:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    80004e24:	df043783          	ld	a5,-528(s0)
    80004e28:	6388                	ld	a0,0(a5)
    80004e2a:	c925                	beqz	a0,80004e9a <exec+0x222>
    80004e2c:	e8840993          	addi	s3,s0,-376
    80004e30:	f8840c93          	addi	s9,s0,-120
  sp = sz;
    80004e34:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004e36:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    80004e38:	ffffc097          	auipc	ra,0xffffc
    80004e3c:	018080e7          	jalr	24(ra) # 80000e50 <strlen>
    80004e40:	0015079b          	addiw	a5,a0,1
    80004e44:	40f90933          	sub	s2,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    80004e48:	ff097913          	andi	s2,s2,-16
    if(sp < stackbase)
    80004e4c:	13596363          	bltu	s2,s5,80004f72 <exec+0x2fa>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    80004e50:	df043d83          	ld	s11,-528(s0)
    80004e54:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    80004e58:	8552                	mv	a0,s4
    80004e5a:	ffffc097          	auipc	ra,0xffffc
    80004e5e:	ff6080e7          	jalr	-10(ra) # 80000e50 <strlen>
    80004e62:	0015069b          	addiw	a3,a0,1
    80004e66:	8652                	mv	a2,s4
    80004e68:	85ca                	mv	a1,s2
    80004e6a:	855a                	mv	a0,s6
    80004e6c:	ffffc097          	auipc	ra,0xffffc
    80004e70:	7e0080e7          	jalr	2016(ra) # 8000164c <copyout>
    80004e74:	10054363          	bltz	a0,80004f7a <exec+0x302>
    ustack[argc] = sp;
    80004e78:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    80004e7c:	0485                	addi	s1,s1,1
    80004e7e:	008d8793          	addi	a5,s11,8
    80004e82:	def43823          	sd	a5,-528(s0)
    80004e86:	008db503          	ld	a0,8(s11)
    80004e8a:	c911                	beqz	a0,80004e9e <exec+0x226>
    if(argc >= MAXARG)
    80004e8c:	09a1                	addi	s3,s3,8
    80004e8e:	fb3c95e3          	bne	s9,s3,80004e38 <exec+0x1c0>
  sz = sz1;
    80004e92:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004e96:	4a81                	li	s5,0
    80004e98:	a84d                	j	80004f4a <exec+0x2d2>
  sp = sz;
    80004e9a:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004e9c:	4481                	li	s1,0
  ustack[argc] = 0;
    80004e9e:	00349793          	slli	a5,s1,0x3
    80004ea2:	f9040713          	addi	a4,s0,-112
    80004ea6:	97ba                	add	a5,a5,a4
    80004ea8:	ee07bc23          	sd	zero,-264(a5) # ffffffffffffeef8 <end+0xffffffff7ffd88a0>
  sp -= (argc+1) * sizeof(uint64);
    80004eac:	00148693          	addi	a3,s1,1
    80004eb0:	068e                	slli	a3,a3,0x3
    80004eb2:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004eb6:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004eba:	01597663          	bgeu	s2,s5,80004ec6 <exec+0x24e>
  sz = sz1;
    80004ebe:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004ec2:	4a81                	li	s5,0
    80004ec4:	a059                	j	80004f4a <exec+0x2d2>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004ec6:	e8840613          	addi	a2,s0,-376
    80004eca:	85ca                	mv	a1,s2
    80004ecc:	855a                	mv	a0,s6
    80004ece:	ffffc097          	auipc	ra,0xffffc
    80004ed2:	77e080e7          	jalr	1918(ra) # 8000164c <copyout>
    80004ed6:	0a054663          	bltz	a0,80004f82 <exec+0x30a>
  p->trapframe->a1 = sp;
    80004eda:	058bb783          	ld	a5,88(s7) # 1058 <_entry-0x7fffefa8>
    80004ede:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    80004ee2:	de843783          	ld	a5,-536(s0)
    80004ee6:	0007c703          	lbu	a4,0(a5)
    80004eea:	cf11                	beqz	a4,80004f06 <exec+0x28e>
    80004eec:	0785                	addi	a5,a5,1
    if(*s == '/')
    80004eee:	02f00693          	li	a3,47
    80004ef2:	a039                	j	80004f00 <exec+0x288>
      last = s+1;
    80004ef4:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    80004ef8:	0785                	addi	a5,a5,1
    80004efa:	fff7c703          	lbu	a4,-1(a5)
    80004efe:	c701                	beqz	a4,80004f06 <exec+0x28e>
    if(*s == '/')
    80004f00:	fed71ce3          	bne	a4,a3,80004ef8 <exec+0x280>
    80004f04:	bfc5                	j	80004ef4 <exec+0x27c>
  safestrcpy(p->name, last, sizeof(p->name));
    80004f06:	4641                	li	a2,16
    80004f08:	de843583          	ld	a1,-536(s0)
    80004f0c:	158b8513          	addi	a0,s7,344
    80004f10:	ffffc097          	auipc	ra,0xffffc
    80004f14:	f0e080e7          	jalr	-242(ra) # 80000e1e <safestrcpy>
  oldpagetable = p->pagetable;
    80004f18:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    80004f1c:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    80004f20:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    80004f24:	058bb783          	ld	a5,88(s7)
    80004f28:	e6043703          	ld	a4,-416(s0)
    80004f2c:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    80004f2e:	058bb783          	ld	a5,88(s7)
    80004f32:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    80004f36:	85ea                	mv	a1,s10
    80004f38:	ffffd097          	auipc	ra,0xffffd
    80004f3c:	c8e080e7          	jalr	-882(ra) # 80001bc6 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    80004f40:	0004851b          	sext.w	a0,s1
    80004f44:	bbc1                	j	80004d14 <exec+0x9c>
    80004f46:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    80004f4a:	df843583          	ld	a1,-520(s0)
    80004f4e:	855a                	mv	a0,s6
    80004f50:	ffffd097          	auipc	ra,0xffffd
    80004f54:	c76080e7          	jalr	-906(ra) # 80001bc6 <proc_freepagetable>
  if(ip){
    80004f58:	da0a94e3          	bnez	s5,80004d00 <exec+0x88>
  return -1;
    80004f5c:	557d                	li	a0,-1
    80004f5e:	bb5d                	j	80004d14 <exec+0x9c>
    80004f60:	de943c23          	sd	s1,-520(s0)
    80004f64:	b7dd                	j	80004f4a <exec+0x2d2>
    80004f66:	de943c23          	sd	s1,-520(s0)
    80004f6a:	b7c5                	j	80004f4a <exec+0x2d2>
    80004f6c:	de943c23          	sd	s1,-520(s0)
    80004f70:	bfe9                	j	80004f4a <exec+0x2d2>
  sz = sz1;
    80004f72:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004f76:	4a81                	li	s5,0
    80004f78:	bfc9                	j	80004f4a <exec+0x2d2>
  sz = sz1;
    80004f7a:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004f7e:	4a81                	li	s5,0
    80004f80:	b7e9                	j	80004f4a <exec+0x2d2>
  sz = sz1;
    80004f82:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004f86:	4a81                	li	s5,0
    80004f88:	b7c9                	j	80004f4a <exec+0x2d2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004f8a:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    80004f8e:	e0843783          	ld	a5,-504(s0)
    80004f92:	0017869b          	addiw	a3,a5,1
    80004f96:	e0d43423          	sd	a3,-504(s0)
    80004f9a:	e0043783          	ld	a5,-512(s0)
    80004f9e:	0387879b          	addiw	a5,a5,56
    80004fa2:	e8045703          	lhu	a4,-384(s0)
    80004fa6:	e2e6d3e3          	bge	a3,a4,80004dcc <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004faa:	2781                	sext.w	a5,a5
    80004fac:	e0f43023          	sd	a5,-512(s0)
    80004fb0:	03800713          	li	a4,56
    80004fb4:	86be                	mv	a3,a5
    80004fb6:	e1040613          	addi	a2,s0,-496
    80004fba:	4581                	li	a1,0
    80004fbc:	8556                	mv	a0,s5
    80004fbe:	fffff097          	auipc	ra,0xfffff
    80004fc2:	980080e7          	jalr	-1664(ra) # 8000393e <readi>
    80004fc6:	03800793          	li	a5,56
    80004fca:	f6f51ee3          	bne	a0,a5,80004f46 <exec+0x2ce>
    if(ph.type != ELF_PROG_LOAD)
    80004fce:	e1042783          	lw	a5,-496(s0)
    80004fd2:	4705                	li	a4,1
    80004fd4:	fae79de3          	bne	a5,a4,80004f8e <exec+0x316>
    if(ph.memsz < ph.filesz)
    80004fd8:	e3843603          	ld	a2,-456(s0)
    80004fdc:	e3043783          	ld	a5,-464(s0)
    80004fe0:	f8f660e3          	bltu	a2,a5,80004f60 <exec+0x2e8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004fe4:	e2043783          	ld	a5,-480(s0)
    80004fe8:	963e                	add	a2,a2,a5
    80004fea:	f6f66ee3          	bltu	a2,a5,80004f66 <exec+0x2ee>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004fee:	85a6                	mv	a1,s1
    80004ff0:	855a                	mv	a0,s6
    80004ff2:	ffffc097          	auipc	ra,0xffffc
    80004ff6:	40a080e7          	jalr	1034(ra) # 800013fc <uvmalloc>
    80004ffa:	dea43c23          	sd	a0,-520(s0)
    80004ffe:	d53d                	beqz	a0,80004f6c <exec+0x2f4>
    if(ph.vaddr % PGSIZE != 0)
    80005000:	e2043c03          	ld	s8,-480(s0)
    80005004:	de043783          	ld	a5,-544(s0)
    80005008:	00fc77b3          	and	a5,s8,a5
    8000500c:	ff9d                	bnez	a5,80004f4a <exec+0x2d2>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000500e:	e1842c83          	lw	s9,-488(s0)
    80005012:	e3042b83          	lw	s7,-464(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80005016:	f60b8ae3          	beqz	s7,80004f8a <exec+0x312>
    8000501a:	89de                	mv	s3,s7
    8000501c:	4481                	li	s1,0
    8000501e:	b371                	j	80004daa <exec+0x132>

0000000080005020 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    80005020:	7179                	addi	sp,sp,-48
    80005022:	f406                	sd	ra,40(sp)
    80005024:	f022                	sd	s0,32(sp)
    80005026:	ec26                	sd	s1,24(sp)
    80005028:	e84a                	sd	s2,16(sp)
    8000502a:	1800                	addi	s0,sp,48
    8000502c:	892e                	mv	s2,a1
    8000502e:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    80005030:	fdc40593          	addi	a1,s0,-36
    80005034:	ffffe097          	auipc	ra,0xffffe
    80005038:	ae4080e7          	jalr	-1308(ra) # 80002b18 <argint>
    8000503c:	04054063          	bltz	a0,8000507c <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    80005040:	fdc42703          	lw	a4,-36(s0)
    80005044:	47bd                	li	a5,15
    80005046:	02e7ed63          	bltu	a5,a4,80005080 <argfd+0x60>
    8000504a:	ffffd097          	auipc	ra,0xffffd
    8000504e:	a1c080e7          	jalr	-1508(ra) # 80001a66 <myproc>
    80005052:	fdc42703          	lw	a4,-36(s0)
    80005056:	01a70793          	addi	a5,a4,26
    8000505a:	078e                	slli	a5,a5,0x3
    8000505c:	953e                	add	a0,a0,a5
    8000505e:	611c                	ld	a5,0(a0)
    80005060:	c395                	beqz	a5,80005084 <argfd+0x64>
    return -1;
  if(pfd)
    80005062:	00090463          	beqz	s2,8000506a <argfd+0x4a>
    *pfd = fd;
    80005066:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    8000506a:	4501                	li	a0,0
  if(pf)
    8000506c:	c091                	beqz	s1,80005070 <argfd+0x50>
    *pf = f;
    8000506e:	e09c                	sd	a5,0(s1)
}
    80005070:	70a2                	ld	ra,40(sp)
    80005072:	7402                	ld	s0,32(sp)
    80005074:	64e2                	ld	s1,24(sp)
    80005076:	6942                	ld	s2,16(sp)
    80005078:	6145                	addi	sp,sp,48
    8000507a:	8082                	ret
    return -1;
    8000507c:	557d                	li	a0,-1
    8000507e:	bfcd                	j	80005070 <argfd+0x50>
    return -1;
    80005080:	557d                	li	a0,-1
    80005082:	b7fd                	j	80005070 <argfd+0x50>
    80005084:	557d                	li	a0,-1
    80005086:	b7ed                	j	80005070 <argfd+0x50>

0000000080005088 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80005088:	1101                	addi	sp,sp,-32
    8000508a:	ec06                	sd	ra,24(sp)
    8000508c:	e822                	sd	s0,16(sp)
    8000508e:	e426                	sd	s1,8(sp)
    80005090:	1000                	addi	s0,sp,32
    80005092:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80005094:	ffffd097          	auipc	ra,0xffffd
    80005098:	9d2080e7          	jalr	-1582(ra) # 80001a66 <myproc>
    8000509c:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000509e:	0d050793          	addi	a5,a0,208
    800050a2:	4501                	li	a0,0
    800050a4:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    800050a6:	6398                	ld	a4,0(a5)
    800050a8:	cb19                	beqz	a4,800050be <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    800050aa:	2505                	addiw	a0,a0,1
    800050ac:	07a1                	addi	a5,a5,8
    800050ae:	fed51ce3          	bne	a0,a3,800050a6 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    800050b2:	557d                	li	a0,-1
}
    800050b4:	60e2                	ld	ra,24(sp)
    800050b6:	6442                	ld	s0,16(sp)
    800050b8:	64a2                	ld	s1,8(sp)
    800050ba:	6105                	addi	sp,sp,32
    800050bc:	8082                	ret
      p->ofile[fd] = f;
    800050be:	01a50793          	addi	a5,a0,26
    800050c2:	078e                	slli	a5,a5,0x3
    800050c4:	963e                	add	a2,a2,a5
    800050c6:	e204                	sd	s1,0(a2)
      return fd;
    800050c8:	b7f5                	j	800050b4 <fdalloc+0x2c>

00000000800050ca <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    800050ca:	715d                	addi	sp,sp,-80
    800050cc:	e486                	sd	ra,72(sp)
    800050ce:	e0a2                	sd	s0,64(sp)
    800050d0:	fc26                	sd	s1,56(sp)
    800050d2:	f84a                	sd	s2,48(sp)
    800050d4:	f44e                	sd	s3,40(sp)
    800050d6:	f052                	sd	s4,32(sp)
    800050d8:	ec56                	sd	s5,24(sp)
    800050da:	0880                	addi	s0,sp,80
    800050dc:	89ae                	mv	s3,a1
    800050de:	8ab2                	mv	s5,a2
    800050e0:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    800050e2:	fb040593          	addi	a1,s0,-80
    800050e6:	fffff097          	auipc	ra,0xfffff
    800050ea:	d78080e7          	jalr	-648(ra) # 80003e5e <nameiparent>
    800050ee:	892a                	mv	s2,a0
    800050f0:	12050e63          	beqz	a0,8000522c <create+0x162>
    return 0;

  ilock(dp);
    800050f4:	ffffe097          	auipc	ra,0xffffe
    800050f8:	596080e7          	jalr	1430(ra) # 8000368a <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    800050fc:	4601                	li	a2,0
    800050fe:	fb040593          	addi	a1,s0,-80
    80005102:	854a                	mv	a0,s2
    80005104:	fffff097          	auipc	ra,0xfffff
    80005108:	a6a080e7          	jalr	-1430(ra) # 80003b6e <dirlookup>
    8000510c:	84aa                	mv	s1,a0
    8000510e:	c921                	beqz	a0,8000515e <create+0x94>
    iunlockput(dp);
    80005110:	854a                	mv	a0,s2
    80005112:	ffffe097          	auipc	ra,0xffffe
    80005116:	7da080e7          	jalr	2010(ra) # 800038ec <iunlockput>
    ilock(ip);
    8000511a:	8526                	mv	a0,s1
    8000511c:	ffffe097          	auipc	ra,0xffffe
    80005120:	56e080e7          	jalr	1390(ra) # 8000368a <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    80005124:	2981                	sext.w	s3,s3
    80005126:	4789                	li	a5,2
    80005128:	02f99463          	bne	s3,a5,80005150 <create+0x86>
    8000512c:	0444d783          	lhu	a5,68(s1)
    80005130:	37f9                	addiw	a5,a5,-2
    80005132:	17c2                	slli	a5,a5,0x30
    80005134:	93c1                	srli	a5,a5,0x30
    80005136:	4705                	li	a4,1
    80005138:	00f76c63          	bltu	a4,a5,80005150 <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    8000513c:	8526                	mv	a0,s1
    8000513e:	60a6                	ld	ra,72(sp)
    80005140:	6406                	ld	s0,64(sp)
    80005142:	74e2                	ld	s1,56(sp)
    80005144:	7942                	ld	s2,48(sp)
    80005146:	79a2                	ld	s3,40(sp)
    80005148:	7a02                	ld	s4,32(sp)
    8000514a:	6ae2                	ld	s5,24(sp)
    8000514c:	6161                	addi	sp,sp,80
    8000514e:	8082                	ret
    iunlockput(ip);
    80005150:	8526                	mv	a0,s1
    80005152:	ffffe097          	auipc	ra,0xffffe
    80005156:	79a080e7          	jalr	1946(ra) # 800038ec <iunlockput>
    return 0;
    8000515a:	4481                	li	s1,0
    8000515c:	b7c5                	j	8000513c <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    8000515e:	85ce                	mv	a1,s3
    80005160:	00092503          	lw	a0,0(s2)
    80005164:	ffffe097          	auipc	ra,0xffffe
    80005168:	38e080e7          	jalr	910(ra) # 800034f2 <ialloc>
    8000516c:	84aa                	mv	s1,a0
    8000516e:	c521                	beqz	a0,800051b6 <create+0xec>
  ilock(ip);
    80005170:	ffffe097          	auipc	ra,0xffffe
    80005174:	51a080e7          	jalr	1306(ra) # 8000368a <ilock>
  ip->major = major;
    80005178:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    8000517c:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    80005180:	4a05                	li	s4,1
    80005182:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    80005186:	8526                	mv	a0,s1
    80005188:	ffffe097          	auipc	ra,0xffffe
    8000518c:	438080e7          	jalr	1080(ra) # 800035c0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    80005190:	2981                	sext.w	s3,s3
    80005192:	03498a63          	beq	s3,s4,800051c6 <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    80005196:	40d0                	lw	a2,4(s1)
    80005198:	fb040593          	addi	a1,s0,-80
    8000519c:	854a                	mv	a0,s2
    8000519e:	fffff097          	auipc	ra,0xfffff
    800051a2:	be0080e7          	jalr	-1056(ra) # 80003d7e <dirlink>
    800051a6:	06054b63          	bltz	a0,8000521c <create+0x152>
  iunlockput(dp);
    800051aa:	854a                	mv	a0,s2
    800051ac:	ffffe097          	auipc	ra,0xffffe
    800051b0:	740080e7          	jalr	1856(ra) # 800038ec <iunlockput>
  return ip;
    800051b4:	b761                	j	8000513c <create+0x72>
    panic("create: ialloc");
    800051b6:	00003517          	auipc	a0,0x3
    800051ba:	52250513          	addi	a0,a0,1314 # 800086d8 <syscalls+0x2a8>
    800051be:	ffffb097          	auipc	ra,0xffffb
    800051c2:	37a080e7          	jalr	890(ra) # 80000538 <panic>
    dp->nlink++;  // for ".."
    800051c6:	04a95783          	lhu	a5,74(s2)
    800051ca:	2785                	addiw	a5,a5,1
    800051cc:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    800051d0:	854a                	mv	a0,s2
    800051d2:	ffffe097          	auipc	ra,0xffffe
    800051d6:	3ee080e7          	jalr	1006(ra) # 800035c0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    800051da:	40d0                	lw	a2,4(s1)
    800051dc:	00003597          	auipc	a1,0x3
    800051e0:	50c58593          	addi	a1,a1,1292 # 800086e8 <syscalls+0x2b8>
    800051e4:	8526                	mv	a0,s1
    800051e6:	fffff097          	auipc	ra,0xfffff
    800051ea:	b98080e7          	jalr	-1128(ra) # 80003d7e <dirlink>
    800051ee:	00054f63          	bltz	a0,8000520c <create+0x142>
    800051f2:	00492603          	lw	a2,4(s2)
    800051f6:	00003597          	auipc	a1,0x3
    800051fa:	4fa58593          	addi	a1,a1,1274 # 800086f0 <syscalls+0x2c0>
    800051fe:	8526                	mv	a0,s1
    80005200:	fffff097          	auipc	ra,0xfffff
    80005204:	b7e080e7          	jalr	-1154(ra) # 80003d7e <dirlink>
    80005208:	f80557e3          	bgez	a0,80005196 <create+0xcc>
      panic("create dots");
    8000520c:	00003517          	auipc	a0,0x3
    80005210:	4ec50513          	addi	a0,a0,1260 # 800086f8 <syscalls+0x2c8>
    80005214:	ffffb097          	auipc	ra,0xffffb
    80005218:	324080e7          	jalr	804(ra) # 80000538 <panic>
    panic("create: dirlink");
    8000521c:	00003517          	auipc	a0,0x3
    80005220:	4ec50513          	addi	a0,a0,1260 # 80008708 <syscalls+0x2d8>
    80005224:	ffffb097          	auipc	ra,0xffffb
    80005228:	314080e7          	jalr	788(ra) # 80000538 <panic>
    return 0;
    8000522c:	84aa                	mv	s1,a0
    8000522e:	b739                	j	8000513c <create+0x72>

0000000080005230 <sys_ringbuf>:
{
    80005230:	7179                	addi	sp,sp,-48
    80005232:	f406                	sd	ra,40(sp)
    80005234:	f022                	sd	s0,32(sp)
    80005236:	1800                	addi	s0,sp,48
  if(argstr(0, namestr, 16) < 0)
    80005238:	4641                	li	a2,16
    8000523a:	fe040593          	addi	a1,s0,-32
    8000523e:	4501                	li	a0,0
    80005240:	ffffe097          	auipc	ra,0xffffe
    80005244:	91c080e7          	jalr	-1764(ra) # 80002b5c <argstr>
     return -1;
    80005248:	57fd                	li	a5,-1
  if(argstr(0, namestr, 16) < 0)
    8000524a:	06054f63          	bltz	a0,800052c8 <sys_ringbuf+0x98>
  printf("Name of ring buffer: %s\n",namestr);
    8000524e:	fe040593          	addi	a1,s0,-32
    80005252:	00003517          	auipc	a0,0x3
    80005256:	4c650513          	addi	a0,a0,1222 # 80008718 <syscalls+0x2e8>
    8000525a:	ffffb097          	auipc	ra,0xffffb
    8000525e:	328080e7          	jalr	808(ra) # 80000582 <printf>
  if(argint(1, &open_or_close) < 0)
    80005262:	fdc40593          	addi	a1,s0,-36
    80005266:	4505                	li	a0,1
    80005268:	ffffe097          	auipc	ra,0xffffe
    8000526c:	8b0080e7          	jalr	-1872(ra) # 80002b18 <argint>
    return -1;
    80005270:	57fd                	li	a5,-1
  if(argint(1, &open_or_close) < 0)
    80005272:	04054b63          	bltz	a0,800052c8 <sys_ringbuf+0x98>
  printf("Open(1) or close(0): %d\n", open_or_close);
    80005276:	fdc42583          	lw	a1,-36(s0)
    8000527a:	00003517          	auipc	a0,0x3
    8000527e:	4be50513          	addi	a0,a0,1214 # 80008738 <syscalls+0x308>
    80005282:	ffffb097          	auipc	ra,0xffffb
    80005286:	300080e7          	jalr	768(ra) # 80000582 <printf>
  if(argaddr(2, (uint64*)&address_64bit_ring_buffer_mapped) < 0)
    8000528a:	fd040593          	addi	a1,s0,-48
    8000528e:	4509                	li	a0,2
    80005290:	ffffe097          	auipc	ra,0xffffe
    80005294:	8aa080e7          	jalr	-1878(ra) # 80002b3a <argaddr>
    return -1;
    80005298:	57fd                	li	a5,-1
  if(argaddr(2, (uint64*)&address_64bit_ring_buffer_mapped) < 0)
    8000529a:	02054763          	bltz	a0,800052c8 <sys_ringbuf+0x98>
  printf("Address of ring buffer: %p\n", address_64bit_ring_buffer_mapped);
    8000529e:	fd043583          	ld	a1,-48(s0)
    800052a2:	00003517          	auipc	a0,0x3
    800052a6:	4b650513          	addi	a0,a0,1206 # 80008758 <syscalls+0x328>
    800052aa:	ffffb097          	auipc	ra,0xffffb
    800052ae:	2d8080e7          	jalr	728(ra) # 80000582 <printf>
  create_the_buffer(namestr, open_or_close, address_64bit_ring_buffer_mapped);
    800052b2:	fd043603          	ld	a2,-48(s0)
    800052b6:	fdc42583          	lw	a1,-36(s0)
    800052ba:	fe040513          	addi	a0,s0,-32
    800052be:	00001097          	auipc	ra,0x1
    800052c2:	0d6080e7          	jalr	214(ra) # 80006394 <create_the_buffer>
  return 0;
    800052c6:	4781                	li	a5,0
}
    800052c8:	853e                	mv	a0,a5
    800052ca:	70a2                	ld	ra,40(sp)
    800052cc:	7402                	ld	s0,32(sp)
    800052ce:	6145                	addi	sp,sp,48
    800052d0:	8082                	ret

00000000800052d2 <sys_dup>:
{
    800052d2:	7179                	addi	sp,sp,-48
    800052d4:	f406                	sd	ra,40(sp)
    800052d6:	f022                	sd	s0,32(sp)
    800052d8:	ec26                	sd	s1,24(sp)
    800052da:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800052dc:	fd840613          	addi	a2,s0,-40
    800052e0:	4581                	li	a1,0
    800052e2:	4501                	li	a0,0
    800052e4:	00000097          	auipc	ra,0x0
    800052e8:	d3c080e7          	jalr	-708(ra) # 80005020 <argfd>
    return -1;
    800052ec:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800052ee:	02054363          	bltz	a0,80005314 <sys_dup+0x42>
  if((fd=fdalloc(f)) < 0)
    800052f2:	fd843503          	ld	a0,-40(s0)
    800052f6:	00000097          	auipc	ra,0x0
    800052fa:	d92080e7          	jalr	-622(ra) # 80005088 <fdalloc>
    800052fe:	84aa                	mv	s1,a0
    return -1;
    80005300:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    80005302:	00054963          	bltz	a0,80005314 <sys_dup+0x42>
  filedup(f);
    80005306:	fd843503          	ld	a0,-40(s0)
    8000530a:	fffff097          	auipc	ra,0xfffff
    8000530e:	1d0080e7          	jalr	464(ra) # 800044da <filedup>
  return fd;
    80005312:	87a6                	mv	a5,s1
}
    80005314:	853e                	mv	a0,a5
    80005316:	70a2                	ld	ra,40(sp)
    80005318:	7402                	ld	s0,32(sp)
    8000531a:	64e2                	ld	s1,24(sp)
    8000531c:	6145                	addi	sp,sp,48
    8000531e:	8082                	ret

0000000080005320 <sys_read>:
{
    80005320:	7179                	addi	sp,sp,-48
    80005322:	f406                	sd	ra,40(sp)
    80005324:	f022                	sd	s0,32(sp)
    80005326:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005328:	fe840613          	addi	a2,s0,-24
    8000532c:	4581                	li	a1,0
    8000532e:	4501                	li	a0,0
    80005330:	00000097          	auipc	ra,0x0
    80005334:	cf0080e7          	jalr	-784(ra) # 80005020 <argfd>
    return -1;
    80005338:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000533a:	04054163          	bltz	a0,8000537c <sys_read+0x5c>
    8000533e:	fe440593          	addi	a1,s0,-28
    80005342:	4509                	li	a0,2
    80005344:	ffffd097          	auipc	ra,0xffffd
    80005348:	7d4080e7          	jalr	2004(ra) # 80002b18 <argint>
    return -1;
    8000534c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000534e:	02054763          	bltz	a0,8000537c <sys_read+0x5c>
    80005352:	fd840593          	addi	a1,s0,-40
    80005356:	4505                	li	a0,1
    80005358:	ffffd097          	auipc	ra,0xffffd
    8000535c:	7e2080e7          	jalr	2018(ra) # 80002b3a <argaddr>
    return -1;
    80005360:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80005362:	00054d63          	bltz	a0,8000537c <sys_read+0x5c>
  return fileread(f, p, n);
    80005366:	fe442603          	lw	a2,-28(s0)
    8000536a:	fd843583          	ld	a1,-40(s0)
    8000536e:	fe843503          	ld	a0,-24(s0)
    80005372:	fffff097          	auipc	ra,0xfffff
    80005376:	2f4080e7          	jalr	756(ra) # 80004666 <fileread>
    8000537a:	87aa                	mv	a5,a0
}
    8000537c:	853e                	mv	a0,a5
    8000537e:	70a2                	ld	ra,40(sp)
    80005380:	7402                	ld	s0,32(sp)
    80005382:	6145                	addi	sp,sp,48
    80005384:	8082                	ret

0000000080005386 <sys_write>:
{
    80005386:	7179                	addi	sp,sp,-48
    80005388:	f406                	sd	ra,40(sp)
    8000538a:	f022                	sd	s0,32(sp)
    8000538c:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000538e:	fe840613          	addi	a2,s0,-24
    80005392:	4581                	li	a1,0
    80005394:	4501                	li	a0,0
    80005396:	00000097          	auipc	ra,0x0
    8000539a:	c8a080e7          	jalr	-886(ra) # 80005020 <argfd>
    return -1;
    8000539e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800053a0:	04054163          	bltz	a0,800053e2 <sys_write+0x5c>
    800053a4:	fe440593          	addi	a1,s0,-28
    800053a8:	4509                	li	a0,2
    800053aa:	ffffd097          	auipc	ra,0xffffd
    800053ae:	76e080e7          	jalr	1902(ra) # 80002b18 <argint>
    return -1;
    800053b2:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800053b4:	02054763          	bltz	a0,800053e2 <sys_write+0x5c>
    800053b8:	fd840593          	addi	a1,s0,-40
    800053bc:	4505                	li	a0,1
    800053be:	ffffd097          	auipc	ra,0xffffd
    800053c2:	77c080e7          	jalr	1916(ra) # 80002b3a <argaddr>
    return -1;
    800053c6:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800053c8:	00054d63          	bltz	a0,800053e2 <sys_write+0x5c>
  return filewrite(f, p, n);
    800053cc:	fe442603          	lw	a2,-28(s0)
    800053d0:	fd843583          	ld	a1,-40(s0)
    800053d4:	fe843503          	ld	a0,-24(s0)
    800053d8:	fffff097          	auipc	ra,0xfffff
    800053dc:	350080e7          	jalr	848(ra) # 80004728 <filewrite>
    800053e0:	87aa                	mv	a5,a0
}
    800053e2:	853e                	mv	a0,a5
    800053e4:	70a2                	ld	ra,40(sp)
    800053e6:	7402                	ld	s0,32(sp)
    800053e8:	6145                	addi	sp,sp,48
    800053ea:	8082                	ret

00000000800053ec <sys_close>:
{
    800053ec:	1101                	addi	sp,sp,-32
    800053ee:	ec06                	sd	ra,24(sp)
    800053f0:	e822                	sd	s0,16(sp)
    800053f2:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800053f4:	fe040613          	addi	a2,s0,-32
    800053f8:	fec40593          	addi	a1,s0,-20
    800053fc:	4501                	li	a0,0
    800053fe:	00000097          	auipc	ra,0x0
    80005402:	c22080e7          	jalr	-990(ra) # 80005020 <argfd>
    return -1;
    80005406:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    80005408:	02054463          	bltz	a0,80005430 <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    8000540c:	ffffc097          	auipc	ra,0xffffc
    80005410:	65a080e7          	jalr	1626(ra) # 80001a66 <myproc>
    80005414:	fec42783          	lw	a5,-20(s0)
    80005418:	07e9                	addi	a5,a5,26
    8000541a:	078e                	slli	a5,a5,0x3
    8000541c:	97aa                	add	a5,a5,a0
    8000541e:	0007b023          	sd	zero,0(a5)
  fileclose(f);
    80005422:	fe043503          	ld	a0,-32(s0)
    80005426:	fffff097          	auipc	ra,0xfffff
    8000542a:	106080e7          	jalr	262(ra) # 8000452c <fileclose>
  return 0;
    8000542e:	4781                	li	a5,0
}
    80005430:	853e                	mv	a0,a5
    80005432:	60e2                	ld	ra,24(sp)
    80005434:	6442                	ld	s0,16(sp)
    80005436:	6105                	addi	sp,sp,32
    80005438:	8082                	ret

000000008000543a <sys_fstat>:
{
    8000543a:	1101                	addi	sp,sp,-32
    8000543c:	ec06                	sd	ra,24(sp)
    8000543e:	e822                	sd	s0,16(sp)
    80005440:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005442:	fe840613          	addi	a2,s0,-24
    80005446:	4581                	li	a1,0
    80005448:	4501                	li	a0,0
    8000544a:	00000097          	auipc	ra,0x0
    8000544e:	bd6080e7          	jalr	-1066(ra) # 80005020 <argfd>
    return -1;
    80005452:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005454:	02054563          	bltz	a0,8000547e <sys_fstat+0x44>
    80005458:	fe040593          	addi	a1,s0,-32
    8000545c:	4505                	li	a0,1
    8000545e:	ffffd097          	auipc	ra,0xffffd
    80005462:	6dc080e7          	jalr	1756(ra) # 80002b3a <argaddr>
    return -1;
    80005466:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80005468:	00054b63          	bltz	a0,8000547e <sys_fstat+0x44>
  return filestat(f, st);
    8000546c:	fe043583          	ld	a1,-32(s0)
    80005470:	fe843503          	ld	a0,-24(s0)
    80005474:	fffff097          	auipc	ra,0xfffff
    80005478:	180080e7          	jalr	384(ra) # 800045f4 <filestat>
    8000547c:	87aa                	mv	a5,a0
}
    8000547e:	853e                	mv	a0,a5
    80005480:	60e2                	ld	ra,24(sp)
    80005482:	6442                	ld	s0,16(sp)
    80005484:	6105                	addi	sp,sp,32
    80005486:	8082                	ret

0000000080005488 <sys_link>:
{
    80005488:	7169                	addi	sp,sp,-304
    8000548a:	f606                	sd	ra,296(sp)
    8000548c:	f222                	sd	s0,288(sp)
    8000548e:	ee26                	sd	s1,280(sp)
    80005490:	ea4a                	sd	s2,272(sp)
    80005492:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80005494:	08000613          	li	a2,128
    80005498:	ed040593          	addi	a1,s0,-304
    8000549c:	4501                	li	a0,0
    8000549e:	ffffd097          	auipc	ra,0xffffd
    800054a2:	6be080e7          	jalr	1726(ra) # 80002b5c <argstr>
    return -1;
    800054a6:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800054a8:	10054e63          	bltz	a0,800055c4 <sys_link+0x13c>
    800054ac:	08000613          	li	a2,128
    800054b0:	f5040593          	addi	a1,s0,-176
    800054b4:	4505                	li	a0,1
    800054b6:	ffffd097          	auipc	ra,0xffffd
    800054ba:	6a6080e7          	jalr	1702(ra) # 80002b5c <argstr>
    return -1;
    800054be:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    800054c0:	10054263          	bltz	a0,800055c4 <sys_link+0x13c>
  begin_op();
    800054c4:	fffff097          	auipc	ra,0xfffff
    800054c8:	b9c080e7          	jalr	-1124(ra) # 80004060 <begin_op>
  if((ip = namei(old)) == 0){
    800054cc:	ed040513          	addi	a0,s0,-304
    800054d0:	fffff097          	auipc	ra,0xfffff
    800054d4:	970080e7          	jalr	-1680(ra) # 80003e40 <namei>
    800054d8:	84aa                	mv	s1,a0
    800054da:	c551                	beqz	a0,80005566 <sys_link+0xde>
  ilock(ip);
    800054dc:	ffffe097          	auipc	ra,0xffffe
    800054e0:	1ae080e7          	jalr	430(ra) # 8000368a <ilock>
  if(ip->type == T_DIR){
    800054e4:	04449703          	lh	a4,68(s1)
    800054e8:	4785                	li	a5,1
    800054ea:	08f70463          	beq	a4,a5,80005572 <sys_link+0xea>
  ip->nlink++;
    800054ee:	04a4d783          	lhu	a5,74(s1)
    800054f2:	2785                	addiw	a5,a5,1
    800054f4:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800054f8:	8526                	mv	a0,s1
    800054fa:	ffffe097          	auipc	ra,0xffffe
    800054fe:	0c6080e7          	jalr	198(ra) # 800035c0 <iupdate>
  iunlock(ip);
    80005502:	8526                	mv	a0,s1
    80005504:	ffffe097          	auipc	ra,0xffffe
    80005508:	248080e7          	jalr	584(ra) # 8000374c <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    8000550c:	fd040593          	addi	a1,s0,-48
    80005510:	f5040513          	addi	a0,s0,-176
    80005514:	fffff097          	auipc	ra,0xfffff
    80005518:	94a080e7          	jalr	-1718(ra) # 80003e5e <nameiparent>
    8000551c:	892a                	mv	s2,a0
    8000551e:	c935                	beqz	a0,80005592 <sys_link+0x10a>
  ilock(dp);
    80005520:	ffffe097          	auipc	ra,0xffffe
    80005524:	16a080e7          	jalr	362(ra) # 8000368a <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80005528:	00092703          	lw	a4,0(s2)
    8000552c:	409c                	lw	a5,0(s1)
    8000552e:	04f71d63          	bne	a4,a5,80005588 <sys_link+0x100>
    80005532:	40d0                	lw	a2,4(s1)
    80005534:	fd040593          	addi	a1,s0,-48
    80005538:	854a                	mv	a0,s2
    8000553a:	fffff097          	auipc	ra,0xfffff
    8000553e:	844080e7          	jalr	-1980(ra) # 80003d7e <dirlink>
    80005542:	04054363          	bltz	a0,80005588 <sys_link+0x100>
  iunlockput(dp);
    80005546:	854a                	mv	a0,s2
    80005548:	ffffe097          	auipc	ra,0xffffe
    8000554c:	3a4080e7          	jalr	932(ra) # 800038ec <iunlockput>
  iput(ip);
    80005550:	8526                	mv	a0,s1
    80005552:	ffffe097          	auipc	ra,0xffffe
    80005556:	2f2080e7          	jalr	754(ra) # 80003844 <iput>
  end_op();
    8000555a:	fffff097          	auipc	ra,0xfffff
    8000555e:	b86080e7          	jalr	-1146(ra) # 800040e0 <end_op>
  return 0;
    80005562:	4781                	li	a5,0
    80005564:	a085                	j	800055c4 <sys_link+0x13c>
    end_op();
    80005566:	fffff097          	auipc	ra,0xfffff
    8000556a:	b7a080e7          	jalr	-1158(ra) # 800040e0 <end_op>
    return -1;
    8000556e:	57fd                	li	a5,-1
    80005570:	a891                	j	800055c4 <sys_link+0x13c>
    iunlockput(ip);
    80005572:	8526                	mv	a0,s1
    80005574:	ffffe097          	auipc	ra,0xffffe
    80005578:	378080e7          	jalr	888(ra) # 800038ec <iunlockput>
    end_op();
    8000557c:	fffff097          	auipc	ra,0xfffff
    80005580:	b64080e7          	jalr	-1180(ra) # 800040e0 <end_op>
    return -1;
    80005584:	57fd                	li	a5,-1
    80005586:	a83d                	j	800055c4 <sys_link+0x13c>
    iunlockput(dp);
    80005588:	854a                	mv	a0,s2
    8000558a:	ffffe097          	auipc	ra,0xffffe
    8000558e:	362080e7          	jalr	866(ra) # 800038ec <iunlockput>
  ilock(ip);
    80005592:	8526                	mv	a0,s1
    80005594:	ffffe097          	auipc	ra,0xffffe
    80005598:	0f6080e7          	jalr	246(ra) # 8000368a <ilock>
  ip->nlink--;
    8000559c:	04a4d783          	lhu	a5,74(s1)
    800055a0:	37fd                	addiw	a5,a5,-1
    800055a2:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800055a6:	8526                	mv	a0,s1
    800055a8:	ffffe097          	auipc	ra,0xffffe
    800055ac:	018080e7          	jalr	24(ra) # 800035c0 <iupdate>
  iunlockput(ip);
    800055b0:	8526                	mv	a0,s1
    800055b2:	ffffe097          	auipc	ra,0xffffe
    800055b6:	33a080e7          	jalr	826(ra) # 800038ec <iunlockput>
  end_op();
    800055ba:	fffff097          	auipc	ra,0xfffff
    800055be:	b26080e7          	jalr	-1242(ra) # 800040e0 <end_op>
  return -1;
    800055c2:	57fd                	li	a5,-1
}
    800055c4:	853e                	mv	a0,a5
    800055c6:	70b2                	ld	ra,296(sp)
    800055c8:	7412                	ld	s0,288(sp)
    800055ca:	64f2                	ld	s1,280(sp)
    800055cc:	6952                	ld	s2,272(sp)
    800055ce:	6155                	addi	sp,sp,304
    800055d0:	8082                	ret

00000000800055d2 <sys_unlink>:
{
    800055d2:	7151                	addi	sp,sp,-240
    800055d4:	f586                	sd	ra,232(sp)
    800055d6:	f1a2                	sd	s0,224(sp)
    800055d8:	eda6                	sd	s1,216(sp)
    800055da:	e9ca                	sd	s2,208(sp)
    800055dc:	e5ce                	sd	s3,200(sp)
    800055de:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800055e0:	08000613          	li	a2,128
    800055e4:	f3040593          	addi	a1,s0,-208
    800055e8:	4501                	li	a0,0
    800055ea:	ffffd097          	auipc	ra,0xffffd
    800055ee:	572080e7          	jalr	1394(ra) # 80002b5c <argstr>
    800055f2:	18054163          	bltz	a0,80005774 <sys_unlink+0x1a2>
  begin_op();
    800055f6:	fffff097          	auipc	ra,0xfffff
    800055fa:	a6a080e7          	jalr	-1430(ra) # 80004060 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800055fe:	fb040593          	addi	a1,s0,-80
    80005602:	f3040513          	addi	a0,s0,-208
    80005606:	fffff097          	auipc	ra,0xfffff
    8000560a:	858080e7          	jalr	-1960(ra) # 80003e5e <nameiparent>
    8000560e:	84aa                	mv	s1,a0
    80005610:	c979                	beqz	a0,800056e6 <sys_unlink+0x114>
  ilock(dp);
    80005612:	ffffe097          	auipc	ra,0xffffe
    80005616:	078080e7          	jalr	120(ra) # 8000368a <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    8000561a:	00003597          	auipc	a1,0x3
    8000561e:	0ce58593          	addi	a1,a1,206 # 800086e8 <syscalls+0x2b8>
    80005622:	fb040513          	addi	a0,s0,-80
    80005626:	ffffe097          	auipc	ra,0xffffe
    8000562a:	52e080e7          	jalr	1326(ra) # 80003b54 <namecmp>
    8000562e:	14050a63          	beqz	a0,80005782 <sys_unlink+0x1b0>
    80005632:	00003597          	auipc	a1,0x3
    80005636:	0be58593          	addi	a1,a1,190 # 800086f0 <syscalls+0x2c0>
    8000563a:	fb040513          	addi	a0,s0,-80
    8000563e:	ffffe097          	auipc	ra,0xffffe
    80005642:	516080e7          	jalr	1302(ra) # 80003b54 <namecmp>
    80005646:	12050e63          	beqz	a0,80005782 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    8000564a:	f2c40613          	addi	a2,s0,-212
    8000564e:	fb040593          	addi	a1,s0,-80
    80005652:	8526                	mv	a0,s1
    80005654:	ffffe097          	auipc	ra,0xffffe
    80005658:	51a080e7          	jalr	1306(ra) # 80003b6e <dirlookup>
    8000565c:	892a                	mv	s2,a0
    8000565e:	12050263          	beqz	a0,80005782 <sys_unlink+0x1b0>
  ilock(ip);
    80005662:	ffffe097          	auipc	ra,0xffffe
    80005666:	028080e7          	jalr	40(ra) # 8000368a <ilock>
  if(ip->nlink < 1)
    8000566a:	04a91783          	lh	a5,74(s2)
    8000566e:	08f05263          	blez	a5,800056f2 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80005672:	04491703          	lh	a4,68(s2)
    80005676:	4785                	li	a5,1
    80005678:	08f70563          	beq	a4,a5,80005702 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    8000567c:	4641                	li	a2,16
    8000567e:	4581                	li	a1,0
    80005680:	fc040513          	addi	a0,s0,-64
    80005684:	ffffb097          	auipc	ra,0xffffb
    80005688:	648080e7          	jalr	1608(ra) # 80000ccc <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000568c:	4741                	li	a4,16
    8000568e:	f2c42683          	lw	a3,-212(s0)
    80005692:	fc040613          	addi	a2,s0,-64
    80005696:	4581                	li	a1,0
    80005698:	8526                	mv	a0,s1
    8000569a:	ffffe097          	auipc	ra,0xffffe
    8000569e:	39c080e7          	jalr	924(ra) # 80003a36 <writei>
    800056a2:	47c1                	li	a5,16
    800056a4:	0af51563          	bne	a0,a5,8000574e <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    800056a8:	04491703          	lh	a4,68(s2)
    800056ac:	4785                	li	a5,1
    800056ae:	0af70863          	beq	a4,a5,8000575e <sys_unlink+0x18c>
  iunlockput(dp);
    800056b2:	8526                	mv	a0,s1
    800056b4:	ffffe097          	auipc	ra,0xffffe
    800056b8:	238080e7          	jalr	568(ra) # 800038ec <iunlockput>
  ip->nlink--;
    800056bc:	04a95783          	lhu	a5,74(s2)
    800056c0:	37fd                	addiw	a5,a5,-1
    800056c2:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    800056c6:	854a                	mv	a0,s2
    800056c8:	ffffe097          	auipc	ra,0xffffe
    800056cc:	ef8080e7          	jalr	-264(ra) # 800035c0 <iupdate>
  iunlockput(ip);
    800056d0:	854a                	mv	a0,s2
    800056d2:	ffffe097          	auipc	ra,0xffffe
    800056d6:	21a080e7          	jalr	538(ra) # 800038ec <iunlockput>
  end_op();
    800056da:	fffff097          	auipc	ra,0xfffff
    800056de:	a06080e7          	jalr	-1530(ra) # 800040e0 <end_op>
  return 0;
    800056e2:	4501                	li	a0,0
    800056e4:	a84d                	j	80005796 <sys_unlink+0x1c4>
    end_op();
    800056e6:	fffff097          	auipc	ra,0xfffff
    800056ea:	9fa080e7          	jalr	-1542(ra) # 800040e0 <end_op>
    return -1;
    800056ee:	557d                	li	a0,-1
    800056f0:	a05d                	j	80005796 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    800056f2:	00003517          	auipc	a0,0x3
    800056f6:	08650513          	addi	a0,a0,134 # 80008778 <syscalls+0x348>
    800056fa:	ffffb097          	auipc	ra,0xffffb
    800056fe:	e3e080e7          	jalr	-450(ra) # 80000538 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005702:	04c92703          	lw	a4,76(s2)
    80005706:	02000793          	li	a5,32
    8000570a:	f6e7f9e3          	bgeu	a5,a4,8000567c <sys_unlink+0xaa>
    8000570e:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80005712:	4741                	li	a4,16
    80005714:	86ce                	mv	a3,s3
    80005716:	f1840613          	addi	a2,s0,-232
    8000571a:	4581                	li	a1,0
    8000571c:	854a                	mv	a0,s2
    8000571e:	ffffe097          	auipc	ra,0xffffe
    80005722:	220080e7          	jalr	544(ra) # 8000393e <readi>
    80005726:	47c1                	li	a5,16
    80005728:	00f51b63          	bne	a0,a5,8000573e <sys_unlink+0x16c>
    if(de.inum != 0)
    8000572c:	f1845783          	lhu	a5,-232(s0)
    80005730:	e7a1                	bnez	a5,80005778 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80005732:	29c1                	addiw	s3,s3,16
    80005734:	04c92783          	lw	a5,76(s2)
    80005738:	fcf9ede3          	bltu	s3,a5,80005712 <sys_unlink+0x140>
    8000573c:	b781                	j	8000567c <sys_unlink+0xaa>
      panic("isdirempty: readi");
    8000573e:	00003517          	auipc	a0,0x3
    80005742:	05250513          	addi	a0,a0,82 # 80008790 <syscalls+0x360>
    80005746:	ffffb097          	auipc	ra,0xffffb
    8000574a:	df2080e7          	jalr	-526(ra) # 80000538 <panic>
    panic("unlink: writei");
    8000574e:	00003517          	auipc	a0,0x3
    80005752:	05a50513          	addi	a0,a0,90 # 800087a8 <syscalls+0x378>
    80005756:	ffffb097          	auipc	ra,0xffffb
    8000575a:	de2080e7          	jalr	-542(ra) # 80000538 <panic>
    dp->nlink--;
    8000575e:	04a4d783          	lhu	a5,74(s1)
    80005762:	37fd                	addiw	a5,a5,-1
    80005764:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80005768:	8526                	mv	a0,s1
    8000576a:	ffffe097          	auipc	ra,0xffffe
    8000576e:	e56080e7          	jalr	-426(ra) # 800035c0 <iupdate>
    80005772:	b781                	j	800056b2 <sys_unlink+0xe0>
    return -1;
    80005774:	557d                	li	a0,-1
    80005776:	a005                	j	80005796 <sys_unlink+0x1c4>
    iunlockput(ip);
    80005778:	854a                	mv	a0,s2
    8000577a:	ffffe097          	auipc	ra,0xffffe
    8000577e:	172080e7          	jalr	370(ra) # 800038ec <iunlockput>
  iunlockput(dp);
    80005782:	8526                	mv	a0,s1
    80005784:	ffffe097          	auipc	ra,0xffffe
    80005788:	168080e7          	jalr	360(ra) # 800038ec <iunlockput>
  end_op();
    8000578c:	fffff097          	auipc	ra,0xfffff
    80005790:	954080e7          	jalr	-1708(ra) # 800040e0 <end_op>
  return -1;
    80005794:	557d                	li	a0,-1
}
    80005796:	70ae                	ld	ra,232(sp)
    80005798:	740e                	ld	s0,224(sp)
    8000579a:	64ee                	ld	s1,216(sp)
    8000579c:	694e                	ld	s2,208(sp)
    8000579e:	69ae                	ld	s3,200(sp)
    800057a0:	616d                	addi	sp,sp,240
    800057a2:	8082                	ret

00000000800057a4 <sys_open>:

uint64
sys_open(void)
{
    800057a4:	7131                	addi	sp,sp,-192
    800057a6:	fd06                	sd	ra,184(sp)
    800057a8:	f922                	sd	s0,176(sp)
    800057aa:	f526                	sd	s1,168(sp)
    800057ac:	f14a                	sd	s2,160(sp)
    800057ae:	ed4e                	sd	s3,152(sp)
    800057b0:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800057b2:	08000613          	li	a2,128
    800057b6:	f5040593          	addi	a1,s0,-176
    800057ba:	4501                	li	a0,0
    800057bc:	ffffd097          	auipc	ra,0xffffd
    800057c0:	3a0080e7          	jalr	928(ra) # 80002b5c <argstr>
    return -1;
    800057c4:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    800057c6:	0c054163          	bltz	a0,80005888 <sys_open+0xe4>
    800057ca:	f4c40593          	addi	a1,s0,-180
    800057ce:	4505                	li	a0,1
    800057d0:	ffffd097          	auipc	ra,0xffffd
    800057d4:	348080e7          	jalr	840(ra) # 80002b18 <argint>
    800057d8:	0a054863          	bltz	a0,80005888 <sys_open+0xe4>

  begin_op();
    800057dc:	fffff097          	auipc	ra,0xfffff
    800057e0:	884080e7          	jalr	-1916(ra) # 80004060 <begin_op>

  if(omode & O_CREATE){
    800057e4:	f4c42783          	lw	a5,-180(s0)
    800057e8:	2007f793          	andi	a5,a5,512
    800057ec:	cbdd                	beqz	a5,800058a2 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    800057ee:	4681                	li	a3,0
    800057f0:	4601                	li	a2,0
    800057f2:	4589                	li	a1,2
    800057f4:	f5040513          	addi	a0,s0,-176
    800057f8:	00000097          	auipc	ra,0x0
    800057fc:	8d2080e7          	jalr	-1838(ra) # 800050ca <create>
    80005800:	892a                	mv	s2,a0
    if(ip == 0){
    80005802:	c959                	beqz	a0,80005898 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80005804:	04491703          	lh	a4,68(s2)
    80005808:	478d                	li	a5,3
    8000580a:	00f71763          	bne	a4,a5,80005818 <sys_open+0x74>
    8000580e:	04695703          	lhu	a4,70(s2)
    80005812:	47a5                	li	a5,9
    80005814:	0ce7ec63          	bltu	a5,a4,800058ec <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80005818:	fffff097          	auipc	ra,0xfffff
    8000581c:	c58080e7          	jalr	-936(ra) # 80004470 <filealloc>
    80005820:	89aa                	mv	s3,a0
    80005822:	10050263          	beqz	a0,80005926 <sys_open+0x182>
    80005826:	00000097          	auipc	ra,0x0
    8000582a:	862080e7          	jalr	-1950(ra) # 80005088 <fdalloc>
    8000582e:	84aa                	mv	s1,a0
    80005830:	0e054663          	bltz	a0,8000591c <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80005834:	04491703          	lh	a4,68(s2)
    80005838:	478d                	li	a5,3
    8000583a:	0cf70463          	beq	a4,a5,80005902 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    8000583e:	4789                	li	a5,2
    80005840:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80005844:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80005848:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    8000584c:	f4c42783          	lw	a5,-180(s0)
    80005850:	0017c713          	xori	a4,a5,1
    80005854:	8b05                	andi	a4,a4,1
    80005856:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    8000585a:	0037f713          	andi	a4,a5,3
    8000585e:	00e03733          	snez	a4,a4
    80005862:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80005866:	4007f793          	andi	a5,a5,1024
    8000586a:	c791                	beqz	a5,80005876 <sys_open+0xd2>
    8000586c:	04491703          	lh	a4,68(s2)
    80005870:	4789                	li	a5,2
    80005872:	08f70f63          	beq	a4,a5,80005910 <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80005876:	854a                	mv	a0,s2
    80005878:	ffffe097          	auipc	ra,0xffffe
    8000587c:	ed4080e7          	jalr	-300(ra) # 8000374c <iunlock>
  end_op();
    80005880:	fffff097          	auipc	ra,0xfffff
    80005884:	860080e7          	jalr	-1952(ra) # 800040e0 <end_op>

  return fd;
}
    80005888:	8526                	mv	a0,s1
    8000588a:	70ea                	ld	ra,184(sp)
    8000588c:	744a                	ld	s0,176(sp)
    8000588e:	74aa                	ld	s1,168(sp)
    80005890:	790a                	ld	s2,160(sp)
    80005892:	69ea                	ld	s3,152(sp)
    80005894:	6129                	addi	sp,sp,192
    80005896:	8082                	ret
      end_op();
    80005898:	fffff097          	auipc	ra,0xfffff
    8000589c:	848080e7          	jalr	-1976(ra) # 800040e0 <end_op>
      return -1;
    800058a0:	b7e5                	j	80005888 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    800058a2:	f5040513          	addi	a0,s0,-176
    800058a6:	ffffe097          	auipc	ra,0xffffe
    800058aa:	59a080e7          	jalr	1434(ra) # 80003e40 <namei>
    800058ae:	892a                	mv	s2,a0
    800058b0:	c905                	beqz	a0,800058e0 <sys_open+0x13c>
    ilock(ip);
    800058b2:	ffffe097          	auipc	ra,0xffffe
    800058b6:	dd8080e7          	jalr	-552(ra) # 8000368a <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    800058ba:	04491703          	lh	a4,68(s2)
    800058be:	4785                	li	a5,1
    800058c0:	f4f712e3          	bne	a4,a5,80005804 <sys_open+0x60>
    800058c4:	f4c42783          	lw	a5,-180(s0)
    800058c8:	dba1                	beqz	a5,80005818 <sys_open+0x74>
      iunlockput(ip);
    800058ca:	854a                	mv	a0,s2
    800058cc:	ffffe097          	auipc	ra,0xffffe
    800058d0:	020080e7          	jalr	32(ra) # 800038ec <iunlockput>
      end_op();
    800058d4:	fffff097          	auipc	ra,0xfffff
    800058d8:	80c080e7          	jalr	-2036(ra) # 800040e0 <end_op>
      return -1;
    800058dc:	54fd                	li	s1,-1
    800058de:	b76d                	j	80005888 <sys_open+0xe4>
      end_op();
    800058e0:	fffff097          	auipc	ra,0xfffff
    800058e4:	800080e7          	jalr	-2048(ra) # 800040e0 <end_op>
      return -1;
    800058e8:	54fd                	li	s1,-1
    800058ea:	bf79                	j	80005888 <sys_open+0xe4>
    iunlockput(ip);
    800058ec:	854a                	mv	a0,s2
    800058ee:	ffffe097          	auipc	ra,0xffffe
    800058f2:	ffe080e7          	jalr	-2(ra) # 800038ec <iunlockput>
    end_op();
    800058f6:	ffffe097          	auipc	ra,0xffffe
    800058fa:	7ea080e7          	jalr	2026(ra) # 800040e0 <end_op>
    return -1;
    800058fe:	54fd                	li	s1,-1
    80005900:	b761                	j	80005888 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80005902:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80005906:	04691783          	lh	a5,70(s2)
    8000590a:	02f99223          	sh	a5,36(s3)
    8000590e:	bf2d                	j	80005848 <sys_open+0xa4>
    itrunc(ip);
    80005910:	854a                	mv	a0,s2
    80005912:	ffffe097          	auipc	ra,0xffffe
    80005916:	e86080e7          	jalr	-378(ra) # 80003798 <itrunc>
    8000591a:	bfb1                	j	80005876 <sys_open+0xd2>
      fileclose(f);
    8000591c:	854e                	mv	a0,s3
    8000591e:	fffff097          	auipc	ra,0xfffff
    80005922:	c0e080e7          	jalr	-1010(ra) # 8000452c <fileclose>
    iunlockput(ip);
    80005926:	854a                	mv	a0,s2
    80005928:	ffffe097          	auipc	ra,0xffffe
    8000592c:	fc4080e7          	jalr	-60(ra) # 800038ec <iunlockput>
    end_op();
    80005930:	ffffe097          	auipc	ra,0xffffe
    80005934:	7b0080e7          	jalr	1968(ra) # 800040e0 <end_op>
    return -1;
    80005938:	54fd                	li	s1,-1
    8000593a:	b7b9                	j	80005888 <sys_open+0xe4>

000000008000593c <sys_mkdir>:

uint64
sys_mkdir(void)
{
    8000593c:	7175                	addi	sp,sp,-144
    8000593e:	e506                	sd	ra,136(sp)
    80005940:	e122                	sd	s0,128(sp)
    80005942:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80005944:	ffffe097          	auipc	ra,0xffffe
    80005948:	71c080e7          	jalr	1820(ra) # 80004060 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    8000594c:	08000613          	li	a2,128
    80005950:	f7040593          	addi	a1,s0,-144
    80005954:	4501                	li	a0,0
    80005956:	ffffd097          	auipc	ra,0xffffd
    8000595a:	206080e7          	jalr	518(ra) # 80002b5c <argstr>
    8000595e:	02054963          	bltz	a0,80005990 <sys_mkdir+0x54>
    80005962:	4681                	li	a3,0
    80005964:	4601                	li	a2,0
    80005966:	4585                	li	a1,1
    80005968:	f7040513          	addi	a0,s0,-144
    8000596c:	fffff097          	auipc	ra,0xfffff
    80005970:	75e080e7          	jalr	1886(ra) # 800050ca <create>
    80005974:	cd11                	beqz	a0,80005990 <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80005976:	ffffe097          	auipc	ra,0xffffe
    8000597a:	f76080e7          	jalr	-138(ra) # 800038ec <iunlockput>
  end_op();
    8000597e:	ffffe097          	auipc	ra,0xffffe
    80005982:	762080e7          	jalr	1890(ra) # 800040e0 <end_op>
  return 0;
    80005986:	4501                	li	a0,0
}
    80005988:	60aa                	ld	ra,136(sp)
    8000598a:	640a                	ld	s0,128(sp)
    8000598c:	6149                	addi	sp,sp,144
    8000598e:	8082                	ret
    end_op();
    80005990:	ffffe097          	auipc	ra,0xffffe
    80005994:	750080e7          	jalr	1872(ra) # 800040e0 <end_op>
    return -1;
    80005998:	557d                	li	a0,-1
    8000599a:	b7fd                	j	80005988 <sys_mkdir+0x4c>

000000008000599c <sys_mknod>:

uint64
sys_mknod(void)
{
    8000599c:	7135                	addi	sp,sp,-160
    8000599e:	ed06                	sd	ra,152(sp)
    800059a0:	e922                	sd	s0,144(sp)
    800059a2:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    800059a4:	ffffe097          	auipc	ra,0xffffe
    800059a8:	6bc080e7          	jalr	1724(ra) # 80004060 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800059ac:	08000613          	li	a2,128
    800059b0:	f7040593          	addi	a1,s0,-144
    800059b4:	4501                	li	a0,0
    800059b6:	ffffd097          	auipc	ra,0xffffd
    800059ba:	1a6080e7          	jalr	422(ra) # 80002b5c <argstr>
    800059be:	04054a63          	bltz	a0,80005a12 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    800059c2:	f6c40593          	addi	a1,s0,-148
    800059c6:	4505                	li	a0,1
    800059c8:	ffffd097          	auipc	ra,0xffffd
    800059cc:	150080e7          	jalr	336(ra) # 80002b18 <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    800059d0:	04054163          	bltz	a0,80005a12 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    800059d4:	f6840593          	addi	a1,s0,-152
    800059d8:	4509                	li	a0,2
    800059da:	ffffd097          	auipc	ra,0xffffd
    800059de:	13e080e7          	jalr	318(ra) # 80002b18 <argint>
     argint(1, &major) < 0 ||
    800059e2:	02054863          	bltz	a0,80005a12 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    800059e6:	f6841683          	lh	a3,-152(s0)
    800059ea:	f6c41603          	lh	a2,-148(s0)
    800059ee:	458d                	li	a1,3
    800059f0:	f7040513          	addi	a0,s0,-144
    800059f4:	fffff097          	auipc	ra,0xfffff
    800059f8:	6d6080e7          	jalr	1750(ra) # 800050ca <create>
     argint(2, &minor) < 0 ||
    800059fc:	c919                	beqz	a0,80005a12 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    800059fe:	ffffe097          	auipc	ra,0xffffe
    80005a02:	eee080e7          	jalr	-274(ra) # 800038ec <iunlockput>
  end_op();
    80005a06:	ffffe097          	auipc	ra,0xffffe
    80005a0a:	6da080e7          	jalr	1754(ra) # 800040e0 <end_op>
  return 0;
    80005a0e:	4501                	li	a0,0
    80005a10:	a031                	j	80005a1c <sys_mknod+0x80>
    end_op();
    80005a12:	ffffe097          	auipc	ra,0xffffe
    80005a16:	6ce080e7          	jalr	1742(ra) # 800040e0 <end_op>
    return -1;
    80005a1a:	557d                	li	a0,-1
}
    80005a1c:	60ea                	ld	ra,152(sp)
    80005a1e:	644a                	ld	s0,144(sp)
    80005a20:	610d                	addi	sp,sp,160
    80005a22:	8082                	ret

0000000080005a24 <sys_chdir>:

uint64
sys_chdir(void)
{
    80005a24:	7135                	addi	sp,sp,-160
    80005a26:	ed06                	sd	ra,152(sp)
    80005a28:	e922                	sd	s0,144(sp)
    80005a2a:	e526                	sd	s1,136(sp)
    80005a2c:	e14a                	sd	s2,128(sp)
    80005a2e:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80005a30:	ffffc097          	auipc	ra,0xffffc
    80005a34:	036080e7          	jalr	54(ra) # 80001a66 <myproc>
    80005a38:	892a                	mv	s2,a0
  
  begin_op();
    80005a3a:	ffffe097          	auipc	ra,0xffffe
    80005a3e:	626080e7          	jalr	1574(ra) # 80004060 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80005a42:	08000613          	li	a2,128
    80005a46:	f6040593          	addi	a1,s0,-160
    80005a4a:	4501                	li	a0,0
    80005a4c:	ffffd097          	auipc	ra,0xffffd
    80005a50:	110080e7          	jalr	272(ra) # 80002b5c <argstr>
    80005a54:	04054b63          	bltz	a0,80005aaa <sys_chdir+0x86>
    80005a58:	f6040513          	addi	a0,s0,-160
    80005a5c:	ffffe097          	auipc	ra,0xffffe
    80005a60:	3e4080e7          	jalr	996(ra) # 80003e40 <namei>
    80005a64:	84aa                	mv	s1,a0
    80005a66:	c131                	beqz	a0,80005aaa <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80005a68:	ffffe097          	auipc	ra,0xffffe
    80005a6c:	c22080e7          	jalr	-990(ra) # 8000368a <ilock>
  if(ip->type != T_DIR){
    80005a70:	04449703          	lh	a4,68(s1)
    80005a74:	4785                	li	a5,1
    80005a76:	04f71063          	bne	a4,a5,80005ab6 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80005a7a:	8526                	mv	a0,s1
    80005a7c:	ffffe097          	auipc	ra,0xffffe
    80005a80:	cd0080e7          	jalr	-816(ra) # 8000374c <iunlock>
  iput(p->cwd);
    80005a84:	15093503          	ld	a0,336(s2)
    80005a88:	ffffe097          	auipc	ra,0xffffe
    80005a8c:	dbc080e7          	jalr	-580(ra) # 80003844 <iput>
  end_op();
    80005a90:	ffffe097          	auipc	ra,0xffffe
    80005a94:	650080e7          	jalr	1616(ra) # 800040e0 <end_op>
  p->cwd = ip;
    80005a98:	14993823          	sd	s1,336(s2)
  return 0;
    80005a9c:	4501                	li	a0,0
}
    80005a9e:	60ea                	ld	ra,152(sp)
    80005aa0:	644a                	ld	s0,144(sp)
    80005aa2:	64aa                	ld	s1,136(sp)
    80005aa4:	690a                	ld	s2,128(sp)
    80005aa6:	610d                	addi	sp,sp,160
    80005aa8:	8082                	ret
    end_op();
    80005aaa:	ffffe097          	auipc	ra,0xffffe
    80005aae:	636080e7          	jalr	1590(ra) # 800040e0 <end_op>
    return -1;
    80005ab2:	557d                	li	a0,-1
    80005ab4:	b7ed                	j	80005a9e <sys_chdir+0x7a>
    iunlockput(ip);
    80005ab6:	8526                	mv	a0,s1
    80005ab8:	ffffe097          	auipc	ra,0xffffe
    80005abc:	e34080e7          	jalr	-460(ra) # 800038ec <iunlockput>
    end_op();
    80005ac0:	ffffe097          	auipc	ra,0xffffe
    80005ac4:	620080e7          	jalr	1568(ra) # 800040e0 <end_op>
    return -1;
    80005ac8:	557d                	li	a0,-1
    80005aca:	bfd1                	j	80005a9e <sys_chdir+0x7a>

0000000080005acc <sys_exec>:

uint64
sys_exec(void)
{
    80005acc:	7145                	addi	sp,sp,-464
    80005ace:	e786                	sd	ra,456(sp)
    80005ad0:	e3a2                	sd	s0,448(sp)
    80005ad2:	ff26                	sd	s1,440(sp)
    80005ad4:	fb4a                	sd	s2,432(sp)
    80005ad6:	f74e                	sd	s3,424(sp)
    80005ad8:	f352                	sd	s4,416(sp)
    80005ada:	ef56                	sd	s5,408(sp)
    80005adc:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005ade:	08000613          	li	a2,128
    80005ae2:	f4040593          	addi	a1,s0,-192
    80005ae6:	4501                	li	a0,0
    80005ae8:	ffffd097          	auipc	ra,0xffffd
    80005aec:	074080e7          	jalr	116(ra) # 80002b5c <argstr>
    return -1;
    80005af0:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80005af2:	0c054a63          	bltz	a0,80005bc6 <sys_exec+0xfa>
    80005af6:	e3840593          	addi	a1,s0,-456
    80005afa:	4505                	li	a0,1
    80005afc:	ffffd097          	auipc	ra,0xffffd
    80005b00:	03e080e7          	jalr	62(ra) # 80002b3a <argaddr>
    80005b04:	0c054163          	bltz	a0,80005bc6 <sys_exec+0xfa>
  }
  memset(argv, 0, sizeof(argv));
    80005b08:	10000613          	li	a2,256
    80005b0c:	4581                	li	a1,0
    80005b0e:	e4040513          	addi	a0,s0,-448
    80005b12:	ffffb097          	auipc	ra,0xffffb
    80005b16:	1ba080e7          	jalr	442(ra) # 80000ccc <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80005b1a:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80005b1e:	89a6                	mv	s3,s1
    80005b20:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80005b22:	02000a13          	li	s4,32
    80005b26:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80005b2a:	00391793          	slli	a5,s2,0x3
    80005b2e:	e3040593          	addi	a1,s0,-464
    80005b32:	e3843503          	ld	a0,-456(s0)
    80005b36:	953e                	add	a0,a0,a5
    80005b38:	ffffd097          	auipc	ra,0xffffd
    80005b3c:	f46080e7          	jalr	-186(ra) # 80002a7e <fetchaddr>
    80005b40:	02054a63          	bltz	a0,80005b74 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    80005b44:	e3043783          	ld	a5,-464(s0)
    80005b48:	c3b9                	beqz	a5,80005b8e <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80005b4a:	ffffb097          	auipc	ra,0xffffb
    80005b4e:	f96080e7          	jalr	-106(ra) # 80000ae0 <kalloc>
    80005b52:	85aa                	mv	a1,a0
    80005b54:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80005b58:	cd11                	beqz	a0,80005b74 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80005b5a:	6605                	lui	a2,0x1
    80005b5c:	e3043503          	ld	a0,-464(s0)
    80005b60:	ffffd097          	auipc	ra,0xffffd
    80005b64:	f70080e7          	jalr	-144(ra) # 80002ad0 <fetchstr>
    80005b68:	00054663          	bltz	a0,80005b74 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    80005b6c:	0905                	addi	s2,s2,1
    80005b6e:	09a1                	addi	s3,s3,8
    80005b70:	fb491be3          	bne	s2,s4,80005b26 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005b74:	10048913          	addi	s2,s1,256
    80005b78:	6088                	ld	a0,0(s1)
    80005b7a:	c529                	beqz	a0,80005bc4 <sys_exec+0xf8>
    kfree(argv[i]);
    80005b7c:	ffffb097          	auipc	ra,0xffffb
    80005b80:	e68080e7          	jalr	-408(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005b84:	04a1                	addi	s1,s1,8
    80005b86:	ff2499e3          	bne	s1,s2,80005b78 <sys_exec+0xac>
  return -1;
    80005b8a:	597d                	li	s2,-1
    80005b8c:	a82d                	j	80005bc6 <sys_exec+0xfa>
      argv[i] = 0;
    80005b8e:	0a8e                	slli	s5,s5,0x3
    80005b90:	fc040793          	addi	a5,s0,-64
    80005b94:	9abe                	add	s5,s5,a5
    80005b96:	e80ab023          	sd	zero,-384(s5) # ffffffffffffee80 <end+0xffffffff7ffd8828>
  int ret = exec(path, argv);
    80005b9a:	e4040593          	addi	a1,s0,-448
    80005b9e:	f4040513          	addi	a0,s0,-192
    80005ba2:	fffff097          	auipc	ra,0xfffff
    80005ba6:	0d6080e7          	jalr	214(ra) # 80004c78 <exec>
    80005baa:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005bac:	10048993          	addi	s3,s1,256
    80005bb0:	6088                	ld	a0,0(s1)
    80005bb2:	c911                	beqz	a0,80005bc6 <sys_exec+0xfa>
    kfree(argv[i]);
    80005bb4:	ffffb097          	auipc	ra,0xffffb
    80005bb8:	e30080e7          	jalr	-464(ra) # 800009e4 <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80005bbc:	04a1                	addi	s1,s1,8
    80005bbe:	ff3499e3          	bne	s1,s3,80005bb0 <sys_exec+0xe4>
    80005bc2:	a011                	j	80005bc6 <sys_exec+0xfa>
  return -1;
    80005bc4:	597d                	li	s2,-1
}
    80005bc6:	854a                	mv	a0,s2
    80005bc8:	60be                	ld	ra,456(sp)
    80005bca:	641e                	ld	s0,448(sp)
    80005bcc:	74fa                	ld	s1,440(sp)
    80005bce:	795a                	ld	s2,432(sp)
    80005bd0:	79ba                	ld	s3,424(sp)
    80005bd2:	7a1a                	ld	s4,416(sp)
    80005bd4:	6afa                	ld	s5,408(sp)
    80005bd6:	6179                	addi	sp,sp,464
    80005bd8:	8082                	ret

0000000080005bda <sys_pipe>:

uint64
sys_pipe(void)
{
    80005bda:	7139                	addi	sp,sp,-64
    80005bdc:	fc06                	sd	ra,56(sp)
    80005bde:	f822                	sd	s0,48(sp)
    80005be0:	f426                	sd	s1,40(sp)
    80005be2:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80005be4:	ffffc097          	auipc	ra,0xffffc
    80005be8:	e82080e7          	jalr	-382(ra) # 80001a66 <myproc>
    80005bec:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80005bee:	fd840593          	addi	a1,s0,-40
    80005bf2:	4501                	li	a0,0
    80005bf4:	ffffd097          	auipc	ra,0xffffd
    80005bf8:	f46080e7          	jalr	-186(ra) # 80002b3a <argaddr>
    return -1;
    80005bfc:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80005bfe:	0e054063          	bltz	a0,80005cde <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80005c02:	fc840593          	addi	a1,s0,-56
    80005c06:	fd040513          	addi	a0,s0,-48
    80005c0a:	fffff097          	auipc	ra,0xfffff
    80005c0e:	c52080e7          	jalr	-942(ra) # 8000485c <pipealloc>
    return -1;
    80005c12:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80005c14:	0c054563          	bltz	a0,80005cde <sys_pipe+0x104>
  fd0 = -1;
    80005c18:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80005c1c:	fd043503          	ld	a0,-48(s0)
    80005c20:	fffff097          	auipc	ra,0xfffff
    80005c24:	468080e7          	jalr	1128(ra) # 80005088 <fdalloc>
    80005c28:	fca42223          	sw	a0,-60(s0)
    80005c2c:	08054c63          	bltz	a0,80005cc4 <sys_pipe+0xea>
    80005c30:	fc843503          	ld	a0,-56(s0)
    80005c34:	fffff097          	auipc	ra,0xfffff
    80005c38:	454080e7          	jalr	1108(ra) # 80005088 <fdalloc>
    80005c3c:	fca42023          	sw	a0,-64(s0)
    80005c40:	06054863          	bltz	a0,80005cb0 <sys_pipe+0xd6>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005c44:	4691                	li	a3,4
    80005c46:	fc440613          	addi	a2,s0,-60
    80005c4a:	fd843583          	ld	a1,-40(s0)
    80005c4e:	68a8                	ld	a0,80(s1)
    80005c50:	ffffc097          	auipc	ra,0xffffc
    80005c54:	9fc080e7          	jalr	-1540(ra) # 8000164c <copyout>
    80005c58:	02054063          	bltz	a0,80005c78 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    80005c5c:	4691                	li	a3,4
    80005c5e:	fc040613          	addi	a2,s0,-64
    80005c62:	fd843583          	ld	a1,-40(s0)
    80005c66:	0591                	addi	a1,a1,4
    80005c68:	68a8                	ld	a0,80(s1)
    80005c6a:	ffffc097          	auipc	ra,0xffffc
    80005c6e:	9e2080e7          	jalr	-1566(ra) # 8000164c <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005c72:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005c74:	06055563          	bgez	a0,80005cde <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005c78:	fc442783          	lw	a5,-60(s0)
    80005c7c:	07e9                	addi	a5,a5,26
    80005c7e:	078e                	slli	a5,a5,0x3
    80005c80:	97a6                	add	a5,a5,s1
    80005c82:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005c86:	fc042503          	lw	a0,-64(s0)
    80005c8a:	0569                	addi	a0,a0,26
    80005c8c:	050e                	slli	a0,a0,0x3
    80005c8e:	9526                	add	a0,a0,s1
    80005c90:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005c94:	fd043503          	ld	a0,-48(s0)
    80005c98:	fffff097          	auipc	ra,0xfffff
    80005c9c:	894080e7          	jalr	-1900(ra) # 8000452c <fileclose>
    fileclose(wf);
    80005ca0:	fc843503          	ld	a0,-56(s0)
    80005ca4:	fffff097          	auipc	ra,0xfffff
    80005ca8:	888080e7          	jalr	-1912(ra) # 8000452c <fileclose>
    return -1;
    80005cac:	57fd                	li	a5,-1
    80005cae:	a805                	j	80005cde <sys_pipe+0x104>
    if(fd0 >= 0)
    80005cb0:	fc442783          	lw	a5,-60(s0)
    80005cb4:	0007c863          	bltz	a5,80005cc4 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    80005cb8:	01a78513          	addi	a0,a5,26
    80005cbc:	050e                	slli	a0,a0,0x3
    80005cbe:	9526                	add	a0,a0,s1
    80005cc0:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005cc4:	fd043503          	ld	a0,-48(s0)
    80005cc8:	fffff097          	auipc	ra,0xfffff
    80005ccc:	864080e7          	jalr	-1948(ra) # 8000452c <fileclose>
    fileclose(wf);
    80005cd0:	fc843503          	ld	a0,-56(s0)
    80005cd4:	fffff097          	auipc	ra,0xfffff
    80005cd8:	858080e7          	jalr	-1960(ra) # 8000452c <fileclose>
    return -1;
    80005cdc:	57fd                	li	a5,-1
}
    80005cde:	853e                	mv	a0,a5
    80005ce0:	70e2                	ld	ra,56(sp)
    80005ce2:	7442                	ld	s0,48(sp)
    80005ce4:	74a2                	ld	s1,40(sp)
    80005ce6:	6121                	addi	sp,sp,64
    80005ce8:	8082                	ret
    80005cea:	0000                	unimp
    80005cec:	0000                	unimp
	...

0000000080005cf0 <kernelvec>:
    80005cf0:	7111                	addi	sp,sp,-256
    80005cf2:	e006                	sd	ra,0(sp)
    80005cf4:	e40a                	sd	sp,8(sp)
    80005cf6:	e80e                	sd	gp,16(sp)
    80005cf8:	ec12                	sd	tp,24(sp)
    80005cfa:	f016                	sd	t0,32(sp)
    80005cfc:	f41a                	sd	t1,40(sp)
    80005cfe:	f81e                	sd	t2,48(sp)
    80005d00:	fc22                	sd	s0,56(sp)
    80005d02:	e0a6                	sd	s1,64(sp)
    80005d04:	e4aa                	sd	a0,72(sp)
    80005d06:	e8ae                	sd	a1,80(sp)
    80005d08:	ecb2                	sd	a2,88(sp)
    80005d0a:	f0b6                	sd	a3,96(sp)
    80005d0c:	f4ba                	sd	a4,104(sp)
    80005d0e:	f8be                	sd	a5,112(sp)
    80005d10:	fcc2                	sd	a6,120(sp)
    80005d12:	e146                	sd	a7,128(sp)
    80005d14:	e54a                	sd	s2,136(sp)
    80005d16:	e94e                	sd	s3,144(sp)
    80005d18:	ed52                	sd	s4,152(sp)
    80005d1a:	f156                	sd	s5,160(sp)
    80005d1c:	f55a                	sd	s6,168(sp)
    80005d1e:	f95e                	sd	s7,176(sp)
    80005d20:	fd62                	sd	s8,184(sp)
    80005d22:	e1e6                	sd	s9,192(sp)
    80005d24:	e5ea                	sd	s10,200(sp)
    80005d26:	e9ee                	sd	s11,208(sp)
    80005d28:	edf2                	sd	t3,216(sp)
    80005d2a:	f1f6                	sd	t4,224(sp)
    80005d2c:	f5fa                	sd	t5,232(sp)
    80005d2e:	f9fe                	sd	t6,240(sp)
    80005d30:	c1bfc0ef          	jal	ra,8000294a <kerneltrap>
    80005d34:	6082                	ld	ra,0(sp)
    80005d36:	6122                	ld	sp,8(sp)
    80005d38:	61c2                	ld	gp,16(sp)
    80005d3a:	7282                	ld	t0,32(sp)
    80005d3c:	7322                	ld	t1,40(sp)
    80005d3e:	73c2                	ld	t2,48(sp)
    80005d40:	7462                	ld	s0,56(sp)
    80005d42:	6486                	ld	s1,64(sp)
    80005d44:	6526                	ld	a0,72(sp)
    80005d46:	65c6                	ld	a1,80(sp)
    80005d48:	6666                	ld	a2,88(sp)
    80005d4a:	7686                	ld	a3,96(sp)
    80005d4c:	7726                	ld	a4,104(sp)
    80005d4e:	77c6                	ld	a5,112(sp)
    80005d50:	7866                	ld	a6,120(sp)
    80005d52:	688a                	ld	a7,128(sp)
    80005d54:	692a                	ld	s2,136(sp)
    80005d56:	69ca                	ld	s3,144(sp)
    80005d58:	6a6a                	ld	s4,152(sp)
    80005d5a:	7a8a                	ld	s5,160(sp)
    80005d5c:	7b2a                	ld	s6,168(sp)
    80005d5e:	7bca                	ld	s7,176(sp)
    80005d60:	7c6a                	ld	s8,184(sp)
    80005d62:	6c8e                	ld	s9,192(sp)
    80005d64:	6d2e                	ld	s10,200(sp)
    80005d66:	6dce                	ld	s11,208(sp)
    80005d68:	6e6e                	ld	t3,216(sp)
    80005d6a:	7e8e                	ld	t4,224(sp)
    80005d6c:	7f2e                	ld	t5,232(sp)
    80005d6e:	7fce                	ld	t6,240(sp)
    80005d70:	6111                	addi	sp,sp,256
    80005d72:	10200073          	sret

0000000080005d76 <unexpected_exc>:
    80005d76:	a001                	j	80005d76 <unexpected_exc>

0000000080005d78 <unexpected_int>:
    80005d78:	a001                	j	80005d78 <unexpected_int>
    80005d7a:	00000013          	nop
    80005d7e:	0001                	nop

0000000080005d80 <timervec>:
    80005d80:	34051573          	csrrw	a0,mscratch,a0
    80005d84:	e10c                	sd	a1,0(a0)
    80005d86:	e510                	sd	a2,8(a0)
    80005d88:	e914                	sd	a3,16(a0)
    80005d8a:	342025f3          	csrr	a1,mcause
    80005d8e:	fe05d4e3          	bgez	a1,80005d76 <unexpected_exc>
    80005d92:	fff0061b          	addiw	a2,zero,-1
    80005d96:	167e                	slli	a2,a2,0x3f
    80005d98:	061d                	addi	a2,a2,7
    80005d9a:	fcc59fe3          	bne	a1,a2,80005d78 <unexpected_int>
    80005d9e:	6d0c                	ld	a1,24(a0)
    80005da0:	7110                	ld	a2,32(a0)
    80005da2:	6194                	ld	a3,0(a1)
    80005da4:	96b2                	add	a3,a3,a2
    80005da6:	e194                	sd	a3,0(a1)
    80005da8:	4589                	li	a1,2
    80005daa:	14459073          	csrw	sip,a1
    80005dae:	6914                	ld	a3,16(a0)
    80005db0:	6510                	ld	a2,8(a0)
    80005db2:	610c                	ld	a1,0(a0)
    80005db4:	34051573          	csrrw	a0,mscratch,a0
    80005db8:	30200073          	mret
	...

0000000080005dc6 <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    80005dc6:	1141                	addi	sp,sp,-16
    80005dc8:	e422                	sd	s0,8(sp)
    80005dca:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005dcc:	0c0007b7          	lui	a5,0xc000
    80005dd0:	4705                	li	a4,1
    80005dd2:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005dd4:	c3d8                	sw	a4,4(a5)
}
    80005dd6:	6422                	ld	s0,8(sp)
    80005dd8:	0141                	addi	sp,sp,16
    80005dda:	8082                	ret

0000000080005ddc <plicinithart>:

void
plicinithart(void)
{
    80005ddc:	1141                	addi	sp,sp,-16
    80005dde:	e406                	sd	ra,8(sp)
    80005de0:	e022                	sd	s0,0(sp)
    80005de2:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005de4:	ffffc097          	auipc	ra,0xffffc
    80005de8:	c56080e7          	jalr	-938(ra) # 80001a3a <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    80005dec:	0085171b          	slliw	a4,a0,0x8
    80005df0:	0c0027b7          	lui	a5,0xc002
    80005df4:	97ba                	add	a5,a5,a4
    80005df6:	40200713          	li	a4,1026
    80005dfa:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    80005dfe:	00d5151b          	slliw	a0,a0,0xd
    80005e02:	0c2017b7          	lui	a5,0xc201
    80005e06:	953e                	add	a0,a0,a5
    80005e08:	00052023          	sw	zero,0(a0)
}
    80005e0c:	60a2                	ld	ra,8(sp)
    80005e0e:	6402                	ld	s0,0(sp)
    80005e10:	0141                	addi	sp,sp,16
    80005e12:	8082                	ret

0000000080005e14 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    80005e14:	1141                	addi	sp,sp,-16
    80005e16:	e406                	sd	ra,8(sp)
    80005e18:	e022                	sd	s0,0(sp)
    80005e1a:	0800                	addi	s0,sp,16
  int hart = cpuid();
    80005e1c:	ffffc097          	auipc	ra,0xffffc
    80005e20:	c1e080e7          	jalr	-994(ra) # 80001a3a <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    80005e24:	00d5179b          	slliw	a5,a0,0xd
    80005e28:	0c201537          	lui	a0,0xc201
    80005e2c:	953e                	add	a0,a0,a5
  return irq;
}
    80005e2e:	4148                	lw	a0,4(a0)
    80005e30:	60a2                	ld	ra,8(sp)
    80005e32:	6402                	ld	s0,0(sp)
    80005e34:	0141                	addi	sp,sp,16
    80005e36:	8082                	ret

0000000080005e38 <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    80005e38:	1101                	addi	sp,sp,-32
    80005e3a:	ec06                	sd	ra,24(sp)
    80005e3c:	e822                	sd	s0,16(sp)
    80005e3e:	e426                	sd	s1,8(sp)
    80005e40:	1000                	addi	s0,sp,32
    80005e42:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005e44:	ffffc097          	auipc	ra,0xffffc
    80005e48:	bf6080e7          	jalr	-1034(ra) # 80001a3a <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005e4c:	00d5151b          	slliw	a0,a0,0xd
    80005e50:	0c2017b7          	lui	a5,0xc201
    80005e54:	97aa                	add	a5,a5,a0
    80005e56:	c3c4                	sw	s1,4(a5)
}
    80005e58:	60e2                	ld	ra,24(sp)
    80005e5a:	6442                	ld	s0,16(sp)
    80005e5c:	64a2                	ld	s1,8(sp)
    80005e5e:	6105                	addi	sp,sp,32
    80005e60:	8082                	ret

0000000080005e62 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005e62:	1141                	addi	sp,sp,-16
    80005e64:	e406                	sd	ra,8(sp)
    80005e66:	e022                	sd	s0,0(sp)
    80005e68:	0800                	addi	s0,sp,16
  if(i >= NUM)
    80005e6a:	479d                	li	a5,7
    80005e6c:	06a7c963          	blt	a5,a0,80005ede <free_desc+0x7c>
    panic("free_desc 1");
  if(disk.free[i])
    80005e70:	0001d797          	auipc	a5,0x1d
    80005e74:	19078793          	addi	a5,a5,400 # 80023000 <disk>
    80005e78:	00a78733          	add	a4,a5,a0
    80005e7c:	6789                	lui	a5,0x2
    80005e7e:	97ba                	add	a5,a5,a4
    80005e80:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005e84:	e7ad                	bnez	a5,80005eee <free_desc+0x8c>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005e86:	00451793          	slli	a5,a0,0x4
    80005e8a:	0001f717          	auipc	a4,0x1f
    80005e8e:	17670713          	addi	a4,a4,374 # 80025000 <disk+0x2000>
    80005e92:	6314                	ld	a3,0(a4)
    80005e94:	96be                	add	a3,a3,a5
    80005e96:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    80005e9a:	6314                	ld	a3,0(a4)
    80005e9c:	96be                	add	a3,a3,a5
    80005e9e:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005ea2:	6314                	ld	a3,0(a4)
    80005ea4:	96be                	add	a3,a3,a5
    80005ea6:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    80005eaa:	6318                	ld	a4,0(a4)
    80005eac:	97ba                	add	a5,a5,a4
    80005eae:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005eb2:	0001d797          	auipc	a5,0x1d
    80005eb6:	14e78793          	addi	a5,a5,334 # 80023000 <disk>
    80005eba:	97aa                	add	a5,a5,a0
    80005ebc:	6509                	lui	a0,0x2
    80005ebe:	953e                	add	a0,a0,a5
    80005ec0:	4785                	li	a5,1
    80005ec2:	00f50c23          	sb	a5,24(a0) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005ec6:	0001f517          	auipc	a0,0x1f
    80005eca:	15250513          	addi	a0,a0,338 # 80025018 <disk+0x2018>
    80005ece:	ffffc097          	auipc	ra,0xffffc
    80005ed2:	3e4080e7          	jalr	996(ra) # 800022b2 <wakeup>
}
    80005ed6:	60a2                	ld	ra,8(sp)
    80005ed8:	6402                	ld	s0,0(sp)
    80005eda:	0141                	addi	sp,sp,16
    80005edc:	8082                	ret
    panic("free_desc 1");
    80005ede:	00003517          	auipc	a0,0x3
    80005ee2:	8da50513          	addi	a0,a0,-1830 # 800087b8 <syscalls+0x388>
    80005ee6:	ffffa097          	auipc	ra,0xffffa
    80005eea:	652080e7          	jalr	1618(ra) # 80000538 <panic>
    panic("free_desc 2");
    80005eee:	00003517          	auipc	a0,0x3
    80005ef2:	8da50513          	addi	a0,a0,-1830 # 800087c8 <syscalls+0x398>
    80005ef6:	ffffa097          	auipc	ra,0xffffa
    80005efa:	642080e7          	jalr	1602(ra) # 80000538 <panic>

0000000080005efe <virtio_disk_init>:
{
    80005efe:	1101                	addi	sp,sp,-32
    80005f00:	ec06                	sd	ra,24(sp)
    80005f02:	e822                	sd	s0,16(sp)
    80005f04:	e426                	sd	s1,8(sp)
    80005f06:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    80005f08:	00003597          	auipc	a1,0x3
    80005f0c:	8d058593          	addi	a1,a1,-1840 # 800087d8 <syscalls+0x3a8>
    80005f10:	0001f517          	auipc	a0,0x1f
    80005f14:	21850513          	addi	a0,a0,536 # 80025128 <disk+0x2128>
    80005f18:	ffffb097          	auipc	ra,0xffffb
    80005f1c:	c28080e7          	jalr	-984(ra) # 80000b40 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005f20:	100017b7          	lui	a5,0x10001
    80005f24:	4398                	lw	a4,0(a5)
    80005f26:	2701                	sext.w	a4,a4
    80005f28:	747277b7          	lui	a5,0x74727
    80005f2c:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    80005f30:	0ef71163          	bne	a4,a5,80006012 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005f34:	100017b7          	lui	a5,0x10001
    80005f38:	43dc                	lw	a5,4(a5)
    80005f3a:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    80005f3c:	4705                	li	a4,1
    80005f3e:	0ce79a63          	bne	a5,a4,80006012 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005f42:	100017b7          	lui	a5,0x10001
    80005f46:	479c                	lw	a5,8(a5)
    80005f48:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    80005f4a:	4709                	li	a4,2
    80005f4c:	0ce79363          	bne	a5,a4,80006012 <virtio_disk_init+0x114>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005f50:	100017b7          	lui	a5,0x10001
    80005f54:	47d8                	lw	a4,12(a5)
    80005f56:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005f58:	554d47b7          	lui	a5,0x554d4
    80005f5c:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005f60:	0af71963          	bne	a4,a5,80006012 <virtio_disk_init+0x114>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f64:	100017b7          	lui	a5,0x10001
    80005f68:	4705                	li	a4,1
    80005f6a:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f6c:	470d                	li	a4,3
    80005f6e:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005f70:	4b94                	lw	a3,16(a5)
  features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
    80005f72:	c7ffe737          	lui	a4,0xc7ffe
    80005f76:	75f70713          	addi	a4,a4,1887 # ffffffffc7ffe75f <end+0xffffffff47fd8107>
    80005f7a:	8f75                	and	a4,a4,a3
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005f7c:	2701                	sext.w	a4,a4
    80005f7e:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f80:	472d                	li	a4,11
    80005f82:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005f84:	473d                	li	a4,15
    80005f86:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80005f88:	6705                	lui	a4,0x1
    80005f8a:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    80005f8c:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005f90:	5bdc                	lw	a5,52(a5)
    80005f92:	2781                	sext.w	a5,a5
  if(max == 0)
    80005f94:	c7d9                	beqz	a5,80006022 <virtio_disk_init+0x124>
  if(max < NUM)
    80005f96:	471d                	li	a4,7
    80005f98:	08f77d63          	bgeu	a4,a5,80006032 <virtio_disk_init+0x134>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    80005f9c:	100014b7          	lui	s1,0x10001
    80005fa0:	47a1                	li	a5,8
    80005fa2:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005fa4:	6609                	lui	a2,0x2
    80005fa6:	4581                	li	a1,0
    80005fa8:	0001d517          	auipc	a0,0x1d
    80005fac:	05850513          	addi	a0,a0,88 # 80023000 <disk>
    80005fb0:	ffffb097          	auipc	ra,0xffffb
    80005fb4:	d1c080e7          	jalr	-740(ra) # 80000ccc <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005fb8:	0001d717          	auipc	a4,0x1d
    80005fbc:	04870713          	addi	a4,a4,72 # 80023000 <disk>
    80005fc0:	00c75793          	srli	a5,a4,0xc
    80005fc4:	2781                	sext.w	a5,a5
    80005fc6:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    80005fc8:	0001f797          	auipc	a5,0x1f
    80005fcc:	03878793          	addi	a5,a5,56 # 80025000 <disk+0x2000>
    80005fd0:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005fd2:	0001d717          	auipc	a4,0x1d
    80005fd6:	0ae70713          	addi	a4,a4,174 # 80023080 <disk+0x80>
    80005fda:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    80005fdc:	0001e717          	auipc	a4,0x1e
    80005fe0:	02470713          	addi	a4,a4,36 # 80024000 <disk+0x1000>
    80005fe4:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    80005fe6:	4705                	li	a4,1
    80005fe8:	00e78c23          	sb	a4,24(a5)
    80005fec:	00e78ca3          	sb	a4,25(a5)
    80005ff0:	00e78d23          	sb	a4,26(a5)
    80005ff4:	00e78da3          	sb	a4,27(a5)
    80005ff8:	00e78e23          	sb	a4,28(a5)
    80005ffc:	00e78ea3          	sb	a4,29(a5)
    80006000:	00e78f23          	sb	a4,30(a5)
    80006004:	00e78fa3          	sb	a4,31(a5)
}
    80006008:	60e2                	ld	ra,24(sp)
    8000600a:	6442                	ld	s0,16(sp)
    8000600c:	64a2                	ld	s1,8(sp)
    8000600e:	6105                	addi	sp,sp,32
    80006010:	8082                	ret
    panic("could not find virtio disk");
    80006012:	00002517          	auipc	a0,0x2
    80006016:	7d650513          	addi	a0,a0,2006 # 800087e8 <syscalls+0x3b8>
    8000601a:	ffffa097          	auipc	ra,0xffffa
    8000601e:	51e080e7          	jalr	1310(ra) # 80000538 <panic>
    panic("virtio disk has no queue 0");
    80006022:	00002517          	auipc	a0,0x2
    80006026:	7e650513          	addi	a0,a0,2022 # 80008808 <syscalls+0x3d8>
    8000602a:	ffffa097          	auipc	ra,0xffffa
    8000602e:	50e080e7          	jalr	1294(ra) # 80000538 <panic>
    panic("virtio disk max queue too short");
    80006032:	00002517          	auipc	a0,0x2
    80006036:	7f650513          	addi	a0,a0,2038 # 80008828 <syscalls+0x3f8>
    8000603a:	ffffa097          	auipc	ra,0xffffa
    8000603e:	4fe080e7          	jalr	1278(ra) # 80000538 <panic>

0000000080006042 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80006042:	7119                	addi	sp,sp,-128
    80006044:	fc86                	sd	ra,120(sp)
    80006046:	f8a2                	sd	s0,112(sp)
    80006048:	f4a6                	sd	s1,104(sp)
    8000604a:	f0ca                	sd	s2,96(sp)
    8000604c:	ecce                	sd	s3,88(sp)
    8000604e:	e8d2                	sd	s4,80(sp)
    80006050:	e4d6                	sd	s5,72(sp)
    80006052:	e0da                	sd	s6,64(sp)
    80006054:	fc5e                	sd	s7,56(sp)
    80006056:	f862                	sd	s8,48(sp)
    80006058:	f466                	sd	s9,40(sp)
    8000605a:	f06a                	sd	s10,32(sp)
    8000605c:	ec6e                	sd	s11,24(sp)
    8000605e:	0100                	addi	s0,sp,128
    80006060:	8aaa                	mv	s5,a0
    80006062:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80006064:	00c52c83          	lw	s9,12(a0)
    80006068:	001c9c9b          	slliw	s9,s9,0x1
    8000606c:	1c82                	slli	s9,s9,0x20
    8000606e:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80006072:	0001f517          	auipc	a0,0x1f
    80006076:	0b650513          	addi	a0,a0,182 # 80025128 <disk+0x2128>
    8000607a:	ffffb097          	auipc	ra,0xffffb
    8000607e:	b56080e7          	jalr	-1194(ra) # 80000bd0 <acquire>
  for(int i = 0; i < 3; i++){
    80006082:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80006084:	44a1                	li	s1,8
      disk.free[i] = 0;
    80006086:	0001dc17          	auipc	s8,0x1d
    8000608a:	f7ac0c13          	addi	s8,s8,-134 # 80023000 <disk>
    8000608e:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    80006090:	4b0d                	li	s6,3
    80006092:	a0ad                	j	800060fc <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    80006094:	00fc0733          	add	a4,s8,a5
    80006098:	975e                	add	a4,a4,s7
    8000609a:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    8000609e:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    800060a0:	0207c563          	bltz	a5,800060ca <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    800060a4:	2905                	addiw	s2,s2,1
    800060a6:	0611                	addi	a2,a2,4
    800060a8:	19690d63          	beq	s2,s6,80006242 <virtio_disk_rw+0x200>
    idx[i] = alloc_desc();
    800060ac:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    800060ae:	0001f717          	auipc	a4,0x1f
    800060b2:	f6a70713          	addi	a4,a4,-150 # 80025018 <disk+0x2018>
    800060b6:	87ce                	mv	a5,s3
    if(disk.free[i]){
    800060b8:	00074683          	lbu	a3,0(a4)
    800060bc:	fee1                	bnez	a3,80006094 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    800060be:	2785                	addiw	a5,a5,1
    800060c0:	0705                	addi	a4,a4,1
    800060c2:	fe979be3          	bne	a5,s1,800060b8 <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    800060c6:	57fd                	li	a5,-1
    800060c8:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    800060ca:	01205d63          	blez	s2,800060e4 <virtio_disk_rw+0xa2>
    800060ce:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    800060d0:	000a2503          	lw	a0,0(s4)
    800060d4:	00000097          	auipc	ra,0x0
    800060d8:	d8e080e7          	jalr	-626(ra) # 80005e62 <free_desc>
      for(int j = 0; j < i; j++)
    800060dc:	2d85                	addiw	s11,s11,1
    800060de:	0a11                	addi	s4,s4,4
    800060e0:	ffb918e3          	bne	s2,s11,800060d0 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800060e4:	0001f597          	auipc	a1,0x1f
    800060e8:	04458593          	addi	a1,a1,68 # 80025128 <disk+0x2128>
    800060ec:	0001f517          	auipc	a0,0x1f
    800060f0:	f2c50513          	addi	a0,a0,-212 # 80025018 <disk+0x2018>
    800060f4:	ffffc097          	auipc	ra,0xffffc
    800060f8:	032080e7          	jalr	50(ra) # 80002126 <sleep>
  for(int i = 0; i < 3; i++){
    800060fc:	f8040a13          	addi	s4,s0,-128
{
    80006100:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    80006102:	894e                	mv	s2,s3
    80006104:	b765                	j	800060ac <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    80006106:	0001f697          	auipc	a3,0x1f
    8000610a:	efa6b683          	ld	a3,-262(a3) # 80025000 <disk+0x2000>
    8000610e:	96ba                	add	a3,a3,a4
    80006110:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    80006114:	0001d817          	auipc	a6,0x1d
    80006118:	eec80813          	addi	a6,a6,-276 # 80023000 <disk>
    8000611c:	0001f697          	auipc	a3,0x1f
    80006120:	ee468693          	addi	a3,a3,-284 # 80025000 <disk+0x2000>
    80006124:	6290                	ld	a2,0(a3)
    80006126:	963a                	add	a2,a2,a4
    80006128:	00c65583          	lhu	a1,12(a2) # 200c <_entry-0x7fffdff4>
    8000612c:	0015e593          	ori	a1,a1,1
    80006130:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    80006134:	f8842603          	lw	a2,-120(s0)
    80006138:	628c                	ld	a1,0(a3)
    8000613a:	972e                	add	a4,a4,a1
    8000613c:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80006140:	20050593          	addi	a1,a0,512
    80006144:	0592                	slli	a1,a1,0x4
    80006146:	95c2                	add	a1,a1,a6
    80006148:	577d                	li	a4,-1
    8000614a:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000614e:	00461713          	slli	a4,a2,0x4
    80006152:	6290                	ld	a2,0(a3)
    80006154:	963a                	add	a2,a2,a4
    80006156:	03078793          	addi	a5,a5,48
    8000615a:	97c2                	add	a5,a5,a6
    8000615c:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    8000615e:	629c                	ld	a5,0(a3)
    80006160:	97ba                	add	a5,a5,a4
    80006162:	4605                	li	a2,1
    80006164:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80006166:	629c                	ld	a5,0(a3)
    80006168:	97ba                	add	a5,a5,a4
    8000616a:	4809                	li	a6,2
    8000616c:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80006170:	629c                	ld	a5,0(a3)
    80006172:	973e                	add	a4,a4,a5
    80006174:	00071723          	sh	zero,14(a4)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80006178:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    8000617c:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80006180:	6698                	ld	a4,8(a3)
    80006182:	00275783          	lhu	a5,2(a4)
    80006186:	8b9d                	andi	a5,a5,7
    80006188:	0786                	slli	a5,a5,0x1
    8000618a:	97ba                	add	a5,a5,a4
    8000618c:	00a79223          	sh	a0,4(a5)

  __sync_synchronize();
    80006190:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80006194:	6698                	ld	a4,8(a3)
    80006196:	00275783          	lhu	a5,2(a4)
    8000619a:	2785                	addiw	a5,a5,1
    8000619c:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    800061a0:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    800061a4:	100017b7          	lui	a5,0x10001
    800061a8:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    800061ac:	004aa783          	lw	a5,4(s5)
    800061b0:	02c79163          	bne	a5,a2,800061d2 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    800061b4:	0001f917          	auipc	s2,0x1f
    800061b8:	f7490913          	addi	s2,s2,-140 # 80025128 <disk+0x2128>
  while(b->disk == 1) {
    800061bc:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    800061be:	85ca                	mv	a1,s2
    800061c0:	8556                	mv	a0,s5
    800061c2:	ffffc097          	auipc	ra,0xffffc
    800061c6:	f64080e7          	jalr	-156(ra) # 80002126 <sleep>
  while(b->disk == 1) {
    800061ca:	004aa783          	lw	a5,4(s5)
    800061ce:	fe9788e3          	beq	a5,s1,800061be <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    800061d2:	f8042903          	lw	s2,-128(s0)
    800061d6:	20090793          	addi	a5,s2,512
    800061da:	00479713          	slli	a4,a5,0x4
    800061de:	0001d797          	auipc	a5,0x1d
    800061e2:	e2278793          	addi	a5,a5,-478 # 80023000 <disk>
    800061e6:	97ba                	add	a5,a5,a4
    800061e8:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    800061ec:	0001f997          	auipc	s3,0x1f
    800061f0:	e1498993          	addi	s3,s3,-492 # 80025000 <disk+0x2000>
    800061f4:	00491713          	slli	a4,s2,0x4
    800061f8:	0009b783          	ld	a5,0(s3)
    800061fc:	97ba                	add	a5,a5,a4
    800061fe:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    80006202:	854a                	mv	a0,s2
    80006204:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    80006208:	00000097          	auipc	ra,0x0
    8000620c:	c5a080e7          	jalr	-934(ra) # 80005e62 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    80006210:	8885                	andi	s1,s1,1
    80006212:	f0ed                	bnez	s1,800061f4 <virtio_disk_rw+0x1b2>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    80006214:	0001f517          	auipc	a0,0x1f
    80006218:	f1450513          	addi	a0,a0,-236 # 80025128 <disk+0x2128>
    8000621c:	ffffb097          	auipc	ra,0xffffb
    80006220:	a68080e7          	jalr	-1432(ra) # 80000c84 <release>
}
    80006224:	70e6                	ld	ra,120(sp)
    80006226:	7446                	ld	s0,112(sp)
    80006228:	74a6                	ld	s1,104(sp)
    8000622a:	7906                	ld	s2,96(sp)
    8000622c:	69e6                	ld	s3,88(sp)
    8000622e:	6a46                	ld	s4,80(sp)
    80006230:	6aa6                	ld	s5,72(sp)
    80006232:	6b06                	ld	s6,64(sp)
    80006234:	7be2                	ld	s7,56(sp)
    80006236:	7c42                	ld	s8,48(sp)
    80006238:	7ca2                	ld	s9,40(sp)
    8000623a:	7d02                	ld	s10,32(sp)
    8000623c:	6de2                	ld	s11,24(sp)
    8000623e:	6109                	addi	sp,sp,128
    80006240:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006242:	f8042503          	lw	a0,-128(s0)
    80006246:	20050793          	addi	a5,a0,512
    8000624a:	0792                	slli	a5,a5,0x4
  if(write)
    8000624c:	0001d817          	auipc	a6,0x1d
    80006250:	db480813          	addi	a6,a6,-588 # 80023000 <disk>
    80006254:	00f80733          	add	a4,a6,a5
    80006258:	01a036b3          	snez	a3,s10
    8000625c:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    80006260:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80006264:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    80006268:	7679                	lui	a2,0xffffe
    8000626a:	963e                	add	a2,a2,a5
    8000626c:	0001f697          	auipc	a3,0x1f
    80006270:	d9468693          	addi	a3,a3,-620 # 80025000 <disk+0x2000>
    80006274:	6298                	ld	a4,0(a3)
    80006276:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80006278:	0a878593          	addi	a1,a5,168
    8000627c:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000627e:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    80006280:	6298                	ld	a4,0(a3)
    80006282:	9732                	add	a4,a4,a2
    80006284:	45c1                	li	a1,16
    80006286:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80006288:	6298                	ld	a4,0(a3)
    8000628a:	9732                	add	a4,a4,a2
    8000628c:	4585                	li	a1,1
    8000628e:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80006292:	f8442703          	lw	a4,-124(s0)
    80006296:	628c                	ld	a1,0(a3)
    80006298:	962e                	add	a2,a2,a1
    8000629a:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd79b6>
  disk.desc[idx[1]].addr = (uint64) b->data;
    8000629e:	0712                	slli	a4,a4,0x4
    800062a0:	6290                	ld	a2,0(a3)
    800062a2:	963a                	add	a2,a2,a4
    800062a4:	058a8593          	addi	a1,s5,88
    800062a8:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    800062aa:	6294                	ld	a3,0(a3)
    800062ac:	96ba                	add	a3,a3,a4
    800062ae:	40000613          	li	a2,1024
    800062b2:	c690                	sw	a2,8(a3)
  if(write)
    800062b4:	e40d19e3          	bnez	s10,80006106 <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    800062b8:	0001f697          	auipc	a3,0x1f
    800062bc:	d486b683          	ld	a3,-696(a3) # 80025000 <disk+0x2000>
    800062c0:	96ba                	add	a3,a3,a4
    800062c2:	4609                	li	a2,2
    800062c4:	00c69623          	sh	a2,12(a3)
    800062c8:	b5b1                	j	80006114 <virtio_disk_rw+0xd2>

00000000800062ca <virtio_disk_intr>:

void
virtio_disk_intr()
{
    800062ca:	1101                	addi	sp,sp,-32
    800062cc:	ec06                	sd	ra,24(sp)
    800062ce:	e822                	sd	s0,16(sp)
    800062d0:	e426                	sd	s1,8(sp)
    800062d2:	e04a                	sd	s2,0(sp)
    800062d4:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    800062d6:	0001f517          	auipc	a0,0x1f
    800062da:	e5250513          	addi	a0,a0,-430 # 80025128 <disk+0x2128>
    800062de:	ffffb097          	auipc	ra,0xffffb
    800062e2:	8f2080e7          	jalr	-1806(ra) # 80000bd0 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800062e6:	10001737          	lui	a4,0x10001
    800062ea:	533c                	lw	a5,96(a4)
    800062ec:	8b8d                	andi	a5,a5,3
    800062ee:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800062f0:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800062f4:	0001f797          	auipc	a5,0x1f
    800062f8:	d0c78793          	addi	a5,a5,-756 # 80025000 <disk+0x2000>
    800062fc:	6b94                	ld	a3,16(a5)
    800062fe:	0207d703          	lhu	a4,32(a5)
    80006302:	0026d783          	lhu	a5,2(a3)
    80006306:	06f70163          	beq	a4,a5,80006368 <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000630a:	0001d917          	auipc	s2,0x1d
    8000630e:	cf690913          	addi	s2,s2,-778 # 80023000 <disk>
    80006312:	0001f497          	auipc	s1,0x1f
    80006316:	cee48493          	addi	s1,s1,-786 # 80025000 <disk+0x2000>
    __sync_synchronize();
    8000631a:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    8000631e:	6898                	ld	a4,16(s1)
    80006320:	0204d783          	lhu	a5,32(s1)
    80006324:	8b9d                	andi	a5,a5,7
    80006326:	078e                	slli	a5,a5,0x3
    80006328:	97ba                	add	a5,a5,a4
    8000632a:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    8000632c:	20078713          	addi	a4,a5,512
    80006330:	0712                	slli	a4,a4,0x4
    80006332:	974a                	add	a4,a4,s2
    80006334:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    80006338:	e731                	bnez	a4,80006384 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    8000633a:	20078793          	addi	a5,a5,512
    8000633e:	0792                	slli	a5,a5,0x4
    80006340:	97ca                	add	a5,a5,s2
    80006342:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80006344:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80006348:	ffffc097          	auipc	ra,0xffffc
    8000634c:	f6a080e7          	jalr	-150(ra) # 800022b2 <wakeup>

    disk.used_idx += 1;
    80006350:	0204d783          	lhu	a5,32(s1)
    80006354:	2785                	addiw	a5,a5,1
    80006356:	17c2                	slli	a5,a5,0x30
    80006358:	93c1                	srli	a5,a5,0x30
    8000635a:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    8000635e:	6898                	ld	a4,16(s1)
    80006360:	00275703          	lhu	a4,2(a4)
    80006364:	faf71be3          	bne	a4,a5,8000631a <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    80006368:	0001f517          	auipc	a0,0x1f
    8000636c:	dc050513          	addi	a0,a0,-576 # 80025128 <disk+0x2128>
    80006370:	ffffb097          	auipc	ra,0xffffb
    80006374:	914080e7          	jalr	-1772(ra) # 80000c84 <release>
}
    80006378:	60e2                	ld	ra,24(sp)
    8000637a:	6442                	ld	s0,16(sp)
    8000637c:	64a2                	ld	s1,8(sp)
    8000637e:	6902                	ld	s2,0(sp)
    80006380:	6105                	addi	sp,sp,32
    80006382:	8082                	ret
      panic("virtio_disk_intr status");
    80006384:	00002517          	auipc	a0,0x2
    80006388:	4c450513          	addi	a0,a0,1220 # 80008848 <syscalls+0x418>
    8000638c:	ffffa097          	auipc	ra,0xffffa
    80006390:	1ac080e7          	jalr	428(ra) # 80000538 <panic>

0000000080006394 <create_the_buffer>:
struct ringbuf ringbufs[MAX_RINGBUFS];



uint64 create_the_buffer(char nameBuf[16], int open_or_close, uint64 *address_64bit_ring_buffer_mapped)
{
    80006394:	711d                	addi	sp,sp,-96
    80006396:	ec86                	sd	ra,88(sp)
    80006398:	e8a2                	sd	s0,80(sp)
    8000639a:	e4a6                	sd	s1,72(sp)
    8000639c:	e0ca                	sd	s2,64(sp)
    8000639e:	fc4e                	sd	s3,56(sp)
    800063a0:	f852                	sd	s4,48(sp)
    800063a2:	f456                	sd	s5,40(sp)
    800063a4:	f05a                	sd	s6,32(sp)
    800063a6:	ec5e                	sd	s7,24(sp)
    800063a8:	e862                	sd	s8,16(sp)
    800063aa:	e466                	sd	s9,8(sp)
    800063ac:	1080                	addi	s0,sp,96
    800063ae:	84aa                	mv	s1,a0
    800063b0:	892e                	mv	s2,a1
  int i,j;
  // uint64 first_va;

  //initializing the lock
  initlock(&ringbuf_lk.ringbuf_lock, "ring_lock");
    800063b2:	00002597          	auipc	a1,0x2
    800063b6:	4ae58593          	addi	a1,a1,1198 # 80008860 <syscalls+0x430>
    800063ba:	00020517          	auipc	a0,0x20
    800063be:	c4650513          	addi	a0,a0,-954 # 80026000 <ringbuf_lk>
    800063c2:	ffffa097          	auipc	ra,0xffffa
    800063c6:	77e080e7          	jalr	1918(ra) # 80000b40 <initlock>

  for(i=0; i<MAX_RINGBUFS; i++){
    if(ringbufs[i].name != nameBuf || ringbufs[i].refcount == 0 ){
    800063ca:	00020797          	auipc	a5,0x20
    800063ce:	c5278793          	addi	a5,a5,-942 # 8002601c <ringbufs+0x4>
    800063d2:	06f49363          	bne	s1,a5,80006438 <create_the_buffer+0xa4>
    800063d6:	00020a17          	auipc	s4,0x20
    800063da:	c42a2a03          	lw	s4,-958(s4) # 80026018 <ringbufs>
  for(i=0; i<MAX_RINGBUFS; i++){
    800063de:	01403a33          	snez	s4,s4
      for(int k=0; k<16;k++)
    800063e2:	87a6                	mv	a5,s1
    800063e4:	002a1993          	slli	s3,s4,0x2
    800063e8:	99d2                	add	s3,s3,s4
    800063ea:	00599a93          	slli	s5,s3,0x5
    800063ee:	00020717          	auipc	a4,0x20
    800063f2:	c2e70713          	addi	a4,a4,-978 # 8002601c <ringbufs+0x4>
    800063f6:	9756                	add	a4,a4,s5
    800063f8:	01048613          	addi	a2,s1,16
        ringbufs[i].name[k] = nameBuf[k];
    800063fc:	0007c683          	lbu	a3,0(a5)
    80006400:	00d70023          	sb	a3,0(a4)
      for(int k=0; k<16;k++)
    80006404:	0785                	addi	a5,a5,1
    80006406:	0705                	addi	a4,a4,1
    80006408:	fec79ae3          	bne	a5,a2,800063fc <create_the_buffer+0x68>
      //printf("Name of ring buffer: %s\n", ringbufs[i].name);
      break;
    }
  }
  if(open_or_close == 1){
    8000640c:	4785                	li	a5,1
    8000640e:	02f90763          	beq	s2,a5,8000643c <create_the_buffer+0xa8>

  }
  else{
    //free up memory;
    //acquire lock
     acquire(&ringbuf_lk.ringbuf_lock);
    80006412:	00020517          	auipc	a0,0x20
    80006416:	bee50513          	addi	a0,a0,-1042 # 80026000 <ringbuf_lk>
    8000641a:	ffffa097          	auipc	ra,0xffffa
    8000641e:	7b6080e7          	jalr	1974(ra) # 80000bd0 <acquire>
    for(j=0;j<16;j++){
    80006422:	00020497          	auipc	s1,0x20
    80006426:	bf648493          	addi	s1,s1,-1034 # 80026018 <ringbufs>
    8000642a:	94d6                	add	s1,s1,s5
    8000642c:	00020997          	auipc	s3,0x20
    80006430:	c6c98993          	addi	s3,s3,-916 # 80026098 <ringbufs+0x80>
    80006434:	99d6                	add	s3,s3,s5
    80006436:	a2dd                	j	8000661c <create_the_buffer+0x288>
  for(i=0; i<MAX_RINGBUFS; i++){
    80006438:	4a01                	li	s4,0
    8000643a:	b765                	j	800063e2 <create_the_buffer+0x4e>
    acquire(&ringbuf_lk.ringbuf_lock);
    8000643c:	00020497          	auipc	s1,0x20
    80006440:	bc448493          	addi	s1,s1,-1084 # 80026000 <ringbuf_lk>
    80006444:	8526                	mv	a0,s1
    80006446:	ffffa097          	auipc	ra,0xffffa
    8000644a:	78a080e7          	jalr	1930(ra) # 80000bd0 <acquire>
    ringbufs[i].refcount++;
    8000644e:	002a1793          	slli	a5,s4,0x2
    80006452:	97d2                	add	a5,a5,s4
    80006454:	0796                	slli	a5,a5,0x5
    80006456:	94be                	add	s1,s1,a5
    80006458:	4c9c                	lw	a5,24(s1)
    8000645a:	2785                	addiw	a5,a5,1
    8000645c:	cc9c                	sw	a5,24(s1)
    struct proc *pr = myproc();
    8000645e:	ffffb097          	auipc	ra,0xffffb
    80006462:	608080e7          	jalr	1544(ra) # 80001a66 <myproc>
    80006466:	892a                	mv	s2,a0
    printf("At first the Virtual Address: %p %p\n", vaa, va);
    80006468:	020004b7          	lui	s1,0x2000
    8000646c:	14b5                	addi	s1,s1,-19
    8000646e:	00d49613          	slli	a2,s1,0xd
    80006472:	040005b7          	lui	a1,0x4000
    80006476:	15f5                	addi	a1,a1,-3
    80006478:	05b2                	slli	a1,a1,0xc
    8000647a:	00002517          	auipc	a0,0x2
    8000647e:	3f650513          	addi	a0,a0,1014 # 80008870 <syscalls+0x440>
    80006482:	ffffa097          	auipc	ra,0xffffa
    80006486:	100080e7          	jalr	256(ra) # 80000582 <printf>
    for(j=0;j<16;j++){
    8000648a:	00020997          	auipc	s3,0x20
    8000648e:	b8e98993          	addi	s3,s3,-1138 # 80026018 <ringbufs>
    80006492:	99d6                	add	s3,s3,s5
    uint64 va = vaa - (35* PGSIZE);
    80006494:	04b6                	slli	s1,s1,0xd
        printf("mapping 1st virual page\n");
    80006496:	00002c17          	auipc	s8,0x2
    8000649a:	412c0c13          	addi	s8,s8,1042 # 800088a8 <syscalls+0x478>
        printf("unmapped\n");
    8000649e:	00002c97          	auipc	s9,0x2
    800064a2:	3fac8c93          	addi	s9,s9,1018 # 80008898 <syscalls+0x468>
        printf("mapping 2nd virtual page\n");
    800064a6:	00002b97          	auipc	s7,0x2
    800064aa:	422b8b93          	addi	s7,s7,1058 # 800088c8 <syscalls+0x498>
    for(j=0;j<16;j++){
    800064ae:	02000b37          	lui	s6,0x2000
    800064b2:	1b55                	addi	s6,s6,-11
    800064b4:	0b36                	slli	s6,s6,0xd
    800064b6:	a805                	j	800064e6 <create_the_buffer+0x152>
        printf("unmapped\n");
    800064b8:	8566                	mv	a0,s9
    800064ba:	ffffa097          	auipc	ra,0xffffa
    800064be:	0c8080e7          	jalr	200(ra) # 80000582 <printf>
    800064c2:	a885                	j	80006532 <create_the_buffer+0x19e>
        printf("mapping 2nd virtual page\n");
    800064c4:	855e                	mv	a0,s7
    800064c6:	ffffa097          	auipc	ra,0xffffa
    800064ca:	0bc080e7          	jalr	188(ra) # 80000582 <printf>
      uvmunmap(pr->pagetable, va, PGROUNDUP(4096)/PGSIZE, 1);
    800064ce:	4685                	li	a3,1
    800064d0:	4605                	li	a2,1
    800064d2:	85a6                	mv	a1,s1
    800064d4:	05093503          	ld	a0,80(s2)
    800064d8:	ffffb097          	auipc	ra,0xffffb
    800064dc:	d78080e7          	jalr	-648(ra) # 80001250 <uvmunmap>
    for(j=0;j<16;j++){
    800064e0:	09a1                	addi	s3,s3,8
    800064e2:	09648d63          	beq	s1,s6,8000657c <create_the_buffer+0x1e8>
      ringbufs[i].buf[j] = kalloc();
    800064e6:	ffffa097          	auipc	ra,0xffffa
    800064ea:	5fa080e7          	jalr	1530(ra) # 80000ae0 <kalloc>
    800064ee:	8ace                	mv	s5,s3
    800064f0:	00a9bc23          	sd	a0,24(s3)
      memset(ringbufs[i].buf[j], 0, 4096);
    800064f4:	6605                	lui	a2,0x1
    800064f6:	4581                	li	a1,0
    800064f8:	ffffa097          	auipc	ra,0xffffa
    800064fc:	7d4080e7          	jalr	2004(ra) # 80000ccc <memset>
      mappages(pr->pagetable, va, 4096, (uint64)ringbufs[i].buf[j], PTE_W|PTE_R|PTE_U);
    80006500:	4759                	li	a4,22
    80006502:	0189b683          	ld	a3,24(s3)
    80006506:	6605                	lui	a2,0x1
    80006508:	85a6                	mv	a1,s1
    8000650a:	05093503          	ld	a0,80(s2)
    8000650e:	ffffb097          	auipc	ra,0xffffb
    80006512:	b8e080e7          	jalr	-1138(ra) # 8000109c <mappages>
      pte =  walk(pr->pagetable,va, 0);
    80006516:	4601                	li	a2,0
    80006518:	85a6                	mv	a1,s1
    8000651a:	05093503          	ld	a0,80(s2)
    8000651e:	ffffb097          	auipc	ra,0xffffb
    80006522:	a96080e7          	jalr	-1386(ra) # 80000fb4 <walk>
      if(pte == 0)
    80006526:	d949                	beqz	a0,800064b8 <create_the_buffer+0x124>
        printf("mapping 1st virual page\n");
    80006528:	8562                	mv	a0,s8
    8000652a:	ffffa097          	auipc	ra,0xffffa
    8000652e:	058080e7          	jalr	88(ra) # 80000582 <printf>
      uvmunmap(pr->pagetable, va, PGROUNDUP(4096)/PGSIZE, 1);
    80006532:	4685                	li	a3,1
    80006534:	4605                	li	a2,1
    80006536:	85a6                	mv	a1,s1
    80006538:	05093503          	ld	a0,80(s2)
    8000653c:	ffffb097          	auipc	ra,0xffffb
    80006540:	d14080e7          	jalr	-748(ra) # 80001250 <uvmunmap>
      va += 4096;
    80006544:	6785                	lui	a5,0x1
    80006546:	94be                	add	s1,s1,a5
      mappages(pr->pagetable, va, 4096, (uint64)ringbufs[i].buf[j], PTE_W | PTE_R | PTE_U);
    80006548:	4759                	li	a4,22
    8000654a:	018ab683          	ld	a3,24(s5)
    8000654e:	6605                	lui	a2,0x1
    80006550:	85a6                	mv	a1,s1
    80006552:	05093503          	ld	a0,80(s2)
    80006556:	ffffb097          	auipc	ra,0xffffb
    8000655a:	b46080e7          	jalr	-1210(ra) # 8000109c <mappages>
      pte1 =  walk(pr->pagetable,va, 0);
    8000655e:	4601                	li	a2,0
    80006560:	85a6                	mv	a1,s1
    80006562:	05093503          	ld	a0,80(s2)
    80006566:	ffffb097          	auipc	ra,0xffffb
    8000656a:	a4e080e7          	jalr	-1458(ra) # 80000fb4 <walk>
      if(pte1 == 0)
    8000656e:	f939                	bnez	a0,800064c4 <create_the_buffer+0x130>
        printf("unmapped\n");
    80006570:	8566                	mv	a0,s9
    80006572:	ffffa097          	auipc	ra,0xffffa
    80006576:	010080e7          	jalr	16(ra) # 80000582 <printf>
    8000657a:	bf91                	j	800064ce <create_the_buffer+0x13a>
    ringbufs[i].book = kalloc();
    8000657c:	ffffa097          	auipc	ra,0xffffa
    80006580:	564080e7          	jalr	1380(ra) # 80000ae0 <kalloc>
    80006584:	86aa                	mv	a3,a0
    80006586:	002a1793          	slli	a5,s4,0x2
    8000658a:	9a3e                	add	s4,s4,a5
    8000658c:	0a16                	slli	s4,s4,0x5
    8000658e:	00020797          	auipc	a5,0x20
    80006592:	a7278793          	addi	a5,a5,-1422 # 80026000 <ringbuf_lk>
    80006596:	9a3e                	add	s4,s4,a5
    80006598:	0aaa3823          	sd	a0,176(s4)
    mappages(pr->pagetable, va, 4096, (uint64)ringbufs[i].book, PTE_W | PTE_R | PTE_U);
    8000659c:	4759                	li	a4,22
    8000659e:	6605                	lui	a2,0x1
    800065a0:	040004b7          	lui	s1,0x4000
    800065a4:	14ad                	addi	s1,s1,-21
    800065a6:	00c49593          	slli	a1,s1,0xc
    800065aa:	05093503          	ld	a0,80(s2)
    800065ae:	ffffb097          	auipc	ra,0xffffb
    800065b2:	aee080e7          	jalr	-1298(ra) # 8000109c <mappages>
    pte1 =  walk(pr->pagetable,va, 0);
    800065b6:	4601                	li	a2,0
    800065b8:	00c49593          	slli	a1,s1,0xc
    800065bc:	05093503          	ld	a0,80(s2)
    800065c0:	ffffb097          	auipc	ra,0xffffb
    800065c4:	9f4080e7          	jalr	-1548(ra) # 80000fb4 <walk>
    if(pte1 == 0)
    800065c8:	cd15                	beqz	a0,80006604 <create_the_buffer+0x270>
      printf("Bookkeeping pages are mapped\n");
    800065ca:	00002517          	auipc	a0,0x2
    800065ce:	31e50513          	addi	a0,a0,798 # 800088e8 <syscalls+0x4b8>
    800065d2:	ffffa097          	auipc	ra,0xffffa
    800065d6:	fb0080e7          	jalr	-80(ra) # 80000582 <printf>
    uvmunmap(pr->pagetable, va, PGROUNDUP(4096)/PGSIZE, 1);
    800065da:	4685                	li	a3,1
    800065dc:	4605                	li	a2,1
    800065de:	040005b7          	lui	a1,0x4000
    800065e2:	15ad                	addi	a1,a1,-21
    800065e4:	05b2                	slli	a1,a1,0xc
    800065e6:	05093503          	ld	a0,80(s2)
    800065ea:	ffffb097          	auipc	ra,0xffffb
    800065ee:	c66080e7          	jalr	-922(ra) # 80001250 <uvmunmap>
    release(&ringbuf_lk.ringbuf_lock);
    800065f2:	00020517          	auipc	a0,0x20
    800065f6:	a0e50513          	addi	a0,a0,-1522 # 80026000 <ringbuf_lk>
    800065fa:	ffffa097          	auipc	ra,0xffffa
    800065fe:	68a080e7          	jalr	1674(ra) # 80000c84 <release>
    80006602:	a851                	j	80006696 <create_the_buffer+0x302>
      printf("unmapped\n");
    80006604:	00002517          	auipc	a0,0x2
    80006608:	29450513          	addi	a0,a0,660 # 80008898 <syscalls+0x468>
    8000660c:	ffffa097          	auipc	ra,0xffffa
    80006610:	f76080e7          	jalr	-138(ra) # 80000582 <printf>
    80006614:	b7d9                	j	800065da <create_the_buffer+0x246>
    for(j=0;j<16;j++){
    80006616:	04a1                	addi	s1,s1,8
    80006618:	00998963          	beq	s3,s1,8000662a <create_the_buffer+0x296>
      if(ringbufs[i].buf[j])
    8000661c:	6c88                	ld	a0,24(s1)
    8000661e:	dd65                	beqz	a0,80006616 <create_the_buffer+0x282>
        kfree((char*)ringbufs[i].buf[j]);
    80006620:	ffffa097          	auipc	ra,0xffffa
    80006624:	3c4080e7          	jalr	964(ra) # 800009e4 <kfree>
    80006628:	b7fd                	j	80006616 <create_the_buffer+0x282>
    }
    if(ringbufs[i].book)
    8000662a:	002a1793          	slli	a5,s4,0x2
    8000662e:	97d2                	add	a5,a5,s4
    80006630:	0796                	slli	a5,a5,0x5
    80006632:	00020717          	auipc	a4,0x20
    80006636:	9ce70713          	addi	a4,a4,-1586 # 80026000 <ringbuf_lk>
    8000663a:	97ba                	add	a5,a5,a4
    8000663c:	7bc8                	ld	a0,176(a5)
    8000663e:	c509                	beqz	a0,80006648 <create_the_buffer+0x2b4>
      kfree(ringbufs[i].book);
    80006640:	ffffa097          	auipc	ra,0xffffa
    80006644:	3a4080e7          	jalr	932(ra) # 800009e4 <kfree>
    if(ringbufs[i].refcount)
    80006648:	002a1793          	slli	a5,s4,0x2
    8000664c:	97d2                	add	a5,a5,s4
    8000664e:	0796                	slli	a5,a5,0x5
    80006650:	00020717          	auipc	a4,0x20
    80006654:	9b070713          	addi	a4,a4,-1616 # 80026000 <ringbuf_lk>
    80006658:	97ba                	add	a5,a5,a4
    8000665a:	4f9c                	lw	a5,24(a5)
    8000665c:	cf89                	beqz	a5,80006676 <create_the_buffer+0x2e2>
      ringbufs[i].refcount--;
    8000665e:	002a1713          	slli	a4,s4,0x2
    80006662:	9a3a                	add	s4,s4,a4
    80006664:	0a16                	slli	s4,s4,0x5
    80006666:	00020717          	auipc	a4,0x20
    8000666a:	99a70713          	addi	a4,a4,-1638 # 80026000 <ringbuf_lk>
    8000666e:	9a3a                	add	s4,s4,a4
    80006670:	37fd                	addiw	a5,a5,-1
    80006672:	00fa2c23          	sw	a5,24(s4)

    printf("\nBuffer closed\n\n");
    80006676:	00002517          	auipc	a0,0x2
    8000667a:	29250513          	addi	a0,a0,658 # 80008908 <syscalls+0x4d8>
    8000667e:	ffffa097          	auipc	ra,0xffffa
    80006682:	f04080e7          	jalr	-252(ra) # 80000582 <printf>

    //   //release lock 
     release(&ringbuf_lk.ringbuf_lock);
    80006686:	00020517          	auipc	a0,0x20
    8000668a:	97a50513          	addi	a0,a0,-1670 # 80026000 <ringbuf_lk>
    8000668e:	ffffa097          	auipc	ra,0xffffa
    80006692:	5f6080e7          	jalr	1526(ra) # 80000c84 <release>
  }

  return 0;
}
    80006696:	4501                	li	a0,0
    80006698:	60e6                	ld	ra,88(sp)
    8000669a:	6446                	ld	s0,80(sp)
    8000669c:	64a6                	ld	s1,72(sp)
    8000669e:	6906                	ld	s2,64(sp)
    800066a0:	79e2                	ld	s3,56(sp)
    800066a2:	7a42                	ld	s4,48(sp)
    800066a4:	7aa2                	ld	s5,40(sp)
    800066a6:	7b02                	ld	s6,32(sp)
    800066a8:	6be2                	ld	s7,24(sp)
    800066aa:	6c42                	ld	s8,16(sp)
    800066ac:	6ca2                	ld	s9,8(sp)
    800066ae:	6125                	addi	sp,sp,96
    800066b0:	8082                	ret
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
