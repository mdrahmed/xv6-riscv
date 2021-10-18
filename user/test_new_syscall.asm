
user/_test_new_syscall:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <a>:
#include "kernel/types.h"
#include "user/user.h"
#include "kernel/stat.h"

void a(int *b, int *c){
   0:	1141                	addi	sp,sp,-16
   2:	e422                	sd	s0,8(sp)
   4:	0800                	addi	s0,sp,16
  *b = 100;
   6:	06400793          	li	a5,100
   a:	c11c                	sw	a5,0(a0)
  *c = 222;
   c:	0de00793          	li	a5,222
  10:	c19c                	sw	a5,0(a1)
}
  12:	6422                	ld	s0,8(sp)
  14:	0141                	addi	sp,sp,16
  16:	8082                	ret

0000000000000018 <main>:

int main()
{
  18:	715d                	addi	sp,sp,-80
  1a:	e486                	sd	ra,72(sp)
  1c:	e0a2                	sd	s0,64(sp)
  1e:	fc26                	sd	s1,56(sp)
  20:	f84a                	sd	s2,48(sp)
  22:	f44e                	sd	s3,40(sp)
  24:	f052                	sd	s4,32(sp)
  26:	0880                	addi	s0,sp,80
  int pid = fork();
  28:	00000097          	auipc	ra,0x0
  2c:	678080e7          	jalr	1656(ra) # 6a0 <fork>

  uint64 addri = 0; // = (uint64 *)0;
  30:	fc043423          	sd	zero,-56(s0)
  uint64* addr = &addri;
  34:	fc840793          	addi	a5,s0,-56
  38:	fcf43023          	sd	a5,-64(s0)
  int bytesi = 0; // = (int *) 0;
  3c:	fa042e23          	sw	zero,-68(s0)

  int bytes_want = 14;// 65536;//(10485760/8);
  // int start_time, elasped_time;
  // start_time = uptime();

  if(pid > 0){
  40:	0ca04663          	bgtz	a0,10c <main+0xf4>
    ringbuf_finish_read(ring_desc, *bytes);
    printf("\n\n");
    
    create_or_close_the_buffer_user("ring", 0);
  }
  else if(pid ==0 ){
  44:	1a051d63          	bnez	a0,1fe <main+0x1e6>
    ////child process

    int ring_desc = create_or_close_the_buffer_user("ring", 1);
  48:	4585                	li	a1,1
  4a:	00001517          	auipc	a0,0x1
  4e:	b8650513          	addi	a0,a0,-1146 # bd0 <malloc+0xea>
  52:	00000097          	auipc	ra,0x0
  56:	1ea080e7          	jalr	490(ra) # 23c <create_or_close_the_buffer_user>
  5a:	892a                	mv	s2,a0

    printf("before write addr %d\n", addr);
  5c:	fc043583          	ld	a1,-64(s0)
  60:	00001517          	auipc	a0,0x1
  64:	bd050513          	addi	a0,a0,-1072 # c30 <malloc+0x14a>
  68:	00001097          	auipc	ra,0x1
  6c:	9c0080e7          	jalr	-1600(ra) # a28 <printf>
    printf("before write bytes %d\n", bytes);
  70:	fbc40593          	addi	a1,s0,-68
  74:	00001517          	auipc	a0,0x1
  78:	bd450513          	addi	a0,a0,-1068 # c48 <malloc+0x162>
  7c:	00001097          	auipc	ra,0x1
  80:	9ac080e7          	jalr	-1620(ra) # a28 <printf>
  //start here
    ringbuf_start_write(ring_desc, &addr, bytes);
  84:	fbc40613          	addi	a2,s0,-68
  88:	fc040593          	addi	a1,s0,-64
  8c:	854a                	mv	a0,s2
  8e:	00000097          	auipc	ra,0x0
  92:	24c080e7          	jalr	588(ra) # 2da <ringbuf_start_write>
    printf("after start_write addr %d\n", addr);
  96:	fc043583          	ld	a1,-64(s0)
  9a:	00001517          	auipc	a0,0x1
  9e:	bc650513          	addi	a0,a0,-1082 # c60 <malloc+0x17a>
  a2:	00001097          	auipc	ra,0x1
  a6:	986080e7          	jalr	-1658(ra) # a28 <printf>
    printf("after start_write bytes %d\n\n", *bytes);
  aa:	fbc42583          	lw	a1,-68(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	bd250513          	addi	a0,a0,-1070 # c80 <malloc+0x19a>
  b6:	00001097          	auipc	ra,0x1
  ba:	972080e7          	jalr	-1678(ra) # a28 <printf>

    if(bytes_want < *bytes){
  be:	fbc42583          	lw	a1,-68(s0)
  c2:	47b9                	li	a5,14
  c4:	0eb7c563          	blt	a5,a1,1ae <main+0x196>
        printf("written on address %d\n", addr[i]);
      }
      ringbuf_finish_write(ring_desc, bytes_want);
    }
    else{
      for(int i=0; i < *bytes; i++){
  c8:	4481                	li	s1,0
        addr[i] = i;
        printf("written on address %d\n", addr + i);
  ca:	00001997          	auipc	s3,0x1
  ce:	bd698993          	addi	s3,s3,-1066 # ca0 <malloc+0x1ba>
      for(int i=0; i < *bytes; i++){
  d2:	02b05763          	blez	a1,100 <main+0xe8>
        addr[i] = i;
  d6:	00349713          	slli	a4,s1,0x3
  da:	fc043783          	ld	a5,-64(s0)
  de:	97ba                	add	a5,a5,a4
  e0:	e384                	sd	s1,0(a5)
        printf("written on address %d\n", addr + i);
  e2:	fc043583          	ld	a1,-64(s0)
  e6:	95ba                	add	a1,a1,a4
  e8:	854e                	mv	a0,s3
  ea:	00001097          	auipc	ra,0x1
  ee:	93e080e7          	jalr	-1730(ra) # a28 <printf>
      for(int i=0; i < *bytes; i++){
  f2:	fbc42583          	lw	a1,-68(s0)
  f6:	0485                	addi	s1,s1,1
  f8:	0004879b          	sext.w	a5,s1
  fc:	fcb7cde3          	blt	a5,a1,d6 <main+0xbe>
      }
      ringbuf_finish_write(ring_desc, *bytes);
 100:	854a                	mv	a0,s2
 102:	00000097          	auipc	ra,0x0
 106:	246080e7          	jalr	582(ra) # 348 <ringbuf_finish_write>
 10a:	a0c5                	j	1ea <main+0x1d2>
    int ring_desc = create_or_close_the_buffer_user("ring", 1);
 10c:	4585                	li	a1,1
 10e:	00001517          	auipc	a0,0x1
 112:	ac250513          	addi	a0,a0,-1342 # bd0 <malloc+0xea>
 116:	00000097          	auipc	ra,0x0
 11a:	126080e7          	jalr	294(ra) # 23c <create_or_close_the_buffer_user>
 11e:	84aa                	mv	s1,a0
    check_bytes_written(ring_desc, bytes);
 120:	fbc40593          	addi	a1,s0,-68
 124:	00000097          	auipc	ra,0x0
 128:	256080e7          	jalr	598(ra) # 37a <check_bytes_written>
    printf("after checking bytes written addr %d\n", *addr);
 12c:	fc043783          	ld	a5,-64(s0)
 130:	638c                	ld	a1,0(a5)
 132:	00001517          	auipc	a0,0x1
 136:	aa650513          	addi	a0,a0,-1370 # bd8 <malloc+0xf2>
 13a:	00001097          	auipc	ra,0x1
 13e:	8ee080e7          	jalr	-1810(ra) # a28 <printf>
    printf("after checking bytes written bytes %d\n", *bytes);
 142:	fbc42583          	lw	a1,-68(s0)
 146:	00001517          	auipc	a0,0x1
 14a:	aba50513          	addi	a0,a0,-1350 # c00 <malloc+0x11a>
 14e:	00001097          	auipc	ra,0x1
 152:	8da080e7          	jalr	-1830(ra) # a28 <printf>
    ringbuf_start_read(ring_desc, addr, bytes);
 156:	fbc40613          	addi	a2,s0,-68
 15a:	fc043583          	ld	a1,-64(s0)
 15e:	8526                	mv	a0,s1
 160:	00000097          	auipc	ra,0x0
 164:	250080e7          	jalr	592(ra) # 3b0 <ringbuf_start_read>
    for(int i=0; i < *bytes; i++){
 168:	fbc42583          	lw	a1,-68(s0)
 16c:	00b05663          	blez	a1,178 <main+0x160>
 170:	4781                	li	a5,0
 172:	2785                	addiw	a5,a5,1
 174:	feb79fe3          	bne	a5,a1,172 <main+0x15a>
    ringbuf_finish_read(ring_desc, *bytes);
 178:	8526                	mv	a0,s1
 17a:	00000097          	auipc	ra,0x0
 17e:	290080e7          	jalr	656(ra) # 40a <ringbuf_finish_read>
    printf("\n\n");
 182:	00001517          	auipc	a0,0x1
 186:	aa650513          	addi	a0,a0,-1370 # c28 <malloc+0x142>
 18a:	00001097          	auipc	ra,0x1
 18e:	89e080e7          	jalr	-1890(ra) # a28 <printf>
    create_or_close_the_buffer_user("ring", 0);
 192:	4581                	li	a1,0
 194:	00001517          	auipc	a0,0x1
 198:	a3c50513          	addi	a0,a0,-1476 # bd0 <malloc+0xea>
 19c:	00000097          	auipc	ra,0x0
 1a0:	0a0080e7          	jalr	160(ra) # 23c <create_or_close_the_buffer_user>
  // printf("\n\n");
  // elasped_time = uptime()-start_time;
  // printf("Elasped time is %d\n\n", elasped_time);


  exit(0);
 1a4:	4501                	li	a0,0
 1a6:	00000097          	auipc	ra,0x0
 1aa:	502080e7          	jalr	1282(ra) # 6a8 <exit>
 1ae:	4481                	li	s1,0
        printf("written on address %d\n", addr[i]);
 1b0:	00001a17          	auipc	s4,0x1
 1b4:	af0a0a13          	addi	s4,s4,-1296 # ca0 <malloc+0x1ba>
      for(int i=0; i < bytes_want; i++){
 1b8:	49b9                	li	s3,14
        addr[i] = i;
 1ba:	00349693          	slli	a3,s1,0x3
 1be:	fc043703          	ld	a4,-64(s0)
 1c2:	9736                	add	a4,a4,a3
 1c4:	e304                	sd	s1,0(a4)
        printf("written on address %d\n", addr[i]);
 1c6:	fc043783          	ld	a5,-64(s0)
 1ca:	97b6                	add	a5,a5,a3
 1cc:	638c                	ld	a1,0(a5)
 1ce:	8552                	mv	a0,s4
 1d0:	00001097          	auipc	ra,0x1
 1d4:	858080e7          	jalr	-1960(ra) # a28 <printf>
      for(int i=0; i < bytes_want; i++){
 1d8:	0485                	addi	s1,s1,1
 1da:	ff3490e3          	bne	s1,s3,1ba <main+0x1a2>
      ringbuf_finish_write(ring_desc, bytes_want);
 1de:	45b9                	li	a1,14
 1e0:	854a                	mv	a0,s2
 1e2:	00000097          	auipc	ra,0x0
 1e6:	166080e7          	jalr	358(ra) # 348 <ringbuf_finish_write>
    create_or_close_the_buffer_user("ring", 0);
 1ea:	4581                	li	a1,0
 1ec:	00001517          	auipc	a0,0x1
 1f0:	9e450513          	addi	a0,a0,-1564 # bd0 <malloc+0xea>
 1f4:	00000097          	auipc	ra,0x0
 1f8:	048080e7          	jalr	72(ra) # 23c <create_or_close_the_buffer_user>
 1fc:	b765                	j	1a4 <main+0x18c>
    printf("An error occurred while forking.");
 1fe:	00001517          	auipc	a0,0x1
 202:	aba50513          	addi	a0,a0,-1350 # cb8 <malloc+0x1d2>
 206:	00001097          	auipc	ra,0x1
 20a:	822080e7          	jalr	-2014(ra) # a28 <printf>
 20e:	bf59                	j	1a4 <main+0x18c>

0000000000000210 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 210:	1141                	addi	sp,sp,-16
 212:	e422                	sd	s0,8(sp)
 214:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 216:	0f50000f          	fence	iorw,ow
 21a:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 21e:	6422                	ld	s0,8(sp)
 220:	0141                	addi	sp,sp,16
 222:	8082                	ret

0000000000000224 <load>:

int load(uint64 *p) {
 224:	1141                	addi	sp,sp,-16
 226:	e422                	sd	s0,8(sp)
 228:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 22a:	0ff0000f          	fence
 22e:	6108                	ld	a0,0(a0)
 230:	0ff0000f          	fence
}
 234:	2501                	sext.w	a0,a0
 236:	6422                	ld	s0,8(sp)
 238:	0141                	addi	sp,sp,16
 23a:	8082                	ret

000000000000023c <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 23c:	7179                	addi	sp,sp,-48
 23e:	f406                	sd	ra,40(sp)
 240:	f022                	sd	s0,32(sp)
 242:	ec26                	sd	s1,24(sp)
 244:	e84a                	sd	s2,16(sp)
 246:	e44e                	sd	s3,8(sp)
 248:	e052                	sd	s4,0(sp)
 24a:	1800                	addi	s0,sp,48
 24c:	8a2a                	mv	s4,a0
 24e:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 250:	4785                	li	a5,1
 252:	00001497          	auipc	s1,0x1
 256:	ac648493          	addi	s1,s1,-1338 # d18 <rings+0x10>
 25a:	00001917          	auipc	s2,0x1
 25e:	bae90913          	addi	s2,s2,-1106 # e08 <__BSS_END__>
 262:	04f59563          	bne	a1,a5,2ac <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 266:	00001497          	auipc	s1,0x1
 26a:	ab24a483          	lw	s1,-1358(s1) # d18 <rings+0x10>
 26e:	c099                	beqz	s1,274 <create_or_close_the_buffer_user+0x38>
 270:	4481                	li	s1,0
 272:	a899                	j	2c8 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 274:	00001917          	auipc	s2,0x1
 278:	a9490913          	addi	s2,s2,-1388 # d08 <rings>
 27c:	00093603          	ld	a2,0(s2)
 280:	4585                	li	a1,1
 282:	00000097          	auipc	ra,0x0
 286:	4c6080e7          	jalr	1222(ra) # 748 <ringbuf>
        rings[i].book->write_done = 0;
 28a:	00893783          	ld	a5,8(s2)
 28e:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 292:	00893783          	ld	a5,8(s2)
 296:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 29a:	01092783          	lw	a5,16(s2)
 29e:	2785                	addiw	a5,a5,1
 2a0:	00f92823          	sw	a5,16(s2)
        break;
 2a4:	a015                	j	2c8 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 2a6:	04e1                	addi	s1,s1,24
 2a8:	01248f63          	beq	s1,s2,2c6 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 2ac:	409c                	lw	a5,0(s1)
 2ae:	dfe5                	beqz	a5,2a6 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 2b0:	ff04b603          	ld	a2,-16(s1)
 2b4:	85ce                	mv	a1,s3
 2b6:	8552                	mv	a0,s4
 2b8:	00000097          	auipc	ra,0x0
 2bc:	490080e7          	jalr	1168(ra) # 748 <ringbuf>
        rings[i].exists = 0;
 2c0:	0004a023          	sw	zero,0(s1)
 2c4:	b7cd                	j	2a6 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 2c6:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 2c8:	8526                	mv	a0,s1
 2ca:	70a2                	ld	ra,40(sp)
 2cc:	7402                	ld	s0,32(sp)
 2ce:	64e2                	ld	s1,24(sp)
 2d0:	6942                	ld	s2,16(sp)
 2d2:	69a2                	ld	s3,8(sp)
 2d4:	6a02                	ld	s4,0(sp)
 2d6:	6145                	addi	sp,sp,48
 2d8:	8082                	ret

00000000000002da <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 2da:	1101                	addi	sp,sp,-32
 2dc:	ec06                	sd	ra,24(sp)
 2de:	e822                	sd	s0,16(sp)
 2e0:	e426                	sd	s1,8(sp)
 2e2:	1000                	addi	s0,sp,32
 2e4:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 2e6:	00151793          	slli	a5,a0,0x1
 2ea:	97aa                	add	a5,a5,a0
 2ec:	078e                	slli	a5,a5,0x3
 2ee:	00001717          	auipc	a4,0x1
 2f2:	a1a70713          	addi	a4,a4,-1510 # d08 <rings>
 2f6:	97ba                	add	a5,a5,a4
 2f8:	639c                	ld	a5,0(a5)
 2fa:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 2fc:	421c                	lw	a5,0(a2)
 2fe:	e785                	bnez	a5,326 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 300:	86ba                	mv	a3,a4
 302:	671c                	ld	a5,8(a4)
 304:	6398                	ld	a4,0(a5)
 306:	67c1                	lui	a5,0x10
 308:	9fb9                	addw	a5,a5,a4
 30a:	00151713          	slli	a4,a0,0x1
 30e:	953a                	add	a0,a0,a4
 310:	050e                	slli	a0,a0,0x3
 312:	9536                	add	a0,a0,a3
 314:	6518                	ld	a4,8(a0)
 316:	6718                	ld	a4,8(a4)
 318:	9f99                	subw	a5,a5,a4
 31a:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 31c:	60e2                	ld	ra,24(sp)
 31e:	6442                	ld	s0,16(sp)
 320:	64a2                	ld	s1,8(sp)
 322:	6105                	addi	sp,sp,32
 324:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 326:	00151793          	slli	a5,a0,0x1
 32a:	953e                	add	a0,a0,a5
 32c:	050e                	slli	a0,a0,0x3
 32e:	00001797          	auipc	a5,0x1
 332:	9da78793          	addi	a5,a5,-1574 # d08 <rings>
 336:	953e                	add	a0,a0,a5
 338:	6508                	ld	a0,8(a0)
 33a:	0521                	addi	a0,a0,8
 33c:	00000097          	auipc	ra,0x0
 340:	ee8080e7          	jalr	-280(ra) # 224 <load>
 344:	c088                	sw	a0,0(s1)
}
 346:	bfd9                	j	31c <ringbuf_start_write+0x42>

0000000000000348 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 348:	1141                	addi	sp,sp,-16
 34a:	e406                	sd	ra,8(sp)
 34c:	e022                	sd	s0,0(sp)
 34e:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 350:	00151793          	slli	a5,a0,0x1
 354:	97aa                	add	a5,a5,a0
 356:	078e                	slli	a5,a5,0x3
 358:	00001517          	auipc	a0,0x1
 35c:	9b050513          	addi	a0,a0,-1616 # d08 <rings>
 360:	97aa                	add	a5,a5,a0
 362:	6788                	ld	a0,8(a5)
 364:	0035959b          	slliw	a1,a1,0x3
 368:	0521                	addi	a0,a0,8
 36a:	00000097          	auipc	ra,0x0
 36e:	ea6080e7          	jalr	-346(ra) # 210 <store>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 37a:	1101                	addi	sp,sp,-32
 37c:	ec06                	sd	ra,24(sp)
 37e:	e822                	sd	s0,16(sp)
 380:	e426                	sd	s1,8(sp)
 382:	1000                	addi	s0,sp,32
 384:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 386:	00151793          	slli	a5,a0,0x1
 38a:	97aa                	add	a5,a5,a0
 38c:	078e                	slli	a5,a5,0x3
 38e:	00001517          	auipc	a0,0x1
 392:	97a50513          	addi	a0,a0,-1670 # d08 <rings>
 396:	97aa                	add	a5,a5,a0
 398:	6788                	ld	a0,8(a5)
 39a:	0521                	addi	a0,a0,8
 39c:	00000097          	auipc	ra,0x0
 3a0:	e88080e7          	jalr	-376(ra) # 224 <load>
 3a4:	c088                	sw	a0,0(s1)
}
 3a6:	60e2                	ld	ra,24(sp)
 3a8:	6442                	ld	s0,16(sp)
 3aa:	64a2                	ld	s1,8(sp)
 3ac:	6105                	addi	sp,sp,32
 3ae:	8082                	ret

00000000000003b0 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 3b0:	1101                	addi	sp,sp,-32
 3b2:	ec06                	sd	ra,24(sp)
 3b4:	e822                	sd	s0,16(sp)
 3b6:	e426                	sd	s1,8(sp)
 3b8:	1000                	addi	s0,sp,32
 3ba:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 3bc:	00151793          	slli	a5,a0,0x1
 3c0:	97aa                	add	a5,a5,a0
 3c2:	078e                	slli	a5,a5,0x3
 3c4:	00001517          	auipc	a0,0x1
 3c8:	94450513          	addi	a0,a0,-1724 # d08 <rings>
 3cc:	97aa                	add	a5,a5,a0
 3ce:	6788                	ld	a0,8(a5)
 3d0:	611c                	ld	a5,0(a0)
 3d2:	ef99                	bnez	a5,3f0 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 3d4:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 3d6:	41f7579b          	sraiw	a5,a4,0x1f
 3da:	01d7d79b          	srliw	a5,a5,0x1d
 3de:	9fb9                	addw	a5,a5,a4
 3e0:	4037d79b          	sraiw	a5,a5,0x3
 3e4:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 3e6:	60e2                	ld	ra,24(sp)
 3e8:	6442                	ld	s0,16(sp)
 3ea:	64a2                	ld	s1,8(sp)
 3ec:	6105                	addi	sp,sp,32
 3ee:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 3f0:	00000097          	auipc	ra,0x0
 3f4:	e34080e7          	jalr	-460(ra) # 224 <load>
    *bytes /= 8;
 3f8:	41f5579b          	sraiw	a5,a0,0x1f
 3fc:	01d7d79b          	srliw	a5,a5,0x1d
 400:	9d3d                	addw	a0,a0,a5
 402:	4035551b          	sraiw	a0,a0,0x3
 406:	c088                	sw	a0,0(s1)
}
 408:	bff9                	j	3e6 <ringbuf_start_read+0x36>

000000000000040a <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 40a:	1141                	addi	sp,sp,-16
 40c:	e406                	sd	ra,8(sp)
 40e:	e022                	sd	s0,0(sp)
 410:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 412:	00151793          	slli	a5,a0,0x1
 416:	97aa                	add	a5,a5,a0
 418:	078e                	slli	a5,a5,0x3
 41a:	00001517          	auipc	a0,0x1
 41e:	8ee50513          	addi	a0,a0,-1810 # d08 <rings>
 422:	97aa                	add	a5,a5,a0
 424:	0035959b          	slliw	a1,a1,0x3
 428:	6788                	ld	a0,8(a5)
 42a:	00000097          	auipc	ra,0x0
 42e:	de6080e7          	jalr	-538(ra) # 210 <store>
}
 432:	60a2                	ld	ra,8(sp)
 434:	6402                	ld	s0,0(sp)
 436:	0141                	addi	sp,sp,16
 438:	8082                	ret

000000000000043a <strcpy>:



char*
strcpy(char *s, const char *t)
{
 43a:	1141                	addi	sp,sp,-16
 43c:	e422                	sd	s0,8(sp)
 43e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 440:	87aa                	mv	a5,a0
 442:	0585                	addi	a1,a1,1
 444:	0785                	addi	a5,a5,1
 446:	fff5c703          	lbu	a4,-1(a1)
 44a:	fee78fa3          	sb	a4,-1(a5)
 44e:	fb75                	bnez	a4,442 <strcpy+0x8>
    ;
  return os;
}
 450:	6422                	ld	s0,8(sp)
 452:	0141                	addi	sp,sp,16
 454:	8082                	ret

0000000000000456 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 456:	1141                	addi	sp,sp,-16
 458:	e422                	sd	s0,8(sp)
 45a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 45c:	00054783          	lbu	a5,0(a0)
 460:	cb91                	beqz	a5,474 <strcmp+0x1e>
 462:	0005c703          	lbu	a4,0(a1)
 466:	00f71763          	bne	a4,a5,474 <strcmp+0x1e>
    p++, q++;
 46a:	0505                	addi	a0,a0,1
 46c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 46e:	00054783          	lbu	a5,0(a0)
 472:	fbe5                	bnez	a5,462 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 474:	0005c503          	lbu	a0,0(a1)
}
 478:	40a7853b          	subw	a0,a5,a0
 47c:	6422                	ld	s0,8(sp)
 47e:	0141                	addi	sp,sp,16
 480:	8082                	ret

0000000000000482 <strlen>:

uint
strlen(const char *s)
{
 482:	1141                	addi	sp,sp,-16
 484:	e422                	sd	s0,8(sp)
 486:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 488:	00054783          	lbu	a5,0(a0)
 48c:	cf91                	beqz	a5,4a8 <strlen+0x26>
 48e:	0505                	addi	a0,a0,1
 490:	87aa                	mv	a5,a0
 492:	4685                	li	a3,1
 494:	9e89                	subw	a3,a3,a0
 496:	00f6853b          	addw	a0,a3,a5
 49a:	0785                	addi	a5,a5,1
 49c:	fff7c703          	lbu	a4,-1(a5)
 4a0:	fb7d                	bnez	a4,496 <strlen+0x14>
    ;
  return n;
}
 4a2:	6422                	ld	s0,8(sp)
 4a4:	0141                	addi	sp,sp,16
 4a6:	8082                	ret
  for(n = 0; s[n]; n++)
 4a8:	4501                	li	a0,0
 4aa:	bfe5                	j	4a2 <strlen+0x20>

00000000000004ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 4ac:	1141                	addi	sp,sp,-16
 4ae:	e422                	sd	s0,8(sp)
 4b0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 4b2:	ca19                	beqz	a2,4c8 <memset+0x1c>
 4b4:	87aa                	mv	a5,a0
 4b6:	1602                	slli	a2,a2,0x20
 4b8:	9201                	srli	a2,a2,0x20
 4ba:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 4be:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 4c2:	0785                	addi	a5,a5,1
 4c4:	fee79de3          	bne	a5,a4,4be <memset+0x12>
  }
  return dst;
}
 4c8:	6422                	ld	s0,8(sp)
 4ca:	0141                	addi	sp,sp,16
 4cc:	8082                	ret

00000000000004ce <strchr>:

char*
strchr(const char *s, char c)
{
 4ce:	1141                	addi	sp,sp,-16
 4d0:	e422                	sd	s0,8(sp)
 4d2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 4d4:	00054783          	lbu	a5,0(a0)
 4d8:	cb99                	beqz	a5,4ee <strchr+0x20>
    if(*s == c)
 4da:	00f58763          	beq	a1,a5,4e8 <strchr+0x1a>
  for(; *s; s++)
 4de:	0505                	addi	a0,a0,1
 4e0:	00054783          	lbu	a5,0(a0)
 4e4:	fbfd                	bnez	a5,4da <strchr+0xc>
      return (char*)s;
  return 0;
 4e6:	4501                	li	a0,0
}
 4e8:	6422                	ld	s0,8(sp)
 4ea:	0141                	addi	sp,sp,16
 4ec:	8082                	ret
  return 0;
 4ee:	4501                	li	a0,0
 4f0:	bfe5                	j	4e8 <strchr+0x1a>

00000000000004f2 <gets>:

char*
gets(char *buf, int max)
{
 4f2:	711d                	addi	sp,sp,-96
 4f4:	ec86                	sd	ra,88(sp)
 4f6:	e8a2                	sd	s0,80(sp)
 4f8:	e4a6                	sd	s1,72(sp)
 4fa:	e0ca                	sd	s2,64(sp)
 4fc:	fc4e                	sd	s3,56(sp)
 4fe:	f852                	sd	s4,48(sp)
 500:	f456                	sd	s5,40(sp)
 502:	f05a                	sd	s6,32(sp)
 504:	ec5e                	sd	s7,24(sp)
 506:	1080                	addi	s0,sp,96
 508:	8baa                	mv	s7,a0
 50a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 50c:	892a                	mv	s2,a0
 50e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 510:	4aa9                	li	s5,10
 512:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 514:	89a6                	mv	s3,s1
 516:	2485                	addiw	s1,s1,1
 518:	0344d863          	bge	s1,s4,548 <gets+0x56>
    cc = read(0, &c, 1);
 51c:	4605                	li	a2,1
 51e:	faf40593          	addi	a1,s0,-81
 522:	4501                	li	a0,0
 524:	00000097          	auipc	ra,0x0
 528:	19c080e7          	jalr	412(ra) # 6c0 <read>
    if(cc < 1)
 52c:	00a05e63          	blez	a0,548 <gets+0x56>
    buf[i++] = c;
 530:	faf44783          	lbu	a5,-81(s0)
 534:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 538:	01578763          	beq	a5,s5,546 <gets+0x54>
 53c:	0905                	addi	s2,s2,1
 53e:	fd679be3          	bne	a5,s6,514 <gets+0x22>
  for(i=0; i+1 < max; ){
 542:	89a6                	mv	s3,s1
 544:	a011                	j	548 <gets+0x56>
 546:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 548:	99de                	add	s3,s3,s7
 54a:	00098023          	sb	zero,0(s3)
  return buf;
}
 54e:	855e                	mv	a0,s7
 550:	60e6                	ld	ra,88(sp)
 552:	6446                	ld	s0,80(sp)
 554:	64a6                	ld	s1,72(sp)
 556:	6906                	ld	s2,64(sp)
 558:	79e2                	ld	s3,56(sp)
 55a:	7a42                	ld	s4,48(sp)
 55c:	7aa2                	ld	s5,40(sp)
 55e:	7b02                	ld	s6,32(sp)
 560:	6be2                	ld	s7,24(sp)
 562:	6125                	addi	sp,sp,96
 564:	8082                	ret

0000000000000566 <stat>:

int
stat(const char *n, struct stat *st)
{
 566:	1101                	addi	sp,sp,-32
 568:	ec06                	sd	ra,24(sp)
 56a:	e822                	sd	s0,16(sp)
 56c:	e426                	sd	s1,8(sp)
 56e:	e04a                	sd	s2,0(sp)
 570:	1000                	addi	s0,sp,32
 572:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 574:	4581                	li	a1,0
 576:	00000097          	auipc	ra,0x0
 57a:	172080e7          	jalr	370(ra) # 6e8 <open>
  if(fd < 0)
 57e:	02054563          	bltz	a0,5a8 <stat+0x42>
 582:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 584:	85ca                	mv	a1,s2
 586:	00000097          	auipc	ra,0x0
 58a:	17a080e7          	jalr	378(ra) # 700 <fstat>
 58e:	892a                	mv	s2,a0
  close(fd);
 590:	8526                	mv	a0,s1
 592:	00000097          	auipc	ra,0x0
 596:	13e080e7          	jalr	318(ra) # 6d0 <close>
  return r;
}
 59a:	854a                	mv	a0,s2
 59c:	60e2                	ld	ra,24(sp)
 59e:	6442                	ld	s0,16(sp)
 5a0:	64a2                	ld	s1,8(sp)
 5a2:	6902                	ld	s2,0(sp)
 5a4:	6105                	addi	sp,sp,32
 5a6:	8082                	ret
    return -1;
 5a8:	597d                	li	s2,-1
 5aa:	bfc5                	j	59a <stat+0x34>

00000000000005ac <atoi>:

int
atoi(const char *s)
{
 5ac:	1141                	addi	sp,sp,-16
 5ae:	e422                	sd	s0,8(sp)
 5b0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 5b2:	00054603          	lbu	a2,0(a0)
 5b6:	fd06079b          	addiw	a5,a2,-48
 5ba:	0ff7f793          	zext.b	a5,a5
 5be:	4725                	li	a4,9
 5c0:	02f76963          	bltu	a4,a5,5f2 <atoi+0x46>
 5c4:	86aa                	mv	a3,a0
  n = 0;
 5c6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 5c8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 5ca:	0685                	addi	a3,a3,1
 5cc:	0025179b          	slliw	a5,a0,0x2
 5d0:	9fa9                	addw	a5,a5,a0
 5d2:	0017979b          	slliw	a5,a5,0x1
 5d6:	9fb1                	addw	a5,a5,a2
 5d8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5dc:	0006c603          	lbu	a2,0(a3)
 5e0:	fd06071b          	addiw	a4,a2,-48
 5e4:	0ff77713          	zext.b	a4,a4
 5e8:	fee5f1e3          	bgeu	a1,a4,5ca <atoi+0x1e>
  return n;
}
 5ec:	6422                	ld	s0,8(sp)
 5ee:	0141                	addi	sp,sp,16
 5f0:	8082                	ret
  n = 0;
 5f2:	4501                	li	a0,0
 5f4:	bfe5                	j	5ec <atoi+0x40>

00000000000005f6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5f6:	1141                	addi	sp,sp,-16
 5f8:	e422                	sd	s0,8(sp)
 5fa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5fc:	02b57463          	bgeu	a0,a1,624 <memmove+0x2e>
    while(n-- > 0)
 600:	00c05f63          	blez	a2,61e <memmove+0x28>
 604:	1602                	slli	a2,a2,0x20
 606:	9201                	srli	a2,a2,0x20
 608:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 60c:	872a                	mv	a4,a0
      *dst++ = *src++;
 60e:	0585                	addi	a1,a1,1
 610:	0705                	addi	a4,a4,1
 612:	fff5c683          	lbu	a3,-1(a1)
 616:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 61a:	fee79ae3          	bne	a5,a4,60e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 61e:	6422                	ld	s0,8(sp)
 620:	0141                	addi	sp,sp,16
 622:	8082                	ret
    dst += n;
 624:	00c50733          	add	a4,a0,a2
    src += n;
 628:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 62a:	fec05ae3          	blez	a2,61e <memmove+0x28>
 62e:	fff6079b          	addiw	a5,a2,-1
 632:	1782                	slli	a5,a5,0x20
 634:	9381                	srli	a5,a5,0x20
 636:	fff7c793          	not	a5,a5
 63a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 63c:	15fd                	addi	a1,a1,-1
 63e:	177d                	addi	a4,a4,-1
 640:	0005c683          	lbu	a3,0(a1)
 644:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 648:	fee79ae3          	bne	a5,a4,63c <memmove+0x46>
 64c:	bfc9                	j	61e <memmove+0x28>

000000000000064e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 64e:	1141                	addi	sp,sp,-16
 650:	e422                	sd	s0,8(sp)
 652:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 654:	ca05                	beqz	a2,684 <memcmp+0x36>
 656:	fff6069b          	addiw	a3,a2,-1
 65a:	1682                	slli	a3,a3,0x20
 65c:	9281                	srli	a3,a3,0x20
 65e:	0685                	addi	a3,a3,1
 660:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 662:	00054783          	lbu	a5,0(a0)
 666:	0005c703          	lbu	a4,0(a1)
 66a:	00e79863          	bne	a5,a4,67a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 66e:	0505                	addi	a0,a0,1
    p2++;
 670:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 672:	fed518e3          	bne	a0,a3,662 <memcmp+0x14>
  }
  return 0;
 676:	4501                	li	a0,0
 678:	a019                	j	67e <memcmp+0x30>
      return *p1 - *p2;
 67a:	40e7853b          	subw	a0,a5,a4
}
 67e:	6422                	ld	s0,8(sp)
 680:	0141                	addi	sp,sp,16
 682:	8082                	ret
  return 0;
 684:	4501                	li	a0,0
 686:	bfe5                	j	67e <memcmp+0x30>

0000000000000688 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 688:	1141                	addi	sp,sp,-16
 68a:	e406                	sd	ra,8(sp)
 68c:	e022                	sd	s0,0(sp)
 68e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 690:	00000097          	auipc	ra,0x0
 694:	f66080e7          	jalr	-154(ra) # 5f6 <memmove>
}
 698:	60a2                	ld	ra,8(sp)
 69a:	6402                	ld	s0,0(sp)
 69c:	0141                	addi	sp,sp,16
 69e:	8082                	ret

00000000000006a0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 6a0:	4885                	li	a7,1
 ecall
 6a2:	00000073          	ecall
 ret
 6a6:	8082                	ret

00000000000006a8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 6a8:	4889                	li	a7,2
 ecall
 6aa:	00000073          	ecall
 ret
 6ae:	8082                	ret

00000000000006b0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 6b0:	488d                	li	a7,3
 ecall
 6b2:	00000073          	ecall
 ret
 6b6:	8082                	ret

00000000000006b8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 6b8:	4891                	li	a7,4
 ecall
 6ba:	00000073          	ecall
 ret
 6be:	8082                	ret

00000000000006c0 <read>:
.global read
read:
 li a7, SYS_read
 6c0:	4895                	li	a7,5
 ecall
 6c2:	00000073          	ecall
 ret
 6c6:	8082                	ret

00000000000006c8 <write>:
.global write
write:
 li a7, SYS_write
 6c8:	48c1                	li	a7,16
 ecall
 6ca:	00000073          	ecall
 ret
 6ce:	8082                	ret

00000000000006d0 <close>:
.global close
close:
 li a7, SYS_close
 6d0:	48d5                	li	a7,21
 ecall
 6d2:	00000073          	ecall
 ret
 6d6:	8082                	ret

00000000000006d8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6d8:	4899                	li	a7,6
 ecall
 6da:	00000073          	ecall
 ret
 6de:	8082                	ret

00000000000006e0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6e0:	489d                	li	a7,7
 ecall
 6e2:	00000073          	ecall
 ret
 6e6:	8082                	ret

00000000000006e8 <open>:
.global open
open:
 li a7, SYS_open
 6e8:	48bd                	li	a7,15
 ecall
 6ea:	00000073          	ecall
 ret
 6ee:	8082                	ret

00000000000006f0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6f0:	48c5                	li	a7,17
 ecall
 6f2:	00000073          	ecall
 ret
 6f6:	8082                	ret

00000000000006f8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6f8:	48c9                	li	a7,18
 ecall
 6fa:	00000073          	ecall
 ret
 6fe:	8082                	ret

0000000000000700 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 700:	48a1                	li	a7,8
 ecall
 702:	00000073          	ecall
 ret
 706:	8082                	ret

0000000000000708 <link>:
.global link
link:
 li a7, SYS_link
 708:	48cd                	li	a7,19
 ecall
 70a:	00000073          	ecall
 ret
 70e:	8082                	ret

0000000000000710 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 710:	48d1                	li	a7,20
 ecall
 712:	00000073          	ecall
 ret
 716:	8082                	ret

0000000000000718 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 718:	48a5                	li	a7,9
 ecall
 71a:	00000073          	ecall
 ret
 71e:	8082                	ret

0000000000000720 <dup>:
.global dup
dup:
 li a7, SYS_dup
 720:	48a9                	li	a7,10
 ecall
 722:	00000073          	ecall
 ret
 726:	8082                	ret

0000000000000728 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 728:	48ad                	li	a7,11
 ecall
 72a:	00000073          	ecall
 ret
 72e:	8082                	ret

0000000000000730 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 730:	48b1                	li	a7,12
 ecall
 732:	00000073          	ecall
 ret
 736:	8082                	ret

0000000000000738 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 738:	48b5                	li	a7,13
 ecall
 73a:	00000073          	ecall
 ret
 73e:	8082                	ret

0000000000000740 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 740:	48b9                	li	a7,14
 ecall
 742:	00000073          	ecall
 ret
 746:	8082                	ret

0000000000000748 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 748:	48d9                	li	a7,22
 ecall
 74a:	00000073          	ecall
 ret
 74e:	8082                	ret

0000000000000750 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 750:	1101                	addi	sp,sp,-32
 752:	ec06                	sd	ra,24(sp)
 754:	e822                	sd	s0,16(sp)
 756:	1000                	addi	s0,sp,32
 758:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 75c:	4605                	li	a2,1
 75e:	fef40593          	addi	a1,s0,-17
 762:	00000097          	auipc	ra,0x0
 766:	f66080e7          	jalr	-154(ra) # 6c8 <write>
}
 76a:	60e2                	ld	ra,24(sp)
 76c:	6442                	ld	s0,16(sp)
 76e:	6105                	addi	sp,sp,32
 770:	8082                	ret

0000000000000772 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 772:	7139                	addi	sp,sp,-64
 774:	fc06                	sd	ra,56(sp)
 776:	f822                	sd	s0,48(sp)
 778:	f426                	sd	s1,40(sp)
 77a:	f04a                	sd	s2,32(sp)
 77c:	ec4e                	sd	s3,24(sp)
 77e:	0080                	addi	s0,sp,64
 780:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 782:	c299                	beqz	a3,788 <printint+0x16>
 784:	0805c863          	bltz	a1,814 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 788:	2581                	sext.w	a1,a1
  neg = 0;
 78a:	4881                	li	a7,0
 78c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 790:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 792:	2601                	sext.w	a2,a2
 794:	00000517          	auipc	a0,0x0
 798:	55450513          	addi	a0,a0,1364 # ce8 <digits>
 79c:	883a                	mv	a6,a4
 79e:	2705                	addiw	a4,a4,1
 7a0:	02c5f7bb          	remuw	a5,a1,a2
 7a4:	1782                	slli	a5,a5,0x20
 7a6:	9381                	srli	a5,a5,0x20
 7a8:	97aa                	add	a5,a5,a0
 7aa:	0007c783          	lbu	a5,0(a5)
 7ae:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 7b2:	0005879b          	sext.w	a5,a1
 7b6:	02c5d5bb          	divuw	a1,a1,a2
 7ba:	0685                	addi	a3,a3,1
 7bc:	fec7f0e3          	bgeu	a5,a2,79c <printint+0x2a>
  if(neg)
 7c0:	00088b63          	beqz	a7,7d6 <printint+0x64>
    buf[i++] = '-';
 7c4:	fd040793          	addi	a5,s0,-48
 7c8:	973e                	add	a4,a4,a5
 7ca:	02d00793          	li	a5,45
 7ce:	fef70823          	sb	a5,-16(a4)
 7d2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7d6:	02e05863          	blez	a4,806 <printint+0x94>
 7da:	fc040793          	addi	a5,s0,-64
 7de:	00e78933          	add	s2,a5,a4
 7e2:	fff78993          	addi	s3,a5,-1
 7e6:	99ba                	add	s3,s3,a4
 7e8:	377d                	addiw	a4,a4,-1
 7ea:	1702                	slli	a4,a4,0x20
 7ec:	9301                	srli	a4,a4,0x20
 7ee:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7f2:	fff94583          	lbu	a1,-1(s2)
 7f6:	8526                	mv	a0,s1
 7f8:	00000097          	auipc	ra,0x0
 7fc:	f58080e7          	jalr	-168(ra) # 750 <putc>
  while(--i >= 0)
 800:	197d                	addi	s2,s2,-1
 802:	ff3918e3          	bne	s2,s3,7f2 <printint+0x80>
}
 806:	70e2                	ld	ra,56(sp)
 808:	7442                	ld	s0,48(sp)
 80a:	74a2                	ld	s1,40(sp)
 80c:	7902                	ld	s2,32(sp)
 80e:	69e2                	ld	s3,24(sp)
 810:	6121                	addi	sp,sp,64
 812:	8082                	ret
    x = -xx;
 814:	40b005bb          	negw	a1,a1
    neg = 1;
 818:	4885                	li	a7,1
    x = -xx;
 81a:	bf8d                	j	78c <printint+0x1a>

000000000000081c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 81c:	7119                	addi	sp,sp,-128
 81e:	fc86                	sd	ra,120(sp)
 820:	f8a2                	sd	s0,112(sp)
 822:	f4a6                	sd	s1,104(sp)
 824:	f0ca                	sd	s2,96(sp)
 826:	ecce                	sd	s3,88(sp)
 828:	e8d2                	sd	s4,80(sp)
 82a:	e4d6                	sd	s5,72(sp)
 82c:	e0da                	sd	s6,64(sp)
 82e:	fc5e                	sd	s7,56(sp)
 830:	f862                	sd	s8,48(sp)
 832:	f466                	sd	s9,40(sp)
 834:	f06a                	sd	s10,32(sp)
 836:	ec6e                	sd	s11,24(sp)
 838:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 83a:	0005c903          	lbu	s2,0(a1)
 83e:	18090f63          	beqz	s2,9dc <vprintf+0x1c0>
 842:	8aaa                	mv	s5,a0
 844:	8b32                	mv	s6,a2
 846:	00158493          	addi	s1,a1,1
  state = 0;
 84a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 84c:	02500a13          	li	s4,37
      if(c == 'd'){
 850:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 854:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 858:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 85c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 860:	00000b97          	auipc	s7,0x0
 864:	488b8b93          	addi	s7,s7,1160 # ce8 <digits>
 868:	a839                	j	886 <vprintf+0x6a>
        putc(fd, c);
 86a:	85ca                	mv	a1,s2
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	ee2080e7          	jalr	-286(ra) # 750 <putc>
 876:	a019                	j	87c <vprintf+0x60>
    } else if(state == '%'){
 878:	01498f63          	beq	s3,s4,896 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 87c:	0485                	addi	s1,s1,1
 87e:	fff4c903          	lbu	s2,-1(s1)
 882:	14090d63          	beqz	s2,9dc <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 886:	0009079b          	sext.w	a5,s2
    if(state == 0){
 88a:	fe0997e3          	bnez	s3,878 <vprintf+0x5c>
      if(c == '%'){
 88e:	fd479ee3          	bne	a5,s4,86a <vprintf+0x4e>
        state = '%';
 892:	89be                	mv	s3,a5
 894:	b7e5                	j	87c <vprintf+0x60>
      if(c == 'd'){
 896:	05878063          	beq	a5,s8,8d6 <vprintf+0xba>
      } else if(c == 'l') {
 89a:	05978c63          	beq	a5,s9,8f2 <vprintf+0xd6>
      } else if(c == 'x') {
 89e:	07a78863          	beq	a5,s10,90e <vprintf+0xf2>
      } else if(c == 'p') {
 8a2:	09b78463          	beq	a5,s11,92a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 8a6:	07300713          	li	a4,115
 8aa:	0ce78663          	beq	a5,a4,976 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8ae:	06300713          	li	a4,99
 8b2:	0ee78e63          	beq	a5,a4,9ae <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 8b6:	11478863          	beq	a5,s4,9c6 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ba:	85d2                	mv	a1,s4
 8bc:	8556                	mv	a0,s5
 8be:	00000097          	auipc	ra,0x0
 8c2:	e92080e7          	jalr	-366(ra) # 750 <putc>
        putc(fd, c);
 8c6:	85ca                	mv	a1,s2
 8c8:	8556                	mv	a0,s5
 8ca:	00000097          	auipc	ra,0x0
 8ce:	e86080e7          	jalr	-378(ra) # 750 <putc>
      }
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	b765                	j	87c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8d6:	008b0913          	addi	s2,s6,8
 8da:	4685                	li	a3,1
 8dc:	4629                	li	a2,10
 8de:	000b2583          	lw	a1,0(s6)
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	e8e080e7          	jalr	-370(ra) # 772 <printint>
 8ec:	8b4a                	mv	s6,s2
      state = 0;
 8ee:	4981                	li	s3,0
 8f0:	b771                	j	87c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8f2:	008b0913          	addi	s2,s6,8
 8f6:	4681                	li	a3,0
 8f8:	4629                	li	a2,10
 8fa:	000b2583          	lw	a1,0(s6)
 8fe:	8556                	mv	a0,s5
 900:	00000097          	auipc	ra,0x0
 904:	e72080e7          	jalr	-398(ra) # 772 <printint>
 908:	8b4a                	mv	s6,s2
      state = 0;
 90a:	4981                	li	s3,0
 90c:	bf85                	j	87c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 90e:	008b0913          	addi	s2,s6,8
 912:	4681                	li	a3,0
 914:	4641                	li	a2,16
 916:	000b2583          	lw	a1,0(s6)
 91a:	8556                	mv	a0,s5
 91c:	00000097          	auipc	ra,0x0
 920:	e56080e7          	jalr	-426(ra) # 772 <printint>
 924:	8b4a                	mv	s6,s2
      state = 0;
 926:	4981                	li	s3,0
 928:	bf91                	j	87c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 92a:	008b0793          	addi	a5,s6,8
 92e:	f8f43423          	sd	a5,-120(s0)
 932:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 936:	03000593          	li	a1,48
 93a:	8556                	mv	a0,s5
 93c:	00000097          	auipc	ra,0x0
 940:	e14080e7          	jalr	-492(ra) # 750 <putc>
  putc(fd, 'x');
 944:	85ea                	mv	a1,s10
 946:	8556                	mv	a0,s5
 948:	00000097          	auipc	ra,0x0
 94c:	e08080e7          	jalr	-504(ra) # 750 <putc>
 950:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 952:	03c9d793          	srli	a5,s3,0x3c
 956:	97de                	add	a5,a5,s7
 958:	0007c583          	lbu	a1,0(a5)
 95c:	8556                	mv	a0,s5
 95e:	00000097          	auipc	ra,0x0
 962:	df2080e7          	jalr	-526(ra) # 750 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 966:	0992                	slli	s3,s3,0x4
 968:	397d                	addiw	s2,s2,-1
 96a:	fe0914e3          	bnez	s2,952 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 96e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 972:	4981                	li	s3,0
 974:	b721                	j	87c <vprintf+0x60>
        s = va_arg(ap, char*);
 976:	008b0993          	addi	s3,s6,8
 97a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 97e:	02090163          	beqz	s2,9a0 <vprintf+0x184>
        while(*s != 0){
 982:	00094583          	lbu	a1,0(s2)
 986:	c9a1                	beqz	a1,9d6 <vprintf+0x1ba>
          putc(fd, *s);
 988:	8556                	mv	a0,s5
 98a:	00000097          	auipc	ra,0x0
 98e:	dc6080e7          	jalr	-570(ra) # 750 <putc>
          s++;
 992:	0905                	addi	s2,s2,1
        while(*s != 0){
 994:	00094583          	lbu	a1,0(s2)
 998:	f9e5                	bnez	a1,988 <vprintf+0x16c>
        s = va_arg(ap, char*);
 99a:	8b4e                	mv	s6,s3
      state = 0;
 99c:	4981                	li	s3,0
 99e:	bdf9                	j	87c <vprintf+0x60>
          s = "(null)";
 9a0:	00000917          	auipc	s2,0x0
 9a4:	34090913          	addi	s2,s2,832 # ce0 <malloc+0x1fa>
        while(*s != 0){
 9a8:	02800593          	li	a1,40
 9ac:	bff1                	j	988 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 9ae:	008b0913          	addi	s2,s6,8
 9b2:	000b4583          	lbu	a1,0(s6)
 9b6:	8556                	mv	a0,s5
 9b8:	00000097          	auipc	ra,0x0
 9bc:	d98080e7          	jalr	-616(ra) # 750 <putc>
 9c0:	8b4a                	mv	s6,s2
      state = 0;
 9c2:	4981                	li	s3,0
 9c4:	bd65                	j	87c <vprintf+0x60>
        putc(fd, c);
 9c6:	85d2                	mv	a1,s4
 9c8:	8556                	mv	a0,s5
 9ca:	00000097          	auipc	ra,0x0
 9ce:	d86080e7          	jalr	-634(ra) # 750 <putc>
      state = 0;
 9d2:	4981                	li	s3,0
 9d4:	b565                	j	87c <vprintf+0x60>
        s = va_arg(ap, char*);
 9d6:	8b4e                	mv	s6,s3
      state = 0;
 9d8:	4981                	li	s3,0
 9da:	b54d                	j	87c <vprintf+0x60>
    }
  }
}
 9dc:	70e6                	ld	ra,120(sp)
 9de:	7446                	ld	s0,112(sp)
 9e0:	74a6                	ld	s1,104(sp)
 9e2:	7906                	ld	s2,96(sp)
 9e4:	69e6                	ld	s3,88(sp)
 9e6:	6a46                	ld	s4,80(sp)
 9e8:	6aa6                	ld	s5,72(sp)
 9ea:	6b06                	ld	s6,64(sp)
 9ec:	7be2                	ld	s7,56(sp)
 9ee:	7c42                	ld	s8,48(sp)
 9f0:	7ca2                	ld	s9,40(sp)
 9f2:	7d02                	ld	s10,32(sp)
 9f4:	6de2                	ld	s11,24(sp)
 9f6:	6109                	addi	sp,sp,128
 9f8:	8082                	ret

00000000000009fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9fa:	715d                	addi	sp,sp,-80
 9fc:	ec06                	sd	ra,24(sp)
 9fe:	e822                	sd	s0,16(sp)
 a00:	1000                	addi	s0,sp,32
 a02:	e010                	sd	a2,0(s0)
 a04:	e414                	sd	a3,8(s0)
 a06:	e818                	sd	a4,16(s0)
 a08:	ec1c                	sd	a5,24(s0)
 a0a:	03043023          	sd	a6,32(s0)
 a0e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 a12:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 a16:	8622                	mv	a2,s0
 a18:	00000097          	auipc	ra,0x0
 a1c:	e04080e7          	jalr	-508(ra) # 81c <vprintf>
}
 a20:	60e2                	ld	ra,24(sp)
 a22:	6442                	ld	s0,16(sp)
 a24:	6161                	addi	sp,sp,80
 a26:	8082                	ret

0000000000000a28 <printf>:

void
printf(const char *fmt, ...)
{
 a28:	711d                	addi	sp,sp,-96
 a2a:	ec06                	sd	ra,24(sp)
 a2c:	e822                	sd	s0,16(sp)
 a2e:	1000                	addi	s0,sp,32
 a30:	e40c                	sd	a1,8(s0)
 a32:	e810                	sd	a2,16(s0)
 a34:	ec14                	sd	a3,24(s0)
 a36:	f018                	sd	a4,32(s0)
 a38:	f41c                	sd	a5,40(s0)
 a3a:	03043823          	sd	a6,48(s0)
 a3e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a42:	00840613          	addi	a2,s0,8
 a46:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a4a:	85aa                	mv	a1,a0
 a4c:	4505                	li	a0,1
 a4e:	00000097          	auipc	ra,0x0
 a52:	dce080e7          	jalr	-562(ra) # 81c <vprintf>
}
 a56:	60e2                	ld	ra,24(sp)
 a58:	6442                	ld	s0,16(sp)
 a5a:	6125                	addi	sp,sp,96
 a5c:	8082                	ret

0000000000000a5e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a5e:	1141                	addi	sp,sp,-16
 a60:	e422                	sd	s0,8(sp)
 a62:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a64:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a68:	00000797          	auipc	a5,0x0
 a6c:	2987b783          	ld	a5,664(a5) # d00 <freep>
 a70:	a805                	j	aa0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a72:	4618                	lw	a4,8(a2)
 a74:	9db9                	addw	a1,a1,a4
 a76:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a7a:	6398                	ld	a4,0(a5)
 a7c:	6318                	ld	a4,0(a4)
 a7e:	fee53823          	sd	a4,-16(a0)
 a82:	a091                	j	ac6 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a84:	ff852703          	lw	a4,-8(a0)
 a88:	9e39                	addw	a2,a2,a4
 a8a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a8c:	ff053703          	ld	a4,-16(a0)
 a90:	e398                	sd	a4,0(a5)
 a92:	a099                	j	ad8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a94:	6398                	ld	a4,0(a5)
 a96:	00e7e463          	bltu	a5,a4,a9e <free+0x40>
 a9a:	00e6ea63          	bltu	a3,a4,aae <free+0x50>
{
 a9e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 aa0:	fed7fae3          	bgeu	a5,a3,a94 <free+0x36>
 aa4:	6398                	ld	a4,0(a5)
 aa6:	00e6e463          	bltu	a3,a4,aae <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 aaa:	fee7eae3          	bltu	a5,a4,a9e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 aae:	ff852583          	lw	a1,-8(a0)
 ab2:	6390                	ld	a2,0(a5)
 ab4:	02059813          	slli	a6,a1,0x20
 ab8:	01c85713          	srli	a4,a6,0x1c
 abc:	9736                	add	a4,a4,a3
 abe:	fae60ae3          	beq	a2,a4,a72 <free+0x14>
    bp->s.ptr = p->s.ptr;
 ac2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 ac6:	4790                	lw	a2,8(a5)
 ac8:	02061593          	slli	a1,a2,0x20
 acc:	01c5d713          	srli	a4,a1,0x1c
 ad0:	973e                	add	a4,a4,a5
 ad2:	fae689e3          	beq	a3,a4,a84 <free+0x26>
  } else
    p->s.ptr = bp;
 ad6:	e394                	sd	a3,0(a5)
  freep = p;
 ad8:	00000717          	auipc	a4,0x0
 adc:	22f73423          	sd	a5,552(a4) # d00 <freep>
}
 ae0:	6422                	ld	s0,8(sp)
 ae2:	0141                	addi	sp,sp,16
 ae4:	8082                	ret

0000000000000ae6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ae6:	7139                	addi	sp,sp,-64
 ae8:	fc06                	sd	ra,56(sp)
 aea:	f822                	sd	s0,48(sp)
 aec:	f426                	sd	s1,40(sp)
 aee:	f04a                	sd	s2,32(sp)
 af0:	ec4e                	sd	s3,24(sp)
 af2:	e852                	sd	s4,16(sp)
 af4:	e456                	sd	s5,8(sp)
 af6:	e05a                	sd	s6,0(sp)
 af8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 afa:	02051493          	slli	s1,a0,0x20
 afe:	9081                	srli	s1,s1,0x20
 b00:	04bd                	addi	s1,s1,15
 b02:	8091                	srli	s1,s1,0x4
 b04:	0014899b          	addiw	s3,s1,1
 b08:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 b0a:	00000517          	auipc	a0,0x0
 b0e:	1f653503          	ld	a0,502(a0) # d00 <freep>
 b12:	c515                	beqz	a0,b3e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b14:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b16:	4798                	lw	a4,8(a5)
 b18:	02977f63          	bgeu	a4,s1,b56 <malloc+0x70>
 b1c:	8a4e                	mv	s4,s3
 b1e:	0009871b          	sext.w	a4,s3
 b22:	6685                	lui	a3,0x1
 b24:	00d77363          	bgeu	a4,a3,b2a <malloc+0x44>
 b28:	6a05                	lui	s4,0x1
 b2a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 b2e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b32:	00000917          	auipc	s2,0x0
 b36:	1ce90913          	addi	s2,s2,462 # d00 <freep>
  if(p == (char*)-1)
 b3a:	5afd                	li	s5,-1
 b3c:	a895                	j	bb0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b3e:	00000797          	auipc	a5,0x0
 b42:	2ba78793          	addi	a5,a5,698 # df8 <base>
 b46:	00000717          	auipc	a4,0x0
 b4a:	1af73d23          	sd	a5,442(a4) # d00 <freep>
 b4e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b50:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b54:	b7e1                	j	b1c <malloc+0x36>
      if(p->s.size == nunits)
 b56:	02e48c63          	beq	s1,a4,b8e <malloc+0xa8>
        p->s.size -= nunits;
 b5a:	4137073b          	subw	a4,a4,s3
 b5e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b60:	02071693          	slli	a3,a4,0x20
 b64:	01c6d713          	srli	a4,a3,0x1c
 b68:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b6a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b6e:	00000717          	auipc	a4,0x0
 b72:	18a73923          	sd	a0,402(a4) # d00 <freep>
      return (void*)(p + 1);
 b76:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b7a:	70e2                	ld	ra,56(sp)
 b7c:	7442                	ld	s0,48(sp)
 b7e:	74a2                	ld	s1,40(sp)
 b80:	7902                	ld	s2,32(sp)
 b82:	69e2                	ld	s3,24(sp)
 b84:	6a42                	ld	s4,16(sp)
 b86:	6aa2                	ld	s5,8(sp)
 b88:	6b02                	ld	s6,0(sp)
 b8a:	6121                	addi	sp,sp,64
 b8c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b8e:	6398                	ld	a4,0(a5)
 b90:	e118                	sd	a4,0(a0)
 b92:	bff1                	j	b6e <malloc+0x88>
  hp->s.size = nu;
 b94:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b98:	0541                	addi	a0,a0,16
 b9a:	00000097          	auipc	ra,0x0
 b9e:	ec4080e7          	jalr	-316(ra) # a5e <free>
  return freep;
 ba2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ba6:	d971                	beqz	a0,b7a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 baa:	4798                	lw	a4,8(a5)
 bac:	fa9775e3          	bgeu	a4,s1,b56 <malloc+0x70>
    if(p == freep)
 bb0:	00093703          	ld	a4,0(s2)
 bb4:	853e                	mv	a0,a5
 bb6:	fef719e3          	bne	a4,a5,ba8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 bba:	8552                	mv	a0,s4
 bbc:	00000097          	auipc	ra,0x0
 bc0:	b74080e7          	jalr	-1164(ra) # 730 <sbrk>
  if(p == (char*)-1)
 bc4:	fd5518e3          	bne	a0,s5,b94 <malloc+0xae>
        return 0;
 bc8:	4501                	li	a0,0
 bca:	bf45                	j	b7a <malloc+0x94>
