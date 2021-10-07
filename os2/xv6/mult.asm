
_mult:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// The single real purpose for mult is to have a compute
// intensive program that runs for a long time.

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 20             	sub    $0x20,%esp
  int i;
  int j;
  int max = MAXINT;
  int sum = 0;

  if(argc > 1) {
   c:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  10:	7e 60                	jle    72 <main+0x72>
    // change the upper bound on the iteration loops.
    max = atoi(argv[1]);
  12:	8b 45 0c             	mov    0xc(%ebp),%eax
  15:	8b 40 04             	mov    0x4(%eax),%eax
  18:	89 04 24             	mov    %eax,(%esp)
  1b:	e8 d0 02 00 00       	call   2f0 <atoi>
  20:	89 c7                	mov    %eax,%edi
  }
  printf(1, "mult begin: pid = %d     max = %d\n", getpid(), max);
  22:	e8 ab 03 00 00       	call   3d2 <getpid>
  27:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  2b:	c7 44 24 04 48 08 00 	movl   $0x848,0x4(%esp)
  32:	00 
  33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3a:	89 44 24 08          	mov    %eax,0x8(%esp)
  3e:	e8 6d 04 00 00       	call   4b0 <printf>

  for (j = 0; j < max; j++) {
  43:	85 ff                	test   %edi,%edi
  45:	7e 05                	jle    4c <main+0x4c>
    for(i = 1; i < max; i++) {
  47:	83 ff 01             	cmp    $0x1,%edi
  4a:	75 50                	jne    9c <main+0x9c>
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if (sum > (MAXINT / 2)) {
        sum = 0;
      }
    }
  }
  printf(1, "mult done: pid = %d\n", getpid());
  50:	e8 7d 03 00 00       	call   3d2 <getpid>
  55:	c7 44 24 04 7c 08 00 	movl   $0x87c,0x4(%esp)
  5c:	00 
  5d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  64:	89 44 24 08          	mov    %eax,0x8(%esp)
  68:	e8 43 04 00 00       	call   4b0 <printf>

  // in xv6, exit() does not take a parameter.
  exit();
  6d:	e8 e0 02 00 00       	call   352 <exit>
  printf(1, "mult begin: pid = %d     max = %d\n", getpid(), max);
  72:	e8 5b 03 00 00       	call   3d2 <getpid>
  int max = MAXINT;
  77:	bf ff ff ff 7f       	mov    $0x7fffffff,%edi
  printf(1, "mult begin: pid = %d     max = %d\n", getpid(), max);
  7c:	c7 44 24 0c ff ff ff 	movl   $0x7fffffff,0xc(%esp)
  83:	7f 
  84:	c7 44 24 04 48 08 00 	movl   $0x848,0x4(%esp)
  8b:	00 
  8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  93:	89 44 24 08          	mov    %eax,0x8(%esp)
  97:	e8 14 04 00 00       	call   4b0 <printf>
    for(i = 1; i < max; i++) {
  9c:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  a3:	00 
  a4:	31 db                	xor    %ebx,%ebx
      if (sum % (MAXSHORT * MAXSHORT) == 0) {
  a6:	b9 03 00 ff 3f       	mov    $0x3fff0003,%ecx
  ab:	90                   	nop
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  b0:	be 01 00 00 00       	mov    $0x1,%esi
  b5:	eb 16                	jmp    cd <main+0xcd>
  b7:	90                   	nop
        sum = 0;
  b8:	81 fb 00 00 00 40    	cmp    $0x40000000,%ebx
  be:	b8 00 00 00 00       	mov    $0x0,%eax
  c3:	0f 4d d8             	cmovge %eax,%ebx
    for(i = 1; i < max; i++) {
  c6:	83 c6 01             	add    $0x1,%esi
  c9:	39 fe                	cmp    %edi,%esi
  cb:	74 4b                	je     118 <main+0x118>
      sum ++;
  cd:	83 c3 01             	add    $0x1,%ebx
      if (sum % (MAXSHORT * MAXSHORT) == 0) {
  d0:	89 d8                	mov    %ebx,%eax
  d2:	f7 e9                	imul   %ecx
  d4:	89 d8                	mov    %ebx,%eax
  d6:	c1 f8 1f             	sar    $0x1f,%eax
  d9:	c1 fa 1c             	sar    $0x1c,%edx
  dc:	29 c2                	sub    %eax,%edx
  de:	69 d2 01 00 01 40    	imul   $0x40010001,%edx,%edx
  e4:	39 d3                	cmp    %edx,%ebx
  e6:	75 d0                	jne    b8 <main+0xb8>
  e8:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
        printf(1, "  mult: %d  %d\n", getpid(), sum);
  ec:	e8 e1 02 00 00       	call   3d2 <getpid>
  f1:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
  f5:	c7 44 24 04 6c 08 00 	movl   $0x86c,0x4(%esp)
  fc:	00 
  fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 104:	89 44 24 08          	mov    %eax,0x8(%esp)
 108:	e8 a3 03 00 00       	call   4b0 <printf>
 10d:	8b 4c 24 1c          	mov    0x1c(%esp),%ecx
 111:	eb a5                	jmp    b8 <main+0xb8>
 113:	90                   	nop
 114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for (j = 0; j < max; j++) {
 118:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
 11d:	39 7c 24 18          	cmp    %edi,0x18(%esp)
 121:	7c 8d                	jl     b0 <main+0xb0>
 123:	e9 24 ff ff ff       	jmp    4c <main+0x4c>
 128:	66 90                	xchg   %ax,%ax
 12a:	66 90                	xchg   %ax,%ax
 12c:	66 90                	xchg   %ax,%ax
 12e:	66 90                	xchg   %ax,%ax

00000130 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 139:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 13a:	89 c2                	mov    %eax,%edx
 13c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 140:	83 c1 01             	add    $0x1,%ecx
 143:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 147:	83 c2 01             	add    $0x1,%edx
 14a:	84 db                	test   %bl,%bl
 14c:	88 5a ff             	mov    %bl,-0x1(%edx)
 14f:	75 ef                	jne    140 <strcpy+0x10>
    ;
  return os;
}
 151:	5b                   	pop    %ebx
 152:	5d                   	pop    %ebp
 153:	c3                   	ret    
 154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 15a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000160 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 55 08             	mov    0x8(%ebp),%edx
 166:	53                   	push   %ebx
 167:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 16a:	0f b6 02             	movzbl (%edx),%eax
 16d:	84 c0                	test   %al,%al
 16f:	74 2d                	je     19e <strcmp+0x3e>
 171:	0f b6 19             	movzbl (%ecx),%ebx
 174:	38 d8                	cmp    %bl,%al
 176:	74 0e                	je     186 <strcmp+0x26>
 178:	eb 2b                	jmp    1a5 <strcmp+0x45>
 17a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 180:	38 c8                	cmp    %cl,%al
 182:	75 15                	jne    199 <strcmp+0x39>
    p++, q++;
 184:	89 d9                	mov    %ebx,%ecx
 186:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 189:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 18c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 18f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 193:	84 c0                	test   %al,%al
 195:	75 e9                	jne    180 <strcmp+0x20>
 197:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 199:	29 c8                	sub    %ecx,%eax
}
 19b:	5b                   	pop    %ebx
 19c:	5d                   	pop    %ebp
 19d:	c3                   	ret    
 19e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 1a1:	31 c0                	xor    %eax,%eax
 1a3:	eb f4                	jmp    199 <strcmp+0x39>
 1a5:	0f b6 cb             	movzbl %bl,%ecx
 1a8:	eb ef                	jmp    199 <strcmp+0x39>
 1aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001b0 <strlen>:

uint
strlen(const char *s)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1b6:	80 39 00             	cmpb   $0x0,(%ecx)
 1b9:	74 12                	je     1cd <strlen+0x1d>
 1bb:	31 d2                	xor    %edx,%edx
 1bd:	8d 76 00             	lea    0x0(%esi),%esi
 1c0:	83 c2 01             	add    $0x1,%edx
 1c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1c7:	89 d0                	mov    %edx,%eax
 1c9:	75 f5                	jne    1c0 <strlen+0x10>
    ;
  return n;
}
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 1cd:	31 c0                	xor    %eax,%eax
}
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    
 1d1:	eb 0d                	jmp    1e0 <memset>
 1d3:	90                   	nop
 1d4:	90                   	nop
 1d5:	90                   	nop
 1d6:	90                   	nop
 1d7:	90                   	nop
 1d8:	90                   	nop
 1d9:	90                   	nop
 1da:	90                   	nop
 1db:	90                   	nop
 1dc:	90                   	nop
 1dd:	90                   	nop
 1de:	90                   	nop
 1df:	90                   	nop

000001e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 55 08             	mov    0x8(%ebp),%edx
 1e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ed:	89 d7                	mov    %edx,%edi
 1ef:	fc                   	cld    
 1f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1f2:	89 d0                	mov    %edx,%eax
 1f4:	5f                   	pop    %edi
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strchr>:

char*
strchr(const char *s, char c)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	53                   	push   %ebx
 207:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 20a:	0f b6 18             	movzbl (%eax),%ebx
 20d:	84 db                	test   %bl,%bl
 20f:	74 1d                	je     22e <strchr+0x2e>
    if(*s == c)
 211:	38 d3                	cmp    %dl,%bl
 213:	89 d1                	mov    %edx,%ecx
 215:	75 0d                	jne    224 <strchr+0x24>
 217:	eb 17                	jmp    230 <strchr+0x30>
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 220:	38 ca                	cmp    %cl,%dl
 222:	74 0c                	je     230 <strchr+0x30>
  for(; *s; s++)
 224:	83 c0 01             	add    $0x1,%eax
 227:	0f b6 10             	movzbl (%eax),%edx
 22a:	84 d2                	test   %dl,%dl
 22c:	75 f2                	jne    220 <strchr+0x20>
      return (char*)s;
  return 0;
 22e:	31 c0                	xor    %eax,%eax
}
 230:	5b                   	pop    %ebx
 231:	5d                   	pop    %ebp
 232:	c3                   	ret    
 233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <gets>:

char*
gets(char *buf, int max)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	57                   	push   %edi
 244:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 245:	31 f6                	xor    %esi,%esi
{
 247:	53                   	push   %ebx
 248:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 24b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 24e:	eb 31                	jmp    281 <gets+0x41>
    cc = read(0, &c, 1);
 250:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 257:	00 
 258:	89 7c 24 04          	mov    %edi,0x4(%esp)
 25c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 263:	e8 02 01 00 00       	call   36a <read>
    if(cc < 1)
 268:	85 c0                	test   %eax,%eax
 26a:	7e 1d                	jle    289 <gets+0x49>
      break;
    buf[i++] = c;
 26c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 270:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 272:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 275:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 277:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 27b:	74 0c                	je     289 <gets+0x49>
 27d:	3c 0a                	cmp    $0xa,%al
 27f:	74 08                	je     289 <gets+0x49>
  for(i=0; i+1 < max; ){
 281:	8d 5e 01             	lea    0x1(%esi),%ebx
 284:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 287:	7c c7                	jl     250 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 290:	83 c4 2c             	add    $0x2c,%esp
 293:	5b                   	pop    %ebx
 294:	5e                   	pop    %esi
 295:	5f                   	pop    %edi
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	90                   	nop
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	56                   	push   %esi
 2a4:	53                   	push   %ebx
 2a5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2b2:	00 
 2b3:	89 04 24             	mov    %eax,(%esp)
 2b6:	e8 d7 00 00 00       	call   392 <open>
  if(fd < 0)
 2bb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 2bd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2bf:	78 27                	js     2e8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c4:	89 1c 24             	mov    %ebx,(%esp)
 2c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cb:	e8 da 00 00 00       	call   3aa <fstat>
  close(fd);
 2d0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2d3:	89 c6                	mov    %eax,%esi
  close(fd);
 2d5:	e8 a0 00 00 00       	call   37a <close>
  return r;
 2da:	89 f0                	mov    %esi,%eax
}
 2dc:	83 c4 10             	add    $0x10,%esp
 2df:	5b                   	pop    %ebx
 2e0:	5e                   	pop    %esi
 2e1:	5d                   	pop    %ebp
 2e2:	c3                   	ret    
 2e3:	90                   	nop
 2e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ed:	eb ed                	jmp    2dc <stat+0x3c>
 2ef:	90                   	nop

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2f7:	0f be 11             	movsbl (%ecx),%edx
 2fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 2fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 304:	77 17                	ja     31d <atoi+0x2d>
 306:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 308:	83 c1 01             	add    $0x1,%ecx
 30b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 30e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 312:	0f be 11             	movsbl (%ecx),%edx
 315:	8d 5a d0             	lea    -0x30(%edx),%ebx
 318:	80 fb 09             	cmp    $0x9,%bl
 31b:	76 eb                	jbe    308 <atoi+0x18>
  return n;
}
 31d:	5b                   	pop    %ebx
 31e:	5d                   	pop    %ebp
 31f:	c3                   	ret    

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 321:	31 d2                	xor    %edx,%edx
{
 323:	89 e5                	mov    %esp,%ebp
 325:	56                   	push   %esi
 326:	8b 45 08             	mov    0x8(%ebp),%eax
 329:	53                   	push   %ebx
 32a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 32d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 330:	85 db                	test   %ebx,%ebx
 332:	7e 12                	jle    346 <memmove+0x26>
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 338:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 33c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 33f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 342:	39 da                	cmp    %ebx,%edx
 344:	75 f2                	jne    338 <memmove+0x18>
  return vdst;
}
 346:	5b                   	pop    %ebx
 347:	5e                   	pop    %esi
 348:	5d                   	pop    %ebp
 349:	c3                   	ret    

0000034a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34a:	b8 01 00 00 00       	mov    $0x1,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <exit>:
SYSCALL(exit)
 352:	b8 02 00 00 00       	mov    $0x2,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <wait>:
SYSCALL(wait)
 35a:	b8 03 00 00 00       	mov    $0x3,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <pipe>:
SYSCALL(pipe)
 362:	b8 04 00 00 00       	mov    $0x4,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <read>:
SYSCALL(read)
 36a:	b8 05 00 00 00       	mov    $0x5,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <write>:
SYSCALL(write)
 372:	b8 10 00 00 00       	mov    $0x10,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <close>:
SYSCALL(close)
 37a:	b8 15 00 00 00       	mov    $0x15,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <kill>:
SYSCALL(kill)
 382:	b8 06 00 00 00       	mov    $0x6,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <exec>:
SYSCALL(exec)
 38a:	b8 07 00 00 00       	mov    $0x7,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <open>:
SYSCALL(open)
 392:	b8 0f 00 00 00       	mov    $0xf,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <mknod>:
SYSCALL(mknod)
 39a:	b8 11 00 00 00       	mov    $0x11,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <unlink>:
SYSCALL(unlink)
 3a2:	b8 12 00 00 00       	mov    $0x12,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <fstat>:
SYSCALL(fstat)
 3aa:	b8 08 00 00 00       	mov    $0x8,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <link>:
SYSCALL(link)
 3b2:	b8 13 00 00 00       	mov    $0x13,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <mkdir>:
SYSCALL(mkdir)
 3ba:	b8 14 00 00 00       	mov    $0x14,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <chdir>:
SYSCALL(chdir)
 3c2:	b8 09 00 00 00       	mov    $0x9,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <dup>:
SYSCALL(dup)
 3ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <getpid>:
SYSCALL(getpid)
 3d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <sbrk>:
SYSCALL(sbrk)
 3da:	b8 0c 00 00 00       	mov    $0xc,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <sleep>:
SYSCALL(sleep)
 3e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <uptime>:
SYSCALL(uptime)
 3ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 3f2:	b8 16 00 00 00       	mov    $0x16,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 3fa:	b8 17 00 00 00       	mov    $0x17,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 402:	b8 18 00 00 00       	mov    $0x18,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    
 40a:	66 90                	xchg   %ax,%ax
 40c:	66 90                	xchg   %ax,%ax
 40e:	66 90                	xchg   %ax,%ax

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	89 c6                	mov    %eax,%esi
 417:	53                   	push   %ebx
 418:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 41b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 41e:	85 db                	test   %ebx,%ebx
 420:	74 09                	je     42b <printint+0x1b>
 422:	89 d0                	mov    %edx,%eax
 424:	c1 e8 1f             	shr    $0x1f,%eax
 427:	84 c0                	test   %al,%al
 429:	75 75                	jne    4a0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 42b:	89 d0                	mov    %edx,%eax
  neg = 0;
 42d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 434:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 437:	31 ff                	xor    %edi,%edi
 439:	89 ce                	mov    %ecx,%esi
 43b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 43e:	eb 02                	jmp    442 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 440:	89 cf                	mov    %ecx,%edi
 442:	31 d2                	xor    %edx,%edx
 444:	f7 f6                	div    %esi
 446:	8d 4f 01             	lea    0x1(%edi),%ecx
 449:	0f b6 92 98 08 00 00 	movzbl 0x898(%edx),%edx
  }while((x /= base) != 0);
 450:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 452:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 455:	75 e9                	jne    440 <printint+0x30>
  if(neg)
 457:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 45a:	89 c8                	mov    %ecx,%eax
 45c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 45f:	85 d2                	test   %edx,%edx
 461:	74 08                	je     46b <printint+0x5b>
    buf[i++] = '-';
 463:	8d 4f 02             	lea    0x2(%edi),%ecx
 466:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 46b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 46e:	66 90                	xchg   %ax,%ax
 470:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 475:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 478:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47f:	00 
 480:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 484:	89 34 24             	mov    %esi,(%esp)
 487:	88 45 d7             	mov    %al,-0x29(%ebp)
 48a:	e8 e3 fe ff ff       	call   372 <write>
  while(--i >= 0)
 48f:	83 ff ff             	cmp    $0xffffffff,%edi
 492:	75 dc                	jne    470 <printint+0x60>
    putc(fd, buf[i]);
}
 494:	83 c4 4c             	add    $0x4c,%esp
 497:	5b                   	pop    %ebx
 498:	5e                   	pop    %esi
 499:	5f                   	pop    %edi
 49a:	5d                   	pop    %ebp
 49b:	c3                   	ret    
 49c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 4a0:	89 d0                	mov    %edx,%eax
 4a2:	f7 d8                	neg    %eax
    neg = 1;
 4a4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4ab:	eb 87                	jmp    434 <printint+0x24>
 4ad:	8d 76 00             	lea    0x0(%esi),%esi

000004b0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b4:	31 ff                	xor    %edi,%edi
{
 4b6:	56                   	push   %esi
 4b7:	53                   	push   %ebx
 4b8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4bb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 4be:	8d 45 10             	lea    0x10(%ebp),%eax
{
 4c1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 4c4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 4c7:	0f b6 13             	movzbl (%ebx),%edx
 4ca:	83 c3 01             	add    $0x1,%ebx
 4cd:	84 d2                	test   %dl,%dl
 4cf:	75 39                	jne    50a <printf+0x5a>
 4d1:	e9 ca 00 00 00       	jmp    5a0 <printf+0xf0>
 4d6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4d8:	83 fa 25             	cmp    $0x25,%edx
 4db:	0f 84 c7 00 00 00    	je     5a8 <printf+0xf8>
  write(fd, &c, 1);
 4e1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 4e4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4eb:	00 
 4ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 4f3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 4f6:	e8 77 fe ff ff       	call   372 <write>
 4fb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 4fe:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 502:	84 d2                	test   %dl,%dl
 504:	0f 84 96 00 00 00    	je     5a0 <printf+0xf0>
    if(state == 0){
 50a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 50c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 50f:	74 c7                	je     4d8 <printf+0x28>
      }
    } else if(state == '%'){
 511:	83 ff 25             	cmp    $0x25,%edi
 514:	75 e5                	jne    4fb <printf+0x4b>
      if(c == 'd' || c == 'u'){
 516:	83 fa 75             	cmp    $0x75,%edx
 519:	0f 84 99 00 00 00    	je     5b8 <printf+0x108>
 51f:	83 fa 64             	cmp    $0x64,%edx
 522:	0f 84 90 00 00 00    	je     5b8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 528:	25 f7 00 00 00       	and    $0xf7,%eax
 52d:	83 f8 70             	cmp    $0x70,%eax
 530:	0f 84 aa 00 00 00    	je     5e0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 536:	83 fa 73             	cmp    $0x73,%edx
 539:	0f 84 e9 00 00 00    	je     628 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 53f:	83 fa 63             	cmp    $0x63,%edx
 542:	0f 84 2b 01 00 00    	je     673 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 548:	83 fa 25             	cmp    $0x25,%edx
 54b:	0f 84 4f 01 00 00    	je     6a0 <printf+0x1f0>
  write(fd, &c, 1);
 551:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 554:	83 c3 01             	add    $0x1,%ebx
 557:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 55f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 561:	89 44 24 04          	mov    %eax,0x4(%esp)
 565:	89 34 24             	mov    %esi,(%esp)
 568:	89 55 d0             	mov    %edx,-0x30(%ebp)
 56b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 56f:	e8 fe fd ff ff       	call   372 <write>
        putc(fd, c);
 574:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 577:	8d 45 e7             	lea    -0x19(%ebp),%eax
 57a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 581:	00 
 582:	89 44 24 04          	mov    %eax,0x4(%esp)
 586:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 589:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 58c:	e8 e1 fd ff ff       	call   372 <write>
  for(i = 0; fmt[i]; i++){
 591:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 595:	84 d2                	test   %dl,%dl
 597:	0f 85 6d ff ff ff    	jne    50a <printf+0x5a>
 59d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 5a0:	83 c4 3c             	add    $0x3c,%esp
 5a3:	5b                   	pop    %ebx
 5a4:	5e                   	pop    %esi
 5a5:	5f                   	pop    %edi
 5a6:	5d                   	pop    %ebp
 5a7:	c3                   	ret    
        state = '%';
 5a8:	bf 25 00 00 00       	mov    $0x25,%edi
 5ad:	e9 49 ff ff ff       	jmp    4fb <printf+0x4b>
 5b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5bf:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 5c4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5c7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 5c9:	8b 10                	mov    (%eax),%edx
 5cb:	89 f0                	mov    %esi,%eax
 5cd:	e8 3e fe ff ff       	call   410 <printint>
        ap++;
 5d2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 5d6:	e9 20 ff ff ff       	jmp    4fb <printf+0x4b>
 5db:	90                   	nop
 5dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 5e0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 5e3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ea:	00 
 5eb:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ef:	89 34 24             	mov    %esi,(%esp)
 5f2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 5f6:	e8 77 fd ff ff       	call   372 <write>
 5fb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5fe:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 605:	00 
 606:	89 44 24 04          	mov    %eax,0x4(%esp)
 60a:	89 34 24             	mov    %esi,(%esp)
 60d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 611:	e8 5c fd ff ff       	call   372 <write>
        printint(fd, *ap, 16, 0);
 616:	b9 10 00 00 00       	mov    $0x10,%ecx
 61b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 622:	eb a0                	jmp    5c4 <printf+0x114>
 624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 628:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 62b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 62f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 631:	b8 91 08 00 00       	mov    $0x891,%eax
 636:	85 ff                	test   %edi,%edi
 638:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 63b:	0f b6 07             	movzbl (%edi),%eax
 63e:	84 c0                	test   %al,%al
 640:	74 2a                	je     66c <printf+0x1bc>
 642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 648:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 64b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 64e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 651:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 658:	00 
 659:	89 44 24 04          	mov    %eax,0x4(%esp)
 65d:	89 34 24             	mov    %esi,(%esp)
 660:	e8 0d fd ff ff       	call   372 <write>
        while(*s != 0){
 665:	0f b6 07             	movzbl (%edi),%eax
 668:	84 c0                	test   %al,%al
 66a:	75 dc                	jne    648 <printf+0x198>
      state = 0;
 66c:	31 ff                	xor    %edi,%edi
 66e:	e9 88 fe ff ff       	jmp    4fb <printf+0x4b>
        putc(fd, *ap);
 673:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 676:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 678:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 67a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 681:	00 
 682:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 685:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 688:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 68b:	89 44 24 04          	mov    %eax,0x4(%esp)
 68f:	e8 de fc ff ff       	call   372 <write>
        ap++;
 694:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 698:	e9 5e fe ff ff       	jmp    4fb <printf+0x4b>
 69d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6a0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 6a3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 6a5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6ac:	00 
 6ad:	89 44 24 04          	mov    %eax,0x4(%esp)
 6b1:	89 34 24             	mov    %esi,(%esp)
 6b4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 6b8:	e8 b5 fc ff ff       	call   372 <write>
 6bd:	e9 39 fe ff ff       	jmp    4fb <printf+0x4b>
 6c2:	66 90                	xchg   %ax,%ax
 6c4:	66 90                	xchg   %ax,%ax
 6c6:	66 90                	xchg   %ax,%ax
 6c8:	66 90                	xchg   %ax,%ax
 6ca:	66 90                	xchg   %ax,%ax
 6cc:	66 90                	xchg   %ax,%ax
 6ce:	66 90                	xchg   %ax,%ax

000006d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d1:	a1 14 0b 00 00       	mov    0xb14,%eax
{
 6d6:	89 e5                	mov    %esp,%ebp
 6d8:	57                   	push   %edi
 6d9:	56                   	push   %esi
 6da:	53                   	push   %ebx
 6db:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6de:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 6e0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e3:	39 d0                	cmp    %edx,%eax
 6e5:	72 11                	jb     6f8 <free+0x28>
 6e7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e8:	39 c8                	cmp    %ecx,%eax
 6ea:	72 04                	jb     6f0 <free+0x20>
 6ec:	39 ca                	cmp    %ecx,%edx
 6ee:	72 10                	jb     700 <free+0x30>
 6f0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f6:	73 f0                	jae    6e8 <free+0x18>
 6f8:	39 ca                	cmp    %ecx,%edx
 6fa:	72 04                	jb     700 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6fc:	39 c8                	cmp    %ecx,%eax
 6fe:	72 f0                	jb     6f0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 700:	8b 73 fc             	mov    -0x4(%ebx),%esi
 703:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 706:	39 cf                	cmp    %ecx,%edi
 708:	74 1e                	je     728 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 70a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 70d:	8b 48 04             	mov    0x4(%eax),%ecx
 710:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 713:	39 f2                	cmp    %esi,%edx
 715:	74 28                	je     73f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 717:	89 10                	mov    %edx,(%eax)
  freep = p;
 719:	a3 14 0b 00 00       	mov    %eax,0xb14
}
 71e:	5b                   	pop    %ebx
 71f:	5e                   	pop    %esi
 720:	5f                   	pop    %edi
 721:	5d                   	pop    %ebp
 722:	c3                   	ret    
 723:	90                   	nop
 724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 728:	03 71 04             	add    0x4(%ecx),%esi
 72b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 72e:	8b 08                	mov    (%eax),%ecx
 730:	8b 09                	mov    (%ecx),%ecx
 732:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 735:	8b 48 04             	mov    0x4(%eax),%ecx
 738:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 73b:	39 f2                	cmp    %esi,%edx
 73d:	75 d8                	jne    717 <free+0x47>
    p->s.size += bp->s.size;
 73f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 742:	a3 14 0b 00 00       	mov    %eax,0xb14
    p->s.size += bp->s.size;
 747:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 74a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 74d:	89 10                	mov    %edx,(%eax)
}
 74f:	5b                   	pop    %ebx
 750:	5e                   	pop    %esi
 751:	5f                   	pop    %edi
 752:	5d                   	pop    %ebp
 753:	c3                   	ret    
 754:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 75a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000760 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 769:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 76c:	8b 1d 14 0b 00 00    	mov    0xb14,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 772:	8d 48 07             	lea    0x7(%eax),%ecx
 775:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 778:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 77a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 77d:	0f 84 9b 00 00 00    	je     81e <malloc+0xbe>
 783:	8b 13                	mov    (%ebx),%edx
 785:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 788:	39 fe                	cmp    %edi,%esi
 78a:	76 64                	jbe    7f0 <malloc+0x90>
 78c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 793:	bb 00 80 00 00       	mov    $0x8000,%ebx
 798:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 79b:	eb 0e                	jmp    7ab <malloc+0x4b>
 79d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7a0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7a2:	8b 78 04             	mov    0x4(%eax),%edi
 7a5:	39 fe                	cmp    %edi,%esi
 7a7:	76 4f                	jbe    7f8 <malloc+0x98>
 7a9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7ab:	3b 15 14 0b 00 00    	cmp    0xb14,%edx
 7b1:	75 ed                	jne    7a0 <malloc+0x40>
  if(nu < 4096)
 7b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7bc:	bf 00 10 00 00       	mov    $0x1000,%edi
 7c1:	0f 43 fe             	cmovae %esi,%edi
 7c4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 7c7:	89 04 24             	mov    %eax,(%esp)
 7ca:	e8 0b fc ff ff       	call   3da <sbrk>
  if(p == (char*)-1)
 7cf:	83 f8 ff             	cmp    $0xffffffff,%eax
 7d2:	74 18                	je     7ec <malloc+0x8c>
  hp->s.size = nu;
 7d4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 7d7:	83 c0 08             	add    $0x8,%eax
 7da:	89 04 24             	mov    %eax,(%esp)
 7dd:	e8 ee fe ff ff       	call   6d0 <free>
  return freep;
 7e2:	8b 15 14 0b 00 00    	mov    0xb14,%edx
      if((p = morecore(nunits)) == 0)
 7e8:	85 d2                	test   %edx,%edx
 7ea:	75 b4                	jne    7a0 <malloc+0x40>
        return 0;
 7ec:	31 c0                	xor    %eax,%eax
 7ee:	eb 20                	jmp    810 <malloc+0xb0>
    if(p->s.size >= nunits){
 7f0:	89 d0                	mov    %edx,%eax
 7f2:	89 da                	mov    %ebx,%edx
 7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 7f8:	39 fe                	cmp    %edi,%esi
 7fa:	74 1c                	je     818 <malloc+0xb8>
        p->s.size -= nunits;
 7fc:	29 f7                	sub    %esi,%edi
 7fe:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 801:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 804:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 807:	89 15 14 0b 00 00    	mov    %edx,0xb14
      return (void*)(p + 1);
 80d:	83 c0 08             	add    $0x8,%eax
  }
}
 810:	83 c4 1c             	add    $0x1c,%esp
 813:	5b                   	pop    %ebx
 814:	5e                   	pop    %esi
 815:	5f                   	pop    %edi
 816:	5d                   	pop    %ebp
 817:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 818:	8b 08                	mov    (%eax),%ecx
 81a:	89 0a                	mov    %ecx,(%edx)
 81c:	eb e9                	jmp    807 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 81e:	c7 05 14 0b 00 00 18 	movl   $0xb18,0xb14
 825:	0b 00 00 
    base.s.size = 0;
 828:	ba 18 0b 00 00       	mov    $0xb18,%edx
    base.s.ptr = freep = prevp = &base;
 82d:	c7 05 18 0b 00 00 18 	movl   $0xb18,0xb18
 834:	0b 00 00 
    base.s.size = 0;
 837:	c7 05 1c 0b 00 00 00 	movl   $0x0,0xb1c
 83e:	00 00 00 
 841:	e9 46 ff ff ff       	jmp    78c <malloc+0x2c>
