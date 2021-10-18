
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	e052                	sd	s4,0(sp)
   e:	1800                	addi	s0,sp,48
  10:	892a                	mv	s2,a0
  12:	89ae                	mv	s3,a1
  14:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  16:	02e00a13          	li	s4,46
    if(matchhere(re, text))
  1a:	85a6                	mv	a1,s1
  1c:	854e                	mv	a0,s3
  1e:	00000097          	auipc	ra,0x0
  22:	030080e7          	jalr	48(ra) # 4e <matchhere>
  26:	e919                	bnez	a0,3c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
  28:	0004c783          	lbu	a5,0(s1)
  2c:	cb89                	beqz	a5,3e <matchstar+0x3e>
  2e:	0485                	addi	s1,s1,1
  30:	2781                	sext.w	a5,a5
  32:	ff2784e3          	beq	a5,s2,1a <matchstar+0x1a>
  36:	ff4902e3          	beq	s2,s4,1a <matchstar+0x1a>
  3a:	a011                	j	3e <matchstar+0x3e>
      return 1;
  3c:	4505                	li	a0,1
  return 0;
}
  3e:	70a2                	ld	ra,40(sp)
  40:	7402                	ld	s0,32(sp)
  42:	64e2                	ld	s1,24(sp)
  44:	6942                	ld	s2,16(sp)
  46:	69a2                	ld	s3,8(sp)
  48:	6a02                	ld	s4,0(sp)
  4a:	6145                	addi	sp,sp,48
  4c:	8082                	ret

000000000000004e <matchhere>:
  if(re[0] == '\0')
  4e:	00054703          	lbu	a4,0(a0)
  52:	cb3d                	beqz	a4,c8 <matchhere+0x7a>
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  5c:	87aa                	mv	a5,a0
  if(re[1] == '*')
  5e:	00154683          	lbu	a3,1(a0)
  62:	02a00613          	li	a2,42
  66:	02c68563          	beq	a3,a2,90 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
  6a:	02400613          	li	a2,36
  6e:	02c70a63          	beq	a4,a2,a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  72:	0005c683          	lbu	a3,0(a1)
  return 0;
  76:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  78:	ca81                	beqz	a3,88 <matchhere+0x3a>
  7a:	02e00613          	li	a2,46
  7e:	02c70d63          	beq	a4,a2,b8 <matchhere+0x6a>
  return 0;
  82:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  84:	02d70a63          	beq	a4,a3,b8 <matchhere+0x6a>
}
  88:	60a2                	ld	ra,8(sp)
  8a:	6402                	ld	s0,0(sp)
  8c:	0141                	addi	sp,sp,16
  8e:	8082                	ret
    return matchstar(re[0], re+2, text);
  90:	862e                	mv	a2,a1
  92:	00250593          	addi	a1,a0,2
  96:	853a                	mv	a0,a4
  98:	00000097          	auipc	ra,0x0
  9c:	f68080e7          	jalr	-152(ra) # 0 <matchstar>
  a0:	b7e5                	j	88 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
  a2:	c691                	beqz	a3,ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  a4:	0005c683          	lbu	a3,0(a1)
  a8:	fee9                	bnez	a3,82 <matchhere+0x34>
  return 0;
  aa:	4501                	li	a0,0
  ac:	bff1                	j	88 <matchhere+0x3a>
    return *text == '\0';
  ae:	0005c503          	lbu	a0,0(a1)
  b2:	00153513          	seqz	a0,a0
  b6:	bfc9                	j	88 <matchhere+0x3a>
    return matchhere(re+1, text+1);
  b8:	0585                	addi	a1,a1,1
  ba:	00178513          	addi	a0,a5,1
  be:	00000097          	auipc	ra,0x0
  c2:	f90080e7          	jalr	-112(ra) # 4e <matchhere>
  c6:	b7c9                	j	88 <matchhere+0x3a>
    return 1;
  c8:	4505                	li	a0,1
}
  ca:	8082                	ret

00000000000000cc <match>:
{
  cc:	1101                	addi	sp,sp,-32
  ce:	ec06                	sd	ra,24(sp)
  d0:	e822                	sd	s0,16(sp)
  d2:	e426                	sd	s1,8(sp)
  d4:	e04a                	sd	s2,0(sp)
  d6:	1000                	addi	s0,sp,32
  d8:	892a                	mv	s2,a0
  da:	84ae                	mv	s1,a1
  if(re[0] == '^')
  dc:	00054703          	lbu	a4,0(a0)
  e0:	05e00793          	li	a5,94
  e4:	00f70e63          	beq	a4,a5,100 <match+0x34>
    if(matchhere(re, text))
  e8:	85a6                	mv	a1,s1
  ea:	854a                	mv	a0,s2
  ec:	00000097          	auipc	ra,0x0
  f0:	f62080e7          	jalr	-158(ra) # 4e <matchhere>
  f4:	ed01                	bnez	a0,10c <match+0x40>
  }while(*text++ != '\0');
  f6:	0485                	addi	s1,s1,1
  f8:	fff4c783          	lbu	a5,-1(s1)
  fc:	f7f5                	bnez	a5,e8 <match+0x1c>
  fe:	a801                	j	10e <match+0x42>
    return matchhere(re+1, text);
 100:	0505                	addi	a0,a0,1
 102:	00000097          	auipc	ra,0x0
 106:	f4c080e7          	jalr	-180(ra) # 4e <matchhere>
 10a:	a011                	j	10e <match+0x42>
      return 1;
 10c:	4505                	li	a0,1
}
 10e:	60e2                	ld	ra,24(sp)
 110:	6442                	ld	s0,16(sp)
 112:	64a2                	ld	s1,8(sp)
 114:	6902                	ld	s2,0(sp)
 116:	6105                	addi	sp,sp,32
 118:	8082                	ret

000000000000011a <grep>:
{
 11a:	715d                	addi	sp,sp,-80
 11c:	e486                	sd	ra,72(sp)
 11e:	e0a2                	sd	s0,64(sp)
 120:	fc26                	sd	s1,56(sp)
 122:	f84a                	sd	s2,48(sp)
 124:	f44e                	sd	s3,40(sp)
 126:	f052                	sd	s4,32(sp)
 128:	ec56                	sd	s5,24(sp)
 12a:	e85a                	sd	s6,16(sp)
 12c:	e45e                	sd	s7,8(sp)
 12e:	0880                	addi	s0,sp,80
 130:	89aa                	mv	s3,a0
 132:	8b2e                	mv	s6,a1
  m = 0;
 134:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 136:	3ff00b93          	li	s7,1023
 13a:	00001a97          	auipc	s5,0x1
 13e:	ba6a8a93          	addi	s5,s5,-1114 # ce0 <buf>
 142:	a0a1                	j	18a <grep+0x70>
      p = q+1;
 144:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
 148:	45a9                	li	a1,10
 14a:	854a                	mv	a0,s2
 14c:	00000097          	auipc	ra,0x0
 150:	428080e7          	jalr	1064(ra) # 574 <strchr>
 154:	84aa                	mv	s1,a0
 156:	c905                	beqz	a0,186 <grep+0x6c>
      *q = 0;
 158:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
 15c:	85ca                	mv	a1,s2
 15e:	854e                	mv	a0,s3
 160:	00000097          	auipc	ra,0x0
 164:	f6c080e7          	jalr	-148(ra) # cc <match>
 168:	dd71                	beqz	a0,144 <grep+0x2a>
        *q = '\n';
 16a:	47a9                	li	a5,10
 16c:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
 170:	00148613          	addi	a2,s1,1
 174:	4126063b          	subw	a2,a2,s2
 178:	85ca                	mv	a1,s2
 17a:	4505                	li	a0,1
 17c:	00000097          	auipc	ra,0x0
 180:	5f2080e7          	jalr	1522(ra) # 76e <write>
 184:	b7c1                	j	144 <grep+0x2a>
    if(m > 0){
 186:	03404563          	bgtz	s4,1b0 <grep+0x96>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18a:	414b863b          	subw	a2,s7,s4
 18e:	014a85b3          	add	a1,s5,s4
 192:	855a                	mv	a0,s6
 194:	00000097          	auipc	ra,0x0
 198:	5d2080e7          	jalr	1490(ra) # 766 <read>
 19c:	02a05663          	blez	a0,1c8 <grep+0xae>
    m += n;
 1a0:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
 1a4:	014a87b3          	add	a5,s5,s4
 1a8:	00078023          	sb	zero,0(a5)
    p = buf;
 1ac:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
 1ae:	bf69                	j	148 <grep+0x2e>
      m -= p - buf;
 1b0:	415907b3          	sub	a5,s2,s5
 1b4:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
 1b8:	8652                	mv	a2,s4
 1ba:	85ca                	mv	a1,s2
 1bc:	8556                	mv	a0,s5
 1be:	00000097          	auipc	ra,0x0
 1c2:	4de080e7          	jalr	1246(ra) # 69c <memmove>
 1c6:	b7d1                	j	18a <grep+0x70>
}
 1c8:	60a6                	ld	ra,72(sp)
 1ca:	6406                	ld	s0,64(sp)
 1cc:	74e2                	ld	s1,56(sp)
 1ce:	7942                	ld	s2,48(sp)
 1d0:	79a2                	ld	s3,40(sp)
 1d2:	7a02                	ld	s4,32(sp)
 1d4:	6ae2                	ld	s5,24(sp)
 1d6:	6b42                	ld	s6,16(sp)
 1d8:	6ba2                	ld	s7,8(sp)
 1da:	6161                	addi	sp,sp,80
 1dc:	8082                	ret

00000000000001de <main>:
{
 1de:	7139                	addi	sp,sp,-64
 1e0:	fc06                	sd	ra,56(sp)
 1e2:	f822                	sd	s0,48(sp)
 1e4:	f426                	sd	s1,40(sp)
 1e6:	f04a                	sd	s2,32(sp)
 1e8:	ec4e                	sd	s3,24(sp)
 1ea:	e852                	sd	s4,16(sp)
 1ec:	e456                	sd	s5,8(sp)
 1ee:	0080                	addi	s0,sp,64
  if(argc <= 1){
 1f0:	4785                	li	a5,1
 1f2:	04a7de63          	bge	a5,a0,24e <main+0x70>
  pattern = argv[1];
 1f6:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
 1fa:	4789                	li	a5,2
 1fc:	06a7d763          	bge	a5,a0,26a <main+0x8c>
 200:	01058913          	addi	s2,a1,16
 204:	ffd5099b          	addiw	s3,a0,-3
 208:	02099793          	slli	a5,s3,0x20
 20c:	01d7d993          	srli	s3,a5,0x1d
 210:	05e1                	addi	a1,a1,24
 212:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
 214:	4581                	li	a1,0
 216:	00093503          	ld	a0,0(s2)
 21a:	00000097          	auipc	ra,0x0
 21e:	574080e7          	jalr	1396(ra) # 78e <open>
 222:	84aa                	mv	s1,a0
 224:	04054e63          	bltz	a0,280 <main+0xa2>
    grep(pattern, fd);
 228:	85aa                	mv	a1,a0
 22a:	8552                	mv	a0,s4
 22c:	00000097          	auipc	ra,0x0
 230:	eee080e7          	jalr	-274(ra) # 11a <grep>
    close(fd);
 234:	8526                	mv	a0,s1
 236:	00000097          	auipc	ra,0x0
 23a:	540080e7          	jalr	1344(ra) # 776 <close>
  for(i = 2; i < argc; i++){
 23e:	0921                	addi	s2,s2,8
 240:	fd391ae3          	bne	s2,s3,214 <main+0x36>
  exit(0);
 244:	4501                	li	a0,0
 246:	00000097          	auipc	ra,0x0
 24a:	508080e7          	jalr	1288(ra) # 74e <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
 24e:	00001597          	auipc	a1,0x1
 252:	a2a58593          	addi	a1,a1,-1494 # c78 <malloc+0xec>
 256:	4509                	li	a0,2
 258:	00001097          	auipc	ra,0x1
 25c:	848080e7          	jalr	-1976(ra) # aa0 <fprintf>
    exit(1);
 260:	4505                	li	a0,1
 262:	00000097          	auipc	ra,0x0
 266:	4ec080e7          	jalr	1260(ra) # 74e <exit>
    grep(pattern, 0);
 26a:	4581                	li	a1,0
 26c:	8552                	mv	a0,s4
 26e:	00000097          	auipc	ra,0x0
 272:	eac080e7          	jalr	-340(ra) # 11a <grep>
    exit(0);
 276:	4501                	li	a0,0
 278:	00000097          	auipc	ra,0x0
 27c:	4d6080e7          	jalr	1238(ra) # 74e <exit>
      printf("grep: cannot open %s\n", argv[i]);
 280:	00093583          	ld	a1,0(s2)
 284:	00001517          	auipc	a0,0x1
 288:	a1450513          	addi	a0,a0,-1516 # c98 <malloc+0x10c>
 28c:	00001097          	auipc	ra,0x1
 290:	842080e7          	jalr	-1982(ra) # ace <printf>
      exit(1);
 294:	4505                	li	a0,1
 296:	00000097          	auipc	ra,0x0
 29a:	4b8080e7          	jalr	1208(ra) # 74e <exit>

000000000000029e <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 29e:	1141                	addi	sp,sp,-16
 2a0:	e422                	sd	s0,8(sp)
 2a2:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 2a4:	0f50000f          	fence	iorw,ow
 2a8:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 2ac:	6422                	ld	s0,8(sp)
 2ae:	0141                	addi	sp,sp,16
 2b0:	8082                	ret

00000000000002b2 <load>:

int load(uint64 *p) {
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e422                	sd	s0,8(sp)
 2b6:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 2b8:	0ff0000f          	fence
 2bc:	6108                	ld	a0,0(a0)
 2be:	0ff0000f          	fence
}
 2c2:	2501                	sext.w	a0,a0
 2c4:	6422                	ld	s0,8(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close, uint64 **addr){
 2ca:	7139                	addi	sp,sp,-64
 2cc:	fc06                	sd	ra,56(sp)
 2ce:	f822                	sd	s0,48(sp)
 2d0:	f426                	sd	s1,40(sp)
 2d2:	f04a                	sd	s2,32(sp)
 2d4:	ec4e                	sd	s3,24(sp)
 2d6:	e852                	sd	s4,16(sp)
 2d8:	e456                	sd	s5,8(sp)
 2da:	e05a                	sd	s6,0(sp)
 2dc:	0080                	addi	s0,sp,64
 2de:	8a2a                	mv	s4,a0
 2e0:	89ae                	mv	s3,a1
 2e2:	8ab2                	mv	s5,a2
  int i=0;
  // *addr = rings[i].buf;
  // ringbuf(name, open_close);
  if(open_close == 1){
 2e4:	4785                	li	a5,1
 2e6:	00001497          	auipc	s1,0x1
 2ea:	e0248493          	addi	s1,s1,-510 # 10e8 <rings+0x8>
 2ee:	00001917          	auipc	s2,0x1
 2f2:	eea90913          	addi	s2,s2,-278 # 11d8 <base+0x8>
    }
  }
  else{
    for(i = 0; i < 10; i++){
      if(rings[i].exists != 0){
        ringbuf(name, open_close, &vm_addr);
 2f6:	00001b17          	auipc	s6,0x1
 2fa:	9dab0b13          	addi	s6,s6,-1574 # cd0 <vm_addr>
  if(open_close == 1){
 2fe:	04f59063          	bne	a1,a5,33e <create_or_close_the_buffer_user+0x74>
      if(rings[i].exists == 0){
 302:	00001497          	auipc	s1,0x1
 306:	dee4a483          	lw	s1,-530(s1) # 10f0 <rings+0x10>
 30a:	c099                	beqz	s1,310 <create_or_close_the_buffer_user+0x46>
 30c:	4481                	li	s1,0
 30e:	a899                	j	364 <create_or_close_the_buffer_user+0x9a>
        ringbuf(name, open_close, &vm_addr);
 310:	865a                	mv	a2,s6
 312:	4585                	li	a1,1
 314:	00000097          	auipc	ra,0x0
 318:	4da080e7          	jalr	1242(ra) # 7ee <ringbuf>
        rings[i].book->write_done = 0;
 31c:	00001797          	auipc	a5,0x1
 320:	dc478793          	addi	a5,a5,-572 # 10e0 <rings>
 324:	6798                	ld	a4,8(a5)
 326:	00073423          	sd	zero,8(a4)
        rings[i].book->read_done = 0;
 32a:	6798                	ld	a4,8(a5)
 32c:	00073023          	sd	zero,0(a4)
        rings[i].exists++;
 330:	4b98                	lw	a4,16(a5)
 332:	2705                	addiw	a4,a4,1
 334:	cb98                	sw	a4,16(a5)
        break;
 336:	a03d                	j	364 <create_or_close_the_buffer_user+0x9a>
    for(i = 0; i < 10; i++){
 338:	04e1                	addi	s1,s1,24
 33a:	03248463          	beq	s1,s2,362 <create_or_close_the_buffer_user+0x98>
      if(rings[i].exists != 0){
 33e:	449c                	lw	a5,8(s1)
 340:	dfe5                	beqz	a5,338 <create_or_close_the_buffer_user+0x6e>
        ringbuf(name, open_close, &vm_addr);
 342:	865a                	mv	a2,s6
 344:	85ce                	mv	a1,s3
 346:	8552                	mv	a0,s4
 348:	00000097          	auipc	ra,0x0
 34c:	4a6080e7          	jalr	1190(ra) # 7ee <ringbuf>
        rings[i].book->write_done = 0;
 350:	609c                	ld	a5,0(s1)
 352:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 356:	609c                	ld	a5,0(s1)
 358:	0007b023          	sd	zero,0(a5)
        rings[i].exists = 0;
 35c:	0004a423          	sw	zero,8(s1)
 360:	bfe1                	j	338 <create_or_close_the_buffer_user+0x6e>
    for(i = 0; i < 10; i++){
 362:	44a9                	li	s1,10
        
      }
    }
  }
  *addr = (uint64*)vm_addr;
 364:	00001797          	auipc	a5,0x1
 368:	96c7b783          	ld	a5,-1684(a5) # cd0 <vm_addr>
 36c:	00fab023          	sd	a5,0(s5)
  return i;
}
 370:	8526                	mv	a0,s1
 372:	70e2                	ld	ra,56(sp)
 374:	7442                	ld	s0,48(sp)
 376:	74a2                	ld	s1,40(sp)
 378:	7902                	ld	s2,32(sp)
 37a:	69e2                	ld	s3,24(sp)
 37c:	6a42                	ld	s4,16(sp)
 37e:	6aa2                	ld	s5,8(sp)
 380:	6b02                	ld	s6,0(sp)
 382:	6121                	addi	sp,sp,64
 384:	8082                	ret

0000000000000386 <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ 
 386:	1101                	addi	sp,sp,-32
 388:	ec06                	sd	ra,24(sp)
 38a:	e822                	sd	s0,16(sp)
 38c:	e426                	sd	s1,8(sp)
 38e:	1000                	addi	s0,sp,32
 390:	84b2                	mv	s1,a2
  *addr = (uint64*)vm_addr;
 392:	00001797          	auipc	a5,0x1
 396:	93e7b783          	ld	a5,-1730(a5) # cd0 <vm_addr>
 39a:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 39c:	421c                	lw	a5,0(a2)
 39e:	e79d                	bnez	a5,3cc <ringbuf_start_write+0x46>
    *bytes = (4096*16) -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 3a0:	00001697          	auipc	a3,0x1
 3a4:	d4068693          	addi	a3,a3,-704 # 10e0 <rings>
 3a8:	669c                	ld	a5,8(a3)
 3aa:	6398                	ld	a4,0(a5)
 3ac:	67c1                	lui	a5,0x10
 3ae:	9fb9                	addw	a5,a5,a4
 3b0:	00151713          	slli	a4,a0,0x1
 3b4:	953a                	add	a0,a0,a4
 3b6:	050e                	slli	a0,a0,0x3
 3b8:	9536                	add	a0,a0,a3
 3ba:	6518                	ld	a4,8(a0)
 3bc:	6718                	ld	a4,8(a4)
 3be:	9f99                	subw	a5,a5,a4
 3c0:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 3c2:	60e2                	ld	ra,24(sp)
 3c4:	6442                	ld	s0,16(sp)
 3c6:	64a2                	ld	s1,8(sp)
 3c8:	6105                	addi	sp,sp,32
 3ca:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 3cc:	00151793          	slli	a5,a0,0x1
 3d0:	953e                	add	a0,a0,a5
 3d2:	050e                	slli	a0,a0,0x3
 3d4:	00001797          	auipc	a5,0x1
 3d8:	d0c78793          	addi	a5,a5,-756 # 10e0 <rings>
 3dc:	953e                	add	a0,a0,a5
 3de:	6508                	ld	a0,8(a0)
 3e0:	0521                	addi	a0,a0,8
 3e2:	00000097          	auipc	ra,0x0
 3e6:	ed0080e7          	jalr	-304(ra) # 2b2 <load>
 3ea:	c088                	sw	a0,0(s1)
}
 3ec:	bfd9                	j	3c2 <ringbuf_start_write+0x3c>

00000000000003ee <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 3ee:	1141                	addi	sp,sp,-16
 3f0:	e406                	sd	ra,8(sp)
 3f2:	e022                	sd	s0,0(sp)
 3f4:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 3f6:	00151793          	slli	a5,a0,0x1
 3fa:	97aa                	add	a5,a5,a0
 3fc:	078e                	slli	a5,a5,0x3
 3fe:	00001517          	auipc	a0,0x1
 402:	ce250513          	addi	a0,a0,-798 # 10e0 <rings>
 406:	97aa                	add	a5,a5,a0
 408:	6788                	ld	a0,8(a5)
 40a:	0035959b          	slliw	a1,a1,0x3
 40e:	0521                	addi	a0,a0,8
 410:	00000097          	auipc	ra,0x0
 414:	e8e080e7          	jalr	-370(ra) # 29e <store>
}
 418:	60a2                	ld	ra,8(sp)
 41a:	6402                	ld	s0,0(sp)
 41c:	0141                	addi	sp,sp,16
 41e:	8082                	ret

0000000000000420 <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 420:	1101                	addi	sp,sp,-32
 422:	ec06                	sd	ra,24(sp)
 424:	e822                	sd	s0,16(sp)
 426:	e426                	sd	s1,8(sp)
 428:	1000                	addi	s0,sp,32
 42a:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 42c:	00151793          	slli	a5,a0,0x1
 430:	97aa                	add	a5,a5,a0
 432:	078e                	slli	a5,a5,0x3
 434:	00001517          	auipc	a0,0x1
 438:	cac50513          	addi	a0,a0,-852 # 10e0 <rings>
 43c:	97aa                	add	a5,a5,a0
 43e:	6788                	ld	a0,8(a5)
 440:	0521                	addi	a0,a0,8
 442:	00000097          	auipc	ra,0x0
 446:	e70080e7          	jalr	-400(ra) # 2b2 <load>
 44a:	c088                	sw	a0,0(s1)
}
 44c:	60e2                	ld	ra,24(sp)
 44e:	6442                	ld	s0,16(sp)
 450:	64a2                	ld	s1,8(sp)
 452:	6105                	addi	sp,sp,32
 454:	8082                	ret

0000000000000456 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ 
 456:	1101                	addi	sp,sp,-32
 458:	ec06                	sd	ra,24(sp)
 45a:	e822                	sd	s0,16(sp)
 45c:	e426                	sd	s1,8(sp)
 45e:	1000                	addi	s0,sp,32
 460:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  if(rings[ring_desc].book -> read_done == 0){
 462:	00151793          	slli	a5,a0,0x1
 466:	97aa                	add	a5,a5,a0
 468:	078e                	slli	a5,a5,0x3
 46a:	00001517          	auipc	a0,0x1
 46e:	c7650513          	addi	a0,a0,-906 # 10e0 <rings>
 472:	97aa                	add	a5,a5,a0
 474:	6788                	ld	a0,8(a5)
 476:	611c                	ld	a5,0(a0)
 478:	ef99                	bnez	a5,496 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 47a:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 47c:	41f7579b          	sraiw	a5,a4,0x1f
 480:	01d7d79b          	srliw	a5,a5,0x1d
 484:	9fb9                	addw	a5,a5,a4
 486:	4037d79b          	sraiw	a5,a5,0x3
 48a:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 48c:	60e2                	ld	ra,24(sp)
 48e:	6442                	ld	s0,16(sp)
 490:	64a2                	ld	s1,8(sp)
 492:	6105                	addi	sp,sp,32
 494:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 496:	00000097          	auipc	ra,0x0
 49a:	e1c080e7          	jalr	-484(ra) # 2b2 <load>
    *bytes /= 8;
 49e:	41f5579b          	sraiw	a5,a0,0x1f
 4a2:	01d7d79b          	srliw	a5,a5,0x1d
 4a6:	9d3d                	addw	a0,a0,a5
 4a8:	4035551b          	sraiw	a0,a0,0x3
 4ac:	c088                	sw	a0,0(s1)
}
 4ae:	bff9                	j	48c <ringbuf_start_read+0x36>

00000000000004b0 <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 4b0:	1141                	addi	sp,sp,-16
 4b2:	e406                	sd	ra,8(sp)
 4b4:	e022                	sd	s0,0(sp)
 4b6:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 4b8:	00151793          	slli	a5,a0,0x1
 4bc:	97aa                	add	a5,a5,a0
 4be:	078e                	slli	a5,a5,0x3
 4c0:	00001517          	auipc	a0,0x1
 4c4:	c2050513          	addi	a0,a0,-992 # 10e0 <rings>
 4c8:	97aa                	add	a5,a5,a0
 4ca:	0035959b          	slliw	a1,a1,0x3
 4ce:	6788                	ld	a0,8(a5)
 4d0:	00000097          	auipc	ra,0x0
 4d4:	dce080e7          	jalr	-562(ra) # 29e <store>
}
 4d8:	60a2                	ld	ra,8(sp)
 4da:	6402                	ld	s0,0(sp)
 4dc:	0141                	addi	sp,sp,16
 4de:	8082                	ret

00000000000004e0 <strcpy>:



char*
strcpy(char *s, const char *t)
{
 4e0:	1141                	addi	sp,sp,-16
 4e2:	e422                	sd	s0,8(sp)
 4e4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4e6:	87aa                	mv	a5,a0
 4e8:	0585                	addi	a1,a1,1
 4ea:	0785                	addi	a5,a5,1
 4ec:	fff5c703          	lbu	a4,-1(a1)
 4f0:	fee78fa3          	sb	a4,-1(a5)
 4f4:	fb75                	bnez	a4,4e8 <strcpy+0x8>
    ;
  return os;
}
 4f6:	6422                	ld	s0,8(sp)
 4f8:	0141                	addi	sp,sp,16
 4fa:	8082                	ret

00000000000004fc <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4fc:	1141                	addi	sp,sp,-16
 4fe:	e422                	sd	s0,8(sp)
 500:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 502:	00054783          	lbu	a5,0(a0)
 506:	cb91                	beqz	a5,51a <strcmp+0x1e>
 508:	0005c703          	lbu	a4,0(a1)
 50c:	00f71763          	bne	a4,a5,51a <strcmp+0x1e>
    p++, q++;
 510:	0505                	addi	a0,a0,1
 512:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 514:	00054783          	lbu	a5,0(a0)
 518:	fbe5                	bnez	a5,508 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 51a:	0005c503          	lbu	a0,0(a1)
}
 51e:	40a7853b          	subw	a0,a5,a0
 522:	6422                	ld	s0,8(sp)
 524:	0141                	addi	sp,sp,16
 526:	8082                	ret

0000000000000528 <strlen>:

uint
strlen(const char *s)
{
 528:	1141                	addi	sp,sp,-16
 52a:	e422                	sd	s0,8(sp)
 52c:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 52e:	00054783          	lbu	a5,0(a0)
 532:	cf91                	beqz	a5,54e <strlen+0x26>
 534:	0505                	addi	a0,a0,1
 536:	87aa                	mv	a5,a0
 538:	4685                	li	a3,1
 53a:	9e89                	subw	a3,a3,a0
 53c:	00f6853b          	addw	a0,a3,a5
 540:	0785                	addi	a5,a5,1
 542:	fff7c703          	lbu	a4,-1(a5)
 546:	fb7d                	bnez	a4,53c <strlen+0x14>
    ;
  return n;
}
 548:	6422                	ld	s0,8(sp)
 54a:	0141                	addi	sp,sp,16
 54c:	8082                	ret
  for(n = 0; s[n]; n++)
 54e:	4501                	li	a0,0
 550:	bfe5                	j	548 <strlen+0x20>

0000000000000552 <memset>:

void*
memset(void *dst, int c, uint n)
{
 552:	1141                	addi	sp,sp,-16
 554:	e422                	sd	s0,8(sp)
 556:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 558:	ca19                	beqz	a2,56e <memset+0x1c>
 55a:	87aa                	mv	a5,a0
 55c:	1602                	slli	a2,a2,0x20
 55e:	9201                	srli	a2,a2,0x20
 560:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 564:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 568:	0785                	addi	a5,a5,1
 56a:	fee79de3          	bne	a5,a4,564 <memset+0x12>
  }
  return dst;
}
 56e:	6422                	ld	s0,8(sp)
 570:	0141                	addi	sp,sp,16
 572:	8082                	ret

0000000000000574 <strchr>:

char*
strchr(const char *s, char c)
{
 574:	1141                	addi	sp,sp,-16
 576:	e422                	sd	s0,8(sp)
 578:	0800                	addi	s0,sp,16
  for(; *s; s++)
 57a:	00054783          	lbu	a5,0(a0)
 57e:	cb99                	beqz	a5,594 <strchr+0x20>
    if(*s == c)
 580:	00f58763          	beq	a1,a5,58e <strchr+0x1a>
  for(; *s; s++)
 584:	0505                	addi	a0,a0,1
 586:	00054783          	lbu	a5,0(a0)
 58a:	fbfd                	bnez	a5,580 <strchr+0xc>
      return (char*)s;
  return 0;
 58c:	4501                	li	a0,0
}
 58e:	6422                	ld	s0,8(sp)
 590:	0141                	addi	sp,sp,16
 592:	8082                	ret
  return 0;
 594:	4501                	li	a0,0
 596:	bfe5                	j	58e <strchr+0x1a>

0000000000000598 <gets>:

char*
gets(char *buf, int max)
{
 598:	711d                	addi	sp,sp,-96
 59a:	ec86                	sd	ra,88(sp)
 59c:	e8a2                	sd	s0,80(sp)
 59e:	e4a6                	sd	s1,72(sp)
 5a0:	e0ca                	sd	s2,64(sp)
 5a2:	fc4e                	sd	s3,56(sp)
 5a4:	f852                	sd	s4,48(sp)
 5a6:	f456                	sd	s5,40(sp)
 5a8:	f05a                	sd	s6,32(sp)
 5aa:	ec5e                	sd	s7,24(sp)
 5ac:	1080                	addi	s0,sp,96
 5ae:	8baa                	mv	s7,a0
 5b0:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5b2:	892a                	mv	s2,a0
 5b4:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 5b6:	4aa9                	li	s5,10
 5b8:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 5ba:	89a6                	mv	s3,s1
 5bc:	2485                	addiw	s1,s1,1
 5be:	0344d863          	bge	s1,s4,5ee <gets+0x56>
    cc = read(0, &c, 1);
 5c2:	4605                	li	a2,1
 5c4:	faf40593          	addi	a1,s0,-81
 5c8:	4501                	li	a0,0
 5ca:	00000097          	auipc	ra,0x0
 5ce:	19c080e7          	jalr	412(ra) # 766 <read>
    if(cc < 1)
 5d2:	00a05e63          	blez	a0,5ee <gets+0x56>
    buf[i++] = c;
 5d6:	faf44783          	lbu	a5,-81(s0)
 5da:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 5de:	01578763          	beq	a5,s5,5ec <gets+0x54>
 5e2:	0905                	addi	s2,s2,1
 5e4:	fd679be3          	bne	a5,s6,5ba <gets+0x22>
  for(i=0; i+1 < max; ){
 5e8:	89a6                	mv	s3,s1
 5ea:	a011                	j	5ee <gets+0x56>
 5ec:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 5ee:	99de                	add	s3,s3,s7
 5f0:	00098023          	sb	zero,0(s3)
  return buf;
}
 5f4:	855e                	mv	a0,s7
 5f6:	60e6                	ld	ra,88(sp)
 5f8:	6446                	ld	s0,80(sp)
 5fa:	64a6                	ld	s1,72(sp)
 5fc:	6906                	ld	s2,64(sp)
 5fe:	79e2                	ld	s3,56(sp)
 600:	7a42                	ld	s4,48(sp)
 602:	7aa2                	ld	s5,40(sp)
 604:	7b02                	ld	s6,32(sp)
 606:	6be2                	ld	s7,24(sp)
 608:	6125                	addi	sp,sp,96
 60a:	8082                	ret

000000000000060c <stat>:

int
stat(const char *n, struct stat *st)
{
 60c:	1101                	addi	sp,sp,-32
 60e:	ec06                	sd	ra,24(sp)
 610:	e822                	sd	s0,16(sp)
 612:	e426                	sd	s1,8(sp)
 614:	e04a                	sd	s2,0(sp)
 616:	1000                	addi	s0,sp,32
 618:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 61a:	4581                	li	a1,0
 61c:	00000097          	auipc	ra,0x0
 620:	172080e7          	jalr	370(ra) # 78e <open>
  if(fd < 0)
 624:	02054563          	bltz	a0,64e <stat+0x42>
 628:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 62a:	85ca                	mv	a1,s2
 62c:	00000097          	auipc	ra,0x0
 630:	17a080e7          	jalr	378(ra) # 7a6 <fstat>
 634:	892a                	mv	s2,a0
  close(fd);
 636:	8526                	mv	a0,s1
 638:	00000097          	auipc	ra,0x0
 63c:	13e080e7          	jalr	318(ra) # 776 <close>
  return r;
}
 640:	854a                	mv	a0,s2
 642:	60e2                	ld	ra,24(sp)
 644:	6442                	ld	s0,16(sp)
 646:	64a2                	ld	s1,8(sp)
 648:	6902                	ld	s2,0(sp)
 64a:	6105                	addi	sp,sp,32
 64c:	8082                	ret
    return -1;
 64e:	597d                	li	s2,-1
 650:	bfc5                	j	640 <stat+0x34>

0000000000000652 <atoi>:

int
atoi(const char *s)
{
 652:	1141                	addi	sp,sp,-16
 654:	e422                	sd	s0,8(sp)
 656:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 658:	00054603          	lbu	a2,0(a0)
 65c:	fd06079b          	addiw	a5,a2,-48
 660:	0ff7f793          	zext.b	a5,a5
 664:	4725                	li	a4,9
 666:	02f76963          	bltu	a4,a5,698 <atoi+0x46>
 66a:	86aa                	mv	a3,a0
  n = 0;
 66c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 66e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 670:	0685                	addi	a3,a3,1
 672:	0025179b          	slliw	a5,a0,0x2
 676:	9fa9                	addw	a5,a5,a0
 678:	0017979b          	slliw	a5,a5,0x1
 67c:	9fb1                	addw	a5,a5,a2
 67e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 682:	0006c603          	lbu	a2,0(a3)
 686:	fd06071b          	addiw	a4,a2,-48
 68a:	0ff77713          	zext.b	a4,a4
 68e:	fee5f1e3          	bgeu	a1,a4,670 <atoi+0x1e>
  return n;
}
 692:	6422                	ld	s0,8(sp)
 694:	0141                	addi	sp,sp,16
 696:	8082                	ret
  n = 0;
 698:	4501                	li	a0,0
 69a:	bfe5                	j	692 <atoi+0x40>

000000000000069c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 69c:	1141                	addi	sp,sp,-16
 69e:	e422                	sd	s0,8(sp)
 6a0:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6a2:	02b57463          	bgeu	a0,a1,6ca <memmove+0x2e>
    while(n-- > 0)
 6a6:	00c05f63          	blez	a2,6c4 <memmove+0x28>
 6aa:	1602                	slli	a2,a2,0x20
 6ac:	9201                	srli	a2,a2,0x20
 6ae:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6b2:	872a                	mv	a4,a0
      *dst++ = *src++;
 6b4:	0585                	addi	a1,a1,1
 6b6:	0705                	addi	a4,a4,1
 6b8:	fff5c683          	lbu	a3,-1(a1)
 6bc:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6c0:	fee79ae3          	bne	a5,a4,6b4 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6c4:	6422                	ld	s0,8(sp)
 6c6:	0141                	addi	sp,sp,16
 6c8:	8082                	ret
    dst += n;
 6ca:	00c50733          	add	a4,a0,a2
    src += n;
 6ce:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 6d0:	fec05ae3          	blez	a2,6c4 <memmove+0x28>
 6d4:	fff6079b          	addiw	a5,a2,-1
 6d8:	1782                	slli	a5,a5,0x20
 6da:	9381                	srli	a5,a5,0x20
 6dc:	fff7c793          	not	a5,a5
 6e0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 6e2:	15fd                	addi	a1,a1,-1
 6e4:	177d                	addi	a4,a4,-1
 6e6:	0005c683          	lbu	a3,0(a1)
 6ea:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 6ee:	fee79ae3          	bne	a5,a4,6e2 <memmove+0x46>
 6f2:	bfc9                	j	6c4 <memmove+0x28>

00000000000006f4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 6f4:	1141                	addi	sp,sp,-16
 6f6:	e422                	sd	s0,8(sp)
 6f8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 6fa:	ca05                	beqz	a2,72a <memcmp+0x36>
 6fc:	fff6069b          	addiw	a3,a2,-1
 700:	1682                	slli	a3,a3,0x20
 702:	9281                	srli	a3,a3,0x20
 704:	0685                	addi	a3,a3,1
 706:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 708:	00054783          	lbu	a5,0(a0)
 70c:	0005c703          	lbu	a4,0(a1)
 710:	00e79863          	bne	a5,a4,720 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 714:	0505                	addi	a0,a0,1
    p2++;
 716:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 718:	fed518e3          	bne	a0,a3,708 <memcmp+0x14>
  }
  return 0;
 71c:	4501                	li	a0,0
 71e:	a019                	j	724 <memcmp+0x30>
      return *p1 - *p2;
 720:	40e7853b          	subw	a0,a5,a4
}
 724:	6422                	ld	s0,8(sp)
 726:	0141                	addi	sp,sp,16
 728:	8082                	ret
  return 0;
 72a:	4501                	li	a0,0
 72c:	bfe5                	j	724 <memcmp+0x30>

000000000000072e <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 72e:	1141                	addi	sp,sp,-16
 730:	e406                	sd	ra,8(sp)
 732:	e022                	sd	s0,0(sp)
 734:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 736:	00000097          	auipc	ra,0x0
 73a:	f66080e7          	jalr	-154(ra) # 69c <memmove>
}
 73e:	60a2                	ld	ra,8(sp)
 740:	6402                	ld	s0,0(sp)
 742:	0141                	addi	sp,sp,16
 744:	8082                	ret

0000000000000746 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 746:	4885                	li	a7,1
 ecall
 748:	00000073          	ecall
 ret
 74c:	8082                	ret

000000000000074e <exit>:
.global exit
exit:
 li a7, SYS_exit
 74e:	4889                	li	a7,2
 ecall
 750:	00000073          	ecall
 ret
 754:	8082                	ret

0000000000000756 <wait>:
.global wait
wait:
 li a7, SYS_wait
 756:	488d                	li	a7,3
 ecall
 758:	00000073          	ecall
 ret
 75c:	8082                	ret

000000000000075e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 75e:	4891                	li	a7,4
 ecall
 760:	00000073          	ecall
 ret
 764:	8082                	ret

0000000000000766 <read>:
.global read
read:
 li a7, SYS_read
 766:	4895                	li	a7,5
 ecall
 768:	00000073          	ecall
 ret
 76c:	8082                	ret

000000000000076e <write>:
.global write
write:
 li a7, SYS_write
 76e:	48c1                	li	a7,16
 ecall
 770:	00000073          	ecall
 ret
 774:	8082                	ret

0000000000000776 <close>:
.global close
close:
 li a7, SYS_close
 776:	48d5                	li	a7,21
 ecall
 778:	00000073          	ecall
 ret
 77c:	8082                	ret

000000000000077e <kill>:
.global kill
kill:
 li a7, SYS_kill
 77e:	4899                	li	a7,6
 ecall
 780:	00000073          	ecall
 ret
 784:	8082                	ret

0000000000000786 <exec>:
.global exec
exec:
 li a7, SYS_exec
 786:	489d                	li	a7,7
 ecall
 788:	00000073          	ecall
 ret
 78c:	8082                	ret

000000000000078e <open>:
.global open
open:
 li a7, SYS_open
 78e:	48bd                	li	a7,15
 ecall
 790:	00000073          	ecall
 ret
 794:	8082                	ret

0000000000000796 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 796:	48c5                	li	a7,17
 ecall
 798:	00000073          	ecall
 ret
 79c:	8082                	ret

000000000000079e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 79e:	48c9                	li	a7,18
 ecall
 7a0:	00000073          	ecall
 ret
 7a4:	8082                	ret

00000000000007a6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7a6:	48a1                	li	a7,8
 ecall
 7a8:	00000073          	ecall
 ret
 7ac:	8082                	ret

00000000000007ae <link>:
.global link
link:
 li a7, SYS_link
 7ae:	48cd                	li	a7,19
 ecall
 7b0:	00000073          	ecall
 ret
 7b4:	8082                	ret

00000000000007b6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7b6:	48d1                	li	a7,20
 ecall
 7b8:	00000073          	ecall
 ret
 7bc:	8082                	ret

00000000000007be <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7be:	48a5                	li	a7,9
 ecall
 7c0:	00000073          	ecall
 ret
 7c4:	8082                	ret

00000000000007c6 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7c6:	48a9                	li	a7,10
 ecall
 7c8:	00000073          	ecall
 ret
 7cc:	8082                	ret

00000000000007ce <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7ce:	48ad                	li	a7,11
 ecall
 7d0:	00000073          	ecall
 ret
 7d4:	8082                	ret

00000000000007d6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7d6:	48b1                	li	a7,12
 ecall
 7d8:	00000073          	ecall
 ret
 7dc:	8082                	ret

00000000000007de <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7de:	48b5                	li	a7,13
 ecall
 7e0:	00000073          	ecall
 ret
 7e4:	8082                	ret

00000000000007e6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 7e6:	48b9                	li	a7,14
 ecall
 7e8:	00000073          	ecall
 ret
 7ec:	8082                	ret

00000000000007ee <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 7ee:	48d9                	li	a7,22
 ecall
 7f0:	00000073          	ecall
 ret
 7f4:	8082                	ret

00000000000007f6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 7f6:	1101                	addi	sp,sp,-32
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 802:	4605                	li	a2,1
 804:	fef40593          	addi	a1,s0,-17
 808:	00000097          	auipc	ra,0x0
 80c:	f66080e7          	jalr	-154(ra) # 76e <write>
}
 810:	60e2                	ld	ra,24(sp)
 812:	6442                	ld	s0,16(sp)
 814:	6105                	addi	sp,sp,32
 816:	8082                	ret

0000000000000818 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 818:	7139                	addi	sp,sp,-64
 81a:	fc06                	sd	ra,56(sp)
 81c:	f822                	sd	s0,48(sp)
 81e:	f426                	sd	s1,40(sp)
 820:	f04a                	sd	s2,32(sp)
 822:	ec4e                	sd	s3,24(sp)
 824:	0080                	addi	s0,sp,64
 826:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 828:	c299                	beqz	a3,82e <printint+0x16>
 82a:	0805c863          	bltz	a1,8ba <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 82e:	2581                	sext.w	a1,a1
  neg = 0;
 830:	4881                	li	a7,0
 832:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 836:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 838:	2601                	sext.w	a2,a2
 83a:	00000517          	auipc	a0,0x0
 83e:	47e50513          	addi	a0,a0,1150 # cb8 <digits>
 842:	883a                	mv	a6,a4
 844:	2705                	addiw	a4,a4,1
 846:	02c5f7bb          	remuw	a5,a1,a2
 84a:	1782                	slli	a5,a5,0x20
 84c:	9381                	srli	a5,a5,0x20
 84e:	97aa                	add	a5,a5,a0
 850:	0007c783          	lbu	a5,0(a5)
 854:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 858:	0005879b          	sext.w	a5,a1
 85c:	02c5d5bb          	divuw	a1,a1,a2
 860:	0685                	addi	a3,a3,1
 862:	fec7f0e3          	bgeu	a5,a2,842 <printint+0x2a>
  if(neg)
 866:	00088b63          	beqz	a7,87c <printint+0x64>
    buf[i++] = '-';
 86a:	fd040793          	addi	a5,s0,-48
 86e:	973e                	add	a4,a4,a5
 870:	02d00793          	li	a5,45
 874:	fef70823          	sb	a5,-16(a4)
 878:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 87c:	02e05863          	blez	a4,8ac <printint+0x94>
 880:	fc040793          	addi	a5,s0,-64
 884:	00e78933          	add	s2,a5,a4
 888:	fff78993          	addi	s3,a5,-1
 88c:	99ba                	add	s3,s3,a4
 88e:	377d                	addiw	a4,a4,-1
 890:	1702                	slli	a4,a4,0x20
 892:	9301                	srli	a4,a4,0x20
 894:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 898:	fff94583          	lbu	a1,-1(s2)
 89c:	8526                	mv	a0,s1
 89e:	00000097          	auipc	ra,0x0
 8a2:	f58080e7          	jalr	-168(ra) # 7f6 <putc>
  while(--i >= 0)
 8a6:	197d                	addi	s2,s2,-1
 8a8:	ff3918e3          	bne	s2,s3,898 <printint+0x80>
}
 8ac:	70e2                	ld	ra,56(sp)
 8ae:	7442                	ld	s0,48(sp)
 8b0:	74a2                	ld	s1,40(sp)
 8b2:	7902                	ld	s2,32(sp)
 8b4:	69e2                	ld	s3,24(sp)
 8b6:	6121                	addi	sp,sp,64
 8b8:	8082                	ret
    x = -xx;
 8ba:	40b005bb          	negw	a1,a1
    neg = 1;
 8be:	4885                	li	a7,1
    x = -xx;
 8c0:	bf8d                	j	832 <printint+0x1a>

00000000000008c2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8c2:	7119                	addi	sp,sp,-128
 8c4:	fc86                	sd	ra,120(sp)
 8c6:	f8a2                	sd	s0,112(sp)
 8c8:	f4a6                	sd	s1,104(sp)
 8ca:	f0ca                	sd	s2,96(sp)
 8cc:	ecce                	sd	s3,88(sp)
 8ce:	e8d2                	sd	s4,80(sp)
 8d0:	e4d6                	sd	s5,72(sp)
 8d2:	e0da                	sd	s6,64(sp)
 8d4:	fc5e                	sd	s7,56(sp)
 8d6:	f862                	sd	s8,48(sp)
 8d8:	f466                	sd	s9,40(sp)
 8da:	f06a                	sd	s10,32(sp)
 8dc:	ec6e                	sd	s11,24(sp)
 8de:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8e0:	0005c903          	lbu	s2,0(a1)
 8e4:	18090f63          	beqz	s2,a82 <vprintf+0x1c0>
 8e8:	8aaa                	mv	s5,a0
 8ea:	8b32                	mv	s6,a2
 8ec:	00158493          	addi	s1,a1,1
  state = 0;
 8f0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8f2:	02500a13          	li	s4,37
      if(c == 'd'){
 8f6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 8fa:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 8fe:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 902:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 906:	00000b97          	auipc	s7,0x0
 90a:	3b2b8b93          	addi	s7,s7,946 # cb8 <digits>
 90e:	a839                	j	92c <vprintf+0x6a>
        putc(fd, c);
 910:	85ca                	mv	a1,s2
 912:	8556                	mv	a0,s5
 914:	00000097          	auipc	ra,0x0
 918:	ee2080e7          	jalr	-286(ra) # 7f6 <putc>
 91c:	a019                	j	922 <vprintf+0x60>
    } else if(state == '%'){
 91e:	01498f63          	beq	s3,s4,93c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 922:	0485                	addi	s1,s1,1
 924:	fff4c903          	lbu	s2,-1(s1)
 928:	14090d63          	beqz	s2,a82 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 92c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 930:	fe0997e3          	bnez	s3,91e <vprintf+0x5c>
      if(c == '%'){
 934:	fd479ee3          	bne	a5,s4,910 <vprintf+0x4e>
        state = '%';
 938:	89be                	mv	s3,a5
 93a:	b7e5                	j	922 <vprintf+0x60>
      if(c == 'd'){
 93c:	05878063          	beq	a5,s8,97c <vprintf+0xba>
      } else if(c == 'l') {
 940:	05978c63          	beq	a5,s9,998 <vprintf+0xd6>
      } else if(c == 'x') {
 944:	07a78863          	beq	a5,s10,9b4 <vprintf+0xf2>
      } else if(c == 'p') {
 948:	09b78463          	beq	a5,s11,9d0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 94c:	07300713          	li	a4,115
 950:	0ce78663          	beq	a5,a4,a1c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 954:	06300713          	li	a4,99
 958:	0ee78e63          	beq	a5,a4,a54 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 95c:	11478863          	beq	a5,s4,a6c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 960:	85d2                	mv	a1,s4
 962:	8556                	mv	a0,s5
 964:	00000097          	auipc	ra,0x0
 968:	e92080e7          	jalr	-366(ra) # 7f6 <putc>
        putc(fd, c);
 96c:	85ca                	mv	a1,s2
 96e:	8556                	mv	a0,s5
 970:	00000097          	auipc	ra,0x0
 974:	e86080e7          	jalr	-378(ra) # 7f6 <putc>
      }
      state = 0;
 978:	4981                	li	s3,0
 97a:	b765                	j	922 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 97c:	008b0913          	addi	s2,s6,8
 980:	4685                	li	a3,1
 982:	4629                	li	a2,10
 984:	000b2583          	lw	a1,0(s6)
 988:	8556                	mv	a0,s5
 98a:	00000097          	auipc	ra,0x0
 98e:	e8e080e7          	jalr	-370(ra) # 818 <printint>
 992:	8b4a                	mv	s6,s2
      state = 0;
 994:	4981                	li	s3,0
 996:	b771                	j	922 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 998:	008b0913          	addi	s2,s6,8
 99c:	4681                	li	a3,0
 99e:	4629                	li	a2,10
 9a0:	000b2583          	lw	a1,0(s6)
 9a4:	8556                	mv	a0,s5
 9a6:	00000097          	auipc	ra,0x0
 9aa:	e72080e7          	jalr	-398(ra) # 818 <printint>
 9ae:	8b4a                	mv	s6,s2
      state = 0;
 9b0:	4981                	li	s3,0
 9b2:	bf85                	j	922 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9b4:	008b0913          	addi	s2,s6,8
 9b8:	4681                	li	a3,0
 9ba:	4641                	li	a2,16
 9bc:	000b2583          	lw	a1,0(s6)
 9c0:	8556                	mv	a0,s5
 9c2:	00000097          	auipc	ra,0x0
 9c6:	e56080e7          	jalr	-426(ra) # 818 <printint>
 9ca:	8b4a                	mv	s6,s2
      state = 0;
 9cc:	4981                	li	s3,0
 9ce:	bf91                	j	922 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 9d0:	008b0793          	addi	a5,s6,8
 9d4:	f8f43423          	sd	a5,-120(s0)
 9d8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 9dc:	03000593          	li	a1,48
 9e0:	8556                	mv	a0,s5
 9e2:	00000097          	auipc	ra,0x0
 9e6:	e14080e7          	jalr	-492(ra) # 7f6 <putc>
  putc(fd, 'x');
 9ea:	85ea                	mv	a1,s10
 9ec:	8556                	mv	a0,s5
 9ee:	00000097          	auipc	ra,0x0
 9f2:	e08080e7          	jalr	-504(ra) # 7f6 <putc>
 9f6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 9f8:	03c9d793          	srli	a5,s3,0x3c
 9fc:	97de                	add	a5,a5,s7
 9fe:	0007c583          	lbu	a1,0(a5)
 a02:	8556                	mv	a0,s5
 a04:	00000097          	auipc	ra,0x0
 a08:	df2080e7          	jalr	-526(ra) # 7f6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a0c:	0992                	slli	s3,s3,0x4
 a0e:	397d                	addiw	s2,s2,-1
 a10:	fe0914e3          	bnez	s2,9f8 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 a14:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a18:	4981                	li	s3,0
 a1a:	b721                	j	922 <vprintf+0x60>
        s = va_arg(ap, char*);
 a1c:	008b0993          	addi	s3,s6,8
 a20:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 a24:	02090163          	beqz	s2,a46 <vprintf+0x184>
        while(*s != 0){
 a28:	00094583          	lbu	a1,0(s2)
 a2c:	c9a1                	beqz	a1,a7c <vprintf+0x1ba>
          putc(fd, *s);
 a2e:	8556                	mv	a0,s5
 a30:	00000097          	auipc	ra,0x0
 a34:	dc6080e7          	jalr	-570(ra) # 7f6 <putc>
          s++;
 a38:	0905                	addi	s2,s2,1
        while(*s != 0){
 a3a:	00094583          	lbu	a1,0(s2)
 a3e:	f9e5                	bnez	a1,a2e <vprintf+0x16c>
        s = va_arg(ap, char*);
 a40:	8b4e                	mv	s6,s3
      state = 0;
 a42:	4981                	li	s3,0
 a44:	bdf9                	j	922 <vprintf+0x60>
          s = "(null)";
 a46:	00000917          	auipc	s2,0x0
 a4a:	26a90913          	addi	s2,s2,618 # cb0 <malloc+0x124>
        while(*s != 0){
 a4e:	02800593          	li	a1,40
 a52:	bff1                	j	a2e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 a54:	008b0913          	addi	s2,s6,8
 a58:	000b4583          	lbu	a1,0(s6)
 a5c:	8556                	mv	a0,s5
 a5e:	00000097          	auipc	ra,0x0
 a62:	d98080e7          	jalr	-616(ra) # 7f6 <putc>
 a66:	8b4a                	mv	s6,s2
      state = 0;
 a68:	4981                	li	s3,0
 a6a:	bd65                	j	922 <vprintf+0x60>
        putc(fd, c);
 a6c:	85d2                	mv	a1,s4
 a6e:	8556                	mv	a0,s5
 a70:	00000097          	auipc	ra,0x0
 a74:	d86080e7          	jalr	-634(ra) # 7f6 <putc>
      state = 0;
 a78:	4981                	li	s3,0
 a7a:	b565                	j	922 <vprintf+0x60>
        s = va_arg(ap, char*);
 a7c:	8b4e                	mv	s6,s3
      state = 0;
 a7e:	4981                	li	s3,0
 a80:	b54d                	j	922 <vprintf+0x60>
    }
  }
}
 a82:	70e6                	ld	ra,120(sp)
 a84:	7446                	ld	s0,112(sp)
 a86:	74a6                	ld	s1,104(sp)
 a88:	7906                	ld	s2,96(sp)
 a8a:	69e6                	ld	s3,88(sp)
 a8c:	6a46                	ld	s4,80(sp)
 a8e:	6aa6                	ld	s5,72(sp)
 a90:	6b06                	ld	s6,64(sp)
 a92:	7be2                	ld	s7,56(sp)
 a94:	7c42                	ld	s8,48(sp)
 a96:	7ca2                	ld	s9,40(sp)
 a98:	7d02                	ld	s10,32(sp)
 a9a:	6de2                	ld	s11,24(sp)
 a9c:	6109                	addi	sp,sp,128
 a9e:	8082                	ret

0000000000000aa0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 aa0:	715d                	addi	sp,sp,-80
 aa2:	ec06                	sd	ra,24(sp)
 aa4:	e822                	sd	s0,16(sp)
 aa6:	1000                	addi	s0,sp,32
 aa8:	e010                	sd	a2,0(s0)
 aaa:	e414                	sd	a3,8(s0)
 aac:	e818                	sd	a4,16(s0)
 aae:	ec1c                	sd	a5,24(s0)
 ab0:	03043023          	sd	a6,32(s0)
 ab4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ab8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 abc:	8622                	mv	a2,s0
 abe:	00000097          	auipc	ra,0x0
 ac2:	e04080e7          	jalr	-508(ra) # 8c2 <vprintf>
}
 ac6:	60e2                	ld	ra,24(sp)
 ac8:	6442                	ld	s0,16(sp)
 aca:	6161                	addi	sp,sp,80
 acc:	8082                	ret

0000000000000ace <printf>:

void
printf(const char *fmt, ...)
{
 ace:	711d                	addi	sp,sp,-96
 ad0:	ec06                	sd	ra,24(sp)
 ad2:	e822                	sd	s0,16(sp)
 ad4:	1000                	addi	s0,sp,32
 ad6:	e40c                	sd	a1,8(s0)
 ad8:	e810                	sd	a2,16(s0)
 ada:	ec14                	sd	a3,24(s0)
 adc:	f018                	sd	a4,32(s0)
 ade:	f41c                	sd	a5,40(s0)
 ae0:	03043823          	sd	a6,48(s0)
 ae4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 ae8:	00840613          	addi	a2,s0,8
 aec:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 af0:	85aa                	mv	a1,a0
 af2:	4505                	li	a0,1
 af4:	00000097          	auipc	ra,0x0
 af8:	dce080e7          	jalr	-562(ra) # 8c2 <vprintf>
}
 afc:	60e2                	ld	ra,24(sp)
 afe:	6442                	ld	s0,16(sp)
 b00:	6125                	addi	sp,sp,96
 b02:	8082                	ret

0000000000000b04 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b04:	1141                	addi	sp,sp,-16
 b06:	e422                	sd	s0,8(sp)
 b08:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b0a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b0e:	00000797          	auipc	a5,0x0
 b12:	1ca7b783          	ld	a5,458(a5) # cd8 <freep>
 b16:	a805                	j	b46 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b18:	4618                	lw	a4,8(a2)
 b1a:	9db9                	addw	a1,a1,a4
 b1c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b20:	6398                	ld	a4,0(a5)
 b22:	6318                	ld	a4,0(a4)
 b24:	fee53823          	sd	a4,-16(a0)
 b28:	a091                	j	b6c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b2a:	ff852703          	lw	a4,-8(a0)
 b2e:	9e39                	addw	a2,a2,a4
 b30:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 b32:	ff053703          	ld	a4,-16(a0)
 b36:	e398                	sd	a4,0(a5)
 b38:	a099                	j	b7e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b3a:	6398                	ld	a4,0(a5)
 b3c:	00e7e463          	bltu	a5,a4,b44 <free+0x40>
 b40:	00e6ea63          	bltu	a3,a4,b54 <free+0x50>
{
 b44:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b46:	fed7fae3          	bgeu	a5,a3,b3a <free+0x36>
 b4a:	6398                	ld	a4,0(a5)
 b4c:	00e6e463          	bltu	a3,a4,b54 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b50:	fee7eae3          	bltu	a5,a4,b44 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 b54:	ff852583          	lw	a1,-8(a0)
 b58:	6390                	ld	a2,0(a5)
 b5a:	02059813          	slli	a6,a1,0x20
 b5e:	01c85713          	srli	a4,a6,0x1c
 b62:	9736                	add	a4,a4,a3
 b64:	fae60ae3          	beq	a2,a4,b18 <free+0x14>
    bp->s.ptr = p->s.ptr;
 b68:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b6c:	4790                	lw	a2,8(a5)
 b6e:	02061593          	slli	a1,a2,0x20
 b72:	01c5d713          	srli	a4,a1,0x1c
 b76:	973e                	add	a4,a4,a5
 b78:	fae689e3          	beq	a3,a4,b2a <free+0x26>
  } else
    p->s.ptr = bp;
 b7c:	e394                	sd	a3,0(a5)
  freep = p;
 b7e:	00000717          	auipc	a4,0x0
 b82:	14f73d23          	sd	a5,346(a4) # cd8 <freep>
}
 b86:	6422                	ld	s0,8(sp)
 b88:	0141                	addi	sp,sp,16
 b8a:	8082                	ret

0000000000000b8c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b8c:	7139                	addi	sp,sp,-64
 b8e:	fc06                	sd	ra,56(sp)
 b90:	f822                	sd	s0,48(sp)
 b92:	f426                	sd	s1,40(sp)
 b94:	f04a                	sd	s2,32(sp)
 b96:	ec4e                	sd	s3,24(sp)
 b98:	e852                	sd	s4,16(sp)
 b9a:	e456                	sd	s5,8(sp)
 b9c:	e05a                	sd	s6,0(sp)
 b9e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ba0:	02051493          	slli	s1,a0,0x20
 ba4:	9081                	srli	s1,s1,0x20
 ba6:	04bd                	addi	s1,s1,15
 ba8:	8091                	srli	s1,s1,0x4
 baa:	0014899b          	addiw	s3,s1,1
 bae:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 bb0:	00000517          	auipc	a0,0x0
 bb4:	12853503          	ld	a0,296(a0) # cd8 <freep>
 bb8:	c515                	beqz	a0,be4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bba:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bbc:	4798                	lw	a4,8(a5)
 bbe:	02977f63          	bgeu	a4,s1,bfc <malloc+0x70>
 bc2:	8a4e                	mv	s4,s3
 bc4:	0009871b          	sext.w	a4,s3
 bc8:	6685                	lui	a3,0x1
 bca:	00d77363          	bgeu	a4,a3,bd0 <malloc+0x44>
 bce:	6a05                	lui	s4,0x1
 bd0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bd4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bd8:	00000917          	auipc	s2,0x0
 bdc:	10090913          	addi	s2,s2,256 # cd8 <freep>
  if(p == (char*)-1)
 be0:	5afd                	li	s5,-1
 be2:	a895                	j	c56 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 be4:	00000797          	auipc	a5,0x0
 be8:	5ec78793          	addi	a5,a5,1516 # 11d0 <base>
 bec:	00000717          	auipc	a4,0x0
 bf0:	0ef73623          	sd	a5,236(a4) # cd8 <freep>
 bf4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 bf6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 bfa:	b7e1                	j	bc2 <malloc+0x36>
      if(p->s.size == nunits)
 bfc:	02e48c63          	beq	s1,a4,c34 <malloc+0xa8>
        p->s.size -= nunits;
 c00:	4137073b          	subw	a4,a4,s3
 c04:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c06:	02071693          	slli	a3,a4,0x20
 c0a:	01c6d713          	srli	a4,a3,0x1c
 c0e:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c10:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c14:	00000717          	auipc	a4,0x0
 c18:	0ca73223          	sd	a0,196(a4) # cd8 <freep>
      return (void*)(p + 1);
 c1c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c20:	70e2                	ld	ra,56(sp)
 c22:	7442                	ld	s0,48(sp)
 c24:	74a2                	ld	s1,40(sp)
 c26:	7902                	ld	s2,32(sp)
 c28:	69e2                	ld	s3,24(sp)
 c2a:	6a42                	ld	s4,16(sp)
 c2c:	6aa2                	ld	s5,8(sp)
 c2e:	6b02                	ld	s6,0(sp)
 c30:	6121                	addi	sp,sp,64
 c32:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c34:	6398                	ld	a4,0(a5)
 c36:	e118                	sd	a4,0(a0)
 c38:	bff1                	j	c14 <malloc+0x88>
  hp->s.size = nu;
 c3a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c3e:	0541                	addi	a0,a0,16
 c40:	00000097          	auipc	ra,0x0
 c44:	ec4080e7          	jalr	-316(ra) # b04 <free>
  return freep;
 c48:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c4c:	d971                	beqz	a0,c20 <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c4e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c50:	4798                	lw	a4,8(a5)
 c52:	fa9775e3          	bgeu	a4,s1,bfc <malloc+0x70>
    if(p == freep)
 c56:	00093703          	ld	a4,0(s2)
 c5a:	853e                	mv	a0,a5
 c5c:	fef719e3          	bne	a4,a5,c4e <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 c60:	8552                	mv	a0,s4
 c62:	00000097          	auipc	ra,0x0
 c66:	b74080e7          	jalr	-1164(ra) # 7d6 <sbrk>
  if(p == (char*)-1)
 c6a:	fd5518e3          	bne	a0,s5,c3a <malloc+0xae>
        return 0;
 c6e:	4501                	li	a0,0
 c70:	bf45                	j	c20 <malloc+0x94>
