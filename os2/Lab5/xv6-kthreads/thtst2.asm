
_thtst2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}
#endif // KTHREADS

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 70             	sub    $0x70,%esp
#ifdef KTHREADS
    benny_thread_t bt[MAX_THREADS];
    long i = -1;
    long num_threads = DEFAULT_NUM_THREADS;

    printf(1, "%s %d: %p %p\n", __FILE__, __LINE__, main, &argc);
   c:	8d 45 08             	lea    0x8(%ebp),%eax
   f:	89 44 24 14          	mov    %eax,0x14(%esp)
  13:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1a:	00 
  1b:	c7 44 24 0c 32 00 00 	movl   $0x32,0xc(%esp)
  22:	00 
  23:	c7 44 24 08 5b 0a 00 	movl   $0xa5b,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 64 0a 00 	movl   $0xa64,0x4(%esp)
  32:	00 
  33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3a:	e8 51 05 00 00       	call   590 <printf>
    if (argc > 1) {
  3f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  43:	0f 8e f7 00 00 00    	jle    140 <main+0x140>
        num_threads = atoi(argv[1]);
  49:	8b 45 0c             	mov    0xc(%ebp),%eax
  4c:	8b 40 04             	mov    0x4(%eax),%eax
  4f:	89 04 24             	mov    %eax,(%esp)
  52:	e8 59 03 00 00       	call   3b0 <atoi>
  57:	89 c6                	mov    %eax,%esi
        if (num_threads < 1 || num_threads > MAX_THREADS) {
  59:	8d 40 ff             	lea    -0x1(%eax),%eax
  5c:	83 f8 13             	cmp    $0x13,%eax
  5f:	0f 87 db 00 00 00    	ja     140 <main+0x140>
            num_threads = DEFAULT_NUM_THREADS;
        }
    }
    printf(1, "Starting %d threads\n", num_threads);
  65:	89 74 24 08          	mov    %esi,0x8(%esp)
  69:	8d 7c 24 20          	lea    0x20(%esp),%edi
    
    // spin up all the threads
    for (i = 0; i < num_threads; i++) {
  6d:	31 db                	xor    %ebx,%ebx
    printf(1, "Starting %d threads\n", num_threads);
  6f:	c7 44 24 04 72 0a 00 	movl   $0xa72,0x4(%esp)
  76:	00 
  77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7e:	e8 0d 05 00 00       	call   590 <printf>
  83:	90                   	nop
  84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        benny_thread_create(&(bt[i]), func1, (void *) i);
  88:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    for (i = 0; i < num_threads; i++) {
  8c:	83 c3 01             	add    $0x1,%ebx
        benny_thread_create(&(bt[i]), func1, (void *) i);
  8f:	89 3c 24             	mov    %edi,(%esp)
  92:	83 c7 04             	add    $0x4,%edi
  95:	c7 44 24 04 50 01 00 	movl   $0x150,0x4(%esp)
  9c:	00 
  9d:	e8 8e 08 00 00       	call   930 <benny_thread_create>
        printf(1, "%s %d: %d\n", __FILE__, __LINE__, benny_thread_tid(bt[i]));
  a2:	8b 47 fc             	mov    -0x4(%edi),%eax
  a5:	89 04 24             	mov    %eax,(%esp)
  a8:	e8 43 09 00 00       	call   9f0 <benny_thread_tid>
  ad:	c7 44 24 0c 3e 00 00 	movl   $0x3e,0xc(%esp)
  b4:	00 
  b5:	c7 44 24 08 5b 0a 00 	movl   $0xa5b,0x8(%esp)
  bc:	00 
  bd:	c7 44 24 04 87 0a 00 	movl   $0xa87,0x4(%esp)
  c4:	00 
  c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cc:	89 44 24 10          	mov    %eax,0x10(%esp)
  d0:	e8 bb 04 00 00       	call   590 <printf>
    for (i = 0; i < num_threads; i++) {
  d5:	39 de                	cmp    %ebx,%esi
  d7:	7f af                	jg     88 <main+0x88>
  d9:	31 db                	xor    %ebx,%ebx
  db:	90                   	nop
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }

    // join back with the threads
    for (i = 0; i < num_threads; i++) {
        printf(1, "%s %d: joining with %d\n", __FILE__, __LINE__, benny_thread_tid(bt[i]));
  e0:	8b 44 9c 20          	mov    0x20(%esp,%ebx,4),%eax
  e4:	89 04 24             	mov    %eax,(%esp)
  e7:	e8 04 09 00 00       	call   9f0 <benny_thread_tid>
  ec:	c7 44 24 0c 43 00 00 	movl   $0x43,0xc(%esp)
  f3:	00 
  f4:	c7 44 24 08 5b 0a 00 	movl   $0xa5b,0x8(%esp)
  fb:	00 
  fc:	c7 44 24 04 92 0a 00 	movl   $0xa92,0x4(%esp)
 103:	00 
 104:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 10b:	89 44 24 10          	mov    %eax,0x10(%esp)
 10f:	e8 7c 04 00 00       	call   590 <printf>
        benny_thread_join(bt[i]);
 114:	8b 44 9c 20          	mov    0x20(%esp,%ebx,4),%eax
    for (i = 0; i < num_threads; i++) {
 118:	83 c3 01             	add    $0x1,%ebx
        benny_thread_join(bt[i]);
 11b:	89 04 24             	mov    %eax,(%esp)
 11e:	e8 dd 08 00 00       	call   a00 <benny_thread_join>
    for (i = 0; i < num_threads; i++) {
 123:	39 de                	cmp    %ebx,%esi
 125:	7f b9                	jg     e0 <main+0xe0>
    }

    printf(1, "All threads joined\n");
 127:	c7 44 24 04 aa 0a 00 	movl   $0xaaa,0x4(%esp)
 12e:	00 
 12f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 136:	e8 55 04 00 00       	call   590 <printf>
#endif // KTHREADS

    exit();
 13b:	e8 d2 02 00 00       	call   412 <exit>
    long num_threads = DEFAULT_NUM_THREADS;
 140:	be 02 00 00 00       	mov    $0x2,%esi
 145:	e9 1b ff ff ff       	jmp    65 <main+0x65>
 14a:	66 90                	xchg   %ax,%ax
 14c:	66 90                	xchg   %ax,%ax
 14e:	66 90                	xchg   %ax,%ax

00000150 <func1>:
{
 150:	55                   	push   %ebp
        if ((sum % (MAXSHORT * MAXSHORT)) == 0) {
 151:	b9 03 00 ff 3f       	mov    $0x3fff0003,%ecx
{
 156:	89 e5                	mov    %esp,%ebp
 158:	57                   	push   %edi
            sum = 0;
 159:	31 ff                	xor    %edi,%edi
{
 15b:	56                   	push   %esi
    long arg = ((long) arg_ptr);
 15c:	be fe ff ff 7f       	mov    $0x7ffffffe,%esi
{
 161:	53                   	push   %ebx
        sum ++;
 162:	bb 02 00 00 00       	mov    $0x2,%ebx
{
 167:	83 ec 2c             	sub    $0x2c,%esp
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
 16d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            sum = 0;
 170:	81 fb 00 00 00 40    	cmp    $0x40000000,%ebx
 176:	0f 43 df             	cmovae %edi,%ebx
    for(i = 1; i < max; i++) {
 179:	83 ee 01             	sub    $0x1,%esi
 17c:	74 53                	je     1d1 <func1+0x81>
        sum ++;
 17e:	83 c3 01             	add    $0x1,%ebx
        if ((sum % (MAXSHORT * MAXSHORT)) == 0) {
 181:	89 d8                	mov    %ebx,%eax
 183:	f7 e1                	mul    %ecx
 185:	c1 ea 1c             	shr    $0x1c,%edx
 188:	69 d2 01 00 01 40    	imul   $0x40010001,%edx,%edx
 18e:	39 d3                	cmp    %edx,%ebx
 190:	75 de                	jne    170 <func1+0x20>
            sum += arg;
 192:	03 5d e4             	add    -0x1c(%ebp),%ebx
 195:	89 4d e0             	mov    %ecx,-0x20(%ebp)
            printf(1, "\t%d  thtst2: %d  %d\n\n", arg, getpid(), sum);
 198:	e8 f5 02 00 00       	call   492 <getpid>
 19d:	89 5c 24 10          	mov    %ebx,0x10(%esp)
 1a1:	c7 44 24 04 45 0a 00 	movl   $0xa45,0x4(%esp)
 1a8:	00 
 1a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1b0:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1b4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1b7:	89 44 24 08          	mov    %eax,0x8(%esp)
 1bb:	e8 d0 03 00 00       	call   590 <printf>
            sum = 0;
 1c0:	81 fb 00 00 00 40    	cmp    $0x40000000,%ebx
            printf(1, "\t%d  thtst2: %d  %d\n\n", arg, getpid(), sum);
 1c6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
            sum = 0;
 1c9:	0f 43 df             	cmovae %edi,%ebx
    for(i = 1; i < max; i++) {
 1cc:	83 ee 01             	sub    $0x1,%esi
 1cf:	75 ad                	jne    17e <func1+0x2e>
    benny_thread_exit(7);
 1d1:	c7 45 08 07 00 00 00 	movl   $0x7,0x8(%ebp)
}
 1d8:	83 c4 2c             	add    $0x2c,%esp
 1db:	5b                   	pop    %ebx
 1dc:	5e                   	pop    %esi
 1dd:	5f                   	pop    %edi
 1de:	5d                   	pop    %ebp
    benny_thread_exit(7);
 1df:	e9 4c 08 00 00       	jmp    a30 <benny_thread_exit>
 1e4:	66 90                	xchg   %ax,%ax
 1e6:	66 90                	xchg   %ax,%ax
 1e8:	66 90                	xchg   %ax,%ax
 1ea:	66 90                	xchg   %ax,%ax
 1ec:	66 90                	xchg   %ax,%ax
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1f9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1fa:	89 c2                	mov    %eax,%edx
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 200:	83 c1 01             	add    $0x1,%ecx
 203:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 207:	83 c2 01             	add    $0x1,%edx
 20a:	84 db                	test   %bl,%bl
 20c:	88 5a ff             	mov    %bl,-0x1(%edx)
 20f:	75 ef                	jne    200 <strcpy+0x10>
    ;
  return os;
}
 211:	5b                   	pop    %ebx
 212:	5d                   	pop    %ebp
 213:	c3                   	ret    
 214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 21a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000220 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 55 08             	mov    0x8(%ebp),%edx
 226:	53                   	push   %ebx
 227:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 22a:	0f b6 02             	movzbl (%edx),%eax
 22d:	84 c0                	test   %al,%al
 22f:	74 2d                	je     25e <strcmp+0x3e>
 231:	0f b6 19             	movzbl (%ecx),%ebx
 234:	38 d8                	cmp    %bl,%al
 236:	74 0e                	je     246 <strcmp+0x26>
 238:	eb 2b                	jmp    265 <strcmp+0x45>
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 240:	38 c8                	cmp    %cl,%al
 242:	75 15                	jne    259 <strcmp+0x39>
    p++, q++;
 244:	89 d9                	mov    %ebx,%ecx
 246:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 249:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 24c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 24f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 253:	84 c0                	test   %al,%al
 255:	75 e9                	jne    240 <strcmp+0x20>
 257:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 259:	29 c8                	sub    %ecx,%eax
}
 25b:	5b                   	pop    %ebx
 25c:	5d                   	pop    %ebp
 25d:	c3                   	ret    
 25e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 261:	31 c0                	xor    %eax,%eax
 263:	eb f4                	jmp    259 <strcmp+0x39>
 265:	0f b6 cb             	movzbl %bl,%ecx
 268:	eb ef                	jmp    259 <strcmp+0x39>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000270 <strlen>:

uint
strlen(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 276:	80 39 00             	cmpb   $0x0,(%ecx)
 279:	74 12                	je     28d <strlen+0x1d>
 27b:	31 d2                	xor    %edx,%edx
 27d:	8d 76 00             	lea    0x0(%esi),%esi
 280:	83 c2 01             	add    $0x1,%edx
 283:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 287:	89 d0                	mov    %edx,%eax
 289:	75 f5                	jne    280 <strlen+0x10>
    ;
  return n;
}
 28b:	5d                   	pop    %ebp
 28c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 28d:	31 c0                	xor    %eax,%eax
}
 28f:	5d                   	pop    %ebp
 290:	c3                   	ret    
 291:	eb 0d                	jmp    2a0 <memset>
 293:	90                   	nop
 294:	90                   	nop
 295:	90                   	nop
 296:	90                   	nop
 297:	90                   	nop
 298:	90                   	nop
 299:	90                   	nop
 29a:	90                   	nop
 29b:	90                   	nop
 29c:	90                   	nop
 29d:	90                   	nop
 29e:	90                   	nop
 29f:	90                   	nop

000002a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 55 08             	mov    0x8(%ebp),%edx
 2a6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 d7                	mov    %edx,%edi
 2af:	fc                   	cld    
 2b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2b2:	89 d0                	mov    %edx,%eax
 2b4:	5f                   	pop    %edi
 2b5:	5d                   	pop    %ebp
 2b6:	c3                   	ret    
 2b7:	89 f6                	mov    %esi,%esi
 2b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002c0 <strchr>:

char*
strchr(const char *s, char c)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	53                   	push   %ebx
 2c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 2ca:	0f b6 18             	movzbl (%eax),%ebx
 2cd:	84 db                	test   %bl,%bl
 2cf:	74 1d                	je     2ee <strchr+0x2e>
    if(*s == c)
 2d1:	38 d3                	cmp    %dl,%bl
 2d3:	89 d1                	mov    %edx,%ecx
 2d5:	75 0d                	jne    2e4 <strchr+0x24>
 2d7:	eb 17                	jmp    2f0 <strchr+0x30>
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2e0:	38 ca                	cmp    %cl,%dl
 2e2:	74 0c                	je     2f0 <strchr+0x30>
  for(; *s; s++)
 2e4:	83 c0 01             	add    $0x1,%eax
 2e7:	0f b6 10             	movzbl (%eax),%edx
 2ea:	84 d2                	test   %dl,%dl
 2ec:	75 f2                	jne    2e0 <strchr+0x20>
      return (char*)s;
  return 0;
 2ee:	31 c0                	xor    %eax,%eax
}
 2f0:	5b                   	pop    %ebx
 2f1:	5d                   	pop    %ebp
 2f2:	c3                   	ret    
 2f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <gets>:

char*
gets(char *buf, int max)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 305:	31 f6                	xor    %esi,%esi
{
 307:	53                   	push   %ebx
 308:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 30b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 30e:	eb 31                	jmp    341 <gets+0x41>
    cc = read(0, &c, 1);
 310:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 317:	00 
 318:	89 7c 24 04          	mov    %edi,0x4(%esp)
 31c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 323:	e8 02 01 00 00       	call   42a <read>
    if(cc < 1)
 328:	85 c0                	test   %eax,%eax
 32a:	7e 1d                	jle    349 <gets+0x49>
      break;
    buf[i++] = c;
 32c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 330:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 332:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 335:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 337:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 33b:	74 0c                	je     349 <gets+0x49>
 33d:	3c 0a                	cmp    $0xa,%al
 33f:	74 08                	je     349 <gets+0x49>
  for(i=0; i+1 < max; ){
 341:	8d 5e 01             	lea    0x1(%esi),%ebx
 344:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 347:	7c c7                	jl     310 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 349:	8b 45 08             	mov    0x8(%ebp),%eax
 34c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 350:	83 c4 2c             	add    $0x2c,%esp
 353:	5b                   	pop    %ebx
 354:	5e                   	pop    %esi
 355:	5f                   	pop    %edi
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <stat>:

int
stat(const char *n, struct stat *st)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 372:	00 
 373:	89 04 24             	mov    %eax,(%esp)
 376:	e8 d7 00 00 00       	call   452 <open>
  if(fd < 0)
 37b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 37d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 37f:	78 27                	js     3a8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 381:	8b 45 0c             	mov    0xc(%ebp),%eax
 384:	89 1c 24             	mov    %ebx,(%esp)
 387:	89 44 24 04          	mov    %eax,0x4(%esp)
 38b:	e8 da 00 00 00       	call   46a <fstat>
  close(fd);
 390:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 393:	89 c6                	mov    %eax,%esi
  close(fd);
 395:	e8 a0 00 00 00       	call   43a <close>
  return r;
 39a:	89 f0                	mov    %esi,%eax
}
 39c:	83 c4 10             	add    $0x10,%esp
 39f:	5b                   	pop    %ebx
 3a0:	5e                   	pop    %esi
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
 3a3:	90                   	nop
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 3a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3ad:	eb ed                	jmp    39c <stat+0x3c>
 3af:	90                   	nop

000003b0 <atoi>:

int
atoi(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3b6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b7:	0f be 11             	movsbl (%ecx),%edx
 3ba:	8d 42 d0             	lea    -0x30(%edx),%eax
 3bd:	3c 09                	cmp    $0x9,%al
  n = 0;
 3bf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 3c4:	77 17                	ja     3dd <atoi+0x2d>
 3c6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 3c8:	83 c1 01             	add    $0x1,%ecx
 3cb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3ce:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3d2:	0f be 11             	movsbl (%ecx),%edx
 3d5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3d8:	80 fb 09             	cmp    $0x9,%bl
 3db:	76 eb                	jbe    3c8 <atoi+0x18>
  return n;
}
 3dd:	5b                   	pop    %ebx
 3de:	5d                   	pop    %ebp
 3df:	c3                   	ret    

000003e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3e1:	31 d2                	xor    %edx,%edx
{
 3e3:	89 e5                	mov    %esp,%ebp
 3e5:	56                   	push   %esi
 3e6:	8b 45 08             	mov    0x8(%ebp),%eax
 3e9:	53                   	push   %ebx
 3ea:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ed:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 3f0:	85 db                	test   %ebx,%ebx
 3f2:	7e 12                	jle    406 <memmove+0x26>
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3f8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3ff:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 402:	39 da                	cmp    %ebx,%edx
 404:	75 f2                	jne    3f8 <memmove+0x18>
  return vdst;
}
 406:	5b                   	pop    %ebx
 407:	5e                   	pop    %esi
 408:	5d                   	pop    %ebp
 409:	c3                   	ret    

0000040a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 40a:	b8 01 00 00 00       	mov    $0x1,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <exit>:
SYSCALL(exit)
 412:	b8 02 00 00 00       	mov    $0x2,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <wait>:
SYSCALL(wait)
 41a:	b8 03 00 00 00       	mov    $0x3,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <pipe>:
SYSCALL(pipe)
 422:	b8 04 00 00 00       	mov    $0x4,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <read>:
SYSCALL(read)
 42a:	b8 05 00 00 00       	mov    $0x5,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <write>:
SYSCALL(write)
 432:	b8 10 00 00 00       	mov    $0x10,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <close>:
SYSCALL(close)
 43a:	b8 15 00 00 00       	mov    $0x15,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <kill>:
SYSCALL(kill)
 442:	b8 06 00 00 00       	mov    $0x6,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <exec>:
SYSCALL(exec)
 44a:	b8 07 00 00 00       	mov    $0x7,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <open>:
SYSCALL(open)
 452:	b8 0f 00 00 00       	mov    $0xf,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <mknod>:
SYSCALL(mknod)
 45a:	b8 11 00 00 00       	mov    $0x11,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <unlink>:
SYSCALL(unlink)
 462:	b8 12 00 00 00       	mov    $0x12,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <fstat>:
SYSCALL(fstat)
 46a:	b8 08 00 00 00       	mov    $0x8,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <link>:
SYSCALL(link)
 472:	b8 13 00 00 00       	mov    $0x13,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <mkdir>:
SYSCALL(mkdir)
 47a:	b8 14 00 00 00       	mov    $0x14,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <chdir>:
SYSCALL(chdir)
 482:	b8 09 00 00 00       	mov    $0x9,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <dup>:
SYSCALL(dup)
 48a:	b8 0a 00 00 00       	mov    $0xa,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <getpid>:
SYSCALL(getpid)
 492:	b8 0b 00 00 00       	mov    $0xb,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <sbrk>:
SYSCALL(sbrk)
 49a:	b8 0c 00 00 00       	mov    $0xc,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <sleep>:
SYSCALL(sleep)
 4a2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <uptime>:
SYSCALL(uptime)
 4aa:	b8 0e 00 00 00       	mov    $0xe,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 4b2:	b8 16 00 00 00       	mov    $0x16,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 4ba:	b8 17 00 00 00       	mov    $0x17,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 4c2:	b8 18 00 00 00       	mov    $0x18,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <halt>:
SYSCALL(halt)
 4ca:	b8 19 00 00 00       	mov    $0x19,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 4d2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <kthread_join>:
SYSCALL(kthread_join)
 4da:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <kthread_exit>:
SYSCALL(kthread_exit)
 4e2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    
 4ea:	66 90                	xchg   %ax,%ax
 4ec:	66 90                	xchg   %ax,%ax
 4ee:	66 90                	xchg   %ax,%ax

000004f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	89 c6                	mov    %eax,%esi
 4f7:	53                   	push   %ebx
 4f8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4fe:	85 db                	test   %ebx,%ebx
 500:	74 09                	je     50b <printint+0x1b>
 502:	89 d0                	mov    %edx,%eax
 504:	c1 e8 1f             	shr    $0x1f,%eax
 507:	84 c0                	test   %al,%al
 509:	75 75                	jne    580 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 50b:	89 d0                	mov    %edx,%eax
  neg = 0;
 50d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 514:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 517:	31 ff                	xor    %edi,%edi
 519:	89 ce                	mov    %ecx,%esi
 51b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 51e:	eb 02                	jmp    522 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 520:	89 cf                	mov    %ecx,%edi
 522:	31 d2                	xor    %edx,%edx
 524:	f7 f6                	div    %esi
 526:	8d 4f 01             	lea    0x1(%edi),%ecx
 529:	0f b6 92 c5 0a 00 00 	movzbl 0xac5(%edx),%edx
  }while((x /= base) != 0);
 530:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 532:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 535:	75 e9                	jne    520 <printint+0x30>
  if(neg)
 537:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 53a:	89 c8                	mov    %ecx,%eax
 53c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 53f:	85 d2                	test   %edx,%edx
 541:	74 08                	je     54b <printint+0x5b>
    buf[i++] = '-';
 543:	8d 4f 02             	lea    0x2(%edi),%ecx
 546:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 54b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 54e:	66 90                	xchg   %ax,%ax
 550:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 555:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 558:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 55f:	00 
 560:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 564:	89 34 24             	mov    %esi,(%esp)
 567:	88 45 d7             	mov    %al,-0x29(%ebp)
 56a:	e8 c3 fe ff ff       	call   432 <write>
  while(--i >= 0)
 56f:	83 ff ff             	cmp    $0xffffffff,%edi
 572:	75 dc                	jne    550 <printint+0x60>
    putc(fd, buf[i]);
}
 574:	83 c4 4c             	add    $0x4c,%esp
 577:	5b                   	pop    %ebx
 578:	5e                   	pop    %esi
 579:	5f                   	pop    %edi
 57a:	5d                   	pop    %ebp
 57b:	c3                   	ret    
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 580:	89 d0                	mov    %edx,%eax
 582:	f7 d8                	neg    %eax
    neg = 1;
 584:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 58b:	eb 87                	jmp    514 <printint+0x24>
 58d:	8d 76 00             	lea    0x0(%esi),%esi

00000590 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 594:	31 ff                	xor    %edi,%edi
{
 596:	56                   	push   %esi
 597:	53                   	push   %ebx
 598:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 59b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 59e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 5a1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 5a4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5a7:	0f b6 13             	movzbl (%ebx),%edx
 5aa:	83 c3 01             	add    $0x1,%ebx
 5ad:	84 d2                	test   %dl,%dl
 5af:	75 39                	jne    5ea <printf+0x5a>
 5b1:	e9 ca 00 00 00       	jmp    680 <printf+0xf0>
 5b6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5b8:	83 fa 25             	cmp    $0x25,%edx
 5bb:	0f 84 c7 00 00 00    	je     688 <printf+0xf8>
  write(fd, &c, 1);
 5c1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5c4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5cb:	00 
 5cc:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 5d3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 5d6:	e8 57 fe ff ff       	call   432 <write>
 5db:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 5de:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5e2:	84 d2                	test   %dl,%dl
 5e4:	0f 84 96 00 00 00    	je     680 <printf+0xf0>
    if(state == 0){
 5ea:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 5ec:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 5ef:	74 c7                	je     5b8 <printf+0x28>
      }
    } else if(state == '%'){
 5f1:	83 ff 25             	cmp    $0x25,%edi
 5f4:	75 e5                	jne    5db <printf+0x4b>
      if(c == 'd' || c == 'u'){
 5f6:	83 fa 75             	cmp    $0x75,%edx
 5f9:	0f 84 99 00 00 00    	je     698 <printf+0x108>
 5ff:	83 fa 64             	cmp    $0x64,%edx
 602:	0f 84 90 00 00 00    	je     698 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 608:	25 f7 00 00 00       	and    $0xf7,%eax
 60d:	83 f8 70             	cmp    $0x70,%eax
 610:	0f 84 aa 00 00 00    	je     6c0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 616:	83 fa 73             	cmp    $0x73,%edx
 619:	0f 84 e9 00 00 00    	je     708 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 61f:	83 fa 63             	cmp    $0x63,%edx
 622:	0f 84 2b 01 00 00    	je     753 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 628:	83 fa 25             	cmp    $0x25,%edx
 62b:	0f 84 4f 01 00 00    	je     780 <printf+0x1f0>
  write(fd, &c, 1);
 631:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 634:	83 c3 01             	add    $0x1,%ebx
 637:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 63e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 63f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 641:	89 44 24 04          	mov    %eax,0x4(%esp)
 645:	89 34 24             	mov    %esi,(%esp)
 648:	89 55 d0             	mov    %edx,-0x30(%ebp)
 64b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 64f:	e8 de fd ff ff       	call   432 <write>
        putc(fd, c);
 654:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 657:	8d 45 e7             	lea    -0x19(%ebp),%eax
 65a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 661:	00 
 662:	89 44 24 04          	mov    %eax,0x4(%esp)
 666:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 669:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 66c:	e8 c1 fd ff ff       	call   432 <write>
  for(i = 0; fmt[i]; i++){
 671:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 675:	84 d2                	test   %dl,%dl
 677:	0f 85 6d ff ff ff    	jne    5ea <printf+0x5a>
 67d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 680:	83 c4 3c             	add    $0x3c,%esp
 683:	5b                   	pop    %ebx
 684:	5e                   	pop    %esi
 685:	5f                   	pop    %edi
 686:	5d                   	pop    %ebp
 687:	c3                   	ret    
        state = '%';
 688:	bf 25 00 00 00       	mov    $0x25,%edi
 68d:	e9 49 ff ff ff       	jmp    5db <printf+0x4b>
 692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 698:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 69f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 6a4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6a7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 6a9:	8b 10                	mov    (%eax),%edx
 6ab:	89 f0                	mov    %esi,%eax
 6ad:	e8 3e fe ff ff       	call   4f0 <printint>
        ap++;
 6b2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6b6:	e9 20 ff ff ff       	jmp    5db <printf+0x4b>
 6bb:	90                   	nop
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6c0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 6c3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6ca:	00 
 6cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6cf:	89 34 24             	mov    %esi,(%esp)
 6d2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 6d6:	e8 57 fd ff ff       	call   432 <write>
 6db:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6de:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6e5:	00 
 6e6:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ea:	89 34 24             	mov    %esi,(%esp)
 6ed:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 6f1:	e8 3c fd ff ff       	call   432 <write>
        printint(fd, *ap, 16, 0);
 6f6:	b9 10 00 00 00       	mov    $0x10,%ecx
 6fb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 702:	eb a0                	jmp    6a4 <printf+0x114>
 704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 708:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 70b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 70f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 711:	b8 be 0a 00 00       	mov    $0xabe,%eax
 716:	85 ff                	test   %edi,%edi
 718:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 71b:	0f b6 07             	movzbl (%edi),%eax
 71e:	84 c0                	test   %al,%al
 720:	74 2a                	je     74c <printf+0x1bc>
 722:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 728:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 72b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 72e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 731:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 738:	00 
 739:	89 44 24 04          	mov    %eax,0x4(%esp)
 73d:	89 34 24             	mov    %esi,(%esp)
 740:	e8 ed fc ff ff       	call   432 <write>
        while(*s != 0){
 745:	0f b6 07             	movzbl (%edi),%eax
 748:	84 c0                	test   %al,%al
 74a:	75 dc                	jne    728 <printf+0x198>
      state = 0;
 74c:	31 ff                	xor    %edi,%edi
 74e:	e9 88 fe ff ff       	jmp    5db <printf+0x4b>
        putc(fd, *ap);
 753:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 756:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 758:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 75a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 761:	00 
 762:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 765:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 768:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 76b:	89 44 24 04          	mov    %eax,0x4(%esp)
 76f:	e8 be fc ff ff       	call   432 <write>
        ap++;
 774:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 778:	e9 5e fe ff ff       	jmp    5db <printf+0x4b>
 77d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 780:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 783:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 785:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 78c:	00 
 78d:	89 44 24 04          	mov    %eax,0x4(%esp)
 791:	89 34 24             	mov    %esi,(%esp)
 794:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 798:	e8 95 fc ff ff       	call   432 <write>
 79d:	e9 39 fe ff ff       	jmp    5db <printf+0x4b>
 7a2:	66 90                	xchg   %ax,%ax
 7a4:	66 90                	xchg   %ax,%ax
 7a6:	66 90                	xchg   %ax,%ax
 7a8:	66 90                	xchg   %ax,%ax
 7aa:	66 90                	xchg   %ax,%ax
 7ac:	66 90                	xchg   %ax,%ax
 7ae:	66 90                	xchg   %ax,%ax

000007b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b1:	a1 2c 0e 00 00       	mov    0xe2c,%eax
{
 7b6:	89 e5                	mov    %esp,%ebp
 7b8:	57                   	push   %edi
 7b9:	56                   	push   %esi
 7ba:	53                   	push   %ebx
 7bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7be:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 7c0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c3:	39 d0                	cmp    %edx,%eax
 7c5:	72 11                	jb     7d8 <free+0x28>
 7c7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c8:	39 c8                	cmp    %ecx,%eax
 7ca:	72 04                	jb     7d0 <free+0x20>
 7cc:	39 ca                	cmp    %ecx,%edx
 7ce:	72 10                	jb     7e0 <free+0x30>
 7d0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d6:	73 f0                	jae    7c8 <free+0x18>
 7d8:	39 ca                	cmp    %ecx,%edx
 7da:	72 04                	jb     7e0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7dc:	39 c8                	cmp    %ecx,%eax
 7de:	72 f0                	jb     7d0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7e3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 7e6:	39 cf                	cmp    %ecx,%edi
 7e8:	74 1e                	je     808 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ea:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ed:	8b 48 04             	mov    0x4(%eax),%ecx
 7f0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7f3:	39 f2                	cmp    %esi,%edx
 7f5:	74 28                	je     81f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7f7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7f9:	a3 2c 0e 00 00       	mov    %eax,0xe2c
}
 7fe:	5b                   	pop    %ebx
 7ff:	5e                   	pop    %esi
 800:	5f                   	pop    %edi
 801:	5d                   	pop    %ebp
 802:	c3                   	ret    
 803:	90                   	nop
 804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 808:	03 71 04             	add    0x4(%ecx),%esi
 80b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 80e:	8b 08                	mov    (%eax),%ecx
 810:	8b 09                	mov    (%ecx),%ecx
 812:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 815:	8b 48 04             	mov    0x4(%eax),%ecx
 818:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 81b:	39 f2                	cmp    %esi,%edx
 81d:	75 d8                	jne    7f7 <free+0x47>
    p->s.size += bp->s.size;
 81f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 822:	a3 2c 0e 00 00       	mov    %eax,0xe2c
    p->s.size += bp->s.size;
 827:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 82a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 82d:	89 10                	mov    %edx,(%eax)
}
 82f:	5b                   	pop    %ebx
 830:	5e                   	pop    %esi
 831:	5f                   	pop    %edi
 832:	5d                   	pop    %ebp
 833:	c3                   	ret    
 834:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 83a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000840 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 849:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 84c:	8b 1d 2c 0e 00 00    	mov    0xe2c,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 852:	8d 48 07             	lea    0x7(%eax),%ecx
 855:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 858:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 85a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 85d:	0f 84 9b 00 00 00    	je     8fe <malloc+0xbe>
 863:	8b 13                	mov    (%ebx),%edx
 865:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 868:	39 fe                	cmp    %edi,%esi
 86a:	76 64                	jbe    8d0 <malloc+0x90>
 86c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 873:	bb 00 80 00 00       	mov    $0x8000,%ebx
 878:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 87b:	eb 0e                	jmp    88b <malloc+0x4b>
 87d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 880:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 882:	8b 78 04             	mov    0x4(%eax),%edi
 885:	39 fe                	cmp    %edi,%esi
 887:	76 4f                	jbe    8d8 <malloc+0x98>
 889:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 88b:	3b 15 2c 0e 00 00    	cmp    0xe2c,%edx
 891:	75 ed                	jne    880 <malloc+0x40>
  if(nu < 4096)
 893:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 896:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 89c:	bf 00 10 00 00       	mov    $0x1000,%edi
 8a1:	0f 43 fe             	cmovae %esi,%edi
 8a4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 8a7:	89 04 24             	mov    %eax,(%esp)
 8aa:	e8 eb fb ff ff       	call   49a <sbrk>
  if(p == (char*)-1)
 8af:	83 f8 ff             	cmp    $0xffffffff,%eax
 8b2:	74 18                	je     8cc <malloc+0x8c>
  hp->s.size = nu;
 8b4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8b7:	83 c0 08             	add    $0x8,%eax
 8ba:	89 04 24             	mov    %eax,(%esp)
 8bd:	e8 ee fe ff ff       	call   7b0 <free>
  return freep;
 8c2:	8b 15 2c 0e 00 00    	mov    0xe2c,%edx
      if((p = morecore(nunits)) == 0)
 8c8:	85 d2                	test   %edx,%edx
 8ca:	75 b4                	jne    880 <malloc+0x40>
        return 0;
 8cc:	31 c0                	xor    %eax,%eax
 8ce:	eb 20                	jmp    8f0 <malloc+0xb0>
    if(p->s.size >= nunits){
 8d0:	89 d0                	mov    %edx,%eax
 8d2:	89 da                	mov    %ebx,%edx
 8d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 8d8:	39 fe                	cmp    %edi,%esi
 8da:	74 1c                	je     8f8 <malloc+0xb8>
        p->s.size -= nunits;
 8dc:	29 f7                	sub    %esi,%edi
 8de:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 8e1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 8e4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8e7:	89 15 2c 0e 00 00    	mov    %edx,0xe2c
      return (void*)(p + 1);
 8ed:	83 c0 08             	add    $0x8,%eax
  }
}
 8f0:	83 c4 1c             	add    $0x1c,%esp
 8f3:	5b                   	pop    %ebx
 8f4:	5e                   	pop    %esi
 8f5:	5f                   	pop    %edi
 8f6:	5d                   	pop    %ebp
 8f7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 8f8:	8b 08                	mov    (%eax),%ecx
 8fa:	89 0a                	mov    %ecx,(%edx)
 8fc:	eb e9                	jmp    8e7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 8fe:	c7 05 2c 0e 00 00 30 	movl   $0xe30,0xe2c
 905:	0e 00 00 
    base.s.size = 0;
 908:	ba 30 0e 00 00       	mov    $0xe30,%edx
    base.s.ptr = freep = prevp = &base;
 90d:	c7 05 30 0e 00 00 30 	movl   $0xe30,0xe30
 914:	0e 00 00 
    base.s.size = 0;
 917:	c7 05 34 0e 00 00 00 	movl   $0x0,0xe34
 91e:	00 00 00 
 921:	e9 46 ff ff ff       	jmp    86c <malloc+0x2c>
 926:	66 90                	xchg   %ax,%ax
 928:	66 90                	xchg   %ax,%ax
 92a:	66 90                	xchg   %ax,%ax
 92c:	66 90                	xchg   %ax,%ax
 92e:	66 90                	xchg   %ax,%ax

00000930 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	53                   	push   %ebx
 934:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 937:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 93e:	e8 fd fe ff ff       	call   840 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 943:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 94a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 94c:	e8 ef fe ff ff       	call   840 <malloc>
    if (tstack == NULL) {
 951:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 953:	89 c2                	mov    %eax,%edx
 955:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 958:	0f 84 8a 00 00 00    	je     9e8 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 95e:	25 ff 0f 00 00       	and    $0xfff,%eax
 963:	75 73                	jne    9d8 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 965:	8b 45 10             	mov    0x10(%ebp),%eax
 968:	89 54 24 08          	mov    %edx,0x8(%esp)
 96c:	89 44 24 04          	mov    %eax,0x4(%esp)
 970:	8b 45 0c             	mov    0xc(%ebp),%eax
 973:	89 04 24             	mov    %eax,(%esp)
 976:	e8 57 fb ff ff       	call   4d2 <kthread_create>
 97b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 97d:	89 44 24 10          	mov    %eax,0x10(%esp)
 981:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 988:	00 
 989:	c7 44 24 08 d6 0a 00 	movl   $0xad6,0x8(%esp)
 990:	00 
 991:	c7 44 24 04 e5 0a 00 	movl   $0xae5,0x4(%esp)
 998:	00 
 999:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9a0:	e8 eb fb ff ff       	call   590 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 9a5:	8b 03                	mov    (%ebx),%eax
 9a7:	c7 44 24 04 fc 0a 00 	movl   $0xafc,0x4(%esp)
 9ae:	00 
 9af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9b6:	89 44 24 08          	mov    %eax,0x8(%esp)
 9ba:	e8 d1 fb ff ff       	call   590 <printf>
    
    if (bt->tid != 0) {
 9bf:	8b 03                	mov    (%ebx),%eax
 9c1:	85 c0                	test   %eax,%eax
 9c3:	74 23                	je     9e8 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 9c5:	8b 45 08             	mov    0x8(%ebp),%eax
 9c8:	89 18                	mov    %ebx,(%eax)
        return 0;
 9ca:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 9cc:	83 c4 24             	add    $0x24,%esp
 9cf:	5b                   	pop    %ebx
 9d0:	5d                   	pop    %ebp
 9d1:	c3                   	ret    
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 9d8:	29 c2                	sub    %eax,%edx
 9da:	81 c2 00 10 00 00    	add    $0x1000,%edx
 9e0:	eb 83                	jmp    965 <benny_thread_create+0x35>
 9e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 9e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9ed:	eb dd                	jmp    9cc <benny_thread_create+0x9c>
 9ef:	90                   	nop

000009f0 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 9f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 9f6:	5d                   	pop    %ebp
    return bt->tid;
 9f7:	8b 00                	mov    (%eax),%eax
}
 9f9:	c3                   	ret    
 9fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a00 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	53                   	push   %ebx
 a04:	83 ec 14             	sub    $0x14,%esp
 a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 a0a:	8b 03                	mov    (%ebx),%eax
 a0c:	89 04 24             	mov    %eax,(%esp)
 a0f:	e8 c6 fa ff ff       	call   4da <kthread_join>
    if (retVal == 0) {
 a14:	85 c0                	test   %eax,%eax
 a16:	75 11                	jne    a29 <benny_thread_join+0x29>
        free(bt->tstack);
 a18:	8b 53 04             	mov    0x4(%ebx),%edx
 a1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a1e:	89 14 24             	mov    %edx,(%esp)
 a21:	e8 8a fd ff ff       	call   7b0 <free>
 a26:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 a29:	83 c4 14             	add    $0x14,%esp
 a2c:	5b                   	pop    %ebx
 a2d:	5d                   	pop    %ebp
 a2e:	c3                   	ret    
 a2f:	90                   	nop

00000a30 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 a36:	8b 45 08             	mov    0x8(%ebp),%eax
 a39:	89 04 24             	mov    %eax,(%esp)
 a3c:	e8 a1 fa ff ff       	call   4e2 <kthread_exit>
    return 0;
}
 a41:	31 c0                	xor    %eax,%eax
 a43:	c9                   	leave  
 a44:	c3                   	ret    
