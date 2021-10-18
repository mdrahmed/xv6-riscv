
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	ac250513          	addi	a0,a0,-1342 # ad0 <malloc+0xea>
  16:	00000097          	auipc	ra,0x0
  1a:	5d2080e7          	jalr	1490(ra) # 5e8 <open>
  1e:	06054363          	bltz	a0,84 <main+0x84>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  22:	4501                	li	a0,0
  24:	00000097          	auipc	ra,0x0
  28:	5fc080e7          	jalr	1532(ra) # 620 <dup>
  dup(0);  // stderr
  2c:	4501                	li	a0,0
  2e:	00000097          	auipc	ra,0x0
  32:	5f2080e7          	jalr	1522(ra) # 620 <dup>

  for(;;){
    printf("init: starting sh\n");
  36:	00001917          	auipc	s2,0x1
  3a:	aa290913          	addi	s2,s2,-1374 # ad8 <malloc+0xf2>
  3e:	854a                	mv	a0,s2
  40:	00001097          	auipc	ra,0x1
  44:	8e8080e7          	jalr	-1816(ra) # 928 <printf>
    pid = fork();
  48:	00000097          	auipc	ra,0x0
  4c:	558080e7          	jalr	1368(ra) # 5a0 <fork>
  50:	84aa                	mv	s1,a0
    if(pid < 0){
  52:	04054d63          	bltz	a0,ac <main+0xac>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  56:	c925                	beqz	a0,c6 <main+0xc6>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  58:	4501                	li	a0,0
  5a:	00000097          	auipc	ra,0x0
  5e:	556080e7          	jalr	1366(ra) # 5b0 <wait>
      if(wpid == pid){
  62:	fca48ee3          	beq	s1,a0,3e <main+0x3e>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  66:	fe0559e3          	bgez	a0,58 <main+0x58>
        printf("init: wait returned an error\n");
  6a:	00001517          	auipc	a0,0x1
  6e:	abe50513          	addi	a0,a0,-1346 # b28 <malloc+0x142>
  72:	00001097          	auipc	ra,0x1
  76:	8b6080e7          	jalr	-1866(ra) # 928 <printf>
        exit(1);
  7a:	4505                	li	a0,1
  7c:	00000097          	auipc	ra,0x0
  80:	52c080e7          	jalr	1324(ra) # 5a8 <exit>
    mknod("console", CONSOLE, 0);
  84:	4601                	li	a2,0
  86:	4585                	li	a1,1
  88:	00001517          	auipc	a0,0x1
  8c:	a4850513          	addi	a0,a0,-1464 # ad0 <malloc+0xea>
  90:	00000097          	auipc	ra,0x0
  94:	560080e7          	jalr	1376(ra) # 5f0 <mknod>
    open("console", O_RDWR);
  98:	4589                	li	a1,2
  9a:	00001517          	auipc	a0,0x1
  9e:	a3650513          	addi	a0,a0,-1482 # ad0 <malloc+0xea>
  a2:	00000097          	auipc	ra,0x0
  a6:	546080e7          	jalr	1350(ra) # 5e8 <open>
  aa:	bfa5                	j	22 <main+0x22>
      printf("init: fork failed\n");
  ac:	00001517          	auipc	a0,0x1
  b0:	a4450513          	addi	a0,a0,-1468 # af0 <malloc+0x10a>
  b4:	00001097          	auipc	ra,0x1
  b8:	874080e7          	jalr	-1932(ra) # 928 <printf>
      exit(1);
  bc:	4505                	li	a0,1
  be:	00000097          	auipc	ra,0x0
  c2:	4ea080e7          	jalr	1258(ra) # 5a8 <exit>
      exec("sh", argv);
  c6:	00001597          	auipc	a1,0x1
  ca:	aa258593          	addi	a1,a1,-1374 # b68 <argv>
  ce:	00001517          	auipc	a0,0x1
  d2:	a3a50513          	addi	a0,a0,-1478 # b08 <malloc+0x122>
  d6:	00000097          	auipc	ra,0x0
  da:	50a080e7          	jalr	1290(ra) # 5e0 <exec>
      printf("init: exec sh failed\n");
  de:	00001517          	auipc	a0,0x1
  e2:	a3250513          	addi	a0,a0,-1486 # b10 <malloc+0x12a>
  e6:	00001097          	auipc	ra,0x1
  ea:	842080e7          	jalr	-1982(ra) # 928 <printf>
      exit(1);
  ee:	4505                	li	a0,1
  f0:	00000097          	auipc	ra,0x0
  f4:	4b8080e7          	jalr	1208(ra) # 5a8 <exit>

00000000000000f8 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
  fe:	0f50000f          	fence	iorw,ow
 102:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 106:	6422                	ld	s0,8(sp)
 108:	0141                	addi	sp,sp,16
 10a:	8082                	ret

000000000000010c <load>:

int load(uint64 *p) {
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 112:	0ff0000f          	fence
 116:	6108                	ld	a0,0(a0)
 118:	0ff0000f          	fence
}
 11c:	2501                	sext.w	a0,a0
 11e:	6422                	ld	s0,8(sp)
 120:	0141                	addi	sp,sp,16
 122:	8082                	ret

0000000000000124 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 124:	7139                	addi	sp,sp,-64
 126:	fc06                	sd	ra,56(sp)
 128:	f822                	sd	s0,48(sp)
 12a:	f426                	sd	s1,40(sp)
 12c:	f04a                	sd	s2,32(sp)
 12e:	ec4e                	sd	s3,24(sp)
 130:	e852                	sd	s4,16(sp)
 132:	e456                	sd	s5,8(sp)
 134:	e05a                	sd	s6,0(sp)
 136:	0080                	addi	s0,sp,64
 138:	8a2a                	mv	s4,a0
 13a:	89ae                	mv	s3,a1
 13c:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 13e:	4785                	li	a5,1
 140:	00001497          	auipc	s1,0x1
 144:	a5048493          	addi	s1,s1,-1456 # b90 <rings+0x8>
 148:	00001917          	auipc	s2,0x1
 14c:	b3890913          	addi	s2,s2,-1224 # c80 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 150:	00001b17          	auipc	s6,0x1
 154:	a28b0b13          	addi	s6,s6,-1496 # b78 <vm_addr>
  if(open_close == 1){
 158:	04f59063          	bne	a1,a5,198 <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 15c:	00001497          	auipc	s1,0x1
 160:	a3c4a483          	lw	s1,-1476(s1) # b98 <rings+0x10>
 164:	c099                	beqz	s1,16a <create_or_close_the_buffer_user+0x46>
 166:	4481                	li	s1,0
 168:	a899                	j	1be <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 16a:	865a                	mv	a2,s6
 16c:	4585                	li	a1,1
 16e:	00000097          	auipc	ra,0x0
 172:	4da080e7          	jalr	1242(ra) # 648 <ringbuf>
        rings[i].book->write_done = 0;
 176:	00001797          	auipc	a5,0x1
 17a:	a1278793          	addi	a5,a5,-1518 # b88 <rings>
 17e:	6798                	ld	a4,8(a5)
 180:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 184:	6798                	ld	a4,8(a5)
 186:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 18a:	4b98                	lw	a4,16(a5)
 18c:	2705                	addiw	a4,a4,1
 18e:	cb98                	sw	a4,16(a5)
        break;
 190:	a03d                	j	1be <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 192:	04e1                	addi	s1,s1,24
 194:	03248463          	beq	s1,s2,1bc <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 198:	449c                	lw	a5,8(s1)
 19a:	dfe5                	beqz	a5,192 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 19c:	865a                	mv	a2,s6
 19e:	85ce                	mv	a1,s3
 1a0:	8552                	mv	a0,s4
 1a2:	00000097          	auipc	ra,0x0
 1a6:	4a6080e7          	jalr	1190(ra) # 648 <ringbuf>
        rings[i].book->write_done = 0;
 1aa:	609c                	ld	a5,0(s1)
 1ac:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 1b0:	609c                	ld	a5,0(s1)
 1b2:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 1b6:	0004a423          	sw	zero,8(s1)
 1ba:	bfe1                	j	192 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 1bc:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 1be:	00001797          	auipc	a5,0x1
 1c2:	9ba7b783          	ld	a5,-1606(a5) # b78 <vm_addr>
 1c6:	00fab023          	sd	a5,0(s5)
  return i;
}
 1ca:	8526                	mv	a0,s1
 1cc:	70e2                	ld	ra,56(sp)
 1ce:	7442                	ld	s0,48(sp)
 1d0:	74a2                	ld	s1,40(sp)
 1d2:	7902                	ld	s2,32(sp)
 1d4:	69e2                	ld	s3,24(sp)
 1d6:	6a42                	ld	s4,16(sp)
 1d8:	6aa2                	ld	s5,8(sp)
 1da:	6b02                	ld	s6,0(sp)
 1dc:	6121                	addi	sp,sp,64
 1de:	8082                	ret

00000000000001e0 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 1e0:	1101                	addi	sp,sp,-32
 1e2:	ec06                	sd	ra,24(sp)
 1e4:	e822                	sd	s0,16(sp)
 1e6:	e426                	sd	s1,8(sp)
 1e8:	1000                	addi	s0,sp,32
 1ea:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 1ec:	00001797          	auipc	a5,0x1
 1f0:	98c7b783          	ld	a5,-1652(a5) # b78 <vm_addr>
 1f4:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 1f6:	421c                	lw	a5,0(a2)
 1f8:	e79d                	bnez	a5,226 <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 1fa:	00001697          	auipc	a3,0x1
 1fe:	98e68693          	addi	a3,a3,-1650 # b88 <rings>
 202:	669c                	ld	a5,8(a3)
 204:	6398                	ld	a4,0(a5)
 206:	67c1                	lui	a5,0x10
 208:	9fb9                	addw	a5,a5,a4
 20a:	00151713          	slli	a4,a0,0x1
 20e:	953a                	add	a0,a0,a4
 210:	050e                	slli	a0,a0,0x3
 212:	9536                	add	a0,a0,a3
 214:	6518                	ld	a4,8(a0)
 216:	6718                	ld	a4,8(a4)
 218:	9f99                	subw	a5,a5,a4
 21a:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 21c:	60e2                	ld	ra,24(sp)
 21e:	6442                	ld	s0,16(sp)
 220:	64a2                	ld	s1,8(sp)
 222:	6105                	addi	sp,sp,32
 224:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 226:	00151793          	slli	a5,a0,0x1
 22a:	953e                	add	a0,a0,a5
 22c:	050e                	slli	a0,a0,0x3
 22e:	00001797          	auipc	a5,0x1
 232:	95a78793          	addi	a5,a5,-1702 # b88 <rings>
 236:	953e                	add	a0,a0,a5
 238:	6508                	ld	a0,8(a0)
 23a:	0521                	addi	a0,a0,8
 23c:	00000097          	auipc	ra,0x0
 240:	ed0080e7          	jalr	-304(ra) # 10c <load>
 244:	c088                	sw	a0,0(s1)
}
 246:	bfd9                	j	21c <ringbuf_start_write+0x3c>

0000000000000248 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 248:	1141                	addi	sp,sp,-16
 24a:	e406                	sd	ra,8(sp)
 24c:	e022                	sd	s0,0(sp)
 24e:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 250:	00151793          	slli	a5,a0,0x1
 254:	97aa                	add	a5,a5,a0
 256:	078e                	slli	a5,a5,0x3
 258:	00001517          	auipc	a0,0x1
 25c:	93050513          	addi	a0,a0,-1744 # b88 <rings>
 260:	97aa                	add	a5,a5,a0
 262:	6788                	ld	a0,8(a5)
 264:	0035959b          	slliw	a1,a1,0x3
 268:	0521                	addi	a0,a0,8
 26a:	00000097          	auipc	ra,0x0
 26e:	e8e080e7          	jalr	-370(ra) # f8 <store>
}
 272:	60a2                	ld	ra,8(sp)
 274:	6402                	ld	s0,0(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret

000000000000027a <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 27a:	1101                	addi	sp,sp,-32
 27c:	ec06                	sd	ra,24(sp)
 27e:	e822                	sd	s0,16(sp)
 280:	e426                	sd	s1,8(sp)
 282:	1000                	addi	s0,sp,32
 284:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 286:	00151793          	slli	a5,a0,0x1
 28a:	97aa                	add	a5,a5,a0
 28c:	078e                	slli	a5,a5,0x3
 28e:	00001517          	auipc	a0,0x1
 292:	8fa50513          	addi	a0,a0,-1798 # b88 <rings>
 296:	97aa                	add	a5,a5,a0
 298:	6788                	ld	a0,8(a5)
 29a:	0521                	addi	a0,a0,8
 29c:	00000097          	auipc	ra,0x0
 2a0:	e70080e7          	jalr	-400(ra) # 10c <load>
 2a4:	c088                	sw	a0,0(s1)
}
 2a6:	60e2                	ld	ra,24(sp)
 2a8:	6442                	ld	s0,16(sp)
 2aa:	64a2                	ld	s1,8(sp)
 2ac:	6105                	addi	sp,sp,32
 2ae:	8082                	ret

00000000000002b0 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 2b0:	1101                	addi	sp,sp,-32
 2b2:	ec06                	sd	ra,24(sp)
 2b4:	e822                	sd	s0,16(sp)
 2b6:	e426                	sd	s1,8(sp)
 2b8:	1000                	addi	s0,sp,32
 2ba:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 2bc:	00151793          	slli	a5,a0,0x1
 2c0:	97aa                	add	a5,a5,a0
 2c2:	078e                	slli	a5,a5,0x3
 2c4:	00001517          	auipc	a0,0x1
 2c8:	8c450513          	addi	a0,a0,-1852 # b88 <rings>
 2cc:	97aa                	add	a5,a5,a0
 2ce:	6788                	ld	a0,8(a5)
 2d0:	611c                	ld	a5,0(a0)
 2d2:	ef99                	bnez	a5,2f0 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2d4:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2d6:	41f7579b          	sraiw	a5,a4,0x1f
 2da:	01d7d79b          	srliw	a5,a5,0x1d
 2de:	9fb9                	addw	a5,a5,a4
 2e0:	4037d79b          	sraiw	a5,a5,0x3
 2e4:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 2e6:	60e2                	ld	ra,24(sp)
 2e8:	6442                	ld	s0,16(sp)
 2ea:	64a2                	ld	s1,8(sp)
 2ec:	6105                	addi	sp,sp,32
 2ee:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 2f0:	00000097          	auipc	ra,0x0
 2f4:	e1c080e7          	jalr	-484(ra) # 10c <load>
    *bytes /= 8;
 2f8:	41f5579b          	sraiw	a5,a0,0x1f
 2fc:	01d7d79b          	srliw	a5,a5,0x1d
 300:	9d3d                	addw	a0,a0,a5
 302:	4035551b          	sraiw	a0,a0,0x3
 306:	c088                	sw	a0,0(s1)
}
 308:	bff9                	j	2e6 <ringbuf_start_read+0x36>

000000000000030a <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 30a:	1141                	addi	sp,sp,-16
 30c:	e406                	sd	ra,8(sp)
 30e:	e022                	sd	s0,0(sp)
 310:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 312:	00151793          	slli	a5,a0,0x1
 316:	97aa                	add	a5,a5,a0
 318:	078e                	slli	a5,a5,0x3
 31a:	00001517          	auipc	a0,0x1
 31e:	86e50513          	addi	a0,a0,-1938 # b88 <rings>
 322:	97aa                	add	a5,a5,a0
 324:	0035959b          	slliw	a1,a1,0x3
 328:	6788                	ld	a0,8(a5)
 32a:	00000097          	auipc	ra,0x0
 32e:	dce080e7          	jalr	-562(ra) # f8 <store>
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <strcpy>:



char*
strcpy(char *s, const char *t)
{
 33a:	1141                	addi	sp,sp,-16
 33c:	e422                	sd	s0,8(sp)
 33e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 340:	87aa                	mv	a5,a0
 342:	0585                	addi	a1,a1,1
 344:	0785                	addi	a5,a5,1
 346:	fff5c703          	lbu	a4,-1(a1)
 34a:	fee78fa3          	sb	a4,-1(a5)
 34e:	fb75                	bnez	a4,342 <strcpy+0x8>
    ;
  return os;
}
 350:	6422                	ld	s0,8(sp)
 352:	0141                	addi	sp,sp,16
 354:	8082                	ret

0000000000000356 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 356:	1141                	addi	sp,sp,-16
 358:	e422                	sd	s0,8(sp)
 35a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 35c:	00054783          	lbu	a5,0(a0)
 360:	cb91                	beqz	a5,374 <strcmp+0x1e>
 362:	0005c703          	lbu	a4,0(a1)
 366:	00f71763          	bne	a4,a5,374 <strcmp+0x1e>
    p++, q++;
 36a:	0505                	addi	a0,a0,1
 36c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 36e:	00054783          	lbu	a5,0(a0)
 372:	fbe5                	bnez	a5,362 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 374:	0005c503          	lbu	a0,0(a1)
}
 378:	40a7853b          	subw	a0,a5,a0
 37c:	6422                	ld	s0,8(sp)
 37e:	0141                	addi	sp,sp,16
 380:	8082                	ret

0000000000000382 <strlen>:

uint
strlen(const char *s)
{
 382:	1141                	addi	sp,sp,-16
 384:	e422                	sd	s0,8(sp)
 386:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 388:	00054783          	lbu	a5,0(a0)
 38c:	cf91                	beqz	a5,3a8 <strlen+0x26>
 38e:	0505                	addi	a0,a0,1
 390:	87aa                	mv	a5,a0
 392:	4685                	li	a3,1
 394:	9e89                	subw	a3,a3,a0
 396:	00f6853b          	addw	a0,a3,a5
 39a:	0785                	addi	a5,a5,1
 39c:	fff7c703          	lbu	a4,-1(a5)
 3a0:	fb7d                	bnez	a4,396 <strlen+0x14>
    ;
  return n;
}
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret
  for(n = 0; s[n]; n++)
 3a8:	4501                	li	a0,0
 3aa:	bfe5                	j	3a2 <strlen+0x20>

00000000000003ac <memset>:

void*
memset(void *dst, int c, uint n)
{
 3ac:	1141                	addi	sp,sp,-16
 3ae:	e422                	sd	s0,8(sp)
 3b0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3b2:	ca19                	beqz	a2,3c8 <memset+0x1c>
 3b4:	87aa                	mv	a5,a0
 3b6:	1602                	slli	a2,a2,0x20
 3b8:	9201                	srli	a2,a2,0x20
 3ba:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3be:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3c2:	0785                	addi	a5,a5,1
 3c4:	fee79de3          	bne	a5,a4,3be <memset+0x12>
  }
  return dst;
}
 3c8:	6422                	ld	s0,8(sp)
 3ca:	0141                	addi	sp,sp,16
 3cc:	8082                	ret

00000000000003ce <strchr>:

char*
strchr(const char *s, char c)
{
 3ce:	1141                	addi	sp,sp,-16
 3d0:	e422                	sd	s0,8(sp)
 3d2:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3d4:	00054783          	lbu	a5,0(a0)
 3d8:	cb99                	beqz	a5,3ee <strchr+0x20>
    if(*s == c)
 3da:	00f58763          	beq	a1,a5,3e8 <strchr+0x1a>
  for(; *s; s++)
 3de:	0505                	addi	a0,a0,1
 3e0:	00054783          	lbu	a5,0(a0)
 3e4:	fbfd                	bnez	a5,3da <strchr+0xc>
      return (char*)s;
  return 0;
 3e6:	4501                	li	a0,0
}
 3e8:	6422                	ld	s0,8(sp)
 3ea:	0141                	addi	sp,sp,16
 3ec:	8082                	ret
  return 0;
 3ee:	4501                	li	a0,0
 3f0:	bfe5                	j	3e8 <strchr+0x1a>

00000000000003f2 <gets>:

char*
gets(char *buf, int max)
{
 3f2:	711d                	addi	sp,sp,-96
 3f4:	ec86                	sd	ra,88(sp)
 3f6:	e8a2                	sd	s0,80(sp)
 3f8:	e4a6                	sd	s1,72(sp)
 3fa:	e0ca                	sd	s2,64(sp)
 3fc:	fc4e                	sd	s3,56(sp)
 3fe:	f852                	sd	s4,48(sp)
 400:	f456                	sd	s5,40(sp)
 402:	f05a                	sd	s6,32(sp)
 404:	ec5e                	sd	s7,24(sp)
 406:	1080                	addi	s0,sp,96
 408:	8baa                	mv	s7,a0
 40a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 40c:	892a                	mv	s2,a0
 40e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 410:	4aa9                	li	s5,10
 412:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 414:	89a6                	mv	s3,s1
 416:	2485                	addiw	s1,s1,1
 418:	0344d863          	bge	s1,s4,448 <gets+0x56>
    cc = read(0, &c, 1);
 41c:	4605                	li	a2,1
 41e:	faf40593          	addi	a1,s0,-81
 422:	4501                	li	a0,0
 424:	00000097          	auipc	ra,0x0
 428:	19c080e7          	jalr	412(ra) # 5c0 <read>
    if(cc < 1)
 42c:	00a05e63          	blez	a0,448 <gets+0x56>
    buf[i++] = c;
 430:	faf44783          	lbu	a5,-81(s0)
 434:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 438:	01578763          	beq	a5,s5,446 <gets+0x54>
 43c:	0905                	addi	s2,s2,1
 43e:	fd679be3          	bne	a5,s6,414 <gets+0x22>
  for(i=0; i+1 < max; ){
 442:	89a6                	mv	s3,s1
 444:	a011                	j	448 <gets+0x56>
 446:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 448:	99de                	add	s3,s3,s7
 44a:	00098023          	sb	zero,0(s3)
  return buf;
}
 44e:	855e                	mv	a0,s7
 450:	60e6                	ld	ra,88(sp)
 452:	6446                	ld	s0,80(sp)
 454:	64a6                	ld	s1,72(sp)
 456:	6906                	ld	s2,64(sp)
 458:	79e2                	ld	s3,56(sp)
 45a:	7a42                	ld	s4,48(sp)
 45c:	7aa2                	ld	s5,40(sp)
 45e:	7b02                	ld	s6,32(sp)
 460:	6be2                	ld	s7,24(sp)
 462:	6125                	addi	sp,sp,96
 464:	8082                	ret

0000000000000466 <stat>:

int
stat(const char *n, struct stat *st)
{
 466:	1101                	addi	sp,sp,-32
 468:	ec06                	sd	ra,24(sp)
 46a:	e822                	sd	s0,16(sp)
 46c:	e426                	sd	s1,8(sp)
 46e:	e04a                	sd	s2,0(sp)
 470:	1000                	addi	s0,sp,32
 472:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 474:	4581                	li	a1,0
 476:	00000097          	auipc	ra,0x0
 47a:	172080e7          	jalr	370(ra) # 5e8 <open>
  if(fd < 0)
 47e:	02054563          	bltz	a0,4a8 <stat+0x42>
 482:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 484:	85ca                	mv	a1,s2
 486:	00000097          	auipc	ra,0x0
 48a:	17a080e7          	jalr	378(ra) # 600 <fstat>
 48e:	892a                	mv	s2,a0
  close(fd);
 490:	8526                	mv	a0,s1
 492:	00000097          	auipc	ra,0x0
 496:	13e080e7          	jalr	318(ra) # 5d0 <close>
  return r;
}
 49a:	854a                	mv	a0,s2
 49c:	60e2                	ld	ra,24(sp)
 49e:	6442                	ld	s0,16(sp)
 4a0:	64a2                	ld	s1,8(sp)
 4a2:	6902                	ld	s2,0(sp)
 4a4:	6105                	addi	sp,sp,32
 4a6:	8082                	ret
    return -1;
 4a8:	597d                	li	s2,-1
 4aa:	bfc5                	j	49a <stat+0x34>

00000000000004ac <atoi>:

int
atoi(const char *s)
{
 4ac:	1141                	addi	sp,sp,-16
 4ae:	e422                	sd	s0,8(sp)
 4b0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4b2:	00054603          	lbu	a2,0(a0)
 4b6:	fd06079b          	addiw	a5,a2,-48
 4ba:	0ff7f793          	zext.b	a5,a5
 4be:	4725                	li	a4,9
 4c0:	02f76963          	bltu	a4,a5,4f2 <atoi+0x46>
 4c4:	86aa                	mv	a3,a0
  n = 0;
 4c6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4c8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4ca:	0685                	addi	a3,a3,1
 4cc:	0025179b          	slliw	a5,a0,0x2
 4d0:	9fa9                	addw	a5,a5,a0
 4d2:	0017979b          	slliw	a5,a5,0x1
 4d6:	9fb1                	addw	a5,a5,a2
 4d8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4dc:	0006c603          	lbu	a2,0(a3)
 4e0:	fd06071b          	addiw	a4,a2,-48
 4e4:	0ff77713          	zext.b	a4,a4
 4e8:	fee5f1e3          	bgeu	a1,a4,4ca <atoi+0x1e>
  return n;
}
 4ec:	6422                	ld	s0,8(sp)
 4ee:	0141                	addi	sp,sp,16
 4f0:	8082                	ret
  n = 0;
 4f2:	4501                	li	a0,0
 4f4:	bfe5                	j	4ec <atoi+0x40>

00000000000004f6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 4f6:	1141                	addi	sp,sp,-16
 4f8:	e422                	sd	s0,8(sp)
 4fa:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 4fc:	02b57463          	bgeu	a0,a1,524 <memmove+0x2e>
    while(n-- > 0)
 500:	00c05f63          	blez	a2,51e <memmove+0x28>
 504:	1602                	slli	a2,a2,0x20
 506:	9201                	srli	a2,a2,0x20
 508:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 50c:	872a                	mv	a4,a0
      *dst++ = *src++;
 50e:	0585                	addi	a1,a1,1
 510:	0705                	addi	a4,a4,1
 512:	fff5c683          	lbu	a3,-1(a1)
 516:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 51a:	fee79ae3          	bne	a5,a4,50e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 51e:	6422                	ld	s0,8(sp)
 520:	0141                	addi	sp,sp,16
 522:	8082                	ret
    dst += n;
 524:	00c50733          	add	a4,a0,a2
    src += n;
 528:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 52a:	fec05ae3          	blez	a2,51e <memmove+0x28>
 52e:	fff6079b          	addiw	a5,a2,-1
 532:	1782                	slli	a5,a5,0x20
 534:	9381                	srli	a5,a5,0x20
 536:	fff7c793          	not	a5,a5
 53a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 53c:	15fd                	addi	a1,a1,-1
 53e:	177d                	addi	a4,a4,-1
 540:	0005c683          	lbu	a3,0(a1)
 544:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 548:	fee79ae3          	bne	a5,a4,53c <memmove+0x46>
 54c:	bfc9                	j	51e <memmove+0x28>

000000000000054e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 54e:	1141                	addi	sp,sp,-16
 550:	e422                	sd	s0,8(sp)
 552:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 554:	ca05                	beqz	a2,584 <memcmp+0x36>
 556:	fff6069b          	addiw	a3,a2,-1
 55a:	1682                	slli	a3,a3,0x20
 55c:	9281                	srli	a3,a3,0x20
 55e:	0685                	addi	a3,a3,1
 560:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 562:	00054783          	lbu	a5,0(a0)
 566:	0005c703          	lbu	a4,0(a1)
 56a:	00e79863          	bne	a5,a4,57a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 56e:	0505                	addi	a0,a0,1
    p2++;
 570:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 572:	fed518e3          	bne	a0,a3,562 <memcmp+0x14>
  }
  return 0;
 576:	4501                	li	a0,0
 578:	a019                	j	57e <memcmp+0x30>
      return *p1 - *p2;
 57a:	40e7853b          	subw	a0,a5,a4
}
 57e:	6422                	ld	s0,8(sp)
 580:	0141                	addi	sp,sp,16
 582:	8082                	ret
  return 0;
 584:	4501                	li	a0,0
 586:	bfe5                	j	57e <memcmp+0x30>

0000000000000588 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 588:	1141                	addi	sp,sp,-16
 58a:	e406                	sd	ra,8(sp)
 58c:	e022                	sd	s0,0(sp)
 58e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 590:	00000097          	auipc	ra,0x0
 594:	f66080e7          	jalr	-154(ra) # 4f6 <memmove>
}
 598:	60a2                	ld	ra,8(sp)
 59a:	6402                	ld	s0,0(sp)
 59c:	0141                	addi	sp,sp,16
 59e:	8082                	ret

00000000000005a0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5a0:	4885                	li	a7,1
 ecall
 5a2:	00000073          	ecall
 ret
 5a6:	8082                	ret

00000000000005a8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5a8:	4889                	li	a7,2
 ecall
 5aa:	00000073          	ecall
 ret
 5ae:	8082                	ret

00000000000005b0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5b0:	488d                	li	a7,3
 ecall
 5b2:	00000073          	ecall
 ret
 5b6:	8082                	ret

00000000000005b8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5b8:	4891                	li	a7,4
 ecall
 5ba:	00000073          	ecall
 ret
 5be:	8082                	ret

00000000000005c0 <read>:
.global read
read:
 li a7, SYS_read
 5c0:	4895                	li	a7,5
 ecall
 5c2:	00000073          	ecall
 ret
 5c6:	8082                	ret

00000000000005c8 <write>:
.global write
write:
 li a7, SYS_write
 5c8:	48c1                	li	a7,16
 ecall
 5ca:	00000073          	ecall
 ret
 5ce:	8082                	ret

00000000000005d0 <close>:
.global close
close:
 li a7, SYS_close
 5d0:	48d5                	li	a7,21
 ecall
 5d2:	00000073          	ecall
 ret
 5d6:	8082                	ret

00000000000005d8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5d8:	4899                	li	a7,6
 ecall
 5da:	00000073          	ecall
 ret
 5de:	8082                	ret

00000000000005e0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 5e0:	489d                	li	a7,7
 ecall
 5e2:	00000073          	ecall
 ret
 5e6:	8082                	ret

00000000000005e8 <open>:
.global open
open:
 li a7, SYS_open
 5e8:	48bd                	li	a7,15
 ecall
 5ea:	00000073          	ecall
 ret
 5ee:	8082                	ret

00000000000005f0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5f0:	48c5                	li	a7,17
 ecall
 5f2:	00000073          	ecall
 ret
 5f6:	8082                	ret

00000000000005f8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 5f8:	48c9                	li	a7,18
 ecall
 5fa:	00000073          	ecall
 ret
 5fe:	8082                	ret

0000000000000600 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 600:	48a1                	li	a7,8
 ecall
 602:	00000073          	ecall
 ret
 606:	8082                	ret

0000000000000608 <link>:
.global link
link:
 li a7, SYS_link
 608:	48cd                	li	a7,19
 ecall
 60a:	00000073          	ecall
 ret
 60e:	8082                	ret

0000000000000610 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 610:	48d1                	li	a7,20
 ecall
 612:	00000073          	ecall
 ret
 616:	8082                	ret

0000000000000618 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 618:	48a5                	li	a7,9
 ecall
 61a:	00000073          	ecall
 ret
 61e:	8082                	ret

0000000000000620 <dup>:
.global dup
dup:
 li a7, SYS_dup
 620:	48a9                	li	a7,10
 ecall
 622:	00000073          	ecall
 ret
 626:	8082                	ret

0000000000000628 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 628:	48ad                	li	a7,11
 ecall
 62a:	00000073          	ecall
 ret
 62e:	8082                	ret

0000000000000630 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 630:	48b1                	li	a7,12
 ecall
 632:	00000073          	ecall
 ret
 636:	8082                	ret

0000000000000638 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 638:	48b5                	li	a7,13
 ecall
 63a:	00000073          	ecall
 ret
 63e:	8082                	ret

0000000000000640 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 640:	48b9                	li	a7,14
 ecall
 642:	00000073          	ecall
 ret
 646:	8082                	ret

0000000000000648 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 648:	48d9                	li	a7,22
 ecall
 64a:	00000073          	ecall
 ret
 64e:	8082                	ret

0000000000000650 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 650:	1101                	addi	sp,sp,-32
 652:	ec06                	sd	ra,24(sp)
 654:	e822                	sd	s0,16(sp)
 656:	1000                	addi	s0,sp,32
 658:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 65c:	4605                	li	a2,1
 65e:	fef40593          	addi	a1,s0,-17
 662:	00000097          	auipc	ra,0x0
 666:	f66080e7          	jalr	-154(ra) # 5c8 <write>
}
 66a:	60e2                	ld	ra,24(sp)
 66c:	6442                	ld	s0,16(sp)
 66e:	6105                	addi	sp,sp,32
 670:	8082                	ret

0000000000000672 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 672:	7139                	addi	sp,sp,-64
 674:	fc06                	sd	ra,56(sp)
 676:	f822                	sd	s0,48(sp)
 678:	f426                	sd	s1,40(sp)
 67a:	f04a                	sd	s2,32(sp)
 67c:	ec4e                	sd	s3,24(sp)
 67e:	0080                	addi	s0,sp,64
 680:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 682:	c299                	beqz	a3,688 <printint+0x16>
 684:	0805c863          	bltz	a1,714 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 688:	2581                	sext.w	a1,a1
  neg = 0;
 68a:	4881                	li	a7,0
 68c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 690:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 692:	2601                	sext.w	a2,a2
 694:	00000517          	auipc	a0,0x0
 698:	4bc50513          	addi	a0,a0,1212 # b50 <digits>
 69c:	883a                	mv	a6,a4
 69e:	2705                	addiw	a4,a4,1
 6a0:	02c5f7bb          	remuw	a5,a1,a2
 6a4:	1782                	slli	a5,a5,0x20
 6a6:	9381                	srli	a5,a5,0x20
 6a8:	97aa                	add	a5,a5,a0
 6aa:	0007c783          	lbu	a5,0(a5)
 6ae:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6b2:	0005879b          	sext.w	a5,a1
 6b6:	02c5d5bb          	divuw	a1,a1,a2
 6ba:	0685                	addi	a3,a3,1
 6bc:	fec7f0e3          	bgeu	a5,a2,69c <printint+0x2a>
  if(neg)
 6c0:	00088b63          	beqz	a7,6d6 <printint+0x64>
    buf[i++] = '-';
 6c4:	fd040793          	addi	a5,s0,-48
 6c8:	973e                	add	a4,a4,a5
 6ca:	02d00793          	li	a5,45
 6ce:	fef70823          	sb	a5,-16(a4)
 6d2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6d6:	02e05863          	blez	a4,706 <printint+0x94>
 6da:	fc040793          	addi	a5,s0,-64
 6de:	00e78933          	add	s2,a5,a4
 6e2:	fff78993          	addi	s3,a5,-1
 6e6:	99ba                	add	s3,s3,a4
 6e8:	377d                	addiw	a4,a4,-1
 6ea:	1702                	slli	a4,a4,0x20
 6ec:	9301                	srli	a4,a4,0x20
 6ee:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 6f2:	fff94583          	lbu	a1,-1(s2)
 6f6:	8526                	mv	a0,s1
 6f8:	00000097          	auipc	ra,0x0
 6fc:	f58080e7          	jalr	-168(ra) # 650 <putc>
  while(--i >= 0)
 700:	197d                	addi	s2,s2,-1
 702:	ff3918e3          	bne	s2,s3,6f2 <printint+0x80>
}
 706:	70e2                	ld	ra,56(sp)
 708:	7442                	ld	s0,48(sp)
 70a:	74a2                	ld	s1,40(sp)
 70c:	7902                	ld	s2,32(sp)
 70e:	69e2                	ld	s3,24(sp)
 710:	6121                	addi	sp,sp,64
 712:	8082                	ret
    x = -xx;
 714:	40b005bb          	negw	a1,a1
    neg = 1;
 718:	4885                	li	a7,1
    x = -xx;
 71a:	bf8d                	j	68c <printint+0x1a>

000000000000071c <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 71c:	7119                	addi	sp,sp,-128
 71e:	fc86                	sd	ra,120(sp)
 720:	f8a2                	sd	s0,112(sp)
 722:	f4a6                	sd	s1,104(sp)
 724:	f0ca                	sd	s2,96(sp)
 726:	ecce                	sd	s3,88(sp)
 728:	e8d2                	sd	s4,80(sp)
 72a:	e4d6                	sd	s5,72(sp)
 72c:	e0da                	sd	s6,64(sp)
 72e:	fc5e                	sd	s7,56(sp)
 730:	f862                	sd	s8,48(sp)
 732:	f466                	sd	s9,40(sp)
 734:	f06a                	sd	s10,32(sp)
 736:	ec6e                	sd	s11,24(sp)
 738:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 73a:	0005c903          	lbu	s2,0(a1)
 73e:	18090f63          	beqz	s2,8dc <vprintf+0x1c0>
 742:	8aaa                	mv	s5,a0
 744:	8b32                	mv	s6,a2
 746:	00158493          	addi	s1,a1,1
  state = 0;
 74a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 74c:	02500a13          	li	s4,37
      if(c == 'd'){
 750:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 754:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 758:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 75c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 760:	00000b97          	auipc	s7,0x0
 764:	3f0b8b93          	addi	s7,s7,1008 # b50 <digits>
 768:	a839                	j	786 <vprintf+0x6a>
        putc(fd, c);
 76a:	85ca                	mv	a1,s2
 76c:	8556                	mv	a0,s5
 76e:	00000097          	auipc	ra,0x0
 772:	ee2080e7          	jalr	-286(ra) # 650 <putc>
 776:	a019                	j	77c <vprintf+0x60>
    } else if(state == '%'){
 778:	01498f63          	beq	s3,s4,796 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 77c:	0485                	addi	s1,s1,1
 77e:	fff4c903          	lbu	s2,-1(s1)
 782:	14090d63          	beqz	s2,8dc <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 786:	0009079b          	sext.w	a5,s2
    if(state == 0){
 78a:	fe0997e3          	bnez	s3,778 <vprintf+0x5c>
      if(c == '%'){
 78e:	fd479ee3          	bne	a5,s4,76a <vprintf+0x4e>
        state = '%';
 792:	89be                	mv	s3,a5
 794:	b7e5                	j	77c <vprintf+0x60>
      if(c == 'd'){
 796:	05878063          	beq	a5,s8,7d6 <vprintf+0xba>
      } else if(c == 'l') {
 79a:	05978c63          	beq	a5,s9,7f2 <vprintf+0xd6>
      } else if(c == 'x') {
 79e:	07a78863          	beq	a5,s10,80e <vprintf+0xf2>
      } else if(c == 'p') {
 7a2:	09b78463          	beq	a5,s11,82a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7a6:	07300713          	li	a4,115
 7aa:	0ce78663          	beq	a5,a4,876 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ae:	06300713          	li	a4,99
 7b2:	0ee78e63          	beq	a5,a4,8ae <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7b6:	11478863          	beq	a5,s4,8c6 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7ba:	85d2                	mv	a1,s4
 7bc:	8556                	mv	a0,s5
 7be:	00000097          	auipc	ra,0x0
 7c2:	e92080e7          	jalr	-366(ra) # 650 <putc>
        putc(fd, c);
 7c6:	85ca                	mv	a1,s2
 7c8:	8556                	mv	a0,s5
 7ca:	00000097          	auipc	ra,0x0
 7ce:	e86080e7          	jalr	-378(ra) # 650 <putc>
      }
      state = 0;
 7d2:	4981                	li	s3,0
 7d4:	b765                	j	77c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7d6:	008b0913          	addi	s2,s6,8
 7da:	4685                	li	a3,1
 7dc:	4629                	li	a2,10
 7de:	000b2583          	lw	a1,0(s6)
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	e8e080e7          	jalr	-370(ra) # 672 <printint>
 7ec:	8b4a                	mv	s6,s2
      state = 0;
 7ee:	4981                	li	s3,0
 7f0:	b771                	j	77c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7f2:	008b0913          	addi	s2,s6,8
 7f6:	4681                	li	a3,0
 7f8:	4629                	li	a2,10
 7fa:	000b2583          	lw	a1,0(s6)
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	e72080e7          	jalr	-398(ra) # 672 <printint>
 808:	8b4a                	mv	s6,s2
      state = 0;
 80a:	4981                	li	s3,0
 80c:	bf85                	j	77c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 80e:	008b0913          	addi	s2,s6,8
 812:	4681                	li	a3,0
 814:	4641                	li	a2,16
 816:	000b2583          	lw	a1,0(s6)
 81a:	8556                	mv	a0,s5
 81c:	00000097          	auipc	ra,0x0
 820:	e56080e7          	jalr	-426(ra) # 672 <printint>
 824:	8b4a                	mv	s6,s2
      state = 0;
 826:	4981                	li	s3,0
 828:	bf91                	j	77c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 82a:	008b0793          	addi	a5,s6,8
 82e:	f8f43423          	sd	a5,-120(s0)
 832:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 836:	03000593          	li	a1,48
 83a:	8556                	mv	a0,s5
 83c:	00000097          	auipc	ra,0x0
 840:	e14080e7          	jalr	-492(ra) # 650 <putc>
  putc(fd, 'x');
 844:	85ea                	mv	a1,s10
 846:	8556                	mv	a0,s5
 848:	00000097          	auipc	ra,0x0
 84c:	e08080e7          	jalr	-504(ra) # 650 <putc>
 850:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 852:	03c9d793          	srli	a5,s3,0x3c
 856:	97de                	add	a5,a5,s7
 858:	0007c583          	lbu	a1,0(a5)
 85c:	8556                	mv	a0,s5
 85e:	00000097          	auipc	ra,0x0
 862:	df2080e7          	jalr	-526(ra) # 650 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 866:	0992                	slli	s3,s3,0x4
 868:	397d                	addiw	s2,s2,-1
 86a:	fe0914e3          	bnez	s2,852 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 86e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 872:	4981                	li	s3,0
 874:	b721                	j	77c <vprintf+0x60>
        s = va_arg(ap, char*);
 876:	008b0993          	addi	s3,s6,8
 87a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 87e:	02090163          	beqz	s2,8a0 <vprintf+0x184>
        while(*s != 0){
 882:	00094583          	lbu	a1,0(s2)
 886:	c9a1                	beqz	a1,8d6 <vprintf+0x1ba>
          putc(fd, *s);
 888:	8556                	mv	a0,s5
 88a:	00000097          	auipc	ra,0x0
 88e:	dc6080e7          	jalr	-570(ra) # 650 <putc>
          s++;
 892:	0905                	addi	s2,s2,1
        while(*s != 0){
 894:	00094583          	lbu	a1,0(s2)
 898:	f9e5                	bnez	a1,888 <vprintf+0x16c>
        s = va_arg(ap, char*);
 89a:	8b4e                	mv	s6,s3
      state = 0;
 89c:	4981                	li	s3,0
 89e:	bdf9                	j	77c <vprintf+0x60>
          s = "(null)";
 8a0:	00000917          	auipc	s2,0x0
 8a4:	2a890913          	addi	s2,s2,680 # b48 <malloc+0x162>
        while(*s != 0){
 8a8:	02800593          	li	a1,40
 8ac:	bff1                	j	888 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8ae:	008b0913          	addi	s2,s6,8
 8b2:	000b4583          	lbu	a1,0(s6)
 8b6:	8556                	mv	a0,s5
 8b8:	00000097          	auipc	ra,0x0
 8bc:	d98080e7          	jalr	-616(ra) # 650 <putc>
 8c0:	8b4a                	mv	s6,s2
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bd65                	j	77c <vprintf+0x60>
        putc(fd, c);
 8c6:	85d2                	mv	a1,s4
 8c8:	8556                	mv	a0,s5
 8ca:	00000097          	auipc	ra,0x0
 8ce:	d86080e7          	jalr	-634(ra) # 650 <putc>
      state = 0;
 8d2:	4981                	li	s3,0
 8d4:	b565                	j	77c <vprintf+0x60>
        s = va_arg(ap, char*);
 8d6:	8b4e                	mv	s6,s3
      state = 0;
 8d8:	4981                	li	s3,0
 8da:	b54d                	j	77c <vprintf+0x60>
    }
  }
}
 8dc:	70e6                	ld	ra,120(sp)
 8de:	7446                	ld	s0,112(sp)
 8e0:	74a6                	ld	s1,104(sp)
 8e2:	7906                	ld	s2,96(sp)
 8e4:	69e6                	ld	s3,88(sp)
 8e6:	6a46                	ld	s4,80(sp)
 8e8:	6aa6                	ld	s5,72(sp)
 8ea:	6b06                	ld	s6,64(sp)
 8ec:	7be2                	ld	s7,56(sp)
 8ee:	7c42                	ld	s8,48(sp)
 8f0:	7ca2                	ld	s9,40(sp)
 8f2:	7d02                	ld	s10,32(sp)
 8f4:	6de2                	ld	s11,24(sp)
 8f6:	6109                	addi	sp,sp,128
 8f8:	8082                	ret

00000000000008fa <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8fa:	715d                	addi	sp,sp,-80
 8fc:	ec06                	sd	ra,24(sp)
 8fe:	e822                	sd	s0,16(sp)
 900:	1000                	addi	s0,sp,32
 902:	e010                	sd	a2,0(s0)
 904:	e414                	sd	a3,8(s0)
 906:	e818                	sd	a4,16(s0)
 908:	ec1c                	sd	a5,24(s0)
 90a:	03043023          	sd	a6,32(s0)
 90e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 912:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 916:	8622                	mv	a2,s0
 918:	00000097          	auipc	ra,0x0
 91c:	e04080e7          	jalr	-508(ra) # 71c <vprintf>
}
 920:	60e2                	ld	ra,24(sp)
 922:	6442                	ld	s0,16(sp)
 924:	6161                	addi	sp,sp,80
 926:	8082                	ret

0000000000000928 <printf>:

void
printf(const char *fmt, ...)
{
 928:	711d                	addi	sp,sp,-96
 92a:	ec06                	sd	ra,24(sp)
 92c:	e822                	sd	s0,16(sp)
 92e:	1000                	addi	s0,sp,32
 930:	e40c                	sd	a1,8(s0)
 932:	e810                	sd	a2,16(s0)
 934:	ec14                	sd	a3,24(s0)
 936:	f018                	sd	a4,32(s0)
 938:	f41c                	sd	a5,40(s0)
 93a:	03043823          	sd	a6,48(s0)
 93e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 942:	00840613          	addi	a2,s0,8
 946:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 94a:	85aa                	mv	a1,a0
 94c:	4505                	li	a0,1
 94e:	00000097          	auipc	ra,0x0
 952:	dce080e7          	jalr	-562(ra) # 71c <vprintf>
}
 956:	60e2                	ld	ra,24(sp)
 958:	6442                	ld	s0,16(sp)
 95a:	6125                	addi	sp,sp,96
 95c:	8082                	ret

000000000000095e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 95e:	1141                	addi	sp,sp,-16
 960:	e422                	sd	s0,8(sp)
 962:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 964:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 968:	00000797          	auipc	a5,0x0
 96c:	2187b783          	ld	a5,536(a5) # b80 <freep>
 970:	a805                	j	9a0 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 972:	4618                	lw	a4,8(a2)
 974:	9db9                	addw	a1,a1,a4
 976:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 97a:	6398                	ld	a4,0(a5)
 97c:	6318                	ld	a4,0(a4)
 97e:	fee53823          	sd	a4,-16(a0)
 982:	a091                	j	9c6 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 984:	ff852703          	lw	a4,-8(a0)
 988:	9e39                	addw	a2,a2,a4
 98a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 98c:	ff053703          	ld	a4,-16(a0)
 990:	e398                	sd	a4,0(a5)
 992:	a099                	j	9d8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 994:	6398                	ld	a4,0(a5)
 996:	00e7e463          	bltu	a5,a4,99e <free+0x40>
 99a:	00e6ea63          	bltu	a3,a4,9ae <free+0x50>
{
 99e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a0:	fed7fae3          	bgeu	a5,a3,994 <free+0x36>
 9a4:	6398                	ld	a4,0(a5)
 9a6:	00e6e463          	bltu	a3,a4,9ae <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9aa:	fee7eae3          	bltu	a5,a4,99e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9ae:	ff852583          	lw	a1,-8(a0)
 9b2:	6390                	ld	a2,0(a5)
 9b4:	02059813          	slli	a6,a1,0x20
 9b8:	01c85713          	srli	a4,a6,0x1c
 9bc:	9736                	add	a4,a4,a3
 9be:	fae60ae3          	beq	a2,a4,972 <free+0x14>
    bp->s.ptr = p->s.ptr;
 9c2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9c6:	4790                	lw	a2,8(a5)
 9c8:	02061593          	slli	a1,a2,0x20
 9cc:	01c5d713          	srli	a4,a1,0x1c
 9d0:	973e                	add	a4,a4,a5
 9d2:	fae689e3          	beq	a3,a4,984 <free+0x26>
  } else
    p->s.ptr = bp;
 9d6:	e394                	sd	a3,0(a5)
  freep = p;
 9d8:	00000717          	auipc	a4,0x0
 9dc:	1af73423          	sd	a5,424(a4) # b80 <freep>
}
 9e0:	6422                	ld	s0,8(sp)
 9e2:	0141                	addi	sp,sp,16
 9e4:	8082                	ret

00000000000009e6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9e6:	7139                	addi	sp,sp,-64
 9e8:	fc06                	sd	ra,56(sp)
 9ea:	f822                	sd	s0,48(sp)
 9ec:	f426                	sd	s1,40(sp)
 9ee:	f04a                	sd	s2,32(sp)
 9f0:	ec4e                	sd	s3,24(sp)
 9f2:	e852                	sd	s4,16(sp)
 9f4:	e456                	sd	s5,8(sp)
 9f6:	e05a                	sd	s6,0(sp)
 9f8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9fa:	02051493          	slli	s1,a0,0x20
 9fe:	9081                	srli	s1,s1,0x20
 a00:	04bd                	addi	s1,s1,15
 a02:	8091                	srli	s1,s1,0x4
 a04:	0014899b          	addiw	s3,s1,1
 a08:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a0a:	00000517          	auipc	a0,0x0
 a0e:	17653503          	ld	a0,374(a0) # b80 <freep>
 a12:	c515                	beqz	a0,a3e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a14:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a16:	4798                	lw	a4,8(a5)
 a18:	02977f63          	bgeu	a4,s1,a56 <malloc+0x70>
 a1c:	8a4e                	mv	s4,s3
 a1e:	0009871b          	sext.w	a4,s3
 a22:	6685                	lui	a3,0x1
 a24:	00d77363          	bgeu	a4,a3,a2a <malloc+0x44>
 a28:	6a05                	lui	s4,0x1
 a2a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a2e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a32:	00000917          	auipc	s2,0x0
 a36:	14e90913          	addi	s2,s2,334 # b80 <freep>
  if(p == (char*)-1)
 a3a:	5afd                	li	s5,-1
 a3c:	a895                	j	ab0 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a3e:	00000797          	auipc	a5,0x0
 a42:	23a78793          	addi	a5,a5,570 # c78 <base>
 a46:	00000717          	auipc	a4,0x0
 a4a:	12f73d23          	sd	a5,314(a4) # b80 <freep>
 a4e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a50:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a54:	b7e1                	j	a1c <malloc+0x36>
      if(p->s.size == nunits)
 a56:	02e48c63          	beq	s1,a4,a8e <malloc+0xa8>
        p->s.size -= nunits;
 a5a:	4137073b          	subw	a4,a4,s3
 a5e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a60:	02071693          	slli	a3,a4,0x20
 a64:	01c6d713          	srli	a4,a3,0x1c
 a68:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a6a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a6e:	00000717          	auipc	a4,0x0
 a72:	10a73923          	sd	a0,274(a4) # b80 <freep>
      return (void*)(p + 1);
 a76:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a7a:	70e2                	ld	ra,56(sp)
 a7c:	7442                	ld	s0,48(sp)
 a7e:	74a2                	ld	s1,40(sp)
 a80:	7902                	ld	s2,32(sp)
 a82:	69e2                	ld	s3,24(sp)
 a84:	6a42                	ld	s4,16(sp)
 a86:	6aa2                	ld	s5,8(sp)
 a88:	6b02                	ld	s6,0(sp)
 a8a:	6121                	addi	sp,sp,64
 a8c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a8e:	6398                	ld	a4,0(a5)
 a90:	e118                	sd	a4,0(a0)
 a92:	bff1                	j	a6e <malloc+0x88>
  hp->s.size = nu;
 a94:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a98:	0541                	addi	a0,a0,16
 a9a:	00000097          	auipc	ra,0x0
 a9e:	ec4080e7          	jalr	-316(ra) # 95e <free>
  return freep;
 aa2:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 aa6:	d971                	beqz	a0,a7a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 aaa:	4798                	lw	a4,8(a5)
 aac:	fa9775e3          	bgeu	a4,s1,a56 <malloc+0x70>
    if(p == freep)
 ab0:	00093703          	ld	a4,0(s2)
 ab4:	853e                	mv	a0,a5
 ab6:	fef719e3          	bne	a4,a5,aa8 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 aba:	8552                	mv	a0,s4
 abc:	00000097          	auipc	ra,0x0
 ac0:	b74080e7          	jalr	-1164(ra) # 630 <sbrk>
  if(p == (char*)-1)
 ac4:	fd5518e3          	bne	a0,s5,a94 <malloc+0xae>
        return 0;
 ac8:	4501                	li	a0,0
 aca:	bf45                	j	a7a <malloc+0x94>
