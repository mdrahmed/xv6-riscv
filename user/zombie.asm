
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
   c:	4ca080e7          	jalr	1226(ra) # 4d2 <fork>
  10:	00a04763          	bgtz	a0,1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  exit(0);
  14:	4501                	li	a0,0
  16:	00000097          	auipc	ra,0x0
  1a:	4c4080e7          	jalr	1220(ra) # 4da <exit>
    sleep(5);  // Let child exit before parent.
  1e:	4515                	li	a0,5
  20:	00000097          	auipc	ra,0x0
  24:	54a080e7          	jalr	1354(ra) # 56a <sleep>
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
  70:	9cc48493          	addi	s1,s1,-1588 # a38 <rings+0x10>
  74:	00001917          	auipc	s2,0x1
  78:	ab490913          	addi	s2,s2,-1356 # b28 <__BSS_END__>
  7c:	04f59563          	bne	a1,a5,c6 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  80:	00001497          	auipc	s1,0x1
  84:	9b84a483          	lw	s1,-1608(s1) # a38 <rings+0x10>
  88:	c099                	beqz	s1,8e <create_or_close_the_buffer_user+0x38>
  8a:	4481                	li	s1,0
  8c:	a899                	j	e2 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  8e:	00001917          	auipc	s2,0x1
  92:	99a90913          	addi	s2,s2,-1638 # a28 <rings>
  96:	00093603          	ld	a2,0(s2)
  9a:	4585                	li	a1,1
  9c:	00000097          	auipc	ra,0x0
  a0:	4de080e7          	jalr	1246(ra) # 57a <ringbuf>
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
  d6:	4a8080e7          	jalr	1192(ra) # 57a <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
  f4:	1101                	addi	sp,sp,-32
  f6:	ec06                	sd	ra,24(sp)
  f8:	e822                	sd	s0,16(sp)
  fa:	e426                	sd	s1,8(sp)
  fc:	1000                	addi	s0,sp,32
  fe:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 100:	00151793          	slli	a5,a0,0x1
 104:	97aa                	add	a5,a5,a0
 106:	078e                	slli	a5,a5,0x3
 108:	00001717          	auipc	a4,0x1
 10c:	92070713          	addi	a4,a4,-1760 # a28 <rings>
 110:	97ba                	add	a5,a5,a4
 112:	6798                	ld	a4,8(a5)
 114:	671c                	ld	a5,8(a4)
 116:	00178693          	addi	a3,a5,1
 11a:	e714                	sd	a3,8(a4)
 11c:	17d2                	slli	a5,a5,0x34
 11e:	93d1                	srli	a5,a5,0x34
 120:	6741                	lui	a4,0x10
 122:	40f707b3          	sub	a5,a4,a5
 126:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 128:	421c                	lw	a5,0(a2)
 12a:	e79d                	bnez	a5,158 <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 12c:	00001697          	auipc	a3,0x1
 130:	8fc68693          	addi	a3,a3,-1796 # a28 <rings>
 134:	669c                	ld	a5,8(a3)
 136:	6398                	ld	a4,0(a5)
 138:	67c1                	lui	a5,0x10
 13a:	9fb9                	addw	a5,a5,a4
 13c:	00151713          	slli	a4,a0,0x1
 140:	953a                	add	a0,a0,a4
 142:	050e                	slli	a0,a0,0x3
 144:	9536                	add	a0,a0,a3
 146:	6518                	ld	a4,8(a0)
 148:	6718                	ld	a4,8(a4)
 14a:	9f99                	subw	a5,a5,a4
 14c:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 14e:	60e2                	ld	ra,24(sp)
 150:	6442                	ld	s0,16(sp)
 152:	64a2                	ld	s1,8(sp)
 154:	6105                	addi	sp,sp,32
 156:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 158:	00151793          	slli	a5,a0,0x1
 15c:	953e                	add	a0,a0,a5
 15e:	050e                	slli	a0,a0,0x3
 160:	00001797          	auipc	a5,0x1
 164:	8c878793          	addi	a5,a5,-1848 # a28 <rings>
 168:	953e                	add	a0,a0,a5
 16a:	6508                	ld	a0,8(a0)
 16c:	0521                	addi	a0,a0,8
 16e:	00000097          	auipc	ra,0x0
 172:	ed0080e7          	jalr	-304(ra) # 3e <load>
 176:	c088                	sw	a0,0(s1)
}
 178:	bfd9                	j	14e <ringbuf_start_write+0x5a>

000000000000017a <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 17a:	1141                	addi	sp,sp,-16
 17c:	e406                	sd	ra,8(sp)
 17e:	e022                	sd	s0,0(sp)
 180:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 182:	00151793          	slli	a5,a0,0x1
 186:	97aa                	add	a5,a5,a0
 188:	078e                	slli	a5,a5,0x3
 18a:	00001517          	auipc	a0,0x1
 18e:	89e50513          	addi	a0,a0,-1890 # a28 <rings>
 192:	97aa                	add	a5,a5,a0
 194:	6788                	ld	a0,8(a5)
 196:	0035959b          	slliw	a1,a1,0x3
 19a:	0521                	addi	a0,a0,8
 19c:	00000097          	auipc	ra,0x0
 1a0:	e8e080e7          	jalr	-370(ra) # 2a <store>
}
 1a4:	60a2                	ld	ra,8(sp)
 1a6:	6402                	ld	s0,0(sp)
 1a8:	0141                	addi	sp,sp,16
 1aa:	8082                	ret

00000000000001ac <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1ac:	1101                	addi	sp,sp,-32
 1ae:	ec06                	sd	ra,24(sp)
 1b0:	e822                	sd	s0,16(sp)
 1b2:	e426                	sd	s1,8(sp)
 1b4:	1000                	addi	s0,sp,32
 1b6:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1b8:	00151793          	slli	a5,a0,0x1
 1bc:	97aa                	add	a5,a5,a0
 1be:	078e                	slli	a5,a5,0x3
 1c0:	00001517          	auipc	a0,0x1
 1c4:	86850513          	addi	a0,a0,-1944 # a28 <rings>
 1c8:	97aa                	add	a5,a5,a0
 1ca:	6788                	ld	a0,8(a5)
 1cc:	0521                	addi	a0,a0,8
 1ce:	00000097          	auipc	ra,0x0
 1d2:	e70080e7          	jalr	-400(ra) # 3e <load>
 1d6:	c088                	sw	a0,0(s1)
}
 1d8:	60e2                	ld	ra,24(sp)
 1da:	6442                	ld	s0,16(sp)
 1dc:	64a2                	ld	s1,8(sp)
 1de:	6105                	addi	sp,sp,32
 1e0:	8082                	ret

00000000000001e2 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 1e2:	1101                	addi	sp,sp,-32
 1e4:	ec06                	sd	ra,24(sp)
 1e6:	e822                	sd	s0,16(sp)
 1e8:	e426                	sd	s1,8(sp)
 1ea:	1000                	addi	s0,sp,32
 1ec:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 1ee:	00151793          	slli	a5,a0,0x1
 1f2:	97aa                	add	a5,a5,a0
 1f4:	078e                	slli	a5,a5,0x3
 1f6:	00001517          	auipc	a0,0x1
 1fa:	83250513          	addi	a0,a0,-1998 # a28 <rings>
 1fe:	97aa                	add	a5,a5,a0
 200:	6788                	ld	a0,8(a5)
 202:	611c                	ld	a5,0(a0)
 204:	ef99                	bnez	a5,222 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 206:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 208:	41f7579b          	sraiw	a5,a4,0x1f
 20c:	01d7d79b          	srliw	a5,a5,0x1d
 210:	9fb9                	addw	a5,a5,a4
 212:	4037d79b          	sraiw	a5,a5,0x3
 216:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 218:	60e2                	ld	ra,24(sp)
 21a:	6442                	ld	s0,16(sp)
 21c:	64a2                	ld	s1,8(sp)
 21e:	6105                	addi	sp,sp,32
 220:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 222:	00000097          	auipc	ra,0x0
 226:	e1c080e7          	jalr	-484(ra) # 3e <load>
    *bytes /= 8;
 22a:	41f5579b          	sraiw	a5,a0,0x1f
 22e:	01d7d79b          	srliw	a5,a5,0x1d
 232:	9d3d                	addw	a0,a0,a5
 234:	4035551b          	sraiw	a0,a0,0x3
 238:	c088                	sw	a0,0(s1)
}
 23a:	bff9                	j	218 <ringbuf_start_read+0x36>

000000000000023c <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 23c:	1141                	addi	sp,sp,-16
 23e:	e406                	sd	ra,8(sp)
 240:	e022                	sd	s0,0(sp)
 242:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 244:	00151793          	slli	a5,a0,0x1
 248:	97aa                	add	a5,a5,a0
 24a:	078e                	slli	a5,a5,0x3
 24c:	00000517          	auipc	a0,0x0
 250:	7dc50513          	addi	a0,a0,2012 # a28 <rings>
 254:	97aa                	add	a5,a5,a0
 256:	0035959b          	slliw	a1,a1,0x3
 25a:	6788                	ld	a0,8(a5)
 25c:	00000097          	auipc	ra,0x0
 260:	dce080e7          	jalr	-562(ra) # 2a <store>
}
 264:	60a2                	ld	ra,8(sp)
 266:	6402                	ld	s0,0(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret

000000000000026c <strcpy>:



char*
strcpy(char *s, const char *t)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e422                	sd	s0,8(sp)
 270:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 272:	87aa                	mv	a5,a0
 274:	0585                	addi	a1,a1,1
 276:	0785                	addi	a5,a5,1
 278:	fff5c703          	lbu	a4,-1(a1)
 27c:	fee78fa3          	sb	a4,-1(a5)
 280:	fb75                	bnez	a4,274 <strcpy+0x8>
    ;
  return os;
}
 282:	6422                	ld	s0,8(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 288:	1141                	addi	sp,sp,-16
 28a:	e422                	sd	s0,8(sp)
 28c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 28e:	00054783          	lbu	a5,0(a0)
 292:	cb91                	beqz	a5,2a6 <strcmp+0x1e>
 294:	0005c703          	lbu	a4,0(a1)
 298:	00f71763          	bne	a4,a5,2a6 <strcmp+0x1e>
    p++, q++;
 29c:	0505                	addi	a0,a0,1
 29e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	fbe5                	bnez	a5,294 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2a6:	0005c503          	lbu	a0,0(a1)
}
 2aa:	40a7853b          	subw	a0,a5,a0
 2ae:	6422                	ld	s0,8(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <strlen>:

uint
strlen(const char *s)
{
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e422                	sd	s0,8(sp)
 2b8:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2ba:	00054783          	lbu	a5,0(a0)
 2be:	cf91                	beqz	a5,2da <strlen+0x26>
 2c0:	0505                	addi	a0,a0,1
 2c2:	87aa                	mv	a5,a0
 2c4:	4685                	li	a3,1
 2c6:	9e89                	subw	a3,a3,a0
 2c8:	00f6853b          	addw	a0,a3,a5
 2cc:	0785                	addi	a5,a5,1
 2ce:	fff7c703          	lbu	a4,-1(a5)
 2d2:	fb7d                	bnez	a4,2c8 <strlen+0x14>
    ;
  return n;
}
 2d4:	6422                	ld	s0,8(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret
  for(n = 0; s[n]; n++)
 2da:	4501                	li	a0,0
 2dc:	bfe5                	j	2d4 <strlen+0x20>

00000000000002de <memset>:

void*
memset(void *dst, int c, uint n)
{
 2de:	1141                	addi	sp,sp,-16
 2e0:	e422                	sd	s0,8(sp)
 2e2:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2e4:	ca19                	beqz	a2,2fa <memset+0x1c>
 2e6:	87aa                	mv	a5,a0
 2e8:	1602                	slli	a2,a2,0x20
 2ea:	9201                	srli	a2,a2,0x20
 2ec:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2f0:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2f4:	0785                	addi	a5,a5,1
 2f6:	fee79de3          	bne	a5,a4,2f0 <memset+0x12>
  }
  return dst;
}
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	1141                	addi	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	addi	s0,sp,16
  for(; *s; s++)
 306:	00054783          	lbu	a5,0(a0)
 30a:	cb99                	beqz	a5,320 <strchr+0x20>
    if(*s == c)
 30c:	00f58763          	beq	a1,a5,31a <strchr+0x1a>
  for(; *s; s++)
 310:	0505                	addi	a0,a0,1
 312:	00054783          	lbu	a5,0(a0)
 316:	fbfd                	bnez	a5,30c <strchr+0xc>
      return (char*)s;
  return 0;
 318:	4501                	li	a0,0
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
  return 0;
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <strchr+0x1a>

0000000000000324 <gets>:

char*
gets(char *buf, int max)
{
 324:	711d                	addi	sp,sp,-96
 326:	ec86                	sd	ra,88(sp)
 328:	e8a2                	sd	s0,80(sp)
 32a:	e4a6                	sd	s1,72(sp)
 32c:	e0ca                	sd	s2,64(sp)
 32e:	fc4e                	sd	s3,56(sp)
 330:	f852                	sd	s4,48(sp)
 332:	f456                	sd	s5,40(sp)
 334:	f05a                	sd	s6,32(sp)
 336:	ec5e                	sd	s7,24(sp)
 338:	1080                	addi	s0,sp,96
 33a:	8baa                	mv	s7,a0
 33c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 33e:	892a                	mv	s2,a0
 340:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 342:	4aa9                	li	s5,10
 344:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 346:	89a6                	mv	s3,s1
 348:	2485                	addiw	s1,s1,1
 34a:	0344d863          	bge	s1,s4,37a <gets+0x56>
    cc = read(0, &c, 1);
 34e:	4605                	li	a2,1
 350:	faf40593          	addi	a1,s0,-81
 354:	4501                	li	a0,0
 356:	00000097          	auipc	ra,0x0
 35a:	19c080e7          	jalr	412(ra) # 4f2 <read>
    if(cc < 1)
 35e:	00a05e63          	blez	a0,37a <gets+0x56>
    buf[i++] = c;
 362:	faf44783          	lbu	a5,-81(s0)
 366:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 36a:	01578763          	beq	a5,s5,378 <gets+0x54>
 36e:	0905                	addi	s2,s2,1
 370:	fd679be3          	bne	a5,s6,346 <gets+0x22>
  for(i=0; i+1 < max; ){
 374:	89a6                	mv	s3,s1
 376:	a011                	j	37a <gets+0x56>
 378:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 37a:	99de                	add	s3,s3,s7
 37c:	00098023          	sb	zero,0(s3)
  return buf;
}
 380:	855e                	mv	a0,s7
 382:	60e6                	ld	ra,88(sp)
 384:	6446                	ld	s0,80(sp)
 386:	64a6                	ld	s1,72(sp)
 388:	6906                	ld	s2,64(sp)
 38a:	79e2                	ld	s3,56(sp)
 38c:	7a42                	ld	s4,48(sp)
 38e:	7aa2                	ld	s5,40(sp)
 390:	7b02                	ld	s6,32(sp)
 392:	6be2                	ld	s7,24(sp)
 394:	6125                	addi	sp,sp,96
 396:	8082                	ret

0000000000000398 <stat>:

int
stat(const char *n, struct stat *st)
{
 398:	1101                	addi	sp,sp,-32
 39a:	ec06                	sd	ra,24(sp)
 39c:	e822                	sd	s0,16(sp)
 39e:	e426                	sd	s1,8(sp)
 3a0:	e04a                	sd	s2,0(sp)
 3a2:	1000                	addi	s0,sp,32
 3a4:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a6:	4581                	li	a1,0
 3a8:	00000097          	auipc	ra,0x0
 3ac:	172080e7          	jalr	370(ra) # 51a <open>
  if(fd < 0)
 3b0:	02054563          	bltz	a0,3da <stat+0x42>
 3b4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3b6:	85ca                	mv	a1,s2
 3b8:	00000097          	auipc	ra,0x0
 3bc:	17a080e7          	jalr	378(ra) # 532 <fstat>
 3c0:	892a                	mv	s2,a0
  close(fd);
 3c2:	8526                	mv	a0,s1
 3c4:	00000097          	auipc	ra,0x0
 3c8:	13e080e7          	jalr	318(ra) # 502 <close>
  return r;
}
 3cc:	854a                	mv	a0,s2
 3ce:	60e2                	ld	ra,24(sp)
 3d0:	6442                	ld	s0,16(sp)
 3d2:	64a2                	ld	s1,8(sp)
 3d4:	6902                	ld	s2,0(sp)
 3d6:	6105                	addi	sp,sp,32
 3d8:	8082                	ret
    return -1;
 3da:	597d                	li	s2,-1
 3dc:	bfc5                	j	3cc <stat+0x34>

00000000000003de <atoi>:

int
atoi(const char *s)
{
 3de:	1141                	addi	sp,sp,-16
 3e0:	e422                	sd	s0,8(sp)
 3e2:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e4:	00054603          	lbu	a2,0(a0)
 3e8:	fd06079b          	addiw	a5,a2,-48
 3ec:	0ff7f793          	zext.b	a5,a5
 3f0:	4725                	li	a4,9
 3f2:	02f76963          	bltu	a4,a5,424 <atoi+0x46>
 3f6:	86aa                	mv	a3,a0
  n = 0;
 3f8:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3fa:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3fc:	0685                	addi	a3,a3,1
 3fe:	0025179b          	slliw	a5,a0,0x2
 402:	9fa9                	addw	a5,a5,a0
 404:	0017979b          	slliw	a5,a5,0x1
 408:	9fb1                	addw	a5,a5,a2
 40a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 40e:	0006c603          	lbu	a2,0(a3)
 412:	fd06071b          	addiw	a4,a2,-48
 416:	0ff77713          	zext.b	a4,a4
 41a:	fee5f1e3          	bgeu	a1,a4,3fc <atoi+0x1e>
  return n;
}
 41e:	6422                	ld	s0,8(sp)
 420:	0141                	addi	sp,sp,16
 422:	8082                	ret
  n = 0;
 424:	4501                	li	a0,0
 426:	bfe5                	j	41e <atoi+0x40>

0000000000000428 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 428:	1141                	addi	sp,sp,-16
 42a:	e422                	sd	s0,8(sp)
 42c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 42e:	02b57463          	bgeu	a0,a1,456 <memmove+0x2e>
    while(n-- > 0)
 432:	00c05f63          	blez	a2,450 <memmove+0x28>
 436:	1602                	slli	a2,a2,0x20
 438:	9201                	srli	a2,a2,0x20
 43a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 43e:	872a                	mv	a4,a0
      *dst++ = *src++;
 440:	0585                	addi	a1,a1,1
 442:	0705                	addi	a4,a4,1
 444:	fff5c683          	lbu	a3,-1(a1)
 448:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xede6>
    while(n-- > 0)
 44c:	fee79ae3          	bne	a5,a4,440 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 450:	6422                	ld	s0,8(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret
    dst += n;
 456:	00c50733          	add	a4,a0,a2
    src += n;
 45a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 45c:	fec05ae3          	blez	a2,450 <memmove+0x28>
 460:	fff6079b          	addiw	a5,a2,-1
 464:	1782                	slli	a5,a5,0x20
 466:	9381                	srli	a5,a5,0x20
 468:	fff7c793          	not	a5,a5
 46c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 46e:	15fd                	addi	a1,a1,-1
 470:	177d                	addi	a4,a4,-1
 472:	0005c683          	lbu	a3,0(a1)
 476:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 47a:	fee79ae3          	bne	a5,a4,46e <memmove+0x46>
 47e:	bfc9                	j	450 <memmove+0x28>

0000000000000480 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 480:	1141                	addi	sp,sp,-16
 482:	e422                	sd	s0,8(sp)
 484:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 486:	ca05                	beqz	a2,4b6 <memcmp+0x36>
 488:	fff6069b          	addiw	a3,a2,-1
 48c:	1682                	slli	a3,a3,0x20
 48e:	9281                	srli	a3,a3,0x20
 490:	0685                	addi	a3,a3,1
 492:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 494:	00054783          	lbu	a5,0(a0)
 498:	0005c703          	lbu	a4,0(a1)
 49c:	00e79863          	bne	a5,a4,4ac <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4a0:	0505                	addi	a0,a0,1
    p2++;
 4a2:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4a4:	fed518e3          	bne	a0,a3,494 <memcmp+0x14>
  }
  return 0;
 4a8:	4501                	li	a0,0
 4aa:	a019                	j	4b0 <memcmp+0x30>
      return *p1 - *p2;
 4ac:	40e7853b          	subw	a0,a5,a4
}
 4b0:	6422                	ld	s0,8(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret
  return 0;
 4b6:	4501                	li	a0,0
 4b8:	bfe5                	j	4b0 <memcmp+0x30>

00000000000004ba <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e406                	sd	ra,8(sp)
 4be:	e022                	sd	s0,0(sp)
 4c0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4c2:	00000097          	auipc	ra,0x0
 4c6:	f66080e7          	jalr	-154(ra) # 428 <memmove>
}
 4ca:	60a2                	ld	ra,8(sp)
 4cc:	6402                	ld	s0,0(sp)
 4ce:	0141                	addi	sp,sp,16
 4d0:	8082                	ret

00000000000004d2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4d2:	4885                	li	a7,1
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <exit>:
.global exit
exit:
 li a7, SYS_exit
 4da:	4889                	li	a7,2
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4e2:	488d                	li	a7,3
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4ea:	4891                	li	a7,4
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <read>:
.global read
read:
 li a7, SYS_read
 4f2:	4895                	li	a7,5
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <write>:
.global write
write:
 li a7, SYS_write
 4fa:	48c1                	li	a7,16
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <close>:
.global close
close:
 li a7, SYS_close
 502:	48d5                	li	a7,21
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <kill>:
.global kill
kill:
 li a7, SYS_kill
 50a:	4899                	li	a7,6
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <exec>:
.global exec
exec:
 li a7, SYS_exec
 512:	489d                	li	a7,7
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <open>:
.global open
open:
 li a7, SYS_open
 51a:	48bd                	li	a7,15
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 522:	48c5                	li	a7,17
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 52a:	48c9                	li	a7,18
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 532:	48a1                	li	a7,8
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <link>:
.global link
link:
 li a7, SYS_link
 53a:	48cd                	li	a7,19
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 542:	48d1                	li	a7,20
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 54a:	48a5                	li	a7,9
 ecall
 54c:	00000073          	ecall
 ret
 550:	8082                	ret

0000000000000552 <dup>:
.global dup
dup:
 li a7, SYS_dup
 552:	48a9                	li	a7,10
 ecall
 554:	00000073          	ecall
 ret
 558:	8082                	ret

000000000000055a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 55a:	48ad                	li	a7,11
 ecall
 55c:	00000073          	ecall
 ret
 560:	8082                	ret

0000000000000562 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 562:	48b1                	li	a7,12
 ecall
 564:	00000073          	ecall
 ret
 568:	8082                	ret

000000000000056a <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 56a:	48b5                	li	a7,13
 ecall
 56c:	00000073          	ecall
 ret
 570:	8082                	ret

0000000000000572 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 572:	48b9                	li	a7,14
 ecall
 574:	00000073          	ecall
 ret
 578:	8082                	ret

000000000000057a <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 57a:	48d9                	li	a7,22
 ecall
 57c:	00000073          	ecall
 ret
 580:	8082                	ret

0000000000000582 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 582:	1101                	addi	sp,sp,-32
 584:	ec06                	sd	ra,24(sp)
 586:	e822                	sd	s0,16(sp)
 588:	1000                	addi	s0,sp,32
 58a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 58e:	4605                	li	a2,1
 590:	fef40593          	addi	a1,s0,-17
 594:	00000097          	auipc	ra,0x0
 598:	f66080e7          	jalr	-154(ra) # 4fa <write>
}
 59c:	60e2                	ld	ra,24(sp)
 59e:	6442                	ld	s0,16(sp)
 5a0:	6105                	addi	sp,sp,32
 5a2:	8082                	ret

00000000000005a4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5a4:	7139                	addi	sp,sp,-64
 5a6:	fc06                	sd	ra,56(sp)
 5a8:	f822                	sd	s0,48(sp)
 5aa:	f426                	sd	s1,40(sp)
 5ac:	f04a                	sd	s2,32(sp)
 5ae:	ec4e                	sd	s3,24(sp)
 5b0:	0080                	addi	s0,sp,64
 5b2:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5b4:	c299                	beqz	a3,5ba <printint+0x16>
 5b6:	0805c863          	bltz	a1,646 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5ba:	2581                	sext.w	a1,a1
  neg = 0;
 5bc:	4881                	li	a7,0
 5be:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5c2:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5c4:	2601                	sext.w	a2,a2
 5c6:	00000517          	auipc	a0,0x0
 5ca:	44250513          	addi	a0,a0,1090 # a08 <digits>
 5ce:	883a                	mv	a6,a4
 5d0:	2705                	addiw	a4,a4,1
 5d2:	02c5f7bb          	remuw	a5,a1,a2
 5d6:	1782                	slli	a5,a5,0x20
 5d8:	9381                	srli	a5,a5,0x20
 5da:	97aa                	add	a5,a5,a0
 5dc:	0007c783          	lbu	a5,0(a5)
 5e0:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5e4:	0005879b          	sext.w	a5,a1
 5e8:	02c5d5bb          	divuw	a1,a1,a2
 5ec:	0685                	addi	a3,a3,1
 5ee:	fec7f0e3          	bgeu	a5,a2,5ce <printint+0x2a>
  if(neg)
 5f2:	00088b63          	beqz	a7,608 <printint+0x64>
    buf[i++] = '-';
 5f6:	fd040793          	addi	a5,s0,-48
 5fa:	973e                	add	a4,a4,a5
 5fc:	02d00793          	li	a5,45
 600:	fef70823          	sb	a5,-16(a4)
 604:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 608:	02e05863          	blez	a4,638 <printint+0x94>
 60c:	fc040793          	addi	a5,s0,-64
 610:	00e78933          	add	s2,a5,a4
 614:	fff78993          	addi	s3,a5,-1
 618:	99ba                	add	s3,s3,a4
 61a:	377d                	addiw	a4,a4,-1
 61c:	1702                	slli	a4,a4,0x20
 61e:	9301                	srli	a4,a4,0x20
 620:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 624:	fff94583          	lbu	a1,-1(s2)
 628:	8526                	mv	a0,s1
 62a:	00000097          	auipc	ra,0x0
 62e:	f58080e7          	jalr	-168(ra) # 582 <putc>
  while(--i >= 0)
 632:	197d                	addi	s2,s2,-1
 634:	ff3918e3          	bne	s2,s3,624 <printint+0x80>
}
 638:	70e2                	ld	ra,56(sp)
 63a:	7442                	ld	s0,48(sp)
 63c:	74a2                	ld	s1,40(sp)
 63e:	7902                	ld	s2,32(sp)
 640:	69e2                	ld	s3,24(sp)
 642:	6121                	addi	sp,sp,64
 644:	8082                	ret
    x = -xx;
 646:	40b005bb          	negw	a1,a1
    neg = 1;
 64a:	4885                	li	a7,1
    x = -xx;
 64c:	bf8d                	j	5be <printint+0x1a>

000000000000064e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 64e:	7119                	addi	sp,sp,-128
 650:	fc86                	sd	ra,120(sp)
 652:	f8a2                	sd	s0,112(sp)
 654:	f4a6                	sd	s1,104(sp)
 656:	f0ca                	sd	s2,96(sp)
 658:	ecce                	sd	s3,88(sp)
 65a:	e8d2                	sd	s4,80(sp)
 65c:	e4d6                	sd	s5,72(sp)
 65e:	e0da                	sd	s6,64(sp)
 660:	fc5e                	sd	s7,56(sp)
 662:	f862                	sd	s8,48(sp)
 664:	f466                	sd	s9,40(sp)
 666:	f06a                	sd	s10,32(sp)
 668:	ec6e                	sd	s11,24(sp)
 66a:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 66c:	0005c903          	lbu	s2,0(a1)
 670:	18090f63          	beqz	s2,80e <vprintf+0x1c0>
 674:	8aaa                	mv	s5,a0
 676:	8b32                	mv	s6,a2
 678:	00158493          	addi	s1,a1,1
  state = 0;
 67c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 67e:	02500a13          	li	s4,37
      if(c == 'd'){
 682:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 686:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 68a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 68e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 692:	00000b97          	auipc	s7,0x0
 696:	376b8b93          	addi	s7,s7,886 # a08 <digits>
 69a:	a839                	j	6b8 <vprintf+0x6a>
        putc(fd, c);
 69c:	85ca                	mv	a1,s2
 69e:	8556                	mv	a0,s5
 6a0:	00000097          	auipc	ra,0x0
 6a4:	ee2080e7          	jalr	-286(ra) # 582 <putc>
 6a8:	a019                	j	6ae <vprintf+0x60>
    } else if(state == '%'){
 6aa:	01498f63          	beq	s3,s4,6c8 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6ae:	0485                	addi	s1,s1,1
 6b0:	fff4c903          	lbu	s2,-1(s1)
 6b4:	14090d63          	beqz	s2,80e <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6b8:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6bc:	fe0997e3          	bnez	s3,6aa <vprintf+0x5c>
      if(c == '%'){
 6c0:	fd479ee3          	bne	a5,s4,69c <vprintf+0x4e>
        state = '%';
 6c4:	89be                	mv	s3,a5
 6c6:	b7e5                	j	6ae <vprintf+0x60>
      if(c == 'd'){
 6c8:	05878063          	beq	a5,s8,708 <vprintf+0xba>
      } else if(c == 'l') {
 6cc:	05978c63          	beq	a5,s9,724 <vprintf+0xd6>
      } else if(c == 'x') {
 6d0:	07a78863          	beq	a5,s10,740 <vprintf+0xf2>
      } else if(c == 'p') {
 6d4:	09b78463          	beq	a5,s11,75c <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6d8:	07300713          	li	a4,115
 6dc:	0ce78663          	beq	a5,a4,7a8 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6e0:	06300713          	li	a4,99
 6e4:	0ee78e63          	beq	a5,a4,7e0 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6e8:	11478863          	beq	a5,s4,7f8 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ec:	85d2                	mv	a1,s4
 6ee:	8556                	mv	a0,s5
 6f0:	00000097          	auipc	ra,0x0
 6f4:	e92080e7          	jalr	-366(ra) # 582 <putc>
        putc(fd, c);
 6f8:	85ca                	mv	a1,s2
 6fa:	8556                	mv	a0,s5
 6fc:	00000097          	auipc	ra,0x0
 700:	e86080e7          	jalr	-378(ra) # 582 <putc>
      }
      state = 0;
 704:	4981                	li	s3,0
 706:	b765                	j	6ae <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 708:	008b0913          	addi	s2,s6,8
 70c:	4685                	li	a3,1
 70e:	4629                	li	a2,10
 710:	000b2583          	lw	a1,0(s6)
 714:	8556                	mv	a0,s5
 716:	00000097          	auipc	ra,0x0
 71a:	e8e080e7          	jalr	-370(ra) # 5a4 <printint>
 71e:	8b4a                	mv	s6,s2
      state = 0;
 720:	4981                	li	s3,0
 722:	b771                	j	6ae <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 724:	008b0913          	addi	s2,s6,8
 728:	4681                	li	a3,0
 72a:	4629                	li	a2,10
 72c:	000b2583          	lw	a1,0(s6)
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	e72080e7          	jalr	-398(ra) # 5a4 <printint>
 73a:	8b4a                	mv	s6,s2
      state = 0;
 73c:	4981                	li	s3,0
 73e:	bf85                	j	6ae <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 740:	008b0913          	addi	s2,s6,8
 744:	4681                	li	a3,0
 746:	4641                	li	a2,16
 748:	000b2583          	lw	a1,0(s6)
 74c:	8556                	mv	a0,s5
 74e:	00000097          	auipc	ra,0x0
 752:	e56080e7          	jalr	-426(ra) # 5a4 <printint>
 756:	8b4a                	mv	s6,s2
      state = 0;
 758:	4981                	li	s3,0
 75a:	bf91                	j	6ae <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 75c:	008b0793          	addi	a5,s6,8
 760:	f8f43423          	sd	a5,-120(s0)
 764:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 768:	03000593          	li	a1,48
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	e14080e7          	jalr	-492(ra) # 582 <putc>
  putc(fd, 'x');
 776:	85ea                	mv	a1,s10
 778:	8556                	mv	a0,s5
 77a:	00000097          	auipc	ra,0x0
 77e:	e08080e7          	jalr	-504(ra) # 582 <putc>
 782:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 784:	03c9d793          	srli	a5,s3,0x3c
 788:	97de                	add	a5,a5,s7
 78a:	0007c583          	lbu	a1,0(a5)
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	df2080e7          	jalr	-526(ra) # 582 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 798:	0992                	slli	s3,s3,0x4
 79a:	397d                	addiw	s2,s2,-1
 79c:	fe0914e3          	bnez	s2,784 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7a0:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	b721                	j	6ae <vprintf+0x60>
        s = va_arg(ap, char*);
 7a8:	008b0993          	addi	s3,s6,8
 7ac:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7b0:	02090163          	beqz	s2,7d2 <vprintf+0x184>
        while(*s != 0){
 7b4:	00094583          	lbu	a1,0(s2)
 7b8:	c9a1                	beqz	a1,808 <vprintf+0x1ba>
          putc(fd, *s);
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	dc6080e7          	jalr	-570(ra) # 582 <putc>
          s++;
 7c4:	0905                	addi	s2,s2,1
        while(*s != 0){
 7c6:	00094583          	lbu	a1,0(s2)
 7ca:	f9e5                	bnez	a1,7ba <vprintf+0x16c>
        s = va_arg(ap, char*);
 7cc:	8b4e                	mv	s6,s3
      state = 0;
 7ce:	4981                	li	s3,0
 7d0:	bdf9                	j	6ae <vprintf+0x60>
          s = "(null)";
 7d2:	00000917          	auipc	s2,0x0
 7d6:	22e90913          	addi	s2,s2,558 # a00 <malloc+0xe8>
        while(*s != 0){
 7da:	02800593          	li	a1,40
 7de:	bff1                	j	7ba <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7e0:	008b0913          	addi	s2,s6,8
 7e4:	000b4583          	lbu	a1,0(s6)
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	d98080e7          	jalr	-616(ra) # 582 <putc>
 7f2:	8b4a                	mv	s6,s2
      state = 0;
 7f4:	4981                	li	s3,0
 7f6:	bd65                	j	6ae <vprintf+0x60>
        putc(fd, c);
 7f8:	85d2                	mv	a1,s4
 7fa:	8556                	mv	a0,s5
 7fc:	00000097          	auipc	ra,0x0
 800:	d86080e7          	jalr	-634(ra) # 582 <putc>
      state = 0;
 804:	4981                	li	s3,0
 806:	b565                	j	6ae <vprintf+0x60>
        s = va_arg(ap, char*);
 808:	8b4e                	mv	s6,s3
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b54d                	j	6ae <vprintf+0x60>
    }
  }
}
 80e:	70e6                	ld	ra,120(sp)
 810:	7446                	ld	s0,112(sp)
 812:	74a6                	ld	s1,104(sp)
 814:	7906                	ld	s2,96(sp)
 816:	69e6                	ld	s3,88(sp)
 818:	6a46                	ld	s4,80(sp)
 81a:	6aa6                	ld	s5,72(sp)
 81c:	6b06                	ld	s6,64(sp)
 81e:	7be2                	ld	s7,56(sp)
 820:	7c42                	ld	s8,48(sp)
 822:	7ca2                	ld	s9,40(sp)
 824:	7d02                	ld	s10,32(sp)
 826:	6de2                	ld	s11,24(sp)
 828:	6109                	addi	sp,sp,128
 82a:	8082                	ret

000000000000082c <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 82c:	715d                	addi	sp,sp,-80
 82e:	ec06                	sd	ra,24(sp)
 830:	e822                	sd	s0,16(sp)
 832:	1000                	addi	s0,sp,32
 834:	e010                	sd	a2,0(s0)
 836:	e414                	sd	a3,8(s0)
 838:	e818                	sd	a4,16(s0)
 83a:	ec1c                	sd	a5,24(s0)
 83c:	03043023          	sd	a6,32(s0)
 840:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 844:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 848:	8622                	mv	a2,s0
 84a:	00000097          	auipc	ra,0x0
 84e:	e04080e7          	jalr	-508(ra) # 64e <vprintf>
}
 852:	60e2                	ld	ra,24(sp)
 854:	6442                	ld	s0,16(sp)
 856:	6161                	addi	sp,sp,80
 858:	8082                	ret

000000000000085a <printf>:

void
printf(const char *fmt, ...)
{
 85a:	711d                	addi	sp,sp,-96
 85c:	ec06                	sd	ra,24(sp)
 85e:	e822                	sd	s0,16(sp)
 860:	1000                	addi	s0,sp,32
 862:	e40c                	sd	a1,8(s0)
 864:	e810                	sd	a2,16(s0)
 866:	ec14                	sd	a3,24(s0)
 868:	f018                	sd	a4,32(s0)
 86a:	f41c                	sd	a5,40(s0)
 86c:	03043823          	sd	a6,48(s0)
 870:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 874:	00840613          	addi	a2,s0,8
 878:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 87c:	85aa                	mv	a1,a0
 87e:	4505                	li	a0,1
 880:	00000097          	auipc	ra,0x0
 884:	dce080e7          	jalr	-562(ra) # 64e <vprintf>
}
 888:	60e2                	ld	ra,24(sp)
 88a:	6442                	ld	s0,16(sp)
 88c:	6125                	addi	sp,sp,96
 88e:	8082                	ret

0000000000000890 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 890:	1141                	addi	sp,sp,-16
 892:	e422                	sd	s0,8(sp)
 894:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 896:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89a:	00000797          	auipc	a5,0x0
 89e:	1867b783          	ld	a5,390(a5) # a20 <freep>
 8a2:	a805                	j	8d2 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a4:	4618                	lw	a4,8(a2)
 8a6:	9db9                	addw	a1,a1,a4
 8a8:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ac:	6398                	ld	a4,0(a5)
 8ae:	6318                	ld	a4,0(a4)
 8b0:	fee53823          	sd	a4,-16(a0)
 8b4:	a091                	j	8f8 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b6:	ff852703          	lw	a4,-8(a0)
 8ba:	9e39                	addw	a2,a2,a4
 8bc:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8be:	ff053703          	ld	a4,-16(a0)
 8c2:	e398                	sd	a4,0(a5)
 8c4:	a099                	j	90a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c6:	6398                	ld	a4,0(a5)
 8c8:	00e7e463          	bltu	a5,a4,8d0 <free+0x40>
 8cc:	00e6ea63          	bltu	a3,a4,8e0 <free+0x50>
{
 8d0:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d2:	fed7fae3          	bgeu	a5,a3,8c6 <free+0x36>
 8d6:	6398                	ld	a4,0(a5)
 8d8:	00e6e463          	bltu	a3,a4,8e0 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8dc:	fee7eae3          	bltu	a5,a4,8d0 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8e0:	ff852583          	lw	a1,-8(a0)
 8e4:	6390                	ld	a2,0(a5)
 8e6:	02059813          	slli	a6,a1,0x20
 8ea:	01c85713          	srli	a4,a6,0x1c
 8ee:	9736                	add	a4,a4,a3
 8f0:	fae60ae3          	beq	a2,a4,8a4 <free+0x14>
    bp->s.ptr = p->s.ptr;
 8f4:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f8:	4790                	lw	a2,8(a5)
 8fa:	02061593          	slli	a1,a2,0x20
 8fe:	01c5d713          	srli	a4,a1,0x1c
 902:	973e                	add	a4,a4,a5
 904:	fae689e3          	beq	a3,a4,8b6 <free+0x26>
  } else
    p->s.ptr = bp;
 908:	e394                	sd	a3,0(a5)
  freep = p;
 90a:	00000717          	auipc	a4,0x0
 90e:	10f73b23          	sd	a5,278(a4) # a20 <freep>
}
 912:	6422                	ld	s0,8(sp)
 914:	0141                	addi	sp,sp,16
 916:	8082                	ret

0000000000000918 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 918:	7139                	addi	sp,sp,-64
 91a:	fc06                	sd	ra,56(sp)
 91c:	f822                	sd	s0,48(sp)
 91e:	f426                	sd	s1,40(sp)
 920:	f04a                	sd	s2,32(sp)
 922:	ec4e                	sd	s3,24(sp)
 924:	e852                	sd	s4,16(sp)
 926:	e456                	sd	s5,8(sp)
 928:	e05a                	sd	s6,0(sp)
 92a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 92c:	02051493          	slli	s1,a0,0x20
 930:	9081                	srli	s1,s1,0x20
 932:	04bd                	addi	s1,s1,15
 934:	8091                	srli	s1,s1,0x4
 936:	0014899b          	addiw	s3,s1,1
 93a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 93c:	00000517          	auipc	a0,0x0
 940:	0e453503          	ld	a0,228(a0) # a20 <freep>
 944:	c515                	beqz	a0,970 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 946:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 948:	4798                	lw	a4,8(a5)
 94a:	02977f63          	bgeu	a4,s1,988 <malloc+0x70>
 94e:	8a4e                	mv	s4,s3
 950:	0009871b          	sext.w	a4,s3
 954:	6685                	lui	a3,0x1
 956:	00d77363          	bgeu	a4,a3,95c <malloc+0x44>
 95a:	6a05                	lui	s4,0x1
 95c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 960:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 964:	00000917          	auipc	s2,0x0
 968:	0bc90913          	addi	s2,s2,188 # a20 <freep>
  if(p == (char*)-1)
 96c:	5afd                	li	s5,-1
 96e:	a895                	j	9e2 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 970:	00000797          	auipc	a5,0x0
 974:	1a878793          	addi	a5,a5,424 # b18 <base>
 978:	00000717          	auipc	a4,0x0
 97c:	0af73423          	sd	a5,168(a4) # a20 <freep>
 980:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 982:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 986:	b7e1                	j	94e <malloc+0x36>
      if(p->s.size == nunits)
 988:	02e48c63          	beq	s1,a4,9c0 <malloc+0xa8>
        p->s.size -= nunits;
 98c:	4137073b          	subw	a4,a4,s3
 990:	c798                	sw	a4,8(a5)
        p += p->s.size;
 992:	02071693          	slli	a3,a4,0x20
 996:	01c6d713          	srli	a4,a3,0x1c
 99a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 99c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9a0:	00000717          	auipc	a4,0x0
 9a4:	08a73023          	sd	a0,128(a4) # a20 <freep>
      return (void*)(p + 1);
 9a8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ac:	70e2                	ld	ra,56(sp)
 9ae:	7442                	ld	s0,48(sp)
 9b0:	74a2                	ld	s1,40(sp)
 9b2:	7902                	ld	s2,32(sp)
 9b4:	69e2                	ld	s3,24(sp)
 9b6:	6a42                	ld	s4,16(sp)
 9b8:	6aa2                	ld	s5,8(sp)
 9ba:	6b02                	ld	s6,0(sp)
 9bc:	6121                	addi	sp,sp,64
 9be:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9c0:	6398                	ld	a4,0(a5)
 9c2:	e118                	sd	a4,0(a0)
 9c4:	bff1                	j	9a0 <malloc+0x88>
  hp->s.size = nu;
 9c6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ca:	0541                	addi	a0,a0,16
 9cc:	00000097          	auipc	ra,0x0
 9d0:	ec4080e7          	jalr	-316(ra) # 890 <free>
  return freep;
 9d4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9d8:	d971                	beqz	a0,9ac <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9da:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9dc:	4798                	lw	a4,8(a5)
 9de:	fa9775e3          	bgeu	a4,s1,988 <malloc+0x70>
    if(p == freep)
 9e2:	00093703          	ld	a4,0(s2)
 9e6:	853e                	mv	a0,a5
 9e8:	fef719e3          	bne	a4,a5,9da <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9ec:	8552                	mv	a0,s4
 9ee:	00000097          	auipc	ra,0x0
 9f2:	b74080e7          	jalr	-1164(ra) # 562 <sbrk>
  if(p == (char*)-1)
 9f6:	fd5518e3          	bne	a0,s5,9c6 <malloc+0xae>
        return 0;
 9fa:	4501                	li	a0,0
 9fc:	bf45                	j	9ac <malloc+0x94>
