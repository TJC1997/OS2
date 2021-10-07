
_rm:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
  int i;

  if(argc < 2){
   5:	be 01 00 00 00       	mov    $0x1,%esi
{
   a:	53                   	push   %ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 7d 08             	mov    0x8(%ebp),%edi
  14:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(argc < 2){
  17:	83 ff 01             	cmp    $0x1,%edi
  1a:	8d 58 04             	lea    0x4(%eax),%ebx
  1d:	7e 3a                	jle    59 <main+0x59>
  1f:	90                   	nop
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  20:	8b 03                	mov    (%ebx),%eax
  22:	89 04 24             	mov    %eax,(%esp)
  25:	e8 c8 02 00 00       	call   2f2 <unlink>
  2a:	85 c0                	test   %eax,%eax
  2c:	78 0f                	js     3d <main+0x3d>
  for(i = 1; i < argc; i++){
  2e:	83 c6 01             	add    $0x1,%esi
  31:	83 c3 04             	add    $0x4,%ebx
  34:	39 fe                	cmp    %edi,%esi
  36:	75 e8                	jne    20 <main+0x20>
      printf(2, "rm: %s failed to delete\n", argv[i]);
      break;
    }
  }

  exit();
  38:	e8 65 02 00 00       	call   2a2 <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  3d:	8b 03                	mov    (%ebx),%eax
  3f:	c7 44 24 04 e9 08 00 	movl   $0x8e9,0x4(%esp)
  46:	00 
  47:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  4e:	89 44 24 08          	mov    %eax,0x8(%esp)
  52:	e8 c9 03 00 00       	call   420 <printf>
      break;
  57:	eb df                	jmp    38 <main+0x38>
    printf(2, "Usage: rm files...\n");
  59:	c7 44 24 04 d5 08 00 	movl   $0x8d5,0x4(%esp)
  60:	00 
  61:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  68:	e8 b3 03 00 00       	call   420 <printf>
    exit();
  6d:	e8 30 02 00 00       	call   2a2 <exit>
  72:	66 90                	xchg   %ax,%ax
  74:	66 90                	xchg   %ax,%ax
  76:	66 90                	xchg   %ax,%ax
  78:	66 90                	xchg   %ax,%ax
  7a:	66 90                	xchg   %ax,%ax
  7c:	66 90                	xchg   %ax,%ax
  7e:	66 90                	xchg   %ax,%ax

00000080 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	8b 45 08             	mov    0x8(%ebp),%eax
  86:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  89:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  8a:	89 c2                	mov    %eax,%edx
  8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  90:	83 c1 01             	add    $0x1,%ecx
  93:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  97:	83 c2 01             	add    $0x1,%edx
  9a:	84 db                	test   %bl,%bl
  9c:	88 5a ff             	mov    %bl,-0x1(%edx)
  9f:	75 ef                	jne    90 <strcpy+0x10>
    ;
  return os;
}
  a1:	5b                   	pop    %ebx
  a2:	5d                   	pop    %ebp
  a3:	c3                   	ret    
  a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 55 08             	mov    0x8(%ebp),%edx
  b6:	53                   	push   %ebx
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ba:	0f b6 02             	movzbl (%edx),%eax
  bd:	84 c0                	test   %al,%al
  bf:	74 2d                	je     ee <strcmp+0x3e>
  c1:	0f b6 19             	movzbl (%ecx),%ebx
  c4:	38 d8                	cmp    %bl,%al
  c6:	74 0e                	je     d6 <strcmp+0x26>
  c8:	eb 2b                	jmp    f5 <strcmp+0x45>
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d0:	38 c8                	cmp    %cl,%al
  d2:	75 15                	jne    e9 <strcmp+0x39>
    p++, q++;
  d4:	89 d9                	mov    %ebx,%ecx
  d6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  d9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  dc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  df:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  e3:	84 c0                	test   %al,%al
  e5:	75 e9                	jne    d0 <strcmp+0x20>
  e7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  e9:	29 c8                	sub    %ecx,%eax
}
  eb:	5b                   	pop    %ebx
  ec:	5d                   	pop    %ebp
  ed:	c3                   	ret    
  ee:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
  f1:	31 c0                	xor    %eax,%eax
  f3:	eb f4                	jmp    e9 <strcmp+0x39>
  f5:	0f b6 cb             	movzbl %bl,%ecx
  f8:	eb ef                	jmp    e9 <strcmp+0x39>
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000100 <strlen>:

uint
strlen(const char *s)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 106:	80 39 00             	cmpb   $0x0,(%ecx)
 109:	74 12                	je     11d <strlen+0x1d>
 10b:	31 d2                	xor    %edx,%edx
 10d:	8d 76 00             	lea    0x0(%esi),%esi
 110:	83 c2 01             	add    $0x1,%edx
 113:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 117:	89 d0                	mov    %edx,%eax
 119:	75 f5                	jne    110 <strlen+0x10>
    ;
  return n;
}
 11b:	5d                   	pop    %ebp
 11c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 11d:	31 c0                	xor    %eax,%eax
}
 11f:	5d                   	pop    %ebp
 120:	c3                   	ret    
 121:	eb 0d                	jmp    130 <memset>
 123:	90                   	nop
 124:	90                   	nop
 125:	90                   	nop
 126:	90                   	nop
 127:	90                   	nop
 128:	90                   	nop
 129:	90                   	nop
 12a:	90                   	nop
 12b:	90                   	nop
 12c:	90                   	nop
 12d:	90                   	nop
 12e:	90                   	nop
 12f:	90                   	nop

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 55 08             	mov    0x8(%ebp),%edx
 136:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 137:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13a:	8b 45 0c             	mov    0xc(%ebp),%eax
 13d:	89 d7                	mov    %edx,%edi
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 142:	89 d0                	mov    %edx,%eax
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	89 f6                	mov    %esi,%esi
 149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 45 08             	mov    0x8(%ebp),%eax
 156:	53                   	push   %ebx
 157:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 15a:	0f b6 18             	movzbl (%eax),%ebx
 15d:	84 db                	test   %bl,%bl
 15f:	74 1d                	je     17e <strchr+0x2e>
    if(*s == c)
 161:	38 d3                	cmp    %dl,%bl
 163:	89 d1                	mov    %edx,%ecx
 165:	75 0d                	jne    174 <strchr+0x24>
 167:	eb 17                	jmp    180 <strchr+0x30>
 169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 170:	38 ca                	cmp    %cl,%dl
 172:	74 0c                	je     180 <strchr+0x30>
  for(; *s; s++)
 174:	83 c0 01             	add    $0x1,%eax
 177:	0f b6 10             	movzbl (%eax),%edx
 17a:	84 d2                	test   %dl,%dl
 17c:	75 f2                	jne    170 <strchr+0x20>
      return (char*)s;
  return 0;
 17e:	31 c0                	xor    %eax,%eax
}
 180:	5b                   	pop    %ebx
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000190 <gets>:

char*
gets(char *buf, int max)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	31 f6                	xor    %esi,%esi
{
 197:	53                   	push   %ebx
 198:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 19b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 19e:	eb 31                	jmp    1d1 <gets+0x41>
    cc = read(0, &c, 1);
 1a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1a7:	00 
 1a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1b3:	e8 02 01 00 00       	call   2ba <read>
    if(cc < 1)
 1b8:	85 c0                	test   %eax,%eax
 1ba:	7e 1d                	jle    1d9 <gets+0x49>
      break;
    buf[i++] = c;
 1bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 1c0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 1c2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1c5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 1c7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1cb:	74 0c                	je     1d9 <gets+0x49>
 1cd:	3c 0a                	cmp    $0xa,%al
 1cf:	74 08                	je     1d9 <gets+0x49>
  for(i=0; i+1 < max; ){
 1d1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1d7:	7c c7                	jl     1a0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1d9:	8b 45 08             	mov    0x8(%ebp),%eax
 1dc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 1e0:	83 c4 2c             	add    $0x2c,%esp
 1e3:	5b                   	pop    %ebx
 1e4:	5e                   	pop    %esi
 1e5:	5f                   	pop    %edi
 1e6:	5d                   	pop    %ebp
 1e7:	c3                   	ret    
 1e8:	90                   	nop
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
 1f5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f8:	8b 45 08             	mov    0x8(%ebp),%eax
 1fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 202:	00 
 203:	89 04 24             	mov    %eax,(%esp)
 206:	e8 d7 00 00 00       	call   2e2 <open>
  if(fd < 0)
 20b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 20d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 20f:	78 27                	js     238 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 211:	8b 45 0c             	mov    0xc(%ebp),%eax
 214:	89 1c 24             	mov    %ebx,(%esp)
 217:	89 44 24 04          	mov    %eax,0x4(%esp)
 21b:	e8 da 00 00 00       	call   2fa <fstat>
  close(fd);
 220:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 223:	89 c6                	mov    %eax,%esi
  close(fd);
 225:	e8 a0 00 00 00       	call   2ca <close>
  return r;
 22a:	89 f0                	mov    %esi,%eax
}
 22c:	83 c4 10             	add    $0x10,%esp
 22f:	5b                   	pop    %ebx
 230:	5e                   	pop    %esi
 231:	5d                   	pop    %ebp
 232:	c3                   	ret    
 233:	90                   	nop
 234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 238:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 23d:	eb ed                	jmp    22c <stat+0x3c>
 23f:	90                   	nop

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
 246:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
  n = 0;
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 254:	77 17                	ja     26d <atoi+0x2d>
 256:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 258:	83 c1 01             	add    $0x1,%ecx
 25b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 25e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 262:	0f be 11             	movsbl (%ecx),%edx
 265:	8d 5a d0             	lea    -0x30(%edx),%ebx
 268:	80 fb 09             	cmp    $0x9,%bl
 26b:	76 eb                	jbe    258 <atoi+0x18>
  return n;
}
 26d:	5b                   	pop    %ebx
 26e:	5d                   	pop    %ebp
 26f:	c3                   	ret    

00000270 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 270:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 271:	31 d2                	xor    %edx,%edx
{
 273:	89 e5                	mov    %esp,%ebp
 275:	56                   	push   %esi
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	53                   	push   %ebx
 27a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 27d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 280:	85 db                	test   %ebx,%ebx
 282:	7e 12                	jle    296 <memmove+0x26>
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 288:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 28c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 28f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 292:	39 da                	cmp    %ebx,%edx
 294:	75 f2                	jne    288 <memmove+0x18>
  return vdst;
}
 296:	5b                   	pop    %ebx
 297:	5e                   	pop    %esi
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    

0000029a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 29a:	b8 01 00 00 00       	mov    $0x1,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <exit>:
SYSCALL(exit)
 2a2:	b8 02 00 00 00       	mov    $0x2,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <wait>:
SYSCALL(wait)
 2aa:	b8 03 00 00 00       	mov    $0x3,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <pipe>:
SYSCALL(pipe)
 2b2:	b8 04 00 00 00       	mov    $0x4,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <read>:
SYSCALL(read)
 2ba:	b8 05 00 00 00       	mov    $0x5,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <write>:
SYSCALL(write)
 2c2:	b8 10 00 00 00       	mov    $0x10,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <close>:
SYSCALL(close)
 2ca:	b8 15 00 00 00       	mov    $0x15,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <kill>:
SYSCALL(kill)
 2d2:	b8 06 00 00 00       	mov    $0x6,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <exec>:
SYSCALL(exec)
 2da:	b8 07 00 00 00       	mov    $0x7,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <open>:
SYSCALL(open)
 2e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <mknod>:
SYSCALL(mknod)
 2ea:	b8 11 00 00 00       	mov    $0x11,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <unlink>:
SYSCALL(unlink)
 2f2:	b8 12 00 00 00       	mov    $0x12,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <fstat>:
SYSCALL(fstat)
 2fa:	b8 08 00 00 00       	mov    $0x8,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <link>:
SYSCALL(link)
 302:	b8 13 00 00 00       	mov    $0x13,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mkdir>:
SYSCALL(mkdir)
 30a:	b8 14 00 00 00       	mov    $0x14,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <chdir>:
SYSCALL(chdir)
 312:	b8 09 00 00 00       	mov    $0x9,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <dup>:
SYSCALL(dup)
 31a:	b8 0a 00 00 00       	mov    $0xa,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <getpid>:
SYSCALL(getpid)
 322:	b8 0b 00 00 00       	mov    $0xb,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <sbrk>:
SYSCALL(sbrk)
 32a:	b8 0c 00 00 00       	mov    $0xc,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <sleep>:
SYSCALL(sleep)
 332:	b8 0d 00 00 00       	mov    $0xd,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <uptime>:
SYSCALL(uptime)
 33a:	b8 0e 00 00 00       	mov    $0xe,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 342:	b8 16 00 00 00       	mov    $0x16,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 34a:	b8 17 00 00 00       	mov    $0x17,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 352:	b8 18 00 00 00       	mov    $0x18,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <halt>:
SYSCALL(halt)
 35a:	b8 19 00 00 00       	mov    $0x19,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 362:	b8 1a 00 00 00       	mov    $0x1a,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <kthread_join>:
SYSCALL(kthread_join)
 36a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kthread_exit>:
SYSCALL(kthread_exit)
 372:	b8 1c 00 00 00       	mov    $0x1c,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    
 37a:	66 90                	xchg   %ax,%ax
 37c:	66 90                	xchg   %ax,%ax
 37e:	66 90                	xchg   %ax,%ax

00000380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	89 c6                	mov    %eax,%esi
 387:	53                   	push   %ebx
 388:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 38b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 38e:	85 db                	test   %ebx,%ebx
 390:	74 09                	je     39b <printint+0x1b>
 392:	89 d0                	mov    %edx,%eax
 394:	c1 e8 1f             	shr    $0x1f,%eax
 397:	84 c0                	test   %al,%al
 399:	75 75                	jne    410 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 39b:	89 d0                	mov    %edx,%eax
  neg = 0;
 39d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3a4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 3a7:	31 ff                	xor    %edi,%edi
 3a9:	89 ce                	mov    %ecx,%esi
 3ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3ae:	eb 02                	jmp    3b2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 3b0:	89 cf                	mov    %ecx,%edi
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	f7 f6                	div    %esi
 3b6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3b9:	0f b6 92 09 09 00 00 	movzbl 0x909(%edx),%edx
  }while((x /= base) != 0);
 3c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3c2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3c5:	75 e9                	jne    3b0 <printint+0x30>
  if(neg)
 3c7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 3ca:	89 c8                	mov    %ecx,%eax
 3cc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 3cf:	85 d2                	test   %edx,%edx
 3d1:	74 08                	je     3db <printint+0x5b>
    buf[i++] = '-';
 3d3:	8d 4f 02             	lea    0x2(%edi),%ecx
 3d6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3db:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3de:	66 90                	xchg   %ax,%ax
 3e0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 3e5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 3e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3ef:	00 
 3f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 3f4:	89 34 24             	mov    %esi,(%esp)
 3f7:	88 45 d7             	mov    %al,-0x29(%ebp)
 3fa:	e8 c3 fe ff ff       	call   2c2 <write>
  while(--i >= 0)
 3ff:	83 ff ff             	cmp    $0xffffffff,%edi
 402:	75 dc                	jne    3e0 <printint+0x60>
    putc(fd, buf[i]);
}
 404:	83 c4 4c             	add    $0x4c,%esp
 407:	5b                   	pop    %ebx
 408:	5e                   	pop    %esi
 409:	5f                   	pop    %edi
 40a:	5d                   	pop    %ebp
 40b:	c3                   	ret    
 40c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 410:	89 d0                	mov    %edx,%eax
 412:	f7 d8                	neg    %eax
    neg = 1;
 414:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 41b:	eb 87                	jmp    3a4 <printint+0x24>
 41d:	8d 76 00             	lea    0x0(%esi),%esi

00000420 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 424:	31 ff                	xor    %edi,%edi
{
 426:	56                   	push   %esi
 427:	53                   	push   %ebx
 428:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 42b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 42e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 431:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 434:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 437:	0f b6 13             	movzbl (%ebx),%edx
 43a:	83 c3 01             	add    $0x1,%ebx
 43d:	84 d2                	test   %dl,%dl
 43f:	75 39                	jne    47a <printf+0x5a>
 441:	e9 ca 00 00 00       	jmp    510 <printf+0xf0>
 446:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 448:	83 fa 25             	cmp    $0x25,%edx
 44b:	0f 84 c7 00 00 00    	je     518 <printf+0xf8>
  write(fd, &c, 1);
 451:	8d 45 e0             	lea    -0x20(%ebp),%eax
 454:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 45b:	00 
 45c:	89 44 24 04          	mov    %eax,0x4(%esp)
 460:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 463:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 466:	e8 57 fe ff ff       	call   2c2 <write>
 46b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 46e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 472:	84 d2                	test   %dl,%dl
 474:	0f 84 96 00 00 00    	je     510 <printf+0xf0>
    if(state == 0){
 47a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 47c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 47f:	74 c7                	je     448 <printf+0x28>
      }
    } else if(state == '%'){
 481:	83 ff 25             	cmp    $0x25,%edi
 484:	75 e5                	jne    46b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 486:	83 fa 75             	cmp    $0x75,%edx
 489:	0f 84 99 00 00 00    	je     528 <printf+0x108>
 48f:	83 fa 64             	cmp    $0x64,%edx
 492:	0f 84 90 00 00 00    	je     528 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 498:	25 f7 00 00 00       	and    $0xf7,%eax
 49d:	83 f8 70             	cmp    $0x70,%eax
 4a0:	0f 84 aa 00 00 00    	je     550 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4a6:	83 fa 73             	cmp    $0x73,%edx
 4a9:	0f 84 e9 00 00 00    	je     598 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4af:	83 fa 63             	cmp    $0x63,%edx
 4b2:	0f 84 2b 01 00 00    	je     5e3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4b8:	83 fa 25             	cmp    $0x25,%edx
 4bb:	0f 84 4f 01 00 00    	je     610 <printf+0x1f0>
  write(fd, &c, 1);
 4c1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4c4:	83 c3 01             	add    $0x1,%ebx
 4c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ce:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4cf:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4d5:	89 34 24             	mov    %esi,(%esp)
 4d8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4db:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 4df:	e8 de fd ff ff       	call   2c2 <write>
        putc(fd, c);
 4e4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 4e7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f1:	00 
 4f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 4f9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 4fc:	e8 c1 fd ff ff       	call   2c2 <write>
  for(i = 0; fmt[i]; i++){
 501:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 505:	84 d2                	test   %dl,%dl
 507:	0f 85 6d ff ff ff    	jne    47a <printf+0x5a>
 50d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 510:	83 c4 3c             	add    $0x3c,%esp
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
        state = '%';
 518:	bf 25 00 00 00       	mov    $0x25,%edi
 51d:	e9 49 ff ff ff       	jmp    46b <printf+0x4b>
 522:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 528:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 52f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 534:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 537:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 539:	8b 10                	mov    (%eax),%edx
 53b:	89 f0                	mov    %esi,%eax
 53d:	e8 3e fe ff ff       	call   380 <printint>
        ap++;
 542:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 546:	e9 20 ff ff ff       	jmp    46b <printf+0x4b>
 54b:	90                   	nop
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 550:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 553:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55a:	00 
 55b:	89 44 24 04          	mov    %eax,0x4(%esp)
 55f:	89 34 24             	mov    %esi,(%esp)
 562:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 566:	e8 57 fd ff ff       	call   2c2 <write>
 56b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 56e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 575:	00 
 576:	89 44 24 04          	mov    %eax,0x4(%esp)
 57a:	89 34 24             	mov    %esi,(%esp)
 57d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 581:	e8 3c fd ff ff       	call   2c2 <write>
        printint(fd, *ap, 16, 0);
 586:	b9 10 00 00 00       	mov    $0x10,%ecx
 58b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 592:	eb a0                	jmp    534 <printf+0x114>
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 598:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 59b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 59f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 5a1:	b8 02 09 00 00       	mov    $0x902,%eax
 5a6:	85 ff                	test   %edi,%edi
 5a8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 5ab:	0f b6 07             	movzbl (%edi),%eax
 5ae:	84 c0                	test   %al,%al
 5b0:	74 2a                	je     5dc <printf+0x1bc>
 5b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5b8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5bb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 5be:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 5c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5c8:	00 
 5c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5cd:	89 34 24             	mov    %esi,(%esp)
 5d0:	e8 ed fc ff ff       	call   2c2 <write>
        while(*s != 0){
 5d5:	0f b6 07             	movzbl (%edi),%eax
 5d8:	84 c0                	test   %al,%al
 5da:	75 dc                	jne    5b8 <printf+0x198>
      state = 0;
 5dc:	31 ff                	xor    %edi,%edi
 5de:	e9 88 fe ff ff       	jmp    46b <printf+0x4b>
        putc(fd, *ap);
 5e3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5e6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 5e8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5f1:	00 
 5f2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 5f5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5f8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ff:	e8 be fc ff ff       	call   2c2 <write>
        ap++;
 604:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 608:	e9 5e fe ff ff       	jmp    46b <printf+0x4b>
 60d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 610:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 613:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 615:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 61c:	00 
 61d:	89 44 24 04          	mov    %eax,0x4(%esp)
 621:	89 34 24             	mov    %esi,(%esp)
 624:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 628:	e8 95 fc ff ff       	call   2c2 <write>
 62d:	e9 39 fe ff ff       	jmp    46b <printf+0x4b>
 632:	66 90                	xchg   %ax,%ax
 634:	66 90                	xchg   %ax,%ax
 636:	66 90                	xchg   %ax,%ax
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	a1 44 0c 00 00       	mov    0xc44,%eax
{
 646:	89 e5                	mov    %esp,%ebp
 648:	57                   	push   %edi
 649:	56                   	push   %esi
 64a:	53                   	push   %ebx
 64b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 64e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 650:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 653:	39 d0                	cmp    %edx,%eax
 655:	72 11                	jb     668 <free+0x28>
 657:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 658:	39 c8                	cmp    %ecx,%eax
 65a:	72 04                	jb     660 <free+0x20>
 65c:	39 ca                	cmp    %ecx,%edx
 65e:	72 10                	jb     670 <free+0x30>
 660:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 662:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 664:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 666:	73 f0                	jae    658 <free+0x18>
 668:	39 ca                	cmp    %ecx,%edx
 66a:	72 04                	jb     670 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66c:	39 c8                	cmp    %ecx,%eax
 66e:	72 f0                	jb     660 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 670:	8b 73 fc             	mov    -0x4(%ebx),%esi
 673:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 676:	39 cf                	cmp    %ecx,%edi
 678:	74 1e                	je     698 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 67a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 67d:	8b 48 04             	mov    0x4(%eax),%ecx
 680:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 683:	39 f2                	cmp    %esi,%edx
 685:	74 28                	je     6af <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 687:	89 10                	mov    %edx,(%eax)
  freep = p;
 689:	a3 44 0c 00 00       	mov    %eax,0xc44
}
 68e:	5b                   	pop    %ebx
 68f:	5e                   	pop    %esi
 690:	5f                   	pop    %edi
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
 693:	90                   	nop
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 698:	03 71 04             	add    0x4(%ecx),%esi
 69b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 69e:	8b 08                	mov    (%eax),%ecx
 6a0:	8b 09                	mov    (%ecx),%ecx
 6a2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6a5:	8b 48 04             	mov    0x4(%eax),%ecx
 6a8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6ab:	39 f2                	cmp    %esi,%edx
 6ad:	75 d8                	jne    687 <free+0x47>
    p->s.size += bp->s.size;
 6af:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 6b2:	a3 44 0c 00 00       	mov    %eax,0xc44
    p->s.size += bp->s.size;
 6b7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ba:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6bd:	89 10                	mov    %edx,(%eax)
}
 6bf:	5b                   	pop    %ebx
 6c0:	5e                   	pop    %esi
 6c1:	5f                   	pop    %edi
 6c2:	5d                   	pop    %ebp
 6c3:	c3                   	ret    
 6c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6d0:	55                   	push   %ebp
 6d1:	89 e5                	mov    %esp,%ebp
 6d3:	57                   	push   %edi
 6d4:	56                   	push   %esi
 6d5:	53                   	push   %ebx
 6d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6dc:	8b 1d 44 0c 00 00    	mov    0xc44,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e2:	8d 48 07             	lea    0x7(%eax),%ecx
 6e5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 6e8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6ea:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 6ed:	0f 84 9b 00 00 00    	je     78e <malloc+0xbe>
 6f3:	8b 13                	mov    (%ebx),%edx
 6f5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6f8:	39 fe                	cmp    %edi,%esi
 6fa:	76 64                	jbe    760 <malloc+0x90>
 6fc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 703:	bb 00 80 00 00       	mov    $0x8000,%ebx
 708:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 70b:	eb 0e                	jmp    71b <malloc+0x4b>
 70d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 710:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 712:	8b 78 04             	mov    0x4(%eax),%edi
 715:	39 fe                	cmp    %edi,%esi
 717:	76 4f                	jbe    768 <malloc+0x98>
 719:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 71b:	3b 15 44 0c 00 00    	cmp    0xc44,%edx
 721:	75 ed                	jne    710 <malloc+0x40>
  if(nu < 4096)
 723:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 726:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 72c:	bf 00 10 00 00       	mov    $0x1000,%edi
 731:	0f 43 fe             	cmovae %esi,%edi
 734:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 737:	89 04 24             	mov    %eax,(%esp)
 73a:	e8 eb fb ff ff       	call   32a <sbrk>
  if(p == (char*)-1)
 73f:	83 f8 ff             	cmp    $0xffffffff,%eax
 742:	74 18                	je     75c <malloc+0x8c>
  hp->s.size = nu;
 744:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 747:	83 c0 08             	add    $0x8,%eax
 74a:	89 04 24             	mov    %eax,(%esp)
 74d:	e8 ee fe ff ff       	call   640 <free>
  return freep;
 752:	8b 15 44 0c 00 00    	mov    0xc44,%edx
      if((p = morecore(nunits)) == 0)
 758:	85 d2                	test   %edx,%edx
 75a:	75 b4                	jne    710 <malloc+0x40>
        return 0;
 75c:	31 c0                	xor    %eax,%eax
 75e:	eb 20                	jmp    780 <malloc+0xb0>
    if(p->s.size >= nunits){
 760:	89 d0                	mov    %edx,%eax
 762:	89 da                	mov    %ebx,%edx
 764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 768:	39 fe                	cmp    %edi,%esi
 76a:	74 1c                	je     788 <malloc+0xb8>
        p->s.size -= nunits;
 76c:	29 f7                	sub    %esi,%edi
 76e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 771:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 774:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 777:	89 15 44 0c 00 00    	mov    %edx,0xc44
      return (void*)(p + 1);
 77d:	83 c0 08             	add    $0x8,%eax
  }
}
 780:	83 c4 1c             	add    $0x1c,%esp
 783:	5b                   	pop    %ebx
 784:	5e                   	pop    %esi
 785:	5f                   	pop    %edi
 786:	5d                   	pop    %ebp
 787:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 788:	8b 08                	mov    (%eax),%ecx
 78a:	89 0a                	mov    %ecx,(%edx)
 78c:	eb e9                	jmp    777 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 78e:	c7 05 44 0c 00 00 48 	movl   $0xc48,0xc44
 795:	0c 00 00 
    base.s.size = 0;
 798:	ba 48 0c 00 00       	mov    $0xc48,%edx
    base.s.ptr = freep = prevp = &base;
 79d:	c7 05 48 0c 00 00 48 	movl   $0xc48,0xc48
 7a4:	0c 00 00 
    base.s.size = 0;
 7a7:	c7 05 4c 0c 00 00 00 	movl   $0x0,0xc4c
 7ae:	00 00 00 
 7b1:	e9 46 ff ff ff       	jmp    6fc <malloc+0x2c>
 7b6:	66 90                	xchg   %ax,%ax
 7b8:	66 90                	xchg   %ax,%ax
 7ba:	66 90                	xchg   %ax,%ax
 7bc:	66 90                	xchg   %ax,%ax
 7be:	66 90                	xchg   %ax,%ax

000007c0 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	53                   	push   %ebx
 7c4:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 7c7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 7ce:	e8 fd fe ff ff       	call   6d0 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 7d3:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 7da:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 7dc:	e8 ef fe ff ff       	call   6d0 <malloc>
    if (tstack == NULL) {
 7e1:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 7e3:	89 c2                	mov    %eax,%edx
 7e5:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 7e8:	0f 84 8a 00 00 00    	je     878 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 7ee:	25 ff 0f 00 00       	and    $0xfff,%eax
 7f3:	75 73                	jne    868 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 7f5:	8b 45 10             	mov    0x10(%ebp),%eax
 7f8:	89 54 24 08          	mov    %edx,0x8(%esp)
 7fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 800:	8b 45 0c             	mov    0xc(%ebp),%eax
 803:	89 04 24             	mov    %eax,(%esp)
 806:	e8 57 fb ff ff       	call   362 <kthread_create>
 80b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 80d:	89 44 24 10          	mov    %eax,0x10(%esp)
 811:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 818:	00 
 819:	c7 44 24 08 1a 09 00 	movl   $0x91a,0x8(%esp)
 820:	00 
 821:	c7 44 24 04 29 09 00 	movl   $0x929,0x4(%esp)
 828:	00 
 829:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 830:	e8 eb fb ff ff       	call   420 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 835:	8b 03                	mov    (%ebx),%eax
 837:	c7 44 24 04 40 09 00 	movl   $0x940,0x4(%esp)
 83e:	00 
 83f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 846:	89 44 24 08          	mov    %eax,0x8(%esp)
 84a:	e8 d1 fb ff ff       	call   420 <printf>
    
    if (bt->tid != 0) {
 84f:	8b 03                	mov    (%ebx),%eax
 851:	85 c0                	test   %eax,%eax
 853:	74 23                	je     878 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 855:	8b 45 08             	mov    0x8(%ebp),%eax
 858:	89 18                	mov    %ebx,(%eax)
        return 0;
 85a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 85c:	83 c4 24             	add    $0x24,%esp
 85f:	5b                   	pop    %ebx
 860:	5d                   	pop    %ebp
 861:	c3                   	ret    
 862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 868:	29 c2                	sub    %eax,%edx
 86a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 870:	eb 83                	jmp    7f5 <benny_thread_create+0x35>
 872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 87d:	eb dd                	jmp    85c <benny_thread_create+0x9c>
 87f:	90                   	nop

00000880 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 883:	8b 45 08             	mov    0x8(%ebp),%eax
}
 886:	5d                   	pop    %ebp
    return bt->tid;
 887:	8b 00                	mov    (%eax),%eax
}
 889:	c3                   	ret    
 88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000890 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	53                   	push   %ebx
 894:	83 ec 14             	sub    $0x14,%esp
 897:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 89a:	8b 03                	mov    (%ebx),%eax
 89c:	89 04 24             	mov    %eax,(%esp)
 89f:	e8 c6 fa ff ff       	call   36a <kthread_join>
    if (retVal == 0) {
 8a4:	85 c0                	test   %eax,%eax
 8a6:	75 11                	jne    8b9 <benny_thread_join+0x29>
        free(bt->tstack);
 8a8:	8b 53 04             	mov    0x4(%ebx),%edx
 8ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8ae:	89 14 24             	mov    %edx,(%esp)
 8b1:	e8 8a fd ff ff       	call   640 <free>
 8b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 8b9:	83 c4 14             	add    $0x14,%esp
 8bc:	5b                   	pop    %ebx
 8bd:	5d                   	pop    %ebp
 8be:	c3                   	ret    
 8bf:	90                   	nop

000008c0 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 8c6:	8b 45 08             	mov    0x8(%ebp),%eax
 8c9:	89 04 24             	mov    %eax,(%esp)
 8cc:	e8 a1 fa ff ff       	call   372 <kthread_exit>
    return 0;
}
 8d1:	31 c0                	xor    %eax,%eax
 8d3:	c9                   	leave  
 8d4:	c3                   	ret    
