
_thtst5:     file format elf32-i386


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
    benny_thread_t bt[MAX_THREADS];
    long i = -1;
    long num_threads = DEFAULT_NUM_THREADS;
    int rez = -17;

    printf(1, "%s %d: %p %p\n", __FILE__, __LINE__, main, &argc);
   c:	8d 45 08             	lea    0x8(%ebp),%eax
   f:	89 44 24 14          	mov    %eax,0x14(%esp)
  13:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  1a:	00 
  1b:	c7 44 24 0c 35 00 00 	movl   $0x35,0xc(%esp)
  22:	00 
  23:	c7 44 24 08 8b 0a 00 	movl   $0xa8b,0x8(%esp)
  2a:	00 
  2b:	c7 44 24 04 94 0a 00 	movl   $0xa94,0x4(%esp)
  32:	00 
  33:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  3a:	e8 81 05 00 00       	call   5c0 <printf>
    if (argc > 1) {
  3f:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  43:	0f 8e 27 01 00 00    	jle    170 <main+0x170>
        num_threads = atoi(argv[1]);
  49:	8b 45 0c             	mov    0xc(%ebp),%eax
  4c:	8b 40 04             	mov    0x4(%eax),%eax
  4f:	89 04 24             	mov    %eax,(%esp)
  52:	e8 89 03 00 00       	call   3e0 <atoi>
  57:	89 c6                	mov    %eax,%esi
        if (num_threads < 1 || num_threads > MAX_THREADS) {
  59:	8d 40 ff             	lea    -0x1(%eax),%eax
  5c:	83 f8 13             	cmp    $0x13,%eax
  5f:	0f 87 0b 01 00 00    	ja     170 <main+0x170>
            num_threads = DEFAULT_NUM_THREADS;
        }
    }
    printf(1, "Starting %d threads\n", num_threads);
  65:	89 74 24 08          	mov    %esi,0x8(%esp)
  69:	8d 7c 24 20          	lea    0x20(%esp),%edi
    
    for (i = 0; i < num_threads; i++) {
  6d:	31 db                	xor    %ebx,%ebx
    printf(1, "Starting %d threads\n", num_threads);
  6f:	c7 44 24 04 a2 0a 00 	movl   $0xaa2,0x4(%esp)
  76:	00 
  77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7e:	e8 3d 05 00 00       	call   5c0 <printf>
  83:	90                   	nop
  84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        benny_thread_create(&(bt[i]), func1, (void *) i);
  88:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    for (i = 0; i < num_threads; i++) {
  8c:	83 c3 01             	add    $0x1,%ebx
        benny_thread_create(&(bt[i]), func1, (void *) i);
  8f:	89 3c 24             	mov    %edi,(%esp)
  92:	83 c7 04             	add    $0x4,%edi
  95:	c7 44 24 04 80 01 00 	movl   $0x180,0x4(%esp)
  9c:	00 
  9d:	e8 be 08 00 00       	call   960 <benny_thread_create>
        printf(1, "%s %d: %d\n", __FILE__, __LINE__, benny_thread_tid(bt[i]));
  a2:	8b 47 fc             	mov    -0x4(%edi),%eax
  a5:	89 04 24             	mov    %eax,(%esp)
  a8:	e8 73 09 00 00       	call   a20 <benny_thread_tid>
  ad:	c7 44 24 0c 40 00 00 	movl   $0x40,0xc(%esp)
  b4:	00 
  b5:	c7 44 24 08 8b 0a 00 	movl   $0xa8b,0x8(%esp)
  bc:	00 
  bd:	c7 44 24 04 b7 0a 00 	movl   $0xab7,0x4(%esp)
  c4:	00 
  c5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cc:	89 44 24 10          	mov    %eax,0x10(%esp)
  d0:	e8 eb 04 00 00       	call   5c0 <printf>
    for (i = 0; i < num_threads; i++) {
  d5:	39 de                	cmp    %ebx,%esi
  d7:	7f af                	jg     88 <main+0x88>

    // my code does not allow you to join with thread 0, but this is not a requirement.
    //rez = kthread_join(0);
    //printf(1, "%s %d: %d\n", __FILE__, __LINE__, rez);
    rez = -17;
    rez = kthread_join(50);
  d9:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
    printf(1, "%s %d: %d\n", __FILE__, __LINE__, rez);

    for (i = 0; i < num_threads; i++) {
  e0:	31 db                	xor    %ebx,%ebx
    rez = kthread_join(50);
  e2:	e8 23 04 00 00       	call   50a <kthread_join>
    printf(1, "%s %d: %d\n", __FILE__, __LINE__, rez);
  e7:	c7 44 24 0c 48 00 00 	movl   $0x48,0xc(%esp)
  ee:	00 
  ef:	c7 44 24 08 8b 0a 00 	movl   $0xa8b,0x8(%esp)
  f6:	00 
  f7:	c7 44 24 04 b7 0a 00 	movl   $0xab7,0x4(%esp)
  fe:	00 
  ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 106:	89 44 24 10          	mov    %eax,0x10(%esp)
 10a:	e8 b1 04 00 00       	call   5c0 <printf>
 10f:	90                   	nop
        printf(1, "%s %d: joining with %d\n", __FILE__, __LINE__, benny_thread_tid(bt[i]));
 110:	8b 44 9c 20          	mov    0x20(%esp,%ebx,4),%eax
 114:	89 04 24             	mov    %eax,(%esp)
 117:	e8 04 09 00 00       	call   a20 <benny_thread_tid>
 11c:	c7 44 24 0c 4b 00 00 	movl   $0x4b,0xc(%esp)
 123:	00 
 124:	c7 44 24 08 8b 0a 00 	movl   $0xa8b,0x8(%esp)
 12b:	00 
 12c:	c7 44 24 04 c2 0a 00 	movl   $0xac2,0x4(%esp)
 133:	00 
 134:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13b:	89 44 24 10          	mov    %eax,0x10(%esp)
 13f:	e8 7c 04 00 00       	call   5c0 <printf>
        benny_thread_join(bt[i]);
 144:	8b 44 9c 20          	mov    0x20(%esp,%ebx,4),%eax
    for (i = 0; i < num_threads; i++) {
 148:	83 c3 01             	add    $0x1,%ebx
        benny_thread_join(bt[i]);
 14b:	89 04 24             	mov    %eax,(%esp)
 14e:	e8 dd 08 00 00       	call   a30 <benny_thread_join>
    for (i = 0; i < num_threads; i++) {
 153:	39 de                	cmp    %ebx,%esi
 155:	7f b9                	jg     110 <main+0x110>
    }

    printf(1, "All threads joined\n");
 157:	c7 44 24 04 da 0a 00 	movl   $0xada,0x4(%esp)
 15e:	00 
 15f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 166:	e8 55 04 00 00       	call   5c0 <printf>
#endif // KTHREADS
    exit();
 16b:	e8 d2 02 00 00       	call   442 <exit>
    long num_threads = DEFAULT_NUM_THREADS;
 170:	be 02 00 00 00       	mov    $0x2,%esi
 175:	e9 eb fe ff ff       	jmp    65 <main+0x65>
 17a:	66 90                	xchg   %ax,%ax
 17c:	66 90                	xchg   %ax,%ax
 17e:	66 90                	xchg   %ax,%ax

00000180 <func1>:
{
 180:	55                   	push   %ebp
        if ((sum % (MAXSHORT * MAXSHORT)) == 0) {
 181:	b9 03 00 ff 3f       	mov    $0x3fff0003,%ecx
{
 186:	89 e5                	mov    %esp,%ebp
 188:	57                   	push   %edi
            sum = 0;
 189:	31 ff                	xor    %edi,%edi
{
 18b:	56                   	push   %esi
    long arg = ((long) arg_ptr);
 18c:	be fe ff ff 7f       	mov    $0x7ffffffe,%esi
{
 191:	53                   	push   %ebx
        sum ++;
 192:	bb 02 00 00 00       	mov    $0x2,%ebx
{
 197:	83 ec 2c             	sub    $0x2c,%esp
 19a:	8b 45 08             	mov    0x8(%ebp),%eax
 19d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            sum = 0;
 1a0:	81 fb 00 00 00 40    	cmp    $0x40000000,%ebx
 1a6:	0f 43 df             	cmovae %edi,%ebx
    for(i = 1; i < max; i++) {
 1a9:	83 ee 01             	sub    $0x1,%esi
 1ac:	74 53                	je     201 <func1+0x81>
        sum ++;
 1ae:	83 c3 01             	add    $0x1,%ebx
        if ((sum % (MAXSHORT * MAXSHORT)) == 0) {
 1b1:	89 d8                	mov    %ebx,%eax
 1b3:	f7 e1                	mul    %ecx
 1b5:	c1 ea 1c             	shr    $0x1c,%edx
 1b8:	69 d2 01 00 01 40    	imul   $0x40010001,%edx,%edx
 1be:	39 d3                	cmp    %edx,%ebx
 1c0:	75 de                	jne    1a0 <func1+0x20>
            sum += arg;
 1c2:	03 5d e4             	add    -0x1c(%ebp),%ebx
 1c5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
            printf(1, "\t%d  thtst2: %d  %d\n\n", arg, getpid(), sum);
 1c8:	e8 f5 02 00 00       	call   4c2 <getpid>
 1cd:	89 5c 24 10          	mov    %ebx,0x10(%esp)
 1d1:	c7 44 24 04 75 0a 00 	movl   $0xa75,0x4(%esp)
 1d8:	00 
 1d9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1e0:	89 44 24 0c          	mov    %eax,0xc(%esp)
 1e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 1e7:	89 44 24 08          	mov    %eax,0x8(%esp)
 1eb:	e8 d0 03 00 00       	call   5c0 <printf>
            sum = 0;
 1f0:	81 fb 00 00 00 40    	cmp    $0x40000000,%ebx
            printf(1, "\t%d  thtst2: %d  %d\n\n", arg, getpid(), sum);
 1f6:	8b 4d e0             	mov    -0x20(%ebp),%ecx
            sum = 0;
 1f9:	0f 43 df             	cmovae %edi,%ebx
    for(i = 1; i < max; i++) {
 1fc:	83 ee 01             	sub    $0x1,%esi
 1ff:	75 ad                	jne    1ae <func1+0x2e>
    benny_thread_exit(7);
 201:	c7 45 08 07 00 00 00 	movl   $0x7,0x8(%ebp)
}
 208:	83 c4 2c             	add    $0x2c,%esp
 20b:	5b                   	pop    %ebx
 20c:	5e                   	pop    %esi
 20d:	5f                   	pop    %edi
 20e:	5d                   	pop    %ebp
    benny_thread_exit(7);
 20f:	e9 4c 08 00 00       	jmp    a60 <benny_thread_exit>
 214:	66 90                	xchg   %ax,%ax
 216:	66 90                	xchg   %ax,%ax
 218:	66 90                	xchg   %ax,%ax
 21a:	66 90                	xchg   %ax,%ax
 21c:	66 90                	xchg   %ax,%ax
 21e:	66 90                	xchg   %ax,%ax

00000220 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 229:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 22a:	89 c2                	mov    %eax,%edx
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 230:	83 c1 01             	add    $0x1,%ecx
 233:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 237:	83 c2 01             	add    $0x1,%edx
 23a:	84 db                	test   %bl,%bl
 23c:	88 5a ff             	mov    %bl,-0x1(%edx)
 23f:	75 ef                	jne    230 <strcpy+0x10>
    ;
  return os;
}
 241:	5b                   	pop    %ebx
 242:	5d                   	pop    %ebp
 243:	c3                   	ret    
 244:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 24a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000250 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 55 08             	mov    0x8(%ebp),%edx
 256:	53                   	push   %ebx
 257:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 25a:	0f b6 02             	movzbl (%edx),%eax
 25d:	84 c0                	test   %al,%al
 25f:	74 2d                	je     28e <strcmp+0x3e>
 261:	0f b6 19             	movzbl (%ecx),%ebx
 264:	38 d8                	cmp    %bl,%al
 266:	74 0e                	je     276 <strcmp+0x26>
 268:	eb 2b                	jmp    295 <strcmp+0x45>
 26a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 270:	38 c8                	cmp    %cl,%al
 272:	75 15                	jne    289 <strcmp+0x39>
    p++, q++;
 274:	89 d9                	mov    %ebx,%ecx
 276:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 279:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 27c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 27f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 283:	84 c0                	test   %al,%al
 285:	75 e9                	jne    270 <strcmp+0x20>
 287:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 289:	29 c8                	sub    %ecx,%eax
}
 28b:	5b                   	pop    %ebx
 28c:	5d                   	pop    %ebp
 28d:	c3                   	ret    
 28e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 291:	31 c0                	xor    %eax,%eax
 293:	eb f4                	jmp    289 <strcmp+0x39>
 295:	0f b6 cb             	movzbl %bl,%ecx
 298:	eb ef                	jmp    289 <strcmp+0x39>
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <strlen>:

uint
strlen(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2a6:	80 39 00             	cmpb   $0x0,(%ecx)
 2a9:	74 12                	je     2bd <strlen+0x1d>
 2ab:	31 d2                	xor    %edx,%edx
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
 2b0:	83 c2 01             	add    $0x1,%edx
 2b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2b7:	89 d0                	mov    %edx,%eax
 2b9:	75 f5                	jne    2b0 <strlen+0x10>
    ;
  return n;
}
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 2bd:	31 c0                	xor    %eax,%eax
}
 2bf:	5d                   	pop    %ebp
 2c0:	c3                   	ret    
 2c1:	eb 0d                	jmp    2d0 <memset>
 2c3:	90                   	nop
 2c4:	90                   	nop
 2c5:	90                   	nop
 2c6:	90                   	nop
 2c7:	90                   	nop
 2c8:	90                   	nop
 2c9:	90                   	nop
 2ca:	90                   	nop
 2cb:	90                   	nop
 2cc:	90                   	nop
 2cd:	90                   	nop
 2ce:	90                   	nop
 2cf:	90                   	nop

000002d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	8b 55 08             	mov    0x8(%ebp),%edx
 2d6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2da:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dd:	89 d7                	mov    %edx,%edi
 2df:	fc                   	cld    
 2e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2e2:	89 d0                	mov    %edx,%eax
 2e4:	5f                   	pop    %edi
 2e5:	5d                   	pop    %ebp
 2e6:	c3                   	ret    
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <strchr>:

char*
strchr(const char *s, char c)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	53                   	push   %ebx
 2f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 2fa:	0f b6 18             	movzbl (%eax),%ebx
 2fd:	84 db                	test   %bl,%bl
 2ff:	74 1d                	je     31e <strchr+0x2e>
    if(*s == c)
 301:	38 d3                	cmp    %dl,%bl
 303:	89 d1                	mov    %edx,%ecx
 305:	75 0d                	jne    314 <strchr+0x24>
 307:	eb 17                	jmp    320 <strchr+0x30>
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 310:	38 ca                	cmp    %cl,%dl
 312:	74 0c                	je     320 <strchr+0x30>
  for(; *s; s++)
 314:	83 c0 01             	add    $0x1,%eax
 317:	0f b6 10             	movzbl (%eax),%edx
 31a:	84 d2                	test   %dl,%dl
 31c:	75 f2                	jne    310 <strchr+0x20>
      return (char*)s;
  return 0;
 31e:	31 c0                	xor    %eax,%eax
}
 320:	5b                   	pop    %ebx
 321:	5d                   	pop    %ebp
 322:	c3                   	ret    
 323:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <gets>:

char*
gets(char *buf, int max)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 335:	31 f6                	xor    %esi,%esi
{
 337:	53                   	push   %ebx
 338:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 33b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 33e:	eb 31                	jmp    371 <gets+0x41>
    cc = read(0, &c, 1);
 340:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 347:	00 
 348:	89 7c 24 04          	mov    %edi,0x4(%esp)
 34c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 353:	e8 02 01 00 00       	call   45a <read>
    if(cc < 1)
 358:	85 c0                	test   %eax,%eax
 35a:	7e 1d                	jle    379 <gets+0x49>
      break;
    buf[i++] = c;
 35c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 360:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 362:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 365:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 367:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 36b:	74 0c                	je     379 <gets+0x49>
 36d:	3c 0a                	cmp    $0xa,%al
 36f:	74 08                	je     379 <gets+0x49>
  for(i=0; i+1 < max; ){
 371:	8d 5e 01             	lea    0x1(%esi),%ebx
 374:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 377:	7c c7                	jl     340 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 379:	8b 45 08             	mov    0x8(%ebp),%eax
 37c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 380:	83 c4 2c             	add    $0x2c,%esp
 383:	5b                   	pop    %ebx
 384:	5e                   	pop    %esi
 385:	5f                   	pop    %edi
 386:	5d                   	pop    %ebp
 387:	c3                   	ret    
 388:	90                   	nop
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	53                   	push   %ebx
 395:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3a2:	00 
 3a3:	89 04 24             	mov    %eax,(%esp)
 3a6:	e8 d7 00 00 00       	call   482 <open>
  if(fd < 0)
 3ab:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 3ad:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3af:	78 27                	js     3d8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b4:	89 1c 24             	mov    %ebx,(%esp)
 3b7:	89 44 24 04          	mov    %eax,0x4(%esp)
 3bb:	e8 da 00 00 00       	call   49a <fstat>
  close(fd);
 3c0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3c3:	89 c6                	mov    %eax,%esi
  close(fd);
 3c5:	e8 a0 00 00 00       	call   46a <close>
  return r;
 3ca:	89 f0                	mov    %esi,%eax
}
 3cc:	83 c4 10             	add    $0x10,%esp
 3cf:	5b                   	pop    %ebx
 3d0:	5e                   	pop    %esi
 3d1:	5d                   	pop    %ebp
 3d2:	c3                   	ret    
 3d3:	90                   	nop
 3d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 3d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3dd:	eb ed                	jmp    3cc <stat+0x3c>
 3df:	90                   	nop

000003e0 <atoi>:

int
atoi(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3e6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e7:	0f be 11             	movsbl (%ecx),%edx
 3ea:	8d 42 d0             	lea    -0x30(%edx),%eax
 3ed:	3c 09                	cmp    $0x9,%al
  n = 0;
 3ef:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 3f4:	77 17                	ja     40d <atoi+0x2d>
 3f6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 3f8:	83 c1 01             	add    $0x1,%ecx
 3fb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3fe:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 402:	0f be 11             	movsbl (%ecx),%edx
 405:	8d 5a d0             	lea    -0x30(%edx),%ebx
 408:	80 fb 09             	cmp    $0x9,%bl
 40b:	76 eb                	jbe    3f8 <atoi+0x18>
  return n;
}
 40d:	5b                   	pop    %ebx
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    

00000410 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 410:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 411:	31 d2                	xor    %edx,%edx
{
 413:	89 e5                	mov    %esp,%ebp
 415:	56                   	push   %esi
 416:	8b 45 08             	mov    0x8(%ebp),%eax
 419:	53                   	push   %ebx
 41a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 41d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 420:	85 db                	test   %ebx,%ebx
 422:	7e 12                	jle    436 <memmove+0x26>
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 428:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 42c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 42f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 432:	39 da                	cmp    %ebx,%edx
 434:	75 f2                	jne    428 <memmove+0x18>
  return vdst;
}
 436:	5b                   	pop    %ebx
 437:	5e                   	pop    %esi
 438:	5d                   	pop    %ebp
 439:	c3                   	ret    

0000043a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43a:	b8 01 00 00 00       	mov    $0x1,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <exit>:
SYSCALL(exit)
 442:	b8 02 00 00 00       	mov    $0x2,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <wait>:
SYSCALL(wait)
 44a:	b8 03 00 00 00       	mov    $0x3,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <pipe>:
SYSCALL(pipe)
 452:	b8 04 00 00 00       	mov    $0x4,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <read>:
SYSCALL(read)
 45a:	b8 05 00 00 00       	mov    $0x5,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <write>:
SYSCALL(write)
 462:	b8 10 00 00 00       	mov    $0x10,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <close>:
SYSCALL(close)
 46a:	b8 15 00 00 00       	mov    $0x15,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kill>:
SYSCALL(kill)
 472:	b8 06 00 00 00       	mov    $0x6,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <exec>:
SYSCALL(exec)
 47a:	b8 07 00 00 00       	mov    $0x7,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <open>:
SYSCALL(open)
 482:	b8 0f 00 00 00       	mov    $0xf,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <mknod>:
SYSCALL(mknod)
 48a:	b8 11 00 00 00       	mov    $0x11,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <unlink>:
SYSCALL(unlink)
 492:	b8 12 00 00 00       	mov    $0x12,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <fstat>:
SYSCALL(fstat)
 49a:	b8 08 00 00 00       	mov    $0x8,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <link>:
SYSCALL(link)
 4a2:	b8 13 00 00 00       	mov    $0x13,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <mkdir>:
SYSCALL(mkdir)
 4aa:	b8 14 00 00 00       	mov    $0x14,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <chdir>:
SYSCALL(chdir)
 4b2:	b8 09 00 00 00       	mov    $0x9,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <dup>:
SYSCALL(dup)
 4ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <getpid>:
SYSCALL(getpid)
 4c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <sbrk>:
SYSCALL(sbrk)
 4ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <sleep>:
SYSCALL(sleep)
 4d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <uptime>:
SYSCALL(uptime)
 4da:	b8 0e 00 00 00       	mov    $0xe,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 4e2:	b8 16 00 00 00       	mov    $0x16,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 4ea:	b8 17 00 00 00       	mov    $0x17,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 4f2:	b8 18 00 00 00       	mov    $0x18,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <halt>:
SYSCALL(halt)
 4fa:	b8 19 00 00 00       	mov    $0x19,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 502:	b8 1a 00 00 00       	mov    $0x1a,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <kthread_join>:
SYSCALL(kthread_join)
 50a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <kthread_exit>:
SYSCALL(kthread_exit)
 512:	b8 1c 00 00 00       	mov    $0x1c,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    
 51a:	66 90                	xchg   %ax,%ax
 51c:	66 90                	xchg   %ax,%ax
 51e:	66 90                	xchg   %ax,%ax

00000520 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 520:	55                   	push   %ebp
 521:	89 e5                	mov    %esp,%ebp
 523:	57                   	push   %edi
 524:	56                   	push   %esi
 525:	89 c6                	mov    %eax,%esi
 527:	53                   	push   %ebx
 528:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 52b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 52e:	85 db                	test   %ebx,%ebx
 530:	74 09                	je     53b <printint+0x1b>
 532:	89 d0                	mov    %edx,%eax
 534:	c1 e8 1f             	shr    $0x1f,%eax
 537:	84 c0                	test   %al,%al
 539:	75 75                	jne    5b0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 53b:	89 d0                	mov    %edx,%eax
  neg = 0;
 53d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 544:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 547:	31 ff                	xor    %edi,%edi
 549:	89 ce                	mov    %ecx,%esi
 54b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 54e:	eb 02                	jmp    552 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 550:	89 cf                	mov    %ecx,%edi
 552:	31 d2                	xor    %edx,%edx
 554:	f7 f6                	div    %esi
 556:	8d 4f 01             	lea    0x1(%edi),%ecx
 559:	0f b6 92 f5 0a 00 00 	movzbl 0xaf5(%edx),%edx
  }while((x /= base) != 0);
 560:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 562:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 565:	75 e9                	jne    550 <printint+0x30>
  if(neg)
 567:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 56a:	89 c8                	mov    %ecx,%eax
 56c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 56f:	85 d2                	test   %edx,%edx
 571:	74 08                	je     57b <printint+0x5b>
    buf[i++] = '-';
 573:	8d 4f 02             	lea    0x2(%edi),%ecx
 576:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 57b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 57e:	66 90                	xchg   %ax,%ax
 580:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 585:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 588:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 58f:	00 
 590:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 594:	89 34 24             	mov    %esi,(%esp)
 597:	88 45 d7             	mov    %al,-0x29(%ebp)
 59a:	e8 c3 fe ff ff       	call   462 <write>
  while(--i >= 0)
 59f:	83 ff ff             	cmp    $0xffffffff,%edi
 5a2:	75 dc                	jne    580 <printint+0x60>
    putc(fd, buf[i]);
}
 5a4:	83 c4 4c             	add    $0x4c,%esp
 5a7:	5b                   	pop    %ebx
 5a8:	5e                   	pop    %esi
 5a9:	5f                   	pop    %edi
 5aa:	5d                   	pop    %ebp
 5ab:	c3                   	ret    
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 5b0:	89 d0                	mov    %edx,%eax
 5b2:	f7 d8                	neg    %eax
    neg = 1;
 5b4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 5bb:	eb 87                	jmp    544 <printint+0x24>
 5bd:	8d 76 00             	lea    0x0(%esi),%esi

000005c0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5c4:	31 ff                	xor    %edi,%edi
{
 5c6:	56                   	push   %esi
 5c7:	53                   	push   %ebx
 5c8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5cb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 5ce:	8d 45 10             	lea    0x10(%ebp),%eax
{
 5d1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 5d4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 5d7:	0f b6 13             	movzbl (%ebx),%edx
 5da:	83 c3 01             	add    $0x1,%ebx
 5dd:	84 d2                	test   %dl,%dl
 5df:	75 39                	jne    61a <printf+0x5a>
 5e1:	e9 ca 00 00 00       	jmp    6b0 <printf+0xf0>
 5e6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5e8:	83 fa 25             	cmp    $0x25,%edx
 5eb:	0f 84 c7 00 00 00    	je     6b8 <printf+0xf8>
  write(fd, &c, 1);
 5f1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5fb:	00 
 5fc:	89 44 24 04          	mov    %eax,0x4(%esp)
 600:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 603:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 606:	e8 57 fe ff ff       	call   462 <write>
 60b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 60e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 612:	84 d2                	test   %dl,%dl
 614:	0f 84 96 00 00 00    	je     6b0 <printf+0xf0>
    if(state == 0){
 61a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 61c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 61f:	74 c7                	je     5e8 <printf+0x28>
      }
    } else if(state == '%'){
 621:	83 ff 25             	cmp    $0x25,%edi
 624:	75 e5                	jne    60b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 626:	83 fa 75             	cmp    $0x75,%edx
 629:	0f 84 99 00 00 00    	je     6c8 <printf+0x108>
 62f:	83 fa 64             	cmp    $0x64,%edx
 632:	0f 84 90 00 00 00    	je     6c8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 638:	25 f7 00 00 00       	and    $0xf7,%eax
 63d:	83 f8 70             	cmp    $0x70,%eax
 640:	0f 84 aa 00 00 00    	je     6f0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 646:	83 fa 73             	cmp    $0x73,%edx
 649:	0f 84 e9 00 00 00    	je     738 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 64f:	83 fa 63             	cmp    $0x63,%edx
 652:	0f 84 2b 01 00 00    	je     783 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 658:	83 fa 25             	cmp    $0x25,%edx
 65b:	0f 84 4f 01 00 00    	je     7b0 <printf+0x1f0>
  write(fd, &c, 1);
 661:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 664:	83 c3 01             	add    $0x1,%ebx
 667:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 66e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 671:	89 44 24 04          	mov    %eax,0x4(%esp)
 675:	89 34 24             	mov    %esi,(%esp)
 678:	89 55 d0             	mov    %edx,-0x30(%ebp)
 67b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 67f:	e8 de fd ff ff       	call   462 <write>
        putc(fd, c);
 684:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 687:	8d 45 e7             	lea    -0x19(%ebp),%eax
 68a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 691:	00 
 692:	89 44 24 04          	mov    %eax,0x4(%esp)
 696:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 699:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 69c:	e8 c1 fd ff ff       	call   462 <write>
  for(i = 0; fmt[i]; i++){
 6a1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 6a5:	84 d2                	test   %dl,%dl
 6a7:	0f 85 6d ff ff ff    	jne    61a <printf+0x5a>
 6ad:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 6b0:	83 c4 3c             	add    $0x3c,%esp
 6b3:	5b                   	pop    %ebx
 6b4:	5e                   	pop    %esi
 6b5:	5f                   	pop    %edi
 6b6:	5d                   	pop    %ebp
 6b7:	c3                   	ret    
        state = '%';
 6b8:	bf 25 00 00 00       	mov    $0x25,%edi
 6bd:	e9 49 ff ff ff       	jmp    60b <printf+0x4b>
 6c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 6c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6cf:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 6d4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6d7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	89 f0                	mov    %esi,%eax
 6dd:	e8 3e fe ff ff       	call   520 <printint>
        ap++;
 6e2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6e6:	e9 20 ff ff ff       	jmp    60b <printf+0x4b>
 6eb:	90                   	nop
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6f0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 6f3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6fa:	00 
 6fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6ff:	89 34 24             	mov    %esi,(%esp)
 702:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 706:	e8 57 fd ff ff       	call   462 <write>
 70b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 70e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 715:	00 
 716:	89 44 24 04          	mov    %eax,0x4(%esp)
 71a:	89 34 24             	mov    %esi,(%esp)
 71d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 721:	e8 3c fd ff ff       	call   462 <write>
        printint(fd, *ap, 16, 0);
 726:	b9 10 00 00 00       	mov    $0x10,%ecx
 72b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 732:	eb a0                	jmp    6d4 <printf+0x114>
 734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 738:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 73b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 73f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 741:	b8 ee 0a 00 00       	mov    $0xaee,%eax
 746:	85 ff                	test   %edi,%edi
 748:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 74b:	0f b6 07             	movzbl (%edi),%eax
 74e:	84 c0                	test   %al,%al
 750:	74 2a                	je     77c <printf+0x1bc>
 752:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 758:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 75b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 75e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 761:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 768:	00 
 769:	89 44 24 04          	mov    %eax,0x4(%esp)
 76d:	89 34 24             	mov    %esi,(%esp)
 770:	e8 ed fc ff ff       	call   462 <write>
        while(*s != 0){
 775:	0f b6 07             	movzbl (%edi),%eax
 778:	84 c0                	test   %al,%al
 77a:	75 dc                	jne    758 <printf+0x198>
      state = 0;
 77c:	31 ff                	xor    %edi,%edi
 77e:	e9 88 fe ff ff       	jmp    60b <printf+0x4b>
        putc(fd, *ap);
 783:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 786:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 788:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 78a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 791:	00 
 792:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 795:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 798:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 79b:	89 44 24 04          	mov    %eax,0x4(%esp)
 79f:	e8 be fc ff ff       	call   462 <write>
        ap++;
 7a4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 7a8:	e9 5e fe ff ff       	jmp    60b <printf+0x4b>
 7ad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 7b0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 7b3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 7b5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 7bc:	00 
 7bd:	89 44 24 04          	mov    %eax,0x4(%esp)
 7c1:	89 34 24             	mov    %esi,(%esp)
 7c4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 7c8:	e8 95 fc ff ff       	call   462 <write>
 7cd:	e9 39 fe ff ff       	jmp    60b <printf+0x4b>
 7d2:	66 90                	xchg   %ax,%ax
 7d4:	66 90                	xchg   %ax,%ax
 7d6:	66 90                	xchg   %ax,%ax
 7d8:	66 90                	xchg   %ax,%ax
 7da:	66 90                	xchg   %ax,%ax
 7dc:	66 90                	xchg   %ax,%ax
 7de:	66 90                	xchg   %ax,%ax

000007e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e1:	a1 5c 0e 00 00       	mov    0xe5c,%eax
{
 7e6:	89 e5                	mov    %esp,%ebp
 7e8:	57                   	push   %edi
 7e9:	56                   	push   %esi
 7ea:	53                   	push   %ebx
 7eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 7f0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f3:	39 d0                	cmp    %edx,%eax
 7f5:	72 11                	jb     808 <free+0x28>
 7f7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7f8:	39 c8                	cmp    %ecx,%eax
 7fa:	72 04                	jb     800 <free+0x20>
 7fc:	39 ca                	cmp    %ecx,%edx
 7fe:	72 10                	jb     810 <free+0x30>
 800:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 802:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 806:	73 f0                	jae    7f8 <free+0x18>
 808:	39 ca                	cmp    %ecx,%edx
 80a:	72 04                	jb     810 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	39 c8                	cmp    %ecx,%eax
 80e:	72 f0                	jb     800 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 810:	8b 73 fc             	mov    -0x4(%ebx),%esi
 813:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 816:	39 cf                	cmp    %ecx,%edi
 818:	74 1e                	je     838 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 81a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 81d:	8b 48 04             	mov    0x4(%eax),%ecx
 820:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 823:	39 f2                	cmp    %esi,%edx
 825:	74 28                	je     84f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 827:	89 10                	mov    %edx,(%eax)
  freep = p;
 829:	a3 5c 0e 00 00       	mov    %eax,0xe5c
}
 82e:	5b                   	pop    %ebx
 82f:	5e                   	pop    %esi
 830:	5f                   	pop    %edi
 831:	5d                   	pop    %ebp
 832:	c3                   	ret    
 833:	90                   	nop
 834:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 838:	03 71 04             	add    0x4(%ecx),%esi
 83b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 83e:	8b 08                	mov    (%eax),%ecx
 840:	8b 09                	mov    (%ecx),%ecx
 842:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 845:	8b 48 04             	mov    0x4(%eax),%ecx
 848:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 84b:	39 f2                	cmp    %esi,%edx
 84d:	75 d8                	jne    827 <free+0x47>
    p->s.size += bp->s.size;
 84f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 852:	a3 5c 0e 00 00       	mov    %eax,0xe5c
    p->s.size += bp->s.size;
 857:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 85a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 85d:	89 10                	mov    %edx,(%eax)
}
 85f:	5b                   	pop    %ebx
 860:	5e                   	pop    %esi
 861:	5f                   	pop    %edi
 862:	5d                   	pop    %ebp
 863:	c3                   	ret    
 864:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 86a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000870 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 87c:	8b 1d 5c 0e 00 00    	mov    0xe5c,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 882:	8d 48 07             	lea    0x7(%eax),%ecx
 885:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 888:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 88a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 88d:	0f 84 9b 00 00 00    	je     92e <malloc+0xbe>
 893:	8b 13                	mov    (%ebx),%edx
 895:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 898:	39 fe                	cmp    %edi,%esi
 89a:	76 64                	jbe    900 <malloc+0x90>
 89c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 8a3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 8a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 8ab:	eb 0e                	jmp    8bb <malloc+0x4b>
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8b2:	8b 78 04             	mov    0x4(%eax),%edi
 8b5:	39 fe                	cmp    %edi,%esi
 8b7:	76 4f                	jbe    908 <malloc+0x98>
 8b9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8bb:	3b 15 5c 0e 00 00    	cmp    0xe5c,%edx
 8c1:	75 ed                	jne    8b0 <malloc+0x40>
  if(nu < 4096)
 8c3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8c6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 8cc:	bf 00 10 00 00       	mov    $0x1000,%edi
 8d1:	0f 43 fe             	cmovae %esi,%edi
 8d4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 8d7:	89 04 24             	mov    %eax,(%esp)
 8da:	e8 eb fb ff ff       	call   4ca <sbrk>
  if(p == (char*)-1)
 8df:	83 f8 ff             	cmp    $0xffffffff,%eax
 8e2:	74 18                	je     8fc <malloc+0x8c>
  hp->s.size = nu;
 8e4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8e7:	83 c0 08             	add    $0x8,%eax
 8ea:	89 04 24             	mov    %eax,(%esp)
 8ed:	e8 ee fe ff ff       	call   7e0 <free>
  return freep;
 8f2:	8b 15 5c 0e 00 00    	mov    0xe5c,%edx
      if((p = morecore(nunits)) == 0)
 8f8:	85 d2                	test   %edx,%edx
 8fa:	75 b4                	jne    8b0 <malloc+0x40>
        return 0;
 8fc:	31 c0                	xor    %eax,%eax
 8fe:	eb 20                	jmp    920 <malloc+0xb0>
    if(p->s.size >= nunits){
 900:	89 d0                	mov    %edx,%eax
 902:	89 da                	mov    %ebx,%edx
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 908:	39 fe                	cmp    %edi,%esi
 90a:	74 1c                	je     928 <malloc+0xb8>
        p->s.size -= nunits;
 90c:	29 f7                	sub    %esi,%edi
 90e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 911:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 914:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 917:	89 15 5c 0e 00 00    	mov    %edx,0xe5c
      return (void*)(p + 1);
 91d:	83 c0 08             	add    $0x8,%eax
  }
}
 920:	83 c4 1c             	add    $0x1c,%esp
 923:	5b                   	pop    %ebx
 924:	5e                   	pop    %esi
 925:	5f                   	pop    %edi
 926:	5d                   	pop    %ebp
 927:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 928:	8b 08                	mov    (%eax),%ecx
 92a:	89 0a                	mov    %ecx,(%edx)
 92c:	eb e9                	jmp    917 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 92e:	c7 05 5c 0e 00 00 60 	movl   $0xe60,0xe5c
 935:	0e 00 00 
    base.s.size = 0;
 938:	ba 60 0e 00 00       	mov    $0xe60,%edx
    base.s.ptr = freep = prevp = &base;
 93d:	c7 05 60 0e 00 00 60 	movl   $0xe60,0xe60
 944:	0e 00 00 
    base.s.size = 0;
 947:	c7 05 64 0e 00 00 00 	movl   $0x0,0xe64
 94e:	00 00 00 
 951:	e9 46 ff ff ff       	jmp    89c <malloc+0x2c>
 956:	66 90                	xchg   %ax,%ax
 958:	66 90                	xchg   %ax,%ax
 95a:	66 90                	xchg   %ax,%ax
 95c:	66 90                	xchg   %ax,%ax
 95e:	66 90                	xchg   %ax,%ax

00000960 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 960:	55                   	push   %ebp
 961:	89 e5                	mov    %esp,%ebp
 963:	53                   	push   %ebx
 964:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 967:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 96e:	e8 fd fe ff ff       	call   870 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 973:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 97a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 97c:	e8 ef fe ff ff       	call   870 <malloc>
    if (tstack == NULL) {
 981:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 983:	89 c2                	mov    %eax,%edx
 985:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 988:	0f 84 8a 00 00 00    	je     a18 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 98e:	25 ff 0f 00 00       	and    $0xfff,%eax
 993:	75 73                	jne    a08 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 995:	8b 45 10             	mov    0x10(%ebp),%eax
 998:	89 54 24 08          	mov    %edx,0x8(%esp)
 99c:	89 44 24 04          	mov    %eax,0x4(%esp)
 9a0:	8b 45 0c             	mov    0xc(%ebp),%eax
 9a3:	89 04 24             	mov    %eax,(%esp)
 9a6:	e8 57 fb ff ff       	call   502 <kthread_create>
 9ab:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 9ad:	89 44 24 10          	mov    %eax,0x10(%esp)
 9b1:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 9b8:	00 
 9b9:	c7 44 24 08 06 0b 00 	movl   $0xb06,0x8(%esp)
 9c0:	00 
 9c1:	c7 44 24 04 15 0b 00 	movl   $0xb15,0x4(%esp)
 9c8:	00 
 9c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9d0:	e8 eb fb ff ff       	call   5c0 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 9d5:	8b 03                	mov    (%ebx),%eax
 9d7:	c7 44 24 04 2c 0b 00 	movl   $0xb2c,0x4(%esp)
 9de:	00 
 9df:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9e6:	89 44 24 08          	mov    %eax,0x8(%esp)
 9ea:	e8 d1 fb ff ff       	call   5c0 <printf>
    
    if (bt->tid != 0) {
 9ef:	8b 03                	mov    (%ebx),%eax
 9f1:	85 c0                	test   %eax,%eax
 9f3:	74 23                	je     a18 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 9f5:	8b 45 08             	mov    0x8(%ebp),%eax
 9f8:	89 18                	mov    %ebx,(%eax)
        return 0;
 9fa:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 9fc:	83 c4 24             	add    $0x24,%esp
 9ff:	5b                   	pop    %ebx
 a00:	5d                   	pop    %ebp
 a01:	c3                   	ret    
 a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 a08:	29 c2                	sub    %eax,%edx
 a0a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 a10:	eb 83                	jmp    995 <benny_thread_create+0x35>
 a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 a18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 a1d:	eb dd                	jmp    9fc <benny_thread_create+0x9c>
 a1f:	90                   	nop

00000a20 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 a23:	8b 45 08             	mov    0x8(%ebp),%eax
}
 a26:	5d                   	pop    %ebp
    return bt->tid;
 a27:	8b 00                	mov    (%eax),%eax
}
 a29:	c3                   	ret    
 a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000a30 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	53                   	push   %ebx
 a34:	83 ec 14             	sub    $0x14,%esp
 a37:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 a3a:	8b 03                	mov    (%ebx),%eax
 a3c:	89 04 24             	mov    %eax,(%esp)
 a3f:	e8 c6 fa ff ff       	call   50a <kthread_join>
    if (retVal == 0) {
 a44:	85 c0                	test   %eax,%eax
 a46:	75 11                	jne    a59 <benny_thread_join+0x29>
        free(bt->tstack);
 a48:	8b 53 04             	mov    0x4(%ebx),%edx
 a4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a4e:	89 14 24             	mov    %edx,(%esp)
 a51:	e8 8a fd ff ff       	call   7e0 <free>
 a56:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 a59:	83 c4 14             	add    $0x14,%esp
 a5c:	5b                   	pop    %ebx
 a5d:	5d                   	pop    %ebp
 a5e:	c3                   	ret    
 a5f:	90                   	nop

00000a60 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 a60:	55                   	push   %ebp
 a61:	89 e5                	mov    %esp,%ebp
 a63:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 a66:	8b 45 08             	mov    0x8(%ebp),%eax
 a69:	89 04 24             	mov    %eax,(%esp)
 a6c:	e8 a1 fa ff ff       	call   512 <kthread_exit>
    return 0;
}
 a71:	31 c0                	xor    %eax,%eax
 a73:	c9                   	leave  
 a74:	c3                   	ret    
