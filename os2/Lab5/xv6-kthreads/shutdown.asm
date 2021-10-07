
_shutdown:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
    halt();
   6:	e8 df 02 00 00       	call   2ea <halt>
    exit();
   b:	e8 22 02 00 00       	call   232 <exit>

00000010 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	8b 45 08             	mov    0x8(%ebp),%eax
  16:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  19:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  1a:	89 c2                	mov    %eax,%edx
  1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  20:	83 c1 01             	add    $0x1,%ecx
  23:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  27:	83 c2 01             	add    $0x1,%edx
  2a:	84 db                	test   %bl,%bl
  2c:	88 5a ff             	mov    %bl,-0x1(%edx)
  2f:	75 ef                	jne    20 <strcpy+0x10>
    ;
  return os;
}
  31:	5b                   	pop    %ebx
  32:	5d                   	pop    %ebp
  33:	c3                   	ret    
  34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	8b 55 08             	mov    0x8(%ebp),%edx
  46:	53                   	push   %ebx
  47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  4a:	0f b6 02             	movzbl (%edx),%eax
  4d:	84 c0                	test   %al,%al
  4f:	74 2d                	je     7e <strcmp+0x3e>
  51:	0f b6 19             	movzbl (%ecx),%ebx
  54:	38 d8                	cmp    %bl,%al
  56:	74 0e                	je     66 <strcmp+0x26>
  58:	eb 2b                	jmp    85 <strcmp+0x45>
  5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  60:	38 c8                	cmp    %cl,%al
  62:	75 15                	jne    79 <strcmp+0x39>
    p++, q++;
  64:	89 d9                	mov    %ebx,%ecx
  66:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  69:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  6c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  6f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  73:	84 c0                	test   %al,%al
  75:	75 e9                	jne    60 <strcmp+0x20>
  77:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  79:	29 c8                	sub    %ecx,%eax
}
  7b:	5b                   	pop    %ebx
  7c:	5d                   	pop    %ebp
  7d:	c3                   	ret    
  7e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  81:	31 c0                	xor    %eax,%eax
  83:	eb f4                	jmp    79 <strcmp+0x39>
  85:	0f b6 cb             	movzbl %bl,%ecx
  88:	eb ef                	jmp    79 <strcmp+0x39>
  8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  96:	80 39 00             	cmpb   $0x0,(%ecx)
  99:	74 12                	je     ad <strlen+0x1d>
  9b:	31 d2                	xor    %edx,%edx
  9d:	8d 76 00             	lea    0x0(%esi),%esi
  a0:	83 c2 01             	add    $0x1,%edx
  a3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  a7:	89 d0                	mov    %edx,%eax
  a9:	75 f5                	jne    a0 <strlen+0x10>
    ;
  return n;
}
  ab:	5d                   	pop    %ebp
  ac:	c3                   	ret    
  for(n = 0; s[n]; n++)
  ad:	31 c0                	xor    %eax,%eax
}
  af:	5d                   	pop    %ebp
  b0:	c3                   	ret    
  b1:	eb 0d                	jmp    c0 <memset>
  b3:	90                   	nop
  b4:	90                   	nop
  b5:	90                   	nop
  b6:	90                   	nop
  b7:	90                   	nop
  b8:	90                   	nop
  b9:	90                   	nop
  ba:	90                   	nop
  bb:	90                   	nop
  bc:	90                   	nop
  bd:	90                   	nop
  be:	90                   	nop
  bf:	90                   	nop

000000c0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 55 08             	mov    0x8(%ebp),%edx
  c6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  cd:	89 d7                	mov    %edx,%edi
  cf:	fc                   	cld    
  d0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  d2:	89 d0                	mov    %edx,%eax
  d4:	5f                   	pop    %edi
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strchr>:

char*
strchr(const char *s, char c)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	53                   	push   %ebx
  e7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
  ea:	0f b6 18             	movzbl (%eax),%ebx
  ed:	84 db                	test   %bl,%bl
  ef:	74 1d                	je     10e <strchr+0x2e>
    if(*s == c)
  f1:	38 d3                	cmp    %dl,%bl
  f3:	89 d1                	mov    %edx,%ecx
  f5:	75 0d                	jne    104 <strchr+0x24>
  f7:	eb 17                	jmp    110 <strchr+0x30>
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 100:	38 ca                	cmp    %cl,%dl
 102:	74 0c                	je     110 <strchr+0x30>
  for(; *s; s++)
 104:	83 c0 01             	add    $0x1,%eax
 107:	0f b6 10             	movzbl (%eax),%edx
 10a:	84 d2                	test   %dl,%dl
 10c:	75 f2                	jne    100 <strchr+0x20>
      return (char*)s;
  return 0;
 10e:	31 c0                	xor    %eax,%eax
}
 110:	5b                   	pop    %ebx
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <gets>:

char*
gets(char *buf, int max)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 125:	31 f6                	xor    %esi,%esi
{
 127:	53                   	push   %ebx
 128:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 12b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 12e:	eb 31                	jmp    161 <gets+0x41>
    cc = read(0, &c, 1);
 130:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 137:	00 
 138:	89 7c 24 04          	mov    %edi,0x4(%esp)
 13c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 143:	e8 02 01 00 00       	call   24a <read>
    if(cc < 1)
 148:	85 c0                	test   %eax,%eax
 14a:	7e 1d                	jle    169 <gets+0x49>
      break;
    buf[i++] = c;
 14c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 150:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 152:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 155:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 157:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 15b:	74 0c                	je     169 <gets+0x49>
 15d:	3c 0a                	cmp    $0xa,%al
 15f:	74 08                	je     169 <gets+0x49>
  for(i=0; i+1 < max; ){
 161:	8d 5e 01             	lea    0x1(%esi),%ebx
 164:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 167:	7c c7                	jl     130 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 170:	83 c4 2c             	add    $0x2c,%esp
 173:	5b                   	pop    %ebx
 174:	5e                   	pop    %esi
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    
 178:	90                   	nop
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000180 <stat>:

int
stat(const char *n, struct stat *st)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	56                   	push   %esi
 184:	53                   	push   %ebx
 185:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 192:	00 
 193:	89 04 24             	mov    %eax,(%esp)
 196:	e8 d7 00 00 00       	call   272 <open>
  if(fd < 0)
 19b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 19d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 19f:	78 27                	js     1c8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a4:	89 1c 24             	mov    %ebx,(%esp)
 1a7:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ab:	e8 da 00 00 00       	call   28a <fstat>
  close(fd);
 1b0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1b3:	89 c6                	mov    %eax,%esi
  close(fd);
 1b5:	e8 a0 00 00 00       	call   25a <close>
  return r;
 1ba:	89 f0                	mov    %esi,%eax
}
 1bc:	83 c4 10             	add    $0x10,%esp
 1bf:	5b                   	pop    %ebx
 1c0:	5e                   	pop    %esi
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    
 1c3:	90                   	nop
 1c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 1c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1cd:	eb ed                	jmp    1bc <stat+0x3c>
 1cf:	90                   	nop

000001d0 <atoi>:

int
atoi(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d7:	0f be 11             	movsbl (%ecx),%edx
 1da:	8d 42 d0             	lea    -0x30(%edx),%eax
 1dd:	3c 09                	cmp    $0x9,%al
  n = 0;
 1df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1e4:	77 17                	ja     1fd <atoi+0x2d>
 1e6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1e8:	83 c1 01             	add    $0x1,%ecx
 1eb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1ee:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 1f2:	0f be 11             	movsbl (%ecx),%edx
 1f5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1f8:	80 fb 09             	cmp    $0x9,%bl
 1fb:	76 eb                	jbe    1e8 <atoi+0x18>
  return n;
}
 1fd:	5b                   	pop    %ebx
 1fe:	5d                   	pop    %ebp
 1ff:	c3                   	ret    

00000200 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 200:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 201:	31 d2                	xor    %edx,%edx
{
 203:	89 e5                	mov    %esp,%ebp
 205:	56                   	push   %esi
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	53                   	push   %ebx
 20a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 20d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 210:	85 db                	test   %ebx,%ebx
 212:	7e 12                	jle    226 <memmove+0x26>
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 218:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 21c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 21f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 222:	39 da                	cmp    %ebx,%edx
 224:	75 f2                	jne    218 <memmove+0x18>
  return vdst;
}
 226:	5b                   	pop    %ebx
 227:	5e                   	pop    %esi
 228:	5d                   	pop    %ebp
 229:	c3                   	ret    

0000022a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 22a:	b8 01 00 00 00       	mov    $0x1,%eax
 22f:	cd 40                	int    $0x40
 231:	c3                   	ret    

00000232 <exit>:
SYSCALL(exit)
 232:	b8 02 00 00 00       	mov    $0x2,%eax
 237:	cd 40                	int    $0x40
 239:	c3                   	ret    

0000023a <wait>:
SYSCALL(wait)
 23a:	b8 03 00 00 00       	mov    $0x3,%eax
 23f:	cd 40                	int    $0x40
 241:	c3                   	ret    

00000242 <pipe>:
SYSCALL(pipe)
 242:	b8 04 00 00 00       	mov    $0x4,%eax
 247:	cd 40                	int    $0x40
 249:	c3                   	ret    

0000024a <read>:
SYSCALL(read)
 24a:	b8 05 00 00 00       	mov    $0x5,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <write>:
SYSCALL(write)
 252:	b8 10 00 00 00       	mov    $0x10,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <close>:
SYSCALL(close)
 25a:	b8 15 00 00 00       	mov    $0x15,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <kill>:
SYSCALL(kill)
 262:	b8 06 00 00 00       	mov    $0x6,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <exec>:
SYSCALL(exec)
 26a:	b8 07 00 00 00       	mov    $0x7,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <open>:
SYSCALL(open)
 272:	b8 0f 00 00 00       	mov    $0xf,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <mknod>:
SYSCALL(mknod)
 27a:	b8 11 00 00 00       	mov    $0x11,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <unlink>:
SYSCALL(unlink)
 282:	b8 12 00 00 00       	mov    $0x12,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <fstat>:
SYSCALL(fstat)
 28a:	b8 08 00 00 00       	mov    $0x8,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <link>:
SYSCALL(link)
 292:	b8 13 00 00 00       	mov    $0x13,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <mkdir>:
SYSCALL(mkdir)
 29a:	b8 14 00 00 00       	mov    $0x14,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <chdir>:
SYSCALL(chdir)
 2a2:	b8 09 00 00 00       	mov    $0x9,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <dup>:
SYSCALL(dup)
 2aa:	b8 0a 00 00 00       	mov    $0xa,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <getpid>:
SYSCALL(getpid)
 2b2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <sbrk>:
SYSCALL(sbrk)
 2ba:	b8 0c 00 00 00       	mov    $0xc,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <sleep>:
SYSCALL(sleep)
 2c2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <uptime>:
SYSCALL(uptime)
 2ca:	b8 0e 00 00 00       	mov    $0xe,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 2d2:	b8 16 00 00 00       	mov    $0x16,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 2da:	b8 17 00 00 00       	mov    $0x17,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 2e2:	b8 18 00 00 00       	mov    $0x18,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <halt>:
SYSCALL(halt)
 2ea:	b8 19 00 00 00       	mov    $0x19,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 2f2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <kthread_join>:
SYSCALL(kthread_join)
 2fa:	b8 1b 00 00 00       	mov    $0x1b,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <kthread_exit>:
SYSCALL(kthread_exit)
 302:	b8 1c 00 00 00       	mov    $0x1c,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    
 30a:	66 90                	xchg   %ax,%ax
 30c:	66 90                	xchg   %ax,%ax
 30e:	66 90                	xchg   %ax,%ax

00000310 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	89 c6                	mov    %eax,%esi
 317:	53                   	push   %ebx
 318:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 31b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 31e:	85 db                	test   %ebx,%ebx
 320:	74 09                	je     32b <printint+0x1b>
 322:	89 d0                	mov    %edx,%eax
 324:	c1 e8 1f             	shr    $0x1f,%eax
 327:	84 c0                	test   %al,%al
 329:	75 75                	jne    3a0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 32b:	89 d0                	mov    %edx,%eax
  neg = 0;
 32d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 334:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 337:	31 ff                	xor    %edi,%edi
 339:	89 ce                	mov    %ecx,%esi
 33b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 33e:	eb 02                	jmp    342 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 340:	89 cf                	mov    %ecx,%edi
 342:	31 d2                	xor    %edx,%edx
 344:	f7 f6                	div    %esi
 346:	8d 4f 01             	lea    0x1(%edi),%ecx
 349:	0f b6 92 6c 08 00 00 	movzbl 0x86c(%edx),%edx
  }while((x /= base) != 0);
 350:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 352:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 355:	75 e9                	jne    340 <printint+0x30>
  if(neg)
 357:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 35a:	89 c8                	mov    %ecx,%eax
 35c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 35f:	85 d2                	test   %edx,%edx
 361:	74 08                	je     36b <printint+0x5b>
    buf[i++] = '-';
 363:	8d 4f 02             	lea    0x2(%edi),%ecx
 366:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 36b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 36e:	66 90                	xchg   %ax,%ax
 370:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 375:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 378:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 37f:	00 
 380:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 384:	89 34 24             	mov    %esi,(%esp)
 387:	88 45 d7             	mov    %al,-0x29(%ebp)
 38a:	e8 c3 fe ff ff       	call   252 <write>
  while(--i >= 0)
 38f:	83 ff ff             	cmp    $0xffffffff,%edi
 392:	75 dc                	jne    370 <printint+0x60>
    putc(fd, buf[i]);
}
 394:	83 c4 4c             	add    $0x4c,%esp
 397:	5b                   	pop    %ebx
 398:	5e                   	pop    %esi
 399:	5f                   	pop    %edi
 39a:	5d                   	pop    %ebp
 39b:	c3                   	ret    
 39c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 3a0:	89 d0                	mov    %edx,%eax
 3a2:	f7 d8                	neg    %eax
    neg = 1;
 3a4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 3ab:	eb 87                	jmp    334 <printint+0x24>
 3ad:	8d 76 00             	lea    0x0(%esi),%esi

000003b0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3b4:	31 ff                	xor    %edi,%edi
{
 3b6:	56                   	push   %esi
 3b7:	53                   	push   %ebx
 3b8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3bb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 3be:	8d 45 10             	lea    0x10(%ebp),%eax
{
 3c1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 3c4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 3c7:	0f b6 13             	movzbl (%ebx),%edx
 3ca:	83 c3 01             	add    $0x1,%ebx
 3cd:	84 d2                	test   %dl,%dl
 3cf:	75 39                	jne    40a <printf+0x5a>
 3d1:	e9 ca 00 00 00       	jmp    4a0 <printf+0xf0>
 3d6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 3d8:	83 fa 25             	cmp    $0x25,%edx
 3db:	0f 84 c7 00 00 00    	je     4a8 <printf+0xf8>
  write(fd, &c, 1);
 3e1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 3e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3eb:	00 
 3ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 3f0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 3f3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 3f6:	e8 57 fe ff ff       	call   252 <write>
 3fb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 3fe:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 402:	84 d2                	test   %dl,%dl
 404:	0f 84 96 00 00 00    	je     4a0 <printf+0xf0>
    if(state == 0){
 40a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 40c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 40f:	74 c7                	je     3d8 <printf+0x28>
      }
    } else if(state == '%'){
 411:	83 ff 25             	cmp    $0x25,%edi
 414:	75 e5                	jne    3fb <printf+0x4b>
      if(c == 'd' || c == 'u'){
 416:	83 fa 75             	cmp    $0x75,%edx
 419:	0f 84 99 00 00 00    	je     4b8 <printf+0x108>
 41f:	83 fa 64             	cmp    $0x64,%edx
 422:	0f 84 90 00 00 00    	je     4b8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 428:	25 f7 00 00 00       	and    $0xf7,%eax
 42d:	83 f8 70             	cmp    $0x70,%eax
 430:	0f 84 aa 00 00 00    	je     4e0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 436:	83 fa 73             	cmp    $0x73,%edx
 439:	0f 84 e9 00 00 00    	je     528 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 43f:	83 fa 63             	cmp    $0x63,%edx
 442:	0f 84 2b 01 00 00    	je     573 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 448:	83 fa 25             	cmp    $0x25,%edx
 44b:	0f 84 4f 01 00 00    	je     5a0 <printf+0x1f0>
  write(fd, &c, 1);
 451:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 454:	83 c3 01             	add    $0x1,%ebx
 457:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 45e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 45f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 461:	89 44 24 04          	mov    %eax,0x4(%esp)
 465:	89 34 24             	mov    %esi,(%esp)
 468:	89 55 d0             	mov    %edx,-0x30(%ebp)
 46b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 46f:	e8 de fd ff ff       	call   252 <write>
        putc(fd, c);
 474:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 477:	8d 45 e7             	lea    -0x19(%ebp),%eax
 47a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 481:	00 
 482:	89 44 24 04          	mov    %eax,0x4(%esp)
 486:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 489:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 48c:	e8 c1 fd ff ff       	call   252 <write>
  for(i = 0; fmt[i]; i++){
 491:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 495:	84 d2                	test   %dl,%dl
 497:	0f 85 6d ff ff ff    	jne    40a <printf+0x5a>
 49d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 4a0:	83 c4 3c             	add    $0x3c,%esp
 4a3:	5b                   	pop    %ebx
 4a4:	5e                   	pop    %esi
 4a5:	5f                   	pop    %edi
 4a6:	5d                   	pop    %ebp
 4a7:	c3                   	ret    
        state = '%';
 4a8:	bf 25 00 00 00       	mov    $0x25,%edi
 4ad:	e9 49 ff ff ff       	jmp    3fb <printf+0x4b>
 4b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 4b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4bf:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 4c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 4c7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 4c9:	8b 10                	mov    (%eax),%edx
 4cb:	89 f0                	mov    %esi,%eax
 4cd:	e8 3e fe ff ff       	call   310 <printint>
        ap++;
 4d2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 4d6:	e9 20 ff ff ff       	jmp    3fb <printf+0x4b>
 4db:	90                   	nop
 4dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 4e0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 4e3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ea:	00 
 4eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 4ef:	89 34 24             	mov    %esi,(%esp)
 4f2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 4f6:	e8 57 fd ff ff       	call   252 <write>
 4fb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4fe:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 505:	00 
 506:	89 44 24 04          	mov    %eax,0x4(%esp)
 50a:	89 34 24             	mov    %esi,(%esp)
 50d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 511:	e8 3c fd ff ff       	call   252 <write>
        printint(fd, *ap, 16, 0);
 516:	b9 10 00 00 00       	mov    $0x10,%ecx
 51b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 522:	eb a0                	jmp    4c4 <printf+0x114>
 524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 528:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 52b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 52f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 531:	b8 65 08 00 00       	mov    $0x865,%eax
 536:	85 ff                	test   %edi,%edi
 538:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 53b:	0f b6 07             	movzbl (%edi),%eax
 53e:	84 c0                	test   %al,%al
 540:	74 2a                	je     56c <printf+0x1bc>
 542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 548:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 54b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 54e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 551:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 558:	00 
 559:	89 44 24 04          	mov    %eax,0x4(%esp)
 55d:	89 34 24             	mov    %esi,(%esp)
 560:	e8 ed fc ff ff       	call   252 <write>
        while(*s != 0){
 565:	0f b6 07             	movzbl (%edi),%eax
 568:	84 c0                	test   %al,%al
 56a:	75 dc                	jne    548 <printf+0x198>
      state = 0;
 56c:	31 ff                	xor    %edi,%edi
 56e:	e9 88 fe ff ff       	jmp    3fb <printf+0x4b>
        putc(fd, *ap);
 573:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 576:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 578:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 57a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 581:	00 
 582:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 585:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 588:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 58b:	89 44 24 04          	mov    %eax,0x4(%esp)
 58f:	e8 be fc ff ff       	call   252 <write>
        ap++;
 594:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 598:	e9 5e fe ff ff       	jmp    3fb <printf+0x4b>
 59d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5a0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 5a3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5a5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ac:	00 
 5ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b1:	89 34 24             	mov    %esi,(%esp)
 5b4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 5b8:	e8 95 fc ff ff       	call   252 <write>
 5bd:	e9 39 fe ff ff       	jmp    3fb <printf+0x4b>
 5c2:	66 90                	xchg   %ax,%ax
 5c4:	66 90                	xchg   %ax,%ax
 5c6:	66 90                	xchg   %ax,%ax
 5c8:	66 90                	xchg   %ax,%ax
 5ca:	66 90                	xchg   %ax,%ax
 5cc:	66 90                	xchg   %ax,%ax
 5ce:	66 90                	xchg   %ax,%ax

000005d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d1:	a1 a0 0b 00 00       	mov    0xba0,%eax
{
 5d6:	89 e5                	mov    %esp,%ebp
 5d8:	57                   	push   %edi
 5d9:	56                   	push   %esi
 5da:	53                   	push   %ebx
 5db:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5de:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 5e0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e3:	39 d0                	cmp    %edx,%eax
 5e5:	72 11                	jb     5f8 <free+0x28>
 5e7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e8:	39 c8                	cmp    %ecx,%eax
 5ea:	72 04                	jb     5f0 <free+0x20>
 5ec:	39 ca                	cmp    %ecx,%edx
 5ee:	72 10                	jb     600 <free+0x30>
 5f0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f6:	73 f0                	jae    5e8 <free+0x18>
 5f8:	39 ca                	cmp    %ecx,%edx
 5fa:	72 04                	jb     600 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5fc:	39 c8                	cmp    %ecx,%eax
 5fe:	72 f0                	jb     5f0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 600:	8b 73 fc             	mov    -0x4(%ebx),%esi
 603:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 606:	39 cf                	cmp    %ecx,%edi
 608:	74 1e                	je     628 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 60a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 60d:	8b 48 04             	mov    0x4(%eax),%ecx
 610:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 613:	39 f2                	cmp    %esi,%edx
 615:	74 28                	je     63f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 617:	89 10                	mov    %edx,(%eax)
  freep = p;
 619:	a3 a0 0b 00 00       	mov    %eax,0xba0
}
 61e:	5b                   	pop    %ebx
 61f:	5e                   	pop    %esi
 620:	5f                   	pop    %edi
 621:	5d                   	pop    %ebp
 622:	c3                   	ret    
 623:	90                   	nop
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 628:	03 71 04             	add    0x4(%ecx),%esi
 62b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 62e:	8b 08                	mov    (%eax),%ecx
 630:	8b 09                	mov    (%ecx),%ecx
 632:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 635:	8b 48 04             	mov    0x4(%eax),%ecx
 638:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 63b:	39 f2                	cmp    %esi,%edx
 63d:	75 d8                	jne    617 <free+0x47>
    p->s.size += bp->s.size;
 63f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 642:	a3 a0 0b 00 00       	mov    %eax,0xba0
    p->s.size += bp->s.size;
 647:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 64a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 64d:	89 10                	mov    %edx,(%eax)
}
 64f:	5b                   	pop    %ebx
 650:	5e                   	pop    %esi
 651:	5f                   	pop    %edi
 652:	5d                   	pop    %ebp
 653:	c3                   	ret    
 654:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 65a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	57                   	push   %edi
 664:	56                   	push   %esi
 665:	53                   	push   %ebx
 666:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 669:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 66c:	8b 1d a0 0b 00 00    	mov    0xba0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 672:	8d 48 07             	lea    0x7(%eax),%ecx
 675:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 678:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 67a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 67d:	0f 84 9b 00 00 00    	je     71e <malloc+0xbe>
 683:	8b 13                	mov    (%ebx),%edx
 685:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 688:	39 fe                	cmp    %edi,%esi
 68a:	76 64                	jbe    6f0 <malloc+0x90>
 68c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 693:	bb 00 80 00 00       	mov    $0x8000,%ebx
 698:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 69b:	eb 0e                	jmp    6ab <malloc+0x4b>
 69d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6a2:	8b 78 04             	mov    0x4(%eax),%edi
 6a5:	39 fe                	cmp    %edi,%esi
 6a7:	76 4f                	jbe    6f8 <malloc+0x98>
 6a9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6ab:	3b 15 a0 0b 00 00    	cmp    0xba0,%edx
 6b1:	75 ed                	jne    6a0 <malloc+0x40>
  if(nu < 4096)
 6b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6bc:	bf 00 10 00 00       	mov    $0x1000,%edi
 6c1:	0f 43 fe             	cmovae %esi,%edi
 6c4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 6c7:	89 04 24             	mov    %eax,(%esp)
 6ca:	e8 eb fb ff ff       	call   2ba <sbrk>
  if(p == (char*)-1)
 6cf:	83 f8 ff             	cmp    $0xffffffff,%eax
 6d2:	74 18                	je     6ec <malloc+0x8c>
  hp->s.size = nu;
 6d4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 6d7:	83 c0 08             	add    $0x8,%eax
 6da:	89 04 24             	mov    %eax,(%esp)
 6dd:	e8 ee fe ff ff       	call   5d0 <free>
  return freep;
 6e2:	8b 15 a0 0b 00 00    	mov    0xba0,%edx
      if((p = morecore(nunits)) == 0)
 6e8:	85 d2                	test   %edx,%edx
 6ea:	75 b4                	jne    6a0 <malloc+0x40>
        return 0;
 6ec:	31 c0                	xor    %eax,%eax
 6ee:	eb 20                	jmp    710 <malloc+0xb0>
    if(p->s.size >= nunits){
 6f0:	89 d0                	mov    %edx,%eax
 6f2:	89 da                	mov    %ebx,%edx
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 6f8:	39 fe                	cmp    %edi,%esi
 6fa:	74 1c                	je     718 <malloc+0xb8>
        p->s.size -= nunits;
 6fc:	29 f7                	sub    %esi,%edi
 6fe:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 701:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 704:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 707:	89 15 a0 0b 00 00    	mov    %edx,0xba0
      return (void*)(p + 1);
 70d:	83 c0 08             	add    $0x8,%eax
  }
}
 710:	83 c4 1c             	add    $0x1c,%esp
 713:	5b                   	pop    %ebx
 714:	5e                   	pop    %esi
 715:	5f                   	pop    %edi
 716:	5d                   	pop    %ebp
 717:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 718:	8b 08                	mov    (%eax),%ecx
 71a:	89 0a                	mov    %ecx,(%edx)
 71c:	eb e9                	jmp    707 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 71e:	c7 05 a0 0b 00 00 a4 	movl   $0xba4,0xba0
 725:	0b 00 00 
    base.s.size = 0;
 728:	ba a4 0b 00 00       	mov    $0xba4,%edx
    base.s.ptr = freep = prevp = &base;
 72d:	c7 05 a4 0b 00 00 a4 	movl   $0xba4,0xba4
 734:	0b 00 00 
    base.s.size = 0;
 737:	c7 05 a8 0b 00 00 00 	movl   $0x0,0xba8
 73e:	00 00 00 
 741:	e9 46 ff ff ff       	jmp    68c <malloc+0x2c>
 746:	66 90                	xchg   %ax,%ax
 748:	66 90                	xchg   %ax,%ax
 74a:	66 90                	xchg   %ax,%ax
 74c:	66 90                	xchg   %ax,%ax
 74e:	66 90                	xchg   %ax,%ax

00000750 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	53                   	push   %ebx
 754:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 757:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 75e:	e8 fd fe ff ff       	call   660 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 763:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 76a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 76c:	e8 ef fe ff ff       	call   660 <malloc>
    if (tstack == NULL) {
 771:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 773:	89 c2                	mov    %eax,%edx
 775:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 778:	0f 84 8a 00 00 00    	je     808 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 77e:	25 ff 0f 00 00       	and    $0xfff,%eax
 783:	75 73                	jne    7f8 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 785:	8b 45 10             	mov    0x10(%ebp),%eax
 788:	89 54 24 08          	mov    %edx,0x8(%esp)
 78c:	89 44 24 04          	mov    %eax,0x4(%esp)
 790:	8b 45 0c             	mov    0xc(%ebp),%eax
 793:	89 04 24             	mov    %eax,(%esp)
 796:	e8 57 fb ff ff       	call   2f2 <kthread_create>
 79b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 79d:	89 44 24 10          	mov    %eax,0x10(%esp)
 7a1:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 7a8:	00 
 7a9:	c7 44 24 08 7d 08 00 	movl   $0x87d,0x8(%esp)
 7b0:	00 
 7b1:	c7 44 24 04 8c 08 00 	movl   $0x88c,0x4(%esp)
 7b8:	00 
 7b9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7c0:	e8 eb fb ff ff       	call   3b0 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 7c5:	8b 03                	mov    (%ebx),%eax
 7c7:	c7 44 24 04 a3 08 00 	movl   $0x8a3,0x4(%esp)
 7ce:	00 
 7cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 7d6:	89 44 24 08          	mov    %eax,0x8(%esp)
 7da:	e8 d1 fb ff ff       	call   3b0 <printf>
    
    if (bt->tid != 0) {
 7df:	8b 03                	mov    (%ebx),%eax
 7e1:	85 c0                	test   %eax,%eax
 7e3:	74 23                	je     808 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 7e5:	8b 45 08             	mov    0x8(%ebp),%eax
 7e8:	89 18                	mov    %ebx,(%eax)
        return 0;
 7ea:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 7ec:	83 c4 24             	add    $0x24,%esp
 7ef:	5b                   	pop    %ebx
 7f0:	5d                   	pop    %ebp
 7f1:	c3                   	ret    
 7f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 7f8:	29 c2                	sub    %eax,%edx
 7fa:	81 c2 00 10 00 00    	add    $0x1000,%edx
 800:	eb 83                	jmp    785 <benny_thread_create+0x35>
 802:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 808:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 80d:	eb dd                	jmp    7ec <benny_thread_create+0x9c>
 80f:	90                   	nop

00000810 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 813:	8b 45 08             	mov    0x8(%ebp),%eax
}
 816:	5d                   	pop    %ebp
    return bt->tid;
 817:	8b 00                	mov    (%eax),%eax
}
 819:	c3                   	ret    
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000820 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 820:	55                   	push   %ebp
 821:	89 e5                	mov    %esp,%ebp
 823:	53                   	push   %ebx
 824:	83 ec 14             	sub    $0x14,%esp
 827:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 82a:	8b 03                	mov    (%ebx),%eax
 82c:	89 04 24             	mov    %eax,(%esp)
 82f:	e8 c6 fa ff ff       	call   2fa <kthread_join>
    if (retVal == 0) {
 834:	85 c0                	test   %eax,%eax
 836:	75 11                	jne    849 <benny_thread_join+0x29>
        free(bt->tstack);
 838:	8b 53 04             	mov    0x4(%ebx),%edx
 83b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83e:	89 14 24             	mov    %edx,(%esp)
 841:	e8 8a fd ff ff       	call   5d0 <free>
 846:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 849:	83 c4 14             	add    $0x14,%esp
 84c:	5b                   	pop    %ebx
 84d:	5d                   	pop    %ebp
 84e:	c3                   	ret    
 84f:	90                   	nop

00000850 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 850:	55                   	push   %ebp
 851:	89 e5                	mov    %esp,%ebp
 853:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 856:	8b 45 08             	mov    0x8(%ebp),%eax
 859:	89 04 24             	mov    %eax,(%esp)
 85c:	e8 a1 fa ff ff       	call   302 <kthread_exit>
    return 0;
}
 861:	31 c0                	xor    %eax,%eax
 863:	c9                   	leave  
 864:	c3                   	ret    
