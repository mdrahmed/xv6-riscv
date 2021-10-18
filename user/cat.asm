
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
  14:	b6090913          	addi	s2,s2,-1184 # b70 <buf>
  18:	20000613          	li	a2,512
  1c:	85ca                	mv	a1,s2
  1e:	854e                	mv	a0,s3
  20:	00000097          	auipc	ra,0x0
  24:	5c6080e7          	jalr	1478(ra) # 5e6 <read>
  28:	84aa                	mv	s1,a0
  2a:	02a05963          	blez	a0,5c <cat+0x5c>
    if (write(1, buf, n) != n) {
  2e:	8626                	mv	a2,s1
  30:	85ca                	mv	a1,s2
  32:	4505                	li	a0,1
  34:	00000097          	auipc	ra,0x0
  38:	5ba080e7          	jalr	1466(ra) # 5ee <write>
  3c:	fc950ee3          	beq	a0,s1,18 <cat+0x18>
      fprintf(2, "cat: write error\n");
  40:	00001597          	auipc	a1,0x1
  44:	ab858593          	addi	a1,a1,-1352 # af8 <malloc+0xec>
  48:	4509                	li	a0,2
  4a:	00001097          	auipc	ra,0x1
  4e:	8d6080e7          	jalr	-1834(ra) # 920 <fprintf>
      exit(1);
  52:	4505                	li	a0,1
  54:	00000097          	auipc	ra,0x0
  58:	57a080e7          	jalr	1402(ra) # 5ce <exit>
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
  72:	aa258593          	addi	a1,a1,-1374 # b10 <malloc+0x104>
  76:	4509                	li	a0,2
  78:	00001097          	auipc	ra,0x1
  7c:	8a8080e7          	jalr	-1880(ra) # 920 <fprintf>
    exit(1);
  80:	4505                	li	a0,1
  82:	00000097          	auipc	ra,0x0
  86:	54c080e7          	jalr	1356(ra) # 5ce <exit>

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
  be:	554080e7          	jalr	1364(ra) # 60e <open>
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
  d6:	524080e7          	jalr	1316(ra) # 5f6 <close>
  for(i = 1; i < argc; i++){
  da:	0921                	addi	s2,s2,8
  dc:	fd391ce3          	bne	s2,s3,b4 <main+0x2a>
  }
  exit(0);
  e0:	4501                	li	a0,0
  e2:	00000097          	auipc	ra,0x0
  e6:	4ec080e7          	jalr	1260(ra) # 5ce <exit>
    cat(0);
  ea:	4501                	li	a0,0
  ec:	00000097          	auipc	ra,0x0
  f0:	f14080e7          	jalr	-236(ra) # 0 <cat>
    exit(0);
  f4:	4501                	li	a0,0
  f6:	00000097          	auipc	ra,0x0
  fa:	4d8080e7          	jalr	1240(ra) # 5ce <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
  fe:	00093603          	ld	a2,0(s2)
 102:	00001597          	auipc	a1,0x1
 106:	a2658593          	addi	a1,a1,-1498 # b28 <malloc+0x11c>
 10a:	4509                	li	a0,2
 10c:	00001097          	auipc	ra,0x1
 110:	814080e7          	jalr	-2028(ra) # 920 <fprintf>
      exit(1);
 114:	4505                	li	a0,1
 116:	00000097          	auipc	ra,0x0
 11a:	4b8080e7          	jalr	1208(ra) # 5ce <exit>

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

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 14a:	7139                	addi	sp,sp,-64
 14c:	fc06                	sd	ra,56(sp)
 14e:	f822                	sd	s0,48(sp)
 150:	f426                	sd	s1,40(sp)
 152:	f04a                	sd	s2,32(sp)
 154:	ec4e                	sd	s3,24(sp)
 156:	e852                	sd	s4,16(sp)
 158:	e456                	sd	s5,8(sp)
 15a:	e05a                	sd	s6,0(sp)
 15c:	0080                	addi	s0,sp,64
 15e:	8a2a                	mv	s4,a0
 160:	89ae                	mv	s3,a1
 162:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 164:	4785                	li	a5,1
 166:	00001497          	auipc	s1,0x1
 16a:	c1248493          	addi	s1,s1,-1006 # d78 <rings+0x8>
 16e:	00001917          	auipc	s2,0x1
 172:	cfa90913          	addi	s2,s2,-774 # e68 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 176:	00001b17          	auipc	s6,0x1
 17a:	9eab0b13          	addi	s6,s6,-1558 # b60 <vm_addr>
  if(open_close == 1){
 17e:	04f59063          	bne	a1,a5,1be <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 182:	00001497          	auipc	s1,0x1
 186:	bfe4a483          	lw	s1,-1026(s1) # d80 <rings+0x10>
 18a:	c099                	beqz	s1,190 <create_or_close_the_buffer_user+0x46>
 18c:	4481                	li	s1,0
 18e:	a899                	j	1e4 <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 190:	865a                	mv	a2,s6
 192:	4585                	li	a1,1
 194:	00000097          	auipc	ra,0x0
 198:	4da080e7          	jalr	1242(ra) # 66e <ringbuf>
        rings[i].book->write_done = 0;
 19c:	00001797          	auipc	a5,0x1
 1a0:	bd478793          	addi	a5,a5,-1068 # d70 <rings>
 1a4:	6798                	ld	a4,8(a5)
 1a6:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 1aa:	6798                	ld	a4,8(a5)
 1ac:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 1b0:	4b98                	lw	a4,16(a5)
 1b2:	2705                	addiw	a4,a4,1
 1b4:	cb98                	sw	a4,16(a5)
        break;
 1b6:	a03d                	j	1e4 <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 1b8:	04e1                	addi	s1,s1,24
 1ba:	03248463          	beq	s1,s2,1e2 <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 1be:	449c                	lw	a5,8(s1)
 1c0:	dfe5                	beqz	a5,1b8 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 1c2:	865a                	mv	a2,s6
 1c4:	85ce                	mv	a1,s3
 1c6:	8552                	mv	a0,s4
 1c8:	00000097          	auipc	ra,0x0
 1cc:	4a6080e7          	jalr	1190(ra) # 66e <ringbuf>
        rings[i].book->write_done = 0;
 1d0:	609c                	ld	a5,0(s1)
 1d2:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 1d6:	609c                	ld	a5,0(s1)
 1d8:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 1dc:	0004a423          	sw	zero,8(s1)
 1e0:	bfe1                	j	1b8 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 1e2:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 1e4:	00001797          	auipc	a5,0x1
 1e8:	97c7b783          	ld	a5,-1668(a5) # b60 <vm_addr>
 1ec:	00fab023          	sd	a5,0(s5)
  return i;
}
 1f0:	8526                	mv	a0,s1
 1f2:	70e2                	ld	ra,56(sp)
 1f4:	7442                	ld	s0,48(sp)
 1f6:	74a2                	ld	s1,40(sp)
 1f8:	7902                	ld	s2,32(sp)
 1fa:	69e2                	ld	s3,24(sp)
 1fc:	6a42                	ld	s4,16(sp)
 1fe:	6aa2                	ld	s5,8(sp)
 200:	6b02                	ld	s6,0(sp)
 202:	6121                	addi	sp,sp,64
 204:	8082                	ret

0000000000000206 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 206:	1101                	addi	sp,sp,-32
 208:	ec06                	sd	ra,24(sp)
 20a:	e822                	sd	s0,16(sp)
 20c:	e426                	sd	s1,8(sp)
 20e:	1000                	addi	s0,sp,32
 210:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 212:	00001797          	auipc	a5,0x1
 216:	94e7b783          	ld	a5,-1714(a5) # b60 <vm_addr>
 21a:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 21c:	421c                	lw	a5,0(a2)
 21e:	e79d                	bnez	a5,24c <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 220:	00001697          	auipc	a3,0x1
 224:	b5068693          	addi	a3,a3,-1200 # d70 <rings>
 228:	669c                	ld	a5,8(a3)
 22a:	6398                	ld	a4,0(a5)
 22c:	67c1                	lui	a5,0x10
 22e:	9fb9                	addw	a5,a5,a4
 230:	00151713          	slli	a4,a0,0x1
 234:	953a                	add	a0,a0,a4
 236:	050e                	slli	a0,a0,0x3
 238:	9536                	add	a0,a0,a3
 23a:	6518                	ld	a4,8(a0)
 23c:	6718                	ld	a4,8(a4)
 23e:	9f99                	subw	a5,a5,a4
 240:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 242:	60e2                	ld	ra,24(sp)
 244:	6442                	ld	s0,16(sp)
 246:	64a2                	ld	s1,8(sp)
 248:	6105                	addi	sp,sp,32
 24a:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 24c:	00151793          	slli	a5,a0,0x1
 250:	953e                	add	a0,a0,a5
 252:	050e                	slli	a0,a0,0x3
 254:	00001797          	auipc	a5,0x1
 258:	b1c78793          	addi	a5,a5,-1252 # d70 <rings>
 25c:	953e                	add	a0,a0,a5
 25e:	6508                	ld	a0,8(a0)
 260:	0521                	addi	a0,a0,8
 262:	00000097          	auipc	ra,0x0
 266:	ed0080e7          	jalr	-304(ra) # 132 <load>
 26a:	c088                	sw	a0,0(s1)
}
 26c:	bfd9                	j	242 <ringbuf_start_write+0x3c>

000000000000026e <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 26e:	1141                	addi	sp,sp,-16
 270:	e406                	sd	ra,8(sp)
 272:	e022                	sd	s0,0(sp)
 274:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 276:	00151793          	slli	a5,a0,0x1
 27a:	97aa                	add	a5,a5,a0
 27c:	078e                	slli	a5,a5,0x3
 27e:	00001517          	auipc	a0,0x1
 282:	af250513          	addi	a0,a0,-1294 # d70 <rings>
 286:	97aa                	add	a5,a5,a0
 288:	6788                	ld	a0,8(a5)
 28a:	0035959b          	slliw	a1,a1,0x3
 28e:	0521                	addi	a0,a0,8
 290:	00000097          	auipc	ra,0x0
 294:	e8e080e7          	jalr	-370(ra) # 11e <store>
}
 298:	60a2                	ld	ra,8(sp)
 29a:	6402                	ld	s0,0(sp)
 29c:	0141                	addi	sp,sp,16
 29e:	8082                	ret

00000000000002a0 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 2a0:	1101                	addi	sp,sp,-32
 2a2:	ec06                	sd	ra,24(sp)
 2a4:	e822                	sd	s0,16(sp)
 2a6:	e426                	sd	s1,8(sp)
 2a8:	1000                	addi	s0,sp,32
 2aa:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 2ac:	00151793          	slli	a5,a0,0x1
 2b0:	97aa                	add	a5,a5,a0
 2b2:	078e                	slli	a5,a5,0x3
 2b4:	00001517          	auipc	a0,0x1
 2b8:	abc50513          	addi	a0,a0,-1348 # d70 <rings>
 2bc:	97aa                	add	a5,a5,a0
 2be:	6788                	ld	a0,8(a5)
 2c0:	0521                	addi	a0,a0,8
 2c2:	00000097          	auipc	ra,0x0
 2c6:	e70080e7          	jalr	-400(ra) # 132 <load>
 2ca:	c088                	sw	a0,0(s1)
}
 2cc:	60e2                	ld	ra,24(sp)
 2ce:	6442                	ld	s0,16(sp)
 2d0:	64a2                	ld	s1,8(sp)
 2d2:	6105                	addi	sp,sp,32
 2d4:	8082                	ret

00000000000002d6 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 2d6:	1101                	addi	sp,sp,-32
 2d8:	ec06                	sd	ra,24(sp)
 2da:	e822                	sd	s0,16(sp)
 2dc:	e426                	sd	s1,8(sp)
 2de:	1000                	addi	s0,sp,32
 2e0:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 2e2:	00151793          	slli	a5,a0,0x1
 2e6:	97aa                	add	a5,a5,a0
 2e8:	078e                	slli	a5,a5,0x3
 2ea:	00001517          	auipc	a0,0x1
 2ee:	a8650513          	addi	a0,a0,-1402 # d70 <rings>
 2f2:	97aa                	add	a5,a5,a0
 2f4:	6788                	ld	a0,8(a5)
 2f6:	611c                	ld	a5,0(a0)
 2f8:	ef99                	bnez	a5,316 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 2fa:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 2fc:	41f7579b          	sraiw	a5,a4,0x1f
 300:	01d7d79b          	srliw	a5,a5,0x1d
 304:	9fb9                	addw	a5,a5,a4
 306:	4037d79b          	sraiw	a5,a5,0x3
 30a:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 30c:	60e2                	ld	ra,24(sp)
 30e:	6442                	ld	s0,16(sp)
 310:	64a2                	ld	s1,8(sp)
 312:	6105                	addi	sp,sp,32
 314:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 316:	00000097          	auipc	ra,0x0
 31a:	e1c080e7          	jalr	-484(ra) # 132 <load>
    *bytes /= 8;
 31e:	41f5579b          	sraiw	a5,a0,0x1f
 322:	01d7d79b          	srliw	a5,a5,0x1d
 326:	9d3d                	addw	a0,a0,a5
 328:	4035551b          	sraiw	a0,a0,0x3
 32c:	c088                	sw	a0,0(s1)
}
 32e:	bff9                	j	30c <ringbuf_start_read+0x36>

0000000000000330 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 330:	1141                	addi	sp,sp,-16
 332:	e406                	sd	ra,8(sp)
 334:	e022                	sd	s0,0(sp)
 336:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 338:	00151793          	slli	a5,a0,0x1
 33c:	97aa                	add	a5,a5,a0
 33e:	078e                	slli	a5,a5,0x3
 340:	00001517          	auipc	a0,0x1
 344:	a3050513          	addi	a0,a0,-1488 # d70 <rings>
 348:	97aa                	add	a5,a5,a0
 34a:	0035959b          	slliw	a1,a1,0x3
 34e:	6788                	ld	a0,8(a5)
 350:	00000097          	auipc	ra,0x0
 354:	dce080e7          	jalr	-562(ra) # 11e <store>
}
 358:	60a2                	ld	ra,8(sp)
 35a:	6402                	ld	s0,0(sp)
 35c:	0141                	addi	sp,sp,16
 35e:	8082                	ret

0000000000000360 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 360:	1141                	addi	sp,sp,-16
 362:	e422                	sd	s0,8(sp)
 364:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 366:	87aa                	mv	a5,a0
 368:	0585                	addi	a1,a1,1
 36a:	0785                	addi	a5,a5,1
 36c:	fff5c703          	lbu	a4,-1(a1)
 370:	fee78fa3          	sb	a4,-1(a5)
 374:	fb75                	bnez	a4,368 <strcpy+0x8>
    ;
  return os;
}
 376:	6422                	ld	s0,8(sp)
 378:	0141                	addi	sp,sp,16
 37a:	8082                	ret

000000000000037c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 37c:	1141                	addi	sp,sp,-16
 37e:	e422                	sd	s0,8(sp)
 380:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 382:	00054783          	lbu	a5,0(a0)
 386:	cb91                	beqz	a5,39a <strcmp+0x1e>
 388:	0005c703          	lbu	a4,0(a1)
 38c:	00f71763          	bne	a4,a5,39a <strcmp+0x1e>
    p++, q++;
 390:	0505                	addi	a0,a0,1
 392:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 394:	00054783          	lbu	a5,0(a0)
 398:	fbe5                	bnez	a5,388 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 39a:	0005c503          	lbu	a0,0(a1)
}
 39e:	40a7853b          	subw	a0,a5,a0
 3a2:	6422                	ld	s0,8(sp)
 3a4:	0141                	addi	sp,sp,16
 3a6:	8082                	ret

00000000000003a8 <strlen>:

uint
strlen(const char *s)
{
 3a8:	1141                	addi	sp,sp,-16
 3aa:	e422                	sd	s0,8(sp)
 3ac:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 3ae:	00054783          	lbu	a5,0(a0)
 3b2:	cf91                	beqz	a5,3ce <strlen+0x26>
 3b4:	0505                	addi	a0,a0,1
 3b6:	87aa                	mv	a5,a0
 3b8:	4685                	li	a3,1
 3ba:	9e89                	subw	a3,a3,a0
 3bc:	00f6853b          	addw	a0,a3,a5
 3c0:	0785                	addi	a5,a5,1
 3c2:	fff7c703          	lbu	a4,-1(a5)
 3c6:	fb7d                	bnez	a4,3bc <strlen+0x14>
    ;
  return n;
}
 3c8:	6422                	ld	s0,8(sp)
 3ca:	0141                	addi	sp,sp,16
 3cc:	8082                	ret
  for(n = 0; s[n]; n++)
 3ce:	4501                	li	a0,0
 3d0:	bfe5                	j	3c8 <strlen+0x20>

00000000000003d2 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3d2:	1141                	addi	sp,sp,-16
 3d4:	e422                	sd	s0,8(sp)
 3d6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 3d8:	ca19                	beqz	a2,3ee <memset+0x1c>
 3da:	87aa                	mv	a5,a0
 3dc:	1602                	slli	a2,a2,0x20
 3de:	9201                	srli	a2,a2,0x20
 3e0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 3e4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 3e8:	0785                	addi	a5,a5,1
 3ea:	fee79de3          	bne	a5,a4,3e4 <memset+0x12>
  }
  return dst;
}
 3ee:	6422                	ld	s0,8(sp)
 3f0:	0141                	addi	sp,sp,16
 3f2:	8082                	ret

00000000000003f4 <strchr>:

char*
strchr(const char *s, char c)
{
 3f4:	1141                	addi	sp,sp,-16
 3f6:	e422                	sd	s0,8(sp)
 3f8:	0800                	addi	s0,sp,16
  for(; *s; s++)
 3fa:	00054783          	lbu	a5,0(a0)
 3fe:	cb99                	beqz	a5,414 <strchr+0x20>
    if(*s == c)
 400:	00f58763          	beq	a1,a5,40e <strchr+0x1a>
  for(; *s; s++)
 404:	0505                	addi	a0,a0,1
 406:	00054783          	lbu	a5,0(a0)
 40a:	fbfd                	bnez	a5,400 <strchr+0xc>
      return (char*)s;
  return 0;
 40c:	4501                	li	a0,0
}
 40e:	6422                	ld	s0,8(sp)
 410:	0141                	addi	sp,sp,16
 412:	8082                	ret
  return 0;
 414:	4501                	li	a0,0
 416:	bfe5                	j	40e <strchr+0x1a>

0000000000000418 <gets>:

char*
gets(char *buf, int max)
{
 418:	711d                	addi	sp,sp,-96
 41a:	ec86                	sd	ra,88(sp)
 41c:	e8a2                	sd	s0,80(sp)
 41e:	e4a6                	sd	s1,72(sp)
 420:	e0ca                	sd	s2,64(sp)
 422:	fc4e                	sd	s3,56(sp)
 424:	f852                	sd	s4,48(sp)
 426:	f456                	sd	s5,40(sp)
 428:	f05a                	sd	s6,32(sp)
 42a:	ec5e                	sd	s7,24(sp)
 42c:	1080                	addi	s0,sp,96
 42e:	8baa                	mv	s7,a0
 430:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 432:	892a                	mv	s2,a0
 434:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 436:	4aa9                	li	s5,10
 438:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 43a:	89a6                	mv	s3,s1
 43c:	2485                	addiw	s1,s1,1
 43e:	0344d863          	bge	s1,s4,46e <gets+0x56>
    cc = read(0, &c, 1);
 442:	4605                	li	a2,1
 444:	faf40593          	addi	a1,s0,-81
 448:	4501                	li	a0,0
 44a:	00000097          	auipc	ra,0x0
 44e:	19c080e7          	jalr	412(ra) # 5e6 <read>
    if(cc < 1)
 452:	00a05e63          	blez	a0,46e <gets+0x56>
    buf[i++] = c;
 456:	faf44783          	lbu	a5,-81(s0)
 45a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 45e:	01578763          	beq	a5,s5,46c <gets+0x54>
 462:	0905                	addi	s2,s2,1
 464:	fd679be3          	bne	a5,s6,43a <gets+0x22>
  for(i=0; i+1 < max; ){
 468:	89a6                	mv	s3,s1
 46a:	a011                	j	46e <gets+0x56>
 46c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 46e:	99de                	add	s3,s3,s7
 470:	00098023          	sb	zero,0(s3)
  return buf;
}
 474:	855e                	mv	a0,s7
 476:	60e6                	ld	ra,88(sp)
 478:	6446                	ld	s0,80(sp)
 47a:	64a6                	ld	s1,72(sp)
 47c:	6906                	ld	s2,64(sp)
 47e:	79e2                	ld	s3,56(sp)
 480:	7a42                	ld	s4,48(sp)
 482:	7aa2                	ld	s5,40(sp)
 484:	7b02                	ld	s6,32(sp)
 486:	6be2                	ld	s7,24(sp)
 488:	6125                	addi	sp,sp,96
 48a:	8082                	ret

000000000000048c <stat>:

int
stat(const char *n, struct stat *st)
{
 48c:	1101                	addi	sp,sp,-32
 48e:	ec06                	sd	ra,24(sp)
 490:	e822                	sd	s0,16(sp)
 492:	e426                	sd	s1,8(sp)
 494:	e04a                	sd	s2,0(sp)
 496:	1000                	addi	s0,sp,32
 498:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 49a:	4581                	li	a1,0
 49c:	00000097          	auipc	ra,0x0
 4a0:	172080e7          	jalr	370(ra) # 60e <open>
  if(fd < 0)
 4a4:	02054563          	bltz	a0,4ce <stat+0x42>
 4a8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 4aa:	85ca                	mv	a1,s2
 4ac:	00000097          	auipc	ra,0x0
 4b0:	17a080e7          	jalr	378(ra) # 626 <fstat>
 4b4:	892a                	mv	s2,a0
  close(fd);
 4b6:	8526                	mv	a0,s1
 4b8:	00000097          	auipc	ra,0x0
 4bc:	13e080e7          	jalr	318(ra) # 5f6 <close>
  return r;
}
 4c0:	854a                	mv	a0,s2
 4c2:	60e2                	ld	ra,24(sp)
 4c4:	6442                	ld	s0,16(sp)
 4c6:	64a2                	ld	s1,8(sp)
 4c8:	6902                	ld	s2,0(sp)
 4ca:	6105                	addi	sp,sp,32
 4cc:	8082                	ret
    return -1;
 4ce:	597d                	li	s2,-1
 4d0:	bfc5                	j	4c0 <stat+0x34>

00000000000004d2 <atoi>:

int
atoi(const char *s)
{
 4d2:	1141                	addi	sp,sp,-16
 4d4:	e422                	sd	s0,8(sp)
 4d6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4d8:	00054603          	lbu	a2,0(a0)
 4dc:	fd06079b          	addiw	a5,a2,-48
 4e0:	0ff7f793          	zext.b	a5,a5
 4e4:	4725                	li	a4,9
 4e6:	02f76963          	bltu	a4,a5,518 <atoi+0x46>
 4ea:	86aa                	mv	a3,a0
  n = 0;
 4ec:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 4ee:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 4f0:	0685                	addi	a3,a3,1
 4f2:	0025179b          	slliw	a5,a0,0x2
 4f6:	9fa9                	addw	a5,a5,a0
 4f8:	0017979b          	slliw	a5,a5,0x1
 4fc:	9fb1                	addw	a5,a5,a2
 4fe:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 502:	0006c603          	lbu	a2,0(a3)
 506:	fd06071b          	addiw	a4,a2,-48
 50a:	0ff77713          	zext.b	a4,a4
 50e:	fee5f1e3          	bgeu	a1,a4,4f0 <atoi+0x1e>
  return n;
}
 512:	6422                	ld	s0,8(sp)
 514:	0141                	addi	sp,sp,16
 516:	8082                	ret
  n = 0;
 518:	4501                	li	a0,0
 51a:	bfe5                	j	512 <atoi+0x40>

000000000000051c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 51c:	1141                	addi	sp,sp,-16
 51e:	e422                	sd	s0,8(sp)
 520:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 522:	02b57463          	bgeu	a0,a1,54a <memmove+0x2e>
    while(n-- > 0)
 526:	00c05f63          	blez	a2,544 <memmove+0x28>
 52a:	1602                	slli	a2,a2,0x20
 52c:	9201                	srli	a2,a2,0x20
 52e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 532:	872a                	mv	a4,a0
      *dst++ = *src++;
 534:	0585                	addi	a1,a1,1
 536:	0705                	addi	a4,a4,1
 538:	fff5c683          	lbu	a3,-1(a1)
 53c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 540:	fee79ae3          	bne	a5,a4,534 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 544:	6422                	ld	s0,8(sp)
 546:	0141                	addi	sp,sp,16
 548:	8082                	ret
    dst += n;
 54a:	00c50733          	add	a4,a0,a2
    src += n;
 54e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 550:	fec05ae3          	blez	a2,544 <memmove+0x28>
 554:	fff6079b          	addiw	a5,a2,-1
 558:	1782                	slli	a5,a5,0x20
 55a:	9381                	srli	a5,a5,0x20
 55c:	fff7c793          	not	a5,a5
 560:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 562:	15fd                	addi	a1,a1,-1
 564:	177d                	addi	a4,a4,-1
 566:	0005c683          	lbu	a3,0(a1)
 56a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 56e:	fee79ae3          	bne	a5,a4,562 <memmove+0x46>
 572:	bfc9                	j	544 <memmove+0x28>

0000000000000574 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 574:	1141                	addi	sp,sp,-16
 576:	e422                	sd	s0,8(sp)
 578:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 57a:	ca05                	beqz	a2,5aa <memcmp+0x36>
 57c:	fff6069b          	addiw	a3,a2,-1
 580:	1682                	slli	a3,a3,0x20
 582:	9281                	srli	a3,a3,0x20
 584:	0685                	addi	a3,a3,1
 586:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 588:	00054783          	lbu	a5,0(a0)
 58c:	0005c703          	lbu	a4,0(a1)
 590:	00e79863          	bne	a5,a4,5a0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 594:	0505                	addi	a0,a0,1
    p2++;
 596:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 598:	fed518e3          	bne	a0,a3,588 <memcmp+0x14>
  }
  return 0;
 59c:	4501                	li	a0,0
 59e:	a019                	j	5a4 <memcmp+0x30>
      return *p1 - *p2;
 5a0:	40e7853b          	subw	a0,a5,a4
}
 5a4:	6422                	ld	s0,8(sp)
 5a6:	0141                	addi	sp,sp,16
 5a8:	8082                	ret
  return 0;
 5aa:	4501                	li	a0,0
 5ac:	bfe5                	j	5a4 <memcmp+0x30>

00000000000005ae <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 5ae:	1141                	addi	sp,sp,-16
 5b0:	e406                	sd	ra,8(sp)
 5b2:	e022                	sd	s0,0(sp)
 5b4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 5b6:	00000097          	auipc	ra,0x0
 5ba:	f66080e7          	jalr	-154(ra) # 51c <memmove>
}
 5be:	60a2                	ld	ra,8(sp)
 5c0:	6402                	ld	s0,0(sp)
 5c2:	0141                	addi	sp,sp,16
 5c4:	8082                	ret

00000000000005c6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 5c6:	4885                	li	a7,1
 ecall
 5c8:	00000073          	ecall
 ret
 5cc:	8082                	ret

00000000000005ce <exit>:
.global exit
exit:
 li a7, SYS_exit
 5ce:	4889                	li	a7,2
 ecall
 5d0:	00000073          	ecall
 ret
 5d4:	8082                	ret

00000000000005d6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 5d6:	488d                	li	a7,3
 ecall
 5d8:	00000073          	ecall
 ret
 5dc:	8082                	ret

00000000000005de <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 5de:	4891                	li	a7,4
 ecall
 5e0:	00000073          	ecall
 ret
 5e4:	8082                	ret

00000000000005e6 <read>:
.global read
read:
 li a7, SYS_read
 5e6:	4895                	li	a7,5
 ecall
 5e8:	00000073          	ecall
 ret
 5ec:	8082                	ret

00000000000005ee <write>:
.global write
write:
 li a7, SYS_write
 5ee:	48c1                	li	a7,16
 ecall
 5f0:	00000073          	ecall
 ret
 5f4:	8082                	ret

00000000000005f6 <close>:
.global close
close:
 li a7, SYS_close
 5f6:	48d5                	li	a7,21
 ecall
 5f8:	00000073          	ecall
 ret
 5fc:	8082                	ret

00000000000005fe <kill>:
.global kill
kill:
 li a7, SYS_kill
 5fe:	4899                	li	a7,6
 ecall
 600:	00000073          	ecall
 ret
 604:	8082                	ret

0000000000000606 <exec>:
.global exec
exec:
 li a7, SYS_exec
 606:	489d                	li	a7,7
 ecall
 608:	00000073          	ecall
 ret
 60c:	8082                	ret

000000000000060e <open>:
.global open
open:
 li a7, SYS_open
 60e:	48bd                	li	a7,15
 ecall
 610:	00000073          	ecall
 ret
 614:	8082                	ret

0000000000000616 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 616:	48c5                	li	a7,17
 ecall
 618:	00000073          	ecall
 ret
 61c:	8082                	ret

000000000000061e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 61e:	48c9                	li	a7,18
 ecall
 620:	00000073          	ecall
 ret
 624:	8082                	ret

0000000000000626 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 626:	48a1                	li	a7,8
 ecall
 628:	00000073          	ecall
 ret
 62c:	8082                	ret

000000000000062e <link>:
.global link
link:
 li a7, SYS_link
 62e:	48cd                	li	a7,19
 ecall
 630:	00000073          	ecall
 ret
 634:	8082                	ret

0000000000000636 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 636:	48d1                	li	a7,20
 ecall
 638:	00000073          	ecall
 ret
 63c:	8082                	ret

000000000000063e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 63e:	48a5                	li	a7,9
 ecall
 640:	00000073          	ecall
 ret
 644:	8082                	ret

0000000000000646 <dup>:
.global dup
dup:
 li a7, SYS_dup
 646:	48a9                	li	a7,10
 ecall
 648:	00000073          	ecall
 ret
 64c:	8082                	ret

000000000000064e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 64e:	48ad                	li	a7,11
 ecall
 650:	00000073          	ecall
 ret
 654:	8082                	ret

0000000000000656 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 656:	48b1                	li	a7,12
 ecall
 658:	00000073          	ecall
 ret
 65c:	8082                	ret

000000000000065e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 65e:	48b5                	li	a7,13
 ecall
 660:	00000073          	ecall
 ret
 664:	8082                	ret

0000000000000666 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 666:	48b9                	li	a7,14
 ecall
 668:	00000073          	ecall
 ret
 66c:	8082                	ret

000000000000066e <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 66e:	48d9                	li	a7,22
 ecall
 670:	00000073          	ecall
 ret
 674:	8082                	ret

0000000000000676 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 676:	1101                	addi	sp,sp,-32
 678:	ec06                	sd	ra,24(sp)
 67a:	e822                	sd	s0,16(sp)
 67c:	1000                	addi	s0,sp,32
 67e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 682:	4605                	li	a2,1
 684:	fef40593          	addi	a1,s0,-17
 688:	00000097          	auipc	ra,0x0
 68c:	f66080e7          	jalr	-154(ra) # 5ee <write>
}
 690:	60e2                	ld	ra,24(sp)
 692:	6442                	ld	s0,16(sp)
 694:	6105                	addi	sp,sp,32
 696:	8082                	ret

0000000000000698 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 698:	7139                	addi	sp,sp,-64
 69a:	fc06                	sd	ra,56(sp)
 69c:	f822                	sd	s0,48(sp)
 69e:	f426                	sd	s1,40(sp)
 6a0:	f04a                	sd	s2,32(sp)
 6a2:	ec4e                	sd	s3,24(sp)
 6a4:	0080                	addi	s0,sp,64
 6a6:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 6a8:	c299                	beqz	a3,6ae <printint+0x16>
 6aa:	0805c863          	bltz	a1,73a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 6ae:	2581                	sext.w	a1,a1
  neg = 0;
 6b0:	4881                	li	a7,0
 6b2:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 6b6:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 6b8:	2601                	sext.w	a2,a2
 6ba:	00000517          	auipc	a0,0x0
 6be:	48e50513          	addi	a0,a0,1166 # b48 <digits>
 6c2:	883a                	mv	a6,a4
 6c4:	2705                	addiw	a4,a4,1
 6c6:	02c5f7bb          	remuw	a5,a1,a2
 6ca:	1782                	slli	a5,a5,0x20
 6cc:	9381                	srli	a5,a5,0x20
 6ce:	97aa                	add	a5,a5,a0
 6d0:	0007c783          	lbu	a5,0(a5)
 6d4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 6d8:	0005879b          	sext.w	a5,a1
 6dc:	02c5d5bb          	divuw	a1,a1,a2
 6e0:	0685                	addi	a3,a3,1
 6e2:	fec7f0e3          	bgeu	a5,a2,6c2 <printint+0x2a>
  if(neg)
 6e6:	00088b63          	beqz	a7,6fc <printint+0x64>
    buf[i++] = '-';
 6ea:	fd040793          	addi	a5,s0,-48
 6ee:	973e                	add	a4,a4,a5
 6f0:	02d00793          	li	a5,45
 6f4:	fef70823          	sb	a5,-16(a4)
 6f8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 6fc:	02e05863          	blez	a4,72c <printint+0x94>
 700:	fc040793          	addi	a5,s0,-64
 704:	00e78933          	add	s2,a5,a4
 708:	fff78993          	addi	s3,a5,-1
 70c:	99ba                	add	s3,s3,a4
 70e:	377d                	addiw	a4,a4,-1
 710:	1702                	slli	a4,a4,0x20
 712:	9301                	srli	a4,a4,0x20
 714:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 718:	fff94583          	lbu	a1,-1(s2)
 71c:	8526                	mv	a0,s1
 71e:	00000097          	auipc	ra,0x0
 722:	f58080e7          	jalr	-168(ra) # 676 <putc>
  while(--i >= 0)
 726:	197d                	addi	s2,s2,-1
 728:	ff3918e3          	bne	s2,s3,718 <printint+0x80>
}
 72c:	70e2                	ld	ra,56(sp)
 72e:	7442                	ld	s0,48(sp)
 730:	74a2                	ld	s1,40(sp)
 732:	7902                	ld	s2,32(sp)
 734:	69e2                	ld	s3,24(sp)
 736:	6121                	addi	sp,sp,64
 738:	8082                	ret
    x = -xx;
 73a:	40b005bb          	negw	a1,a1
    neg = 1;
 73e:	4885                	li	a7,1
    x = -xx;
 740:	bf8d                	j	6b2 <printint+0x1a>

0000000000000742 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 742:	7119                	addi	sp,sp,-128
 744:	fc86                	sd	ra,120(sp)
 746:	f8a2                	sd	s0,112(sp)
 748:	f4a6                	sd	s1,104(sp)
 74a:	f0ca                	sd	s2,96(sp)
 74c:	ecce                	sd	s3,88(sp)
 74e:	e8d2                	sd	s4,80(sp)
 750:	e4d6                	sd	s5,72(sp)
 752:	e0da                	sd	s6,64(sp)
 754:	fc5e                	sd	s7,56(sp)
 756:	f862                	sd	s8,48(sp)
 758:	f466                	sd	s9,40(sp)
 75a:	f06a                	sd	s10,32(sp)
 75c:	ec6e                	sd	s11,24(sp)
 75e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 760:	0005c903          	lbu	s2,0(a1)
 764:	18090f63          	beqz	s2,902 <vprintf+0x1c0>
 768:	8aaa                	mv	s5,a0
 76a:	8b32                	mv	s6,a2
 76c:	00158493          	addi	s1,a1,1
  state = 0;
 770:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 772:	02500a13          	li	s4,37
      if(c == 'd'){
 776:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 77a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 77e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 782:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 786:	00000b97          	auipc	s7,0x0
 78a:	3c2b8b93          	addi	s7,s7,962 # b48 <digits>
 78e:	a839                	j	7ac <vprintf+0x6a>
        putc(fd, c);
 790:	85ca                	mv	a1,s2
 792:	8556                	mv	a0,s5
 794:	00000097          	auipc	ra,0x0
 798:	ee2080e7          	jalr	-286(ra) # 676 <putc>
 79c:	a019                	j	7a2 <vprintf+0x60>
    } else if(state == '%'){
 79e:	01498f63          	beq	s3,s4,7bc <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 7a2:	0485                	addi	s1,s1,1
 7a4:	fff4c903          	lbu	s2,-1(s1)
 7a8:	14090d63          	beqz	s2,902 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 7ac:	0009079b          	sext.w	a5,s2
    if(state == 0){
 7b0:	fe0997e3          	bnez	s3,79e <vprintf+0x5c>
      if(c == '%'){
 7b4:	fd479ee3          	bne	a5,s4,790 <vprintf+0x4e>
        state = '%';
 7b8:	89be                	mv	s3,a5
 7ba:	b7e5                	j	7a2 <vprintf+0x60>
      if(c == 'd'){
 7bc:	05878063          	beq	a5,s8,7fc <vprintf+0xba>
      } else if(c == 'l') {
 7c0:	05978c63          	beq	a5,s9,818 <vprintf+0xd6>
      } else if(c == 'x') {
 7c4:	07a78863          	beq	a5,s10,834 <vprintf+0xf2>
      } else if(c == 'p') {
 7c8:	09b78463          	beq	a5,s11,850 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 7cc:	07300713          	li	a4,115
 7d0:	0ce78663          	beq	a5,a4,89c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7d4:	06300713          	li	a4,99
 7d8:	0ee78e63          	beq	a5,a4,8d4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 7dc:	11478863          	beq	a5,s4,8ec <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 7e0:	85d2                	mv	a1,s4
 7e2:	8556                	mv	a0,s5
 7e4:	00000097          	auipc	ra,0x0
 7e8:	e92080e7          	jalr	-366(ra) # 676 <putc>
        putc(fd, c);
 7ec:	85ca                	mv	a1,s2
 7ee:	8556                	mv	a0,s5
 7f0:	00000097          	auipc	ra,0x0
 7f4:	e86080e7          	jalr	-378(ra) # 676 <putc>
      }
      state = 0;
 7f8:	4981                	li	s3,0
 7fa:	b765                	j	7a2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 7fc:	008b0913          	addi	s2,s6,8
 800:	4685                	li	a3,1
 802:	4629                	li	a2,10
 804:	000b2583          	lw	a1,0(s6)
 808:	8556                	mv	a0,s5
 80a:	00000097          	auipc	ra,0x0
 80e:	e8e080e7          	jalr	-370(ra) # 698 <printint>
 812:	8b4a                	mv	s6,s2
      state = 0;
 814:	4981                	li	s3,0
 816:	b771                	j	7a2 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 818:	008b0913          	addi	s2,s6,8
 81c:	4681                	li	a3,0
 81e:	4629                	li	a2,10
 820:	000b2583          	lw	a1,0(s6)
 824:	8556                	mv	a0,s5
 826:	00000097          	auipc	ra,0x0
 82a:	e72080e7          	jalr	-398(ra) # 698 <printint>
 82e:	8b4a                	mv	s6,s2
      state = 0;
 830:	4981                	li	s3,0
 832:	bf85                	j	7a2 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 834:	008b0913          	addi	s2,s6,8
 838:	4681                	li	a3,0
 83a:	4641                	li	a2,16
 83c:	000b2583          	lw	a1,0(s6)
 840:	8556                	mv	a0,s5
 842:	00000097          	auipc	ra,0x0
 846:	e56080e7          	jalr	-426(ra) # 698 <printint>
 84a:	8b4a                	mv	s6,s2
      state = 0;
 84c:	4981                	li	s3,0
 84e:	bf91                	j	7a2 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 850:	008b0793          	addi	a5,s6,8
 854:	f8f43423          	sd	a5,-120(s0)
 858:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 85c:	03000593          	li	a1,48
 860:	8556                	mv	a0,s5
 862:	00000097          	auipc	ra,0x0
 866:	e14080e7          	jalr	-492(ra) # 676 <putc>
  putc(fd, 'x');
 86a:	85ea                	mv	a1,s10
 86c:	8556                	mv	a0,s5
 86e:	00000097          	auipc	ra,0x0
 872:	e08080e7          	jalr	-504(ra) # 676 <putc>
 876:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 878:	03c9d793          	srli	a5,s3,0x3c
 87c:	97de                	add	a5,a5,s7
 87e:	0007c583          	lbu	a1,0(a5)
 882:	8556                	mv	a0,s5
 884:	00000097          	auipc	ra,0x0
 888:	df2080e7          	jalr	-526(ra) # 676 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 88c:	0992                	slli	s3,s3,0x4
 88e:	397d                	addiw	s2,s2,-1
 890:	fe0914e3          	bnez	s2,878 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 894:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 898:	4981                	li	s3,0
 89a:	b721                	j	7a2 <vprintf+0x60>
        s = va_arg(ap, char*);
 89c:	008b0993          	addi	s3,s6,8
 8a0:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 8a4:	02090163          	beqz	s2,8c6 <vprintf+0x184>
        while(*s != 0){
 8a8:	00094583          	lbu	a1,0(s2)
 8ac:	c9a1                	beqz	a1,8fc <vprintf+0x1ba>
          putc(fd, *s);
 8ae:	8556                	mv	a0,s5
 8b0:	00000097          	auipc	ra,0x0
 8b4:	dc6080e7          	jalr	-570(ra) # 676 <putc>
          s++;
 8b8:	0905                	addi	s2,s2,1
        while(*s != 0){
 8ba:	00094583          	lbu	a1,0(s2)
 8be:	f9e5                	bnez	a1,8ae <vprintf+0x16c>
        s = va_arg(ap, char*);
 8c0:	8b4e                	mv	s6,s3
      state = 0;
 8c2:	4981                	li	s3,0
 8c4:	bdf9                	j	7a2 <vprintf+0x60>
          s = "(null)";
 8c6:	00000917          	auipc	s2,0x0
 8ca:	27a90913          	addi	s2,s2,634 # b40 <malloc+0x134>
        while(*s != 0){
 8ce:	02800593          	li	a1,40
 8d2:	bff1                	j	8ae <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 8d4:	008b0913          	addi	s2,s6,8
 8d8:	000b4583          	lbu	a1,0(s6)
 8dc:	8556                	mv	a0,s5
 8de:	00000097          	auipc	ra,0x0
 8e2:	d98080e7          	jalr	-616(ra) # 676 <putc>
 8e6:	8b4a                	mv	s6,s2
      state = 0;
 8e8:	4981                	li	s3,0
 8ea:	bd65                	j	7a2 <vprintf+0x60>
        putc(fd, c);
 8ec:	85d2                	mv	a1,s4
 8ee:	8556                	mv	a0,s5
 8f0:	00000097          	auipc	ra,0x0
 8f4:	d86080e7          	jalr	-634(ra) # 676 <putc>
      state = 0;
 8f8:	4981                	li	s3,0
 8fa:	b565                	j	7a2 <vprintf+0x60>
        s = va_arg(ap, char*);
 8fc:	8b4e                	mv	s6,s3
      state = 0;
 8fe:	4981                	li	s3,0
 900:	b54d                	j	7a2 <vprintf+0x60>
    }
  }
}
 902:	70e6                	ld	ra,120(sp)
 904:	7446                	ld	s0,112(sp)
 906:	74a6                	ld	s1,104(sp)
 908:	7906                	ld	s2,96(sp)
 90a:	69e6                	ld	s3,88(sp)
 90c:	6a46                	ld	s4,80(sp)
 90e:	6aa6                	ld	s5,72(sp)
 910:	6b06                	ld	s6,64(sp)
 912:	7be2                	ld	s7,56(sp)
 914:	7c42                	ld	s8,48(sp)
 916:	7ca2                	ld	s9,40(sp)
 918:	7d02                	ld	s10,32(sp)
 91a:	6de2                	ld	s11,24(sp)
 91c:	6109                	addi	sp,sp,128
 91e:	8082                	ret

0000000000000920 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 920:	715d                	addi	sp,sp,-80
 922:	ec06                	sd	ra,24(sp)
 924:	e822                	sd	s0,16(sp)
 926:	1000                	addi	s0,sp,32
 928:	e010                	sd	a2,0(s0)
 92a:	e414                	sd	a3,8(s0)
 92c:	e818                	sd	a4,16(s0)
 92e:	ec1c                	sd	a5,24(s0)
 930:	03043023          	sd	a6,32(s0)
 934:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 938:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 93c:	8622                	mv	a2,s0
 93e:	00000097          	auipc	ra,0x0
 942:	e04080e7          	jalr	-508(ra) # 742 <vprintf>
}
 946:	60e2                	ld	ra,24(sp)
 948:	6442                	ld	s0,16(sp)
 94a:	6161                	addi	sp,sp,80
 94c:	8082                	ret

000000000000094e <printf>:

void
printf(const char *fmt, ...)
{
 94e:	711d                	addi	sp,sp,-96
 950:	ec06                	sd	ra,24(sp)
 952:	e822                	sd	s0,16(sp)
 954:	1000                	addi	s0,sp,32
 956:	e40c                	sd	a1,8(s0)
 958:	e810                	sd	a2,16(s0)
 95a:	ec14                	sd	a3,24(s0)
 95c:	f018                	sd	a4,32(s0)
 95e:	f41c                	sd	a5,40(s0)
 960:	03043823          	sd	a6,48(s0)
 964:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 968:	00840613          	addi	a2,s0,8
 96c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 970:	85aa                	mv	a1,a0
 972:	4505                	li	a0,1
 974:	00000097          	auipc	ra,0x0
 978:	dce080e7          	jalr	-562(ra) # 742 <vprintf>
}
 97c:	60e2                	ld	ra,24(sp)
 97e:	6442                	ld	s0,16(sp)
 980:	6125                	addi	sp,sp,96
 982:	8082                	ret

0000000000000984 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 984:	1141                	addi	sp,sp,-16
 986:	e422                	sd	s0,8(sp)
 988:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 98a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 98e:	00000797          	auipc	a5,0x0
 992:	1da7b783          	ld	a5,474(a5) # b68 <freep>
 996:	a805                	j	9c6 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 998:	4618                	lw	a4,8(a2)
 99a:	9db9                	addw	a1,a1,a4
 99c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 9a0:	6398                	ld	a4,0(a5)
 9a2:	6318                	ld	a4,0(a4)
 9a4:	fee53823          	sd	a4,-16(a0)
 9a8:	a091                	j	9ec <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 9aa:	ff852703          	lw	a4,-8(a0)
 9ae:	9e39                	addw	a2,a2,a4
 9b0:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 9b2:	ff053703          	ld	a4,-16(a0)
 9b6:	e398                	sd	a4,0(a5)
 9b8:	a099                	j	9fe <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9ba:	6398                	ld	a4,0(a5)
 9bc:	00e7e463          	bltu	a5,a4,9c4 <free+0x40>
 9c0:	00e6ea63          	bltu	a3,a4,9d4 <free+0x50>
{
 9c4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9c6:	fed7fae3          	bgeu	a5,a3,9ba <free+0x36>
 9ca:	6398                	ld	a4,0(a5)
 9cc:	00e6e463          	bltu	a3,a4,9d4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9d0:	fee7eae3          	bltu	a5,a4,9c4 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 9d4:	ff852583          	lw	a1,-8(a0)
 9d8:	6390                	ld	a2,0(a5)
 9da:	02059813          	slli	a6,a1,0x20
 9de:	01c85713          	srli	a4,a6,0x1c
 9e2:	9736                	add	a4,a4,a3
 9e4:	fae60ae3          	beq	a2,a4,998 <free+0x14>
    bp->s.ptr = p->s.ptr;
 9e8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 9ec:	4790                	lw	a2,8(a5)
 9ee:	02061593          	slli	a1,a2,0x20
 9f2:	01c5d713          	srli	a4,a1,0x1c
 9f6:	973e                	add	a4,a4,a5
 9f8:	fae689e3          	beq	a3,a4,9aa <free+0x26>
  } else
    p->s.ptr = bp;
 9fc:	e394                	sd	a3,0(a5)
  freep = p;
 9fe:	00000717          	auipc	a4,0x0
 a02:	16f73523          	sd	a5,362(a4) # b68 <freep>
}
 a06:	6422                	ld	s0,8(sp)
 a08:	0141                	addi	sp,sp,16
 a0a:	8082                	ret

0000000000000a0c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a0c:	7139                	addi	sp,sp,-64
 a0e:	fc06                	sd	ra,56(sp)
 a10:	f822                	sd	s0,48(sp)
 a12:	f426                	sd	s1,40(sp)
 a14:	f04a                	sd	s2,32(sp)
 a16:	ec4e                	sd	s3,24(sp)
 a18:	e852                	sd	s4,16(sp)
 a1a:	e456                	sd	s5,8(sp)
 a1c:	e05a                	sd	s6,0(sp)
 a1e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a20:	02051493          	slli	s1,a0,0x20
 a24:	9081                	srli	s1,s1,0x20
 a26:	04bd                	addi	s1,s1,15
 a28:	8091                	srli	s1,s1,0x4
 a2a:	0014899b          	addiw	s3,s1,1
 a2e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 a30:	00000517          	auipc	a0,0x0
 a34:	13853503          	ld	a0,312(a0) # b68 <freep>
 a38:	c515                	beqz	a0,a64 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a3a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a3c:	4798                	lw	a4,8(a5)
 a3e:	02977f63          	bgeu	a4,s1,a7c <malloc+0x70>
 a42:	8a4e                	mv	s4,s3
 a44:	0009871b          	sext.w	a4,s3
 a48:	6685                	lui	a3,0x1
 a4a:	00d77363          	bgeu	a4,a3,a50 <malloc+0x44>
 a4e:	6a05                	lui	s4,0x1
 a50:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 a54:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a58:	00000917          	auipc	s2,0x0
 a5c:	11090913          	addi	s2,s2,272 # b68 <freep>
  if(p == (char*)-1)
 a60:	5afd                	li	s5,-1
 a62:	a895                	j	ad6 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 a64:	00000797          	auipc	a5,0x0
 a68:	3fc78793          	addi	a5,a5,1020 # e60 <base>
 a6c:	00000717          	auipc	a4,0x0
 a70:	0ef73e23          	sd	a5,252(a4) # b68 <freep>
 a74:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a76:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a7a:	b7e1                	j	a42 <malloc+0x36>
      if(p->s.size == nunits)
 a7c:	02e48c63          	beq	s1,a4,ab4 <malloc+0xa8>
        p->s.size -= nunits;
 a80:	4137073b          	subw	a4,a4,s3
 a84:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a86:	02071693          	slli	a3,a4,0x20
 a8a:	01c6d713          	srli	a4,a3,0x1c
 a8e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a90:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a94:	00000717          	auipc	a4,0x0
 a98:	0ca73a23          	sd	a0,212(a4) # b68 <freep>
      return (void*)(p + 1);
 a9c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 aa0:	70e2                	ld	ra,56(sp)
 aa2:	7442                	ld	s0,48(sp)
 aa4:	74a2                	ld	s1,40(sp)
 aa6:	7902                	ld	s2,32(sp)
 aa8:	69e2                	ld	s3,24(sp)
 aaa:	6a42                	ld	s4,16(sp)
 aac:	6aa2                	ld	s5,8(sp)
 aae:	6b02                	ld	s6,0(sp)
 ab0:	6121                	addi	sp,sp,64
 ab2:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 ab4:	6398                	ld	a4,0(a5)
 ab6:	e118                	sd	a4,0(a0)
 ab8:	bff1                	j	a94 <malloc+0x88>
  hp->s.size = nu;
 aba:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 abe:	0541                	addi	a0,a0,16
 ac0:	00000097          	auipc	ra,0x0
 ac4:	ec4080e7          	jalr	-316(ra) # 984 <free>
  return freep;
 ac8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 acc:	d971                	beqz	a0,aa0 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ace:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 ad0:	4798                	lw	a4,8(a5)
 ad2:	fa9775e3          	bgeu	a4,s1,a7c <malloc+0x70>
    if(p == freep)
 ad6:	00093703          	ld	a4,0(s2)
 ada:	853e                	mv	a0,a5
 adc:	fef719e3          	bne	a4,a5,ace <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 ae0:	8552                	mv	a0,s4
 ae2:	00000097          	auipc	ra,0x0
 ae6:	b74080e7          	jalr	-1164(ra) # 656 <sbrk>
  if(p == (char*)-1)
 aea:	fd5518e3          	bne	a0,s5,aba <malloc+0xae>
        return 0;
 aee:	4501                	li	a0,0
 af0:	bf45                	j	aa0 <malloc+0x94>
