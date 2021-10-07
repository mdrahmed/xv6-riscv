
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  if(argc != 3){
   a:	478d                	li	a5,3
   c:	02f50063          	beq	a0,a5,2c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	a1058593          	addi	a1,a1,-1520 # a20 <malloc+0xea>
  18:	4509                	li	a0,2
  1a:	00001097          	auipc	ra,0x1
  1e:	830080e7          	jalr	-2000(ra) # 84a <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	4d4080e7          	jalr	1236(ra) # 4f8 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	526080e7          	jalr	1318(ra) # 558 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	4b8080e7          	jalr	1208(ra) # 4f8 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	9ec58593          	addi	a1,a1,-1556 # a38 <malloc+0x102>
  54:	4509                	li	a0,2
  56:	00000097          	auipc	ra,0x0
  5a:	7f4080e7          	jalr	2036(ra) # 84a <fprintf>
  5e:	b7c5                	j	3e <main+0x3e>

0000000000000060 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  60:	1141                	addi	sp,sp,-16
  62:	e422                	sd	s0,8(sp)
  64:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  66:	0f50000f          	fence	iorw,ow
  6a:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  6e:	6422                	ld	s0,8(sp)
  70:	0141                	addi	sp,sp,16
  72:	8082                	ret

0000000000000074 <load>:

int load(uint64 *p) {
  74:	1141                	addi	sp,sp,-16
  76:	e422                	sd	s0,8(sp)
  78:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  7a:	0ff0000f          	fence
  7e:	6108                	ld	a0,0(a0)
  80:	0ff0000f          	fence
}
  84:	2501                	sext.w	a0,a0
  86:	6422                	ld	s0,8(sp)
  88:	0141                	addi	sp,sp,16
  8a:	8082                	ret

000000000000008c <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
  8c:	7179                	addi	sp,sp,-48
  8e:	f406                	sd	ra,40(sp)
  90:	f022                	sd	s0,32(sp)
  92:	ec26                	sd	s1,24(sp)
  94:	e84a                	sd	s2,16(sp)
  96:	e44e                	sd	s3,8(sp)
  98:	e052                	sd	s4,0(sp)
  9a:	1800                	addi	s0,sp,48
  9c:	8a2a                	mv	s4,a0
  9e:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  a0:	4785                	li	a5,1
  a2:	00001497          	auipc	s1,0x1
  a6:	9e648493          	addi	s1,s1,-1562 # a88 <rings+0x10>
  aa:	00001917          	auipc	s2,0x1
  ae:	ace90913          	addi	s2,s2,-1330 # b78 <__BSS_END__>
  b2:	04f59563          	bne	a1,a5,fc <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  b6:	00001497          	auipc	s1,0x1
  ba:	9d24a483          	lw	s1,-1582(s1) # a88 <rings+0x10>
  be:	c099                	beqz	s1,c4 <create_or_close_the_buffer_user+0x38>
  c0:	4481                	li	s1,0
  c2:	a899                	j	118 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  c4:	00001917          	auipc	s2,0x1
  c8:	9b490913          	addi	s2,s2,-1612 # a78 <rings>
  cc:	00093603          	ld	a2,0(s2)
  d0:	4585                	li	a1,1
  d2:	00000097          	auipc	ra,0x0
  d6:	4c6080e7          	jalr	1222(ra) # 598 <ringbuf>
        rings[i].book->write_done = 0;
  da:	00893783          	ld	a5,8(s2)
  de:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
  e2:	00893783          	ld	a5,8(s2)
  e6:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
  ea:	01092783          	lw	a5,16(s2)
  ee:	2785                	addiw	a5,a5,1
  f0:	00f92823          	sw	a5,16(s2)
        break;
  f4:	a015                	j	118 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
  f6:	04e1                	addi	s1,s1,24
  f8:	01248f63          	beq	s1,s2,116 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
  fc:	409c                	lw	a5,0(s1)
  fe:	dfe5                	beqz	a5,f6 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 100:	ff04b603          	ld	a2,-16(s1)
 104:	85ce                	mv	a1,s3
 106:	8552                	mv	a0,s4
 108:	00000097          	auipc	ra,0x0
 10c:	490080e7          	jalr	1168(ra) # 598 <ringbuf>
        rings[i].exists = 0;
 110:	0004a023          	sw	zero,0(s1)
 114:	b7cd                	j	f6 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 116:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 118:	8526                	mv	a0,s1
 11a:	70a2                	ld	ra,40(sp)
 11c:	7402                	ld	s0,32(sp)
 11e:	64e2                	ld	s1,24(sp)
 120:	6942                	ld	s2,16(sp)
 122:	69a2                	ld	s3,8(sp)
 124:	6a02                	ld	s4,0(sp)
 126:	6145                	addi	sp,sp,48
 128:	8082                	ret

000000000000012a <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 12a:	1101                	addi	sp,sp,-32
 12c:	ec06                	sd	ra,24(sp)
 12e:	e822                	sd	s0,16(sp)
 130:	e426                	sd	s1,8(sp)
 132:	1000                	addi	s0,sp,32
 134:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 136:	00151793          	slli	a5,a0,0x1
 13a:	97aa                	add	a5,a5,a0
 13c:	078e                	slli	a5,a5,0x3
 13e:	00001717          	auipc	a4,0x1
 142:	93a70713          	addi	a4,a4,-1734 # a78 <rings>
 146:	97ba                	add	a5,a5,a4
 148:	639c                	ld	a5,0(a5)
 14a:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 14c:	421c                	lw	a5,0(a2)
 14e:	e785                	bnez	a5,176 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 150:	86ba                	mv	a3,a4
 152:	671c                	ld	a5,8(a4)
 154:	6398                	ld	a4,0(a5)
 156:	67c1                	lui	a5,0x10
 158:	9fb9                	addw	a5,a5,a4
 15a:	00151713          	slli	a4,a0,0x1
 15e:	953a                	add	a0,a0,a4
 160:	050e                	slli	a0,a0,0x3
 162:	9536                	add	a0,a0,a3
 164:	6518                	ld	a4,8(a0)
 166:	6718                	ld	a4,8(a4)
 168:	9f99                	subw	a5,a5,a4
 16a:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 16c:	60e2                	ld	ra,24(sp)
 16e:	6442                	ld	s0,16(sp)
 170:	64a2                	ld	s1,8(sp)
 172:	6105                	addi	sp,sp,32
 174:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 176:	00151793          	slli	a5,a0,0x1
 17a:	953e                	add	a0,a0,a5
 17c:	050e                	slli	a0,a0,0x3
 17e:	00001797          	auipc	a5,0x1
 182:	8fa78793          	addi	a5,a5,-1798 # a78 <rings>
 186:	953e                	add	a0,a0,a5
 188:	6508                	ld	a0,8(a0)
 18a:	0521                	addi	a0,a0,8
 18c:	00000097          	auipc	ra,0x0
 190:	ee8080e7          	jalr	-280(ra) # 74 <load>
 194:	c088                	sw	a0,0(s1)
}
 196:	bfd9                	j	16c <ringbuf_start_write+0x42>

0000000000000198 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 198:	1141                	addi	sp,sp,-16
 19a:	e406                	sd	ra,8(sp)
 19c:	e022                	sd	s0,0(sp)
 19e:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1a0:	00151793          	slli	a5,a0,0x1
 1a4:	97aa                	add	a5,a5,a0
 1a6:	078e                	slli	a5,a5,0x3
 1a8:	00001517          	auipc	a0,0x1
 1ac:	8d050513          	addi	a0,a0,-1840 # a78 <rings>
 1b0:	97aa                	add	a5,a5,a0
 1b2:	6788                	ld	a0,8(a5)
 1b4:	0035959b          	slliw	a1,a1,0x3
 1b8:	0521                	addi	a0,a0,8
 1ba:	00000097          	auipc	ra,0x0
 1be:	ea6080e7          	jalr	-346(ra) # 60 <store>
}
 1c2:	60a2                	ld	ra,8(sp)
 1c4:	6402                	ld	s0,0(sp)
 1c6:	0141                	addi	sp,sp,16
 1c8:	8082                	ret

00000000000001ca <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1ca:	1101                	addi	sp,sp,-32
 1cc:	ec06                	sd	ra,24(sp)
 1ce:	e822                	sd	s0,16(sp)
 1d0:	e426                	sd	s1,8(sp)
 1d2:	1000                	addi	s0,sp,32
 1d4:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1d6:	00151793          	slli	a5,a0,0x1
 1da:	97aa                	add	a5,a5,a0
 1dc:	078e                	slli	a5,a5,0x3
 1de:	00001517          	auipc	a0,0x1
 1e2:	89a50513          	addi	a0,a0,-1894 # a78 <rings>
 1e6:	97aa                	add	a5,a5,a0
 1e8:	6788                	ld	a0,8(a5)
 1ea:	0521                	addi	a0,a0,8
 1ec:	00000097          	auipc	ra,0x0
 1f0:	e88080e7          	jalr	-376(ra) # 74 <load>
 1f4:	c088                	sw	a0,0(s1)
}
 1f6:	60e2                	ld	ra,24(sp)
 1f8:	6442                	ld	s0,16(sp)
 1fa:	64a2                	ld	s1,8(sp)
 1fc:	6105                	addi	sp,sp,32
 1fe:	8082                	ret

0000000000000200 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 200:	1101                	addi	sp,sp,-32
 202:	ec06                	sd	ra,24(sp)
 204:	e822                	sd	s0,16(sp)
 206:	e426                	sd	s1,8(sp)
 208:	1000                	addi	s0,sp,32
 20a:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 20c:	00151793          	slli	a5,a0,0x1
 210:	97aa                	add	a5,a5,a0
 212:	078e                	slli	a5,a5,0x3
 214:	00001517          	auipc	a0,0x1
 218:	86450513          	addi	a0,a0,-1948 # a78 <rings>
 21c:	97aa                	add	a5,a5,a0
 21e:	6788                	ld	a0,8(a5)
 220:	611c                	ld	a5,0(a0)
 222:	ef99                	bnez	a5,240 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 224:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 226:	41f7579b          	sraiw	a5,a4,0x1f
 22a:	01d7d79b          	srliw	a5,a5,0x1d
 22e:	9fb9                	addw	a5,a5,a4
 230:	4037d79b          	sraiw	a5,a5,0x3
 234:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 236:	60e2                	ld	ra,24(sp)
 238:	6442                	ld	s0,16(sp)
 23a:	64a2                	ld	s1,8(sp)
 23c:	6105                	addi	sp,sp,32
 23e:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 240:	00000097          	auipc	ra,0x0
 244:	e34080e7          	jalr	-460(ra) # 74 <load>
    *bytes /= 8;
 248:	41f5579b          	sraiw	a5,a0,0x1f
 24c:	01d7d79b          	srliw	a5,a5,0x1d
 250:	9d3d                	addw	a0,a0,a5
 252:	4035551b          	sraiw	a0,a0,0x3
 256:	c088                	sw	a0,0(s1)
}
 258:	bff9                	j	236 <ringbuf_start_read+0x36>

000000000000025a <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 25a:	1141                	addi	sp,sp,-16
 25c:	e406                	sd	ra,8(sp)
 25e:	e022                	sd	s0,0(sp)
 260:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 262:	00151793          	slli	a5,a0,0x1
 266:	97aa                	add	a5,a5,a0
 268:	078e                	slli	a5,a5,0x3
 26a:	00001517          	auipc	a0,0x1
 26e:	80e50513          	addi	a0,a0,-2034 # a78 <rings>
 272:	97aa                	add	a5,a5,a0
 274:	0035959b          	slliw	a1,a1,0x3
 278:	6788                	ld	a0,8(a5)
 27a:	00000097          	auipc	ra,0x0
 27e:	de6080e7          	jalr	-538(ra) # 60 <store>
}
 282:	60a2                	ld	ra,8(sp)
 284:	6402                	ld	s0,0(sp)
 286:	0141                	addi	sp,sp,16
 288:	8082                	ret

000000000000028a <strcpy>:



char*
strcpy(char *s, const char *t)
{
 28a:	1141                	addi	sp,sp,-16
 28c:	e422                	sd	s0,8(sp)
 28e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 290:	87aa                	mv	a5,a0
 292:	0585                	addi	a1,a1,1
 294:	0785                	addi	a5,a5,1
 296:	fff5c703          	lbu	a4,-1(a1)
 29a:	fee78fa3          	sb	a4,-1(a5)
 29e:	fb75                	bnez	a4,292 <strcpy+0x8>
    ;
  return os;
}
 2a0:	6422                	ld	s0,8(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2ac:	00054783          	lbu	a5,0(a0)
 2b0:	cb91                	beqz	a5,2c4 <strcmp+0x1e>
 2b2:	0005c703          	lbu	a4,0(a1)
 2b6:	00f71763          	bne	a4,a5,2c4 <strcmp+0x1e>
    p++, q++;
 2ba:	0505                	addi	a0,a0,1
 2bc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2be:	00054783          	lbu	a5,0(a0)
 2c2:	fbe5                	bnez	a5,2b2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2c4:	0005c503          	lbu	a0,0(a1)
}
 2c8:	40a7853b          	subw	a0,a5,a0
 2cc:	6422                	ld	s0,8(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret

00000000000002d2 <strlen>:

uint
strlen(const char *s)
{
 2d2:	1141                	addi	sp,sp,-16
 2d4:	e422                	sd	s0,8(sp)
 2d6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2d8:	00054783          	lbu	a5,0(a0)
 2dc:	cf91                	beqz	a5,2f8 <strlen+0x26>
 2de:	0505                	addi	a0,a0,1
 2e0:	87aa                	mv	a5,a0
 2e2:	4685                	li	a3,1
 2e4:	9e89                	subw	a3,a3,a0
 2e6:	00f6853b          	addw	a0,a3,a5
 2ea:	0785                	addi	a5,a5,1
 2ec:	fff7c703          	lbu	a4,-1(a5)
 2f0:	fb7d                	bnez	a4,2e6 <strlen+0x14>
    ;
  return n;
}
 2f2:	6422                	ld	s0,8(sp)
 2f4:	0141                	addi	sp,sp,16
 2f6:	8082                	ret
  for(n = 0; s[n]; n++)
 2f8:	4501                	li	a0,0
 2fa:	bfe5                	j	2f2 <strlen+0x20>

00000000000002fc <memset>:

void*
memset(void *dst, int c, uint n)
{
 2fc:	1141                	addi	sp,sp,-16
 2fe:	e422                	sd	s0,8(sp)
 300:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 302:	ca19                	beqz	a2,318 <memset+0x1c>
 304:	87aa                	mv	a5,a0
 306:	1602                	slli	a2,a2,0x20
 308:	9201                	srli	a2,a2,0x20
 30a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 30e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 312:	0785                	addi	a5,a5,1
 314:	fee79de3          	bne	a5,a4,30e <memset+0x12>
  }
  return dst;
}
 318:	6422                	ld	s0,8(sp)
 31a:	0141                	addi	sp,sp,16
 31c:	8082                	ret

000000000000031e <strchr>:

char*
strchr(const char *s, char c)
{
 31e:	1141                	addi	sp,sp,-16
 320:	e422                	sd	s0,8(sp)
 322:	0800                	addi	s0,sp,16
  for(; *s; s++)
 324:	00054783          	lbu	a5,0(a0)
 328:	cb99                	beqz	a5,33e <strchr+0x20>
    if(*s == c)
 32a:	00f58763          	beq	a1,a5,338 <strchr+0x1a>
  for(; *s; s++)
 32e:	0505                	addi	a0,a0,1
 330:	00054783          	lbu	a5,0(a0)
 334:	fbfd                	bnez	a5,32a <strchr+0xc>
      return (char*)s;
  return 0;
 336:	4501                	li	a0,0
}
 338:	6422                	ld	s0,8(sp)
 33a:	0141                	addi	sp,sp,16
 33c:	8082                	ret
  return 0;
 33e:	4501                	li	a0,0
 340:	bfe5                	j	338 <strchr+0x1a>

0000000000000342 <gets>:

char*
gets(char *buf, int max)
{
 342:	711d                	addi	sp,sp,-96
 344:	ec86                	sd	ra,88(sp)
 346:	e8a2                	sd	s0,80(sp)
 348:	e4a6                	sd	s1,72(sp)
 34a:	e0ca                	sd	s2,64(sp)
 34c:	fc4e                	sd	s3,56(sp)
 34e:	f852                	sd	s4,48(sp)
 350:	f456                	sd	s5,40(sp)
 352:	f05a                	sd	s6,32(sp)
 354:	ec5e                	sd	s7,24(sp)
 356:	1080                	addi	s0,sp,96
 358:	8baa                	mv	s7,a0
 35a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 35c:	892a                	mv	s2,a0
 35e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 360:	4aa9                	li	s5,10
 362:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 364:	89a6                	mv	s3,s1
 366:	2485                	addiw	s1,s1,1
 368:	0344d863          	bge	s1,s4,398 <gets+0x56>
    cc = read(0, &c, 1);
 36c:	4605                	li	a2,1
 36e:	faf40593          	addi	a1,s0,-81
 372:	4501                	li	a0,0
 374:	00000097          	auipc	ra,0x0
 378:	19c080e7          	jalr	412(ra) # 510 <read>
    if(cc < 1)
 37c:	00a05e63          	blez	a0,398 <gets+0x56>
    buf[i++] = c;
 380:	faf44783          	lbu	a5,-81(s0)
 384:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 388:	01578763          	beq	a5,s5,396 <gets+0x54>
 38c:	0905                	addi	s2,s2,1
 38e:	fd679be3          	bne	a5,s6,364 <gets+0x22>
  for(i=0; i+1 < max; ){
 392:	89a6                	mv	s3,s1
 394:	a011                	j	398 <gets+0x56>
 396:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 398:	99de                	add	s3,s3,s7
 39a:	00098023          	sb	zero,0(s3)
  return buf;
}
 39e:	855e                	mv	a0,s7
 3a0:	60e6                	ld	ra,88(sp)
 3a2:	6446                	ld	s0,80(sp)
 3a4:	64a6                	ld	s1,72(sp)
 3a6:	6906                	ld	s2,64(sp)
 3a8:	79e2                	ld	s3,56(sp)
 3aa:	7a42                	ld	s4,48(sp)
 3ac:	7aa2                	ld	s5,40(sp)
 3ae:	7b02                	ld	s6,32(sp)
 3b0:	6be2                	ld	s7,24(sp)
 3b2:	6125                	addi	sp,sp,96
 3b4:	8082                	ret

00000000000003b6 <stat>:

int
stat(const char *n, struct stat *st)
{
 3b6:	1101                	addi	sp,sp,-32
 3b8:	ec06                	sd	ra,24(sp)
 3ba:	e822                	sd	s0,16(sp)
 3bc:	e426                	sd	s1,8(sp)
 3be:	e04a                	sd	s2,0(sp)
 3c0:	1000                	addi	s0,sp,32
 3c2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c4:	4581                	li	a1,0
 3c6:	00000097          	auipc	ra,0x0
 3ca:	172080e7          	jalr	370(ra) # 538 <open>
  if(fd < 0)
 3ce:	02054563          	bltz	a0,3f8 <stat+0x42>
 3d2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3d4:	85ca                	mv	a1,s2
 3d6:	00000097          	auipc	ra,0x0
 3da:	17a080e7          	jalr	378(ra) # 550 <fstat>
 3de:	892a                	mv	s2,a0
  close(fd);
 3e0:	8526                	mv	a0,s1
 3e2:	00000097          	auipc	ra,0x0
 3e6:	13e080e7          	jalr	318(ra) # 520 <close>
  return r;
}
 3ea:	854a                	mv	a0,s2
 3ec:	60e2                	ld	ra,24(sp)
 3ee:	6442                	ld	s0,16(sp)
 3f0:	64a2                	ld	s1,8(sp)
 3f2:	6902                	ld	s2,0(sp)
 3f4:	6105                	addi	sp,sp,32
 3f6:	8082                	ret
    return -1;
 3f8:	597d                	li	s2,-1
 3fa:	bfc5                	j	3ea <stat+0x34>

00000000000003fc <atoi>:

int
atoi(const char *s)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 402:	00054603          	lbu	a2,0(a0)
 406:	fd06079b          	addiw	a5,a2,-48
 40a:	0ff7f793          	zext.b	a5,a5
 40e:	4725                	li	a4,9
 410:	02f76963          	bltu	a4,a5,442 <atoi+0x46>
 414:	86aa                	mv	a3,a0
  n = 0;
 416:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 418:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 41a:	0685                	addi	a3,a3,1
 41c:	0025179b          	slliw	a5,a0,0x2
 420:	9fa9                	addw	a5,a5,a0
 422:	0017979b          	slliw	a5,a5,0x1
 426:	9fb1                	addw	a5,a5,a2
 428:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 42c:	0006c603          	lbu	a2,0(a3)
 430:	fd06071b          	addiw	a4,a2,-48
 434:	0ff77713          	zext.b	a4,a4
 438:	fee5f1e3          	bgeu	a1,a4,41a <atoi+0x1e>
  return n;
}
 43c:	6422                	ld	s0,8(sp)
 43e:	0141                	addi	sp,sp,16
 440:	8082                	ret
  n = 0;
 442:	4501                	li	a0,0
 444:	bfe5                	j	43c <atoi+0x40>

0000000000000446 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 446:	1141                	addi	sp,sp,-16
 448:	e422                	sd	s0,8(sp)
 44a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 44c:	02b57463          	bgeu	a0,a1,474 <memmove+0x2e>
    while(n-- > 0)
 450:	00c05f63          	blez	a2,46e <memmove+0x28>
 454:	1602                	slli	a2,a2,0x20
 456:	9201                	srli	a2,a2,0x20
 458:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 45c:	872a                	mv	a4,a0
      *dst++ = *src++;
 45e:	0585                	addi	a1,a1,1
 460:	0705                	addi	a4,a4,1
 462:	fff5c683          	lbu	a3,-1(a1)
 466:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 46a:	fee79ae3          	bne	a5,a4,45e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 46e:	6422                	ld	s0,8(sp)
 470:	0141                	addi	sp,sp,16
 472:	8082                	ret
    dst += n;
 474:	00c50733          	add	a4,a0,a2
    src += n;
 478:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 47a:	fec05ae3          	blez	a2,46e <memmove+0x28>
 47e:	fff6079b          	addiw	a5,a2,-1
 482:	1782                	slli	a5,a5,0x20
 484:	9381                	srli	a5,a5,0x20
 486:	fff7c793          	not	a5,a5
 48a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 48c:	15fd                	addi	a1,a1,-1
 48e:	177d                	addi	a4,a4,-1
 490:	0005c683          	lbu	a3,0(a1)
 494:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 498:	fee79ae3          	bne	a5,a4,48c <memmove+0x46>
 49c:	bfc9                	j	46e <memmove+0x28>

000000000000049e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 49e:	1141                	addi	sp,sp,-16
 4a0:	e422                	sd	s0,8(sp)
 4a2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4a4:	ca05                	beqz	a2,4d4 <memcmp+0x36>
 4a6:	fff6069b          	addiw	a3,a2,-1
 4aa:	1682                	slli	a3,a3,0x20
 4ac:	9281                	srli	a3,a3,0x20
 4ae:	0685                	addi	a3,a3,1
 4b0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4b2:	00054783          	lbu	a5,0(a0)
 4b6:	0005c703          	lbu	a4,0(a1)
 4ba:	00e79863          	bne	a5,a4,4ca <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4be:	0505                	addi	a0,a0,1
    p2++;
 4c0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4c2:	fed518e3          	bne	a0,a3,4b2 <memcmp+0x14>
  }
  return 0;
 4c6:	4501                	li	a0,0
 4c8:	a019                	j	4ce <memcmp+0x30>
      return *p1 - *p2;
 4ca:	40e7853b          	subw	a0,a5,a4
}
 4ce:	6422                	ld	s0,8(sp)
 4d0:	0141                	addi	sp,sp,16
 4d2:	8082                	ret
  return 0;
 4d4:	4501                	li	a0,0
 4d6:	bfe5                	j	4ce <memcmp+0x30>

00000000000004d8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4d8:	1141                	addi	sp,sp,-16
 4da:	e406                	sd	ra,8(sp)
 4dc:	e022                	sd	s0,0(sp)
 4de:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4e0:	00000097          	auipc	ra,0x0
 4e4:	f66080e7          	jalr	-154(ra) # 446 <memmove>
}
 4e8:	60a2                	ld	ra,8(sp)
 4ea:	6402                	ld	s0,0(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret

00000000000004f0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4f0:	4885                	li	a7,1
 ecall
 4f2:	00000073          	ecall
 ret
 4f6:	8082                	ret

00000000000004f8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 4f8:	4889                	li	a7,2
 ecall
 4fa:	00000073          	ecall
 ret
 4fe:	8082                	ret

0000000000000500 <wait>:
.global wait
wait:
 li a7, SYS_wait
 500:	488d                	li	a7,3
 ecall
 502:	00000073          	ecall
 ret
 506:	8082                	ret

0000000000000508 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 508:	4891                	li	a7,4
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <read>:
.global read
read:
 li a7, SYS_read
 510:	4895                	li	a7,5
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <write>:
.global write
write:
 li a7, SYS_write
 518:	48c1                	li	a7,16
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <close>:
.global close
close:
 li a7, SYS_close
 520:	48d5                	li	a7,21
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <kill>:
.global kill
kill:
 li a7, SYS_kill
 528:	4899                	li	a7,6
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <exec>:
.global exec
exec:
 li a7, SYS_exec
 530:	489d                	li	a7,7
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <open>:
.global open
open:
 li a7, SYS_open
 538:	48bd                	li	a7,15
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 540:	48c5                	li	a7,17
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 548:	48c9                	li	a7,18
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 550:	48a1                	li	a7,8
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <link>:
.global link
link:
 li a7, SYS_link
 558:	48cd                	li	a7,19
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 560:	48d1                	li	a7,20
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 568:	48a5                	li	a7,9
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <dup>:
.global dup
dup:
 li a7, SYS_dup
 570:	48a9                	li	a7,10
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 578:	48ad                	li	a7,11
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 580:	48b1                	li	a7,12
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 588:	48b5                	li	a7,13
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 590:	48b9                	li	a7,14
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 598:	48d9                	li	a7,22
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5a0:	1101                	addi	sp,sp,-32
 5a2:	ec06                	sd	ra,24(sp)
 5a4:	e822                	sd	s0,16(sp)
 5a6:	1000                	addi	s0,sp,32
 5a8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5ac:	4605                	li	a2,1
 5ae:	fef40593          	addi	a1,s0,-17
 5b2:	00000097          	auipc	ra,0x0
 5b6:	f66080e7          	jalr	-154(ra) # 518 <write>
}
 5ba:	60e2                	ld	ra,24(sp)
 5bc:	6442                	ld	s0,16(sp)
 5be:	6105                	addi	sp,sp,32
 5c0:	8082                	ret

00000000000005c2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5c2:	7139                	addi	sp,sp,-64
 5c4:	fc06                	sd	ra,56(sp)
 5c6:	f822                	sd	s0,48(sp)
 5c8:	f426                	sd	s1,40(sp)
 5ca:	f04a                	sd	s2,32(sp)
 5cc:	ec4e                	sd	s3,24(sp)
 5ce:	0080                	addi	s0,sp,64
 5d0:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5d2:	c299                	beqz	a3,5d8 <printint+0x16>
 5d4:	0805c863          	bltz	a1,664 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5d8:	2581                	sext.w	a1,a1
  neg = 0;
 5da:	4881                	li	a7,0
 5dc:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5e0:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5e2:	2601                	sext.w	a2,a2
 5e4:	00000517          	auipc	a0,0x0
 5e8:	47450513          	addi	a0,a0,1140 # a58 <digits>
 5ec:	883a                	mv	a6,a4
 5ee:	2705                	addiw	a4,a4,1
 5f0:	02c5f7bb          	remuw	a5,a1,a2
 5f4:	1782                	slli	a5,a5,0x20
 5f6:	9381                	srli	a5,a5,0x20
 5f8:	97aa                	add	a5,a5,a0
 5fa:	0007c783          	lbu	a5,0(a5)
 5fe:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 602:	0005879b          	sext.w	a5,a1
 606:	02c5d5bb          	divuw	a1,a1,a2
 60a:	0685                	addi	a3,a3,1
 60c:	fec7f0e3          	bgeu	a5,a2,5ec <printint+0x2a>
  if(neg)
 610:	00088b63          	beqz	a7,626 <printint+0x64>
    buf[i++] = '-';
 614:	fd040793          	addi	a5,s0,-48
 618:	973e                	add	a4,a4,a5
 61a:	02d00793          	li	a5,45
 61e:	fef70823          	sb	a5,-16(a4)
 622:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 626:	02e05863          	blez	a4,656 <printint+0x94>
 62a:	fc040793          	addi	a5,s0,-64
 62e:	00e78933          	add	s2,a5,a4
 632:	fff78993          	addi	s3,a5,-1
 636:	99ba                	add	s3,s3,a4
 638:	377d                	addiw	a4,a4,-1
 63a:	1702                	slli	a4,a4,0x20
 63c:	9301                	srli	a4,a4,0x20
 63e:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 642:	fff94583          	lbu	a1,-1(s2)
 646:	8526                	mv	a0,s1
 648:	00000097          	auipc	ra,0x0
 64c:	f58080e7          	jalr	-168(ra) # 5a0 <putc>
  while(--i >= 0)
 650:	197d                	addi	s2,s2,-1
 652:	ff3918e3          	bne	s2,s3,642 <printint+0x80>
}
 656:	70e2                	ld	ra,56(sp)
 658:	7442                	ld	s0,48(sp)
 65a:	74a2                	ld	s1,40(sp)
 65c:	7902                	ld	s2,32(sp)
 65e:	69e2                	ld	s3,24(sp)
 660:	6121                	addi	sp,sp,64
 662:	8082                	ret
    x = -xx;
 664:	40b005bb          	negw	a1,a1
    neg = 1;
 668:	4885                	li	a7,1
    x = -xx;
 66a:	bf8d                	j	5dc <printint+0x1a>

000000000000066c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 66c:	7119                	addi	sp,sp,-128
 66e:	fc86                	sd	ra,120(sp)
 670:	f8a2                	sd	s0,112(sp)
 672:	f4a6                	sd	s1,104(sp)
 674:	f0ca                	sd	s2,96(sp)
 676:	ecce                	sd	s3,88(sp)
 678:	e8d2                	sd	s4,80(sp)
 67a:	e4d6                	sd	s5,72(sp)
 67c:	e0da                	sd	s6,64(sp)
 67e:	fc5e                	sd	s7,56(sp)
 680:	f862                	sd	s8,48(sp)
 682:	f466                	sd	s9,40(sp)
 684:	f06a                	sd	s10,32(sp)
 686:	ec6e                	sd	s11,24(sp)
 688:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 68a:	0005c903          	lbu	s2,0(a1)
 68e:	18090f63          	beqz	s2,82c <vprintf+0x1c0>
 692:	8aaa                	mv	s5,a0
 694:	8b32                	mv	s6,a2
 696:	00158493          	addi	s1,a1,1
  state = 0;
 69a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 69c:	02500a13          	li	s4,37
      if(c == 'd'){
 6a0:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6a4:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6a8:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6ac:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6b0:	00000b97          	auipc	s7,0x0
 6b4:	3a8b8b93          	addi	s7,s7,936 # a58 <digits>
 6b8:	a839                	j	6d6 <vprintf+0x6a>
        putc(fd, c);
 6ba:	85ca                	mv	a1,s2
 6bc:	8556                	mv	a0,s5
 6be:	00000097          	auipc	ra,0x0
 6c2:	ee2080e7          	jalr	-286(ra) # 5a0 <putc>
 6c6:	a019                	j	6cc <vprintf+0x60>
    } else if(state == '%'){
 6c8:	01498f63          	beq	s3,s4,6e6 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6cc:	0485                	addi	s1,s1,1
 6ce:	fff4c903          	lbu	s2,-1(s1)
 6d2:	14090d63          	beqz	s2,82c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6d6:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6da:	fe0997e3          	bnez	s3,6c8 <vprintf+0x5c>
      if(c == '%'){
 6de:	fd479ee3          	bne	a5,s4,6ba <vprintf+0x4e>
        state = '%';
 6e2:	89be                	mv	s3,a5
 6e4:	b7e5                	j	6cc <vprintf+0x60>
      if(c == 'd'){
 6e6:	05878063          	beq	a5,s8,726 <vprintf+0xba>
      } else if(c == 'l') {
 6ea:	05978c63          	beq	a5,s9,742 <vprintf+0xd6>
      } else if(c == 'x') {
 6ee:	07a78863          	beq	a5,s10,75e <vprintf+0xf2>
      } else if(c == 'p') {
 6f2:	09b78463          	beq	a5,s11,77a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6f6:	07300713          	li	a4,115
 6fa:	0ce78663          	beq	a5,a4,7c6 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6fe:	06300713          	li	a4,99
 702:	0ee78e63          	beq	a5,a4,7fe <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 706:	11478863          	beq	a5,s4,816 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 70a:	85d2                	mv	a1,s4
 70c:	8556                	mv	a0,s5
 70e:	00000097          	auipc	ra,0x0
 712:	e92080e7          	jalr	-366(ra) # 5a0 <putc>
        putc(fd, c);
 716:	85ca                	mv	a1,s2
 718:	8556                	mv	a0,s5
 71a:	00000097          	auipc	ra,0x0
 71e:	e86080e7          	jalr	-378(ra) # 5a0 <putc>
      }
      state = 0;
 722:	4981                	li	s3,0
 724:	b765                	j	6cc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 726:	008b0913          	addi	s2,s6,8
 72a:	4685                	li	a3,1
 72c:	4629                	li	a2,10
 72e:	000b2583          	lw	a1,0(s6)
 732:	8556                	mv	a0,s5
 734:	00000097          	auipc	ra,0x0
 738:	e8e080e7          	jalr	-370(ra) # 5c2 <printint>
 73c:	8b4a                	mv	s6,s2
      state = 0;
 73e:	4981                	li	s3,0
 740:	b771                	j	6cc <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 742:	008b0913          	addi	s2,s6,8
 746:	4681                	li	a3,0
 748:	4629                	li	a2,10
 74a:	000b2583          	lw	a1,0(s6)
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	e72080e7          	jalr	-398(ra) # 5c2 <printint>
 758:	8b4a                	mv	s6,s2
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bf85                	j	6cc <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 75e:	008b0913          	addi	s2,s6,8
 762:	4681                	li	a3,0
 764:	4641                	li	a2,16
 766:	000b2583          	lw	a1,0(s6)
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e56080e7          	jalr	-426(ra) # 5c2 <printint>
 774:	8b4a                	mv	s6,s2
      state = 0;
 776:	4981                	li	s3,0
 778:	bf91                	j	6cc <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 77a:	008b0793          	addi	a5,s6,8
 77e:	f8f43423          	sd	a5,-120(s0)
 782:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 786:	03000593          	li	a1,48
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e14080e7          	jalr	-492(ra) # 5a0 <putc>
  putc(fd, 'x');
 794:	85ea                	mv	a1,s10
 796:	8556                	mv	a0,s5
 798:	00000097          	auipc	ra,0x0
 79c:	e08080e7          	jalr	-504(ra) # 5a0 <putc>
 7a0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a2:	03c9d793          	srli	a5,s3,0x3c
 7a6:	97de                	add	a5,a5,s7
 7a8:	0007c583          	lbu	a1,0(a5)
 7ac:	8556                	mv	a0,s5
 7ae:	00000097          	auipc	ra,0x0
 7b2:	df2080e7          	jalr	-526(ra) # 5a0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b6:	0992                	slli	s3,s3,0x4
 7b8:	397d                	addiw	s2,s2,-1
 7ba:	fe0914e3          	bnez	s2,7a2 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7be:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7c2:	4981                	li	s3,0
 7c4:	b721                	j	6cc <vprintf+0x60>
        s = va_arg(ap, char*);
 7c6:	008b0993          	addi	s3,s6,8
 7ca:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7ce:	02090163          	beqz	s2,7f0 <vprintf+0x184>
        while(*s != 0){
 7d2:	00094583          	lbu	a1,0(s2)
 7d6:	c9a1                	beqz	a1,826 <vprintf+0x1ba>
          putc(fd, *s);
 7d8:	8556                	mv	a0,s5
 7da:	00000097          	auipc	ra,0x0
 7de:	dc6080e7          	jalr	-570(ra) # 5a0 <putc>
          s++;
 7e2:	0905                	addi	s2,s2,1
        while(*s != 0){
 7e4:	00094583          	lbu	a1,0(s2)
 7e8:	f9e5                	bnez	a1,7d8 <vprintf+0x16c>
        s = va_arg(ap, char*);
 7ea:	8b4e                	mv	s6,s3
      state = 0;
 7ec:	4981                	li	s3,0
 7ee:	bdf9                	j	6cc <vprintf+0x60>
          s = "(null)";
 7f0:	00000917          	auipc	s2,0x0
 7f4:	26090913          	addi	s2,s2,608 # a50 <malloc+0x11a>
        while(*s != 0){
 7f8:	02800593          	li	a1,40
 7fc:	bff1                	j	7d8 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 7fe:	008b0913          	addi	s2,s6,8
 802:	000b4583          	lbu	a1,0(s6)
 806:	8556                	mv	a0,s5
 808:	00000097          	auipc	ra,0x0
 80c:	d98080e7          	jalr	-616(ra) # 5a0 <putc>
 810:	8b4a                	mv	s6,s2
      state = 0;
 812:	4981                	li	s3,0
 814:	bd65                	j	6cc <vprintf+0x60>
        putc(fd, c);
 816:	85d2                	mv	a1,s4
 818:	8556                	mv	a0,s5
 81a:	00000097          	auipc	ra,0x0
 81e:	d86080e7          	jalr	-634(ra) # 5a0 <putc>
      state = 0;
 822:	4981                	li	s3,0
 824:	b565                	j	6cc <vprintf+0x60>
        s = va_arg(ap, char*);
 826:	8b4e                	mv	s6,s3
      state = 0;
 828:	4981                	li	s3,0
 82a:	b54d                	j	6cc <vprintf+0x60>
    }
  }
}
 82c:	70e6                	ld	ra,120(sp)
 82e:	7446                	ld	s0,112(sp)
 830:	74a6                	ld	s1,104(sp)
 832:	7906                	ld	s2,96(sp)
 834:	69e6                	ld	s3,88(sp)
 836:	6a46                	ld	s4,80(sp)
 838:	6aa6                	ld	s5,72(sp)
 83a:	6b06                	ld	s6,64(sp)
 83c:	7be2                	ld	s7,56(sp)
 83e:	7c42                	ld	s8,48(sp)
 840:	7ca2                	ld	s9,40(sp)
 842:	7d02                	ld	s10,32(sp)
 844:	6de2                	ld	s11,24(sp)
 846:	6109                	addi	sp,sp,128
 848:	8082                	ret

000000000000084a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 84a:	715d                	addi	sp,sp,-80
 84c:	ec06                	sd	ra,24(sp)
 84e:	e822                	sd	s0,16(sp)
 850:	1000                	addi	s0,sp,32
 852:	e010                	sd	a2,0(s0)
 854:	e414                	sd	a3,8(s0)
 856:	e818                	sd	a4,16(s0)
 858:	ec1c                	sd	a5,24(s0)
 85a:	03043023          	sd	a6,32(s0)
 85e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 862:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 866:	8622                	mv	a2,s0
 868:	00000097          	auipc	ra,0x0
 86c:	e04080e7          	jalr	-508(ra) # 66c <vprintf>
}
 870:	60e2                	ld	ra,24(sp)
 872:	6442                	ld	s0,16(sp)
 874:	6161                	addi	sp,sp,80
 876:	8082                	ret

0000000000000878 <printf>:

void
printf(const char *fmt, ...)
{
 878:	711d                	addi	sp,sp,-96
 87a:	ec06                	sd	ra,24(sp)
 87c:	e822                	sd	s0,16(sp)
 87e:	1000                	addi	s0,sp,32
 880:	e40c                	sd	a1,8(s0)
 882:	e810                	sd	a2,16(s0)
 884:	ec14                	sd	a3,24(s0)
 886:	f018                	sd	a4,32(s0)
 888:	f41c                	sd	a5,40(s0)
 88a:	03043823          	sd	a6,48(s0)
 88e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 892:	00840613          	addi	a2,s0,8
 896:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 89a:	85aa                	mv	a1,a0
 89c:	4505                	li	a0,1
 89e:	00000097          	auipc	ra,0x0
 8a2:	dce080e7          	jalr	-562(ra) # 66c <vprintf>
}
 8a6:	60e2                	ld	ra,24(sp)
 8a8:	6442                	ld	s0,16(sp)
 8aa:	6125                	addi	sp,sp,96
 8ac:	8082                	ret

00000000000008ae <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ae:	1141                	addi	sp,sp,-16
 8b0:	e422                	sd	s0,8(sp)
 8b2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8b4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b8:	00000797          	auipc	a5,0x0
 8bc:	1b87b783          	ld	a5,440(a5) # a70 <freep>
 8c0:	a805                	j	8f0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8c2:	4618                	lw	a4,8(a2)
 8c4:	9db9                	addw	a1,a1,a4
 8c6:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ca:	6398                	ld	a4,0(a5)
 8cc:	6318                	ld	a4,0(a4)
 8ce:	fee53823          	sd	a4,-16(a0)
 8d2:	a091                	j	916 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8d4:	ff852703          	lw	a4,-8(a0)
 8d8:	9e39                	addw	a2,a2,a4
 8da:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8dc:	ff053703          	ld	a4,-16(a0)
 8e0:	e398                	sd	a4,0(a5)
 8e2:	a099                	j	928 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e4:	6398                	ld	a4,0(a5)
 8e6:	00e7e463          	bltu	a5,a4,8ee <free+0x40>
 8ea:	00e6ea63          	bltu	a3,a4,8fe <free+0x50>
{
 8ee:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f0:	fed7fae3          	bgeu	a5,a3,8e4 <free+0x36>
 8f4:	6398                	ld	a4,0(a5)
 8f6:	00e6e463          	bltu	a3,a4,8fe <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fa:	fee7eae3          	bltu	a5,a4,8ee <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 8fe:	ff852583          	lw	a1,-8(a0)
 902:	6390                	ld	a2,0(a5)
 904:	02059813          	slli	a6,a1,0x20
 908:	01c85713          	srli	a4,a6,0x1c
 90c:	9736                	add	a4,a4,a3
 90e:	fae60ae3          	beq	a2,a4,8c2 <free+0x14>
    bp->s.ptr = p->s.ptr;
 912:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 916:	4790                	lw	a2,8(a5)
 918:	02061593          	slli	a1,a2,0x20
 91c:	01c5d713          	srli	a4,a1,0x1c
 920:	973e                	add	a4,a4,a5
 922:	fae689e3          	beq	a3,a4,8d4 <free+0x26>
  } else
    p->s.ptr = bp;
 926:	e394                	sd	a3,0(a5)
  freep = p;
 928:	00000717          	auipc	a4,0x0
 92c:	14f73423          	sd	a5,328(a4) # a70 <freep>
}
 930:	6422                	ld	s0,8(sp)
 932:	0141                	addi	sp,sp,16
 934:	8082                	ret

0000000000000936 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 936:	7139                	addi	sp,sp,-64
 938:	fc06                	sd	ra,56(sp)
 93a:	f822                	sd	s0,48(sp)
 93c:	f426                	sd	s1,40(sp)
 93e:	f04a                	sd	s2,32(sp)
 940:	ec4e                	sd	s3,24(sp)
 942:	e852                	sd	s4,16(sp)
 944:	e456                	sd	s5,8(sp)
 946:	e05a                	sd	s6,0(sp)
 948:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 94a:	02051493          	slli	s1,a0,0x20
 94e:	9081                	srli	s1,s1,0x20
 950:	04bd                	addi	s1,s1,15
 952:	8091                	srli	s1,s1,0x4
 954:	0014899b          	addiw	s3,s1,1
 958:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 95a:	00000517          	auipc	a0,0x0
 95e:	11653503          	ld	a0,278(a0) # a70 <freep>
 962:	c515                	beqz	a0,98e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 964:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 966:	4798                	lw	a4,8(a5)
 968:	02977f63          	bgeu	a4,s1,9a6 <malloc+0x70>
 96c:	8a4e                	mv	s4,s3
 96e:	0009871b          	sext.w	a4,s3
 972:	6685                	lui	a3,0x1
 974:	00d77363          	bgeu	a4,a3,97a <malloc+0x44>
 978:	6a05                	lui	s4,0x1
 97a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 97e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 982:	00000917          	auipc	s2,0x0
 986:	0ee90913          	addi	s2,s2,238 # a70 <freep>
  if(p == (char*)-1)
 98a:	5afd                	li	s5,-1
 98c:	a895                	j	a00 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 98e:	00000797          	auipc	a5,0x0
 992:	1da78793          	addi	a5,a5,474 # b68 <base>
 996:	00000717          	auipc	a4,0x0
 99a:	0cf73d23          	sd	a5,218(a4) # a70 <freep>
 99e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9a0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9a4:	b7e1                	j	96c <malloc+0x36>
      if(p->s.size == nunits)
 9a6:	02e48c63          	beq	s1,a4,9de <malloc+0xa8>
        p->s.size -= nunits;
 9aa:	4137073b          	subw	a4,a4,s3
 9ae:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9b0:	02071693          	slli	a3,a4,0x20
 9b4:	01c6d713          	srli	a4,a3,0x1c
 9b8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ba:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9be:	00000717          	auipc	a4,0x0
 9c2:	0aa73923          	sd	a0,178(a4) # a70 <freep>
      return (void*)(p + 1);
 9c6:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ca:	70e2                	ld	ra,56(sp)
 9cc:	7442                	ld	s0,48(sp)
 9ce:	74a2                	ld	s1,40(sp)
 9d0:	7902                	ld	s2,32(sp)
 9d2:	69e2                	ld	s3,24(sp)
 9d4:	6a42                	ld	s4,16(sp)
 9d6:	6aa2                	ld	s5,8(sp)
 9d8:	6b02                	ld	s6,0(sp)
 9da:	6121                	addi	sp,sp,64
 9dc:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9de:	6398                	ld	a4,0(a5)
 9e0:	e118                	sd	a4,0(a0)
 9e2:	bff1                	j	9be <malloc+0x88>
  hp->s.size = nu;
 9e4:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9e8:	0541                	addi	a0,a0,16
 9ea:	00000097          	auipc	ra,0x0
 9ee:	ec4080e7          	jalr	-316(ra) # 8ae <free>
  return freep;
 9f2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9f6:	d971                	beqz	a0,9ca <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9fa:	4798                	lw	a4,8(a5)
 9fc:	fa9775e3          	bgeu	a4,s1,9a6 <malloc+0x70>
    if(p == freep)
 a00:	00093703          	ld	a4,0(s2)
 a04:	853e                	mv	a0,a5
 a06:	fef719e3          	bne	a4,a5,9f8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a0a:	8552                	mv	a0,s4
 a0c:	00000097          	auipc	ra,0x0
 a10:	b74080e7          	jalr	-1164(ra) # 580 <sbrk>
  if(p == (char*)-1)
 a14:	fd5518e3          	bne	a0,s5,9e4 <malloc+0xae>
        return 0;
 a18:	4501                	li	a0,0
 a1a:	bf45                	j	9ca <malloc+0x94>
