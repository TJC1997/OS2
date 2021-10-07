
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
   a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(argc != 3){
   d:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
  11:	74 19                	je     2c <main+0x2c>
    printf(2, "Usage: ln old new\n");
  13:	c7 44 24 04 c5 08 00 	movl   $0x8c5,0x4(%esp)
  1a:	00 
  1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  22:	e8 e9 03 00 00       	call   410 <printf>
    exit();
  27:	e8 66 02 00 00       	call   292 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2c:	8b 43 08             	mov    0x8(%ebx),%eax
  2f:	89 44 24 04          	mov    %eax,0x4(%esp)
  33:	8b 43 04             	mov    0x4(%ebx),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 b4 02 00 00       	call   2f2 <link>
  3e:	85 c0                	test   %eax,%eax
  40:	78 05                	js     47 <main+0x47>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  42:	e8 4b 02 00 00       	call   292 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  47:	8b 43 08             	mov    0x8(%ebx),%eax
  4a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	c7 44 24 04 d8 08 00 	movl   $0x8d8,0x4(%esp)
  58:	00 
  59:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  60:	89 44 24 08          	mov    %eax,0x8(%esp)
  64:	e8 a7 03 00 00       	call   410 <printf>
  69:	eb d7                	jmp    42 <main+0x42>
  6b:	66 90                	xchg   %ax,%ax
  6d:	66 90                	xchg   %ax,%ax
  6f:	90                   	nop

00000070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	8b 45 08             	mov    0x8(%ebp),%eax
  76:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  79:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7a:	89 c2                	mov    %eax,%edx
  7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  80:	83 c1 01             	add    $0x1,%ecx
  83:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  87:	83 c2 01             	add    $0x1,%edx
  8a:	84 db                	test   %bl,%bl
  8c:	88 5a ff             	mov    %bl,-0x1(%edx)
  8f:	75 ef                	jne    80 <strcpy+0x10>
    ;
  return os;
}
  91:	5b                   	pop    %ebx
  92:	5d                   	pop    %ebp
  93:	c3                   	ret    
  94:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  9a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 55 08             	mov    0x8(%ebp),%edx
  a6:	53                   	push   %ebx
  a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  aa:	0f b6 02             	movzbl (%edx),%eax
  ad:	84 c0                	test   %al,%al
  af:	74 2d                	je     de <strcmp+0x3e>
  b1:	0f b6 19             	movzbl (%ecx),%ebx
  b4:	38 d8                	cmp    %bl,%al
  b6:	74 0e                	je     c6 <strcmp+0x26>
  b8:	eb 2b                	jmp    e5 <strcmp+0x45>
  ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c0:	38 c8                	cmp    %cl,%al
  c2:	75 15                	jne    d9 <strcmp+0x39>
    p++, q++;
  c4:	89 d9                	mov    %ebx,%ecx
  c6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  c9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  cc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  cf:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  d3:	84 c0                	test   %al,%al
  d5:	75 e9                	jne    c0 <strcmp+0x20>
  d7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d9:	29 c8                	sub    %ecx,%eax
}
  db:	5b                   	pop    %ebx
  dc:	5d                   	pop    %ebp
  dd:	c3                   	ret    
  de:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  e1:	31 c0                	xor    %eax,%eax
  e3:	eb f4                	jmp    d9 <strcmp+0x39>
  e5:	0f b6 cb             	movzbl %bl,%ecx
  e8:	eb ef                	jmp    d9 <strcmp+0x39>
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000f0 <strlen>:

uint
strlen(const char *s)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  f6:	80 39 00             	cmpb   $0x0,(%ecx)
  f9:	74 12                	je     10d <strlen+0x1d>
  fb:	31 d2                	xor    %edx,%edx
  fd:	8d 76 00             	lea    0x0(%esi),%esi
 100:	83 c2 01             	add    $0x1,%edx
 103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 107:	89 d0                	mov    %edx,%eax
 109:	75 f5                	jne    100 <strlen+0x10>
    ;
  return n;
}
 10b:	5d                   	pop    %ebp
 10c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 10d:	31 c0                	xor    %eax,%eax
}
 10f:	5d                   	pop    %ebp
 110:	c3                   	ret    
 111:	eb 0d                	jmp    120 <memset>
 113:	90                   	nop
 114:	90                   	nop
 115:	90                   	nop
 116:	90                   	nop
 117:	90                   	nop
 118:	90                   	nop
 119:	90                   	nop
 11a:	90                   	nop
 11b:	90                   	nop
 11c:	90                   	nop
 11d:	90                   	nop
 11e:	90                   	nop
 11f:	90                   	nop

00000120 <memset>:

void*
memset(void *dst, int c, uint n)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 55 08             	mov    0x8(%ebp),%edx
 126:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 127:	8b 4d 10             	mov    0x10(%ebp),%ecx
 12a:	8b 45 0c             	mov    0xc(%ebp),%eax
 12d:	89 d7                	mov    %edx,%edi
 12f:	fc                   	cld    
 130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 132:	89 d0                	mov    %edx,%eax
 134:	5f                   	pop    %edi
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	89 f6                	mov    %esi,%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <strchr>:

char*
strchr(const char *s, char c)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	53                   	push   %ebx
 147:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 14a:	0f b6 18             	movzbl (%eax),%ebx
 14d:	84 db                	test   %bl,%bl
 14f:	74 1d                	je     16e <strchr+0x2e>
    if(*s == c)
 151:	38 d3                	cmp    %dl,%bl
 153:	89 d1                	mov    %edx,%ecx
 155:	75 0d                	jne    164 <strchr+0x24>
 157:	eb 17                	jmp    170 <strchr+0x30>
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	38 ca                	cmp    %cl,%dl
 162:	74 0c                	je     170 <strchr+0x30>
  for(; *s; s++)
 164:	83 c0 01             	add    $0x1,%eax
 167:	0f b6 10             	movzbl (%eax),%edx
 16a:	84 d2                	test   %dl,%dl
 16c:	75 f2                	jne    160 <strchr+0x20>
      return (char*)s;
  return 0;
 16e:	31 c0                	xor    %eax,%eax
}
 170:	5b                   	pop    %ebx
 171:	5d                   	pop    %ebp
 172:	c3                   	ret    
 173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <gets>:

char*
gets(char *buf, int max)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	57                   	push   %edi
 184:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 185:	31 f6                	xor    %esi,%esi
{
 187:	53                   	push   %ebx
 188:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 18b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 18e:	eb 31                	jmp    1c1 <gets+0x41>
    cc = read(0, &c, 1);
 190:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 197:	00 
 198:	89 7c 24 04          	mov    %edi,0x4(%esp)
 19c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1a3:	e8 02 01 00 00       	call   2aa <read>
    if(cc < 1)
 1a8:	85 c0                	test   %eax,%eax
 1aa:	7e 1d                	jle    1c9 <gets+0x49>
      break;
    buf[i++] = c;
 1ac:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 1b0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 1b2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1b5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 1b7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1bb:	74 0c                	je     1c9 <gets+0x49>
 1bd:	3c 0a                	cmp    $0xa,%al
 1bf:	74 08                	je     1c9 <gets+0x49>
  for(i=0; i+1 < max; ){
 1c1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1c7:	7c c7                	jl     190 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1c9:	8b 45 08             	mov    0x8(%ebp),%eax
 1cc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1d0:	83 c4 2c             	add    $0x2c,%esp
 1d3:	5b                   	pop    %ebx
 1d4:	5e                   	pop    %esi
 1d5:	5f                   	pop    %edi
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    
 1d8:	90                   	nop
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001e0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	56                   	push   %esi
 1e4:	53                   	push   %ebx
 1e5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e8:	8b 45 08             	mov    0x8(%ebp),%eax
 1eb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1f2:	00 
 1f3:	89 04 24             	mov    %eax,(%esp)
 1f6:	e8 d7 00 00 00       	call   2d2 <open>
  if(fd < 0)
 1fb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 1fd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1ff:	78 27                	js     228 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 201:	8b 45 0c             	mov    0xc(%ebp),%eax
 204:	89 1c 24             	mov    %ebx,(%esp)
 207:	89 44 24 04          	mov    %eax,0x4(%esp)
 20b:	e8 da 00 00 00       	call   2ea <fstat>
  close(fd);
 210:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 213:	89 c6                	mov    %eax,%esi
  close(fd);
 215:	e8 a0 00 00 00       	call   2ba <close>
  return r;
 21a:	89 f0                	mov    %esi,%eax
}
 21c:	83 c4 10             	add    $0x10,%esp
 21f:	5b                   	pop    %ebx
 220:	5e                   	pop    %esi
 221:	5d                   	pop    %ebp
 222:	c3                   	ret    
 223:	90                   	nop
 224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22d:	eb ed                	jmp    21c <stat+0x3c>
 22f:	90                   	nop

00000230 <atoi>:

int
atoi(const char *s)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 4d 08             	mov    0x8(%ebp),%ecx
 236:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 237:	0f be 11             	movsbl (%ecx),%edx
 23a:	8d 42 d0             	lea    -0x30(%edx),%eax
 23d:	3c 09                	cmp    $0x9,%al
  n = 0;
 23f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 244:	77 17                	ja     25d <atoi+0x2d>
 246:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 248:	83 c1 01             	add    $0x1,%ecx
 24b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 24e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 252:	0f be 11             	movsbl (%ecx),%edx
 255:	8d 5a d0             	lea    -0x30(%edx),%ebx
 258:	80 fb 09             	cmp    $0x9,%bl
 25b:	76 eb                	jbe    248 <atoi+0x18>
  return n;
}
 25d:	5b                   	pop    %ebx
 25e:	5d                   	pop    %ebp
 25f:	c3                   	ret    

00000260 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 260:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 261:	31 d2                	xor    %edx,%edx
{
 263:	89 e5                	mov    %esp,%ebp
 265:	56                   	push   %esi
 266:	8b 45 08             	mov    0x8(%ebp),%eax
 269:	53                   	push   %ebx
 26a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 26d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 270:	85 db                	test   %ebx,%ebx
 272:	7e 12                	jle    286 <memmove+0x26>
 274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 278:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 27c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 27f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 282:	39 da                	cmp    %ebx,%edx
 284:	75 f2                	jne    278 <memmove+0x18>
  return vdst;
}
 286:	5b                   	pop    %ebx
 287:	5e                   	pop    %esi
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    

0000028a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 28a:	b8 01 00 00 00       	mov    $0x1,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <exit>:
SYSCALL(exit)
 292:	b8 02 00 00 00       	mov    $0x2,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <wait>:
SYSCALL(wait)
 29a:	b8 03 00 00 00       	mov    $0x3,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <pipe>:
SYSCALL(pipe)
 2a2:	b8 04 00 00 00       	mov    $0x4,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <read>:
SYSCALL(read)
 2aa:	b8 05 00 00 00       	mov    $0x5,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <write>:
SYSCALL(write)
 2b2:	b8 10 00 00 00       	mov    $0x10,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <close>:
SYSCALL(close)
 2ba:	b8 15 00 00 00       	mov    $0x15,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <kill>:
SYSCALL(kill)
 2c2:	b8 06 00 00 00       	mov    $0x6,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <exec>:
SYSCALL(exec)
 2ca:	b8 07 00 00 00       	mov    $0x7,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <open>:
SYSCALL(open)
 2d2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <mknod>:
SYSCALL(mknod)
 2da:	b8 11 00 00 00       	mov    $0x11,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <unlink>:
SYSCALL(unlink)
 2e2:	b8 12 00 00 00       	mov    $0x12,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <fstat>:
SYSCALL(fstat)
 2ea:	b8 08 00 00 00       	mov    $0x8,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <link>:
SYSCALL(link)
 2f2:	b8 13 00 00 00       	mov    $0x13,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <mkdir>:
SYSCALL(mkdir)
 2fa:	b8 14 00 00 00       	mov    $0x14,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <chdir>:
SYSCALL(chdir)
 302:	b8 09 00 00 00       	mov    $0x9,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <dup>:
SYSCALL(dup)
 30a:	b8 0a 00 00 00       	mov    $0xa,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <getpid>:
SYSCALL(getpid)
 312:	b8 0b 00 00 00       	mov    $0xb,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <sbrk>:
SYSCALL(sbrk)
 31a:	b8 0c 00 00 00       	mov    $0xc,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <sleep>:
SYSCALL(sleep)
 322:	b8 0d 00 00 00       	mov    $0xd,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <uptime>:
SYSCALL(uptime)
 32a:	b8 0e 00 00 00       	mov    $0xe,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 332:	b8 16 00 00 00       	mov    $0x16,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 33a:	b8 17 00 00 00       	mov    $0x17,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 342:	b8 18 00 00 00       	mov    $0x18,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <halt>:
SYSCALL(halt)
 34a:	b8 19 00 00 00       	mov    $0x19,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 352:	b8 1a 00 00 00       	mov    $0x1a,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <kthread_join>:
SYSCALL(kthread_join)
 35a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kthread_exit>:
SYSCALL(kthread_exit)
 362:	b8 1c 00 00 00       	mov    $0x1c,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	89 c6                	mov    %eax,%esi
 377:	53                   	push   %ebx
 378:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 37b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 37e:	85 db                	test   %ebx,%ebx
 380:	74 09                	je     38b <printint+0x1b>
 382:	89 d0                	mov    %edx,%eax
 384:	c1 e8 1f             	shr    $0x1f,%eax
 387:	84 c0                	test   %al,%al
 389:	75 75                	jne    400 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 38b:	89 d0                	mov    %edx,%eax
  neg = 0;
 38d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 394:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 397:	31 ff                	xor    %edi,%edi
 399:	89 ce                	mov    %ecx,%esi
 39b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 39e:	eb 02                	jmp    3a2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 3a0:	89 cf                	mov    %ecx,%edi
 3a2:	31 d2                	xor    %edx,%edx
 3a4:	f7 f6                	div    %esi
 3a6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3a9:	0f b6 92 f3 08 00 00 	movzbl 0x8f3(%edx),%edx
  }while((x /= base) != 0);
 3b0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3b2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3b5:	75 e9                	jne    3a0 <printint+0x30>
  if(neg)
 3b7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 3ba:	89 c8                	mov    %ecx,%eax
 3bc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 3bf:	85 d2                	test   %edx,%edx
 3c1:	74 08                	je     3cb <printint+0x5b>
    buf[i++] = '-';
 3c3:	8d 4f 02             	lea    0x2(%edi),%ecx
 3c6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3cb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3ce:	66 90                	xchg   %ax,%ax
 3d0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 3d5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 3d8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3df:	00 
 3e0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3e4:	89 34 24             	mov    %esi,(%esp)
 3e7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3ea:	e8 c3 fe ff ff       	call   2b2 <write>
  while(--i >= 0)
 3ef:	83 ff ff             	cmp    $0xffffffff,%edi
 3f2:	75 dc                	jne    3d0 <printint+0x60>
    putc(fd, buf[i]);
}
 3f4:	83 c4 4c             	add    $0x4c,%esp
 3f7:	5b                   	pop    %ebx
 3f8:	5e                   	pop    %esi
 3f9:	5f                   	pop    %edi
 3fa:	5d                   	pop    %ebp
 3fb:	c3                   	ret    
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 400:	89 d0                	mov    %edx,%eax
 402:	f7 d8                	neg    %eax
    neg = 1;
 404:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 40b:	eb 87                	jmp    394 <printint+0x24>
 40d:	8d 76 00             	lea    0x0(%esi),%esi

00000410 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 414:	31 ff                	xor    %edi,%edi
{
 416:	56                   	push   %esi
 417:	53                   	push   %ebx
 418:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 41b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 41e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 421:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 424:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 427:	0f b6 13             	movzbl (%ebx),%edx
 42a:	83 c3 01             	add    $0x1,%ebx
 42d:	84 d2                	test   %dl,%dl
 42f:	75 39                	jne    46a <printf+0x5a>
 431:	e9 ca 00 00 00       	jmp    500 <printf+0xf0>
 436:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 438:	83 fa 25             	cmp    $0x25,%edx
 43b:	0f 84 c7 00 00 00    	je     508 <printf+0xf8>
  write(fd, &c, 1);
 441:	8d 45 e0             	lea    -0x20(%ebp),%eax
 444:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 44b:	00 
 44c:	89 44 24 04          	mov    %eax,0x4(%esp)
 450:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 453:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 456:	e8 57 fe ff ff       	call   2b2 <write>
 45b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 45e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 462:	84 d2                	test   %dl,%dl
 464:	0f 84 96 00 00 00    	je     500 <printf+0xf0>
    if(state == 0){
 46a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 46c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 46f:	74 c7                	je     438 <printf+0x28>
      }
    } else if(state == '%'){
 471:	83 ff 25             	cmp    $0x25,%edi
 474:	75 e5                	jne    45b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 476:	83 fa 75             	cmp    $0x75,%edx
 479:	0f 84 99 00 00 00    	je     518 <printf+0x108>
 47f:	83 fa 64             	cmp    $0x64,%edx
 482:	0f 84 90 00 00 00    	je     518 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 488:	25 f7 00 00 00       	and    $0xf7,%eax
 48d:	83 f8 70             	cmp    $0x70,%eax
 490:	0f 84 aa 00 00 00    	je     540 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 496:	83 fa 73             	cmp    $0x73,%edx
 499:	0f 84 e9 00 00 00    	je     588 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49f:	83 fa 63             	cmp    $0x63,%edx
 4a2:	0f 84 2b 01 00 00    	je     5d3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4a8:	83 fa 25             	cmp    $0x25,%edx
 4ab:	0f 84 4f 01 00 00    	je     600 <printf+0x1f0>
  write(fd, &c, 1);
 4b1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4b4:	83 c3 01             	add    $0x1,%ebx
 4b7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4be:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4bf:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4c1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c5:	89 34 24             	mov    %esi,(%esp)
 4c8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4cb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 4cf:	e8 de fd ff ff       	call   2b2 <write>
        putc(fd, c);
 4d4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 4d7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4da:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4e1:	00 
 4e2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4e6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 4e9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4ec:	e8 c1 fd ff ff       	call   2b2 <write>
  for(i = 0; fmt[i]; i++){
 4f1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 4f5:	84 d2                	test   %dl,%dl
 4f7:	0f 85 6d ff ff ff    	jne    46a <printf+0x5a>
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 500:	83 c4 3c             	add    $0x3c,%esp
 503:	5b                   	pop    %ebx
 504:	5e                   	pop    %esi
 505:	5f                   	pop    %edi
 506:	5d                   	pop    %ebp
 507:	c3                   	ret    
        state = '%';
 508:	bf 25 00 00 00       	mov    $0x25,%edi
 50d:	e9 49 ff ff ff       	jmp    45b <printf+0x4b>
 512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 518:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 51f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 524:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 527:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 529:	8b 10                	mov    (%eax),%edx
 52b:	89 f0                	mov    %esi,%eax
 52d:	e8 3e fe ff ff       	call   370 <printint>
        ap++;
 532:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 536:	e9 20 ff ff ff       	jmp    45b <printf+0x4b>
 53b:	90                   	nop
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 540:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 543:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 54a:	00 
 54b:	89 44 24 04          	mov    %eax,0x4(%esp)
 54f:	89 34 24             	mov    %esi,(%esp)
 552:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 556:	e8 57 fd ff ff       	call   2b2 <write>
 55b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 55e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 565:	00 
 566:	89 44 24 04          	mov    %eax,0x4(%esp)
 56a:	89 34 24             	mov    %esi,(%esp)
 56d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 571:	e8 3c fd ff ff       	call   2b2 <write>
        printint(fd, *ap, 16, 0);
 576:	b9 10 00 00 00       	mov    $0x10,%ecx
 57b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 582:	eb a0                	jmp    524 <printf+0x114>
 584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 588:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 58b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 58f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 591:	b8 ec 08 00 00       	mov    $0x8ec,%eax
 596:	85 ff                	test   %edi,%edi
 598:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 59b:	0f b6 07             	movzbl (%edi),%eax
 59e:	84 c0                	test   %al,%al
 5a0:	74 2a                	je     5cc <printf+0x1bc>
 5a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5a8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5ab:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 5ae:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 5b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b8:	00 
 5b9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5bd:	89 34 24             	mov    %esi,(%esp)
 5c0:	e8 ed fc ff ff       	call   2b2 <write>
        while(*s != 0){
 5c5:	0f b6 07             	movzbl (%edi),%eax
 5c8:	84 c0                	test   %al,%al
 5ca:	75 dc                	jne    5a8 <printf+0x198>
      state = 0;
 5cc:	31 ff                	xor    %edi,%edi
 5ce:	e9 88 fe ff ff       	jmp    45b <printf+0x4b>
        putc(fd, *ap);
 5d3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5d6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 5d8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5da:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5e1:	00 
 5e2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5e5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5e8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ef:	e8 be fc ff ff       	call   2b2 <write>
        ap++;
 5f4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5f8:	e9 5e fe ff ff       	jmp    45b <printf+0x4b>
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 600:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 603:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 605:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 60c:	00 
 60d:	89 44 24 04          	mov    %eax,0x4(%esp)
 611:	89 34 24             	mov    %esi,(%esp)
 614:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 618:	e8 95 fc ff ff       	call   2b2 <write>
 61d:	e9 39 fe ff ff       	jmp    45b <printf+0x4b>
 622:	66 90                	xchg   %ax,%ax
 624:	66 90                	xchg   %ax,%ax
 626:	66 90                	xchg   %ax,%ax
 628:	66 90                	xchg   %ax,%ax
 62a:	66 90                	xchg   %ax,%ax
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 24 0c 00 00       	mov    0xc24,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 63e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 640:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 643:	39 d0                	cmp    %edx,%eax
 645:	72 11                	jb     658 <free+0x28>
 647:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 648:	39 c8                	cmp    %ecx,%eax
 64a:	72 04                	jb     650 <free+0x20>
 64c:	39 ca                	cmp    %ecx,%edx
 64e:	72 10                	jb     660 <free+0x30>
 650:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 652:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 654:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 656:	73 f0                	jae    648 <free+0x18>
 658:	39 ca                	cmp    %ecx,%edx
 65a:	72 04                	jb     660 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65c:	39 c8                	cmp    %ecx,%eax
 65e:	72 f0                	jb     650 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 660:	8b 73 fc             	mov    -0x4(%ebx),%esi
 663:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 666:	39 cf                	cmp    %ecx,%edi
 668:	74 1e                	je     688 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 66a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 66d:	8b 48 04             	mov    0x4(%eax),%ecx
 670:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 673:	39 f2                	cmp    %esi,%edx
 675:	74 28                	je     69f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 677:	89 10                	mov    %edx,(%eax)
  freep = p;
 679:	a3 24 0c 00 00       	mov    %eax,0xc24
}
 67e:	5b                   	pop    %ebx
 67f:	5e                   	pop    %esi
 680:	5f                   	pop    %edi
 681:	5d                   	pop    %ebp
 682:	c3                   	ret    
 683:	90                   	nop
 684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 688:	03 71 04             	add    0x4(%ecx),%esi
 68b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 68e:	8b 08                	mov    (%eax),%ecx
 690:	8b 09                	mov    (%ecx),%ecx
 692:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 695:	8b 48 04             	mov    0x4(%eax),%ecx
 698:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 69b:	39 f2                	cmp    %esi,%edx
 69d:	75 d8                	jne    677 <free+0x47>
    p->s.size += bp->s.size;
 69f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 6a2:	a3 24 0c 00 00       	mov    %eax,0xc24
    p->s.size += bp->s.size;
 6a7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6aa:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6ad:	89 10                	mov    %edx,(%eax)
}
 6af:	5b                   	pop    %ebx
 6b0:	5e                   	pop    %esi
 6b1:	5f                   	pop    %edi
 6b2:	5d                   	pop    %ebp
 6b3:	c3                   	ret    
 6b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 1d 24 0c 00 00    	mov    0xc24,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 48 07             	lea    0x7(%eax),%ecx
 6d5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 6d8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6da:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 6dd:	0f 84 9b 00 00 00    	je     77e <malloc+0xbe>
 6e3:	8b 13                	mov    (%ebx),%edx
 6e5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6e8:	39 fe                	cmp    %edi,%esi
 6ea:	76 64                	jbe    750 <malloc+0x90>
 6ec:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 6f3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 6f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 6fb:	eb 0e                	jmp    70b <malloc+0x4b>
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 700:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 702:	8b 78 04             	mov    0x4(%eax),%edi
 705:	39 fe                	cmp    %edi,%esi
 707:	76 4f                	jbe    758 <malloc+0x98>
 709:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 70b:	3b 15 24 0c 00 00    	cmp    0xc24,%edx
 711:	75 ed                	jne    700 <malloc+0x40>
  if(nu < 4096)
 713:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 716:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 71c:	bf 00 10 00 00       	mov    $0x1000,%edi
 721:	0f 43 fe             	cmovae %esi,%edi
 724:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 727:	89 04 24             	mov    %eax,(%esp)
 72a:	e8 eb fb ff ff       	call   31a <sbrk>
  if(p == (char*)-1)
 72f:	83 f8 ff             	cmp    $0xffffffff,%eax
 732:	74 18                	je     74c <malloc+0x8c>
  hp->s.size = nu;
 734:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 737:	83 c0 08             	add    $0x8,%eax
 73a:	89 04 24             	mov    %eax,(%esp)
 73d:	e8 ee fe ff ff       	call   630 <free>
  return freep;
 742:	8b 15 24 0c 00 00    	mov    0xc24,%edx
      if((p = morecore(nunits)) == 0)
 748:	85 d2                	test   %edx,%edx
 74a:	75 b4                	jne    700 <malloc+0x40>
        return 0;
 74c:	31 c0                	xor    %eax,%eax
 74e:	eb 20                	jmp    770 <malloc+0xb0>
    if(p->s.size >= nunits){
 750:	89 d0                	mov    %edx,%eax
 752:	89 da                	mov    %ebx,%edx
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 758:	39 fe                	cmp    %edi,%esi
 75a:	74 1c                	je     778 <malloc+0xb8>
        p->s.size -= nunits;
 75c:	29 f7                	sub    %esi,%edi
 75e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 761:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 764:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 767:	89 15 24 0c 00 00    	mov    %edx,0xc24
      return (void*)(p + 1);
 76d:	83 c0 08             	add    $0x8,%eax
  }
}
 770:	83 c4 1c             	add    $0x1c,%esp
 773:	5b                   	pop    %ebx
 774:	5e                   	pop    %esi
 775:	5f                   	pop    %edi
 776:	5d                   	pop    %ebp
 777:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 778:	8b 08                	mov    (%eax),%ecx
 77a:	89 0a                	mov    %ecx,(%edx)
 77c:	eb e9                	jmp    767 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 77e:	c7 05 24 0c 00 00 28 	movl   $0xc28,0xc24
 785:	0c 00 00 
    base.s.size = 0;
 788:	ba 28 0c 00 00       	mov    $0xc28,%edx
    base.s.ptr = freep = prevp = &base;
 78d:	c7 05 28 0c 00 00 28 	movl   $0xc28,0xc28
 794:	0c 00 00 
    base.s.size = 0;
 797:	c7 05 2c 0c 00 00 00 	movl   $0x0,0xc2c
 79e:	00 00 00 
 7a1:	e9 46 ff ff ff       	jmp    6ec <malloc+0x2c>
 7a6:	66 90                	xchg   %ax,%ax
 7a8:	66 90                	xchg   %ax,%ax
 7aa:	66 90                	xchg   %ax,%ax
 7ac:	66 90                	xchg   %ax,%ax
 7ae:	66 90                	xchg   %ax,%ax

000007b0 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	53                   	push   %ebx
 7b4:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 7b7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 7be:	e8 fd fe ff ff       	call   6c0 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 7c3:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 7ca:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 7cc:	e8 ef fe ff ff       	call   6c0 <malloc>
    if (tstack == NULL) {
 7d1:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 7d3:	89 c2                	mov    %eax,%edx
 7d5:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 7d8:	0f 84 8a 00 00 00    	je     868 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 7de:	25 ff 0f 00 00       	and    $0xfff,%eax
 7e3:	75 73                	jne    858 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 7e5:	8b 45 10             	mov    0x10(%ebp),%eax
 7e8:	89 54 24 08          	mov    %edx,0x8(%esp)
 7ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 7f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 7f3:	89 04 24             	mov    %eax,(%esp)
 7f6:	e8 57 fb ff ff       	call   352 <kthread_create>
 7fb:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 7fd:	89 44 24 10          	mov    %eax,0x10(%esp)
 801:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 808:	00 
 809:	c7 44 24 08 04 09 00 	movl   $0x904,0x8(%esp)
 810:	00 
 811:	c7 44 24 04 13 09 00 	movl   $0x913,0x4(%esp)
 818:	00 
 819:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 820:	e8 eb fb ff ff       	call   410 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 825:	8b 03                	mov    (%ebx),%eax
 827:	c7 44 24 04 2a 09 00 	movl   $0x92a,0x4(%esp)
 82e:	00 
 82f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 836:	89 44 24 08          	mov    %eax,0x8(%esp)
 83a:	e8 d1 fb ff ff       	call   410 <printf>
    
    if (bt->tid != 0) {
 83f:	8b 03                	mov    (%ebx),%eax
 841:	85 c0                	test   %eax,%eax
 843:	74 23                	je     868 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 845:	8b 45 08             	mov    0x8(%ebp),%eax
 848:	89 18                	mov    %ebx,(%eax)
        return 0;
 84a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 84c:	83 c4 24             	add    $0x24,%esp
 84f:	5b                   	pop    %ebx
 850:	5d                   	pop    %ebp
 851:	c3                   	ret    
 852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 858:	29 c2                	sub    %eax,%edx
 85a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 860:	eb 83                	jmp    7e5 <benny_thread_create+0x35>
 862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 868:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 86d:	eb dd                	jmp    84c <benny_thread_create+0x9c>
 86f:	90                   	nop

00000870 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 873:	8b 45 08             	mov    0x8(%ebp),%eax
}
 876:	5d                   	pop    %ebp
    return bt->tid;
 877:	8b 00                	mov    (%eax),%eax
}
 879:	c3                   	ret    
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000880 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	53                   	push   %ebx
 884:	83 ec 14             	sub    $0x14,%esp
 887:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 88a:	8b 03                	mov    (%ebx),%eax
 88c:	89 04 24             	mov    %eax,(%esp)
 88f:	e8 c6 fa ff ff       	call   35a <kthread_join>
    if (retVal == 0) {
 894:	85 c0                	test   %eax,%eax
 896:	75 11                	jne    8a9 <benny_thread_join+0x29>
        free(bt->tstack);
 898:	8b 53 04             	mov    0x4(%ebx),%edx
 89b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 89e:	89 14 24             	mov    %edx,(%esp)
 8a1:	e8 8a fd ff ff       	call   630 <free>
 8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 8a9:	83 c4 14             	add    $0x14,%esp
 8ac:	5b                   	pop    %ebx
 8ad:	5d                   	pop    %ebp
 8ae:	c3                   	ret    
 8af:	90                   	nop

000008b0 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 8b6:	8b 45 08             	mov    0x8(%ebp),%eax
 8b9:	89 04 24             	mov    %eax,(%esp)
 8bc:	e8 a1 fa ff ff       	call   362 <kthread_exit>
    return 0;
}
 8c1:	31 c0                	xor    %eax,%eax
 8c3:	c9                   	leave  
 8c4:	c3                   	ret    
