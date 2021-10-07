
user/_first:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main()
{  
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
    fprintf(1, "My first xv6 program\n");  
   8:	00001597          	auipc	a1,0x1
   c:	9f058593          	addi	a1,a1,-1552 # 9f8 <malloc+0xea>
  10:	4505                	li	a0,1
  12:	00001097          	auipc	ra,0x1
  16:	810080e7          	jalr	-2032(ra) # 822 <fprintf>
    fprintf(1, "An int occupies %d bytes.\n", sizeof(int)); 
  1a:	4611                	li	a2,4
  1c:	00001597          	auipc	a1,0x1
  20:	9f458593          	addi	a1,a1,-1548 # a10 <malloc+0x102>
  24:	4505                	li	a0,1
  26:	00000097          	auipc	ra,0x0
  2a:	7fc080e7          	jalr	2044(ra) # 822 <fprintf>
    exit(0);
  2e:	4501                	li	a0,0
  30:	00000097          	auipc	ra,0x0
  34:	4a0080e7          	jalr	1184(ra) # 4d0 <exit>

0000000000000038 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  38:	1141                	addi	sp,sp,-16
  3a:	e422                	sd	s0,8(sp)
  3c:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  3e:	0f50000f          	fence	iorw,ow
  42:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  46:	6422                	ld	s0,8(sp)
  48:	0141                	addi	sp,sp,16
  4a:	8082                	ret

000000000000004c <load>:

int load(uint64 *p) {
  4c:	1141                	addi	sp,sp,-16
  4e:	e422                	sd	s0,8(sp)
  50:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  52:	0ff0000f          	fence
  56:	6108                	ld	a0,0(a0)
  58:	0ff0000f          	fence
}
  5c:	2501                	sext.w	a0,a0
  5e:	6422                	ld	s0,8(sp)
  60:	0141                	addi	sp,sp,16
  62:	8082                	ret

0000000000000064 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
  64:	7179                	addi	sp,sp,-48
  66:	f406                	sd	ra,40(sp)
  68:	f022                	sd	s0,32(sp)
  6a:	ec26                	sd	s1,24(sp)
  6c:	e84a                	sd	s2,16(sp)
  6e:	e44e                	sd	s3,8(sp)
  70:	e052                	sd	s4,0(sp)
  72:	1800                	addi	s0,sp,48
  74:	8a2a                	mv	s4,a0
  76:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  78:	4785                	li	a5,1
  7a:	00001497          	auipc	s1,0x1
  7e:	9ee48493          	addi	s1,s1,-1554 # a68 <rings+0x10>
  82:	00001917          	auipc	s2,0x1
  86:	ad690913          	addi	s2,s2,-1322 # b58 <__BSS_END__>
  8a:	04f59563          	bne	a1,a5,d4 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  8e:	00001497          	auipc	s1,0x1
  92:	9da4a483          	lw	s1,-1574(s1) # a68 <rings+0x10>
  96:	c099                	beqz	s1,9c <create_or_close_the_buffer_user+0x38>
  98:	4481                	li	s1,0
  9a:	a899                	j	f0 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  9c:	00001917          	auipc	s2,0x1
  a0:	9bc90913          	addi	s2,s2,-1604 # a58 <rings>
  a4:	00093603          	ld	a2,0(s2)
  a8:	4585                	li	a1,1
  aa:	00000097          	auipc	ra,0x0
  ae:	4c6080e7          	jalr	1222(ra) # 570 <ringbuf>
        rings[i].book->write_done = 0;
  b2:	00893783          	ld	a5,8(s2)
  b6:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
  ba:	00893783          	ld	a5,8(s2)
  be:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
  c2:	01092783          	lw	a5,16(s2)
  c6:	2785                	addiw	a5,a5,1
  c8:	00f92823          	sw	a5,16(s2)
        break;
  cc:	a015                	j	f0 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
  ce:	04e1                	addi	s1,s1,24
  d0:	01248f63          	beq	s1,s2,ee <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
  d4:	409c                	lw	a5,0(s1)
  d6:	dfe5                	beqz	a5,ce <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
  d8:	ff04b603          	ld	a2,-16(s1)
  dc:	85ce                	mv	a1,s3
  de:	8552                	mv	a0,s4
  e0:	00000097          	auipc	ra,0x0
  e4:	490080e7          	jalr	1168(ra) # 570 <ringbuf>
        rings[i].exists = 0;
  e8:	0004a023          	sw	zero,0(s1)
  ec:	b7cd                	j	ce <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
  ee:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
  f0:	8526                	mv	a0,s1
  f2:	70a2                	ld	ra,40(sp)
  f4:	7402                	ld	s0,32(sp)
  f6:	64e2                	ld	s1,24(sp)
  f8:	6942                	ld	s2,16(sp)
  fa:	69a2                	ld	s3,8(sp)
  fc:	6a02                	ld	s4,0(sp)
  fe:	6145                	addi	sp,sp,48
 100:	8082                	ret

0000000000000102 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 102:	1101                	addi	sp,sp,-32
 104:	ec06                	sd	ra,24(sp)
 106:	e822                	sd	s0,16(sp)
 108:	e426                	sd	s1,8(sp)
 10a:	1000                	addi	s0,sp,32
 10c:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 10e:	00151793          	slli	a5,a0,0x1
 112:	97aa                	add	a5,a5,a0
 114:	078e                	slli	a5,a5,0x3
 116:	00001717          	auipc	a4,0x1
 11a:	94270713          	addi	a4,a4,-1726 # a58 <rings>
 11e:	97ba                	add	a5,a5,a4
 120:	639c                	ld	a5,0(a5)
 122:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 124:	421c                	lw	a5,0(a2)
 126:	e785                	bnez	a5,14e <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 128:	86ba                	mv	a3,a4
 12a:	671c                	ld	a5,8(a4)
 12c:	6398                	ld	a4,0(a5)
 12e:	67c1                	lui	a5,0x10
 130:	9fb9                	addw	a5,a5,a4
 132:	00151713          	slli	a4,a0,0x1
 136:	953a                	add	a0,a0,a4
 138:	050e                	slli	a0,a0,0x3
 13a:	9536                	add	a0,a0,a3
 13c:	6518                	ld	a4,8(a0)
 13e:	6718                	ld	a4,8(a4)
 140:	9f99                	subw	a5,a5,a4
 142:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 144:	60e2                	ld	ra,24(sp)
 146:	6442                	ld	s0,16(sp)
 148:	64a2                	ld	s1,8(sp)
 14a:	6105                	addi	sp,sp,32
 14c:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 14e:	00151793          	slli	a5,a0,0x1
 152:	953e                	add	a0,a0,a5
 154:	050e                	slli	a0,a0,0x3
 156:	00001797          	auipc	a5,0x1
 15a:	90278793          	addi	a5,a5,-1790 # a58 <rings>
 15e:	953e                	add	a0,a0,a5
 160:	6508                	ld	a0,8(a0)
 162:	0521                	addi	a0,a0,8
 164:	00000097          	auipc	ra,0x0
 168:	ee8080e7          	jalr	-280(ra) # 4c <load>
 16c:	c088                	sw	a0,0(s1)
}
 16e:	bfd9                	j	144 <ringbuf_start_write+0x42>

0000000000000170 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 170:	1141                	addi	sp,sp,-16
 172:	e406                	sd	ra,8(sp)
 174:	e022                	sd	s0,0(sp)
 176:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 178:	00151793          	slli	a5,a0,0x1
 17c:	97aa                	add	a5,a5,a0
 17e:	078e                	slli	a5,a5,0x3
 180:	00001517          	auipc	a0,0x1
 184:	8d850513          	addi	a0,a0,-1832 # a58 <rings>
 188:	97aa                	add	a5,a5,a0
 18a:	6788                	ld	a0,8(a5)
 18c:	0035959b          	slliw	a1,a1,0x3
 190:	0521                	addi	a0,a0,8
 192:	00000097          	auipc	ra,0x0
 196:	ea6080e7          	jalr	-346(ra) # 38 <store>
}
 19a:	60a2                	ld	ra,8(sp)
 19c:	6402                	ld	s0,0(sp)
 19e:	0141                	addi	sp,sp,16
 1a0:	8082                	ret

00000000000001a2 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1a2:	1101                	addi	sp,sp,-32
 1a4:	ec06                	sd	ra,24(sp)
 1a6:	e822                	sd	s0,16(sp)
 1a8:	e426                	sd	s1,8(sp)
 1aa:	1000                	addi	s0,sp,32
 1ac:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1ae:	00151793          	slli	a5,a0,0x1
 1b2:	97aa                	add	a5,a5,a0
 1b4:	078e                	slli	a5,a5,0x3
 1b6:	00001517          	auipc	a0,0x1
 1ba:	8a250513          	addi	a0,a0,-1886 # a58 <rings>
 1be:	97aa                	add	a5,a5,a0
 1c0:	6788                	ld	a0,8(a5)
 1c2:	0521                	addi	a0,a0,8
 1c4:	00000097          	auipc	ra,0x0
 1c8:	e88080e7          	jalr	-376(ra) # 4c <load>
 1cc:	c088                	sw	a0,0(s1)
}
 1ce:	60e2                	ld	ra,24(sp)
 1d0:	6442                	ld	s0,16(sp)
 1d2:	64a2                	ld	s1,8(sp)
 1d4:	6105                	addi	sp,sp,32
 1d6:	8082                	ret

00000000000001d8 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 1d8:	1101                	addi	sp,sp,-32
 1da:	ec06                	sd	ra,24(sp)
 1dc:	e822                	sd	s0,16(sp)
 1de:	e426                	sd	s1,8(sp)
 1e0:	1000                	addi	s0,sp,32
 1e2:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 1e4:	00151793          	slli	a5,a0,0x1
 1e8:	97aa                	add	a5,a5,a0
 1ea:	078e                	slli	a5,a5,0x3
 1ec:	00001517          	auipc	a0,0x1
 1f0:	86c50513          	addi	a0,a0,-1940 # a58 <rings>
 1f4:	97aa                	add	a5,a5,a0
 1f6:	6788                	ld	a0,8(a5)
 1f8:	611c                	ld	a5,0(a0)
 1fa:	ef99                	bnez	a5,218 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 1fc:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 1fe:	41f7579b          	sraiw	a5,a4,0x1f
 202:	01d7d79b          	srliw	a5,a5,0x1d
 206:	9fb9                	addw	a5,a5,a4
 208:	4037d79b          	sraiw	a5,a5,0x3
 20c:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 20e:	60e2                	ld	ra,24(sp)
 210:	6442                	ld	s0,16(sp)
 212:	64a2                	ld	s1,8(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 218:	00000097          	auipc	ra,0x0
 21c:	e34080e7          	jalr	-460(ra) # 4c <load>
    *bytes /= 8;
 220:	41f5579b          	sraiw	a5,a0,0x1f
 224:	01d7d79b          	srliw	a5,a5,0x1d
 228:	9d3d                	addw	a0,a0,a5
 22a:	4035551b          	sraiw	a0,a0,0x3
 22e:	c088                	sw	a0,0(s1)
}
 230:	bff9                	j	20e <ringbuf_start_read+0x36>

0000000000000232 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 232:	1141                	addi	sp,sp,-16
 234:	e406                	sd	ra,8(sp)
 236:	e022                	sd	s0,0(sp)
 238:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 23a:	00151793          	slli	a5,a0,0x1
 23e:	97aa                	add	a5,a5,a0
 240:	078e                	slli	a5,a5,0x3
 242:	00001517          	auipc	a0,0x1
 246:	81650513          	addi	a0,a0,-2026 # a58 <rings>
 24a:	97aa                	add	a5,a5,a0
 24c:	0035959b          	slliw	a1,a1,0x3
 250:	6788                	ld	a0,8(a5)
 252:	00000097          	auipc	ra,0x0
 256:	de6080e7          	jalr	-538(ra) # 38 <store>
}
 25a:	60a2                	ld	ra,8(sp)
 25c:	6402                	ld	s0,0(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret

0000000000000262 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 262:	1141                	addi	sp,sp,-16
 264:	e422                	sd	s0,8(sp)
 266:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 268:	87aa                	mv	a5,a0
 26a:	0585                	addi	a1,a1,1
 26c:	0785                	addi	a5,a5,1
 26e:	fff5c703          	lbu	a4,-1(a1)
 272:	fee78fa3          	sb	a4,-1(a5)
 276:	fb75                	bnez	a4,26a <strcpy+0x8>
    ;
  return os;
}
 278:	6422                	ld	s0,8(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 284:	00054783          	lbu	a5,0(a0)
 288:	cb91                	beqz	a5,29c <strcmp+0x1e>
 28a:	0005c703          	lbu	a4,0(a1)
 28e:	00f71763          	bne	a4,a5,29c <strcmp+0x1e>
    p++, q++;
 292:	0505                	addi	a0,a0,1
 294:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 296:	00054783          	lbu	a5,0(a0)
 29a:	fbe5                	bnez	a5,28a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 29c:	0005c503          	lbu	a0,0(a1)
}
 2a0:	40a7853b          	subw	a0,a5,a0
 2a4:	6422                	ld	s0,8(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret

00000000000002aa <strlen>:

uint
strlen(const char *s)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	cf91                	beqz	a5,2d0 <strlen+0x26>
 2b6:	0505                	addi	a0,a0,1
 2b8:	87aa                	mv	a5,a0
 2ba:	4685                	li	a3,1
 2bc:	9e89                	subw	a3,a3,a0
 2be:	00f6853b          	addw	a0,a3,a5
 2c2:	0785                	addi	a5,a5,1
 2c4:	fff7c703          	lbu	a4,-1(a5)
 2c8:	fb7d                	bnez	a4,2be <strlen+0x14>
    ;
  return n;
}
 2ca:	6422                	ld	s0,8(sp)
 2cc:	0141                	addi	sp,sp,16
 2ce:	8082                	ret
  for(n = 0; s[n]; n++)
 2d0:	4501                	li	a0,0
 2d2:	bfe5                	j	2ca <strlen+0x20>

00000000000002d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e422                	sd	s0,8(sp)
 2d8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2da:	ca19                	beqz	a2,2f0 <memset+0x1c>
 2dc:	87aa                	mv	a5,a0
 2de:	1602                	slli	a2,a2,0x20
 2e0:	9201                	srli	a2,a2,0x20
 2e2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2e6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2ea:	0785                	addi	a5,a5,1
 2ec:	fee79de3          	bne	a5,a4,2e6 <memset+0x12>
  }
  return dst;
}
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <strchr>:

char*
strchr(const char *s, char c)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2fc:	00054783          	lbu	a5,0(a0)
 300:	cb99                	beqz	a5,316 <strchr+0x20>
    if(*s == c)
 302:	00f58763          	beq	a1,a5,310 <strchr+0x1a>
  for(; *s; s++)
 306:	0505                	addi	a0,a0,1
 308:	00054783          	lbu	a5,0(a0)
 30c:	fbfd                	bnez	a5,302 <strchr+0xc>
      return (char*)s;
  return 0;
 30e:	4501                	li	a0,0
}
 310:	6422                	ld	s0,8(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret
  return 0;
 316:	4501                	li	a0,0
 318:	bfe5                	j	310 <strchr+0x1a>

000000000000031a <gets>:

char*
gets(char *buf, int max)
{
 31a:	711d                	addi	sp,sp,-96
 31c:	ec86                	sd	ra,88(sp)
 31e:	e8a2                	sd	s0,80(sp)
 320:	e4a6                	sd	s1,72(sp)
 322:	e0ca                	sd	s2,64(sp)
 324:	fc4e                	sd	s3,56(sp)
 326:	f852                	sd	s4,48(sp)
 328:	f456                	sd	s5,40(sp)
 32a:	f05a                	sd	s6,32(sp)
 32c:	ec5e                	sd	s7,24(sp)
 32e:	1080                	addi	s0,sp,96
 330:	8baa                	mv	s7,a0
 332:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 334:	892a                	mv	s2,a0
 336:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 338:	4aa9                	li	s5,10
 33a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 33c:	89a6                	mv	s3,s1
 33e:	2485                	addiw	s1,s1,1
 340:	0344d863          	bge	s1,s4,370 <gets+0x56>
    cc = read(0, &c, 1);
 344:	4605                	li	a2,1
 346:	faf40593          	addi	a1,s0,-81
 34a:	4501                	li	a0,0
 34c:	00000097          	auipc	ra,0x0
 350:	19c080e7          	jalr	412(ra) # 4e8 <read>
    if(cc < 1)
 354:	00a05e63          	blez	a0,370 <gets+0x56>
    buf[i++] = c;
 358:	faf44783          	lbu	a5,-81(s0)
 35c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 360:	01578763          	beq	a5,s5,36e <gets+0x54>
 364:	0905                	addi	s2,s2,1
 366:	fd679be3          	bne	a5,s6,33c <gets+0x22>
  for(i=0; i+1 < max; ){
 36a:	89a6                	mv	s3,s1
 36c:	a011                	j	370 <gets+0x56>
 36e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 370:	99de                	add	s3,s3,s7
 372:	00098023          	sb	zero,0(s3)
  return buf;
}
 376:	855e                	mv	a0,s7
 378:	60e6                	ld	ra,88(sp)
 37a:	6446                	ld	s0,80(sp)
 37c:	64a6                	ld	s1,72(sp)
 37e:	6906                	ld	s2,64(sp)
 380:	79e2                	ld	s3,56(sp)
 382:	7a42                	ld	s4,48(sp)
 384:	7aa2                	ld	s5,40(sp)
 386:	7b02                	ld	s6,32(sp)
 388:	6be2                	ld	s7,24(sp)
 38a:	6125                	addi	sp,sp,96
 38c:	8082                	ret

000000000000038e <stat>:

int
stat(const char *n, struct stat *st)
{
 38e:	1101                	addi	sp,sp,-32
 390:	ec06                	sd	ra,24(sp)
 392:	e822                	sd	s0,16(sp)
 394:	e426                	sd	s1,8(sp)
 396:	e04a                	sd	s2,0(sp)
 398:	1000                	addi	s0,sp,32
 39a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 39c:	4581                	li	a1,0
 39e:	00000097          	auipc	ra,0x0
 3a2:	172080e7          	jalr	370(ra) # 510 <open>
  if(fd < 0)
 3a6:	02054563          	bltz	a0,3d0 <stat+0x42>
 3aa:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3ac:	85ca                	mv	a1,s2
 3ae:	00000097          	auipc	ra,0x0
 3b2:	17a080e7          	jalr	378(ra) # 528 <fstat>
 3b6:	892a                	mv	s2,a0
  close(fd);
 3b8:	8526                	mv	a0,s1
 3ba:	00000097          	auipc	ra,0x0
 3be:	13e080e7          	jalr	318(ra) # 4f8 <close>
  return r;
}
 3c2:	854a                	mv	a0,s2
 3c4:	60e2                	ld	ra,24(sp)
 3c6:	6442                	ld	s0,16(sp)
 3c8:	64a2                	ld	s1,8(sp)
 3ca:	6902                	ld	s2,0(sp)
 3cc:	6105                	addi	sp,sp,32
 3ce:	8082                	ret
    return -1;
 3d0:	597d                	li	s2,-1
 3d2:	bfc5                	j	3c2 <stat+0x34>

00000000000003d4 <atoi>:

int
atoi(const char *s)
{
 3d4:	1141                	addi	sp,sp,-16
 3d6:	e422                	sd	s0,8(sp)
 3d8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3da:	00054603          	lbu	a2,0(a0)
 3de:	fd06079b          	addiw	a5,a2,-48
 3e2:	0ff7f793          	zext.b	a5,a5
 3e6:	4725                	li	a4,9
 3e8:	02f76963          	bltu	a4,a5,41a <atoi+0x46>
 3ec:	86aa                	mv	a3,a0
  n = 0;
 3ee:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3f0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3f2:	0685                	addi	a3,a3,1
 3f4:	0025179b          	slliw	a5,a0,0x2
 3f8:	9fa9                	addw	a5,a5,a0
 3fa:	0017979b          	slliw	a5,a5,0x1
 3fe:	9fb1                	addw	a5,a5,a2
 400:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 404:	0006c603          	lbu	a2,0(a3)
 408:	fd06071b          	addiw	a4,a2,-48
 40c:	0ff77713          	zext.b	a4,a4
 410:	fee5f1e3          	bgeu	a1,a4,3f2 <atoi+0x1e>
  return n;
}
 414:	6422                	ld	s0,8(sp)
 416:	0141                	addi	sp,sp,16
 418:	8082                	ret
  n = 0;
 41a:	4501                	li	a0,0
 41c:	bfe5                	j	414 <atoi+0x40>

000000000000041e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 41e:	1141                	addi	sp,sp,-16
 420:	e422                	sd	s0,8(sp)
 422:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 424:	02b57463          	bgeu	a0,a1,44c <memmove+0x2e>
    while(n-- > 0)
 428:	00c05f63          	blez	a2,446 <memmove+0x28>
 42c:	1602                	slli	a2,a2,0x20
 42e:	9201                	srli	a2,a2,0x20
 430:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 434:	872a                	mv	a4,a0
      *dst++ = *src++;
 436:	0585                	addi	a1,a1,1
 438:	0705                	addi	a4,a4,1
 43a:	fff5c683          	lbu	a3,-1(a1)
 43e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 442:	fee79ae3          	bne	a5,a4,436 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 446:	6422                	ld	s0,8(sp)
 448:	0141                	addi	sp,sp,16
 44a:	8082                	ret
    dst += n;
 44c:	00c50733          	add	a4,a0,a2
    src += n;
 450:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 452:	fec05ae3          	blez	a2,446 <memmove+0x28>
 456:	fff6079b          	addiw	a5,a2,-1
 45a:	1782                	slli	a5,a5,0x20
 45c:	9381                	srli	a5,a5,0x20
 45e:	fff7c793          	not	a5,a5
 462:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 464:	15fd                	addi	a1,a1,-1
 466:	177d                	addi	a4,a4,-1
 468:	0005c683          	lbu	a3,0(a1)
 46c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 470:	fee79ae3          	bne	a5,a4,464 <memmove+0x46>
 474:	bfc9                	j	446 <memmove+0x28>

0000000000000476 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 476:	1141                	addi	sp,sp,-16
 478:	e422                	sd	s0,8(sp)
 47a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 47c:	ca05                	beqz	a2,4ac <memcmp+0x36>
 47e:	fff6069b          	addiw	a3,a2,-1
 482:	1682                	slli	a3,a3,0x20
 484:	9281                	srli	a3,a3,0x20
 486:	0685                	addi	a3,a3,1
 488:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 48a:	00054783          	lbu	a5,0(a0)
 48e:	0005c703          	lbu	a4,0(a1)
 492:	00e79863          	bne	a5,a4,4a2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 496:	0505                	addi	a0,a0,1
    p2++;
 498:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 49a:	fed518e3          	bne	a0,a3,48a <memcmp+0x14>
  }
  return 0;
 49e:	4501                	li	a0,0
 4a0:	a019                	j	4a6 <memcmp+0x30>
      return *p1 - *p2;
 4a2:	40e7853b          	subw	a0,a5,a4
}
 4a6:	6422                	ld	s0,8(sp)
 4a8:	0141                	addi	sp,sp,16
 4aa:	8082                	ret
  return 0;
 4ac:	4501                	li	a0,0
 4ae:	bfe5                	j	4a6 <memcmp+0x30>

00000000000004b0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e406                	sd	ra,8(sp)
 4b4:	e022                	sd	s0,0(sp)
 4b6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4b8:	00000097          	auipc	ra,0x0
 4bc:	f66080e7          	jalr	-154(ra) # 41e <memmove>
}
 4c0:	60a2                	ld	ra,8(sp)
 4c2:	6402                	ld	s0,0(sp)
 4c4:	0141                	addi	sp,sp,16
 4c6:	8082                	ret

00000000000004c8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4c8:	4885                	li	a7,1
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4d0:	4889                	li	a7,2
 ecall
 4d2:	00000073          	ecall
 ret
 4d6:	8082                	ret

00000000000004d8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4d8:	488d                	li	a7,3
 ecall
 4da:	00000073          	ecall
 ret
 4de:	8082                	ret

00000000000004e0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4e0:	4891                	li	a7,4
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <read>:
.global read
read:
 li a7, SYS_read
 4e8:	4895                	li	a7,5
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <write>:
.global write
write:
 li a7, SYS_write
 4f0:	48c1                	li	a7,16
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <close>:
.global close
close:
 li a7, SYS_close
 4f8:	48d5                	li	a7,21
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <kill>:
.global kill
kill:
 li a7, SYS_kill
 500:	4899                	li	a7,6
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <exec>:
.global exec
exec:
 li a7, SYS_exec
 508:	489d                	li	a7,7
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <open>:
.global open
open:
 li a7, SYS_open
 510:	48bd                	li	a7,15
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 518:	48c5                	li	a7,17
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 520:	48c9                	li	a7,18
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 528:	48a1                	li	a7,8
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <link>:
.global link
link:
 li a7, SYS_link
 530:	48cd                	li	a7,19
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 538:	48d1                	li	a7,20
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 540:	48a5                	li	a7,9
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <dup>:
.global dup
dup:
 li a7, SYS_dup
 548:	48a9                	li	a7,10
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 550:	48ad                	li	a7,11
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 558:	48b1                	li	a7,12
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 560:	48b5                	li	a7,13
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 568:	48b9                	li	a7,14
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 570:	48d9                	li	a7,22
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 578:	1101                	addi	sp,sp,-32
 57a:	ec06                	sd	ra,24(sp)
 57c:	e822                	sd	s0,16(sp)
 57e:	1000                	addi	s0,sp,32
 580:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 584:	4605                	li	a2,1
 586:	fef40593          	addi	a1,s0,-17
 58a:	00000097          	auipc	ra,0x0
 58e:	f66080e7          	jalr	-154(ra) # 4f0 <write>
}
 592:	60e2                	ld	ra,24(sp)
 594:	6442                	ld	s0,16(sp)
 596:	6105                	addi	sp,sp,32
 598:	8082                	ret

000000000000059a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 59a:	7139                	addi	sp,sp,-64
 59c:	fc06                	sd	ra,56(sp)
 59e:	f822                	sd	s0,48(sp)
 5a0:	f426                	sd	s1,40(sp)
 5a2:	f04a                	sd	s2,32(sp)
 5a4:	ec4e                	sd	s3,24(sp)
 5a6:	0080                	addi	s0,sp,64
 5a8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5aa:	c299                	beqz	a3,5b0 <printint+0x16>
 5ac:	0805c863          	bltz	a1,63c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b0:	2581                	sext.w	a1,a1
  neg = 0;
 5b2:	4881                	li	a7,0
 5b4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5b8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5ba:	2601                	sext.w	a2,a2
 5bc:	00000517          	auipc	a0,0x0
 5c0:	47c50513          	addi	a0,a0,1148 # a38 <digits>
 5c4:	883a                	mv	a6,a4
 5c6:	2705                	addiw	a4,a4,1
 5c8:	02c5f7bb          	remuw	a5,a1,a2
 5cc:	1782                	slli	a5,a5,0x20
 5ce:	9381                	srli	a5,a5,0x20
 5d0:	97aa                	add	a5,a5,a0
 5d2:	0007c783          	lbu	a5,0(a5)
 5d6:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5da:	0005879b          	sext.w	a5,a1
 5de:	02c5d5bb          	divuw	a1,a1,a2
 5e2:	0685                	addi	a3,a3,1
 5e4:	fec7f0e3          	bgeu	a5,a2,5c4 <printint+0x2a>
  if(neg)
 5e8:	00088b63          	beqz	a7,5fe <printint+0x64>
    buf[i++] = '-';
 5ec:	fd040793          	addi	a5,s0,-48
 5f0:	973e                	add	a4,a4,a5
 5f2:	02d00793          	li	a5,45
 5f6:	fef70823          	sb	a5,-16(a4)
 5fa:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 5fe:	02e05863          	blez	a4,62e <printint+0x94>
 602:	fc040793          	addi	a5,s0,-64
 606:	00e78933          	add	s2,a5,a4
 60a:	fff78993          	addi	s3,a5,-1
 60e:	99ba                	add	s3,s3,a4
 610:	377d                	addiw	a4,a4,-1
 612:	1702                	slli	a4,a4,0x20
 614:	9301                	srli	a4,a4,0x20
 616:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 61a:	fff94583          	lbu	a1,-1(s2)
 61e:	8526                	mv	a0,s1
 620:	00000097          	auipc	ra,0x0
 624:	f58080e7          	jalr	-168(ra) # 578 <putc>
  while(--i >= 0)
 628:	197d                	addi	s2,s2,-1
 62a:	ff3918e3          	bne	s2,s3,61a <printint+0x80>
}
 62e:	70e2                	ld	ra,56(sp)
 630:	7442                	ld	s0,48(sp)
 632:	74a2                	ld	s1,40(sp)
 634:	7902                	ld	s2,32(sp)
 636:	69e2                	ld	s3,24(sp)
 638:	6121                	addi	sp,sp,64
 63a:	8082                	ret
    x = -xx;
 63c:	40b005bb          	negw	a1,a1
    neg = 1;
 640:	4885                	li	a7,1
    x = -xx;
 642:	bf8d                	j	5b4 <printint+0x1a>

0000000000000644 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 644:	7119                	addi	sp,sp,-128
 646:	fc86                	sd	ra,120(sp)
 648:	f8a2                	sd	s0,112(sp)
 64a:	f4a6                	sd	s1,104(sp)
 64c:	f0ca                	sd	s2,96(sp)
 64e:	ecce                	sd	s3,88(sp)
 650:	e8d2                	sd	s4,80(sp)
 652:	e4d6                	sd	s5,72(sp)
 654:	e0da                	sd	s6,64(sp)
 656:	fc5e                	sd	s7,56(sp)
 658:	f862                	sd	s8,48(sp)
 65a:	f466                	sd	s9,40(sp)
 65c:	f06a                	sd	s10,32(sp)
 65e:	ec6e                	sd	s11,24(sp)
 660:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 662:	0005c903          	lbu	s2,0(a1)
 666:	18090f63          	beqz	s2,804 <vprintf+0x1c0>
 66a:	8aaa                	mv	s5,a0
 66c:	8b32                	mv	s6,a2
 66e:	00158493          	addi	s1,a1,1
  state = 0;
 672:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 674:	02500a13          	li	s4,37
      if(c == 'd'){
 678:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 67c:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 680:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 684:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 688:	00000b97          	auipc	s7,0x0
 68c:	3b0b8b93          	addi	s7,s7,944 # a38 <digits>
 690:	a839                	j	6ae <vprintf+0x6a>
        putc(fd, c);
 692:	85ca                	mv	a1,s2
 694:	8556                	mv	a0,s5
 696:	00000097          	auipc	ra,0x0
 69a:	ee2080e7          	jalr	-286(ra) # 578 <putc>
 69e:	a019                	j	6a4 <vprintf+0x60>
    } else if(state == '%'){
 6a0:	01498f63          	beq	s3,s4,6be <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6a4:	0485                	addi	s1,s1,1
 6a6:	fff4c903          	lbu	s2,-1(s1)
 6aa:	14090d63          	beqz	s2,804 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6ae:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6b2:	fe0997e3          	bnez	s3,6a0 <vprintf+0x5c>
      if(c == '%'){
 6b6:	fd479ee3          	bne	a5,s4,692 <vprintf+0x4e>
        state = '%';
 6ba:	89be                	mv	s3,a5
 6bc:	b7e5                	j	6a4 <vprintf+0x60>
      if(c == 'd'){
 6be:	05878063          	beq	a5,s8,6fe <vprintf+0xba>
      } else if(c == 'l') {
 6c2:	05978c63          	beq	a5,s9,71a <vprintf+0xd6>
      } else if(c == 'x') {
 6c6:	07a78863          	beq	a5,s10,736 <vprintf+0xf2>
      } else if(c == 'p') {
 6ca:	09b78463          	beq	a5,s11,752 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6ce:	07300713          	li	a4,115
 6d2:	0ce78663          	beq	a5,a4,79e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6d6:	06300713          	li	a4,99
 6da:	0ee78e63          	beq	a5,a4,7d6 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6de:	11478863          	beq	a5,s4,7ee <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6e2:	85d2                	mv	a1,s4
 6e4:	8556                	mv	a0,s5
 6e6:	00000097          	auipc	ra,0x0
 6ea:	e92080e7          	jalr	-366(ra) # 578 <putc>
        putc(fd, c);
 6ee:	85ca                	mv	a1,s2
 6f0:	8556                	mv	a0,s5
 6f2:	00000097          	auipc	ra,0x0
 6f6:	e86080e7          	jalr	-378(ra) # 578 <putc>
      }
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	b765                	j	6a4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 6fe:	008b0913          	addi	s2,s6,8
 702:	4685                	li	a3,1
 704:	4629                	li	a2,10
 706:	000b2583          	lw	a1,0(s6)
 70a:	8556                	mv	a0,s5
 70c:	00000097          	auipc	ra,0x0
 710:	e8e080e7          	jalr	-370(ra) # 59a <printint>
 714:	8b4a                	mv	s6,s2
      state = 0;
 716:	4981                	li	s3,0
 718:	b771                	j	6a4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 71a:	008b0913          	addi	s2,s6,8
 71e:	4681                	li	a3,0
 720:	4629                	li	a2,10
 722:	000b2583          	lw	a1,0(s6)
 726:	8556                	mv	a0,s5
 728:	00000097          	auipc	ra,0x0
 72c:	e72080e7          	jalr	-398(ra) # 59a <printint>
 730:	8b4a                	mv	s6,s2
      state = 0;
 732:	4981                	li	s3,0
 734:	bf85                	j	6a4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 736:	008b0913          	addi	s2,s6,8
 73a:	4681                	li	a3,0
 73c:	4641                	li	a2,16
 73e:	000b2583          	lw	a1,0(s6)
 742:	8556                	mv	a0,s5
 744:	00000097          	auipc	ra,0x0
 748:	e56080e7          	jalr	-426(ra) # 59a <printint>
 74c:	8b4a                	mv	s6,s2
      state = 0;
 74e:	4981                	li	s3,0
 750:	bf91                	j	6a4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 752:	008b0793          	addi	a5,s6,8
 756:	f8f43423          	sd	a5,-120(s0)
 75a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 75e:	03000593          	li	a1,48
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	e14080e7          	jalr	-492(ra) # 578 <putc>
  putc(fd, 'x');
 76c:	85ea                	mv	a1,s10
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e08080e7          	jalr	-504(ra) # 578 <putc>
 778:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 77a:	03c9d793          	srli	a5,s3,0x3c
 77e:	97de                	add	a5,a5,s7
 780:	0007c583          	lbu	a1,0(a5)
 784:	8556                	mv	a0,s5
 786:	00000097          	auipc	ra,0x0
 78a:	df2080e7          	jalr	-526(ra) # 578 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78e:	0992                	slli	s3,s3,0x4
 790:	397d                	addiw	s2,s2,-1
 792:	fe0914e3          	bnez	s2,77a <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 796:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 79a:	4981                	li	s3,0
 79c:	b721                	j	6a4 <vprintf+0x60>
        s = va_arg(ap, char*);
 79e:	008b0993          	addi	s3,s6,8
 7a2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7a6:	02090163          	beqz	s2,7c8 <vprintf+0x184>
        while(*s != 0){
 7aa:	00094583          	lbu	a1,0(s2)
 7ae:	c9a1                	beqz	a1,7fe <vprintf+0x1ba>
          putc(fd, *s);
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	dc6080e7          	jalr	-570(ra) # 578 <putc>
          s++;
 7ba:	0905                	addi	s2,s2,1
        while(*s != 0){
 7bc:	00094583          	lbu	a1,0(s2)
 7c0:	f9e5                	bnez	a1,7b0 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7c2:	8b4e                	mv	s6,s3
      state = 0;
 7c4:	4981                	li	s3,0
 7c6:	bdf9                	j	6a4 <vprintf+0x60>
          s = "(null)";
 7c8:	00000917          	auipc	s2,0x0
 7cc:	26890913          	addi	s2,s2,616 # a30 <malloc+0x122>
        while(*s != 0){
 7d0:	02800593          	li	a1,40
 7d4:	bff1                	j	7b0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7d6:	008b0913          	addi	s2,s6,8
 7da:	000b4583          	lbu	a1,0(s6)
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	d98080e7          	jalr	-616(ra) # 578 <putc>
 7e8:	8b4a                	mv	s6,s2
      state = 0;
 7ea:	4981                	li	s3,0
 7ec:	bd65                	j	6a4 <vprintf+0x60>
        putc(fd, c);
 7ee:	85d2                	mv	a1,s4
 7f0:	8556                	mv	a0,s5
 7f2:	00000097          	auipc	ra,0x0
 7f6:	d86080e7          	jalr	-634(ra) # 578 <putc>
      state = 0;
 7fa:	4981                	li	s3,0
 7fc:	b565                	j	6a4 <vprintf+0x60>
        s = va_arg(ap, char*);
 7fe:	8b4e                	mv	s6,s3
      state = 0;
 800:	4981                	li	s3,0
 802:	b54d                	j	6a4 <vprintf+0x60>
    }
  }
}
 804:	70e6                	ld	ra,120(sp)
 806:	7446                	ld	s0,112(sp)
 808:	74a6                	ld	s1,104(sp)
 80a:	7906                	ld	s2,96(sp)
 80c:	69e6                	ld	s3,88(sp)
 80e:	6a46                	ld	s4,80(sp)
 810:	6aa6                	ld	s5,72(sp)
 812:	6b06                	ld	s6,64(sp)
 814:	7be2                	ld	s7,56(sp)
 816:	7c42                	ld	s8,48(sp)
 818:	7ca2                	ld	s9,40(sp)
 81a:	7d02                	ld	s10,32(sp)
 81c:	6de2                	ld	s11,24(sp)
 81e:	6109                	addi	sp,sp,128
 820:	8082                	ret

0000000000000822 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 822:	715d                	addi	sp,sp,-80
 824:	ec06                	sd	ra,24(sp)
 826:	e822                	sd	s0,16(sp)
 828:	1000                	addi	s0,sp,32
 82a:	e010                	sd	a2,0(s0)
 82c:	e414                	sd	a3,8(s0)
 82e:	e818                	sd	a4,16(s0)
 830:	ec1c                	sd	a5,24(s0)
 832:	03043023          	sd	a6,32(s0)
 836:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 83a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 83e:	8622                	mv	a2,s0
 840:	00000097          	auipc	ra,0x0
 844:	e04080e7          	jalr	-508(ra) # 644 <vprintf>
}
 848:	60e2                	ld	ra,24(sp)
 84a:	6442                	ld	s0,16(sp)
 84c:	6161                	addi	sp,sp,80
 84e:	8082                	ret

0000000000000850 <printf>:

void
printf(const char *fmt, ...)
{
 850:	711d                	addi	sp,sp,-96
 852:	ec06                	sd	ra,24(sp)
 854:	e822                	sd	s0,16(sp)
 856:	1000                	addi	s0,sp,32
 858:	e40c                	sd	a1,8(s0)
 85a:	e810                	sd	a2,16(s0)
 85c:	ec14                	sd	a3,24(s0)
 85e:	f018                	sd	a4,32(s0)
 860:	f41c                	sd	a5,40(s0)
 862:	03043823          	sd	a6,48(s0)
 866:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 86a:	00840613          	addi	a2,s0,8
 86e:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 872:	85aa                	mv	a1,a0
 874:	4505                	li	a0,1
 876:	00000097          	auipc	ra,0x0
 87a:	dce080e7          	jalr	-562(ra) # 644 <vprintf>
}
 87e:	60e2                	ld	ra,24(sp)
 880:	6442                	ld	s0,16(sp)
 882:	6125                	addi	sp,sp,96
 884:	8082                	ret

0000000000000886 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 886:	1141                	addi	sp,sp,-16
 888:	e422                	sd	s0,8(sp)
 88a:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 88c:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 890:	00000797          	auipc	a5,0x0
 894:	1c07b783          	ld	a5,448(a5) # a50 <freep>
 898:	a805                	j	8c8 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 89a:	4618                	lw	a4,8(a2)
 89c:	9db9                	addw	a1,a1,a4
 89e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a2:	6398                	ld	a4,0(a5)
 8a4:	6318                	ld	a4,0(a4)
 8a6:	fee53823          	sd	a4,-16(a0)
 8aa:	a091                	j	8ee <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8ac:	ff852703          	lw	a4,-8(a0)
 8b0:	9e39                	addw	a2,a2,a4
 8b2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8b4:	ff053703          	ld	a4,-16(a0)
 8b8:	e398                	sd	a4,0(a5)
 8ba:	a099                	j	900 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8bc:	6398                	ld	a4,0(a5)
 8be:	00e7e463          	bltu	a5,a4,8c6 <free+0x40>
 8c2:	00e6ea63          	bltu	a3,a4,8d6 <free+0x50>
{
 8c6:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c8:	fed7fae3          	bgeu	a5,a3,8bc <free+0x36>
 8cc:	6398                	ld	a4,0(a5)
 8ce:	00e6e463          	bltu	a3,a4,8d6 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d2:	fee7eae3          	bltu	a5,a4,8c6 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8d6:	ff852583          	lw	a1,-8(a0)
 8da:	6390                	ld	a2,0(a5)
 8dc:	02059813          	slli	a6,a1,0x20
 8e0:	01c85713          	srli	a4,a6,0x1c
 8e4:	9736                	add	a4,a4,a3
 8e6:	fae60ae3          	beq	a2,a4,89a <free+0x14>
    bp->s.ptr = p->s.ptr;
 8ea:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8ee:	4790                	lw	a2,8(a5)
 8f0:	02061593          	slli	a1,a2,0x20
 8f4:	01c5d713          	srli	a4,a1,0x1c
 8f8:	973e                	add	a4,a4,a5
 8fa:	fae689e3          	beq	a3,a4,8ac <free+0x26>
  } else
    p->s.ptr = bp;
 8fe:	e394                	sd	a3,0(a5)
  freep = p;
 900:	00000717          	auipc	a4,0x0
 904:	14f73823          	sd	a5,336(a4) # a50 <freep>
}
 908:	6422                	ld	s0,8(sp)
 90a:	0141                	addi	sp,sp,16
 90c:	8082                	ret

000000000000090e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 90e:	7139                	addi	sp,sp,-64
 910:	fc06                	sd	ra,56(sp)
 912:	f822                	sd	s0,48(sp)
 914:	f426                	sd	s1,40(sp)
 916:	f04a                	sd	s2,32(sp)
 918:	ec4e                	sd	s3,24(sp)
 91a:	e852                	sd	s4,16(sp)
 91c:	e456                	sd	s5,8(sp)
 91e:	e05a                	sd	s6,0(sp)
 920:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	02051493          	slli	s1,a0,0x20
 926:	9081                	srli	s1,s1,0x20
 928:	04bd                	addi	s1,s1,15
 92a:	8091                	srli	s1,s1,0x4
 92c:	0014899b          	addiw	s3,s1,1
 930:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 932:	00000517          	auipc	a0,0x0
 936:	11e53503          	ld	a0,286(a0) # a50 <freep>
 93a:	c515                	beqz	a0,966 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93e:	4798                	lw	a4,8(a5)
 940:	02977f63          	bgeu	a4,s1,97e <malloc+0x70>
 944:	8a4e                	mv	s4,s3
 946:	0009871b          	sext.w	a4,s3
 94a:	6685                	lui	a3,0x1
 94c:	00d77363          	bgeu	a4,a3,952 <malloc+0x44>
 950:	6a05                	lui	s4,0x1
 952:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 956:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 95a:	00000917          	auipc	s2,0x0
 95e:	0f690913          	addi	s2,s2,246 # a50 <freep>
  if(p == (char*)-1)
 962:	5afd                	li	s5,-1
 964:	a895                	j	9d8 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 966:	00000797          	auipc	a5,0x0
 96a:	1e278793          	addi	a5,a5,482 # b48 <base>
 96e:	00000717          	auipc	a4,0x0
 972:	0ef73123          	sd	a5,226(a4) # a50 <freep>
 976:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 978:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 97c:	b7e1                	j	944 <malloc+0x36>
      if(p->s.size == nunits)
 97e:	02e48c63          	beq	s1,a4,9b6 <malloc+0xa8>
        p->s.size -= nunits;
 982:	4137073b          	subw	a4,a4,s3
 986:	c798                	sw	a4,8(a5)
        p += p->s.size;
 988:	02071693          	slli	a3,a4,0x20
 98c:	01c6d713          	srli	a4,a3,0x1c
 990:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 992:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 996:	00000717          	auipc	a4,0x0
 99a:	0aa73d23          	sd	a0,186(a4) # a50 <freep>
      return (void*)(p + 1);
 99e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9a2:	70e2                	ld	ra,56(sp)
 9a4:	7442                	ld	s0,48(sp)
 9a6:	74a2                	ld	s1,40(sp)
 9a8:	7902                	ld	s2,32(sp)
 9aa:	69e2                	ld	s3,24(sp)
 9ac:	6a42                	ld	s4,16(sp)
 9ae:	6aa2                	ld	s5,8(sp)
 9b0:	6b02                	ld	s6,0(sp)
 9b2:	6121                	addi	sp,sp,64
 9b4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9b6:	6398                	ld	a4,0(a5)
 9b8:	e118                	sd	a4,0(a0)
 9ba:	bff1                	j	996 <malloc+0x88>
  hp->s.size = nu;
 9bc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9c0:	0541                	addi	a0,a0,16
 9c2:	00000097          	auipc	ra,0x0
 9c6:	ec4080e7          	jalr	-316(ra) # 886 <free>
  return freep;
 9ca:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9ce:	d971                	beqz	a0,9a2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d2:	4798                	lw	a4,8(a5)
 9d4:	fa9775e3          	bgeu	a4,s1,97e <malloc+0x70>
    if(p == freep)
 9d8:	00093703          	ld	a4,0(s2)
 9dc:	853e                	mv	a0,a5
 9de:	fef719e3          	bne	a4,a5,9d0 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9e2:	8552                	mv	a0,s4
 9e4:	00000097          	auipc	ra,0x0
 9e8:	b74080e7          	jalr	-1164(ra) # 558 <sbrk>
  if(p == (char*)-1)
 9ec:	fd5518e3          	bne	a0,s5,9bc <malloc+0xae>
        return 0;
 9f0:	4501                	li	a0,0
 9f2:	bf45                	j	9a2 <malloc+0x94>
