
_kdebug:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
#ifdef KDEBUG
    int val = 0;
   1:	31 c0                	xor    %eax,%eax
{
   3:	89 e5                	mov    %esp,%ebp
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp

    if (argc > 1) {
   b:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   f:	7e 0e                	jle    1f <main+0x1f>
        val = atoi(argv[1]);
  11:	8b 45 0c             	mov    0xc(%ebp),%eax
  14:	8b 40 04             	mov    0x4(%eax),%eax
  17:	89 04 24             	mov    %eax,(%esp)
  1a:	e8 d1 01 00 00       	call   1f0 <atoi>
    }

    kdebug(val);
  1f:	89 04 24             	mov    %eax,(%esp)
  22:	e8 db 02 00 00       	call   302 <kdebug>
#endif // KDEBUG

    exit();
  27:	e8 26 02 00 00       	call   252 <exit>
  2c:	66 90                	xchg   %ax,%ax
  2e:	66 90                	xchg   %ax,%ax

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	8b 45 08             	mov    0x8(%ebp),%eax
  36:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  39:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	8b 55 08             	mov    0x8(%ebp),%edx
  66:	53                   	push   %ebx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	84 c0                	test   %al,%al
  6f:	74 2d                	je     9e <strcmp+0x3e>
  71:	0f b6 19             	movzbl (%ecx),%ebx
  74:	38 d8                	cmp    %bl,%al
  76:	74 0e                	je     86 <strcmp+0x26>
  78:	eb 2b                	jmp    a5 <strcmp+0x45>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	38 c8                	cmp    %cl,%al
  82:	75 15                	jne    99 <strcmp+0x39>
    p++, q++;
  84:	89 d9                	mov    %ebx,%ecx
  86:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  89:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  8c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  8f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  93:	84 c0                	test   %al,%al
  95:	75 e9                	jne    80 <strcmp+0x20>
  97:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  99:	29 c8                	sub    %ecx,%eax
}
  9b:	5b                   	pop    %ebx
  9c:	5d                   	pop    %ebp
  9d:	c3                   	ret    
  9e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  a1:	31 c0                	xor    %eax,%eax
  a3:	eb f4                	jmp    99 <strcmp+0x39>
  a5:	0f b6 cb             	movzbl %bl,%ecx
  a8:	eb ef                	jmp    99 <strcmp+0x39>
  aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 12                	je     cd <strlen+0x1d>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  for(n = 0; s[n]; n++)
  cd:	31 c0                	xor    %eax,%eax
}
  cf:	5d                   	pop    %ebp
  d0:	c3                   	ret    
  d1:	eb 0d                	jmp    e0 <memset>
  d3:	90                   	nop
  d4:	90                   	nop
  d5:	90                   	nop
  d6:	90                   	nop
  d7:	90                   	nop
  d8:	90                   	nop
  d9:	90                   	nop
  da:	90                   	nop
  db:	90                   	nop
  dc:	90                   	nop
  dd:	90                   	nop
  de:	90                   	nop
  df:	90                   	nop

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
  e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	53                   	push   %ebx
 107:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 10a:	0f b6 18             	movzbl (%eax),%ebx
 10d:	84 db                	test   %bl,%bl
 10f:	74 1d                	je     12e <strchr+0x2e>
    if(*s == c)
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d1                	mov    %edx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 145:	31 f6                	xor    %esi,%esi
{
 147:	53                   	push   %ebx
 148:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 14b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 14e:	eb 31                	jmp    181 <gets+0x41>
    cc = read(0, &c, 1);
 150:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 157:	00 
 158:	89 7c 24 04          	mov    %edi,0x4(%esp)
 15c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 163:	e8 02 01 00 00       	call   26a <read>
    if(cc < 1)
 168:	85 c0                	test   %eax,%eax
 16a:	7e 1d                	jle    189 <gets+0x49>
      break;
    buf[i++] = c;
 16c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 170:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 172:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 175:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 177:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 17b:	74 0c                	je     189 <gets+0x49>
 17d:	3c 0a                	cmp    $0xa,%al
 17f:	74 08                	je     189 <gets+0x49>
  for(i=0; i+1 < max; ){
 181:	8d 5e 01             	lea    0x1(%esi),%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	7c c7                	jl     150 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 189:	8b 45 08             	mov    0x8(%ebp),%eax
 18c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 190:	83 c4 2c             	add    $0x2c,%esp
 193:	5b                   	pop    %ebx
 194:	5e                   	pop    %esi
 195:	5f                   	pop    %edi
 196:	5d                   	pop    %ebp
 197:	c3                   	ret    
 198:	90                   	nop
 199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	56                   	push   %esi
 1a4:	53                   	push   %ebx
 1a5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a8:	8b 45 08             	mov    0x8(%ebp),%eax
 1ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1b2:	00 
 1b3:	89 04 24             	mov    %eax,(%esp)
 1b6:	e8 d7 00 00 00       	call   292 <open>
  if(fd < 0)
 1bb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 1bd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1bf:	78 27                	js     1e8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c4:	89 1c 24             	mov    %ebx,(%esp)
 1c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1cb:	e8 da 00 00 00       	call   2aa <fstat>
  close(fd);
 1d0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1d3:	89 c6                	mov    %eax,%esi
  close(fd);
 1d5:	e8 a0 00 00 00       	call   27a <close>
  return r;
 1da:	89 f0                	mov    %esi,%eax
}
 1dc:	83 c4 10             	add    $0x10,%esp
 1df:	5b                   	pop    %ebx
 1e0:	5e                   	pop    %esi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    
 1e3:	90                   	nop
 1e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 1e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1ed:	eb ed                	jmp    1dc <stat+0x3c>
 1ef:	90                   	nop

000001f0 <atoi>:

int
atoi(const char *s)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f7:	0f be 11             	movsbl (%ecx),%edx
 1fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 1fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 1ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 204:	77 17                	ja     21d <atoi+0x2d>
 206:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 208:	83 c1 01             	add    $0x1,%ecx
 20b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 20e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 212:	0f be 11             	movsbl (%ecx),%edx
 215:	8d 5a d0             	lea    -0x30(%edx),%ebx
 218:	80 fb 09             	cmp    $0x9,%bl
 21b:	76 eb                	jbe    208 <atoi+0x18>
  return n;
}
 21d:	5b                   	pop    %ebx
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret    

00000220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 220:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 221:	31 d2                	xor    %edx,%edx
{
 223:	89 e5                	mov    %esp,%ebp
 225:	56                   	push   %esi
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	53                   	push   %ebx
 22a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 22d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 230:	85 db                	test   %ebx,%ebx
 232:	7e 12                	jle    246 <memmove+0x26>
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 238:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 23c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 23f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 242:	39 da                	cmp    %ebx,%edx
 244:	75 f2                	jne    238 <memmove+0x18>
  return vdst;
}
 246:	5b                   	pop    %ebx
 247:	5e                   	pop    %esi
 248:	5d                   	pop    %ebp
 249:	c3                   	ret    

0000024a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 24a:	b8 01 00 00 00       	mov    $0x1,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <exit>:
SYSCALL(exit)
 252:	b8 02 00 00 00       	mov    $0x2,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <wait>:
SYSCALL(wait)
 25a:	b8 03 00 00 00       	mov    $0x3,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <pipe>:
SYSCALL(pipe)
 262:	b8 04 00 00 00       	mov    $0x4,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <read>:
SYSCALL(read)
 26a:	b8 05 00 00 00       	mov    $0x5,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <write>:
SYSCALL(write)
 272:	b8 10 00 00 00       	mov    $0x10,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <close>:
SYSCALL(close)
 27a:	b8 15 00 00 00       	mov    $0x15,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <kill>:
SYSCALL(kill)
 282:	b8 06 00 00 00       	mov    $0x6,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <exec>:
SYSCALL(exec)
 28a:	b8 07 00 00 00       	mov    $0x7,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <open>:
SYSCALL(open)
 292:	b8 0f 00 00 00       	mov    $0xf,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <mknod>:
SYSCALL(mknod)
 29a:	b8 11 00 00 00       	mov    $0x11,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <unlink>:
SYSCALL(unlink)
 2a2:	b8 12 00 00 00       	mov    $0x12,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <fstat>:
SYSCALL(fstat)
 2aa:	b8 08 00 00 00       	mov    $0x8,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <link>:
SYSCALL(link)
 2b2:	b8 13 00 00 00       	mov    $0x13,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <mkdir>:
SYSCALL(mkdir)
 2ba:	b8 14 00 00 00       	mov    $0x14,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <chdir>:
SYSCALL(chdir)
 2c2:	b8 09 00 00 00       	mov    $0x9,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <dup>:
SYSCALL(dup)
 2ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <getpid>:
SYSCALL(getpid)
 2d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <sbrk>:
SYSCALL(sbrk)
 2da:	b8 0c 00 00 00       	mov    $0xc,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <sleep>:
SYSCALL(sleep)
 2e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <uptime>:
SYSCALL(uptime)
 2ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 2f2:	b8 16 00 00 00       	mov    $0x16,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 2fa:	b8 17 00 00 00       	mov    $0x17,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 302:	b8 18 00 00 00       	mov    $0x18,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <halt>:
SYSCALL(halt)
 30a:	b8 19 00 00 00       	mov    $0x19,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 312:	b8 1a 00 00 00       	mov    $0x1a,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <kthread_join>:
SYSCALL(kthread_join)
 31a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <kthread_exit>:
SYSCALL(kthread_exit)
 322:	b8 1c 00 00 00       	mov    $0x1c,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
 335:	89 c6                	mov    %eax,%esi
 337:	53                   	push   %ebx
 338:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 33b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 33e:	85 db                	test   %ebx,%ebx
 340:	74 09                	je     34b <printint+0x1b>
 342:	89 d0                	mov    %edx,%eax
 344:	c1 e8 1f             	shr    $0x1f,%eax
 347:	84 c0                	test   %al,%al
 349:	75 75                	jne    3c0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 34b:	89 d0                	mov    %edx,%eax
  neg = 0;
 34d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 354:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 357:	31 ff                	xor    %edi,%edi
 359:	89 ce                	mov    %ecx,%esi
 35b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 35e:	eb 02                	jmp    362 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 360:	89 cf                	mov    %ecx,%edi
 362:	31 d2                	xor    %edx,%edx
 364:	f7 f6                	div    %esi
 366:	8d 4f 01             	lea    0x1(%edi),%ecx
 369:	0f b6 92 8c 08 00 00 	movzbl 0x88c(%edx),%edx
  }while((x /= base) != 0);
 370:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 372:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 375:	75 e9                	jne    360 <printint+0x30>
  if(neg)
 377:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 37a:	89 c8                	mov    %ecx,%eax
 37c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 37f:	85 d2                	test   %edx,%edx
 381:	74 08                	je     38b <printint+0x5b>
    buf[i++] = '-';
 383:	8d 4f 02             	lea    0x2(%edi),%ecx
 386:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 38b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 38e:	66 90                	xchg   %ax,%ax
 390:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 395:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 398:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 39f:	00 
 3a0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3a4:	89 34 24             	mov    %esi,(%esp)
 3a7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3aa:	e8 c3 fe ff ff       	call   272 <write>
  while(--i >= 0)
 3af:	83 ff ff             	cmp    $0xffffffff,%edi
 3b2:	75 dc                	jne    390 <printint+0x60>
    putc(fd, buf[i]);
}
 3b4:	83 c4 4c             	add    $0x4c,%esp
 3b7:	5b                   	pop    %ebx
 3b8:	5e                   	pop    %esi
 3b9:	5f                   	pop    %edi
 3ba:	5d                   	pop    %ebp
 3bb:	c3                   	ret    
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 3c0:	89 d0                	mov    %edx,%eax
 3c2:	f7 d8                	neg    %eax
    neg = 1;
 3c4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3cb:	eb 87                	jmp    354 <printint+0x24>
 3cd:	8d 76 00             	lea    0x0(%esi),%esi

000003d0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3d4:	31 ff                	xor    %edi,%edi
{
 3d6:	56                   	push   %esi
 3d7:	53                   	push   %ebx
 3d8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3db:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 3de:	8d 45 10             	lea    0x10(%ebp),%eax
{
 3e1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 3e4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3e7:	0f b6 13             	movzbl (%ebx),%edx
 3ea:	83 c3 01             	add    $0x1,%ebx
 3ed:	84 d2                	test   %dl,%dl
 3ef:	75 39                	jne    42a <printf+0x5a>
 3f1:	e9 ca 00 00 00       	jmp    4c0 <printf+0xf0>
 3f6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3f8:	83 fa 25             	cmp    $0x25,%edx
 3fb:	0f 84 c7 00 00 00    	je     4c8 <printf+0xf8>
  write(fd, &c, 1);
 401:	8d 45 e0             	lea    -0x20(%ebp),%eax
 404:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 40b:	00 
 40c:	89 44 24 04          	mov    %eax,0x4(%esp)
 410:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 413:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 416:	e8 57 fe ff ff       	call   272 <write>
 41b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 41e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 422:	84 d2                	test   %dl,%dl
 424:	0f 84 96 00 00 00    	je     4c0 <printf+0xf0>
    if(state == 0){
 42a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 42c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 42f:	74 c7                	je     3f8 <printf+0x28>
      }
    } else if(state == '%'){
 431:	83 ff 25             	cmp    $0x25,%edi
 434:	75 e5                	jne    41b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 436:	83 fa 75             	cmp    $0x75,%edx
 439:	0f 84 99 00 00 00    	je     4d8 <printf+0x108>
 43f:	83 fa 64             	cmp    $0x64,%edx
 442:	0f 84 90 00 00 00    	je     4d8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 448:	25 f7 00 00 00       	and    $0xf7,%eax
 44d:	83 f8 70             	cmp    $0x70,%eax
 450:	0f 84 aa 00 00 00    	je     500 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 456:	83 fa 73             	cmp    $0x73,%edx
 459:	0f 84 e9 00 00 00    	je     548 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 45f:	83 fa 63             	cmp    $0x63,%edx
 462:	0f 84 2b 01 00 00    	je     593 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 468:	83 fa 25             	cmp    $0x25,%edx
 46b:	0f 84 4f 01 00 00    	je     5c0 <printf+0x1f0>
  write(fd, &c, 1);
 471:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 474:	83 c3 01             	add    $0x1,%ebx
 477:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 47f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 481:	89 44 24 04          	mov    %eax,0x4(%esp)
 485:	89 34 24             	mov    %esi,(%esp)
 488:	89 55 d0             	mov    %edx,-0x30(%ebp)
 48b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 48f:	e8 de fd ff ff       	call   272 <write>
        putc(fd, c);
 494:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 497:	8d 45 e7             	lea    -0x19(%ebp),%eax
 49a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4a1:	00 
 4a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4a6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 4a9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4ac:	e8 c1 fd ff ff       	call   272 <write>
  for(i = 0; fmt[i]; i++){
 4b1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4b5:	84 d2                	test   %dl,%dl
 4b7:	0f 85 6d ff ff ff    	jne    42a <printf+0x5a>
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 4c0:	83 c4 3c             	add    $0x3c,%esp
 4c3:	5b                   	pop    %ebx
 4c4:	5e                   	pop    %esi
 4c5:	5f                   	pop    %edi
 4c6:	5d                   	pop    %ebp
 4c7:	c3                   	ret    
        state = '%';
 4c8:	bf 25 00 00 00       	mov    $0x25,%edi
 4cd:	e9 49 ff ff ff       	jmp    41b <printf+0x4b>
 4d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 4d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4df:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 4e4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 4e7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 4e9:	8b 10                	mov    (%eax),%edx
 4eb:	89 f0                	mov    %esi,%eax
 4ed:	e8 3e fe ff ff       	call   330 <printint>
        ap++;
 4f2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 4f6:	e9 20 ff ff ff       	jmp    41b <printf+0x4b>
 4fb:	90                   	nop
 4fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 500:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 503:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 50a:	00 
 50b:	89 44 24 04          	mov    %eax,0x4(%esp)
 50f:	89 34 24             	mov    %esi,(%esp)
 512:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 516:	e8 57 fd ff ff       	call   272 <write>
 51b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 51e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 525:	00 
 526:	89 44 24 04          	mov    %eax,0x4(%esp)
 52a:	89 34 24             	mov    %esi,(%esp)
 52d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 531:	e8 3c fd ff ff       	call   272 <write>
        printint(fd, *ap, 16, 0);
 536:	b9 10 00 00 00       	mov    $0x10,%ecx
 53b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 542:	eb a0                	jmp    4e4 <printf+0x114>
 544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 548:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 54b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 54f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 551:	b8 85 08 00 00       	mov    $0x885,%eax
 556:	85 ff                	test   %edi,%edi
 558:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 55b:	0f b6 07             	movzbl (%edi),%eax
 55e:	84 c0                	test   %al,%al
 560:	74 2a                	je     58c <printf+0x1bc>
 562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 568:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 56b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 56e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 571:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 578:	00 
 579:	89 44 24 04          	mov    %eax,0x4(%esp)
 57d:	89 34 24             	mov    %esi,(%esp)
 580:	e8 ed fc ff ff       	call   272 <write>
        while(*s != 0){
 585:	0f b6 07             	movzbl (%edi),%eax
 588:	84 c0                	test   %al,%al
 58a:	75 dc                	jne    568 <printf+0x198>
      state = 0;
 58c:	31 ff                	xor    %edi,%edi
 58e:	e9 88 fe ff ff       	jmp    41b <printf+0x4b>
        putc(fd, *ap);
 593:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 596:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 598:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 59a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5a1:	00 
 5a2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5a5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5a8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 5af:	e8 be fc ff ff       	call   272 <write>
        ap++;
 5b4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5b8:	e9 5e fe ff ff       	jmp    41b <printf+0x4b>
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5c0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5c3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5c5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5cc:	00 
 5cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d1:	89 34 24             	mov    %esi,(%esp)
 5d4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 5d8:	e8 95 fc ff ff       	call   272 <write>
 5dd:	e9 39 fe ff ff       	jmp    41b <printf+0x4b>
 5e2:	66 90                	xchg   %ax,%ax
 5e4:	66 90                	xchg   %ax,%ax
 5e6:	66 90                	xchg   %ax,%ax
 5e8:	66 90                	xchg   %ax,%ax
 5ea:	66 90                	xchg   %ax,%ax
 5ec:	66 90                	xchg   %ax,%ax
 5ee:	66 90                	xchg   %ax,%ax

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	a1 c0 0b 00 00       	mov    0xbc0,%eax
{
 5f6:	89 e5                	mov    %esp,%ebp
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fe:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 600:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 603:	39 d0                	cmp    %edx,%eax
 605:	72 11                	jb     618 <free+0x28>
 607:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 608:	39 c8                	cmp    %ecx,%eax
 60a:	72 04                	jb     610 <free+0x20>
 60c:	39 ca                	cmp    %ecx,%edx
 60e:	72 10                	jb     620 <free+0x30>
 610:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 612:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 614:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 616:	73 f0                	jae    608 <free+0x18>
 618:	39 ca                	cmp    %ecx,%edx
 61a:	72 04                	jb     620 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61c:	39 c8                	cmp    %ecx,%eax
 61e:	72 f0                	jb     610 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 620:	8b 73 fc             	mov    -0x4(%ebx),%esi
 623:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 626:	39 cf                	cmp    %ecx,%edi
 628:	74 1e                	je     648 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 62a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 62d:	8b 48 04             	mov    0x4(%eax),%ecx
 630:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 633:	39 f2                	cmp    %esi,%edx
 635:	74 28                	je     65f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 637:	89 10                	mov    %edx,(%eax)
  freep = p;
 639:	a3 c0 0b 00 00       	mov    %eax,0xbc0
}
 63e:	5b                   	pop    %ebx
 63f:	5e                   	pop    %esi
 640:	5f                   	pop    %edi
 641:	5d                   	pop    %ebp
 642:	c3                   	ret    
 643:	90                   	nop
 644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 648:	03 71 04             	add    0x4(%ecx),%esi
 64b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 64e:	8b 08                	mov    (%eax),%ecx
 650:	8b 09                	mov    (%ecx),%ecx
 652:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 655:	8b 48 04             	mov    0x4(%eax),%ecx
 658:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 65b:	39 f2                	cmp    %esi,%edx
 65d:	75 d8                	jne    637 <free+0x47>
    p->s.size += bp->s.size;
 65f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 662:	a3 c0 0b 00 00       	mov    %eax,0xbc0
    p->s.size += bp->s.size;
 667:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 66a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 66d:	89 10                	mov    %edx,(%eax)
}
 66f:	5b                   	pop    %ebx
 670:	5e                   	pop    %esi
 671:	5f                   	pop    %edi
 672:	5d                   	pop    %ebp
 673:	c3                   	ret    
 674:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 67a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000680 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 689:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 68c:	8b 1d c0 0b 00 00    	mov    0xbc0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 692:	8d 48 07             	lea    0x7(%eax),%ecx
 695:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 698:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 69a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 69d:	0f 84 9b 00 00 00    	je     73e <malloc+0xbe>
 6a3:	8b 13                	mov    (%ebx),%edx
 6a5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6a8:	39 fe                	cmp    %edi,%esi
 6aa:	76 64                	jbe    710 <malloc+0x90>
 6ac:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 6b3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 6b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6bb:	eb 0e                	jmp    6cb <malloc+0x4b>
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6c2:	8b 78 04             	mov    0x4(%eax),%edi
 6c5:	39 fe                	cmp    %edi,%esi
 6c7:	76 4f                	jbe    718 <malloc+0x98>
 6c9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6cb:	3b 15 c0 0b 00 00    	cmp    0xbc0,%edx
 6d1:	75 ed                	jne    6c0 <malloc+0x40>
  if(nu < 4096)
 6d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6d6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6dc:	bf 00 10 00 00       	mov    $0x1000,%edi
 6e1:	0f 43 fe             	cmovae %esi,%edi
 6e4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 6e7:	89 04 24             	mov    %eax,(%esp)
 6ea:	e8 eb fb ff ff       	call   2da <sbrk>
  if(p == (char*)-1)
 6ef:	83 f8 ff             	cmp    $0xffffffff,%eax
 6f2:	74 18                	je     70c <malloc+0x8c>
  hp->s.size = nu;
 6f4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6f7:	83 c0 08             	add    $0x8,%eax
 6fa:	89 04 24             	mov    %eax,(%esp)
 6fd:	e8 ee fe ff ff       	call   5f0 <free>
  return freep;
 702:	8b 15 c0 0b 00 00    	mov    0xbc0,%edx
      if((p = morecore(nunits)) == 0)
 708:	85 d2                	test   %edx,%edx
 70a:	75 b4                	jne    6c0 <malloc+0x40>
        return 0;
 70c:	31 c0                	xor    %eax,%eax
 70e:	eb 20                	jmp    730 <malloc+0xb0>
    if(p->s.size >= nunits){
 710:	89 d0                	mov    %edx,%eax
 712:	89 da                	mov    %ebx,%edx
 714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 718:	39 fe                	cmp    %edi,%esi
 71a:	74 1c                	je     738 <malloc+0xb8>
        p->s.size -= nunits;
 71c:	29 f7                	sub    %esi,%edi
 71e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 721:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 724:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 727:	89 15 c0 0b 00 00    	mov    %edx,0xbc0
      return (void*)(p + 1);
 72d:	83 c0 08             	add    $0x8,%eax
  }
}
 730:	83 c4 1c             	add    $0x1c,%esp
 733:	5b                   	pop    %ebx
 734:	5e                   	pop    %esi
 735:	5f                   	pop    %edi
 736:	5d                   	pop    %ebp
 737:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 738:	8b 08                	mov    (%eax),%ecx
 73a:	89 0a                	mov    %ecx,(%edx)
 73c:	eb e9                	jmp    727 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 73e:	c7 05 c0 0b 00 00 c4 	movl   $0xbc4,0xbc0
 745:	0b 00 00 
    base.s.size = 0;
 748:	ba c4 0b 00 00       	mov    $0xbc4,%edx
    base.s.ptr = freep = prevp = &base;
 74d:	c7 05 c4 0b 00 00 c4 	movl   $0xbc4,0xbc4
 754:	0b 00 00 
    base.s.size = 0;
 757:	c7 05 c8 0b 00 00 00 	movl   $0x0,0xbc8
 75e:	00 00 00 
 761:	e9 46 ff ff ff       	jmp    6ac <malloc+0x2c>
 766:	66 90                	xchg   %ax,%ax
 768:	66 90                	xchg   %ax,%ax
 76a:	66 90                	xchg   %ax,%ax
 76c:	66 90                	xchg   %ax,%ax
 76e:	66 90                	xchg   %ax,%ax

00000770 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 770:	55                   	push   %ebp
 771:	89 e5                	mov    %esp,%ebp
 773:	53                   	push   %ebx
 774:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 777:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 77e:	e8 fd fe ff ff       	call   680 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 783:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 78a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 78c:	e8 ef fe ff ff       	call   680 <malloc>
    if (tstack == NULL) {
 791:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 793:	89 c2                	mov    %eax,%edx
 795:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 798:	0f 84 8a 00 00 00    	je     828 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 79e:	25 ff 0f 00 00       	and    $0xfff,%eax
 7a3:	75 73                	jne    818 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 7a5:	8b 45 10             	mov    0x10(%ebp),%eax
 7a8:	89 54 24 08          	mov    %edx,0x8(%esp)
 7ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 7b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 7b3:	89 04 24             	mov    %eax,(%esp)
 7b6:	e8 57 fb ff ff       	call   312 <kthread_create>
 7bb:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 7bd:	89 44 24 10          	mov    %eax,0x10(%esp)
 7c1:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 7c8:	00 
 7c9:	c7 44 24 08 9d 08 00 	movl   $0x89d,0x8(%esp)
 7d0:	00 
 7d1:	c7 44 24 04 ac 08 00 	movl   $0x8ac,0x4(%esp)
 7d8:	00 
 7d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7e0:	e8 eb fb ff ff       	call   3d0 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 7e5:	8b 03                	mov    (%ebx),%eax
 7e7:	c7 44 24 04 c3 08 00 	movl   $0x8c3,0x4(%esp)
 7ee:	00 
 7ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7f6:	89 44 24 08          	mov    %eax,0x8(%esp)
 7fa:	e8 d1 fb ff ff       	call   3d0 <printf>
    
    if (bt->tid != 0) {
 7ff:	8b 03                	mov    (%ebx),%eax
 801:	85 c0                	test   %eax,%eax
 803:	74 23                	je     828 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 805:	8b 45 08             	mov    0x8(%ebp),%eax
 808:	89 18                	mov    %ebx,(%eax)
        return 0;
 80a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 80c:	83 c4 24             	add    $0x24,%esp
 80f:	5b                   	pop    %ebx
 810:	5d                   	pop    %ebp
 811:	c3                   	ret    
 812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 818:	29 c2                	sub    %eax,%edx
 81a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 820:	eb 83                	jmp    7a5 <benny_thread_create+0x35>
 822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 828:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 82d:	eb dd                	jmp    80c <benny_thread_create+0x9c>
 82f:	90                   	nop

00000830 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 833:	8b 45 08             	mov    0x8(%ebp),%eax
}
 836:	5d                   	pop    %ebp
    return bt->tid;
 837:	8b 00                	mov    (%eax),%eax
}
 839:	c3                   	ret    
 83a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000840 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	53                   	push   %ebx
 844:	83 ec 14             	sub    $0x14,%esp
 847:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 84a:	8b 03                	mov    (%ebx),%eax
 84c:	89 04 24             	mov    %eax,(%esp)
 84f:	e8 c6 fa ff ff       	call   31a <kthread_join>
    if (retVal == 0) {
 854:	85 c0                	test   %eax,%eax
 856:	75 11                	jne    869 <benny_thread_join+0x29>
        free(bt->tstack);
 858:	8b 53 04             	mov    0x4(%ebx),%edx
 85b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 85e:	89 14 24             	mov    %edx,(%esp)
 861:	e8 8a fd ff ff       	call   5f0 <free>
 866:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 869:	83 c4 14             	add    $0x14,%esp
 86c:	5b                   	pop    %ebx
 86d:	5d                   	pop    %ebp
 86e:	c3                   	ret    
 86f:	90                   	nop

00000870 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 876:	8b 45 08             	mov    0x8(%ebp),%eax
 879:	89 04 24             	mov    %eax,(%esp)
 87c:	e8 a1 fa ff ff       	call   322 <kthread_exit>
    return 0;
}
 881:	31 c0                	xor    %eax,%eax
 883:	c9                   	leave  
 884:	c3                   	ret    
