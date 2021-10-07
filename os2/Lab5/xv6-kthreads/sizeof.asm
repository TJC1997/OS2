
_sizeof:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
    printf(1, "This appears to be a %d bit system.\n", __WORDSIZE);
   9:	c7 44 24 08 20 00 00 	movl   $0x20,0x8(%esp)
  10:	00 
  11:	c7 44 24 04 d8 09 00 	movl   $0x9d8,0x4(%esp)
  18:	00 
  19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  20:	e8 fb 04 00 00       	call   520 <printf>
    {
        unsigned int i = 1;

        char *c = (char *) &i;
        if (0 != (*c)) {
            printf(1, "    This system is little endian.\n");
  25:	c7 44 24 04 00 0a 00 	movl   $0xa00,0x4(%esp)
  2c:	00 
  2d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  34:	e8 e7 04 00 00       	call   520 <printf>
        }
        else {
            printf(1, "    This system is big endian.\n");
        }
    }
    printf(1, "\n");
  39:	c7 44 24 04 b0 0b 00 	movl   $0xbb0,0x4(%esp)
  40:	00 
  41:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  48:	e8 d3 04 00 00       	call   520 <printf>

    printf(1, "Size of basic C data types\n");
  4d:	c7 44 24 04 58 0b 00 	movl   $0xb58,0x4(%esp)
  54:	00 
  55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  5c:	e8 bf 04 00 00       	call   520 <printf>
    printf(1, "                        bytes  bits\n");
  61:	c7 44 24 04 24 0a 00 	movl   $0xa24,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	e8 ab 04 00 00       	call   520 <printf>
    printf(1, "    sizeof(char)        %d      %d\n"
  75:	c7 44 24 0c 08 00 00 	movl   $0x8,0xc(%esp)
  7c:	00 
  7d:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  84:	00 
  85:	c7 44 24 04 4c 0a 00 	movl   $0xa4c,0x4(%esp)
  8c:	00 
  8d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  94:	e8 87 04 00 00       	call   520 <printf>
           , (int) sizeof(char)
           , (int) CHARBITS);
    printf(1, "    sizeof(short)       %d      %d\n"
  99:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
  a0:	00 
  a1:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
  a8:	00 
  a9:	c7 44 24 04 70 0a 00 	movl   $0xa70,0x4(%esp)
  b0:	00 
  b1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  b8:	e8 63 04 00 00       	call   520 <printf>
           , (int) sizeof(short)
           , (int) SHORTBITS);
    printf(1, "    sizeof(int)         %d      %d\n"
  bd:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  c4:	00 
  c5:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  cc:	00 
  cd:	c7 44 24 04 94 0a 00 	movl   $0xa94,0x4(%esp)
  d4:	00 
  d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  dc:	e8 3f 04 00 00       	call   520 <printf>
           , (int) sizeof(int)
           , (int) INTBITS);
    printf(1, "    sizeof(unsigned)    %d      %d\n"
  e1:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
  e8:	00 
  e9:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  f0:	00 
  f1:	c7 44 24 04 b8 0a 00 	movl   $0xab8,0x4(%esp)
  f8:	00 
  f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 100:	e8 1b 04 00 00       	call   520 <printf>
           , (int) sizeof(unsigned)
           // This is not directly supported by a nice macro, so I'm
           //   calculating it.
           , (int) (sizeof(unsigned) * CHARBITS));
    printf(1, "    sizeof(long)        %d      %d\n"
 105:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
 10c:	00 
 10d:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
 114:	00 
 115:	c7 44 24 04 dc 0a 00 	movl   $0xadc,0x4(%esp)
 11c:	00 
 11d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 124:	e8 f7 03 00 00       	call   520 <printf>
           , (int) sizeof(long)
           , (int) LONGBITS);
    printf(1, "    sizeof(long long)   %d      %d\n"
 129:	c7 44 24 0c 40 00 00 	movl   $0x40,0xc(%esp)
 130:	00 
 131:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
 138:	00 
 139:	c7 44 24 04 00 0b 00 	movl   $0xb00,0x4(%esp)
 140:	00 
 141:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 148:	e8 d3 03 00 00       	call   520 <printf>
           , (int) sizeof(long long)
           // This is not directly supported by a nice macro, sir I'm
           //   calculating it.
           , (int) (sizeof(long long) * CHARBITS));

    printf(1, "    sizeof(void *)      %d      %d (aka a pointer)\n"
 14d:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
 154:	00 
 155:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
 15c:	00 
 15d:	c7 44 24 04 24 0b 00 	movl   $0xb24,0x4(%esp)
 164:	00 
 165:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 16c:	e8 af 03 00 00       	call   520 <printf>
           , (int) sizeof(void *), (int) PTRBITS);

    // You MUST call exit() as the last thing your code does in xv6.
    exit();
 171:	e8 2c 02 00 00       	call   3a2 <exit>
 176:	66 90                	xchg   %ax,%ax
 178:	66 90                	xchg   %ax,%ax
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	8b 45 08             	mov    0x8(%ebp),%eax
 186:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 189:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 55 08             	mov    0x8(%ebp),%edx
 1b6:	53                   	push   %ebx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	84 c0                	test   %al,%al
 1bf:	74 2d                	je     1ee <strcmp+0x3e>
 1c1:	0f b6 19             	movzbl (%ecx),%ebx
 1c4:	38 d8                	cmp    %bl,%al
 1c6:	74 0e                	je     1d6 <strcmp+0x26>
 1c8:	eb 2b                	jmp    1f5 <strcmp+0x45>
 1ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1d0:	38 c8                	cmp    %cl,%al
 1d2:	75 15                	jne    1e9 <strcmp+0x39>
    p++, q++;
 1d4:	89 d9                	mov    %ebx,%ecx
 1d6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1d9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1dc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1df:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1e3:	84 c0                	test   %al,%al
 1e5:	75 e9                	jne    1d0 <strcmp+0x20>
 1e7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1e9:	29 c8                	sub    %ecx,%eax
}
 1eb:	5b                   	pop    %ebx
 1ec:	5d                   	pop    %ebp
 1ed:	c3                   	ret    
 1ee:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 1f1:	31 c0                	xor    %eax,%eax
 1f3:	eb f4                	jmp    1e9 <strcmp+0x39>
 1f5:	0f b6 cb             	movzbl %bl,%ecx
 1f8:	eb ef                	jmp    1e9 <strcmp+0x39>
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 12                	je     21d <strlen+0x1d>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 21d:	31 c0                	xor    %eax,%eax
}
 21f:	5d                   	pop    %ebp
 220:	c3                   	ret    
 221:	eb 0d                	jmp    230 <memset>
 223:	90                   	nop
 224:	90                   	nop
 225:	90                   	nop
 226:	90                   	nop
 227:	90                   	nop
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 55 08             	mov    0x8(%ebp),%edx
 236:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	53                   	push   %ebx
 257:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 25a:	0f b6 18             	movzbl (%eax),%ebx
 25d:	84 db                	test   %bl,%bl
 25f:	74 1d                	je     27e <strchr+0x2e>
    if(*s == c)
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d1                	mov    %edx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 295:	31 f6                	xor    %esi,%esi
{
 297:	53                   	push   %ebx
 298:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 29b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 29e:	eb 31                	jmp    2d1 <gets+0x41>
    cc = read(0, &c, 1);
 2a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2a7:	00 
 2a8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2ac:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2b3:	e8 02 01 00 00       	call   3ba <read>
    if(cc < 1)
 2b8:	85 c0                	test   %eax,%eax
 2ba:	7e 1d                	jle    2d9 <gets+0x49>
      break;
    buf[i++] = c;
 2bc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 2c0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 2c2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2c5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 2c7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2cb:	74 0c                	je     2d9 <gets+0x49>
 2cd:	3c 0a                	cmp    $0xa,%al
 2cf:	74 08                	je     2d9 <gets+0x49>
  for(i=0; i+1 < max; ){
 2d1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d7:	7c c7                	jl     2a0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2d9:	8b 45 08             	mov    0x8(%ebp),%eax
 2dc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2e0:	83 c4 2c             	add    $0x2c,%esp
 2e3:	5b                   	pop    %ebx
 2e4:	5e                   	pop    %esi
 2e5:	5f                   	pop    %edi
 2e6:	5d                   	pop    %ebp
 2e7:	c3                   	ret    
 2e8:	90                   	nop
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	56                   	push   %esi
 2f4:	53                   	push   %ebx
 2f5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2f8:	8b 45 08             	mov    0x8(%ebp),%eax
 2fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 302:	00 
 303:	89 04 24             	mov    %eax,(%esp)
 306:	e8 d7 00 00 00       	call   3e2 <open>
  if(fd < 0)
 30b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 30d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 30f:	78 27                	js     338 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 311:	8b 45 0c             	mov    0xc(%ebp),%eax
 314:	89 1c 24             	mov    %ebx,(%esp)
 317:	89 44 24 04          	mov    %eax,0x4(%esp)
 31b:	e8 da 00 00 00       	call   3fa <fstat>
  close(fd);
 320:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 323:	89 c6                	mov    %eax,%esi
  close(fd);
 325:	e8 a0 00 00 00       	call   3ca <close>
  return r;
 32a:	89 f0                	mov    %esi,%eax
}
 32c:	83 c4 10             	add    $0x10,%esp
 32f:	5b                   	pop    %ebx
 330:	5e                   	pop    %esi
 331:	5d                   	pop    %ebp
 332:	c3                   	ret    
 333:	90                   	nop
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 338:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 33d:	eb ed                	jmp    32c <stat+0x3c>
 33f:	90                   	nop

00000340 <atoi>:

int
atoi(const char *s)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 4d 08             	mov    0x8(%ebp),%ecx
 346:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 347:	0f be 11             	movsbl (%ecx),%edx
 34a:	8d 42 d0             	lea    -0x30(%edx),%eax
 34d:	3c 09                	cmp    $0x9,%al
  n = 0;
 34f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 354:	77 17                	ja     36d <atoi+0x2d>
 356:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 358:	83 c1 01             	add    $0x1,%ecx
 35b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 35e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 362:	0f be 11             	movsbl (%ecx),%edx
 365:	8d 5a d0             	lea    -0x30(%edx),%ebx
 368:	80 fb 09             	cmp    $0x9,%bl
 36b:	76 eb                	jbe    358 <atoi+0x18>
  return n;
}
 36d:	5b                   	pop    %ebx
 36e:	5d                   	pop    %ebp
 36f:	c3                   	ret    

00000370 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 370:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 371:	31 d2                	xor    %edx,%edx
{
 373:	89 e5                	mov    %esp,%ebp
 375:	56                   	push   %esi
 376:	8b 45 08             	mov    0x8(%ebp),%eax
 379:	53                   	push   %ebx
 37a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 37d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 380:	85 db                	test   %ebx,%ebx
 382:	7e 12                	jle    396 <memmove+0x26>
 384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 388:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 38c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 38f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 392:	39 da                	cmp    %ebx,%edx
 394:	75 f2                	jne    388 <memmove+0x18>
  return vdst;
}
 396:	5b                   	pop    %ebx
 397:	5e                   	pop    %esi
 398:	5d                   	pop    %ebp
 399:	c3                   	ret    

0000039a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 39a:	b8 01 00 00 00       	mov    $0x1,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <exit>:
SYSCALL(exit)
 3a2:	b8 02 00 00 00       	mov    $0x2,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <wait>:
SYSCALL(wait)
 3aa:	b8 03 00 00 00       	mov    $0x3,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <pipe>:
SYSCALL(pipe)
 3b2:	b8 04 00 00 00       	mov    $0x4,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <read>:
SYSCALL(read)
 3ba:	b8 05 00 00 00       	mov    $0x5,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <write>:
SYSCALL(write)
 3c2:	b8 10 00 00 00       	mov    $0x10,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <close>:
SYSCALL(close)
 3ca:	b8 15 00 00 00       	mov    $0x15,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <kill>:
SYSCALL(kill)
 3d2:	b8 06 00 00 00       	mov    $0x6,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <exec>:
SYSCALL(exec)
 3da:	b8 07 00 00 00       	mov    $0x7,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <open>:
SYSCALL(open)
 3e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <mknod>:
SYSCALL(mknod)
 3ea:	b8 11 00 00 00       	mov    $0x11,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <unlink>:
SYSCALL(unlink)
 3f2:	b8 12 00 00 00       	mov    $0x12,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <fstat>:
SYSCALL(fstat)
 3fa:	b8 08 00 00 00       	mov    $0x8,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <link>:
SYSCALL(link)
 402:	b8 13 00 00 00       	mov    $0x13,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <mkdir>:
SYSCALL(mkdir)
 40a:	b8 14 00 00 00       	mov    $0x14,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <chdir>:
SYSCALL(chdir)
 412:	b8 09 00 00 00       	mov    $0x9,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <dup>:
SYSCALL(dup)
 41a:	b8 0a 00 00 00       	mov    $0xa,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <getpid>:
SYSCALL(getpid)
 422:	b8 0b 00 00 00       	mov    $0xb,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <sbrk>:
SYSCALL(sbrk)
 42a:	b8 0c 00 00 00       	mov    $0xc,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <sleep>:
SYSCALL(sleep)
 432:	b8 0d 00 00 00       	mov    $0xd,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <uptime>:
SYSCALL(uptime)
 43a:	b8 0e 00 00 00       	mov    $0xe,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 442:	b8 16 00 00 00       	mov    $0x16,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 44a:	b8 17 00 00 00       	mov    $0x17,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 452:	b8 18 00 00 00       	mov    $0x18,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <halt>:
SYSCALL(halt)
 45a:	b8 19 00 00 00       	mov    $0x19,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 462:	b8 1a 00 00 00       	mov    $0x1a,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <kthread_join>:
SYSCALL(kthread_join)
 46a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kthread_exit>:
SYSCALL(kthread_exit)
 472:	b8 1c 00 00 00       	mov    $0x1c,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    
 47a:	66 90                	xchg   %ax,%ax
 47c:	66 90                	xchg   %ax,%ax
 47e:	66 90                	xchg   %ax,%ax

00000480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	57                   	push   %edi
 484:	56                   	push   %esi
 485:	89 c6                	mov    %eax,%esi
 487:	53                   	push   %ebx
 488:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 48b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 48e:	85 db                	test   %ebx,%ebx
 490:	74 09                	je     49b <printint+0x1b>
 492:	89 d0                	mov    %edx,%eax
 494:	c1 e8 1f             	shr    $0x1f,%eax
 497:	84 c0                	test   %al,%al
 499:	75 75                	jne    510 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 49b:	89 d0                	mov    %edx,%eax
  neg = 0;
 49d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4a4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 4a7:	31 ff                	xor    %edi,%edi
 4a9:	89 ce                	mov    %ecx,%esi
 4ab:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4ae:	eb 02                	jmp    4b2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 4b0:	89 cf                	mov    %ecx,%edi
 4b2:	31 d2                	xor    %edx,%edx
 4b4:	f7 f6                	div    %esi
 4b6:	8d 4f 01             	lea    0x1(%edi),%ecx
 4b9:	0f b6 92 7b 0b 00 00 	movzbl 0xb7b(%edx),%edx
  }while((x /= base) != 0);
 4c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4c2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4c5:	75 e9                	jne    4b0 <printint+0x30>
  if(neg)
 4c7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 4ca:	89 c8                	mov    %ecx,%eax
 4cc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 4cf:	85 d2                	test   %edx,%edx
 4d1:	74 08                	je     4db <printint+0x5b>
    buf[i++] = '-';
 4d3:	8d 4f 02             	lea    0x2(%edi),%ecx
 4d6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 4db:	8d 79 ff             	lea    -0x1(%ecx),%edi
 4de:	66 90                	xchg   %ax,%ax
 4e0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 4e5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 4e8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ef:	00 
 4f0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4f4:	89 34 24             	mov    %esi,(%esp)
 4f7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4fa:	e8 c3 fe ff ff       	call   3c2 <write>
  while(--i >= 0)
 4ff:	83 ff ff             	cmp    $0xffffffff,%edi
 502:	75 dc                	jne    4e0 <printint+0x60>
    putc(fd, buf[i]);
}
 504:	83 c4 4c             	add    $0x4c,%esp
 507:	5b                   	pop    %ebx
 508:	5e                   	pop    %esi
 509:	5f                   	pop    %edi
 50a:	5d                   	pop    %ebp
 50b:	c3                   	ret    
 50c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 510:	89 d0                	mov    %edx,%eax
 512:	f7 d8                	neg    %eax
    neg = 1;
 514:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 51b:	eb 87                	jmp    4a4 <printint+0x24>
 51d:	8d 76 00             	lea    0x0(%esi),%esi

00000520 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 524:	31 ff                	xor    %edi,%edi
{
 526:	56                   	push   %esi
 527:	53                   	push   %ebx
 528:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 52b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 52e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 531:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 534:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 537:	0f b6 13             	movzbl (%ebx),%edx
 53a:	83 c3 01             	add    $0x1,%ebx
 53d:	84 d2                	test   %dl,%dl
 53f:	75 39                	jne    57a <printf+0x5a>
 541:	e9 ca 00 00 00       	jmp    610 <printf+0xf0>
 546:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 548:	83 fa 25             	cmp    $0x25,%edx
 54b:	0f 84 c7 00 00 00    	je     618 <printf+0xf8>
  write(fd, &c, 1);
 551:	8d 45 e0             	lea    -0x20(%ebp),%eax
 554:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55b:	00 
 55c:	89 44 24 04          	mov    %eax,0x4(%esp)
 560:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 563:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 566:	e8 57 fe ff ff       	call   3c2 <write>
 56b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 56e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 572:	84 d2                	test   %dl,%dl
 574:	0f 84 96 00 00 00    	je     610 <printf+0xf0>
    if(state == 0){
 57a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 57c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 57f:	74 c7                	je     548 <printf+0x28>
      }
    } else if(state == '%'){
 581:	83 ff 25             	cmp    $0x25,%edi
 584:	75 e5                	jne    56b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 586:	83 fa 75             	cmp    $0x75,%edx
 589:	0f 84 99 00 00 00    	je     628 <printf+0x108>
 58f:	83 fa 64             	cmp    $0x64,%edx
 592:	0f 84 90 00 00 00    	je     628 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 598:	25 f7 00 00 00       	and    $0xf7,%eax
 59d:	83 f8 70             	cmp    $0x70,%eax
 5a0:	0f 84 aa 00 00 00    	je     650 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5a6:	83 fa 73             	cmp    $0x73,%edx
 5a9:	0f 84 e9 00 00 00    	je     698 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5af:	83 fa 63             	cmp    $0x63,%edx
 5b2:	0f 84 2b 01 00 00    	je     6e3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5b8:	83 fa 25             	cmp    $0x25,%edx
 5bb:	0f 84 4f 01 00 00    	je     710 <printf+0x1f0>
  write(fd, &c, 1);
 5c1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5c4:	83 c3 01             	add    $0x1,%ebx
 5c7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ce:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5cf:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5d1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d5:	89 34 24             	mov    %esi,(%esp)
 5d8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5db:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 5df:	e8 de fd ff ff       	call   3c2 <write>
        putc(fd, c);
 5e4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 5e7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5f1:	00 
 5f2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 5f9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5fc:	e8 c1 fd ff ff       	call   3c2 <write>
  for(i = 0; fmt[i]; i++){
 601:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 605:	84 d2                	test   %dl,%dl
 607:	0f 85 6d ff ff ff    	jne    57a <printf+0x5a>
 60d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 610:	83 c4 3c             	add    $0x3c,%esp
 613:	5b                   	pop    %ebx
 614:	5e                   	pop    %esi
 615:	5f                   	pop    %edi
 616:	5d                   	pop    %ebp
 617:	c3                   	ret    
        state = '%';
 618:	bf 25 00 00 00       	mov    $0x25,%edi
 61d:	e9 49 ff ff ff       	jmp    56b <printf+0x4b>
 622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 628:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 62f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 634:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 637:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 639:	8b 10                	mov    (%eax),%edx
 63b:	89 f0                	mov    %esi,%eax
 63d:	e8 3e fe ff ff       	call   480 <printint>
        ap++;
 642:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 646:	e9 20 ff ff ff       	jmp    56b <printf+0x4b>
 64b:	90                   	nop
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 650:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 653:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 65a:	00 
 65b:	89 44 24 04          	mov    %eax,0x4(%esp)
 65f:	89 34 24             	mov    %esi,(%esp)
 662:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 666:	e8 57 fd ff ff       	call   3c2 <write>
 66b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 66e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 675:	00 
 676:	89 44 24 04          	mov    %eax,0x4(%esp)
 67a:	89 34 24             	mov    %esi,(%esp)
 67d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 681:	e8 3c fd ff ff       	call   3c2 <write>
        printint(fd, *ap, 16, 0);
 686:	b9 10 00 00 00       	mov    $0x10,%ecx
 68b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 692:	eb a0                	jmp    634 <printf+0x114>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 698:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 69b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 69f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 6a1:	b8 74 0b 00 00       	mov    $0xb74,%eax
 6a6:	85 ff                	test   %edi,%edi
 6a8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 6ab:	0f b6 07             	movzbl (%edi),%eax
 6ae:	84 c0                	test   %al,%al
 6b0:	74 2a                	je     6dc <printf+0x1bc>
 6b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6b8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6bb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 6be:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6c1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6c8:	00 
 6c9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6cd:	89 34 24             	mov    %esi,(%esp)
 6d0:	e8 ed fc ff ff       	call   3c2 <write>
        while(*s != 0){
 6d5:	0f b6 07             	movzbl (%edi),%eax
 6d8:	84 c0                	test   %al,%al
 6da:	75 dc                	jne    6b8 <printf+0x198>
      state = 0;
 6dc:	31 ff                	xor    %edi,%edi
 6de:	e9 88 fe ff ff       	jmp    56b <printf+0x4b>
        putc(fd, *ap);
 6e3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6e6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 6e8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 6ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6f1:	00 
 6f2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6f5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6f8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ff:	e8 be fc ff ff       	call   3c2 <write>
        ap++;
 704:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 708:	e9 5e fe ff ff       	jmp    56b <printf+0x4b>
 70d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 710:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 713:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 715:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 71c:	00 
 71d:	89 44 24 04          	mov    %eax,0x4(%esp)
 721:	89 34 24             	mov    %esi,(%esp)
 724:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 728:	e8 95 fc ff ff       	call   3c2 <write>
 72d:	e9 39 fe ff ff       	jmp    56b <printf+0x4b>
 732:	66 90                	xchg   %ax,%ax
 734:	66 90                	xchg   %ax,%ax
 736:	66 90                	xchg   %ax,%ax
 738:	66 90                	xchg   %ax,%ax
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 ac 0e 00 00       	mov    0xeac,%eax
{
 746:	89 e5                	mov    %esp,%ebp
 748:	57                   	push   %edi
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 750:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 753:	39 d0                	cmp    %edx,%eax
 755:	72 11                	jb     768 <free+0x28>
 757:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 758:	39 c8                	cmp    %ecx,%eax
 75a:	72 04                	jb     760 <free+0x20>
 75c:	39 ca                	cmp    %ecx,%edx
 75e:	72 10                	jb     770 <free+0x30>
 760:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 762:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 766:	73 f0                	jae    758 <free+0x18>
 768:	39 ca                	cmp    %ecx,%edx
 76a:	72 04                	jb     770 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	39 c8                	cmp    %ecx,%eax
 76e:	72 f0                	jb     760 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 770:	8b 73 fc             	mov    -0x4(%ebx),%esi
 773:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 776:	39 cf                	cmp    %ecx,%edi
 778:	74 1e                	je     798 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 77a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 77d:	8b 48 04             	mov    0x4(%eax),%ecx
 780:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 783:	39 f2                	cmp    %esi,%edx
 785:	74 28                	je     7af <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 787:	89 10                	mov    %edx,(%eax)
  freep = p;
 789:	a3 ac 0e 00 00       	mov    %eax,0xeac
}
 78e:	5b                   	pop    %ebx
 78f:	5e                   	pop    %esi
 790:	5f                   	pop    %edi
 791:	5d                   	pop    %ebp
 792:	c3                   	ret    
 793:	90                   	nop
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 798:	03 71 04             	add    0x4(%ecx),%esi
 79b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 79e:	8b 08                	mov    (%eax),%ecx
 7a0:	8b 09                	mov    (%ecx),%ecx
 7a2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7a5:	8b 48 04             	mov    0x4(%eax),%ecx
 7a8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7ab:	39 f2                	cmp    %esi,%edx
 7ad:	75 d8                	jne    787 <free+0x47>
    p->s.size += bp->s.size;
 7af:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 7b2:	a3 ac 0e 00 00       	mov    %eax,0xeac
    p->s.size += bp->s.size;
 7b7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7ba:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7bd:	89 10                	mov    %edx,(%eax)
}
 7bf:	5b                   	pop    %ebx
 7c0:	5e                   	pop    %esi
 7c1:	5f                   	pop    %edi
 7c2:	5d                   	pop    %ebp
 7c3:	c3                   	ret    
 7c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	57                   	push   %edi
 7d4:	56                   	push   %esi
 7d5:	53                   	push   %ebx
 7d6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7dc:	8b 1d ac 0e 00 00    	mov    0xeac,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	8d 48 07             	lea    0x7(%eax),%ecx
 7e5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 7e8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ea:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 7ed:	0f 84 9b 00 00 00    	je     88e <malloc+0xbe>
 7f3:	8b 13                	mov    (%ebx),%edx
 7f5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7f8:	39 fe                	cmp    %edi,%esi
 7fa:	76 64                	jbe    860 <malloc+0x90>
 7fc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 803:	bb 00 80 00 00       	mov    $0x8000,%ebx
 808:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 80b:	eb 0e                	jmp    81b <malloc+0x4b>
 80d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 810:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 812:	8b 78 04             	mov    0x4(%eax),%edi
 815:	39 fe                	cmp    %edi,%esi
 817:	76 4f                	jbe    868 <malloc+0x98>
 819:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 81b:	3b 15 ac 0e 00 00    	cmp    0xeac,%edx
 821:	75 ed                	jne    810 <malloc+0x40>
  if(nu < 4096)
 823:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 826:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 82c:	bf 00 10 00 00       	mov    $0x1000,%edi
 831:	0f 43 fe             	cmovae %esi,%edi
 834:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 837:	89 04 24             	mov    %eax,(%esp)
 83a:	e8 eb fb ff ff       	call   42a <sbrk>
  if(p == (char*)-1)
 83f:	83 f8 ff             	cmp    $0xffffffff,%eax
 842:	74 18                	je     85c <malloc+0x8c>
  hp->s.size = nu;
 844:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 847:	83 c0 08             	add    $0x8,%eax
 84a:	89 04 24             	mov    %eax,(%esp)
 84d:	e8 ee fe ff ff       	call   740 <free>
  return freep;
 852:	8b 15 ac 0e 00 00    	mov    0xeac,%edx
      if((p = morecore(nunits)) == 0)
 858:	85 d2                	test   %edx,%edx
 85a:	75 b4                	jne    810 <malloc+0x40>
        return 0;
 85c:	31 c0                	xor    %eax,%eax
 85e:	eb 20                	jmp    880 <malloc+0xb0>
    if(p->s.size >= nunits){
 860:	89 d0                	mov    %edx,%eax
 862:	89 da                	mov    %ebx,%edx
 864:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 868:	39 fe                	cmp    %edi,%esi
 86a:	74 1c                	je     888 <malloc+0xb8>
        p->s.size -= nunits;
 86c:	29 f7                	sub    %esi,%edi
 86e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 871:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 874:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 877:	89 15 ac 0e 00 00    	mov    %edx,0xeac
      return (void*)(p + 1);
 87d:	83 c0 08             	add    $0x8,%eax
  }
}
 880:	83 c4 1c             	add    $0x1c,%esp
 883:	5b                   	pop    %ebx
 884:	5e                   	pop    %esi
 885:	5f                   	pop    %edi
 886:	5d                   	pop    %ebp
 887:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 888:	8b 08                	mov    (%eax),%ecx
 88a:	89 0a                	mov    %ecx,(%edx)
 88c:	eb e9                	jmp    877 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 88e:	c7 05 ac 0e 00 00 b0 	movl   $0xeb0,0xeac
 895:	0e 00 00 
    base.s.size = 0;
 898:	ba b0 0e 00 00       	mov    $0xeb0,%edx
    base.s.ptr = freep = prevp = &base;
 89d:	c7 05 b0 0e 00 00 b0 	movl   $0xeb0,0xeb0
 8a4:	0e 00 00 
    base.s.size = 0;
 8a7:	c7 05 b4 0e 00 00 00 	movl   $0x0,0xeb4
 8ae:	00 00 00 
 8b1:	e9 46 ff ff ff       	jmp    7fc <malloc+0x2c>
 8b6:	66 90                	xchg   %ax,%ax
 8b8:	66 90                	xchg   %ax,%ax
 8ba:	66 90                	xchg   %ax,%ax
 8bc:	66 90                	xchg   %ax,%ax
 8be:	66 90                	xchg   %ax,%ax

000008c0 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 8c0:	55                   	push   %ebp
 8c1:	89 e5                	mov    %esp,%ebp
 8c3:	53                   	push   %ebx
 8c4:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 8c7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 8ce:	e8 fd fe ff ff       	call   7d0 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 8d3:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 8da:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 8dc:	e8 ef fe ff ff       	call   7d0 <malloc>
    if (tstack == NULL) {
 8e1:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 8e3:	89 c2                	mov    %eax,%edx
 8e5:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 8e8:	0f 84 8a 00 00 00    	je     978 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 8ee:	25 ff 0f 00 00       	and    $0xfff,%eax
 8f3:	75 73                	jne    968 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 8f5:	8b 45 10             	mov    0x10(%ebp),%eax
 8f8:	89 54 24 08          	mov    %edx,0x8(%esp)
 8fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 900:	8b 45 0c             	mov    0xc(%ebp),%eax
 903:	89 04 24             	mov    %eax,(%esp)
 906:	e8 57 fb ff ff       	call   462 <kthread_create>
 90b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 90d:	89 44 24 10          	mov    %eax,0x10(%esp)
 911:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 918:	00 
 919:	c7 44 24 08 8c 0b 00 	movl   $0xb8c,0x8(%esp)
 920:	00 
 921:	c7 44 24 04 9b 0b 00 	movl   $0xb9b,0x4(%esp)
 928:	00 
 929:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 930:	e8 eb fb ff ff       	call   520 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 935:	8b 03                	mov    (%ebx),%eax
 937:	c7 44 24 04 b2 0b 00 	movl   $0xbb2,0x4(%esp)
 93e:	00 
 93f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 946:	89 44 24 08          	mov    %eax,0x8(%esp)
 94a:	e8 d1 fb ff ff       	call   520 <printf>
    
    if (bt->tid != 0) {
 94f:	8b 03                	mov    (%ebx),%eax
 951:	85 c0                	test   %eax,%eax
 953:	74 23                	je     978 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 955:	8b 45 08             	mov    0x8(%ebp),%eax
 958:	89 18                	mov    %ebx,(%eax)
        return 0;
 95a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 95c:	83 c4 24             	add    $0x24,%esp
 95f:	5b                   	pop    %ebx
 960:	5d                   	pop    %ebp
 961:	c3                   	ret    
 962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 968:	29 c2                	sub    %eax,%edx
 96a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 970:	eb 83                	jmp    8f5 <benny_thread_create+0x35>
 972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 97d:	eb dd                	jmp    95c <benny_thread_create+0x9c>
 97f:	90                   	nop

00000980 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 983:	8b 45 08             	mov    0x8(%ebp),%eax
}
 986:	5d                   	pop    %ebp
    return bt->tid;
 987:	8b 00                	mov    (%eax),%eax
}
 989:	c3                   	ret    
 98a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000990 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 990:	55                   	push   %ebp
 991:	89 e5                	mov    %esp,%ebp
 993:	53                   	push   %ebx
 994:	83 ec 14             	sub    $0x14,%esp
 997:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 99a:	8b 03                	mov    (%ebx),%eax
 99c:	89 04 24             	mov    %eax,(%esp)
 99f:	e8 c6 fa ff ff       	call   46a <kthread_join>
    if (retVal == 0) {
 9a4:	85 c0                	test   %eax,%eax
 9a6:	75 11                	jne    9b9 <benny_thread_join+0x29>
        free(bt->tstack);
 9a8:	8b 53 04             	mov    0x4(%ebx),%edx
 9ab:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9ae:	89 14 24             	mov    %edx,(%esp)
 9b1:	e8 8a fd ff ff       	call   740 <free>
 9b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 9b9:	83 c4 14             	add    $0x14,%esp
 9bc:	5b                   	pop    %ebx
 9bd:	5d                   	pop    %ebp
 9be:	c3                   	ret    
 9bf:	90                   	nop

000009c0 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 9c0:	55                   	push   %ebp
 9c1:	89 e5                	mov    %esp,%ebp
 9c3:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 9c6:	8b 45 08             	mov    0x8(%ebp),%eax
 9c9:	89 04 24             	mov    %eax,(%esp)
 9cc:	e8 a1 fa ff ff       	call   472 <kthread_exit>
    return 0;
}
 9d1:	31 c0                	xor    %eax,%eax
 9d3:	c9                   	leave  
 9d4:	c3                   	ret    
