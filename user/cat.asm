
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
  10:	00001917          	auipc	s2,0x1
  14:	b4090913          	addi	s2,s2,-1216 # b50 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	5ae080e7          	jalr	1454(ra) # 5ce <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	5a2080e7          	jalr	1442(ra) # 5d6 <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	aa058593          	addi	a1,a1,-1376 # ae0 <malloc+0xec>
  48:	4509                	li	a0,2
  4a:	00001097          	auipc	ra,0x1
  4e:	8be080e7          	jalr	-1858(ra) # 908 <fprintf>
      exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	562080e7          	jalr	1378(ra) # 5b6 <exit>
    }
  }
  if(n < 0){
  5c:	00054963          	bltz	a0,6e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
  60:	70a2                	ld	ra,40(sp)
  62:	7402                	ld	s0,32(sp)
  64:	64e2                	ld	s1,24(sp)
  66:	6942                	ld	s2,16(sp)
  68:	69a2                	ld	s3,8(sp)
  6a:	6145                	addi	sp,sp,48
  6c:	8082                	ret
    fprintf(2, "cat: read error\n");
  6e:	00001597          	auipc	a1,0x1
  72:	a8a58593          	addi	a1,a1,-1398 # af8 <malloc+0x104>
  76:	4509                	li	a0,2
  78:	00001097          	auipc	ra,0x1
  7c:	890080e7          	jalr	-1904(ra) # 908 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	534080e7          	jalr	1332(ra) # 5b6 <exit>

000000000000008a <main>:

int
main(int argc, char *argv[])
{
  8a:	7179                	addi	sp,sp,-48
  8c:	f406                	sd	ra,40(sp)
  8e:	f022                	sd	s0,32(sp)
  90:	ec26                	sd	s1,24(sp)
  92:	e84a                	sd	s2,16(sp)
  94:	e44e                	sd	s3,8(sp)
  96:	e052                	sd	s4,0(sp)
  98:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
  9a:	4785                	li	a5,1
  9c:	04a7d763          	bge	a5,a0,ea <main+0x60>
  a0:	00858913          	addi	s2,a1,8
  a4:	ffe5099b          	addiw	s3,a0,-2
  a8:	02099793          	slli	a5,s3,0x20
  ac:	01d7d993          	srli	s3,a5,0x1d
  b0:	05c1                	addi	a1,a1,16
  b2:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  b4:	4581                	li	a1,0
  b6:	00093503          	ld	a0,0(s2)
  ba:	00000097          	auipc	ra,0x0
  be:	53c080e7          	jalr	1340(ra) # 5f6 <open>
  c2:	84aa                	mv	s1,a0
  c4:	02054d63          	bltz	a0,fe <main+0x74>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
  c8:	00000097          	auipc	ra,0x0
  cc:	f38080e7          	jalr	-200(ra) # 0 <cat>
    close(fd);
  d0:	8526                	mv	a0,s1
  d2:	00000097          	auipc	ra,0x0
  d6:	50c080e7          	jalr	1292(ra) # 5de <close>
  for(i = 1; i < argc; i++){
  da:	0921                	addi	s2,s2,8
  dc:	fd391ce3          	bne	s2,s3,b4 <main+0x2a>
  }
  exit(0);
  e0:	4501                	li	a0,0
  e2:	00000097          	auipc	ra,0x0
  e6:	4d4080e7          	jalr	1236(ra) # 5b6 <exit>
    cat(0);
  ea:	4501                	li	a0,0
  ec:	00000097          	auipc	ra,0x0
  f0:	f14080e7          	jalr	-236(ra) # 0 <cat>
    exit(0);
  f4:	4501                	li	a0,0
  f6:	00000097          	auipc	ra,0x0
  fa:	4c0080e7          	jalr	1216(ra) # 5b6 <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  fe:	00093603          	ld	a2,0(s2)
 102:	00001597          	auipc	a1,0x1
 106:	a0e58593          	addi	a1,a1,-1522 # b10 <malloc+0x11c>
 10a:	4509                	li	a0,2
 10c:	00000097          	auipc	ra,0x0
 110:	7fc080e7          	jalr	2044(ra) # 908 <fprintf>
      exit(1);
 114:	4505                	li	a0,1
 116:	00000097          	auipc	ra,0x0
 11a:	4a0080e7          	jalr	1184(ra) # 5b6 <exit>

000000000000011e <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 124:	0f50000f          	fence	iorw,ow
 128:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 12c:	6422                	ld	s0,8(sp)
 12e:	0141                	addi	sp,sp,16
 130:	8082                	ret

0000000000000132 <load>:

int load(uint64 *p) {
 132:	1141                	addi	sp,sp,-16
 134:	e422                	sd	s0,8(sp)
 136:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 138:	0ff0000f          	fence
 13c:	6108                	ld	a0,0(a0)
 13e:	0ff0000f          	fence
}
 142:	2501                	sext.w	a0,a0
 144:	6422                	ld	s0,8(sp)
 146:	0141                	addi	sp,sp,16
 148:	8082                	ret

000000000000014a <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 14a:	7179                	addi	sp,sp,-48
 14c:	f406                	sd	ra,40(sp)
 14e:	f022                	sd	s0,32(sp)
 150:	ec26                	sd	s1,24(sp)
 152:	e84a                	sd	s2,16(sp)
 154:	e44e                	sd	s3,8(sp)
 156:	e052                	sd	s4,0(sp)
 158:	1800                	addi	s0,sp,48
 15a:	8a2a                	mv	s4,a0
 15c:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 15e:	4785                	li	a5,1
 160:	00001497          	auipc	s1,0x1
 164:	c0048493          	addi	s1,s1,-1024 # d60 <rings+0x10>
 168:	00001917          	auipc	s2,0x1
 16c:	ce890913          	addi	s2,s2,-792 # e50 <__BSS_END__>
 170:	04f59563          	bne	a1,a5,1ba <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 174:	00001497          	auipc	s1,0x1
 178:	bec4a483          	lw	s1,-1044(s1) # d60 <rings+0x10>
 17c:	c099                	beqz	s1,182 <create_or_close_the_buffer_user+0x38>
 17e:	4481                	li	s1,0
 180:	a899                	j	1d6 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 182:	00001917          	auipc	s2,0x1
 186:	bce90913          	addi	s2,s2,-1074 # d50 <rings>
 18a:	00093603          	ld	a2,0(s2)
 18e:	4585                	li	a1,1
 190:	00000097          	auipc	ra,0x0
 194:	4c6080e7          	jalr	1222(ra) # 656 <ringbuf>
        rings[i].book->write_done = 0;
 198:	00893783          	ld	a5,8(s2)
 19c:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 1a0:	00893783          	ld	a5,8(s2)
 1a4:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 1a8:	01092783          	lw	a5,16(s2)
 1ac:	2785                	addiw	a5,a5,1
 1ae:	00f92823          	sw	a5,16(s2)
        break;
 1b2:	a015                	j	1d6 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 1b4:	04e1                	addi	s1,s1,24
 1b6:	01248f63          	beq	s1,s2,1d4 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 1ba:	409c                	lw	a5,0(s1)
 1bc:	dfe5                	beqz	a5,1b4 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 1be:	ff04b603          	ld	a2,-16(s1)
 1c2:	85ce                	mv	a1,s3
 1c4:	8552                	mv	a0,s4
 1c6:	00000097          	auipc	ra,0x0
 1ca:	490080e7          	jalr	1168(ra) # 656 <ringbuf>
        rings[i].exists = 0;
 1ce:	0004a023          	sw	zero,0(s1)
 1d2:	b7cd                	j	1b4 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 1d4:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 1d6:	8526                	mv	a0,s1
 1d8:	70a2                	ld	ra,40(sp)
 1da:	7402                	ld	s0,32(sp)
 1dc:	64e2                	ld	s1,24(sp)
 1de:	6942                	ld	s2,16(sp)
 1e0:	69a2                	ld	s3,8(sp)
 1e2:	6a02                	ld	s4,0(sp)
 1e4:	6145                	addi	sp,sp,48
 1e6:	8082                	ret

00000000000001e8 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 1e8:	1101                	addi	sp,sp,-32
 1ea:	ec06                	sd	ra,24(sp)
 1ec:	e822                	sd	s0,16(sp)
 1ee:	e426                	sd	s1,8(sp)
 1f0:	1000                	addi	s0,sp,32
 1f2:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 1f4:	00151793          	slli	a5,a0,0x1
 1f8:	97aa                	add	a5,a5,a0
 1fa:	078e                	slli	a5,a5,0x3
 1fc:	00001717          	auipc	a4,0x1
 200:	b5470713          	addi	a4,a4,-1196 # d50 <rings>
 204:	97ba                	add	a5,a5,a4
 206:	639c                	ld	a5,0(a5)
 208:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 20a:	421c                	lw	a5,0(a2)
 20c:	e785                	bnez	a5,234 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 20e:	86ba                	mv	a3,a4
 210:	671c                	ld	a5,8(a4)
 212:	6398                	ld	a4,0(a5)
 214:	67c1                	lui	a5,0x10
 216:	9fb9                	addw	a5,a5,a4
 218:	00151713          	slli	a4,a0,0x1
 21c:	953a                	add	a0,a0,a4
 21e:	050e                	slli	a0,a0,0x3
 220:	9536                	add	a0,a0,a3
 222:	6518                	ld	a4,8(a0)
 224:	6718                	ld	a4,8(a4)
 226:	9f99                	subw	a5,a5,a4
 228:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 22a:	60e2                	ld	ra,24(sp)
 22c:	6442                	ld	s0,16(sp)
 22e:	64a2                	ld	s1,8(sp)
 230:	6105                	addi	sp,sp,32
 232:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 234:	00151793          	slli	a5,a0,0x1
 238:	953e                	add	a0,a0,a5
 23a:	050e                	slli	a0,a0,0x3
 23c:	00001797          	auipc	a5,0x1
 240:	b1478793          	addi	a5,a5,-1260 # d50 <rings>
 244:	953e                	add	a0,a0,a5
 246:	6508                	ld	a0,8(a0)
 248:	0521                	addi	a0,a0,8
 24a:	00000097          	auipc	ra,0x0
 24e:	ee8080e7          	jalr	-280(ra) # 132 <load>
 252:	c088                	sw	a0,0(s1)
}
 254:	bfd9                	j	22a <ringbuf_start_write+0x42>

0000000000000256 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 256:	1141                	addi	sp,sp,-16
 258:	e406                	sd	ra,8(sp)
 25a:	e022                	sd	s0,0(sp)
 25c:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 25e:	00151793          	slli	a5,a0,0x1
 262:	97aa                	add	a5,a5,a0
 264:	078e                	slli	a5,a5,0x3
 266:	00001517          	auipc	a0,0x1
 26a:	aea50513          	addi	a0,a0,-1302 # d50 <rings>
 26e:	97aa                	add	a5,a5,a0
 270:	6788                	ld	a0,8(a5)
 272:	0035959b          	slliw	a1,a1,0x3
 276:	0521                	addi	a0,a0,8
 278:	00000097          	auipc	ra,0x0
 27c:	ea6080e7          	jalr	-346(ra) # 11e <store>
}
 280:	60a2                	ld	ra,8(sp)
 282:	6402                	ld	s0,0(sp)
 284:	0141                	addi	sp,sp,16
 286:	8082                	ret

0000000000000288 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 288:	1101                	addi	sp,sp,-32
 28a:	ec06                	sd	ra,24(sp)
 28c:	e822                	sd	s0,16(sp)
 28e:	e426                	sd	s1,8(sp)
 290:	1000                	addi	s0,sp,32
 292:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 294:	00151793          	slli	a5,a0,0x1
 298:	97aa                	add	a5,a5,a0
 29a:	078e                	slli	a5,a5,0x3
 29c:	00001517          	auipc	a0,0x1
 2a0:	ab450513          	addi	a0,a0,-1356 # d50 <rings>
 2a4:	97aa                	add	a5,a5,a0
 2a6:	6788                	ld	a0,8(a5)
 2a8:	0521                	addi	a0,a0,8
 2aa:	00000097          	auipc	ra,0x0
 2ae:	e88080e7          	jalr	-376(ra) # 132 <load>
 2b2:	c088                	sw	a0,0(s1)
}
 2b4:	60e2                	ld	ra,24(sp)
 2b6:	6442                	ld	s0,16(sp)
 2b8:	64a2                	ld	s1,8(sp)
 2ba:	6105                	addi	sp,sp,32
 2bc:	8082                	ret

00000000000002be <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 2be:	1101                	addi	sp,sp,-32
 2c0:	ec06                	sd	ra,24(sp)
 2c2:	e822                	sd	s0,16(sp)
 2c4:	e426                	sd	s1,8(sp)
 2c6:	1000                	addi	s0,sp,32
 2c8:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 2ca:	00151793          	slli	a5,a0,0x1
 2ce:	97aa                	add	a5,a5,a0
 2d0:	078e                	slli	a5,a5,0x3
 2d2:	00001517          	auipc	a0,0x1
 2d6:	a7e50513          	addi	a0,a0,-1410 # d50 <rings>
 2da:	97aa                	add	a5,a5,a0
 2dc:	6788                	ld	a0,8(a5)
 2de:	611c                	ld	a5,0(a0)
 2e0:	ef99                	bnez	a5,2fe <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2e2:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2e4:	41f7579b          	sraiw	a5,a4,0x1f
 2e8:	01d7d79b          	srliw	a5,a5,0x1d
 2ec:	9fb9                	addw	a5,a5,a4
 2ee:	4037d79b          	sraiw	a5,a5,0x3
 2f2:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 2f4:	60e2                	ld	ra,24(sp)
 2f6:	6442                	ld	s0,16(sp)
 2f8:	64a2                	ld	s1,8(sp)
 2fa:	6105                	addi	sp,sp,32
 2fc:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 2fe:	00000097          	auipc	ra,0x0
 302:	e34080e7          	jalr	-460(ra) # 132 <load>
    *bytes /= 8;
 306:	41f5579b          	sraiw	a5,a0,0x1f
 30a:	01d7d79b          	srliw	a5,a5,0x1d
 30e:	9d3d                	addw	a0,a0,a5
 310:	4035551b          	sraiw	a0,a0,0x3
 314:	c088                	sw	a0,0(s1)
}
 316:	bff9                	j	2f4 <ringbuf_start_read+0x36>

0000000000000318 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 318:	1141                	addi	sp,sp,-16
 31a:	e406                	sd	ra,8(sp)
 31c:	e022                	sd	s0,0(sp)
 31e:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 320:	00151793          	slli	a5,a0,0x1
 324:	97aa                	add	a5,a5,a0
 326:	078e                	slli	a5,a5,0x3
 328:	00001517          	auipc	a0,0x1
 32c:	a2850513          	addi	a0,a0,-1496 # d50 <rings>
 330:	97aa                	add	a5,a5,a0
 332:	0035959b          	slliw	a1,a1,0x3
 336:	6788                	ld	a0,8(a5)
 338:	00000097          	auipc	ra,0x0
 33c:	de6080e7          	jalr	-538(ra) # 11e <store>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 348:	1141                	addi	sp,sp,-16
 34a:	e422                	sd	s0,8(sp)
 34c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 34e:	87aa                	mv	a5,a0
 350:	0585                	addi	a1,a1,1
 352:	0785                	addi	a5,a5,1
 354:	fff5c703          	lbu	a4,-1(a1)
 358:	fee78fa3          	sb	a4,-1(a5)
 35c:	fb75                	bnez	a4,350 <strcpy+0x8>
    ;
  return os;
}
 35e:	6422                	ld	s0,8(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 364:	1141                	addi	sp,sp,-16
 366:	e422                	sd	s0,8(sp)
 368:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 36a:	00054783          	lbu	a5,0(a0)
 36e:	cb91                	beqz	a5,382 <strcmp+0x1e>
 370:	0005c703          	lbu	a4,0(a1)
 374:	00f71763          	bne	a4,a5,382 <strcmp+0x1e>
    p++, q++;
 378:	0505                	addi	a0,a0,1
 37a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 37c:	00054783          	lbu	a5,0(a0)
 380:	fbe5                	bnez	a5,370 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 382:	0005c503          	lbu	a0,0(a1)
}
 386:	40a7853b          	subw	a0,a5,a0
 38a:	6422                	ld	s0,8(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <strlen>:

uint
strlen(const char *s)
{
 390:	1141                	addi	sp,sp,-16
 392:	e422                	sd	s0,8(sp)
 394:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 396:	00054783          	lbu	a5,0(a0)
 39a:	cf91                	beqz	a5,3b6 <strlen+0x26>
 39c:	0505                	addi	a0,a0,1
 39e:	87aa                	mv	a5,a0
 3a0:	4685                	li	a3,1
 3a2:	9e89                	subw	a3,a3,a0
 3a4:	00f6853b          	addw	a0,a3,a5
 3a8:	0785                	addi	a5,a5,1
 3aa:	fff7c703          	lbu	a4,-1(a5)
 3ae:	fb7d                	bnez	a4,3a4 <strlen+0x14>
    ;
  return n;
}
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret
  for(n = 0; s[n]; n++)
 3b6:	4501                	li	a0,0
 3b8:	bfe5                	j	3b0 <strlen+0x20>

00000000000003ba <memset>:

void*
memset(void *dst, int c, uint n)
{
 3ba:	1141                	addi	sp,sp,-16
 3bc:	e422                	sd	s0,8(sp)
 3be:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3c0:	ca19                	beqz	a2,3d6 <memset+0x1c>
 3c2:	87aa                	mv	a5,a0
 3c4:	1602                	slli	a2,a2,0x20
 3c6:	9201                	srli	a2,a2,0x20
 3c8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3cc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3d0:	0785                	addi	a5,a5,1
 3d2:	fee79de3          	bne	a5,a4,3cc <memset+0x12>
  }
  return dst;
}
 3d6:	6422                	ld	s0,8(sp)
 3d8:	0141                	addi	sp,sp,16
 3da:	8082                	ret

00000000000003dc <strchr>:

char*
strchr(const char *s, char c)
{
 3dc:	1141                	addi	sp,sp,-16
 3de:	e422                	sd	s0,8(sp)
 3e0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3e2:	00054783          	lbu	a5,0(a0)
 3e6:	cb99                	beqz	a5,3fc <strchr+0x20>
    if(*s == c)
 3e8:	00f58763          	beq	a1,a5,3f6 <strchr+0x1a>
  for(; *s; s++)
 3ec:	0505                	addi	a0,a0,1
 3ee:	00054783          	lbu	a5,0(a0)
 3f2:	fbfd                	bnez	a5,3e8 <strchr+0xc>
      return (char*)s;
  return 0;
 3f4:	4501                	li	a0,0
}
 3f6:	6422                	ld	s0,8(sp)
 3f8:	0141                	addi	sp,sp,16
 3fa:	8082                	ret
  return 0;
 3fc:	4501                	li	a0,0
 3fe:	bfe5                	j	3f6 <strchr+0x1a>

0000000000000400 <gets>:

char*
gets(char *buf, int max)
{
 400:	711d                	addi	sp,sp,-96
 402:	ec86                	sd	ra,88(sp)
 404:	e8a2                	sd	s0,80(sp)
 406:	e4a6                	sd	s1,72(sp)
 408:	e0ca                	sd	s2,64(sp)
 40a:	fc4e                	sd	s3,56(sp)
 40c:	f852                	sd	s4,48(sp)
 40e:	f456                	sd	s5,40(sp)
 410:	f05a                	sd	s6,32(sp)
 412:	ec5e                	sd	s7,24(sp)
 414:	1080                	addi	s0,sp,96
 416:	8baa                	mv	s7,a0
 418:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 41a:	892a                	mv	s2,a0
 41c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 41e:	4aa9                	li	s5,10
 420:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 422:	89a6                	mv	s3,s1
 424:	2485                	addiw	s1,s1,1
 426:	0344d863          	bge	s1,s4,456 <gets+0x56>
    cc = read(0, &c, 1);
 42a:	4605                	li	a2,1
 42c:	faf40593          	addi	a1,s0,-81
 430:	4501                	li	a0,0
 432:	00000097          	auipc	ra,0x0
 436:	19c080e7          	jalr	412(ra) # 5ce <read>
    if(cc < 1)
 43a:	00a05e63          	blez	a0,456 <gets+0x56>
    buf[i++] = c;
 43e:	faf44783          	lbu	a5,-81(s0)
 442:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 446:	01578763          	beq	a5,s5,454 <gets+0x54>
 44a:	0905                	addi	s2,s2,1
 44c:	fd679be3          	bne	a5,s6,422 <gets+0x22>
  for(i=0; i+1 < max; ){
 450:	89a6                	mv	s3,s1
 452:	a011                	j	456 <gets+0x56>
 454:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 456:	99de                	add	s3,s3,s7
 458:	00098023          	sb	zero,0(s3)
  return buf;
}
 45c:	855e                	mv	a0,s7
 45e:	60e6                	ld	ra,88(sp)
 460:	6446                	ld	s0,80(sp)
 462:	64a6                	ld	s1,72(sp)
 464:	6906                	ld	s2,64(sp)
 466:	79e2                	ld	s3,56(sp)
 468:	7a42                	ld	s4,48(sp)
 46a:	7aa2                	ld	s5,40(sp)
 46c:	7b02                	ld	s6,32(sp)
 46e:	6be2                	ld	s7,24(sp)
 470:	6125                	addi	sp,sp,96
 472:	8082                	ret

0000000000000474 <stat>:

int
stat(const char *n, struct stat *st)
{
 474:	1101                	addi	sp,sp,-32
 476:	ec06                	sd	ra,24(sp)
 478:	e822                	sd	s0,16(sp)
 47a:	e426                	sd	s1,8(sp)
 47c:	e04a                	sd	s2,0(sp)
 47e:	1000                	addi	s0,sp,32
 480:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 482:	4581                	li	a1,0
 484:	00000097          	auipc	ra,0x0
 488:	172080e7          	jalr	370(ra) # 5f6 <open>
  if(fd < 0)
 48c:	02054563          	bltz	a0,4b6 <stat+0x42>
 490:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 492:	85ca                	mv	a1,s2
 494:	00000097          	auipc	ra,0x0
 498:	17a080e7          	jalr	378(ra) # 60e <fstat>
 49c:	892a                	mv	s2,a0
  close(fd);
 49e:	8526                	mv	a0,s1
 4a0:	00000097          	auipc	ra,0x0
 4a4:	13e080e7          	jalr	318(ra) # 5de <close>
  return r;
}
 4a8:	854a                	mv	a0,s2
 4aa:	60e2                	ld	ra,24(sp)
 4ac:	6442                	ld	s0,16(sp)
 4ae:	64a2                	ld	s1,8(sp)
 4b0:	6902                	ld	s2,0(sp)
 4b2:	6105                	addi	sp,sp,32
 4b4:	8082                	ret
    return -1;
 4b6:	597d                	li	s2,-1
 4b8:	bfc5                	j	4a8 <stat+0x34>

00000000000004ba <atoi>:

int
atoi(const char *s)
{
 4ba:	1141                	addi	sp,sp,-16
 4bc:	e422                	sd	s0,8(sp)
 4be:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4c0:	00054603          	lbu	a2,0(a0)
 4c4:	fd06079b          	addiw	a5,a2,-48
 4c8:	0ff7f793          	zext.b	a5,a5
 4cc:	4725                	li	a4,9
 4ce:	02f76963          	bltu	a4,a5,500 <atoi+0x46>
 4d2:	86aa                	mv	a3,a0
  n = 0;
 4d4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4d6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4d8:	0685                	addi	a3,a3,1
 4da:	0025179b          	slliw	a5,a0,0x2
 4de:	9fa9                	addw	a5,a5,a0
 4e0:	0017979b          	slliw	a5,a5,0x1
 4e4:	9fb1                	addw	a5,a5,a2
 4e6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 4ea:	0006c603          	lbu	a2,0(a3)
 4ee:	fd06071b          	addiw	a4,a2,-48
 4f2:	0ff77713          	zext.b	a4,a4
 4f6:	fee5f1e3          	bgeu	a1,a4,4d8 <atoi+0x1e>
  return n;
}
 4fa:	6422                	ld	s0,8(sp)
 4fc:	0141                	addi	sp,sp,16
 4fe:	8082                	ret
  n = 0;
 500:	4501                	li	a0,0
 502:	bfe5                	j	4fa <atoi+0x40>

0000000000000504 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 504:	1141                	addi	sp,sp,-16
 506:	e422                	sd	s0,8(sp)
 508:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 50a:	02b57463          	bgeu	a0,a1,532 <memmove+0x2e>
    while(n-- > 0)
 50e:	00c05f63          	blez	a2,52c <memmove+0x28>
 512:	1602                	slli	a2,a2,0x20
 514:	9201                	srli	a2,a2,0x20
 516:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 51a:	872a                	mv	a4,a0
      *dst++ = *src++;
 51c:	0585                	addi	a1,a1,1
 51e:	0705                	addi	a4,a4,1
 520:	fff5c683          	lbu	a3,-1(a1)
 524:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 528:	fee79ae3          	bne	a5,a4,51c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 52c:	6422                	ld	s0,8(sp)
 52e:	0141                	addi	sp,sp,16
 530:	8082                	ret
    dst += n;
 532:	00c50733          	add	a4,a0,a2
    src += n;
 536:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 538:	fec05ae3          	blez	a2,52c <memmove+0x28>
 53c:	fff6079b          	addiw	a5,a2,-1
 540:	1782                	slli	a5,a5,0x20
 542:	9381                	srli	a5,a5,0x20
 544:	fff7c793          	not	a5,a5
 548:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 54a:	15fd                	addi	a1,a1,-1
 54c:	177d                	addi	a4,a4,-1
 54e:	0005c683          	lbu	a3,0(a1)
 552:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 556:	fee79ae3          	bne	a5,a4,54a <memmove+0x46>
 55a:	bfc9                	j	52c <memmove+0x28>

000000000000055c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 55c:	1141                	addi	sp,sp,-16
 55e:	e422                	sd	s0,8(sp)
 560:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 562:	ca05                	beqz	a2,592 <memcmp+0x36>
 564:	fff6069b          	addiw	a3,a2,-1
 568:	1682                	slli	a3,a3,0x20
 56a:	9281                	srli	a3,a3,0x20
 56c:	0685                	addi	a3,a3,1
 56e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 570:	00054783          	lbu	a5,0(a0)
 574:	0005c703          	lbu	a4,0(a1)
 578:	00e79863          	bne	a5,a4,588 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 57c:	0505                	addi	a0,a0,1
    p2++;
 57e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 580:	fed518e3          	bne	a0,a3,570 <memcmp+0x14>
  }
  return 0;
 584:	4501                	li	a0,0
 586:	a019                	j	58c <memcmp+0x30>
      return *p1 - *p2;
 588:	40e7853b          	subw	a0,a5,a4
}
 58c:	6422                	ld	s0,8(sp)
 58e:	0141                	addi	sp,sp,16
 590:	8082                	ret
  return 0;
 592:	4501                	li	a0,0
 594:	bfe5                	j	58c <memcmp+0x30>

0000000000000596 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 596:	1141                	addi	sp,sp,-16
 598:	e406                	sd	ra,8(sp)
 59a:	e022                	sd	s0,0(sp)
 59c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 59e:	00000097          	auipc	ra,0x0
 5a2:	f66080e7          	jalr	-154(ra) # 504 <memmove>
}
 5a6:	60a2                	ld	ra,8(sp)
 5a8:	6402                	ld	s0,0(sp)
 5aa:	0141                	addi	sp,sp,16
 5ac:	8082                	ret

00000000000005ae <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5ae:	4885                	li	a7,1
 ecall
 5b0:	00000073          	ecall
 ret
 5b4:	8082                	ret

00000000000005b6 <exit>:
.global exit
exit:
 li a7, SYS_exit
 5b6:	4889                	li	a7,2
 ecall
 5b8:	00000073          	ecall
 ret
 5bc:	8082                	ret

00000000000005be <wait>:
.global wait
wait:
 li a7, SYS_wait
 5be:	488d                	li	a7,3
 ecall
 5c0:	00000073          	ecall
 ret
 5c4:	8082                	ret

00000000000005c6 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5c6:	4891                	li	a7,4
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <read>:
.global read
read:
 li a7, SYS_read
 5ce:	4895                	li	a7,5
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <write>:
.global write
write:
 li a7, SYS_write
 5d6:	48c1                	li	a7,16
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <close>:
.global close
close:
 li a7, SYS_close
 5de:	48d5                	li	a7,21
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <kill>:
.global kill
kill:
 li a7, SYS_kill
 5e6:	4899                	li	a7,6
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <exec>:
.global exec
exec:
 li a7, SYS_exec
 5ee:	489d                	li	a7,7
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <open>:
.global open
open:
 li a7, SYS_open
 5f6:	48bd                	li	a7,15
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 5fe:	48c5                	li	a7,17
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 606:	48c9                	li	a7,18
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 60e:	48a1                	li	a7,8
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <link>:
.global link
link:
 li a7, SYS_link
 616:	48cd                	li	a7,19
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 61e:	48d1                	li	a7,20
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 626:	48a5                	li	a7,9
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <dup>:
.global dup
dup:
 li a7, SYS_dup
 62e:	48a9                	li	a7,10
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 636:	48ad                	li	a7,11
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 63e:	48b1                	li	a7,12
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 646:	48b5                	li	a7,13
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 64e:	48b9                	li	a7,14
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 656:	48d9                	li	a7,22
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 65e:	1101                	addi	sp,sp,-32
 660:	ec06                	sd	ra,24(sp)
 662:	e822                	sd	s0,16(sp)
 664:	1000                	addi	s0,sp,32
 666:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 66a:	4605                	li	a2,1
 66c:	fef40593          	addi	a1,s0,-17
 670:	00000097          	auipc	ra,0x0
 674:	f66080e7          	jalr	-154(ra) # 5d6 <write>
}
 678:	60e2                	ld	ra,24(sp)
 67a:	6442                	ld	s0,16(sp)
 67c:	6105                	addi	sp,sp,32
 67e:	8082                	ret

0000000000000680 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 680:	7139                	addi	sp,sp,-64
 682:	fc06                	sd	ra,56(sp)
 684:	f822                	sd	s0,48(sp)
 686:	f426                	sd	s1,40(sp)
 688:	f04a                	sd	s2,32(sp)
 68a:	ec4e                	sd	s3,24(sp)
 68c:	0080                	addi	s0,sp,64
 68e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 690:	c299                	beqz	a3,696 <printint+0x16>
 692:	0805c863          	bltz	a1,722 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 696:	2581                	sext.w	a1,a1
  neg = 0;
 698:	4881                	li	a7,0
 69a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 69e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6a0:	2601                	sext.w	a2,a2
 6a2:	00000517          	auipc	a0,0x0
 6a6:	48e50513          	addi	a0,a0,1166 # b30 <digits>
 6aa:	883a                	mv	a6,a4
 6ac:	2705                	addiw	a4,a4,1
 6ae:	02c5f7bb          	remuw	a5,a1,a2
 6b2:	1782                	slli	a5,a5,0x20
 6b4:	9381                	srli	a5,a5,0x20
 6b6:	97aa                	add	a5,a5,a0
 6b8:	0007c783          	lbu	a5,0(a5)
 6bc:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6c0:	0005879b          	sext.w	a5,a1
 6c4:	02c5d5bb          	divuw	a1,a1,a2
 6c8:	0685                	addi	a3,a3,1
 6ca:	fec7f0e3          	bgeu	a5,a2,6aa <printint+0x2a>
  if(neg)
 6ce:	00088b63          	beqz	a7,6e4 <printint+0x64>
    buf[i++] = '-';
 6d2:	fd040793          	addi	a5,s0,-48
 6d6:	973e                	add	a4,a4,a5
 6d8:	02d00793          	li	a5,45
 6dc:	fef70823          	sb	a5,-16(a4)
 6e0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6e4:	02e05863          	blez	a4,714 <printint+0x94>
 6e8:	fc040793          	addi	a5,s0,-64
 6ec:	00e78933          	add	s2,a5,a4
 6f0:	fff78993          	addi	s3,a5,-1
 6f4:	99ba                	add	s3,s3,a4
 6f6:	377d                	addiw	a4,a4,-1
 6f8:	1702                	slli	a4,a4,0x20
 6fa:	9301                	srli	a4,a4,0x20
 6fc:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 700:	fff94583          	lbu	a1,-1(s2)
 704:	8526                	mv	a0,s1
 706:	00000097          	auipc	ra,0x0
 70a:	f58080e7          	jalr	-168(ra) # 65e <putc>
  while(--i >= 0)
 70e:	197d                	addi	s2,s2,-1
 710:	ff3918e3          	bne	s2,s3,700 <printint+0x80>
}
 714:	70e2                	ld	ra,56(sp)
 716:	7442                	ld	s0,48(sp)
 718:	74a2                	ld	s1,40(sp)
 71a:	7902                	ld	s2,32(sp)
 71c:	69e2                	ld	s3,24(sp)
 71e:	6121                	addi	sp,sp,64
 720:	8082                	ret
    x = -xx;
 722:	40b005bb          	negw	a1,a1
    neg = 1;
 726:	4885                	li	a7,1
    x = -xx;
 728:	bf8d                	j	69a <printint+0x1a>

000000000000072a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 72a:	7119                	addi	sp,sp,-128
 72c:	fc86                	sd	ra,120(sp)
 72e:	f8a2                	sd	s0,112(sp)
 730:	f4a6                	sd	s1,104(sp)
 732:	f0ca                	sd	s2,96(sp)
 734:	ecce                	sd	s3,88(sp)
 736:	e8d2                	sd	s4,80(sp)
 738:	e4d6                	sd	s5,72(sp)
 73a:	e0da                	sd	s6,64(sp)
 73c:	fc5e                	sd	s7,56(sp)
 73e:	f862                	sd	s8,48(sp)
 740:	f466                	sd	s9,40(sp)
 742:	f06a                	sd	s10,32(sp)
 744:	ec6e                	sd	s11,24(sp)
 746:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 748:	0005c903          	lbu	s2,0(a1)
 74c:	18090f63          	beqz	s2,8ea <vprintf+0x1c0>
 750:	8aaa                	mv	s5,a0
 752:	8b32                	mv	s6,a2
 754:	00158493          	addi	s1,a1,1
  state = 0;
 758:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 75a:	02500a13          	li	s4,37
      if(c == 'd'){
 75e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 762:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 766:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 76a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76e:	00000b97          	auipc	s7,0x0
 772:	3c2b8b93          	addi	s7,s7,962 # b30 <digits>
 776:	a839                	j	794 <vprintf+0x6a>
        putc(fd, c);
 778:	85ca                	mv	a1,s2
 77a:	8556                	mv	a0,s5
 77c:	00000097          	auipc	ra,0x0
 780:	ee2080e7          	jalr	-286(ra) # 65e <putc>
 784:	a019                	j	78a <vprintf+0x60>
    } else if(state == '%'){
 786:	01498f63          	beq	s3,s4,7a4 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 78a:	0485                	addi	s1,s1,1
 78c:	fff4c903          	lbu	s2,-1(s1)
 790:	14090d63          	beqz	s2,8ea <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 794:	0009079b          	sext.w	a5,s2
    if(state == 0){
 798:	fe0997e3          	bnez	s3,786 <vprintf+0x5c>
      if(c == '%'){
 79c:	fd479ee3          	bne	a5,s4,778 <vprintf+0x4e>
        state = '%';
 7a0:	89be                	mv	s3,a5
 7a2:	b7e5                	j	78a <vprintf+0x60>
      if(c == 'd'){
 7a4:	05878063          	beq	a5,s8,7e4 <vprintf+0xba>
      } else if(c == 'l') {
 7a8:	05978c63          	beq	a5,s9,800 <vprintf+0xd6>
      } else if(c == 'x') {
 7ac:	07a78863          	beq	a5,s10,81c <vprintf+0xf2>
      } else if(c == 'p') {
 7b0:	09b78463          	beq	a5,s11,838 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7b4:	07300713          	li	a4,115
 7b8:	0ce78663          	beq	a5,a4,884 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7bc:	06300713          	li	a4,99
 7c0:	0ee78e63          	beq	a5,a4,8bc <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7c4:	11478863          	beq	a5,s4,8d4 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7c8:	85d2                	mv	a1,s4
 7ca:	8556                	mv	a0,s5
 7cc:	00000097          	auipc	ra,0x0
 7d0:	e92080e7          	jalr	-366(ra) # 65e <putc>
        putc(fd, c);
 7d4:	85ca                	mv	a1,s2
 7d6:	8556                	mv	a0,s5
 7d8:	00000097          	auipc	ra,0x0
 7dc:	e86080e7          	jalr	-378(ra) # 65e <putc>
      }
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	b765                	j	78a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7e4:	008b0913          	addi	s2,s6,8
 7e8:	4685                	li	a3,1
 7ea:	4629                	li	a2,10
 7ec:	000b2583          	lw	a1,0(s6)
 7f0:	8556                	mv	a0,s5
 7f2:	00000097          	auipc	ra,0x0
 7f6:	e8e080e7          	jalr	-370(ra) # 680 <printint>
 7fa:	8b4a                	mv	s6,s2
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	b771                	j	78a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 800:	008b0913          	addi	s2,s6,8
 804:	4681                	li	a3,0
 806:	4629                	li	a2,10
 808:	000b2583          	lw	a1,0(s6)
 80c:	8556                	mv	a0,s5
 80e:	00000097          	auipc	ra,0x0
 812:	e72080e7          	jalr	-398(ra) # 680 <printint>
 816:	8b4a                	mv	s6,s2
      state = 0;
 818:	4981                	li	s3,0
 81a:	bf85                	j	78a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 81c:	008b0913          	addi	s2,s6,8
 820:	4681                	li	a3,0
 822:	4641                	li	a2,16
 824:	000b2583          	lw	a1,0(s6)
 828:	8556                	mv	a0,s5
 82a:	00000097          	auipc	ra,0x0
 82e:	e56080e7          	jalr	-426(ra) # 680 <printint>
 832:	8b4a                	mv	s6,s2
      state = 0;
 834:	4981                	li	s3,0
 836:	bf91                	j	78a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 838:	008b0793          	addi	a5,s6,8
 83c:	f8f43423          	sd	a5,-120(s0)
 840:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 844:	03000593          	li	a1,48
 848:	8556                	mv	a0,s5
 84a:	00000097          	auipc	ra,0x0
 84e:	e14080e7          	jalr	-492(ra) # 65e <putc>
  putc(fd, 'x');
 852:	85ea                	mv	a1,s10
 854:	8556                	mv	a0,s5
 856:	00000097          	auipc	ra,0x0
 85a:	e08080e7          	jalr	-504(ra) # 65e <putc>
 85e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 860:	03c9d793          	srli	a5,s3,0x3c
 864:	97de                	add	a5,a5,s7
 866:	0007c583          	lbu	a1,0(a5)
 86a:	8556                	mv	a0,s5
 86c:	00000097          	auipc	ra,0x0
 870:	df2080e7          	jalr	-526(ra) # 65e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 874:	0992                	slli	s3,s3,0x4
 876:	397d                	addiw	s2,s2,-1
 878:	fe0914e3          	bnez	s2,860 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 87c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 880:	4981                	li	s3,0
 882:	b721                	j	78a <vprintf+0x60>
        s = va_arg(ap, char*);
 884:	008b0993          	addi	s3,s6,8
 888:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 88c:	02090163          	beqz	s2,8ae <vprintf+0x184>
        while(*s != 0){
 890:	00094583          	lbu	a1,0(s2)
 894:	c9a1                	beqz	a1,8e4 <vprintf+0x1ba>
          putc(fd, *s);
 896:	8556                	mv	a0,s5
 898:	00000097          	auipc	ra,0x0
 89c:	dc6080e7          	jalr	-570(ra) # 65e <putc>
          s++;
 8a0:	0905                	addi	s2,s2,1
        while(*s != 0){
 8a2:	00094583          	lbu	a1,0(s2)
 8a6:	f9e5                	bnez	a1,896 <vprintf+0x16c>
        s = va_arg(ap, char*);
 8a8:	8b4e                	mv	s6,s3
      state = 0;
 8aa:	4981                	li	s3,0
 8ac:	bdf9                	j	78a <vprintf+0x60>
          s = "(null)";
 8ae:	00000917          	auipc	s2,0x0
 8b2:	27a90913          	addi	s2,s2,634 # b28 <malloc+0x134>
        while(*s != 0){
 8b6:	02800593          	li	a1,40
 8ba:	bff1                	j	896 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8bc:	008b0913          	addi	s2,s6,8
 8c0:	000b4583          	lbu	a1,0(s6)
 8c4:	8556                	mv	a0,s5
 8c6:	00000097          	auipc	ra,0x0
 8ca:	d98080e7          	jalr	-616(ra) # 65e <putc>
 8ce:	8b4a                	mv	s6,s2
      state = 0;
 8d0:	4981                	li	s3,0
 8d2:	bd65                	j	78a <vprintf+0x60>
        putc(fd, c);
 8d4:	85d2                	mv	a1,s4
 8d6:	8556                	mv	a0,s5
 8d8:	00000097          	auipc	ra,0x0
 8dc:	d86080e7          	jalr	-634(ra) # 65e <putc>
      state = 0;
 8e0:	4981                	li	s3,0
 8e2:	b565                	j	78a <vprintf+0x60>
        s = va_arg(ap, char*);
 8e4:	8b4e                	mv	s6,s3
      state = 0;
 8e6:	4981                	li	s3,0
 8e8:	b54d                	j	78a <vprintf+0x60>
    }
  }
}
 8ea:	70e6                	ld	ra,120(sp)
 8ec:	7446                	ld	s0,112(sp)
 8ee:	74a6                	ld	s1,104(sp)
 8f0:	7906                	ld	s2,96(sp)
 8f2:	69e6                	ld	s3,88(sp)
 8f4:	6a46                	ld	s4,80(sp)
 8f6:	6aa6                	ld	s5,72(sp)
 8f8:	6b06                	ld	s6,64(sp)
 8fa:	7be2                	ld	s7,56(sp)
 8fc:	7c42                	ld	s8,48(sp)
 8fe:	7ca2                	ld	s9,40(sp)
 900:	7d02                	ld	s10,32(sp)
 902:	6de2                	ld	s11,24(sp)
 904:	6109                	addi	sp,sp,128
 906:	8082                	ret

0000000000000908 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 908:	715d                	addi	sp,sp,-80
 90a:	ec06                	sd	ra,24(sp)
 90c:	e822                	sd	s0,16(sp)
 90e:	1000                	addi	s0,sp,32
 910:	e010                	sd	a2,0(s0)
 912:	e414                	sd	a3,8(s0)
 914:	e818                	sd	a4,16(s0)
 916:	ec1c                	sd	a5,24(s0)
 918:	03043023          	sd	a6,32(s0)
 91c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 920:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 924:	8622                	mv	a2,s0
 926:	00000097          	auipc	ra,0x0
 92a:	e04080e7          	jalr	-508(ra) # 72a <vprintf>
}
 92e:	60e2                	ld	ra,24(sp)
 930:	6442                	ld	s0,16(sp)
 932:	6161                	addi	sp,sp,80
 934:	8082                	ret

0000000000000936 <printf>:

void
printf(const char *fmt, ...)
{
 936:	711d                	addi	sp,sp,-96
 938:	ec06                	sd	ra,24(sp)
 93a:	e822                	sd	s0,16(sp)
 93c:	1000                	addi	s0,sp,32
 93e:	e40c                	sd	a1,8(s0)
 940:	e810                	sd	a2,16(s0)
 942:	ec14                	sd	a3,24(s0)
 944:	f018                	sd	a4,32(s0)
 946:	f41c                	sd	a5,40(s0)
 948:	03043823          	sd	a6,48(s0)
 94c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 950:	00840613          	addi	a2,s0,8
 954:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 958:	85aa                	mv	a1,a0
 95a:	4505                	li	a0,1
 95c:	00000097          	auipc	ra,0x0
 960:	dce080e7          	jalr	-562(ra) # 72a <vprintf>
}
 964:	60e2                	ld	ra,24(sp)
 966:	6442                	ld	s0,16(sp)
 968:	6125                	addi	sp,sp,96
 96a:	8082                	ret

000000000000096c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 96c:	1141                	addi	sp,sp,-16
 96e:	e422                	sd	s0,8(sp)
 970:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 972:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 976:	00000797          	auipc	a5,0x0
 97a:	1d27b783          	ld	a5,466(a5) # b48 <freep>
 97e:	a805                	j	9ae <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 980:	4618                	lw	a4,8(a2)
 982:	9db9                	addw	a1,a1,a4
 984:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 988:	6398                	ld	a4,0(a5)
 98a:	6318                	ld	a4,0(a4)
 98c:	fee53823          	sd	a4,-16(a0)
 990:	a091                	j	9d4 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 992:	ff852703          	lw	a4,-8(a0)
 996:	9e39                	addw	a2,a2,a4
 998:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 99a:	ff053703          	ld	a4,-16(a0)
 99e:	e398                	sd	a4,0(a5)
 9a0:	a099                	j	9e6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9a2:	6398                	ld	a4,0(a5)
 9a4:	00e7e463          	bltu	a5,a4,9ac <free+0x40>
 9a8:	00e6ea63          	bltu	a3,a4,9bc <free+0x50>
{
 9ac:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9ae:	fed7fae3          	bgeu	a5,a3,9a2 <free+0x36>
 9b2:	6398                	ld	a4,0(a5)
 9b4:	00e6e463          	bltu	a3,a4,9bc <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9b8:	fee7eae3          	bltu	a5,a4,9ac <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9bc:	ff852583          	lw	a1,-8(a0)
 9c0:	6390                	ld	a2,0(a5)
 9c2:	02059813          	slli	a6,a1,0x20
 9c6:	01c85713          	srli	a4,a6,0x1c
 9ca:	9736                	add	a4,a4,a3
 9cc:	fae60ae3          	beq	a2,a4,980 <free+0x14>
    bp->s.ptr = p->s.ptr;
 9d0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9d4:	4790                	lw	a2,8(a5)
 9d6:	02061593          	slli	a1,a2,0x20
 9da:	01c5d713          	srli	a4,a1,0x1c
 9de:	973e                	add	a4,a4,a5
 9e0:	fae689e3          	beq	a3,a4,992 <free+0x26>
  } else
    p->s.ptr = bp;
 9e4:	e394                	sd	a3,0(a5)
  freep = p;
 9e6:	00000717          	auipc	a4,0x0
 9ea:	16f73123          	sd	a5,354(a4) # b48 <freep>
}
 9ee:	6422                	ld	s0,8(sp)
 9f0:	0141                	addi	sp,sp,16
 9f2:	8082                	ret

00000000000009f4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9f4:	7139                	addi	sp,sp,-64
 9f6:	fc06                	sd	ra,56(sp)
 9f8:	f822                	sd	s0,48(sp)
 9fa:	f426                	sd	s1,40(sp)
 9fc:	f04a                	sd	s2,32(sp)
 9fe:	ec4e                	sd	s3,24(sp)
 a00:	e852                	sd	s4,16(sp)
 a02:	e456                	sd	s5,8(sp)
 a04:	e05a                	sd	s6,0(sp)
 a06:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a08:	02051493          	slli	s1,a0,0x20
 a0c:	9081                	srli	s1,s1,0x20
 a0e:	04bd                	addi	s1,s1,15
 a10:	8091                	srli	s1,s1,0x4
 a12:	0014899b          	addiw	s3,s1,1
 a16:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a18:	00000517          	auipc	a0,0x0
 a1c:	13053503          	ld	a0,304(a0) # b48 <freep>
 a20:	c515                	beqz	a0,a4c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a22:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a24:	4798                	lw	a4,8(a5)
 a26:	02977f63          	bgeu	a4,s1,a64 <malloc+0x70>
 a2a:	8a4e                	mv	s4,s3
 a2c:	0009871b          	sext.w	a4,s3
 a30:	6685                	lui	a3,0x1
 a32:	00d77363          	bgeu	a4,a3,a38 <malloc+0x44>
 a36:	6a05                	lui	s4,0x1
 a38:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a3c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a40:	00000917          	auipc	s2,0x0
 a44:	10890913          	addi	s2,s2,264 # b48 <freep>
  if(p == (char*)-1)
 a48:	5afd                	li	s5,-1
 a4a:	a895                	j	abe <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a4c:	00000797          	auipc	a5,0x0
 a50:	3f478793          	addi	a5,a5,1012 # e40 <base>
 a54:	00000717          	auipc	a4,0x0
 a58:	0ef73a23          	sd	a5,244(a4) # b48 <freep>
 a5c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a5e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a62:	b7e1                	j	a2a <malloc+0x36>
      if(p->s.size == nunits)
 a64:	02e48c63          	beq	s1,a4,a9c <malloc+0xa8>
        p->s.size -= nunits;
 a68:	4137073b          	subw	a4,a4,s3
 a6c:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a6e:	02071693          	slli	a3,a4,0x20
 a72:	01c6d713          	srli	a4,a3,0x1c
 a76:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a78:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a7c:	00000717          	auipc	a4,0x0
 a80:	0ca73623          	sd	a0,204(a4) # b48 <freep>
      return (void*)(p + 1);
 a84:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 a88:	70e2                	ld	ra,56(sp)
 a8a:	7442                	ld	s0,48(sp)
 a8c:	74a2                	ld	s1,40(sp)
 a8e:	7902                	ld	s2,32(sp)
 a90:	69e2                	ld	s3,24(sp)
 a92:	6a42                	ld	s4,16(sp)
 a94:	6aa2                	ld	s5,8(sp)
 a96:	6b02                	ld	s6,0(sp)
 a98:	6121                	addi	sp,sp,64
 a9a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 a9c:	6398                	ld	a4,0(a5)
 a9e:	e118                	sd	a4,0(a0)
 aa0:	bff1                	j	a7c <malloc+0x88>
  hp->s.size = nu;
 aa2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 aa6:	0541                	addi	a0,a0,16
 aa8:	00000097          	auipc	ra,0x0
 aac:	ec4080e7          	jalr	-316(ra) # 96c <free>
  return freep;
 ab0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 ab4:	d971                	beqz	a0,a88 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ab6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ab8:	4798                	lw	a4,8(a5)
 aba:	fa9775e3          	bgeu	a4,s1,a64 <malloc+0x70>
    if(p == freep)
 abe:	00093703          	ld	a4,0(s2)
 ac2:	853e                	mv	a0,a5
 ac4:	fef719e3          	bne	a4,a5,ab6 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ac8:	8552                	mv	a0,s4
 aca:	00000097          	auipc	ra,0x0
 ace:	b74080e7          	jalr	-1164(ra) # 63e <sbrk>
  if(p == (char*)-1)
 ad2:	fd5518e3          	bne	a0,s5,aa2 <malloc+0xae>
        return 0;
 ad6:	4501                	li	a0,0
 ad8:	bf45                	j	a88 <malloc+0x94>
