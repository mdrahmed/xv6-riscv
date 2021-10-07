
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	00000097          	auipc	ra,0x0
   c:	4b2080e7          	jalr	1202(ra) # 4ba <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	4ac080e7          	jalr	1196(ra) # 4c2 <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	532080e7          	jalr	1330(ra) # 552 <sleep>
  28:	b7f5                	j	14 <main+0x14>

000000000000002a <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  2a:	1141                	addi	sp,sp,-16
  2c:	e422                	sd	s0,8(sp)
  2e:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  30:	0f50000f          	fence	iorw,ow
  34:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  38:	6422                	ld	s0,8(sp)
  3a:	0141                	addi	sp,sp,16
  3c:	8082                	ret

000000000000003e <load>:

int load(uint64 *p) {
  3e:	1141                	addi	sp,sp,-16
  40:	e422                	sd	s0,8(sp)
  42:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  44:	0ff0000f          	fence
  48:	6108                	ld	a0,0(a0)
  4a:	0ff0000f          	fence
}
  4e:	2501                	sext.w	a0,a0
  50:	6422                	ld	s0,8(sp)
  52:	0141                	addi	sp,sp,16
  54:	8082                	ret

0000000000000056 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
  56:	7179                	addi	sp,sp,-48
  58:	f406                	sd	ra,40(sp)
  5a:	f022                	sd	s0,32(sp)
  5c:	ec26                	sd	s1,24(sp)
  5e:	e84a                	sd	s2,16(sp)
  60:	e44e                	sd	s3,8(sp)
  62:	e052                	sd	s4,0(sp)
  64:	1800                	addi	s0,sp,48
  66:	8a2a                	mv	s4,a0
  68:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  6a:	4785                	li	a5,1
  6c:	00001497          	auipc	s1,0x1
  70:	9b448493          	addi	s1,s1,-1612 # a20 <rings+0x10>
  74:	00001917          	auipc	s2,0x1
  78:	a9c90913          	addi	s2,s2,-1380 # b10 <__BSS_END__>
  7c:	04f59563          	bne	a1,a5,c6 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  80:	00001497          	auipc	s1,0x1
  84:	9a04a483          	lw	s1,-1632(s1) # a20 <rings+0x10>
  88:	c099                	beqz	s1,8e <create_or_close_the_buffer_user+0x38>
  8a:	4481                	li	s1,0
  8c:	a899                	j	e2 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  8e:	00001917          	auipc	s2,0x1
  92:	98290913          	addi	s2,s2,-1662 # a10 <rings>
  96:	00093603          	ld	a2,0(s2)
  9a:	4585                	li	a1,1
  9c:	00000097          	auipc	ra,0x0
  a0:	4c6080e7          	jalr	1222(ra) # 562 <ringbuf>
        rings[i].book->write_done = 0;
  a4:	00893783          	ld	a5,8(s2)
  a8:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
  ac:	00893783          	ld	a5,8(s2)
  b0:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
  b4:	01092783          	lw	a5,16(s2)
  b8:	2785                	addiw	a5,a5,1
  ba:	00f92823          	sw	a5,16(s2)
        break;
  be:	a015                	j	e2 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
  c0:	04e1                	addi	s1,s1,24
  c2:	01248f63          	beq	s1,s2,e0 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
  c6:	409c                	lw	a5,0(s1)
  c8:	dfe5                	beqz	a5,c0 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
  ca:	ff04b603          	ld	a2,-16(s1)
  ce:	85ce                	mv	a1,s3
  d0:	8552                	mv	a0,s4
  d2:	00000097          	auipc	ra,0x0
  d6:	490080e7          	jalr	1168(ra) # 562 <ringbuf>
        rings[i].exists = 0;
  da:	0004a023          	sw	zero,0(s1)
  de:	b7cd                	j	c0 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
  e0:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
  e2:	8526                	mv	a0,s1
  e4:	70a2                	ld	ra,40(sp)
  e6:	7402                	ld	s0,32(sp)
  e8:	64e2                	ld	s1,24(sp)
  ea:	6942                	ld	s2,16(sp)
  ec:	69a2                	ld	s3,8(sp)
  ee:	6a02                	ld	s4,0(sp)
  f0:	6145                	addi	sp,sp,48
  f2:	8082                	ret

00000000000000f4 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
  f4:	1101                	addi	sp,sp,-32
  f6:	ec06                	sd	ra,24(sp)
  f8:	e822                	sd	s0,16(sp)
  fa:	e426                	sd	s1,8(sp)
  fc:	1000                	addi	s0,sp,32
  fe:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 100:	00151793          	slli	a5,a0,0x1
 104:	97aa                	add	a5,a5,a0
 106:	078e                	slli	a5,a5,0x3
 108:	00001717          	auipc	a4,0x1
 10c:	90870713          	addi	a4,a4,-1784 # a10 <rings>
 110:	97ba                	add	a5,a5,a4
 112:	639c                	ld	a5,0(a5)
 114:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 116:	421c                	lw	a5,0(a2)
 118:	e785                	bnez	a5,140 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 11a:	86ba                	mv	a3,a4
 11c:	671c                	ld	a5,8(a4)
 11e:	6398                	ld	a4,0(a5)
 120:	67c1                	lui	a5,0x10
 122:	9fb9                	addw	a5,a5,a4
 124:	00151713          	slli	a4,a0,0x1
 128:	953a                	add	a0,a0,a4
 12a:	050e                	slli	a0,a0,0x3
 12c:	9536                	add	a0,a0,a3
 12e:	6518                	ld	a4,8(a0)
 130:	6718                	ld	a4,8(a4)
 132:	9f99                	subw	a5,a5,a4
 134:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 136:	60e2                	ld	ra,24(sp)
 138:	6442                	ld	s0,16(sp)
 13a:	64a2                	ld	s1,8(sp)
 13c:	6105                	addi	sp,sp,32
 13e:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 140:	00151793          	slli	a5,a0,0x1
 144:	953e                	add	a0,a0,a5
 146:	050e                	slli	a0,a0,0x3
 148:	00001797          	auipc	a5,0x1
 14c:	8c878793          	addi	a5,a5,-1848 # a10 <rings>
 150:	953e                	add	a0,a0,a5
 152:	6508                	ld	a0,8(a0)
 154:	0521                	addi	a0,a0,8
 156:	00000097          	auipc	ra,0x0
 15a:	ee8080e7          	jalr	-280(ra) # 3e <load>
 15e:	c088                	sw	a0,0(s1)
}
 160:	bfd9                	j	136 <ringbuf_start_write+0x42>

0000000000000162 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 162:	1141                	addi	sp,sp,-16
 164:	e406                	sd	ra,8(sp)
 166:	e022                	sd	s0,0(sp)
 168:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 16a:	00151793          	slli	a5,a0,0x1
 16e:	97aa                	add	a5,a5,a0
 170:	078e                	slli	a5,a5,0x3
 172:	00001517          	auipc	a0,0x1
 176:	89e50513          	addi	a0,a0,-1890 # a10 <rings>
 17a:	97aa                	add	a5,a5,a0
 17c:	6788                	ld	a0,8(a5)
 17e:	0035959b          	slliw	a1,a1,0x3
 182:	0521                	addi	a0,a0,8
 184:	00000097          	auipc	ra,0x0
 188:	ea6080e7          	jalr	-346(ra) # 2a <store>
}
 18c:	60a2                	ld	ra,8(sp)
 18e:	6402                	ld	s0,0(sp)
 190:	0141                	addi	sp,sp,16
 192:	8082                	ret

0000000000000194 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 194:	1101                	addi	sp,sp,-32
 196:	ec06                	sd	ra,24(sp)
 198:	e822                	sd	s0,16(sp)
 19a:	e426                	sd	s1,8(sp)
 19c:	1000                	addi	s0,sp,32
 19e:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1a0:	00151793          	slli	a5,a0,0x1
 1a4:	97aa                	add	a5,a5,a0
 1a6:	078e                	slli	a5,a5,0x3
 1a8:	00001517          	auipc	a0,0x1
 1ac:	86850513          	addi	a0,a0,-1944 # a10 <rings>
 1b0:	97aa                	add	a5,a5,a0
 1b2:	6788                	ld	a0,8(a5)
 1b4:	0521                	addi	a0,a0,8
 1b6:	00000097          	auipc	ra,0x0
 1ba:	e88080e7          	jalr	-376(ra) # 3e <load>
 1be:	c088                	sw	a0,0(s1)
}
 1c0:	60e2                	ld	ra,24(sp)
 1c2:	6442                	ld	s0,16(sp)
 1c4:	64a2                	ld	s1,8(sp)
 1c6:	6105                	addi	sp,sp,32
 1c8:	8082                	ret

00000000000001ca <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 1ca:	1101                	addi	sp,sp,-32
 1cc:	ec06                	sd	ra,24(sp)
 1ce:	e822                	sd	s0,16(sp)
 1d0:	e426                	sd	s1,8(sp)
 1d2:	1000                	addi	s0,sp,32
 1d4:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 1d6:	00151793          	slli	a5,a0,0x1
 1da:	97aa                	add	a5,a5,a0
 1dc:	078e                	slli	a5,a5,0x3
 1de:	00001517          	auipc	a0,0x1
 1e2:	83250513          	addi	a0,a0,-1998 # a10 <rings>
 1e6:	97aa                	add	a5,a5,a0
 1e8:	6788                	ld	a0,8(a5)
 1ea:	611c                	ld	a5,0(a0)
 1ec:	ef99                	bnez	a5,20a <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 1ee:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 1f0:	41f7579b          	sraiw	a5,a4,0x1f
 1f4:	01d7d79b          	srliw	a5,a5,0x1d
 1f8:	9fb9                	addw	a5,a5,a4
 1fa:	4037d79b          	sraiw	a5,a5,0x3
 1fe:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 200:	60e2                	ld	ra,24(sp)
 202:	6442                	ld	s0,16(sp)
 204:	64a2                	ld	s1,8(sp)
 206:	6105                	addi	sp,sp,32
 208:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 20a:	00000097          	auipc	ra,0x0
 20e:	e34080e7          	jalr	-460(ra) # 3e <load>
    *bytes /= 8;
 212:	41f5579b          	sraiw	a5,a0,0x1f
 216:	01d7d79b          	srliw	a5,a5,0x1d
 21a:	9d3d                	addw	a0,a0,a5
 21c:	4035551b          	sraiw	a0,a0,0x3
 220:	c088                	sw	a0,0(s1)
}
 222:	bff9                	j	200 <ringbuf_start_read+0x36>

0000000000000224 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 224:	1141                	addi	sp,sp,-16
 226:	e406                	sd	ra,8(sp)
 228:	e022                	sd	s0,0(sp)
 22a:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 22c:	00151793          	slli	a5,a0,0x1
 230:	97aa                	add	a5,a5,a0
 232:	078e                	slli	a5,a5,0x3
 234:	00000517          	auipc	a0,0x0
 238:	7dc50513          	addi	a0,a0,2012 # a10 <rings>
 23c:	97aa                	add	a5,a5,a0
 23e:	0035959b          	slliw	a1,a1,0x3
 242:	6788                	ld	a0,8(a5)
 244:	00000097          	auipc	ra,0x0
 248:	de6080e7          	jalr	-538(ra) # 2a <store>
}
 24c:	60a2                	ld	ra,8(sp)
 24e:	6402                	ld	s0,0(sp)
 250:	0141                	addi	sp,sp,16
 252:	8082                	ret

0000000000000254 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 254:	1141                	addi	sp,sp,-16
 256:	e422                	sd	s0,8(sp)
 258:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 25a:	87aa                	mv	a5,a0
 25c:	0585                	addi	a1,a1,1
 25e:	0785                	addi	a5,a5,1
 260:	fff5c703          	lbu	a4,-1(a1)
 264:	fee78fa3          	sb	a4,-1(a5)
 268:	fb75                	bnez	a4,25c <strcpy+0x8>
    ;
  return os;
}
 26a:	6422                	ld	s0,8(sp)
 26c:	0141                	addi	sp,sp,16
 26e:	8082                	ret

0000000000000270 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 270:	1141                	addi	sp,sp,-16
 272:	e422                	sd	s0,8(sp)
 274:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 276:	00054783          	lbu	a5,0(a0)
 27a:	cb91                	beqz	a5,28e <strcmp+0x1e>
 27c:	0005c703          	lbu	a4,0(a1)
 280:	00f71763          	bne	a4,a5,28e <strcmp+0x1e>
    p++, q++;
 284:	0505                	addi	a0,a0,1
 286:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 288:	00054783          	lbu	a5,0(a0)
 28c:	fbe5                	bnez	a5,27c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 28e:	0005c503          	lbu	a0,0(a1)
}
 292:	40a7853b          	subw	a0,a5,a0
 296:	6422                	ld	s0,8(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret

000000000000029c <strlen>:

uint
strlen(const char *s)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2a2:	00054783          	lbu	a5,0(a0)
 2a6:	cf91                	beqz	a5,2c2 <strlen+0x26>
 2a8:	0505                	addi	a0,a0,1
 2aa:	87aa                	mv	a5,a0
 2ac:	4685                	li	a3,1
 2ae:	9e89                	subw	a3,a3,a0
 2b0:	00f6853b          	addw	a0,a3,a5
 2b4:	0785                	addi	a5,a5,1
 2b6:	fff7c703          	lbu	a4,-1(a5)
 2ba:	fb7d                	bnez	a4,2b0 <strlen+0x14>
    ;
  return n;
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
  for(n = 0; s[n]; n++)
 2c2:	4501                	li	a0,0
 2c4:	bfe5                	j	2bc <strlen+0x20>

00000000000002c6 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2cc:	ca19                	beqz	a2,2e2 <memset+0x1c>
 2ce:	87aa                	mv	a5,a0
 2d0:	1602                	slli	a2,a2,0x20
 2d2:	9201                	srli	a2,a2,0x20
 2d4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2d8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2dc:	0785                	addi	a5,a5,1
 2de:	fee79de3          	bne	a5,a4,2d8 <memset+0x12>
  }
  return dst;
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <strchr>:

char*
strchr(const char *s, char c)
{
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	cb99                	beqz	a5,308 <strchr+0x20>
    if(*s == c)
 2f4:	00f58763          	beq	a1,a5,302 <strchr+0x1a>
  for(; *s; s++)
 2f8:	0505                	addi	a0,a0,1
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	fbfd                	bnez	a5,2f4 <strchr+0xc>
      return (char*)s;
  return 0;
 300:	4501                	li	a0,0
}
 302:	6422                	ld	s0,8(sp)
 304:	0141                	addi	sp,sp,16
 306:	8082                	ret
  return 0;
 308:	4501                	li	a0,0
 30a:	bfe5                	j	302 <strchr+0x1a>

000000000000030c <gets>:

char*
gets(char *buf, int max)
{
 30c:	711d                	addi	sp,sp,-96
 30e:	ec86                	sd	ra,88(sp)
 310:	e8a2                	sd	s0,80(sp)
 312:	e4a6                	sd	s1,72(sp)
 314:	e0ca                	sd	s2,64(sp)
 316:	fc4e                	sd	s3,56(sp)
 318:	f852                	sd	s4,48(sp)
 31a:	f456                	sd	s5,40(sp)
 31c:	f05a                	sd	s6,32(sp)
 31e:	ec5e                	sd	s7,24(sp)
 320:	1080                	addi	s0,sp,96
 322:	8baa                	mv	s7,a0
 324:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 326:	892a                	mv	s2,a0
 328:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 32a:	4aa9                	li	s5,10
 32c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 32e:	89a6                	mv	s3,s1
 330:	2485                	addiw	s1,s1,1
 332:	0344d863          	bge	s1,s4,362 <gets+0x56>
    cc = read(0, &c, 1);
 336:	4605                	li	a2,1
 338:	faf40593          	addi	a1,s0,-81
 33c:	4501                	li	a0,0
 33e:	00000097          	auipc	ra,0x0
 342:	19c080e7          	jalr	412(ra) # 4da <read>
    if(cc < 1)
 346:	00a05e63          	blez	a0,362 <gets+0x56>
    buf[i++] = c;
 34a:	faf44783          	lbu	a5,-81(s0)
 34e:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 352:	01578763          	beq	a5,s5,360 <gets+0x54>
 356:	0905                	addi	s2,s2,1
 358:	fd679be3          	bne	a5,s6,32e <gets+0x22>
  for(i=0; i+1 < max; ){
 35c:	89a6                	mv	s3,s1
 35e:	a011                	j	362 <gets+0x56>
 360:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 362:	99de                	add	s3,s3,s7
 364:	00098023          	sb	zero,0(s3)
  return buf;
}
 368:	855e                	mv	a0,s7
 36a:	60e6                	ld	ra,88(sp)
 36c:	6446                	ld	s0,80(sp)
 36e:	64a6                	ld	s1,72(sp)
 370:	6906                	ld	s2,64(sp)
 372:	79e2                	ld	s3,56(sp)
 374:	7a42                	ld	s4,48(sp)
 376:	7aa2                	ld	s5,40(sp)
 378:	7b02                	ld	s6,32(sp)
 37a:	6be2                	ld	s7,24(sp)
 37c:	6125                	addi	sp,sp,96
 37e:	8082                	ret

0000000000000380 <stat>:

int
stat(const char *n, struct stat *st)
{
 380:	1101                	addi	sp,sp,-32
 382:	ec06                	sd	ra,24(sp)
 384:	e822                	sd	s0,16(sp)
 386:	e426                	sd	s1,8(sp)
 388:	e04a                	sd	s2,0(sp)
 38a:	1000                	addi	s0,sp,32
 38c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 38e:	4581                	li	a1,0
 390:	00000097          	auipc	ra,0x0
 394:	172080e7          	jalr	370(ra) # 502 <open>
  if(fd < 0)
 398:	02054563          	bltz	a0,3c2 <stat+0x42>
 39c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 39e:	85ca                	mv	a1,s2
 3a0:	00000097          	auipc	ra,0x0
 3a4:	17a080e7          	jalr	378(ra) # 51a <fstat>
 3a8:	892a                	mv	s2,a0
  close(fd);
 3aa:	8526                	mv	a0,s1
 3ac:	00000097          	auipc	ra,0x0
 3b0:	13e080e7          	jalr	318(ra) # 4ea <close>
  return r;
}
 3b4:	854a                	mv	a0,s2
 3b6:	60e2                	ld	ra,24(sp)
 3b8:	6442                	ld	s0,16(sp)
 3ba:	64a2                	ld	s1,8(sp)
 3bc:	6902                	ld	s2,0(sp)
 3be:	6105                	addi	sp,sp,32
 3c0:	8082                	ret
    return -1;
 3c2:	597d                	li	s2,-1
 3c4:	bfc5                	j	3b4 <stat+0x34>

00000000000003c6 <atoi>:

int
atoi(const char *s)
{
 3c6:	1141                	addi	sp,sp,-16
 3c8:	e422                	sd	s0,8(sp)
 3ca:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3cc:	00054603          	lbu	a2,0(a0)
 3d0:	fd06079b          	addiw	a5,a2,-48
 3d4:	0ff7f793          	zext.b	a5,a5
 3d8:	4725                	li	a4,9
 3da:	02f76963          	bltu	a4,a5,40c <atoi+0x46>
 3de:	86aa                	mv	a3,a0
  n = 0;
 3e0:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3e2:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3e4:	0685                	addi	a3,a3,1
 3e6:	0025179b          	slliw	a5,a0,0x2
 3ea:	9fa9                	addw	a5,a5,a0
 3ec:	0017979b          	slliw	a5,a5,0x1
 3f0:	9fb1                	addw	a5,a5,a2
 3f2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3f6:	0006c603          	lbu	a2,0(a3)
 3fa:	fd06071b          	addiw	a4,a2,-48
 3fe:	0ff77713          	zext.b	a4,a4
 402:	fee5f1e3          	bgeu	a1,a4,3e4 <atoi+0x1e>
  return n;
}
 406:	6422                	ld	s0,8(sp)
 408:	0141                	addi	sp,sp,16
 40a:	8082                	ret
  n = 0;
 40c:	4501                	li	a0,0
 40e:	bfe5                	j	406 <atoi+0x40>

0000000000000410 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 410:	1141                	addi	sp,sp,-16
 412:	e422                	sd	s0,8(sp)
 414:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 416:	02b57463          	bgeu	a0,a1,43e <memmove+0x2e>
    while(n-- > 0)
 41a:	00c05f63          	blez	a2,438 <memmove+0x28>
 41e:	1602                	slli	a2,a2,0x20
 420:	9201                	srli	a2,a2,0x20
 422:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 426:	872a                	mv	a4,a0
      *dst++ = *src++;
 428:	0585                	addi	a1,a1,1
 42a:	0705                	addi	a4,a4,1
 42c:	fff5c683          	lbu	a3,-1(a1)
 430:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 434:	fee79ae3          	bne	a5,a4,428 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 438:	6422                	ld	s0,8(sp)
 43a:	0141                	addi	sp,sp,16
 43c:	8082                	ret
    dst += n;
 43e:	00c50733          	add	a4,a0,a2
    src += n;
 442:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 444:	fec05ae3          	blez	a2,438 <memmove+0x28>
 448:	fff6079b          	addiw	a5,a2,-1
 44c:	1782                	slli	a5,a5,0x20
 44e:	9381                	srli	a5,a5,0x20
 450:	fff7c793          	not	a5,a5
 454:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 456:	15fd                	addi	a1,a1,-1
 458:	177d                	addi	a4,a4,-1
 45a:	0005c683          	lbu	a3,0(a1)
 45e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 462:	fee79ae3          	bne	a5,a4,456 <memmove+0x46>
 466:	bfc9                	j	438 <memmove+0x28>

0000000000000468 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 468:	1141                	addi	sp,sp,-16
 46a:	e422                	sd	s0,8(sp)
 46c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 46e:	ca05                	beqz	a2,49e <memcmp+0x36>
 470:	fff6069b          	addiw	a3,a2,-1
 474:	1682                	slli	a3,a3,0x20
 476:	9281                	srli	a3,a3,0x20
 478:	0685                	addi	a3,a3,1
 47a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 47c:	00054783          	lbu	a5,0(a0)
 480:	0005c703          	lbu	a4,0(a1)
 484:	00e79863          	bne	a5,a4,494 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 488:	0505                	addi	a0,a0,1
    p2++;
 48a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 48c:	fed518e3          	bne	a0,a3,47c <memcmp+0x14>
  }
  return 0;
 490:	4501                	li	a0,0
 492:	a019                	j	498 <memcmp+0x30>
      return *p1 - *p2;
 494:	40e7853b          	subw	a0,a5,a4
}
 498:	6422                	ld	s0,8(sp)
 49a:	0141                	addi	sp,sp,16
 49c:	8082                	ret
  return 0;
 49e:	4501                	li	a0,0
 4a0:	bfe5                	j	498 <memcmp+0x30>

00000000000004a2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4a2:	1141                	addi	sp,sp,-16
 4a4:	e406                	sd	ra,8(sp)
 4a6:	e022                	sd	s0,0(sp)
 4a8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4aa:	00000097          	auipc	ra,0x0
 4ae:	f66080e7          	jalr	-154(ra) # 410 <memmove>
}
 4b2:	60a2                	ld	ra,8(sp)
 4b4:	6402                	ld	s0,0(sp)
 4b6:	0141                	addi	sp,sp,16
 4b8:	8082                	ret

00000000000004ba <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4ba:	4885                	li	a7,1
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4c2:	4889                	li	a7,2
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <wait>:
.global wait
wait:
 li a7, SYS_wait
 4ca:	488d                	li	a7,3
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4d2:	4891                	li	a7,4
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <read>:
.global read
read:
 li a7, SYS_read
 4da:	4895                	li	a7,5
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <write>:
.global write
write:
 li a7, SYS_write
 4e2:	48c1                	li	a7,16
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <close>:
.global close
close:
 li a7, SYS_close
 4ea:	48d5                	li	a7,21
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 4f2:	4899                	li	a7,6
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <exec>:
.global exec
exec:
 li a7, SYS_exec
 4fa:	489d                	li	a7,7
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <open>:
.global open
open:
 li a7, SYS_open
 502:	48bd                	li	a7,15
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 50a:	48c5                	li	a7,17
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 512:	48c9                	li	a7,18
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 51a:	48a1                	li	a7,8
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <link>:
.global link
link:
 li a7, SYS_link
 522:	48cd                	li	a7,19
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 52a:	48d1                	li	a7,20
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 532:	48a5                	li	a7,9
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <dup>:
.global dup
dup:
 li a7, SYS_dup
 53a:	48a9                	li	a7,10
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 542:	48ad                	li	a7,11
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 54a:	48b1                	li	a7,12
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 552:	48b5                	li	a7,13
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 55a:	48b9                	li	a7,14
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 562:	48d9                	li	a7,22
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 56a:	1101                	addi	sp,sp,-32
 56c:	ec06                	sd	ra,24(sp)
 56e:	e822                	sd	s0,16(sp)
 570:	1000                	addi	s0,sp,32
 572:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 576:	4605                	li	a2,1
 578:	fef40593          	addi	a1,s0,-17
 57c:	00000097          	auipc	ra,0x0
 580:	f66080e7          	jalr	-154(ra) # 4e2 <write>
}
 584:	60e2                	ld	ra,24(sp)
 586:	6442                	ld	s0,16(sp)
 588:	6105                	addi	sp,sp,32
 58a:	8082                	ret

000000000000058c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 58c:	7139                	addi	sp,sp,-64
 58e:	fc06                	sd	ra,56(sp)
 590:	f822                	sd	s0,48(sp)
 592:	f426                	sd	s1,40(sp)
 594:	f04a                	sd	s2,32(sp)
 596:	ec4e                	sd	s3,24(sp)
 598:	0080                	addi	s0,sp,64
 59a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 59c:	c299                	beqz	a3,5a2 <printint+0x16>
 59e:	0805c863          	bltz	a1,62e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5a2:	2581                	sext.w	a1,a1
  neg = 0;
 5a4:	4881                	li	a7,0
 5a6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5aa:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ac:	2601                	sext.w	a2,a2
 5ae:	00000517          	auipc	a0,0x0
 5b2:	44250513          	addi	a0,a0,1090 # 9f0 <digits>
 5b6:	883a                	mv	a6,a4
 5b8:	2705                	addiw	a4,a4,1
 5ba:	02c5f7bb          	remuw	a5,a1,a2
 5be:	1782                	slli	a5,a5,0x20
 5c0:	9381                	srli	a5,a5,0x20
 5c2:	97aa                	add	a5,a5,a0
 5c4:	0007c783          	lbu	a5,0(a5)
 5c8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5cc:	0005879b          	sext.w	a5,a1
 5d0:	02c5d5bb          	divuw	a1,a1,a2
 5d4:	0685                	addi	a3,a3,1
 5d6:	fec7f0e3          	bgeu	a5,a2,5b6 <printint+0x2a>
  if(neg)
 5da:	00088b63          	beqz	a7,5f0 <printint+0x64>
    buf[i++] = '-';
 5de:	fd040793          	addi	a5,s0,-48
 5e2:	973e                	add	a4,a4,a5
 5e4:	02d00793          	li	a5,45
 5e8:	fef70823          	sb	a5,-16(a4)
 5ec:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5f0:	02e05863          	blez	a4,620 <printint+0x94>
 5f4:	fc040793          	addi	a5,s0,-64
 5f8:	00e78933          	add	s2,a5,a4
 5fc:	fff78993          	addi	s3,a5,-1
 600:	99ba                	add	s3,s3,a4
 602:	377d                	addiw	a4,a4,-1
 604:	1702                	slli	a4,a4,0x20
 606:	9301                	srli	a4,a4,0x20
 608:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 60c:	fff94583          	lbu	a1,-1(s2)
 610:	8526                	mv	a0,s1
 612:	00000097          	auipc	ra,0x0
 616:	f58080e7          	jalr	-168(ra) # 56a <putc>
  while(--i >= 0)
 61a:	197d                	addi	s2,s2,-1
 61c:	ff3918e3          	bne	s2,s3,60c <printint+0x80>
}
 620:	70e2                	ld	ra,56(sp)
 622:	7442                	ld	s0,48(sp)
 624:	74a2                	ld	s1,40(sp)
 626:	7902                	ld	s2,32(sp)
 628:	69e2                	ld	s3,24(sp)
 62a:	6121                	addi	sp,sp,64
 62c:	8082                	ret
    x = -xx;
 62e:	40b005bb          	negw	a1,a1
    neg = 1;
 632:	4885                	li	a7,1
    x = -xx;
 634:	bf8d                	j	5a6 <printint+0x1a>

0000000000000636 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 636:	7119                	addi	sp,sp,-128
 638:	fc86                	sd	ra,120(sp)
 63a:	f8a2                	sd	s0,112(sp)
 63c:	f4a6                	sd	s1,104(sp)
 63e:	f0ca                	sd	s2,96(sp)
 640:	ecce                	sd	s3,88(sp)
 642:	e8d2                	sd	s4,80(sp)
 644:	e4d6                	sd	s5,72(sp)
 646:	e0da                	sd	s6,64(sp)
 648:	fc5e                	sd	s7,56(sp)
 64a:	f862                	sd	s8,48(sp)
 64c:	f466                	sd	s9,40(sp)
 64e:	f06a                	sd	s10,32(sp)
 650:	ec6e                	sd	s11,24(sp)
 652:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 654:	0005c903          	lbu	s2,0(a1)
 658:	18090f63          	beqz	s2,7f6 <vprintf+0x1c0>
 65c:	8aaa                	mv	s5,a0
 65e:	8b32                	mv	s6,a2
 660:	00158493          	addi	s1,a1,1
  state = 0;
 664:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 666:	02500a13          	li	s4,37
      if(c == 'd'){
 66a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 66e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 672:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 676:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 67a:	00000b97          	auipc	s7,0x0
 67e:	376b8b93          	addi	s7,s7,886 # 9f0 <digits>
 682:	a839                	j	6a0 <vprintf+0x6a>
        putc(fd, c);
 684:	85ca                	mv	a1,s2
 686:	8556                	mv	a0,s5
 688:	00000097          	auipc	ra,0x0
 68c:	ee2080e7          	jalr	-286(ra) # 56a <putc>
 690:	a019                	j	696 <vprintf+0x60>
    } else if(state == '%'){
 692:	01498f63          	beq	s3,s4,6b0 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 696:	0485                	addi	s1,s1,1
 698:	fff4c903          	lbu	s2,-1(s1)
 69c:	14090d63          	beqz	s2,7f6 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6a0:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6a4:	fe0997e3          	bnez	s3,692 <vprintf+0x5c>
      if(c == '%'){
 6a8:	fd479ee3          	bne	a5,s4,684 <vprintf+0x4e>
        state = '%';
 6ac:	89be                	mv	s3,a5
 6ae:	b7e5                	j	696 <vprintf+0x60>
      if(c == 'd'){
 6b0:	05878063          	beq	a5,s8,6f0 <vprintf+0xba>
      } else if(c == 'l') {
 6b4:	05978c63          	beq	a5,s9,70c <vprintf+0xd6>
      } else if(c == 'x') {
 6b8:	07a78863          	beq	a5,s10,728 <vprintf+0xf2>
      } else if(c == 'p') {
 6bc:	09b78463          	beq	a5,s11,744 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6c0:	07300713          	li	a4,115
 6c4:	0ce78663          	beq	a5,a4,790 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6c8:	06300713          	li	a4,99
 6cc:	0ee78e63          	beq	a5,a4,7c8 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6d0:	11478863          	beq	a5,s4,7e0 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6d4:	85d2                	mv	a1,s4
 6d6:	8556                	mv	a0,s5
 6d8:	00000097          	auipc	ra,0x0
 6dc:	e92080e7          	jalr	-366(ra) # 56a <putc>
        putc(fd, c);
 6e0:	85ca                	mv	a1,s2
 6e2:	8556                	mv	a0,s5
 6e4:	00000097          	auipc	ra,0x0
 6e8:	e86080e7          	jalr	-378(ra) # 56a <putc>
      }
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	b765                	j	696 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6f0:	008b0913          	addi	s2,s6,8
 6f4:	4685                	li	a3,1
 6f6:	4629                	li	a2,10
 6f8:	000b2583          	lw	a1,0(s6)
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	e8e080e7          	jalr	-370(ra) # 58c <printint>
 706:	8b4a                	mv	s6,s2
      state = 0;
 708:	4981                	li	s3,0
 70a:	b771                	j	696 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 70c:	008b0913          	addi	s2,s6,8
 710:	4681                	li	a3,0
 712:	4629                	li	a2,10
 714:	000b2583          	lw	a1,0(s6)
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	e72080e7          	jalr	-398(ra) # 58c <printint>
 722:	8b4a                	mv	s6,s2
      state = 0;
 724:	4981                	li	s3,0
 726:	bf85                	j	696 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 728:	008b0913          	addi	s2,s6,8
 72c:	4681                	li	a3,0
 72e:	4641                	li	a2,16
 730:	000b2583          	lw	a1,0(s6)
 734:	8556                	mv	a0,s5
 736:	00000097          	auipc	ra,0x0
 73a:	e56080e7          	jalr	-426(ra) # 58c <printint>
 73e:	8b4a                	mv	s6,s2
      state = 0;
 740:	4981                	li	s3,0
 742:	bf91                	j	696 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 744:	008b0793          	addi	a5,s6,8
 748:	f8f43423          	sd	a5,-120(s0)
 74c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 750:	03000593          	li	a1,48
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	e14080e7          	jalr	-492(ra) # 56a <putc>
  putc(fd, 'x');
 75e:	85ea                	mv	a1,s10
 760:	8556                	mv	a0,s5
 762:	00000097          	auipc	ra,0x0
 766:	e08080e7          	jalr	-504(ra) # 56a <putc>
 76a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76c:	03c9d793          	srli	a5,s3,0x3c
 770:	97de                	add	a5,a5,s7
 772:	0007c583          	lbu	a1,0(a5)
 776:	8556                	mv	a0,s5
 778:	00000097          	auipc	ra,0x0
 77c:	df2080e7          	jalr	-526(ra) # 56a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 780:	0992                	slli	s3,s3,0x4
 782:	397d                	addiw	s2,s2,-1
 784:	fe0914e3          	bnez	s2,76c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 788:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 78c:	4981                	li	s3,0
 78e:	b721                	j	696 <vprintf+0x60>
        s = va_arg(ap, char*);
 790:	008b0993          	addi	s3,s6,8
 794:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 798:	02090163          	beqz	s2,7ba <vprintf+0x184>
        while(*s != 0){
 79c:	00094583          	lbu	a1,0(s2)
 7a0:	c9a1                	beqz	a1,7f0 <vprintf+0x1ba>
          putc(fd, *s);
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	dc6080e7          	jalr	-570(ra) # 56a <putc>
          s++;
 7ac:	0905                	addi	s2,s2,1
        while(*s != 0){
 7ae:	00094583          	lbu	a1,0(s2)
 7b2:	f9e5                	bnez	a1,7a2 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7b4:	8b4e                	mv	s6,s3
      state = 0;
 7b6:	4981                	li	s3,0
 7b8:	bdf9                	j	696 <vprintf+0x60>
          s = "(null)";
 7ba:	00000917          	auipc	s2,0x0
 7be:	22e90913          	addi	s2,s2,558 # 9e8 <malloc+0xe8>
        while(*s != 0){
 7c2:	02800593          	li	a1,40
 7c6:	bff1                	j	7a2 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7c8:	008b0913          	addi	s2,s6,8
 7cc:	000b4583          	lbu	a1,0(s6)
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	d98080e7          	jalr	-616(ra) # 56a <putc>
 7da:	8b4a                	mv	s6,s2
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bd65                	j	696 <vprintf+0x60>
        putc(fd, c);
 7e0:	85d2                	mv	a1,s4
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	d86080e7          	jalr	-634(ra) # 56a <putc>
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	b565                	j	696 <vprintf+0x60>
        s = va_arg(ap, char*);
 7f0:	8b4e                	mv	s6,s3
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	b54d                	j	696 <vprintf+0x60>
    }
  }
}
 7f6:	70e6                	ld	ra,120(sp)
 7f8:	7446                	ld	s0,112(sp)
 7fa:	74a6                	ld	s1,104(sp)
 7fc:	7906                	ld	s2,96(sp)
 7fe:	69e6                	ld	s3,88(sp)
 800:	6a46                	ld	s4,80(sp)
 802:	6aa6                	ld	s5,72(sp)
 804:	6b06                	ld	s6,64(sp)
 806:	7be2                	ld	s7,56(sp)
 808:	7c42                	ld	s8,48(sp)
 80a:	7ca2                	ld	s9,40(sp)
 80c:	7d02                	ld	s10,32(sp)
 80e:	6de2                	ld	s11,24(sp)
 810:	6109                	addi	sp,sp,128
 812:	8082                	ret

0000000000000814 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 814:	715d                	addi	sp,sp,-80
 816:	ec06                	sd	ra,24(sp)
 818:	e822                	sd	s0,16(sp)
 81a:	1000                	addi	s0,sp,32
 81c:	e010                	sd	a2,0(s0)
 81e:	e414                	sd	a3,8(s0)
 820:	e818                	sd	a4,16(s0)
 822:	ec1c                	sd	a5,24(s0)
 824:	03043023          	sd	a6,32(s0)
 828:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 82c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 830:	8622                	mv	a2,s0
 832:	00000097          	auipc	ra,0x0
 836:	e04080e7          	jalr	-508(ra) # 636 <vprintf>
}
 83a:	60e2                	ld	ra,24(sp)
 83c:	6442                	ld	s0,16(sp)
 83e:	6161                	addi	sp,sp,80
 840:	8082                	ret

0000000000000842 <printf>:

void
printf(const char *fmt, ...)
{
 842:	711d                	addi	sp,sp,-96
 844:	ec06                	sd	ra,24(sp)
 846:	e822                	sd	s0,16(sp)
 848:	1000                	addi	s0,sp,32
 84a:	e40c                	sd	a1,8(s0)
 84c:	e810                	sd	a2,16(s0)
 84e:	ec14                	sd	a3,24(s0)
 850:	f018                	sd	a4,32(s0)
 852:	f41c                	sd	a5,40(s0)
 854:	03043823          	sd	a6,48(s0)
 858:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 85c:	00840613          	addi	a2,s0,8
 860:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 864:	85aa                	mv	a1,a0
 866:	4505                	li	a0,1
 868:	00000097          	auipc	ra,0x0
 86c:	dce080e7          	jalr	-562(ra) # 636 <vprintf>
}
 870:	60e2                	ld	ra,24(sp)
 872:	6442                	ld	s0,16(sp)
 874:	6125                	addi	sp,sp,96
 876:	8082                	ret

0000000000000878 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 878:	1141                	addi	sp,sp,-16
 87a:	e422                	sd	s0,8(sp)
 87c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 87e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 882:	00000797          	auipc	a5,0x0
 886:	1867b783          	ld	a5,390(a5) # a08 <freep>
 88a:	a805                	j	8ba <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 88c:	4618                	lw	a4,8(a2)
 88e:	9db9                	addw	a1,a1,a4
 890:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 894:	6398                	ld	a4,0(a5)
 896:	6318                	ld	a4,0(a4)
 898:	fee53823          	sd	a4,-16(a0)
 89c:	a091                	j	8e0 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 89e:	ff852703          	lw	a4,-8(a0)
 8a2:	9e39                	addw	a2,a2,a4
 8a4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8a6:	ff053703          	ld	a4,-16(a0)
 8aa:	e398                	sd	a4,0(a5)
 8ac:	a099                	j	8f2 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ae:	6398                	ld	a4,0(a5)
 8b0:	00e7e463          	bltu	a5,a4,8b8 <free+0x40>
 8b4:	00e6ea63          	bltu	a3,a4,8c8 <free+0x50>
{
 8b8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ba:	fed7fae3          	bgeu	a5,a3,8ae <free+0x36>
 8be:	6398                	ld	a4,0(a5)
 8c0:	00e6e463          	bltu	a3,a4,8c8 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c4:	fee7eae3          	bltu	a5,a4,8b8 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8c8:	ff852583          	lw	a1,-8(a0)
 8cc:	6390                	ld	a2,0(a5)
 8ce:	02059813          	slli	a6,a1,0x20
 8d2:	01c85713          	srli	a4,a6,0x1c
 8d6:	9736                	add	a4,a4,a3
 8d8:	fae60ae3          	beq	a2,a4,88c <free+0x14>
    bp->s.ptr = p->s.ptr;
 8dc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8e0:	4790                	lw	a2,8(a5)
 8e2:	02061593          	slli	a1,a2,0x20
 8e6:	01c5d713          	srli	a4,a1,0x1c
 8ea:	973e                	add	a4,a4,a5
 8ec:	fae689e3          	beq	a3,a4,89e <free+0x26>
  } else
    p->s.ptr = bp;
 8f0:	e394                	sd	a3,0(a5)
  freep = p;
 8f2:	00000717          	auipc	a4,0x0
 8f6:	10f73b23          	sd	a5,278(a4) # a08 <freep>
}
 8fa:	6422                	ld	s0,8(sp)
 8fc:	0141                	addi	sp,sp,16
 8fe:	8082                	ret

0000000000000900 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 900:	7139                	addi	sp,sp,-64
 902:	fc06                	sd	ra,56(sp)
 904:	f822                	sd	s0,48(sp)
 906:	f426                	sd	s1,40(sp)
 908:	f04a                	sd	s2,32(sp)
 90a:	ec4e                	sd	s3,24(sp)
 90c:	e852                	sd	s4,16(sp)
 90e:	e456                	sd	s5,8(sp)
 910:	e05a                	sd	s6,0(sp)
 912:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 914:	02051493          	slli	s1,a0,0x20
 918:	9081                	srli	s1,s1,0x20
 91a:	04bd                	addi	s1,s1,15
 91c:	8091                	srli	s1,s1,0x4
 91e:	0014899b          	addiw	s3,s1,1
 922:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 924:	00000517          	auipc	a0,0x0
 928:	0e453503          	ld	a0,228(a0) # a08 <freep>
 92c:	c515                	beqz	a0,958 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 930:	4798                	lw	a4,8(a5)
 932:	02977f63          	bgeu	a4,s1,970 <malloc+0x70>
 936:	8a4e                	mv	s4,s3
 938:	0009871b          	sext.w	a4,s3
 93c:	6685                	lui	a3,0x1
 93e:	00d77363          	bgeu	a4,a3,944 <malloc+0x44>
 942:	6a05                	lui	s4,0x1
 944:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 948:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 94c:	00000917          	auipc	s2,0x0
 950:	0bc90913          	addi	s2,s2,188 # a08 <freep>
  if(p == (char*)-1)
 954:	5afd                	li	s5,-1
 956:	a895                	j	9ca <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 958:	00000797          	auipc	a5,0x0
 95c:	1a878793          	addi	a5,a5,424 # b00 <base>
 960:	00000717          	auipc	a4,0x0
 964:	0af73423          	sd	a5,168(a4) # a08 <freep>
 968:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 96a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 96e:	b7e1                	j	936 <malloc+0x36>
      if(p->s.size == nunits)
 970:	02e48c63          	beq	s1,a4,9a8 <malloc+0xa8>
        p->s.size -= nunits;
 974:	4137073b          	subw	a4,a4,s3
 978:	c798                	sw	a4,8(a5)
        p += p->s.size;
 97a:	02071693          	slli	a3,a4,0x20
 97e:	01c6d713          	srli	a4,a3,0x1c
 982:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 984:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 988:	00000717          	auipc	a4,0x0
 98c:	08a73023          	sd	a0,128(a4) # a08 <freep>
      return (void*)(p + 1);
 990:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 994:	70e2                	ld	ra,56(sp)
 996:	7442                	ld	s0,48(sp)
 998:	74a2                	ld	s1,40(sp)
 99a:	7902                	ld	s2,32(sp)
 99c:	69e2                	ld	s3,24(sp)
 99e:	6a42                	ld	s4,16(sp)
 9a0:	6aa2                	ld	s5,8(sp)
 9a2:	6b02                	ld	s6,0(sp)
 9a4:	6121                	addi	sp,sp,64
 9a6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9a8:	6398                	ld	a4,0(a5)
 9aa:	e118                	sd	a4,0(a0)
 9ac:	bff1                	j	988 <malloc+0x88>
  hp->s.size = nu;
 9ae:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9b2:	0541                	addi	a0,a0,16
 9b4:	00000097          	auipc	ra,0x0
 9b8:	ec4080e7          	jalr	-316(ra) # 878 <free>
  return freep;
 9bc:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9c0:	d971                	beqz	a0,994 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9c2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9c4:	4798                	lw	a4,8(a5)
 9c6:	fa9775e3          	bgeu	a4,s1,970 <malloc+0x70>
    if(p == freep)
 9ca:	00093703          	ld	a4,0(s2)
 9ce:	853e                	mv	a0,a5
 9d0:	fef719e3          	bne	a4,a5,9c2 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9d4:	8552                	mv	a0,s4
 9d6:	00000097          	auipc	ra,0x0
 9da:	b74080e7          	jalr	-1164(ra) # 54a <sbrk>
  if(p == (char*)-1)
 9de:	fd5518e3          	bne	a0,s5,9ae <malloc+0xae>
        return 0;
 9e2:	4501                	li	a0,0
 9e4:	bf45                	j	994 <malloc+0x94>
