
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
  int fd, i;

  if(argc <= 1){
   5:	be 01 00 00 00       	mov    $0x1,%esi
{
   a:	53                   	push   %ebx
   b:	83 e4 f0             	and    $0xfffffff0,%esp
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(argc <= 1){
  14:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  18:	8d 58 04             	lea    0x4(%eax),%ebx
  1b:	7e 60                	jle    7d <main+0x7d>
  1d:	8d 76 00             	lea    0x0(%esi),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  20:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  27:	00 
  28:	8b 03                	mov    (%ebx),%eax
  2a:	89 04 24             	mov    %eax,(%esp)
  2d:	e8 c0 03 00 00       	call   3f2 <open>
  32:	85 c0                	test   %eax,%eax
  34:	89 c7                	mov    %eax,%edi
  36:	78 26                	js     5e <main+0x5e>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  38:	8b 13                	mov    (%ebx),%edx
  for(i = 1; i < argc; i++){
  3a:	83 c6 01             	add    $0x1,%esi
  3d:	83 c3 04             	add    $0x4,%ebx
    wc(fd, argv[i]);
  40:	89 04 24             	mov    %eax,(%esp)
  43:	89 54 24 04          	mov    %edx,0x4(%esp)
  47:	e8 54 00 00 00       	call   a0 <wc>
    close(fd);
  4c:	89 3c 24             	mov    %edi,(%esp)
  4f:	e8 86 03 00 00       	call   3da <close>
  for(i = 1; i < argc; i++){
  54:	3b 75 08             	cmp    0x8(%ebp),%esi
  57:	75 c7                	jne    20 <main+0x20>
  }
  exit();
  59:	e8 54 03 00 00       	call   3b2 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  5e:	8b 03                	mov    (%ebx),%eax
  60:	c7 44 24 04 08 0a 00 	movl   $0xa08,0x4(%esp)
  67:	00 
  68:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  6f:	89 44 24 08          	mov    %eax,0x8(%esp)
  73:	e8 b8 04 00 00       	call   530 <printf>
      exit();
  78:	e8 35 03 00 00       	call   3b2 <exit>
    wc(0, "");
  7d:	c7 44 24 04 59 0a 00 	movl   $0xa59,0x4(%esp)
  84:	00 
  85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  8c:	e8 0f 00 00 00       	call   a0 <wc>
    exit();
  91:	e8 1c 03 00 00       	call   3b2 <exit>
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  inword = 0;
  a5:	31 f6                	xor    %esi,%esi
{
  a7:	53                   	push   %ebx
  l = w = c = 0;
  a8:	31 db                	xor    %ebx,%ebx
{
  aa:	83 ec 3c             	sub    $0x3c,%esp
  l = w = c = 0;
  ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  bb:	90                   	nop
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  ca:	00 
  cb:	c7 44 24 04 c0 0d 00 	movl   $0xdc0,0x4(%esp)
  d2:	00 
  d3:	89 04 24             	mov    %eax,(%esp)
  d6:	e8 ef 02 00 00       	call   3ca <read>
  db:	83 f8 00             	cmp    $0x0,%eax
  de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  e1:	7e 54                	jle    137 <wc+0x97>
  e3:	31 ff                	xor    %edi,%edi
  e5:	eb 0b                	jmp    f2 <wc+0x52>
  e7:	90                   	nop
        inword = 0;
  e8:	31 f6                	xor    %esi,%esi
    for(i=0; i<n; i++){
  ea:	83 c7 01             	add    $0x1,%edi
  ed:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
  f0:	74 38                	je     12a <wc+0x8a>
      if(buf[i] == '\n')
  f2:	0f be 87 c0 0d 00 00 	movsbl 0xdc0(%edi),%eax
        l++;
  f9:	31 c9                	xor    %ecx,%ecx
      if(strchr(" \r\t\n\v", buf[i]))
  fb:	c7 04 24 e5 09 00 00 	movl   $0x9e5,(%esp)
        l++;
 102:	3c 0a                	cmp    $0xa,%al
 104:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 107:	89 44 24 04          	mov    %eax,0x4(%esp)
        l++;
 10b:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10d:	e8 4e 01 00 00       	call   260 <strchr>
 112:	85 c0                	test   %eax,%eax
 114:	75 d2                	jne    e8 <wc+0x48>
      else if(!inword){
 116:	85 f6                	test   %esi,%esi
 118:	75 16                	jne    130 <wc+0x90>
        w++;
 11a:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
    for(i=0; i<n; i++){
 11e:	83 c7 01             	add    $0x1,%edi
 121:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
        inword = 1;
 124:	66 be 01 00          	mov    $0x1,%si
    for(i=0; i<n; i++){
 128:	75 c8                	jne    f2 <wc+0x52>
 12a:	01 7d dc             	add    %edi,-0x24(%ebp)
 12d:	eb 91                	jmp    c0 <wc+0x20>
 12f:	90                   	nop
 130:	be 01 00 00 00       	mov    $0x1,%esi
 135:	eb b3                	jmp    ea <wc+0x4a>
  if(n < 0){
 137:	75 35                	jne    16e <wc+0xce>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 139:	8b 45 0c             	mov    0xc(%ebp),%eax
 13c:	89 5c 24 08          	mov    %ebx,0x8(%esp)
 140:	c7 44 24 04 fb 09 00 	movl   $0x9fb,0x4(%esp)
 147:	00 
 148:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 14f:	89 44 24 14          	mov    %eax,0x14(%esp)
 153:	8b 45 dc             	mov    -0x24(%ebp),%eax
 156:	89 44 24 10          	mov    %eax,0x10(%esp)
 15a:	8b 45 e0             	mov    -0x20(%ebp),%eax
 15d:	89 44 24 0c          	mov    %eax,0xc(%esp)
 161:	e8 ca 03 00 00       	call   530 <printf>
}
 166:	83 c4 3c             	add    $0x3c,%esp
 169:	5b                   	pop    %ebx
 16a:	5e                   	pop    %esi
 16b:	5f                   	pop    %edi
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret    
    printf(1, "wc: read error\n");
 16e:	c7 44 24 04 eb 09 00 	movl   $0x9eb,0x4(%esp)
 175:	00 
 176:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 17d:	e8 ae 03 00 00       	call   530 <printf>
    exit();
 182:	e8 2b 02 00 00       	call   3b2 <exit>
 187:	66 90                	xchg   %ax,%ax
 189:	66 90                	xchg   %ax,%ax
 18b:	66 90                	xchg   %ax,%ax
 18d:	66 90                	xchg   %ax,%ax
 18f:	90                   	nop

00000190 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 199:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 19a:	89 c2                	mov    %eax,%edx
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	83 c1 01             	add    $0x1,%ecx
 1a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 1a7:	83 c2 01             	add    $0x1,%edx
 1aa:	84 db                	test   %bl,%bl
 1ac:	88 5a ff             	mov    %bl,-0x1(%edx)
 1af:	75 ef                	jne    1a0 <strcpy+0x10>
    ;
  return os;
}
 1b1:	5b                   	pop    %ebx
 1b2:	5d                   	pop    %ebp
 1b3:	c3                   	ret    
 1b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 55 08             	mov    0x8(%ebp),%edx
 1c6:	53                   	push   %ebx
 1c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ca:	0f b6 02             	movzbl (%edx),%eax
 1cd:	84 c0                	test   %al,%al
 1cf:	74 2d                	je     1fe <strcmp+0x3e>
 1d1:	0f b6 19             	movzbl (%ecx),%ebx
 1d4:	38 d8                	cmp    %bl,%al
 1d6:	74 0e                	je     1e6 <strcmp+0x26>
 1d8:	eb 2b                	jmp    205 <strcmp+0x45>
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	38 c8                	cmp    %cl,%al
 1e2:	75 15                	jne    1f9 <strcmp+0x39>
    p++, q++;
 1e4:	89 d9                	mov    %ebx,%ecx
 1e6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1e9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1ec:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 1ef:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1f3:	84 c0                	test   %al,%al
 1f5:	75 e9                	jne    1e0 <strcmp+0x20>
 1f7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1f9:	29 c8                	sub    %ecx,%eax
}
 1fb:	5b                   	pop    %ebx
 1fc:	5d                   	pop    %ebp
 1fd:	c3                   	ret    
 1fe:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 201:	31 c0                	xor    %eax,%eax
 203:	eb f4                	jmp    1f9 <strcmp+0x39>
 205:	0f b6 cb             	movzbl %bl,%ecx
 208:	eb ef                	jmp    1f9 <strcmp+0x39>
 20a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000210 <strlen>:

uint
strlen(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 216:	80 39 00             	cmpb   $0x0,(%ecx)
 219:	74 12                	je     22d <strlen+0x1d>
 21b:	31 d2                	xor    %edx,%edx
 21d:	8d 76 00             	lea    0x0(%esi),%esi
 220:	83 c2 01             	add    $0x1,%edx
 223:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 227:	89 d0                	mov    %edx,%eax
 229:	75 f5                	jne    220 <strlen+0x10>
    ;
  return n;
}
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 22d:	31 c0                	xor    %eax,%eax
}
 22f:	5d                   	pop    %ebp
 230:	c3                   	ret    
 231:	eb 0d                	jmp    240 <memset>
 233:	90                   	nop
 234:	90                   	nop
 235:	90                   	nop
 236:	90                   	nop
 237:	90                   	nop
 238:	90                   	nop
 239:	90                   	nop
 23a:	90                   	nop
 23b:	90                   	nop
 23c:	90                   	nop
 23d:	90                   	nop
 23e:	90                   	nop
 23f:	90                   	nop

00000240 <memset>:

void*
memset(void *dst, int c, uint n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	8b 55 08             	mov    0x8(%ebp),%edx
 246:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 247:	8b 4d 10             	mov    0x10(%ebp),%ecx
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 d7                	mov    %edx,%edi
 24f:	fc                   	cld    
 250:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 252:	89 d0                	mov    %edx,%eax
 254:	5f                   	pop    %edi
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000260 <strchr>:

char*
strchr(const char *s, char c)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	53                   	push   %ebx
 267:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 26a:	0f b6 18             	movzbl (%eax),%ebx
 26d:	84 db                	test   %bl,%bl
 26f:	74 1d                	je     28e <strchr+0x2e>
    if(*s == c)
 271:	38 d3                	cmp    %dl,%bl
 273:	89 d1                	mov    %edx,%ecx
 275:	75 0d                	jne    284 <strchr+0x24>
 277:	eb 17                	jmp    290 <strchr+0x30>
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 280:	38 ca                	cmp    %cl,%dl
 282:	74 0c                	je     290 <strchr+0x30>
  for(; *s; s++)
 284:	83 c0 01             	add    $0x1,%eax
 287:	0f b6 10             	movzbl (%eax),%edx
 28a:	84 d2                	test   %dl,%dl
 28c:	75 f2                	jne    280 <strchr+0x20>
      return (char*)s;
  return 0;
 28e:	31 c0                	xor    %eax,%eax
}
 290:	5b                   	pop    %ebx
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    
 293:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <gets>:

char*
gets(char *buf, int max)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2a5:	31 f6                	xor    %esi,%esi
{
 2a7:	53                   	push   %ebx
 2a8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 2ab:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 2ae:	eb 31                	jmp    2e1 <gets+0x41>
    cc = read(0, &c, 1);
 2b0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2b7:	00 
 2b8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 2bc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2c3:	e8 02 01 00 00       	call   3ca <read>
    if(cc < 1)
 2c8:	85 c0                	test   %eax,%eax
 2ca:	7e 1d                	jle    2e9 <gets+0x49>
      break;
    buf[i++] = c;
 2cc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 2d0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 2d2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 2d5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 2d7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 2db:	74 0c                	je     2e9 <gets+0x49>
 2dd:	3c 0a                	cmp    $0xa,%al
 2df:	74 08                	je     2e9 <gets+0x49>
  for(i=0; i+1 < max; ){
 2e1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e7:	7c c7                	jl     2b0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 2e9:	8b 45 08             	mov    0x8(%ebp),%eax
 2ec:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2f0:	83 c4 2c             	add    $0x2c,%esp
 2f3:	5b                   	pop    %ebx
 2f4:	5e                   	pop    %esi
 2f5:	5f                   	pop    %edi
 2f6:	5d                   	pop    %ebp
 2f7:	c3                   	ret    
 2f8:	90                   	nop
 2f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000300 <stat>:

int
stat(const char *n, struct stat *st)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
 305:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 312:	00 
 313:	89 04 24             	mov    %eax,(%esp)
 316:	e8 d7 00 00 00       	call   3f2 <open>
  if(fd < 0)
 31b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 31d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 31f:	78 27                	js     348 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 321:	8b 45 0c             	mov    0xc(%ebp),%eax
 324:	89 1c 24             	mov    %ebx,(%esp)
 327:	89 44 24 04          	mov    %eax,0x4(%esp)
 32b:	e8 da 00 00 00       	call   40a <fstat>
  close(fd);
 330:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 333:	89 c6                	mov    %eax,%esi
  close(fd);
 335:	e8 a0 00 00 00       	call   3da <close>
  return r;
 33a:	89 f0                	mov    %esi,%eax
}
 33c:	83 c4 10             	add    $0x10,%esp
 33f:	5b                   	pop    %ebx
 340:	5e                   	pop    %esi
 341:	5d                   	pop    %ebp
 342:	c3                   	ret    
 343:	90                   	nop
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 348:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 34d:	eb ed                	jmp    33c <stat+0x3c>
 34f:	90                   	nop

00000350 <atoi>:

int
atoi(const char *s)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	8b 4d 08             	mov    0x8(%ebp),%ecx
 356:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 357:	0f be 11             	movsbl (%ecx),%edx
 35a:	8d 42 d0             	lea    -0x30(%edx),%eax
 35d:	3c 09                	cmp    $0x9,%al
  n = 0;
 35f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 364:	77 17                	ja     37d <atoi+0x2d>
 366:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 368:	83 c1 01             	add    $0x1,%ecx
 36b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 36e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 372:	0f be 11             	movsbl (%ecx),%edx
 375:	8d 5a d0             	lea    -0x30(%edx),%ebx
 378:	80 fb 09             	cmp    $0x9,%bl
 37b:	76 eb                	jbe    368 <atoi+0x18>
  return n;
}
 37d:	5b                   	pop    %ebx
 37e:	5d                   	pop    %ebp
 37f:	c3                   	ret    

00000380 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 380:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 381:	31 d2                	xor    %edx,%edx
{
 383:	89 e5                	mov    %esp,%ebp
 385:	56                   	push   %esi
 386:	8b 45 08             	mov    0x8(%ebp),%eax
 389:	53                   	push   %ebx
 38a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 38d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 390:	85 db                	test   %ebx,%ebx
 392:	7e 12                	jle    3a6 <memmove+0x26>
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 398:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 39c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 39f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3a2:	39 da                	cmp    %ebx,%edx
 3a4:	75 f2                	jne    398 <memmove+0x18>
  return vdst;
}
 3a6:	5b                   	pop    %ebx
 3a7:	5e                   	pop    %esi
 3a8:	5d                   	pop    %ebp
 3a9:	c3                   	ret    

000003aa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3aa:	b8 01 00 00 00       	mov    $0x1,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <exit>:
SYSCALL(exit)
 3b2:	b8 02 00 00 00       	mov    $0x2,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <wait>:
SYSCALL(wait)
 3ba:	b8 03 00 00 00       	mov    $0x3,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <pipe>:
SYSCALL(pipe)
 3c2:	b8 04 00 00 00       	mov    $0x4,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <read>:
SYSCALL(read)
 3ca:	b8 05 00 00 00       	mov    $0x5,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <write>:
SYSCALL(write)
 3d2:	b8 10 00 00 00       	mov    $0x10,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <close>:
SYSCALL(close)
 3da:	b8 15 00 00 00       	mov    $0x15,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <kill>:
SYSCALL(kill)
 3e2:	b8 06 00 00 00       	mov    $0x6,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <exec>:
SYSCALL(exec)
 3ea:	b8 07 00 00 00       	mov    $0x7,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <open>:
SYSCALL(open)
 3f2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <mknod>:
SYSCALL(mknod)
 3fa:	b8 11 00 00 00       	mov    $0x11,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <unlink>:
SYSCALL(unlink)
 402:	b8 12 00 00 00       	mov    $0x12,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <fstat>:
SYSCALL(fstat)
 40a:	b8 08 00 00 00       	mov    $0x8,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <link>:
SYSCALL(link)
 412:	b8 13 00 00 00       	mov    $0x13,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <mkdir>:
SYSCALL(mkdir)
 41a:	b8 14 00 00 00       	mov    $0x14,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <chdir>:
SYSCALL(chdir)
 422:	b8 09 00 00 00       	mov    $0x9,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <dup>:
SYSCALL(dup)
 42a:	b8 0a 00 00 00       	mov    $0xa,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <getpid>:
SYSCALL(getpid)
 432:	b8 0b 00 00 00       	mov    $0xb,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <sbrk>:
SYSCALL(sbrk)
 43a:	b8 0c 00 00 00       	mov    $0xc,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <sleep>:
SYSCALL(sleep)
 442:	b8 0d 00 00 00       	mov    $0xd,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <uptime>:
SYSCALL(uptime)
 44a:	b8 0e 00 00 00       	mov    $0xe,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 452:	b8 16 00 00 00       	mov    $0x16,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 45a:	b8 17 00 00 00       	mov    $0x17,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 462:	b8 18 00 00 00       	mov    $0x18,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <halt>:
SYSCALL(halt)
 46a:	b8 19 00 00 00       	mov    $0x19,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 472:	b8 1a 00 00 00       	mov    $0x1a,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <kthread_join>:
SYSCALL(kthread_join)
 47a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <kthread_exit>:
SYSCALL(kthread_exit)
 482:	b8 1c 00 00 00       	mov    $0x1c,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    
 48a:	66 90                	xchg   %ax,%ax
 48c:	66 90                	xchg   %ax,%ax
 48e:	66 90                	xchg   %ax,%ax

00000490 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	89 c6                	mov    %eax,%esi
 497:	53                   	push   %ebx
 498:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 49b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 49e:	85 db                	test   %ebx,%ebx
 4a0:	74 09                	je     4ab <printint+0x1b>
 4a2:	89 d0                	mov    %edx,%eax
 4a4:	c1 e8 1f             	shr    $0x1f,%eax
 4a7:	84 c0                	test   %al,%al
 4a9:	75 75                	jne    520 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 4ab:	89 d0                	mov    %edx,%eax
  neg = 0;
 4ad:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 4b4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 4b7:	31 ff                	xor    %edi,%edi
 4b9:	89 ce                	mov    %ecx,%esi
 4bb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 4be:	eb 02                	jmp    4c2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 4c0:	89 cf                	mov    %ecx,%edi
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	f7 f6                	div    %esi
 4c6:	8d 4f 01             	lea    0x1(%edi),%ecx
 4c9:	0f b6 92 23 0a 00 00 	movzbl 0xa23(%edx),%edx
  }while((x /= base) != 0);
 4d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 4d2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 4d5:	75 e9                	jne    4c0 <printint+0x30>
  if(neg)
 4d7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 4da:	89 c8                	mov    %ecx,%eax
 4dc:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 4df:	85 d2                	test   %edx,%edx
 4e1:	74 08                	je     4eb <printint+0x5b>
    buf[i++] = '-';
 4e3:	8d 4f 02             	lea    0x2(%edi),%ecx
 4e6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 4eb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 4ee:	66 90                	xchg   %ax,%ax
 4f0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 4f5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 4f8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ff:	00 
 500:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 504:	89 34 24             	mov    %esi,(%esp)
 507:	88 45 d7             	mov    %al,-0x29(%ebp)
 50a:	e8 c3 fe ff ff       	call   3d2 <write>
  while(--i >= 0)
 50f:	83 ff ff             	cmp    $0xffffffff,%edi
 512:	75 dc                	jne    4f0 <printint+0x60>
    putc(fd, buf[i]);
}
 514:	83 c4 4c             	add    $0x4c,%esp
 517:	5b                   	pop    %ebx
 518:	5e                   	pop    %esi
 519:	5f                   	pop    %edi
 51a:	5d                   	pop    %ebp
 51b:	c3                   	ret    
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 520:	89 d0                	mov    %edx,%eax
 522:	f7 d8                	neg    %eax
    neg = 1;
 524:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 52b:	eb 87                	jmp    4b4 <printint+0x24>
 52d:	8d 76 00             	lea    0x0(%esi),%esi

00000530 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 534:	31 ff                	xor    %edi,%edi
{
 536:	56                   	push   %esi
 537:	53                   	push   %ebx
 538:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 53b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 53e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 541:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 544:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 547:	0f b6 13             	movzbl (%ebx),%edx
 54a:	83 c3 01             	add    $0x1,%ebx
 54d:	84 d2                	test   %dl,%dl
 54f:	75 39                	jne    58a <printf+0x5a>
 551:	e9 ca 00 00 00       	jmp    620 <printf+0xf0>
 556:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 558:	83 fa 25             	cmp    $0x25,%edx
 55b:	0f 84 c7 00 00 00    	je     628 <printf+0xf8>
  write(fd, &c, 1);
 561:	8d 45 e0             	lea    -0x20(%ebp),%eax
 564:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 56b:	00 
 56c:	89 44 24 04          	mov    %eax,0x4(%esp)
 570:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 573:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 576:	e8 57 fe ff ff       	call   3d2 <write>
 57b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 57e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 582:	84 d2                	test   %dl,%dl
 584:	0f 84 96 00 00 00    	je     620 <printf+0xf0>
    if(state == 0){
 58a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 58c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 58f:	74 c7                	je     558 <printf+0x28>
      }
    } else if(state == '%'){
 591:	83 ff 25             	cmp    $0x25,%edi
 594:	75 e5                	jne    57b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 596:	83 fa 75             	cmp    $0x75,%edx
 599:	0f 84 99 00 00 00    	je     638 <printf+0x108>
 59f:	83 fa 64             	cmp    $0x64,%edx
 5a2:	0f 84 90 00 00 00    	je     638 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5a8:	25 f7 00 00 00       	and    $0xf7,%eax
 5ad:	83 f8 70             	cmp    $0x70,%eax
 5b0:	0f 84 aa 00 00 00    	je     660 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5b6:	83 fa 73             	cmp    $0x73,%edx
 5b9:	0f 84 e9 00 00 00    	je     6a8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5bf:	83 fa 63             	cmp    $0x63,%edx
 5c2:	0f 84 2b 01 00 00    	je     6f3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5c8:	83 fa 25             	cmp    $0x25,%edx
 5cb:	0f 84 4f 01 00 00    	je     720 <printf+0x1f0>
  write(fd, &c, 1);
 5d1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 5d4:	83 c3 01             	add    $0x1,%ebx
 5d7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5de:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5df:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 5e1:	89 44 24 04          	mov    %eax,0x4(%esp)
 5e5:	89 34 24             	mov    %esi,(%esp)
 5e8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 5eb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 5ef:	e8 de fd ff ff       	call   3d2 <write>
        putc(fd, c);
 5f4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 5f7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 601:	00 
 602:	89 44 24 04          	mov    %eax,0x4(%esp)
 606:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 609:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 60c:	e8 c1 fd ff ff       	call   3d2 <write>
  for(i = 0; fmt[i]; i++){
 611:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 615:	84 d2                	test   %dl,%dl
 617:	0f 85 6d ff ff ff    	jne    58a <printf+0x5a>
 61d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 620:	83 c4 3c             	add    $0x3c,%esp
 623:	5b                   	pop    %ebx
 624:	5e                   	pop    %esi
 625:	5f                   	pop    %edi
 626:	5d                   	pop    %ebp
 627:	c3                   	ret    
        state = '%';
 628:	bf 25 00 00 00       	mov    $0x25,%edi
 62d:	e9 49 ff ff ff       	jmp    57b <printf+0x4b>
 632:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 638:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 63f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 644:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 647:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 649:	8b 10                	mov    (%eax),%edx
 64b:	89 f0                	mov    %esi,%eax
 64d:	e8 3e fe ff ff       	call   490 <printint>
        ap++;
 652:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 656:	e9 20 ff ff ff       	jmp    57b <printf+0x4b>
 65b:	90                   	nop
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 660:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 663:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 66a:	00 
 66b:	89 44 24 04          	mov    %eax,0x4(%esp)
 66f:	89 34 24             	mov    %esi,(%esp)
 672:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 676:	e8 57 fd ff ff       	call   3d2 <write>
 67b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 67e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 685:	00 
 686:	89 44 24 04          	mov    %eax,0x4(%esp)
 68a:	89 34 24             	mov    %esi,(%esp)
 68d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 691:	e8 3c fd ff ff       	call   3d2 <write>
        printint(fd, *ap, 16, 0);
 696:	b9 10 00 00 00       	mov    $0x10,%ecx
 69b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 6a2:	eb a0                	jmp    644 <printf+0x114>
 6a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 6a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 6ab:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 6af:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 6b1:	b8 1c 0a 00 00       	mov    $0xa1c,%eax
 6b6:	85 ff                	test   %edi,%edi
 6b8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 6bb:	0f b6 07             	movzbl (%edi),%eax
 6be:	84 c0                	test   %al,%al
 6c0:	74 2a                	je     6ec <printf+0x1bc>
 6c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6c8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 6cb:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 6ce:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 6d1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6d8:	00 
 6d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 6dd:	89 34 24             	mov    %esi,(%esp)
 6e0:	e8 ed fc ff ff       	call   3d2 <write>
        while(*s != 0){
 6e5:	0f b6 07             	movzbl (%edi),%eax
 6e8:	84 c0                	test   %al,%al
 6ea:	75 dc                	jne    6c8 <printf+0x198>
      state = 0;
 6ec:	31 ff                	xor    %edi,%edi
 6ee:	e9 88 fe ff ff       	jmp    57b <printf+0x4b>
        putc(fd, *ap);
 6f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6f6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 6f8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 6fa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 701:	00 
 702:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 705:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 708:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 70b:	89 44 24 04          	mov    %eax,0x4(%esp)
 70f:	e8 be fc ff ff       	call   3d2 <write>
        ap++;
 714:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 718:	e9 5e fe ff ff       	jmp    57b <printf+0x4b>
 71d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 720:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 723:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 725:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 72c:	00 
 72d:	89 44 24 04          	mov    %eax,0x4(%esp)
 731:	89 34 24             	mov    %esi,(%esp)
 734:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 738:	e8 95 fc ff ff       	call   3d2 <write>
 73d:	e9 39 fe ff ff       	jmp    57b <printf+0x4b>
 742:	66 90                	xchg   %ax,%ax
 744:	66 90                	xchg   %ax,%ax
 746:	66 90                	xchg   %ax,%ax
 748:	66 90                	xchg   %ax,%ax
 74a:	66 90                	xchg   %ax,%ax
 74c:	66 90                	xchg   %ax,%ax
 74e:	66 90                	xchg   %ax,%ax

00000750 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 750:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 751:	a1 a0 0d 00 00       	mov    0xda0,%eax
{
 756:	89 e5                	mov    %esp,%ebp
 758:	57                   	push   %edi
 759:	56                   	push   %esi
 75a:	53                   	push   %ebx
 75b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 75e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 760:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 763:	39 d0                	cmp    %edx,%eax
 765:	72 11                	jb     778 <free+0x28>
 767:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 768:	39 c8                	cmp    %ecx,%eax
 76a:	72 04                	jb     770 <free+0x20>
 76c:	39 ca                	cmp    %ecx,%edx
 76e:	72 10                	jb     780 <free+0x30>
 770:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 772:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 774:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 776:	73 f0                	jae    768 <free+0x18>
 778:	39 ca                	cmp    %ecx,%edx
 77a:	72 04                	jb     780 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 77c:	39 c8                	cmp    %ecx,%eax
 77e:	72 f0                	jb     770 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 780:	8b 73 fc             	mov    -0x4(%ebx),%esi
 783:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 786:	39 cf                	cmp    %ecx,%edi
 788:	74 1e                	je     7a8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 78a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 78d:	8b 48 04             	mov    0x4(%eax),%ecx
 790:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 793:	39 f2                	cmp    %esi,%edx
 795:	74 28                	je     7bf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 797:	89 10                	mov    %edx,(%eax)
  freep = p;
 799:	a3 a0 0d 00 00       	mov    %eax,0xda0
}
 79e:	5b                   	pop    %ebx
 79f:	5e                   	pop    %esi
 7a0:	5f                   	pop    %edi
 7a1:	5d                   	pop    %ebp
 7a2:	c3                   	ret    
 7a3:	90                   	nop
 7a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7a8:	03 71 04             	add    0x4(%ecx),%esi
 7ab:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ae:	8b 08                	mov    (%eax),%ecx
 7b0:	8b 09                	mov    (%ecx),%ecx
 7b2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7b5:	8b 48 04             	mov    0x4(%eax),%ecx
 7b8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 7bb:	39 f2                	cmp    %esi,%edx
 7bd:	75 d8                	jne    797 <free+0x47>
    p->s.size += bp->s.size;
 7bf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 7c2:	a3 a0 0d 00 00       	mov    %eax,0xda0
    p->s.size += bp->s.size;
 7c7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7ca:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7cd:	89 10                	mov    %edx,(%eax)
}
 7cf:	5b                   	pop    %ebx
 7d0:	5e                   	pop    %esi
 7d1:	5f                   	pop    %edi
 7d2:	5d                   	pop    %ebp
 7d3:	c3                   	ret    
 7d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	57                   	push   %edi
 7e4:	56                   	push   %esi
 7e5:	53                   	push   %ebx
 7e6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7ec:	8b 1d a0 0d 00 00    	mov    0xda0,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f2:	8d 48 07             	lea    0x7(%eax),%ecx
 7f5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 7f8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7fa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 7fd:	0f 84 9b 00 00 00    	je     89e <malloc+0xbe>
 803:	8b 13                	mov    (%ebx),%edx
 805:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 808:	39 fe                	cmp    %edi,%esi
 80a:	76 64                	jbe    870 <malloc+0x90>
 80c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 813:	bb 00 80 00 00       	mov    $0x8000,%ebx
 818:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 81b:	eb 0e                	jmp    82b <malloc+0x4b>
 81d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 820:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 822:	8b 78 04             	mov    0x4(%eax),%edi
 825:	39 fe                	cmp    %edi,%esi
 827:	76 4f                	jbe    878 <malloc+0x98>
 829:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 82b:	3b 15 a0 0d 00 00    	cmp    0xda0,%edx
 831:	75 ed                	jne    820 <malloc+0x40>
  if(nu < 4096)
 833:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 836:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 83c:	bf 00 10 00 00       	mov    $0x1000,%edi
 841:	0f 43 fe             	cmovae %esi,%edi
 844:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 847:	89 04 24             	mov    %eax,(%esp)
 84a:	e8 eb fb ff ff       	call   43a <sbrk>
  if(p == (char*)-1)
 84f:	83 f8 ff             	cmp    $0xffffffff,%eax
 852:	74 18                	je     86c <malloc+0x8c>
  hp->s.size = nu;
 854:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 857:	83 c0 08             	add    $0x8,%eax
 85a:	89 04 24             	mov    %eax,(%esp)
 85d:	e8 ee fe ff ff       	call   750 <free>
  return freep;
 862:	8b 15 a0 0d 00 00    	mov    0xda0,%edx
      if((p = morecore(nunits)) == 0)
 868:	85 d2                	test   %edx,%edx
 86a:	75 b4                	jne    820 <malloc+0x40>
        return 0;
 86c:	31 c0                	xor    %eax,%eax
 86e:	eb 20                	jmp    890 <malloc+0xb0>
    if(p->s.size >= nunits){
 870:	89 d0                	mov    %edx,%eax
 872:	89 da                	mov    %ebx,%edx
 874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 878:	39 fe                	cmp    %edi,%esi
 87a:	74 1c                	je     898 <malloc+0xb8>
        p->s.size -= nunits;
 87c:	29 f7                	sub    %esi,%edi
 87e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 881:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 884:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 887:	89 15 a0 0d 00 00    	mov    %edx,0xda0
      return (void*)(p + 1);
 88d:	83 c0 08             	add    $0x8,%eax
  }
}
 890:	83 c4 1c             	add    $0x1c,%esp
 893:	5b                   	pop    %ebx
 894:	5e                   	pop    %esi
 895:	5f                   	pop    %edi
 896:	5d                   	pop    %ebp
 897:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 898:	8b 08                	mov    (%eax),%ecx
 89a:	89 0a                	mov    %ecx,(%edx)
 89c:	eb e9                	jmp    887 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 89e:	c7 05 a0 0d 00 00 a4 	movl   $0xda4,0xda0
 8a5:	0d 00 00 
    base.s.size = 0;
 8a8:	ba a4 0d 00 00       	mov    $0xda4,%edx
    base.s.ptr = freep = prevp = &base;
 8ad:	c7 05 a4 0d 00 00 a4 	movl   $0xda4,0xda4
 8b4:	0d 00 00 
    base.s.size = 0;
 8b7:	c7 05 a8 0d 00 00 00 	movl   $0x0,0xda8
 8be:	00 00 00 
 8c1:	e9 46 ff ff ff       	jmp    80c <malloc+0x2c>
 8c6:	66 90                	xchg   %ax,%ax
 8c8:	66 90                	xchg   %ax,%ax
 8ca:	66 90                	xchg   %ax,%ax
 8cc:	66 90                	xchg   %ax,%ax
 8ce:	66 90                	xchg   %ax,%ax

000008d0 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 8d0:	55                   	push   %ebp
 8d1:	89 e5                	mov    %esp,%ebp
 8d3:	53                   	push   %ebx
 8d4:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 8d7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 8de:	e8 fd fe ff ff       	call   7e0 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 8e3:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 8ea:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 8ec:	e8 ef fe ff ff       	call   7e0 <malloc>
    if (tstack == NULL) {
 8f1:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 8f3:	89 c2                	mov    %eax,%edx
 8f5:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 8f8:	0f 84 8a 00 00 00    	je     988 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 8fe:	25 ff 0f 00 00       	and    $0xfff,%eax
 903:	75 73                	jne    978 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 905:	8b 45 10             	mov    0x10(%ebp),%eax
 908:	89 54 24 08          	mov    %edx,0x8(%esp)
 90c:	89 44 24 04          	mov    %eax,0x4(%esp)
 910:	8b 45 0c             	mov    0xc(%ebp),%eax
 913:	89 04 24             	mov    %eax,(%esp)
 916:	e8 57 fb ff ff       	call   472 <kthread_create>
 91b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 91d:	89 44 24 10          	mov    %eax,0x10(%esp)
 921:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 928:	00 
 929:	c7 44 24 08 34 0a 00 	movl   $0xa34,0x8(%esp)
 930:	00 
 931:	c7 44 24 04 43 0a 00 	movl   $0xa43,0x4(%esp)
 938:	00 
 939:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 940:	e8 eb fb ff ff       	call   530 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 945:	8b 03                	mov    (%ebx),%eax
 947:	c7 44 24 04 5a 0a 00 	movl   $0xa5a,0x4(%esp)
 94e:	00 
 94f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 956:	89 44 24 08          	mov    %eax,0x8(%esp)
 95a:	e8 d1 fb ff ff       	call   530 <printf>
    
    if (bt->tid != 0) {
 95f:	8b 03                	mov    (%ebx),%eax
 961:	85 c0                	test   %eax,%eax
 963:	74 23                	je     988 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 965:	8b 45 08             	mov    0x8(%ebp),%eax
 968:	89 18                	mov    %ebx,(%eax)
        return 0;
 96a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 96c:	83 c4 24             	add    $0x24,%esp
 96f:	5b                   	pop    %ebx
 970:	5d                   	pop    %ebp
 971:	c3                   	ret    
 972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 978:	29 c2                	sub    %eax,%edx
 97a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 980:	eb 83                	jmp    905 <benny_thread_create+0x35>
 982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 988:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 98d:	eb dd                	jmp    96c <benny_thread_create+0x9c>
 98f:	90                   	nop

00000990 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 990:	55                   	push   %ebp
 991:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 993:	8b 45 08             	mov    0x8(%ebp),%eax
}
 996:	5d                   	pop    %ebp
    return bt->tid;
 997:	8b 00                	mov    (%eax),%eax
}
 999:	c3                   	ret    
 99a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000009a0 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 9a0:	55                   	push   %ebp
 9a1:	89 e5                	mov    %esp,%ebp
 9a3:	53                   	push   %ebx
 9a4:	83 ec 14             	sub    $0x14,%esp
 9a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 9aa:	8b 03                	mov    (%ebx),%eax
 9ac:	89 04 24             	mov    %eax,(%esp)
 9af:	e8 c6 fa ff ff       	call   47a <kthread_join>
    if (retVal == 0) {
 9b4:	85 c0                	test   %eax,%eax
 9b6:	75 11                	jne    9c9 <benny_thread_join+0x29>
        free(bt->tstack);
 9b8:	8b 53 04             	mov    0x4(%ebx),%edx
 9bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9be:	89 14 24             	mov    %edx,(%esp)
 9c1:	e8 8a fd ff ff       	call   750 <free>
 9c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 9c9:	83 c4 14             	add    $0x14,%esp
 9cc:	5b                   	pop    %ebx
 9cd:	5d                   	pop    %ebp
 9ce:	c3                   	ret    
 9cf:	90                   	nop

000009d0 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 9d0:	55                   	push   %ebp
 9d1:	89 e5                	mov    %esp,%ebp
 9d3:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 9d6:	8b 45 08             	mov    0x8(%ebp),%eax
 9d9:	89 04 24             	mov    %eax,(%esp)
 9dc:	e8 a1 fa ff ff       	call   482 <kthread_exit>
    return 0;
}
 9e1:	31 c0                	xor    %eax,%eax
 9e3:	c9                   	leave  
 9e4:	c3                   	ret    
