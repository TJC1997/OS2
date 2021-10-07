
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 20 2e 10 80       	mov    $0x80102e20,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
{
80100049:	83 ec 14             	sub    $0x14,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	c7 44 24 04 80 73 10 	movl   $0x80107380,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010005b:	e8 20 46 00 00       	call   80104680 <initlock>
  bcache.head.next = &bcache.head;
80100060:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
  bcache.head.prev = &bcache.head;
80100065:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
8010006c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006f:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
80100076:	fc 10 80 
80100079:	eb 09                	jmp    80100084 <binit+0x44>
8010007b:	90                   	nop
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 da                	mov    %ebx,%edx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100082:	89 c3                	mov    %eax,%ebx
80100084:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->next = bcache.head.next;
80100087:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008a:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 87 73 10 	movl   $0x80107387,0x4(%esp)
8010009b:	80 
8010009c:	e8 af 44 00 00       	call   80104550 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
    bcache.head.next = b;
801000b4:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ba:	75 c4                	jne    80100080 <binit+0x40>
  }
}
801000bc:	83 c4 14             	add    $0x14,%esp
801000bf:	5b                   	pop    %ebx
801000c0:	5d                   	pop    %ebp
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&bcache.lock);
801000dc:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
{
801000e3:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000e6:	e8 05 47 00 00       	call   801047f0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000f1:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100161:	e8 fa 46 00 00       	call   80104860 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 1f 44 00 00       	call   80104590 <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 d2 1f 00 00       	call   80102150 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
  panic("bget: no buffers");
80100188:	c7 04 24 8e 73 10 80 	movl   $0x8010738e,(%esp)
8010018f:	e8 cc 01 00 00       	call   80100360 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 7b 44 00 00       	call   80104630 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
  iderw(b);
801001c4:	e9 87 1f 00 00       	jmp    80102150 <iderw>
    panic("bwrite");
801001c9:	c7 04 24 9f 73 10 80 	movl   $0x8010739f,(%esp)
801001d0:	e8 8b 01 00 00       	call   80100360 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 3a 44 00 00       	call   80104630 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 5b                	je     80100255 <brelse+0x75>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 ee 43 00 00       	call   801045f0 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
80100209:	e8 e2 45 00 00       	call   801047f0 <acquire>
  b->refcnt--;
  if (b->refcnt == 0) {
8010020e:	83 6b 4c 01          	subl   $0x1,0x4c(%ebx)
80100212:	75 2f                	jne    80100243 <brelse+0x63>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100214:	8b 43 54             	mov    0x54(%ebx),%eax
80100217:	8b 53 50             	mov    0x50(%ebx),%edx
8010021a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010021d:	8b 43 50             	mov    0x50(%ebx),%eax
80100220:	8b 53 54             	mov    0x54(%ebx),%edx
80100223:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100226:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
8010022b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    b->next = bcache.head.next;
80100232:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100235:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
8010023a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010023d:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
80100243:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
8010024a:	83 c4 10             	add    $0x10,%esp
8010024d:	5b                   	pop    %ebx
8010024e:	5e                   	pop    %esi
8010024f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100250:	e9 0b 46 00 00       	jmp    80104860 <release>
    panic("brelse");
80100255:	c7 04 24 a6 73 10 80 	movl   $0x801073a6,(%esp)
8010025c:	e8 ff 00 00 00       	call   80100360 <panic>
80100261:	66 90                	xchg   %ax,%ax
80100263:	66 90                	xchg   %ax,%ax
80100265:	66 90                	xchg   %ax,%ax
80100267:	66 90                	xchg   %ax,%ax
80100269:	66 90                	xchg   %ax,%ax
8010026b:	66 90                	xchg   %ax,%ax
8010026d:	66 90                	xchg   %ax,%ax
8010026f:	90                   	nop

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 1c             	sub    $0x1c,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	89 3c 24             	mov    %edi,(%esp)
80100282:	e8 39 15 00 00       	call   801017c0 <iunlock>
  target = n;
  acquire(&cons.lock);
80100287:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028e:	e8 5d 45 00 00       	call   801047f0 <acquire>
  while(n > 0){
80100293:	8b 55 10             	mov    0x10(%ebp),%edx
80100296:	85 d2                	test   %edx,%edx
80100298:	0f 8e bc 00 00 00    	jle    8010035a <consoleread+0xea>
8010029e:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a1:	eb 25                	jmp    801002c8 <consoleread+0x58>
801002a3:	90                   	nop
801002a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(myproc()->killed){
801002a8:	e8 63 34 00 00       	call   80103710 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 74                	jne    80100328 <consoleread+0xb8>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
801002c3:	e8 f8 3d 00 00       	call   801040c0 <sleep>
    while(input.r == input.w){
801002c8:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002cd:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	8d 50 01             	lea    0x1(%eax),%edx
801002d8:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
801002de:	89 c2                	mov    %eax,%edx
801002e0:	83 e2 7f             	and    $0x7f,%edx
801002e3:	0f b6 8a 40 ff 10 80 	movzbl -0x7fef00c0(%edx),%ecx
801002ea:	0f be d1             	movsbl %cl,%edx
    if(c == C('D')){  // EOF
801002ed:	83 fa 04             	cmp    $0x4,%edx
801002f0:	74 57                	je     80100349 <consoleread+0xd9>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f2:	83 c6 01             	add    $0x1,%esi
    --n;
801002f5:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
801002f8:	83 fa 0a             	cmp    $0xa,%edx
    *dst++ = c;
801002fb:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
801002fe:	74 53                	je     80100353 <consoleread+0xe3>
  while(n > 0){
80100300:	85 db                	test   %ebx,%ebx
80100302:	75 c4                	jne    801002c8 <consoleread+0x58>
80100304:	8b 45 10             	mov    0x10(%ebp),%eax
      break;
  }
  release(&cons.lock);
80100307:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010030e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100311:	e8 4a 45 00 00       	call   80104860 <release>
  ilock(ip);
80100316:	89 3c 24             	mov    %edi,(%esp)
80100319:	e8 c2 13 00 00       	call   801016e0 <ilock>
8010031e:	8b 45 e4             	mov    -0x1c(%ebp),%eax

  return target - n;
80100321:	eb 1e                	jmp    80100341 <consoleread+0xd1>
80100323:	90                   	nop
80100324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        release(&cons.lock);
80100328:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010032f:	e8 2c 45 00 00       	call   80104860 <release>
        ilock(ip);
80100334:	89 3c 24             	mov    %edi,(%esp)
80100337:	e8 a4 13 00 00       	call   801016e0 <ilock>
        return -1;
8010033c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100341:	83 c4 1c             	add    $0x1c,%esp
80100344:	5b                   	pop    %ebx
80100345:	5e                   	pop    %esi
80100346:	5f                   	pop    %edi
80100347:	5d                   	pop    %ebp
80100348:	c3                   	ret    
      if(n < target){
80100349:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010034c:	76 05                	jbe    80100353 <consoleread+0xe3>
        input.r--;
8010034e:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100353:	8b 45 10             	mov    0x10(%ebp),%eax
80100356:	29 d8                	sub    %ebx,%eax
80100358:	eb ad                	jmp    80100307 <consoleread+0x97>
  while(n > 0){
8010035a:	31 c0                	xor    %eax,%eax
8010035c:	eb a9                	jmp    80100307 <consoleread+0x97>
8010035e:	66 90                	xchg   %ax,%ax

80100360 <panic>:
{
80100360:	55                   	push   %ebp
80100361:	89 e5                	mov    %esp,%ebp
80100363:	56                   	push   %esi
80100364:	53                   	push   %ebx
80100365:	83 ec 40             	sub    $0x40,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100368:	fa                   	cli    
  cons.locking = 0;
80100369:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100370:	00 00 00 
  getcallerpcs(&s, pcs);
80100373:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  cprintf("lapicid %d: panic: ", lapicid());
80100376:	e8 15 24 00 00       	call   80102790 <lapicid>
8010037b:	8d 75 f8             	lea    -0x8(%ebp),%esi
8010037e:	c7 04 24 ad 73 10 80 	movl   $0x801073ad,(%esp)
80100385:	89 44 24 04          	mov    %eax,0x4(%esp)
80100389:	e8 c2 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010038e:	8b 45 08             	mov    0x8(%ebp),%eax
80100391:	89 04 24             	mov    %eax,(%esp)
80100394:	e8 b7 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
80100399:	c7 04 24 e7 7d 10 80 	movl   $0x80107de7,(%esp)
801003a0:	e8 ab 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003a5:	8d 45 08             	lea    0x8(%ebp),%eax
801003a8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003ac:	89 04 24             	mov    %eax,(%esp)
801003af:	e8 ec 42 00 00       	call   801046a0 <getcallerpcs>
801003b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf(" %p", pcs[i]);
801003b8:	8b 03                	mov    (%ebx),%eax
801003ba:	83 c3 04             	add    $0x4,%ebx
801003bd:	c7 04 24 c1 73 10 80 	movl   $0x801073c1,(%esp)
801003c4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003c8:	e8 83 02 00 00       	call   80100650 <cprintf>
  for(i=0; i<10; i++)
801003cd:	39 f3                	cmp    %esi,%ebx
801003cf:	75 e7                	jne    801003b8 <panic+0x58>
  panicked = 1; // freeze other CPU
801003d1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003d8:	00 00 00 
801003db:	eb fe                	jmp    801003db <panic+0x7b>
801003dd:	8d 76 00             	lea    0x0(%esi),%esi

801003e0 <consputc>:
  if(panicked){
801003e0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003e6:	85 d2                	test   %edx,%edx
801003e8:	74 06                	je     801003f0 <consputc+0x10>
801003ea:	fa                   	cli    
801003eb:	eb fe                	jmp    801003eb <consputc+0xb>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	53                   	push   %ebx
801003f6:	89 c3                	mov    %eax,%ebx
801003f8:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
801003fb:	3d 00 01 00 00       	cmp    $0x100,%eax
80100400:	0f 84 ac 00 00 00    	je     801004b2 <consputc+0xd2>
    uartputc(c);
80100406:	89 04 24             	mov    %eax,(%esp)
80100409:	e8 e2 5a 00 00       	call   80105ef0 <uartputc>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010040e:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100413:	b8 0e 00 00 00       	mov    $0xe,%eax
80100418:	89 fa                	mov    %edi,%edx
8010041a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010041b:	be d5 03 00 00       	mov    $0x3d5,%esi
80100420:	89 f2                	mov    %esi,%edx
80100422:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100423:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100426:	89 fa                	mov    %edi,%edx
80100428:	c1 e1 08             	shl    $0x8,%ecx
8010042b:	b8 0f 00 00 00       	mov    $0xf,%eax
80100430:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100431:	89 f2                	mov    %esi,%edx
80100433:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100434:	0f b6 c0             	movzbl %al,%eax
80100437:	09 c1                	or     %eax,%ecx
  if(c == '\n')
80100439:	83 fb 0a             	cmp    $0xa,%ebx
8010043c:	0f 84 0d 01 00 00    	je     8010054f <consputc+0x16f>
  else if(c == BACKSPACE){
80100442:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100448:	0f 84 e8 00 00 00    	je     80100536 <consputc+0x156>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010044e:	0f b6 db             	movzbl %bl,%ebx
80100451:	80 cf 07             	or     $0x7,%bh
80100454:	8d 79 01             	lea    0x1(%ecx),%edi
80100457:	66 89 9c 09 00 80 0b 	mov    %bx,-0x7ff48000(%ecx,%ecx,1)
8010045e:	80 
  if(pos < 0 || pos > 25*80)
8010045f:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
80100465:	0f 87 bf 00 00 00    	ja     8010052a <consputc+0x14a>
  if((pos/80) >= 24){  // Scroll up.
8010046b:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100471:	7f 68                	jg     801004db <consputc+0xfb>
80100473:	89 f8                	mov    %edi,%eax
80100475:	89 fb                	mov    %edi,%ebx
80100477:	c1 e8 08             	shr    $0x8,%eax
8010047a:	89 c6                	mov    %eax,%esi
8010047c:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100483:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100488:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048d:	89 fa                	mov    %edi,%edx
8010048f:	ee                   	out    %al,(%dx)
80100490:	89 f0                	mov    %esi,%eax
80100492:	b2 d5                	mov    $0xd5,%dl
80100494:	ee                   	out    %al,(%dx)
80100495:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049a:	89 fa                	mov    %edi,%edx
8010049c:	ee                   	out    %al,(%dx)
8010049d:	89 d8                	mov    %ebx,%eax
8010049f:	b2 d5                	mov    $0xd5,%dl
801004a1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a2:	b8 20 07 00 00       	mov    $0x720,%eax
801004a7:	66 89 01             	mov    %ax,(%ecx)
}
801004aa:	83 c4 1c             	add    $0x1c,%esp
801004ad:	5b                   	pop    %ebx
801004ae:	5e                   	pop    %esi
801004af:	5f                   	pop    %edi
801004b0:	5d                   	pop    %ebp
801004b1:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004b2:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004b9:	e8 32 5a 00 00       	call   80105ef0 <uartputc>
801004be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004c5:	e8 26 5a 00 00       	call   80105ef0 <uartputc>
801004ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004d1:	e8 1a 5a 00 00       	call   80105ef0 <uartputc>
801004d6:	e9 33 ff ff ff       	jmp    8010040e <consputc+0x2e>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004db:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004e2:	00 
    pos -= 80;
801004e3:	8d 5f b0             	lea    -0x50(%edi),%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004e6:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004ed:	80 
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004ee:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f5:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
801004fc:	e8 4f 44 00 00       	call   80104950 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100501:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100506:	29 f8                	sub    %edi,%eax
80100508:	01 c0                	add    %eax,%eax
8010050a:	89 34 24             	mov    %esi,(%esp)
8010050d:	89 44 24 08          	mov    %eax,0x8(%esp)
80100511:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100518:	00 
80100519:	e8 92 43 00 00       	call   801048b0 <memset>
8010051e:	89 f1                	mov    %esi,%ecx
80100520:	be 07 00 00 00       	mov    $0x7,%esi
80100525:	e9 59 ff ff ff       	jmp    80100483 <consputc+0xa3>
    panic("pos under/overflow");
8010052a:	c7 04 24 c5 73 10 80 	movl   $0x801073c5,(%esp)
80100531:	e8 2a fe ff ff       	call   80100360 <panic>
    if(pos > 0) --pos;
80100536:	85 c9                	test   %ecx,%ecx
80100538:	8d 79 ff             	lea    -0x1(%ecx),%edi
8010053b:	0f 85 1e ff ff ff    	jne    8010045f <consputc+0x7f>
80100541:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
80100546:	31 db                	xor    %ebx,%ebx
80100548:	31 f6                	xor    %esi,%esi
8010054a:	e9 34 ff ff ff       	jmp    80100483 <consputc+0xa3>
    pos += 80 - pos%80;
8010054f:	89 c8                	mov    %ecx,%eax
80100551:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100556:	f7 ea                	imul   %edx
80100558:	c1 ea 05             	shr    $0x5,%edx
8010055b:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010055e:	c1 e0 04             	shl    $0x4,%eax
80100561:	8d 78 50             	lea    0x50(%eax),%edi
80100564:	e9 f6 fe ff ff       	jmp    8010045f <consputc+0x7f>
80100569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100570 <printint>:
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	89 d6                	mov    %edx,%esi
80100577:	53                   	push   %ebx
80100578:	83 ec 1c             	sub    $0x1c,%esp
  if(sign && (sign = xx < 0))
8010057b:	85 c9                	test   %ecx,%ecx
8010057d:	74 61                	je     801005e0 <printint+0x70>
8010057f:	85 c0                	test   %eax,%eax
80100581:	79 5d                	jns    801005e0 <printint+0x70>
    x = -xx;
80100583:	f7 d8                	neg    %eax
80100585:	bf 01 00 00 00       	mov    $0x1,%edi
  i = 0;
8010058a:	31 c9                	xor    %ecx,%ecx
8010058c:	eb 04                	jmp    80100592 <printint+0x22>
8010058e:	66 90                	xchg   %ax,%ax
    buf[i++] = digits[x % base];
80100590:	89 d9                	mov    %ebx,%ecx
80100592:	31 d2                	xor    %edx,%edx
80100594:	f7 f6                	div    %esi
80100596:	8d 59 01             	lea    0x1(%ecx),%ebx
80100599:	0f b6 92 f0 73 10 80 	movzbl -0x7fef8c10(%edx),%edx
  }while((x /= base) != 0);
801005a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005a2:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
801005a6:	75 e8                	jne    80100590 <printint+0x20>
  if(sign)
801005a8:	85 ff                	test   %edi,%edi
    buf[i++] = digits[x % base];
801005aa:	89 d8                	mov    %ebx,%eax
  if(sign)
801005ac:	74 08                	je     801005b6 <printint+0x46>
    buf[i++] = '-';
801005ae:	8d 59 02             	lea    0x2(%ecx),%ebx
801005b1:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)
  while(--i >= 0)
801005b6:	83 eb 01             	sub    $0x1,%ebx
801005b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
801005c0:	0f be 44 1d d8       	movsbl -0x28(%ebp,%ebx,1),%eax
  while(--i >= 0)
801005c5:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
801005c8:	e8 13 fe ff ff       	call   801003e0 <consputc>
  while(--i >= 0)
801005cd:	83 fb ff             	cmp    $0xffffffff,%ebx
801005d0:	75 ee                	jne    801005c0 <printint+0x50>
}
801005d2:	83 c4 1c             	add    $0x1c,%esp
801005d5:	5b                   	pop    %ebx
801005d6:	5e                   	pop    %esi
801005d7:	5f                   	pop    %edi
801005d8:	5d                   	pop    %ebp
801005d9:	c3                   	ret    
801005da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    x = xx;
801005e0:	31 ff                	xor    %edi,%edi
801005e2:	eb a6                	jmp    8010058a <printint+0x1a>
801005e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801005f0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
801005f9:	8b 45 08             	mov    0x8(%ebp),%eax
{
801005fc:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
801005ff:	89 04 24             	mov    %eax,(%esp)
80100602:	e8 b9 11 00 00       	call   801017c0 <iunlock>
  acquire(&cons.lock);
80100607:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010060e:	e8 dd 41 00 00       	call   801047f0 <acquire>
80100613:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100616:	85 f6                	test   %esi,%esi
80100618:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010061b:	7e 12                	jle    8010062f <consolewrite+0x3f>
8010061d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100620:	0f b6 07             	movzbl (%edi),%eax
80100623:	83 c7 01             	add    $0x1,%edi
80100626:	e8 b5 fd ff ff       	call   801003e0 <consputc>
  for(i = 0; i < n; i++)
8010062b:	39 df                	cmp    %ebx,%edi
8010062d:	75 f1                	jne    80100620 <consolewrite+0x30>
  release(&cons.lock);
8010062f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100636:	e8 25 42 00 00       	call   80104860 <release>
  ilock(ip);
8010063b:	8b 45 08             	mov    0x8(%ebp),%eax
8010063e:	89 04 24             	mov    %eax,(%esp)
80100641:	e8 9a 10 00 00       	call   801016e0 <ilock>

  return n;
}
80100646:	83 c4 1c             	add    $0x1c,%esp
80100649:	89 f0                	mov    %esi,%eax
8010064b:	5b                   	pop    %ebx
8010064c:	5e                   	pop    %esi
8010064d:	5f                   	pop    %edi
8010064e:	5d                   	pop    %ebp
8010064f:	c3                   	ret    

80100650 <cprintf>:
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100659:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010065e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100660:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100663:	0f 85 3f 01 00 00    	jne    801007a8 <cprintf+0x158>
  if (fmt == 0)
80100669:	8b 45 08             	mov    0x8(%ebp),%eax
8010066c:	85 c0                	test   %eax,%eax
8010066e:	89 c1                	mov    %eax,%ecx
80100670:	0f 84 43 01 00 00    	je     801007b9 <cprintf+0x169>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100676:	0f b6 00             	movzbl (%eax),%eax
80100679:	31 db                	xor    %ebx,%ebx
8010067b:	89 cf                	mov    %ecx,%edi
8010067d:	8d 75 0c             	lea    0xc(%ebp),%esi
80100680:	85 c0                	test   %eax,%eax
80100682:	74 7f                	je     80100703 <cprintf+0xb3>
80100684:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c != '%'){
80100688:	83 f8 25             	cmp    $0x25,%eax
8010068b:	0f 85 a7 00 00 00    	jne    80100738 <cprintf+0xe8>
    c = fmt[++i] & 0xff;
80100691:	83 c3 01             	add    $0x1,%ebx
80100694:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
80100698:	85 d2                	test   %edx,%edx
8010069a:	74 67                	je     80100703 <cprintf+0xb3>
    switch(c){
8010069c:	83 fa 70             	cmp    $0x70,%edx
8010069f:	0f 84 d3 00 00 00    	je     80100778 <cprintf+0x128>
801006a5:	0f 8e 95 00 00 00    	jle    80100740 <cprintf+0xf0>
801006ab:	83 fa 75             	cmp    $0x75,%edx
801006ae:	66 90                	xchg   %ax,%ax
801006b0:	0f 84 94 00 00 00    	je     8010074a <cprintf+0xfa>
801006b6:	83 fa 78             	cmp    $0x78,%edx
801006b9:	0f 84 b9 00 00 00    	je     80100778 <cprintf+0x128>
801006bf:	83 fa 73             	cmp    $0x73,%edx
801006c2:	75 5c                	jne    80100720 <cprintf+0xd0>
      if((s = (char*)*argp++) == 0)
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	8b 36                	mov    (%esi),%esi
801006c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
801006cc:	b8 d8 73 10 80       	mov    $0x801073d8,%eax
801006d1:	85 f6                	test   %esi,%esi
801006d3:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
801006d6:	0f be 06             	movsbl (%esi),%eax
801006d9:	84 c0                	test   %al,%al
801006db:	74 12                	je     801006ef <cprintf+0x9f>
801006dd:	8d 76 00             	lea    0x0(%esi),%esi
801006e0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801006e3:	e8 f8 fc ff ff       	call   801003e0 <consputc>
      for(; *s; s++)
801006e8:	0f be 06             	movsbl (%esi),%eax
801006eb:	84 c0                	test   %al,%al
801006ed:	75 f1                	jne    801006e0 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
801006ef:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801006f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f8:	83 c3 01             	add    $0x1,%ebx
801006fb:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006ff:	85 c0                	test   %eax,%eax
80100701:	75 85                	jne    80100688 <cprintf+0x38>
  if(locking)
80100703:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100706:	85 c0                	test   %eax,%eax
80100708:	74 0c                	je     80100716 <cprintf+0xc6>
    release(&cons.lock);
8010070a:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100711:	e8 4a 41 00 00       	call   80104860 <release>
}
80100716:	83 c4 1c             	add    $0x1c,%esp
80100719:	5b                   	pop    %ebx
8010071a:	5e                   	pop    %esi
8010071b:	5f                   	pop    %edi
8010071c:	5d                   	pop    %ebp
8010071d:	c3                   	ret    
8010071e:	66 90                	xchg   %ax,%ax
      consputc('%');
80100720:	b8 25 00 00 00       	mov    $0x25,%eax
80100725:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100728:	e8 b3 fc ff ff       	call   801003e0 <consputc>
      consputc(c);
8010072d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100730:	89 d0                	mov    %edx,%eax
80100732:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100738:	e8 a3 fc ff ff       	call   801003e0 <consputc>
      break;
8010073d:	eb b9                	jmp    801006f8 <cprintf+0xa8>
8010073f:	90                   	nop
    switch(c){
80100740:	83 fa 25             	cmp    $0x25,%edx
80100743:	74 23                	je     80100768 <cprintf+0x118>
80100745:	83 fa 64             	cmp    $0x64,%edx
80100748:	75 d6                	jne    80100720 <cprintf+0xd0>
      printint(*argp++, 10, 1);
8010074a:	8d 46 04             	lea    0x4(%esi),%eax
8010074d:	b9 01 00 00 00       	mov    $0x1,%ecx
80100752:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100755:	8b 06                	mov    (%esi),%eax
80100757:	ba 0a 00 00 00       	mov    $0xa,%edx
8010075c:	e8 0f fe ff ff       	call   80100570 <printint>
80100761:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100764:	eb 92                	jmp    801006f8 <cprintf+0xa8>
80100766:	66 90                	xchg   %ax,%ax
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 6e fc ff ff       	call   801003e0 <consputc>
      break;
80100772:	eb 84                	jmp    801006f8 <cprintf+0xa8>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('0');
80100778:	b8 30 00 00 00       	mov    $0x30,%eax
8010077d:	e8 5e fc ff ff       	call   801003e0 <consputc>
      consputc('x');
80100782:	b8 78 00 00 00       	mov    $0x78,%eax
80100787:	e8 54 fc ff ff       	call   801003e0 <consputc>
      printint(*argp++, 16, 0);
8010078c:	8d 46 04             	lea    0x4(%esi),%eax
8010078f:	31 c9                	xor    %ecx,%ecx
80100791:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100794:	8b 06                	mov    (%esi),%eax
80100796:	ba 10 00 00 00       	mov    $0x10,%edx
8010079b:	e8 d0 fd ff ff       	call   80100570 <printint>
801007a0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
801007a3:	e9 50 ff ff ff       	jmp    801006f8 <cprintf+0xa8>
    acquire(&cons.lock);
801007a8:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007af:	e8 3c 40 00 00       	call   801047f0 <acquire>
801007b4:	e9 b0 fe ff ff       	jmp    80100669 <cprintf+0x19>
    panic("null fmt");
801007b9:	c7 04 24 df 73 10 80 	movl   $0x801073df,(%esp)
801007c0:	e8 9b fb ff ff       	call   80100360 <panic>
801007c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801007c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007d0 <consoleintr>:
{
801007d0:	55                   	push   %ebp
801007d1:	89 e5                	mov    %esp,%ebp
801007d3:	57                   	push   %edi
801007d4:	56                   	push   %esi
  int c, doprocdump = 0;
801007d5:	31 f6                	xor    %esi,%esi
{
801007d7:	53                   	push   %ebx
801007d8:	83 ec 1c             	sub    $0x1c,%esp
801007db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
801007de:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007e5:	e8 06 40 00 00       	call   801047f0 <acquire>
801007ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801007f0:	ff d3                	call   *%ebx
801007f2:	85 c0                	test   %eax,%eax
801007f4:	89 c7                	mov    %eax,%edi
801007f6:	78 48                	js     80100840 <consoleintr+0x70>
    switch(c){
801007f8:	83 ff 10             	cmp    $0x10,%edi
801007fb:	0f 84 2f 01 00 00    	je     80100930 <consoleintr+0x160>
80100801:	7e 5d                	jle    80100860 <consoleintr+0x90>
80100803:	83 ff 15             	cmp    $0x15,%edi
80100806:	0f 84 d4 00 00 00    	je     801008e0 <consoleintr+0x110>
8010080c:	83 ff 7f             	cmp    $0x7f,%edi
8010080f:	90                   	nop
80100810:	75 53                	jne    80100865 <consoleintr+0x95>
      if(input.e != input.w){
80100812:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100817:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010081d:	74 d1                	je     801007f0 <consoleintr+0x20>
        input.e--;
8010081f:	83 e8 01             	sub    $0x1,%eax
80100822:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100827:	b8 00 01 00 00       	mov    $0x100,%eax
8010082c:	e8 af fb ff ff       	call   801003e0 <consputc>
  while((c = getc()) >= 0){
80100831:	ff d3                	call   *%ebx
80100833:	85 c0                	test   %eax,%eax
80100835:	89 c7                	mov    %eax,%edi
80100837:	79 bf                	jns    801007f8 <consoleintr+0x28>
80100839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100840:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100847:	e8 14 40 00 00       	call   80104860 <release>
  if(doprocdump) {
8010084c:	85 f6                	test   %esi,%esi
8010084e:	0f 85 ec 00 00 00    	jne    80100940 <consoleintr+0x170>
}
80100854:	83 c4 1c             	add    $0x1c,%esp
80100857:	5b                   	pop    %ebx
80100858:	5e                   	pop    %esi
80100859:	5f                   	pop    %edi
8010085a:	5d                   	pop    %ebp
8010085b:	c3                   	ret    
8010085c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100860:	83 ff 08             	cmp    $0x8,%edi
80100863:	74 ad                	je     80100812 <consoleintr+0x42>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100865:	85 ff                	test   %edi,%edi
80100867:	74 87                	je     801007f0 <consoleintr+0x20>
80100869:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010086e:	89 c2                	mov    %eax,%edx
80100870:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100876:	83 fa 7f             	cmp    $0x7f,%edx
80100879:	0f 87 71 ff ff ff    	ja     801007f0 <consoleintr+0x20>
        input.buf[input.e++ % INPUT_BUF] = c;
8010087f:	8d 50 01             	lea    0x1(%eax),%edx
80100882:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100885:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
80100888:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        c = (c == '\r') ? '\n' : c;
8010088e:	0f 84 b8 00 00 00    	je     8010094c <consoleintr+0x17c>
        input.buf[input.e++ % INPUT_BUF] = c;
80100894:	89 f9                	mov    %edi,%ecx
80100896:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
8010089c:	89 f8                	mov    %edi,%eax
8010089e:	e8 3d fb ff ff       	call   801003e0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008a3:	83 ff 04             	cmp    $0x4,%edi
801008a6:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801008ab:	74 19                	je     801008c6 <consoleintr+0xf6>
801008ad:	83 ff 0a             	cmp    $0xa,%edi
801008b0:	74 14                	je     801008c6 <consoleintr+0xf6>
801008b2:	8b 0d c0 ff 10 80    	mov    0x8010ffc0,%ecx
801008b8:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
801008be:	39 d0                	cmp    %edx,%eax
801008c0:	0f 85 2a ff ff ff    	jne    801007f0 <consoleintr+0x20>
          wakeup(&input.r);
801008c6:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
          input.w = input.e;
801008cd:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801008d2:	e8 89 39 00 00       	call   80104260 <wakeup>
801008d7:	e9 14 ff ff ff       	jmp    801007f0 <consoleintr+0x20>
801008dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
801008e0:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
801008e5:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801008eb:	75 2b                	jne    80100918 <consoleintr+0x148>
801008ed:	e9 fe fe ff ff       	jmp    801007f0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
801008f8:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
801008fd:	b8 00 01 00 00       	mov    $0x100,%eax
80100902:	e8 d9 fa ff ff       	call   801003e0 <consputc>
      while(input.e != input.w &&
80100907:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010090c:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100912:	0f 84 d8 fe ff ff    	je     801007f0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100918:	83 e8 01             	sub    $0x1,%eax
8010091b:	89 c2                	mov    %eax,%edx
8010091d:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100920:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
80100927:	75 cf                	jne    801008f8 <consoleintr+0x128>
80100929:	e9 c2 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010092e:	66 90                	xchg   %ax,%ax
      doprocdump = 1;
80100930:	be 01 00 00 00       	mov    $0x1,%esi
80100935:	e9 b6 fe ff ff       	jmp    801007f0 <consoleintr+0x20>
8010093a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
80100940:	83 c4 1c             	add    $0x1c,%esp
80100943:	5b                   	pop    %ebx
80100944:	5e                   	pop    %esi
80100945:	5f                   	pop    %edi
80100946:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100947:	e9 34 3b 00 00       	jmp    80104480 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
8010094c:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
80100953:	b8 0a 00 00 00       	mov    $0xa,%eax
80100958:	e8 83 fa ff ff       	call   801003e0 <consputc>
8010095d:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100962:	e9 5f ff ff ff       	jmp    801008c6 <consoleintr+0xf6>
80100967:	89 f6                	mov    %esi,%esi
80100969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100970 <consoleinit>:

void
consoleinit(void)
{
80100970:	55                   	push   %ebp
80100971:	89 e5                	mov    %esp,%ebp
80100973:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100976:	c7 44 24 04 e8 73 10 	movl   $0x801073e8,0x4(%esp)
8010097d:	80 
8010097e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100985:	e8 f6 3c 00 00       	call   80104680 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
8010098a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100991:	00 
80100992:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  devsw[CONSOLE].write = consolewrite;
80100999:	c7 05 8c 09 11 80 f0 	movl   $0x801005f0,0x8011098c
801009a0:	05 10 80 
  devsw[CONSOLE].read = consoleread;
801009a3:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009aa:	02 10 80 
  cons.locking = 1;
801009ad:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009b4:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009b7:	e8 24 19 00 00       	call   801022e0 <ioapicenable>
}
801009bc:	c9                   	leave  
801009bd:	c3                   	ret    
801009be:	66 90                	xchg   %ax,%ax

801009c0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	57                   	push   %edi
801009c4:	56                   	push   %esi
801009c5:	53                   	push   %ebx
801009c6:	81 ec 2c 01 00 00    	sub    $0x12c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009cc:	e8 3f 2d 00 00       	call   80103710 <myproc>
801009d1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009d7:	e8 64 21 00 00       	call   80102b40 <begin_op>

  if((ip = namei(path)) == 0){
801009dc:	8b 45 08             	mov    0x8(%ebp),%eax
801009df:	89 04 24             	mov    %eax,(%esp)
801009e2:	e8 49 15 00 00       	call   80101f30 <namei>
801009e7:	85 c0                	test   %eax,%eax
801009e9:	89 c3                	mov    %eax,%ebx
801009eb:	0f 84 c2 01 00 00    	je     80100bb3 <exec+0x1f3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009f1:	89 04 24             	mov    %eax,(%esp)
801009f4:	e8 e7 0c 00 00       	call   801016e0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801009f9:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
801009ff:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
80100a06:	00 
80100a07:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100a0e:	00 
80100a0f:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a13:	89 1c 24             	mov    %ebx,(%esp)
80100a16:	e8 75 0f 00 00       	call   80101990 <readi>
80100a1b:	83 f8 34             	cmp    $0x34,%eax
80100a1e:	74 20                	je     80100a40 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a20:	89 1c 24             	mov    %ebx,(%esp)
80100a23:	e8 18 0f 00 00       	call   80101940 <iunlockput>
    end_op();
80100a28:	e8 83 21 00 00       	call   80102bb0 <end_op>
  }
  return -1;
80100a2d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a32:	81 c4 2c 01 00 00    	add    $0x12c,%esp
80100a38:	5b                   	pop    %ebx
80100a39:	5e                   	pop    %esi
80100a3a:	5f                   	pop    %edi
80100a3b:	5d                   	pop    %ebp
80100a3c:	c3                   	ret    
80100a3d:	8d 76 00             	lea    0x0(%esi),%esi
  if(elf.magic != ELF_MAGIC)
80100a40:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a47:	45 4c 46 
80100a4a:	75 d4                	jne    80100a20 <exec+0x60>
  if((pgdir = setupkvm()) == 0)
80100a4c:	e8 8f 66 00 00       	call   801070e0 <setupkvm>
80100a51:	85 c0                	test   %eax,%eax
80100a53:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100a59:	74 c5                	je     80100a20 <exec+0x60>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a5b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a62:	00 
80100a63:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
  sz = 0;
80100a69:	c7 85 ec fe ff ff 00 	movl   $0x0,-0x114(%ebp)
80100a70:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a73:	0f 84 da 00 00 00    	je     80100b53 <exec+0x193>
80100a79:	31 ff                	xor    %edi,%edi
80100a7b:	eb 18                	jmp    80100a95 <exec+0xd5>
80100a7d:	8d 76 00             	lea    0x0(%esi),%esi
80100a80:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100a87:	83 c7 01             	add    $0x1,%edi
80100a8a:	83 c6 20             	add    $0x20,%esi
80100a8d:	39 f8                	cmp    %edi,%eax
80100a8f:	0f 8e be 00 00 00    	jle    80100b53 <exec+0x193>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a95:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100a9b:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100aa2:	00 
80100aa3:	89 74 24 08          	mov    %esi,0x8(%esp)
80100aa7:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aab:	89 1c 24             	mov    %ebx,(%esp)
80100aae:	e8 dd 0e 00 00       	call   80101990 <readi>
80100ab3:	83 f8 20             	cmp    $0x20,%eax
80100ab6:	0f 85 84 00 00 00    	jne    80100b40 <exec+0x180>
    if(ph.type != ELF_PROG_LOAD)
80100abc:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ac3:	75 bb                	jne    80100a80 <exec+0xc0>
    if(ph.memsz < ph.filesz)
80100ac5:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100acb:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ad1:	72 6d                	jb     80100b40 <exec+0x180>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ad3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ad9:	72 65                	jb     80100b40 <exec+0x180>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100adb:	89 44 24 08          	mov    %eax,0x8(%esp)
80100adf:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ae5:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ae9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100aef:	89 04 24             	mov    %eax,(%esp)
80100af2:	e8 59 64 00 00       	call   80106f50 <allocuvm>
80100af7:	85 c0                	test   %eax,%eax
80100af9:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100aff:	74 3f                	je     80100b40 <exec+0x180>
    if(ph.vaddr % PGSIZE != 0)
80100b01:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b07:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0c:	75 32                	jne    80100b40 <exec+0x180>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b0e:	8b 95 14 ff ff ff    	mov    -0xec(%ebp),%edx
80100b14:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b18:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b1e:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100b22:	89 54 24 10          	mov    %edx,0x10(%esp)
80100b26:	8b 95 08 ff ff ff    	mov    -0xf8(%ebp),%edx
80100b2c:	89 04 24             	mov    %eax,(%esp)
80100b2f:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b33:	e8 58 63 00 00       	call   80106e90 <loaduvm>
80100b38:	85 c0                	test   %eax,%eax
80100b3a:	0f 89 40 ff ff ff    	jns    80100a80 <exec+0xc0>
    freevm(pgdir);
80100b40:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b46:	89 04 24             	mov    %eax,(%esp)
80100b49:	e8 12 65 00 00       	call   80107060 <freevm>
80100b4e:	e9 cd fe ff ff       	jmp    80100a20 <exec+0x60>
  iunlockput(ip);
80100b53:	89 1c 24             	mov    %ebx,(%esp)
80100b56:	e8 e5 0d 00 00       	call   80101940 <iunlockput>
80100b5b:	90                   	nop
80100b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  end_op();
80100b60:	e8 4b 20 00 00       	call   80102bb0 <end_op>
  sz = PGROUNDUP(sz);
80100b65:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b6b:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b70:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b75:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b7f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b85:	89 54 24 08          	mov    %edx,0x8(%esp)
80100b89:	89 04 24             	mov    %eax,(%esp)
80100b8c:	e8 bf 63 00 00       	call   80106f50 <allocuvm>
80100b91:	85 c0                	test   %eax,%eax
80100b93:	89 85 e8 fe ff ff    	mov    %eax,-0x118(%ebp)
80100b99:	75 33                	jne    80100bce <exec+0x20e>
    freevm(pgdir);
80100b9b:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ba1:	89 04 24             	mov    %eax,(%esp)
80100ba4:	e8 b7 64 00 00       	call   80107060 <freevm>
  return -1;
80100ba9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bae:	e9 7f fe ff ff       	jmp    80100a32 <exec+0x72>
    end_op();
80100bb3:	e8 f8 1f 00 00       	call   80102bb0 <end_op>
    cprintf("exec: fail\n");
80100bb8:	c7 04 24 01 74 10 80 	movl   $0x80107401,(%esp)
80100bbf:	e8 8c fa ff ff       	call   80100650 <cprintf>
    return -1;
80100bc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc9:	e9 64 fe ff ff       	jmp    80100a32 <exec+0x72>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bce:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100bd4:	89 d8                	mov    %ebx,%eax
80100bd6:	2d 00 20 00 00       	sub    $0x2000,%eax
80100bdb:	89 44 24 04          	mov    %eax,0x4(%esp)
80100bdf:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100be5:	89 04 24             	mov    %eax,(%esp)
80100be8:	e8 a3 65 00 00       	call   80107190 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100bed:	8b 45 0c             	mov    0xc(%ebp),%eax
80100bf0:	8b 00                	mov    (%eax),%eax
80100bf2:	85 c0                	test   %eax,%eax
80100bf4:	0f 84 59 01 00 00    	je     80100d53 <exec+0x393>
80100bfa:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80100bfd:	31 d2                	xor    %edx,%edx
80100bff:	8d 71 04             	lea    0x4(%ecx),%esi
80100c02:	89 cf                	mov    %ecx,%edi
80100c04:	89 d1                	mov    %edx,%ecx
80100c06:	89 f2                	mov    %esi,%edx
80100c08:	89 fe                	mov    %edi,%esi
80100c0a:	89 cf                	mov    %ecx,%edi
80100c0c:	eb 0a                	jmp    80100c18 <exec+0x258>
80100c0e:	66 90                	xchg   %ax,%ax
80100c10:	83 c2 04             	add    $0x4,%edx
    if(argc >= MAXARG)
80100c13:	83 ff 20             	cmp    $0x20,%edi
80100c16:	74 83                	je     80100b9b <exec+0x1db>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c18:	89 04 24             	mov    %eax,(%esp)
80100c1b:	89 95 ec fe ff ff    	mov    %edx,-0x114(%ebp)
80100c21:	e8 aa 3e 00 00       	call   80104ad0 <strlen>
80100c26:	f7 d0                	not    %eax
80100c28:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c2a:	8b 06                	mov    (%esi),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c2c:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c2f:	89 04 24             	mov    %eax,(%esp)
80100c32:	e8 99 3e 00 00       	call   80104ad0 <strlen>
80100c37:	83 c0 01             	add    $0x1,%eax
80100c3a:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c3e:	8b 06                	mov    (%esi),%eax
80100c40:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c44:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c48:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c4e:	89 04 24             	mov    %eax,(%esp)
80100c51:	e8 9a 66 00 00       	call   801072f0 <copyout>
80100c56:	85 c0                	test   %eax,%eax
80100c58:	0f 88 3d ff ff ff    	js     80100b9b <exec+0x1db>
  for(argc = 0; argv[argc]; argc++) {
80100c5e:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
    ustack[3+argc] = sp;
80100c64:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100c6a:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c71:	83 c7 01             	add    $0x1,%edi
80100c74:	8b 02                	mov    (%edx),%eax
80100c76:	89 d6                	mov    %edx,%esi
80100c78:	85 c0                	test   %eax,%eax
80100c7a:	75 94                	jne    80100c10 <exec+0x250>
80100c7c:	89 fa                	mov    %edi,%edx
  ustack[3+argc] = 0;
80100c7e:	c7 84 95 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edx,4)
80100c85:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c89:	8d 04 95 04 00 00 00 	lea    0x4(,%edx,4),%eax
  ustack[1] = argc;
80100c90:	89 95 5c ff ff ff    	mov    %edx,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c96:	89 da                	mov    %ebx,%edx
80100c98:	29 c2                	sub    %eax,%edx
  sp -= (3+argc+1) * 4;
80100c9a:	83 c0 0c             	add    $0xc,%eax
80100c9d:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9f:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100ca3:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100ca9:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80100cad:	89 5c 24 04          	mov    %ebx,0x4(%esp)
  ustack[0] = 0xffffffff;  // fake return PC
80100cb1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100cb8:	ff ff ff 
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cbb:	89 04 24             	mov    %eax,(%esp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cbe:	89 95 60 ff ff ff    	mov    %edx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc4:	e8 27 66 00 00       	call   801072f0 <copyout>
80100cc9:	85 c0                	test   %eax,%eax
80100ccb:	0f 88 ca fe ff ff    	js     80100b9b <exec+0x1db>
  for(last=s=path; *s; s++)
80100cd1:	8b 45 08             	mov    0x8(%ebp),%eax
80100cd4:	0f b6 10             	movzbl (%eax),%edx
80100cd7:	84 d2                	test   %dl,%dl
80100cd9:	74 19                	je     80100cf4 <exec+0x334>
80100cdb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cde:	83 c0 01             	add    $0x1,%eax
      last = s+1;
80100ce1:	80 fa 2f             	cmp    $0x2f,%dl
  for(last=s=path; *s; s++)
80100ce4:	0f b6 10             	movzbl (%eax),%edx
      last = s+1;
80100ce7:	0f 44 c8             	cmove  %eax,%ecx
80100cea:	83 c0 01             	add    $0x1,%eax
  for(last=s=path; *s; s++)
80100ced:	84 d2                	test   %dl,%dl
80100cef:	75 f0                	jne    80100ce1 <exec+0x321>
80100cf1:	89 4d 08             	mov    %ecx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf4:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfa:	8b 45 08             	mov    0x8(%ebp),%eax
80100cfd:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100d04:	00 
80100d05:	89 44 24 04          	mov    %eax,0x4(%esp)
80100d09:	89 f8                	mov    %edi,%eax
80100d0b:	83 c0 6c             	add    $0x6c,%eax
80100d0e:	89 04 24             	mov    %eax,(%esp)
80100d11:	e8 7a 3d 00 00       	call   80104a90 <safestrcpy>
  curproc->pgdir = pgdir;
80100d16:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100d1c:	8b 77 04             	mov    0x4(%edi),%esi
  curproc->tf->eip = elf.entry;  // main
80100d1f:	8b 47 18             	mov    0x18(%edi),%eax
  curproc->pgdir = pgdir;
80100d22:	89 4f 04             	mov    %ecx,0x4(%edi)
  curproc->sz = sz;
80100d25:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100d2b:	89 0f                	mov    %ecx,(%edi)
  curproc->tf->eip = elf.entry;  // main
80100d2d:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d33:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d36:	8b 47 18             	mov    0x18(%edi),%eax
80100d39:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d3c:	89 3c 24             	mov    %edi,(%esp)
80100d3f:	e8 bc 5f 00 00       	call   80106d00 <switchuvm>
  freevm(oldpgdir);
80100d44:	89 34 24             	mov    %esi,(%esp)
80100d47:	e8 14 63 00 00       	call   80107060 <freevm>
  return 0;
80100d4c:	31 c0                	xor    %eax,%eax
80100d4e:	e9 df fc ff ff       	jmp    80100a32 <exec+0x72>
  for(argc = 0; argv[argc]; argc++) {
80100d53:	8b 9d e8 fe ff ff    	mov    -0x118(%ebp),%ebx
80100d59:	31 d2                	xor    %edx,%edx
80100d5b:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100d61:	e9 18 ff ff ff       	jmp    80100c7e <exec+0x2be>
80100d66:	66 90                	xchg   %ax,%ax
80100d68:	66 90                	xchg   %ax,%ax
80100d6a:	66 90                	xchg   %ax,%ax
80100d6c:	66 90                	xchg   %ax,%ax
80100d6e:	66 90                	xchg   %ax,%ax

80100d70 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d70:	55                   	push   %ebp
80100d71:	89 e5                	mov    %esp,%ebp
80100d73:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d76:	c7 44 24 04 0d 74 10 	movl   $0x8010740d,0x4(%esp)
80100d7d:	80 
80100d7e:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100d85:	e8 f6 38 00 00       	call   80104680 <initlock>
}
80100d8a:	c9                   	leave  
80100d8b:	c3                   	ret    
80100d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d90 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d90:	55                   	push   %ebp
80100d91:	89 e5                	mov    %esp,%ebp
80100d93:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d94:	bb 14 00 11 80       	mov    $0x80110014,%ebx
{
80100d99:	83 ec 14             	sub    $0x14,%esp
  acquire(&ftable.lock);
80100d9c:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100da3:	e8 48 3a 00 00       	call   801047f0 <acquire>
80100da8:	eb 11                	jmp    80100dbb <filealloc+0x2b>
80100daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100db0:	83 c3 18             	add    $0x18,%ebx
80100db3:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100db9:	74 25                	je     80100de0 <filealloc+0x50>
    if(f->ref == 0){
80100dbb:	8b 43 04             	mov    0x4(%ebx),%eax
80100dbe:	85 c0                	test   %eax,%eax
80100dc0:	75 ee                	jne    80100db0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100dc2:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
      f->ref = 1;
80100dc9:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dd0:	e8 8b 3a 00 00       	call   80104860 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dd5:	83 c4 14             	add    $0x14,%esp
      return f;
80100dd8:	89 d8                	mov    %ebx,%eax
}
80100dda:	5b                   	pop    %ebx
80100ddb:	5d                   	pop    %ebp
80100ddc:	c3                   	ret    
80100ddd:	8d 76 00             	lea    0x0(%esi),%esi
  release(&ftable.lock);
80100de0:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100de7:	e8 74 3a 00 00       	call   80104860 <release>
}
80100dec:	83 c4 14             	add    $0x14,%esp
  return 0;
80100def:	31 c0                	xor    %eax,%eax
}
80100df1:	5b                   	pop    %ebx
80100df2:	5d                   	pop    %ebp
80100df3:	c3                   	ret    
80100df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100e00 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100e00:	55                   	push   %ebp
80100e01:	89 e5                	mov    %esp,%ebp
80100e03:	53                   	push   %ebx
80100e04:	83 ec 14             	sub    $0x14,%esp
80100e07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100e0a:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100e11:	e8 da 39 00 00       	call   801047f0 <acquire>
  if(f->ref < 1)
80100e16:	8b 43 04             	mov    0x4(%ebx),%eax
80100e19:	85 c0                	test   %eax,%eax
80100e1b:	7e 1a                	jle    80100e37 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100e1d:	83 c0 01             	add    $0x1,%eax
80100e20:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e23:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100e2a:	e8 31 3a 00 00       	call   80104860 <release>
  return f;
}
80100e2f:	83 c4 14             	add    $0x14,%esp
80100e32:	89 d8                	mov    %ebx,%eax
80100e34:	5b                   	pop    %ebx
80100e35:	5d                   	pop    %ebp
80100e36:	c3                   	ret    
    panic("filedup");
80100e37:	c7 04 24 14 74 10 80 	movl   $0x80107414,(%esp)
80100e3e:	e8 1d f5 ff ff       	call   80100360 <panic>
80100e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e50 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e50:	55                   	push   %ebp
80100e51:	89 e5                	mov    %esp,%ebp
80100e53:	57                   	push   %edi
80100e54:	56                   	push   %esi
80100e55:	53                   	push   %ebx
80100e56:	83 ec 1c             	sub    $0x1c,%esp
80100e59:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e5c:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
80100e63:	e8 88 39 00 00       	call   801047f0 <acquire>
  if(f->ref < 1)
80100e68:	8b 57 04             	mov    0x4(%edi),%edx
80100e6b:	85 d2                	test   %edx,%edx
80100e6d:	0f 8e 89 00 00 00    	jle    80100efc <fileclose+0xac>
    panic("fileclose");
  if(--f->ref > 0){
80100e73:	83 ea 01             	sub    $0x1,%edx
80100e76:	85 d2                	test   %edx,%edx
80100e78:	89 57 04             	mov    %edx,0x4(%edi)
80100e7b:	74 13                	je     80100e90 <fileclose+0x40>
    release(&ftable.lock);
80100e7d:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e84:	83 c4 1c             	add    $0x1c,%esp
80100e87:	5b                   	pop    %ebx
80100e88:	5e                   	pop    %esi
80100e89:	5f                   	pop    %edi
80100e8a:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e8b:	e9 d0 39 00 00       	jmp    80104860 <release>
  ff = *f;
80100e90:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e94:	8b 37                	mov    (%edi),%esi
80100e96:	8b 5f 0c             	mov    0xc(%edi),%ebx
  f->type = FD_NONE;
80100e99:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
  ff = *f;
80100e9f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100ea2:	8b 47 10             	mov    0x10(%edi),%eax
  release(&ftable.lock);
80100ea5:	c7 04 24 e0 ff 10 80 	movl   $0x8010ffe0,(%esp)
  ff = *f;
80100eac:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100eaf:	e8 ac 39 00 00       	call   80104860 <release>
  if(ff.type == FD_PIPE)
80100eb4:	83 fe 01             	cmp    $0x1,%esi
80100eb7:	74 0f                	je     80100ec8 <fileclose+0x78>
  else if(ff.type == FD_INODE){
80100eb9:	83 fe 02             	cmp    $0x2,%esi
80100ebc:	74 22                	je     80100ee0 <fileclose+0x90>
}
80100ebe:	83 c4 1c             	add    $0x1c,%esp
80100ec1:	5b                   	pop    %ebx
80100ec2:	5e                   	pop    %esi
80100ec3:	5f                   	pop    %edi
80100ec4:	5d                   	pop    %ebp
80100ec5:	c3                   	ret    
80100ec6:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 75 e7          	movsbl -0x19(%ebp),%esi
80100ecc:	89 1c 24             	mov    %ebx,(%esp)
80100ecf:	89 74 24 04          	mov    %esi,0x4(%esp)
80100ed3:	e8 b8 23 00 00       	call   80103290 <pipeclose>
80100ed8:	eb e4                	jmp    80100ebe <fileclose+0x6e>
80100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    begin_op();
80100ee0:	e8 5b 1c 00 00       	call   80102b40 <begin_op>
    iput(ff.ip);
80100ee5:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100ee8:	89 04 24             	mov    %eax,(%esp)
80100eeb:	e8 10 09 00 00       	call   80101800 <iput>
}
80100ef0:	83 c4 1c             	add    $0x1c,%esp
80100ef3:	5b                   	pop    %ebx
80100ef4:	5e                   	pop    %esi
80100ef5:	5f                   	pop    %edi
80100ef6:	5d                   	pop    %ebp
    end_op();
80100ef7:	e9 b4 1c 00 00       	jmp    80102bb0 <end_op>
    panic("fileclose");
80100efc:	c7 04 24 1c 74 10 80 	movl   $0x8010741c,(%esp)
80100f03:	e8 58 f4 ff ff       	call   80100360 <panic>
80100f08:	90                   	nop
80100f09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 14             	sub    $0x14,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	8b 43 10             	mov    0x10(%ebx),%eax
80100f22:	89 04 24             	mov    %eax,(%esp)
80100f25:	e8 b6 07 00 00       	call   801016e0 <ilock>
    stati(f->ip, st);
80100f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f2d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
80100f34:	89 04 24             	mov    %eax,(%esp)
80100f37:	e8 24 0a 00 00       	call   80101960 <stati>
    iunlock(f->ip);
80100f3c:	8b 43 10             	mov    0x10(%ebx),%eax
80100f3f:	89 04 24             	mov    %eax,(%esp)
80100f42:	e8 79 08 00 00       	call   801017c0 <iunlock>
    return 0;
  }
  return -1;
}
80100f47:	83 c4 14             	add    $0x14,%esp
    return 0;
80100f4a:	31 c0                	xor    %eax,%eax
}
80100f4c:	5b                   	pop    %ebx
80100f4d:	5d                   	pop    %ebp
80100f4e:	c3                   	ret    
80100f4f:	90                   	nop
80100f50:	83 c4 14             	add    $0x14,%esp
  return -1;
80100f53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f58:	5b                   	pop    %ebx
80100f59:	5d                   	pop    %ebp
80100f5a:	c3                   	ret    
80100f5b:	90                   	nop
80100f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 1c             	sub    $0x1c,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 68                	je     80100fe0 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 49                	je     80100fc8 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 63                	jne    80100fe7 <fileread+0x87>
    ilock(f->ip);
80100f84:	8b 43 10             	mov    0x10(%ebx),%eax
80100f87:	89 04 24             	mov    %eax,(%esp)
80100f8a:	e8 51 07 00 00       	call   801016e0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f93:	8b 43 14             	mov    0x14(%ebx),%eax
80100f96:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f9a:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f9e:	8b 43 10             	mov    0x10(%ebx),%eax
80100fa1:	89 04 24             	mov    %eax,(%esp)
80100fa4:	e8 e7 09 00 00       	call   80101990 <readi>
80100fa9:	85 c0                	test   %eax,%eax
80100fab:	89 c6                	mov    %eax,%esi
80100fad:	7e 03                	jle    80100fb2 <fileread+0x52>
      f->off += r;
80100faf:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fb2:	8b 43 10             	mov    0x10(%ebx),%eax
80100fb5:	89 04 24             	mov    %eax,(%esp)
80100fb8:	e8 03 08 00 00       	call   801017c0 <iunlock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100fbd:	89 f0                	mov    %esi,%eax
    return r;
  }
  panic("fileread");
}
80100fbf:	83 c4 1c             	add    $0x1c,%esp
80100fc2:	5b                   	pop    %ebx
80100fc3:	5e                   	pop    %esi
80100fc4:	5f                   	pop    %edi
80100fc5:	5d                   	pop    %ebp
80100fc6:	c3                   	ret    
80100fc7:	90                   	nop
    return piperead(f->pipe, addr, n);
80100fc8:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fcb:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fce:	83 c4 1c             	add    $0x1c,%esp
80100fd1:	5b                   	pop    %ebx
80100fd2:	5e                   	pop    %esi
80100fd3:	5f                   	pop    %edi
80100fd4:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fd5:	e9 36 24 00 00       	jmp    80103410 <piperead>
80100fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fe0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fe5:	eb d8                	jmp    80100fbf <fileread+0x5f>
  panic("fileread");
80100fe7:	c7 04 24 26 74 10 80 	movl   $0x80107426,(%esp)
80100fee:	e8 6d f3 ff ff       	call   80100360 <panic>
80100ff3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101000 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 2c             	sub    $0x2c,%esp
80101009:	8b 45 0c             	mov    0xc(%ebp),%eax
8010100c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010100f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101012:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101015:	80 7f 09 00          	cmpb   $0x0,0x9(%edi)
{
80101019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010101c:	0f 84 ae 00 00 00    	je     801010d0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101022:	8b 07                	mov    (%edi),%eax
80101024:	83 f8 01             	cmp    $0x1,%eax
80101027:	0f 84 c2 00 00 00    	je     801010ef <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010102d:	83 f8 02             	cmp    $0x2,%eax
80101030:	0f 85 d7 00 00 00    	jne    8010110d <filewrite+0x10d>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101036:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101039:	31 db                	xor    %ebx,%ebx
8010103b:	85 c0                	test   %eax,%eax
8010103d:	7f 31                	jg     80101070 <filewrite+0x70>
8010103f:	e9 9c 00 00 00       	jmp    801010e0 <filewrite+0xe0>
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
      iunlock(f->ip);
80101048:	8b 4f 10             	mov    0x10(%edi),%ecx
        f->off += r;
8010104b:	01 47 14             	add    %eax,0x14(%edi)
8010104e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101051:	89 0c 24             	mov    %ecx,(%esp)
80101054:	e8 67 07 00 00       	call   801017c0 <iunlock>
      end_op();
80101059:	e8 52 1b 00 00       	call   80102bb0 <end_op>
8010105e:	8b 45 e0             	mov    -0x20(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101061:	39 f0                	cmp    %esi,%eax
80101063:	0f 85 98 00 00 00    	jne    80101101 <filewrite+0x101>
        panic("short filewrite");
      i += r;
80101069:	01 c3                	add    %eax,%ebx
    while(i < n){
8010106b:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010106e:	7e 70                	jle    801010e0 <filewrite+0xe0>
      int n1 = n - i;
80101070:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101073:	b8 00 06 00 00       	mov    $0x600,%eax
80101078:	29 de                	sub    %ebx,%esi
8010107a:	81 fe 00 06 00 00    	cmp    $0x600,%esi
80101080:	0f 4f f0             	cmovg  %eax,%esi
      begin_op();
80101083:	e8 b8 1a 00 00       	call   80102b40 <begin_op>
      ilock(f->ip);
80101088:	8b 47 10             	mov    0x10(%edi),%eax
8010108b:	89 04 24             	mov    %eax,(%esp)
8010108e:	e8 4d 06 00 00       	call   801016e0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101093:	89 74 24 0c          	mov    %esi,0xc(%esp)
80101097:	8b 47 14             	mov    0x14(%edi),%eax
8010109a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010109e:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010a1:	01 d8                	add    %ebx,%eax
801010a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801010a7:	8b 47 10             	mov    0x10(%edi),%eax
801010aa:	89 04 24             	mov    %eax,(%esp)
801010ad:	e8 de 09 00 00       	call   80101a90 <writei>
801010b2:	85 c0                	test   %eax,%eax
801010b4:	7f 92                	jg     80101048 <filewrite+0x48>
      iunlock(f->ip);
801010b6:	8b 4f 10             	mov    0x10(%edi),%ecx
801010b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010bc:	89 0c 24             	mov    %ecx,(%esp)
801010bf:	e8 fc 06 00 00       	call   801017c0 <iunlock>
      end_op();
801010c4:	e8 e7 1a 00 00       	call   80102bb0 <end_op>
      if(r < 0)
801010c9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010cc:	85 c0                	test   %eax,%eax
801010ce:	74 91                	je     80101061 <filewrite+0x61>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010d0:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801010d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
801010dc:	c3                   	ret    
801010dd:	8d 76 00             	lea    0x0(%esi),%esi
    return i == n ? n : -1;
801010e0:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
801010e3:	89 d8                	mov    %ebx,%eax
801010e5:	75 e9                	jne    801010d0 <filewrite+0xd0>
}
801010e7:	83 c4 2c             	add    $0x2c,%esp
801010ea:	5b                   	pop    %ebx
801010eb:	5e                   	pop    %esi
801010ec:	5f                   	pop    %edi
801010ed:	5d                   	pop    %ebp
801010ee:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
801010ef:	8b 47 0c             	mov    0xc(%edi),%eax
801010f2:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010f5:	83 c4 2c             	add    $0x2c,%esp
801010f8:	5b                   	pop    %ebx
801010f9:	5e                   	pop    %esi
801010fa:	5f                   	pop    %edi
801010fb:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010fc:	e9 1f 22 00 00       	jmp    80103320 <pipewrite>
        panic("short filewrite");
80101101:	c7 04 24 2f 74 10 80 	movl   $0x8010742f,(%esp)
80101108:	e8 53 f2 ff ff       	call   80100360 <panic>
  panic("filewrite");
8010110d:	c7 04 24 35 74 10 80 	movl   $0x80107435,(%esp)
80101114:	e8 47 f2 ff ff       	call   80100360 <panic>
80101119:	66 90                	xchg   %ax,%ax
8010111b:	66 90                	xchg   %ax,%ax
8010111d:	66 90                	xchg   %ax,%ax
8010111f:	90                   	nop

80101120 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	56                   	push   %esi
80101125:	53                   	push   %ebx
80101126:	83 ec 2c             	sub    $0x2c,%esp
80101129:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010112c:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101131:	85 c0                	test   %eax,%eax
80101133:	0f 84 8c 00 00 00    	je     801011c5 <balloc+0xa5>
80101139:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101140:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101143:	89 f0                	mov    %esi,%eax
80101145:	c1 f8 0c             	sar    $0xc,%eax
80101148:	03 05 f8 09 11 80    	add    0x801109f8,%eax
8010114e:	89 44 24 04          	mov    %eax,0x4(%esp)
80101152:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101155:	89 04 24             	mov    %eax,(%esp)
80101158:	e8 73 ef ff ff       	call   801000d0 <bread>
8010115d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101160:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101165:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101168:	31 c0                	xor    %eax,%eax
8010116a:	eb 33                	jmp    8010119f <balloc+0x7f>
8010116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101170:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101173:	89 c2                	mov    %eax,%edx
      m = 1 << (bi % 8);
80101175:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101177:	c1 fa 03             	sar    $0x3,%edx
      m = 1 << (bi % 8);
8010117a:	83 e1 07             	and    $0x7,%ecx
8010117d:	bf 01 00 00 00       	mov    $0x1,%edi
80101182:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101184:	0f b6 5c 13 5c       	movzbl 0x5c(%ebx,%edx,1),%ebx
      m = 1 << (bi % 8);
80101189:	89 f9                	mov    %edi,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010118b:	0f b6 fb             	movzbl %bl,%edi
8010118e:	85 cf                	test   %ecx,%edi
80101190:	74 46                	je     801011d8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101192:	83 c0 01             	add    $0x1,%eax
80101195:	83 c6 01             	add    $0x1,%esi
80101198:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010119d:	74 05                	je     801011a4 <balloc+0x84>
8010119f:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801011a2:	72 cc                	jb     80101170 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801011a4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801011a7:	89 04 24             	mov    %eax,(%esp)
801011aa:	e8 31 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801011af:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011b6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011b9:	3b 05 e0 09 11 80    	cmp    0x801109e0,%eax
801011bf:	0f 82 7b ff ff ff    	jb     80101140 <balloc+0x20>
  }
  panic("balloc: out of blocks");
801011c5:	c7 04 24 3f 74 10 80 	movl   $0x8010743f,(%esp)
801011cc:	e8 8f f1 ff ff       	call   80100360 <panic>
801011d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801011d8:	09 d9                	or     %ebx,%ecx
801011da:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801011dd:	88 4c 13 5c          	mov    %cl,0x5c(%ebx,%edx,1)
        log_write(bp);
801011e1:	89 1c 24             	mov    %ebx,(%esp)
801011e4:	e8 f7 1a 00 00       	call   80102ce0 <log_write>
        brelse(bp);
801011e9:	89 1c 24             	mov    %ebx,(%esp)
801011ec:	e8 ef ef ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011f1:	8b 45 d8             	mov    -0x28(%ebp),%eax
801011f4:	89 74 24 04          	mov    %esi,0x4(%esp)
801011f8:	89 04 24             	mov    %eax,(%esp)
801011fb:	e8 d0 ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101200:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80101207:	00 
80101208:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010120f:	00 
  bp = bread(dev, bno);
80101210:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101212:	8d 40 5c             	lea    0x5c(%eax),%eax
80101215:	89 04 24             	mov    %eax,(%esp)
80101218:	e8 93 36 00 00       	call   801048b0 <memset>
  log_write(bp);
8010121d:	89 1c 24             	mov    %ebx,(%esp)
80101220:	e8 bb 1a 00 00       	call   80102ce0 <log_write>
  brelse(bp);
80101225:	89 1c 24             	mov    %ebx,(%esp)
80101228:	e8 b3 ef ff ff       	call   801001e0 <brelse>
}
8010122d:	83 c4 2c             	add    $0x2c,%esp
80101230:	89 f0                	mov    %esi,%eax
80101232:	5b                   	pop    %ebx
80101233:	5e                   	pop    %esi
80101234:	5f                   	pop    %edi
80101235:	5d                   	pop    %ebp
80101236:	c3                   	ret    
80101237:	89 f6                	mov    %esi,%esi
80101239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101240 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	89 c7                	mov    %eax,%edi
80101246:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101247:	31 f6                	xor    %esi,%esi
{
80101249:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010124a:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
8010124f:	83 ec 1c             	sub    $0x1c,%esp
  acquire(&icache.lock);
80101252:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
{
80101259:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
8010125c:	e8 8f 35 00 00       	call   801047f0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101261:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101264:	eb 14                	jmp    8010127a <iget+0x3a>
80101266:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101268:	85 f6                	test   %esi,%esi
8010126a:	74 3c                	je     801012a8 <iget+0x68>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010126c:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101272:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101278:	74 46                	je     801012c0 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010127a:	8b 4b 08             	mov    0x8(%ebx),%ecx
8010127d:	85 c9                	test   %ecx,%ecx
8010127f:	7e e7                	jle    80101268 <iget+0x28>
80101281:	39 3b                	cmp    %edi,(%ebx)
80101283:	75 e3                	jne    80101268 <iget+0x28>
80101285:	39 53 04             	cmp    %edx,0x4(%ebx)
80101288:	75 de                	jne    80101268 <iget+0x28>
      ip->ref++;
8010128a:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010128d:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010128f:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
      ip->ref++;
80101296:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101299:	e8 c2 35 00 00       	call   80104860 <release>
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
8010129e:	83 c4 1c             	add    $0x1c,%esp
801012a1:	89 f0                	mov    %esi,%eax
801012a3:	5b                   	pop    %ebx
801012a4:	5e                   	pop    %esi
801012a5:	5f                   	pop    %edi
801012a6:	5d                   	pop    %ebp
801012a7:	c3                   	ret    
801012a8:	85 c9                	test   %ecx,%ecx
801012aa:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801012ad:	81 c3 90 00 00 00    	add    $0x90,%ebx
801012b3:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801012b9:	75 bf                	jne    8010127a <iget+0x3a>
801012bb:	90                   	nop
801012bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(empty == 0)
801012c0:	85 f6                	test   %esi,%esi
801012c2:	74 29                	je     801012ed <iget+0xad>
  ip->dev = dev;
801012c4:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801012c6:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801012c9:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801012d0:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801012d7:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801012de:	e8 7d 35 00 00       	call   80104860 <release>
}
801012e3:	83 c4 1c             	add    $0x1c,%esp
801012e6:	89 f0                	mov    %esi,%eax
801012e8:	5b                   	pop    %ebx
801012e9:	5e                   	pop    %esi
801012ea:	5f                   	pop    %edi
801012eb:	5d                   	pop    %ebp
801012ec:	c3                   	ret    
    panic("iget: no inodes");
801012ed:	c7 04 24 55 74 10 80 	movl   $0x80107455,(%esp)
801012f4:	e8 67 f0 ff ff       	call   80100360 <panic>
801012f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101300 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	57                   	push   %edi
80101304:	56                   	push   %esi
80101305:	53                   	push   %ebx
80101306:	89 c3                	mov    %eax,%ebx
80101308:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010130b:	83 fa 0b             	cmp    $0xb,%edx
8010130e:	77 18                	ja     80101328 <bmap+0x28>
80101310:	8d 34 90             	lea    (%eax,%edx,4),%esi
    if((addr = ip->addrs[bn]) == 0)
80101313:	8b 46 5c             	mov    0x5c(%esi),%eax
80101316:	85 c0                	test   %eax,%eax
80101318:	74 66                	je     80101380 <bmap+0x80>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010131a:	83 c4 1c             	add    $0x1c,%esp
8010131d:	5b                   	pop    %ebx
8010131e:	5e                   	pop    %esi
8010131f:	5f                   	pop    %edi
80101320:	5d                   	pop    %ebp
80101321:	c3                   	ret    
80101322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;
80101328:	8d 72 f4             	lea    -0xc(%edx),%esi
  if(bn < NINDIRECT){
8010132b:	83 fe 7f             	cmp    $0x7f,%esi
8010132e:	77 77                	ja     801013a7 <bmap+0xa7>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101330:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101336:	85 c0                	test   %eax,%eax
80101338:	74 5e                	je     80101398 <bmap+0x98>
    bp = bread(ip->dev, addr);
8010133a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010133e:	8b 03                	mov    (%ebx),%eax
80101340:	89 04 24             	mov    %eax,(%esp)
80101343:	e8 88 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
80101348:	8d 54 b0 5c          	lea    0x5c(%eax,%esi,4),%edx
    bp = bread(ip->dev, addr);
8010134c:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010134e:	8b 32                	mov    (%edx),%esi
80101350:	85 f6                	test   %esi,%esi
80101352:	75 19                	jne    8010136d <bmap+0x6d>
      a[bn] = addr = balloc(ip->dev);
80101354:	8b 03                	mov    (%ebx),%eax
80101356:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101359:	e8 c2 fd ff ff       	call   80101120 <balloc>
8010135e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101361:	89 02                	mov    %eax,(%edx)
80101363:	89 c6                	mov    %eax,%esi
      log_write(bp);
80101365:	89 3c 24             	mov    %edi,(%esp)
80101368:	e8 73 19 00 00       	call   80102ce0 <log_write>
    brelse(bp);
8010136d:	89 3c 24             	mov    %edi,(%esp)
80101370:	e8 6b ee ff ff       	call   801001e0 <brelse>
}
80101375:	83 c4 1c             	add    $0x1c,%esp
    brelse(bp);
80101378:	89 f0                	mov    %esi,%eax
}
8010137a:	5b                   	pop    %ebx
8010137b:	5e                   	pop    %esi
8010137c:	5f                   	pop    %edi
8010137d:	5d                   	pop    %ebp
8010137e:	c3                   	ret    
8010137f:	90                   	nop
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 03                	mov    (%ebx),%eax
80101382:	e8 99 fd ff ff       	call   80101120 <balloc>
80101387:	89 46 5c             	mov    %eax,0x5c(%esi)
}
8010138a:	83 c4 1c             	add    $0x1c,%esp
8010138d:	5b                   	pop    %ebx
8010138e:	5e                   	pop    %esi
8010138f:	5f                   	pop    %edi
80101390:	5d                   	pop    %ebp
80101391:	c3                   	ret    
80101392:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101398:	8b 03                	mov    (%ebx),%eax
8010139a:	e8 81 fd ff ff       	call   80101120 <balloc>
8010139f:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
801013a5:	eb 93                	jmp    8010133a <bmap+0x3a>
  panic("bmap: out of range");
801013a7:	c7 04 24 65 74 10 80 	movl   $0x80107465,(%esp)
801013ae:	e8 ad ef ff ff       	call   80100360 <panic>
801013b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013c0 <readsb>:
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	56                   	push   %esi
801013c4:	53                   	push   %ebx
801013c5:	83 ec 10             	sub    $0x10,%esp
  bp = bread(dev, 1);
801013c8:	8b 45 08             	mov    0x8(%ebp),%eax
801013cb:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801013d2:	00 
{
801013d3:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013d6:	89 04 24             	mov    %eax,(%esp)
801013d9:	e8 f2 ec ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013de:	89 34 24             	mov    %esi,(%esp)
801013e1:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
801013e8:	00 
  bp = bread(dev, 1);
801013e9:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013eb:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ee:	89 44 24 04          	mov    %eax,0x4(%esp)
801013f2:	e8 59 35 00 00       	call   80104950 <memmove>
  brelse(bp);
801013f7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801013fa:	83 c4 10             	add    $0x10,%esp
801013fd:	5b                   	pop    %ebx
801013fe:	5e                   	pop    %esi
801013ff:	5d                   	pop    %ebp
  brelse(bp);
80101400:	e9 db ed ff ff       	jmp    801001e0 <brelse>
80101405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101410 <bfree>:
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	57                   	push   %edi
80101414:	89 d7                	mov    %edx,%edi
80101416:	56                   	push   %esi
80101417:	53                   	push   %ebx
80101418:	89 c3                	mov    %eax,%ebx
8010141a:	83 ec 1c             	sub    $0x1c,%esp
  readsb(dev, &sb);
8010141d:	89 04 24             	mov    %eax,(%esp)
80101420:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
80101427:	80 
80101428:	e8 93 ff ff ff       	call   801013c0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
8010142d:	89 fa                	mov    %edi,%edx
8010142f:	c1 ea 0c             	shr    $0xc,%edx
80101432:	03 15 f8 09 11 80    	add    0x801109f8,%edx
80101438:	89 1c 24             	mov    %ebx,(%esp)
  m = 1 << (bi % 8);
8010143b:	bb 01 00 00 00       	mov    $0x1,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101440:	89 54 24 04          	mov    %edx,0x4(%esp)
80101444:	e8 87 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
80101449:	89 f9                	mov    %edi,%ecx
  bi = b % BPB;
8010144b:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80101451:	89 fa                	mov    %edi,%edx
  m = 1 << (bi % 8);
80101453:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101456:	c1 fa 03             	sar    $0x3,%edx
  m = 1 << (bi % 8);
80101459:	d3 e3                	shl    %cl,%ebx
  bp = bread(dev, BBLOCK(b, sb));
8010145b:	89 c6                	mov    %eax,%esi
  if((bp->data[bi/8] & m) == 0)
8010145d:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101462:	0f b6 c8             	movzbl %al,%ecx
80101465:	85 d9                	test   %ebx,%ecx
80101467:	74 20                	je     80101489 <bfree+0x79>
  bp->data[bi/8] &= ~m;
80101469:	f7 d3                	not    %ebx
8010146b:	21 c3                	and    %eax,%ebx
8010146d:	88 5c 16 5c          	mov    %bl,0x5c(%esi,%edx,1)
  log_write(bp);
80101471:	89 34 24             	mov    %esi,(%esp)
80101474:	e8 67 18 00 00       	call   80102ce0 <log_write>
  brelse(bp);
80101479:	89 34 24             	mov    %esi,(%esp)
8010147c:	e8 5f ed ff ff       	call   801001e0 <brelse>
}
80101481:	83 c4 1c             	add    $0x1c,%esp
80101484:	5b                   	pop    %ebx
80101485:	5e                   	pop    %esi
80101486:	5f                   	pop    %edi
80101487:	5d                   	pop    %ebp
80101488:	c3                   	ret    
    panic("freeing free block");
80101489:	c7 04 24 78 74 10 80 	movl   $0x80107478,(%esp)
80101490:	e8 cb ee ff ff       	call   80100360 <panic>
80101495:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101499:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801014a0 <iinit>:
{
801014a0:	55                   	push   %ebp
801014a1:	89 e5                	mov    %esp,%ebp
801014a3:	53                   	push   %ebx
801014a4:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
801014a9:	83 ec 24             	sub    $0x24,%esp
  initlock(&icache.lock, "icache");
801014ac:	c7 44 24 04 8b 74 10 	movl   $0x8010748b,0x4(%esp)
801014b3:	80 
801014b4:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801014bb:	e8 c0 31 00 00       	call   80104680 <initlock>
    initsleeplock(&icache.inode[i].lock, "inode");
801014c0:	89 1c 24             	mov    %ebx,(%esp)
801014c3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014c9:	c7 44 24 04 92 74 10 	movl   $0x80107492,0x4(%esp)
801014d0:	80 
801014d1:	e8 7a 30 00 00       	call   80104550 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014d6:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
801014dc:	75 e2                	jne    801014c0 <iinit+0x20>
  readsb(dev, &sb);
801014de:	8b 45 08             	mov    0x8(%ebp),%eax
801014e1:	c7 44 24 04 e0 09 11 	movl   $0x801109e0,0x4(%esp)
801014e8:	80 
801014e9:	89 04 24             	mov    %eax,(%esp)
801014ec:	e8 cf fe ff ff       	call   801013c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014f1:	a1 f8 09 11 80       	mov    0x801109f8,%eax
801014f6:	c7 04 24 f8 74 10 80 	movl   $0x801074f8,(%esp)
801014fd:	89 44 24 1c          	mov    %eax,0x1c(%esp)
80101501:	a1 f4 09 11 80       	mov    0x801109f4,%eax
80101506:	89 44 24 18          	mov    %eax,0x18(%esp)
8010150a:	a1 f0 09 11 80       	mov    0x801109f0,%eax
8010150f:	89 44 24 14          	mov    %eax,0x14(%esp)
80101513:	a1 ec 09 11 80       	mov    0x801109ec,%eax
80101518:	89 44 24 10          	mov    %eax,0x10(%esp)
8010151c:	a1 e8 09 11 80       	mov    0x801109e8,%eax
80101521:	89 44 24 0c          	mov    %eax,0xc(%esp)
80101525:	a1 e4 09 11 80       	mov    0x801109e4,%eax
8010152a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010152e:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101533:	89 44 24 04          	mov    %eax,0x4(%esp)
80101537:	e8 14 f1 ff ff       	call   80100650 <cprintf>
}
8010153c:	83 c4 24             	add    $0x24,%esp
8010153f:	5b                   	pop    %ebx
80101540:	5d                   	pop    %ebp
80101541:	c3                   	ret    
80101542:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101550 <ialloc>:
{
80101550:	55                   	push   %ebp
80101551:	89 e5                	mov    %esp,%ebp
80101553:	57                   	push   %edi
80101554:	56                   	push   %esi
80101555:	53                   	push   %ebx
80101556:	83 ec 2c             	sub    $0x2c,%esp
80101559:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010155c:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
80101563:	8b 7d 08             	mov    0x8(%ebp),%edi
80101566:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101569:	0f 86 a2 00 00 00    	jbe    80101611 <ialloc+0xc1>
8010156f:	be 01 00 00 00       	mov    $0x1,%esi
80101574:	bb 01 00 00 00       	mov    $0x1,%ebx
80101579:	eb 1a                	jmp    80101595 <ialloc+0x45>
8010157b:	90                   	nop
8010157c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    brelse(bp);
80101580:	89 14 24             	mov    %edx,(%esp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101583:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101586:	e8 55 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010158b:	89 de                	mov    %ebx,%esi
8010158d:	3b 1d e8 09 11 80    	cmp    0x801109e8,%ebx
80101593:	73 7c                	jae    80101611 <ialloc+0xc1>
    bp = bread(dev, IBLOCK(inum, sb));
80101595:	89 f0                	mov    %esi,%eax
80101597:	c1 e8 03             	shr    $0x3,%eax
8010159a:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801015a0:	89 3c 24             	mov    %edi,(%esp)
801015a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
801015ac:	89 c2                	mov    %eax,%edx
    dip = (struct dinode*)bp->data + inum%IPB;
801015ae:	89 f0                	mov    %esi,%eax
801015b0:	83 e0 07             	and    $0x7,%eax
801015b3:	c1 e0 06             	shl    $0x6,%eax
801015b6:	8d 4c 02 5c          	lea    0x5c(%edx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801015ba:	66 83 39 00          	cmpw   $0x0,(%ecx)
801015be:	75 c0                	jne    80101580 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015c0:	89 0c 24             	mov    %ecx,(%esp)
801015c3:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
801015ca:	00 
801015cb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801015d2:	00 
801015d3:	89 55 dc             	mov    %edx,-0x24(%ebp)
801015d6:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801015d9:	e8 d2 32 00 00       	call   801048b0 <memset>
      dip->type = type;
801015de:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
      log_write(bp);   // mark it allocated on the disk
801015e2:	8b 55 dc             	mov    -0x24(%ebp),%edx
      dip->type = type;
801015e5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      log_write(bp);   // mark it allocated on the disk
801015e8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      dip->type = type;
801015eb:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ee:	89 14 24             	mov    %edx,(%esp)
801015f1:	e8 ea 16 00 00       	call   80102ce0 <log_write>
      brelse(bp);
801015f6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015f9:	89 14 24             	mov    %edx,(%esp)
801015fc:	e8 df eb ff ff       	call   801001e0 <brelse>
}
80101601:	83 c4 2c             	add    $0x2c,%esp
      return iget(dev, inum);
80101604:	89 f2                	mov    %esi,%edx
}
80101606:	5b                   	pop    %ebx
      return iget(dev, inum);
80101607:	89 f8                	mov    %edi,%eax
}
80101609:	5e                   	pop    %esi
8010160a:	5f                   	pop    %edi
8010160b:	5d                   	pop    %ebp
      return iget(dev, inum);
8010160c:	e9 2f fc ff ff       	jmp    80101240 <iget>
  panic("ialloc: no inodes");
80101611:	c7 04 24 98 74 10 80 	movl   $0x80107498,(%esp)
80101618:	e8 43 ed ff ff       	call   80100360 <panic>
8010161d:	8d 76 00             	lea    0x0(%esi),%esi

80101620 <iupdate>:
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	56                   	push   %esi
80101624:	53                   	push   %ebx
80101625:	83 ec 10             	sub    $0x10,%esp
80101628:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010162b:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010162e:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101631:	c1 e8 03             	shr    $0x3,%eax
80101634:	03 05 f4 09 11 80    	add    0x801109f4,%eax
8010163a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010163e:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80101641:	89 04 24             	mov    %eax,(%esp)
80101644:	e8 87 ea ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101649:	8b 53 a8             	mov    -0x58(%ebx),%edx
8010164c:	83 e2 07             	and    $0x7,%edx
8010164f:	c1 e2 06             	shl    $0x6,%edx
80101652:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101656:	89 c6                	mov    %eax,%esi
  dip->type = ip->type;
80101658:	0f b7 43 f4          	movzwl -0xc(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165c:	83 c2 0c             	add    $0xc,%edx
  dip->type = ip->type;
8010165f:	66 89 42 f4          	mov    %ax,-0xc(%edx)
  dip->major = ip->major;
80101663:	0f b7 43 f6          	movzwl -0xa(%ebx),%eax
80101667:	66 89 42 f6          	mov    %ax,-0xa(%edx)
  dip->minor = ip->minor;
8010166b:	0f b7 43 f8          	movzwl -0x8(%ebx),%eax
8010166f:	66 89 42 f8          	mov    %ax,-0x8(%edx)
  dip->nlink = ip->nlink;
80101673:	0f b7 43 fa          	movzwl -0x6(%ebx),%eax
80101677:	66 89 42 fa          	mov    %ax,-0x6(%edx)
  dip->size = ip->size;
8010167b:	8b 43 fc             	mov    -0x4(%ebx),%eax
8010167e:	89 42 fc             	mov    %eax,-0x4(%edx)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101681:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101685:	89 14 24             	mov    %edx,(%esp)
80101688:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010168f:	00 
80101690:	e8 bb 32 00 00       	call   80104950 <memmove>
  log_write(bp);
80101695:	89 34 24             	mov    %esi,(%esp)
80101698:	e8 43 16 00 00       	call   80102ce0 <log_write>
  brelse(bp);
8010169d:	89 75 08             	mov    %esi,0x8(%ebp)
}
801016a0:	83 c4 10             	add    $0x10,%esp
801016a3:	5b                   	pop    %ebx
801016a4:	5e                   	pop    %esi
801016a5:	5d                   	pop    %ebp
  brelse(bp);
801016a6:	e9 35 eb ff ff       	jmp    801001e0 <brelse>
801016ab:	90                   	nop
801016ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801016b0 <idup>:
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	53                   	push   %ebx
801016b4:	83 ec 14             	sub    $0x14,%esp
801016b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801016ba:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801016c1:	e8 2a 31 00 00       	call   801047f0 <acquire>
  ip->ref++;
801016c6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016ca:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
801016d1:	e8 8a 31 00 00       	call   80104860 <release>
}
801016d6:	83 c4 14             	add    $0x14,%esp
801016d9:	89 d8                	mov    %ebx,%eax
801016db:	5b                   	pop    %ebx
801016dc:	5d                   	pop    %ebp
801016dd:	c3                   	ret    
801016de:	66 90                	xchg   %ax,%ax

801016e0 <ilock>:
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	56                   	push   %esi
801016e4:	53                   	push   %ebx
801016e5:	83 ec 10             	sub    $0x10,%esp
801016e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801016eb:	85 db                	test   %ebx,%ebx
801016ed:	0f 84 b3 00 00 00    	je     801017a6 <ilock+0xc6>
801016f3:	8b 53 08             	mov    0x8(%ebx),%edx
801016f6:	85 d2                	test   %edx,%edx
801016f8:	0f 8e a8 00 00 00    	jle    801017a6 <ilock+0xc6>
  acquiresleep(&ip->lock);
801016fe:	8d 43 0c             	lea    0xc(%ebx),%eax
80101701:	89 04 24             	mov    %eax,(%esp)
80101704:	e8 87 2e 00 00       	call   80104590 <acquiresleep>
  if(ip->valid == 0){
80101709:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010170c:	85 c0                	test   %eax,%eax
8010170e:	74 08                	je     80101718 <ilock+0x38>
}
80101710:	83 c4 10             	add    $0x10,%esp
80101713:	5b                   	pop    %ebx
80101714:	5e                   	pop    %esi
80101715:	5d                   	pop    %ebp
80101716:	c3                   	ret    
80101717:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101718:	8b 43 04             	mov    0x4(%ebx),%eax
8010171b:	c1 e8 03             	shr    $0x3,%eax
8010171e:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101724:	89 44 24 04          	mov    %eax,0x4(%esp)
80101728:	8b 03                	mov    (%ebx),%eax
8010172a:	89 04 24             	mov    %eax,(%esp)
8010172d:	e8 9e e9 ff ff       	call   801000d0 <bread>
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101732:	8b 53 04             	mov    0x4(%ebx),%edx
80101735:	83 e2 07             	and    $0x7,%edx
80101738:	c1 e2 06             	shl    $0x6,%edx
8010173b:	8d 54 10 5c          	lea    0x5c(%eax,%edx,1),%edx
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010173f:	89 c6                	mov    %eax,%esi
    ip->type = dip->type;
80101741:	0f b7 02             	movzwl (%edx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101744:	83 c2 0c             	add    $0xc,%edx
    ip->type = dip->type;
80101747:	66 89 43 50          	mov    %ax,0x50(%ebx)
    ip->major = dip->major;
8010174b:	0f b7 42 f6          	movzwl -0xa(%edx),%eax
8010174f:	66 89 43 52          	mov    %ax,0x52(%ebx)
    ip->minor = dip->minor;
80101753:	0f b7 42 f8          	movzwl -0x8(%edx),%eax
80101757:	66 89 43 54          	mov    %ax,0x54(%ebx)
    ip->nlink = dip->nlink;
8010175b:	0f b7 42 fa          	movzwl -0x6(%edx),%eax
8010175f:	66 89 43 56          	mov    %ax,0x56(%ebx)
    ip->size = dip->size;
80101763:	8b 42 fc             	mov    -0x4(%edx),%eax
80101766:	89 43 58             	mov    %eax,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101769:	8d 43 5c             	lea    0x5c(%ebx),%eax
8010176c:	89 54 24 04          	mov    %edx,0x4(%esp)
80101770:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101777:	00 
80101778:	89 04 24             	mov    %eax,(%esp)
8010177b:	e8 d0 31 00 00       	call   80104950 <memmove>
    brelse(bp);
80101780:	89 34 24             	mov    %esi,(%esp)
80101783:	e8 58 ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101788:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010178d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101794:	0f 85 76 ff ff ff    	jne    80101710 <ilock+0x30>
      panic("ilock: no type");
8010179a:	c7 04 24 b0 74 10 80 	movl   $0x801074b0,(%esp)
801017a1:	e8 ba eb ff ff       	call   80100360 <panic>
    panic("ilock");
801017a6:	c7 04 24 aa 74 10 80 	movl   $0x801074aa,(%esp)
801017ad:	e8 ae eb ff ff       	call   80100360 <panic>
801017b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801017c0 <iunlock>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	56                   	push   %esi
801017c4:	53                   	push   %ebx
801017c5:	83 ec 10             	sub    $0x10,%esp
801017c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017cb:	85 db                	test   %ebx,%ebx
801017cd:	74 24                	je     801017f3 <iunlock+0x33>
801017cf:	8d 73 0c             	lea    0xc(%ebx),%esi
801017d2:	89 34 24             	mov    %esi,(%esp)
801017d5:	e8 56 2e 00 00       	call   80104630 <holdingsleep>
801017da:	85 c0                	test   %eax,%eax
801017dc:	74 15                	je     801017f3 <iunlock+0x33>
801017de:	8b 43 08             	mov    0x8(%ebx),%eax
801017e1:	85 c0                	test   %eax,%eax
801017e3:	7e 0e                	jle    801017f3 <iunlock+0x33>
  releasesleep(&ip->lock);
801017e5:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017e8:	83 c4 10             	add    $0x10,%esp
801017eb:	5b                   	pop    %ebx
801017ec:	5e                   	pop    %esi
801017ed:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801017ee:	e9 fd 2d 00 00       	jmp    801045f0 <releasesleep>
    panic("iunlock");
801017f3:	c7 04 24 bf 74 10 80 	movl   $0x801074bf,(%esp)
801017fa:	e8 61 eb ff ff       	call   80100360 <panic>
801017ff:	90                   	nop

80101800 <iput>:
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	57                   	push   %edi
80101804:	56                   	push   %esi
80101805:	53                   	push   %ebx
80101806:	83 ec 1c             	sub    $0x1c,%esp
80101809:	8b 75 08             	mov    0x8(%ebp),%esi
  acquiresleep(&ip->lock);
8010180c:	8d 7e 0c             	lea    0xc(%esi),%edi
8010180f:	89 3c 24             	mov    %edi,(%esp)
80101812:	e8 79 2d 00 00       	call   80104590 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101817:	8b 56 4c             	mov    0x4c(%esi),%edx
8010181a:	85 d2                	test   %edx,%edx
8010181c:	74 07                	je     80101825 <iput+0x25>
8010181e:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80101823:	74 2b                	je     80101850 <iput+0x50>
  releasesleep(&ip->lock);
80101825:	89 3c 24             	mov    %edi,(%esp)
80101828:	e8 c3 2d 00 00       	call   801045f0 <releasesleep>
  acquire(&icache.lock);
8010182d:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101834:	e8 b7 2f 00 00       	call   801047f0 <acquire>
  ip->ref--;
80101839:	83 6e 08 01          	subl   $0x1,0x8(%esi)
  release(&icache.lock);
8010183d:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
80101844:	83 c4 1c             	add    $0x1c,%esp
80101847:	5b                   	pop    %ebx
80101848:	5e                   	pop    %esi
80101849:	5f                   	pop    %edi
8010184a:	5d                   	pop    %ebp
  release(&icache.lock);
8010184b:	e9 10 30 00 00       	jmp    80104860 <release>
    acquire(&icache.lock);
80101850:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101857:	e8 94 2f 00 00       	call   801047f0 <acquire>
    int r = ip->ref;
8010185c:	8b 5e 08             	mov    0x8(%esi),%ebx
    release(&icache.lock);
8010185f:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101866:	e8 f5 2f 00 00       	call   80104860 <release>
    if(r == 1){
8010186b:	83 fb 01             	cmp    $0x1,%ebx
8010186e:	75 b5                	jne    80101825 <iput+0x25>
80101870:	8d 4e 30             	lea    0x30(%esi),%ecx
80101873:	89 f3                	mov    %esi,%ebx
80101875:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101878:	89 cf                	mov    %ecx,%edi
8010187a:	eb 0b                	jmp    80101887 <iput+0x87>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101880:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101883:	39 fb                	cmp    %edi,%ebx
80101885:	74 19                	je     801018a0 <iput+0xa0>
    if(ip->addrs[i]){
80101887:	8b 53 5c             	mov    0x5c(%ebx),%edx
8010188a:	85 d2                	test   %edx,%edx
8010188c:	74 f2                	je     80101880 <iput+0x80>
      bfree(ip->dev, ip->addrs[i]);
8010188e:	8b 06                	mov    (%esi),%eax
80101890:	e8 7b fb ff ff       	call   80101410 <bfree>
      ip->addrs[i] = 0;
80101895:	c7 43 5c 00 00 00 00 	movl   $0x0,0x5c(%ebx)
8010189c:	eb e2                	jmp    80101880 <iput+0x80>
8010189e:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
801018a0:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
801018a6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801018a9:	85 c0                	test   %eax,%eax
801018ab:	75 2b                	jne    801018d8 <iput+0xd8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018ad:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
801018b4:	89 34 24             	mov    %esi,(%esp)
801018b7:	e8 64 fd ff ff       	call   80101620 <iupdate>
      ip->type = 0;
801018bc:	31 c0                	xor    %eax,%eax
801018be:	66 89 46 50          	mov    %ax,0x50(%esi)
      iupdate(ip);
801018c2:	89 34 24             	mov    %esi,(%esp)
801018c5:	e8 56 fd ff ff       	call   80101620 <iupdate>
      ip->valid = 0;
801018ca:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
801018d1:	e9 4f ff ff ff       	jmp    80101825 <iput+0x25>
801018d6:	66 90                	xchg   %ax,%ax
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018d8:	89 44 24 04          	mov    %eax,0x4(%esp)
801018dc:	8b 06                	mov    (%esi),%eax
    for(j = 0; j < NINDIRECT; j++){
801018de:	31 db                	xor    %ebx,%ebx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018e0:	89 04 24             	mov    %eax,(%esp)
801018e3:	e8 e8 e7 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801018e8:	89 7d e0             	mov    %edi,-0x20(%ebp)
    a = (uint*)bp->data;
801018eb:	8d 48 5c             	lea    0x5c(%eax),%ecx
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801018f1:	89 cf                	mov    %ecx,%edi
801018f3:	31 c0                	xor    %eax,%eax
801018f5:	eb 0e                	jmp    80101905 <iput+0x105>
801018f7:	90                   	nop
801018f8:	83 c3 01             	add    $0x1,%ebx
801018fb:	81 fb 80 00 00 00    	cmp    $0x80,%ebx
80101901:	89 d8                	mov    %ebx,%eax
80101903:	74 10                	je     80101915 <iput+0x115>
      if(a[j])
80101905:	8b 14 87             	mov    (%edi,%eax,4),%edx
80101908:	85 d2                	test   %edx,%edx
8010190a:	74 ec                	je     801018f8 <iput+0xf8>
        bfree(ip->dev, a[j]);
8010190c:	8b 06                	mov    (%esi),%eax
8010190e:	e8 fd fa ff ff       	call   80101410 <bfree>
80101913:	eb e3                	jmp    801018f8 <iput+0xf8>
    brelse(bp);
80101915:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101918:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010191b:	89 04 24             	mov    %eax,(%esp)
8010191e:	e8 bd e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101923:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
80101929:	8b 06                	mov    (%esi),%eax
8010192b:	e8 e0 fa ff ff       	call   80101410 <bfree>
    ip->addrs[NDIRECT] = 0;
80101930:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80101937:	00 00 00 
8010193a:	e9 6e ff ff ff       	jmp    801018ad <iput+0xad>
8010193f:	90                   	nop

80101940 <iunlockput>:
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	53                   	push   %ebx
80101944:	83 ec 14             	sub    $0x14,%esp
80101947:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010194a:	89 1c 24             	mov    %ebx,(%esp)
8010194d:	e8 6e fe ff ff       	call   801017c0 <iunlock>
  iput(ip);
80101952:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101955:	83 c4 14             	add    $0x14,%esp
80101958:	5b                   	pop    %ebx
80101959:	5d                   	pop    %ebp
  iput(ip);
8010195a:	e9 a1 fe ff ff       	jmp    80101800 <iput>
8010195f:	90                   	nop

80101960 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	8b 55 08             	mov    0x8(%ebp),%edx
80101966:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101969:	8b 0a                	mov    (%edx),%ecx
8010196b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010196e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101971:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101974:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101978:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010197b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010197f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101983:	8b 52 58             	mov    0x58(%edx),%edx
80101986:	89 50 10             	mov    %edx,0x10(%eax)
}
80101989:	5d                   	pop    %ebp
8010198a:	c3                   	ret    
8010198b:	90                   	nop
8010198c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101990 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	57                   	push   %edi
80101994:	56                   	push   %esi
80101995:	53                   	push   %ebx
80101996:	83 ec 2c             	sub    $0x2c,%esp
80101999:	8b 45 0c             	mov    0xc(%ebp),%eax
8010199c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010199f:	8b 75 10             	mov    0x10(%ebp),%esi
801019a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801019a5:	8b 45 14             	mov    0x14(%ebp),%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019a8:	66 83 7f 50 03       	cmpw   $0x3,0x50(%edi)
{
801019ad:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(ip->type == T_DEV){
801019b0:	0f 84 aa 00 00 00    	je     80101a60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019b6:	8b 47 58             	mov    0x58(%edi),%eax
801019b9:	39 f0                	cmp    %esi,%eax
801019bb:	0f 82 c7 00 00 00    	jb     80101a88 <readi+0xf8>
801019c1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801019c4:	89 da                	mov    %ebx,%edx
801019c6:	01 f2                	add    %esi,%edx
801019c8:	0f 82 ba 00 00 00    	jb     80101a88 <readi+0xf8>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019ce:	89 c1                	mov    %eax,%ecx
801019d0:	29 f1                	sub    %esi,%ecx
801019d2:	39 d0                	cmp    %edx,%eax
801019d4:	0f 43 cb             	cmovae %ebx,%ecx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d7:	31 c0                	xor    %eax,%eax
801019d9:	85 c9                	test   %ecx,%ecx
    n = ip->size - off;
801019db:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019de:	74 70                	je     80101a50 <readi+0xc0>
801019e0:	89 7d d8             	mov    %edi,-0x28(%ebp)
801019e3:	89 c7                	mov    %eax,%edi
801019e5:	8d 76 00             	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019e8:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019eb:	89 f2                	mov    %esi,%edx
801019ed:	c1 ea 09             	shr    $0x9,%edx
801019f0:	89 d8                	mov    %ebx,%eax
801019f2:	e8 09 f9 ff ff       	call   80101300 <bmap>
801019f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801019fb:	8b 03                	mov    (%ebx),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801019fd:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a02:	89 04 24             	mov    %eax,(%esp)
80101a05:	e8 c6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a0a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101a0d:	29 f9                	sub    %edi,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a0f:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a11:	89 f0                	mov    %esi,%eax
80101a13:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a18:	29 c3                	sub    %eax,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a1a:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a1e:	39 cb                	cmp    %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a20:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a24:	8b 45 e0             	mov    -0x20(%ebp),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a27:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a2a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a2e:	01 df                	add    %ebx,%edi
80101a30:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a32:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101a35:	89 04 24             	mov    %eax,(%esp)
80101a38:	e8 13 2f 00 00       	call   80104950 <memmove>
    brelse(bp);
80101a3d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a40:	89 14 24             	mov    %edx,(%esp)
80101a43:	e8 98 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a48:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a4b:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a4e:	77 98                	ja     801019e8 <readi+0x58>
  }
  return n;
80101a50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a53:	83 c4 2c             	add    $0x2c,%esp
80101a56:	5b                   	pop    %ebx
80101a57:	5e                   	pop    %esi
80101a58:	5f                   	pop    %edi
80101a59:	5d                   	pop    %ebp
80101a5a:	c3                   	ret    
80101a5b:	90                   	nop
80101a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a60:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101a64:	66 83 f8 09          	cmp    $0x9,%ax
80101a68:	77 1e                	ja     80101a88 <readi+0xf8>
80101a6a:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a71:	85 c0                	test   %eax,%eax
80101a73:	74 13                	je     80101a88 <readi+0xf8>
    return devsw[ip->major].read(ip, dst, n);
80101a75:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101a78:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101a7b:	83 c4 2c             	add    $0x2c,%esp
80101a7e:	5b                   	pop    %ebx
80101a7f:	5e                   	pop    %esi
80101a80:	5f                   	pop    %edi
80101a81:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a82:	ff e0                	jmp    *%eax
80101a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101a88:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a8d:	eb c4                	jmp    80101a53 <readi+0xc3>
80101a8f:	90                   	nop

80101a90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 2c             	sub    $0x2c,%esp
80101a99:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a9f:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aa2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aa7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101aaa:	8b 75 10             	mov    0x10(%ebp),%esi
80101aad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ab0:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101ab3:	0f 84 b7 00 00 00    	je     80101b70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ab9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abc:	39 70 58             	cmp    %esi,0x58(%eax)
80101abf:	0f 82 e3 00 00 00    	jb     80101ba8 <writei+0x118>
80101ac5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101ac8:	89 c8                	mov    %ecx,%eax
80101aca:	01 f0                	add    %esi,%eax
80101acc:	0f 82 d6 00 00 00    	jb     80101ba8 <writei+0x118>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ad2:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ad7:	0f 87 cb 00 00 00    	ja     80101ba8 <writei+0x118>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101add:	85 c9                	test   %ecx,%ecx
80101adf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ae6:	74 77                	je     80101b5f <writei+0xcf>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ae8:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101aeb:	89 f2                	mov    %esi,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101aed:	bb 00 02 00 00       	mov    $0x200,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af2:	c1 ea 09             	shr    $0x9,%edx
80101af5:	89 f8                	mov    %edi,%eax
80101af7:	e8 04 f8 ff ff       	call   80101300 <bmap>
80101afc:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b00:	8b 07                	mov    (%edi),%eax
80101b02:	89 04 24             	mov    %eax,(%esp)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0a:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b0d:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b10:	8b 55 dc             	mov    -0x24(%ebp),%edx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b13:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101b15:	89 f0                	mov    %esi,%eax
80101b17:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b1c:	29 c3                	sub    %eax,%ebx
80101b1e:	39 cb                	cmp    %ecx,%ebx
80101b20:	0f 47 d9             	cmova  %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b23:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b27:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b29:	89 54 24 04          	mov    %edx,0x4(%esp)
80101b2d:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101b31:	89 04 24             	mov    %eax,(%esp)
80101b34:	e8 17 2e 00 00       	call   80104950 <memmove>
    log_write(bp);
80101b39:	89 3c 24             	mov    %edi,(%esp)
80101b3c:	e8 9f 11 00 00       	call   80102ce0 <log_write>
    brelse(bp);
80101b41:	89 3c 24             	mov    %edi,(%esp)
80101b44:	e8 97 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b49:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b4c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b4f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b52:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b55:	77 91                	ja     80101ae8 <writei+0x58>
  }

  if(n > 0 && off > ip->size){
80101b57:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b5a:	39 70 58             	cmp    %esi,0x58(%eax)
80101b5d:	72 39                	jb     80101b98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b5f:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b62:	83 c4 2c             	add    $0x2c,%esp
80101b65:	5b                   	pop    %ebx
80101b66:	5e                   	pop    %esi
80101b67:	5f                   	pop    %edi
80101b68:	5d                   	pop    %ebp
80101b69:	c3                   	ret    
80101b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b74:	66 83 f8 09          	cmp    $0x9,%ax
80101b78:	77 2e                	ja     80101ba8 <writei+0x118>
80101b7a:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b81:	85 c0                	test   %eax,%eax
80101b83:	74 23                	je     80101ba8 <writei+0x118>
    return devsw[ip->major].write(ip, src, n);
80101b85:	89 4d 10             	mov    %ecx,0x10(%ebp)
}
80101b88:	83 c4 2c             	add    $0x2c,%esp
80101b8b:	5b                   	pop    %ebx
80101b8c:	5e                   	pop    %esi
80101b8d:	5f                   	pop    %edi
80101b8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b8f:	ff e0                	jmp    *%eax
80101b91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b98:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b9b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b9e:	89 04 24             	mov    %eax,(%esp)
80101ba1:	e8 7a fa ff ff       	call   80101620 <iupdate>
80101ba6:	eb b7                	jmp    80101b5f <writei+0xcf>
}
80101ba8:	83 c4 2c             	add    $0x2c,%esp
      return -1;
80101bab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101bb0:	5b                   	pop    %ebx
80101bb1:	5e                   	pop    %esi
80101bb2:	5f                   	pop    %edi
80101bb3:	5d                   	pop    %ebp
80101bb4:	c3                   	ret    
80101bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101bc9:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101bd0:	00 
80101bd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101bd5:	8b 45 08             	mov    0x8(%ebp),%eax
80101bd8:	89 04 24             	mov    %eax,(%esp)
80101bdb:	e8 f0 2d 00 00       	call   801049d0 <strncmp>
}
80101be0:	c9                   	leave  
80101be1:	c3                   	ret    
80101be2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bf0:	55                   	push   %ebp
80101bf1:	89 e5                	mov    %esp,%ebp
80101bf3:	57                   	push   %edi
80101bf4:	56                   	push   %esi
80101bf5:	53                   	push   %ebx
80101bf6:	83 ec 2c             	sub    $0x2c,%esp
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bfc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c01:	0f 85 97 00 00 00    	jne    80101c9e <dirlookup+0xae>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c07:	8b 53 58             	mov    0x58(%ebx),%edx
80101c0a:	31 ff                	xor    %edi,%edi
80101c0c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c0f:	85 d2                	test   %edx,%edx
80101c11:	75 0d                	jne    80101c20 <dirlookup+0x30>
80101c13:	eb 73                	jmp    80101c88 <dirlookup+0x98>
80101c15:	8d 76 00             	lea    0x0(%esi),%esi
80101c18:	83 c7 10             	add    $0x10,%edi
80101c1b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101c1e:	76 68                	jbe    80101c88 <dirlookup+0x98>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c20:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101c27:	00 
80101c28:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101c2c:	89 74 24 04          	mov    %esi,0x4(%esp)
80101c30:	89 1c 24             	mov    %ebx,(%esp)
80101c33:	e8 58 fd ff ff       	call   80101990 <readi>
80101c38:	83 f8 10             	cmp    $0x10,%eax
80101c3b:	75 55                	jne    80101c92 <dirlookup+0xa2>
      panic("dirlookup read");
    if(de.inum == 0)
80101c3d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c42:	74 d4                	je     80101c18 <dirlookup+0x28>
  return strncmp(s, t, DIRSIZ);
80101c44:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c47:	89 44 24 04          	mov    %eax,0x4(%esp)
80101c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c4e:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101c55:	00 
80101c56:	89 04 24             	mov    %eax,(%esp)
80101c59:	e8 72 2d 00 00       	call   801049d0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c5e:	85 c0                	test   %eax,%eax
80101c60:	75 b6                	jne    80101c18 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c62:	8b 45 10             	mov    0x10(%ebp),%eax
80101c65:	85 c0                	test   %eax,%eax
80101c67:	74 05                	je     80101c6e <dirlookup+0x7e>
        *poff = off;
80101c69:	8b 45 10             	mov    0x10(%ebp),%eax
80101c6c:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c6e:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c72:	8b 03                	mov    (%ebx),%eax
80101c74:	e8 c7 f5 ff ff       	call   80101240 <iget>
    }
  }

  return 0;
}
80101c79:	83 c4 2c             	add    $0x2c,%esp
80101c7c:	5b                   	pop    %ebx
80101c7d:	5e                   	pop    %esi
80101c7e:	5f                   	pop    %edi
80101c7f:	5d                   	pop    %ebp
80101c80:	c3                   	ret    
80101c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c88:	83 c4 2c             	add    $0x2c,%esp
  return 0;
80101c8b:	31 c0                	xor    %eax,%eax
}
80101c8d:	5b                   	pop    %ebx
80101c8e:	5e                   	pop    %esi
80101c8f:	5f                   	pop    %edi
80101c90:	5d                   	pop    %ebp
80101c91:	c3                   	ret    
      panic("dirlookup read");
80101c92:	c7 04 24 d9 74 10 80 	movl   $0x801074d9,(%esp)
80101c99:	e8 c2 e6 ff ff       	call   80100360 <panic>
    panic("dirlookup not DIR");
80101c9e:	c7 04 24 c7 74 10 80 	movl   $0x801074c7,(%esp)
80101ca5:	e8 b6 e6 ff ff       	call   80100360 <panic>
80101caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cb0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	57                   	push   %edi
80101cb4:	89 cf                	mov    %ecx,%edi
80101cb6:	56                   	push   %esi
80101cb7:	53                   	push   %ebx
80101cb8:	89 c3                	mov    %eax,%ebx
80101cba:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cbd:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101cc0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101cc3:	0f 84 51 01 00 00    	je     80101e1a <namex+0x16a>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101cc9:	e8 42 1a 00 00       	call   80103710 <myproc>
80101cce:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101cd1:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101cd8:	e8 13 2b 00 00       	call   801047f0 <acquire>
  ip->ref++;
80101cdd:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ce1:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101ce8:	e8 73 2b 00 00       	call   80104860 <release>
80101ced:	eb 04                	jmp    80101cf3 <namex+0x43>
80101cef:	90                   	nop
    path++;
80101cf0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cf3:	0f b6 03             	movzbl (%ebx),%eax
80101cf6:	3c 2f                	cmp    $0x2f,%al
80101cf8:	74 f6                	je     80101cf0 <namex+0x40>
  if(*path == 0)
80101cfa:	84 c0                	test   %al,%al
80101cfc:	0f 84 ed 00 00 00    	je     80101def <namex+0x13f>
  while(*path != '/' && *path != 0)
80101d02:	0f b6 03             	movzbl (%ebx),%eax
80101d05:	89 da                	mov    %ebx,%edx
80101d07:	84 c0                	test   %al,%al
80101d09:	0f 84 b1 00 00 00    	je     80101dc0 <namex+0x110>
80101d0f:	3c 2f                	cmp    $0x2f,%al
80101d11:	75 0f                	jne    80101d22 <namex+0x72>
80101d13:	e9 a8 00 00 00       	jmp    80101dc0 <namex+0x110>
80101d18:	3c 2f                	cmp    $0x2f,%al
80101d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d20:	74 0a                	je     80101d2c <namex+0x7c>
    path++;
80101d22:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101d25:	0f b6 02             	movzbl (%edx),%eax
80101d28:	84 c0                	test   %al,%al
80101d2a:	75 ec                	jne    80101d18 <namex+0x68>
80101d2c:	89 d1                	mov    %edx,%ecx
80101d2e:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d30:	83 f9 0d             	cmp    $0xd,%ecx
80101d33:	0f 8e 8f 00 00 00    	jle    80101dc8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d39:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101d3d:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101d44:	00 
80101d45:	89 3c 24             	mov    %edi,(%esp)
80101d48:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d4b:	e8 00 2c 00 00       	call   80104950 <memmove>
    path++;
80101d50:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d53:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d55:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d58:	75 0e                	jne    80101d68 <namex+0xb8>
80101d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    path++;
80101d60:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d63:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d66:	74 f8                	je     80101d60 <namex+0xb0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d68:	89 34 24             	mov    %esi,(%esp)
80101d6b:	e8 70 f9 ff ff       	call   801016e0 <ilock>
    if(ip->type != T_DIR){
80101d70:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d75:	0f 85 85 00 00 00    	jne    80101e00 <namex+0x150>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d7b:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d7e:	85 d2                	test   %edx,%edx
80101d80:	74 09                	je     80101d8b <namex+0xdb>
80101d82:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d85:	0f 84 a5 00 00 00    	je     80101e30 <namex+0x180>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d8b:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101d92:	00 
80101d93:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101d97:	89 34 24             	mov    %esi,(%esp)
80101d9a:	e8 51 fe ff ff       	call   80101bf0 <dirlookup>
80101d9f:	85 c0                	test   %eax,%eax
80101da1:	74 5d                	je     80101e00 <namex+0x150>
  iunlock(ip);
80101da3:	89 34 24             	mov    %esi,(%esp)
80101da6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101da9:	e8 12 fa ff ff       	call   801017c0 <iunlock>
  iput(ip);
80101dae:	89 34 24             	mov    %esi,(%esp)
80101db1:	e8 4a fa ff ff       	call   80101800 <iput>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101db6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101db9:	89 c6                	mov    %eax,%esi
80101dbb:	e9 33 ff ff ff       	jmp    80101cf3 <namex+0x43>
  while(*path != '/' && *path != 0)
80101dc0:	31 c9                	xor    %ecx,%ecx
80101dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(name, s, len);
80101dc8:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101dcc:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101dd0:	89 3c 24             	mov    %edi,(%esp)
80101dd3:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dd6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101dd9:	e8 72 2b 00 00       	call   80104950 <memmove>
    name[len] = 0;
80101dde:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101de1:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101de4:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101de8:	89 d3                	mov    %edx,%ebx
80101dea:	e9 66 ff ff ff       	jmp    80101d55 <namex+0xa5>
  }
  if(nameiparent){
80101def:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101df2:	85 c0                	test   %eax,%eax
80101df4:	75 4c                	jne    80101e42 <namex+0x192>
80101df6:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101df8:	83 c4 2c             	add    $0x2c,%esp
80101dfb:	5b                   	pop    %ebx
80101dfc:	5e                   	pop    %esi
80101dfd:	5f                   	pop    %edi
80101dfe:	5d                   	pop    %ebp
80101dff:	c3                   	ret    
  iunlock(ip);
80101e00:	89 34 24             	mov    %esi,(%esp)
80101e03:	e8 b8 f9 ff ff       	call   801017c0 <iunlock>
  iput(ip);
80101e08:	89 34 24             	mov    %esi,(%esp)
80101e0b:	e8 f0 f9 ff ff       	call   80101800 <iput>
}
80101e10:	83 c4 2c             	add    $0x2c,%esp
      return 0;
80101e13:	31 c0                	xor    %eax,%eax
}
80101e15:	5b                   	pop    %ebx
80101e16:	5e                   	pop    %esi
80101e17:	5f                   	pop    %edi
80101e18:	5d                   	pop    %ebp
80101e19:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e1a:	ba 01 00 00 00       	mov    $0x1,%edx
80101e1f:	b8 01 00 00 00       	mov    $0x1,%eax
80101e24:	e8 17 f4 ff ff       	call   80101240 <iget>
80101e29:	89 c6                	mov    %eax,%esi
80101e2b:	e9 c3 fe ff ff       	jmp    80101cf3 <namex+0x43>
      iunlock(ip);
80101e30:	89 34 24             	mov    %esi,(%esp)
80101e33:	e8 88 f9 ff ff       	call   801017c0 <iunlock>
}
80101e38:	83 c4 2c             	add    $0x2c,%esp
      return ip;
80101e3b:	89 f0                	mov    %esi,%eax
}
80101e3d:	5b                   	pop    %ebx
80101e3e:	5e                   	pop    %esi
80101e3f:	5f                   	pop    %edi
80101e40:	5d                   	pop    %ebp
80101e41:	c3                   	ret    
    iput(ip);
80101e42:	89 34 24             	mov    %esi,(%esp)
80101e45:	e8 b6 f9 ff ff       	call   80101800 <iput>
    return 0;
80101e4a:	31 c0                	xor    %eax,%eax
80101e4c:	eb aa                	jmp    80101df8 <namex+0x148>
80101e4e:	66 90                	xchg   %ax,%ax

80101e50 <dirlink>:
{
80101e50:	55                   	push   %ebp
80101e51:	89 e5                	mov    %esp,%ebp
80101e53:	57                   	push   %edi
80101e54:	56                   	push   %esi
80101e55:	53                   	push   %ebx
80101e56:	83 ec 2c             	sub    $0x2c,%esp
80101e59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e5f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e66:	00 
80101e67:	89 1c 24             	mov    %ebx,(%esp)
80101e6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101e6e:	e8 7d fd ff ff       	call   80101bf0 <dirlookup>
80101e73:	85 c0                	test   %eax,%eax
80101e75:	0f 85 8b 00 00 00    	jne    80101f06 <dirlink+0xb6>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e7b:	8b 43 58             	mov    0x58(%ebx),%eax
80101e7e:	31 ff                	xor    %edi,%edi
80101e80:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e83:	85 c0                	test   %eax,%eax
80101e85:	75 13                	jne    80101e9a <dirlink+0x4a>
80101e87:	eb 35                	jmp    80101ebe <dirlink+0x6e>
80101e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e90:	8d 57 10             	lea    0x10(%edi),%edx
80101e93:	39 53 58             	cmp    %edx,0x58(%ebx)
80101e96:	89 d7                	mov    %edx,%edi
80101e98:	76 24                	jbe    80101ebe <dirlink+0x6e>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e9a:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ea1:	00 
80101ea2:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ea6:	89 74 24 04          	mov    %esi,0x4(%esp)
80101eaa:	89 1c 24             	mov    %ebx,(%esp)
80101ead:	e8 de fa ff ff       	call   80101990 <readi>
80101eb2:	83 f8 10             	cmp    $0x10,%eax
80101eb5:	75 5e                	jne    80101f15 <dirlink+0xc5>
    if(de.inum == 0)
80101eb7:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101ebc:	75 d2                	jne    80101e90 <dirlink+0x40>
  strncpy(de.name, name, DIRSIZ);
80101ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ec1:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101ec8:	00 
80101ec9:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ecd:	8d 45 da             	lea    -0x26(%ebp),%eax
80101ed0:	89 04 24             	mov    %eax,(%esp)
80101ed3:	e8 68 2b 00 00       	call   80104a40 <strncpy>
  de.inum = inum;
80101ed8:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101edb:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101ee2:	00 
80101ee3:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101ee7:	89 74 24 04          	mov    %esi,0x4(%esp)
80101eeb:	89 1c 24             	mov    %ebx,(%esp)
  de.inum = inum;
80101eee:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ef2:	e8 99 fb ff ff       	call   80101a90 <writei>
80101ef7:	83 f8 10             	cmp    $0x10,%eax
80101efa:	75 25                	jne    80101f21 <dirlink+0xd1>
  return 0;
80101efc:	31 c0                	xor    %eax,%eax
}
80101efe:	83 c4 2c             	add    $0x2c,%esp
80101f01:	5b                   	pop    %ebx
80101f02:	5e                   	pop    %esi
80101f03:	5f                   	pop    %edi
80101f04:	5d                   	pop    %ebp
80101f05:	c3                   	ret    
    iput(ip);
80101f06:	89 04 24             	mov    %eax,(%esp)
80101f09:	e8 f2 f8 ff ff       	call   80101800 <iput>
    return -1;
80101f0e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f13:	eb e9                	jmp    80101efe <dirlink+0xae>
      panic("dirlink read");
80101f15:	c7 04 24 e8 74 10 80 	movl   $0x801074e8,(%esp)
80101f1c:	e8 3f e4 ff ff       	call   80100360 <panic>
    panic("dirlink");
80101f21:	c7 04 24 9a 7b 10 80 	movl   $0x80107b9a,(%esp)
80101f28:	e8 33 e4 ff ff       	call   80100360 <panic>
80101f2d:	8d 76 00             	lea    0x0(%esi),%esi

80101f30 <namei>:

struct inode*
namei(char *path)
{
80101f30:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f31:	31 d2                	xor    %edx,%edx
{
80101f33:	89 e5                	mov    %esp,%ebp
80101f35:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f38:	8b 45 08             	mov    0x8(%ebp),%eax
80101f3b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f3e:	e8 6d fd ff ff       	call   80101cb0 <namex>
}
80101f43:	c9                   	leave  
80101f44:	c3                   	ret    
80101f45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f50 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f50:	55                   	push   %ebp
  return namex(path, 1, name);
80101f51:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f56:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f58:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f5b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f5e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f5f:	e9 4c fd ff ff       	jmp    80101cb0 <namex>
80101f64:	66 90                	xchg   %ax,%ax
80101f66:	66 90                	xchg   %ax,%ax
80101f68:	66 90                	xchg   %ax,%ax
80101f6a:	66 90                	xchg   %ax,%ax
80101f6c:	66 90                	xchg   %ax,%ax
80101f6e:	66 90                	xchg   %ax,%ax

80101f70 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	56                   	push   %esi
80101f74:	89 c6                	mov    %eax,%esi
80101f76:	53                   	push   %ebx
80101f77:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
80101f7a:	85 c0                	test   %eax,%eax
80101f7c:	0f 84 99 00 00 00    	je     8010201b <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f82:	8b 48 08             	mov    0x8(%eax),%ecx
80101f85:	81 f9 1f 4e 00 00    	cmp    $0x4e1f,%ecx
80101f8b:	0f 87 7e 00 00 00    	ja     8010200f <idestart+0x9f>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f91:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f96:	66 90                	xchg   %ax,%ax
80101f98:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f99:	83 e0 c0             	and    $0xffffffc0,%eax
80101f9c:	3c 40                	cmp    $0x40,%al
80101f9e:	75 f8                	jne    80101f98 <idestart+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101fa0:	31 db                	xor    %ebx,%ebx
80101fa2:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101fa7:	89 d8                	mov    %ebx,%eax
80101fa9:	ee                   	out    %al,(%dx)
80101faa:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101faf:	b8 01 00 00 00       	mov    $0x1,%eax
80101fb4:	ee                   	out    %al,(%dx)
80101fb5:	0f b6 c1             	movzbl %cl,%eax
80101fb8:	b2 f3                	mov    $0xf3,%dl
80101fba:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101fbb:	89 c8                	mov    %ecx,%eax
80101fbd:	b2 f4                	mov    $0xf4,%dl
80101fbf:	c1 f8 08             	sar    $0x8,%eax
80101fc2:	ee                   	out    %al,(%dx)
80101fc3:	b2 f5                	mov    $0xf5,%dl
80101fc5:	89 d8                	mov    %ebx,%eax
80101fc7:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101fc8:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fcc:	b2 f6                	mov    $0xf6,%dl
80101fce:	83 e0 01             	and    $0x1,%eax
80101fd1:	c1 e0 04             	shl    $0x4,%eax
80101fd4:	83 c8 e0             	or     $0xffffffe0,%eax
80101fd7:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fd8:	f6 06 04             	testb  $0x4,(%esi)
80101fdb:	75 13                	jne    80101ff0 <idestart+0x80>
80101fdd:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fe2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fe7:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fe8:	83 c4 10             	add    $0x10,%esp
80101feb:	5b                   	pop    %ebx
80101fec:	5e                   	pop    %esi
80101fed:	5d                   	pop    %ebp
80101fee:	c3                   	ret    
80101fef:	90                   	nop
80101ff0:	b2 f7                	mov    $0xf7,%dl
80101ff2:	b8 30 00 00 00       	mov    $0x30,%eax
80101ff7:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101ff8:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101ffd:	83 c6 5c             	add    $0x5c,%esi
80102000:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102005:	fc                   	cld    
80102006:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102008:	83 c4 10             	add    $0x10,%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5d                   	pop    %ebp
8010200e:	c3                   	ret    
    panic("incorrect blockno");
8010200f:	c7 04 24 54 75 10 80 	movl   $0x80107554,(%esp)
80102016:	e8 45 e3 ff ff       	call   80100360 <panic>
    panic("idestart");
8010201b:	c7 04 24 4b 75 10 80 	movl   $0x8010754b,(%esp)
80102022:	e8 39 e3 ff ff       	call   80100360 <panic>
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 18             	sub    $0x18,%esp
  initlock(&idelock, "ide");
80102036:	c7 44 24 04 66 75 10 	movl   $0x80107566,0x4(%esp)
8010203d:	80 
8010203e:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102045:	e8 36 26 00 00       	call   80104680 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010204a:	a1 20 2d 11 80       	mov    0x80112d20,%eax
8010204f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102056:	83 e8 01             	sub    $0x1,%eax
80102059:	89 44 24 04          	mov    %eax,0x4(%esp)
8010205d:	e8 7e 02 00 00       	call   801022e0 <ioapicenable>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102062:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102067:	90                   	nop
80102068:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102069:	83 e0 c0             	and    $0xffffffc0,%eax
8010206c:	3c 40                	cmp    $0x40,%al
8010206e:	75 f8                	jne    80102068 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102070:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102075:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010207a:	ee                   	out    %al,(%dx)
8010207b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102080:	b2 f7                	mov    $0xf7,%dl
80102082:	eb 09                	jmp    8010208d <ideinit+0x5d>
80102084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<1000; i++){
80102088:	83 e9 01             	sub    $0x1,%ecx
8010208b:	74 0f                	je     8010209c <ideinit+0x6c>
8010208d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010208e:	84 c0                	test   %al,%al
80102090:	74 f6                	je     80102088 <ideinit+0x58>
      havedisk1 = 1;
80102092:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102099:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010209c:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020a1:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801020a6:	ee                   	out    %al,(%dx)
}
801020a7:	c9                   	leave  
801020a8:	c3                   	ret    
801020a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020b0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020b0:	55                   	push   %ebp
801020b1:	89 e5                	mov    %esp,%ebp
801020b3:	57                   	push   %edi
801020b4:	56                   	push   %esi
801020b5:	53                   	push   %ebx
801020b6:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020b9:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
801020c0:	e8 2b 27 00 00       	call   801047f0 <acquire>

  if((b = idequeue) == 0){
801020c5:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020cb:	85 db                	test   %ebx,%ebx
801020cd:	74 30                	je     801020ff <ideintr+0x4f>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020cf:	8b 43 58             	mov    0x58(%ebx),%eax
801020d2:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020d7:	8b 33                	mov    (%ebx),%esi
801020d9:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020df:	74 37                	je     80102118 <ideintr+0x68>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020e1:	83 e6 fb             	and    $0xfffffffb,%esi
801020e4:	83 ce 02             	or     $0x2,%esi
801020e7:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020e9:	89 1c 24             	mov    %ebx,(%esp)
801020ec:	e8 6f 21 00 00       	call   80104260 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020f1:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020f6:	85 c0                	test   %eax,%eax
801020f8:	74 05                	je     801020ff <ideintr+0x4f>
    idestart(idequeue);
801020fa:	e8 71 fe ff ff       	call   80101f70 <idestart>
    release(&idelock);
801020ff:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102106:	e8 55 27 00 00       	call   80104860 <release>

  release(&idelock);
}
8010210b:	83 c4 1c             	add    $0x1c,%esp
8010210e:	5b                   	pop    %ebx
8010210f:	5e                   	pop    %esi
80102110:	5f                   	pop    %edi
80102111:	5d                   	pop    %ebp
80102112:	c3                   	ret    
80102113:	90                   	nop
80102114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102118:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010211d:	8d 76 00             	lea    0x0(%esi),%esi
80102120:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102121:	89 c1                	mov    %eax,%ecx
80102123:	83 e1 c0             	and    $0xffffffc0,%ecx
80102126:	80 f9 40             	cmp    $0x40,%cl
80102129:	75 f5                	jne    80102120 <ideintr+0x70>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010212b:	a8 21                	test   $0x21,%al
8010212d:	75 b2                	jne    801020e1 <ideintr+0x31>
    insl(0x1f0, b->data, BSIZE/4);
8010212f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102132:	b9 80 00 00 00       	mov    $0x80,%ecx
80102137:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010213c:	fc                   	cld    
8010213d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010213f:	8b 33                	mov    (%ebx),%esi
80102141:	eb 9e                	jmp    801020e1 <ideintr+0x31>
80102143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102150 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	53                   	push   %ebx
80102154:	83 ec 14             	sub    $0x14,%esp
80102157:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010215a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010215d:	89 04 24             	mov    %eax,(%esp)
80102160:	e8 cb 24 00 00       	call   80104630 <holdingsleep>
80102165:	85 c0                	test   %eax,%eax
80102167:	0f 84 9e 00 00 00    	je     8010220b <iderw+0xbb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010216d:	8b 03                	mov    (%ebx),%eax
8010216f:	83 e0 06             	and    $0x6,%eax
80102172:	83 f8 02             	cmp    $0x2,%eax
80102175:	0f 84 a8 00 00 00    	je     80102223 <iderw+0xd3>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010217b:	8b 53 04             	mov    0x4(%ebx),%edx
8010217e:	85 d2                	test   %edx,%edx
80102180:	74 0d                	je     8010218f <iderw+0x3f>
80102182:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102187:	85 c0                	test   %eax,%eax
80102189:	0f 84 88 00 00 00    	je     80102217 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010218f:	c7 04 24 80 a5 10 80 	movl   $0x8010a580,(%esp)
80102196:	e8 55 26 00 00       	call   801047f0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219b:	a1 64 a5 10 80       	mov    0x8010a564,%eax
  b->qnext = 0;
801021a0:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021a7:	85 c0                	test   %eax,%eax
801021a9:	75 07                	jne    801021b2 <iderw+0x62>
801021ab:	eb 4e                	jmp    801021fb <iderw+0xab>
801021ad:	8d 76 00             	lea    0x0(%esi),%esi
801021b0:	89 d0                	mov    %edx,%eax
801021b2:	8b 50 58             	mov    0x58(%eax),%edx
801021b5:	85 d2                	test   %edx,%edx
801021b7:	75 f7                	jne    801021b0 <iderw+0x60>
801021b9:	83 c0 58             	add    $0x58,%eax
    ;
  *pp = b;
801021bc:	89 18                	mov    %ebx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
801021be:	39 1d 64 a5 10 80    	cmp    %ebx,0x8010a564
801021c4:	74 3c                	je     80102202 <iderw+0xb2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021c6:	8b 03                	mov    (%ebx),%eax
801021c8:	83 e0 06             	and    $0x6,%eax
801021cb:	83 f8 02             	cmp    $0x2,%eax
801021ce:	74 1a                	je     801021ea <iderw+0x9a>
    sleep(b, &idelock);
801021d0:	c7 44 24 04 80 a5 10 	movl   $0x8010a580,0x4(%esp)
801021d7:	80 
801021d8:	89 1c 24             	mov    %ebx,(%esp)
801021db:	e8 e0 1e 00 00       	call   801040c0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021e0:	8b 13                	mov    (%ebx),%edx
801021e2:	83 e2 06             	and    $0x6,%edx
801021e5:	83 fa 02             	cmp    $0x2,%edx
801021e8:	75 e6                	jne    801021d0 <iderw+0x80>
  }


  release(&idelock);
801021ea:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021f1:	83 c4 14             	add    $0x14,%esp
801021f4:	5b                   	pop    %ebx
801021f5:	5d                   	pop    %ebp
  release(&idelock);
801021f6:	e9 65 26 00 00       	jmp    80104860 <release>
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021fb:	b8 64 a5 10 80       	mov    $0x8010a564,%eax
80102200:	eb ba                	jmp    801021bc <iderw+0x6c>
    idestart(b);
80102202:	89 d8                	mov    %ebx,%eax
80102204:	e8 67 fd ff ff       	call   80101f70 <idestart>
80102209:	eb bb                	jmp    801021c6 <iderw+0x76>
    panic("iderw: buf not locked");
8010220b:	c7 04 24 6a 75 10 80 	movl   $0x8010756a,(%esp)
80102212:	e8 49 e1 ff ff       	call   80100360 <panic>
    panic("iderw: ide disk 1 not present");
80102217:	c7 04 24 95 75 10 80 	movl   $0x80107595,(%esp)
8010221e:	e8 3d e1 ff ff       	call   80100360 <panic>
    panic("iderw: nothing to do");
80102223:	c7 04 24 80 75 10 80 	movl   $0x80107580,(%esp)
8010222a:	e8 31 e1 ff ff       	call   80100360 <panic>
8010222f:	90                   	nop

80102230 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	56                   	push   %esi
80102234:	53                   	push   %ebx
80102235:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102238:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
8010223f:	00 c0 fe 
  ioapic->reg = reg;
80102242:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102249:	00 00 00 
  return ioapic->data;
8010224c:	8b 15 54 26 11 80    	mov    0x80112654,%edx
80102252:	8b 42 10             	mov    0x10(%edx),%eax
  ioapic->reg = reg;
80102255:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010225b:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102261:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102268:	c1 e8 10             	shr    $0x10,%eax
8010226b:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010226e:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102271:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102274:	39 c2                	cmp    %eax,%edx
80102276:	74 12                	je     8010228a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102278:	c7 04 24 b4 75 10 80 	movl   $0x801075b4,(%esp)
8010227f:	e8 cc e3 ff ff       	call   80100650 <cprintf>
80102284:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
8010228a:	ba 10 00 00 00       	mov    $0x10,%edx
8010228f:	31 c0                	xor    %eax,%eax
80102291:	eb 07                	jmp    8010229a <ioapicinit+0x6a>
80102293:	90                   	nop
80102294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102298:	89 cb                	mov    %ecx,%ebx
  ioapic->reg = reg;
8010229a:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010229c:	8b 1d 54 26 11 80    	mov    0x80112654,%ebx
801022a2:	8d 48 20             	lea    0x20(%eax),%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022a5:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  for(i = 0; i <= maxintr; i++){
801022ab:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022ae:	89 4b 10             	mov    %ecx,0x10(%ebx)
801022b1:	8d 4a 01             	lea    0x1(%edx),%ecx
801022b4:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801022b7:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801022b9:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
  for(i = 0; i <= maxintr; i++){
801022bf:	39 c6                	cmp    %eax,%esi
  ioapic->data = data;
801022c1:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022c8:	7d ce                	jge    80102298 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022ca:	83 c4 10             	add    $0x10,%esp
801022cd:	5b                   	pop    %ebx
801022ce:	5e                   	pop    %esi
801022cf:	5d                   	pop    %ebp
801022d0:	c3                   	ret    
801022d1:	eb 0d                	jmp    801022e0 <ioapicenable>
801022d3:	90                   	nop
801022d4:	90                   	nop
801022d5:	90                   	nop
801022d6:	90                   	nop
801022d7:	90                   	nop
801022d8:	90                   	nop
801022d9:	90                   	nop
801022da:	90                   	nop
801022db:	90                   	nop
801022dc:	90                   	nop
801022dd:	90                   	nop
801022de:	90                   	nop
801022df:	90                   	nop

801022e0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	8b 55 08             	mov    0x8(%ebp),%edx
801022e6:	53                   	push   %ebx
801022e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022ea:	8d 5a 20             	lea    0x20(%edx),%ebx
801022ed:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
  ioapic->reg = reg;
801022f1:	8b 15 54 26 11 80    	mov    0x80112654,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801022f7:	c1 e0 18             	shl    $0x18,%eax
  ioapic->reg = reg;
801022fa:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801022fc:	8b 15 54 26 11 80    	mov    0x80112654,%edx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102302:	83 c1 01             	add    $0x1,%ecx
  ioapic->data = data;
80102305:	89 5a 10             	mov    %ebx,0x10(%edx)
  ioapic->reg = reg;
80102308:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
8010230a:	8b 15 54 26 11 80    	mov    0x80112654,%edx
80102310:	89 42 10             	mov    %eax,0x10(%edx)
}
80102313:	5b                   	pop    %ebx
80102314:	5d                   	pop    %ebp
80102315:	c3                   	ret    
80102316:	66 90                	xchg   %ax,%ax
80102318:	66 90                	xchg   %ax,%ax
8010231a:	66 90                	xchg   %ax,%ax
8010231c:	66 90                	xchg   %ax,%ax
8010231e:	66 90                	xchg   %ax,%ax

80102320 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	53                   	push   %ebx
80102324:	83 ec 14             	sub    $0x14,%esp
80102327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010232a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102330:	75 7c                	jne    801023ae <kfree+0x8e>
80102332:	81 fb c8 59 11 80    	cmp    $0x801159c8,%ebx
80102338:	72 74                	jb     801023ae <kfree+0x8e>
8010233a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102340:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102345:	77 67                	ja     801023ae <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102347:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010234e:	00 
8010234f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102356:	00 
80102357:	89 1c 24             	mov    %ebx,(%esp)
8010235a:	e8 51 25 00 00       	call   801048b0 <memset>

  if(kmem.use_lock)
8010235f:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102365:	85 d2                	test   %edx,%edx
80102367:	75 37                	jne    801023a0 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102369:	a1 98 26 11 80       	mov    0x80112698,%eax
8010236e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102370:	a1 94 26 11 80       	mov    0x80112694,%eax
  kmem.freelist = r;
80102375:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
8010237b:	85 c0                	test   %eax,%eax
8010237d:	75 09                	jne    80102388 <kfree+0x68>
    release(&kmem.lock);
}
8010237f:	83 c4 14             	add    $0x14,%esp
80102382:	5b                   	pop    %ebx
80102383:	5d                   	pop    %ebp
80102384:	c3                   	ret    
80102385:	8d 76 00             	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102388:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
8010238f:	83 c4 14             	add    $0x14,%esp
80102392:	5b                   	pop    %ebx
80102393:	5d                   	pop    %ebp
    release(&kmem.lock);
80102394:	e9 c7 24 00 00       	jmp    80104860 <release>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&kmem.lock);
801023a0:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801023a7:	e8 44 24 00 00       	call   801047f0 <acquire>
801023ac:	eb bb                	jmp    80102369 <kfree+0x49>
    panic("kfree");
801023ae:	c7 04 24 e6 75 10 80 	movl   $0x801075e6,(%esp)
801023b5:	e8 a6 df ff ff       	call   80100360 <panic>
801023ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023c0 <freerange>:
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
801023c5:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
801023c8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023cb:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023ce:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801023d4:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023da:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801023e0:	39 de                	cmp    %ebx,%esi
801023e2:	73 08                	jae    801023ec <freerange+0x2c>
801023e4:	eb 18                	jmp    801023fe <freerange+0x3e>
801023e6:	66 90                	xchg   %ax,%ax
801023e8:	89 da                	mov    %ebx,%edx
801023ea:	89 c3                	mov    %eax,%ebx
    kfree(p);
801023ec:	89 14 24             	mov    %edx,(%esp)
801023ef:	e8 2c ff ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801023fa:	39 f0                	cmp    %esi,%eax
801023fc:	76 ea                	jbe    801023e8 <freerange+0x28>
}
801023fe:	83 c4 10             	add    $0x10,%esp
80102401:	5b                   	pop    %ebx
80102402:	5e                   	pop    %esi
80102403:	5d                   	pop    %ebp
80102404:	c3                   	ret    
80102405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102410 <kinit1>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	83 ec 10             	sub    $0x10,%esp
80102418:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010241b:	c7 44 24 04 ec 75 10 	movl   $0x801075ec,0x4(%esp)
80102422:	80 
80102423:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
8010242a:	e8 51 22 00 00       	call   80104680 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010242f:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 0;
80102432:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102439:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010243c:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102442:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102448:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
8010244e:	39 de                	cmp    %ebx,%esi
80102450:	73 0a                	jae    8010245c <kinit1+0x4c>
80102452:	eb 1a                	jmp    8010246e <kinit1+0x5e>
80102454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102458:	89 da                	mov    %ebx,%edx
8010245a:	89 c3                	mov    %eax,%ebx
    kfree(p);
8010245c:	89 14 24             	mov    %edx,(%esp)
8010245f:	e8 bc fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102464:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
8010246a:	39 c6                	cmp    %eax,%esi
8010246c:	73 ea                	jae    80102458 <kinit1+0x48>
}
8010246e:	83 c4 10             	add    $0x10,%esp
80102471:	5b                   	pop    %ebx
80102472:	5e                   	pop    %esi
80102473:	5d                   	pop    %ebp
80102474:	c3                   	ret    
80102475:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kinit2>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
80102485:	83 ec 10             	sub    $0x10,%esp
  p = (char*)PGROUNDUP((uint)vstart);
80102488:	8b 45 08             	mov    0x8(%ebp),%eax
{
8010248b:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010248e:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80102494:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010249a:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801024a0:	39 de                	cmp    %ebx,%esi
801024a2:	73 08                	jae    801024ac <kinit2+0x2c>
801024a4:	eb 18                	jmp    801024be <kinit2+0x3e>
801024a6:	66 90                	xchg   %ax,%ax
801024a8:	89 da                	mov    %ebx,%edx
801024aa:	89 c3                	mov    %eax,%ebx
    kfree(p);
801024ac:	89 14 24             	mov    %edx,(%esp)
801024af:	e8 6c fe ff ff       	call   80102320 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801024ba:	39 c6                	cmp    %eax,%esi
801024bc:	73 ea                	jae    801024a8 <kinit2+0x28>
  kmem.use_lock = 1;
801024be:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024c5:	00 00 00 
}
801024c8:	83 c4 10             	add    $0x10,%esp
801024cb:	5b                   	pop    %ebx
801024cc:	5e                   	pop    %esi
801024cd:	5d                   	pop    %ebp
801024ce:	c3                   	ret    
801024cf:	90                   	nop

801024d0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024d0:	55                   	push   %ebp
801024d1:	89 e5                	mov    %esp,%ebp
801024d3:	53                   	push   %ebx
801024d4:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
801024d7:	a1 94 26 11 80       	mov    0x80112694,%eax
801024dc:	85 c0                	test   %eax,%eax
801024de:	75 30                	jne    80102510 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024e0:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
801024e6:	85 db                	test   %ebx,%ebx
801024e8:	74 08                	je     801024f2 <kalloc+0x22>
    kmem.freelist = r->next;
801024ea:	8b 13                	mov    (%ebx),%edx
801024ec:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
801024f2:	85 c0                	test   %eax,%eax
801024f4:	74 0c                	je     80102502 <kalloc+0x32>
    release(&kmem.lock);
801024f6:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
801024fd:	e8 5e 23 00 00       	call   80104860 <release>
  return (char*)r;
}
80102502:	83 c4 14             	add    $0x14,%esp
80102505:	89 d8                	mov    %ebx,%eax
80102507:	5b                   	pop    %ebx
80102508:	5d                   	pop    %ebp
80102509:	c3                   	ret    
8010250a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
80102510:	c7 04 24 60 26 11 80 	movl   $0x80112660,(%esp)
80102517:	e8 d4 22 00 00       	call   801047f0 <acquire>
8010251c:	a1 94 26 11 80       	mov    0x80112694,%eax
80102521:	eb bd                	jmp    801024e0 <kalloc+0x10>
80102523:	66 90                	xchg   %ax,%ax
80102525:	66 90                	xchg   %ax,%ax
80102527:	66 90                	xchg   %ax,%ax
80102529:	66 90                	xchg   %ax,%ax
8010252b:	66 90                	xchg   %ax,%ax
8010252d:	66 90                	xchg   %ax,%ax
8010252f:	90                   	nop

80102530 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102530:	ba 64 00 00 00       	mov    $0x64,%edx
80102535:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102536:	a8 01                	test   $0x1,%al
80102538:	0f 84 ba 00 00 00    	je     801025f8 <kbdgetc+0xc8>
8010253e:	b2 60                	mov    $0x60,%dl
80102540:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102541:	0f b6 c8             	movzbl %al,%ecx

  if(data == 0xE0){
80102544:	81 f9 e0 00 00 00    	cmp    $0xe0,%ecx
8010254a:	0f 84 88 00 00 00    	je     801025d8 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102550:	84 c0                	test   %al,%al
80102552:	79 2c                	jns    80102580 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102554:	8b 15 b4 a5 10 80    	mov    0x8010a5b4,%edx
8010255a:	f6 c2 40             	test   $0x40,%dl
8010255d:	75 05                	jne    80102564 <kbdgetc+0x34>
8010255f:	89 c1                	mov    %eax,%ecx
80102561:	83 e1 7f             	and    $0x7f,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102564:	0f b6 81 20 77 10 80 	movzbl -0x7fef88e0(%ecx),%eax
8010256b:	83 c8 40             	or     $0x40,%eax
8010256e:	0f b6 c0             	movzbl %al,%eax
80102571:	f7 d0                	not    %eax
80102573:	21 d0                	and    %edx,%eax
80102575:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
8010257a:	31 c0                	xor    %eax,%eax
8010257c:	c3                   	ret    
8010257d:	8d 76 00             	lea    0x0(%esi),%esi
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	53                   	push   %ebx
80102584:	8b 1d b4 a5 10 80    	mov    0x8010a5b4,%ebx
  } else if(shift & E0ESC){
8010258a:	f6 c3 40             	test   $0x40,%bl
8010258d:	74 09                	je     80102598 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010258f:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102592:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102595:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102598:	0f b6 91 20 77 10 80 	movzbl -0x7fef88e0(%ecx),%edx
  shift ^= togglecode[data];
8010259f:	0f b6 81 20 76 10 80 	movzbl -0x7fef89e0(%ecx),%eax
  shift |= shiftcode[data];
801025a6:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801025a8:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801025aa:	89 d0                	mov    %edx,%eax
801025ac:	83 e0 03             	and    $0x3,%eax
801025af:	8b 04 85 00 76 10 80 	mov    -0x7fef8a00(,%eax,4),%eax
  shift ^= togglecode[data];
801025b6:	89 15 b4 a5 10 80    	mov    %edx,0x8010a5b4
  if(shift & CAPSLOCK){
801025bc:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801025bf:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
801025c3:	74 0b                	je     801025d0 <kbdgetc+0xa0>
    if('a' <= c && c <= 'z')
801025c5:	8d 50 9f             	lea    -0x61(%eax),%edx
801025c8:	83 fa 19             	cmp    $0x19,%edx
801025cb:	77 1b                	ja     801025e8 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025cd:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025d0:	5b                   	pop    %ebx
801025d1:	5d                   	pop    %ebp
801025d2:	c3                   	ret    
801025d3:	90                   	nop
801025d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025d8:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
    return 0;
801025df:	31 c0                	xor    %eax,%eax
801025e1:	c3                   	ret    
801025e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801025e8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801025eb:	8d 50 20             	lea    0x20(%eax),%edx
801025ee:	83 f9 19             	cmp    $0x19,%ecx
801025f1:	0f 46 c2             	cmovbe %edx,%eax
  return c;
801025f4:	eb da                	jmp    801025d0 <kbdgetc+0xa0>
801025f6:	66 90                	xchg   %ax,%ax
    return -1;
801025f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025fd:	c3                   	ret    
801025fe:	66 90                	xchg   %ax,%ax

80102600 <kbdintr>:

void
kbdintr(void)
{
80102600:	55                   	push   %ebp
80102601:	89 e5                	mov    %esp,%ebp
80102603:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
80102606:	c7 04 24 30 25 10 80 	movl   $0x80102530,(%esp)
8010260d:	e8 be e1 ff ff       	call   801007d0 <consoleintr>
}
80102612:	c9                   	leave  
80102613:	c3                   	ret    
80102614:	66 90                	xchg   %ax,%ax
80102616:	66 90                	xchg   %ax,%ax
80102618:	66 90                	xchg   %ax,%ax
8010261a:	66 90                	xchg   %ax,%ax
8010261c:	66 90                	xchg   %ax,%ax
8010261e:	66 90                	xchg   %ax,%ax

80102620 <fill_rtcdate>:
  return inb(CMOS_RETURN);
}

static void
fill_rtcdate(struct rtcdate *r)
{
80102620:	55                   	push   %ebp
80102621:	89 c1                	mov    %eax,%ecx
80102623:	89 e5                	mov    %esp,%ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102625:	ba 70 00 00 00       	mov    $0x70,%edx
8010262a:	53                   	push   %ebx
8010262b:	31 c0                	xor    %eax,%eax
8010262d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010262e:	bb 71 00 00 00       	mov    $0x71,%ebx
80102633:	89 da                	mov    %ebx,%edx
80102635:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
80102636:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102639:	b2 70                	mov    $0x70,%dl
8010263b:	89 01                	mov    %eax,(%ecx)
8010263d:	b8 02 00 00 00       	mov    $0x2,%eax
80102642:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102643:	89 da                	mov    %ebx,%edx
80102645:	ec                   	in     (%dx),%al
80102646:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102649:	b2 70                	mov    $0x70,%dl
8010264b:	89 41 04             	mov    %eax,0x4(%ecx)
8010264e:	b8 04 00 00 00       	mov    $0x4,%eax
80102653:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102654:	89 da                	mov    %ebx,%edx
80102656:	ec                   	in     (%dx),%al
80102657:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010265a:	b2 70                	mov    $0x70,%dl
8010265c:	89 41 08             	mov    %eax,0x8(%ecx)
8010265f:	b8 07 00 00 00       	mov    $0x7,%eax
80102664:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102665:	89 da                	mov    %ebx,%edx
80102667:	ec                   	in     (%dx),%al
80102668:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010266b:	b2 70                	mov    $0x70,%dl
8010266d:	89 41 0c             	mov    %eax,0xc(%ecx)
80102670:	b8 08 00 00 00       	mov    $0x8,%eax
80102675:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102676:	89 da                	mov    %ebx,%edx
80102678:	ec                   	in     (%dx),%al
80102679:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010267c:	b2 70                	mov    $0x70,%dl
8010267e:	89 41 10             	mov    %eax,0x10(%ecx)
80102681:	b8 09 00 00 00       	mov    $0x9,%eax
80102686:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102687:	89 da                	mov    %ebx,%edx
80102689:	ec                   	in     (%dx),%al
8010268a:	0f b6 d8             	movzbl %al,%ebx
8010268d:	89 59 14             	mov    %ebx,0x14(%ecx)
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
}
80102690:	5b                   	pop    %ebx
80102691:	5d                   	pop    %ebp
80102692:	c3                   	ret    
80102693:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026a0 <lapicinit>:
  if(!lapic)
801026a0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
801026a5:	55                   	push   %ebp
801026a6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801026a8:	85 c0                	test   %eax,%eax
801026aa:	0f 84 c0 00 00 00    	je     80102770 <lapicinit+0xd0>
  lapic[index] = value;
801026b0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801026b7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ba:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026bd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801026c4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ca:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026d1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026de:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026eb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026f1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026fb:	8b 50 20             	mov    0x20(%eax),%edx
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026fe:	8b 50 30             	mov    0x30(%eax),%edx
80102701:	c1 ea 10             	shr    $0x10,%edx
80102704:	80 fa 03             	cmp    $0x3,%dl
80102707:	77 6f                	ja     80102778 <lapicinit+0xd8>
  lapic[index] = value;
80102709:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102710:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102713:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102716:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010271d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102720:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102723:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010272a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010272d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102730:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102737:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010273d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102744:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102747:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010274a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102751:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102754:	8b 50 20             	mov    0x20(%eax),%edx
80102757:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
80102758:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010275e:	80 e6 10             	and    $0x10,%dh
80102761:	75 f5                	jne    80102758 <lapicinit+0xb8>
  lapic[index] = value;
80102763:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010276a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010276d:	8b 40 20             	mov    0x20(%eax),%eax
}
80102770:	5d                   	pop    %ebp
80102771:	c3                   	ret    
80102772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102778:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010277f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102782:	8b 50 20             	mov    0x20(%eax),%edx
80102785:	eb 82                	jmp    80102709 <lapicinit+0x69>
80102787:	89 f6                	mov    %esi,%esi
80102789:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102790 <lapicid>:
  if (!lapic)
80102790:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
80102795:	55                   	push   %ebp
80102796:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102798:	85 c0                	test   %eax,%eax
8010279a:	74 0c                	je     801027a8 <lapicid+0x18>
  return lapic[ID] >> 24;
8010279c:	8b 40 20             	mov    0x20(%eax),%eax
}
8010279f:	5d                   	pop    %ebp
  return lapic[ID] >> 24;
801027a0:	c1 e8 18             	shr    $0x18,%eax
}
801027a3:	c3                   	ret    
801027a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801027a8:	31 c0                	xor    %eax,%eax
}
801027aa:	5d                   	pop    %ebp
801027ab:	c3                   	ret    
801027ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027b0 <lapiceoi>:
  if(lapic)
801027b0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
{
801027b5:	55                   	push   %ebp
801027b6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801027b8:	85 c0                	test   %eax,%eax
801027ba:	74 0d                	je     801027c9 <lapiceoi+0x19>
  lapic[index] = value;
801027bc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027c3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027c6:	8b 40 20             	mov    0x20(%eax),%eax
}
801027c9:	5d                   	pop    %ebp
801027ca:	c3                   	ret    
801027cb:	90                   	nop
801027cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027d0 <microdelay>:
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
}
801027d3:	5d                   	pop    %ebp
801027d4:	c3                   	ret    
801027d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027e0 <lapicstartap>:
{
801027e0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027e1:	ba 70 00 00 00       	mov    $0x70,%edx
801027e6:	89 e5                	mov    %esp,%ebp
801027e8:	b8 0f 00 00 00       	mov    $0xf,%eax
801027ed:	53                   	push   %ebx
801027ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
801027f1:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801027f4:	ee                   	out    %al,(%dx)
801027f5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027fa:	b2 71                	mov    $0x71,%dl
801027fc:	ee                   	out    %al,(%dx)
  wrv[0] = 0;
801027fd:	31 c0                	xor    %eax,%eax
801027ff:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102805:	89 d8                	mov    %ebx,%eax
80102807:	c1 e8 04             	shr    $0x4,%eax
8010280a:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102810:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  lapicw(ICRHI, apicid<<24);
80102815:	c1 e1 18             	shl    $0x18,%ecx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102818:	c1 eb 0c             	shr    $0xc,%ebx
  lapic[index] = value;
8010281b:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102821:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102824:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
8010282b:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102838:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283e:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102844:	8b 50 20             	mov    0x20(%eax),%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
80102847:	89 da                	mov    %ebx,%edx
80102849:	80 ce 06             	or     $0x6,%dh
  lapic[index] = value;
8010284c:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102852:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102855:	89 88 10 03 00 00    	mov    %ecx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010285b:	8b 48 20             	mov    0x20(%eax),%ecx
  lapic[index] = value;
8010285e:	89 90 00 03 00 00    	mov    %edx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102864:	8b 40 20             	mov    0x20(%eax),%eax
}
80102867:	5b                   	pop    %ebx
80102868:	5d                   	pop    %ebp
80102869:	c3                   	ret    
8010286a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102870 <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102870:	55                   	push   %ebp
80102871:	ba 70 00 00 00       	mov    $0x70,%edx
80102876:	89 e5                	mov    %esp,%ebp
80102878:	b8 0b 00 00 00       	mov    $0xb,%eax
8010287d:	57                   	push   %edi
8010287e:	56                   	push   %esi
8010287f:	53                   	push   %ebx
80102880:	83 ec 4c             	sub    $0x4c,%esp
80102883:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102884:	b2 71                	mov    $0x71,%dl
80102886:	ec                   	in     (%dx),%al
80102887:	88 45 b7             	mov    %al,-0x49(%ebp)
8010288a:	8d 5d b8             	lea    -0x48(%ebp),%ebx
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
8010288d:	80 65 b7 04          	andb   $0x4,-0x49(%ebp)
80102891:	8d 7d d0             	lea    -0x30(%ebp),%edi
80102894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102898:	be 70 00 00 00       	mov    $0x70,%esi

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
8010289d:	89 d8                	mov    %ebx,%eax
8010289f:	e8 7c fd ff ff       	call   80102620 <fill_rtcdate>
801028a4:	b8 0a 00 00 00       	mov    $0xa,%eax
801028a9:	89 f2                	mov    %esi,%edx
801028ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ac:	ba 71 00 00 00       	mov    $0x71,%edx
801028b1:	ec                   	in     (%dx),%al
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028b2:	84 c0                	test   %al,%al
801028b4:	78 e7                	js     8010289d <cmostime+0x2d>
        continue;
    fill_rtcdate(&t2);
801028b6:	89 f8                	mov    %edi,%eax
801028b8:	e8 63 fd ff ff       	call   80102620 <fill_rtcdate>
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801028bd:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
801028c4:	00 
801028c5:	89 7c 24 04          	mov    %edi,0x4(%esp)
801028c9:	89 1c 24             	mov    %ebx,(%esp)
801028cc:	e8 2f 20 00 00       	call   80104900 <memcmp>
801028d1:	85 c0                	test   %eax,%eax
801028d3:	75 c3                	jne    80102898 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801028d5:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801028d9:	75 78                	jne    80102953 <cmostime+0xe3>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801028db:	8b 45 b8             	mov    -0x48(%ebp),%eax
801028de:	89 c2                	mov    %eax,%edx
801028e0:	83 e0 0f             	and    $0xf,%eax
801028e3:	c1 ea 04             	shr    $0x4,%edx
801028e6:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028e9:	8d 04 50             	lea    (%eax,%edx,2),%eax
801028ec:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801028ef:	8b 45 bc             	mov    -0x44(%ebp),%eax
801028f2:	89 c2                	mov    %eax,%edx
801028f4:	83 e0 0f             	and    $0xf,%eax
801028f7:	c1 ea 04             	shr    $0x4,%edx
801028fa:	8d 14 92             	lea    (%edx,%edx,4),%edx
801028fd:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102900:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102903:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102906:	89 c2                	mov    %eax,%edx
80102908:	83 e0 0f             	and    $0xf,%eax
8010290b:	c1 ea 04             	shr    $0x4,%edx
8010290e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102911:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102914:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102917:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010291a:	89 c2                	mov    %eax,%edx
8010291c:	83 e0 0f             	and    $0xf,%eax
8010291f:	c1 ea 04             	shr    $0x4,%edx
80102922:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102925:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102928:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010292b:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010292e:	89 c2                	mov    %eax,%edx
80102930:	83 e0 0f             	and    $0xf,%eax
80102933:	c1 ea 04             	shr    $0x4,%edx
80102936:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102939:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010293c:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
8010293f:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102942:	89 c2                	mov    %eax,%edx
80102944:	83 e0 0f             	and    $0xf,%eax
80102947:	c1 ea 04             	shr    $0x4,%edx
8010294a:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010294d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102950:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102953:	8b 4d 08             	mov    0x8(%ebp),%ecx
80102956:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102959:	89 01                	mov    %eax,(%ecx)
8010295b:	8b 45 bc             	mov    -0x44(%ebp),%eax
8010295e:	89 41 04             	mov    %eax,0x4(%ecx)
80102961:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102964:	89 41 08             	mov    %eax,0x8(%ecx)
80102967:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010296a:	89 41 0c             	mov    %eax,0xc(%ecx)
8010296d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102970:	89 41 10             	mov    %eax,0x10(%ecx)
80102973:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102976:	89 41 14             	mov    %eax,0x14(%ecx)
  r->year += 2000;
80102979:	81 41 14 d0 07 00 00 	addl   $0x7d0,0x14(%ecx)
}
80102980:	83 c4 4c             	add    $0x4c,%esp
80102983:	5b                   	pop    %ebx
80102984:	5e                   	pop    %esi
80102985:	5f                   	pop    %edi
80102986:	5d                   	pop    %ebp
80102987:	c3                   	ret    
80102988:	66 90                	xchg   %ax,%ax
8010298a:	66 90                	xchg   %ax,%ax
8010298c:	66 90                	xchg   %ax,%ax
8010298e:	66 90                	xchg   %ax,%ax

80102990 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	57                   	push   %edi
80102994:	56                   	push   %esi
80102995:	53                   	push   %ebx
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102996:	31 db                	xor    %ebx,%ebx
{
80102998:	83 ec 1c             	sub    $0x1c,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
8010299b:	a1 e8 26 11 80       	mov    0x801126e8,%eax
801029a0:	85 c0                	test   %eax,%eax
801029a2:	7e 78                	jle    80102a1c <install_trans+0x8c>
801029a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801029a8:	a1 d4 26 11 80       	mov    0x801126d4,%eax
801029ad:	01 d8                	add    %ebx,%eax
801029af:	83 c0 01             	add    $0x1,%eax
801029b2:	89 44 24 04          	mov    %eax,0x4(%esp)
801029b6:	a1 e4 26 11 80       	mov    0x801126e4,%eax
801029bb:	89 04 24             	mov    %eax,(%esp)
801029be:	e8 0d d7 ff ff       	call   801000d0 <bread>
801029c3:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029c5:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
801029cc:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029cf:	89 44 24 04          	mov    %eax,0x4(%esp)
801029d3:	a1 e4 26 11 80       	mov    0x801126e4,%eax
801029d8:	89 04 24             	mov    %eax,(%esp)
801029db:	e8 f0 d6 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029e0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801029e7:	00 
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801029e8:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801029ea:	8d 47 5c             	lea    0x5c(%edi),%eax
801029ed:	89 44 24 04          	mov    %eax,0x4(%esp)
801029f1:	8d 46 5c             	lea    0x5c(%esi),%eax
801029f4:	89 04 24             	mov    %eax,(%esp)
801029f7:	e8 54 1f 00 00       	call   80104950 <memmove>
    bwrite(dbuf);  // write dst to disk
801029fc:	89 34 24             	mov    %esi,(%esp)
801029ff:	e8 9c d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a04:	89 3c 24             	mov    %edi,(%esp)
80102a07:	e8 d4 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a0c:	89 34 24             	mov    %esi,(%esp)
80102a0f:	e8 cc d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102a14:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102a1a:	7f 8c                	jg     801029a8 <install_trans+0x18>
  }
}
80102a1c:	83 c4 1c             	add    $0x1c,%esp
80102a1f:	5b                   	pop    %ebx
80102a20:	5e                   	pop    %esi
80102a21:	5f                   	pop    %edi
80102a22:	5d                   	pop    %ebp
80102a23:	c3                   	ret    
80102a24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102a2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102a30 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102a30:	55                   	push   %ebp
80102a31:	89 e5                	mov    %esp,%ebp
80102a33:	57                   	push   %edi
80102a34:	56                   	push   %esi
80102a35:	53                   	push   %ebx
80102a36:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102a39:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102a3e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102a42:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102a47:	89 04 24             	mov    %eax,(%esp)
80102a4a:	e8 81 d6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102a4f:	8b 1d e8 26 11 80    	mov    0x801126e8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102a55:	31 d2                	xor    %edx,%edx
80102a57:	85 db                	test   %ebx,%ebx
  struct buf *buf = bread(log.dev, log.start);
80102a59:	89 c7                	mov    %eax,%edi
  hb->n = log.lh.n;
80102a5b:	89 58 5c             	mov    %ebx,0x5c(%eax)
80102a5e:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102a61:	7e 17                	jle    80102a7a <write_head+0x4a>
80102a63:	90                   	nop
80102a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102a68:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102a6f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102a73:	83 c2 01             	add    $0x1,%edx
80102a76:	39 da                	cmp    %ebx,%edx
80102a78:	75 ee                	jne    80102a68 <write_head+0x38>
  }
  bwrite(buf);
80102a7a:	89 3c 24             	mov    %edi,(%esp)
80102a7d:	e8 1e d7 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102a82:	89 3c 24             	mov    %edi,(%esp)
80102a85:	e8 56 d7 ff ff       	call   801001e0 <brelse>
}
80102a8a:	83 c4 1c             	add    $0x1c,%esp
80102a8d:	5b                   	pop    %ebx
80102a8e:	5e                   	pop    %esi
80102a8f:	5f                   	pop    %edi
80102a90:	5d                   	pop    %ebp
80102a91:	c3                   	ret    
80102a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102aa0 <initlog>:
{
80102aa0:	55                   	push   %ebp
80102aa1:	89 e5                	mov    %esp,%ebp
80102aa3:	56                   	push   %esi
80102aa4:	53                   	push   %ebx
80102aa5:	83 ec 30             	sub    $0x30,%esp
80102aa8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102aab:	c7 44 24 04 20 78 10 	movl   $0x80107820,0x4(%esp)
80102ab2:	80 
80102ab3:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102aba:	e8 c1 1b 00 00       	call   80104680 <initlock>
  readsb(dev, &sb);
80102abf:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102ac2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ac6:	89 1c 24             	mov    %ebx,(%esp)
80102ac9:	e8 f2 e8 ff ff       	call   801013c0 <readsb>
  log.start = sb.logstart;
80102ace:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102ad1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  struct buf *buf = bread(log.dev, log.start);
80102ad4:	89 1c 24             	mov    %ebx,(%esp)
  log.dev = dev;
80102ad7:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  struct buf *buf = bread(log.dev, log.start);
80102add:	89 44 24 04          	mov    %eax,0x4(%esp)
  log.size = sb.nlog;
80102ae1:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  log.start = sb.logstart;
80102ae7:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  struct buf *buf = bread(log.dev, log.start);
80102aec:	e8 df d5 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102af1:	31 d2                	xor    %edx,%edx
  log.lh.n = lh->n;
80102af3:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102af6:	8d 70 5c             	lea    0x5c(%eax),%esi
  for (i = 0; i < log.lh.n; i++) {
80102af9:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102afb:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102b01:	7e 17                	jle    80102b1a <initlog+0x7a>
80102b03:	90                   	nop
80102b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102b08:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102b0c:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102b13:	83 c2 01             	add    $0x1,%edx
80102b16:	39 da                	cmp    %ebx,%edx
80102b18:	75 ee                	jne    80102b08 <initlog+0x68>
  brelse(buf);
80102b1a:	89 04 24             	mov    %eax,(%esp)
80102b1d:	e8 be d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b22:	e8 69 fe ff ff       	call   80102990 <install_trans>
  log.lh.n = 0;
80102b27:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102b2e:	00 00 00 
  write_head(); // clear the log
80102b31:	e8 fa fe ff ff       	call   80102a30 <write_head>
}
80102b36:	83 c4 30             	add    $0x30,%esp
80102b39:	5b                   	pop    %ebx
80102b3a:	5e                   	pop    %esi
80102b3b:	5d                   	pop    %ebp
80102b3c:	c3                   	ret    
80102b3d:	8d 76 00             	lea    0x0(%esi),%esi

80102b40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102b40:	55                   	push   %ebp
80102b41:	89 e5                	mov    %esp,%ebp
80102b43:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102b46:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102b4d:	e8 9e 1c 00 00       	call   801047f0 <acquire>
80102b52:	eb 18                	jmp    80102b6c <begin_op+0x2c>
80102b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102b58:	c7 44 24 04 a0 26 11 	movl   $0x801126a0,0x4(%esp)
80102b5f:	80 
80102b60:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102b67:	e8 54 15 00 00       	call   801040c0 <sleep>
    if(log.committing){
80102b6c:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102b71:	85 c0                	test   %eax,%eax
80102b73:	75 e3                	jne    80102b58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102b75:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102b7a:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102b80:	83 c0 01             	add    $0x1,%eax
80102b83:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102b86:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102b89:	83 fa 1e             	cmp    $0x1e,%edx
80102b8c:	7f ca                	jg     80102b58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102b8e:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
      log.outstanding += 1;
80102b95:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102b9a:	e8 c1 1c 00 00       	call   80104860 <release>
      break;
    }
  }
}
80102b9f:	c9                   	leave  
80102ba0:	c3                   	ret    
80102ba1:	eb 0d                	jmp    80102bb0 <end_op>
80102ba3:	90                   	nop
80102ba4:	90                   	nop
80102ba5:	90                   	nop
80102ba6:	90                   	nop
80102ba7:	90                   	nop
80102ba8:	90                   	nop
80102ba9:	90                   	nop
80102baa:	90                   	nop
80102bab:	90                   	nop
80102bac:	90                   	nop
80102bad:	90                   	nop
80102bae:	90                   	nop
80102baf:	90                   	nop

80102bb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	57                   	push   %edi
80102bb4:	56                   	push   %esi
80102bb5:	53                   	push   %ebx
80102bb6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102bb9:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102bc0:	e8 2b 1c 00 00       	call   801047f0 <acquire>
  log.outstanding -= 1;
80102bc5:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102bca:	8b 15 e0 26 11 80    	mov    0x801126e0,%edx
  log.outstanding -= 1;
80102bd0:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102bd3:	85 d2                	test   %edx,%edx
  log.outstanding -= 1;
80102bd5:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102bda:	0f 85 f3 00 00 00    	jne    80102cd3 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102be0:	85 c0                	test   %eax,%eax
80102be2:	0f 85 cb 00 00 00    	jne    80102cb3 <end_op+0x103>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102be8:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
}

static void
commit()
{
  if (log.lh.n > 0) {
80102bef:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
80102bf1:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102bf8:	00 00 00 
  release(&log.lock);
80102bfb:	e8 60 1c 00 00       	call   80104860 <release>
  if (log.lh.n > 0) {
80102c00:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c05:	85 c0                	test   %eax,%eax
80102c07:	0f 8e 90 00 00 00    	jle    80102c9d <end_op+0xed>
80102c0d:	8d 76 00             	lea    0x0(%esi),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c10:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102c15:	01 d8                	add    %ebx,%eax
80102c17:	83 c0 01             	add    $0x1,%eax
80102c1a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c1e:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102c23:	89 04 24             	mov    %eax,(%esp)
80102c26:	e8 a5 d4 ff ff       	call   801000d0 <bread>
80102c2b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c2d:	8b 04 9d ec 26 11 80 	mov    -0x7feed914(,%ebx,4),%eax
  for (tail = 0; tail < log.lh.n; tail++) {
80102c34:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c37:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c3b:	a1 e4 26 11 80       	mov    0x801126e4,%eax
80102c40:	89 04 24             	mov    %eax,(%esp)
80102c43:	e8 88 d4 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102c48:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102c4f:	00 
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102c50:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102c52:	8d 40 5c             	lea    0x5c(%eax),%eax
80102c55:	89 44 24 04          	mov    %eax,0x4(%esp)
80102c59:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c5c:	89 04 24             	mov    %eax,(%esp)
80102c5f:	e8 ec 1c 00 00       	call   80104950 <memmove>
    bwrite(to);  // write the log
80102c64:	89 34 24             	mov    %esi,(%esp)
80102c67:	e8 34 d5 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102c6c:	89 3c 24             	mov    %edi,(%esp)
80102c6f:	e8 6c d5 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102c74:	89 34 24             	mov    %esi,(%esp)
80102c77:	e8 64 d5 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c7c:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102c82:	7c 8c                	jl     80102c10 <end_op+0x60>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102c84:	e8 a7 fd ff ff       	call   80102a30 <write_head>
    install_trans(); // Now install writes to home locations
80102c89:	e8 02 fd ff ff       	call   80102990 <install_trans>
    log.lh.n = 0;
80102c8e:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102c95:	00 00 00 
    write_head();    // Erase the transaction from the log
80102c98:	e8 93 fd ff ff       	call   80102a30 <write_head>
    acquire(&log.lock);
80102c9d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102ca4:	e8 47 1b 00 00       	call   801047f0 <acquire>
    log.committing = 0;
80102ca9:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102cb0:	00 00 00 
    wakeup(&log);
80102cb3:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102cba:	e8 a1 15 00 00       	call   80104260 <wakeup>
    release(&log.lock);
80102cbf:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102cc6:	e8 95 1b 00 00       	call   80104860 <release>
}
80102ccb:	83 c4 1c             	add    $0x1c,%esp
80102cce:	5b                   	pop    %ebx
80102ccf:	5e                   	pop    %esi
80102cd0:	5f                   	pop    %edi
80102cd1:	5d                   	pop    %ebp
80102cd2:	c3                   	ret    
    panic("log.committing");
80102cd3:	c7 04 24 24 78 10 80 	movl   $0x80107824,(%esp)
80102cda:	e8 81 d6 ff ff       	call   80100360 <panic>
80102cdf:	90                   	nop

80102ce0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ce0:	55                   	push   %ebp
80102ce1:	89 e5                	mov    %esp,%ebp
80102ce3:	53                   	push   %ebx
80102ce4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ce7:	a1 e8 26 11 80       	mov    0x801126e8,%eax
{
80102cec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102cef:	83 f8 1d             	cmp    $0x1d,%eax
80102cf2:	0f 8f 98 00 00 00    	jg     80102d90 <log_write+0xb0>
80102cf8:	8b 0d d8 26 11 80    	mov    0x801126d8,%ecx
80102cfe:	8d 51 ff             	lea    -0x1(%ecx),%edx
80102d01:	39 d0                	cmp    %edx,%eax
80102d03:	0f 8d 87 00 00 00    	jge    80102d90 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102d09:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d0e:	85 c0                	test   %eax,%eax
80102d10:	0f 8e 86 00 00 00    	jle    80102d9c <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102d16:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102d1d:	e8 ce 1a 00 00       	call   801047f0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102d22:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102d28:	83 fa 00             	cmp    $0x0,%edx
80102d2b:	7e 54                	jle    80102d81 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d2d:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102d30:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102d32:	39 0d ec 26 11 80    	cmp    %ecx,0x801126ec
80102d38:	75 0f                	jne    80102d49 <log_write+0x69>
80102d3a:	eb 3c                	jmp    80102d78 <log_write+0x98>
80102d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d40:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102d47:	74 2f                	je     80102d78 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102d49:	83 c0 01             	add    $0x1,%eax
80102d4c:	39 d0                	cmp    %edx,%eax
80102d4e:	75 f0                	jne    80102d40 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102d50:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102d57:	83 c2 01             	add    $0x1,%edx
80102d5a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102d60:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102d63:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102d6a:	83 c4 14             	add    $0x14,%esp
80102d6d:	5b                   	pop    %ebx
80102d6e:	5d                   	pop    %ebp
  release(&log.lock);
80102d6f:	e9 ec 1a 00 00       	jmp    80104860 <release>
80102d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  log.lh.block[i] = b->blockno;
80102d78:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102d7f:	eb df                	jmp    80102d60 <log_write+0x80>
80102d81:	8b 43 08             	mov    0x8(%ebx),%eax
80102d84:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102d89:	75 d5                	jne    80102d60 <log_write+0x80>
80102d8b:	eb ca                	jmp    80102d57 <log_write+0x77>
80102d8d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("too big a transaction");
80102d90:	c7 04 24 33 78 10 80 	movl   $0x80107833,(%esp)
80102d97:	e8 c4 d5 ff ff       	call   80100360 <panic>
    panic("log_write outside of trans");
80102d9c:	c7 04 24 49 78 10 80 	movl   $0x80107849,(%esp)
80102da3:	e8 b8 d5 ff ff       	call   80100360 <panic>
80102da8:	66 90                	xchg   %ax,%ax
80102daa:	66 90                	xchg   %ax,%ax
80102dac:	66 90                	xchg   %ax,%ax
80102dae:	66 90                	xchg   %ax,%ax

80102db0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	53                   	push   %ebx
80102db4:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102db7:	e8 34 09 00 00       	call   801036f0 <cpuid>
80102dbc:	89 c3                	mov    %eax,%ebx
80102dbe:	e8 2d 09 00 00       	call   801036f0 <cpuid>
80102dc3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102dc7:	c7 04 24 64 78 10 80 	movl   $0x80107864,(%esp)
80102dce:	89 44 24 04          	mov    %eax,0x4(%esp)
80102dd2:	e8 79 d8 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102dd7:	e8 44 2e 00 00       	call   80105c20 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102ddc:	e8 8f 08 00 00       	call   80103670 <mycpu>
80102de1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102de3:	b8 01 00 00 00       	mov    $0x1,%eax
80102de8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102def:	e8 ec 0d 00 00       	call   80103be0 <scheduler>
80102df4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102dfa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102e00 <mpenter>:
{
80102e00:	55                   	push   %ebp
80102e01:	89 e5                	mov    %esp,%ebp
80102e03:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102e06:	e8 d5 3e 00 00       	call   80106ce0 <switchkvm>
  seginit();
80102e0b:	e8 10 3e 00 00       	call   80106c20 <seginit>
  lapicinit();
80102e10:	e8 8b f8 ff ff       	call   801026a0 <lapicinit>
  mpmain();
80102e15:	e8 96 ff ff ff       	call   80102db0 <mpmain>
80102e1a:	66 90                	xchg   %ax,%ax
80102e1c:	66 90                	xchg   %ax,%ax
80102e1e:	66 90                	xchg   %ax,%ax

80102e20 <main>:
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102e24:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
{
80102e29:	83 e4 f0             	and    $0xfffffff0,%esp
80102e2c:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102e2f:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102e36:	80 
80102e37:	c7 04 24 c8 59 11 80 	movl   $0x801159c8,(%esp)
80102e3e:	e8 cd f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102e43:	e8 28 43 00 00       	call   80107170 <kvmalloc>
  mpinit();        // detect other processors
80102e48:	e8 73 01 00 00       	call   80102fc0 <mpinit>
80102e4d:	8d 76 00             	lea    0x0(%esi),%esi
  lapicinit();     // interrupt controller
80102e50:	e8 4b f8 ff ff       	call   801026a0 <lapicinit>
  seginit();       // segment descriptors
80102e55:	e8 c6 3d 00 00       	call   80106c20 <seginit>
  picinit();       // disable pic
80102e5a:	e8 21 03 00 00       	call   80103180 <picinit>
80102e5f:	90                   	nop
  ioapicinit();    // another interrupt controller
80102e60:	e8 cb f3 ff ff       	call   80102230 <ioapicinit>
  consoleinit();   // console hardware
80102e65:	e8 06 db ff ff       	call   80100970 <consoleinit>
  uartinit();      // serial port
80102e6a:	e8 d1 30 00 00       	call   80105f40 <uartinit>
80102e6f:	90                   	nop
  pinit();         // process table
80102e70:	e8 db 07 00 00       	call   80103650 <pinit>
  tvinit();        // trap vectors
80102e75:	e8 06 2d 00 00       	call   80105b80 <tvinit>
  binit();         // buffer cache
80102e7a:	e8 c1 d1 ff ff       	call   80100040 <binit>
80102e7f:	90                   	nop
  fileinit();      // file table
80102e80:	e8 eb de ff ff       	call   80100d70 <fileinit>
  ideinit();       // disk 
80102e85:	e8 a6 f1 ff ff       	call   80102030 <ideinit>
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102e8a:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102e91:	00 
80102e92:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102e99:	80 
80102e9a:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102ea1:	e8 aa 1a 00 00       	call   80104950 <memmove>
  for(c = cpus; c < cpus+ncpu; c++){
80102ea6:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80102ead:	00 00 00 
80102eb0:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102eb5:	39 d8                	cmp    %ebx,%eax
80102eb7:	76 6a                	jbe    80102f23 <main+0x103>
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102ec0:	e8 ab 07 00 00       	call   80103670 <mycpu>
80102ec5:	39 d8                	cmp    %ebx,%eax
80102ec7:	74 41                	je     80102f0a <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102ec9:	e8 02 f6 ff ff       	call   801024d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102ece:	c7 05 f8 6f 00 80 00 	movl   $0x80102e00,0x80006ff8
80102ed5:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102ed8:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102edf:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102ee2:	05 00 10 00 00       	add    $0x1000,%eax
80102ee7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102eec:	0f b6 03             	movzbl (%ebx),%eax
80102eef:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102ef6:	00 
80102ef7:	89 04 24             	mov    %eax,(%esp)
80102efa:	e8 e1 f8 ff ff       	call   801027e0 <lapicstartap>
80102eff:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102f00:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102f06:	85 c0                	test   %eax,%eax
80102f08:	74 f6                	je     80102f00 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102f0a:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80102f11:	00 00 00 
80102f14:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102f1a:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102f1f:	39 c3                	cmp    %eax,%ebx
80102f21:	72 9d                	jb     80102ec0 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102f23:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
80102f2a:	8e 
80102f2b:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80102f32:	e8 49 f5 ff ff       	call   80102480 <kinit2>
  userinit();      // first user process
80102f37:	e8 04 08 00 00       	call   80103740 <userinit>
  mpmain();        // finish this processor's setup
80102f3c:	e8 6f fe ff ff       	call   80102db0 <mpmain>
80102f41:	66 90                	xchg   %ax,%ax
80102f43:	66 90                	xchg   %ax,%ax
80102f45:	66 90                	xchg   %ax,%ax
80102f47:	66 90                	xchg   %ax,%ax
80102f49:	66 90                	xchg   %ax,%ax
80102f4b:	66 90                	xchg   %ax,%ax
80102f4d:	66 90                	xchg   %ax,%ax
80102f4f:	90                   	nop

80102f50 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102f50:	55                   	push   %ebp
80102f51:	89 e5                	mov    %esp,%ebp
80102f53:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102f54:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102f5a:	53                   	push   %ebx
  e = addr+len;
80102f5b:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102f5e:	83 ec 10             	sub    $0x10,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102f61:	39 de                	cmp    %ebx,%esi
80102f63:	73 3c                	jae    80102fa1 <mpsearch1+0x51>
80102f65:	8d 76 00             	lea    0x0(%esi),%esi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f68:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80102f6f:	00 
80102f70:	c7 44 24 04 78 78 10 	movl   $0x80107878,0x4(%esp)
80102f77:	80 
80102f78:	89 34 24             	mov    %esi,(%esp)
80102f7b:	e8 80 19 00 00       	call   80104900 <memcmp>
80102f80:	85 c0                	test   %eax,%eax
80102f82:	75 16                	jne    80102f9a <mpsearch1+0x4a>
80102f84:	31 c9                	xor    %ecx,%ecx
80102f86:	31 d2                	xor    %edx,%edx
    sum += addr[i];
80102f88:	0f b6 04 16          	movzbl (%esi,%edx,1),%eax
  for(i=0; i<len; i++)
80102f8c:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80102f8f:	01 c1                	add    %eax,%ecx
  for(i=0; i<len; i++)
80102f91:	83 fa 10             	cmp    $0x10,%edx
80102f94:	75 f2                	jne    80102f88 <mpsearch1+0x38>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80102f96:	84 c9                	test   %cl,%cl
80102f98:	74 10                	je     80102faa <mpsearch1+0x5a>
  for(p = addr; p < e; p += sizeof(struct mp))
80102f9a:	83 c6 10             	add    $0x10,%esi
80102f9d:	39 f3                	cmp    %esi,%ebx
80102f9f:	77 c7                	ja     80102f68 <mpsearch1+0x18>
      return (struct mp*)p;
  return 0;
}
80102fa1:	83 c4 10             	add    $0x10,%esp
  return 0;
80102fa4:	31 c0                	xor    %eax,%eax
}
80102fa6:	5b                   	pop    %ebx
80102fa7:	5e                   	pop    %esi
80102fa8:	5d                   	pop    %ebp
80102fa9:	c3                   	ret    
80102faa:	83 c4 10             	add    $0x10,%esp
80102fad:	89 f0                	mov    %esi,%eax
80102faf:	5b                   	pop    %ebx
80102fb0:	5e                   	pop    %esi
80102fb1:	5d                   	pop    %ebp
80102fb2:	c3                   	ret    
80102fb3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102fb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102fc0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	57                   	push   %edi
80102fc4:	56                   	push   %esi
80102fc5:	53                   	push   %ebx
80102fc6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80102fc9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80102fd0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80102fd7:	c1 e0 08             	shl    $0x8,%eax
80102fda:	09 d0                	or     %edx,%eax
80102fdc:	c1 e0 04             	shl    $0x4,%eax
80102fdf:	85 c0                	test   %eax,%eax
80102fe1:	75 1b                	jne    80102ffe <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80102fe3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80102fea:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80102ff1:	c1 e0 08             	shl    $0x8,%eax
80102ff4:	09 d0                	or     %edx,%eax
80102ff6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80102ff9:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80102ffe:	ba 00 04 00 00       	mov    $0x400,%edx
80103003:	e8 48 ff ff ff       	call   80102f50 <mpsearch1>
80103008:	85 c0                	test   %eax,%eax
8010300a:	89 c7                	mov    %eax,%edi
8010300c:	0f 84 22 01 00 00    	je     80103134 <mpinit+0x174>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103012:	8b 77 04             	mov    0x4(%edi),%esi
80103015:	85 f6                	test   %esi,%esi
80103017:	0f 84 30 01 00 00    	je     8010314d <mpinit+0x18d>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010301d:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103023:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010302a:	00 
8010302b:	c7 44 24 04 7d 78 10 	movl   $0x8010787d,0x4(%esp)
80103032:	80 
80103033:	89 04 24             	mov    %eax,(%esp)
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103036:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103039:	e8 c2 18 00 00       	call   80104900 <memcmp>
8010303e:	85 c0                	test   %eax,%eax
80103040:	0f 85 07 01 00 00    	jne    8010314d <mpinit+0x18d>
  if(conf->version != 1 && conf->version != 4)
80103046:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
8010304d:	3c 04                	cmp    $0x4,%al
8010304f:	0f 85 0b 01 00 00    	jne    80103160 <mpinit+0x1a0>
  if(sum((uchar*)conf, conf->length) != 0)
80103055:	0f b7 86 04 00 00 80 	movzwl -0x7ffffffc(%esi),%eax
  for(i=0; i<len; i++)
8010305c:	85 c0                	test   %eax,%eax
8010305e:	74 21                	je     80103081 <mpinit+0xc1>
  sum = 0;
80103060:	31 c9                	xor    %ecx,%ecx
  for(i=0; i<len; i++)
80103062:	31 d2                	xor    %edx,%edx
80103064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103068:	0f b6 9c 16 00 00 00 	movzbl -0x80000000(%esi,%edx,1),%ebx
8010306f:	80 
  for(i=0; i<len; i++)
80103070:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103073:	01 d9                	add    %ebx,%ecx
  for(i=0; i<len; i++)
80103075:	39 d0                	cmp    %edx,%eax
80103077:	7f ef                	jg     80103068 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103079:	84 c9                	test   %cl,%cl
8010307b:	0f 85 cc 00 00 00    	jne    8010314d <mpinit+0x18d>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103081:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103084:	85 c0                	test   %eax,%eax
80103086:	0f 84 c1 00 00 00    	je     8010314d <mpinit+0x18d>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010308c:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  ismp = 1;
80103092:	bb 01 00 00 00       	mov    $0x1,%ebx
  lapic = (uint*)conf->lapicaddr;
80103097:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010309c:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801030a3:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801030a9:	03 55 e4             	add    -0x1c(%ebp),%edx
801030ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030b0:	39 c2                	cmp    %eax,%edx
801030b2:	76 1b                	jbe    801030cf <mpinit+0x10f>
801030b4:	0f b6 08             	movzbl (%eax),%ecx
    switch(*p){
801030b7:	80 f9 04             	cmp    $0x4,%cl
801030ba:	77 74                	ja     80103130 <mpinit+0x170>
801030bc:	ff 24 8d bc 78 10 80 	jmp    *-0x7fef8744(,%ecx,4)
801030c3:	90                   	nop
801030c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801030c8:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801030cb:	39 c2                	cmp    %eax,%edx
801030cd:	77 e5                	ja     801030b4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801030cf:	85 db                	test   %ebx,%ebx
801030d1:	0f 84 93 00 00 00    	je     8010316a <mpinit+0x1aa>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801030d7:	80 7f 0c 00          	cmpb   $0x0,0xc(%edi)
801030db:	74 12                	je     801030ef <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030dd:	ba 22 00 00 00       	mov    $0x22,%edx
801030e2:	b8 70 00 00 00       	mov    $0x70,%eax
801030e7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801030e8:	b2 23                	mov    $0x23,%dl
801030ea:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801030eb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801030ee:	ee                   	out    %al,(%dx)
  }
}
801030ef:	83 c4 1c             	add    $0x1c,%esp
801030f2:	5b                   	pop    %ebx
801030f3:	5e                   	pop    %esi
801030f4:	5f                   	pop    %edi
801030f5:	5d                   	pop    %ebp
801030f6:	c3                   	ret    
801030f7:	90                   	nop
      if(ncpu < NCPU) {
801030f8:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
801030fe:	83 fe 07             	cmp    $0x7,%esi
80103101:	7f 17                	jg     8010311a <mpinit+0x15a>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103103:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80103107:	69 f6 b0 00 00 00    	imul   $0xb0,%esi,%esi
        ncpu++;
8010310d:	83 05 20 2d 11 80 01 	addl   $0x1,0x80112d20
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103114:	88 8e a0 27 11 80    	mov    %cl,-0x7feed860(%esi)
      p += sizeof(struct mpproc);
8010311a:	83 c0 14             	add    $0x14,%eax
      continue;
8010311d:	eb 91                	jmp    801030b0 <mpinit+0xf0>
8010311f:	90                   	nop
      ioapicid = ioapic->apicno;
80103120:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103124:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103127:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010312d:	eb 81                	jmp    801030b0 <mpinit+0xf0>
8010312f:	90                   	nop
      ismp = 0;
80103130:	31 db                	xor    %ebx,%ebx
80103132:	eb 83                	jmp    801030b7 <mpinit+0xf7>
  return mpsearch1(0xF0000, 0x10000);
80103134:	ba 00 00 01 00       	mov    $0x10000,%edx
80103139:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010313e:	e8 0d fe ff ff       	call   80102f50 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103143:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103145:	89 c7                	mov    %eax,%edi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103147:	0f 85 c5 fe ff ff    	jne    80103012 <mpinit+0x52>
    panic("Expect to run on an SMP");
8010314d:	c7 04 24 82 78 10 80 	movl   $0x80107882,(%esp)
80103154:	e8 07 d2 ff ff       	call   80100360 <panic>
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(conf->version != 1 && conf->version != 4)
80103160:	3c 01                	cmp    $0x1,%al
80103162:	0f 84 ed fe ff ff    	je     80103055 <mpinit+0x95>
80103168:	eb e3                	jmp    8010314d <mpinit+0x18d>
    panic("Didn't find a suitable machine");
8010316a:	c7 04 24 9c 78 10 80 	movl   $0x8010789c,(%esp)
80103171:	e8 ea d1 ff ff       	call   80100360 <panic>
80103176:	66 90                	xchg   %ax,%ax
80103178:	66 90                	xchg   %ax,%ax
8010317a:	66 90                	xchg   %ax,%ax
8010317c:	66 90                	xchg   %ax,%ax
8010317e:	66 90                	xchg   %ax,%ax

80103180 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103180:	55                   	push   %ebp
80103181:	ba 21 00 00 00       	mov    $0x21,%edx
80103186:	89 e5                	mov    %esp,%ebp
80103188:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010318d:	ee                   	out    %al,(%dx)
8010318e:	b2 a1                	mov    $0xa1,%dl
80103190:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103191:	5d                   	pop    %ebp
80103192:	c3                   	ret    
80103193:	66 90                	xchg   %ax,%ax
80103195:	66 90                	xchg   %ax,%ax
80103197:	66 90                	xchg   %ax,%ax
80103199:	66 90                	xchg   %ax,%ax
8010319b:	66 90                	xchg   %ax,%ax
8010319d:	66 90                	xchg   %ax,%ax
8010319f:	90                   	nop

801031a0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	57                   	push   %edi
801031a4:	56                   	push   %esi
801031a5:	53                   	push   %ebx
801031a6:	83 ec 1c             	sub    $0x1c,%esp
801031a9:	8b 75 08             	mov    0x8(%ebp),%esi
801031ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801031af:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801031b5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801031bb:	e8 d0 db ff ff       	call   80100d90 <filealloc>
801031c0:	85 c0                	test   %eax,%eax
801031c2:	89 06                	mov    %eax,(%esi)
801031c4:	0f 84 a4 00 00 00    	je     8010326e <pipealloc+0xce>
801031ca:	e8 c1 db ff ff       	call   80100d90 <filealloc>
801031cf:	85 c0                	test   %eax,%eax
801031d1:	89 03                	mov    %eax,(%ebx)
801031d3:	0f 84 87 00 00 00    	je     80103260 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801031d9:	e8 f2 f2 ff ff       	call   801024d0 <kalloc>
801031de:	85 c0                	test   %eax,%eax
801031e0:	89 c7                	mov    %eax,%edi
801031e2:	74 7c                	je     80103260 <pipealloc+0xc0>
    goto bad;
  p->readopen = 1;
801031e4:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801031eb:	00 00 00 
  p->writeopen = 1;
801031ee:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801031f5:	00 00 00 
  p->nwrite = 0;
801031f8:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801031ff:	00 00 00 
  p->nread = 0;
80103202:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103209:	00 00 00 
  initlock(&p->lock, "pipe");
8010320c:	89 04 24             	mov    %eax,(%esp)
8010320f:	c7 44 24 04 d0 78 10 	movl   $0x801078d0,0x4(%esp)
80103216:	80 
80103217:	e8 64 14 00 00       	call   80104680 <initlock>
  (*f0)->type = FD_PIPE;
8010321c:	8b 06                	mov    (%esi),%eax
8010321e:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103224:	8b 06                	mov    (%esi),%eax
80103226:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010322a:	8b 06                	mov    (%esi),%eax
8010322c:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103230:	8b 06                	mov    (%esi),%eax
80103232:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103235:	8b 03                	mov    (%ebx),%eax
80103237:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010323d:	8b 03                	mov    (%ebx),%eax
8010323f:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103243:	8b 03                	mov    (%ebx),%eax
80103245:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103249:	8b 03                	mov    (%ebx),%eax
  return 0;
8010324b:	31 db                	xor    %ebx,%ebx
  (*f1)->pipe = p;
8010324d:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103250:	83 c4 1c             	add    $0x1c,%esp
80103253:	89 d8                	mov    %ebx,%eax
80103255:	5b                   	pop    %ebx
80103256:	5e                   	pop    %esi
80103257:	5f                   	pop    %edi
80103258:	5d                   	pop    %ebp
80103259:	c3                   	ret    
8010325a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(*f0)
80103260:	8b 06                	mov    (%esi),%eax
80103262:	85 c0                	test   %eax,%eax
80103264:	74 08                	je     8010326e <pipealloc+0xce>
    fileclose(*f0);
80103266:	89 04 24             	mov    %eax,(%esp)
80103269:	e8 e2 db ff ff       	call   80100e50 <fileclose>
  if(*f1)
8010326e:	8b 03                	mov    (%ebx),%eax
  return -1;
80103270:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  if(*f1)
80103275:	85 c0                	test   %eax,%eax
80103277:	74 d7                	je     80103250 <pipealloc+0xb0>
    fileclose(*f1);
80103279:	89 04 24             	mov    %eax,(%esp)
8010327c:	e8 cf db ff ff       	call   80100e50 <fileclose>
}
80103281:	83 c4 1c             	add    $0x1c,%esp
80103284:	89 d8                	mov    %ebx,%eax
80103286:	5b                   	pop    %ebx
80103287:	5e                   	pop    %esi
80103288:	5f                   	pop    %edi
80103289:	5d                   	pop    %ebp
8010328a:	c3                   	ret    
8010328b:	90                   	nop
8010328c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103290 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	56                   	push   %esi
80103294:	53                   	push   %ebx
80103295:	83 ec 10             	sub    $0x10,%esp
80103298:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010329b:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010329e:	89 1c 24             	mov    %ebx,(%esp)
801032a1:	e8 4a 15 00 00       	call   801047f0 <acquire>
  if(writable){
801032a6:	85 f6                	test   %esi,%esi
801032a8:	74 3e                	je     801032e8 <pipeclose+0x58>
    p->writeopen = 0;
    wakeup(&p->nread);
801032aa:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801032b0:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801032b7:	00 00 00 
    wakeup(&p->nread);
801032ba:	89 04 24             	mov    %eax,(%esp)
801032bd:	e8 9e 0f 00 00       	call   80104260 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801032c2:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801032c8:	85 d2                	test   %edx,%edx
801032ca:	75 0a                	jne    801032d6 <pipeclose+0x46>
801032cc:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	74 32                	je     80103308 <pipeclose+0x78>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801032d6:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801032d9:	83 c4 10             	add    $0x10,%esp
801032dc:	5b                   	pop    %ebx
801032dd:	5e                   	pop    %esi
801032de:	5d                   	pop    %ebp
    release(&p->lock);
801032df:	e9 7c 15 00 00       	jmp    80104860 <release>
801032e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801032e8:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801032ee:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801032f5:	00 00 00 
    wakeup(&p->nwrite);
801032f8:	89 04 24             	mov    %eax,(%esp)
801032fb:	e8 60 0f 00 00       	call   80104260 <wakeup>
80103300:	eb c0                	jmp    801032c2 <pipeclose+0x32>
80103302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&p->lock);
80103308:	89 1c 24             	mov    %ebx,(%esp)
8010330b:	e8 50 15 00 00       	call   80104860 <release>
    kfree((char*)p);
80103310:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103313:	83 c4 10             	add    $0x10,%esp
80103316:	5b                   	pop    %ebx
80103317:	5e                   	pop    %esi
80103318:	5d                   	pop    %ebp
    kfree((char*)p);
80103319:	e9 02 f0 ff ff       	jmp    80102320 <kfree>
8010331e:	66 90                	xchg   %ax,%ax

80103320 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103320:	55                   	push   %ebp
80103321:	89 e5                	mov    %esp,%ebp
80103323:	57                   	push   %edi
80103324:	56                   	push   %esi
80103325:	53                   	push   %ebx
80103326:	83 ec 1c             	sub    $0x1c,%esp
80103329:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010332c:	89 1c 24             	mov    %ebx,(%esp)
8010332f:	e8 bc 14 00 00       	call   801047f0 <acquire>
  for(i = 0; i < n; i++){
80103334:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103337:	85 c9                	test   %ecx,%ecx
80103339:	0f 8e b2 00 00 00    	jle    801033f1 <pipewrite+0xd1>
8010333f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103342:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103348:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010334e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103354:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103357:	03 4d 10             	add    0x10(%ebp),%ecx
8010335a:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010335d:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
80103363:	81 c1 00 02 00 00    	add    $0x200,%ecx
80103369:	39 c8                	cmp    %ecx,%eax
8010336b:	74 38                	je     801033a5 <pipewrite+0x85>
8010336d:	eb 55                	jmp    801033c4 <pipewrite+0xa4>
8010336f:	90                   	nop
      if(p->readopen == 0 || myproc()->killed){
80103370:	e8 9b 03 00 00       	call   80103710 <myproc>
80103375:	8b 40 24             	mov    0x24(%eax),%eax
80103378:	85 c0                	test   %eax,%eax
8010337a:	75 33                	jne    801033af <pipewrite+0x8f>
      wakeup(&p->nread);
8010337c:	89 3c 24             	mov    %edi,(%esp)
8010337f:	e8 dc 0e 00 00       	call   80104260 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103384:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103388:	89 34 24             	mov    %esi,(%esp)
8010338b:	e8 30 0d 00 00       	call   801040c0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103390:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103396:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010339c:	05 00 02 00 00       	add    $0x200,%eax
801033a1:	39 c2                	cmp    %eax,%edx
801033a3:	75 23                	jne    801033c8 <pipewrite+0xa8>
      if(p->readopen == 0 || myproc()->killed){
801033a5:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033ab:	85 d2                	test   %edx,%edx
801033ad:	75 c1                	jne    80103370 <pipewrite+0x50>
        release(&p->lock);
801033af:	89 1c 24             	mov    %ebx,(%esp)
801033b2:	e8 a9 14 00 00       	call   80104860 <release>
        return -1;
801033b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801033bc:	83 c4 1c             	add    $0x1c,%esp
801033bf:	5b                   	pop    %ebx
801033c0:	5e                   	pop    %esi
801033c1:	5f                   	pop    %edi
801033c2:	5d                   	pop    %ebp
801033c3:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801033c4:	89 c2                	mov    %eax,%edx
801033c6:	66 90                	xchg   %ax,%ax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801033c8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801033cb:	8d 42 01             	lea    0x1(%edx),%eax
801033ce:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801033d4:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801033da:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
801033de:	0f b6 09             	movzbl (%ecx),%ecx
801033e1:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801033e5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801033e8:	3b 4d e0             	cmp    -0x20(%ebp),%ecx
801033eb:	0f 85 6c ff ff ff    	jne    8010335d <pipewrite+0x3d>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801033f1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033f7:	89 04 24             	mov    %eax,(%esp)
801033fa:	e8 61 0e 00 00       	call   80104260 <wakeup>
  release(&p->lock);
801033ff:	89 1c 24             	mov    %ebx,(%esp)
80103402:	e8 59 14 00 00       	call   80104860 <release>
  return n;
80103407:	8b 45 10             	mov    0x10(%ebp),%eax
8010340a:	eb b0                	jmp    801033bc <pipewrite+0x9c>
8010340c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103410 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	57                   	push   %edi
80103414:	56                   	push   %esi
80103415:	53                   	push   %ebx
80103416:	83 ec 1c             	sub    $0x1c,%esp
80103419:	8b 75 08             	mov    0x8(%ebp),%esi
8010341c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010341f:	89 34 24             	mov    %esi,(%esp)
80103422:	e8 c9 13 00 00       	call   801047f0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103427:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010342d:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103433:	75 5b                	jne    80103490 <piperead+0x80>
80103435:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010343b:	85 db                	test   %ebx,%ebx
8010343d:	74 51                	je     80103490 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010343f:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103445:	eb 25                	jmp    8010346c <piperead+0x5c>
80103447:	90                   	nop
80103448:	89 74 24 04          	mov    %esi,0x4(%esp)
8010344c:	89 1c 24             	mov    %ebx,(%esp)
8010344f:	e8 6c 0c 00 00       	call   801040c0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103454:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
8010345a:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103460:	75 2e                	jne    80103490 <piperead+0x80>
80103462:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103468:	85 d2                	test   %edx,%edx
8010346a:	74 24                	je     80103490 <piperead+0x80>
    if(myproc()->killed){
8010346c:	e8 9f 02 00 00       	call   80103710 <myproc>
80103471:	8b 48 24             	mov    0x24(%eax),%ecx
80103474:	85 c9                	test   %ecx,%ecx
80103476:	74 d0                	je     80103448 <piperead+0x38>
      release(&p->lock);
80103478:	89 34 24             	mov    %esi,(%esp)
8010347b:	e8 e0 13 00 00       	call   80104860 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103480:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80103483:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103488:	5b                   	pop    %ebx
80103489:	5e                   	pop    %esi
8010348a:	5f                   	pop    %edi
8010348b:	5d                   	pop    %ebp
8010348c:	c3                   	ret    
8010348d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103490:	8b 55 10             	mov    0x10(%ebp),%edx
    if(p->nread == p->nwrite)
80103493:	31 db                	xor    %ebx,%ebx
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103495:	85 d2                	test   %edx,%edx
80103497:	7f 2b                	jg     801034c4 <piperead+0xb4>
80103499:	eb 31                	jmp    801034cc <piperead+0xbc>
8010349b:	90                   	nop
8010349c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    addr[i] = p->data[p->nread++ % PIPESIZE];
801034a0:	8d 48 01             	lea    0x1(%eax),%ecx
801034a3:	25 ff 01 00 00       	and    $0x1ff,%eax
801034a8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801034ae:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801034b3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801034b6:	83 c3 01             	add    $0x1,%ebx
801034b9:	3b 5d 10             	cmp    0x10(%ebp),%ebx
801034bc:	74 0e                	je     801034cc <piperead+0xbc>
    if(p->nread == p->nwrite)
801034be:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801034c4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801034ca:	75 d4                	jne    801034a0 <piperead+0x90>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801034cc:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801034d2:	89 04 24             	mov    %eax,(%esp)
801034d5:	e8 86 0d 00 00       	call   80104260 <wakeup>
  release(&p->lock);
801034da:	89 34 24             	mov    %esi,(%esp)
801034dd:	e8 7e 13 00 00       	call   80104860 <release>
}
801034e2:	83 c4 1c             	add    $0x1c,%esp
  return i;
801034e5:	89 d8                	mov    %ebx,%eax
}
801034e7:	5b                   	pop    %ebx
801034e8:	5e                   	pop    %esi
801034e9:	5f                   	pop    %edi
801034ea:	5d                   	pop    %ebp
801034eb:	c3                   	ret    
801034ec:	66 90                	xchg   %ax,%ax
801034ee:	66 90                	xchg   %ax,%ax

801034f0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801034f4:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
801034f9:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);
801034fc:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103503:	e8 e8 12 00 00       	call   801047f0 <acquire>
80103508:	eb 18                	jmp    80103522 <allocproc+0x32>
8010350a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103510:	81 c3 90 00 00 00    	add    $0x90,%ebx
80103516:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
8010351c:	0f 84 be 00 00 00    	je     801035e0 <allocproc+0xf0>
    if(p->state == UNUSED)
80103522:	8b 43 0c             	mov    0xc(%ebx),%eax
80103525:	85 c0                	test   %eax,%eax
80103527:	75 e7                	jne    80103510 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103529:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
8010352e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
  p->state = EMBRYO;
80103535:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
8010353c:	8d 50 01             	lea    0x1(%eax),%edx
8010353f:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
80103545:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
80103548:	e8 13 13 00 00       	call   80104860 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010354d:	e8 7e ef ff ff       	call   801024d0 <kalloc>
80103552:	85 c0                	test   %eax,%eax
80103554:	89 43 08             	mov    %eax,0x8(%ebx)
80103557:	0f 84 97 00 00 00    	je     801035f4 <allocproc+0x104>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010355d:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
80103563:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103568:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010356b:	c7 40 14 67 5b 10 80 	movl   $0x80105b67,0x14(%eax)
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103572:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80103579:	00 
8010357a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103581:	00 
80103582:	89 04 24             	mov    %eax,(%esp)
  p->context = (struct context*)sp;
80103585:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103588:	e8 23 13 00 00       	call   801048b0 <memset>
  p->context->eip = (uint)forkret;
8010358d:	8b 43 1c             	mov    0x1c(%ebx),%eax


  p->oncpu=-1;
  p->isThread=0;
  p->isParent=0;
80103590:	31 d2                	xor    %edx,%edx
  p->threadCount=0;
80103592:	31 c9                	xor    %ecx,%ecx
  p->context->eip = (uint)forkret;
80103594:	c7 40 10 00 36 10 80 	movl   $0x80103600,0x10(%eax)
  p->isThread=0;
8010359b:	31 c0                	xor    %eax,%eax
8010359d:	66 89 83 80 00 00 00 	mov    %ax,0x80(%ebx)
  p->tid=0;
801035a4:	31 c0                	xor    %eax,%eax
801035a6:	66 89 83 86 00 00 00 	mov    %ax,0x86(%ebx)
  p->nextTid=1;
801035ad:	b8 01 00 00 00       	mov    $0x1,%eax
801035b2:	66 89 83 88 00 00 00 	mov    %ax,0x88(%ebx)
  p->threadExitvalue=0;


  return p;
801035b9:	89 d8                	mov    %ebx,%eax
  p->oncpu=-1;
801035bb:	c7 43 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ebx)
  p->isParent=0;
801035c2:	66 89 93 82 00 00 00 	mov    %dx,0x82(%ebx)
  p->threadCount=0;
801035c9:	66 89 8b 84 00 00 00 	mov    %cx,0x84(%ebx)
  p->threadExitvalue=0;
801035d0:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801035d7:	00 00 00 
}
801035da:	83 c4 14             	add    $0x14,%esp
801035dd:	5b                   	pop    %ebx
801035de:	5d                   	pop    %ebp
801035df:	c3                   	ret    
  release(&ptable.lock);
801035e0:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801035e7:	e8 74 12 00 00       	call   80104860 <release>
}
801035ec:	83 c4 14             	add    $0x14,%esp
  return 0;
801035ef:	31 c0                	xor    %eax,%eax
}
801035f1:	5b                   	pop    %ebx
801035f2:	5d                   	pop    %ebp
801035f3:	c3                   	ret    
    p->state = UNUSED;
801035f4:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801035fb:	eb dd                	jmp    801035da <allocproc+0xea>
801035fd:	8d 76 00             	lea    0x0(%esi),%esi

80103600 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103606:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010360d:	e8 4e 12 00 00       	call   80104860 <release>

  if (first) {
80103612:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103617:	85 c0                	test   %eax,%eax
80103619:	75 05                	jne    80103620 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010361b:	c9                   	leave  
8010361c:	c3                   	ret    
8010361d:	8d 76 00             	lea    0x0(%esi),%esi
    iinit(ROOTDEV);
80103620:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    first = 0;
80103627:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
8010362e:	00 00 00 
    iinit(ROOTDEV);
80103631:	e8 6a de ff ff       	call   801014a0 <iinit>
    initlog(ROOTDEV);
80103636:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010363d:	e8 5e f4 ff ff       	call   80102aa0 <initlog>
}
80103642:	c9                   	leave  
80103643:	c3                   	ret    
80103644:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010364a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103650 <pinit>:
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103656:	c7 44 24 04 d5 78 10 	movl   $0x801078d5,0x4(%esp)
8010365d:	80 
8010365e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103665:	e8 16 10 00 00       	call   80104680 <initlock>
}
8010366a:	c9                   	leave  
8010366b:	c3                   	ret    
8010366c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103670 <mycpu>:
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	56                   	push   %esi
80103674:	53                   	push   %ebx
80103675:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103678:	9c                   	pushf  
80103679:	58                   	pop    %eax
  if(readeflags()&FL_IF)
8010367a:	f6 c4 02             	test   $0x2,%ah
8010367d:	75 57                	jne    801036d6 <mycpu+0x66>
  apicid = lapicid();
8010367f:	e8 0c f1 ff ff       	call   80102790 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103684:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
8010368a:	85 f6                	test   %esi,%esi
8010368c:	7e 3c                	jle    801036ca <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010368e:	0f b6 15 a0 27 11 80 	movzbl 0x801127a0,%edx
80103695:	39 c2                	cmp    %eax,%edx
80103697:	74 2d                	je     801036c6 <mycpu+0x56>
80103699:	b9 50 28 11 80       	mov    $0x80112850,%ecx
  for (i = 0; i < ncpu; ++i) {
8010369e:	31 d2                	xor    %edx,%edx
801036a0:	83 c2 01             	add    $0x1,%edx
801036a3:	39 f2                	cmp    %esi,%edx
801036a5:	74 23                	je     801036ca <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
801036a7:	0f b6 19             	movzbl (%ecx),%ebx
801036aa:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
801036b0:	39 c3                	cmp    %eax,%ebx
801036b2:	75 ec                	jne    801036a0 <mycpu+0x30>
      return &cpus[i];
801036b4:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
}
801036ba:	83 c4 10             	add    $0x10,%esp
801036bd:	5b                   	pop    %ebx
801036be:	5e                   	pop    %esi
801036bf:	5d                   	pop    %ebp
      return &cpus[i];
801036c0:	05 a0 27 11 80       	add    $0x801127a0,%eax
}
801036c5:	c3                   	ret    
  for (i = 0; i < ncpu; ++i) {
801036c6:	31 d2                	xor    %edx,%edx
801036c8:	eb ea                	jmp    801036b4 <mycpu+0x44>
  panic("unknown apicid\n");
801036ca:	c7 04 24 dc 78 10 80 	movl   $0x801078dc,(%esp)
801036d1:	e8 8a cc ff ff       	call   80100360 <panic>
    panic("mycpu called with interrupts enabled\n");
801036d6:	c7 04 24 e0 79 10 80 	movl   $0x801079e0,(%esp)
801036dd:	e8 7e cc ff ff       	call   80100360 <panic>
801036e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036f0 <cpuid>:
cpuid() {
801036f0:	55                   	push   %ebp
801036f1:	89 e5                	mov    %esp,%ebp
801036f3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801036f6:	e8 75 ff ff ff       	call   80103670 <mycpu>
}
801036fb:	c9                   	leave  
  return mycpu()-cpus;
801036fc:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103701:	c1 f8 04             	sar    $0x4,%eax
80103704:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010370a:	c3                   	ret    
8010370b:	90                   	nop
8010370c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103710 <myproc>:
myproc(void) {
80103710:	55                   	push   %ebp
80103711:	89 e5                	mov    %esp,%ebp
80103713:	53                   	push   %ebx
80103714:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103717:	e8 e4 0f 00 00       	call   80104700 <pushcli>
  c = mycpu();
8010371c:	e8 4f ff ff ff       	call   80103670 <mycpu>
  p = c->proc;
80103721:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103727:	e8 14 10 00 00       	call   80104740 <popcli>
}
8010372c:	83 c4 04             	add    $0x4,%esp
8010372f:	89 d8                	mov    %ebx,%eax
80103731:	5b                   	pop    %ebx
80103732:	5d                   	pop    %ebp
80103733:	c3                   	ret    
80103734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010373a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103740 <userinit>:
{
80103740:	55                   	push   %ebp
80103741:	89 e5                	mov    %esp,%ebp
80103743:	53                   	push   %ebx
80103744:	83 ec 14             	sub    $0x14,%esp
  p = allocproc();
80103747:	e8 a4 fd ff ff       	call   801034f0 <allocproc>
8010374c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010374e:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103753:	e8 88 39 00 00       	call   801070e0 <setupkvm>
80103758:	85 c0                	test   %eax,%eax
8010375a:	89 43 04             	mov    %eax,0x4(%ebx)
8010375d:	0f 84 d4 00 00 00    	je     80103837 <userinit+0xf7>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103763:	89 04 24             	mov    %eax,(%esp)
80103766:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
8010376d:	00 
8010376e:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103775:	80 
80103776:	e8 95 36 00 00       	call   80106e10 <inituvm>
  p->sz = PGSIZE;
8010377b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103781:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103788:	00 
80103789:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103790:	00 
80103791:	8b 43 18             	mov    0x18(%ebx),%eax
80103794:	89 04 24             	mov    %eax,(%esp)
80103797:	e8 14 11 00 00       	call   801048b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010379c:	8b 43 18             	mov    0x18(%ebx),%eax
8010379f:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801037a4:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801037a9:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801037ad:	8b 43 18             	mov    0x18(%ebx),%eax
801037b0:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801037b4:	8b 43 18             	mov    0x18(%ebx),%eax
801037b7:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801037bb:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
801037bf:	8b 43 18             	mov    0x18(%ebx),%eax
801037c2:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801037c6:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801037ca:	8b 43 18             	mov    0x18(%ebx),%eax
801037cd:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801037d4:	8b 43 18             	mov    0x18(%ebx),%eax
801037d7:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801037de:	8b 43 18             	mov    0x18(%ebx),%eax
801037e1:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
801037e8:	8d 43 6c             	lea    0x6c(%ebx),%eax
801037eb:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801037f2:	00 
801037f3:	c7 44 24 04 05 79 10 	movl   $0x80107905,0x4(%esp)
801037fa:	80 
801037fb:	89 04 24             	mov    %eax,(%esp)
801037fe:	e8 8d 12 00 00       	call   80104a90 <safestrcpy>
  p->cwd = namei("/");
80103803:	c7 04 24 0e 79 10 80 	movl   $0x8010790e,(%esp)
8010380a:	e8 21 e7 ff ff       	call   80101f30 <namei>
8010380f:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103812:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103819:	e8 d2 0f 00 00       	call   801047f0 <acquire>
  p->state = RUNNABLE;
8010381e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103825:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010382c:	e8 2f 10 00 00       	call   80104860 <release>
}
80103831:	83 c4 14             	add    $0x14,%esp
80103834:	5b                   	pop    %ebx
80103835:	5d                   	pop    %ebp
80103836:	c3                   	ret    
    panic("userinit: out of memory?");
80103837:	c7 04 24 ec 78 10 80 	movl   $0x801078ec,(%esp)
8010383e:	e8 1d cb ff ff       	call   80100360 <panic>
80103843:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103849:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103850 <growproc>:
{
80103850:	55                   	push   %ebp
80103851:	89 e5                	mov    %esp,%ebp
80103853:	56                   	push   %esi
80103854:	53                   	push   %ebx
80103855:	83 ec 10             	sub    $0x10,%esp
80103858:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *curproc = myproc();
8010385b:	e8 b0 fe ff ff       	call   80103710 <myproc>
  if(n > 0){
80103860:	83 fe 00             	cmp    $0x0,%esi
  struct proc *curproc = myproc();
80103863:	89 c3                	mov    %eax,%ebx
  sz = curproc->sz;
80103865:	8b 00                	mov    (%eax),%eax
  if(n > 0){
80103867:	7e 2f                	jle    80103898 <growproc+0x48>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103869:	01 c6                	add    %eax,%esi
8010386b:	89 74 24 08          	mov    %esi,0x8(%esp)
8010386f:	89 44 24 04          	mov    %eax,0x4(%esp)
80103873:	8b 43 04             	mov    0x4(%ebx),%eax
80103876:	89 04 24             	mov    %eax,(%esp)
80103879:	e8 d2 36 00 00       	call   80106f50 <allocuvm>
8010387e:	85 c0                	test   %eax,%eax
80103880:	74 36                	je     801038b8 <growproc+0x68>
  curproc->sz = sz;
80103882:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103884:	89 1c 24             	mov    %ebx,(%esp)
80103887:	e8 74 34 00 00       	call   80106d00 <switchuvm>
  return 0;
8010388c:	31 c0                	xor    %eax,%eax
}
8010388e:	83 c4 10             	add    $0x10,%esp
80103891:	5b                   	pop    %ebx
80103892:	5e                   	pop    %esi
80103893:	5d                   	pop    %ebp
80103894:	c3                   	ret    
80103895:	8d 76 00             	lea    0x0(%esi),%esi
  } else if(n < 0){
80103898:	74 e8                	je     80103882 <growproc+0x32>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010389a:	01 c6                	add    %eax,%esi
8010389c:	89 74 24 08          	mov    %esi,0x8(%esp)
801038a0:	89 44 24 04          	mov    %eax,0x4(%esp)
801038a4:	8b 43 04             	mov    0x4(%ebx),%eax
801038a7:	89 04 24             	mov    %eax,(%esp)
801038aa:	e8 91 37 00 00       	call   80107040 <deallocuvm>
801038af:	85 c0                	test   %eax,%eax
801038b1:	75 cf                	jne    80103882 <growproc+0x32>
801038b3:	90                   	nop
801038b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
801038b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801038bd:	eb cf                	jmp    8010388e <growproc+0x3e>
801038bf:	90                   	nop

801038c0 <kthread_create>:
{
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	57                   	push   %edi
801038c4:	56                   	push   %esi
801038c5:	53                   	push   %ebx
801038c6:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *curproc = myproc();
801038c9:	e8 42 fe ff ff       	call   80103710 <myproc>
  if (debugState) {
801038ce:	8b 1d b8 a5 10 80    	mov    0x8010a5b8,%ebx
801038d4:	85 db                	test   %ebx,%ebx
  struct proc *curproc = myproc();
801038d6:	89 c2                	mov    %eax,%edx
  if (debugState) {
801038d8:	0f 85 6a 01 00 00    	jne    80103a48 <kthread_create+0x188>
  if(((uint) tstack) % PGSIZE!=0){
801038de:	f7 45 10 ff 0f 00 00 	testl  $0xfff,0x10(%ebp)
801038e5:	0f 85 9a 01 00 00    	jne    80103a85 <kthread_create+0x1c5>
801038eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  if((np = allocproc()) == 0){
801038ee:	e8 fd fb ff ff       	call   801034f0 <allocproc>
801038f3:	85 c0                	test   %eax,%eax
801038f5:	89 c3                	mov    %eax,%ebx
801038f7:	0f 84 88 01 00 00    	je     80103a85 <kthread_create+0x1c5>
  np->pgdir=curproc->pgdir;
801038fd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  np->isThread=1;
80103900:	b9 01 00 00 00       	mov    $0x1,%ecx
  np->pgdir=curproc->pgdir;
80103905:	8b 42 04             	mov    0x4(%edx),%eax
  np->isThread=1;
80103908:	66 89 8b 80 00 00 00 	mov    %cx,0x80(%ebx)
  np->pgdir=curproc->pgdir;
8010390f:	89 43 04             	mov    %eax,0x4(%ebx)
  np->sz = curproc->sz;
80103912:	8b 02                	mov    (%edx),%eax
80103914:	89 03                	mov    %eax,(%ebx)
  if(curproc->isThread==0){
80103916:	66 83 ba 80 00 00 00 	cmpw   $0x0,0x80(%edx)
8010391d:	00 
8010391e:	0f 84 04 01 00 00    	je     80103a28 <kthread_create+0x168>
    np->parent=curproc->parent;
80103924:	8b 42 14             	mov    0x14(%edx),%eax
80103927:	89 43 14             	mov    %eax,0x14(%ebx)
    curproc->parent->threadCount++;
8010392a:	8b 42 14             	mov    0x14(%edx),%eax
8010392d:	66 83 80 84 00 00 00 	addw   $0x1,0x84(%eax)
80103934:	01 
  *np->tf = *curproc->tf;
80103935:	8b 72 18             	mov    0x18(%edx),%esi
80103938:	b9 13 00 00 00       	mov    $0x13,%ecx
8010393d:	8b 7b 18             	mov    0x18(%ebx),%edi
80103940:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  np->tf->eip=(int)func;
80103942:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < NOFILE; i++)
80103945:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103947:	8b 43 18             	mov    0x18(%ebx),%eax
8010394a:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  np->tf->eip=(int)func;
80103951:	8b 43 18             	mov    0x18(%ebx),%eax
80103954:	89 48 38             	mov    %ecx,0x38(%eax)
  np->tf->esp=((int)tstack)+PGSIZE;
80103957:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010395a:	8b 43 18             	mov    0x18(%ebx),%eax
8010395d:	81 c1 00 10 00 00    	add    $0x1000,%ecx
80103963:	89 48 44             	mov    %ecx,0x44(%eax)
  np->tf->esp-=sizeof(int);
80103966:	8b 43 18             	mov    0x18(%ebx),%eax
  *((int*)(np->tf->esp))=(int)arg_ptr;
80103969:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  np->tf->esp-=sizeof(int);
8010396c:	83 68 44 04          	subl   $0x4,0x44(%eax)
  *((int*)(np->tf->esp))=(int)arg_ptr;
80103970:	8b 43 18             	mov    0x18(%ebx),%eax
80103973:	8b 40 44             	mov    0x44(%eax),%eax
80103976:	89 08                	mov    %ecx,(%eax)
  np->tf->esp-=sizeof(int);
80103978:	8b 43 18             	mov    0x18(%ebx),%eax
8010397b:	83 68 44 04          	subl   $0x4,0x44(%eax)
  tid=np->parent->nextTid;
8010397f:	8b 43 14             	mov    0x14(%ebx),%eax
80103982:	0f b7 88 88 00 00 00 	movzwl 0x88(%eax),%ecx
  np->tid=tid;
80103989:	66 89 8b 86 00 00 00 	mov    %cx,0x86(%ebx)
  tid=np->parent->nextTid;
80103990:	0f b7 f9             	movzwl %cx,%edi
  np->parent->nextTid++;
80103993:	66 83 80 88 00 00 00 	addw   $0x1,0x88(%eax)
8010399a:	01 
  *((int*)(np->tf->esp))=(int)tid;
8010399b:	8b 43 18             	mov    0x18(%ebx),%eax
  for(i = 0; i < NOFILE; i++)
8010399e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  *((int*)(np->tf->esp))=(int)tid;
801039a1:	8b 40 44             	mov    0x44(%eax),%eax
801039a4:	89 38                	mov    %edi,(%eax)
  for(i = 0; i < NOFILE; i++)
801039a6:	89 f7                	mov    %esi,%edi
801039a8:	89 d6                	mov    %edx,%esi
801039aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[i])
801039b0:	8b 44 be 28          	mov    0x28(%esi,%edi,4),%eax
801039b4:	85 c0                	test   %eax,%eax
801039b6:	74 0c                	je     801039c4 <kthread_create+0x104>
      np->ofile[i] = filedup(curproc->ofile[i]);
801039b8:	89 04 24             	mov    %eax,(%esp)
801039bb:	e8 40 d4 ff ff       	call   80100e00 <filedup>
801039c0:	89 44 bb 28          	mov    %eax,0x28(%ebx,%edi,4)
  for(i = 0; i < NOFILE; i++)
801039c4:	83 c7 01             	add    $0x1,%edi
801039c7:	83 ff 10             	cmp    $0x10,%edi
801039ca:	75 e4                	jne    801039b0 <kthread_create+0xf0>
  np->cwd = idup(curproc->cwd);
801039cc:	8b 46 68             	mov    0x68(%esi),%eax
801039cf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801039d2:	89 75 e4             	mov    %esi,-0x1c(%ebp)
801039d5:	89 04 24             	mov    %eax,(%esp)
801039d8:	e8 d3 dc ff ff       	call   801016b0 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039dd:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039e0:	83 c2 6c             	add    $0x6c,%edx
  np->cwd = idup(curproc->cwd);
801039e3:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801039e6:	8d 43 6c             	lea    0x6c(%ebx),%eax
801039e9:	89 54 24 04          	mov    %edx,0x4(%esp)
801039ed:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801039f4:	00 
801039f5:	89 04 24             	mov    %eax,(%esp)
801039f8:	e8 93 10 00 00       	call   80104a90 <safestrcpy>
  acquire(&ptable.lock);
801039fd:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a04:	e8 e7 0d 00 00       	call   801047f0 <acquire>
  np->state = RUNNABLE;
80103a09:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a10:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103a17:	e8 44 0e 00 00       	call   80104860 <release>
  return tid;
80103a1c:	89 f8                	mov    %edi,%eax
}
80103a1e:	83 c4 2c             	add    $0x2c,%esp
80103a21:	5b                   	pop    %ebx
80103a22:	5e                   	pop    %esi
80103a23:	5f                   	pop    %edi
80103a24:	5d                   	pop    %ebp
80103a25:	c3                   	ret    
80103a26:	66 90                	xchg   %ax,%ax
    curproc->isParent=1;
80103a28:	b8 01 00 00 00       	mov    $0x1,%eax
    np->parent=curproc;
80103a2d:	89 53 14             	mov    %edx,0x14(%ebx)
    curproc->isParent=1;
80103a30:	66 89 82 82 00 00 00 	mov    %ax,0x82(%edx)
    curproc->threadCount++;
80103a37:	66 83 82 84 00 00 00 	addw   $0x1,0x84(%edx)
80103a3e:	01 
80103a3f:	e9 f1 fe ff ff       	jmp    80103935 <kthread_create+0x75>
80103a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("%s %s %d: fork() called from process:  %s   pid: %d\n"
80103a48:	8b 40 10             	mov    0x10(%eax),%eax
80103a4b:	c7 44 24 0c cb 00 00 	movl   $0xcb,0xc(%esp)
80103a52:	00 
80103a53:	c7 44 24 08 79 7a 10 	movl   $0x80107a79,0x8(%esp)
80103a5a:	80 
80103a5b:	c7 44 24 04 d8 7b 10 	movl   $0x80107bd8,0x4(%esp)
80103a62:	80 
80103a63:	89 44 24 14          	mov    %eax,0x14(%esp)
              , curproc->name, curproc->pid);
80103a67:	8d 42 6c             	lea    0x6c(%edx),%eax
80103a6a:	89 44 24 10          	mov    %eax,0x10(%esp)
      cprintf("%s %s %d: fork() called from process:  %s   pid: %d\n"
80103a6e:	c7 04 24 08 7a 10 80 	movl   $0x80107a08,(%esp)
              , curproc->name, curproc->pid);
80103a75:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      cprintf("%s %s %d: fork() called from process:  %s   pid: %d\n"
80103a78:	e8 d3 cb ff ff       	call   80100650 <cprintf>
80103a7d:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a80:	e9 59 fe ff ff       	jmp    801038de <kthread_create+0x1e>
    return -1;
80103a85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103a8a:	eb 92                	jmp    80103a1e <kthread_create+0x15e>
80103a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103a90 <fork>:
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	57                   	push   %edi
80103a94:	56                   	push   %esi
80103a95:	53                   	push   %ebx
80103a96:	83 ec 2c             	sub    $0x2c,%esp
  struct proc *curproc = myproc();
80103a99:	e8 72 fc ff ff       	call   80103710 <myproc>
80103a9e:	89 c3                	mov    %eax,%ebx
  if (debugState) {
80103aa0:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80103aa5:	85 c0                	test   %eax,%eax
80103aa7:	0f 85 cb 00 00 00    	jne    80103b78 <fork+0xe8>
  if((np = allocproc()) == 0){
80103aad:	e8 3e fa ff ff       	call   801034f0 <allocproc>
80103ab2:	85 c0                	test   %eax,%eax
80103ab4:	89 c7                	mov    %eax,%edi
80103ab6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ab9:	0f 84 f0 00 00 00    	je     80103baf <fork+0x11f>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103abf:	8b 03                	mov    (%ebx),%eax
80103ac1:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ac5:	8b 43 04             	mov    0x4(%ebx),%eax
80103ac8:	89 04 24             	mov    %eax,(%esp)
80103acb:	e8 f0 36 00 00       	call   801071c0 <copyuvm>
80103ad0:	85 c0                	test   %eax,%eax
80103ad2:	89 47 04             	mov    %eax,0x4(%edi)
80103ad5:	0f 84 db 00 00 00    	je     80103bb6 <fork+0x126>
  np->sz = curproc->sz;
80103adb:	8b 03                	mov    (%ebx),%eax
80103add:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ae0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103ae2:	8b 79 18             	mov    0x18(%ecx),%edi
80103ae5:	89 c8                	mov    %ecx,%eax
  np->parent = curproc;
80103ae7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103aea:	8b 73 18             	mov    0x18(%ebx),%esi
80103aed:	b9 13 00 00 00       	mov    $0x13,%ecx
80103af2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103af4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103af6:	8b 40 18             	mov    0x18(%eax),%eax
80103af9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b00:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b04:	85 c0                	test   %eax,%eax
80103b06:	74 0f                	je     80103b17 <fork+0x87>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b08:	89 04 24             	mov    %eax,(%esp)
80103b0b:	e8 f0 d2 ff ff       	call   80100e00 <filedup>
80103b10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b13:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b17:	83 c6 01             	add    $0x1,%esi
80103b1a:	83 fe 10             	cmp    $0x10,%esi
80103b1d:	75 e1                	jne    80103b00 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103b1f:	8b 43 68             	mov    0x68(%ebx),%eax
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b22:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103b25:	89 04 24             	mov    %eax,(%esp)
80103b28:	e8 83 db ff ff       	call   801016b0 <idup>
80103b2d:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103b30:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103b33:	8d 47 6c             	lea    0x6c(%edi),%eax
80103b36:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103b3a:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103b41:	00 
80103b42:	89 04 24             	mov    %eax,(%esp)
80103b45:	e8 46 0f 00 00       	call   80104a90 <safestrcpy>
  pid = np->pid;
80103b4a:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103b4d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103b54:	e8 97 0c 00 00       	call   801047f0 <acquire>
  np->state = RUNNABLE;
80103b59:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103b60:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103b67:	e8 f4 0c 00 00       	call   80104860 <release>
  return pid;
80103b6c:	89 d8                	mov    %ebx,%eax
}
80103b6e:	83 c4 2c             	add    $0x2c,%esp
80103b71:	5b                   	pop    %ebx
80103b72:	5e                   	pop    %esi
80103b73:	5f                   	pop    %edi
80103b74:	5d                   	pop    %ebp
80103b75:	c3                   	ret    
80103b76:	66 90                	xchg   %ax,%ax
      cprintf("%s %s %d: fork() called from process:  %s   pid: %d\n"
80103b78:	8b 43 10             	mov    0x10(%ebx),%eax
80103b7b:	c7 44 24 0c 7c 01 00 	movl   $0x17c,0xc(%esp)
80103b82:	00 
80103b83:	c7 44 24 08 74 7a 10 	movl   $0x80107a74,0x8(%esp)
80103b8a:	80 
80103b8b:	c7 44 24 04 d8 7b 10 	movl   $0x80107bd8,0x4(%esp)
80103b92:	80 
80103b93:	89 44 24 14          	mov    %eax,0x14(%esp)
              , curproc->name, curproc->pid);
80103b97:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b9a:	89 44 24 10          	mov    %eax,0x10(%esp)
      cprintf("%s %s %d: fork() called from process:  %s   pid: %d\n"
80103b9e:	c7 04 24 08 7a 10 80 	movl   $0x80107a08,(%esp)
80103ba5:	e8 a6 ca ff ff       	call   80100650 <cprintf>
80103baa:	e9 fe fe ff ff       	jmp    80103aad <fork+0x1d>
    return -1;
80103baf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bb4:	eb b8                	jmp    80103b6e <fork+0xde>
    kfree(np->kstack);
80103bb6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103bb9:	8b 47 08             	mov    0x8(%edi),%eax
80103bbc:	89 04 24             	mov    %eax,(%esp)
80103bbf:	e8 5c e7 ff ff       	call   80102320 <kfree>
    return -1;
80103bc4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    np->kstack = 0;
80103bc9:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103bd0:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103bd7:	eb 95                	jmp    80103b6e <fork+0xde>
80103bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103be0 <scheduler>:
{
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	57                   	push   %edi
80103be4:	56                   	push   %esi
80103be5:	53                   	push   %ebx
80103be6:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103be9:	e8 82 fa ff ff       	call   80103670 <mycpu>
80103bee:	89 c3                	mov    %eax,%ebx
  return mycpu()-cpus;
80103bf0:	e8 7b fa ff ff       	call   80103670 <mycpu>
  c->proc = 0;
80103bf5:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103bfc:	00 00 00 
  return mycpu()-cpus;
80103bff:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103c04:	c1 f8 04             	sar    $0x4,%eax
80103c07:	69 f8 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%edi
80103c0d:	8d 43 04             	lea    0x4(%ebx),%eax
80103c10:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c13:	90                   	nop
80103c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80103c18:	fb                   	sti    
    acquire(&ptable.lock);
80103c19:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c20:	be 74 2d 11 80       	mov    $0x80112d74,%esi
    acquire(&ptable.lock);
80103c25:	e8 c6 0b 00 00       	call   801047f0 <acquire>
80103c2a:	eb 12                	jmp    80103c3e <scheduler+0x5e>
80103c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c30:	81 c6 90 00 00 00    	add    $0x90,%esi
80103c36:	81 fe 74 51 11 80    	cmp    $0x80115174,%esi
80103c3c:	74 5a                	je     80103c98 <scheduler+0xb8>
      if(p->state != RUNNABLE)
80103c3e:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103c42:	75 ec                	jne    80103c30 <scheduler+0x50>
      p->oncpu = current_cpu;
80103c44:	89 7e 7c             	mov    %edi,0x7c(%esi)
      c->proc = p;
80103c47:	89 b3 ac 00 00 00    	mov    %esi,0xac(%ebx)
      switchuvm(p);
80103c4d:	89 34 24             	mov    %esi,(%esp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c50:	81 c6 90 00 00 00    	add    $0x90,%esi
      switchuvm(p);
80103c56:	e8 a5 30 00 00       	call   80106d00 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103c5b:	8b 56 8c             	mov    -0x74(%esi),%edx
80103c5e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      p->state = RUNNING;
80103c61:	c7 86 7c ff ff ff 04 	movl   $0x4,-0x84(%esi)
80103c68:	00 00 00 
      swtch(&(c->scheduler), p->context);
80103c6b:	89 54 24 04          	mov    %edx,0x4(%esp)
80103c6f:	89 04 24             	mov    %eax,(%esp)
80103c72:	e8 74 0e 00 00       	call   80104aeb <swtch>
      switchkvm();
80103c77:	e8 64 30 00 00       	call   80106ce0 <switchkvm>
      p->oncpu = -1;
80103c7c:	c7 46 ec ff ff ff ff 	movl   $0xffffffff,-0x14(%esi)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c83:	81 fe 74 51 11 80    	cmp    $0x80115174,%esi
      c->proc = NULL;
80103c89:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80103c90:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c93:	75 a9                	jne    80103c3e <scheduler+0x5e>
80103c95:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ptable.lock);
80103c98:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103c9f:	e8 bc 0b 00 00       	call   80104860 <release>
  }
80103ca4:	e9 6f ff ff ff       	jmp    80103c18 <scheduler+0x38>
80103ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103cb0 <sched>:
{
80103cb0:	55                   	push   %ebp
80103cb1:	89 e5                	mov    %esp,%ebp
80103cb3:	56                   	push   %esi
80103cb4:	53                   	push   %ebx
80103cb5:	83 ec 10             	sub    $0x10,%esp
  struct proc *p = myproc();
80103cb8:	e8 53 fa ff ff       	call   80103710 <myproc>
  if(!holding(&ptable.lock))
80103cbd:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
  struct proc *p = myproc();
80103cc4:	89 c3                	mov    %eax,%ebx
  if(!holding(&ptable.lock))
80103cc6:	e8 e5 0a 00 00       	call   801047b0 <holding>
80103ccb:	85 c0                	test   %eax,%eax
80103ccd:	74 4f                	je     80103d1e <sched+0x6e>
  if(mycpu()->ncli != 1)
80103ccf:	e8 9c f9 ff ff       	call   80103670 <mycpu>
80103cd4:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103cdb:	75 65                	jne    80103d42 <sched+0x92>
  if(p->state == RUNNING)
80103cdd:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ce1:	74 53                	je     80103d36 <sched+0x86>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ce3:	9c                   	pushf  
80103ce4:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ce5:	f6 c4 02             	test   $0x2,%ah
80103ce8:	75 40                	jne    80103d2a <sched+0x7a>
  intena = mycpu()->intena;
80103cea:	e8 81 f9 ff ff       	call   80103670 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103cef:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103cf2:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103cf8:	e8 73 f9 ff ff       	call   80103670 <mycpu>
80103cfd:	8b 40 04             	mov    0x4(%eax),%eax
80103d00:	89 1c 24             	mov    %ebx,(%esp)
80103d03:	89 44 24 04          	mov    %eax,0x4(%esp)
80103d07:	e8 df 0d 00 00       	call   80104aeb <swtch>
  mycpu()->intena = intena;
80103d0c:	e8 5f f9 ff ff       	call   80103670 <mycpu>
80103d11:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103d17:	83 c4 10             	add    $0x10,%esp
80103d1a:	5b                   	pop    %ebx
80103d1b:	5e                   	pop    %esi
80103d1c:	5d                   	pop    %ebp
80103d1d:	c3                   	ret    
    panic("sched ptable.lock");
80103d1e:	c7 04 24 10 79 10 80 	movl   $0x80107910,(%esp)
80103d25:	e8 36 c6 ff ff       	call   80100360 <panic>
    panic("sched interruptible");
80103d2a:	c7 04 24 3c 79 10 80 	movl   $0x8010793c,(%esp)
80103d31:	e8 2a c6 ff ff       	call   80100360 <panic>
    panic("sched running");
80103d36:	c7 04 24 2e 79 10 80 	movl   $0x8010792e,(%esp)
80103d3d:	e8 1e c6 ff ff       	call   80100360 <panic>
    panic("sched locks");
80103d42:	c7 04 24 22 79 10 80 	movl   $0x80107922,(%esp)
80103d49:	e8 12 c6 ff ff       	call   80100360 <panic>
80103d4e:	66 90                	xchg   %ax,%ax

80103d50 <kthread_exit>:
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	56                   	push   %esi
80103d54:	53                   	push   %ebx
80103d55:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103d58:	e8 b3 f9 ff ff       	call   80103710 <myproc>
  if(curproc->isThread==1){
80103d5d:	66 83 b8 80 00 00 00 	cmpw   $0x1,0x80(%eax)
80103d64:	01 
  struct proc *curproc = myproc();
80103d65:	89 c6                	mov    %eax,%esi
  if(curproc->isThread==1){
80103d67:	74 07                	je     80103d70 <kthread_exit+0x20>
}
80103d69:	83 c4 10             	add    $0x10,%esp
80103d6c:	5b                   	pop    %ebx
80103d6d:	5e                   	pop    %esi
80103d6e:	5d                   	pop    %ebp
80103d6f:	c3                   	ret    
    if(curproc == initproc)
80103d70:	31 db                	xor    %ebx,%ebx
80103d72:	3b 05 bc a5 10 80    	cmp    0x8010a5bc,%eax
80103d78:	74 7d                	je     80103df7 <kthread_exit+0xa7>
80103d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(curproc->ofile[fd]){
80103d80:	8b 54 9e 28          	mov    0x28(%esi,%ebx,4),%edx
80103d84:	85 d2                	test   %edx,%edx
80103d86:	74 10                	je     80103d98 <kthread_exit+0x48>
        fileclose(curproc->ofile[fd]);
80103d88:	89 14 24             	mov    %edx,(%esp)
80103d8b:	e8 c0 d0 ff ff       	call   80100e50 <fileclose>
        curproc->ofile[fd] = 0;
80103d90:	c7 44 9e 28 00 00 00 	movl   $0x0,0x28(%esi,%ebx,4)
80103d97:	00 
    for(fd = 0; fd < NOFILE; fd++){
80103d98:	83 c3 01             	add    $0x1,%ebx
80103d9b:	83 fb 10             	cmp    $0x10,%ebx
80103d9e:	75 e0                	jne    80103d80 <kthread_exit+0x30>
    begin_op();
80103da0:	e8 9b ed ff ff       	call   80102b40 <begin_op>
    iput(curproc->cwd);
80103da5:	8b 46 68             	mov    0x68(%esi),%eax
80103da8:	89 04 24             	mov    %eax,(%esp)
80103dab:	e8 50 da ff ff       	call   80101800 <iput>
    end_op();
80103db0:	e8 fb ed ff ff       	call   80102bb0 <end_op>
    curproc->threadExitvalue=exitValue;
80103db5:	8b 45 08             	mov    0x8(%ebp),%eax
    curproc->cwd = 0;
80103db8:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
    curproc->killed=0;
80103dbf:	c7 46 24 00 00 00 00 	movl   $0x0,0x24(%esi)
    curproc->oncpu=-1;
80103dc6:	c7 46 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%esi)
    curproc->threadExitvalue=exitValue;
80103dcd:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
    curproc->state=ZOMBIE;
80103dd3:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
    acquire(&ptable.lock);
80103dda:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103de1:	e8 0a 0a 00 00       	call   801047f0 <acquire>
    sched();
80103de6:	e8 c5 fe ff ff       	call   80103cb0 <sched>
    panic("kthread_exit");
80103deb:	c7 04 24 5d 79 10 80 	movl   $0x8010795d,(%esp)
80103df2:	e8 69 c5 ff ff       	call   80100360 <panic>
    panic("init exiting");
80103df7:	c7 04 24 50 79 10 80 	movl   $0x80107950,(%esp)
80103dfe:	e8 5d c5 ff ff       	call   80100360 <panic>
80103e03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e10 <exit>:
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	56                   	push   %esi
  if(curproc == initproc)
80103e14:	31 f6                	xor    %esi,%esi
{
80103e16:	53                   	push   %ebx
80103e17:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103e1a:	e8 f1 f8 ff ff       	call   80103710 <myproc>
  if(curproc == initproc)
80103e1f:	3b 05 bc a5 10 80    	cmp    0x8010a5bc,%eax
  struct proc *curproc = myproc();
80103e25:	89 c3                	mov    %eax,%ebx
  if(curproc == initproc)
80103e27:	0f 84 fd 00 00 00    	je     80103f2a <exit+0x11a>
80103e2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103e30:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103e34:	85 c0                	test   %eax,%eax
80103e36:	74 10                	je     80103e48 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103e38:	89 04 24             	mov    %eax,(%esp)
80103e3b:	e8 10 d0 ff ff       	call   80100e50 <fileclose>
      curproc->ofile[fd] = 0;
80103e40:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103e47:	00 
  for(fd = 0; fd < NOFILE; fd++){
80103e48:	83 c6 01             	add    $0x1,%esi
80103e4b:	83 fe 10             	cmp    $0x10,%esi
80103e4e:	75 e0                	jne    80103e30 <exit+0x20>
  begin_op();
80103e50:	e8 eb ec ff ff       	call   80102b40 <begin_op>
  iput(curproc->cwd);
80103e55:	8b 43 68             	mov    0x68(%ebx),%eax
80103e58:	89 04 24             	mov    %eax,(%esp)
80103e5b:	e8 a0 d9 ff ff       	call   80101800 <iput>
  end_op();
80103e60:	e8 4b ed ff ff       	call   80102bb0 <end_op>
  curproc->cwd = 0;
80103e65:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103e6c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103e73:	e8 78 09 00 00       	call   801047f0 <acquire>
  wakeup1(curproc->parent);
80103e78:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103e7b:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103e80:	eb 14                	jmp    80103e96 <exit+0x86>
80103e82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e88:	81 c2 90 00 00 00    	add    $0x90,%edx
80103e8e:	81 fa 74 51 11 80    	cmp    $0x80115174,%edx
80103e94:	74 20                	je     80103eb6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80103e96:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103e9a:	75 ec                	jne    80103e88 <exit+0x78>
80103e9c:	3b 42 20             	cmp    0x20(%edx),%eax
80103e9f:	75 e7                	jne    80103e88 <exit+0x78>
      p->state = RUNNABLE;
80103ea1:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ea8:	81 c2 90 00 00 00    	add    $0x90,%edx
80103eae:	81 fa 74 51 11 80    	cmp    $0x80115174,%edx
80103eb4:	75 e0                	jne    80103e96 <exit+0x86>
      p->parent = initproc;
80103eb6:	a1 bc a5 10 80       	mov    0x8010a5bc,%eax
80103ebb:	b9 74 2d 11 80       	mov    $0x80112d74,%ecx
80103ec0:	eb 14                	jmp    80103ed6 <exit+0xc6>
80103ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ec8:	81 c1 90 00 00 00    	add    $0x90,%ecx
80103ece:	81 f9 74 51 11 80    	cmp    $0x80115174,%ecx
80103ed4:	74 3c                	je     80103f12 <exit+0x102>
    if(p->parent == curproc){
80103ed6:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103ed9:	75 ed                	jne    80103ec8 <exit+0xb8>
      if(p->state == ZOMBIE)
80103edb:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
      p->parent = initproc;
80103edf:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103ee2:	75 e4                	jne    80103ec8 <exit+0xb8>
80103ee4:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80103ee9:	eb 13                	jmp    80103efe <exit+0xee>
80103eeb:	90                   	nop
80103eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ef0:	81 c2 90 00 00 00    	add    $0x90,%edx
80103ef6:	81 fa 74 51 11 80    	cmp    $0x80115174,%edx
80103efc:	74 ca                	je     80103ec8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80103efe:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103f02:	75 ec                	jne    80103ef0 <exit+0xe0>
80103f04:	3b 42 20             	cmp    0x20(%edx),%eax
80103f07:	75 e7                	jne    80103ef0 <exit+0xe0>
      p->state = RUNNABLE;
80103f09:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103f10:	eb de                	jmp    80103ef0 <exit+0xe0>
  curproc->state = ZOMBIE;
80103f12:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f19:	e8 92 fd ff ff       	call   80103cb0 <sched>
  panic("zombie exit");
80103f1e:	c7 04 24 6a 79 10 80 	movl   $0x8010796a,(%esp)
80103f25:	e8 36 c4 ff ff       	call   80100360 <panic>
    panic("init exiting");
80103f2a:	c7 04 24 50 79 10 80 	movl   $0x80107950,(%esp)
80103f31:	e8 2a c4 ff ff       	call   80100360 <panic>
80103f36:	8d 76 00             	lea    0x0(%esi),%esi
80103f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103f40 <yield>:
{
80103f40:	55                   	push   %ebp
80103f41:	89 e5                	mov    %esp,%ebp
80103f43:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f46:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f4d:	e8 9e 08 00 00       	call   801047f0 <acquire>
  myproc()->state = RUNNABLE;
80103f52:	e8 b9 f7 ff ff       	call   80103710 <myproc>
80103f57:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103f5e:	e8 4d fd ff ff       	call   80103cb0 <sched>
  release(&ptable.lock);
80103f63:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f6a:	e8 f1 08 00 00       	call   80104860 <release>
}
80103f6f:	c9                   	leave  
80103f70:	c3                   	ret    
80103f71:	eb 0d                	jmp    80103f80 <kthread_join>
80103f73:	90                   	nop
80103f74:	90                   	nop
80103f75:	90                   	nop
80103f76:	90                   	nop
80103f77:	90                   	nop
80103f78:	90                   	nop
80103f79:	90                   	nop
80103f7a:	90                   	nop
80103f7b:	90                   	nop
80103f7c:	90                   	nop
80103f7d:	90                   	nop
80103f7e:	90                   	nop
80103f7f:	90                   	nop

80103f80 <kthread_join>:
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	57                   	push   %edi
80103f84:	56                   	push   %esi
80103f85:	53                   	push   %ebx
80103f86:	83 ec 1c             	sub    $0x1c,%esp
80103f89:	8b 75 08             	mov    0x8(%ebp),%esi
    struct proc *curproc = myproc();
80103f8c:	e8 7f f7 ff ff       	call   80103710 <myproc>
    acquire(&ptable.lock);
80103f91:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
    struct proc *curproc = myproc();
80103f98:	89 c7                	mov    %eax,%edi
    acquire(&ptable.lock);
80103f9a:	e8 51 08 00 00       	call   801047f0 <acquire>
    if(curproc->isParent==1 && curproc->threadCount==0){
80103f9f:	66 83 bf 82 00 00 00 	cmpw   $0x1,0x82(%edi)
80103fa6:	01 
80103fa7:	0f 84 db 00 00 00    	je     80104088 <kthread_join+0x108>
    if(tid==0){
80103fad:	85 f6                	test   %esi,%esi
80103faf:	0f 84 e3 00 00 00    	je     80104098 <kthread_join+0x118>
    if(curproc->isThread==1){
80103fb5:	66 83 bf 80 00 00 00 	cmpw   $0x1,0x80(%edi)
80103fbc:	01 
80103fbd:	0f 84 ee 00 00 00    	je     801040b1 <kthread_join+0x131>
      for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fc3:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80103fc8:	eb 18                	jmp    80103fe2 <kthread_join+0x62>
80103fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103fd0:	81 c3 90 00 00 00    	add    $0x90,%ebx
80103fd6:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
80103fdc:	0f 84 b6 00 00 00    	je     80104098 <kthread_join+0x118>
        if(p->state==UNUSED ||p->parent==NULL || p->parent != curproc || p->tid!=tid ||p->isThread==0){
80103fe2:	8b 53 0c             	mov    0xc(%ebx),%edx
80103fe5:	85 d2                	test   %edx,%edx
80103fe7:	74 e7                	je     80103fd0 <kthread_join+0x50>
80103fe9:	8b 4b 14             	mov    0x14(%ebx),%ecx
80103fec:	85 c9                	test   %ecx,%ecx
80103fee:	74 e0                	je     80103fd0 <kthread_join+0x50>
80103ff0:	39 cf                	cmp    %ecx,%edi
80103ff2:	75 dc                	jne    80103fd0 <kthread_join+0x50>
80103ff4:	0f b7 83 86 00 00 00 	movzwl 0x86(%ebx),%eax
80103ffb:	39 f0                	cmp    %esi,%eax
80103ffd:	75 d1                	jne    80103fd0 <kthread_join+0x50>
80103fff:	66 83 bb 80 00 00 00 	cmpw   $0x0,0x80(%ebx)
80104006:	00 
80104007:	74 c7                	je     80103fd0 <kthread_join+0x50>
        while(p->state!=ZOMBIE){
80104009:	83 fa 05             	cmp    $0x5,%edx
8010400c:	74 25                	je     80104033 <kthread_join+0xb3>
8010400e:	66 90                	xchg   %ax,%ax
          release(&ptable.lock);
80104010:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104017:	e8 44 08 00 00       	call   80104860 <release>
          yield();
8010401c:	e8 1f ff ff ff       	call   80103f40 <yield>
          acquire(&ptable.lock);
80104021:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104028:	e8 c3 07 00 00       	call   801047f0 <acquire>
        while(p->state!=ZOMBIE){
8010402d:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104031:	75 dd                	jne    80104010 <kthread_join+0x90>
        curproc->threadCount--;
80104033:	66 83 af 84 00 00 00 	subw   $0x1,0x84(%edi)
8010403a:	01 
        if(p->state == ZOMBIE){
8010403b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010403f:	75 8f                	jne    80103fd0 <kthread_join+0x50>
          kfree(p->kstack);
80104041:	8b 43 08             	mov    0x8(%ebx),%eax
80104044:	89 04 24             	mov    %eax,(%esp)
80104047:	e8 d4 e2 ff ff       	call   80102320 <kfree>
        release(&ptable.lock);
8010404c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
          p->kstack = 0;
80104053:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
          p->pid = 0;
8010405a:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
          p->parent = 0;
80104061:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
          p->name[0] = 0;
80104068:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
          p->killed = 0;
8010406c:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
          p->state = UNUSED;
80104073:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010407a:	e8 e1 07 00 00       	call   80104860 <release>
        return 0;
8010407f:	31 c0                	xor    %eax,%eax
80104081:	eb 26                	jmp    801040a9 <kthread_join+0x129>
80104083:	90                   	nop
80104084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->isParent==1 && curproc->threadCount==0){
80104088:	66 83 bf 84 00 00 00 	cmpw   $0x0,0x84(%edi)
8010408f:	00 
80104090:	0f 85 17 ff ff ff    	jne    80103fad <kthread_join+0x2d>
80104096:	66 90                	xchg   %ax,%ax
      release(&ptable.lock);
80104098:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010409f:	e8 bc 07 00 00       	call   80104860 <release>
      return -1;
801040a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040a9:	83 c4 1c             	add    $0x1c,%esp
801040ac:	5b                   	pop    %ebx
801040ad:	5e                   	pop    %esi
801040ae:	5f                   	pop    %edi
801040af:	5d                   	pop    %ebp
801040b0:	c3                   	ret    
      curproc=curproc->parent;
801040b1:	8b 7f 14             	mov    0x14(%edi),%edi
801040b4:	e9 0a ff ff ff       	jmp    80103fc3 <kthread_join+0x43>
801040b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801040c0 <sleep>:
{
801040c0:	55                   	push   %ebp
801040c1:	89 e5                	mov    %esp,%ebp
801040c3:	57                   	push   %edi
801040c4:	56                   	push   %esi
801040c5:	53                   	push   %ebx
801040c6:	83 ec 1c             	sub    $0x1c,%esp
801040c9:	8b 7d 08             	mov    0x8(%ebp),%edi
801040cc:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct proc *p = myproc();
801040cf:	e8 3c f6 ff ff       	call   80103710 <myproc>
  if(p == 0)
801040d4:	85 c0                	test   %eax,%eax
  struct proc *p = myproc();
801040d6:	89 c3                	mov    %eax,%ebx
  if(p == 0)
801040d8:	0f 84 7c 00 00 00    	je     8010415a <sleep+0x9a>
  if(lk == 0)
801040de:	85 f6                	test   %esi,%esi
801040e0:	74 6c                	je     8010414e <sleep+0x8e>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801040e2:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
801040e8:	74 46                	je     80104130 <sleep+0x70>
    acquire(&ptable.lock);  //DOC: sleeplock1
801040ea:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801040f1:	e8 fa 06 00 00       	call   801047f0 <acquire>
    release(lk);
801040f6:	89 34 24             	mov    %esi,(%esp)
801040f9:	e8 62 07 00 00       	call   80104860 <release>
  p->chan = chan;
801040fe:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104101:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104108:	e8 a3 fb ff ff       	call   80103cb0 <sched>
  p->chan = 0;
8010410d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104114:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010411b:	e8 40 07 00 00       	call   80104860 <release>
    acquire(lk);
80104120:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104123:	83 c4 1c             	add    $0x1c,%esp
80104126:	5b                   	pop    %ebx
80104127:	5e                   	pop    %esi
80104128:	5f                   	pop    %edi
80104129:	5d                   	pop    %ebp
    acquire(lk);
8010412a:	e9 c1 06 00 00       	jmp    801047f0 <acquire>
8010412f:	90                   	nop
  p->chan = chan;
80104130:	89 78 20             	mov    %edi,0x20(%eax)
  p->state = SLEEPING;
80104133:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
8010413a:	e8 71 fb ff ff       	call   80103cb0 <sched>
  p->chan = 0;
8010413f:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104146:	83 c4 1c             	add    $0x1c,%esp
80104149:	5b                   	pop    %ebx
8010414a:	5e                   	pop    %esi
8010414b:	5f                   	pop    %edi
8010414c:	5d                   	pop    %ebp
8010414d:	c3                   	ret    
    panic("sleep without lk");
8010414e:	c7 04 24 7c 79 10 80 	movl   $0x8010797c,(%esp)
80104155:	e8 06 c2 ff ff       	call   80100360 <panic>
    panic("sleep");
8010415a:	c7 04 24 76 79 10 80 	movl   $0x80107976,(%esp)
80104161:	e8 fa c1 ff ff       	call   80100360 <panic>
80104166:	8d 76 00             	lea    0x0(%esi),%esi
80104169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104170 <wait>:
{
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	56                   	push   %esi
80104174:	53                   	push   %ebx
80104175:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80104178:	e8 93 f5 ff ff       	call   80103710 <myproc>
  acquire(&ptable.lock);
8010417d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
  struct proc *curproc = myproc();
80104184:	89 c6                	mov    %eax,%esi
  acquire(&ptable.lock);
80104186:	e8 65 06 00 00       	call   801047f0 <acquire>
    havekids = 0;
8010418b:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010418d:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104192:	eb 12                	jmp    801041a6 <wait+0x36>
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104198:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010419e:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
801041a4:	74 2a                	je     801041d0 <wait+0x60>
      if(p->parent != curproc || p->isThread==1){
801041a6:	39 73 14             	cmp    %esi,0x14(%ebx)
801041a9:	75 ed                	jne    80104198 <wait+0x28>
801041ab:	66 83 bb 80 00 00 00 	cmpw   $0x1,0x80(%ebx)
801041b2:	01 
801041b3:	74 e3                	je     80104198 <wait+0x28>
      if(p->state == ZOMBIE){
801041b5:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801041b9:	74 32                	je     801041ed <wait+0x7d>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041bb:	81 c3 90 00 00 00    	add    $0x90,%ebx
      havekids = 1;
801041c1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041c6:	81 fb 74 51 11 80    	cmp    $0x80115174,%ebx
801041cc:	75 d8                	jne    801041a6 <wait+0x36>
801041ce:	66 90                	xchg   %ax,%ax
    if(!havekids || curproc->killed){
801041d0:	85 c0                	test   %eax,%eax
801041d2:	74 6e                	je     80104242 <wait+0xd2>
801041d4:	8b 46 24             	mov    0x24(%esi),%eax
801041d7:	85 c0                	test   %eax,%eax
801041d9:	75 67                	jne    80104242 <wait+0xd2>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801041db:	c7 44 24 04 40 2d 11 	movl   $0x80112d40,0x4(%esp)
801041e2:	80 
801041e3:	89 34 24             	mov    %esi,(%esp)
801041e6:	e8 d5 fe ff ff       	call   801040c0 <sleep>
  }
801041eb:	eb 9e                	jmp    8010418b <wait+0x1b>
        kfree(p->kstack);
801041ed:	8b 43 08             	mov    0x8(%ebx),%eax
        pid = p->pid;
801041f0:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801041f3:	89 04 24             	mov    %eax,(%esp)
801041f6:	e8 25 e1 ff ff       	call   80102320 <kfree>
        freevm(p->pgdir);
801041fb:	8b 43 04             	mov    0x4(%ebx),%eax
        p->kstack = 0;
801041fe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104205:	89 04 24             	mov    %eax,(%esp)
80104208:	e8 53 2e 00 00       	call   80107060 <freevm>
        release(&ptable.lock);
8010420d:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
        p->pid = 0;
80104214:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010421b:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104222:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104226:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010422d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104234:	e8 27 06 00 00       	call   80104860 <release>
}
80104239:	83 c4 10             	add    $0x10,%esp
        return pid;
8010423c:	89 f0                	mov    %esi,%eax
}
8010423e:	5b                   	pop    %ebx
8010423f:	5e                   	pop    %esi
80104240:	5d                   	pop    %ebp
80104241:	c3                   	ret    
      release(&ptable.lock);
80104242:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104249:	e8 12 06 00 00       	call   80104860 <release>
}
8010424e:	83 c4 10             	add    $0x10,%esp
      return -1;
80104251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104256:	5b                   	pop    %ebx
80104257:	5e                   	pop    %esi
80104258:	5d                   	pop    %ebp
80104259:	c3                   	ret    
8010425a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104260 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	53                   	push   %ebx
80104264:	83 ec 14             	sub    $0x14,%esp
80104267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010426a:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104271:	e8 7a 05 00 00       	call   801047f0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104276:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010427b:	eb 0f                	jmp    8010428c <wakeup+0x2c>
8010427d:	8d 76 00             	lea    0x0(%esi),%esi
80104280:	05 90 00 00 00       	add    $0x90,%eax
80104285:	3d 74 51 11 80       	cmp    $0x80115174,%eax
8010428a:	74 24                	je     801042b0 <wakeup+0x50>
    if(p->state == SLEEPING && p->chan == chan)
8010428c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104290:	75 ee                	jne    80104280 <wakeup+0x20>
80104292:	3b 58 20             	cmp    0x20(%eax),%ebx
80104295:	75 e9                	jne    80104280 <wakeup+0x20>
      p->state = RUNNABLE;
80104297:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010429e:	05 90 00 00 00       	add    $0x90,%eax
801042a3:	3d 74 51 11 80       	cmp    $0x80115174,%eax
801042a8:	75 e2                	jne    8010428c <wakeup+0x2c>
801042aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  wakeup1(chan);
  release(&ptable.lock);
801042b0:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801042b7:	83 c4 14             	add    $0x14,%esp
801042ba:	5b                   	pop    %ebx
801042bb:	5d                   	pop    %ebp
  release(&ptable.lock);
801042bc:	e9 9f 05 00 00       	jmp    80104860 <release>
801042c1:	eb 0d                	jmp    801042d0 <kill>
801042c3:	90                   	nop
801042c4:	90                   	nop
801042c5:	90                   	nop
801042c6:	90                   	nop
801042c7:	90                   	nop
801042c8:	90                   	nop
801042c9:	90                   	nop
801042ca:	90                   	nop
801042cb:	90                   	nop
801042cc:	90                   	nop
801042cd:	90                   	nop
801042ce:	90                   	nop
801042cf:	90                   	nop

801042d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx
801042d4:	83 ec 14             	sub    $0x14,%esp
801042d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801042da:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801042e1:	e8 0a 05 00 00       	call   801047f0 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e6:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801042eb:	eb 0f                	jmp    801042fc <kill+0x2c>
801042ed:	8d 76 00             	lea    0x0(%esi),%esi
801042f0:	05 90 00 00 00       	add    $0x90,%eax
801042f5:	3d 74 51 11 80       	cmp    $0x80115174,%eax
801042fa:	74 3c                	je     80104338 <kill+0x68>
    if(p->pid == pid){
801042fc:	39 58 10             	cmp    %ebx,0x10(%eax)
801042ff:	75 ef                	jne    801042f0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104301:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104305:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010430c:	74 1a                	je     80104328 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010430e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104315:	e8 46 05 00 00       	call   80104860 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
8010431a:	83 c4 14             	add    $0x14,%esp
      return 0;
8010431d:	31 c0                	xor    %eax,%eax
}
8010431f:	5b                   	pop    %ebx
80104320:	5d                   	pop    %ebp
80104321:	c3                   	ret    
80104322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        p->state = RUNNABLE;
80104328:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010432f:	eb dd                	jmp    8010430e <kill+0x3e>
80104331:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104338:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010433f:	e8 1c 05 00 00       	call   80104860 <release>
}
80104344:	83 c4 14             	add    $0x14,%esp
  return -1;
80104347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010434c:	5b                   	pop    %ebx
8010434d:	5d                   	pop    %ebp
8010434e:	c3                   	ret    
8010434f:	90                   	nop

80104350 <sys_cps>:
};

#ifdef CPS
int
sys_cps(void)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	53                   	push   %ebx
80104354:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80104359:	83 ec 24             	sub    $0x24,%esp
    int i;
    const char *state = NULL;

    acquire(&ptable.lock);
8010435c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104363:	e8 88 04 00 00       	call   801047f0 <acquire>
    cprintf(
80104368:	c7 04 24 40 7a 10 80 	movl   $0x80107a40,(%esp)
8010436f:	e8 dc c2 ff ff       	call   80100650 <cprintf>
        "pid\tppid\tname\tstate\tsize\tcpu\tis_par\tis_thrd\tthrd #"
        );
    cprintf("\n");
80104374:	c7 04 24 e7 7d 10 80 	movl   $0x80107de7,(%esp)
8010437b:	e8 d0 c2 ff ff       	call   80100650 <cprintf>
80104380:	eb 6c                	jmp    801043ee <sys_cps+0x9e>
80104382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                    , ptable.proc[i].parent ? ptable.proc[i].parent->pid : 1
                    , ptable.proc[i].name, state
                    , ptable.proc[i].sz
                );
            if(ptable.proc[i].oncpu>=0){
              cprintf("%u\t",ptable.proc[i].oncpu);
80104388:	89 44 24 04          	mov    %eax,0x4(%esp)
8010438c:	c7 04 24 a0 79 10 80 	movl   $0x801079a0,(%esp)
80104393:	e8 b8 c2 ff ff       	call   80100650 <cprintf>
            }
            else{
              cprintf(" \t");
            }
            cprintf("%u\t",ptable.proc[i].isParent);
80104398:	0f b7 43 16          	movzwl 0x16(%ebx),%eax
8010439c:	c7 04 24 a0 79 10 80 	movl   $0x801079a0,(%esp)
801043a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801043a7:	e8 a4 c2 ff ff       	call   80100650 <cprintf>
            cprintf("%u\t",ptable.proc[i].isThread);
801043ac:	0f b7 43 14          	movzwl 0x14(%ebx),%eax
801043b0:	c7 04 24 a0 79 10 80 	movl   $0x801079a0,(%esp)
801043b7:	89 44 24 04          	mov    %eax,0x4(%esp)
801043bb:	e8 90 c2 ff ff       	call   80100650 <cprintf>
            cprintf("%u\t",ptable.proc[i].threadCount);
801043c0:	0f b7 43 18          	movzwl 0x18(%ebx),%eax
801043c4:	c7 04 24 a0 79 10 80 	movl   $0x801079a0,(%esp)
801043cb:	89 44 24 04          	mov    %eax,0x4(%esp)
801043cf:	e8 7c c2 ff ff       	call   80100650 <cprintf>
            cprintf("\n");
801043d4:	c7 04 24 e7 7d 10 80 	movl   $0x80107de7,(%esp)
801043db:	e8 70 c2 ff ff       	call   80100650 <cprintf>
801043e0:	81 c3 90 00 00 00    	add    $0x90,%ebx
    for (i = 0; i < NPROC; i++) {
801043e6:	81 fb e0 51 11 80    	cmp    $0x801151e0,%ebx
801043ec:	74 7a                	je     80104468 <sys_cps+0x118>
        if (ptable.proc[i].state != UNUSED) {
801043ee:	8b 43 a0             	mov    -0x60(%ebx),%eax
801043f1:	85 c0                	test   %eax,%eax
801043f3:	74 eb                	je     801043e0 <sys_cps+0x90>
            if (ptable.proc[i].state >= 0 && ptable.proc[i].state < NELEM(states)
801043f5:	83 f8 05             	cmp    $0x5,%eax
                state = "uknown";
801043f8:	ba 8d 79 10 80       	mov    $0x8010798d,%edx
            if (ptable.proc[i].state >= 0 && ptable.proc[i].state < NELEM(states)
801043fd:	77 11                	ja     80104410 <sys_cps+0xc0>
                && states[ptable.proc[i].state]) {
801043ff:	8b 14 85 88 7a 10 80 	mov    -0x7fef8578(,%eax,4),%edx
                state = "uknown";
80104406:	b8 8d 79 10 80       	mov    $0x8010798d,%eax
8010440b:	85 d2                	test   %edx,%edx
8010440d:	0f 44 d0             	cmove  %eax,%edx
                    , ptable.proc[i].parent ? ptable.proc[i].parent->pid : 1
80104410:	8b 43 a8             	mov    -0x58(%ebx),%eax
            cprintf("%d\t%d\t%s\t%s\t%u\t"
80104413:	8b 4b 94             	mov    -0x6c(%ebx),%ecx
80104416:	85 c0                	test   %eax,%eax
80104418:	74 46                	je     80104460 <sys_cps+0x110>
8010441a:	8b 40 10             	mov    0x10(%eax),%eax
8010441d:	89 44 24 08          	mov    %eax,0x8(%esp)
80104421:	8b 43 a4             	mov    -0x5c(%ebx),%eax
80104424:	89 4c 24 14          	mov    %ecx,0x14(%esp)
80104428:	89 54 24 10          	mov    %edx,0x10(%esp)
8010442c:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
80104430:	89 44 24 04          	mov    %eax,0x4(%esp)
80104434:	c7 04 24 94 79 10 80 	movl   $0x80107994,(%esp)
8010443b:	e8 10 c2 ff ff       	call   80100650 <cprintf>
            if(ptable.proc[i].oncpu>=0){
80104440:	8b 43 10             	mov    0x10(%ebx),%eax
80104443:	85 c0                	test   %eax,%eax
80104445:	0f 89 3d ff ff ff    	jns    80104388 <sys_cps+0x38>
              cprintf(" \t");
8010444b:	c7 04 24 a4 79 10 80 	movl   $0x801079a4,(%esp)
80104452:	e8 f9 c1 ff ff       	call   80100650 <cprintf>
80104457:	e9 3c ff ff ff       	jmp    80104398 <sys_cps+0x48>
8010445c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
            cprintf("%d\t%d\t%s\t%s\t%u\t"
80104460:	b8 01 00 00 00       	mov    $0x1,%eax
80104465:	eb b6                	jmp    8010441d <sys_cps+0xcd>
80104467:	90                   	nop
        }
        else {
            // UNUSED process table entry is ignored
        }
    }
    release(&ptable.lock);
80104468:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010446f:	e8 ec 03 00 00       	call   80104860 <release>

    return 0;
}
80104474:	83 c4 24             	add    $0x24,%esp
80104477:	31 c0                	xor    %eax,%eax
80104479:	5b                   	pop    %ebx
8010447a:	5d                   	pop    %ebp
8010447b:	c3                   	ret    
8010447c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104480 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	57                   	push   %edi
80104484:	56                   	push   %esi
80104485:	53                   	push   %ebx
80104486:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
8010448b:	83 ec 4c             	sub    $0x4c,%esp
8010448e:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104491:	eb 23                	jmp    801044b6 <procdump+0x36>
80104493:	90                   	nop
80104494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104498:	c7 04 24 e7 7d 10 80 	movl   $0x80107de7,(%esp)
8010449f:	e8 ac c1 ff ff       	call   80100650 <cprintf>
801044a4:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044aa:	81 fb e0 51 11 80    	cmp    $0x801151e0,%ebx
801044b0:	0f 84 8a 00 00 00    	je     80104540 <procdump+0xc0>
    if(p->state == UNUSED)
801044b6:	8b 43 a0             	mov    -0x60(%ebx),%eax
801044b9:	85 c0                	test   %eax,%eax
801044bb:	74 e7                	je     801044a4 <procdump+0x24>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801044bd:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
801044c0:	ba a7 79 10 80       	mov    $0x801079a7,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801044c5:	77 11                	ja     801044d8 <procdump+0x58>
801044c7:	8b 14 85 88 7a 10 80 	mov    -0x7fef8578(,%eax,4),%edx
      state = "???";
801044ce:	b8 a7 79 10 80       	mov    $0x801079a7,%eax
801044d3:	85 d2                	test   %edx,%edx
801044d5:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801044d8:	8b 43 a4             	mov    -0x5c(%ebx),%eax
801044db:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
801044df:	89 54 24 08          	mov    %edx,0x8(%esp)
801044e3:	c7 04 24 ab 79 10 80 	movl   $0x801079ab,(%esp)
801044ea:	89 44 24 04          	mov    %eax,0x4(%esp)
801044ee:	e8 5d c1 ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
801044f3:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801044f7:	75 9f                	jne    80104498 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801044f9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801044fc:	89 44 24 04          	mov    %eax,0x4(%esp)
80104500:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104503:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104506:	8b 40 0c             	mov    0xc(%eax),%eax
80104509:	83 c0 08             	add    $0x8,%eax
8010450c:	89 04 24             	mov    %eax,(%esp)
8010450f:	e8 8c 01 00 00       	call   801046a0 <getcallerpcs>
80104514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104518:	8b 17                	mov    (%edi),%edx
8010451a:	85 d2                	test   %edx,%edx
8010451c:	0f 84 76 ff ff ff    	je     80104498 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104522:	89 54 24 04          	mov    %edx,0x4(%esp)
80104526:	83 c7 04             	add    $0x4,%edi
80104529:	c7 04 24 c1 73 10 80 	movl   $0x801073c1,(%esp)
80104530:	e8 1b c1 ff ff       	call   80100650 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104535:	39 f7                	cmp    %esi,%edi
80104537:	75 df                	jne    80104518 <procdump+0x98>
80104539:	e9 5a ff ff ff       	jmp    80104498 <procdump+0x18>
8010453e:	66 90                	xchg   %ax,%ax
  }
}
80104540:	83 c4 4c             	add    $0x4c,%esp
80104543:	5b                   	pop    %ebx
80104544:	5e                   	pop    %esi
80104545:	5f                   	pop    %edi
80104546:	5d                   	pop    %ebp
80104547:	c3                   	ret    
80104548:	66 90                	xchg   %ax,%ax
8010454a:	66 90                	xchg   %ax,%ax
8010454c:	66 90                	xchg   %ax,%ax
8010454e:	66 90                	xchg   %ax,%ax

80104550 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	53                   	push   %ebx
80104554:	83 ec 14             	sub    $0x14,%esp
80104557:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010455a:	c7 44 24 04 a0 7a 10 	movl   $0x80107aa0,0x4(%esp)
80104561:	80 
80104562:	8d 43 04             	lea    0x4(%ebx),%eax
80104565:	89 04 24             	mov    %eax,(%esp)
80104568:	e8 13 01 00 00       	call   80104680 <initlock>
  lk->name = name;
8010456d:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104570:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104576:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010457d:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104580:	83 c4 14             	add    $0x14,%esp
80104583:	5b                   	pop    %ebx
80104584:	5d                   	pop    %ebp
80104585:	c3                   	ret    
80104586:	8d 76 00             	lea    0x0(%esi),%esi
80104589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104590 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	56                   	push   %esi
80104594:	53                   	push   %ebx
80104595:	83 ec 10             	sub    $0x10,%esp
80104598:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010459b:	8d 73 04             	lea    0x4(%ebx),%esi
8010459e:	89 34 24             	mov    %esi,(%esp)
801045a1:	e8 4a 02 00 00       	call   801047f0 <acquire>
  while (lk->locked) {
801045a6:	8b 13                	mov    (%ebx),%edx
801045a8:	85 d2                	test   %edx,%edx
801045aa:	74 16                	je     801045c2 <acquiresleep+0x32>
801045ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
801045b0:	89 74 24 04          	mov    %esi,0x4(%esp)
801045b4:	89 1c 24             	mov    %ebx,(%esp)
801045b7:	e8 04 fb ff ff       	call   801040c0 <sleep>
  while (lk->locked) {
801045bc:	8b 03                	mov    (%ebx),%eax
801045be:	85 c0                	test   %eax,%eax
801045c0:	75 ee                	jne    801045b0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801045c2:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801045c8:	e8 43 f1 ff ff       	call   80103710 <myproc>
801045cd:	8b 40 10             	mov    0x10(%eax),%eax
801045d0:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801045d3:	89 75 08             	mov    %esi,0x8(%ebp)
}
801045d6:	83 c4 10             	add    $0x10,%esp
801045d9:	5b                   	pop    %ebx
801045da:	5e                   	pop    %esi
801045db:	5d                   	pop    %ebp
  release(&lk->lk);
801045dc:	e9 7f 02 00 00       	jmp    80104860 <release>
801045e1:	eb 0d                	jmp    801045f0 <releasesleep>
801045e3:	90                   	nop
801045e4:	90                   	nop
801045e5:	90                   	nop
801045e6:	90                   	nop
801045e7:	90                   	nop
801045e8:	90                   	nop
801045e9:	90                   	nop
801045ea:	90                   	nop
801045eb:	90                   	nop
801045ec:	90                   	nop
801045ed:	90                   	nop
801045ee:	90                   	nop
801045ef:	90                   	nop

801045f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	56                   	push   %esi
801045f4:	53                   	push   %ebx
801045f5:	83 ec 10             	sub    $0x10,%esp
801045f8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045fb:	8d 73 04             	lea    0x4(%ebx),%esi
801045fe:	89 34 24             	mov    %esi,(%esp)
80104601:	e8 ea 01 00 00       	call   801047f0 <acquire>
  lk->locked = 0;
80104606:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010460c:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104613:	89 1c 24             	mov    %ebx,(%esp)
80104616:	e8 45 fc ff ff       	call   80104260 <wakeup>
  release(&lk->lk);
8010461b:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010461e:	83 c4 10             	add    $0x10,%esp
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5d                   	pop    %ebp
  release(&lk->lk);
80104624:	e9 37 02 00 00       	jmp    80104860 <release>
80104629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104630 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
80104634:	31 ff                	xor    %edi,%edi
{
80104636:	56                   	push   %esi
80104637:	53                   	push   %ebx
80104638:	83 ec 1c             	sub    $0x1c,%esp
8010463b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
8010463e:	8d 73 04             	lea    0x4(%ebx),%esi
80104641:	89 34 24             	mov    %esi,(%esp)
80104644:	e8 a7 01 00 00       	call   801047f0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104649:	8b 03                	mov    (%ebx),%eax
8010464b:	85 c0                	test   %eax,%eax
8010464d:	74 13                	je     80104662 <holdingsleep+0x32>
8010464f:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104652:	e8 b9 f0 ff ff       	call   80103710 <myproc>
80104657:	3b 58 10             	cmp    0x10(%eax),%ebx
8010465a:	0f 94 c0             	sete   %al
8010465d:	0f b6 c0             	movzbl %al,%eax
80104660:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104662:	89 34 24             	mov    %esi,(%esp)
80104665:	e8 f6 01 00 00       	call   80104860 <release>
  return r;
}
8010466a:	83 c4 1c             	add    $0x1c,%esp
8010466d:	89 f8                	mov    %edi,%eax
8010466f:	5b                   	pop    %ebx
80104670:	5e                   	pop    %esi
80104671:	5f                   	pop    %edi
80104672:	5d                   	pop    %ebp
80104673:	c3                   	ret    
80104674:	66 90                	xchg   %ax,%ax
80104676:	66 90                	xchg   %ax,%ax
80104678:	66 90                	xchg   %ax,%ax
8010467a:	66 90                	xchg   %ax,%ax
8010467c:	66 90                	xchg   %ax,%ax
8010467e:	66 90                	xchg   %ax,%ax

80104680 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104686:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104689:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010468f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104692:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104699:	5d                   	pop    %ebp
8010469a:	c3                   	ret    
8010469b:	90                   	nop
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801046a3:	8b 45 08             	mov    0x8(%ebp),%eax
{
801046a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801046a9:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801046aa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801046ad:	31 c0                	xor    %eax,%eax
801046af:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046b0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801046b6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801046bc:	77 1a                	ja     801046d8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801046be:	8b 5a 04             	mov    0x4(%edx),%ebx
801046c1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801046c4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801046c7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801046c9:	83 f8 0a             	cmp    $0xa,%eax
801046cc:	75 e2                	jne    801046b0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801046ce:	5b                   	pop    %ebx
801046cf:	5d                   	pop    %ebp
801046d0:	c3                   	ret    
801046d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
801046d8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801046df:	83 c0 01             	add    $0x1,%eax
801046e2:	83 f8 0a             	cmp    $0xa,%eax
801046e5:	74 e7                	je     801046ce <getcallerpcs+0x2e>
    pcs[i] = 0;
801046e7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
  for(; i < 10; i++)
801046ee:	83 c0 01             	add    $0x1,%eax
801046f1:	83 f8 0a             	cmp    $0xa,%eax
801046f4:	75 e2                	jne    801046d8 <getcallerpcs+0x38>
801046f6:	eb d6                	jmp    801046ce <getcallerpcs+0x2e>
801046f8:	90                   	nop
801046f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104700 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	53                   	push   %ebx
80104704:	83 ec 04             	sub    $0x4,%esp
80104707:	9c                   	pushf  
80104708:	5b                   	pop    %ebx
  asm volatile("cli");
80104709:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010470a:	e8 61 ef ff ff       	call   80103670 <mycpu>
8010470f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104715:	85 c0                	test   %eax,%eax
80104717:	75 11                	jne    8010472a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104719:	e8 52 ef ff ff       	call   80103670 <mycpu>
8010471e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104724:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010472a:	e8 41 ef ff ff       	call   80103670 <mycpu>
8010472f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104736:	83 c4 04             	add    $0x4,%esp
80104739:	5b                   	pop    %ebx
8010473a:	5d                   	pop    %ebp
8010473b:	c3                   	ret    
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104740 <popcli>:

void
popcli(void)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	83 ec 18             	sub    $0x18,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104746:	9c                   	pushf  
80104747:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104748:	f6 c4 02             	test   $0x2,%ah
8010474b:	75 49                	jne    80104796 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010474d:	e8 1e ef ff ff       	call   80103670 <mycpu>
80104752:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
80104758:	8d 51 ff             	lea    -0x1(%ecx),%edx
8010475b:	85 d2                	test   %edx,%edx
8010475d:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
80104763:	78 25                	js     8010478a <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104765:	e8 06 ef ff ff       	call   80103670 <mycpu>
8010476a:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104770:	85 d2                	test   %edx,%edx
80104772:	74 04                	je     80104778 <popcli+0x38>
    sti();
}
80104774:	c9                   	leave  
80104775:	c3                   	ret    
80104776:	66 90                	xchg   %ax,%ax
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104778:	e8 f3 ee ff ff       	call   80103670 <mycpu>
8010477d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104783:	85 c0                	test   %eax,%eax
80104785:	74 ed                	je     80104774 <popcli+0x34>
  asm volatile("sti");
80104787:	fb                   	sti    
}
80104788:	c9                   	leave  
80104789:	c3                   	ret    
    panic("popcli");
8010478a:	c7 04 24 c2 7a 10 80 	movl   $0x80107ac2,(%esp)
80104791:	e8 ca bb ff ff       	call   80100360 <panic>
    panic("popcli - interruptible");
80104796:	c7 04 24 ab 7a 10 80 	movl   $0x80107aab,(%esp)
8010479d:	e8 be bb ff ff       	call   80100360 <panic>
801047a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047b0 <holding>:
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
  r = lock->locked && lock->cpu == mycpu();
801047b4:	31 f6                	xor    %esi,%esi
{
801047b6:	53                   	push   %ebx
801047b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801047ba:	e8 41 ff ff ff       	call   80104700 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801047bf:	8b 03                	mov    (%ebx),%eax
801047c1:	85 c0                	test   %eax,%eax
801047c3:	74 12                	je     801047d7 <holding+0x27>
801047c5:	8b 5b 08             	mov    0x8(%ebx),%ebx
801047c8:	e8 a3 ee ff ff       	call   80103670 <mycpu>
801047cd:	39 c3                	cmp    %eax,%ebx
801047cf:	0f 94 c0             	sete   %al
801047d2:	0f b6 c0             	movzbl %al,%eax
801047d5:	89 c6                	mov    %eax,%esi
  popcli();
801047d7:	e8 64 ff ff ff       	call   80104740 <popcli>
}
801047dc:	89 f0                	mov    %esi,%eax
801047de:	5b                   	pop    %ebx
801047df:	5e                   	pop    %esi
801047e0:	5d                   	pop    %ebp
801047e1:	c3                   	ret    
801047e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047f0 <acquire>:
{
801047f0:	55                   	push   %ebp
801047f1:	89 e5                	mov    %esp,%ebp
801047f3:	53                   	push   %ebx
801047f4:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801047f7:	e8 04 ff ff ff       	call   80104700 <pushcli>
  if(holding(lk))
801047fc:	8b 45 08             	mov    0x8(%ebp),%eax
801047ff:	89 04 24             	mov    %eax,(%esp)
80104802:	e8 a9 ff ff ff       	call   801047b0 <holding>
80104807:	85 c0                	test   %eax,%eax
80104809:	75 3a                	jne    80104845 <acquire+0x55>
  asm volatile("lock; xchgl %0, %1" :
8010480b:	b9 01 00 00 00       	mov    $0x1,%ecx
  while(xchg(&lk->locked, 1) != 0)
80104810:	8b 55 08             	mov    0x8(%ebp),%edx
80104813:	89 c8                	mov    %ecx,%eax
80104815:	f0 87 02             	lock xchg %eax,(%edx)
80104818:	85 c0                	test   %eax,%eax
8010481a:	75 f4                	jne    80104810 <acquire+0x20>
  __sync_synchronize();
8010481c:	0f ae f0             	mfence 
  lk->cpu = mycpu();
8010481f:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104822:	e8 49 ee ff ff       	call   80103670 <mycpu>
80104827:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
8010482a:	8b 45 08             	mov    0x8(%ebp),%eax
8010482d:	83 c0 0c             	add    $0xc,%eax
80104830:	89 44 24 04          	mov    %eax,0x4(%esp)
80104834:	8d 45 08             	lea    0x8(%ebp),%eax
80104837:	89 04 24             	mov    %eax,(%esp)
8010483a:	e8 61 fe ff ff       	call   801046a0 <getcallerpcs>
}
8010483f:	83 c4 14             	add    $0x14,%esp
80104842:	5b                   	pop    %ebx
80104843:	5d                   	pop    %ebp
80104844:	c3                   	ret    
    panic("acquire");
80104845:	c7 04 24 c9 7a 10 80 	movl   $0x80107ac9,(%esp)
8010484c:	e8 0f bb ff ff       	call   80100360 <panic>
80104851:	eb 0d                	jmp    80104860 <release>
80104853:	90                   	nop
80104854:	90                   	nop
80104855:	90                   	nop
80104856:	90                   	nop
80104857:	90                   	nop
80104858:	90                   	nop
80104859:	90                   	nop
8010485a:	90                   	nop
8010485b:	90                   	nop
8010485c:	90                   	nop
8010485d:	90                   	nop
8010485e:	90                   	nop
8010485f:	90                   	nop

80104860 <release>:
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	53                   	push   %ebx
80104864:	83 ec 14             	sub    $0x14,%esp
80104867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010486a:	89 1c 24             	mov    %ebx,(%esp)
8010486d:	e8 3e ff ff ff       	call   801047b0 <holding>
80104872:	85 c0                	test   %eax,%eax
80104874:	74 21                	je     80104897 <release+0x37>
  lk->pcs[0] = 0;
80104876:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
8010487d:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104884:	0f ae f0             	mfence 
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104887:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
8010488d:	83 c4 14             	add    $0x14,%esp
80104890:	5b                   	pop    %ebx
80104891:	5d                   	pop    %ebp
  popcli();
80104892:	e9 a9 fe ff ff       	jmp    80104740 <popcli>
    panic("release");
80104897:	c7 04 24 d1 7a 10 80 	movl   $0x80107ad1,(%esp)
8010489e:	e8 bd ba ff ff       	call   80100360 <panic>
801048a3:	66 90                	xchg   %ax,%ax
801048a5:	66 90                	xchg   %ax,%ax
801048a7:	66 90                	xchg   %ax,%ax
801048a9:	66 90                	xchg   %ax,%ax
801048ab:	66 90                	xchg   %ax,%ax
801048ad:	66 90                	xchg   %ax,%ax
801048af:	90                   	nop

801048b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	8b 55 08             	mov    0x8(%ebp),%edx
801048b6:	57                   	push   %edi
801048b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
801048ba:	53                   	push   %ebx
  if ((int)dst%4 == 0 && n%4 == 0){
801048bb:	f6 c2 03             	test   $0x3,%dl
801048be:	75 05                	jne    801048c5 <memset+0x15>
801048c0:	f6 c1 03             	test   $0x3,%cl
801048c3:	74 13                	je     801048d8 <memset+0x28>
  asm volatile("cld; rep stosb" :
801048c5:	89 d7                	mov    %edx,%edi
801048c7:	8b 45 0c             	mov    0xc(%ebp),%eax
801048ca:	fc                   	cld    
801048cb:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
801048cd:	5b                   	pop    %ebx
801048ce:	89 d0                	mov    %edx,%eax
801048d0:	5f                   	pop    %edi
801048d1:	5d                   	pop    %ebp
801048d2:	c3                   	ret    
801048d3:	90                   	nop
801048d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
801048d8:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801048dc:	c1 e9 02             	shr    $0x2,%ecx
801048df:	89 f8                	mov    %edi,%eax
801048e1:	89 fb                	mov    %edi,%ebx
801048e3:	c1 e0 18             	shl    $0x18,%eax
801048e6:	c1 e3 10             	shl    $0x10,%ebx
801048e9:	09 d8                	or     %ebx,%eax
801048eb:	09 f8                	or     %edi,%eax
801048ed:	c1 e7 08             	shl    $0x8,%edi
801048f0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801048f2:	89 d7                	mov    %edx,%edi
801048f4:	fc                   	cld    
801048f5:	f3 ab                	rep stos %eax,%es:(%edi)
}
801048f7:	5b                   	pop    %ebx
801048f8:	89 d0                	mov    %edx,%eax
801048fa:	5f                   	pop    %edi
801048fb:	5d                   	pop    %ebp
801048fc:	c3                   	ret    
801048fd:	8d 76 00             	lea    0x0(%esi),%esi

80104900 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	8b 45 10             	mov    0x10(%ebp),%eax
80104906:	57                   	push   %edi
80104907:	56                   	push   %esi
80104908:	8b 75 0c             	mov    0xc(%ebp),%esi
8010490b:	53                   	push   %ebx
8010490c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010490f:	85 c0                	test   %eax,%eax
80104911:	8d 78 ff             	lea    -0x1(%eax),%edi
80104914:	74 26                	je     8010493c <memcmp+0x3c>
    if(*s1 != *s2)
80104916:	0f b6 03             	movzbl (%ebx),%eax
80104919:	31 d2                	xor    %edx,%edx
8010491b:	0f b6 0e             	movzbl (%esi),%ecx
8010491e:	38 c8                	cmp    %cl,%al
80104920:	74 16                	je     80104938 <memcmp+0x38>
80104922:	eb 24                	jmp    80104948 <memcmp+0x48>
80104924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104928:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
8010492d:	83 c2 01             	add    $0x1,%edx
80104930:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104934:	38 c8                	cmp    %cl,%al
80104936:	75 10                	jne    80104948 <memcmp+0x48>
  while(n-- > 0){
80104938:	39 fa                	cmp    %edi,%edx
8010493a:	75 ec                	jne    80104928 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010493c:	5b                   	pop    %ebx
  return 0;
8010493d:	31 c0                	xor    %eax,%eax
}
8010493f:	5e                   	pop    %esi
80104940:	5f                   	pop    %edi
80104941:	5d                   	pop    %ebp
80104942:	c3                   	ret    
80104943:	90                   	nop
80104944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104948:	5b                   	pop    %ebx
      return *s1 - *s2;
80104949:	29 c8                	sub    %ecx,%eax
}
8010494b:	5e                   	pop    %esi
8010494c:	5f                   	pop    %edi
8010494d:	5d                   	pop    %ebp
8010494e:	c3                   	ret    
8010494f:	90                   	nop

80104950 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	57                   	push   %edi
80104954:	8b 45 08             	mov    0x8(%ebp),%eax
80104957:	56                   	push   %esi
80104958:	8b 75 0c             	mov    0xc(%ebp),%esi
8010495b:	53                   	push   %ebx
8010495c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010495f:	39 c6                	cmp    %eax,%esi
80104961:	73 35                	jae    80104998 <memmove+0x48>
80104963:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
80104966:	39 c8                	cmp    %ecx,%eax
80104968:	73 2e                	jae    80104998 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
8010496a:	85 db                	test   %ebx,%ebx
    d += n;
8010496c:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
    while(n-- > 0)
8010496f:	8d 53 ff             	lea    -0x1(%ebx),%edx
80104972:	74 1b                	je     8010498f <memmove+0x3f>
80104974:	f7 db                	neg    %ebx
80104976:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
80104979:	01 fb                	add    %edi,%ebx
8010497b:	90                   	nop
8010497c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80104980:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104984:	88 0c 13             	mov    %cl,(%ebx,%edx,1)
    while(n-- > 0)
80104987:	83 ea 01             	sub    $0x1,%edx
8010498a:	83 fa ff             	cmp    $0xffffffff,%edx
8010498d:	75 f1                	jne    80104980 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010498f:	5b                   	pop    %ebx
80104990:	5e                   	pop    %esi
80104991:	5f                   	pop    %edi
80104992:	5d                   	pop    %ebp
80104993:	c3                   	ret    
80104994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104998:	31 d2                	xor    %edx,%edx
8010499a:	85 db                	test   %ebx,%ebx
8010499c:	74 f1                	je     8010498f <memmove+0x3f>
8010499e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
801049a0:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
801049a4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
801049a7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
801049aa:	39 da                	cmp    %ebx,%edx
801049ac:	75 f2                	jne    801049a0 <memmove+0x50>
}
801049ae:	5b                   	pop    %ebx
801049af:	5e                   	pop    %esi
801049b0:	5f                   	pop    %edi
801049b1:	5d                   	pop    %ebp
801049b2:	c3                   	ret    
801049b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
801049c3:	5d                   	pop    %ebp
  return memmove(dst, src, n);
801049c4:	eb 8a                	jmp    80104950 <memmove>
801049c6:	8d 76 00             	lea    0x0(%esi),%esi
801049c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801049d0 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	56                   	push   %esi
801049d4:	8b 75 10             	mov    0x10(%ebp),%esi
801049d7:	53                   	push   %ebx
801049d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
801049db:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
801049de:	85 f6                	test   %esi,%esi
801049e0:	74 30                	je     80104a12 <strncmp+0x42>
801049e2:	0f b6 01             	movzbl (%ecx),%eax
801049e5:	84 c0                	test   %al,%al
801049e7:	74 2f                	je     80104a18 <strncmp+0x48>
801049e9:	0f b6 13             	movzbl (%ebx),%edx
801049ec:	38 d0                	cmp    %dl,%al
801049ee:	75 46                	jne    80104a36 <strncmp+0x66>
801049f0:	8d 51 01             	lea    0x1(%ecx),%edx
801049f3:	01 ce                	add    %ecx,%esi
801049f5:	eb 14                	jmp    80104a0b <strncmp+0x3b>
801049f7:	90                   	nop
801049f8:	0f b6 02             	movzbl (%edx),%eax
801049fb:	84 c0                	test   %al,%al
801049fd:	74 31                	je     80104a30 <strncmp+0x60>
801049ff:	0f b6 19             	movzbl (%ecx),%ebx
80104a02:	83 c2 01             	add    $0x1,%edx
80104a05:	38 d8                	cmp    %bl,%al
80104a07:	75 17                	jne    80104a20 <strncmp+0x50>
    n--, p++, q++;
80104a09:	89 cb                	mov    %ecx,%ebx
  while(n > 0 && *p && *p == *q)
80104a0b:	39 f2                	cmp    %esi,%edx
    n--, p++, q++;
80104a0d:	8d 4b 01             	lea    0x1(%ebx),%ecx
  while(n > 0 && *p && *p == *q)
80104a10:	75 e6                	jne    801049f8 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104a12:	5b                   	pop    %ebx
    return 0;
80104a13:	31 c0                	xor    %eax,%eax
}
80104a15:	5e                   	pop    %esi
80104a16:	5d                   	pop    %ebp
80104a17:	c3                   	ret    
80104a18:	0f b6 1b             	movzbl (%ebx),%ebx
  while(n > 0 && *p && *p == *q)
80104a1b:	31 c0                	xor    %eax,%eax
80104a1d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
80104a20:	0f b6 d3             	movzbl %bl,%edx
80104a23:	29 d0                	sub    %edx,%eax
}
80104a25:	5b                   	pop    %ebx
80104a26:	5e                   	pop    %esi
80104a27:	5d                   	pop    %ebp
80104a28:	c3                   	ret    
80104a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a30:	0f b6 5b 01          	movzbl 0x1(%ebx),%ebx
80104a34:	eb ea                	jmp    80104a20 <strncmp+0x50>
  while(n > 0 && *p && *p == *q)
80104a36:	89 d3                	mov    %edx,%ebx
80104a38:	eb e6                	jmp    80104a20 <strncmp+0x50>
80104a3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a40 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	8b 45 08             	mov    0x8(%ebp),%eax
80104a46:	56                   	push   %esi
80104a47:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a4a:	53                   	push   %ebx
80104a4b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104a4e:	89 c2                	mov    %eax,%edx
80104a50:	eb 19                	jmp    80104a6b <strncpy+0x2b>
80104a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a58:	83 c3 01             	add    $0x1,%ebx
80104a5b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104a5f:	83 c2 01             	add    $0x1,%edx
80104a62:	84 c9                	test   %cl,%cl
80104a64:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a67:	74 09                	je     80104a72 <strncpy+0x32>
80104a69:	89 f1                	mov    %esi,%ecx
80104a6b:	85 c9                	test   %ecx,%ecx
80104a6d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104a70:	7f e6                	jg     80104a58 <strncpy+0x18>
    ;
  while(n-- > 0)
80104a72:	31 c9                	xor    %ecx,%ecx
80104a74:	85 f6                	test   %esi,%esi
80104a76:	7e 0f                	jle    80104a87 <strncpy+0x47>
    *s++ = 0;
80104a78:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104a7c:	89 f3                	mov    %esi,%ebx
80104a7e:	83 c1 01             	add    $0x1,%ecx
80104a81:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104a83:	85 db                	test   %ebx,%ebx
80104a85:	7f f1                	jg     80104a78 <strncpy+0x38>
  return os;
}
80104a87:	5b                   	pop    %ebx
80104a88:	5e                   	pop    %esi
80104a89:	5d                   	pop    %ebp
80104a8a:	c3                   	ret    
80104a8b:	90                   	nop
80104a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a90 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a96:	56                   	push   %esi
80104a97:	8b 45 08             	mov    0x8(%ebp),%eax
80104a9a:	53                   	push   %ebx
80104a9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104a9e:	85 c9                	test   %ecx,%ecx
80104aa0:	7e 26                	jle    80104ac8 <safestrcpy+0x38>
80104aa2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104aa6:	89 c1                	mov    %eax,%ecx
80104aa8:	eb 17                	jmp    80104ac1 <safestrcpy+0x31>
80104aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104ab0:	83 c2 01             	add    $0x1,%edx
80104ab3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104ab7:	83 c1 01             	add    $0x1,%ecx
80104aba:	84 db                	test   %bl,%bl
80104abc:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104abf:	74 04                	je     80104ac5 <safestrcpy+0x35>
80104ac1:	39 f2                	cmp    %esi,%edx
80104ac3:	75 eb                	jne    80104ab0 <safestrcpy+0x20>
    ;
  *s = 0;
80104ac5:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104ac8:	5b                   	pop    %ebx
80104ac9:	5e                   	pop    %esi
80104aca:	5d                   	pop    %ebp
80104acb:	c3                   	ret    
80104acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ad0 <strlen>:

int
strlen(const char *s)
{
80104ad0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104ad1:	31 c0                	xor    %eax,%eax
{
80104ad3:	89 e5                	mov    %esp,%ebp
80104ad5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104ad8:	80 3a 00             	cmpb   $0x0,(%edx)
80104adb:	74 0c                	je     80104ae9 <strlen+0x19>
80104add:	8d 76 00             	lea    0x0(%esi),%esi
80104ae0:	83 c0 01             	add    $0x1,%eax
80104ae3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104ae7:	75 f7                	jne    80104ae0 <strlen+0x10>
    ;
  return n;
}
80104ae9:	5d                   	pop    %ebp
80104aea:	c3                   	ret    

80104aeb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104aeb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104aef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104af3:	55                   	push   %ebp
  pushl %ebx
80104af4:	53                   	push   %ebx
  pushl %esi
80104af5:	56                   	push   %esi
  pushl %edi
80104af6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104af7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104af9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104afb:	5f                   	pop    %edi
  popl %esi
80104afc:	5e                   	pop    %esi
  popl %ebx
80104afd:	5b                   	pop    %ebx
  popl %ebp
80104afe:	5d                   	pop    %ebp
  ret
80104aff:	c3                   	ret    

80104b00 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
80104b03:	53                   	push   %ebx
80104b04:	83 ec 04             	sub    $0x4,%esp
80104b07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104b0a:	e8 01 ec ff ff       	call   80103710 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b0f:	8b 00                	mov    (%eax),%eax
80104b11:	39 d8                	cmp    %ebx,%eax
80104b13:	76 1b                	jbe    80104b30 <fetchint+0x30>
80104b15:	8d 53 04             	lea    0x4(%ebx),%edx
80104b18:	39 d0                	cmp    %edx,%eax
80104b1a:	72 14                	jb     80104b30 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104b1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b1f:	8b 13                	mov    (%ebx),%edx
80104b21:	89 10                	mov    %edx,(%eax)
  return 0;
80104b23:	31 c0                	xor    %eax,%eax
}
80104b25:	83 c4 04             	add    $0x4,%esp
80104b28:	5b                   	pop    %ebx
80104b29:	5d                   	pop    %ebp
80104b2a:	c3                   	ret    
80104b2b:	90                   	nop
80104b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b35:	eb ee                	jmp    80104b25 <fetchint+0x25>
80104b37:	89 f6                	mov    %esi,%esi
80104b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b40 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	53                   	push   %ebx
80104b44:	83 ec 04             	sub    $0x4,%esp
80104b47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104b4a:	e8 c1 eb ff ff       	call   80103710 <myproc>

  if(addr >= curproc->sz)
80104b4f:	39 18                	cmp    %ebx,(%eax)
80104b51:	76 26                	jbe    80104b79 <fetchstr+0x39>
    return -1;
  *pp = (char*)addr;
80104b53:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104b56:	89 da                	mov    %ebx,%edx
80104b58:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104b5a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104b5c:	39 c3                	cmp    %eax,%ebx
80104b5e:	73 19                	jae    80104b79 <fetchstr+0x39>
    if(*s == 0)
80104b60:	80 3b 00             	cmpb   $0x0,(%ebx)
80104b63:	75 0d                	jne    80104b72 <fetchstr+0x32>
80104b65:	eb 21                	jmp    80104b88 <fetchstr+0x48>
80104b67:	90                   	nop
80104b68:	80 3a 00             	cmpb   $0x0,(%edx)
80104b6b:	90                   	nop
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b70:	74 16                	je     80104b88 <fetchstr+0x48>
  for(s = *pp; s < ep; s++){
80104b72:	83 c2 01             	add    $0x1,%edx
80104b75:	39 d0                	cmp    %edx,%eax
80104b77:	77 ef                	ja     80104b68 <fetchstr+0x28>
      return s - *pp;
  }
  return -1;
}
80104b79:	83 c4 04             	add    $0x4,%esp
    return -1;
80104b7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b81:	5b                   	pop    %ebx
80104b82:	5d                   	pop    %ebp
80104b83:	c3                   	ret    
80104b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b88:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
80104b8b:	89 d0                	mov    %edx,%eax
80104b8d:	29 d8                	sub    %ebx,%eax
}
80104b8f:	5b                   	pop    %ebx
80104b90:	5d                   	pop    %ebp
80104b91:	c3                   	ret    
80104b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ba0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104ba0:	55                   	push   %ebp
80104ba1:	89 e5                	mov    %esp,%ebp
80104ba3:	56                   	push   %esi
80104ba4:	8b 75 0c             	mov    0xc(%ebp),%esi
80104ba7:	53                   	push   %ebx
80104ba8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bab:	e8 60 eb ff ff       	call   80103710 <myproc>
80104bb0:	89 75 0c             	mov    %esi,0xc(%ebp)
80104bb3:	8b 40 18             	mov    0x18(%eax),%eax
80104bb6:	8b 40 44             	mov    0x44(%eax),%eax
80104bb9:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
80104bbd:	89 45 08             	mov    %eax,0x8(%ebp)
}
80104bc0:	5b                   	pop    %ebx
80104bc1:	5e                   	pop    %esi
80104bc2:	5d                   	pop    %ebp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bc3:	e9 38 ff ff ff       	jmp    80104b00 <fetchint>
80104bc8:	90                   	nop
80104bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104bd0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	83 ec 20             	sub    $0x20,%esp
80104bd8:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104bdb:	e8 30 eb ff ff       	call   80103710 <myproc>
80104be0:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104be2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104be5:	89 44 24 04          	mov    %eax,0x4(%esp)
80104be9:	8b 45 08             	mov    0x8(%ebp),%eax
80104bec:	89 04 24             	mov    %eax,(%esp)
80104bef:	e8 ac ff ff ff       	call   80104ba0 <argint>
80104bf4:	85 c0                	test   %eax,%eax
80104bf6:	78 28                	js     80104c20 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104bf8:	85 db                	test   %ebx,%ebx
80104bfa:	78 24                	js     80104c20 <argptr+0x50>
80104bfc:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104bff:	8b 06                	mov    (%esi),%eax
80104c01:	39 c2                	cmp    %eax,%edx
80104c03:	73 1b                	jae    80104c20 <argptr+0x50>
80104c05:	01 d3                	add    %edx,%ebx
80104c07:	39 d8                	cmp    %ebx,%eax
80104c09:	72 15                	jb     80104c20 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c0e:	89 10                	mov    %edx,(%eax)
  return 0;
}
80104c10:	83 c4 20             	add    $0x20,%esp
  return 0;
80104c13:	31 c0                	xor    %eax,%eax
}
80104c15:	5b                   	pop    %ebx
80104c16:	5e                   	pop    %esi
80104c17:	5d                   	pop    %ebp
80104c18:	c3                   	ret    
80104c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c20:	83 c4 20             	add    $0x20,%esp
    return -1;
80104c23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c28:	5b                   	pop    %ebx
80104c29:	5e                   	pop    %esi
80104c2a:	5d                   	pop    %ebp
80104c2b:	c3                   	ret    
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c30 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c30:	55                   	push   %ebp
80104c31:	89 e5                	mov    %esp,%ebp
80104c33:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104c36:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c39:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c3d:	8b 45 08             	mov    0x8(%ebp),%eax
80104c40:	89 04 24             	mov    %eax,(%esp)
80104c43:	e8 58 ff ff ff       	call   80104ba0 <argint>
80104c48:	85 c0                	test   %eax,%eax
80104c4a:	78 14                	js     80104c60 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104c4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c4f:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c56:	89 04 24             	mov    %eax,(%esp)
80104c59:	e8 e2 fe ff ff       	call   80104b40 <fetchstr>
}
80104c5e:	c9                   	leave  
80104c5f:	c3                   	ret    
    return -1;
80104c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c65:	c9                   	leave  
80104c66:	c3                   	ret    
80104c67:	89 f6                	mov    %esi,%esi
80104c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c70 <syscall>:

};

void
syscall(void)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	56                   	push   %esi
80104c74:	53                   	push   %ebx
80104c75:	83 ec 10             	sub    $0x10,%esp
  int num;
  struct proc *curproc = myproc();
80104c78:	e8 93 ea ff ff       	call   80103710 <myproc>

  num = curproc->tf->eax;
80104c7d:	8b 70 18             	mov    0x18(%eax),%esi
  struct proc *curproc = myproc();
80104c80:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104c82:	8b 46 1c             	mov    0x1c(%esi),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c85:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c88:	83 fa 1b             	cmp    $0x1b,%edx
80104c8b:	77 1b                	ja     80104ca8 <syscall+0x38>
80104c8d:	8b 14 85 00 7b 10 80 	mov    -0x7fef8500(,%eax,4),%edx
80104c94:	85 d2                	test   %edx,%edx
80104c96:	74 10                	je     80104ca8 <syscall+0x38>
    curproc->tf->eax = syscalls[num]();
80104c98:	ff d2                	call   *%edx
80104c9a:	89 46 1c             	mov    %eax,0x1c(%esi)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104c9d:	83 c4 10             	add    $0x10,%esp
80104ca0:	5b                   	pop    %ebx
80104ca1:	5e                   	pop    %esi
80104ca2:	5d                   	pop    %ebp
80104ca3:	c3                   	ret    
80104ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104ca8:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80104cac:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104caf:	89 44 24 08          	mov    %eax,0x8(%esp)
    cprintf("%d %s: unknown sys call %d\n",
80104cb3:	8b 43 10             	mov    0x10(%ebx),%eax
80104cb6:	c7 04 24 d9 7a 10 80 	movl   $0x80107ad9,(%esp)
80104cbd:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cc1:	e8 8a b9 ff ff       	call   80100650 <cprintf>
    curproc->tf->eax = -1;
80104cc6:	8b 43 18             	mov    0x18(%ebx),%eax
80104cc9:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104cd0:	83 c4 10             	add    $0x10,%esp
80104cd3:	5b                   	pop    %ebx
80104cd4:	5e                   	pop    %esi
80104cd5:	5d                   	pop    %ebp
80104cd6:	c3                   	ret    
80104cd7:	66 90                	xchg   %ax,%ax
80104cd9:	66 90                	xchg   %ax,%ax
80104cdb:	66 90                	xchg   %ax,%ax
80104cdd:	66 90                	xchg   %ax,%ax
80104cdf:	90                   	nop

80104ce0 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	53                   	push   %ebx
80104ce4:	89 c3                	mov    %eax,%ebx
80104ce6:	83 ec 04             	sub    $0x4,%esp
  int fd;
  struct proc *curproc = myproc();
80104ce9:	e8 22 ea ff ff       	call   80103710 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80104cee:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
80104cf0:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104cf4:	85 c9                	test   %ecx,%ecx
80104cf6:	74 18                	je     80104d10 <fdalloc+0x30>
  for(fd = 0; fd < NOFILE; fd++){
80104cf8:	83 c2 01             	add    $0x1,%edx
80104cfb:	83 fa 10             	cmp    $0x10,%edx
80104cfe:	75 f0                	jne    80104cf0 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
80104d00:	83 c4 04             	add    $0x4,%esp
  return -1;
80104d03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d08:	5b                   	pop    %ebx
80104d09:	5d                   	pop    %ebp
80104d0a:	c3                   	ret    
80104d0b:	90                   	nop
80104d0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80104d10:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
}
80104d14:	83 c4 04             	add    $0x4,%esp
      return fd;
80104d17:	89 d0                	mov    %edx,%eax
}
80104d19:	5b                   	pop    %ebx
80104d1a:	5d                   	pop    %ebp
80104d1b:	c3                   	ret    
80104d1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d20 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	57                   	push   %edi
80104d24:	56                   	push   %esi
80104d25:	53                   	push   %ebx
80104d26:	83 ec 4c             	sub    $0x4c,%esp
80104d29:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104d2c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d2f:	8d 5d da             	lea    -0x26(%ebp),%ebx
80104d32:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d36:	89 04 24             	mov    %eax,(%esp)
{
80104d39:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104d3c:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104d3f:	e8 0c d2 ff ff       	call   80101f50 <nameiparent>
80104d44:	85 c0                	test   %eax,%eax
80104d46:	89 c7                	mov    %eax,%edi
80104d48:	0f 84 da 00 00 00    	je     80104e28 <create+0x108>
    return 0;
  ilock(dp);
80104d4e:	89 04 24             	mov    %eax,(%esp)
80104d51:	e8 8a c9 ff ff       	call   801016e0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104d56:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104d59:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d5d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104d61:	89 3c 24             	mov    %edi,(%esp)
80104d64:	e8 87 ce ff ff       	call   80101bf0 <dirlookup>
80104d69:	85 c0                	test   %eax,%eax
80104d6b:	89 c6                	mov    %eax,%esi
80104d6d:	74 41                	je     80104db0 <create+0x90>
    iunlockput(dp);
80104d6f:	89 3c 24             	mov    %edi,(%esp)
80104d72:	e8 c9 cb ff ff       	call   80101940 <iunlockput>
    ilock(ip);
80104d77:	89 34 24             	mov    %esi,(%esp)
80104d7a:	e8 61 c9 ff ff       	call   801016e0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104d7f:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104d84:	75 12                	jne    80104d98 <create+0x78>
80104d86:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104d8b:	89 f0                	mov    %esi,%eax
80104d8d:	75 09                	jne    80104d98 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d8f:	83 c4 4c             	add    $0x4c,%esp
80104d92:	5b                   	pop    %ebx
80104d93:	5e                   	pop    %esi
80104d94:	5f                   	pop    %edi
80104d95:	5d                   	pop    %ebp
80104d96:	c3                   	ret    
80104d97:	90                   	nop
    iunlockput(ip);
80104d98:	89 34 24             	mov    %esi,(%esp)
80104d9b:	e8 a0 cb ff ff       	call   80101940 <iunlockput>
}
80104da0:	83 c4 4c             	add    $0x4c,%esp
    return 0;
80104da3:	31 c0                	xor    %eax,%eax
}
80104da5:	5b                   	pop    %ebx
80104da6:	5e                   	pop    %esi
80104da7:	5f                   	pop    %edi
80104da8:	5d                   	pop    %ebp
80104da9:	c3                   	ret    
80104daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if((ip = ialloc(dp->dev, type)) == 0)
80104db0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104db4:	89 44 24 04          	mov    %eax,0x4(%esp)
80104db8:	8b 07                	mov    (%edi),%eax
80104dba:	89 04 24             	mov    %eax,(%esp)
80104dbd:	e8 8e c7 ff ff       	call   80101550 <ialloc>
80104dc2:	85 c0                	test   %eax,%eax
80104dc4:	89 c6                	mov    %eax,%esi
80104dc6:	0f 84 bf 00 00 00    	je     80104e8b <create+0x16b>
  ilock(ip);
80104dcc:	89 04 24             	mov    %eax,(%esp)
80104dcf:	e8 0c c9 ff ff       	call   801016e0 <ilock>
  ip->major = major;
80104dd4:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104dd8:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104ddc:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104de0:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104de4:	b8 01 00 00 00       	mov    $0x1,%eax
80104de9:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104ded:	89 34 24             	mov    %esi,(%esp)
80104df0:	e8 2b c8 ff ff       	call   80101620 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104df5:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104dfa:	74 34                	je     80104e30 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104dfc:	8b 46 04             	mov    0x4(%esi),%eax
80104dff:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104e03:	89 3c 24             	mov    %edi,(%esp)
80104e06:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e0a:	e8 41 d0 ff ff       	call   80101e50 <dirlink>
80104e0f:	85 c0                	test   %eax,%eax
80104e11:	78 6c                	js     80104e7f <create+0x15f>
  iunlockput(dp);
80104e13:	89 3c 24             	mov    %edi,(%esp)
80104e16:	e8 25 cb ff ff       	call   80101940 <iunlockput>
}
80104e1b:	83 c4 4c             	add    $0x4c,%esp
  return ip;
80104e1e:	89 f0                	mov    %esi,%eax
}
80104e20:	5b                   	pop    %ebx
80104e21:	5e                   	pop    %esi
80104e22:	5f                   	pop    %edi
80104e23:	5d                   	pop    %ebp
80104e24:	c3                   	ret    
80104e25:	8d 76 00             	lea    0x0(%esi),%esi
    return 0;
80104e28:	31 c0                	xor    %eax,%eax
80104e2a:	e9 60 ff ff ff       	jmp    80104d8f <create+0x6f>
80104e2f:	90                   	nop
    dp->nlink++;  // for ".."
80104e30:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104e35:	89 3c 24             	mov    %edi,(%esp)
80104e38:	e8 e3 c7 ff ff       	call   80101620 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e3d:	8b 46 04             	mov    0x4(%esi),%eax
80104e40:	c7 44 24 04 90 7b 10 	movl   $0x80107b90,0x4(%esp)
80104e47:	80 
80104e48:	89 34 24             	mov    %esi,(%esp)
80104e4b:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e4f:	e8 fc cf ff ff       	call   80101e50 <dirlink>
80104e54:	85 c0                	test   %eax,%eax
80104e56:	78 1b                	js     80104e73 <create+0x153>
80104e58:	8b 47 04             	mov    0x4(%edi),%eax
80104e5b:	c7 44 24 04 8f 7b 10 	movl   $0x80107b8f,0x4(%esp)
80104e62:	80 
80104e63:	89 34 24             	mov    %esi,(%esp)
80104e66:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e6a:	e8 e1 cf ff ff       	call   80101e50 <dirlink>
80104e6f:	85 c0                	test   %eax,%eax
80104e71:	79 89                	jns    80104dfc <create+0xdc>
      panic("create dots");
80104e73:	c7 04 24 83 7b 10 80 	movl   $0x80107b83,(%esp)
80104e7a:	e8 e1 b4 ff ff       	call   80100360 <panic>
    panic("create: dirlink");
80104e7f:	c7 04 24 92 7b 10 80 	movl   $0x80107b92,(%esp)
80104e86:	e8 d5 b4 ff ff       	call   80100360 <panic>
    panic("create: ialloc");
80104e8b:	c7 04 24 74 7b 10 80 	movl   $0x80107b74,(%esp)
80104e92:	e8 c9 b4 ff ff       	call   80100360 <panic>
80104e97:	89 f6                	mov    %esi,%esi
80104e99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ea0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104ea0:	55                   	push   %ebp
80104ea1:	89 e5                	mov    %esp,%ebp
80104ea3:	56                   	push   %esi
80104ea4:	89 c6                	mov    %eax,%esi
80104ea6:	53                   	push   %ebx
80104ea7:	89 d3                	mov    %edx,%ebx
80104ea9:	83 ec 20             	sub    $0x20,%esp
  if(argint(n, &fd) < 0)
80104eac:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104eaf:	89 44 24 04          	mov    %eax,0x4(%esp)
80104eb3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104eba:	e8 e1 fc ff ff       	call   80104ba0 <argint>
80104ebf:	85 c0                	test   %eax,%eax
80104ec1:	78 2d                	js     80104ef0 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104ec3:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ec7:	77 27                	ja     80104ef0 <argfd.constprop.0+0x50>
80104ec9:	e8 42 e8 ff ff       	call   80103710 <myproc>
80104ece:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ed1:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104ed5:	85 c0                	test   %eax,%eax
80104ed7:	74 17                	je     80104ef0 <argfd.constprop.0+0x50>
  if(pfd)
80104ed9:	85 f6                	test   %esi,%esi
80104edb:	74 02                	je     80104edf <argfd.constprop.0+0x3f>
    *pfd = fd;
80104edd:	89 16                	mov    %edx,(%esi)
  if(pf)
80104edf:	85 db                	test   %ebx,%ebx
80104ee1:	74 1d                	je     80104f00 <argfd.constprop.0+0x60>
    *pf = f;
80104ee3:	89 03                	mov    %eax,(%ebx)
  return 0;
80104ee5:	31 c0                	xor    %eax,%eax
}
80104ee7:	83 c4 20             	add    $0x20,%esp
80104eea:	5b                   	pop    %ebx
80104eeb:	5e                   	pop    %esi
80104eec:	5d                   	pop    %ebp
80104eed:	c3                   	ret    
80104eee:	66 90                	xchg   %ax,%ax
80104ef0:	83 c4 20             	add    $0x20,%esp
    return -1;
80104ef3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ef8:	5b                   	pop    %ebx
80104ef9:	5e                   	pop    %esi
80104efa:	5d                   	pop    %ebp
80104efb:	c3                   	ret    
80104efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return 0;
80104f00:	31 c0                	xor    %eax,%eax
80104f02:	eb e3                	jmp    80104ee7 <argfd.constprop.0+0x47>
80104f04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f10 <sys_dup>:
{
80104f10:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80104f11:	31 c0                	xor    %eax,%eax
{
80104f13:	89 e5                	mov    %esp,%ebp
80104f15:	53                   	push   %ebx
80104f16:	83 ec 24             	sub    $0x24,%esp
  if(argfd(0, 0, &f) < 0)
80104f19:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104f1c:	e8 7f ff ff ff       	call   80104ea0 <argfd.constprop.0>
80104f21:	85 c0                	test   %eax,%eax
80104f23:	78 23                	js     80104f48 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
80104f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f28:	e8 b3 fd ff ff       	call   80104ce0 <fdalloc>
80104f2d:	85 c0                	test   %eax,%eax
80104f2f:	89 c3                	mov    %eax,%ebx
80104f31:	78 15                	js     80104f48 <sys_dup+0x38>
  filedup(f);
80104f33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f36:	89 04 24             	mov    %eax,(%esp)
80104f39:	e8 c2 be ff ff       	call   80100e00 <filedup>
  return fd;
80104f3e:	89 d8                	mov    %ebx,%eax
}
80104f40:	83 c4 24             	add    $0x24,%esp
80104f43:	5b                   	pop    %ebx
80104f44:	5d                   	pop    %ebp
80104f45:	c3                   	ret    
80104f46:	66 90                	xchg   %ax,%ax
    return -1;
80104f48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f4d:	eb f1                	jmp    80104f40 <sys_dup+0x30>
80104f4f:	90                   	nop

80104f50 <sys_read>:
{
80104f50:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f51:	31 c0                	xor    %eax,%eax
{
80104f53:	89 e5                	mov    %esp,%ebp
80104f55:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f58:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104f5b:	e8 40 ff ff ff       	call   80104ea0 <argfd.constprop.0>
80104f60:	85 c0                	test   %eax,%eax
80104f62:	78 54                	js     80104fb8 <sys_read+0x68>
80104f64:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f67:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f6b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104f72:	e8 29 fc ff ff       	call   80104ba0 <argint>
80104f77:	85 c0                	test   %eax,%eax
80104f79:	78 3d                	js     80104fb8 <sys_read+0x68>
80104f7b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104f85:	89 44 24 08          	mov    %eax,0x8(%esp)
80104f89:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104f8c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104f90:	e8 3b fc ff ff       	call   80104bd0 <argptr>
80104f95:	85 c0                	test   %eax,%eax
80104f97:	78 1f                	js     80104fb8 <sys_read+0x68>
  return fileread(f, p, n);
80104f99:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104f9c:	89 44 24 08          	mov    %eax,0x8(%esp)
80104fa0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fa3:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fa7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104faa:	89 04 24             	mov    %eax,(%esp)
80104fad:	e8 ae bf ff ff       	call   80100f60 <fileread>
}
80104fb2:	c9                   	leave  
80104fb3:	c3                   	ret    
80104fb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104fb8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fbd:	c9                   	leave  
80104fbe:	c3                   	ret    
80104fbf:	90                   	nop

80104fc0 <sys_write>:
{
80104fc0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fc1:	31 c0                	xor    %eax,%eax
{
80104fc3:	89 e5                	mov    %esp,%ebp
80104fc5:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fc8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104fcb:	e8 d0 fe ff ff       	call   80104ea0 <argfd.constprop.0>
80104fd0:	85 c0                	test   %eax,%eax
80104fd2:	78 54                	js     80105028 <sys_write+0x68>
80104fd4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fd7:	89 44 24 04          	mov    %eax,0x4(%esp)
80104fdb:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104fe2:	e8 b9 fb ff ff       	call   80104ba0 <argint>
80104fe7:	85 c0                	test   %eax,%eax
80104fe9:	78 3d                	js     80105028 <sys_write+0x68>
80104feb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104fee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104ff5:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ff9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ffc:	89 44 24 04          	mov    %eax,0x4(%esp)
80105000:	e8 cb fb ff ff       	call   80104bd0 <argptr>
80105005:	85 c0                	test   %eax,%eax
80105007:	78 1f                	js     80105028 <sys_write+0x68>
  return filewrite(f, p, n);
80105009:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010500c:	89 44 24 08          	mov    %eax,0x8(%esp)
80105010:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105013:	89 44 24 04          	mov    %eax,0x4(%esp)
80105017:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010501a:	89 04 24             	mov    %eax,(%esp)
8010501d:	e8 de bf ff ff       	call   80101000 <filewrite>
}
80105022:	c9                   	leave  
80105023:	c3                   	ret    
80105024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105028:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010502d:	c9                   	leave  
8010502e:	c3                   	ret    
8010502f:	90                   	nop

80105030 <sys_close>:
{
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, &fd, &f) < 0)
80105036:	8d 55 f4             	lea    -0xc(%ebp),%edx
80105039:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010503c:	e8 5f fe ff ff       	call   80104ea0 <argfd.constprop.0>
80105041:	85 c0                	test   %eax,%eax
80105043:	78 23                	js     80105068 <sys_close+0x38>
  myproc()->ofile[fd] = 0;
80105045:	e8 c6 e6 ff ff       	call   80103710 <myproc>
8010504a:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010504d:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80105054:	00 
  fileclose(f);
80105055:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105058:	89 04 24             	mov    %eax,(%esp)
8010505b:	e8 f0 bd ff ff       	call   80100e50 <fileclose>
  return 0;
80105060:	31 c0                	xor    %eax,%eax
}
80105062:	c9                   	leave  
80105063:	c3                   	ret    
80105064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105068:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010506d:	c9                   	leave  
8010506e:	c3                   	ret    
8010506f:	90                   	nop

80105070 <sys_fstat>:
{
80105070:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105071:	31 c0                	xor    %eax,%eax
{
80105073:	89 e5                	mov    %esp,%ebp
80105075:	83 ec 28             	sub    $0x28,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105078:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010507b:	e8 20 fe ff ff       	call   80104ea0 <argfd.constprop.0>
80105080:	85 c0                	test   %eax,%eax
80105082:	78 34                	js     801050b8 <sys_fstat+0x48>
80105084:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105087:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010508e:	00 
8010508f:	89 44 24 04          	mov    %eax,0x4(%esp)
80105093:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010509a:	e8 31 fb ff ff       	call   80104bd0 <argptr>
8010509f:	85 c0                	test   %eax,%eax
801050a1:	78 15                	js     801050b8 <sys_fstat+0x48>
  return filestat(f, st);
801050a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050a6:	89 44 24 04          	mov    %eax,0x4(%esp)
801050aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801050ad:	89 04 24             	mov    %eax,(%esp)
801050b0:	e8 5b be ff ff       	call   80100f10 <filestat>
}
801050b5:	c9                   	leave  
801050b6:	c3                   	ret    
801050b7:	90                   	nop
    return -1;
801050b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050bd:	c9                   	leave  
801050be:	c3                   	ret    
801050bf:	90                   	nop

801050c0 <sys_link>:
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	57                   	push   %edi
801050c4:	56                   	push   %esi
801050c5:	53                   	push   %ebx
801050c6:	83 ec 3c             	sub    $0x3c,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050c9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
801050cc:	89 44 24 04          	mov    %eax,0x4(%esp)
801050d0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801050d7:	e8 54 fb ff ff       	call   80104c30 <argstr>
801050dc:	85 c0                	test   %eax,%eax
801050de:	0f 88 e6 00 00 00    	js     801051ca <sys_link+0x10a>
801050e4:	8d 45 d0             	lea    -0x30(%ebp),%eax
801050e7:	89 44 24 04          	mov    %eax,0x4(%esp)
801050eb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801050f2:	e8 39 fb ff ff       	call   80104c30 <argstr>
801050f7:	85 c0                	test   %eax,%eax
801050f9:	0f 88 cb 00 00 00    	js     801051ca <sys_link+0x10a>
  begin_op();
801050ff:	e8 3c da ff ff       	call   80102b40 <begin_op>
  if((ip = namei(old)) == 0){
80105104:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105107:	89 04 24             	mov    %eax,(%esp)
8010510a:	e8 21 ce ff ff       	call   80101f30 <namei>
8010510f:	85 c0                	test   %eax,%eax
80105111:	89 c3                	mov    %eax,%ebx
80105113:	0f 84 ac 00 00 00    	je     801051c5 <sys_link+0x105>
  ilock(ip);
80105119:	89 04 24             	mov    %eax,(%esp)
8010511c:	e8 bf c5 ff ff       	call   801016e0 <ilock>
  if(ip->type == T_DIR){
80105121:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105126:	0f 84 91 00 00 00    	je     801051bd <sys_link+0xfd>
  ip->nlink++;
8010512c:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105131:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105134:	89 1c 24             	mov    %ebx,(%esp)
80105137:	e8 e4 c4 ff ff       	call   80101620 <iupdate>
  iunlock(ip);
8010513c:	89 1c 24             	mov    %ebx,(%esp)
8010513f:	e8 7c c6 ff ff       	call   801017c0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105144:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105147:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010514b:	89 04 24             	mov    %eax,(%esp)
8010514e:	e8 fd cd ff ff       	call   80101f50 <nameiparent>
80105153:	85 c0                	test   %eax,%eax
80105155:	89 c6                	mov    %eax,%esi
80105157:	74 4f                	je     801051a8 <sys_link+0xe8>
  ilock(dp);
80105159:	89 04 24             	mov    %eax,(%esp)
8010515c:	e8 7f c5 ff ff       	call   801016e0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105161:	8b 03                	mov    (%ebx),%eax
80105163:	39 06                	cmp    %eax,(%esi)
80105165:	75 39                	jne    801051a0 <sys_link+0xe0>
80105167:	8b 43 04             	mov    0x4(%ebx),%eax
8010516a:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010516e:	89 34 24             	mov    %esi,(%esp)
80105171:	89 44 24 08          	mov    %eax,0x8(%esp)
80105175:	e8 d6 cc ff ff       	call   80101e50 <dirlink>
8010517a:	85 c0                	test   %eax,%eax
8010517c:	78 22                	js     801051a0 <sys_link+0xe0>
  iunlockput(dp);
8010517e:	89 34 24             	mov    %esi,(%esp)
80105181:	e8 ba c7 ff ff       	call   80101940 <iunlockput>
  iput(ip);
80105186:	89 1c 24             	mov    %ebx,(%esp)
80105189:	e8 72 c6 ff ff       	call   80101800 <iput>
  end_op();
8010518e:	e8 1d da ff ff       	call   80102bb0 <end_op>
}
80105193:	83 c4 3c             	add    $0x3c,%esp
  return 0;
80105196:	31 c0                	xor    %eax,%eax
}
80105198:	5b                   	pop    %ebx
80105199:	5e                   	pop    %esi
8010519a:	5f                   	pop    %edi
8010519b:	5d                   	pop    %ebp
8010519c:	c3                   	ret    
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801051a0:	89 34 24             	mov    %esi,(%esp)
801051a3:	e8 98 c7 ff ff       	call   80101940 <iunlockput>
  ilock(ip);
801051a8:	89 1c 24             	mov    %ebx,(%esp)
801051ab:	e8 30 c5 ff ff       	call   801016e0 <ilock>
  ip->nlink--;
801051b0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801051b5:	89 1c 24             	mov    %ebx,(%esp)
801051b8:	e8 63 c4 ff ff       	call   80101620 <iupdate>
  iunlockput(ip);
801051bd:	89 1c 24             	mov    %ebx,(%esp)
801051c0:	e8 7b c7 ff ff       	call   80101940 <iunlockput>
  end_op();
801051c5:	e8 e6 d9 ff ff       	call   80102bb0 <end_op>
}
801051ca:	83 c4 3c             	add    $0x3c,%esp
  return -1;
801051cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051d2:	5b                   	pop    %ebx
801051d3:	5e                   	pop    %esi
801051d4:	5f                   	pop    %edi
801051d5:	5d                   	pop    %ebp
801051d6:	c3                   	ret    
801051d7:	89 f6                	mov    %esi,%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051e0 <sys_unlink>:
{
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	57                   	push   %edi
801051e4:	56                   	push   %esi
801051e5:	53                   	push   %ebx
801051e6:	83 ec 5c             	sub    $0x5c,%esp
  if(argstr(0, &path) < 0)
801051e9:	8d 45 c0             	lea    -0x40(%ebp),%eax
801051ec:	89 44 24 04          	mov    %eax,0x4(%esp)
801051f0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051f7:	e8 34 fa ff ff       	call   80104c30 <argstr>
801051fc:	85 c0                	test   %eax,%eax
801051fe:	0f 88 76 01 00 00    	js     8010537a <sys_unlink+0x19a>
  begin_op();
80105204:	e8 37 d9 ff ff       	call   80102b40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105209:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010520c:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010520f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105213:	89 04 24             	mov    %eax,(%esp)
80105216:	e8 35 cd ff ff       	call   80101f50 <nameiparent>
8010521b:	85 c0                	test   %eax,%eax
8010521d:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105220:	0f 84 4f 01 00 00    	je     80105375 <sys_unlink+0x195>
  ilock(dp);
80105226:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80105229:	89 34 24             	mov    %esi,(%esp)
8010522c:	e8 af c4 ff ff       	call   801016e0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105231:	c7 44 24 04 90 7b 10 	movl   $0x80107b90,0x4(%esp)
80105238:	80 
80105239:	89 1c 24             	mov    %ebx,(%esp)
8010523c:	e8 7f c9 ff ff       	call   80101bc0 <namecmp>
80105241:	85 c0                	test   %eax,%eax
80105243:	0f 84 21 01 00 00    	je     8010536a <sys_unlink+0x18a>
80105249:	c7 44 24 04 8f 7b 10 	movl   $0x80107b8f,0x4(%esp)
80105250:	80 
80105251:	89 1c 24             	mov    %ebx,(%esp)
80105254:	e8 67 c9 ff ff       	call   80101bc0 <namecmp>
80105259:	85 c0                	test   %eax,%eax
8010525b:	0f 84 09 01 00 00    	je     8010536a <sys_unlink+0x18a>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105261:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105264:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80105268:	89 44 24 08          	mov    %eax,0x8(%esp)
8010526c:	89 34 24             	mov    %esi,(%esp)
8010526f:	e8 7c c9 ff ff       	call   80101bf0 <dirlookup>
80105274:	85 c0                	test   %eax,%eax
80105276:	89 c3                	mov    %eax,%ebx
80105278:	0f 84 ec 00 00 00    	je     8010536a <sys_unlink+0x18a>
  ilock(ip);
8010527e:	89 04 24             	mov    %eax,(%esp)
80105281:	e8 5a c4 ff ff       	call   801016e0 <ilock>
  if(ip->nlink < 1)
80105286:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010528b:	0f 8e 24 01 00 00    	jle    801053b5 <sys_unlink+0x1d5>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105291:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105296:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105299:	74 7d                	je     80105318 <sys_unlink+0x138>
  memset(&de, 0, sizeof(de));
8010529b:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801052a2:	00 
801052a3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801052aa:	00 
801052ab:	89 34 24             	mov    %esi,(%esp)
801052ae:	e8 fd f5 ff ff       	call   801048b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052b3:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801052b6:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
801052bd:	00 
801052be:	89 74 24 04          	mov    %esi,0x4(%esp)
801052c2:	89 44 24 08          	mov    %eax,0x8(%esp)
801052c6:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801052c9:	89 04 24             	mov    %eax,(%esp)
801052cc:	e8 bf c7 ff ff       	call   80101a90 <writei>
801052d1:	83 f8 10             	cmp    $0x10,%eax
801052d4:	0f 85 cf 00 00 00    	jne    801053a9 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
801052da:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052df:	0f 84 a3 00 00 00    	je     80105388 <sys_unlink+0x1a8>
  iunlockput(dp);
801052e5:	8b 45 b4             	mov    -0x4c(%ebp),%eax
801052e8:	89 04 24             	mov    %eax,(%esp)
801052eb:	e8 50 c6 ff ff       	call   80101940 <iunlockput>
  ip->nlink--;
801052f0:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801052f5:	89 1c 24             	mov    %ebx,(%esp)
801052f8:	e8 23 c3 ff ff       	call   80101620 <iupdate>
  iunlockput(ip);
801052fd:	89 1c 24             	mov    %ebx,(%esp)
80105300:	e8 3b c6 ff ff       	call   80101940 <iunlockput>
  end_op();
80105305:	e8 a6 d8 ff ff       	call   80102bb0 <end_op>
}
8010530a:	83 c4 5c             	add    $0x5c,%esp
  return 0;
8010530d:	31 c0                	xor    %eax,%eax
}
8010530f:	5b                   	pop    %ebx
80105310:	5e                   	pop    %esi
80105311:	5f                   	pop    %edi
80105312:	5d                   	pop    %ebp
80105313:	c3                   	ret    
80105314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105318:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
8010531c:	0f 86 79 ff ff ff    	jbe    8010529b <sys_unlink+0xbb>
80105322:	bf 20 00 00 00       	mov    $0x20,%edi
80105327:	eb 15                	jmp    8010533e <sys_unlink+0x15e>
80105329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105330:	8d 57 10             	lea    0x10(%edi),%edx
80105333:	3b 53 58             	cmp    0x58(%ebx),%edx
80105336:	0f 83 5f ff ff ff    	jae    8010529b <sys_unlink+0xbb>
8010533c:	89 d7                	mov    %edx,%edi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010533e:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80105345:	00 
80105346:	89 7c 24 08          	mov    %edi,0x8(%esp)
8010534a:	89 74 24 04          	mov    %esi,0x4(%esp)
8010534e:	89 1c 24             	mov    %ebx,(%esp)
80105351:	e8 3a c6 ff ff       	call   80101990 <readi>
80105356:	83 f8 10             	cmp    $0x10,%eax
80105359:	75 42                	jne    8010539d <sys_unlink+0x1bd>
    if(de.inum != 0)
8010535b:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105360:	74 ce                	je     80105330 <sys_unlink+0x150>
    iunlockput(ip);
80105362:	89 1c 24             	mov    %ebx,(%esp)
80105365:	e8 d6 c5 ff ff       	call   80101940 <iunlockput>
  iunlockput(dp);
8010536a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010536d:	89 04 24             	mov    %eax,(%esp)
80105370:	e8 cb c5 ff ff       	call   80101940 <iunlockput>
  end_op();
80105375:	e8 36 d8 ff ff       	call   80102bb0 <end_op>
}
8010537a:	83 c4 5c             	add    $0x5c,%esp
  return -1;
8010537d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105382:	5b                   	pop    %ebx
80105383:	5e                   	pop    %esi
80105384:	5f                   	pop    %edi
80105385:	5d                   	pop    %ebp
80105386:	c3                   	ret    
80105387:	90                   	nop
    dp->nlink--;
80105388:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010538b:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105390:	89 04 24             	mov    %eax,(%esp)
80105393:	e8 88 c2 ff ff       	call   80101620 <iupdate>
80105398:	e9 48 ff ff ff       	jmp    801052e5 <sys_unlink+0x105>
      panic("isdirempty: readi");
8010539d:	c7 04 24 b4 7b 10 80 	movl   $0x80107bb4,(%esp)
801053a4:	e8 b7 af ff ff       	call   80100360 <panic>
    panic("unlink: writei");
801053a9:	c7 04 24 c6 7b 10 80 	movl   $0x80107bc6,(%esp)
801053b0:	e8 ab af ff ff       	call   80100360 <panic>
    panic("unlink: nlink < 1");
801053b5:	c7 04 24 a2 7b 10 80 	movl   $0x80107ba2,(%esp)
801053bc:	e8 9f af ff ff       	call   80100360 <panic>
801053c1:	eb 0d                	jmp    801053d0 <sys_open>
801053c3:	90                   	nop
801053c4:	90                   	nop
801053c5:	90                   	nop
801053c6:	90                   	nop
801053c7:	90                   	nop
801053c8:	90                   	nop
801053c9:	90                   	nop
801053ca:	90                   	nop
801053cb:	90                   	nop
801053cc:	90                   	nop
801053cd:	90                   	nop
801053ce:	90                   	nop
801053cf:	90                   	nop

801053d0 <sys_open>:

int
sys_open(void)
{
801053d0:	55                   	push   %ebp
801053d1:	89 e5                	mov    %esp,%ebp
801053d3:	57                   	push   %edi
801053d4:	56                   	push   %esi
801053d5:	53                   	push   %ebx
801053d6:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801053d9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801053dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801053e0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053e7:	e8 44 f8 ff ff       	call   80104c30 <argstr>
801053ec:	85 c0                	test   %eax,%eax
801053ee:	0f 88 d1 00 00 00    	js     801054c5 <sys_open+0xf5>
801053f4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801053f7:	89 44 24 04          	mov    %eax,0x4(%esp)
801053fb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105402:	e8 99 f7 ff ff       	call   80104ba0 <argint>
80105407:	85 c0                	test   %eax,%eax
80105409:	0f 88 b6 00 00 00    	js     801054c5 <sys_open+0xf5>
    return -1;

  begin_op();
8010540f:	e8 2c d7 ff ff       	call   80102b40 <begin_op>

  if(omode & O_CREATE){
80105414:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105418:	0f 85 82 00 00 00    	jne    801054a0 <sys_open+0xd0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010541e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105421:	89 04 24             	mov    %eax,(%esp)
80105424:	e8 07 cb ff ff       	call   80101f30 <namei>
80105429:	85 c0                	test   %eax,%eax
8010542b:	89 c6                	mov    %eax,%esi
8010542d:	0f 84 8d 00 00 00    	je     801054c0 <sys_open+0xf0>
      end_op();
      return -1;
    }
    ilock(ip);
80105433:	89 04 24             	mov    %eax,(%esp)
80105436:	e8 a5 c2 ff ff       	call   801016e0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
8010543b:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105440:	0f 84 92 00 00 00    	je     801054d8 <sys_open+0x108>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105446:	e8 45 b9 ff ff       	call   80100d90 <filealloc>
8010544b:	85 c0                	test   %eax,%eax
8010544d:	89 c3                	mov    %eax,%ebx
8010544f:	0f 84 93 00 00 00    	je     801054e8 <sys_open+0x118>
80105455:	e8 86 f8 ff ff       	call   80104ce0 <fdalloc>
8010545a:	85 c0                	test   %eax,%eax
8010545c:	89 c7                	mov    %eax,%edi
8010545e:	0f 88 94 00 00 00    	js     801054f8 <sys_open+0x128>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105464:	89 34 24             	mov    %esi,(%esp)
80105467:	e8 54 c3 ff ff       	call   801017c0 <iunlock>
  end_op();
8010546c:	e8 3f d7 ff ff       	call   80102bb0 <end_op>

  f->type = FD_INODE;
80105471:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105477:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  f->ip = ip;
8010547a:	89 73 10             	mov    %esi,0x10(%ebx)
  f->off = 0;
8010547d:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
  f->readable = !(omode & O_WRONLY);
80105484:	89 c2                	mov    %eax,%edx
80105486:	83 e2 01             	and    $0x1,%edx
80105489:	83 f2 01             	xor    $0x1,%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010548c:	a8 03                	test   $0x3,%al
  f->readable = !(omode & O_WRONLY);
8010548e:	88 53 08             	mov    %dl,0x8(%ebx)
  return fd;
80105491:	89 f8                	mov    %edi,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105493:	0f 95 43 09          	setne  0x9(%ebx)
}
80105497:	83 c4 2c             	add    $0x2c,%esp
8010549a:	5b                   	pop    %ebx
8010549b:	5e                   	pop    %esi
8010549c:	5f                   	pop    %edi
8010549d:	5d                   	pop    %ebp
8010549e:	c3                   	ret    
8010549f:	90                   	nop
    ip = create(path, T_FILE, 0, 0);
801054a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801054a3:	31 c9                	xor    %ecx,%ecx
801054a5:	ba 02 00 00 00       	mov    $0x2,%edx
801054aa:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054b1:	e8 6a f8 ff ff       	call   80104d20 <create>
    if(ip == 0){
801054b6:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
801054b8:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801054ba:	75 8a                	jne    80105446 <sys_open+0x76>
801054bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
801054c0:	e8 eb d6 ff ff       	call   80102bb0 <end_op>
}
801054c5:	83 c4 2c             	add    $0x2c,%esp
    return -1;
801054c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054cd:	5b                   	pop    %ebx
801054ce:	5e                   	pop    %esi
801054cf:	5f                   	pop    %edi
801054d0:	5d                   	pop    %ebp
801054d1:	c3                   	ret    
801054d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801054d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801054db:	85 c0                	test   %eax,%eax
801054dd:	0f 84 63 ff ff ff    	je     80105446 <sys_open+0x76>
801054e3:	90                   	nop
801054e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
801054e8:	89 34 24             	mov    %esi,(%esp)
801054eb:	e8 50 c4 ff ff       	call   80101940 <iunlockput>
801054f0:	eb ce                	jmp    801054c0 <sys_open+0xf0>
801054f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      fileclose(f);
801054f8:	89 1c 24             	mov    %ebx,(%esp)
801054fb:	e8 50 b9 ff ff       	call   80100e50 <fileclose>
80105500:	eb e6                	jmp    801054e8 <sys_open+0x118>
80105502:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105510 <sys_mkdir>:

int
sys_mkdir(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105516:	e8 25 d6 ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010551b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010551e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105522:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105529:	e8 02 f7 ff ff       	call   80104c30 <argstr>
8010552e:	85 c0                	test   %eax,%eax
80105530:	78 2e                	js     80105560 <sys_mkdir+0x50>
80105532:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105535:	31 c9                	xor    %ecx,%ecx
80105537:	ba 01 00 00 00       	mov    $0x1,%edx
8010553c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105543:	e8 d8 f7 ff ff       	call   80104d20 <create>
80105548:	85 c0                	test   %eax,%eax
8010554a:	74 14                	je     80105560 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010554c:	89 04 24             	mov    %eax,(%esp)
8010554f:	e8 ec c3 ff ff       	call   80101940 <iunlockput>
  end_op();
80105554:	e8 57 d6 ff ff       	call   80102bb0 <end_op>
  return 0;
80105559:	31 c0                	xor    %eax,%eax
}
8010555b:	c9                   	leave  
8010555c:	c3                   	ret    
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
80105560:	e8 4b d6 ff ff       	call   80102bb0 <end_op>
    return -1;
80105565:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010556a:	c9                   	leave  
8010556b:	c3                   	ret    
8010556c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105570 <sys_mknod>:

int
sys_mknod(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105576:	e8 c5 d5 ff ff       	call   80102b40 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010557b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010557e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105582:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105589:	e8 a2 f6 ff ff       	call   80104c30 <argstr>
8010558e:	85 c0                	test   %eax,%eax
80105590:	78 5e                	js     801055f0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105592:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105595:	89 44 24 04          	mov    %eax,0x4(%esp)
80105599:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801055a0:	e8 fb f5 ff ff       	call   80104ba0 <argint>
  if((argstr(0, &path)) < 0 ||
801055a5:	85 c0                	test   %eax,%eax
801055a7:	78 47                	js     801055f0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801055a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055ac:	89 44 24 04          	mov    %eax,0x4(%esp)
801055b0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801055b7:	e8 e4 f5 ff ff       	call   80104ba0 <argint>
     argint(1, &major) < 0 ||
801055bc:	85 c0                	test   %eax,%eax
801055be:	78 30                	js     801055f0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801055c0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
801055c4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
801055c9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801055cd:	89 04 24             	mov    %eax,(%esp)
     argint(2, &minor) < 0 ||
801055d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801055d3:	e8 48 f7 ff ff       	call   80104d20 <create>
801055d8:	85 c0                	test   %eax,%eax
801055da:	74 14                	je     801055f0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801055dc:	89 04 24             	mov    %eax,(%esp)
801055df:	e8 5c c3 ff ff       	call   80101940 <iunlockput>
  end_op();
801055e4:	e8 c7 d5 ff ff       	call   80102bb0 <end_op>
  return 0;
801055e9:	31 c0                	xor    %eax,%eax
}
801055eb:	c9                   	leave  
801055ec:	c3                   	ret    
801055ed:	8d 76 00             	lea    0x0(%esi),%esi
    end_op();
801055f0:	e8 bb d5 ff ff       	call   80102bb0 <end_op>
    return -1;
801055f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055fa:	c9                   	leave  
801055fb:	c3                   	ret    
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <sys_chdir>:

int
sys_chdir(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	56                   	push   %esi
80105604:	53                   	push   %ebx
80105605:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105608:	e8 03 e1 ff ff       	call   80103710 <myproc>
8010560d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010560f:	e8 2c d5 ff ff       	call   80102b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105614:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105617:	89 44 24 04          	mov    %eax,0x4(%esp)
8010561b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105622:	e8 09 f6 ff ff       	call   80104c30 <argstr>
80105627:	85 c0                	test   %eax,%eax
80105629:	78 4a                	js     80105675 <sys_chdir+0x75>
8010562b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010562e:	89 04 24             	mov    %eax,(%esp)
80105631:	e8 fa c8 ff ff       	call   80101f30 <namei>
80105636:	85 c0                	test   %eax,%eax
80105638:	89 c3                	mov    %eax,%ebx
8010563a:	74 39                	je     80105675 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010563c:	89 04 24             	mov    %eax,(%esp)
8010563f:	e8 9c c0 ff ff       	call   801016e0 <ilock>
  if(ip->type != T_DIR){
80105644:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
    iunlockput(ip);
80105649:	89 1c 24             	mov    %ebx,(%esp)
  if(ip->type != T_DIR){
8010564c:	75 22                	jne    80105670 <sys_chdir+0x70>
    end_op();
    return -1;
  }
  iunlock(ip);
8010564e:	e8 6d c1 ff ff       	call   801017c0 <iunlock>
  iput(curproc->cwd);
80105653:	8b 46 68             	mov    0x68(%esi),%eax
80105656:	89 04 24             	mov    %eax,(%esp)
80105659:	e8 a2 c1 ff ff       	call   80101800 <iput>
  end_op();
8010565e:	e8 4d d5 ff ff       	call   80102bb0 <end_op>
  curproc->cwd = ip;
  return 0;
80105663:	31 c0                	xor    %eax,%eax
  curproc->cwd = ip;
80105665:	89 5e 68             	mov    %ebx,0x68(%esi)
}
80105668:	83 c4 20             	add    $0x20,%esp
8010566b:	5b                   	pop    %ebx
8010566c:	5e                   	pop    %esi
8010566d:	5d                   	pop    %ebp
8010566e:	c3                   	ret    
8010566f:	90                   	nop
    iunlockput(ip);
80105670:	e8 cb c2 ff ff       	call   80101940 <iunlockput>
    end_op();
80105675:	e8 36 d5 ff ff       	call   80102bb0 <end_op>
}
8010567a:	83 c4 20             	add    $0x20,%esp
    return -1;
8010567d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105682:	5b                   	pop    %ebx
80105683:	5e                   	pop    %esi
80105684:	5d                   	pop    %ebp
80105685:	c3                   	ret    
80105686:	8d 76 00             	lea    0x0(%esi),%esi
80105689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105690 <sys_exec>:

int
sys_exec(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	57                   	push   %edi
80105694:	56                   	push   %esi
80105695:	53                   	push   %ebx
80105696:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
8010569c:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
801056a2:	89 44 24 04          	mov    %eax,0x4(%esp)
801056a6:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801056ad:	e8 7e f5 ff ff       	call   80104c30 <argstr>
801056b2:	85 c0                	test   %eax,%eax
801056b4:	0f 88 84 00 00 00    	js     8010573e <sys_exec+0xae>
801056ba:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801056c0:	89 44 24 04          	mov    %eax,0x4(%esp)
801056c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801056cb:	e8 d0 f4 ff ff       	call   80104ba0 <argint>
801056d0:	85 c0                	test   %eax,%eax
801056d2:	78 6a                	js     8010573e <sys_exec+0xae>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801056d4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801056da:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801056dc:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
801056e3:	00 
801056e4:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801056ea:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801056f1:	00 
801056f2:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801056f8:	89 04 24             	mov    %eax,(%esp)
801056fb:	e8 b0 f1 ff ff       	call   801048b0 <memset>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105700:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105706:	89 7c 24 04          	mov    %edi,0x4(%esp)
8010570a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010570d:	89 04 24             	mov    %eax,(%esp)
80105710:	e8 eb f3 ff ff       	call   80104b00 <fetchint>
80105715:	85 c0                	test   %eax,%eax
80105717:	78 25                	js     8010573e <sys_exec+0xae>
      return -1;
    if(uarg == 0){
80105719:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010571f:	85 c0                	test   %eax,%eax
80105721:	74 2d                	je     80105750 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105723:	89 74 24 04          	mov    %esi,0x4(%esp)
80105727:	89 04 24             	mov    %eax,(%esp)
8010572a:	e8 11 f4 ff ff       	call   80104b40 <fetchstr>
8010572f:	85 c0                	test   %eax,%eax
80105731:	78 0b                	js     8010573e <sys_exec+0xae>
  for(i=0;; i++){
80105733:	83 c3 01             	add    $0x1,%ebx
80105736:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
80105739:	83 fb 20             	cmp    $0x20,%ebx
8010573c:	75 c2                	jne    80105700 <sys_exec+0x70>
      return -1;
  }
  return exec(path, argv);
}
8010573e:	81 c4 ac 00 00 00    	add    $0xac,%esp
    return -1;
80105744:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105749:	5b                   	pop    %ebx
8010574a:	5e                   	pop    %esi
8010574b:	5f                   	pop    %edi
8010574c:	5d                   	pop    %ebp
8010574d:	c3                   	ret    
8010574e:	66 90                	xchg   %ax,%ax
  return exec(path, argv);
80105750:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105756:	89 44 24 04          	mov    %eax,0x4(%esp)
8010575a:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
      argv[i] = 0;
80105760:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105767:	00 00 00 00 
  return exec(path, argv);
8010576b:	89 04 24             	mov    %eax,(%esp)
8010576e:	e8 4d b2 ff ff       	call   801009c0 <exec>
}
80105773:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105779:	5b                   	pop    %ebx
8010577a:	5e                   	pop    %esi
8010577b:	5f                   	pop    %edi
8010577c:	5d                   	pop    %ebp
8010577d:	c3                   	ret    
8010577e:	66 90                	xchg   %ax,%ax

80105780 <sys_pipe>:

int
sys_pipe(void)
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	53                   	push   %ebx
80105784:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105787:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010578a:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
80105791:	00 
80105792:	89 44 24 04          	mov    %eax,0x4(%esp)
80105796:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010579d:	e8 2e f4 ff ff       	call   80104bd0 <argptr>
801057a2:	85 c0                	test   %eax,%eax
801057a4:	78 6d                	js     80105813 <sys_pipe+0x93>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801057a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801057ad:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057b0:	89 04 24             	mov    %eax,(%esp)
801057b3:	e8 e8 d9 ff ff       	call   801031a0 <pipealloc>
801057b8:	85 c0                	test   %eax,%eax
801057ba:	78 57                	js     80105813 <sys_pipe+0x93>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801057bf:	e8 1c f5 ff ff       	call   80104ce0 <fdalloc>
801057c4:	85 c0                	test   %eax,%eax
801057c6:	89 c3                	mov    %eax,%ebx
801057c8:	78 33                	js     801057fd <sys_pipe+0x7d>
801057ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057cd:	e8 0e f5 ff ff       	call   80104ce0 <fdalloc>
801057d2:	85 c0                	test   %eax,%eax
801057d4:	78 1a                	js     801057f0 <sys_pipe+0x70>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
801057d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
801057d9:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
801057db:	8b 55 ec             	mov    -0x14(%ebp),%edx
801057de:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
801057e1:	83 c4 24             	add    $0x24,%esp
  return 0;
801057e4:	31 c0                	xor    %eax,%eax
}
801057e6:	5b                   	pop    %ebx
801057e7:	5d                   	pop    %ebp
801057e8:	c3                   	ret    
801057e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      myproc()->ofile[fd0] = 0;
801057f0:	e8 1b df ff ff       	call   80103710 <myproc>
801057f5:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
801057fc:	00 
    fileclose(rf);
801057fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105800:	89 04 24             	mov    %eax,(%esp)
80105803:	e8 48 b6 ff ff       	call   80100e50 <fileclose>
    fileclose(wf);
80105808:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010580b:	89 04 24             	mov    %eax,(%esp)
8010580e:	e8 3d b6 ff ff       	call   80100e50 <fileclose>
}
80105813:	83 c4 24             	add    $0x24,%esp
    return -1;
80105816:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010581b:	5b                   	pop    %ebx
8010581c:	5d                   	pop    %ebp
8010581d:	c3                   	ret    
8010581e:	66 90                	xchg   %ax,%ax

80105820 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105823:	5d                   	pop    %ebp
  return fork();
80105824:	e9 67 e2 ff ff       	jmp    80103a90 <fork>
80105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105830 <sys_getppid>:

#ifdef GETPPID
int
sys_getppid(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	83 ec 08             	sub    $0x8,%esp
    int ppid = 1;

    if (myproc()->parent) {
80105836:	e8 d5 de ff ff       	call   80103710 <myproc>
    int ppid = 1;
8010583b:	ba 01 00 00 00       	mov    $0x1,%edx
    if (myproc()->parent) {
80105840:	8b 40 14             	mov    0x14(%eax),%eax
80105843:	85 c0                	test   %eax,%eax
80105845:	74 0b                	je     80105852 <sys_getppid+0x22>
        ppid = myproc()->parent->pid;
80105847:	e8 c4 de ff ff       	call   80103710 <myproc>
8010584c:	8b 40 14             	mov    0x14(%eax),%eax
8010584f:	8b 50 10             	mov    0x10(%eax),%edx
    }
    return ppid;
}
80105852:	89 d0                	mov    %edx,%eax
80105854:	c9                   	leave  
80105855:	c3                   	ret    
80105856:	8d 76 00             	lea    0x0(%esi),%esi
80105859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105860 <sys_exit>:
#endif 

int
sys_exit(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	83 ec 08             	sub    $0x8,%esp
  exit();
80105866:	e8 a5 e5 ff ff       	call   80103e10 <exit>
  return 0;  // not reached
}
8010586b:	31 c0                	xor    %eax,%eax
8010586d:	c9                   	leave  
8010586e:	c3                   	ret    
8010586f:	90                   	nop

80105870 <sys_wait>:

int
sys_wait(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105873:	5d                   	pop    %ebp
  return wait();
80105874:	e9 f7 e8 ff ff       	jmp    80104170 <wait>
80105879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105880 <sys_kill>:

int
sys_kill(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105886:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105889:	89 44 24 04          	mov    %eax,0x4(%esp)
8010588d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105894:	e8 07 f3 ff ff       	call   80104ba0 <argint>
80105899:	85 c0                	test   %eax,%eax
8010589b:	78 13                	js     801058b0 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010589d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058a0:	89 04 24             	mov    %eax,(%esp)
801058a3:	e8 28 ea ff ff       	call   801042d0 <kill>
}
801058a8:	c9                   	leave  
801058a9:	c3                   	ret    
801058aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801058b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058b5:	c9                   	leave  
801058b6:	c3                   	ret    
801058b7:	89 f6                	mov    %esi,%esi
801058b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058c0 <sys_getpid>:

int
sys_getpid(void)
{
801058c0:	55                   	push   %ebp
801058c1:	89 e5                	mov    %esp,%ebp
801058c3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801058c6:	e8 45 de ff ff       	call   80103710 <myproc>
801058cb:	8b 40 10             	mov    0x10(%eax),%eax
}
801058ce:	c9                   	leave  
801058cf:	c3                   	ret    

801058d0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	53                   	push   %ebx
801058d4:	83 ec 24             	sub    $0x24,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058d7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058da:	89 44 24 04          	mov    %eax,0x4(%esp)
801058de:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801058e5:	e8 b6 f2 ff ff       	call   80104ba0 <argint>
801058ea:	85 c0                	test   %eax,%eax
801058ec:	78 22                	js     80105910 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801058ee:	e8 1d de ff ff       	call   80103710 <myproc>
  if(growproc(n) < 0)
801058f3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  addr = myproc()->sz;
801058f6:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801058f8:	89 14 24             	mov    %edx,(%esp)
801058fb:	e8 50 df ff ff       	call   80103850 <growproc>
80105900:	85 c0                	test   %eax,%eax
80105902:	78 0c                	js     80105910 <sys_sbrk+0x40>
    return -1;
  return addr;
80105904:	89 d8                	mov    %ebx,%eax
}
80105906:	83 c4 24             	add    $0x24,%esp
80105909:	5b                   	pop    %ebx
8010590a:	5d                   	pop    %ebp
8010590b:	c3                   	ret    
8010590c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105915:	eb ef                	jmp    80105906 <sys_sbrk+0x36>
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_sleep>:

int
sys_sleep(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	53                   	push   %ebx
80105924:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105927:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010592a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010592e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105935:	e8 66 f2 ff ff       	call   80104ba0 <argint>
8010593a:	85 c0                	test   %eax,%eax
8010593c:	78 7e                	js     801059bc <sys_sleep+0x9c>
    return -1;
  acquire(&tickslock);
8010593e:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
80105945:	e8 a6 ee ff ff       	call   801047f0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010594a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
8010594d:	8b 1d c0 59 11 80    	mov    0x801159c0,%ebx
  while(ticks - ticks0 < n){
80105953:	85 d2                	test   %edx,%edx
80105955:	75 29                	jne    80105980 <sys_sleep+0x60>
80105957:	eb 4f                	jmp    801059a8 <sys_sleep+0x88>
80105959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105960:	c7 44 24 04 80 51 11 	movl   $0x80115180,0x4(%esp)
80105967:	80 
80105968:	c7 04 24 c0 59 11 80 	movl   $0x801159c0,(%esp)
8010596f:	e8 4c e7 ff ff       	call   801040c0 <sleep>
  while(ticks - ticks0 < n){
80105974:	a1 c0 59 11 80       	mov    0x801159c0,%eax
80105979:	29 d8                	sub    %ebx,%eax
8010597b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010597e:	73 28                	jae    801059a8 <sys_sleep+0x88>
    if(myproc()->killed){
80105980:	e8 8b dd ff ff       	call   80103710 <myproc>
80105985:	8b 40 24             	mov    0x24(%eax),%eax
80105988:	85 c0                	test   %eax,%eax
8010598a:	74 d4                	je     80105960 <sys_sleep+0x40>
      release(&tickslock);
8010598c:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
80105993:	e8 c8 ee ff ff       	call   80104860 <release>
      return -1;
80105998:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
8010599d:	83 c4 24             	add    $0x24,%esp
801059a0:	5b                   	pop    %ebx
801059a1:	5d                   	pop    %ebp
801059a2:	c3                   	ret    
801059a3:	90                   	nop
801059a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&tickslock);
801059a8:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
801059af:	e8 ac ee ff ff       	call   80104860 <release>
}
801059b4:	83 c4 24             	add    $0x24,%esp
  return 0;
801059b7:	31 c0                	xor    %eax,%eax
}
801059b9:	5b                   	pop    %ebx
801059ba:	5d                   	pop    %ebp
801059bb:	c3                   	ret    
    return -1;
801059bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059c1:	eb da                	jmp    8010599d <sys_sleep+0x7d>
801059c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059d0 <sys_kdebug>:

#ifdef KDEBUG
int
sys_kdebug(void)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	83 ec 38             	sub    $0x38,%esp
    extern uint debugState;

    int val = 0;

    if (argint(0, &val) < 0)
801059d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801059d9:	89 44 24 04          	mov    %eax,0x4(%esp)
801059dd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    int val = 0;
801059e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (argint(0, &val) < 0)
801059eb:	e8 b0 f1 ff ff       	call   80104ba0 <argint>
801059f0:	85 c0                	test   %eax,%eax
801059f2:	78 34                	js     80105a28 <sys_kdebug+0x58>
        return -1;
    debugState = val;
801059f4:	8b 45 f4             	mov    -0xc(%ebp),%eax

    cprintf("%s %s %d: set debugState = %d\n"
801059f7:	c7 44 24 0c 6a 00 00 	movl   $0x6a,0xc(%esp)
801059fe:	00 
801059ff:	c7 44 24 08 ff 7b 10 	movl   $0x80107bff,0x8(%esp)
80105a06:	80 
80105a07:	c7 44 24 04 d5 7b 10 	movl   $0x80107bd5,0x4(%esp)
80105a0e:	80 
80105a0f:	89 44 24 10          	mov    %eax,0x10(%esp)
80105a13:	c7 04 24 e0 7b 10 80 	movl   $0x80107be0,(%esp)
    debugState = val;
80105a1a:	a3 b8 a5 10 80       	mov    %eax,0x8010a5b8
    cprintf("%s %s %d: set debugState = %d\n"
80105a1f:	e8 2c ac ff ff       	call   80100650 <cprintf>
            , __FILE__, __FUNCTION__, __LINE__, val);

    return 0;
80105a24:	31 c0                	xor    %eax,%eax
}
80105a26:	c9                   	leave  
80105a27:	c3                   	ret    
        return -1;
80105a28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a2d:	c9                   	leave  
80105a2e:	c3                   	ret    
80105a2f:	90                   	nop

80105a30 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105a30:	55                   	push   %ebp
80105a31:	89 e5                	mov    %esp,%ebp
80105a33:	53                   	push   %ebx
80105a34:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105a37:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
80105a3e:	e8 ad ed ff ff       	call   801047f0 <acquire>
  xticks = ticks;
80105a43:	8b 1d c0 59 11 80    	mov    0x801159c0,%ebx
  release(&tickslock);
80105a49:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
80105a50:	e8 0b ee ff ff       	call   80104860 <release>
  return xticks;
}
80105a55:	83 c4 14             	add    $0x14,%esp
80105a58:	89 d8                	mov    %ebx,%eax
80105a5a:	5b                   	pop    %ebx
80105a5b:	5d                   	pop    %ebp
80105a5c:	c3                   	ret    
80105a5d:	8d 76 00             	lea    0x0(%esi),%esi

80105a60 <sys_halt>:

int
sys_halt(void)
{
80105a60:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a61:	ba f4 00 00 00       	mov    $0xf4,%edx
80105a66:	89 e5                	mov    %esp,%ebp
80105a68:	31 c0                	xor    %eax,%eax
80105a6a:	ee                   	out    %al,(%dx)
    outb(0xf4, 0x00);
    return 0;
}
80105a6b:	31 c0                	xor    %eax,%eax
80105a6d:	5d                   	pop    %ebp
80105a6e:	c3                   	ret    
80105a6f:	90                   	nop

80105a70 <sys_kthread_create>:

#ifdef KTHREADS

int
sys_kthread_create(void)
{
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	83 ec 28             	sub    $0x28,%esp
  char*tstack=NULL;

  void (*func)(void*);


  argptr(0,(char**)&func,sizeof(void*));
80105a76:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a79:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105a80:	00 
80105a81:	89 44 24 04          	mov    %eax,0x4(%esp)
80105a85:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  char*args=NULL;
80105a8c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  char*tstack=NULL;
80105a93:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  argptr(0,(char**)&func,sizeof(void*));
80105a9a:	e8 31 f1 ff ff       	call   80104bd0 <argptr>
  argptr(1,&args,sizeof(void*));
80105a9f:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105aa2:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105aa9:	00 
80105aaa:	89 44 24 04          	mov    %eax,0x4(%esp)
80105aae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105ab5:	e8 16 f1 ff ff       	call   80104bd0 <argptr>
  argptr(2,&tstack,sizeof(void*));
80105aba:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105abd:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
80105ac4:	00 
80105ac5:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ac9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80105ad0:	e8 fb f0 ff ff       	call   80104bd0 <argptr>
  return kthread_create(func,(void*)args,(void*)tstack);
80105ad5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ad8:	89 44 24 08          	mov    %eax,0x8(%esp)
80105adc:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105adf:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ae3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ae6:	89 04 24             	mov    %eax,(%esp)
80105ae9:	e8 d2 dd ff ff       	call   801038c0 <kthread_create>
}
80105aee:	c9                   	leave  
80105aef:	c3                   	ret    

80105af0 <sys_kthread_join>:

int
sys_kthread_join(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 28             	sub    $0x28,%esp
  int p=0;
  argint(0,&p);
80105af6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105af9:	89 44 24 04          	mov    %eax,0x4(%esp)
80105afd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int p=0;
80105b04:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  argint(0,&p);
80105b0b:	e8 90 f0 ff ff       	call   80104ba0 <argint>
  return kthread_join(p);
80105b10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b13:	89 04 24             	mov    %eax,(%esp)
80105b16:	e8 65 e4 ff ff       	call   80103f80 <kthread_join>
}
80105b1b:	c9                   	leave  
80105b1c:	c3                   	ret    
80105b1d:	8d 76 00             	lea    0x0(%esi),%esi

80105b20 <sys_kthread_exit>:

int
sys_kthread_exit(void)
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	83 ec 28             	sub    $0x28,%esp
  int p=0;
  argint(0,&p);
80105b26:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b29:	89 44 24 04          	mov    %eax,0x4(%esp)
80105b2d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  int p=0;
80105b34:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  argint(0,&p);
80105b3b:	e8 60 f0 ff ff       	call   80104ba0 <argint>
  kthread_exit(p);
80105b40:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b43:	89 04 24             	mov    %eax,(%esp)
80105b46:	e8 05 e2 ff ff       	call   80103d50 <kthread_exit>
  return 0;
}
80105b4b:	31 c0                	xor    %eax,%eax
80105b4d:	c9                   	leave  
80105b4e:	c3                   	ret    

80105b4f <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105b4f:	1e                   	push   %ds
  pushl %es
80105b50:	06                   	push   %es
  pushl %fs
80105b51:	0f a0                	push   %fs
  pushl %gs
80105b53:	0f a8                	push   %gs
  pushal
80105b55:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105b56:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105b5a:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105b5c:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105b5e:	54                   	push   %esp
  call trap
80105b5f:	e8 ec 00 00 00       	call   80105c50 <trap>
  addl $4, %esp
80105b64:	83 c4 04             	add    $0x4,%esp

80105b67 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105b67:	61                   	popa   
  popl %gs
80105b68:	0f a9                	pop    %gs
  popl %fs
80105b6a:	0f a1                	pop    %fs
  popl %es
80105b6c:	07                   	pop    %es
  popl %ds
80105b6d:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105b6e:	83 c4 08             	add    $0x8,%esp
  iret
80105b71:	cf                   	iret   
80105b72:	66 90                	xchg   %ax,%ax
80105b74:	66 90                	xchg   %ax,%ax
80105b76:	66 90                	xchg   %ax,%ax
80105b78:	66 90                	xchg   %ax,%ax
80105b7a:	66 90                	xchg   %ax,%ax
80105b7c:	66 90                	xchg   %ax,%ax
80105b7e:	66 90                	xchg   %ax,%ax

80105b80 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105b80:	31 c0                	xor    %eax,%eax
80105b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105b88:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105b8f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105b94:	66 89 0c c5 c2 51 11 	mov    %cx,-0x7feeae3e(,%eax,8)
80105b9b:	80 
80105b9c:	c6 04 c5 c4 51 11 80 	movb   $0x0,-0x7feeae3c(,%eax,8)
80105ba3:	00 
80105ba4:	c6 04 c5 c5 51 11 80 	movb   $0x8e,-0x7feeae3b(,%eax,8)
80105bab:	8e 
80105bac:	66 89 14 c5 c0 51 11 	mov    %dx,-0x7feeae40(,%eax,8)
80105bb3:	80 
80105bb4:	c1 ea 10             	shr    $0x10,%edx
80105bb7:	66 89 14 c5 c6 51 11 	mov    %dx,-0x7feeae3a(,%eax,8)
80105bbe:	80 
  for(i = 0; i < 256; i++)
80105bbf:	83 c0 01             	add    $0x1,%eax
80105bc2:	3d 00 01 00 00       	cmp    $0x100,%eax
80105bc7:	75 bf                	jne    80105b88 <tvinit+0x8>
{
80105bc9:	55                   	push   %ebp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bca:	ba 08 00 00 00       	mov    $0x8,%edx
{
80105bcf:	89 e5                	mov    %esp,%ebp
80105bd1:	83 ec 18             	sub    $0x18,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105bd4:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
80105bd9:	c7 44 24 04 0a 7c 10 	movl   $0x80107c0a,0x4(%esp)
80105be0:	80 
80105be1:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105be8:	66 89 15 c2 53 11 80 	mov    %dx,0x801153c2
80105bef:	66 a3 c0 53 11 80    	mov    %ax,0x801153c0
80105bf5:	c1 e8 10             	shr    $0x10,%eax
80105bf8:	c6 05 c4 53 11 80 00 	movb   $0x0,0x801153c4
80105bff:	c6 05 c5 53 11 80 ef 	movb   $0xef,0x801153c5
80105c06:	66 a3 c6 53 11 80    	mov    %ax,0x801153c6
  initlock(&tickslock, "time");
80105c0c:	e8 6f ea ff ff       	call   80104680 <initlock>
}
80105c11:	c9                   	leave  
80105c12:	c3                   	ret    
80105c13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c20 <idtinit>:

void
idtinit(void)
{
80105c20:	55                   	push   %ebp
  pd[0] = size-1;
80105c21:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105c26:	89 e5                	mov    %esp,%ebp
80105c28:	83 ec 10             	sub    $0x10,%esp
80105c2b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105c2f:	b8 c0 51 11 80       	mov    $0x801151c0,%eax
80105c34:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105c38:	c1 e8 10             	shr    $0x10,%eax
80105c3b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105c3f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105c42:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105c45:	c9                   	leave  
80105c46:	c3                   	ret    
80105c47:	89 f6                	mov    %esi,%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105c50 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	57                   	push   %edi
80105c54:	56                   	push   %esi
80105c55:	53                   	push   %ebx
80105c56:	83 ec 3c             	sub    $0x3c,%esp
80105c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105c5c:	8b 43 30             	mov    0x30(%ebx),%eax
80105c5f:	83 f8 40             	cmp    $0x40,%eax
80105c62:	0f 84 a0 01 00 00    	je     80105e08 <trap+0x1b8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105c68:	83 e8 20             	sub    $0x20,%eax
80105c6b:	83 f8 1f             	cmp    $0x1f,%eax
80105c6e:	77 08                	ja     80105c78 <trap+0x28>
80105c70:	ff 24 85 b0 7c 10 80 	jmp    *-0x7fef8350(,%eax,4)
80105c77:	90                   	nop
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80105c78:	e8 93 da ff ff       	call   80103710 <myproc>
80105c7d:	85 c0                	test   %eax,%eax
80105c7f:	90                   	nop
80105c80:	0f 84 fa 01 00 00    	je     80105e80 <trap+0x230>
80105c86:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105c8a:	0f 84 f0 01 00 00    	je     80105e80 <trap+0x230>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105c90:	0f 20 d1             	mov    %cr2,%ecx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c93:	8b 53 38             	mov    0x38(%ebx),%edx
80105c96:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105c99:	89 55 dc             	mov    %edx,-0x24(%ebp)
80105c9c:	e8 4f da ff ff       	call   801036f0 <cpuid>
80105ca1:	8b 73 30             	mov    0x30(%ebx),%esi
80105ca4:	89 c7                	mov    %eax,%edi
80105ca6:	8b 43 34             	mov    0x34(%ebx),%eax
80105ca9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105cac:	e8 5f da ff ff       	call   80103710 <myproc>
80105cb1:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105cb4:	e8 57 da ff ff       	call   80103710 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cb9:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105cbc:	89 74 24 0c          	mov    %esi,0xc(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105cc0:	8b 75 e0             	mov    -0x20(%ebp),%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cc3:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105cc6:	89 7c 24 14          	mov    %edi,0x14(%esp)
80105cca:	89 54 24 18          	mov    %edx,0x18(%esp)
80105cce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
            myproc()->pid, myproc()->name, tf->trapno,
80105cd1:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cd4:	89 4c 24 1c          	mov    %ecx,0x1c(%esp)
            myproc()->pid, myproc()->name, tf->trapno,
80105cd8:	89 74 24 08          	mov    %esi,0x8(%esp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105cdc:	89 54 24 10          	mov    %edx,0x10(%esp)
80105ce0:	8b 40 10             	mov    0x10(%eax),%eax
80105ce3:	c7 04 24 6c 7c 10 80 	movl   $0x80107c6c,(%esp)
80105cea:	89 44 24 04          	mov    %eax,0x4(%esp)
80105cee:	e8 5d a9 ff ff       	call   80100650 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80105cf3:	e8 18 da ff ff       	call   80103710 <myproc>
80105cf8:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105cff:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d00:	e8 0b da ff ff       	call   80103710 <myproc>
80105d05:	85 c0                	test   %eax,%eax
80105d07:	74 0c                	je     80105d15 <trap+0xc5>
80105d09:	e8 02 da ff ff       	call   80103710 <myproc>
80105d0e:	8b 50 24             	mov    0x24(%eax),%edx
80105d11:	85 d2                	test   %edx,%edx
80105d13:	75 4b                	jne    80105d60 <trap+0x110>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105d15:	e8 f6 d9 ff ff       	call   80103710 <myproc>
80105d1a:	85 c0                	test   %eax,%eax
80105d1c:	74 0d                	je     80105d2b <trap+0xdb>
80105d1e:	66 90                	xchg   %ax,%ax
80105d20:	e8 eb d9 ff ff       	call   80103710 <myproc>
80105d25:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105d29:	74 4d                	je     80105d78 <trap+0x128>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d2b:	e8 e0 d9 ff ff       	call   80103710 <myproc>
80105d30:	85 c0                	test   %eax,%eax
80105d32:	74 1d                	je     80105d51 <trap+0x101>
80105d34:	e8 d7 d9 ff ff       	call   80103710 <myproc>
80105d39:	8b 40 24             	mov    0x24(%eax),%eax
80105d3c:	85 c0                	test   %eax,%eax
80105d3e:	74 11                	je     80105d51 <trap+0x101>
80105d40:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105d44:	83 e0 03             	and    $0x3,%eax
80105d47:	66 83 f8 03          	cmp    $0x3,%ax
80105d4b:	0f 84 e8 00 00 00    	je     80105e39 <trap+0x1e9>
    exit();
}
80105d51:	83 c4 3c             	add    $0x3c,%esp
80105d54:	5b                   	pop    %ebx
80105d55:	5e                   	pop    %esi
80105d56:	5f                   	pop    %edi
80105d57:	5d                   	pop    %ebp
80105d58:	c3                   	ret    
80105d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d60:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105d64:	83 e0 03             	and    $0x3,%eax
80105d67:	66 83 f8 03          	cmp    $0x3,%ax
80105d6b:	75 a8                	jne    80105d15 <trap+0xc5>
    exit();
80105d6d:	e8 9e e0 ff ff       	call   80103e10 <exit>
80105d72:	eb a1                	jmp    80105d15 <trap+0xc5>
80105d74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->state == RUNNING &&
80105d78:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d80:	75 a9                	jne    80105d2b <trap+0xdb>
    yield();
80105d82:	e8 b9 e1 ff ff       	call   80103f40 <yield>
80105d87:	eb a2                	jmp    80105d2b <trap+0xdb>
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105d90:	e8 5b d9 ff ff       	call   801036f0 <cpuid>
80105d95:	85 c0                	test   %eax,%eax
80105d97:	0f 84 b3 00 00 00    	je     80105e50 <trap+0x200>
80105d9d:	8d 76 00             	lea    0x0(%esi),%esi
    lapiceoi();
80105da0:	e8 0b ca ff ff       	call   801027b0 <lapiceoi>
    break;
80105da5:	e9 56 ff ff ff       	jmp    80105d00 <trap+0xb0>
80105daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    kbdintr();
80105db0:	e8 4b c8 ff ff       	call   80102600 <kbdintr>
    lapiceoi();
80105db5:	e8 f6 c9 ff ff       	call   801027b0 <lapiceoi>
    break;
80105dba:	e9 41 ff ff ff       	jmp    80105d00 <trap+0xb0>
80105dbf:	90                   	nop
    uartintr();
80105dc0:	e8 1b 02 00 00       	call   80105fe0 <uartintr>
    lapiceoi();
80105dc5:	e8 e6 c9 ff ff       	call   801027b0 <lapiceoi>
    break;
80105dca:	e9 31 ff ff ff       	jmp    80105d00 <trap+0xb0>
80105dcf:	90                   	nop
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105dd0:	8b 7b 38             	mov    0x38(%ebx),%edi
80105dd3:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105dd7:	e8 14 d9 ff ff       	call   801036f0 <cpuid>
80105ddc:	c7 04 24 14 7c 10 80 	movl   $0x80107c14,(%esp)
80105de3:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105de7:	89 74 24 08          	mov    %esi,0x8(%esp)
80105deb:	89 44 24 04          	mov    %eax,0x4(%esp)
80105def:	e8 5c a8 ff ff       	call   80100650 <cprintf>
    lapiceoi();
80105df4:	e8 b7 c9 ff ff       	call   801027b0 <lapiceoi>
    break;
80105df9:	e9 02 ff ff ff       	jmp    80105d00 <trap+0xb0>
80105dfe:	66 90                	xchg   %ax,%ax
    ideintr();
80105e00:	e8 ab c2 ff ff       	call   801020b0 <ideintr>
80105e05:	eb 96                	jmp    80105d9d <trap+0x14d>
80105e07:	90                   	nop
80105e08:	90                   	nop
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105e10:	e8 fb d8 ff ff       	call   80103710 <myproc>
80105e15:	8b 70 24             	mov    0x24(%eax),%esi
80105e18:	85 f6                	test   %esi,%esi
80105e1a:	75 2c                	jne    80105e48 <trap+0x1f8>
    myproc()->tf = tf;
80105e1c:	e8 ef d8 ff ff       	call   80103710 <myproc>
80105e21:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105e24:	e8 47 ee ff ff       	call   80104c70 <syscall>
    if(myproc()->killed)
80105e29:	e8 e2 d8 ff ff       	call   80103710 <myproc>
80105e2e:	8b 48 24             	mov    0x24(%eax),%ecx
80105e31:	85 c9                	test   %ecx,%ecx
80105e33:	0f 84 18 ff ff ff    	je     80105d51 <trap+0x101>
}
80105e39:	83 c4 3c             	add    $0x3c,%esp
80105e3c:	5b                   	pop    %ebx
80105e3d:	5e                   	pop    %esi
80105e3e:	5f                   	pop    %edi
80105e3f:	5d                   	pop    %ebp
      exit();
80105e40:	e9 cb df ff ff       	jmp    80103e10 <exit>
80105e45:	8d 76 00             	lea    0x0(%esi),%esi
      exit();
80105e48:	e8 c3 df ff ff       	call   80103e10 <exit>
80105e4d:	eb cd                	jmp    80105e1c <trap+0x1cc>
80105e4f:	90                   	nop
      acquire(&tickslock);
80105e50:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
80105e57:	e8 94 e9 ff ff       	call   801047f0 <acquire>
      wakeup(&ticks);
80105e5c:	c7 04 24 c0 59 11 80 	movl   $0x801159c0,(%esp)
      ticks++;
80105e63:	83 05 c0 59 11 80 01 	addl   $0x1,0x801159c0
      wakeup(&ticks);
80105e6a:	e8 f1 e3 ff ff       	call   80104260 <wakeup>
      release(&tickslock);
80105e6f:	c7 04 24 80 51 11 80 	movl   $0x80115180,(%esp)
80105e76:	e8 e5 e9 ff ff       	call   80104860 <release>
80105e7b:	e9 1d ff ff ff       	jmp    80105d9d <trap+0x14d>
80105e80:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105e83:	8b 73 38             	mov    0x38(%ebx),%esi
80105e86:	e8 65 d8 ff ff       	call   801036f0 <cpuid>
80105e8b:	89 7c 24 10          	mov    %edi,0x10(%esp)
80105e8f:	89 74 24 0c          	mov    %esi,0xc(%esp)
80105e93:	89 44 24 08          	mov    %eax,0x8(%esp)
80105e97:	8b 43 30             	mov    0x30(%ebx),%eax
80105e9a:	c7 04 24 38 7c 10 80 	movl   $0x80107c38,(%esp)
80105ea1:	89 44 24 04          	mov    %eax,0x4(%esp)
80105ea5:	e8 a6 a7 ff ff       	call   80100650 <cprintf>
      panic("trap");
80105eaa:	c7 04 24 0f 7c 10 80 	movl   $0x80107c0f,(%esp)
80105eb1:	e8 aa a4 ff ff       	call   80100360 <panic>
80105eb6:	66 90                	xchg   %ax,%ax
80105eb8:	66 90                	xchg   %ax,%ax
80105eba:	66 90                	xchg   %ax,%ax
80105ebc:	66 90                	xchg   %ax,%ax
80105ebe:	66 90                	xchg   %ax,%ax

80105ec0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105ec0:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
{
80105ec5:	55                   	push   %ebp
80105ec6:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105ec8:	85 c0                	test   %eax,%eax
80105eca:	74 14                	je     80105ee0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105ecc:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ed1:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105ed2:	a8 01                	test   $0x1,%al
80105ed4:	74 0a                	je     80105ee0 <uartgetc+0x20>
80105ed6:	b2 f8                	mov    $0xf8,%dl
80105ed8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105ed9:	0f b6 c0             	movzbl %al,%eax
}
80105edc:	5d                   	pop    %ebp
80105edd:	c3                   	ret    
80105ede:	66 90                	xchg   %ax,%ax
    return -1;
80105ee0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ee5:	5d                   	pop    %ebp
80105ee6:	c3                   	ret    
80105ee7:	89 f6                	mov    %esi,%esi
80105ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ef0 <uartputc>:
  if(!uart)
80105ef0:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
80105ef5:	85 c0                	test   %eax,%eax
80105ef7:	74 3f                	je     80105f38 <uartputc+0x48>
{
80105ef9:	55                   	push   %ebp
80105efa:	89 e5                	mov    %esp,%ebp
80105efc:	56                   	push   %esi
80105efd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105f02:	53                   	push   %ebx
  if(!uart)
80105f03:	bb 80 00 00 00       	mov    $0x80,%ebx
{
80105f08:	83 ec 10             	sub    $0x10,%esp
80105f0b:	eb 14                	jmp    80105f21 <uartputc+0x31>
80105f0d:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105f10:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105f17:	e8 b4 c8 ff ff       	call   801027d0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f1c:	83 eb 01             	sub    $0x1,%ebx
80105f1f:	74 07                	je     80105f28 <uartputc+0x38>
80105f21:	89 f2                	mov    %esi,%edx
80105f23:	ec                   	in     (%dx),%al
80105f24:	a8 20                	test   $0x20,%al
80105f26:	74 e8                	je     80105f10 <uartputc+0x20>
  outb(COM1+0, c);
80105f28:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f2c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f31:	ee                   	out    %al,(%dx)
}
80105f32:	83 c4 10             	add    $0x10,%esp
80105f35:	5b                   	pop    %ebx
80105f36:	5e                   	pop    %esi
80105f37:	5d                   	pop    %ebp
80105f38:	f3 c3                	repz ret 
80105f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f40 <uartinit>:
{
80105f40:	55                   	push   %ebp
80105f41:	31 c9                	xor    %ecx,%ecx
80105f43:	89 e5                	mov    %esp,%ebp
80105f45:	89 c8                	mov    %ecx,%eax
80105f47:	57                   	push   %edi
80105f48:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105f4d:	56                   	push   %esi
80105f4e:	89 fa                	mov    %edi,%edx
80105f50:	53                   	push   %ebx
80105f51:	83 ec 1c             	sub    $0x1c,%esp
80105f54:	ee                   	out    %al,(%dx)
80105f55:	be fb 03 00 00       	mov    $0x3fb,%esi
80105f5a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105f5f:	89 f2                	mov    %esi,%edx
80105f61:	ee                   	out    %al,(%dx)
80105f62:	b8 0c 00 00 00       	mov    $0xc,%eax
80105f67:	b2 f8                	mov    $0xf8,%dl
80105f69:	ee                   	out    %al,(%dx)
80105f6a:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105f6f:	89 c8                	mov    %ecx,%eax
80105f71:	89 da                	mov    %ebx,%edx
80105f73:	ee                   	out    %al,(%dx)
80105f74:	b8 03 00 00 00       	mov    $0x3,%eax
80105f79:	89 f2                	mov    %esi,%edx
80105f7b:	ee                   	out    %al,(%dx)
80105f7c:	b2 fc                	mov    $0xfc,%dl
80105f7e:	89 c8                	mov    %ecx,%eax
80105f80:	ee                   	out    %al,(%dx)
80105f81:	b8 01 00 00 00       	mov    $0x1,%eax
80105f86:	89 da                	mov    %ebx,%edx
80105f88:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f89:	b2 fd                	mov    $0xfd,%dl
80105f8b:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105f8c:	3c ff                	cmp    $0xff,%al
80105f8e:	74 42                	je     80105fd2 <uartinit+0x92>
  uart = 1;
80105f90:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80105f97:	00 00 00 
80105f9a:	89 fa                	mov    %edi,%edx
80105f9c:	ec                   	in     (%dx),%al
80105f9d:	b2 f8                	mov    $0xf8,%dl
80105f9f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105fa0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105fa7:	00 
  for(p="xv6...\n"; *p; p++)
80105fa8:	bb 30 7d 10 80       	mov    $0x80107d30,%ebx
  ioapicenable(IRQ_COM1, 0);
80105fad:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105fb4:	e8 27 c3 ff ff       	call   801022e0 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
80105fb9:	b8 78 00 00 00       	mov    $0x78,%eax
80105fbe:	66 90                	xchg   %ax,%ax
    uartputc(*p);
80105fc0:	89 04 24             	mov    %eax,(%esp)
  for(p="xv6...\n"; *p; p++)
80105fc3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105fc6:	e8 25 ff ff ff       	call   80105ef0 <uartputc>
  for(p="xv6...\n"; *p; p++)
80105fcb:	0f be 03             	movsbl (%ebx),%eax
80105fce:	84 c0                	test   %al,%al
80105fd0:	75 ee                	jne    80105fc0 <uartinit+0x80>
}
80105fd2:	83 c4 1c             	add    $0x1c,%esp
80105fd5:	5b                   	pop    %ebx
80105fd6:	5e                   	pop    %esi
80105fd7:	5f                   	pop    %edi
80105fd8:	5d                   	pop    %ebp
80105fd9:	c3                   	ret    
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105fe0 <uartintr>:

void
uartintr(void)
{
80105fe0:	55                   	push   %ebp
80105fe1:	89 e5                	mov    %esp,%ebp
80105fe3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105fe6:	c7 04 24 c0 5e 10 80 	movl   $0x80105ec0,(%esp)
80105fed:	e8 de a7 ff ff       	call   801007d0 <consoleintr>
}
80105ff2:	c9                   	leave  
80105ff3:	c3                   	ret    

80105ff4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105ff4:	6a 00                	push   $0x0
  pushl $0
80105ff6:	6a 00                	push   $0x0
  jmp alltraps
80105ff8:	e9 52 fb ff ff       	jmp    80105b4f <alltraps>

80105ffd <vector1>:
.globl vector1
vector1:
  pushl $0
80105ffd:	6a 00                	push   $0x0
  pushl $1
80105fff:	6a 01                	push   $0x1
  jmp alltraps
80106001:	e9 49 fb ff ff       	jmp    80105b4f <alltraps>

80106006 <vector2>:
.globl vector2
vector2:
  pushl $0
80106006:	6a 00                	push   $0x0
  pushl $2
80106008:	6a 02                	push   $0x2
  jmp alltraps
8010600a:	e9 40 fb ff ff       	jmp    80105b4f <alltraps>

8010600f <vector3>:
.globl vector3
vector3:
  pushl $0
8010600f:	6a 00                	push   $0x0
  pushl $3
80106011:	6a 03                	push   $0x3
  jmp alltraps
80106013:	e9 37 fb ff ff       	jmp    80105b4f <alltraps>

80106018 <vector4>:
.globl vector4
vector4:
  pushl $0
80106018:	6a 00                	push   $0x0
  pushl $4
8010601a:	6a 04                	push   $0x4
  jmp alltraps
8010601c:	e9 2e fb ff ff       	jmp    80105b4f <alltraps>

80106021 <vector5>:
.globl vector5
vector5:
  pushl $0
80106021:	6a 00                	push   $0x0
  pushl $5
80106023:	6a 05                	push   $0x5
  jmp alltraps
80106025:	e9 25 fb ff ff       	jmp    80105b4f <alltraps>

8010602a <vector6>:
.globl vector6
vector6:
  pushl $0
8010602a:	6a 00                	push   $0x0
  pushl $6
8010602c:	6a 06                	push   $0x6
  jmp alltraps
8010602e:	e9 1c fb ff ff       	jmp    80105b4f <alltraps>

80106033 <vector7>:
.globl vector7
vector7:
  pushl $0
80106033:	6a 00                	push   $0x0
  pushl $7
80106035:	6a 07                	push   $0x7
  jmp alltraps
80106037:	e9 13 fb ff ff       	jmp    80105b4f <alltraps>

8010603c <vector8>:
.globl vector8
vector8:
  pushl $8
8010603c:	6a 08                	push   $0x8
  jmp alltraps
8010603e:	e9 0c fb ff ff       	jmp    80105b4f <alltraps>

80106043 <vector9>:
.globl vector9
vector9:
  pushl $0
80106043:	6a 00                	push   $0x0
  pushl $9
80106045:	6a 09                	push   $0x9
  jmp alltraps
80106047:	e9 03 fb ff ff       	jmp    80105b4f <alltraps>

8010604c <vector10>:
.globl vector10
vector10:
  pushl $10
8010604c:	6a 0a                	push   $0xa
  jmp alltraps
8010604e:	e9 fc fa ff ff       	jmp    80105b4f <alltraps>

80106053 <vector11>:
.globl vector11
vector11:
  pushl $11
80106053:	6a 0b                	push   $0xb
  jmp alltraps
80106055:	e9 f5 fa ff ff       	jmp    80105b4f <alltraps>

8010605a <vector12>:
.globl vector12
vector12:
  pushl $12
8010605a:	6a 0c                	push   $0xc
  jmp alltraps
8010605c:	e9 ee fa ff ff       	jmp    80105b4f <alltraps>

80106061 <vector13>:
.globl vector13
vector13:
  pushl $13
80106061:	6a 0d                	push   $0xd
  jmp alltraps
80106063:	e9 e7 fa ff ff       	jmp    80105b4f <alltraps>

80106068 <vector14>:
.globl vector14
vector14:
  pushl $14
80106068:	6a 0e                	push   $0xe
  jmp alltraps
8010606a:	e9 e0 fa ff ff       	jmp    80105b4f <alltraps>

8010606f <vector15>:
.globl vector15
vector15:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $15
80106071:	6a 0f                	push   $0xf
  jmp alltraps
80106073:	e9 d7 fa ff ff       	jmp    80105b4f <alltraps>

80106078 <vector16>:
.globl vector16
vector16:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $16
8010607a:	6a 10                	push   $0x10
  jmp alltraps
8010607c:	e9 ce fa ff ff       	jmp    80105b4f <alltraps>

80106081 <vector17>:
.globl vector17
vector17:
  pushl $17
80106081:	6a 11                	push   $0x11
  jmp alltraps
80106083:	e9 c7 fa ff ff       	jmp    80105b4f <alltraps>

80106088 <vector18>:
.globl vector18
vector18:
  pushl $0
80106088:	6a 00                	push   $0x0
  pushl $18
8010608a:	6a 12                	push   $0x12
  jmp alltraps
8010608c:	e9 be fa ff ff       	jmp    80105b4f <alltraps>

80106091 <vector19>:
.globl vector19
vector19:
  pushl $0
80106091:	6a 00                	push   $0x0
  pushl $19
80106093:	6a 13                	push   $0x13
  jmp alltraps
80106095:	e9 b5 fa ff ff       	jmp    80105b4f <alltraps>

8010609a <vector20>:
.globl vector20
vector20:
  pushl $0
8010609a:	6a 00                	push   $0x0
  pushl $20
8010609c:	6a 14                	push   $0x14
  jmp alltraps
8010609e:	e9 ac fa ff ff       	jmp    80105b4f <alltraps>

801060a3 <vector21>:
.globl vector21
vector21:
  pushl $0
801060a3:	6a 00                	push   $0x0
  pushl $21
801060a5:	6a 15                	push   $0x15
  jmp alltraps
801060a7:	e9 a3 fa ff ff       	jmp    80105b4f <alltraps>

801060ac <vector22>:
.globl vector22
vector22:
  pushl $0
801060ac:	6a 00                	push   $0x0
  pushl $22
801060ae:	6a 16                	push   $0x16
  jmp alltraps
801060b0:	e9 9a fa ff ff       	jmp    80105b4f <alltraps>

801060b5 <vector23>:
.globl vector23
vector23:
  pushl $0
801060b5:	6a 00                	push   $0x0
  pushl $23
801060b7:	6a 17                	push   $0x17
  jmp alltraps
801060b9:	e9 91 fa ff ff       	jmp    80105b4f <alltraps>

801060be <vector24>:
.globl vector24
vector24:
  pushl $0
801060be:	6a 00                	push   $0x0
  pushl $24
801060c0:	6a 18                	push   $0x18
  jmp alltraps
801060c2:	e9 88 fa ff ff       	jmp    80105b4f <alltraps>

801060c7 <vector25>:
.globl vector25
vector25:
  pushl $0
801060c7:	6a 00                	push   $0x0
  pushl $25
801060c9:	6a 19                	push   $0x19
  jmp alltraps
801060cb:	e9 7f fa ff ff       	jmp    80105b4f <alltraps>

801060d0 <vector26>:
.globl vector26
vector26:
  pushl $0
801060d0:	6a 00                	push   $0x0
  pushl $26
801060d2:	6a 1a                	push   $0x1a
  jmp alltraps
801060d4:	e9 76 fa ff ff       	jmp    80105b4f <alltraps>

801060d9 <vector27>:
.globl vector27
vector27:
  pushl $0
801060d9:	6a 00                	push   $0x0
  pushl $27
801060db:	6a 1b                	push   $0x1b
  jmp alltraps
801060dd:	e9 6d fa ff ff       	jmp    80105b4f <alltraps>

801060e2 <vector28>:
.globl vector28
vector28:
  pushl $0
801060e2:	6a 00                	push   $0x0
  pushl $28
801060e4:	6a 1c                	push   $0x1c
  jmp alltraps
801060e6:	e9 64 fa ff ff       	jmp    80105b4f <alltraps>

801060eb <vector29>:
.globl vector29
vector29:
  pushl $0
801060eb:	6a 00                	push   $0x0
  pushl $29
801060ed:	6a 1d                	push   $0x1d
  jmp alltraps
801060ef:	e9 5b fa ff ff       	jmp    80105b4f <alltraps>

801060f4 <vector30>:
.globl vector30
vector30:
  pushl $0
801060f4:	6a 00                	push   $0x0
  pushl $30
801060f6:	6a 1e                	push   $0x1e
  jmp alltraps
801060f8:	e9 52 fa ff ff       	jmp    80105b4f <alltraps>

801060fd <vector31>:
.globl vector31
vector31:
  pushl $0
801060fd:	6a 00                	push   $0x0
  pushl $31
801060ff:	6a 1f                	push   $0x1f
  jmp alltraps
80106101:	e9 49 fa ff ff       	jmp    80105b4f <alltraps>

80106106 <vector32>:
.globl vector32
vector32:
  pushl $0
80106106:	6a 00                	push   $0x0
  pushl $32
80106108:	6a 20                	push   $0x20
  jmp alltraps
8010610a:	e9 40 fa ff ff       	jmp    80105b4f <alltraps>

8010610f <vector33>:
.globl vector33
vector33:
  pushl $0
8010610f:	6a 00                	push   $0x0
  pushl $33
80106111:	6a 21                	push   $0x21
  jmp alltraps
80106113:	e9 37 fa ff ff       	jmp    80105b4f <alltraps>

80106118 <vector34>:
.globl vector34
vector34:
  pushl $0
80106118:	6a 00                	push   $0x0
  pushl $34
8010611a:	6a 22                	push   $0x22
  jmp alltraps
8010611c:	e9 2e fa ff ff       	jmp    80105b4f <alltraps>

80106121 <vector35>:
.globl vector35
vector35:
  pushl $0
80106121:	6a 00                	push   $0x0
  pushl $35
80106123:	6a 23                	push   $0x23
  jmp alltraps
80106125:	e9 25 fa ff ff       	jmp    80105b4f <alltraps>

8010612a <vector36>:
.globl vector36
vector36:
  pushl $0
8010612a:	6a 00                	push   $0x0
  pushl $36
8010612c:	6a 24                	push   $0x24
  jmp alltraps
8010612e:	e9 1c fa ff ff       	jmp    80105b4f <alltraps>

80106133 <vector37>:
.globl vector37
vector37:
  pushl $0
80106133:	6a 00                	push   $0x0
  pushl $37
80106135:	6a 25                	push   $0x25
  jmp alltraps
80106137:	e9 13 fa ff ff       	jmp    80105b4f <alltraps>

8010613c <vector38>:
.globl vector38
vector38:
  pushl $0
8010613c:	6a 00                	push   $0x0
  pushl $38
8010613e:	6a 26                	push   $0x26
  jmp alltraps
80106140:	e9 0a fa ff ff       	jmp    80105b4f <alltraps>

80106145 <vector39>:
.globl vector39
vector39:
  pushl $0
80106145:	6a 00                	push   $0x0
  pushl $39
80106147:	6a 27                	push   $0x27
  jmp alltraps
80106149:	e9 01 fa ff ff       	jmp    80105b4f <alltraps>

8010614e <vector40>:
.globl vector40
vector40:
  pushl $0
8010614e:	6a 00                	push   $0x0
  pushl $40
80106150:	6a 28                	push   $0x28
  jmp alltraps
80106152:	e9 f8 f9 ff ff       	jmp    80105b4f <alltraps>

80106157 <vector41>:
.globl vector41
vector41:
  pushl $0
80106157:	6a 00                	push   $0x0
  pushl $41
80106159:	6a 29                	push   $0x29
  jmp alltraps
8010615b:	e9 ef f9 ff ff       	jmp    80105b4f <alltraps>

80106160 <vector42>:
.globl vector42
vector42:
  pushl $0
80106160:	6a 00                	push   $0x0
  pushl $42
80106162:	6a 2a                	push   $0x2a
  jmp alltraps
80106164:	e9 e6 f9 ff ff       	jmp    80105b4f <alltraps>

80106169 <vector43>:
.globl vector43
vector43:
  pushl $0
80106169:	6a 00                	push   $0x0
  pushl $43
8010616b:	6a 2b                	push   $0x2b
  jmp alltraps
8010616d:	e9 dd f9 ff ff       	jmp    80105b4f <alltraps>

80106172 <vector44>:
.globl vector44
vector44:
  pushl $0
80106172:	6a 00                	push   $0x0
  pushl $44
80106174:	6a 2c                	push   $0x2c
  jmp alltraps
80106176:	e9 d4 f9 ff ff       	jmp    80105b4f <alltraps>

8010617b <vector45>:
.globl vector45
vector45:
  pushl $0
8010617b:	6a 00                	push   $0x0
  pushl $45
8010617d:	6a 2d                	push   $0x2d
  jmp alltraps
8010617f:	e9 cb f9 ff ff       	jmp    80105b4f <alltraps>

80106184 <vector46>:
.globl vector46
vector46:
  pushl $0
80106184:	6a 00                	push   $0x0
  pushl $46
80106186:	6a 2e                	push   $0x2e
  jmp alltraps
80106188:	e9 c2 f9 ff ff       	jmp    80105b4f <alltraps>

8010618d <vector47>:
.globl vector47
vector47:
  pushl $0
8010618d:	6a 00                	push   $0x0
  pushl $47
8010618f:	6a 2f                	push   $0x2f
  jmp alltraps
80106191:	e9 b9 f9 ff ff       	jmp    80105b4f <alltraps>

80106196 <vector48>:
.globl vector48
vector48:
  pushl $0
80106196:	6a 00                	push   $0x0
  pushl $48
80106198:	6a 30                	push   $0x30
  jmp alltraps
8010619a:	e9 b0 f9 ff ff       	jmp    80105b4f <alltraps>

8010619f <vector49>:
.globl vector49
vector49:
  pushl $0
8010619f:	6a 00                	push   $0x0
  pushl $49
801061a1:	6a 31                	push   $0x31
  jmp alltraps
801061a3:	e9 a7 f9 ff ff       	jmp    80105b4f <alltraps>

801061a8 <vector50>:
.globl vector50
vector50:
  pushl $0
801061a8:	6a 00                	push   $0x0
  pushl $50
801061aa:	6a 32                	push   $0x32
  jmp alltraps
801061ac:	e9 9e f9 ff ff       	jmp    80105b4f <alltraps>

801061b1 <vector51>:
.globl vector51
vector51:
  pushl $0
801061b1:	6a 00                	push   $0x0
  pushl $51
801061b3:	6a 33                	push   $0x33
  jmp alltraps
801061b5:	e9 95 f9 ff ff       	jmp    80105b4f <alltraps>

801061ba <vector52>:
.globl vector52
vector52:
  pushl $0
801061ba:	6a 00                	push   $0x0
  pushl $52
801061bc:	6a 34                	push   $0x34
  jmp alltraps
801061be:	e9 8c f9 ff ff       	jmp    80105b4f <alltraps>

801061c3 <vector53>:
.globl vector53
vector53:
  pushl $0
801061c3:	6a 00                	push   $0x0
  pushl $53
801061c5:	6a 35                	push   $0x35
  jmp alltraps
801061c7:	e9 83 f9 ff ff       	jmp    80105b4f <alltraps>

801061cc <vector54>:
.globl vector54
vector54:
  pushl $0
801061cc:	6a 00                	push   $0x0
  pushl $54
801061ce:	6a 36                	push   $0x36
  jmp alltraps
801061d0:	e9 7a f9 ff ff       	jmp    80105b4f <alltraps>

801061d5 <vector55>:
.globl vector55
vector55:
  pushl $0
801061d5:	6a 00                	push   $0x0
  pushl $55
801061d7:	6a 37                	push   $0x37
  jmp alltraps
801061d9:	e9 71 f9 ff ff       	jmp    80105b4f <alltraps>

801061de <vector56>:
.globl vector56
vector56:
  pushl $0
801061de:	6a 00                	push   $0x0
  pushl $56
801061e0:	6a 38                	push   $0x38
  jmp alltraps
801061e2:	e9 68 f9 ff ff       	jmp    80105b4f <alltraps>

801061e7 <vector57>:
.globl vector57
vector57:
  pushl $0
801061e7:	6a 00                	push   $0x0
  pushl $57
801061e9:	6a 39                	push   $0x39
  jmp alltraps
801061eb:	e9 5f f9 ff ff       	jmp    80105b4f <alltraps>

801061f0 <vector58>:
.globl vector58
vector58:
  pushl $0
801061f0:	6a 00                	push   $0x0
  pushl $58
801061f2:	6a 3a                	push   $0x3a
  jmp alltraps
801061f4:	e9 56 f9 ff ff       	jmp    80105b4f <alltraps>

801061f9 <vector59>:
.globl vector59
vector59:
  pushl $0
801061f9:	6a 00                	push   $0x0
  pushl $59
801061fb:	6a 3b                	push   $0x3b
  jmp alltraps
801061fd:	e9 4d f9 ff ff       	jmp    80105b4f <alltraps>

80106202 <vector60>:
.globl vector60
vector60:
  pushl $0
80106202:	6a 00                	push   $0x0
  pushl $60
80106204:	6a 3c                	push   $0x3c
  jmp alltraps
80106206:	e9 44 f9 ff ff       	jmp    80105b4f <alltraps>

8010620b <vector61>:
.globl vector61
vector61:
  pushl $0
8010620b:	6a 00                	push   $0x0
  pushl $61
8010620d:	6a 3d                	push   $0x3d
  jmp alltraps
8010620f:	e9 3b f9 ff ff       	jmp    80105b4f <alltraps>

80106214 <vector62>:
.globl vector62
vector62:
  pushl $0
80106214:	6a 00                	push   $0x0
  pushl $62
80106216:	6a 3e                	push   $0x3e
  jmp alltraps
80106218:	e9 32 f9 ff ff       	jmp    80105b4f <alltraps>

8010621d <vector63>:
.globl vector63
vector63:
  pushl $0
8010621d:	6a 00                	push   $0x0
  pushl $63
8010621f:	6a 3f                	push   $0x3f
  jmp alltraps
80106221:	e9 29 f9 ff ff       	jmp    80105b4f <alltraps>

80106226 <vector64>:
.globl vector64
vector64:
  pushl $0
80106226:	6a 00                	push   $0x0
  pushl $64
80106228:	6a 40                	push   $0x40
  jmp alltraps
8010622a:	e9 20 f9 ff ff       	jmp    80105b4f <alltraps>

8010622f <vector65>:
.globl vector65
vector65:
  pushl $0
8010622f:	6a 00                	push   $0x0
  pushl $65
80106231:	6a 41                	push   $0x41
  jmp alltraps
80106233:	e9 17 f9 ff ff       	jmp    80105b4f <alltraps>

80106238 <vector66>:
.globl vector66
vector66:
  pushl $0
80106238:	6a 00                	push   $0x0
  pushl $66
8010623a:	6a 42                	push   $0x42
  jmp alltraps
8010623c:	e9 0e f9 ff ff       	jmp    80105b4f <alltraps>

80106241 <vector67>:
.globl vector67
vector67:
  pushl $0
80106241:	6a 00                	push   $0x0
  pushl $67
80106243:	6a 43                	push   $0x43
  jmp alltraps
80106245:	e9 05 f9 ff ff       	jmp    80105b4f <alltraps>

8010624a <vector68>:
.globl vector68
vector68:
  pushl $0
8010624a:	6a 00                	push   $0x0
  pushl $68
8010624c:	6a 44                	push   $0x44
  jmp alltraps
8010624e:	e9 fc f8 ff ff       	jmp    80105b4f <alltraps>

80106253 <vector69>:
.globl vector69
vector69:
  pushl $0
80106253:	6a 00                	push   $0x0
  pushl $69
80106255:	6a 45                	push   $0x45
  jmp alltraps
80106257:	e9 f3 f8 ff ff       	jmp    80105b4f <alltraps>

8010625c <vector70>:
.globl vector70
vector70:
  pushl $0
8010625c:	6a 00                	push   $0x0
  pushl $70
8010625e:	6a 46                	push   $0x46
  jmp alltraps
80106260:	e9 ea f8 ff ff       	jmp    80105b4f <alltraps>

80106265 <vector71>:
.globl vector71
vector71:
  pushl $0
80106265:	6a 00                	push   $0x0
  pushl $71
80106267:	6a 47                	push   $0x47
  jmp alltraps
80106269:	e9 e1 f8 ff ff       	jmp    80105b4f <alltraps>

8010626e <vector72>:
.globl vector72
vector72:
  pushl $0
8010626e:	6a 00                	push   $0x0
  pushl $72
80106270:	6a 48                	push   $0x48
  jmp alltraps
80106272:	e9 d8 f8 ff ff       	jmp    80105b4f <alltraps>

80106277 <vector73>:
.globl vector73
vector73:
  pushl $0
80106277:	6a 00                	push   $0x0
  pushl $73
80106279:	6a 49                	push   $0x49
  jmp alltraps
8010627b:	e9 cf f8 ff ff       	jmp    80105b4f <alltraps>

80106280 <vector74>:
.globl vector74
vector74:
  pushl $0
80106280:	6a 00                	push   $0x0
  pushl $74
80106282:	6a 4a                	push   $0x4a
  jmp alltraps
80106284:	e9 c6 f8 ff ff       	jmp    80105b4f <alltraps>

80106289 <vector75>:
.globl vector75
vector75:
  pushl $0
80106289:	6a 00                	push   $0x0
  pushl $75
8010628b:	6a 4b                	push   $0x4b
  jmp alltraps
8010628d:	e9 bd f8 ff ff       	jmp    80105b4f <alltraps>

80106292 <vector76>:
.globl vector76
vector76:
  pushl $0
80106292:	6a 00                	push   $0x0
  pushl $76
80106294:	6a 4c                	push   $0x4c
  jmp alltraps
80106296:	e9 b4 f8 ff ff       	jmp    80105b4f <alltraps>

8010629b <vector77>:
.globl vector77
vector77:
  pushl $0
8010629b:	6a 00                	push   $0x0
  pushl $77
8010629d:	6a 4d                	push   $0x4d
  jmp alltraps
8010629f:	e9 ab f8 ff ff       	jmp    80105b4f <alltraps>

801062a4 <vector78>:
.globl vector78
vector78:
  pushl $0
801062a4:	6a 00                	push   $0x0
  pushl $78
801062a6:	6a 4e                	push   $0x4e
  jmp alltraps
801062a8:	e9 a2 f8 ff ff       	jmp    80105b4f <alltraps>

801062ad <vector79>:
.globl vector79
vector79:
  pushl $0
801062ad:	6a 00                	push   $0x0
  pushl $79
801062af:	6a 4f                	push   $0x4f
  jmp alltraps
801062b1:	e9 99 f8 ff ff       	jmp    80105b4f <alltraps>

801062b6 <vector80>:
.globl vector80
vector80:
  pushl $0
801062b6:	6a 00                	push   $0x0
  pushl $80
801062b8:	6a 50                	push   $0x50
  jmp alltraps
801062ba:	e9 90 f8 ff ff       	jmp    80105b4f <alltraps>

801062bf <vector81>:
.globl vector81
vector81:
  pushl $0
801062bf:	6a 00                	push   $0x0
  pushl $81
801062c1:	6a 51                	push   $0x51
  jmp alltraps
801062c3:	e9 87 f8 ff ff       	jmp    80105b4f <alltraps>

801062c8 <vector82>:
.globl vector82
vector82:
  pushl $0
801062c8:	6a 00                	push   $0x0
  pushl $82
801062ca:	6a 52                	push   $0x52
  jmp alltraps
801062cc:	e9 7e f8 ff ff       	jmp    80105b4f <alltraps>

801062d1 <vector83>:
.globl vector83
vector83:
  pushl $0
801062d1:	6a 00                	push   $0x0
  pushl $83
801062d3:	6a 53                	push   $0x53
  jmp alltraps
801062d5:	e9 75 f8 ff ff       	jmp    80105b4f <alltraps>

801062da <vector84>:
.globl vector84
vector84:
  pushl $0
801062da:	6a 00                	push   $0x0
  pushl $84
801062dc:	6a 54                	push   $0x54
  jmp alltraps
801062de:	e9 6c f8 ff ff       	jmp    80105b4f <alltraps>

801062e3 <vector85>:
.globl vector85
vector85:
  pushl $0
801062e3:	6a 00                	push   $0x0
  pushl $85
801062e5:	6a 55                	push   $0x55
  jmp alltraps
801062e7:	e9 63 f8 ff ff       	jmp    80105b4f <alltraps>

801062ec <vector86>:
.globl vector86
vector86:
  pushl $0
801062ec:	6a 00                	push   $0x0
  pushl $86
801062ee:	6a 56                	push   $0x56
  jmp alltraps
801062f0:	e9 5a f8 ff ff       	jmp    80105b4f <alltraps>

801062f5 <vector87>:
.globl vector87
vector87:
  pushl $0
801062f5:	6a 00                	push   $0x0
  pushl $87
801062f7:	6a 57                	push   $0x57
  jmp alltraps
801062f9:	e9 51 f8 ff ff       	jmp    80105b4f <alltraps>

801062fe <vector88>:
.globl vector88
vector88:
  pushl $0
801062fe:	6a 00                	push   $0x0
  pushl $88
80106300:	6a 58                	push   $0x58
  jmp alltraps
80106302:	e9 48 f8 ff ff       	jmp    80105b4f <alltraps>

80106307 <vector89>:
.globl vector89
vector89:
  pushl $0
80106307:	6a 00                	push   $0x0
  pushl $89
80106309:	6a 59                	push   $0x59
  jmp alltraps
8010630b:	e9 3f f8 ff ff       	jmp    80105b4f <alltraps>

80106310 <vector90>:
.globl vector90
vector90:
  pushl $0
80106310:	6a 00                	push   $0x0
  pushl $90
80106312:	6a 5a                	push   $0x5a
  jmp alltraps
80106314:	e9 36 f8 ff ff       	jmp    80105b4f <alltraps>

80106319 <vector91>:
.globl vector91
vector91:
  pushl $0
80106319:	6a 00                	push   $0x0
  pushl $91
8010631b:	6a 5b                	push   $0x5b
  jmp alltraps
8010631d:	e9 2d f8 ff ff       	jmp    80105b4f <alltraps>

80106322 <vector92>:
.globl vector92
vector92:
  pushl $0
80106322:	6a 00                	push   $0x0
  pushl $92
80106324:	6a 5c                	push   $0x5c
  jmp alltraps
80106326:	e9 24 f8 ff ff       	jmp    80105b4f <alltraps>

8010632b <vector93>:
.globl vector93
vector93:
  pushl $0
8010632b:	6a 00                	push   $0x0
  pushl $93
8010632d:	6a 5d                	push   $0x5d
  jmp alltraps
8010632f:	e9 1b f8 ff ff       	jmp    80105b4f <alltraps>

80106334 <vector94>:
.globl vector94
vector94:
  pushl $0
80106334:	6a 00                	push   $0x0
  pushl $94
80106336:	6a 5e                	push   $0x5e
  jmp alltraps
80106338:	e9 12 f8 ff ff       	jmp    80105b4f <alltraps>

8010633d <vector95>:
.globl vector95
vector95:
  pushl $0
8010633d:	6a 00                	push   $0x0
  pushl $95
8010633f:	6a 5f                	push   $0x5f
  jmp alltraps
80106341:	e9 09 f8 ff ff       	jmp    80105b4f <alltraps>

80106346 <vector96>:
.globl vector96
vector96:
  pushl $0
80106346:	6a 00                	push   $0x0
  pushl $96
80106348:	6a 60                	push   $0x60
  jmp alltraps
8010634a:	e9 00 f8 ff ff       	jmp    80105b4f <alltraps>

8010634f <vector97>:
.globl vector97
vector97:
  pushl $0
8010634f:	6a 00                	push   $0x0
  pushl $97
80106351:	6a 61                	push   $0x61
  jmp alltraps
80106353:	e9 f7 f7 ff ff       	jmp    80105b4f <alltraps>

80106358 <vector98>:
.globl vector98
vector98:
  pushl $0
80106358:	6a 00                	push   $0x0
  pushl $98
8010635a:	6a 62                	push   $0x62
  jmp alltraps
8010635c:	e9 ee f7 ff ff       	jmp    80105b4f <alltraps>

80106361 <vector99>:
.globl vector99
vector99:
  pushl $0
80106361:	6a 00                	push   $0x0
  pushl $99
80106363:	6a 63                	push   $0x63
  jmp alltraps
80106365:	e9 e5 f7 ff ff       	jmp    80105b4f <alltraps>

8010636a <vector100>:
.globl vector100
vector100:
  pushl $0
8010636a:	6a 00                	push   $0x0
  pushl $100
8010636c:	6a 64                	push   $0x64
  jmp alltraps
8010636e:	e9 dc f7 ff ff       	jmp    80105b4f <alltraps>

80106373 <vector101>:
.globl vector101
vector101:
  pushl $0
80106373:	6a 00                	push   $0x0
  pushl $101
80106375:	6a 65                	push   $0x65
  jmp alltraps
80106377:	e9 d3 f7 ff ff       	jmp    80105b4f <alltraps>

8010637c <vector102>:
.globl vector102
vector102:
  pushl $0
8010637c:	6a 00                	push   $0x0
  pushl $102
8010637e:	6a 66                	push   $0x66
  jmp alltraps
80106380:	e9 ca f7 ff ff       	jmp    80105b4f <alltraps>

80106385 <vector103>:
.globl vector103
vector103:
  pushl $0
80106385:	6a 00                	push   $0x0
  pushl $103
80106387:	6a 67                	push   $0x67
  jmp alltraps
80106389:	e9 c1 f7 ff ff       	jmp    80105b4f <alltraps>

8010638e <vector104>:
.globl vector104
vector104:
  pushl $0
8010638e:	6a 00                	push   $0x0
  pushl $104
80106390:	6a 68                	push   $0x68
  jmp alltraps
80106392:	e9 b8 f7 ff ff       	jmp    80105b4f <alltraps>

80106397 <vector105>:
.globl vector105
vector105:
  pushl $0
80106397:	6a 00                	push   $0x0
  pushl $105
80106399:	6a 69                	push   $0x69
  jmp alltraps
8010639b:	e9 af f7 ff ff       	jmp    80105b4f <alltraps>

801063a0 <vector106>:
.globl vector106
vector106:
  pushl $0
801063a0:	6a 00                	push   $0x0
  pushl $106
801063a2:	6a 6a                	push   $0x6a
  jmp alltraps
801063a4:	e9 a6 f7 ff ff       	jmp    80105b4f <alltraps>

801063a9 <vector107>:
.globl vector107
vector107:
  pushl $0
801063a9:	6a 00                	push   $0x0
  pushl $107
801063ab:	6a 6b                	push   $0x6b
  jmp alltraps
801063ad:	e9 9d f7 ff ff       	jmp    80105b4f <alltraps>

801063b2 <vector108>:
.globl vector108
vector108:
  pushl $0
801063b2:	6a 00                	push   $0x0
  pushl $108
801063b4:	6a 6c                	push   $0x6c
  jmp alltraps
801063b6:	e9 94 f7 ff ff       	jmp    80105b4f <alltraps>

801063bb <vector109>:
.globl vector109
vector109:
  pushl $0
801063bb:	6a 00                	push   $0x0
  pushl $109
801063bd:	6a 6d                	push   $0x6d
  jmp alltraps
801063bf:	e9 8b f7 ff ff       	jmp    80105b4f <alltraps>

801063c4 <vector110>:
.globl vector110
vector110:
  pushl $0
801063c4:	6a 00                	push   $0x0
  pushl $110
801063c6:	6a 6e                	push   $0x6e
  jmp alltraps
801063c8:	e9 82 f7 ff ff       	jmp    80105b4f <alltraps>

801063cd <vector111>:
.globl vector111
vector111:
  pushl $0
801063cd:	6a 00                	push   $0x0
  pushl $111
801063cf:	6a 6f                	push   $0x6f
  jmp alltraps
801063d1:	e9 79 f7 ff ff       	jmp    80105b4f <alltraps>

801063d6 <vector112>:
.globl vector112
vector112:
  pushl $0
801063d6:	6a 00                	push   $0x0
  pushl $112
801063d8:	6a 70                	push   $0x70
  jmp alltraps
801063da:	e9 70 f7 ff ff       	jmp    80105b4f <alltraps>

801063df <vector113>:
.globl vector113
vector113:
  pushl $0
801063df:	6a 00                	push   $0x0
  pushl $113
801063e1:	6a 71                	push   $0x71
  jmp alltraps
801063e3:	e9 67 f7 ff ff       	jmp    80105b4f <alltraps>

801063e8 <vector114>:
.globl vector114
vector114:
  pushl $0
801063e8:	6a 00                	push   $0x0
  pushl $114
801063ea:	6a 72                	push   $0x72
  jmp alltraps
801063ec:	e9 5e f7 ff ff       	jmp    80105b4f <alltraps>

801063f1 <vector115>:
.globl vector115
vector115:
  pushl $0
801063f1:	6a 00                	push   $0x0
  pushl $115
801063f3:	6a 73                	push   $0x73
  jmp alltraps
801063f5:	e9 55 f7 ff ff       	jmp    80105b4f <alltraps>

801063fa <vector116>:
.globl vector116
vector116:
  pushl $0
801063fa:	6a 00                	push   $0x0
  pushl $116
801063fc:	6a 74                	push   $0x74
  jmp alltraps
801063fe:	e9 4c f7 ff ff       	jmp    80105b4f <alltraps>

80106403 <vector117>:
.globl vector117
vector117:
  pushl $0
80106403:	6a 00                	push   $0x0
  pushl $117
80106405:	6a 75                	push   $0x75
  jmp alltraps
80106407:	e9 43 f7 ff ff       	jmp    80105b4f <alltraps>

8010640c <vector118>:
.globl vector118
vector118:
  pushl $0
8010640c:	6a 00                	push   $0x0
  pushl $118
8010640e:	6a 76                	push   $0x76
  jmp alltraps
80106410:	e9 3a f7 ff ff       	jmp    80105b4f <alltraps>

80106415 <vector119>:
.globl vector119
vector119:
  pushl $0
80106415:	6a 00                	push   $0x0
  pushl $119
80106417:	6a 77                	push   $0x77
  jmp alltraps
80106419:	e9 31 f7 ff ff       	jmp    80105b4f <alltraps>

8010641e <vector120>:
.globl vector120
vector120:
  pushl $0
8010641e:	6a 00                	push   $0x0
  pushl $120
80106420:	6a 78                	push   $0x78
  jmp alltraps
80106422:	e9 28 f7 ff ff       	jmp    80105b4f <alltraps>

80106427 <vector121>:
.globl vector121
vector121:
  pushl $0
80106427:	6a 00                	push   $0x0
  pushl $121
80106429:	6a 79                	push   $0x79
  jmp alltraps
8010642b:	e9 1f f7 ff ff       	jmp    80105b4f <alltraps>

80106430 <vector122>:
.globl vector122
vector122:
  pushl $0
80106430:	6a 00                	push   $0x0
  pushl $122
80106432:	6a 7a                	push   $0x7a
  jmp alltraps
80106434:	e9 16 f7 ff ff       	jmp    80105b4f <alltraps>

80106439 <vector123>:
.globl vector123
vector123:
  pushl $0
80106439:	6a 00                	push   $0x0
  pushl $123
8010643b:	6a 7b                	push   $0x7b
  jmp alltraps
8010643d:	e9 0d f7 ff ff       	jmp    80105b4f <alltraps>

80106442 <vector124>:
.globl vector124
vector124:
  pushl $0
80106442:	6a 00                	push   $0x0
  pushl $124
80106444:	6a 7c                	push   $0x7c
  jmp alltraps
80106446:	e9 04 f7 ff ff       	jmp    80105b4f <alltraps>

8010644b <vector125>:
.globl vector125
vector125:
  pushl $0
8010644b:	6a 00                	push   $0x0
  pushl $125
8010644d:	6a 7d                	push   $0x7d
  jmp alltraps
8010644f:	e9 fb f6 ff ff       	jmp    80105b4f <alltraps>

80106454 <vector126>:
.globl vector126
vector126:
  pushl $0
80106454:	6a 00                	push   $0x0
  pushl $126
80106456:	6a 7e                	push   $0x7e
  jmp alltraps
80106458:	e9 f2 f6 ff ff       	jmp    80105b4f <alltraps>

8010645d <vector127>:
.globl vector127
vector127:
  pushl $0
8010645d:	6a 00                	push   $0x0
  pushl $127
8010645f:	6a 7f                	push   $0x7f
  jmp alltraps
80106461:	e9 e9 f6 ff ff       	jmp    80105b4f <alltraps>

80106466 <vector128>:
.globl vector128
vector128:
  pushl $0
80106466:	6a 00                	push   $0x0
  pushl $128
80106468:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010646d:	e9 dd f6 ff ff       	jmp    80105b4f <alltraps>

80106472 <vector129>:
.globl vector129
vector129:
  pushl $0
80106472:	6a 00                	push   $0x0
  pushl $129
80106474:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106479:	e9 d1 f6 ff ff       	jmp    80105b4f <alltraps>

8010647e <vector130>:
.globl vector130
vector130:
  pushl $0
8010647e:	6a 00                	push   $0x0
  pushl $130
80106480:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106485:	e9 c5 f6 ff ff       	jmp    80105b4f <alltraps>

8010648a <vector131>:
.globl vector131
vector131:
  pushl $0
8010648a:	6a 00                	push   $0x0
  pushl $131
8010648c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106491:	e9 b9 f6 ff ff       	jmp    80105b4f <alltraps>

80106496 <vector132>:
.globl vector132
vector132:
  pushl $0
80106496:	6a 00                	push   $0x0
  pushl $132
80106498:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010649d:	e9 ad f6 ff ff       	jmp    80105b4f <alltraps>

801064a2 <vector133>:
.globl vector133
vector133:
  pushl $0
801064a2:	6a 00                	push   $0x0
  pushl $133
801064a4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801064a9:	e9 a1 f6 ff ff       	jmp    80105b4f <alltraps>

801064ae <vector134>:
.globl vector134
vector134:
  pushl $0
801064ae:	6a 00                	push   $0x0
  pushl $134
801064b0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801064b5:	e9 95 f6 ff ff       	jmp    80105b4f <alltraps>

801064ba <vector135>:
.globl vector135
vector135:
  pushl $0
801064ba:	6a 00                	push   $0x0
  pushl $135
801064bc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801064c1:	e9 89 f6 ff ff       	jmp    80105b4f <alltraps>

801064c6 <vector136>:
.globl vector136
vector136:
  pushl $0
801064c6:	6a 00                	push   $0x0
  pushl $136
801064c8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801064cd:	e9 7d f6 ff ff       	jmp    80105b4f <alltraps>

801064d2 <vector137>:
.globl vector137
vector137:
  pushl $0
801064d2:	6a 00                	push   $0x0
  pushl $137
801064d4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801064d9:	e9 71 f6 ff ff       	jmp    80105b4f <alltraps>

801064de <vector138>:
.globl vector138
vector138:
  pushl $0
801064de:	6a 00                	push   $0x0
  pushl $138
801064e0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801064e5:	e9 65 f6 ff ff       	jmp    80105b4f <alltraps>

801064ea <vector139>:
.globl vector139
vector139:
  pushl $0
801064ea:	6a 00                	push   $0x0
  pushl $139
801064ec:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801064f1:	e9 59 f6 ff ff       	jmp    80105b4f <alltraps>

801064f6 <vector140>:
.globl vector140
vector140:
  pushl $0
801064f6:	6a 00                	push   $0x0
  pushl $140
801064f8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801064fd:	e9 4d f6 ff ff       	jmp    80105b4f <alltraps>

80106502 <vector141>:
.globl vector141
vector141:
  pushl $0
80106502:	6a 00                	push   $0x0
  pushl $141
80106504:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106509:	e9 41 f6 ff ff       	jmp    80105b4f <alltraps>

8010650e <vector142>:
.globl vector142
vector142:
  pushl $0
8010650e:	6a 00                	push   $0x0
  pushl $142
80106510:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106515:	e9 35 f6 ff ff       	jmp    80105b4f <alltraps>

8010651a <vector143>:
.globl vector143
vector143:
  pushl $0
8010651a:	6a 00                	push   $0x0
  pushl $143
8010651c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106521:	e9 29 f6 ff ff       	jmp    80105b4f <alltraps>

80106526 <vector144>:
.globl vector144
vector144:
  pushl $0
80106526:	6a 00                	push   $0x0
  pushl $144
80106528:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010652d:	e9 1d f6 ff ff       	jmp    80105b4f <alltraps>

80106532 <vector145>:
.globl vector145
vector145:
  pushl $0
80106532:	6a 00                	push   $0x0
  pushl $145
80106534:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106539:	e9 11 f6 ff ff       	jmp    80105b4f <alltraps>

8010653e <vector146>:
.globl vector146
vector146:
  pushl $0
8010653e:	6a 00                	push   $0x0
  pushl $146
80106540:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106545:	e9 05 f6 ff ff       	jmp    80105b4f <alltraps>

8010654a <vector147>:
.globl vector147
vector147:
  pushl $0
8010654a:	6a 00                	push   $0x0
  pushl $147
8010654c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106551:	e9 f9 f5 ff ff       	jmp    80105b4f <alltraps>

80106556 <vector148>:
.globl vector148
vector148:
  pushl $0
80106556:	6a 00                	push   $0x0
  pushl $148
80106558:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010655d:	e9 ed f5 ff ff       	jmp    80105b4f <alltraps>

80106562 <vector149>:
.globl vector149
vector149:
  pushl $0
80106562:	6a 00                	push   $0x0
  pushl $149
80106564:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106569:	e9 e1 f5 ff ff       	jmp    80105b4f <alltraps>

8010656e <vector150>:
.globl vector150
vector150:
  pushl $0
8010656e:	6a 00                	push   $0x0
  pushl $150
80106570:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106575:	e9 d5 f5 ff ff       	jmp    80105b4f <alltraps>

8010657a <vector151>:
.globl vector151
vector151:
  pushl $0
8010657a:	6a 00                	push   $0x0
  pushl $151
8010657c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106581:	e9 c9 f5 ff ff       	jmp    80105b4f <alltraps>

80106586 <vector152>:
.globl vector152
vector152:
  pushl $0
80106586:	6a 00                	push   $0x0
  pushl $152
80106588:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010658d:	e9 bd f5 ff ff       	jmp    80105b4f <alltraps>

80106592 <vector153>:
.globl vector153
vector153:
  pushl $0
80106592:	6a 00                	push   $0x0
  pushl $153
80106594:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106599:	e9 b1 f5 ff ff       	jmp    80105b4f <alltraps>

8010659e <vector154>:
.globl vector154
vector154:
  pushl $0
8010659e:	6a 00                	push   $0x0
  pushl $154
801065a0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801065a5:	e9 a5 f5 ff ff       	jmp    80105b4f <alltraps>

801065aa <vector155>:
.globl vector155
vector155:
  pushl $0
801065aa:	6a 00                	push   $0x0
  pushl $155
801065ac:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801065b1:	e9 99 f5 ff ff       	jmp    80105b4f <alltraps>

801065b6 <vector156>:
.globl vector156
vector156:
  pushl $0
801065b6:	6a 00                	push   $0x0
  pushl $156
801065b8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801065bd:	e9 8d f5 ff ff       	jmp    80105b4f <alltraps>

801065c2 <vector157>:
.globl vector157
vector157:
  pushl $0
801065c2:	6a 00                	push   $0x0
  pushl $157
801065c4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801065c9:	e9 81 f5 ff ff       	jmp    80105b4f <alltraps>

801065ce <vector158>:
.globl vector158
vector158:
  pushl $0
801065ce:	6a 00                	push   $0x0
  pushl $158
801065d0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801065d5:	e9 75 f5 ff ff       	jmp    80105b4f <alltraps>

801065da <vector159>:
.globl vector159
vector159:
  pushl $0
801065da:	6a 00                	push   $0x0
  pushl $159
801065dc:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801065e1:	e9 69 f5 ff ff       	jmp    80105b4f <alltraps>

801065e6 <vector160>:
.globl vector160
vector160:
  pushl $0
801065e6:	6a 00                	push   $0x0
  pushl $160
801065e8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801065ed:	e9 5d f5 ff ff       	jmp    80105b4f <alltraps>

801065f2 <vector161>:
.globl vector161
vector161:
  pushl $0
801065f2:	6a 00                	push   $0x0
  pushl $161
801065f4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801065f9:	e9 51 f5 ff ff       	jmp    80105b4f <alltraps>

801065fe <vector162>:
.globl vector162
vector162:
  pushl $0
801065fe:	6a 00                	push   $0x0
  pushl $162
80106600:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106605:	e9 45 f5 ff ff       	jmp    80105b4f <alltraps>

8010660a <vector163>:
.globl vector163
vector163:
  pushl $0
8010660a:	6a 00                	push   $0x0
  pushl $163
8010660c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106611:	e9 39 f5 ff ff       	jmp    80105b4f <alltraps>

80106616 <vector164>:
.globl vector164
vector164:
  pushl $0
80106616:	6a 00                	push   $0x0
  pushl $164
80106618:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010661d:	e9 2d f5 ff ff       	jmp    80105b4f <alltraps>

80106622 <vector165>:
.globl vector165
vector165:
  pushl $0
80106622:	6a 00                	push   $0x0
  pushl $165
80106624:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106629:	e9 21 f5 ff ff       	jmp    80105b4f <alltraps>

8010662e <vector166>:
.globl vector166
vector166:
  pushl $0
8010662e:	6a 00                	push   $0x0
  pushl $166
80106630:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106635:	e9 15 f5 ff ff       	jmp    80105b4f <alltraps>

8010663a <vector167>:
.globl vector167
vector167:
  pushl $0
8010663a:	6a 00                	push   $0x0
  pushl $167
8010663c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106641:	e9 09 f5 ff ff       	jmp    80105b4f <alltraps>

80106646 <vector168>:
.globl vector168
vector168:
  pushl $0
80106646:	6a 00                	push   $0x0
  pushl $168
80106648:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010664d:	e9 fd f4 ff ff       	jmp    80105b4f <alltraps>

80106652 <vector169>:
.globl vector169
vector169:
  pushl $0
80106652:	6a 00                	push   $0x0
  pushl $169
80106654:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106659:	e9 f1 f4 ff ff       	jmp    80105b4f <alltraps>

8010665e <vector170>:
.globl vector170
vector170:
  pushl $0
8010665e:	6a 00                	push   $0x0
  pushl $170
80106660:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106665:	e9 e5 f4 ff ff       	jmp    80105b4f <alltraps>

8010666a <vector171>:
.globl vector171
vector171:
  pushl $0
8010666a:	6a 00                	push   $0x0
  pushl $171
8010666c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106671:	e9 d9 f4 ff ff       	jmp    80105b4f <alltraps>

80106676 <vector172>:
.globl vector172
vector172:
  pushl $0
80106676:	6a 00                	push   $0x0
  pushl $172
80106678:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010667d:	e9 cd f4 ff ff       	jmp    80105b4f <alltraps>

80106682 <vector173>:
.globl vector173
vector173:
  pushl $0
80106682:	6a 00                	push   $0x0
  pushl $173
80106684:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106689:	e9 c1 f4 ff ff       	jmp    80105b4f <alltraps>

8010668e <vector174>:
.globl vector174
vector174:
  pushl $0
8010668e:	6a 00                	push   $0x0
  pushl $174
80106690:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106695:	e9 b5 f4 ff ff       	jmp    80105b4f <alltraps>

8010669a <vector175>:
.globl vector175
vector175:
  pushl $0
8010669a:	6a 00                	push   $0x0
  pushl $175
8010669c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801066a1:	e9 a9 f4 ff ff       	jmp    80105b4f <alltraps>

801066a6 <vector176>:
.globl vector176
vector176:
  pushl $0
801066a6:	6a 00                	push   $0x0
  pushl $176
801066a8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801066ad:	e9 9d f4 ff ff       	jmp    80105b4f <alltraps>

801066b2 <vector177>:
.globl vector177
vector177:
  pushl $0
801066b2:	6a 00                	push   $0x0
  pushl $177
801066b4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801066b9:	e9 91 f4 ff ff       	jmp    80105b4f <alltraps>

801066be <vector178>:
.globl vector178
vector178:
  pushl $0
801066be:	6a 00                	push   $0x0
  pushl $178
801066c0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801066c5:	e9 85 f4 ff ff       	jmp    80105b4f <alltraps>

801066ca <vector179>:
.globl vector179
vector179:
  pushl $0
801066ca:	6a 00                	push   $0x0
  pushl $179
801066cc:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801066d1:	e9 79 f4 ff ff       	jmp    80105b4f <alltraps>

801066d6 <vector180>:
.globl vector180
vector180:
  pushl $0
801066d6:	6a 00                	push   $0x0
  pushl $180
801066d8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801066dd:	e9 6d f4 ff ff       	jmp    80105b4f <alltraps>

801066e2 <vector181>:
.globl vector181
vector181:
  pushl $0
801066e2:	6a 00                	push   $0x0
  pushl $181
801066e4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801066e9:	e9 61 f4 ff ff       	jmp    80105b4f <alltraps>

801066ee <vector182>:
.globl vector182
vector182:
  pushl $0
801066ee:	6a 00                	push   $0x0
  pushl $182
801066f0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801066f5:	e9 55 f4 ff ff       	jmp    80105b4f <alltraps>

801066fa <vector183>:
.globl vector183
vector183:
  pushl $0
801066fa:	6a 00                	push   $0x0
  pushl $183
801066fc:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106701:	e9 49 f4 ff ff       	jmp    80105b4f <alltraps>

80106706 <vector184>:
.globl vector184
vector184:
  pushl $0
80106706:	6a 00                	push   $0x0
  pushl $184
80106708:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010670d:	e9 3d f4 ff ff       	jmp    80105b4f <alltraps>

80106712 <vector185>:
.globl vector185
vector185:
  pushl $0
80106712:	6a 00                	push   $0x0
  pushl $185
80106714:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106719:	e9 31 f4 ff ff       	jmp    80105b4f <alltraps>

8010671e <vector186>:
.globl vector186
vector186:
  pushl $0
8010671e:	6a 00                	push   $0x0
  pushl $186
80106720:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106725:	e9 25 f4 ff ff       	jmp    80105b4f <alltraps>

8010672a <vector187>:
.globl vector187
vector187:
  pushl $0
8010672a:	6a 00                	push   $0x0
  pushl $187
8010672c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106731:	e9 19 f4 ff ff       	jmp    80105b4f <alltraps>

80106736 <vector188>:
.globl vector188
vector188:
  pushl $0
80106736:	6a 00                	push   $0x0
  pushl $188
80106738:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010673d:	e9 0d f4 ff ff       	jmp    80105b4f <alltraps>

80106742 <vector189>:
.globl vector189
vector189:
  pushl $0
80106742:	6a 00                	push   $0x0
  pushl $189
80106744:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106749:	e9 01 f4 ff ff       	jmp    80105b4f <alltraps>

8010674e <vector190>:
.globl vector190
vector190:
  pushl $0
8010674e:	6a 00                	push   $0x0
  pushl $190
80106750:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106755:	e9 f5 f3 ff ff       	jmp    80105b4f <alltraps>

8010675a <vector191>:
.globl vector191
vector191:
  pushl $0
8010675a:	6a 00                	push   $0x0
  pushl $191
8010675c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106761:	e9 e9 f3 ff ff       	jmp    80105b4f <alltraps>

80106766 <vector192>:
.globl vector192
vector192:
  pushl $0
80106766:	6a 00                	push   $0x0
  pushl $192
80106768:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010676d:	e9 dd f3 ff ff       	jmp    80105b4f <alltraps>

80106772 <vector193>:
.globl vector193
vector193:
  pushl $0
80106772:	6a 00                	push   $0x0
  pushl $193
80106774:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106779:	e9 d1 f3 ff ff       	jmp    80105b4f <alltraps>

8010677e <vector194>:
.globl vector194
vector194:
  pushl $0
8010677e:	6a 00                	push   $0x0
  pushl $194
80106780:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106785:	e9 c5 f3 ff ff       	jmp    80105b4f <alltraps>

8010678a <vector195>:
.globl vector195
vector195:
  pushl $0
8010678a:	6a 00                	push   $0x0
  pushl $195
8010678c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106791:	e9 b9 f3 ff ff       	jmp    80105b4f <alltraps>

80106796 <vector196>:
.globl vector196
vector196:
  pushl $0
80106796:	6a 00                	push   $0x0
  pushl $196
80106798:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010679d:	e9 ad f3 ff ff       	jmp    80105b4f <alltraps>

801067a2 <vector197>:
.globl vector197
vector197:
  pushl $0
801067a2:	6a 00                	push   $0x0
  pushl $197
801067a4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801067a9:	e9 a1 f3 ff ff       	jmp    80105b4f <alltraps>

801067ae <vector198>:
.globl vector198
vector198:
  pushl $0
801067ae:	6a 00                	push   $0x0
  pushl $198
801067b0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801067b5:	e9 95 f3 ff ff       	jmp    80105b4f <alltraps>

801067ba <vector199>:
.globl vector199
vector199:
  pushl $0
801067ba:	6a 00                	push   $0x0
  pushl $199
801067bc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801067c1:	e9 89 f3 ff ff       	jmp    80105b4f <alltraps>

801067c6 <vector200>:
.globl vector200
vector200:
  pushl $0
801067c6:	6a 00                	push   $0x0
  pushl $200
801067c8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801067cd:	e9 7d f3 ff ff       	jmp    80105b4f <alltraps>

801067d2 <vector201>:
.globl vector201
vector201:
  pushl $0
801067d2:	6a 00                	push   $0x0
  pushl $201
801067d4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801067d9:	e9 71 f3 ff ff       	jmp    80105b4f <alltraps>

801067de <vector202>:
.globl vector202
vector202:
  pushl $0
801067de:	6a 00                	push   $0x0
  pushl $202
801067e0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801067e5:	e9 65 f3 ff ff       	jmp    80105b4f <alltraps>

801067ea <vector203>:
.globl vector203
vector203:
  pushl $0
801067ea:	6a 00                	push   $0x0
  pushl $203
801067ec:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801067f1:	e9 59 f3 ff ff       	jmp    80105b4f <alltraps>

801067f6 <vector204>:
.globl vector204
vector204:
  pushl $0
801067f6:	6a 00                	push   $0x0
  pushl $204
801067f8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801067fd:	e9 4d f3 ff ff       	jmp    80105b4f <alltraps>

80106802 <vector205>:
.globl vector205
vector205:
  pushl $0
80106802:	6a 00                	push   $0x0
  pushl $205
80106804:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106809:	e9 41 f3 ff ff       	jmp    80105b4f <alltraps>

8010680e <vector206>:
.globl vector206
vector206:
  pushl $0
8010680e:	6a 00                	push   $0x0
  pushl $206
80106810:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106815:	e9 35 f3 ff ff       	jmp    80105b4f <alltraps>

8010681a <vector207>:
.globl vector207
vector207:
  pushl $0
8010681a:	6a 00                	push   $0x0
  pushl $207
8010681c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106821:	e9 29 f3 ff ff       	jmp    80105b4f <alltraps>

80106826 <vector208>:
.globl vector208
vector208:
  pushl $0
80106826:	6a 00                	push   $0x0
  pushl $208
80106828:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010682d:	e9 1d f3 ff ff       	jmp    80105b4f <alltraps>

80106832 <vector209>:
.globl vector209
vector209:
  pushl $0
80106832:	6a 00                	push   $0x0
  pushl $209
80106834:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106839:	e9 11 f3 ff ff       	jmp    80105b4f <alltraps>

8010683e <vector210>:
.globl vector210
vector210:
  pushl $0
8010683e:	6a 00                	push   $0x0
  pushl $210
80106840:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106845:	e9 05 f3 ff ff       	jmp    80105b4f <alltraps>

8010684a <vector211>:
.globl vector211
vector211:
  pushl $0
8010684a:	6a 00                	push   $0x0
  pushl $211
8010684c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106851:	e9 f9 f2 ff ff       	jmp    80105b4f <alltraps>

80106856 <vector212>:
.globl vector212
vector212:
  pushl $0
80106856:	6a 00                	push   $0x0
  pushl $212
80106858:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010685d:	e9 ed f2 ff ff       	jmp    80105b4f <alltraps>

80106862 <vector213>:
.globl vector213
vector213:
  pushl $0
80106862:	6a 00                	push   $0x0
  pushl $213
80106864:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106869:	e9 e1 f2 ff ff       	jmp    80105b4f <alltraps>

8010686e <vector214>:
.globl vector214
vector214:
  pushl $0
8010686e:	6a 00                	push   $0x0
  pushl $214
80106870:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106875:	e9 d5 f2 ff ff       	jmp    80105b4f <alltraps>

8010687a <vector215>:
.globl vector215
vector215:
  pushl $0
8010687a:	6a 00                	push   $0x0
  pushl $215
8010687c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106881:	e9 c9 f2 ff ff       	jmp    80105b4f <alltraps>

80106886 <vector216>:
.globl vector216
vector216:
  pushl $0
80106886:	6a 00                	push   $0x0
  pushl $216
80106888:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010688d:	e9 bd f2 ff ff       	jmp    80105b4f <alltraps>

80106892 <vector217>:
.globl vector217
vector217:
  pushl $0
80106892:	6a 00                	push   $0x0
  pushl $217
80106894:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106899:	e9 b1 f2 ff ff       	jmp    80105b4f <alltraps>

8010689e <vector218>:
.globl vector218
vector218:
  pushl $0
8010689e:	6a 00                	push   $0x0
  pushl $218
801068a0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801068a5:	e9 a5 f2 ff ff       	jmp    80105b4f <alltraps>

801068aa <vector219>:
.globl vector219
vector219:
  pushl $0
801068aa:	6a 00                	push   $0x0
  pushl $219
801068ac:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801068b1:	e9 99 f2 ff ff       	jmp    80105b4f <alltraps>

801068b6 <vector220>:
.globl vector220
vector220:
  pushl $0
801068b6:	6a 00                	push   $0x0
  pushl $220
801068b8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801068bd:	e9 8d f2 ff ff       	jmp    80105b4f <alltraps>

801068c2 <vector221>:
.globl vector221
vector221:
  pushl $0
801068c2:	6a 00                	push   $0x0
  pushl $221
801068c4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801068c9:	e9 81 f2 ff ff       	jmp    80105b4f <alltraps>

801068ce <vector222>:
.globl vector222
vector222:
  pushl $0
801068ce:	6a 00                	push   $0x0
  pushl $222
801068d0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801068d5:	e9 75 f2 ff ff       	jmp    80105b4f <alltraps>

801068da <vector223>:
.globl vector223
vector223:
  pushl $0
801068da:	6a 00                	push   $0x0
  pushl $223
801068dc:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801068e1:	e9 69 f2 ff ff       	jmp    80105b4f <alltraps>

801068e6 <vector224>:
.globl vector224
vector224:
  pushl $0
801068e6:	6a 00                	push   $0x0
  pushl $224
801068e8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801068ed:	e9 5d f2 ff ff       	jmp    80105b4f <alltraps>

801068f2 <vector225>:
.globl vector225
vector225:
  pushl $0
801068f2:	6a 00                	push   $0x0
  pushl $225
801068f4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801068f9:	e9 51 f2 ff ff       	jmp    80105b4f <alltraps>

801068fe <vector226>:
.globl vector226
vector226:
  pushl $0
801068fe:	6a 00                	push   $0x0
  pushl $226
80106900:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106905:	e9 45 f2 ff ff       	jmp    80105b4f <alltraps>

8010690a <vector227>:
.globl vector227
vector227:
  pushl $0
8010690a:	6a 00                	push   $0x0
  pushl $227
8010690c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106911:	e9 39 f2 ff ff       	jmp    80105b4f <alltraps>

80106916 <vector228>:
.globl vector228
vector228:
  pushl $0
80106916:	6a 00                	push   $0x0
  pushl $228
80106918:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010691d:	e9 2d f2 ff ff       	jmp    80105b4f <alltraps>

80106922 <vector229>:
.globl vector229
vector229:
  pushl $0
80106922:	6a 00                	push   $0x0
  pushl $229
80106924:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106929:	e9 21 f2 ff ff       	jmp    80105b4f <alltraps>

8010692e <vector230>:
.globl vector230
vector230:
  pushl $0
8010692e:	6a 00                	push   $0x0
  pushl $230
80106930:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106935:	e9 15 f2 ff ff       	jmp    80105b4f <alltraps>

8010693a <vector231>:
.globl vector231
vector231:
  pushl $0
8010693a:	6a 00                	push   $0x0
  pushl $231
8010693c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106941:	e9 09 f2 ff ff       	jmp    80105b4f <alltraps>

80106946 <vector232>:
.globl vector232
vector232:
  pushl $0
80106946:	6a 00                	push   $0x0
  pushl $232
80106948:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010694d:	e9 fd f1 ff ff       	jmp    80105b4f <alltraps>

80106952 <vector233>:
.globl vector233
vector233:
  pushl $0
80106952:	6a 00                	push   $0x0
  pushl $233
80106954:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106959:	e9 f1 f1 ff ff       	jmp    80105b4f <alltraps>

8010695e <vector234>:
.globl vector234
vector234:
  pushl $0
8010695e:	6a 00                	push   $0x0
  pushl $234
80106960:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106965:	e9 e5 f1 ff ff       	jmp    80105b4f <alltraps>

8010696a <vector235>:
.globl vector235
vector235:
  pushl $0
8010696a:	6a 00                	push   $0x0
  pushl $235
8010696c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106971:	e9 d9 f1 ff ff       	jmp    80105b4f <alltraps>

80106976 <vector236>:
.globl vector236
vector236:
  pushl $0
80106976:	6a 00                	push   $0x0
  pushl $236
80106978:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010697d:	e9 cd f1 ff ff       	jmp    80105b4f <alltraps>

80106982 <vector237>:
.globl vector237
vector237:
  pushl $0
80106982:	6a 00                	push   $0x0
  pushl $237
80106984:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106989:	e9 c1 f1 ff ff       	jmp    80105b4f <alltraps>

8010698e <vector238>:
.globl vector238
vector238:
  pushl $0
8010698e:	6a 00                	push   $0x0
  pushl $238
80106990:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106995:	e9 b5 f1 ff ff       	jmp    80105b4f <alltraps>

8010699a <vector239>:
.globl vector239
vector239:
  pushl $0
8010699a:	6a 00                	push   $0x0
  pushl $239
8010699c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801069a1:	e9 a9 f1 ff ff       	jmp    80105b4f <alltraps>

801069a6 <vector240>:
.globl vector240
vector240:
  pushl $0
801069a6:	6a 00                	push   $0x0
  pushl $240
801069a8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801069ad:	e9 9d f1 ff ff       	jmp    80105b4f <alltraps>

801069b2 <vector241>:
.globl vector241
vector241:
  pushl $0
801069b2:	6a 00                	push   $0x0
  pushl $241
801069b4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801069b9:	e9 91 f1 ff ff       	jmp    80105b4f <alltraps>

801069be <vector242>:
.globl vector242
vector242:
  pushl $0
801069be:	6a 00                	push   $0x0
  pushl $242
801069c0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801069c5:	e9 85 f1 ff ff       	jmp    80105b4f <alltraps>

801069ca <vector243>:
.globl vector243
vector243:
  pushl $0
801069ca:	6a 00                	push   $0x0
  pushl $243
801069cc:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801069d1:	e9 79 f1 ff ff       	jmp    80105b4f <alltraps>

801069d6 <vector244>:
.globl vector244
vector244:
  pushl $0
801069d6:	6a 00                	push   $0x0
  pushl $244
801069d8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801069dd:	e9 6d f1 ff ff       	jmp    80105b4f <alltraps>

801069e2 <vector245>:
.globl vector245
vector245:
  pushl $0
801069e2:	6a 00                	push   $0x0
  pushl $245
801069e4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801069e9:	e9 61 f1 ff ff       	jmp    80105b4f <alltraps>

801069ee <vector246>:
.globl vector246
vector246:
  pushl $0
801069ee:	6a 00                	push   $0x0
  pushl $246
801069f0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801069f5:	e9 55 f1 ff ff       	jmp    80105b4f <alltraps>

801069fa <vector247>:
.globl vector247
vector247:
  pushl $0
801069fa:	6a 00                	push   $0x0
  pushl $247
801069fc:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106a01:	e9 49 f1 ff ff       	jmp    80105b4f <alltraps>

80106a06 <vector248>:
.globl vector248
vector248:
  pushl $0
80106a06:	6a 00                	push   $0x0
  pushl $248
80106a08:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106a0d:	e9 3d f1 ff ff       	jmp    80105b4f <alltraps>

80106a12 <vector249>:
.globl vector249
vector249:
  pushl $0
80106a12:	6a 00                	push   $0x0
  pushl $249
80106a14:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106a19:	e9 31 f1 ff ff       	jmp    80105b4f <alltraps>

80106a1e <vector250>:
.globl vector250
vector250:
  pushl $0
80106a1e:	6a 00                	push   $0x0
  pushl $250
80106a20:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106a25:	e9 25 f1 ff ff       	jmp    80105b4f <alltraps>

80106a2a <vector251>:
.globl vector251
vector251:
  pushl $0
80106a2a:	6a 00                	push   $0x0
  pushl $251
80106a2c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106a31:	e9 19 f1 ff ff       	jmp    80105b4f <alltraps>

80106a36 <vector252>:
.globl vector252
vector252:
  pushl $0
80106a36:	6a 00                	push   $0x0
  pushl $252
80106a38:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106a3d:	e9 0d f1 ff ff       	jmp    80105b4f <alltraps>

80106a42 <vector253>:
.globl vector253
vector253:
  pushl $0
80106a42:	6a 00                	push   $0x0
  pushl $253
80106a44:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106a49:	e9 01 f1 ff ff       	jmp    80105b4f <alltraps>

80106a4e <vector254>:
.globl vector254
vector254:
  pushl $0
80106a4e:	6a 00                	push   $0x0
  pushl $254
80106a50:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106a55:	e9 f5 f0 ff ff       	jmp    80105b4f <alltraps>

80106a5a <vector255>:
.globl vector255
vector255:
  pushl $0
80106a5a:	6a 00                	push   $0x0
  pushl $255
80106a5c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106a61:	e9 e9 f0 ff ff       	jmp    80105b4f <alltraps>
80106a66:	66 90                	xchg   %ax,%ax
80106a68:	66 90                	xchg   %ax,%ax
80106a6a:	66 90                	xchg   %ax,%ax
80106a6c:	66 90                	xchg   %ax,%ax
80106a6e:	66 90                	xchg   %ax,%ax

80106a70 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106a70:	55                   	push   %ebp
80106a71:	89 e5                	mov    %esp,%ebp
80106a73:	57                   	push   %edi
80106a74:	56                   	push   %esi
80106a75:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106a77:	c1 ea 16             	shr    $0x16,%edx
{
80106a7a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
80106a7b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
80106a7e:	83 ec 1c             	sub    $0x1c,%esp
  if(*pde & PTE_P){
80106a81:	8b 1f                	mov    (%edi),%ebx
80106a83:	f6 c3 01             	test   $0x1,%bl
80106a86:	74 28                	je     80106ab0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106a88:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106a8e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106a94:	c1 ee 0a             	shr    $0xa,%esi
}
80106a97:	83 c4 1c             	add    $0x1c,%esp
  return &pgtab[PTX(va)];
80106a9a:	89 f2                	mov    %esi,%edx
80106a9c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106aa2:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106aa5:	5b                   	pop    %ebx
80106aa6:	5e                   	pop    %esi
80106aa7:	5f                   	pop    %edi
80106aa8:	5d                   	pop    %ebp
80106aa9:	c3                   	ret    
80106aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106ab0:	85 c9                	test   %ecx,%ecx
80106ab2:	74 34                	je     80106ae8 <walkpgdir+0x78>
80106ab4:	e8 17 ba ff ff       	call   801024d0 <kalloc>
80106ab9:	85 c0                	test   %eax,%eax
80106abb:	89 c3                	mov    %eax,%ebx
80106abd:	74 29                	je     80106ae8 <walkpgdir+0x78>
    memset(pgtab, 0, PGSIZE);
80106abf:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106ac6:	00 
80106ac7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106ace:	00 
80106acf:	89 04 24             	mov    %eax,(%esp)
80106ad2:	e8 d9 dd ff ff       	call   801048b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106ad7:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106add:	83 c8 07             	or     $0x7,%eax
80106ae0:	89 07                	mov    %eax,(%edi)
80106ae2:	eb b0                	jmp    80106a94 <walkpgdir+0x24>
80106ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
}
80106ae8:	83 c4 1c             	add    $0x1c,%esp
      return 0;
80106aeb:	31 c0                	xor    %eax,%eax
}
80106aed:	5b                   	pop    %ebx
80106aee:	5e                   	pop    %esi
80106aef:	5f                   	pop    %edi
80106af0:	5d                   	pop    %ebp
80106af1:	c3                   	ret    
80106af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106b00 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	57                   	push   %edi
80106b04:	56                   	push   %esi
80106b05:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106b06:	89 d3                	mov    %edx,%ebx
{
80106b08:	83 ec 1c             	sub    $0x1c,%esp
80106b0b:	8b 7d 08             	mov    0x8(%ebp),%edi
  a = (char*)PGROUNDDOWN((uint)va);
80106b0e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106b14:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106b17:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106b1b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106b1e:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106b22:	81 65 e4 00 f0 ff ff 	andl   $0xfffff000,-0x1c(%ebp)
80106b29:	29 df                	sub    %ebx,%edi
80106b2b:	eb 18                	jmp    80106b45 <mappages+0x45>
80106b2d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*pte & PTE_P)
80106b30:	f6 00 01             	testb  $0x1,(%eax)
80106b33:	75 3d                	jne    80106b72 <mappages+0x72>
    *pte = pa | perm | PTE_P;
80106b35:	0b 75 0c             	or     0xc(%ebp),%esi
    if(a == last)
80106b38:	3b 5d e4             	cmp    -0x1c(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106b3b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106b3d:	74 29                	je     80106b68 <mappages+0x68>
      break;
    a += PGSIZE;
80106b3f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106b45:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b48:	b9 01 00 00 00       	mov    $0x1,%ecx
80106b4d:	89 da                	mov    %ebx,%edx
80106b4f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106b52:	e8 19 ff ff ff       	call   80106a70 <walkpgdir>
80106b57:	85 c0                	test   %eax,%eax
80106b59:	75 d5                	jne    80106b30 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106b5b:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80106b5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b63:	5b                   	pop    %ebx
80106b64:	5e                   	pop    %esi
80106b65:	5f                   	pop    %edi
80106b66:	5d                   	pop    %ebp
80106b67:	c3                   	ret    
80106b68:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80106b6b:	31 c0                	xor    %eax,%eax
}
80106b6d:	5b                   	pop    %ebx
80106b6e:	5e                   	pop    %esi
80106b6f:	5f                   	pop    %edi
80106b70:	5d                   	pop    %ebp
80106b71:	c3                   	ret    
      panic("remap");
80106b72:	c7 04 24 38 7d 10 80 	movl   $0x80107d38,(%esp)
80106b79:	e8 e2 97 ff ff       	call   80100360 <panic>
80106b7e:	66 90                	xchg   %ax,%ax

80106b80 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b80:	55                   	push   %ebp
80106b81:	89 e5                	mov    %esp,%ebp
80106b83:	57                   	push   %edi
80106b84:	89 c7                	mov    %eax,%edi
80106b86:	56                   	push   %esi
80106b87:	89 d6                	mov    %edx,%esi
80106b89:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106b8a:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b90:	83 ec 1c             	sub    $0x1c,%esp
  a = PGROUNDUP(newsz);
80106b93:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106b99:	39 d3                	cmp    %edx,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106b9b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106b9e:	72 3b                	jb     80106bdb <deallocuvm.part.0+0x5b>
80106ba0:	eb 5e                	jmp    80106c00 <deallocuvm.part.0+0x80>
80106ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106ba8:	8b 10                	mov    (%eax),%edx
80106baa:	f6 c2 01             	test   $0x1,%dl
80106bad:	74 22                	je     80106bd1 <deallocuvm.part.0+0x51>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106baf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106bb5:	74 54                	je     80106c0b <deallocuvm.part.0+0x8b>
        panic("kfree");
      char *v = P2V(pa);
80106bb7:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106bbd:	89 14 24             	mov    %edx,(%esp)
80106bc0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106bc3:	e8 58 b7 ff ff       	call   80102320 <kfree>
      *pte = 0;
80106bc8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106bcb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80106bd1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bd7:	39 f3                	cmp    %esi,%ebx
80106bd9:	73 25                	jae    80106c00 <deallocuvm.part.0+0x80>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106bdb:	31 c9                	xor    %ecx,%ecx
80106bdd:	89 da                	mov    %ebx,%edx
80106bdf:	89 f8                	mov    %edi,%eax
80106be1:	e8 8a fe ff ff       	call   80106a70 <walkpgdir>
    if(!pte)
80106be6:	85 c0                	test   %eax,%eax
80106be8:	75 be                	jne    80106ba8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106bea:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106bf0:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106bf6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106bfc:	39 f3                	cmp    %esi,%ebx
80106bfe:	72 db                	jb     80106bdb <deallocuvm.part.0+0x5b>
    }
  }
  return newsz;
}
80106c00:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106c03:	83 c4 1c             	add    $0x1c,%esp
80106c06:	5b                   	pop    %ebx
80106c07:	5e                   	pop    %esi
80106c08:	5f                   	pop    %edi
80106c09:	5d                   	pop    %ebp
80106c0a:	c3                   	ret    
        panic("kfree");
80106c0b:	c7 04 24 e6 75 10 80 	movl   $0x801075e6,(%esp)
80106c12:	e8 49 97 ff ff       	call   80100360 <panic>
80106c17:	89 f6                	mov    %esi,%esi
80106c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c20 <seginit>:
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106c26:	e8 c5 ca ff ff       	call   801036f0 <cpuid>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c2b:	31 c9                	xor    %ecx,%ecx
80106c2d:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c = &cpus[cpuid()];
80106c32:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106c38:	05 a0 27 11 80       	add    $0x801127a0,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c3d:	66 89 50 78          	mov    %dx,0x78(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c41:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  lgdt(c->gdt, sizeof(c->gdt));
80106c46:	83 c0 70             	add    $0x70,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c49:	66 89 48 0a          	mov    %cx,0xa(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c4d:	31 c9                	xor    %ecx,%ecx
80106c4f:	66 89 50 10          	mov    %dx,0x10(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c53:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c58:	66 89 48 12          	mov    %cx,0x12(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c5c:	31 c9                	xor    %ecx,%ecx
80106c5e:	66 89 50 18          	mov    %dx,0x18(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c62:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c67:	66 89 48 1a          	mov    %cx,0x1a(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c6b:	31 c9                	xor    %ecx,%ecx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c6d:	c6 40 0d 9a          	movb   $0x9a,0xd(%eax)
80106c71:	c6 40 0e cf          	movb   $0xcf,0xe(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c75:	c6 40 15 92          	movb   $0x92,0x15(%eax)
80106c79:	c6 40 16 cf          	movb   $0xcf,0x16(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c7d:	c6 40 1d fa          	movb   $0xfa,0x1d(%eax)
80106c81:	c6 40 1e cf          	movb   $0xcf,0x1e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c85:	c6 40 25 f2          	movb   $0xf2,0x25(%eax)
80106c89:	c6 40 26 cf          	movb   $0xcf,0x26(%eax)
80106c8d:	66 89 50 20          	mov    %dx,0x20(%eax)
  pd[0] = size-1;
80106c91:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c96:	c6 40 0c 00          	movb   $0x0,0xc(%eax)
80106c9a:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c9e:	c6 40 14 00          	movb   $0x0,0x14(%eax)
80106ca2:	c6 40 17 00          	movb   $0x0,0x17(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106ca6:	c6 40 1c 00          	movb   $0x0,0x1c(%eax)
80106caa:	c6 40 1f 00          	movb   $0x0,0x1f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106cae:	66 89 48 22          	mov    %cx,0x22(%eax)
80106cb2:	c6 40 24 00          	movb   $0x0,0x24(%eax)
80106cb6:	c6 40 27 00          	movb   $0x0,0x27(%eax)
80106cba:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  pd[1] = (uint)p;
80106cbe:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106cc2:	c1 e8 10             	shr    $0x10,%eax
80106cc5:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106cc9:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106ccc:	0f 01 10             	lgdtl  (%eax)
}
80106ccf:	c9                   	leave  
80106cd0:	c3                   	ret    
80106cd1:	eb 0d                	jmp    80106ce0 <switchkvm>
80106cd3:	90                   	nop
80106cd4:	90                   	nop
80106cd5:	90                   	nop
80106cd6:	90                   	nop
80106cd7:	90                   	nop
80106cd8:	90                   	nop
80106cd9:	90                   	nop
80106cda:	90                   	nop
80106cdb:	90                   	nop
80106cdc:	90                   	nop
80106cdd:	90                   	nop
80106cde:	90                   	nop
80106cdf:	90                   	nop

80106ce0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ce0:	a1 c4 59 11 80       	mov    0x801159c4,%eax
{
80106ce5:	55                   	push   %ebp
80106ce6:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ce8:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ced:	0f 22 d8             	mov    %eax,%cr3
}
80106cf0:	5d                   	pop    %ebp
80106cf1:	c3                   	ret    
80106cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <switchuvm>:
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	57                   	push   %edi
80106d04:	56                   	push   %esi
80106d05:	53                   	push   %ebx
80106d06:	83 ec 1c             	sub    $0x1c,%esp
80106d09:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106d0c:	85 f6                	test   %esi,%esi
80106d0e:	0f 84 cd 00 00 00    	je     80106de1 <switchuvm+0xe1>
  if(p->kstack == 0)
80106d14:	8b 46 08             	mov    0x8(%esi),%eax
80106d17:	85 c0                	test   %eax,%eax
80106d19:	0f 84 da 00 00 00    	je     80106df9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106d1f:	8b 7e 04             	mov    0x4(%esi),%edi
80106d22:	85 ff                	test   %edi,%edi
80106d24:	0f 84 c3 00 00 00    	je     80106ded <switchuvm+0xed>
  pushcli();
80106d2a:	e8 d1 d9 ff ff       	call   80104700 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106d2f:	e8 3c c9 ff ff       	call   80103670 <mycpu>
80106d34:	89 c3                	mov    %eax,%ebx
80106d36:	e8 35 c9 ff ff       	call   80103670 <mycpu>
80106d3b:	89 c7                	mov    %eax,%edi
80106d3d:	e8 2e c9 ff ff       	call   80103670 <mycpu>
80106d42:	83 c7 08             	add    $0x8,%edi
80106d45:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d48:	e8 23 c9 ff ff       	call   80103670 <mycpu>
80106d4d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106d50:	ba 67 00 00 00       	mov    $0x67,%edx
80106d55:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106d5c:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106d63:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
80106d6a:	83 c1 08             	add    $0x8,%ecx
80106d6d:	c1 e9 10             	shr    $0x10,%ecx
80106d70:	83 c0 08             	add    $0x8,%eax
80106d73:	c1 e8 18             	shr    $0x18,%eax
80106d76:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106d7c:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
80106d83:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d89:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106d8e:	e8 dd c8 ff ff       	call   80103670 <mycpu>
80106d93:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d9a:	e8 d1 c8 ff ff       	call   80103670 <mycpu>
80106d9f:	b9 10 00 00 00       	mov    $0x10,%ecx
80106da4:	66 89 48 10          	mov    %cx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106da8:	e8 c3 c8 ff ff       	call   80103670 <mycpu>
80106dad:	8b 56 08             	mov    0x8(%esi),%edx
80106db0:	8d 8a 00 10 00 00    	lea    0x1000(%edx),%ecx
80106db6:	89 48 0c             	mov    %ecx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106db9:	e8 b2 c8 ff ff       	call   80103670 <mycpu>
80106dbe:	66 89 58 6e          	mov    %bx,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106dc2:	b8 28 00 00 00       	mov    $0x28,%eax
80106dc7:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106dca:	8b 46 04             	mov    0x4(%esi),%eax
80106dcd:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106dd2:	0f 22 d8             	mov    %eax,%cr3
}
80106dd5:	83 c4 1c             	add    $0x1c,%esp
80106dd8:	5b                   	pop    %ebx
80106dd9:	5e                   	pop    %esi
80106dda:	5f                   	pop    %edi
80106ddb:	5d                   	pop    %ebp
  popcli();
80106ddc:	e9 5f d9 ff ff       	jmp    80104740 <popcli>
    panic("switchuvm: no process");
80106de1:	c7 04 24 3e 7d 10 80 	movl   $0x80107d3e,(%esp)
80106de8:	e8 73 95 ff ff       	call   80100360 <panic>
    panic("switchuvm: no pgdir");
80106ded:	c7 04 24 69 7d 10 80 	movl   $0x80107d69,(%esp)
80106df4:	e8 67 95 ff ff       	call   80100360 <panic>
    panic("switchuvm: no kstack");
80106df9:	c7 04 24 54 7d 10 80 	movl   $0x80107d54,(%esp)
80106e00:	e8 5b 95 ff ff       	call   80100360 <panic>
80106e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e10 <inituvm>:
{
80106e10:	55                   	push   %ebp
80106e11:	89 e5                	mov    %esp,%ebp
80106e13:	57                   	push   %edi
80106e14:	56                   	push   %esi
80106e15:	53                   	push   %ebx
80106e16:	83 ec 1c             	sub    $0x1c,%esp
80106e19:	8b 75 10             	mov    0x10(%ebp),%esi
80106e1c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e1f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80106e22:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80106e28:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106e2b:	77 54                	ja     80106e81 <inituvm+0x71>
  mem = kalloc();
80106e2d:	e8 9e b6 ff ff       	call   801024d0 <kalloc>
  memset(mem, 0, PGSIZE);
80106e32:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106e39:	00 
80106e3a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106e41:	00 
  mem = kalloc();
80106e42:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e44:	89 04 24             	mov    %eax,(%esp)
80106e47:	e8 64 da ff ff       	call   801048b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e4c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e52:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e57:	89 04 24             	mov    %eax,(%esp)
80106e5a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e5d:	31 d2                	xor    %edx,%edx
80106e5f:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106e66:	00 
80106e67:	e8 94 fc ff ff       	call   80106b00 <mappages>
  memmove(mem, init, sz);
80106e6c:	89 75 10             	mov    %esi,0x10(%ebp)
80106e6f:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106e72:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106e75:	83 c4 1c             	add    $0x1c,%esp
80106e78:	5b                   	pop    %ebx
80106e79:	5e                   	pop    %esi
80106e7a:	5f                   	pop    %edi
80106e7b:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106e7c:	e9 cf da ff ff       	jmp    80104950 <memmove>
    panic("inituvm: more than a page");
80106e81:	c7 04 24 7d 7d 10 80 	movl   $0x80107d7d,(%esp)
80106e88:	e8 d3 94 ff ff       	call   80100360 <panic>
80106e8d:	8d 76 00             	lea    0x0(%esi),%esi

80106e90 <loaduvm>:
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	57                   	push   %edi
80106e94:	56                   	push   %esi
80106e95:	53                   	push   %ebx
80106e96:	83 ec 1c             	sub    $0x1c,%esp
  if((uint) addr % PGSIZE != 0)
80106e99:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106ea0:	0f 85 98 00 00 00    	jne    80106f3e <loaduvm+0xae>
  for(i = 0; i < sz; i += PGSIZE){
80106ea6:	8b 75 18             	mov    0x18(%ebp),%esi
80106ea9:	31 db                	xor    %ebx,%ebx
80106eab:	85 f6                	test   %esi,%esi
80106ead:	75 1a                	jne    80106ec9 <loaduvm+0x39>
80106eaf:	eb 77                	jmp    80106f28 <loaduvm+0x98>
80106eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106eb8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ebe:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106ec4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106ec7:	76 5f                	jbe    80106f28 <loaduvm+0x98>
80106ec9:	8b 55 0c             	mov    0xc(%ebp),%edx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106ecc:	31 c9                	xor    %ecx,%ecx
80106ece:	8b 45 08             	mov    0x8(%ebp),%eax
80106ed1:	01 da                	add    %ebx,%edx
80106ed3:	e8 98 fb ff ff       	call   80106a70 <walkpgdir>
80106ed8:	85 c0                	test   %eax,%eax
80106eda:	74 56                	je     80106f32 <loaduvm+0xa2>
    pa = PTE_ADDR(*pte);
80106edc:	8b 00                	mov    (%eax),%eax
      n = PGSIZE;
80106ede:	bf 00 10 00 00       	mov    $0x1000,%edi
80106ee3:	8b 4d 14             	mov    0x14(%ebp),%ecx
    pa = PTE_ADDR(*pte);
80106ee6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      n = PGSIZE;
80106eeb:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
80106ef1:	0f 42 fe             	cmovb  %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ef4:	05 00 00 00 80       	add    $0x80000000,%eax
80106ef9:	89 44 24 04          	mov    %eax,0x4(%esp)
80106efd:	8b 45 10             	mov    0x10(%ebp),%eax
80106f00:	01 d9                	add    %ebx,%ecx
80106f02:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80106f06:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80106f0a:	89 04 24             	mov    %eax,(%esp)
80106f0d:	e8 7e aa ff ff       	call   80101990 <readi>
80106f12:	39 f8                	cmp    %edi,%eax
80106f14:	74 a2                	je     80106eb8 <loaduvm+0x28>
}
80106f16:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80106f19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106f1e:	5b                   	pop    %ebx
80106f1f:	5e                   	pop    %esi
80106f20:	5f                   	pop    %edi
80106f21:	5d                   	pop    %ebp
80106f22:	c3                   	ret    
80106f23:	90                   	nop
80106f24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f28:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80106f2b:	31 c0                	xor    %eax,%eax
}
80106f2d:	5b                   	pop    %ebx
80106f2e:	5e                   	pop    %esi
80106f2f:	5f                   	pop    %edi
80106f30:	5d                   	pop    %ebp
80106f31:	c3                   	ret    
      panic("loaduvm: address should exist");
80106f32:	c7 04 24 97 7d 10 80 	movl   $0x80107d97,(%esp)
80106f39:	e8 22 94 ff ff       	call   80100360 <panic>
    panic("loaduvm: addr must be page aligned");
80106f3e:	c7 04 24 38 7e 10 80 	movl   $0x80107e38,(%esp)
80106f45:	e8 16 94 ff ff       	call   80100360 <panic>
80106f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f50 <allocuvm>:
{
80106f50:	55                   	push   %ebp
80106f51:	89 e5                	mov    %esp,%ebp
80106f53:	57                   	push   %edi
80106f54:	56                   	push   %esi
80106f55:	53                   	push   %ebx
80106f56:	83 ec 1c             	sub    $0x1c,%esp
80106f59:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(newsz >= KERNBASE)
80106f5c:	85 ff                	test   %edi,%edi
80106f5e:	0f 88 7e 00 00 00    	js     80106fe2 <allocuvm+0x92>
  if(newsz < oldsz)
80106f64:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106f67:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80106f6a:	72 78                	jb     80106fe4 <allocuvm+0x94>
  a = PGROUNDUP(oldsz);
80106f6c:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106f72:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106f78:	39 df                	cmp    %ebx,%edi
80106f7a:	77 4a                	ja     80106fc6 <allocuvm+0x76>
80106f7c:	eb 72                	jmp    80106ff0 <allocuvm+0xa0>
80106f7e:	66 90                	xchg   %ax,%ax
    memset(mem, 0, PGSIZE);
80106f80:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106f87:	00 
80106f88:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106f8f:	00 
80106f90:	89 04 24             	mov    %eax,(%esp)
80106f93:	e8 18 d9 ff ff       	call   801048b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106f98:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f9e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106fa3:	89 04 24             	mov    %eax,(%esp)
80106fa6:	8b 45 08             	mov    0x8(%ebp),%eax
80106fa9:	89 da                	mov    %ebx,%edx
80106fab:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106fb2:	00 
80106fb3:	e8 48 fb ff ff       	call   80106b00 <mappages>
80106fb8:	85 c0                	test   %eax,%eax
80106fba:	78 44                	js     80107000 <allocuvm+0xb0>
  for(; a < newsz; a += PGSIZE){
80106fbc:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106fc2:	39 df                	cmp    %ebx,%edi
80106fc4:	76 2a                	jbe    80106ff0 <allocuvm+0xa0>
    mem = kalloc();
80106fc6:	e8 05 b5 ff ff       	call   801024d0 <kalloc>
    if(mem == 0){
80106fcb:	85 c0                	test   %eax,%eax
    mem = kalloc();
80106fcd:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106fcf:	75 af                	jne    80106f80 <allocuvm+0x30>
      cprintf("allocuvm out of memory\n");
80106fd1:	c7 04 24 b5 7d 10 80 	movl   $0x80107db5,(%esp)
80106fd8:	e8 73 96 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
80106fdd:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106fe0:	77 48                	ja     8010702a <allocuvm+0xda>
      return 0;
80106fe2:	31 c0                	xor    %eax,%eax
}
80106fe4:	83 c4 1c             	add    $0x1c,%esp
80106fe7:	5b                   	pop    %ebx
80106fe8:	5e                   	pop    %esi
80106fe9:	5f                   	pop    %edi
80106fea:	5d                   	pop    %ebp
80106feb:	c3                   	ret    
80106fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ff0:	83 c4 1c             	add    $0x1c,%esp
80106ff3:	89 f8                	mov    %edi,%eax
80106ff5:	5b                   	pop    %ebx
80106ff6:	5e                   	pop    %esi
80106ff7:	5f                   	pop    %edi
80106ff8:	5d                   	pop    %ebp
80106ff9:	c3                   	ret    
80106ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107000:	c7 04 24 cd 7d 10 80 	movl   $0x80107dcd,(%esp)
80107007:	e8 44 96 ff ff       	call   80100650 <cprintf>
  if(newsz >= oldsz)
8010700c:	3b 7d 0c             	cmp    0xc(%ebp),%edi
8010700f:	76 0d                	jbe    8010701e <allocuvm+0xce>
80107011:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107014:	89 fa                	mov    %edi,%edx
80107016:	8b 45 08             	mov    0x8(%ebp),%eax
80107019:	e8 62 fb ff ff       	call   80106b80 <deallocuvm.part.0>
      kfree(mem);
8010701e:	89 34 24             	mov    %esi,(%esp)
80107021:	e8 fa b2 ff ff       	call   80102320 <kfree>
      return 0;
80107026:	31 c0                	xor    %eax,%eax
80107028:	eb ba                	jmp    80106fe4 <allocuvm+0x94>
8010702a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010702d:	89 fa                	mov    %edi,%edx
8010702f:	8b 45 08             	mov    0x8(%ebp),%eax
80107032:	e8 49 fb ff ff       	call   80106b80 <deallocuvm.part.0>
      return 0;
80107037:	31 c0                	xor    %eax,%eax
80107039:	eb a9                	jmp    80106fe4 <allocuvm+0x94>
8010703b:	90                   	nop
8010703c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107040 <deallocuvm>:
{
80107040:	55                   	push   %ebp
80107041:	89 e5                	mov    %esp,%ebp
80107043:	8b 55 0c             	mov    0xc(%ebp),%edx
80107046:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107049:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010704c:	39 d1                	cmp    %edx,%ecx
8010704e:	73 08                	jae    80107058 <deallocuvm+0x18>
}
80107050:	5d                   	pop    %ebp
80107051:	e9 2a fb ff ff       	jmp    80106b80 <deallocuvm.part.0>
80107056:	66 90                	xchg   %ax,%ax
80107058:	89 d0                	mov    %edx,%eax
8010705a:	5d                   	pop    %ebp
8010705b:	c3                   	ret    
8010705c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107060 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107060:	55                   	push   %ebp
80107061:	89 e5                	mov    %esp,%ebp
80107063:	56                   	push   %esi
80107064:	53                   	push   %ebx
80107065:	83 ec 10             	sub    $0x10,%esp
80107068:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010706b:	85 f6                	test   %esi,%esi
8010706d:	74 59                	je     801070c8 <freevm+0x68>
8010706f:	31 c9                	xor    %ecx,%ecx
80107071:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107076:	89 f0                	mov    %esi,%eax
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107078:	31 db                	xor    %ebx,%ebx
8010707a:	e8 01 fb ff ff       	call   80106b80 <deallocuvm.part.0>
8010707f:	eb 12                	jmp    80107093 <freevm+0x33>
80107081:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107088:	83 c3 01             	add    $0x1,%ebx
8010708b:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
80107091:	74 27                	je     801070ba <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107093:	8b 14 9e             	mov    (%esi,%ebx,4),%edx
80107096:	f6 c2 01             	test   $0x1,%dl
80107099:	74 ed                	je     80107088 <freevm+0x28>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010709b:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(i = 0; i < NPDENTRIES; i++){
801070a1:	83 c3 01             	add    $0x1,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
801070a4:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
801070aa:	89 14 24             	mov    %edx,(%esp)
801070ad:	e8 6e b2 ff ff       	call   80102320 <kfree>
  for(i = 0; i < NPDENTRIES; i++){
801070b2:	81 fb 00 04 00 00    	cmp    $0x400,%ebx
801070b8:	75 d9                	jne    80107093 <freevm+0x33>
    }
  }
  kfree((char*)pgdir);
801070ba:	89 75 08             	mov    %esi,0x8(%ebp)
}
801070bd:	83 c4 10             	add    $0x10,%esp
801070c0:	5b                   	pop    %ebx
801070c1:	5e                   	pop    %esi
801070c2:	5d                   	pop    %ebp
  kfree((char*)pgdir);
801070c3:	e9 58 b2 ff ff       	jmp    80102320 <kfree>
    panic("freevm: no pgdir");
801070c8:	c7 04 24 e9 7d 10 80 	movl   $0x80107de9,(%esp)
801070cf:	e8 8c 92 ff ff       	call   80100360 <panic>
801070d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801070da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801070e0 <setupkvm>:
{
801070e0:	55                   	push   %ebp
801070e1:	89 e5                	mov    %esp,%ebp
801070e3:	56                   	push   %esi
801070e4:	53                   	push   %ebx
801070e5:	83 ec 10             	sub    $0x10,%esp
  if((pgdir = (pde_t*)kalloc()) == 0)
801070e8:	e8 e3 b3 ff ff       	call   801024d0 <kalloc>
801070ed:	85 c0                	test   %eax,%eax
801070ef:	89 c6                	mov    %eax,%esi
801070f1:	74 6d                	je     80107160 <setupkvm+0x80>
  memset(pgdir, 0, PGSIZE);
801070f3:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801070fa:	00 
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070fb:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80107100:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80107107:	00 
80107108:	89 04 24             	mov    %eax,(%esp)
8010710b:	e8 a0 d7 ff ff       	call   801048b0 <memset>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107110:	8b 53 0c             	mov    0xc(%ebx),%edx
80107113:	8b 43 04             	mov    0x4(%ebx),%eax
80107116:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107119:	89 54 24 04          	mov    %edx,0x4(%esp)
8010711d:	8b 13                	mov    (%ebx),%edx
8010711f:	89 04 24             	mov    %eax,(%esp)
80107122:	29 c1                	sub    %eax,%ecx
80107124:	89 f0                	mov    %esi,%eax
80107126:	e8 d5 f9 ff ff       	call   80106b00 <mappages>
8010712b:	85 c0                	test   %eax,%eax
8010712d:	78 19                	js     80107148 <setupkvm+0x68>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010712f:	83 c3 10             	add    $0x10,%ebx
80107132:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107138:	72 d6                	jb     80107110 <setupkvm+0x30>
8010713a:	89 f0                	mov    %esi,%eax
}
8010713c:	83 c4 10             	add    $0x10,%esp
8010713f:	5b                   	pop    %ebx
80107140:	5e                   	pop    %esi
80107141:	5d                   	pop    %ebp
80107142:	c3                   	ret    
80107143:	90                   	nop
80107144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107148:	89 34 24             	mov    %esi,(%esp)
8010714b:	e8 10 ff ff ff       	call   80107060 <freevm>
}
80107150:	83 c4 10             	add    $0x10,%esp
      return 0;
80107153:	31 c0                	xor    %eax,%eax
}
80107155:	5b                   	pop    %ebx
80107156:	5e                   	pop    %esi
80107157:	5d                   	pop    %ebp
80107158:	c3                   	ret    
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80107160:	31 c0                	xor    %eax,%eax
80107162:	eb d8                	jmp    8010713c <setupkvm+0x5c>
80107164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010716a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107170 <kvmalloc>:
{
80107170:	55                   	push   %ebp
80107171:	89 e5                	mov    %esp,%ebp
80107173:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107176:	e8 65 ff ff ff       	call   801070e0 <setupkvm>
8010717b:	a3 c4 59 11 80       	mov    %eax,0x801159c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107180:	05 00 00 00 80       	add    $0x80000000,%eax
80107185:	0f 22 d8             	mov    %eax,%cr3
}
80107188:	c9                   	leave  
80107189:	c3                   	ret    
8010718a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107190 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107190:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107191:	31 c9                	xor    %ecx,%ecx
{
80107193:	89 e5                	mov    %esp,%ebp
80107195:	83 ec 18             	sub    $0x18,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107198:	8b 55 0c             	mov    0xc(%ebp),%edx
8010719b:	8b 45 08             	mov    0x8(%ebp),%eax
8010719e:	e8 cd f8 ff ff       	call   80106a70 <walkpgdir>
  if(pte == 0)
801071a3:	85 c0                	test   %eax,%eax
801071a5:	74 05                	je     801071ac <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801071a7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801071aa:	c9                   	leave  
801071ab:	c3                   	ret    
    panic("clearpteu");
801071ac:	c7 04 24 fa 7d 10 80 	movl   $0x80107dfa,(%esp)
801071b3:	e8 a8 91 ff ff       	call   80100360 <panic>
801071b8:	90                   	nop
801071b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801071c0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801071c0:	55                   	push   %ebp
801071c1:	89 e5                	mov    %esp,%ebp
801071c3:	57                   	push   %edi
801071c4:	56                   	push   %esi
801071c5:	53                   	push   %ebx
801071c6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801071c9:	e8 12 ff ff ff       	call   801070e0 <setupkvm>
801071ce:	85 c0                	test   %eax,%eax
801071d0:	89 45 e0             	mov    %eax,-0x20(%ebp)
801071d3:	0f 84 b9 00 00 00    	je     80107292 <copyuvm+0xd2>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801071dc:	85 c0                	test   %eax,%eax
801071de:	0f 84 94 00 00 00    	je     80107278 <copyuvm+0xb8>
801071e4:	31 ff                	xor    %edi,%edi
801071e6:	eb 48                	jmp    80107230 <copyuvm+0x70>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
801071e8:	81 c6 00 00 00 80    	add    $0x80000000,%esi
801071ee:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801071f5:	00 
801071f6:	89 74 24 04          	mov    %esi,0x4(%esp)
801071fa:	89 04 24             	mov    %eax,(%esp)
801071fd:	e8 4e d7 ff ff       	call   80104950 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107202:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107205:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010720a:	89 fa                	mov    %edi,%edx
8010720c:	89 44 24 04          	mov    %eax,0x4(%esp)
80107210:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107216:	89 04 24             	mov    %eax,(%esp)
80107219:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010721c:	e8 df f8 ff ff       	call   80106b00 <mappages>
80107221:	85 c0                	test   %eax,%eax
80107223:	78 63                	js     80107288 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107225:	81 c7 00 10 00 00    	add    $0x1000,%edi
8010722b:	39 7d 0c             	cmp    %edi,0xc(%ebp)
8010722e:	76 48                	jbe    80107278 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107230:	8b 45 08             	mov    0x8(%ebp),%eax
80107233:	31 c9                	xor    %ecx,%ecx
80107235:	89 fa                	mov    %edi,%edx
80107237:	e8 34 f8 ff ff       	call   80106a70 <walkpgdir>
8010723c:	85 c0                	test   %eax,%eax
8010723e:	74 62                	je     801072a2 <copyuvm+0xe2>
    if(!(*pte & PTE_P))
80107240:	8b 00                	mov    (%eax),%eax
80107242:	a8 01                	test   $0x1,%al
80107244:	74 50                	je     80107296 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107246:	89 c6                	mov    %eax,%esi
    flags = PTE_FLAGS(*pte);
80107248:	25 ff 0f 00 00       	and    $0xfff,%eax
8010724d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107250:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    if((mem = kalloc()) == 0)
80107256:	e8 75 b2 ff ff       	call   801024d0 <kalloc>
8010725b:	85 c0                	test   %eax,%eax
8010725d:	89 c3                	mov    %eax,%ebx
8010725f:	75 87                	jne    801071e8 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80107261:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107264:	89 04 24             	mov    %eax,(%esp)
80107267:	e8 f4 fd ff ff       	call   80107060 <freevm>
  return 0;
8010726c:	31 c0                	xor    %eax,%eax
}
8010726e:	83 c4 2c             	add    $0x2c,%esp
80107271:	5b                   	pop    %ebx
80107272:	5e                   	pop    %esi
80107273:	5f                   	pop    %edi
80107274:	5d                   	pop    %ebp
80107275:	c3                   	ret    
80107276:	66 90                	xchg   %ax,%ax
80107278:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010727b:	83 c4 2c             	add    $0x2c,%esp
8010727e:	5b                   	pop    %ebx
8010727f:	5e                   	pop    %esi
80107280:	5f                   	pop    %edi
80107281:	5d                   	pop    %ebp
80107282:	c3                   	ret    
80107283:	90                   	nop
80107284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107288:	89 1c 24             	mov    %ebx,(%esp)
8010728b:	e8 90 b0 ff ff       	call   80102320 <kfree>
      goto bad;
80107290:	eb cf                	jmp    80107261 <copyuvm+0xa1>
    return 0;
80107292:	31 c0                	xor    %eax,%eax
80107294:	eb d8                	jmp    8010726e <copyuvm+0xae>
      panic("copyuvm: page not present");
80107296:	c7 04 24 1e 7e 10 80 	movl   $0x80107e1e,(%esp)
8010729d:	e8 be 90 ff ff       	call   80100360 <panic>
      panic("copyuvm: pte should exist");
801072a2:	c7 04 24 04 7e 10 80 	movl   $0x80107e04,(%esp)
801072a9:	e8 b2 90 ff ff       	call   80100360 <panic>
801072ae:	66 90                	xchg   %ax,%ax

801072b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801072b0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801072b1:	31 c9                	xor    %ecx,%ecx
{
801072b3:	89 e5                	mov    %esp,%ebp
801072b5:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801072b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801072bb:	8b 45 08             	mov    0x8(%ebp),%eax
801072be:	e8 ad f7 ff ff       	call   80106a70 <walkpgdir>
  if((*pte & PTE_P) == 0)
801072c3:	8b 00                	mov    (%eax),%eax
801072c5:	89 c2                	mov    %eax,%edx
801072c7:	83 e2 05             	and    $0x5,%edx
    return 0;
  if((*pte & PTE_U) == 0)
801072ca:	83 fa 05             	cmp    $0x5,%edx
801072cd:	75 11                	jne    801072e0 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
801072cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801072d4:	05 00 00 00 80       	add    $0x80000000,%eax
}
801072d9:	c9                   	leave  
801072da:	c3                   	ret    
801072db:	90                   	nop
801072dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
801072e0:	31 c0                	xor    %eax,%eax
}
801072e2:	c9                   	leave  
801072e3:	c3                   	ret    
801072e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801072ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801072f0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801072f0:	55                   	push   %ebp
801072f1:	89 e5                	mov    %esp,%ebp
801072f3:	57                   	push   %edi
801072f4:	56                   	push   %esi
801072f5:	53                   	push   %ebx
801072f6:	83 ec 1c             	sub    $0x1c,%esp
801072f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
801072fc:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072ff:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107302:	85 db                	test   %ebx,%ebx
80107304:	75 3a                	jne    80107340 <copyout+0x50>
80107306:	eb 68                	jmp    80107370 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107308:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010730b:	89 f2                	mov    %esi,%edx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
8010730d:	89 7c 24 04          	mov    %edi,0x4(%esp)
    n = PGSIZE - (va - va0);
80107311:	29 ca                	sub    %ecx,%edx
80107313:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107319:	39 da                	cmp    %ebx,%edx
8010731b:	0f 47 d3             	cmova  %ebx,%edx
    memmove(pa0 + (va - va0), buf, n);
8010731e:	29 f1                	sub    %esi,%ecx
80107320:	01 c8                	add    %ecx,%eax
80107322:	89 54 24 08          	mov    %edx,0x8(%esp)
80107326:	89 04 24             	mov    %eax,(%esp)
80107329:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010732c:	e8 1f d6 ff ff       	call   80104950 <memmove>
    len -= n;
    buf += n;
80107331:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    va = va0 + PGSIZE;
80107334:	8d 8e 00 10 00 00    	lea    0x1000(%esi),%ecx
    buf += n;
8010733a:	01 d7                	add    %edx,%edi
  while(len > 0){
8010733c:	29 d3                	sub    %edx,%ebx
8010733e:	74 30                	je     80107370 <copyout+0x80>
    pa0 = uva2ka(pgdir, (char*)va0);
80107340:	8b 45 08             	mov    0x8(%ebp),%eax
    va0 = (uint)PGROUNDDOWN(va);
80107343:	89 ce                	mov    %ecx,%esi
80107345:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
8010734b:	89 74 24 04          	mov    %esi,0x4(%esp)
    va0 = (uint)PGROUNDDOWN(va);
8010734f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
80107352:	89 04 24             	mov    %eax,(%esp)
80107355:	e8 56 ff ff ff       	call   801072b0 <uva2ka>
    if(pa0 == 0)
8010735a:	85 c0                	test   %eax,%eax
8010735c:	75 aa                	jne    80107308 <copyout+0x18>
  }
  return 0;
}
8010735e:	83 c4 1c             	add    $0x1c,%esp
      return -1;
80107361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107366:	5b                   	pop    %ebx
80107367:	5e                   	pop    %esi
80107368:	5f                   	pop    %edi
80107369:	5d                   	pop    %ebp
8010736a:	c3                   	ret    
8010736b:	90                   	nop
8010736c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107370:	83 c4 1c             	add    $0x1c,%esp
  return 0;
80107373:	31 c0                	xor    %eax,%eax
}
80107375:	5b                   	pop    %ebx
80107376:	5e                   	pop    %esi
80107377:	5f                   	pop    %edi
80107378:	5d                   	pop    %ebp
80107379:	c3                   	ret    
