
_mv:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    return res;
}

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
    int i = 0;
    int res = -1;
    char *dest = NULL;
    struct stat st;
    char dirstr[DIRSTR] = {0};
   1:	31 c0                	xor    %eax,%eax
{
   3:	89 e5                	mov    %esp,%ebp
    char dirstr[DIRSTR] = {0};
   5:	b9 20 00 00 00       	mov    $0x20,%ecx
{
   a:	57                   	push   %edi
   b:	56                   	push   %esi
   c:	53                   	push   %ebx
   d:	83 e4 f0             	and    $0xfffffff0,%esp
  10:	81 ec c0 00 00 00    	sub    $0xc0,%esp
  16:	8b 75 0c             	mov    0xc(%ebp),%esi

    if (argc < 3) {
  19:	83 7d 08 02          	cmpl   $0x2,0x8(%ebp)
    char dirstr[DIRSTR] = {0};
  1d:	8d 5c 24 40          	lea    0x40(%esp),%ebx
  21:	89 df                	mov    %ebx,%edi
  23:	f3 ab                	rep stos %eax,%es:(%edi)
    if (argc < 3) {
  25:	7f 19                	jg     40 <main+0x40>
        printf(2, "barf\n");
  27:	c7 44 24 04 43 0a 00 	movl   $0xa43,0x4(%esp)
  2e:	00 
  2f:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  36:	e8 45 05 00 00       	call   580 <printf>
        exit();
  3b:	e8 c2 03 00 00       	call   402 <exit>
    }
    dest = argv[argc - 1];
  40:	8b 45 08             	mov    0x8(%ebp),%eax
  43:	8b 44 86 fc          	mov    -0x4(%esi,%eax,4),%eax
  47:	89 c1                	mov    %eax,%ecx
  49:	89 44 24 18          	mov    %eax,0x18(%esp)
    res = stat(dest, &st);
  4d:	8d 44 24 2c          	lea    0x2c(%esp),%eax
  51:	89 44 24 04          	mov    %eax,0x4(%esp)
  55:	89 0c 24             	mov    %ecx,(%esp)
  58:	e8 f3 02 00 00       	call   350 <stat>
    if (res < 0) {
  5d:	85 c0                	test   %eax,%eax
  5f:	78 47                	js     a8 <main+0xa8>
        // dest does not exist
        mv(argv[1], dest);
    }
    else {
        switch(st.type) {
  61:	0f b7 44 24 2c       	movzwl 0x2c(%esp),%eax
  66:	66 83 f8 01          	cmp    $0x1,%ax
  6a:	74 51                	je     bd <main+0xbd>
  6c:	66 83 f8 02          	cmp    $0x2,%ax
  70:	74 19                	je     8b <main+0x8b>
        case T_FILE:
            unlink(dest);
            mv(argv[1], dest);
            break;
        default:
            printf(2, "extra barf\n");
  72:	c7 44 24 04 3d 0a 00 	movl   $0xa3d,0x4(%esp)
  79:	00 
  7a:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  81:	e8 fa 04 00 00       	call   580 <printf>
            break;
        }
    }
    exit();
  86:	e8 77 03 00 00       	call   402 <exit>
            unlink(dest);
  8b:	8b 7c 24 18          	mov    0x18(%esp),%edi
  8f:	89 3c 24             	mov    %edi,(%esp)
  92:	e8 bb 03 00 00       	call   452 <unlink>
            mv(argv[1], dest);
  97:	89 7c 24 04          	mov    %edi,0x4(%esp)
  9b:	8b 46 04             	mov    0x4(%esi),%eax
  9e:	89 04 24             	mov    %eax,(%esp)
  a1:	e8 aa 00 00 00       	call   150 <mv>
            break;
  a6:	eb de                	jmp    86 <main+0x86>
        mv(argv[1], dest);
  a8:	8b 44 24 18          	mov    0x18(%esp),%eax
  ac:	89 44 24 04          	mov    %eax,0x4(%esp)
  b0:	8b 46 04             	mov    0x4(%esi),%eax
  b3:	89 04 24             	mov    %eax,(%esp)
  b6:	e8 95 00 00 00       	call   150 <mv>
  bb:	eb c9                	jmp    86 <main+0x86>
  bd:	8b 45 08             	mov    0x8(%ebp),%eax
        switch(st.type) {
  c0:	bf 01 00 00 00       	mov    $0x1,%edi
  c5:	83 e8 01             	sub    $0x1,%eax
  c8:	89 44 24 14          	mov    %eax,0x14(%esp)
  cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                memset(dirstr, 0, DIRSTR);
  d0:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
  d7:	00 
  d8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  df:	00 
  e0:	89 1c 24             	mov    %ebx,(%esp)
  e3:	e8 a8 01 00 00       	call   290 <memset>
                strcpy(dirstr, dest);
  e8:	8b 44 24 18          	mov    0x18(%esp),%eax
  ec:	89 1c 24             	mov    %ebx,(%esp)
  ef:	89 44 24 04          	mov    %eax,0x4(%esp)
  f3:	e8 e8 00 00 00       	call   1e0 <strcpy>
                dirstr[strlen(dirstr)] = '/';
  f8:	89 1c 24             	mov    %ebx,(%esp)
  fb:	e8 60 01 00 00       	call   260 <strlen>
                strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 100:	8b 14 be             	mov    (%esi,%edi,4),%edx
 103:	89 54 24 1c          	mov    %edx,0x1c(%esp)
                dirstr[strlen(dirstr)] = '/';
 107:	c6 44 04 40 2f       	movb   $0x2f,0x40(%esp,%eax,1)
                strcpy(&(dirstr[strlen(dirstr)]), argv[i]);
 10c:	89 1c 24             	mov    %ebx,(%esp)
 10f:	e8 4c 01 00 00       	call   260 <strlen>
 114:	8b 54 24 1c          	mov    0x1c(%esp),%edx
 118:	89 54 24 04          	mov    %edx,0x4(%esp)
 11c:	01 d8                	add    %ebx,%eax
 11e:	89 04 24             	mov    %eax,(%esp)
 121:	e8 ba 00 00 00       	call   1e0 <strcpy>
                mv(argv[i], dirstr);
 126:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 12a:	8b 04 be             	mov    (%esi,%edi,4),%eax
            for (i = 1; i < (argc - 1); i++) {
 12d:	83 c7 01             	add    $0x1,%edi
                mv(argv[i], dirstr);
 130:	89 04 24             	mov    %eax,(%esp)
 133:	e8 18 00 00 00       	call   150 <mv>
            for (i = 1; i < (argc - 1); i++) {
 138:	3b 7c 24 14          	cmp    0x14(%esp),%edi
 13c:	75 92                	jne    d0 <main+0xd0>
 13e:	e9 43 ff ff ff       	jmp    86 <main+0x86>
 143:	66 90                	xchg   %ax,%ax
 145:	66 90                	xchg   %ax,%ax
 147:	66 90                	xchg   %ax,%ax
 149:	66 90                	xchg   %ax,%ax
 14b:	66 90                	xchg   %ax,%ax
 14d:	66 90                	xchg   %ax,%ax
 14f:	90                   	nop

00000150 <mv>:
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	53                   	push   %ebx
 154:	83 ec 14             	sub    $0x14,%esp
 157:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (link(src, dest) < 0) {
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 1c 24             	mov    %ebx,(%esp)
 160:	89 44 24 04          	mov    %eax,0x4(%esp)
 164:	e8 f9 02 00 00       	call   462 <link>
 169:	85 c0                	test   %eax,%eax
 16b:	78 1b                	js     188 <mv+0x38>
        if (unlink(src) < 0) {
 16d:	89 1c 24             	mov    %ebx,(%esp)
 170:	e8 dd 02 00 00       	call   452 <unlink>
 175:	85 c0                	test   %eax,%eax
 177:	78 3a                	js     1b3 <mv+0x63>
            res = 0;
 179:	31 c0                	xor    %eax,%eax
}
 17b:	83 c4 14             	add    $0x14,%esp
 17e:	5b                   	pop    %ebx
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(2, "ERROR %s %d: failed to create link\n", __FILE__, __LINE__);
 188:	c7 44 24 0c 0d 00 00 	movl   $0xd,0xc(%esp)
 18f:	00 
 190:	c7 44 24 08 38 0a 00 	movl   $0xa38,0x8(%esp)
 197:	00 
 198:	c7 44 24 04 4c 0a 00 	movl   $0xa4c,0x4(%esp)
 19f:	00 
 1a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1a7:	e8 d4 03 00 00       	call   580 <printf>
    int res = -1;
 1ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b1:	eb c8                	jmp    17b <mv+0x2b>
            printf(2, "ERROR %s %d: failed to remove link\n", __FILE__, __LINE__);
 1b3:	c7 44 24 0c 11 00 00 	movl   $0x11,0xc(%esp)
 1ba:	00 
 1bb:	c7 44 24 08 38 0a 00 	movl   $0xa38,0x8(%esp)
 1c2:	00 
 1c3:	c7 44 24 04 70 0a 00 	movl   $0xa70,0x4(%esp)
 1ca:	00 
 1cb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
 1d2:	e8 a9 03 00 00       	call   580 <printf>
 1d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1dc:	eb 9d                	jmp    17b <mv+0x2b>
 1de:	66 90                	xchg   %ax,%ax

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	8b 45 08             	mov    0x8(%ebp),%eax
 1e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 1e9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1ea:	89 c2                	mov    %eax,%edx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 c1 01             	add    $0x1,%ecx
 1f3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1f7:	83 c2 01             	add    $0x1,%edx
 1fa:	84 db                	test   %bl,%bl
 1fc:	88 5a ff             	mov    %bl,-0x1(%edx)
 1ff:	75 ef                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 201:	5b                   	pop    %ebx
 202:	5d                   	pop    %ebp
 203:	c3                   	ret    
 204:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 20a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 55 08             	mov    0x8(%ebp),%edx
 216:	53                   	push   %ebx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	74 2d                	je     24e <strcmp+0x3e>
 221:	0f b6 19             	movzbl (%ecx),%ebx
 224:	38 d8                	cmp    %bl,%al
 226:	74 0e                	je     236 <strcmp+0x26>
 228:	eb 2b                	jmp    255 <strcmp+0x45>
 22a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 230:	38 c8                	cmp    %cl,%al
 232:	75 15                	jne    249 <strcmp+0x39>
    p++, q++;
 234:	89 d9                	mov    %ebx,%ecx
 236:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 239:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 23c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 23f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 243:	84 c0                	test   %al,%al
 245:	75 e9                	jne    230 <strcmp+0x20>
 247:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 249:	29 c8                	sub    %ecx,%eax
}
 24b:	5b                   	pop    %ebx
 24c:	5d                   	pop    %ebp
 24d:	c3                   	ret    
 24e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 251:	31 c0                	xor    %eax,%eax
 253:	eb f4                	jmp    249 <strcmp+0x39>
 255:	0f b6 cb             	movzbl %bl,%ecx
 258:	eb ef                	jmp    249 <strcmp+0x39>
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000260 <strlen>:

uint
strlen(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 266:	80 39 00             	cmpb   $0x0,(%ecx)
 269:	74 12                	je     27d <strlen+0x1d>
 26b:	31 d2                	xor    %edx,%edx
 26d:	8d 76 00             	lea    0x0(%esi),%esi
 270:	83 c2 01             	add    $0x1,%edx
 273:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 277:	89 d0                	mov    %edx,%eax
 279:	75 f5                	jne    270 <strlen+0x10>
    ;
  return n;
}
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 27d:	31 c0                	xor    %eax,%eax
}
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	eb 0d                	jmp    290 <memset>
 283:	90                   	nop
 284:	90                   	nop
 285:	90                   	nop
 286:	90                   	nop
 287:	90                   	nop
 288:	90                   	nop
 289:	90                   	nop
 28a:	90                   	nop
 28b:	90                   	nop
 28c:	90                   	nop
 28d:	90                   	nop
 28e:	90                   	nop
 28f:	90                   	nop

00000290 <memset>:

void*
memset(void *dst, int c, uint n)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	8b 55 08             	mov    0x8(%ebp),%edx
 296:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 297:	8b 4d 10             	mov    0x10(%ebp),%ecx
 29a:	8b 45 0c             	mov    0xc(%ebp),%eax
 29d:	89 d7                	mov    %edx,%edi
 29f:	fc                   	cld    
 2a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2a2:	89 d0                	mov    %edx,%eax
 2a4:	5f                   	pop    %edi
 2a5:	5d                   	pop    %ebp
 2a6:	c3                   	ret    
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002b0 <strchr>:

char*
strchr(const char *s, char c)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	53                   	push   %ebx
 2b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 2ba:	0f b6 18             	movzbl (%eax),%ebx
 2bd:	84 db                	test   %bl,%bl
 2bf:	74 1d                	je     2de <strchr+0x2e>
    if(*s == c)
 2c1:	38 d3                	cmp    %dl,%bl
 2c3:	89 d1                	mov    %edx,%ecx
 2c5:	75 0d                	jne    2d4 <strchr+0x24>
 2c7:	eb 17                	jmp    2e0 <strchr+0x30>
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2d0:	38 ca                	cmp    %cl,%dl
 2d2:	74 0c                	je     2e0 <strchr+0x30>
  for(; *s; s++)
 2d4:	83 c0 01             	add    $0x1,%eax
 2d7:	0f b6 10             	movzbl (%eax),%edx
 2da:	84 d2                	test   %dl,%dl
 2dc:	75 f2                	jne    2d0 <strchr+0x20>
      return (char*)s;
  return 0;
 2de:	31 c0                	xor    %eax,%eax
}
 2e0:	5b                   	pop    %ebx
 2e1:	5d                   	pop    %ebp
 2e2:	c3                   	ret    
 2e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002f0 <gets>:

char*
gets(char *buf, int max)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f5:	31 f6                	xor    %esi,%esi
{
 2f7:	53                   	push   %ebx
 2f8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 2fb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2fe:	eb 31                	jmp    331 <gets+0x41>
    cc = read(0, &c, 1);
 300:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 307:	00 
 308:	89 7c 24 04          	mov    %edi,0x4(%esp)
 30c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 313:	e8 02 01 00 00       	call   41a <read>
    if(cc < 1)
 318:	85 c0                	test   %eax,%eax
 31a:	7e 1d                	jle    339 <gets+0x49>
      break;
    buf[i++] = c;
 31c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 320:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 322:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 325:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 327:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 32b:	74 0c                	je     339 <gets+0x49>
 32d:	3c 0a                	cmp    $0xa,%al
 32f:	74 08                	je     339 <gets+0x49>
  for(i=0; i+1 < max; ){
 331:	8d 5e 01             	lea    0x1(%esi),%ebx
 334:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 337:	7c c7                	jl     300 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 339:	8b 45 08             	mov    0x8(%ebp),%eax
 33c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 340:	83 c4 2c             	add    $0x2c,%esp
 343:	5b                   	pop    %ebx
 344:	5e                   	pop    %esi
 345:	5f                   	pop    %edi
 346:	5d                   	pop    %ebp
 347:	c3                   	ret    
 348:	90                   	nop
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000350 <stat>:

int
stat(const char *n, struct stat *st)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	56                   	push   %esi
 354:	53                   	push   %ebx
 355:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 358:	8b 45 08             	mov    0x8(%ebp),%eax
 35b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 362:	00 
 363:	89 04 24             	mov    %eax,(%esp)
 366:	e8 d7 00 00 00       	call   442 <open>
  if(fd < 0)
 36b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 36d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 36f:	78 27                	js     398 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 371:	8b 45 0c             	mov    0xc(%ebp),%eax
 374:	89 1c 24             	mov    %ebx,(%esp)
 377:	89 44 24 04          	mov    %eax,0x4(%esp)
 37b:	e8 da 00 00 00       	call   45a <fstat>
  close(fd);
 380:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 383:	89 c6                	mov    %eax,%esi
  close(fd);
 385:	e8 a0 00 00 00       	call   42a <close>
  return r;
 38a:	89 f0                	mov    %esi,%eax
}
 38c:	83 c4 10             	add    $0x10,%esp
 38f:	5b                   	pop    %ebx
 390:	5e                   	pop    %esi
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	90                   	nop
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 398:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 39d:	eb ed                	jmp    38c <stat+0x3c>
 39f:	90                   	nop

000003a0 <atoi>:

int
atoi(const char *s)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3a6:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a7:	0f be 11             	movsbl (%ecx),%edx
 3aa:	8d 42 d0             	lea    -0x30(%edx),%eax
 3ad:	3c 09                	cmp    $0x9,%al
  n = 0;
 3af:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 3b4:	77 17                	ja     3cd <atoi+0x2d>
 3b6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 3b8:	83 c1 01             	add    $0x1,%ecx
 3bb:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3be:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 3c2:	0f be 11             	movsbl (%ecx),%edx
 3c5:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3c8:	80 fb 09             	cmp    $0x9,%bl
 3cb:	76 eb                	jbe    3b8 <atoi+0x18>
  return n;
}
 3cd:	5b                   	pop    %ebx
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d0:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3d1:	31 d2                	xor    %edx,%edx
{
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	56                   	push   %esi
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
 3d9:	53                   	push   %ebx
 3da:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3dd:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 3e0:	85 db                	test   %ebx,%ebx
 3e2:	7e 12                	jle    3f6 <memmove+0x26>
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3f2:	39 da                	cmp    %ebx,%edx
 3f4:	75 f2                	jne    3e8 <memmove+0x18>
  return vdst;
}
 3f6:	5b                   	pop    %ebx
 3f7:	5e                   	pop    %esi
 3f8:	5d                   	pop    %ebp
 3f9:	c3                   	ret    

000003fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3fa:	b8 01 00 00 00       	mov    $0x1,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <exit>:
SYSCALL(exit)
 402:	b8 02 00 00 00       	mov    $0x2,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <wait>:
SYSCALL(wait)
 40a:	b8 03 00 00 00       	mov    $0x3,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <pipe>:
SYSCALL(pipe)
 412:	b8 04 00 00 00       	mov    $0x4,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <read>:
SYSCALL(read)
 41a:	b8 05 00 00 00       	mov    $0x5,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <write>:
SYSCALL(write)
 422:	b8 10 00 00 00       	mov    $0x10,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <close>:
SYSCALL(close)
 42a:	b8 15 00 00 00       	mov    $0x15,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <kill>:
SYSCALL(kill)
 432:	b8 06 00 00 00       	mov    $0x6,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <exec>:
SYSCALL(exec)
 43a:	b8 07 00 00 00       	mov    $0x7,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <open>:
SYSCALL(open)
 442:	b8 0f 00 00 00       	mov    $0xf,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <mknod>:
SYSCALL(mknod)
 44a:	b8 11 00 00 00       	mov    $0x11,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <unlink>:
SYSCALL(unlink)
 452:	b8 12 00 00 00       	mov    $0x12,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <fstat>:
SYSCALL(fstat)
 45a:	b8 08 00 00 00       	mov    $0x8,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <link>:
SYSCALL(link)
 462:	b8 13 00 00 00       	mov    $0x13,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <mkdir>:
SYSCALL(mkdir)
 46a:	b8 14 00 00 00       	mov    $0x14,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <chdir>:
SYSCALL(chdir)
 472:	b8 09 00 00 00       	mov    $0x9,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <dup>:
SYSCALL(dup)
 47a:	b8 0a 00 00 00       	mov    $0xa,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <getpid>:
SYSCALL(getpid)
 482:	b8 0b 00 00 00       	mov    $0xb,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <sbrk>:
SYSCALL(sbrk)
 48a:	b8 0c 00 00 00       	mov    $0xc,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <sleep>:
SYSCALL(sleep)
 492:	b8 0d 00 00 00       	mov    $0xd,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <uptime>:
SYSCALL(uptime)
 49a:	b8 0e 00 00 00       	mov    $0xe,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 4a2:	b8 16 00 00 00       	mov    $0x16,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 4aa:	b8 17 00 00 00       	mov    $0x17,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 4b2:	b8 18 00 00 00       	mov    $0x18,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <halt>:
SYSCALL(halt)
 4ba:	b8 19 00 00 00       	mov    $0x19,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 4c2:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <kthread_join>:
SYSCALL(kthread_join)
 4ca:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <kthread_exit>:
SYSCALL(kthread_exit)
 4d2:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    
 4da:	66 90                	xchg   %ax,%ax
 4dc:	66 90                	xchg   %ax,%ax
 4de:	66 90                	xchg   %ax,%ax

000004e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	89 c6                	mov    %eax,%esi
 4e7:	53                   	push   %ebx
 4e8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
 4ee:	85 db                	test   %ebx,%ebx
 4f0:	74 09                	je     4fb <printint+0x1b>
 4f2:	89 d0                	mov    %edx,%eax
 4f4:	c1 e8 1f             	shr    $0x1f,%eax
 4f7:	84 c0                	test   %al,%al
 4f9:	75 75                	jne    570 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4fb:	89 d0                	mov    %edx,%eax
  neg = 0;
 4fd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 504:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 507:	31 ff                	xor    %edi,%edi
 509:	89 ce                	mov    %ecx,%esi
 50b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 50e:	eb 02                	jmp    512 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 510:	89 cf                	mov    %ecx,%edi
 512:	31 d2                	xor    %edx,%edx
 514:	f7 f6                	div    %esi
 516:	8d 4f 01             	lea    0x1(%edi),%ecx
 519:	0f b6 92 9b 0a 00 00 	movzbl 0xa9b(%edx),%edx
  }while((x /= base) != 0);
 520:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 522:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 525:	75 e9                	jne    510 <printint+0x30>
  if(neg)
 527:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 52a:	89 c8                	mov    %ecx,%eax
 52c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 52f:	85 d2                	test   %edx,%edx
 531:	74 08                	je     53b <printint+0x5b>
    buf[i++] = '-';
 533:	8d 4f 02             	lea    0x2(%edi),%ecx
 536:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 53b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 53e:	66 90                	xchg   %ax,%ax
 540:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 545:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 548:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 54f:	00 
 550:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 554:	89 34 24             	mov    %esi,(%esp)
 557:	88 45 d7             	mov    %al,-0x29(%ebp)
 55a:	e8 c3 fe ff ff       	call   422 <write>
  while(--i >= 0)
 55f:	83 ff ff             	cmp    $0xffffffff,%edi
 562:	75 dc                	jne    540 <printint+0x60>
    putc(fd, buf[i]);
}
 564:	83 c4 4c             	add    $0x4c,%esp
 567:	5b                   	pop    %ebx
 568:	5e                   	pop    %esi
 569:	5f                   	pop    %edi
 56a:	5d                   	pop    %ebp
 56b:	c3                   	ret    
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 570:	89 d0                	mov    %edx,%eax
 572:	f7 d8                	neg    %eax
    neg = 1;
 574:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 57b:	eb 87                	jmp    504 <printint+0x24>
 57d:	8d 76 00             	lea    0x0(%esi),%esi

00000580 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 584:	31 ff                	xor    %edi,%edi
{
 586:	56                   	push   %esi
 587:	53                   	push   %ebx
 588:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 58b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 58e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 591:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 594:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 597:	0f b6 13             	movzbl (%ebx),%edx
 59a:	83 c3 01             	add    $0x1,%ebx
 59d:	84 d2                	test   %dl,%dl
 59f:	75 39                	jne    5da <printf+0x5a>
 5a1:	e9 ca 00 00 00       	jmp    670 <printf+0xf0>
 5a6:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5a8:	83 fa 25             	cmp    $0x25,%edx
 5ab:	0f 84 c7 00 00 00    	je     678 <printf+0xf8>
  write(fd, &c, 1);
 5b1:	8d 45 e0             	lea    -0x20(%ebp),%eax
 5b4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5bb:	00 
 5bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 5c0:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 5c3:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 5c6:	e8 57 fe ff ff       	call   422 <write>
 5cb:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 5ce:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5d2:	84 d2                	test   %dl,%dl
 5d4:	0f 84 96 00 00 00    	je     670 <printf+0xf0>
    if(state == 0){
 5da:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 5dc:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 5df:	74 c7                	je     5a8 <printf+0x28>
      }
    } else if(state == '%'){
 5e1:	83 ff 25             	cmp    $0x25,%edi
 5e4:	75 e5                	jne    5cb <printf+0x4b>
      if(c == 'd' || c == 'u'){
 5e6:	83 fa 75             	cmp    $0x75,%edx
 5e9:	0f 84 99 00 00 00    	je     688 <printf+0x108>
 5ef:	83 fa 64             	cmp    $0x64,%edx
 5f2:	0f 84 90 00 00 00    	je     688 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5f8:	25 f7 00 00 00       	and    $0xf7,%eax
 5fd:	83 f8 70             	cmp    $0x70,%eax
 600:	0f 84 aa 00 00 00    	je     6b0 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 606:	83 fa 73             	cmp    $0x73,%edx
 609:	0f 84 e9 00 00 00    	je     6f8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 60f:	83 fa 63             	cmp    $0x63,%edx
 612:	0f 84 2b 01 00 00    	je     743 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 618:	83 fa 25             	cmp    $0x25,%edx
 61b:	0f 84 4f 01 00 00    	je     770 <printf+0x1f0>
  write(fd, &c, 1);
 621:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 624:	83 c3 01             	add    $0x1,%ebx
 627:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 62e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 62f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 631:	89 44 24 04          	mov    %eax,0x4(%esp)
 635:	89 34 24             	mov    %esi,(%esp)
 638:	89 55 d0             	mov    %edx,-0x30(%ebp)
 63b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 63f:	e8 de fd ff ff       	call   422 <write>
        putc(fd, c);
 644:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 647:	8d 45 e7             	lea    -0x19(%ebp),%eax
 64a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 651:	00 
 652:	89 44 24 04          	mov    %eax,0x4(%esp)
 656:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 659:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 65c:	e8 c1 fd ff ff       	call   422 <write>
  for(i = 0; fmt[i]; i++){
 661:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 665:	84 d2                	test   %dl,%dl
 667:	0f 85 6d ff ff ff    	jne    5da <printf+0x5a>
 66d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 670:	83 c4 3c             	add    $0x3c,%esp
 673:	5b                   	pop    %ebx
 674:	5e                   	pop    %esi
 675:	5f                   	pop    %edi
 676:	5d                   	pop    %ebp
 677:	c3                   	ret    
        state = '%';
 678:	bf 25 00 00 00       	mov    $0x25,%edi
 67d:	e9 49 ff ff ff       	jmp    5cb <printf+0x4b>
 682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 688:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 68f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 694:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 697:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 699:	8b 10                	mov    (%eax),%edx
 69b:	89 f0                	mov    %esi,%eax
 69d:	e8 3e fe ff ff       	call   4e0 <printint>
        ap++;
 6a2:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6a6:	e9 20 ff ff ff       	jmp    5cb <printf+0x4b>
 6ab:	90                   	nop
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 6b0:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 6b3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6ba:	00 
 6bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bf:	89 34 24             	mov    %esi,(%esp)
 6c2:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 6c6:	e8 57 fd ff ff       	call   422 <write>
 6cb:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 6ce:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6d5:	00 
 6d6:	89 44 24 04          	mov    %eax,0x4(%esp)
 6da:	89 34 24             	mov    %esi,(%esp)
 6dd:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 6e1:	e8 3c fd ff ff       	call   422 <write>
        printint(fd, *ap, 16, 0);
 6e6:	b9 10 00 00 00       	mov    $0x10,%ecx
 6eb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6f2:	eb a0                	jmp    694 <printf+0x114>
 6f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 6fb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 6ff:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 701:	b8 94 0a 00 00       	mov    $0xa94,%eax
 706:	85 ff                	test   %edi,%edi
 708:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 70b:	0f b6 07             	movzbl (%edi),%eax
 70e:	84 c0                	test   %al,%al
 710:	74 2a                	je     73c <printf+0x1bc>
 712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 718:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 71b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 71e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 721:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 728:	00 
 729:	89 44 24 04          	mov    %eax,0x4(%esp)
 72d:	89 34 24             	mov    %esi,(%esp)
 730:	e8 ed fc ff ff       	call   422 <write>
        while(*s != 0){
 735:	0f b6 07             	movzbl (%edi),%eax
 738:	84 c0                	test   %al,%al
 73a:	75 dc                	jne    718 <printf+0x198>
      state = 0;
 73c:	31 ff                	xor    %edi,%edi
 73e:	e9 88 fe ff ff       	jmp    5cb <printf+0x4b>
        putc(fd, *ap);
 743:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 746:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 748:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 74a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 751:	00 
 752:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 755:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 758:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 75b:	89 44 24 04          	mov    %eax,0x4(%esp)
 75f:	e8 be fc ff ff       	call   422 <write>
        ap++;
 764:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 768:	e9 5e fe ff ff       	jmp    5cb <printf+0x4b>
 76d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 770:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 773:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 775:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 77c:	00 
 77d:	89 44 24 04          	mov    %eax,0x4(%esp)
 781:	89 34 24             	mov    %esi,(%esp)
 784:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 788:	e8 95 fc ff ff       	call   422 <write>
 78d:	e9 39 fe ff ff       	jmp    5cb <printf+0x4b>
 792:	66 90                	xchg   %ax,%ax
 794:	66 90                	xchg   %ax,%ax
 796:	66 90                	xchg   %ax,%ax
 798:	66 90                	xchg   %ax,%ax
 79a:	66 90                	xchg   %ax,%ax
 79c:	66 90                	xchg   %ax,%ax
 79e:	66 90                	xchg   %ax,%ax

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a1:	a1 f8 0d 00 00       	mov    0xdf8,%eax
{
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	57                   	push   %edi
 7a9:	56                   	push   %esi
 7aa:	53                   	push   %ebx
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ae:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 7b0:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	39 d0                	cmp    %edx,%eax
 7b5:	72 11                	jb     7c8 <free+0x28>
 7b7:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b8:	39 c8                	cmp    %ecx,%eax
 7ba:	72 04                	jb     7c0 <free+0x20>
 7bc:	39 ca                	cmp    %ecx,%edx
 7be:	72 10                	jb     7d0 <free+0x30>
 7c0:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c2:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c4:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c6:	73 f0                	jae    7b8 <free+0x18>
 7c8:	39 ca                	cmp    %ecx,%edx
 7ca:	72 04                	jb     7d0 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cc:	39 c8                	cmp    %ecx,%eax
 7ce:	72 f0                	jb     7c0 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7d3:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 7d6:	39 cf                	cmp    %ecx,%edi
 7d8:	74 1e                	je     7f8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7da:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7dd:	8b 48 04             	mov    0x4(%eax),%ecx
 7e0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7e3:	39 f2                	cmp    %esi,%edx
 7e5:	74 28                	je     80f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7e7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7e9:	a3 f8 0d 00 00       	mov    %eax,0xdf8
}
 7ee:	5b                   	pop    %ebx
 7ef:	5e                   	pop    %esi
 7f0:	5f                   	pop    %edi
 7f1:	5d                   	pop    %ebp
 7f2:	c3                   	ret    
 7f3:	90                   	nop
 7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7f8:	03 71 04             	add    0x4(%ecx),%esi
 7fb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7fe:	8b 08                	mov    (%eax),%ecx
 800:	8b 09                	mov    (%ecx),%ecx
 802:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 805:	8b 48 04             	mov    0x4(%eax),%ecx
 808:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 80b:	39 f2                	cmp    %esi,%edx
 80d:	75 d8                	jne    7e7 <free+0x47>
    p->s.size += bp->s.size;
 80f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 812:	a3 f8 0d 00 00       	mov    %eax,0xdf8
    p->s.size += bp->s.size;
 817:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 81a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 81d:	89 10                	mov    %edx,(%eax)
}
 81f:	5b                   	pop    %ebx
 820:	5e                   	pop    %esi
 821:	5f                   	pop    %edi
 822:	5d                   	pop    %ebp
 823:	c3                   	ret    
 824:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 82a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 1d f8 0d 00 00    	mov    0xdf8,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	8d 48 07             	lea    0x7(%eax),%ecx
 845:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 848:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 84d:	0f 84 9b 00 00 00    	je     8ee <malloc+0xbe>
 853:	8b 13                	mov    (%ebx),%edx
 855:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 858:	39 fe                	cmp    %edi,%esi
 85a:	76 64                	jbe    8c0 <malloc+0x90>
 85c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 863:	bb 00 80 00 00       	mov    $0x8000,%ebx
 868:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 86b:	eb 0e                	jmp    87b <malloc+0x4b>
 86d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 870:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 872:	8b 78 04             	mov    0x4(%eax),%edi
 875:	39 fe                	cmp    %edi,%esi
 877:	76 4f                	jbe    8c8 <malloc+0x98>
 879:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 87b:	3b 15 f8 0d 00 00    	cmp    0xdf8,%edx
 881:	75 ed                	jne    870 <malloc+0x40>
  if(nu < 4096)
 883:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 886:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 88c:	bf 00 10 00 00       	mov    $0x1000,%edi
 891:	0f 43 fe             	cmovae %esi,%edi
 894:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 897:	89 04 24             	mov    %eax,(%esp)
 89a:	e8 eb fb ff ff       	call   48a <sbrk>
  if(p == (char*)-1)
 89f:	83 f8 ff             	cmp    $0xffffffff,%eax
 8a2:	74 18                	je     8bc <malloc+0x8c>
  hp->s.size = nu;
 8a4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 8a7:	83 c0 08             	add    $0x8,%eax
 8aa:	89 04 24             	mov    %eax,(%esp)
 8ad:	e8 ee fe ff ff       	call   7a0 <free>
  return freep;
 8b2:	8b 15 f8 0d 00 00    	mov    0xdf8,%edx
      if((p = morecore(nunits)) == 0)
 8b8:	85 d2                	test   %edx,%edx
 8ba:	75 b4                	jne    870 <malloc+0x40>
        return 0;
 8bc:	31 c0                	xor    %eax,%eax
 8be:	eb 20                	jmp    8e0 <malloc+0xb0>
    if(p->s.size >= nunits){
 8c0:	89 d0                	mov    %edx,%eax
 8c2:	89 da                	mov    %ebx,%edx
 8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 8c8:	39 fe                	cmp    %edi,%esi
 8ca:	74 1c                	je     8e8 <malloc+0xb8>
        p->s.size -= nunits;
 8cc:	29 f7                	sub    %esi,%edi
 8ce:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 8d1:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 8d4:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 8d7:	89 15 f8 0d 00 00    	mov    %edx,0xdf8
      return (void*)(p + 1);
 8dd:	83 c0 08             	add    $0x8,%eax
  }
}
 8e0:	83 c4 1c             	add    $0x1c,%esp
 8e3:	5b                   	pop    %ebx
 8e4:	5e                   	pop    %esi
 8e5:	5f                   	pop    %edi
 8e6:	5d                   	pop    %ebp
 8e7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 8e8:	8b 08                	mov    (%eax),%ecx
 8ea:	89 0a                	mov    %ecx,(%edx)
 8ec:	eb e9                	jmp    8d7 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 8ee:	c7 05 f8 0d 00 00 fc 	movl   $0xdfc,0xdf8
 8f5:	0d 00 00 
    base.s.size = 0;
 8f8:	ba fc 0d 00 00       	mov    $0xdfc,%edx
    base.s.ptr = freep = prevp = &base;
 8fd:	c7 05 fc 0d 00 00 fc 	movl   $0xdfc,0xdfc
 904:	0d 00 00 
    base.s.size = 0;
 907:	c7 05 00 0e 00 00 00 	movl   $0x0,0xe00
 90e:	00 00 00 
 911:	e9 46 ff ff ff       	jmp    85c <malloc+0x2c>
 916:	66 90                	xchg   %ax,%ax
 918:	66 90                	xchg   %ax,%ax
 91a:	66 90                	xchg   %ax,%ax
 91c:	66 90                	xchg   %ax,%ax
 91e:	66 90                	xchg   %ax,%ax

00000920 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	53                   	push   %ebx
 924:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 927:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 92e:	e8 fd fe ff ff       	call   830 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 933:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 93a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 93c:	e8 ef fe ff ff       	call   830 <malloc>
    if (tstack == NULL) {
 941:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 943:	89 c2                	mov    %eax,%edx
 945:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 948:	0f 84 8a 00 00 00    	je     9d8 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 94e:	25 ff 0f 00 00       	and    $0xfff,%eax
 953:	75 73                	jne    9c8 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 955:	8b 45 10             	mov    0x10(%ebp),%eax
 958:	89 54 24 08          	mov    %edx,0x8(%esp)
 95c:	89 44 24 04          	mov    %eax,0x4(%esp)
 960:	8b 45 0c             	mov    0xc(%ebp),%eax
 963:	89 04 24             	mov    %eax,(%esp)
 966:	e8 57 fb ff ff       	call   4c2 <kthread_create>
 96b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 96d:	89 44 24 10          	mov    %eax,0x10(%esp)
 971:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 978:	00 
 979:	c7 44 24 08 ac 0a 00 	movl   $0xaac,0x8(%esp)
 980:	00 
 981:	c7 44 24 04 bb 0a 00 	movl   $0xabb,0x4(%esp)
 988:	00 
 989:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 990:	e8 eb fb ff ff       	call   580 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 995:	8b 03                	mov    (%ebx),%eax
 997:	c7 44 24 04 d2 0a 00 	movl   $0xad2,0x4(%esp)
 99e:	00 
 99f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 9a6:	89 44 24 08          	mov    %eax,0x8(%esp)
 9aa:	e8 d1 fb ff ff       	call   580 <printf>
    
    if (bt->tid != 0) {
 9af:	8b 03                	mov    (%ebx),%eax
 9b1:	85 c0                	test   %eax,%eax
 9b3:	74 23                	je     9d8 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 9b5:	8b 45 08             	mov    0x8(%ebp),%eax
 9b8:	89 18                	mov    %ebx,(%eax)
        return 0;
 9ba:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 9bc:	83 c4 24             	add    $0x24,%esp
 9bf:	5b                   	pop    %ebx
 9c0:	5d                   	pop    %ebp
 9c1:	c3                   	ret    
 9c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 9c8:	29 c2                	sub    %eax,%edx
 9ca:	81 c2 00 10 00 00    	add    $0x1000,%edx
 9d0:	eb 83                	jmp    955 <benny_thread_create+0x35>
 9d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 9d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 9dd:	eb dd                	jmp    9bc <benny_thread_create+0x9c>
 9df:	90                   	nop

000009e0 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 9e0:	55                   	push   %ebp
 9e1:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 9e3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 9e6:	5d                   	pop    %ebp
    return bt->tid;
 9e7:	8b 00                	mov    (%eax),%eax
}
 9e9:	c3                   	ret    
 9ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000009f0 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 9f0:	55                   	push   %ebp
 9f1:	89 e5                	mov    %esp,%ebp
 9f3:	53                   	push   %ebx
 9f4:	83 ec 14             	sub    $0x14,%esp
 9f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 9fa:	8b 03                	mov    (%ebx),%eax
 9fc:	89 04 24             	mov    %eax,(%esp)
 9ff:	e8 c6 fa ff ff       	call   4ca <kthread_join>
    if (retVal == 0) {
 a04:	85 c0                	test   %eax,%eax
 a06:	75 11                	jne    a19 <benny_thread_join+0x29>
        free(bt->tstack);
 a08:	8b 53 04             	mov    0x4(%ebx),%edx
 a0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a0e:	89 14 24             	mov    %edx,(%esp)
 a11:	e8 8a fd ff ff       	call   7a0 <free>
 a16:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 a19:	83 c4 14             	add    $0x14,%esp
 a1c:	5b                   	pop    %ebx
 a1d:	5d                   	pop    %ebp
 a1e:	c3                   	ret    
 a1f:	90                   	nop

00000a20 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 a20:	55                   	push   %ebp
 a21:	89 e5                	mov    %esp,%ebp
 a23:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 a26:	8b 45 08             	mov    0x8(%ebp),%eax
 a29:	89 04 24             	mov    %eax,(%esp)
 a2c:	e8 a1 fa ff ff       	call   4d2 <kthread_exit>
    return 0;
}
 a31:	31 c0                	xor    %eax,%eax
 a33:	c9                   	leave  
 a34:	c3                   	ret    
