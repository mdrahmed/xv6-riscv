
user/_echo:     file format elf64-littleriscv


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
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  int i;

  for(i = 1; i < argc; i++){
  10:	4785                	li	a5,1
  12:	06a7d463          	bge	a5,a0,7a <main+0x7a>
  16:	00858493          	addi	s1,a1,8
  1a:	ffe5099b          	addiw	s3,a0,-2
  1e:	02099793          	slli	a5,s3,0x20
  22:	01d7d993          	srli	s3,a5,0x1d
  26:	05c1                	addi	a1,a1,16
  28:	99ae                	add	s3,s3,a1
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  2a:	00001a17          	auipc	s4,0x1
  2e:	a16a0a13          	addi	s4,s4,-1514 # a40 <malloc+0xe6>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	2be080e7          	jalr	702(ra) # 2f6 <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	4f4080e7          	jalr	1268(ra) # 53c <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	4e0080e7          	jalr	1248(ra) # 53c <write>
  for(i = 1; i < argc; i++){
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	9e058593          	addi	a1,a1,-1568 # a48 <malloc+0xee>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	4ca080e7          	jalr	1226(ra) # 53c <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	4a0080e7          	jalr	1184(ra) # 51c <exit>

0000000000000084 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  84:	1141                	addi	sp,sp,-16
  86:	e422                	sd	s0,8(sp)
  88:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  8a:	0f50000f          	fence	iorw,ow
  8e:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  92:	6422                	ld	s0,8(sp)
  94:	0141                	addi	sp,sp,16
  96:	8082                	ret

0000000000000098 <load>:

int load(uint64 *p) {
  98:	1141                	addi	sp,sp,-16
  9a:	e422                	sd	s0,8(sp)
  9c:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  9e:	0ff0000f          	fence
  a2:	6108                	ld	a0,0(a0)
  a4:	0ff0000f          	fence
}
  a8:	2501                	sext.w	a0,a0
  aa:	6422                	ld	s0,8(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
  b0:	7179                	addi	sp,sp,-48
  b2:	f406                	sd	ra,40(sp)
  b4:	f022                	sd	s0,32(sp)
  b6:	ec26                	sd	s1,24(sp)
  b8:	e84a                	sd	s2,16(sp)
  ba:	e44e                	sd	s3,8(sp)
  bc:	e052                	sd	s4,0(sp)
  be:	1800                	addi	s0,sp,48
  c0:	8a2a                	mv	s4,a0
  c2:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  c4:	4785                	li	a5,1
  c6:	00001497          	auipc	s1,0x1
  ca:	9c248493          	addi	s1,s1,-1598 # a88 <rings+0x10>
  ce:	00001917          	auipc	s2,0x1
  d2:	aaa90913          	addi	s2,s2,-1366 # b78 <__BSS_END__>
  d6:	04f59563          	bne	a1,a5,120 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  da:	00001497          	auipc	s1,0x1
  de:	9ae4a483          	lw	s1,-1618(s1) # a88 <rings+0x10>
  e2:	c099                	beqz	s1,e8 <create_or_close_the_buffer_user+0x38>
  e4:	4481                	li	s1,0
  e6:	a899                	j	13c <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  e8:	00001917          	auipc	s2,0x1
  ec:	99090913          	addi	s2,s2,-1648 # a78 <rings>
  f0:	00093603          	ld	a2,0(s2)
  f4:	4585                	li	a1,1
  f6:	00000097          	auipc	ra,0x0
  fa:	4c6080e7          	jalr	1222(ra) # 5bc <ringbuf>
        rings[i].book->write_done = 0;
  fe:	00893783          	ld	a5,8(s2)
 102:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 106:	00893783          	ld	a5,8(s2)
 10a:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 10e:	01092783          	lw	a5,16(s2)
 112:	2785                	addiw	a5,a5,1
 114:	00f92823          	sw	a5,16(s2)
        break;
 118:	a015                	j	13c <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 11a:	04e1                	addi	s1,s1,24
 11c:	01248f63          	beq	s1,s2,13a <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 120:	409c                	lw	a5,0(s1)
 122:	dfe5                	beqz	a5,11a <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 124:	ff04b603          	ld	a2,-16(s1)
 128:	85ce                	mv	a1,s3
 12a:	8552                	mv	a0,s4
 12c:	00000097          	auipc	ra,0x0
 130:	490080e7          	jalr	1168(ra) # 5bc <ringbuf>
        rings[i].exists = 0;
 134:	0004a023          	sw	zero,0(s1)
 138:	b7cd                	j	11a <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 13a:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 13c:	8526                	mv	a0,s1
 13e:	70a2                	ld	ra,40(sp)
 140:	7402                	ld	s0,32(sp)
 142:	64e2                	ld	s1,24(sp)
 144:	6942                	ld	s2,16(sp)
 146:	69a2                	ld	s3,8(sp)
 148:	6a02                	ld	s4,0(sp)
 14a:	6145                	addi	sp,sp,48
 14c:	8082                	ret

000000000000014e <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 14e:	1101                	addi	sp,sp,-32
 150:	ec06                	sd	ra,24(sp)
 152:	e822                	sd	s0,16(sp)
 154:	e426                	sd	s1,8(sp)
 156:	1000                	addi	s0,sp,32
 158:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 15a:	00151793          	slli	a5,a0,0x1
 15e:	97aa                	add	a5,a5,a0
 160:	078e                	slli	a5,a5,0x3
 162:	00001717          	auipc	a4,0x1
 166:	91670713          	addi	a4,a4,-1770 # a78 <rings>
 16a:	97ba                	add	a5,a5,a4
 16c:	639c                	ld	a5,0(a5)
 16e:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 170:	421c                	lw	a5,0(a2)
 172:	e785                	bnez	a5,19a <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 174:	86ba                	mv	a3,a4
 176:	671c                	ld	a5,8(a4)
 178:	6398                	ld	a4,0(a5)
 17a:	67c1                	lui	a5,0x10
 17c:	9fb9                	addw	a5,a5,a4
 17e:	00151713          	slli	a4,a0,0x1
 182:	953a                	add	a0,a0,a4
 184:	050e                	slli	a0,a0,0x3
 186:	9536                	add	a0,a0,a3
 188:	6518                	ld	a4,8(a0)
 18a:	6718                	ld	a4,8(a4)
 18c:	9f99                	subw	a5,a5,a4
 18e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 190:	60e2                	ld	ra,24(sp)
 192:	6442                	ld	s0,16(sp)
 194:	64a2                	ld	s1,8(sp)
 196:	6105                	addi	sp,sp,32
 198:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 19a:	00151793          	slli	a5,a0,0x1
 19e:	953e                	add	a0,a0,a5
 1a0:	050e                	slli	a0,a0,0x3
 1a2:	00001797          	auipc	a5,0x1
 1a6:	8d678793          	addi	a5,a5,-1834 # a78 <rings>
 1aa:	953e                	add	a0,a0,a5
 1ac:	6508                	ld	a0,8(a0)
 1ae:	0521                	addi	a0,a0,8
 1b0:	00000097          	auipc	ra,0x0
 1b4:	ee8080e7          	jalr	-280(ra) # 98 <load>
 1b8:	c088                	sw	a0,0(s1)
}
 1ba:	bfd9                	j	190 <ringbuf_start_write+0x42>

00000000000001bc <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1bc:	1141                	addi	sp,sp,-16
 1be:	e406                	sd	ra,8(sp)
 1c0:	e022                	sd	s0,0(sp)
 1c2:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1c4:	00151793          	slli	a5,a0,0x1
 1c8:	97aa                	add	a5,a5,a0
 1ca:	078e                	slli	a5,a5,0x3
 1cc:	00001517          	auipc	a0,0x1
 1d0:	8ac50513          	addi	a0,a0,-1876 # a78 <rings>
 1d4:	97aa                	add	a5,a5,a0
 1d6:	6788                	ld	a0,8(a5)
 1d8:	0035959b          	slliw	a1,a1,0x3
 1dc:	0521                	addi	a0,a0,8
 1de:	00000097          	auipc	ra,0x0
 1e2:	ea6080e7          	jalr	-346(ra) # 84 <store>
}
 1e6:	60a2                	ld	ra,8(sp)
 1e8:	6402                	ld	s0,0(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret

00000000000001ee <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1ee:	1101                	addi	sp,sp,-32
 1f0:	ec06                	sd	ra,24(sp)
 1f2:	e822                	sd	s0,16(sp)
 1f4:	e426                	sd	s1,8(sp)
 1f6:	1000                	addi	s0,sp,32
 1f8:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1fa:	00151793          	slli	a5,a0,0x1
 1fe:	97aa                	add	a5,a5,a0
 200:	078e                	slli	a5,a5,0x3
 202:	00001517          	auipc	a0,0x1
 206:	87650513          	addi	a0,a0,-1930 # a78 <rings>
 20a:	97aa                	add	a5,a5,a0
 20c:	6788                	ld	a0,8(a5)
 20e:	0521                	addi	a0,a0,8
 210:	00000097          	auipc	ra,0x0
 214:	e88080e7          	jalr	-376(ra) # 98 <load>
 218:	c088                	sw	a0,0(s1)
}
 21a:	60e2                	ld	ra,24(sp)
 21c:	6442                	ld	s0,16(sp)
 21e:	64a2                	ld	s1,8(sp)
 220:	6105                	addi	sp,sp,32
 222:	8082                	ret

0000000000000224 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 224:	1101                	addi	sp,sp,-32
 226:	ec06                	sd	ra,24(sp)
 228:	e822                	sd	s0,16(sp)
 22a:	e426                	sd	s1,8(sp)
 22c:	1000                	addi	s0,sp,32
 22e:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 230:	00151793          	slli	a5,a0,0x1
 234:	97aa                	add	a5,a5,a0
 236:	078e                	slli	a5,a5,0x3
 238:	00001517          	auipc	a0,0x1
 23c:	84050513          	addi	a0,a0,-1984 # a78 <rings>
 240:	97aa                	add	a5,a5,a0
 242:	6788                	ld	a0,8(a5)
 244:	611c                	ld	a5,0(a0)
 246:	ef99                	bnez	a5,264 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 248:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 24a:	41f7579b          	sraiw	a5,a4,0x1f
 24e:	01d7d79b          	srliw	a5,a5,0x1d
 252:	9fb9                	addw	a5,a5,a4
 254:	4037d79b          	sraiw	a5,a5,0x3
 258:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 25a:	60e2                	ld	ra,24(sp)
 25c:	6442                	ld	s0,16(sp)
 25e:	64a2                	ld	s1,8(sp)
 260:	6105                	addi	sp,sp,32
 262:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 264:	00000097          	auipc	ra,0x0
 268:	e34080e7          	jalr	-460(ra) # 98 <load>
    *bytes /= 8;
 26c:	41f5579b          	sraiw	a5,a0,0x1f
 270:	01d7d79b          	srliw	a5,a5,0x1d
 274:	9d3d                	addw	a0,a0,a5
 276:	4035551b          	sraiw	a0,a0,0x3
 27a:	c088                	sw	a0,0(s1)
}
 27c:	bff9                	j	25a <ringbuf_start_read+0x36>

000000000000027e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 286:	00151793          	slli	a5,a0,0x1
 28a:	97aa                	add	a5,a5,a0
 28c:	078e                	slli	a5,a5,0x3
 28e:	00000517          	auipc	a0,0x0
 292:	7ea50513          	addi	a0,a0,2026 # a78 <rings>
 296:	97aa                	add	a5,a5,a0
 298:	0035959b          	slliw	a1,a1,0x3
 29c:	6788                	ld	a0,8(a5)
 29e:	00000097          	auipc	ra,0x0
 2a2:	de6080e7          	jalr	-538(ra) # 84 <store>
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e422                	sd	s0,8(sp)
 2b2:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b4:	87aa                	mv	a5,a0
 2b6:	0585                	addi	a1,a1,1
 2b8:	0785                	addi	a5,a5,1
 2ba:	fff5c703          	lbu	a4,-1(a1)
 2be:	fee78fa3          	sb	a4,-1(a5)
 2c2:	fb75                	bnez	a4,2b6 <strcpy+0x8>
    ;
  return os;
}
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e422                	sd	s0,8(sp)
 2ce:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2d0:	00054783          	lbu	a5,0(a0)
 2d4:	cb91                	beqz	a5,2e8 <strcmp+0x1e>
 2d6:	0005c703          	lbu	a4,0(a1)
 2da:	00f71763          	bne	a4,a5,2e8 <strcmp+0x1e>
    p++, q++;
 2de:	0505                	addi	a0,a0,1
 2e0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	fbe5                	bnez	a5,2d6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2e8:	0005c503          	lbu	a0,0(a1)
}
 2ec:	40a7853b          	subw	a0,a5,a0
 2f0:	6422                	ld	s0,8(sp)
 2f2:	0141                	addi	sp,sp,16
 2f4:	8082                	ret

00000000000002f6 <strlen>:

uint
strlen(const char *s)
{
 2f6:	1141                	addi	sp,sp,-16
 2f8:	e422                	sd	s0,8(sp)
 2fa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2fc:	00054783          	lbu	a5,0(a0)
 300:	cf91                	beqz	a5,31c <strlen+0x26>
 302:	0505                	addi	a0,a0,1
 304:	87aa                	mv	a5,a0
 306:	4685                	li	a3,1
 308:	9e89                	subw	a3,a3,a0
 30a:	00f6853b          	addw	a0,a3,a5
 30e:	0785                	addi	a5,a5,1
 310:	fff7c703          	lbu	a4,-1(a5)
 314:	fb7d                	bnez	a4,30a <strlen+0x14>
    ;
  return n;
}
 316:	6422                	ld	s0,8(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret
  for(n = 0; s[n]; n++)
 31c:	4501                	li	a0,0
 31e:	bfe5                	j	316 <strlen+0x20>

0000000000000320 <memset>:

void*
memset(void *dst, int c, uint n)
{
 320:	1141                	addi	sp,sp,-16
 322:	e422                	sd	s0,8(sp)
 324:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 326:	ca19                	beqz	a2,33c <memset+0x1c>
 328:	87aa                	mv	a5,a0
 32a:	1602                	slli	a2,a2,0x20
 32c:	9201                	srli	a2,a2,0x20
 32e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 332:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 336:	0785                	addi	a5,a5,1
 338:	fee79de3          	bne	a5,a4,332 <memset+0x12>
  }
  return dst;
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret

0000000000000342 <strchr>:

char*
strchr(const char *s, char c)
{
 342:	1141                	addi	sp,sp,-16
 344:	e422                	sd	s0,8(sp)
 346:	0800                	addi	s0,sp,16
  for(; *s; s++)
 348:	00054783          	lbu	a5,0(a0)
 34c:	cb99                	beqz	a5,362 <strchr+0x20>
    if(*s == c)
 34e:	00f58763          	beq	a1,a5,35c <strchr+0x1a>
  for(; *s; s++)
 352:	0505                	addi	a0,a0,1
 354:	00054783          	lbu	a5,0(a0)
 358:	fbfd                	bnez	a5,34e <strchr+0xc>
      return (char*)s;
  return 0;
 35a:	4501                	li	a0,0
}
 35c:	6422                	ld	s0,8(sp)
 35e:	0141                	addi	sp,sp,16
 360:	8082                	ret
  return 0;
 362:	4501                	li	a0,0
 364:	bfe5                	j	35c <strchr+0x1a>

0000000000000366 <gets>:

char*
gets(char *buf, int max)
{
 366:	711d                	addi	sp,sp,-96
 368:	ec86                	sd	ra,88(sp)
 36a:	e8a2                	sd	s0,80(sp)
 36c:	e4a6                	sd	s1,72(sp)
 36e:	e0ca                	sd	s2,64(sp)
 370:	fc4e                	sd	s3,56(sp)
 372:	f852                	sd	s4,48(sp)
 374:	f456                	sd	s5,40(sp)
 376:	f05a                	sd	s6,32(sp)
 378:	ec5e                	sd	s7,24(sp)
 37a:	1080                	addi	s0,sp,96
 37c:	8baa                	mv	s7,a0
 37e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 380:	892a                	mv	s2,a0
 382:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 384:	4aa9                	li	s5,10
 386:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 388:	89a6                	mv	s3,s1
 38a:	2485                	addiw	s1,s1,1
 38c:	0344d863          	bge	s1,s4,3bc <gets+0x56>
    cc = read(0, &c, 1);
 390:	4605                	li	a2,1
 392:	faf40593          	addi	a1,s0,-81
 396:	4501                	li	a0,0
 398:	00000097          	auipc	ra,0x0
 39c:	19c080e7          	jalr	412(ra) # 534 <read>
    if(cc < 1)
 3a0:	00a05e63          	blez	a0,3bc <gets+0x56>
    buf[i++] = c;
 3a4:	faf44783          	lbu	a5,-81(s0)
 3a8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3ac:	01578763          	beq	a5,s5,3ba <gets+0x54>
 3b0:	0905                	addi	s2,s2,1
 3b2:	fd679be3          	bne	a5,s6,388 <gets+0x22>
  for(i=0; i+1 < max; ){
 3b6:	89a6                	mv	s3,s1
 3b8:	a011                	j	3bc <gets+0x56>
 3ba:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3bc:	99de                	add	s3,s3,s7
 3be:	00098023          	sb	zero,0(s3)
  return buf;
}
 3c2:	855e                	mv	a0,s7
 3c4:	60e6                	ld	ra,88(sp)
 3c6:	6446                	ld	s0,80(sp)
 3c8:	64a6                	ld	s1,72(sp)
 3ca:	6906                	ld	s2,64(sp)
 3cc:	79e2                	ld	s3,56(sp)
 3ce:	7a42                	ld	s4,48(sp)
 3d0:	7aa2                	ld	s5,40(sp)
 3d2:	7b02                	ld	s6,32(sp)
 3d4:	6be2                	ld	s7,24(sp)
 3d6:	6125                	addi	sp,sp,96
 3d8:	8082                	ret

00000000000003da <stat>:

int
stat(const char *n, struct stat *st)
{
 3da:	1101                	addi	sp,sp,-32
 3dc:	ec06                	sd	ra,24(sp)
 3de:	e822                	sd	s0,16(sp)
 3e0:	e426                	sd	s1,8(sp)
 3e2:	e04a                	sd	s2,0(sp)
 3e4:	1000                	addi	s0,sp,32
 3e6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e8:	4581                	li	a1,0
 3ea:	00000097          	auipc	ra,0x0
 3ee:	172080e7          	jalr	370(ra) # 55c <open>
  if(fd < 0)
 3f2:	02054563          	bltz	a0,41c <stat+0x42>
 3f6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3f8:	85ca                	mv	a1,s2
 3fa:	00000097          	auipc	ra,0x0
 3fe:	17a080e7          	jalr	378(ra) # 574 <fstat>
 402:	892a                	mv	s2,a0
  close(fd);
 404:	8526                	mv	a0,s1
 406:	00000097          	auipc	ra,0x0
 40a:	13e080e7          	jalr	318(ra) # 544 <close>
  return r;
}
 40e:	854a                	mv	a0,s2
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	64a2                	ld	s1,8(sp)
 416:	6902                	ld	s2,0(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret
    return -1;
 41c:	597d                	li	s2,-1
 41e:	bfc5                	j	40e <stat+0x34>

0000000000000420 <atoi>:

int
atoi(const char *s)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 426:	00054603          	lbu	a2,0(a0)
 42a:	fd06079b          	addiw	a5,a2,-48
 42e:	0ff7f793          	zext.b	a5,a5
 432:	4725                	li	a4,9
 434:	02f76963          	bltu	a4,a5,466 <atoi+0x46>
 438:	86aa                	mv	a3,a0
  n = 0;
 43a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 43c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 43e:	0685                	addi	a3,a3,1
 440:	0025179b          	slliw	a5,a0,0x2
 444:	9fa9                	addw	a5,a5,a0
 446:	0017979b          	slliw	a5,a5,0x1
 44a:	9fb1                	addw	a5,a5,a2
 44c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 450:	0006c603          	lbu	a2,0(a3)
 454:	fd06071b          	addiw	a4,a2,-48
 458:	0ff77713          	zext.b	a4,a4
 45c:	fee5f1e3          	bgeu	a1,a4,43e <atoi+0x1e>
  return n;
}
 460:	6422                	ld	s0,8(sp)
 462:	0141                	addi	sp,sp,16
 464:	8082                	ret
  n = 0;
 466:	4501                	li	a0,0
 468:	bfe5                	j	460 <atoi+0x40>

000000000000046a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 46a:	1141                	addi	sp,sp,-16
 46c:	e422                	sd	s0,8(sp)
 46e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 470:	02b57463          	bgeu	a0,a1,498 <memmove+0x2e>
    while(n-- > 0)
 474:	00c05f63          	blez	a2,492 <memmove+0x28>
 478:	1602                	slli	a2,a2,0x20
 47a:	9201                	srli	a2,a2,0x20
 47c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 480:	872a                	mv	a4,a0
      *dst++ = *src++;
 482:	0585                	addi	a1,a1,1
 484:	0705                	addi	a4,a4,1
 486:	fff5c683          	lbu	a3,-1(a1)
 48a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 48e:	fee79ae3          	bne	a5,a4,482 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 492:	6422                	ld	s0,8(sp)
 494:	0141                	addi	sp,sp,16
 496:	8082                	ret
    dst += n;
 498:	00c50733          	add	a4,a0,a2
    src += n;
 49c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 49e:	fec05ae3          	blez	a2,492 <memmove+0x28>
 4a2:	fff6079b          	addiw	a5,a2,-1
 4a6:	1782                	slli	a5,a5,0x20
 4a8:	9381                	srli	a5,a5,0x20
 4aa:	fff7c793          	not	a5,a5
 4ae:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4b0:	15fd                	addi	a1,a1,-1
 4b2:	177d                	addi	a4,a4,-1
 4b4:	0005c683          	lbu	a3,0(a1)
 4b8:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4bc:	fee79ae3          	bne	a5,a4,4b0 <memmove+0x46>
 4c0:	bfc9                	j	492 <memmove+0x28>

00000000000004c2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4c2:	1141                	addi	sp,sp,-16
 4c4:	e422                	sd	s0,8(sp)
 4c6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4c8:	ca05                	beqz	a2,4f8 <memcmp+0x36>
 4ca:	fff6069b          	addiw	a3,a2,-1
 4ce:	1682                	slli	a3,a3,0x20
 4d0:	9281                	srli	a3,a3,0x20
 4d2:	0685                	addi	a3,a3,1
 4d4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4d6:	00054783          	lbu	a5,0(a0)
 4da:	0005c703          	lbu	a4,0(a1)
 4de:	00e79863          	bne	a5,a4,4ee <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4e2:	0505                	addi	a0,a0,1
    p2++;
 4e4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4e6:	fed518e3          	bne	a0,a3,4d6 <memcmp+0x14>
  }
  return 0;
 4ea:	4501                	li	a0,0
 4ec:	a019                	j	4f2 <memcmp+0x30>
      return *p1 - *p2;
 4ee:	40e7853b          	subw	a0,a5,a4
}
 4f2:	6422                	ld	s0,8(sp)
 4f4:	0141                	addi	sp,sp,16
 4f6:	8082                	ret
  return 0;
 4f8:	4501                	li	a0,0
 4fa:	bfe5                	j	4f2 <memcmp+0x30>

00000000000004fc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4fc:	1141                	addi	sp,sp,-16
 4fe:	e406                	sd	ra,8(sp)
 500:	e022                	sd	s0,0(sp)
 502:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 504:	00000097          	auipc	ra,0x0
 508:	f66080e7          	jalr	-154(ra) # 46a <memmove>
}
 50c:	60a2                	ld	ra,8(sp)
 50e:	6402                	ld	s0,0(sp)
 510:	0141                	addi	sp,sp,16
 512:	8082                	ret

0000000000000514 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 514:	4885                	li	a7,1
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <exit>:
.global exit
exit:
 li a7, SYS_exit
 51c:	4889                	li	a7,2
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <wait>:
.global wait
wait:
 li a7, SYS_wait
 524:	488d                	li	a7,3
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 52c:	4891                	li	a7,4
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <read>:
.global read
read:
 li a7, SYS_read
 534:	4895                	li	a7,5
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <write>:
.global write
write:
 li a7, SYS_write
 53c:	48c1                	li	a7,16
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <close>:
.global close
close:
 li a7, SYS_close
 544:	48d5                	li	a7,21
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <kill>:
.global kill
kill:
 li a7, SYS_kill
 54c:	4899                	li	a7,6
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <exec>:
.global exec
exec:
 li a7, SYS_exec
 554:	489d                	li	a7,7
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <open>:
.global open
open:
 li a7, SYS_open
 55c:	48bd                	li	a7,15
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 564:	48c5                	li	a7,17
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 56c:	48c9                	li	a7,18
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 574:	48a1                	li	a7,8
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <link>:
.global link
link:
 li a7, SYS_link
 57c:	48cd                	li	a7,19
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 584:	48d1                	li	a7,20
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 58c:	48a5                	li	a7,9
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <dup>:
.global dup
dup:
 li a7, SYS_dup
 594:	48a9                	li	a7,10
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 59c:	48ad                	li	a7,11
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5a4:	48b1                	li	a7,12
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5ac:	48b5                	li	a7,13
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5b4:	48b9                	li	a7,14
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5bc:	48d9                	li	a7,22
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5c4:	1101                	addi	sp,sp,-32
 5c6:	ec06                	sd	ra,24(sp)
 5c8:	e822                	sd	s0,16(sp)
 5ca:	1000                	addi	s0,sp,32
 5cc:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5d0:	4605                	li	a2,1
 5d2:	fef40593          	addi	a1,s0,-17
 5d6:	00000097          	auipc	ra,0x0
 5da:	f66080e7          	jalr	-154(ra) # 53c <write>
}
 5de:	60e2                	ld	ra,24(sp)
 5e0:	6442                	ld	s0,16(sp)
 5e2:	6105                	addi	sp,sp,32
 5e4:	8082                	ret

00000000000005e6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5e6:	7139                	addi	sp,sp,-64
 5e8:	fc06                	sd	ra,56(sp)
 5ea:	f822                	sd	s0,48(sp)
 5ec:	f426                	sd	s1,40(sp)
 5ee:	f04a                	sd	s2,32(sp)
 5f0:	ec4e                	sd	s3,24(sp)
 5f2:	0080                	addi	s0,sp,64
 5f4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5f6:	c299                	beqz	a3,5fc <printint+0x16>
 5f8:	0805c863          	bltz	a1,688 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5fc:	2581                	sext.w	a1,a1
  neg = 0;
 5fe:	4881                	li	a7,0
 600:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 604:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 606:	2601                	sext.w	a2,a2
 608:	00000517          	auipc	a0,0x0
 60c:	45050513          	addi	a0,a0,1104 # a58 <digits>
 610:	883a                	mv	a6,a4
 612:	2705                	addiw	a4,a4,1
 614:	02c5f7bb          	remuw	a5,a1,a2
 618:	1782                	slli	a5,a5,0x20
 61a:	9381                	srli	a5,a5,0x20
 61c:	97aa                	add	a5,a5,a0
 61e:	0007c783          	lbu	a5,0(a5)
 622:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 626:	0005879b          	sext.w	a5,a1
 62a:	02c5d5bb          	divuw	a1,a1,a2
 62e:	0685                	addi	a3,a3,1
 630:	fec7f0e3          	bgeu	a5,a2,610 <printint+0x2a>
  if(neg)
 634:	00088b63          	beqz	a7,64a <printint+0x64>
    buf[i++] = '-';
 638:	fd040793          	addi	a5,s0,-48
 63c:	973e                	add	a4,a4,a5
 63e:	02d00793          	li	a5,45
 642:	fef70823          	sb	a5,-16(a4)
 646:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 64a:	02e05863          	blez	a4,67a <printint+0x94>
 64e:	fc040793          	addi	a5,s0,-64
 652:	00e78933          	add	s2,a5,a4
 656:	fff78993          	addi	s3,a5,-1
 65a:	99ba                	add	s3,s3,a4
 65c:	377d                	addiw	a4,a4,-1
 65e:	1702                	slli	a4,a4,0x20
 660:	9301                	srli	a4,a4,0x20
 662:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 666:	fff94583          	lbu	a1,-1(s2)
 66a:	8526                	mv	a0,s1
 66c:	00000097          	auipc	ra,0x0
 670:	f58080e7          	jalr	-168(ra) # 5c4 <putc>
  while(--i >= 0)
 674:	197d                	addi	s2,s2,-1
 676:	ff3918e3          	bne	s2,s3,666 <printint+0x80>
}
 67a:	70e2                	ld	ra,56(sp)
 67c:	7442                	ld	s0,48(sp)
 67e:	74a2                	ld	s1,40(sp)
 680:	7902                	ld	s2,32(sp)
 682:	69e2                	ld	s3,24(sp)
 684:	6121                	addi	sp,sp,64
 686:	8082                	ret
    x = -xx;
 688:	40b005bb          	negw	a1,a1
    neg = 1;
 68c:	4885                	li	a7,1
    x = -xx;
 68e:	bf8d                	j	600 <printint+0x1a>

0000000000000690 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 690:	7119                	addi	sp,sp,-128
 692:	fc86                	sd	ra,120(sp)
 694:	f8a2                	sd	s0,112(sp)
 696:	f4a6                	sd	s1,104(sp)
 698:	f0ca                	sd	s2,96(sp)
 69a:	ecce                	sd	s3,88(sp)
 69c:	e8d2                	sd	s4,80(sp)
 69e:	e4d6                	sd	s5,72(sp)
 6a0:	e0da                	sd	s6,64(sp)
 6a2:	fc5e                	sd	s7,56(sp)
 6a4:	f862                	sd	s8,48(sp)
 6a6:	f466                	sd	s9,40(sp)
 6a8:	f06a                	sd	s10,32(sp)
 6aa:	ec6e                	sd	s11,24(sp)
 6ac:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6ae:	0005c903          	lbu	s2,0(a1)
 6b2:	18090f63          	beqz	s2,850 <vprintf+0x1c0>
 6b6:	8aaa                	mv	s5,a0
 6b8:	8b32                	mv	s6,a2
 6ba:	00158493          	addi	s1,a1,1
  state = 0;
 6be:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6c0:	02500a13          	li	s4,37
      if(c == 'd'){
 6c4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6c8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6cc:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6d0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6d4:	00000b97          	auipc	s7,0x0
 6d8:	384b8b93          	addi	s7,s7,900 # a58 <digits>
 6dc:	a839                	j	6fa <vprintf+0x6a>
        putc(fd, c);
 6de:	85ca                	mv	a1,s2
 6e0:	8556                	mv	a0,s5
 6e2:	00000097          	auipc	ra,0x0
 6e6:	ee2080e7          	jalr	-286(ra) # 5c4 <putc>
 6ea:	a019                	j	6f0 <vprintf+0x60>
    } else if(state == '%'){
 6ec:	01498f63          	beq	s3,s4,70a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6f0:	0485                	addi	s1,s1,1
 6f2:	fff4c903          	lbu	s2,-1(s1)
 6f6:	14090d63          	beqz	s2,850 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6fa:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6fe:	fe0997e3          	bnez	s3,6ec <vprintf+0x5c>
      if(c == '%'){
 702:	fd479ee3          	bne	a5,s4,6de <vprintf+0x4e>
        state = '%';
 706:	89be                	mv	s3,a5
 708:	b7e5                	j	6f0 <vprintf+0x60>
      if(c == 'd'){
 70a:	05878063          	beq	a5,s8,74a <vprintf+0xba>
      } else if(c == 'l') {
 70e:	05978c63          	beq	a5,s9,766 <vprintf+0xd6>
      } else if(c == 'x') {
 712:	07a78863          	beq	a5,s10,782 <vprintf+0xf2>
      } else if(c == 'p') {
 716:	09b78463          	beq	a5,s11,79e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 71a:	07300713          	li	a4,115
 71e:	0ce78663          	beq	a5,a4,7ea <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 722:	06300713          	li	a4,99
 726:	0ee78e63          	beq	a5,a4,822 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 72a:	11478863          	beq	a5,s4,83a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 72e:	85d2                	mv	a1,s4
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	e92080e7          	jalr	-366(ra) # 5c4 <putc>
        putc(fd, c);
 73a:	85ca                	mv	a1,s2
 73c:	8556                	mv	a0,s5
 73e:	00000097          	auipc	ra,0x0
 742:	e86080e7          	jalr	-378(ra) # 5c4 <putc>
      }
      state = 0;
 746:	4981                	li	s3,0
 748:	b765                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 74a:	008b0913          	addi	s2,s6,8
 74e:	4685                	li	a3,1
 750:	4629                	li	a2,10
 752:	000b2583          	lw	a1,0(s6)
 756:	8556                	mv	a0,s5
 758:	00000097          	auipc	ra,0x0
 75c:	e8e080e7          	jalr	-370(ra) # 5e6 <printint>
 760:	8b4a                	mv	s6,s2
      state = 0;
 762:	4981                	li	s3,0
 764:	b771                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 766:	008b0913          	addi	s2,s6,8
 76a:	4681                	li	a3,0
 76c:	4629                	li	a2,10
 76e:	000b2583          	lw	a1,0(s6)
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	e72080e7          	jalr	-398(ra) # 5e6 <printint>
 77c:	8b4a                	mv	s6,s2
      state = 0;
 77e:	4981                	li	s3,0
 780:	bf85                	j	6f0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 782:	008b0913          	addi	s2,s6,8
 786:	4681                	li	a3,0
 788:	4641                	li	a2,16
 78a:	000b2583          	lw	a1,0(s6)
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	e56080e7          	jalr	-426(ra) # 5e6 <printint>
 798:	8b4a                	mv	s6,s2
      state = 0;
 79a:	4981                	li	s3,0
 79c:	bf91                	j	6f0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 79e:	008b0793          	addi	a5,s6,8
 7a2:	f8f43423          	sd	a5,-120(s0)
 7a6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7aa:	03000593          	li	a1,48
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e14080e7          	jalr	-492(ra) # 5c4 <putc>
  putc(fd, 'x');
 7b8:	85ea                	mv	a1,s10
 7ba:	8556                	mv	a0,s5
 7bc:	00000097          	auipc	ra,0x0
 7c0:	e08080e7          	jalr	-504(ra) # 5c4 <putc>
 7c4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7c6:	03c9d793          	srli	a5,s3,0x3c
 7ca:	97de                	add	a5,a5,s7
 7cc:	0007c583          	lbu	a1,0(a5)
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	df2080e7          	jalr	-526(ra) # 5c4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7da:	0992                	slli	s3,s3,0x4
 7dc:	397d                	addiw	s2,s2,-1
 7de:	fe0914e3          	bnez	s2,7c6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7e2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	b721                	j	6f0 <vprintf+0x60>
        s = va_arg(ap, char*);
 7ea:	008b0993          	addi	s3,s6,8
 7ee:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7f2:	02090163          	beqz	s2,814 <vprintf+0x184>
        while(*s != 0){
 7f6:	00094583          	lbu	a1,0(s2)
 7fa:	c9a1                	beqz	a1,84a <vprintf+0x1ba>
          putc(fd, *s);
 7fc:	8556                	mv	a0,s5
 7fe:	00000097          	auipc	ra,0x0
 802:	dc6080e7          	jalr	-570(ra) # 5c4 <putc>
          s++;
 806:	0905                	addi	s2,s2,1
        while(*s != 0){
 808:	00094583          	lbu	a1,0(s2)
 80c:	f9e5                	bnez	a1,7fc <vprintf+0x16c>
        s = va_arg(ap, char*);
 80e:	8b4e                	mv	s6,s3
      state = 0;
 810:	4981                	li	s3,0
 812:	bdf9                	j	6f0 <vprintf+0x60>
          s = "(null)";
 814:	00000917          	auipc	s2,0x0
 818:	23c90913          	addi	s2,s2,572 # a50 <malloc+0xf6>
        while(*s != 0){
 81c:	02800593          	li	a1,40
 820:	bff1                	j	7fc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 822:	008b0913          	addi	s2,s6,8
 826:	000b4583          	lbu	a1,0(s6)
 82a:	8556                	mv	a0,s5
 82c:	00000097          	auipc	ra,0x0
 830:	d98080e7          	jalr	-616(ra) # 5c4 <putc>
 834:	8b4a                	mv	s6,s2
      state = 0;
 836:	4981                	li	s3,0
 838:	bd65                	j	6f0 <vprintf+0x60>
        putc(fd, c);
 83a:	85d2                	mv	a1,s4
 83c:	8556                	mv	a0,s5
 83e:	00000097          	auipc	ra,0x0
 842:	d86080e7          	jalr	-634(ra) # 5c4 <putc>
      state = 0;
 846:	4981                	li	s3,0
 848:	b565                	j	6f0 <vprintf+0x60>
        s = va_arg(ap, char*);
 84a:	8b4e                	mv	s6,s3
      state = 0;
 84c:	4981                	li	s3,0
 84e:	b54d                	j	6f0 <vprintf+0x60>
    }
  }
}
 850:	70e6                	ld	ra,120(sp)
 852:	7446                	ld	s0,112(sp)
 854:	74a6                	ld	s1,104(sp)
 856:	7906                	ld	s2,96(sp)
 858:	69e6                	ld	s3,88(sp)
 85a:	6a46                	ld	s4,80(sp)
 85c:	6aa6                	ld	s5,72(sp)
 85e:	6b06                	ld	s6,64(sp)
 860:	7be2                	ld	s7,56(sp)
 862:	7c42                	ld	s8,48(sp)
 864:	7ca2                	ld	s9,40(sp)
 866:	7d02                	ld	s10,32(sp)
 868:	6de2                	ld	s11,24(sp)
 86a:	6109                	addi	sp,sp,128
 86c:	8082                	ret

000000000000086e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 86e:	715d                	addi	sp,sp,-80
 870:	ec06                	sd	ra,24(sp)
 872:	e822                	sd	s0,16(sp)
 874:	1000                	addi	s0,sp,32
 876:	e010                	sd	a2,0(s0)
 878:	e414                	sd	a3,8(s0)
 87a:	e818                	sd	a4,16(s0)
 87c:	ec1c                	sd	a5,24(s0)
 87e:	03043023          	sd	a6,32(s0)
 882:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 886:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 88a:	8622                	mv	a2,s0
 88c:	00000097          	auipc	ra,0x0
 890:	e04080e7          	jalr	-508(ra) # 690 <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6161                	addi	sp,sp,80
 89a:	8082                	ret

000000000000089c <printf>:

void
printf(const char *fmt, ...)
{
 89c:	711d                	addi	sp,sp,-96
 89e:	ec06                	sd	ra,24(sp)
 8a0:	e822                	sd	s0,16(sp)
 8a2:	1000                	addi	s0,sp,32
 8a4:	e40c                	sd	a1,8(s0)
 8a6:	e810                	sd	a2,16(s0)
 8a8:	ec14                	sd	a3,24(s0)
 8aa:	f018                	sd	a4,32(s0)
 8ac:	f41c                	sd	a5,40(s0)
 8ae:	03043823          	sd	a6,48(s0)
 8b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b6:	00840613          	addi	a2,s0,8
 8ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8be:	85aa                	mv	a1,a0
 8c0:	4505                	li	a0,1
 8c2:	00000097          	auipc	ra,0x0
 8c6:	dce080e7          	jalr	-562(ra) # 690 <vprintf>
}
 8ca:	60e2                	ld	ra,24(sp)
 8cc:	6442                	ld	s0,16(sp)
 8ce:	6125                	addi	sp,sp,96
 8d0:	8082                	ret

00000000000008d2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8d2:	1141                	addi	sp,sp,-16
 8d4:	e422                	sd	s0,8(sp)
 8d6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8dc:	00000797          	auipc	a5,0x0
 8e0:	1947b783          	ld	a5,404(a5) # a70 <freep>
 8e4:	a805                	j	914 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e6:	4618                	lw	a4,8(a2)
 8e8:	9db9                	addw	a1,a1,a4
 8ea:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ee:	6398                	ld	a4,0(a5)
 8f0:	6318                	ld	a4,0(a4)
 8f2:	fee53823          	sd	a4,-16(a0)
 8f6:	a091                	j	93a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f8:	ff852703          	lw	a4,-8(a0)
 8fc:	9e39                	addw	a2,a2,a4
 8fe:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 900:	ff053703          	ld	a4,-16(a0)
 904:	e398                	sd	a4,0(a5)
 906:	a099                	j	94c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 908:	6398                	ld	a4,0(a5)
 90a:	00e7e463          	bltu	a5,a4,912 <free+0x40>
 90e:	00e6ea63          	bltu	a3,a4,922 <free+0x50>
{
 912:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 914:	fed7fae3          	bgeu	a5,a3,908 <free+0x36>
 918:	6398                	ld	a4,0(a5)
 91a:	00e6e463          	bltu	a3,a4,922 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 91e:	fee7eae3          	bltu	a5,a4,912 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 922:	ff852583          	lw	a1,-8(a0)
 926:	6390                	ld	a2,0(a5)
 928:	02059813          	slli	a6,a1,0x20
 92c:	01c85713          	srli	a4,a6,0x1c
 930:	9736                	add	a4,a4,a3
 932:	fae60ae3          	beq	a2,a4,8e6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 936:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 93a:	4790                	lw	a2,8(a5)
 93c:	02061593          	slli	a1,a2,0x20
 940:	01c5d713          	srli	a4,a1,0x1c
 944:	973e                	add	a4,a4,a5
 946:	fae689e3          	beq	a3,a4,8f8 <free+0x26>
  } else
    p->s.ptr = bp;
 94a:	e394                	sd	a3,0(a5)
  freep = p;
 94c:	00000717          	auipc	a4,0x0
 950:	12f73223          	sd	a5,292(a4) # a70 <freep>
}
 954:	6422                	ld	s0,8(sp)
 956:	0141                	addi	sp,sp,16
 958:	8082                	ret

000000000000095a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 95a:	7139                	addi	sp,sp,-64
 95c:	fc06                	sd	ra,56(sp)
 95e:	f822                	sd	s0,48(sp)
 960:	f426                	sd	s1,40(sp)
 962:	f04a                	sd	s2,32(sp)
 964:	ec4e                	sd	s3,24(sp)
 966:	e852                	sd	s4,16(sp)
 968:	e456                	sd	s5,8(sp)
 96a:	e05a                	sd	s6,0(sp)
 96c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 96e:	02051493          	slli	s1,a0,0x20
 972:	9081                	srli	s1,s1,0x20
 974:	04bd                	addi	s1,s1,15
 976:	8091                	srli	s1,s1,0x4
 978:	0014899b          	addiw	s3,s1,1
 97c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 97e:	00000517          	auipc	a0,0x0
 982:	0f253503          	ld	a0,242(a0) # a70 <freep>
 986:	c515                	beqz	a0,9b2 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 988:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98a:	4798                	lw	a4,8(a5)
 98c:	02977f63          	bgeu	a4,s1,9ca <malloc+0x70>
 990:	8a4e                	mv	s4,s3
 992:	0009871b          	sext.w	a4,s3
 996:	6685                	lui	a3,0x1
 998:	00d77363          	bgeu	a4,a3,99e <malloc+0x44>
 99c:	6a05                	lui	s4,0x1
 99e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9a2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9a6:	00000917          	auipc	s2,0x0
 9aa:	0ca90913          	addi	s2,s2,202 # a70 <freep>
  if(p == (char*)-1)
 9ae:	5afd                	li	s5,-1
 9b0:	a895                	j	a24 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9b2:	00000797          	auipc	a5,0x0
 9b6:	1b678793          	addi	a5,a5,438 # b68 <base>
 9ba:	00000717          	auipc	a4,0x0
 9be:	0af73b23          	sd	a5,182(a4) # a70 <freep>
 9c2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9c4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9c8:	b7e1                	j	990 <malloc+0x36>
      if(p->s.size == nunits)
 9ca:	02e48c63          	beq	s1,a4,a02 <malloc+0xa8>
        p->s.size -= nunits;
 9ce:	4137073b          	subw	a4,a4,s3
 9d2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9d4:	02071693          	slli	a3,a4,0x20
 9d8:	01c6d713          	srli	a4,a3,0x1c
 9dc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9de:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9e2:	00000717          	auipc	a4,0x0
 9e6:	08a73723          	sd	a0,142(a4) # a70 <freep>
      return (void*)(p + 1);
 9ea:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ee:	70e2                	ld	ra,56(sp)
 9f0:	7442                	ld	s0,48(sp)
 9f2:	74a2                	ld	s1,40(sp)
 9f4:	7902                	ld	s2,32(sp)
 9f6:	69e2                	ld	s3,24(sp)
 9f8:	6a42                	ld	s4,16(sp)
 9fa:	6aa2                	ld	s5,8(sp)
 9fc:	6b02                	ld	s6,0(sp)
 9fe:	6121                	addi	sp,sp,64
 a00:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a02:	6398                	ld	a4,0(a5)
 a04:	e118                	sd	a4,0(a0)
 a06:	bff1                	j	9e2 <malloc+0x88>
  hp->s.size = nu;
 a08:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a0c:	0541                	addi	a0,a0,16
 a0e:	00000097          	auipc	ra,0x0
 a12:	ec4080e7          	jalr	-316(ra) # 8d2 <free>
  return freep;
 a16:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a1a:	d971                	beqz	a0,9ee <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a1e:	4798                	lw	a4,8(a5)
 a20:	fa9775e3          	bgeu	a4,s1,9ca <malloc+0x70>
    if(p == freep)
 a24:	00093703          	ld	a4,0(s2)
 a28:	853e                	mv	a0,a5
 a2a:	fef719e3          	bne	a4,a5,a1c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a2e:	8552                	mv	a0,s4
 a30:	00000097          	auipc	ra,0x0
 a34:	b74080e7          	jalr	-1164(ra) # 5a4 <sbrk>
  if(p == (char*)-1)
 a38:	fd5518e3          	bne	a0,s5,a08 <malloc+0xae>
        return 0;
 a3c:	4501                	li	a0,0
 a3e:	bf45                	j	9ee <malloc+0x94>
