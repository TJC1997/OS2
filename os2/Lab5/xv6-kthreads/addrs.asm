
_addrs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

static int unint_data;
static int init_data = -1;
static const char const_data[] = "hello world";

int main(int argc, char *argv[], char *envp[]) {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 20             	sub    $0x20,%esp
    static int static_data = -2;

    int x = 3;
    char *theap = sbrk(0);
   a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    int x = 3;
  11:	c7 44 24 1c 03 00 00 	movl   $0x3,0x1c(%esp)
  18:	00 
    char *theap = sbrk(0);
  19:	e8 4c 04 00 00       	call   46a <sbrk>

    printf(1, "location of envp[0]\t\t: %p\n", &(envp[0]));
  1e:	c7 44 24 04 18 0a 00 	movl   $0xa18,0x4(%esp)
  25:	00 
  26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    char *theap = sbrk(0);
  2d:	89 c3                	mov    %eax,%ebx
    printf(1, "location of envp[0]\t\t: %p\n", &(envp[0]));
  2f:	8b 45 10             	mov    0x10(%ebp),%eax
  32:	89 44 24 08          	mov    %eax,0x8(%esp)
  36:	e8 25 05 00 00       	call   560 <printf>
    printf(1, "location of argv[0]\t\t: %p\n", &(argv[0]));
  3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  3e:	c7 44 24 04 33 0a 00 	movl   $0xa33,0x4(%esp)
  45:	00 
  46:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4d:	89 44 24 08          	mov    %eax,0x8(%esp)
  51:	e8 0a 05 00 00       	call   560 <printf>

    printf(1, "location of stack\t\t: %p\n", &x);
  56:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  5a:	89 44 24 08          	mov    %eax,0x8(%esp)
  5e:	c7 44 24 04 4e 0a 00 	movl   $0xa4e,0x4(%esp)
  65:	00 
  66:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6d:	e8 ee 04 00 00       	call   560 <printf>
    printf(1, "location of argc\t\t: %p\n", &argc);
  72:	8d 45 08             	lea    0x8(%ebp),%eax
  75:	89 44 24 08          	mov    %eax,0x8(%esp)
  79:	c7 44 24 04 67 0a 00 	movl   $0xa67,0x4(%esp)
  80:	00 
  81:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  88:	e8 d3 04 00 00       	call   560 <printf>
    printf(1, "location of argv\t\t: %p\n", &argv);
  8d:	8d 45 0c             	lea    0xc(%ebp),%eax
  90:	89 44 24 08          	mov    %eax,0x8(%esp)
  94:	c7 44 24 04 7f 0a 00 	movl   $0xa7f,0x4(%esp)
  9b:	00 
  9c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a3:	e8 b8 04 00 00       	call   560 <printf>

    printf(1, "\n");
  a8:	c7 44 24 04 b4 0b 00 	movl   $0xbb4,0x4(%esp)
  af:	00 
  b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b7:	e8 a4 04 00 00       	call   560 <printf>

    printf(1, "location of heap\t\t: %p\n", malloc(1));
  bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c3:	e8 48 07 00 00       	call   810 <malloc>
  c8:	c7 44 24 04 97 0a 00 	movl   $0xa97,0x4(%esp)
  cf:	00 
  d0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d7:	89 44 24 08          	mov    %eax,0x8(%esp)
  db:	e8 80 04 00 00       	call   560 <printf>
    printf(1, "location of sbrk(0)\t\t: %p\n", theap);
  e0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  e4:	c7 44 24 04 af 0a 00 	movl   $0xaaf,0x4(%esp)
  eb:	00 
  ec:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  f3:	e8 68 04 00 00       	call   560 <printf>
    printf(1, "\n");
  f8:	c7 44 24 04 b4 0b 00 	movl   $0xbb4,0x4(%esp)
  ff:	00 
 100:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 107:	e8 54 04 00 00       	call   560 <printf>

    printf(1, "location of uninitialized data\t: %p\n", &unint_data);
 10c:	c7 44 24 08 b8 0e 00 	movl   $0xeb8,0x8(%esp)
 113:	00 
 114:	c7 44 24 04 00 0b 00 	movl   $0xb00,0x4(%esp)
 11b:	00 
 11c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 123:	e8 38 04 00 00       	call   560 <printf>
    printf(1, "location of static data\t\t: %p\n", &static_data);
 128:	c7 44 24 08 b0 0e 00 	movl   $0xeb0,0x8(%esp)
 12f:	00 
 130:	c7 44 24 04 28 0b 00 	movl   $0xb28,0x4(%esp)
 137:	00 
 138:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13f:	e8 1c 04 00 00       	call   560 <printf>
    printf(1, "location of initialized data\t: %p\n", &init_data);
 144:	c7 44 24 08 b4 0e 00 	movl   $0xeb4,0x8(%esp)
 14b:	00 
 14c:	c7 44 24 04 48 0b 00 	movl   $0xb48,0x4(%esp)
 153:	00 
 154:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 15b:	e8 00 04 00 00       	call   560 <printf>
    printf(1, "\n");
 160:	c7 44 24 04 b4 0b 00 	movl   $0xbb4,0x4(%esp)
 167:	00 
 168:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 16f:	e8 ec 03 00 00       	call   560 <printf>

    printf(1, "location of const data\t\t: %p\n", &const_data);
 174:	c7 44 24 08 6c 0b 00 	movl   $0xb6c,0x8(%esp)
 17b:	00 
 17c:	c7 44 24 04 ca 0a 00 	movl   $0xaca,0x4(%esp)
 183:	00 
 184:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 18b:	e8 d0 03 00 00       	call   560 <printf>
    printf(1, "location of text\t\t: %p\n", main);
 190:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
 197:	00 
 198:	c7 44 24 04 e8 0a 00 	movl   $0xae8,0x4(%esp)
 19f:	00 
 1a0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1a7:	e8 b4 03 00 00       	call   560 <printf>

    exit();
 1ac:	e8 31 02 00 00       	call   3e2 <exit>
 1b1:	66 90                	xchg   %ax,%ax
 1b3:	66 90                	xchg   %ax,%ax
 1b5:	66 90                	xchg   %ax,%ax
 1b7:	66 90                	xchg   %ax,%ax
 1b9:	66 90                	xchg   %ax,%ax
 1bb:	66 90                	xchg   %ax,%ax
 1bd:	66 90                	xchg   %ax,%ax
 1bf:	90                   	nop

000001c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1c9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ca:	89 c2                	mov    %eax,%edx
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	83 c1 01             	add    $0x1,%ecx
 1d3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1d7:	83 c2 01             	add    $0x1,%edx
 1da:	84 db                	test   %bl,%bl
 1dc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1df:	75 ef                	jne    1d0 <strcpy+0x10>
    ;
  return os;
}
 1e1:	5b                   	pop    %ebx
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
 1f6:	53                   	push   %ebx
 1f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1fa:	0f b6 02             	movzbl (%edx),%eax
 1fd:	84 c0                	test   %al,%al
 1ff:	74 2d                	je     22e <strcmp+0x3e>
 201:	0f b6 19             	movzbl (%ecx),%ebx
 204:	38 d8                	cmp    %bl,%al
 206:	74 0e                	je     216 <strcmp+0x26>
 208:	eb 2b                	jmp    235 <strcmp+0x45>
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 210:	38 c8                	cmp    %cl,%al
 212:	75 15                	jne    229 <strcmp+0x39>
    p++, q++;
 214:	89 d9                	mov    %ebx,%ecx
 216:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 219:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 21c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 21f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 223:	84 c0                	test   %al,%al
 225:	75 e9                	jne    210 <strcmp+0x20>
 227:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 229:	29 c8                	sub    %ecx,%eax
}
 22b:	5b                   	pop    %ebx
 22c:	5d                   	pop    %ebp
 22d:	c3                   	ret    
 22e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 231:	31 c0                	xor    %eax,%eax
 233:	eb f4                	jmp    229 <strcmp+0x39>
 235:	0f b6 cb             	movzbl %bl,%ecx
 238:	eb ef                	jmp    229 <strcmp+0x39>
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <strlen>:

uint
strlen(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 246:	80 39 00             	cmpb   $0x0,(%ecx)
 249:	74 12                	je     25d <strlen+0x1d>
 24b:	31 d2                	xor    %edx,%edx
 24d:	8d 76 00             	lea    0x0(%esi),%esi
 250:	83 c2 01             	add    $0x1,%edx
 253:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 257:	89 d0                	mov    %edx,%eax
 259:	75 f5                	jne    250 <strlen+0x10>
    ;
  return n;
}
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 25d:	31 c0                	xor    %eax,%eax
}
 25f:	5d                   	pop    %ebp
 260:	c3                   	ret    
 261:	eb 0d                	jmp    270 <memset>
 263:	90                   	nop
 264:	90                   	nop
 265:	90                   	nop
 266:	90                   	nop
 267:	90                   	nop
 268:	90                   	nop
 269:	90                   	nop
 26a:	90                   	nop
 26b:	90                   	nop
 26c:	90                   	nop
 26d:	90                   	nop
 26e:	90                   	nop
 26f:	90                   	nop

00000270 <memset>:

void*
memset(void *dst, int c, uint n)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 55 08             	mov    0x8(%ebp),%edx
 276:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 277:	8b 4d 10             	mov    0x10(%ebp),%ecx
 27a:	8b 45 0c             	mov    0xc(%ebp),%eax
 27d:	89 d7                	mov    %edx,%edi
 27f:	fc                   	cld    
 280:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 282:	89 d0                	mov    %edx,%eax
 284:	5f                   	pop    %edi
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <strchr>:

char*
strchr(const char *s, char c)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	53                   	push   %ebx
 297:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 29a:	0f b6 18             	movzbl (%eax),%ebx
 29d:	84 db                	test   %bl,%bl
 29f:	74 1d                	je     2be <strchr+0x2e>
    if(*s == c)
 2a1:	38 d3                	cmp    %dl,%bl
 2a3:	89 d1                	mov    %edx,%ecx
 2a5:	75 0d                	jne    2b4 <strchr+0x24>
 2a7:	eb 17                	jmp    2c0 <strchr+0x30>
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2b0:	38 ca                	cmp    %cl,%dl
 2b2:	74 0c                	je     2c0 <strchr+0x30>
  for(; *s; s++)
 2b4:	83 c0 01             	add    $0x1,%eax
 2b7:	0f b6 10             	movzbl (%eax),%edx
 2ba:	84 d2                	test   %dl,%dl
 2bc:	75 f2                	jne    2b0 <strchr+0x20>
      return (char*)s;
  return 0;
 2be:	31 c0                	xor    %eax,%eax
}
 2c0:	5b                   	pop    %ebx
 2c1:	5d                   	pop    %ebp
 2c2:	c3                   	ret    
 2c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <gets>:

char*
gets(char *buf, int max)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d5:	31 f6                	xor    %esi,%esi
{
 2d7:	53                   	push   %ebx
 2d8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 2db:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2de:	eb 31                	jmp    311 <gets+0x41>
    cc = read(0, &c, 1);
 2e0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2e7:	00 
 2e8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2ec:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2f3:	e8 02 01 00 00       	call   3fa <read>
    if(cc < 1)
 2f8:	85 c0                	test   %eax,%eax
 2fa:	7e 1d                	jle    319 <gets+0x49>
      break;
    buf[i++] = c;
 2fc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 300:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 302:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 305:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 307:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 30b:	74 0c                	je     319 <gets+0x49>
 30d:	3c 0a                	cmp    $0xa,%al
 30f:	74 08                	je     319 <gets+0x49>
  for(i=0; i+1 < max; ){
 311:	8d 5e 01             	lea    0x1(%esi),%ebx
 314:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 317:	7c c7                	jl     2e0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 320:	83 c4 2c             	add    $0x2c,%esp
 323:	5b                   	pop    %ebx
 324:	5e                   	pop    %esi
 325:	5f                   	pop    %edi
 326:	5d                   	pop    %ebp
 327:	c3                   	ret    
 328:	90                   	nop
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000330 <stat>:

int
stat(const char *n, struct stat *st)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 342:	00 
 343:	89 04 24             	mov    %eax,(%esp)
 346:	e8 d7 00 00 00       	call   422 <open>
  if(fd < 0)
 34b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 34d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 34f:	78 27                	js     378 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 351:	8b 45 0c             	mov    0xc(%ebp),%eax
 354:	89 1c 24             	mov    %ebx,(%esp)
 357:	89 44 24 04          	mov    %eax,0x4(%esp)
 35b:	e8 da 00 00 00       	call   43a <fstat>
  close(fd);
 360:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 363:	89 c6                	mov    %eax,%esi
  close(fd);
 365:	e8 a0 00 00 00       	call   40a <close>
  return r;
 36a:	89 f0                	mov    %esi,%eax
}
 36c:	83 c4 10             	add    $0x10,%esp
 36f:	5b                   	pop    %ebx
 370:	5e                   	pop    %esi
 371:	5d                   	pop    %ebp
 372:	c3                   	ret    
 373:	90                   	nop
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 37d:	eb ed                	jmp    36c <stat+0x3c>
 37f:	90                   	nop

00000380 <atoi>:

int
atoi(const char *s)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	8b 4d 08             	mov    0x8(%ebp),%ecx
 386:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 387:	0f be 11             	movsbl (%ecx),%edx
 38a:	8d 42 d0             	lea    -0x30(%edx),%eax
 38d:	3c 09                	cmp    $0x9,%al
  n = 0;
 38f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 394:	77 17                	ja     3ad <atoi+0x2d>
 396:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 398:	83 c1 01             	add    $0x1,%ecx
 39b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 39e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3a2:	0f be 11             	movsbl (%ecx),%edx
 3a5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3a8:	80 fb 09             	cmp    $0x9,%bl
 3ab:	76 eb                	jbe    398 <atoi+0x18>
  return n;
}
 3ad:	5b                   	pop    %ebx
 3ae:	5d                   	pop    %ebp
 3af:	c3                   	ret    

000003b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3b0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3b1:	31 d2                	xor    %edx,%edx
{
 3b3:	89 e5                	mov    %esp,%ebp
 3b5:	56                   	push   %esi
 3b6:	8b 45 08             	mov    0x8(%ebp),%eax
 3b9:	53                   	push   %ebx
 3ba:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3bd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 3c0:	85 db                	test   %ebx,%ebx
 3c2:	7e 12                	jle    3d6 <memmove+0x26>
 3c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3d2:	39 da                	cmp    %ebx,%edx
 3d4:	75 f2                	jne    3c8 <memmove+0x18>
  return vdst;
}
 3d6:	5b                   	pop    %ebx
 3d7:	5e                   	pop    %esi
 3d8:	5d                   	pop    %ebp
 3d9:	c3                   	ret    

000003da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3da:	b8 01 00 00 00       	mov    $0x1,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <exit>:
SYSCALL(exit)
 3e2:	b8 02 00 00 00       	mov    $0x2,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <wait>:
SYSCALL(wait)
 3ea:	b8 03 00 00 00       	mov    $0x3,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <pipe>:
SYSCALL(pipe)
 3f2:	b8 04 00 00 00       	mov    $0x4,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <read>:
SYSCALL(read)
 3fa:	b8 05 00 00 00       	mov    $0x5,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <write>:
SYSCALL(write)
 402:	b8 10 00 00 00       	mov    $0x10,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <close>:
SYSCALL(close)
 40a:	b8 15 00 00 00       	mov    $0x15,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <kill>:
SYSCALL(kill)
 412:	b8 06 00 00 00       	mov    $0x6,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <exec>:
SYSCALL(exec)
 41a:	b8 07 00 00 00       	mov    $0x7,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <open>:
SYSCALL(open)
 422:	b8 0f 00 00 00       	mov    $0xf,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <mknod>:
SYSCALL(mknod)
 42a:	b8 11 00 00 00       	mov    $0x11,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <unlink>:
SYSCALL(unlink)
 432:	b8 12 00 00 00       	mov    $0x12,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <fstat>:
SYSCALL(fstat)
 43a:	b8 08 00 00 00       	mov    $0x8,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <link>:
SYSCALL(link)
 442:	b8 13 00 00 00       	mov    $0x13,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <mkdir>:
SYSCALL(mkdir)
 44a:	b8 14 00 00 00       	mov    $0x14,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <chdir>:
SYSCALL(chdir)
 452:	b8 09 00 00 00       	mov    $0x9,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <dup>:
SYSCALL(dup)
 45a:	b8 0a 00 00 00       	mov    $0xa,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <getpid>:
SYSCALL(getpid)
 462:	b8 0b 00 00 00       	mov    $0xb,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <sbrk>:
SYSCALL(sbrk)
 46a:	b8 0c 00 00 00       	mov    $0xc,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <sleep>:
SYSCALL(sleep)
 472:	b8 0d 00 00 00       	mov    $0xd,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <uptime>:
SYSCALL(uptime)
 47a:	b8 0e 00 00 00       	mov    $0xe,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 482:	b8 16 00 00 00       	mov    $0x16,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 48a:	b8 17 00 00 00       	mov    $0x17,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 492:	b8 18 00 00 00       	mov    $0x18,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <halt>:
SYSCALL(halt)
 49a:	b8 19 00 00 00       	mov    $0x19,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 4a2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <kthread_join>:
SYSCALL(kthread_join)
 4aa:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <kthread_exit>:
SYSCALL(kthread_exit)
 4b2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    
 4ba:	66 90                	xchg   %ax,%ax
 4bc:	66 90                	xchg   %ax,%ax
 4be:	66 90                	xchg   %ax,%ax

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	89 c6                	mov    %eax,%esi
 4c7:	53                   	push   %ebx
 4c8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ce:	85 db                	test   %ebx,%ebx
 4d0:	74 09                	je     4db <printint+0x1b>
 4d2:	89 d0                	mov    %edx,%eax
 4d4:	c1 e8 1f             	shr    $0x1f,%eax
 4d7:	84 c0                	test   %al,%al
 4d9:	75 75                	jne    550 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4db:	89 d0                	mov    %edx,%eax
  neg = 0;
 4dd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4e4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 4e7:	31 ff                	xor    %edi,%edi
 4e9:	89 ce                	mov    %ecx,%esi
 4eb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ee:	eb 02                	jmp    4f2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 4f0:	89 cf                	mov    %ecx,%edi
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	f7 f6                	div    %esi
 4f6:	8d 4f 01             	lea    0x1(%edi),%ecx
 4f9:	0f b6 92 7f 0b 00 00 	movzbl 0xb7f(%edx),%edx
  }while((x /= base) != 0);
 500:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 502:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 505:	75 e9                	jne    4f0 <printint+0x30>
  if(neg)
 507:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 50a:	89 c8                	mov    %ecx,%eax
 50c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 50f:	85 d2                	test   %edx,%edx
 511:	74 08                	je     51b <printint+0x5b>
    buf[i++] = '-';
 513:	8d 4f 02             	lea    0x2(%edi),%ecx
 516:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 51b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 51e:	66 90                	xchg   %ax,%ax
 520:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 525:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 528:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 52f:	00 
 530:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 534:	89 34 24             	mov    %esi,(%esp)
 537:	88 45 d7             	mov    %al,-0x29(%ebp)
 53a:	e8 c3 fe ff ff       	call   402 <write>
  while(--i >= 0)
 53f:	83 ff ff             	cmp    $0xffffffff,%edi
 542:	75 dc                	jne    520 <printint+0x60>
    putc(fd, buf[i]);
}
 544:	83 c4 4c             	add    $0x4c,%esp
 547:	5b                   	pop    %ebx
 548:	5e                   	pop    %esi
 549:	5f                   	pop    %edi
 54a:	5d                   	pop    %ebp
 54b:	c3                   	ret    
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 550:	89 d0                	mov    %edx,%eax
 552:	f7 d8                	neg    %eax
    neg = 1;
 554:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 55b:	eb 87                	jmp    4e4 <printint+0x24>
 55d:	8d 76 00             	lea    0x0(%esi),%esi

00000560 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 564:	31 ff                	xor    %edi,%edi
{
 566:	56                   	push   %esi
 567:	53                   	push   %ebx
 568:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 56e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 571:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 574:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 577:	0f b6 13             	movzbl (%ebx),%edx
 57a:	83 c3 01             	add    $0x1,%ebx
 57d:	84 d2                	test   %dl,%dl
 57f:	75 39                	jne    5ba <printf+0x5a>
 581:	e9 ca 00 00 00       	jmp    650 <printf+0xf0>
 586:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 588:	83 fa 25             	cmp    $0x25,%edx
 58b:	0f 84 c7 00 00 00    	je     658 <printf+0xf8>
  write(fd, &c, 1);
 591:	8d 45 e0             	lea    -0x20(%ebp),%eax
 594:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 59b:	00 
 59c:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 5a3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 5a6:	e8 57 fe ff ff       	call   402 <write>
 5ab:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 5ae:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5b2:	84 d2                	test   %dl,%dl
 5b4:	0f 84 96 00 00 00    	je     650 <printf+0xf0>
    if(state == 0){
 5ba:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 5bc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 5bf:	74 c7                	je     588 <printf+0x28>
      }
    } else if(state == '%'){
 5c1:	83 ff 25             	cmp    $0x25,%edi
 5c4:	75 e5                	jne    5ab <printf+0x4b>
      if(c == 'd' || c == 'u'){
 5c6:	83 fa 75             	cmp    $0x75,%edx
 5c9:	0f 84 99 00 00 00    	je     668 <printf+0x108>
 5cf:	83 fa 64             	cmp    $0x64,%edx
 5d2:	0f 84 90 00 00 00    	je     668 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5d8:	25 f7 00 00 00       	and    $0xf7,%eax
 5dd:	83 f8 70             	cmp    $0x70,%eax
 5e0:	0f 84 aa 00 00 00    	je     690 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5e6:	83 fa 73             	cmp    $0x73,%edx
 5e9:	0f 84 e9 00 00 00    	je     6d8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ef:	83 fa 63             	cmp    $0x63,%edx
 5f2:	0f 84 2b 01 00 00    	je     723 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5f8:	83 fa 25             	cmp    $0x25,%edx
 5fb:	0f 84 4f 01 00 00    	je     750 <printf+0x1f0>
  write(fd, &c, 1);
 601:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 604:	83 c3 01             	add    $0x1,%ebx
 607:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 60e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 60f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 611:	89 44 24 04          	mov    %eax,0x4(%esp)
 615:	89 34 24             	mov    %esi,(%esp)
 618:	89 55 d0             	mov    %edx,-0x30(%ebp)
 61b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 61f:	e8 de fd ff ff       	call   402 <write>
        putc(fd, c);
 624:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 627:	8d 45 e7             	lea    -0x19(%ebp),%eax
 62a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 631:	00 
 632:	89 44 24 04          	mov    %eax,0x4(%esp)
 636:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 639:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 63c:	e8 c1 fd ff ff       	call   402 <write>
  for(i = 0; fmt[i]; i++){
 641:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 645:	84 d2                	test   %dl,%dl
 647:	0f 85 6d ff ff ff    	jne    5ba <printf+0x5a>
 64d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 650:	83 c4 3c             	add    $0x3c,%esp
 653:	5b                   	pop    %ebx
 654:	5e                   	pop    %esi
 655:	5f                   	pop    %edi
 656:	5d                   	pop    %ebp
 657:	c3                   	ret    
        state = '%';
 658:	bf 25 00 00 00       	mov    $0x25,%edi
 65d:	e9 49 ff ff ff       	jmp    5ab <printf+0x4b>
 662:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 668:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 66f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 674:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 677:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 679:	8b 10                	mov    (%eax),%edx
 67b:	89 f0                	mov    %esi,%eax
 67d:	e8 3e fe ff ff       	call   4c0 <printint>
        ap++;
 682:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 686:	e9 20 ff ff ff       	jmp    5ab <printf+0x4b>
 68b:	90                   	nop
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 690:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 693:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 69a:	00 
 69b:	89 44 24 04          	mov    %eax,0x4(%esp)
 69f:	89 34 24             	mov    %esi,(%esp)
 6a2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 6a6:	e8 57 fd ff ff       	call   402 <write>
 6ab:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6ae:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b5:	00 
 6b6:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ba:	89 34 24             	mov    %esi,(%esp)
 6bd:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 6c1:	e8 3c fd ff ff       	call   402 <write>
        printint(fd, *ap, 16, 0);
 6c6:	b9 10 00 00 00       	mov    $0x10,%ecx
 6cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6d2:	eb a0                	jmp    674 <printf+0x114>
 6d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 6db:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 6df:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 6e1:	b8 78 0b 00 00       	mov    $0xb78,%eax
 6e6:	85 ff                	test   %edi,%edi
 6e8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 6eb:	0f b6 07             	movzbl (%edi),%eax
 6ee:	84 c0                	test   %al,%al
 6f0:	74 2a                	je     71c <printf+0x1bc>
 6f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6f8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6fb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 6fe:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 701:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 708:	00 
 709:	89 44 24 04          	mov    %eax,0x4(%esp)
 70d:	89 34 24             	mov    %esi,(%esp)
 710:	e8 ed fc ff ff       	call   402 <write>
        while(*s != 0){
 715:	0f b6 07             	movzbl (%edi),%eax
 718:	84 c0                	test   %al,%al
 71a:	75 dc                	jne    6f8 <printf+0x198>
      state = 0;
 71c:	31 ff                	xor    %edi,%edi
 71e:	e9 88 fe ff ff       	jmp    5ab <printf+0x4b>
        putc(fd, *ap);
 723:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 726:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 728:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 72a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 731:	00 
 732:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 735:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 738:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 73b:	89 44 24 04          	mov    %eax,0x4(%esp)
 73f:	e8 be fc ff ff       	call   402 <write>
        ap++;
 744:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 748:	e9 5e fe ff ff       	jmp    5ab <printf+0x4b>
 74d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 750:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 753:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 755:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 75c:	00 
 75d:	89 44 24 04          	mov    %eax,0x4(%esp)
 761:	89 34 24             	mov    %esi,(%esp)
 764:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 768:	e8 95 fc ff ff       	call   402 <write>
 76d:	e9 39 fe ff ff       	jmp    5ab <printf+0x4b>
 772:	66 90                	xchg   %ax,%ax
 774:	66 90                	xchg   %ax,%ax
 776:	66 90                	xchg   %ax,%ax
 778:	66 90                	xchg   %ax,%ax
 77a:	66 90                	xchg   %ax,%ax
 77c:	66 90                	xchg   %ax,%ax
 77e:	66 90                	xchg   %ax,%ax

00000780 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 780:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 781:	a1 bc 0e 00 00       	mov    0xebc,%eax
{
 786:	89 e5                	mov    %esp,%ebp
 788:	57                   	push   %edi
 789:	56                   	push   %esi
 78a:	53                   	push   %ebx
 78b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 78e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 790:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 793:	39 d0                	cmp    %edx,%eax
 795:	72 11                	jb     7a8 <free+0x28>
 797:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 798:	39 c8                	cmp    %ecx,%eax
 79a:	72 04                	jb     7a0 <free+0x20>
 79c:	39 ca                	cmp    %ecx,%edx
 79e:	72 10                	jb     7b0 <free+0x30>
 7a0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a6:	73 f0                	jae    798 <free+0x18>
 7a8:	39 ca                	cmp    %ecx,%edx
 7aa:	72 04                	jb     7b0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ac:	39 c8                	cmp    %ecx,%eax
 7ae:	72 f0                	jb     7a0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7b0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7b3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 7b6:	39 cf                	cmp    %ecx,%edi
 7b8:	74 1e                	je     7d8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ba:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7bd:	8b 48 04             	mov    0x4(%eax),%ecx
 7c0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7c3:	39 f2                	cmp    %esi,%edx
 7c5:	74 28                	je     7ef <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7c7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7c9:	a3 bc 0e 00 00       	mov    %eax,0xebc
}
 7ce:	5b                   	pop    %ebx
 7cf:	5e                   	pop    %esi
 7d0:	5f                   	pop    %edi
 7d1:	5d                   	pop    %ebp
 7d2:	c3                   	ret    
 7d3:	90                   	nop
 7d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7d8:	03 71 04             	add    0x4(%ecx),%esi
 7db:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7de:	8b 08                	mov    (%eax),%ecx
 7e0:	8b 09                	mov    (%ecx),%ecx
 7e2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7e5:	8b 48 04             	mov    0x4(%eax),%ecx
 7e8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7eb:	39 f2                	cmp    %esi,%edx
 7ed:	75 d8                	jne    7c7 <free+0x47>
    p->s.size += bp->s.size;
 7ef:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 7f2:	a3 bc 0e 00 00       	mov    %eax,0xebc
    p->s.size += bp->s.size;
 7f7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7fa:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7fd:	89 10                	mov    %edx,(%eax)
}
 7ff:	5b                   	pop    %ebx
 800:	5e                   	pop    %esi
 801:	5f                   	pop    %edi
 802:	5d                   	pop    %ebp
 803:	c3                   	ret    
 804:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 80a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000810 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 810:	55                   	push   %ebp
 811:	89 e5                	mov    %esp,%ebp
 813:	57                   	push   %edi
 814:	56                   	push   %esi
 815:	53                   	push   %ebx
 816:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 819:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 81c:	8b 1d bc 0e 00 00    	mov    0xebc,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 822:	8d 48 07             	lea    0x7(%eax),%ecx
 825:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 828:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 82a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 82d:	0f 84 9b 00 00 00    	je     8ce <malloc+0xbe>
 833:	8b 13                	mov    (%ebx),%edx
 835:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 838:	39 fe                	cmp    %edi,%esi
 83a:	76 64                	jbe    8a0 <malloc+0x90>
 83c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 843:	bb 00 80 00 00       	mov    $0x8000,%ebx
 848:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 84b:	eb 0e                	jmp    85b <malloc+0x4b>
 84d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 852:	8b 78 04             	mov    0x4(%eax),%edi
 855:	39 fe                	cmp    %edi,%esi
 857:	76 4f                	jbe    8a8 <malloc+0x98>
 859:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 85b:	3b 15 bc 0e 00 00    	cmp    0xebc,%edx
 861:	75 ed                	jne    850 <malloc+0x40>
  if(nu < 4096)
 863:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 866:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 86c:	bf 00 10 00 00       	mov    $0x1000,%edi
 871:	0f 43 fe             	cmovae %esi,%edi
 874:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 877:	89 04 24             	mov    %eax,(%esp)
 87a:	e8 eb fb ff ff       	call   46a <sbrk>
  if(p == (char*)-1)
 87f:	83 f8 ff             	cmp    $0xffffffff,%eax
 882:	74 18                	je     89c <malloc+0x8c>
  hp->s.size = nu;
 884:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 887:	83 c0 08             	add    $0x8,%eax
 88a:	89 04 24             	mov    %eax,(%esp)
 88d:	e8 ee fe ff ff       	call   780 <free>
  return freep;
 892:	8b 15 bc 0e 00 00    	mov    0xebc,%edx
      if((p = morecore(nunits)) == 0)
 898:	85 d2                	test   %edx,%edx
 89a:	75 b4                	jne    850 <malloc+0x40>
        return 0;
 89c:	31 c0                	xor    %eax,%eax
 89e:	eb 20                	jmp    8c0 <malloc+0xb0>
    if(p->s.size >= nunits){
 8a0:	89 d0                	mov    %edx,%eax
 8a2:	89 da                	mov    %ebx,%edx
 8a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 8a8:	39 fe                	cmp    %edi,%esi
 8aa:	74 1c                	je     8c8 <malloc+0xb8>
        p->s.size -= nunits;
 8ac:	29 f7                	sub    %esi,%edi
 8ae:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 8b1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 8b4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8b7:	89 15 bc 0e 00 00    	mov    %edx,0xebc
      return (void*)(p + 1);
 8bd:	83 c0 08             	add    $0x8,%eax
  }
}
 8c0:	83 c4 1c             	add    $0x1c,%esp
 8c3:	5b                   	pop    %ebx
 8c4:	5e                   	pop    %esi
 8c5:	5f                   	pop    %edi
 8c6:	5d                   	pop    %ebp
 8c7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 8c8:	8b 08                	mov    (%eax),%ecx
 8ca:	89 0a                	mov    %ecx,(%edx)
 8cc:	eb e9                	jmp    8b7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 8ce:	c7 05 bc 0e 00 00 c0 	movl   $0xec0,0xebc
 8d5:	0e 00 00 
    base.s.size = 0;
 8d8:	ba c0 0e 00 00       	mov    $0xec0,%edx
    base.s.ptr = freep = prevp = &base;
 8dd:	c7 05 c0 0e 00 00 c0 	movl   $0xec0,0xec0
 8e4:	0e 00 00 
    base.s.size = 0;
 8e7:	c7 05 c4 0e 00 00 00 	movl   $0x0,0xec4
 8ee:	00 00 00 
 8f1:	e9 46 ff ff ff       	jmp    83c <malloc+0x2c>
 8f6:	66 90                	xchg   %ax,%ax
 8f8:	66 90                	xchg   %ax,%ax
 8fa:	66 90                	xchg   %ax,%ax
 8fc:	66 90                	xchg   %ax,%ax
 8fe:	66 90                	xchg   %ax,%ax

00000900 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 900:	55                   	push   %ebp
 901:	89 e5                	mov    %esp,%ebp
 903:	53                   	push   %ebx
 904:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 907:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 90e:	e8 fd fe ff ff       	call   810 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 913:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 91a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 91c:	e8 ef fe ff ff       	call   810 <malloc>
    if (tstack == NULL) {
 921:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 923:	89 c2                	mov    %eax,%edx
 925:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 928:	0f 84 8a 00 00 00    	je     9b8 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 92e:	25 ff 0f 00 00       	and    $0xfff,%eax
 933:	75 73                	jne    9a8 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 935:	8b 45 10             	mov    0x10(%ebp),%eax
 938:	89 54 24 08          	mov    %edx,0x8(%esp)
 93c:	89 44 24 04          	mov    %eax,0x4(%esp)
 940:	8b 45 0c             	mov    0xc(%ebp),%eax
 943:	89 04 24             	mov    %eax,(%esp)
 946:	e8 57 fb ff ff       	call   4a2 <kthread_create>
 94b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 94d:	89 44 24 10          	mov    %eax,0x10(%esp)
 951:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 958:	00 
 959:	c7 44 24 08 90 0b 00 	movl   $0xb90,0x8(%esp)
 960:	00 
 961:	c7 44 24 04 9f 0b 00 	movl   $0xb9f,0x4(%esp)
 968:	00 
 969:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 970:	e8 eb fb ff ff       	call   560 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 975:	8b 03                	mov    (%ebx),%eax
 977:	c7 44 24 04 b6 0b 00 	movl   $0xbb6,0x4(%esp)
 97e:	00 
 97f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 986:	89 44 24 08          	mov    %eax,0x8(%esp)
 98a:	e8 d1 fb ff ff       	call   560 <printf>
    
    if (bt->tid != 0) {
 98f:	8b 03                	mov    (%ebx),%eax
 991:	85 c0                	test   %eax,%eax
 993:	74 23                	je     9b8 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 995:	8b 45 08             	mov    0x8(%ebp),%eax
 998:	89 18                	mov    %ebx,(%eax)
        return 0;
 99a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 99c:	83 c4 24             	add    $0x24,%esp
 99f:	5b                   	pop    %ebx
 9a0:	5d                   	pop    %ebp
 9a1:	c3                   	ret    
 9a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 9a8:	29 c2                	sub    %eax,%edx
 9aa:	81 c2 00 10 00 00    	add    $0x1000,%edx
 9b0:	eb 83                	jmp    935 <benny_thread_create+0x35>
 9b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 9b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9bd:	eb dd                	jmp    99c <benny_thread_create+0x9c>
 9bf:	90                   	nop

000009c0 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 9c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 9c6:	5d                   	pop    %ebp
    return bt->tid;
 9c7:	8b 00                	mov    (%eax),%eax
}
 9c9:	c3                   	ret    
 9ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000009d0 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	53                   	push   %ebx
 9d4:	83 ec 14             	sub    $0x14,%esp
 9d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 9da:	8b 03                	mov    (%ebx),%eax
 9dc:	89 04 24             	mov    %eax,(%esp)
 9df:	e8 c6 fa ff ff       	call   4aa <kthread_join>
    if (retVal == 0) {
 9e4:	85 c0                	test   %eax,%eax
 9e6:	75 11                	jne    9f9 <benny_thread_join+0x29>
        free(bt->tstack);
 9e8:	8b 53 04             	mov    0x4(%ebx),%edx
 9eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9ee:	89 14 24             	mov    %edx,(%esp)
 9f1:	e8 8a fd ff ff       	call   780 <free>
 9f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 9f9:	83 c4 14             	add    $0x14,%esp
 9fc:	5b                   	pop    %ebx
 9fd:	5d                   	pop    %ebp
 9fe:	c3                   	ret    
 9ff:	90                   	nop

00000a00 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 a06:	8b 45 08             	mov    0x8(%ebp),%eax
 a09:	89 04 24             	mov    %eax,(%esp)
 a0c:	e8 a1 fa ff ff       	call   4b2 <kthread_exit>
    return 0;
}
 a11:	31 c0                	xor    %eax,%eax
 a13:	c9                   	leave  
 a14:	c3                   	ret    
