
_thtst4:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}
#endif // KTHREADS

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
#ifdef KTHREADS
    benny_thread_create(&(bt[0]), func1, (void *) 1);
   9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  10:	00 
  11:	c7 44 24 04 10 01 00 	movl   $0x110,0x4(%esp)
  18:	00 
  19:	c7 04 24 40 0f 00 00 	movl   $0xf40,(%esp)
  20:	e8 ab 09 00 00       	call   9d0 <benny_thread_create>

    long_time(20);
  25:	c7 04 24 14 00 00 00 	movl   $0x14,(%esp)
  2c:	e8 4f 00 00 00       	call   80 <long_time>

    benny_thread_join(bt[0]); // tid = 1
  31:	a1 40 0f 00 00       	mov    0xf40,%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 62 0a 00 00       	call   aa0 <benny_thread_join>
    benny_thread_join(bt[1]); // tid = 2
  3e:	a1 44 0f 00 00       	mov    0xf44,%eax
  43:	89 04 24             	mov    %eax,(%esp)
  46:	e8 55 0a 00 00       	call   aa0 <benny_thread_join>
    benny_thread_join(bt[2]); // tid = 3
  4b:	a1 48 0f 00 00       	mov    0xf48,%eax
  50:	89 04 24             	mov    %eax,(%esp)
  53:	e8 48 0a 00 00       	call   aa0 <benny_thread_join>

    printf(1, "All threads joined\n");
  58:	c7 44 24 04 fb 0a 00 	movl   $0xafb,0x4(%esp)
  5f:	00 
  60:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  67:	e8 c4 05 00 00       	call   630 <printf>
#endif // KTHREADS
    exit();
  6c:	e8 41 04 00 00       	call   4b2 <exit>
  71:	66 90                	xchg   %ax,%ax
  73:	66 90                	xchg   %ax,%ax
  75:	66 90                	xchg   %ax,%ax
  77:	66 90                	xchg   %ax,%ax
  79:	66 90                	xchg   %ax,%ax
  7b:	66 90                	xchg   %ax,%ax
  7d:	66 90                	xchg   %ax,%ax
  7f:	90                   	nop

00000080 <long_time>:
{
  80:	55                   	push   %ebp
        if ((sum % (MAXSHORT * MAXSHORT)) == 0) {
  81:	b9 03 00 ff 3f       	mov    $0x3fff0003,%ecx
{
  86:	89 e5                	mov    %esp,%ebp
  88:	57                   	push   %edi
            sum = 0;
  89:	31 ff                	xor    %edi,%edi
{
  8b:	56                   	push   %esi
  8c:	be ff ff ff 7f       	mov    $0x7fffffff,%esi
  91:	53                   	push   %ebx
        sum ++;
  92:	bb 02 00 00 00       	mov    $0x2,%ebx
{
  97:	83 ec 2c             	sub    $0x2c,%esp
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            sum = 0;
  a0:	81 fb 00 00 00 40    	cmp    $0x40000000,%ebx
  a6:	0f 43 df             	cmovae %edi,%ebx
    for(i = 0; i < max; i++) {
  a9:	83 ee 01             	sub    $0x1,%esi
  ac:	74 53                	je     101 <long_time+0x81>
        sum ++;
  ae:	83 c3 01             	add    $0x1,%ebx
        if ((sum % (MAXSHORT * MAXSHORT)) == 0) {
  b1:	89 d8                	mov    %ebx,%eax
  b3:	f7 e1                	mul    %ecx
  b5:	c1 ea 1c             	shr    $0x1c,%edx
  b8:	69 d2 01 00 01 40    	imul   $0x40010001,%edx,%edx
  be:	39 d3                	cmp    %edx,%ebx
  c0:	75 de                	jne    a0 <long_time+0x20>
            sum += arg;
  c2:	03 5d 08             	add    0x8(%ebp),%ebx
  c5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
            printf(1, "\t%d  thtst2: %d  %d\n\n", arg, getpid(), sum);
  c8:	e8 65 04 00 00       	call   532 <getpid>
  cd:	89 5c 24 10          	mov    %ebx,0x10(%esp)
  d1:	c7 44 24 04 e5 0a 00 	movl   $0xae5,0x4(%esp)
  d8:	00 
  d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
  e4:	8b 45 08             	mov    0x8(%ebp),%eax
  e7:	89 44 24 08          	mov    %eax,0x8(%esp)
  eb:	e8 40 05 00 00       	call   630 <printf>
            sum = 0;
  f0:	81 fb 00 00 00 40    	cmp    $0x40000000,%ebx
            printf(1, "\t%d  thtst2: %d  %d\n\n", arg, getpid(), sum);
  f6:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
            sum = 0;
  f9:	0f 43 df             	cmovae %edi,%ebx
    for(i = 0; i < max; i++) {
  fc:	83 ee 01             	sub    $0x1,%esi
  ff:	75 ad                	jne    ae <long_time+0x2e>
}
 101:	83 c4 2c             	add    $0x2c,%esp
 104:	5b                   	pop    %ebx
 105:	5e                   	pop    %esi
 106:	5f                   	pop    %edi
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000110 <func1>:
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	53                   	push   %ebx
 114:	83 ec 14             	sub    $0x14,%esp
 117:	8b 5d 08             	mov    0x8(%ebp),%ebx
    benny_thread_create(&(bt[arg]), func2, (void *) (arg + 1));
 11a:	c7 44 24 04 80 01 00 	movl   $0x180,0x4(%esp)
 121:	00 
 122:	8d 43 01             	lea    0x1(%ebx),%eax
 125:	89 44 24 08          	mov    %eax,0x8(%esp)
 129:	8d 04 9d 40 0f 00 00 	lea    0xf40(,%ebx,4),%eax
 130:	89 04 24             	mov    %eax,(%esp)
 133:	e8 98 08 00 00       	call   9d0 <benny_thread_create>
    long_time(arg);
 138:	89 1c 24             	mov    %ebx,(%esp)
 13b:	e8 40 ff ff ff       	call   80 <long_time>
    benny_thread_join(bt[3]); // tid = 4
 140:	a1 4c 0f 00 00       	mov    0xf4c,%eax
 145:	89 04 24             	mov    %eax,(%esp)
 148:	e8 53 09 00 00       	call   aa0 <benny_thread_join>
    benny_thread_join(bt[4]); // tid = 5
 14d:	a1 50 0f 00 00       	mov    0xf50,%eax
 152:	89 04 24             	mov    %eax,(%esp)
 155:	e8 46 09 00 00       	call   aa0 <benny_thread_join>
    benny_thread_exit(1);
 15a:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
    bt[3] = NULL;
 161:	c7 05 4c 0f 00 00 00 	movl   $0x0,0xf4c
 168:	00 00 00 
    bt[4] = NULL;
 16b:	c7 05 50 0f 00 00 00 	movl   $0x0,0xf50
 172:	00 00 00 
}
 175:	83 c4 14             	add    $0x14,%esp
 178:	5b                   	pop    %ebx
 179:	5d                   	pop    %ebp
    benny_thread_exit(1);
 17a:	e9 51 09 00 00       	jmp    ad0 <benny_thread_exit>
 17f:	90                   	nop

00000180 <func2>:
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	83 ec 14             	sub    $0x14,%esp
 187:	8b 5d 08             	mov    0x8(%ebp),%ebx
    benny_thread_create(&(bt[arg]), func3, (void *) (arg + 1));
 18a:	c7 44 24 04 d0 01 00 	movl   $0x1d0,0x4(%esp)
 191:	00 
 192:	8d 43 01             	lea    0x1(%ebx),%eax
 195:	89 44 24 08          	mov    %eax,0x8(%esp)
 199:	8d 04 9d 40 0f 00 00 	lea    0xf40(,%ebx,4),%eax
 1a0:	89 04 24             	mov    %eax,(%esp)
 1a3:	e8 28 08 00 00       	call   9d0 <benny_thread_create>
    long_time(arg);
 1a8:	89 1c 24             	mov    %ebx,(%esp)
 1ab:	e8 d0 fe ff ff       	call   80 <long_time>
    benny_thread_exit(2);
 1b0:	c7 45 08 02 00 00 00 	movl   $0x2,0x8(%ebp)
}
 1b7:	83 c4 14             	add    $0x14,%esp
 1ba:	5b                   	pop    %ebx
 1bb:	5d                   	pop    %ebp
    benny_thread_exit(2);
 1bc:	e9 0f 09 00 00       	jmp    ad0 <benny_thread_exit>
 1c1:	eb 0d                	jmp    1d0 <func3>
 1c3:	90                   	nop
 1c4:	90                   	nop
 1c5:	90                   	nop
 1c6:	90                   	nop
 1c7:	90                   	nop
 1c8:	90                   	nop
 1c9:	90                   	nop
 1ca:	90                   	nop
 1cb:	90                   	nop
 1cc:	90                   	nop
 1cd:	90                   	nop
 1ce:	90                   	nop
 1cf:	90                   	nop

000001d0 <func3>:
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	83 ec 14             	sub    $0x14,%esp
 1d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    benny_thread_create(&(bt[arg]), func4, (void *) (arg + 1));
 1da:	c7 44 24 04 20 02 00 	movl   $0x220,0x4(%esp)
 1e1:	00 
 1e2:	8d 43 01             	lea    0x1(%ebx),%eax
 1e5:	89 44 24 08          	mov    %eax,0x8(%esp)
 1e9:	8d 04 9d 40 0f 00 00 	lea    0xf40(,%ebx,4),%eax
 1f0:	89 04 24             	mov    %eax,(%esp)
 1f3:	e8 d8 07 00 00       	call   9d0 <benny_thread_create>
    long_time(arg);
 1f8:	89 1c 24             	mov    %ebx,(%esp)
 1fb:	e8 80 fe ff ff       	call   80 <long_time>
    benny_thread_exit(3);
 200:	c7 45 08 03 00 00 00 	movl   $0x3,0x8(%ebp)
}
 207:	83 c4 14             	add    $0x14,%esp
 20a:	5b                   	pop    %ebx
 20b:	5d                   	pop    %ebp
    benny_thread_exit(3);
 20c:	e9 bf 08 00 00       	jmp    ad0 <benny_thread_exit>
 211:	eb 0d                	jmp    220 <func4>
 213:	90                   	nop
 214:	90                   	nop
 215:	90                   	nop
 216:	90                   	nop
 217:	90                   	nop
 218:	90                   	nop
 219:	90                   	nop
 21a:	90                   	nop
 21b:	90                   	nop
 21c:	90                   	nop
 21d:	90                   	nop
 21e:	90                   	nop
 21f:	90                   	nop

00000220 <func4>:
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	53                   	push   %ebx
 224:	83 ec 14             	sub    $0x14,%esp
 227:	8b 5d 08             	mov    0x8(%ebp),%ebx
    benny_thread_create(&(bt[arg]), func5, (void *) (arg + 1));
 22a:	c7 44 24 04 70 02 00 	movl   $0x270,0x4(%esp)
 231:	00 
 232:	8d 43 01             	lea    0x1(%ebx),%eax
 235:	89 44 24 08          	mov    %eax,0x8(%esp)
 239:	8d 04 9d 40 0f 00 00 	lea    0xf40(,%ebx,4),%eax
 240:	89 04 24             	mov    %eax,(%esp)
 243:	e8 88 07 00 00       	call   9d0 <benny_thread_create>
    long_time(arg);
 248:	89 1c 24             	mov    %ebx,(%esp)
 24b:	e8 30 fe ff ff       	call   80 <long_time>
    benny_thread_exit(4);
 250:	c7 45 08 04 00 00 00 	movl   $0x4,0x8(%ebp)
}
 257:	83 c4 14             	add    $0x14,%esp
 25a:	5b                   	pop    %ebx
 25b:	5d                   	pop    %ebp
    benny_thread_exit(4);
 25c:	e9 6f 08 00 00       	jmp    ad0 <benny_thread_exit>
 261:	eb 0d                	jmp    270 <func5>
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

00000270 <func5>:
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	83 ec 18             	sub    $0x18,%esp
    long_time(arg);
 276:	8b 45 08             	mov    0x8(%ebp),%eax
 279:	89 04 24             	mov    %eax,(%esp)
 27c:	e8 ff fd ff ff       	call   80 <long_time>
    benny_thread_exit(5);
 281:	c7 45 08 05 00 00 00 	movl   $0x5,0x8(%ebp)
}
 288:	c9                   	leave  
    benny_thread_exit(5);
 289:	e9 42 08 00 00       	jmp    ad0 <benny_thread_exit>
 28e:	66 90                	xchg   %ax,%ax

00000290 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 299:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 29a:	89 c2                	mov    %eax,%edx
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2a0:	83 c1 01             	add    $0x1,%ecx
 2a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2a7:	83 c2 01             	add    $0x1,%edx
 2aa:	84 db                	test   %bl,%bl
 2ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 2af:	75 ef                	jne    2a0 <strcpy+0x10>
    ;
  return os;
}
 2b1:	5b                   	pop    %ebx
 2b2:	5d                   	pop    %ebp
 2b3:	c3                   	ret    
 2b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 55 08             	mov    0x8(%ebp),%edx
 2c6:	53                   	push   %ebx
 2c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2ca:	0f b6 02             	movzbl (%edx),%eax
 2cd:	84 c0                	test   %al,%al
 2cf:	74 2d                	je     2fe <strcmp+0x3e>
 2d1:	0f b6 19             	movzbl (%ecx),%ebx
 2d4:	38 d8                	cmp    %bl,%al
 2d6:	74 0e                	je     2e6 <strcmp+0x26>
 2d8:	eb 2b                	jmp    305 <strcmp+0x45>
 2da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2e0:	38 c8                	cmp    %cl,%al
 2e2:	75 15                	jne    2f9 <strcmp+0x39>
    p++, q++;
 2e4:	89 d9                	mov    %ebx,%ecx
 2e6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2e9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2ec:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 2ef:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 2f3:	84 c0                	test   %al,%al
 2f5:	75 e9                	jne    2e0 <strcmp+0x20>
 2f7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 2f9:	29 c8                	sub    %ecx,%eax
}
 2fb:	5b                   	pop    %ebx
 2fc:	5d                   	pop    %ebp
 2fd:	c3                   	ret    
 2fe:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 301:	31 c0                	xor    %eax,%eax
 303:	eb f4                	jmp    2f9 <strcmp+0x39>
 305:	0f b6 cb             	movzbl %bl,%ecx
 308:	eb ef                	jmp    2f9 <strcmp+0x39>
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000310 <strlen>:

uint
strlen(const char *s)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 316:	80 39 00             	cmpb   $0x0,(%ecx)
 319:	74 12                	je     32d <strlen+0x1d>
 31b:	31 d2                	xor    %edx,%edx
 31d:	8d 76 00             	lea    0x0(%esi),%esi
 320:	83 c2 01             	add    $0x1,%edx
 323:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 327:	89 d0                	mov    %edx,%eax
 329:	75 f5                	jne    320 <strlen+0x10>
    ;
  return n;
}
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 32d:	31 c0                	xor    %eax,%eax
}
 32f:	5d                   	pop    %ebp
 330:	c3                   	ret    
 331:	eb 0d                	jmp    340 <memset>
 333:	90                   	nop
 334:	90                   	nop
 335:	90                   	nop
 336:	90                   	nop
 337:	90                   	nop
 338:	90                   	nop
 339:	90                   	nop
 33a:	90                   	nop
 33b:	90                   	nop
 33c:	90                   	nop
 33d:	90                   	nop
 33e:	90                   	nop
 33f:	90                   	nop

00000340 <memset>:

void*
memset(void *dst, int c, uint n)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	8b 55 08             	mov    0x8(%ebp),%edx
 346:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 347:	8b 4d 10             	mov    0x10(%ebp),%ecx
 34a:	8b 45 0c             	mov    0xc(%ebp),%eax
 34d:	89 d7                	mov    %edx,%edi
 34f:	fc                   	cld    
 350:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 352:	89 d0                	mov    %edx,%eax
 354:	5f                   	pop    %edi
 355:	5d                   	pop    %ebp
 356:	c3                   	ret    
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <strchr>:

char*
strchr(const char *s, char c)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	8b 45 08             	mov    0x8(%ebp),%eax
 366:	53                   	push   %ebx
 367:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 36a:	0f b6 18             	movzbl (%eax),%ebx
 36d:	84 db                	test   %bl,%bl
 36f:	74 1d                	je     38e <strchr+0x2e>
    if(*s == c)
 371:	38 d3                	cmp    %dl,%bl
 373:	89 d1                	mov    %edx,%ecx
 375:	75 0d                	jne    384 <strchr+0x24>
 377:	eb 17                	jmp    390 <strchr+0x30>
 379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 380:	38 ca                	cmp    %cl,%dl
 382:	74 0c                	je     390 <strchr+0x30>
  for(; *s; s++)
 384:	83 c0 01             	add    $0x1,%eax
 387:	0f b6 10             	movzbl (%eax),%edx
 38a:	84 d2                	test   %dl,%dl
 38c:	75 f2                	jne    380 <strchr+0x20>
      return (char*)s;
  return 0;
 38e:	31 c0                	xor    %eax,%eax
}
 390:	5b                   	pop    %ebx
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <gets>:

char*
gets(char *buf, int max)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a5:	31 f6                	xor    %esi,%esi
{
 3a7:	53                   	push   %ebx
 3a8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 3ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 3ae:	eb 31                	jmp    3e1 <gets+0x41>
    cc = read(0, &c, 1);
 3b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b7:	00 
 3b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 3bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 3c3:	e8 02 01 00 00       	call   4ca <read>
    if(cc < 1)
 3c8:	85 c0                	test   %eax,%eax
 3ca:	7e 1d                	jle    3e9 <gets+0x49>
      break;
    buf[i++] = c;
 3cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 3d0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 3d2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 3d5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 3d7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3db:	74 0c                	je     3e9 <gets+0x49>
 3dd:	3c 0a                	cmp    $0xa,%al
 3df:	74 08                	je     3e9 <gets+0x49>
  for(i=0; i+1 < max; ){
 3e1:	8d 5e 01             	lea    0x1(%esi),%ebx
 3e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3e7:	7c c7                	jl     3b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 3e9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ec:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3f0:	83 c4 2c             	add    $0x2c,%esp
 3f3:	5b                   	pop    %ebx
 3f4:	5e                   	pop    %esi
 3f5:	5f                   	pop    %edi
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
 3f8:	90                   	nop
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000400 <stat>:

int
stat(const char *n, struct stat *st)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	56                   	push   %esi
 404:	53                   	push   %ebx
 405:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 408:	8b 45 08             	mov    0x8(%ebp),%eax
 40b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 412:	00 
 413:	89 04 24             	mov    %eax,(%esp)
 416:	e8 d7 00 00 00       	call   4f2 <open>
  if(fd < 0)
 41b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 41d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 41f:	78 27                	js     448 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 421:	8b 45 0c             	mov    0xc(%ebp),%eax
 424:	89 1c 24             	mov    %ebx,(%esp)
 427:	89 44 24 04          	mov    %eax,0x4(%esp)
 42b:	e8 da 00 00 00       	call   50a <fstat>
  close(fd);
 430:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 433:	89 c6                	mov    %eax,%esi
  close(fd);
 435:	e8 a0 00 00 00       	call   4da <close>
  return r;
 43a:	89 f0                	mov    %esi,%eax
}
 43c:	83 c4 10             	add    $0x10,%esp
 43f:	5b                   	pop    %ebx
 440:	5e                   	pop    %esi
 441:	5d                   	pop    %ebp
 442:	c3                   	ret    
 443:	90                   	nop
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 448:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 44d:	eb ed                	jmp    43c <stat+0x3c>
 44f:	90                   	nop

00000450 <atoi>:

int
atoi(const char *s)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	8b 4d 08             	mov    0x8(%ebp),%ecx
 456:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 457:	0f be 11             	movsbl (%ecx),%edx
 45a:	8d 42 d0             	lea    -0x30(%edx),%eax
 45d:	3c 09                	cmp    $0x9,%al
  n = 0;
 45f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 464:	77 17                	ja     47d <atoi+0x2d>
 466:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 468:	83 c1 01             	add    $0x1,%ecx
 46b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 46e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 472:	0f be 11             	movsbl (%ecx),%edx
 475:	8d 5a d0             	lea    -0x30(%edx),%ebx
 478:	80 fb 09             	cmp    $0x9,%bl
 47b:	76 eb                	jbe    468 <atoi+0x18>
  return n;
}
 47d:	5b                   	pop    %ebx
 47e:	5d                   	pop    %ebp
 47f:	c3                   	ret    

00000480 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 480:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 481:	31 d2                	xor    %edx,%edx
{
 483:	89 e5                	mov    %esp,%ebp
 485:	56                   	push   %esi
 486:	8b 45 08             	mov    0x8(%ebp),%eax
 489:	53                   	push   %ebx
 48a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 48d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 490:	85 db                	test   %ebx,%ebx
 492:	7e 12                	jle    4a6 <memmove+0x26>
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 498:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 49c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 49f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 4a2:	39 da                	cmp    %ebx,%edx
 4a4:	75 f2                	jne    498 <memmove+0x18>
  return vdst;
}
 4a6:	5b                   	pop    %ebx
 4a7:	5e                   	pop    %esi
 4a8:	5d                   	pop    %ebp
 4a9:	c3                   	ret    

000004aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4aa:	b8 01 00 00 00       	mov    $0x1,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <exit>:
SYSCALL(exit)
 4b2:	b8 02 00 00 00       	mov    $0x2,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <wait>:
SYSCALL(wait)
 4ba:	b8 03 00 00 00       	mov    $0x3,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <pipe>:
SYSCALL(pipe)
 4c2:	b8 04 00 00 00       	mov    $0x4,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <read>:
SYSCALL(read)
 4ca:	b8 05 00 00 00       	mov    $0x5,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <write>:
SYSCALL(write)
 4d2:	b8 10 00 00 00       	mov    $0x10,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <close>:
SYSCALL(close)
 4da:	b8 15 00 00 00       	mov    $0x15,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <kill>:
SYSCALL(kill)
 4e2:	b8 06 00 00 00       	mov    $0x6,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <exec>:
SYSCALL(exec)
 4ea:	b8 07 00 00 00       	mov    $0x7,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <open>:
SYSCALL(open)
 4f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <mknod>:
SYSCALL(mknod)
 4fa:	b8 11 00 00 00       	mov    $0x11,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <unlink>:
SYSCALL(unlink)
 502:	b8 12 00 00 00       	mov    $0x12,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <fstat>:
SYSCALL(fstat)
 50a:	b8 08 00 00 00       	mov    $0x8,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <link>:
SYSCALL(link)
 512:	b8 13 00 00 00       	mov    $0x13,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <mkdir>:
SYSCALL(mkdir)
 51a:	b8 14 00 00 00       	mov    $0x14,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <chdir>:
SYSCALL(chdir)
 522:	b8 09 00 00 00       	mov    $0x9,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <dup>:
SYSCALL(dup)
 52a:	b8 0a 00 00 00       	mov    $0xa,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <getpid>:
SYSCALL(getpid)
 532:	b8 0b 00 00 00       	mov    $0xb,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <sbrk>:
SYSCALL(sbrk)
 53a:	b8 0c 00 00 00       	mov    $0xc,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <sleep>:
SYSCALL(sleep)
 542:	b8 0d 00 00 00       	mov    $0xd,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <uptime>:
SYSCALL(uptime)
 54a:	b8 0e 00 00 00       	mov    $0xe,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 552:	b8 16 00 00 00       	mov    $0x16,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 55a:	b8 17 00 00 00       	mov    $0x17,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 562:	b8 18 00 00 00       	mov    $0x18,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <halt>:
SYSCALL(halt)
 56a:	b8 19 00 00 00       	mov    $0x19,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 572:	b8 1a 00 00 00       	mov    $0x1a,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <kthread_join>:
SYSCALL(kthread_join)
 57a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <kthread_exit>:
SYSCALL(kthread_exit)
 582:	b8 1c 00 00 00       	mov    $0x1c,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    
 58a:	66 90                	xchg   %ax,%ax
 58c:	66 90                	xchg   %ax,%ax
 58e:	66 90                	xchg   %ax,%ax

00000590 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	89 c6                	mov    %eax,%esi
 597:	53                   	push   %ebx
 598:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 59b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 59e:	85 db                	test   %ebx,%ebx
 5a0:	74 09                	je     5ab <printint+0x1b>
 5a2:	89 d0                	mov    %edx,%eax
 5a4:	c1 e8 1f             	shr    $0x1f,%eax
 5a7:	84 c0                	test   %al,%al
 5a9:	75 75                	jne    620 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5ab:	89 d0                	mov    %edx,%eax
  neg = 0;
 5ad:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5b4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 5b7:	31 ff                	xor    %edi,%edi
 5b9:	89 ce                	mov    %ecx,%esi
 5bb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5be:	eb 02                	jmp    5c2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 5c0:	89 cf                	mov    %ecx,%edi
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	f7 f6                	div    %esi
 5c6:	8d 4f 01             	lea    0x1(%edi),%ecx
 5c9:	0f b6 92 16 0b 00 00 	movzbl 0xb16(%edx),%edx
  }while((x /= base) != 0);
 5d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 5d2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5d5:	75 e9                	jne    5c0 <printint+0x30>
  if(neg)
 5d7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 5da:	89 c8                	mov    %ecx,%eax
 5dc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 5df:	85 d2                	test   %edx,%edx
 5e1:	74 08                	je     5eb <printint+0x5b>
    buf[i++] = '-';
 5e3:	8d 4f 02             	lea    0x2(%edi),%ecx
 5e6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 5eb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 5ee:	66 90                	xchg   %ax,%ax
 5f0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 5f5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 5f8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5ff:	00 
 600:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 604:	89 34 24             	mov    %esi,(%esp)
 607:	88 45 d7             	mov    %al,-0x29(%ebp)
 60a:	e8 c3 fe ff ff       	call   4d2 <write>
  while(--i >= 0)
 60f:	83 ff ff             	cmp    $0xffffffff,%edi
 612:	75 dc                	jne    5f0 <printint+0x60>
    putc(fd, buf[i]);
}
 614:	83 c4 4c             	add    $0x4c,%esp
 617:	5b                   	pop    %ebx
 618:	5e                   	pop    %esi
 619:	5f                   	pop    %edi
 61a:	5d                   	pop    %ebp
 61b:	c3                   	ret    
 61c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 620:	89 d0                	mov    %edx,%eax
 622:	f7 d8                	neg    %eax
    neg = 1;
 624:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 62b:	eb 87                	jmp    5b4 <printint+0x24>
 62d:	8d 76 00             	lea    0x0(%esi),%esi

00000630 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 634:	31 ff                	xor    %edi,%edi
{
 636:	56                   	push   %esi
 637:	53                   	push   %ebx
 638:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 63e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 641:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 644:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 647:	0f b6 13             	movzbl (%ebx),%edx
 64a:	83 c3 01             	add    $0x1,%ebx
 64d:	84 d2                	test   %dl,%dl
 64f:	75 39                	jne    68a <printf+0x5a>
 651:	e9 ca 00 00 00       	jmp    720 <printf+0xf0>
 656:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 658:	83 fa 25             	cmp    $0x25,%edx
 65b:	0f 84 c7 00 00 00    	je     728 <printf+0xf8>
  write(fd, &c, 1);
 661:	8d 45 e0             	lea    -0x20(%ebp),%eax
 664:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 66b:	00 
 66c:	89 44 24 04          	mov    %eax,0x4(%esp)
 670:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 673:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 676:	e8 57 fe ff ff       	call   4d2 <write>
 67b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 67e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 682:	84 d2                	test   %dl,%dl
 684:	0f 84 96 00 00 00    	je     720 <printf+0xf0>
    if(state == 0){
 68a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 68c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 68f:	74 c7                	je     658 <printf+0x28>
      }
    } else if(state == '%'){
 691:	83 ff 25             	cmp    $0x25,%edi
 694:	75 e5                	jne    67b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 696:	83 fa 75             	cmp    $0x75,%edx
 699:	0f 84 99 00 00 00    	je     738 <printf+0x108>
 69f:	83 fa 64             	cmp    $0x64,%edx
 6a2:	0f 84 90 00 00 00    	je     738 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6a8:	25 f7 00 00 00       	and    $0xf7,%eax
 6ad:	83 f8 70             	cmp    $0x70,%eax
 6b0:	0f 84 aa 00 00 00    	je     760 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6b6:	83 fa 73             	cmp    $0x73,%edx
 6b9:	0f 84 e9 00 00 00    	je     7a8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6bf:	83 fa 63             	cmp    $0x63,%edx
 6c2:	0f 84 2b 01 00 00    	je     7f3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6c8:	83 fa 25             	cmp    $0x25,%edx
 6cb:	0f 84 4f 01 00 00    	je     820 <printf+0x1f0>
  write(fd, &c, 1);
 6d1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6d4:	83 c3 01             	add    $0x1,%ebx
 6d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6de:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6df:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 6e1:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e5:	89 34 24             	mov    %esi,(%esp)
 6e8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 6eb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 6ef:	e8 de fd ff ff       	call   4d2 <write>
        putc(fd, c);
 6f4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 6f7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 701:	00 
 702:	89 44 24 04          	mov    %eax,0x4(%esp)
 706:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 709:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 70c:	e8 c1 fd ff ff       	call   4d2 <write>
  for(i = 0; fmt[i]; i++){
 711:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 715:	84 d2                	test   %dl,%dl
 717:	0f 85 6d ff ff ff    	jne    68a <printf+0x5a>
 71d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 720:	83 c4 3c             	add    $0x3c,%esp
 723:	5b                   	pop    %ebx
 724:	5e                   	pop    %esi
 725:	5f                   	pop    %edi
 726:	5d                   	pop    %ebp
 727:	c3                   	ret    
        state = '%';
 728:	bf 25 00 00 00       	mov    $0x25,%edi
 72d:	e9 49 ff ff ff       	jmp    67b <printf+0x4b>
 732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 738:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 73f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 744:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 747:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 749:	8b 10                	mov    (%eax),%edx
 74b:	89 f0                	mov    %esi,%eax
 74d:	e8 3e fe ff ff       	call   590 <printint>
        ap++;
 752:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 756:	e9 20 ff ff ff       	jmp    67b <printf+0x4b>
 75b:	90                   	nop
 75c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 760:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 763:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 76a:	00 
 76b:	89 44 24 04          	mov    %eax,0x4(%esp)
 76f:	89 34 24             	mov    %esi,(%esp)
 772:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 776:	e8 57 fd ff ff       	call   4d2 <write>
 77b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 77e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 785:	00 
 786:	89 44 24 04          	mov    %eax,0x4(%esp)
 78a:	89 34 24             	mov    %esi,(%esp)
 78d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 791:	e8 3c fd ff ff       	call   4d2 <write>
        printint(fd, *ap, 16, 0);
 796:	b9 10 00 00 00       	mov    $0x10,%ecx
 79b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 7a2:	eb a0                	jmp    744 <printf+0x114>
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 7a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 7ab:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 7af:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 7b1:	b8 0f 0b 00 00       	mov    $0xb0f,%eax
 7b6:	85 ff                	test   %edi,%edi
 7b8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 7bb:	0f b6 07             	movzbl (%edi),%eax
 7be:	84 c0                	test   %al,%al
 7c0:	74 2a                	je     7ec <printf+0x1bc>
 7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7c8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 7cb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 7ce:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 7d1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7d8:	00 
 7d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 7dd:	89 34 24             	mov    %esi,(%esp)
 7e0:	e8 ed fc ff ff       	call   4d2 <write>
        while(*s != 0){
 7e5:	0f b6 07             	movzbl (%edi),%eax
 7e8:	84 c0                	test   %al,%al
 7ea:	75 dc                	jne    7c8 <printf+0x198>
      state = 0;
 7ec:	31 ff                	xor    %edi,%edi
 7ee:	e9 88 fe ff ff       	jmp    67b <printf+0x4b>
        putc(fd, *ap);
 7f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 7f6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 7f8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 7fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 801:	00 
 802:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 805:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 808:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 80b:	89 44 24 04          	mov    %eax,0x4(%esp)
 80f:	e8 be fc ff ff       	call   4d2 <write>
        ap++;
 814:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 818:	e9 5e fe ff ff       	jmp    67b <printf+0x4b>
 81d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 820:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 823:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 825:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 82c:	00 
 82d:	89 44 24 04          	mov    %eax,0x4(%esp)
 831:	89 34 24             	mov    %esi,(%esp)
 834:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 838:	e8 95 fc ff ff       	call   4d2 <write>
 83d:	e9 39 fe ff ff       	jmp    67b <printf+0x4b>
 842:	66 90                	xchg   %ax,%ax
 844:	66 90                	xchg   %ax,%ax
 846:	66 90                	xchg   %ax,%ax
 848:	66 90                	xchg   %ax,%ax
 84a:	66 90                	xchg   %ax,%ax
 84c:	66 90                	xchg   %ax,%ax
 84e:	66 90                	xchg   %ax,%ax

00000850 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 850:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 851:	a1 90 0f 00 00       	mov    0xf90,%eax
{
 856:	89 e5                	mov    %esp,%ebp
 858:	57                   	push   %edi
 859:	56                   	push   %esi
 85a:	53                   	push   %ebx
 85b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 85e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 860:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 863:	39 d0                	cmp    %edx,%eax
 865:	72 11                	jb     878 <free+0x28>
 867:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 868:	39 c8                	cmp    %ecx,%eax
 86a:	72 04                	jb     870 <free+0x20>
 86c:	39 ca                	cmp    %ecx,%edx
 86e:	72 10                	jb     880 <free+0x30>
 870:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 872:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 874:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 876:	73 f0                	jae    868 <free+0x18>
 878:	39 ca                	cmp    %ecx,%edx
 87a:	72 04                	jb     880 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 87c:	39 c8                	cmp    %ecx,%eax
 87e:	72 f0                	jb     870 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 880:	8b 73 fc             	mov    -0x4(%ebx),%esi
 883:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 886:	39 cf                	cmp    %ecx,%edi
 888:	74 1e                	je     8a8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 88a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 88d:	8b 48 04             	mov    0x4(%eax),%ecx
 890:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 893:	39 f2                	cmp    %esi,%edx
 895:	74 28                	je     8bf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 897:	89 10                	mov    %edx,(%eax)
  freep = p;
 899:	a3 90 0f 00 00       	mov    %eax,0xf90
}
 89e:	5b                   	pop    %ebx
 89f:	5e                   	pop    %esi
 8a0:	5f                   	pop    %edi
 8a1:	5d                   	pop    %ebp
 8a2:	c3                   	ret    
 8a3:	90                   	nop
 8a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 8a8:	03 71 04             	add    0x4(%ecx),%esi
 8ab:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ae:	8b 08                	mov    (%eax),%ecx
 8b0:	8b 09                	mov    (%ecx),%ecx
 8b2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 8b5:	8b 48 04             	mov    0x4(%eax),%ecx
 8b8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 8bb:	39 f2                	cmp    %esi,%edx
 8bd:	75 d8                	jne    897 <free+0x47>
    p->s.size += bp->s.size;
 8bf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 8c2:	a3 90 0f 00 00       	mov    %eax,0xf90
    p->s.size += bp->s.size;
 8c7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 8ca:	8b 53 f8             	mov    -0x8(%ebx),%edx
 8cd:	89 10                	mov    %edx,(%eax)
}
 8cf:	5b                   	pop    %ebx
 8d0:	5e                   	pop    %esi
 8d1:	5f                   	pop    %edi
 8d2:	5d                   	pop    %ebp
 8d3:	c3                   	ret    
 8d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000008e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	56                   	push   %esi
 8e5:	53                   	push   %ebx
 8e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 8ec:	8b 1d 90 0f 00 00    	mov    0xf90,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8f2:	8d 48 07             	lea    0x7(%eax),%ecx
 8f5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 8f8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 8fd:	0f 84 9b 00 00 00    	je     99e <malloc+0xbe>
 903:	8b 13                	mov    (%ebx),%edx
 905:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 908:	39 fe                	cmp    %edi,%esi
 90a:	76 64                	jbe    970 <malloc+0x90>
 90c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 913:	bb 00 80 00 00       	mov    $0x8000,%ebx
 918:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 91b:	eb 0e                	jmp    92b <malloc+0x4b>
 91d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 920:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 922:	8b 78 04             	mov    0x4(%eax),%edi
 925:	39 fe                	cmp    %edi,%esi
 927:	76 4f                	jbe    978 <malloc+0x98>
 929:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 92b:	3b 15 90 0f 00 00    	cmp    0xf90,%edx
 931:	75 ed                	jne    920 <malloc+0x40>
  if(nu < 4096)
 933:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 936:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 93c:	bf 00 10 00 00       	mov    $0x1000,%edi
 941:	0f 43 fe             	cmovae %esi,%edi
 944:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 947:	89 04 24             	mov    %eax,(%esp)
 94a:	e8 eb fb ff ff       	call   53a <sbrk>
  if(p == (char*)-1)
 94f:	83 f8 ff             	cmp    $0xffffffff,%eax
 952:	74 18                	je     96c <malloc+0x8c>
  hp->s.size = nu;
 954:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 957:	83 c0 08             	add    $0x8,%eax
 95a:	89 04 24             	mov    %eax,(%esp)
 95d:	e8 ee fe ff ff       	call   850 <free>
  return freep;
 962:	8b 15 90 0f 00 00    	mov    0xf90,%edx
      if((p = morecore(nunits)) == 0)
 968:	85 d2                	test   %edx,%edx
 96a:	75 b4                	jne    920 <malloc+0x40>
        return 0;
 96c:	31 c0                	xor    %eax,%eax
 96e:	eb 20                	jmp    990 <malloc+0xb0>
    if(p->s.size >= nunits){
 970:	89 d0                	mov    %edx,%eax
 972:	89 da                	mov    %ebx,%edx
 974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 978:	39 fe                	cmp    %edi,%esi
 97a:	74 1c                	je     998 <malloc+0xb8>
        p->s.size -= nunits;
 97c:	29 f7                	sub    %esi,%edi
 97e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 981:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 984:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 987:	89 15 90 0f 00 00    	mov    %edx,0xf90
      return (void*)(p + 1);
 98d:	83 c0 08             	add    $0x8,%eax
  }
}
 990:	83 c4 1c             	add    $0x1c,%esp
 993:	5b                   	pop    %ebx
 994:	5e                   	pop    %esi
 995:	5f                   	pop    %edi
 996:	5d                   	pop    %ebp
 997:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 998:	8b 08                	mov    (%eax),%ecx
 99a:	89 0a                	mov    %ecx,(%edx)
 99c:	eb e9                	jmp    987 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 99e:	c7 05 90 0f 00 00 94 	movl   $0xf94,0xf90
 9a5:	0f 00 00 
    base.s.size = 0;
 9a8:	ba 94 0f 00 00       	mov    $0xf94,%edx
    base.s.ptr = freep = prevp = &base;
 9ad:	c7 05 94 0f 00 00 94 	movl   $0xf94,0xf94
 9b4:	0f 00 00 
    base.s.size = 0;
 9b7:	c7 05 98 0f 00 00 00 	movl   $0x0,0xf98
 9be:	00 00 00 
 9c1:	e9 46 ff ff ff       	jmp    90c <malloc+0x2c>
 9c6:	66 90                	xchg   %ax,%ax
 9c8:	66 90                	xchg   %ax,%ax
 9ca:	66 90                	xchg   %ax,%ax
 9cc:	66 90                	xchg   %ax,%ax
 9ce:	66 90                	xchg   %ax,%ax

000009d0 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	53                   	push   %ebx
 9d4:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 9d7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 9de:	e8 fd fe ff ff       	call   8e0 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 9e3:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 9ea:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 9ec:	e8 ef fe ff ff       	call   8e0 <malloc>
    if (tstack == NULL) {
 9f1:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 9f3:	89 c2                	mov    %eax,%edx
 9f5:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 9f8:	0f 84 8a 00 00 00    	je     a88 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 9fe:	25 ff 0f 00 00       	and    $0xfff,%eax
 a03:	75 73                	jne    a78 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 a05:	8b 45 10             	mov    0x10(%ebp),%eax
 a08:	89 54 24 08          	mov    %edx,0x8(%esp)
 a0c:	89 44 24 04          	mov    %eax,0x4(%esp)
 a10:	8b 45 0c             	mov    0xc(%ebp),%eax
 a13:	89 04 24             	mov    %eax,(%esp)
 a16:	e8 57 fb ff ff       	call   572 <kthread_create>
 a1b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 a1d:	89 44 24 10          	mov    %eax,0x10(%esp)
 a21:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 a28:	00 
 a29:	c7 44 24 08 27 0b 00 	movl   $0xb27,0x8(%esp)
 a30:	00 
 a31:	c7 44 24 04 36 0b 00 	movl   $0xb36,0x4(%esp)
 a38:	00 
 a39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a40:	e8 eb fb ff ff       	call   630 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 a45:	8b 03                	mov    (%ebx),%eax
 a47:	c7 44 24 04 4d 0b 00 	movl   $0xb4d,0x4(%esp)
 a4e:	00 
 a4f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a56:	89 44 24 08          	mov    %eax,0x8(%esp)
 a5a:	e8 d1 fb ff ff       	call   630 <printf>
    
    if (bt->tid != 0) {
 a5f:	8b 03                	mov    (%ebx),%eax
 a61:	85 c0                	test   %eax,%eax
 a63:	74 23                	je     a88 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 a65:	8b 45 08             	mov    0x8(%ebp),%eax
 a68:	89 18                	mov    %ebx,(%eax)
        return 0;
 a6a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 a6c:	83 c4 24             	add    $0x24,%esp
 a6f:	5b                   	pop    %ebx
 a70:	5d                   	pop    %ebp
 a71:	c3                   	ret    
 a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 a78:	29 c2                	sub    %eax,%edx
 a7a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 a80:	eb 83                	jmp    a05 <benny_thread_create+0x35>
 a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 a88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a8d:	eb dd                	jmp    a6c <benny_thread_create+0x9c>
 a8f:	90                   	nop

00000a90 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 a93:	8b 45 08             	mov    0x8(%ebp),%eax
}
 a96:	5d                   	pop    %ebp
    return bt->tid;
 a97:	8b 00                	mov    (%eax),%eax
}
 a99:	c3                   	ret    
 a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000aa0 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 aa0:	55                   	push   %ebp
 aa1:	89 e5                	mov    %esp,%ebp
 aa3:	53                   	push   %ebx
 aa4:	83 ec 14             	sub    $0x14,%esp
 aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 aaa:	8b 03                	mov    (%ebx),%eax
 aac:	89 04 24             	mov    %eax,(%esp)
 aaf:	e8 c6 fa ff ff       	call   57a <kthread_join>
    if (retVal == 0) {
 ab4:	85 c0                	test   %eax,%eax
 ab6:	75 11                	jne    ac9 <benny_thread_join+0x29>
        free(bt->tstack);
 ab8:	8b 53 04             	mov    0x4(%ebx),%edx
 abb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 abe:	89 14 24             	mov    %edx,(%esp)
 ac1:	e8 8a fd ff ff       	call   850 <free>
 ac6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 ac9:	83 c4 14             	add    $0x14,%esp
 acc:	5b                   	pop    %ebx
 acd:	5d                   	pop    %ebp
 ace:	c3                   	ret    
 acf:	90                   	nop

00000ad0 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 ad0:	55                   	push   %ebp
 ad1:	89 e5                	mov    %esp,%ebp
 ad3:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 ad6:	8b 45 08             	mov    0x8(%ebp),%eax
 ad9:	89 04 24             	mov    %eax,(%esp)
 adc:	e8 a1 fa ff ff       	call   582 <kthread_exit>
    return 0;
}
 ae1:	31 c0                	xor    %eax,%eax
 ae3:	c9                   	leave  
 ae4:	c3                   	ret    
