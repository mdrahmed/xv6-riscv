
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
  2c:	3f0080e7          	jalr	1008(ra) # 418 <atoi>
  30:	00000097          	auipc	ra,0x0
  34:	514080e7          	jalr	1300(ra) # 544 <kill>
  for(i=1; i<argc; i++)
  38:	04a1                	addi	s1,s1,8
  3a:	ff2496e3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  3e:	4501                	li	a0,0
  40:	00000097          	auipc	ra,0x0
  44:	4d4080e7          	jalr	1236(ra) # 514 <exit>
    fprintf(2, "usage: kill pid...\n");
  48:	00001597          	auipc	a1,0x1
  4c:	9f058593          	addi	a1,a1,-1552 # a38 <malloc+0xe6>
  50:	4509                	li	a0,2
  52:	00001097          	auipc	ra,0x1
  56:	814080e7          	jalr	-2028(ra) # 866 <fprintf>
    exit(1);
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	4b8080e7          	jalr	1208(ra) # 514 <exit>

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
  aa:	9e248493          	addi	s1,s1,-1566 # a88 <rings+0x10>
  ae:	00001917          	auipc	s2,0x1
  b2:	aca90913          	addi	s2,s2,-1334 # b78 <__BSS_END__>
  b6:	04f59563          	bne	a1,a5,100 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
  ba:	00001497          	auipc	s1,0x1
  be:	9ce4a483          	lw	s1,-1586(s1) # a88 <rings+0x10>
  c2:	c099                	beqz	s1,c8 <create_or_close_the_buffer_user+0x38>
  c4:	4481                	li	s1,0
  c6:	a899                	j	11c <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
  c8:	00001917          	auipc	s2,0x1
  cc:	9b090913          	addi	s2,s2,-1616 # a78 <rings>
  d0:	00093603          	ld	a2,0(s2)
  d4:	4585                	li	a1,1
  d6:	00000097          	auipc	ra,0x0
  da:	4de080e7          	jalr	1246(ra) # 5b4 <ringbuf>
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
 110:	4a8080e7          	jalr	1192(ra) # 5b4 <ringbuf>
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
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 12e:	1101                	addi	sp,sp,-32
 130:	ec06                	sd	ra,24(sp)
 132:	e822                	sd	s0,16(sp)
 134:	e426                	sd	s1,8(sp)
 136:	1000                	addi	s0,sp,32
 138:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 13a:	00151793          	slli	a5,a0,0x1
 13e:	97aa                	add	a5,a5,a0
 140:	078e                	slli	a5,a5,0x3
 142:	00001717          	auipc	a4,0x1
 146:	93670713          	addi	a4,a4,-1738 # a78 <rings>
 14a:	97ba                	add	a5,a5,a4
 14c:	6798                	ld	a4,8(a5)
 14e:	671c                	ld	a5,8(a4)
 150:	00178693          	addi	a3,a5,1
 154:	e714                	sd	a3,8(a4)
 156:	17d2                	slli	a5,a5,0x34
 158:	93d1                	srli	a5,a5,0x34
 15a:	6741                	lui	a4,0x10
 15c:	40f707b3          	sub	a5,a4,a5
 160:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 162:	421c                	lw	a5,0(a2)
 164:	e79d                	bnez	a5,192 <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 166:	00001697          	auipc	a3,0x1
 16a:	91268693          	addi	a3,a3,-1774 # a78 <rings>
 16e:	669c                	ld	a5,8(a3)
 170:	6398                	ld	a4,0(a5)
 172:	67c1                	lui	a5,0x10
 174:	9fb9                	addw	a5,a5,a4
 176:	00151713          	slli	a4,a0,0x1
 17a:	953a                	add	a0,a0,a4
 17c:	050e                	slli	a0,a0,0x3
 17e:	9536                	add	a0,a0,a3
 180:	6518                	ld	a4,8(a0)
 182:	6718                	ld	a4,8(a4)
 184:	9f99                	subw	a5,a5,a4
 186:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 188:	60e2                	ld	ra,24(sp)
 18a:	6442                	ld	s0,16(sp)
 18c:	64a2                	ld	s1,8(sp)
 18e:	6105                	addi	sp,sp,32
 190:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 192:	00151793          	slli	a5,a0,0x1
 196:	953e                	add	a0,a0,a5
 198:	050e                	slli	a0,a0,0x3
 19a:	00001797          	auipc	a5,0x1
 19e:	8de78793          	addi	a5,a5,-1826 # a78 <rings>
 1a2:	953e                	add	a0,a0,a5
 1a4:	6508                	ld	a0,8(a0)
 1a6:	0521                	addi	a0,a0,8
 1a8:	00000097          	auipc	ra,0x0
 1ac:	ed0080e7          	jalr	-304(ra) # 78 <load>
 1b0:	c088                	sw	a0,0(s1)
}
 1b2:	bfd9                	j	188 <ringbuf_start_write+0x5a>

00000000000001b4 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1b4:	1141                	addi	sp,sp,-16
 1b6:	e406                	sd	ra,8(sp)
 1b8:	e022                	sd	s0,0(sp)
 1ba:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1bc:	00151793          	slli	a5,a0,0x1
 1c0:	97aa                	add	a5,a5,a0
 1c2:	078e                	slli	a5,a5,0x3
 1c4:	00001517          	auipc	a0,0x1
 1c8:	8b450513          	addi	a0,a0,-1868 # a78 <rings>
 1cc:	97aa                	add	a5,a5,a0
 1ce:	6788                	ld	a0,8(a5)
 1d0:	0035959b          	slliw	a1,a1,0x3
 1d4:	0521                	addi	a0,a0,8
 1d6:	00000097          	auipc	ra,0x0
 1da:	e8e080e7          	jalr	-370(ra) # 64 <store>
}
 1de:	60a2                	ld	ra,8(sp)
 1e0:	6402                	ld	s0,0(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret

00000000000001e6 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 1e6:	1101                	addi	sp,sp,-32
 1e8:	ec06                	sd	ra,24(sp)
 1ea:	e822                	sd	s0,16(sp)
 1ec:	e426                	sd	s1,8(sp)
 1ee:	1000                	addi	s0,sp,32
 1f0:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 1f2:	00151793          	slli	a5,a0,0x1
 1f6:	97aa                	add	a5,a5,a0
 1f8:	078e                	slli	a5,a5,0x3
 1fa:	00001517          	auipc	a0,0x1
 1fe:	87e50513          	addi	a0,a0,-1922 # a78 <rings>
 202:	97aa                	add	a5,a5,a0
 204:	6788                	ld	a0,8(a5)
 206:	0521                	addi	a0,a0,8
 208:	00000097          	auipc	ra,0x0
 20c:	e70080e7          	jalr	-400(ra) # 78 <load>
 210:	c088                	sw	a0,0(s1)
}
 212:	60e2                	ld	ra,24(sp)
 214:	6442                	ld	s0,16(sp)
 216:	64a2                	ld	s1,8(sp)
 218:	6105                	addi	sp,sp,32
 21a:	8082                	ret

000000000000021c <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 21c:	1101                	addi	sp,sp,-32
 21e:	ec06                	sd	ra,24(sp)
 220:	e822                	sd	s0,16(sp)
 222:	e426                	sd	s1,8(sp)
 224:	1000                	addi	s0,sp,32
 226:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 228:	00151793          	slli	a5,a0,0x1
 22c:	97aa                	add	a5,a5,a0
 22e:	078e                	slli	a5,a5,0x3
 230:	00001517          	auipc	a0,0x1
 234:	84850513          	addi	a0,a0,-1976 # a78 <rings>
 238:	97aa                	add	a5,a5,a0
 23a:	6788                	ld	a0,8(a5)
 23c:	611c                	ld	a5,0(a0)
 23e:	ef99                	bnez	a5,25c <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 240:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 242:	41f7579b          	sraiw	a5,a4,0x1f
 246:	01d7d79b          	srliw	a5,a5,0x1d
 24a:	9fb9                	addw	a5,a5,a4
 24c:	4037d79b          	sraiw	a5,a5,0x3
 250:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 252:	60e2                	ld	ra,24(sp)
 254:	6442                	ld	s0,16(sp)
 256:	64a2                	ld	s1,8(sp)
 258:	6105                	addi	sp,sp,32
 25a:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 25c:	00000097          	auipc	ra,0x0
 260:	e1c080e7          	jalr	-484(ra) # 78 <load>
    *bytes /= 8;
 264:	41f5579b          	sraiw	a5,a0,0x1f
 268:	01d7d79b          	srliw	a5,a5,0x1d
 26c:	9d3d                	addw	a0,a0,a5
 26e:	4035551b          	sraiw	a0,a0,0x3
 272:	c088                	sw	a0,0(s1)
}
 274:	bff9                	j	252 <ringbuf_start_read+0x36>

0000000000000276 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 276:	1141                	addi	sp,sp,-16
 278:	e406                	sd	ra,8(sp)
 27a:	e022                	sd	s0,0(sp)
 27c:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 27e:	00151793          	slli	a5,a0,0x1
 282:	97aa                	add	a5,a5,a0
 284:	078e                	slli	a5,a5,0x3
 286:	00000517          	auipc	a0,0x0
 28a:	7f250513          	addi	a0,a0,2034 # a78 <rings>
 28e:	97aa                	add	a5,a5,a0
 290:	0035959b          	slliw	a1,a1,0x3
 294:	6788                	ld	a0,8(a5)
 296:	00000097          	auipc	ra,0x0
 29a:	dce080e7          	jalr	-562(ra) # 64 <store>
}
 29e:	60a2                	ld	ra,8(sp)
 2a0:	6402                	ld	s0,0(sp)
 2a2:	0141                	addi	sp,sp,16
 2a4:	8082                	ret

00000000000002a6 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2a6:	1141                	addi	sp,sp,-16
 2a8:	e422                	sd	s0,8(sp)
 2aa:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2ac:	87aa                	mv	a5,a0
 2ae:	0585                	addi	a1,a1,1
 2b0:	0785                	addi	a5,a5,1
 2b2:	fff5c703          	lbu	a4,-1(a1)
 2b6:	fee78fa3          	sb	a4,-1(a5)
 2ba:	fb75                	bnez	a4,2ae <strcpy+0x8>
    ;
  return os;
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret

00000000000002c2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c2:	1141                	addi	sp,sp,-16
 2c4:	e422                	sd	s0,8(sp)
 2c6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2c8:	00054783          	lbu	a5,0(a0)
 2cc:	cb91                	beqz	a5,2e0 <strcmp+0x1e>
 2ce:	0005c703          	lbu	a4,0(a1)
 2d2:	00f71763          	bne	a4,a5,2e0 <strcmp+0x1e>
    p++, q++;
 2d6:	0505                	addi	a0,a0,1
 2d8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2da:	00054783          	lbu	a5,0(a0)
 2de:	fbe5                	bnez	a5,2ce <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 2e0:	0005c503          	lbu	a0,0(a1)
}
 2e4:	40a7853b          	subw	a0,a5,a0
 2e8:	6422                	ld	s0,8(sp)
 2ea:	0141                	addi	sp,sp,16
 2ec:	8082                	ret

00000000000002ee <strlen>:

uint
strlen(const char *s)
{
 2ee:	1141                	addi	sp,sp,-16
 2f0:	e422                	sd	s0,8(sp)
 2f2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 2f4:	00054783          	lbu	a5,0(a0)
 2f8:	cf91                	beqz	a5,314 <strlen+0x26>
 2fa:	0505                	addi	a0,a0,1
 2fc:	87aa                	mv	a5,a0
 2fe:	4685                	li	a3,1
 300:	9e89                	subw	a3,a3,a0
 302:	00f6853b          	addw	a0,a3,a5
 306:	0785                	addi	a5,a5,1
 308:	fff7c703          	lbu	a4,-1(a5)
 30c:	fb7d                	bnez	a4,302 <strlen+0x14>
    ;
  return n;
}
 30e:	6422                	ld	s0,8(sp)
 310:	0141                	addi	sp,sp,16
 312:	8082                	ret
  for(n = 0; s[n]; n++)
 314:	4501                	li	a0,0
 316:	bfe5                	j	30e <strlen+0x20>

0000000000000318 <memset>:

void*
memset(void *dst, int c, uint n)
{
 318:	1141                	addi	sp,sp,-16
 31a:	e422                	sd	s0,8(sp)
 31c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 31e:	ca19                	beqz	a2,334 <memset+0x1c>
 320:	87aa                	mv	a5,a0
 322:	1602                	slli	a2,a2,0x20
 324:	9201                	srli	a2,a2,0x20
 326:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 32a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 32e:	0785                	addi	a5,a5,1
 330:	fee79de3          	bne	a5,a4,32a <memset+0x12>
  }
  return dst;
}
 334:	6422                	ld	s0,8(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <strchr>:

char*
strchr(const char *s, char c)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 340:	00054783          	lbu	a5,0(a0)
 344:	cb99                	beqz	a5,35a <strchr+0x20>
    if(*s == c)
 346:	00f58763          	beq	a1,a5,354 <strchr+0x1a>
  for(; *s; s++)
 34a:	0505                	addi	a0,a0,1
 34c:	00054783          	lbu	a5,0(a0)
 350:	fbfd                	bnez	a5,346 <strchr+0xc>
      return (char*)s;
  return 0;
 352:	4501                	li	a0,0
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret
  return 0;
 35a:	4501                	li	a0,0
 35c:	bfe5                	j	354 <strchr+0x1a>

000000000000035e <gets>:

char*
gets(char *buf, int max)
{
 35e:	711d                	addi	sp,sp,-96
 360:	ec86                	sd	ra,88(sp)
 362:	e8a2                	sd	s0,80(sp)
 364:	e4a6                	sd	s1,72(sp)
 366:	e0ca                	sd	s2,64(sp)
 368:	fc4e                	sd	s3,56(sp)
 36a:	f852                	sd	s4,48(sp)
 36c:	f456                	sd	s5,40(sp)
 36e:	f05a                	sd	s6,32(sp)
 370:	ec5e                	sd	s7,24(sp)
 372:	1080                	addi	s0,sp,96
 374:	8baa                	mv	s7,a0
 376:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 378:	892a                	mv	s2,a0
 37a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 37c:	4aa9                	li	s5,10
 37e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 380:	89a6                	mv	s3,s1
 382:	2485                	addiw	s1,s1,1
 384:	0344d863          	bge	s1,s4,3b4 <gets+0x56>
    cc = read(0, &c, 1);
 388:	4605                	li	a2,1
 38a:	faf40593          	addi	a1,s0,-81
 38e:	4501                	li	a0,0
 390:	00000097          	auipc	ra,0x0
 394:	19c080e7          	jalr	412(ra) # 52c <read>
    if(cc < 1)
 398:	00a05e63          	blez	a0,3b4 <gets+0x56>
    buf[i++] = c;
 39c:	faf44783          	lbu	a5,-81(s0)
 3a0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3a4:	01578763          	beq	a5,s5,3b2 <gets+0x54>
 3a8:	0905                	addi	s2,s2,1
 3aa:	fd679be3          	bne	a5,s6,380 <gets+0x22>
  for(i=0; i+1 < max; ){
 3ae:	89a6                	mv	s3,s1
 3b0:	a011                	j	3b4 <gets+0x56>
 3b2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3b4:	99de                	add	s3,s3,s7
 3b6:	00098023          	sb	zero,0(s3)
  return buf;
}
 3ba:	855e                	mv	a0,s7
 3bc:	60e6                	ld	ra,88(sp)
 3be:	6446                	ld	s0,80(sp)
 3c0:	64a6                	ld	s1,72(sp)
 3c2:	6906                	ld	s2,64(sp)
 3c4:	79e2                	ld	s3,56(sp)
 3c6:	7a42                	ld	s4,48(sp)
 3c8:	7aa2                	ld	s5,40(sp)
 3ca:	7b02                	ld	s6,32(sp)
 3cc:	6be2                	ld	s7,24(sp)
 3ce:	6125                	addi	sp,sp,96
 3d0:	8082                	ret

00000000000003d2 <stat>:

int
stat(const char *n, struct stat *st)
{
 3d2:	1101                	addi	sp,sp,-32
 3d4:	ec06                	sd	ra,24(sp)
 3d6:	e822                	sd	s0,16(sp)
 3d8:	e426                	sd	s1,8(sp)
 3da:	e04a                	sd	s2,0(sp)
 3dc:	1000                	addi	s0,sp,32
 3de:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e0:	4581                	li	a1,0
 3e2:	00000097          	auipc	ra,0x0
 3e6:	172080e7          	jalr	370(ra) # 554 <open>
  if(fd < 0)
 3ea:	02054563          	bltz	a0,414 <stat+0x42>
 3ee:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 3f0:	85ca                	mv	a1,s2
 3f2:	00000097          	auipc	ra,0x0
 3f6:	17a080e7          	jalr	378(ra) # 56c <fstat>
 3fa:	892a                	mv	s2,a0
  close(fd);
 3fc:	8526                	mv	a0,s1
 3fe:	00000097          	auipc	ra,0x0
 402:	13e080e7          	jalr	318(ra) # 53c <close>
  return r;
}
 406:	854a                	mv	a0,s2
 408:	60e2                	ld	ra,24(sp)
 40a:	6442                	ld	s0,16(sp)
 40c:	64a2                	ld	s1,8(sp)
 40e:	6902                	ld	s2,0(sp)
 410:	6105                	addi	sp,sp,32
 412:	8082                	ret
    return -1;
 414:	597d                	li	s2,-1
 416:	bfc5                	j	406 <stat+0x34>

0000000000000418 <atoi>:

int
atoi(const char *s)
{
 418:	1141                	addi	sp,sp,-16
 41a:	e422                	sd	s0,8(sp)
 41c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 41e:	00054603          	lbu	a2,0(a0)
 422:	fd06079b          	addiw	a5,a2,-48
 426:	0ff7f793          	zext.b	a5,a5
 42a:	4725                	li	a4,9
 42c:	02f76963          	bltu	a4,a5,45e <atoi+0x46>
 430:	86aa                	mv	a3,a0
  n = 0;
 432:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 434:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 436:	0685                	addi	a3,a3,1
 438:	0025179b          	slliw	a5,a0,0x2
 43c:	9fa9                	addw	a5,a5,a0
 43e:	0017979b          	slliw	a5,a5,0x1
 442:	9fb1                	addw	a5,a5,a2
 444:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 448:	0006c603          	lbu	a2,0(a3)
 44c:	fd06071b          	addiw	a4,a2,-48
 450:	0ff77713          	zext.b	a4,a4
 454:	fee5f1e3          	bgeu	a1,a4,436 <atoi+0x1e>
  return n;
}
 458:	6422                	ld	s0,8(sp)
 45a:	0141                	addi	sp,sp,16
 45c:	8082                	ret
  n = 0;
 45e:	4501                	li	a0,0
 460:	bfe5                	j	458 <atoi+0x40>

0000000000000462 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 462:	1141                	addi	sp,sp,-16
 464:	e422                	sd	s0,8(sp)
 466:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 468:	02b57463          	bgeu	a0,a1,490 <memmove+0x2e>
    while(n-- > 0)
 46c:	00c05f63          	blez	a2,48a <memmove+0x28>
 470:	1602                	slli	a2,a2,0x20
 472:	9201                	srli	a2,a2,0x20
 474:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 478:	872a                	mv	a4,a0
      *dst++ = *src++;
 47a:	0585                	addi	a1,a1,1
 47c:	0705                	addi	a4,a4,1
 47e:	fff5c683          	lbu	a3,-1(a1)
 482:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xed96>
    while(n-- > 0)
 486:	fee79ae3          	bne	a5,a4,47a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 48a:	6422                	ld	s0,8(sp)
 48c:	0141                	addi	sp,sp,16
 48e:	8082                	ret
    dst += n;
 490:	00c50733          	add	a4,a0,a2
    src += n;
 494:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 496:	fec05ae3          	blez	a2,48a <memmove+0x28>
 49a:	fff6079b          	addiw	a5,a2,-1
 49e:	1782                	slli	a5,a5,0x20
 4a0:	9381                	srli	a5,a5,0x20
 4a2:	fff7c793          	not	a5,a5
 4a6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4a8:	15fd                	addi	a1,a1,-1
 4aa:	177d                	addi	a4,a4,-1
 4ac:	0005c683          	lbu	a3,0(a1)
 4b0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4b4:	fee79ae3          	bne	a5,a4,4a8 <memmove+0x46>
 4b8:	bfc9                	j	48a <memmove+0x28>

00000000000004ba <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e422                	sd	s0,8(sp)
 4be:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4c0:	ca05                	beqz	a2,4f0 <memcmp+0x36>
 4c2:	fff6069b          	addiw	a3,a2,-1
 4c6:	1682                	slli	a3,a3,0x20
 4c8:	9281                	srli	a3,a3,0x20
 4ca:	0685                	addi	a3,a3,1
 4cc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ce:	00054783          	lbu	a5,0(a0)
 4d2:	0005c703          	lbu	a4,0(a1)
 4d6:	00e79863          	bne	a5,a4,4e6 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4da:	0505                	addi	a0,a0,1
    p2++;
 4dc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4de:	fed518e3          	bne	a0,a3,4ce <memcmp+0x14>
  }
  return 0;
 4e2:	4501                	li	a0,0
 4e4:	a019                	j	4ea <memcmp+0x30>
      return *p1 - *p2;
 4e6:	40e7853b          	subw	a0,a5,a4
}
 4ea:	6422                	ld	s0,8(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret
  return 0;
 4f0:	4501                	li	a0,0
 4f2:	bfe5                	j	4ea <memcmp+0x30>

00000000000004f4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 4f4:	1141                	addi	sp,sp,-16
 4f6:	e406                	sd	ra,8(sp)
 4f8:	e022                	sd	s0,0(sp)
 4fa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 4fc:	00000097          	auipc	ra,0x0
 500:	f66080e7          	jalr	-154(ra) # 462 <memmove>
}
 504:	60a2                	ld	ra,8(sp)
 506:	6402                	ld	s0,0(sp)
 508:	0141                	addi	sp,sp,16
 50a:	8082                	ret

000000000000050c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 50c:	4885                	li	a7,1
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <exit>:
.global exit
exit:
 li a7, SYS_exit
 514:	4889                	li	a7,2
 ecall
 516:	00000073          	ecall
 ret
 51a:	8082                	ret

000000000000051c <wait>:
.global wait
wait:
 li a7, SYS_wait
 51c:	488d                	li	a7,3
 ecall
 51e:	00000073          	ecall
 ret
 522:	8082                	ret

0000000000000524 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 524:	4891                	li	a7,4
 ecall
 526:	00000073          	ecall
 ret
 52a:	8082                	ret

000000000000052c <read>:
.global read
read:
 li a7, SYS_read
 52c:	4895                	li	a7,5
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <write>:
.global write
write:
 li a7, SYS_write
 534:	48c1                	li	a7,16
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <close>:
.global close
close:
 li a7, SYS_close
 53c:	48d5                	li	a7,21
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <kill>:
.global kill
kill:
 li a7, SYS_kill
 544:	4899                	li	a7,6
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <exec>:
.global exec
exec:
 li a7, SYS_exec
 54c:	489d                	li	a7,7
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <open>:
.global open
open:
 li a7, SYS_open
 554:	48bd                	li	a7,15
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 55c:	48c5                	li	a7,17
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 564:	48c9                	li	a7,18
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 56c:	48a1                	li	a7,8
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <link>:
.global link
link:
 li a7, SYS_link
 574:	48cd                	li	a7,19
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 57c:	48d1                	li	a7,20
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 584:	48a5                	li	a7,9
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <dup>:
.global dup
dup:
 li a7, SYS_dup
 58c:	48a9                	li	a7,10
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 594:	48ad                	li	a7,11
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 59c:	48b1                	li	a7,12
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5a4:	48b5                	li	a7,13
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5ac:	48b9                	li	a7,14
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5b4:	48d9                	li	a7,22
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5bc:	1101                	addi	sp,sp,-32
 5be:	ec06                	sd	ra,24(sp)
 5c0:	e822                	sd	s0,16(sp)
 5c2:	1000                	addi	s0,sp,32
 5c4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5c8:	4605                	li	a2,1
 5ca:	fef40593          	addi	a1,s0,-17
 5ce:	00000097          	auipc	ra,0x0
 5d2:	f66080e7          	jalr	-154(ra) # 534 <write>
}
 5d6:	60e2                	ld	ra,24(sp)
 5d8:	6442                	ld	s0,16(sp)
 5da:	6105                	addi	sp,sp,32
 5dc:	8082                	ret

00000000000005de <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5de:	7139                	addi	sp,sp,-64
 5e0:	fc06                	sd	ra,56(sp)
 5e2:	f822                	sd	s0,48(sp)
 5e4:	f426                	sd	s1,40(sp)
 5e6:	f04a                	sd	s2,32(sp)
 5e8:	ec4e                	sd	s3,24(sp)
 5ea:	0080                	addi	s0,sp,64
 5ec:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ee:	c299                	beqz	a3,5f4 <printint+0x16>
 5f0:	0805c863          	bltz	a1,680 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5f4:	2581                	sext.w	a1,a1
  neg = 0;
 5f6:	4881                	li	a7,0
 5f8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 5fc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 5fe:	2601                	sext.w	a2,a2
 600:	00000517          	auipc	a0,0x0
 604:	45850513          	addi	a0,a0,1112 # a58 <digits>
 608:	883a                	mv	a6,a4
 60a:	2705                	addiw	a4,a4,1
 60c:	02c5f7bb          	remuw	a5,a1,a2
 610:	1782                	slli	a5,a5,0x20
 612:	9381                	srli	a5,a5,0x20
 614:	97aa                	add	a5,a5,a0
 616:	0007c783          	lbu	a5,0(a5)
 61a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 61e:	0005879b          	sext.w	a5,a1
 622:	02c5d5bb          	divuw	a1,a1,a2
 626:	0685                	addi	a3,a3,1
 628:	fec7f0e3          	bgeu	a5,a2,608 <printint+0x2a>
  if(neg)
 62c:	00088b63          	beqz	a7,642 <printint+0x64>
    buf[i++] = '-';
 630:	fd040793          	addi	a5,s0,-48
 634:	973e                	add	a4,a4,a5
 636:	02d00793          	li	a5,45
 63a:	fef70823          	sb	a5,-16(a4)
 63e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 642:	02e05863          	blez	a4,672 <printint+0x94>
 646:	fc040793          	addi	a5,s0,-64
 64a:	00e78933          	add	s2,a5,a4
 64e:	fff78993          	addi	s3,a5,-1
 652:	99ba                	add	s3,s3,a4
 654:	377d                	addiw	a4,a4,-1
 656:	1702                	slli	a4,a4,0x20
 658:	9301                	srli	a4,a4,0x20
 65a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 65e:	fff94583          	lbu	a1,-1(s2)
 662:	8526                	mv	a0,s1
 664:	00000097          	auipc	ra,0x0
 668:	f58080e7          	jalr	-168(ra) # 5bc <putc>
  while(--i >= 0)
 66c:	197d                	addi	s2,s2,-1
 66e:	ff3918e3          	bne	s2,s3,65e <printint+0x80>
}
 672:	70e2                	ld	ra,56(sp)
 674:	7442                	ld	s0,48(sp)
 676:	74a2                	ld	s1,40(sp)
 678:	7902                	ld	s2,32(sp)
 67a:	69e2                	ld	s3,24(sp)
 67c:	6121                	addi	sp,sp,64
 67e:	8082                	ret
    x = -xx;
 680:	40b005bb          	negw	a1,a1
    neg = 1;
 684:	4885                	li	a7,1
    x = -xx;
 686:	bf8d                	j	5f8 <printint+0x1a>

0000000000000688 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 688:	7119                	addi	sp,sp,-128
 68a:	fc86                	sd	ra,120(sp)
 68c:	f8a2                	sd	s0,112(sp)
 68e:	f4a6                	sd	s1,104(sp)
 690:	f0ca                	sd	s2,96(sp)
 692:	ecce                	sd	s3,88(sp)
 694:	e8d2                	sd	s4,80(sp)
 696:	e4d6                	sd	s5,72(sp)
 698:	e0da                	sd	s6,64(sp)
 69a:	fc5e                	sd	s7,56(sp)
 69c:	f862                	sd	s8,48(sp)
 69e:	f466                	sd	s9,40(sp)
 6a0:	f06a                	sd	s10,32(sp)
 6a2:	ec6e                	sd	s11,24(sp)
 6a4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6a6:	0005c903          	lbu	s2,0(a1)
 6aa:	18090f63          	beqz	s2,848 <vprintf+0x1c0>
 6ae:	8aaa                	mv	s5,a0
 6b0:	8b32                	mv	s6,a2
 6b2:	00158493          	addi	s1,a1,1
  state = 0;
 6b6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6b8:	02500a13          	li	s4,37
      if(c == 'd'){
 6bc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6c0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6c4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6c8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6cc:	00000b97          	auipc	s7,0x0
 6d0:	38cb8b93          	addi	s7,s7,908 # a58 <digits>
 6d4:	a839                	j	6f2 <vprintf+0x6a>
        putc(fd, c);
 6d6:	85ca                	mv	a1,s2
 6d8:	8556                	mv	a0,s5
 6da:	00000097          	auipc	ra,0x0
 6de:	ee2080e7          	jalr	-286(ra) # 5bc <putc>
 6e2:	a019                	j	6e8 <vprintf+0x60>
    } else if(state == '%'){
 6e4:	01498f63          	beq	s3,s4,702 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 6e8:	0485                	addi	s1,s1,1
 6ea:	fff4c903          	lbu	s2,-1(s1)
 6ee:	14090d63          	beqz	s2,848 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 6f2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 6f6:	fe0997e3          	bnez	s3,6e4 <vprintf+0x5c>
      if(c == '%'){
 6fa:	fd479ee3          	bne	a5,s4,6d6 <vprintf+0x4e>
        state = '%';
 6fe:	89be                	mv	s3,a5
 700:	b7e5                	j	6e8 <vprintf+0x60>
      if(c == 'd'){
 702:	05878063          	beq	a5,s8,742 <vprintf+0xba>
      } else if(c == 'l') {
 706:	05978c63          	beq	a5,s9,75e <vprintf+0xd6>
      } else if(c == 'x') {
 70a:	07a78863          	beq	a5,s10,77a <vprintf+0xf2>
      } else if(c == 'p') {
 70e:	09b78463          	beq	a5,s11,796 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 712:	07300713          	li	a4,115
 716:	0ce78663          	beq	a5,a4,7e2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71a:	06300713          	li	a4,99
 71e:	0ee78e63          	beq	a5,a4,81a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 722:	11478863          	beq	a5,s4,832 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 726:	85d2                	mv	a1,s4
 728:	8556                	mv	a0,s5
 72a:	00000097          	auipc	ra,0x0
 72e:	e92080e7          	jalr	-366(ra) # 5bc <putc>
        putc(fd, c);
 732:	85ca                	mv	a1,s2
 734:	8556                	mv	a0,s5
 736:	00000097          	auipc	ra,0x0
 73a:	e86080e7          	jalr	-378(ra) # 5bc <putc>
      }
      state = 0;
 73e:	4981                	li	s3,0
 740:	b765                	j	6e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 742:	008b0913          	addi	s2,s6,8
 746:	4685                	li	a3,1
 748:	4629                	li	a2,10
 74a:	000b2583          	lw	a1,0(s6)
 74e:	8556                	mv	a0,s5
 750:	00000097          	auipc	ra,0x0
 754:	e8e080e7          	jalr	-370(ra) # 5de <printint>
 758:	8b4a                	mv	s6,s2
      state = 0;
 75a:	4981                	li	s3,0
 75c:	b771                	j	6e8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 75e:	008b0913          	addi	s2,s6,8
 762:	4681                	li	a3,0
 764:	4629                	li	a2,10
 766:	000b2583          	lw	a1,0(s6)
 76a:	8556                	mv	a0,s5
 76c:	00000097          	auipc	ra,0x0
 770:	e72080e7          	jalr	-398(ra) # 5de <printint>
 774:	8b4a                	mv	s6,s2
      state = 0;
 776:	4981                	li	s3,0
 778:	bf85                	j	6e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 77a:	008b0913          	addi	s2,s6,8
 77e:	4681                	li	a3,0
 780:	4641                	li	a2,16
 782:	000b2583          	lw	a1,0(s6)
 786:	8556                	mv	a0,s5
 788:	00000097          	auipc	ra,0x0
 78c:	e56080e7          	jalr	-426(ra) # 5de <printint>
 790:	8b4a                	mv	s6,s2
      state = 0;
 792:	4981                	li	s3,0
 794:	bf91                	j	6e8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 796:	008b0793          	addi	a5,s6,8
 79a:	f8f43423          	sd	a5,-120(s0)
 79e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7a2:	03000593          	li	a1,48
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e14080e7          	jalr	-492(ra) # 5bc <putc>
  putc(fd, 'x');
 7b0:	85ea                	mv	a1,s10
 7b2:	8556                	mv	a0,s5
 7b4:	00000097          	auipc	ra,0x0
 7b8:	e08080e7          	jalr	-504(ra) # 5bc <putc>
 7bc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7be:	03c9d793          	srli	a5,s3,0x3c
 7c2:	97de                	add	a5,a5,s7
 7c4:	0007c583          	lbu	a1,0(a5)
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	df2080e7          	jalr	-526(ra) # 5bc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7d2:	0992                	slli	s3,s3,0x4
 7d4:	397d                	addiw	s2,s2,-1
 7d6:	fe0914e3          	bnez	s2,7be <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7da:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7de:	4981                	li	s3,0
 7e0:	b721                	j	6e8 <vprintf+0x60>
        s = va_arg(ap, char*);
 7e2:	008b0993          	addi	s3,s6,8
 7e6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 7ea:	02090163          	beqz	s2,80c <vprintf+0x184>
        while(*s != 0){
 7ee:	00094583          	lbu	a1,0(s2)
 7f2:	c9a1                	beqz	a1,842 <vprintf+0x1ba>
          putc(fd, *s);
 7f4:	8556                	mv	a0,s5
 7f6:	00000097          	auipc	ra,0x0
 7fa:	dc6080e7          	jalr	-570(ra) # 5bc <putc>
          s++;
 7fe:	0905                	addi	s2,s2,1
        while(*s != 0){
 800:	00094583          	lbu	a1,0(s2)
 804:	f9e5                	bnez	a1,7f4 <vprintf+0x16c>
        s = va_arg(ap, char*);
 806:	8b4e                	mv	s6,s3
      state = 0;
 808:	4981                	li	s3,0
 80a:	bdf9                	j	6e8 <vprintf+0x60>
          s = "(null)";
 80c:	00000917          	auipc	s2,0x0
 810:	24490913          	addi	s2,s2,580 # a50 <malloc+0xfe>
        while(*s != 0){
 814:	02800593          	li	a1,40
 818:	bff1                	j	7f4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 81a:	008b0913          	addi	s2,s6,8
 81e:	000b4583          	lbu	a1,0(s6)
 822:	8556                	mv	a0,s5
 824:	00000097          	auipc	ra,0x0
 828:	d98080e7          	jalr	-616(ra) # 5bc <putc>
 82c:	8b4a                	mv	s6,s2
      state = 0;
 82e:	4981                	li	s3,0
 830:	bd65                	j	6e8 <vprintf+0x60>
        putc(fd, c);
 832:	85d2                	mv	a1,s4
 834:	8556                	mv	a0,s5
 836:	00000097          	auipc	ra,0x0
 83a:	d86080e7          	jalr	-634(ra) # 5bc <putc>
      state = 0;
 83e:	4981                	li	s3,0
 840:	b565                	j	6e8 <vprintf+0x60>
        s = va_arg(ap, char*);
 842:	8b4e                	mv	s6,s3
      state = 0;
 844:	4981                	li	s3,0
 846:	b54d                	j	6e8 <vprintf+0x60>
    }
  }
}
 848:	70e6                	ld	ra,120(sp)
 84a:	7446                	ld	s0,112(sp)
 84c:	74a6                	ld	s1,104(sp)
 84e:	7906                	ld	s2,96(sp)
 850:	69e6                	ld	s3,88(sp)
 852:	6a46                	ld	s4,80(sp)
 854:	6aa6                	ld	s5,72(sp)
 856:	6b06                	ld	s6,64(sp)
 858:	7be2                	ld	s7,56(sp)
 85a:	7c42                	ld	s8,48(sp)
 85c:	7ca2                	ld	s9,40(sp)
 85e:	7d02                	ld	s10,32(sp)
 860:	6de2                	ld	s11,24(sp)
 862:	6109                	addi	sp,sp,128
 864:	8082                	ret

0000000000000866 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 866:	715d                	addi	sp,sp,-80
 868:	ec06                	sd	ra,24(sp)
 86a:	e822                	sd	s0,16(sp)
 86c:	1000                	addi	s0,sp,32
 86e:	e010                	sd	a2,0(s0)
 870:	e414                	sd	a3,8(s0)
 872:	e818                	sd	a4,16(s0)
 874:	ec1c                	sd	a5,24(s0)
 876:	03043023          	sd	a6,32(s0)
 87a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 87e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 882:	8622                	mv	a2,s0
 884:	00000097          	auipc	ra,0x0
 888:	e04080e7          	jalr	-508(ra) # 688 <vprintf>
}
 88c:	60e2                	ld	ra,24(sp)
 88e:	6442                	ld	s0,16(sp)
 890:	6161                	addi	sp,sp,80
 892:	8082                	ret

0000000000000894 <printf>:

void
printf(const char *fmt, ...)
{
 894:	711d                	addi	sp,sp,-96
 896:	ec06                	sd	ra,24(sp)
 898:	e822                	sd	s0,16(sp)
 89a:	1000                	addi	s0,sp,32
 89c:	e40c                	sd	a1,8(s0)
 89e:	e810                	sd	a2,16(s0)
 8a0:	ec14                	sd	a3,24(s0)
 8a2:	f018                	sd	a4,32(s0)
 8a4:	f41c                	sd	a5,40(s0)
 8a6:	03043823          	sd	a6,48(s0)
 8aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ae:	00840613          	addi	a2,s0,8
 8b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8b6:	85aa                	mv	a1,a0
 8b8:	4505                	li	a0,1
 8ba:	00000097          	auipc	ra,0x0
 8be:	dce080e7          	jalr	-562(ra) # 688 <vprintf>
}
 8c2:	60e2                	ld	ra,24(sp)
 8c4:	6442                	ld	s0,16(sp)
 8c6:	6125                	addi	sp,sp,96
 8c8:	8082                	ret

00000000000008ca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ca:	1141                	addi	sp,sp,-16
 8cc:	e422                	sd	s0,8(sp)
 8ce:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d4:	00000797          	auipc	a5,0x0
 8d8:	19c7b783          	ld	a5,412(a5) # a70 <freep>
 8dc:	a805                	j	90c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8de:	4618                	lw	a4,8(a2)
 8e0:	9db9                	addw	a1,a1,a4
 8e2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e6:	6398                	ld	a4,0(a5)
 8e8:	6318                	ld	a4,0(a4)
 8ea:	fee53823          	sd	a4,-16(a0)
 8ee:	a091                	j	932 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f0:	ff852703          	lw	a4,-8(a0)
 8f4:	9e39                	addw	a2,a2,a4
 8f6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 8f8:	ff053703          	ld	a4,-16(a0)
 8fc:	e398                	sd	a4,0(a5)
 8fe:	a099                	j	944 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 900:	6398                	ld	a4,0(a5)
 902:	00e7e463          	bltu	a5,a4,90a <free+0x40>
 906:	00e6ea63          	bltu	a3,a4,91a <free+0x50>
{
 90a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90c:	fed7fae3          	bgeu	a5,a3,900 <free+0x36>
 910:	6398                	ld	a4,0(a5)
 912:	00e6e463          	bltu	a3,a4,91a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 916:	fee7eae3          	bltu	a5,a4,90a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 91a:	ff852583          	lw	a1,-8(a0)
 91e:	6390                	ld	a2,0(a5)
 920:	02059813          	slli	a6,a1,0x20
 924:	01c85713          	srli	a4,a6,0x1c
 928:	9736                	add	a4,a4,a3
 92a:	fae60ae3          	beq	a2,a4,8de <free+0x14>
    bp->s.ptr = p->s.ptr;
 92e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 932:	4790                	lw	a2,8(a5)
 934:	02061593          	slli	a1,a2,0x20
 938:	01c5d713          	srli	a4,a1,0x1c
 93c:	973e                	add	a4,a4,a5
 93e:	fae689e3          	beq	a3,a4,8f0 <free+0x26>
  } else
    p->s.ptr = bp;
 942:	e394                	sd	a3,0(a5)
  freep = p;
 944:	00000717          	auipc	a4,0x0
 948:	12f73623          	sd	a5,300(a4) # a70 <freep>
}
 94c:	6422                	ld	s0,8(sp)
 94e:	0141                	addi	sp,sp,16
 950:	8082                	ret

0000000000000952 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 952:	7139                	addi	sp,sp,-64
 954:	fc06                	sd	ra,56(sp)
 956:	f822                	sd	s0,48(sp)
 958:	f426                	sd	s1,40(sp)
 95a:	f04a                	sd	s2,32(sp)
 95c:	ec4e                	sd	s3,24(sp)
 95e:	e852                	sd	s4,16(sp)
 960:	e456                	sd	s5,8(sp)
 962:	e05a                	sd	s6,0(sp)
 964:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 966:	02051493          	slli	s1,a0,0x20
 96a:	9081                	srli	s1,s1,0x20
 96c:	04bd                	addi	s1,s1,15
 96e:	8091                	srli	s1,s1,0x4
 970:	0014899b          	addiw	s3,s1,1
 974:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 976:	00000517          	auipc	a0,0x0
 97a:	0fa53503          	ld	a0,250(a0) # a70 <freep>
 97e:	c515                	beqz	a0,9aa <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 980:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 982:	4798                	lw	a4,8(a5)
 984:	02977f63          	bgeu	a4,s1,9c2 <malloc+0x70>
 988:	8a4e                	mv	s4,s3
 98a:	0009871b          	sext.w	a4,s3
 98e:	6685                	lui	a3,0x1
 990:	00d77363          	bgeu	a4,a3,996 <malloc+0x44>
 994:	6a05                	lui	s4,0x1
 996:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 99a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 99e:	00000917          	auipc	s2,0x0
 9a2:	0d290913          	addi	s2,s2,210 # a70 <freep>
  if(p == (char*)-1)
 9a6:	5afd                	li	s5,-1
 9a8:	a895                	j	a1c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9aa:	00000797          	auipc	a5,0x0
 9ae:	1be78793          	addi	a5,a5,446 # b68 <base>
 9b2:	00000717          	auipc	a4,0x0
 9b6:	0af73f23          	sd	a5,190(a4) # a70 <freep>
 9ba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9bc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9c0:	b7e1                	j	988 <malloc+0x36>
      if(p->s.size == nunits)
 9c2:	02e48c63          	beq	s1,a4,9fa <malloc+0xa8>
        p->s.size -= nunits;
 9c6:	4137073b          	subw	a4,a4,s3
 9ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9cc:	02071693          	slli	a3,a4,0x20
 9d0:	01c6d713          	srli	a4,a3,0x1c
 9d4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9d6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9da:	00000717          	auipc	a4,0x0
 9de:	08a73b23          	sd	a0,150(a4) # a70 <freep>
      return (void*)(p + 1);
 9e2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 9e6:	70e2                	ld	ra,56(sp)
 9e8:	7442                	ld	s0,48(sp)
 9ea:	74a2                	ld	s1,40(sp)
 9ec:	7902                	ld	s2,32(sp)
 9ee:	69e2                	ld	s3,24(sp)
 9f0:	6a42                	ld	s4,16(sp)
 9f2:	6aa2                	ld	s5,8(sp)
 9f4:	6b02                	ld	s6,0(sp)
 9f6:	6121                	addi	sp,sp,64
 9f8:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 9fa:	6398                	ld	a4,0(a5)
 9fc:	e118                	sd	a4,0(a0)
 9fe:	bff1                	j	9da <malloc+0x88>
  hp->s.size = nu;
 a00:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a04:	0541                	addi	a0,a0,16
 a06:	00000097          	auipc	ra,0x0
 a0a:	ec4080e7          	jalr	-316(ra) # 8ca <free>
  return freep;
 a0e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a12:	d971                	beqz	a0,9e6 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a14:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a16:	4798                	lw	a4,8(a5)
 a18:	fa9775e3          	bgeu	a4,s1,9c2 <malloc+0x70>
    if(p == freep)
 a1c:	00093703          	ld	a4,0(s2)
 a20:	853e                	mv	a0,a5
 a22:	fef719e3          	bne	a4,a5,a14 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a26:	8552                	mv	a0,s4
 a28:	00000097          	auipc	ra,0x0
 a2c:	b74080e7          	jalr	-1164(ra) # 59c <sbrk>
  if(p == (char*)-1)
 a30:	fd5518e3          	bne	a0,s5,a00 <malloc+0xae>
        return 0;
 a34:	4501                	li	a0,0
 a36:	bf45                	j	9e6 <malloc+0x94>
