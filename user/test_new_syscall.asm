
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
  26:	ec56                	sd	s5,24(sp)
  28:	0880                	addi	s0,sp,80
  int ring_desc = create_or_close_the_buffer_user("ring", 1);
  2a:	4585                	li	a1,1
  2c:	00001517          	auipc	a0,0x1
  30:	b6c50513          	addi	a0,a0,-1172 # b98 <malloc+0xe8>
  34:	00000097          	auipc	ra,0x0
  38:	1ba080e7          	jalr	442(ra) # 1ee <create_or_close_the_buffer_user>
  3c:	89aa                	mv	s3,a0
  uint64 addri = 0; // = (uint64 *)0;
  3e:	fa043c23          	sd	zero,-72(s0)
  uint64* addr = &addri;
  int bytesi = 0; // = (int *) 0;
  42:	fa042a23          	sw	zero,-76(s0)
  int bytes_want_to_read = 13;// 65536;//(10485760/8);

  // int start_time, elasped_time;
  // start_time = uptime();

  printf("before write addr %d\n", addr);
  46:	fb840593          	addi	a1,s0,-72
  4a:	00001517          	auipc	a0,0x1
  4e:	b5650513          	addi	a0,a0,-1194 # ba0 <malloc+0xf0>
  52:	00001097          	auipc	ra,0x1
  56:	9a0080e7          	jalr	-1632(ra) # 9f2 <printf>
  printf("before write bytes %d\n", bytes);
  5a:	fb440593          	addi	a1,s0,-76
  5e:	00001517          	auipc	a0,0x1
  62:	b5a50513          	addi	a0,a0,-1190 # bb8 <malloc+0x108>
  66:	00001097          	auipc	ra,0x1
  6a:	98c080e7          	jalr	-1652(ra) # 9f2 <printf>
//start here
  ringbuf_start_write(ring_desc, addr, bytes);
  6e:	fb440613          	addi	a2,s0,-76
  72:	fb840593          	addi	a1,s0,-72
  76:	854e                	mv	a0,s3
  78:	00000097          	auipc	ra,0x0
  7c:	214080e7          	jalr	532(ra) # 28c <ringbuf_start_write>
  printf("after start_write addr %d\n", addr);
  80:	fb840593          	addi	a1,s0,-72
  84:	00001517          	auipc	a0,0x1
  88:	b4c50513          	addi	a0,a0,-1204 # bd0 <malloc+0x120>
  8c:	00001097          	auipc	ra,0x1
  90:	966080e7          	jalr	-1690(ra) # 9f2 <printf>
  printf("after start_write bytes %d\n\n", *bytes);
  94:	fb442583          	lw	a1,-76(s0)
  98:	00001517          	auipc	a0,0x1
  9c:	b5850513          	addi	a0,a0,-1192 # bf0 <malloc+0x140>
  a0:	00001097          	auipc	ra,0x1
  a4:	952080e7          	jalr	-1710(ra) # 9f2 <printf>

  if(bytes_want_to_read < *bytes){
  a8:	fb442583          	lw	a1,-76(s0)
  ac:	47b5                	li	a5,13
  ae:	04b7c163          	blt	a5,a1,f0 <main+0xd8>
      printf("written on address %d\n", addr + i);
    }
    ringbuf_finish_write(ring_desc, bytes_want_to_read);
  }
  else{
    for(int i=0; i < *bytes; i++){
  b2:	fb840913          	addi	s2,s0,-72
  b6:	4481                	li	s1,0
      addr[i] = i;
      printf("written on address %d\n", addr + i);
  b8:	00001a17          	auipc	s4,0x1
  bc:	b58a0a13          	addi	s4,s4,-1192 # c10 <malloc+0x160>
    for(int i=0; i < *bytes; i++){
  c0:	02b05263          	blez	a1,e4 <main+0xcc>
      addr[i] = i;
  c4:	00993023          	sd	s1,0(s2)
      printf("written on address %d\n", addr + i);
  c8:	85ca                	mv	a1,s2
  ca:	8552                	mv	a0,s4
  cc:	00001097          	auipc	ra,0x1
  d0:	926080e7          	jalr	-1754(ra) # 9f2 <printf>
    for(int i=0; i < *bytes; i++){
  d4:	fb442583          	lw	a1,-76(s0)
  d8:	0485                	addi	s1,s1,1
  da:	0921                	addi	s2,s2,8
  dc:	0004879b          	sext.w	a5,s1
  e0:	feb7c2e3          	blt	a5,a1,c4 <main+0xac>
    }
    ringbuf_finish_write(ring_desc, *bytes);
  e4:	854e                	mv	a0,s3
  e6:	00000097          	auipc	ra,0x0
  ea:	22c080e7          	jalr	556(ra) # 312 <ringbuf_finish_write>
  ee:	a81d                	j	124 <main+0x10c>
  f0:	fb840913          	addi	s2,s0,-72
  if(bytes_want_to_read < *bytes){
  f4:	4481                	li	s1,0
      printf("written on address %d\n", addr + i);
  f6:	00001a97          	auipc	s5,0x1
  fa:	b1aa8a93          	addi	s5,s5,-1254 # c10 <malloc+0x160>
    for(int i=0; i < bytes_want_to_read; i++){
  fe:	4a35                	li	s4,13
      addr[i] = i;
 100:	00993023          	sd	s1,0(s2)
      printf("written on address %d\n", addr + i);
 104:	85ca                	mv	a1,s2
 106:	8556                	mv	a0,s5
 108:	00001097          	auipc	ra,0x1
 10c:	8ea080e7          	jalr	-1814(ra) # 9f2 <printf>
    for(int i=0; i < bytes_want_to_read; i++){
 110:	0485                	addi	s1,s1,1
 112:	0921                	addi	s2,s2,8
 114:	ff4496e3          	bne	s1,s4,100 <main+0xe8>
    ringbuf_finish_write(ring_desc, bytes_want_to_read);
 118:	45b5                	li	a1,13
 11a:	854e                	mv	a0,s3
 11c:	00000097          	auipc	ra,0x0
 120:	1f6080e7          	jalr	502(ra) # 312 <ringbuf_finish_write>
  }

  printf("\n\n");
 124:	00001517          	auipc	a0,0x1
 128:	b0450513          	addi	a0,a0,-1276 # c28 <malloc+0x178>
 12c:	00001097          	auipc	ra,0x1
 130:	8c6080e7          	jalr	-1850(ra) # 9f2 <printf>
  check_bytes_written(ring_desc, bytes);
 134:	fb440593          	addi	a1,s0,-76
 138:	854e                	mv	a0,s3
 13a:	00000097          	auipc	ra,0x0
 13e:	20a080e7          	jalr	522(ra) # 344 <check_bytes_written>
  printf("after checking bytes written addr %d\n", *addr);
 142:	fb843583          	ld	a1,-72(s0)
 146:	00001517          	auipc	a0,0x1
 14a:	aea50513          	addi	a0,a0,-1302 # c30 <malloc+0x180>
 14e:	00001097          	auipc	ra,0x1
 152:	8a4080e7          	jalr	-1884(ra) # 9f2 <printf>
  printf("after checking bytes written bytes %d\n", *bytes);
 156:	fb442583          	lw	a1,-76(s0)
 15a:	00001517          	auipc	a0,0x1
 15e:	afe50513          	addi	a0,a0,-1282 # c58 <malloc+0x1a8>
 162:	00001097          	auipc	ra,0x1
 166:	890080e7          	jalr	-1904(ra) # 9f2 <printf>

  ringbuf_start_read(ring_desc, addr, bytes);
 16a:	fb440613          	addi	a2,s0,-76
 16e:	fb840593          	addi	a1,s0,-72
 172:	854e                	mv	a0,s3
 174:	00000097          	auipc	ra,0x0
 178:	206080e7          	jalr	518(ra) # 37a <ringbuf_start_read>
  // printf("\nThe data written is shown below\n");
  for(int i=0; i < *bytes; i++){
 17c:	fb442583          	lw	a1,-76(s0)
 180:	00b05663          	blez	a1,18c <main+0x174>
 184:	4781                	li	a5,0
 186:	2785                	addiw	a5,a5,1
 188:	feb79fe3          	bne	a5,a1,186 <main+0x16e>
    // printf(" %d ", addr[i]);
  }
  ringbuf_finish_read(ring_desc, *bytes);
 18c:	854e                	mv	a0,s3
 18e:	00000097          	auipc	ra,0x0
 192:	246080e7          	jalr	582(ra) # 3d4 <ringbuf_finish_read>
  printf("\n\n");
 196:	00001517          	auipc	a0,0x1
 19a:	a9250513          	addi	a0,a0,-1390 # c28 <malloc+0x178>
 19e:	00001097          	auipc	ra,0x1
 1a2:	854080e7          	jalr	-1964(ra) # 9f2 <printf>

  // elasped_time = uptime()-start_time;
  // printf("Elasped time is %d\n\n", elasped_time);

  create_or_close_the_buffer_user("ring", 0);
 1a6:	4581                	li	a1,0
 1a8:	00001517          	auipc	a0,0x1
 1ac:	9f050513          	addi	a0,a0,-1552 # b98 <malloc+0xe8>
 1b0:	00000097          	auipc	ra,0x0
 1b4:	03e080e7          	jalr	62(ra) # 1ee <create_or_close_the_buffer_user>

  exit(0);
 1b8:	4501                	li	a0,0
 1ba:	00000097          	auipc	ra,0x0
 1be:	4b8080e7          	jalr	1208(ra) # 672 <exit>

00000000000001c2 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 1c2:	1141                	addi	sp,sp,-16
 1c4:	e422                	sd	s0,8(sp)
 1c6:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 1c8:	0f50000f          	fence	iorw,ow
 1cc:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 1d0:	6422                	ld	s0,8(sp)
 1d2:	0141                	addi	sp,sp,16
 1d4:	8082                	ret

00000000000001d6 <load>:

int load(uint64 *p) {
 1d6:	1141                	addi	sp,sp,-16
 1d8:	e422                	sd	s0,8(sp)
 1da:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 1dc:	0ff0000f          	fence
 1e0:	6108                	ld	a0,0(a0)
 1e2:	0ff0000f          	fence
}
 1e6:	2501                	sext.w	a0,a0
 1e8:	6422                	ld	s0,8(sp)
 1ea:	0141                	addi	sp,sp,16
 1ec:	8082                	ret

00000000000001ee <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 1ee:	7179                	addi	sp,sp,-48
 1f0:	f406                	sd	ra,40(sp)
 1f2:	f022                	sd	s0,32(sp)
 1f4:	ec26                	sd	s1,24(sp)
 1f6:	e84a                	sd	s2,16(sp)
 1f8:	e44e                	sd	s3,8(sp)
 1fa:	e052                	sd	s4,0(sp)
 1fc:	1800                	addi	s0,sp,48
 1fe:	8a2a                	mv	s4,a0
 200:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 202:	4785                	li	a5,1
 204:	00001497          	auipc	s1,0x1
 208:	ab448493          	addi	s1,s1,-1356 # cb8 <rings+0x10>
 20c:	00001917          	auipc	s2,0x1
 210:	b9c90913          	addi	s2,s2,-1124 # da8 <__BSS_END__>
 214:	04f59563          	bne	a1,a5,25e <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 218:	00001497          	auipc	s1,0x1
 21c:	aa04a483          	lw	s1,-1376(s1) # cb8 <rings+0x10>
 220:	c099                	beqz	s1,226 <create_or_close_the_buffer_user+0x38>
 222:	4481                	li	s1,0
 224:	a899                	j	27a <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 226:	00001917          	auipc	s2,0x1
 22a:	a8290913          	addi	s2,s2,-1406 # ca8 <rings>
 22e:	00093603          	ld	a2,0(s2)
 232:	4585                	li	a1,1
 234:	00000097          	auipc	ra,0x0
 238:	4de080e7          	jalr	1246(ra) # 712 <ringbuf>
        rings[i].book->write_done = 0;
 23c:	00893783          	ld	a5,8(s2)
 240:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 244:	00893783          	ld	a5,8(s2)
 248:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 24c:	01092783          	lw	a5,16(s2)
 250:	2785                	addiw	a5,a5,1
 252:	00f92823          	sw	a5,16(s2)
        break;
 256:	a015                	j	27a <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 258:	04e1                	addi	s1,s1,24
 25a:	01248f63          	beq	s1,s2,278 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 25e:	409c                	lw	a5,0(s1)
 260:	dfe5                	beqz	a5,258 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 262:	ff04b603          	ld	a2,-16(s1)
 266:	85ce                	mv	a1,s3
 268:	8552                	mv	a0,s4
 26a:	00000097          	auipc	ra,0x0
 26e:	4a8080e7          	jalr	1192(ra) # 712 <ringbuf>
        rings[i].exists = 0;
 272:	0004a023          	sw	zero,0(s1)
 276:	b7cd                	j	258 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 278:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 27a:	8526                	mv	a0,s1
 27c:	70a2                	ld	ra,40(sp)
 27e:	7402                	ld	s0,32(sp)
 280:	64e2                	ld	s1,24(sp)
 282:	6942                	ld	s2,16(sp)
 284:	69a2                	ld	s3,8(sp)
 286:	6a02                	ld	s4,0(sp)
 288:	6145                	addi	sp,sp,48
 28a:	8082                	ret

000000000000028c <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 28c:	1101                	addi	sp,sp,-32
 28e:	ec06                	sd	ra,24(sp)
 290:	e822                	sd	s0,16(sp)
 292:	e426                	sd	s1,8(sp)
 294:	1000                	addi	s0,sp,32
 296:	84b2                	mv	s1,a2
  *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
 298:	00151793          	slli	a5,a0,0x1
 29c:	97aa                	add	a5,a5,a0
 29e:	078e                	slli	a5,a5,0x3
 2a0:	00001717          	auipc	a4,0x1
 2a4:	a0870713          	addi	a4,a4,-1528 # ca8 <rings>
 2a8:	97ba                	add	a5,a5,a4
 2aa:	6798                	ld	a4,8(a5)
 2ac:	671c                	ld	a5,8(a4)
 2ae:	00178693          	addi	a3,a5,1
 2b2:	e714                	sd	a3,8(a4)
 2b4:	17d2                	slli	a5,a5,0x34
 2b6:	93d1                	srli	a5,a5,0x34
 2b8:	6741                	lui	a4,0x10
 2ba:	40f707b3          	sub	a5,a4,a5
 2be:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 2c0:	421c                	lw	a5,0(a2)
 2c2:	e79d                	bnez	a5,2f0 <ringbuf_start_write+0x64>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 2c4:	00001697          	auipc	a3,0x1
 2c8:	9e468693          	addi	a3,a3,-1564 # ca8 <rings>
 2cc:	669c                	ld	a5,8(a3)
 2ce:	6398                	ld	a4,0(a5)
 2d0:	67c1                	lui	a5,0x10
 2d2:	9fb9                	addw	a5,a5,a4
 2d4:	00151713          	slli	a4,a0,0x1
 2d8:	953a                	add	a0,a0,a4
 2da:	050e                	slli	a0,a0,0x3
 2dc:	9536                	add	a0,a0,a3
 2de:	6518                	ld	a4,8(a0)
 2e0:	6718                	ld	a4,8(a4)
 2e2:	9f99                	subw	a5,a5,a4
 2e4:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 2e6:	60e2                	ld	ra,24(sp)
 2e8:	6442                	ld	s0,16(sp)
 2ea:	64a2                	ld	s1,8(sp)
 2ec:	6105                	addi	sp,sp,32
 2ee:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 2f0:	00151793          	slli	a5,a0,0x1
 2f4:	953e                	add	a0,a0,a5
 2f6:	050e                	slli	a0,a0,0x3
 2f8:	00001797          	auipc	a5,0x1
 2fc:	9b078793          	addi	a5,a5,-1616 # ca8 <rings>
 300:	953e                	add	a0,a0,a5
 302:	6508                	ld	a0,8(a0)
 304:	0521                	addi	a0,a0,8
 306:	00000097          	auipc	ra,0x0
 30a:	ed0080e7          	jalr	-304(ra) # 1d6 <load>
 30e:	c088                	sw	a0,0(s1)
}
 310:	bfd9                	j	2e6 <ringbuf_start_write+0x5a>

0000000000000312 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 312:	1141                	addi	sp,sp,-16
 314:	e406                	sd	ra,8(sp)
 316:	e022                	sd	s0,0(sp)
 318:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 31a:	00151793          	slli	a5,a0,0x1
 31e:	97aa                	add	a5,a5,a0
 320:	078e                	slli	a5,a5,0x3
 322:	00001517          	auipc	a0,0x1
 326:	98650513          	addi	a0,a0,-1658 # ca8 <rings>
 32a:	97aa                	add	a5,a5,a0
 32c:	6788                	ld	a0,8(a5)
 32e:	0035959b          	slliw	a1,a1,0x3
 332:	0521                	addi	a0,a0,8
 334:	00000097          	auipc	ra,0x0
 338:	e8e080e7          	jalr	-370(ra) # 1c2 <store>
}
 33c:	60a2                	ld	ra,8(sp)
 33e:	6402                	ld	s0,0(sp)
 340:	0141                	addi	sp,sp,16
 342:	8082                	ret

0000000000000344 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 344:	1101                	addi	sp,sp,-32
 346:	ec06                	sd	ra,24(sp)
 348:	e822                	sd	s0,16(sp)
 34a:	e426                	sd	s1,8(sp)
 34c:	1000                	addi	s0,sp,32
 34e:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 350:	00151793          	slli	a5,a0,0x1
 354:	97aa                	add	a5,a5,a0
 356:	078e                	slli	a5,a5,0x3
 358:	00001517          	auipc	a0,0x1
 35c:	95050513          	addi	a0,a0,-1712 # ca8 <rings>
 360:	97aa                	add	a5,a5,a0
 362:	6788                	ld	a0,8(a5)
 364:	0521                	addi	a0,a0,8
 366:	00000097          	auipc	ra,0x0
 36a:	e70080e7          	jalr	-400(ra) # 1d6 <load>
 36e:	c088                	sw	a0,0(s1)
}
 370:	60e2                	ld	ra,24(sp)
 372:	6442                	ld	s0,16(sp)
 374:	64a2                	ld	s1,8(sp)
 376:	6105                	addi	sp,sp,32
 378:	8082                	ret

000000000000037a <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 37a:	1101                	addi	sp,sp,-32
 37c:	ec06                	sd	ra,24(sp)
 37e:	e822                	sd	s0,16(sp)
 380:	e426                	sd	s1,8(sp)
 382:	1000                	addi	s0,sp,32
 384:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 386:	00151793          	slli	a5,a0,0x1
 38a:	97aa                	add	a5,a5,a0
 38c:	078e                	slli	a5,a5,0x3
 38e:	00001517          	auipc	a0,0x1
 392:	91a50513          	addi	a0,a0,-1766 # ca8 <rings>
 396:	97aa                	add	a5,a5,a0
 398:	6788                	ld	a0,8(a5)
 39a:	611c                	ld	a5,0(a0)
 39c:	ef99                	bnez	a5,3ba <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 39e:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 3a0:	41f7579b          	sraiw	a5,a4,0x1f
 3a4:	01d7d79b          	srliw	a5,a5,0x1d
 3a8:	9fb9                	addw	a5,a5,a4
 3aa:	4037d79b          	sraiw	a5,a5,0x3
 3ae:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 3b0:	60e2                	ld	ra,24(sp)
 3b2:	6442                	ld	s0,16(sp)
 3b4:	64a2                	ld	s1,8(sp)
 3b6:	6105                	addi	sp,sp,32
 3b8:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 3ba:	00000097          	auipc	ra,0x0
 3be:	e1c080e7          	jalr	-484(ra) # 1d6 <load>
    *bytes /= 8;
 3c2:	41f5579b          	sraiw	a5,a0,0x1f
 3c6:	01d7d79b          	srliw	a5,a5,0x1d
 3ca:	9d3d                	addw	a0,a0,a5
 3cc:	4035551b          	sraiw	a0,a0,0x3
 3d0:	c088                	sw	a0,0(s1)
}
 3d2:	bff9                	j	3b0 <ringbuf_start_read+0x36>

00000000000003d4 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 3d4:	1141                	addi	sp,sp,-16
 3d6:	e406                	sd	ra,8(sp)
 3d8:	e022                	sd	s0,0(sp)
 3da:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 3dc:	00151793          	slli	a5,a0,0x1
 3e0:	97aa                	add	a5,a5,a0
 3e2:	078e                	slli	a5,a5,0x3
 3e4:	00001517          	auipc	a0,0x1
 3e8:	8c450513          	addi	a0,a0,-1852 # ca8 <rings>
 3ec:	97aa                	add	a5,a5,a0
 3ee:	0035959b          	slliw	a1,a1,0x3
 3f2:	6788                	ld	a0,8(a5)
 3f4:	00000097          	auipc	ra,0x0
 3f8:	dce080e7          	jalr	-562(ra) # 1c2 <store>
}
 3fc:	60a2                	ld	ra,8(sp)
 3fe:	6402                	ld	s0,0(sp)
 400:	0141                	addi	sp,sp,16
 402:	8082                	ret

0000000000000404 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 404:	1141                	addi	sp,sp,-16
 406:	e422                	sd	s0,8(sp)
 408:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 40a:	87aa                	mv	a5,a0
 40c:	0585                	addi	a1,a1,1
 40e:	0785                	addi	a5,a5,1
 410:	fff5c703          	lbu	a4,-1(a1)
 414:	fee78fa3          	sb	a4,-1(a5)
 418:	fb75                	bnez	a4,40c <strcpy+0x8>
    ;
  return os;
}
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 426:	00054783          	lbu	a5,0(a0)
 42a:	cb91                	beqz	a5,43e <strcmp+0x1e>
 42c:	0005c703          	lbu	a4,0(a1)
 430:	00f71763          	bne	a4,a5,43e <strcmp+0x1e>
    p++, q++;
 434:	0505                	addi	a0,a0,1
 436:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 438:	00054783          	lbu	a5,0(a0)
 43c:	fbe5                	bnez	a5,42c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 43e:	0005c503          	lbu	a0,0(a1)
}
 442:	40a7853b          	subw	a0,a5,a0
 446:	6422                	ld	s0,8(sp)
 448:	0141                	addi	sp,sp,16
 44a:	8082                	ret

000000000000044c <strlen>:

uint
strlen(const char *s)
{
 44c:	1141                	addi	sp,sp,-16
 44e:	e422                	sd	s0,8(sp)
 450:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 452:	00054783          	lbu	a5,0(a0)
 456:	cf91                	beqz	a5,472 <strlen+0x26>
 458:	0505                	addi	a0,a0,1
 45a:	87aa                	mv	a5,a0
 45c:	4685                	li	a3,1
 45e:	9e89                	subw	a3,a3,a0
 460:	00f6853b          	addw	a0,a3,a5
 464:	0785                	addi	a5,a5,1
 466:	fff7c703          	lbu	a4,-1(a5)
 46a:	fb7d                	bnez	a4,460 <strlen+0x14>
    ;
  return n;
}
 46c:	6422                	ld	s0,8(sp)
 46e:	0141                	addi	sp,sp,16
 470:	8082                	ret
  for(n = 0; s[n]; n++)
 472:	4501                	li	a0,0
 474:	bfe5                	j	46c <strlen+0x20>

0000000000000476 <memset>:

void*
memset(void *dst, int c, uint n)
{
 476:	1141                	addi	sp,sp,-16
 478:	e422                	sd	s0,8(sp)
 47a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 47c:	ca19                	beqz	a2,492 <memset+0x1c>
 47e:	87aa                	mv	a5,a0
 480:	1602                	slli	a2,a2,0x20
 482:	9201                	srli	a2,a2,0x20
 484:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 488:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 48c:	0785                	addi	a5,a5,1
 48e:	fee79de3          	bne	a5,a4,488 <memset+0x12>
  }
  return dst;
}
 492:	6422                	ld	s0,8(sp)
 494:	0141                	addi	sp,sp,16
 496:	8082                	ret

0000000000000498 <strchr>:

char*
strchr(const char *s, char c)
{
 498:	1141                	addi	sp,sp,-16
 49a:	e422                	sd	s0,8(sp)
 49c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 49e:	00054783          	lbu	a5,0(a0)
 4a2:	cb99                	beqz	a5,4b8 <strchr+0x20>
    if(*s == c)
 4a4:	00f58763          	beq	a1,a5,4b2 <strchr+0x1a>
  for(; *s; s++)
 4a8:	0505                	addi	a0,a0,1
 4aa:	00054783          	lbu	a5,0(a0)
 4ae:	fbfd                	bnez	a5,4a4 <strchr+0xc>
      return (char*)s;
  return 0;
 4b0:	4501                	li	a0,0
}
 4b2:	6422                	ld	s0,8(sp)
 4b4:	0141                	addi	sp,sp,16
 4b6:	8082                	ret
  return 0;
 4b8:	4501                	li	a0,0
 4ba:	bfe5                	j	4b2 <strchr+0x1a>

00000000000004bc <gets>:

char*
gets(char *buf, int max)
{
 4bc:	711d                	addi	sp,sp,-96
 4be:	ec86                	sd	ra,88(sp)
 4c0:	e8a2                	sd	s0,80(sp)
 4c2:	e4a6                	sd	s1,72(sp)
 4c4:	e0ca                	sd	s2,64(sp)
 4c6:	fc4e                	sd	s3,56(sp)
 4c8:	f852                	sd	s4,48(sp)
 4ca:	f456                	sd	s5,40(sp)
 4cc:	f05a                	sd	s6,32(sp)
 4ce:	ec5e                	sd	s7,24(sp)
 4d0:	1080                	addi	s0,sp,96
 4d2:	8baa                	mv	s7,a0
 4d4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4d6:	892a                	mv	s2,a0
 4d8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4da:	4aa9                	li	s5,10
 4dc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4de:	89a6                	mv	s3,s1
 4e0:	2485                	addiw	s1,s1,1
 4e2:	0344d863          	bge	s1,s4,512 <gets+0x56>
    cc = read(0, &c, 1);
 4e6:	4605                	li	a2,1
 4e8:	faf40593          	addi	a1,s0,-81
 4ec:	4501                	li	a0,0
 4ee:	00000097          	auipc	ra,0x0
 4f2:	19c080e7          	jalr	412(ra) # 68a <read>
    if(cc < 1)
 4f6:	00a05e63          	blez	a0,512 <gets+0x56>
    buf[i++] = c;
 4fa:	faf44783          	lbu	a5,-81(s0)
 4fe:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 502:	01578763          	beq	a5,s5,510 <gets+0x54>
 506:	0905                	addi	s2,s2,1
 508:	fd679be3          	bne	a5,s6,4de <gets+0x22>
  for(i=0; i+1 < max; ){
 50c:	89a6                	mv	s3,s1
 50e:	a011                	j	512 <gets+0x56>
 510:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 512:	99de                	add	s3,s3,s7
 514:	00098023          	sb	zero,0(s3)
  return buf;
}
 518:	855e                	mv	a0,s7
 51a:	60e6                	ld	ra,88(sp)
 51c:	6446                	ld	s0,80(sp)
 51e:	64a6                	ld	s1,72(sp)
 520:	6906                	ld	s2,64(sp)
 522:	79e2                	ld	s3,56(sp)
 524:	7a42                	ld	s4,48(sp)
 526:	7aa2                	ld	s5,40(sp)
 528:	7b02                	ld	s6,32(sp)
 52a:	6be2                	ld	s7,24(sp)
 52c:	6125                	addi	sp,sp,96
 52e:	8082                	ret

0000000000000530 <stat>:

int
stat(const char *n, struct stat *st)
{
 530:	1101                	addi	sp,sp,-32
 532:	ec06                	sd	ra,24(sp)
 534:	e822                	sd	s0,16(sp)
 536:	e426                	sd	s1,8(sp)
 538:	e04a                	sd	s2,0(sp)
 53a:	1000                	addi	s0,sp,32
 53c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 53e:	4581                	li	a1,0
 540:	00000097          	auipc	ra,0x0
 544:	172080e7          	jalr	370(ra) # 6b2 <open>
  if(fd < 0)
 548:	02054563          	bltz	a0,572 <stat+0x42>
 54c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 54e:	85ca                	mv	a1,s2
 550:	00000097          	auipc	ra,0x0
 554:	17a080e7          	jalr	378(ra) # 6ca <fstat>
 558:	892a                	mv	s2,a0
  close(fd);
 55a:	8526                	mv	a0,s1
 55c:	00000097          	auipc	ra,0x0
 560:	13e080e7          	jalr	318(ra) # 69a <close>
  return r;
}
 564:	854a                	mv	a0,s2
 566:	60e2                	ld	ra,24(sp)
 568:	6442                	ld	s0,16(sp)
 56a:	64a2                	ld	s1,8(sp)
 56c:	6902                	ld	s2,0(sp)
 56e:	6105                	addi	sp,sp,32
 570:	8082                	ret
    return -1;
 572:	597d                	li	s2,-1
 574:	bfc5                	j	564 <stat+0x34>

0000000000000576 <atoi>:

int
atoi(const char *s)
{
 576:	1141                	addi	sp,sp,-16
 578:	e422                	sd	s0,8(sp)
 57a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 57c:	00054603          	lbu	a2,0(a0)
 580:	fd06079b          	addiw	a5,a2,-48
 584:	0ff7f793          	zext.b	a5,a5
 588:	4725                	li	a4,9
 58a:	02f76963          	bltu	a4,a5,5bc <atoi+0x46>
 58e:	86aa                	mv	a3,a0
  n = 0;
 590:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 592:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 594:	0685                	addi	a3,a3,1
 596:	0025179b          	slliw	a5,a0,0x2
 59a:	9fa9                	addw	a5,a5,a0
 59c:	0017979b          	slliw	a5,a5,0x1
 5a0:	9fb1                	addw	a5,a5,a2
 5a2:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 5a6:	0006c603          	lbu	a2,0(a3)
 5aa:	fd06071b          	addiw	a4,a2,-48
 5ae:	0ff77713          	zext.b	a4,a4
 5b2:	fee5f1e3          	bgeu	a1,a4,594 <atoi+0x1e>
  return n;
}
 5b6:	6422                	ld	s0,8(sp)
 5b8:	0141                	addi	sp,sp,16
 5ba:	8082                	ret
  n = 0;
 5bc:	4501                	li	a0,0
 5be:	bfe5                	j	5b6 <atoi+0x40>

00000000000005c0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5c0:	1141                	addi	sp,sp,-16
 5c2:	e422                	sd	s0,8(sp)
 5c4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5c6:	02b57463          	bgeu	a0,a1,5ee <memmove+0x2e>
    while(n-- > 0)
 5ca:	00c05f63          	blez	a2,5e8 <memmove+0x28>
 5ce:	1602                	slli	a2,a2,0x20
 5d0:	9201                	srli	a2,a2,0x20
 5d2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5d6:	872a                	mv	a4,a0
      *dst++ = *src++;
 5d8:	0585                	addi	a1,a1,1
 5da:	0705                	addi	a4,a4,1
 5dc:	fff5c683          	lbu	a3,-1(a1)
 5e0:	fed70fa3          	sb	a3,-1(a4) # ffff <__global_pointer$+0xeb66>
    while(n-- > 0)
 5e4:	fee79ae3          	bne	a5,a4,5d8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5e8:	6422                	ld	s0,8(sp)
 5ea:	0141                	addi	sp,sp,16
 5ec:	8082                	ret
    dst += n;
 5ee:	00c50733          	add	a4,a0,a2
    src += n;
 5f2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5f4:	fec05ae3          	blez	a2,5e8 <memmove+0x28>
 5f8:	fff6079b          	addiw	a5,a2,-1
 5fc:	1782                	slli	a5,a5,0x20
 5fe:	9381                	srli	a5,a5,0x20
 600:	fff7c793          	not	a5,a5
 604:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 606:	15fd                	addi	a1,a1,-1
 608:	177d                	addi	a4,a4,-1
 60a:	0005c683          	lbu	a3,0(a1)
 60e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 612:	fee79ae3          	bne	a5,a4,606 <memmove+0x46>
 616:	bfc9                	j	5e8 <memmove+0x28>

0000000000000618 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 618:	1141                	addi	sp,sp,-16
 61a:	e422                	sd	s0,8(sp)
 61c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 61e:	ca05                	beqz	a2,64e <memcmp+0x36>
 620:	fff6069b          	addiw	a3,a2,-1
 624:	1682                	slli	a3,a3,0x20
 626:	9281                	srli	a3,a3,0x20
 628:	0685                	addi	a3,a3,1
 62a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 62c:	00054783          	lbu	a5,0(a0)
 630:	0005c703          	lbu	a4,0(a1)
 634:	00e79863          	bne	a5,a4,644 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 638:	0505                	addi	a0,a0,1
    p2++;
 63a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 63c:	fed518e3          	bne	a0,a3,62c <memcmp+0x14>
  }
  return 0;
 640:	4501                	li	a0,0
 642:	a019                	j	648 <memcmp+0x30>
      return *p1 - *p2;
 644:	40e7853b          	subw	a0,a5,a4
}
 648:	6422                	ld	s0,8(sp)
 64a:	0141                	addi	sp,sp,16
 64c:	8082                	ret
  return 0;
 64e:	4501                	li	a0,0
 650:	bfe5                	j	648 <memcmp+0x30>

0000000000000652 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 652:	1141                	addi	sp,sp,-16
 654:	e406                	sd	ra,8(sp)
 656:	e022                	sd	s0,0(sp)
 658:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 65a:	00000097          	auipc	ra,0x0
 65e:	f66080e7          	jalr	-154(ra) # 5c0 <memmove>
}
 662:	60a2                	ld	ra,8(sp)
 664:	6402                	ld	s0,0(sp)
 666:	0141                	addi	sp,sp,16
 668:	8082                	ret

000000000000066a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 66a:	4885                	li	a7,1
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <exit>:
.global exit
exit:
 li a7, SYS_exit
 672:	4889                	li	a7,2
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <wait>:
.global wait
wait:
 li a7, SYS_wait
 67a:	488d                	li	a7,3
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 682:	4891                	li	a7,4
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <read>:
.global read
read:
 li a7, SYS_read
 68a:	4895                	li	a7,5
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <write>:
.global write
write:
 li a7, SYS_write
 692:	48c1                	li	a7,16
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <close>:
.global close
close:
 li a7, SYS_close
 69a:	48d5                	li	a7,21
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 6a2:	4899                	li	a7,6
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <exec>:
.global exec
exec:
 li a7, SYS_exec
 6aa:	489d                	li	a7,7
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <open>:
.global open
open:
 li a7, SYS_open
 6b2:	48bd                	li	a7,15
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6ba:	48c5                	li	a7,17
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6c2:	48c9                	li	a7,18
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6ca:	48a1                	li	a7,8
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <link>:
.global link
link:
 li a7, SYS_link
 6d2:	48cd                	li	a7,19
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6da:	48d1                	li	a7,20
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6e2:	48a5                	li	a7,9
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <dup>:
.global dup
dup:
 li a7, SYS_dup
 6ea:	48a9                	li	a7,10
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6f2:	48ad                	li	a7,11
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6fa:	48b1                	li	a7,12
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 702:	48b5                	li	a7,13
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 70a:	48b9                	li	a7,14
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 712:	48d9                	li	a7,22
 ecall
 714:	00000073          	ecall
 ret
 718:	8082                	ret

000000000000071a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 71a:	1101                	addi	sp,sp,-32
 71c:	ec06                	sd	ra,24(sp)
 71e:	e822                	sd	s0,16(sp)
 720:	1000                	addi	s0,sp,32
 722:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 726:	4605                	li	a2,1
 728:	fef40593          	addi	a1,s0,-17
 72c:	00000097          	auipc	ra,0x0
 730:	f66080e7          	jalr	-154(ra) # 692 <write>
}
 734:	60e2                	ld	ra,24(sp)
 736:	6442                	ld	s0,16(sp)
 738:	6105                	addi	sp,sp,32
 73a:	8082                	ret

000000000000073c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 73c:	7139                	addi	sp,sp,-64
 73e:	fc06                	sd	ra,56(sp)
 740:	f822                	sd	s0,48(sp)
 742:	f426                	sd	s1,40(sp)
 744:	f04a                	sd	s2,32(sp)
 746:	ec4e                	sd	s3,24(sp)
 748:	0080                	addi	s0,sp,64
 74a:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 74c:	c299                	beqz	a3,752 <printint+0x16>
 74e:	0805c863          	bltz	a1,7de <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 752:	2581                	sext.w	a1,a1
  neg = 0;
 754:	4881                	li	a7,0
 756:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 75a:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 75c:	2601                	sext.w	a2,a2
 75e:	00000517          	auipc	a0,0x0
 762:	52a50513          	addi	a0,a0,1322 # c88 <digits>
 766:	883a                	mv	a6,a4
 768:	2705                	addiw	a4,a4,1
 76a:	02c5f7bb          	remuw	a5,a1,a2
 76e:	1782                	slli	a5,a5,0x20
 770:	9381                	srli	a5,a5,0x20
 772:	97aa                	add	a5,a5,a0
 774:	0007c783          	lbu	a5,0(a5)
 778:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 77c:	0005879b          	sext.w	a5,a1
 780:	02c5d5bb          	divuw	a1,a1,a2
 784:	0685                	addi	a3,a3,1
 786:	fec7f0e3          	bgeu	a5,a2,766 <printint+0x2a>
  if(neg)
 78a:	00088b63          	beqz	a7,7a0 <printint+0x64>
    buf[i++] = '-';
 78e:	fd040793          	addi	a5,s0,-48
 792:	973e                	add	a4,a4,a5
 794:	02d00793          	li	a5,45
 798:	fef70823          	sb	a5,-16(a4)
 79c:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 7a0:	02e05863          	blez	a4,7d0 <printint+0x94>
 7a4:	fc040793          	addi	a5,s0,-64
 7a8:	00e78933          	add	s2,a5,a4
 7ac:	fff78993          	addi	s3,a5,-1
 7b0:	99ba                	add	s3,s3,a4
 7b2:	377d                	addiw	a4,a4,-1
 7b4:	1702                	slli	a4,a4,0x20
 7b6:	9301                	srli	a4,a4,0x20
 7b8:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7bc:	fff94583          	lbu	a1,-1(s2)
 7c0:	8526                	mv	a0,s1
 7c2:	00000097          	auipc	ra,0x0
 7c6:	f58080e7          	jalr	-168(ra) # 71a <putc>
  while(--i >= 0)
 7ca:	197d                	addi	s2,s2,-1
 7cc:	ff3918e3          	bne	s2,s3,7bc <printint+0x80>
}
 7d0:	70e2                	ld	ra,56(sp)
 7d2:	7442                	ld	s0,48(sp)
 7d4:	74a2                	ld	s1,40(sp)
 7d6:	7902                	ld	s2,32(sp)
 7d8:	69e2                	ld	s3,24(sp)
 7da:	6121                	addi	sp,sp,64
 7dc:	8082                	ret
    x = -xx;
 7de:	40b005bb          	negw	a1,a1
    neg = 1;
 7e2:	4885                	li	a7,1
    x = -xx;
 7e4:	bf8d                	j	756 <printint+0x1a>

00000000000007e6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7e6:	7119                	addi	sp,sp,-128
 7e8:	fc86                	sd	ra,120(sp)
 7ea:	f8a2                	sd	s0,112(sp)
 7ec:	f4a6                	sd	s1,104(sp)
 7ee:	f0ca                	sd	s2,96(sp)
 7f0:	ecce                	sd	s3,88(sp)
 7f2:	e8d2                	sd	s4,80(sp)
 7f4:	e4d6                	sd	s5,72(sp)
 7f6:	e0da                	sd	s6,64(sp)
 7f8:	fc5e                	sd	s7,56(sp)
 7fa:	f862                	sd	s8,48(sp)
 7fc:	f466                	sd	s9,40(sp)
 7fe:	f06a                	sd	s10,32(sp)
 800:	ec6e                	sd	s11,24(sp)
 802:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 804:	0005c903          	lbu	s2,0(a1)
 808:	18090f63          	beqz	s2,9a6 <vprintf+0x1c0>
 80c:	8aaa                	mv	s5,a0
 80e:	8b32                	mv	s6,a2
 810:	00158493          	addi	s1,a1,1
  state = 0;
 814:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 816:	02500a13          	li	s4,37
      if(c == 'd'){
 81a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 81e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 822:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 826:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 82a:	00000b97          	auipc	s7,0x0
 82e:	45eb8b93          	addi	s7,s7,1118 # c88 <digits>
 832:	a839                	j	850 <vprintf+0x6a>
        putc(fd, c);
 834:	85ca                	mv	a1,s2
 836:	8556                	mv	a0,s5
 838:	00000097          	auipc	ra,0x0
 83c:	ee2080e7          	jalr	-286(ra) # 71a <putc>
 840:	a019                	j	846 <vprintf+0x60>
    } else if(state == '%'){
 842:	01498f63          	beq	s3,s4,860 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 846:	0485                	addi	s1,s1,1
 848:	fff4c903          	lbu	s2,-1(s1)
 84c:	14090d63          	beqz	s2,9a6 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 850:	0009079b          	sext.w	a5,s2
    if(state == 0){
 854:	fe0997e3          	bnez	s3,842 <vprintf+0x5c>
      if(c == '%'){
 858:	fd479ee3          	bne	a5,s4,834 <vprintf+0x4e>
        state = '%';
 85c:	89be                	mv	s3,a5
 85e:	b7e5                	j	846 <vprintf+0x60>
      if(c == 'd'){
 860:	05878063          	beq	a5,s8,8a0 <vprintf+0xba>
      } else if(c == 'l') {
 864:	05978c63          	beq	a5,s9,8bc <vprintf+0xd6>
      } else if(c == 'x') {
 868:	07a78863          	beq	a5,s10,8d8 <vprintf+0xf2>
      } else if(c == 'p') {
 86c:	09b78463          	beq	a5,s11,8f4 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 870:	07300713          	li	a4,115
 874:	0ce78663          	beq	a5,a4,940 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 878:	06300713          	li	a4,99
 87c:	0ee78e63          	beq	a5,a4,978 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 880:	11478863          	beq	a5,s4,990 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 884:	85d2                	mv	a1,s4
 886:	8556                	mv	a0,s5
 888:	00000097          	auipc	ra,0x0
 88c:	e92080e7          	jalr	-366(ra) # 71a <putc>
        putc(fd, c);
 890:	85ca                	mv	a1,s2
 892:	8556                	mv	a0,s5
 894:	00000097          	auipc	ra,0x0
 898:	e86080e7          	jalr	-378(ra) # 71a <putc>
      }
      state = 0;
 89c:	4981                	li	s3,0
 89e:	b765                	j	846 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 8a0:	008b0913          	addi	s2,s6,8
 8a4:	4685                	li	a3,1
 8a6:	4629                	li	a2,10
 8a8:	000b2583          	lw	a1,0(s6)
 8ac:	8556                	mv	a0,s5
 8ae:	00000097          	auipc	ra,0x0
 8b2:	e8e080e7          	jalr	-370(ra) # 73c <printint>
 8b6:	8b4a                	mv	s6,s2
      state = 0;
 8b8:	4981                	li	s3,0
 8ba:	b771                	j	846 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8bc:	008b0913          	addi	s2,s6,8
 8c0:	4681                	li	a3,0
 8c2:	4629                	li	a2,10
 8c4:	000b2583          	lw	a1,0(s6)
 8c8:	8556                	mv	a0,s5
 8ca:	00000097          	auipc	ra,0x0
 8ce:	e72080e7          	jalr	-398(ra) # 73c <printint>
 8d2:	8b4a                	mv	s6,s2
      state = 0;
 8d4:	4981                	li	s3,0
 8d6:	bf85                	j	846 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8d8:	008b0913          	addi	s2,s6,8
 8dc:	4681                	li	a3,0
 8de:	4641                	li	a2,16
 8e0:	000b2583          	lw	a1,0(s6)
 8e4:	8556                	mv	a0,s5
 8e6:	00000097          	auipc	ra,0x0
 8ea:	e56080e7          	jalr	-426(ra) # 73c <printint>
 8ee:	8b4a                	mv	s6,s2
      state = 0;
 8f0:	4981                	li	s3,0
 8f2:	bf91                	j	846 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8f4:	008b0793          	addi	a5,s6,8
 8f8:	f8f43423          	sd	a5,-120(s0)
 8fc:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 900:	03000593          	li	a1,48
 904:	8556                	mv	a0,s5
 906:	00000097          	auipc	ra,0x0
 90a:	e14080e7          	jalr	-492(ra) # 71a <putc>
  putc(fd, 'x');
 90e:	85ea                	mv	a1,s10
 910:	8556                	mv	a0,s5
 912:	00000097          	auipc	ra,0x0
 916:	e08080e7          	jalr	-504(ra) # 71a <putc>
 91a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 91c:	03c9d793          	srli	a5,s3,0x3c
 920:	97de                	add	a5,a5,s7
 922:	0007c583          	lbu	a1,0(a5)
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	df2080e7          	jalr	-526(ra) # 71a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 930:	0992                	slli	s3,s3,0x4
 932:	397d                	addiw	s2,s2,-1
 934:	fe0914e3          	bnez	s2,91c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 938:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 93c:	4981                	li	s3,0
 93e:	b721                	j	846 <vprintf+0x60>
        s = va_arg(ap, char*);
 940:	008b0993          	addi	s3,s6,8
 944:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 948:	02090163          	beqz	s2,96a <vprintf+0x184>
        while(*s != 0){
 94c:	00094583          	lbu	a1,0(s2)
 950:	c9a1                	beqz	a1,9a0 <vprintf+0x1ba>
          putc(fd, *s);
 952:	8556                	mv	a0,s5
 954:	00000097          	auipc	ra,0x0
 958:	dc6080e7          	jalr	-570(ra) # 71a <putc>
          s++;
 95c:	0905                	addi	s2,s2,1
        while(*s != 0){
 95e:	00094583          	lbu	a1,0(s2)
 962:	f9e5                	bnez	a1,952 <vprintf+0x16c>
        s = va_arg(ap, char*);
 964:	8b4e                	mv	s6,s3
      state = 0;
 966:	4981                	li	s3,0
 968:	bdf9                	j	846 <vprintf+0x60>
          s = "(null)";
 96a:	00000917          	auipc	s2,0x0
 96e:	31690913          	addi	s2,s2,790 # c80 <malloc+0x1d0>
        while(*s != 0){
 972:	02800593          	li	a1,40
 976:	bff1                	j	952 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 978:	008b0913          	addi	s2,s6,8
 97c:	000b4583          	lbu	a1,0(s6)
 980:	8556                	mv	a0,s5
 982:	00000097          	auipc	ra,0x0
 986:	d98080e7          	jalr	-616(ra) # 71a <putc>
 98a:	8b4a                	mv	s6,s2
      state = 0;
 98c:	4981                	li	s3,0
 98e:	bd65                	j	846 <vprintf+0x60>
        putc(fd, c);
 990:	85d2                	mv	a1,s4
 992:	8556                	mv	a0,s5
 994:	00000097          	auipc	ra,0x0
 998:	d86080e7          	jalr	-634(ra) # 71a <putc>
      state = 0;
 99c:	4981                	li	s3,0
 99e:	b565                	j	846 <vprintf+0x60>
        s = va_arg(ap, char*);
 9a0:	8b4e                	mv	s6,s3
      state = 0;
 9a2:	4981                	li	s3,0
 9a4:	b54d                	j	846 <vprintf+0x60>
    }
  }
}
 9a6:	70e6                	ld	ra,120(sp)
 9a8:	7446                	ld	s0,112(sp)
 9aa:	74a6                	ld	s1,104(sp)
 9ac:	7906                	ld	s2,96(sp)
 9ae:	69e6                	ld	s3,88(sp)
 9b0:	6a46                	ld	s4,80(sp)
 9b2:	6aa6                	ld	s5,72(sp)
 9b4:	6b06                	ld	s6,64(sp)
 9b6:	7be2                	ld	s7,56(sp)
 9b8:	7c42                	ld	s8,48(sp)
 9ba:	7ca2                	ld	s9,40(sp)
 9bc:	7d02                	ld	s10,32(sp)
 9be:	6de2                	ld	s11,24(sp)
 9c0:	6109                	addi	sp,sp,128
 9c2:	8082                	ret

00000000000009c4 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9c4:	715d                	addi	sp,sp,-80
 9c6:	ec06                	sd	ra,24(sp)
 9c8:	e822                	sd	s0,16(sp)
 9ca:	1000                	addi	s0,sp,32
 9cc:	e010                	sd	a2,0(s0)
 9ce:	e414                	sd	a3,8(s0)
 9d0:	e818                	sd	a4,16(s0)
 9d2:	ec1c                	sd	a5,24(s0)
 9d4:	03043023          	sd	a6,32(s0)
 9d8:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9dc:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9e0:	8622                	mv	a2,s0
 9e2:	00000097          	auipc	ra,0x0
 9e6:	e04080e7          	jalr	-508(ra) # 7e6 <vprintf>
}
 9ea:	60e2                	ld	ra,24(sp)
 9ec:	6442                	ld	s0,16(sp)
 9ee:	6161                	addi	sp,sp,80
 9f0:	8082                	ret

00000000000009f2 <printf>:

void
printf(const char *fmt, ...)
{
 9f2:	711d                	addi	sp,sp,-96
 9f4:	ec06                	sd	ra,24(sp)
 9f6:	e822                	sd	s0,16(sp)
 9f8:	1000                	addi	s0,sp,32
 9fa:	e40c                	sd	a1,8(s0)
 9fc:	e810                	sd	a2,16(s0)
 9fe:	ec14                	sd	a3,24(s0)
 a00:	f018                	sd	a4,32(s0)
 a02:	f41c                	sd	a5,40(s0)
 a04:	03043823          	sd	a6,48(s0)
 a08:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a0c:	00840613          	addi	a2,s0,8
 a10:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a14:	85aa                	mv	a1,a0
 a16:	4505                	li	a0,1
 a18:	00000097          	auipc	ra,0x0
 a1c:	dce080e7          	jalr	-562(ra) # 7e6 <vprintf>
}
 a20:	60e2                	ld	ra,24(sp)
 a22:	6442                	ld	s0,16(sp)
 a24:	6125                	addi	sp,sp,96
 a26:	8082                	ret

0000000000000a28 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a28:	1141                	addi	sp,sp,-16
 a2a:	e422                	sd	s0,8(sp)
 a2c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a2e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a32:	00000797          	auipc	a5,0x0
 a36:	26e7b783          	ld	a5,622(a5) # ca0 <freep>
 a3a:	a805                	j	a6a <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a3c:	4618                	lw	a4,8(a2)
 a3e:	9db9                	addw	a1,a1,a4
 a40:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a44:	6398                	ld	a4,0(a5)
 a46:	6318                	ld	a4,0(a4)
 a48:	fee53823          	sd	a4,-16(a0)
 a4c:	a091                	j	a90 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a4e:	ff852703          	lw	a4,-8(a0)
 a52:	9e39                	addw	a2,a2,a4
 a54:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a56:	ff053703          	ld	a4,-16(a0)
 a5a:	e398                	sd	a4,0(a5)
 a5c:	a099                	j	aa2 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a5e:	6398                	ld	a4,0(a5)
 a60:	00e7e463          	bltu	a5,a4,a68 <free+0x40>
 a64:	00e6ea63          	bltu	a3,a4,a78 <free+0x50>
{
 a68:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a6a:	fed7fae3          	bgeu	a5,a3,a5e <free+0x36>
 a6e:	6398                	ld	a4,0(a5)
 a70:	00e6e463          	bltu	a3,a4,a78 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a74:	fee7eae3          	bltu	a5,a4,a68 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a78:	ff852583          	lw	a1,-8(a0)
 a7c:	6390                	ld	a2,0(a5)
 a7e:	02059813          	slli	a6,a1,0x20
 a82:	01c85713          	srli	a4,a6,0x1c
 a86:	9736                	add	a4,a4,a3
 a88:	fae60ae3          	beq	a2,a4,a3c <free+0x14>
    bp->s.ptr = p->s.ptr;
 a8c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a90:	4790                	lw	a2,8(a5)
 a92:	02061593          	slli	a1,a2,0x20
 a96:	01c5d713          	srli	a4,a1,0x1c
 a9a:	973e                	add	a4,a4,a5
 a9c:	fae689e3          	beq	a3,a4,a4e <free+0x26>
  } else
    p->s.ptr = bp;
 aa0:	e394                	sd	a3,0(a5)
  freep = p;
 aa2:	00000717          	auipc	a4,0x0
 aa6:	1ef73f23          	sd	a5,510(a4) # ca0 <freep>
}
 aaa:	6422                	ld	s0,8(sp)
 aac:	0141                	addi	sp,sp,16
 aae:	8082                	ret

0000000000000ab0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ab0:	7139                	addi	sp,sp,-64
 ab2:	fc06                	sd	ra,56(sp)
 ab4:	f822                	sd	s0,48(sp)
 ab6:	f426                	sd	s1,40(sp)
 ab8:	f04a                	sd	s2,32(sp)
 aba:	ec4e                	sd	s3,24(sp)
 abc:	e852                	sd	s4,16(sp)
 abe:	e456                	sd	s5,8(sp)
 ac0:	e05a                	sd	s6,0(sp)
 ac2:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ac4:	02051493          	slli	s1,a0,0x20
 ac8:	9081                	srli	s1,s1,0x20
 aca:	04bd                	addi	s1,s1,15
 acc:	8091                	srli	s1,s1,0x4
 ace:	0014899b          	addiw	s3,s1,1
 ad2:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 ad4:	00000517          	auipc	a0,0x0
 ad8:	1cc53503          	ld	a0,460(a0) # ca0 <freep>
 adc:	c515                	beqz	a0,b08 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ade:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ae0:	4798                	lw	a4,8(a5)
 ae2:	02977f63          	bgeu	a4,s1,b20 <malloc+0x70>
 ae6:	8a4e                	mv	s4,s3
 ae8:	0009871b          	sext.w	a4,s3
 aec:	6685                	lui	a3,0x1
 aee:	00d77363          	bgeu	a4,a3,af4 <malloc+0x44>
 af2:	6a05                	lui	s4,0x1
 af4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 af8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 afc:	00000917          	auipc	s2,0x0
 b00:	1a490913          	addi	s2,s2,420 # ca0 <freep>
  if(p == (char*)-1)
 b04:	5afd                	li	s5,-1
 b06:	a895                	j	b7a <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b08:	00000797          	auipc	a5,0x0
 b0c:	29078793          	addi	a5,a5,656 # d98 <base>
 b10:	00000717          	auipc	a4,0x0
 b14:	18f73823          	sd	a5,400(a4) # ca0 <freep>
 b18:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b1a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b1e:	b7e1                	j	ae6 <malloc+0x36>
      if(p->s.size == nunits)
 b20:	02e48c63          	beq	s1,a4,b58 <malloc+0xa8>
        p->s.size -= nunits;
 b24:	4137073b          	subw	a4,a4,s3
 b28:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b2a:	02071693          	slli	a3,a4,0x20
 b2e:	01c6d713          	srli	a4,a3,0x1c
 b32:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b34:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b38:	00000717          	auipc	a4,0x0
 b3c:	16a73423          	sd	a0,360(a4) # ca0 <freep>
      return (void*)(p + 1);
 b40:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b44:	70e2                	ld	ra,56(sp)
 b46:	7442                	ld	s0,48(sp)
 b48:	74a2                	ld	s1,40(sp)
 b4a:	7902                	ld	s2,32(sp)
 b4c:	69e2                	ld	s3,24(sp)
 b4e:	6a42                	ld	s4,16(sp)
 b50:	6aa2                	ld	s5,8(sp)
 b52:	6b02                	ld	s6,0(sp)
 b54:	6121                	addi	sp,sp,64
 b56:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b58:	6398                	ld	a4,0(a5)
 b5a:	e118                	sd	a4,0(a0)
 b5c:	bff1                	j	b38 <malloc+0x88>
  hp->s.size = nu;
 b5e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b62:	0541                	addi	a0,a0,16
 b64:	00000097          	auipc	ra,0x0
 b68:	ec4080e7          	jalr	-316(ra) # a28 <free>
  return freep;
 b6c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b70:	d971                	beqz	a0,b44 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b72:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b74:	4798                	lw	a4,8(a5)
 b76:	fa9775e3          	bgeu	a4,s1,b20 <malloc+0x70>
    if(p == freep)
 b7a:	00093703          	ld	a4,0(s2)
 b7e:	853e                	mv	a0,a5
 b80:	fef719e3          	bne	a4,a5,b72 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 b84:	8552                	mv	a0,s4
 b86:	00000097          	auipc	ra,0x0
 b8a:	b74080e7          	jalr	-1164(ra) # 6fa <sbrk>
  if(p == (char*)-1)
 b8e:	fd5518e3          	bne	a0,s5,b5e <malloc+0xae>
        return 0;
 b92:	4501                	li	a0,0
 b94:	bf45                	j	b44 <malloc+0x94>
