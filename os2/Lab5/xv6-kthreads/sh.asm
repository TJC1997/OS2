
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0e                	jmp    19 <main+0x19>
       b:	90                   	nop
       c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      10:	83 f8 02             	cmp    $0x2,%eax
      13:	0f 8f cd 00 00 00    	jg     e6 <main+0xe6>
  while((fd = open("console", O_RDWR)) >= 0){
      19:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      20:	00 
      21:	c7 04 24 f9 14 00 00 	movl   $0x14f9,(%esp)
      28:	e8 35 0e 00 00       	call   e62 <open>
      2d:	85 c0                	test   %eax,%eax
      2f:	79 df                	jns    10 <main+0x10>
      31:	eb 23                	jmp    56 <main+0x56>
      33:	90                   	nop
      34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d c2 1b 00 00 20 	cmpb   $0x20,0x1bc2
      3f:	90                   	nop
      40:	74 60                	je     a2 <main+0xa2>
      42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      48:	e8 43 01 00 00       	call   190 <fork1>
      4d:	85 c0                	test   %eax,%eax
      4f:	74 38                	je     89 <main+0x89>
      runcmd(parsecmd(buf));
    wait();
      51:	e8 d4 0d 00 00       	call   e2a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      56:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
      5d:	00 
      5e:	c7 04 24 c0 1b 00 00 	movl   $0x1bc0,(%esp)
      65:	e8 96 00 00 00       	call   100 <getcmd>
      6a:	85 c0                	test   %eax,%eax
      6c:	78 2f                	js     9d <main+0x9d>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      6e:	80 3d c0 1b 00 00 63 	cmpb   $0x63,0x1bc0
      75:	75 d1                	jne    48 <main+0x48>
      77:	80 3d c1 1b 00 00 64 	cmpb   $0x64,0x1bc1
      7e:	74 b8                	je     38 <main+0x38>
    if(fork1() == 0)
      80:	e8 0b 01 00 00       	call   190 <fork1>
      85:	85 c0                	test   %eax,%eax
      87:	75 c8                	jne    51 <main+0x51>
      runcmd(parsecmd(buf));
      89:	c7 04 24 c0 1b 00 00 	movl   $0x1bc0,(%esp)
      90:	e8 eb 0a 00 00       	call   b80 <parsecmd>
      95:	89 04 24             	mov    %eax,(%esp)
      98:	e8 13 01 00 00       	call   1b0 <runcmd>
  }
  exit();
      9d:	e8 80 0d 00 00       	call   e22 <exit>
      buf[strlen(buf)-1] = 0;  // chop \n
      a2:	c7 04 24 c0 1b 00 00 	movl   $0x1bc0,(%esp)
      a9:	e8 d2 0b 00 00       	call   c80 <strlen>
      if(chdir(buf+3) < 0)
      ae:	c7 04 24 c3 1b 00 00 	movl   $0x1bc3,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      b5:	c6 80 bf 1b 00 00 00 	movb   $0x0,0x1bbf(%eax)
      if(chdir(buf+3) < 0)
      bc:	e8 d1 0d 00 00       	call   e92 <chdir>
      c1:	85 c0                	test   %eax,%eax
      c3:	79 91                	jns    56 <main+0x56>
        printf(2, "cannot cd %s\n", buf+3);
      c5:	c7 44 24 08 c3 1b 00 	movl   $0x1bc3,0x8(%esp)
      cc:	00 
      cd:	c7 44 24 04 01 15 00 	movl   $0x1501,0x4(%esp)
      d4:	00 
      d5:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      dc:	e8 bf 0e 00 00       	call   fa0 <printf>
      e1:	e9 70 ff ff ff       	jmp    56 <main+0x56>
      close(fd);
      e6:	89 04 24             	mov    %eax,(%esp)
      e9:	e8 5c 0d 00 00       	call   e4a <close>
      ee:	66 90                	xchg   %ax,%ax
      break;
      f0:	e9 61 ff ff ff       	jmp    56 <main+0x56>
      f5:	66 90                	xchg   %ax,%ax
      f7:	66 90                	xchg   %ax,%ax
      f9:	66 90                	xchg   %ax,%ax
      fb:	66 90                	xchg   %ax,%ax
      fd:	66 90                	xchg   %ax,%ax
      ff:	90                   	nop

00000100 <getcmd>:
{
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	56                   	push   %esi
     104:	53                   	push   %ebx
     105:	83 ec 10             	sub    $0x10,%esp
     108:	8b 5d 08             	mov    0x8(%ebp),%ebx
     10b:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
     10e:	c7 44 24 04 58 14 00 	movl   $0x1458,0x4(%esp)
     115:	00 
     116:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     11d:	e8 7e 0e 00 00       	call   fa0 <printf>
  memset(buf, 0, nbuf);
     122:	89 74 24 08          	mov    %esi,0x8(%esp)
     126:	89 1c 24             	mov    %ebx,(%esp)
     129:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     130:	00 
     131:	e8 7a 0b 00 00       	call   cb0 <memset>
  gets(buf, nbuf);
     136:	89 74 24 04          	mov    %esi,0x4(%esp)
     13a:	89 1c 24             	mov    %ebx,(%esp)
     13d:	e8 ce 0b 00 00       	call   d10 <gets>
  if(buf[0] == 0) // EOF
     142:	31 c0                	xor    %eax,%eax
     144:	80 3b 00             	cmpb   $0x0,(%ebx)
     147:	0f 94 c0             	sete   %al
}
     14a:	83 c4 10             	add    $0x10,%esp
     14d:	5b                   	pop    %ebx
  if(buf[0] == 0) // EOF
     14e:	f7 d8                	neg    %eax
}
     150:	5e                   	pop    %esi
     151:	5d                   	pop    %ebp
     152:	c3                   	ret    
     153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <panic>:
}

void
panic(char *s)
{
     160:	55                   	push   %ebp
     161:	89 e5                	mov    %esp,%ebp
     163:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     166:	8b 45 08             	mov    0x8(%ebp),%eax
     169:	c7 44 24 04 f5 14 00 	movl   $0x14f5,0x4(%esp)
     170:	00 
     171:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     178:	89 44 24 08          	mov    %eax,0x8(%esp)
     17c:	e8 1f 0e 00 00       	call   fa0 <printf>
  exit();
     181:	e8 9c 0c 00 00       	call   e22 <exit>
     186:	8d 76 00             	lea    0x0(%esi),%esi
     189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <fork1>:
}

int
fork1(void)
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     196:	e8 7f 0c 00 00       	call   e1a <fork>
  if(pid == -1)
     19b:	83 f8 ff             	cmp    $0xffffffff,%eax
     19e:	74 02                	je     1a2 <fork1+0x12>
    panic("fork");
  return pid;
}
     1a0:	c9                   	leave  
     1a1:	c3                   	ret    
    panic("fork");
     1a2:	c7 04 24 5b 14 00 00 	movl   $0x145b,(%esp)
     1a9:	e8 b2 ff ff ff       	call   160 <panic>
     1ae:	66 90                	xchg   %ax,%ax

000001b0 <runcmd>:
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	57                   	push   %edi
     1b4:	56                   	push   %esi
     1b5:	53                   	push   %ebx
     1b6:	83 ec 3c             	sub    $0x3c,%esp
     1b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     1bc:	85 db                	test   %ebx,%ebx
     1be:	74 66                	je     226 <runcmd+0x76>
  switch(cmd->type){
     1c0:	83 3b 05             	cmpl   $0x5,(%ebx)
     1c3:	0f 87 25 01 00 00    	ja     2ee <runcmd+0x13e>
     1c9:	8b 03                	mov    (%ebx),%eax
     1cb:	ff 24 85 10 15 00 00 	jmp    *0x1510(,%eax,4)
    if(pipe(p) < 0)
     1d2:	8d 45 d4             	lea    -0x2c(%ebp),%eax
     1d5:	89 04 24             	mov    %eax,(%esp)
     1d8:	e8 55 0c 00 00       	call   e32 <pipe>
     1dd:	85 c0                	test   %eax,%eax
     1df:	0f 88 15 01 00 00    	js     2fa <runcmd+0x14a>
    if(fork1() == 0){
     1e5:	e8 a6 ff ff ff       	call   190 <fork1>
     1ea:	85 c0                	test   %eax,%eax
     1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1f0:	0f 84 68 01 00 00    	je     35e <runcmd+0x1ae>
    if(fork1() == 0){
     1f6:	e8 95 ff ff ff       	call   190 <fork1>
     1fb:	85 c0                	test   %eax,%eax
     1fd:	8d 76 00             	lea    0x0(%esi),%esi
     200:	0f 84 20 01 00 00    	je     326 <runcmd+0x176>
    close(p[0]);
     206:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     209:	89 04 24             	mov    %eax,(%esp)
     20c:	e8 39 0c 00 00       	call   e4a <close>
    close(p[1]);
     211:	8b 45 d8             	mov    -0x28(%ebp),%eax
     214:	89 04 24             	mov    %eax,(%esp)
     217:	e8 2e 0c 00 00       	call   e4a <close>
    wait();
     21c:	e8 09 0c 00 00       	call   e2a <wait>
    wait();
     221:	e8 04 0c 00 00       	call   e2a <wait>
      exit();
     226:	e8 f7 0b 00 00       	call   e22 <exit>
     22b:	90                   	nop
     22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fork1() == 0)
     230:	e8 5b ff ff ff       	call   190 <fork1>
     235:	85 c0                	test   %eax,%eax
     237:	75 ed                	jne    226 <runcmd+0x76>
     239:	e9 a5 00 00 00       	jmp    2e3 <runcmd+0x133>
    if(ecmd->argv[0] == 0)
     23e:	8b 43 04             	mov    0x4(%ebx),%eax
     241:	85 c0                	test   %eax,%eax
     243:	74 e1                	je     226 <runcmd+0x76>
    exec(ecmd->argv[0], ecmd->argv);
     245:	8d 73 04             	lea    0x4(%ebx),%esi
     248:	89 74 24 04          	mov    %esi,0x4(%esp)
        char c[20] = "/";
     24c:	8d 7d d8             	lea    -0x28(%ebp),%edi
    exec(ecmd->argv[0], ecmd->argv);
     24f:	89 04 24             	mov    %eax,(%esp)
     252:	e8 03 0c 00 00       	call   e5a <exec>
        char c[20] = "/";
     257:	31 c0                	xor    %eax,%eax
     259:	b9 04 00 00 00       	mov    $0x4,%ecx
     25e:	f3 ab                	rep stos %eax,%es:(%edi)
        strcpy(&c[1], ecmd->argv[0]);
     260:	8b 43 04             	mov    0x4(%ebx),%eax
     263:	8d 7d d4             	lea    -0x2c(%ebp),%edi
        char c[20] = "/";
     266:	c7 45 d4 2f 00 00 00 	movl   $0x2f,-0x2c(%ebp)
        strcpy(&c[1], ecmd->argv[0]);
     26d:	89 44 24 04          	mov    %eax,0x4(%esp)
     271:	8d 45 d5             	lea    -0x2b(%ebp),%eax
     274:	89 04 24             	mov    %eax,(%esp)
     277:	e8 84 09 00 00       	call   c00 <strcpy>
        exec(c, ecmd->argv);
     27c:	89 74 24 04          	mov    %esi,0x4(%esp)
     280:	89 3c 24             	mov    %edi,(%esp)
     283:	e8 d2 0b 00 00       	call   e5a <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     288:	8b 43 04             	mov    0x4(%ebx),%eax
     28b:	c7 44 24 04 67 14 00 	movl   $0x1467,0x4(%esp)
     292:	00 
     293:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     29a:	89 44 24 08          	mov    %eax,0x8(%esp)
     29e:	e8 fd 0c 00 00       	call   fa0 <printf>
    break;
     2a3:	eb 81                	jmp    226 <runcmd+0x76>
    if(fork1() == 0)
     2a5:	e8 e6 fe ff ff       	call   190 <fork1>
     2aa:	85 c0                	test   %eax,%eax
     2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     2b0:	74 31                	je     2e3 <runcmd+0x133>
    wait();
     2b2:	e8 73 0b 00 00       	call   e2a <wait>
    runcmd(lcmd->right);
     2b7:	8b 43 08             	mov    0x8(%ebx),%eax
     2ba:	89 04 24             	mov    %eax,(%esp)
     2bd:	e8 ee fe ff ff       	call   1b0 <runcmd>
    close(rcmd->fd);
     2c2:	8b 43 14             	mov    0x14(%ebx),%eax
     2c5:	89 04 24             	mov    %eax,(%esp)
     2c8:	e8 7d 0b 00 00       	call   e4a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     2cd:	8b 43 10             	mov    0x10(%ebx),%eax
     2d0:	89 44 24 04          	mov    %eax,0x4(%esp)
     2d4:	8b 43 08             	mov    0x8(%ebx),%eax
     2d7:	89 04 24             	mov    %eax,(%esp)
     2da:	e8 83 0b 00 00       	call   e62 <open>
     2df:	85 c0                	test   %eax,%eax
     2e1:	78 23                	js     306 <runcmd+0x156>
      runcmd(bcmd->cmd);
     2e3:	8b 43 04             	mov    0x4(%ebx),%eax
     2e6:	89 04 24             	mov    %eax,(%esp)
     2e9:	e8 c2 fe ff ff       	call   1b0 <runcmd>
    panic("runcmd");
     2ee:	c7 04 24 60 14 00 00 	movl   $0x1460,(%esp)
     2f5:	e8 66 fe ff ff       	call   160 <panic>
      panic("pipe");
     2fa:	c7 04 24 87 14 00 00 	movl   $0x1487,(%esp)
     301:	e8 5a fe ff ff       	call   160 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     306:	8b 43 08             	mov    0x8(%ebx),%eax
     309:	c7 44 24 04 77 14 00 	movl   $0x1477,0x4(%esp)
     310:	00 
     311:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     318:	89 44 24 08          	mov    %eax,0x8(%esp)
     31c:	e8 7f 0c 00 00       	call   fa0 <printf>
     321:	e9 00 ff ff ff       	jmp    226 <runcmd+0x76>
      close(0);
     326:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     32d:	e8 18 0b 00 00       	call   e4a <close>
      dup(p[0]);
     332:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     335:	89 04 24             	mov    %eax,(%esp)
     338:	e8 5d 0b 00 00       	call   e9a <dup>
      close(p[0]);
     33d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     340:	89 04 24             	mov    %eax,(%esp)
     343:	e8 02 0b 00 00       	call   e4a <close>
      close(p[1]);
     348:	8b 45 d8             	mov    -0x28(%ebp),%eax
     34b:	89 04 24             	mov    %eax,(%esp)
     34e:	e8 f7 0a 00 00       	call   e4a <close>
      runcmd(pcmd->right);
     353:	8b 43 08             	mov    0x8(%ebx),%eax
     356:	89 04 24             	mov    %eax,(%esp)
     359:	e8 52 fe ff ff       	call   1b0 <runcmd>
      close(1);
     35e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     365:	e8 e0 0a 00 00       	call   e4a <close>
      dup(p[1]);
     36a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     36d:	89 04 24             	mov    %eax,(%esp)
     370:	e8 25 0b 00 00       	call   e9a <dup>
      close(p[0]);
     375:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     378:	89 04 24             	mov    %eax,(%esp)
     37b:	e8 ca 0a 00 00       	call   e4a <close>
      close(p[1]);
     380:	8b 45 d8             	mov    -0x28(%ebp),%eax
     383:	89 04 24             	mov    %eax,(%esp)
     386:	e8 bf 0a 00 00       	call   e4a <close>
      runcmd(pcmd->left);
     38b:	8b 43 04             	mov    0x4(%ebx),%eax
     38e:	89 04 24             	mov    %eax,(%esp)
     391:	e8 1a fe ff ff       	call   1b0 <runcmd>
     396:	8d 76 00             	lea    0x0(%esi),%esi
     399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     3a0:	55                   	push   %ebp
     3a1:	89 e5                	mov    %esp,%ebp
     3a3:	53                   	push   %ebx
     3a4:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3a7:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     3ae:	e8 9d 0e 00 00       	call   1250 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3b3:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     3ba:	00 
     3bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3c2:	00 
  cmd = malloc(sizeof(*cmd));
     3c3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3c5:	89 04 24             	mov    %eax,(%esp)
     3c8:	e8 e3 08 00 00       	call   cb0 <memset>
  cmd->type = EXEC;
  return (struct cmd*)cmd;
}
     3cd:	89 d8                	mov    %ebx,%eax
  cmd->type = EXEC;
     3cf:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
}
     3d5:	83 c4 14             	add    $0x14,%esp
     3d8:	5b                   	pop    %ebx
     3d9:	5d                   	pop    %ebp
     3da:	c3                   	ret    
     3db:	90                   	nop
     3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003e0 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	53                   	push   %ebx
     3e4:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3e7:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     3ee:	e8 5d 0e 00 00       	call   1250 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3f3:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     3fa:	00 
     3fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     402:	00 
     403:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     406:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     408:	e8 a3 08 00 00       	call   cb0 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     40d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     410:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     416:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     419:	8b 45 0c             	mov    0xc(%ebp),%eax
     41c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     41f:	8b 45 10             	mov    0x10(%ebp),%eax
     422:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     425:	8b 45 14             	mov    0x14(%ebp),%eax
     428:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     42b:	8b 45 18             	mov    0x18(%ebp),%eax
     42e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     431:	83 c4 14             	add    $0x14,%esp
     434:	89 d8                	mov    %ebx,%eax
     436:	5b                   	pop    %ebx
     437:	5d                   	pop    %ebp
     438:	c3                   	ret    
     439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000440 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     447:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     44e:	e8 fd 0d 00 00       	call   1250 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     453:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     45a:	00 
     45b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     462:	00 
     463:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     466:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     468:	e8 43 08 00 00       	call   cb0 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     46d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     470:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     476:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     479:	8b 45 0c             	mov    0xc(%ebp),%eax
     47c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     47f:	83 c4 14             	add    $0x14,%esp
     482:	89 d8                	mov    %ebx,%eax
     484:	5b                   	pop    %ebx
     485:	5d                   	pop    %ebp
     486:	c3                   	ret    
     487:	89 f6                	mov    %esi,%esi
     489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000490 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	53                   	push   %ebx
     494:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     497:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     49e:	e8 ad 0d 00 00       	call   1250 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4a3:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     4aa:	00 
     4ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     4b2:	00 
     4b3:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     4b6:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     4b8:	e8 f3 07 00 00       	call   cb0 <memset>
  cmd->type = LIST;
  cmd->left = left;
     4bd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     4c0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     4c6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     4c9:	8b 45 0c             	mov    0xc(%ebp),%eax
     4cc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     4cf:	83 c4 14             	add    $0x14,%esp
     4d2:	89 d8                	mov    %ebx,%eax
     4d4:	5b                   	pop    %ebx
     4d5:	5d                   	pop    %ebp
     4d6:	c3                   	ret    
     4d7:	89 f6                	mov    %esi,%esi
     4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     4e0:	55                   	push   %ebp
     4e1:	89 e5                	mov    %esp,%ebp
     4e3:	53                   	push   %ebx
     4e4:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     4e7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     4ee:	e8 5d 0d 00 00       	call   1250 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     4f3:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     4fa:	00 
     4fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     502:	00 
     503:	89 04 24             	mov    %eax,(%esp)
  cmd = malloc(sizeof(*cmd));
     506:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     508:	e8 a3 07 00 00       	call   cb0 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     50d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     510:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     516:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     519:	83 c4 14             	add    $0x14,%esp
     51c:	89 d8                	mov    %ebx,%eax
     51e:	5b                   	pop    %ebx
     51f:	5d                   	pop    %ebp
     520:	c3                   	ret    
     521:	eb 0d                	jmp    530 <gettoken>
     523:	90                   	nop
     524:	90                   	nop
     525:	90                   	nop
     526:	90                   	nop
     527:	90                   	nop
     528:	90                   	nop
     529:	90                   	nop
     52a:	90                   	nop
     52b:	90                   	nop
     52c:	90                   	nop
     52d:	90                   	nop
     52e:	90                   	nop
     52f:	90                   	nop

00000530 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     530:	55                   	push   %ebp
     531:	89 e5                	mov    %esp,%ebp
     533:	57                   	push   %edi
     534:	56                   	push   %esi
     535:	53                   	push   %ebx
     536:	83 ec 1c             	sub    $0x1c,%esp
  char *s;
  int ret;

  s = *ps;
     539:	8b 45 08             	mov    0x8(%ebp),%eax
{
     53c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     53f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     542:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     544:	39 df                	cmp    %ebx,%edi
     546:	72 0f                	jb     557 <gettoken+0x27>
     548:	eb 24                	jmp    56e <gettoken+0x3e>
     54a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     550:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     553:	39 df                	cmp    %ebx,%edi
     555:	74 17                	je     56e <gettoken+0x3e>
     557:	0f be 07             	movsbl (%edi),%eax
     55a:	c7 04 24 a0 1b 00 00 	movl   $0x1ba0,(%esp)
     561:	89 44 24 04          	mov    %eax,0x4(%esp)
     565:	e8 66 07 00 00       	call   cd0 <strchr>
     56a:	85 c0                	test   %eax,%eax
     56c:	75 e2                	jne    550 <gettoken+0x20>
  if(q)
     56e:	85 f6                	test   %esi,%esi
     570:	74 02                	je     574 <gettoken+0x44>
    *q = s;
     572:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     574:	0f b6 0f             	movzbl (%edi),%ecx
     577:	0f be f1             	movsbl %cl,%esi
  switch(*s){
     57a:	80 f9 29             	cmp    $0x29,%cl
  ret = *s;
     57d:	89 f0                	mov    %esi,%eax
  switch(*s){
     57f:	7f 4f                	jg     5d0 <gettoken+0xa0>
     581:	80 f9 28             	cmp    $0x28,%cl
     584:	7d 55                	jge    5db <gettoken+0xab>
     586:	84 c9                	test   %cl,%cl
     588:	0f 85 ca 00 00 00    	jne    658 <gettoken+0x128>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     58e:	8b 45 14             	mov    0x14(%ebp),%eax
     591:	85 c0                	test   %eax,%eax
     593:	74 05                	je     59a <gettoken+0x6a>
    *eq = s;
     595:	8b 45 14             	mov    0x14(%ebp),%eax
     598:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     59a:	39 df                	cmp    %ebx,%edi
     59c:	72 09                	jb     5a7 <gettoken+0x77>
     59e:	eb 1e                	jmp    5be <gettoken+0x8e>
    s++;
     5a0:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     5a3:	39 df                	cmp    %ebx,%edi
     5a5:	74 17                	je     5be <gettoken+0x8e>
     5a7:	0f be 07             	movsbl (%edi),%eax
     5aa:	c7 04 24 a0 1b 00 00 	movl   $0x1ba0,(%esp)
     5b1:	89 44 24 04          	mov    %eax,0x4(%esp)
     5b5:	e8 16 07 00 00       	call   cd0 <strchr>
     5ba:	85 c0                	test   %eax,%eax
     5bc:	75 e2                	jne    5a0 <gettoken+0x70>
  *ps = s;
     5be:	8b 45 08             	mov    0x8(%ebp),%eax
     5c1:	89 38                	mov    %edi,(%eax)
  return ret;
}
     5c3:	83 c4 1c             	add    $0x1c,%esp
     5c6:	89 f0                	mov    %esi,%eax
     5c8:	5b                   	pop    %ebx
     5c9:	5e                   	pop    %esi
     5ca:	5f                   	pop    %edi
     5cb:	5d                   	pop    %ebp
     5cc:	c3                   	ret    
     5cd:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     5d0:	80 f9 3e             	cmp    $0x3e,%cl
     5d3:	75 0b                	jne    5e0 <gettoken+0xb0>
    if(*s == '>'){
     5d5:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     5d9:	74 6d                	je     648 <gettoken+0x118>
    s++;
     5db:	83 c7 01             	add    $0x1,%edi
     5de:	eb ae                	jmp    58e <gettoken+0x5e>
  switch(*s){
     5e0:	7f 56                	jg     638 <gettoken+0x108>
     5e2:	83 e9 3b             	sub    $0x3b,%ecx
     5e5:	80 f9 01             	cmp    $0x1,%cl
     5e8:	76 f1                	jbe    5db <gettoken+0xab>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     5ea:	39 fb                	cmp    %edi,%ebx
     5ec:	77 2b                	ja     619 <gettoken+0xe9>
     5ee:	66 90                	xchg   %ax,%ax
     5f0:	eb 3b                	jmp    62d <gettoken+0xfd>
     5f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     5f8:	0f be 07             	movsbl (%edi),%eax
     5fb:	c7 04 24 98 1b 00 00 	movl   $0x1b98,(%esp)
     602:	89 44 24 04          	mov    %eax,0x4(%esp)
     606:	e8 c5 06 00 00       	call   cd0 <strchr>
     60b:	85 c0                	test   %eax,%eax
     60d:	75 1e                	jne    62d <gettoken+0xfd>
      s++;
     60f:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     612:	39 df                	cmp    %ebx,%edi
     614:	74 17                	je     62d <gettoken+0xfd>
     616:	0f be 07             	movsbl (%edi),%eax
     619:	89 44 24 04          	mov    %eax,0x4(%esp)
     61d:	c7 04 24 a0 1b 00 00 	movl   $0x1ba0,(%esp)
     624:	e8 a7 06 00 00       	call   cd0 <strchr>
     629:	85 c0                	test   %eax,%eax
     62b:	74 cb                	je     5f8 <gettoken+0xc8>
    ret = 'a';
     62d:	be 61 00 00 00       	mov    $0x61,%esi
     632:	e9 57 ff ff ff       	jmp    58e <gettoken+0x5e>
     637:	90                   	nop
  switch(*s){
     638:	80 f9 7c             	cmp    $0x7c,%cl
     63b:	74 9e                	je     5db <gettoken+0xab>
     63d:	8d 76 00             	lea    0x0(%esi),%esi
     640:	eb a8                	jmp    5ea <gettoken+0xba>
     642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      s++;
     648:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     64b:	be 2b 00 00 00       	mov    $0x2b,%esi
     650:	e9 39 ff ff ff       	jmp    58e <gettoken+0x5e>
     655:	8d 76 00             	lea    0x0(%esi),%esi
  switch(*s){
     658:	80 f9 26             	cmp    $0x26,%cl
     65b:	75 8d                	jne    5ea <gettoken+0xba>
     65d:	e9 79 ff ff ff       	jmp    5db <gettoken+0xab>
     662:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000670 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	57                   	push   %edi
     674:	56                   	push   %esi
     675:	53                   	push   %ebx
     676:	83 ec 1c             	sub    $0x1c,%esp
     679:	8b 7d 08             	mov    0x8(%ebp),%edi
     67c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     67f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     681:	39 f3                	cmp    %esi,%ebx
     683:	72 0a                	jb     68f <peek+0x1f>
     685:	eb 1f                	jmp    6a6 <peek+0x36>
     687:	90                   	nop
    s++;
     688:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     68b:	39 f3                	cmp    %esi,%ebx
     68d:	74 17                	je     6a6 <peek+0x36>
     68f:	0f be 03             	movsbl (%ebx),%eax
     692:	c7 04 24 a0 1b 00 00 	movl   $0x1ba0,(%esp)
     699:	89 44 24 04          	mov    %eax,0x4(%esp)
     69d:	e8 2e 06 00 00       	call   cd0 <strchr>
     6a2:	85 c0                	test   %eax,%eax
     6a4:	75 e2                	jne    688 <peek+0x18>
  *ps = s;
     6a6:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     6a8:	0f be 13             	movsbl (%ebx),%edx
     6ab:	31 c0                	xor    %eax,%eax
     6ad:	84 d2                	test   %dl,%dl
     6af:	74 17                	je     6c8 <peek+0x58>
     6b1:	8b 45 10             	mov    0x10(%ebp),%eax
     6b4:	89 54 24 04          	mov    %edx,0x4(%esp)
     6b8:	89 04 24             	mov    %eax,(%esp)
     6bb:	e8 10 06 00 00       	call   cd0 <strchr>
     6c0:	85 c0                	test   %eax,%eax
     6c2:	0f 95 c0             	setne  %al
     6c5:	0f b6 c0             	movzbl %al,%eax
}
     6c8:	83 c4 1c             	add    $0x1c,%esp
     6cb:	5b                   	pop    %ebx
     6cc:	5e                   	pop    %esi
     6cd:	5f                   	pop    %edi
     6ce:	5d                   	pop    %ebp
     6cf:	c3                   	ret    

000006d0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	57                   	push   %edi
     6d4:	56                   	push   %esi
     6d5:	53                   	push   %ebx
     6d6:	83 ec 3c             	sub    $0x3c,%esp
     6d9:	8b 75 0c             	mov    0xc(%ebp),%esi
     6dc:	8b 5d 10             	mov    0x10(%ebp),%ebx
     6df:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     6e0:	c7 44 24 08 a9 14 00 	movl   $0x14a9,0x8(%esp)
     6e7:	00 
     6e8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     6ec:	89 34 24             	mov    %esi,(%esp)
     6ef:	e8 7c ff ff ff       	call   670 <peek>
     6f4:	85 c0                	test   %eax,%eax
     6f6:	0f 84 9c 00 00 00    	je     798 <parseredirs+0xc8>
    tok = gettoken(ps, es, 0, 0);
     6fc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     703:	00 
     704:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     70b:	00 
     70c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     710:	89 34 24             	mov    %esi,(%esp)
     713:	e8 18 fe ff ff       	call   530 <gettoken>
    if(gettoken(ps, es, &q, &eq) != 'a')
     718:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     71c:	89 34 24             	mov    %esi,(%esp)
    tok = gettoken(ps, es, 0, 0);
     71f:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     721:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     724:	89 44 24 0c          	mov    %eax,0xc(%esp)
     728:	8d 45 e0             	lea    -0x20(%ebp),%eax
     72b:	89 44 24 08          	mov    %eax,0x8(%esp)
     72f:	e8 fc fd ff ff       	call   530 <gettoken>
     734:	83 f8 61             	cmp    $0x61,%eax
     737:	75 6a                	jne    7a3 <parseredirs+0xd3>
      panic("missing file for redirection");
    switch(tok){
     739:	83 ff 3c             	cmp    $0x3c,%edi
     73c:	74 42                	je     780 <parseredirs+0xb0>
     73e:	83 ff 3e             	cmp    $0x3e,%edi
     741:	74 05                	je     748 <parseredirs+0x78>
     743:	83 ff 2b             	cmp    $0x2b,%edi
     746:	75 98                	jne    6e0 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     748:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     74f:	00 
     750:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     757:	00 
     758:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     75b:	89 44 24 08          	mov    %eax,0x8(%esp)
     75f:	8b 45 e0             	mov    -0x20(%ebp),%eax
     762:	89 44 24 04          	mov    %eax,0x4(%esp)
     766:	8b 45 08             	mov    0x8(%ebp),%eax
     769:	89 04 24             	mov    %eax,(%esp)
     76c:	e8 6f fc ff ff       	call   3e0 <redircmd>
     771:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     774:	e9 67 ff ff ff       	jmp    6e0 <parseredirs+0x10>
     779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     780:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     787:	00 
     788:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     78f:	00 
     790:	eb c6                	jmp    758 <parseredirs+0x88>
     792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    }
  }
  return cmd;
}
     798:	8b 45 08             	mov    0x8(%ebp),%eax
     79b:	83 c4 3c             	add    $0x3c,%esp
     79e:	5b                   	pop    %ebx
     79f:	5e                   	pop    %esi
     7a0:	5f                   	pop    %edi
     7a1:	5d                   	pop    %ebp
     7a2:	c3                   	ret    
      panic("missing file for redirection");
     7a3:	c7 04 24 8c 14 00 00 	movl   $0x148c,(%esp)
     7aa:	e8 b1 f9 ff ff       	call   160 <panic>
     7af:	90                   	nop

000007b0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	57                   	push   %edi
     7b4:	56                   	push   %esi
     7b5:	53                   	push   %ebx
     7b6:	83 ec 3c             	sub    $0x3c,%esp
     7b9:	8b 75 08             	mov    0x8(%ebp),%esi
     7bc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     7bf:	c7 44 24 08 ac 14 00 	movl   $0x14ac,0x8(%esp)
     7c6:	00 
     7c7:	89 34 24             	mov    %esi,(%esp)
     7ca:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7ce:	e8 9d fe ff ff       	call   670 <peek>
     7d3:	85 c0                	test   %eax,%eax
     7d5:	0f 85 a5 00 00 00    	jne    880 <parseexec+0xd0>
    return parseblock(ps, es);

  ret = execcmd();
     7db:	e8 c0 fb ff ff       	call   3a0 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     7e0:	89 7c 24 08          	mov    %edi,0x8(%esp)
     7e4:	89 74 24 04          	mov    %esi,0x4(%esp)
     7e8:	89 04 24             	mov    %eax,(%esp)
  ret = execcmd();
     7eb:	89 c3                	mov    %eax,%ebx
     7ed:	89 45 cc             	mov    %eax,-0x34(%ebp)
  ret = parseredirs(ret, ps, es);
     7f0:	e8 db fe ff ff       	call   6d0 <parseredirs>
  argc = 0;
     7f5:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  ret = parseredirs(ret, ps, es);
     7fc:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     7ff:	eb 1d                	jmp    81e <parseexec+0x6e>
     801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     808:	8b 45 d0             	mov    -0x30(%ebp),%eax
     80b:	89 7c 24 08          	mov    %edi,0x8(%esp)
     80f:	89 74 24 04          	mov    %esi,0x4(%esp)
     813:	89 04 24             	mov    %eax,(%esp)
     816:	e8 b5 fe ff ff       	call   6d0 <parseredirs>
     81b:	89 45 d0             	mov    %eax,-0x30(%ebp)
  while(!peek(ps, es, "|)&;")){
     81e:	c7 44 24 08 c3 14 00 	movl   $0x14c3,0x8(%esp)
     825:	00 
     826:	89 7c 24 04          	mov    %edi,0x4(%esp)
     82a:	89 34 24             	mov    %esi,(%esp)
     82d:	e8 3e fe ff ff       	call   670 <peek>
     832:	85 c0                	test   %eax,%eax
     834:	75 62                	jne    898 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     836:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     839:	89 44 24 0c          	mov    %eax,0xc(%esp)
     83d:	8d 45 e0             	lea    -0x20(%ebp),%eax
     840:	89 44 24 08          	mov    %eax,0x8(%esp)
     844:	89 7c 24 04          	mov    %edi,0x4(%esp)
     848:	89 34 24             	mov    %esi,(%esp)
     84b:	e8 e0 fc ff ff       	call   530 <gettoken>
     850:	85 c0                	test   %eax,%eax
     852:	74 44                	je     898 <parseexec+0xe8>
    if(tok != 'a')
     854:	83 f8 61             	cmp    $0x61,%eax
     857:	75 61                	jne    8ba <parseexec+0x10a>
    cmd->argv[argc] = q;
     859:	8b 45 e0             	mov    -0x20(%ebp),%eax
     85c:	83 c3 04             	add    $0x4,%ebx
    argc++;
     85f:	83 45 d4 01          	addl   $0x1,-0x2c(%ebp)
    cmd->argv[argc] = q;
     863:	89 03                	mov    %eax,(%ebx)
    cmd->eargv[argc] = eq;
     865:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     868:	89 43 28             	mov    %eax,0x28(%ebx)
    if(argc >= MAXARGS)
     86b:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
     86f:	75 97                	jne    808 <parseexec+0x58>
      panic("too many args");
     871:	c7 04 24 b5 14 00 00 	movl   $0x14b5,(%esp)
     878:	e8 e3 f8 ff ff       	call   160 <panic>
     87d:	8d 76 00             	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     880:	89 7c 24 04          	mov    %edi,0x4(%esp)
     884:	89 34 24             	mov    %esi,(%esp)
     887:	e8 84 01 00 00       	call   a10 <parseblock>
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     88c:	83 c4 3c             	add    $0x3c,%esp
     88f:	5b                   	pop    %ebx
     890:	5e                   	pop    %esi
     891:	5f                   	pop    %edi
     892:	5d                   	pop    %ebp
     893:	c3                   	ret    
     894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     898:	8b 45 cc             	mov    -0x34(%ebp),%eax
     89b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     89e:	8d 04 90             	lea    (%eax,%edx,4),%eax
  cmd->argv[argc] = 0;
     8a1:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     8a8:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
  return ret;
     8af:	8b 45 d0             	mov    -0x30(%ebp),%eax
}
     8b2:	83 c4 3c             	add    $0x3c,%esp
     8b5:	5b                   	pop    %ebx
     8b6:	5e                   	pop    %esi
     8b7:	5f                   	pop    %edi
     8b8:	5d                   	pop    %ebp
     8b9:	c3                   	ret    
      panic("syntax");
     8ba:	c7 04 24 ae 14 00 00 	movl   $0x14ae,(%esp)
     8c1:	e8 9a f8 ff ff       	call   160 <panic>
     8c6:	8d 76 00             	lea    0x0(%esi),%esi
     8c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000008d0 <parsepipe>:
{
     8d0:	55                   	push   %ebp
     8d1:	89 e5                	mov    %esp,%ebp
     8d3:	57                   	push   %edi
     8d4:	56                   	push   %esi
     8d5:	53                   	push   %ebx
     8d6:	83 ec 1c             	sub    $0x1c,%esp
     8d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     8dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     8df:	89 1c 24             	mov    %ebx,(%esp)
     8e2:	89 74 24 04          	mov    %esi,0x4(%esp)
     8e6:	e8 c5 fe ff ff       	call   7b0 <parseexec>
  if(peek(ps, es, "|")){
     8eb:	c7 44 24 08 c8 14 00 	movl   $0x14c8,0x8(%esp)
     8f2:	00 
     8f3:	89 74 24 04          	mov    %esi,0x4(%esp)
     8f7:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseexec(ps, es);
     8fa:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     8fc:	e8 6f fd ff ff       	call   670 <peek>
     901:	85 c0                	test   %eax,%eax
     903:	75 0b                	jne    910 <parsepipe+0x40>
}
     905:	83 c4 1c             	add    $0x1c,%esp
     908:	89 f8                	mov    %edi,%eax
     90a:	5b                   	pop    %ebx
     90b:	5e                   	pop    %esi
     90c:	5f                   	pop    %edi
     90d:	5d                   	pop    %ebp
     90e:	c3                   	ret    
     90f:	90                   	nop
    gettoken(ps, es, 0, 0);
     910:	89 74 24 04          	mov    %esi,0x4(%esp)
     914:	89 1c 24             	mov    %ebx,(%esp)
     917:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     91e:	00 
     91f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     926:	00 
     927:	e8 04 fc ff ff       	call   530 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     92c:	89 74 24 04          	mov    %esi,0x4(%esp)
     930:	89 1c 24             	mov    %ebx,(%esp)
     933:	e8 98 ff ff ff       	call   8d0 <parsepipe>
     938:	89 7d 08             	mov    %edi,0x8(%ebp)
     93b:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     93e:	83 c4 1c             	add    $0x1c,%esp
     941:	5b                   	pop    %ebx
     942:	5e                   	pop    %esi
     943:	5f                   	pop    %edi
     944:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     945:	e9 f6 fa ff ff       	jmp    440 <pipecmd>
     94a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000950 <parseline>:
{
     950:	55                   	push   %ebp
     951:	89 e5                	mov    %esp,%ebp
     953:	57                   	push   %edi
     954:	56                   	push   %esi
     955:	53                   	push   %ebx
     956:	83 ec 1c             	sub    $0x1c,%esp
     959:	8b 5d 08             	mov    0x8(%ebp),%ebx
     95c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     95f:	89 1c 24             	mov    %ebx,(%esp)
     962:	89 74 24 04          	mov    %esi,0x4(%esp)
     966:	e8 65 ff ff ff       	call   8d0 <parsepipe>
     96b:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     96d:	eb 27                	jmp    996 <parseline+0x46>
     96f:	90                   	nop
    gettoken(ps, es, 0, 0);
     970:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     977:	00 
     978:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     97f:	00 
     980:	89 74 24 04          	mov    %esi,0x4(%esp)
     984:	89 1c 24             	mov    %ebx,(%esp)
     987:	e8 a4 fb ff ff       	call   530 <gettoken>
    cmd = backcmd(cmd);
     98c:	89 3c 24             	mov    %edi,(%esp)
     98f:	e8 4c fb ff ff       	call   4e0 <backcmd>
     994:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     996:	c7 44 24 08 ca 14 00 	movl   $0x14ca,0x8(%esp)
     99d:	00 
     99e:	89 74 24 04          	mov    %esi,0x4(%esp)
     9a2:	89 1c 24             	mov    %ebx,(%esp)
     9a5:	e8 c6 fc ff ff       	call   670 <peek>
     9aa:	85 c0                	test   %eax,%eax
     9ac:	75 c2                	jne    970 <parseline+0x20>
  if(peek(ps, es, ";")){
     9ae:	c7 44 24 08 c6 14 00 	movl   $0x14c6,0x8(%esp)
     9b5:	00 
     9b6:	89 74 24 04          	mov    %esi,0x4(%esp)
     9ba:	89 1c 24             	mov    %ebx,(%esp)
     9bd:	e8 ae fc ff ff       	call   670 <peek>
     9c2:	85 c0                	test   %eax,%eax
     9c4:	75 0a                	jne    9d0 <parseline+0x80>
}
     9c6:	83 c4 1c             	add    $0x1c,%esp
     9c9:	89 f8                	mov    %edi,%eax
     9cb:	5b                   	pop    %ebx
     9cc:	5e                   	pop    %esi
     9cd:	5f                   	pop    %edi
     9ce:	5d                   	pop    %ebp
     9cf:	c3                   	ret    
    gettoken(ps, es, 0, 0);
     9d0:	89 74 24 04          	mov    %esi,0x4(%esp)
     9d4:	89 1c 24             	mov    %ebx,(%esp)
     9d7:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9de:	00 
     9df:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9e6:	00 
     9e7:	e8 44 fb ff ff       	call   530 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     9ec:	89 74 24 04          	mov    %esi,0x4(%esp)
     9f0:	89 1c 24             	mov    %ebx,(%esp)
     9f3:	e8 58 ff ff ff       	call   950 <parseline>
     9f8:	89 7d 08             	mov    %edi,0x8(%ebp)
     9fb:	89 45 0c             	mov    %eax,0xc(%ebp)
}
     9fe:	83 c4 1c             	add    $0x1c,%esp
     a01:	5b                   	pop    %ebx
     a02:	5e                   	pop    %esi
     a03:	5f                   	pop    %edi
     a04:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     a05:	e9 86 fa ff ff       	jmp    490 <listcmd>
     a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a10 <parseblock>:
{
     a10:	55                   	push   %ebp
     a11:	89 e5                	mov    %esp,%ebp
     a13:	57                   	push   %edi
     a14:	56                   	push   %esi
     a15:	53                   	push   %ebx
     a16:	83 ec 1c             	sub    $0x1c,%esp
     a19:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a1c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     a1f:	c7 44 24 08 ac 14 00 	movl   $0x14ac,0x8(%esp)
     a26:	00 
     a27:	89 1c 24             	mov    %ebx,(%esp)
     a2a:	89 74 24 04          	mov    %esi,0x4(%esp)
     a2e:	e8 3d fc ff ff       	call   670 <peek>
     a33:	85 c0                	test   %eax,%eax
     a35:	74 76                	je     aad <parseblock+0x9d>
  gettoken(ps, es, 0, 0);
     a37:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a3e:	00 
     a3f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a46:	00 
     a47:	89 74 24 04          	mov    %esi,0x4(%esp)
     a4b:	89 1c 24             	mov    %ebx,(%esp)
     a4e:	e8 dd fa ff ff       	call   530 <gettoken>
  cmd = parseline(ps, es);
     a53:	89 74 24 04          	mov    %esi,0x4(%esp)
     a57:	89 1c 24             	mov    %ebx,(%esp)
     a5a:	e8 f1 fe ff ff       	call   950 <parseline>
  if(!peek(ps, es, ")"))
     a5f:	c7 44 24 08 e8 14 00 	movl   $0x14e8,0x8(%esp)
     a66:	00 
     a67:	89 74 24 04          	mov    %esi,0x4(%esp)
     a6b:	89 1c 24             	mov    %ebx,(%esp)
  cmd = parseline(ps, es);
     a6e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     a70:	e8 fb fb ff ff       	call   670 <peek>
     a75:	85 c0                	test   %eax,%eax
     a77:	74 40                	je     ab9 <parseblock+0xa9>
  gettoken(ps, es, 0, 0);
     a79:	89 74 24 04          	mov    %esi,0x4(%esp)
     a7d:	89 1c 24             	mov    %ebx,(%esp)
     a80:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     a87:	00 
     a88:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     a8f:	00 
     a90:	e8 9b fa ff ff       	call   530 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     a95:	89 74 24 08          	mov    %esi,0x8(%esp)
     a99:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     a9d:	89 3c 24             	mov    %edi,(%esp)
     aa0:	e8 2b fc ff ff       	call   6d0 <parseredirs>
}
     aa5:	83 c4 1c             	add    $0x1c,%esp
     aa8:	5b                   	pop    %ebx
     aa9:	5e                   	pop    %esi
     aaa:	5f                   	pop    %edi
     aab:	5d                   	pop    %ebp
     aac:	c3                   	ret    
    panic("parseblock");
     aad:	c7 04 24 cc 14 00 00 	movl   $0x14cc,(%esp)
     ab4:	e8 a7 f6 ff ff       	call   160 <panic>
    panic("syntax - missing )");
     ab9:	c7 04 24 d7 14 00 00 	movl   $0x14d7,(%esp)
     ac0:	e8 9b f6 ff ff       	call   160 <panic>
     ac5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ad0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     ad0:	55                   	push   %ebp
     ad1:	89 e5                	mov    %esp,%ebp
     ad3:	53                   	push   %ebx
     ad4:	83 ec 14             	sub    $0x14,%esp
     ad7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     ada:	85 db                	test   %ebx,%ebx
     adc:	0f 84 8e 00 00 00    	je     b70 <nulterminate+0xa0>
    return 0;

  switch(cmd->type){
     ae2:	83 3b 05             	cmpl   $0x5,(%ebx)
     ae5:	77 49                	ja     b30 <nulterminate+0x60>
     ae7:	8b 03                	mov    (%ebx),%eax
     ae9:	ff 24 85 28 15 00 00 	jmp    *0x1528(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     af0:	8b 43 04             	mov    0x4(%ebx),%eax
     af3:	89 04 24             	mov    %eax,(%esp)
     af6:	e8 d5 ff ff ff       	call   ad0 <nulterminate>
    nulterminate(lcmd->right);
     afb:	8b 43 08             	mov    0x8(%ebx),%eax
     afe:	89 04 24             	mov    %eax,(%esp)
     b01:	e8 ca ff ff ff       	call   ad0 <nulterminate>
    break;
     b06:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     b08:	83 c4 14             	add    $0x14,%esp
     b0b:	5b                   	pop    %ebx
     b0c:	5d                   	pop    %ebp
     b0d:	c3                   	ret    
     b0e:	66 90                	xchg   %ax,%ax
    for(i=0; ecmd->argv[i]; i++)
     b10:	8b 4b 04             	mov    0x4(%ebx),%ecx
     b13:	89 d8                	mov    %ebx,%eax
     b15:	85 c9                	test   %ecx,%ecx
     b17:	74 17                	je     b30 <nulterminate+0x60>
     b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *ecmd->eargv[i] = 0;
     b20:	8b 50 2c             	mov    0x2c(%eax),%edx
     b23:	83 c0 04             	add    $0x4,%eax
     b26:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     b29:	8b 50 04             	mov    0x4(%eax),%edx
     b2c:	85 d2                	test   %edx,%edx
     b2e:	75 f0                	jne    b20 <nulterminate+0x50>
}
     b30:	83 c4 14             	add    $0x14,%esp
  switch(cmd->type){
     b33:	89 d8                	mov    %ebx,%eax
}
     b35:	5b                   	pop    %ebx
     b36:	5d                   	pop    %ebp
     b37:	c3                   	ret    
    nulterminate(bcmd->cmd);
     b38:	8b 43 04             	mov    0x4(%ebx),%eax
     b3b:	89 04 24             	mov    %eax,(%esp)
     b3e:	e8 8d ff ff ff       	call   ad0 <nulterminate>
}
     b43:	83 c4 14             	add    $0x14,%esp
    break;
     b46:	89 d8                	mov    %ebx,%eax
}
     b48:	5b                   	pop    %ebx
     b49:	5d                   	pop    %ebp
     b4a:	c3                   	ret    
     b4b:	90                   	nop
     b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(rcmd->cmd);
     b50:	8b 43 04             	mov    0x4(%ebx),%eax
     b53:	89 04 24             	mov    %eax,(%esp)
     b56:	e8 75 ff ff ff       	call   ad0 <nulterminate>
    *rcmd->efile = 0;
     b5b:	8b 43 0c             	mov    0xc(%ebx),%eax
     b5e:	c6 00 00             	movb   $0x0,(%eax)
}
     b61:	83 c4 14             	add    $0x14,%esp
    break;
     b64:	89 d8                	mov    %ebx,%eax
}
     b66:	5b                   	pop    %ebx
     b67:	5d                   	pop    %ebp
     b68:	c3                   	ret    
     b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
     b70:	31 c0                	xor    %eax,%eax
     b72:	eb 94                	jmp    b08 <nulterminate+0x38>
     b74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b80 <parsecmd>:
{
     b80:	55                   	push   %ebp
     b81:	89 e5                	mov    %esp,%ebp
     b83:	56                   	push   %esi
     b84:	53                   	push   %ebx
     b85:	83 ec 10             	sub    $0x10,%esp
  es = s + strlen(s);
     b88:	8b 5d 08             	mov    0x8(%ebp),%ebx
     b8b:	89 1c 24             	mov    %ebx,(%esp)
     b8e:	e8 ed 00 00 00       	call   c80 <strlen>
     b93:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     b95:	8d 45 08             	lea    0x8(%ebp),%eax
     b98:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     b9c:	89 04 24             	mov    %eax,(%esp)
     b9f:	e8 ac fd ff ff       	call   950 <parseline>
  peek(&s, es, "");
     ba4:	c7 44 24 08 7d 15 00 	movl   $0x157d,0x8(%esp)
     bab:	00 
     bac:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  cmd = parseline(&s, es);
     bb0:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     bb2:	8d 45 08             	lea    0x8(%ebp),%eax
     bb5:	89 04 24             	mov    %eax,(%esp)
     bb8:	e8 b3 fa ff ff       	call   670 <peek>
  if(s != es){
     bbd:	8b 45 08             	mov    0x8(%ebp),%eax
     bc0:	39 d8                	cmp    %ebx,%eax
     bc2:	75 11                	jne    bd5 <parsecmd+0x55>
  nulterminate(cmd);
     bc4:	89 34 24             	mov    %esi,(%esp)
     bc7:	e8 04 ff ff ff       	call   ad0 <nulterminate>
}
     bcc:	83 c4 10             	add    $0x10,%esp
     bcf:	89 f0                	mov    %esi,%eax
     bd1:	5b                   	pop    %ebx
     bd2:	5e                   	pop    %esi
     bd3:	5d                   	pop    %ebp
     bd4:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     bd5:	89 44 24 08          	mov    %eax,0x8(%esp)
     bd9:	c7 44 24 04 ea 14 00 	movl   $0x14ea,0x4(%esp)
     be0:	00 
     be1:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     be8:	e8 b3 03 00 00       	call   fa0 <printf>
    panic("syntax");
     bed:	c7 04 24 ae 14 00 00 	movl   $0x14ae,(%esp)
     bf4:	e8 67 f5 ff ff       	call   160 <panic>
     bf9:	66 90                	xchg   %ax,%ax
     bfb:	66 90                	xchg   %ax,%ax
     bfd:	66 90                	xchg   %ax,%ax
     bff:	90                   	nop

00000c00 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	8b 45 08             	mov    0x8(%ebp),%eax
     c06:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     c09:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     c0a:	89 c2                	mov    %eax,%edx
     c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c10:	83 c1 01             	add    $0x1,%ecx
     c13:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     c17:	83 c2 01             	add    $0x1,%edx
     c1a:	84 db                	test   %bl,%bl
     c1c:	88 5a ff             	mov    %bl,-0x1(%edx)
     c1f:	75 ef                	jne    c10 <strcpy+0x10>
    ;
  return os;
}
     c21:	5b                   	pop    %ebx
     c22:	5d                   	pop    %ebp
     c23:	c3                   	ret    
     c24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000c30 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     c30:	55                   	push   %ebp
     c31:	89 e5                	mov    %esp,%ebp
     c33:	8b 55 08             	mov    0x8(%ebp),%edx
     c36:	53                   	push   %ebx
     c37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     c3a:	0f b6 02             	movzbl (%edx),%eax
     c3d:	84 c0                	test   %al,%al
     c3f:	74 2d                	je     c6e <strcmp+0x3e>
     c41:	0f b6 19             	movzbl (%ecx),%ebx
     c44:	38 d8                	cmp    %bl,%al
     c46:	74 0e                	je     c56 <strcmp+0x26>
     c48:	eb 2b                	jmp    c75 <strcmp+0x45>
     c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     c50:	38 c8                	cmp    %cl,%al
     c52:	75 15                	jne    c69 <strcmp+0x39>
    p++, q++;
     c54:	89 d9                	mov    %ebx,%ecx
     c56:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     c59:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     c5c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     c5f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
     c63:	84 c0                	test   %al,%al
     c65:	75 e9                	jne    c50 <strcmp+0x20>
     c67:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     c69:	29 c8                	sub    %ecx,%eax
}
     c6b:	5b                   	pop    %ebx
     c6c:	5d                   	pop    %ebp
     c6d:	c3                   	ret    
     c6e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
     c71:	31 c0                	xor    %eax,%eax
     c73:	eb f4                	jmp    c69 <strcmp+0x39>
     c75:	0f b6 cb             	movzbl %bl,%ecx
     c78:	eb ef                	jmp    c69 <strcmp+0x39>
     c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000c80 <strlen>:

uint
strlen(const char *s)
{
     c80:	55                   	push   %ebp
     c81:	89 e5                	mov    %esp,%ebp
     c83:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     c86:	80 39 00             	cmpb   $0x0,(%ecx)
     c89:	74 12                	je     c9d <strlen+0x1d>
     c8b:	31 d2                	xor    %edx,%edx
     c8d:	8d 76 00             	lea    0x0(%esi),%esi
     c90:	83 c2 01             	add    $0x1,%edx
     c93:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     c97:	89 d0                	mov    %edx,%eax
     c99:	75 f5                	jne    c90 <strlen+0x10>
    ;
  return n;
}
     c9b:	5d                   	pop    %ebp
     c9c:	c3                   	ret    
  for(n = 0; s[n]; n++)
     c9d:	31 c0                	xor    %eax,%eax
}
     c9f:	5d                   	pop    %ebp
     ca0:	c3                   	ret    
     ca1:	eb 0d                	jmp    cb0 <memset>
     ca3:	90                   	nop
     ca4:	90                   	nop
     ca5:	90                   	nop
     ca6:	90                   	nop
     ca7:	90                   	nop
     ca8:	90                   	nop
     ca9:	90                   	nop
     caa:	90                   	nop
     cab:	90                   	nop
     cac:	90                   	nop
     cad:	90                   	nop
     cae:	90                   	nop
     caf:	90                   	nop

00000cb0 <memset>:

void*
memset(void *dst, int c, uint n)
{
     cb0:	55                   	push   %ebp
     cb1:	89 e5                	mov    %esp,%ebp
     cb3:	8b 55 08             	mov    0x8(%ebp),%edx
     cb6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     cb7:	8b 4d 10             	mov    0x10(%ebp),%ecx
     cba:	8b 45 0c             	mov    0xc(%ebp),%eax
     cbd:	89 d7                	mov    %edx,%edi
     cbf:	fc                   	cld    
     cc0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     cc2:	89 d0                	mov    %edx,%eax
     cc4:	5f                   	pop    %edi
     cc5:	5d                   	pop    %ebp
     cc6:	c3                   	ret    
     cc7:	89 f6                	mov    %esi,%esi
     cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cd0 <strchr>:

char*
strchr(const char *s, char c)
{
     cd0:	55                   	push   %ebp
     cd1:	89 e5                	mov    %esp,%ebp
     cd3:	8b 45 08             	mov    0x8(%ebp),%eax
     cd6:	53                   	push   %ebx
     cd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
     cda:	0f b6 18             	movzbl (%eax),%ebx
     cdd:	84 db                	test   %bl,%bl
     cdf:	74 1d                	je     cfe <strchr+0x2e>
    if(*s == c)
     ce1:	38 d3                	cmp    %dl,%bl
     ce3:	89 d1                	mov    %edx,%ecx
     ce5:	75 0d                	jne    cf4 <strchr+0x24>
     ce7:	eb 17                	jmp    d00 <strchr+0x30>
     ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     cf0:	38 ca                	cmp    %cl,%dl
     cf2:	74 0c                	je     d00 <strchr+0x30>
  for(; *s; s++)
     cf4:	83 c0 01             	add    $0x1,%eax
     cf7:	0f b6 10             	movzbl (%eax),%edx
     cfa:	84 d2                	test   %dl,%dl
     cfc:	75 f2                	jne    cf0 <strchr+0x20>
      return (char*)s;
  return 0;
     cfe:	31 c0                	xor    %eax,%eax
}
     d00:	5b                   	pop    %ebx
     d01:	5d                   	pop    %ebp
     d02:	c3                   	ret    
     d03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000d10 <gets>:

char*
gets(char *buf, int max)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	57                   	push   %edi
     d14:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     d15:	31 f6                	xor    %esi,%esi
{
     d17:	53                   	push   %ebx
     d18:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
     d1b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
     d1e:	eb 31                	jmp    d51 <gets+0x41>
    cc = read(0, &c, 1);
     d20:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     d27:	00 
     d28:	89 7c 24 04          	mov    %edi,0x4(%esp)
     d2c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     d33:	e8 02 01 00 00       	call   e3a <read>
    if(cc < 1)
     d38:	85 c0                	test   %eax,%eax
     d3a:	7e 1d                	jle    d59 <gets+0x49>
      break;
    buf[i++] = c;
     d3c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
     d40:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
     d42:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
     d45:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
     d47:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     d4b:	74 0c                	je     d59 <gets+0x49>
     d4d:	3c 0a                	cmp    $0xa,%al
     d4f:	74 08                	je     d59 <gets+0x49>
  for(i=0; i+1 < max; ){
     d51:	8d 5e 01             	lea    0x1(%esi),%ebx
     d54:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     d57:	7c c7                	jl     d20 <gets+0x10>
      break;
  }
  buf[i] = '\0';
     d59:	8b 45 08             	mov    0x8(%ebp),%eax
     d5c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     d60:	83 c4 2c             	add    $0x2c,%esp
     d63:	5b                   	pop    %ebx
     d64:	5e                   	pop    %esi
     d65:	5f                   	pop    %edi
     d66:	5d                   	pop    %ebp
     d67:	c3                   	ret    
     d68:	90                   	nop
     d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d70 <stat>:

int
stat(const char *n, struct stat *st)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	56                   	push   %esi
     d74:	53                   	push   %ebx
     d75:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     d78:	8b 45 08             	mov    0x8(%ebp),%eax
     d7b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     d82:	00 
     d83:	89 04 24             	mov    %eax,(%esp)
     d86:	e8 d7 00 00 00       	call   e62 <open>
  if(fd < 0)
     d8b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
     d8d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     d8f:	78 27                	js     db8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
     d91:	8b 45 0c             	mov    0xc(%ebp),%eax
     d94:	89 1c 24             	mov    %ebx,(%esp)
     d97:	89 44 24 04          	mov    %eax,0x4(%esp)
     d9b:	e8 da 00 00 00       	call   e7a <fstat>
  close(fd);
     da0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     da3:	89 c6                	mov    %eax,%esi
  close(fd);
     da5:	e8 a0 00 00 00       	call   e4a <close>
  return r;
     daa:	89 f0                	mov    %esi,%eax
}
     dac:	83 c4 10             	add    $0x10,%esp
     daf:	5b                   	pop    %ebx
     db0:	5e                   	pop    %esi
     db1:	5d                   	pop    %ebp
     db2:	c3                   	ret    
     db3:	90                   	nop
     db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
     db8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     dbd:	eb ed                	jmp    dac <stat+0x3c>
     dbf:	90                   	nop

00000dc0 <atoi>:

int
atoi(const char *s)
{
     dc0:	55                   	push   %ebp
     dc1:	89 e5                	mov    %esp,%ebp
     dc3:	8b 4d 08             	mov    0x8(%ebp),%ecx
     dc6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     dc7:	0f be 11             	movsbl (%ecx),%edx
     dca:	8d 42 d0             	lea    -0x30(%edx),%eax
     dcd:	3c 09                	cmp    $0x9,%al
  n = 0;
     dcf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     dd4:	77 17                	ja     ded <atoi+0x2d>
     dd6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     dd8:	83 c1 01             	add    $0x1,%ecx
     ddb:	8d 04 80             	lea    (%eax,%eax,4),%eax
     dde:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     de2:	0f be 11             	movsbl (%ecx),%edx
     de5:	8d 5a d0             	lea    -0x30(%edx),%ebx
     de8:	80 fb 09             	cmp    $0x9,%bl
     deb:	76 eb                	jbe    dd8 <atoi+0x18>
  return n;
}
     ded:	5b                   	pop    %ebx
     dee:	5d                   	pop    %ebp
     def:	c3                   	ret    

00000df0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     df0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     df1:	31 d2                	xor    %edx,%edx
{
     df3:	89 e5                	mov    %esp,%ebp
     df5:	56                   	push   %esi
     df6:	8b 45 08             	mov    0x8(%ebp),%eax
     df9:	53                   	push   %ebx
     dfa:	8b 5d 10             	mov    0x10(%ebp),%ebx
     dfd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
     e00:	85 db                	test   %ebx,%ebx
     e02:	7e 12                	jle    e16 <memmove+0x26>
     e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     e08:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     e0c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     e0f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     e12:	39 da                	cmp    %ebx,%edx
     e14:	75 f2                	jne    e08 <memmove+0x18>
  return vdst;
}
     e16:	5b                   	pop    %ebx
     e17:	5e                   	pop    %esi
     e18:	5d                   	pop    %ebp
     e19:	c3                   	ret    

00000e1a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     e1a:	b8 01 00 00 00       	mov    $0x1,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <exit>:
SYSCALL(exit)
     e22:	b8 02 00 00 00       	mov    $0x2,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <wait>:
SYSCALL(wait)
     e2a:	b8 03 00 00 00       	mov    $0x3,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    

00000e32 <pipe>:
SYSCALL(pipe)
     e32:	b8 04 00 00 00       	mov    $0x4,%eax
     e37:	cd 40                	int    $0x40
     e39:	c3                   	ret    

00000e3a <read>:
SYSCALL(read)
     e3a:	b8 05 00 00 00       	mov    $0x5,%eax
     e3f:	cd 40                	int    $0x40
     e41:	c3                   	ret    

00000e42 <write>:
SYSCALL(write)
     e42:	b8 10 00 00 00       	mov    $0x10,%eax
     e47:	cd 40                	int    $0x40
     e49:	c3                   	ret    

00000e4a <close>:
SYSCALL(close)
     e4a:	b8 15 00 00 00       	mov    $0x15,%eax
     e4f:	cd 40                	int    $0x40
     e51:	c3                   	ret    

00000e52 <kill>:
SYSCALL(kill)
     e52:	b8 06 00 00 00       	mov    $0x6,%eax
     e57:	cd 40                	int    $0x40
     e59:	c3                   	ret    

00000e5a <exec>:
SYSCALL(exec)
     e5a:	b8 07 00 00 00       	mov    $0x7,%eax
     e5f:	cd 40                	int    $0x40
     e61:	c3                   	ret    

00000e62 <open>:
SYSCALL(open)
     e62:	b8 0f 00 00 00       	mov    $0xf,%eax
     e67:	cd 40                	int    $0x40
     e69:	c3                   	ret    

00000e6a <mknod>:
SYSCALL(mknod)
     e6a:	b8 11 00 00 00       	mov    $0x11,%eax
     e6f:	cd 40                	int    $0x40
     e71:	c3                   	ret    

00000e72 <unlink>:
SYSCALL(unlink)
     e72:	b8 12 00 00 00       	mov    $0x12,%eax
     e77:	cd 40                	int    $0x40
     e79:	c3                   	ret    

00000e7a <fstat>:
SYSCALL(fstat)
     e7a:	b8 08 00 00 00       	mov    $0x8,%eax
     e7f:	cd 40                	int    $0x40
     e81:	c3                   	ret    

00000e82 <link>:
SYSCALL(link)
     e82:	b8 13 00 00 00       	mov    $0x13,%eax
     e87:	cd 40                	int    $0x40
     e89:	c3                   	ret    

00000e8a <mkdir>:
SYSCALL(mkdir)
     e8a:	b8 14 00 00 00       	mov    $0x14,%eax
     e8f:	cd 40                	int    $0x40
     e91:	c3                   	ret    

00000e92 <chdir>:
SYSCALL(chdir)
     e92:	b8 09 00 00 00       	mov    $0x9,%eax
     e97:	cd 40                	int    $0x40
     e99:	c3                   	ret    

00000e9a <dup>:
SYSCALL(dup)
     e9a:	b8 0a 00 00 00       	mov    $0xa,%eax
     e9f:	cd 40                	int    $0x40
     ea1:	c3                   	ret    

00000ea2 <getpid>:
SYSCALL(getpid)
     ea2:	b8 0b 00 00 00       	mov    $0xb,%eax
     ea7:	cd 40                	int    $0x40
     ea9:	c3                   	ret    

00000eaa <sbrk>:
SYSCALL(sbrk)
     eaa:	b8 0c 00 00 00       	mov    $0xc,%eax
     eaf:	cd 40                	int    $0x40
     eb1:	c3                   	ret    

00000eb2 <sleep>:
SYSCALL(sleep)
     eb2:	b8 0d 00 00 00       	mov    $0xd,%eax
     eb7:	cd 40                	int    $0x40
     eb9:	c3                   	ret    

00000eba <uptime>:
SYSCALL(uptime)
     eba:	b8 0e 00 00 00       	mov    $0xe,%eax
     ebf:	cd 40                	int    $0x40
     ec1:	c3                   	ret    

00000ec2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
     ec2:	b8 16 00 00 00       	mov    $0x16,%eax
     ec7:	cd 40                	int    $0x40
     ec9:	c3                   	ret    

00000eca <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
     eca:	b8 17 00 00 00       	mov    $0x17,%eax
     ecf:	cd 40                	int    $0x40
     ed1:	c3                   	ret    

00000ed2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
     ed2:	b8 18 00 00 00       	mov    $0x18,%eax
     ed7:	cd 40                	int    $0x40
     ed9:	c3                   	ret    

00000eda <halt>:
SYSCALL(halt)
     eda:	b8 19 00 00 00       	mov    $0x19,%eax
     edf:	cd 40                	int    $0x40
     ee1:	c3                   	ret    

00000ee2 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
     ee2:	b8 1a 00 00 00       	mov    $0x1a,%eax
     ee7:	cd 40                	int    $0x40
     ee9:	c3                   	ret    

00000eea <kthread_join>:
SYSCALL(kthread_join)
     eea:	b8 1b 00 00 00       	mov    $0x1b,%eax
     eef:	cd 40                	int    $0x40
     ef1:	c3                   	ret    

00000ef2 <kthread_exit>:
SYSCALL(kthread_exit)
     ef2:	b8 1c 00 00 00       	mov    $0x1c,%eax
     ef7:	cd 40                	int    $0x40
     ef9:	c3                   	ret    
     efa:	66 90                	xchg   %ax,%ax
     efc:	66 90                	xchg   %ax,%ax
     efe:	66 90                	xchg   %ax,%ax

00000f00 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
     f03:	57                   	push   %edi
     f04:	56                   	push   %esi
     f05:	89 c6                	mov    %eax,%esi
     f07:	53                   	push   %ebx
     f08:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     f0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
     f0e:	85 db                	test   %ebx,%ebx
     f10:	74 09                	je     f1b <printint+0x1b>
     f12:	89 d0                	mov    %edx,%eax
     f14:	c1 e8 1f             	shr    $0x1f,%eax
     f17:	84 c0                	test   %al,%al
     f19:	75 75                	jne    f90 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
     f1b:	89 d0                	mov    %edx,%eax
  neg = 0;
     f1d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     f24:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
     f27:	31 ff                	xor    %edi,%edi
     f29:	89 ce                	mov    %ecx,%esi
     f2b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     f2e:	eb 02                	jmp    f32 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
     f30:	89 cf                	mov    %ecx,%edi
     f32:	31 d2                	xor    %edx,%edx
     f34:	f7 f6                	div    %esi
     f36:	8d 4f 01             	lea    0x1(%edi),%ecx
     f39:	0f b6 92 47 15 00 00 	movzbl 0x1547(%edx),%edx
  }while((x /= base) != 0);
     f40:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     f42:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     f45:	75 e9                	jne    f30 <printint+0x30>
  if(neg)
     f47:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
     f4a:	89 c8                	mov    %ecx,%eax
     f4c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
     f4f:	85 d2                	test   %edx,%edx
     f51:	74 08                	je     f5b <printint+0x5b>
    buf[i++] = '-';
     f53:	8d 4f 02             	lea    0x2(%edi),%ecx
     f56:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
     f5b:	8d 79 ff             	lea    -0x1(%ecx),%edi
     f5e:	66 90                	xchg   %ax,%ax
     f60:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
     f65:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
     f68:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f6f:	00 
     f70:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     f74:	89 34 24             	mov    %esi,(%esp)
     f77:	88 45 d7             	mov    %al,-0x29(%ebp)
     f7a:	e8 c3 fe ff ff       	call   e42 <write>
  while(--i >= 0)
     f7f:	83 ff ff             	cmp    $0xffffffff,%edi
     f82:	75 dc                	jne    f60 <printint+0x60>
    putc(fd, buf[i]);
}
     f84:	83 c4 4c             	add    $0x4c,%esp
     f87:	5b                   	pop    %ebx
     f88:	5e                   	pop    %esi
     f89:	5f                   	pop    %edi
     f8a:	5d                   	pop    %ebp
     f8b:	c3                   	ret    
     f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
     f90:	89 d0                	mov    %edx,%eax
     f92:	f7 d8                	neg    %eax
    neg = 1;
     f94:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
     f9b:	eb 87                	jmp    f24 <printint+0x24>
     f9d:	8d 76 00             	lea    0x0(%esi),%esi

00000fa0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     fa4:	31 ff                	xor    %edi,%edi
{
     fa6:	56                   	push   %esi
     fa7:	53                   	push   %ebx
     fa8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     fab:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
     fae:	8d 45 10             	lea    0x10(%ebp),%eax
{
     fb1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
     fb4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
     fb7:	0f b6 13             	movzbl (%ebx),%edx
     fba:	83 c3 01             	add    $0x1,%ebx
     fbd:	84 d2                	test   %dl,%dl
     fbf:	75 39                	jne    ffa <printf+0x5a>
     fc1:	e9 ca 00 00 00       	jmp    1090 <printf+0xf0>
     fc6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     fc8:	83 fa 25             	cmp    $0x25,%edx
     fcb:	0f 84 c7 00 00 00    	je     1098 <printf+0xf8>
  write(fd, &c, 1);
     fd1:	8d 45 e0             	lea    -0x20(%ebp),%eax
     fd4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     fdb:	00 
     fdc:	89 44 24 04          	mov    %eax,0x4(%esp)
     fe0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
     fe3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
     fe6:	e8 57 fe ff ff       	call   e42 <write>
     feb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
     fee:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     ff2:	84 d2                	test   %dl,%dl
     ff4:	0f 84 96 00 00 00    	je     1090 <printf+0xf0>
    if(state == 0){
     ffa:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     ffc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
     fff:	74 c7                	je     fc8 <printf+0x28>
      }
    } else if(state == '%'){
    1001:	83 ff 25             	cmp    $0x25,%edi
    1004:	75 e5                	jne    feb <printf+0x4b>
      if(c == 'd' || c == 'u'){
    1006:	83 fa 75             	cmp    $0x75,%edx
    1009:	0f 84 99 00 00 00    	je     10a8 <printf+0x108>
    100f:	83 fa 64             	cmp    $0x64,%edx
    1012:	0f 84 90 00 00 00    	je     10a8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    1018:	25 f7 00 00 00       	and    $0xf7,%eax
    101d:	83 f8 70             	cmp    $0x70,%eax
    1020:	0f 84 aa 00 00 00    	je     10d0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1026:	83 fa 73             	cmp    $0x73,%edx
    1029:	0f 84 e9 00 00 00    	je     1118 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    102f:	83 fa 63             	cmp    $0x63,%edx
    1032:	0f 84 2b 01 00 00    	je     1163 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    1038:	83 fa 25             	cmp    $0x25,%edx
    103b:	0f 84 4f 01 00 00    	je     1190 <printf+0x1f0>
  write(fd, &c, 1);
    1041:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1044:	83 c3 01             	add    $0x1,%ebx
    1047:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    104e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    104f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    1051:	89 44 24 04          	mov    %eax,0x4(%esp)
    1055:	89 34 24             	mov    %esi,(%esp)
    1058:	89 55 d0             	mov    %edx,-0x30(%ebp)
    105b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
    105f:	e8 de fd ff ff       	call   e42 <write>
        putc(fd, c);
    1064:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
    1067:	8d 45 e7             	lea    -0x19(%ebp),%eax
    106a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1071:	00 
    1072:	89 44 24 04          	mov    %eax,0x4(%esp)
    1076:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
    1079:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    107c:	e8 c1 fd ff ff       	call   e42 <write>
  for(i = 0; fmt[i]; i++){
    1081:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    1085:	84 d2                	test   %dl,%dl
    1087:	0f 85 6d ff ff ff    	jne    ffa <printf+0x5a>
    108d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
    1090:	83 c4 3c             	add    $0x3c,%esp
    1093:	5b                   	pop    %ebx
    1094:	5e                   	pop    %esi
    1095:	5f                   	pop    %edi
    1096:	5d                   	pop    %ebp
    1097:	c3                   	ret    
        state = '%';
    1098:	bf 25 00 00 00       	mov    $0x25,%edi
    109d:	e9 49 ff ff ff       	jmp    feb <printf+0x4b>
    10a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    10a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    10af:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
    10b4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
    10b7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
    10b9:	8b 10                	mov    (%eax),%edx
    10bb:	89 f0                	mov    %esi,%eax
    10bd:	e8 3e fe ff ff       	call   f00 <printint>
        ap++;
    10c2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    10c6:	e9 20 ff ff ff       	jmp    feb <printf+0x4b>
    10cb:	90                   	nop
    10cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
    10d0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
    10d3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    10da:	00 
    10db:	89 44 24 04          	mov    %eax,0x4(%esp)
    10df:	89 34 24             	mov    %esi,(%esp)
    10e2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
    10e6:	e8 57 fd ff ff       	call   e42 <write>
    10eb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    10ee:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    10f5:	00 
    10f6:	89 44 24 04          	mov    %eax,0x4(%esp)
    10fa:	89 34 24             	mov    %esi,(%esp)
    10fd:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
    1101:	e8 3c fd ff ff       	call   e42 <write>
        printint(fd, *ap, 16, 0);
    1106:	b9 10 00 00 00       	mov    $0x10,%ecx
    110b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    1112:	eb a0                	jmp    10b4 <printf+0x114>
    1114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1118:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
    111b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
    111f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
    1121:	b8 40 15 00 00       	mov    $0x1540,%eax
    1126:	85 ff                	test   %edi,%edi
    1128:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
    112b:	0f b6 07             	movzbl (%edi),%eax
    112e:	84 c0                	test   %al,%al
    1130:	74 2a                	je     115c <printf+0x1bc>
    1132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1138:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    113b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
    113e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
    1141:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1148:	00 
    1149:	89 44 24 04          	mov    %eax,0x4(%esp)
    114d:	89 34 24             	mov    %esi,(%esp)
    1150:	e8 ed fc ff ff       	call   e42 <write>
        while(*s != 0){
    1155:	0f b6 07             	movzbl (%edi),%eax
    1158:	84 c0                	test   %al,%al
    115a:	75 dc                	jne    1138 <printf+0x198>
      state = 0;
    115c:	31 ff                	xor    %edi,%edi
    115e:	e9 88 fe ff ff       	jmp    feb <printf+0x4b>
        putc(fd, *ap);
    1163:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
    1166:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
    1168:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    116a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    1171:	00 
    1172:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
    1175:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1178:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    117b:	89 44 24 04          	mov    %eax,0x4(%esp)
    117f:	e8 be fc ff ff       	call   e42 <write>
        ap++;
    1184:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
    1188:	e9 5e fe ff ff       	jmp    feb <printf+0x4b>
    118d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1190:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
    1193:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    1195:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    119c:	00 
    119d:	89 44 24 04          	mov    %eax,0x4(%esp)
    11a1:	89 34 24             	mov    %esi,(%esp)
    11a4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
    11a8:	e8 95 fc ff ff       	call   e42 <write>
    11ad:	e9 39 fe ff ff       	jmp    feb <printf+0x4b>
    11b2:	66 90                	xchg   %ax,%ax
    11b4:	66 90                	xchg   %ax,%ax
    11b6:	66 90                	xchg   %ax,%ax
    11b8:	66 90                	xchg   %ax,%ax
    11ba:	66 90                	xchg   %ax,%ax
    11bc:	66 90                	xchg   %ax,%ax
    11be:	66 90                	xchg   %ax,%ax

000011c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    11c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11c1:	a1 24 1c 00 00       	mov    0x1c24,%eax
{
    11c6:	89 e5                	mov    %esp,%ebp
    11c8:	57                   	push   %edi
    11c9:	56                   	push   %esi
    11ca:	53                   	push   %ebx
    11cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11ce:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
    11d0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11d3:	39 d0                	cmp    %edx,%eax
    11d5:	72 11                	jb     11e8 <free+0x28>
    11d7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11d8:	39 c8                	cmp    %ecx,%eax
    11da:	72 04                	jb     11e0 <free+0x20>
    11dc:	39 ca                	cmp    %ecx,%edx
    11de:	72 10                	jb     11f0 <free+0x30>
    11e0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11e2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11e4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    11e6:	73 f0                	jae    11d8 <free+0x18>
    11e8:	39 ca                	cmp    %ecx,%edx
    11ea:	72 04                	jb     11f0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    11ec:	39 c8                	cmp    %ecx,%eax
    11ee:	72 f0                	jb     11e0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    11f0:	8b 73 fc             	mov    -0x4(%ebx),%esi
    11f3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
    11f6:	39 cf                	cmp    %ecx,%edi
    11f8:	74 1e                	je     1218 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    11fa:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    11fd:	8b 48 04             	mov    0x4(%eax),%ecx
    1200:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    1203:	39 f2                	cmp    %esi,%edx
    1205:	74 28                	je     122f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    1207:	89 10                	mov    %edx,(%eax)
  freep = p;
    1209:	a3 24 1c 00 00       	mov    %eax,0x1c24
}
    120e:	5b                   	pop    %ebx
    120f:	5e                   	pop    %esi
    1210:	5f                   	pop    %edi
    1211:	5d                   	pop    %ebp
    1212:	c3                   	ret    
    1213:	90                   	nop
    1214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1218:	03 71 04             	add    0x4(%ecx),%esi
    121b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    121e:	8b 08                	mov    (%eax),%ecx
    1220:	8b 09                	mov    (%ecx),%ecx
    1222:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1225:	8b 48 04             	mov    0x4(%eax),%ecx
    1228:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    122b:	39 f2                	cmp    %esi,%edx
    122d:	75 d8                	jne    1207 <free+0x47>
    p->s.size += bp->s.size;
    122f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
    1232:	a3 24 1c 00 00       	mov    %eax,0x1c24
    p->s.size += bp->s.size;
    1237:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    123a:	8b 53 f8             	mov    -0x8(%ebx),%edx
    123d:	89 10                	mov    %edx,(%eax)
}
    123f:	5b                   	pop    %ebx
    1240:	5e                   	pop    %esi
    1241:	5f                   	pop    %edi
    1242:	5d                   	pop    %ebp
    1243:	c3                   	ret    
    1244:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    124a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001250 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	57                   	push   %edi
    1254:	56                   	push   %esi
    1255:	53                   	push   %ebx
    1256:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1259:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    125c:	8b 1d 24 1c 00 00    	mov    0x1c24,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1262:	8d 48 07             	lea    0x7(%eax),%ecx
    1265:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
    1268:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    126a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
    126d:	0f 84 9b 00 00 00    	je     130e <malloc+0xbe>
    1273:	8b 13                	mov    (%ebx),%edx
    1275:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1278:	39 fe                	cmp    %edi,%esi
    127a:	76 64                	jbe    12e0 <malloc+0x90>
    127c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
    1283:	bb 00 80 00 00       	mov    $0x8000,%ebx
    1288:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    128b:	eb 0e                	jmp    129b <malloc+0x4b>
    128d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1290:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1292:	8b 78 04             	mov    0x4(%eax),%edi
    1295:	39 fe                	cmp    %edi,%esi
    1297:	76 4f                	jbe    12e8 <malloc+0x98>
    1299:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    129b:	3b 15 24 1c 00 00    	cmp    0x1c24,%edx
    12a1:	75 ed                	jne    1290 <malloc+0x40>
  if(nu < 4096)
    12a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    12a6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
    12ac:	bf 00 10 00 00       	mov    $0x1000,%edi
    12b1:	0f 43 fe             	cmovae %esi,%edi
    12b4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
    12b7:	89 04 24             	mov    %eax,(%esp)
    12ba:	e8 eb fb ff ff       	call   eaa <sbrk>
  if(p == (char*)-1)
    12bf:	83 f8 ff             	cmp    $0xffffffff,%eax
    12c2:	74 18                	je     12dc <malloc+0x8c>
  hp->s.size = nu;
    12c4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    12c7:	83 c0 08             	add    $0x8,%eax
    12ca:	89 04 24             	mov    %eax,(%esp)
    12cd:	e8 ee fe ff ff       	call   11c0 <free>
  return freep;
    12d2:	8b 15 24 1c 00 00    	mov    0x1c24,%edx
      if((p = morecore(nunits)) == 0)
    12d8:	85 d2                	test   %edx,%edx
    12da:	75 b4                	jne    1290 <malloc+0x40>
        return 0;
    12dc:	31 c0                	xor    %eax,%eax
    12de:	eb 20                	jmp    1300 <malloc+0xb0>
    if(p->s.size >= nunits){
    12e0:	89 d0                	mov    %edx,%eax
    12e2:	89 da                	mov    %ebx,%edx
    12e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
    12e8:	39 fe                	cmp    %edi,%esi
    12ea:	74 1c                	je     1308 <malloc+0xb8>
        p->s.size -= nunits;
    12ec:	29 f7                	sub    %esi,%edi
    12ee:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
    12f1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
    12f4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    12f7:	89 15 24 1c 00 00    	mov    %edx,0x1c24
      return (void*)(p + 1);
    12fd:	83 c0 08             	add    $0x8,%eax
  }
}
    1300:	83 c4 1c             	add    $0x1c,%esp
    1303:	5b                   	pop    %ebx
    1304:	5e                   	pop    %esi
    1305:	5f                   	pop    %edi
    1306:	5d                   	pop    %ebp
    1307:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
    1308:	8b 08                	mov    (%eax),%ecx
    130a:	89 0a                	mov    %ecx,(%edx)
    130c:	eb e9                	jmp    12f7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
    130e:	c7 05 24 1c 00 00 28 	movl   $0x1c28,0x1c24
    1315:	1c 00 00 
    base.s.size = 0;
    1318:	ba 28 1c 00 00       	mov    $0x1c28,%edx
    base.s.ptr = freep = prevp = &base;
    131d:	c7 05 28 1c 00 00 28 	movl   $0x1c28,0x1c28
    1324:	1c 00 00 
    base.s.size = 0;
    1327:	c7 05 2c 1c 00 00 00 	movl   $0x0,0x1c2c
    132e:	00 00 00 
    1331:	e9 46 ff ff ff       	jmp    127c <malloc+0x2c>
    1336:	66 90                	xchg   %ax,%ax
    1338:	66 90                	xchg   %ax,%ax
    133a:	66 90                	xchg   %ax,%ax
    133c:	66 90                	xchg   %ax,%ax
    133e:	66 90                	xchg   %ax,%ax

00001340 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	53                   	push   %ebx
    1344:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
    1347:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
    134e:	e8 fd fe ff ff       	call   1250 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
    1353:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
    135a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
    135c:	e8 ef fe ff ff       	call   1250 <malloc>
    if (tstack == NULL) {
    1361:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
    1363:	89 c2                	mov    %eax,%edx
    1365:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
    1368:	0f 84 8a 00 00 00    	je     13f8 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
    136e:	25 ff 0f 00 00       	and    $0xfff,%eax
    1373:	75 73                	jne    13e8 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
    1375:	8b 45 10             	mov    0x10(%ebp),%eax
    1378:	89 54 24 08          	mov    %edx,0x8(%esp)
    137c:	89 44 24 04          	mov    %eax,0x4(%esp)
    1380:	8b 45 0c             	mov    0xc(%ebp),%eax
    1383:	89 04 24             	mov    %eax,(%esp)
    1386:	e8 57 fb ff ff       	call   ee2 <kthread_create>
    138b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
    138d:	89 44 24 10          	mov    %eax,0x10(%esp)
    1391:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
    1398:	00 
    1399:	c7 44 24 08 58 15 00 	movl   $0x1558,0x8(%esp)
    13a0:	00 
    13a1:	c7 44 24 04 67 15 00 	movl   $0x1567,0x4(%esp)
    13a8:	00 
    13a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13b0:	e8 eb fb ff ff       	call   fa0 <printf>
    printf(1,"tid:: %u\n",bt->tid);
    13b5:	8b 03                	mov    (%ebx),%eax
    13b7:	c7 44 24 04 7e 15 00 	movl   $0x157e,0x4(%esp)
    13be:	00 
    13bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13c6:	89 44 24 08          	mov    %eax,0x8(%esp)
    13ca:	e8 d1 fb ff ff       	call   fa0 <printf>
    
    if (bt->tid != 0) {
    13cf:	8b 03                	mov    (%ebx),%eax
    13d1:	85 c0                	test   %eax,%eax
    13d3:	74 23                	je     13f8 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
    13d5:	8b 45 08             	mov    0x8(%ebp),%eax
    13d8:	89 18                	mov    %ebx,(%eax)
        return 0;
    13da:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
    13dc:	83 c4 24             	add    $0x24,%esp
    13df:	5b                   	pop    %ebx
    13e0:	5d                   	pop    %ebp
    13e1:	c3                   	ret    
    13e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    13e8:	29 c2                	sub    %eax,%edx
    13ea:	81 c2 00 10 00 00    	add    $0x1000,%edx
    13f0:	eb 83                	jmp    1375 <benny_thread_create+0x35>
    13f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
    13f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    13fd:	eb dd                	jmp    13dc <benny_thread_create+0x9c>
    13ff:	90                   	nop

00001400 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
    1400:	55                   	push   %ebp
    1401:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
    1403:	8b 45 08             	mov    0x8(%ebp),%eax
}
    1406:	5d                   	pop    %ebp
    return bt->tid;
    1407:	8b 00                	mov    (%eax),%eax
}
    1409:	c3                   	ret    
    140a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001410 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	53                   	push   %ebx
    1414:	83 ec 14             	sub    $0x14,%esp
    1417:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
    141a:	8b 03                	mov    (%ebx),%eax
    141c:	89 04 24             	mov    %eax,(%esp)
    141f:	e8 c6 fa ff ff       	call   eea <kthread_join>
    if (retVal == 0) {
    1424:	85 c0                	test   %eax,%eax
    1426:	75 11                	jne    1439 <benny_thread_join+0x29>
        free(bt->tstack);
    1428:	8b 53 04             	mov    0x4(%ebx),%edx
    142b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    142e:	89 14 24             	mov    %edx,(%esp)
    1431:	e8 8a fd ff ff       	call   11c0 <free>
    1436:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
    1439:	83 c4 14             	add    $0x14,%esp
    143c:	5b                   	pop    %ebx
    143d:	5d                   	pop    %ebp
    143e:	c3                   	ret    
    143f:	90                   	nop

00001440 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
    1440:	55                   	push   %ebp
    1441:	89 e5                	mov    %esp,%ebp
    1443:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
    1446:	8b 45 08             	mov    0x8(%ebp),%eax
    1449:	89 04 24             	mov    %eax,(%esp)
    144c:	e8 a1 fa ff ff       	call   ef2 <kthread_exit>
    return 0;
}
    1451:	31 c0                	xor    %eax,%eax
    1453:	c9                   	leave  
    1454:	c3                   	ret    
