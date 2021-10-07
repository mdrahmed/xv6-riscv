
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
       0:	1101                	addi	sp,sp,-32
       2:	ec06                	sd	ra,24(sp)
       4:	e822                	sd	s0,16(sp)
       6:	e426                	sd	s1,8(sp)
       8:	e04a                	sd	s2,0(sp)
       a:	1000                	addi	s0,sp,32
       c:	84aa                	mv	s1,a0
       e:	892e                	mv	s2,a1
  fprintf(2, "$ ");
      10:	00001597          	auipc	a1,0x1
      14:	50058593          	addi	a1,a1,1280 # 1510 <malloc+0xe6>
      18:	4509                	li	a0,2
      1a:	00001097          	auipc	ra,0x1
      1e:	324080e7          	jalr	804(ra) # 133e <fprintf>
  memset(buf, 0, nbuf);
      22:	864a                	mv	a2,s2
      24:	4581                	li	a1,0
      26:	8526                	mv	a0,s1
      28:	00001097          	auipc	ra,0x1
      2c:	dc8080e7          	jalr	-568(ra) # df0 <memset>
  gets(buf, nbuf);
      30:	85ca                	mv	a1,s2
      32:	8526                	mv	a0,s1
      34:	00001097          	auipc	ra,0x1
      38:	e02080e7          	jalr	-510(ra) # e36 <gets>
  if(buf[0] == 0) // EOF
      3c:	0004c503          	lbu	a0,0(s1)
      40:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
      44:	40a00533          	neg	a0,a0
      48:	60e2                	ld	ra,24(sp)
      4a:	6442                	ld	s0,16(sp)
      4c:	64a2                	ld	s1,8(sp)
      4e:	6902                	ld	s2,0(sp)
      50:	6105                	addi	sp,sp,32
      52:	8082                	ret

0000000000000054 <panic>:
  exit(0);
}

void
panic(char *s)
{
      54:	1141                	addi	sp,sp,-16
      56:	e406                	sd	ra,8(sp)
      58:	e022                	sd	s0,0(sp)
      5a:	0800                	addi	s0,sp,16
      5c:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
      5e:	00001597          	auipc	a1,0x1
      62:	4ba58593          	addi	a1,a1,1210 # 1518 <malloc+0xee>
      66:	4509                	li	a0,2
      68:	00001097          	auipc	ra,0x1
      6c:	2d6080e7          	jalr	726(ra) # 133e <fprintf>
  exit(1);
      70:	4505                	li	a0,1
      72:	00001097          	auipc	ra,0x1
      76:	f7a080e7          	jalr	-134(ra) # fec <exit>

000000000000007a <fork1>:
}

int
fork1(void)
{
      7a:	1141                	addi	sp,sp,-16
      7c:	e406                	sd	ra,8(sp)
      7e:	e022                	sd	s0,0(sp)
      80:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
      82:	00001097          	auipc	ra,0x1
      86:	f62080e7          	jalr	-158(ra) # fe4 <fork>
  if(pid == -1)
      8a:	57fd                	li	a5,-1
      8c:	00f50663          	beq	a0,a5,98 <fork1+0x1e>
    panic("fork");
  return pid;
}
      90:	60a2                	ld	ra,8(sp)
      92:	6402                	ld	s0,0(sp)
      94:	0141                	addi	sp,sp,16
      96:	8082                	ret
    panic("fork");
      98:	00001517          	auipc	a0,0x1
      9c:	48850513          	addi	a0,a0,1160 # 1520 <malloc+0xf6>
      a0:	00000097          	auipc	ra,0x0
      a4:	fb4080e7          	jalr	-76(ra) # 54 <panic>

00000000000000a8 <runcmd>:
{
      a8:	7179                	addi	sp,sp,-48
      aa:	f406                	sd	ra,40(sp)
      ac:	f022                	sd	s0,32(sp)
      ae:	ec26                	sd	s1,24(sp)
      b0:	1800                	addi	s0,sp,48
  if(cmd == 0)
      b2:	c10d                	beqz	a0,d4 <runcmd+0x2c>
      b4:	84aa                	mv	s1,a0
  switch(cmd->type){
      b6:	4118                	lw	a4,0(a0)
      b8:	4795                	li	a5,5
      ba:	02e7e263          	bltu	a5,a4,de <runcmd+0x36>
      be:	00056783          	lwu	a5,0(a0)
      c2:	078a                	slli	a5,a5,0x2
      c4:	00001717          	auipc	a4,0x1
      c8:	55c70713          	addi	a4,a4,1372 # 1620 <malloc+0x1f6>
      cc:	97ba                	add	a5,a5,a4
      ce:	439c                	lw	a5,0(a5)
      d0:	97ba                	add	a5,a5,a4
      d2:	8782                	jr	a5
    exit(1);
      d4:	4505                	li	a0,1
      d6:	00001097          	auipc	ra,0x1
      da:	f16080e7          	jalr	-234(ra) # fec <exit>
    panic("runcmd");
      de:	00001517          	auipc	a0,0x1
      e2:	44a50513          	addi	a0,a0,1098 # 1528 <malloc+0xfe>
      e6:	00000097          	auipc	ra,0x0
      ea:	f6e080e7          	jalr	-146(ra) # 54 <panic>
    if(ecmd->argv[0] == 0)
      ee:	6508                	ld	a0,8(a0)
      f0:	c515                	beqz	a0,11c <runcmd+0x74>
    exec(ecmd->argv[0], ecmd->argv);
      f2:	00848593          	addi	a1,s1,8
      f6:	00001097          	auipc	ra,0x1
      fa:	f2e080e7          	jalr	-210(ra) # 1024 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
      fe:	6490                	ld	a2,8(s1)
     100:	00001597          	auipc	a1,0x1
     104:	43058593          	addi	a1,a1,1072 # 1530 <malloc+0x106>
     108:	4509                	li	a0,2
     10a:	00001097          	auipc	ra,0x1
     10e:	234080e7          	jalr	564(ra) # 133e <fprintf>
  exit(0);
     112:	4501                	li	a0,0
     114:	00001097          	auipc	ra,0x1
     118:	ed8080e7          	jalr	-296(ra) # fec <exit>
      exit(1);
     11c:	4505                	li	a0,1
     11e:	00001097          	auipc	ra,0x1
     122:	ece080e7          	jalr	-306(ra) # fec <exit>
    close(rcmd->fd);
     126:	5148                	lw	a0,36(a0)
     128:	00001097          	auipc	ra,0x1
     12c:	eec080e7          	jalr	-276(ra) # 1014 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     130:	508c                	lw	a1,32(s1)
     132:	6888                	ld	a0,16(s1)
     134:	00001097          	auipc	ra,0x1
     138:	ef8080e7          	jalr	-264(ra) # 102c <open>
     13c:	00054763          	bltz	a0,14a <runcmd+0xa2>
    runcmd(rcmd->cmd);
     140:	6488                	ld	a0,8(s1)
     142:	00000097          	auipc	ra,0x0
     146:	f66080e7          	jalr	-154(ra) # a8 <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
     14a:	6890                	ld	a2,16(s1)
     14c:	00001597          	auipc	a1,0x1
     150:	3f458593          	addi	a1,a1,1012 # 1540 <malloc+0x116>
     154:	4509                	li	a0,2
     156:	00001097          	auipc	ra,0x1
     15a:	1e8080e7          	jalr	488(ra) # 133e <fprintf>
      exit(1);
     15e:	4505                	li	a0,1
     160:	00001097          	auipc	ra,0x1
     164:	e8c080e7          	jalr	-372(ra) # fec <exit>
    if(fork1() == 0)
     168:	00000097          	auipc	ra,0x0
     16c:	f12080e7          	jalr	-238(ra) # 7a <fork1>
     170:	c919                	beqz	a0,186 <runcmd+0xde>
    wait(0);
     172:	4501                	li	a0,0
     174:	00001097          	auipc	ra,0x1
     178:	e80080e7          	jalr	-384(ra) # ff4 <wait>
    runcmd(lcmd->right);
     17c:	6888                	ld	a0,16(s1)
     17e:	00000097          	auipc	ra,0x0
     182:	f2a080e7          	jalr	-214(ra) # a8 <runcmd>
      runcmd(lcmd->left);
     186:	6488                	ld	a0,8(s1)
     188:	00000097          	auipc	ra,0x0
     18c:	f20080e7          	jalr	-224(ra) # a8 <runcmd>
    if(pipe(p) < 0)
     190:	fd840513          	addi	a0,s0,-40
     194:	00001097          	auipc	ra,0x1
     198:	e68080e7          	jalr	-408(ra) # ffc <pipe>
     19c:	04054363          	bltz	a0,1e2 <runcmd+0x13a>
    if(fork1() == 0){
     1a0:	00000097          	auipc	ra,0x0
     1a4:	eda080e7          	jalr	-294(ra) # 7a <fork1>
     1a8:	c529                	beqz	a0,1f2 <runcmd+0x14a>
    if(fork1() == 0){
     1aa:	00000097          	auipc	ra,0x0
     1ae:	ed0080e7          	jalr	-304(ra) # 7a <fork1>
     1b2:	cd25                	beqz	a0,22a <runcmd+0x182>
    close(p[0]);
     1b4:	fd842503          	lw	a0,-40(s0)
     1b8:	00001097          	auipc	ra,0x1
     1bc:	e5c080e7          	jalr	-420(ra) # 1014 <close>
    close(p[1]);
     1c0:	fdc42503          	lw	a0,-36(s0)
     1c4:	00001097          	auipc	ra,0x1
     1c8:	e50080e7          	jalr	-432(ra) # 1014 <close>
    wait(0);
     1cc:	4501                	li	a0,0
     1ce:	00001097          	auipc	ra,0x1
     1d2:	e26080e7          	jalr	-474(ra) # ff4 <wait>
    wait(0);
     1d6:	4501                	li	a0,0
     1d8:	00001097          	auipc	ra,0x1
     1dc:	e1c080e7          	jalr	-484(ra) # ff4 <wait>
    break;
     1e0:	bf0d                	j	112 <runcmd+0x6a>
      panic("pipe");
     1e2:	00001517          	auipc	a0,0x1
     1e6:	36e50513          	addi	a0,a0,878 # 1550 <malloc+0x126>
     1ea:	00000097          	auipc	ra,0x0
     1ee:	e6a080e7          	jalr	-406(ra) # 54 <panic>
      close(1);
     1f2:	4505                	li	a0,1
     1f4:	00001097          	auipc	ra,0x1
     1f8:	e20080e7          	jalr	-480(ra) # 1014 <close>
      dup(p[1]);
     1fc:	fdc42503          	lw	a0,-36(s0)
     200:	00001097          	auipc	ra,0x1
     204:	e64080e7          	jalr	-412(ra) # 1064 <dup>
      close(p[0]);
     208:	fd842503          	lw	a0,-40(s0)
     20c:	00001097          	auipc	ra,0x1
     210:	e08080e7          	jalr	-504(ra) # 1014 <close>
      close(p[1]);
     214:	fdc42503          	lw	a0,-36(s0)
     218:	00001097          	auipc	ra,0x1
     21c:	dfc080e7          	jalr	-516(ra) # 1014 <close>
      runcmd(pcmd->left);
     220:	6488                	ld	a0,8(s1)
     222:	00000097          	auipc	ra,0x0
     226:	e86080e7          	jalr	-378(ra) # a8 <runcmd>
      close(0);
     22a:	00001097          	auipc	ra,0x1
     22e:	dea080e7          	jalr	-534(ra) # 1014 <close>
      dup(p[0]);
     232:	fd842503          	lw	a0,-40(s0)
     236:	00001097          	auipc	ra,0x1
     23a:	e2e080e7          	jalr	-466(ra) # 1064 <dup>
      close(p[0]);
     23e:	fd842503          	lw	a0,-40(s0)
     242:	00001097          	auipc	ra,0x1
     246:	dd2080e7          	jalr	-558(ra) # 1014 <close>
      close(p[1]);
     24a:	fdc42503          	lw	a0,-36(s0)
     24e:	00001097          	auipc	ra,0x1
     252:	dc6080e7          	jalr	-570(ra) # 1014 <close>
      runcmd(pcmd->right);
     256:	6888                	ld	a0,16(s1)
     258:	00000097          	auipc	ra,0x0
     25c:	e50080e7          	jalr	-432(ra) # a8 <runcmd>
    if(fork1() == 0)
     260:	00000097          	auipc	ra,0x0
     264:	e1a080e7          	jalr	-486(ra) # 7a <fork1>
     268:	ea0515e3          	bnez	a0,112 <runcmd+0x6a>
      runcmd(bcmd->cmd);
     26c:	6488                	ld	a0,8(s1)
     26e:	00000097          	auipc	ra,0x0
     272:	e3a080e7          	jalr	-454(ra) # a8 <runcmd>

0000000000000276 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     276:	1101                	addi	sp,sp,-32
     278:	ec06                	sd	ra,24(sp)
     27a:	e822                	sd	s0,16(sp)
     27c:	e426                	sd	s1,8(sp)
     27e:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     280:	0a800513          	li	a0,168
     284:	00001097          	auipc	ra,0x1
     288:	1a6080e7          	jalr	422(ra) # 142a <malloc>
     28c:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     28e:	0a800613          	li	a2,168
     292:	4581                	li	a1,0
     294:	00001097          	auipc	ra,0x1
     298:	b5c080e7          	jalr	-1188(ra) # df0 <memset>
  cmd->type = EXEC;
     29c:	4785                	li	a5,1
     29e:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
     2a0:	8526                	mv	a0,s1
     2a2:	60e2                	ld	ra,24(sp)
     2a4:	6442                	ld	s0,16(sp)
     2a6:	64a2                	ld	s1,8(sp)
     2a8:	6105                	addi	sp,sp,32
     2aa:	8082                	ret

00000000000002ac <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     2ac:	7139                	addi	sp,sp,-64
     2ae:	fc06                	sd	ra,56(sp)
     2b0:	f822                	sd	s0,48(sp)
     2b2:	f426                	sd	s1,40(sp)
     2b4:	f04a                	sd	s2,32(sp)
     2b6:	ec4e                	sd	s3,24(sp)
     2b8:	e852                	sd	s4,16(sp)
     2ba:	e456                	sd	s5,8(sp)
     2bc:	e05a                	sd	s6,0(sp)
     2be:	0080                	addi	s0,sp,64
     2c0:	8b2a                	mv	s6,a0
     2c2:	8aae                	mv	s5,a1
     2c4:	8a32                	mv	s4,a2
     2c6:	89b6                	mv	s3,a3
     2c8:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     2ca:	02800513          	li	a0,40
     2ce:	00001097          	auipc	ra,0x1
     2d2:	15c080e7          	jalr	348(ra) # 142a <malloc>
     2d6:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     2d8:	02800613          	li	a2,40
     2dc:	4581                	li	a1,0
     2de:	00001097          	auipc	ra,0x1
     2e2:	b12080e7          	jalr	-1262(ra) # df0 <memset>
  cmd->type = REDIR;
     2e6:	4789                	li	a5,2
     2e8:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     2ea:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
     2ee:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
     2f2:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
     2f6:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
     2fa:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
     2fe:	8526                	mv	a0,s1
     300:	70e2                	ld	ra,56(sp)
     302:	7442                	ld	s0,48(sp)
     304:	74a2                	ld	s1,40(sp)
     306:	7902                	ld	s2,32(sp)
     308:	69e2                	ld	s3,24(sp)
     30a:	6a42                	ld	s4,16(sp)
     30c:	6aa2                	ld	s5,8(sp)
     30e:	6b02                	ld	s6,0(sp)
     310:	6121                	addi	sp,sp,64
     312:	8082                	ret

0000000000000314 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     314:	7179                	addi	sp,sp,-48
     316:	f406                	sd	ra,40(sp)
     318:	f022                	sd	s0,32(sp)
     31a:	ec26                	sd	s1,24(sp)
     31c:	e84a                	sd	s2,16(sp)
     31e:	e44e                	sd	s3,8(sp)
     320:	1800                	addi	s0,sp,48
     322:	89aa                	mv	s3,a0
     324:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     326:	4561                	li	a0,24
     328:	00001097          	auipc	ra,0x1
     32c:	102080e7          	jalr	258(ra) # 142a <malloc>
     330:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     332:	4661                	li	a2,24
     334:	4581                	li	a1,0
     336:	00001097          	auipc	ra,0x1
     33a:	aba080e7          	jalr	-1350(ra) # df0 <memset>
  cmd->type = PIPE;
     33e:	478d                	li	a5,3
     340:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     342:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     346:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     34a:	8526                	mv	a0,s1
     34c:	70a2                	ld	ra,40(sp)
     34e:	7402                	ld	s0,32(sp)
     350:	64e2                	ld	s1,24(sp)
     352:	6942                	ld	s2,16(sp)
     354:	69a2                	ld	s3,8(sp)
     356:	6145                	addi	sp,sp,48
     358:	8082                	ret

000000000000035a <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     35a:	7179                	addi	sp,sp,-48
     35c:	f406                	sd	ra,40(sp)
     35e:	f022                	sd	s0,32(sp)
     360:	ec26                	sd	s1,24(sp)
     362:	e84a                	sd	s2,16(sp)
     364:	e44e                	sd	s3,8(sp)
     366:	1800                	addi	s0,sp,48
     368:	89aa                	mv	s3,a0
     36a:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     36c:	4561                	li	a0,24
     36e:	00001097          	auipc	ra,0x1
     372:	0bc080e7          	jalr	188(ra) # 142a <malloc>
     376:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     378:	4661                	li	a2,24
     37a:	4581                	li	a1,0
     37c:	00001097          	auipc	ra,0x1
     380:	a74080e7          	jalr	-1420(ra) # df0 <memset>
  cmd->type = LIST;
     384:	4791                	li	a5,4
     386:	c09c                	sw	a5,0(s1)
  cmd->left = left;
     388:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
     38c:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
     390:	8526                	mv	a0,s1
     392:	70a2                	ld	ra,40(sp)
     394:	7402                	ld	s0,32(sp)
     396:	64e2                	ld	s1,24(sp)
     398:	6942                	ld	s2,16(sp)
     39a:	69a2                	ld	s3,8(sp)
     39c:	6145                	addi	sp,sp,48
     39e:	8082                	ret

00000000000003a0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     3a0:	1101                	addi	sp,sp,-32
     3a2:	ec06                	sd	ra,24(sp)
     3a4:	e822                	sd	s0,16(sp)
     3a6:	e426                	sd	s1,8(sp)
     3a8:	e04a                	sd	s2,0(sp)
     3aa:	1000                	addi	s0,sp,32
     3ac:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3ae:	4541                	li	a0,16
     3b0:	00001097          	auipc	ra,0x1
     3b4:	07a080e7          	jalr	122(ra) # 142a <malloc>
     3b8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
     3ba:	4641                	li	a2,16
     3bc:	4581                	li	a1,0
     3be:	00001097          	auipc	ra,0x1
     3c2:	a32080e7          	jalr	-1486(ra) # df0 <memset>
  cmd->type = BACK;
     3c6:	4795                	li	a5,5
     3c8:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
     3ca:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
     3ce:	8526                	mv	a0,s1
     3d0:	60e2                	ld	ra,24(sp)
     3d2:	6442                	ld	s0,16(sp)
     3d4:	64a2                	ld	s1,8(sp)
     3d6:	6902                	ld	s2,0(sp)
     3d8:	6105                	addi	sp,sp,32
     3da:	8082                	ret

00000000000003dc <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     3dc:	7139                	addi	sp,sp,-64
     3de:	fc06                	sd	ra,56(sp)
     3e0:	f822                	sd	s0,48(sp)
     3e2:	f426                	sd	s1,40(sp)
     3e4:	f04a                	sd	s2,32(sp)
     3e6:	ec4e                	sd	s3,24(sp)
     3e8:	e852                	sd	s4,16(sp)
     3ea:	e456                	sd	s5,8(sp)
     3ec:	e05a                	sd	s6,0(sp)
     3ee:	0080                	addi	s0,sp,64
     3f0:	8a2a                	mv	s4,a0
     3f2:	892e                	mv	s2,a1
     3f4:	8ab2                	mv	s5,a2
     3f6:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
     3f8:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     3fa:	00001997          	auipc	s3,0x1
     3fe:	27e98993          	addi	s3,s3,638 # 1678 <whitespace>
     402:	00b4fd63          	bgeu	s1,a1,41c <gettoken+0x40>
     406:	0004c583          	lbu	a1,0(s1)
     40a:	854e                	mv	a0,s3
     40c:	00001097          	auipc	ra,0x1
     410:	a06080e7          	jalr	-1530(ra) # e12 <strchr>
     414:	c501                	beqz	a0,41c <gettoken+0x40>
    s++;
     416:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     418:	fe9917e3          	bne	s2,s1,406 <gettoken+0x2a>
  if(q)
     41c:	000a8463          	beqz	s5,424 <gettoken+0x48>
    *q = s;
     420:	009ab023          	sd	s1,0(s5)
  ret = *s;
     424:	0004c783          	lbu	a5,0(s1)
     428:	00078a9b          	sext.w	s5,a5
  switch(*s){
     42c:	03c00713          	li	a4,60
     430:	06f76563          	bltu	a4,a5,49a <gettoken+0xbe>
     434:	03a00713          	li	a4,58
     438:	00f76e63          	bltu	a4,a5,454 <gettoken+0x78>
     43c:	cf89                	beqz	a5,456 <gettoken+0x7a>
     43e:	02600713          	li	a4,38
     442:	00e78963          	beq	a5,a4,454 <gettoken+0x78>
     446:	fd87879b          	addiw	a5,a5,-40
     44a:	0ff7f793          	zext.b	a5,a5
     44e:	4705                	li	a4,1
     450:	06f76c63          	bltu	a4,a5,4c8 <gettoken+0xec>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
     454:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     456:	000b0463          	beqz	s6,45e <gettoken+0x82>
    *eq = s;
     45a:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
     45e:	00001997          	auipc	s3,0x1
     462:	21a98993          	addi	s3,s3,538 # 1678 <whitespace>
     466:	0124fd63          	bgeu	s1,s2,480 <gettoken+0xa4>
     46a:	0004c583          	lbu	a1,0(s1)
     46e:	854e                	mv	a0,s3
     470:	00001097          	auipc	ra,0x1
     474:	9a2080e7          	jalr	-1630(ra) # e12 <strchr>
     478:	c501                	beqz	a0,480 <gettoken+0xa4>
    s++;
     47a:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     47c:	fe9917e3          	bne	s2,s1,46a <gettoken+0x8e>
  *ps = s;
     480:	009a3023          	sd	s1,0(s4)
  return ret;
}
     484:	8556                	mv	a0,s5
     486:	70e2                	ld	ra,56(sp)
     488:	7442                	ld	s0,48(sp)
     48a:	74a2                	ld	s1,40(sp)
     48c:	7902                	ld	s2,32(sp)
     48e:	69e2                	ld	s3,24(sp)
     490:	6a42                	ld	s4,16(sp)
     492:	6aa2                	ld	s5,8(sp)
     494:	6b02                	ld	s6,0(sp)
     496:	6121                	addi	sp,sp,64
     498:	8082                	ret
  switch(*s){
     49a:	03e00713          	li	a4,62
     49e:	02e79163          	bne	a5,a4,4c0 <gettoken+0xe4>
    s++;
     4a2:	00148693          	addi	a3,s1,1
    if(*s == '>'){
     4a6:	0014c703          	lbu	a4,1(s1)
     4aa:	03e00793          	li	a5,62
      s++;
     4ae:	0489                	addi	s1,s1,2
      ret = '+';
     4b0:	02b00a93          	li	s5,43
    if(*s == '>'){
     4b4:	faf701e3          	beq	a4,a5,456 <gettoken+0x7a>
    s++;
     4b8:	84b6                	mv	s1,a3
  ret = *s;
     4ba:	03e00a93          	li	s5,62
     4be:	bf61                	j	456 <gettoken+0x7a>
  switch(*s){
     4c0:	07c00713          	li	a4,124
     4c4:	f8e788e3          	beq	a5,a4,454 <gettoken+0x78>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4c8:	00001997          	auipc	s3,0x1
     4cc:	1b098993          	addi	s3,s3,432 # 1678 <whitespace>
     4d0:	00001a97          	auipc	s5,0x1
     4d4:	1a0a8a93          	addi	s5,s5,416 # 1670 <symbols>
     4d8:	0324f563          	bgeu	s1,s2,502 <gettoken+0x126>
     4dc:	0004c583          	lbu	a1,0(s1)
     4e0:	854e                	mv	a0,s3
     4e2:	00001097          	auipc	ra,0x1
     4e6:	930080e7          	jalr	-1744(ra) # e12 <strchr>
     4ea:	e505                	bnez	a0,512 <gettoken+0x136>
     4ec:	0004c583          	lbu	a1,0(s1)
     4f0:	8556                	mv	a0,s5
     4f2:	00001097          	auipc	ra,0x1
     4f6:	920080e7          	jalr	-1760(ra) # e12 <strchr>
     4fa:	e909                	bnez	a0,50c <gettoken+0x130>
      s++;
     4fc:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     4fe:	fc991fe3          	bne	s2,s1,4dc <gettoken+0x100>
  if(eq)
     502:	06100a93          	li	s5,97
     506:	f40b1ae3          	bnez	s6,45a <gettoken+0x7e>
     50a:	bf9d                	j	480 <gettoken+0xa4>
    ret = 'a';
     50c:	06100a93          	li	s5,97
     510:	b799                	j	456 <gettoken+0x7a>
     512:	06100a93          	li	s5,97
     516:	b781                	j	456 <gettoken+0x7a>

0000000000000518 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     518:	7139                	addi	sp,sp,-64
     51a:	fc06                	sd	ra,56(sp)
     51c:	f822                	sd	s0,48(sp)
     51e:	f426                	sd	s1,40(sp)
     520:	f04a                	sd	s2,32(sp)
     522:	ec4e                	sd	s3,24(sp)
     524:	e852                	sd	s4,16(sp)
     526:	e456                	sd	s5,8(sp)
     528:	0080                	addi	s0,sp,64
     52a:	8a2a                	mv	s4,a0
     52c:	892e                	mv	s2,a1
     52e:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
     530:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
     532:	00001997          	auipc	s3,0x1
     536:	14698993          	addi	s3,s3,326 # 1678 <whitespace>
     53a:	00b4fd63          	bgeu	s1,a1,554 <peek+0x3c>
     53e:	0004c583          	lbu	a1,0(s1)
     542:	854e                	mv	a0,s3
     544:	00001097          	auipc	ra,0x1
     548:	8ce080e7          	jalr	-1842(ra) # e12 <strchr>
     54c:	c501                	beqz	a0,554 <peek+0x3c>
    s++;
     54e:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
     550:	fe9917e3          	bne	s2,s1,53e <peek+0x26>
  *ps = s;
     554:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
     558:	0004c583          	lbu	a1,0(s1)
     55c:	4501                	li	a0,0
     55e:	e991                	bnez	a1,572 <peek+0x5a>
}
     560:	70e2                	ld	ra,56(sp)
     562:	7442                	ld	s0,48(sp)
     564:	74a2                	ld	s1,40(sp)
     566:	7902                	ld	s2,32(sp)
     568:	69e2                	ld	s3,24(sp)
     56a:	6a42                	ld	s4,16(sp)
     56c:	6aa2                	ld	s5,8(sp)
     56e:	6121                	addi	sp,sp,64
     570:	8082                	ret
  return *s && strchr(toks, *s);
     572:	8556                	mv	a0,s5
     574:	00001097          	auipc	ra,0x1
     578:	89e080e7          	jalr	-1890(ra) # e12 <strchr>
     57c:	00a03533          	snez	a0,a0
     580:	b7c5                	j	560 <peek+0x48>

0000000000000582 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     582:	7159                	addi	sp,sp,-112
     584:	f486                	sd	ra,104(sp)
     586:	f0a2                	sd	s0,96(sp)
     588:	eca6                	sd	s1,88(sp)
     58a:	e8ca                	sd	s2,80(sp)
     58c:	e4ce                	sd	s3,72(sp)
     58e:	e0d2                	sd	s4,64(sp)
     590:	fc56                	sd	s5,56(sp)
     592:	f85a                	sd	s6,48(sp)
     594:	f45e                	sd	s7,40(sp)
     596:	f062                	sd	s8,32(sp)
     598:	ec66                	sd	s9,24(sp)
     59a:	1880                	addi	s0,sp,112
     59c:	8a2a                	mv	s4,a0
     59e:	89ae                	mv	s3,a1
     5a0:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     5a2:	00001b97          	auipc	s7,0x1
     5a6:	fd6b8b93          	addi	s7,s7,-42 # 1578 <malloc+0x14e>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
     5aa:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
     5ae:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
     5b2:	a02d                	j	5dc <parseredirs+0x5a>
      panic("missing file for redirection");
     5b4:	00001517          	auipc	a0,0x1
     5b8:	fa450513          	addi	a0,a0,-92 # 1558 <malloc+0x12e>
     5bc:	00000097          	auipc	ra,0x0
     5c0:	a98080e7          	jalr	-1384(ra) # 54 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     5c4:	4701                	li	a4,0
     5c6:	4681                	li	a3,0
     5c8:	f9043603          	ld	a2,-112(s0)
     5cc:	f9843583          	ld	a1,-104(s0)
     5d0:	8552                	mv	a0,s4
     5d2:	00000097          	auipc	ra,0x0
     5d6:	cda080e7          	jalr	-806(ra) # 2ac <redircmd>
     5da:	8a2a                	mv	s4,a0
    switch(tok){
     5dc:	03e00b13          	li	s6,62
     5e0:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
     5e4:	865e                	mv	a2,s7
     5e6:	85ca                	mv	a1,s2
     5e8:	854e                	mv	a0,s3
     5ea:	00000097          	auipc	ra,0x0
     5ee:	f2e080e7          	jalr	-210(ra) # 518 <peek>
     5f2:	c925                	beqz	a0,662 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
     5f4:	4681                	li	a3,0
     5f6:	4601                	li	a2,0
     5f8:	85ca                	mv	a1,s2
     5fa:	854e                	mv	a0,s3
     5fc:	00000097          	auipc	ra,0x0
     600:	de0080e7          	jalr	-544(ra) # 3dc <gettoken>
     604:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
     606:	f9040693          	addi	a3,s0,-112
     60a:	f9840613          	addi	a2,s0,-104
     60e:	85ca                	mv	a1,s2
     610:	854e                	mv	a0,s3
     612:	00000097          	auipc	ra,0x0
     616:	dca080e7          	jalr	-566(ra) # 3dc <gettoken>
     61a:	f9851de3          	bne	a0,s8,5b4 <parseredirs+0x32>
    switch(tok){
     61e:	fb9483e3          	beq	s1,s9,5c4 <parseredirs+0x42>
     622:	03648263          	beq	s1,s6,646 <parseredirs+0xc4>
     626:	fb549fe3          	bne	s1,s5,5e4 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     62a:	4705                	li	a4,1
     62c:	20100693          	li	a3,513
     630:	f9043603          	ld	a2,-112(s0)
     634:	f9843583          	ld	a1,-104(s0)
     638:	8552                	mv	a0,s4
     63a:	00000097          	auipc	ra,0x0
     63e:	c72080e7          	jalr	-910(ra) # 2ac <redircmd>
     642:	8a2a                	mv	s4,a0
      break;
     644:	bf61                	j	5dc <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
     646:	4705                	li	a4,1
     648:	60100693          	li	a3,1537
     64c:	f9043603          	ld	a2,-112(s0)
     650:	f9843583          	ld	a1,-104(s0)
     654:	8552                	mv	a0,s4
     656:	00000097          	auipc	ra,0x0
     65a:	c56080e7          	jalr	-938(ra) # 2ac <redircmd>
     65e:	8a2a                	mv	s4,a0
      break;
     660:	bfb5                	j	5dc <parseredirs+0x5a>
    }
  }
  return cmd;
}
     662:	8552                	mv	a0,s4
     664:	70a6                	ld	ra,104(sp)
     666:	7406                	ld	s0,96(sp)
     668:	64e6                	ld	s1,88(sp)
     66a:	6946                	ld	s2,80(sp)
     66c:	69a6                	ld	s3,72(sp)
     66e:	6a06                	ld	s4,64(sp)
     670:	7ae2                	ld	s5,56(sp)
     672:	7b42                	ld	s6,48(sp)
     674:	7ba2                	ld	s7,40(sp)
     676:	7c02                	ld	s8,32(sp)
     678:	6ce2                	ld	s9,24(sp)
     67a:	6165                	addi	sp,sp,112
     67c:	8082                	ret

000000000000067e <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     67e:	7159                	addi	sp,sp,-112
     680:	f486                	sd	ra,104(sp)
     682:	f0a2                	sd	s0,96(sp)
     684:	eca6                	sd	s1,88(sp)
     686:	e8ca                	sd	s2,80(sp)
     688:	e4ce                	sd	s3,72(sp)
     68a:	e0d2                	sd	s4,64(sp)
     68c:	fc56                	sd	s5,56(sp)
     68e:	f85a                	sd	s6,48(sp)
     690:	f45e                	sd	s7,40(sp)
     692:	f062                	sd	s8,32(sp)
     694:	ec66                	sd	s9,24(sp)
     696:	1880                	addi	s0,sp,112
     698:	8a2a                	mv	s4,a0
     69a:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     69c:	00001617          	auipc	a2,0x1
     6a0:	ee460613          	addi	a2,a2,-284 # 1580 <malloc+0x156>
     6a4:	00000097          	auipc	ra,0x0
     6a8:	e74080e7          	jalr	-396(ra) # 518 <peek>
     6ac:	e905                	bnez	a0,6dc <parseexec+0x5e>
     6ae:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
     6b0:	00000097          	auipc	ra,0x0
     6b4:	bc6080e7          	jalr	-1082(ra) # 276 <execcmd>
     6b8:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     6ba:	8656                	mv	a2,s5
     6bc:	85d2                	mv	a1,s4
     6be:	00000097          	auipc	ra,0x0
     6c2:	ec4080e7          	jalr	-316(ra) # 582 <parseredirs>
     6c6:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     6c8:	008c0913          	addi	s2,s8,8
     6cc:	00001b17          	auipc	s6,0x1
     6d0:	ed4b0b13          	addi	s6,s6,-300 # 15a0 <malloc+0x176>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
     6d4:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
     6d8:	4ba9                	li	s7,10
  while(!peek(ps, es, "|)&;")){
     6da:	a0b1                	j	726 <parseexec+0xa8>
    return parseblock(ps, es);
     6dc:	85d6                	mv	a1,s5
     6de:	8552                	mv	a0,s4
     6e0:	00000097          	auipc	ra,0x0
     6e4:	1bc080e7          	jalr	444(ra) # 89c <parseblock>
     6e8:	84aa                	mv	s1,a0
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     6ea:	8526                	mv	a0,s1
     6ec:	70a6                	ld	ra,104(sp)
     6ee:	7406                	ld	s0,96(sp)
     6f0:	64e6                	ld	s1,88(sp)
     6f2:	6946                	ld	s2,80(sp)
     6f4:	69a6                	ld	s3,72(sp)
     6f6:	6a06                	ld	s4,64(sp)
     6f8:	7ae2                	ld	s5,56(sp)
     6fa:	7b42                	ld	s6,48(sp)
     6fc:	7ba2                	ld	s7,40(sp)
     6fe:	7c02                	ld	s8,32(sp)
     700:	6ce2                	ld	s9,24(sp)
     702:	6165                	addi	sp,sp,112
     704:	8082                	ret
      panic("syntax");
     706:	00001517          	auipc	a0,0x1
     70a:	e8250513          	addi	a0,a0,-382 # 1588 <malloc+0x15e>
     70e:	00000097          	auipc	ra,0x0
     712:	946080e7          	jalr	-1722(ra) # 54 <panic>
    ret = parseredirs(ret, ps, es);
     716:	8656                	mv	a2,s5
     718:	85d2                	mv	a1,s4
     71a:	8526                	mv	a0,s1
     71c:	00000097          	auipc	ra,0x0
     720:	e66080e7          	jalr	-410(ra) # 582 <parseredirs>
     724:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
     726:	865a                	mv	a2,s6
     728:	85d6                	mv	a1,s5
     72a:	8552                	mv	a0,s4
     72c:	00000097          	auipc	ra,0x0
     730:	dec080e7          	jalr	-532(ra) # 518 <peek>
     734:	e131                	bnez	a0,778 <parseexec+0xfa>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     736:	f9040693          	addi	a3,s0,-112
     73a:	f9840613          	addi	a2,s0,-104
     73e:	85d6                	mv	a1,s5
     740:	8552                	mv	a0,s4
     742:	00000097          	auipc	ra,0x0
     746:	c9a080e7          	jalr	-870(ra) # 3dc <gettoken>
     74a:	c51d                	beqz	a0,778 <parseexec+0xfa>
    if(tok != 'a')
     74c:	fb951de3          	bne	a0,s9,706 <parseexec+0x88>
    cmd->argv[argc] = q;
     750:	f9843783          	ld	a5,-104(s0)
     754:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
     758:	f9043783          	ld	a5,-112(s0)
     75c:	04f93823          	sd	a5,80(s2)
    argc++;
     760:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
     762:	0921                	addi	s2,s2,8
     764:	fb7999e3          	bne	s3,s7,716 <parseexec+0x98>
      panic("too many args");
     768:	00001517          	auipc	a0,0x1
     76c:	e2850513          	addi	a0,a0,-472 # 1590 <malloc+0x166>
     770:	00000097          	auipc	ra,0x0
     774:	8e4080e7          	jalr	-1820(ra) # 54 <panic>
  cmd->argv[argc] = 0;
     778:	098e                	slli	s3,s3,0x3
     77a:	99e2                	add	s3,s3,s8
     77c:	0009b423          	sd	zero,8(s3)
  cmd->eargv[argc] = 0;
     780:	0409bc23          	sd	zero,88(s3)
  return ret;
     784:	b79d                	j	6ea <parseexec+0x6c>

0000000000000786 <parsepipe>:
{
     786:	7179                	addi	sp,sp,-48
     788:	f406                	sd	ra,40(sp)
     78a:	f022                	sd	s0,32(sp)
     78c:	ec26                	sd	s1,24(sp)
     78e:	e84a                	sd	s2,16(sp)
     790:	e44e                	sd	s3,8(sp)
     792:	1800                	addi	s0,sp,48
     794:	892a                	mv	s2,a0
     796:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
     798:	00000097          	auipc	ra,0x0
     79c:	ee6080e7          	jalr	-282(ra) # 67e <parseexec>
     7a0:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
     7a2:	00001617          	auipc	a2,0x1
     7a6:	e0660613          	addi	a2,a2,-506 # 15a8 <malloc+0x17e>
     7aa:	85ce                	mv	a1,s3
     7ac:	854a                	mv	a0,s2
     7ae:	00000097          	auipc	ra,0x0
     7b2:	d6a080e7          	jalr	-662(ra) # 518 <peek>
     7b6:	e909                	bnez	a0,7c8 <parsepipe+0x42>
}
     7b8:	8526                	mv	a0,s1
     7ba:	70a2                	ld	ra,40(sp)
     7bc:	7402                	ld	s0,32(sp)
     7be:	64e2                	ld	s1,24(sp)
     7c0:	6942                	ld	s2,16(sp)
     7c2:	69a2                	ld	s3,8(sp)
     7c4:	6145                	addi	sp,sp,48
     7c6:	8082                	ret
    gettoken(ps, es, 0, 0);
     7c8:	4681                	li	a3,0
     7ca:	4601                	li	a2,0
     7cc:	85ce                	mv	a1,s3
     7ce:	854a                	mv	a0,s2
     7d0:	00000097          	auipc	ra,0x0
     7d4:	c0c080e7          	jalr	-1012(ra) # 3dc <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     7d8:	85ce                	mv	a1,s3
     7da:	854a                	mv	a0,s2
     7dc:	00000097          	auipc	ra,0x0
     7e0:	faa080e7          	jalr	-86(ra) # 786 <parsepipe>
     7e4:	85aa                	mv	a1,a0
     7e6:	8526                	mv	a0,s1
     7e8:	00000097          	auipc	ra,0x0
     7ec:	b2c080e7          	jalr	-1236(ra) # 314 <pipecmd>
     7f0:	84aa                	mv	s1,a0
  return cmd;
     7f2:	b7d9                	j	7b8 <parsepipe+0x32>

00000000000007f4 <parseline>:
{
     7f4:	7179                	addi	sp,sp,-48
     7f6:	f406                	sd	ra,40(sp)
     7f8:	f022                	sd	s0,32(sp)
     7fa:	ec26                	sd	s1,24(sp)
     7fc:	e84a                	sd	s2,16(sp)
     7fe:	e44e                	sd	s3,8(sp)
     800:	e052                	sd	s4,0(sp)
     802:	1800                	addi	s0,sp,48
     804:	892a                	mv	s2,a0
     806:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
     808:	00000097          	auipc	ra,0x0
     80c:	f7e080e7          	jalr	-130(ra) # 786 <parsepipe>
     810:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     812:	00001a17          	auipc	s4,0x1
     816:	d9ea0a13          	addi	s4,s4,-610 # 15b0 <malloc+0x186>
     81a:	a839                	j	838 <parseline+0x44>
    gettoken(ps, es, 0, 0);
     81c:	4681                	li	a3,0
     81e:	4601                	li	a2,0
     820:	85ce                	mv	a1,s3
     822:	854a                	mv	a0,s2
     824:	00000097          	auipc	ra,0x0
     828:	bb8080e7          	jalr	-1096(ra) # 3dc <gettoken>
    cmd = backcmd(cmd);
     82c:	8526                	mv	a0,s1
     82e:	00000097          	auipc	ra,0x0
     832:	b72080e7          	jalr	-1166(ra) # 3a0 <backcmd>
     836:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
     838:	8652                	mv	a2,s4
     83a:	85ce                	mv	a1,s3
     83c:	854a                	mv	a0,s2
     83e:	00000097          	auipc	ra,0x0
     842:	cda080e7          	jalr	-806(ra) # 518 <peek>
     846:	f979                	bnez	a0,81c <parseline+0x28>
  if(peek(ps, es, ";")){
     848:	00001617          	auipc	a2,0x1
     84c:	d7060613          	addi	a2,a2,-656 # 15b8 <malloc+0x18e>
     850:	85ce                	mv	a1,s3
     852:	854a                	mv	a0,s2
     854:	00000097          	auipc	ra,0x0
     858:	cc4080e7          	jalr	-828(ra) # 518 <peek>
     85c:	e911                	bnez	a0,870 <parseline+0x7c>
}
     85e:	8526                	mv	a0,s1
     860:	70a2                	ld	ra,40(sp)
     862:	7402                	ld	s0,32(sp)
     864:	64e2                	ld	s1,24(sp)
     866:	6942                	ld	s2,16(sp)
     868:	69a2                	ld	s3,8(sp)
     86a:	6a02                	ld	s4,0(sp)
     86c:	6145                	addi	sp,sp,48
     86e:	8082                	ret
    gettoken(ps, es, 0, 0);
     870:	4681                	li	a3,0
     872:	4601                	li	a2,0
     874:	85ce                	mv	a1,s3
     876:	854a                	mv	a0,s2
     878:	00000097          	auipc	ra,0x0
     87c:	b64080e7          	jalr	-1180(ra) # 3dc <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     880:	85ce                	mv	a1,s3
     882:	854a                	mv	a0,s2
     884:	00000097          	auipc	ra,0x0
     888:	f70080e7          	jalr	-144(ra) # 7f4 <parseline>
     88c:	85aa                	mv	a1,a0
     88e:	8526                	mv	a0,s1
     890:	00000097          	auipc	ra,0x0
     894:	aca080e7          	jalr	-1334(ra) # 35a <listcmd>
     898:	84aa                	mv	s1,a0
  return cmd;
     89a:	b7d1                	j	85e <parseline+0x6a>

000000000000089c <parseblock>:
{
     89c:	7179                	addi	sp,sp,-48
     89e:	f406                	sd	ra,40(sp)
     8a0:	f022                	sd	s0,32(sp)
     8a2:	ec26                	sd	s1,24(sp)
     8a4:	e84a                	sd	s2,16(sp)
     8a6:	e44e                	sd	s3,8(sp)
     8a8:	1800                	addi	s0,sp,48
     8aa:	84aa                	mv	s1,a0
     8ac:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
     8ae:	00001617          	auipc	a2,0x1
     8b2:	cd260613          	addi	a2,a2,-814 # 1580 <malloc+0x156>
     8b6:	00000097          	auipc	ra,0x0
     8ba:	c62080e7          	jalr	-926(ra) # 518 <peek>
     8be:	c12d                	beqz	a0,920 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
     8c0:	4681                	li	a3,0
     8c2:	4601                	li	a2,0
     8c4:	85ca                	mv	a1,s2
     8c6:	8526                	mv	a0,s1
     8c8:	00000097          	auipc	ra,0x0
     8cc:	b14080e7          	jalr	-1260(ra) # 3dc <gettoken>
  cmd = parseline(ps, es);
     8d0:	85ca                	mv	a1,s2
     8d2:	8526                	mv	a0,s1
     8d4:	00000097          	auipc	ra,0x0
     8d8:	f20080e7          	jalr	-224(ra) # 7f4 <parseline>
     8dc:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
     8de:	00001617          	auipc	a2,0x1
     8e2:	cf260613          	addi	a2,a2,-782 # 15d0 <malloc+0x1a6>
     8e6:	85ca                	mv	a1,s2
     8e8:	8526                	mv	a0,s1
     8ea:	00000097          	auipc	ra,0x0
     8ee:	c2e080e7          	jalr	-978(ra) # 518 <peek>
     8f2:	cd1d                	beqz	a0,930 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
     8f4:	4681                	li	a3,0
     8f6:	4601                	li	a2,0
     8f8:	85ca                	mv	a1,s2
     8fa:	8526                	mv	a0,s1
     8fc:	00000097          	auipc	ra,0x0
     900:	ae0080e7          	jalr	-1312(ra) # 3dc <gettoken>
  cmd = parseredirs(cmd, ps, es);
     904:	864a                	mv	a2,s2
     906:	85a6                	mv	a1,s1
     908:	854e                	mv	a0,s3
     90a:	00000097          	auipc	ra,0x0
     90e:	c78080e7          	jalr	-904(ra) # 582 <parseredirs>
}
     912:	70a2                	ld	ra,40(sp)
     914:	7402                	ld	s0,32(sp)
     916:	64e2                	ld	s1,24(sp)
     918:	6942                	ld	s2,16(sp)
     91a:	69a2                	ld	s3,8(sp)
     91c:	6145                	addi	sp,sp,48
     91e:	8082                	ret
    panic("parseblock");
     920:	00001517          	auipc	a0,0x1
     924:	ca050513          	addi	a0,a0,-864 # 15c0 <malloc+0x196>
     928:	fffff097          	auipc	ra,0xfffff
     92c:	72c080e7          	jalr	1836(ra) # 54 <panic>
    panic("syntax - missing )");
     930:	00001517          	auipc	a0,0x1
     934:	ca850513          	addi	a0,a0,-856 # 15d8 <malloc+0x1ae>
     938:	fffff097          	auipc	ra,0xfffff
     93c:	71c080e7          	jalr	1820(ra) # 54 <panic>

0000000000000940 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     940:	1101                	addi	sp,sp,-32
     942:	ec06                	sd	ra,24(sp)
     944:	e822                	sd	s0,16(sp)
     946:	e426                	sd	s1,8(sp)
     948:	1000                	addi	s0,sp,32
     94a:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     94c:	c521                	beqz	a0,994 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
     94e:	4118                	lw	a4,0(a0)
     950:	4795                	li	a5,5
     952:	04e7e163          	bltu	a5,a4,994 <nulterminate+0x54>
     956:	00056783          	lwu	a5,0(a0)
     95a:	078a                	slli	a5,a5,0x2
     95c:	00001717          	auipc	a4,0x1
     960:	cdc70713          	addi	a4,a4,-804 # 1638 <malloc+0x20e>
     964:	97ba                	add	a5,a5,a4
     966:	439c                	lw	a5,0(a5)
     968:	97ba                	add	a5,a5,a4
     96a:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     96c:	651c                	ld	a5,8(a0)
     96e:	c39d                	beqz	a5,994 <nulterminate+0x54>
     970:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
     974:	67b8                	ld	a4,72(a5)
     976:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
     97a:	07a1                	addi	a5,a5,8
     97c:	ff87b703          	ld	a4,-8(a5)
     980:	fb75                	bnez	a4,974 <nulterminate+0x34>
     982:	a809                	j	994 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     984:	6508                	ld	a0,8(a0)
     986:	00000097          	auipc	ra,0x0
     98a:	fba080e7          	jalr	-70(ra) # 940 <nulterminate>
    *rcmd->efile = 0;
     98e:	6c9c                	ld	a5,24(s1)
     990:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     994:	8526                	mv	a0,s1
     996:	60e2                	ld	ra,24(sp)
     998:	6442                	ld	s0,16(sp)
     99a:	64a2                	ld	s1,8(sp)
     99c:	6105                	addi	sp,sp,32
     99e:	8082                	ret
    nulterminate(pcmd->left);
     9a0:	6508                	ld	a0,8(a0)
     9a2:	00000097          	auipc	ra,0x0
     9a6:	f9e080e7          	jalr	-98(ra) # 940 <nulterminate>
    nulterminate(pcmd->right);
     9aa:	6888                	ld	a0,16(s1)
     9ac:	00000097          	auipc	ra,0x0
     9b0:	f94080e7          	jalr	-108(ra) # 940 <nulterminate>
    break;
     9b4:	b7c5                	j	994 <nulterminate+0x54>
    nulterminate(lcmd->left);
     9b6:	6508                	ld	a0,8(a0)
     9b8:	00000097          	auipc	ra,0x0
     9bc:	f88080e7          	jalr	-120(ra) # 940 <nulterminate>
    nulterminate(lcmd->right);
     9c0:	6888                	ld	a0,16(s1)
     9c2:	00000097          	auipc	ra,0x0
     9c6:	f7e080e7          	jalr	-130(ra) # 940 <nulterminate>
    break;
     9ca:	b7e9                	j	994 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
     9cc:	6508                	ld	a0,8(a0)
     9ce:	00000097          	auipc	ra,0x0
     9d2:	f72080e7          	jalr	-142(ra) # 940 <nulterminate>
    break;
     9d6:	bf7d                	j	994 <nulterminate+0x54>

00000000000009d8 <parsecmd>:
{
     9d8:	7179                	addi	sp,sp,-48
     9da:	f406                	sd	ra,40(sp)
     9dc:	f022                	sd	s0,32(sp)
     9de:	ec26                	sd	s1,24(sp)
     9e0:	e84a                	sd	s2,16(sp)
     9e2:	1800                	addi	s0,sp,48
     9e4:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
     9e8:	84aa                	mv	s1,a0
     9ea:	00000097          	auipc	ra,0x0
     9ee:	3dc080e7          	jalr	988(ra) # dc6 <strlen>
     9f2:	1502                	slli	a0,a0,0x20
     9f4:	9101                	srli	a0,a0,0x20
     9f6:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
     9f8:	85a6                	mv	a1,s1
     9fa:	fd840513          	addi	a0,s0,-40
     9fe:	00000097          	auipc	ra,0x0
     a02:	df6080e7          	jalr	-522(ra) # 7f4 <parseline>
     a06:	892a                	mv	s2,a0
  peek(&s, es, "");
     a08:	00001617          	auipc	a2,0x1
     a0c:	be860613          	addi	a2,a2,-1048 # 15f0 <malloc+0x1c6>
     a10:	85a6                	mv	a1,s1
     a12:	fd840513          	addi	a0,s0,-40
     a16:	00000097          	auipc	ra,0x0
     a1a:	b02080e7          	jalr	-1278(ra) # 518 <peek>
  if(s != es){
     a1e:	fd843603          	ld	a2,-40(s0)
     a22:	00961e63          	bne	a2,s1,a3e <parsecmd+0x66>
  nulterminate(cmd);
     a26:	854a                	mv	a0,s2
     a28:	00000097          	auipc	ra,0x0
     a2c:	f18080e7          	jalr	-232(ra) # 940 <nulterminate>
}
     a30:	854a                	mv	a0,s2
     a32:	70a2                	ld	ra,40(sp)
     a34:	7402                	ld	s0,32(sp)
     a36:	64e2                	ld	s1,24(sp)
     a38:	6942                	ld	s2,16(sp)
     a3a:	6145                	addi	sp,sp,48
     a3c:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
     a3e:	00001597          	auipc	a1,0x1
     a42:	bba58593          	addi	a1,a1,-1094 # 15f8 <malloc+0x1ce>
     a46:	4509                	li	a0,2
     a48:	00001097          	auipc	ra,0x1
     a4c:	8f6080e7          	jalr	-1802(ra) # 133e <fprintf>
    panic("syntax");
     a50:	00001517          	auipc	a0,0x1
     a54:	b3850513          	addi	a0,a0,-1224 # 1588 <malloc+0x15e>
     a58:	fffff097          	auipc	ra,0xfffff
     a5c:	5fc080e7          	jalr	1532(ra) # 54 <panic>

0000000000000a60 <main>:
{
     a60:	7139                	addi	sp,sp,-64
     a62:	fc06                	sd	ra,56(sp)
     a64:	f822                	sd	s0,48(sp)
     a66:	f426                	sd	s1,40(sp)
     a68:	f04a                	sd	s2,32(sp)
     a6a:	ec4e                	sd	s3,24(sp)
     a6c:	e852                	sd	s4,16(sp)
     a6e:	e456                	sd	s5,8(sp)
     a70:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
     a72:	00001497          	auipc	s1,0x1
     a76:	b9648493          	addi	s1,s1,-1130 # 1608 <malloc+0x1de>
     a7a:	4589                	li	a1,2
     a7c:	8526                	mv	a0,s1
     a7e:	00000097          	auipc	ra,0x0
     a82:	5ae080e7          	jalr	1454(ra) # 102c <open>
     a86:	00054963          	bltz	a0,a98 <main+0x38>
    if(fd >= 3){
     a8a:	4789                	li	a5,2
     a8c:	fea7d7e3          	bge	a5,a0,a7a <main+0x1a>
      close(fd);
     a90:	00000097          	auipc	ra,0x0
     a94:	584080e7          	jalr	1412(ra) # 1014 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
     a98:	00001497          	auipc	s1,0x1
     a9c:	bf048493          	addi	s1,s1,-1040 # 1688 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     aa0:	06300913          	li	s2,99
     aa4:	02000993          	li	s3,32
      if(chdir(buf+3) < 0)
     aa8:	00001a17          	auipc	s4,0x1
     aac:	be3a0a13          	addi	s4,s4,-1053 # 168b <buf.0+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
     ab0:	00001a97          	auipc	s5,0x1
     ab4:	b60a8a93          	addi	s5,s5,-1184 # 1610 <malloc+0x1e6>
     ab8:	a819                	j	ace <main+0x6e>
    if(fork1() == 0)
     aba:	fffff097          	auipc	ra,0xfffff
     abe:	5c0080e7          	jalr	1472(ra) # 7a <fork1>
     ac2:	c925                	beqz	a0,b32 <main+0xd2>
    wait(0);
     ac4:	4501                	li	a0,0
     ac6:	00000097          	auipc	ra,0x0
     aca:	52e080e7          	jalr	1326(ra) # ff4 <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
     ace:	06400593          	li	a1,100
     ad2:	8526                	mv	a0,s1
     ad4:	fffff097          	auipc	ra,0xfffff
     ad8:	52c080e7          	jalr	1324(ra) # 0 <getcmd>
     adc:	06054763          	bltz	a0,b4a <main+0xea>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     ae0:	0004c783          	lbu	a5,0(s1)
     ae4:	fd279be3          	bne	a5,s2,aba <main+0x5a>
     ae8:	0014c703          	lbu	a4,1(s1)
     aec:	06400793          	li	a5,100
     af0:	fcf715e3          	bne	a4,a5,aba <main+0x5a>
     af4:	0024c783          	lbu	a5,2(s1)
     af8:	fd3791e3          	bne	a5,s3,aba <main+0x5a>
      buf[strlen(buf)-1] = 0;  // chop \n
     afc:	8526                	mv	a0,s1
     afe:	00000097          	auipc	ra,0x0
     b02:	2c8080e7          	jalr	712(ra) # dc6 <strlen>
     b06:	fff5079b          	addiw	a5,a0,-1
     b0a:	1782                	slli	a5,a5,0x20
     b0c:	9381                	srli	a5,a5,0x20
     b0e:	97a6                	add	a5,a5,s1
     b10:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
     b14:	8552                	mv	a0,s4
     b16:	00000097          	auipc	ra,0x0
     b1a:	546080e7          	jalr	1350(ra) # 105c <chdir>
     b1e:	fa0558e3          	bgez	a0,ace <main+0x6e>
        fprintf(2, "cannot cd %s\n", buf+3);
     b22:	8652                	mv	a2,s4
     b24:	85d6                	mv	a1,s5
     b26:	4509                	li	a0,2
     b28:	00001097          	auipc	ra,0x1
     b2c:	816080e7          	jalr	-2026(ra) # 133e <fprintf>
     b30:	bf79                	j	ace <main+0x6e>
      runcmd(parsecmd(buf));
     b32:	00001517          	auipc	a0,0x1
     b36:	b5650513          	addi	a0,a0,-1194 # 1688 <buf.0>
     b3a:	00000097          	auipc	ra,0x0
     b3e:	e9e080e7          	jalr	-354(ra) # 9d8 <parsecmd>
     b42:	fffff097          	auipc	ra,0xfffff
     b46:	566080e7          	jalr	1382(ra) # a8 <runcmd>
  exit(0);
     b4a:	4501                	li	a0,0
     b4c:	00000097          	auipc	ra,0x0
     b50:	4a0080e7          	jalr	1184(ra) # fec <exit>

0000000000000b54 <store>:
  uint64 read_done, write_done;
};

struct user_ring_buf rings[10]; // this will be an array of 10 rings

void store(uint64 *p, int v) {
     b54:	1141                	addi	sp,sp,-16
     b56:	e422                	sd	s0,8(sp)
     b58:	0800                	addi	s0,sp,16
  __atomic_store_8(p, v, __ATOMIC_SEQ_CST);
     b5a:	0f50000f          	fence	iorw,ow
     b5e:	0cb5302f          	amoswap.d.aq	zero,a1,(a0)
}
     b62:	6422                	ld	s0,8(sp)
     b64:	0141                	addi	sp,sp,16
     b66:	8082                	ret

0000000000000b68 <load>:

int load(uint64 *p) {
     b68:	1141                	addi	sp,sp,-16
     b6a:	e422                	sd	s0,8(sp)
     b6c:	0800                	addi	s0,sp,16
  return __atomic_load_8(p, __ATOMIC_SEQ_CST);
     b6e:	0ff0000f          	fence
     b72:	6108                	ld	a0,0(a0)
     b74:	0ff0000f          	fence
}
     b78:	2501                	sext.w	a0,a0
     b7a:	6422                	ld	s0,8(sp)
     b7c:	0141                	addi	sp,sp,16
     b7e:	8082                	ret

0000000000000b80 <create_or_close_the_buffer_user>:

int create_or_close_the_buffer_user(char name[16], int open_close){
     b80:	7179                	addi	sp,sp,-48
     b82:	f406                	sd	ra,40(sp)
     b84:	f022                	sd	s0,32(sp)
     b86:	ec26                	sd	s1,24(sp)
     b88:	e84a                	sd	s2,16(sp)
     b8a:	e44e                	sd	s3,8(sp)
     b8c:	e052                	sd	s4,0(sp)
     b8e:	1800                	addi	s0,sp,48
     b90:	8a2a                	mv	s4,a0
     b92:	89ae                	mv	s3,a1
  int i;
  if(open_close == 1){
     b94:	4785                	li	a5,1
     b96:	00001497          	auipc	s1,0x1
     b9a:	b6a48493          	addi	s1,s1,-1174 # 1700 <rings+0x10>
     b9e:	00001917          	auipc	s2,0x1
     ba2:	c5290913          	addi	s2,s2,-942 # 17f0 <__BSS_END__>
     ba6:	04f59563          	bne	a1,a5,bf0 <create_or_close_the_buffer_user+0x70>
    for(i = 0; i < 10; i++){
      if(rings[i].exists == 0){
     baa:	00001497          	auipc	s1,0x1
     bae:	b564a483          	lw	s1,-1194(s1) # 1700 <rings+0x10>
     bb2:	c099                	beqz	s1,bb8 <create_or_close_the_buffer_user+0x38>
     bb4:	4481                	li	s1,0
     bb6:	a899                	j	c0c <create_or_close_the_buffer_user+0x8c>
        ringbuf(name, open_close, rings[i].buf);
     bb8:	00001917          	auipc	s2,0x1
     bbc:	b3890913          	addi	s2,s2,-1224 # 16f0 <rings>
     bc0:	00093603          	ld	a2,0(s2)
     bc4:	4585                	li	a1,1
     bc6:	00000097          	auipc	ra,0x0
     bca:	4c6080e7          	jalr	1222(ra) # 108c <ringbuf>
        rings[i].book->write_done = 0;
     bce:	00893783          	ld	a5,8(s2)
     bd2:	0007b423          	sd	zero,8(a5)
        rings[i].book->read_done = 0;
     bd6:	00893783          	ld	a5,8(s2)
     bda:	0007b023          	sd	zero,0(a5)
        rings[i].exists++;
     bde:	01092783          	lw	a5,16(s2)
     be2:	2785                	addiw	a5,a5,1
     be4:	00f92823          	sw	a5,16(s2)
        break;
     be8:	a015                	j	c0c <create_or_close_the_buffer_user+0x8c>
        break;
      }
    }
  }
  else{
    for(i = 0; i < 10; i++){
     bea:	04e1                	addi	s1,s1,24
     bec:	01248f63          	beq	s1,s2,c0a <create_or_close_the_buffer_user+0x8a>
      if(rings[i].exists != 0){
     bf0:	409c                	lw	a5,0(s1)
     bf2:	dfe5                	beqz	a5,bea <create_or_close_the_buffer_user+0x6a>
        ringbuf(name, open_close, rings[i].buf);
     bf4:	ff04b603          	ld	a2,-16(s1)
     bf8:	85ce                	mv	a1,s3
     bfa:	8552                	mv	a0,s4
     bfc:	00000097          	auipc	ra,0x0
     c00:	490080e7          	jalr	1168(ra) # 108c <ringbuf>
        rings[i].exists = 0;
     c04:	0004a023          	sw	zero,0(s1)
     c08:	b7cd                	j	bea <create_or_close_the_buffer_user+0x6a>
    for(i = 0; i < 10; i++){
     c0a:	44a9                	li	s1,10
      }
    }
  }
  
  return i;
}
     c0c:	8526                	mv	a0,s1
     c0e:	70a2                	ld	ra,40(sp)
     c10:	7402                	ld	s0,32(sp)
     c12:	64e2                	ld	s1,24(sp)
     c14:	6942                	ld	s2,16(sp)
     c16:	69a2                	ld	s3,8(sp)
     c18:	6a02                	ld	s4,0(sp)
     c1a:	6145                	addi	sp,sp,48
     c1c:	8082                	ret

0000000000000c1e <ringbuf_start_write>:

//// rings starting to write 
void ringbuf_start_write(int ring_desc, uint64 **addr, int *bytes){ // address ta double pointer hobe
     c1e:	1101                	addi	sp,sp,-32
     c20:	ec06                	sd	ra,24(sp)
     c22:	e822                	sd	s0,16(sp)
     c24:	e426                	sd	s1,8(sp)
     c26:	1000                	addi	s0,sp,32
     c28:	84b2                	mv	s1,a2
  // *addr = (4096*16)-(rings[ring_desc].book->write_done++) % 4096;
  *addr = rings[ring_desc].buf;
     c2a:	00151793          	slli	a5,a0,0x1
     c2e:	97aa                	add	a5,a5,a0
     c30:	078e                	slli	a5,a5,0x3
     c32:	00001717          	auipc	a4,0x1
     c36:	abe70713          	addi	a4,a4,-1346 # 16f0 <rings>
     c3a:	97ba                	add	a5,a5,a4
     c3c:	639c                	ld	a5,0(a5)
     c3e:	e19c                	sd	a5,0(a1)
  if(*bytes == 0){
     c40:	421c                	lw	a5,0(a2)
     c42:	e785                	bnez	a5,c6a <ringbuf_start_write+0x4c>
    *bytes = 4096*16 -(rings[ring_desc].book->write_done - rings[0].book->read_done);
     c44:	86ba                	mv	a3,a4
     c46:	671c                	ld	a5,8(a4)
     c48:	6398                	ld	a4,0(a5)
     c4a:	67c1                	lui	a5,0x10
     c4c:	9fb9                	addw	a5,a5,a4
     c4e:	00151713          	slli	a4,a0,0x1
     c52:	953a                	add	a0,a0,a4
     c54:	050e                	slli	a0,a0,0x3
     c56:	9536                	add	a0,a0,a3
     c58:	6518                	ld	a4,8(a0)
     c5a:	6718                	ld	a4,8(a4)
     c5c:	9f99                	subw	a5,a5,a4
     c5e:	c21c                	sw	a5,0(a2)
  }
  else{
    *bytes = load(&(rings[ring_desc].book->write_done));
  } 
}
     c60:	60e2                	ld	ra,24(sp)
     c62:	6442                	ld	s0,16(sp)
     c64:	64a2                	ld	s1,8(sp)
     c66:	6105                	addi	sp,sp,32
     c68:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->write_done));
     c6a:	00151793          	slli	a5,a0,0x1
     c6e:	953e                	add	a0,a0,a5
     c70:	050e                	slli	a0,a0,0x3
     c72:	00001797          	auipc	a5,0x1
     c76:	a7e78793          	addi	a5,a5,-1410 # 16f0 <rings>
     c7a:	953e                	add	a0,a0,a5
     c7c:	6508                	ld	a0,8(a0)
     c7e:	0521                	addi	a0,a0,8
     c80:	00000097          	auipc	ra,0x0
     c84:	ee8080e7          	jalr	-280(ra) # b68 <load>
     c88:	c088                	sw	a0,0(s1)
}
     c8a:	bfd9                	j	c60 <ringbuf_start_write+0x42>

0000000000000c8c <ringbuf_finish_write>:
void ringbuf_finish_write(int ring_desc, int bytes){
     c8c:	1141                	addi	sp,sp,-16
     c8e:	e406                	sd	ra,8(sp)
     c90:	e022                	sd	s0,0(sp)
     c92:	0800                	addi	s0,sp,16
  //store total bytes write to the bookkeeping page 
  bytes = (bytes*8); ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->write_done), bytes);
     c94:	00151793          	slli	a5,a0,0x1
     c98:	97aa                	add	a5,a5,a0
     c9a:	078e                	slli	a5,a5,0x3
     c9c:	00001517          	auipc	a0,0x1
     ca0:	a5450513          	addi	a0,a0,-1452 # 16f0 <rings>
     ca4:	97aa                	add	a5,a5,a0
     ca6:	6788                	ld	a0,8(a5)
     ca8:	0035959b          	slliw	a1,a1,0x3
     cac:	0521                	addi	a0,a0,8
     cae:	00000097          	auipc	ra,0x0
     cb2:	ea6080e7          	jalr	-346(ra) # b54 <store>
}
     cb6:	60a2                	ld	ra,8(sp)
     cb8:	6402                	ld	s0,0(sp)
     cba:	0141                	addi	sp,sp,16
     cbc:	8082                	ret

0000000000000cbe <check_bytes_written>:

void check_bytes_written(int ring_desc, int *bytes){
     cbe:	1101                	addi	sp,sp,-32
     cc0:	ec06                	sd	ra,24(sp)
     cc2:	e822                	sd	s0,16(sp)
     cc4:	e426                	sd	s1,8(sp)
     cc6:	1000                	addi	s0,sp,32
     cc8:	84ae                	mv	s1,a1
  *bytes = load(&(rings[ring_desc].book->write_done));
     cca:	00151793          	slli	a5,a0,0x1
     cce:	97aa                	add	a5,a5,a0
     cd0:	078e                	slli	a5,a5,0x3
     cd2:	00001517          	auipc	a0,0x1
     cd6:	a1e50513          	addi	a0,a0,-1506 # 16f0 <rings>
     cda:	97aa                	add	a5,a5,a0
     cdc:	6788                	ld	a0,8(a5)
     cde:	0521                	addi	a0,a0,8
     ce0:	00000097          	auipc	ra,0x0
     ce4:	e88080e7          	jalr	-376(ra) # b68 <load>
     ce8:	c088                	sw	a0,0(s1)
}
     cea:	60e2                	ld	ra,24(sp)
     cec:	6442                	ld	s0,16(sp)
     cee:	64a2                	ld	s1,8(sp)
     cf0:	6105                	addi	sp,sp,32
     cf2:	8082                	ret

0000000000000cf4 <ringbuf_start_read>:

////rings starting to read
void ringbuf_start_read(int ring_desc, uint64 *addr, int *bytes){ // address ta double pointer hobe
     cf4:	1101                	addi	sp,sp,-32
     cf6:	ec06                	sd	ra,24(sp)
     cf8:	e822                	sd	s0,16(sp)
     cfa:	e426                	sd	s1,8(sp)
     cfc:	1000                	addi	s0,sp,32
     cfe:	84b2                	mv	s1,a2
  if(rings[ring_desc].book -> read_done == 0){
     d00:	00151793          	slli	a5,a0,0x1
     d04:	97aa                	add	a5,a5,a0
     d06:	078e                	slli	a5,a5,0x3
     d08:	00001517          	auipc	a0,0x1
     d0c:	9e850513          	addi	a0,a0,-1560 # 16f0 <rings>
     d10:	97aa                	add	a5,a5,a0
     d12:	6788                	ld	a0,8(a5)
     d14:	611c                	ld	a5,0(a0)
     d16:	ef99                	bnez	a5,d34 <ringbuf_start_read+0x40>
    *bytes = (rings[ring_desc].book->write_done - rings[ring_desc].book->read_done);
     d18:	6518                	ld	a4,8(a0)
    *bytes /= 8;
     d1a:	41f7579b          	sraiw	a5,a4,0x1f
     d1e:	01d7d79b          	srliw	a5,a5,0x1d
     d22:	9fb9                	addw	a5,a5,a4
     d24:	4037d79b          	sraiw	a5,a5,0x3
     d28:	c21c                	sw	a5,0(a2)
  else{
    *bytes = load(&(rings[ring_desc].book->read_done));
    *bytes /= 8;
  }
  // *bytes = rings[ring_desc].book -> read_done;
}
     d2a:	60e2                	ld	ra,24(sp)
     d2c:	6442                	ld	s0,16(sp)
     d2e:	64a2                	ld	s1,8(sp)
     d30:	6105                	addi	sp,sp,32
     d32:	8082                	ret
    *bytes = load(&(rings[ring_desc].book->read_done));
     d34:	00000097          	auipc	ra,0x0
     d38:	e34080e7          	jalr	-460(ra) # b68 <load>
    *bytes /= 8;
     d3c:	41f5579b          	sraiw	a5,a0,0x1f
     d40:	01d7d79b          	srliw	a5,a5,0x1d
     d44:	9d3d                	addw	a0,a0,a5
     d46:	4035551b          	sraiw	a0,a0,0x3
     d4a:	c088                	sw	a0,0(s1)
}
     d4c:	bff9                	j	d2a <ringbuf_start_read+0x36>

0000000000000d4e <ringbuf_finish_read>:
void ringbuf_finish_read(int ring_desc, int bytes){
     d4e:	1141                	addi	sp,sp,-16
     d50:	e406                	sd	ra,8(sp)
     d52:	e022                	sd	s0,0(sp)
     d54:	0800                	addi	s0,sp,16
  //store total bytes read to the bookkeeping page 
  bytes *= 8; ////I am using uint64 to read and write, so 8 bytes are allocated per data
  store(&(rings[ring_desc].book->read_done), bytes);
     d56:	00151793          	slli	a5,a0,0x1
     d5a:	97aa                	add	a5,a5,a0
     d5c:	078e                	slli	a5,a5,0x3
     d5e:	00001517          	auipc	a0,0x1
     d62:	99250513          	addi	a0,a0,-1646 # 16f0 <rings>
     d66:	97aa                	add	a5,a5,a0
     d68:	0035959b          	slliw	a1,a1,0x3
     d6c:	6788                	ld	a0,8(a5)
     d6e:	00000097          	auipc	ra,0x0
     d72:	de6080e7          	jalr	-538(ra) # b54 <store>
}
     d76:	60a2                	ld	ra,8(sp)
     d78:	6402                	ld	s0,0(sp)
     d7a:	0141                	addi	sp,sp,16
     d7c:	8082                	ret

0000000000000d7e <strcpy>:



char*
strcpy(char *s, const char *t)
{
     d7e:	1141                	addi	sp,sp,-16
     d80:	e422                	sd	s0,8(sp)
     d82:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     d84:	87aa                	mv	a5,a0
     d86:	0585                	addi	a1,a1,1
     d88:	0785                	addi	a5,a5,1
     d8a:	fff5c703          	lbu	a4,-1(a1)
     d8e:	fee78fa3          	sb	a4,-1(a5)
     d92:	fb75                	bnez	a4,d86 <strcpy+0x8>
    ;
  return os;
}
     d94:	6422                	ld	s0,8(sp)
     d96:	0141                	addi	sp,sp,16
     d98:	8082                	ret

0000000000000d9a <strcmp>:

int
strcmp(const char *p, const char *q)
{
     d9a:	1141                	addi	sp,sp,-16
     d9c:	e422                	sd	s0,8(sp)
     d9e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
     da0:	00054783          	lbu	a5,0(a0)
     da4:	cb91                	beqz	a5,db8 <strcmp+0x1e>
     da6:	0005c703          	lbu	a4,0(a1)
     daa:	00f71763          	bne	a4,a5,db8 <strcmp+0x1e>
    p++, q++;
     dae:	0505                	addi	a0,a0,1
     db0:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
     db2:	00054783          	lbu	a5,0(a0)
     db6:	fbe5                	bnez	a5,da6 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
     db8:	0005c503          	lbu	a0,0(a1)
}
     dbc:	40a7853b          	subw	a0,a5,a0
     dc0:	6422                	ld	s0,8(sp)
     dc2:	0141                	addi	sp,sp,16
     dc4:	8082                	ret

0000000000000dc6 <strlen>:

uint
strlen(const char *s)
{
     dc6:	1141                	addi	sp,sp,-16
     dc8:	e422                	sd	s0,8(sp)
     dca:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
     dcc:	00054783          	lbu	a5,0(a0)
     dd0:	cf91                	beqz	a5,dec <strlen+0x26>
     dd2:	0505                	addi	a0,a0,1
     dd4:	87aa                	mv	a5,a0
     dd6:	4685                	li	a3,1
     dd8:	9e89                	subw	a3,a3,a0
     dda:	00f6853b          	addw	a0,a3,a5
     dde:	0785                	addi	a5,a5,1
     de0:	fff7c703          	lbu	a4,-1(a5)
     de4:	fb7d                	bnez	a4,dda <strlen+0x14>
    ;
  return n;
}
     de6:	6422                	ld	s0,8(sp)
     de8:	0141                	addi	sp,sp,16
     dea:	8082                	ret
  for(n = 0; s[n]; n++)
     dec:	4501                	li	a0,0
     dee:	bfe5                	j	de6 <strlen+0x20>

0000000000000df0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     df0:	1141                	addi	sp,sp,-16
     df2:	e422                	sd	s0,8(sp)
     df4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
     df6:	ca19                	beqz	a2,e0c <memset+0x1c>
     df8:	87aa                	mv	a5,a0
     dfa:	1602                	slli	a2,a2,0x20
     dfc:	9201                	srli	a2,a2,0x20
     dfe:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
     e02:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
     e06:	0785                	addi	a5,a5,1
     e08:	fee79de3          	bne	a5,a4,e02 <memset+0x12>
  }
  return dst;
}
     e0c:	6422                	ld	s0,8(sp)
     e0e:	0141                	addi	sp,sp,16
     e10:	8082                	ret

0000000000000e12 <strchr>:

char*
strchr(const char *s, char c)
{
     e12:	1141                	addi	sp,sp,-16
     e14:	e422                	sd	s0,8(sp)
     e16:	0800                	addi	s0,sp,16
  for(; *s; s++)
     e18:	00054783          	lbu	a5,0(a0)
     e1c:	cb99                	beqz	a5,e32 <strchr+0x20>
    if(*s == c)
     e1e:	00f58763          	beq	a1,a5,e2c <strchr+0x1a>
  for(; *s; s++)
     e22:	0505                	addi	a0,a0,1
     e24:	00054783          	lbu	a5,0(a0)
     e28:	fbfd                	bnez	a5,e1e <strchr+0xc>
      return (char*)s;
  return 0;
     e2a:	4501                	li	a0,0
}
     e2c:	6422                	ld	s0,8(sp)
     e2e:	0141                	addi	sp,sp,16
     e30:	8082                	ret
  return 0;
     e32:	4501                	li	a0,0
     e34:	bfe5                	j	e2c <strchr+0x1a>

0000000000000e36 <gets>:

char*
gets(char *buf, int max)
{
     e36:	711d                	addi	sp,sp,-96
     e38:	ec86                	sd	ra,88(sp)
     e3a:	e8a2                	sd	s0,80(sp)
     e3c:	e4a6                	sd	s1,72(sp)
     e3e:	e0ca                	sd	s2,64(sp)
     e40:	fc4e                	sd	s3,56(sp)
     e42:	f852                	sd	s4,48(sp)
     e44:	f456                	sd	s5,40(sp)
     e46:	f05a                	sd	s6,32(sp)
     e48:	ec5e                	sd	s7,24(sp)
     e4a:	1080                	addi	s0,sp,96
     e4c:	8baa                	mv	s7,a0
     e4e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     e50:	892a                	mv	s2,a0
     e52:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     e54:	4aa9                	li	s5,10
     e56:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
     e58:	89a6                	mv	s3,s1
     e5a:	2485                	addiw	s1,s1,1
     e5c:	0344d863          	bge	s1,s4,e8c <gets+0x56>
    cc = read(0, &c, 1);
     e60:	4605                	li	a2,1
     e62:	faf40593          	addi	a1,s0,-81
     e66:	4501                	li	a0,0
     e68:	00000097          	auipc	ra,0x0
     e6c:	19c080e7          	jalr	412(ra) # 1004 <read>
    if(cc < 1)
     e70:	00a05e63          	blez	a0,e8c <gets+0x56>
    buf[i++] = c;
     e74:	faf44783          	lbu	a5,-81(s0)
     e78:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
     e7c:	01578763          	beq	a5,s5,e8a <gets+0x54>
     e80:	0905                	addi	s2,s2,1
     e82:	fd679be3          	bne	a5,s6,e58 <gets+0x22>
  for(i=0; i+1 < max; ){
     e86:	89a6                	mv	s3,s1
     e88:	a011                	j	e8c <gets+0x56>
     e8a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
     e8c:	99de                	add	s3,s3,s7
     e8e:	00098023          	sb	zero,0(s3)
  return buf;
}
     e92:	855e                	mv	a0,s7
     e94:	60e6                	ld	ra,88(sp)
     e96:	6446                	ld	s0,80(sp)
     e98:	64a6                	ld	s1,72(sp)
     e9a:	6906                	ld	s2,64(sp)
     e9c:	79e2                	ld	s3,56(sp)
     e9e:	7a42                	ld	s4,48(sp)
     ea0:	7aa2                	ld	s5,40(sp)
     ea2:	7b02                	ld	s6,32(sp)
     ea4:	6be2                	ld	s7,24(sp)
     ea6:	6125                	addi	sp,sp,96
     ea8:	8082                	ret

0000000000000eaa <stat>:

int
stat(const char *n, struct stat *st)
{
     eaa:	1101                	addi	sp,sp,-32
     eac:	ec06                	sd	ra,24(sp)
     eae:	e822                	sd	s0,16(sp)
     eb0:	e426                	sd	s1,8(sp)
     eb2:	e04a                	sd	s2,0(sp)
     eb4:	1000                	addi	s0,sp,32
     eb6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     eb8:	4581                	li	a1,0
     eba:	00000097          	auipc	ra,0x0
     ebe:	172080e7          	jalr	370(ra) # 102c <open>
  if(fd < 0)
     ec2:	02054563          	bltz	a0,eec <stat+0x42>
     ec6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
     ec8:	85ca                	mv	a1,s2
     eca:	00000097          	auipc	ra,0x0
     ece:	17a080e7          	jalr	378(ra) # 1044 <fstat>
     ed2:	892a                	mv	s2,a0
  close(fd);
     ed4:	8526                	mv	a0,s1
     ed6:	00000097          	auipc	ra,0x0
     eda:	13e080e7          	jalr	318(ra) # 1014 <close>
  return r;
}
     ede:	854a                	mv	a0,s2
     ee0:	60e2                	ld	ra,24(sp)
     ee2:	6442                	ld	s0,16(sp)
     ee4:	64a2                	ld	s1,8(sp)
     ee6:	6902                	ld	s2,0(sp)
     ee8:	6105                	addi	sp,sp,32
     eea:	8082                	ret
    return -1;
     eec:	597d                	li	s2,-1
     eee:	bfc5                	j	ede <stat+0x34>

0000000000000ef0 <atoi>:

int
atoi(const char *s)
{
     ef0:	1141                	addi	sp,sp,-16
     ef2:	e422                	sd	s0,8(sp)
     ef4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ef6:	00054603          	lbu	a2,0(a0)
     efa:	fd06079b          	addiw	a5,a2,-48
     efe:	0ff7f793          	zext.b	a5,a5
     f02:	4725                	li	a4,9
     f04:	02f76963          	bltu	a4,a5,f36 <atoi+0x46>
     f08:	86aa                	mv	a3,a0
  n = 0;
     f0a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
     f0c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
     f0e:	0685                	addi	a3,a3,1
     f10:	0025179b          	slliw	a5,a0,0x2
     f14:	9fa9                	addw	a5,a5,a0
     f16:	0017979b          	slliw	a5,a5,0x1
     f1a:	9fb1                	addw	a5,a5,a2
     f1c:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
     f20:	0006c603          	lbu	a2,0(a3)
     f24:	fd06071b          	addiw	a4,a2,-48
     f28:	0ff77713          	zext.b	a4,a4
     f2c:	fee5f1e3          	bgeu	a1,a4,f0e <atoi+0x1e>
  return n;
}
     f30:	6422                	ld	s0,8(sp)
     f32:	0141                	addi	sp,sp,16
     f34:	8082                	ret
  n = 0;
     f36:	4501                	li	a0,0
     f38:	bfe5                	j	f30 <atoi+0x40>

0000000000000f3a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     f3a:	1141                	addi	sp,sp,-16
     f3c:	e422                	sd	s0,8(sp)
     f3e:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
     f40:	02b57463          	bgeu	a0,a1,f68 <memmove+0x2e>
    while(n-- > 0)
     f44:	00c05f63          	blez	a2,f62 <memmove+0x28>
     f48:	1602                	slli	a2,a2,0x20
     f4a:	9201                	srli	a2,a2,0x20
     f4c:	00c507b3          	add	a5,a0,a2
  dst = vdst;
     f50:	872a                	mv	a4,a0
      *dst++ = *src++;
     f52:	0585                	addi	a1,a1,1
     f54:	0705                	addi	a4,a4,1
     f56:	fff5c683          	lbu	a3,-1(a1)
     f5a:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
     f5e:	fee79ae3          	bne	a5,a4,f52 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
     f62:	6422                	ld	s0,8(sp)
     f64:	0141                	addi	sp,sp,16
     f66:	8082                	ret
    dst += n;
     f68:	00c50733          	add	a4,a0,a2
    src += n;
     f6c:	95b2                	add	a1,a1,a2
    while(n-- > 0)
     f6e:	fec05ae3          	blez	a2,f62 <memmove+0x28>
     f72:	fff6079b          	addiw	a5,a2,-1
     f76:	1782                	slli	a5,a5,0x20
     f78:	9381                	srli	a5,a5,0x20
     f7a:	fff7c793          	not	a5,a5
     f7e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
     f80:	15fd                	addi	a1,a1,-1
     f82:	177d                	addi	a4,a4,-1
     f84:	0005c683          	lbu	a3,0(a1)
     f88:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
     f8c:	fee79ae3          	bne	a5,a4,f80 <memmove+0x46>
     f90:	bfc9                	j	f62 <memmove+0x28>

0000000000000f92 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     f92:	1141                	addi	sp,sp,-16
     f94:	e422                	sd	s0,8(sp)
     f96:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
     f98:	ca05                	beqz	a2,fc8 <memcmp+0x36>
     f9a:	fff6069b          	addiw	a3,a2,-1
     f9e:	1682                	slli	a3,a3,0x20
     fa0:	9281                	srli	a3,a3,0x20
     fa2:	0685                	addi	a3,a3,1
     fa4:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
     fa6:	00054783          	lbu	a5,0(a0)
     faa:	0005c703          	lbu	a4,0(a1)
     fae:	00e79863          	bne	a5,a4,fbe <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
     fb2:	0505                	addi	a0,a0,1
    p2++;
     fb4:	0585                	addi	a1,a1,1
  while (n-- > 0) {
     fb6:	fed518e3          	bne	a0,a3,fa6 <memcmp+0x14>
  }
  return 0;
     fba:	4501                	li	a0,0
     fbc:	a019                	j	fc2 <memcmp+0x30>
      return *p1 - *p2;
     fbe:	40e7853b          	subw	a0,a5,a4
}
     fc2:	6422                	ld	s0,8(sp)
     fc4:	0141                	addi	sp,sp,16
     fc6:	8082                	ret
  return 0;
     fc8:	4501                	li	a0,0
     fca:	bfe5                	j	fc2 <memcmp+0x30>

0000000000000fcc <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     fcc:	1141                	addi	sp,sp,-16
     fce:	e406                	sd	ra,8(sp)
     fd0:	e022                	sd	s0,0(sp)
     fd2:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
     fd4:	00000097          	auipc	ra,0x0
     fd8:	f66080e7          	jalr	-154(ra) # f3a <memmove>
}
     fdc:	60a2                	ld	ra,8(sp)
     fde:	6402                	ld	s0,0(sp)
     fe0:	0141                	addi	sp,sp,16
     fe2:	8082                	ret

0000000000000fe4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     fe4:	4885                	li	a7,1
 ecall
     fe6:	00000073          	ecall
 ret
     fea:	8082                	ret

0000000000000fec <exit>:
.global exit
exit:
 li a7, SYS_exit
     fec:	4889                	li	a7,2
 ecall
     fee:	00000073          	ecall
 ret
     ff2:	8082                	ret

0000000000000ff4 <wait>:
.global wait
wait:
 li a7, SYS_wait
     ff4:	488d                	li	a7,3
 ecall
     ff6:	00000073          	ecall
 ret
     ffa:	8082                	ret

0000000000000ffc <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     ffc:	4891                	li	a7,4
 ecall
     ffe:	00000073          	ecall
 ret
    1002:	8082                	ret

0000000000001004 <read>:
.global read
read:
 li a7, SYS_read
    1004:	4895                	li	a7,5
 ecall
    1006:	00000073          	ecall
 ret
    100a:	8082                	ret

000000000000100c <write>:
.global write
write:
 li a7, SYS_write
    100c:	48c1                	li	a7,16
 ecall
    100e:	00000073          	ecall
 ret
    1012:	8082                	ret

0000000000001014 <close>:
.global close
close:
 li a7, SYS_close
    1014:	48d5                	li	a7,21
 ecall
    1016:	00000073          	ecall
 ret
    101a:	8082                	ret

000000000000101c <kill>:
.global kill
kill:
 li a7, SYS_kill
    101c:	4899                	li	a7,6
 ecall
    101e:	00000073          	ecall
 ret
    1022:	8082                	ret

0000000000001024 <exec>:
.global exec
exec:
 li a7, SYS_exec
    1024:	489d                	li	a7,7
 ecall
    1026:	00000073          	ecall
 ret
    102a:	8082                	ret

000000000000102c <open>:
.global open
open:
 li a7, SYS_open
    102c:	48bd                	li	a7,15
 ecall
    102e:	00000073          	ecall
 ret
    1032:	8082                	ret

0000000000001034 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    1034:	48c5                	li	a7,17
 ecall
    1036:	00000073          	ecall
 ret
    103a:	8082                	ret

000000000000103c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    103c:	48c9                	li	a7,18
 ecall
    103e:	00000073          	ecall
 ret
    1042:	8082                	ret

0000000000001044 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    1044:	48a1                	li	a7,8
 ecall
    1046:	00000073          	ecall
 ret
    104a:	8082                	ret

000000000000104c <link>:
.global link
link:
 li a7, SYS_link
    104c:	48cd                	li	a7,19
 ecall
    104e:	00000073          	ecall
 ret
    1052:	8082                	ret

0000000000001054 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    1054:	48d1                	li	a7,20
 ecall
    1056:	00000073          	ecall
 ret
    105a:	8082                	ret

000000000000105c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    105c:	48a5                	li	a7,9
 ecall
    105e:	00000073          	ecall
 ret
    1062:	8082                	ret

0000000000001064 <dup>:
.global dup
dup:
 li a7, SYS_dup
    1064:	48a9                	li	a7,10
 ecall
    1066:	00000073          	ecall
 ret
    106a:	8082                	ret

000000000000106c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    106c:	48ad                	li	a7,11
 ecall
    106e:	00000073          	ecall
 ret
    1072:	8082                	ret

0000000000001074 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    1074:	48b1                	li	a7,12
 ecall
    1076:	00000073          	ecall
 ret
    107a:	8082                	ret

000000000000107c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    107c:	48b5                	li	a7,13
 ecall
    107e:	00000073          	ecall
 ret
    1082:	8082                	ret

0000000000001084 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    1084:	48b9                	li	a7,14
 ecall
    1086:	00000073          	ecall
 ret
    108a:	8082                	ret

000000000000108c <ringbuf>:
.global ringbuf
ringbuf:
 li a7, SYS_ringbuf
    108c:	48d9                	li	a7,22
 ecall
    108e:	00000073          	ecall
 ret
    1092:	8082                	ret

0000000000001094 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    1094:	1101                	addi	sp,sp,-32
    1096:	ec06                	sd	ra,24(sp)
    1098:	e822                	sd	s0,16(sp)
    109a:	1000                	addi	s0,sp,32
    109c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    10a0:	4605                	li	a2,1
    10a2:	fef40593          	addi	a1,s0,-17
    10a6:	00000097          	auipc	ra,0x0
    10aa:	f66080e7          	jalr	-154(ra) # 100c <write>
}
    10ae:	60e2                	ld	ra,24(sp)
    10b0:	6442                	ld	s0,16(sp)
    10b2:	6105                	addi	sp,sp,32
    10b4:	8082                	ret

00000000000010b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    10b6:	7139                	addi	sp,sp,-64
    10b8:	fc06                	sd	ra,56(sp)
    10ba:	f822                	sd	s0,48(sp)
    10bc:	f426                	sd	s1,40(sp)
    10be:	f04a                	sd	s2,32(sp)
    10c0:	ec4e                	sd	s3,24(sp)
    10c2:	0080                	addi	s0,sp,64
    10c4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    10c6:	c299                	beqz	a3,10cc <printint+0x16>
    10c8:	0805c863          	bltz	a1,1158 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    10cc:	2581                	sext.w	a1,a1
  neg = 0;
    10ce:	4881                	li	a7,0
    10d0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    10d4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    10d6:	2601                	sext.w	a2,a2
    10d8:	00000517          	auipc	a0,0x0
    10dc:	58050513          	addi	a0,a0,1408 # 1658 <digits>
    10e0:	883a                	mv	a6,a4
    10e2:	2705                	addiw	a4,a4,1
    10e4:	02c5f7bb          	remuw	a5,a1,a2
    10e8:	1782                	slli	a5,a5,0x20
    10ea:	9381                	srli	a5,a5,0x20
    10ec:	97aa                	add	a5,a5,a0
    10ee:	0007c783          	lbu	a5,0(a5)
    10f2:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    10f6:	0005879b          	sext.w	a5,a1
    10fa:	02c5d5bb          	divuw	a1,a1,a2
    10fe:	0685                	addi	a3,a3,1
    1100:	fec7f0e3          	bgeu	a5,a2,10e0 <printint+0x2a>
  if(neg)
    1104:	00088b63          	beqz	a7,111a <printint+0x64>
    buf[i++] = '-';
    1108:	fd040793          	addi	a5,s0,-48
    110c:	973e                	add	a4,a4,a5
    110e:	02d00793          	li	a5,45
    1112:	fef70823          	sb	a5,-16(a4)
    1116:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    111a:	02e05863          	blez	a4,114a <printint+0x94>
    111e:	fc040793          	addi	a5,s0,-64
    1122:	00e78933          	add	s2,a5,a4
    1126:	fff78993          	addi	s3,a5,-1
    112a:	99ba                	add	s3,s3,a4
    112c:	377d                	addiw	a4,a4,-1
    112e:	1702                	slli	a4,a4,0x20
    1130:	9301                	srli	a4,a4,0x20
    1132:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    1136:	fff94583          	lbu	a1,-1(s2)
    113a:	8526                	mv	a0,s1
    113c:	00000097          	auipc	ra,0x0
    1140:	f58080e7          	jalr	-168(ra) # 1094 <putc>
  while(--i >= 0)
    1144:	197d                	addi	s2,s2,-1
    1146:	ff3918e3          	bne	s2,s3,1136 <printint+0x80>
}
    114a:	70e2                	ld	ra,56(sp)
    114c:	7442                	ld	s0,48(sp)
    114e:	74a2                	ld	s1,40(sp)
    1150:	7902                	ld	s2,32(sp)
    1152:	69e2                	ld	s3,24(sp)
    1154:	6121                	addi	sp,sp,64
    1156:	8082                	ret
    x = -xx;
    1158:	40b005bb          	negw	a1,a1
    neg = 1;
    115c:	4885                	li	a7,1
    x = -xx;
    115e:	bf8d                	j	10d0 <printint+0x1a>

0000000000001160 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    1160:	7119                	addi	sp,sp,-128
    1162:	fc86                	sd	ra,120(sp)
    1164:	f8a2                	sd	s0,112(sp)
    1166:	f4a6                	sd	s1,104(sp)
    1168:	f0ca                	sd	s2,96(sp)
    116a:	ecce                	sd	s3,88(sp)
    116c:	e8d2                	sd	s4,80(sp)
    116e:	e4d6                	sd	s5,72(sp)
    1170:	e0da                	sd	s6,64(sp)
    1172:	fc5e                	sd	s7,56(sp)
    1174:	f862                	sd	s8,48(sp)
    1176:	f466                	sd	s9,40(sp)
    1178:	f06a                	sd	s10,32(sp)
    117a:	ec6e                	sd	s11,24(sp)
    117c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    117e:	0005c903          	lbu	s2,0(a1)
    1182:	18090f63          	beqz	s2,1320 <vprintf+0x1c0>
    1186:	8aaa                	mv	s5,a0
    1188:	8b32                	mv	s6,a2
    118a:	00158493          	addi	s1,a1,1
  state = 0;
    118e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    1190:	02500a13          	li	s4,37
      if(c == 'd'){
    1194:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    1198:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    119c:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    11a0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    11a4:	00000b97          	auipc	s7,0x0
    11a8:	4b4b8b93          	addi	s7,s7,1204 # 1658 <digits>
    11ac:	a839                	j	11ca <vprintf+0x6a>
        putc(fd, c);
    11ae:	85ca                	mv	a1,s2
    11b0:	8556                	mv	a0,s5
    11b2:	00000097          	auipc	ra,0x0
    11b6:	ee2080e7          	jalr	-286(ra) # 1094 <putc>
    11ba:	a019                	j	11c0 <vprintf+0x60>
    } else if(state == '%'){
    11bc:	01498f63          	beq	s3,s4,11da <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    11c0:	0485                	addi	s1,s1,1
    11c2:	fff4c903          	lbu	s2,-1(s1)
    11c6:	14090d63          	beqz	s2,1320 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    11ca:	0009079b          	sext.w	a5,s2
    if(state == 0){
    11ce:	fe0997e3          	bnez	s3,11bc <vprintf+0x5c>
      if(c == '%'){
    11d2:	fd479ee3          	bne	a5,s4,11ae <vprintf+0x4e>
        state = '%';
    11d6:	89be                	mv	s3,a5
    11d8:	b7e5                	j	11c0 <vprintf+0x60>
      if(c == 'd'){
    11da:	05878063          	beq	a5,s8,121a <vprintf+0xba>
      } else if(c == 'l') {
    11de:	05978c63          	beq	a5,s9,1236 <vprintf+0xd6>
      } else if(c == 'x') {
    11e2:	07a78863          	beq	a5,s10,1252 <vprintf+0xf2>
      } else if(c == 'p') {
    11e6:	09b78463          	beq	a5,s11,126e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    11ea:	07300713          	li	a4,115
    11ee:	0ce78663          	beq	a5,a4,12ba <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    11f2:	06300713          	li	a4,99
    11f6:	0ee78e63          	beq	a5,a4,12f2 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    11fa:	11478863          	beq	a5,s4,130a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    11fe:	85d2                	mv	a1,s4
    1200:	8556                	mv	a0,s5
    1202:	00000097          	auipc	ra,0x0
    1206:	e92080e7          	jalr	-366(ra) # 1094 <putc>
        putc(fd, c);
    120a:	85ca                	mv	a1,s2
    120c:	8556                	mv	a0,s5
    120e:	00000097          	auipc	ra,0x0
    1212:	e86080e7          	jalr	-378(ra) # 1094 <putc>
      }
      state = 0;
    1216:	4981                	li	s3,0
    1218:	b765                	j	11c0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    121a:	008b0913          	addi	s2,s6,8
    121e:	4685                	li	a3,1
    1220:	4629                	li	a2,10
    1222:	000b2583          	lw	a1,0(s6)
    1226:	8556                	mv	a0,s5
    1228:	00000097          	auipc	ra,0x0
    122c:	e8e080e7          	jalr	-370(ra) # 10b6 <printint>
    1230:	8b4a                	mv	s6,s2
      state = 0;
    1232:	4981                	li	s3,0
    1234:	b771                	j	11c0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    1236:	008b0913          	addi	s2,s6,8
    123a:	4681                	li	a3,0
    123c:	4629                	li	a2,10
    123e:	000b2583          	lw	a1,0(s6)
    1242:	8556                	mv	a0,s5
    1244:	00000097          	auipc	ra,0x0
    1248:	e72080e7          	jalr	-398(ra) # 10b6 <printint>
    124c:	8b4a                	mv	s6,s2
      state = 0;
    124e:	4981                	li	s3,0
    1250:	bf85                	j	11c0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    1252:	008b0913          	addi	s2,s6,8
    1256:	4681                	li	a3,0
    1258:	4641                	li	a2,16
    125a:	000b2583          	lw	a1,0(s6)
    125e:	8556                	mv	a0,s5
    1260:	00000097          	auipc	ra,0x0
    1264:	e56080e7          	jalr	-426(ra) # 10b6 <printint>
    1268:	8b4a                	mv	s6,s2
      state = 0;
    126a:	4981                	li	s3,0
    126c:	bf91                	j	11c0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    126e:	008b0793          	addi	a5,s6,8
    1272:	f8f43423          	sd	a5,-120(s0)
    1276:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    127a:	03000593          	li	a1,48
    127e:	8556                	mv	a0,s5
    1280:	00000097          	auipc	ra,0x0
    1284:	e14080e7          	jalr	-492(ra) # 1094 <putc>
  putc(fd, 'x');
    1288:	85ea                	mv	a1,s10
    128a:	8556                	mv	a0,s5
    128c:	00000097          	auipc	ra,0x0
    1290:	e08080e7          	jalr	-504(ra) # 1094 <putc>
    1294:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    1296:	03c9d793          	srli	a5,s3,0x3c
    129a:	97de                	add	a5,a5,s7
    129c:	0007c583          	lbu	a1,0(a5)
    12a0:	8556                	mv	a0,s5
    12a2:	00000097          	auipc	ra,0x0
    12a6:	df2080e7          	jalr	-526(ra) # 1094 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    12aa:	0992                	slli	s3,s3,0x4
    12ac:	397d                	addiw	s2,s2,-1
    12ae:	fe0914e3          	bnez	s2,1296 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    12b2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    12b6:	4981                	li	s3,0
    12b8:	b721                	j	11c0 <vprintf+0x60>
        s = va_arg(ap, char*);
    12ba:	008b0993          	addi	s3,s6,8
    12be:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    12c2:	02090163          	beqz	s2,12e4 <vprintf+0x184>
        while(*s != 0){
    12c6:	00094583          	lbu	a1,0(s2)
    12ca:	c9a1                	beqz	a1,131a <vprintf+0x1ba>
          putc(fd, *s);
    12cc:	8556                	mv	a0,s5
    12ce:	00000097          	auipc	ra,0x0
    12d2:	dc6080e7          	jalr	-570(ra) # 1094 <putc>
          s++;
    12d6:	0905                	addi	s2,s2,1
        while(*s != 0){
    12d8:	00094583          	lbu	a1,0(s2)
    12dc:	f9e5                	bnez	a1,12cc <vprintf+0x16c>
        s = va_arg(ap, char*);
    12de:	8b4e                	mv	s6,s3
      state = 0;
    12e0:	4981                	li	s3,0
    12e2:	bdf9                	j	11c0 <vprintf+0x60>
          s = "(null)";
    12e4:	00000917          	auipc	s2,0x0
    12e8:	36c90913          	addi	s2,s2,876 # 1650 <malloc+0x226>
        while(*s != 0){
    12ec:	02800593          	li	a1,40
    12f0:	bff1                	j	12cc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    12f2:	008b0913          	addi	s2,s6,8
    12f6:	000b4583          	lbu	a1,0(s6)
    12fa:	8556                	mv	a0,s5
    12fc:	00000097          	auipc	ra,0x0
    1300:	d98080e7          	jalr	-616(ra) # 1094 <putc>
    1304:	8b4a                	mv	s6,s2
      state = 0;
    1306:	4981                	li	s3,0
    1308:	bd65                	j	11c0 <vprintf+0x60>
        putc(fd, c);
    130a:	85d2                	mv	a1,s4
    130c:	8556                	mv	a0,s5
    130e:	00000097          	auipc	ra,0x0
    1312:	d86080e7          	jalr	-634(ra) # 1094 <putc>
      state = 0;
    1316:	4981                	li	s3,0
    1318:	b565                	j	11c0 <vprintf+0x60>
        s = va_arg(ap, char*);
    131a:	8b4e                	mv	s6,s3
      state = 0;
    131c:	4981                	li	s3,0
    131e:	b54d                	j	11c0 <vprintf+0x60>
    }
  }
}
    1320:	70e6                	ld	ra,120(sp)
    1322:	7446                	ld	s0,112(sp)
    1324:	74a6                	ld	s1,104(sp)
    1326:	7906                	ld	s2,96(sp)
    1328:	69e6                	ld	s3,88(sp)
    132a:	6a46                	ld	s4,80(sp)
    132c:	6aa6                	ld	s5,72(sp)
    132e:	6b06                	ld	s6,64(sp)
    1330:	7be2                	ld	s7,56(sp)
    1332:	7c42                	ld	s8,48(sp)
    1334:	7ca2                	ld	s9,40(sp)
    1336:	7d02                	ld	s10,32(sp)
    1338:	6de2                	ld	s11,24(sp)
    133a:	6109                	addi	sp,sp,128
    133c:	8082                	ret

000000000000133e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    133e:	715d                	addi	sp,sp,-80
    1340:	ec06                	sd	ra,24(sp)
    1342:	e822                	sd	s0,16(sp)
    1344:	1000                	addi	s0,sp,32
    1346:	e010                	sd	a2,0(s0)
    1348:	e414                	sd	a3,8(s0)
    134a:	e818                	sd	a4,16(s0)
    134c:	ec1c                	sd	a5,24(s0)
    134e:	03043023          	sd	a6,32(s0)
    1352:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    1356:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    135a:	8622                	mv	a2,s0
    135c:	00000097          	auipc	ra,0x0
    1360:	e04080e7          	jalr	-508(ra) # 1160 <vprintf>
}
    1364:	60e2                	ld	ra,24(sp)
    1366:	6442                	ld	s0,16(sp)
    1368:	6161                	addi	sp,sp,80
    136a:	8082                	ret

000000000000136c <printf>:

void
printf(const char *fmt, ...)
{
    136c:	711d                	addi	sp,sp,-96
    136e:	ec06                	sd	ra,24(sp)
    1370:	e822                	sd	s0,16(sp)
    1372:	1000                	addi	s0,sp,32
    1374:	e40c                	sd	a1,8(s0)
    1376:	e810                	sd	a2,16(s0)
    1378:	ec14                	sd	a3,24(s0)
    137a:	f018                	sd	a4,32(s0)
    137c:	f41c                	sd	a5,40(s0)
    137e:	03043823          	sd	a6,48(s0)
    1382:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    1386:	00840613          	addi	a2,s0,8
    138a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    138e:	85aa                	mv	a1,a0
    1390:	4505                	li	a0,1
    1392:	00000097          	auipc	ra,0x0
    1396:	dce080e7          	jalr	-562(ra) # 1160 <vprintf>
}
    139a:	60e2                	ld	ra,24(sp)
    139c:	6442                	ld	s0,16(sp)
    139e:	6125                	addi	sp,sp,96
    13a0:	8082                	ret

00000000000013a2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    13a2:	1141                	addi	sp,sp,-16
    13a4:	e422                	sd	s0,8(sp)
    13a6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    13a8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13ac:	00000797          	auipc	a5,0x0
    13b0:	2d47b783          	ld	a5,724(a5) # 1680 <freep>
    13b4:	a805                	j	13e4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    13b6:	4618                	lw	a4,8(a2)
    13b8:	9db9                	addw	a1,a1,a4
    13ba:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    13be:	6398                	ld	a4,0(a5)
    13c0:	6318                	ld	a4,0(a4)
    13c2:	fee53823          	sd	a4,-16(a0)
    13c6:	a091                	j	140a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    13c8:	ff852703          	lw	a4,-8(a0)
    13cc:	9e39                	addw	a2,a2,a4
    13ce:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    13d0:	ff053703          	ld	a4,-16(a0)
    13d4:	e398                	sd	a4,0(a5)
    13d6:	a099                	j	141c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13d8:	6398                	ld	a4,0(a5)
    13da:	00e7e463          	bltu	a5,a4,13e2 <free+0x40>
    13de:	00e6ea63          	bltu	a3,a4,13f2 <free+0x50>
{
    13e2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13e4:	fed7fae3          	bgeu	a5,a3,13d8 <free+0x36>
    13e8:	6398                	ld	a4,0(a5)
    13ea:	00e6e463          	bltu	a3,a4,13f2 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13ee:	fee7eae3          	bltu	a5,a4,13e2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    13f2:	ff852583          	lw	a1,-8(a0)
    13f6:	6390                	ld	a2,0(a5)
    13f8:	02059813          	slli	a6,a1,0x20
    13fc:	01c85713          	srli	a4,a6,0x1c
    1400:	9736                	add	a4,a4,a3
    1402:	fae60ae3          	beq	a2,a4,13b6 <free+0x14>
    bp->s.ptr = p->s.ptr;
    1406:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    140a:	4790                	lw	a2,8(a5)
    140c:	02061593          	slli	a1,a2,0x20
    1410:	01c5d713          	srli	a4,a1,0x1c
    1414:	973e                	add	a4,a4,a5
    1416:	fae689e3          	beq	a3,a4,13c8 <free+0x26>
  } else
    p->s.ptr = bp;
    141a:	e394                	sd	a3,0(a5)
  freep = p;
    141c:	00000717          	auipc	a4,0x0
    1420:	26f73223          	sd	a5,612(a4) # 1680 <freep>
}
    1424:	6422                	ld	s0,8(sp)
    1426:	0141                	addi	sp,sp,16
    1428:	8082                	ret

000000000000142a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    142a:	7139                	addi	sp,sp,-64
    142c:	fc06                	sd	ra,56(sp)
    142e:	f822                	sd	s0,48(sp)
    1430:	f426                	sd	s1,40(sp)
    1432:	f04a                	sd	s2,32(sp)
    1434:	ec4e                	sd	s3,24(sp)
    1436:	e852                	sd	s4,16(sp)
    1438:	e456                	sd	s5,8(sp)
    143a:	e05a                	sd	s6,0(sp)
    143c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    143e:	02051493          	slli	s1,a0,0x20
    1442:	9081                	srli	s1,s1,0x20
    1444:	04bd                	addi	s1,s1,15
    1446:	8091                	srli	s1,s1,0x4
    1448:	0014899b          	addiw	s3,s1,1
    144c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    144e:	00000517          	auipc	a0,0x0
    1452:	23253503          	ld	a0,562(a0) # 1680 <freep>
    1456:	c515                	beqz	a0,1482 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1458:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    145a:	4798                	lw	a4,8(a5)
    145c:	02977f63          	bgeu	a4,s1,149a <malloc+0x70>
    1460:	8a4e                	mv	s4,s3
    1462:	0009871b          	sext.w	a4,s3
    1466:	6685                	lui	a3,0x1
    1468:	00d77363          	bgeu	a4,a3,146e <malloc+0x44>
    146c:	6a05                	lui	s4,0x1
    146e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    1472:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1476:	00000917          	auipc	s2,0x0
    147a:	20a90913          	addi	s2,s2,522 # 1680 <freep>
  if(p == (char*)-1)
    147e:	5afd                	li	s5,-1
    1480:	a895                	j	14f4 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    1482:	00000797          	auipc	a5,0x0
    1486:	35e78793          	addi	a5,a5,862 # 17e0 <base>
    148a:	00000717          	auipc	a4,0x0
    148e:	1ef73b23          	sd	a5,502(a4) # 1680 <freep>
    1492:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    1494:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    1498:	b7e1                	j	1460 <malloc+0x36>
      if(p->s.size == nunits)
    149a:	02e48c63          	beq	s1,a4,14d2 <malloc+0xa8>
        p->s.size -= nunits;
    149e:	4137073b          	subw	a4,a4,s3
    14a2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    14a4:	02071693          	slli	a3,a4,0x20
    14a8:	01c6d713          	srli	a4,a3,0x1c
    14ac:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    14ae:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    14b2:	00000717          	auipc	a4,0x0
    14b6:	1ca73723          	sd	a0,462(a4) # 1680 <freep>
      return (void*)(p + 1);
    14ba:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    14be:	70e2                	ld	ra,56(sp)
    14c0:	7442                	ld	s0,48(sp)
    14c2:	74a2                	ld	s1,40(sp)
    14c4:	7902                	ld	s2,32(sp)
    14c6:	69e2                	ld	s3,24(sp)
    14c8:	6a42                	ld	s4,16(sp)
    14ca:	6aa2                	ld	s5,8(sp)
    14cc:	6b02                	ld	s6,0(sp)
    14ce:	6121                	addi	sp,sp,64
    14d0:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    14d2:	6398                	ld	a4,0(a5)
    14d4:	e118                	sd	a4,0(a0)
    14d6:	bff1                	j	14b2 <malloc+0x88>
  hp->s.size = nu;
    14d8:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    14dc:	0541                	addi	a0,a0,16
    14de:	00000097          	auipc	ra,0x0
    14e2:	ec4080e7          	jalr	-316(ra) # 13a2 <free>
  return freep;
    14e6:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    14ea:	d971                	beqz	a0,14be <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    14ec:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    14ee:	4798                	lw	a4,8(a5)
    14f0:	fa9775e3          	bgeu	a4,s1,149a <malloc+0x70>
    if(p == freep)
    14f4:	00093703          	ld	a4,0(s2)
    14f8:	853e                	mv	a0,a5
    14fa:	fef719e3          	bne	a4,a5,14ec <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    14fe:	8552                	mv	a0,s4
    1500:	00000097          	auipc	ra,0x0
    1504:	b74080e7          	jalr	-1164(ra) # 1074 <sbrk>
  if(p == (char*)-1)
    1508:	fd5518e3          	bne	a0,s5,14d8 <malloc+0xae>
        return 0;
    150c:	4501                	li	a0,0
    150e:	bf45                	j	14be <malloc+0x94>
