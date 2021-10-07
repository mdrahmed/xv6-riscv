
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	7119                	addi	sp,sp,-128
   2:	fc86                	sd	ra,120(sp)
   4:	f8a2                	sd	s0,112(sp)
   6:	f4a6                	sd	s1,104(sp)
   8:	f0ca                	sd	s2,96(sp)
   a:	ecce                	sd	s3,88(sp)
   c:	e8d2                	sd	s4,80(sp)
   e:	e4d6                	sd	s5,72(sp)
  10:	e0da                	sd	s6,64(sp)
  12:	fc5e                	sd	s7,56(sp)
  14:	f862                	sd	s8,48(sp)
  16:	f466                	sd	s9,40(sp)
  18:	f06a                	sd	s10,32(sp)
  1a:	ec6e                	sd	s11,24(sp)
  1c:	0100                	addi	s0,sp,128
  1e:	f8a43423          	sd	a0,-120(s0)
  22:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  26:	4981                	li	s3,0
  l = w = c = 0;
  28:	4c81                	li	s9,0
  2a:	4c01                	li	s8,0
  2c:	4b81                	li	s7,0
  2e:	00001d97          	auipc	s11,0x1
  32:	b9bd8d93          	addi	s11,s11,-1125 # bc9 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	b20a0a13          	addi	s4,s4,-1248 # b58 <malloc+0xec>
        inword = 0;
  40:	4b01                	li	s6,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	40e080e7          	jalr	1038(ra) # 454 <strchr>
  4e:	c919                	beqz	a0,64 <wc+0x64>
        inword = 0;
  50:	89da                	mv	s3,s6
    for(i=0; i<n; i++){
  52:	0485                	addi	s1,s1,1
  54:	01248d63          	beq	s1,s2,6e <wc+0x6e>
      if(buf[i] == '\n')
  58:	0004c583          	lbu	a1,0(s1)
  5c:	ff5594e3          	bne	a1,s5,44 <wc+0x44>
        l++;
  60:	2b85                	addiw	s7,s7,1
  62:	b7cd                	j	44 <wc+0x44>
      else if(!inword){
  64:	fe0997e3          	bnez	s3,52 <wc+0x52>
        w++;
  68:	2c05                	addiw	s8,s8,1
        inword = 1;
  6a:	4985                	li	s3,1
  6c:	b7dd                	j	52 <wc+0x52>
      c++;
  6e:	01ac8cbb          	addw	s9,s9,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
  72:	20000613          	li	a2,512
  76:	00001597          	auipc	a1,0x1
  7a:	b5258593          	addi	a1,a1,-1198 # bc8 <buf>
  7e:	f8843503          	ld	a0,-120(s0)
  82:	00000097          	auipc	ra,0x0
  86:	5c4080e7          	jalr	1476(ra) # 646 <read>
  8a:	00a05f63          	blez	a0,a8 <wc+0xa8>
    for(i=0; i<n; i++){
  8e:	00001497          	auipc	s1,0x1
  92:	b3a48493          	addi	s1,s1,-1222 # bc8 <buf>
  96:	00050d1b          	sext.w	s10,a0
  9a:	fff5091b          	addiw	s2,a0,-1
  9e:	1902                	slli	s2,s2,0x20
  a0:	02095913          	srli	s2,s2,0x20
  a4:	996e                	add	s2,s2,s11
  a6:	bf4d                	j	58 <wc+0x58>
      }
    }
  }
  if(n < 0){
  a8:	02054e63          	bltz	a0,e4 <wc+0xe4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
  ac:	f8043703          	ld	a4,-128(s0)
  b0:	86e6                	mv	a3,s9
  b2:	8662                	mv	a2,s8
  b4:	85de                	mv	a1,s7
  b6:	00001517          	auipc	a0,0x1
  ba:	aba50513          	addi	a0,a0,-1350 # b70 <malloc+0x104>
  be:	00001097          	auipc	ra,0x1
  c2:	8f0080e7          	jalr	-1808(ra) # 9ae <printf>
}
  c6:	70e6                	ld	ra,120(sp)
  c8:	7446                	ld	s0,112(sp)
  ca:	74a6                	ld	s1,104(sp)
  cc:	7906                	ld	s2,96(sp)
  ce:	69e6                	ld	s3,88(sp)
  d0:	6a46                	ld	s4,80(sp)
  d2:	6aa6                	ld	s5,72(sp)
  d4:	6b06                	ld	s6,64(sp)
  d6:	7be2                	ld	s7,56(sp)
  d8:	7c42                	ld	s8,48(sp)
  da:	7ca2                	ld	s9,40(sp)
  dc:	7d02                	ld	s10,32(sp)
  de:	6de2                	ld	s11,24(sp)
  e0:	6109                	addi	sp,sp,128
  e2:	8082                	ret
    printf("wc: read error\n");
  e4:	00001517          	auipc	a0,0x1
  e8:	a7c50513          	addi	a0,a0,-1412 # b60 <malloc+0xf4>
  ec:	00001097          	auipc	ra,0x1
  f0:	8c2080e7          	jalr	-1854(ra) # 9ae <printf>
    exit(1);
  f4:	4505                	li	a0,1
  f6:	00000097          	auipc	ra,0x0
  fa:	538080e7          	jalr	1336(ra) # 62e <exit>

00000000000000fe <main>:

int
main(int argc, char *argv[])
{
  fe:	7179                	addi	sp,sp,-48
 100:	f406                	sd	ra,40(sp)
 102:	f022                	sd	s0,32(sp)
 104:	ec26                	sd	s1,24(sp)
 106:	e84a                	sd	s2,16(sp)
 108:	e44e                	sd	s3,8(sp)
 10a:	e052                	sd	s4,0(sp)
 10c:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
 10e:	4785                	li	a5,1
 110:	04a7d763          	bge	a5,a0,15e <main+0x60>
 114:	00858493          	addi	s1,a1,8
 118:	ffe5099b          	addiw	s3,a0,-2
 11c:	02099793          	slli	a5,s3,0x20
 120:	01d7d993          	srli	s3,a5,0x1d
 124:	05c1                	addi	a1,a1,16
 126:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
 128:	4581                	li	a1,0
 12a:	6088                	ld	a0,0(s1)
 12c:	00000097          	auipc	ra,0x0
 130:	542080e7          	jalr	1346(ra) # 66e <open>
 134:	892a                	mv	s2,a0
 136:	04054263          	bltz	a0,17a <main+0x7c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
 13a:	608c                	ld	a1,0(s1)
 13c:	00000097          	auipc	ra,0x0
 140:	ec4080e7          	jalr	-316(ra) # 0 <wc>
    close(fd);
 144:	854a                	mv	a0,s2
 146:	00000097          	auipc	ra,0x0
 14a:	510080e7          	jalr	1296(ra) # 656 <close>
  for(i = 1; i < argc; i++){
 14e:	04a1                	addi	s1,s1,8
 150:	fd349ce3          	bne	s1,s3,128 <main+0x2a>
  }
  exit(0);
 154:	4501                	li	a0,0
 156:	00000097          	auipc	ra,0x0
 15a:	4d8080e7          	jalr	1240(ra) # 62e <exit>
    wc(0, "");
 15e:	00001597          	auipc	a1,0x1
 162:	a2258593          	addi	a1,a1,-1502 # b80 <malloc+0x114>
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	e98080e7          	jalr	-360(ra) # 0 <wc>
    exit(0);
 170:	4501                	li	a0,0
 172:	00000097          	auipc	ra,0x0
 176:	4bc080e7          	jalr	1212(ra) # 62e <exit>
      printf("wc: cannot open %s\n", argv[i]);
 17a:	608c                	ld	a1,0(s1)
 17c:	00001517          	auipc	a0,0x1
 180:	a0c50513          	addi	a0,a0,-1524 # b88 <malloc+0x11c>
 184:	00001097          	auipc	ra,0x1
 188:	82a080e7          	jalr	-2006(ra) # 9ae <printf>
      exit(1);
 18c:	4505                	li	a0,1
 18e:	00000097          	auipc	ra,0x0
 192:	4a0080e7          	jalr	1184(ra) # 62e <exit>

0000000000000196 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 196:	1141                	addi	sp,sp,-16
 198:	e422                	sd	s0,8(sp)
 19a:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 19c:	0f50000f          	fence	iorw,ow
 1a0:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 1a4:	6422                	ld	s0,8(sp)
 1a6:	0141                	addi	sp,sp,16
 1a8:	8082                	ret

00000000000001aa <load>:

int load(uint64 *p) {
 1aa:	1141                	addi	sp,sp,-16
 1ac:	e422                	sd	s0,8(sp)
 1ae:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 1b0:	0ff0000f          	fence
 1b4:	6108                	ld	a0,0(a0)
 1b6:	0ff0000f          	fence
}
 1ba:	2501                	sext.w	a0,a0
 1bc:	6422                	ld	s0,8(sp)
 1be:	0141                	addi	sp,sp,16
 1c0:	8082                	ret

00000000000001c2 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 1c2:	7179                	addi	sp,sp,-48
 1c4:	f406                	sd	ra,40(sp)
 1c6:	f022                	sd	s0,32(sp)
 1c8:	ec26                	sd	s1,24(sp)
 1ca:	e84a                	sd	s2,16(sp)
 1cc:	e44e                	sd	s3,8(sp)
 1ce:	e052                	sd	s4,0(sp)
 1d0:	1800                	addi	s0,sp,48
 1d2:	8a2a                	mv	s4,a0
 1d4:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 1d6:	4785                	li	a5,1
 1d8:	00001497          	auipc	s1,0x1
 1dc:	c0048493          	addi	s1,s1,-1024 # dd8 <rings+0x10>
 1e0:	00001917          	auipc	s2,0x1
 1e4:	ce890913          	addi	s2,s2,-792 # ec8 <__BSS_END__>
 1e8:	04f59563          	bne	a1,a5,232 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 1ec:	00001497          	auipc	s1,0x1
 1f0:	bec4a483          	lw	s1,-1044(s1) # dd8 <rings+0x10>
 1f4:	c099                	beqz	s1,1fa <create_or_close_the_buffer_user+0x38>
 1f6:	4481                	li	s1,0
 1f8:	a899                	j	24e <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 1fa:	00001917          	auipc	s2,0x1
 1fe:	bce90913          	addi	s2,s2,-1074 # dc8 <rings>
 202:	00093603          	ld	a2,0(s2)
 206:	4585                	li	a1,1
 208:	00000097          	auipc	ra,0x0
 20c:	4c6080e7          	jalr	1222(ra) # 6ce <ringbuf>
        rings[i].book->write_done = 0;
 210:	00893783          	ld	a5,8(s2)
 214:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 218:	00893783          	ld	a5,8(s2)
 21c:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 220:	01092783          	lw	a5,16(s2)
 224:	2785                	addiw	a5,a5,1
 226:	00f92823          	sw	a5,16(s2)
        break;
 22a:	a015                	j	24e <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 22c:	04e1                	addi	s1,s1,24
 22e:	01248f63          	beq	s1,s2,24c <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 232:	409c                	lw	a5,0(s1)
 234:	dfe5                	beqz	a5,22c <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 236:	ff04b603          	ld	a2,-16(s1)
 23a:	85ce                	mv	a1,s3
 23c:	8552                	mv	a0,s4
 23e:	00000097          	auipc	ra,0x0
 242:	490080e7          	jalr	1168(ra) # 6ce <ringbuf>
        rings[i].exists = 0;
 246:	0004a023          	sw	zero,0(s1)
 24a:	b7cd                	j	22c <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 24c:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 24e:	8526                	mv	a0,s1
 250:	70a2                	ld	ra,40(sp)
 252:	7402                	ld	s0,32(sp)
 254:	64e2                	ld	s1,24(sp)
 256:	6942                	ld	s2,16(sp)
 258:	69a2                	ld	s3,8(sp)
 25a:	6a02                	ld	s4,0(sp)
 25c:	6145                	addi	sp,sp,48
 25e:	8082                	ret

0000000000000260 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 260:	1101                	addi	sp,sp,-32
 262:	ec06                	sd	ra,24(sp)
 264:	e822                	sd	s0,16(sp)
 266:	e426                	sd	s1,8(sp)
 268:	1000                	addi	s0,sp,32
 26a:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 26c:	00151793          	slli	a5,a0,0x1
 270:	97aa                	add	a5,a5,a0
 272:	078e                	slli	a5,a5,0x3
 274:	00001717          	auipc	a4,0x1
 278:	b5470713          	addi	a4,a4,-1196 # dc8 <rings>
 27c:	97ba                	add	a5,a5,a4
 27e:	639c                	ld	a5,0(a5)
 280:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 282:	421c                	lw	a5,0(a2)
 284:	e785                	bnez	a5,2ac <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 286:	86ba                	mv	a3,a4
 288:	671c                	ld	a5,8(a4)
 28a:	6398                	ld	a4,0(a5)
 28c:	67c1                	lui	a5,0x10
 28e:	9fb9                	addw	a5,a5,a4
 290:	00151713          	slli	a4,a0,0x1
 294:	953a                	add	a0,a0,a4
 296:	050e                	slli	a0,a0,0x3
 298:	9536                	add	a0,a0,a3
 29a:	6518                	ld	a4,8(a0)
 29c:	6718                	ld	a4,8(a4)
 29e:	9f99                	subw	a5,a5,a4
 2a0:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 2a2:	60e2                	ld	ra,24(sp)
 2a4:	6442                	ld	s0,16(sp)
 2a6:	64a2                	ld	s1,8(sp)
 2a8:	6105                	addi	sp,sp,32
 2aa:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 2ac:	00151793          	slli	a5,a0,0x1
 2b0:	953e                	add	a0,a0,a5
 2b2:	050e                	slli	a0,a0,0x3
 2b4:	00001797          	auipc	a5,0x1
 2b8:	b1478793          	addi	a5,a5,-1260 # dc8 <rings>
 2bc:	953e                	add	a0,a0,a5
 2be:	6508                	ld	a0,8(a0)
 2c0:	0521                	addi	a0,a0,8
 2c2:	00000097          	auipc	ra,0x0
 2c6:	ee8080e7          	jalr	-280(ra) # 1aa <load>
 2ca:	c088                	sw	a0,0(s1)
}
 2cc:	bfd9                	j	2a2 <ringbuf_start_write+0x42>

00000000000002ce <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e406                	sd	ra,8(sp)
 2d2:	e022                	sd	s0,0(sp)
 2d4:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 2d6:	00151793          	slli	a5,a0,0x1
 2da:	97aa                	add	a5,a5,a0
 2dc:	078e                	slli	a5,a5,0x3
 2de:	00001517          	auipc	a0,0x1
 2e2:	aea50513          	addi	a0,a0,-1302 # dc8 <rings>
 2e6:	97aa                	add	a5,a5,a0
 2e8:	6788                	ld	a0,8(a5)
 2ea:	0035959b          	slliw	a1,a1,0x3
 2ee:	0521                	addi	a0,a0,8
 2f0:	00000097          	auipc	ra,0x0
 2f4:	ea6080e7          	jalr	-346(ra) # 196 <store>
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 300:	1101                	addi	sp,sp,-32
 302:	ec06                	sd	ra,24(sp)
 304:	e822                	sd	s0,16(sp)
 306:	e426                	sd	s1,8(sp)
 308:	1000                	addi	s0,sp,32
 30a:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 30c:	00151793          	slli	a5,a0,0x1
 310:	97aa                	add	a5,a5,a0
 312:	078e                	slli	a5,a5,0x3
 314:	00001517          	auipc	a0,0x1
 318:	ab450513          	addi	a0,a0,-1356 # dc8 <rings>
 31c:	97aa                	add	a5,a5,a0
 31e:	6788                	ld	a0,8(a5)
 320:	0521                	addi	a0,a0,8
 322:	00000097          	auipc	ra,0x0
 326:	e88080e7          	jalr	-376(ra) # 1aa <load>
 32a:	c088                	sw	a0,0(s1)
}
 32c:	60e2                	ld	ra,24(sp)
 32e:	6442                	ld	s0,16(sp)
 330:	64a2                	ld	s1,8(sp)
 332:	6105                	addi	sp,sp,32
 334:	8082                	ret

0000000000000336 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 336:	1101                	addi	sp,sp,-32
 338:	ec06                	sd	ra,24(sp)
 33a:	e822                	sd	s0,16(sp)
 33c:	e426                	sd	s1,8(sp)
 33e:	1000                	addi	s0,sp,32
 340:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 342:	00151793          	slli	a5,a0,0x1
 346:	97aa                	add	a5,a5,a0
 348:	078e                	slli	a5,a5,0x3
 34a:	00001517          	auipc	a0,0x1
 34e:	a7e50513          	addi	a0,a0,-1410 # dc8 <rings>
 352:	97aa                	add	a5,a5,a0
 354:	6788                	ld	a0,8(a5)
 356:	611c                	ld	a5,0(a0)
 358:	ef99                	bnez	a5,376 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 35a:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 35c:	41f7579b          	sraiw	a5,a4,0x1f
 360:	01d7d79b          	srliw	a5,a5,0x1d
 364:	9fb9                	addw	a5,a5,a4
 366:	4037d79b          	sraiw	a5,a5,0x3
 36a:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 36c:	60e2                	ld	ra,24(sp)
 36e:	6442                	ld	s0,16(sp)
 370:	64a2                	ld	s1,8(sp)
 372:	6105                	addi	sp,sp,32
 374:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 376:	00000097          	auipc	ra,0x0
 37a:	e34080e7          	jalr	-460(ra) # 1aa <load>
    *bytes /= 8;
 37e:	41f5579b          	sraiw	a5,a0,0x1f
 382:	01d7d79b          	srliw	a5,a5,0x1d
 386:	9d3d                	addw	a0,a0,a5
 388:	4035551b          	sraiw	a0,a0,0x3
 38c:	c088                	sw	a0,0(s1)
}
 38e:	bff9                	j	36c <ringbuf_start_read+0x36>

0000000000000390 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 390:	1141                	addi	sp,sp,-16
 392:	e406                	sd	ra,8(sp)
 394:	e022                	sd	s0,0(sp)
 396:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 398:	00151793          	slli	a5,a0,0x1
 39c:	97aa                	add	a5,a5,a0
 39e:	078e                	slli	a5,a5,0x3
 3a0:	00001517          	auipc	a0,0x1
 3a4:	a2850513          	addi	a0,a0,-1496 # dc8 <rings>
 3a8:	97aa                	add	a5,a5,a0
 3aa:	0035959b          	slliw	a1,a1,0x3
 3ae:	6788                	ld	a0,8(a5)
 3b0:	00000097          	auipc	ra,0x0
 3b4:	de6080e7          	jalr	-538(ra) # 196 <store>
}
 3b8:	60a2                	ld	ra,8(sp)
 3ba:	6402                	ld	s0,0(sp)
 3bc:	0141                	addi	sp,sp,16
 3be:	8082                	ret

00000000000003c0 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 3c0:	1141                	addi	sp,sp,-16
 3c2:	e422                	sd	s0,8(sp)
 3c4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3c6:	87aa                	mv	a5,a0
 3c8:	0585                	addi	a1,a1,1
 3ca:	0785                	addi	a5,a5,1
 3cc:	fff5c703          	lbu	a4,-1(a1)
 3d0:	fee78fa3          	sb	a4,-1(a5)
 3d4:	fb75                	bnez	a4,3c8 <strcpy+0x8>
    ;
  return os;
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret

00000000000003dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3dc:	1141                	addi	sp,sp,-16
 3de:	e422                	sd	s0,8(sp)
 3e0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3e2:	00054783          	lbu	a5,0(a0)
 3e6:	cb91                	beqz	a5,3fa <strcmp+0x1e>
 3e8:	0005c703          	lbu	a4,0(a1)
 3ec:	00f71763          	bne	a4,a5,3fa <strcmp+0x1e>
    p++, q++;
 3f0:	0505                	addi	a0,a0,1
 3f2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 3f4:	00054783          	lbu	a5,0(a0)
 3f8:	fbe5                	bnez	a5,3e8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 3fa:	0005c503          	lbu	a0,0(a1)
}
 3fe:	40a7853b          	subw	a0,a5,a0
 402:	6422                	ld	s0,8(sp)
 404:	0141                	addi	sp,sp,16
 406:	8082                	ret

0000000000000408 <strlen>:

uint
strlen(const char *s)
{
 408:	1141                	addi	sp,sp,-16
 40a:	e422                	sd	s0,8(sp)
 40c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 40e:	00054783          	lbu	a5,0(a0)
 412:	cf91                	beqz	a5,42e <strlen+0x26>
 414:	0505                	addi	a0,a0,1
 416:	87aa                	mv	a5,a0
 418:	4685                	li	a3,1
 41a:	9e89                	subw	a3,a3,a0
 41c:	00f6853b          	addw	a0,a3,a5
 420:	0785                	addi	a5,a5,1
 422:	fff7c703          	lbu	a4,-1(a5)
 426:	fb7d                	bnez	a4,41c <strlen+0x14>
    ;
  return n;
}
 428:	6422                	ld	s0,8(sp)
 42a:	0141                	addi	sp,sp,16
 42c:	8082                	ret
  for(n = 0; s[n]; n++)
 42e:	4501                	li	a0,0
 430:	bfe5                	j	428 <strlen+0x20>

0000000000000432 <memset>:

void*
memset(void *dst, int c, uint n)
{
 432:	1141                	addi	sp,sp,-16
 434:	e422                	sd	s0,8(sp)
 436:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 438:	ca19                	beqz	a2,44e <memset+0x1c>
 43a:	87aa                	mv	a5,a0
 43c:	1602                	slli	a2,a2,0x20
 43e:	9201                	srli	a2,a2,0x20
 440:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 444:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 448:	0785                	addi	a5,a5,1
 44a:	fee79de3          	bne	a5,a4,444 <memset+0x12>
  }
  return dst;
}
 44e:	6422                	ld	s0,8(sp)
 450:	0141                	addi	sp,sp,16
 452:	8082                	ret

0000000000000454 <strchr>:

char*
strchr(const char *s, char c)
{
 454:	1141                	addi	sp,sp,-16
 456:	e422                	sd	s0,8(sp)
 458:	0800                	addi	s0,sp,16
  for(; *s; s++)
 45a:	00054783          	lbu	a5,0(a0)
 45e:	cb99                	beqz	a5,474 <strchr+0x20>
    if(*s == c)
 460:	00f58763          	beq	a1,a5,46e <strchr+0x1a>
  for(; *s; s++)
 464:	0505                	addi	a0,a0,1
 466:	00054783          	lbu	a5,0(a0)
 46a:	fbfd                	bnez	a5,460 <strchr+0xc>
      return (char*)s;
  return 0;
 46c:	4501                	li	a0,0
}
 46e:	6422                	ld	s0,8(sp)
 470:	0141                	addi	sp,sp,16
 472:	8082                	ret
  return 0;
 474:	4501                	li	a0,0
 476:	bfe5                	j	46e <strchr+0x1a>

0000000000000478 <gets>:

char*
gets(char *buf, int max)
{
 478:	711d                	addi	sp,sp,-96
 47a:	ec86                	sd	ra,88(sp)
 47c:	e8a2                	sd	s0,80(sp)
 47e:	e4a6                	sd	s1,72(sp)
 480:	e0ca                	sd	s2,64(sp)
 482:	fc4e                	sd	s3,56(sp)
 484:	f852                	sd	s4,48(sp)
 486:	f456                	sd	s5,40(sp)
 488:	f05a                	sd	s6,32(sp)
 48a:	ec5e                	sd	s7,24(sp)
 48c:	1080                	addi	s0,sp,96
 48e:	8baa                	mv	s7,a0
 490:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 492:	892a                	mv	s2,a0
 494:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 496:	4aa9                	li	s5,10
 498:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 49a:	89a6                	mv	s3,s1
 49c:	2485                	addiw	s1,s1,1
 49e:	0344d863          	bge	s1,s4,4ce <gets+0x56>
    cc = read(0, &c, 1);
 4a2:	4605                	li	a2,1
 4a4:	faf40593          	addi	a1,s0,-81
 4a8:	4501                	li	a0,0
 4aa:	00000097          	auipc	ra,0x0
 4ae:	19c080e7          	jalr	412(ra) # 646 <read>
    if(cc < 1)
 4b2:	00a05e63          	blez	a0,4ce <gets+0x56>
    buf[i++] = c;
 4b6:	faf44783          	lbu	a5,-81(s0)
 4ba:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4be:	01578763          	beq	a5,s5,4cc <gets+0x54>
 4c2:	0905                	addi	s2,s2,1
 4c4:	fd679be3          	bne	a5,s6,49a <gets+0x22>
  for(i=0; i+1 < max; ){
 4c8:	89a6                	mv	s3,s1
 4ca:	a011                	j	4ce <gets+0x56>
 4cc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 4ce:	99de                	add	s3,s3,s7
 4d0:	00098023          	sb	zero,0(s3)
  return buf;
}
 4d4:	855e                	mv	a0,s7
 4d6:	60e6                	ld	ra,88(sp)
 4d8:	6446                	ld	s0,80(sp)
 4da:	64a6                	ld	s1,72(sp)
 4dc:	6906                	ld	s2,64(sp)
 4de:	79e2                	ld	s3,56(sp)
 4e0:	7a42                	ld	s4,48(sp)
 4e2:	7aa2                	ld	s5,40(sp)
 4e4:	7b02                	ld	s6,32(sp)
 4e6:	6be2                	ld	s7,24(sp)
 4e8:	6125                	addi	sp,sp,96
 4ea:	8082                	ret

00000000000004ec <stat>:

int
stat(const char *n, struct stat *st)
{
 4ec:	1101                	addi	sp,sp,-32
 4ee:	ec06                	sd	ra,24(sp)
 4f0:	e822                	sd	s0,16(sp)
 4f2:	e426                	sd	s1,8(sp)
 4f4:	e04a                	sd	s2,0(sp)
 4f6:	1000                	addi	s0,sp,32
 4f8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4fa:	4581                	li	a1,0
 4fc:	00000097          	auipc	ra,0x0
 500:	172080e7          	jalr	370(ra) # 66e <open>
  if(fd < 0)
 504:	02054563          	bltz	a0,52e <stat+0x42>
 508:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 50a:	85ca                	mv	a1,s2
 50c:	00000097          	auipc	ra,0x0
 510:	17a080e7          	jalr	378(ra) # 686 <fstat>
 514:	892a                	mv	s2,a0
  close(fd);
 516:	8526                	mv	a0,s1
 518:	00000097          	auipc	ra,0x0
 51c:	13e080e7          	jalr	318(ra) # 656 <close>
  return r;
}
 520:	854a                	mv	a0,s2
 522:	60e2                	ld	ra,24(sp)
 524:	6442                	ld	s0,16(sp)
 526:	64a2                	ld	s1,8(sp)
 528:	6902                	ld	s2,0(sp)
 52a:	6105                	addi	sp,sp,32
 52c:	8082                	ret
    return -1;
 52e:	597d                	li	s2,-1
 530:	bfc5                	j	520 <stat+0x34>

0000000000000532 <atoi>:

int
atoi(const char *s)
{
 532:	1141                	addi	sp,sp,-16
 534:	e422                	sd	s0,8(sp)
 536:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 538:	00054603          	lbu	a2,0(a0)
 53c:	fd06079b          	addiw	a5,a2,-48
 540:	0ff7f793          	zext.b	a5,a5
 544:	4725                	li	a4,9
 546:	02f76963          	bltu	a4,a5,578 <atoi+0x46>
 54a:	86aa                	mv	a3,a0
  n = 0;
 54c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 54e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 550:	0685                	addi	a3,a3,1
 552:	0025179b          	slliw	a5,a0,0x2
 556:	9fa9                	addw	a5,a5,a0
 558:	0017979b          	slliw	a5,a5,0x1
 55c:	9fb1                	addw	a5,a5,a2
 55e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 562:	0006c603          	lbu	a2,0(a3)
 566:	fd06071b          	addiw	a4,a2,-48
 56a:	0ff77713          	zext.b	a4,a4
 56e:	fee5f1e3          	bgeu	a1,a4,550 <atoi+0x1e>
  return n;
}
 572:	6422                	ld	s0,8(sp)
 574:	0141                	addi	sp,sp,16
 576:	8082                	ret
  n = 0;
 578:	4501                	li	a0,0
 57a:	bfe5                	j	572 <atoi+0x40>

000000000000057c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 57c:	1141                	addi	sp,sp,-16
 57e:	e422                	sd	s0,8(sp)
 580:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 582:	02b57463          	bgeu	a0,a1,5aa <memmove+0x2e>
    while(n-- > 0)
 586:	00c05f63          	blez	a2,5a4 <memmove+0x28>
 58a:	1602                	slli	a2,a2,0x20
 58c:	9201                	srli	a2,a2,0x20
 58e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 592:	872a                	mv	a4,a0
      *dst++ = *src++;
 594:	0585                	addi	a1,a1,1
 596:	0705                	addi	a4,a4,1
 598:	fff5c683          	lbu	a3,-1(a1)
 59c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5a0:	fee79ae3          	bne	a5,a4,594 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret
    dst += n;
 5aa:	00c50733          	add	a4,a0,a2
    src += n;
 5ae:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5b0:	fec05ae3          	blez	a2,5a4 <memmove+0x28>
 5b4:	fff6079b          	addiw	a5,a2,-1
 5b8:	1782                	slli	a5,a5,0x20
 5ba:	9381                	srli	a5,a5,0x20
 5bc:	fff7c793          	not	a5,a5
 5c0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5c2:	15fd                	addi	a1,a1,-1
 5c4:	177d                	addi	a4,a4,-1
 5c6:	0005c683          	lbu	a3,0(a1)
 5ca:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5ce:	fee79ae3          	bne	a5,a4,5c2 <memmove+0x46>
 5d2:	bfc9                	j	5a4 <memmove+0x28>

00000000000005d4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5d4:	1141                	addi	sp,sp,-16
 5d6:	e422                	sd	s0,8(sp)
 5d8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5da:	ca05                	beqz	a2,60a <memcmp+0x36>
 5dc:	fff6069b          	addiw	a3,a2,-1
 5e0:	1682                	slli	a3,a3,0x20
 5e2:	9281                	srli	a3,a3,0x20
 5e4:	0685                	addi	a3,a3,1
 5e6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 5e8:	00054783          	lbu	a5,0(a0)
 5ec:	0005c703          	lbu	a4,0(a1)
 5f0:	00e79863          	bne	a5,a4,600 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 5f4:	0505                	addi	a0,a0,1
    p2++;
 5f6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 5f8:	fed518e3          	bne	a0,a3,5e8 <memcmp+0x14>
  }
  return 0;
 5fc:	4501                	li	a0,0
 5fe:	a019                	j	604 <memcmp+0x30>
      return *p1 - *p2;
 600:	40e7853b          	subw	a0,a5,a4
}
 604:	6422                	ld	s0,8(sp)
 606:	0141                	addi	sp,sp,16
 608:	8082                	ret
  return 0;
 60a:	4501                	li	a0,0
 60c:	bfe5                	j	604 <memcmp+0x30>

000000000000060e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 60e:	1141                	addi	sp,sp,-16
 610:	e406                	sd	ra,8(sp)
 612:	e022                	sd	s0,0(sp)
 614:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 616:	00000097          	auipc	ra,0x0
 61a:	f66080e7          	jalr	-154(ra) # 57c <memmove>
}
 61e:	60a2                	ld	ra,8(sp)
 620:	6402                	ld	s0,0(sp)
 622:	0141                	addi	sp,sp,16
 624:	8082                	ret

0000000000000626 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 626:	4885                	li	a7,1
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <exit>:
.global exit
exit:
 li a7, SYS_exit
 62e:	4889                	li	a7,2
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <wait>:
.global wait
wait:
 li a7, SYS_wait
 636:	488d                	li	a7,3
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 63e:	4891                	li	a7,4
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <read>:
.global read
read:
 li a7, SYS_read
 646:	4895                	li	a7,5
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <write>:
.global write
write:
 li a7, SYS_write
 64e:	48c1                	li	a7,16
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <close>:
.global close
close:
 li a7, SYS_close
 656:	48d5                	li	a7,21
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <kill>:
.global kill
kill:
 li a7, SYS_kill
 65e:	4899                	li	a7,6
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <exec>:
.global exec
exec:
 li a7, SYS_exec
 666:	489d                	li	a7,7
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <open>:
.global open
open:
 li a7, SYS_open
 66e:	48bd                	li	a7,15
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 676:	48c5                	li	a7,17
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 67e:	48c9                	li	a7,18
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 686:	48a1                	li	a7,8
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <link>:
.global link
link:
 li a7, SYS_link
 68e:	48cd                	li	a7,19
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 696:	48d1                	li	a7,20
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 69e:	48a5                	li	a7,9
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 6a6:	48a9                	li	a7,10
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6ae:	48ad                	li	a7,11
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6b6:	48b1                	li	a7,12
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6be:	48b5                	li	a7,13
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6c6:	48b9                	li	a7,14
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 6ce:	48d9                	li	a7,22
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6d6:	1101                	addi	sp,sp,-32
 6d8:	ec06                	sd	ra,24(sp)
 6da:	e822                	sd	s0,16(sp)
 6dc:	1000                	addi	s0,sp,32
 6de:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6e2:	4605                	li	a2,1
 6e4:	fef40593          	addi	a1,s0,-17
 6e8:	00000097          	auipc	ra,0x0
 6ec:	f66080e7          	jalr	-154(ra) # 64e <write>
}
 6f0:	60e2                	ld	ra,24(sp)
 6f2:	6442                	ld	s0,16(sp)
 6f4:	6105                	addi	sp,sp,32
 6f6:	8082                	ret

00000000000006f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6f8:	7139                	addi	sp,sp,-64
 6fa:	fc06                	sd	ra,56(sp)
 6fc:	f822                	sd	s0,48(sp)
 6fe:	f426                	sd	s1,40(sp)
 700:	f04a                	sd	s2,32(sp)
 702:	ec4e                	sd	s3,24(sp)
 704:	0080                	addi	s0,sp,64
 706:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 708:	c299                	beqz	a3,70e <printint+0x16>
 70a:	0805c863          	bltz	a1,79a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 70e:	2581                	sext.w	a1,a1
  neg = 0;
 710:	4881                	li	a7,0
 712:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 716:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 718:	2601                	sext.w	a2,a2
 71a:	00000517          	auipc	a0,0x0
 71e:	48e50513          	addi	a0,a0,1166 # ba8 <digits>
 722:	883a                	mv	a6,a4
 724:	2705                	addiw	a4,a4,1
 726:	02c5f7bb          	remuw	a5,a1,a2
 72a:	1782                	slli	a5,a5,0x20
 72c:	9381                	srli	a5,a5,0x20
 72e:	97aa                	add	a5,a5,a0
 730:	0007c783          	lbu	a5,0(a5)
 734:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 738:	0005879b          	sext.w	a5,a1
 73c:	02c5d5bb          	divuw	a1,a1,a2
 740:	0685                	addi	a3,a3,1
 742:	fec7f0e3          	bgeu	a5,a2,722 <printint+0x2a>
  if(neg)
 746:	00088b63          	beqz	a7,75c <printint+0x64>
    buf[i++] = '-';
 74a:	fd040793          	addi	a5,s0,-48
 74e:	973e                	add	a4,a4,a5
 750:	02d00793          	li	a5,45
 754:	fef70823          	sb	a5,-16(a4)
 758:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 75c:	02e05863          	blez	a4,78c <printint+0x94>
 760:	fc040793          	addi	a5,s0,-64
 764:	00e78933          	add	s2,a5,a4
 768:	fff78993          	addi	s3,a5,-1
 76c:	99ba                	add	s3,s3,a4
 76e:	377d                	addiw	a4,a4,-1
 770:	1702                	slli	a4,a4,0x20
 772:	9301                	srli	a4,a4,0x20
 774:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 778:	fff94583          	lbu	a1,-1(s2)
 77c:	8526                	mv	a0,s1
 77e:	00000097          	auipc	ra,0x0
 782:	f58080e7          	jalr	-168(ra) # 6d6 <putc>
  while(--i >= 0)
 786:	197d                	addi	s2,s2,-1
 788:	ff3918e3          	bne	s2,s3,778 <printint+0x80>
}
 78c:	70e2                	ld	ra,56(sp)
 78e:	7442                	ld	s0,48(sp)
 790:	74a2                	ld	s1,40(sp)
 792:	7902                	ld	s2,32(sp)
 794:	69e2                	ld	s3,24(sp)
 796:	6121                	addi	sp,sp,64
 798:	8082                	ret
    x = -xx;
 79a:	40b005bb          	negw	a1,a1
    neg = 1;
 79e:	4885                	li	a7,1
    x = -xx;
 7a0:	bf8d                	j	712 <printint+0x1a>

00000000000007a2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7a2:	7119                	addi	sp,sp,-128
 7a4:	fc86                	sd	ra,120(sp)
 7a6:	f8a2                	sd	s0,112(sp)
 7a8:	f4a6                	sd	s1,104(sp)
 7aa:	f0ca                	sd	s2,96(sp)
 7ac:	ecce                	sd	s3,88(sp)
 7ae:	e8d2                	sd	s4,80(sp)
 7b0:	e4d6                	sd	s5,72(sp)
 7b2:	e0da                	sd	s6,64(sp)
 7b4:	fc5e                	sd	s7,56(sp)
 7b6:	f862                	sd	s8,48(sp)
 7b8:	f466                	sd	s9,40(sp)
 7ba:	f06a                	sd	s10,32(sp)
 7bc:	ec6e                	sd	s11,24(sp)
 7be:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7c0:	0005c903          	lbu	s2,0(a1)
 7c4:	18090f63          	beqz	s2,962 <vprintf+0x1c0>
 7c8:	8aaa                	mv	s5,a0
 7ca:	8b32                	mv	s6,a2
 7cc:	00158493          	addi	s1,a1,1
  state = 0;
 7d0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7d2:	02500a13          	li	s4,37
      if(c == 'd'){
 7d6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 7da:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 7de:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 7e2:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7e6:	00000b97          	auipc	s7,0x0
 7ea:	3c2b8b93          	addi	s7,s7,962 # ba8 <digits>
 7ee:	a839                	j	80c <vprintf+0x6a>
        putc(fd, c);
 7f0:	85ca                	mv	a1,s2
 7f2:	8556                	mv	a0,s5
 7f4:	00000097          	auipc	ra,0x0
 7f8:	ee2080e7          	jalr	-286(ra) # 6d6 <putc>
 7fc:	a019                	j	802 <vprintf+0x60>
    } else if(state == '%'){
 7fe:	01498f63          	beq	s3,s4,81c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 802:	0485                	addi	s1,s1,1
 804:	fff4c903          	lbu	s2,-1(s1)
 808:	14090d63          	beqz	s2,962 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 80c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 810:	fe0997e3          	bnez	s3,7fe <vprintf+0x5c>
      if(c == '%'){
 814:	fd479ee3          	bne	a5,s4,7f0 <vprintf+0x4e>
        state = '%';
 818:	89be                	mv	s3,a5
 81a:	b7e5                	j	802 <vprintf+0x60>
      if(c == 'd'){
 81c:	05878063          	beq	a5,s8,85c <vprintf+0xba>
      } else if(c == 'l') {
 820:	05978c63          	beq	a5,s9,878 <vprintf+0xd6>
      } else if(c == 'x') {
 824:	07a78863          	beq	a5,s10,894 <vprintf+0xf2>
      } else if(c == 'p') {
 828:	09b78463          	beq	a5,s11,8b0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 82c:	07300713          	li	a4,115
 830:	0ce78663          	beq	a5,a4,8fc <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 834:	06300713          	li	a4,99
 838:	0ee78e63          	beq	a5,a4,934 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 83c:	11478863          	beq	a5,s4,94c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 840:	85d2                	mv	a1,s4
 842:	8556                	mv	a0,s5
 844:	00000097          	auipc	ra,0x0
 848:	e92080e7          	jalr	-366(ra) # 6d6 <putc>
        putc(fd, c);
 84c:	85ca                	mv	a1,s2
 84e:	8556                	mv	a0,s5
 850:	00000097          	auipc	ra,0x0
 854:	e86080e7          	jalr	-378(ra) # 6d6 <putc>
      }
      state = 0;
 858:	4981                	li	s3,0
 85a:	b765                	j	802 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 85c:	008b0913          	addi	s2,s6,8
 860:	4685                	li	a3,1
 862:	4629                	li	a2,10
 864:	000b2583          	lw	a1,0(s6)
 868:	8556                	mv	a0,s5
 86a:	00000097          	auipc	ra,0x0
 86e:	e8e080e7          	jalr	-370(ra) # 6f8 <printint>
 872:	8b4a                	mv	s6,s2
      state = 0;
 874:	4981                	li	s3,0
 876:	b771                	j	802 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 878:	008b0913          	addi	s2,s6,8
 87c:	4681                	li	a3,0
 87e:	4629                	li	a2,10
 880:	000b2583          	lw	a1,0(s6)
 884:	8556                	mv	a0,s5
 886:	00000097          	auipc	ra,0x0
 88a:	e72080e7          	jalr	-398(ra) # 6f8 <printint>
 88e:	8b4a                	mv	s6,s2
      state = 0;
 890:	4981                	li	s3,0
 892:	bf85                	j	802 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 894:	008b0913          	addi	s2,s6,8
 898:	4681                	li	a3,0
 89a:	4641                	li	a2,16
 89c:	000b2583          	lw	a1,0(s6)
 8a0:	8556                	mv	a0,s5
 8a2:	00000097          	auipc	ra,0x0
 8a6:	e56080e7          	jalr	-426(ra) # 6f8 <printint>
 8aa:	8b4a                	mv	s6,s2
      state = 0;
 8ac:	4981                	li	s3,0
 8ae:	bf91                	j	802 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8b0:	008b0793          	addi	a5,s6,8
 8b4:	f8f43423          	sd	a5,-120(s0)
 8b8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8bc:	03000593          	li	a1,48
 8c0:	8556                	mv	a0,s5
 8c2:	00000097          	auipc	ra,0x0
 8c6:	e14080e7          	jalr	-492(ra) # 6d6 <putc>
  putc(fd, 'x');
 8ca:	85ea                	mv	a1,s10
 8cc:	8556                	mv	a0,s5
 8ce:	00000097          	auipc	ra,0x0
 8d2:	e08080e7          	jalr	-504(ra) # 6d6 <putc>
 8d6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8d8:	03c9d793          	srli	a5,s3,0x3c
 8dc:	97de                	add	a5,a5,s7
 8de:	0007c583          	lbu	a1,0(a5)
 8e2:	8556                	mv	a0,s5
 8e4:	00000097          	auipc	ra,0x0
 8e8:	df2080e7          	jalr	-526(ra) # 6d6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 8ec:	0992                	slli	s3,s3,0x4
 8ee:	397d                	addiw	s2,s2,-1
 8f0:	fe0914e3          	bnez	s2,8d8 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 8f4:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 8f8:	4981                	li	s3,0
 8fa:	b721                	j	802 <vprintf+0x60>
        s = va_arg(ap, char*);
 8fc:	008b0993          	addi	s3,s6,8
 900:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 904:	02090163          	beqz	s2,926 <vprintf+0x184>
        while(*s != 0){
 908:	00094583          	lbu	a1,0(s2)
 90c:	c9a1                	beqz	a1,95c <vprintf+0x1ba>
          putc(fd, *s);
 90e:	8556                	mv	a0,s5
 910:	00000097          	auipc	ra,0x0
 914:	dc6080e7          	jalr	-570(ra) # 6d6 <putc>
          s++;
 918:	0905                	addi	s2,s2,1
        while(*s != 0){
 91a:	00094583          	lbu	a1,0(s2)
 91e:	f9e5                	bnez	a1,90e <vprintf+0x16c>
        s = va_arg(ap, char*);
 920:	8b4e                	mv	s6,s3
      state = 0;
 922:	4981                	li	s3,0
 924:	bdf9                	j	802 <vprintf+0x60>
          s = "(null)";
 926:	00000917          	auipc	s2,0x0
 92a:	27a90913          	addi	s2,s2,634 # ba0 <malloc+0x134>
        while(*s != 0){
 92e:	02800593          	li	a1,40
 932:	bff1                	j	90e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 934:	008b0913          	addi	s2,s6,8
 938:	000b4583          	lbu	a1,0(s6)
 93c:	8556                	mv	a0,s5
 93e:	00000097          	auipc	ra,0x0
 942:	d98080e7          	jalr	-616(ra) # 6d6 <putc>
 946:	8b4a                	mv	s6,s2
      state = 0;
 948:	4981                	li	s3,0
 94a:	bd65                	j	802 <vprintf+0x60>
        putc(fd, c);
 94c:	85d2                	mv	a1,s4
 94e:	8556                	mv	a0,s5
 950:	00000097          	auipc	ra,0x0
 954:	d86080e7          	jalr	-634(ra) # 6d6 <putc>
      state = 0;
 958:	4981                	li	s3,0
 95a:	b565                	j	802 <vprintf+0x60>
        s = va_arg(ap, char*);
 95c:	8b4e                	mv	s6,s3
      state = 0;
 95e:	4981                	li	s3,0
 960:	b54d                	j	802 <vprintf+0x60>
    }
  }
}
 962:	70e6                	ld	ra,120(sp)
 964:	7446                	ld	s0,112(sp)
 966:	74a6                	ld	s1,104(sp)
 968:	7906                	ld	s2,96(sp)
 96a:	69e6                	ld	s3,88(sp)
 96c:	6a46                	ld	s4,80(sp)
 96e:	6aa6                	ld	s5,72(sp)
 970:	6b06                	ld	s6,64(sp)
 972:	7be2                	ld	s7,56(sp)
 974:	7c42                	ld	s8,48(sp)
 976:	7ca2                	ld	s9,40(sp)
 978:	7d02                	ld	s10,32(sp)
 97a:	6de2                	ld	s11,24(sp)
 97c:	6109                	addi	sp,sp,128
 97e:	8082                	ret

0000000000000980 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 980:	715d                	addi	sp,sp,-80
 982:	ec06                	sd	ra,24(sp)
 984:	e822                	sd	s0,16(sp)
 986:	1000                	addi	s0,sp,32
 988:	e010                	sd	a2,0(s0)
 98a:	e414                	sd	a3,8(s0)
 98c:	e818                	sd	a4,16(s0)
 98e:	ec1c                	sd	a5,24(s0)
 990:	03043023          	sd	a6,32(s0)
 994:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 998:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 99c:	8622                	mv	a2,s0
 99e:	00000097          	auipc	ra,0x0
 9a2:	e04080e7          	jalr	-508(ra) # 7a2 <vprintf>
}
 9a6:	60e2                	ld	ra,24(sp)
 9a8:	6442                	ld	s0,16(sp)
 9aa:	6161                	addi	sp,sp,80
 9ac:	8082                	ret

00000000000009ae <printf>:

void
printf(const char *fmt, ...)
{
 9ae:	711d                	addi	sp,sp,-96
 9b0:	ec06                	sd	ra,24(sp)
 9b2:	e822                	sd	s0,16(sp)
 9b4:	1000                	addi	s0,sp,32
 9b6:	e40c                	sd	a1,8(s0)
 9b8:	e810                	sd	a2,16(s0)
 9ba:	ec14                	sd	a3,24(s0)
 9bc:	f018                	sd	a4,32(s0)
 9be:	f41c                	sd	a5,40(s0)
 9c0:	03043823          	sd	a6,48(s0)
 9c4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9c8:	00840613          	addi	a2,s0,8
 9cc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9d0:	85aa                	mv	a1,a0
 9d2:	4505                	li	a0,1
 9d4:	00000097          	auipc	ra,0x0
 9d8:	dce080e7          	jalr	-562(ra) # 7a2 <vprintf>
}
 9dc:	60e2                	ld	ra,24(sp)
 9de:	6442                	ld	s0,16(sp)
 9e0:	6125                	addi	sp,sp,96
 9e2:	8082                	ret

00000000000009e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9e4:	1141                	addi	sp,sp,-16
 9e6:	e422                	sd	s0,8(sp)
 9e8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 9ea:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ee:	00000797          	auipc	a5,0x0
 9f2:	1d27b783          	ld	a5,466(a5) # bc0 <freep>
 9f6:	a805                	j	a26 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 9f8:	4618                	lw	a4,8(a2)
 9fa:	9db9                	addw	a1,a1,a4
 9fc:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a00:	6398                	ld	a4,0(a5)
 a02:	6318                	ld	a4,0(a4)
 a04:	fee53823          	sd	a4,-16(a0)
 a08:	a091                	j	a4c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a0a:	ff852703          	lw	a4,-8(a0)
 a0e:	9e39                	addw	a2,a2,a4
 a10:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a12:	ff053703          	ld	a4,-16(a0)
 a16:	e398                	sd	a4,0(a5)
 a18:	a099                	j	a5e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a1a:	6398                	ld	a4,0(a5)
 a1c:	00e7e463          	bltu	a5,a4,a24 <free+0x40>
 a20:	00e6ea63          	bltu	a3,a4,a34 <free+0x50>
{
 a24:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a26:	fed7fae3          	bgeu	a5,a3,a1a <free+0x36>
 a2a:	6398                	ld	a4,0(a5)
 a2c:	00e6e463          	bltu	a3,a4,a34 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a30:	fee7eae3          	bltu	a5,a4,a24 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a34:	ff852583          	lw	a1,-8(a0)
 a38:	6390                	ld	a2,0(a5)
 a3a:	02059813          	slli	a6,a1,0x20
 a3e:	01c85713          	srli	a4,a6,0x1c
 a42:	9736                	add	a4,a4,a3
 a44:	fae60ae3          	beq	a2,a4,9f8 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a48:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a4c:	4790                	lw	a2,8(a5)
 a4e:	02061593          	slli	a1,a2,0x20
 a52:	01c5d713          	srli	a4,a1,0x1c
 a56:	973e                	add	a4,a4,a5
 a58:	fae689e3          	beq	a3,a4,a0a <free+0x26>
  } else
    p->s.ptr = bp;
 a5c:	e394                	sd	a3,0(a5)
  freep = p;
 a5e:	00000717          	auipc	a4,0x0
 a62:	16f73123          	sd	a5,354(a4) # bc0 <freep>
}
 a66:	6422                	ld	s0,8(sp)
 a68:	0141                	addi	sp,sp,16
 a6a:	8082                	ret

0000000000000a6c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a6c:	7139                	addi	sp,sp,-64
 a6e:	fc06                	sd	ra,56(sp)
 a70:	f822                	sd	s0,48(sp)
 a72:	f426                	sd	s1,40(sp)
 a74:	f04a                	sd	s2,32(sp)
 a76:	ec4e                	sd	s3,24(sp)
 a78:	e852                	sd	s4,16(sp)
 a7a:	e456                	sd	s5,8(sp)
 a7c:	e05a                	sd	s6,0(sp)
 a7e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a80:	02051493          	slli	s1,a0,0x20
 a84:	9081                	srli	s1,s1,0x20
 a86:	04bd                	addi	s1,s1,15
 a88:	8091                	srli	s1,s1,0x4
 a8a:	0014899b          	addiw	s3,s1,1
 a8e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a90:	00000517          	auipc	a0,0x0
 a94:	13053503          	ld	a0,304(a0) # bc0 <freep>
 a98:	c515                	beqz	a0,ac4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a9c:	4798                	lw	a4,8(a5)
 a9e:	02977f63          	bgeu	a4,s1,adc <malloc+0x70>
 aa2:	8a4e                	mv	s4,s3
 aa4:	0009871b          	sext.w	a4,s3
 aa8:	6685                	lui	a3,0x1
 aaa:	00d77363          	bgeu	a4,a3,ab0 <malloc+0x44>
 aae:	6a05                	lui	s4,0x1
 ab0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 ab4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab8:	00000917          	auipc	s2,0x0
 abc:	10890913          	addi	s2,s2,264 # bc0 <freep>
  if(p == (char*)-1)
 ac0:	5afd                	li	s5,-1
 ac2:	a895                	j	b36 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 ac4:	00000797          	auipc	a5,0x0
 ac8:	3f478793          	addi	a5,a5,1012 # eb8 <base>
 acc:	00000717          	auipc	a4,0x0
 ad0:	0ef73a23          	sd	a5,244(a4) # bc0 <freep>
 ad4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 ad6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 ada:	b7e1                	j	aa2 <malloc+0x36>
      if(p->s.size == nunits)
 adc:	02e48c63          	beq	s1,a4,b14 <malloc+0xa8>
        p->s.size -= nunits;
 ae0:	4137073b          	subw	a4,a4,s3
 ae4:	c798                	sw	a4,8(a5)
        p += p->s.size;
 ae6:	02071693          	slli	a3,a4,0x20
 aea:	01c6d713          	srli	a4,a3,0x1c
 aee:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 af0:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 af4:	00000717          	auipc	a4,0x0
 af8:	0ca73623          	sd	a0,204(a4) # bc0 <freep>
      return (void*)(p + 1);
 afc:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b00:	70e2                	ld	ra,56(sp)
 b02:	7442                	ld	s0,48(sp)
 b04:	74a2                	ld	s1,40(sp)
 b06:	7902                	ld	s2,32(sp)
 b08:	69e2                	ld	s3,24(sp)
 b0a:	6a42                	ld	s4,16(sp)
 b0c:	6aa2                	ld	s5,8(sp)
 b0e:	6b02                	ld	s6,0(sp)
 b10:	6121                	addi	sp,sp,64
 b12:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b14:	6398                	ld	a4,0(a5)
 b16:	e118                	sd	a4,0(a0)
 b18:	bff1                	j	af4 <malloc+0x88>
  hp->s.size = nu;
 b1a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b1e:	0541                	addi	a0,a0,16
 b20:	00000097          	auipc	ra,0x0
 b24:	ec4080e7          	jalr	-316(ra) # 9e4 <free>
  return freep;
 b28:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b2c:	d971                	beqz	a0,b00 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b2e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b30:	4798                	lw	a4,8(a5)
 b32:	fa9775e3          	bgeu	a4,s1,adc <malloc+0x70>
    if(p == freep)
 b36:	00093703          	ld	a4,0(s2)
 b3a:	853e                	mv	a0,a5
 b3c:	fef719e3          	bne	a4,a5,b2e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 b40:	8552                	mv	a0,s4
 b42:	00000097          	auipc	ra,0x0
 b46:	b74080e7          	jalr	-1164(ra) # 6b6 <sbrk>
  if(p == (char*)-1)
 b4a:	fd5518e3          	bne	a0,s5,b1a <malloc+0xae>
        return 0;
 b4e:	4501                	li	a0,0
 b50:	bf45                	j	b00 <malloc+0x94>
