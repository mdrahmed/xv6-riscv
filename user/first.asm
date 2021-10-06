
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
   c:	a0858593          	addi	a1,a1,-1528 # a10 <malloc+0xea>
  10:	4505                	li	a0,1
  12:	00001097          	auipc	ra,0x1
  16:	828080e7          	jalr	-2008(ra) # 83a <fprintf>
    fprintf(1, "An int occupies %d bytes.\n", sizeof(int)); 
  1a:	4611                	li	a2,4
  1c:	00001597          	auipc	a1,0x1
  20:	a0c58593          	addi	a1,a1,-1524 # a28 <malloc+0x102>
  24:	4505                	li	a0,1
  26:	00001097          	auipc	ra,0x1
  2a:	814080e7          	jalr	-2028(ra) # 83a <fprintf>
    exit(0);
  2e:	4501                	li	a0,0
  30:	00000097          	auipc	ra,0x0
  34:	4b8080e7          	jalr	1208(ra) # 4e8 <exit>

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
  7e:	a0648493          	addi	s1,s1,-1530 # a80 <rings+0x10>
  82:	00001917          	auipc	s2,0x1
  86:	aee90913          	addi	s2,s2,-1298 # b70 <__BSS_END__>
  8a:	04f59563          	bne	a1,a5,d4 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  8e:	00001497          	auipc	s1,0x1
  92:	9f24a483          	lw	s1,-1550(s1) # a80 <rings+0x10>
  96:	c099                	beqz	s1,9c <create_or_close_the_buffer_user+0x38>
  98:	4481                	li	s1,0
  9a:	a899                	j	f0 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  9c:	00001917          	auipc	s2,0x1
  a0:	9d490913          	addi	s2,s2,-1580 # a70 <rings>
  a4:	00093603          	ld	a2,0(s2)
  a8:	4585                	li	a1,1
  aa:	00000097          	auipc	ra,0x0
  ae:	4de080e7          	jalr	1246(ra) # 588 <ringbuf>
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
  e4:	4a8080e7          	jalr	1192(ra) # 588 <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 102:	1101                	addi	sp,sp,-32
 104:	ec06                	sd	ra,24(sp)
 106:	e822                	sd	s0,16(sp)
 108:	e426                	sd	s1,8(sp)
 10a:	1000                	addi	s0,sp,32
 10c:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 10e:	00151793          	slli	a5,a0,0x1
 112:	97aa                	add	a5,a5,a0
 114:	078e                	slli	a5,a5,0x3
 116:	00001717          	auipc	a4,0x1
 11a:	95a70713          	addi	a4,a4,-1702 # a70 <rings>
 11e:	97ba                	add	a5,a5,a4
 120:	6798                	ld	a4,8(a5)
 122:	671c                	ld	a5,8(a4)
 124:	00178693          	addi	a3,a5,1
 128:	e714                	sd	a3,8(a4)
 12a:	17d2                	slli	a5,a5,0x34
 12c:	93d1                	srli	a5,a5,0x34
 12e:	6741                	lui	a4,0x10
 130:	40f707b3          	sub	a5,a4,a5
 134:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 136:	421c                	lw	a5,0(a2)
 138:	e79d                	bnez	a5,166 <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 13a:	00001697          	auipc	a3,0x1
 13e:	93668693          	addi	a3,a3,-1738 # a70 <rings>
 142:	669c                	ld	a5,8(a3)
 144:	6398                	ld	a4,0(a5)
 146:	67c1                	lui	a5,0x10
 148:	9fb9                	addw	a5,a5,a4
 14a:	00151713          	slli	a4,a0,0x1
 14e:	953a                	add	a0,a0,a4
 150:	050e                	slli	a0,a0,0x3
 152:	9536                	add	a0,a0,a3
 154:	6518                	ld	a4,8(a0)
 156:	6718                	ld	a4,8(a4)
 158:	9f99                	subw	a5,a5,a4
 15a:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 15c:	60e2                	ld	ra,24(sp)
 15e:	6442                	ld	s0,16(sp)
 160:	64a2                	ld	s1,8(sp)
 162:	6105                	addi	sp,sp,32
 164:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 166:	00151793          	slli	a5,a0,0x1
 16a:	953e                	add	a0,a0,a5
 16c:	050e                	slli	a0,a0,0x3
 16e:	00001797          	auipc	a5,0x1
 172:	90278793          	addi	a5,a5,-1790 # a70 <rings>
 176:	953e                	add	a0,a0,a5
 178:	6508                	ld	a0,8(a0)
 17a:	0521                	addi	a0,a0,8
 17c:	00000097          	auipc	ra,0x0
 180:	ed0080e7          	jalr	-304(ra) # 4c <load>
 184:	c088                	sw	a0,0(s1)
}
 186:	bfd9                	j	15c <ringbuf_start_write+0x5a>

0000000000000188 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 188:	1141                	addi	sp,sp,-16
 18a:	e406                	sd	ra,8(sp)
 18c:	e022                	sd	s0,0(sp)
 18e:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 190:	00151793          	slli	a5,a0,0x1
 194:	97aa                	add	a5,a5,a0
 196:	078e                	slli	a5,a5,0x3
 198:	00001517          	auipc	a0,0x1
 19c:	8d850513          	addi	a0,a0,-1832 # a70 <rings>
 1a0:	97aa                	add	a5,a5,a0
 1a2:	6788                	ld	a0,8(a5)
 1a4:	0035959b          	slliw	a1,a1,0x3
 1a8:	0521                	addi	a0,a0,8
 1aa:	00000097          	auipc	ra,0x0
 1ae:	e8e080e7          	jalr	-370(ra) # 38 <store>
}
 1b2:	60a2                	ld	ra,8(sp)
 1b4:	6402                	ld	s0,0(sp)
 1b6:	0141                	addi	sp,sp,16
 1b8:	8082                	ret

00000000000001ba <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1ba:	1101                	addi	sp,sp,-32
 1bc:	ec06                	sd	ra,24(sp)
 1be:	e822                	sd	s0,16(sp)
 1c0:	e426                	sd	s1,8(sp)
 1c2:	1000                	addi	s0,sp,32
 1c4:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1c6:	00151793          	slli	a5,a0,0x1
 1ca:	97aa                	add	a5,a5,a0
 1cc:	078e                	slli	a5,a5,0x3
 1ce:	00001517          	auipc	a0,0x1
 1d2:	8a250513          	addi	a0,a0,-1886 # a70 <rings>
 1d6:	97aa                	add	a5,a5,a0
 1d8:	6788                	ld	a0,8(a5)
 1da:	0521                	addi	a0,a0,8
 1dc:	00000097          	auipc	ra,0x0
 1e0:	e70080e7          	jalr	-400(ra) # 4c <load>
 1e4:	c088                	sw	a0,0(s1)
}
 1e6:	60e2                	ld	ra,24(sp)
 1e8:	6442                	ld	s0,16(sp)
 1ea:	64a2                	ld	s1,8(sp)
 1ec:	6105                	addi	sp,sp,32
 1ee:	8082                	ret

00000000000001f0 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 1f0:	1101                	addi	sp,sp,-32
 1f2:	ec06                	sd	ra,24(sp)
 1f4:	e822                	sd	s0,16(sp)
 1f6:	e426                	sd	s1,8(sp)
 1f8:	1000                	addi	s0,sp,32
 1fa:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 1fc:	00151793          	slli	a5,a0,0x1
 200:	97aa                	add	a5,a5,a0
 202:	078e                	slli	a5,a5,0x3
 204:	00001517          	auipc	a0,0x1
 208:	86c50513          	addi	a0,a0,-1940 # a70 <rings>
 20c:	97aa                	add	a5,a5,a0
 20e:	6788                	ld	a0,8(a5)
 210:	611c                	ld	a5,0(a0)
 212:	ef99                	bnez	a5,230 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 214:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 216:	41f7579b          	sraiw	a5,a4,0x1f
 21a:	01d7d79b          	srliw	a5,a5,0x1d
 21e:	9fb9                	addw	a5,a5,a4
 220:	4037d79b          	sraiw	a5,a5,0x3
 224:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 226:	60e2                	ld	ra,24(sp)
 228:	6442                	ld	s0,16(sp)
 22a:	64a2                	ld	s1,8(sp)
 22c:	6105                	addi	sp,sp,32
 22e:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 230:	00000097          	auipc	ra,0x0
 234:	e1c080e7          	jalr	-484(ra) # 4c <load>
    *bytes /= 8;
 238:	41f5579b          	sraiw	a5,a0,0x1f
 23c:	01d7d79b          	srliw	a5,a5,0x1d
 240:	9d3d                	addw	a0,a0,a5
 242:	4035551b          	sraiw	a0,a0,0x3
 246:	c088                	sw	a0,0(s1)
}
 248:	bff9                	j	226 <ringbuf_start_read+0x36>

000000000000024a <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 24a:	1141                	addi	sp,sp,-16
 24c:	e406                	sd	ra,8(sp)
 24e:	e022                	sd	s0,0(sp)
 250:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 252:	00151793          	slli	a5,a0,0x1
 256:	97aa                	add	a5,a5,a0
 258:	078e                	slli	a5,a5,0x3
 25a:	00001517          	auipc	a0,0x1
 25e:	81650513          	addi	a0,a0,-2026 # a70 <rings>
 262:	97aa                	add	a5,a5,a0
 264:	0035959b          	slliw	a1,a1,0x3
 268:	6788                	ld	a0,8(a5)
 26a:	00000097          	auipc	ra,0x0
 26e:	dce080e7          	jalr	-562(ra) # 38 <store>
}
 272:	60a2                	ld	ra,8(sp)
 274:	6402                	ld	s0,0(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret

000000000000027a <strcpy>:



char*
strcpy(char *s, const char *t)
{
 27a:	1141                	addi	sp,sp,-16
 27c:	e422                	sd	s0,8(sp)
 27e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 280:	87aa                	mv	a5,a0
 282:	0585                	addi	a1,a1,1
 284:	0785                	addi	a5,a5,1
 286:	fff5c703          	lbu	a4,-1(a1)
 28a:	fee78fa3          	sb	a4,-1(a5)
 28e:	fb75                	bnez	a4,282 <strcpy+0x8>
    ;
  return os;
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret

0000000000000296 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 29c:	00054783          	lbu	a5,0(a0)
 2a0:	cb91                	beqz	a5,2b4 <strcmp+0x1e>
 2a2:	0005c703          	lbu	a4,0(a1)
 2a6:	00f71763          	bne	a4,a5,2b4 <strcmp+0x1e>
    p++, q++;
 2aa:	0505                	addi	a0,a0,1
 2ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ae:	00054783          	lbu	a5,0(a0)
 2b2:	fbe5                	bnez	a5,2a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2b4:	0005c503          	lbu	a0,0(a1)
}
 2b8:	40a7853b          	subw	a0,a5,a0
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <strlen>:

uint
strlen(const char *s)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	cf91                	beqz	a5,2e8 <strlen+0x26>
 2ce:	0505                	addi	a0,a0,1
 2d0:	87aa                	mv	a5,a0
 2d2:	4685                	li	a3,1
 2d4:	9e89                	subw	a3,a3,a0
 2d6:	00f6853b          	addw	a0,a3,a5
 2da:	0785                	addi	a5,a5,1
 2dc:	fff7c703          	lbu	a4,-1(a5)
 2e0:	fb7d                	bnez	a4,2d6 <strlen+0x14>
    ;
  return n;
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret
  for(n = 0; s[n]; n++)
 2e8:	4501                	li	a0,0
 2ea:	bfe5                	j	2e2 <strlen+0x20>

00000000000002ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 2ec:	1141                	addi	sp,sp,-16
 2ee:	e422                	sd	s0,8(sp)
 2f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 2f2:	ca19                	beqz	a2,308 <memset+0x1c>
 2f4:	87aa                	mv	a5,a0
 2f6:	1602                	slli	a2,a2,0x20
 2f8:	9201                	srli	a2,a2,0x20
 2fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 2fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 302:	0785                	addi	a5,a5,1
 304:	fee79de3          	bne	a5,a4,2fe <memset+0x12>
  }
  return dst;
}
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret

000000000000030e <strchr>:

char*
strchr(const char *s, char c)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	addi	s0,sp,16
  for(; *s; s++)
 314:	00054783          	lbu	a5,0(a0)
 318:	cb99                	beqz	a5,32e <strchr+0x20>
    if(*s == c)
 31a:	00f58763          	beq	a1,a5,328 <strchr+0x1a>
  for(; *s; s++)
 31e:	0505                	addi	a0,a0,1
 320:	00054783          	lbu	a5,0(a0)
 324:	fbfd                	bnez	a5,31a <strchr+0xc>
      return (char*)s;
  return 0;
 326:	4501                	li	a0,0
}
 328:	6422                	ld	s0,8(sp)
 32a:	0141                	addi	sp,sp,16
 32c:	8082                	ret
  return 0;
 32e:	4501                	li	a0,0
 330:	bfe5                	j	328 <strchr+0x1a>

0000000000000332 <gets>:

char*
gets(char *buf, int max)
{
 332:	711d                	addi	sp,sp,-96
 334:	ec86                	sd	ra,88(sp)
 336:	e8a2                	sd	s0,80(sp)
 338:	e4a6                	sd	s1,72(sp)
 33a:	e0ca                	sd	s2,64(sp)
 33c:	fc4e                	sd	s3,56(sp)
 33e:	f852                	sd	s4,48(sp)
 340:	f456                	sd	s5,40(sp)
 342:	f05a                	sd	s6,32(sp)
 344:	ec5e                	sd	s7,24(sp)
 346:	1080                	addi	s0,sp,96
 348:	8baa                	mv	s7,a0
 34a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34c:	892a                	mv	s2,a0
 34e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 350:	4aa9                	li	s5,10
 352:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 354:	89a6                	mv	s3,s1
 356:	2485                	addiw	s1,s1,1
 358:	0344d863          	bge	s1,s4,388 <gets+0x56>
    cc = read(0, &c, 1);
 35c:	4605                	li	a2,1
 35e:	faf40593          	addi	a1,s0,-81
 362:	4501                	li	a0,0
 364:	00000097          	auipc	ra,0x0
 368:	19c080e7          	jalr	412(ra) # 500 <read>
    if(cc < 1)
 36c:	00a05e63          	blez	a0,388 <gets+0x56>
    buf[i++] = c;
 370:	faf44783          	lbu	a5,-81(s0)
 374:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 378:	01578763          	beq	a5,s5,386 <gets+0x54>
 37c:	0905                	addi	s2,s2,1
 37e:	fd679be3          	bne	a5,s6,354 <gets+0x22>
  for(i=0; i+1 < max; ){
 382:	89a6                	mv	s3,s1
 384:	a011                	j	388 <gets+0x56>
 386:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 388:	99de                	add	s3,s3,s7
 38a:	00098023          	sb	zero,0(s3)
  return buf;
}
 38e:	855e                	mv	a0,s7
 390:	60e6                	ld	ra,88(sp)
 392:	6446                	ld	s0,80(sp)
 394:	64a6                	ld	s1,72(sp)
 396:	6906                	ld	s2,64(sp)
 398:	79e2                	ld	s3,56(sp)
 39a:	7a42                	ld	s4,48(sp)
 39c:	7aa2                	ld	s5,40(sp)
 39e:	7b02                	ld	s6,32(sp)
 3a0:	6be2                	ld	s7,24(sp)
 3a2:	6125                	addi	sp,sp,96
 3a4:	8082                	ret

00000000000003a6 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a6:	1101                	addi	sp,sp,-32
 3a8:	ec06                	sd	ra,24(sp)
 3aa:	e822                	sd	s0,16(sp)
 3ac:	e426                	sd	s1,8(sp)
 3ae:	e04a                	sd	s2,0(sp)
 3b0:	1000                	addi	s0,sp,32
 3b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b4:	4581                	li	a1,0
 3b6:	00000097          	auipc	ra,0x0
 3ba:	172080e7          	jalr	370(ra) # 528 <open>
  if(fd < 0)
 3be:	02054563          	bltz	a0,3e8 <stat+0x42>
 3c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3c4:	85ca                	mv	a1,s2
 3c6:	00000097          	auipc	ra,0x0
 3ca:	17a080e7          	jalr	378(ra) # 540 <fstat>
 3ce:	892a                	mv	s2,a0
  close(fd);
 3d0:	8526                	mv	a0,s1
 3d2:	00000097          	auipc	ra,0x0
 3d6:	13e080e7          	jalr	318(ra) # 510 <close>
  return r;
}
 3da:	854a                	mv	a0,s2
 3dc:	60e2                	ld	ra,24(sp)
 3de:	6442                	ld	s0,16(sp)
 3e0:	64a2                	ld	s1,8(sp)
 3e2:	6902                	ld	s2,0(sp)
 3e4:	6105                	addi	sp,sp,32
 3e6:	8082                	ret
    return -1;
 3e8:	597d                	li	s2,-1
 3ea:	bfc5                	j	3da <stat+0x34>

00000000000003ec <atoi>:

int
atoi(const char *s)
{
 3ec:	1141                	addi	sp,sp,-16
 3ee:	e422                	sd	s0,8(sp)
 3f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f2:	00054603          	lbu	a2,0(a0)
 3f6:	fd06079b          	addiw	a5,a2,-48
 3fa:	0ff7f793          	zext.b	a5,a5
 3fe:	4725                	li	a4,9
 400:	02f76963          	bltu	a4,a5,432 <atoi+0x46>
 404:	86aa                	mv	a3,a0
  n = 0;
 406:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 408:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 40a:	0685                	addi	a3,a3,1
 40c:	0025179b          	slliw	a5,a0,0x2
 410:	9fa9                	addw	a5,a5,a0
 412:	0017979b          	slliw	a5,a5,0x1
 416:	9fb1                	addw	a5,a5,a2
 418:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 41c:	0006c603          	lbu	a2,0(a3)
 420:	fd06071b          	addiw	a4,a2,-48
 424:	0ff77713          	zext.b	a4,a4
 428:	fee5f1e3          	bgeu	a1,a4,40a <atoi+0x1e>
  return n;
}
 42c:	6422                	ld	s0,8(sp)
 42e:	0141                	addi	sp,sp,16
 430:	8082                	ret
  n = 0;
 432:	4501                	li	a0,0
 434:	bfe5                	j	42c <atoi+0x40>

0000000000000436 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 436:	1141                	addi	sp,sp,-16
 438:	e422                	sd	s0,8(sp)
 43a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 43c:	02b57463          	bgeu	a0,a1,464 <memmove+0x2e>
    while(n-- > 0)
 440:	00c05f63          	blez	a2,45e <memmove+0x28>
 444:	1602                	slli	a2,a2,0x20
 446:	9201                	srli	a2,a2,0x20
 448:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 44c:	872a                	mv	a4,a0
      *dst++ = *src++;
 44e:	0585                	addi	a1,a1,1
 450:	0705                	addi	a4,a4,1
 452:	fff5c683          	lbu	a3,-1(a1)
 456:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xed9e>
    while(n-- > 0)
 45a:	fee79ae3          	bne	a5,a4,44e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 45e:	6422                	ld	s0,8(sp)
 460:	0141                	addi	sp,sp,16
 462:	8082                	ret
    dst += n;
 464:	00c50733          	add	a4,a0,a2
    src += n;
 468:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 46a:	fec05ae3          	blez	a2,45e <memmove+0x28>
 46e:	fff6079b          	addiw	a5,a2,-1
 472:	1782                	slli	a5,a5,0x20
 474:	9381                	srli	a5,a5,0x20
 476:	fff7c793          	not	a5,a5
 47a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 47c:	15fd                	addi	a1,a1,-1
 47e:	177d                	addi	a4,a4,-1
 480:	0005c683          	lbu	a3,0(a1)
 484:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 488:	fee79ae3          	bne	a5,a4,47c <memmove+0x46>
 48c:	bfc9                	j	45e <memmove+0x28>

000000000000048e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 48e:	1141                	addi	sp,sp,-16
 490:	e422                	sd	s0,8(sp)
 492:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 494:	ca05                	beqz	a2,4c4 <memcmp+0x36>
 496:	fff6069b          	addiw	a3,a2,-1
 49a:	1682                	slli	a3,a3,0x20
 49c:	9281                	srli	a3,a3,0x20
 49e:	0685                	addi	a3,a3,1
 4a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4a2:	00054783          	lbu	a5,0(a0)
 4a6:	0005c703          	lbu	a4,0(a1)
 4aa:	00e79863          	bne	a5,a4,4ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4ae:	0505                	addi	a0,a0,1
    p2++;
 4b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4b2:	fed518e3          	bne	a0,a3,4a2 <memcmp+0x14>
  }
  return 0;
 4b6:	4501                	li	a0,0
 4b8:	a019                	j	4be <memcmp+0x30>
      return *p1 - *p2;
 4ba:	40e7853b          	subw	a0,a5,a4
}
 4be:	6422                	ld	s0,8(sp)
 4c0:	0141                	addi	sp,sp,16
 4c2:	8082                	ret
  return 0;
 4c4:	4501                	li	a0,0
 4c6:	bfe5                	j	4be <memcmp+0x30>

00000000000004c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4c8:	1141                	addi	sp,sp,-16
 4ca:	e406                	sd	ra,8(sp)
 4cc:	e022                	sd	s0,0(sp)
 4ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4d0:	00000097          	auipc	ra,0x0
 4d4:	f66080e7          	jalr	-154(ra) # 436 <memmove>
}
 4d8:	60a2                	ld	ra,8(sp)
 4da:	6402                	ld	s0,0(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret

00000000000004e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4e0:	4885                	li	a7,1
 ecall
 4e2:	00000073          	ecall
 ret
 4e6:	8082                	ret

00000000000004e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4e8:	4889                	li	a7,2
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 4f0:	488d                	li	a7,3
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 4f8:	4891                	li	a7,4
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <read>:
.global read
read:
 li a7, SYS_read
 500:	4895                	li	a7,5
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <write>:
.global write
write:
 li a7, SYS_write
 508:	48c1                	li	a7,16
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <close>:
.global close
close:
 li a7, SYS_close
 510:	48d5                	li	a7,21
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <kill>:
.global kill
kill:
 li a7, SYS_kill
 518:	4899                	li	a7,6
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <exec>:
.global exec
exec:
 li a7, SYS_exec
 520:	489d                	li	a7,7
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <open>:
.global open
open:
 li a7, SYS_open
 528:	48bd                	li	a7,15
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 530:	48c5                	li	a7,17
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 538:	48c9                	li	a7,18
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 540:	48a1                	li	a7,8
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <link>:
.global link
link:
 li a7, SYS_link
 548:	48cd                	li	a7,19
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 550:	48d1                	li	a7,20
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 558:	48a5                	li	a7,9
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <dup>:
.global dup
dup:
 li a7, SYS_dup
 560:	48a9                	li	a7,10
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 568:	48ad                	li	a7,11
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 570:	48b1                	li	a7,12
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 578:	48b5                	li	a7,13
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 580:	48b9                	li	a7,14
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 588:	48d9                	li	a7,22
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 590:	1101                	addi	sp,sp,-32
 592:	ec06                	sd	ra,24(sp)
 594:	e822                	sd	s0,16(sp)
 596:	1000                	addi	s0,sp,32
 598:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 59c:	4605                	li	a2,1
 59e:	fef40593          	addi	a1,s0,-17
 5a2:	00000097          	auipc	ra,0x0
 5a6:	f66080e7          	jalr	-154(ra) # 508 <write>
}
 5aa:	60e2                	ld	ra,24(sp)
 5ac:	6442                	ld	s0,16(sp)
 5ae:	6105                	addi	sp,sp,32
 5b0:	8082                	ret

00000000000005b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5b2:	7139                	addi	sp,sp,-64
 5b4:	fc06                	sd	ra,56(sp)
 5b6:	f822                	sd	s0,48(sp)
 5b8:	f426                	sd	s1,40(sp)
 5ba:	f04a                	sd	s2,32(sp)
 5bc:	ec4e                	sd	s3,24(sp)
 5be:	0080                	addi	s0,sp,64
 5c0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5c2:	c299                	beqz	a3,5c8 <printint+0x16>
 5c4:	0805c863          	bltz	a1,654 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5c8:	2581                	sext.w	a1,a1
  neg = 0;
 5ca:	4881                	li	a7,0
 5cc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5d0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5d2:	2601                	sext.w	a2,a2
 5d4:	00000517          	auipc	a0,0x0
 5d8:	47c50513          	addi	a0,a0,1148 # a50 <digits>
 5dc:	883a                	mv	a6,a4
 5de:	2705                	addiw	a4,a4,1
 5e0:	02c5f7bb          	remuw	a5,a1,a2
 5e4:	1782                	slli	a5,a5,0x20
 5e6:	9381                	srli	a5,a5,0x20
 5e8:	97aa                	add	a5,a5,a0
 5ea:	0007c783          	lbu	a5,0(a5)
 5ee:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 5f2:	0005879b          	sext.w	a5,a1
 5f6:	02c5d5bb          	divuw	a1,a1,a2
 5fa:	0685                	addi	a3,a3,1
 5fc:	fec7f0e3          	bgeu	a5,a2,5dc <printint+0x2a>
  if(neg)
 600:	00088b63          	beqz	a7,616 <printint+0x64>
    buf[i++] = '-';
 604:	fd040793          	addi	a5,s0,-48
 608:	973e                	add	a4,a4,a5
 60a:	02d00793          	li	a5,45
 60e:	fef70823          	sb	a5,-16(a4)
 612:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 616:	02e05863          	blez	a4,646 <printint+0x94>
 61a:	fc040793          	addi	a5,s0,-64
 61e:	00e78933          	add	s2,a5,a4
 622:	fff78993          	addi	s3,a5,-1
 626:	99ba                	add	s3,s3,a4
 628:	377d                	addiw	a4,a4,-1
 62a:	1702                	slli	a4,a4,0x20
 62c:	9301                	srli	a4,a4,0x20
 62e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 632:	fff94583          	lbu	a1,-1(s2)
 636:	8526                	mv	a0,s1
 638:	00000097          	auipc	ra,0x0
 63c:	f58080e7          	jalr	-168(ra) # 590 <putc>
  while(--i >= 0)
 640:	197d                	addi	s2,s2,-1
 642:	ff3918e3          	bne	s2,s3,632 <printint+0x80>
}
 646:	70e2                	ld	ra,56(sp)
 648:	7442                	ld	s0,48(sp)
 64a:	74a2                	ld	s1,40(sp)
 64c:	7902                	ld	s2,32(sp)
 64e:	69e2                	ld	s3,24(sp)
 650:	6121                	addi	sp,sp,64
 652:	8082                	ret
    x = -xx;
 654:	40b005bb          	negw	a1,a1
    neg = 1;
 658:	4885                	li	a7,1
    x = -xx;
 65a:	bf8d                	j	5cc <printint+0x1a>

000000000000065c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 65c:	7119                	addi	sp,sp,-128
 65e:	fc86                	sd	ra,120(sp)
 660:	f8a2                	sd	s0,112(sp)
 662:	f4a6                	sd	s1,104(sp)
 664:	f0ca                	sd	s2,96(sp)
 666:	ecce                	sd	s3,88(sp)
 668:	e8d2                	sd	s4,80(sp)
 66a:	e4d6                	sd	s5,72(sp)
 66c:	e0da                	sd	s6,64(sp)
 66e:	fc5e                	sd	s7,56(sp)
 670:	f862                	sd	s8,48(sp)
 672:	f466                	sd	s9,40(sp)
 674:	f06a                	sd	s10,32(sp)
 676:	ec6e                	sd	s11,24(sp)
 678:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 67a:	0005c903          	lbu	s2,0(a1)
 67e:	18090f63          	beqz	s2,81c <vprintf+0x1c0>
 682:	8aaa                	mv	s5,a0
 684:	8b32                	mv	s6,a2
 686:	00158493          	addi	s1,a1,1
  state = 0;
 68a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 68c:	02500a13          	li	s4,37
      if(c == 'd'){
 690:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 694:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 698:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 69c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6a0:	00000b97          	auipc	s7,0x0
 6a4:	3b0b8b93          	addi	s7,s7,944 # a50 <digits>
 6a8:	a839                	j	6c6 <vprintf+0x6a>
        putc(fd, c);
 6aa:	85ca                	mv	a1,s2
 6ac:	8556                	mv	a0,s5
 6ae:	00000097          	auipc	ra,0x0
 6b2:	ee2080e7          	jalr	-286(ra) # 590 <putc>
 6b6:	a019                	j	6bc <vprintf+0x60>
    } else if(state == '%'){
 6b8:	01498f63          	beq	s3,s4,6d6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6bc:	0485                	addi	s1,s1,1
 6be:	fff4c903          	lbu	s2,-1(s1)
 6c2:	14090d63          	beqz	s2,81c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6c6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6ca:	fe0997e3          	bnez	s3,6b8 <vprintf+0x5c>
      if(c == '%'){
 6ce:	fd479ee3          	bne	a5,s4,6aa <vprintf+0x4e>
        state = '%';
 6d2:	89be                	mv	s3,a5
 6d4:	b7e5                	j	6bc <vprintf+0x60>
      if(c == 'd'){
 6d6:	05878063          	beq	a5,s8,716 <vprintf+0xba>
      } else if(c == 'l') {
 6da:	05978c63          	beq	a5,s9,732 <vprintf+0xd6>
      } else if(c == 'x') {
 6de:	07a78863          	beq	a5,s10,74e <vprintf+0xf2>
      } else if(c == 'p') {
 6e2:	09b78463          	beq	a5,s11,76a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6e6:	07300713          	li	a4,115
 6ea:	0ce78663          	beq	a5,a4,7b6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6ee:	06300713          	li	a4,99
 6f2:	0ee78e63          	beq	a5,a4,7ee <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 6f6:	11478863          	beq	a5,s4,806 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6fa:	85d2                	mv	a1,s4
 6fc:	8556                	mv	a0,s5
 6fe:	00000097          	auipc	ra,0x0
 702:	e92080e7          	jalr	-366(ra) # 590 <putc>
        putc(fd, c);
 706:	85ca                	mv	a1,s2
 708:	8556                	mv	a0,s5
 70a:	00000097          	auipc	ra,0x0
 70e:	e86080e7          	jalr	-378(ra) # 590 <putc>
      }
      state = 0;
 712:	4981                	li	s3,0
 714:	b765                	j	6bc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 716:	008b0913          	addi	s2,s6,8
 71a:	4685                	li	a3,1
 71c:	4629                	li	a2,10
 71e:	000b2583          	lw	a1,0(s6)
 722:	8556                	mv	a0,s5
 724:	00000097          	auipc	ra,0x0
 728:	e8e080e7          	jalr	-370(ra) # 5b2 <printint>
 72c:	8b4a                	mv	s6,s2
      state = 0;
 72e:	4981                	li	s3,0
 730:	b771                	j	6bc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 732:	008b0913          	addi	s2,s6,8
 736:	4681                	li	a3,0
 738:	4629                	li	a2,10
 73a:	000b2583          	lw	a1,0(s6)
 73e:	8556                	mv	a0,s5
 740:	00000097          	auipc	ra,0x0
 744:	e72080e7          	jalr	-398(ra) # 5b2 <printint>
 748:	8b4a                	mv	s6,s2
      state = 0;
 74a:	4981                	li	s3,0
 74c:	bf85                	j	6bc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 74e:	008b0913          	addi	s2,s6,8
 752:	4681                	li	a3,0
 754:	4641                	li	a2,16
 756:	000b2583          	lw	a1,0(s6)
 75a:	8556                	mv	a0,s5
 75c:	00000097          	auipc	ra,0x0
 760:	e56080e7          	jalr	-426(ra) # 5b2 <printint>
 764:	8b4a                	mv	s6,s2
      state = 0;
 766:	4981                	li	s3,0
 768:	bf91                	j	6bc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 76a:	008b0793          	addi	a5,s6,8
 76e:	f8f43423          	sd	a5,-120(s0)
 772:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 776:	03000593          	li	a1,48
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	e14080e7          	jalr	-492(ra) # 590 <putc>
  putc(fd, 'x');
 784:	85ea                	mv	a1,s10
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	e08080e7          	jalr	-504(ra) # 590 <putc>
 790:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 792:	03c9d793          	srli	a5,s3,0x3c
 796:	97de                	add	a5,a5,s7
 798:	0007c583          	lbu	a1,0(a5)
 79c:	8556                	mv	a0,s5
 79e:	00000097          	auipc	ra,0x0
 7a2:	df2080e7          	jalr	-526(ra) # 590 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7a6:	0992                	slli	s3,s3,0x4
 7a8:	397d                	addiw	s2,s2,-1
 7aa:	fe0914e3          	bnez	s2,792 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7ae:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	b721                	j	6bc <vprintf+0x60>
        s = va_arg(ap, char*);
 7b6:	008b0993          	addi	s3,s6,8
 7ba:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7be:	02090163          	beqz	s2,7e0 <vprintf+0x184>
        while(*s != 0){
 7c2:	00094583          	lbu	a1,0(s2)
 7c6:	c9a1                	beqz	a1,816 <vprintf+0x1ba>
          putc(fd, *s);
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	dc6080e7          	jalr	-570(ra) # 590 <putc>
          s++;
 7d2:	0905                	addi	s2,s2,1
        while(*s != 0){
 7d4:	00094583          	lbu	a1,0(s2)
 7d8:	f9e5                	bnez	a1,7c8 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7da:	8b4e                	mv	s6,s3
      state = 0;
 7dc:	4981                	li	s3,0
 7de:	bdf9                	j	6bc <vprintf+0x60>
          s = "(null)";
 7e0:	00000917          	auipc	s2,0x0
 7e4:	26890913          	addi	s2,s2,616 # a48 <malloc+0x122>
        while(*s != 0){
 7e8:	02800593          	li	a1,40
 7ec:	bff1                	j	7c8 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7ee:	008b0913          	addi	s2,s6,8
 7f2:	000b4583          	lbu	a1,0(s6)
 7f6:	8556                	mv	a0,s5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	d98080e7          	jalr	-616(ra) # 590 <putc>
 800:	8b4a                	mv	s6,s2
      state = 0;
 802:	4981                	li	s3,0
 804:	bd65                	j	6bc <vprintf+0x60>
        putc(fd, c);
 806:	85d2                	mv	a1,s4
 808:	8556                	mv	a0,s5
 80a:	00000097          	auipc	ra,0x0
 80e:	d86080e7          	jalr	-634(ra) # 590 <putc>
      state = 0;
 812:	4981                	li	s3,0
 814:	b565                	j	6bc <vprintf+0x60>
        s = va_arg(ap, char*);
 816:	8b4e                	mv	s6,s3
      state = 0;
 818:	4981                	li	s3,0
 81a:	b54d                	j	6bc <vprintf+0x60>
    }
  }
}
 81c:	70e6                	ld	ra,120(sp)
 81e:	7446                	ld	s0,112(sp)
 820:	74a6                	ld	s1,104(sp)
 822:	7906                	ld	s2,96(sp)
 824:	69e6                	ld	s3,88(sp)
 826:	6a46                	ld	s4,80(sp)
 828:	6aa6                	ld	s5,72(sp)
 82a:	6b06                	ld	s6,64(sp)
 82c:	7be2                	ld	s7,56(sp)
 82e:	7c42                	ld	s8,48(sp)
 830:	7ca2                	ld	s9,40(sp)
 832:	7d02                	ld	s10,32(sp)
 834:	6de2                	ld	s11,24(sp)
 836:	6109                	addi	sp,sp,128
 838:	8082                	ret

000000000000083a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 83a:	715d                	addi	sp,sp,-80
 83c:	ec06                	sd	ra,24(sp)
 83e:	e822                	sd	s0,16(sp)
 840:	1000                	addi	s0,sp,32
 842:	e010                	sd	a2,0(s0)
 844:	e414                	sd	a3,8(s0)
 846:	e818                	sd	a4,16(s0)
 848:	ec1c                	sd	a5,24(s0)
 84a:	03043023          	sd	a6,32(s0)
 84e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 852:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 856:	8622                	mv	a2,s0
 858:	00000097          	auipc	ra,0x0
 85c:	e04080e7          	jalr	-508(ra) # 65c <vprintf>
}
 860:	60e2                	ld	ra,24(sp)
 862:	6442                	ld	s0,16(sp)
 864:	6161                	addi	sp,sp,80
 866:	8082                	ret

0000000000000868 <printf>:

void
printf(const char *fmt, ...)
{
 868:	711d                	addi	sp,sp,-96
 86a:	ec06                	sd	ra,24(sp)
 86c:	e822                	sd	s0,16(sp)
 86e:	1000                	addi	s0,sp,32
 870:	e40c                	sd	a1,8(s0)
 872:	e810                	sd	a2,16(s0)
 874:	ec14                	sd	a3,24(s0)
 876:	f018                	sd	a4,32(s0)
 878:	f41c                	sd	a5,40(s0)
 87a:	03043823          	sd	a6,48(s0)
 87e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 882:	00840613          	addi	a2,s0,8
 886:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 88a:	85aa                	mv	a1,a0
 88c:	4505                	li	a0,1
 88e:	00000097          	auipc	ra,0x0
 892:	dce080e7          	jalr	-562(ra) # 65c <vprintf>
}
 896:	60e2                	ld	ra,24(sp)
 898:	6442                	ld	s0,16(sp)
 89a:	6125                	addi	sp,sp,96
 89c:	8082                	ret

000000000000089e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 89e:	1141                	addi	sp,sp,-16
 8a0:	e422                	sd	s0,8(sp)
 8a2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8a4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8a8:	00000797          	auipc	a5,0x0
 8ac:	1c07b783          	ld	a5,448(a5) # a68 <freep>
 8b0:	a805                	j	8e0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8b2:	4618                	lw	a4,8(a2)
 8b4:	9db9                	addw	a1,a1,a4
 8b6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ba:	6398                	ld	a4,0(a5)
 8bc:	6318                	ld	a4,0(a4)
 8be:	fee53823          	sd	a4,-16(a0)
 8c2:	a091                	j	906 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8c4:	ff852703          	lw	a4,-8(a0)
 8c8:	9e39                	addw	a2,a2,a4
 8ca:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8cc:	ff053703          	ld	a4,-16(a0)
 8d0:	e398                	sd	a4,0(a5)
 8d2:	a099                	j	918 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8d4:	6398                	ld	a4,0(a5)
 8d6:	00e7e463          	bltu	a5,a4,8de <free+0x40>
 8da:	00e6ea63          	bltu	a3,a4,8ee <free+0x50>
{
 8de:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e0:	fed7fae3          	bgeu	a5,a3,8d4 <free+0x36>
 8e4:	6398                	ld	a4,0(a5)
 8e6:	00e6e463          	bltu	a3,a4,8ee <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ea:	fee7eae3          	bltu	a5,a4,8de <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8ee:	ff852583          	lw	a1,-8(a0)
 8f2:	6390                	ld	a2,0(a5)
 8f4:	02059813          	slli	a6,a1,0x20
 8f8:	01c85713          	srli	a4,a6,0x1c
 8fc:	9736                	add	a4,a4,a3
 8fe:	fae60ae3          	beq	a2,a4,8b2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 902:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 906:	4790                	lw	a2,8(a5)
 908:	02061593          	slli	a1,a2,0x20
 90c:	01c5d713          	srli	a4,a1,0x1c
 910:	973e                	add	a4,a4,a5
 912:	fae689e3          	beq	a3,a4,8c4 <free+0x26>
  } else
    p->s.ptr = bp;
 916:	e394                	sd	a3,0(a5)
  freep = p;
 918:	00000717          	auipc	a4,0x0
 91c:	14f73823          	sd	a5,336(a4) # a68 <freep>
}
 920:	6422                	ld	s0,8(sp)
 922:	0141                	addi	sp,sp,16
 924:	8082                	ret

0000000000000926 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 926:	7139                	addi	sp,sp,-64
 928:	fc06                	sd	ra,56(sp)
 92a:	f822                	sd	s0,48(sp)
 92c:	f426                	sd	s1,40(sp)
 92e:	f04a                	sd	s2,32(sp)
 930:	ec4e                	sd	s3,24(sp)
 932:	e852                	sd	s4,16(sp)
 934:	e456                	sd	s5,8(sp)
 936:	e05a                	sd	s6,0(sp)
 938:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 93a:	02051493          	slli	s1,a0,0x20
 93e:	9081                	srli	s1,s1,0x20
 940:	04bd                	addi	s1,s1,15
 942:	8091                	srli	s1,s1,0x4
 944:	0014899b          	addiw	s3,s1,1
 948:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 94a:	00000517          	auipc	a0,0x0
 94e:	11e53503          	ld	a0,286(a0) # a68 <freep>
 952:	c515                	beqz	a0,97e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 954:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 956:	4798                	lw	a4,8(a5)
 958:	02977f63          	bgeu	a4,s1,996 <malloc+0x70>
 95c:	8a4e                	mv	s4,s3
 95e:	0009871b          	sext.w	a4,s3
 962:	6685                	lui	a3,0x1
 964:	00d77363          	bgeu	a4,a3,96a <malloc+0x44>
 968:	6a05                	lui	s4,0x1
 96a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 96e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 972:	00000917          	auipc	s2,0x0
 976:	0f690913          	addi	s2,s2,246 # a68 <freep>
  if(p == (char*)-1)
 97a:	5afd                	li	s5,-1
 97c:	a895                	j	9f0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 97e:	00000797          	auipc	a5,0x0
 982:	1e278793          	addi	a5,a5,482 # b60 <base>
 986:	00000717          	auipc	a4,0x0
 98a:	0ef73123          	sd	a5,226(a4) # a68 <freep>
 98e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 990:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 994:	b7e1                	j	95c <malloc+0x36>
      if(p->s.size == nunits)
 996:	02e48c63          	beq	s1,a4,9ce <malloc+0xa8>
        p->s.size -= nunits;
 99a:	4137073b          	subw	a4,a4,s3
 99e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9a0:	02071693          	slli	a3,a4,0x20
 9a4:	01c6d713          	srli	a4,a3,0x1c
 9a8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9aa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ae:	00000717          	auipc	a4,0x0
 9b2:	0aa73d23          	sd	a0,186(a4) # a68 <freep>
      return (void*)(p + 1);
 9b6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ba:	70e2                	ld	ra,56(sp)
 9bc:	7442                	ld	s0,48(sp)
 9be:	74a2                	ld	s1,40(sp)
 9c0:	7902                	ld	s2,32(sp)
 9c2:	69e2                	ld	s3,24(sp)
 9c4:	6a42                	ld	s4,16(sp)
 9c6:	6aa2                	ld	s5,8(sp)
 9c8:	6b02                	ld	s6,0(sp)
 9ca:	6121                	addi	sp,sp,64
 9cc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9ce:	6398                	ld	a4,0(a5)
 9d0:	e118                	sd	a4,0(a0)
 9d2:	bff1                	j	9ae <malloc+0x88>
  hp->s.size = nu;
 9d4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9d8:	0541                	addi	a0,a0,16
 9da:	00000097          	auipc	ra,0x0
 9de:	ec4080e7          	jalr	-316(ra) # 89e <free>
  return freep;
 9e2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9e6:	d971                	beqz	a0,9ba <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9ea:	4798                	lw	a4,8(a5)
 9ec:	fa9775e3          	bgeu	a4,s1,996 <malloc+0x70>
    if(p == freep)
 9f0:	00093703          	ld	a4,0(s2)
 9f4:	853e                	mv	a0,a5
 9f6:	fef719e3          	bne	a4,a5,9e8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 9fa:	8552                	mv	a0,s4
 9fc:	00000097          	auipc	ra,0x0
 a00:	b74080e7          	jalr	-1164(ra) # 570 <sbrk>
  if(p == (char*)-1)
 a04:	fd5518e3          	bne	a0,s5,9d4 <malloc+0xae>
        return 0;
 a08:	4501                	li	a0,0
 a0a:	bf45                	j	9ba <malloc+0x94>
