
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   c:	4785                	li	a5,1
   e:	02a7dd63          	bge	a5,a0,48 <main+0x48>
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	00000097          	auipc	ra,0x0
  2c:	3d8080e7          	jalr	984(ra) # 400 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	4fc080e7          	jalr	1276(ra) # 52c <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	4bc080e7          	jalr	1212(ra) # 4fc <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	9d858593          	addi	a1,a1,-1576 # a20 <malloc+0xe6>
  50:	4509                	li	a0,2
  52:	00000097          	auipc	ra,0x0
  56:	7fc080e7          	jalr	2044(ra) # 84e <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	4a0080e7          	jalr	1184(ra) # 4fc <exit>

0000000000000064 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  6a:	0f50000f          	fence	iorw,ow
  6e:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
  72:	6422                	ld	s0,8(sp)
  74:	0141                	addi	sp,sp,16
  76:	8082                	ret

0000000000000078 <load>:

int load(uint64 *p) {
  78:	1141                	addi	sp,sp,-16
  7a:	e422                	sd	s0,8(sp)
  7c:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
  7e:	0ff0000f          	fence
  82:	6108                	ld	a0,0(a0)
  84:	0ff0000f          	fence
}
  88:	2501                	sext.w	a0,a0
  8a:	6422                	ld	s0,8(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret

0000000000000090 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
  90:	7179                	addi	sp,sp,-48
  92:	f406                	sd	ra,40(sp)
  94:	f022                	sd	s0,32(sp)
  96:	ec26                	sd	s1,24(sp)
  98:	e84a                	sd	s2,16(sp)
  9a:	e44e                	sd	s3,8(sp)
  9c:	e052                	sd	s4,0(sp)
  9e:	1800                	addi	s0,sp,48
  a0:	8a2a                	mv	s4,a0
  a2:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
  a4:	4785                	li	a5,1
  a6:	00001497          	auipc	s1,0x1
  aa:	9ca48493          	addi	s1,s1,-1590 # a70 <rings+0x10>
  ae:	00001917          	auipc	s2,0x1
  b2:	ab290913          	addi	s2,s2,-1358 # b60 <__BSS_END__>
  b6:	04f59563          	bne	a1,a5,100 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  ba:	00001497          	auipc	s1,0x1
  be:	9b64a483          	lw	s1,-1610(s1) # a70 <rings+0x10>
  c2:	c099                	beqz	s1,c8 <create_or_close_the_buffer_user+0x38>
  c4:	4481                	li	s1,0
  c6:	a899                	j	11c <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  c8:	00001917          	auipc	s2,0x1
  cc:	99890913          	addi	s2,s2,-1640 # a60 <rings>
  d0:	00093603          	ld	a2,0(s2)
  d4:	4585                	li	a1,1
  d6:	00000097          	auipc	ra,0x0
  da:	4c6080e7          	jalr	1222(ra) # 59c <ringbuf>
        rings[i].book->write_done = 0;
  de:	00893783          	ld	a5,8(s2)
  e2:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
  e6:	00893783          	ld	a5,8(s2)
  ea:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
  ee:	01092783          	lw	a5,16(s2)
  f2:	2785                	addiw	a5,a5,1
  f4:	00f92823          	sw	a5,16(s2)
        break;
  f8:	a015                	j	11c <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
  fa:	04e1                	addi	s1,s1,24
  fc:	01248f63          	beq	s1,s2,11a <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 100:	409c                	lw	a5,0(s1)
 102:	dfe5                	beqz	a5,fa <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 104:	ff04b603          	ld	a2,-16(s1)
 108:	85ce                	mv	a1,s3
 10a:	8552                	mv	a0,s4
 10c:	00000097          	auipc	ra,0x0
 110:	490080e7          	jalr	1168(ra) # 59c <ringbuf>
        rings[i].exists = 0;
 114:	0004a023          	sw	zero,0(s1)
 118:	b7cd                	j	fa <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 11a:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 11c:	8526                	mv	a0,s1
 11e:	70a2                	ld	ra,40(sp)
 120:	7402                	ld	s0,32(sp)
 122:	64e2                	ld	s1,24(sp)
 124:	6942                	ld	s2,16(sp)
 126:	69a2                	ld	s3,8(sp)
 128:	6a02                	ld	s4,0(sp)
 12a:	6145                	addi	sp,sp,48
 12c:	8082                	ret

000000000000012e <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 12e:	1101                	addi	sp,sp,-32
 130:	ec06                	sd	ra,24(sp)
 132:	e822                	sd	s0,16(sp)
 134:	e426                	sd	s1,8(sp)
 136:	1000                	addi	s0,sp,32
 138:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 13a:	00151793          	slli	a5,a0,0x1
 13e:	97aa                	add	a5,a5,a0
 140:	078e                	slli	a5,a5,0x3
 142:	00001717          	auipc	a4,0x1
 146:	91e70713          	addi	a4,a4,-1762 # a60 <rings>
 14a:	97ba                	add	a5,a5,a4
 14c:	639c                	ld	a5,0(a5)
 14e:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 150:	421c                	lw	a5,0(a2)
 152:	e785                	bnez	a5,17a <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 154:	86ba                	mv	a3,a4
 156:	671c                	ld	a5,8(a4)
 158:	6398                	ld	a4,0(a5)
 15a:	67c1                	lui	a5,0x10
 15c:	9fb9                	addw	a5,a5,a4
 15e:	00151713          	slli	a4,a0,0x1
 162:	953a                	add	a0,a0,a4
 164:	050e                	slli	a0,a0,0x3
 166:	9536                	add	a0,a0,a3
 168:	6518                	ld	a4,8(a0)
 16a:	6718                	ld	a4,8(a4)
 16c:	9f99                	subw	a5,a5,a4
 16e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 170:	60e2                	ld	ra,24(sp)
 172:	6442                	ld	s0,16(sp)
 174:	64a2                	ld	s1,8(sp)
 176:	6105                	addi	sp,sp,32
 178:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 17a:	00151793          	slli	a5,a0,0x1
 17e:	953e                	add	a0,a0,a5
 180:	050e                	slli	a0,a0,0x3
 182:	00001797          	auipc	a5,0x1
 186:	8de78793          	addi	a5,a5,-1826 # a60 <rings>
 18a:	953e                	add	a0,a0,a5
 18c:	6508                	ld	a0,8(a0)
 18e:	0521                	addi	a0,a0,8
 190:	00000097          	auipc	ra,0x0
 194:	ee8080e7          	jalr	-280(ra) # 78 <load>
 198:	c088                	sw	a0,0(s1)
}
 19a:	bfd9                	j	170 <ringbuf_start_write+0x42>

000000000000019c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 19c:	1141                	addi	sp,sp,-16
 19e:	e406                	sd	ra,8(sp)
 1a0:	e022                	sd	s0,0(sp)
 1a2:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1a4:	00151793          	slli	a5,a0,0x1
 1a8:	97aa                	add	a5,a5,a0
 1aa:	078e                	slli	a5,a5,0x3
 1ac:	00001517          	auipc	a0,0x1
 1b0:	8b450513          	addi	a0,a0,-1868 # a60 <rings>
 1b4:	97aa                	add	a5,a5,a0
 1b6:	6788                	ld	a0,8(a5)
 1b8:	0035959b          	slliw	a1,a1,0x3
 1bc:	0521                	addi	a0,a0,8
 1be:	00000097          	auipc	ra,0x0
 1c2:	ea6080e7          	jalr	-346(ra) # 64 <store>
}
 1c6:	60a2                	ld	ra,8(sp)
 1c8:	6402                	ld	s0,0(sp)
 1ca:	0141                	addi	sp,sp,16
 1cc:	8082                	ret

00000000000001ce <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1ce:	1101                	addi	sp,sp,-32
 1d0:	ec06                	sd	ra,24(sp)
 1d2:	e822                	sd	s0,16(sp)
 1d4:	e426                	sd	s1,8(sp)
 1d6:	1000                	addi	s0,sp,32
 1d8:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1da:	00151793          	slli	a5,a0,0x1
 1de:	97aa                	add	a5,a5,a0
 1e0:	078e                	slli	a5,a5,0x3
 1e2:	00001517          	auipc	a0,0x1
 1e6:	87e50513          	addi	a0,a0,-1922 # a60 <rings>
 1ea:	97aa                	add	a5,a5,a0
 1ec:	6788                	ld	a0,8(a5)
 1ee:	0521                	addi	a0,a0,8
 1f0:	00000097          	auipc	ra,0x0
 1f4:	e88080e7          	jalr	-376(ra) # 78 <load>
 1f8:	c088                	sw	a0,0(s1)
}
 1fa:	60e2                	ld	ra,24(sp)
 1fc:	6442                	ld	s0,16(sp)
 1fe:	64a2                	ld	s1,8(sp)
 200:	6105                	addi	sp,sp,32
 202:	8082                	ret

0000000000000204 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 204:	1101                	addi	sp,sp,-32
 206:	ec06                	sd	ra,24(sp)
 208:	e822                	sd	s0,16(sp)
 20a:	e426                	sd	s1,8(sp)
 20c:	1000                	addi	s0,sp,32
 20e:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 210:	00151793          	slli	a5,a0,0x1
 214:	97aa                	add	a5,a5,a0
 216:	078e                	slli	a5,a5,0x3
 218:	00001517          	auipc	a0,0x1
 21c:	84850513          	addi	a0,a0,-1976 # a60 <rings>
 220:	97aa                	add	a5,a5,a0
 222:	6788                	ld	a0,8(a5)
 224:	611c                	ld	a5,0(a0)
 226:	ef99                	bnez	a5,244 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 228:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 22a:	41f7579b          	sraiw	a5,a4,0x1f
 22e:	01d7d79b          	srliw	a5,a5,0x1d
 232:	9fb9                	addw	a5,a5,a4
 234:	4037d79b          	sraiw	a5,a5,0x3
 238:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 23a:	60e2                	ld	ra,24(sp)
 23c:	6442                	ld	s0,16(sp)
 23e:	64a2                	ld	s1,8(sp)
 240:	6105                	addi	sp,sp,32
 242:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 244:	00000097          	auipc	ra,0x0
 248:	e34080e7          	jalr	-460(ra) # 78 <load>
    *bytes /= 8;
 24c:	41f5579b          	sraiw	a5,a0,0x1f
 250:	01d7d79b          	srliw	a5,a5,0x1d
 254:	9d3d                	addw	a0,a0,a5
 256:	4035551b          	sraiw	a0,a0,0x3
 25a:	c088                	sw	a0,0(s1)
}
 25c:	bff9                	j	23a <ringbuf_start_read+0x36>

000000000000025e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 25e:	1141                	addi	sp,sp,-16
 260:	e406                	sd	ra,8(sp)
 262:	e022                	sd	s0,0(sp)
 264:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 266:	00151793          	slli	a5,a0,0x1
 26a:	97aa                	add	a5,a5,a0
 26c:	078e                	slli	a5,a5,0x3
 26e:	00000517          	auipc	a0,0x0
 272:	7f250513          	addi	a0,a0,2034 # a60 <rings>
 276:	97aa                	add	a5,a5,a0
 278:	0035959b          	slliw	a1,a1,0x3
 27c:	6788                	ld	a0,8(a5)
 27e:	00000097          	auipc	ra,0x0
 282:	de6080e7          	jalr	-538(ra) # 64 <store>
}
 286:	60a2                	ld	ra,8(sp)
 288:	6402                	ld	s0,0(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret

000000000000028e <strcpy>:



char*
strcpy(char *s, const char *t)
{
 28e:	1141                	addi	sp,sp,-16
 290:	e422                	sd	s0,8(sp)
 292:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 294:	87aa                	mv	a5,a0
 296:	0585                	addi	a1,a1,1
 298:	0785                	addi	a5,a5,1
 29a:	fff5c703          	lbu	a4,-1(a1)
 29e:	fee78fa3          	sb	a4,-1(a5)
 2a2:	fb75                	bnez	a4,296 <strcpy+0x8>
    ;
  return os;
}
 2a4:	6422                	ld	s0,8(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret

00000000000002aa <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2aa:	1141                	addi	sp,sp,-16
 2ac:	e422                	sd	s0,8(sp)
 2ae:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	cb91                	beqz	a5,2c8 <strcmp+0x1e>
 2b6:	0005c703          	lbu	a4,0(a1)
 2ba:	00f71763          	bne	a4,a5,2c8 <strcmp+0x1e>
    p++, q++;
 2be:	0505                	addi	a0,a0,1
 2c0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	fbe5                	bnez	a5,2b6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2c8:	0005c503          	lbu	a0,0(a1)
}
 2cc:	40a7853b          	subw	a0,a5,a0
 2d0:	6422                	ld	s0,8(sp)
 2d2:	0141                	addi	sp,sp,16
 2d4:	8082                	ret

00000000000002d6 <strlen>:

uint
strlen(const char *s)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2dc:	00054783          	lbu	a5,0(a0)
 2e0:	cf91                	beqz	a5,2fc <strlen+0x26>
 2e2:	0505                	addi	a0,a0,1
 2e4:	87aa                	mv	a5,a0
 2e6:	4685                	li	a3,1
 2e8:	9e89                	subw	a3,a3,a0
 2ea:	00f6853b          	addw	a0,a3,a5
 2ee:	0785                	addi	a5,a5,1
 2f0:	fff7c703          	lbu	a4,-1(a5)
 2f4:	fb7d                	bnez	a4,2ea <strlen+0x14>
    ;
  return n;
}
 2f6:	6422                	ld	s0,8(sp)
 2f8:	0141                	addi	sp,sp,16
 2fa:	8082                	ret
  for(n = 0; s[n]; n++)
 2fc:	4501                	li	a0,0
 2fe:	bfe5                	j	2f6 <strlen+0x20>

0000000000000300 <memset>:

void*
memset(void *dst, int c, uint n)
{
 300:	1141                	addi	sp,sp,-16
 302:	e422                	sd	s0,8(sp)
 304:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 306:	ca19                	beqz	a2,31c <memset+0x1c>
 308:	87aa                	mv	a5,a0
 30a:	1602                	slli	a2,a2,0x20
 30c:	9201                	srli	a2,a2,0x20
 30e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 312:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 316:	0785                	addi	a5,a5,1
 318:	fee79de3          	bne	a5,a4,312 <memset+0x12>
  }
  return dst;
}
 31c:	6422                	ld	s0,8(sp)
 31e:	0141                	addi	sp,sp,16
 320:	8082                	ret

0000000000000322 <strchr>:

char*
strchr(const char *s, char c)
{
 322:	1141                	addi	sp,sp,-16
 324:	e422                	sd	s0,8(sp)
 326:	0800                	addi	s0,sp,16
  for(; *s; s++)
 328:	00054783          	lbu	a5,0(a0)
 32c:	cb99                	beqz	a5,342 <strchr+0x20>
    if(*s == c)
 32e:	00f58763          	beq	a1,a5,33c <strchr+0x1a>
  for(; *s; s++)
 332:	0505                	addi	a0,a0,1
 334:	00054783          	lbu	a5,0(a0)
 338:	fbfd                	bnez	a5,32e <strchr+0xc>
      return (char*)s;
  return 0;
 33a:	4501                	li	a0,0
}
 33c:	6422                	ld	s0,8(sp)
 33e:	0141                	addi	sp,sp,16
 340:	8082                	ret
  return 0;
 342:	4501                	li	a0,0
 344:	bfe5                	j	33c <strchr+0x1a>

0000000000000346 <gets>:

char*
gets(char *buf, int max)
{
 346:	711d                	addi	sp,sp,-96
 348:	ec86                	sd	ra,88(sp)
 34a:	e8a2                	sd	s0,80(sp)
 34c:	e4a6                	sd	s1,72(sp)
 34e:	e0ca                	sd	s2,64(sp)
 350:	fc4e                	sd	s3,56(sp)
 352:	f852                	sd	s4,48(sp)
 354:	f456                	sd	s5,40(sp)
 356:	f05a                	sd	s6,32(sp)
 358:	ec5e                	sd	s7,24(sp)
 35a:	1080                	addi	s0,sp,96
 35c:	8baa                	mv	s7,a0
 35e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 360:	892a                	mv	s2,a0
 362:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 364:	4aa9                	li	s5,10
 366:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 368:	89a6                	mv	s3,s1
 36a:	2485                	addiw	s1,s1,1
 36c:	0344d863          	bge	s1,s4,39c <gets+0x56>
    cc = read(0, &c, 1);
 370:	4605                	li	a2,1
 372:	faf40593          	addi	a1,s0,-81
 376:	4501                	li	a0,0
 378:	00000097          	auipc	ra,0x0
 37c:	19c080e7          	jalr	412(ra) # 514 <read>
    if(cc < 1)
 380:	00a05e63          	blez	a0,39c <gets+0x56>
    buf[i++] = c;
 384:	faf44783          	lbu	a5,-81(s0)
 388:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 38c:	01578763          	beq	a5,s5,39a <gets+0x54>
 390:	0905                	addi	s2,s2,1
 392:	fd679be3          	bne	a5,s6,368 <gets+0x22>
  for(i=0; i+1 < max; ){
 396:	89a6                	mv	s3,s1
 398:	a011                	j	39c <gets+0x56>
 39a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 39c:	99de                	add	s3,s3,s7
 39e:	00098023          	sb	zero,0(s3)
  return buf;
}
 3a2:	855e                	mv	a0,s7
 3a4:	60e6                	ld	ra,88(sp)
 3a6:	6446                	ld	s0,80(sp)
 3a8:	64a6                	ld	s1,72(sp)
 3aa:	6906                	ld	s2,64(sp)
 3ac:	79e2                	ld	s3,56(sp)
 3ae:	7a42                	ld	s4,48(sp)
 3b0:	7aa2                	ld	s5,40(sp)
 3b2:	7b02                	ld	s6,32(sp)
 3b4:	6be2                	ld	s7,24(sp)
 3b6:	6125                	addi	sp,sp,96
 3b8:	8082                	ret

00000000000003ba <stat>:

int
stat(const char *n, struct stat *st)
{
 3ba:	1101                	addi	sp,sp,-32
 3bc:	ec06                	sd	ra,24(sp)
 3be:	e822                	sd	s0,16(sp)
 3c0:	e426                	sd	s1,8(sp)
 3c2:	e04a                	sd	s2,0(sp)
 3c4:	1000                	addi	s0,sp,32
 3c6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c8:	4581                	li	a1,0
 3ca:	00000097          	auipc	ra,0x0
 3ce:	172080e7          	jalr	370(ra) # 53c <open>
  if(fd < 0)
 3d2:	02054563          	bltz	a0,3fc <stat+0x42>
 3d6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3d8:	85ca                	mv	a1,s2
 3da:	00000097          	auipc	ra,0x0
 3de:	17a080e7          	jalr	378(ra) # 554 <fstat>
 3e2:	892a                	mv	s2,a0
  close(fd);
 3e4:	8526                	mv	a0,s1
 3e6:	00000097          	auipc	ra,0x0
 3ea:	13e080e7          	jalr	318(ra) # 524 <close>
  return r;
}
 3ee:	854a                	mv	a0,s2
 3f0:	60e2                	ld	ra,24(sp)
 3f2:	6442                	ld	s0,16(sp)
 3f4:	64a2                	ld	s1,8(sp)
 3f6:	6902                	ld	s2,0(sp)
 3f8:	6105                	addi	sp,sp,32
 3fa:	8082                	ret
    return -1;
 3fc:	597d                	li	s2,-1
 3fe:	bfc5                	j	3ee <stat+0x34>

0000000000000400 <atoi>:

int
atoi(const char *s)
{
 400:	1141                	addi	sp,sp,-16
 402:	e422                	sd	s0,8(sp)
 404:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 406:	00054603          	lbu	a2,0(a0)
 40a:	fd06079b          	addiw	a5,a2,-48
 40e:	0ff7f793          	zext.b	a5,a5
 412:	4725                	li	a4,9
 414:	02f76963          	bltu	a4,a5,446 <atoi+0x46>
 418:	86aa                	mv	a3,a0
  n = 0;
 41a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 41c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 41e:	0685                	addi	a3,a3,1
 420:	0025179b          	slliw	a5,a0,0x2
 424:	9fa9                	addw	a5,a5,a0
 426:	0017979b          	slliw	a5,a5,0x1
 42a:	9fb1                	addw	a5,a5,a2
 42c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 430:	0006c603          	lbu	a2,0(a3)
 434:	fd06071b          	addiw	a4,a2,-48
 438:	0ff77713          	zext.b	a4,a4
 43c:	fee5f1e3          	bgeu	a1,a4,41e <atoi+0x1e>
  return n;
}
 440:	6422                	ld	s0,8(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret
  n = 0;
 446:	4501                	li	a0,0
 448:	bfe5                	j	440 <atoi+0x40>

000000000000044a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 44a:	1141                	addi	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 450:	02b57463          	bgeu	a0,a1,478 <memmove+0x2e>
    while(n-- > 0)
 454:	00c05f63          	blez	a2,472 <memmove+0x28>
 458:	1602                	slli	a2,a2,0x20
 45a:	9201                	srli	a2,a2,0x20
 45c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 460:	872a                	mv	a4,a0
      *dst++ = *src++;
 462:	0585                	addi	a1,a1,1
 464:	0705                	addi	a4,a4,1
 466:	fff5c683          	lbu	a3,-1(a1)
 46a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 46e:	fee79ae3          	bne	a5,a4,462 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 472:	6422                	ld	s0,8(sp)
 474:	0141                	addi	sp,sp,16
 476:	8082                	ret
    dst += n;
 478:	00c50733          	add	a4,a0,a2
    src += n;
 47c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 47e:	fec05ae3          	blez	a2,472 <memmove+0x28>
 482:	fff6079b          	addiw	a5,a2,-1
 486:	1782                	slli	a5,a5,0x20
 488:	9381                	srli	a5,a5,0x20
 48a:	fff7c793          	not	a5,a5
 48e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 490:	15fd                	addi	a1,a1,-1
 492:	177d                	addi	a4,a4,-1
 494:	0005c683          	lbu	a3,0(a1)
 498:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 49c:	fee79ae3          	bne	a5,a4,490 <memmove+0x46>
 4a0:	bfc9                	j	472 <memmove+0x28>

00000000000004a2 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4a2:	1141                	addi	sp,sp,-16
 4a4:	e422                	sd	s0,8(sp)
 4a6:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4a8:	ca05                	beqz	a2,4d8 <memcmp+0x36>
 4aa:	fff6069b          	addiw	a3,a2,-1
 4ae:	1682                	slli	a3,a3,0x20
 4b0:	9281                	srli	a3,a3,0x20
 4b2:	0685                	addi	a3,a3,1
 4b4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4b6:	00054783          	lbu	a5,0(a0)
 4ba:	0005c703          	lbu	a4,0(a1)
 4be:	00e79863          	bne	a5,a4,4ce <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4c2:	0505                	addi	a0,a0,1
    p2++;
 4c4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4c6:	fed518e3          	bne	a0,a3,4b6 <memcmp+0x14>
  }
  return 0;
 4ca:	4501                	li	a0,0
 4cc:	a019                	j	4d2 <memcmp+0x30>
      return *p1 - *p2;
 4ce:	40e7853b          	subw	a0,a5,a4
}
 4d2:	6422                	ld	s0,8(sp)
 4d4:	0141                	addi	sp,sp,16
 4d6:	8082                	ret
  return 0;
 4d8:	4501                	li	a0,0
 4da:	bfe5                	j	4d2 <memcmp+0x30>

00000000000004dc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4dc:	1141                	addi	sp,sp,-16
 4de:	e406                	sd	ra,8(sp)
 4e0:	e022                	sd	s0,0(sp)
 4e2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4e4:	00000097          	auipc	ra,0x0
 4e8:	f66080e7          	jalr	-154(ra) # 44a <memmove>
}
 4ec:	60a2                	ld	ra,8(sp)
 4ee:	6402                	ld	s0,0(sp)
 4f0:	0141                	addi	sp,sp,16
 4f2:	8082                	ret

00000000000004f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 4f4:	4885                	li	a7,1
 ecall
 4f6:	00000073          	ecall
 ret
 4fa:	8082                	ret

00000000000004fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 4fc:	4889                	li	a7,2
 ecall
 4fe:	00000073          	ecall
 ret
 502:	8082                	ret

0000000000000504 <wait>:
.global wait
wait:
 li a7, SYS_wait
 504:	488d                	li	a7,3
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 50c:	4891                	li	a7,4
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <read>:
.global read
read:
 li a7, SYS_read
 514:	4895                	li	a7,5
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <write>:
.global write
write:
 li a7, SYS_write
 51c:	48c1                	li	a7,16
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <close>:
.global close
close:
 li a7, SYS_close
 524:	48d5                	li	a7,21
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <kill>:
.global kill
kill:
 li a7, SYS_kill
 52c:	4899                	li	a7,6
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <exec>:
.global exec
exec:
 li a7, SYS_exec
 534:	489d                	li	a7,7
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <open>:
.global open
open:
 li a7, SYS_open
 53c:	48bd                	li	a7,15
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 544:	48c5                	li	a7,17
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 54c:	48c9                	li	a7,18
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 554:	48a1                	li	a7,8
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <link>:
.global link
link:
 li a7, SYS_link
 55c:	48cd                	li	a7,19
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 564:	48d1                	li	a7,20
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 56c:	48a5                	li	a7,9
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <dup>:
.global dup
dup:
 li a7, SYS_dup
 574:	48a9                	li	a7,10
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 57c:	48ad                	li	a7,11
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 584:	48b1                	li	a7,12
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 58c:	48b5                	li	a7,13
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 594:	48b9                	li	a7,14
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 59c:	48d9                	li	a7,22
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5a4:	1101                	addi	sp,sp,-32
 5a6:	ec06                	sd	ra,24(sp)
 5a8:	e822                	sd	s0,16(sp)
 5aa:	1000                	addi	s0,sp,32
 5ac:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5b0:	4605                	li	a2,1
 5b2:	fef40593          	addi	a1,s0,-17
 5b6:	00000097          	auipc	ra,0x0
 5ba:	f66080e7          	jalr	-154(ra) # 51c <write>
}
 5be:	60e2                	ld	ra,24(sp)
 5c0:	6442                	ld	s0,16(sp)
 5c2:	6105                	addi	sp,sp,32
 5c4:	8082                	ret

00000000000005c6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5c6:	7139                	addi	sp,sp,-64
 5c8:	fc06                	sd	ra,56(sp)
 5ca:	f822                	sd	s0,48(sp)
 5cc:	f426                	sd	s1,40(sp)
 5ce:	f04a                	sd	s2,32(sp)
 5d0:	ec4e                	sd	s3,24(sp)
 5d2:	0080                	addi	s0,sp,64
 5d4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5d6:	c299                	beqz	a3,5dc <printint+0x16>
 5d8:	0805c863          	bltz	a1,668 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5dc:	2581                	sext.w	a1,a1
  neg = 0;
 5de:	4881                	li	a7,0
 5e0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5e4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5e6:	2601                	sext.w	a2,a2
 5e8:	00000517          	auipc	a0,0x0
 5ec:	45850513          	addi	a0,a0,1112 # a40 <digits>
 5f0:	883a                	mv	a6,a4
 5f2:	2705                	addiw	a4,a4,1
 5f4:	02c5f7bb          	remuw	a5,a1,a2
 5f8:	1782                	slli	a5,a5,0x20
 5fa:	9381                	srli	a5,a5,0x20
 5fc:	97aa                	add	a5,a5,a0
 5fe:	0007c783          	lbu	a5,0(a5)
 602:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 606:	0005879b          	sext.w	a5,a1
 60a:	02c5d5bb          	divuw	a1,a1,a2
 60e:	0685                	addi	a3,a3,1
 610:	fec7f0e3          	bgeu	a5,a2,5f0 <printint+0x2a>
  if(neg)
 614:	00088b63          	beqz	a7,62a <printint+0x64>
    buf[i++] = '-';
 618:	fd040793          	addi	a5,s0,-48
 61c:	973e                	add	a4,a4,a5
 61e:	02d00793          	li	a5,45
 622:	fef70823          	sb	a5,-16(a4)
 626:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 62a:	02e05863          	blez	a4,65a <printint+0x94>
 62e:	fc040793          	addi	a5,s0,-64
 632:	00e78933          	add	s2,a5,a4
 636:	fff78993          	addi	s3,a5,-1
 63a:	99ba                	add	s3,s3,a4
 63c:	377d                	addiw	a4,a4,-1
 63e:	1702                	slli	a4,a4,0x20
 640:	9301                	srli	a4,a4,0x20
 642:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 646:	fff94583          	lbu	a1,-1(s2)
 64a:	8526                	mv	a0,s1
 64c:	00000097          	auipc	ra,0x0
 650:	f58080e7          	jalr	-168(ra) # 5a4 <putc>
  while(--i >= 0)
 654:	197d                	addi	s2,s2,-1
 656:	ff3918e3          	bne	s2,s3,646 <printint+0x80>
}
 65a:	70e2                	ld	ra,56(sp)
 65c:	7442                	ld	s0,48(sp)
 65e:	74a2                	ld	s1,40(sp)
 660:	7902                	ld	s2,32(sp)
 662:	69e2                	ld	s3,24(sp)
 664:	6121                	addi	sp,sp,64
 666:	8082                	ret
    x = -xx;
 668:	40b005bb          	negw	a1,a1
    neg = 1;
 66c:	4885                	li	a7,1
    x = -xx;
 66e:	bf8d                	j	5e0 <printint+0x1a>

0000000000000670 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 670:	7119                	addi	sp,sp,-128
 672:	fc86                	sd	ra,120(sp)
 674:	f8a2                	sd	s0,112(sp)
 676:	f4a6                	sd	s1,104(sp)
 678:	f0ca                	sd	s2,96(sp)
 67a:	ecce                	sd	s3,88(sp)
 67c:	e8d2                	sd	s4,80(sp)
 67e:	e4d6                	sd	s5,72(sp)
 680:	e0da                	sd	s6,64(sp)
 682:	fc5e                	sd	s7,56(sp)
 684:	f862                	sd	s8,48(sp)
 686:	f466                	sd	s9,40(sp)
 688:	f06a                	sd	s10,32(sp)
 68a:	ec6e                	sd	s11,24(sp)
 68c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 68e:	0005c903          	lbu	s2,0(a1)
 692:	18090f63          	beqz	s2,830 <vprintf+0x1c0>
 696:	8aaa                	mv	s5,a0
 698:	8b32                	mv	s6,a2
 69a:	00158493          	addi	s1,a1,1
  state = 0;
 69e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6a0:	02500a13          	li	s4,37
      if(c == 'd'){
 6a4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6a8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6ac:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6b0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6b4:	00000b97          	auipc	s7,0x0
 6b8:	38cb8b93          	addi	s7,s7,908 # a40 <digits>
 6bc:	a839                	j	6da <vprintf+0x6a>
        putc(fd, c);
 6be:	85ca                	mv	a1,s2
 6c0:	8556                	mv	a0,s5
 6c2:	00000097          	auipc	ra,0x0
 6c6:	ee2080e7          	jalr	-286(ra) # 5a4 <putc>
 6ca:	a019                	j	6d0 <vprintf+0x60>
    } else if(state == '%'){
 6cc:	01498f63          	beq	s3,s4,6ea <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6d0:	0485                	addi	s1,s1,1
 6d2:	fff4c903          	lbu	s2,-1(s1)
 6d6:	14090d63          	beqz	s2,830 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6da:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6de:	fe0997e3          	bnez	s3,6cc <vprintf+0x5c>
      if(c == '%'){
 6e2:	fd479ee3          	bne	a5,s4,6be <vprintf+0x4e>
        state = '%';
 6e6:	89be                	mv	s3,a5
 6e8:	b7e5                	j	6d0 <vprintf+0x60>
      if(c == 'd'){
 6ea:	05878063          	beq	a5,s8,72a <vprintf+0xba>
      } else if(c == 'l') {
 6ee:	05978c63          	beq	a5,s9,746 <vprintf+0xd6>
      } else if(c == 'x') {
 6f2:	07a78863          	beq	a5,s10,762 <vprintf+0xf2>
      } else if(c == 'p') {
 6f6:	09b78463          	beq	a5,s11,77e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 6fa:	07300713          	li	a4,115
 6fe:	0ce78663          	beq	a5,a4,7ca <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 702:	06300713          	li	a4,99
 706:	0ee78e63          	beq	a5,a4,802 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 70a:	11478863          	beq	a5,s4,81a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 70e:	85d2                	mv	a1,s4
 710:	8556                	mv	a0,s5
 712:	00000097          	auipc	ra,0x0
 716:	e92080e7          	jalr	-366(ra) # 5a4 <putc>
        putc(fd, c);
 71a:	85ca                	mv	a1,s2
 71c:	8556                	mv	a0,s5
 71e:	00000097          	auipc	ra,0x0
 722:	e86080e7          	jalr	-378(ra) # 5a4 <putc>
      }
      state = 0;
 726:	4981                	li	s3,0
 728:	b765                	j	6d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 72a:	008b0913          	addi	s2,s6,8
 72e:	4685                	li	a3,1
 730:	4629                	li	a2,10
 732:	000b2583          	lw	a1,0(s6)
 736:	8556                	mv	a0,s5
 738:	00000097          	auipc	ra,0x0
 73c:	e8e080e7          	jalr	-370(ra) # 5c6 <printint>
 740:	8b4a                	mv	s6,s2
      state = 0;
 742:	4981                	li	s3,0
 744:	b771                	j	6d0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 746:	008b0913          	addi	s2,s6,8
 74a:	4681                	li	a3,0
 74c:	4629                	li	a2,10
 74e:	000b2583          	lw	a1,0(s6)
 752:	8556                	mv	a0,s5
 754:	00000097          	auipc	ra,0x0
 758:	e72080e7          	jalr	-398(ra) # 5c6 <printint>
 75c:	8b4a                	mv	s6,s2
      state = 0;
 75e:	4981                	li	s3,0
 760:	bf85                	j	6d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 762:	008b0913          	addi	s2,s6,8
 766:	4681                	li	a3,0
 768:	4641                	li	a2,16
 76a:	000b2583          	lw	a1,0(s6)
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e56080e7          	jalr	-426(ra) # 5c6 <printint>
 778:	8b4a                	mv	s6,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	bf91                	j	6d0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 77e:	008b0793          	addi	a5,s6,8
 782:	f8f43423          	sd	a5,-120(s0)
 786:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 78a:	03000593          	li	a1,48
 78e:	8556                	mv	a0,s5
 790:	00000097          	auipc	ra,0x0
 794:	e14080e7          	jalr	-492(ra) # 5a4 <putc>
  putc(fd, 'x');
 798:	85ea                	mv	a1,s10
 79a:	8556                	mv	a0,s5
 79c:	00000097          	auipc	ra,0x0
 7a0:	e08080e7          	jalr	-504(ra) # 5a4 <putc>
 7a4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a6:	03c9d793          	srli	a5,s3,0x3c
 7aa:	97de                	add	a5,a5,s7
 7ac:	0007c583          	lbu	a1,0(a5)
 7b0:	8556                	mv	a0,s5
 7b2:	00000097          	auipc	ra,0x0
 7b6:	df2080e7          	jalr	-526(ra) # 5a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7ba:	0992                	slli	s3,s3,0x4
 7bc:	397d                	addiw	s2,s2,-1
 7be:	fe0914e3          	bnez	s2,7a6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7c2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7c6:	4981                	li	s3,0
 7c8:	b721                	j	6d0 <vprintf+0x60>
        s = va_arg(ap, char*);
 7ca:	008b0993          	addi	s3,s6,8
 7ce:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7d2:	02090163          	beqz	s2,7f4 <vprintf+0x184>
        while(*s != 0){
 7d6:	00094583          	lbu	a1,0(s2)
 7da:	c9a1                	beqz	a1,82a <vprintf+0x1ba>
          putc(fd, *s);
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	dc6080e7          	jalr	-570(ra) # 5a4 <putc>
          s++;
 7e6:	0905                	addi	s2,s2,1
        while(*s != 0){
 7e8:	00094583          	lbu	a1,0(s2)
 7ec:	f9e5                	bnez	a1,7dc <vprintf+0x16c>
        s = va_arg(ap, char*);
 7ee:	8b4e                	mv	s6,s3
      state = 0;
 7f0:	4981                	li	s3,0
 7f2:	bdf9                	j	6d0 <vprintf+0x60>
          s = "(null)";
 7f4:	00000917          	auipc	s2,0x0
 7f8:	24490913          	addi	s2,s2,580 # a38 <malloc+0xfe>
        while(*s != 0){
 7fc:	02800593          	li	a1,40
 800:	bff1                	j	7dc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 802:	008b0913          	addi	s2,s6,8
 806:	000b4583          	lbu	a1,0(s6)
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	d98080e7          	jalr	-616(ra) # 5a4 <putc>
 814:	8b4a                	mv	s6,s2
      state = 0;
 816:	4981                	li	s3,0
 818:	bd65                	j	6d0 <vprintf+0x60>
        putc(fd, c);
 81a:	85d2                	mv	a1,s4
 81c:	8556                	mv	a0,s5
 81e:	00000097          	auipc	ra,0x0
 822:	d86080e7          	jalr	-634(ra) # 5a4 <putc>
      state = 0;
 826:	4981                	li	s3,0
 828:	b565                	j	6d0 <vprintf+0x60>
        s = va_arg(ap, char*);
 82a:	8b4e                	mv	s6,s3
      state = 0;
 82c:	4981                	li	s3,0
 82e:	b54d                	j	6d0 <vprintf+0x60>
    }
  }
}
 830:	70e6                	ld	ra,120(sp)
 832:	7446                	ld	s0,112(sp)
 834:	74a6                	ld	s1,104(sp)
 836:	7906                	ld	s2,96(sp)
 838:	69e6                	ld	s3,88(sp)
 83a:	6a46                	ld	s4,80(sp)
 83c:	6aa6                	ld	s5,72(sp)
 83e:	6b06                	ld	s6,64(sp)
 840:	7be2                	ld	s7,56(sp)
 842:	7c42                	ld	s8,48(sp)
 844:	7ca2                	ld	s9,40(sp)
 846:	7d02                	ld	s10,32(sp)
 848:	6de2                	ld	s11,24(sp)
 84a:	6109                	addi	sp,sp,128
 84c:	8082                	ret

000000000000084e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 84e:	715d                	addi	sp,sp,-80
 850:	ec06                	sd	ra,24(sp)
 852:	e822                	sd	s0,16(sp)
 854:	1000                	addi	s0,sp,32
 856:	e010                	sd	a2,0(s0)
 858:	e414                	sd	a3,8(s0)
 85a:	e818                	sd	a4,16(s0)
 85c:	ec1c                	sd	a5,24(s0)
 85e:	03043023          	sd	a6,32(s0)
 862:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 866:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 86a:	8622                	mv	a2,s0
 86c:	00000097          	auipc	ra,0x0
 870:	e04080e7          	jalr	-508(ra) # 670 <vprintf>
}
 874:	60e2                	ld	ra,24(sp)
 876:	6442                	ld	s0,16(sp)
 878:	6161                	addi	sp,sp,80
 87a:	8082                	ret

000000000000087c <printf>:

void
printf(const char *fmt, ...)
{
 87c:	711d                	addi	sp,sp,-96
 87e:	ec06                	sd	ra,24(sp)
 880:	e822                	sd	s0,16(sp)
 882:	1000                	addi	s0,sp,32
 884:	e40c                	sd	a1,8(s0)
 886:	e810                	sd	a2,16(s0)
 888:	ec14                	sd	a3,24(s0)
 88a:	f018                	sd	a4,32(s0)
 88c:	f41c                	sd	a5,40(s0)
 88e:	03043823          	sd	a6,48(s0)
 892:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 896:	00840613          	addi	a2,s0,8
 89a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 89e:	85aa                	mv	a1,a0
 8a0:	4505                	li	a0,1
 8a2:	00000097          	auipc	ra,0x0
 8a6:	dce080e7          	jalr	-562(ra) # 670 <vprintf>
}
 8aa:	60e2                	ld	ra,24(sp)
 8ac:	6442                	ld	s0,16(sp)
 8ae:	6125                	addi	sp,sp,96
 8b0:	8082                	ret

00000000000008b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8b2:	1141                	addi	sp,sp,-16
 8b4:	e422                	sd	s0,8(sp)
 8b6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8b8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8bc:	00000797          	auipc	a5,0x0
 8c0:	19c7b783          	ld	a5,412(a5) # a58 <freep>
 8c4:	a805                	j	8f4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8c6:	4618                	lw	a4,8(a2)
 8c8:	9db9                	addw	a1,a1,a4
 8ca:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ce:	6398                	ld	a4,0(a5)
 8d0:	6318                	ld	a4,0(a4)
 8d2:	fee53823          	sd	a4,-16(a0)
 8d6:	a091                	j	91a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8d8:	ff852703          	lw	a4,-8(a0)
 8dc:	9e39                	addw	a2,a2,a4
 8de:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8e0:	ff053703          	ld	a4,-16(a0)
 8e4:	e398                	sd	a4,0(a5)
 8e6:	a099                	j	92c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8e8:	6398                	ld	a4,0(a5)
 8ea:	00e7e463          	bltu	a5,a4,8f2 <free+0x40>
 8ee:	00e6ea63          	bltu	a3,a4,902 <free+0x50>
{
 8f2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f4:	fed7fae3          	bgeu	a5,a3,8e8 <free+0x36>
 8f8:	6398                	ld	a4,0(a5)
 8fa:	00e6e463          	bltu	a3,a4,902 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fe:	fee7eae3          	bltu	a5,a4,8f2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 902:	ff852583          	lw	a1,-8(a0)
 906:	6390                	ld	a2,0(a5)
 908:	02059813          	slli	a6,a1,0x20
 90c:	01c85713          	srli	a4,a6,0x1c
 910:	9736                	add	a4,a4,a3
 912:	fae60ae3          	beq	a2,a4,8c6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 916:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 91a:	4790                	lw	a2,8(a5)
 91c:	02061593          	slli	a1,a2,0x20
 920:	01c5d713          	srli	a4,a1,0x1c
 924:	973e                	add	a4,a4,a5
 926:	fae689e3          	beq	a3,a4,8d8 <free+0x26>
  } else
    p->s.ptr = bp;
 92a:	e394                	sd	a3,0(a5)
  freep = p;
 92c:	00000717          	auipc	a4,0x0
 930:	12f73623          	sd	a5,300(a4) # a58 <freep>
}
 934:	6422                	ld	s0,8(sp)
 936:	0141                	addi	sp,sp,16
 938:	8082                	ret

000000000000093a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 93a:	7139                	addi	sp,sp,-64
 93c:	fc06                	sd	ra,56(sp)
 93e:	f822                	sd	s0,48(sp)
 940:	f426                	sd	s1,40(sp)
 942:	f04a                	sd	s2,32(sp)
 944:	ec4e                	sd	s3,24(sp)
 946:	e852                	sd	s4,16(sp)
 948:	e456                	sd	s5,8(sp)
 94a:	e05a                	sd	s6,0(sp)
 94c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 94e:	02051493          	slli	s1,a0,0x20
 952:	9081                	srli	s1,s1,0x20
 954:	04bd                	addi	s1,s1,15
 956:	8091                	srli	s1,s1,0x4
 958:	0014899b          	addiw	s3,s1,1
 95c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 95e:	00000517          	auipc	a0,0x0
 962:	0fa53503          	ld	a0,250(a0) # a58 <freep>
 966:	c515                	beqz	a0,992 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 968:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96a:	4798                	lw	a4,8(a5)
 96c:	02977f63          	bgeu	a4,s1,9aa <malloc+0x70>
 970:	8a4e                	mv	s4,s3
 972:	0009871b          	sext.w	a4,s3
 976:	6685                	lui	a3,0x1
 978:	00d77363          	bgeu	a4,a3,97e <malloc+0x44>
 97c:	6a05                	lui	s4,0x1
 97e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 982:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 986:	00000917          	auipc	s2,0x0
 98a:	0d290913          	addi	s2,s2,210 # a58 <freep>
  if(p == (char*)-1)
 98e:	5afd                	li	s5,-1
 990:	a895                	j	a04 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 992:	00000797          	auipc	a5,0x0
 996:	1be78793          	addi	a5,a5,446 # b50 <base>
 99a:	00000717          	auipc	a4,0x0
 99e:	0af73f23          	sd	a5,190(a4) # a58 <freep>
 9a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9a8:	b7e1                	j	970 <malloc+0x36>
      if(p->s.size == nunits)
 9aa:	02e48c63          	beq	s1,a4,9e2 <malloc+0xa8>
        p->s.size -= nunits;
 9ae:	4137073b          	subw	a4,a4,s3
 9b2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9b4:	02071693          	slli	a3,a4,0x20
 9b8:	01c6d713          	srli	a4,a3,0x1c
 9bc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9be:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9c2:	00000717          	auipc	a4,0x0
 9c6:	08a73b23          	sd	a0,150(a4) # a58 <freep>
      return (void*)(p + 1);
 9ca:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9ce:	70e2                	ld	ra,56(sp)
 9d0:	7442                	ld	s0,48(sp)
 9d2:	74a2                	ld	s1,40(sp)
 9d4:	7902                	ld	s2,32(sp)
 9d6:	69e2                	ld	s3,24(sp)
 9d8:	6a42                	ld	s4,16(sp)
 9da:	6aa2                	ld	s5,8(sp)
 9dc:	6b02                	ld	s6,0(sp)
 9de:	6121                	addi	sp,sp,64
 9e0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9e2:	6398                	ld	a4,0(a5)
 9e4:	e118                	sd	a4,0(a0)
 9e6:	bff1                	j	9c2 <malloc+0x88>
  hp->s.size = nu;
 9e8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ec:	0541                	addi	a0,a0,16
 9ee:	00000097          	auipc	ra,0x0
 9f2:	ec4080e7          	jalr	-316(ra) # 8b2 <free>
  return freep;
 9f6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9fa:	d971                	beqz	a0,9ce <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9fc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9fe:	4798                	lw	a4,8(a5)
 a00:	fa9775e3          	bgeu	a4,s1,9aa <malloc+0x70>
    if(p == freep)
 a04:	00093703          	ld	a4,0(s2)
 a08:	853e                	mv	a0,a5
 a0a:	fef719e3          	bne	a4,a5,9fc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a0e:	8552                	mv	a0,s4
 a10:	00000097          	auipc	ra,0x0
 a14:	b74080e7          	jalr	-1164(ra) # 584 <sbrk>
  if(p == (char*)-1)
 a18:	fd5518e3          	bne	a0,s5,9e8 <malloc+0xae>
        return 0;
 a1c:	4501                	li	a0,0
 a1e:	bf45                	j	9ce <malloc+0x94>
