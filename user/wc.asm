
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
  32:	bbbd8d93          	addi	s11,s11,-1093 # be9 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
  36:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
  38:	00001a17          	auipc	s4,0x1
  3c:	b38a0a13          	addi	s4,s4,-1224 # b70 <malloc+0xec>
        inword = 0;
  40:	4b01                	li	s6,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
  42:	a805                	j	72 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
  44:	8552                	mv	a0,s4
  46:	00000097          	auipc	ra,0x0
  4a:	426080e7          	jalr	1062(ra) # 46c <strchr>
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
  7a:	b7258593          	addi	a1,a1,-1166 # be8 <buf>
  7e:	f8843503          	ld	a0,-120(s0)
  82:	00000097          	auipc	ra,0x0
  86:	5dc080e7          	jalr	1500(ra) # 65e <read>
  8a:	00a05f63          	blez	a0,a8 <wc+0xa8>
    for(i=0; i<n; i++){
  8e:	00001497          	auipc	s1,0x1
  92:	b5a48493          	addi	s1,s1,-1190 # be8 <buf>
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
  ba:	ad250513          	addi	a0,a0,-1326 # b88 <malloc+0x104>
  be:	00001097          	auipc	ra,0x1
  c2:	908080e7          	jalr	-1784(ra) # 9c6 <printf>
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
  e8:	a9450513          	addi	a0,a0,-1388 # b78 <malloc+0xf4>
  ec:	00001097          	auipc	ra,0x1
  f0:	8da080e7          	jalr	-1830(ra) # 9c6 <printf>
    exit(1);
  f4:	4505                	li	a0,1
  f6:	00000097          	auipc	ra,0x0
  fa:	550080e7          	jalr	1360(ra) # 646 <exit>

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
 130:	55a080e7          	jalr	1370(ra) # 686 <open>
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
 14a:	528080e7          	jalr	1320(ra) # 66e <close>
  for(i = 1; i < argc; i++){
 14e:	04a1                	addi	s1,s1,8
 150:	fd349ce3          	bne	s1,s3,128 <main+0x2a>
  }
  exit(0);
 154:	4501                	li	a0,0
 156:	00000097          	auipc	ra,0x0
 15a:	4f0080e7          	jalr	1264(ra) # 646 <exit>
    wc(0, "");
 15e:	00001597          	auipc	a1,0x1
 162:	a3a58593          	addi	a1,a1,-1478 # b98 <malloc+0x114>
 166:	4501                	li	a0,0
 168:	00000097          	auipc	ra,0x0
 16c:	e98080e7          	jalr	-360(ra) # 0 <wc>
    exit(0);
 170:	4501                	li	a0,0
 172:	00000097          	auipc	ra,0x0
 176:	4d4080e7          	jalr	1236(ra) # 646 <exit>
      printf("wc: cannot open %s\n", argv[i]);
 17a:	608c                	ld	a1,0(s1)
 17c:	00001517          	auipc	a0,0x1
 180:	a2450513          	addi	a0,a0,-1500 # ba0 <malloc+0x11c>
 184:	00001097          	auipc	ra,0x1
 188:	842080e7          	jalr	-1982(ra) # 9c6 <printf>
      exit(1);
 18c:	4505                	li	a0,1
 18e:	00000097          	auipc	ra,0x0
 192:	4b8080e7          	jalr	1208(ra) # 646 <exit>

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

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 1c2:	7139                	addi	sp,sp,-64
 1c4:	fc06                	sd	ra,56(sp)
 1c6:	f822                	sd	s0,48(sp)
 1c8:	f426                	sd	s1,40(sp)
 1ca:	f04a                	sd	s2,32(sp)
 1cc:	ec4e                	sd	s3,24(sp)
 1ce:	e852                	sd	s4,16(sp)
 1d0:	e456                	sd	s5,8(sp)
 1d2:	e05a                	sd	s6,0(sp)
 1d4:	0080                	addi	s0,sp,64
 1d6:	8a2a                	mv	s4,a0
 1d8:	89ae                	mv	s3,a1
 1da:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 1dc:	4785                	li	a5,1
 1de:	00001497          	auipc	s1,0x1
 1e2:	c1248493          	addi	s1,s1,-1006 # df0 <rings+0x8>
 1e6:	00001917          	auipc	s2,0x1
 1ea:	cfa90913          	addi	s2,s2,-774 # ee0 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 1ee:	00001b17          	auipc	s6,0x1
 1f2:	9eab0b13          	addi	s6,s6,-1558 # bd8 <vm_addr>
  if(open_close == 1){
 1f6:	04f59063          	bne	a1,a5,236 <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 1fa:	00001497          	auipc	s1,0x1
 1fe:	bfe4a483          	lw	s1,-1026(s1) # df8 <rings+0x10>
 202:	c099                	beqz	s1,208 <create_or_close_the_buffer_user+0x46>
 204:	4481                	li	s1,0
 206:	a899                	j	25c <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 208:	865a                	mv	a2,s6
 20a:	4585                	li	a1,1
 20c:	00000097          	auipc	ra,0x0
 210:	4da080e7          	jalr	1242(ra) # 6e6 <ringbuf>
        rings[i].book->write_done = 0;
 214:	00001797          	auipc	a5,0x1
 218:	bd478793          	addi	a5,a5,-1068 # de8 <rings>
 21c:	6798                	ld	a4,8(a5)
 21e:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 222:	6798                	ld	a4,8(a5)
 224:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 228:	4b98                	lw	a4,16(a5)
 22a:	2705                	addiw	a4,a4,1
 22c:	cb98                	sw	a4,16(a5)
        break;
 22e:	a03d                	j	25c <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 230:	04e1                	addi	s1,s1,24
 232:	03248463          	beq	s1,s2,25a <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 236:	449c                	lw	a5,8(s1)
 238:	dfe5                	beqz	a5,230 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 23a:	865a                	mv	a2,s6
 23c:	85ce                	mv	a1,s3
 23e:	8552                	mv	a0,s4
 240:	00000097          	auipc	ra,0x0
 244:	4a6080e7          	jalr	1190(ra) # 6e6 <ringbuf>
        rings[i].book->write_done = 0;
 248:	609c                	ld	a5,0(s1)
 24a:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 24e:	609c                	ld	a5,0(s1)
 250:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 254:	0004a423          	sw	zero,8(s1)
 258:	bfe1                	j	230 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 25a:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 25c:	00001797          	auipc	a5,0x1
 260:	97c7b783          	ld	a5,-1668(a5) # bd8 <vm_addr>
 264:	00fab023          	sd	a5,0(s5)
  return i;
}
 268:	8526                	mv	a0,s1
 26a:	70e2                	ld	ra,56(sp)
 26c:	7442                	ld	s0,48(sp)
 26e:	74a2                	ld	s1,40(sp)
 270:	7902                	ld	s2,32(sp)
 272:	69e2                	ld	s3,24(sp)
 274:	6a42                	ld	s4,16(sp)
 276:	6aa2                	ld	s5,8(sp)
 278:	6b02                	ld	s6,0(sp)
 27a:	6121                	addi	sp,sp,64
 27c:	8082                	ret

000000000000027e <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 27e:	1101                	addi	sp,sp,-32
 280:	ec06                	sd	ra,24(sp)
 282:	e822                	sd	s0,16(sp)
 284:	e426                	sd	s1,8(sp)
 286:	1000                	addi	s0,sp,32
 288:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 28a:	00001797          	auipc	a5,0x1
 28e:	94e7b783          	ld	a5,-1714(a5) # bd8 <vm_addr>
 292:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 294:	421c                	lw	a5,0(a2)
 296:	e79d                	bnez	a5,2c4 <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 298:	00001697          	auipc	a3,0x1
 29c:	b5068693          	addi	a3,a3,-1200 # de8 <rings>
 2a0:	669c                	ld	a5,8(a3)
 2a2:	6398                	ld	a4,0(a5)
 2a4:	67c1                	lui	a5,0x10
 2a6:	9fb9                	addw	a5,a5,a4
 2a8:	00151713          	slli	a4,a0,0x1
 2ac:	953a                	add	a0,a0,a4
 2ae:	050e                	slli	a0,a0,0x3
 2b0:	9536                	add	a0,a0,a3
 2b2:	6518                	ld	a4,8(a0)
 2b4:	6718                	ld	a4,8(a4)
 2b6:	9f99                	subw	a5,a5,a4
 2b8:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 2ba:	60e2                	ld	ra,24(sp)
 2bc:	6442                	ld	s0,16(sp)
 2be:	64a2                	ld	s1,8(sp)
 2c0:	6105                	addi	sp,sp,32
 2c2:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 2c4:	00151793          	slli	a5,a0,0x1
 2c8:	953e                	add	a0,a0,a5
 2ca:	050e                	slli	a0,a0,0x3
 2cc:	00001797          	auipc	a5,0x1
 2d0:	b1c78793          	addi	a5,a5,-1252 # de8 <rings>
 2d4:	953e                	add	a0,a0,a5
 2d6:	6508                	ld	a0,8(a0)
 2d8:	0521                	addi	a0,a0,8
 2da:	00000097          	auipc	ra,0x0
 2de:	ed0080e7          	jalr	-304(ra) # 1aa <load>
 2e2:	c088                	sw	a0,0(s1)
}
 2e4:	bfd9                	j	2ba <ringbuf_start_write+0x3c>

00000000000002e6 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 2e6:	1141                	addi	sp,sp,-16
 2e8:	e406                	sd	ra,8(sp)
 2ea:	e022                	sd	s0,0(sp)
 2ec:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 2ee:	00151793          	slli	a5,a0,0x1
 2f2:	97aa                	add	a5,a5,a0
 2f4:	078e                	slli	a5,a5,0x3
 2f6:	00001517          	auipc	a0,0x1
 2fa:	af250513          	addi	a0,a0,-1294 # de8 <rings>
 2fe:	97aa                	add	a5,a5,a0
 300:	6788                	ld	a0,8(a5)
 302:	0035959b          	slliw	a1,a1,0x3
 306:	0521                	addi	a0,a0,8
 308:	00000097          	auipc	ra,0x0
 30c:	e8e080e7          	jalr	-370(ra) # 196 <store>
}
 310:	60a2                	ld	ra,8(sp)
 312:	6402                	ld	s0,0(sp)
 314:	0141                	addi	sp,sp,16
 316:	8082                	ret

0000000000000318 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 318:	1101                	addi	sp,sp,-32
 31a:	ec06                	sd	ra,24(sp)
 31c:	e822                	sd	s0,16(sp)
 31e:	e426                	sd	s1,8(sp)
 320:	1000                	addi	s0,sp,32
 322:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 324:	00151793          	slli	a5,a0,0x1
 328:	97aa                	add	a5,a5,a0
 32a:	078e                	slli	a5,a5,0x3
 32c:	00001517          	auipc	a0,0x1
 330:	abc50513          	addi	a0,a0,-1348 # de8 <rings>
 334:	97aa                	add	a5,a5,a0
 336:	6788                	ld	a0,8(a5)
 338:	0521                	addi	a0,a0,8
 33a:	00000097          	auipc	ra,0x0
 33e:	e70080e7          	jalr	-400(ra) # 1aa <load>
 342:	c088                	sw	a0,0(s1)
}
 344:	60e2                	ld	ra,24(sp)
 346:	6442                	ld	s0,16(sp)
 348:	64a2                	ld	s1,8(sp)
 34a:	6105                	addi	sp,sp,32
 34c:	8082                	ret

000000000000034e <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 34e:	1101                	addi	sp,sp,-32
 350:	ec06                	sd	ra,24(sp)
 352:	e822                	sd	s0,16(sp)
 354:	e426                	sd	s1,8(sp)
 356:	1000                	addi	s0,sp,32
 358:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 35a:	00151793          	slli	a5,a0,0x1
 35e:	97aa                	add	a5,a5,a0
 360:	078e                	slli	a5,a5,0x3
 362:	00001517          	auipc	a0,0x1
 366:	a8650513          	addi	a0,a0,-1402 # de8 <rings>
 36a:	97aa                	add	a5,a5,a0
 36c:	6788                	ld	a0,8(a5)
 36e:	611c                	ld	a5,0(a0)
 370:	ef99                	bnez	a5,38e <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 372:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 374:	41f7579b          	sraiw	a5,a4,0x1f
 378:	01d7d79b          	srliw	a5,a5,0x1d
 37c:	9fb9                	addw	a5,a5,a4
 37e:	4037d79b          	sraiw	a5,a5,0x3
 382:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 384:	60e2                	ld	ra,24(sp)
 386:	6442                	ld	s0,16(sp)
 388:	64a2                	ld	s1,8(sp)
 38a:	6105                	addi	sp,sp,32
 38c:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 38e:	00000097          	auipc	ra,0x0
 392:	e1c080e7          	jalr	-484(ra) # 1aa <load>
    *bytes /= 8;
 396:	41f5579b          	sraiw	a5,a0,0x1f
 39a:	01d7d79b          	srliw	a5,a5,0x1d
 39e:	9d3d                	addw	a0,a0,a5
 3a0:	4035551b          	sraiw	a0,a0,0x3
 3a4:	c088                	sw	a0,0(s1)
}
 3a6:	bff9                	j	384 <ringbuf_start_read+0x36>

00000000000003a8 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e406                	sd	ra,8(sp)
 3ac:	e022                	sd	s0,0(sp)
 3ae:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 3b0:	00151793          	slli	a5,a0,0x1
 3b4:	97aa                	add	a5,a5,a0
 3b6:	078e                	slli	a5,a5,0x3
 3b8:	00001517          	auipc	a0,0x1
 3bc:	a3050513          	addi	a0,a0,-1488 # de8 <rings>
 3c0:	97aa                	add	a5,a5,a0
 3c2:	0035959b          	slliw	a1,a1,0x3
 3c6:	6788                	ld	a0,8(a5)
 3c8:	00000097          	auipc	ra,0x0
 3cc:	dce080e7          	jalr	-562(ra) # 196 <store>
}
 3d0:	60a2                	ld	ra,8(sp)
 3d2:	6402                	ld	s0,0(sp)
 3d4:	0141                	addi	sp,sp,16
 3d6:	8082                	ret

00000000000003d8 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 3d8:	1141                	addi	sp,sp,-16
 3da:	e422                	sd	s0,8(sp)
 3dc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3de:	87aa                	mv	a5,a0
 3e0:	0585                	addi	a1,a1,1
 3e2:	0785                	addi	a5,a5,1
 3e4:	fff5c703          	lbu	a4,-1(a1)
 3e8:	fee78fa3          	sb	a4,-1(a5)
 3ec:	fb75                	bnez	a4,3e0 <strcpy+0x8>
    ;
  return os;
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	cb91                	beqz	a5,412 <strcmp+0x1e>
 400:	0005c703          	lbu	a4,0(a1)
 404:	00f71763          	bne	a4,a5,412 <strcmp+0x1e>
    p++, q++;
 408:	0505                	addi	a0,a0,1
 40a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 40c:	00054783          	lbu	a5,0(a0)
 410:	fbe5                	bnez	a5,400 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 412:	0005c503          	lbu	a0,0(a1)
}
 416:	40a7853b          	subw	a0,a5,a0
 41a:	6422                	ld	s0,8(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <strlen>:

uint
strlen(const char *s)
{
 420:	1141                	addi	sp,sp,-16
 422:	e422                	sd	s0,8(sp)
 424:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 426:	00054783          	lbu	a5,0(a0)
 42a:	cf91                	beqz	a5,446 <strlen+0x26>
 42c:	0505                	addi	a0,a0,1
 42e:	87aa                	mv	a5,a0
 430:	4685                	li	a3,1
 432:	9e89                	subw	a3,a3,a0
 434:	00f6853b          	addw	a0,a3,a5
 438:	0785                	addi	a5,a5,1
 43a:	fff7c703          	lbu	a4,-1(a5)
 43e:	fb7d                	bnez	a4,434 <strlen+0x14>
    ;
  return n;
}
 440:	6422                	ld	s0,8(sp)
 442:	0141                	addi	sp,sp,16
 444:	8082                	ret
  for(n = 0; s[n]; n++)
 446:	4501                	li	a0,0
 448:	bfe5                	j	440 <strlen+0x20>

000000000000044a <memset>:

void*
memset(void *dst, int c, uint n)
{
 44a:	1141                	addi	sp,sp,-16
 44c:	e422                	sd	s0,8(sp)
 44e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 450:	ca19                	beqz	a2,466 <memset+0x1c>
 452:	87aa                	mv	a5,a0
 454:	1602                	slli	a2,a2,0x20
 456:	9201                	srli	a2,a2,0x20
 458:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 45c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 460:	0785                	addi	a5,a5,1
 462:	fee79de3          	bne	a5,a4,45c <memset+0x12>
  }
  return dst;
}
 466:	6422                	ld	s0,8(sp)
 468:	0141                	addi	sp,sp,16
 46a:	8082                	ret

000000000000046c <strchr>:

char*
strchr(const char *s, char c)
{
 46c:	1141                	addi	sp,sp,-16
 46e:	e422                	sd	s0,8(sp)
 470:	0800                	addi	s0,sp,16
  for(; *s; s++)
 472:	00054783          	lbu	a5,0(a0)
 476:	cb99                	beqz	a5,48c <strchr+0x20>
    if(*s == c)
 478:	00f58763          	beq	a1,a5,486 <strchr+0x1a>
  for(; *s; s++)
 47c:	0505                	addi	a0,a0,1
 47e:	00054783          	lbu	a5,0(a0)
 482:	fbfd                	bnez	a5,478 <strchr+0xc>
      return (char*)s;
  return 0;
 484:	4501                	li	a0,0
}
 486:	6422                	ld	s0,8(sp)
 488:	0141                	addi	sp,sp,16
 48a:	8082                	ret
  return 0;
 48c:	4501                	li	a0,0
 48e:	bfe5                	j	486 <strchr+0x1a>

0000000000000490 <gets>:

char*
gets(char *buf, int max)
{
 490:	711d                	addi	sp,sp,-96
 492:	ec86                	sd	ra,88(sp)
 494:	e8a2                	sd	s0,80(sp)
 496:	e4a6                	sd	s1,72(sp)
 498:	e0ca                	sd	s2,64(sp)
 49a:	fc4e                	sd	s3,56(sp)
 49c:	f852                	sd	s4,48(sp)
 49e:	f456                	sd	s5,40(sp)
 4a0:	f05a                	sd	s6,32(sp)
 4a2:	ec5e                	sd	s7,24(sp)
 4a4:	1080                	addi	s0,sp,96
 4a6:	8baa                	mv	s7,a0
 4a8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4aa:	892a                	mv	s2,a0
 4ac:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 4ae:	4aa9                	li	s5,10
 4b0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 4b2:	89a6                	mv	s3,s1
 4b4:	2485                	addiw	s1,s1,1
 4b6:	0344d863          	bge	s1,s4,4e6 <gets+0x56>
    cc = read(0, &c, 1);
 4ba:	4605                	li	a2,1
 4bc:	faf40593          	addi	a1,s0,-81
 4c0:	4501                	li	a0,0
 4c2:	00000097          	auipc	ra,0x0
 4c6:	19c080e7          	jalr	412(ra) # 65e <read>
    if(cc < 1)
 4ca:	00a05e63          	blez	a0,4e6 <gets+0x56>
    buf[i++] = c;
 4ce:	faf44783          	lbu	a5,-81(s0)
 4d2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 4d6:	01578763          	beq	a5,s5,4e4 <gets+0x54>
 4da:	0905                	addi	s2,s2,1
 4dc:	fd679be3          	bne	a5,s6,4b2 <gets+0x22>
  for(i=0; i+1 < max; ){
 4e0:	89a6                	mv	s3,s1
 4e2:	a011                	j	4e6 <gets+0x56>
 4e4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 4e6:	99de                	add	s3,s3,s7
 4e8:	00098023          	sb	zero,0(s3)
  return buf;
}
 4ec:	855e                	mv	a0,s7
 4ee:	60e6                	ld	ra,88(sp)
 4f0:	6446                	ld	s0,80(sp)
 4f2:	64a6                	ld	s1,72(sp)
 4f4:	6906                	ld	s2,64(sp)
 4f6:	79e2                	ld	s3,56(sp)
 4f8:	7a42                	ld	s4,48(sp)
 4fa:	7aa2                	ld	s5,40(sp)
 4fc:	7b02                	ld	s6,32(sp)
 4fe:	6be2                	ld	s7,24(sp)
 500:	6125                	addi	sp,sp,96
 502:	8082                	ret

0000000000000504 <stat>:

int
stat(const char *n, struct stat *st)
{
 504:	1101                	addi	sp,sp,-32
 506:	ec06                	sd	ra,24(sp)
 508:	e822                	sd	s0,16(sp)
 50a:	e426                	sd	s1,8(sp)
 50c:	e04a                	sd	s2,0(sp)
 50e:	1000                	addi	s0,sp,32
 510:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 512:	4581                	li	a1,0
 514:	00000097          	auipc	ra,0x0
 518:	172080e7          	jalr	370(ra) # 686 <open>
  if(fd < 0)
 51c:	02054563          	bltz	a0,546 <stat+0x42>
 520:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 522:	85ca                	mv	a1,s2
 524:	00000097          	auipc	ra,0x0
 528:	17a080e7          	jalr	378(ra) # 69e <fstat>
 52c:	892a                	mv	s2,a0
  close(fd);
 52e:	8526                	mv	a0,s1
 530:	00000097          	auipc	ra,0x0
 534:	13e080e7          	jalr	318(ra) # 66e <close>
  return r;
}
 538:	854a                	mv	a0,s2
 53a:	60e2                	ld	ra,24(sp)
 53c:	6442                	ld	s0,16(sp)
 53e:	64a2                	ld	s1,8(sp)
 540:	6902                	ld	s2,0(sp)
 542:	6105                	addi	sp,sp,32
 544:	8082                	ret
    return -1;
 546:	597d                	li	s2,-1
 548:	bfc5                	j	538 <stat+0x34>

000000000000054a <atoi>:

int
atoi(const char *s)
{
 54a:	1141                	addi	sp,sp,-16
 54c:	e422                	sd	s0,8(sp)
 54e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 550:	00054603          	lbu	a2,0(a0)
 554:	fd06079b          	addiw	a5,a2,-48
 558:	0ff7f793          	zext.b	a5,a5
 55c:	4725                	li	a4,9
 55e:	02f76963          	bltu	a4,a5,590 <atoi+0x46>
 562:	86aa                	mv	a3,a0
  n = 0;
 564:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 566:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 568:	0685                	addi	a3,a3,1
 56a:	0025179b          	slliw	a5,a0,0x2
 56e:	9fa9                	addw	a5,a5,a0
 570:	0017979b          	slliw	a5,a5,0x1
 574:	9fb1                	addw	a5,a5,a2
 576:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 57a:	0006c603          	lbu	a2,0(a3)
 57e:	fd06071b          	addiw	a4,a2,-48
 582:	0ff77713          	zext.b	a4,a4
 586:	fee5f1e3          	bgeu	a1,a4,568 <atoi+0x1e>
  return n;
}
 58a:	6422                	ld	s0,8(sp)
 58c:	0141                	addi	sp,sp,16
 58e:	8082                	ret
  n = 0;
 590:	4501                	li	a0,0
 592:	bfe5                	j	58a <atoi+0x40>

0000000000000594 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 594:	1141                	addi	sp,sp,-16
 596:	e422                	sd	s0,8(sp)
 598:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 59a:	02b57463          	bgeu	a0,a1,5c2 <memmove+0x2e>
    while(n-- > 0)
 59e:	00c05f63          	blez	a2,5bc <memmove+0x28>
 5a2:	1602                	slli	a2,a2,0x20
 5a4:	9201                	srli	a2,a2,0x20
 5a6:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 5aa:	872a                	mv	a4,a0
      *dst++ = *src++;
 5ac:	0585                	addi	a1,a1,1
 5ae:	0705                	addi	a4,a4,1
 5b0:	fff5c683          	lbu	a3,-1(a1)
 5b4:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 5b8:	fee79ae3          	bne	a5,a4,5ac <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 5bc:	6422                	ld	s0,8(sp)
 5be:	0141                	addi	sp,sp,16
 5c0:	8082                	ret
    dst += n;
 5c2:	00c50733          	add	a4,a0,a2
    src += n;
 5c6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 5c8:	fec05ae3          	blez	a2,5bc <memmove+0x28>
 5cc:	fff6079b          	addiw	a5,a2,-1
 5d0:	1782                	slli	a5,a5,0x20
 5d2:	9381                	srli	a5,a5,0x20
 5d4:	fff7c793          	not	a5,a5
 5d8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 5da:	15fd                	addi	a1,a1,-1
 5dc:	177d                	addi	a4,a4,-1
 5de:	0005c683          	lbu	a3,0(a1)
 5e2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 5e6:	fee79ae3          	bne	a5,a4,5da <memmove+0x46>
 5ea:	bfc9                	j	5bc <memmove+0x28>

00000000000005ec <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 5ec:	1141                	addi	sp,sp,-16
 5ee:	e422                	sd	s0,8(sp)
 5f0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 5f2:	ca05                	beqz	a2,622 <memcmp+0x36>
 5f4:	fff6069b          	addiw	a3,a2,-1
 5f8:	1682                	slli	a3,a3,0x20
 5fa:	9281                	srli	a3,a3,0x20
 5fc:	0685                	addi	a3,a3,1
 5fe:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 600:	00054783          	lbu	a5,0(a0)
 604:	0005c703          	lbu	a4,0(a1)
 608:	00e79863          	bne	a5,a4,618 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 60c:	0505                	addi	a0,a0,1
    p2++;
 60e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 610:	fed518e3          	bne	a0,a3,600 <memcmp+0x14>
  }
  return 0;
 614:	4501                	li	a0,0
 616:	a019                	j	61c <memcmp+0x30>
      return *p1 - *p2;
 618:	40e7853b          	subw	a0,a5,a4
}
 61c:	6422                	ld	s0,8(sp)
 61e:	0141                	addi	sp,sp,16
 620:	8082                	ret
  return 0;
 622:	4501                	li	a0,0
 624:	bfe5                	j	61c <memcmp+0x30>

0000000000000626 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 626:	1141                	addi	sp,sp,-16
 628:	e406                	sd	ra,8(sp)
 62a:	e022                	sd	s0,0(sp)
 62c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 62e:	00000097          	auipc	ra,0x0
 632:	f66080e7          	jalr	-154(ra) # 594 <memmove>
}
 636:	60a2                	ld	ra,8(sp)
 638:	6402                	ld	s0,0(sp)
 63a:	0141                	addi	sp,sp,16
 63c:	8082                	ret

000000000000063e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 63e:	4885                	li	a7,1
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <exit>:
.global exit
exit:
 li a7, SYS_exit
 646:	4889                	li	a7,2
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <wait>:
.global wait
wait:
 li a7, SYS_wait
 64e:	488d                	li	a7,3
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 656:	4891                	li	a7,4
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <read>:
.global read
read:
 li a7, SYS_read
 65e:	4895                	li	a7,5
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <write>:
.global write
write:
 li a7, SYS_write
 666:	48c1                	li	a7,16
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <close>:
.global close
close:
 li a7, SYS_close
 66e:	48d5                	li	a7,21
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <kill>:
.global kill
kill:
 li a7, SYS_kill
 676:	4899                	li	a7,6
 ecall
 678:	00000073          	ecall
 ret
 67c:	8082                	ret

000000000000067e <exec>:
.global exec
exec:
 li a7, SYS_exec
 67e:	489d                	li	a7,7
 ecall
 680:	00000073          	ecall
 ret
 684:	8082                	ret

0000000000000686 <open>:
.global open
open:
 li a7, SYS_open
 686:	48bd                	li	a7,15
 ecall
 688:	00000073          	ecall
 ret
 68c:	8082                	ret

000000000000068e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 68e:	48c5                	li	a7,17
 ecall
 690:	00000073          	ecall
 ret
 694:	8082                	ret

0000000000000696 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 696:	48c9                	li	a7,18
 ecall
 698:	00000073          	ecall
 ret
 69c:	8082                	ret

000000000000069e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 69e:	48a1                	li	a7,8
 ecall
 6a0:	00000073          	ecall
 ret
 6a4:	8082                	ret

00000000000006a6 <link>:
.global link
link:
 li a7, SYS_link
 6a6:	48cd                	li	a7,19
 ecall
 6a8:	00000073          	ecall
 ret
 6ac:	8082                	ret

00000000000006ae <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 6ae:	48d1                	li	a7,20
 ecall
 6b0:	00000073          	ecall
 ret
 6b4:	8082                	ret

00000000000006b6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 6b6:	48a5                	li	a7,9
 ecall
 6b8:	00000073          	ecall
 ret
 6bc:	8082                	ret

00000000000006be <dup>:
.global dup
dup:
 li a7, SYS_dup
 6be:	48a9                	li	a7,10
 ecall
 6c0:	00000073          	ecall
 ret
 6c4:	8082                	ret

00000000000006c6 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 6c6:	48ad                	li	a7,11
 ecall
 6c8:	00000073          	ecall
 ret
 6cc:	8082                	ret

00000000000006ce <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 6ce:	48b1                	li	a7,12
 ecall
 6d0:	00000073          	ecall
 ret
 6d4:	8082                	ret

00000000000006d6 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 6d6:	48b5                	li	a7,13
 ecall
 6d8:	00000073          	ecall
 ret
 6dc:	8082                	ret

00000000000006de <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 6de:	48b9                	li	a7,14
 ecall
 6e0:	00000073          	ecall
 ret
 6e4:	8082                	ret

00000000000006e6 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 6e6:	48d9                	li	a7,22
 ecall
 6e8:	00000073          	ecall
 ret
 6ec:	8082                	ret

00000000000006ee <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 6ee:	1101                	addi	sp,sp,-32
 6f0:	ec06                	sd	ra,24(sp)
 6f2:	e822                	sd	s0,16(sp)
 6f4:	1000                	addi	s0,sp,32
 6f6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 6fa:	4605                	li	a2,1
 6fc:	fef40593          	addi	a1,s0,-17
 700:	00000097          	auipc	ra,0x0
 704:	f66080e7          	jalr	-154(ra) # 666 <write>
}
 708:	60e2                	ld	ra,24(sp)
 70a:	6442                	ld	s0,16(sp)
 70c:	6105                	addi	sp,sp,32
 70e:	8082                	ret

0000000000000710 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 710:	7139                	addi	sp,sp,-64
 712:	fc06                	sd	ra,56(sp)
 714:	f822                	sd	s0,48(sp)
 716:	f426                	sd	s1,40(sp)
 718:	f04a                	sd	s2,32(sp)
 71a:	ec4e                	sd	s3,24(sp)
 71c:	0080                	addi	s0,sp,64
 71e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 720:	c299                	beqz	a3,726 <printint+0x16>
 722:	0805c863          	bltz	a1,7b2 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 726:	2581                	sext.w	a1,a1
  neg = 0;
 728:	4881                	li	a7,0
 72a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 72e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 730:	2601                	sext.w	a2,a2
 732:	00000517          	auipc	a0,0x0
 736:	48e50513          	addi	a0,a0,1166 # bc0 <digits>
 73a:	883a                	mv	a6,a4
 73c:	2705                	addiw	a4,a4,1
 73e:	02c5f7bb          	remuw	a5,a1,a2
 742:	1782                	slli	a5,a5,0x20
 744:	9381                	srli	a5,a5,0x20
 746:	97aa                	add	a5,a5,a0
 748:	0007c783          	lbu	a5,0(a5)
 74c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 750:	0005879b          	sext.w	a5,a1
 754:	02c5d5bb          	divuw	a1,a1,a2
 758:	0685                	addi	a3,a3,1
 75a:	fec7f0e3          	bgeu	a5,a2,73a <printint+0x2a>
  if(neg)
 75e:	00088b63          	beqz	a7,774 <printint+0x64>
    buf[i++] = '-';
 762:	fd040793          	addi	a5,s0,-48
 766:	973e                	add	a4,a4,a5
 768:	02d00793          	li	a5,45
 76c:	fef70823          	sb	a5,-16(a4)
 770:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 774:	02e05863          	blez	a4,7a4 <printint+0x94>
 778:	fc040793          	addi	a5,s0,-64
 77c:	00e78933          	add	s2,a5,a4
 780:	fff78993          	addi	s3,a5,-1
 784:	99ba                	add	s3,s3,a4
 786:	377d                	addiw	a4,a4,-1
 788:	1702                	slli	a4,a4,0x20
 78a:	9301                	srli	a4,a4,0x20
 78c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 790:	fff94583          	lbu	a1,-1(s2)
 794:	8526                	mv	a0,s1
 796:	00000097          	auipc	ra,0x0
 79a:	f58080e7          	jalr	-168(ra) # 6ee <putc>
  while(--i >= 0)
 79e:	197d                	addi	s2,s2,-1
 7a0:	ff3918e3          	bne	s2,s3,790 <printint+0x80>
}
 7a4:	70e2                	ld	ra,56(sp)
 7a6:	7442                	ld	s0,48(sp)
 7a8:	74a2                	ld	s1,40(sp)
 7aa:	7902                	ld	s2,32(sp)
 7ac:	69e2                	ld	s3,24(sp)
 7ae:	6121                	addi	sp,sp,64
 7b0:	8082                	ret
    x = -xx;
 7b2:	40b005bb          	negw	a1,a1
    neg = 1;
 7b6:	4885                	li	a7,1
    x = -xx;
 7b8:	bf8d                	j	72a <printint+0x1a>

00000000000007ba <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 7ba:	7119                	addi	sp,sp,-128
 7bc:	fc86                	sd	ra,120(sp)
 7be:	f8a2                	sd	s0,112(sp)
 7c0:	f4a6                	sd	s1,104(sp)
 7c2:	f0ca                	sd	s2,96(sp)
 7c4:	ecce                	sd	s3,88(sp)
 7c6:	e8d2                	sd	s4,80(sp)
 7c8:	e4d6                	sd	s5,72(sp)
 7ca:	e0da                	sd	s6,64(sp)
 7cc:	fc5e                	sd	s7,56(sp)
 7ce:	f862                	sd	s8,48(sp)
 7d0:	f466                	sd	s9,40(sp)
 7d2:	f06a                	sd	s10,32(sp)
 7d4:	ec6e                	sd	s11,24(sp)
 7d6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 7d8:	0005c903          	lbu	s2,0(a1)
 7dc:	18090f63          	beqz	s2,97a <vprintf+0x1c0>
 7e0:	8aaa                	mv	s5,a0
 7e2:	8b32                	mv	s6,a2
 7e4:	00158493          	addi	s1,a1,1
  state = 0;
 7e8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7ea:	02500a13          	li	s4,37
      if(c == 'd'){
 7ee:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 7f2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 7f6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 7fa:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7fe:	00000b97          	auipc	s7,0x0
 802:	3c2b8b93          	addi	s7,s7,962 # bc0 <digits>
 806:	a839                	j	824 <vprintf+0x6a>
        putc(fd, c);
 808:	85ca                	mv	a1,s2
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	ee2080e7          	jalr	-286(ra) # 6ee <putc>
 814:	a019                	j	81a <vprintf+0x60>
    } else if(state == '%'){
 816:	01498f63          	beq	s3,s4,834 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 81a:	0485                	addi	s1,s1,1
 81c:	fff4c903          	lbu	s2,-1(s1)
 820:	14090d63          	beqz	s2,97a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 824:	0009079b          	sext.w	a5,s2
    if(state == 0){
 828:	fe0997e3          	bnez	s3,816 <vprintf+0x5c>
      if(c == '%'){
 82c:	fd479ee3          	bne	a5,s4,808 <vprintf+0x4e>
        state = '%';
 830:	89be                	mv	s3,a5
 832:	b7e5                	j	81a <vprintf+0x60>
      if(c == 'd'){
 834:	05878063          	beq	a5,s8,874 <vprintf+0xba>
      } else if(c == 'l') {
 838:	05978c63          	beq	a5,s9,890 <vprintf+0xd6>
      } else if(c == 'x') {
 83c:	07a78863          	beq	a5,s10,8ac <vprintf+0xf2>
      } else if(c == 'p') {
 840:	09b78463          	beq	a5,s11,8c8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 844:	07300713          	li	a4,115
 848:	0ce78663          	beq	a5,a4,914 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 84c:	06300713          	li	a4,99
 850:	0ee78e63          	beq	a5,a4,94c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 854:	11478863          	beq	a5,s4,964 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 858:	85d2                	mv	a1,s4
 85a:	8556                	mv	a0,s5
 85c:	00000097          	auipc	ra,0x0
 860:	e92080e7          	jalr	-366(ra) # 6ee <putc>
        putc(fd, c);
 864:	85ca                	mv	a1,s2
 866:	8556                	mv	a0,s5
 868:	00000097          	auipc	ra,0x0
 86c:	e86080e7          	jalr	-378(ra) # 6ee <putc>
      }
      state = 0;
 870:	4981                	li	s3,0
 872:	b765                	j	81a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 874:	008b0913          	addi	s2,s6,8
 878:	4685                	li	a3,1
 87a:	4629                	li	a2,10
 87c:	000b2583          	lw	a1,0(s6)
 880:	8556                	mv	a0,s5
 882:	00000097          	auipc	ra,0x0
 886:	e8e080e7          	jalr	-370(ra) # 710 <printint>
 88a:	8b4a                	mv	s6,s2
      state = 0;
 88c:	4981                	li	s3,0
 88e:	b771                	j	81a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 890:	008b0913          	addi	s2,s6,8
 894:	4681                	li	a3,0
 896:	4629                	li	a2,10
 898:	000b2583          	lw	a1,0(s6)
 89c:	8556                	mv	a0,s5
 89e:	00000097          	auipc	ra,0x0
 8a2:	e72080e7          	jalr	-398(ra) # 710 <printint>
 8a6:	8b4a                	mv	s6,s2
      state = 0;
 8a8:	4981                	li	s3,0
 8aa:	bf85                	j	81a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 8ac:	008b0913          	addi	s2,s6,8
 8b0:	4681                	li	a3,0
 8b2:	4641                	li	a2,16
 8b4:	000b2583          	lw	a1,0(s6)
 8b8:	8556                	mv	a0,s5
 8ba:	00000097          	auipc	ra,0x0
 8be:	e56080e7          	jalr	-426(ra) # 710 <printint>
 8c2:	8b4a                	mv	s6,s2
      state = 0;
 8c4:	4981                	li	s3,0
 8c6:	bf91                	j	81a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 8c8:	008b0793          	addi	a5,s6,8
 8cc:	f8f43423          	sd	a5,-120(s0)
 8d0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 8d4:	03000593          	li	a1,48
 8d8:	8556                	mv	a0,s5
 8da:	00000097          	auipc	ra,0x0
 8de:	e14080e7          	jalr	-492(ra) # 6ee <putc>
  putc(fd, 'x');
 8e2:	85ea                	mv	a1,s10
 8e4:	8556                	mv	a0,s5
 8e6:	00000097          	auipc	ra,0x0
 8ea:	e08080e7          	jalr	-504(ra) # 6ee <putc>
 8ee:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 8f0:	03c9d793          	srli	a5,s3,0x3c
 8f4:	97de                	add	a5,a5,s7
 8f6:	0007c583          	lbu	a1,0(a5)
 8fa:	8556                	mv	a0,s5
 8fc:	00000097          	auipc	ra,0x0
 900:	df2080e7          	jalr	-526(ra) # 6ee <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 904:	0992                	slli	s3,s3,0x4
 906:	397d                	addiw	s2,s2,-1
 908:	fe0914e3          	bnez	s2,8f0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 90c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 910:	4981                	li	s3,0
 912:	b721                	j	81a <vprintf+0x60>
        s = va_arg(ap, char*);
 914:	008b0993          	addi	s3,s6,8
 918:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 91c:	02090163          	beqz	s2,93e <vprintf+0x184>
        while(*s != 0){
 920:	00094583          	lbu	a1,0(s2)
 924:	c9a1                	beqz	a1,974 <vprintf+0x1ba>
          putc(fd, *s);
 926:	8556                	mv	a0,s5
 928:	00000097          	auipc	ra,0x0
 92c:	dc6080e7          	jalr	-570(ra) # 6ee <putc>
          s++;
 930:	0905                	addi	s2,s2,1
        while(*s != 0){
 932:	00094583          	lbu	a1,0(s2)
 936:	f9e5                	bnez	a1,926 <vprintf+0x16c>
        s = va_arg(ap, char*);
 938:	8b4e                	mv	s6,s3
      state = 0;
 93a:	4981                	li	s3,0
 93c:	bdf9                	j	81a <vprintf+0x60>
          s = "(null)";
 93e:	00000917          	auipc	s2,0x0
 942:	27a90913          	addi	s2,s2,634 # bb8 <malloc+0x134>
        while(*s != 0){
 946:	02800593          	li	a1,40
 94a:	bff1                	j	926 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 94c:	008b0913          	addi	s2,s6,8
 950:	000b4583          	lbu	a1,0(s6)
 954:	8556                	mv	a0,s5
 956:	00000097          	auipc	ra,0x0
 95a:	d98080e7          	jalr	-616(ra) # 6ee <putc>
 95e:	8b4a                	mv	s6,s2
      state = 0;
 960:	4981                	li	s3,0
 962:	bd65                	j	81a <vprintf+0x60>
        putc(fd, c);
 964:	85d2                	mv	a1,s4
 966:	8556                	mv	a0,s5
 968:	00000097          	auipc	ra,0x0
 96c:	d86080e7          	jalr	-634(ra) # 6ee <putc>
      state = 0;
 970:	4981                	li	s3,0
 972:	b565                	j	81a <vprintf+0x60>
        s = va_arg(ap, char*);
 974:	8b4e                	mv	s6,s3
      state = 0;
 976:	4981                	li	s3,0
 978:	b54d                	j	81a <vprintf+0x60>
    }
  }
}
 97a:	70e6                	ld	ra,120(sp)
 97c:	7446                	ld	s0,112(sp)
 97e:	74a6                	ld	s1,104(sp)
 980:	7906                	ld	s2,96(sp)
 982:	69e6                	ld	s3,88(sp)
 984:	6a46                	ld	s4,80(sp)
 986:	6aa6                	ld	s5,72(sp)
 988:	6b06                	ld	s6,64(sp)
 98a:	7be2                	ld	s7,56(sp)
 98c:	7c42                	ld	s8,48(sp)
 98e:	7ca2                	ld	s9,40(sp)
 990:	7d02                	ld	s10,32(sp)
 992:	6de2                	ld	s11,24(sp)
 994:	6109                	addi	sp,sp,128
 996:	8082                	ret

0000000000000998 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 998:	715d                	addi	sp,sp,-80
 99a:	ec06                	sd	ra,24(sp)
 99c:	e822                	sd	s0,16(sp)
 99e:	1000                	addi	s0,sp,32
 9a0:	e010                	sd	a2,0(s0)
 9a2:	e414                	sd	a3,8(s0)
 9a4:	e818                	sd	a4,16(s0)
 9a6:	ec1c                	sd	a5,24(s0)
 9a8:	03043023          	sd	a6,32(s0)
 9ac:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 9b0:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 9b4:	8622                	mv	a2,s0
 9b6:	00000097          	auipc	ra,0x0
 9ba:	e04080e7          	jalr	-508(ra) # 7ba <vprintf>
}
 9be:	60e2                	ld	ra,24(sp)
 9c0:	6442                	ld	s0,16(sp)
 9c2:	6161                	addi	sp,sp,80
 9c4:	8082                	ret

00000000000009c6 <printf>:

void
printf(const char *fmt, ...)
{
 9c6:	711d                	addi	sp,sp,-96
 9c8:	ec06                	sd	ra,24(sp)
 9ca:	e822                	sd	s0,16(sp)
 9cc:	1000                	addi	s0,sp,32
 9ce:	e40c                	sd	a1,8(s0)
 9d0:	e810                	sd	a2,16(s0)
 9d2:	ec14                	sd	a3,24(s0)
 9d4:	f018                	sd	a4,32(s0)
 9d6:	f41c                	sd	a5,40(s0)
 9d8:	03043823          	sd	a6,48(s0)
 9dc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 9e0:	00840613          	addi	a2,s0,8
 9e4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 9e8:	85aa                	mv	a1,a0
 9ea:	4505                	li	a0,1
 9ec:	00000097          	auipc	ra,0x0
 9f0:	dce080e7          	jalr	-562(ra) # 7ba <vprintf>
}
 9f4:	60e2                	ld	ra,24(sp)
 9f6:	6442                	ld	s0,16(sp)
 9f8:	6125                	addi	sp,sp,96
 9fa:	8082                	ret

00000000000009fc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9fc:	1141                	addi	sp,sp,-16
 9fe:	e422                	sd	s0,8(sp)
 a00:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 a02:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a06:	00000797          	auipc	a5,0x0
 a0a:	1da7b783          	ld	a5,474(a5) # be0 <freep>
 a0e:	a805                	j	a3e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 a10:	4618                	lw	a4,8(a2)
 a12:	9db9                	addw	a1,a1,a4
 a14:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 a18:	6398                	ld	a4,0(a5)
 a1a:	6318                	ld	a4,0(a4)
 a1c:	fee53823          	sd	a4,-16(a0)
 a20:	a091                	j	a64 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 a22:	ff852703          	lw	a4,-8(a0)
 a26:	9e39                	addw	a2,a2,a4
 a28:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 a2a:	ff053703          	ld	a4,-16(a0)
 a2e:	e398                	sd	a4,0(a5)
 a30:	a099                	j	a76 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a32:	6398                	ld	a4,0(a5)
 a34:	00e7e463          	bltu	a5,a4,a3c <free+0x40>
 a38:	00e6ea63          	bltu	a3,a4,a4c <free+0x50>
{
 a3c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a3e:	fed7fae3          	bgeu	a5,a3,a32 <free+0x36>
 a42:	6398                	ld	a4,0(a5)
 a44:	00e6e463          	bltu	a3,a4,a4c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a48:	fee7eae3          	bltu	a5,a4,a3c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 a4c:	ff852583          	lw	a1,-8(a0)
 a50:	6390                	ld	a2,0(a5)
 a52:	02059813          	slli	a6,a1,0x20
 a56:	01c85713          	srli	a4,a6,0x1c
 a5a:	9736                	add	a4,a4,a3
 a5c:	fae60ae3          	beq	a2,a4,a10 <free+0x14>
    bp->s.ptr = p->s.ptr;
 a60:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 a64:	4790                	lw	a2,8(a5)
 a66:	02061593          	slli	a1,a2,0x20
 a6a:	01c5d713          	srli	a4,a1,0x1c
 a6e:	973e                	add	a4,a4,a5
 a70:	fae689e3          	beq	a3,a4,a22 <free+0x26>
  } else
    p->s.ptr = bp;
 a74:	e394                	sd	a3,0(a5)
  freep = p;
 a76:	00000717          	auipc	a4,0x0
 a7a:	16f73523          	sd	a5,362(a4) # be0 <freep>
}
 a7e:	6422                	ld	s0,8(sp)
 a80:	0141                	addi	sp,sp,16
 a82:	8082                	ret

0000000000000a84 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a84:	7139                	addi	sp,sp,-64
 a86:	fc06                	sd	ra,56(sp)
 a88:	f822                	sd	s0,48(sp)
 a8a:	f426                	sd	s1,40(sp)
 a8c:	f04a                	sd	s2,32(sp)
 a8e:	ec4e                	sd	s3,24(sp)
 a90:	e852                	sd	s4,16(sp)
 a92:	e456                	sd	s5,8(sp)
 a94:	e05a                	sd	s6,0(sp)
 a96:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a98:	02051493          	slli	s1,a0,0x20
 a9c:	9081                	srli	s1,s1,0x20
 a9e:	04bd                	addi	s1,s1,15
 aa0:	8091                	srli	s1,s1,0x4
 aa2:	0014899b          	addiw	s3,s1,1
 aa6:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 aa8:	00000517          	auipc	a0,0x0
 aac:	13853503          	ld	a0,312(a0) # be0 <freep>
 ab0:	c515                	beqz	a0,adc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ab4:	4798                	lw	a4,8(a5)
 ab6:	02977f63          	bgeu	a4,s1,af4 <malloc+0x70>
 aba:	8a4e                	mv	s4,s3
 abc:	0009871b          	sext.w	a4,s3
 ac0:	6685                	lui	a3,0x1
 ac2:	00d77363          	bgeu	a4,a3,ac8 <malloc+0x44>
 ac6:	6a05                	lui	s4,0x1
 ac8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 acc:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ad0:	00000917          	auipc	s2,0x0
 ad4:	11090913          	addi	s2,s2,272 # be0 <freep>
  if(p == (char*)-1)
 ad8:	5afd                	li	s5,-1
 ada:	a895                	j	b4e <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 adc:	00000797          	auipc	a5,0x0
 ae0:	3fc78793          	addi	a5,a5,1020 # ed8 <base>
 ae4:	00000717          	auipc	a4,0x0
 ae8:	0ef73e23          	sd	a5,252(a4) # be0 <freep>
 aec:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 aee:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 af2:	b7e1                	j	aba <malloc+0x36>
      if(p->s.size == nunits)
 af4:	02e48c63          	beq	s1,a4,b2c <malloc+0xa8>
        p->s.size -= nunits;
 af8:	4137073b          	subw	a4,a4,s3
 afc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 afe:	02071693          	slli	a3,a4,0x20
 b02:	01c6d713          	srli	a4,a3,0x1c
 b06:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 b08:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 b0c:	00000717          	auipc	a4,0x0
 b10:	0ca73a23          	sd	a0,212(a4) # be0 <freep>
      return (void*)(p + 1);
 b14:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 b18:	70e2                	ld	ra,56(sp)
 b1a:	7442                	ld	s0,48(sp)
 b1c:	74a2                	ld	s1,40(sp)
 b1e:	7902                	ld	s2,32(sp)
 b20:	69e2                	ld	s3,24(sp)
 b22:	6a42                	ld	s4,16(sp)
 b24:	6aa2                	ld	s5,8(sp)
 b26:	6b02                	ld	s6,0(sp)
 b28:	6121                	addi	sp,sp,64
 b2a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 b2c:	6398                	ld	a4,0(a5)
 b2e:	e118                	sd	a4,0(a0)
 b30:	bff1                	j	b0c <malloc+0x88>
  hp->s.size = nu;
 b32:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 b36:	0541                	addi	a0,a0,16
 b38:	00000097          	auipc	ra,0x0
 b3c:	ec4080e7          	jalr	-316(ra) # 9fc <free>
  return freep;
 b40:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 b44:	d971                	beqz	a0,b18 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b46:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 b48:	4798                	lw	a4,8(a5)
 b4a:	fa9775e3          	bgeu	a4,s1,af4 <malloc+0x70>
    if(p == freep)
 b4e:	00093703          	ld	a4,0(s2)
 b52:	853e                	mv	a0,a5
 b54:	fef719e3          	bne	a4,a5,b46 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 b58:	8552                	mv	a0,s4
 b5a:	00000097          	auipc	ra,0x0
 b5e:	b74080e7          	jalr	-1164(ra) # 6ce <sbrk>
  if(p == (char*)-1)
 b62:	fd5518e3          	bne	a0,s5,b32 <malloc+0xae>
        return 0;
 b66:	4501                	li	a0,0
 b68:	bf45                	j	b18 <malloc+0x94>
