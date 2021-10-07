
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
  int fd, i;
  char path[] = "stressfs0";
   1:	b8 30 00 00 00       	mov    $0x30,%eax
{
   6:	89 e5                	mov    %esp,%ebp
   8:	57                   	push   %edi
   9:	56                   	push   %esi
   a:	53                   	push   %ebx
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
   b:	31 db                	xor    %ebx,%ebx
{
   d:	83 e4 f0             	and    $0xfffffff0,%esp
  10:	81 ec 20 02 00 00    	sub    $0x220,%esp
  printf(1, "stressfs starting\n");
  16:	c7 44 24 04 95 09 00 	movl   $0x995,0x4(%esp)
  1d:	00 
  memset(data, 'a', sizeof(data));
  1e:	8d 74 24 20          	lea    0x20(%esp),%esi
  printf(1, "stressfs starting\n");
  22:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  char path[] = "stressfs0";
  29:	66 89 44 24 1e       	mov    %ax,0x1e(%esp)
  2e:	c7 44 24 16 73 74 72 	movl   $0x65727473,0x16(%esp)
  35:	65 
  36:	c7 44 24 1a 73 73 66 	movl   $0x73667373,0x1a(%esp)
  3d:	73 
  printf(1, "stressfs starting\n");
  3e:	e8 9d 04 00 00       	call   4e0 <printf>
  memset(data, 'a', sizeof(data));
  43:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  4a:	00 
  4b:	c7 44 24 04 61 00 00 	movl   $0x61,0x4(%esp)
  52:	00 
  53:	89 34 24             	mov    %esi,(%esp)
  56:	e8 95 01 00 00       	call   1f0 <memset>
    if(fork() > 0)
  5b:	e8 fa 02 00 00       	call   35a <fork>
  60:	85 c0                	test   %eax,%eax
  62:	0f 8f c3 00 00 00    	jg     12b <main+0x12b>
  for(i = 0; i < 4; i++)
  68:	83 c3 01             	add    $0x1,%ebx
  6b:	83 fb 04             	cmp    $0x4,%ebx
  6e:	75 eb                	jne    5b <main+0x5b>
  70:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
  75:	89 5c 24 08          	mov    %ebx,0x8(%esp)

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  79:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  7e:	c7 44 24 04 a8 09 00 	movl   $0x9a8,0x4(%esp)
  85:	00 
  86:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  8d:	e8 4e 04 00 00       	call   4e0 <printf>
  path[8] += i;
  92:	89 f8                	mov    %edi,%eax
  94:	00 44 24 1e          	add    %al,0x1e(%esp)
  fd = open(path, O_CREATE | O_RDWR);
  98:	8d 44 24 16          	lea    0x16(%esp),%eax
  9c:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  a3:	00 
  a4:	89 04 24             	mov    %eax,(%esp)
  a7:	e8 f6 02 00 00       	call   3a2 <open>
  ac:	89 c7                	mov    %eax,%edi
  ae:	66 90                	xchg   %ax,%ax
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
  b7:	00 
  b8:	89 74 24 04          	mov    %esi,0x4(%esp)
  bc:	89 3c 24             	mov    %edi,(%esp)
  bf:	e8 be 02 00 00       	call   382 <write>
  for(i = 0; i < 20; i++)
  c4:	83 eb 01             	sub    $0x1,%ebx
  c7:	75 e7                	jne    b0 <main+0xb0>
  close(fd);
  c9:	89 3c 24             	mov    %edi,(%esp)

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  cc:	bb 14 00 00 00       	mov    $0x14,%ebx
  close(fd);
  d1:	e8 b4 02 00 00       	call   38a <close>
  printf(1, "read\n");
  d6:	c7 44 24 04 b2 09 00 	movl   $0x9b2,0x4(%esp)
  dd:	00 
  de:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e5:	e8 f6 03 00 00       	call   4e0 <printf>
  fd = open(path, O_RDONLY);
  ea:	8d 44 24 16          	lea    0x16(%esp),%eax
  ee:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  f5:	00 
  f6:	89 04 24             	mov    %eax,(%esp)
  f9:	e8 a4 02 00 00       	call   3a2 <open>
  fe:	89 c7                	mov    %eax,%edi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
 100:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
 107:	00 
 108:	89 74 24 04          	mov    %esi,0x4(%esp)
 10c:	89 3c 24             	mov    %edi,(%esp)
 10f:	e8 66 02 00 00       	call   37a <read>
  for (i = 0; i < 20; i++)
 114:	83 eb 01             	sub    $0x1,%ebx
 117:	75 e7                	jne    100 <main+0x100>
  close(fd);
 119:	89 3c 24             	mov    %edi,(%esp)
 11c:	e8 69 02 00 00       	call   38a <close>

  wait();
 121:	e8 44 02 00 00       	call   36a <wait>

  exit();
 126:	e8 37 02 00 00       	call   362 <exit>
 12b:	89 df                	mov    %ebx,%edi
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	e9 40 ff ff ff       	jmp    75 <main+0x75>
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	8b 45 08             	mov    0x8(%ebp),%eax
 146:	8b 4d 0c             	mov    0xc(%ebp),%ecx
 149:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c1 01             	add    $0x1,%ecx
 153:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 db                	test   %bl,%bl
 15c:	88 5a ff             	mov    %bl,-0x1(%edx)
 15f:	75 ef                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 161:	5b                   	pop    %ebx
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 55 08             	mov    0x8(%ebp),%edx
 176:	53                   	push   %ebx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	84 c0                	test   %al,%al
 17f:	74 2d                	je     1ae <strcmp+0x3e>
 181:	0f b6 19             	movzbl (%ecx),%ebx
 184:	38 d8                	cmp    %bl,%al
 186:	74 0e                	je     196 <strcmp+0x26>
 188:	eb 2b                	jmp    1b5 <strcmp+0x45>
 18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 190:	38 c8                	cmp    %cl,%al
 192:	75 15                	jne    1a9 <strcmp+0x39>
    p++, q++;
 194:	89 d9                	mov    %ebx,%ecx
 196:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 199:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 19c:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 19f:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 1a3:	84 c0                	test   %al,%al
 1a5:	75 e9                	jne    190 <strcmp+0x20>
 1a7:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1a9:	29 c8                	sub    %ecx,%eax
}
 1ab:	5b                   	pop    %ebx
 1ac:	5d                   	pop    %ebp
 1ad:	c3                   	ret    
 1ae:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 1b1:	31 c0                	xor    %eax,%eax
 1b3:	eb f4                	jmp    1a9 <strcmp+0x39>
 1b5:	0f b6 cb             	movzbl %bl,%ecx
 1b8:	eb ef                	jmp    1a9 <strcmp+0x39>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 12                	je     1dd <strlen+0x1d>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
  for(n = 0; s[n]; n++)
 1dd:	31 c0                	xor    %eax,%eax
}
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret    
 1e1:	eb 0d                	jmp    1f0 <memset>
 1e3:	90                   	nop
 1e4:	90                   	nop
 1e5:	90                   	nop
 1e6:	90                   	nop
 1e7:	90                   	nop
 1e8:	90                   	nop
 1e9:	90                   	nop
 1ea:	90                   	nop
 1eb:	90                   	nop
 1ec:	90                   	nop
 1ed:	90                   	nop
 1ee:	90                   	nop
 1ef:	90                   	nop

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 55 08             	mov    0x8(%ebp),%edx
 1f6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	53                   	push   %ebx
 217:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 21a:	0f b6 18             	movzbl (%eax),%ebx
 21d:	84 db                	test   %bl,%bl
 21f:	74 1d                	je     23e <strchr+0x2e>
    if(*s == c)
 221:	38 d3                	cmp    %dl,%bl
 223:	89 d1                	mov    %edx,%ecx
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
  for(; *s; s++)
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
 23e:	31 c0                	xor    %eax,%eax
}
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 255:	31 f6                	xor    %esi,%esi
{
 257:	53                   	push   %ebx
 258:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 25b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 25e:	eb 31                	jmp    291 <gets+0x41>
    cc = read(0, &c, 1);
 260:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 267:	00 
 268:	89 7c 24 04          	mov    %edi,0x4(%esp)
 26c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 273:	e8 02 01 00 00       	call   37a <read>
    if(cc < 1)
 278:	85 c0                	test   %eax,%eax
 27a:	7e 1d                	jle    299 <gets+0x49>
      break;
    buf[i++] = c;
 27c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 280:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 282:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 285:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 287:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 28b:	74 0c                	je     299 <gets+0x49>
 28d:	3c 0a                	cmp    $0xa,%al
 28f:	74 08                	je     299 <gets+0x49>
  for(i=0; i+1 < max; ){
 291:	8d 5e 01             	lea    0x1(%esi),%ebx
 294:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 297:	7c c7                	jl     260 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 299:	8b 45 08             	mov    0x8(%ebp),%eax
 29c:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 2a0:	83 c4 2c             	add    $0x2c,%esp
 2a3:	5b                   	pop    %ebx
 2a4:	5e                   	pop    %esi
 2a5:	5f                   	pop    %edi
 2a6:	5d                   	pop    %ebp
 2a7:	c3                   	ret    
 2a8:	90                   	nop
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
 2bb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2c2:	00 
 2c3:	89 04 24             	mov    %eax,(%esp)
 2c6:	e8 d7 00 00 00       	call   3a2 <open>
  if(fd < 0)
 2cb:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 2cd:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 2cf:	78 27                	js     2f8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 2d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d4:	89 1c 24             	mov    %ebx,(%esp)
 2d7:	89 44 24 04          	mov    %eax,0x4(%esp)
 2db:	e8 da 00 00 00       	call   3ba <fstat>
  close(fd);
 2e0:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2e3:	89 c6                	mov    %eax,%esi
  close(fd);
 2e5:	e8 a0 00 00 00       	call   38a <close>
  return r;
 2ea:	89 f0                	mov    %esi,%eax
}
 2ec:	83 c4 10             	add    $0x10,%esp
 2ef:	5b                   	pop    %ebx
 2f0:	5e                   	pop    %esi
 2f1:	5d                   	pop    %ebp
 2f2:	c3                   	ret    
 2f3:	90                   	nop
 2f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 2f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2fd:	eb ed                	jmp    2ec <stat+0x3c>
 2ff:	90                   	nop

00000300 <atoi>:

int
atoi(const char *s)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 4d 08             	mov    0x8(%ebp),%ecx
 306:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 307:	0f be 11             	movsbl (%ecx),%edx
 30a:	8d 42 d0             	lea    -0x30(%edx),%eax
 30d:	3c 09                	cmp    $0x9,%al
  n = 0;
 30f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 314:	77 17                	ja     32d <atoi+0x2d>
 316:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 318:	83 c1 01             	add    $0x1,%ecx
 31b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 31e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 322:	0f be 11             	movsbl (%ecx),%edx
 325:	8d 5a d0             	lea    -0x30(%edx),%ebx
 328:	80 fb 09             	cmp    $0x9,%bl
 32b:	76 eb                	jbe    318 <atoi+0x18>
  return n;
}
 32d:	5b                   	pop    %ebx
 32e:	5d                   	pop    %ebp
 32f:	c3                   	ret    

00000330 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 330:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 331:	31 d2                	xor    %edx,%edx
{
 333:	89 e5                	mov    %esp,%ebp
 335:	56                   	push   %esi
 336:	8b 45 08             	mov    0x8(%ebp),%eax
 339:	53                   	push   %ebx
 33a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 33d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 340:	85 db                	test   %ebx,%ebx
 342:	7e 12                	jle    356 <memmove+0x26>
 344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 348:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 34c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 34f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 352:	39 da                	cmp    %ebx,%edx
 354:	75 f2                	jne    348 <memmove+0x18>
  return vdst;
}
 356:	5b                   	pop    %ebx
 357:	5e                   	pop    %esi
 358:	5d                   	pop    %ebp
 359:	c3                   	ret    

0000035a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 35a:	b8 01 00 00 00       	mov    $0x1,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <exit>:
SYSCALL(exit)
 362:	b8 02 00 00 00       	mov    $0x2,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <wait>:
SYSCALL(wait)
 36a:	b8 03 00 00 00       	mov    $0x3,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <pipe>:
SYSCALL(pipe)
 372:	b8 04 00 00 00       	mov    $0x4,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <read>:
SYSCALL(read)
 37a:	b8 05 00 00 00       	mov    $0x5,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <write>:
SYSCALL(write)
 382:	b8 10 00 00 00       	mov    $0x10,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <close>:
SYSCALL(close)
 38a:	b8 15 00 00 00       	mov    $0x15,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <kill>:
SYSCALL(kill)
 392:	b8 06 00 00 00       	mov    $0x6,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <exec>:
SYSCALL(exec)
 39a:	b8 07 00 00 00       	mov    $0x7,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <open>:
SYSCALL(open)
 3a2:	b8 0f 00 00 00       	mov    $0xf,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mknod>:
SYSCALL(mknod)
 3aa:	b8 11 00 00 00       	mov    $0x11,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <unlink>:
SYSCALL(unlink)
 3b2:	b8 12 00 00 00       	mov    $0x12,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <fstat>:
SYSCALL(fstat)
 3ba:	b8 08 00 00 00       	mov    $0x8,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <link>:
SYSCALL(link)
 3c2:	b8 13 00 00 00       	mov    $0x13,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <mkdir>:
SYSCALL(mkdir)
 3ca:	b8 14 00 00 00       	mov    $0x14,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <chdir>:
SYSCALL(chdir)
 3d2:	b8 09 00 00 00       	mov    $0x9,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <dup>:
SYSCALL(dup)
 3da:	b8 0a 00 00 00       	mov    $0xa,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <getpid>:
SYSCALL(getpid)
 3e2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <sbrk>:
SYSCALL(sbrk)
 3ea:	b8 0c 00 00 00       	mov    $0xc,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <sleep>:
SYSCALL(sleep)
 3f2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <uptime>:
SYSCALL(uptime)
 3fa:	b8 0e 00 00 00       	mov    $0xe,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 402:	b8 16 00 00 00       	mov    $0x16,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 40a:	b8 17 00 00 00       	mov    $0x17,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 412:	b8 18 00 00 00       	mov    $0x18,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <halt>:
SYSCALL(halt)
 41a:	b8 19 00 00 00       	mov    $0x19,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 422:	b8 1a 00 00 00       	mov    $0x1a,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <kthread_join>:
SYSCALL(kthread_join)
 42a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <kthread_exit>:
SYSCALL(kthread_exit)
 432:	b8 1c 00 00 00       	mov    $0x1c,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    
 43a:	66 90                	xchg   %ax,%ax
 43c:	66 90                	xchg   %ax,%ax
 43e:	66 90                	xchg   %ax,%ax

00000440 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
 444:	56                   	push   %esi
 445:	89 c6                	mov    %eax,%esi
 447:	53                   	push   %ebx
 448:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 44b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 44e:	85 db                	test   %ebx,%ebx
 450:	74 09                	je     45b <printint+0x1b>
 452:	89 d0                	mov    %edx,%eax
 454:	c1 e8 1f             	shr    $0x1f,%eax
 457:	84 c0                	test   %al,%al
 459:	75 75                	jne    4d0 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 45b:	89 d0                	mov    %edx,%eax
  neg = 0;
 45d:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 464:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 467:	31 ff                	xor    %edi,%edi
 469:	89 ce                	mov    %ecx,%esi
 46b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 46e:	eb 02                	jmp    472 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 470:	89 cf                	mov    %ecx,%edi
 472:	31 d2                	xor    %edx,%edx
 474:	f7 f6                	div    %esi
 476:	8d 4f 01             	lea    0x1(%edi),%ecx
 479:	0f b6 92 bf 09 00 00 	movzbl 0x9bf(%edx),%edx
  }while((x /= base) != 0);
 480:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 482:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 485:	75 e9                	jne    470 <printint+0x30>
  if(neg)
 487:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 48a:	89 c8                	mov    %ecx,%eax
 48c:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 48f:	85 d2                	test   %edx,%edx
 491:	74 08                	je     49b <printint+0x5b>
    buf[i++] = '-';
 493:	8d 4f 02             	lea    0x2(%edi),%ecx
 496:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 49b:	8d 79 ff             	lea    -0x1(%ecx),%edi
 49e:	66 90                	xchg   %ax,%ax
 4a0:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 4a5:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 4a8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4af:	00 
 4b0:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 4b4:	89 34 24             	mov    %esi,(%esp)
 4b7:	88 45 d7             	mov    %al,-0x29(%ebp)
 4ba:	e8 c3 fe ff ff       	call   382 <write>
  while(--i >= 0)
 4bf:	83 ff ff             	cmp    $0xffffffff,%edi
 4c2:	75 dc                	jne    4a0 <printint+0x60>
    putc(fd, buf[i]);
}
 4c4:	83 c4 4c             	add    $0x4c,%esp
 4c7:	5b                   	pop    %ebx
 4c8:	5e                   	pop    %esi
 4c9:	5f                   	pop    %edi
 4ca:	5d                   	pop    %ebp
 4cb:	c3                   	ret    
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 4d0:	89 d0                	mov    %edx,%eax
 4d2:	f7 d8                	neg    %eax
    neg = 1;
 4d4:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 4db:	eb 87                	jmp    464 <printint+0x24>
 4dd:	8d 76 00             	lea    0x0(%esi),%esi

000004e0 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4e4:	31 ff                	xor    %edi,%edi
{
 4e6:	56                   	push   %esi
 4e7:	53                   	push   %ebx
 4e8:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4eb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 4ee:	8d 45 10             	lea    0x10(%ebp),%eax
{
 4f1:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 4f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 4f7:	0f b6 13             	movzbl (%ebx),%edx
 4fa:	83 c3 01             	add    $0x1,%ebx
 4fd:	84 d2                	test   %dl,%dl
 4ff:	75 39                	jne    53a <printf+0x5a>
 501:	e9 ca 00 00 00       	jmp    5d0 <printf+0xf0>
 506:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 508:	83 fa 25             	cmp    $0x25,%edx
 50b:	0f 84 c7 00 00 00    	je     5d8 <printf+0xf8>
  write(fd, &c, 1);
 511:	8d 45 e0             	lea    -0x20(%ebp),%eax
 514:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 51b:	00 
 51c:	89 44 24 04          	mov    %eax,0x4(%esp)
 520:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 523:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 526:	e8 57 fe ff ff       	call   382 <write>
 52b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 52e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 532:	84 d2                	test   %dl,%dl
 534:	0f 84 96 00 00 00    	je     5d0 <printf+0xf0>
    if(state == 0){
 53a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 53c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 53f:	74 c7                	je     508 <printf+0x28>
      }
    } else if(state == '%'){
 541:	83 ff 25             	cmp    $0x25,%edi
 544:	75 e5                	jne    52b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 546:	83 fa 75             	cmp    $0x75,%edx
 549:	0f 84 99 00 00 00    	je     5e8 <printf+0x108>
 54f:	83 fa 64             	cmp    $0x64,%edx
 552:	0f 84 90 00 00 00    	je     5e8 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 558:	25 f7 00 00 00       	and    $0xf7,%eax
 55d:	83 f8 70             	cmp    $0x70,%eax
 560:	0f 84 aa 00 00 00    	je     610 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 566:	83 fa 73             	cmp    $0x73,%edx
 569:	0f 84 e9 00 00 00    	je     658 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56f:	83 fa 63             	cmp    $0x63,%edx
 572:	0f 84 2b 01 00 00    	je     6a3 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 578:	83 fa 25             	cmp    $0x25,%edx
 57b:	0f 84 4f 01 00 00    	je     6d0 <printf+0x1f0>
  write(fd, &c, 1);
 581:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 584:	83 c3 01             	add    $0x1,%ebx
 587:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 58e:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 58f:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 591:	89 44 24 04          	mov    %eax,0x4(%esp)
 595:	89 34 24             	mov    %esi,(%esp)
 598:	89 55 d0             	mov    %edx,-0x30(%ebp)
 59b:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 59f:	e8 de fd ff ff       	call   382 <write>
        putc(fd, c);
 5a4:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 5a7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5b1:	00 
 5b2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5b6:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 5b9:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 5bc:	e8 c1 fd ff ff       	call   382 <write>
  for(i = 0; fmt[i]; i++){
 5c1:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 5c5:	84 d2                	test   %dl,%dl
 5c7:	0f 85 6d ff ff ff    	jne    53a <printf+0x5a>
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 5d0:	83 c4 3c             	add    $0x3c,%esp
 5d3:	5b                   	pop    %ebx
 5d4:	5e                   	pop    %esi
 5d5:	5f                   	pop    %edi
 5d6:	5d                   	pop    %ebp
 5d7:	c3                   	ret    
        state = '%';
 5d8:	bf 25 00 00 00       	mov    $0x25,%edi
 5dd:	e9 49 ff ff ff       	jmp    52b <printf+0x4b>
 5e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 5ef:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 5f4:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 5f7:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 5f9:	8b 10                	mov    (%eax),%edx
 5fb:	89 f0                	mov    %esi,%eax
 5fd:	e8 3e fe ff ff       	call   440 <printint>
        ap++;
 602:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 606:	e9 20 ff ff ff       	jmp    52b <printf+0x4b>
 60b:	90                   	nop
 60c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 610:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 613:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 61a:	00 
 61b:	89 44 24 04          	mov    %eax,0x4(%esp)
 61f:	89 34 24             	mov    %esi,(%esp)
 622:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 626:	e8 57 fd ff ff       	call   382 <write>
 62b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 62e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 635:	00 
 636:	89 44 24 04          	mov    %eax,0x4(%esp)
 63a:	89 34 24             	mov    %esi,(%esp)
 63d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 641:	e8 3c fd ff ff       	call   382 <write>
        printint(fd, *ap, 16, 0);
 646:	b9 10 00 00 00       	mov    $0x10,%ecx
 64b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 652:	eb a0                	jmp    5f4 <printf+0x114>
 654:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 658:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 65b:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 65f:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 661:	b8 b8 09 00 00       	mov    $0x9b8,%eax
 666:	85 ff                	test   %edi,%edi
 668:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 66b:	0f b6 07             	movzbl (%edi),%eax
 66e:	84 c0                	test   %al,%al
 670:	74 2a                	je     69c <printf+0x1bc>
 672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 678:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 67b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 67e:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 681:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 688:	00 
 689:	89 44 24 04          	mov    %eax,0x4(%esp)
 68d:	89 34 24             	mov    %esi,(%esp)
 690:	e8 ed fc ff ff       	call   382 <write>
        while(*s != 0){
 695:	0f b6 07             	movzbl (%edi),%eax
 698:	84 c0                	test   %al,%al
 69a:	75 dc                	jne    678 <printf+0x198>
      state = 0;
 69c:	31 ff                	xor    %edi,%edi
 69e:	e9 88 fe ff ff       	jmp    52b <printf+0x4b>
        putc(fd, *ap);
 6a3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 6a6:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 6a8:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 6aa:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6b1:	00 
 6b2:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 6b5:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 6b8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 6bb:	89 44 24 04          	mov    %eax,0x4(%esp)
 6bf:	e8 be fc ff ff       	call   382 <write>
        ap++;
 6c4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 6c8:	e9 5e fe ff ff       	jmp    52b <printf+0x4b>
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 6d0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 6d3:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 6d5:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 6dc:	00 
 6dd:	89 44 24 04          	mov    %eax,0x4(%esp)
 6e1:	89 34 24             	mov    %esi,(%esp)
 6e4:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 6e8:	e8 95 fc ff ff       	call   382 <write>
 6ed:	e9 39 fe ff ff       	jmp    52b <printf+0x4b>
 6f2:	66 90                	xchg   %ax,%ax
 6f4:	66 90                	xchg   %ax,%ax
 6f6:	66 90                	xchg   %ax,%ax
 6f8:	66 90                	xchg   %ax,%ax
 6fa:	66 90                	xchg   %ax,%ax
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 700:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 701:	a1 f4 0c 00 00       	mov    0xcf4,%eax
{
 706:	89 e5                	mov    %esp,%ebp
 708:	57                   	push   %edi
 709:	56                   	push   %esi
 70a:	53                   	push   %ebx
 70b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 710:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 713:	39 d0                	cmp    %edx,%eax
 715:	72 11                	jb     728 <free+0x28>
 717:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 718:	39 c8                	cmp    %ecx,%eax
 71a:	72 04                	jb     720 <free+0x20>
 71c:	39 ca                	cmp    %ecx,%edx
 71e:	72 10                	jb     730 <free+0x30>
 720:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 722:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 724:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 726:	73 f0                	jae    718 <free+0x18>
 728:	39 ca                	cmp    %ecx,%edx
 72a:	72 04                	jb     730 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 72c:	39 c8                	cmp    %ecx,%eax
 72e:	72 f0                	jb     720 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 730:	8b 73 fc             	mov    -0x4(%ebx),%esi
 733:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 736:	39 cf                	cmp    %ecx,%edi
 738:	74 1e                	je     758 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 73a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 73d:	8b 48 04             	mov    0x4(%eax),%ecx
 740:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 743:	39 f2                	cmp    %esi,%edx
 745:	74 28                	je     76f <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 747:	89 10                	mov    %edx,(%eax)
  freep = p;
 749:	a3 f4 0c 00 00       	mov    %eax,0xcf4
}
 74e:	5b                   	pop    %ebx
 74f:	5e                   	pop    %esi
 750:	5f                   	pop    %edi
 751:	5d                   	pop    %ebp
 752:	c3                   	ret    
 753:	90                   	nop
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 758:	03 71 04             	add    0x4(%ecx),%esi
 75b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 75e:	8b 08                	mov    (%eax),%ecx
 760:	8b 09                	mov    (%ecx),%ecx
 762:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 765:	8b 48 04             	mov    0x4(%eax),%ecx
 768:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 76b:	39 f2                	cmp    %esi,%edx
 76d:	75 d8                	jne    747 <free+0x47>
    p->s.size += bp->s.size;
 76f:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 772:	a3 f4 0c 00 00       	mov    %eax,0xcf4
    p->s.size += bp->s.size;
 777:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 77a:	8b 53 f8             	mov    -0x8(%ebx),%edx
 77d:	89 10                	mov    %edx,(%eax)
}
 77f:	5b                   	pop    %ebx
 780:	5e                   	pop    %esi
 781:	5f                   	pop    %edi
 782:	5d                   	pop    %ebp
 783:	c3                   	ret    
 784:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 78a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000790 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 799:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 79c:	8b 1d f4 0c 00 00    	mov    0xcf4,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a2:	8d 48 07             	lea    0x7(%eax),%ecx
 7a5:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 7a8:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7aa:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 7ad:	0f 84 9b 00 00 00    	je     84e <malloc+0xbe>
 7b3:	8b 13                	mov    (%ebx),%edx
 7b5:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7b8:	39 fe                	cmp    %edi,%esi
 7ba:	76 64                	jbe    820 <malloc+0x90>
 7bc:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 7c3:	bb 00 80 00 00       	mov    $0x8000,%ebx
 7c8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 7cb:	eb 0e                	jmp    7db <malloc+0x4b>
 7cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7d2:	8b 78 04             	mov    0x4(%eax),%edi
 7d5:	39 fe                	cmp    %edi,%esi
 7d7:	76 4f                	jbe    828 <malloc+0x98>
 7d9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7db:	3b 15 f4 0c 00 00    	cmp    0xcf4,%edx
 7e1:	75 ed                	jne    7d0 <malloc+0x40>
  if(nu < 4096)
 7e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7e6:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7ec:	bf 00 10 00 00       	mov    $0x1000,%edi
 7f1:	0f 43 fe             	cmovae %esi,%edi
 7f4:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 7f7:	89 04 24             	mov    %eax,(%esp)
 7fa:	e8 eb fb ff ff       	call   3ea <sbrk>
  if(p == (char*)-1)
 7ff:	83 f8 ff             	cmp    $0xffffffff,%eax
 802:	74 18                	je     81c <malloc+0x8c>
  hp->s.size = nu;
 804:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 807:	83 c0 08             	add    $0x8,%eax
 80a:	89 04 24             	mov    %eax,(%esp)
 80d:	e8 ee fe ff ff       	call   700 <free>
  return freep;
 812:	8b 15 f4 0c 00 00    	mov    0xcf4,%edx
      if((p = morecore(nunits)) == 0)
 818:	85 d2                	test   %edx,%edx
 81a:	75 b4                	jne    7d0 <malloc+0x40>
        return 0;
 81c:	31 c0                	xor    %eax,%eax
 81e:	eb 20                	jmp    840 <malloc+0xb0>
    if(p->s.size >= nunits){
 820:	89 d0                	mov    %edx,%eax
 822:	89 da                	mov    %ebx,%edx
 824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 828:	39 fe                	cmp    %edi,%esi
 82a:	74 1c                	je     848 <malloc+0xb8>
        p->s.size -= nunits;
 82c:	29 f7                	sub    %esi,%edi
 82e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 831:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 834:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 837:	89 15 f4 0c 00 00    	mov    %edx,0xcf4
      return (void*)(p + 1);
 83d:	83 c0 08             	add    $0x8,%eax
  }
}
 840:	83 c4 1c             	add    $0x1c,%esp
 843:	5b                   	pop    %ebx
 844:	5e                   	pop    %esi
 845:	5f                   	pop    %edi
 846:	5d                   	pop    %ebp
 847:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 848:	8b 08                	mov    (%eax),%ecx
 84a:	89 0a                	mov    %ecx,(%edx)
 84c:	eb e9                	jmp    837 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 84e:	c7 05 f4 0c 00 00 f8 	movl   $0xcf8,0xcf4
 855:	0c 00 00 
    base.s.size = 0;
 858:	ba f8 0c 00 00       	mov    $0xcf8,%edx
    base.s.ptr = freep = prevp = &base;
 85d:	c7 05 f8 0c 00 00 f8 	movl   $0xcf8,0xcf8
 864:	0c 00 00 
    base.s.size = 0;
 867:	c7 05 fc 0c 00 00 00 	movl   $0x0,0xcfc
 86e:	00 00 00 
 871:	e9 46 ff ff ff       	jmp    7bc <malloc+0x2c>
 876:	66 90                	xchg   %ax,%ax
 878:	66 90                	xchg   %ax,%ax
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	53                   	push   %ebx
 884:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 887:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 88e:	e8 fd fe ff ff       	call   790 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 893:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 89a:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 89c:	e8 ef fe ff ff       	call   790 <malloc>
    if (tstack == NULL) {
 8a1:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 8a3:	89 c2                	mov    %eax,%edx
 8a5:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 8a8:	0f 84 8a 00 00 00    	je     938 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 8ae:	25 ff 0f 00 00       	and    $0xfff,%eax
 8b3:	75 73                	jne    928 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 8b5:	8b 45 10             	mov    0x10(%ebp),%eax
 8b8:	89 54 24 08          	mov    %edx,0x8(%esp)
 8bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 8c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 8c3:	89 04 24             	mov    %eax,(%esp)
 8c6:	e8 57 fb ff ff       	call   422 <kthread_create>
 8cb:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 8cd:	89 44 24 10          	mov    %eax,0x10(%esp)
 8d1:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 8d8:	00 
 8d9:	c7 44 24 08 d0 09 00 	movl   $0x9d0,0x8(%esp)
 8e0:	00 
 8e1:	c7 44 24 04 df 09 00 	movl   $0x9df,0x4(%esp)
 8e8:	00 
 8e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8f0:	e8 eb fb ff ff       	call   4e0 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 8f5:	8b 03                	mov    (%ebx),%eax
 8f7:	c7 44 24 04 f6 09 00 	movl   $0x9f6,0x4(%esp)
 8fe:	00 
 8ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 906:	89 44 24 08          	mov    %eax,0x8(%esp)
 90a:	e8 d1 fb ff ff       	call   4e0 <printf>
    
    if (bt->tid != 0) {
 90f:	8b 03                	mov    (%ebx),%eax
 911:	85 c0                	test   %eax,%eax
 913:	74 23                	je     938 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 915:	8b 45 08             	mov    0x8(%ebp),%eax
 918:	89 18                	mov    %ebx,(%eax)
        return 0;
 91a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 91c:	83 c4 24             	add    $0x24,%esp
 91f:	5b                   	pop    %ebx
 920:	5d                   	pop    %ebp
 921:	c3                   	ret    
 922:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 928:	29 c2                	sub    %eax,%edx
 92a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 930:	eb 83                	jmp    8b5 <benny_thread_create+0x35>
 932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 938:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 93d:	eb dd                	jmp    91c <benny_thread_create+0x9c>
 93f:	90                   	nop

00000940 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 940:	55                   	push   %ebp
 941:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 943:	8b 45 08             	mov    0x8(%ebp),%eax
}
 946:	5d                   	pop    %ebp
    return bt->tid;
 947:	8b 00                	mov    (%eax),%eax
}
 949:	c3                   	ret    
 94a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000950 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 950:	55                   	push   %ebp
 951:	89 e5                	mov    %esp,%ebp
 953:	53                   	push   %ebx
 954:	83 ec 14             	sub    $0x14,%esp
 957:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 95a:	8b 03                	mov    (%ebx),%eax
 95c:	89 04 24             	mov    %eax,(%esp)
 95f:	e8 c6 fa ff ff       	call   42a <kthread_join>
    if (retVal == 0) {
 964:	85 c0                	test   %eax,%eax
 966:	75 11                	jne    979 <benny_thread_join+0x29>
        free(bt->tstack);
 968:	8b 53 04             	mov    0x4(%ebx),%edx
 96b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 96e:	89 14 24             	mov    %edx,(%esp)
 971:	e8 8a fd ff ff       	call   700 <free>
 976:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 979:	83 c4 14             	add    $0x14,%esp
 97c:	5b                   	pop    %ebx
 97d:	5d                   	pop    %ebp
 97e:	c3                   	ret    
 97f:	90                   	nop

00000980 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 980:	55                   	push   %ebp
 981:	89 e5                	mov    %esp,%ebp
 983:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 986:	8b 45 08             	mov    0x8(%ebp),%eax
 989:	89 04 24             	mov    %eax,(%esp)
 98c:	e8 a1 fa ff ff       	call   432 <kthread_exit>
    return 0;
}
 991:	31 c0                	xor    %eax,%eax
 993:	c9                   	leave  
 994:	c3                   	ret    
