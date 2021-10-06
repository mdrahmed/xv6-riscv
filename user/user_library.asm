
user/_user_library:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <ab>:
#include "user/user.h"
#include "kernel/stat.h"

#define PIPESIZE 1024

int ab(int a){
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  return a*10;
   6:	0025179b          	slliw	a5,a0,0x2
   a:	9d3d                	addw	a0,a0,a5
}
   c:	0015151b          	slliw	a0,a0,0x1
  10:	6422                	ld	s0,8(sp)
  12:	0141                	addi	sp,sp,16
  14:	8082                	ret

0000000000000016 <strcpy>:
#include "user/user.h"


char*
strcpy(char *s, const char *t)
{
  16:	1141                	addi	sp,sp,-16
  18:	e422                	sd	s0,8(sp)
  1a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  1c:	87aa                	mv	a5,a0
  1e:	0585                	addi	a1,a1,1
  20:	0785                	addi	a5,a5,1
  22:	fff5c703          	lbu	a4,-1(a1)
  26:	fee78fa3          	sb	a4,-1(a5)
  2a:	fb75                	bnez	a4,1e <strcpy+0x8>
    ;
  return os;
}
  2c:	6422                	ld	s0,8(sp)
  2e:	0141                	addi	sp,sp,16
  30:	8082                	ret

0000000000000032 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  32:	1141                	addi	sp,sp,-16
  34:	e422                	sd	s0,8(sp)
  36:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  38:	00054783          	lbu	a5,0(a0)
  3c:	cb91                	beqz	a5,50 <strcmp+0x1e>
  3e:	0005c703          	lbu	a4,0(a1)
  42:	00f71763          	bne	a4,a5,50 <strcmp+0x1e>
    p++, q++;
  46:	0505                	addi	a0,a0,1
  48:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  4a:	00054783          	lbu	a5,0(a0)
  4e:	fbe5                	bnez	a5,3e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  50:	0005c503          	lbu	a0,0(a1)
}
  54:	40a7853b          	subw	a0,a5,a0
  58:	6422                	ld	s0,8(sp)
  5a:	0141                	addi	sp,sp,16
  5c:	8082                	ret

000000000000005e <strlen>:

uint
strlen(const char *s)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  64:	00054783          	lbu	a5,0(a0)
  68:	cf91                	beqz	a5,84 <strlen+0x26>
  6a:	0505                	addi	a0,a0,1
  6c:	87aa                	mv	a5,a0
  6e:	4685                	li	a3,1
  70:	9e89                	subw	a3,a3,a0
  72:	00f6853b          	addw	a0,a3,a5
  76:	0785                	addi	a5,a5,1
  78:	fff7c703          	lbu	a4,-1(a5)
  7c:	fb7d                	bnez	a4,72 <strlen+0x14>
    ;
  return n;
}
  7e:	6422                	ld	s0,8(sp)
  80:	0141                	addi	sp,sp,16
  82:	8082                	ret
  for(n = 0; s[n]; n++)
  84:	4501                	li	a0,0
  86:	bfe5                	j	7e <strlen+0x20>

0000000000000088 <memset>:

void*
memset(void *dst, int c, uint n)
{
  88:	1141                	addi	sp,sp,-16
  8a:	e422                	sd	s0,8(sp)
  8c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  8e:	ca19                	beqz	a2,a4 <memset+0x1c>
  90:	87aa                	mv	a5,a0
  92:	1602                	slli	a2,a2,0x20
  94:	9201                	srli	a2,a2,0x20
  96:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  9a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  9e:	0785                	addi	a5,a5,1
  a0:	fee79de3          	bne	a5,a4,9a <memset+0x12>
  }
  return dst;
}
  a4:	6422                	ld	s0,8(sp)
  a6:	0141                	addi	sp,sp,16
  a8:	8082                	ret

00000000000000aa <strchr>:

char*
strchr(const char *s, char c)
{
  aa:	1141                	addi	sp,sp,-16
  ac:	e422                	sd	s0,8(sp)
  ae:	0800                	addi	s0,sp,16
  for(; *s; s++)
  b0:	00054783          	lbu	a5,0(a0)
  b4:	cb99                	beqz	a5,ca <strchr+0x20>
    if(*s == c)
  b6:	00f58763          	beq	a1,a5,c4 <strchr+0x1a>
  for(; *s; s++)
  ba:	0505                	addi	a0,a0,1
  bc:	00054783          	lbu	a5,0(a0)
  c0:	fbfd                	bnez	a5,b6 <strchr+0xc>
      return (char*)s;
  return 0;
  c2:	4501                	li	a0,0
}
  c4:	6422                	ld	s0,8(sp)
  c6:	0141                	addi	sp,sp,16
  c8:	8082                	ret
  return 0;
  ca:	4501                	li	a0,0
  cc:	bfe5                	j	c4 <strchr+0x1a>

00000000000000ce <gets>:

char*
gets(char *buf, int max)
{
  ce:	711d                	addi	sp,sp,-96
  d0:	ec86                	sd	ra,88(sp)
  d2:	e8a2                	sd	s0,80(sp)
  d4:	e4a6                	sd	s1,72(sp)
  d6:	e0ca                	sd	s2,64(sp)
  d8:	fc4e                	sd	s3,56(sp)
  da:	f852                	sd	s4,48(sp)
  dc:	f456                	sd	s5,40(sp)
  de:	f05a                	sd	s6,32(sp)
  e0:	ec5e                	sd	s7,24(sp)
  e2:	1080                	addi	s0,sp,96
  e4:	8baa                	mv	s7,a0
  e6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  e8:	892a                	mv	s2,a0
  ea:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
  ec:	4aa9                	li	s5,10
  ee:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
  f0:	89a6                	mv	s3,s1
  f2:	2485                	addiw	s1,s1,1
  f4:	0344d863          	bge	s1,s4,124 <gets+0x56>
    cc = read(0, &c, 1);
  f8:	4605                	li	a2,1
  fa:	faf40593          	addi	a1,s0,-81
  fe:	4501                	li	a0,0
 100:	00000097          	auipc	ra,0x0
 104:	19c080e7          	jalr	412(ra) # 29c <read>
    if(cc < 1)
 108:	00a05e63          	blez	a0,124 <gets+0x56>
    buf[i++] = c;
 10c:	faf44783          	lbu	a5,-81(s0)
 110:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 114:	01578763          	beq	a5,s5,122 <gets+0x54>
 118:	0905                	addi	s2,s2,1
 11a:	fd679be3          	bne	a5,s6,f0 <gets+0x22>
  for(i=0; i+1 < max; ){
 11e:	89a6                	mv	s3,s1
 120:	a011                	j	124 <gets+0x56>
 122:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 124:	99de                	add	s3,s3,s7
 126:	00098023          	sb	zero,0(s3)
  return buf;
}
 12a:	855e                	mv	a0,s7
 12c:	60e6                	ld	ra,88(sp)
 12e:	6446                	ld	s0,80(sp)
 130:	64a6                	ld	s1,72(sp)
 132:	6906                	ld	s2,64(sp)
 134:	79e2                	ld	s3,56(sp)
 136:	7a42                	ld	s4,48(sp)
 138:	7aa2                	ld	s5,40(sp)
 13a:	7b02                	ld	s6,32(sp)
 13c:	6be2                	ld	s7,24(sp)
 13e:	6125                	addi	sp,sp,96
 140:	8082                	ret

0000000000000142 <stat>:

int
stat(const char *n, struct stat *st)
{
 142:	1101                	addi	sp,sp,-32
 144:	ec06                	sd	ra,24(sp)
 146:	e822                	sd	s0,16(sp)
 148:	e426                	sd	s1,8(sp)
 14a:	e04a                	sd	s2,0(sp)
 14c:	1000                	addi	s0,sp,32
 14e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 150:	4581                	li	a1,0
 152:	00000097          	auipc	ra,0x0
 156:	172080e7          	jalr	370(ra) # 2c4 <open>
  if(fd < 0)
 15a:	02054563          	bltz	a0,184 <stat+0x42>
 15e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 160:	85ca                	mv	a1,s2
 162:	00000097          	auipc	ra,0x0
 166:	17a080e7          	jalr	378(ra) # 2dc <fstat>
 16a:	892a                	mv	s2,a0
  close(fd);
 16c:	8526                	mv	a0,s1
 16e:	00000097          	auipc	ra,0x0
 172:	13e080e7          	jalr	318(ra) # 2ac <close>
  return r;
}
 176:	854a                	mv	a0,s2
 178:	60e2                	ld	ra,24(sp)
 17a:	6442                	ld	s0,16(sp)
 17c:	64a2                	ld	s1,8(sp)
 17e:	6902                	ld	s2,0(sp)
 180:	6105                	addi	sp,sp,32
 182:	8082                	ret
    return -1;
 184:	597d                	li	s2,-1
 186:	bfc5                	j	176 <stat+0x34>

0000000000000188 <atoi>:

int
atoi(const char *s)
{
 188:	1141                	addi	sp,sp,-16
 18a:	e422                	sd	s0,8(sp)
 18c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 18e:	00054603          	lbu	a2,0(a0)
 192:	fd06079b          	addiw	a5,a2,-48
 196:	0ff7f793          	zext.b	a5,a5
 19a:	4725                	li	a4,9
 19c:	02f76963          	bltu	a4,a5,1ce <atoi+0x46>
 1a0:	86aa                	mv	a3,a0
  n = 0;
 1a2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 1a4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 1a6:	0685                	addi	a3,a3,1
 1a8:	0025179b          	slliw	a5,a0,0x2
 1ac:	9fa9                	addw	a5,a5,a0
 1ae:	0017979b          	slliw	a5,a5,0x1
 1b2:	9fb1                	addw	a5,a5,a2
 1b4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1b8:	0006c603          	lbu	a2,0(a3)
 1bc:	fd06071b          	addiw	a4,a2,-48
 1c0:	0ff77713          	zext.b	a4,a4
 1c4:	fee5f1e3          	bgeu	a1,a4,1a6 <atoi+0x1e>
  return n;
}
 1c8:	6422                	ld	s0,8(sp)
 1ca:	0141                	addi	sp,sp,16
 1cc:	8082                	ret
  n = 0;
 1ce:	4501                	li	a0,0
 1d0:	bfe5                	j	1c8 <atoi+0x40>

00000000000001d2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1d2:	1141                	addi	sp,sp,-16
 1d4:	e422                	sd	s0,8(sp)
 1d6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1d8:	02b57463          	bgeu	a0,a1,200 <memmove+0x2e>
    while(n-- > 0)
 1dc:	00c05f63          	blez	a2,1fa <memmove+0x28>
 1e0:	1602                	slli	a2,a2,0x20
 1e2:	9201                	srli	a2,a2,0x20
 1e4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1e8:	872a                	mv	a4,a0
      *dst++ = *src++;
 1ea:	0585                	addi	a1,a1,1
 1ec:	0705                	addi	a4,a4,1
 1ee:	fff5c683          	lbu	a3,-1(a1)
 1f2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1f6:	fee79ae3          	bne	a5,a4,1ea <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 1fa:	6422                	ld	s0,8(sp)
 1fc:	0141                	addi	sp,sp,16
 1fe:	8082                	ret
    dst += n;
 200:	00c50733          	add	a4,a0,a2
    src += n;
 204:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 206:	fec05ae3          	blez	a2,1fa <memmove+0x28>
 20a:	fff6079b          	addiw	a5,a2,-1
 20e:	1782                	slli	a5,a5,0x20
 210:	9381                	srli	a5,a5,0x20
 212:	fff7c793          	not	a5,a5
 216:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 218:	15fd                	addi	a1,a1,-1
 21a:	177d                	addi	a4,a4,-1
 21c:	0005c683          	lbu	a3,0(a1)
 220:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 224:	fee79ae3          	bne	a5,a4,218 <memmove+0x46>
 228:	bfc9                	j	1fa <memmove+0x28>

000000000000022a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 22a:	1141                	addi	sp,sp,-16
 22c:	e422                	sd	s0,8(sp)
 22e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 230:	ca05                	beqz	a2,260 <memcmp+0x36>
 232:	fff6069b          	addiw	a3,a2,-1
 236:	1682                	slli	a3,a3,0x20
 238:	9281                	srli	a3,a3,0x20
 23a:	0685                	addi	a3,a3,1
 23c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 23e:	00054783          	lbu	a5,0(a0)
 242:	0005c703          	lbu	a4,0(a1)
 246:	00e79863          	bne	a5,a4,256 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 24a:	0505                	addi	a0,a0,1
    p2++;
 24c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 24e:	fed518e3          	bne	a0,a3,23e <memcmp+0x14>
  }
  return 0;
 252:	4501                	li	a0,0
 254:	a019                	j	25a <memcmp+0x30>
      return *p1 - *p2;
 256:	40e7853b          	subw	a0,a5,a4
}
 25a:	6422                	ld	s0,8(sp)
 25c:	0141                	addi	sp,sp,16
 25e:	8082                	ret
  return 0;
 260:	4501                	li	a0,0
 262:	bfe5                	j	25a <memcmp+0x30>

0000000000000264 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 264:	1141                	addi	sp,sp,-16
 266:	e406                	sd	ra,8(sp)
 268:	e022                	sd	s0,0(sp)
 26a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 26c:	00000097          	auipc	ra,0x0
 270:	f66080e7          	jalr	-154(ra) # 1d2 <memmove>
}
 274:	60a2                	ld	ra,8(sp)
 276:	6402                	ld	s0,0(sp)
 278:	0141                	addi	sp,sp,16
 27a:	8082                	ret

000000000000027c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 27c:	4885                	li	a7,1
 ecall
 27e:	00000073          	ecall
 ret
 282:	8082                	ret

0000000000000284 <exit>:
.global exit
exit:
 li a7, SYS_exit
 284:	4889                	li	a7,2
 ecall
 286:	00000073          	ecall
 ret
 28a:	8082                	ret

000000000000028c <wait>:
.global wait
wait:
 li a7, SYS_wait
 28c:	488d                	li	a7,3
 ecall
 28e:	00000073          	ecall
 ret
 292:	8082                	ret

0000000000000294 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 294:	4891                	li	a7,4
 ecall
 296:	00000073          	ecall
 ret
 29a:	8082                	ret

000000000000029c <read>:
.global read
read:
 li a7, SYS_read
 29c:	4895                	li	a7,5
 ecall
 29e:	00000073          	ecall
 ret
 2a2:	8082                	ret

00000000000002a4 <write>:
.global write
write:
 li a7, SYS_write
 2a4:	48c1                	li	a7,16
 ecall
 2a6:	00000073          	ecall
 ret
 2aa:	8082                	ret

00000000000002ac <close>:
.global close
close:
 li a7, SYS_close
 2ac:	48d5                	li	a7,21
 ecall
 2ae:	00000073          	ecall
 ret
 2b2:	8082                	ret

00000000000002b4 <kill>:
.global kill
kill:
 li a7, SYS_kill
 2b4:	4899                	li	a7,6
 ecall
 2b6:	00000073          	ecall
 ret
 2ba:	8082                	ret

00000000000002bc <exec>:
.global exec
exec:
 li a7, SYS_exec
 2bc:	489d                	li	a7,7
 ecall
 2be:	00000073          	ecall
 ret
 2c2:	8082                	ret

00000000000002c4 <open>:
.global open
open:
 li a7, SYS_open
 2c4:	48bd                	li	a7,15
 ecall
 2c6:	00000073          	ecall
 ret
 2ca:	8082                	ret

00000000000002cc <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 2cc:	48c5                	li	a7,17
 ecall
 2ce:	00000073          	ecall
 ret
 2d2:	8082                	ret

00000000000002d4 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 2d4:	48c9                	li	a7,18
 ecall
 2d6:	00000073          	ecall
 ret
 2da:	8082                	ret

00000000000002dc <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 2dc:	48a1                	li	a7,8
 ecall
 2de:	00000073          	ecall
 ret
 2e2:	8082                	ret

00000000000002e4 <link>:
.global link
link:
 li a7, SYS_link
 2e4:	48cd                	li	a7,19
 ecall
 2e6:	00000073          	ecall
 ret
 2ea:	8082                	ret

00000000000002ec <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 2ec:	48d1                	li	a7,20
 ecall
 2ee:	00000073          	ecall
 ret
 2f2:	8082                	ret

00000000000002f4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 2f4:	48a5                	li	a7,9
 ecall
 2f6:	00000073          	ecall
 ret
 2fa:	8082                	ret

00000000000002fc <dup>:
.global dup
dup:
 li a7, SYS_dup
 2fc:	48a9                	li	a7,10
 ecall
 2fe:	00000073          	ecall
 ret
 302:	8082                	ret

0000000000000304 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 304:	48ad                	li	a7,11
 ecall
 306:	00000073          	ecall
 ret
 30a:	8082                	ret

000000000000030c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 30c:	48b1                	li	a7,12
 ecall
 30e:	00000073          	ecall
 ret
 312:	8082                	ret

0000000000000314 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 314:	48b5                	li	a7,13
 ecall
 316:	00000073          	ecall
 ret
 31a:	8082                	ret

000000000000031c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 31c:	48b9                	li	a7,14
 ecall
 31e:	00000073          	ecall
 ret
 322:	8082                	ret

0000000000000324 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 324:	48d9                	li	a7,22
 ecall
 326:	00000073          	ecall
 ret
 32a:	8082                	ret

000000000000032c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 32c:	1101                	addi	sp,sp,-32
 32e:	ec06                	sd	ra,24(sp)
 330:	e822                	sd	s0,16(sp)
 332:	1000                	addi	s0,sp,32
 334:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 338:	4605                	li	a2,1
 33a:	fef40593          	addi	a1,s0,-17
 33e:	00000097          	auipc	ra,0x0
 342:	f66080e7          	jalr	-154(ra) # 2a4 <write>
}
 346:	60e2                	ld	ra,24(sp)
 348:	6442                	ld	s0,16(sp)
 34a:	6105                	addi	sp,sp,32
 34c:	8082                	ret

000000000000034e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 34e:	7139                	addi	sp,sp,-64
 350:	fc06                	sd	ra,56(sp)
 352:	f822                	sd	s0,48(sp)
 354:	f426                	sd	s1,40(sp)
 356:	f04a                	sd	s2,32(sp)
 358:	ec4e                	sd	s3,24(sp)
 35a:	0080                	addi	s0,sp,64
 35c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 35e:	c299                	beqz	a3,364 <printint+0x16>
 360:	0805c863          	bltz	a1,3f0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 364:	2581                	sext.w	a1,a1
  neg = 0;
 366:	4881                	li	a7,0
 368:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 36c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 36e:	2601                	sext.w	a2,a2
 370:	00000517          	auipc	a0,0x0
 374:	44050513          	addi	a0,a0,1088 # 7b0 <digits>
 378:	883a                	mv	a6,a4
 37a:	2705                	addiw	a4,a4,1
 37c:	02c5f7bb          	remuw	a5,a1,a2
 380:	1782                	slli	a5,a5,0x20
 382:	9381                	srli	a5,a5,0x20
 384:	97aa                	add	a5,a5,a0
 386:	0007c783          	lbu	a5,0(a5)
 38a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 38e:	0005879b          	sext.w	a5,a1
 392:	02c5d5bb          	divuw	a1,a1,a2
 396:	0685                	addi	a3,a3,1
 398:	fec7f0e3          	bgeu	a5,a2,378 <printint+0x2a>
  if(neg)
 39c:	00088b63          	beqz	a7,3b2 <printint+0x64>
    buf[i++] = '-';
 3a0:	fd040793          	addi	a5,s0,-48
 3a4:	973e                	add	a4,a4,a5
 3a6:	02d00793          	li	a5,45
 3aa:	fef70823          	sb	a5,-16(a4)
 3ae:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 3b2:	02e05863          	blez	a4,3e2 <printint+0x94>
 3b6:	fc040793          	addi	a5,s0,-64
 3ba:	00e78933          	add	s2,a5,a4
 3be:	fff78993          	addi	s3,a5,-1
 3c2:	99ba                	add	s3,s3,a4
 3c4:	377d                	addiw	a4,a4,-1
 3c6:	1702                	slli	a4,a4,0x20
 3c8:	9301                	srli	a4,a4,0x20
 3ca:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 3ce:	fff94583          	lbu	a1,-1(s2)
 3d2:	8526                	mv	a0,s1
 3d4:	00000097          	auipc	ra,0x0
 3d8:	f58080e7          	jalr	-168(ra) # 32c <putc>
  while(--i >= 0)
 3dc:	197d                	addi	s2,s2,-1
 3de:	ff3918e3          	bne	s2,s3,3ce <printint+0x80>
}
 3e2:	70e2                	ld	ra,56(sp)
 3e4:	7442                	ld	s0,48(sp)
 3e6:	74a2                	ld	s1,40(sp)
 3e8:	7902                	ld	s2,32(sp)
 3ea:	69e2                	ld	s3,24(sp)
 3ec:	6121                	addi	sp,sp,64
 3ee:	8082                	ret
    x = -xx;
 3f0:	40b005bb          	negw	a1,a1
    neg = 1;
 3f4:	4885                	li	a7,1
    x = -xx;
 3f6:	bf8d                	j	368 <printint+0x1a>

00000000000003f8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 3f8:	7119                	addi	sp,sp,-128
 3fa:	fc86                	sd	ra,120(sp)
 3fc:	f8a2                	sd	s0,112(sp)
 3fe:	f4a6                	sd	s1,104(sp)
 400:	f0ca                	sd	s2,96(sp)
 402:	ecce                	sd	s3,88(sp)
 404:	e8d2                	sd	s4,80(sp)
 406:	e4d6                	sd	s5,72(sp)
 408:	e0da                	sd	s6,64(sp)
 40a:	fc5e                	sd	s7,56(sp)
 40c:	f862                	sd	s8,48(sp)
 40e:	f466                	sd	s9,40(sp)
 410:	f06a                	sd	s10,32(sp)
 412:	ec6e                	sd	s11,24(sp)
 414:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 416:	0005c903          	lbu	s2,0(a1)
 41a:	18090f63          	beqz	s2,5b8 <vprintf+0x1c0>
 41e:	8aaa                	mv	s5,a0
 420:	8b32                	mv	s6,a2
 422:	00158493          	addi	s1,a1,1
  state = 0;
 426:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 428:	02500a13          	li	s4,37
      if(c == 'd'){
 42c:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 430:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 434:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 438:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 43c:	00000b97          	auipc	s7,0x0
 440:	374b8b93          	addi	s7,s7,884 # 7b0 <digits>
 444:	a839                	j	462 <vprintf+0x6a>
        putc(fd, c);
 446:	85ca                	mv	a1,s2
 448:	8556                	mv	a0,s5
 44a:	00000097          	auipc	ra,0x0
 44e:	ee2080e7          	jalr	-286(ra) # 32c <putc>
 452:	a019                	j	458 <vprintf+0x60>
    } else if(state == '%'){
 454:	01498f63          	beq	s3,s4,472 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 458:	0485                	addi	s1,s1,1
 45a:	fff4c903          	lbu	s2,-1(s1)
 45e:	14090d63          	beqz	s2,5b8 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 462:	0009079b          	sext.w	a5,s2
    if(state == 0){
 466:	fe0997e3          	bnez	s3,454 <vprintf+0x5c>
      if(c == '%'){
 46a:	fd479ee3          	bne	a5,s4,446 <vprintf+0x4e>
        state = '%';
 46e:	89be                	mv	s3,a5
 470:	b7e5                	j	458 <vprintf+0x60>
      if(c == 'd'){
 472:	05878063          	beq	a5,s8,4b2 <vprintf+0xba>
      } else if(c == 'l') {
 476:	05978c63          	beq	a5,s9,4ce <vprintf+0xd6>
      } else if(c == 'x') {
 47a:	07a78863          	beq	a5,s10,4ea <vprintf+0xf2>
      } else if(c == 'p') {
 47e:	09b78463          	beq	a5,s11,506 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 482:	07300713          	li	a4,115
 486:	0ce78663          	beq	a5,a4,552 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48a:	06300713          	li	a4,99
 48e:	0ee78e63          	beq	a5,a4,58a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 492:	11478863          	beq	a5,s4,5a2 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 496:	85d2                	mv	a1,s4
 498:	8556                	mv	a0,s5
 49a:	00000097          	auipc	ra,0x0
 49e:	e92080e7          	jalr	-366(ra) # 32c <putc>
        putc(fd, c);
 4a2:	85ca                	mv	a1,s2
 4a4:	8556                	mv	a0,s5
 4a6:	00000097          	auipc	ra,0x0
 4aa:	e86080e7          	jalr	-378(ra) # 32c <putc>
      }
      state = 0;
 4ae:	4981                	li	s3,0
 4b0:	b765                	j	458 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 4b2:	008b0913          	addi	s2,s6,8
 4b6:	4685                	li	a3,1
 4b8:	4629                	li	a2,10
 4ba:	000b2583          	lw	a1,0(s6)
 4be:	8556                	mv	a0,s5
 4c0:	00000097          	auipc	ra,0x0
 4c4:	e8e080e7          	jalr	-370(ra) # 34e <printint>
 4c8:	8b4a                	mv	s6,s2
      state = 0;
 4ca:	4981                	li	s3,0
 4cc:	b771                	j	458 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 4ce:	008b0913          	addi	s2,s6,8
 4d2:	4681                	li	a3,0
 4d4:	4629                	li	a2,10
 4d6:	000b2583          	lw	a1,0(s6)
 4da:	8556                	mv	a0,s5
 4dc:	00000097          	auipc	ra,0x0
 4e0:	e72080e7          	jalr	-398(ra) # 34e <printint>
 4e4:	8b4a                	mv	s6,s2
      state = 0;
 4e6:	4981                	li	s3,0
 4e8:	bf85                	j	458 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 4ea:	008b0913          	addi	s2,s6,8
 4ee:	4681                	li	a3,0
 4f0:	4641                	li	a2,16
 4f2:	000b2583          	lw	a1,0(s6)
 4f6:	8556                	mv	a0,s5
 4f8:	00000097          	auipc	ra,0x0
 4fc:	e56080e7          	jalr	-426(ra) # 34e <printint>
 500:	8b4a                	mv	s6,s2
      state = 0;
 502:	4981                	li	s3,0
 504:	bf91                	j	458 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 506:	008b0793          	addi	a5,s6,8
 50a:	f8f43423          	sd	a5,-120(s0)
 50e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 512:	03000593          	li	a1,48
 516:	8556                	mv	a0,s5
 518:	00000097          	auipc	ra,0x0
 51c:	e14080e7          	jalr	-492(ra) # 32c <putc>
  putc(fd, 'x');
 520:	85ea                	mv	a1,s10
 522:	8556                	mv	a0,s5
 524:	00000097          	auipc	ra,0x0
 528:	e08080e7          	jalr	-504(ra) # 32c <putc>
 52c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 52e:	03c9d793          	srli	a5,s3,0x3c
 532:	97de                	add	a5,a5,s7
 534:	0007c583          	lbu	a1,0(a5)
 538:	8556                	mv	a0,s5
 53a:	00000097          	auipc	ra,0x0
 53e:	df2080e7          	jalr	-526(ra) # 32c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 542:	0992                	slli	s3,s3,0x4
 544:	397d                	addiw	s2,s2,-1
 546:	fe0914e3          	bnez	s2,52e <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 54a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 54e:	4981                	li	s3,0
 550:	b721                	j	458 <vprintf+0x60>
        s = va_arg(ap, char*);
 552:	008b0993          	addi	s3,s6,8
 556:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 55a:	02090163          	beqz	s2,57c <vprintf+0x184>
        while(*s != 0){
 55e:	00094583          	lbu	a1,0(s2)
 562:	c9a1                	beqz	a1,5b2 <vprintf+0x1ba>
          putc(fd, *s);
 564:	8556                	mv	a0,s5
 566:	00000097          	auipc	ra,0x0
 56a:	dc6080e7          	jalr	-570(ra) # 32c <putc>
          s++;
 56e:	0905                	addi	s2,s2,1
        while(*s != 0){
 570:	00094583          	lbu	a1,0(s2)
 574:	f9e5                	bnez	a1,564 <vprintf+0x16c>
        s = va_arg(ap, char*);
 576:	8b4e                	mv	s6,s3
      state = 0;
 578:	4981                	li	s3,0
 57a:	bdf9                	j	458 <vprintf+0x60>
          s = "(null)";
 57c:	00000917          	auipc	s2,0x0
 580:	22c90913          	addi	s2,s2,556 # 7a8 <malloc+0xe6>
        while(*s != 0){
 584:	02800593          	li	a1,40
 588:	bff1                	j	564 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 58a:	008b0913          	addi	s2,s6,8
 58e:	000b4583          	lbu	a1,0(s6)
 592:	8556                	mv	a0,s5
 594:	00000097          	auipc	ra,0x0
 598:	d98080e7          	jalr	-616(ra) # 32c <putc>
 59c:	8b4a                	mv	s6,s2
      state = 0;
 59e:	4981                	li	s3,0
 5a0:	bd65                	j	458 <vprintf+0x60>
        putc(fd, c);
 5a2:	85d2                	mv	a1,s4
 5a4:	8556                	mv	a0,s5
 5a6:	00000097          	auipc	ra,0x0
 5aa:	d86080e7          	jalr	-634(ra) # 32c <putc>
      state = 0;
 5ae:	4981                	li	s3,0
 5b0:	b565                	j	458 <vprintf+0x60>
        s = va_arg(ap, char*);
 5b2:	8b4e                	mv	s6,s3
      state = 0;
 5b4:	4981                	li	s3,0
 5b6:	b54d                	j	458 <vprintf+0x60>
    }
  }
}
 5b8:	70e6                	ld	ra,120(sp)
 5ba:	7446                	ld	s0,112(sp)
 5bc:	74a6                	ld	s1,104(sp)
 5be:	7906                	ld	s2,96(sp)
 5c0:	69e6                	ld	s3,88(sp)
 5c2:	6a46                	ld	s4,80(sp)
 5c4:	6aa6                	ld	s5,72(sp)
 5c6:	6b06                	ld	s6,64(sp)
 5c8:	7be2                	ld	s7,56(sp)
 5ca:	7c42                	ld	s8,48(sp)
 5cc:	7ca2                	ld	s9,40(sp)
 5ce:	7d02                	ld	s10,32(sp)
 5d0:	6de2                	ld	s11,24(sp)
 5d2:	6109                	addi	sp,sp,128
 5d4:	8082                	ret

00000000000005d6 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 5d6:	715d                	addi	sp,sp,-80
 5d8:	ec06                	sd	ra,24(sp)
 5da:	e822                	sd	s0,16(sp)
 5dc:	1000                	addi	s0,sp,32
 5de:	e010                	sd	a2,0(s0)
 5e0:	e414                	sd	a3,8(s0)
 5e2:	e818                	sd	a4,16(s0)
 5e4:	ec1c                	sd	a5,24(s0)
 5e6:	03043023          	sd	a6,32(s0)
 5ea:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 5ee:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 5f2:	8622                	mv	a2,s0
 5f4:	00000097          	auipc	ra,0x0
 5f8:	e04080e7          	jalr	-508(ra) # 3f8 <vprintf>
}
 5fc:	60e2                	ld	ra,24(sp)
 5fe:	6442                	ld	s0,16(sp)
 600:	6161                	addi	sp,sp,80
 602:	8082                	ret

0000000000000604 <printf>:

void
printf(const char *fmt, ...)
{
 604:	711d                	addi	sp,sp,-96
 606:	ec06                	sd	ra,24(sp)
 608:	e822                	sd	s0,16(sp)
 60a:	1000                	addi	s0,sp,32
 60c:	e40c                	sd	a1,8(s0)
 60e:	e810                	sd	a2,16(s0)
 610:	ec14                	sd	a3,24(s0)
 612:	f018                	sd	a4,32(s0)
 614:	f41c                	sd	a5,40(s0)
 616:	03043823          	sd	a6,48(s0)
 61a:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 61e:	00840613          	addi	a2,s0,8
 622:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 626:	85aa                	mv	a1,a0
 628:	4505                	li	a0,1
 62a:	00000097          	auipc	ra,0x0
 62e:	dce080e7          	jalr	-562(ra) # 3f8 <vprintf>
}
 632:	60e2                	ld	ra,24(sp)
 634:	6442                	ld	s0,16(sp)
 636:	6125                	addi	sp,sp,96
 638:	8082                	ret

000000000000063a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 63a:	1141                	addi	sp,sp,-16
 63c:	e422                	sd	s0,8(sp)
 63e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 640:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 644:	00000797          	auipc	a5,0x0
 648:	1847b783          	ld	a5,388(a5) # 7c8 <freep>
 64c:	a805                	j	67c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 64e:	4618                	lw	a4,8(a2)
 650:	9db9                	addw	a1,a1,a4
 652:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 656:	6398                	ld	a4,0(a5)
 658:	6318                	ld	a4,0(a4)
 65a:	fee53823          	sd	a4,-16(a0)
 65e:	a091                	j	6a2 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 660:	ff852703          	lw	a4,-8(a0)
 664:	9e39                	addw	a2,a2,a4
 666:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 668:	ff053703          	ld	a4,-16(a0)
 66c:	e398                	sd	a4,0(a5)
 66e:	a099                	j	6b4 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 670:	6398                	ld	a4,0(a5)
 672:	00e7e463          	bltu	a5,a4,67a <free+0x40>
 676:	00e6ea63          	bltu	a3,a4,68a <free+0x50>
{
 67a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67c:	fed7fae3          	bgeu	a5,a3,670 <free+0x36>
 680:	6398                	ld	a4,0(a5)
 682:	00e6e463          	bltu	a3,a4,68a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 686:	fee7eae3          	bltu	a5,a4,67a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 68a:	ff852583          	lw	a1,-8(a0)
 68e:	6390                	ld	a2,0(a5)
 690:	02059813          	slli	a6,a1,0x20
 694:	01c85713          	srli	a4,a6,0x1c
 698:	9736                	add	a4,a4,a3
 69a:	fae60ae3          	beq	a2,a4,64e <free+0x14>
    bp->s.ptr = p->s.ptr;
 69e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 6a2:	4790                	lw	a2,8(a5)
 6a4:	02061593          	slli	a1,a2,0x20
 6a8:	01c5d713          	srli	a4,a1,0x1c
 6ac:	973e                	add	a4,a4,a5
 6ae:	fae689e3          	beq	a3,a4,660 <free+0x26>
  } else
    p->s.ptr = bp;
 6b2:	e394                	sd	a3,0(a5)
  freep = p;
 6b4:	00000717          	auipc	a4,0x0
 6b8:	10f73a23          	sd	a5,276(a4) # 7c8 <freep>
}
 6bc:	6422                	ld	s0,8(sp)
 6be:	0141                	addi	sp,sp,16
 6c0:	8082                	ret

00000000000006c2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c2:	7139                	addi	sp,sp,-64
 6c4:	fc06                	sd	ra,56(sp)
 6c6:	f822                	sd	s0,48(sp)
 6c8:	f426                	sd	s1,40(sp)
 6ca:	f04a                	sd	s2,32(sp)
 6cc:	ec4e                	sd	s3,24(sp)
 6ce:	e852                	sd	s4,16(sp)
 6d0:	e456                	sd	s5,8(sp)
 6d2:	e05a                	sd	s6,0(sp)
 6d4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d6:	02051493          	slli	s1,a0,0x20
 6da:	9081                	srli	s1,s1,0x20
 6dc:	04bd                	addi	s1,s1,15
 6de:	8091                	srli	s1,s1,0x4
 6e0:	0014899b          	addiw	s3,s1,1
 6e4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 6e6:	00000517          	auipc	a0,0x0
 6ea:	0e253503          	ld	a0,226(a0) # 7c8 <freep>
 6ee:	c515                	beqz	a0,71a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 6f2:	4798                	lw	a4,8(a5)
 6f4:	02977f63          	bgeu	a4,s1,732 <malloc+0x70>
 6f8:	8a4e                	mv	s4,s3
 6fa:	0009871b          	sext.w	a4,s3
 6fe:	6685                	lui	a3,0x1
 700:	00d77363          	bgeu	a4,a3,706 <malloc+0x44>
 704:	6a05                	lui	s4,0x1
 706:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 70a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 70e:	00000917          	auipc	s2,0x0
 712:	0ba90913          	addi	s2,s2,186 # 7c8 <freep>
  if(p == (char*)-1)
 716:	5afd                	li	s5,-1
 718:	a895                	j	78c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 71a:	00000797          	auipc	a5,0x0
 71e:	0b678793          	addi	a5,a5,182 # 7d0 <base>
 722:	00000717          	auipc	a4,0x0
 726:	0af73323          	sd	a5,166(a4) # 7c8 <freep>
 72a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 72c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 730:	b7e1                	j	6f8 <malloc+0x36>
      if(p->s.size == nunits)
 732:	02e48c63          	beq	s1,a4,76a <malloc+0xa8>
        p->s.size -= nunits;
 736:	4137073b          	subw	a4,a4,s3
 73a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 73c:	02071693          	slli	a3,a4,0x20
 740:	01c6d713          	srli	a4,a3,0x1c
 744:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 746:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 74a:	00000717          	auipc	a4,0x0
 74e:	06a73f23          	sd	a0,126(a4) # 7c8 <freep>
      return (void*)(p + 1);
 752:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 756:	70e2                	ld	ra,56(sp)
 758:	7442                	ld	s0,48(sp)
 75a:	74a2                	ld	s1,40(sp)
 75c:	7902                	ld	s2,32(sp)
 75e:	69e2                	ld	s3,24(sp)
 760:	6a42                	ld	s4,16(sp)
 762:	6aa2                	ld	s5,8(sp)
 764:	6b02                	ld	s6,0(sp)
 766:	6121                	addi	sp,sp,64
 768:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 76a:	6398                	ld	a4,0(a5)
 76c:	e118                	sd	a4,0(a0)
 76e:	bff1                	j	74a <malloc+0x88>
  hp->s.size = nu;
 770:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 774:	0541                	addi	a0,a0,16
 776:	00000097          	auipc	ra,0x0
 77a:	ec4080e7          	jalr	-316(ra) # 63a <free>
  return freep;
 77e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 782:	d971                	beqz	a0,756 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 784:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 786:	4798                	lw	a4,8(a5)
 788:	fa9775e3          	bgeu	a4,s1,732 <malloc+0x70>
    if(p == freep)
 78c:	00093703          	ld	a4,0(s2)
 790:	853e                	mv	a0,a5
 792:	fef719e3          	bne	a4,a5,784 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 796:	8552                	mv	a0,s4
 798:	00000097          	auipc	ra,0x0
 79c:	b74080e7          	jalr	-1164(ra) # 30c <sbrk>
  if(p == (char*)-1)
 7a0:	fd5518e3          	bne	a0,s5,770 <malloc+0xae>
        return 0;
 7a4:	4501                	li	a0,0
 7a6:	bf45                	j	756 <malloc+0x94>
