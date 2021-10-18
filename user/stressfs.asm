
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	afa78793          	addi	a5,a5,-1286 # b10 <malloc+0x116>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	ab450513          	addi	a0,a0,-1356 # ae0 <malloc+0xe6>
  34:	00001097          	auipc	ra,0x1
  38:	908080e7          	jalr	-1784(ra) # 93c <printf>
  memset(data, 'a', sizeof(data));
  3c:	20000613          	li	a2,512
  40:	06100593          	li	a1,97
  44:	dd040513          	addi	a0,s0,-560
  48:	00000097          	auipc	ra,0x0
  4c:	378080e7          	jalr	888(ra) # 3c0 <memset>

  for(i = 0; i < 4; i++)
  50:	4481                	li	s1,0
  52:	4911                	li	s2,4
    if(fork() > 0)
  54:	00000097          	auipc	ra,0x0
  58:	560080e7          	jalr	1376(ra) # 5b4 <fork>
  5c:	00a04563          	bgtz	a0,66 <main+0x66>
  for(i = 0; i < 4; i++)
  60:	2485                	addiw	s1,s1,1
  62:	ff2499e3          	bne	s1,s2,54 <main+0x54>
      break;

  printf("write %d\n", i);
  66:	85a6                	mv	a1,s1
  68:	00001517          	auipc	a0,0x1
  6c:	a9050513          	addi	a0,a0,-1392 # af8 <malloc+0xfe>
  70:	00001097          	auipc	ra,0x1
  74:	8cc080e7          	jalr	-1844(ra) # 93c <printf>

  path[8] += i;
  78:	fd844783          	lbu	a5,-40(s0)
  7c:	9cbd                	addw	s1,s1,a5
  7e:	fc940c23          	sb	s1,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  82:	20200593          	li	a1,514
  86:	fd040513          	addi	a0,s0,-48
  8a:	00000097          	auipc	ra,0x0
  8e:	572080e7          	jalr	1394(ra) # 5fc <open>
  92:	892a                	mv	s2,a0
  94:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  96:	20000613          	li	a2,512
  9a:	dd040593          	addi	a1,s0,-560
  9e:	854a                	mv	a0,s2
  a0:	00000097          	auipc	ra,0x0
  a4:	53c080e7          	jalr	1340(ra) # 5dc <write>
  for(i = 0; i < 20; i++)
  a8:	34fd                	addiw	s1,s1,-1
  aa:	f4f5                	bnez	s1,96 <main+0x96>
  close(fd);
  ac:	854a                	mv	a0,s2
  ae:	00000097          	auipc	ra,0x0
  b2:	536080e7          	jalr	1334(ra) # 5e4 <close>

  printf("read\n");
  b6:	00001517          	auipc	a0,0x1
  ba:	a5250513          	addi	a0,a0,-1454 # b08 <malloc+0x10e>
  be:	00001097          	auipc	ra,0x1
  c2:	87e080e7          	jalr	-1922(ra) # 93c <printf>

  fd = open(path, O_RDONLY);
  c6:	4581                	li	a1,0
  c8:	fd040513          	addi	a0,s0,-48
  cc:	00000097          	auipc	ra,0x0
  d0:	530080e7          	jalr	1328(ra) # 5fc <open>
  d4:	892a                	mv	s2,a0
  d6:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  d8:	20000613          	li	a2,512
  dc:	dd040593          	addi	a1,s0,-560
  e0:	854a                	mv	a0,s2
  e2:	00000097          	auipc	ra,0x0
  e6:	4f2080e7          	jalr	1266(ra) # 5d4 <read>
  for (i = 0; i < 20; i++)
  ea:	34fd                	addiw	s1,s1,-1
  ec:	f4f5                	bnez	s1,d8 <main+0xd8>
  close(fd);
  ee:	854a                	mv	a0,s2
  f0:	00000097          	auipc	ra,0x0
  f4:	4f4080e7          	jalr	1268(ra) # 5e4 <close>

  wait(0);
  f8:	4501                	li	a0,0
  fa:	00000097          	auipc	ra,0x0
  fe:	4ca080e7          	jalr	1226(ra) # 5c4 <wait>

  exit(0);
 102:	4501                	li	a0,0
 104:	00000097          	auipc	ra,0x0
 108:	4b8080e7          	jalr	1208(ra) # 5bc <exit>

000000000000010c <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 112:	0f50000f          	fence	iorw,ow
 116:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 11a:	6422                	ld	s0,8(sp)
 11c:	0141                	addi	sp,sp,16
 11e:	8082                	ret

0000000000000120 <load>:

int load(uint64 *p) {
 120:	1141                	addi	sp,sp,-16
 122:	e422                	sd	s0,8(sp)
 124:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 126:	0ff0000f          	fence
 12a:	6108                	ld	a0,0(a0)
 12c:	0ff0000f          	fence
}
 130:	2501                	sext.w	a0,a0
 132:	6422                	ld	s0,8(sp)
 134:	0141                	addi	sp,sp,16
 136:	8082                	ret

0000000000000138 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 138:	7139                	addi	sp,sp,-64
 13a:	fc06                	sd	ra,56(sp)
 13c:	f822                	sd	s0,48(sp)
 13e:	f426                	sd	s1,40(sp)
 140:	f04a                	sd	s2,32(sp)
 142:	ec4e                	sd	s3,24(sp)
 144:	e852                	sd	s4,16(sp)
 146:	e456                	sd	s5,8(sp)
 148:	e05a                	sd	s6,0(sp)
 14a:	0080                	addi	s0,sp,64
 14c:	8a2a                	mv	s4,a0
 14e:	89ae                	mv	s3,a1
 150:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 152:	4785                	li	a5,1
 154:	00001497          	auipc	s1,0x1
 158:	a0448493          	addi	s1,s1,-1532 # b58 <rings+0x8>
 15c:	00001917          	auipc	s2,0x1
 160:	aec90913          	addi	s2,s2,-1300 # c48 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 164:	00001b17          	auipc	s6,0x1
 168:	9dcb0b13          	addi	s6,s6,-1572 # b40 <vm_addr>
  if(open_close == 1){
 16c:	04f59063          	bne	a1,a5,1ac <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 170:	00001497          	auipc	s1,0x1
 174:	9f04a483          	lw	s1,-1552(s1) # b60 <rings+0x10>
 178:	c099                	beqz	s1,17e <create_or_close_the_buffer_user+0x46>
 17a:	4481                	li	s1,0
 17c:	a899                	j	1d2 <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 17e:	865a                	mv	a2,s6
 180:	4585                	li	a1,1
 182:	00000097          	auipc	ra,0x0
 186:	4da080e7          	jalr	1242(ra) # 65c <ringbuf>
        rings[i].book->write_done = 0;
 18a:	00001797          	auipc	a5,0x1
 18e:	9c678793          	addi	a5,a5,-1594 # b50 <rings>
 192:	6798                	ld	a4,8(a5)
 194:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 198:	6798                	ld	a4,8(a5)
 19a:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 19e:	4b98                	lw	a4,16(a5)
 1a0:	2705                	addiw	a4,a4,1
 1a2:	cb98                	sw	a4,16(a5)
        break;
 1a4:	a03d                	j	1d2 <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 1a6:	04e1                	addi	s1,s1,24
 1a8:	03248463          	beq	s1,s2,1d0 <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 1ac:	449c                	lw	a5,8(s1)
 1ae:	dfe5                	beqz	a5,1a6 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 1b0:	865a                	mv	a2,s6
 1b2:	85ce                	mv	a1,s3
 1b4:	8552                	mv	a0,s4
 1b6:	00000097          	auipc	ra,0x0
 1ba:	4a6080e7          	jalr	1190(ra) # 65c <ringbuf>
        rings[i].book->write_done = 0;
 1be:	609c                	ld	a5,0(s1)
 1c0:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 1c4:	609c                	ld	a5,0(s1)
 1c6:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 1ca:	0004a423          	sw	zero,8(s1)
 1ce:	bfe1                	j	1a6 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 1d0:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 1d2:	00001797          	auipc	a5,0x1
 1d6:	96e7b783          	ld	a5,-1682(a5) # b40 <vm_addr>
 1da:	00fab023          	sd	a5,0(s5)
  return i;
}
 1de:	8526                	mv	a0,s1
 1e0:	70e2                	ld	ra,56(sp)
 1e2:	7442                	ld	s0,48(sp)
 1e4:	74a2                	ld	s1,40(sp)
 1e6:	7902                	ld	s2,32(sp)
 1e8:	69e2                	ld	s3,24(sp)
 1ea:	6a42                	ld	s4,16(sp)
 1ec:	6aa2                	ld	s5,8(sp)
 1ee:	6b02                	ld	s6,0(sp)
 1f0:	6121                	addi	sp,sp,64
 1f2:	8082                	ret

00000000000001f4 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 1f4:	1101                	addi	sp,sp,-32
 1f6:	ec06                	sd	ra,24(sp)
 1f8:	e822                	sd	s0,16(sp)
 1fa:	e426                	sd	s1,8(sp)
 1fc:	1000                	addi	s0,sp,32
 1fe:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 200:	00001797          	auipc	a5,0x1
 204:	9407b783          	ld	a5,-1728(a5) # b40 <vm_addr>
 208:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 20a:	421c                	lw	a5,0(a2)
 20c:	e79d                	bnez	a5,23a <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 20e:	00001697          	auipc	a3,0x1
 212:	94268693          	addi	a3,a3,-1726 # b50 <rings>
 216:	669c                	ld	a5,8(a3)
 218:	6398                	ld	a4,0(a5)
 21a:	67c1                	lui	a5,0x10
 21c:	9fb9                	addw	a5,a5,a4
 21e:	00151713          	slli	a4,a0,0x1
 222:	953a                	add	a0,a0,a4
 224:	050e                	slli	a0,a0,0x3
 226:	9536                	add	a0,a0,a3
 228:	6518                	ld	a4,8(a0)
 22a:	6718                	ld	a4,8(a4)
 22c:	9f99                	subw	a5,a5,a4
 22e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 230:	60e2                	ld	ra,24(sp)
 232:	6442                	ld	s0,16(sp)
 234:	64a2                	ld	s1,8(sp)
 236:	6105                	addi	sp,sp,32
 238:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 23a:	00151793          	slli	a5,a0,0x1
 23e:	953e                	add	a0,a0,a5
 240:	050e                	slli	a0,a0,0x3
 242:	00001797          	auipc	a5,0x1
 246:	90e78793          	addi	a5,a5,-1778 # b50 <rings>
 24a:	953e                	add	a0,a0,a5
 24c:	6508                	ld	a0,8(a0)
 24e:	0521                	addi	a0,a0,8
 250:	00000097          	auipc	ra,0x0
 254:	ed0080e7          	jalr	-304(ra) # 120 <load>
 258:	c088                	sw	a0,0(s1)
}
 25a:	bfd9                	j	230 <ringbuf_start_write+0x3c>

000000000000025c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 25c:	1141                	addi	sp,sp,-16
 25e:	e406                	sd	ra,8(sp)
 260:	e022                	sd	s0,0(sp)
 262:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 264:	00151793          	slli	a5,a0,0x1
 268:	97aa                	add	a5,a5,a0
 26a:	078e                	slli	a5,a5,0x3
 26c:	00001517          	auipc	a0,0x1
 270:	8e450513          	addi	a0,a0,-1820 # b50 <rings>
 274:	97aa                	add	a5,a5,a0
 276:	6788                	ld	a0,8(a5)
 278:	0035959b          	slliw	a1,a1,0x3
 27c:	0521                	addi	a0,a0,8
 27e:	00000097          	auipc	ra,0x0
 282:	e8e080e7          	jalr	-370(ra) # 10c <store>
}
 286:	60a2                	ld	ra,8(sp)
 288:	6402                	ld	s0,0(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret

000000000000028e <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 28e:	1101                	addi	sp,sp,-32
 290:	ec06                	sd	ra,24(sp)
 292:	e822                	sd	s0,16(sp)
 294:	e426                	sd	s1,8(sp)
 296:	1000                	addi	s0,sp,32
 298:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 29a:	00151793          	slli	a5,a0,0x1
 29e:	97aa                	add	a5,a5,a0
 2a0:	078e                	slli	a5,a5,0x3
 2a2:	00001517          	auipc	a0,0x1
 2a6:	8ae50513          	addi	a0,a0,-1874 # b50 <rings>
 2aa:	97aa                	add	a5,a5,a0
 2ac:	6788                	ld	a0,8(a5)
 2ae:	0521                	addi	a0,a0,8
 2b0:	00000097          	auipc	ra,0x0
 2b4:	e70080e7          	jalr	-400(ra) # 120 <load>
 2b8:	c088                	sw	a0,0(s1)
}
 2ba:	60e2                	ld	ra,24(sp)
 2bc:	6442                	ld	s0,16(sp)
 2be:	64a2                	ld	s1,8(sp)
 2c0:	6105                	addi	sp,sp,32
 2c2:	8082                	ret

00000000000002c4 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 2c4:	1101                	addi	sp,sp,-32
 2c6:	ec06                	sd	ra,24(sp)
 2c8:	e822                	sd	s0,16(sp)
 2ca:	e426                	sd	s1,8(sp)
 2cc:	1000                	addi	s0,sp,32
 2ce:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 2d0:	00151793          	slli	a5,a0,0x1
 2d4:	97aa                	add	a5,a5,a0
 2d6:	078e                	slli	a5,a5,0x3
 2d8:	00001517          	auipc	a0,0x1
 2dc:	87850513          	addi	a0,a0,-1928 # b50 <rings>
 2e0:	97aa                	add	a5,a5,a0
 2e2:	6788                	ld	a0,8(a5)
 2e4:	611c                	ld	a5,0(a0)
 2e6:	ef99                	bnez	a5,304 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2e8:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2ea:	41f7579b          	sraiw	a5,a4,0x1f
 2ee:	01d7d79b          	srliw	a5,a5,0x1d
 2f2:	9fb9                	addw	a5,a5,a4
 2f4:	4037d79b          	sraiw	a5,a5,0x3
 2f8:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 2fa:	60e2                	ld	ra,24(sp)
 2fc:	6442                	ld	s0,16(sp)
 2fe:	64a2                	ld	s1,8(sp)
 300:	6105                	addi	sp,sp,32
 302:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 304:	00000097          	auipc	ra,0x0
 308:	e1c080e7          	jalr	-484(ra) # 120 <load>
    *bytes /= 8;
 30c:	41f5579b          	sraiw	a5,a0,0x1f
 310:	01d7d79b          	srliw	a5,a5,0x1d
 314:	9d3d                	addw	a0,a0,a5
 316:	4035551b          	sraiw	a0,a0,0x3
 31a:	c088                	sw	a0,0(s1)
}
 31c:	bff9                	j	2fa <ringbuf_start_read+0x36>

000000000000031e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 31e:	1141                	addi	sp,sp,-16
 320:	e406                	sd	ra,8(sp)
 322:	e022                	sd	s0,0(sp)
 324:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 326:	00151793          	slli	a5,a0,0x1
 32a:	97aa                	add	a5,a5,a0
 32c:	078e                	slli	a5,a5,0x3
 32e:	00001517          	auipc	a0,0x1
 332:	82250513          	addi	a0,a0,-2014 # b50 <rings>
 336:	97aa                	add	a5,a5,a0
 338:	0035959b          	slliw	a1,a1,0x3
 33c:	6788                	ld	a0,8(a5)
 33e:	00000097          	auipc	ra,0x0
 342:	dce080e7          	jalr	-562(ra) # 10c <store>
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <strcpy>:



char*
strcpy(char *s, const char *t)
{
 34e:	1141                	addi	sp,sp,-16
 350:	e422                	sd	s0,8(sp)
 352:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 354:	87aa                	mv	a5,a0
 356:	0585                	addi	a1,a1,1
 358:	0785                	addi	a5,a5,1
 35a:	fff5c703          	lbu	a4,-1(a1)
 35e:	fee78fa3          	sb	a4,-1(a5)
 362:	fb75                	bnez	a4,356 <strcpy+0x8>
    ;
  return os;
}
 364:	6422                	ld	s0,8(sp)
 366:	0141                	addi	sp,sp,16
 368:	8082                	ret

000000000000036a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 36a:	1141                	addi	sp,sp,-16
 36c:	e422                	sd	s0,8(sp)
 36e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 370:	00054783          	lbu	a5,0(a0)
 374:	cb91                	beqz	a5,388 <strcmp+0x1e>
 376:	0005c703          	lbu	a4,0(a1)
 37a:	00f71763          	bne	a4,a5,388 <strcmp+0x1e>
    p++, q++;
 37e:	0505                	addi	a0,a0,1
 380:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 382:	00054783          	lbu	a5,0(a0)
 386:	fbe5                	bnez	a5,376 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 388:	0005c503          	lbu	a0,0(a1)
}
 38c:	40a7853b          	subw	a0,a5,a0
 390:	6422                	ld	s0,8(sp)
 392:	0141                	addi	sp,sp,16
 394:	8082                	ret

0000000000000396 <strlen>:

uint
strlen(const char *s)
{
 396:	1141                	addi	sp,sp,-16
 398:	e422                	sd	s0,8(sp)
 39a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 39c:	00054783          	lbu	a5,0(a0)
 3a0:	cf91                	beqz	a5,3bc <strlen+0x26>
 3a2:	0505                	addi	a0,a0,1
 3a4:	87aa                	mv	a5,a0
 3a6:	4685                	li	a3,1
 3a8:	9e89                	subw	a3,a3,a0
 3aa:	00f6853b          	addw	a0,a3,a5
 3ae:	0785                	addi	a5,a5,1
 3b0:	fff7c703          	lbu	a4,-1(a5)
 3b4:	fb7d                	bnez	a4,3aa <strlen+0x14>
    ;
  return n;
}
 3b6:	6422                	ld	s0,8(sp)
 3b8:	0141                	addi	sp,sp,16
 3ba:	8082                	ret
  for(n = 0; s[n]; n++)
 3bc:	4501                	li	a0,0
 3be:	bfe5                	j	3b6 <strlen+0x20>

00000000000003c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3c6:	ca19                	beqz	a2,3dc <memset+0x1c>
 3c8:	87aa                	mv	a5,a0
 3ca:	1602                	slli	a2,a2,0x20
 3cc:	9201                	srli	a2,a2,0x20
 3ce:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3d2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3d6:	0785                	addi	a5,a5,1
 3d8:	fee79de3          	bne	a5,a4,3d2 <memset+0x12>
  }
  return dst;
}
 3dc:	6422                	ld	s0,8(sp)
 3de:	0141                	addi	sp,sp,16
 3e0:	8082                	ret

00000000000003e2 <strchr>:

char*
strchr(const char *s, char c)
{
 3e2:	1141                	addi	sp,sp,-16
 3e4:	e422                	sd	s0,8(sp)
 3e6:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3e8:	00054783          	lbu	a5,0(a0)
 3ec:	cb99                	beqz	a5,402 <strchr+0x20>
    if(*s == c)
 3ee:	00f58763          	beq	a1,a5,3fc <strchr+0x1a>
  for(; *s; s++)
 3f2:	0505                	addi	a0,a0,1
 3f4:	00054783          	lbu	a5,0(a0)
 3f8:	fbfd                	bnez	a5,3ee <strchr+0xc>
      return (char*)s;
  return 0;
 3fa:	4501                	li	a0,0
}
 3fc:	6422                	ld	s0,8(sp)
 3fe:	0141                	addi	sp,sp,16
 400:	8082                	ret
  return 0;
 402:	4501                	li	a0,0
 404:	bfe5                	j	3fc <strchr+0x1a>

0000000000000406 <gets>:

char*
gets(char *buf, int max)
{
 406:	711d                	addi	sp,sp,-96
 408:	ec86                	sd	ra,88(sp)
 40a:	e8a2                	sd	s0,80(sp)
 40c:	e4a6                	sd	s1,72(sp)
 40e:	e0ca                	sd	s2,64(sp)
 410:	fc4e                	sd	s3,56(sp)
 412:	f852                	sd	s4,48(sp)
 414:	f456                	sd	s5,40(sp)
 416:	f05a                	sd	s6,32(sp)
 418:	ec5e                	sd	s7,24(sp)
 41a:	1080                	addi	s0,sp,96
 41c:	8baa                	mv	s7,a0
 41e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 420:	892a                	mv	s2,a0
 422:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 424:	4aa9                	li	s5,10
 426:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 428:	89a6                	mv	s3,s1
 42a:	2485                	addiw	s1,s1,1
 42c:	0344d863          	bge	s1,s4,45c <gets+0x56>
    cc = read(0, &c, 1);
 430:	4605                	li	a2,1
 432:	faf40593          	addi	a1,s0,-81
 436:	4501                	li	a0,0
 438:	00000097          	auipc	ra,0x0
 43c:	19c080e7          	jalr	412(ra) # 5d4 <read>
    if(cc < 1)
 440:	00a05e63          	blez	a0,45c <gets+0x56>
    buf[i++] = c;
 444:	faf44783          	lbu	a5,-81(s0)
 448:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 44c:	01578763          	beq	a5,s5,45a <gets+0x54>
 450:	0905                	addi	s2,s2,1
 452:	fd679be3          	bne	a5,s6,428 <gets+0x22>
  for(i=0; i+1 < max; ){
 456:	89a6                	mv	s3,s1
 458:	a011                	j	45c <gets+0x56>
 45a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 45c:	99de                	add	s3,s3,s7
 45e:	00098023          	sb	zero,0(s3)
  return buf;
}
 462:	855e                	mv	a0,s7
 464:	60e6                	ld	ra,88(sp)
 466:	6446                	ld	s0,80(sp)
 468:	64a6                	ld	s1,72(sp)
 46a:	6906                	ld	s2,64(sp)
 46c:	79e2                	ld	s3,56(sp)
 46e:	7a42                	ld	s4,48(sp)
 470:	7aa2                	ld	s5,40(sp)
 472:	7b02                	ld	s6,32(sp)
 474:	6be2                	ld	s7,24(sp)
 476:	6125                	addi	sp,sp,96
 478:	8082                	ret

000000000000047a <stat>:

int
stat(const char *n, struct stat *st)
{
 47a:	1101                	addi	sp,sp,-32
 47c:	ec06                	sd	ra,24(sp)
 47e:	e822                	sd	s0,16(sp)
 480:	e426                	sd	s1,8(sp)
 482:	e04a                	sd	s2,0(sp)
 484:	1000                	addi	s0,sp,32
 486:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 488:	4581                	li	a1,0
 48a:	00000097          	auipc	ra,0x0
 48e:	172080e7          	jalr	370(ra) # 5fc <open>
  if(fd < 0)
 492:	02054563          	bltz	a0,4bc <stat+0x42>
 496:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 498:	85ca                	mv	a1,s2
 49a:	00000097          	auipc	ra,0x0
 49e:	17a080e7          	jalr	378(ra) # 614 <fstat>
 4a2:	892a                	mv	s2,a0
  close(fd);
 4a4:	8526                	mv	a0,s1
 4a6:	00000097          	auipc	ra,0x0
 4aa:	13e080e7          	jalr	318(ra) # 5e4 <close>
  return r;
}
 4ae:	854a                	mv	a0,s2
 4b0:	60e2                	ld	ra,24(sp)
 4b2:	6442                	ld	s0,16(sp)
 4b4:	64a2                	ld	s1,8(sp)
 4b6:	6902                	ld	s2,0(sp)
 4b8:	6105                	addi	sp,sp,32
 4ba:	8082                	ret
    return -1;
 4bc:	597d                	li	s2,-1
 4be:	bfc5                	j	4ae <stat+0x34>

00000000000004c0 <atoi>:

int
atoi(const char *s)
{
 4c0:	1141                	addi	sp,sp,-16
 4c2:	e422                	sd	s0,8(sp)
 4c4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c6:	00054603          	lbu	a2,0(a0)
 4ca:	fd06079b          	addiw	a5,a2,-48
 4ce:	0ff7f793          	zext.b	a5,a5
 4d2:	4725                	li	a4,9
 4d4:	02f76963          	bltu	a4,a5,506 <atoi+0x46>
 4d8:	86aa                	mv	a3,a0
  n = 0;
 4da:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4dc:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4de:	0685                	addi	a3,a3,1
 4e0:	0025179b          	slliw	a5,a0,0x2
 4e4:	9fa9                	addw	a5,a5,a0
 4e6:	0017979b          	slliw	a5,a5,0x1
 4ea:	9fb1                	addw	a5,a5,a2
 4ec:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4f0:	0006c603          	lbu	a2,0(a3)
 4f4:	fd06071b          	addiw	a4,a2,-48
 4f8:	0ff77713          	zext.b	a4,a4
 4fc:	fee5f1e3          	bgeu	a1,a4,4de <atoi+0x1e>
  return n;
}
 500:	6422                	ld	s0,8(sp)
 502:	0141                	addi	sp,sp,16
 504:	8082                	ret
  n = 0;
 506:	4501                	li	a0,0
 508:	bfe5                	j	500 <atoi+0x40>

000000000000050a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 50a:	1141                	addi	sp,sp,-16
 50c:	e422                	sd	s0,8(sp)
 50e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 510:	02b57463          	bgeu	a0,a1,538 <memmove+0x2e>
    while(n-- > 0)
 514:	00c05f63          	blez	a2,532 <memmove+0x28>
 518:	1602                	slli	a2,a2,0x20
 51a:	9201                	srli	a2,a2,0x20
 51c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 520:	872a                	mv	a4,a0
      *dst++ = *src++;
 522:	0585                	addi	a1,a1,1
 524:	0705                	addi	a4,a4,1
 526:	fff5c683          	lbu	a3,-1(a1)
 52a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 52e:	fee79ae3          	bne	a5,a4,522 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 532:	6422                	ld	s0,8(sp)
 534:	0141                	addi	sp,sp,16
 536:	8082                	ret
    dst += n;
 538:	00c50733          	add	a4,a0,a2
    src += n;
 53c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 53e:	fec05ae3          	blez	a2,532 <memmove+0x28>
 542:	fff6079b          	addiw	a5,a2,-1
 546:	1782                	slli	a5,a5,0x20
 548:	9381                	srli	a5,a5,0x20
 54a:	fff7c793          	not	a5,a5
 54e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 550:	15fd                	addi	a1,a1,-1
 552:	177d                	addi	a4,a4,-1
 554:	0005c683          	lbu	a3,0(a1)
 558:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 55c:	fee79ae3          	bne	a5,a4,550 <memmove+0x46>
 560:	bfc9                	j	532 <memmove+0x28>

0000000000000562 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 562:	1141                	addi	sp,sp,-16
 564:	e422                	sd	s0,8(sp)
 566:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 568:	ca05                	beqz	a2,598 <memcmp+0x36>
 56a:	fff6069b          	addiw	a3,a2,-1
 56e:	1682                	slli	a3,a3,0x20
 570:	9281                	srli	a3,a3,0x20
 572:	0685                	addi	a3,a3,1
 574:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 576:	00054783          	lbu	a5,0(a0)
 57a:	0005c703          	lbu	a4,0(a1)
 57e:	00e79863          	bne	a5,a4,58e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 582:	0505                	addi	a0,a0,1
    p2++;
 584:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 586:	fed518e3          	bne	a0,a3,576 <memcmp+0x14>
  }
  return 0;
 58a:	4501                	li	a0,0
 58c:	a019                	j	592 <memcmp+0x30>
      return *p1 - *p2;
 58e:	40e7853b          	subw	a0,a5,a4
}
 592:	6422                	ld	s0,8(sp)
 594:	0141                	addi	sp,sp,16
 596:	8082                	ret
  return 0;
 598:	4501                	li	a0,0
 59a:	bfe5                	j	592 <memcmp+0x30>

000000000000059c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 59c:	1141                	addi	sp,sp,-16
 59e:	e406                	sd	ra,8(sp)
 5a0:	e022                	sd	s0,0(sp)
 5a2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5a4:	00000097          	auipc	ra,0x0
 5a8:	f66080e7          	jalr	-154(ra) # 50a <memmove>
}
 5ac:	60a2                	ld	ra,8(sp)
 5ae:	6402                	ld	s0,0(sp)
 5b0:	0141                	addi	sp,sp,16
 5b2:	8082                	ret

00000000000005b4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5b4:	4885                	li	a7,1
 ecall
 5b6:	00000073          	ecall
 ret
 5ba:	8082                	ret

00000000000005bc <exit>:
.global exit
exit:
 li a7, SYS_exit
 5bc:	4889                	li	a7,2
 ecall
 5be:	00000073          	ecall
 ret
 5c2:	8082                	ret

00000000000005c4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5c4:	488d                	li	a7,3
 ecall
 5c6:	00000073          	ecall
 ret
 5ca:	8082                	ret

00000000000005cc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5cc:	4891                	li	a7,4
 ecall
 5ce:	00000073          	ecall
 ret
 5d2:	8082                	ret

00000000000005d4 <read>:
.global read
read:
 li a7, SYS_read
 5d4:	4895                	li	a7,5
 ecall
 5d6:	00000073          	ecall
 ret
 5da:	8082                	ret

00000000000005dc <write>:
.global write
write:
 li a7, SYS_write
 5dc:	48c1                	li	a7,16
 ecall
 5de:	00000073          	ecall
 ret
 5e2:	8082                	ret

00000000000005e4 <close>:
.global close
close:
 li a7, SYS_close
 5e4:	48d5                	li	a7,21
 ecall
 5e6:	00000073          	ecall
 ret
 5ea:	8082                	ret

00000000000005ec <kill>:
.global kill
kill:
 li a7, SYS_kill
 5ec:	4899                	li	a7,6
 ecall
 5ee:	00000073          	ecall
 ret
 5f2:	8082                	ret

00000000000005f4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5f4:	489d                	li	a7,7
 ecall
 5f6:	00000073          	ecall
 ret
 5fa:	8082                	ret

00000000000005fc <open>:
.global open
open:
 li a7, SYS_open
 5fc:	48bd                	li	a7,15
 ecall
 5fe:	00000073          	ecall
 ret
 602:	8082                	ret

0000000000000604 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 604:	48c5                	li	a7,17
 ecall
 606:	00000073          	ecall
 ret
 60a:	8082                	ret

000000000000060c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 60c:	48c9                	li	a7,18
 ecall
 60e:	00000073          	ecall
 ret
 612:	8082                	ret

0000000000000614 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 614:	48a1                	li	a7,8
 ecall
 616:	00000073          	ecall
 ret
 61a:	8082                	ret

000000000000061c <link>:
.global link
link:
 li a7, SYS_link
 61c:	48cd                	li	a7,19
 ecall
 61e:	00000073          	ecall
 ret
 622:	8082                	ret

0000000000000624 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 624:	48d1                	li	a7,20
 ecall
 626:	00000073          	ecall
 ret
 62a:	8082                	ret

000000000000062c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 62c:	48a5                	li	a7,9
 ecall
 62e:	00000073          	ecall
 ret
 632:	8082                	ret

0000000000000634 <dup>:
.global dup
dup:
 li a7, SYS_dup
 634:	48a9                	li	a7,10
 ecall
 636:	00000073          	ecall
 ret
 63a:	8082                	ret

000000000000063c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 63c:	48ad                	li	a7,11
 ecall
 63e:	00000073          	ecall
 ret
 642:	8082                	ret

0000000000000644 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 644:	48b1                	li	a7,12
 ecall
 646:	00000073          	ecall
 ret
 64a:	8082                	ret

000000000000064c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 64c:	48b5                	li	a7,13
 ecall
 64e:	00000073          	ecall
 ret
 652:	8082                	ret

0000000000000654 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 654:	48b9                	li	a7,14
 ecall
 656:	00000073          	ecall
 ret
 65a:	8082                	ret

000000000000065c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 65c:	48d9                	li	a7,22
 ecall
 65e:	00000073          	ecall
 ret
 662:	8082                	ret

0000000000000664 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 664:	1101                	addi	sp,sp,-32
 666:	ec06                	sd	ra,24(sp)
 668:	e822                	sd	s0,16(sp)
 66a:	1000                	addi	s0,sp,32
 66c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 670:	4605                	li	a2,1
 672:	fef40593          	addi	a1,s0,-17
 676:	00000097          	auipc	ra,0x0
 67a:	f66080e7          	jalr	-154(ra) # 5dc <write>
}
 67e:	60e2                	ld	ra,24(sp)
 680:	6442                	ld	s0,16(sp)
 682:	6105                	addi	sp,sp,32
 684:	8082                	ret

0000000000000686 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 686:	7139                	addi	sp,sp,-64
 688:	fc06                	sd	ra,56(sp)
 68a:	f822                	sd	s0,48(sp)
 68c:	f426                	sd	s1,40(sp)
 68e:	f04a                	sd	s2,32(sp)
 690:	ec4e                	sd	s3,24(sp)
 692:	0080                	addi	s0,sp,64
 694:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 696:	c299                	beqz	a3,69c <printint+0x16>
 698:	0805c863          	bltz	a1,728 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 69c:	2581                	sext.w	a1,a1
  neg = 0;
 69e:	4881                	li	a7,0
 6a0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6a4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6a6:	2601                	sext.w	a2,a2
 6a8:	00000517          	auipc	a0,0x0
 6ac:	48050513          	addi	a0,a0,1152 # b28 <digits>
 6b0:	883a                	mv	a6,a4
 6b2:	2705                	addiw	a4,a4,1
 6b4:	02c5f7bb          	remuw	a5,a1,a2
 6b8:	1782                	slli	a5,a5,0x20
 6ba:	9381                	srli	a5,a5,0x20
 6bc:	97aa                	add	a5,a5,a0
 6be:	0007c783          	lbu	a5,0(a5)
 6c2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6c6:	0005879b          	sext.w	a5,a1
 6ca:	02c5d5bb          	divuw	a1,a1,a2
 6ce:	0685                	addi	a3,a3,1
 6d0:	fec7f0e3          	bgeu	a5,a2,6b0 <printint+0x2a>
  if(neg)
 6d4:	00088b63          	beqz	a7,6ea <printint+0x64>
    buf[i++] = '-';
 6d8:	fd040793          	addi	a5,s0,-48
 6dc:	973e                	add	a4,a4,a5
 6de:	02d00793          	li	a5,45
 6e2:	fef70823          	sb	a5,-16(a4)
 6e6:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6ea:	02e05863          	blez	a4,71a <printint+0x94>
 6ee:	fc040793          	addi	a5,s0,-64
 6f2:	00e78933          	add	s2,a5,a4
 6f6:	fff78993          	addi	s3,a5,-1
 6fa:	99ba                	add	s3,s3,a4
 6fc:	377d                	addiw	a4,a4,-1
 6fe:	1702                	slli	a4,a4,0x20
 700:	9301                	srli	a4,a4,0x20
 702:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 706:	fff94583          	lbu	a1,-1(s2)
 70a:	8526                	mv	a0,s1
 70c:	00000097          	auipc	ra,0x0
 710:	f58080e7          	jalr	-168(ra) # 664 <putc>
  while(--i >= 0)
 714:	197d                	addi	s2,s2,-1
 716:	ff3918e3          	bne	s2,s3,706 <printint+0x80>
}
 71a:	70e2                	ld	ra,56(sp)
 71c:	7442                	ld	s0,48(sp)
 71e:	74a2                	ld	s1,40(sp)
 720:	7902                	ld	s2,32(sp)
 722:	69e2                	ld	s3,24(sp)
 724:	6121                	addi	sp,sp,64
 726:	8082                	ret
    x = -xx;
 728:	40b005bb          	negw	a1,a1
    neg = 1;
 72c:	4885                	li	a7,1
    x = -xx;
 72e:	bf8d                	j	6a0 <printint+0x1a>

0000000000000730 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 730:	7119                	addi	sp,sp,-128
 732:	fc86                	sd	ra,120(sp)
 734:	f8a2                	sd	s0,112(sp)
 736:	f4a6                	sd	s1,104(sp)
 738:	f0ca                	sd	s2,96(sp)
 73a:	ecce                	sd	s3,88(sp)
 73c:	e8d2                	sd	s4,80(sp)
 73e:	e4d6                	sd	s5,72(sp)
 740:	e0da                	sd	s6,64(sp)
 742:	fc5e                	sd	s7,56(sp)
 744:	f862                	sd	s8,48(sp)
 746:	f466                	sd	s9,40(sp)
 748:	f06a                	sd	s10,32(sp)
 74a:	ec6e                	sd	s11,24(sp)
 74c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 74e:	0005c903          	lbu	s2,0(a1)
 752:	18090f63          	beqz	s2,8f0 <vprintf+0x1c0>
 756:	8aaa                	mv	s5,a0
 758:	8b32                	mv	s6,a2
 75a:	00158493          	addi	s1,a1,1
  state = 0;
 75e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 760:	02500a13          	li	s4,37
      if(c == 'd'){
 764:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 768:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 76c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 770:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 774:	00000b97          	auipc	s7,0x0
 778:	3b4b8b93          	addi	s7,s7,948 # b28 <digits>
 77c:	a839                	j	79a <vprintf+0x6a>
        putc(fd, c);
 77e:	85ca                	mv	a1,s2
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	ee2080e7          	jalr	-286(ra) # 664 <putc>
 78a:	a019                	j	790 <vprintf+0x60>
    } else if(state == '%'){
 78c:	01498f63          	beq	s3,s4,7aa <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 790:	0485                	addi	s1,s1,1
 792:	fff4c903          	lbu	s2,-1(s1)
 796:	14090d63          	beqz	s2,8f0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 79a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 79e:	fe0997e3          	bnez	s3,78c <vprintf+0x5c>
      if(c == '%'){
 7a2:	fd479ee3          	bne	a5,s4,77e <vprintf+0x4e>
        state = '%';
 7a6:	89be                	mv	s3,a5
 7a8:	b7e5                	j	790 <vprintf+0x60>
      if(c == 'd'){
 7aa:	05878063          	beq	a5,s8,7ea <vprintf+0xba>
      } else if(c == 'l') {
 7ae:	05978c63          	beq	a5,s9,806 <vprintf+0xd6>
      } else if(c == 'x') {
 7b2:	07a78863          	beq	a5,s10,822 <vprintf+0xf2>
      } else if(c == 'p') {
 7b6:	09b78463          	beq	a5,s11,83e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7ba:	07300713          	li	a4,115
 7be:	0ce78663          	beq	a5,a4,88a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7c2:	06300713          	li	a4,99
 7c6:	0ee78e63          	beq	a5,a4,8c2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7ca:	11478863          	beq	a5,s4,8da <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7ce:	85d2                	mv	a1,s4
 7d0:	8556                	mv	a0,s5
 7d2:	00000097          	auipc	ra,0x0
 7d6:	e92080e7          	jalr	-366(ra) # 664 <putc>
        putc(fd, c);
 7da:	85ca                	mv	a1,s2
 7dc:	8556                	mv	a0,s5
 7de:	00000097          	auipc	ra,0x0
 7e2:	e86080e7          	jalr	-378(ra) # 664 <putc>
      }
      state = 0;
 7e6:	4981                	li	s3,0
 7e8:	b765                	j	790 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7ea:	008b0913          	addi	s2,s6,8
 7ee:	4685                	li	a3,1
 7f0:	4629                	li	a2,10
 7f2:	000b2583          	lw	a1,0(s6)
 7f6:	8556                	mv	a0,s5
 7f8:	00000097          	auipc	ra,0x0
 7fc:	e8e080e7          	jalr	-370(ra) # 686 <printint>
 800:	8b4a                	mv	s6,s2
      state = 0;
 802:	4981                	li	s3,0
 804:	b771                	j	790 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 806:	008b0913          	addi	s2,s6,8
 80a:	4681                	li	a3,0
 80c:	4629                	li	a2,10
 80e:	000b2583          	lw	a1,0(s6)
 812:	8556                	mv	a0,s5
 814:	00000097          	auipc	ra,0x0
 818:	e72080e7          	jalr	-398(ra) # 686 <printint>
 81c:	8b4a                	mv	s6,s2
      state = 0;
 81e:	4981                	li	s3,0
 820:	bf85                	j	790 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 822:	008b0913          	addi	s2,s6,8
 826:	4681                	li	a3,0
 828:	4641                	li	a2,16
 82a:	000b2583          	lw	a1,0(s6)
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	e56080e7          	jalr	-426(ra) # 686 <printint>
 838:	8b4a                	mv	s6,s2
      state = 0;
 83a:	4981                	li	s3,0
 83c:	bf91                	j	790 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 83e:	008b0793          	addi	a5,s6,8
 842:	f8f43423          	sd	a5,-120(s0)
 846:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 84a:	03000593          	li	a1,48
 84e:	8556                	mv	a0,s5
 850:	00000097          	auipc	ra,0x0
 854:	e14080e7          	jalr	-492(ra) # 664 <putc>
  putc(fd, 'x');
 858:	85ea                	mv	a1,s10
 85a:	8556                	mv	a0,s5
 85c:	00000097          	auipc	ra,0x0
 860:	e08080e7          	jalr	-504(ra) # 664 <putc>
 864:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 866:	03c9d793          	srli	a5,s3,0x3c
 86a:	97de                	add	a5,a5,s7
 86c:	0007c583          	lbu	a1,0(a5)
 870:	8556                	mv	a0,s5
 872:	00000097          	auipc	ra,0x0
 876:	df2080e7          	jalr	-526(ra) # 664 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 87a:	0992                	slli	s3,s3,0x4
 87c:	397d                	addiw	s2,s2,-1
 87e:	fe0914e3          	bnez	s2,866 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 882:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 886:	4981                	li	s3,0
 888:	b721                	j	790 <vprintf+0x60>
        s = va_arg(ap, char*);
 88a:	008b0993          	addi	s3,s6,8
 88e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 892:	02090163          	beqz	s2,8b4 <vprintf+0x184>
        while(*s != 0){
 896:	00094583          	lbu	a1,0(s2)
 89a:	c9a1                	beqz	a1,8ea <vprintf+0x1ba>
          putc(fd, *s);
 89c:	8556                	mv	a0,s5
 89e:	00000097          	auipc	ra,0x0
 8a2:	dc6080e7          	jalr	-570(ra) # 664 <putc>
          s++;
 8a6:	0905                	addi	s2,s2,1
        while(*s != 0){
 8a8:	00094583          	lbu	a1,0(s2)
 8ac:	f9e5                	bnez	a1,89c <vprintf+0x16c>
        s = va_arg(ap, char*);
 8ae:	8b4e                	mv	s6,s3
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	bdf9                	j	790 <vprintf+0x60>
          s = "(null)";
 8b4:	00000917          	auipc	s2,0x0
 8b8:	26c90913          	addi	s2,s2,620 # b20 <malloc+0x126>
        while(*s != 0){
 8bc:	02800593          	li	a1,40
 8c0:	bff1                	j	89c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8c2:	008b0913          	addi	s2,s6,8
 8c6:	000b4583          	lbu	a1,0(s6)
 8ca:	8556                	mv	a0,s5
 8cc:	00000097          	auipc	ra,0x0
 8d0:	d98080e7          	jalr	-616(ra) # 664 <putc>
 8d4:	8b4a                	mv	s6,s2
      state = 0;
 8d6:	4981                	li	s3,0
 8d8:	bd65                	j	790 <vprintf+0x60>
        putc(fd, c);
 8da:	85d2                	mv	a1,s4
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	d86080e7          	jalr	-634(ra) # 664 <putc>
      state = 0;
 8e6:	4981                	li	s3,0
 8e8:	b565                	j	790 <vprintf+0x60>
        s = va_arg(ap, char*);
 8ea:	8b4e                	mv	s6,s3
      state = 0;
 8ec:	4981                	li	s3,0
 8ee:	b54d                	j	790 <vprintf+0x60>
    }
  }
}
 8f0:	70e6                	ld	ra,120(sp)
 8f2:	7446                	ld	s0,112(sp)
 8f4:	74a6                	ld	s1,104(sp)
 8f6:	7906                	ld	s2,96(sp)
 8f8:	69e6                	ld	s3,88(sp)
 8fa:	6a46                	ld	s4,80(sp)
 8fc:	6aa6                	ld	s5,72(sp)
 8fe:	6b06                	ld	s6,64(sp)
 900:	7be2                	ld	s7,56(sp)
 902:	7c42                	ld	s8,48(sp)
 904:	7ca2                	ld	s9,40(sp)
 906:	7d02                	ld	s10,32(sp)
 908:	6de2                	ld	s11,24(sp)
 90a:	6109                	addi	sp,sp,128
 90c:	8082                	ret

000000000000090e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 90e:	715d                	addi	sp,sp,-80
 910:	ec06                	sd	ra,24(sp)
 912:	e822                	sd	s0,16(sp)
 914:	1000                	addi	s0,sp,32
 916:	e010                	sd	a2,0(s0)
 918:	e414                	sd	a3,8(s0)
 91a:	e818                	sd	a4,16(s0)
 91c:	ec1c                	sd	a5,24(s0)
 91e:	03043023          	sd	a6,32(s0)
 922:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 926:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 92a:	8622                	mv	a2,s0
 92c:	00000097          	auipc	ra,0x0
 930:	e04080e7          	jalr	-508(ra) # 730 <vprintf>
}
 934:	60e2                	ld	ra,24(sp)
 936:	6442                	ld	s0,16(sp)
 938:	6161                	addi	sp,sp,80
 93a:	8082                	ret

000000000000093c <printf>:

void
printf(const char *fmt, ...)
{
 93c:	711d                	addi	sp,sp,-96
 93e:	ec06                	sd	ra,24(sp)
 940:	e822                	sd	s0,16(sp)
 942:	1000                	addi	s0,sp,32
 944:	e40c                	sd	a1,8(s0)
 946:	e810                	sd	a2,16(s0)
 948:	ec14                	sd	a3,24(s0)
 94a:	f018                	sd	a4,32(s0)
 94c:	f41c                	sd	a5,40(s0)
 94e:	03043823          	sd	a6,48(s0)
 952:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 956:	00840613          	addi	a2,s0,8
 95a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 95e:	85aa                	mv	a1,a0
 960:	4505                	li	a0,1
 962:	00000097          	auipc	ra,0x0
 966:	dce080e7          	jalr	-562(ra) # 730 <vprintf>
}
 96a:	60e2                	ld	ra,24(sp)
 96c:	6442                	ld	s0,16(sp)
 96e:	6125                	addi	sp,sp,96
 970:	8082                	ret

0000000000000972 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 972:	1141                	addi	sp,sp,-16
 974:	e422                	sd	s0,8(sp)
 976:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 978:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 97c:	00000797          	auipc	a5,0x0
 980:	1cc7b783          	ld	a5,460(a5) # b48 <freep>
 984:	a805                	j	9b4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 986:	4618                	lw	a4,8(a2)
 988:	9db9                	addw	a1,a1,a4
 98a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 98e:	6398                	ld	a4,0(a5)
 990:	6318                	ld	a4,0(a4)
 992:	fee53823          	sd	a4,-16(a0)
 996:	a091                	j	9da <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 998:	ff852703          	lw	a4,-8(a0)
 99c:	9e39                	addw	a2,a2,a4
 99e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9a0:	ff053703          	ld	a4,-16(a0)
 9a4:	e398                	sd	a4,0(a5)
 9a6:	a099                	j	9ec <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a8:	6398                	ld	a4,0(a5)
 9aa:	00e7e463          	bltu	a5,a4,9b2 <free+0x40>
 9ae:	00e6ea63          	bltu	a3,a4,9c2 <free+0x50>
{
 9b2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b4:	fed7fae3          	bgeu	a5,a3,9a8 <free+0x36>
 9b8:	6398                	ld	a4,0(a5)
 9ba:	00e6e463          	bltu	a3,a4,9c2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9be:	fee7eae3          	bltu	a5,a4,9b2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9c2:	ff852583          	lw	a1,-8(a0)
 9c6:	6390                	ld	a2,0(a5)
 9c8:	02059813          	slli	a6,a1,0x20
 9cc:	01c85713          	srli	a4,a6,0x1c
 9d0:	9736                	add	a4,a4,a3
 9d2:	fae60ae3          	beq	a2,a4,986 <free+0x14>
    bp->s.ptr = p->s.ptr;
 9d6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9da:	4790                	lw	a2,8(a5)
 9dc:	02061593          	slli	a1,a2,0x20
 9e0:	01c5d713          	srli	a4,a1,0x1c
 9e4:	973e                	add	a4,a4,a5
 9e6:	fae689e3          	beq	a3,a4,998 <free+0x26>
  } else
    p->s.ptr = bp;
 9ea:	e394                	sd	a3,0(a5)
  freep = p;
 9ec:	00000717          	auipc	a4,0x0
 9f0:	14f73e23          	sd	a5,348(a4) # b48 <freep>
}
 9f4:	6422                	ld	s0,8(sp)
 9f6:	0141                	addi	sp,sp,16
 9f8:	8082                	ret

00000000000009fa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9fa:	7139                	addi	sp,sp,-64
 9fc:	fc06                	sd	ra,56(sp)
 9fe:	f822                	sd	s0,48(sp)
 a00:	f426                	sd	s1,40(sp)
 a02:	f04a                	sd	s2,32(sp)
 a04:	ec4e                	sd	s3,24(sp)
 a06:	e852                	sd	s4,16(sp)
 a08:	e456                	sd	s5,8(sp)
 a0a:	e05a                	sd	s6,0(sp)
 a0c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a0e:	02051493          	slli	s1,a0,0x20
 a12:	9081                	srli	s1,s1,0x20
 a14:	04bd                	addi	s1,s1,15
 a16:	8091                	srli	s1,s1,0x4
 a18:	0014899b          	addiw	s3,s1,1
 a1c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a1e:	00000517          	auipc	a0,0x0
 a22:	12a53503          	ld	a0,298(a0) # b48 <freep>
 a26:	c515                	beqz	a0,a52 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a28:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a2a:	4798                	lw	a4,8(a5)
 a2c:	02977f63          	bgeu	a4,s1,a6a <malloc+0x70>
 a30:	8a4e                	mv	s4,s3
 a32:	0009871b          	sext.w	a4,s3
 a36:	6685                	lui	a3,0x1
 a38:	00d77363          	bgeu	a4,a3,a3e <malloc+0x44>
 a3c:	6a05                	lui	s4,0x1
 a3e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a42:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a46:	00000917          	auipc	s2,0x0
 a4a:	10290913          	addi	s2,s2,258 # b48 <freep>
  if(p == (char*)-1)
 a4e:	5afd                	li	s5,-1
 a50:	a895                	j	ac4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a52:	00000797          	auipc	a5,0x0
 a56:	1ee78793          	addi	a5,a5,494 # c40 <base>
 a5a:	00000717          	auipc	a4,0x0
 a5e:	0ef73723          	sd	a5,238(a4) # b48 <freep>
 a62:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a64:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a68:	b7e1                	j	a30 <malloc+0x36>
      if(p->s.size == nunits)
 a6a:	02e48c63          	beq	s1,a4,aa2 <malloc+0xa8>
        p->s.size -= nunits;
 a6e:	4137073b          	subw	a4,a4,s3
 a72:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a74:	02071693          	slli	a3,a4,0x20
 a78:	01c6d713          	srli	a4,a3,0x1c
 a7c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a7e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a82:	00000717          	auipc	a4,0x0
 a86:	0ca73323          	sd	a0,198(a4) # b48 <freep>
      return (void*)(p + 1);
 a8a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a8e:	70e2                	ld	ra,56(sp)
 a90:	7442                	ld	s0,48(sp)
 a92:	74a2                	ld	s1,40(sp)
 a94:	7902                	ld	s2,32(sp)
 a96:	69e2                	ld	s3,24(sp)
 a98:	6a42                	ld	s4,16(sp)
 a9a:	6aa2                	ld	s5,8(sp)
 a9c:	6b02                	ld	s6,0(sp)
 a9e:	6121                	addi	sp,sp,64
 aa0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 aa2:	6398                	ld	a4,0(a5)
 aa4:	e118                	sd	a4,0(a0)
 aa6:	bff1                	j	a82 <malloc+0x88>
  hp->s.size = nu;
 aa8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aac:	0541                	addi	a0,a0,16
 aae:	00000097          	auipc	ra,0x0
 ab2:	ec4080e7          	jalr	-316(ra) # 972 <free>
  return freep;
 ab6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aba:	d971                	beqz	a0,a8e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 abc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 abe:	4798                	lw	a4,8(a5)
 ac0:	fa9775e3          	bgeu	a4,s1,a6a <malloc+0x70>
    if(p == freep)
 ac4:	00093703          	ld	a4,0(s2)
 ac8:	853e                	mv	a0,a5
 aca:	fef719e3          	bne	a4,a5,abc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ace:	8552                	mv	a0,s4
 ad0:	00000097          	auipc	ra,0x0
 ad4:	b74080e7          	jalr	-1164(ra) # 644 <sbrk>
  if(p == (char*)-1)
 ad8:	fd5518e3          	bne	a0,s5,aa8 <malloc+0xae>
        return 0;
 adc:	4501                	li	a0,0
 ade:	bf45                	j	a8e <malloc+0x94>
