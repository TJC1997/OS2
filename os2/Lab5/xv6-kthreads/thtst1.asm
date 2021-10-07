
_thtst1:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#endif // KTHREADS


int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 20             	sub    $0x20,%esp
#ifdef KTHREADS
    benny_thread_t bt = NULL;
    int rez = -1;
    int i = IVAL;
    
    printf(1, "global before: %d\n", global);
   a:	a1 90 0e 00 00       	mov    0xe90,%eax
   f:	c7 44 24 04 98 0a 00 	movl   $0xa98,0x4(%esp)
  16:	00 
  17:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    benny_thread_t bt = NULL;
  1e:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  25:	00 
    printf(1, "global before: %d\n", global);
  26:	89 44 24 08          	mov    %eax,0x8(%esp)
    int i = IVAL;
  2a:	c7 44 24 1c 0f 0f 0f 	movl   $0xf0f0f0f,0x1c(%esp)
  31:	0f 
    printf(1, "global before: %d\n", global);
  32:	e8 99 05 00 00       	call   5d0 <printf>
    printf(1, "i before     : %x\n", i);
  37:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  3b:	c7 44 24 04 ab 0a 00 	movl   $0xaab,0x4(%esp)
  42:	00 
  43:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  4a:	89 44 24 08          	mov    %eax,0x8(%esp)
  4e:	e8 7d 05 00 00       	call   5d0 <printf>
    // create the new thread.
    rez = benny_thread_create(&bt, func1, &i);
  53:	8d 44 24 1c          	lea    0x1c(%esp),%eax
  57:	89 44 24 08          	mov    %eax,0x8(%esp)
  5b:	8d 44 24 18          	lea    0x18(%esp),%eax
  5f:	c7 44 24 04 50 01 00 	movl   $0x150,0x4(%esp)
  66:	00 
  67:	89 04 24             	mov    %eax,(%esp)
  6a:	e8 01 09 00 00       	call   970 <benny_thread_create>

    sleep(2);
  6f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    rez = benny_thread_create(&bt, func1, &i);
  76:	89 c3                	mov    %eax,%ebx
    sleep(2);
  78:	e8 65 04 00 00       	call   4e2 <sleep>

    printf(1, "rez          : %x\n", rez);
  7d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  81:	c7 44 24 04 be 0a 00 	movl   $0xabe,0x4(%esp)
  88:	00 
  89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  90:	e8 3b 05 00 00       	call   5d0 <printf>

    // join back with the thread. this is a blocking call.
    rez = benny_thread_join(bt);
  95:	8b 44 24 18          	mov    0x18(%esp),%eax
  99:	89 04 24             	mov    %eax,(%esp)
  9c:	e8 9f 09 00 00       	call   a40 <benny_thread_join>

    // once the thread has koined back with the main thread, the values
    // should reflect the changes made within the thread.
    printf(1, "global after : %d\n", global);
  a1:	c7 44 24 04 d1 0a 00 	movl   $0xad1,0x4(%esp)
  a8:	00 
  a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    rez = benny_thread_join(bt);
  b0:	89 c3                	mov    %eax,%ebx
    printf(1, "global after : %d\n", global);
  b2:	a1 90 0e 00 00       	mov    0xe90,%eax
  b7:	89 44 24 08          	mov    %eax,0x8(%esp)
  bb:	e8 10 05 00 00       	call   5d0 <printf>
    printf(1, "i after      : %x\n", i);
  c0:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  c4:	c7 44 24 04 e4 0a 00 	movl   $0xae4,0x4(%esp)
  cb:	00 
  cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d3:	89 44 24 08          	mov    %eax,0x8(%esp)
  d7:	e8 f4 04 00 00       	call   5d0 <printf>
    printf(1, "rez          : %d\n", rez);
  dc:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  e0:	c7 44 24 04 f7 0a 00 	movl   $0xaf7,0x4(%esp)
  e7:	00 
  e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  ef:	e8 dc 04 00 00       	call   5d0 <printf>
    assert(global == 100);
  f4:	83 3d 90 0e 00 00 64 	cmpl   $0x64,0xe90
  fb:	74 29                	je     126 <main+0x126>
  fd:	c7 44 24 0c 3e 00 00 	movl   $0x3e,0xc(%esp)
 104:	00 
    assert(rez == 0);
 105:	c7 44 24 08 88 0a 00 	movl   $0xa88,0x8(%esp)
 10c:	00 
 10d:	c7 44 24 04 0c 0b 00 	movl   $0xb0c,0x4(%esp)
 114:	00 
 115:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 11c:	e8 af 04 00 00       	call   5d0 <printf>
 121:	e8 2c 03 00 00       	call   452 <exit>
 126:	85 db                	test   %ebx,%ebx
 128:	75 14                	jne    13e <main+0x13e>
    assert(i == FVAL);
 12a:	81 7c 24 1c ae ae ae 	cmpl   $0xaeaeaeae,0x1c(%esp)
 131:	ae 
 132:	74 ed                	je     121 <main+0x121>
 134:	c7 44 24 0c 40 00 00 	movl   $0x40,0xc(%esp)
 13b:	00 
 13c:	eb c7                	jmp    105 <main+0x105>
    assert(rez == 0);
 13e:	c7 44 24 0c 3f 00 00 	movl   $0x3f,0xc(%esp)
 145:	00 
 146:	eb bd                	jmp    105 <main+0x105>
 148:	66 90                	xchg   %ax,%ax
 14a:	66 90                	xchg   %ax,%ax
 14c:	66 90                	xchg   %ax,%ax
 14e:	66 90                	xchg   %ax,%ax

00000150 <func1>:
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	83 ec 14             	sub    $0x14,%esp
 157:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1, "%s %d\n", __FILE__, __LINE__);
 15a:	c7 44 24 0c 13 00 00 	movl   $0x13,0xc(%esp)
 161:	00 
 162:	c7 44 24 08 88 0a 00 	movl   $0xa88,0x8(%esp)
 169:	00 
 16a:	c7 44 24 04 91 0a 00 	movl   $0xa91,0x4(%esp)
 171:	00 
 172:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 179:	e8 52 04 00 00       	call   5d0 <printf>
    assert(global == 10);
 17e:	83 3d 90 0e 00 00 0a 	cmpl   $0xa,0xe90
 185:	75 75                	jne    1fc <func1+0xac>
    assert(*i == IVAL);
 187:	81 3b 0f 0f 0f 0f    	cmpl   $0xf0f0f0f,(%ebx)
 18d:	0f 85 92 00 00 00    	jne    225 <func1+0xd5>
    printf(1, "%s %d\n", __FILE__, __LINE__);
 193:	c7 44 24 0c 17 00 00 	movl   $0x17,0xc(%esp)
 19a:	00 
 19b:	c7 44 24 08 88 0a 00 	movl   $0xa88,0x8(%esp)
 1a2:	00 
 1a3:	c7 44 24 04 91 0a 00 	movl   $0xa91,0x4(%esp)
 1aa:	00 
 1ab:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1b2:	e8 19 04 00 00       	call   5d0 <printf>
    *i = FVAL;
 1b7:	c7 03 ae ae ae ae    	movl   $0xaeaeaeae,(%ebx)
    printf(1, "%s %d\n", __FILE__, __LINE__);
 1bd:	c7 44 24 0c 1f 00 00 	movl   $0x1f,0xc(%esp)
 1c4:	00 
 1c5:	c7 44 24 08 88 0a 00 	movl   $0xa88,0x8(%esp)
 1cc:	00 
 1cd:	c7 44 24 04 91 0a 00 	movl   $0xa91,0x4(%esp)
 1d4:	00 
 1d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    global = 100;
 1dc:	c7 05 90 0e 00 00 64 	movl   $0x64,0xe90
 1e3:	00 00 00 
    printf(1, "%s %d\n", __FILE__, __LINE__);
 1e6:	e8 e5 03 00 00       	call   5d0 <printf>
    benny_thread_exit(3);
 1eb:	c7 45 08 03 00 00 00 	movl   $0x3,0x8(%ebp)
}
 1f2:	83 c4 14             	add    $0x14,%esp
 1f5:	5b                   	pop    %ebx
 1f6:	5d                   	pop    %ebp
    benny_thread_exit(3);
 1f7:	e9 74 08 00 00       	jmp    a70 <benny_thread_exit>
    assert(global == 10);
 1fc:	c7 44 24 0c 14 00 00 	movl   $0x14,0xc(%esp)
 203:	00 
    assert(*i == IVAL);
 204:	c7 44 24 08 88 0a 00 	movl   $0xa88,0x8(%esp)
 20b:	00 
 20c:	c7 44 24 04 0c 0b 00 	movl   $0xb0c,0x4(%esp)
 213:	00 
 214:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 21b:	e8 b0 03 00 00       	call   5d0 <printf>
 220:	e8 2d 02 00 00       	call   452 <exit>
 225:	c7 44 24 0c 15 00 00 	movl   $0x15,0xc(%esp)
 22c:	00 
 22d:	eb d5                	jmp    204 <func1+0xb4>
 22f:	90                   	nop

00000230 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	8b 45 08             	mov    0x8(%ebp),%eax
 236:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 239:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 23a:	89 c2                	mov    %eax,%edx
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 240:	83 c1 01             	add    $0x1,%ecx
 243:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 247:	83 c2 01             	add    $0x1,%edx
 24a:	84 db                	test   %bl,%bl
 24c:	88 5a ff             	mov    %bl,-0x1(%edx)
 24f:	75 ef                	jne    240 <strcpy+0x10>
    ;
  return os;
}
 251:	5b                   	pop    %ebx
 252:	5d                   	pop    %ebp
 253:	c3                   	ret    
 254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 25a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000260 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 55 08             	mov    0x8(%ebp),%edx
 266:	53                   	push   %ebx
 267:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 26a:	0f b6 02             	movzbl (%edx),%eax
 26d:	84 c0                	test   %al,%al
 26f:	74 2d                	je     29e <strcmp+0x3e>
 271:	0f b6 19             	movzbl (%ecx),%ebx
 274:	38 d8                	cmp    %bl,%al
 276:	74 0e                	je     286 <strcmp+0x26>
 278:	eb 2b                	jmp    2a5 <strcmp+0x45>
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 280:	38 c8                	cmp    %cl,%al
 282:	75 15                	jne    299 <strcmp+0x39>
    p++, q++;
 284:	89 d9                	mov    %ebx,%ecx
 286:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 289:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 28c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 28f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 293:	84 c0                	test   %al,%al
 295:	75 e9                	jne    280 <strcmp+0x20>
 297:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 299:	29 c8                	sub    %ecx,%eax
}
 29b:	5b                   	pop    %ebx
 29c:	5d                   	pop    %ebp
 29d:	c3                   	ret    
 29e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 2a1:	31 c0                	xor    %eax,%eax
 2a3:	eb f4                	jmp    299 <strcmp+0x39>
 2a5:	0f b6 cb             	movzbl %bl,%ecx
 2a8:	eb ef                	jmp    299 <strcmp+0x39>
 2aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002b0 <strlen>:

uint
strlen(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2b6:	80 39 00             	cmpb   $0x0,(%ecx)
 2b9:	74 12                	je     2cd <strlen+0x1d>
 2bb:	31 d2                	xor    %edx,%edx
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2c7:	89 d0                	mov    %edx,%eax
 2c9:	75 f5                	jne    2c0 <strlen+0x10>
    ;
  return n;
}
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 2cd:	31 c0                	xor    %eax,%eax
}
 2cf:	5d                   	pop    %ebp
 2d0:	c3                   	ret    
 2d1:	eb 0d                	jmp    2e0 <memset>
 2d3:	90                   	nop
 2d4:	90                   	nop
 2d5:	90                   	nop
 2d6:	90                   	nop
 2d7:	90                   	nop
 2d8:	90                   	nop
 2d9:	90                   	nop
 2da:	90                   	nop
 2db:	90                   	nop
 2dc:	90                   	nop
 2dd:	90                   	nop
 2de:	90                   	nop
 2df:	90                   	nop

000002e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 55 08             	mov    0x8(%ebp),%edx
 2e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ed:	89 d7                	mov    %edx,%edi
 2ef:	fc                   	cld    
 2f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2f2:	89 d0                	mov    %edx,%eax
 2f4:	5f                   	pop    %edi
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	53                   	push   %ebx
 307:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 30a:	0f b6 18             	movzbl (%eax),%ebx
 30d:	84 db                	test   %bl,%bl
 30f:	74 1d                	je     32e <strchr+0x2e>
    if(*s == c)
 311:	38 d3                	cmp    %dl,%bl
 313:	89 d1                	mov    %edx,%ecx
 315:	75 0d                	jne    324 <strchr+0x24>
 317:	eb 17                	jmp    330 <strchr+0x30>
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 320:	38 ca                	cmp    %cl,%dl
 322:	74 0c                	je     330 <strchr+0x30>
  for(; *s; s++)
 324:	83 c0 01             	add    $0x1,%eax
 327:	0f b6 10             	movzbl (%eax),%edx
 32a:	84 d2                	test   %dl,%dl
 32c:	75 f2                	jne    320 <strchr+0x20>
      return (char*)s;
  return 0;
 32e:	31 c0                	xor    %eax,%eax
}
 330:	5b                   	pop    %ebx
 331:	5d                   	pop    %ebp
 332:	c3                   	ret    
 333:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <gets>:

char*
gets(char *buf, int max)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 345:	31 f6                	xor    %esi,%esi
{
 347:	53                   	push   %ebx
 348:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 34b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 34e:	eb 31                	jmp    381 <gets+0x41>
    cc = read(0, &c, 1);
 350:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 357:	00 
 358:	89 7c 24 04          	mov    %edi,0x4(%esp)
 35c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 363:	e8 02 01 00 00       	call   46a <read>
    if(cc < 1)
 368:	85 c0                	test   %eax,%eax
 36a:	7e 1d                	jle    389 <gets+0x49>
      break;
    buf[i++] = c;
 36c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 370:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 372:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 375:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 377:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 37b:	74 0c                	je     389 <gets+0x49>
 37d:	3c 0a                	cmp    $0xa,%al
 37f:	74 08                	je     389 <gets+0x49>
  for(i=0; i+1 < max; ){
 381:	8d 5e 01             	lea    0x1(%esi),%ebx
 384:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 387:	7c c7                	jl     350 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 389:	8b 45 08             	mov    0x8(%ebp),%eax
 38c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 390:	83 c4 2c             	add    $0x2c,%esp
 393:	5b                   	pop    %ebx
 394:	5e                   	pop    %esi
 395:	5f                   	pop    %edi
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
 3a5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3b2:	00 
 3b3:	89 04 24             	mov    %eax,(%esp)
 3b6:	e8 d7 00 00 00       	call   492 <open>
  if(fd < 0)
 3bb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 3bd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3bf:	78 27                	js     3e8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 3c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c4:	89 1c 24             	mov    %ebx,(%esp)
 3c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3cb:	e8 da 00 00 00       	call   4aa <fstat>
  close(fd);
 3d0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3d3:	89 c6                	mov    %eax,%esi
  close(fd);
 3d5:	e8 a0 00 00 00       	call   47a <close>
  return r;
 3da:	89 f0                	mov    %esi,%eax
}
 3dc:	83 c4 10             	add    $0x10,%esp
 3df:	5b                   	pop    %ebx
 3e0:	5e                   	pop    %esi
 3e1:	5d                   	pop    %ebp
 3e2:	c3                   	ret    
 3e3:	90                   	nop
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 3e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3ed:	eb ed                	jmp    3dc <stat+0x3c>
 3ef:	90                   	nop

000003f0 <atoi>:

int
atoi(const char *s)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3f6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f7:	0f be 11             	movsbl (%ecx),%edx
 3fa:	8d 42 d0             	lea    -0x30(%edx),%eax
 3fd:	3c 09                	cmp    $0x9,%al
  n = 0;
 3ff:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 404:	77 17                	ja     41d <atoi+0x2d>
 406:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 408:	83 c1 01             	add    $0x1,%ecx
 40b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 40e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 412:	0f be 11             	movsbl (%ecx),%edx
 415:	8d 5a d0             	lea    -0x30(%edx),%ebx
 418:	80 fb 09             	cmp    $0x9,%bl
 41b:	76 eb                	jbe    408 <atoi+0x18>
  return n;
}
 41d:	5b                   	pop    %ebx
 41e:	5d                   	pop    %ebp
 41f:	c3                   	ret    

00000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 421:	31 d2                	xor    %edx,%edx
{
 423:	89 e5                	mov    %esp,%ebp
 425:	56                   	push   %esi
 426:	8b 45 08             	mov    0x8(%ebp),%eax
 429:	53                   	push   %ebx
 42a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 42d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 430:	85 db                	test   %ebx,%ebx
 432:	7e 12                	jle    446 <memmove+0x26>
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 438:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 43c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 43f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 442:	39 da                	cmp    %ebx,%edx
 444:	75 f2                	jne    438 <memmove+0x18>
  return vdst;
}
 446:	5b                   	pop    %ebx
 447:	5e                   	pop    %esi
 448:	5d                   	pop    %ebp
 449:	c3                   	ret    

0000044a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 44a:	b8 01 00 00 00       	mov    $0x1,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <exit>:
SYSCALL(exit)
 452:	b8 02 00 00 00       	mov    $0x2,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <wait>:
SYSCALL(wait)
 45a:	b8 03 00 00 00       	mov    $0x3,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <pipe>:
SYSCALL(pipe)
 462:	b8 04 00 00 00       	mov    $0x4,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <read>:
SYSCALL(read)
 46a:	b8 05 00 00 00       	mov    $0x5,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <write>:
SYSCALL(write)
 472:	b8 10 00 00 00       	mov    $0x10,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <close>:
SYSCALL(close)
 47a:	b8 15 00 00 00       	mov    $0x15,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <kill>:
SYSCALL(kill)
 482:	b8 06 00 00 00       	mov    $0x6,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <exec>:
SYSCALL(exec)
 48a:	b8 07 00 00 00       	mov    $0x7,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <open>:
SYSCALL(open)
 492:	b8 0f 00 00 00       	mov    $0xf,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <mknod>:
SYSCALL(mknod)
 49a:	b8 11 00 00 00       	mov    $0x11,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <unlink>:
SYSCALL(unlink)
 4a2:	b8 12 00 00 00       	mov    $0x12,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <fstat>:
SYSCALL(fstat)
 4aa:	b8 08 00 00 00       	mov    $0x8,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <link>:
SYSCALL(link)
 4b2:	b8 13 00 00 00       	mov    $0x13,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <mkdir>:
SYSCALL(mkdir)
 4ba:	b8 14 00 00 00       	mov    $0x14,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <chdir>:
SYSCALL(chdir)
 4c2:	b8 09 00 00 00       	mov    $0x9,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <dup>:
SYSCALL(dup)
 4ca:	b8 0a 00 00 00       	mov    $0xa,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <getpid>:
SYSCALL(getpid)
 4d2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <sbrk>:
SYSCALL(sbrk)
 4da:	b8 0c 00 00 00       	mov    $0xc,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <sleep>:
SYSCALL(sleep)
 4e2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <uptime>:
SYSCALL(uptime)
 4ea:	b8 0e 00 00 00       	mov    $0xe,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 4f2:	b8 16 00 00 00       	mov    $0x16,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 4fa:	b8 17 00 00 00       	mov    $0x17,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 502:	b8 18 00 00 00       	mov    $0x18,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <halt>:
SYSCALL(halt)
 50a:	b8 19 00 00 00       	mov    $0x19,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 512:	b8 1a 00 00 00       	mov    $0x1a,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <kthread_join>:
SYSCALL(kthread_join)
 51a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <kthread_exit>:
SYSCALL(kthread_exit)
 522:	b8 1c 00 00 00       	mov    $0x1c,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    
 52a:	66 90                	xchg   %ax,%ax
 52c:	66 90                	xchg   %ax,%ax
 52e:	66 90                	xchg   %ax,%ax

00000530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	89 c6                	mov    %eax,%esi
 537:	53                   	push   %ebx
 538:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 53b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 53e:	85 db                	test   %ebx,%ebx
 540:	74 09                	je     54b <printint+0x1b>
 542:	89 d0                	mov    %edx,%eax
 544:	c1 e8 1f             	shr    $0x1f,%eax
 547:	84 c0                	test   %al,%al
 549:	75 75                	jne    5c0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 54b:	89 d0                	mov    %edx,%eax
  neg = 0;
 54d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 554:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 557:	31 ff                	xor    %edi,%edi
 559:	89 ce                	mov    %ecx,%esi
 55b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 55e:	eb 02                	jmp    562 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 560:	89 cf                	mov    %ecx,%edi
 562:	31 d2                	xor    %edx,%edx
 564:	f7 f6                	div    %esi
 566:	8d 4f 01             	lea    0x1(%edi),%ecx
 569:	0f b6 92 37 0b 00 00 	movzbl 0xb37(%edx),%edx
  }while((x /= base) != 0);
 570:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 572:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 575:	75 e9                	jne    560 <printint+0x30>
  if(neg)
 577:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 57a:	89 c8                	mov    %ecx,%eax
 57c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 57f:	85 d2                	test   %edx,%edx
 581:	74 08                	je     58b <printint+0x5b>
    buf[i++] = '-';
 583:	8d 4f 02             	lea    0x2(%edi),%ecx
 586:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 58b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 58e:	66 90                	xchg   %ax,%ax
 590:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 595:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 598:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 59f:	00 
 5a0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 5a4:	89 34 24             	mov    %esi,(%esp)
 5a7:	88 45 d7             	mov    %al,-0x29(%ebp)
 5aa:	e8 c3 fe ff ff       	call   472 <write>
  while(--i >= 0)
 5af:	83 ff ff             	cmp    $0xffffffff,%edi
 5b2:	75 dc                	jne    590 <printint+0x60>
    putc(fd, buf[i]);
}
 5b4:	83 c4 4c             	add    $0x4c,%esp
 5b7:	5b                   	pop    %ebx
 5b8:	5e                   	pop    %esi
 5b9:	5f                   	pop    %edi
 5ba:	5d                   	pop    %ebp
 5bb:	c3                   	ret    
 5bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 5c0:	89 d0                	mov    %edx,%eax
 5c2:	f7 d8                	neg    %eax
    neg = 1;
 5c4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 5cb:	eb 87                	jmp    554 <printint+0x24>
 5cd:	8d 76 00             	lea    0x0(%esi),%esi

000005d0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5d4:	31 ff                	xor    %edi,%edi
{
 5d6:	56                   	push   %esi
 5d7:	53                   	push   %ebx
 5d8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5db:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 5de:	8d 45 10             	lea    0x10(%ebp),%eax
{
 5e1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 5e4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5e7:	0f b6 13             	movzbl (%ebx),%edx
 5ea:	83 c3 01             	add    $0x1,%ebx
 5ed:	84 d2                	test   %dl,%dl
 5ef:	75 39                	jne    62a <printf+0x5a>
 5f1:	e9 ca 00 00 00       	jmp    6c0 <printf+0xf0>
 5f6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5f8:	83 fa 25             	cmp    $0x25,%edx
 5fb:	0f 84 c7 00 00 00    	je     6c8 <printf+0xf8>
  write(fd, &c, 1);
 601:	8d 45 e0             	lea    -0x20(%ebp),%eax
 604:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 60b:	00 
 60c:	89 44 24 04          	mov    %eax,0x4(%esp)
 610:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 613:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 616:	e8 57 fe ff ff       	call   472 <write>
 61b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 61e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 622:	84 d2                	test   %dl,%dl
 624:	0f 84 96 00 00 00    	je     6c0 <printf+0xf0>
    if(state == 0){
 62a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 62c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 62f:	74 c7                	je     5f8 <printf+0x28>
      }
    } else if(state == '%'){
 631:	83 ff 25             	cmp    $0x25,%edi
 634:	75 e5                	jne    61b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 636:	83 fa 75             	cmp    $0x75,%edx
 639:	0f 84 99 00 00 00    	je     6d8 <printf+0x108>
 63f:	83 fa 64             	cmp    $0x64,%edx
 642:	0f 84 90 00 00 00    	je     6d8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 648:	25 f7 00 00 00       	and    $0xf7,%eax
 64d:	83 f8 70             	cmp    $0x70,%eax
 650:	0f 84 aa 00 00 00    	je     700 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 656:	83 fa 73             	cmp    $0x73,%edx
 659:	0f 84 e9 00 00 00    	je     748 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 65f:	83 fa 63             	cmp    $0x63,%edx
 662:	0f 84 2b 01 00 00    	je     793 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 668:	83 fa 25             	cmp    $0x25,%edx
 66b:	0f 84 4f 01 00 00    	je     7c0 <printf+0x1f0>
  write(fd, &c, 1);
 671:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 674:	83 c3 01             	add    $0x1,%ebx
 677:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 67e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 67f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 681:	89 44 24 04          	mov    %eax,0x4(%esp)
 685:	89 34 24             	mov    %esi,(%esp)
 688:	89 55 d0             	mov    %edx,-0x30(%ebp)
 68b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 68f:	e8 de fd ff ff       	call   472 <write>
        putc(fd, c);
 694:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 697:	8d 45 e7             	lea    -0x19(%ebp),%eax
 69a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6a1:	00 
 6a2:	89 44 24 04          	mov    %eax,0x4(%esp)
 6a6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 6a9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 6ac:	e8 c1 fd ff ff       	call   472 <write>
  for(i = 0; fmt[i]; i++){
 6b1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6b5:	84 d2                	test   %dl,%dl
 6b7:	0f 85 6d ff ff ff    	jne    62a <printf+0x5a>
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 6c0:	83 c4 3c             	add    $0x3c,%esp
 6c3:	5b                   	pop    %ebx
 6c4:	5e                   	pop    %esi
 6c5:	5f                   	pop    %edi
 6c6:	5d                   	pop    %ebp
 6c7:	c3                   	ret    
        state = '%';
 6c8:	bf 25 00 00 00       	mov    $0x25,%edi
 6cd:	e9 49 ff ff ff       	jmp    61b <printf+0x4b>
 6d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 6d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6df:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 6e4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6e7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 6e9:	8b 10                	mov    (%eax),%edx
 6eb:	89 f0                	mov    %esi,%eax
 6ed:	e8 3e fe ff ff       	call   530 <printint>
        ap++;
 6f2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6f6:	e9 20 ff ff ff       	jmp    61b <printf+0x4b>
 6fb:	90                   	nop
 6fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 700:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 703:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 70a:	00 
 70b:	89 44 24 04          	mov    %eax,0x4(%esp)
 70f:	89 34 24             	mov    %esi,(%esp)
 712:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 716:	e8 57 fd ff ff       	call   472 <write>
 71b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 71e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 725:	00 
 726:	89 44 24 04          	mov    %eax,0x4(%esp)
 72a:	89 34 24             	mov    %esi,(%esp)
 72d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 731:	e8 3c fd ff ff       	call   472 <write>
        printint(fd, *ap, 16, 0);
 736:	b9 10 00 00 00       	mov    $0x10,%ecx
 73b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 742:	eb a0                	jmp    6e4 <printf+0x114>
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 748:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 74b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 74f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 751:	b8 30 0b 00 00       	mov    $0xb30,%eax
 756:	85 ff                	test   %edi,%edi
 758:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 75b:	0f b6 07             	movzbl (%edi),%eax
 75e:	84 c0                	test   %al,%al
 760:	74 2a                	je     78c <printf+0x1bc>
 762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 768:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 76b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 76e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 771:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 778:	00 
 779:	89 44 24 04          	mov    %eax,0x4(%esp)
 77d:	89 34 24             	mov    %esi,(%esp)
 780:	e8 ed fc ff ff       	call   472 <write>
        while(*s != 0){
 785:	0f b6 07             	movzbl (%edi),%eax
 788:	84 c0                	test   %al,%al
 78a:	75 dc                	jne    768 <printf+0x198>
      state = 0;
 78c:	31 ff                	xor    %edi,%edi
 78e:	e9 88 fe ff ff       	jmp    61b <printf+0x4b>
        putc(fd, *ap);
 793:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 796:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 798:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 79a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7a1:	00 
 7a2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 7a5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 7a8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 7af:	e8 be fc ff ff       	call   472 <write>
        ap++;
 7b4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 7b8:	e9 5e fe ff ff       	jmp    61b <printf+0x4b>
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7c0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 7c3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 7c5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7cc:	00 
 7cd:	89 44 24 04          	mov    %eax,0x4(%esp)
 7d1:	89 34 24             	mov    %esi,(%esp)
 7d4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 7d8:	e8 95 fc ff ff       	call   472 <write>
 7dd:	e9 39 fe ff ff       	jmp    61b <printf+0x4b>
 7e2:	66 90                	xchg   %ax,%ax
 7e4:	66 90                	xchg   %ax,%ax
 7e6:	66 90                	xchg   %ax,%ax
 7e8:	66 90                	xchg   %ax,%ax
 7ea:	66 90                	xchg   %ax,%ax
 7ec:	66 90                	xchg   %ax,%ax
 7ee:	66 90                	xchg   %ax,%ax

000007f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f1:	a1 94 0e 00 00       	mov    0xe94,%eax
{
 7f6:	89 e5                	mov    %esp,%ebp
 7f8:	57                   	push   %edi
 7f9:	56                   	push   %esi
 7fa:	53                   	push   %ebx
 7fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7fe:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 800:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 803:	39 d0                	cmp    %edx,%eax
 805:	72 11                	jb     818 <free+0x28>
 807:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 808:	39 c8                	cmp    %ecx,%eax
 80a:	72 04                	jb     810 <free+0x20>
 80c:	39 ca                	cmp    %ecx,%edx
 80e:	72 10                	jb     820 <free+0x30>
 810:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 812:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 814:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 816:	73 f0                	jae    808 <free+0x18>
 818:	39 ca                	cmp    %ecx,%edx
 81a:	72 04                	jb     820 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 81c:	39 c8                	cmp    %ecx,%eax
 81e:	72 f0                	jb     810 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 820:	8b 73 fc             	mov    -0x4(%ebx),%esi
 823:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 826:	39 cf                	cmp    %ecx,%edi
 828:	74 1e                	je     848 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 82a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 82d:	8b 48 04             	mov    0x4(%eax),%ecx
 830:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 833:	39 f2                	cmp    %esi,%edx
 835:	74 28                	je     85f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 837:	89 10                	mov    %edx,(%eax)
  freep = p;
 839:	a3 94 0e 00 00       	mov    %eax,0xe94
}
 83e:	5b                   	pop    %ebx
 83f:	5e                   	pop    %esi
 840:	5f                   	pop    %edi
 841:	5d                   	pop    %ebp
 842:	c3                   	ret    
 843:	90                   	nop
 844:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 848:	03 71 04             	add    0x4(%ecx),%esi
 84b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 84e:	8b 08                	mov    (%eax),%ecx
 850:	8b 09                	mov    (%ecx),%ecx
 852:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 855:	8b 48 04             	mov    0x4(%eax),%ecx
 858:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 85b:	39 f2                	cmp    %esi,%edx
 85d:	75 d8                	jne    837 <free+0x47>
    p->s.size += bp->s.size;
 85f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 862:	a3 94 0e 00 00       	mov    %eax,0xe94
    p->s.size += bp->s.size;
 867:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 86a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 86d:	89 10                	mov    %edx,(%eax)
}
 86f:	5b                   	pop    %ebx
 870:	5e                   	pop    %esi
 871:	5f                   	pop    %edi
 872:	5d                   	pop    %ebp
 873:	c3                   	ret    
 874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 87a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000880 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	56                   	push   %esi
 885:	53                   	push   %ebx
 886:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 889:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 88c:	8b 1d 94 0e 00 00    	mov    0xe94,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 892:	8d 48 07             	lea    0x7(%eax),%ecx
 895:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 898:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 89a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 89d:	0f 84 9b 00 00 00    	je     93e <malloc+0xbe>
 8a3:	8b 13                	mov    (%ebx),%edx
 8a5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 8a8:	39 fe                	cmp    %edi,%esi
 8aa:	76 64                	jbe    910 <malloc+0x90>
 8ac:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 8b3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 8b8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 8bb:	eb 0e                	jmp    8cb <malloc+0x4b>
 8bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8c2:	8b 78 04             	mov    0x4(%eax),%edi
 8c5:	39 fe                	cmp    %edi,%esi
 8c7:	76 4f                	jbe    918 <malloc+0x98>
 8c9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8cb:	3b 15 94 0e 00 00    	cmp    0xe94,%edx
 8d1:	75 ed                	jne    8c0 <malloc+0x40>
  if(nu < 4096)
 8d3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8d6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 8dc:	bf 00 10 00 00       	mov    $0x1000,%edi
 8e1:	0f 43 fe             	cmovae %esi,%edi
 8e4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 8e7:	89 04 24             	mov    %eax,(%esp)
 8ea:	e8 eb fb ff ff       	call   4da <sbrk>
  if(p == (char*)-1)
 8ef:	83 f8 ff             	cmp    $0xffffffff,%eax
 8f2:	74 18                	je     90c <malloc+0x8c>
  hp->s.size = nu;
 8f4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8f7:	83 c0 08             	add    $0x8,%eax
 8fa:	89 04 24             	mov    %eax,(%esp)
 8fd:	e8 ee fe ff ff       	call   7f0 <free>
  return freep;
 902:	8b 15 94 0e 00 00    	mov    0xe94,%edx
      if((p = morecore(nunits)) == 0)
 908:	85 d2                	test   %edx,%edx
 90a:	75 b4                	jne    8c0 <malloc+0x40>
        return 0;
 90c:	31 c0                	xor    %eax,%eax
 90e:	eb 20                	jmp    930 <malloc+0xb0>
    if(p->s.size >= nunits){
 910:	89 d0                	mov    %edx,%eax
 912:	89 da                	mov    %ebx,%edx
 914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 918:	39 fe                	cmp    %edi,%esi
 91a:	74 1c                	je     938 <malloc+0xb8>
        p->s.size -= nunits;
 91c:	29 f7                	sub    %esi,%edi
 91e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 921:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 924:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 927:	89 15 94 0e 00 00    	mov    %edx,0xe94
      return (void*)(p + 1);
 92d:	83 c0 08             	add    $0x8,%eax
  }
}
 930:	83 c4 1c             	add    $0x1c,%esp
 933:	5b                   	pop    %ebx
 934:	5e                   	pop    %esi
 935:	5f                   	pop    %edi
 936:	5d                   	pop    %ebp
 937:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 938:	8b 08                	mov    (%eax),%ecx
 93a:	89 0a                	mov    %ecx,(%edx)
 93c:	eb e9                	jmp    927 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 93e:	c7 05 94 0e 00 00 98 	movl   $0xe98,0xe94
 945:	0e 00 00 
    base.s.size = 0;
 948:	ba 98 0e 00 00       	mov    $0xe98,%edx
    base.s.ptr = freep = prevp = &base;
 94d:	c7 05 98 0e 00 00 98 	movl   $0xe98,0xe98
 954:	0e 00 00 
    base.s.size = 0;
 957:	c7 05 9c 0e 00 00 00 	movl   $0x0,0xe9c
 95e:	00 00 00 
 961:	e9 46 ff ff ff       	jmp    8ac <malloc+0x2c>
 966:	66 90                	xchg   %ax,%ax
 968:	66 90                	xchg   %ax,%ax
 96a:	66 90                	xchg   %ax,%ax
 96c:	66 90                	xchg   %ax,%ax
 96e:	66 90                	xchg   %ax,%ax

00000970 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 970:	55                   	push   %ebp
 971:	89 e5                	mov    %esp,%ebp
 973:	53                   	push   %ebx
 974:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 977:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 97e:	e8 fd fe ff ff       	call   880 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 983:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 98a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 98c:	e8 ef fe ff ff       	call   880 <malloc>
    if (tstack == NULL) {
 991:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 993:	89 c2                	mov    %eax,%edx
 995:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 998:	0f 84 8a 00 00 00    	je     a28 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 99e:	25 ff 0f 00 00       	and    $0xfff,%eax
 9a3:	75 73                	jne    a18 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 9a5:	8b 45 10             	mov    0x10(%ebp),%eax
 9a8:	89 54 24 08          	mov    %edx,0x8(%esp)
 9ac:	89 44 24 04          	mov    %eax,0x4(%esp)
 9b0:	8b 45 0c             	mov    0xc(%ebp),%eax
 9b3:	89 04 24             	mov    %eax,(%esp)
 9b6:	e8 57 fb ff ff       	call   512 <kthread_create>
 9bb:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 9bd:	89 44 24 10          	mov    %eax,0x10(%esp)
 9c1:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 9c8:	00 
 9c9:	c7 44 24 08 48 0b 00 	movl   $0xb48,0x8(%esp)
 9d0:	00 
 9d1:	c7 44 24 04 57 0b 00 	movl   $0xb57,0x4(%esp)
 9d8:	00 
 9d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9e0:	e8 eb fb ff ff       	call   5d0 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 9e5:	8b 03                	mov    (%ebx),%eax
 9e7:	c7 44 24 04 6e 0b 00 	movl   $0xb6e,0x4(%esp)
 9ee:	00 
 9ef:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9f6:	89 44 24 08          	mov    %eax,0x8(%esp)
 9fa:	e8 d1 fb ff ff       	call   5d0 <printf>
    
    if (bt->tid != 0) {
 9ff:	8b 03                	mov    (%ebx),%eax
 a01:	85 c0                	test   %eax,%eax
 a03:	74 23                	je     a28 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 a05:	8b 45 08             	mov    0x8(%ebp),%eax
 a08:	89 18                	mov    %ebx,(%eax)
        return 0;
 a0a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 a0c:	83 c4 24             	add    $0x24,%esp
 a0f:	5b                   	pop    %ebx
 a10:	5d                   	pop    %ebp
 a11:	c3                   	ret    
 a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 a18:	29 c2                	sub    %eax,%edx
 a1a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 a20:	eb 83                	jmp    9a5 <benny_thread_create+0x35>
 a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 a28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a2d:	eb dd                	jmp    a0c <benny_thread_create+0x9c>
 a2f:	90                   	nop

00000a30 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 a33:	8b 45 08             	mov    0x8(%ebp),%eax
}
 a36:	5d                   	pop    %ebp
    return bt->tid;
 a37:	8b 00                	mov    (%eax),%eax
}
 a39:	c3                   	ret    
 a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a40 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 a40:	55                   	push   %ebp
 a41:	89 e5                	mov    %esp,%ebp
 a43:	53                   	push   %ebx
 a44:	83 ec 14             	sub    $0x14,%esp
 a47:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 a4a:	8b 03                	mov    (%ebx),%eax
 a4c:	89 04 24             	mov    %eax,(%esp)
 a4f:	e8 c6 fa ff ff       	call   51a <kthread_join>
    if (retVal == 0) {
 a54:	85 c0                	test   %eax,%eax
 a56:	75 11                	jne    a69 <benny_thread_join+0x29>
        free(bt->tstack);
 a58:	8b 53 04             	mov    0x4(%ebx),%edx
 a5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a5e:	89 14 24             	mov    %edx,(%esp)
 a61:	e8 8a fd ff ff       	call   7f0 <free>
 a66:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 a69:	83 c4 14             	add    $0x14,%esp
 a6c:	5b                   	pop    %ebx
 a6d:	5d                   	pop    %ebp
 a6e:	c3                   	ret    
 a6f:	90                   	nop

00000a70 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 a70:	55                   	push   %ebp
 a71:	89 e5                	mov    %esp,%ebp
 a73:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 a76:	8b 45 08             	mov    0x8(%ebp),%eax
 a79:	89 04 24             	mov    %eax,(%esp)
 a7c:	e8 a1 fa ff ff       	call   522 <kthread_exit>
    return 0;
}
 a81:	31 c0                	xor    %eax,%eax
 a83:	c9                   	leave  
 a84:	c3                   	ret    
