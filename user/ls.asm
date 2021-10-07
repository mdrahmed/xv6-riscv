
user/_ls:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char *path)
{
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  10:	00000097          	auipc	ra,0x0
  14:	536080e7          	jalr	1334(ra) # 546 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    ;
  p++;
  36:	00178493          	addi	s1,a5,1

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	50a080e7          	jalr	1290(ra) # 546 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
  memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	4e8080e7          	jalr	1256(ra) # 546 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	cc298993          	addi	s3,s3,-830 # d28 <buf.0>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	644080e7          	jalr	1604(ra) # 6ba <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	4c6080e7          	jalr	1222(ra) # 546 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	4b8080e7          	jalr	1208(ra) # 546 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	4c8080e7          	jalr	1224(ra) # 570 <memset>
  return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <ls>:

void
ls(char *path)
{
  b4:	d9010113          	addi	sp,sp,-624
  b8:	26113423          	sd	ra,616(sp)
  bc:	26813023          	sd	s0,608(sp)
  c0:	24913c23          	sd	s1,600(sp)
  c4:	25213823          	sd	s2,592(sp)
  c8:	25313423          	sd	s3,584(sp)
  cc:	25413023          	sd	s4,576(sp)
  d0:	23513c23          	sd	s5,568(sp)
  d4:	1c80                	addi	s0,sp,624
  d6:	892a                	mv	s2,a0
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  d8:	4581                	li	a1,0
  da:	00000097          	auipc	ra,0x0
  de:	6d2080e7          	jalr	1746(ra) # 7ac <open>
  e2:	06054f63          	bltz	a0,160 <ls+0xac>
  e6:	84aa                	mv	s1,a0
    fprintf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
  e8:	d9840593          	addi	a1,s0,-616
  ec:	00000097          	auipc	ra,0x0
  f0:	6d8080e7          	jalr	1752(ra) # 7c4 <fstat>
  f4:	08054163          	bltz	a0,176 <ls+0xc2>
    fprintf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  f8:	da041783          	lh	a5,-608(s0)
  fc:	0007869b          	sext.w	a3,a5
 100:	4705                	li	a4,1
 102:	08e68a63          	beq	a3,a4,196 <ls+0xe2>
 106:	4709                	li	a4,2
 108:	02e69663          	bne	a3,a4,134 <ls+0x80>
  case T_FILE:
    printf("%s %d %d %l\n", fmtname(path), st.type, st.ino, st.size);
 10c:	854a                	mv	a0,s2
 10e:	00000097          	auipc	ra,0x0
 112:	ef2080e7          	jalr	-270(ra) # 0 <fmtname>
 116:	85aa                	mv	a1,a0
 118:	da843703          	ld	a4,-600(s0)
 11c:	d9c42683          	lw	a3,-612(s0)
 120:	da041603          	lh	a2,-608(s0)
 124:	00001517          	auipc	a0,0x1
 128:	b9c50513          	addi	a0,a0,-1124 # cc0 <malloc+0x116>
 12c:	00001097          	auipc	ra,0x1
 130:	9c0080e7          	jalr	-1600(ra) # aec <printf>
      }
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
 134:	8526                	mv	a0,s1
 136:	00000097          	auipc	ra,0x0
 13a:	65e080e7          	jalr	1630(ra) # 794 <close>
}
 13e:	26813083          	ld	ra,616(sp)
 142:	26013403          	ld	s0,608(sp)
 146:	25813483          	ld	s1,600(sp)
 14a:	25013903          	ld	s2,592(sp)
 14e:	24813983          	ld	s3,584(sp)
 152:	24013a03          	ld	s4,576(sp)
 156:	23813a83          	ld	s5,568(sp)
 15a:	27010113          	addi	sp,sp,624
 15e:	8082                	ret
    fprintf(2, "ls: cannot open %s\n", path);
 160:	864a                	mv	a2,s2
 162:	00001597          	auipc	a1,0x1
 166:	b2e58593          	addi	a1,a1,-1234 # c90 <malloc+0xe6>
 16a:	4509                	li	a0,2
 16c:	00001097          	auipc	ra,0x1
 170:	952080e7          	jalr	-1710(ra) # abe <fprintf>
    return;
 174:	b7e9                	j	13e <ls+0x8a>
    fprintf(2, "ls: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	b3058593          	addi	a1,a1,-1232 # ca8 <malloc+0xfe>
 180:	4509                	li	a0,2
 182:	00001097          	auipc	ra,0x1
 186:	93c080e7          	jalr	-1732(ra) # abe <fprintf>
    close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	608080e7          	jalr	1544(ra) # 794 <close>
    return;
 194:	b76d                	j	13e <ls+0x8a>
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 196:	854a                	mv	a0,s2
 198:	00000097          	auipc	ra,0x0
 19c:	3ae080e7          	jalr	942(ra) # 546 <strlen>
 1a0:	2541                	addiw	a0,a0,16
 1a2:	20000793          	li	a5,512
 1a6:	00a7fb63          	bgeu	a5,a0,1bc <ls+0x108>
      printf("ls: path too long\n");
 1aa:	00001517          	auipc	a0,0x1
 1ae:	b2650513          	addi	a0,a0,-1242 # cd0 <malloc+0x126>
 1b2:	00001097          	auipc	ra,0x1
 1b6:	93a080e7          	jalr	-1734(ra) # aec <printf>
      break;
 1ba:	bfad                	j	134 <ls+0x80>
    strcpy(buf, path);
 1bc:	85ca                	mv	a1,s2
 1be:	dc040513          	addi	a0,s0,-576
 1c2:	00000097          	auipc	ra,0x0
 1c6:	33c080e7          	jalr	828(ra) # 4fe <strcpy>
    p = buf+strlen(buf);
 1ca:	dc040513          	addi	a0,s0,-576
 1ce:	00000097          	auipc	ra,0x0
 1d2:	378080e7          	jalr	888(ra) # 546 <strlen>
 1d6:	02051913          	slli	s2,a0,0x20
 1da:	02095913          	srli	s2,s2,0x20
 1de:	dc040793          	addi	a5,s0,-576
 1e2:	993e                	add	s2,s2,a5
    *p++ = '/';
 1e4:	00190993          	addi	s3,s2,1
 1e8:	02f00793          	li	a5,47
 1ec:	00f90023          	sb	a5,0(s2)
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 1f0:	00001a17          	auipc	s4,0x1
 1f4:	af8a0a13          	addi	s4,s4,-1288 # ce8 <malloc+0x13e>
        printf("ls: cannot stat %s\n", buf);
 1f8:	00001a97          	auipc	s5,0x1
 1fc:	ab0a8a93          	addi	s5,s5,-1360 # ca8 <malloc+0xfe>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 200:	a801                	j	210 <ls+0x15c>
        printf("ls: cannot stat %s\n", buf);
 202:	dc040593          	addi	a1,s0,-576
 206:	8556                	mv	a0,s5
 208:	00001097          	auipc	ra,0x1
 20c:	8e4080e7          	jalr	-1820(ra) # aec <printf>
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 210:	4641                	li	a2,16
 212:	db040593          	addi	a1,s0,-592
 216:	8526                	mv	a0,s1
 218:	00000097          	auipc	ra,0x0
 21c:	56c080e7          	jalr	1388(ra) # 784 <read>
 220:	47c1                	li	a5,16
 222:	f0f519e3          	bne	a0,a5,134 <ls+0x80>
      if(de.inum == 0)
 226:	db045783          	lhu	a5,-592(s0)
 22a:	d3fd                	beqz	a5,210 <ls+0x15c>
      memmove(p, de.name, DIRSIZ);
 22c:	4639                	li	a2,14
 22e:	db240593          	addi	a1,s0,-590
 232:	854e                	mv	a0,s3
 234:	00000097          	auipc	ra,0x0
 238:	486080e7          	jalr	1158(ra) # 6ba <memmove>
      p[DIRSIZ] = 0;
 23c:	000907a3          	sb	zero,15(s2)
      if(stat(buf, &st) < 0){
 240:	d9840593          	addi	a1,s0,-616
 244:	dc040513          	addi	a0,s0,-576
 248:	00000097          	auipc	ra,0x0
 24c:	3e2080e7          	jalr	994(ra) # 62a <stat>
 250:	fa0549e3          	bltz	a0,202 <ls+0x14e>
      printf("%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 254:	dc040513          	addi	a0,s0,-576
 258:	00000097          	auipc	ra,0x0
 25c:	da8080e7          	jalr	-600(ra) # 0 <fmtname>
 260:	85aa                	mv	a1,a0
 262:	da843703          	ld	a4,-600(s0)
 266:	d9c42683          	lw	a3,-612(s0)
 26a:	da041603          	lh	a2,-608(s0)
 26e:	8552                	mv	a0,s4
 270:	00001097          	auipc	ra,0x1
 274:	87c080e7          	jalr	-1924(ra) # aec <printf>
 278:	bf61                	j	210 <ls+0x15c>

000000000000027a <main>:

int
main(int argc, char *argv[])
{
 27a:	1101                	addi	sp,sp,-32
 27c:	ec06                	sd	ra,24(sp)
 27e:	e822                	sd	s0,16(sp)
 280:	e426                	sd	s1,8(sp)
 282:	e04a                	sd	s2,0(sp)
 284:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
 286:	4785                	li	a5,1
 288:	02a7d963          	bge	a5,a0,2ba <main+0x40>
 28c:	00858493          	addi	s1,a1,8
 290:	ffe5091b          	addiw	s2,a0,-2
 294:	02091793          	slli	a5,s2,0x20
 298:	01d7d913          	srli	s2,a5,0x1d
 29c:	05c1                	addi	a1,a1,16
 29e:	992e                	add	s2,s2,a1
    ls(".");
    exit(0);
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
 2a0:	6088                	ld	a0,0(s1)
 2a2:	00000097          	auipc	ra,0x0
 2a6:	e12080e7          	jalr	-494(ra) # b4 <ls>
  for(i=1; i<argc; i++)
 2aa:	04a1                	addi	s1,s1,8
 2ac:	ff249ae3          	bne	s1,s2,2a0 <main+0x26>
  exit(0);
 2b0:	4501                	li	a0,0
 2b2:	00000097          	auipc	ra,0x0
 2b6:	4ba080e7          	jalr	1210(ra) # 76c <exit>
    ls(".");
 2ba:	00001517          	auipc	a0,0x1
 2be:	a3e50513          	addi	a0,a0,-1474 # cf8 <malloc+0x14e>
 2c2:	00000097          	auipc	ra,0x0
 2c6:	df2080e7          	jalr	-526(ra) # b4 <ls>
    exit(0);
 2ca:	4501                	li	a0,0
 2cc:	00000097          	auipc	ra,0x0
 2d0:	4a0080e7          	jalr	1184(ra) # 76c <exit>

00000000000002d4 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
 2d4:	1141                	addi	sp,sp,-16
 2d6:	e422                	sd	s0,8(sp)
 2d8:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
 2da:	0f50000f          	fence	iorw,ow
 2de:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
 2e2:	6422                	ld	s0,8(sp)
 2e4:	0141                	addi	sp,sp,16
 2e6:	8082                	ret

00000000000002e8 <load>:

int load(uint64 *p) {
 2e8:	1141                	addi	sp,sp,-16
 2ea:	e422                	sd	s0,8(sp)
 2ec:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
 2ee:	0ff0000f          	fence
 2f2:	6108                	ld	a0,0(a0)
 2f4:	0ff0000f          	fence
}
 2f8:	2501                	sext.w	a0,a0
 2fa:	6422                	ld	s0,8(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
 300:	7179                	addi	sp,sp,-48
 302:	f406                	sd	ra,40(sp)
 304:	f022                	sd	s0,32(sp)
 306:	ec26                	sd	s1,24(sp)
 308:	e84a                	sd	s2,16(sp)
 30a:	e44e                	sd	s3,8(sp)
 30c:	e052                	sd	s4,0(sp)
 30e:	1800                	addi	s0,sp,48
 310:	8a2a                	mv	s4,a0
 312:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
 314:	4785                	li	a5,1
 316:	00001497          	auipc	s1,0x1
 31a:	a3248493          	addi	s1,s1,-1486 # d48 <rings+0x10>
 31e:	00001917          	auipc	s2,0x1
 322:	b1a90913          	addi	s2,s2,-1254 # e38 <__BSS_END__>
 326:	04f59563          	bne	a1,a5,370 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
 32a:	00001497          	auipc	s1,0x1
 32e:	a1e4a483          	lw	s1,-1506(s1) # d48 <rings+0x10>
 332:	c099                	beqz	s1,338 <create_or_close_the_buffer_user+0x38>
 334:	4481                	li	s1,0
 336:	a899                	j	38c <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
 338:	00001917          	auipc	s2,0x1
 33c:	a0090913          	addi	s2,s2,-1536 # d38 <rings>
 340:	00093603          	ld	a2,0(s2)
 344:	4585                	li	a1,1
 346:	00000097          	auipc	ra,0x0
 34a:	4c6080e7          	jalr	1222(ra) # 80c <ringbuf>
        rings[i].book->write_done = 0;
 34e:	00893783          	ld	a5,8(s2)
 352:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
 356:	00893783          	ld	a5,8(s2)
 35a:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
 35e:	01092783          	lw	a5,16(s2)
 362:	2785                	addiw	a5,a5,1
 364:	00f92823          	sw	a5,16(s2)
        break;
 368:	a015                	j	38c <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
 36a:	04e1                	addi	s1,s1,24
 36c:	01248f63          	beq	s1,s2,38a <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
 370:	409c                	lw	a5,0(s1)
 372:	dfe5                	beqz	a5,36a <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
 374:	ff04b603          	ld	a2,-16(s1)
 378:	85ce                	mv	a1,s3
 37a:	8552                	mv	a0,s4
 37c:	00000097          	auipc	ra,0x0
 380:	490080e7          	jalr	1168(ra) # 80c <ringbuf>
        rings[i].exists = 0;
 384:	0004a023          	sw	zero,0(s1)
 388:	b7cd                	j	36a <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
 38a:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
 38c:	8526                	mv	a0,s1
 38e:	70a2                	ld	ra,40(sp)
 390:	7402                	ld	s0,32(sp)
 392:	64e2                	ld	s1,24(sp)
 394:	6942                	ld	s2,16(sp)
 396:	69a2                	ld	s3,8(sp)
 398:	6a02                	ld	s4,0(sp)
 39a:	6145                	addi	sp,sp,48
 39c:	8082                	ret

000000000000039e <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
 39e:	1101                	addi	sp,sp,-32
 3a0:	ec06                	sd	ra,24(sp)
 3a2:	e822                	sd	s0,16(sp)
 3a4:	e426                	sd	s1,8(sp)
 3a6:	1000                	addi	s0,sp,32
 3a8:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
 3aa:	00151793          	slli	a5,a0,0x1
 3ae:	97aa                	add	a5,a5,a0
 3b0:	078e                	slli	a5,a5,0x3
 3b2:	00001717          	auipc	a4,0x1
 3b6:	98670713          	addi	a4,a4,-1658 # d38 <rings>
 3ba:	97ba                	add	a5,a5,a4
 3bc:	639c                	ld	a5,0(a5)
 3be:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
 3c0:	421c                	lw	a5,0(a2)
 3c2:	e785                	bnez	a5,3ea <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
 3c4:	86ba                	mv	a3,a4
 3c6:	671c                	ld	a5,8(a4)
 3c8:	6398                	ld	a4,0(a5)
 3ca:	67c1                	lui	a5,0x10
 3cc:	9fb9                	addw	a5,a5,a4
 3ce:	00151713          	slli	a4,a0,0x1
 3d2:	953a                	add	a0,a0,a4
 3d4:	050e                	slli	a0,a0,0x3
 3d6:	9536                	add	a0,a0,a3
 3d8:	6518                	ld	a4,8(a0)
 3da:	6718                	ld	a4,8(a4)
 3dc:	9f99                	subw	a5,a5,a4
 3de:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
 3e0:	60e2                	ld	ra,24(sp)
 3e2:	6442                	ld	s0,16(sp)
 3e4:	64a2                	ld	s1,8(sp)
 3e6:	6105                	addi	sp,sp,32
 3e8:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
 3ea:	00151793          	slli	a5,a0,0x1
 3ee:	953e                	add	a0,a0,a5
 3f0:	050e                	slli	a0,a0,0x3
 3f2:	00001797          	auipc	a5,0x1
 3f6:	94678793          	addi	a5,a5,-1722 # d38 <rings>
 3fa:	953e                	add	a0,a0,a5
 3fc:	6508                	ld	a0,8(a0)
 3fe:	0521                	addi	a0,a0,8
 400:	00000097          	auipc	ra,0x0
 404:	ee8080e7          	jalr	-280(ra) # 2e8 <load>
 408:	c088                	sw	a0,0(s1)
}
 40a:	bfd9                	j	3e0 <ringbuf_start_write+0x42>

000000000000040c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
 40c:	1141                	addi	sp,sp,-16
 40e:	e406                	sd	ra,8(sp)
 410:	e022                	sd	s0,0(sp)
 412:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
 414:	00151793          	slli	a5,a0,0x1
 418:	97aa                	add	a5,a5,a0
 41a:	078e                	slli	a5,a5,0x3
 41c:	00001517          	auipc	a0,0x1
 420:	91c50513          	addi	a0,a0,-1764 # d38 <rings>
 424:	97aa                	add	a5,a5,a0
 426:	6788                	ld	a0,8(a5)
 428:	0035959b          	slliw	a1,a1,0x3
 42c:	0521                	addi	a0,a0,8
 42e:	00000097          	auipc	ra,0x0
 432:	ea6080e7          	jalr	-346(ra) # 2d4 <store>
}
 436:	60a2                	ld	ra,8(sp)
 438:	6402                	ld	s0,0(sp)
 43a:	0141                	addi	sp,sp,16
 43c:	8082                	ret

000000000000043e <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
 43e:	1101                	addi	sp,sp,-32
 440:	ec06                	sd	ra,24(sp)
 442:	e822                	sd	s0,16(sp)
 444:	e426                	sd	s1,8(sp)
 446:	1000                	addi	s0,sp,32
 448:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
 44a:	00151793          	slli	a5,a0,0x1
 44e:	97aa                	add	a5,a5,a0
 450:	078e                	slli	a5,a5,0x3
 452:	00001517          	auipc	a0,0x1
 456:	8e650513          	addi	a0,a0,-1818 # d38 <rings>
 45a:	97aa                	add	a5,a5,a0
 45c:	6788                	ld	a0,8(a5)
 45e:	0521                	addi	a0,a0,8
 460:	00000097          	auipc	ra,0x0
 464:	e88080e7          	jalr	-376(ra) # 2e8 <load>
 468:	c088                	sw	a0,0(s1)
}
 46a:	60e2                	ld	ra,24(sp)
 46c:	6442                	ld	s0,16(sp)
 46e:	64a2                	ld	s1,8(sp)
 470:	6105                	addi	sp,sp,32
 472:	8082                	ret

0000000000000474 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
 474:	1101                	addi	sp,sp,-32
 476:	ec06                	sd	ra,24(sp)
 478:	e822                	sd	s0,16(sp)
 47a:	e426                	sd	s1,8(sp)
 47c:	1000                	addi	s0,sp,32
 47e:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
 480:	00151793          	slli	a5,a0,0x1
 484:	97aa                	add	a5,a5,a0
 486:	078e                	slli	a5,a5,0x3
 488:	00001517          	auipc	a0,0x1
 48c:	8b050513          	addi	a0,a0,-1872 # d38 <rings>
 490:	97aa                	add	a5,a5,a0
 492:	6788                	ld	a0,8(a5)
 494:	611c                	ld	a5,0(a0)
 496:	ef99                	bnez	a5,4b4 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
 498:	6518                	ld	a4,8(a0)
    *bytes /= 8;
 49a:	41f7579b          	sraiw	a5,a4,0x1f
 49e:	01d7d79b          	srliw	a5,a5,0x1d
 4a2:	9fb9                	addw	a5,a5,a4
 4a4:	4037d79b          	sraiw	a5,a5,0x3
 4a8:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
 4aa:	60e2                	ld	ra,24(sp)
 4ac:	6442                	ld	s0,16(sp)
 4ae:	64a2                	ld	s1,8(sp)
 4b0:	6105                	addi	sp,sp,32
 4b2:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
 4b4:	00000097          	auipc	ra,0x0
 4b8:	e34080e7          	jalr	-460(ra) # 2e8 <load>
    *bytes /= 8;
 4bc:	41f5579b          	sraiw	a5,a0,0x1f
 4c0:	01d7d79b          	srliw	a5,a5,0x1d
 4c4:	9d3d                	addw	a0,a0,a5
 4c6:	4035551b          	sraiw	a0,a0,0x3
 4ca:	c088                	sw	a0,0(s1)
}
 4cc:	bff9                	j	4aa <ringbuf_start_read+0x36>

00000000000004ce <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
 4ce:	1141                	addi	sp,sp,-16
 4d0:	e406                	sd	ra,8(sp)
 4d2:	e022                	sd	s0,0(sp)
 4d4:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
 4d6:	00151793          	slli	a5,a0,0x1
 4da:	97aa                	add	a5,a5,a0
 4dc:	078e                	slli	a5,a5,0x3
 4de:	00001517          	auipc	a0,0x1
 4e2:	85a50513          	addi	a0,a0,-1958 # d38 <rings>
 4e6:	97aa                	add	a5,a5,a0
 4e8:	0035959b          	slliw	a1,a1,0x3
 4ec:	6788                	ld	a0,8(a5)
 4ee:	00000097          	auipc	ra,0x0
 4f2:	de6080e7          	jalr	-538(ra) # 2d4 <store>
}
 4f6:	60a2                	ld	ra,8(sp)
 4f8:	6402                	ld	s0,0(sp)
 4fa:	0141                	addi	sp,sp,16
 4fc:	8082                	ret

00000000000004fe <strcpy>:



char*
strcpy(char *s, const char *t)
{
 4fe:	1141                	addi	sp,sp,-16
 500:	e422                	sd	s0,8(sp)
 502:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 504:	87aa                	mv	a5,a0
 506:	0585                	addi	a1,a1,1
 508:	0785                	addi	a5,a5,1
 50a:	fff5c703          	lbu	a4,-1(a1)
 50e:	fee78fa3          	sb	a4,-1(a5)
 512:	fb75                	bnez	a4,506 <strcpy+0x8>
    ;
  return os;
}
 514:	6422                	ld	s0,8(sp)
 516:	0141                	addi	sp,sp,16
 518:	8082                	ret

000000000000051a <strcmp>:

int
strcmp(const char *p, const char *q)
{
 51a:	1141                	addi	sp,sp,-16
 51c:	e422                	sd	s0,8(sp)
 51e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 520:	00054783          	lbu	a5,0(a0)
 524:	cb91                	beqz	a5,538 <strcmp+0x1e>
 526:	0005c703          	lbu	a4,0(a1)
 52a:	00f71763          	bne	a4,a5,538 <strcmp+0x1e>
    p++, q++;
 52e:	0505                	addi	a0,a0,1
 530:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 532:	00054783          	lbu	a5,0(a0)
 536:	fbe5                	bnez	a5,526 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 538:	0005c503          	lbu	a0,0(a1)
}
 53c:	40a7853b          	subw	a0,a5,a0
 540:	6422                	ld	s0,8(sp)
 542:	0141                	addi	sp,sp,16
 544:	8082                	ret

0000000000000546 <strlen>:

uint
strlen(const char *s)
{
 546:	1141                	addi	sp,sp,-16
 548:	e422                	sd	s0,8(sp)
 54a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 54c:	00054783          	lbu	a5,0(a0)
 550:	cf91                	beqz	a5,56c <strlen+0x26>
 552:	0505                	addi	a0,a0,1
 554:	87aa                	mv	a5,a0
 556:	4685                	li	a3,1
 558:	9e89                	subw	a3,a3,a0
 55a:	00f6853b          	addw	a0,a3,a5
 55e:	0785                	addi	a5,a5,1
 560:	fff7c703          	lbu	a4,-1(a5)
 564:	fb7d                	bnez	a4,55a <strlen+0x14>
    ;
  return n;
}
 566:	6422                	ld	s0,8(sp)
 568:	0141                	addi	sp,sp,16
 56a:	8082                	ret
  for(n = 0; s[n]; n++)
 56c:	4501                	li	a0,0
 56e:	bfe5                	j	566 <strlen+0x20>

0000000000000570 <memset>:

void*
memset(void *dst, int c, uint n)
{
 570:	1141                	addi	sp,sp,-16
 572:	e422                	sd	s0,8(sp)
 574:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 576:	ca19                	beqz	a2,58c <memset+0x1c>
 578:	87aa                	mv	a5,a0
 57a:	1602                	slli	a2,a2,0x20
 57c:	9201                	srli	a2,a2,0x20
 57e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 582:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 586:	0785                	addi	a5,a5,1
 588:	fee79de3          	bne	a5,a4,582 <memset+0x12>
  }
  return dst;
}
 58c:	6422                	ld	s0,8(sp)
 58e:	0141                	addi	sp,sp,16
 590:	8082                	ret

0000000000000592 <strchr>:

char*
strchr(const char *s, char c)
{
 592:	1141                	addi	sp,sp,-16
 594:	e422                	sd	s0,8(sp)
 596:	0800                	addi	s0,sp,16
  for(; *s; s++)
 598:	00054783          	lbu	a5,0(a0)
 59c:	cb99                	beqz	a5,5b2 <strchr+0x20>
    if(*s == c)
 59e:	00f58763          	beq	a1,a5,5ac <strchr+0x1a>
  for(; *s; s++)
 5a2:	0505                	addi	a0,a0,1
 5a4:	00054783          	lbu	a5,0(a0)
 5a8:	fbfd                	bnez	a5,59e <strchr+0xc>
      return (char*)s;
  return 0;
 5aa:	4501                	li	a0,0
}
 5ac:	6422                	ld	s0,8(sp)
 5ae:	0141                	addi	sp,sp,16
 5b0:	8082                	ret
  return 0;
 5b2:	4501                	li	a0,0
 5b4:	bfe5                	j	5ac <strchr+0x1a>

00000000000005b6 <gets>:

char*
gets(char *buf, int max)
{
 5b6:	711d                	addi	sp,sp,-96
 5b8:	ec86                	sd	ra,88(sp)
 5ba:	e8a2                	sd	s0,80(sp)
 5bc:	e4a6                	sd	s1,72(sp)
 5be:	e0ca                	sd	s2,64(sp)
 5c0:	fc4e                	sd	s3,56(sp)
 5c2:	f852                	sd	s4,48(sp)
 5c4:	f456                	sd	s5,40(sp)
 5c6:	f05a                	sd	s6,32(sp)
 5c8:	ec5e                	sd	s7,24(sp)
 5ca:	1080                	addi	s0,sp,96
 5cc:	8baa                	mv	s7,a0
 5ce:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 5d0:	892a                	mv	s2,a0
 5d2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 5d4:	4aa9                	li	s5,10
 5d6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 5d8:	89a6                	mv	s3,s1
 5da:	2485                	addiw	s1,s1,1
 5dc:	0344d863          	bge	s1,s4,60c <gets+0x56>
    cc = read(0, &c, 1);
 5e0:	4605                	li	a2,1
 5e2:	faf40593          	addi	a1,s0,-81
 5e6:	4501                	li	a0,0
 5e8:	00000097          	auipc	ra,0x0
 5ec:	19c080e7          	jalr	412(ra) # 784 <read>
    if(cc < 1)
 5f0:	00a05e63          	blez	a0,60c <gets+0x56>
    buf[i++] = c;
 5f4:	faf44783          	lbu	a5,-81(s0)
 5f8:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 5fc:	01578763          	beq	a5,s5,60a <gets+0x54>
 600:	0905                	addi	s2,s2,1
 602:	fd679be3          	bne	a5,s6,5d8 <gets+0x22>
  for(i=0; i+1 < max; ){
 606:	89a6                	mv	s3,s1
 608:	a011                	j	60c <gets+0x56>
 60a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 60c:	99de                	add	s3,s3,s7
 60e:	00098023          	sb	zero,0(s3)
  return buf;
}
 612:	855e                	mv	a0,s7
 614:	60e6                	ld	ra,88(sp)
 616:	6446                	ld	s0,80(sp)
 618:	64a6                	ld	s1,72(sp)
 61a:	6906                	ld	s2,64(sp)
 61c:	79e2                	ld	s3,56(sp)
 61e:	7a42                	ld	s4,48(sp)
 620:	7aa2                	ld	s5,40(sp)
 622:	7b02                	ld	s6,32(sp)
 624:	6be2                	ld	s7,24(sp)
 626:	6125                	addi	sp,sp,96
 628:	8082                	ret

000000000000062a <stat>:

int
stat(const char *n, struct stat *st)
{
 62a:	1101                	addi	sp,sp,-32
 62c:	ec06                	sd	ra,24(sp)
 62e:	e822                	sd	s0,16(sp)
 630:	e426                	sd	s1,8(sp)
 632:	e04a                	sd	s2,0(sp)
 634:	1000                	addi	s0,sp,32
 636:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 638:	4581                	li	a1,0
 63a:	00000097          	auipc	ra,0x0
 63e:	172080e7          	jalr	370(ra) # 7ac <open>
  if(fd < 0)
 642:	02054563          	bltz	a0,66c <stat+0x42>
 646:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 648:	85ca                	mv	a1,s2
 64a:	00000097          	auipc	ra,0x0
 64e:	17a080e7          	jalr	378(ra) # 7c4 <fstat>
 652:	892a                	mv	s2,a0
  close(fd);
 654:	8526                	mv	a0,s1
 656:	00000097          	auipc	ra,0x0
 65a:	13e080e7          	jalr	318(ra) # 794 <close>
  return r;
}
 65e:	854a                	mv	a0,s2
 660:	60e2                	ld	ra,24(sp)
 662:	6442                	ld	s0,16(sp)
 664:	64a2                	ld	s1,8(sp)
 666:	6902                	ld	s2,0(sp)
 668:	6105                	addi	sp,sp,32
 66a:	8082                	ret
    return -1;
 66c:	597d                	li	s2,-1
 66e:	bfc5                	j	65e <stat+0x34>

0000000000000670 <atoi>:

int
atoi(const char *s)
{
 670:	1141                	addi	sp,sp,-16
 672:	e422                	sd	s0,8(sp)
 674:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 676:	00054603          	lbu	a2,0(a0)
 67a:	fd06079b          	addiw	a5,a2,-48
 67e:	0ff7f793          	zext.b	a5,a5
 682:	4725                	li	a4,9
 684:	02f76963          	bltu	a4,a5,6b6 <atoi+0x46>
 688:	86aa                	mv	a3,a0
  n = 0;
 68a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 68c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 68e:	0685                	addi	a3,a3,1
 690:	0025179b          	slliw	a5,a0,0x2
 694:	9fa9                	addw	a5,a5,a0
 696:	0017979b          	slliw	a5,a5,0x1
 69a:	9fb1                	addw	a5,a5,a2
 69c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 6a0:	0006c603          	lbu	a2,0(a3)
 6a4:	fd06071b          	addiw	a4,a2,-48
 6a8:	0ff77713          	zext.b	a4,a4
 6ac:	fee5f1e3          	bgeu	a1,a4,68e <atoi+0x1e>
  return n;
}
 6b0:	6422                	ld	s0,8(sp)
 6b2:	0141                	addi	sp,sp,16
 6b4:	8082                	ret
  n = 0;
 6b6:	4501                	li	a0,0
 6b8:	bfe5                	j	6b0 <atoi+0x40>

00000000000006ba <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6ba:	1141                	addi	sp,sp,-16
 6bc:	e422                	sd	s0,8(sp)
 6be:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 6c0:	02b57463          	bgeu	a0,a1,6e8 <memmove+0x2e>
    while(n-- > 0)
 6c4:	00c05f63          	blez	a2,6e2 <memmove+0x28>
 6c8:	1602                	slli	a2,a2,0x20
 6ca:	9201                	srli	a2,a2,0x20
 6cc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 6d0:	872a                	mv	a4,a0
      *dst++ = *src++;
 6d2:	0585                	addi	a1,a1,1
 6d4:	0705                	addi	a4,a4,1
 6d6:	fff5c683          	lbu	a3,-1(a1)
 6da:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 6de:	fee79ae3          	bne	a5,a4,6d2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 6e2:	6422                	ld	s0,8(sp)
 6e4:	0141                	addi	sp,sp,16
 6e6:	8082                	ret
    dst += n;
 6e8:	00c50733          	add	a4,a0,a2
    src += n;
 6ec:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 6ee:	fec05ae3          	blez	a2,6e2 <memmove+0x28>
 6f2:	fff6079b          	addiw	a5,a2,-1
 6f6:	1782                	slli	a5,a5,0x20
 6f8:	9381                	srli	a5,a5,0x20
 6fa:	fff7c793          	not	a5,a5
 6fe:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 700:	15fd                	addi	a1,a1,-1
 702:	177d                	addi	a4,a4,-1
 704:	0005c683          	lbu	a3,0(a1)
 708:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 70c:	fee79ae3          	bne	a5,a4,700 <memmove+0x46>
 710:	bfc9                	j	6e2 <memmove+0x28>

0000000000000712 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 712:	1141                	addi	sp,sp,-16
 714:	e422                	sd	s0,8(sp)
 716:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 718:	ca05                	beqz	a2,748 <memcmp+0x36>
 71a:	fff6069b          	addiw	a3,a2,-1
 71e:	1682                	slli	a3,a3,0x20
 720:	9281                	srli	a3,a3,0x20
 722:	0685                	addi	a3,a3,1
 724:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 726:	00054783          	lbu	a5,0(a0)
 72a:	0005c703          	lbu	a4,0(a1)
 72e:	00e79863          	bne	a5,a4,73e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 732:	0505                	addi	a0,a0,1
    p2++;
 734:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 736:	fed518e3          	bne	a0,a3,726 <memcmp+0x14>
  }
  return 0;
 73a:	4501                	li	a0,0
 73c:	a019                	j	742 <memcmp+0x30>
      return *p1 - *p2;
 73e:	40e7853b          	subw	a0,a5,a4
}
 742:	6422                	ld	s0,8(sp)
 744:	0141                	addi	sp,sp,16
 746:	8082                	ret
  return 0;
 748:	4501                	li	a0,0
 74a:	bfe5                	j	742 <memcmp+0x30>

000000000000074c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 74c:	1141                	addi	sp,sp,-16
 74e:	e406                	sd	ra,8(sp)
 750:	e022                	sd	s0,0(sp)
 752:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 754:	00000097          	auipc	ra,0x0
 758:	f66080e7          	jalr	-154(ra) # 6ba <memmove>
}
 75c:	60a2                	ld	ra,8(sp)
 75e:	6402                	ld	s0,0(sp)
 760:	0141                	addi	sp,sp,16
 762:	8082                	ret

0000000000000764 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 764:	4885                	li	a7,1
 ecall
 766:	00000073          	ecall
 ret
 76a:	8082                	ret

000000000000076c <exit>:
.global exit
exit:
 li a7, SYS_exit
 76c:	4889                	li	a7,2
 ecall
 76e:	00000073          	ecall
 ret
 772:	8082                	ret

0000000000000774 <wait>:
.global wait
wait:
 li a7, SYS_wait
 774:	488d                	li	a7,3
 ecall
 776:	00000073          	ecall
 ret
 77a:	8082                	ret

000000000000077c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 77c:	4891                	li	a7,4
 ecall
 77e:	00000073          	ecall
 ret
 782:	8082                	ret

0000000000000784 <read>:
.global read
read:
 li a7, SYS_read
 784:	4895                	li	a7,5
 ecall
 786:	00000073          	ecall
 ret
 78a:	8082                	ret

000000000000078c <write>:
.global write
write:
 li a7, SYS_write
 78c:	48c1                	li	a7,16
 ecall
 78e:	00000073          	ecall
 ret
 792:	8082                	ret

0000000000000794 <close>:
.global close
close:
 li a7, SYS_close
 794:	48d5                	li	a7,21
 ecall
 796:	00000073          	ecall
 ret
 79a:	8082                	ret

000000000000079c <kill>:
.global kill
kill:
 li a7, SYS_kill
 79c:	4899                	li	a7,6
 ecall
 79e:	00000073          	ecall
 ret
 7a2:	8082                	ret

00000000000007a4 <exec>:
.global exec
exec:
 li a7, SYS_exec
 7a4:	489d                	li	a7,7
 ecall
 7a6:	00000073          	ecall
 ret
 7aa:	8082                	ret

00000000000007ac <open>:
.global open
open:
 li a7, SYS_open
 7ac:	48bd                	li	a7,15
 ecall
 7ae:	00000073          	ecall
 ret
 7b2:	8082                	ret

00000000000007b4 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 7b4:	48c5                	li	a7,17
 ecall
 7b6:	00000073          	ecall
 ret
 7ba:	8082                	ret

00000000000007bc <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 7bc:	48c9                	li	a7,18
 ecall
 7be:	00000073          	ecall
 ret
 7c2:	8082                	ret

00000000000007c4 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 7c4:	48a1                	li	a7,8
 ecall
 7c6:	00000073          	ecall
 ret
 7ca:	8082                	ret

00000000000007cc <link>:
.global link
link:
 li a7, SYS_link
 7cc:	48cd                	li	a7,19
 ecall
 7ce:	00000073          	ecall
 ret
 7d2:	8082                	ret

00000000000007d4 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 7d4:	48d1                	li	a7,20
 ecall
 7d6:	00000073          	ecall
 ret
 7da:	8082                	ret

00000000000007dc <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 7dc:	48a5                	li	a7,9
 ecall
 7de:	00000073          	ecall
 ret
 7e2:	8082                	ret

00000000000007e4 <dup>:
.global dup
dup:
 li a7, SYS_dup
 7e4:	48a9                	li	a7,10
 ecall
 7e6:	00000073          	ecall
 ret
 7ea:	8082                	ret

00000000000007ec <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 7ec:	48ad                	li	a7,11
 ecall
 7ee:	00000073          	ecall
 ret
 7f2:	8082                	ret

00000000000007f4 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
 7f4:	48b1                	li	a7,12
 ecall
 7f6:	00000073          	ecall
 ret
 7fa:	8082                	ret

00000000000007fc <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
 7fc:	48b5                	li	a7,13
 ecall
 7fe:	00000073          	ecall
 ret
 802:	8082                	ret

0000000000000804 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 804:	48b9                	li	a7,14
 ecall
 806:	00000073          	ecall
 ret
 80a:	8082                	ret

000000000000080c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
 80c:	48d9                	li	a7,22
 ecall
 80e:	00000073          	ecall
 ret
 812:	8082                	ret

0000000000000814 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 814:	1101                	addi	sp,sp,-32
 816:	ec06                	sd	ra,24(sp)
 818:	e822                	sd	s0,16(sp)
 81a:	1000                	addi	s0,sp,32
 81c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 820:	4605                	li	a2,1
 822:	fef40593          	addi	a1,s0,-17
 826:	00000097          	auipc	ra,0x0
 82a:	f66080e7          	jalr	-154(ra) # 78c <write>
}
 82e:	60e2                	ld	ra,24(sp)
 830:	6442                	ld	s0,16(sp)
 832:	6105                	addi	sp,sp,32
 834:	8082                	ret

0000000000000836 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 836:	7139                	addi	sp,sp,-64
 838:	fc06                	sd	ra,56(sp)
 83a:	f822                	sd	s0,48(sp)
 83c:	f426                	sd	s1,40(sp)
 83e:	f04a                	sd	s2,32(sp)
 840:	ec4e                	sd	s3,24(sp)
 842:	0080                	addi	s0,sp,64
 844:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 846:	c299                	beqz	a3,84c <printint+0x16>
 848:	0805c863          	bltz	a1,8d8 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 84c:	2581                	sext.w	a1,a1
  neg = 0;
 84e:	4881                	li	a7,0
 850:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
 854:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
 856:	2601                	sext.w	a2,a2
 858:	00000517          	auipc	a0,0x0
 85c:	4b050513          	addi	a0,a0,1200 # d08 <digits>
 860:	883a                	mv	a6,a4
 862:	2705                	addiw	a4,a4,1
 864:	02c5f7bb          	remuw	a5,a1,a2
 868:	1782                	slli	a5,a5,0x20
 86a:	9381                	srli	a5,a5,0x20
 86c:	97aa                	add	a5,a5,a0
 86e:	0007c783          	lbu	a5,0(a5)
 872:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
 876:	0005879b          	sext.w	a5,a1
 87a:	02c5d5bb          	divuw	a1,a1,a2
 87e:	0685                	addi	a3,a3,1
 880:	fec7f0e3          	bgeu	a5,a2,860 <printint+0x2a>
  if(neg)
 884:	00088b63          	beqz	a7,89a <printint+0x64>
    buf[i++] = '-';
 888:	fd040793          	addi	a5,s0,-48
 88c:	973e                	add	a4,a4,a5
 88e:	02d00793          	li	a5,45
 892:	fef70823          	sb	a5,-16(a4)
 896:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
 89a:	02e05863          	blez	a4,8ca <printint+0x94>
 89e:	fc040793          	addi	a5,s0,-64
 8a2:	00e78933          	add	s2,a5,a4
 8a6:	fff78993          	addi	s3,a5,-1
 8aa:	99ba                	add	s3,s3,a4
 8ac:	377d                	addiw	a4,a4,-1
 8ae:	1702                	slli	a4,a4,0x20
 8b0:	9301                	srli	a4,a4,0x20
 8b2:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
 8b6:	fff94583          	lbu	a1,-1(s2)
 8ba:	8526                	mv	a0,s1
 8bc:	00000097          	auipc	ra,0x0
 8c0:	f58080e7          	jalr	-168(ra) # 814 <putc>
  while(--i >= 0)
 8c4:	197d                	addi	s2,s2,-1
 8c6:	ff3918e3          	bne	s2,s3,8b6 <printint+0x80>
}
 8ca:	70e2                	ld	ra,56(sp)
 8cc:	7442                	ld	s0,48(sp)
 8ce:	74a2                	ld	s1,40(sp)
 8d0:	7902                	ld	s2,32(sp)
 8d2:	69e2                	ld	s3,24(sp)
 8d4:	6121                	addi	sp,sp,64
 8d6:	8082                	ret
    x = -xx;
 8d8:	40b005bb          	negw	a1,a1
    neg = 1;
 8dc:	4885                	li	a7,1
    x = -xx;
 8de:	bf8d                	j	850 <printint+0x1a>

00000000000008e0 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 8e0:	7119                	addi	sp,sp,-128
 8e2:	fc86                	sd	ra,120(sp)
 8e4:	f8a2                	sd	s0,112(sp)
 8e6:	f4a6                	sd	s1,104(sp)
 8e8:	f0ca                	sd	s2,96(sp)
 8ea:	ecce                	sd	s3,88(sp)
 8ec:	e8d2                	sd	s4,80(sp)
 8ee:	e4d6                	sd	s5,72(sp)
 8f0:	e0da                	sd	s6,64(sp)
 8f2:	fc5e                	sd	s7,56(sp)
 8f4:	f862                	sd	s8,48(sp)
 8f6:	f466                	sd	s9,40(sp)
 8f8:	f06a                	sd	s10,32(sp)
 8fa:	ec6e                	sd	s11,24(sp)
 8fc:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 8fe:	0005c903          	lbu	s2,0(a1)
 902:	18090f63          	beqz	s2,aa0 <vprintf+0x1c0>
 906:	8aaa                	mv	s5,a0
 908:	8b32                	mv	s6,a2
 90a:	00158493          	addi	s1,a1,1
  state = 0;
 90e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 910:	02500a13          	li	s4,37
      if(c == 'd'){
 914:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
 918:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
 91c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
 920:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 924:	00000b97          	auipc	s7,0x0
 928:	3e4b8b93          	addi	s7,s7,996 # d08 <digits>
 92c:	a839                	j	94a <vprintf+0x6a>
        putc(fd, c);
 92e:	85ca                	mv	a1,s2
 930:	8556                	mv	a0,s5
 932:	00000097          	auipc	ra,0x0
 936:	ee2080e7          	jalr	-286(ra) # 814 <putc>
 93a:	a019                	j	940 <vprintf+0x60>
    } else if(state == '%'){
 93c:	01498f63          	beq	s3,s4,95a <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
 940:	0485                	addi	s1,s1,1
 942:	fff4c903          	lbu	s2,-1(s1)
 946:	14090d63          	beqz	s2,aa0 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
 94a:	0009079b          	sext.w	a5,s2
    if(state == 0){
 94e:	fe0997e3          	bnez	s3,93c <vprintf+0x5c>
      if(c == '%'){
 952:	fd479ee3          	bne	a5,s4,92e <vprintf+0x4e>
        state = '%';
 956:	89be                	mv	s3,a5
 958:	b7e5                	j	940 <vprintf+0x60>
      if(c == 'd'){
 95a:	05878063          	beq	a5,s8,99a <vprintf+0xba>
      } else if(c == 'l') {
 95e:	05978c63          	beq	a5,s9,9b6 <vprintf+0xd6>
      } else if(c == 'x') {
 962:	07a78863          	beq	a5,s10,9d2 <vprintf+0xf2>
      } else if(c == 'p') {
 966:	09b78463          	beq	a5,s11,9ee <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
 96a:	07300713          	li	a4,115
 96e:	0ce78663          	beq	a5,a4,a3a <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 972:	06300713          	li	a4,99
 976:	0ee78e63          	beq	a5,a4,a72 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
 97a:	11478863          	beq	a5,s4,a8a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 97e:	85d2                	mv	a1,s4
 980:	8556                	mv	a0,s5
 982:	00000097          	auipc	ra,0x0
 986:	e92080e7          	jalr	-366(ra) # 814 <putc>
        putc(fd, c);
 98a:	85ca                	mv	a1,s2
 98c:	8556                	mv	a0,s5
 98e:	00000097          	auipc	ra,0x0
 992:	e86080e7          	jalr	-378(ra) # 814 <putc>
      }
      state = 0;
 996:	4981                	li	s3,0
 998:	b765                	j	940 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
 99a:	008b0913          	addi	s2,s6,8
 99e:	4685                	li	a3,1
 9a0:	4629                	li	a2,10
 9a2:	000b2583          	lw	a1,0(s6)
 9a6:	8556                	mv	a0,s5
 9a8:	00000097          	auipc	ra,0x0
 9ac:	e8e080e7          	jalr	-370(ra) # 836 <printint>
 9b0:	8b4a                	mv	s6,s2
      state = 0;
 9b2:	4981                	li	s3,0
 9b4:	b771                	j	940 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
 9b6:	008b0913          	addi	s2,s6,8
 9ba:	4681                	li	a3,0
 9bc:	4629                	li	a2,10
 9be:	000b2583          	lw	a1,0(s6)
 9c2:	8556                	mv	a0,s5
 9c4:	00000097          	auipc	ra,0x0
 9c8:	e72080e7          	jalr	-398(ra) # 836 <printint>
 9cc:	8b4a                	mv	s6,s2
      state = 0;
 9ce:	4981                	li	s3,0
 9d0:	bf85                	j	940 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
 9d2:	008b0913          	addi	s2,s6,8
 9d6:	4681                	li	a3,0
 9d8:	4641                	li	a2,16
 9da:	000b2583          	lw	a1,0(s6)
 9de:	8556                	mv	a0,s5
 9e0:	00000097          	auipc	ra,0x0
 9e4:	e56080e7          	jalr	-426(ra) # 836 <printint>
 9e8:	8b4a                	mv	s6,s2
      state = 0;
 9ea:	4981                	li	s3,0
 9ec:	bf91                	j	940 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
 9ee:	008b0793          	addi	a5,s6,8
 9f2:	f8f43423          	sd	a5,-120(s0)
 9f6:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
 9fa:	03000593          	li	a1,48
 9fe:	8556                	mv	a0,s5
 a00:	00000097          	auipc	ra,0x0
 a04:	e14080e7          	jalr	-492(ra) # 814 <putc>
  putc(fd, 'x');
 a08:	85ea                	mv	a1,s10
 a0a:	8556                	mv	a0,s5
 a0c:	00000097          	auipc	ra,0x0
 a10:	e08080e7          	jalr	-504(ra) # 814 <putc>
 a14:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 a16:	03c9d793          	srli	a5,s3,0x3c
 a1a:	97de                	add	a5,a5,s7
 a1c:	0007c583          	lbu	a1,0(a5)
 a20:	8556                	mv	a0,s5
 a22:	00000097          	auipc	ra,0x0
 a26:	df2080e7          	jalr	-526(ra) # 814 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 a2a:	0992                	slli	s3,s3,0x4
 a2c:	397d                	addiw	s2,s2,-1
 a2e:	fe0914e3          	bnez	s2,a16 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
 a32:	f8843b03          	ld	s6,-120(s0)
      state = 0;
 a36:	4981                	li	s3,0
 a38:	b721                	j	940 <vprintf+0x60>
        s = va_arg(ap, char*);
 a3a:	008b0993          	addi	s3,s6,8
 a3e:	000b3903          	ld	s2,0(s6)
        if(s == 0)
 a42:	02090163          	beqz	s2,a64 <vprintf+0x184>
        while(*s != 0){
 a46:	00094583          	lbu	a1,0(s2)
 a4a:	c9a1                	beqz	a1,a9a <vprintf+0x1ba>
          putc(fd, *s);
 a4c:	8556                	mv	a0,s5
 a4e:	00000097          	auipc	ra,0x0
 a52:	dc6080e7          	jalr	-570(ra) # 814 <putc>
          s++;
 a56:	0905                	addi	s2,s2,1
        while(*s != 0){
 a58:	00094583          	lbu	a1,0(s2)
 a5c:	f9e5                	bnez	a1,a4c <vprintf+0x16c>
        s = va_arg(ap, char*);
 a5e:	8b4e                	mv	s6,s3
      state = 0;
 a60:	4981                	li	s3,0
 a62:	bdf9                	j	940 <vprintf+0x60>
          s = "(null)";
 a64:	00000917          	auipc	s2,0x0
 a68:	29c90913          	addi	s2,s2,668 # d00 <malloc+0x156>
        while(*s != 0){
 a6c:	02800593          	li	a1,40
 a70:	bff1                	j	a4c <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
 a72:	008b0913          	addi	s2,s6,8
 a76:	000b4583          	lbu	a1,0(s6)
 a7a:	8556                	mv	a0,s5
 a7c:	00000097          	auipc	ra,0x0
 a80:	d98080e7          	jalr	-616(ra) # 814 <putc>
 a84:	8b4a                	mv	s6,s2
      state = 0;
 a86:	4981                	li	s3,0
 a88:	bd65                	j	940 <vprintf+0x60>
        putc(fd, c);
 a8a:	85d2                	mv	a1,s4
 a8c:	8556                	mv	a0,s5
 a8e:	00000097          	auipc	ra,0x0
 a92:	d86080e7          	jalr	-634(ra) # 814 <putc>
      state = 0;
 a96:	4981                	li	s3,0
 a98:	b565                	j	940 <vprintf+0x60>
        s = va_arg(ap, char*);
 a9a:	8b4e                	mv	s6,s3
      state = 0;
 a9c:	4981                	li	s3,0
 a9e:	b54d                	j	940 <vprintf+0x60>
    }
  }
}
 aa0:	70e6                	ld	ra,120(sp)
 aa2:	7446                	ld	s0,112(sp)
 aa4:	74a6                	ld	s1,104(sp)
 aa6:	7906                	ld	s2,96(sp)
 aa8:	69e6                	ld	s3,88(sp)
 aaa:	6a46                	ld	s4,80(sp)
 aac:	6aa6                	ld	s5,72(sp)
 aae:	6b06                	ld	s6,64(sp)
 ab0:	7be2                	ld	s7,56(sp)
 ab2:	7c42                	ld	s8,48(sp)
 ab4:	7ca2                	ld	s9,40(sp)
 ab6:	7d02                	ld	s10,32(sp)
 ab8:	6de2                	ld	s11,24(sp)
 aba:	6109                	addi	sp,sp,128
 abc:	8082                	ret

0000000000000abe <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 abe:	715d                	addi	sp,sp,-80
 ac0:	ec06                	sd	ra,24(sp)
 ac2:	e822                	sd	s0,16(sp)
 ac4:	1000                	addi	s0,sp,32
 ac6:	e010                	sd	a2,0(s0)
 ac8:	e414                	sd	a3,8(s0)
 aca:	e818                	sd	a4,16(s0)
 acc:	ec1c                	sd	a5,24(s0)
 ace:	03043023          	sd	a6,32(s0)
 ad2:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 ad6:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 ada:	8622                	mv	a2,s0
 adc:	00000097          	auipc	ra,0x0
 ae0:	e04080e7          	jalr	-508(ra) # 8e0 <vprintf>
}
 ae4:	60e2                	ld	ra,24(sp)
 ae6:	6442                	ld	s0,16(sp)
 ae8:	6161                	addi	sp,sp,80
 aea:	8082                	ret

0000000000000aec <printf>:

void
printf(const char *fmt, ...)
{
 aec:	711d                	addi	sp,sp,-96
 aee:	ec06                	sd	ra,24(sp)
 af0:	e822                	sd	s0,16(sp)
 af2:	1000                	addi	s0,sp,32
 af4:	e40c                	sd	a1,8(s0)
 af6:	e810                	sd	a2,16(s0)
 af8:	ec14                	sd	a3,24(s0)
 afa:	f018                	sd	a4,32(s0)
 afc:	f41c                	sd	a5,40(s0)
 afe:	03043823          	sd	a6,48(s0)
 b02:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 b06:	00840613          	addi	a2,s0,8
 b0a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 b0e:	85aa                	mv	a1,a0
 b10:	4505                	li	a0,1
 b12:	00000097          	auipc	ra,0x0
 b16:	dce080e7          	jalr	-562(ra) # 8e0 <vprintf>
}
 b1a:	60e2                	ld	ra,24(sp)
 b1c:	6442                	ld	s0,16(sp)
 b1e:	6125                	addi	sp,sp,96
 b20:	8082                	ret

0000000000000b22 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b22:	1141                	addi	sp,sp,-16
 b24:	e422                	sd	s0,8(sp)
 b26:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 b28:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b2c:	00000797          	auipc	a5,0x0
 b30:	1f47b783          	ld	a5,500(a5) # d20 <freep>
 b34:	a805                	j	b64 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 b36:	4618                	lw	a4,8(a2)
 b38:	9db9                	addw	a1,a1,a4
 b3a:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 b3e:	6398                	ld	a4,0(a5)
 b40:	6318                	ld	a4,0(a4)
 b42:	fee53823          	sd	a4,-16(a0)
 b46:	a091                	j	b8a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 b48:	ff852703          	lw	a4,-8(a0)
 b4c:	9e39                	addw	a2,a2,a4
 b4e:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
 b50:	ff053703          	ld	a4,-16(a0)
 b54:	e398                	sd	a4,0(a5)
 b56:	a099                	j	b9c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b58:	6398                	ld	a4,0(a5)
 b5a:	00e7e463          	bltu	a5,a4,b62 <free+0x40>
 b5e:	00e6ea63          	bltu	a3,a4,b72 <free+0x50>
{
 b62:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b64:	fed7fae3          	bgeu	a5,a3,b58 <free+0x36>
 b68:	6398                	ld	a4,0(a5)
 b6a:	00e6e463          	bltu	a3,a4,b72 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b6e:	fee7eae3          	bltu	a5,a4,b62 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
 b72:	ff852583          	lw	a1,-8(a0)
 b76:	6390                	ld	a2,0(a5)
 b78:	02059813          	slli	a6,a1,0x20
 b7c:	01c85713          	srli	a4,a6,0x1c
 b80:	9736                	add	a4,a4,a3
 b82:	fae60ae3          	beq	a2,a4,b36 <free+0x14>
    bp->s.ptr = p->s.ptr;
 b86:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 b8a:	4790                	lw	a2,8(a5)
 b8c:	02061593          	slli	a1,a2,0x20
 b90:	01c5d713          	srli	a4,a1,0x1c
 b94:	973e                	add	a4,a4,a5
 b96:	fae689e3          	beq	a3,a4,b48 <free+0x26>
  } else
    p->s.ptr = bp;
 b9a:	e394                	sd	a3,0(a5)
  freep = p;
 b9c:	00000717          	auipc	a4,0x0
 ba0:	18f73223          	sd	a5,388(a4) # d20 <freep>
}
 ba4:	6422                	ld	s0,8(sp)
 ba6:	0141                	addi	sp,sp,16
 ba8:	8082                	ret

0000000000000baa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 baa:	7139                	addi	sp,sp,-64
 bac:	fc06                	sd	ra,56(sp)
 bae:	f822                	sd	s0,48(sp)
 bb0:	f426                	sd	s1,40(sp)
 bb2:	f04a                	sd	s2,32(sp)
 bb4:	ec4e                	sd	s3,24(sp)
 bb6:	e852                	sd	s4,16(sp)
 bb8:	e456                	sd	s5,8(sp)
 bba:	e05a                	sd	s6,0(sp)
 bbc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bbe:	02051493          	slli	s1,a0,0x20
 bc2:	9081                	srli	s1,s1,0x20
 bc4:	04bd                	addi	s1,s1,15
 bc6:	8091                	srli	s1,s1,0x4
 bc8:	0014899b          	addiw	s3,s1,1
 bcc:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 bce:	00000517          	auipc	a0,0x0
 bd2:	15253503          	ld	a0,338(a0) # d20 <freep>
 bd6:	c515                	beqz	a0,c02 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bd8:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 bda:	4798                	lw	a4,8(a5)
 bdc:	02977f63          	bgeu	a4,s1,c1a <malloc+0x70>
 be0:	8a4e                	mv	s4,s3
 be2:	0009871b          	sext.w	a4,s3
 be6:	6685                	lui	a3,0x1
 be8:	00d77363          	bgeu	a4,a3,bee <malloc+0x44>
 bec:	6a05                	lui	s4,0x1
 bee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 bf2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bf6:	00000917          	auipc	s2,0x0
 bfa:	12a90913          	addi	s2,s2,298 # d20 <freep>
  if(p == (char*)-1)
 bfe:	5afd                	li	s5,-1
 c00:	a895                	j	c74 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
 c02:	00000797          	auipc	a5,0x0
 c06:	22678793          	addi	a5,a5,550 # e28 <base>
 c0a:	00000717          	auipc	a4,0x0
 c0e:	10f73b23          	sd	a5,278(a4) # d20 <freep>
 c12:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 c14:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 c18:	b7e1                	j	be0 <malloc+0x36>
      if(p->s.size == nunits)
 c1a:	02e48c63          	beq	s1,a4,c52 <malloc+0xa8>
        p->s.size -= nunits;
 c1e:	4137073b          	subw	a4,a4,s3
 c22:	c798                	sw	a4,8(a5)
        p += p->s.size;
 c24:	02071693          	slli	a3,a4,0x20
 c28:	01c6d713          	srli	a4,a3,0x1c
 c2c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 c2e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 c32:	00000717          	auipc	a4,0x0
 c36:	0ea73723          	sd	a0,238(a4) # d20 <freep>
      return (void*)(p + 1);
 c3a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 c3e:	70e2                	ld	ra,56(sp)
 c40:	7442                	ld	s0,48(sp)
 c42:	74a2                	ld	s1,40(sp)
 c44:	7902                	ld	s2,32(sp)
 c46:	69e2                	ld	s3,24(sp)
 c48:	6a42                	ld	s4,16(sp)
 c4a:	6aa2                	ld	s5,8(sp)
 c4c:	6b02                	ld	s6,0(sp)
 c4e:	6121                	addi	sp,sp,64
 c50:	8082                	ret
        prevp->s.ptr = p->s.ptr;
 c52:	6398                	ld	a4,0(a5)
 c54:	e118                	sd	a4,0(a0)
 c56:	bff1                	j	c32 <malloc+0x88>
  hp->s.size = nu;
 c58:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 c5c:	0541                	addi	a0,a0,16
 c5e:	00000097          	auipc	ra,0x0
 c62:	ec4080e7          	jalr	-316(ra) # b22 <free>
  return freep;
 c66:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 c6a:	d971                	beqz	a0,c3e <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c6c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 c6e:	4798                	lw	a4,8(a5)
 c70:	fa9775e3          	bgeu	a4,s1,c1a <malloc+0x70>
    if(p == freep)
 c74:	00093703          	ld	a4,0(s2)
 c78:	853e                	mv	a0,a5
 c7a:	fef719e3          	bne	a4,a5,c6c <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
 c7e:	8552                	mv	a0,s4
 c80:	00000097          	auipc	ra,0x0
 c84:	b74080e7          	jalr	-1164(ra) # 7f4 <sbrk>
  if(p == (char*)-1)
 c88:	fd5518e3          	bne	a0,s5,c58 <malloc+0xae>
        return 0;
 c8c:	4501                	li	a0,0
 c8e:	bf45                	j	c3e <malloc+0x94>
