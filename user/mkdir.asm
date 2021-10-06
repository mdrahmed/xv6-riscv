
user/_mkdir:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
  int i;

  if(argc < 2){
   e:	4785                	li	a5,1
  10:	02a7d763          	bge	a5,a0,3e <main+0x3e>
  14:	00858493          	addi	s1,a1,8
  18:	ffe5091b          	addiw	s2,a0,-2
  1c:	02091793          	slli	a5,s2,0x20
  20:	01d7d913          	srli	s2,a5,0x1d
  24:	05c1                	addi	a1,a1,16
  26:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: mkdir files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(mkdir(argv[i]) < 0){
  28:	6088                	ld	a0,0(s1)
  2a:	00000097          	auipc	ra,0x0
  2e:	566080e7          	jalr	1382(ra) # 590 <mkdir>
  32:	02054463          	bltz	a0,5a <main+0x5a>
  for(i = 1; i < argc; i++){
  36:	04a1                	addi	s1,s1,8
  38:	ff2498e3          	bne	s1,s2,28 <main+0x28>
  3c:	a80d                	j	6e <main+0x6e>
    fprintf(2, "Usage: mkdir files...\n");
  3e:	00001597          	auipc	a1,0x1
  42:	a1258593          	addi	a1,a1,-1518 # a50 <malloc+0xea>
  46:	4509                	li	a0,2
  48:	00001097          	auipc	ra,0x1
  4c:	832080e7          	jalr	-1998(ra) # 87a <fprintf>
    exit(1);
  50:	4505                	li	a0,1
  52:	00000097          	auipc	ra,0x0
  56:	4d6080e7          	jalr	1238(ra) # 528 <exit>
      fprintf(2, "mkdir: %s failed to create\n", argv[i]);
  5a:	6090                	ld	a2,0(s1)
  5c:	00001597          	auipc	a1,0x1
  60:	a0c58593          	addi	a1,a1,-1524 # a68 <malloc+0x102>
  64:	4509                	li	a0,2
  66:	00001097          	auipc	ra,0x1
  6a:	814080e7          	jalr	-2028(ra) # 87a <fprintf>
      break;
    }
  }

  exit(0);
  6e:	4501                	li	a0,0
  70:	00000097          	auipc	ra,0x0
  74:	4b8080e7          	jalr	1208(ra) # 528 <exit>

0000000000000078 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  7e:	0f50000f          	fence	iorw,ow
  82:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  86:	6422                	ld	s0,8(sp)
  88:	0141                	addi	sp,sp,16
  8a:	8082                	ret

000000000000008c <load>:

int load(uint64 *p) {
  8c:	1141                	addi	sp,sp,-16
  8e:	e422                	sd	s0,8(sp)
  90:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  92:	0ff0000f          	fence
  96:	6108                	ld	a0,0(a0)
  98:	0ff0000f          	fence
}
  9c:	2501                	sext.w	a0,a0
  9e:	6422                	ld	s0,8(sp)
  a0:	0141                	addi	sp,sp,16
  a2:	8082                	ret

00000000000000a4 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
  a4:	7179                	addi	sp,sp,-48
  a6:	f406                	sd	ra,40(sp)
  a8:	f022                	sd	s0,32(sp)
  aa:	ec26                	sd	s1,24(sp)
  ac:	e84a                	sd	s2,16(sp)
  ae:	e44e                	sd	s3,8(sp)
  b0:	e052                	sd	s4,0(sp)
  b2:	1800                	addi	s0,sp,48
  b4:	8a2a                	mv	s4,a0
  b6:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  b8:	4785                	li	a5,1
  ba:	00001497          	auipc	s1,0x1
  be:	a0648493          	addi	s1,s1,-1530 # ac0 <rings+0x10>
  c2:	00001917          	auipc	s2,0x1
  c6:	aee90913          	addi	s2,s2,-1298 # bb0 <__BSS_END__>
  ca:	04f59563          	bne	a1,a5,114 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  ce:	00001497          	auipc	s1,0x1
  d2:	9f24a483          	lw	s1,-1550(s1) # ac0 <rings+0x10>
  d6:	c099                	beqz	s1,dc <create_or_close_the_buffer_user+0x38>
  d8:	4481                	li	s1,0
  da:	a899                	j	130 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  dc:	00001917          	auipc	s2,0x1
  e0:	9d490913          	addi	s2,s2,-1580 # ab0 <rings>
  e4:	00093603          	ld	a2,0(s2)
  e8:	4585                	li	a1,1
  ea:	00000097          	auipc	ra,0x0
  ee:	4de080e7          	jalr	1246(ra) # 5c8 <ringbuf>
        rings[i].book->write_done = 0;
  f2:	00893783          	ld	a5,8(s2)
  f6:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
  fa:	00893783          	ld	a5,8(s2)
  fe:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 102:	01092783          	lw	a5,16(s2)
 106:	2785                	addiw	a5,a5,1
 108:	00f92823          	sw	a5,16(s2)
        break;
 10c:	a015                	j	130 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 10e:	04e1                	addi	s1,s1,24
 110:	01248f63          	beq	s1,s2,12e <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 114:	409c                	lw	a5,0(s1)
 116:	dfe5                	beqz	a5,10e <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 118:	ff04b603          	ld	a2,-16(s1)
 11c:	85ce                	mv	a1,s3
 11e:	8552                	mv	a0,s4
 120:	00000097          	auipc	ra,0x0
 124:	4a8080e7          	jalr	1192(ra) # 5c8 <ringbuf>
        rings[i].exists = 0;
 128:	0004a023          	sw	zero,0(s1)
 12c:	b7cd                	j	10e <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 12e:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 130:	8526                	mv	a0,s1
 132:	70a2                	ld	ra,40(sp)
 134:	7402                	ld	s0,32(sp)
 136:	64e2                	ld	s1,24(sp)
 138:	6942                	ld	s2,16(sp)
 13a:	69a2                	ld	s3,8(sp)
 13c:	6a02                	ld	s4,0(sp)
 13e:	6145                	addi	sp,sp,48
 140:	8082                	ret

0000000000000142 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 142:	1101                	addi	sp,sp,-32
 144:	ec06                	sd	ra,24(sp)
 146:	e822                	sd	s0,16(sp)
 148:	e426                	sd	s1,8(sp)
 14a:	1000                	addi	s0,sp,32
 14c:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 14e:	00151793          	slli	a5,a0,0x1
 152:	97aa                	add	a5,a5,a0
 154:	078e                	slli	a5,a5,0x3
 156:	00001717          	auipc	a4,0x1
 15a:	95a70713          	addi	a4,a4,-1702 # ab0 <rings>
 15e:	97ba                	add	a5,a5,a4
 160:	6798                	ld	a4,8(a5)
 162:	671c                	ld	a5,8(a4)
 164:	00178693          	addi	a3,a5,1
 168:	e714                	sd	a3,8(a4)
 16a:	17d2                	slli	a5,a5,0x34
 16c:	93d1                	srli	a5,a5,0x34
 16e:	6741                	lui	a4,0x10
 170:	40f707b3          	sub	a5,a4,a5
 174:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 176:	421c                	lw	a5,0(a2)
 178:	e79d                	bnez	a5,1a6 <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 17a:	00001697          	auipc	a3,0x1
 17e:	93668693          	addi	a3,a3,-1738 # ab0 <rings>
 182:	669c                	ld	a5,8(a3)
 184:	6398                	ld	a4,0(a5)
 186:	67c1                	lui	a5,0x10
 188:	9fb9                	addw	a5,a5,a4
 18a:	00151713          	slli	a4,a0,0x1
 18e:	953a                	add	a0,a0,a4
 190:	050e                	slli	a0,a0,0x3
 192:	9536                	add	a0,a0,a3
 194:	6518                	ld	a4,8(a0)
 196:	6718                	ld	a4,8(a4)
 198:	9f99                	subw	a5,a5,a4
 19a:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 19c:	60e2                	ld	ra,24(sp)
 19e:	6442                	ld	s0,16(sp)
 1a0:	64a2                	ld	s1,8(sp)
 1a2:	6105                	addi	sp,sp,32
 1a4:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 1a6:	00151793          	slli	a5,a0,0x1
 1aa:	953e                	add	a0,a0,a5
 1ac:	050e                	slli	a0,a0,0x3
 1ae:	00001797          	auipc	a5,0x1
 1b2:	90278793          	addi	a5,a5,-1790 # ab0 <rings>
 1b6:	953e                	add	a0,a0,a5
 1b8:	6508                	ld	a0,8(a0)
 1ba:	0521                	addi	a0,a0,8
 1bc:	00000097          	auipc	ra,0x0
 1c0:	ed0080e7          	jalr	-304(ra) # 8c <load>
 1c4:	c088                	sw	a0,0(s1)
}
 1c6:	bfd9                	j	19c <ringbuf_start_write+0x5a>

00000000000001c8 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1c8:	1141                	addi	sp,sp,-16
 1ca:	e406                	sd	ra,8(sp)
 1cc:	e022                	sd	s0,0(sp)
 1ce:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1d0:	00151793          	slli	a5,a0,0x1
 1d4:	97aa                	add	a5,a5,a0
 1d6:	078e                	slli	a5,a5,0x3
 1d8:	00001517          	auipc	a0,0x1
 1dc:	8d850513          	addi	a0,a0,-1832 # ab0 <rings>
 1e0:	97aa                	add	a5,a5,a0
 1e2:	6788                	ld	a0,8(a5)
 1e4:	0035959b          	slliw	a1,a1,0x3
 1e8:	0521                	addi	a0,a0,8
 1ea:	00000097          	auipc	ra,0x0
 1ee:	e8e080e7          	jalr	-370(ra) # 78 <store>
}
 1f2:	60a2                	ld	ra,8(sp)
 1f4:	6402                	ld	s0,0(sp)
 1f6:	0141                	addi	sp,sp,16
 1f8:	8082                	ret

00000000000001fa <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1fa:	1101                	addi	sp,sp,-32
 1fc:	ec06                	sd	ra,24(sp)
 1fe:	e822                	sd	s0,16(sp)
 200:	e426                	sd	s1,8(sp)
 202:	1000                	addi	s0,sp,32
 204:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 206:	00151793          	slli	a5,a0,0x1
 20a:	97aa                	add	a5,a5,a0
 20c:	078e                	slli	a5,a5,0x3
 20e:	00001517          	auipc	a0,0x1
 212:	8a250513          	addi	a0,a0,-1886 # ab0 <rings>
 216:	97aa                	add	a5,a5,a0
 218:	6788                	ld	a0,8(a5)
 21a:	0521                	addi	a0,a0,8
 21c:	00000097          	auipc	ra,0x0
 220:	e70080e7          	jalr	-400(ra) # 8c <load>
 224:	c088                	sw	a0,0(s1)
}
 226:	60e2                	ld	ra,24(sp)
 228:	6442                	ld	s0,16(sp)
 22a:	64a2                	ld	s1,8(sp)
 22c:	6105                	addi	sp,sp,32
 22e:	8082                	ret

0000000000000230 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 230:	1101                	addi	sp,sp,-32
 232:	ec06                	sd	ra,24(sp)
 234:	e822                	sd	s0,16(sp)
 236:	e426                	sd	s1,8(sp)
 238:	1000                	addi	s0,sp,32
 23a:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 23c:	00151793          	slli	a5,a0,0x1
 240:	97aa                	add	a5,a5,a0
 242:	078e                	slli	a5,a5,0x3
 244:	00001517          	auipc	a0,0x1
 248:	86c50513          	addi	a0,a0,-1940 # ab0 <rings>
 24c:	97aa                	add	a5,a5,a0
 24e:	6788                	ld	a0,8(a5)
 250:	611c                	ld	a5,0(a0)
 252:	ef99                	bnez	a5,270 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 254:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 256:	41f7579b          	sraiw	a5,a4,0x1f
 25a:	01d7d79b          	srliw	a5,a5,0x1d
 25e:	9fb9                	addw	a5,a5,a4
 260:	4037d79b          	sraiw	a5,a5,0x3
 264:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 266:	60e2                	ld	ra,24(sp)
 268:	6442                	ld	s0,16(sp)
 26a:	64a2                	ld	s1,8(sp)
 26c:	6105                	addi	sp,sp,32
 26e:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 270:	00000097          	auipc	ra,0x0
 274:	e1c080e7          	jalr	-484(ra) # 8c <load>
    *bytes /= 8;
 278:	41f5579b          	sraiw	a5,a0,0x1f
 27c:	01d7d79b          	srliw	a5,a5,0x1d
 280:	9d3d                	addw	a0,a0,a5
 282:	4035551b          	sraiw	a0,a0,0x3
 286:	c088                	sw	a0,0(s1)
}
 288:	bff9                	j	266 <ringbuf_start_read+0x36>

000000000000028a <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 28a:	1141                	addi	sp,sp,-16
 28c:	e406                	sd	ra,8(sp)
 28e:	e022                	sd	s0,0(sp)
 290:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 292:	00151793          	slli	a5,a0,0x1
 296:	97aa                	add	a5,a5,a0
 298:	078e                	slli	a5,a5,0x3
 29a:	00001517          	auipc	a0,0x1
 29e:	81650513          	addi	a0,a0,-2026 # ab0 <rings>
 2a2:	97aa                	add	a5,a5,a0
 2a4:	0035959b          	slliw	a1,a1,0x3
 2a8:	6788                	ld	a0,8(a5)
 2aa:	00000097          	auipc	ra,0x0
 2ae:	dce080e7          	jalr	-562(ra) # 78 <store>
}
 2b2:	60a2                	ld	ra,8(sp)
 2b4:	6402                	ld	s0,0(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret

00000000000002ba <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2ba:	1141                	addi	sp,sp,-16
 2bc:	e422                	sd	s0,8(sp)
 2be:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2c0:	87aa                	mv	a5,a0
 2c2:	0585                	addi	a1,a1,1
 2c4:	0785                	addi	a5,a5,1
 2c6:	fff5c703          	lbu	a4,-1(a1)
 2ca:	fee78fa3          	sb	a4,-1(a5)
 2ce:	fb75                	bnez	a4,2c2 <strcpy+0x8>
    ;
  return os;
}
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret

00000000000002d6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2dc:	00054783          	lbu	a5,0(a0)
 2e0:	cb91                	beqz	a5,2f4 <strcmp+0x1e>
 2e2:	0005c703          	lbu	a4,0(a1)
 2e6:	00f71763          	bne	a4,a5,2f4 <strcmp+0x1e>
    p++, q++;
 2ea:	0505                	addi	a0,a0,1
 2ec:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2ee:	00054783          	lbu	a5,0(a0)
 2f2:	fbe5                	bnez	a5,2e2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2f4:	0005c503          	lbu	a0,0(a1)
}
 2f8:	40a7853b          	subw	a0,a5,a0
 2fc:	6422                	ld	s0,8(sp)
 2fe:	0141                	addi	sp,sp,16
 300:	8082                	ret

0000000000000302 <strlen>:

uint
strlen(const char *s)
{
 302:	1141                	addi	sp,sp,-16
 304:	e422                	sd	s0,8(sp)
 306:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 308:	00054783          	lbu	a5,0(a0)
 30c:	cf91                	beqz	a5,328 <strlen+0x26>
 30e:	0505                	addi	a0,a0,1
 310:	87aa                	mv	a5,a0
 312:	4685                	li	a3,1
 314:	9e89                	subw	a3,a3,a0
 316:	00f6853b          	addw	a0,a3,a5
 31a:	0785                	addi	a5,a5,1
 31c:	fff7c703          	lbu	a4,-1(a5)
 320:	fb7d                	bnez	a4,316 <strlen+0x14>
    ;
  return n;
}
 322:	6422                	ld	s0,8(sp)
 324:	0141                	addi	sp,sp,16
 326:	8082                	ret
  for(n = 0; s[n]; n++)
 328:	4501                	li	a0,0
 32a:	bfe5                	j	322 <strlen+0x20>

000000000000032c <memset>:

void*
memset(void *dst, int c, uint n)
{
 32c:	1141                	addi	sp,sp,-16
 32e:	e422                	sd	s0,8(sp)
 330:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 332:	ca19                	beqz	a2,348 <memset+0x1c>
 334:	87aa                	mv	a5,a0
 336:	1602                	slli	a2,a2,0x20
 338:	9201                	srli	a2,a2,0x20
 33a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 33e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 342:	0785                	addi	a5,a5,1
 344:	fee79de3          	bne	a5,a4,33e <memset+0x12>
  }
  return dst;
}
 348:	6422                	ld	s0,8(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <strchr>:

char*
strchr(const char *s, char c)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
  for(; *s; s++)
 354:	00054783          	lbu	a5,0(a0)
 358:	cb99                	beqz	a5,36e <strchr+0x20>
    if(*s == c)
 35a:	00f58763          	beq	a1,a5,368 <strchr+0x1a>
  for(; *s; s++)
 35e:	0505                	addi	a0,a0,1
 360:	00054783          	lbu	a5,0(a0)
 364:	fbfd                	bnez	a5,35a <strchr+0xc>
      return (char*)s;
  return 0;
 366:	4501                	li	a0,0
}
 368:	6422                	ld	s0,8(sp)
 36a:	0141                	addi	sp,sp,16
 36c:	8082                	ret
  return 0;
 36e:	4501                	li	a0,0
 370:	bfe5                	j	368 <strchr+0x1a>

0000000000000372 <gets>:

char*
gets(char *buf, int max)
{
 372:	711d                	addi	sp,sp,-96
 374:	ec86                	sd	ra,88(sp)
 376:	e8a2                	sd	s0,80(sp)
 378:	e4a6                	sd	s1,72(sp)
 37a:	e0ca                	sd	s2,64(sp)
 37c:	fc4e                	sd	s3,56(sp)
 37e:	f852                	sd	s4,48(sp)
 380:	f456                	sd	s5,40(sp)
 382:	f05a                	sd	s6,32(sp)
 384:	ec5e                	sd	s7,24(sp)
 386:	1080                	addi	s0,sp,96
 388:	8baa                	mv	s7,a0
 38a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 38c:	892a                	mv	s2,a0
 38e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 390:	4aa9                	li	s5,10
 392:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 394:	89a6                	mv	s3,s1
 396:	2485                	addiw	s1,s1,1
 398:	0344d863          	bge	s1,s4,3c8 <gets+0x56>
    cc = read(0, &c, 1);
 39c:	4605                	li	a2,1
 39e:	faf40593          	addi	a1,s0,-81
 3a2:	4501                	li	a0,0
 3a4:	00000097          	auipc	ra,0x0
 3a8:	19c080e7          	jalr	412(ra) # 540 <read>
    if(cc < 1)
 3ac:	00a05e63          	blez	a0,3c8 <gets+0x56>
    buf[i++] = c;
 3b0:	faf44783          	lbu	a5,-81(s0)
 3b4:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3b8:	01578763          	beq	a5,s5,3c6 <gets+0x54>
 3bc:	0905                	addi	s2,s2,1
 3be:	fd679be3          	bne	a5,s6,394 <gets+0x22>
  for(i=0; i+1 < max; ){
 3c2:	89a6                	mv	s3,s1
 3c4:	a011                	j	3c8 <gets+0x56>
 3c6:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3c8:	99de                	add	s3,s3,s7
 3ca:	00098023          	sb	zero,0(s3)
  return buf;
}
 3ce:	855e                	mv	a0,s7
 3d0:	60e6                	ld	ra,88(sp)
 3d2:	6446                	ld	s0,80(sp)
 3d4:	64a6                	ld	s1,72(sp)
 3d6:	6906                	ld	s2,64(sp)
 3d8:	79e2                	ld	s3,56(sp)
 3da:	7a42                	ld	s4,48(sp)
 3dc:	7aa2                	ld	s5,40(sp)
 3de:	7b02                	ld	s6,32(sp)
 3e0:	6be2                	ld	s7,24(sp)
 3e2:	6125                	addi	sp,sp,96
 3e4:	8082                	ret

00000000000003e6 <stat>:

int
stat(const char *n, struct stat *st)
{
 3e6:	1101                	addi	sp,sp,-32
 3e8:	ec06                	sd	ra,24(sp)
 3ea:	e822                	sd	s0,16(sp)
 3ec:	e426                	sd	s1,8(sp)
 3ee:	e04a                	sd	s2,0(sp)
 3f0:	1000                	addi	s0,sp,32
 3f2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3f4:	4581                	li	a1,0
 3f6:	00000097          	auipc	ra,0x0
 3fa:	172080e7          	jalr	370(ra) # 568 <open>
  if(fd < 0)
 3fe:	02054563          	bltz	a0,428 <stat+0x42>
 402:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 404:	85ca                	mv	a1,s2
 406:	00000097          	auipc	ra,0x0
 40a:	17a080e7          	jalr	378(ra) # 580 <fstat>
 40e:	892a                	mv	s2,a0
  close(fd);
 410:	8526                	mv	a0,s1
 412:	00000097          	auipc	ra,0x0
 416:	13e080e7          	jalr	318(ra) # 550 <close>
  return r;
}
 41a:	854a                	mv	a0,s2
 41c:	60e2                	ld	ra,24(sp)
 41e:	6442                	ld	s0,16(sp)
 420:	64a2                	ld	s1,8(sp)
 422:	6902                	ld	s2,0(sp)
 424:	6105                	addi	sp,sp,32
 426:	8082                	ret
    return -1;
 428:	597d                	li	s2,-1
 42a:	bfc5                	j	41a <stat+0x34>

000000000000042c <atoi>:

int
atoi(const char *s)
{
 42c:	1141                	addi	sp,sp,-16
 42e:	e422                	sd	s0,8(sp)
 430:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 432:	00054603          	lbu	a2,0(a0)
 436:	fd06079b          	addiw	a5,a2,-48
 43a:	0ff7f793          	zext.b	a5,a5
 43e:	4725                	li	a4,9
 440:	02f76963          	bltu	a4,a5,472 <atoi+0x46>
 444:	86aa                	mv	a3,a0
  n = 0;
 446:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 448:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 44a:	0685                	addi	a3,a3,1
 44c:	0025179b          	slliw	a5,a0,0x2
 450:	9fa9                	addw	a5,a5,a0
 452:	0017979b          	slliw	a5,a5,0x1
 456:	9fb1                	addw	a5,a5,a2
 458:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 45c:	0006c603          	lbu	a2,0(a3)
 460:	fd06071b          	addiw	a4,a2,-48
 464:	0ff77713          	zext.b	a4,a4
 468:	fee5f1e3          	bgeu	a1,a4,44a <atoi+0x1e>
  return n;
}
 46c:	6422                	ld	s0,8(sp)
 46e:	0141                	addi	sp,sp,16
 470:	8082                	ret
  n = 0;
 472:	4501                	li	a0,0
 474:	bfe5                	j	46c <atoi+0x40>

0000000000000476 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 476:	1141                	addi	sp,sp,-16
 478:	e422                	sd	s0,8(sp)
 47a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 47c:	02b57463          	bgeu	a0,a1,4a4 <memmove+0x2e>
    while(n-- > 0)
 480:	00c05f63          	blez	a2,49e <memmove+0x28>
 484:	1602                	slli	a2,a2,0x20
 486:	9201                	srli	a2,a2,0x20
 488:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 48c:	872a                	mv	a4,a0
      *dst++ = *src++;
 48e:	0585                	addi	a1,a1,1
 490:	0705                	addi	a4,a4,1
 492:	fff5c683          	lbu	a3,-1(a1)
 496:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xed5e>
    while(n-- > 0)
 49a:	fee79ae3          	bne	a5,a4,48e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 49e:	6422                	ld	s0,8(sp)
 4a0:	0141                	addi	sp,sp,16
 4a2:	8082                	ret
    dst += n;
 4a4:	00c50733          	add	a4,a0,a2
    src += n;
 4a8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4aa:	fec05ae3          	blez	a2,49e <memmove+0x28>
 4ae:	fff6079b          	addiw	a5,a2,-1
 4b2:	1782                	slli	a5,a5,0x20
 4b4:	9381                	srli	a5,a5,0x20
 4b6:	fff7c793          	not	a5,a5
 4ba:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4bc:	15fd                	addi	a1,a1,-1
 4be:	177d                	addi	a4,a4,-1
 4c0:	0005c683          	lbu	a3,0(a1)
 4c4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4c8:	fee79ae3          	bne	a5,a4,4bc <memmove+0x46>
 4cc:	bfc9                	j	49e <memmove+0x28>

00000000000004ce <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ce:	1141                	addi	sp,sp,-16
 4d0:	e422                	sd	s0,8(sp)
 4d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4d4:	ca05                	beqz	a2,504 <memcmp+0x36>
 4d6:	fff6069b          	addiw	a3,a2,-1
 4da:	1682                	slli	a3,a3,0x20
 4dc:	9281                	srli	a3,a3,0x20
 4de:	0685                	addi	a3,a3,1
 4e0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4e2:	00054783          	lbu	a5,0(a0)
 4e6:	0005c703          	lbu	a4,0(a1)
 4ea:	00e79863          	bne	a5,a4,4fa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4ee:	0505                	addi	a0,a0,1
    p2++;
 4f0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4f2:	fed518e3          	bne	a0,a3,4e2 <memcmp+0x14>
  }
  return 0;
 4f6:	4501                	li	a0,0
 4f8:	a019                	j	4fe <memcmp+0x30>
      return *p1 - *p2;
 4fa:	40e7853b          	subw	a0,a5,a4
}
 4fe:	6422                	ld	s0,8(sp)
 500:	0141                	addi	sp,sp,16
 502:	8082                	ret
  return 0;
 504:	4501                	li	a0,0
 506:	bfe5                	j	4fe <memcmp+0x30>

0000000000000508 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 508:	1141                	addi	sp,sp,-16
 50a:	e406                	sd	ra,8(sp)
 50c:	e022                	sd	s0,0(sp)
 50e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 510:	00000097          	auipc	ra,0x0
 514:	f66080e7          	jalr	-154(ra) # 476 <memmove>
}
 518:	60a2                	ld	ra,8(sp)
 51a:	6402                	ld	s0,0(sp)
 51c:	0141                	addi	sp,sp,16
 51e:	8082                	ret

0000000000000520 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 520:	4885                	li	a7,1
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <exit>:
.global exit
exit:
 li a7, SYS_exit
 528:	4889                	li	a7,2
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <wait>:
.global wait
wait:
 li a7, SYS_wait
 530:	488d                	li	a7,3
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 538:	4891                	li	a7,4
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <read>:
.global read
read:
 li a7, SYS_read
 540:	4895                	li	a7,5
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <write>:
.global write
write:
 li a7, SYS_write
 548:	48c1                	li	a7,16
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <close>:
.global close
close:
 li a7, SYS_close
 550:	48d5                	li	a7,21
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <kill>:
.global kill
kill:
 li a7, SYS_kill
 558:	4899                	li	a7,6
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <exec>:
.global exec
exec:
 li a7, SYS_exec
 560:	489d                	li	a7,7
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <open>:
.global open
open:
 li a7, SYS_open
 568:	48bd                	li	a7,15
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 570:	48c5                	li	a7,17
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 578:	48c9                	li	a7,18
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 580:	48a1                	li	a7,8
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <link>:
.global link
link:
 li a7, SYS_link
 588:	48cd                	li	a7,19
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 590:	48d1                	li	a7,20
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 598:	48a5                	li	a7,9
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 5a0:	48a9                	li	a7,10
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5a8:	48ad                	li	a7,11
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5b0:	48b1                	li	a7,12
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5b8:	48b5                	li	a7,13
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5c0:	48b9                	li	a7,14
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5c8:	48d9                	li	a7,22
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5d0:	1101                	addi	sp,sp,-32
 5d2:	ec06                	sd	ra,24(sp)
 5d4:	e822                	sd	s0,16(sp)
 5d6:	1000                	addi	s0,sp,32
 5d8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5dc:	4605                	li	a2,1
 5de:	fef40593          	addi	a1,s0,-17
 5e2:	00000097          	auipc	ra,0x0
 5e6:	f66080e7          	jalr	-154(ra) # 548 <write>
}
 5ea:	60e2                	ld	ra,24(sp)
 5ec:	6442                	ld	s0,16(sp)
 5ee:	6105                	addi	sp,sp,32
 5f0:	8082                	ret

00000000000005f2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5f2:	7139                	addi	sp,sp,-64
 5f4:	fc06                	sd	ra,56(sp)
 5f6:	f822                	sd	s0,48(sp)
 5f8:	f426                	sd	s1,40(sp)
 5fa:	f04a                	sd	s2,32(sp)
 5fc:	ec4e                	sd	s3,24(sp)
 5fe:	0080                	addi	s0,sp,64
 600:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 602:	c299                	beqz	a3,608 <printint+0x16>
 604:	0805c863          	bltz	a1,694 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 608:	2581                	sext.w	a1,a1
  neg = 0;
 60a:	4881                	li	a7,0
 60c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 610:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 612:	2601                	sext.w	a2,a2
 614:	00000517          	auipc	a0,0x0
 618:	47c50513          	addi	a0,a0,1148 # a90 <digits>
 61c:	883a                	mv	a6,a4
 61e:	2705                	addiw	a4,a4,1
 620:	02c5f7bb          	remuw	a5,a1,a2
 624:	1782                	slli	a5,a5,0x20
 626:	9381                	srli	a5,a5,0x20
 628:	97aa                	add	a5,a5,a0
 62a:	0007c783          	lbu	a5,0(a5)
 62e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 632:	0005879b          	sext.w	a5,a1
 636:	02c5d5bb          	divuw	a1,a1,a2
 63a:	0685                	addi	a3,a3,1
 63c:	fec7f0e3          	bgeu	a5,a2,61c <printint+0x2a>
  if(neg)
 640:	00088b63          	beqz	a7,656 <printint+0x64>
    buf[i++] = '-';
 644:	fd040793          	addi	a5,s0,-48
 648:	973e                	add	a4,a4,a5
 64a:	02d00793          	li	a5,45
 64e:	fef70823          	sb	a5,-16(a4)
 652:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 656:	02e05863          	blez	a4,686 <printint+0x94>
 65a:	fc040793          	addi	a5,s0,-64
 65e:	00e78933          	add	s2,a5,a4
 662:	fff78993          	addi	s3,a5,-1
 666:	99ba                	add	s3,s3,a4
 668:	377d                	addiw	a4,a4,-1
 66a:	1702                	slli	a4,a4,0x20
 66c:	9301                	srli	a4,a4,0x20
 66e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 672:	fff94583          	lbu	a1,-1(s2)
 676:	8526                	mv	a0,s1
 678:	00000097          	auipc	ra,0x0
 67c:	f58080e7          	jalr	-168(ra) # 5d0 <putc>
  while(--i >= 0)
 680:	197d                	addi	s2,s2,-1
 682:	ff3918e3          	bne	s2,s3,672 <printint+0x80>
}
 686:	70e2                	ld	ra,56(sp)
 688:	7442                	ld	s0,48(sp)
 68a:	74a2                	ld	s1,40(sp)
 68c:	7902                	ld	s2,32(sp)
 68e:	69e2                	ld	s3,24(sp)
 690:	6121                	addi	sp,sp,64
 692:	8082                	ret
    x = -xx;
 694:	40b005bb          	negw	a1,a1
    neg = 1;
 698:	4885                	li	a7,1
    x = -xx;
 69a:	bf8d                	j	60c <printint+0x1a>

000000000000069c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 69c:	7119                	addi	sp,sp,-128
 69e:	fc86                	sd	ra,120(sp)
 6a0:	f8a2                	sd	s0,112(sp)
 6a2:	f4a6                	sd	s1,104(sp)
 6a4:	f0ca                	sd	s2,96(sp)
 6a6:	ecce                	sd	s3,88(sp)
 6a8:	e8d2                	sd	s4,80(sp)
 6aa:	e4d6                	sd	s5,72(sp)
 6ac:	e0da                	sd	s6,64(sp)
 6ae:	fc5e                	sd	s7,56(sp)
 6b0:	f862                	sd	s8,48(sp)
 6b2:	f466                	sd	s9,40(sp)
 6b4:	f06a                	sd	s10,32(sp)
 6b6:	ec6e                	sd	s11,24(sp)
 6b8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ba:	0005c903          	lbu	s2,0(a1)
 6be:	18090f63          	beqz	s2,85c <vprintf+0x1c0>
 6c2:	8aaa                	mv	s5,a0
 6c4:	8b32                	mv	s6,a2
 6c6:	00158493          	addi	s1,a1,1
  state = 0;
 6ca:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6cc:	02500a13          	li	s4,37
      if(c == 'd'){
 6d0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6d4:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6d8:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6dc:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6e0:	00000b97          	auipc	s7,0x0
 6e4:	3b0b8b93          	addi	s7,s7,944 # a90 <digits>
 6e8:	a839                	j	706 <vprintf+0x6a>
        putc(fd, c);
 6ea:	85ca                	mv	a1,s2
 6ec:	8556                	mv	a0,s5
 6ee:	00000097          	auipc	ra,0x0
 6f2:	ee2080e7          	jalr	-286(ra) # 5d0 <putc>
 6f6:	a019                	j	6fc <vprintf+0x60>
    } else if(state == '%'){
 6f8:	01498f63          	beq	s3,s4,716 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6fc:	0485                	addi	s1,s1,1
 6fe:	fff4c903          	lbu	s2,-1(s1)
 702:	14090d63          	beqz	s2,85c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 706:	0009079b          	sext.w	a5,s2
    if(state == 0){
 70a:	fe0997e3          	bnez	s3,6f8 <vprintf+0x5c>
      if(c == '%'){
 70e:	fd479ee3          	bne	a5,s4,6ea <vprintf+0x4e>
        state = '%';
 712:	89be                	mv	s3,a5
 714:	b7e5                	j	6fc <vprintf+0x60>
      if(c == 'd'){
 716:	05878063          	beq	a5,s8,756 <vprintf+0xba>
      } else if(c == 'l') {
 71a:	05978c63          	beq	a5,s9,772 <vprintf+0xd6>
      } else if(c == 'x') {
 71e:	07a78863          	beq	a5,s10,78e <vprintf+0xf2>
      } else if(c == 'p') {
 722:	09b78463          	beq	a5,s11,7aa <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 726:	07300713          	li	a4,115
 72a:	0ce78663          	beq	a5,a4,7f6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 72e:	06300713          	li	a4,99
 732:	0ee78e63          	beq	a5,a4,82e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 736:	11478863          	beq	a5,s4,846 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 73a:	85d2                	mv	a1,s4
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e92080e7          	jalr	-366(ra) # 5d0 <putc>
        putc(fd, c);
 746:	85ca                	mv	a1,s2
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e86080e7          	jalr	-378(ra) # 5d0 <putc>
      }
      state = 0;
 752:	4981                	li	s3,0
 754:	b765                	j	6fc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 756:	008b0913          	addi	s2,s6,8
 75a:	4685                	li	a3,1
 75c:	4629                	li	a2,10
 75e:	000b2583          	lw	a1,0(s6)
 762:	8556                	mv	a0,s5
 764:	00000097          	auipc	ra,0x0
 768:	e8e080e7          	jalr	-370(ra) # 5f2 <printint>
 76c:	8b4a                	mv	s6,s2
      state = 0;
 76e:	4981                	li	s3,0
 770:	b771                	j	6fc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 772:	008b0913          	addi	s2,s6,8
 776:	4681                	li	a3,0
 778:	4629                	li	a2,10
 77a:	000b2583          	lw	a1,0(s6)
 77e:	8556                	mv	a0,s5
 780:	00000097          	auipc	ra,0x0
 784:	e72080e7          	jalr	-398(ra) # 5f2 <printint>
 788:	8b4a                	mv	s6,s2
      state = 0;
 78a:	4981                	li	s3,0
 78c:	bf85                	j	6fc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 78e:	008b0913          	addi	s2,s6,8
 792:	4681                	li	a3,0
 794:	4641                	li	a2,16
 796:	000b2583          	lw	a1,0(s6)
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	e56080e7          	jalr	-426(ra) # 5f2 <printint>
 7a4:	8b4a                	mv	s6,s2
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	bf91                	j	6fc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7aa:	008b0793          	addi	a5,s6,8
 7ae:	f8f43423          	sd	a5,-120(s0)
 7b2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7b6:	03000593          	li	a1,48
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e14080e7          	jalr	-492(ra) # 5d0 <putc>
  putc(fd, 'x');
 7c4:	85ea                	mv	a1,s10
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	e08080e7          	jalr	-504(ra) # 5d0 <putc>
 7d0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7d2:	03c9d793          	srli	a5,s3,0x3c
 7d6:	97de                	add	a5,a5,s7
 7d8:	0007c583          	lbu	a1,0(a5)
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	df2080e7          	jalr	-526(ra) # 5d0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7e6:	0992                	slli	s3,s3,0x4
 7e8:	397d                	addiw	s2,s2,-1
 7ea:	fe0914e3          	bnez	s2,7d2 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7ee:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7f2:	4981                	li	s3,0
 7f4:	b721                	j	6fc <vprintf+0x60>
        s = va_arg(ap, char*);
 7f6:	008b0993          	addi	s3,s6,8
 7fa:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7fe:	02090163          	beqz	s2,820 <vprintf+0x184>
        while(*s != 0){
 802:	00094583          	lbu	a1,0(s2)
 806:	c9a1                	beqz	a1,856 <vprintf+0x1ba>
          putc(fd, *s);
 808:	8556                	mv	a0,s5
 80a:	00000097          	auipc	ra,0x0
 80e:	dc6080e7          	jalr	-570(ra) # 5d0 <putc>
          s++;
 812:	0905                	addi	s2,s2,1
        while(*s != 0){
 814:	00094583          	lbu	a1,0(s2)
 818:	f9e5                	bnez	a1,808 <vprintf+0x16c>
        s = va_arg(ap, char*);
 81a:	8b4e                	mv	s6,s3
      state = 0;
 81c:	4981                	li	s3,0
 81e:	bdf9                	j	6fc <vprintf+0x60>
          s = "(null)";
 820:	00000917          	auipc	s2,0x0
 824:	26890913          	addi	s2,s2,616 # a88 <malloc+0x122>
        while(*s != 0){
 828:	02800593          	li	a1,40
 82c:	bff1                	j	808 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 82e:	008b0913          	addi	s2,s6,8
 832:	000b4583          	lbu	a1,0(s6)
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	d98080e7          	jalr	-616(ra) # 5d0 <putc>
 840:	8b4a                	mv	s6,s2
      state = 0;
 842:	4981                	li	s3,0
 844:	bd65                	j	6fc <vprintf+0x60>
        putc(fd, c);
 846:	85d2                	mv	a1,s4
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	d86080e7          	jalr	-634(ra) # 5d0 <putc>
      state = 0;
 852:	4981                	li	s3,0
 854:	b565                	j	6fc <vprintf+0x60>
        s = va_arg(ap, char*);
 856:	8b4e                	mv	s6,s3
      state = 0;
 858:	4981                	li	s3,0
 85a:	b54d                	j	6fc <vprintf+0x60>
    }
  }
}
 85c:	70e6                	ld	ra,120(sp)
 85e:	7446                	ld	s0,112(sp)
 860:	74a6                	ld	s1,104(sp)
 862:	7906                	ld	s2,96(sp)
 864:	69e6                	ld	s3,88(sp)
 866:	6a46                	ld	s4,80(sp)
 868:	6aa6                	ld	s5,72(sp)
 86a:	6b06                	ld	s6,64(sp)
 86c:	7be2                	ld	s7,56(sp)
 86e:	7c42                	ld	s8,48(sp)
 870:	7ca2                	ld	s9,40(sp)
 872:	7d02                	ld	s10,32(sp)
 874:	6de2                	ld	s11,24(sp)
 876:	6109                	addi	sp,sp,128
 878:	8082                	ret

000000000000087a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 87a:	715d                	addi	sp,sp,-80
 87c:	ec06                	sd	ra,24(sp)
 87e:	e822                	sd	s0,16(sp)
 880:	1000                	addi	s0,sp,32
 882:	e010                	sd	a2,0(s0)
 884:	e414                	sd	a3,8(s0)
 886:	e818                	sd	a4,16(s0)
 888:	ec1c                	sd	a5,24(s0)
 88a:	03043023          	sd	a6,32(s0)
 88e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 892:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 896:	8622                	mv	a2,s0
 898:	00000097          	auipc	ra,0x0
 89c:	e04080e7          	jalr	-508(ra) # 69c <vprintf>
}
 8a0:	60e2                	ld	ra,24(sp)
 8a2:	6442                	ld	s0,16(sp)
 8a4:	6161                	addi	sp,sp,80
 8a6:	8082                	ret

00000000000008a8 <printf>:

void
printf(const char *fmt, ...)
{
 8a8:	711d                	addi	sp,sp,-96
 8aa:	ec06                	sd	ra,24(sp)
 8ac:	e822                	sd	s0,16(sp)
 8ae:	1000                	addi	s0,sp,32
 8b0:	e40c                	sd	a1,8(s0)
 8b2:	e810                	sd	a2,16(s0)
 8b4:	ec14                	sd	a3,24(s0)
 8b6:	f018                	sd	a4,32(s0)
 8b8:	f41c                	sd	a5,40(s0)
 8ba:	03043823          	sd	a6,48(s0)
 8be:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8c2:	00840613          	addi	a2,s0,8
 8c6:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8ca:	85aa                	mv	a1,a0
 8cc:	4505                	li	a0,1
 8ce:	00000097          	auipc	ra,0x0
 8d2:	dce080e7          	jalr	-562(ra) # 69c <vprintf>
}
 8d6:	60e2                	ld	ra,24(sp)
 8d8:	6442                	ld	s0,16(sp)
 8da:	6125                	addi	sp,sp,96
 8dc:	8082                	ret

00000000000008de <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8de:	1141                	addi	sp,sp,-16
 8e0:	e422                	sd	s0,8(sp)
 8e2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8e4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8e8:	00000797          	auipc	a5,0x0
 8ec:	1c07b783          	ld	a5,448(a5) # aa8 <freep>
 8f0:	a805                	j	920 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8f2:	4618                	lw	a4,8(a2)
 8f4:	9db9                	addw	a1,a1,a4
 8f6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8fa:	6398                	ld	a4,0(a5)
 8fc:	6318                	ld	a4,0(a4)
 8fe:	fee53823          	sd	a4,-16(a0)
 902:	a091                	j	946 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 904:	ff852703          	lw	a4,-8(a0)
 908:	9e39                	addw	a2,a2,a4
 90a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 90c:	ff053703          	ld	a4,-16(a0)
 910:	e398                	sd	a4,0(a5)
 912:	a099                	j	958 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 914:	6398                	ld	a4,0(a5)
 916:	00e7e463          	bltu	a5,a4,91e <free+0x40>
 91a:	00e6ea63          	bltu	a3,a4,92e <free+0x50>
{
 91e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 920:	fed7fae3          	bgeu	a5,a3,914 <free+0x36>
 924:	6398                	ld	a4,0(a5)
 926:	00e6e463          	bltu	a3,a4,92e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92a:	fee7eae3          	bltu	a5,a4,91e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 92e:	ff852583          	lw	a1,-8(a0)
 932:	6390                	ld	a2,0(a5)
 934:	02059813          	slli	a6,a1,0x20
 938:	01c85713          	srli	a4,a6,0x1c
 93c:	9736                	add	a4,a4,a3
 93e:	fae60ae3          	beq	a2,a4,8f2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 942:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 946:	4790                	lw	a2,8(a5)
 948:	02061593          	slli	a1,a2,0x20
 94c:	01c5d713          	srli	a4,a1,0x1c
 950:	973e                	add	a4,a4,a5
 952:	fae689e3          	beq	a3,a4,904 <free+0x26>
  } else
    p->s.ptr = bp;
 956:	e394                	sd	a3,0(a5)
  freep = p;
 958:	00000717          	auipc	a4,0x0
 95c:	14f73823          	sd	a5,336(a4) # aa8 <freep>
}
 960:	6422                	ld	s0,8(sp)
 962:	0141                	addi	sp,sp,16
 964:	8082                	ret

0000000000000966 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 966:	7139                	addi	sp,sp,-64
 968:	fc06                	sd	ra,56(sp)
 96a:	f822                	sd	s0,48(sp)
 96c:	f426                	sd	s1,40(sp)
 96e:	f04a                	sd	s2,32(sp)
 970:	ec4e                	sd	s3,24(sp)
 972:	e852                	sd	s4,16(sp)
 974:	e456                	sd	s5,8(sp)
 976:	e05a                	sd	s6,0(sp)
 978:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 97a:	02051493          	slli	s1,a0,0x20
 97e:	9081                	srli	s1,s1,0x20
 980:	04bd                	addi	s1,s1,15
 982:	8091                	srli	s1,s1,0x4
 984:	0014899b          	addiw	s3,s1,1
 988:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 98a:	00000517          	auipc	a0,0x0
 98e:	11e53503          	ld	a0,286(a0) # aa8 <freep>
 992:	c515                	beqz	a0,9be <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 994:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 996:	4798                	lw	a4,8(a5)
 998:	02977f63          	bgeu	a4,s1,9d6 <malloc+0x70>
 99c:	8a4e                	mv	s4,s3
 99e:	0009871b          	sext.w	a4,s3
 9a2:	6685                	lui	a3,0x1
 9a4:	00d77363          	bgeu	a4,a3,9aa <malloc+0x44>
 9a8:	6a05                	lui	s4,0x1
 9aa:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9ae:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b2:	00000917          	auipc	s2,0x0
 9b6:	0f690913          	addi	s2,s2,246 # aa8 <freep>
  if(p == (char*)-1)
 9ba:	5afd                	li	s5,-1
 9bc:	a895                	j	a30 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9be:	00000797          	auipc	a5,0x0
 9c2:	1e278793          	addi	a5,a5,482 # ba0 <base>
 9c6:	00000717          	auipc	a4,0x0
 9ca:	0ef73123          	sd	a5,226(a4) # aa8 <freep>
 9ce:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9d0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9d4:	b7e1                	j	99c <malloc+0x36>
      if(p->s.size == nunits)
 9d6:	02e48c63          	beq	s1,a4,a0e <malloc+0xa8>
        p->s.size -= nunits;
 9da:	4137073b          	subw	a4,a4,s3
 9de:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9e0:	02071693          	slli	a3,a4,0x20
 9e4:	01c6d713          	srli	a4,a3,0x1c
 9e8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ea:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ee:	00000717          	auipc	a4,0x0
 9f2:	0aa73d23          	sd	a0,186(a4) # aa8 <freep>
      return (void*)(p + 1);
 9f6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9fa:	70e2                	ld	ra,56(sp)
 9fc:	7442                	ld	s0,48(sp)
 9fe:	74a2                	ld	s1,40(sp)
 a00:	7902                	ld	s2,32(sp)
 a02:	69e2                	ld	s3,24(sp)
 a04:	6a42                	ld	s4,16(sp)
 a06:	6aa2                	ld	s5,8(sp)
 a08:	6b02                	ld	s6,0(sp)
 a0a:	6121                	addi	sp,sp,64
 a0c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a0e:	6398                	ld	a4,0(a5)
 a10:	e118                	sd	a4,0(a0)
 a12:	bff1                	j	9ee <malloc+0x88>
  hp->s.size = nu;
 a14:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a18:	0541                	addi	a0,a0,16
 a1a:	00000097          	auipc	ra,0x0
 a1e:	ec4080e7          	jalr	-316(ra) # 8de <free>
  return freep;
 a22:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a26:	d971                	beqz	a0,9fa <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a28:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a2a:	4798                	lw	a4,8(a5)
 a2c:	fa9775e3          	bgeu	a4,s1,9d6 <malloc+0x70>
    if(p == freep)
 a30:	00093703          	ld	a4,0(s2)
 a34:	853e                	mv	a0,a5
 a36:	fef719e3          	bne	a4,a5,a28 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a3a:	8552                	mv	a0,s4
 a3c:	00000097          	auipc	ra,0x0
 a40:	b74080e7          	jalr	-1164(ra) # 5b0 <sbrk>
  if(p == (char*)-1)
 a44:	fd5518e3          	bne	a0,s5,a14 <malloc+0xae>
        return 0;
 a48:	4501                	li	a0,0
 a4a:	bf45                	j	9fa <malloc+0x94>
