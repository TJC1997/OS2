
_memalgn:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

#define PGSIZE 4096

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	83 e4 f0             	and    $0xfffffff0,%esp
   8:	83 ec 10             	sub    $0x10,%esp
    void *ptr = NULL;

    ptr = malloc(50);
   b:	c7 04 24 32 00 00 00 	movl   $0x32,(%esp)
  12:	e8 d9 06 00 00       	call   6f0 <malloc>
    ptr = malloc(PGSIZE * 2);
  17:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
  1e:	e8 cd 06 00 00       	call   6f0 <malloc>
    printf(1, "%p ptr\n", ptr);
  23:	c7 44 24 04 f5 08 00 	movl   $0x8f5,0x4(%esp)
  2a:	00 
  2b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    ptr = malloc(PGSIZE * 2);
  32:	89 c3                	mov    %eax,%ebx
    printf(1, "%u pg offset ptr\n", ((ulong) ptr) % PGSIZE);
  34:	89 de                	mov    %ebx,%esi
  36:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
    printf(1, "%p ptr\n", ptr);
  3c:	89 44 24 08          	mov    %eax,0x8(%esp)

    ptr += (PGSIZE - ((ulong) ptr) % PGSIZE);
  40:	29 f3                	sub    %esi,%ebx
    printf(1, "%p ptr\n", ptr);
  42:	e8 f9 03 00 00       	call   440 <printf>
    ptr += (PGSIZE - ((ulong) ptr) % PGSIZE);
  47:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    printf(1, "%u pg offset ptr\n", ((ulong) ptr) % PGSIZE);
  4d:	89 74 24 08          	mov    %esi,0x8(%esp)
  51:	c7 44 24 04 fd 08 00 	movl   $0x8fd,0x4(%esp)
  58:	00 
  59:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  60:	e8 db 03 00 00       	call   440 <printf>
    printf(1, "%p ptr\n", ptr);
  65:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    printf(1, "%u pg offset ptr\n", ((ulong) ptr) % PGSIZE);
  69:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
    printf(1, "%p ptr\n", ptr);
  6f:	c7 44 24 04 f5 08 00 	movl   $0x8f5,0x4(%esp)
  76:	00 
  77:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  7e:	e8 bd 03 00 00       	call   440 <printf>
    printf(1, "%u pg offset ptr\n", ((ulong) ptr) % PGSIZE);
  83:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  87:	c7 44 24 04 fd 08 00 	movl   $0x8fd,0x4(%esp)
  8e:	00 
  8f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  96:	e8 a5 03 00 00       	call   440 <printf>

    exit();
  9b:	e8 22 02 00 00       	call   2c2 <exit>

000000a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 45 08             	mov    0x8(%ebp),%eax
  a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  a9:	53                   	push   %ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  aa:	89 c2                	mov    %eax,%edx
  ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  b0:	83 c1 01             	add    $0x1,%ecx
  b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  b7:	83 c2 01             	add    $0x1,%edx
  ba:	84 db                	test   %bl,%bl
  bc:	88 5a ff             	mov    %bl,-0x1(%edx)
  bf:	75 ef                	jne    b0 <strcpy+0x10>
    ;
  return os;
}
  c1:	5b                   	pop    %ebx
  c2:	5d                   	pop    %ebp
  c3:	c3                   	ret    
  c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 55 08             	mov    0x8(%ebp),%edx
  d6:	53                   	push   %ebx
  d7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  da:	0f b6 02             	movzbl (%edx),%eax
  dd:	84 c0                	test   %al,%al
  df:	74 2d                	je     10e <strcmp+0x3e>
  e1:	0f b6 19             	movzbl (%ecx),%ebx
  e4:	38 d8                	cmp    %bl,%al
  e6:	74 0e                	je     f6 <strcmp+0x26>
  e8:	eb 2b                	jmp    115 <strcmp+0x45>
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f0:	38 c8                	cmp    %cl,%al
  f2:	75 15                	jne    109 <strcmp+0x39>
    p++, q++;
  f4:	89 d9                	mov    %ebx,%ecx
  f6:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  f9:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  fc:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
  ff:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
 103:	84 c0                	test   %al,%al
 105:	75 e9                	jne    f0 <strcmp+0x20>
 107:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 109:	29 c8                	sub    %ecx,%eax
}
 10b:	5b                   	pop    %ebx
 10c:	5d                   	pop    %ebp
 10d:	c3                   	ret    
 10e:	0f b6 09             	movzbl (%ecx),%ecx
  while(*p && *p == *q)
 111:	31 c0                	xor    %eax,%eax
 113:	eb f4                	jmp    109 <strcmp+0x39>
 115:	0f b6 cb             	movzbl %bl,%ecx
 118:	eb ef                	jmp    109 <strcmp+0x39>
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000120 <strlen>:

uint
strlen(const char *s)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 126:	80 39 00             	cmpb   $0x0,(%ecx)
 129:	74 12                	je     13d <strlen+0x1d>
 12b:	31 d2                	xor    %edx,%edx
 12d:	8d 76 00             	lea    0x0(%esi),%esi
 130:	83 c2 01             	add    $0x1,%edx
 133:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 137:	89 d0                	mov    %edx,%eax
 139:	75 f5                	jne    130 <strlen+0x10>
    ;
  return n;
}
 13b:	5d                   	pop    %ebp
 13c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 13d:	31 c0                	xor    %eax,%eax
}
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	eb 0d                	jmp    150 <memset>
 143:	90                   	nop
 144:	90                   	nop
 145:	90                   	nop
 146:	90                   	nop
 147:	90                   	nop
 148:	90                   	nop
 149:	90                   	nop
 14a:	90                   	nop
 14b:	90                   	nop
 14c:	90                   	nop
 14d:	90                   	nop
 14e:	90                   	nop
 14f:	90                   	nop

00000150 <memset>:

void*
memset(void *dst, int c, uint n)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	8b 55 08             	mov    0x8(%ebp),%edx
 156:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 157:	8b 4d 10             	mov    0x10(%ebp),%ecx
 15a:	8b 45 0c             	mov    0xc(%ebp),%eax
 15d:	89 d7                	mov    %edx,%edi
 15f:	fc                   	cld    
 160:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 162:	89 d0                	mov    %edx,%eax
 164:	5f                   	pop    %edi
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strchr>:

char*
strchr(const char *s, char c)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 45 08             	mov    0x8(%ebp),%eax
 176:	53                   	push   %ebx
 177:	8b 55 0c             	mov    0xc(%ebp),%edx
  for(; *s; s++)
 17a:	0f b6 18             	movzbl (%eax),%ebx
 17d:	84 db                	test   %bl,%bl
 17f:	74 1d                	je     19e <strchr+0x2e>
    if(*s == c)
 181:	38 d3                	cmp    %dl,%bl
 183:	89 d1                	mov    %edx,%ecx
 185:	75 0d                	jne    194 <strchr+0x24>
 187:	eb 17                	jmp    1a0 <strchr+0x30>
 189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 190:	38 ca                	cmp    %cl,%dl
 192:	74 0c                	je     1a0 <strchr+0x30>
  for(; *s; s++)
 194:	83 c0 01             	add    $0x1,%eax
 197:	0f b6 10             	movzbl (%eax),%edx
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strchr+0x20>
      return (char*)s;
  return 0;
 19e:	31 c0                	xor    %eax,%eax
}
 1a0:	5b                   	pop    %ebx
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    
 1a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <gets>:

char*
gets(char *buf, int max)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1b5:	31 f6                	xor    %esi,%esi
{
 1b7:	53                   	push   %ebx
 1b8:	83 ec 2c             	sub    $0x2c,%esp
    cc = read(0, &c, 1);
 1bb:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1be:	eb 31                	jmp    1f1 <gets+0x41>
    cc = read(0, &c, 1);
 1c0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 1c7:	00 
 1c8:	89 7c 24 04          	mov    %edi,0x4(%esp)
 1cc:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 1d3:	e8 02 01 00 00       	call   2da <read>
    if(cc < 1)
 1d8:	85 c0                	test   %eax,%eax
 1da:	7e 1d                	jle    1f9 <gets+0x49>
      break;
    buf[i++] = c;
 1dc:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
  for(i=0; i+1 < max; ){
 1e0:	89 de                	mov    %ebx,%esi
    buf[i++] = c;
 1e2:	8b 55 08             	mov    0x8(%ebp),%edx
    if(c == '\n' || c == '\r')
 1e5:	3c 0d                	cmp    $0xd,%al
    buf[i++] = c;
 1e7:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 1eb:	74 0c                	je     1f9 <gets+0x49>
 1ed:	3c 0a                	cmp    $0xa,%al
 1ef:	74 08                	je     1f9 <gets+0x49>
  for(i=0; i+1 < max; ){
 1f1:	8d 5e 01             	lea    0x1(%esi),%ebx
 1f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1f7:	7c c7                	jl     1c0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 200:	83 c4 2c             	add    $0x2c,%esp
 203:	5b                   	pop    %ebx
 204:	5e                   	pop    %esi
 205:	5f                   	pop    %edi
 206:	5d                   	pop    %ebp
 207:	c3                   	ret    
 208:	90                   	nop
 209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	56                   	push   %esi
 214:	53                   	push   %ebx
 215:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 218:	8b 45 08             	mov    0x8(%ebp),%eax
 21b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 222:	00 
 223:	89 04 24             	mov    %eax,(%esp)
 226:	e8 d7 00 00 00       	call   302 <open>
  if(fd < 0)
 22b:	85 c0                	test   %eax,%eax
  fd = open(n, O_RDONLY);
 22d:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 22f:	78 27                	js     258 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 231:	8b 45 0c             	mov    0xc(%ebp),%eax
 234:	89 1c 24             	mov    %ebx,(%esp)
 237:	89 44 24 04          	mov    %eax,0x4(%esp)
 23b:	e8 da 00 00 00       	call   31a <fstat>
  close(fd);
 240:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 243:	89 c6                	mov    %eax,%esi
  close(fd);
 245:	e8 a0 00 00 00       	call   2ea <close>
  return r;
 24a:	89 f0                	mov    %esi,%eax
}
 24c:	83 c4 10             	add    $0x10,%esp
 24f:	5b                   	pop    %ebx
 250:	5e                   	pop    %esi
 251:	5d                   	pop    %ebp
 252:	c3                   	ret    
 253:	90                   	nop
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 258:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 25d:	eb ed                	jmp    24c <stat+0x3c>
 25f:	90                   	nop

00000260 <atoi>:

int
atoi(const char *s)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 4d 08             	mov    0x8(%ebp),%ecx
 266:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 267:	0f be 11             	movsbl (%ecx),%edx
 26a:	8d 42 d0             	lea    -0x30(%edx),%eax
 26d:	3c 09                	cmp    $0x9,%al
  n = 0;
 26f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 274:	77 17                	ja     28d <atoi+0x2d>
 276:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 278:	83 c1 01             	add    $0x1,%ecx
 27b:	8d 04 80             	lea    (%eax,%eax,4),%eax
 27e:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 282:	0f be 11             	movsbl (%ecx),%edx
 285:	8d 5a d0             	lea    -0x30(%edx),%ebx
 288:	80 fb 09             	cmp    $0x9,%bl
 28b:	76 eb                	jbe    278 <atoi+0x18>
  return n;
}
 28d:	5b                   	pop    %ebx
 28e:	5d                   	pop    %ebp
 28f:	c3                   	ret    

00000290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 290:	55                   	push   %ebp
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 291:	31 d2                	xor    %edx,%edx
{
 293:	89 e5                	mov    %esp,%ebp
 295:	56                   	push   %esi
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	53                   	push   %ebx
 29a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 29d:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n-- > 0)
 2a0:	85 db                	test   %ebx,%ebx
 2a2:	7e 12                	jle    2b6 <memmove+0x26>
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2b2:	39 da                	cmp    %ebx,%edx
 2b4:	75 f2                	jne    2a8 <memmove+0x18>
  return vdst;
}
 2b6:	5b                   	pop    %ebx
 2b7:	5e                   	pop    %esi
 2b8:	5d                   	pop    %ebp
 2b9:	c3                   	ret    

000002ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ba:	b8 01 00 00 00       	mov    $0x1,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <exit>:
SYSCALL(exit)
 2c2:	b8 02 00 00 00       	mov    $0x2,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <wait>:
SYSCALL(wait)
 2ca:	b8 03 00 00 00       	mov    $0x3,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <pipe>:
SYSCALL(pipe)
 2d2:	b8 04 00 00 00       	mov    $0x4,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <read>:
SYSCALL(read)
 2da:	b8 05 00 00 00       	mov    $0x5,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <write>:
SYSCALL(write)
 2e2:	b8 10 00 00 00       	mov    $0x10,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <close>:
SYSCALL(close)
 2ea:	b8 15 00 00 00       	mov    $0x15,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <kill>:
SYSCALL(kill)
 2f2:	b8 06 00 00 00       	mov    $0x6,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <exec>:
SYSCALL(exec)
 2fa:	b8 07 00 00 00       	mov    $0x7,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <open>:
SYSCALL(open)
 302:	b8 0f 00 00 00       	mov    $0xf,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mknod>:
SYSCALL(mknod)
 30a:	b8 11 00 00 00       	mov    $0x11,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <unlink>:
SYSCALL(unlink)
 312:	b8 12 00 00 00       	mov    $0x12,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <fstat>:
SYSCALL(fstat)
 31a:	b8 08 00 00 00       	mov    $0x8,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <link>:
SYSCALL(link)
 322:	b8 13 00 00 00       	mov    $0x13,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <mkdir>:
SYSCALL(mkdir)
 32a:	b8 14 00 00 00       	mov    $0x14,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <chdir>:
SYSCALL(chdir)
 332:	b8 09 00 00 00       	mov    $0x9,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <dup>:
SYSCALL(dup)
 33a:	b8 0a 00 00 00       	mov    $0xa,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <getpid>:
SYSCALL(getpid)
 342:	b8 0b 00 00 00       	mov    $0xb,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <sbrk>:
SYSCALL(sbrk)
 34a:	b8 0c 00 00 00       	mov    $0xc,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <sleep>:
SYSCALL(sleep)
 352:	b8 0d 00 00 00       	mov    $0xd,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <uptime>:
SYSCALL(uptime)
 35a:	b8 0e 00 00 00       	mov    $0xe,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <getppid>:
#ifdef GETPPID
SYSCALL(getppid)
 362:	b8 16 00 00 00       	mov    $0x16,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <cps>:
#endif // GETPPID
#ifdef CPS
SYSCALL(cps)
 36a:	b8 17 00 00 00       	mov    $0x17,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kdebug>:
#endif // CPS

SYSCALL(kdebug)
 372:	b8 18 00 00 00       	mov    $0x18,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <halt>:
SYSCALL(halt)
 37a:	b8 19 00 00 00       	mov    $0x19,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <kthread_create>:

#ifdef KTHREADS
SYSCALL(kthread_create)
 382:	b8 1a 00 00 00       	mov    $0x1a,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <kthread_join>:
SYSCALL(kthread_join)
 38a:	b8 1b 00 00 00       	mov    $0x1b,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <kthread_exit>:
SYSCALL(kthread_exit)
 392:	b8 1c 00 00 00       	mov    $0x1c,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    
 39a:	66 90                	xchg   %ax,%ax
 39c:	66 90                	xchg   %ax,%ax
 39e:	66 90                	xchg   %ax,%ax

000003a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	89 c6                	mov    %eax,%esi
 3a7:	53                   	push   %ebx
 3a8:	83 ec 4c             	sub    $0x4c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	74 09                	je     3bb <printint+0x1b>
 3b2:	89 d0                	mov    %edx,%eax
 3b4:	c1 e8 1f             	shr    $0x1f,%eax
 3b7:	84 c0                	test   %al,%al
 3b9:	75 75                	jne    430 <printint+0x90>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 3bb:	89 d0                	mov    %edx,%eax
  neg = 0;
 3bd:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 3c4:	89 75 c0             	mov    %esi,-0x40(%ebp)
  }

  i = 0;
 3c7:	31 ff                	xor    %edi,%edi
 3c9:	89 ce                	mov    %ecx,%esi
 3cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3ce:	eb 02                	jmp    3d2 <printint+0x32>
  do{
    buf[i++] = digits[x % base];
 3d0:	89 cf                	mov    %ecx,%edi
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	f7 f6                	div    %esi
 3d6:	8d 4f 01             	lea    0x1(%edi),%ecx
 3d9:	0f b6 92 16 09 00 00 	movzbl 0x916(%edx),%edx
  }while((x /= base) != 0);
 3e0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3e2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 3e5:	75 e9                	jne    3d0 <printint+0x30>
  if(neg)
 3e7:	8b 55 c4             	mov    -0x3c(%ebp),%edx
    buf[i++] = digits[x % base];
 3ea:	89 c8                	mov    %ecx,%eax
 3ec:	8b 75 c0             	mov    -0x40(%ebp),%esi
  if(neg)
 3ef:	85 d2                	test   %edx,%edx
 3f1:	74 08                	je     3fb <printint+0x5b>
    buf[i++] = '-';
 3f3:	8d 4f 02             	lea    0x2(%edi),%ecx
 3f6:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 3fb:	8d 79 ff             	lea    -0x1(%ecx),%edi
 3fe:	66 90                	xchg   %ax,%ax
 400:	0f b6 44 3d d8       	movzbl -0x28(%ebp,%edi,1),%eax
 405:	83 ef 01             	sub    $0x1,%edi
  write(fd, &c, 1);
 408:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 40f:	00 
 410:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 414:	89 34 24             	mov    %esi,(%esp)
 417:	88 45 d7             	mov    %al,-0x29(%ebp)
 41a:	e8 c3 fe ff ff       	call   2e2 <write>
  while(--i >= 0)
 41f:	83 ff ff             	cmp    $0xffffffff,%edi
 422:	75 dc                	jne    400 <printint+0x60>
    putc(fd, buf[i]);
}
 424:	83 c4 4c             	add    $0x4c,%esp
 427:	5b                   	pop    %ebx
 428:	5e                   	pop    %esi
 429:	5f                   	pop    %edi
 42a:	5d                   	pop    %ebp
 42b:	c3                   	ret    
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
 430:	89 d0                	mov    %edx,%eax
 432:	f7 d8                	neg    %eax
    neg = 1;
 434:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
 43b:	eb 87                	jmp    3c4 <printint+0x24>
 43d:	8d 76 00             	lea    0x0(%esi),%esi

00000440 <printf>:
// knows nothing about the non-integral types (float/double).
// Also missing is octal.
// RJC
void
printf(int fd, const char *fmt, ...)
{
 440:	55                   	push   %ebp
 441:	89 e5                	mov    %esp,%ebp
 443:	57                   	push   %edi
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 444:	31 ff                	xor    %edi,%edi
{
 446:	56                   	push   %esi
 447:	53                   	push   %ebx
 448:	83 ec 3c             	sub    $0x3c,%esp
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 44b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  ap = (uint*)(void*)&fmt + 1;
 44e:	8d 45 10             	lea    0x10(%ebp),%eax
{
 451:	8b 75 08             	mov    0x8(%ebp),%esi
  ap = (uint*)(void*)&fmt + 1;
 454:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(i = 0; fmt[i]; i++){
 457:	0f b6 13             	movzbl (%ebx),%edx
 45a:	83 c3 01             	add    $0x1,%ebx
 45d:	84 d2                	test   %dl,%dl
 45f:	75 39                	jne    49a <printf+0x5a>
 461:	e9 ca 00 00 00       	jmp    530 <printf+0xf0>
 466:	66 90                	xchg   %ax,%ax
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 468:	83 fa 25             	cmp    $0x25,%edx
 46b:	0f 84 c7 00 00 00    	je     538 <printf+0xf8>
  write(fd, &c, 1);
 471:	8d 45 e0             	lea    -0x20(%ebp),%eax
 474:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47b:	00 
 47c:	89 44 24 04          	mov    %eax,0x4(%esp)
 480:	89 34 24             	mov    %esi,(%esp)
        state = '%';
      } else {
        putc(fd, c);
 483:	88 55 e0             	mov    %dl,-0x20(%ebp)
  write(fd, &c, 1);
 486:	e8 57 fe ff ff       	call   2e2 <write>
 48b:	83 c3 01             	add    $0x1,%ebx
  for(i = 0; fmt[i]; i++){
 48e:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 492:	84 d2                	test   %dl,%dl
 494:	0f 84 96 00 00 00    	je     530 <printf+0xf0>
    if(state == 0){
 49a:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 49c:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 49f:	74 c7                	je     468 <printf+0x28>
      }
    } else if(state == '%'){
 4a1:	83 ff 25             	cmp    $0x25,%edi
 4a4:	75 e5                	jne    48b <printf+0x4b>
      if(c == 'd' || c == 'u'){
 4a6:	83 fa 75             	cmp    $0x75,%edx
 4a9:	0f 84 99 00 00 00    	je     548 <printf+0x108>
 4af:	83 fa 64             	cmp    $0x64,%edx
 4b2:	0f 84 90 00 00 00    	je     548 <printf+0x108>
          // added unsigned - RJC
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4b8:	25 f7 00 00 00       	and    $0xf7,%eax
 4bd:	83 f8 70             	cmp    $0x70,%eax
 4c0:	0f 84 aa 00 00 00    	je     570 <printf+0x130>
          // Add the 0x in front of the value displayed. - RJC
          putc(fd, '0');
          putc(fd, 'x');
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4c6:	83 fa 73             	cmp    $0x73,%edx
 4c9:	0f 84 e9 00 00 00    	je     5b8 <printf+0x178>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4cf:	83 fa 63             	cmp    $0x63,%edx
 4d2:	0f 84 2b 01 00 00    	je     603 <printf+0x1c3>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4d8:	83 fa 25             	cmp    $0x25,%edx
 4db:	0f 84 4f 01 00 00    	je     630 <printf+0x1f0>
  write(fd, &c, 1);
 4e1:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4e4:	83 c3 01             	add    $0x1,%ebx
 4e7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4ee:	00 
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4ef:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4f1:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f5:	89 34 24             	mov    %esi,(%esp)
 4f8:	89 55 d0             	mov    %edx,-0x30(%ebp)
 4fb:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
 4ff:	e8 de fd ff ff       	call   2e2 <write>
        putc(fd, c);
 504:	8b 55 d0             	mov    -0x30(%ebp),%edx
  write(fd, &c, 1);
 507:	8d 45 e7             	lea    -0x19(%ebp),%eax
 50a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 511:	00 
 512:	89 44 24 04          	mov    %eax,0x4(%esp)
 516:	89 34 24             	mov    %esi,(%esp)
        putc(fd, c);
 519:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 51c:	e8 c1 fd ff ff       	call   2e2 <write>
  for(i = 0; fmt[i]; i++){
 521:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 525:	84 d2                	test   %dl,%dl
 527:	0f 85 6d ff ff ff    	jne    49a <printf+0x5a>
 52d:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }
}
 530:	83 c4 3c             	add    $0x3c,%esp
 533:	5b                   	pop    %ebx
 534:	5e                   	pop    %esi
 535:	5f                   	pop    %edi
 536:	5d                   	pop    %ebp
 537:	c3                   	ret    
        state = '%';
 538:	bf 25 00 00 00       	mov    $0x25,%edi
 53d:	e9 49 ff ff ff       	jmp    48b <printf+0x4b>
 542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 548:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 54f:	b9 0a 00 00 00       	mov    $0xa,%ecx
        printint(fd, *ap, 16, 0);
 554:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 557:	31 ff                	xor    %edi,%edi
        printint(fd, *ap, 16, 0);
 559:	8b 10                	mov    (%eax),%edx
 55b:	89 f0                	mov    %esi,%eax
 55d:	e8 3e fe ff ff       	call   3a0 <printint>
        ap++;
 562:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 566:	e9 20 ff ff ff       	jmp    48b <printf+0x4b>
 56b:	90                   	nop
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  write(fd, &c, 1);
 570:	8d 45 e1             	lea    -0x1f(%ebp),%eax
 573:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 57a:	00 
 57b:	89 44 24 04          	mov    %eax,0x4(%esp)
 57f:	89 34 24             	mov    %esi,(%esp)
 582:	c6 45 e1 30          	movb   $0x30,-0x1f(%ebp)
 586:	e8 57 fd ff ff       	call   2e2 <write>
 58b:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 58e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 595:	00 
 596:	89 44 24 04          	mov    %eax,0x4(%esp)
 59a:	89 34 24             	mov    %esi,(%esp)
 59d:	c6 45 e2 78          	movb   $0x78,-0x1e(%ebp)
 5a1:	e8 3c fd ff ff       	call   2e2 <write>
        printint(fd, *ap, 16, 0);
 5a6:	b9 10 00 00 00       	mov    $0x10,%ecx
 5ab:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5b2:	eb a0                	jmp    554 <printf+0x114>
 5b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
        ap++;
 5bb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        s = (char*)*ap;
 5bf:	8b 38                	mov    (%eax),%edi
          s = "(null)";
 5c1:	b8 0f 09 00 00       	mov    $0x90f,%eax
 5c6:	85 ff                	test   %edi,%edi
 5c8:	0f 44 f8             	cmove  %eax,%edi
        while(*s != 0){
 5cb:	0f b6 07             	movzbl (%edi),%eax
 5ce:	84 c0                	test   %al,%al
 5d0:	74 2a                	je     5fc <printf+0x1bc>
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 5d8:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 5db:	8d 45 e3             	lea    -0x1d(%ebp),%eax
          s++;
 5de:	83 c7 01             	add    $0x1,%edi
  write(fd, &c, 1);
 5e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 5e8:	00 
 5e9:	89 44 24 04          	mov    %eax,0x4(%esp)
 5ed:	89 34 24             	mov    %esi,(%esp)
 5f0:	e8 ed fc ff ff       	call   2e2 <write>
        while(*s != 0){
 5f5:	0f b6 07             	movzbl (%edi),%eax
 5f8:	84 c0                	test   %al,%al
 5fa:	75 dc                	jne    5d8 <printf+0x198>
      state = 0;
 5fc:	31 ff                	xor    %edi,%edi
 5fe:	e9 88 fe ff ff       	jmp    48b <printf+0x4b>
        putc(fd, *ap);
 603:	8b 45 d4             	mov    -0x2c(%ebp),%eax
      state = 0;
 606:	31 ff                	xor    %edi,%edi
        putc(fd, *ap);
 608:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 60a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 611:	00 
 612:	89 34 24             	mov    %esi,(%esp)
        putc(fd, *ap);
 615:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 618:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 61b:	89 44 24 04          	mov    %eax,0x4(%esp)
 61f:	e8 be fc ff ff       	call   2e2 <write>
        ap++;
 624:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
 628:	e9 5e fe ff ff       	jmp    48b <printf+0x4b>
 62d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 630:	8d 45 e5             	lea    -0x1b(%ebp),%eax
      state = 0;
 633:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 635:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 63c:	00 
 63d:	89 44 24 04          	mov    %eax,0x4(%esp)
 641:	89 34 24             	mov    %esi,(%esp)
 644:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
 648:	e8 95 fc ff ff       	call   2e2 <write>
 64d:	e9 39 fe ff ff       	jmp    48b <printf+0x4b>
 652:	66 90                	xchg   %ax,%ax
 654:	66 90                	xchg   %ax,%ax
 656:	66 90                	xchg   %ax,%ax
 658:	66 90                	xchg   %ax,%ax
 65a:	66 90                	xchg   %ax,%ax
 65c:	66 90                	xchg   %ax,%ax
 65e:	66 90                	xchg   %ax,%ax

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 4c 0c 00 00       	mov    0xc4c,%eax
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66e:	8b 08                	mov    (%eax),%ecx
  bp = (Header*)ap - 1;
 670:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 673:	39 d0                	cmp    %edx,%eax
 675:	72 11                	jb     688 <free+0x28>
 677:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	39 c8                	cmp    %ecx,%eax
 67a:	72 04                	jb     680 <free+0x20>
 67c:	39 ca                	cmp    %ecx,%edx
 67e:	72 10                	jb     690 <free+0x30>
 680:	89 c8                	mov    %ecx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 682:	39 d0                	cmp    %edx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 684:	8b 08                	mov    (%eax),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 686:	73 f0                	jae    678 <free+0x18>
 688:	39 ca                	cmp    %ecx,%edx
 68a:	72 04                	jb     690 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 68c:	39 c8                	cmp    %ecx,%eax
 68e:	72 f0                	jb     680 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 690:	8b 73 fc             	mov    -0x4(%ebx),%esi
 693:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 696:	39 cf                	cmp    %ecx,%edi
 698:	74 1e                	je     6b8 <free+0x58>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 69a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 69d:	8b 48 04             	mov    0x4(%eax),%ecx
 6a0:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6a3:	39 f2                	cmp    %esi,%edx
 6a5:	74 28                	je     6cf <free+0x6f>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6a7:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a9:	a3 4c 0c 00 00       	mov    %eax,0xc4c
}
 6ae:	5b                   	pop    %ebx
 6af:	5e                   	pop    %esi
 6b0:	5f                   	pop    %edi
 6b1:	5d                   	pop    %ebp
 6b2:	c3                   	ret    
 6b3:	90                   	nop
 6b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6b8:	03 71 04             	add    0x4(%ecx),%esi
 6bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6be:	8b 08                	mov    (%eax),%ecx
 6c0:	8b 09                	mov    (%ecx),%ecx
 6c2:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6c5:	8b 48 04             	mov    0x4(%eax),%ecx
 6c8:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 6cb:	39 f2                	cmp    %esi,%edx
 6cd:	75 d8                	jne    6a7 <free+0x47>
    p->s.size += bp->s.size;
 6cf:	03 4b fc             	add    -0x4(%ebx),%ecx
  freep = p;
 6d2:	a3 4c 0c 00 00       	mov    %eax,0xc4c
    p->s.size += bp->s.size;
 6d7:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6da:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6dd:	89 10                	mov    %edx,(%eax)
}
 6df:	5b                   	pop    %ebx
 6e0:	5e                   	pop    %esi
 6e1:	5f                   	pop    %edi
 6e2:	5d                   	pop    %ebp
 6e3:	c3                   	ret    
 6e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 1d 4c 0c 00 00    	mov    0xc4c,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	8d 48 07             	lea    0x7(%eax),%ecx
 705:	c1 e9 03             	shr    $0x3,%ecx
  if((prevp = freep) == 0){
 708:	85 db                	test   %ebx,%ebx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 70a:	8d 71 01             	lea    0x1(%ecx),%esi
  if((prevp = freep) == 0){
 70d:	0f 84 9b 00 00 00    	je     7ae <malloc+0xbe>
 713:	8b 13                	mov    (%ebx),%edx
 715:	8b 7a 04             	mov    0x4(%edx),%edi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 718:	39 fe                	cmp    %edi,%esi
 71a:	76 64                	jbe    780 <malloc+0x90>
 71c:	8d 04 f5 00 00 00 00 	lea    0x0(,%esi,8),%eax
  if(nu < 4096)
 723:	bb 00 80 00 00       	mov    $0x8000,%ebx
 728:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 72b:	eb 0e                	jmp    73b <malloc+0x4b>
 72d:	8d 76 00             	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 730:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 732:	8b 78 04             	mov    0x4(%eax),%edi
 735:	39 fe                	cmp    %edi,%esi
 737:	76 4f                	jbe    788 <malloc+0x98>
 739:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 73b:	3b 15 4c 0c 00 00    	cmp    0xc4c,%edx
 741:	75 ed                	jne    730 <malloc+0x40>
  if(nu < 4096)
 743:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 746:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 74c:	bf 00 10 00 00       	mov    $0x1000,%edi
 751:	0f 43 fe             	cmovae %esi,%edi
 754:	0f 42 c3             	cmovb  %ebx,%eax
  p = sbrk(nu * sizeof(Header));
 757:	89 04 24             	mov    %eax,(%esp)
 75a:	e8 eb fb ff ff       	call   34a <sbrk>
  if(p == (char*)-1)
 75f:	83 f8 ff             	cmp    $0xffffffff,%eax
 762:	74 18                	je     77c <malloc+0x8c>
  hp->s.size = nu;
 764:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 767:	83 c0 08             	add    $0x8,%eax
 76a:	89 04 24             	mov    %eax,(%esp)
 76d:	e8 ee fe ff ff       	call   660 <free>
  return freep;
 772:	8b 15 4c 0c 00 00    	mov    0xc4c,%edx
      if((p = morecore(nunits)) == 0)
 778:	85 d2                	test   %edx,%edx
 77a:	75 b4                	jne    730 <malloc+0x40>
        return 0;
 77c:	31 c0                	xor    %eax,%eax
 77e:	eb 20                	jmp    7a0 <malloc+0xb0>
    if(p->s.size >= nunits){
 780:	89 d0                	mov    %edx,%eax
 782:	89 da                	mov    %ebx,%edx
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 788:	39 fe                	cmp    %edi,%esi
 78a:	74 1c                	je     7a8 <malloc+0xb8>
        p->s.size -= nunits;
 78c:	29 f7                	sub    %esi,%edi
 78e:	89 78 04             	mov    %edi,0x4(%eax)
        p += p->s.size;
 791:	8d 04 f8             	lea    (%eax,%edi,8),%eax
        p->s.size = nunits;
 794:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 797:	89 15 4c 0c 00 00    	mov    %edx,0xc4c
      return (void*)(p + 1);
 79d:	83 c0 08             	add    $0x8,%eax
  }
}
 7a0:	83 c4 1c             	add    $0x1c,%esp
 7a3:	5b                   	pop    %ebx
 7a4:	5e                   	pop    %esi
 7a5:	5f                   	pop    %edi
 7a6:	5d                   	pop    %ebp
 7a7:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 7a8:	8b 08                	mov    (%eax),%ecx
 7aa:	89 0a                	mov    %ecx,(%edx)
 7ac:	eb e9                	jmp    797 <malloc+0xa7>
    base.s.ptr = freep = prevp = &base;
 7ae:	c7 05 4c 0c 00 00 50 	movl   $0xc50,0xc4c
 7b5:	0c 00 00 
    base.s.size = 0;
 7b8:	ba 50 0c 00 00       	mov    $0xc50,%edx
    base.s.ptr = freep = prevp = &base;
 7bd:	c7 05 50 0c 00 00 50 	movl   $0xc50,0xc50
 7c4:	0c 00 00 
    base.s.size = 0;
 7c7:	c7 05 54 0c 00 00 00 	movl   $0x0,0xc54
 7ce:	00 00 00 
 7d1:	e9 46 ff ff ff       	jmp    71c <malloc+0x2c>
 7d6:	66 90                	xchg   %ax,%ax
 7d8:	66 90                	xchg   %ax,%ax
 7da:	66 90                	xchg   %ax,%ax
 7dc:	66 90                	xchg   %ax,%ax
 7de:	66 90                	xchg   %ax,%ax

000007e0 <benny_thread_create>:
extern int kthread_join(benny_thread_t);
extern void kthread_exit(int);

int
benny_thread_create(benny_thread_t *vbt, void (*func)(void*), void *arg_ptr)
{
 7e0:	55                   	push   %ebp
 7e1:	89 e5                	mov    %esp,%ebp
 7e3:	53                   	push   %ebx
 7e4:	83 ec 24             	sub    $0x24,%esp
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 7e7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
 7ee:	e8 fd fe ff ff       	call   6f0 <malloc>
    void *tstack = NULL;

    bt->tstack = tstack = malloc(PGSIZE * 2);
 7f3:	c7 04 24 00 20 00 00 	movl   $0x2000,(%esp)
    struct benny_thread_s *bt = malloc(sizeof(struct benny_thread_s));
 7fa:	89 c3                	mov    %eax,%ebx
    bt->tstack = tstack = malloc(PGSIZE * 2);
 7fc:	e8 ef fe ff ff       	call   6f0 <malloc>
    if (tstack == NULL) {
 801:	85 c0                	test   %eax,%eax
    bt->tstack = tstack = malloc(PGSIZE * 2);
 803:	89 c2                	mov    %eax,%edx
 805:	89 43 04             	mov    %eax,0x4(%ebx)
    if (tstack == NULL) {
 808:	0f 84 8a 00 00 00    	je     898 <benny_thread_create+0xb8>
        return -1;
    }
    if (((uint) tstack) % PGSIZE != 0) {
 80e:	25 ff 0f 00 00       	and    $0xfff,%eax
 813:	75 73                	jne    888 <benny_thread_create+0xa8>
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
    }
    bt->tid = kthread_create(func, arg_ptr, tstack);
 815:	8b 45 10             	mov    0x10(%ebp),%eax
 818:	89 54 24 08          	mov    %edx,0x8(%esp)
 81c:	89 44 24 04          	mov    %eax,0x4(%esp)
 820:	8b 45 0c             	mov    0xc(%ebp),%eax
 823:	89 04 24             	mov    %eax,(%esp)
 826:	e8 57 fb ff ff       	call   382 <kthread_create>
 82b:	89 03                	mov    %eax,(%ebx)
    printf(1, "\n%s %d: new thread %d\n", __FILE__, __LINE__, bt->tid);
 82d:	89 44 24 10          	mov    %eax,0x10(%esp)
 831:	c7 44 24 0c 25 00 00 	movl   $0x25,0xc(%esp)
 838:	00 
 839:	c7 44 24 08 27 09 00 	movl   $0x927,0x8(%esp)
 840:	00 
 841:	c7 44 24 04 36 09 00 	movl   $0x936,0x4(%esp)
 848:	00 
 849:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 850:	e8 eb fb ff ff       	call   440 <printf>
    printf(1,"tid:: %u\n",bt->tid);
 855:	8b 03                	mov    (%ebx),%eax
 857:	c7 44 24 04 4d 09 00 	movl   $0x94d,0x4(%esp)
 85e:	00 
 85f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 866:	89 44 24 08          	mov    %eax,0x8(%esp)
 86a:	e8 d1 fb ff ff       	call   440 <printf>
    
    if (bt->tid != 0) {
 86f:	8b 03                	mov    (%ebx),%eax
 871:	85 c0                	test   %eax,%eax
 873:	74 23                	je     898 <benny_thread_create+0xb8>
        *vbt = (benny_thread_t) bt;
 875:	8b 45 08             	mov    0x8(%ebp),%eax
 878:	89 18                	mov    %ebx,(%eax)
        return 0;
 87a:	31 c0                	xor    %eax,%eax
    }
    return -1;
}
 87c:	83 c4 24             	add    $0x24,%esp
 87f:	5b                   	pop    %ebx
 880:	5d                   	pop    %ebp
 881:	c3                   	ret    
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        tstack += (PGSIZE - ((uint) tstack) % PGSIZE);
 888:	29 c2                	sub    %eax,%edx
 88a:	81 c2 00 10 00 00    	add    $0x1000,%edx
 890:	eb 83                	jmp    815 <benny_thread_create+0x35>
 892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        return -1;
 898:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 89d:	eb dd                	jmp    87c <benny_thread_create+0x9c>
 89f:	90                   	nop

000008a0 <benny_thread_tid>:

int
benny_thread_tid(benny_thread_t vbt)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;

    return bt->tid;
 8a3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 8a6:	5d                   	pop    %ebp
    return bt->tid;
 8a7:	8b 00                	mov    (%eax),%eax
}
 8a9:	c3                   	ret    
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000008b0 <benny_thread_join>:

int
benny_thread_join(benny_thread_t vbt)
{
 8b0:	55                   	push   %ebp
 8b1:	89 e5                	mov    %esp,%ebp
 8b3:	53                   	push   %ebx
 8b4:	83 ec 14             	sub    $0x14,%esp
 8b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
    struct benny_thread_s *bt = (struct benny_thread_s *) vbt;
    int retVal = -1;
    
    retVal = kthread_join(bt->tid);
 8ba:	8b 03                	mov    (%ebx),%eax
 8bc:	89 04 24             	mov    %eax,(%esp)
 8bf:	e8 c6 fa ff ff       	call   38a <kthread_join>
    if (retVal == 0) {
 8c4:	85 c0                	test   %eax,%eax
 8c6:	75 11                	jne    8d9 <benny_thread_join+0x29>
        free(bt->tstack);
 8c8:	8b 53 04             	mov    0x4(%ebx),%edx
 8cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8ce:	89 14 24             	mov    %edx,(%esp)
 8d1:	e8 8a fd ff ff       	call   660 <free>
 8d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    }
    
    return retVal;
}
 8d9:	83 c4 14             	add    $0x14,%esp
 8dc:	5b                   	pop    %ebx
 8dd:	5d                   	pop    %ebp
 8de:	c3                   	ret    
 8df:	90                   	nop

000008e0 <benny_thread_exit>:

int
benny_thread_exit(int exitValue)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	83 ec 18             	sub    $0x18,%esp
    kthread_exit(exitValue);
 8e6:	8b 45 08             	mov    0x8(%ebp),%eax
 8e9:	89 04 24             	mov    %eax,(%esp)
 8ec:	e8 a1 fa ff ff       	call   392 <kthread_exit>
    return 0;
}
 8f1:	31 c0                	xor    %eax,%eax
 8f3:	c9                   	leave  
 8f4:	c3                   	ret    
