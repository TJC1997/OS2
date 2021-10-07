
_nice:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"
int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 20             	sub    $0x20,%esp
   b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    int val=atoi(argv[1]);
   e:	8b 43 04             	mov    0x4(%ebx),%eax
  11:	89 04 24             	mov    %eax,(%esp)
  14:	e8 f7 01 00 00       	call   210 <atoi>
  19:	89 c6                	mov    %eax,%esi
    int pid=getpid();
  1b:	e8 d2 02 00 00       	call   2f2 <getpid>
    renice(pid,val);
  20:	89 74 24 04          	mov    %esi,0x4(%esp)
  24:	89 04 24             	mov    %eax,(%esp)
  27:	e8 06 03 00 00       	call   332 <renice>
    char* command=argv[2];
  2c:	8b 43 08             	mov    0x8(%ebx),%eax
    char**arg=&command;
    exec(command,arg);
  2f:	8d 54 24 1c          	lea    0x1c(%esp),%edx
  33:	89 54 24 04          	mov    %edx,0x4(%esp)
  37:	89 04 24             	mov    %eax,(%esp)
    char* command=argv[2];
  3a:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    exec(command,arg);
  3e:	e8 67 02 00 00       	call   2aa <exec>
    exit();
  43:	e8 2a 02 00 00       	call   272 <exit>
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	8b 45 08             	mov    0x8(%ebp),%eax
  56:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  59:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  5a:	89 c2                	mov    %eax,%edx
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  60:	83 c1 01             	add    $0x1,%ecx
  63:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  67:	83 c2 01             	add    $0x1,%edx
  6a:	84 db                	test   %bl,%bl
  6c:	88 5a ff             	mov    %bl,-0x1(%edx)
  6f:	75 ef                	jne    60 <strcpy+0x10>
    ;
  return os;
}
  71:	5b                   	pop    %ebx
  72:	5d                   	pop    %ebp
  73:	c3                   	ret    
  74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 55 08             	mov    0x8(%ebp),%edx
  86:	53                   	push   %ebx
  87:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  8a:	0f b6 02             	movzbl (%edx),%eax
  8d:	84 c0                	test   %al,%al
  8f:	74 2d                	je     be <strcmp+0x3e>
  91:	0f b6 19             	movzbl (%ecx),%ebx
  94:	38 d8                	cmp    %bl,%al
  96:	74 0e                	je     a6 <strcmp+0x26>
  98:	eb 2b                	jmp    c5 <strcmp+0x45>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a0:	38 c8                	cmp    %cl,%al
  a2:	75 15                	jne    b9 <strcmp+0x39>
    p++, q++;
  a4:	89 d9                	mov    %ebx,%ecx
  a6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  a9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  ac:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  af:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  b3:	84 c0                	test   %al,%al
  b5:	75 e9                	jne    a0 <strcmp+0x20>
  b7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  b9:	29 c8                	sub    %ecx,%eax
}
  bb:	5b                   	pop    %ebx
  bc:	5d                   	pop    %ebp
  bd:	c3                   	ret    
  be:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  c1:	31 c0                	xor    %eax,%eax
  c3:	eb f4                	jmp    b9 <strcmp+0x39>
  c5:	0f b6 cb             	movzbl %bl,%ecx
  c8:	eb ef                	jmp    b9 <strcmp+0x39>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000d0 <strlen>:

uint
strlen(const char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  d6:	80 39 00             	cmpb   $0x0,(%ecx)
  d9:	74 12                	je     ed <strlen+0x1d>
  db:	31 d2                	xor    %edx,%edx
  dd:	8d 76 00             	lea    0x0(%esi),%esi
  e0:	83 c2 01             	add    $0x1,%edx
  e3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e7:	89 d0                	mov    %edx,%eax
  e9:	75 f5                	jne    e0 <strlen+0x10>
    ;
  return n;
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    
  for(n = 0; s[n]; n++)
  ed:	31 c0                	xor    %eax,%eax
}
  ef:	5d                   	pop    %ebp
  f0:	c3                   	ret    
  f1:	eb 0d                	jmp    100 <memset>
  f3:	90                   	nop
  f4:	90                   	nop
  f5:	90                   	nop
  f6:	90                   	nop
  f7:	90                   	nop
  f8:	90                   	nop
  f9:	90                   	nop
  fa:	90                   	nop
  fb:	90                   	nop
  fc:	90                   	nop
  fd:	90                   	nop
  fe:	90                   	nop
  ff:	90                   	nop

00000100 <memset>:

void*
memset(void *dst, int c, uint n)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 55 08             	mov    0x8(%ebp),%edx
 106:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 107:	8b 4d 10             	mov    0x10(%ebp),%ecx
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	89 d7                	mov    %edx,%edi
 10f:	fc                   	cld    
 110:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 112:	89 d0                	mov    %edx,%eax
 114:	5f                   	pop    %edi
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	89 f6                	mov    %esi,%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <strchr>:

char*
strchr(const char *s, char c)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 45 08             	mov    0x8(%ebp),%eax
 126:	53                   	push   %ebx
 127:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 12a:	0f b6 18             	movzbl (%eax),%ebx
 12d:	84 db                	test   %bl,%bl
 12f:	74 1d                	je     14e <strchr+0x2e>
    if(*s == c)
 131:	38 d3                	cmp    %dl,%bl
 133:	89 d1                	mov    %edx,%ecx
 135:	75 0d                	jne    144 <strchr+0x24>
 137:	eb 17                	jmp    150 <strchr+0x30>
 139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 140:	38 ca                	cmp    %cl,%dl
 142:	74 0c                	je     150 <strchr+0x30>
  for(; *s; s++)
 144:	83 c0 01             	add    $0x1,%eax
 147:	0f b6 10             	movzbl (%eax),%edx
 14a:	84 d2                	test   %dl,%dl
 14c:	75 f2                	jne    140 <strchr+0x20>
      return (char*)s;
  return 0;
 14e:	31 c0                	xor    %eax,%eax
}
 150:	5b                   	pop    %ebx
 151:	5d                   	pop    %ebp
 152:	c3                   	ret    
 153:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <gets>:

char*
gets(char *buf, int max)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 165:	31 f6                	xor    %esi,%esi
{
 167:	53                   	push   %ebx
 168:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 16b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 16e:	eb 31                	jmp    1a1 <gets+0x41>
    cc = read(0, &c, 1);
 170:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 177:	00 
 178:	89 7c 24 04          	mov    %edi,0x4(%esp)
 17c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 183:	e8 02 01 00 00       	call   28a <read>
    if(cc < 1)
 188:	85 c0                	test   %eax,%eax
 18a:	7e 1d                	jle    1a9 <gets+0x49>
      break;
    buf[i++] = c;
 18c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 190:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 192:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 195:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 197:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 19b:	74 0c                	je     1a9 <gets+0x49>
 19d:	3c 0a                	cmp    $0xa,%al
 19f:	74 08                	je     1a9 <gets+0x49>
  for(i=0; i+1 < max; ){
 1a1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1a4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1a7:	7c c7                	jl     170 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1a9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ac:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1b0:	83 c4 2c             	add    $0x2c,%esp
 1b3:	5b                   	pop    %ebx
 1b4:	5e                   	pop    %esi
 1b5:	5f                   	pop    %edi
 1b6:	5d                   	pop    %ebp
 1b7:	c3                   	ret    
 1b8:	90                   	nop
 1b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
 1c5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1d2:	00 
 1d3:	89 04 24             	mov    %eax,(%esp)
 1d6:	e8 d7 00 00 00       	call   2b2 <open>
  if(fd < 0)
 1db:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 1dd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1df:	78 27                	js     208 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e4:	89 1c 24             	mov    %ebx,(%esp)
 1e7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1eb:	e8 da 00 00 00       	call   2ca <fstat>
  close(fd);
 1f0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1f3:	89 c6                	mov    %eax,%esi
  close(fd);
 1f5:	e8 a0 00 00 00       	call   29a <close>
  return r;
 1fa:	89 f0                	mov    %esi,%eax
}
 1fc:	83 c4 10             	add    $0x10,%esp
 1ff:	5b                   	pop    %ebx
 200:	5e                   	pop    %esi
 201:	5d                   	pop    %ebp
 202:	c3                   	ret    
 203:	90                   	nop
 204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 20d:	eb ed                	jmp    1fc <stat+0x3c>
 20f:	90                   	nop

00000210 <atoi>:

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
 216:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
  n = 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 224:	77 17                	ja     23d <atoi+0x2d>
 226:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 228:	83 c1 01             	add    $0x1,%ecx
 22b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 22e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 232:	0f be 11             	movsbl (%ecx),%edx
 235:	8d 5a d0             	lea    -0x30(%edx),%ebx
 238:	80 fb 09             	cmp    $0x9,%bl
 23b:	76 eb                	jbe    228 <atoi+0x18>
  return n;
}
 23d:	5b                   	pop    %ebx
 23e:	5d                   	pop    %ebp
 23f:	c3                   	ret    

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 241:	31 d2                	xor    %edx,%edx
{
 243:	89 e5                	mov    %esp,%ebp
 245:	56                   	push   %esi
 246:	8b 45 08             	mov    0x8(%ebp),%eax
 249:	53                   	push   %ebx
 24a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 24d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 250:	85 db                	test   %ebx,%ebx
 252:	7e 12                	jle    266 <memmove+0x26>
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 258:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 25c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 25f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 262:	39 da                	cmp    %ebx,%edx
 264:	75 f2                	jne    258 <memmove+0x18>
  return vdst;
}
 266:	5b                   	pop    %ebx
 267:	5e                   	pop    %esi
 268:	5d                   	pop    %ebp
 269:	c3                   	ret    

0000026a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26a:	b8 01 00 00 00       	mov    $0x1,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <exit>:
SYSCALL(exit)
 272:	b8 02 00 00 00       	mov    $0x2,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <wait>:
SYSCALL(wait)
 27a:	b8 03 00 00 00       	mov    $0x3,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <pipe>:
SYSCALL(pipe)
 282:	b8 04 00 00 00       	mov    $0x4,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <read>:
SYSCALL(read)
 28a:	b8 05 00 00 00       	mov    $0x5,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <write>:
SYSCALL(write)
 292:	b8 10 00 00 00       	mov    $0x10,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <close>:
SYSCALL(close)
 29a:	b8 15 00 00 00       	mov    $0x15,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <kill>:
SYSCALL(kill)
 2a2:	b8 06 00 00 00       	mov    $0x6,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <exec>:
SYSCALL(exec)
 2aa:	b8 07 00 00 00       	mov    $0x7,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <open>:
SYSCALL(open)
 2b2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <mknod>:
SYSCALL(mknod)
 2ba:	b8 11 00 00 00       	mov    $0x11,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <unlink>:
SYSCALL(unlink)
 2c2:	b8 12 00 00 00       	mov    $0x12,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <fstat>:
SYSCALL(fstat)
 2ca:	b8 08 00 00 00       	mov    $0x8,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <link>:
SYSCALL(link)
 2d2:	b8 13 00 00 00       	mov    $0x13,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <mkdir>:
SYSCALL(mkdir)
 2da:	b8 14 00 00 00       	mov    $0x14,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <chdir>:
SYSCALL(chdir)
 2e2:	b8 09 00 00 00       	mov    $0x9,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <dup>:
SYSCALL(dup)
 2ea:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <getpid>:
SYSCALL(getpid)
 2f2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <sbrk>:
SYSCALL(sbrk)
 2fa:	b8 0c 00 00 00       	mov    $0xc,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <sleep>:
SYSCALL(sleep)
 302:	b8 0d 00 00 00       	mov    $0xd,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <uptime>:
SYSCALL(uptime)
 30a:	b8 0e 00 00 00       	mov    $0xe,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 312:	b8 16 00 00 00       	mov    $0x16,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 31a:	b8 17 00 00 00       	mov    $0x17,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <rrand>:
#endif // CPS
SYSCALL(rrand)
 322:	b8 19 00 00 00       	mov    $0x19,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <kdebug>:
SYSCALL(kdebug)
 32a:	b8 18 00 00 00       	mov    $0x18,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <renice>:
 332:	b8 1a 00 00 00       	mov    $0x1a,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
 345:	89 c6                	mov    %eax,%esi
 347:	53                   	push   %ebx
 348:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 34b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 34e:	85 db                	test   %ebx,%ebx
 350:	74 09                	je     35b <printint+0x1b>
 352:	89 d0                	mov    %edx,%eax
 354:	c1 e8 1f             	shr    $0x1f,%eax
 357:	84 c0                	test   %al,%al
 359:	75 75                	jne    3d0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 35b:	89 d0                	mov    %edx,%eax
  neg = 0;
 35d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 364:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 367:	31 ff                	xor    %edi,%edi
 369:	89 ce                	mov    %ecx,%esi
 36b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 36e:	eb 02                	jmp    372 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 370:	89 cf                	mov    %ecx,%edi
 372:	31 d2                	xor    %edx,%edx
 374:	f7 f6                	div    %esi
 376:	8d 4f 01             	lea    0x1(%edi),%ecx
 379:	0f b6 92 7d 07 00 00 	movzbl 0x77d(%edx),%edx
  }while((x /= base) != 0);
 380:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 382:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 385:	75 e9                	jne    370 <printint+0x30>
  if(neg)
 387:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 38a:	89 c8                	mov    %ecx,%eax
 38c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 38f:	85 d2                	test   %edx,%edx
 391:	74 08                	je     39b <printint+0x5b>
    buf[i++] = '-';
 393:	8d 4f 02             	lea    0x2(%edi),%ecx
 396:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 39b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 39e:	66 90                	xchg   %ax,%ax
 3a0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 3a5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 3a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3af:	00 
 3b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3b4:	89 34 24             	mov    %esi,(%esp)
 3b7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3ba:	e8 d3 fe ff ff       	call   292 <write>
  while(--i >= 0)
 3bf:	83 ff ff             	cmp    $0xffffffff,%edi
 3c2:	75 dc                	jne    3a0 <printint+0x60>
    putc(fd, buf[i]);
}
 3c4:	83 c4 4c             	add    $0x4c,%esp
 3c7:	5b                   	pop    %ebx
 3c8:	5e                   	pop    %esi
 3c9:	5f                   	pop    %edi
 3ca:	5d                   	pop    %ebp
 3cb:	c3                   	ret    
 3cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 3d0:	89 d0                	mov    %edx,%eax
 3d2:	f7 d8                	neg    %eax
    neg = 1;
 3d4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3db:	eb 87                	jmp    364 <printint+0x24>
 3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3e4:	31 ff                	xor    %edi,%edi
{
 3e6:	56                   	push   %esi
 3e7:	53                   	push   %ebx
 3e8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 3ee:	8d 45 10             	lea    0x10(%ebp),%eax
{
 3f1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 3f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3f7:	0f b6 13             	movzbl (%ebx),%edx
 3fa:	83 c3 01             	add    $0x1,%ebx
 3fd:	84 d2                	test   %dl,%dl
 3ff:	75 39                	jne    43a <printf+0x5a>
 401:	e9 ca 00 00 00       	jmp    4d0 <printf+0xf0>
 406:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 408:	83 fa 25             	cmp    $0x25,%edx
 40b:	0f 84 c7 00 00 00    	je     4d8 <printf+0xf8>
  write(fd, &c, 1);
 411:	8d 45 e0             	lea    -0x20(%ebp),%eax
 414:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 41b:	00 
 41c:	89 44 24 04          	mov    %eax,0x4(%esp)
 420:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 423:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 426:	e8 67 fe ff ff       	call   292 <write>
 42b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 42e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 432:	84 d2                	test   %dl,%dl
 434:	0f 84 96 00 00 00    	je     4d0 <printf+0xf0>
    if(state == 0){
 43a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 43c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 43f:	74 c7                	je     408 <printf+0x28>
      }
    } else if(state == '%'){
 441:	83 ff 25             	cmp    $0x25,%edi
 444:	75 e5                	jne    42b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 446:	83 fa 75             	cmp    $0x75,%edx
 449:	0f 84 99 00 00 00    	je     4e8 <printf+0x108>
 44f:	83 fa 64             	cmp    $0x64,%edx
 452:	0f 84 90 00 00 00    	je     4e8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 458:	25 f7 00 00 00       	and    $0xf7,%eax
 45d:	83 f8 70             	cmp    $0x70,%eax
 460:	0f 84 aa 00 00 00    	je     510 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 466:	83 fa 73             	cmp    $0x73,%edx
 469:	0f 84 e9 00 00 00    	je     558 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 46f:	83 fa 63             	cmp    $0x63,%edx
 472:	0f 84 2b 01 00 00    	je     5a3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 478:	83 fa 25             	cmp    $0x25,%edx
 47b:	0f 84 4f 01 00 00    	je     5d0 <printf+0x1f0>
  write(fd, &c, 1);
 481:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 484:	83 c3 01             	add    $0x1,%ebx
 487:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 48e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 48f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 491:	89 44 24 04          	mov    %eax,0x4(%esp)
 495:	89 34 24             	mov    %esi,(%esp)
 498:	89 55 d0             	mov    %edx,-0x30(%ebp)
 49b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 49f:	e8 ee fd ff ff       	call   292 <write>
        putc(fd, c);
 4a4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 4a7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4b1:	00 
 4b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4b6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 4b9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4bc:	e8 d1 fd ff ff       	call   292 <write>
  for(i = 0; fmt[i]; i++){
 4c1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4c5:	84 d2                	test   %dl,%dl
 4c7:	0f 85 6d ff ff ff    	jne    43a <printf+0x5a>
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 4d0:	83 c4 3c             	add    $0x3c,%esp
 4d3:	5b                   	pop    %ebx
 4d4:	5e                   	pop    %esi
 4d5:	5f                   	pop    %edi
 4d6:	5d                   	pop    %ebp
 4d7:	c3                   	ret    
        state = '%';
 4d8:	bf 25 00 00 00       	mov    $0x25,%edi
 4dd:	e9 49 ff ff ff       	jmp    42b <printf+0x4b>
 4e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 4e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4ef:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 4f4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 4f7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 4f9:	8b 10                	mov    (%eax),%edx
 4fb:	89 f0                	mov    %esi,%eax
 4fd:	e8 3e fe ff ff       	call   340 <printint>
        ap++;
 502:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 506:	e9 20 ff ff ff       	jmp    42b <printf+0x4b>
 50b:	90                   	nop
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 510:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 513:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 51a:	00 
 51b:	89 44 24 04          	mov    %eax,0x4(%esp)
 51f:	89 34 24             	mov    %esi,(%esp)
 522:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 526:	e8 67 fd ff ff       	call   292 <write>
 52b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 52e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 535:	00 
 536:	89 44 24 04          	mov    %eax,0x4(%esp)
 53a:	89 34 24             	mov    %esi,(%esp)
 53d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 541:	e8 4c fd ff ff       	call   292 <write>
        printint(fd, *ap, 16, 0);
 546:	b9 10 00 00 00       	mov    $0x10,%ecx
 54b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 552:	eb a0                	jmp    4f4 <printf+0x114>
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 558:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 55b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 55f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 561:	b8 76 07 00 00       	mov    $0x776,%eax
 566:	85 ff                	test   %edi,%edi
 568:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 56b:	0f b6 07             	movzbl (%edi),%eax
 56e:	84 c0                	test   %al,%al
 570:	74 2a                	je     59c <printf+0x1bc>
 572:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 578:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 57b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 57e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 581:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 588:	00 
 589:	89 44 24 04          	mov    %eax,0x4(%esp)
 58d:	89 34 24             	mov    %esi,(%esp)
 590:	e8 fd fc ff ff       	call   292 <write>
        while(*s != 0){
 595:	0f b6 07             	movzbl (%edi),%eax
 598:	84 c0                	test   %al,%al
 59a:	75 dc                	jne    578 <printf+0x198>
      state = 0;
 59c:	31 ff                	xor    %edi,%edi
 59e:	e9 88 fe ff ff       	jmp    42b <printf+0x4b>
        putc(fd, *ap);
 5a3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5a6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 5a8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b1:	00 
 5b2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5b5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5b8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bf:	e8 ce fc ff ff       	call   292 <write>
        ap++;
 5c4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5c8:	e9 5e fe ff ff       	jmp    42b <printf+0x4b>
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5d0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5d3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5d5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5dc:	00 
 5dd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e1:	89 34 24             	mov    %esi,(%esp)
 5e4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 5e8:	e8 a5 fc ff ff       	call   292 <write>
 5ed:	e9 39 fe ff ff       	jmp    42b <printf+0x4b>
 5f2:	66 90                	xchg   %ax,%ax
 5f4:	66 90                	xchg   %ax,%ax
 5f6:	66 90                	xchg   %ax,%ax
 5f8:	66 90                	xchg   %ax,%ax
 5fa:	66 90                	xchg   %ax,%ax
 5fc:	66 90                	xchg   %ax,%ax
 5fe:	66 90                	xchg   %ax,%ax

00000600 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 600:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 601:	a1 f8 09 00 00       	mov    0x9f8,%eax
{
 606:	89 e5                	mov    %esp,%ebp
 608:	57                   	push   %edi
 609:	56                   	push   %esi
 60a:	53                   	push   %ebx
 60b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 610:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 613:	39 d0                	cmp    %edx,%eax
 615:	72 11                	jb     628 <free+0x28>
 617:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 618:	39 c8                	cmp    %ecx,%eax
 61a:	72 04                	jb     620 <free+0x20>
 61c:	39 ca                	cmp    %ecx,%edx
 61e:	72 10                	jb     630 <free+0x30>
 620:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 622:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 624:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 626:	73 f0                	jae    618 <free+0x18>
 628:	39 ca                	cmp    %ecx,%edx
 62a:	72 04                	jb     630 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62c:	39 c8                	cmp    %ecx,%eax
 62e:	72 f0                	jb     620 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 630:	8b 73 fc             	mov    -0x4(%ebx),%esi
 633:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 636:	39 cf                	cmp    %ecx,%edi
 638:	74 1e                	je     658 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 63a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 63d:	8b 48 04             	mov    0x4(%eax),%ecx
 640:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 643:	39 f2                	cmp    %esi,%edx
 645:	74 28                	je     66f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 647:	89 10                	mov    %edx,(%eax)
  freep = p;
 649:	a3 f8 09 00 00       	mov    %eax,0x9f8
}
 64e:	5b                   	pop    %ebx
 64f:	5e                   	pop    %esi
 650:	5f                   	pop    %edi
 651:	5d                   	pop    %ebp
 652:	c3                   	ret    
 653:	90                   	nop
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 658:	03 71 04             	add    0x4(%ecx),%esi
 65b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 65e:	8b 08                	mov    (%eax),%ecx
 660:	8b 09                	mov    (%ecx),%ecx
 662:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 665:	8b 48 04             	mov    0x4(%eax),%ecx
 668:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 66b:	39 f2                	cmp    %esi,%edx
 66d:	75 d8                	jne    647 <free+0x47>
    p->s.size += bp->s.size;
 66f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 672:	a3 f8 09 00 00       	mov    %eax,0x9f8
    p->s.size += bp->s.size;
 677:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 67a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 67d:	89 10                	mov    %edx,(%eax)
}
 67f:	5b                   	pop    %ebx
 680:	5e                   	pop    %esi
 681:	5f                   	pop    %edi
 682:	5d                   	pop    %ebp
 683:	c3                   	ret    
 684:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 68a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000690 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 690:	55                   	push   %ebp
 691:	89 e5                	mov    %esp,%ebp
 693:	57                   	push   %edi
 694:	56                   	push   %esi
 695:	53                   	push   %ebx
 696:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 699:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 69c:	8b 1d f8 09 00 00    	mov    0x9f8,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6a2:	8d 48 07             	lea    0x7(%eax),%ecx
 6a5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 6a8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6aa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 6ad:	0f 84 9b 00 00 00    	je     74e <malloc+0xbe>
 6b3:	8b 13                	mov    (%ebx),%edx
 6b5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6b8:	39 fe                	cmp    %edi,%esi
 6ba:	76 64                	jbe    720 <malloc+0x90>
 6bc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 6c3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 6c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6cb:	eb 0e                	jmp    6db <malloc+0x4b>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6d2:	8b 78 04             	mov    0x4(%eax),%edi
 6d5:	39 fe                	cmp    %edi,%esi
 6d7:	76 4f                	jbe    728 <malloc+0x98>
 6d9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6db:	3b 15 f8 09 00 00    	cmp    0x9f8,%edx
 6e1:	75 ed                	jne    6d0 <malloc+0x40>
  if(nu < 4096)
 6e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6ec:	bf 00 10 00 00       	mov    $0x1000,%edi
 6f1:	0f 43 fe             	cmovae %esi,%edi
 6f4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 6f7:	89 04 24             	mov    %eax,(%esp)
 6fa:	e8 fb fb ff ff       	call   2fa <sbrk>
  if(p == (char*)-1)
 6ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 702:	74 18                	je     71c <malloc+0x8c>
  hp->s.size = nu;
 704:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 707:	83 c0 08             	add    $0x8,%eax
 70a:	89 04 24             	mov    %eax,(%esp)
 70d:	e8 ee fe ff ff       	call   600 <free>
  return freep;
 712:	8b 15 f8 09 00 00    	mov    0x9f8,%edx
      if((p = morecore(nunits)) == 0)
 718:	85 d2                	test   %edx,%edx
 71a:	75 b4                	jne    6d0 <malloc+0x40>
        return 0;
 71c:	31 c0                	xor    %eax,%eax
 71e:	eb 20                	jmp    740 <malloc+0xb0>
    if(p->s.size >= nunits){
 720:	89 d0                	mov    %edx,%eax
 722:	89 da                	mov    %ebx,%edx
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 728:	39 fe                	cmp    %edi,%esi
 72a:	74 1c                	je     748 <malloc+0xb8>
        p->s.size -= nunits;
 72c:	29 f7                	sub    %esi,%edi
 72e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 731:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 734:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 737:	89 15 f8 09 00 00    	mov    %edx,0x9f8
      return (void*)(p + 1);
 73d:	83 c0 08             	add    $0x8,%eax
  }
}
 740:	83 c4 1c             	add    $0x1c,%esp
 743:	5b                   	pop    %ebx
 744:	5e                   	pop    %esi
 745:	5f                   	pop    %edi
 746:	5d                   	pop    %ebp
 747:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 748:	8b 08                	mov    (%eax),%ecx
 74a:	89 0a                	mov    %ecx,(%edx)
 74c:	eb e9                	jmp    737 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 74e:	c7 05 f8 09 00 00 fc 	movl   $0x9fc,0x9f8
 755:	09 00 00 
    base.s.size = 0;
 758:	ba fc 09 00 00       	mov    $0x9fc,%edx
    base.s.ptr = freep = prevp = &base;
 75d:	c7 05 fc 09 00 00 fc 	movl   $0x9fc,0x9fc
 764:	09 00 00 
    base.s.size = 0;
 767:	c7 05 00 0a 00 00 00 	movl   $0x0,0xa00
 76e:	00 00 00 
 771:	e9 46 ff ff ff       	jmp    6bc <malloc+0x2c>
