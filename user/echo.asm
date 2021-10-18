
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
  2e:	a2ea0a13          	addi	s4,s4,-1490 # a58 <malloc+0xe6>
    write(1, argv[i], strlen(argv[i]));
  32:	0004b903          	ld	s2,0(s1)
  36:	854a                	mv	a0,s2
  38:	00000097          	auipc	ra,0x0
  3c:	2d6080e7          	jalr	726(ra) # 30e <strlen>
  40:	0005061b          	sext.w	a2,a0
  44:	85ca                	mv	a1,s2
  46:	4505                	li	a0,1
  48:	00000097          	auipc	ra,0x0
  4c:	50c080e7          	jalr	1292(ra) # 554 <write>
    if(i + 1 < argc){
  50:	04a1                	addi	s1,s1,8
  52:	01348a63          	beq	s1,s3,66 <main+0x66>
      write(1, " ", 1);
  56:	4605                	li	a2,1
  58:	85d2                	mv	a1,s4
  5a:	4505                	li	a0,1
  5c:	00000097          	auipc	ra,0x0
  60:	4f8080e7          	jalr	1272(ra) # 554 <write>
  for(i = 1; i < argc; i++){
  64:	b7f9                	j	32 <main+0x32>
    } else {
      write(1, "\n", 1);
  66:	4605                	li	a2,1
  68:	00001597          	auipc	a1,0x1
  6c:	9f858593          	addi	a1,a1,-1544 # a60 <malloc+0xee>
  70:	4505                	li	a0,1
  72:	00000097          	auipc	ra,0x0
  76:	4e2080e7          	jalr	1250(ra) # 554 <write>
    }
  }
  exit(0);
  7a:	4501                	li	a0,0
  7c:	00000097          	auipc	ra,0x0
  80:	4b8080e7          	jalr	1208(ra) # 534 <exit>

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

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
  b0:	7139                	addi	sp,sp,-64
  b2:	fc06                	sd	ra,56(sp)
  b4:	f822                	sd	s0,48(sp)
  b6:	f426                	sd	s1,40(sp)
  b8:	f04a                	sd	s2,32(sp)
  ba:	ec4e                	sd	s3,24(sp)
  bc:	e852                	sd	s4,16(sp)
  be:	e456                	sd	s5,8(sp)
  c0:	e05a                	sd	s6,0(sp)
  c2:	0080                	addi	s0,sp,64
  c4:	8a2a                	mv	s4,a0
  c6:	89ae                	mv	s3,a1
  c8:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
  ca:	4785                	li	a5,1
  cc:	00001497          	auipc	s1,0x1
  d0:	9d448493          	addi	s1,s1,-1580 # aa0 <rings+0x8>
  d4:	00001917          	auipc	s2,0x1
  d8:	abc90913          	addi	s2,s2,-1348 # b90 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
  dc:	00001b17          	auipc	s6,0x1
  e0:	9acb0b13          	addi	s6,s6,-1620 # a88 <vm_addr>
  if(open_close == 1){
  e4:	04f59063          	bne	a1,a5,124 <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
  e8:	00001497          	auipc	s1,0x1
  ec:	9c04a483          	lw	s1,-1600(s1) # aa8 <rings+0x10>
  f0:	c099                	beqz	s1,f6 <create_or_close_the_buffer_user+0x46>
  f2:	4481                	li	s1,0
  f4:	a899                	j	14a <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
  f6:	865a                	mv	a2,s6
  f8:	4585                	li	a1,1
  fa:	00000097          	auipc	ra,0x0
  fe:	4da080e7          	jalr	1242(ra) # 5d4 <ringbuf>
        rings[i].book->write_done = 0;
 102:	00001797          	auipc	a5,0x1
 106:	99678793          	addi	a5,a5,-1642 # a98 <rings>
 10a:	6798                	ld	a4,8(a5)
 10c:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 110:	6798                	ld	a4,8(a5)
 112:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 116:	4b98                	lw	a4,16(a5)
 118:	2705                	addiw	a4,a4,1
 11a:	cb98                	sw	a4,16(a5)
        break;
 11c:	a03d                	j	14a <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 11e:	04e1                	addi	s1,s1,24
 120:	03248463          	beq	s1,s2,148 <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 124:	449c                	lw	a5,8(s1)
 126:	dfe5                	beqz	a5,11e <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 128:	865a                	mv	a2,s6
 12a:	85ce                	mv	a1,s3
 12c:	8552                	mv	a0,s4
 12e:	00000097          	auipc	ra,0x0
 132:	4a6080e7          	jalr	1190(ra) # 5d4 <ringbuf>
        rings[i].book->write_done = 0;
 136:	609c                	ld	a5,0(s1)
 138:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 13c:	609c                	ld	a5,0(s1)
 13e:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 142:	0004a423          	sw	zero,8(s1)
 146:	bfe1                	j	11e <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 148:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 14a:	00001797          	auipc	a5,0x1
 14e:	93e7b783          	ld	a5,-1730(a5) # a88 <vm_addr>
 152:	00fab023          	sd	a5,0(s5)
  return i;
}
 156:	8526                	mv	a0,s1
 158:	70e2                	ld	ra,56(sp)
 15a:	7442                	ld	s0,48(sp)
 15c:	74a2                	ld	s1,40(sp)
 15e:	7902                	ld	s2,32(sp)
 160:	69e2                	ld	s3,24(sp)
 162:	6a42                	ld	s4,16(sp)
 164:	6aa2                	ld	s5,8(sp)
 166:	6b02                	ld	s6,0(sp)
 168:	6121                	addi	sp,sp,64
 16a:	8082                	ret

000000000000016c <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 16c:	1101                	addi	sp,sp,-32
 16e:	ec06                	sd	ra,24(sp)
 170:	e822                	sd	s0,16(sp)
 172:	e426                	sd	s1,8(sp)
 174:	1000                	addi	s0,sp,32
 176:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 178:	00001797          	auipc	a5,0x1
 17c:	9107b783          	ld	a5,-1776(a5) # a88 <vm_addr>
 180:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 182:	421c                	lw	a5,0(a2)
 184:	e79d                	bnez	a5,1b2 <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 186:	00001697          	auipc	a3,0x1
 18a:	91268693          	addi	a3,a3,-1774 # a98 <rings>
 18e:	669c                	ld	a5,8(a3)
 190:	6398                	ld	a4,0(a5)
 192:	67c1                	lui	a5,0x10
 194:	9fb9                	addw	a5,a5,a4
 196:	00151713          	slli	a4,a0,0x1
 19a:	953a                	add	a0,a0,a4
 19c:	050e                	slli	a0,a0,0x3
 19e:	9536                	add	a0,a0,a3
 1a0:	6518                	ld	a4,8(a0)
 1a2:	6718                	ld	a4,8(a4)
 1a4:	9f99                	subw	a5,a5,a4
 1a6:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 1a8:	60e2                	ld	ra,24(sp)
 1aa:	6442                	ld	s0,16(sp)
 1ac:	64a2                	ld	s1,8(sp)
 1ae:	6105                	addi	sp,sp,32
 1b0:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 1b2:	00151793          	slli	a5,a0,0x1
 1b6:	953e                	add	a0,a0,a5
 1b8:	050e                	slli	a0,a0,0x3
 1ba:	00001797          	auipc	a5,0x1
 1be:	8de78793          	addi	a5,a5,-1826 # a98 <rings>
 1c2:	953e                	add	a0,a0,a5
 1c4:	6508                	ld	a0,8(a0)
 1c6:	0521                	addi	a0,a0,8
 1c8:	00000097          	auipc	ra,0x0
 1cc:	ed0080e7          	jalr	-304(ra) # 98 <load>
 1d0:	c088                	sw	a0,0(s1)
}
 1d2:	bfd9                	j	1a8 <ringbuf_start_write+0x3c>

00000000000001d4 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 1d4:	1141                	addi	sp,sp,-16
 1d6:	e406                	sd	ra,8(sp)
 1d8:	e022                	sd	s0,0(sp)
 1da:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 1dc:	00151793          	slli	a5,a0,0x1
 1e0:	97aa                	add	a5,a5,a0
 1e2:	078e                	slli	a5,a5,0x3
 1e4:	00001517          	auipc	a0,0x1
 1e8:	8b450513          	addi	a0,a0,-1868 # a98 <rings>
 1ec:	97aa                	add	a5,a5,a0
 1ee:	6788                	ld	a0,8(a5)
 1f0:	0035959b          	slliw	a1,a1,0x3
 1f4:	0521                	addi	a0,a0,8
 1f6:	00000097          	auipc	ra,0x0
 1fa:	e8e080e7          	jalr	-370(ra) # 84 <store>
}
 1fe:	60a2                	ld	ra,8(sp)
 200:	6402                	ld	s0,0(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret

0000000000000206 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 206:	1101                	addi	sp,sp,-32
 208:	ec06                	sd	ra,24(sp)
 20a:	e822                	sd	s0,16(sp)
 20c:	e426                	sd	s1,8(sp)
 20e:	1000                	addi	s0,sp,32
 210:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 212:	00151793          	slli	a5,a0,0x1
 216:	97aa                	add	a5,a5,a0
 218:	078e                	slli	a5,a5,0x3
 21a:	00001517          	auipc	a0,0x1
 21e:	87e50513          	addi	a0,a0,-1922 # a98 <rings>
 222:	97aa                	add	a5,a5,a0
 224:	6788                	ld	a0,8(a5)
 226:	0521                	addi	a0,a0,8
 228:	00000097          	auipc	ra,0x0
 22c:	e70080e7          	jalr	-400(ra) # 98 <load>
 230:	c088                	sw	a0,0(s1)
}
 232:	60e2                	ld	ra,24(sp)
 234:	6442                	ld	s0,16(sp)
 236:	64a2                	ld	s1,8(sp)
 238:	6105                	addi	sp,sp,32
 23a:	8082                	ret

000000000000023c <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 23c:	1101                	addi	sp,sp,-32
 23e:	ec06                	sd	ra,24(sp)
 240:	e822                	sd	s0,16(sp)
 242:	e426                	sd	s1,8(sp)
 244:	1000                	addi	s0,sp,32
 246:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 248:	00151793          	slli	a5,a0,0x1
 24c:	97aa                	add	a5,a5,a0
 24e:	078e                	slli	a5,a5,0x3
 250:	00001517          	auipc	a0,0x1
 254:	84850513          	addi	a0,a0,-1976 # a98 <rings>
 258:	97aa                	add	a5,a5,a0
 25a:	6788                	ld	a0,8(a5)
 25c:	611c                	ld	a5,0(a0)
 25e:	ef99                	bnez	a5,27c <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 260:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 262:	41f7579b          	sraiw	a5,a4,0x1f
 266:	01d7d79b          	srliw	a5,a5,0x1d
 26a:	9fb9                	addw	a5,a5,a4
 26c:	4037d79b          	sraiw	a5,a5,0x3
 270:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 272:	60e2                	ld	ra,24(sp)
 274:	6442                	ld	s0,16(sp)
 276:	64a2                	ld	s1,8(sp)
 278:	6105                	addi	sp,sp,32
 27a:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 27c:	00000097          	auipc	ra,0x0
 280:	e1c080e7          	jalr	-484(ra) # 98 <load>
    *bytes /= 8;
 284:	41f5579b          	sraiw	a5,a0,0x1f
 288:	01d7d79b          	srliw	a5,a5,0x1d
 28c:	9d3d                	addw	a0,a0,a5
 28e:	4035551b          	sraiw	a0,a0,0x3
 292:	c088                	sw	a0,0(s1)
}
 294:	bff9                	j	272 <ringbuf_start_read+0x36>

0000000000000296 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 296:	1141                	addi	sp,sp,-16
 298:	e406                	sd	ra,8(sp)
 29a:	e022                	sd	s0,0(sp)
 29c:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 29e:	00151793          	slli	a5,a0,0x1
 2a2:	97aa                	add	a5,a5,a0
 2a4:	078e                	slli	a5,a5,0x3
 2a6:	00000517          	auipc	a0,0x0
 2aa:	7f250513          	addi	a0,a0,2034 # a98 <rings>
 2ae:	97aa                	add	a5,a5,a0
 2b0:	0035959b          	slliw	a1,a1,0x3
 2b4:	6788                	ld	a0,8(a5)
 2b6:	00000097          	auipc	ra,0x0
 2ba:	dce080e7          	jalr	-562(ra) # 84 <store>
}
 2be:	60a2                	ld	ra,8(sp)
 2c0:	6402                	ld	s0,0(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e422                	sd	s0,8(sp)
 2ca:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2cc:	87aa                	mv	a5,a0
 2ce:	0585                	addi	a1,a1,1
 2d0:	0785                	addi	a5,a5,1
 2d2:	fff5c703          	lbu	a4,-1(a1)
 2d6:	fee78fa3          	sb	a4,-1(a5)
 2da:	fb75                	bnez	a4,2ce <strcpy+0x8>
    ;
  return os;
}
 2dc:	6422                	ld	s0,8(sp)
 2de:	0141                	addi	sp,sp,16
 2e0:	8082                	ret

00000000000002e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2e2:	1141                	addi	sp,sp,-16
 2e4:	e422                	sd	s0,8(sp)
 2e6:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 2e8:	00054783          	lbu	a5,0(a0)
 2ec:	cb91                	beqz	a5,300 <strcmp+0x1e>
 2ee:	0005c703          	lbu	a4,0(a1)
 2f2:	00f71763          	bne	a4,a5,300 <strcmp+0x1e>
    p++, q++;
 2f6:	0505                	addi	a0,a0,1
 2f8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 2fa:	00054783          	lbu	a5,0(a0)
 2fe:	fbe5                	bnez	a5,2ee <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 300:	0005c503          	lbu	a0,0(a1)
}
 304:	40a7853b          	subw	a0,a5,a0
 308:	6422                	ld	s0,8(sp)
 30a:	0141                	addi	sp,sp,16
 30c:	8082                	ret

000000000000030e <strlen>:

uint
strlen(const char *s)
{
 30e:	1141                	addi	sp,sp,-16
 310:	e422                	sd	s0,8(sp)
 312:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 314:	00054783          	lbu	a5,0(a0)
 318:	cf91                	beqz	a5,334 <strlen+0x26>
 31a:	0505                	addi	a0,a0,1
 31c:	87aa                	mv	a5,a0
 31e:	4685                	li	a3,1
 320:	9e89                	subw	a3,a3,a0
 322:	00f6853b          	addw	a0,a3,a5
 326:	0785                	addi	a5,a5,1
 328:	fff7c703          	lbu	a4,-1(a5)
 32c:	fb7d                	bnez	a4,322 <strlen+0x14>
    ;
  return n;
}
 32e:	6422                	ld	s0,8(sp)
 330:	0141                	addi	sp,sp,16
 332:	8082                	ret
  for(n = 0; s[n]; n++)
 334:	4501                	li	a0,0
 336:	bfe5                	j	32e <strlen+0x20>

0000000000000338 <memset>:

void*
memset(void *dst, int c, uint n)
{
 338:	1141                	addi	sp,sp,-16
 33a:	e422                	sd	s0,8(sp)
 33c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 33e:	ca19                	beqz	a2,354 <memset+0x1c>
 340:	87aa                	mv	a5,a0
 342:	1602                	slli	a2,a2,0x20
 344:	9201                	srli	a2,a2,0x20
 346:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 34a:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 34e:	0785                	addi	a5,a5,1
 350:	fee79de3          	bne	a5,a4,34a <memset+0x12>
  }
  return dst;
}
 354:	6422                	ld	s0,8(sp)
 356:	0141                	addi	sp,sp,16
 358:	8082                	ret

000000000000035a <strchr>:

char*
strchr(const char *s, char c)
{
 35a:	1141                	addi	sp,sp,-16
 35c:	e422                	sd	s0,8(sp)
 35e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 360:	00054783          	lbu	a5,0(a0)
 364:	cb99                	beqz	a5,37a <strchr+0x20>
    if(*s == c)
 366:	00f58763          	beq	a1,a5,374 <strchr+0x1a>
  for(; *s; s++)
 36a:	0505                	addi	a0,a0,1
 36c:	00054783          	lbu	a5,0(a0)
 370:	fbfd                	bnez	a5,366 <strchr+0xc>
      return (char*)s;
  return 0;
 372:	4501                	li	a0,0
}
 374:	6422                	ld	s0,8(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret
  return 0;
 37a:	4501                	li	a0,0
 37c:	bfe5                	j	374 <strchr+0x1a>

000000000000037e <gets>:

char*
gets(char *buf, int max)
{
 37e:	711d                	addi	sp,sp,-96
 380:	ec86                	sd	ra,88(sp)
 382:	e8a2                	sd	s0,80(sp)
 384:	e4a6                	sd	s1,72(sp)
 386:	e0ca                	sd	s2,64(sp)
 388:	fc4e                	sd	s3,56(sp)
 38a:	f852                	sd	s4,48(sp)
 38c:	f456                	sd	s5,40(sp)
 38e:	f05a                	sd	s6,32(sp)
 390:	ec5e                	sd	s7,24(sp)
 392:	1080                	addi	s0,sp,96
 394:	8baa                	mv	s7,a0
 396:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 398:	892a                	mv	s2,a0
 39a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 39c:	4aa9                	li	s5,10
 39e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 3a0:	89a6                	mv	s3,s1
 3a2:	2485                	addiw	s1,s1,1
 3a4:	0344d863          	bge	s1,s4,3d4 <gets+0x56>
    cc = read(0, &c, 1);
 3a8:	4605                	li	a2,1
 3aa:	faf40593          	addi	a1,s0,-81
 3ae:	4501                	li	a0,0
 3b0:	00000097          	auipc	ra,0x0
 3b4:	19c080e7          	jalr	412(ra) # 54c <read>
    if(cc < 1)
 3b8:	00a05e63          	blez	a0,3d4 <gets+0x56>
    buf[i++] = c;
 3bc:	faf44783          	lbu	a5,-81(s0)
 3c0:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 3c4:	01578763          	beq	a5,s5,3d2 <gets+0x54>
 3c8:	0905                	addi	s2,s2,1
 3ca:	fd679be3          	bne	a5,s6,3a0 <gets+0x22>
  for(i=0; i+1 < max; ){
 3ce:	89a6                	mv	s3,s1
 3d0:	a011                	j	3d4 <gets+0x56>
 3d2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 3d4:	99de                	add	s3,s3,s7
 3d6:	00098023          	sb	zero,0(s3)
  return buf;
}
 3da:	855e                	mv	a0,s7
 3dc:	60e6                	ld	ra,88(sp)
 3de:	6446                	ld	s0,80(sp)
 3e0:	64a6                	ld	s1,72(sp)
 3e2:	6906                	ld	s2,64(sp)
 3e4:	79e2                	ld	s3,56(sp)
 3e6:	7a42                	ld	s4,48(sp)
 3e8:	7aa2                	ld	s5,40(sp)
 3ea:	7b02                	ld	s6,32(sp)
 3ec:	6be2                	ld	s7,24(sp)
 3ee:	6125                	addi	sp,sp,96
 3f0:	8082                	ret

00000000000003f2 <stat>:

int
stat(const char *n, struct stat *st)
{
 3f2:	1101                	addi	sp,sp,-32
 3f4:	ec06                	sd	ra,24(sp)
 3f6:	e822                	sd	s0,16(sp)
 3f8:	e426                	sd	s1,8(sp)
 3fa:	e04a                	sd	s2,0(sp)
 3fc:	1000                	addi	s0,sp,32
 3fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 400:	4581                	li	a1,0
 402:	00000097          	auipc	ra,0x0
 406:	172080e7          	jalr	370(ra) # 574 <open>
  if(fd < 0)
 40a:	02054563          	bltz	a0,434 <stat+0x42>
 40e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 410:	85ca                	mv	a1,s2
 412:	00000097          	auipc	ra,0x0
 416:	17a080e7          	jalr	378(ra) # 58c <fstat>
 41a:	892a                	mv	s2,a0
  close(fd);
 41c:	8526                	mv	a0,s1
 41e:	00000097          	auipc	ra,0x0
 422:	13e080e7          	jalr	318(ra) # 55c <close>
  return r;
}
 426:	854a                	mv	a0,s2
 428:	60e2                	ld	ra,24(sp)
 42a:	6442                	ld	s0,16(sp)
 42c:	64a2                	ld	s1,8(sp)
 42e:	6902                	ld	s2,0(sp)
 430:	6105                	addi	sp,sp,32
 432:	8082                	ret
    return -1;
 434:	597d                	li	s2,-1
 436:	bfc5                	j	426 <stat+0x34>

0000000000000438 <atoi>:

int
atoi(const char *s)
{
 438:	1141                	addi	sp,sp,-16
 43a:	e422                	sd	s0,8(sp)
 43c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 43e:	00054603          	lbu	a2,0(a0)
 442:	fd06079b          	addiw	a5,a2,-48
 446:	0ff7f793          	zext.b	a5,a5
 44a:	4725                	li	a4,9
 44c:	02f76963          	bltu	a4,a5,47e <atoi+0x46>
 450:	86aa                	mv	a3,a0
  n = 0;
 452:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 454:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 456:	0685                	addi	a3,a3,1
 458:	0025179b          	slliw	a5,a0,0x2
 45c:	9fa9                	addw	a5,a5,a0
 45e:	0017979b          	slliw	a5,a5,0x1
 462:	9fb1                	addw	a5,a5,a2
 464:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 468:	0006c603          	lbu	a2,0(a3)
 46c:	fd06071b          	addiw	a4,a2,-48
 470:	0ff77713          	zext.b	a4,a4
 474:	fee5f1e3          	bgeu	a1,a4,456 <atoi+0x1e>
  return n;
}
 478:	6422                	ld	s0,8(sp)
 47a:	0141                	addi	sp,sp,16
 47c:	8082                	ret
  n = 0;
 47e:	4501                	li	a0,0
 480:	bfe5                	j	478 <atoi+0x40>

0000000000000482 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 482:	1141                	addi	sp,sp,-16
 484:	e422                	sd	s0,8(sp)
 486:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 488:	02b57463          	bgeu	a0,a1,4b0 <memmove+0x2e>
    while(n-- > 0)
 48c:	00c05f63          	blez	a2,4aa <memmove+0x28>
 490:	1602                	slli	a2,a2,0x20
 492:	9201                	srli	a2,a2,0x20
 494:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 498:	872a                	mv	a4,a0
      *dst++ = *src++;
 49a:	0585                	addi	a1,a1,1
 49c:	0705                	addi	a4,a4,1
 49e:	fff5c683          	lbu	a3,-1(a1)
 4a2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 4a6:	fee79ae3          	bne	a5,a4,49a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret
    dst += n;
 4b0:	00c50733          	add	a4,a0,a2
    src += n;
 4b4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 4b6:	fec05ae3          	blez	a2,4aa <memmove+0x28>
 4ba:	fff6079b          	addiw	a5,a2,-1
 4be:	1782                	slli	a5,a5,0x20
 4c0:	9381                	srli	a5,a5,0x20
 4c2:	fff7c793          	not	a5,a5
 4c6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 4c8:	15fd                	addi	a1,a1,-1
 4ca:	177d                	addi	a4,a4,-1
 4cc:	0005c683          	lbu	a3,0(a1)
 4d0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 4d4:	fee79ae3          	bne	a5,a4,4c8 <memmove+0x46>
 4d8:	bfc9                	j	4aa <memmove+0x28>

00000000000004da <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 4da:	1141                	addi	sp,sp,-16
 4dc:	e422                	sd	s0,8(sp)
 4de:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 4e0:	ca05                	beqz	a2,510 <memcmp+0x36>
 4e2:	fff6069b          	addiw	a3,a2,-1
 4e6:	1682                	slli	a3,a3,0x20
 4e8:	9281                	srli	a3,a3,0x20
 4ea:	0685                	addi	a3,a3,1
 4ec:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 4ee:	00054783          	lbu	a5,0(a0)
 4f2:	0005c703          	lbu	a4,0(a1)
 4f6:	00e79863          	bne	a5,a4,506 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 4fa:	0505                	addi	a0,a0,1
    p2++;
 4fc:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 4fe:	fed518e3          	bne	a0,a3,4ee <memcmp+0x14>
  }
  return 0;
 502:	4501                	li	a0,0
 504:	a019                	j	50a <memcmp+0x30>
      return *p1 - *p2;
 506:	40e7853b          	subw	a0,a5,a4
}
 50a:	6422                	ld	s0,8(sp)
 50c:	0141                	addi	sp,sp,16
 50e:	8082                	ret
  return 0;
 510:	4501                	li	a0,0
 512:	bfe5                	j	50a <memcmp+0x30>

0000000000000514 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 514:	1141                	addi	sp,sp,-16
 516:	e406                	sd	ra,8(sp)
 518:	e022                	sd	s0,0(sp)
 51a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 51c:	00000097          	auipc	ra,0x0
 520:	f66080e7          	jalr	-154(ra) # 482 <memmove>
}
 524:	60a2                	ld	ra,8(sp)
 526:	6402                	ld	s0,0(sp)
 528:	0141                	addi	sp,sp,16
 52a:	8082                	ret

000000000000052c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 52c:	4885                	li	a7,1
 ecall
 52e:	00000073          	ecall
 ret
 532:	8082                	ret

0000000000000534 <exit>:
.global exit
exit:
 li a7, SYS_exit
 534:	4889                	li	a7,2
 ecall
 536:	00000073          	ecall
 ret
 53a:	8082                	ret

000000000000053c <wait>:
.global wait
wait:
 li a7, SYS_wait
 53c:	488d                	li	a7,3
 ecall
 53e:	00000073          	ecall
 ret
 542:	8082                	ret

0000000000000544 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 544:	4891                	li	a7,4
 ecall
 546:	00000073          	ecall
 ret
 54a:	8082                	ret

000000000000054c <read>:
.global read
read:
 li a7, SYS_read
 54c:	4895                	li	a7,5
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <write>:
.global write
write:
 li a7, SYS_write
 554:	48c1                	li	a7,16
 ecall
 556:	00000073          	ecall
 ret
 55a:	8082                	ret

000000000000055c <close>:
.global close
close:
 li a7, SYS_close
 55c:	48d5                	li	a7,21
 ecall
 55e:	00000073          	ecall
 ret
 562:	8082                	ret

0000000000000564 <kill>:
.global kill
kill:
 li a7, SYS_kill
 564:	4899                	li	a7,6
 ecall
 566:	00000073          	ecall
 ret
 56a:	8082                	ret

000000000000056c <exec>:
.global exec
exec:
 li a7, SYS_exec
 56c:	489d                	li	a7,7
 ecall
 56e:	00000073          	ecall
 ret
 572:	8082                	ret

0000000000000574 <open>:
.global open
open:
 li a7, SYS_open
 574:	48bd                	li	a7,15
 ecall
 576:	00000073          	ecall
 ret
 57a:	8082                	ret

000000000000057c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 57c:	48c5                	li	a7,17
 ecall
 57e:	00000073          	ecall
 ret
 582:	8082                	ret

0000000000000584 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 584:	48c9                	li	a7,18
 ecall
 586:	00000073          	ecall
 ret
 58a:	8082                	ret

000000000000058c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 58c:	48a1                	li	a7,8
 ecall
 58e:	00000073          	ecall
 ret
 592:	8082                	ret

0000000000000594 <link>:
.global link
link:
 li a7, SYS_link
 594:	48cd                	li	a7,19
 ecall
 596:	00000073          	ecall
 ret
 59a:	8082                	ret

000000000000059c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 59c:	48d1                	li	a7,20
 ecall
 59e:	00000073          	ecall
 ret
 5a2:	8082                	ret

00000000000005a4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 5a4:	48a5                	li	a7,9
 ecall
 5a6:	00000073          	ecall
 ret
 5aa:	8082                	ret

00000000000005ac <dup>:
.global dup
dup:
 li a7, SYS_dup
 5ac:	48a9                	li	a7,10
 ecall
 5ae:	00000073          	ecall
 ret
 5b2:	8082                	ret

00000000000005b4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 5b4:	48ad                	li	a7,11
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 5bc:	48b1                	li	a7,12
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 5c4:	48b5                	li	a7,13
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 5cc:	48b9                	li	a7,14
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 5d4:	48d9                	li	a7,22
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 5dc:	1101                	addi	sp,sp,-32
 5de:	ec06                	sd	ra,24(sp)
 5e0:	e822                	sd	s0,16(sp)
 5e2:	1000                	addi	s0,sp,32
 5e4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 5e8:	4605                	li	a2,1
 5ea:	fef40593          	addi	a1,s0,-17
 5ee:	00000097          	auipc	ra,0x0
 5f2:	f66080e7          	jalr	-154(ra) # 554 <write>
}
 5f6:	60e2                	ld	ra,24(sp)
 5f8:	6442                	ld	s0,16(sp)
 5fa:	6105                	addi	sp,sp,32
 5fc:	8082                	ret

00000000000005fe <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 5fe:	7139                	addi	sp,sp,-64
 600:	fc06                	sd	ra,56(sp)
 602:	f822                	sd	s0,48(sp)
 604:	f426                	sd	s1,40(sp)
 606:	f04a                	sd	s2,32(sp)
 608:	ec4e                	sd	s3,24(sp)
 60a:	0080                	addi	s0,sp,64
 60c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 60e:	c299                	beqz	a3,614 <printint+0x16>
 610:	0805c863          	bltz	a1,6a0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 614:	2581                	sext.w	a1,a1
  neg = 0;
 616:	4881                	li	a7,0
 618:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 61c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 61e:	2601                	sext.w	a2,a2
 620:	00000517          	auipc	a0,0x0
 624:	45050513          	addi	a0,a0,1104 # a70 <digits>
 628:	883a                	mv	a6,a4
 62a:	2705                	addiw	a4,a4,1
 62c:	02c5f7bb          	remuw	a5,a1,a2
 630:	1782                	slli	a5,a5,0x20
 632:	9381                	srli	a5,a5,0x20
 634:	97aa                	add	a5,a5,a0
 636:	0007c783          	lbu	a5,0(a5)
 63a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 63e:	0005879b          	sext.w	a5,a1
 642:	02c5d5bb          	divuw	a1,a1,a2
 646:	0685                	addi	a3,a3,1
 648:	fec7f0e3          	bgeu	a5,a2,628 <printint+0x2a>
  if(neg)
 64c:	00088b63          	beqz	a7,662 <printint+0x64>
    buf[i++] = '-';
 650:	fd040793          	addi	a5,s0,-48
 654:	973e                	add	a4,a4,a5
 656:	02d00793          	li	a5,45
 65a:	fef70823          	sb	a5,-16(a4)
 65e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 662:	02e05863          	blez	a4,692 <printint+0x94>
 666:	fc040793          	addi	a5,s0,-64
 66a:	00e78933          	add	s2,a5,a4
 66e:	fff78993          	addi	s3,a5,-1
 672:	99ba                	add	s3,s3,a4
 674:	377d                	addiw	a4,a4,-1
 676:	1702                	slli	a4,a4,0x20
 678:	9301                	srli	a4,a4,0x20
 67a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 67e:	fff94583          	lbu	a1,-1(s2)
 682:	8526                	mv	a0,s1
 684:	00000097          	auipc	ra,0x0
 688:	f58080e7          	jalr	-168(ra) # 5dc <putc>
  while(--i >= 0)
 68c:	197d                	addi	s2,s2,-1
 68e:	ff3918e3          	bne	s2,s3,67e <printint+0x80>
}
 692:	70e2                	ld	ra,56(sp)
 694:	7442                	ld	s0,48(sp)
 696:	74a2                	ld	s1,40(sp)
 698:	7902                	ld	s2,32(sp)
 69a:	69e2                	ld	s3,24(sp)
 69c:	6121                	addi	sp,sp,64
 69e:	8082                	ret
    x = -xx;
 6a0:	40b005bb          	negw	a1,a1
    neg = 1;
 6a4:	4885                	li	a7,1
    x = -xx;
 6a6:	bf8d                	j	618 <printint+0x1a>

00000000000006a8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 6a8:	7119                	addi	sp,sp,-128
 6aa:	fc86                	sd	ra,120(sp)
 6ac:	f8a2                	sd	s0,112(sp)
 6ae:	f4a6                	sd	s1,104(sp)
 6b0:	f0ca                	sd	s2,96(sp)
 6b2:	ecce                	sd	s3,88(sp)
 6b4:	e8d2                	sd	s4,80(sp)
 6b6:	e4d6                	sd	s5,72(sp)
 6b8:	e0da                	sd	s6,64(sp)
 6ba:	fc5e                	sd	s7,56(sp)
 6bc:	f862                	sd	s8,48(sp)
 6be:	f466                	sd	s9,40(sp)
 6c0:	f06a                	sd	s10,32(sp)
 6c2:	ec6e                	sd	s11,24(sp)
 6c4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 6c6:	0005c903          	lbu	s2,0(a1)
 6ca:	18090f63          	beqz	s2,868 <vprintf+0x1c0>
 6ce:	8aaa                	mv	s5,a0
 6d0:	8b32                	mv	s6,a2
 6d2:	00158493          	addi	s1,a1,1
  state = 0;
 6d6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6d8:	02500a13          	li	s4,37
      if(c == 'd'){
 6dc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 6e0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 6e4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 6e8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 6ec:	00000b97          	auipc	s7,0x0
 6f0:	384b8b93          	addi	s7,s7,900 # a70 <digits>
 6f4:	a839                	j	712 <vprintf+0x6a>
        putc(fd, c);
 6f6:	85ca                	mv	a1,s2
 6f8:	8556                	mv	a0,s5
 6fa:	00000097          	auipc	ra,0x0
 6fe:	ee2080e7          	jalr	-286(ra) # 5dc <putc>
 702:	a019                	j	708 <vprintf+0x60>
    } else if(state == '%'){
 704:	01498f63          	beq	s3,s4,722 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 708:	0485                	addi	s1,s1,1
 70a:	fff4c903          	lbu	s2,-1(s1)
 70e:	14090d63          	beqz	s2,868 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 712:	0009079b          	sext.w	a5,s2
    if(state == 0){
 716:	fe0997e3          	bnez	s3,704 <vprintf+0x5c>
      if(c == '%'){
 71a:	fd479ee3          	bne	a5,s4,6f6 <vprintf+0x4e>
        state = '%';
 71e:	89be                	mv	s3,a5
 720:	b7e5                	j	708 <vprintf+0x60>
      if(c == 'd'){
 722:	05878063          	beq	a5,s8,762 <vprintf+0xba>
      } else if(c == 'l') {
 726:	05978c63          	beq	a5,s9,77e <vprintf+0xd6>
      } else if(c == 'x') {
 72a:	07a78863          	beq	a5,s10,79a <vprintf+0xf2>
      } else if(c == 'p') {
 72e:	09b78463          	beq	a5,s11,7b6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 732:	07300713          	li	a4,115
 736:	0ce78663          	beq	a5,a4,802 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 73a:	06300713          	li	a4,99
 73e:	0ee78e63          	beq	a5,a4,83a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 742:	11478863          	beq	a5,s4,852 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 746:	85d2                	mv	a1,s4
 748:	8556                	mv	a0,s5
 74a:	00000097          	auipc	ra,0x0
 74e:	e92080e7          	jalr	-366(ra) # 5dc <putc>
        putc(fd, c);
 752:	85ca                	mv	a1,s2
 754:	8556                	mv	a0,s5
 756:	00000097          	auipc	ra,0x0
 75a:	e86080e7          	jalr	-378(ra) # 5dc <putc>
      }
      state = 0;
 75e:	4981                	li	s3,0
 760:	b765                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 762:	008b0913          	addi	s2,s6,8
 766:	4685                	li	a3,1
 768:	4629                	li	a2,10
 76a:	000b2583          	lw	a1,0(s6)
 76e:	8556                	mv	a0,s5
 770:	00000097          	auipc	ra,0x0
 774:	e8e080e7          	jalr	-370(ra) # 5fe <printint>
 778:	8b4a                	mv	s6,s2
      state = 0;
 77a:	4981                	li	s3,0
 77c:	b771                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 77e:	008b0913          	addi	s2,s6,8
 782:	4681                	li	a3,0
 784:	4629                	li	a2,10
 786:	000b2583          	lw	a1,0(s6)
 78a:	8556                	mv	a0,s5
 78c:	00000097          	auipc	ra,0x0
 790:	e72080e7          	jalr	-398(ra) # 5fe <printint>
 794:	8b4a                	mv	s6,s2
      state = 0;
 796:	4981                	li	s3,0
 798:	bf85                	j	708 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 79a:	008b0913          	addi	s2,s6,8
 79e:	4681                	li	a3,0
 7a0:	4641                	li	a2,16
 7a2:	000b2583          	lw	a1,0(s6)
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e56080e7          	jalr	-426(ra) # 5fe <printint>
 7b0:	8b4a                	mv	s6,s2
      state = 0;
 7b2:	4981                	li	s3,0
 7b4:	bf91                	j	708 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 7b6:	008b0793          	addi	a5,s6,8
 7ba:	f8f43423          	sd	a5,-120(s0)
 7be:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 7c2:	03000593          	li	a1,48
 7c6:	8556                	mv	a0,s5
 7c8:	00000097          	auipc	ra,0x0
 7cc:	e14080e7          	jalr	-492(ra) # 5dc <putc>
  putc(fd, 'x');
 7d0:	85ea                	mv	a1,s10
 7d2:	8556                	mv	a0,s5
 7d4:	00000097          	auipc	ra,0x0
 7d8:	e08080e7          	jalr	-504(ra) # 5dc <putc>
 7dc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7de:	03c9d793          	srli	a5,s3,0x3c
 7e2:	97de                	add	a5,a5,s7
 7e4:	0007c583          	lbu	a1,0(a5)
 7e8:	8556                	mv	a0,s5
 7ea:	00000097          	auipc	ra,0x0
 7ee:	df2080e7          	jalr	-526(ra) # 5dc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f2:	0992                	slli	s3,s3,0x4
 7f4:	397d                	addiw	s2,s2,-1
 7f6:	fe0914e3          	bnez	s2,7de <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 7fa:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 7fe:	4981                	li	s3,0
 800:	b721                	j	708 <vprintf+0x60>
        s = va_arg(ap, char*);
 802:	008b0993          	addi	s3,s6,8
 806:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 80a:	02090163          	beqz	s2,82c <vprintf+0x184>
        while(*s != 0){
 80e:	00094583          	lbu	a1,0(s2)
 812:	c9a1                	beqz	a1,862 <vprintf+0x1ba>
          putc(fd, *s);
 814:	8556                	mv	a0,s5
 816:	00000097          	auipc	ra,0x0
 81a:	dc6080e7          	jalr	-570(ra) # 5dc <putc>
          s++;
 81e:	0905                	addi	s2,s2,1
        while(*s != 0){
 820:	00094583          	lbu	a1,0(s2)
 824:	f9e5                	bnez	a1,814 <vprintf+0x16c>
        s = va_arg(ap, char*);
 826:	8b4e                	mv	s6,s3
      state = 0;
 828:	4981                	li	s3,0
 82a:	bdf9                	j	708 <vprintf+0x60>
          s = "(null)";
 82c:	00000917          	auipc	s2,0x0
 830:	23c90913          	addi	s2,s2,572 # a68 <malloc+0xf6>
        while(*s != 0){
 834:	02800593          	li	a1,40
 838:	bff1                	j	814 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 83a:	008b0913          	addi	s2,s6,8
 83e:	000b4583          	lbu	a1,0(s6)
 842:	8556                	mv	a0,s5
 844:	00000097          	auipc	ra,0x0
 848:	d98080e7          	jalr	-616(ra) # 5dc <putc>
 84c:	8b4a                	mv	s6,s2
      state = 0;
 84e:	4981                	li	s3,0
 850:	bd65                	j	708 <vprintf+0x60>
        putc(fd, c);
 852:	85d2                	mv	a1,s4
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	d86080e7          	jalr	-634(ra) # 5dc <putc>
      state = 0;
 85e:	4981                	li	s3,0
 860:	b565                	j	708 <vprintf+0x60>
        s = va_arg(ap, char*);
 862:	8b4e                	mv	s6,s3
      state = 0;
 864:	4981                	li	s3,0
 866:	b54d                	j	708 <vprintf+0x60>
    }
  }
}
 868:	70e6                	ld	ra,120(sp)
 86a:	7446                	ld	s0,112(sp)
 86c:	74a6                	ld	s1,104(sp)
 86e:	7906                	ld	s2,96(sp)
 870:	69e6                	ld	s3,88(sp)
 872:	6a46                	ld	s4,80(sp)
 874:	6aa6                	ld	s5,72(sp)
 876:	6b06                	ld	s6,64(sp)
 878:	7be2                	ld	s7,56(sp)
 87a:	7c42                	ld	s8,48(sp)
 87c:	7ca2                	ld	s9,40(sp)
 87e:	7d02                	ld	s10,32(sp)
 880:	6de2                	ld	s11,24(sp)
 882:	6109                	addi	sp,sp,128
 884:	8082                	ret

0000000000000886 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 886:	715d                	addi	sp,sp,-80
 888:	ec06                	sd	ra,24(sp)
 88a:	e822                	sd	s0,16(sp)
 88c:	1000                	addi	s0,sp,32
 88e:	e010                	sd	a2,0(s0)
 890:	e414                	sd	a3,8(s0)
 892:	e818                	sd	a4,16(s0)
 894:	ec1c                	sd	a5,24(s0)
 896:	03043023          	sd	a6,32(s0)
 89a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a2:	8622                	mv	a2,s0
 8a4:	00000097          	auipc	ra,0x0
 8a8:	e04080e7          	jalr	-508(ra) # 6a8 <vprintf>
}
 8ac:	60e2                	ld	ra,24(sp)
 8ae:	6442                	ld	s0,16(sp)
 8b0:	6161                	addi	sp,sp,80
 8b2:	8082                	ret

00000000000008b4 <printf>:

void
printf(const char *fmt, ...)
{
 8b4:	711d                	addi	sp,sp,-96
 8b6:	ec06                	sd	ra,24(sp)
 8b8:	e822                	sd	s0,16(sp)
 8ba:	1000                	addi	s0,sp,32
 8bc:	e40c                	sd	a1,8(s0)
 8be:	e810                	sd	a2,16(s0)
 8c0:	ec14                	sd	a3,24(s0)
 8c2:	f018                	sd	a4,32(s0)
 8c4:	f41c                	sd	a5,40(s0)
 8c6:	03043823          	sd	a6,48(s0)
 8ca:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ce:	00840613          	addi	a2,s0,8
 8d2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d6:	85aa                	mv	a1,a0
 8d8:	4505                	li	a0,1
 8da:	00000097          	auipc	ra,0x0
 8de:	dce080e7          	jalr	-562(ra) # 6a8 <vprintf>
}
 8e2:	60e2                	ld	ra,24(sp)
 8e4:	6442                	ld	s0,16(sp)
 8e6:	6125                	addi	sp,sp,96
 8e8:	8082                	ret

00000000000008ea <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ea:	1141                	addi	sp,sp,-16
 8ec:	e422                	sd	s0,8(sp)
 8ee:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8f0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8f4:	00000797          	auipc	a5,0x0
 8f8:	19c7b783          	ld	a5,412(a5) # a90 <freep>
 8fc:	a805                	j	92c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8fe:	4618                	lw	a4,8(a2)
 900:	9db9                	addw	a1,a1,a4
 902:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 906:	6398                	ld	a4,0(a5)
 908:	6318                	ld	a4,0(a4)
 90a:	fee53823          	sd	a4,-16(a0)
 90e:	a091                	j	952 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 910:	ff852703          	lw	a4,-8(a0)
 914:	9e39                	addw	a2,a2,a4
 916:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 918:	ff053703          	ld	a4,-16(a0)
 91c:	e398                	sd	a4,0(a5)
 91e:	a099                	j	964 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 920:	6398                	ld	a4,0(a5)
 922:	00e7e463          	bltu	a5,a4,92a <free+0x40>
 926:	00e6ea63          	bltu	a3,a4,93a <free+0x50>
{
 92a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 92c:	fed7fae3          	bgeu	a5,a3,920 <free+0x36>
 930:	6398                	ld	a4,0(a5)
 932:	00e6e463          	bltu	a3,a4,93a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 936:	fee7eae3          	bltu	a5,a4,92a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 93a:	ff852583          	lw	a1,-8(a0)
 93e:	6390                	ld	a2,0(a5)
 940:	02059813          	slli	a6,a1,0x20
 944:	01c85713          	srli	a4,a6,0x1c
 948:	9736                	add	a4,a4,a3
 94a:	fae60ae3          	beq	a2,a4,8fe <free+0x14>
    bp->s.ptr = p->s.ptr;
 94e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 952:	4790                	lw	a2,8(a5)
 954:	02061593          	slli	a1,a2,0x20
 958:	01c5d713          	srli	a4,a1,0x1c
 95c:	973e                	add	a4,a4,a5
 95e:	fae689e3          	beq	a3,a4,910 <free+0x26>
  } else
    p->s.ptr = bp;
 962:	e394                	sd	a3,0(a5)
  freep = p;
 964:	00000717          	auipc	a4,0x0
 968:	12f73623          	sd	a5,300(a4) # a90 <freep>
}
 96c:	6422                	ld	s0,8(sp)
 96e:	0141                	addi	sp,sp,16
 970:	8082                	ret

0000000000000972 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 972:	7139                	addi	sp,sp,-64
 974:	fc06                	sd	ra,56(sp)
 976:	f822                	sd	s0,48(sp)
 978:	f426                	sd	s1,40(sp)
 97a:	f04a                	sd	s2,32(sp)
 97c:	ec4e                	sd	s3,24(sp)
 97e:	e852                	sd	s4,16(sp)
 980:	e456                	sd	s5,8(sp)
 982:	e05a                	sd	s6,0(sp)
 984:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 986:	02051493          	slli	s1,a0,0x20
 98a:	9081                	srli	s1,s1,0x20
 98c:	04bd                	addi	s1,s1,15
 98e:	8091                	srli	s1,s1,0x4
 990:	0014899b          	addiw	s3,s1,1
 994:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 996:	00000517          	auipc	a0,0x0
 99a:	0fa53503          	ld	a0,250(a0) # a90 <freep>
 99e:	c515                	beqz	a0,9ca <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a2:	4798                	lw	a4,8(a5)
 9a4:	02977f63          	bgeu	a4,s1,9e2 <malloc+0x70>
 9a8:	8a4e                	mv	s4,s3
 9aa:	0009871b          	sext.w	a4,s3
 9ae:	6685                	lui	a3,0x1
 9b0:	00d77363          	bgeu	a4,a3,9b6 <malloc+0x44>
 9b4:	6a05                	lui	s4,0x1
 9b6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9ba:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9be:	00000917          	auipc	s2,0x0
 9c2:	0d290913          	addi	s2,s2,210 # a90 <freep>
  if(p == (char*)-1)
 9c6:	5afd                	li	s5,-1
 9c8:	a895                	j	a3c <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 9ca:	00000797          	auipc	a5,0x0
 9ce:	1be78793          	addi	a5,a5,446 # b88 <base>
 9d2:	00000717          	auipc	a4,0x0
 9d6:	0af73f23          	sd	a5,190(a4) # a90 <freep>
 9da:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9dc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9e0:	b7e1                	j	9a8 <malloc+0x36>
      if(p->s.size == nunits)
 9e2:	02e48c63          	beq	s1,a4,a1a <malloc+0xa8>
        p->s.size -= nunits;
 9e6:	4137073b          	subw	a4,a4,s3
 9ea:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ec:	02071693          	slli	a3,a4,0x20
 9f0:	01c6d713          	srli	a4,a3,0x1c
 9f4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9f6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9fa:	00000717          	auipc	a4,0x0
 9fe:	08a73b23          	sd	a0,150(a4) # a90 <freep>
      return (void*)(p + 1);
 a02:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a06:	70e2                	ld	ra,56(sp)
 a08:	7442                	ld	s0,48(sp)
 a0a:	74a2                	ld	s1,40(sp)
 a0c:	7902                	ld	s2,32(sp)
 a0e:	69e2                	ld	s3,24(sp)
 a10:	6a42                	ld	s4,16(sp)
 a12:	6aa2                	ld	s5,8(sp)
 a14:	6b02                	ld	s6,0(sp)
 a16:	6121                	addi	sp,sp,64
 a18:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a1a:	6398                	ld	a4,0(a5)
 a1c:	e118                	sd	a4,0(a0)
 a1e:	bff1                	j	9fa <malloc+0x88>
  hp->s.size = nu;
 a20:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a24:	0541                	addi	a0,a0,16
 a26:	00000097          	auipc	ra,0x0
 a2a:	ec4080e7          	jalr	-316(ra) # 8ea <free>
  return freep;
 a2e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a32:	d971                	beqz	a0,a06 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a34:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a36:	4798                	lw	a4,8(a5)
 a38:	fa9775e3          	bgeu	a4,s1,9e2 <malloc+0x70>
    if(p == freep)
 a3c:	00093703          	ld	a4,0(s2)
 a40:	853e                	mv	a0,a5
 a42:	fef719e3          	bne	a4,a5,a34 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 a46:	8552                	mv	a0,s4
 a48:	00000097          	auipc	ra,0x0
 a4c:	b74080e7          	jalr	-1164(ra) # 5bc <sbrk>
  if(p == (char*)-1)
 a50:	fd5518e3          	bne	a0,s5,a20 <malloc+0xae>
        return 0;
 a54:	4501                	li	a0,0
 a56:	bf45                	j	a06 <malloc+0x94>
