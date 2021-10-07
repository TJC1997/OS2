
_thtst3:     file format elf32-i386


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
   9:	83 ec 50             	sub    $0x50,%esp
#ifdef KTHREADS
    // 3 really is a good number
    mysrand(3);

    lmatrix = malloc(sizeof(matrix_t));
   c:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    next = seed;
  13:	c7 05 b0 12 00 00 03 	movl   $0x3,0x12b0
  1a:	00 00 00 
    lmatrix = malloc(sizeof(matrix_t));
  1d:	e8 be 0b 00 00       	call   be0 <malloc>
    rmatrix = malloc(sizeof(matrix_t));
  22:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    lmatrix = malloc(sizeof(matrix_t));
  29:	a3 bc 12 00 00       	mov    %eax,0x12bc
    rmatrix = malloc(sizeof(matrix_t));
  2e:	e8 ad 0b 00 00       	call   be0 <malloc>
    omatrix = malloc(sizeof(matrix_t));
  33:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    rmatrix = malloc(sizeof(matrix_t));
  3a:	a3 b8 12 00 00       	mov    %eax,0x12b8
    omatrix = malloc(sizeof(matrix_t));
  3f:	e8 9c 0b 00 00       	call   be0 <malloc>

    if (argc < 2) {
  44:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
    omatrix = malloc(sizeof(matrix_t));
  48:	a3 c0 12 00 00       	mov    %eax,0x12c0
    if (argc < 2) {
  4d:	0f 8e c7 01 00 00    	jle    21a <main+0x21a>
        printf(2, "You must specify the number of threads to use\n");
        exit();
    }

    numThreads = atoi(argv[1]);
  53:	8b 45 0c             	mov    0xc(%ebp),%eax
  56:	8b 40 04             	mov    0x4(%eax),%eax
  59:	89 04 24             	mov    %eax,(%esp)
  5c:	e8 ef 06 00 00       	call   750 <atoi>
    printf(1, "num threads %d\n", numThreads);
  61:	c7 44 24 04 04 0e 00 	movl   $0xe04,0x4(%esp)
  68:	00 
  69:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  70:	89 44 24 08          	mov    %eax,0x8(%esp)
    numThreads = atoi(argv[1]);
  74:	a3 b4 12 00 00       	mov    %eax,0x12b4
    printf(1, "num threads %d\n", numThreads);
  79:	e8 b2 08 00 00       	call   930 <printf>
    if (numThreads < 1 || numThreads > MAX_THREADS) {
  7e:	a1 b4 12 00 00       	mov    0x12b4,%eax
  83:	83 e8 01             	sub    $0x1,%eax
  86:	83 f8 09             	cmp    $0x9,%eax
  89:	0f 87 72 01 00 00    	ja     201 <main+0x201>
    {
        long tcount = 0;
        // I'm trying to keep some presure off of malloc()
        benny_thread_t wthreads[MAX_THREADS];

        gen_data(lmatrix);
  8f:	a1 bc 12 00 00       	mov    0x12bc,%eax
  94:	e8 87 02 00 00       	call   320 <gen_data>
        gen_data(rmatrix);
  99:	a1 b8 12 00 00       	mov    0x12b8,%eax
  9e:	e8 7d 02 00 00       	call   320 <gen_data>

        printf(1, "%s %d: %d\n", __FILE__, __LINE__, numThreads);
  a3:	a1 b4 12 00 00       	mov    0x12b4,%eax
  a8:	c7 44 24 0c 62 00 00 	movl   $0x62,0xc(%esp)
  af:	00 
  b0:	c7 44 24 08 e8 0d 00 	movl   $0xde8,0x8(%esp)
  b7:	00 
  b8:	c7 44 24 04 f9 0d 00 	movl   $0xdf9,0x4(%esp)
  bf:	00 
  c0:	89 44 24 10          	mov    %eax,0x10(%esp)
  c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  cb:	e8 60 08 00 00       	call   930 <printf>
        omatrix->rows = lmatrix->rows;
  d0:	a1 bc 12 00 00       	mov    0x12bc,%eax
  d5:	8b 1d c0 12 00 00    	mov    0x12c0,%ebx
        omatrix->cols = rmatrix->cols;
  db:	8b 15 b8 12 00 00    	mov    0x12b8,%edx
        omatrix->rows = lmatrix->rows;
  e1:	8b 00                	mov    (%eax),%eax
  e3:	89 03                	mov    %eax,(%ebx)
        omatrix->cols = rmatrix->cols;
  e5:	8b 52 04             	mov    0x4(%edx),%edx
        omatrix->data = malloc(omatrix->rows * sizeof(MATRIX_TYPE *));
  e8:	c1 e0 02             	shl    $0x2,%eax
        omatrix->cols = rmatrix->cols;
  eb:	89 53 04             	mov    %edx,0x4(%ebx)
        omatrix->data = malloc(omatrix->rows * sizeof(MATRIX_TYPE *));
  ee:	89 04 24             	mov    %eax,(%esp)
  f1:	e8 ea 0a 00 00       	call   be0 <malloc>

        if (lmatrix->cols == rmatrix->rows) {
  f6:	8b 15 bc 12 00 00    	mov    0x12bc,%edx
        omatrix->data = malloc(omatrix->rows * sizeof(MATRIX_TYPE *));
  fc:	89 43 08             	mov    %eax,0x8(%ebx)
        if (lmatrix->cols == rmatrix->rows) {
  ff:	a1 b8 12 00 00       	mov    0x12b8,%eax
 104:	8b 00                	mov    (%eax),%eax
 106:	39 42 04             	cmp    %eax,0x4(%edx)
 109:	0f 84 24 01 00 00    	je     233 <main+0x233>
                printf(1, "  join thread %d %d\n", benny_thread_tid(wthreads[tcount]), tcount);
                benny_thread_join(wthreads[tcount]);
            }
        }
        else {
            printf(2, "*** the left matrix must have the "
 10f:	c7 44 24 04 90 0e 00 	movl   $0xe90,0x4(%esp)
 116:	00 
 117:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 11e:	e8 0d 08 00 00       	call   930 <printf>
                    "same number of colums as the right matrix has rows ***\n");
        }
    }

    output_matrix(omatrix);
 123:	8b 3d c0 12 00 00    	mov    0x12c0,%edi
{
    int file = 1;
    uint row = 0;
    uint col = 0;

    if (NULL != matrix) {
 129:	85 ff                	test   %edi,%edi
 12b:	0f 84 ad 00 00 00    	je     1de <main+0x1de>
        // always goes into the same file name
        file = open("op.txt", O_CREATE | O_RDWR);
 131:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
 138:	00 
 139:	c7 04 24 53 0e 00 00 	movl   $0xe53,(%esp)
 140:	e8 ad 06 00 00       	call   7f2 <open>
 145:	89 c3                	mov    %eax,%ebx

        printf(file,  "%d %d\n", matrix->rows, matrix->cols);
 147:	8b 47 04             	mov    0x4(%edi),%eax
 14a:	89 44 24 0c          	mov    %eax,0xc(%esp)
 14e:	8b 07                	mov    (%edi),%eax
 150:	c7 44 24 04 37 0e 00 	movl   $0xe37,0x4(%esp)
 157:	00 
 158:	89 1c 24             	mov    %ebx,(%esp)
 15b:	89 44 24 08          	mov    %eax,0x8(%esp)
 15f:	e8 cc 07 00 00       	call   930 <printf>
        for (row = 0; row < matrix->rows; row++) {
 164:	83 3f 00             	cmpl   $0x0,(%edi)
 167:	74 6d                	je     1d6 <main+0x1d6>
 169:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
 170:	00 
 171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            for (col = 0; col < matrix->cols; col++) {
 178:	8b 47 04             	mov    0x4(%edi),%eax
 17b:	85 c0                	test   %eax,%eax
 17d:	74 3a                	je     1b9 <main+0x1b9>
 17f:	8b 44 24 18          	mov    0x18(%esp),%eax
 183:	31 f6                	xor    %esi,%esi
 185:	c1 e0 02             	shl    $0x2,%eax
 188:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                printf(file, "%d ", matrix->data[row][col]);
 190:	8b 4f 08             	mov    0x8(%edi),%ecx
 193:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 197:	8b 0c 01             	mov    (%ecx,%eax,1),%ecx
 19a:	8b 0c b1             	mov    (%ecx,%esi,4),%ecx
            for (col = 0; col < matrix->cols; col++) {
 19d:	83 c6 01             	add    $0x1,%esi
                printf(file, "%d ", matrix->data[row][col]);
 1a0:	c7 44 24 04 5a 0e 00 	movl   $0xe5a,0x4(%esp)
 1a7:	00 
 1a8:	89 1c 24             	mov    %ebx,(%esp)
 1ab:	89 4c 24 08          	mov    %ecx,0x8(%esp)
 1af:	e8 7c 07 00 00       	call   930 <printf>
            for (col = 0; col < matrix->cols; col++) {
 1b4:	3b 77 04             	cmp    0x4(%edi),%esi
 1b7:	72 d7                	jb     190 <main+0x190>
            }
            printf(file, "\n");
 1b9:	c7 44 24 04 02 0e 00 	movl   $0xe02,0x4(%esp)
 1c0:	00 
 1c1:	89 1c 24             	mov    %ebx,(%esp)
 1c4:	e8 67 07 00 00       	call   930 <printf>
        for (row = 0; row < matrix->rows; row++) {
 1c9:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
 1ce:	8b 44 24 18          	mov    0x18(%esp),%eax
 1d2:	3b 07                	cmp    (%edi),%eax
 1d4:	72 a2                	jb     178 <main+0x178>
        }

        close(file);
 1d6:	89 1c 24             	mov    %ebx,(%esp)
 1d9:	e8 fc 05 00 00       	call   7da <close>
    free_matrix(lmatrix);
 1de:	a1 bc 12 00 00       	mov    0x12bc,%eax
 1e3:	e8 28 02 00 00       	call   410 <free_matrix>
    free_matrix(rmatrix);
 1e8:	a1 b8 12 00 00       	mov    0x12b8,%eax
 1ed:	e8 1e 02 00 00       	call   410 <free_matrix>
    free_matrix(omatrix);
 1f2:	a1 c0 12 00 00       	mov    0x12c0,%eax
 1f7:	e8 14 02 00 00       	call   410 <free_matrix>
    exit();
 1fc:	e8 b1 05 00 00       	call   7b2 <exit>
        printf(2, "Bad thread count\n");
 201:	c7 44 24 04 14 0e 00 	movl   $0xe14,0x4(%esp)
 208:	00 
 209:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 210:	e8 1b 07 00 00       	call   930 <printf>
        exit();
 215:	e8 98 05 00 00       	call   7b2 <exit>
        printf(2, "You must specify the number of threads to use\n");
 21a:	c7 44 24 04 60 0e 00 	movl   $0xe60,0x4(%esp)
 221:	00 
 222:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 229:	e8 02 07 00 00       	call   930 <printf>
        exit();
 22e:	e8 7f 05 00 00       	call   7b2 <exit>
            printf(1, "%s %d: %d\n", __FILE__, __LINE__, numThreads);
 233:	a1 b4 12 00 00       	mov    0x12b4,%eax
            for (tcount = 0; tcount < numThreads; tcount++) {
 238:	31 f6                	xor    %esi,%esi
            printf(1, "%s %d: %d\n", __FILE__, __LINE__, numThreads);
 23a:	c7 44 24 0c 68 00 00 	movl   $0x68,0xc(%esp)
 241:	00 
 242:	8d 5c 24 28          	lea    0x28(%esp),%ebx
 246:	c7 44 24 08 e8 0d 00 	movl   $0xde8,0x8(%esp)
 24d:	00 
 24e:	c7 44 24 04 f9 0d 00 	movl   $0xdf9,0x4(%esp)
 255:	00 
 256:	89 44 24 10          	mov    %eax,0x10(%esp)
 25a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 261:	e8 ca 06 00 00       	call   930 <printf>
            for (tcount = 0; tcount < numThreads; tcount++) {
 266:	83 3d b4 12 00 00 00 	cmpl   $0x0,0x12b4
 26d:	7e 67                	jle    2d6 <main+0x2d6>
 26f:	90                   	nop
                benny_thread_create(&(wthreads[tcount]), cal_rowThreadStep
 270:	89 74 24 08          	mov    %esi,0x8(%esp)
 274:	c7 44 24 04 60 04 00 	movl   $0x460,0x4(%esp)
 27b:	00 
 27c:	89 1c 24             	mov    %ebx,(%esp)
 27f:	e8 4c 0a 00 00       	call   cd0 <benny_thread_create>
                printf(1, "  created thread %d %d\n", benny_thread_tid(wthreads[tcount]), tcount);
 284:	8b 03                	mov    (%ebx),%eax
 286:	89 04 24             	mov    %eax,(%esp)
 289:	e8 02 0b 00 00       	call   d90 <benny_thread_tid>
 28e:	89 74 24 0c          	mov    %esi,0xc(%esp)
 292:	c7 44 24 04 26 0e 00 	movl   $0xe26,0x4(%esp)
 299:	00 
 29a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2a1:	89 44 24 08          	mov    %eax,0x8(%esp)
 2a5:	e8 86 06 00 00       	call   930 <printf>
                if (benny_thread_tid(wthreads[tcount]) < 1) {
 2aa:	8b 03                	mov    (%ebx),%eax
 2ac:	89 04 24             	mov    %eax,(%esp)
 2af:	e8 dc 0a 00 00       	call   d90 <benny_thread_tid>
 2b4:	85 c0                	test   %eax,%eax
 2b6:	0f 8e 40 ff ff ff    	jle    1fc <main+0x1fc>
                sleep(2);
 2bc:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
            for (tcount = 0; tcount < numThreads; tcount++) {
 2c3:	83 c6 01             	add    $0x1,%esi
 2c6:	83 c3 04             	add    $0x4,%ebx
                sleep(2);
 2c9:	e8 74 05 00 00       	call   842 <sleep>
            for (tcount = 0; tcount < numThreads; tcount++) {
 2ce:	39 35 b4 12 00 00    	cmp    %esi,0x12b4
 2d4:	7f 9a                	jg     270 <main+0x270>
 2d6:	31 db                	xor    %ebx,%ebx
 2d8:	eb 37                	jmp    311 <main+0x311>
                printf(1, "  join thread %d %d\n", benny_thread_tid(wthreads[tcount]), tcount);
 2da:	8b 44 9c 28          	mov    0x28(%esp,%ebx,4),%eax
 2de:	89 04 24             	mov    %eax,(%esp)
 2e1:	e8 aa 0a 00 00       	call   d90 <benny_thread_tid>
 2e6:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
 2ea:	c7 44 24 04 3e 0e 00 	movl   $0xe3e,0x4(%esp)
 2f1:	00 
 2f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 2f9:	89 44 24 08          	mov    %eax,0x8(%esp)
 2fd:	e8 2e 06 00 00       	call   930 <printf>
                benny_thread_join(wthreads[tcount]);
 302:	8b 44 9c 28          	mov    0x28(%esp,%ebx,4),%eax
            for (tcount = 0; tcount < numThreads; tcount++) {
 306:	83 c3 01             	add    $0x1,%ebx
                benny_thread_join(wthreads[tcount]);
 309:	89 04 24             	mov    %eax,(%esp)
 30c:	e8 8f 0a 00 00       	call   da0 <benny_thread_join>
            for (tcount = 0; tcount < numThreads; tcount++) {
 311:	3b 1d b4 12 00 00    	cmp    0x12b4,%ebx
 317:	7c c1                	jl     2da <main+0x2da>
 319:	e9 05 fe ff ff       	jmp    123 <main+0x123>
 31e:	66 90                	xchg   %ax,%ax

00000320 <gen_data>:
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	89 c7                	mov    %eax,%edi
 326:	56                   	push   %esi
 327:	53                   	push   %ebx
 328:	83 ec 2c             	sub    $0x2c,%esp
    matrix->rows = matrix->cols = MAX_MATRIX_SIZE;
 32b:	c7 40 04 1e 00 00 00 	movl   $0x1e,0x4(%eax)
 332:	c7 00 1e 00 00 00    	movl   $0x1e,(%eax)
        matrix->data = malloc(matrix->rows * sizeof(MATRIX_TYPE *));
 338:	c7 04 24 78 00 00 00 	movl   $0x78,(%esp)
 33f:	e8 9c 08 00 00       	call   be0 <malloc>
        for (row = 0; row < matrix->rows; row++) {
 344:	8b 0f                	mov    (%edi),%ecx
 346:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
 34d:	85 c9                	test   %ecx,%ecx
        matrix->data = malloc(matrix->rows * sizeof(MATRIX_TYPE *));
 34f:	89 47 08             	mov    %eax,0x8(%edi)
        for (row = 0; row < matrix->rows; row++) {
 352:	89 c3                	mov    %eax,%ebx
 354:	0f 84 ae 00 00 00    	je     408 <gen_data+0xe8>
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 360:	8b 45 d8             	mov    -0x28(%ebp),%eax
 363:	c1 e0 02             	shl    $0x2,%eax
            matrix->data[row] = malloc(matrix->cols * sizeof(MATRIX_TYPE));
 366:	01 c3                	add    %eax,%ebx
 368:	89 45 dc             	mov    %eax,-0x24(%ebp)
 36b:	8b 47 04             	mov    0x4(%edi),%eax
 36e:	c1 e0 02             	shl    $0x2,%eax
 371:	89 04 24             	mov    %eax,(%esp)
 374:	e8 67 08 00 00       	call   be0 <malloc>
            for (col = 0; col < matrix->cols; col++) {
 379:	31 c9                	xor    %ecx,%ecx
            matrix->data[row] = malloc(matrix->cols * sizeof(MATRIX_TYPE));
 37b:	89 03                	mov    %eax,(%ebx)
            for (col = 0; col < matrix->cols; col++) {
 37d:	8b 57 04             	mov    0x4(%edi),%edx
 380:	a1 b0 12 00 00       	mov    0x12b0,%eax
 385:	85 d2                	test   %edx,%edx
 387:	74 6c                	je     3f5 <gen_data+0xd5>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    next = next * 1103515245 + 12345;
 390:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
 396:	05 39 30 00 00       	add    $0x3039,%eax
 39b:	89 c2                	mov    %eax,%edx
 39d:	81 e2 00 00 01 00    	and    $0x10000,%edx
                neg = (myrand() % 2) == 0 ? 1 : -1;
 3a3:	83 fa 01             	cmp    $0x1,%edx
                matrix->data[row][col] = (myrand() % 100) * neg;
 3a6:	8b 55 dc             	mov    -0x24(%ebp),%edx
                neg = (myrand() % 2) == 0 ? 1 : -1;
 3a9:	19 db                	sbb    %ebx,%ebx
    next = next * 1103515245 + 12345;
 3ab:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
                neg = (myrand() % 2) == 0 ? 1 : -1;
 3b1:	83 e3 02             	and    $0x2,%ebx
 3b4:	83 eb 01             	sub    $0x1,%ebx
    next = next * 1103515245 + 12345;
 3b7:	05 39 30 00 00       	add    $0x3039,%eax
 3bc:	89 c6                	mov    %eax,%esi
 3be:	89 45 e0             	mov    %eax,-0x20(%ebp)
                matrix->data[row][col] = (myrand() % 100) * neg;
 3c1:	8b 47 08             	mov    0x8(%edi),%eax
    return((unsigned) (next / DIVISOR) % MYRAND_MAX);
 3c4:	c1 ee 10             	shr    $0x10,%esi
                matrix->data[row][col] = (myrand() % 100) * neg;
 3c7:	8b 04 10             	mov    (%eax,%edx,1),%eax
 3ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 3cd:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
 3d2:	f7 e6                	mul    %esi
 3d4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 3d7:	c1 ea 05             	shr    $0x5,%edx
 3da:	6b d2 64             	imul   $0x64,%edx,%edx
 3dd:	29 d6                	sub    %edx,%esi
 3df:	0f af de             	imul   %esi,%ebx
 3e2:	89 1c 88             	mov    %ebx,(%eax,%ecx,4)
            for (col = 0; col < matrix->cols; col++) {
 3e5:	83 c1 01             	add    $0x1,%ecx
 3e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
 3eb:	39 4f 04             	cmp    %ecx,0x4(%edi)
 3ee:	77 a0                	ja     390 <gen_data+0x70>
 3f0:	a3 b0 12 00 00       	mov    %eax,0x12b0
        for (row = 0; row < matrix->rows; row++) {
 3f5:	83 45 d8 01          	addl   $0x1,-0x28(%ebp)
 3f9:	8b 45 d8             	mov    -0x28(%ebp),%eax
 3fc:	39 07                	cmp    %eax,(%edi)
 3fe:	76 08                	jbe    408 <gen_data+0xe8>
 400:	8b 5f 08             	mov    0x8(%edi),%ebx
 403:	e9 58 ff ff ff       	jmp    360 <gen_data+0x40>
}
 408:	83 c4 2c             	add    $0x2c,%esp
 40b:	5b                   	pop    %ebx
 40c:	5e                   	pop    %esi
 40d:	5f                   	pop    %edi
 40e:	5d                   	pop    %ebp
 40f:	c3                   	ret    

00000410 <free_matrix>:
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	89 c6                	mov    %eax,%esi
 416:	53                   	push   %ebx
 417:	83 ec 10             	sub    $0x10,%esp
    if (matrix != NULL) {
 41a:	85 c0                	test   %eax,%eax
 41c:	74 32                	je     450 <free_matrix+0x40>
        for (row = 0; row < matrix->rows; row++) {
 41e:	8b 00                	mov    (%eax),%eax
 420:	31 db                	xor    %ebx,%ebx
 422:	85 c0                	test   %eax,%eax
 424:	74 17                	je     43d <free_matrix+0x2d>
 426:	66 90                	xchg   %ax,%ax
            free(matrix->data[row]);
 428:	8b 46 08             	mov    0x8(%esi),%eax
 42b:	8b 04 98             	mov    (%eax,%ebx,4),%eax
        for (row = 0; row < matrix->rows; row++) {
 42e:	83 c3 01             	add    $0x1,%ebx
            free(matrix->data[row]);
 431:	89 04 24             	mov    %eax,(%esp)
 434:	e8 17 07 00 00       	call   b50 <free>
        for (row = 0; row < matrix->rows; row++) {
 439:	39 1e                	cmp    %ebx,(%esi)
 43b:	77 eb                	ja     428 <free_matrix+0x18>
        free(matrix->data);
 43d:	8b 46 08             	mov    0x8(%esi),%eax
 440:	89 04 24             	mov    %eax,(%esp)
 443:	e8 08 07 00 00       	call   b50 <free>
        free(matrix);
 448:	89 34 24             	mov    %esi,(%esp)
 44b:	e8 00 07 00 00       	call   b50 <free>
}
 450:	83 c4 10             	add    $0x10,%esp
 453:	5b                   	pop    %ebx
 454:	5e                   	pop    %esi
 455:	5d                   	pop    %ebp
 456:	c3                   	ret    
 457:	89 f6                	mov    %esi,%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <cal_rowThreadStep>:
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	83 ec 4c             	sub    $0x4c,%esp
 469:	8b 45 08             	mov    0x8(%ebp),%eax
    printf(1, "thread: %s %d: %d\n", __FILE__, __LINE__, tid);
 46c:	c7 44 24 0c 8e 00 00 	movl   $0x8e,0xc(%esp)
 473:	00 
 474:	c7 44 24 08 e8 0d 00 	movl   $0xde8,0x8(%esp)
 47b:	00 
 47c:	c7 44 24 04 f1 0d 00 	movl   $0xdf1,0x4(%esp)
 483:	00 
 484:	89 44 24 10          	mov    %eax,0x10(%esp)
{
 488:	89 c3                	mov    %eax,%ebx
    printf(1, "thread: %s %d: %d\n", __FILE__, __LINE__, tid);
 48a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
{
 491:	89 45 c8             	mov    %eax,-0x38(%ebp)
    printf(1, "thread: %s %d: %d\n", __FILE__, __LINE__, tid);
 494:	e8 97 04 00 00       	call   930 <printf>
    for (row = tid; row < omatrix->rows; row += numThreads) {
 499:	8b 35 c0 12 00 00    	mov    0x12c0,%esi
 49f:	89 d8                	mov    %ebx,%eax
 4a1:	3b 1e                	cmp    (%esi),%ebx
 4a3:	89 75 d0             	mov    %esi,-0x30(%ebp)
 4a6:	0f 83 ca 00 00 00    	jae    576 <cal_rowThreadStep+0x116>
        calc_row(lmatrix, rmatrix, omatrix, row);
 4ac:	8b 1d b8 12 00 00    	mov    0x12b8,%ebx
    omat->data[calc_row] = malloc(omat->cols * sizeof(MATRIX_TYPE));
 4b2:	c1 e0 02             	shl    $0x2,%eax
 4b5:	8b 4d d0             	mov    -0x30(%ebp),%ecx
 4b8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        calc_row(lmatrix, rmatrix, omatrix, row);
 4bb:	89 de                	mov    %ebx,%esi
 4bd:	89 5d d8             	mov    %ebx,-0x28(%ebp)
 4c0:	8b 1d bc 12 00 00    	mov    0x12bc,%ebx
 4c6:	89 5d cc             	mov    %ebx,-0x34(%ebp)
    omat->data[calc_row] = malloc(omat->cols * sizeof(MATRIX_TYPE));
 4c9:	8b 59 08             	mov    0x8(%ecx),%ebx
 4cc:	01 c3                	add    %eax,%ebx
 4ce:	8b 41 04             	mov    0x4(%ecx),%eax
 4d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 4d4:	c1 e0 02             	shl    $0x2,%eax
 4d7:	89 04 24             	mov    %eax,(%esp)
 4da:	e8 01 07 00 00       	call   be0 <malloc>
 4df:	89 03                	mov    %eax,(%ebx)
    for (rcol = 0; rcol < rmat->cols; rcol++) {
 4e1:	8b 46 04             	mov    0x4(%esi),%eax
 4e4:	85 c0                	test   %eax,%eax
 4e6:	74 70                	je     558 <cal_rowThreadStep+0xf8>
 4e8:	31 db                	xor    %ebx,%ebx
 4ea:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
 4f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        for (lcol = 0; lcol < lmat->cols; lcol++) {
 4f8:	8b 75 cc             	mov    -0x34(%ebp),%esi
 4fb:	8b 46 04             	mov    0x4(%esi),%eax
 4fe:	85 c0                	test   %eax,%eax
 500:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 503:	0f 84 80 00 00 00    	je     589 <cal_rowThreadStep+0x129>
 509:	8b 46 08             	mov    0x8(%esi),%eax
 50c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 50f:	8b 3c 08             	mov    (%eax,%ecx,1),%edi
 512:	31 c9                	xor    %ecx,%ecx
 514:	8b 45 d8             	mov    -0x28(%ebp),%eax
 517:	89 7d e0             	mov    %edi,-0x20(%ebp)
 51a:	8b 70 08             	mov    0x8(%eax),%esi
 51d:	31 c0                	xor    %eax,%eax
 51f:	90                   	nop
            sum += lmat->data[calc_row][lcol] * rmat->data[lcol][rcol];
 520:	8b 7d e0             	mov    -0x20(%ebp),%edi
 523:	8b 14 87             	mov    (%edi,%eax,4),%edx
 526:	8b 3c 86             	mov    (%esi,%eax,4),%edi
        for (lcol = 0; lcol < lmat->cols; lcol++) {
 529:	83 c0 01             	add    $0x1,%eax
            sum += lmat->data[calc_row][lcol] * rmat->data[lcol][rcol];
 52c:	0f af 14 1f          	imul   (%edi,%ebx,1),%edx
 530:	01 d1                	add    %edx,%ecx
        for (lcol = 0; lcol < lmat->cols; lcol++) {
 532:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
 535:	75 e9                	jne    520 <cal_rowThreadStep+0xc0>
        omat->data[calc_row][rcol] = sum;
 537:	8b 45 d0             	mov    -0x30(%ebp),%eax
 53a:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    for (rcol = 0; rcol < rmat->cols; rcol++) {
 53d:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
        omat->data[calc_row][rcol] = sum;
 541:	8b 40 08             	mov    0x8(%eax),%eax
 544:	8b 04 30             	mov    (%eax,%esi,1),%eax
 547:	89 0c 18             	mov    %ecx,(%eax,%ebx,1)
    for (rcol = 0; rcol < rmat->cols; rcol++) {
 54a:	8b 45 d8             	mov    -0x28(%ebp),%eax
 54d:	83 c3 04             	add    $0x4,%ebx
 550:	8b 4d dc             	mov    -0x24(%ebp),%ecx
 553:	3b 48 04             	cmp    0x4(%eax),%ecx
 556:	72 a0                	jb     4f8 <cal_rowThreadStep+0x98>
    for (row = tid; row < omatrix->rows; row += numThreads) {
 558:	8b 1d c0 12 00 00    	mov    0x12c0,%ebx
 55e:	a1 b4 12 00 00       	mov    0x12b4,%eax
 563:	01 45 c8             	add    %eax,-0x38(%ebp)
 566:	8b 75 c8             	mov    -0x38(%ebp),%esi
 569:	3b 33                	cmp    (%ebx),%esi
 56b:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 56e:	89 f0                	mov    %esi,%eax
 570:	0f 82 36 ff ff ff    	jb     4ac <cal_rowThreadStep+0x4c>
    benny_thread_exit(7);
 576:	c7 45 08 07 00 00 00 	movl   $0x7,0x8(%ebp)
}
 57d:	83 c4 4c             	add    $0x4c,%esp
 580:	5b                   	pop    %ebx
 581:	5e                   	pop    %esi
 582:	5f                   	pop    %edi
 583:	5d                   	pop    %ebp
    benny_thread_exit(7);
 584:	e9 47 08 00 00       	jmp    dd0 <benny_thread_exit>
        for (lcol = 0; lcol < lmat->cols; lcol++) {
 589:	31 c9                	xor    %ecx,%ecx
 58b:	eb aa                	jmp    537 <cal_rowThreadStep+0xd7>
 58d:	66 90                	xchg   %ax,%ax
 58f:	90                   	nop

00000590 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	8b 45 08             	mov    0x8(%ebp),%eax
 596:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 599:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 59a:	89 c2                	mov    %eax,%edx
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5a0:	83 c1 01             	add    $0x1,%ecx
 5a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 5a7:	83 c2 01             	add    $0x1,%edx
 5aa:	84 db                	test   %bl,%bl
 5ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 5af:	75 ef                	jne    5a0 <strcpy+0x10>
    ;
  return os;
}
 5b1:	5b                   	pop    %ebx
 5b2:	5d                   	pop    %ebp
 5b3:	c3                   	ret    
 5b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000005c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	8b 55 08             	mov    0x8(%ebp),%edx
 5c6:	53                   	push   %ebx
 5c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 5ca:	0f b6 02             	movzbl (%edx),%eax
 5cd:	84 c0                	test   %al,%al
 5cf:	74 2d                	je     5fe <strcmp+0x3e>
 5d1:	0f b6 19             	movzbl (%ecx),%ebx
 5d4:	38 d8                	cmp    %bl,%al
 5d6:	74 0e                	je     5e6 <strcmp+0x26>
 5d8:	eb 2b                	jmp    605 <strcmp+0x45>
 5da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5e0:	38 c8                	cmp    %cl,%al
 5e2:	75 15                	jne    5f9 <strcmp+0x39>
    p++, q++;
 5e4:	89 d9                	mov    %ebx,%ecx
 5e6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 5e9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 5ec:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 5ef:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 5f3:	84 c0                	test   %al,%al
 5f5:	75 e9                	jne    5e0 <strcmp+0x20>
 5f7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 5f9:	29 c8                	sub    %ecx,%eax
}
 5fb:	5b                   	pop    %ebx
 5fc:	5d                   	pop    %ebp
 5fd:	c3                   	ret    
 5fe:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 601:	31 c0                	xor    %eax,%eax
 603:	eb f4                	jmp    5f9 <strcmp+0x39>
 605:	0f b6 cb             	movzbl %bl,%ecx
 608:	eb ef                	jmp    5f9 <strcmp+0x39>
 60a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000610 <strlen>:

uint
strlen(const char *s)
{
 610:	55                   	push   %ebp
 611:	89 e5                	mov    %esp,%ebp
 613:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 616:	80 39 00             	cmpb   $0x0,(%ecx)
 619:	74 12                	je     62d <strlen+0x1d>
 61b:	31 d2                	xor    %edx,%edx
 61d:	8d 76 00             	lea    0x0(%esi),%esi
 620:	83 c2 01             	add    $0x1,%edx
 623:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 627:	89 d0                	mov    %edx,%eax
 629:	75 f5                	jne    620 <strlen+0x10>
    ;
  return n;
}
 62b:	5d                   	pop    %ebp
 62c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 62d:	31 c0                	xor    %eax,%eax
}
 62f:	5d                   	pop    %ebp
 630:	c3                   	ret    
 631:	eb 0d                	jmp    640 <memset>
 633:	90                   	nop
 634:	90                   	nop
 635:	90                   	nop
 636:	90                   	nop
 637:	90                   	nop
 638:	90                   	nop
 639:	90                   	nop
 63a:	90                   	nop
 63b:	90                   	nop
 63c:	90                   	nop
 63d:	90                   	nop
 63e:	90                   	nop
 63f:	90                   	nop

00000640 <memset>:

void*
memset(void *dst, int c, uint n)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	8b 55 08             	mov    0x8(%ebp),%edx
 646:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 647:	8b 4d 10             	mov    0x10(%ebp),%ecx
 64a:	8b 45 0c             	mov    0xc(%ebp),%eax
 64d:	89 d7                	mov    %edx,%edi
 64f:	fc                   	cld    
 650:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 652:	89 d0                	mov    %edx,%eax
 654:	5f                   	pop    %edi
 655:	5d                   	pop    %ebp
 656:	c3                   	ret    
 657:	89 f6                	mov    %esi,%esi
 659:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000660 <strchr>:

char*
strchr(const char *s, char c)
{
 660:	55                   	push   %ebp
 661:	89 e5                	mov    %esp,%ebp
 663:	8b 45 08             	mov    0x8(%ebp),%eax
 666:	53                   	push   %ebx
 667:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 66a:	0f b6 18             	movzbl (%eax),%ebx
 66d:	84 db                	test   %bl,%bl
 66f:	74 1d                	je     68e <strchr+0x2e>
    if(*s == c)
 671:	38 d3                	cmp    %dl,%bl
 673:	89 d1                	mov    %edx,%ecx
 675:	75 0d                	jne    684 <strchr+0x24>
 677:	eb 17                	jmp    690 <strchr+0x30>
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 680:	38 ca                	cmp    %cl,%dl
 682:	74 0c                	je     690 <strchr+0x30>
  for(; *s; s++)
 684:	83 c0 01             	add    $0x1,%eax
 687:	0f b6 10             	movzbl (%eax),%edx
 68a:	84 d2                	test   %dl,%dl
 68c:	75 f2                	jne    680 <strchr+0x20>
      return (char*)s;
  return 0;
 68e:	31 c0                	xor    %eax,%eax
}
 690:	5b                   	pop    %ebx
 691:	5d                   	pop    %ebp
 692:	c3                   	ret    
 693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000006a0 <gets>:

char*
gets(char *buf, int max)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	57                   	push   %edi
 6a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 6a5:	31 f6                	xor    %esi,%esi
{
 6a7:	53                   	push   %ebx
 6a8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 6ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 6ae:	eb 31                	jmp    6e1 <gets+0x41>
    cc = read(0, &c, 1);
 6b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b7:	00 
 6b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 6bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6c3:	e8 02 01 00 00       	call   7ca <read>
    if(cc < 1)
 6c8:	85 c0                	test   %eax,%eax
 6ca:	7e 1d                	jle    6e9 <gets+0x49>
      break;
    buf[i++] = c;
 6cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 6d0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 6d2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 6d5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 6d7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 6db:	74 0c                	je     6e9 <gets+0x49>
 6dd:	3c 0a                	cmp    $0xa,%al
 6df:	74 08                	je     6e9 <gets+0x49>
  for(i=0; i+1 < max; ){
 6e1:	8d 5e 01             	lea    0x1(%esi),%ebx
 6e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 6e7:	7c c7                	jl     6b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 6e9:	8b 45 08             	mov    0x8(%ebp),%eax
 6ec:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 6f0:	83 c4 2c             	add    $0x2c,%esp
 6f3:	5b                   	pop    %ebx
 6f4:	5e                   	pop    %esi
 6f5:	5f                   	pop    %edi
 6f6:	5d                   	pop    %ebp
 6f7:	c3                   	ret    
 6f8:	90                   	nop
 6f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000700 <stat>:

int
stat(const char *n, struct stat *st)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	56                   	push   %esi
 704:	53                   	push   %ebx
 705:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 708:	8b 45 08             	mov    0x8(%ebp),%eax
 70b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 712:	00 
 713:	89 04 24             	mov    %eax,(%esp)
 716:	e8 d7 00 00 00       	call   7f2 <open>
  if(fd < 0)
 71b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 71d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 71f:	78 27                	js     748 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 721:	8b 45 0c             	mov    0xc(%ebp),%eax
 724:	89 1c 24             	mov    %ebx,(%esp)
 727:	89 44 24 04          	mov    %eax,0x4(%esp)
 72b:	e8 da 00 00 00       	call   80a <fstat>
  close(fd);
 730:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 733:	89 c6                	mov    %eax,%esi
  close(fd);
 735:	e8 a0 00 00 00       	call   7da <close>
  return r;
 73a:	89 f0                	mov    %esi,%eax
}
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	5b                   	pop    %ebx
 740:	5e                   	pop    %esi
 741:	5d                   	pop    %ebp
 742:	c3                   	ret    
 743:	90                   	nop
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 748:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 74d:	eb ed                	jmp    73c <stat+0x3c>
 74f:	90                   	nop

00000750 <atoi>:

int
atoi(const char *s)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	8b 4d 08             	mov    0x8(%ebp),%ecx
 756:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 757:	0f be 11             	movsbl (%ecx),%edx
 75a:	8d 42 d0             	lea    -0x30(%edx),%eax
 75d:	3c 09                	cmp    $0x9,%al
  n = 0;
 75f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 764:	77 17                	ja     77d <atoi+0x2d>
 766:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 768:	83 c1 01             	add    $0x1,%ecx
 76b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 76e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 772:	0f be 11             	movsbl (%ecx),%edx
 775:	8d 5a d0             	lea    -0x30(%edx),%ebx
 778:	80 fb 09             	cmp    $0x9,%bl
 77b:	76 eb                	jbe    768 <atoi+0x18>
  return n;
}
 77d:	5b                   	pop    %ebx
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    

00000780 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 780:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 781:	31 d2                	xor    %edx,%edx
{
 783:	89 e5                	mov    %esp,%ebp
 785:	56                   	push   %esi
 786:	8b 45 08             	mov    0x8(%ebp),%eax
 789:	53                   	push   %ebx
 78a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 78d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 790:	85 db                	test   %ebx,%ebx
 792:	7e 12                	jle    7a6 <memmove+0x26>
 794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 798:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 79c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 79f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 7a2:	39 da                	cmp    %ebx,%edx
 7a4:	75 f2                	jne    798 <memmove+0x18>
  return vdst;
}
 7a6:	5b                   	pop    %ebx
 7a7:	5e                   	pop    %esi
 7a8:	5d                   	pop    %ebp
 7a9:	c3                   	ret    

000007aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 7aa:	b8 01 00 00 00       	mov    $0x1,%eax
 7af:	cd 40                	int    $0x40
 7b1:	c3                   	ret    

000007b2 <exit>:
SYSCALL(exit)
 7b2:	b8 02 00 00 00       	mov    $0x2,%eax
 7b7:	cd 40                	int    $0x40
 7b9:	c3                   	ret    

000007ba <wait>:
SYSCALL(wait)
 7ba:	b8 03 00 00 00       	mov    $0x3,%eax
 7bf:	cd 40                	int    $0x40
 7c1:	c3                   	ret    

000007c2 <pipe>:
SYSCALL(pipe)
 7c2:	b8 04 00 00 00       	mov    $0x4,%eax
 7c7:	cd 40                	int    $0x40
 7c9:	c3                   	ret    

000007ca <read>:
SYSCALL(read)
 7ca:	b8 05 00 00 00       	mov    $0x5,%eax
 7cf:	cd 40                	int    $0x40
 7d1:	c3                   	ret    

000007d2 <write>:
SYSCALL(write)
 7d2:	b8 10 00 00 00       	mov    $0x10,%eax
 7d7:	cd 40                	int    $0x40
 7d9:	c3                   	ret    

000007da <close>:
SYSCALL(close)
 7da:	b8 15 00 00 00       	mov    $0x15,%eax
 7df:	cd 40                	int    $0x40
 7e1:	c3                   	ret    

000007e2 <kill>:
SYSCALL(kill)
 7e2:	b8 06 00 00 00       	mov    $0x6,%eax
 7e7:	cd 40                	int    $0x40
 7e9:	c3                   	ret    

000007ea <exec>:
SYSCALL(exec)
 7ea:	b8 07 00 00 00       	mov    $0x7,%eax
 7ef:	cd 40                	int    $0x40
 7f1:	c3                   	ret    

000007f2 <open>:
SYSCALL(open)
 7f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 7f7:	cd 40                	int    $0x40
 7f9:	c3                   	ret    

000007fa <mknod>:
SYSCALL(mknod)
 7fa:	b8 11 00 00 00       	mov    $0x11,%eax
 7ff:	cd 40                	int    $0x40
 801:	c3                   	ret    

00000802 <unlink>:
SYSCALL(unlink)
 802:	b8 12 00 00 00       	mov    $0x12,%eax
 807:	cd 40                	int    $0x40
 809:	c3                   	ret    

0000080a <fstat>:
SYSCALL(fstat)
 80a:	b8 08 00 00 00       	mov    $0x8,%eax
 80f:	cd 40                	int    $0x40
 811:	c3                   	ret    

00000812 <link>:
SYSCALL(link)
 812:	b8 13 00 00 00       	mov    $0x13,%eax
 817:	cd 40                	int    $0x40
 819:	c3                   	ret    

0000081a <mkdir>:
SYSCALL(mkdir)
 81a:	b8 14 00 00 00       	mov    $0x14,%eax
 81f:	cd 40                	int    $0x40
 821:	c3                   	ret    

00000822 <chdir>:
SYSCALL(chdir)
 822:	b8 09 00 00 00       	mov    $0x9,%eax
 827:	cd 40                	int    $0x40
 829:	c3                   	ret    

0000082a <dup>:
SYSCALL(dup)
 82a:	b8 0a 00 00 00       	mov    $0xa,%eax
 82f:	cd 40                	int    $0x40
 831:	c3                   	ret    

00000832 <getpid>:
SYSCALL(getpid)
 832:	b8 0b 00 00 00       	mov    $0xb,%eax
 837:	cd 40                	int    $0x40
 839:	c3                   	ret    

0000083a <sbrk>:
SYSCALL(sbrk)
 83a:	b8 0c 00 00 00       	mov    $0xc,%eax
 83f:	cd 40                	int    $0x40
 841:	c3                   	ret    

00000842 <sleep>:
SYSCALL(sleep)
 842:	b8 0d 00 00 00       	mov    $0xd,%eax
 847:	cd 40                	int    $0x40
 849:	c3                   	ret    

0000084a <uptime>:
SYSCALL(uptime)
 84a:	b8 0e 00 00 00       	mov    $0xe,%eax
 84f:	cd 40                	int    $0x40
 851:	c3                   	ret    

00000852 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 852:	b8 16 00 00 00       	mov    $0x16,%eax
 857:	cd 40                	int    $0x40
 859:	c3                   	ret    

0000085a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 85a:	b8 17 00 00 00       	mov    $0x17,%eax
 85f:	cd 40                	int    $0x40
 861:	c3                   	ret    

00000862 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 862:	b8 18 00 00 00       	mov    $0x18,%eax
 867:	cd 40                	int    $0x40
 869:	c3                   	ret    

0000086a <halt>:
SYSCALL(halt)
 86a:	b8 19 00 00 00       	mov    $0x19,%eax
 86f:	cd 40                	int    $0x40
 871:	c3                   	ret    

00000872 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 872:	b8 1a 00 00 00       	mov    $0x1a,%eax
 877:	cd 40                	int    $0x40
 879:	c3                   	ret    

0000087a <kthread_join>:
SYSCALL(kthread_join)
 87a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 87f:	cd 40                	int    $0x40
 881:	c3                   	ret    

00000882 <kthread_exit>:
SYSCALL(kthread_exit)
 882:	b8 1c 00 00 00       	mov    $0x1c,%eax
 887:	cd 40                	int    $0x40
 889:	c3                   	ret    
 88a:	66 90                	xchg   %ax,%ax
 88c:	66 90                	xchg   %ax,%ax
 88e:	66 90                	xchg   %ax,%ax

00000890 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	57                   	push   %edi
 894:	56                   	push   %esi
 895:	89 c6                	mov    %eax,%esi
 897:	53                   	push   %ebx
 898:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 89b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 89e:	85 db                	test   %ebx,%ebx
 8a0:	74 09                	je     8ab <printint+0x1b>
 8a2:	89 d0                	mov    %edx,%eax
 8a4:	c1 e8 1f             	shr    $0x1f,%eax
 8a7:	84 c0                	test   %al,%al
 8a9:	75 75                	jne    920 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 8ab:	89 d0                	mov    %edx,%eax
  neg = 0;
 8ad:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8b4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 8b7:	31 ff                	xor    %edi,%edi
 8b9:	89 ce                	mov    %ecx,%esi
 8bb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 8be:	eb 02                	jmp    8c2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 8c0:	89 cf                	mov    %ecx,%edi
 8c2:	31 d2                	xor    %edx,%edx
 8c4:	f7 f6                	div    %esi
 8c6:	8d 4f 01             	lea    0x1(%edi),%ecx
 8c9:	0f b6 92 f3 0e 00 00 	movzbl 0xef3(%edx),%edx
  }while((x /= base) != 0);
 8d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 8d2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 8d5:	75 e9                	jne    8c0 <printint+0x30>
  if(neg)
 8d7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 8da:	89 c8                	mov    %ecx,%eax
 8dc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 8df:	85 d2                	test   %edx,%edx
 8e1:	74 08                	je     8eb <printint+0x5b>
    buf[i++] = '-';
 8e3:	8d 4f 02             	lea    0x2(%edi),%ecx
 8e6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 8eb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 8ee:	66 90                	xchg   %ax,%ax
 8f0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 8f5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 8f8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 8ff:	00 
 900:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 904:	89 34 24             	mov    %esi,(%esp)
 907:	88 45 d7             	mov    %al,-0x29(%ebp)
 90a:	e8 c3 fe ff ff       	call   7d2 <write>
  while(--i >= 0)
 90f:	83 ff ff             	cmp    $0xffffffff,%edi
 912:	75 dc                	jne    8f0 <printint+0x60>
    putc(fd, buf[i]);
}
 914:	83 c4 4c             	add    $0x4c,%esp
 917:	5b                   	pop    %ebx
 918:	5e                   	pop    %esi
 919:	5f                   	pop    %edi
 91a:	5d                   	pop    %ebp
 91b:	c3                   	ret    
 91c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 920:	89 d0                	mov    %edx,%eax
 922:	f7 d8                	neg    %eax
    neg = 1;
 924:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 92b:	eb 87                	jmp    8b4 <printint+0x24>
 92d:	8d 76 00             	lea    0x0(%esi),%esi

00000930 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 930:	55                   	push   %ebp
 931:	89 e5                	mov    %esp,%ebp
 933:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 934:	31 ff                	xor    %edi,%edi
{
 936:	56                   	push   %esi
 937:	53                   	push   %ebx
 938:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 93b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 93e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 941:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 944:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 947:	0f b6 13             	movzbl (%ebx),%edx
 94a:	83 c3 01             	add    $0x1,%ebx
 94d:	84 d2                	test   %dl,%dl
 94f:	75 39                	jne    98a <printf+0x5a>
 951:	e9 ca 00 00 00       	jmp    a20 <printf+0xf0>
 956:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 958:	83 fa 25             	cmp    $0x25,%edx
 95b:	0f 84 c7 00 00 00    	je     a28 <printf+0xf8>
  write(fd, &c, 1);
 961:	8d 45 e0             	lea    -0x20(%ebp),%eax
 964:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 96b:	00 
 96c:	89 44 24 04          	mov    %eax,0x4(%esp)
 970:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 973:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 976:	e8 57 fe ff ff       	call   7d2 <write>
 97b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 97e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 982:	84 d2                	test   %dl,%dl
 984:	0f 84 96 00 00 00    	je     a20 <printf+0xf0>
    if(state == 0){
 98a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 98c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 98f:	74 c7                	je     958 <printf+0x28>
      }
    } else if(state == '%'){
 991:	83 ff 25             	cmp    $0x25,%edi
 994:	75 e5                	jne    97b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 996:	83 fa 75             	cmp    $0x75,%edx
 999:	0f 84 99 00 00 00    	je     a38 <printf+0x108>
 99f:	83 fa 64             	cmp    $0x64,%edx
 9a2:	0f 84 90 00 00 00    	je     a38 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 9a8:	25 f7 00 00 00       	and    $0xf7,%eax
 9ad:	83 f8 70             	cmp    $0x70,%eax
 9b0:	0f 84 aa 00 00 00    	je     a60 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 9b6:	83 fa 73             	cmp    $0x73,%edx
 9b9:	0f 84 e9 00 00 00    	je     aa8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 9bf:	83 fa 63             	cmp    $0x63,%edx
 9c2:	0f 84 2b 01 00 00    	je     af3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 9c8:	83 fa 25             	cmp    $0x25,%edx
 9cb:	0f 84 4f 01 00 00    	je     b20 <printf+0x1f0>
  write(fd, &c, 1);
 9d1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9d4:	83 c3 01             	add    $0x1,%ebx
 9d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 9de:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9df:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9e1:	89 44 24 04          	mov    %eax,0x4(%esp)
 9e5:	89 34 24             	mov    %esi,(%esp)
 9e8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 9eb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 9ef:	e8 de fd ff ff       	call   7d2 <write>
        putc(fd, c);
 9f4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 9f7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a01:	00 
 a02:	89 44 24 04          	mov    %eax,0x4(%esp)
 a06:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 a09:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a0c:	e8 c1 fd ff ff       	call   7d2 <write>
  for(i = 0; fmt[i]; i++){
 a11:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 a15:	84 d2                	test   %dl,%dl
 a17:	0f 85 6d ff ff ff    	jne    98a <printf+0x5a>
 a1d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 a20:	83 c4 3c             	add    $0x3c,%esp
 a23:	5b                   	pop    %ebx
 a24:	5e                   	pop    %esi
 a25:	5f                   	pop    %edi
 a26:	5d                   	pop    %ebp
 a27:	c3                   	ret    
        state = '%';
 a28:	bf 25 00 00 00       	mov    $0x25,%edi
 a2d:	e9 49 ff ff ff       	jmp    97b <printf+0x4b>
 a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 a38:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 a3f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 a44:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 a47:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 a49:	8b 10                	mov    (%eax),%edx
 a4b:	89 f0                	mov    %esi,%eax
 a4d:	e8 3e fe ff ff       	call   890 <printint>
        ap++;
 a52:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 a56:	e9 20 ff ff ff       	jmp    97b <printf+0x4b>
 a5b:	90                   	nop
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 a60:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 a63:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a6a:	00 
 a6b:	89 44 24 04          	mov    %eax,0x4(%esp)
 a6f:	89 34 24             	mov    %esi,(%esp)
 a72:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 a76:	e8 57 fd ff ff       	call   7d2 <write>
 a7b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 a7e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 a85:	00 
 a86:	89 44 24 04          	mov    %eax,0x4(%esp)
 a8a:	89 34 24             	mov    %esi,(%esp)
 a8d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 a91:	e8 3c fd ff ff       	call   7d2 <write>
        printint(fd, *ap, 16, 0);
 a96:	b9 10 00 00 00       	mov    $0x10,%ecx
 a9b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 aa2:	eb a0                	jmp    a44 <printf+0x114>
 aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 aa8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 aab:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 aaf:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 ab1:	b8 ec 0e 00 00       	mov    $0xeec,%eax
 ab6:	85 ff                	test   %edi,%edi
 ab8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 abb:	0f b6 07             	movzbl (%edi),%eax
 abe:	84 c0                	test   %al,%al
 ac0:	74 2a                	je     aec <printf+0x1bc>
 ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 ac8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 acb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 ace:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 ad1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 ad8:	00 
 ad9:	89 44 24 04          	mov    %eax,0x4(%esp)
 add:	89 34 24             	mov    %esi,(%esp)
 ae0:	e8 ed fc ff ff       	call   7d2 <write>
        while(*s != 0){
 ae5:	0f b6 07             	movzbl (%edi),%eax
 ae8:	84 c0                	test   %al,%al
 aea:	75 dc                	jne    ac8 <printf+0x198>
      state = 0;
 aec:	31 ff                	xor    %edi,%edi
 aee:	e9 88 fe ff ff       	jmp    97b <printf+0x4b>
        putc(fd, *ap);
 af3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 af6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 af8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 afa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 b01:	00 
 b02:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 b05:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 b08:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 b0b:	89 44 24 04          	mov    %eax,0x4(%esp)
 b0f:	e8 be fc ff ff       	call   7d2 <write>
        ap++;
 b14:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 b18:	e9 5e fe ff ff       	jmp    97b <printf+0x4b>
 b1d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 b20:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 b23:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 b25:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 b2c:	00 
 b2d:	89 44 24 04          	mov    %eax,0x4(%esp)
 b31:	89 34 24             	mov    %esi,(%esp)
 b34:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 b38:	e8 95 fc ff ff       	call   7d2 <write>
 b3d:	e9 39 fe ff ff       	jmp    97b <printf+0x4b>
 b42:	66 90                	xchg   %ax,%ax
 b44:	66 90                	xchg   %ax,%ax
 b46:	66 90                	xchg   %ax,%ax
 b48:	66 90                	xchg   %ax,%ax
 b4a:	66 90                	xchg   %ax,%ax
 b4c:	66 90                	xchg   %ax,%ax
 b4e:	66 90                	xchg   %ax,%ax

00000b50 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b50:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b51:	a1 c4 12 00 00       	mov    0x12c4,%eax
{
 b56:	89 e5                	mov    %esp,%ebp
 b58:	57                   	push   %edi
 b59:	56                   	push   %esi
 b5a:	53                   	push   %ebx
 b5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b5e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 b60:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b63:	39 d0                	cmp    %edx,%eax
 b65:	72 11                	jb     b78 <free+0x28>
 b67:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b68:	39 c8                	cmp    %ecx,%eax
 b6a:	72 04                	jb     b70 <free+0x20>
 b6c:	39 ca                	cmp    %ecx,%edx
 b6e:	72 10                	jb     b80 <free+0x30>
 b70:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b72:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b74:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b76:	73 f0                	jae    b68 <free+0x18>
 b78:	39 ca                	cmp    %ecx,%edx
 b7a:	72 04                	jb     b80 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b7c:	39 c8                	cmp    %ecx,%eax
 b7e:	72 f0                	jb     b70 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b80:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b83:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 b86:	39 cf                	cmp    %ecx,%edi
 b88:	74 1e                	je     ba8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b8a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b8d:	8b 48 04             	mov    0x4(%eax),%ecx
 b90:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 b93:	39 f2                	cmp    %esi,%edx
 b95:	74 28                	je     bbf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b97:	89 10                	mov    %edx,(%eax)
  freep = p;
 b99:	a3 c4 12 00 00       	mov    %eax,0x12c4
}
 b9e:	5b                   	pop    %ebx
 b9f:	5e                   	pop    %esi
 ba0:	5f                   	pop    %edi
 ba1:	5d                   	pop    %ebp
 ba2:	c3                   	ret    
 ba3:	90                   	nop
 ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ba8:	03 71 04             	add    0x4(%ecx),%esi
 bab:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 bae:	8b 08                	mov    (%eax),%ecx
 bb0:	8b 09                	mov    (%ecx),%ecx
 bb2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 bb5:	8b 48 04             	mov    0x4(%eax),%ecx
 bb8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 bbb:	39 f2                	cmp    %esi,%edx
 bbd:	75 d8                	jne    b97 <free+0x47>
    p->s.size += bp->s.size;
 bbf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 bc2:	a3 c4 12 00 00       	mov    %eax,0x12c4
    p->s.size += bp->s.size;
 bc7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 bca:	8b 53 f8             	mov    -0x8(%ebx),%edx
 bcd:	89 10                	mov    %edx,(%eax)
}
 bcf:	5b                   	pop    %ebx
 bd0:	5e                   	pop    %esi
 bd1:	5f                   	pop    %edi
 bd2:	5d                   	pop    %ebp
 bd3:	c3                   	ret    
 bd4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 bda:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000be0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 be0:	55                   	push   %ebp
 be1:	89 e5                	mov    %esp,%ebp
 be3:	57                   	push   %edi
 be4:	56                   	push   %esi
 be5:	53                   	push   %ebx
 be6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 be9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 bec:	8b 1d c4 12 00 00    	mov    0x12c4,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bf2:	8d 48 07             	lea    0x7(%eax),%ecx
 bf5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 bf8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 bfa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 bfd:	0f 84 9b 00 00 00    	je     c9e <malloc+0xbe>
 c03:	8b 13                	mov    (%ebx),%edx
 c05:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 c08:	39 fe                	cmp    %edi,%esi
 c0a:	76 64                	jbe    c70 <malloc+0x90>
 c0c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 c13:	bb 00 80 00 00       	mov    $0x8000,%ebx
 c18:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 c1b:	eb 0e                	jmp    c2b <malloc+0x4b>
 c1d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 c20:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 c22:	8b 78 04             	mov    0x4(%eax),%edi
 c25:	39 fe                	cmp    %edi,%esi
 c27:	76 4f                	jbe    c78 <malloc+0x98>
 c29:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 c2b:	3b 15 c4 12 00 00    	cmp    0x12c4,%edx
 c31:	75 ed                	jne    c20 <malloc+0x40>
  if(nu < 4096)
 c33:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 c36:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 c3c:	bf 00 10 00 00       	mov    $0x1000,%edi
 c41:	0f 43 fe             	cmovae %esi,%edi
 c44:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 c47:	89 04 24             	mov    %eax,(%esp)
 c4a:	e8 eb fb ff ff       	call   83a <sbrk>
  if(p == (char*)-1)
 c4f:	83 f8 ff             	cmp    $0xffffffff,%eax
 c52:	74 18                	je     c6c <malloc+0x8c>
  hp->s.size = nu;
 c54:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 c57:	83 c0 08             	add    $0x8,%eax
 c5a:	89 04 24             	mov    %eax,(%esp)
 c5d:	e8 ee fe ff ff       	call   b50 <free>
  return freep;
 c62:	8b 15 c4 12 00 00    	mov    0x12c4,%edx
      if((p = morecore(nunits)) == 0)
 c68:	85 d2                	test   %edx,%edx
 c6a:	75 b4                	jne    c20 <malloc+0x40>
        return 0;
 c6c:	31 c0                	xor    %eax,%eax
 c6e:	eb 20                	jmp    c90 <malloc+0xb0>
    if(p->s.size >= nunits){
 c70:	89 d0                	mov    %edx,%eax
 c72:	89 da                	mov    %ebx,%edx
 c74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 c78:	39 fe                	cmp    %edi,%esi
 c7a:	74 1c                	je     c98 <malloc+0xb8>
        p->s.size -= nunits;
 c7c:	29 f7                	sub    %esi,%edi
 c7e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 c81:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 c84:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 c87:	89 15 c4 12 00 00    	mov    %edx,0x12c4
      return (void*)(p + 1);
 c8d:	83 c0 08             	add    $0x8,%eax
  }
}
 c90:	83 c4 1c             	add    $0x1c,%esp
 c93:	5b                   	pop    %ebx
 c94:	5e                   	pop    %esi
 c95:	5f                   	pop    %edi
 c96:	5d                   	pop    %ebp
 c97:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 c98:	8b 08                	mov    (%eax),%ecx
 c9a:	89 0a                	mov    %ecx,(%edx)
 c9c:	eb e9                	jmp    c87 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 c9e:	c7 05 c4 12 00 00 c8 	movl   $0x12c8,0x12c4
 ca5:	12 00 00 
    base.s.size = 0;
 ca8:	ba c8 12 00 00       	mov    $0x12c8,%edx
    base.s.ptr = freep = prevp = &base;
 cad:	c7 05 c8 12 00 00 c8 	movl   $0x12c8,0x12c8
 cb4:	12 00 00 
    base.s.size = 0;
 cb7:	c7 05 cc 12 00 00 00 	movl   $0x0,0x12cc
 cbe:	00 00 00 
 cc1:	e9 46 ff ff ff       	jmp    c0c <malloc+0x2c>
 cc6:	66 90                	xchg   %ax,%ax
 cc8:	66 90                	xchg   %ax,%ax
 cca:	66 90                	xchg   %ax,%ax
 ccc:	66 90                	xchg   %ax,%ax
 cce:	66 90                	xchg   %ax,%ax

00000cd0 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 cd0:	55                   	push   %ebp
 cd1:	89 e5                	mov    %esp,%ebp
 cd3:	53                   	push   %ebx
 cd4:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 cd7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 cde:	e8 fd fe ff ff       	call   be0 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 ce3:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 cea:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 cec:	e8 ef fe ff ff       	call   be0 <malloc>
    if (tstack == NULL) {
 cf1:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 cf3:	89 c2                	mov    %eax,%edx
 cf5:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 cf8:	0f 84 8a 00 00 00    	je     d88 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 cfe:	25 ff 0f 00 00       	and    $0xfff,%eax
 d03:	75 73                	jne    d78 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 d05:	8b 45 10             	mov    0x10(%ebp),%eax
 d08:	89 54 24 08          	mov    %edx,0x8(%esp)
 d0c:	89 44 24 04          	mov    %eax,0x4(%esp)
 d10:	8b 45 0c             	mov    0xc(%ebp),%eax
 d13:	89 04 24             	mov    %eax,(%esp)
 d16:	e8 57 fb ff ff       	call   872 <kthread_create>
 d1b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 d1d:	89 44 24 10          	mov    %eax,0x10(%esp)
 d21:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 d28:	00 
 d29:	c7 44 24 08 04 0f 00 	movl   $0xf04,0x8(%esp)
 d30:	00 
 d31:	c7 44 24 04 13 0f 00 	movl   $0xf13,0x4(%esp)
 d38:	00 
 d39:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d40:	e8 eb fb ff ff       	call   930 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 d45:	8b 03                	mov    (%ebx),%eax
 d47:	c7 44 24 04 2a 0f 00 	movl   $0xf2a,0x4(%esp)
 d4e:	00 
 d4f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 d56:	89 44 24 08          	mov    %eax,0x8(%esp)
 d5a:	e8 d1 fb ff ff       	call   930 <printf>
    
    if (bt->tid != 0) {
 d5f:	8b 03                	mov    (%ebx),%eax
 d61:	85 c0                	test   %eax,%eax
 d63:	74 23                	je     d88 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 d65:	8b 45 08             	mov    0x8(%ebp),%eax
 d68:	89 18                	mov    %ebx,(%eax)
        return 0;
 d6a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 d6c:	83 c4 24             	add    $0x24,%esp
 d6f:	5b                   	pop    %ebx
 d70:	5d                   	pop    %ebp
 d71:	c3                   	ret    
 d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 d78:	29 c2                	sub    %eax,%edx
 d7a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 d80:	eb 83                	jmp    d05 <benny_thread_create+0x35>
 d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 d88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 d8d:	eb dd                	jmp    d6c <benny_thread_create+0x9c>
 d8f:	90                   	nop

00000d90 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 d90:	55                   	push   %ebp
 d91:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 d93:	8b 45 08             	mov    0x8(%ebp),%eax
}
 d96:	5d                   	pop    %ebp
    return bt->tid;
 d97:	8b 00                	mov    (%eax),%eax
}
 d99:	c3                   	ret    
 d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000da0 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 da0:	55                   	push   %ebp
 da1:	89 e5                	mov    %esp,%ebp
 da3:	53                   	push   %ebx
 da4:	83 ec 14             	sub    $0x14,%esp
 da7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 daa:	8b 03                	mov    (%ebx),%eax
 dac:	89 04 24             	mov    %eax,(%esp)
 daf:	e8 c6 fa ff ff       	call   87a <kthread_join>
    if (retVal == 0) {
 db4:	85 c0                	test   %eax,%eax
 db6:	75 11                	jne    dc9 <benny_thread_join+0x29>
        free(bt->tstack);
 db8:	8b 53 04             	mov    0x4(%ebx),%edx
 dbb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 dbe:	89 14 24             	mov    %edx,(%esp)
 dc1:	e8 8a fd ff ff       	call   b50 <free>
 dc6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 dc9:	83 c4 14             	add    $0x14,%esp
 dcc:	5b                   	pop    %ebx
 dcd:	5d                   	pop    %ebp
 dce:	c3                   	ret    
 dcf:	90                   	nop

00000dd0 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 dd0:	55                   	push   %ebp
 dd1:	89 e5                	mov    %esp,%ebp
 dd3:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 dd6:	8b 45 08             	mov    0x8(%ebp),%eax
 dd9:	89 04 24             	mov    %eax,(%esp)
 ddc:	e8 a1 fa ff ff       	call   882 <kthread_exit>
    return 0;
}
 de1:	31 c0                	xor    %eax,%eax
 de3:	c9                   	leave  
 de4:	c3                   	ret    
