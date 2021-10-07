
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
  int ring_desc = create_or_close_the_buffer_user("ring", 1);
  28:	4585                	li	a1,1
  2a:	00001517          	auipc	a0,0x1
  2e:	b6650513          	addi	a0,a0,-1178 # b90 <malloc+0xe8>
  32:	00000097          	auipc	ra,0x0
  36:	1cc080e7          	jalr	460(ra) # 1fe <create_or_close_the_buffer_user>
  3a:	892a                	mv	s2,a0
  uint64 addri = 0; // = (uint64 *)0;
  3c:	fc043423          	sd	zero,-56(s0)
  uint64* addr = &addri;
  40:	fc840593          	addi	a1,s0,-56
  44:	fcb43023          	sd	a1,-64(s0)
  int bytesi = 0; // = (int *) 0;
  48:	fa042e23          	sw	zero,-68(s0)
  int bytes_want_to_read = 14;// 65536;//(10485760/8);

  // int start_time, elasped_time;
  // start_time = uptime();

  printf("before write addr %d\n", addr);
  4c:	00001517          	auipc	a0,0x1
  50:	b4c50513          	addi	a0,a0,-1204 # b98 <malloc+0xf0>
  54:	00001097          	auipc	ra,0x1
  58:	996080e7          	jalr	-1642(ra) # 9ea <printf>
  printf("before write bytes %d\n", bytes);
  5c:	fbc40593          	addi	a1,s0,-68
  60:	00001517          	auipc	a0,0x1
  64:	b5050513          	addi	a0,a0,-1200 # bb0 <malloc+0x108>
  68:	00001097          	auipc	ra,0x1
  6c:	982080e7          	jalr	-1662(ra) # 9ea <printf>
//start here
  ringbuf_start_write(ring_desc, &addr, bytes);
  70:	fbc40613          	addi	a2,s0,-68
  74:	fc040593          	addi	a1,s0,-64
  78:	854a                	mv	a0,s2
  7a:	00000097          	auipc	ra,0x0
  7e:	222080e7          	jalr	546(ra) # 29c <ringbuf_start_write>
  printf("after start_write addr %d\n", addr);
  82:	fc043583          	ld	a1,-64(s0)
  86:	00001517          	auipc	a0,0x1
  8a:	b4250513          	addi	a0,a0,-1214 # bc8 <malloc+0x120>
  8e:	00001097          	auipc	ra,0x1
  92:	95c080e7          	jalr	-1700(ra) # 9ea <printf>
  printf("after start_write bytes %d\n\n", *bytes);
  96:	fbc42583          	lw	a1,-68(s0)
  9a:	00001517          	auipc	a0,0x1
  9e:	b4e50513          	addi	a0,a0,-1202 # be8 <malloc+0x140>
  a2:	00001097          	auipc	ra,0x1
  a6:	948080e7          	jalr	-1720(ra) # 9ea <printf>

  if(bytes_want_to_read < *bytes){
  aa:	fbc42583          	lw	a1,-68(s0)
  ae:	47b9                	li	a5,14
  b0:	04b7c463          	blt	a5,a1,f8 <main+0xe0>
      printf("written on address %d\n", addr + i);
    }
    ringbuf_finish_write(ring_desc, bytes_want_to_read);
  }
  else{
    for(int i=0; i < *bytes; i++){
  b4:	4481                	li	s1,0
      addr[i] = i;
      printf("written on address %d\n", addr + i);
  b6:	00001997          	auipc	s3,0x1
  ba:	b5298993          	addi	s3,s3,-1198 # c08 <malloc+0x160>
    for(int i=0; i < *bytes; i++){
  be:	02b05763          	blez	a1,ec <main+0xd4>
      addr[i] = i;
  c2:	00349713          	slli	a4,s1,0x3
  c6:	fc043783          	ld	a5,-64(s0)
  ca:	97ba                	add	a5,a5,a4
  cc:	e384                	sd	s1,0(a5)
      printf("written on address %d\n", addr + i);
  ce:	fc043583          	ld	a1,-64(s0)
  d2:	95ba                	add	a1,a1,a4
  d4:	854e                	mv	a0,s3
  d6:	00001097          	auipc	ra,0x1
  da:	914080e7          	jalr	-1772(ra) # 9ea <printf>
    for(int i=0; i < *bytes; i++){
  de:	fbc42583          	lw	a1,-68(s0)
  e2:	0485                	addi	s1,s1,1
  e4:	0004879b          	sext.w	a5,s1
  e8:	fcb7cde3          	blt	a5,a1,c2 <main+0xaa>
    }
    ringbuf_finish_write(ring_desc, *bytes);
  ec:	854a                	mv	a0,s2
  ee:	00000097          	auipc	ra,0x0
  f2:	21c080e7          	jalr	540(ra) # 30a <ringbuf_finish_write>
  f6:	a835                	j	132 <main+0x11a>
  f8:	4481                	li	s1,0
      printf("written on address %d\n", addr + i);
  fa:	00001a17          	auipc	s4,0x1
  fe:	b0ea0a13          	addi	s4,s4,-1266 # c08 <malloc+0x160>
    for(int i=0; i < bytes_want_to_read; i++){
 102:	49b9                	li	s3,14
      addr[i] = i;
 104:	00349713          	slli	a4,s1,0x3
 108:	fc043783          	ld	a5,-64(s0)
 10c:	97ba                	add	a5,a5,a4
 10e:	e384                	sd	s1,0(a5)
      printf("written on address %d\n", addr + i);
 110:	fc043583          	ld	a1,-64(s0)
 114:	95ba                	add	a1,a1,a4
 116:	8552                	mv	a0,s4
 118:	00001097          	auipc	ra,0x1
 11c:	8d2080e7          	jalr	-1838(ra) # 9ea <printf>
    for(int i=0; i < bytes_want_to_read; i++){
 120:	0485                	addi	s1,s1,1
 122:	ff3491e3          	bne	s1,s3,104 <main+0xec>
    ringbuf_finish_write(ring_desc, bytes_want_to_read);
 126:	45b9                	li	a1,14
 128:	854a                	mv	a0,s2
 12a:	00000097          	auipc	ra,0x0
 12e:	1e0080e7          	jalr	480(ra) # 30a <ringbuf_finish_write>
  }

  printf("\n\n");
 132:	00001517          	auipc	a0,0x1
 136:	aee50513          	addi	a0,a0,-1298 # c20 <malloc+0x178>
 13a:	00001097          	auipc	ra,0x1
 13e:	8b0080e7          	jalr	-1872(ra) # 9ea <printf>
  check_bytes_written(ring_desc, bytes);
 142:	fbc40593          	addi	a1,s0,-68
 146:	854a                	mv	a0,s2
 148:	00000097          	auipc	ra,0x0
 14c:	1f4080e7          	jalr	500(ra) # 33c <check_bytes_written>
  printf("after checking bytes written addr %d\n", *addr);
 150:	fc043783          	ld	a5,-64(s0)
 154:	638c                	ld	a1,0(a5)
 156:	00001517          	auipc	a0,0x1
 15a:	ad250513          	addi	a0,a0,-1326 # c28 <malloc+0x180>
 15e:	00001097          	auipc	ra,0x1
 162:	88c080e7          	jalr	-1908(ra) # 9ea <printf>
  printf("after checking bytes written bytes %d\n", *bytes);
 166:	fbc42583          	lw	a1,-68(s0)
 16a:	00001517          	auipc	a0,0x1
 16e:	ae650513          	addi	a0,a0,-1306 # c50 <malloc+0x1a8>
 172:	00001097          	auipc	ra,0x1
 176:	878080e7          	jalr	-1928(ra) # 9ea <printf>

  ringbuf_start_read(ring_desc, addr, bytes);
 17a:	fbc40613          	addi	a2,s0,-68
 17e:	fc043583          	ld	a1,-64(s0)
 182:	854a                	mv	a0,s2
 184:	00000097          	auipc	ra,0x0
 188:	1ee080e7          	jalr	494(ra) # 372 <ringbuf_start_read>
  // printf("\nThe data written is shown below\n");
  for(int i=0; i < *bytes; i++){
 18c:	fbc42583          	lw	a1,-68(s0)
 190:	00b05663          	blez	a1,19c <main+0x184>
 194:	4781                	li	a5,0
 196:	2785                	addiw	a5,a5,1
 198:	feb79fe3          	bne	a5,a1,196 <main+0x17e>
    // printf(" %d ", addr[i]);
  }
  ringbuf_finish_read(ring_desc, *bytes);
 19c:	854a                	mv	a0,s2
 19e:	00000097          	auipc	ra,0x0
 1a2:	22e080e7          	jalr	558(ra) # 3cc <ringbuf_finish_read>
  printf("\n\n");
 1a6:	00001517          	auipc	a0,0x1
 1aa:	a7a50513          	addi	a0,a0,-1414 # c20 <malloc+0x178>
 1ae:	00001097          	auipc	ra,0x1
 1b2:	83c080e7          	jalr	-1988(ra) # 9ea <printf>

  // elasped_time = uptime()-start_time;
  // printf("Elasped time is %d\n\n", elasped_time);

  create_or_close_the_buffer_user("ring", 0);
 1b6:	4581                	li	a1,0
 1b8:	00001517          	auipc	a0,0x1
 1bc:	9d850513          	addi	a0,a0,-1576 # b90 <malloc+0xe8>
 1c0:	00000097          	auipc	ra,0x0
 1c4:	03e080e7          	jalr	62(ra) # 1fe <create_or_close_the_buffer_user>

  exit(0);
 1c8:	4501                	li	a0,0
 1ca:	00000097          	auipc	ra,0x0
 1ce:	4a0080e7          	jalr	1184(ra) # 66a <exit>

00000000000001d2 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 1d2:	1141                	addi	sp,sp,-16
 1d4:	e422                	sd	s0,8(sp)
 1d6:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 1d8:	0f50000f          	fence	iorw,ow
 1dc:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 1e0:	6422                	ld	s0,8(sp)
 1e2:	0141                	addi	sp,sp,16
 1e4:	8082                	ret

00000000000001e6 <load>:

int load(uint64 *p) {
 1e6:	1141                	addi	sp,sp,-16
 1e8:	e422                	sd	s0,8(sp)
 1ea:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 1ec:	0ff0000f          	fence
 1f0:	6108                	ld	a0,0(a0)
 1f2:	0ff0000f          	fence
}
 1f6:	2501                	sext.w	a0,a0
 1f8:	6422                	ld	s0,8(sp)
 1fa:	0141                	addi	sp,sp,16
 1fc:	8082                	ret

00000000000001fe <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 1fe:	7179                	addi	sp,sp,-48
 200:	f406                	sd	ra,40(sp)
 202:	f022                	sd	s0,32(sp)
 204:	ec26                	sd	s1,24(sp)
 206:	e84a                	sd	s2,16(sp)
 208:	e44e                	sd	s3,8(sp)
 20a:	e052                	sd	s4,0(sp)
 20c:	1800                	addi	s0,sp,48
 20e:	8a2a                	mv	s4,a0
 210:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 212:	4785                	li	a5,1
 214:	00001497          	auipc	s1,0x1
 218:	a9c48493          	addi	s1,s1,-1380 # cb0 <rings+0x10>
 21c:	00001917          	auipc	s2,0x1
 220:	b8490913          	addi	s2,s2,-1148 # da0 <__BSS_END__>
 224:	04f59563          	bne	a1,a5,26e <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 228:	00001497          	auipc	s1,0x1
 22c:	a884a483          	lw	s1,-1400(s1) # cb0 <rings+0x10>
 230:	c099                	beqz	s1,236 <create_or_close_the_buffer_user+0x38>
 232:	4481                	li	s1,0
 234:	a899                	j	28a <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 236:	00001917          	auipc	s2,0x1
 23a:	a6a90913          	addi	s2,s2,-1430 # ca0 <rings>
 23e:	00093603          	ld	a2,0(s2)
 242:	4585                	li	a1,1
 244:	00000097          	auipc	ra,0x0
 248:	4c6080e7          	jalr	1222(ra) # 70a <ringbuf>
        rings[i].book->write_done = 0;
 24c:	00893783          	ld	a5,8(s2)
 250:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 254:	00893783          	ld	a5,8(s2)
 258:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 25c:	01092783          	lw	a5,16(s2)
 260:	2785                	addiw	a5,a5,1
 262:	00f92823          	sw	a5,16(s2)
        break;
 266:	a015                	j	28a <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 268:	04e1                	addi	s1,s1,24
 26a:	01248f63          	beq	s1,s2,288 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 26e:	409c                	lw	a5,0(s1)
 270:	dfe5                	beqz	a5,268 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 272:	ff04b603          	ld	a2,-16(s1)
 276:	85ce                	mv	a1,s3
 278:	8552                	mv	a0,s4
 27a:	00000097          	auipc	ra,0x0
 27e:	490080e7          	jalr	1168(ra) # 70a <ringbuf>
        rings[i].exists = 0;
 282:	0004a023          	sw	zero,0(s1)
 286:	b7cd                	j	268 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 288:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 28a:	8526                	mv	a0,s1
 28c:	70a2                	ld	ra,40(sp)
 28e:	7402                	ld	s0,32(sp)
 290:	64e2                	ld	s1,24(sp)
 292:	6942                	ld	s2,16(sp)
 294:	69a2                	ld	s3,8(sp)
 296:	6a02                	ld	s4,0(sp)
 298:	6145                	addi	sp,sp,48
 29a:	8082                	ret

000000000000029c <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 29c:	1101                	addi	sp,sp,-32
 29e:	ec06                	sd	ra,24(sp)
 2a0:	e822                	sd	s0,16(sp)
 2a2:	e426                	sd	s1,8(sp)
 2a4:	1000                	addi	s0,sp,32
 2a6:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 2a8:	00151793          	slli	a5,a0,0x1
 2ac:	97aa                	add	a5,a5,a0
 2ae:	078e                	slli	a5,a5,0x3
 2b0:	00001717          	auipc	a4,0x1
 2b4:	9f070713          	addi	a4,a4,-1552 # ca0 <rings>
 2b8:	97ba                	add	a5,a5,a4
 2ba:	639c                	ld	a5,0(a5)
 2bc:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 2be:	421c                	lw	a5,0(a2)
 2c0:	e785                	bnez	a5,2e8 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 2c2:	86ba                	mv	a3,a4
 2c4:	671c                	ld	a5,8(a4)
 2c6:	6398                	ld	a4,0(a5)
 2c8:	67c1                	lui	a5,0x10
 2ca:	9fb9                	addw	a5,a5,a4
 2cc:	00151713          	slli	a4,a0,0x1
 2d0:	953a                	add	a0,a0,a4
 2d2:	050e                	slli	a0,a0,0x3
 2d4:	9536                	add	a0,a0,a3
 2d6:	6518                	ld	a4,8(a0)
 2d8:	6718                	ld	a4,8(a4)
 2da:	9f99                	subw	a5,a5,a4
 2dc:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 2de:	60e2                	ld	ra,24(sp)
 2e0:	6442                	ld	s0,16(sp)
 2e2:	64a2                	ld	s1,8(sp)
 2e4:	6105                	addi	sp,sp,32
 2e6:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 2e8:	00151793          	slli	a5,a0,0x1
 2ec:	953e                	add	a0,a0,a5
 2ee:	050e                	slli	a0,a0,0x3
 2f0:	00001797          	auipc	a5,0x1
 2f4:	9b078793          	addi	a5,a5,-1616 # ca0 <rings>
 2f8:	953e                	add	a0,a0,a5
 2fa:	6508                	ld	a0,8(a0)
 2fc:	0521                	addi	a0,a0,8
 2fe:	00000097          	auipc	ra,0x0
 302:	ee8080e7          	jalr	-280(ra) # 1e6 <load>
 306:	c088                	sw	a0,0(s1)
}
 308:	bfd9                	j	2de <ringbuf_start_write+0x42>

000000000000030a <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 30a:	1141                	addi	sp,sp,-16
 30c:	e406                	sd	ra,8(sp)
 30e:	e022                	sd	s0,0(sp)
 310:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 312:	00151793          	slli	a5,a0,0x1
 316:	97aa                	add	a5,a5,a0
 318:	078e                	slli	a5,a5,0x3
 31a:	00001517          	auipc	a0,0x1
 31e:	98650513          	addi	a0,a0,-1658 # ca0 <rings>
 322:	97aa                	add	a5,a5,a0
 324:	6788                	ld	a0,8(a5)
 326:	0035959b          	slliw	a1,a1,0x3
 32a:	0521                	addi	a0,a0,8
 32c:	00000097          	auipc	ra,0x0
 330:	ea6080e7          	jalr	-346(ra) # 1d2 <store>
}
 334:	60a2                	ld	ra,8(sp)
 336:	6402                	ld	s0,0(sp)
 338:	0141                	addi	sp,sp,16
 33a:	8082                	ret

000000000000033c <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 33c:	1101                	addi	sp,sp,-32
 33e:	ec06                	sd	ra,24(sp)
 340:	e822                	sd	s0,16(sp)
 342:	e426                	sd	s1,8(sp)
 344:	1000                	addi	s0,sp,32
 346:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 348:	00151793          	slli	a5,a0,0x1
 34c:	97aa                	add	a5,a5,a0
 34e:	078e                	slli	a5,a5,0x3
 350:	00001517          	auipc	a0,0x1
 354:	95050513          	addi	a0,a0,-1712 # ca0 <rings>
 358:	97aa                	add	a5,a5,a0
 35a:	6788                	ld	a0,8(a5)
 35c:	0521                	addi	a0,a0,8
 35e:	00000097          	auipc	ra,0x0
 362:	e88080e7          	jalr	-376(ra) # 1e6 <load>
 366:	c088                	sw	a0,0(s1)
}
 368:	60e2                	ld	ra,24(sp)
 36a:	6442                	ld	s0,16(sp)
 36c:	64a2                	ld	s1,8(sp)
 36e:	6105                	addi	sp,sp,32
 370:	8082                	ret

0000000000000372 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 372:	1101                	addi	sp,sp,-32
 374:	ec06                	sd	ra,24(sp)
 376:	e822                	sd	s0,16(sp)
 378:	e426                	sd	s1,8(sp)
 37a:	1000                	addi	s0,sp,32
 37c:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 37e:	00151793          	slli	a5,a0,0x1
 382:	97aa                	add	a5,a5,a0
 384:	078e                	slli	a5,a5,0x3
 386:	00001517          	auipc	a0,0x1
 38a:	91a50513          	addi	a0,a0,-1766 # ca0 <rings>
 38e:	97aa                	add	a5,a5,a0
 390:	6788                	ld	a0,8(a5)
 392:	611c                	ld	a5,0(a0)
 394:	ef99                	bnez	a5,3b2 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 396:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 398:	41f7579b          	sraiw	a5,a4,0x1f
 39c:	01d7d79b          	srliw	a5,a5,0x1d
 3a0:	9fb9                	addw	a5,a5,a4
 3a2:	4037d79b          	sraiw	a5,a5,0x3
 3a6:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 3a8:	60e2                	ld	ra,24(sp)
 3aa:	6442                	ld	s0,16(sp)
 3ac:	64a2                	ld	s1,8(sp)
 3ae:	6105                	addi	sp,sp,32
 3b0:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 3b2:	00000097          	auipc	ra,0x0
 3b6:	e34080e7          	jalr	-460(ra) # 1e6 <load>
    *bytes /= 8;
 3ba:	41f5579b          	sraiw	a5,a0,0x1f
 3be:	01d7d79b          	srliw	a5,a5,0x1d
 3c2:	9d3d                	addw	a0,a0,a5
 3c4:	4035551b          	sraiw	a0,a0,0x3
 3c8:	c088                	sw	a0,0(s1)
}
 3ca:	bff9                	j	3a8 <ringbuf_start_read+0x36>

00000000000003cc <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 3cc:	1141                	addi	sp,sp,-16
 3ce:	e406                	sd	ra,8(sp)
 3d0:	e022                	sd	s0,0(sp)
 3d2:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 3d4:	00151793          	slli	a5,a0,0x1
 3d8:	97aa                	add	a5,a5,a0
 3da:	078e                	slli	a5,a5,0x3
 3dc:	00001517          	auipc	a0,0x1
 3e0:	8c450513          	addi	a0,a0,-1852 # ca0 <rings>
 3e4:	97aa                	add	a5,a5,a0
 3e6:	0035959b          	slliw	a1,a1,0x3
 3ea:	6788                	ld	a0,8(a5)
 3ec:	00000097          	auipc	ra,0x0
 3f0:	de6080e7          	jalr	-538(ra) # 1d2 <store>
}
 3f4:	60a2                	ld	ra,8(sp)
 3f6:	6402                	ld	s0,0(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret

00000000000003fc <strcpy>:



char*
strcpy(char *s, const char *t)
{
 3fc:	1141                	addi	sp,sp,-16
 3fe:	e422                	sd	s0,8(sp)
 400:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 402:	87aa                	mv	a5,a0
 404:	0585                	addi	a1,a1,1
 406:	0785                	addi	a5,a5,1
 408:	fff5c703          	lbu	a4,-1(a1)
 40c:	fee78fa3          	sb	a4,-1(a5)
 410:	fb75                	bnez	a4,404 <strcpy+0x8>
    ;
  return os;
}
 412:	6422                	ld	s0,8(sp)
 414:	0141                	addi	sp,sp,16
 416:	8082                	ret

0000000000000418 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 418:	1141                	addi	sp,sp,-16
 41a:	e422                	sd	s0,8(sp)
 41c:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 41e:	00054783          	lbu	a5,0(a0)
 422:	cb91                	beqz	a5,436 <strcmp+0x1e>
 424:	0005c703          	lbu	a4,0(a1)
 428:	00f71763          	bne	a4,a5,436 <strcmp+0x1e>
    p++, q++;
 42c:	0505                	addi	a0,a0,1
 42e:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 430:	00054783          	lbu	a5,0(a0)
 434:	fbe5                	bnez	a5,424 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 436:	0005c503          	lbu	a0,0(a1)
}
 43a:	40a7853b          	subw	a0,a5,a0
 43e:	6422                	ld	s0,8(sp)
 440:	0141                	addi	sp,sp,16
 442:	8082                	ret

0000000000000444 <strlen>:

uint
strlen(const char *s)
{
 444:	1141                	addi	sp,sp,-16
 446:	e422                	sd	s0,8(sp)
 448:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 44a:	00054783          	lbu	a5,0(a0)
 44e:	cf91                	beqz	a5,46a <strlen+0x26>
 450:	0505                	addi	a0,a0,1
 452:	87aa                	mv	a5,a0
 454:	4685                	li	a3,1
 456:	9e89                	subw	a3,a3,a0
 458:	00f6853b          	addw	a0,a3,a5
 45c:	0785                	addi	a5,a5,1
 45e:	fff7c703          	lbu	a4,-1(a5)
 462:	fb7d                	bnez	a4,458 <strlen+0x14>
    ;
  return n;
}
 464:	6422                	ld	s0,8(sp)
 466:	0141                	addi	sp,sp,16
 468:	8082                	ret
  for(n = 0; s[n]; n++)
 46a:	4501                	li	a0,0
 46c:	bfe5                	j	464 <strlen+0x20>

000000000000046e <memset>:

void*
memset(void *dst, int c, uint n)
{
 46e:	1141                	addi	sp,sp,-16
 470:	e422                	sd	s0,8(sp)
 472:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 474:	ca19                	beqz	a2,48a <memset+0x1c>
 476:	87aa                	mv	a5,a0
 478:	1602                	slli	a2,a2,0x20
 47a:	9201                	srli	a2,a2,0x20
 47c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 480:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 484:	0785                	addi	a5,a5,1
 486:	fee79de3          	bne	a5,a4,480 <memset+0x12>
  }
  return dst;
}
 48a:	6422                	ld	s0,8(sp)
 48c:	0141                	addi	sp,sp,16
 48e:	8082                	ret

0000000000000490 <strchr>:

char*
strchr(const char *s, char c)
{
 490:	1141                	addi	sp,sp,-16
 492:	e422                	sd	s0,8(sp)
 494:	0800                	addi	s0,sp,16
  for(; *s; s++)
 496:	00054783          	lbu	a5,0(a0)
 49a:	cb99                	beqz	a5,4b0 <strchr+0x20>
    if(*s == c)
 49c:	00f58763          	beq	a1,a5,4aa <strchr+0x1a>
  for(; *s; s++)
 4a0:	0505                	addi	a0,a0,1
 4a2:	00054783          	lbu	a5,0(a0)
 4a6:	fbfd                	bnez	a5,49c <strchr+0xc>
      return (char*)s;
  return 0;
 4a8:	4501                	li	a0,0
}
 4aa:	6422                	ld	s0,8(sp)
 4ac:	0141                	addi	sp,sp,16
 4ae:	8082                	ret
  return 0;
 4b0:	4501                	li	a0,0
 4b2:	bfe5                	j	4aa <strchr+0x1a>

00000000000004b4 <gets>:

char*
gets(char *buf, int max)
{
 4b4:	711d                	addi	sp,sp,-96
 4b6:	ec86                	sd	ra,88(sp)
 4b8:	e8a2                	sd	s0,80(sp)
 4ba:	e4a6                	sd	s1,72(sp)
 4bc:	e0ca                	sd	s2,64(sp)
 4be:	fc4e                	sd	s3,56(sp)
 4c0:	f852                	sd	s4,48(sp)
 4c2:	f456                	sd	s5,40(sp)
 4c4:	f05a                	sd	s6,32(sp)
 4c6:	ec5e                	sd	s7,24(sp)
 4c8:	1080                	addi	s0,sp,96
 4ca:	8baa                	mv	s7,a0
 4cc:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4ce:	892a                	mv	s2,a0
 4d0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4d2:	4aa9                	li	s5,10
 4d4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4d6:	89a6                	mv	s3,s1
 4d8:	2485                	addiw	s1,s1,1
 4da:	0344d863          	bge	s1,s4,50a <gets+0x56>
    cc = read(0, &c, 1);
 4de:	4605                	li	a2,1
 4e0:	faf40593          	addi	a1,s0,-81
 4e4:	4501                	li	a0,0
 4e6:	00000097          	auipc	ra,0x0
 4ea:	19c080e7          	jalr	412(ra) # 682 <read>
    if(cc < 1)
 4ee:	00a05e63          	blez	a0,50a <gets+0x56>
    buf[i++] = c;
 4f2:	faf44783          	lbu	a5,-81(s0)
 4f6:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4fa:	01578763          	beq	a5,s5,508 <gets+0x54>
 4fe:	0905                	addi	s2,s2,1
 500:	fd679be3          	bne	a5,s6,4d6 <gets+0x22>
  for(i=0; i+1 < max; ){
 504:	89a6                	mv	s3,s1
 506:	a011                	j	50a <gets+0x56>
 508:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 50a:	99de                	add	s3,s3,s7
 50c:	00098023          	sb	zero,0(s3)
  return buf;
}
 510:	855e                	mv	a0,s7
 512:	60e6                	ld	ra,88(sp)
 514:	6446                	ld	s0,80(sp)
 516:	64a6                	ld	s1,72(sp)
 518:	6906                	ld	s2,64(sp)
 51a:	79e2                	ld	s3,56(sp)
 51c:	7a42                	ld	s4,48(sp)
 51e:	7aa2                	ld	s5,40(sp)
 520:	7b02                	ld	s6,32(sp)
 522:	6be2                	ld	s7,24(sp)
 524:	6125                	addi	sp,sp,96
 526:	8082                	ret

0000000000000528 <stat>:

int
stat(const char *n, struct stat *st)
{
 528:	1101                	addi	sp,sp,-32
 52a:	ec06                	sd	ra,24(sp)
 52c:	e822                	sd	s0,16(sp)
 52e:	e426                	sd	s1,8(sp)
 530:	e04a                	sd	s2,0(sp)
 532:	1000                	addi	s0,sp,32
 534:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 536:	4581                	li	a1,0
 538:	00000097          	auipc	ra,0x0
 53c:	172080e7          	jalr	370(ra) # 6aa <open>
  if(fd < 0)
 540:	02054563          	bltz	a0,56a <stat+0x42>
 544:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 546:	85ca                	mv	a1,s2
 548:	00000097          	auipc	ra,0x0
 54c:	17a080e7          	jalr	378(ra) # 6c2 <fstat>
 550:	892a                	mv	s2,a0
  close(fd);
 552:	8526                	mv	a0,s1
 554:	00000097          	auipc	ra,0x0
 558:	13e080e7          	jalr	318(ra) # 692 <close>
  return r;
}
 55c:	854a                	mv	a0,s2
 55e:	60e2                	ld	ra,24(sp)
 560:	6442                	ld	s0,16(sp)
 562:	64a2                	ld	s1,8(sp)
 564:	6902                	ld	s2,0(sp)
 566:	6105                	addi	sp,sp,32
 568:	8082                	ret
    return -1;
 56a:	597d                	li	s2,-1
 56c:	bfc5                	j	55c <stat+0x34>

000000000000056e <atoi>:

int
atoi(const char *s)
{
 56e:	1141                	addi	sp,sp,-16
 570:	e422                	sd	s0,8(sp)
 572:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 574:	00054603          	lbu	a2,0(a0)
 578:	fd06079b          	addiw	a5,a2,-48
 57c:	0ff7f793          	zext.b	a5,a5
 580:	4725                	li	a4,9
 582:	02f76963          	bltu	a4,a5,5b4 <atoi+0x46>
 586:	86aa                	mv	a3,a0
  n = 0;
 588:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 58a:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 58c:	0685                	addi	a3,a3,1
 58e:	0025179b          	slliw	a5,a0,0x2
 592:	9fa9                	addw	a5,a5,a0
 594:	0017979b          	slliw	a5,a5,0x1
 598:	9fb1                	addw	a5,a5,a2
 59a:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 59e:	0006c603          	lbu	a2,0(a3)
 5a2:	fd06071b          	addiw	a4,a2,-48
 5a6:	0ff77713          	zext.b	a4,a4
 5aa:	fee5f1e3          	bgeu	a1,a4,58c <atoi+0x1e>
  return n;
}
 5ae:	6422                	ld	s0,8(sp)
 5b0:	0141                	addi	sp,sp,16
 5b2:	8082                	ret
  n = 0;
 5b4:	4501                	li	a0,0
 5b6:	bfe5                	j	5ae <atoi+0x40>

00000000000005b8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5b8:	1141                	addi	sp,sp,-16
 5ba:	e422                	sd	s0,8(sp)
 5bc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 5be:	02b57463          	bgeu	a0,a1,5e6 <memmove+0x2e>
    while(n-- > 0)
 5c2:	00c05f63          	blez	a2,5e0 <memmove+0x28>
 5c6:	1602                	slli	a2,a2,0x20
 5c8:	9201                	srli	a2,a2,0x20
 5ca:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5ce:	872a                	mv	a4,a0
      *dst++ = *src++;
 5d0:	0585                	addi	a1,a1,1
 5d2:	0705                	addi	a4,a4,1
 5d4:	fff5c683          	lbu	a3,-1(a1)
 5d8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5dc:	fee79ae3          	bne	a5,a4,5d0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5e0:	6422                	ld	s0,8(sp)
 5e2:	0141                	addi	sp,sp,16
 5e4:	8082                	ret
    dst += n;
 5e6:	00c50733          	add	a4,a0,a2
    src += n;
 5ea:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5ec:	fec05ae3          	blez	a2,5e0 <memmove+0x28>
 5f0:	fff6079b          	addiw	a5,a2,-1
 5f4:	1782                	slli	a5,a5,0x20
 5f6:	9381                	srli	a5,a5,0x20
 5f8:	fff7c793          	not	a5,a5
 5fc:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5fe:	15fd                	addi	a1,a1,-1
 600:	177d                	addi	a4,a4,-1
 602:	0005c683          	lbu	a3,0(a1)
 606:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 60a:	fee79ae3          	bne	a5,a4,5fe <memmove+0x46>
 60e:	bfc9                	j	5e0 <memmove+0x28>

0000000000000610 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 610:	1141                	addi	sp,sp,-16
 612:	e422                	sd	s0,8(sp)
 614:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 616:	ca05                	beqz	a2,646 <memcmp+0x36>
 618:	fff6069b          	addiw	a3,a2,-1
 61c:	1682                	slli	a3,a3,0x20
 61e:	9281                	srli	a3,a3,0x20
 620:	0685                	addi	a3,a3,1
 622:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 624:	00054783          	lbu	a5,0(a0)
 628:	0005c703          	lbu	a4,0(a1)
 62c:	00e79863          	bne	a5,a4,63c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 630:	0505                	addi	a0,a0,1
    p2++;
 632:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 634:	fed518e3          	bne	a0,a3,624 <memcmp+0x14>
  }
  return 0;
 638:	4501                	li	a0,0
 63a:	a019                	j	640 <memcmp+0x30>
      return *p1 - *p2;
 63c:	40e7853b          	subw	a0,a5,a4
}
 640:	6422                	ld	s0,8(sp)
 642:	0141                	addi	sp,sp,16
 644:	8082                	ret
  return 0;
 646:	4501                	li	a0,0
 648:	bfe5                	j	640 <memcmp+0x30>

000000000000064a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 64a:	1141                	addi	sp,sp,-16
 64c:	e406                	sd	ra,8(sp)
 64e:	e022                	sd	s0,0(sp)
 650:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 652:	00000097          	auipc	ra,0x0
 656:	f66080e7          	jalr	-154(ra) # 5b8 <memmove>
}
 65a:	60a2                	ld	ra,8(sp)
 65c:	6402                	ld	s0,0(sp)
 65e:	0141                	addi	sp,sp,16
 660:	8082                	ret

0000000000000662 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 662:	4885                	li	a7,1
 ecall
 664:	00000073          	ecall
 ret
 668:	8082                	ret

000000000000066a <exit>:
.global exit
exit:
 li a7, SYS_exit
 66a:	4889                	li	a7,2
 ecall
 66c:	00000073          	ecall
 ret
 670:	8082                	ret

0000000000000672 <wait>:
.global wait
wait:
 li a7, SYS_wait
 672:	488d                	li	a7,3
 ecall
 674:	00000073          	ecall
 ret
 678:	8082                	ret

000000000000067a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 67a:	4891                	li	a7,4
 ecall
 67c:	00000073          	ecall
 ret
 680:	8082                	ret

0000000000000682 <read>:
.global read
read:
 li a7, SYS_read
 682:	4895                	li	a7,5
 ecall
 684:	00000073          	ecall
 ret
 688:	8082                	ret

000000000000068a <write>:
.global write
write:
 li a7, SYS_write
 68a:	48c1                	li	a7,16
 ecall
 68c:	00000073          	ecall
 ret
 690:	8082                	ret

0000000000000692 <close>:
.global close
close:
 li a7, SYS_close
 692:	48d5                	li	a7,21
 ecall
 694:	00000073          	ecall
 ret
 698:	8082                	ret

000000000000069a <kill>:
.global kill
kill:
 li a7, SYS_kill
 69a:	4899                	li	a7,6
 ecall
 69c:	00000073          	ecall
 ret
 6a0:	8082                	ret

00000000000006a2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 6a2:	489d                	li	a7,7
 ecall
 6a4:	00000073          	ecall
 ret
 6a8:	8082                	ret

00000000000006aa <open>:
.global open
open:
 li a7, SYS_open
 6aa:	48bd                	li	a7,15
 ecall
 6ac:	00000073          	ecall
 ret
 6b0:	8082                	ret

00000000000006b2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 6b2:	48c5                	li	a7,17
 ecall
 6b4:	00000073          	ecall
 ret
 6b8:	8082                	ret

00000000000006ba <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 6ba:	48c9                	li	a7,18
 ecall
 6bc:	00000073          	ecall
 ret
 6c0:	8082                	ret

00000000000006c2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 6c2:	48a1                	li	a7,8
 ecall
 6c4:	00000073          	ecall
 ret
 6c8:	8082                	ret

00000000000006ca <link>:
.global link
link:
 li a7, SYS_link
 6ca:	48cd                	li	a7,19
 ecall
 6cc:	00000073          	ecall
 ret
 6d0:	8082                	ret

00000000000006d2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6d2:	48d1                	li	a7,20
 ecall
 6d4:	00000073          	ecall
 ret
 6d8:	8082                	ret

00000000000006da <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6da:	48a5                	li	a7,9
 ecall
 6dc:	00000073          	ecall
 ret
 6e0:	8082                	ret

00000000000006e2 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6e2:	48a9                	li	a7,10
 ecall
 6e4:	00000073          	ecall
 ret
 6e8:	8082                	ret

00000000000006ea <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6ea:	48ad                	li	a7,11
 ecall
 6ec:	00000073          	ecall
 ret
 6f0:	8082                	ret

00000000000006f2 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6f2:	48b1                	li	a7,12
 ecall
 6f4:	00000073          	ecall
 ret
 6f8:	8082                	ret

00000000000006fa <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6fa:	48b5                	li	a7,13
 ecall
 6fc:	00000073          	ecall
 ret
 700:	8082                	ret

0000000000000702 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 702:	48b9                	li	a7,14
 ecall
 704:	00000073          	ecall
 ret
 708:	8082                	ret

000000000000070a <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 70a:	48d9                	li	a7,22
 ecall
 70c:	00000073          	ecall
 ret
 710:	8082                	ret

0000000000000712 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 712:	1101                	addi	sp,sp,-32
 714:	ec06                	sd	ra,24(sp)
 716:	e822                	sd	s0,16(sp)
 718:	1000                	addi	s0,sp,32
 71a:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 71e:	4605                	li	a2,1
 720:	fef40593          	addi	a1,s0,-17
 724:	00000097          	auipc	ra,0x0
 728:	f66080e7          	jalr	-154(ra) # 68a <write>
}
 72c:	60e2                	ld	ra,24(sp)
 72e:	6442                	ld	s0,16(sp)
 730:	6105                	addi	sp,sp,32
 732:	8082                	ret

0000000000000734 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 734:	7139                	addi	sp,sp,-64
 736:	fc06                	sd	ra,56(sp)
 738:	f822                	sd	s0,48(sp)
 73a:	f426                	sd	s1,40(sp)
 73c:	f04a                	sd	s2,32(sp)
 73e:	ec4e                	sd	s3,24(sp)
 740:	0080                	addi	s0,sp,64
 742:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 744:	c299                	beqz	a3,74a <printint+0x16>
 746:	0805c863          	bltz	a1,7d6 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 74a:	2581                	sext.w	a1,a1
  neg = 0;
 74c:	4881                	li	a7,0
 74e:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 752:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 754:	2601                	sext.w	a2,a2
 756:	00000517          	auipc	a0,0x0
 75a:	52a50513          	addi	a0,a0,1322 # c80 <digits>
 75e:	883a                	mv	a6,a4
 760:	2705                	addiw	a4,a4,1
 762:	02c5f7bb          	remuw	a5,a1,a2
 766:	1782                	slli	a5,a5,0x20
 768:	9381                	srli	a5,a5,0x20
 76a:	97aa                	add	a5,a5,a0
 76c:	0007c783          	lbu	a5,0(a5)
 770:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 774:	0005879b          	sext.w	a5,a1
 778:	02c5d5bb          	divuw	a1,a1,a2
 77c:	0685                	addi	a3,a3,1
 77e:	fec7f0e3          	bgeu	a5,a2,75e <printint+0x2a>
  if(neg)
 782:	00088b63          	beqz	a7,798 <printint+0x64>
    buf[i++] = '-';
 786:	fd040793          	addi	a5,s0,-48
 78a:	973e                	add	a4,a4,a5
 78c:	02d00793          	li	a5,45
 790:	fef70823          	sb	a5,-16(a4)
 794:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 798:	02e05863          	blez	a4,7c8 <printint+0x94>
 79c:	fc040793          	addi	a5,s0,-64
 7a0:	00e78933          	add	s2,a5,a4
 7a4:	fff78993          	addi	s3,a5,-1
 7a8:	99ba                	add	s3,s3,a4
 7aa:	377d                	addiw	a4,a4,-1
 7ac:	1702                	slli	a4,a4,0x20
 7ae:	9301                	srli	a4,a4,0x20
 7b0:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 7b4:	fff94583          	lbu	a1,-1(s2)
 7b8:	8526                	mv	a0,s1
 7ba:	00000097          	auipc	ra,0x0
 7be:	f58080e7          	jalr	-168(ra) # 712 <putc>
  while(--i >= 0)
 7c2:	197d                	addi	s2,s2,-1
 7c4:	ff3918e3          	bne	s2,s3,7b4 <printint+0x80>
}
 7c8:	70e2                	ld	ra,56(sp)
 7ca:	7442                	ld	s0,48(sp)
 7cc:	74a2                	ld	s1,40(sp)
 7ce:	7902                	ld	s2,32(sp)
 7d0:	69e2                	ld	s3,24(sp)
 7d2:	6121                	addi	sp,sp,64
 7d4:	8082                	ret
    x = -xx;
 7d6:	40b005bb          	negw	a1,a1
    neg = 1;
 7da:	4885                	li	a7,1
    x = -xx;
 7dc:	bf8d                	j	74e <printint+0x1a>

00000000000007de <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7de:	7119                	addi	sp,sp,-128
 7e0:	fc86                	sd	ra,120(sp)
 7e2:	f8a2                	sd	s0,112(sp)
 7e4:	f4a6                	sd	s1,104(sp)
 7e6:	f0ca                	sd	s2,96(sp)
 7e8:	ecce                	sd	s3,88(sp)
 7ea:	e8d2                	sd	s4,80(sp)
 7ec:	e4d6                	sd	s5,72(sp)
 7ee:	e0da                	sd	s6,64(sp)
 7f0:	fc5e                	sd	s7,56(sp)
 7f2:	f862                	sd	s8,48(sp)
 7f4:	f466                	sd	s9,40(sp)
 7f6:	f06a                	sd	s10,32(sp)
 7f8:	ec6e                	sd	s11,24(sp)
 7fa:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7fc:	0005c903          	lbu	s2,0(a1)
 800:	18090f63          	beqz	s2,99e <vprintf+0x1c0>
 804:	8aaa                	mv	s5,a0
 806:	8b32                	mv	s6,a2
 808:	00158493          	addi	s1,a1,1
  state = 0;
 80c:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 80e:	02500a13          	li	s4,37
      if(c == 'd'){
 812:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 816:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 81a:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 81e:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 822:	00000b97          	auipc	s7,0x0
 826:	45eb8b93          	addi	s7,s7,1118 # c80 <digits>
 82a:	a839                	j	848 <vprintf+0x6a>
        putc(fd, c);
 82c:	85ca                	mv	a1,s2
 82e:	8556                	mv	a0,s5
 830:	00000097          	auipc	ra,0x0
 834:	ee2080e7          	jalr	-286(ra) # 712 <putc>
 838:	a019                	j	83e <vprintf+0x60>
    } else if(state == '%'){
 83a:	01498f63          	beq	s3,s4,858 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 83e:	0485                	addi	s1,s1,1
 840:	fff4c903          	lbu	s2,-1(s1)
 844:	14090d63          	beqz	s2,99e <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 848:	0009079b          	sext.w	a5,s2
    if(state == 0){
 84c:	fe0997e3          	bnez	s3,83a <vprintf+0x5c>
      if(c == '%'){
 850:	fd479ee3          	bne	a5,s4,82c <vprintf+0x4e>
        state = '%';
 854:	89be                	mv	s3,a5
 856:	b7e5                	j	83e <vprintf+0x60>
      if(c == 'd'){
 858:	05878063          	beq	a5,s8,898 <vprintf+0xba>
      } else if(c == 'l') {
 85c:	05978c63          	beq	a5,s9,8b4 <vprintf+0xd6>
      } else if(c == 'x') {
 860:	07a78863          	beq	a5,s10,8d0 <vprintf+0xf2>
      } else if(c == 'p') {
 864:	09b78463          	beq	a5,s11,8ec <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 868:	07300713          	li	a4,115
 86c:	0ce78663          	beq	a5,a4,938 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 870:	06300713          	li	a4,99
 874:	0ee78e63          	beq	a5,a4,970 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 878:	11478863          	beq	a5,s4,988 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 87c:	85d2                	mv	a1,s4
 87e:	8556                	mv	a0,s5
 880:	00000097          	auipc	ra,0x0
 884:	e92080e7          	jalr	-366(ra) # 712 <putc>
        putc(fd, c);
 888:	85ca                	mv	a1,s2
 88a:	8556                	mv	a0,s5
 88c:	00000097          	auipc	ra,0x0
 890:	e86080e7          	jalr	-378(ra) # 712 <putc>
      }
      state = 0;
 894:	4981                	li	s3,0
 896:	b765                	j	83e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 898:	008b0913          	addi	s2,s6,8
 89c:	4685                	li	a3,1
 89e:	4629                	li	a2,10
 8a0:	000b2583          	lw	a1,0(s6)
 8a4:	8556                	mv	a0,s5
 8a6:	00000097          	auipc	ra,0x0
 8aa:	e8e080e7          	jalr	-370(ra) # 734 <printint>
 8ae:	8b4a                	mv	s6,s2
      state = 0;
 8b0:	4981                	li	s3,0
 8b2:	b771                	j	83e <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 8b4:	008b0913          	addi	s2,s6,8
 8b8:	4681                	li	a3,0
 8ba:	4629                	li	a2,10
 8bc:	000b2583          	lw	a1,0(s6)
 8c0:	8556                	mv	a0,s5
 8c2:	00000097          	auipc	ra,0x0
 8c6:	e72080e7          	jalr	-398(ra) # 734 <printint>
 8ca:	8b4a                	mv	s6,s2
      state = 0;
 8cc:	4981                	li	s3,0
 8ce:	bf85                	j	83e <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8d0:	008b0913          	addi	s2,s6,8
 8d4:	4681                	li	a3,0
 8d6:	4641                	li	a2,16
 8d8:	000b2583          	lw	a1,0(s6)
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	e56080e7          	jalr	-426(ra) # 734 <printint>
 8e6:	8b4a                	mv	s6,s2
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	bf91                	j	83e <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8ec:	008b0793          	addi	a5,s6,8
 8f0:	f8f43423          	sd	a5,-120(s0)
 8f4:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8f8:	03000593          	li	a1,48
 8fc:	8556                	mv	a0,s5
 8fe:	00000097          	auipc	ra,0x0
 902:	e14080e7          	jalr	-492(ra) # 712 <putc>
  putc(fd, 'x');
 906:	85ea                	mv	a1,s10
 908:	8556                	mv	a0,s5
 90a:	00000097          	auipc	ra,0x0
 90e:	e08080e7          	jalr	-504(ra) # 712 <putc>
 912:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 914:	03c9d793          	srli	a5,s3,0x3c
 918:	97de                	add	a5,a5,s7
 91a:	0007c583          	lbu	a1,0(a5)
 91e:	8556                	mv	a0,s5
 920:	00000097          	auipc	ra,0x0
 924:	df2080e7          	jalr	-526(ra) # 712 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 928:	0992                	slli	s3,s3,0x4
 92a:	397d                	addiw	s2,s2,-1
 92c:	fe0914e3          	bnez	s2,914 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 930:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 934:	4981                	li	s3,0
 936:	b721                	j	83e <vprintf+0x60>
        s = va_arg(ap, char*);
 938:	008b0993          	addi	s3,s6,8
 93c:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 940:	02090163          	beqz	s2,962 <vprintf+0x184>
        while(*s != 0){
 944:	00094583          	lbu	a1,0(s2)
 948:	c9a1                	beqz	a1,998 <vprintf+0x1ba>
          putc(fd, *s);
 94a:	8556                	mv	a0,s5
 94c:	00000097          	auipc	ra,0x0
 950:	dc6080e7          	jalr	-570(ra) # 712 <putc>
          s++;
 954:	0905                	addi	s2,s2,1
        while(*s != 0){
 956:	00094583          	lbu	a1,0(s2)
 95a:	f9e5                	bnez	a1,94a <vprintf+0x16c>
        s = va_arg(ap, char*);
 95c:	8b4e                	mv	s6,s3
      state = 0;
 95e:	4981                	li	s3,0
 960:	bdf9                	j	83e <vprintf+0x60>
          s = "(null)";
 962:	00000917          	auipc	s2,0x0
 966:	31690913          	addi	s2,s2,790 # c78 <malloc+0x1d0>
        while(*s != 0){
 96a:	02800593          	li	a1,40
 96e:	bff1                	j	94a <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 970:	008b0913          	addi	s2,s6,8
 974:	000b4583          	lbu	a1,0(s6)
 978:	8556                	mv	a0,s5
 97a:	00000097          	auipc	ra,0x0
 97e:	d98080e7          	jalr	-616(ra) # 712 <putc>
 982:	8b4a                	mv	s6,s2
      state = 0;
 984:	4981                	li	s3,0
 986:	bd65                	j	83e <vprintf+0x60>
        putc(fd, c);
 988:	85d2                	mv	a1,s4
 98a:	8556                	mv	a0,s5
 98c:	00000097          	auipc	ra,0x0
 990:	d86080e7          	jalr	-634(ra) # 712 <putc>
      state = 0;
 994:	4981                	li	s3,0
 996:	b565                	j	83e <vprintf+0x60>
        s = va_arg(ap, char*);
 998:	8b4e                	mv	s6,s3
      state = 0;
 99a:	4981                	li	s3,0
 99c:	b54d                	j	83e <vprintf+0x60>
    }
  }
}
 99e:	70e6                	ld	ra,120(sp)
 9a0:	7446                	ld	s0,112(sp)
 9a2:	74a6                	ld	s1,104(sp)
 9a4:	7906                	ld	s2,96(sp)
 9a6:	69e6                	ld	s3,88(sp)
 9a8:	6a46                	ld	s4,80(sp)
 9aa:	6aa6                	ld	s5,72(sp)
 9ac:	6b06                	ld	s6,64(sp)
 9ae:	7be2                	ld	s7,56(sp)
 9b0:	7c42                	ld	s8,48(sp)
 9b2:	7ca2                	ld	s9,40(sp)
 9b4:	7d02                	ld	s10,32(sp)
 9b6:	6de2                	ld	s11,24(sp)
 9b8:	6109                	addi	sp,sp,128
 9ba:	8082                	ret

00000000000009bc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 9bc:	715d                	addi	sp,sp,-80
 9be:	ec06                	sd	ra,24(sp)
 9c0:	e822                	sd	s0,16(sp)
 9c2:	1000                	addi	s0,sp,32
 9c4:	e010                	sd	a2,0(s0)
 9c6:	e414                	sd	a3,8(s0)
 9c8:	e818                	sd	a4,16(s0)
 9ca:	ec1c                	sd	a5,24(s0)
 9cc:	03043023          	sd	a6,32(s0)
 9d0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9d4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9d8:	8622                	mv	a2,s0
 9da:	00000097          	auipc	ra,0x0
 9de:	e04080e7          	jalr	-508(ra) # 7de <vprintf>
}
 9e2:	60e2                	ld	ra,24(sp)
 9e4:	6442                	ld	s0,16(sp)
 9e6:	6161                	addi	sp,sp,80
 9e8:	8082                	ret

00000000000009ea <printf>:

void
printf(const char *fmt, ...)
{
 9ea:	711d                	addi	sp,sp,-96
 9ec:	ec06                	sd	ra,24(sp)
 9ee:	e822                	sd	s0,16(sp)
 9f0:	1000                	addi	s0,sp,32
 9f2:	e40c                	sd	a1,8(s0)
 9f4:	e810                	sd	a2,16(s0)
 9f6:	ec14                	sd	a3,24(s0)
 9f8:	f018                	sd	a4,32(s0)
 9fa:	f41c                	sd	a5,40(s0)
 9fc:	03043823          	sd	a6,48(s0)
 a00:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 a04:	00840613          	addi	a2,s0,8
 a08:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 a0c:	85aa                	mv	a1,a0
 a0e:	4505                	li	a0,1
 a10:	00000097          	auipc	ra,0x0
 a14:	dce080e7          	jalr	-562(ra) # 7de <vprintf>
}
 a18:	60e2                	ld	ra,24(sp)
 a1a:	6442                	ld	s0,16(sp)
 a1c:	6125                	addi	sp,sp,96
 a1e:	8082                	ret

0000000000000a20 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a20:	1141                	addi	sp,sp,-16
 a22:	e422                	sd	s0,8(sp)
 a24:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a26:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a2a:	00000797          	auipc	a5,0x0
 a2e:	26e7b783          	ld	a5,622(a5) # c98 <freep>
 a32:	a805                	j	a62 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a34:	4618                	lw	a4,8(a2)
 a36:	9db9                	addw	a1,a1,a4
 a38:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a3c:	6398                	ld	a4,0(a5)
 a3e:	6318                	ld	a4,0(a4)
 a40:	fee53823          	sd	a4,-16(a0)
 a44:	a091                	j	a88 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a46:	ff852703          	lw	a4,-8(a0)
 a4a:	9e39                	addw	a2,a2,a4
 a4c:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a4e:	ff053703          	ld	a4,-16(a0)
 a52:	e398                	sd	a4,0(a5)
 a54:	a099                	j	a9a <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a56:	6398                	ld	a4,0(a5)
 a58:	00e7e463          	bltu	a5,a4,a60 <free+0x40>
 a5c:	00e6ea63          	bltu	a3,a4,a70 <free+0x50>
{
 a60:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a62:	fed7fae3          	bgeu	a5,a3,a56 <free+0x36>
 a66:	6398                	ld	a4,0(a5)
 a68:	00e6e463          	bltu	a3,a4,a70 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a6c:	fee7eae3          	bltu	a5,a4,a60 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a70:	ff852583          	lw	a1,-8(a0)
 a74:	6390                	ld	a2,0(a5)
 a76:	02059813          	slli	a6,a1,0x20
 a7a:	01c85713          	srli	a4,a6,0x1c
 a7e:	9736                	add	a4,a4,a3
 a80:	fae60ae3          	beq	a2,a4,a34 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a84:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a88:	4790                	lw	a2,8(a5)
 a8a:	02061593          	slli	a1,a2,0x20
 a8e:	01c5d713          	srli	a4,a1,0x1c
 a92:	973e                	add	a4,a4,a5
 a94:	fae689e3          	beq	a3,a4,a46 <free+0x26>
  } else
    p->s.ptr = bp;
 a98:	e394                	sd	a3,0(a5)
  freep = p;
 a9a:	00000717          	auipc	a4,0x0
 a9e:	1ef73f23          	sd	a5,510(a4) # c98 <freep>
}
 aa2:	6422                	ld	s0,8(sp)
 aa4:	0141                	addi	sp,sp,16
 aa6:	8082                	ret

0000000000000aa8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 aa8:	7139                	addi	sp,sp,-64
 aaa:	fc06                	sd	ra,56(sp)
 aac:	f822                	sd	s0,48(sp)
 aae:	f426                	sd	s1,40(sp)
 ab0:	f04a                	sd	s2,32(sp)
 ab2:	ec4e                	sd	s3,24(sp)
 ab4:	e852                	sd	s4,16(sp)
 ab6:	e456                	sd	s5,8(sp)
 ab8:	e05a                	sd	s6,0(sp)
 aba:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 abc:	02051493          	slli	s1,a0,0x20
 ac0:	9081                	srli	s1,s1,0x20
 ac2:	04bd                	addi	s1,s1,15
 ac4:	8091                	srli	s1,s1,0x4
 ac6:	0014899b          	addiw	s3,s1,1
 aca:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 acc:	00000517          	auipc	a0,0x0
 ad0:	1cc53503          	ld	a0,460(a0) # c98 <freep>
 ad4:	c515                	beqz	a0,b00 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ad8:	4798                	lw	a4,8(a5)
 ada:	02977f63          	bgeu	a4,s1,b18 <malloc+0x70>
 ade:	8a4e                	mv	s4,s3
 ae0:	0009871b          	sext.w	a4,s3
 ae4:	6685                	lui	a3,0x1
 ae6:	00d77363          	bgeu	a4,a3,aec <malloc+0x44>
 aea:	6a05                	lui	s4,0x1
 aec:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 af0:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 af4:	00000917          	auipc	s2,0x0
 af8:	1a490913          	addi	s2,s2,420 # c98 <freep>
  if(p == (char*)-1)
 afc:	5afd                	li	s5,-1
 afe:	a895                	j	b72 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 b00:	00000797          	auipc	a5,0x0
 b04:	29078793          	addi	a5,a5,656 # d90 <base>
 b08:	00000717          	auipc	a4,0x0
 b0c:	18f73823          	sd	a5,400(a4) # c98 <freep>
 b10:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 b12:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 b16:	b7e1                	j	ade <malloc+0x36>
      if(p->s.size == nunits)
 b18:	02e48c63          	beq	s1,a4,b50 <malloc+0xa8>
        p->s.size -= nunits;
 b1c:	4137073b          	subw	a4,a4,s3
 b20:	c798                	sw	a4,8(a5)
        p += p->s.size;
 b22:	02071693          	slli	a3,a4,0x20
 b26:	01c6d713          	srli	a4,a3,0x1c
 b2a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b2c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b30:	00000717          	auipc	a4,0x0
 b34:	16a73423          	sd	a0,360(a4) # c98 <freep>
      return (void*)(p + 1);
 b38:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b3c:	70e2                	ld	ra,56(sp)
 b3e:	7442                	ld	s0,48(sp)
 b40:	74a2                	ld	s1,40(sp)
 b42:	7902                	ld	s2,32(sp)
 b44:	69e2                	ld	s3,24(sp)
 b46:	6a42                	ld	s4,16(sp)
 b48:	6aa2                	ld	s5,8(sp)
 b4a:	6b02                	ld	s6,0(sp)
 b4c:	6121                	addi	sp,sp,64
 b4e:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b50:	6398                	ld	a4,0(a5)
 b52:	e118                	sd	a4,0(a0)
 b54:	bff1                	j	b30 <malloc+0x88>
  hp->s.size = nu;
 b56:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b5a:	0541                	addi	a0,a0,16
 b5c:	00000097          	auipc	ra,0x0
 b60:	ec4080e7          	jalr	-316(ra) # a20 <free>
  return freep;
 b64:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b68:	d971                	beqz	a0,b3c <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b6a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b6c:	4798                	lw	a4,8(a5)
 b6e:	fa9775e3          	bgeu	a4,s1,b18 <malloc+0x70>
    if(p == freep)
 b72:	00093703          	ld	a4,0(s2)
 b76:	853e                	mv	a0,a5
 b78:	fef719e3          	bne	a4,a5,b6a <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 b7c:	8552                	mv	a0,s4
 b7e:	00000097          	auipc	ra,0x0
 b82:	b74080e7          	jalr	-1164(ra) # 6f2 <sbrk>
  if(p == (char*)-1)
 b86:	fd5518e3          	bne	a0,s5,b56 <malloc+0xae>
        return 0;
 b8a:	4501                	li	a0,0
 b8c:	bf45                	j	b3c <malloc+0x94>
