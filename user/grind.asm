
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
       0:	1141                	addi	sp,sp,-16
       2:	e422                	sd	s0,8(sp)
       4:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
       6:	611c                	ld	a5,0(a0)
       8:	80000737          	lui	a4,0x80000
       c:	ffe74713          	xori	a4,a4,-2
      10:	02e7f7b3          	remu	a5,a5,a4
      14:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
      16:	66fd                	lui	a3,0x1f
      18:	31d68693          	addi	a3,a3,797 # 1f31d <__global_pointer$+0x1d26c>
      1c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
      20:	6611                	lui	a2,0x4
      22:	1a760613          	addi	a2,a2,423 # 41a7 <__global_pointer$+0x20f6>
      26:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
      2a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
      2e:	76fd                	lui	a3,0xfffff
      30:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <__global_pointer$+0xffffffffffffd43b>
      34:	02d787b3          	mul	a5,a5,a3
      38:	97ba                	add	a5,a5,a4
    if (x < 0)
      3a:	0007c963          	bltz	a5,4c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
      3e:	17fd                	addi	a5,a5,-1
    *ctx = x;
      40:	e11c                	sd	a5,0(a0)
    return (x);
}
      42:	0007851b          	sext.w	a0,a5
      46:	6422                	ld	s0,8(sp)
      48:	0141                	addi	sp,sp,16
      4a:	8082                	ret
        x += 0x7fffffff;
      4c:	80000737          	lui	a4,0x80000
      50:	fff74713          	not	a4,a4
      54:	97ba                	add	a5,a5,a4
      56:	b7e5                	j	3e <do_rand+0x3e>

0000000000000058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
      58:	1141                	addi	sp,sp,-16
      5a:	e406                	sd	ra,8(sp)
      5c:	e022                	sd	s0,0(sp)
      5e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
      60:	00002517          	auipc	a0,0x2
      64:	85850513          	addi	a0,a0,-1960 # 18b8 <rand_next>
      68:	00000097          	auipc	ra,0x0
      6c:	f98080e7          	jalr	-104(ra) # 0 <do_rand>
}
      70:	60a2                	ld	ra,8(sp)
      72:	6402                	ld	s0,0(sp)
      74:	0141                	addi	sp,sp,16
      76:	8082                	ret

0000000000000078 <go>:

void
go(int which_child)
{
      78:	7159                	addi	sp,sp,-112
      7a:	f486                	sd	ra,104(sp)
      7c:	f0a2                	sd	s0,96(sp)
      7e:	eca6                	sd	s1,88(sp)
      80:	e8ca                	sd	s2,80(sp)
      82:	e4ce                	sd	s3,72(sp)
      84:	e0d2                	sd	s4,64(sp)
      86:	fc56                	sd	s5,56(sp)
      88:	f85a                	sd	s6,48(sp)
      8a:	1880                	addi	s0,sp,112
      8c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
      8e:	4501                	li	a0,0
      90:	00001097          	auipc	ra,0x1
      94:	080080e7          	jalr	128(ra) # 1110 <sbrk>
      98:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
      9a:	00001517          	auipc	a0,0x1
      9e:	51650513          	addi	a0,a0,1302 # 15b0 <malloc+0xea>
      a2:	00001097          	auipc	ra,0x1
      a6:	04e080e7          	jalr	78(ra) # 10f0 <mkdir>
  if(chdir("grindir") != 0){
      aa:	00001517          	auipc	a0,0x1
      ae:	50650513          	addi	a0,a0,1286 # 15b0 <malloc+0xea>
      b2:	00001097          	auipc	ra,0x1
      b6:	046080e7          	jalr	70(ra) # 10f8 <chdir>
      ba:	cd11                	beqz	a0,d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
      bc:	00001517          	auipc	a0,0x1
      c0:	4fc50513          	addi	a0,a0,1276 # 15b8 <malloc+0xf2>
      c4:	00001097          	auipc	ra,0x1
      c8:	344080e7          	jalr	836(ra) # 1408 <printf>
    exit(1);
      cc:	4505                	li	a0,1
      ce:	00001097          	auipc	ra,0x1
      d2:	fba080e7          	jalr	-70(ra) # 1088 <exit>
  }
  chdir("/");
      d6:	00001517          	auipc	a0,0x1
      da:	50250513          	addi	a0,a0,1282 # 15d8 <malloc+0x112>
      de:	00001097          	auipc	ra,0x1
      e2:	01a080e7          	jalr	26(ra) # 10f8 <chdir>
  
  while(1){
    iters++;
    if((iters % 500) == 0)
      e6:	00001997          	auipc	s3,0x1
      ea:	50298993          	addi	s3,s3,1282 # 15e8 <malloc+0x122>
      ee:	c489                	beqz	s1,f8 <go+0x80>
      f0:	00001997          	auipc	s3,0x1
      f4:	4f098993          	addi	s3,s3,1264 # 15e0 <malloc+0x11a>
    iters++;
      f8:	4485                	li	s1,1
  int fd = -1;
      fa:	597d                	li	s2,-1
      close(fd);
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
      fc:	00001a17          	auipc	s4,0x1
     100:	7cca0a13          	addi	s4,s4,1996 # 18c8 <buf.0>
     104:	a825                	j	13c <go+0xc4>
      close(open("grindir/../a", O_CREATE|O_RDWR));
     106:	20200593          	li	a1,514
     10a:	00001517          	auipc	a0,0x1
     10e:	4e650513          	addi	a0,a0,1254 # 15f0 <malloc+0x12a>
     112:	00001097          	auipc	ra,0x1
     116:	fb6080e7          	jalr	-74(ra) # 10c8 <open>
     11a:	00001097          	auipc	ra,0x1
     11e:	f96080e7          	jalr	-106(ra) # 10b0 <close>
    iters++;
     122:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
     124:	1f400793          	li	a5,500
     128:	02f4f7b3          	remu	a5,s1,a5
     12c:	eb81                	bnez	a5,13c <go+0xc4>
      write(1, which_child?"B":"A", 1);
     12e:	4605                	li	a2,1
     130:	85ce                	mv	a1,s3
     132:	4505                	li	a0,1
     134:	00001097          	auipc	ra,0x1
     138:	f74080e7          	jalr	-140(ra) # 10a8 <write>
    int what = rand() % 23;
     13c:	00000097          	auipc	ra,0x0
     140:	f1c080e7          	jalr	-228(ra) # 58 <rand>
     144:	47dd                	li	a5,23
     146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
     14a:	4785                	li	a5,1
     14c:	faf50de3          	beq	a0,a5,106 <go+0x8e>
    } else if(what == 2){
     150:	4789                	li	a5,2
     152:	18f50563          	beq	a0,a5,2dc <go+0x264>
    } else if(what == 3){
     156:	478d                	li	a5,3
     158:	1af50163          	beq	a0,a5,2fa <go+0x282>
    } else if(what == 4){
     15c:	4791                	li	a5,4
     15e:	1af50763          	beq	a0,a5,30c <go+0x294>
    } else if(what == 5){
     162:	4795                	li	a5,5
     164:	1ef50b63          	beq	a0,a5,35a <go+0x2e2>
    } else if(what == 6){
     168:	4799                	li	a5,6
     16a:	20f50963          	beq	a0,a5,37c <go+0x304>
    } else if(what == 7){
     16e:	479d                	li	a5,7
     170:	22f50763          	beq	a0,a5,39e <go+0x326>
    } else if(what == 8){
     174:	47a1                	li	a5,8
     176:	22f50d63          	beq	a0,a5,3b0 <go+0x338>
    } else if(what == 9){
     17a:	47a5                	li	a5,9
     17c:	24f50363          	beq	a0,a5,3c2 <go+0x34a>
      mkdir("grindir/../a");
      close(open("a/../a/./a", O_CREATE|O_RDWR));
      unlink("a/a");
    } else if(what == 10){
     180:	47a9                	li	a5,10
     182:	26f50f63          	beq	a0,a5,400 <go+0x388>
      mkdir("/../b");
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
      unlink("b/b");
    } else if(what == 11){
     186:	47ad                	li	a5,11
     188:	2af50b63          	beq	a0,a5,43e <go+0x3c6>
      unlink("b");
      link("../grindir/./../a", "../b");
    } else if(what == 12){
     18c:	47b1                	li	a5,12
     18e:	2cf50d63          	beq	a0,a5,468 <go+0x3f0>
      unlink("../grindir/../a");
      link(".././b", "/grindir/../a");
    } else if(what == 13){
     192:	47b5                	li	a5,13
     194:	2ef50f63          	beq	a0,a5,492 <go+0x41a>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 14){
     198:	47b9                	li	a5,14
     19a:	32f50a63          	beq	a0,a5,4ce <go+0x456>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 15){
     19e:	47bd                	li	a5,15
     1a0:	36f50e63          	beq	a0,a5,51c <go+0x4a4>
      sbrk(6011);
    } else if(what == 16){
     1a4:	47c1                	li	a5,16
     1a6:	38f50363          	beq	a0,a5,52c <go+0x4b4>
      if(sbrk(0) > break0)
        sbrk(-(sbrk(0) - break0));
    } else if(what == 17){
     1aa:	47c5                	li	a5,17
     1ac:	3af50363          	beq	a0,a5,552 <go+0x4da>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
      wait(0);
    } else if(what == 18){
     1b0:	47c9                	li	a5,18
     1b2:	42f50963          	beq	a0,a5,5e4 <go+0x56c>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 19){
     1b6:	47cd                	li	a5,19
     1b8:	46f50d63          	beq	a0,a5,632 <go+0x5ba>
        exit(1);
      }
      close(fds[0]);
      close(fds[1]);
      wait(0);
    } else if(what == 20){
     1bc:	47d1                	li	a5,20
     1be:	54f50e63          	beq	a0,a5,71a <go+0x6a2>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 21){
     1c2:	47d5                	li	a5,21
     1c4:	5ef50c63          	beq	a0,a5,7bc <go+0x744>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
      unlink("c");
    } else if(what == 22){
     1c8:	47d9                	li	a5,22
     1ca:	f4f51ce3          	bne	a0,a5,122 <go+0xaa>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
     1ce:	f9840513          	addi	a0,s0,-104
     1d2:	00001097          	auipc	ra,0x1
     1d6:	ec6080e7          	jalr	-314(ra) # 1098 <pipe>
     1da:	6e054563          	bltz	a0,8c4 <go+0x84c>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
     1de:	fa040513          	addi	a0,s0,-96
     1e2:	00001097          	auipc	ra,0x1
     1e6:	eb6080e7          	jalr	-330(ra) # 1098 <pipe>
     1ea:	6e054b63          	bltz	a0,8e0 <go+0x868>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
     1ee:	00001097          	auipc	ra,0x1
     1f2:	e92080e7          	jalr	-366(ra) # 1080 <fork>
      if(pid1 == 0){
     1f6:	70050363          	beqz	a0,8fc <go+0x884>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
     1fa:	7a054b63          	bltz	a0,9b0 <go+0x938>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
     1fe:	00001097          	auipc	ra,0x1
     202:	e82080e7          	jalr	-382(ra) # 1080 <fork>
      if(pid2 == 0){
     206:	7c050363          	beqz	a0,9cc <go+0x954>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
     20a:	08054fe3          	bltz	a0,aa8 <go+0xa30>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
     20e:	f9842503          	lw	a0,-104(s0)
     212:	00001097          	auipc	ra,0x1
     216:	e9e080e7          	jalr	-354(ra) # 10b0 <close>
      close(aa[1]);
     21a:	f9c42503          	lw	a0,-100(s0)
     21e:	00001097          	auipc	ra,0x1
     222:	e92080e7          	jalr	-366(ra) # 10b0 <close>
      close(bb[1]);
     226:	fa442503          	lw	a0,-92(s0)
     22a:	00001097          	auipc	ra,0x1
     22e:	e86080e7          	jalr	-378(ra) # 10b0 <close>
      char buf[4] = { 0, 0, 0, 0 };
     232:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
     236:	4605                	li	a2,1
     238:	f9040593          	addi	a1,s0,-112
     23c:	fa042503          	lw	a0,-96(s0)
     240:	00001097          	auipc	ra,0x1
     244:	e60080e7          	jalr	-416(ra) # 10a0 <read>
      read(bb[0], buf+1, 1);
     248:	4605                	li	a2,1
     24a:	f9140593          	addi	a1,s0,-111
     24e:	fa042503          	lw	a0,-96(s0)
     252:	00001097          	auipc	ra,0x1
     256:	e4e080e7          	jalr	-434(ra) # 10a0 <read>
      read(bb[0], buf+2, 1);
     25a:	4605                	li	a2,1
     25c:	f9240593          	addi	a1,s0,-110
     260:	fa042503          	lw	a0,-96(s0)
     264:	00001097          	auipc	ra,0x1
     268:	e3c080e7          	jalr	-452(ra) # 10a0 <read>
      close(bb[0]);
     26c:	fa042503          	lw	a0,-96(s0)
     270:	00001097          	auipc	ra,0x1
     274:	e40080e7          	jalr	-448(ra) # 10b0 <close>
      int st1, st2;
      wait(&st1);
     278:	f9440513          	addi	a0,s0,-108
     27c:	00001097          	auipc	ra,0x1
     280:	e14080e7          	jalr	-492(ra) # 1090 <wait>
      wait(&st2);
     284:	fa840513          	addi	a0,s0,-88
     288:	00001097          	auipc	ra,0x1
     28c:	e08080e7          	jalr	-504(ra) # 1090 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
     290:	f9442783          	lw	a5,-108(s0)
     294:	fa842703          	lw	a4,-88(s0)
     298:	8fd9                	or	a5,a5,a4
     29a:	2781                	sext.w	a5,a5
     29c:	ef89                	bnez	a5,2b6 <go+0x23e>
     29e:	00001597          	auipc	a1,0x1
     2a2:	5ca58593          	addi	a1,a1,1482 # 1868 <malloc+0x3a2>
     2a6:	f9040513          	addi	a0,s0,-112
     2aa:	00001097          	auipc	ra,0x1
     2ae:	b8c080e7          	jalr	-1140(ra) # e36 <strcmp>
     2b2:	e60508e3          	beqz	a0,122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
     2b6:	f9040693          	addi	a3,s0,-112
     2ba:	fa842603          	lw	a2,-88(s0)
     2be:	f9442583          	lw	a1,-108(s0)
     2c2:	00001517          	auipc	a0,0x1
     2c6:	5ae50513          	addi	a0,a0,1454 # 1870 <malloc+0x3aa>
     2ca:	00001097          	auipc	ra,0x1
     2ce:	13e080e7          	jalr	318(ra) # 1408 <printf>
        exit(1);
     2d2:	4505                	li	a0,1
     2d4:	00001097          	auipc	ra,0x1
     2d8:	db4080e7          	jalr	-588(ra) # 1088 <exit>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
     2dc:	20200593          	li	a1,514
     2e0:	00001517          	auipc	a0,0x1
     2e4:	32050513          	addi	a0,a0,800 # 1600 <malloc+0x13a>
     2e8:	00001097          	auipc	ra,0x1
     2ec:	de0080e7          	jalr	-544(ra) # 10c8 <open>
     2f0:	00001097          	auipc	ra,0x1
     2f4:	dc0080e7          	jalr	-576(ra) # 10b0 <close>
     2f8:	b52d                	j	122 <go+0xaa>
      unlink("grindir/../a");
     2fa:	00001517          	auipc	a0,0x1
     2fe:	2f650513          	addi	a0,a0,758 # 15f0 <malloc+0x12a>
     302:	00001097          	auipc	ra,0x1
     306:	dd6080e7          	jalr	-554(ra) # 10d8 <unlink>
     30a:	bd21                	j	122 <go+0xaa>
      if(chdir("grindir") != 0){
     30c:	00001517          	auipc	a0,0x1
     310:	2a450513          	addi	a0,a0,676 # 15b0 <malloc+0xea>
     314:	00001097          	auipc	ra,0x1
     318:	de4080e7          	jalr	-540(ra) # 10f8 <chdir>
     31c:	e115                	bnez	a0,340 <go+0x2c8>
      unlink("../b");
     31e:	00001517          	auipc	a0,0x1
     322:	2fa50513          	addi	a0,a0,762 # 1618 <malloc+0x152>
     326:	00001097          	auipc	ra,0x1
     32a:	db2080e7          	jalr	-590(ra) # 10d8 <unlink>
      chdir("/");
     32e:	00001517          	auipc	a0,0x1
     332:	2aa50513          	addi	a0,a0,682 # 15d8 <malloc+0x112>
     336:	00001097          	auipc	ra,0x1
     33a:	dc2080e7          	jalr	-574(ra) # 10f8 <chdir>
     33e:	b3d5                	j	122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
     340:	00001517          	auipc	a0,0x1
     344:	27850513          	addi	a0,a0,632 # 15b8 <malloc+0xf2>
     348:	00001097          	auipc	ra,0x1
     34c:	0c0080e7          	jalr	192(ra) # 1408 <printf>
        exit(1);
     350:	4505                	li	a0,1
     352:	00001097          	auipc	ra,0x1
     356:	d36080e7          	jalr	-714(ra) # 1088 <exit>
      close(fd);
     35a:	854a                	mv	a0,s2
     35c:	00001097          	auipc	ra,0x1
     360:	d54080e7          	jalr	-684(ra) # 10b0 <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
     364:	20200593          	li	a1,514
     368:	00001517          	auipc	a0,0x1
     36c:	2b850513          	addi	a0,a0,696 # 1620 <malloc+0x15a>
     370:	00001097          	auipc	ra,0x1
     374:	d58080e7          	jalr	-680(ra) # 10c8 <open>
     378:	892a                	mv	s2,a0
     37a:	b365                	j	122 <go+0xaa>
      close(fd);
     37c:	854a                	mv	a0,s2
     37e:	00001097          	auipc	ra,0x1
     382:	d32080e7          	jalr	-718(ra) # 10b0 <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
     386:	20200593          	li	a1,514
     38a:	00001517          	auipc	a0,0x1
     38e:	2a650513          	addi	a0,a0,678 # 1630 <malloc+0x16a>
     392:	00001097          	auipc	ra,0x1
     396:	d36080e7          	jalr	-714(ra) # 10c8 <open>
     39a:	892a                	mv	s2,a0
     39c:	b359                	j	122 <go+0xaa>
      write(fd, buf, sizeof(buf));
     39e:	3e700613          	li	a2,999
     3a2:	85d2                	mv	a1,s4
     3a4:	854a                	mv	a0,s2
     3a6:	00001097          	auipc	ra,0x1
     3aa:	d02080e7          	jalr	-766(ra) # 10a8 <write>
     3ae:	bb95                	j	122 <go+0xaa>
      read(fd, buf, sizeof(buf));
     3b0:	3e700613          	li	a2,999
     3b4:	85d2                	mv	a1,s4
     3b6:	854a                	mv	a0,s2
     3b8:	00001097          	auipc	ra,0x1
     3bc:	ce8080e7          	jalr	-792(ra) # 10a0 <read>
     3c0:	b38d                	j	122 <go+0xaa>
      mkdir("grindir/../a");
     3c2:	00001517          	auipc	a0,0x1
     3c6:	22e50513          	addi	a0,a0,558 # 15f0 <malloc+0x12a>
     3ca:	00001097          	auipc	ra,0x1
     3ce:	d26080e7          	jalr	-730(ra) # 10f0 <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
     3d2:	20200593          	li	a1,514
     3d6:	00001517          	auipc	a0,0x1
     3da:	27250513          	addi	a0,a0,626 # 1648 <malloc+0x182>
     3de:	00001097          	auipc	ra,0x1
     3e2:	cea080e7          	jalr	-790(ra) # 10c8 <open>
     3e6:	00001097          	auipc	ra,0x1
     3ea:	cca080e7          	jalr	-822(ra) # 10b0 <close>
      unlink("a/a");
     3ee:	00001517          	auipc	a0,0x1
     3f2:	26a50513          	addi	a0,a0,618 # 1658 <malloc+0x192>
     3f6:	00001097          	auipc	ra,0x1
     3fa:	ce2080e7          	jalr	-798(ra) # 10d8 <unlink>
     3fe:	b315                	j	122 <go+0xaa>
      mkdir("/../b");
     400:	00001517          	auipc	a0,0x1
     404:	26050513          	addi	a0,a0,608 # 1660 <malloc+0x19a>
     408:	00001097          	auipc	ra,0x1
     40c:	ce8080e7          	jalr	-792(ra) # 10f0 <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
     410:	20200593          	li	a1,514
     414:	00001517          	auipc	a0,0x1
     418:	25450513          	addi	a0,a0,596 # 1668 <malloc+0x1a2>
     41c:	00001097          	auipc	ra,0x1
     420:	cac080e7          	jalr	-852(ra) # 10c8 <open>
     424:	00001097          	auipc	ra,0x1
     428:	c8c080e7          	jalr	-884(ra) # 10b0 <close>
      unlink("b/b");
     42c:	00001517          	auipc	a0,0x1
     430:	24c50513          	addi	a0,a0,588 # 1678 <malloc+0x1b2>
     434:	00001097          	auipc	ra,0x1
     438:	ca4080e7          	jalr	-860(ra) # 10d8 <unlink>
     43c:	b1dd                	j	122 <go+0xaa>
      unlink("b");
     43e:	00001517          	auipc	a0,0x1
     442:	20250513          	addi	a0,a0,514 # 1640 <malloc+0x17a>
     446:	00001097          	auipc	ra,0x1
     44a:	c92080e7          	jalr	-878(ra) # 10d8 <unlink>
      link("../grindir/./../a", "../b");
     44e:	00001597          	auipc	a1,0x1
     452:	1ca58593          	addi	a1,a1,458 # 1618 <malloc+0x152>
     456:	00001517          	auipc	a0,0x1
     45a:	22a50513          	addi	a0,a0,554 # 1680 <malloc+0x1ba>
     45e:	00001097          	auipc	ra,0x1
     462:	c8a080e7          	jalr	-886(ra) # 10e8 <link>
     466:	b975                	j	122 <go+0xaa>
      unlink("../grindir/../a");
     468:	00001517          	auipc	a0,0x1
     46c:	23050513          	addi	a0,a0,560 # 1698 <malloc+0x1d2>
     470:	00001097          	auipc	ra,0x1
     474:	c68080e7          	jalr	-920(ra) # 10d8 <unlink>
      link(".././b", "/grindir/../a");
     478:	00001597          	auipc	a1,0x1
     47c:	1a858593          	addi	a1,a1,424 # 1620 <malloc+0x15a>
     480:	00001517          	auipc	a0,0x1
     484:	22850513          	addi	a0,a0,552 # 16a8 <malloc+0x1e2>
     488:	00001097          	auipc	ra,0x1
     48c:	c60080e7          	jalr	-928(ra) # 10e8 <link>
     490:	b949                	j	122 <go+0xaa>
      int pid = fork();
     492:	00001097          	auipc	ra,0x1
     496:	bee080e7          	jalr	-1042(ra) # 1080 <fork>
      if(pid == 0){
     49a:	c909                	beqz	a0,4ac <go+0x434>
      } else if(pid < 0){
     49c:	00054c63          	bltz	a0,4b4 <go+0x43c>
      wait(0);
     4a0:	4501                	li	a0,0
     4a2:	00001097          	auipc	ra,0x1
     4a6:	bee080e7          	jalr	-1042(ra) # 1090 <wait>
     4aa:	b9a5                	j	122 <go+0xaa>
        exit(0);
     4ac:	00001097          	auipc	ra,0x1
     4b0:	bdc080e7          	jalr	-1060(ra) # 1088 <exit>
        printf("grind: fork failed\n");
     4b4:	00001517          	auipc	a0,0x1
     4b8:	1fc50513          	addi	a0,a0,508 # 16b0 <malloc+0x1ea>
     4bc:	00001097          	auipc	ra,0x1
     4c0:	f4c080e7          	jalr	-180(ra) # 1408 <printf>
        exit(1);
     4c4:	4505                	li	a0,1
     4c6:	00001097          	auipc	ra,0x1
     4ca:	bc2080e7          	jalr	-1086(ra) # 1088 <exit>
      int pid = fork();
     4ce:	00001097          	auipc	ra,0x1
     4d2:	bb2080e7          	jalr	-1102(ra) # 1080 <fork>
      if(pid == 0){
     4d6:	c909                	beqz	a0,4e8 <go+0x470>
      } else if(pid < 0){
     4d8:	02054563          	bltz	a0,502 <go+0x48a>
      wait(0);
     4dc:	4501                	li	a0,0
     4de:	00001097          	auipc	ra,0x1
     4e2:	bb2080e7          	jalr	-1102(ra) # 1090 <wait>
     4e6:	b935                	j	122 <go+0xaa>
        fork();
     4e8:	00001097          	auipc	ra,0x1
     4ec:	b98080e7          	jalr	-1128(ra) # 1080 <fork>
        fork();
     4f0:	00001097          	auipc	ra,0x1
     4f4:	b90080e7          	jalr	-1136(ra) # 1080 <fork>
        exit(0);
     4f8:	4501                	li	a0,0
     4fa:	00001097          	auipc	ra,0x1
     4fe:	b8e080e7          	jalr	-1138(ra) # 1088 <exit>
        printf("grind: fork failed\n");
     502:	00001517          	auipc	a0,0x1
     506:	1ae50513          	addi	a0,a0,430 # 16b0 <malloc+0x1ea>
     50a:	00001097          	auipc	ra,0x1
     50e:	efe080e7          	jalr	-258(ra) # 1408 <printf>
        exit(1);
     512:	4505                	li	a0,1
     514:	00001097          	auipc	ra,0x1
     518:	b74080e7          	jalr	-1164(ra) # 1088 <exit>
      sbrk(6011);
     51c:	6505                	lui	a0,0x1
     51e:	77b50513          	addi	a0,a0,1915 # 177b <malloc+0x2b5>
     522:	00001097          	auipc	ra,0x1
     526:	bee080e7          	jalr	-1042(ra) # 1110 <sbrk>
     52a:	bee5                	j	122 <go+0xaa>
      if(sbrk(0) > break0)
     52c:	4501                	li	a0,0
     52e:	00001097          	auipc	ra,0x1
     532:	be2080e7          	jalr	-1054(ra) # 1110 <sbrk>
     536:	beaaf6e3          	bgeu	s5,a0,122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
     53a:	4501                	li	a0,0
     53c:	00001097          	auipc	ra,0x1
     540:	bd4080e7          	jalr	-1068(ra) # 1110 <sbrk>
     544:	40aa853b          	subw	a0,s5,a0
     548:	00001097          	auipc	ra,0x1
     54c:	bc8080e7          	jalr	-1080(ra) # 1110 <sbrk>
     550:	bec9                	j	122 <go+0xaa>
      int pid = fork();
     552:	00001097          	auipc	ra,0x1
     556:	b2e080e7          	jalr	-1234(ra) # 1080 <fork>
     55a:	8b2a                	mv	s6,a0
      if(pid == 0){
     55c:	c51d                	beqz	a0,58a <go+0x512>
      } else if(pid < 0){
     55e:	04054963          	bltz	a0,5b0 <go+0x538>
      if(chdir("../grindir/..") != 0){
     562:	00001517          	auipc	a0,0x1
     566:	16650513          	addi	a0,a0,358 # 16c8 <malloc+0x202>
     56a:	00001097          	auipc	ra,0x1
     56e:	b8e080e7          	jalr	-1138(ra) # 10f8 <chdir>
     572:	ed21                	bnez	a0,5ca <go+0x552>
      kill(pid);
     574:	855a                	mv	a0,s6
     576:	00001097          	auipc	ra,0x1
     57a:	b42080e7          	jalr	-1214(ra) # 10b8 <kill>
      wait(0);
     57e:	4501                	li	a0,0
     580:	00001097          	auipc	ra,0x1
     584:	b10080e7          	jalr	-1264(ra) # 1090 <wait>
     588:	be69                	j	122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
     58a:	20200593          	li	a1,514
     58e:	00001517          	auipc	a0,0x1
     592:	10250513          	addi	a0,a0,258 # 1690 <malloc+0x1ca>
     596:	00001097          	auipc	ra,0x1
     59a:	b32080e7          	jalr	-1230(ra) # 10c8 <open>
     59e:	00001097          	auipc	ra,0x1
     5a2:	b12080e7          	jalr	-1262(ra) # 10b0 <close>
        exit(0);
     5a6:	4501                	li	a0,0
     5a8:	00001097          	auipc	ra,0x1
     5ac:	ae0080e7          	jalr	-1312(ra) # 1088 <exit>
        printf("grind: fork failed\n");
     5b0:	00001517          	auipc	a0,0x1
     5b4:	10050513          	addi	a0,a0,256 # 16b0 <malloc+0x1ea>
     5b8:	00001097          	auipc	ra,0x1
     5bc:	e50080e7          	jalr	-432(ra) # 1408 <printf>
        exit(1);
     5c0:	4505                	li	a0,1
     5c2:	00001097          	auipc	ra,0x1
     5c6:	ac6080e7          	jalr	-1338(ra) # 1088 <exit>
        printf("grind: chdir failed\n");
     5ca:	00001517          	auipc	a0,0x1
     5ce:	10e50513          	addi	a0,a0,270 # 16d8 <malloc+0x212>
     5d2:	00001097          	auipc	ra,0x1
     5d6:	e36080e7          	jalr	-458(ra) # 1408 <printf>
        exit(1);
     5da:	4505                	li	a0,1
     5dc:	00001097          	auipc	ra,0x1
     5e0:	aac080e7          	jalr	-1364(ra) # 1088 <exit>
      int pid = fork();
     5e4:	00001097          	auipc	ra,0x1
     5e8:	a9c080e7          	jalr	-1380(ra) # 1080 <fork>
      if(pid == 0){
     5ec:	c909                	beqz	a0,5fe <go+0x586>
      } else if(pid < 0){
     5ee:	02054563          	bltz	a0,618 <go+0x5a0>
      wait(0);
     5f2:	4501                	li	a0,0
     5f4:	00001097          	auipc	ra,0x1
     5f8:	a9c080e7          	jalr	-1380(ra) # 1090 <wait>
     5fc:	b61d                	j	122 <go+0xaa>
        kill(getpid());
     5fe:	00001097          	auipc	ra,0x1
     602:	b0a080e7          	jalr	-1270(ra) # 1108 <getpid>
     606:	00001097          	auipc	ra,0x1
     60a:	ab2080e7          	jalr	-1358(ra) # 10b8 <kill>
        exit(0);
     60e:	4501                	li	a0,0
     610:	00001097          	auipc	ra,0x1
     614:	a78080e7          	jalr	-1416(ra) # 1088 <exit>
        printf("grind: fork failed\n");
     618:	00001517          	auipc	a0,0x1
     61c:	09850513          	addi	a0,a0,152 # 16b0 <malloc+0x1ea>
     620:	00001097          	auipc	ra,0x1
     624:	de8080e7          	jalr	-536(ra) # 1408 <printf>
        exit(1);
     628:	4505                	li	a0,1
     62a:	00001097          	auipc	ra,0x1
     62e:	a5e080e7          	jalr	-1442(ra) # 1088 <exit>
      if(pipe(fds) < 0){
     632:	fa840513          	addi	a0,s0,-88
     636:	00001097          	auipc	ra,0x1
     63a:	a62080e7          	jalr	-1438(ra) # 1098 <pipe>
     63e:	02054b63          	bltz	a0,674 <go+0x5fc>
      int pid = fork();
     642:	00001097          	auipc	ra,0x1
     646:	a3e080e7          	jalr	-1474(ra) # 1080 <fork>
      if(pid == 0){
     64a:	c131                	beqz	a0,68e <go+0x616>
      } else if(pid < 0){
     64c:	0a054a63          	bltz	a0,700 <go+0x688>
      close(fds[0]);
     650:	fa842503          	lw	a0,-88(s0)
     654:	00001097          	auipc	ra,0x1
     658:	a5c080e7          	jalr	-1444(ra) # 10b0 <close>
      close(fds[1]);
     65c:	fac42503          	lw	a0,-84(s0)
     660:	00001097          	auipc	ra,0x1
     664:	a50080e7          	jalr	-1456(ra) # 10b0 <close>
      wait(0);
     668:	4501                	li	a0,0
     66a:	00001097          	auipc	ra,0x1
     66e:	a26080e7          	jalr	-1498(ra) # 1090 <wait>
     672:	bc45                	j	122 <go+0xaa>
        printf("grind: pipe failed\n");
     674:	00001517          	auipc	a0,0x1
     678:	07c50513          	addi	a0,a0,124 # 16f0 <malloc+0x22a>
     67c:	00001097          	auipc	ra,0x1
     680:	d8c080e7          	jalr	-628(ra) # 1408 <printf>
        exit(1);
     684:	4505                	li	a0,1
     686:	00001097          	auipc	ra,0x1
     68a:	a02080e7          	jalr	-1534(ra) # 1088 <exit>
        fork();
     68e:	00001097          	auipc	ra,0x1
     692:	9f2080e7          	jalr	-1550(ra) # 1080 <fork>
        fork();
     696:	00001097          	auipc	ra,0x1
     69a:	9ea080e7          	jalr	-1558(ra) # 1080 <fork>
        if(write(fds[1], "x", 1) != 1)
     69e:	4605                	li	a2,1
     6a0:	00001597          	auipc	a1,0x1
     6a4:	06858593          	addi	a1,a1,104 # 1708 <malloc+0x242>
     6a8:	fac42503          	lw	a0,-84(s0)
     6ac:	00001097          	auipc	ra,0x1
     6b0:	9fc080e7          	jalr	-1540(ra) # 10a8 <write>
     6b4:	4785                	li	a5,1
     6b6:	02f51363          	bne	a0,a5,6dc <go+0x664>
        if(read(fds[0], &c, 1) != 1)
     6ba:	4605                	li	a2,1
     6bc:	fa040593          	addi	a1,s0,-96
     6c0:	fa842503          	lw	a0,-88(s0)
     6c4:	00001097          	auipc	ra,0x1
     6c8:	9dc080e7          	jalr	-1572(ra) # 10a0 <read>
     6cc:	4785                	li	a5,1
     6ce:	02f51063          	bne	a0,a5,6ee <go+0x676>
        exit(0);
     6d2:	4501                	li	a0,0
     6d4:	00001097          	auipc	ra,0x1
     6d8:	9b4080e7          	jalr	-1612(ra) # 1088 <exit>
          printf("grind: pipe write failed\n");
     6dc:	00001517          	auipc	a0,0x1
     6e0:	03450513          	addi	a0,a0,52 # 1710 <malloc+0x24a>
     6e4:	00001097          	auipc	ra,0x1
     6e8:	d24080e7          	jalr	-732(ra) # 1408 <printf>
     6ec:	b7f9                	j	6ba <go+0x642>
          printf("grind: pipe read failed\n");
     6ee:	00001517          	auipc	a0,0x1
     6f2:	04250513          	addi	a0,a0,66 # 1730 <malloc+0x26a>
     6f6:	00001097          	auipc	ra,0x1
     6fa:	d12080e7          	jalr	-750(ra) # 1408 <printf>
     6fe:	bfd1                	j	6d2 <go+0x65a>
        printf("grind: fork failed\n");
     700:	00001517          	auipc	a0,0x1
     704:	fb050513          	addi	a0,a0,-80 # 16b0 <malloc+0x1ea>
     708:	00001097          	auipc	ra,0x1
     70c:	d00080e7          	jalr	-768(ra) # 1408 <printf>
        exit(1);
     710:	4505                	li	a0,1
     712:	00001097          	auipc	ra,0x1
     716:	976080e7          	jalr	-1674(ra) # 1088 <exit>
      int pid = fork();
     71a:	00001097          	auipc	ra,0x1
     71e:	966080e7          	jalr	-1690(ra) # 1080 <fork>
      if(pid == 0){
     722:	c909                	beqz	a0,734 <go+0x6bc>
      } else if(pid < 0){
     724:	06054f63          	bltz	a0,7a2 <go+0x72a>
      wait(0);
     728:	4501                	li	a0,0
     72a:	00001097          	auipc	ra,0x1
     72e:	966080e7          	jalr	-1690(ra) # 1090 <wait>
     732:	bac5                	j	122 <go+0xaa>
        unlink("a");
     734:	00001517          	auipc	a0,0x1
     738:	f5c50513          	addi	a0,a0,-164 # 1690 <malloc+0x1ca>
     73c:	00001097          	auipc	ra,0x1
     740:	99c080e7          	jalr	-1636(ra) # 10d8 <unlink>
        mkdir("a");
     744:	00001517          	auipc	a0,0x1
     748:	f4c50513          	addi	a0,a0,-180 # 1690 <malloc+0x1ca>
     74c:	00001097          	auipc	ra,0x1
     750:	9a4080e7          	jalr	-1628(ra) # 10f0 <mkdir>
        chdir("a");
     754:	00001517          	auipc	a0,0x1
     758:	f3c50513          	addi	a0,a0,-196 # 1690 <malloc+0x1ca>
     75c:	00001097          	auipc	ra,0x1
     760:	99c080e7          	jalr	-1636(ra) # 10f8 <chdir>
        unlink("../a");
     764:	00001517          	auipc	a0,0x1
     768:	e9450513          	addi	a0,a0,-364 # 15f8 <malloc+0x132>
     76c:	00001097          	auipc	ra,0x1
     770:	96c080e7          	jalr	-1684(ra) # 10d8 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
     774:	20200593          	li	a1,514
     778:	00001517          	auipc	a0,0x1
     77c:	f9050513          	addi	a0,a0,-112 # 1708 <malloc+0x242>
     780:	00001097          	auipc	ra,0x1
     784:	948080e7          	jalr	-1720(ra) # 10c8 <open>
        unlink("x");
     788:	00001517          	auipc	a0,0x1
     78c:	f8050513          	addi	a0,a0,-128 # 1708 <malloc+0x242>
     790:	00001097          	auipc	ra,0x1
     794:	948080e7          	jalr	-1720(ra) # 10d8 <unlink>
        exit(0);
     798:	4501                	li	a0,0
     79a:	00001097          	auipc	ra,0x1
     79e:	8ee080e7          	jalr	-1810(ra) # 1088 <exit>
        printf("grind: fork failed\n");
     7a2:	00001517          	auipc	a0,0x1
     7a6:	f0e50513          	addi	a0,a0,-242 # 16b0 <malloc+0x1ea>
     7aa:	00001097          	auipc	ra,0x1
     7ae:	c5e080e7          	jalr	-930(ra) # 1408 <printf>
        exit(1);
     7b2:	4505                	li	a0,1
     7b4:	00001097          	auipc	ra,0x1
     7b8:	8d4080e7          	jalr	-1836(ra) # 1088 <exit>
      unlink("c");
     7bc:	00001517          	auipc	a0,0x1
     7c0:	f9450513          	addi	a0,a0,-108 # 1750 <malloc+0x28a>
     7c4:	00001097          	auipc	ra,0x1
     7c8:	914080e7          	jalr	-1772(ra) # 10d8 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
     7cc:	20200593          	li	a1,514
     7d0:	00001517          	auipc	a0,0x1
     7d4:	f8050513          	addi	a0,a0,-128 # 1750 <malloc+0x28a>
     7d8:	00001097          	auipc	ra,0x1
     7dc:	8f0080e7          	jalr	-1808(ra) # 10c8 <open>
     7e0:	8b2a                	mv	s6,a0
      if(fd1 < 0){
     7e2:	04054f63          	bltz	a0,840 <go+0x7c8>
      if(write(fd1, "x", 1) != 1){
     7e6:	4605                	li	a2,1
     7e8:	00001597          	auipc	a1,0x1
     7ec:	f2058593          	addi	a1,a1,-224 # 1708 <malloc+0x242>
     7f0:	00001097          	auipc	ra,0x1
     7f4:	8b8080e7          	jalr	-1864(ra) # 10a8 <write>
     7f8:	4785                	li	a5,1
     7fa:	06f51063          	bne	a0,a5,85a <go+0x7e2>
      if(fstat(fd1, &st) != 0){
     7fe:	fa840593          	addi	a1,s0,-88
     802:	855a                	mv	a0,s6
     804:	00001097          	auipc	ra,0x1
     808:	8dc080e7          	jalr	-1828(ra) # 10e0 <fstat>
     80c:	e525                	bnez	a0,874 <go+0x7fc>
      if(st.size != 1){
     80e:	fb843583          	ld	a1,-72(s0)
     812:	4785                	li	a5,1
     814:	06f59d63          	bne	a1,a5,88e <go+0x816>
      if(st.ino > 200){
     818:	fac42583          	lw	a1,-84(s0)
     81c:	0c800793          	li	a5,200
     820:	08b7e563          	bltu	a5,a1,8aa <go+0x832>
      close(fd1);
     824:	855a                	mv	a0,s6
     826:	00001097          	auipc	ra,0x1
     82a:	88a080e7          	jalr	-1910(ra) # 10b0 <close>
      unlink("c");
     82e:	00001517          	auipc	a0,0x1
     832:	f2250513          	addi	a0,a0,-222 # 1750 <malloc+0x28a>
     836:	00001097          	auipc	ra,0x1
     83a:	8a2080e7          	jalr	-1886(ra) # 10d8 <unlink>
     83e:	b0d5                	j	122 <go+0xaa>
        printf("grind: create c failed\n");
     840:	00001517          	auipc	a0,0x1
     844:	f1850513          	addi	a0,a0,-232 # 1758 <malloc+0x292>
     848:	00001097          	auipc	ra,0x1
     84c:	bc0080e7          	jalr	-1088(ra) # 1408 <printf>
        exit(1);
     850:	4505                	li	a0,1
     852:	00001097          	auipc	ra,0x1
     856:	836080e7          	jalr	-1994(ra) # 1088 <exit>
        printf("grind: write c failed\n");
     85a:	00001517          	auipc	a0,0x1
     85e:	f1650513          	addi	a0,a0,-234 # 1770 <malloc+0x2aa>
     862:	00001097          	auipc	ra,0x1
     866:	ba6080e7          	jalr	-1114(ra) # 1408 <printf>
        exit(1);
     86a:	4505                	li	a0,1
     86c:	00001097          	auipc	ra,0x1
     870:	81c080e7          	jalr	-2020(ra) # 1088 <exit>
        printf("grind: fstat failed\n");
     874:	00001517          	auipc	a0,0x1
     878:	f1450513          	addi	a0,a0,-236 # 1788 <malloc+0x2c2>
     87c:	00001097          	auipc	ra,0x1
     880:	b8c080e7          	jalr	-1140(ra) # 1408 <printf>
        exit(1);
     884:	4505                	li	a0,1
     886:	00001097          	auipc	ra,0x1
     88a:	802080e7          	jalr	-2046(ra) # 1088 <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
     88e:	2581                	sext.w	a1,a1
     890:	00001517          	auipc	a0,0x1
     894:	f1050513          	addi	a0,a0,-240 # 17a0 <malloc+0x2da>
     898:	00001097          	auipc	ra,0x1
     89c:	b70080e7          	jalr	-1168(ra) # 1408 <printf>
        exit(1);
     8a0:	4505                	li	a0,1
     8a2:	00000097          	auipc	ra,0x0
     8a6:	7e6080e7          	jalr	2022(ra) # 1088 <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
     8aa:	00001517          	auipc	a0,0x1
     8ae:	f1e50513          	addi	a0,a0,-226 # 17c8 <malloc+0x302>
     8b2:	00001097          	auipc	ra,0x1
     8b6:	b56080e7          	jalr	-1194(ra) # 1408 <printf>
        exit(1);
     8ba:	4505                	li	a0,1
     8bc:	00000097          	auipc	ra,0x0
     8c0:	7cc080e7          	jalr	1996(ra) # 1088 <exit>
        fprintf(2, "grind: pipe failed\n");
     8c4:	00001597          	auipc	a1,0x1
     8c8:	e2c58593          	addi	a1,a1,-468 # 16f0 <malloc+0x22a>
     8cc:	4509                	li	a0,2
     8ce:	00001097          	auipc	ra,0x1
     8d2:	b0c080e7          	jalr	-1268(ra) # 13da <fprintf>
        exit(1);
     8d6:	4505                	li	a0,1
     8d8:	00000097          	auipc	ra,0x0
     8dc:	7b0080e7          	jalr	1968(ra) # 1088 <exit>
        fprintf(2, "grind: pipe failed\n");
     8e0:	00001597          	auipc	a1,0x1
     8e4:	e1058593          	addi	a1,a1,-496 # 16f0 <malloc+0x22a>
     8e8:	4509                	li	a0,2
     8ea:	00001097          	auipc	ra,0x1
     8ee:	af0080e7          	jalr	-1296(ra) # 13da <fprintf>
        exit(1);
     8f2:	4505                	li	a0,1
     8f4:	00000097          	auipc	ra,0x0
     8f8:	794080e7          	jalr	1940(ra) # 1088 <exit>
        close(bb[0]);
     8fc:	fa042503          	lw	a0,-96(s0)
     900:	00000097          	auipc	ra,0x0
     904:	7b0080e7          	jalr	1968(ra) # 10b0 <close>
        close(bb[1]);
     908:	fa442503          	lw	a0,-92(s0)
     90c:	00000097          	auipc	ra,0x0
     910:	7a4080e7          	jalr	1956(ra) # 10b0 <close>
        close(aa[0]);
     914:	f9842503          	lw	a0,-104(s0)
     918:	00000097          	auipc	ra,0x0
     91c:	798080e7          	jalr	1944(ra) # 10b0 <close>
        close(1);
     920:	4505                	li	a0,1
     922:	00000097          	auipc	ra,0x0
     926:	78e080e7          	jalr	1934(ra) # 10b0 <close>
        if(dup(aa[1]) != 1){
     92a:	f9c42503          	lw	a0,-100(s0)
     92e:	00000097          	auipc	ra,0x0
     932:	7d2080e7          	jalr	2002(ra) # 1100 <dup>
     936:	4785                	li	a5,1
     938:	02f50063          	beq	a0,a5,958 <go+0x8e0>
          fprintf(2, "grind: dup failed\n");
     93c:	00001597          	auipc	a1,0x1
     940:	eb458593          	addi	a1,a1,-332 # 17f0 <malloc+0x32a>
     944:	4509                	li	a0,2
     946:	00001097          	auipc	ra,0x1
     94a:	a94080e7          	jalr	-1388(ra) # 13da <fprintf>
          exit(1);
     94e:	4505                	li	a0,1
     950:	00000097          	auipc	ra,0x0
     954:	738080e7          	jalr	1848(ra) # 1088 <exit>
        close(aa[1]);
     958:	f9c42503          	lw	a0,-100(s0)
     95c:	00000097          	auipc	ra,0x0
     960:	754080e7          	jalr	1876(ra) # 10b0 <close>
        char *args[3] = { "echo", "hi", 0 };
     964:	00001797          	auipc	a5,0x1
     968:	ea478793          	addi	a5,a5,-348 # 1808 <malloc+0x342>
     96c:	faf43423          	sd	a5,-88(s0)
     970:	00001797          	auipc	a5,0x1
     974:	ea078793          	addi	a5,a5,-352 # 1810 <malloc+0x34a>
     978:	faf43823          	sd	a5,-80(s0)
     97c:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
     980:	fa840593          	addi	a1,s0,-88
     984:	00001517          	auipc	a0,0x1
     988:	e9450513          	addi	a0,a0,-364 # 1818 <malloc+0x352>
     98c:	00000097          	auipc	ra,0x0
     990:	734080e7          	jalr	1844(ra) # 10c0 <exec>
        fprintf(2, "grind: echo: not found\n");
     994:	00001597          	auipc	a1,0x1
     998:	e9458593          	addi	a1,a1,-364 # 1828 <malloc+0x362>
     99c:	4509                	li	a0,2
     99e:	00001097          	auipc	ra,0x1
     9a2:	a3c080e7          	jalr	-1476(ra) # 13da <fprintf>
        exit(2);
     9a6:	4509                	li	a0,2
     9a8:	00000097          	auipc	ra,0x0
     9ac:	6e0080e7          	jalr	1760(ra) # 1088 <exit>
        fprintf(2, "grind: fork failed\n");
     9b0:	00001597          	auipc	a1,0x1
     9b4:	d0058593          	addi	a1,a1,-768 # 16b0 <malloc+0x1ea>
     9b8:	4509                	li	a0,2
     9ba:	00001097          	auipc	ra,0x1
     9be:	a20080e7          	jalr	-1504(ra) # 13da <fprintf>
        exit(3);
     9c2:	450d                	li	a0,3
     9c4:	00000097          	auipc	ra,0x0
     9c8:	6c4080e7          	jalr	1732(ra) # 1088 <exit>
        close(aa[1]);
     9cc:	f9c42503          	lw	a0,-100(s0)
     9d0:	00000097          	auipc	ra,0x0
     9d4:	6e0080e7          	jalr	1760(ra) # 10b0 <close>
        close(bb[0]);
     9d8:	fa042503          	lw	a0,-96(s0)
     9dc:	00000097          	auipc	ra,0x0
     9e0:	6d4080e7          	jalr	1748(ra) # 10b0 <close>
        close(0);
     9e4:	4501                	li	a0,0
     9e6:	00000097          	auipc	ra,0x0
     9ea:	6ca080e7          	jalr	1738(ra) # 10b0 <close>
        if(dup(aa[0]) != 0){
     9ee:	f9842503          	lw	a0,-104(s0)
     9f2:	00000097          	auipc	ra,0x0
     9f6:	70e080e7          	jalr	1806(ra) # 1100 <dup>
     9fa:	cd19                	beqz	a0,a18 <go+0x9a0>
          fprintf(2, "grind: dup failed\n");
     9fc:	00001597          	auipc	a1,0x1
     a00:	df458593          	addi	a1,a1,-524 # 17f0 <malloc+0x32a>
     a04:	4509                	li	a0,2
     a06:	00001097          	auipc	ra,0x1
     a0a:	9d4080e7          	jalr	-1580(ra) # 13da <fprintf>
          exit(4);
     a0e:	4511                	li	a0,4
     a10:	00000097          	auipc	ra,0x0
     a14:	678080e7          	jalr	1656(ra) # 1088 <exit>
        close(aa[0]);
     a18:	f9842503          	lw	a0,-104(s0)
     a1c:	00000097          	auipc	ra,0x0
     a20:	694080e7          	jalr	1684(ra) # 10b0 <close>
        close(1);
     a24:	4505                	li	a0,1
     a26:	00000097          	auipc	ra,0x0
     a2a:	68a080e7          	jalr	1674(ra) # 10b0 <close>
        if(dup(bb[1]) != 1){
     a2e:	fa442503          	lw	a0,-92(s0)
     a32:	00000097          	auipc	ra,0x0
     a36:	6ce080e7          	jalr	1742(ra) # 1100 <dup>
     a3a:	4785                	li	a5,1
     a3c:	02f50063          	beq	a0,a5,a5c <go+0x9e4>
          fprintf(2, "grind: dup failed\n");
     a40:	00001597          	auipc	a1,0x1
     a44:	db058593          	addi	a1,a1,-592 # 17f0 <malloc+0x32a>
     a48:	4509                	li	a0,2
     a4a:	00001097          	auipc	ra,0x1
     a4e:	990080e7          	jalr	-1648(ra) # 13da <fprintf>
          exit(5);
     a52:	4515                	li	a0,5
     a54:	00000097          	auipc	ra,0x0
     a58:	634080e7          	jalr	1588(ra) # 1088 <exit>
        close(bb[1]);
     a5c:	fa442503          	lw	a0,-92(s0)
     a60:	00000097          	auipc	ra,0x0
     a64:	650080e7          	jalr	1616(ra) # 10b0 <close>
        char *args[2] = { "cat", 0 };
     a68:	00001797          	auipc	a5,0x1
     a6c:	dd878793          	addi	a5,a5,-552 # 1840 <malloc+0x37a>
     a70:	faf43423          	sd	a5,-88(s0)
     a74:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
     a78:	fa840593          	addi	a1,s0,-88
     a7c:	00001517          	auipc	a0,0x1
     a80:	dcc50513          	addi	a0,a0,-564 # 1848 <malloc+0x382>
     a84:	00000097          	auipc	ra,0x0
     a88:	63c080e7          	jalr	1596(ra) # 10c0 <exec>
        fprintf(2, "grind: cat: not found\n");
     a8c:	00001597          	auipc	a1,0x1
     a90:	dc458593          	addi	a1,a1,-572 # 1850 <malloc+0x38a>
     a94:	4509                	li	a0,2
     a96:	00001097          	auipc	ra,0x1
     a9a:	944080e7          	jalr	-1724(ra) # 13da <fprintf>
        exit(6);
     a9e:	4519                	li	a0,6
     aa0:	00000097          	auipc	ra,0x0
     aa4:	5e8080e7          	jalr	1512(ra) # 1088 <exit>
        fprintf(2, "grind: fork failed\n");
     aa8:	00001597          	auipc	a1,0x1
     aac:	c0858593          	addi	a1,a1,-1016 # 16b0 <malloc+0x1ea>
     ab0:	4509                	li	a0,2
     ab2:	00001097          	auipc	ra,0x1
     ab6:	928080e7          	jalr	-1752(ra) # 13da <fprintf>
        exit(7);
     aba:	451d                	li	a0,7
     abc:	00000097          	auipc	ra,0x0
     ac0:	5cc080e7          	jalr	1484(ra) # 1088 <exit>

0000000000000ac4 <iter>:
  }
}

void
iter()
{
     ac4:	7179                	addi	sp,sp,-48
     ac6:	f406                	sd	ra,40(sp)
     ac8:	f022                	sd	s0,32(sp)
     aca:	ec26                	sd	s1,24(sp)
     acc:	e84a                	sd	s2,16(sp)
     ace:	1800                	addi	s0,sp,48
  unlink("a");
     ad0:	00001517          	auipc	a0,0x1
     ad4:	bc050513          	addi	a0,a0,-1088 # 1690 <malloc+0x1ca>
     ad8:	00000097          	auipc	ra,0x0
     adc:	600080e7          	jalr	1536(ra) # 10d8 <unlink>
  unlink("b");
     ae0:	00001517          	auipc	a0,0x1
     ae4:	b6050513          	addi	a0,a0,-1184 # 1640 <malloc+0x17a>
     ae8:	00000097          	auipc	ra,0x0
     aec:	5f0080e7          	jalr	1520(ra) # 10d8 <unlink>
  
  int pid1 = fork();
     af0:	00000097          	auipc	ra,0x0
     af4:	590080e7          	jalr	1424(ra) # 1080 <fork>
  if(pid1 < 0){
     af8:	00054e63          	bltz	a0,b14 <iter+0x50>
     afc:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
     afe:	e905                	bnez	a0,b2e <iter+0x6a>
    rand_next = 31;
     b00:	47fd                	li	a5,31
     b02:	00001717          	auipc	a4,0x1
     b06:	daf73b23          	sd	a5,-586(a4) # 18b8 <rand_next>
    go(0);
     b0a:	4501                	li	a0,0
     b0c:	fffff097          	auipc	ra,0xfffff
     b10:	56c080e7          	jalr	1388(ra) # 78 <go>
    printf("grind: fork failed\n");
     b14:	00001517          	auipc	a0,0x1
     b18:	b9c50513          	addi	a0,a0,-1124 # 16b0 <malloc+0x1ea>
     b1c:	00001097          	auipc	ra,0x1
     b20:	8ec080e7          	jalr	-1812(ra) # 1408 <printf>
    exit(1);
     b24:	4505                	li	a0,1
     b26:	00000097          	auipc	ra,0x0
     b2a:	562080e7          	jalr	1378(ra) # 1088 <exit>
    exit(0);
  }

  int pid2 = fork();
     b2e:	00000097          	auipc	ra,0x0
     b32:	552080e7          	jalr	1362(ra) # 1080 <fork>
     b36:	892a                	mv	s2,a0
  if(pid2 < 0){
     b38:	00054f63          	bltz	a0,b56 <iter+0x92>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
     b3c:	e915                	bnez	a0,b70 <iter+0xac>
    rand_next = 7177;
     b3e:	6789                	lui	a5,0x2
     b40:	c0978793          	addi	a5,a5,-1015 # 1c09 <buf.0+0x341>
     b44:	00001717          	auipc	a4,0x1
     b48:	d6f73a23          	sd	a5,-652(a4) # 18b8 <rand_next>
    go(1);
     b4c:	4505                	li	a0,1
     b4e:	fffff097          	auipc	ra,0xfffff
     b52:	52a080e7          	jalr	1322(ra) # 78 <go>
    printf("grind: fork failed\n");
     b56:	00001517          	auipc	a0,0x1
     b5a:	b5a50513          	addi	a0,a0,-1190 # 16b0 <malloc+0x1ea>
     b5e:	00001097          	auipc	ra,0x1
     b62:	8aa080e7          	jalr	-1878(ra) # 1408 <printf>
    exit(1);
     b66:	4505                	li	a0,1
     b68:	00000097          	auipc	ra,0x0
     b6c:	520080e7          	jalr	1312(ra) # 1088 <exit>
    exit(0);
  }

  int st1 = -1;
     b70:	57fd                	li	a5,-1
     b72:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
     b76:	fdc40513          	addi	a0,s0,-36
     b7a:	00000097          	auipc	ra,0x0
     b7e:	516080e7          	jalr	1302(ra) # 1090 <wait>
  if(st1 != 0){
     b82:	fdc42783          	lw	a5,-36(s0)
     b86:	ef99                	bnez	a5,ba4 <iter+0xe0>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
     b88:	57fd                	li	a5,-1
     b8a:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
     b8e:	fd840513          	addi	a0,s0,-40
     b92:	00000097          	auipc	ra,0x0
     b96:	4fe080e7          	jalr	1278(ra) # 1090 <wait>

  exit(0);
     b9a:	4501                	li	a0,0
     b9c:	00000097          	auipc	ra,0x0
     ba0:	4ec080e7          	jalr	1260(ra) # 1088 <exit>
    kill(pid1);
     ba4:	8526                	mv	a0,s1
     ba6:	00000097          	auipc	ra,0x0
     baa:	512080e7          	jalr	1298(ra) # 10b8 <kill>
    kill(pid2);
     bae:	854a                	mv	a0,s2
     bb0:	00000097          	auipc	ra,0x0
     bb4:	508080e7          	jalr	1288(ra) # 10b8 <kill>
     bb8:	bfc1                	j	b88 <iter+0xc4>

0000000000000bba <main>:
}

int
main()
{
     bba:	1141                	addi	sp,sp,-16
     bbc:	e406                	sd	ra,8(sp)
     bbe:	e022                	sd	s0,0(sp)
     bc0:	0800                	addi	s0,sp,16
     bc2:	a811                	j	bd6 <main+0x1c>
  while(1){
    int pid = fork();
    if(pid == 0){
      iter();
     bc4:	00000097          	auipc	ra,0x0
     bc8:	f00080e7          	jalr	-256(ra) # ac4 <iter>
      exit(0);
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
     bcc:	4551                	li	a0,20
     bce:	00000097          	auipc	ra,0x0
     bd2:	54a080e7          	jalr	1354(ra) # 1118 <sleep>
    int pid = fork();
     bd6:	00000097          	auipc	ra,0x0
     bda:	4aa080e7          	jalr	1194(ra) # 1080 <fork>
    if(pid == 0){
     bde:	d17d                	beqz	a0,bc4 <main+0xa>
    if(pid > 0){
     be0:	fea056e3          	blez	a0,bcc <main+0x12>
      wait(0);
     be4:	4501                	li	a0,0
     be6:	00000097          	auipc	ra,0x0
     bea:	4aa080e7          	jalr	1194(ra) # 1090 <wait>
     bee:	bff9                	j	bcc <main+0x12>

0000000000000bf0 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
     bf0:	1141                	addi	sp,sp,-16
     bf2:	e422                	sd	s0,8(sp)
     bf4:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
     bf6:	0f50000f          	fence	iorw,ow
     bfa:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
     bfe:	6422                	ld	s0,8(sp)
     c00:	0141                	addi	sp,sp,16
     c02:	8082                	ret

0000000000000c04 <load>:

int load(uint64 *p) {
     c04:	1141                	addi	sp,sp,-16
     c06:	e422                	sd	s0,8(sp)
     c08:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
     c0a:	0ff0000f          	fence
     c0e:	6108                	ld	a0,0(a0)
     c10:	0ff0000f          	fence
}
     c14:	2501                	sext.w	a0,a0
     c16:	6422                	ld	s0,8(sp)
     c18:	0141                	addi	sp,sp,16
     c1a:	8082                	ret

0000000000000c1c <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
     c1c:	7179                	addi	sp,sp,-48
     c1e:	f406                	sd	ra,40(sp)
     c20:	f022                	sd	s0,32(sp)
     c22:	ec26                	sd	s1,24(sp)
     c24:	e84a                	sd	s2,16(sp)
     c26:	e44e                	sd	s3,8(sp)
     c28:	e052                	sd	s4,0(sp)
     c2a:	1800                	addi	s0,sp,48
     c2c:	8a2a                	mv	s4,a0
     c2e:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
     c30:	4785                	li	a5,1
     c32:	00001497          	auipc	s1,0x1
     c36:	08e48493          	addi	s1,s1,142 # 1cc0 <rings+0x10>
     c3a:	00001917          	auipc	s2,0x1
     c3e:	17690913          	addi	s2,s2,374 # 1db0 <__BSS_END__>
     c42:	04f59563          	bne	a1,a5,c8c <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
     c46:	00001497          	auipc	s1,0x1
     c4a:	07a4a483          	lw	s1,122(s1) # 1cc0 <rings+0x10>
     c4e:	c099                	beqz	s1,c54 <create_or_close_the_buffer_user+0x38>
     c50:	4481                	li	s1,0
     c52:	a899                	j	ca8 <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
     c54:	00001917          	auipc	s2,0x1
     c58:	05c90913          	addi	s2,s2,92 # 1cb0 <rings>
     c5c:	00093603          	ld	a2,0(s2)
     c60:	4585                	li	a1,1
     c62:	00000097          	auipc	ra,0x0
     c66:	4c6080e7          	jalr	1222(ra) # 1128 <ringbuf>
        rings[i].book->write_done = 0;
     c6a:	00893783          	ld	a5,8(s2)
     c6e:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
     c72:	00893783          	ld	a5,8(s2)
     c76:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
     c7a:	01092783          	lw	a5,16(s2)
     c7e:	2785                	addiw	a5,a5,1
     c80:	00f92823          	sw	a5,16(s2)
        break;
     c84:	a015                	j	ca8 <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
     c86:	04e1                	addi	s1,s1,24
     c88:	01248f63          	beq	s1,s2,ca6 <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
     c8c:	409c                	lw	a5,0(s1)
     c8e:	dfe5                	beqz	a5,c86 <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
     c90:	ff04b603          	ld	a2,-16(s1)
     c94:	85ce                	mv	a1,s3
     c96:	8552                	mv	a0,s4
     c98:	00000097          	auipc	ra,0x0
     c9c:	490080e7          	jalr	1168(ra) # 1128 <ringbuf>
        rings[i].exists = 0;
     ca0:	0004a023          	sw	zero,0(s1)
     ca4:	b7cd                	j	c86 <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
     ca6:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
     ca8:	8526                	mv	a0,s1
     caa:	70a2                	ld	ra,40(sp)
     cac:	7402                	ld	s0,32(sp)
     cae:	64e2                	ld	s1,24(sp)
     cb0:	6942                	ld	s2,16(sp)
     cb2:	69a2                	ld	s3,8(sp)
     cb4:	6a02                	ld	s4,0(sp)
     cb6:	6145                	addi	sp,sp,48
     cb8:	8082                	ret

0000000000000cba <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
     cba:	1101                	addi	sp,sp,-32
     cbc:	ec06                	sd	ra,24(sp)
     cbe:	e822                	sd	s0,16(sp)
     cc0:	e426                	sd	s1,8(sp)
     cc2:	1000                	addi	s0,sp,32
     cc4:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
     cc6:	00151793          	slli	a5,a0,0x1
     cca:	97aa                	add	a5,a5,a0
     ccc:	078e                	slli	a5,a5,0x3
     cce:	00001717          	auipc	a4,0x1
     cd2:	fe270713          	addi	a4,a4,-30 # 1cb0 <rings>
     cd6:	97ba                	add	a5,a5,a4
     cd8:	639c                	ld	a5,0(a5)
     cda:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
     cdc:	421c                	lw	a5,0(a2)
     cde:	e785                	bnez	a5,d06 <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
     ce0:	86ba                	mv	a3,a4
     ce2:	671c                	ld	a5,8(a4)
     ce4:	6398                	ld	a4,0(a5)
     ce6:	67c1                	lui	a5,0x10
     ce8:	9fb9                	addw	a5,a5,a4
     cea:	00151713          	slli	a4,a0,0x1
     cee:	953a                	add	a0,a0,a4
     cf0:	050e                	slli	a0,a0,0x3
     cf2:	9536                	add	a0,a0,a3
     cf4:	6518                	ld	a4,8(a0)
     cf6:	6718                	ld	a4,8(a4)
     cf8:	9f99                	subw	a5,a5,a4
     cfa:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
     cfc:	60e2                	ld	ra,24(sp)
     cfe:	6442                	ld	s0,16(sp)
     d00:	64a2                	ld	s1,8(sp)
     d02:	6105                	addi	sp,sp,32
     d04:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
     d06:	00151793          	slli	a5,a0,0x1
     d0a:	953e                	add	a0,a0,a5
     d0c:	050e                	slli	a0,a0,0x3
     d0e:	00001797          	auipc	a5,0x1
     d12:	fa278793          	addi	a5,a5,-94 # 1cb0 <rings>
     d16:	953e                	add	a0,a0,a5
     d18:	6508                	ld	a0,8(a0)
     d1a:	0521                	addi	a0,a0,8
     d1c:	00000097          	auipc	ra,0x0
     d20:	ee8080e7          	jalr	-280(ra) # c04 <load>
     d24:	c088                	sw	a0,0(s1)
}
     d26:	bfd9                	j	cfc <ringbuf_start_write+0x42>

0000000000000d28 <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
     d28:	1141                	addi	sp,sp,-16
     d2a:	e406                	sd	ra,8(sp)
     d2c:	e022                	sd	s0,0(sp)
     d2e:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
     d30:	00151793          	slli	a5,a0,0x1
     d34:	97aa                	add	a5,a5,a0
     d36:	078e                	slli	a5,a5,0x3
     d38:	00001517          	auipc	a0,0x1
     d3c:	f7850513          	addi	a0,a0,-136 # 1cb0 <rings>
     d40:	97aa                	add	a5,a5,a0
     d42:	6788                	ld	a0,8(a5)
     d44:	0035959b          	slliw	a1,a1,0x3
     d48:	0521                	addi	a0,a0,8
     d4a:	00000097          	auipc	ra,0x0
     d4e:	ea6080e7          	jalr	-346(ra) # bf0 <store>
}
     d52:	60a2                	ld	ra,8(sp)
     d54:	6402                	ld	s0,0(sp)
     d56:	0141                	addi	sp,sp,16
     d58:	8082                	ret

0000000000000d5a <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
     d5a:	1101                	addi	sp,sp,-32
     d5c:	ec06                	sd	ra,24(sp)
     d5e:	e822                	sd	s0,16(sp)
     d60:	e426                	sd	s1,8(sp)
     d62:	1000                	addi	s0,sp,32
     d64:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
     d66:	00151793          	slli	a5,a0,0x1
     d6a:	97aa                	add	a5,a5,a0
     d6c:	078e                	slli	a5,a5,0x3
     d6e:	00001517          	auipc	a0,0x1
     d72:	f4250513          	addi	a0,a0,-190 # 1cb0 <rings>
     d76:	97aa                	add	a5,a5,a0
     d78:	6788                	ld	a0,8(a5)
     d7a:	0521                	addi	a0,a0,8
     d7c:	00000097          	auipc	ra,0x0
     d80:	e88080e7          	jalr	-376(ra) # c04 <load>
     d84:	c088                	sw	a0,0(s1)
}
     d86:	60e2                	ld	ra,24(sp)
     d88:	6442                	ld	s0,16(sp)
     d8a:	64a2                	ld	s1,8(sp)
     d8c:	6105                	addi	sp,sp,32
     d8e:	8082                	ret

0000000000000d90 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
     d90:	1101                	addi	sp,sp,-32
     d92:	ec06                	sd	ra,24(sp)
     d94:	e822                	sd	s0,16(sp)
     d96:	e426                	sd	s1,8(sp)
     d98:	1000                	addi	s0,sp,32
     d9a:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
     d9c:	00151793          	slli	a5,a0,0x1
     da0:	97aa                	add	a5,a5,a0
     da2:	078e                	slli	a5,a5,0x3
     da4:	00001517          	auipc	a0,0x1
     da8:	f0c50513          	addi	a0,a0,-244 # 1cb0 <rings>
     dac:	97aa                	add	a5,a5,a0
     dae:	6788                	ld	a0,8(a5)
     db0:	611c                	ld	a5,0(a0)
     db2:	ef99                	bnez	a5,dd0 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
     db4:	6518                	ld	a4,8(a0)
    *bytes /= 8;
     db6:	41f7579b          	sraiw	a5,a4,0x1f
     dba:	01d7d79b          	srliw	a5,a5,0x1d
     dbe:	9fb9                	addw	a5,a5,a4
     dc0:	4037d79b          	sraiw	a5,a5,0x3
     dc4:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
     dc6:	60e2                	ld	ra,24(sp)
     dc8:	6442                	ld	s0,16(sp)
     dca:	64a2                	ld	s1,8(sp)
     dcc:	6105                	addi	sp,sp,32
     dce:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
     dd0:	00000097          	auipc	ra,0x0
     dd4:	e34080e7          	jalr	-460(ra) # c04 <load>
    *bytes /= 8;
     dd8:	41f5579b          	sraiw	a5,a0,0x1f
     ddc:	01d7d79b          	srliw	a5,a5,0x1d
     de0:	9d3d                	addw	a0,a0,a5
     de2:	4035551b          	sraiw	a0,a0,0x3
     de6:	c088                	sw	a0,0(s1)
}
     de8:	bff9                	j	dc6 <ringbuf_start_read+0x36>

0000000000000dea <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
     dea:	1141                	addi	sp,sp,-16
     dec:	e406                	sd	ra,8(sp)
     dee:	e022                	sd	s0,0(sp)
     df0:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
     df2:	00151793          	slli	a5,a0,0x1
     df6:	97aa                	add	a5,a5,a0
     df8:	078e                	slli	a5,a5,0x3
     dfa:	00001517          	auipc	a0,0x1
     dfe:	eb650513          	addi	a0,a0,-330 # 1cb0 <rings>
     e02:	97aa                	add	a5,a5,a0
     e04:	0035959b          	slliw	a1,a1,0x3
     e08:	6788                	ld	a0,8(a5)
     e0a:	00000097          	auipc	ra,0x0
     e0e:	de6080e7          	jalr	-538(ra) # bf0 <store>
}
     e12:	60a2                	ld	ra,8(sp)
     e14:	6402                	ld	s0,0(sp)
     e16:	0141                	addi	sp,sp,16
     e18:	8082                	ret

0000000000000e1a <strcpy>:



char*
strcpy(char *s, const char *t)
{
     e1a:	1141                	addi	sp,sp,-16
     e1c:	e422                	sd	s0,8(sp)
     e1e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e20:	87aa                	mv	a5,a0
     e22:	0585                	addi	a1,a1,1
     e24:	0785                	addi	a5,a5,1
     e26:	fff5c703          	lbu	a4,-1(a1)
     e2a:	fee78fa3          	sb	a4,-1(a5)
     e2e:	fb75                	bnez	a4,e22 <strcpy+0x8>
    ;
  return os;
}
     e30:	6422                	ld	s0,8(sp)
     e32:	0141                	addi	sp,sp,16
     e34:	8082                	ret

0000000000000e36 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e36:	1141                	addi	sp,sp,-16
     e38:	e422                	sd	s0,8(sp)
     e3a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     e3c:	00054783          	lbu	a5,0(a0)
     e40:	cb91                	beqz	a5,e54 <strcmp+0x1e>
     e42:	0005c703          	lbu	a4,0(a1)
     e46:	00f71763          	bne	a4,a5,e54 <strcmp+0x1e>
    p++, q++;
     e4a:	0505                	addi	a0,a0,1
     e4c:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     e4e:	00054783          	lbu	a5,0(a0)
     e52:	fbe5                	bnez	a5,e42 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     e54:	0005c503          	lbu	a0,0(a1)
}
     e58:	40a7853b          	subw	a0,a5,a0
     e5c:	6422                	ld	s0,8(sp)
     e5e:	0141                	addi	sp,sp,16
     e60:	8082                	ret

0000000000000e62 <strlen>:

uint
strlen(const char *s)
{
     e62:	1141                	addi	sp,sp,-16
     e64:	e422                	sd	s0,8(sp)
     e66:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     e68:	00054783          	lbu	a5,0(a0)
     e6c:	cf91                	beqz	a5,e88 <strlen+0x26>
     e6e:	0505                	addi	a0,a0,1
     e70:	87aa                	mv	a5,a0
     e72:	4685                	li	a3,1
     e74:	9e89                	subw	a3,a3,a0
     e76:	00f6853b          	addw	a0,a3,a5
     e7a:	0785                	addi	a5,a5,1
     e7c:	fff7c703          	lbu	a4,-1(a5)
     e80:	fb7d                	bnez	a4,e76 <strlen+0x14>
    ;
  return n;
}
     e82:	6422                	ld	s0,8(sp)
     e84:	0141                	addi	sp,sp,16
     e86:	8082                	ret
  for(n = 0; s[n]; n++)
     e88:	4501                	li	a0,0
     e8a:	bfe5                	j	e82 <strlen+0x20>

0000000000000e8c <memset>:

void*
memset(void *dst, int c, uint n)
{
     e8c:	1141                	addi	sp,sp,-16
     e8e:	e422                	sd	s0,8(sp)
     e90:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     e92:	ca19                	beqz	a2,ea8 <memset+0x1c>
     e94:	87aa                	mv	a5,a0
     e96:	1602                	slli	a2,a2,0x20
     e98:	9201                	srli	a2,a2,0x20
     e9a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     e9e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     ea2:	0785                	addi	a5,a5,1
     ea4:	fee79de3          	bne	a5,a4,e9e <memset+0x12>
  }
  return dst;
}
     ea8:	6422                	ld	s0,8(sp)
     eaa:	0141                	addi	sp,sp,16
     eac:	8082                	ret

0000000000000eae <strchr>:

char*
strchr(const char *s, char c)
{
     eae:	1141                	addi	sp,sp,-16
     eb0:	e422                	sd	s0,8(sp)
     eb2:	0800                	addi	s0,sp,16
  for(; *s; s++)
     eb4:	00054783          	lbu	a5,0(a0)
     eb8:	cb99                	beqz	a5,ece <strchr+0x20>
    if(*s == c)
     eba:	00f58763          	beq	a1,a5,ec8 <strchr+0x1a>
  for(; *s; s++)
     ebe:	0505                	addi	a0,a0,1
     ec0:	00054783          	lbu	a5,0(a0)
     ec4:	fbfd                	bnez	a5,eba <strchr+0xc>
      return (char*)s;
  return 0;
     ec6:	4501                	li	a0,0
}
     ec8:	6422                	ld	s0,8(sp)
     eca:	0141                	addi	sp,sp,16
     ecc:	8082                	ret
  return 0;
     ece:	4501                	li	a0,0
     ed0:	bfe5                	j	ec8 <strchr+0x1a>

0000000000000ed2 <gets>:

char*
gets(char *buf, int max)
{
     ed2:	711d                	addi	sp,sp,-96
     ed4:	ec86                	sd	ra,88(sp)
     ed6:	e8a2                	sd	s0,80(sp)
     ed8:	e4a6                	sd	s1,72(sp)
     eda:	e0ca                	sd	s2,64(sp)
     edc:	fc4e                	sd	s3,56(sp)
     ede:	f852                	sd	s4,48(sp)
     ee0:	f456                	sd	s5,40(sp)
     ee2:	f05a                	sd	s6,32(sp)
     ee4:	ec5e                	sd	s7,24(sp)
     ee6:	1080                	addi	s0,sp,96
     ee8:	8baa                	mv	s7,a0
     eea:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     eec:	892a                	mv	s2,a0
     eee:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     ef0:	4aa9                	li	s5,10
     ef2:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     ef4:	89a6                	mv	s3,s1
     ef6:	2485                	addiw	s1,s1,1
     ef8:	0344d863          	bge	s1,s4,f28 <gets+0x56>
    cc = read(0, &c, 1);
     efc:	4605                	li	a2,1
     efe:	faf40593          	addi	a1,s0,-81
     f02:	4501                	li	a0,0
     f04:	00000097          	auipc	ra,0x0
     f08:	19c080e7          	jalr	412(ra) # 10a0 <read>
    if(cc < 1)
     f0c:	00a05e63          	blez	a0,f28 <gets+0x56>
    buf[i++] = c;
     f10:	faf44783          	lbu	a5,-81(s0)
     f14:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     f18:	01578763          	beq	a5,s5,f26 <gets+0x54>
     f1c:	0905                	addi	s2,s2,1
     f1e:	fd679be3          	bne	a5,s6,ef4 <gets+0x22>
  for(i=0; i+1 < max; ){
     f22:	89a6                	mv	s3,s1
     f24:	a011                	j	f28 <gets+0x56>
     f26:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     f28:	99de                	add	s3,s3,s7
     f2a:	00098023          	sb	zero,0(s3)
  return buf;
}
     f2e:	855e                	mv	a0,s7
     f30:	60e6                	ld	ra,88(sp)
     f32:	6446                	ld	s0,80(sp)
     f34:	64a6                	ld	s1,72(sp)
     f36:	6906                	ld	s2,64(sp)
     f38:	79e2                	ld	s3,56(sp)
     f3a:	7a42                	ld	s4,48(sp)
     f3c:	7aa2                	ld	s5,40(sp)
     f3e:	7b02                	ld	s6,32(sp)
     f40:	6be2                	ld	s7,24(sp)
     f42:	6125                	addi	sp,sp,96
     f44:	8082                	ret

0000000000000f46 <stat>:

int
stat(const char *n, struct stat *st)
{
     f46:	1101                	addi	sp,sp,-32
     f48:	ec06                	sd	ra,24(sp)
     f4a:	e822                	sd	s0,16(sp)
     f4c:	e426                	sd	s1,8(sp)
     f4e:	e04a                	sd	s2,0(sp)
     f50:	1000                	addi	s0,sp,32
     f52:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     f54:	4581                	li	a1,0
     f56:	00000097          	auipc	ra,0x0
     f5a:	172080e7          	jalr	370(ra) # 10c8 <open>
  if(fd < 0)
     f5e:	02054563          	bltz	a0,f88 <stat+0x42>
     f62:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     f64:	85ca                	mv	a1,s2
     f66:	00000097          	auipc	ra,0x0
     f6a:	17a080e7          	jalr	378(ra) # 10e0 <fstat>
     f6e:	892a                	mv	s2,a0
  close(fd);
     f70:	8526                	mv	a0,s1
     f72:	00000097          	auipc	ra,0x0
     f76:	13e080e7          	jalr	318(ra) # 10b0 <close>
  return r;
}
     f7a:	854a                	mv	a0,s2
     f7c:	60e2                	ld	ra,24(sp)
     f7e:	6442                	ld	s0,16(sp)
     f80:	64a2                	ld	s1,8(sp)
     f82:	6902                	ld	s2,0(sp)
     f84:	6105                	addi	sp,sp,32
     f86:	8082                	ret
    return -1;
     f88:	597d                	li	s2,-1
     f8a:	bfc5                	j	f7a <stat+0x34>

0000000000000f8c <atoi>:

int
atoi(const char *s)
{
     f8c:	1141                	addi	sp,sp,-16
     f8e:	e422                	sd	s0,8(sp)
     f90:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     f92:	00054603          	lbu	a2,0(a0)
     f96:	fd06079b          	addiw	a5,a2,-48
     f9a:	0ff7f793          	zext.b	a5,a5
     f9e:	4725                	li	a4,9
     fa0:	02f76963          	bltu	a4,a5,fd2 <atoi+0x46>
     fa4:	86aa                	mv	a3,a0
  n = 0;
     fa6:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     fa8:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     faa:	0685                	addi	a3,a3,1
     fac:	0025179b          	slliw	a5,a0,0x2
     fb0:	9fa9                	addw	a5,a5,a0
     fb2:	0017979b          	slliw	a5,a5,0x1
     fb6:	9fb1                	addw	a5,a5,a2
     fb8:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     fbc:	0006c603          	lbu	a2,0(a3)
     fc0:	fd06071b          	addiw	a4,a2,-48
     fc4:	0ff77713          	zext.b	a4,a4
     fc8:	fee5f1e3          	bgeu	a1,a4,faa <atoi+0x1e>
  return n;
}
     fcc:	6422                	ld	s0,8(sp)
     fce:	0141                	addi	sp,sp,16
     fd0:	8082                	ret
  n = 0;
     fd2:	4501                	li	a0,0
     fd4:	bfe5                	j	fcc <atoi+0x40>

0000000000000fd6 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     fd6:	1141                	addi	sp,sp,-16
     fd8:	e422                	sd	s0,8(sp)
     fda:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     fdc:	02b57463          	bgeu	a0,a1,1004 <memmove+0x2e>
    while(n-- > 0)
     fe0:	00c05f63          	blez	a2,ffe <memmove+0x28>
     fe4:	1602                	slli	a2,a2,0x20
     fe6:	9201                	srli	a2,a2,0x20
     fe8:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     fec:	872a                	mv	a4,a0
      *dst++ = *src++;
     fee:	0585                	addi	a1,a1,1
     ff0:	0705                	addi	a4,a4,1
     ff2:	fff5c683          	lbu	a3,-1(a1)
     ff6:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     ffa:	fee79ae3          	bne	a5,a4,fee <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     ffe:	6422                	ld	s0,8(sp)
    1000:	0141                	addi	sp,sp,16
    1002:	8082                	ret
    dst += n;
    1004:	00c50733          	add	a4,a0,a2
    src += n;
    1008:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    100a:	fec05ae3          	blez	a2,ffe <memmove+0x28>
    100e:	fff6079b          	addiw	a5,a2,-1
    1012:	1782                	slli	a5,a5,0x20
    1014:	9381                	srli	a5,a5,0x20
    1016:	fff7c793          	not	a5,a5
    101a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    101c:	15fd                	addi	a1,a1,-1
    101e:	177d                	addi	a4,a4,-1
    1020:	0005c683          	lbu	a3,0(a1)
    1024:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    1028:	fee79ae3          	bne	a5,a4,101c <memmove+0x46>
    102c:	bfc9                	j	ffe <memmove+0x28>

000000000000102e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    102e:	1141                	addi	sp,sp,-16
    1030:	e422                	sd	s0,8(sp)
    1032:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    1034:	ca05                	beqz	a2,1064 <memcmp+0x36>
    1036:	fff6069b          	addiw	a3,a2,-1
    103a:	1682                	slli	a3,a3,0x20
    103c:	9281                	srli	a3,a3,0x20
    103e:	0685                	addi	a3,a3,1
    1040:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    1042:	00054783          	lbu	a5,0(a0)
    1046:	0005c703          	lbu	a4,0(a1)
    104a:	00e79863          	bne	a5,a4,105a <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    104e:	0505                	addi	a0,a0,1
    p2++;
    1050:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    1052:	fed518e3          	bne	a0,a3,1042 <memcmp+0x14>
  }
  return 0;
    1056:	4501                	li	a0,0
    1058:	a019                	j	105e <memcmp+0x30>
      return *p1 - *p2;
    105a:	40e7853b          	subw	a0,a5,a4
}
    105e:	6422                	ld	s0,8(sp)
    1060:	0141                	addi	sp,sp,16
    1062:	8082                	ret
  return 0;
    1064:	4501                	li	a0,0
    1066:	bfe5                	j	105e <memcmp+0x30>

0000000000001068 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    1068:	1141                	addi	sp,sp,-16
    106a:	e406                	sd	ra,8(sp)
    106c:	e022                	sd	s0,0(sp)
    106e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    1070:	00000097          	auipc	ra,0x0
    1074:	f66080e7          	jalr	-154(ra) # fd6 <memmove>
}
    1078:	60a2                	ld	ra,8(sp)
    107a:	6402                	ld	s0,0(sp)
    107c:	0141                	addi	sp,sp,16
    107e:	8082                	ret

0000000000001080 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    1080:	4885                	li	a7,1
 ecall
    1082:	00000073          	ecall
 ret
    1086:	8082                	ret

0000000000001088 <exit>:
.global exit
exit:
 li a7, SYS_exit
    1088:	4889                	li	a7,2
 ecall
    108a:	00000073          	ecall
 ret
    108e:	8082                	ret

0000000000001090 <wait>:
.global wait
wait:
 li a7, SYS_wait
    1090:	488d                	li	a7,3
 ecall
    1092:	00000073          	ecall
 ret
    1096:	8082                	ret

0000000000001098 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    1098:	4891                	li	a7,4
 ecall
    109a:	00000073          	ecall
 ret
    109e:	8082                	ret

00000000000010a0 <read>:
.global read
read:
 li a7, SYS_read
    10a0:	4895                	li	a7,5
 ecall
    10a2:	00000073          	ecall
 ret
    10a6:	8082                	ret

00000000000010a8 <write>:
.global write
write:
 li a7, SYS_write
    10a8:	48c1                	li	a7,16
 ecall
    10aa:	00000073          	ecall
 ret
    10ae:	8082                	ret

00000000000010b0 <close>:
.global close
close:
 li a7, SYS_close
    10b0:	48d5                	li	a7,21
 ecall
    10b2:	00000073          	ecall
 ret
    10b6:	8082                	ret

00000000000010b8 <kill>:
.global kill
kill:
 li a7, SYS_kill
    10b8:	4899                	li	a7,6
 ecall
    10ba:	00000073          	ecall
 ret
    10be:	8082                	ret

00000000000010c0 <exec>:
.global exec
exec:
 li a7, SYS_exec
    10c0:	489d                	li	a7,7
 ecall
    10c2:	00000073          	ecall
 ret
    10c6:	8082                	ret

00000000000010c8 <open>:
.global open
open:
 li a7, SYS_open
    10c8:	48bd                	li	a7,15
 ecall
    10ca:	00000073          	ecall
 ret
    10ce:	8082                	ret

00000000000010d0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    10d0:	48c5                	li	a7,17
 ecall
    10d2:	00000073          	ecall
 ret
    10d6:	8082                	ret

00000000000010d8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    10d8:	48c9                	li	a7,18
 ecall
    10da:	00000073          	ecall
 ret
    10de:	8082                	ret

00000000000010e0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    10e0:	48a1                	li	a7,8
 ecall
    10e2:	00000073          	ecall
 ret
    10e6:	8082                	ret

00000000000010e8 <link>:
.global link
link:
 li a7, SYS_link
    10e8:	48cd                	li	a7,19
 ecall
    10ea:	00000073          	ecall
 ret
    10ee:	8082                	ret

00000000000010f0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    10f0:	48d1                	li	a7,20
 ecall
    10f2:	00000073          	ecall
 ret
    10f6:	8082                	ret

00000000000010f8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    10f8:	48a5                	li	a7,9
 ecall
    10fa:	00000073          	ecall
 ret
    10fe:	8082                	ret

0000000000001100 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1100:	48a9                	li	a7,10
 ecall
    1102:	00000073          	ecall
 ret
    1106:	8082                	ret

0000000000001108 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    1108:	48ad                	li	a7,11
 ecall
    110a:	00000073          	ecall
 ret
    110e:	8082                	ret

0000000000001110 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1110:	48b1                	li	a7,12
 ecall
    1112:	00000073          	ecall
 ret
    1116:	8082                	ret

0000000000001118 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    1118:	48b5                	li	a7,13
 ecall
    111a:	00000073          	ecall
 ret
    111e:	8082                	ret

0000000000001120 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1120:	48b9                	li	a7,14
 ecall
    1122:	00000073          	ecall
 ret
    1126:	8082                	ret

0000000000001128 <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
    1128:	48d9                	li	a7,22
 ecall
    112a:	00000073          	ecall
 ret
    112e:	8082                	ret

0000000000001130 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1130:	1101                	addi	sp,sp,-32
    1132:	ec06                	sd	ra,24(sp)
    1134:	e822                	sd	s0,16(sp)
    1136:	1000                	addi	s0,sp,32
    1138:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    113c:	4605                	li	a2,1
    113e:	fef40593          	addi	a1,s0,-17
    1142:	00000097          	auipc	ra,0x0
    1146:	f66080e7          	jalr	-154(ra) # 10a8 <write>
}
    114a:	60e2                	ld	ra,24(sp)
    114c:	6442                	ld	s0,16(sp)
    114e:	6105                	addi	sp,sp,32
    1150:	8082                	ret

0000000000001152 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1152:	7139                	addi	sp,sp,-64
    1154:	fc06                	sd	ra,56(sp)
    1156:	f822                	sd	s0,48(sp)
    1158:	f426                	sd	s1,40(sp)
    115a:	f04a                	sd	s2,32(sp)
    115c:	ec4e                	sd	s3,24(sp)
    115e:	0080                	addi	s0,sp,64
    1160:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1162:	c299                	beqz	a3,1168 <printint+0x16>
    1164:	0805c863          	bltz	a1,11f4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    1168:	2581                	sext.w	a1,a1
  neg = 0;
    116a:	4881                	li	a7,0
    116c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    1170:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    1172:	2601                	sext.w	a2,a2
    1174:	00000517          	auipc	a0,0x0
    1178:	72c50513          	addi	a0,a0,1836 # 18a0 <digits>
    117c:	883a                	mv	a6,a4
    117e:	2705                	addiw	a4,a4,1
    1180:	02c5f7bb          	remuw	a5,a1,a2
    1184:	1782                	slli	a5,a5,0x20
    1186:	9381                	srli	a5,a5,0x20
    1188:	97aa                	add	a5,a5,a0
    118a:	0007c783          	lbu	a5,0(a5)
    118e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    1192:	0005879b          	sext.w	a5,a1
    1196:	02c5d5bb          	divuw	a1,a1,a2
    119a:	0685                	addi	a3,a3,1
    119c:	fec7f0e3          	bgeu	a5,a2,117c <printint+0x2a>
  if(neg)
    11a0:	00088b63          	beqz	a7,11b6 <printint+0x64>
    buf[i++] = '-';
    11a4:	fd040793          	addi	a5,s0,-48
    11a8:	973e                	add	a4,a4,a5
    11aa:	02d00793          	li	a5,45
    11ae:	fef70823          	sb	a5,-16(a4)
    11b2:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    11b6:	02e05863          	blez	a4,11e6 <printint+0x94>
    11ba:	fc040793          	addi	a5,s0,-64
    11be:	00e78933          	add	s2,a5,a4
    11c2:	fff78993          	addi	s3,a5,-1
    11c6:	99ba                	add	s3,s3,a4
    11c8:	377d                	addiw	a4,a4,-1
    11ca:	1702                	slli	a4,a4,0x20
    11cc:	9301                	srli	a4,a4,0x20
    11ce:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    11d2:	fff94583          	lbu	a1,-1(s2)
    11d6:	8526                	mv	a0,s1
    11d8:	00000097          	auipc	ra,0x0
    11dc:	f58080e7          	jalr	-168(ra) # 1130 <putc>
  while(--i >= 0)
    11e0:	197d                	addi	s2,s2,-1
    11e2:	ff3918e3          	bne	s2,s3,11d2 <printint+0x80>
}
    11e6:	70e2                	ld	ra,56(sp)
    11e8:	7442                	ld	s0,48(sp)
    11ea:	74a2                	ld	s1,40(sp)
    11ec:	7902                	ld	s2,32(sp)
    11ee:	69e2                	ld	s3,24(sp)
    11f0:	6121                	addi	sp,sp,64
    11f2:	8082                	ret
    x = -xx;
    11f4:	40b005bb          	negw	a1,a1
    neg = 1;
    11f8:	4885                	li	a7,1
    x = -xx;
    11fa:	bf8d                	j	116c <printint+0x1a>

00000000000011fc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    11fc:	7119                	addi	sp,sp,-128
    11fe:	fc86                	sd	ra,120(sp)
    1200:	f8a2                	sd	s0,112(sp)
    1202:	f4a6                	sd	s1,104(sp)
    1204:	f0ca                	sd	s2,96(sp)
    1206:	ecce                	sd	s3,88(sp)
    1208:	e8d2                	sd	s4,80(sp)
    120a:	e4d6                	sd	s5,72(sp)
    120c:	e0da                	sd	s6,64(sp)
    120e:	fc5e                	sd	s7,56(sp)
    1210:	f862                	sd	s8,48(sp)
    1212:	f466                	sd	s9,40(sp)
    1214:	f06a                	sd	s10,32(sp)
    1216:	ec6e                	sd	s11,24(sp)
    1218:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    121a:	0005c903          	lbu	s2,0(a1)
    121e:	18090f63          	beqz	s2,13bc <vprintf+0x1c0>
    1222:	8aaa                	mv	s5,a0
    1224:	8b32                	mv	s6,a2
    1226:	00158493          	addi	s1,a1,1
  state = 0;
    122a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    122c:	02500a13          	li	s4,37
      if(c == 'd'){
    1230:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    1234:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    1238:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    123c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1240:	00000b97          	auipc	s7,0x0
    1244:	660b8b93          	addi	s7,s7,1632 # 18a0 <digits>
    1248:	a839                	j	1266 <vprintf+0x6a>
        putc(fd, c);
    124a:	85ca                	mv	a1,s2
    124c:	8556                	mv	a0,s5
    124e:	00000097          	auipc	ra,0x0
    1252:	ee2080e7          	jalr	-286(ra) # 1130 <putc>
    1256:	a019                	j	125c <vprintf+0x60>
    } else if(state == '%'){
    1258:	01498f63          	beq	s3,s4,1276 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    125c:	0485                	addi	s1,s1,1
    125e:	fff4c903          	lbu	s2,-1(s1)
    1262:	14090d63          	beqz	s2,13bc <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    1266:	0009079b          	sext.w	a5,s2
    if(state == 0){
    126a:	fe0997e3          	bnez	s3,1258 <vprintf+0x5c>
      if(c == '%'){
    126e:	fd479ee3          	bne	a5,s4,124a <vprintf+0x4e>
        state = '%';
    1272:	89be                	mv	s3,a5
    1274:	b7e5                	j	125c <vprintf+0x60>
      if(c == 'd'){
    1276:	05878063          	beq	a5,s8,12b6 <vprintf+0xba>
      } else if(c == 'l') {
    127a:	05978c63          	beq	a5,s9,12d2 <vprintf+0xd6>
      } else if(c == 'x') {
    127e:	07a78863          	beq	a5,s10,12ee <vprintf+0xf2>
      } else if(c == 'p') {
    1282:	09b78463          	beq	a5,s11,130a <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    1286:	07300713          	li	a4,115
    128a:	0ce78663          	beq	a5,a4,1356 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    128e:	06300713          	li	a4,99
    1292:	0ee78e63          	beq	a5,a4,138e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    1296:	11478863          	beq	a5,s4,13a6 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    129a:	85d2                	mv	a1,s4
    129c:	8556                	mv	a0,s5
    129e:	00000097          	auipc	ra,0x0
    12a2:	e92080e7          	jalr	-366(ra) # 1130 <putc>
        putc(fd, c);
    12a6:	85ca                	mv	a1,s2
    12a8:	8556                	mv	a0,s5
    12aa:	00000097          	auipc	ra,0x0
    12ae:	e86080e7          	jalr	-378(ra) # 1130 <putc>
      }
      state = 0;
    12b2:	4981                	li	s3,0
    12b4:	b765                	j	125c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    12b6:	008b0913          	addi	s2,s6,8
    12ba:	4685                	li	a3,1
    12bc:	4629                	li	a2,10
    12be:	000b2583          	lw	a1,0(s6)
    12c2:	8556                	mv	a0,s5
    12c4:	00000097          	auipc	ra,0x0
    12c8:	e8e080e7          	jalr	-370(ra) # 1152 <printint>
    12cc:	8b4a                	mv	s6,s2
      state = 0;
    12ce:	4981                	li	s3,0
    12d0:	b771                	j	125c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    12d2:	008b0913          	addi	s2,s6,8
    12d6:	4681                	li	a3,0
    12d8:	4629                	li	a2,10
    12da:	000b2583          	lw	a1,0(s6)
    12de:	8556                	mv	a0,s5
    12e0:	00000097          	auipc	ra,0x0
    12e4:	e72080e7          	jalr	-398(ra) # 1152 <printint>
    12e8:	8b4a                	mv	s6,s2
      state = 0;
    12ea:	4981                	li	s3,0
    12ec:	bf85                	j	125c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    12ee:	008b0913          	addi	s2,s6,8
    12f2:	4681                	li	a3,0
    12f4:	4641                	li	a2,16
    12f6:	000b2583          	lw	a1,0(s6)
    12fa:	8556                	mv	a0,s5
    12fc:	00000097          	auipc	ra,0x0
    1300:	e56080e7          	jalr	-426(ra) # 1152 <printint>
    1304:	8b4a                	mv	s6,s2
      state = 0;
    1306:	4981                	li	s3,0
    1308:	bf91                	j	125c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    130a:	008b0793          	addi	a5,s6,8
    130e:	f8f43423          	sd	a5,-120(s0)
    1312:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    1316:	03000593          	li	a1,48
    131a:	8556                	mv	a0,s5
    131c:	00000097          	auipc	ra,0x0
    1320:	e14080e7          	jalr	-492(ra) # 1130 <putc>
  putc(fd, 'x');
    1324:	85ea                	mv	a1,s10
    1326:	8556                	mv	a0,s5
    1328:	00000097          	auipc	ra,0x0
    132c:	e08080e7          	jalr	-504(ra) # 1130 <putc>
    1330:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1332:	03c9d793          	srli	a5,s3,0x3c
    1336:	97de                	add	a5,a5,s7
    1338:	0007c583          	lbu	a1,0(a5)
    133c:	8556                	mv	a0,s5
    133e:	00000097          	auipc	ra,0x0
    1342:	df2080e7          	jalr	-526(ra) # 1130 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    1346:	0992                	slli	s3,s3,0x4
    1348:	397d                	addiw	s2,s2,-1
    134a:	fe0914e3          	bnez	s2,1332 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    134e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    1352:	4981                	li	s3,0
    1354:	b721                	j	125c <vprintf+0x60>
        s = va_arg(ap, char*);
    1356:	008b0993          	addi	s3,s6,8
    135a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    135e:	02090163          	beqz	s2,1380 <vprintf+0x184>
        while(*s != 0){
    1362:	00094583          	lbu	a1,0(s2)
    1366:	c9a1                	beqz	a1,13b6 <vprintf+0x1ba>
          putc(fd, *s);
    1368:	8556                	mv	a0,s5
    136a:	00000097          	auipc	ra,0x0
    136e:	dc6080e7          	jalr	-570(ra) # 1130 <putc>
          s++;
    1372:	0905                	addi	s2,s2,1
        while(*s != 0){
    1374:	00094583          	lbu	a1,0(s2)
    1378:	f9e5                	bnez	a1,1368 <vprintf+0x16c>
        s = va_arg(ap, char*);
    137a:	8b4e                	mv	s6,s3
      state = 0;
    137c:	4981                	li	s3,0
    137e:	bdf9                	j	125c <vprintf+0x60>
          s = "(null)";
    1380:	00000917          	auipc	s2,0x0
    1384:	51890913          	addi	s2,s2,1304 # 1898 <malloc+0x3d2>
        while(*s != 0){
    1388:	02800593          	li	a1,40
    138c:	bff1                	j	1368 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    138e:	008b0913          	addi	s2,s6,8
    1392:	000b4583          	lbu	a1,0(s6)
    1396:	8556                	mv	a0,s5
    1398:	00000097          	auipc	ra,0x0
    139c:	d98080e7          	jalr	-616(ra) # 1130 <putc>
    13a0:	8b4a                	mv	s6,s2
      state = 0;
    13a2:	4981                	li	s3,0
    13a4:	bd65                	j	125c <vprintf+0x60>
        putc(fd, c);
    13a6:	85d2                	mv	a1,s4
    13a8:	8556                	mv	a0,s5
    13aa:	00000097          	auipc	ra,0x0
    13ae:	d86080e7          	jalr	-634(ra) # 1130 <putc>
      state = 0;
    13b2:	4981                	li	s3,0
    13b4:	b565                	j	125c <vprintf+0x60>
        s = va_arg(ap, char*);
    13b6:	8b4e                	mv	s6,s3
      state = 0;
    13b8:	4981                	li	s3,0
    13ba:	b54d                	j	125c <vprintf+0x60>
    }
  }
}
    13bc:	70e6                	ld	ra,120(sp)
    13be:	7446                	ld	s0,112(sp)
    13c0:	74a6                	ld	s1,104(sp)
    13c2:	7906                	ld	s2,96(sp)
    13c4:	69e6                	ld	s3,88(sp)
    13c6:	6a46                	ld	s4,80(sp)
    13c8:	6aa6                	ld	s5,72(sp)
    13ca:	6b06                	ld	s6,64(sp)
    13cc:	7be2                	ld	s7,56(sp)
    13ce:	7c42                	ld	s8,48(sp)
    13d0:	7ca2                	ld	s9,40(sp)
    13d2:	7d02                	ld	s10,32(sp)
    13d4:	6de2                	ld	s11,24(sp)
    13d6:	6109                	addi	sp,sp,128
    13d8:	8082                	ret

00000000000013da <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    13da:	715d                	addi	sp,sp,-80
    13dc:	ec06                	sd	ra,24(sp)
    13de:	e822                	sd	s0,16(sp)
    13e0:	1000                	addi	s0,sp,32
    13e2:	e010                	sd	a2,0(s0)
    13e4:	e414                	sd	a3,8(s0)
    13e6:	e818                	sd	a4,16(s0)
    13e8:	ec1c                	sd	a5,24(s0)
    13ea:	03043023          	sd	a6,32(s0)
    13ee:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    13f2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    13f6:	8622                	mv	a2,s0
    13f8:	00000097          	auipc	ra,0x0
    13fc:	e04080e7          	jalr	-508(ra) # 11fc <vprintf>
}
    1400:	60e2                	ld	ra,24(sp)
    1402:	6442                	ld	s0,16(sp)
    1404:	6161                	addi	sp,sp,80
    1406:	8082                	ret

0000000000001408 <printf>:

void
printf(const char *fmt, ...)
{
    1408:	711d                	addi	sp,sp,-96
    140a:	ec06                	sd	ra,24(sp)
    140c:	e822                	sd	s0,16(sp)
    140e:	1000                	addi	s0,sp,32
    1410:	e40c                	sd	a1,8(s0)
    1412:	e810                	sd	a2,16(s0)
    1414:	ec14                	sd	a3,24(s0)
    1416:	f018                	sd	a4,32(s0)
    1418:	f41c                	sd	a5,40(s0)
    141a:	03043823          	sd	a6,48(s0)
    141e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1422:	00840613          	addi	a2,s0,8
    1426:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    142a:	85aa                	mv	a1,a0
    142c:	4505                	li	a0,1
    142e:	00000097          	auipc	ra,0x0
    1432:	dce080e7          	jalr	-562(ra) # 11fc <vprintf>
}
    1436:	60e2                	ld	ra,24(sp)
    1438:	6442                	ld	s0,16(sp)
    143a:	6125                	addi	sp,sp,96
    143c:	8082                	ret

000000000000143e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    143e:	1141                	addi	sp,sp,-16
    1440:	e422                	sd	s0,8(sp)
    1442:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    1444:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1448:	00000797          	auipc	a5,0x0
    144c:	4787b783          	ld	a5,1144(a5) # 18c0 <freep>
    1450:	a805                	j	1480 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1452:	4618                	lw	a4,8(a2)
    1454:	9db9                	addw	a1,a1,a4
    1456:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    145a:	6398                	ld	a4,0(a5)
    145c:	6318                	ld	a4,0(a4)
    145e:	fee53823          	sd	a4,-16(a0)
    1462:	a091                	j	14a6 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    1464:	ff852703          	lw	a4,-8(a0)
    1468:	9e39                	addw	a2,a2,a4
    146a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    146c:	ff053703          	ld	a4,-16(a0)
    1470:	e398                	sd	a4,0(a5)
    1472:	a099                	j	14b8 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1474:	6398                	ld	a4,0(a5)
    1476:	00e7e463          	bltu	a5,a4,147e <free+0x40>
    147a:	00e6ea63          	bltu	a3,a4,148e <free+0x50>
{
    147e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1480:	fed7fae3          	bgeu	a5,a3,1474 <free+0x36>
    1484:	6398                	ld	a4,0(a5)
    1486:	00e6e463          	bltu	a3,a4,148e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    148a:	fee7eae3          	bltu	a5,a4,147e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    148e:	ff852583          	lw	a1,-8(a0)
    1492:	6390                	ld	a2,0(a5)
    1494:	02059813          	slli	a6,a1,0x20
    1498:	01c85713          	srli	a4,a6,0x1c
    149c:	9736                	add	a4,a4,a3
    149e:	fae60ae3          	beq	a2,a4,1452 <free+0x14>
    bp->s.ptr = p->s.ptr;
    14a2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    14a6:	4790                	lw	a2,8(a5)
    14a8:	02061593          	slli	a1,a2,0x20
    14ac:	01c5d713          	srli	a4,a1,0x1c
    14b0:	973e                	add	a4,a4,a5
    14b2:	fae689e3          	beq	a3,a4,1464 <free+0x26>
  } else
    p->s.ptr = bp;
    14b6:	e394                	sd	a3,0(a5)
  freep = p;
    14b8:	00000717          	auipc	a4,0x0
    14bc:	40f73423          	sd	a5,1032(a4) # 18c0 <freep>
}
    14c0:	6422                	ld	s0,8(sp)
    14c2:	0141                	addi	sp,sp,16
    14c4:	8082                	ret

00000000000014c6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    14c6:	7139                	addi	sp,sp,-64
    14c8:	fc06                	sd	ra,56(sp)
    14ca:	f822                	sd	s0,48(sp)
    14cc:	f426                	sd	s1,40(sp)
    14ce:	f04a                	sd	s2,32(sp)
    14d0:	ec4e                	sd	s3,24(sp)
    14d2:	e852                	sd	s4,16(sp)
    14d4:	e456                	sd	s5,8(sp)
    14d6:	e05a                	sd	s6,0(sp)
    14d8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14da:	02051493          	slli	s1,a0,0x20
    14de:	9081                	srli	s1,s1,0x20
    14e0:	04bd                	addi	s1,s1,15
    14e2:	8091                	srli	s1,s1,0x4
    14e4:	0014899b          	addiw	s3,s1,1
    14e8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    14ea:	00000517          	auipc	a0,0x0
    14ee:	3d653503          	ld	a0,982(a0) # 18c0 <freep>
    14f2:	c515                	beqz	a0,151e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14f4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    14f6:	4798                	lw	a4,8(a5)
    14f8:	02977f63          	bgeu	a4,s1,1536 <malloc+0x70>
    14fc:	8a4e                	mv	s4,s3
    14fe:	0009871b          	sext.w	a4,s3
    1502:	6685                	lui	a3,0x1
    1504:	00d77363          	bgeu	a4,a3,150a <malloc+0x44>
    1508:	6a05                	lui	s4,0x1
    150a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    150e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1512:	00000917          	auipc	s2,0x0
    1516:	3ae90913          	addi	s2,s2,942 # 18c0 <freep>
  if(p == (char*)-1)
    151a:	5afd                	li	s5,-1
    151c:	a895                	j	1590 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    151e:	00001797          	auipc	a5,0x1
    1522:	88278793          	addi	a5,a5,-1918 # 1da0 <base>
    1526:	00000717          	auipc	a4,0x0
    152a:	38f73d23          	sd	a5,922(a4) # 18c0 <freep>
    152e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1530:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1534:	b7e1                	j	14fc <malloc+0x36>
      if(p->s.size == nunits)
    1536:	02e48c63          	beq	s1,a4,156e <malloc+0xa8>
        p->s.size -= nunits;
    153a:	4137073b          	subw	a4,a4,s3
    153e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    1540:	02071693          	slli	a3,a4,0x20
    1544:	01c6d713          	srli	a4,a3,0x1c
    1548:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    154a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    154e:	00000717          	auipc	a4,0x0
    1552:	36a73923          	sd	a0,882(a4) # 18c0 <freep>
      return (void*)(p + 1);
    1556:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    155a:	70e2                	ld	ra,56(sp)
    155c:	7442                	ld	s0,48(sp)
    155e:	74a2                	ld	s1,40(sp)
    1560:	7902                	ld	s2,32(sp)
    1562:	69e2                	ld	s3,24(sp)
    1564:	6a42                	ld	s4,16(sp)
    1566:	6aa2                	ld	s5,8(sp)
    1568:	6b02                	ld	s6,0(sp)
    156a:	6121                	addi	sp,sp,64
    156c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    156e:	6398                	ld	a4,0(a5)
    1570:	e118                	sd	a4,0(a0)
    1572:	bff1                	j	154e <malloc+0x88>
  hp->s.size = nu;
    1574:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    1578:	0541                	addi	a0,a0,16
    157a:	00000097          	auipc	ra,0x0
    157e:	ec4080e7          	jalr	-316(ra) # 143e <free>
  return freep;
    1582:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    1586:	d971                	beqz	a0,155a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1588:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    158a:	4798                	lw	a4,8(a5)
    158c:	fa9775e3          	bgeu	a4,s1,1536 <malloc+0x70>
    if(p == freep)
    1590:	00093703          	ld	a4,0(s2)
    1594:	853e                	mv	a0,a5
    1596:	fef719e3          	bne	a4,a5,1588 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    159a:	8552                	mv	a0,s4
    159c:	00000097          	auipc	ra,0x0
    15a0:	b74080e7          	jalr	-1164(ra) # 1110 <sbrk>
  if(p == (char*)-1)
    15a4:	fd5518e3          	bne	a0,s5,1574 <malloc+0xae>
        return 0;
    15a8:	4501                	li	a0,0
    15aa:	bf45                	j	155a <malloc+0x94>
