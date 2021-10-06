
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
  14:	a2858593          	addi	a1,a1,-1496 # a38 <malloc+0xea>
  18:	4509                	li	a0,2
  1a:	00001097          	auipc	ra,0x1
  1e:	848080e7          	jalr	-1976(ra) # 862 <fprintf>
    exit(1);
  22:	4505                	li	a0,1
  24:	00000097          	auipc	ra,0x0
  28:	4ec080e7          	jalr	1260(ra) # 510 <exit>
  2c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  2e:	698c                	ld	a1,16(a1)
  30:	6488                	ld	a0,8(s1)
  32:	00000097          	auipc	ra,0x0
  36:	53e080e7          	jalr	1342(ra) # 570 <link>
  3a:	00054763          	bltz	a0,48 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	4d0080e7          	jalr	1232(ra) # 510 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  48:	6894                	ld	a3,16(s1)
  4a:	6490                	ld	a2,8(s1)
  4c:	00001597          	auipc	a1,0x1
  50:	a0458593          	addi	a1,a1,-1532 # a50 <malloc+0x102>
  54:	4509                	li	a0,2
  56:	00001097          	auipc	ra,0x1
  5a:	80c080e7          	jalr	-2036(ra) # 862 <fprintf>
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
  a6:	9fe48493          	addi	s1,s1,-1538 # aa0 <rings+0x10>
  aa:	00001917          	auipc	s2,0x1
  ae:	ae690913          	addi	s2,s2,-1306 # b90 <__BSS_END__>
  b2:	04f59563          	bne	a1,a5,fc <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  b6:	00001497          	auipc	s1,0x1
  ba:	9ea4a483          	lw	s1,-1558(s1) # aa0 <rings+0x10>
  be:	c099                	beqz	s1,c4 <create_or_close_the_buffer_user+0x38>
  c0:	4481                	li	s1,0
  c2:	a899                	j	118 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  c4:	00001917          	auipc	s2,0x1
  c8:	9cc90913          	addi	s2,s2,-1588 # a90 <rings>
  cc:	00093603          	ld	a2,0(s2)
  d0:	4585                	li	a1,1
  d2:	00000097          	auipc	ra,0x0
  d6:	4de080e7          	jalr	1246(ra) # 5b0 <ringbuf>
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
 10c:	4a8080e7          	jalr	1192(ra) # 5b0 <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 12a:	1101                	addi	sp,sp,-32
 12c:	ec06                	sd	ra,24(sp)
 12e:	e822                	sd	s0,16(sp)
 130:	e426                	sd	s1,8(sp)
 132:	1000                	addi	s0,sp,32
 134:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 136:	00151793          	slli	a5,a0,0x1
 13a:	97aa                	add	a5,a5,a0
 13c:	078e                	slli	a5,a5,0x3
 13e:	00001717          	auipc	a4,0x1
 142:	95270713          	addi	a4,a4,-1710 # a90 <rings>
 146:	97ba                	add	a5,a5,a4
 148:	6798                	ld	a4,8(a5)
 14a:	671c                	ld	a5,8(a4)
 14c:	00178693          	addi	a3,a5,1
 150:	e714                	sd	a3,8(a4)
 152:	17d2                	slli	a5,a5,0x34
 154:	93d1                	srli	a5,a5,0x34
 156:	6741                	lui	a4,0x10
 158:	40f707b3          	sub	a5,a4,a5
 15c:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 15e:	421c                	lw	a5,0(a2)
 160:	e79d                	bnez	a5,18e <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 162:	00001697          	auipc	a3,0x1
 166:	92e68693          	addi	a3,a3,-1746 # a90 <rings>
 16a:	669c                	ld	a5,8(a3)
 16c:	6398                	ld	a4,0(a5)
 16e:	67c1                	lui	a5,0x10
 170:	9fb9                	addw	a5,a5,a4
 172:	00151713          	slli	a4,a0,0x1
 176:	953a                	add	a0,a0,a4
 178:	050e                	slli	a0,a0,0x3
 17a:	9536                	add	a0,a0,a3
 17c:	6518                	ld	a4,8(a0)
 17e:	6718                	ld	a4,8(a4)
 180:	9f99                	subw	a5,a5,a4
 182:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 184:	60e2                	ld	ra,24(sp)
 186:	6442                	ld	s0,16(sp)
 188:	64a2                	ld	s1,8(sp)
 18a:	6105                	addi	sp,sp,32
 18c:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 18e:	00151793          	slli	a5,a0,0x1
 192:	953e                	add	a0,a0,a5
 194:	050e                	slli	a0,a0,0x3
 196:	00001797          	auipc	a5,0x1
 19a:	8fa78793          	addi	a5,a5,-1798 # a90 <rings>
 19e:	953e                	add	a0,a0,a5
 1a0:	6508                	ld	a0,8(a0)
 1a2:	0521                	addi	a0,a0,8
 1a4:	00000097          	auipc	ra,0x0
 1a8:	ed0080e7          	jalr	-304(ra) # 74 <load>
 1ac:	c088                	sw	a0,0(s1)
}
 1ae:	bfd9                	j	184 <ringbuf_start_write+0x5a>

00000000000001b0 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1b0:	1141                	addi	sp,sp,-16
 1b2:	e406                	sd	ra,8(sp)
 1b4:	e022                	sd	s0,0(sp)
 1b6:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1b8:	00151793          	slli	a5,a0,0x1
 1bc:	97aa                	add	a5,a5,a0
 1be:	078e                	slli	a5,a5,0x3
 1c0:	00001517          	auipc	a0,0x1
 1c4:	8d050513          	addi	a0,a0,-1840 # a90 <rings>
 1c8:	97aa                	add	a5,a5,a0
 1ca:	6788                	ld	a0,8(a5)
 1cc:	0035959b          	slliw	a1,a1,0x3
 1d0:	0521                	addi	a0,a0,8
 1d2:	00000097          	auipc	ra,0x0
 1d6:	e8e080e7          	jalr	-370(ra) # 60 <store>
}
 1da:	60a2                	ld	ra,8(sp)
 1dc:	6402                	ld	s0,0(sp)
 1de:	0141                	addi	sp,sp,16
 1e0:	8082                	ret

00000000000001e2 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1e2:	1101                	addi	sp,sp,-32
 1e4:	ec06                	sd	ra,24(sp)
 1e6:	e822                	sd	s0,16(sp)
 1e8:	e426                	sd	s1,8(sp)
 1ea:	1000                	addi	s0,sp,32
 1ec:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1ee:	00151793          	slli	a5,a0,0x1
 1f2:	97aa                	add	a5,a5,a0
 1f4:	078e                	slli	a5,a5,0x3
 1f6:	00001517          	auipc	a0,0x1
 1fa:	89a50513          	addi	a0,a0,-1894 # a90 <rings>
 1fe:	97aa                	add	a5,a5,a0
 200:	6788                	ld	a0,8(a5)
 202:	0521                	addi	a0,a0,8
 204:	00000097          	auipc	ra,0x0
 208:	e70080e7          	jalr	-400(ra) # 74 <load>
 20c:	c088                	sw	a0,0(s1)
}
 20e:	60e2                	ld	ra,24(sp)
 210:	6442                	ld	s0,16(sp)
 212:	64a2                	ld	s1,8(sp)
 214:	6105                	addi	sp,sp,32
 216:	8082                	ret

0000000000000218 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 218:	1101                	addi	sp,sp,-32
 21a:	ec06                	sd	ra,24(sp)
 21c:	e822                	sd	s0,16(sp)
 21e:	e426                	sd	s1,8(sp)
 220:	1000                	addi	s0,sp,32
 222:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 224:	00151793          	slli	a5,a0,0x1
 228:	97aa                	add	a5,a5,a0
 22a:	078e                	slli	a5,a5,0x3
 22c:	00001517          	auipc	a0,0x1
 230:	86450513          	addi	a0,a0,-1948 # a90 <rings>
 234:	97aa                	add	a5,a5,a0
 236:	6788                	ld	a0,8(a5)
 238:	611c                	ld	a5,0(a0)
 23a:	ef99                	bnez	a5,258 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 23c:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 23e:	41f7579b          	sraiw	a5,a4,0x1f
 242:	01d7d79b          	srliw	a5,a5,0x1d
 246:	9fb9                	addw	a5,a5,a4
 248:	4037d79b          	sraiw	a5,a5,0x3
 24c:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 24e:	60e2                	ld	ra,24(sp)
 250:	6442                	ld	s0,16(sp)
 252:	64a2                	ld	s1,8(sp)
 254:	6105                	addi	sp,sp,32
 256:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 258:	00000097          	auipc	ra,0x0
 25c:	e1c080e7          	jalr	-484(ra) # 74 <load>
    *bytes /= 8;
 260:	41f5579b          	sraiw	a5,a0,0x1f
 264:	01d7d79b          	srliw	a5,a5,0x1d
 268:	9d3d                	addw	a0,a0,a5
 26a:	4035551b          	sraiw	a0,a0,0x3
 26e:	c088                	sw	a0,0(s1)
}
 270:	bff9                	j	24e <ringbuf_start_read+0x36>

0000000000000272 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 272:	1141                	addi	sp,sp,-16
 274:	e406                	sd	ra,8(sp)
 276:	e022                	sd	s0,0(sp)
 278:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 27a:	00151793          	slli	a5,a0,0x1
 27e:	97aa                	add	a5,a5,a0
 280:	078e                	slli	a5,a5,0x3
 282:	00001517          	auipc	a0,0x1
 286:	80e50513          	addi	a0,a0,-2034 # a90 <rings>
 28a:	97aa                	add	a5,a5,a0
 28c:	0035959b          	slliw	a1,a1,0x3
 290:	6788                	ld	a0,8(a5)
 292:	00000097          	auipc	ra,0x0
 296:	dce080e7          	jalr	-562(ra) # 60 <store>
}
 29a:	60a2                	ld	ra,8(sp)
 29c:	6402                	ld	s0,0(sp)
 29e:	0141                	addi	sp,sp,16
 2a0:	8082                	ret

00000000000002a2 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2a2:	1141                	addi	sp,sp,-16
 2a4:	e422                	sd	s0,8(sp)
 2a6:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2a8:	87aa                	mv	a5,a0
 2aa:	0585                	addi	a1,a1,1
 2ac:	0785                	addi	a5,a5,1
 2ae:	fff5c703          	lbu	a4,-1(a1)
 2b2:	fee78fa3          	sb	a4,-1(a5)
 2b6:	fb75                	bnez	a4,2aa <strcpy+0x8>
    ;
  return os;
}
 2b8:	6422                	ld	s0,8(sp)
 2ba:	0141                	addi	sp,sp,16
 2bc:	8082                	ret

00000000000002be <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2c4:	00054783          	lbu	a5,0(a0)
 2c8:	cb91                	beqz	a5,2dc <strcmp+0x1e>
 2ca:	0005c703          	lbu	a4,0(a1)
 2ce:	00f71763          	bne	a4,a5,2dc <strcmp+0x1e>
    p++, q++;
 2d2:	0505                	addi	a0,a0,1
 2d4:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2d6:	00054783          	lbu	a5,0(a0)
 2da:	fbe5                	bnez	a5,2ca <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2dc:	0005c503          	lbu	a0,0(a1)
}
 2e0:	40a7853b          	subw	a0,a5,a0
 2e4:	6422                	ld	s0,8(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <strlen>:

uint
strlen(const char *s)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2f0:	00054783          	lbu	a5,0(a0)
 2f4:	cf91                	beqz	a5,310 <strlen+0x26>
 2f6:	0505                	addi	a0,a0,1
 2f8:	87aa                	mv	a5,a0
 2fa:	4685                	li	a3,1
 2fc:	9e89                	subw	a3,a3,a0
 2fe:	00f6853b          	addw	a0,a3,a5
 302:	0785                	addi	a5,a5,1
 304:	fff7c703          	lbu	a4,-1(a5)
 308:	fb7d                	bnez	a4,2fe <strlen+0x14>
    ;
  return n;
}
 30a:	6422                	ld	s0,8(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret
  for(n = 0; s[n]; n++)
 310:	4501                	li	a0,0
 312:	bfe5                	j	30a <strlen+0x20>

0000000000000314 <memset>:

void*
memset(void *dst, int c, uint n)
{
 314:	1141                	addi	sp,sp,-16
 316:	e422                	sd	s0,8(sp)
 318:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 31a:	ca19                	beqz	a2,330 <memset+0x1c>
 31c:	87aa                	mv	a5,a0
 31e:	1602                	slli	a2,a2,0x20
 320:	9201                	srli	a2,a2,0x20
 322:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 326:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 32a:	0785                	addi	a5,a5,1
 32c:	fee79de3          	bne	a5,a4,326 <memset+0x12>
  }
  return dst;
}
 330:	6422                	ld	s0,8(sp)
 332:	0141                	addi	sp,sp,16
 334:	8082                	ret

0000000000000336 <strchr>:

char*
strchr(const char *s, char c)
{
 336:	1141                	addi	sp,sp,-16
 338:	e422                	sd	s0,8(sp)
 33a:	0800                	addi	s0,sp,16
  for(; *s; s++)
 33c:	00054783          	lbu	a5,0(a0)
 340:	cb99                	beqz	a5,356 <strchr+0x20>
    if(*s == c)
 342:	00f58763          	beq	a1,a5,350 <strchr+0x1a>
  for(; *s; s++)
 346:	0505                	addi	a0,a0,1
 348:	00054783          	lbu	a5,0(a0)
 34c:	fbfd                	bnez	a5,342 <strchr+0xc>
      return (char*)s;
  return 0;
 34e:	4501                	li	a0,0
}
 350:	6422                	ld	s0,8(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret
  return 0;
 356:	4501                	li	a0,0
 358:	bfe5                	j	350 <strchr+0x1a>

000000000000035a <gets>:

char*
gets(char *buf, int max)
{
 35a:	711d                	addi	sp,sp,-96
 35c:	ec86                	sd	ra,88(sp)
 35e:	e8a2                	sd	s0,80(sp)
 360:	e4a6                	sd	s1,72(sp)
 362:	e0ca                	sd	s2,64(sp)
 364:	fc4e                	sd	s3,56(sp)
 366:	f852                	sd	s4,48(sp)
 368:	f456                	sd	s5,40(sp)
 36a:	f05a                	sd	s6,32(sp)
 36c:	ec5e                	sd	s7,24(sp)
 36e:	1080                	addi	s0,sp,96
 370:	8baa                	mv	s7,a0
 372:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 374:	892a                	mv	s2,a0
 376:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 378:	4aa9                	li	s5,10
 37a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 37c:	89a6                	mv	s3,s1
 37e:	2485                	addiw	s1,s1,1
 380:	0344d863          	bge	s1,s4,3b0 <gets+0x56>
    cc = read(0, &c, 1);
 384:	4605                	li	a2,1
 386:	faf40593          	addi	a1,s0,-81
 38a:	4501                	li	a0,0
 38c:	00000097          	auipc	ra,0x0
 390:	19c080e7          	jalr	412(ra) # 528 <read>
    if(cc < 1)
 394:	00a05e63          	blez	a0,3b0 <gets+0x56>
    buf[i++] = c;
 398:	faf44783          	lbu	a5,-81(s0)
 39c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3a0:	01578763          	beq	a5,s5,3ae <gets+0x54>
 3a4:	0905                	addi	s2,s2,1
 3a6:	fd679be3          	bne	a5,s6,37c <gets+0x22>
  for(i=0; i+1 < max; ){
 3aa:	89a6                	mv	s3,s1
 3ac:	a011                	j	3b0 <gets+0x56>
 3ae:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3b0:	99de                	add	s3,s3,s7
 3b2:	00098023          	sb	zero,0(s3)
  return buf;
}
 3b6:	855e                	mv	a0,s7
 3b8:	60e6                	ld	ra,88(sp)
 3ba:	6446                	ld	s0,80(sp)
 3bc:	64a6                	ld	s1,72(sp)
 3be:	6906                	ld	s2,64(sp)
 3c0:	79e2                	ld	s3,56(sp)
 3c2:	7a42                	ld	s4,48(sp)
 3c4:	7aa2                	ld	s5,40(sp)
 3c6:	7b02                	ld	s6,32(sp)
 3c8:	6be2                	ld	s7,24(sp)
 3ca:	6125                	addi	sp,sp,96
 3cc:	8082                	ret

00000000000003ce <stat>:

int
stat(const char *n, struct stat *st)
{
 3ce:	1101                	addi	sp,sp,-32
 3d0:	ec06                	sd	ra,24(sp)
 3d2:	e822                	sd	s0,16(sp)
 3d4:	e426                	sd	s1,8(sp)
 3d6:	e04a                	sd	s2,0(sp)
 3d8:	1000                	addi	s0,sp,32
 3da:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3dc:	4581                	li	a1,0
 3de:	00000097          	auipc	ra,0x0
 3e2:	172080e7          	jalr	370(ra) # 550 <open>
  if(fd < 0)
 3e6:	02054563          	bltz	a0,410 <stat+0x42>
 3ea:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3ec:	85ca                	mv	a1,s2
 3ee:	00000097          	auipc	ra,0x0
 3f2:	17a080e7          	jalr	378(ra) # 568 <fstat>
 3f6:	892a                	mv	s2,a0
  close(fd);
 3f8:	8526                	mv	a0,s1
 3fa:	00000097          	auipc	ra,0x0
 3fe:	13e080e7          	jalr	318(ra) # 538 <close>
  return r;
}
 402:	854a                	mv	a0,s2
 404:	60e2                	ld	ra,24(sp)
 406:	6442                	ld	s0,16(sp)
 408:	64a2                	ld	s1,8(sp)
 40a:	6902                	ld	s2,0(sp)
 40c:	6105                	addi	sp,sp,32
 40e:	8082                	ret
    return -1;
 410:	597d                	li	s2,-1
 412:	bfc5                	j	402 <stat+0x34>

0000000000000414 <atoi>:

int
atoi(const char *s)
{
 414:	1141                	addi	sp,sp,-16
 416:	e422                	sd	s0,8(sp)
 418:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 41a:	00054603          	lbu	a2,0(a0)
 41e:	fd06079b          	addiw	a5,a2,-48
 422:	0ff7f793          	zext.b	a5,a5
 426:	4725                	li	a4,9
 428:	02f76963          	bltu	a4,a5,45a <atoi+0x46>
 42c:	86aa                	mv	a3,a0
  n = 0;
 42e:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 430:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 432:	0685                	addi	a3,a3,1
 434:	0025179b          	slliw	a5,a0,0x2
 438:	9fa9                	addw	a5,a5,a0
 43a:	0017979b          	slliw	a5,a5,0x1
 43e:	9fb1                	addw	a5,a5,a2
 440:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 444:	0006c603          	lbu	a2,0(a3)
 448:	fd06071b          	addiw	a4,a2,-48
 44c:	0ff77713          	zext.b	a4,a4
 450:	fee5f1e3          	bgeu	a1,a4,432 <atoi+0x1e>
  return n;
}
 454:	6422                	ld	s0,8(sp)
 456:	0141                	addi	sp,sp,16
 458:	8082                	ret
  n = 0;
 45a:	4501                	li	a0,0
 45c:	bfe5                	j	454 <atoi+0x40>

000000000000045e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 45e:	1141                	addi	sp,sp,-16
 460:	e422                	sd	s0,8(sp)
 462:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 464:	02b57463          	bgeu	a0,a1,48c <memmove+0x2e>
    while(n-- > 0)
 468:	00c05f63          	blez	a2,486 <memmove+0x28>
 46c:	1602                	slli	a2,a2,0x20
 46e:	9201                	srli	a2,a2,0x20
 470:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 474:	872a                	mv	a4,a0
      *dst++ = *src++;
 476:	0585                	addi	a1,a1,1
 478:	0705                	addi	a4,a4,1
 47a:	fff5c683          	lbu	a3,-1(a1)
 47e:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xed7e>
    while(n-- > 0)
 482:	fee79ae3          	bne	a5,a4,476 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret
    dst += n;
 48c:	00c50733          	add	a4,a0,a2
    src += n;
 490:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 492:	fec05ae3          	blez	a2,486 <memmove+0x28>
 496:	fff6079b          	addiw	a5,a2,-1
 49a:	1782                	slli	a5,a5,0x20
 49c:	9381                	srli	a5,a5,0x20
 49e:	fff7c793          	not	a5,a5
 4a2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4a4:	15fd                	addi	a1,a1,-1
 4a6:	177d                	addi	a4,a4,-1
 4a8:	0005c683          	lbu	a3,0(a1)
 4ac:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4b0:	fee79ae3          	bne	a5,a4,4a4 <memmove+0x46>
 4b4:	bfc9                	j	486 <memmove+0x28>

00000000000004b6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4b6:	1141                	addi	sp,sp,-16
 4b8:	e422                	sd	s0,8(sp)
 4ba:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4bc:	ca05                	beqz	a2,4ec <memcmp+0x36>
 4be:	fff6069b          	addiw	a3,a2,-1
 4c2:	1682                	slli	a3,a3,0x20
 4c4:	9281                	srli	a3,a3,0x20
 4c6:	0685                	addi	a3,a3,1
 4c8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ca:	00054783          	lbu	a5,0(a0)
 4ce:	0005c703          	lbu	a4,0(a1)
 4d2:	00e79863          	bne	a5,a4,4e2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4d6:	0505                	addi	a0,a0,1
    p2++;
 4d8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4da:	fed518e3          	bne	a0,a3,4ca <memcmp+0x14>
  }
  return 0;
 4de:	4501                	li	a0,0
 4e0:	a019                	j	4e6 <memcmp+0x30>
      return *p1 - *p2;
 4e2:	40e7853b          	subw	a0,a5,a4
}
 4e6:	6422                	ld	s0,8(sp)
 4e8:	0141                	addi	sp,sp,16
 4ea:	8082                	ret
  return 0;
 4ec:	4501                	li	a0,0
 4ee:	bfe5                	j	4e6 <memcmp+0x30>

00000000000004f0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4f0:	1141                	addi	sp,sp,-16
 4f2:	e406                	sd	ra,8(sp)
 4f4:	e022                	sd	s0,0(sp)
 4f6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4f8:	00000097          	auipc	ra,0x0
 4fc:	f66080e7          	jalr	-154(ra) # 45e <memmove>
}
 500:	60a2                	ld	ra,8(sp)
 502:	6402                	ld	s0,0(sp)
 504:	0141                	addi	sp,sp,16
 506:	8082                	ret

0000000000000508 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 508:	4885                	li	a7,1
 ecall
 50a:	00000073          	ecall
 ret
 50e:	8082                	ret

0000000000000510 <exit>:
.global exit
exit:
 li a7, SYS_exit
 510:	4889                	li	a7,2
 ecall
 512:	00000073          	ecall
 ret
 516:	8082                	ret

0000000000000518 <wait>:
.global wait
wait:
 li a7, SYS_wait
 518:	488d                	li	a7,3
 ecall
 51a:	00000073          	ecall
 ret
 51e:	8082                	ret

0000000000000520 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 520:	4891                	li	a7,4
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <read>:
.global read
read:
 li a7, SYS_read
 528:	4895                	li	a7,5
 ecall
 52a:	00000073          	ecall
 ret
 52e:	8082                	ret

0000000000000530 <write>:
.global write
write:
 li a7, SYS_write
 530:	48c1                	li	a7,16
 ecall
 532:	00000073          	ecall
 ret
 536:	8082                	ret

0000000000000538 <close>:
.global close
close:
 li a7, SYS_close
 538:	48d5                	li	a7,21
 ecall
 53a:	00000073          	ecall
 ret
 53e:	8082                	ret

0000000000000540 <kill>:
.global kill
kill:
 li a7, SYS_kill
 540:	4899                	li	a7,6
 ecall
 542:	00000073          	ecall
 ret
 546:	8082                	ret

0000000000000548 <exec>:
.global exec
exec:
 li a7, SYS_exec
 548:	489d                	li	a7,7
 ecall
 54a:	00000073          	ecall
 ret
 54e:	8082                	ret

0000000000000550 <open>:
.global open
open:
 li a7, SYS_open
 550:	48bd                	li	a7,15
 ecall
 552:	00000073          	ecall
 ret
 556:	8082                	ret

0000000000000558 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 558:	48c5                	li	a7,17
 ecall
 55a:	00000073          	ecall
 ret
 55e:	8082                	ret

0000000000000560 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 560:	48c9                	li	a7,18
 ecall
 562:	00000073          	ecall
 ret
 566:	8082                	ret

0000000000000568 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 568:	48a1                	li	a7,8
 ecall
 56a:	00000073          	ecall
 ret
 56e:	8082                	ret

0000000000000570 <link>:
.global link
link:
 li a7, SYS_link
 570:	48cd                	li	a7,19
 ecall
 572:	00000073          	ecall
 ret
 576:	8082                	ret

0000000000000578 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 578:	48d1                	li	a7,20
 ecall
 57a:	00000073          	ecall
 ret
 57e:	8082                	ret

0000000000000580 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 580:	48a5                	li	a7,9
 ecall
 582:	00000073          	ecall
 ret
 586:	8082                	ret

0000000000000588 <dup>:
.global dup
dup:
 li a7, SYS_dup
 588:	48a9                	li	a7,10
 ecall
 58a:	00000073          	ecall
 ret
 58e:	8082                	ret

0000000000000590 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 590:	48ad                	li	a7,11
 ecall
 592:	00000073          	ecall
 ret
 596:	8082                	ret

0000000000000598 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 598:	48b1                	li	a7,12
 ecall
 59a:	00000073          	ecall
 ret
 59e:	8082                	ret

00000000000005a0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5a0:	48b5                	li	a7,13
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5a8:	48b9                	li	a7,14
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5b0:	48d9                	li	a7,22
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5b8:	1101                	addi	sp,sp,-32
 5ba:	ec06                	sd	ra,24(sp)
 5bc:	e822                	sd	s0,16(sp)
 5be:	1000                	addi	s0,sp,32
 5c0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5c4:	4605                	li	a2,1
 5c6:	fef40593          	addi	a1,s0,-17
 5ca:	00000097          	auipc	ra,0x0
 5ce:	f66080e7          	jalr	-154(ra) # 530 <write>
}
 5d2:	60e2                	ld	ra,24(sp)
 5d4:	6442                	ld	s0,16(sp)
 5d6:	6105                	addi	sp,sp,32
 5d8:	8082                	ret

00000000000005da <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5da:	7139                	addi	sp,sp,-64
 5dc:	fc06                	sd	ra,56(sp)
 5de:	f822                	sd	s0,48(sp)
 5e0:	f426                	sd	s1,40(sp)
 5e2:	f04a                	sd	s2,32(sp)
 5e4:	ec4e                	sd	s3,24(sp)
 5e6:	0080                	addi	s0,sp,64
 5e8:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ea:	c299                	beqz	a3,5f0 <printint+0x16>
 5ec:	0805c863          	bltz	a1,67c <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5f0:	2581                	sext.w	a1,a1
  neg = 0;
 5f2:	4881                	li	a7,0
 5f4:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5f8:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5fa:	2601                	sext.w	a2,a2
 5fc:	00000517          	auipc	a0,0x0
 600:	47450513          	addi	a0,a0,1140 # a70 <digits>
 604:	883a                	mv	a6,a4
 606:	2705                	addiw	a4,a4,1
 608:	02c5f7bb          	remuw	a5,a1,a2
 60c:	1782                	slli	a5,a5,0x20
 60e:	9381                	srli	a5,a5,0x20
 610:	97aa                	add	a5,a5,a0
 612:	0007c783          	lbu	a5,0(a5)
 616:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 61a:	0005879b          	sext.w	a5,a1
 61e:	02c5d5bb          	divuw	a1,a1,a2
 622:	0685                	addi	a3,a3,1
 624:	fec7f0e3          	bgeu	a5,a2,604 <printint+0x2a>
  if(neg)
 628:	00088b63          	beqz	a7,63e <printint+0x64>
    buf[i++] = '-';
 62c:	fd040793          	addi	a5,s0,-48
 630:	973e                	add	a4,a4,a5
 632:	02d00793          	li	a5,45
 636:	fef70823          	sb	a5,-16(a4)
 63a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 63e:	02e05863          	blez	a4,66e <printint+0x94>
 642:	fc040793          	addi	a5,s0,-64
 646:	00e78933          	add	s2,a5,a4
 64a:	fff78993          	addi	s3,a5,-1
 64e:	99ba                	add	s3,s3,a4
 650:	377d                	addiw	a4,a4,-1
 652:	1702                	slli	a4,a4,0x20
 654:	9301                	srli	a4,a4,0x20
 656:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 65a:	fff94583          	lbu	a1,-1(s2)
 65e:	8526                	mv	a0,s1
 660:	00000097          	auipc	ra,0x0
 664:	f58080e7          	jalr	-168(ra) # 5b8 <putc>
  while(--i >= 0)
 668:	197d                	addi	s2,s2,-1
 66a:	ff3918e3          	bne	s2,s3,65a <printint+0x80>
}
 66e:	70e2                	ld	ra,56(sp)
 670:	7442                	ld	s0,48(sp)
 672:	74a2                	ld	s1,40(sp)
 674:	7902                	ld	s2,32(sp)
 676:	69e2                	ld	s3,24(sp)
 678:	6121                	addi	sp,sp,64
 67a:	8082                	ret
    x = -xx;
 67c:	40b005bb          	negw	a1,a1
    neg = 1;
 680:	4885                	li	a7,1
    x = -xx;
 682:	bf8d                	j	5f4 <printint+0x1a>

0000000000000684 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 684:	7119                	addi	sp,sp,-128
 686:	fc86                	sd	ra,120(sp)
 688:	f8a2                	sd	s0,112(sp)
 68a:	f4a6                	sd	s1,104(sp)
 68c:	f0ca                	sd	s2,96(sp)
 68e:	ecce                	sd	s3,88(sp)
 690:	e8d2                	sd	s4,80(sp)
 692:	e4d6                	sd	s5,72(sp)
 694:	e0da                	sd	s6,64(sp)
 696:	fc5e                	sd	s7,56(sp)
 698:	f862                	sd	s8,48(sp)
 69a:	f466                	sd	s9,40(sp)
 69c:	f06a                	sd	s10,32(sp)
 69e:	ec6e                	sd	s11,24(sp)
 6a0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6a2:	0005c903          	lbu	s2,0(a1)
 6a6:	18090f63          	beqz	s2,844 <vprintf+0x1c0>
 6aa:	8aaa                	mv	s5,a0
 6ac:	8b32                	mv	s6,a2
 6ae:	00158493          	addi	s1,a1,1
  state = 0;
 6b2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6b4:	02500a13          	li	s4,37
      if(c == 'd'){
 6b8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6bc:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6c0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6c4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6c8:	00000b97          	auipc	s7,0x0
 6cc:	3a8b8b93          	addi	s7,s7,936 # a70 <digits>
 6d0:	a839                	j	6ee <vprintf+0x6a>
        putc(fd, c);
 6d2:	85ca                	mv	a1,s2
 6d4:	8556                	mv	a0,s5
 6d6:	00000097          	auipc	ra,0x0
 6da:	ee2080e7          	jalr	-286(ra) # 5b8 <putc>
 6de:	a019                	j	6e4 <vprintf+0x60>
    } else if(state == '%'){
 6e0:	01498f63          	beq	s3,s4,6fe <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6e4:	0485                	addi	s1,s1,1
 6e6:	fff4c903          	lbu	s2,-1(s1)
 6ea:	14090d63          	beqz	s2,844 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6ee:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6f2:	fe0997e3          	bnez	s3,6e0 <vprintf+0x5c>
      if(c == '%'){
 6f6:	fd479ee3          	bne	a5,s4,6d2 <vprintf+0x4e>
        state = '%';
 6fa:	89be                	mv	s3,a5
 6fc:	b7e5                	j	6e4 <vprintf+0x60>
      if(c == 'd'){
 6fe:	05878063          	beq	a5,s8,73e <vprintf+0xba>
      } else if(c == 'l') {
 702:	05978c63          	beq	a5,s9,75a <vprintf+0xd6>
      } else if(c == 'x') {
 706:	07a78863          	beq	a5,s10,776 <vprintf+0xf2>
      } else if(c == 'p') {
 70a:	09b78463          	beq	a5,s11,792 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 70e:	07300713          	li	a4,115
 712:	0ce78663          	beq	a5,a4,7de <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 716:	06300713          	li	a4,99
 71a:	0ee78e63          	beq	a5,a4,816 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 71e:	11478863          	beq	a5,s4,82e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 722:	85d2                	mv	a1,s4
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	e92080e7          	jalr	-366(ra) # 5b8 <putc>
        putc(fd, c);
 72e:	85ca                	mv	a1,s2
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	e86080e7          	jalr	-378(ra) # 5b8 <putc>
      }
      state = 0;
 73a:	4981                	li	s3,0
 73c:	b765                	j	6e4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 73e:	008b0913          	addi	s2,s6,8
 742:	4685                	li	a3,1
 744:	4629                	li	a2,10
 746:	000b2583          	lw	a1,0(s6)
 74a:	8556                	mv	a0,s5
 74c:	00000097          	auipc	ra,0x0
 750:	e8e080e7          	jalr	-370(ra) # 5da <printint>
 754:	8b4a                	mv	s6,s2
      state = 0;
 756:	4981                	li	s3,0
 758:	b771                	j	6e4 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 75a:	008b0913          	addi	s2,s6,8
 75e:	4681                	li	a3,0
 760:	4629                	li	a2,10
 762:	000b2583          	lw	a1,0(s6)
 766:	8556                	mv	a0,s5
 768:	00000097          	auipc	ra,0x0
 76c:	e72080e7          	jalr	-398(ra) # 5da <printint>
 770:	8b4a                	mv	s6,s2
      state = 0;
 772:	4981                	li	s3,0
 774:	bf85                	j	6e4 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 776:	008b0913          	addi	s2,s6,8
 77a:	4681                	li	a3,0
 77c:	4641                	li	a2,16
 77e:	000b2583          	lw	a1,0(s6)
 782:	8556                	mv	a0,s5
 784:	00000097          	auipc	ra,0x0
 788:	e56080e7          	jalr	-426(ra) # 5da <printint>
 78c:	8b4a                	mv	s6,s2
      state = 0;
 78e:	4981                	li	s3,0
 790:	bf91                	j	6e4 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 792:	008b0793          	addi	a5,s6,8
 796:	f8f43423          	sd	a5,-120(s0)
 79a:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 79e:	03000593          	li	a1,48
 7a2:	8556                	mv	a0,s5
 7a4:	00000097          	auipc	ra,0x0
 7a8:	e14080e7          	jalr	-492(ra) # 5b8 <putc>
  putc(fd, 'x');
 7ac:	85ea                	mv	a1,s10
 7ae:	8556                	mv	a0,s5
 7b0:	00000097          	auipc	ra,0x0
 7b4:	e08080e7          	jalr	-504(ra) # 5b8 <putc>
 7b8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7ba:	03c9d793          	srli	a5,s3,0x3c
 7be:	97de                	add	a5,a5,s7
 7c0:	0007c583          	lbu	a1,0(a5)
 7c4:	8556                	mv	a0,s5
 7c6:	00000097          	auipc	ra,0x0
 7ca:	df2080e7          	jalr	-526(ra) # 5b8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ce:	0992                	slli	s3,s3,0x4
 7d0:	397d                	addiw	s2,s2,-1
 7d2:	fe0914e3          	bnez	s2,7ba <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7d6:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7da:	4981                	li	s3,0
 7dc:	b721                	j	6e4 <vprintf+0x60>
        s = va_arg(ap, char*);
 7de:	008b0993          	addi	s3,s6,8
 7e2:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7e6:	02090163          	beqz	s2,808 <vprintf+0x184>
        while(*s != 0){
 7ea:	00094583          	lbu	a1,0(s2)
 7ee:	c9a1                	beqz	a1,83e <vprintf+0x1ba>
          putc(fd, *s);
 7f0:	8556                	mv	a0,s5
 7f2:	00000097          	auipc	ra,0x0
 7f6:	dc6080e7          	jalr	-570(ra) # 5b8 <putc>
          s++;
 7fa:	0905                	addi	s2,s2,1
        while(*s != 0){
 7fc:	00094583          	lbu	a1,0(s2)
 800:	f9e5                	bnez	a1,7f0 <vprintf+0x16c>
        s = va_arg(ap, char*);
 802:	8b4e                	mv	s6,s3
      state = 0;
 804:	4981                	li	s3,0
 806:	bdf9                	j	6e4 <vprintf+0x60>
          s = "(null)";
 808:	00000917          	auipc	s2,0x0
 80c:	26090913          	addi	s2,s2,608 # a68 <malloc+0x11a>
        while(*s != 0){
 810:	02800593          	li	a1,40
 814:	bff1                	j	7f0 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 816:	008b0913          	addi	s2,s6,8
 81a:	000b4583          	lbu	a1,0(s6)
 81e:	8556                	mv	a0,s5
 820:	00000097          	auipc	ra,0x0
 824:	d98080e7          	jalr	-616(ra) # 5b8 <putc>
 828:	8b4a                	mv	s6,s2
      state = 0;
 82a:	4981                	li	s3,0
 82c:	bd65                	j	6e4 <vprintf+0x60>
        putc(fd, c);
 82e:	85d2                	mv	a1,s4
 830:	8556                	mv	a0,s5
 832:	00000097          	auipc	ra,0x0
 836:	d86080e7          	jalr	-634(ra) # 5b8 <putc>
      state = 0;
 83a:	4981                	li	s3,0
 83c:	b565                	j	6e4 <vprintf+0x60>
        s = va_arg(ap, char*);
 83e:	8b4e                	mv	s6,s3
      state = 0;
 840:	4981                	li	s3,0
 842:	b54d                	j	6e4 <vprintf+0x60>
    }
  }
}
 844:	70e6                	ld	ra,120(sp)
 846:	7446                	ld	s0,112(sp)
 848:	74a6                	ld	s1,104(sp)
 84a:	7906                	ld	s2,96(sp)
 84c:	69e6                	ld	s3,88(sp)
 84e:	6a46                	ld	s4,80(sp)
 850:	6aa6                	ld	s5,72(sp)
 852:	6b06                	ld	s6,64(sp)
 854:	7be2                	ld	s7,56(sp)
 856:	7c42                	ld	s8,48(sp)
 858:	7ca2                	ld	s9,40(sp)
 85a:	7d02                	ld	s10,32(sp)
 85c:	6de2                	ld	s11,24(sp)
 85e:	6109                	addi	sp,sp,128
 860:	8082                	ret

0000000000000862 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 862:	715d                	addi	sp,sp,-80
 864:	ec06                	sd	ra,24(sp)
 866:	e822                	sd	s0,16(sp)
 868:	1000                	addi	s0,sp,32
 86a:	e010                	sd	a2,0(s0)
 86c:	e414                	sd	a3,8(s0)
 86e:	e818                	sd	a4,16(s0)
 870:	ec1c                	sd	a5,24(s0)
 872:	03043023          	sd	a6,32(s0)
 876:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 87a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 87e:	8622                	mv	a2,s0
 880:	00000097          	auipc	ra,0x0
 884:	e04080e7          	jalr	-508(ra) # 684 <vprintf>
}
 888:	60e2                	ld	ra,24(sp)
 88a:	6442                	ld	s0,16(sp)
 88c:	6161                	addi	sp,sp,80
 88e:	8082                	ret

0000000000000890 <printf>:

void
printf(const char *fmt, ...)
{
 890:	711d                	addi	sp,sp,-96
 892:	ec06                	sd	ra,24(sp)
 894:	e822                	sd	s0,16(sp)
 896:	1000                	addi	s0,sp,32
 898:	e40c                	sd	a1,8(s0)
 89a:	e810                	sd	a2,16(s0)
 89c:	ec14                	sd	a3,24(s0)
 89e:	f018                	sd	a4,32(s0)
 8a0:	f41c                	sd	a5,40(s0)
 8a2:	03043823          	sd	a6,48(s0)
 8a6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8aa:	00840613          	addi	a2,s0,8
 8ae:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8b2:	85aa                	mv	a1,a0
 8b4:	4505                	li	a0,1
 8b6:	00000097          	auipc	ra,0x0
 8ba:	dce080e7          	jalr	-562(ra) # 684 <vprintf>
}
 8be:	60e2                	ld	ra,24(sp)
 8c0:	6442                	ld	s0,16(sp)
 8c2:	6125                	addi	sp,sp,96
 8c4:	8082                	ret

00000000000008c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c6:	1141                	addi	sp,sp,-16
 8c8:	e422                	sd	s0,8(sp)
 8ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8cc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d0:	00000797          	auipc	a5,0x0
 8d4:	1b87b783          	ld	a5,440(a5) # a88 <freep>
 8d8:	a805                	j	908 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8da:	4618                	lw	a4,8(a2)
 8dc:	9db9                	addw	a1,a1,a4
 8de:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	6318                	ld	a4,0(a4)
 8e6:	fee53823          	sd	a4,-16(a0)
 8ea:	a091                	j	92e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8ec:	ff852703          	lw	a4,-8(a0)
 8f0:	9e39                	addw	a2,a2,a4
 8f2:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8f4:	ff053703          	ld	a4,-16(a0)
 8f8:	e398                	sd	a4,0(a5)
 8fa:	a099                	j	940 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fc:	6398                	ld	a4,0(a5)
 8fe:	00e7e463          	bltu	a5,a4,906 <free+0x40>
 902:	00e6ea63          	bltu	a3,a4,916 <free+0x50>
{
 906:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 908:	fed7fae3          	bgeu	a5,a3,8fc <free+0x36>
 90c:	6398                	ld	a4,0(a5)
 90e:	00e6e463          	bltu	a3,a4,916 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 912:	fee7eae3          	bltu	a5,a4,906 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 916:	ff852583          	lw	a1,-8(a0)
 91a:	6390                	ld	a2,0(a5)
 91c:	02059813          	slli	a6,a1,0x20
 920:	01c85713          	srli	a4,a6,0x1c
 924:	9736                	add	a4,a4,a3
 926:	fae60ae3          	beq	a2,a4,8da <free+0x14>
    bp->s.ptr = p->s.ptr;
 92a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 92e:	4790                	lw	a2,8(a5)
 930:	02061593          	slli	a1,a2,0x20
 934:	01c5d713          	srli	a4,a1,0x1c
 938:	973e                	add	a4,a4,a5
 93a:	fae689e3          	beq	a3,a4,8ec <free+0x26>
  } else
    p->s.ptr = bp;
 93e:	e394                	sd	a3,0(a5)
  freep = p;
 940:	00000717          	auipc	a4,0x0
 944:	14f73423          	sd	a5,328(a4) # a88 <freep>
}
 948:	6422                	ld	s0,8(sp)
 94a:	0141                	addi	sp,sp,16
 94c:	8082                	ret

000000000000094e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 94e:	7139                	addi	sp,sp,-64
 950:	fc06                	sd	ra,56(sp)
 952:	f822                	sd	s0,48(sp)
 954:	f426                	sd	s1,40(sp)
 956:	f04a                	sd	s2,32(sp)
 958:	ec4e                	sd	s3,24(sp)
 95a:	e852                	sd	s4,16(sp)
 95c:	e456                	sd	s5,8(sp)
 95e:	e05a                	sd	s6,0(sp)
 960:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 962:	02051493          	slli	s1,a0,0x20
 966:	9081                	srli	s1,s1,0x20
 968:	04bd                	addi	s1,s1,15
 96a:	8091                	srli	s1,s1,0x4
 96c:	0014899b          	addiw	s3,s1,1
 970:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 972:	00000517          	auipc	a0,0x0
 976:	11653503          	ld	a0,278(a0) # a88 <freep>
 97a:	c515                	beqz	a0,9a6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 97c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 97e:	4798                	lw	a4,8(a5)
 980:	02977f63          	bgeu	a4,s1,9be <malloc+0x70>
 984:	8a4e                	mv	s4,s3
 986:	0009871b          	sext.w	a4,s3
 98a:	6685                	lui	a3,0x1
 98c:	00d77363          	bgeu	a4,a3,992 <malloc+0x44>
 990:	6a05                	lui	s4,0x1
 992:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 996:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 99a:	00000917          	auipc	s2,0x0
 99e:	0ee90913          	addi	s2,s2,238 # a88 <freep>
  if(p == (char*)-1)
 9a2:	5afd                	li	s5,-1
 9a4:	a895                	j	a18 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9a6:	00000797          	auipc	a5,0x0
 9aa:	1da78793          	addi	a5,a5,474 # b80 <base>
 9ae:	00000717          	auipc	a4,0x0
 9b2:	0cf73d23          	sd	a5,218(a4) # a88 <freep>
 9b6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9b8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9bc:	b7e1                	j	984 <malloc+0x36>
      if(p->s.size == nunits)
 9be:	02e48c63          	beq	s1,a4,9f6 <malloc+0xa8>
        p->s.size -= nunits;
 9c2:	4137073b          	subw	a4,a4,s3
 9c6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9c8:	02071693          	slli	a3,a4,0x20
 9cc:	01c6d713          	srli	a4,a3,0x1c
 9d0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9d2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9d6:	00000717          	auipc	a4,0x0
 9da:	0aa73923          	sd	a0,178(a4) # a88 <freep>
      return (void*)(p + 1);
 9de:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9e2:	70e2                	ld	ra,56(sp)
 9e4:	7442                	ld	s0,48(sp)
 9e6:	74a2                	ld	s1,40(sp)
 9e8:	7902                	ld	s2,32(sp)
 9ea:	69e2                	ld	s3,24(sp)
 9ec:	6a42                	ld	s4,16(sp)
 9ee:	6aa2                	ld	s5,8(sp)
 9f0:	6b02                	ld	s6,0(sp)
 9f2:	6121                	addi	sp,sp,64
 9f4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9f6:	6398                	ld	a4,0(a5)
 9f8:	e118                	sd	a4,0(a0)
 9fa:	bff1                	j	9d6 <malloc+0x88>
  hp->s.size = nu;
 9fc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a00:	0541                	addi	a0,a0,16
 a02:	00000097          	auipc	ra,0x0
 a06:	ec4080e7          	jalr	-316(ra) # 8c6 <free>
  return freep;
 a0a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a0e:	d971                	beqz	a0,9e2 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a10:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a12:	4798                	lw	a4,8(a5)
 a14:	fa9775e3          	bgeu	a4,s1,9be <malloc+0x70>
    if(p == freep)
 a18:	00093703          	ld	a4,0(s2)
 a1c:	853e                	mv	a0,a5
 a1e:	fef719e3          	bne	a4,a5,a10 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a22:	8552                	mv	a0,s4
 a24:	00000097          	auipc	ra,0x0
 a28:	b74080e7          	jalr	-1164(ra) # 598 <sbrk>
  if(p == (char*)-1)
 a2c:	fd5518e3          	bne	a0,s5,9fc <malloc+0xae>
        return 0;
 a30:	4501                	li	a0,0
 a32:	bf45                	j	9e2 <malloc+0x94>
