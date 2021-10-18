
user/_ringtest:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "user/user.h"
#include "kernel/stat.h"


int main()
{
   0:	715d                	addi	sp,sp,-80
   2:	e486                	sd	ra,72(sp)
   4:	e0a2                	sd	s0,64(sp)
   6:	fc26                	sd	s1,56(sp)
   8:	f84a                	sd	s2,48(sp)
   a:	f44e                	sd	s3,40(sp)
   c:	f052                	sd	s4,32(sp)
   e:	0880                	addi	s0,sp,80
  uint64 addri = 0; // = (uint64 *)0;
  10:	fc043423          	sd	zero,-56(s0)
  uint64* addr = &addri;
  14:	fc840593          	addi	a1,s0,-56
  18:	fcb43023          	sd	a1,-64(s0)

  printf("before addr %d\n", addr);
  1c:	00001517          	auipc	a0,0x1
  20:	be450513          	addi	a0,a0,-1052 # c00 <malloc+0xe6>
  24:	00001097          	auipc	ra,0x1
  28:	a38080e7          	jalr	-1480(ra) # a5c <printf>
  int ring_desc = create_or_close_the_buffer_user("ring", 1, &addr);
  2c:	fc040613          	addi	a2,s0,-64
  30:	4585                	li	a1,1
  32:	00001517          	auipc	a0,0x1
  36:	bde50513          	addi	a0,a0,-1058 # c10 <malloc+0xf6>
  3a:	00000097          	auipc	ra,0x0
  3e:	21e080e7          	jalr	542(ra) # 258 <create_or_close_the_buffer_user>
  42:	892a                	mv	s2,a0
  // addr = (uint64 *)-155648;
  printf("after getting addr from kernel %d\nring_desc = %d\n", addr, ring_desc);
  44:	862a                	mv	a2,a0
  46:	fc043583          	ld	a1,-64(s0)
  4a:	00001517          	auipc	a0,0x1
  4e:	bce50513          	addi	a0,a0,-1074 # c18 <malloc+0xfe>
  52:	00001097          	auipc	ra,0x1
  56:	a0a080e7          	jalr	-1526(ra) # a5c <printf>

  int bytesi = 0; // = (int *) 0;
  5a:	fa042e23          	sw	zero,-68(s0)
  int *bytes = &bytesi;
  int bytes_want_to_read = 5;//(10485760/8);

  int start_time, elasped_time;
  start_time = uptime();
  5e:	00000097          	auipc	ra,0x0
  62:	716080e7          	jalr	1814(ra) # 774 <uptime>
  66:	89aa                	mv	s3,a0

  printf("before write addr %d\n", addr);
  68:	fc043583          	ld	a1,-64(s0)
  6c:	00001517          	auipc	a0,0x1
  70:	be450513          	addi	a0,a0,-1052 # c50 <malloc+0x136>
  74:	00001097          	auipc	ra,0x1
  78:	9e8080e7          	jalr	-1560(ra) # a5c <printf>
  printf("before write bytes %d\n", bytes);
  7c:	fbc40593          	addi	a1,s0,-68
  80:	00001517          	auipc	a0,0x1
  84:	be850513          	addi	a0,a0,-1048 # c68 <malloc+0x14e>
  88:	00001097          	auipc	ra,0x1
  8c:	9d4080e7          	jalr	-1580(ra) # a5c <printf>
//start here
  ringbuf_start_write(ring_desc, &addr, bytes);
  90:	fbc40613          	addi	a2,s0,-68
  94:	fc040593          	addi	a1,s0,-64
  98:	854a                	mv	a0,s2
  9a:	00000097          	auipc	ra,0x0
  9e:	27a080e7          	jalr	634(ra) # 314 <ringbuf_start_write>
  printf("after start_write addr %p\n", addr);
  a2:	fc043583          	ld	a1,-64(s0)
  a6:	00001517          	auipc	a0,0x1
  aa:	bda50513          	addi	a0,a0,-1062 # c80 <malloc+0x166>
  ae:	00001097          	auipc	ra,0x1
  b2:	9ae080e7          	jalr	-1618(ra) # a5c <printf>
  printf("after start_write bytes %d\n\n", *bytes);
  b6:	fbc42583          	lw	a1,-68(s0)
  ba:	00001517          	auipc	a0,0x1
  be:	be650513          	addi	a0,a0,-1050 # ca0 <malloc+0x186>
  c2:	00001097          	auipc	ra,0x1
  c6:	99a080e7          	jalr	-1638(ra) # a5c <printf>

  if(bytes_want_to_read < *bytes){
  ca:	fbc42583          	lw	a1,-68(s0)
  ce:	4795                	li	a5,5
  d0:	10b7de63          	bge	a5,a1,1ec <main+0x1ec>
    printf("begin loop %d\n",*bytes);
  d4:	00001517          	auipc	a0,0x1
  d8:	bec50513          	addi	a0,a0,-1044 # cc0 <malloc+0x1a6>
  dc:	00001097          	auipc	ra,0x1
  e0:	980080e7          	jalr	-1664(ra) # a5c <printf>
  e4:	4781                	li	a5,0
    for(int i=0; i < bytes_want_to_read; i++){
  e6:	4615                	li	a2,5
      addr[i] = i;
  e8:	00379693          	slli	a3,a5,0x3
  ec:	fc043703          	ld	a4,-64(s0)
  f0:	9736                	add	a4,a4,a3
  f2:	e31c                	sd	a5,0(a4)
    for(int i=0; i < bytes_want_to_read; i++){
  f4:	0785                	addi	a5,a5,1
  f6:	fec799e3          	bne	a5,a2,e8 <main+0xe8>
      // printf("i = %d, addr[i]= %d\n", i, addr[i]);
      // printf("written on address %d\n", addr + i);
    }
    ringbuf_finish_write(ring_desc, bytes_want_to_read);
  fa:	4595                	li	a1,5
  fc:	854a                	mv	a0,s2
  fe:	00000097          	auipc	ra,0x0
 102:	27e080e7          	jalr	638(ra) # 37c <ringbuf_finish_write>
      // printf("written on address %d\n", addr + i);
    }
    ringbuf_finish_write(ring_desc, *bytes);
  }

  printf("\n\n");
 106:	00001517          	auipc	a0,0x1
 10a:	bca50513          	addi	a0,a0,-1078 # cd0 <malloc+0x1b6>
 10e:	00001097          	auipc	ra,0x1
 112:	94e080e7          	jalr	-1714(ra) # a5c <printf>
  check_bytes_written(ring_desc, bytes);
 116:	fbc40593          	addi	a1,s0,-68
 11a:	854a                	mv	a0,s2
 11c:	00000097          	auipc	ra,0x0
 120:	292080e7          	jalr	658(ra) # 3ae <check_bytes_written>
  printf("after checking bytes written addr %d\n", *addr);
 124:	fc043783          	ld	a5,-64(s0)
 128:	638c                	ld	a1,0(a5)
 12a:	00001517          	auipc	a0,0x1
 12e:	bae50513          	addi	a0,a0,-1106 # cd8 <malloc+0x1be>
 132:	00001097          	auipc	ra,0x1
 136:	92a080e7          	jalr	-1750(ra) # a5c <printf>
  printf("after checking bytes written bytes %d\n", *bytes);
 13a:	fbc42583          	lw	a1,-68(s0)
 13e:	00001517          	auipc	a0,0x1
 142:	bc250513          	addi	a0,a0,-1086 # d00 <malloc+0x1e6>
 146:	00001097          	auipc	ra,0x1
 14a:	916080e7          	jalr	-1770(ra) # a5c <printf>

  ringbuf_start_read(ring_desc, addr, bytes);
 14e:	fbc40613          	addi	a2,s0,-68
 152:	fc043583          	ld	a1,-64(s0)
 156:	854a                	mv	a0,s2
 158:	00000097          	auipc	ra,0x0
 15c:	28c080e7          	jalr	652(ra) # 3e4 <ringbuf_start_read>
  // printf("\nThe data written is shown below\n");
  for(int i=0; i < *bytes; i++){
 160:	fbc42583          	lw	a1,-68(s0)
 164:	02b05963          	blez	a1,196 <main+0x196>
 168:	4481                	li	s1,0
    printf("%d ", addr[i]);
 16a:	00001a17          	auipc	s4,0x1
 16e:	bbea0a13          	addi	s4,s4,-1090 # d28 <malloc+0x20e>
 172:	00349713          	slli	a4,s1,0x3
 176:	fc043783          	ld	a5,-64(s0)
 17a:	97ba                	add	a5,a5,a4
 17c:	638c                	ld	a1,0(a5)
 17e:	8552                	mv	a0,s4
 180:	00001097          	auipc	ra,0x1
 184:	8dc080e7          	jalr	-1828(ra) # a5c <printf>
  for(int i=0; i < *bytes; i++){
 188:	fbc42583          	lw	a1,-68(s0)
 18c:	0485                	addi	s1,s1,1
 18e:	0004879b          	sext.w	a5,s1
 192:	feb7c0e3          	blt	a5,a1,172 <main+0x172>
  }
  ringbuf_finish_read(ring_desc, *bytes);
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	2a6080e7          	jalr	678(ra) # 43e <ringbuf_finish_read>
  printf("\n\n");
 1a0:	00001517          	auipc	a0,0x1
 1a4:	b3050513          	addi	a0,a0,-1232 # cd0 <malloc+0x1b6>
 1a8:	00001097          	auipc	ra,0x1
 1ac:	8b4080e7          	jalr	-1868(ra) # a5c <printf>

  elasped_time = uptime()-start_time;
 1b0:	00000097          	auipc	ra,0x0
 1b4:	5c4080e7          	jalr	1476(ra) # 774 <uptime>
  printf("Elasped time is %d\n\n", elasped_time);
 1b8:	413505bb          	subw	a1,a0,s3
 1bc:	00001517          	auipc	a0,0x1
 1c0:	b7450513          	addi	a0,a0,-1164 # d30 <malloc+0x216>
 1c4:	00001097          	auipc	ra,0x1
 1c8:	898080e7          	jalr	-1896(ra) # a5c <printf>

  create_or_close_the_buffer_user("ring", 0, &addr);
 1cc:	fc040613          	addi	a2,s0,-64
 1d0:	4581                	li	a1,0
 1d2:	00001517          	auipc	a0,0x1
 1d6:	a3e50513          	addi	a0,a0,-1474 # c10 <malloc+0xf6>
 1da:	00000097          	auipc	ra,0x0
 1de:	07e080e7          	jalr	126(ra) # 258 <create_or_close_the_buffer_user>

  exit(0);
 1e2:	4501                	li	a0,0
 1e4:	00000097          	auipc	ra,0x0
 1e8:	4f8080e7          	jalr	1272(ra) # 6dc <exit>
    printf("begin loop %d\n",*bytes);
 1ec:	00001517          	auipc	a0,0x1
 1f0:	ad450513          	addi	a0,a0,-1324 # cc0 <malloc+0x1a6>
 1f4:	00001097          	auipc	ra,0x1
 1f8:	868080e7          	jalr	-1944(ra) # a5c <printf>
    for(int i=0; i < *bytes; i++){
 1fc:	fbc42583          	lw	a1,-68(s0)
 200:	02b05063          	blez	a1,220 <main+0x220>
 204:	4781                	li	a5,0
      addr[i] = i;
 206:	00379693          	slli	a3,a5,0x3
 20a:	fc043703          	ld	a4,-64(s0)
 20e:	9736                	add	a4,a4,a3
 210:	e31c                	sd	a5,0(a4)
    for(int i=0; i < *bytes; i++){
 212:	fbc42583          	lw	a1,-68(s0)
 216:	0785                	addi	a5,a5,1
 218:	0007871b          	sext.w	a4,a5
 21c:	feb745e3          	blt	a4,a1,206 <main+0x206>
    ringbuf_finish_write(ring_desc, *bytes);
 220:	854a                	mv	a0,s2
 222:	00000097          	auipc	ra,0x0
 226:	15a080e7          	jalr	346(ra) # 37c <ringbuf_finish_write>
 22a:	bdf1                	j	106 <main+0x106>

000000000000022c <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 22c:	1141                	addi	sp,sp,-16
 22e:	e422                	sd	s0,8(sp)
 230:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 232:	0f50000f          	fence	iorw,ow
 236:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret

0000000000000240 <load>:

int load(uint64 *p) {
 240:	1141                	addi	sp,sp,-16
 242:	e422                	sd	s0,8(sp)
 244:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 246:	0ff0000f          	fence
 24a:	6108                	ld	a0,0(a0)
 24c:	0ff0000f          	fence
}
 250:	2501                	sext.w	a0,a0
 252:	6422                	ld	s0,8(sp)
 254:	0141                	addi	sp,sp,16
 256:	8082                	ret

0000000000000258 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 258:	7139                	addi	sp,sp,-64
 25a:	fc06                	sd	ra,56(sp)
 25c:	f822                	sd	s0,48(sp)
 25e:	f426                	sd	s1,40(sp)
 260:	f04a                	sd	s2,32(sp)
 262:	ec4e                	sd	s3,24(sp)
 264:	e852                	sd	s4,16(sp)
 266:	e456                	sd	s5,8(sp)
 268:	e05a                	sd	s6,0(sp)
 26a:	0080                	addi	s0,sp,64
 26c:	8a2a                	mv	s4,a0
 26e:	89ae                	mv	s3,a1
 270:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 272:	4785                	li	a5,1
 274:	00001497          	auipc	s1,0x1
 278:	b0c48493          	addi	s1,s1,-1268 # d80 <rings+0x8>
 27c:	00001917          	auipc	s2,0x1
 280:	bf490913          	addi	s2,s2,-1036 # e70 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 284:	00001b17          	auipc	s6,0x1
 288:	ae4b0b13          	addi	s6,s6,-1308 # d68 <vm_addr>
  if(open_close == 1){
 28c:	04f59063          	bne	a1,a5,2cc <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 290:	00001497          	auipc	s1,0x1
 294:	af84a483          	lw	s1,-1288(s1) # d88 <rings+0x10>
 298:	c099                	beqz	s1,29e <create_or_close_the_buffer_user+0x46>
 29a:	4481                	li	s1,0
 29c:	a899                	j	2f2 <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 29e:	865a                	mv	a2,s6
 2a0:	4585                	li	a1,1
 2a2:	00000097          	auipc	ra,0x0
 2a6:	4da080e7          	jalr	1242(ra) # 77c <ringbuf>
        rings[i].book->write_done = 0;
 2aa:	00001797          	auipc	a5,0x1
 2ae:	ace78793          	addi	a5,a5,-1330 # d78 <rings>
 2b2:	6798                	ld	a4,8(a5)
 2b4:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 2b8:	6798                	ld	a4,8(a5)
 2ba:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 2be:	4b98                	lw	a4,16(a5)
 2c0:	2705                	addiw	a4,a4,1
 2c2:	cb98                	sw	a4,16(a5)
        break;
 2c4:	a03d                	j	2f2 <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 2c6:	04e1                	addi	s1,s1,24
 2c8:	03248463          	beq	s1,s2,2f0 <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 2cc:	449c                	lw	a5,8(s1)
 2ce:	dfe5                	beqz	a5,2c6 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 2d0:	865a                	mv	a2,s6
 2d2:	85ce                	mv	a1,s3
 2d4:	8552                	mv	a0,s4
 2d6:	00000097          	auipc	ra,0x0
 2da:	4a6080e7          	jalr	1190(ra) # 77c <ringbuf>
        rings[i].book->write_done = 0;
 2de:	609c                	ld	a5,0(s1)
 2e0:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 2e4:	609c                	ld	a5,0(s1)
 2e6:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 2ea:	0004a423          	sw	zero,8(s1)
 2ee:	bfe1                	j	2c6 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 2f0:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 2f2:	00001797          	auipc	a5,0x1
 2f6:	a767b783          	ld	a5,-1418(a5) # d68 <vm_addr>
 2fa:	00fab023          	sd	a5,0(s5)
  return i;
}
 2fe:	8526                	mv	a0,s1
 300:	70e2                	ld	ra,56(sp)
 302:	7442                	ld	s0,48(sp)
 304:	74a2                	ld	s1,40(sp)
 306:	7902                	ld	s2,32(sp)
 308:	69e2                	ld	s3,24(sp)
 30a:	6a42                	ld	s4,16(sp)
 30c:	6aa2                	ld	s5,8(sp)
 30e:	6b02                	ld	s6,0(sp)
 310:	6121                	addi	sp,sp,64
 312:	8082                	ret

0000000000000314 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 314:	1101                	addi	sp,sp,-32
 316:	ec06                	sd	ra,24(sp)
 318:	e822                	sd	s0,16(sp)
 31a:	e426                	sd	s1,8(sp)
 31c:	1000                	addi	s0,sp,32
 31e:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 320:	00001797          	auipc	a5,0x1
 324:	a487b783          	ld	a5,-1464(a5) # d68 <vm_addr>
 328:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 32a:	421c                	lw	a5,0(a2)
 32c:	e79d                	bnez	a5,35a <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 32e:	00001697          	auipc	a3,0x1
 332:	a4a68693          	addi	a3,a3,-1462 # d78 <rings>
 336:	669c                	ld	a5,8(a3)
 338:	6398                	ld	a4,0(a5)
 33a:	67c1                	lui	a5,0x10
 33c:	9fb9                	addw	a5,a5,a4
 33e:	00151713          	slli	a4,a0,0x1
 342:	953a                	add	a0,a0,a4
 344:	050e                	slli	a0,a0,0x3
 346:	9536                	add	a0,a0,a3
 348:	6518                	ld	a4,8(a0)
 34a:	6718                	ld	a4,8(a4)
 34c:	9f99                	subw	a5,a5,a4
 34e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 350:	60e2                	ld	ra,24(sp)
 352:	6442                	ld	s0,16(sp)
 354:	64a2                	ld	s1,8(sp)
 356:	6105                	addi	sp,sp,32
 358:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 35a:	00151793          	slli	a5,a0,0x1
 35e:	953e                	add	a0,a0,a5
 360:	050e                	slli	a0,a0,0x3
 362:	00001797          	auipc	a5,0x1
 366:	a1678793          	addi	a5,a5,-1514 # d78 <rings>
 36a:	953e                	add	a0,a0,a5
 36c:	6508                	ld	a0,8(a0)
 36e:	0521                	addi	a0,a0,8
 370:	00000097          	auipc	ra,0x0
 374:	ed0080e7          	jalr	-304(ra) # 240 <load>
 378:	c088                	sw	a0,0(s1)
}
 37a:	bfd9                	j	350 <ringbuf_start_write+0x3c>

000000000000037c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 37c:	1141                	addi	sp,sp,-16
 37e:	e406                	sd	ra,8(sp)
 380:	e022                	sd	s0,0(sp)
 382:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 384:	00151793          	slli	a5,a0,0x1
 388:	97aa                	add	a5,a5,a0
 38a:	078e                	slli	a5,a5,0x3
 38c:	00001517          	auipc	a0,0x1
 390:	9ec50513          	addi	a0,a0,-1556 # d78 <rings>
 394:	97aa                	add	a5,a5,a0
 396:	6788                	ld	a0,8(a5)
 398:	0035959b          	slliw	a1,a1,0x3
 39c:	0521                	addi	a0,a0,8
 39e:	00000097          	auipc	ra,0x0
 3a2:	e8e080e7          	jalr	-370(ra) # 22c <store>
}
 3a6:	60a2                	ld	ra,8(sp)
 3a8:	6402                	ld	s0,0(sp)
 3aa:	0141                	addi	sp,sp,16
 3ac:	8082                	ret

00000000000003ae <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 3ae:	1101                	addi	sp,sp,-32
 3b0:	ec06                	sd	ra,24(sp)
 3b2:	e822                	sd	s0,16(sp)
 3b4:	e426                	sd	s1,8(sp)
 3b6:	1000                	addi	s0,sp,32
 3b8:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 3ba:	00151793          	slli	a5,a0,0x1
 3be:	97aa                	add	a5,a5,a0
 3c0:	078e                	slli	a5,a5,0x3
 3c2:	00001517          	auipc	a0,0x1
 3c6:	9b650513          	addi	a0,a0,-1610 # d78 <rings>
 3ca:	97aa                	add	a5,a5,a0
 3cc:	6788                	ld	a0,8(a5)
 3ce:	0521                	addi	a0,a0,8
 3d0:	00000097          	auipc	ra,0x0
 3d4:	e70080e7          	jalr	-400(ra) # 240 <load>
 3d8:	c088                	sw	a0,0(s1)
}
 3da:	60e2                	ld	ra,24(sp)
 3dc:	6442                	ld	s0,16(sp)
 3de:	64a2                	ld	s1,8(sp)
 3e0:	6105                	addi	sp,sp,32
 3e2:	8082                	ret

00000000000003e4 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 3e4:	1101                	addi	sp,sp,-32
 3e6:	ec06                	sd	ra,24(sp)
 3e8:	e822                	sd	s0,16(sp)
 3ea:	e426                	sd	s1,8(sp)
 3ec:	1000                	addi	s0,sp,32
 3ee:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 3f0:	00151793          	slli	a5,a0,0x1
 3f4:	97aa                	add	a5,a5,a0
 3f6:	078e                	slli	a5,a5,0x3
 3f8:	00001517          	auipc	a0,0x1
 3fc:	98050513          	addi	a0,a0,-1664 # d78 <rings>
 400:	97aa                	add	a5,a5,a0
 402:	6788                	ld	a0,8(a5)
 404:	611c                	ld	a5,0(a0)
 406:	ef99                	bnez	a5,424 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 408:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 40a:	41f7579b          	sraiw	a5,a4,0x1f
 40e:	01d7d79b          	srliw	a5,a5,0x1d
 412:	9fb9                	addw	a5,a5,a4
 414:	4037d79b          	sraiw	a5,a5,0x3
 418:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 41a:	60e2                	ld	ra,24(sp)
 41c:	6442                	ld	s0,16(sp)
 41e:	64a2                	ld	s1,8(sp)
 420:	6105                	addi	sp,sp,32
 422:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 424:	00000097          	auipc	ra,0x0
 428:	e1c080e7          	jalr	-484(ra) # 240 <load>
    *bytes /= 8;
 42c:	41f5579b          	sraiw	a5,a0,0x1f
 430:	01d7d79b          	srliw	a5,a5,0x1d
 434:	9d3d                	addw	a0,a0,a5
 436:	4035551b          	sraiw	a0,a0,0x3
 43a:	c088                	sw	a0,0(s1)
}
 43c:	bff9                	j	41a <ringbuf_start_read+0x36>

000000000000043e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 43e:	1141                	addi	sp,sp,-16
 440:	e406                	sd	ra,8(sp)
 442:	e022                	sd	s0,0(sp)
 444:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 446:	00151793          	slli	a5,a0,0x1
 44a:	97aa                	add	a5,a5,a0
 44c:	078e                	slli	a5,a5,0x3
 44e:	00001517          	auipc	a0,0x1
 452:	92a50513          	addi	a0,a0,-1750 # d78 <rings>
 456:	97aa                	add	a5,a5,a0
 458:	0035959b          	slliw	a1,a1,0x3
 45c:	6788                	ld	a0,8(a5)
 45e:	00000097          	auipc	ra,0x0
 462:	dce080e7          	jalr	-562(ra) # 22c <store>
}
 466:	60a2                	ld	ra,8(sp)
 468:	6402                	ld	s0,0(sp)
 46a:	0141                	addi	sp,sp,16
 46c:	8082                	ret

000000000000046e <strcpy>:



char*
strcpy(char *s, const char *t)
{
 46e:	1141                	addi	sp,sp,-16
 470:	e422                	sd	s0,8(sp)
 472:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 474:	87aa                	mv	a5,a0
 476:	0585                	addi	a1,a1,1
 478:	0785                	addi	a5,a5,1
 47a:	fff5c703          	lbu	a4,-1(a1)
 47e:	fee78fa3          	sb	a4,-1(a5)
 482:	fb75                	bnez	a4,476 <strcpy+0x8>
    ;
  return os;
}
 484:	6422                	ld	s0,8(sp)
 486:	0141                	addi	sp,sp,16
 488:	8082                	ret

000000000000048a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 48a:	1141                	addi	sp,sp,-16
 48c:	e422                	sd	s0,8(sp)
 48e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 490:	00054783          	lbu	a5,0(a0)
 494:	cb91                	beqz	a5,4a8 <strcmp+0x1e>
 496:	0005c703          	lbu	a4,0(a1)
 49a:	00f71763          	bne	a4,a5,4a8 <strcmp+0x1e>
    p++, q++;
 49e:	0505                	addi	a0,a0,1
 4a0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 4a2:	00054783          	lbu	a5,0(a0)
 4a6:	fbe5                	bnez	a5,496 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 4a8:	0005c503          	lbu	a0,0(a1)
}
 4ac:	40a7853b          	subw	a0,a5,a0
 4b0:	6422                	ld	s0,8(sp)
 4b2:	0141                	addi	sp,sp,16
 4b4:	8082                	ret

00000000000004b6 <strlen>:

uint
strlen(const char *s)
{
 4b6:	1141                	addi	sp,sp,-16
 4b8:	e422                	sd	s0,8(sp)
 4ba:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 4bc:	00054783          	lbu	a5,0(a0)
 4c0:	cf91                	beqz	a5,4dc <strlen+0x26>
 4c2:	0505                	addi	a0,a0,1
 4c4:	87aa                	mv	a5,a0
 4c6:	4685                	li	a3,1
 4c8:	9e89                	subw	a3,a3,a0
 4ca:	00f6853b          	addw	a0,a3,a5
 4ce:	0785                	addi	a5,a5,1
 4d0:	fff7c703          	lbu	a4,-1(a5)
 4d4:	fb7d                	bnez	a4,4ca <strlen+0x14>
    ;
  return n;
}
 4d6:	6422                	ld	s0,8(sp)
 4d8:	0141                	addi	sp,sp,16
 4da:	8082                	ret
  for(n = 0; s[n]; n++)
 4dc:	4501                	li	a0,0
 4de:	bfe5                	j	4d6 <strlen+0x20>

00000000000004e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 4e0:	1141                	addi	sp,sp,-16
 4e2:	e422                	sd	s0,8(sp)
 4e4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4e6:	ca19                	beqz	a2,4fc <memset+0x1c>
 4e8:	87aa                	mv	a5,a0
 4ea:	1602                	slli	a2,a2,0x20
 4ec:	9201                	srli	a2,a2,0x20
 4ee:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4f2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4f6:	0785                	addi	a5,a5,1
 4f8:	fee79de3          	bne	a5,a4,4f2 <memset+0x12>
  }
  return dst;
}
 4fc:	6422                	ld	s0,8(sp)
 4fe:	0141                	addi	sp,sp,16
 500:	8082                	ret

0000000000000502 <strchr>:

char*
strchr(const char *s, char c)
{
 502:	1141                	addi	sp,sp,-16
 504:	e422                	sd	s0,8(sp)
 506:	0800                	addi	s0,sp,16
  for(; *s; s++)
 508:	00054783          	lbu	a5,0(a0)
 50c:	cb99                	beqz	a5,522 <strchr+0x20>
    if(*s == c)
 50e:	00f58763          	beq	a1,a5,51c <strchr+0x1a>
  for(; *s; s++)
 512:	0505                	addi	a0,a0,1
 514:	00054783          	lbu	a5,0(a0)
 518:	fbfd                	bnez	a5,50e <strchr+0xc>
      return (char*)s;
  return 0;
 51a:	4501                	li	a0,0
}
 51c:	6422                	ld	s0,8(sp)
 51e:	0141                	addi	sp,sp,16
 520:	8082                	ret
  return 0;
 522:	4501                	li	a0,0
 524:	bfe5                	j	51c <strchr+0x1a>

0000000000000526 <gets>:

char*
gets(char *buf, int max)
{
 526:	711d                	addi	sp,sp,-96
 528:	ec86                	sd	ra,88(sp)
 52a:	e8a2                	sd	s0,80(sp)
 52c:	e4a6                	sd	s1,72(sp)
 52e:	e0ca                	sd	s2,64(sp)
 530:	fc4e                	sd	s3,56(sp)
 532:	f852                	sd	s4,48(sp)
 534:	f456                	sd	s5,40(sp)
 536:	f05a                	sd	s6,32(sp)
 538:	ec5e                	sd	s7,24(sp)
 53a:	1080                	addi	s0,sp,96
 53c:	8baa                	mv	s7,a0
 53e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 540:	892a                	mv	s2,a0
 542:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 544:	4aa9                	li	s5,10
 546:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 548:	89a6                	mv	s3,s1
 54a:	2485                	addiw	s1,s1,1
 54c:	0344d863          	bge	s1,s4,57c <gets+0x56>
    cc = read(0, &c, 1);
 550:	4605                	li	a2,1
 552:	faf40593          	addi	a1,s0,-81
 556:	4501                	li	a0,0
 558:	00000097          	auipc	ra,0x0
 55c:	19c080e7          	jalr	412(ra) # 6f4 <read>
    if(cc < 1)
 560:	00a05e63          	blez	a0,57c <gets+0x56>
    buf[i++] = c;
 564:	faf44783          	lbu	a5,-81(s0)
 568:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 56c:	01578763          	beq	a5,s5,57a <gets+0x54>
 570:	0905                	addi	s2,s2,1
 572:	fd679be3          	bne	a5,s6,548 <gets+0x22>
  for(i=0; i+1 < max; ){
 576:	89a6                	mv	s3,s1
 578:	a011                	j	57c <gets+0x56>
 57a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 57c:	99de                	add	s3,s3,s7
 57e:	00098023          	sb	zero,0(s3)
  return buf;
}
 582:	855e                	mv	a0,s7
 584:	60e6                	ld	ra,88(sp)
 586:	6446                	ld	s0,80(sp)
 588:	64a6                	ld	s1,72(sp)
 58a:	6906                	ld	s2,64(sp)
 58c:	79e2                	ld	s3,56(sp)
 58e:	7a42                	ld	s4,48(sp)
 590:	7aa2                	ld	s5,40(sp)
 592:	7b02                	ld	s6,32(sp)
 594:	6be2                	ld	s7,24(sp)
 596:	6125                	addi	sp,sp,96
 598:	8082                	ret

000000000000059a <stat>:

int
stat(const char *n, struct stat *st)
{
 59a:	1101                	addi	sp,sp,-32
 59c:	ec06                	sd	ra,24(sp)
 59e:	e822                	sd	s0,16(sp)
 5a0:	e426                	sd	s1,8(sp)
 5a2:	e04a                	sd	s2,0(sp)
 5a4:	1000                	addi	s0,sp,32
 5a6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 5a8:	4581                	li	a1,0
 5aa:	00000097          	auipc	ra,0x0
 5ae:	172080e7          	jalr	370(ra) # 71c <open>
  if(fd < 0)
 5b2:	02054563          	bltz	a0,5dc <stat+0x42>
 5b6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 5b8:	85ca                	mv	a1,s2
 5ba:	00000097          	auipc	ra,0x0
 5be:	17a080e7          	jalr	378(ra) # 734 <fstat>
 5c2:	892a                	mv	s2,a0
  close(fd);
 5c4:	8526                	mv	a0,s1
 5c6:	00000097          	auipc	ra,0x0
 5ca:	13e080e7          	jalr	318(ra) # 704 <close>
  return r;
}
 5ce:	854a                	mv	a0,s2
 5d0:	60e2                	ld	ra,24(sp)
 5d2:	6442                	ld	s0,16(sp)
 5d4:	64a2                	ld	s1,8(sp)
 5d6:	6902                	ld	s2,0(sp)
 5d8:	6105                	addi	sp,sp,32
 5da:	8082                	ret
    return -1;
 5dc:	597d                	li	s2,-1
 5de:	bfc5                	j	5ce <stat+0x34>

00000000000005e0 <atoi>:

int
atoi(const char *s)
{
 5e0:	1141                	addi	sp,sp,-16
 5e2:	e422                	sd	s0,8(sp)
 5e4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5e6:	00054603          	lbu	a2,0(a0)
 5ea:	fd06079b          	addiw	a5,a2,-48
 5ee:	0ff7f793          	zext.b	a5,a5
 5f2:	4725                	li	a4,9
 5f4:	02f76963          	bltu	a4,a5,626 <atoi+0x46>
 5f8:	86aa                	mv	a3,a0
  n = 0;
 5fa:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 5fc:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 5fe:	0685                	addi	a3,a3,1
 600:	0025179b          	slliw	a5,a0,0x2
 604:	9fa9                	addw	a5,a5,a0
 606:	0017979b          	slliw	a5,a5,0x1
 60a:	9fb1                	addw	a5,a5,a2
 60c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 610:	0006c603          	lbu	a2,0(a3)
 614:	fd06071b          	addiw	a4,a2,-48
 618:	0ff77713          	zext.b	a4,a4
 61c:	fee5f1e3          	bgeu	a1,a4,5fe <atoi+0x1e>
  return n;
}
 620:	6422                	ld	s0,8(sp)
 622:	0141                	addi	sp,sp,16
 624:	8082                	ret
  n = 0;
 626:	4501                	li	a0,0
 628:	bfe5                	j	620 <atoi+0x40>

000000000000062a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 62a:	1141                	addi	sp,sp,-16
 62c:	e422                	sd	s0,8(sp)
 62e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 630:	02b57463          	bgeu	a0,a1,658 <memmove+0x2e>
    while(n-- > 0)
 634:	00c05f63          	blez	a2,652 <memmove+0x28>
 638:	1602                	slli	a2,a2,0x20
 63a:	9201                	srli	a2,a2,0x20
 63c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 640:	872a                	mv	a4,a0
      *dst++ = *src++;
 642:	0585                	addi	a1,a1,1
 644:	0705                	addi	a4,a4,1
 646:	fff5c683          	lbu	a3,-1(a1)
 64a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 64e:	fee79ae3          	bne	a5,a4,642 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 652:	6422                	ld	s0,8(sp)
 654:	0141                	addi	sp,sp,16
 656:	8082                	ret
    dst += n;
 658:	00c50733          	add	a4,a0,a2
    src += n;
 65c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 65e:	fec05ae3          	blez	a2,652 <memmove+0x28>
 662:	fff6079b          	addiw	a5,a2,-1
 666:	1782                	slli	a5,a5,0x20
 668:	9381                	srli	a5,a5,0x20
 66a:	fff7c793          	not	a5,a5
 66e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 670:	15fd                	addi	a1,a1,-1
 672:	177d                	addi	a4,a4,-1
 674:	0005c683          	lbu	a3,0(a1)
 678:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 67c:	fee79ae3          	bne	a5,a4,670 <memmove+0x46>
 680:	bfc9                	j	652 <memmove+0x28>

0000000000000682 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 682:	1141                	addi	sp,sp,-16
 684:	e422                	sd	s0,8(sp)
 686:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 688:	ca05                	beqz	a2,6b8 <memcmp+0x36>
 68a:	fff6069b          	addiw	a3,a2,-1
 68e:	1682                	slli	a3,a3,0x20
 690:	9281                	srli	a3,a3,0x20
 692:	0685                	addi	a3,a3,1
 694:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 696:	00054783          	lbu	a5,0(a0)
 69a:	0005c703          	lbu	a4,0(a1)
 69e:	00e79863          	bne	a5,a4,6ae <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 6a2:	0505                	addi	a0,a0,1
    p2++;
 6a4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 6a6:	fed518e3          	bne	a0,a3,696 <memcmp+0x14>
  }
  return 0;
 6aa:	4501                	li	a0,0
 6ac:	a019                	j	6b2 <memcmp+0x30>
      return *p1 - *p2;
 6ae:	40e7853b          	subw	a0,a5,a4
}
 6b2:	6422                	ld	s0,8(sp)
 6b4:	0141                	addi	sp,sp,16
 6b6:	8082                	ret
  return 0;
 6b8:	4501                	li	a0,0
 6ba:	bfe5                	j	6b2 <memcmp+0x30>

00000000000006bc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 6bc:	1141                	addi	sp,sp,-16
 6be:	e406                	sd	ra,8(sp)
 6c0:	e022                	sd	s0,0(sp)
 6c2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 6c4:	00000097          	auipc	ra,0x0
 6c8:	f66080e7          	jalr	-154(ra) # 62a <memmove>
}
 6cc:	60a2                	ld	ra,8(sp)
 6ce:	6402                	ld	s0,0(sp)
 6d0:	0141                	addi	sp,sp,16
 6d2:	8082                	ret

00000000000006d4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6d4:	4885                	li	a7,1
 ecall
 6d6:	00000073          	ecall
 ret
 6da:	8082                	ret

00000000000006dc <exit>:
.global exit
exit:
 li a7, SYS_exit
 6dc:	4889                	li	a7,2
 ecall
 6de:	00000073          	ecall
 ret
 6e2:	8082                	ret

00000000000006e4 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6e4:	488d                	li	a7,3
 ecall
 6e6:	00000073          	ecall
 ret
 6ea:	8082                	ret

00000000000006ec <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6ec:	4891                	li	a7,4
 ecall
 6ee:	00000073          	ecall
 ret
 6f2:	8082                	ret

00000000000006f4 <read>:
.global read
read:
 li a7, SYS_read
 6f4:	4895                	li	a7,5
 ecall
 6f6:	00000073          	ecall
 ret
 6fa:	8082                	ret

00000000000006fc <write>:
.global write
write:
 li a7, SYS_write
 6fc:	48c1                	li	a7,16
 ecall
 6fe:	00000073          	ecall
 ret
 702:	8082                	ret

0000000000000704 <close>:
.global close
close:
 li a7, SYS_close
 704:	48d5                	li	a7,21
 ecall
 706:	00000073          	ecall
 ret
 70a:	8082                	ret

000000000000070c <kill>:
.global kill
kill:
 li a7, SYS_kill
 70c:	4899                	li	a7,6
 ecall
 70e:	00000073          	ecall
 ret
 712:	8082                	ret

0000000000000714 <exec>:
.global exec
exec:
 li a7, SYS_exec
 714:	489d                	li	a7,7
 ecall
 716:	00000073          	ecall
 ret
 71a:	8082                	ret

000000000000071c <open>:
.global open
open:
 li a7, SYS_open
 71c:	48bd                	li	a7,15
 ecall
 71e:	00000073          	ecall
 ret
 722:	8082                	ret

0000000000000724 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 724:	48c5                	li	a7,17
 ecall
 726:	00000073          	ecall
 ret
 72a:	8082                	ret

000000000000072c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 72c:	48c9                	li	a7,18
 ecall
 72e:	00000073          	ecall
 ret
 732:	8082                	ret

0000000000000734 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 734:	48a1                	li	a7,8
 ecall
 736:	00000073          	ecall
 ret
 73a:	8082                	ret

000000000000073c <link>:
.global link
link:
 li a7, SYS_link
 73c:	48cd                	li	a7,19
 ecall
 73e:	00000073          	ecall
 ret
 742:	8082                	ret

0000000000000744 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 744:	48d1                	li	a7,20
 ecall
 746:	00000073          	ecall
 ret
 74a:	8082                	ret

000000000000074c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 74c:	48a5                	li	a7,9
 ecall
 74e:	00000073          	ecall
 ret
 752:	8082                	ret

0000000000000754 <dup>:
.global dup
dup:
 li a7, SYS_dup
 754:	48a9                	li	a7,10
 ecall
 756:	00000073          	ecall
 ret
 75a:	8082                	ret

000000000000075c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 75c:	48ad                	li	a7,11
 ecall
 75e:	00000073          	ecall
 ret
 762:	8082                	ret

0000000000000764 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 764:	48b1                	li	a7,12
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 76c:	48b5                	li	a7,13
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 774:	48b9                	li	a7,14
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 77c:	48d9                	li	a7,22
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 784:	1101                	addi	sp,sp,-32
 786:	ec06                	sd	ra,24(sp)
 788:	e822                	sd	s0,16(sp)
 78a:	1000                	addi	s0,sp,32
 78c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 790:	4605                	li	a2,1
 792:	fef40593          	addi	a1,s0,-17
 796:	00000097          	auipc	ra,0x0
 79a:	f66080e7          	jalr	-154(ra) # 6fc <write>
}
 79e:	60e2                	ld	ra,24(sp)
 7a0:	6442                	ld	s0,16(sp)
 7a2:	6105                	addi	sp,sp,32
 7a4:	8082                	ret

00000000000007a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7a6:	7139                	addi	sp,sp,-64
 7a8:	fc06                	sd	ra,56(sp)
 7aa:	f822                	sd	s0,48(sp)
 7ac:	f426                	sd	s1,40(sp)
 7ae:	f04a                	sd	s2,32(sp)
 7b0:	ec4e                	sd	s3,24(sp)
 7b2:	0080                	addi	s0,sp,64
 7b4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7b6:	c299                	beqz	a3,7bc <printint+0x16>
 7b8:	0805c863          	bltz	a1,848 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 7bc:	2581                	sext.w	a1,a1
  neg = 0;
 7be:	4881                	li	a7,0
 7c0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 7c4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 7c6:	2601                	sext.w	a2,a2
 7c8:	00000517          	auipc	a0,0x0
 7cc:	58850513          	addi	a0,a0,1416 # d50 <digits>
 7d0:	883a                	mv	a6,a4
 7d2:	2705                	addiw	a4,a4,1
 7d4:	02c5f7bb          	remuw	a5,a1,a2
 7d8:	1782                	slli	a5,a5,0x20
 7da:	9381                	srli	a5,a5,0x20
 7dc:	97aa                	add	a5,a5,a0
 7de:	0007c783          	lbu	a5,0(a5)
 7e2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7e6:	0005879b          	sext.w	a5,a1
 7ea:	02c5d5bb          	divuw	a1,a1,a2
 7ee:	0685                	addi	a3,a3,1
 7f0:	fec7f0e3          	bgeu	a5,a2,7d0 <printint+0x2a>
  if(neg)
 7f4:	00088b63          	beqz	a7,80a <printint+0x64>
    buf[i++] = '-';
 7f8:	fd040793          	addi	a5,s0,-48
 7fc:	973e                	add	a4,a4,a5
 7fe:	02d00793          	li	a5,45
 802:	fef70823          	sb	a5,-16(a4)
 806:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 80a:	02e05863          	blez	a4,83a <printint+0x94>
 80e:	fc040793          	addi	a5,s0,-64
 812:	00e78933          	add	s2,a5,a4
 816:	fff78993          	addi	s3,a5,-1
 81a:	99ba                	add	s3,s3,a4
 81c:	377d                	addiw	a4,a4,-1
 81e:	1702                	slli	a4,a4,0x20
 820:	9301                	srli	a4,a4,0x20
 822:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 826:	fff94583          	lbu	a1,-1(s2)
 82a:	8526                	mv	a0,s1
 82c:	00000097          	auipc	ra,0x0
 830:	f58080e7          	jalr	-168(ra) # 784 <putc>
  while(--i >= 0)
 834:	197d                	addi	s2,s2,-1
 836:	ff3918e3          	bne	s2,s3,826 <printint+0x80>
}
 83a:	70e2                	ld	ra,56(sp)
 83c:	7442                	ld	s0,48(sp)
 83e:	74a2                	ld	s1,40(sp)
 840:	7902                	ld	s2,32(sp)
 842:	69e2                	ld	s3,24(sp)
 844:	6121                	addi	sp,sp,64
 846:	8082                	ret
    x = -xx;
 848:	40b005bb          	negw	a1,a1
    neg = 1;
 84c:	4885                	li	a7,1
    x = -xx;
 84e:	bf8d                	j	7c0 <printint+0x1a>

0000000000000850 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 850:	7119                	addi	sp,sp,-128
 852:	fc86                	sd	ra,120(sp)
 854:	f8a2                	sd	s0,112(sp)
 856:	f4a6                	sd	s1,104(sp)
 858:	f0ca                	sd	s2,96(sp)
 85a:	ecce                	sd	s3,88(sp)
 85c:	e8d2                	sd	s4,80(sp)
 85e:	e4d6                	sd	s5,72(sp)
 860:	e0da                	sd	s6,64(sp)
 862:	fc5e                	sd	s7,56(sp)
 864:	f862                	sd	s8,48(sp)
 866:	f466                	sd	s9,40(sp)
 868:	f06a                	sd	s10,32(sp)
 86a:	ec6e                	sd	s11,24(sp)
 86c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 86e:	0005c903          	lbu	s2,0(a1)
 872:	18090f63          	beqz	s2,a10 <vprintf+0x1c0>
 876:	8aaa                	mv	s5,a0
 878:	8b32                	mv	s6,a2
 87a:	00158493          	addi	s1,a1,1
  state = 0;
 87e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 880:	02500a13          	li	s4,37
      if(c == 'd'){
 884:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 888:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 88c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 890:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 894:	00000b97          	auipc	s7,0x0
 898:	4bcb8b93          	addi	s7,s7,1212 # d50 <digits>
 89c:	a839                	j	8ba <vprintf+0x6a>
        putc(fd, c);
 89e:	85ca                	mv	a1,s2
 8a0:	8556                	mv	a0,s5
 8a2:	00000097          	auipc	ra,0x0
 8a6:	ee2080e7          	jalr	-286(ra) # 784 <putc>
 8aa:	a019                	j	8b0 <vprintf+0x60>
    } else if(state == '%'){
 8ac:	01498f63          	beq	s3,s4,8ca <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 8b0:	0485                	addi	s1,s1,1
 8b2:	fff4c903          	lbu	s2,-1(s1)
 8b6:	14090d63          	beqz	s2,a10 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 8ba:	0009079b          	sext.w	a5,s2
    if(state == 0){
 8be:	fe0997e3          	bnez	s3,8ac <vprintf+0x5c>
      if(c == '%'){
 8c2:	fd479ee3          	bne	a5,s4,89e <vprintf+0x4e>
        state = '%';
 8c6:	89be                	mv	s3,a5
 8c8:	b7e5                	j	8b0 <vprintf+0x60>
      if(c == 'd'){
 8ca:	05878063          	beq	a5,s8,90a <vprintf+0xba>
      } else if(c == 'l') {
 8ce:	05978c63          	beq	a5,s9,926 <vprintf+0xd6>
      } else if(c == 'x') {
 8d2:	07a78863          	beq	a5,s10,942 <vprintf+0xf2>
      } else if(c == 'p') {
 8d6:	09b78463          	beq	a5,s11,95e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8da:	07300713          	li	a4,115
 8de:	0ce78663          	beq	a5,a4,9aa <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8e2:	06300713          	li	a4,99
 8e6:	0ee78e63          	beq	a5,a4,9e2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8ea:	11478863          	beq	a5,s4,9fa <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ee:	85d2                	mv	a1,s4
 8f0:	8556                	mv	a0,s5
 8f2:	00000097          	auipc	ra,0x0
 8f6:	e92080e7          	jalr	-366(ra) # 784 <putc>
        putc(fd, c);
 8fa:	85ca                	mv	a1,s2
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	e86080e7          	jalr	-378(ra) # 784 <putc>
      }
      state = 0;
 906:	4981                	li	s3,0
 908:	b765                	j	8b0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 90a:	008b0913          	addi	s2,s6,8
 90e:	4685                	li	a3,1
 910:	4629                	li	a2,10
 912:	000b2583          	lw	a1,0(s6)
 916:	8556                	mv	a0,s5
 918:	00000097          	auipc	ra,0x0
 91c:	e8e080e7          	jalr	-370(ra) # 7a6 <printint>
 920:	8b4a                	mv	s6,s2
      state = 0;
 922:	4981                	li	s3,0
 924:	b771                	j	8b0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 926:	008b0913          	addi	s2,s6,8
 92a:	4681                	li	a3,0
 92c:	4629                	li	a2,10
 92e:	000b2583          	lw	a1,0(s6)
 932:	8556                	mv	a0,s5
 934:	00000097          	auipc	ra,0x0
 938:	e72080e7          	jalr	-398(ra) # 7a6 <printint>
 93c:	8b4a                	mv	s6,s2
      state = 0;
 93e:	4981                	li	s3,0
 940:	bf85                	j	8b0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 942:	008b0913          	addi	s2,s6,8
 946:	4681                	li	a3,0
 948:	4641                	li	a2,16
 94a:	000b2583          	lw	a1,0(s6)
 94e:	8556                	mv	a0,s5
 950:	00000097          	auipc	ra,0x0
 954:	e56080e7          	jalr	-426(ra) # 7a6 <printint>
 958:	8b4a                	mv	s6,s2
      state = 0;
 95a:	4981                	li	s3,0
 95c:	bf91                	j	8b0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 95e:	008b0793          	addi	a5,s6,8
 962:	f8f43423          	sd	a5,-120(s0)
 966:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 96a:	03000593          	li	a1,48
 96e:	8556                	mv	a0,s5
 970:	00000097          	auipc	ra,0x0
 974:	e14080e7          	jalr	-492(ra) # 784 <putc>
  putc(fd, 'x');
 978:	85ea                	mv	a1,s10
 97a:	8556                	mv	a0,s5
 97c:	00000097          	auipc	ra,0x0
 980:	e08080e7          	jalr	-504(ra) # 784 <putc>
 984:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 986:	03c9d793          	srli	a5,s3,0x3c
 98a:	97de                	add	a5,a5,s7
 98c:	0007c583          	lbu	a1,0(a5)
 990:	8556                	mv	a0,s5
 992:	00000097          	auipc	ra,0x0
 996:	df2080e7          	jalr	-526(ra) # 784 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 99a:	0992                	slli	s3,s3,0x4
 99c:	397d                	addiw	s2,s2,-1
 99e:	fe0914e3          	bnez	s2,986 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 9a2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 9a6:	4981                	li	s3,0
 9a8:	b721                	j	8b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 9aa:	008b0993          	addi	s3,s6,8
 9ae:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 9b2:	02090163          	beqz	s2,9d4 <vprintf+0x184>
        while(*s != 0){
 9b6:	00094583          	lbu	a1,0(s2)
 9ba:	c9a1                	beqz	a1,a0a <vprintf+0x1ba>
          putc(fd, *s);
 9bc:	8556                	mv	a0,s5
 9be:	00000097          	auipc	ra,0x0
 9c2:	dc6080e7          	jalr	-570(ra) # 784 <putc>
          s++;
 9c6:	0905                	addi	s2,s2,1
        while(*s != 0){
 9c8:	00094583          	lbu	a1,0(s2)
 9cc:	f9e5                	bnez	a1,9bc <vprintf+0x16c>
        s = va_arg(ap, char*);
 9ce:	8b4e                	mv	s6,s3
      state = 0;
 9d0:	4981                	li	s3,0
 9d2:	bdf9                	j	8b0 <vprintf+0x60>
          s = "(null)";
 9d4:	00000917          	auipc	s2,0x0
 9d8:	37490913          	addi	s2,s2,884 # d48 <malloc+0x22e>
        while(*s != 0){
 9dc:	02800593          	li	a1,40
 9e0:	bff1                	j	9bc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 9e2:	008b0913          	addi	s2,s6,8
 9e6:	000b4583          	lbu	a1,0(s6)
 9ea:	8556                	mv	a0,s5
 9ec:	00000097          	auipc	ra,0x0
 9f0:	d98080e7          	jalr	-616(ra) # 784 <putc>
 9f4:	8b4a                	mv	s6,s2
      state = 0;
 9f6:	4981                	li	s3,0
 9f8:	bd65                	j	8b0 <vprintf+0x60>
        putc(fd, c);
 9fa:	85d2                	mv	a1,s4
 9fc:	8556                	mv	a0,s5
 9fe:	00000097          	auipc	ra,0x0
 a02:	d86080e7          	jalr	-634(ra) # 784 <putc>
      state = 0;
 a06:	4981                	li	s3,0
 a08:	b565                	j	8b0 <vprintf+0x60>
        s = va_arg(ap, char*);
 a0a:	8b4e                	mv	s6,s3
      state = 0;
 a0c:	4981                	li	s3,0
 a0e:	b54d                	j	8b0 <vprintf+0x60>
    }
  }
}
 a10:	70e6                	ld	ra,120(sp)
 a12:	7446                	ld	s0,112(sp)
 a14:	74a6                	ld	s1,104(sp)
 a16:	7906                	ld	s2,96(sp)
 a18:	69e6                	ld	s3,88(sp)
 a1a:	6a46                	ld	s4,80(sp)
 a1c:	6aa6                	ld	s5,72(sp)
 a1e:	6b06                	ld	s6,64(sp)
 a20:	7be2                	ld	s7,56(sp)
 a22:	7c42                	ld	s8,48(sp)
 a24:	7ca2                	ld	s9,40(sp)
 a26:	7d02                	ld	s10,32(sp)
 a28:	6de2                	ld	s11,24(sp)
 a2a:	6109                	addi	sp,sp,128
 a2c:	8082                	ret

0000000000000a2e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 a2e:	715d                	addi	sp,sp,-80
 a30:	ec06                	sd	ra,24(sp)
 a32:	e822                	sd	s0,16(sp)
 a34:	1000                	addi	s0,sp,32
 a36:	e010                	sd	a2,0(s0)
 a38:	e414                	sd	a3,8(s0)
 a3a:	e818                	sd	a4,16(s0)
 a3c:	ec1c                	sd	a5,24(s0)
 a3e:	03043023          	sd	a6,32(s0)
 a42:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a46:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a4a:	8622                	mv	a2,s0
 a4c:	00000097          	auipc	ra,0x0
 a50:	e04080e7          	jalr	-508(ra) # 850 <vprintf>
}
 a54:	60e2                	ld	ra,24(sp)
 a56:	6442                	ld	s0,16(sp)
 a58:	6161                	addi	sp,sp,80
 a5a:	8082                	ret

0000000000000a5c <printf>:

void
printf(const char *fmt, ...)
{
 a5c:	711d                	addi	sp,sp,-96
 a5e:	ec06                	sd	ra,24(sp)
 a60:	e822                	sd	s0,16(sp)
 a62:	1000                	addi	s0,sp,32
 a64:	e40c                	sd	a1,8(s0)
 a66:	e810                	sd	a2,16(s0)
 a68:	ec14                	sd	a3,24(s0)
 a6a:	f018                	sd	a4,32(s0)
 a6c:	f41c                	sd	a5,40(s0)
 a6e:	03043823          	sd	a6,48(s0)
 a72:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a76:	00840613          	addi	a2,s0,8
 a7a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a7e:	85aa                	mv	a1,a0
 a80:	4505                	li	a0,1
 a82:	00000097          	auipc	ra,0x0
 a86:	dce080e7          	jalr	-562(ra) # 850 <vprintf>
}
 a8a:	60e2                	ld	ra,24(sp)
 a8c:	6442                	ld	s0,16(sp)
 a8e:	6125                	addi	sp,sp,96
 a90:	8082                	ret

0000000000000a92 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a92:	1141                	addi	sp,sp,-16
 a94:	e422                	sd	s0,8(sp)
 a96:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a98:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a9c:	00000797          	auipc	a5,0x0
 aa0:	2d47b783          	ld	a5,724(a5) # d70 <freep>
 aa4:	a805                	j	ad4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 aa6:	4618                	lw	a4,8(a2)
 aa8:	9db9                	addw	a1,a1,a4
 aaa:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 aae:	6398                	ld	a4,0(a5)
 ab0:	6318                	ld	a4,0(a4)
 ab2:	fee53823          	sd	a4,-16(a0)
 ab6:	a091                	j	afa <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 ab8:	ff852703          	lw	a4,-8(a0)
 abc:	9e39                	addw	a2,a2,a4
 abe:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 ac0:	ff053703          	ld	a4,-16(a0)
 ac4:	e398                	sd	a4,0(a5)
 ac6:	a099                	j	b0c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ac8:	6398                	ld	a4,0(a5)
 aca:	00e7e463          	bltu	a5,a4,ad2 <free+0x40>
 ace:	00e6ea63          	bltu	a3,a4,ae2 <free+0x50>
{
 ad2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ad4:	fed7fae3          	bgeu	a5,a3,ac8 <free+0x36>
 ad8:	6398                	ld	a4,0(a5)
 ada:	00e6e463          	bltu	a3,a4,ae2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ade:	fee7eae3          	bltu	a5,a4,ad2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 ae2:	ff852583          	lw	a1,-8(a0)
 ae6:	6390                	ld	a2,0(a5)
 ae8:	02059813          	slli	a6,a1,0x20
 aec:	01c85713          	srli	a4,a6,0x1c
 af0:	9736                	add	a4,a4,a3
 af2:	fae60ae3          	beq	a2,a4,aa6 <free+0x14>
    bp->s.ptr = p->s.ptr;
 af6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 afa:	4790                	lw	a2,8(a5)
 afc:	02061593          	slli	a1,a2,0x20
 b00:	01c5d713          	srli	a4,a1,0x1c
 b04:	973e                	add	a4,a4,a5
 b06:	fae689e3          	beq	a3,a4,ab8 <free+0x26>
  } else
    p->s.ptr = bp;
 b0a:	e394                	sd	a3,0(a5)
  freep = p;
 b0c:	00000717          	auipc	a4,0x0
 b10:	26f73223          	sd	a5,612(a4) # d70 <freep>
}
 b14:	6422                	ld	s0,8(sp)
 b16:	0141                	addi	sp,sp,16
 b18:	8082                	ret

0000000000000b1a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b1a:	7139                	addi	sp,sp,-64
 b1c:	fc06                	sd	ra,56(sp)
 b1e:	f822                	sd	s0,48(sp)
 b20:	f426                	sd	s1,40(sp)
 b22:	f04a                	sd	s2,32(sp)
 b24:	ec4e                	sd	s3,24(sp)
 b26:	e852                	sd	s4,16(sp)
 b28:	e456                	sd	s5,8(sp)
 b2a:	e05a                	sd	s6,0(sp)
 b2c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b2e:	02051493          	slli	s1,a0,0x20
 b32:	9081                	srli	s1,s1,0x20
 b34:	04bd                	addi	s1,s1,15
 b36:	8091                	srli	s1,s1,0x4
 b38:	0014899b          	addiw	s3,s1,1
 b3c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b3e:	00000517          	auipc	a0,0x0
 b42:	23253503          	ld	a0,562(a0) # d70 <freep>
 b46:	c515                	beqz	a0,b72 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b48:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b4a:	4798                	lw	a4,8(a5)
 b4c:	02977f63          	bgeu	a4,s1,b8a <malloc+0x70>
 b50:	8a4e                	mv	s4,s3
 b52:	0009871b          	sext.w	a4,s3
 b56:	6685                	lui	a3,0x1
 b58:	00d77363          	bgeu	a4,a3,b5e <malloc+0x44>
 b5c:	6a05                	lui	s4,0x1
 b5e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b62:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b66:	00000917          	auipc	s2,0x0
 b6a:	20a90913          	addi	s2,s2,522 # d70 <freep>
  if(p == (char*)-1)
 b6e:	5afd                	li	s5,-1
 b70:	a895                	j	be4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b72:	00000797          	auipc	a5,0x0
 b76:	2f678793          	addi	a5,a5,758 # e68 <base>
 b7a:	00000717          	auipc	a4,0x0
 b7e:	1ef73b23          	sd	a5,502(a4) # d70 <freep>
 b82:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b84:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b88:	b7e1                	j	b50 <malloc+0x36>
      if(p->s.size == nunits)
 b8a:	02e48c63          	beq	s1,a4,bc2 <malloc+0xa8>
        p->s.size -= nunits;
 b8e:	4137073b          	subw	a4,a4,s3
 b92:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b94:	02071693          	slli	a3,a4,0x20
 b98:	01c6d713          	srli	a4,a3,0x1c
 b9c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b9e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 ba2:	00000717          	auipc	a4,0x0
 ba6:	1ca73723          	sd	a0,462(a4) # d70 <freep>
      return (void*)(p + 1);
 baa:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 bae:	70e2                	ld	ra,56(sp)
 bb0:	7442                	ld	s0,48(sp)
 bb2:	74a2                	ld	s1,40(sp)
 bb4:	7902                	ld	s2,32(sp)
 bb6:	69e2                	ld	s3,24(sp)
 bb8:	6a42                	ld	s4,16(sp)
 bba:	6aa2                	ld	s5,8(sp)
 bbc:	6b02                	ld	s6,0(sp)
 bbe:	6121                	addi	sp,sp,64
 bc0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 bc2:	6398                	ld	a4,0(a5)
 bc4:	e118                	sd	a4,0(a0)
 bc6:	bff1                	j	ba2 <malloc+0x88>
  hp->s.size = nu;
 bc8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 bcc:	0541                	addi	a0,a0,16
 bce:	00000097          	auipc	ra,0x0
 bd2:	ec4080e7          	jalr	-316(ra) # a92 <free>
  return freep;
 bd6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 bda:	d971                	beqz	a0,bae <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bdc:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bde:	4798                	lw	a4,8(a5)
 be0:	fa9775e3          	bgeu	a4,s1,b8a <malloc+0x70>
    if(p == freep)
 be4:	00093703          	ld	a4,0(s2)
 be8:	853e                	mv	a0,a5
 bea:	fef719e3          	bne	a4,a5,bdc <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 bee:	8552                	mv	a0,s4
 bf0:	00000097          	auipc	ra,0x0
 bf4:	b74080e7          	jalr	-1164(ra) # 764 <sbrk>
  if(p == (char*)-1)
 bf8:	fd5518e3          	bne	a0,s5,bc8 <malloc+0xae>
        return 0;
 bfc:	4501                	li	a0,0
 bfe:	bf45                	j	bae <malloc+0x94>
