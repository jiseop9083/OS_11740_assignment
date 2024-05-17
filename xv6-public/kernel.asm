
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
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
80100028:	bc d0 68 11 80       	mov    $0x801168d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 30 10 80       	mov    $0x80103060,%eax
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
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 78 10 80       	push   $0x801078e0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 b5 49 00 00       	call   80104a10 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 78 10 80       	push   $0x801078e7
80100097:	50                   	push   %eax
80100098:	e8 43 48 00 00       	call   801048e0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

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
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 f7 4a 00 00       	call   80104be0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
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
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 19 4a 00 00       	call   80104b80 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 47 00 00       	call   80104920 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 4f 21 00 00       	call   801022e0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ee 78 10 80       	push   $0x801078ee
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 fd 47 00 00       	call   801049c0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 07 21 00 00       	jmp    801022e0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 78 10 80       	push   $0x801078ff
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 bc 47 00 00       	call   801049c0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 6c 47 00 00       	call   80104980 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 c0 49 00 00       	call   80104be0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 0f 49 00 00       	jmp    80104b80 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 06 79 10 80       	push   $0x80107906
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 c7 15 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 3b 49 00 00       	call   80104be0 <acquire>
  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
    while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 ee 3c 00 00       	call   80103fc0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 a9 36 00 00       	call   80103990 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 85 48 00 00       	call   80104b80 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 7c 14 00 00       	call   80101780 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 2f 48 00 00       	call   80104b80 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 26 14 00 00       	call   80101780 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
  cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 52 25 00 00       	call   801028f0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 0d 79 10 80       	push   $0x8010790d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 83 82 10 80 	movl   $0x80108283,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 63 46 00 00       	call   80104a30 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 21 79 10 80       	push   $0x80107921
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 e1 5f 00 00       	call   80106400 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100441:	c1 e1 08             	shl    $0x8,%ecx
80100444:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100445:	89 f2                	mov    %esi,%edx
80100447:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100448:	0f b6 c0             	movzbl %al,%eax
8010044b:	09 c8                	or     %ecx,%eax
  if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	0f 84 92 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100456:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045c:	74 72                	je     801004d0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010045e:	0f b6 db             	movzbl %bl,%ebx
80100461:	8d 70 01             	lea    0x1(%eax),%esi
80100464:	80 cf 07             	or     $0x7,%bh
80100467:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
8010046e:	80 
  if(pos < 0 || pos > 25*80)
8010046f:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100475:	0f 8f fb 00 00 00    	jg     80100576 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010047b:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100481:	0f 8f a9 00 00 00    	jg     80100530 <consputc.part.0+0x130>
  outb(CRTPORT+1, pos>>8);
80100487:	89 f0                	mov    %esi,%eax
  crt[pos] = ' ' | 0x0700;
80100489:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
80100490:	88 45 e7             	mov    %al,-0x19(%ebp)
  outb(CRTPORT+1, pos>>8);
80100493:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100496:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049b:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a0:	89 da                	mov    %ebx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a8:	89 f8                	mov    %edi,%eax
801004aa:	89 ca                	mov    %ecx,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004b9:	89 ca                	mov    %ecx,%edx
801004bb:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004bc:	b8 20 07 00 00       	mov    $0x720,%eax
801004c1:	66 89 06             	mov    %ax,(%esi)
}
801004c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c7:	5b                   	pop    %ebx
801004c8:	5e                   	pop    %esi
801004c9:	5f                   	pop    %edi
801004ca:	5d                   	pop    %ebp
801004cb:	c3                   	ret    
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 98                	jne    8010046f <consputc.part.0+0x6f>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b2                	jmp    80100496 <consputc.part.0+0x96>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 6f ff ff ff       	jmp    8010046f <consputc.part.0+0x6f>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 f6 5e 00 00       	call   80106400 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 ea 5e 00 00       	call   80106400 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 de 5e 00 00       	call   80106400 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
  outb(CRTPORT+1, pos);
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 ea 47 00 00       	call   80104d40 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 35 47 00 00       	call   80104ca0 <memset>
  outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
    panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 25 79 10 80       	push   $0x80107925
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100599:	ff 75 08             	push   0x8(%ebp)
{
8010059c:	8b 75 10             	mov    0x10(%ebp),%esi
  iunlock(ip);
8010059f:	e8 bc 12 00 00       	call   80101860 <iunlock>
  acquire(&cons.lock);
801005a4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005ab:	e8 30 46 00 00       	call   80104be0 <acquire>
  for(i = 0; i < n; i++)
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
  if(panicked){
801005bd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
    consputc(buf[i] & 0xff);
801005c3:	0f b6 03             	movzbl (%ebx),%eax
  if(panicked){
801005c6:	85 d2                	test   %edx,%edx
801005c8:	74 06                	je     801005d0 <consolewrite+0x40>
  asm volatile("cli");
801005ca:	fa                   	cli    
    for(;;)
801005cb:	eb fe                	jmp    801005cb <consolewrite+0x3b>
801005cd:	8d 76 00             	lea    0x0(%esi),%esi
801005d0:	e8 2b fe ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; i < n; i++)
801005d5:	83 c3 01             	add    $0x1,%ebx
801005d8:	39 df                	cmp    %ebx,%edi
801005da:	75 e1                	jne    801005bd <consolewrite+0x2d>
  release(&cons.lock);
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 20 ff 10 80       	push   $0x8010ff20
801005e4:	e8 97 45 00 00       	call   80104b80 <release>
  ilock(ip);
801005e9:	58                   	pop    %eax
801005ea:	ff 75 08             	push   0x8(%ebp)
801005ed:	e8 8e 11 00 00       	call   80101780 <ilock>

  return n;
}
801005f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f5:	89 f0                	mov    %esi,%eax
801005f7:	5b                   	pop    %ebx
801005f8:	5e                   	pop    %esi
801005f9:	5f                   	pop    %edi
801005fa:	5d                   	pop    %ebp
801005fb:	c3                   	ret    
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <printint>:
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
80100609:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010060c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
  if(sign && (sign = xx < 0))
8010060f:	85 c9                	test   %ecx,%ecx
80100611:	74 04                	je     80100617 <printint+0x17>
80100613:	85 c0                	test   %eax,%eax
80100615:	78 6d                	js     80100684 <printint+0x84>
    x = xx;
80100617:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010061e:	89 c1                	mov    %eax,%ecx
  i = 0;
80100620:	31 db                	xor    %ebx,%ebx
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    buf[i++] = digits[x % base];
80100628:	89 c8                	mov    %ecx,%eax
8010062a:	31 d2                	xor    %edx,%edx
8010062c:	89 de                	mov    %ebx,%esi
8010062e:	89 cf                	mov    %ecx,%edi
80100630:	f7 75 d4             	divl   -0x2c(%ebp)
80100633:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100636:	0f b6 92 50 79 10 80 	movzbl -0x7fef86b0(%edx),%edx
  }while((x /= base) != 0);
8010063d:	89 c1                	mov    %eax,%ecx
    buf[i++] = digits[x % base];
8010063f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
  }while((x /= base) != 0);
80100643:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100646:	73 e0                	jae    80100628 <printint+0x28>
  if(sign)
80100648:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 0c                	je     8010065b <printint+0x5b>
    buf[i++] = '-';
8010064f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
80100654:	89 de                	mov    %ebx,%esi
    buf[i++] = '-';
80100656:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
8010065b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010065f:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100662:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100668:	85 d2                	test   %edx,%edx
8010066a:	74 04                	je     80100670 <printint+0x70>
8010066c:	fa                   	cli    
    for(;;)
8010066d:	eb fe                	jmp    8010066d <printint+0x6d>
8010066f:	90                   	nop
80100670:	e8 8b fd ff ff       	call   80100400 <consputc.part.0>
  while(--i >= 0)
80100675:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100678:	39 c3                	cmp    %eax,%ebx
8010067a:	74 0e                	je     8010068a <printint+0x8a>
    consputc(buf[i]);
8010067c:	0f be 03             	movsbl (%ebx),%eax
8010067f:	83 eb 01             	sub    $0x1,%ebx
80100682:	eb de                	jmp    80100662 <printint+0x62>
    x = -xx;
80100684:	f7 d8                	neg    %eax
80100686:	89 c1                	mov    %eax,%ecx
80100688:	eb 96                	jmp    80100620 <printint+0x20>
}
8010068a:	83 c4 2c             	add    $0x2c,%esp
8010068d:	5b                   	pop    %ebx
8010068e:	5e                   	pop    %esi
8010068f:	5f                   	pop    %edi
80100690:	5d                   	pop    %ebp
80100691:	c3                   	ret    
80100692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006a9:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
801006ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 27 01 00 00    	jne    801007e0 <cprintf+0x140>
  if (fmt == 0)
801006b9:	8b 75 08             	mov    0x8(%ebp),%esi
801006bc:	85 f6                	test   %esi,%esi
801006be:	0f 84 ac 01 00 00    	je     80100870 <cprintf+0x1d0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c4:	0f b6 06             	movzbl (%esi),%eax
  argp = (uint*)(void*)(&fmt + 1);
801006c7:	8d 7d 0c             	lea    0xc(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ca:	31 db                	xor    %ebx,%ebx
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 56                	je     80100726 <cprintf+0x86>
    if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	0f 85 cf 00 00 00    	jne    801007a8 <cprintf+0x108>
    c = fmt[++i] & 0xff;
801006d9:	83 c3 01             	add    $0x1,%ebx
801006dc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
    if(c == 0)
801006e0:	85 d2                	test   %edx,%edx
801006e2:	74 42                	je     80100726 <cprintf+0x86>
    switch(c){
801006e4:	83 fa 70             	cmp    $0x70,%edx
801006e7:	0f 84 90 00 00 00    	je     8010077d <cprintf+0xdd>
801006ed:	7f 51                	jg     80100740 <cprintf+0xa0>
801006ef:	83 fa 25             	cmp    $0x25,%edx
801006f2:	0f 84 c0 00 00 00    	je     801007b8 <cprintf+0x118>
801006f8:	83 fa 64             	cmp    $0x64,%edx
801006fb:	0f 85 f4 00 00 00    	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 10, 1);
80100701:	8d 47 04             	lea    0x4(%edi),%eax
80100704:	b9 01 00 00 00       	mov    $0x1,%ecx
80100709:	ba 0a 00 00 00       	mov    $0xa,%edx
8010070e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100711:	8b 07                	mov    (%edi),%eax
80100713:	e8 e8 fe ff ff       	call   80100600 <printint>
80100718:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010071b:	83 c3 01             	add    $0x1,%ebx
8010071e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100722:	85 c0                	test   %eax,%eax
80100724:	75 aa                	jne    801006d0 <cprintf+0x30>
  if(locking)
80100726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	0f 85 22 01 00 00    	jne    80100853 <cprintf+0x1b3>
}
80100731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100734:	5b                   	pop    %ebx
80100735:	5e                   	pop    %esi
80100736:	5f                   	pop    %edi
80100737:	5d                   	pop    %ebp
80100738:	c3                   	ret    
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	75 33                	jne    80100778 <cprintf+0xd8>
      if((s = (char*)*argp++) == 0)
80100745:	8d 47 04             	lea    0x4(%edi),%eax
80100748:	8b 3f                	mov    (%edi),%edi
8010074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010074d:	85 ff                	test   %edi,%edi
8010074f:	0f 84 e3 00 00 00    	je     80100838 <cprintf+0x198>
      for(; *s; s++)
80100755:	0f be 07             	movsbl (%edi),%eax
80100758:	84 c0                	test   %al,%al
8010075a:	0f 84 08 01 00 00    	je     80100868 <cprintf+0x1c8>
  if(panicked){
80100760:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100766:	85 d2                	test   %edx,%edx
80100768:	0f 84 b2 00 00 00    	je     80100820 <cprintf+0x180>
8010076e:	fa                   	cli    
    for(;;)
8010076f:	eb fe                	jmp    8010076f <cprintf+0xcf>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100778:	83 fa 78             	cmp    $0x78,%edx
8010077b:	75 78                	jne    801007f5 <cprintf+0x155>
      printint(*argp++, 16, 0);
8010077d:	8d 47 04             	lea    0x4(%edi),%eax
80100780:	31 c9                	xor    %ecx,%ecx
80100782:	ba 10 00 00 00       	mov    $0x10,%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100787:	83 c3 01             	add    $0x1,%ebx
      printint(*argp++, 16, 0);
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	8b 07                	mov    (%edi),%eax
8010078f:	e8 6c fe ff ff       	call   80100600 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100794:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
      printint(*argp++, 16, 0);
80100798:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010079b:	85 c0                	test   %eax,%eax
8010079d:	0f 85 2d ff ff ff    	jne    801006d0 <cprintf+0x30>
801007a3:	eb 81                	jmp    80100726 <cprintf+0x86>
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007a8:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
    for(;;)
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
  if(panicked){
801007b8:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	75 6c                	jne    8010082d <cprintf+0x18d>
801007c1:	b8 25 00 00 00       	mov    $0x25,%eax
801007c6:	e8 35 fc ff ff       	call   80100400 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	0f 85 f6 fe ff ff    	jne    801006d0 <cprintf+0x30>
801007da:	e9 47 ff ff ff       	jmp    80100726 <cprintf+0x86>
801007df:	90                   	nop
    acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 ff 10 80       	push   $0x8010ff20
801007e8:	e8 f3 43 00 00       	call   80104be0 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
  if(panicked){
801007f5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 31                	jne    80100830 <cprintf+0x190>
801007ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100804:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100807:	e8 f4 fb ff ff       	call   80100400 <consputc.part.0>
8010080c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100812:	85 d2                	test   %edx,%edx
80100814:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100817:	74 2e                	je     80100847 <cprintf+0x1a7>
80100819:	fa                   	cli    
    for(;;)
8010081a:	eb fe                	jmp    8010081a <cprintf+0x17a>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	e8 db fb ff ff       	call   80100400 <consputc.part.0>
      for(; *s; s++)
80100825:	83 c7 01             	add    $0x1,%edi
80100828:	e9 28 ff ff ff       	jmp    80100755 <cprintf+0xb5>
8010082d:	fa                   	cli    
    for(;;)
8010082e:	eb fe                	jmp    8010082e <cprintf+0x18e>
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x191>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
        s = "(null)";
80100838:	bf 38 79 10 80       	mov    $0x80107938,%edi
      for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
    release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 20 43 00 00       	call   80104b80 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
      if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
    panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 3f 79 10 80       	push   $0x8010793f
80100878:	e8 03 fb ff ff       	call   80100380 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <consoleintr>:
{
80100880:	55                   	push   %ebp
80100881:	89 e5                	mov    %esp,%ebp
80100883:	57                   	push   %edi
80100884:	56                   	push   %esi
  int c, doprocdump = 0;
80100885:	31 f6                	xor    %esi,%esi
{
80100887:	53                   	push   %ebx
80100888:	83 ec 18             	sub    $0x18,%esp
8010088b:	8b 7d 08             	mov    0x8(%ebp),%edi
  acquire(&cons.lock);
8010088e:	68 20 ff 10 80       	push   $0x8010ff20
80100893:	e8 48 43 00 00       	call   80104be0 <acquire>
  while((c = getc()) >= 0){
80100898:	83 c4 10             	add    $0x10,%esp
8010089b:	eb 1a                	jmp    801008b7 <consoleintr+0x37>
8010089d:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801008a0:	83 fb 08             	cmp    $0x8,%ebx
801008a3:	0f 84 d7 00 00 00    	je     80100980 <consoleintr+0x100>
801008a9:	83 fb 10             	cmp    $0x10,%ebx
801008ac:	0f 85 32 01 00 00    	jne    801009e4 <consoleintr+0x164>
801008b2:	be 01 00 00 00       	mov    $0x1,%esi
  while((c = getc()) >= 0){
801008b7:	ff d7                	call   *%edi
801008b9:	89 c3                	mov    %eax,%ebx
801008bb:	85 c0                	test   %eax,%eax
801008bd:	0f 88 05 01 00 00    	js     801009c8 <consoleintr+0x148>
    switch(c){
801008c3:	83 fb 15             	cmp    $0x15,%ebx
801008c6:	74 78                	je     80100940 <consoleintr+0xc0>
801008c8:	7e d6                	jle    801008a0 <consoleintr+0x20>
801008ca:	83 fb 7f             	cmp    $0x7f,%ebx
801008cd:	0f 84 ad 00 00 00    	je     80100980 <consoleintr+0x100>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008d3:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801008d8:	89 c2                	mov    %eax,%edx
801008da:	2b 15 00 ff 10 80    	sub    0x8010ff00,%edx
801008e0:	83 fa 7f             	cmp    $0x7f,%edx
801008e3:	77 d2                	ja     801008b7 <consoleintr+0x37>
        input.buf[input.e++ % INPUT_BUF] = c;
801008e5:	8d 48 01             	lea    0x1(%eax),%ecx
  if(panicked){
801008e8:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.buf[input.e++ % INPUT_BUF] = c;
801008ee:	83 e0 7f             	and    $0x7f,%eax
801008f1:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
        c = (c == '\r') ? '\n' : c;
801008f7:	83 fb 0d             	cmp    $0xd,%ebx
801008fa:	0f 84 13 01 00 00    	je     80100a13 <consoleintr+0x193>
        input.buf[input.e++ % INPUT_BUF] = c;
80100900:	88 98 80 fe 10 80    	mov    %bl,-0x7fef0180(%eax)
  if(panicked){
80100906:	85 d2                	test   %edx,%edx
80100908:	0f 85 10 01 00 00    	jne    80100a1e <consoleintr+0x19e>
8010090e:	89 d8                	mov    %ebx,%eax
80100910:	e8 eb fa ff ff       	call   80100400 <consputc.part.0>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100915:	83 fb 0a             	cmp    $0xa,%ebx
80100918:	0f 84 14 01 00 00    	je     80100a32 <consoleintr+0x1b2>
8010091e:	83 fb 04             	cmp    $0x4,%ebx
80100921:	0f 84 0b 01 00 00    	je     80100a32 <consoleintr+0x1b2>
80100927:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
8010092c:	83 e8 80             	sub    $0xffffff80,%eax
8010092f:	39 05 08 ff 10 80    	cmp    %eax,0x8010ff08
80100935:	75 80                	jne    801008b7 <consoleintr+0x37>
80100937:	e9 fb 00 00 00       	jmp    80100a37 <consoleintr+0x1b7>
8010093c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      while(input.e != input.w &&
80100940:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100945:	39 05 04 ff 10 80    	cmp    %eax,0x8010ff04
8010094b:	0f 84 66 ff ff ff    	je     801008b7 <consoleintr+0x37>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100951:	83 e8 01             	sub    $0x1,%eax
80100954:	89 c2                	mov    %eax,%edx
80100956:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100959:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100960:	0f 84 51 ff ff ff    	je     801008b7 <consoleintr+0x37>
  if(panicked){
80100966:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        input.e--;
8010096c:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100971:	85 d2                	test   %edx,%edx
80100973:	74 33                	je     801009a8 <consoleintr+0x128>
80100975:	fa                   	cli    
    for(;;)
80100976:	eb fe                	jmp    80100976 <consoleintr+0xf6>
80100978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010097f:	90                   	nop
      if(input.e != input.w){
80100980:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100985:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
8010098b:	0f 84 26 ff ff ff    	je     801008b7 <consoleintr+0x37>
        input.e--;
80100991:	83 e8 01             	sub    $0x1,%eax
80100994:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
  if(panicked){
80100999:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
8010099e:	85 c0                	test   %eax,%eax
801009a0:	74 56                	je     801009f8 <consoleintr+0x178>
801009a2:	fa                   	cli    
    for(;;)
801009a3:	eb fe                	jmp    801009a3 <consoleintr+0x123>
801009a5:	8d 76 00             	lea    0x0(%esi),%esi
801009a8:	b8 00 01 00 00       	mov    $0x100,%eax
801009ad:	e8 4e fa ff ff       	call   80100400 <consputc.part.0>
      while(input.e != input.w &&
801009b2:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
801009b7:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801009bd:	75 92                	jne    80100951 <consoleintr+0xd1>
801009bf:	e9 f3 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
801009c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
801009c8:	83 ec 0c             	sub    $0xc,%esp
801009cb:	68 20 ff 10 80       	push   $0x8010ff20
801009d0:	e8 ab 41 00 00       	call   80104b80 <release>
  if(doprocdump) {
801009d5:	83 c4 10             	add    $0x10,%esp
801009d8:	85 f6                	test   %esi,%esi
801009da:	75 2b                	jne    80100a07 <consoleintr+0x187>
}
801009dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009df:	5b                   	pop    %ebx
801009e0:	5e                   	pop    %esi
801009e1:	5f                   	pop    %edi
801009e2:	5d                   	pop    %ebp
801009e3:	c3                   	ret    
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009e4:	85 db                	test   %ebx,%ebx
801009e6:	0f 84 cb fe ff ff    	je     801008b7 <consoleintr+0x37>
801009ec:	e9 e2 fe ff ff       	jmp    801008d3 <consoleintr+0x53>
801009f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009f8:	b8 00 01 00 00       	mov    $0x100,%eax
801009fd:	e8 fe f9 ff ff       	call   80100400 <consputc.part.0>
80100a02:	e9 b0 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
}
80100a07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a0a:	5b                   	pop    %ebx
80100a0b:	5e                   	pop    %esi
80100a0c:	5f                   	pop    %edi
80100a0d:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100a0e:	e9 4d 37 00 00       	jmp    80104160 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a13:	c6 80 80 fe 10 80 0a 	movb   $0xa,-0x7fef0180(%eax)
  if(panicked){
80100a1a:	85 d2                	test   %edx,%edx
80100a1c:	74 0a                	je     80100a28 <consoleintr+0x1a8>
80100a1e:	fa                   	cli    
    for(;;)
80100a1f:	eb fe                	jmp    80100a1f <consoleintr+0x19f>
80100a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a28:	b8 0a 00 00 00       	mov    $0xa,%eax
80100a2d:	e8 ce f9 ff ff       	call   80100400 <consputc.part.0>
          input.w = input.e;
80100a32:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
          wakeup(&input.r);
80100a37:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a3a:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
          wakeup(&input.r);
80100a3f:	68 00 ff 10 80       	push   $0x8010ff00
80100a44:	e8 37 36 00 00       	call   80104080 <wakeup>
80100a49:	83 c4 10             	add    $0x10,%esp
80100a4c:	e9 66 fe ff ff       	jmp    801008b7 <consoleintr+0x37>
80100a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5f:	90                   	nop

80100a60 <consoleinit>:

void
consoleinit(void)
{
80100a60:	55                   	push   %ebp
80100a61:	89 e5                	mov    %esp,%ebp
80100a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100a66:	68 48 79 10 80       	push   $0x80107948
80100a6b:	68 20 ff 10 80       	push   $0x8010ff20
80100a70:	e8 9b 3f 00 00       	call   80104a10 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100a75:	58                   	pop    %eax
80100a76:	5a                   	pop    %edx
80100a77:	6a 00                	push   $0x0
80100a79:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100a7b:	c7 05 0c 09 11 80 90 	movl   $0x80100590,0x8011090c
80100a82:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100a85:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100a8c:	02 10 80 
  cons.locking = 1;
80100a8f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100a96:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100a99:	e8 e2 19 00 00       	call   80102480 <ioapicenable>
}
80100a9e:	83 c4 10             	add    $0x10,%esp
80100aa1:	c9                   	leave  
80100aa2:	c3                   	ret    
80100aa3:	66 90                	xchg   %ax,%ax
80100aa5:	66 90                	xchg   %ax,%ax
80100aa7:	66 90                	xchg   %ax,%ax
80100aa9:	66 90                	xchg   %ax,%ax
80100aab:	66 90                	xchg   %ax,%ax
80100aad:	66 90                	xchg   %ax,%ax
80100aaf:	90                   	nop

80100ab0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100abc:	e8 cf 2e 00 00       	call   80103990 <myproc>
	
	//kill all thread except this thread
	thread_exit_all(curproc);
80100ac1:	83 ec 0c             	sub    $0xc,%esp
80100ac4:	50                   	push   %eax
  struct proc *curproc = myproc();
80100ac5:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
	thread_exit_all(curproc);
80100acb:	e8 10 3c 00 00       	call   801046e0 <thread_exit_all>
	
  begin_op();
80100ad0:	e8 8b 22 00 00       	call   80102d60 <begin_op>

  if((ip = namei(path)) == 0){
80100ad5:	5a                   	pop    %edx
80100ad6:	ff 75 08             	push   0x8(%ebp)
80100ad9:	e8 c2 15 00 00       	call   801020a0 <namei>
80100ade:	83 c4 10             	add    $0x10,%esp
80100ae1:	85 c0                	test   %eax,%eax
80100ae3:	0f 84 fb 02 00 00    	je     80100de4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100ae9:	83 ec 0c             	sub    $0xc,%esp
80100aec:	89 c3                	mov    %eax,%ebx
80100aee:	50                   	push   %eax
80100aef:	e8 8c 0c 00 00       	call   80101780 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100af4:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100afa:	6a 34                	push   $0x34
80100afc:	6a 00                	push   $0x0
80100afe:	50                   	push   %eax
80100aff:	53                   	push   %ebx
80100b00:	e8 8b 0f 00 00       	call   80101a90 <readi>
80100b05:	83 c4 20             	add    $0x20,%esp
80100b08:	83 f8 34             	cmp    $0x34,%eax
80100b0b:	74 23                	je     80100b30 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100b0d:	83 ec 0c             	sub    $0xc,%esp
80100b10:	53                   	push   %ebx
80100b11:	e8 fa 0e 00 00       	call   80101a10 <iunlockput>
    end_op();
80100b16:	e8 b5 22 00 00       	call   80102dd0 <end_op>
80100b1b:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100b1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100b23:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b26:	5b                   	pop    %ebx
80100b27:	5e                   	pop    %esi
80100b28:	5f                   	pop    %edi
80100b29:	5d                   	pop    %ebp
80100b2a:	c3                   	ret    
80100b2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b2f:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100b30:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100b37:	45 4c 46 
80100b3a:	75 d1                	jne    80100b0d <exec+0x5d>
  if((pgdir = setupkvm()) == 0)
80100b3c:	e8 4f 6a 00 00       	call   80107590 <setupkvm>
80100b41:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100b47:	85 c0                	test   %eax,%eax
80100b49:	74 c2                	je     80100b0d <exec+0x5d>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b4b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100b52:	00 
80100b53:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100b59:	0f 84 a4 02 00 00    	je     80100e03 <exec+0x353>
  sz = 0;
80100b5f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100b66:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b69:	31 ff                	xor    %edi,%edi
80100b6b:	e9 86 00 00 00       	jmp    80100bf6 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80100b70:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100b77:	75 6c                	jne    80100be5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100b79:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100b7f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100b85:	0f 82 87 00 00 00    	jb     80100c12 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100b8b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100b91:	72 7f                	jb     80100c12 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100b93:	83 ec 04             	sub    $0x4,%esp
80100b96:	50                   	push   %eax
80100b97:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100b9d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ba3:	e8 08 68 00 00       	call   801073b0 <allocuvm>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100bb1:	85 c0                	test   %eax,%eax
80100bb3:	74 5d                	je     80100c12 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100bb5:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bbb:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100bc0:	75 50                	jne    80100c12 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100bc2:	83 ec 0c             	sub    $0xc,%esp
80100bc5:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100bcb:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100bd1:	53                   	push   %ebx
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100bd9:	e8 e2 66 00 00       	call   801072c0 <loaduvm>
80100bde:	83 c4 20             	add    $0x20,%esp
80100be1:	85 c0                	test   %eax,%eax
80100be3:	78 2d                	js     80100c12 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100be5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100bec:	83 c7 01             	add    $0x1,%edi
80100bef:	83 c6 20             	add    $0x20,%esi
80100bf2:	39 f8                	cmp    %edi,%eax
80100bf4:	7e 3a                	jle    80100c30 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100bfc:	6a 20                	push   $0x20
80100bfe:	56                   	push   %esi
80100bff:	50                   	push   %eax
80100c00:	53                   	push   %ebx
80100c01:	e8 8a 0e 00 00       	call   80101a90 <readi>
80100c06:	83 c4 10             	add    $0x10,%esp
80100c09:	83 f8 20             	cmp    $0x20,%eax
80100c0c:	0f 84 5e ff ff ff    	je     80100b70 <exec+0xc0>
    freevm(pgdir);
80100c12:	83 ec 0c             	sub    $0xc,%esp
80100c15:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c1b:	e8 f0 68 00 00       	call   80107510 <freevm>
  if(ip){
80100c20:	83 c4 10             	add    $0x10,%esp
80100c23:	e9 e5 fe ff ff       	jmp    80100b0d <exec+0x5d>
80100c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c2f:	90                   	nop
  sz = PGROUNDUP(sz);
80100c30:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100c36:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100c3c:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c42:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100c48:	83 ec 0c             	sub    $0xc,%esp
80100c4b:	53                   	push   %ebx
80100c4c:	e8 bf 0d 00 00       	call   80101a10 <iunlockput>
  end_op();
80100c51:	e8 7a 21 00 00       	call   80102dd0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100c56:	83 c4 0c             	add    $0xc,%esp
80100c59:	56                   	push   %esi
80100c5a:	57                   	push   %edi
80100c5b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100c61:	57                   	push   %edi
80100c62:	e8 49 67 00 00       	call   801073b0 <allocuvm>
80100c67:	83 c4 10             	add    $0x10,%esp
80100c6a:	89 c6                	mov    %eax,%esi
80100c6c:	85 c0                	test   %eax,%eax
80100c6e:	0f 84 94 00 00 00    	je     80100d08 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c74:	83 ec 08             	sub    $0x8,%esp
80100c77:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
80100c7d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c7f:	50                   	push   %eax
80100c80:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80100c81:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100c83:	e8 a8 69 00 00       	call   80107630 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c88:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c8b:	83 c4 10             	add    $0x10,%esp
80100c8e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c94:	8b 00                	mov    (%eax),%eax
80100c96:	85 c0                	test   %eax,%eax
80100c98:	0f 84 8b 00 00 00    	je     80100d29 <exec+0x279>
80100c9e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100ca4:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100caa:	eb 23                	jmp    80100ccf <exec+0x21f>
80100cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100cb0:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100cb3:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100cba:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100cbd:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100cc3:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100cc6:	85 c0                	test   %eax,%eax
80100cc8:	74 59                	je     80100d23 <exec+0x273>
    if(argc >= MAXARG)
80100cca:	83 ff 20             	cmp    $0x20,%edi
80100ccd:	74 39                	je     80100d08 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ccf:	83 ec 0c             	sub    $0xc,%esp
80100cd2:	50                   	push   %eax
80100cd3:	e8 c8 41 00 00       	call   80104ea0 <strlen>
80100cd8:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100cda:	58                   	pop    %eax
80100cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100cde:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce1:	ff 34 b8             	push   (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ce4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ce7:	e8 b4 41 00 00       	call   80104ea0 <strlen>
80100cec:	83 c0 01             	add    $0x1,%eax
80100cef:	50                   	push   %eax
80100cf0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100cf3:	ff 34 b8             	push   (%eax,%edi,4)
80100cf6:	53                   	push   %ebx
80100cf7:	56                   	push   %esi
80100cf8:	e8 03 6b 00 00       	call   80107800 <copyout>
80100cfd:	83 c4 20             	add    $0x20,%esp
80100d00:	85 c0                	test   %eax,%eax
80100d02:	79 ac                	jns    80100cb0 <exec+0x200>
80100d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
80100d08:	83 ec 0c             	sub    $0xc,%esp
80100d0b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d11:	e8 fa 67 00 00       	call   80107510 <freevm>
80100d16:	83 c4 10             	add    $0x10,%esp
  return -1;
80100d19:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100d1e:	e9 00 fe ff ff       	jmp    80100b23 <exec+0x73>
80100d23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d29:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100d30:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100d32:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100d39:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d3d:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100d3f:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80100d42:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80100d48:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d4a:	50                   	push   %eax
80100d4b:	52                   	push   %edx
80100d4c:	53                   	push   %ebx
80100d4d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80100d53:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100d5a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100d5d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100d63:	e8 98 6a 00 00       	call   80107800 <copyout>
80100d68:	83 c4 10             	add    $0x10,%esp
80100d6b:	85 c0                	test   %eax,%eax
80100d6d:	78 99                	js     80100d08 <exec+0x258>
  for(last=s=path; *s; s++)
80100d6f:	8b 45 08             	mov    0x8(%ebp),%eax
80100d72:	8b 55 08             	mov    0x8(%ebp),%edx
80100d75:	0f b6 00             	movzbl (%eax),%eax
80100d78:	84 c0                	test   %al,%al
80100d7a:	74 13                	je     80100d8f <exec+0x2df>
80100d7c:	89 d1                	mov    %edx,%ecx
80100d7e:	66 90                	xchg   %ax,%ax
      last = s+1;
80100d80:	83 c1 01             	add    $0x1,%ecx
80100d83:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100d85:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100d88:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100d8b:	84 c0                	test   %al,%al
80100d8d:	75 f1                	jne    80100d80 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100d8f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80100d95:	83 ec 04             	sub    $0x4,%esp
80100d98:	6a 10                	push   $0x10
80100d9a:	89 f8                	mov    %edi,%eax
80100d9c:	52                   	push   %edx
80100d9d:	83 c0 6c             	add    $0x6c,%eax
80100da0:	50                   	push   %eax
80100da1:	e8 ba 40 00 00       	call   80104e60 <safestrcpy>
  curproc->pgdir = pgdir;
80100da6:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100dac:	89 f8                	mov    %edi,%eax
80100dae:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80100db1:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80100db3:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100db6:	89 c1                	mov    %eax,%ecx
80100db8:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100dbe:	8b 40 18             	mov    0x18(%eax),%eax
80100dc1:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100dc4:	8b 41 18             	mov    0x18(%ecx),%eax
80100dc7:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100dca:	89 0c 24             	mov    %ecx,(%esp)
80100dcd:	e8 5e 63 00 00       	call   80107130 <switchuvm>
  freevm(oldpgdir);
80100dd2:	89 3c 24             	mov    %edi,(%esp)
80100dd5:	e8 36 67 00 00       	call   80107510 <freevm>
  return 0;
80100dda:	83 c4 10             	add    $0x10,%esp
80100ddd:	31 c0                	xor    %eax,%eax
80100ddf:	e9 3f fd ff ff       	jmp    80100b23 <exec+0x73>
    end_op();
80100de4:	e8 e7 1f 00 00       	call   80102dd0 <end_op>
    cprintf("exec: fail\n");
80100de9:	83 ec 0c             	sub    $0xc,%esp
80100dec:	68 61 79 10 80       	push   $0x80107961
80100df1:	e8 aa f8 ff ff       	call   801006a0 <cprintf>
    return -1;
80100df6:	83 c4 10             	add    $0x10,%esp
80100df9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100dfe:	e9 20 fd ff ff       	jmp    80100b23 <exec+0x73>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e03:	be 00 20 00 00       	mov    $0x2000,%esi
80100e08:	31 ff                	xor    %edi,%edi
80100e0a:	e9 39 fe ff ff       	jmp    80100c48 <exec+0x198>
80100e0f:	90                   	nop

80100e10 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100e16:	68 6d 79 10 80       	push   $0x8010796d
80100e1b:	68 60 ff 10 80       	push   $0x8010ff60
80100e20:	e8 eb 3b 00 00       	call   80104a10 <initlock>
}
80100e25:	83 c4 10             	add    $0x10,%esp
80100e28:	c9                   	leave  
80100e29:	c3                   	ret    
80100e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e30 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100e30:	55                   	push   %ebp
80100e31:	89 e5                	mov    %esp,%ebp
80100e33:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e34:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
80100e39:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100e3c:	68 60 ff 10 80       	push   $0x8010ff60
80100e41:	e8 9a 3d 00 00       	call   80104be0 <acquire>
80100e46:	83 c4 10             	add    $0x10,%esp
80100e49:	eb 10                	jmp    80100e5b <filealloc+0x2b>
80100e4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e4f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100e50:	83 c3 18             	add    $0x18,%ebx
80100e53:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80100e59:	74 25                	je     80100e80 <filealloc+0x50>
    if(f->ref == 0){
80100e5b:	8b 43 04             	mov    0x4(%ebx),%eax
80100e5e:	85 c0                	test   %eax,%eax
80100e60:	75 ee                	jne    80100e50 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100e62:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100e65:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100e6c:	68 60 ff 10 80       	push   $0x8010ff60
80100e71:	e8 0a 3d 00 00       	call   80104b80 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100e76:	89 d8                	mov    %ebx,%eax
      return f;
80100e78:	83 c4 10             	add    $0x10,%esp
}
80100e7b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e7e:	c9                   	leave  
80100e7f:	c3                   	ret    
  release(&ftable.lock);
80100e80:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100e83:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100e85:	68 60 ff 10 80       	push   $0x8010ff60
80100e8a:	e8 f1 3c 00 00       	call   80104b80 <release>
}
80100e8f:	89 d8                	mov    %ebx,%eax
  return 0;
80100e91:	83 c4 10             	add    $0x10,%esp
}
80100e94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e97:	c9                   	leave  
80100e98:	c3                   	ret    
80100e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ea0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100ea0:	55                   	push   %ebp
80100ea1:	89 e5                	mov    %esp,%ebp
80100ea3:	53                   	push   %ebx
80100ea4:	83 ec 10             	sub    $0x10,%esp
80100ea7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100eaa:	68 60 ff 10 80       	push   $0x8010ff60
80100eaf:	e8 2c 3d 00 00       	call   80104be0 <acquire>
  if(f->ref < 1)
80100eb4:	8b 43 04             	mov    0x4(%ebx),%eax
80100eb7:	83 c4 10             	add    $0x10,%esp
80100eba:	85 c0                	test   %eax,%eax
80100ebc:	7e 1a                	jle    80100ed8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100ebe:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100ec1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100ec4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100ec7:	68 60 ff 10 80       	push   $0x8010ff60
80100ecc:	e8 af 3c 00 00       	call   80104b80 <release>
  return f;
}
80100ed1:	89 d8                	mov    %ebx,%eax
80100ed3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100ed6:	c9                   	leave  
80100ed7:	c3                   	ret    
    panic("filedup");
80100ed8:	83 ec 0c             	sub    $0xc,%esp
80100edb:	68 74 79 10 80       	push   $0x80107974
80100ee0:	e8 9b f4 ff ff       	call   80100380 <panic>
80100ee5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ef0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100ef0:	55                   	push   %ebp
80100ef1:	89 e5                	mov    %esp,%ebp
80100ef3:	57                   	push   %edi
80100ef4:	56                   	push   %esi
80100ef5:	53                   	push   %ebx
80100ef6:	83 ec 28             	sub    $0x28,%esp
80100ef9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100efc:	68 60 ff 10 80       	push   $0x8010ff60
80100f01:	e8 da 3c 00 00       	call   80104be0 <acquire>
  if(f->ref < 1)
80100f06:	8b 53 04             	mov    0x4(%ebx),%edx
80100f09:	83 c4 10             	add    $0x10,%esp
80100f0c:	85 d2                	test   %edx,%edx
80100f0e:	0f 8e a5 00 00 00    	jle    80100fb9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80100f14:	83 ea 01             	sub    $0x1,%edx
80100f17:	89 53 04             	mov    %edx,0x4(%ebx)
80100f1a:	75 44                	jne    80100f60 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100f1c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100f20:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100f23:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80100f25:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100f2b:	8b 73 0c             	mov    0xc(%ebx),%esi
80100f2e:	88 45 e7             	mov    %al,-0x19(%ebp)
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100f34:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
80100f39:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100f3c:	e8 3f 3c 00 00       	call   80104b80 <release>

  if(ff.type == FD_PIPE)
80100f41:	83 c4 10             	add    $0x10,%esp
80100f44:	83 ff 01             	cmp    $0x1,%edi
80100f47:	74 57                	je     80100fa0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100f49:	83 ff 02             	cmp    $0x2,%edi
80100f4c:	74 2a                	je     80100f78 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100f4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f51:	5b                   	pop    %ebx
80100f52:	5e                   	pop    %esi
80100f53:	5f                   	pop    %edi
80100f54:	5d                   	pop    %ebp
80100f55:	c3                   	ret    
80100f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f5d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80100f60:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80100f67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f6a:	5b                   	pop    %ebx
80100f6b:	5e                   	pop    %esi
80100f6c:	5f                   	pop    %edi
80100f6d:	5d                   	pop    %ebp
    release(&ftable.lock);
80100f6e:	e9 0d 3c 00 00       	jmp    80104b80 <release>
80100f73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100f77:	90                   	nop
    begin_op();
80100f78:	e8 e3 1d 00 00       	call   80102d60 <begin_op>
    iput(ff.ip);
80100f7d:	83 ec 0c             	sub    $0xc,%esp
80100f80:	ff 75 e0             	push   -0x20(%ebp)
80100f83:	e8 28 09 00 00       	call   801018b0 <iput>
    end_op();
80100f88:	83 c4 10             	add    $0x10,%esp
}
80100f8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8e:	5b                   	pop    %ebx
80100f8f:	5e                   	pop    %esi
80100f90:	5f                   	pop    %edi
80100f91:	5d                   	pop    %ebp
    end_op();
80100f92:	e9 39 1e 00 00       	jmp    80102dd0 <end_op>
80100f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100f9e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80100fa0:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100fa4:	83 ec 08             	sub    $0x8,%esp
80100fa7:	53                   	push   %ebx
80100fa8:	56                   	push   %esi
80100fa9:	e8 82 25 00 00       	call   80103530 <pipeclose>
80100fae:	83 c4 10             	add    $0x10,%esp
}
80100fb1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb4:	5b                   	pop    %ebx
80100fb5:	5e                   	pop    %esi
80100fb6:	5f                   	pop    %edi
80100fb7:	5d                   	pop    %ebp
80100fb8:	c3                   	ret    
    panic("fileclose");
80100fb9:	83 ec 0c             	sub    $0xc,%esp
80100fbc:	68 7c 79 10 80       	push   $0x8010797c
80100fc1:	e8 ba f3 ff ff       	call   80100380 <panic>
80100fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fcd:	8d 76 00             	lea    0x0(%esi),%esi

80100fd0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100fd0:	55                   	push   %ebp
80100fd1:	89 e5                	mov    %esp,%ebp
80100fd3:	53                   	push   %ebx
80100fd4:	83 ec 04             	sub    $0x4,%esp
80100fd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100fda:	83 3b 02             	cmpl   $0x2,(%ebx)
80100fdd:	75 31                	jne    80101010 <filestat+0x40>
    ilock(f->ip);
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	ff 73 10             	push   0x10(%ebx)
80100fe5:	e8 96 07 00 00       	call   80101780 <ilock>
    stati(f->ip, st);
80100fea:	58                   	pop    %eax
80100feb:	5a                   	pop    %edx
80100fec:	ff 75 0c             	push   0xc(%ebp)
80100fef:	ff 73 10             	push   0x10(%ebx)
80100ff2:	e8 69 0a 00 00       	call   80101a60 <stati>
    iunlock(f->ip);
80100ff7:	59                   	pop    %ecx
80100ff8:	ff 73 10             	push   0x10(%ebx)
80100ffb:	e8 60 08 00 00       	call   80101860 <iunlock>
    return 0;
  }
  return -1;
}
80101000:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101003:	83 c4 10             	add    $0x10,%esp
80101006:	31 c0                	xor    %eax,%eax
}
80101008:	c9                   	leave  
80101009:	c3                   	ret    
8010100a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101010:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101013:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101018:	c9                   	leave  
80101019:	c3                   	ret    
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101020 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	57                   	push   %edi
80101024:	56                   	push   %esi
80101025:	53                   	push   %ebx
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010102c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010102f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101032:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101036:	74 60                	je     80101098 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101038:	8b 03                	mov    (%ebx),%eax
8010103a:	83 f8 01             	cmp    $0x1,%eax
8010103d:	74 41                	je     80101080 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010103f:	83 f8 02             	cmp    $0x2,%eax
80101042:	75 5b                	jne    8010109f <fileread+0x7f>
    ilock(f->ip);
80101044:	83 ec 0c             	sub    $0xc,%esp
80101047:	ff 73 10             	push   0x10(%ebx)
8010104a:	e8 31 07 00 00       	call   80101780 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010104f:	57                   	push   %edi
80101050:	ff 73 14             	push   0x14(%ebx)
80101053:	56                   	push   %esi
80101054:	ff 73 10             	push   0x10(%ebx)
80101057:	e8 34 0a 00 00       	call   80101a90 <readi>
8010105c:	83 c4 20             	add    $0x20,%esp
8010105f:	89 c6                	mov    %eax,%esi
80101061:	85 c0                	test   %eax,%eax
80101063:	7e 03                	jle    80101068 <fileread+0x48>
      f->off += r;
80101065:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	ff 73 10             	push   0x10(%ebx)
8010106e:	e8 ed 07 00 00       	call   80101860 <iunlock>
    return r;
80101073:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101079:	89 f0                	mov    %esi,%eax
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101080:	8b 43 0c             	mov    0xc(%ebx),%eax
80101083:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101086:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101089:	5b                   	pop    %ebx
8010108a:	5e                   	pop    %esi
8010108b:	5f                   	pop    %edi
8010108c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010108d:	e9 3e 26 00 00       	jmp    801036d0 <piperead>
80101092:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101098:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010109d:	eb d7                	jmp    80101076 <fileread+0x56>
  panic("fileread");
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	68 86 79 10 80       	push   $0x80107986
801010a7:	e8 d4 f2 ff ff       	call   80100380 <panic>
801010ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801010b0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801010b0:	55                   	push   %ebp
801010b1:	89 e5                	mov    %esp,%ebp
801010b3:	57                   	push   %edi
801010b4:	56                   	push   %esi
801010b5:	53                   	push   %ebx
801010b6:	83 ec 1c             	sub    $0x1c,%esp
801010b9:	8b 45 0c             	mov    0xc(%ebp),%eax
801010bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
801010bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010c2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801010c5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801010c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801010cc:	0f 84 bd 00 00 00    	je     8010118f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
801010d2:	8b 03                	mov    (%ebx),%eax
801010d4:	83 f8 01             	cmp    $0x1,%eax
801010d7:	0f 84 bf 00 00 00    	je     8010119c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801010dd:	83 f8 02             	cmp    $0x2,%eax
801010e0:	0f 85 c8 00 00 00    	jne    801011ae <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801010e6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801010e9:	31 f6                	xor    %esi,%esi
    while(i < n){
801010eb:	85 c0                	test   %eax,%eax
801010ed:	7f 30                	jg     8010111f <filewrite+0x6f>
801010ef:	e9 94 00 00 00       	jmp    80101188 <filewrite+0xd8>
801010f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801010f8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801010fb:	83 ec 0c             	sub    $0xc,%esp
801010fe:	ff 73 10             	push   0x10(%ebx)
        f->off += r;
80101101:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101104:	e8 57 07 00 00       	call   80101860 <iunlock>
      end_op();
80101109:	e8 c2 1c 00 00       	call   80102dd0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010110e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101111:	83 c4 10             	add    $0x10,%esp
80101114:	39 c7                	cmp    %eax,%edi
80101116:	75 5c                	jne    80101174 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101118:	01 fe                	add    %edi,%esi
    while(i < n){
8010111a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010111d:	7e 69                	jle    80101188 <filewrite+0xd8>
      int n1 = n - i;
8010111f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101122:	b8 00 06 00 00       	mov    $0x600,%eax
80101127:	29 f7                	sub    %esi,%edi
80101129:	39 c7                	cmp    %eax,%edi
8010112b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010112e:	e8 2d 1c 00 00       	call   80102d60 <begin_op>
      ilock(f->ip);
80101133:	83 ec 0c             	sub    $0xc,%esp
80101136:	ff 73 10             	push   0x10(%ebx)
80101139:	e8 42 06 00 00       	call   80101780 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010113e:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101141:	57                   	push   %edi
80101142:	ff 73 14             	push   0x14(%ebx)
80101145:	01 f0                	add    %esi,%eax
80101147:	50                   	push   %eax
80101148:	ff 73 10             	push   0x10(%ebx)
8010114b:	e8 40 0a 00 00       	call   80101b90 <writei>
80101150:	83 c4 20             	add    $0x20,%esp
80101153:	85 c0                	test   %eax,%eax
80101155:	7f a1                	jg     801010f8 <filewrite+0x48>
      iunlock(f->ip);
80101157:	83 ec 0c             	sub    $0xc,%esp
8010115a:	ff 73 10             	push   0x10(%ebx)
8010115d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101160:	e8 fb 06 00 00       	call   80101860 <iunlock>
      end_op();
80101165:	e8 66 1c 00 00       	call   80102dd0 <end_op>
      if(r < 0)
8010116a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010116d:	83 c4 10             	add    $0x10,%esp
80101170:	85 c0                	test   %eax,%eax
80101172:	75 1b                	jne    8010118f <filewrite+0xdf>
        panic("short filewrite");
80101174:	83 ec 0c             	sub    $0xc,%esp
80101177:	68 8f 79 10 80       	push   $0x8010798f
8010117c:	e8 ff f1 ff ff       	call   80100380 <panic>
80101181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101188:	89 f0                	mov    %esi,%eax
8010118a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010118d:	74 05                	je     80101194 <filewrite+0xe4>
8010118f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101197:	5b                   	pop    %ebx
80101198:	5e                   	pop    %esi
80101199:	5f                   	pop    %edi
8010119a:	5d                   	pop    %ebp
8010119b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010119c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010119f:	89 45 08             	mov    %eax,0x8(%ebp)
}
801011a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a5:	5b                   	pop    %ebx
801011a6:	5e                   	pop    %esi
801011a7:	5f                   	pop    %edi
801011a8:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801011a9:	e9 22 24 00 00       	jmp    801035d0 <pipewrite>
  panic("filewrite");
801011ae:	83 ec 0c             	sub    $0xc,%esp
801011b1:	68 95 79 10 80       	push   $0x80107995
801011b6:	e8 c5 f1 ff ff       	call   80100380 <panic>
801011bb:	66 90                	xchg   %ax,%ax
801011bd:	66 90                	xchg   %ax,%ax
801011bf:	90                   	nop

801011c0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801011c0:	55                   	push   %ebp
801011c1:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801011c3:	89 d0                	mov    %edx,%eax
801011c5:	c1 e8 0c             	shr    $0xc,%eax
801011c8:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
801011ce:	89 e5                	mov    %esp,%ebp
801011d0:	56                   	push   %esi
801011d1:	53                   	push   %ebx
801011d2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801011d4:	83 ec 08             	sub    $0x8,%esp
801011d7:	50                   	push   %eax
801011d8:	51                   	push   %ecx
801011d9:	e8 f2 ee ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801011de:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801011e0:	c1 fb 03             	sar    $0x3,%ebx
801011e3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801011e6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801011e8:	83 e1 07             	and    $0x7,%ecx
801011eb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801011f0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801011f6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801011f8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801011fd:	85 c1                	test   %eax,%ecx
801011ff:	74 23                	je     80101224 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101201:	f7 d0                	not    %eax
  log_write(bp);
80101203:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101206:	21 c8                	and    %ecx,%eax
80101208:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010120c:	56                   	push   %esi
8010120d:	e8 2e 1d 00 00       	call   80102f40 <log_write>
  brelse(bp);
80101212:	89 34 24             	mov    %esi,(%esp)
80101215:	e8 d6 ef ff ff       	call   801001f0 <brelse>
}
8010121a:	83 c4 10             	add    $0x10,%esp
8010121d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101220:	5b                   	pop    %ebx
80101221:	5e                   	pop    %esi
80101222:	5d                   	pop    %ebp
80101223:	c3                   	ret    
    panic("freeing free block");
80101224:	83 ec 0c             	sub    $0xc,%esp
80101227:	68 9f 79 10 80       	push   $0x8010799f
8010122c:	e8 4f f1 ff ff       	call   80100380 <panic>
80101231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010123f:	90                   	nop

80101240 <balloc>:
{
80101240:	55                   	push   %ebp
80101241:	89 e5                	mov    %esp,%ebp
80101243:	57                   	push   %edi
80101244:	56                   	push   %esi
80101245:	53                   	push   %ebx
80101246:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101249:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
8010124f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101252:	85 c9                	test   %ecx,%ecx
80101254:	0f 84 87 00 00 00    	je     801012e1 <balloc+0xa1>
8010125a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101261:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101264:	83 ec 08             	sub    $0x8,%esp
80101267:	89 f0                	mov    %esi,%eax
80101269:	c1 f8 0c             	sar    $0xc,%eax
8010126c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101272:	50                   	push   %eax
80101273:	ff 75 d8             	push   -0x28(%ebp)
80101276:	e8 55 ee ff ff       	call   801000d0 <bread>
8010127b:	83 c4 10             	add    $0x10,%esp
8010127e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101281:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101286:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101289:	31 c0                	xor    %eax,%eax
8010128b:	eb 2f                	jmp    801012bc <balloc+0x7c>
8010128d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101290:	89 c1                	mov    %eax,%ecx
80101292:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101297:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010129a:	83 e1 07             	and    $0x7,%ecx
8010129d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010129f:	89 c1                	mov    %eax,%ecx
801012a1:	c1 f9 03             	sar    $0x3,%ecx
801012a4:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
801012a9:	89 fa                	mov    %edi,%edx
801012ab:	85 df                	test   %ebx,%edi
801012ad:	74 41                	je     801012f0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012af:	83 c0 01             	add    $0x1,%eax
801012b2:	83 c6 01             	add    $0x1,%esi
801012b5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801012ba:	74 05                	je     801012c1 <balloc+0x81>
801012bc:	39 75 e0             	cmp    %esi,-0x20(%ebp)
801012bf:	77 cf                	ja     80101290 <balloc+0x50>
    brelse(bp);
801012c1:	83 ec 0c             	sub    $0xc,%esp
801012c4:	ff 75 e4             	push   -0x1c(%ebp)
801012c7:	e8 24 ef ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801012cc:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801012d3:	83 c4 10             	add    $0x10,%esp
801012d6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801012d9:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
801012df:	77 80                	ja     80101261 <balloc+0x21>
  panic("balloc: out of blocks");
801012e1:	83 ec 0c             	sub    $0xc,%esp
801012e4:	68 b2 79 10 80       	push   $0x801079b2
801012e9:	e8 92 f0 ff ff       	call   80100380 <panic>
801012ee:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801012f0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801012f3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801012f6:	09 da                	or     %ebx,%edx
801012f8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801012fc:	57                   	push   %edi
801012fd:	e8 3e 1c 00 00       	call   80102f40 <log_write>
        brelse(bp);
80101302:	89 3c 24             	mov    %edi,(%esp)
80101305:	e8 e6 ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
8010130a:	58                   	pop    %eax
8010130b:	5a                   	pop    %edx
8010130c:	56                   	push   %esi
8010130d:	ff 75 d8             	push   -0x28(%ebp)
80101310:	e8 bb ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
80101315:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101318:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
8010131a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010131d:	68 00 02 00 00       	push   $0x200
80101322:	6a 00                	push   $0x0
80101324:	50                   	push   %eax
80101325:	e8 76 39 00 00       	call   80104ca0 <memset>
  log_write(bp);
8010132a:	89 1c 24             	mov    %ebx,(%esp)
8010132d:	e8 0e 1c 00 00       	call   80102f40 <log_write>
  brelse(bp);
80101332:	89 1c 24             	mov    %ebx,(%esp)
80101335:	e8 b6 ee ff ff       	call   801001f0 <brelse>
}
8010133a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010133d:	89 f0                	mov    %esi,%eax
8010133f:	5b                   	pop    %ebx
80101340:	5e                   	pop    %esi
80101341:	5f                   	pop    %edi
80101342:	5d                   	pop    %ebp
80101343:	c3                   	ret    
80101344:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010134f:	90                   	nop

80101350 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101350:	55                   	push   %ebp
80101351:	89 e5                	mov    %esp,%ebp
80101353:	57                   	push   %edi
80101354:	89 c7                	mov    %eax,%edi
80101356:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101357:	31 f6                	xor    %esi,%esi
{
80101359:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010135a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010135f:	83 ec 28             	sub    $0x28,%esp
80101362:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101365:	68 60 09 11 80       	push   $0x80110960
8010136a:	e8 71 38 00 00       	call   80104be0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010136f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101372:	83 c4 10             	add    $0x10,%esp
80101375:	eb 1b                	jmp    80101392 <iget+0x42>
80101377:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010137e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101380:	39 3b                	cmp    %edi,(%ebx)
80101382:	74 6c                	je     801013f0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101384:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010138a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101390:	73 26                	jae    801013b8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101392:	8b 43 08             	mov    0x8(%ebx),%eax
80101395:	85 c0                	test   %eax,%eax
80101397:	7f e7                	jg     80101380 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101399:	85 f6                	test   %esi,%esi
8010139b:	75 e7                	jne    80101384 <iget+0x34>
8010139d:	85 c0                	test   %eax,%eax
8010139f:	75 76                	jne    80101417 <iget+0xc7>
801013a1:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013a3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013a9:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801013af:	72 e1                	jb     80101392 <iget+0x42>
801013b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801013b8:	85 f6                	test   %esi,%esi
801013ba:	74 79                	je     80101435 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801013bc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801013bf:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
801013c1:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
801013c4:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801013cb:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801013d2:	68 60 09 11 80       	push   $0x80110960
801013d7:	e8 a4 37 00 00       	call   80104b80 <release>

  return ip;
801013dc:	83 c4 10             	add    $0x10,%esp
}
801013df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e2:	89 f0                	mov    %esi,%eax
801013e4:	5b                   	pop    %ebx
801013e5:	5e                   	pop    %esi
801013e6:	5f                   	pop    %edi
801013e7:	5d                   	pop    %ebp
801013e8:	c3                   	ret    
801013e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f0:	39 53 04             	cmp    %edx,0x4(%ebx)
801013f3:	75 8f                	jne    80101384 <iget+0x34>
      release(&icache.lock);
801013f5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801013f8:	83 c0 01             	add    $0x1,%eax
      return ip;
801013fb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801013fd:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
80101402:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101405:	e8 76 37 00 00       	call   80104b80 <release>
      return ip;
8010140a:	83 c4 10             	add    $0x10,%esp
}
8010140d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101410:	89 f0                	mov    %esi,%eax
80101412:	5b                   	pop    %ebx
80101413:	5e                   	pop    %esi
80101414:	5f                   	pop    %edi
80101415:	5d                   	pop    %ebp
80101416:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101417:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010141d:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101423:	73 10                	jae    80101435 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101425:	8b 43 08             	mov    0x8(%ebx),%eax
80101428:	85 c0                	test   %eax,%eax
8010142a:	0f 8f 50 ff ff ff    	jg     80101380 <iget+0x30>
80101430:	e9 68 ff ff ff       	jmp    8010139d <iget+0x4d>
    panic("iget: no inodes");
80101435:	83 ec 0c             	sub    $0xc,%esp
80101438:	68 c8 79 10 80       	push   $0x801079c8
8010143d:	e8 3e ef ff ff       	call   80100380 <panic>
80101442:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101450 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	89 c6                	mov    %eax,%esi
80101457:	53                   	push   %ebx
80101458:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010145b:	83 fa 0b             	cmp    $0xb,%edx
8010145e:	0f 86 8c 00 00 00    	jbe    801014f0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101464:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101467:	83 fb 7f             	cmp    $0x7f,%ebx
8010146a:	0f 87 a2 00 00 00    	ja     80101512 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101470:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101476:	85 c0                	test   %eax,%eax
80101478:	74 5e                	je     801014d8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010147a:	83 ec 08             	sub    $0x8,%esp
8010147d:	50                   	push   %eax
8010147e:	ff 36                	push   (%esi)
80101480:	e8 4b ec ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101485:	83 c4 10             	add    $0x10,%esp
80101488:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010148c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010148e:	8b 3b                	mov    (%ebx),%edi
80101490:	85 ff                	test   %edi,%edi
80101492:	74 1c                	je     801014b0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101494:	83 ec 0c             	sub    $0xc,%esp
80101497:	52                   	push   %edx
80101498:	e8 53 ed ff ff       	call   801001f0 <brelse>
8010149d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801014a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a3:	89 f8                	mov    %edi,%eax
801014a5:	5b                   	pop    %ebx
801014a6:	5e                   	pop    %esi
801014a7:	5f                   	pop    %edi
801014a8:	5d                   	pop    %ebp
801014a9:	c3                   	ret    
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014b0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801014b3:	8b 06                	mov    (%esi),%eax
801014b5:	e8 86 fd ff ff       	call   80101240 <balloc>
      log_write(bp);
801014ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014bd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801014c0:	89 03                	mov    %eax,(%ebx)
801014c2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801014c4:	52                   	push   %edx
801014c5:	e8 76 1a 00 00       	call   80102f40 <log_write>
801014ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801014cd:	83 c4 10             	add    $0x10,%esp
801014d0:	eb c2                	jmp    80101494 <bmap+0x44>
801014d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801014d8:	8b 06                	mov    (%esi),%eax
801014da:	e8 61 fd ff ff       	call   80101240 <balloc>
801014df:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801014e5:	eb 93                	jmp    8010147a <bmap+0x2a>
801014e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014ee:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801014f0:	8d 5a 14             	lea    0x14(%edx),%ebx
801014f3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801014f7:	85 ff                	test   %edi,%edi
801014f9:	75 a5                	jne    801014a0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801014fb:	8b 00                	mov    (%eax),%eax
801014fd:	e8 3e fd ff ff       	call   80101240 <balloc>
80101502:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101506:	89 c7                	mov    %eax,%edi
}
80101508:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010150b:	5b                   	pop    %ebx
8010150c:	89 f8                	mov    %edi,%eax
8010150e:	5e                   	pop    %esi
8010150f:	5f                   	pop    %edi
80101510:	5d                   	pop    %ebp
80101511:	c3                   	ret    
  panic("bmap: out of range");
80101512:	83 ec 0c             	sub    $0xc,%esp
80101515:	68 d8 79 10 80       	push   $0x801079d8
8010151a:	e8 61 ee ff ff       	call   80100380 <panic>
8010151f:	90                   	nop

80101520 <readsb>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	56                   	push   %esi
80101524:	53                   	push   %ebx
80101525:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101528:	83 ec 08             	sub    $0x8,%esp
8010152b:	6a 01                	push   $0x1
8010152d:	ff 75 08             	push   0x8(%ebp)
80101530:	e8 9b eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101535:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101538:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010153a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010153d:	6a 1c                	push   $0x1c
8010153f:	50                   	push   %eax
80101540:	56                   	push   %esi
80101541:	e8 fa 37 00 00       	call   80104d40 <memmove>
  brelse(bp);
80101546:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101549:	83 c4 10             	add    $0x10,%esp
}
8010154c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010154f:	5b                   	pop    %ebx
80101550:	5e                   	pop    %esi
80101551:	5d                   	pop    %ebp
  brelse(bp);
80101552:	e9 99 ec ff ff       	jmp    801001f0 <brelse>
80101557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010155e:	66 90                	xchg   %ax,%ax

80101560 <iinit>:
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	53                   	push   %ebx
80101564:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101569:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010156c:	68 eb 79 10 80       	push   $0x801079eb
80101571:	68 60 09 11 80       	push   $0x80110960
80101576:	e8 95 34 00 00       	call   80104a10 <initlock>
  for(i = 0; i < NINODE; i++) {
8010157b:	83 c4 10             	add    $0x10,%esp
8010157e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101580:	83 ec 08             	sub    $0x8,%esp
80101583:	68 f2 79 10 80       	push   $0x801079f2
80101588:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101589:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010158f:	e8 4c 33 00 00       	call   801048e0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101594:	83 c4 10             	add    $0x10,%esp
80101597:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
8010159d:	75 e1                	jne    80101580 <iinit+0x20>
  bp = bread(dev, 1);
8010159f:	83 ec 08             	sub    $0x8,%esp
801015a2:	6a 01                	push   $0x1
801015a4:	ff 75 08             	push   0x8(%ebp)
801015a7:	e8 24 eb ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801015ac:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801015af:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801015b1:	8d 40 5c             	lea    0x5c(%eax),%eax
801015b4:	6a 1c                	push   $0x1c
801015b6:	50                   	push   %eax
801015b7:	68 b4 25 11 80       	push   $0x801125b4
801015bc:	e8 7f 37 00 00       	call   80104d40 <memmove>
  brelse(bp);
801015c1:	89 1c 24             	mov    %ebx,(%esp)
801015c4:	e8 27 ec ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801015c9:	ff 35 cc 25 11 80    	push   0x801125cc
801015cf:	ff 35 c8 25 11 80    	push   0x801125c8
801015d5:	ff 35 c4 25 11 80    	push   0x801125c4
801015db:	ff 35 c0 25 11 80    	push   0x801125c0
801015e1:	ff 35 bc 25 11 80    	push   0x801125bc
801015e7:	ff 35 b8 25 11 80    	push   0x801125b8
801015ed:	ff 35 b4 25 11 80    	push   0x801125b4
801015f3:	68 58 7a 10 80       	push   $0x80107a58
801015f8:	e8 a3 f0 ff ff       	call   801006a0 <cprintf>
}
801015fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101600:	83 c4 30             	add    $0x30,%esp
80101603:	c9                   	leave  
80101604:	c3                   	ret    
80101605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010160c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101610 <ialloc>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
80101614:	56                   	push   %esi
80101615:	53                   	push   %ebx
80101616:	83 ec 1c             	sub    $0x1c,%esp
80101619:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010161c:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101623:	8b 75 08             	mov    0x8(%ebp),%esi
80101626:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101629:	0f 86 91 00 00 00    	jbe    801016c0 <ialloc+0xb0>
8010162f:	bf 01 00 00 00       	mov    $0x1,%edi
80101634:	eb 21                	jmp    80101657 <ialloc+0x47>
80101636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010163d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101640:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101643:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101646:	53                   	push   %ebx
80101647:	e8 a4 eb ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010164c:	83 c4 10             	add    $0x10,%esp
8010164f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101655:	73 69                	jae    801016c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101657:	89 f8                	mov    %edi,%eax
80101659:	83 ec 08             	sub    $0x8,%esp
8010165c:	c1 e8 03             	shr    $0x3,%eax
8010165f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101665:	50                   	push   %eax
80101666:	56                   	push   %esi
80101667:	e8 64 ea ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010166c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010166f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101671:	89 f8                	mov    %edi,%eax
80101673:	83 e0 07             	and    $0x7,%eax
80101676:	c1 e0 06             	shl    $0x6,%eax
80101679:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010167d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101681:	75 bd                	jne    80101640 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101683:	83 ec 04             	sub    $0x4,%esp
80101686:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101689:	6a 40                	push   $0x40
8010168b:	6a 00                	push   $0x0
8010168d:	51                   	push   %ecx
8010168e:	e8 0d 36 00 00       	call   80104ca0 <memset>
      dip->type = type;
80101693:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101697:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010169a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010169d:	89 1c 24             	mov    %ebx,(%esp)
801016a0:	e8 9b 18 00 00       	call   80102f40 <log_write>
      brelse(bp);
801016a5:	89 1c 24             	mov    %ebx,(%esp)
801016a8:	e8 43 eb ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801016ad:	83 c4 10             	add    $0x10,%esp
}
801016b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801016b3:	89 fa                	mov    %edi,%edx
}
801016b5:	5b                   	pop    %ebx
      return iget(dev, inum);
801016b6:	89 f0                	mov    %esi,%eax
}
801016b8:	5e                   	pop    %esi
801016b9:	5f                   	pop    %edi
801016ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801016bb:	e9 90 fc ff ff       	jmp    80101350 <iget>
  panic("ialloc: no inodes");
801016c0:	83 ec 0c             	sub    $0xc,%esp
801016c3:	68 f8 79 10 80       	push   $0x801079f8
801016c8:	e8 b3 ec ff ff       	call   80100380 <panic>
801016cd:	8d 76 00             	lea    0x0(%esi),%esi

801016d0 <iupdate>:
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	56                   	push   %esi
801016d4:	53                   	push   %ebx
801016d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016db:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016de:	83 ec 08             	sub    $0x8,%esp
801016e1:	c1 e8 03             	shr    $0x3,%eax
801016e4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801016ea:	50                   	push   %eax
801016eb:	ff 73 a4             	push   -0x5c(%ebx)
801016ee:	e8 dd e9 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801016f3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801016f7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016fa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801016fc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801016ff:	83 e0 07             	and    $0x7,%eax
80101702:	c1 e0 06             	shl    $0x6,%eax
80101705:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101709:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010170c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101710:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101713:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101717:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010171b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010171f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101723:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101727:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010172a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010172d:	6a 34                	push   $0x34
8010172f:	53                   	push   %ebx
80101730:	50                   	push   %eax
80101731:	e8 0a 36 00 00       	call   80104d40 <memmove>
  log_write(bp);
80101736:	89 34 24             	mov    %esi,(%esp)
80101739:	e8 02 18 00 00       	call   80102f40 <log_write>
  brelse(bp);
8010173e:	89 75 08             	mov    %esi,0x8(%ebp)
80101741:	83 c4 10             	add    $0x10,%esp
}
80101744:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101747:	5b                   	pop    %ebx
80101748:	5e                   	pop    %esi
80101749:	5d                   	pop    %ebp
  brelse(bp);
8010174a:	e9 a1 ea ff ff       	jmp    801001f0 <brelse>
8010174f:	90                   	nop

80101750 <idup>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	53                   	push   %ebx
80101754:	83 ec 10             	sub    $0x10,%esp
80101757:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010175a:	68 60 09 11 80       	push   $0x80110960
8010175f:	e8 7c 34 00 00       	call   80104be0 <acquire>
  ip->ref++;
80101764:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101768:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010176f:	e8 0c 34 00 00       	call   80104b80 <release>
}
80101774:	89 d8                	mov    %ebx,%eax
80101776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101779:	c9                   	leave  
8010177a:	c3                   	ret    
8010177b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010177f:	90                   	nop

80101780 <ilock>:
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	56                   	push   %esi
80101784:	53                   	push   %ebx
80101785:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101788:	85 db                	test   %ebx,%ebx
8010178a:	0f 84 b7 00 00 00    	je     80101847 <ilock+0xc7>
80101790:	8b 53 08             	mov    0x8(%ebx),%edx
80101793:	85 d2                	test   %edx,%edx
80101795:	0f 8e ac 00 00 00    	jle    80101847 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010179b:	83 ec 0c             	sub    $0xc,%esp
8010179e:	8d 43 0c             	lea    0xc(%ebx),%eax
801017a1:	50                   	push   %eax
801017a2:	e8 79 31 00 00       	call   80104920 <acquiresleep>
  if(ip->valid == 0){
801017a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801017aa:	83 c4 10             	add    $0x10,%esp
801017ad:	85 c0                	test   %eax,%eax
801017af:	74 0f                	je     801017c0 <ilock+0x40>
}
801017b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017b4:	5b                   	pop    %ebx
801017b5:	5e                   	pop    %esi
801017b6:	5d                   	pop    %ebp
801017b7:	c3                   	ret    
801017b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017bf:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c0:	8b 43 04             	mov    0x4(%ebx),%eax
801017c3:	83 ec 08             	sub    $0x8,%esp
801017c6:	c1 e8 03             	shr    $0x3,%eax
801017c9:	03 05 c8 25 11 80    	add    0x801125c8,%eax
801017cf:	50                   	push   %eax
801017d0:	ff 33                	push   (%ebx)
801017d2:	e8 f9 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017d7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017da:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801017dc:	8b 43 04             	mov    0x4(%ebx),%eax
801017df:	83 e0 07             	and    $0x7,%eax
801017e2:	c1 e0 06             	shl    $0x6,%eax
801017e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801017e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801017ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801017ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801017f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801017f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801017fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801017ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101803:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101807:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010180b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010180e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101811:	6a 34                	push   $0x34
80101813:	50                   	push   %eax
80101814:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101817:	50                   	push   %eax
80101818:	e8 23 35 00 00       	call   80104d40 <memmove>
    brelse(bp);
8010181d:	89 34 24             	mov    %esi,(%esp)
80101820:	e8 cb e9 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101825:	83 c4 10             	add    $0x10,%esp
80101828:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010182d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101834:	0f 85 77 ff ff ff    	jne    801017b1 <ilock+0x31>
      panic("ilock: no type");
8010183a:	83 ec 0c             	sub    $0xc,%esp
8010183d:	68 10 7a 10 80       	push   $0x80107a10
80101842:	e8 39 eb ff ff       	call   80100380 <panic>
    panic("ilock");
80101847:	83 ec 0c             	sub    $0xc,%esp
8010184a:	68 0a 7a 10 80       	push   $0x80107a0a
8010184f:	e8 2c eb ff ff       	call   80100380 <panic>
80101854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010185b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010185f:	90                   	nop

80101860 <iunlock>:
{
80101860:	55                   	push   %ebp
80101861:	89 e5                	mov    %esp,%ebp
80101863:	56                   	push   %esi
80101864:	53                   	push   %ebx
80101865:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101868:	85 db                	test   %ebx,%ebx
8010186a:	74 28                	je     80101894 <iunlock+0x34>
8010186c:	83 ec 0c             	sub    $0xc,%esp
8010186f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101872:	56                   	push   %esi
80101873:	e8 48 31 00 00       	call   801049c0 <holdingsleep>
80101878:	83 c4 10             	add    $0x10,%esp
8010187b:	85 c0                	test   %eax,%eax
8010187d:	74 15                	je     80101894 <iunlock+0x34>
8010187f:	8b 43 08             	mov    0x8(%ebx),%eax
80101882:	85 c0                	test   %eax,%eax
80101884:	7e 0e                	jle    80101894 <iunlock+0x34>
  releasesleep(&ip->lock);
80101886:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101889:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010188c:	5b                   	pop    %ebx
8010188d:	5e                   	pop    %esi
8010188e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010188f:	e9 ec 30 00 00       	jmp    80104980 <releasesleep>
    panic("iunlock");
80101894:	83 ec 0c             	sub    $0xc,%esp
80101897:	68 1f 7a 10 80       	push   $0x80107a1f
8010189c:	e8 df ea ff ff       	call   80100380 <panic>
801018a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018af:	90                   	nop

801018b0 <iput>:
{
801018b0:	55                   	push   %ebp
801018b1:	89 e5                	mov    %esp,%ebp
801018b3:	57                   	push   %edi
801018b4:	56                   	push   %esi
801018b5:	53                   	push   %ebx
801018b6:	83 ec 28             	sub    $0x28,%esp
801018b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801018bc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801018bf:	57                   	push   %edi
801018c0:	e8 5b 30 00 00       	call   80104920 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801018c5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801018c8:	83 c4 10             	add    $0x10,%esp
801018cb:	85 d2                	test   %edx,%edx
801018cd:	74 07                	je     801018d6 <iput+0x26>
801018cf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801018d4:	74 32                	je     80101908 <iput+0x58>
  releasesleep(&ip->lock);
801018d6:	83 ec 0c             	sub    $0xc,%esp
801018d9:	57                   	push   %edi
801018da:	e8 a1 30 00 00       	call   80104980 <releasesleep>
  acquire(&icache.lock);
801018df:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
801018e6:	e8 f5 32 00 00       	call   80104be0 <acquire>
  ip->ref--;
801018eb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801018ef:	83 c4 10             	add    $0x10,%esp
801018f2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
801018f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018fc:	5b                   	pop    %ebx
801018fd:	5e                   	pop    %esi
801018fe:	5f                   	pop    %edi
801018ff:	5d                   	pop    %ebp
  release(&icache.lock);
80101900:	e9 7b 32 00 00       	jmp    80104b80 <release>
80101905:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	68 60 09 11 80       	push   $0x80110960
80101910:	e8 cb 32 00 00       	call   80104be0 <acquire>
    int r = ip->ref;
80101915:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101918:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010191f:	e8 5c 32 00 00       	call   80104b80 <release>
    if(r == 1){
80101924:	83 c4 10             	add    $0x10,%esp
80101927:	83 fe 01             	cmp    $0x1,%esi
8010192a:	75 aa                	jne    801018d6 <iput+0x26>
8010192c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101932:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101935:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101938:	89 cf                	mov    %ecx,%edi
8010193a:	eb 0b                	jmp    80101947 <iput+0x97>
8010193c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101940:	83 c6 04             	add    $0x4,%esi
80101943:	39 fe                	cmp    %edi,%esi
80101945:	74 19                	je     80101960 <iput+0xb0>
    if(ip->addrs[i]){
80101947:	8b 16                	mov    (%esi),%edx
80101949:	85 d2                	test   %edx,%edx
8010194b:	74 f3                	je     80101940 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010194d:	8b 03                	mov    (%ebx),%eax
8010194f:	e8 6c f8 ff ff       	call   801011c0 <bfree>
      ip->addrs[i] = 0;
80101954:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010195a:	eb e4                	jmp    80101940 <iput+0x90>
8010195c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101960:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101966:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101969:	85 c0                	test   %eax,%eax
8010196b:	75 2d                	jne    8010199a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010196d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101970:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101977:	53                   	push   %ebx
80101978:	e8 53 fd ff ff       	call   801016d0 <iupdate>
      ip->type = 0;
8010197d:	31 c0                	xor    %eax,%eax
8010197f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101983:	89 1c 24             	mov    %ebx,(%esp)
80101986:	e8 45 fd ff ff       	call   801016d0 <iupdate>
      ip->valid = 0;
8010198b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101992:	83 c4 10             	add    $0x10,%esp
80101995:	e9 3c ff ff ff       	jmp    801018d6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
8010199a:	83 ec 08             	sub    $0x8,%esp
8010199d:	50                   	push   %eax
8010199e:	ff 33                	push   (%ebx)
801019a0:	e8 2b e7 ff ff       	call   801000d0 <bread>
801019a5:	89 7d e0             	mov    %edi,-0x20(%ebp)
801019a8:	83 c4 10             	add    $0x10,%esp
801019ab:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801019b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
801019b4:	8d 70 5c             	lea    0x5c(%eax),%esi
801019b7:	89 cf                	mov    %ecx,%edi
801019b9:	eb 0c                	jmp    801019c7 <iput+0x117>
801019bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019bf:	90                   	nop
801019c0:	83 c6 04             	add    $0x4,%esi
801019c3:	39 f7                	cmp    %esi,%edi
801019c5:	74 0f                	je     801019d6 <iput+0x126>
      if(a[j])
801019c7:	8b 16                	mov    (%esi),%edx
801019c9:	85 d2                	test   %edx,%edx
801019cb:	74 f3                	je     801019c0 <iput+0x110>
        bfree(ip->dev, a[j]);
801019cd:	8b 03                	mov    (%ebx),%eax
801019cf:	e8 ec f7 ff ff       	call   801011c0 <bfree>
801019d4:	eb ea                	jmp    801019c0 <iput+0x110>
    brelse(bp);
801019d6:	83 ec 0c             	sub    $0xc,%esp
801019d9:	ff 75 e4             	push   -0x1c(%ebp)
801019dc:	8b 7d e0             	mov    -0x20(%ebp),%edi
801019df:	e8 0c e8 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801019e4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801019ea:	8b 03                	mov    (%ebx),%eax
801019ec:	e8 cf f7 ff ff       	call   801011c0 <bfree>
    ip->addrs[NDIRECT] = 0;
801019f1:	83 c4 10             	add    $0x10,%esp
801019f4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
801019fb:	00 00 00 
801019fe:	e9 6a ff ff ff       	jmp    8010196d <iput+0xbd>
80101a03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101a10 <iunlockput>:
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	56                   	push   %esi
80101a14:	53                   	push   %ebx
80101a15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a18:	85 db                	test   %ebx,%ebx
80101a1a:	74 34                	je     80101a50 <iunlockput+0x40>
80101a1c:	83 ec 0c             	sub    $0xc,%esp
80101a1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a22:	56                   	push   %esi
80101a23:	e8 98 2f 00 00       	call   801049c0 <holdingsleep>
80101a28:	83 c4 10             	add    $0x10,%esp
80101a2b:	85 c0                	test   %eax,%eax
80101a2d:	74 21                	je     80101a50 <iunlockput+0x40>
80101a2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a32:	85 c0                	test   %eax,%eax
80101a34:	7e 1a                	jle    80101a50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101a36:	83 ec 0c             	sub    $0xc,%esp
80101a39:	56                   	push   %esi
80101a3a:	e8 41 2f 00 00       	call   80104980 <releasesleep>
  iput(ip);
80101a3f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a42:	83 c4 10             	add    $0x10,%esp
}
80101a45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a48:	5b                   	pop    %ebx
80101a49:	5e                   	pop    %esi
80101a4a:	5d                   	pop    %ebp
  iput(ip);
80101a4b:	e9 60 fe ff ff       	jmp    801018b0 <iput>
    panic("iunlock");
80101a50:	83 ec 0c             	sub    $0xc,%esp
80101a53:	68 1f 7a 10 80       	push   $0x80107a1f
80101a58:	e8 23 e9 ff ff       	call   80100380 <panic>
80101a5d:	8d 76 00             	lea    0x0(%esi),%esi

80101a60 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	8b 55 08             	mov    0x8(%ebp),%edx
80101a66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101a69:	8b 0a                	mov    (%edx),%ecx
80101a6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101a6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101a71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101a74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101a78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101a7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101a7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101a83:	8b 52 58             	mov    0x58(%edx),%edx
80101a86:	89 50 10             	mov    %edx,0x10(%eax)
}
80101a89:	5d                   	pop    %ebp
80101a8a:	c3                   	ret    
80101a8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101a8f:	90                   	nop

80101a90 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101a90:	55                   	push   %ebp
80101a91:	89 e5                	mov    %esp,%ebp
80101a93:	57                   	push   %edi
80101a94:	56                   	push   %esi
80101a95:	53                   	push   %ebx
80101a96:	83 ec 1c             	sub    $0x1c,%esp
80101a99:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a9c:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9f:	8b 75 10             	mov    0x10(%ebp),%esi
80101aa2:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101aa5:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101aa8:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101aad:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101ab0:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101ab3:	0f 84 a7 00 00 00    	je     80101b60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ab9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101abc:	8b 40 58             	mov    0x58(%eax),%eax
80101abf:	39 c6                	cmp    %eax,%esi
80101ac1:	0f 87 ba 00 00 00    	ja     80101b81 <readi+0xf1>
80101ac7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101aca:	31 c9                	xor    %ecx,%ecx
80101acc:	89 da                	mov    %ebx,%edx
80101ace:	01 f2                	add    %esi,%edx
80101ad0:	0f 92 c1             	setb   %cl
80101ad3:	89 cf                	mov    %ecx,%edi
80101ad5:	0f 82 a6 00 00 00    	jb     80101b81 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101adb:	89 c1                	mov    %eax,%ecx
80101add:	29 f1                	sub    %esi,%ecx
80101adf:	39 d0                	cmp    %edx,%eax
80101ae1:	0f 43 cb             	cmovae %ebx,%ecx
80101ae4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ae7:	85 c9                	test   %ecx,%ecx
80101ae9:	74 67                	je     80101b52 <readi+0xc2>
80101aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101aef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101af3:	89 f2                	mov    %esi,%edx
80101af5:	c1 ea 09             	shr    $0x9,%edx
80101af8:	89 d8                	mov    %ebx,%eax
80101afa:	e8 51 f9 ff ff       	call   80101450 <bmap>
80101aff:	83 ec 08             	sub    $0x8,%esp
80101b02:	50                   	push   %eax
80101b03:	ff 33                	push   (%ebx)
80101b05:	e8 c6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101b0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101b0d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b12:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101b14:	89 f0                	mov    %esi,%eax
80101b16:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b1b:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b1d:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101b20:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101b22:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b26:	39 d9                	cmp    %ebx,%ecx
80101b28:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101b2b:	83 c4 0c             	add    $0xc,%esp
80101b2e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b2f:	01 df                	add    %ebx,%edi
80101b31:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101b33:	50                   	push   %eax
80101b34:	ff 75 e0             	push   -0x20(%ebp)
80101b37:	e8 04 32 00 00       	call   80104d40 <memmove>
    brelse(bp);
80101b3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101b3f:	89 14 24             	mov    %edx,(%esp)
80101b42:	e8 a9 e6 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101b47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b4a:	83 c4 10             	add    $0x10,%esp
80101b4d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101b50:	77 9e                	ja     80101af0 <readi+0x60>
  }
  return n;
80101b52:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b58:	5b                   	pop    %ebx
80101b59:	5e                   	pop    %esi
80101b5a:	5f                   	pop    %edi
80101b5b:	5d                   	pop    %ebp
80101b5c:	c3                   	ret    
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101b60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b64:	66 83 f8 09          	cmp    $0x9,%ax
80101b68:	77 17                	ja     80101b81 <readi+0xf1>
80101b6a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 0c                	je     80101b81 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101b75:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b7b:	5b                   	pop    %ebx
80101b7c:	5e                   	pop    %esi
80101b7d:	5f                   	pop    %edi
80101b7e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101b7f:	ff e0                	jmp    *%eax
      return -1;
80101b81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b86:	eb cd                	jmp    80101b55 <readi+0xc5>
80101b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b8f:	90                   	nop

80101b90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	57                   	push   %edi
80101b94:	56                   	push   %esi
80101b95:	53                   	push   %ebx
80101b96:	83 ec 1c             	sub    $0x1c,%esp
80101b99:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101b9f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ba2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101ba7:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101baa:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101bad:	8b 75 10             	mov    0x10(%ebp),%esi
80101bb0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80101bb3:	0f 84 b7 00 00 00    	je     80101c70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101bb9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101bbc:	3b 70 58             	cmp    0x58(%eax),%esi
80101bbf:	0f 87 e7 00 00 00    	ja     80101cac <writei+0x11c>
80101bc5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101bc8:	31 d2                	xor    %edx,%edx
80101bca:	89 f8                	mov    %edi,%eax
80101bcc:	01 f0                	add    %esi,%eax
80101bce:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101bd1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101bd6:	0f 87 d0 00 00 00    	ja     80101cac <writei+0x11c>
80101bdc:	85 d2                	test   %edx,%edx
80101bde:	0f 85 c8 00 00 00    	jne    80101cac <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101be4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101beb:	85 ff                	test   %edi,%edi
80101bed:	74 72                	je     80101c61 <writei+0xd1>
80101bef:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bf0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101bf3:	89 f2                	mov    %esi,%edx
80101bf5:	c1 ea 09             	shr    $0x9,%edx
80101bf8:	89 f8                	mov    %edi,%eax
80101bfa:	e8 51 f8 ff ff       	call   80101450 <bmap>
80101bff:	83 ec 08             	sub    $0x8,%esp
80101c02:	50                   	push   %eax
80101c03:	ff 37                	push   (%edi)
80101c05:	e8 c6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101c0a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101c0f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101c12:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c15:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101c17:	89 f0                	mov    %esi,%eax
80101c19:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c1e:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101c20:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c24:	39 d9                	cmp    %ebx,%ecx
80101c26:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101c29:	83 c4 0c             	add    $0xc,%esp
80101c2c:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c2d:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101c2f:	ff 75 dc             	push   -0x24(%ebp)
80101c32:	50                   	push   %eax
80101c33:	e8 08 31 00 00       	call   80104d40 <memmove>
    log_write(bp);
80101c38:	89 3c 24             	mov    %edi,(%esp)
80101c3b:	e8 00 13 00 00       	call   80102f40 <log_write>
    brelse(bp);
80101c40:	89 3c 24             	mov    %edi,(%esp)
80101c43:	e8 a8 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101c48:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101c4b:	83 c4 10             	add    $0x10,%esp
80101c4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101c51:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101c54:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101c57:	77 97                	ja     80101bf0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101c59:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101c5c:	3b 70 58             	cmp    0x58(%eax),%esi
80101c5f:	77 37                	ja     80101c98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c61:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c67:	5b                   	pop    %ebx
80101c68:	5e                   	pop    %esi
80101c69:	5f                   	pop    %edi
80101c6a:	5d                   	pop    %ebp
80101c6b:	c3                   	ret    
80101c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101c74:	66 83 f8 09          	cmp    $0x9,%ax
80101c78:	77 32                	ja     80101cac <writei+0x11c>
80101c7a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80101c81:	85 c0                	test   %eax,%eax
80101c83:	74 27                	je     80101cac <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80101c85:	89 55 10             	mov    %edx,0x10(%ebp)
}
80101c88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c8b:	5b                   	pop    %ebx
80101c8c:	5e                   	pop    %esi
80101c8d:	5f                   	pop    %edi
80101c8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101c8f:	ff e0                	jmp    *%eax
80101c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101c98:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101c9b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101c9e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101ca1:	50                   	push   %eax
80101ca2:	e8 29 fa ff ff       	call   801016d0 <iupdate>
80101ca7:	83 c4 10             	add    $0x10,%esp
80101caa:	eb b5                	jmp    80101c61 <writei+0xd1>
      return -1;
80101cac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cb1:	eb b1                	jmp    80101c64 <writei+0xd4>
80101cb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101cc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101cc6:	6a 0e                	push   $0xe
80101cc8:	ff 75 0c             	push   0xc(%ebp)
80101ccb:	ff 75 08             	push   0x8(%ebp)
80101cce:	e8 dd 30 00 00       	call   80104db0 <strncmp>
}
80101cd3:	c9                   	leave  
80101cd4:	c3                   	ret    
80101cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ce0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ce0:	55                   	push   %ebp
80101ce1:	89 e5                	mov    %esp,%ebp
80101ce3:	57                   	push   %edi
80101ce4:	56                   	push   %esi
80101ce5:	53                   	push   %ebx
80101ce6:	83 ec 1c             	sub    $0x1c,%esp
80101ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101cec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101cf1:	0f 85 85 00 00 00    	jne    80101d7c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101cf7:	8b 53 58             	mov    0x58(%ebx),%edx
80101cfa:	31 ff                	xor    %edi,%edi
80101cfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101cff:	85 d2                	test   %edx,%edx
80101d01:	74 3e                	je     80101d41 <dirlookup+0x61>
80101d03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d07:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d08:	6a 10                	push   $0x10
80101d0a:	57                   	push   %edi
80101d0b:	56                   	push   %esi
80101d0c:	53                   	push   %ebx
80101d0d:	e8 7e fd ff ff       	call   80101a90 <readi>
80101d12:	83 c4 10             	add    $0x10,%esp
80101d15:	83 f8 10             	cmp    $0x10,%eax
80101d18:	75 55                	jne    80101d6f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101d1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d1f:	74 18                	je     80101d39 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101d21:	83 ec 04             	sub    $0x4,%esp
80101d24:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d27:	6a 0e                	push   $0xe
80101d29:	50                   	push   %eax
80101d2a:	ff 75 0c             	push   0xc(%ebp)
80101d2d:	e8 7e 30 00 00       	call   80104db0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101d32:	83 c4 10             	add    $0x10,%esp
80101d35:	85 c0                	test   %eax,%eax
80101d37:	74 17                	je     80101d50 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101d39:	83 c7 10             	add    $0x10,%edi
80101d3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101d3f:	72 c7                	jb     80101d08 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101d41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101d44:	31 c0                	xor    %eax,%eax
}
80101d46:	5b                   	pop    %ebx
80101d47:	5e                   	pop    %esi
80101d48:	5f                   	pop    %edi
80101d49:	5d                   	pop    %ebp
80101d4a:	c3                   	ret    
80101d4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d4f:	90                   	nop
      if(poff)
80101d50:	8b 45 10             	mov    0x10(%ebp),%eax
80101d53:	85 c0                	test   %eax,%eax
80101d55:	74 05                	je     80101d5c <dirlookup+0x7c>
        *poff = off;
80101d57:	8b 45 10             	mov    0x10(%ebp),%eax
80101d5a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101d5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d60:	8b 03                	mov    (%ebx),%eax
80101d62:	e8 e9 f5 ff ff       	call   80101350 <iget>
}
80101d67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d6a:	5b                   	pop    %ebx
80101d6b:	5e                   	pop    %esi
80101d6c:	5f                   	pop    %edi
80101d6d:	5d                   	pop    %ebp
80101d6e:	c3                   	ret    
      panic("dirlookup read");
80101d6f:	83 ec 0c             	sub    $0xc,%esp
80101d72:	68 39 7a 10 80       	push   $0x80107a39
80101d77:	e8 04 e6 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101d7c:	83 ec 0c             	sub    $0xc,%esp
80101d7f:	68 27 7a 10 80       	push   $0x80107a27
80101d84:	e8 f7 e5 ff ff       	call   80100380 <panic>
80101d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101d90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	89 c3                	mov    %eax,%ebx
80101d98:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101d9b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101d9e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101da4:	0f 84 64 01 00 00    	je     80101f0e <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101daa:	e8 e1 1b 00 00       	call   80103990 <myproc>
  acquire(&icache.lock);
80101daf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101db2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101db5:	68 60 09 11 80       	push   $0x80110960
80101dba:	e8 21 2e 00 00       	call   80104be0 <acquire>
  ip->ref++;
80101dbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101dc3:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101dca:	e8 b1 2d 00 00       	call   80104b80 <release>
80101dcf:	83 c4 10             	add    $0x10,%esp
80101dd2:	eb 07                	jmp    80101ddb <namex+0x4b>
80101dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101dd8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ddb:	0f b6 03             	movzbl (%ebx),%eax
80101dde:	3c 2f                	cmp    $0x2f,%al
80101de0:	74 f6                	je     80101dd8 <namex+0x48>
  if(*path == 0)
80101de2:	84 c0                	test   %al,%al
80101de4:	0f 84 06 01 00 00    	je     80101ef0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101dea:	0f b6 03             	movzbl (%ebx),%eax
80101ded:	84 c0                	test   %al,%al
80101def:	0f 84 10 01 00 00    	je     80101f05 <namex+0x175>
80101df5:	89 df                	mov    %ebx,%edi
80101df7:	3c 2f                	cmp    $0x2f,%al
80101df9:	0f 84 06 01 00 00    	je     80101f05 <namex+0x175>
80101dff:	90                   	nop
80101e00:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101e04:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101e07:	3c 2f                	cmp    $0x2f,%al
80101e09:	74 04                	je     80101e0f <namex+0x7f>
80101e0b:	84 c0                	test   %al,%al
80101e0d:	75 f1                	jne    80101e00 <namex+0x70>
  len = path - s;
80101e0f:	89 f8                	mov    %edi,%eax
80101e11:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101e13:	83 f8 0d             	cmp    $0xd,%eax
80101e16:	0f 8e ac 00 00 00    	jle    80101ec8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101e1c:	83 ec 04             	sub    $0x4,%esp
80101e1f:	6a 0e                	push   $0xe
80101e21:	53                   	push   %ebx
    path++;
80101e22:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
80101e24:	ff 75 e4             	push   -0x1c(%ebp)
80101e27:	e8 14 2f 00 00       	call   80104d40 <memmove>
80101e2c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101e2f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101e32:	75 0c                	jne    80101e40 <namex+0xb0>
80101e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e38:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101e3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e3e:	74 f8                	je     80101e38 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101e40:	83 ec 0c             	sub    $0xc,%esp
80101e43:	56                   	push   %esi
80101e44:	e8 37 f9 ff ff       	call   80101780 <ilock>
    if(ip->type != T_DIR){
80101e49:	83 c4 10             	add    $0x10,%esp
80101e4c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101e51:	0f 85 cd 00 00 00    	jne    80101f24 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	74 09                	je     80101e67 <namex+0xd7>
80101e5e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e61:	0f 84 22 01 00 00    	je     80101f89 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e67:	83 ec 04             	sub    $0x4,%esp
80101e6a:	6a 00                	push   $0x0
80101e6c:	ff 75 e4             	push   -0x1c(%ebp)
80101e6f:	56                   	push   %esi
80101e70:	e8 6b fe ff ff       	call   80101ce0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e75:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80101e78:	83 c4 10             	add    $0x10,%esp
80101e7b:	89 c7                	mov    %eax,%edi
80101e7d:	85 c0                	test   %eax,%eax
80101e7f:	0f 84 e1 00 00 00    	je     80101f66 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101e85:	83 ec 0c             	sub    $0xc,%esp
80101e88:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101e8b:	52                   	push   %edx
80101e8c:	e8 2f 2b 00 00       	call   801049c0 <holdingsleep>
80101e91:	83 c4 10             	add    $0x10,%esp
80101e94:	85 c0                	test   %eax,%eax
80101e96:	0f 84 30 01 00 00    	je     80101fcc <namex+0x23c>
80101e9c:	8b 56 08             	mov    0x8(%esi),%edx
80101e9f:	85 d2                	test   %edx,%edx
80101ea1:	0f 8e 25 01 00 00    	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101ea7:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101eaa:	83 ec 0c             	sub    $0xc,%esp
80101ead:	52                   	push   %edx
80101eae:	e8 cd 2a 00 00       	call   80104980 <releasesleep>
  iput(ip);
80101eb3:	89 34 24             	mov    %esi,(%esp)
80101eb6:	89 fe                	mov    %edi,%esi
80101eb8:	e8 f3 f9 ff ff       	call   801018b0 <iput>
80101ebd:	83 c4 10             	add    $0x10,%esp
80101ec0:	e9 16 ff ff ff       	jmp    80101ddb <namex+0x4b>
80101ec5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101ec8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ecb:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
80101ece:	83 ec 04             	sub    $0x4,%esp
80101ed1:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101ed4:	50                   	push   %eax
80101ed5:	53                   	push   %ebx
    name[len] = 0;
80101ed6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101ed8:	ff 75 e4             	push   -0x1c(%ebp)
80101edb:	e8 60 2e 00 00       	call   80104d40 <memmove>
    name[len] = 0;
80101ee0:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101ee3:	83 c4 10             	add    $0x10,%esp
80101ee6:	c6 02 00             	movb   $0x0,(%edx)
80101ee9:	e9 41 ff ff ff       	jmp    80101e2f <namex+0x9f>
80101eee:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ef0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101ef3:	85 c0                	test   %eax,%eax
80101ef5:	0f 85 be 00 00 00    	jne    80101fb9 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
80101efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efe:	89 f0                	mov    %esi,%eax
80101f00:	5b                   	pop    %ebx
80101f01:	5e                   	pop    %esi
80101f02:	5f                   	pop    %edi
80101f03:	5d                   	pop    %ebp
80101f04:	c3                   	ret    
  while(*path != '/' && *path != 0)
80101f05:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f08:	89 df                	mov    %ebx,%edi
80101f0a:	31 c0                	xor    %eax,%eax
80101f0c:	eb c0                	jmp    80101ece <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
80101f0e:	ba 01 00 00 00       	mov    $0x1,%edx
80101f13:	b8 01 00 00 00       	mov    $0x1,%eax
80101f18:	e8 33 f4 ff ff       	call   80101350 <iget>
80101f1d:	89 c6                	mov    %eax,%esi
80101f1f:	e9 b7 fe ff ff       	jmp    80101ddb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f24:	83 ec 0c             	sub    $0xc,%esp
80101f27:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f2a:	53                   	push   %ebx
80101f2b:	e8 90 2a 00 00       	call   801049c0 <holdingsleep>
80101f30:	83 c4 10             	add    $0x10,%esp
80101f33:	85 c0                	test   %eax,%eax
80101f35:	0f 84 91 00 00 00    	je     80101fcc <namex+0x23c>
80101f3b:	8b 46 08             	mov    0x8(%esi),%eax
80101f3e:	85 c0                	test   %eax,%eax
80101f40:	0f 8e 86 00 00 00    	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101f46:	83 ec 0c             	sub    $0xc,%esp
80101f49:	53                   	push   %ebx
80101f4a:	e8 31 2a 00 00       	call   80104980 <releasesleep>
  iput(ip);
80101f4f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101f52:	31 f6                	xor    %esi,%esi
  iput(ip);
80101f54:	e8 57 f9 ff ff       	call   801018b0 <iput>
      return 0;
80101f59:	83 c4 10             	add    $0x10,%esp
}
80101f5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f5f:	89 f0                	mov    %esi,%eax
80101f61:	5b                   	pop    %ebx
80101f62:	5e                   	pop    %esi
80101f63:	5f                   	pop    %edi
80101f64:	5d                   	pop    %ebp
80101f65:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f66:	83 ec 0c             	sub    $0xc,%esp
80101f69:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101f6c:	52                   	push   %edx
80101f6d:	e8 4e 2a 00 00       	call   801049c0 <holdingsleep>
80101f72:	83 c4 10             	add    $0x10,%esp
80101f75:	85 c0                	test   %eax,%eax
80101f77:	74 53                	je     80101fcc <namex+0x23c>
80101f79:	8b 4e 08             	mov    0x8(%esi),%ecx
80101f7c:	85 c9                	test   %ecx,%ecx
80101f7e:	7e 4c                	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101f80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101f83:	83 ec 0c             	sub    $0xc,%esp
80101f86:	52                   	push   %edx
80101f87:	eb c1                	jmp    80101f4a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f89:	83 ec 0c             	sub    $0xc,%esp
80101f8c:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101f8f:	53                   	push   %ebx
80101f90:	e8 2b 2a 00 00       	call   801049c0 <holdingsleep>
80101f95:	83 c4 10             	add    $0x10,%esp
80101f98:	85 c0                	test   %eax,%eax
80101f9a:	74 30                	je     80101fcc <namex+0x23c>
80101f9c:	8b 7e 08             	mov    0x8(%esi),%edi
80101f9f:	85 ff                	test   %edi,%edi
80101fa1:	7e 29                	jle    80101fcc <namex+0x23c>
  releasesleep(&ip->lock);
80101fa3:	83 ec 0c             	sub    $0xc,%esp
80101fa6:	53                   	push   %ebx
80101fa7:	e8 d4 29 00 00       	call   80104980 <releasesleep>
}
80101fac:	83 c4 10             	add    $0x10,%esp
}
80101faf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fb2:	89 f0                	mov    %esi,%eax
80101fb4:	5b                   	pop    %ebx
80101fb5:	5e                   	pop    %esi
80101fb6:	5f                   	pop    %edi
80101fb7:	5d                   	pop    %ebp
80101fb8:	c3                   	ret    
    iput(ip);
80101fb9:	83 ec 0c             	sub    $0xc,%esp
80101fbc:	56                   	push   %esi
    return 0;
80101fbd:	31 f6                	xor    %esi,%esi
    iput(ip);
80101fbf:	e8 ec f8 ff ff       	call   801018b0 <iput>
    return 0;
80101fc4:	83 c4 10             	add    $0x10,%esp
80101fc7:	e9 2f ff ff ff       	jmp    80101efb <namex+0x16b>
    panic("iunlock");
80101fcc:	83 ec 0c             	sub    $0xc,%esp
80101fcf:	68 1f 7a 10 80       	push   $0x80107a1f
80101fd4:	e8 a7 e3 ff ff       	call   80100380 <panic>
80101fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101fe0 <dirlink>:
{
80101fe0:	55                   	push   %ebp
80101fe1:	89 e5                	mov    %esp,%ebp
80101fe3:	57                   	push   %edi
80101fe4:	56                   	push   %esi
80101fe5:	53                   	push   %ebx
80101fe6:	83 ec 20             	sub    $0x20,%esp
80101fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101fec:	6a 00                	push   $0x0
80101fee:	ff 75 0c             	push   0xc(%ebp)
80101ff1:	53                   	push   %ebx
80101ff2:	e8 e9 fc ff ff       	call   80101ce0 <dirlookup>
80101ff7:	83 c4 10             	add    $0x10,%esp
80101ffa:	85 c0                	test   %eax,%eax
80101ffc:	75 67                	jne    80102065 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101ffe:	8b 7b 58             	mov    0x58(%ebx),%edi
80102001:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102004:	85 ff                	test   %edi,%edi
80102006:	74 29                	je     80102031 <dirlink+0x51>
80102008:	31 ff                	xor    %edi,%edi
8010200a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010200d:	eb 09                	jmp    80102018 <dirlink+0x38>
8010200f:	90                   	nop
80102010:	83 c7 10             	add    $0x10,%edi
80102013:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102016:	73 19                	jae    80102031 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102018:	6a 10                	push   $0x10
8010201a:	57                   	push   %edi
8010201b:	56                   	push   %esi
8010201c:	53                   	push   %ebx
8010201d:	e8 6e fa ff ff       	call   80101a90 <readi>
80102022:	83 c4 10             	add    $0x10,%esp
80102025:	83 f8 10             	cmp    $0x10,%eax
80102028:	75 4e                	jne    80102078 <dirlink+0x98>
    if(de.inum == 0)
8010202a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010202f:	75 df                	jne    80102010 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102031:	83 ec 04             	sub    $0x4,%esp
80102034:	8d 45 da             	lea    -0x26(%ebp),%eax
80102037:	6a 0e                	push   $0xe
80102039:	ff 75 0c             	push   0xc(%ebp)
8010203c:	50                   	push   %eax
8010203d:	e8 be 2d 00 00       	call   80104e00 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102042:	6a 10                	push   $0x10
  de.inum = inum;
80102044:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102047:	57                   	push   %edi
80102048:	56                   	push   %esi
80102049:	53                   	push   %ebx
  de.inum = inum;
8010204a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010204e:	e8 3d fb ff ff       	call   80101b90 <writei>
80102053:	83 c4 20             	add    $0x20,%esp
80102056:	83 f8 10             	cmp    $0x10,%eax
80102059:	75 2a                	jne    80102085 <dirlink+0xa5>
  return 0;
8010205b:	31 c0                	xor    %eax,%eax
}
8010205d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102060:	5b                   	pop    %ebx
80102061:	5e                   	pop    %esi
80102062:	5f                   	pop    %edi
80102063:	5d                   	pop    %ebp
80102064:	c3                   	ret    
    iput(ip);
80102065:	83 ec 0c             	sub    $0xc,%esp
80102068:	50                   	push   %eax
80102069:	e8 42 f8 ff ff       	call   801018b0 <iput>
    return -1;
8010206e:	83 c4 10             	add    $0x10,%esp
80102071:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102076:	eb e5                	jmp    8010205d <dirlink+0x7d>
      panic("dirlink read");
80102078:	83 ec 0c             	sub    $0xc,%esp
8010207b:	68 48 7a 10 80       	push   $0x80107a48
80102080:	e8 fb e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102085:	83 ec 0c             	sub    $0xc,%esp
80102088:	68 6a 80 10 80       	push   $0x8010806a
8010208d:	e8 ee e2 ff ff       	call   80100380 <panic>
80102092:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801020a0 <namei>:

struct inode*
namei(char *path)
{
801020a0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801020a1:	31 d2                	xor    %edx,%edx
{
801020a3:	89 e5                	mov    %esp,%ebp
801020a5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801020a8:	8b 45 08             	mov    0x8(%ebp),%eax
801020ab:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801020ae:	e8 dd fc ff ff       	call   80101d90 <namex>
}
801020b3:	c9                   	leave  
801020b4:	c3                   	ret    
801020b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020c0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801020c0:	55                   	push   %ebp
  return namex(path, 1, name);
801020c1:	ba 01 00 00 00       	mov    $0x1,%edx
{
801020c6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
801020c8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801020cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
801020ce:	5d                   	pop    %ebp
  return namex(path, 1, name);
801020cf:	e9 bc fc ff ff       	jmp    80101d90 <namex>
801020d4:	66 90                	xchg   %ax,%ax
801020d6:	66 90                	xchg   %ax,%ax
801020d8:	66 90                	xchg   %ax,%ax
801020da:	66 90                	xchg   %ax,%ax
801020dc:	66 90                	xchg   %ax,%ax
801020de:	66 90                	xchg   %ax,%ax

801020e0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	57                   	push   %edi
801020e4:	56                   	push   %esi
801020e5:	53                   	push   %ebx
801020e6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801020e9:	85 c0                	test   %eax,%eax
801020eb:	0f 84 b4 00 00 00    	je     801021a5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801020f1:	8b 70 08             	mov    0x8(%eax),%esi
801020f4:	89 c3                	mov    %eax,%ebx
801020f6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801020fc:	0f 87 96 00 00 00    	ja     80102198 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102102:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010210e:	66 90                	xchg   %ax,%ax
80102110:	89 ca                	mov    %ecx,%edx
80102112:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102113:	83 e0 c0             	and    $0xffffffc0,%eax
80102116:	3c 40                	cmp    $0x40,%al
80102118:	75 f6                	jne    80102110 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010211a:	31 ff                	xor    %edi,%edi
8010211c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102121:	89 f8                	mov    %edi,%eax
80102123:	ee                   	out    %al,(%dx)
80102124:	b8 01 00 00 00       	mov    $0x1,%eax
80102129:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010212e:	ee                   	out    %al,(%dx)
8010212f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102134:	89 f0                	mov    %esi,%eax
80102136:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102137:	89 f0                	mov    %esi,%eax
80102139:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010213e:	c1 f8 08             	sar    $0x8,%eax
80102141:	ee                   	out    %al,(%dx)
80102142:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102147:	89 f8                	mov    %edi,%eax
80102149:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010214a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010214e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102153:	c1 e0 04             	shl    $0x4,%eax
80102156:	83 e0 10             	and    $0x10,%eax
80102159:	83 c8 e0             	or     $0xffffffe0,%eax
8010215c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010215d:	f6 03 04             	testb  $0x4,(%ebx)
80102160:	75 16                	jne    80102178 <idestart+0x98>
80102162:	b8 20 00 00 00       	mov    $0x20,%eax
80102167:	89 ca                	mov    %ecx,%edx
80102169:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010216a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010216d:	5b                   	pop    %ebx
8010216e:	5e                   	pop    %esi
8010216f:	5f                   	pop    %edi
80102170:	5d                   	pop    %ebp
80102171:	c3                   	ret    
80102172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102178:	b8 30 00 00 00       	mov    $0x30,%eax
8010217d:	89 ca                	mov    %ecx,%edx
8010217f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102180:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102185:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102188:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010218d:	fc                   	cld    
8010218e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102190:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102193:	5b                   	pop    %ebx
80102194:	5e                   	pop    %esi
80102195:	5f                   	pop    %edi
80102196:	5d                   	pop    %ebp
80102197:	c3                   	ret    
    panic("incorrect blockno");
80102198:	83 ec 0c             	sub    $0xc,%esp
8010219b:	68 b4 7a 10 80       	push   $0x80107ab4
801021a0:	e8 db e1 ff ff       	call   80100380 <panic>
    panic("idestart");
801021a5:	83 ec 0c             	sub    $0xc,%esp
801021a8:	68 ab 7a 10 80       	push   $0x80107aab
801021ad:	e8 ce e1 ff ff       	call   80100380 <panic>
801021b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021c0 <ideinit>:
{
801021c0:	55                   	push   %ebp
801021c1:	89 e5                	mov    %esp,%ebp
801021c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
801021c6:	68 c6 7a 10 80       	push   $0x80107ac6
801021cb:	68 00 26 11 80       	push   $0x80112600
801021d0:	e8 3b 28 00 00       	call   80104a10 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801021d5:	58                   	pop    %eax
801021d6:	a1 84 27 11 80       	mov    0x80112784,%eax
801021db:	5a                   	pop    %edx
801021dc:	83 e8 01             	sub    $0x1,%eax
801021df:	50                   	push   %eax
801021e0:	6a 0e                	push   $0xe
801021e2:	e8 99 02 00 00       	call   80102480 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021e7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021ea:	ba f7 01 00 00       	mov    $0x1f7,%edx
801021ef:	90                   	nop
801021f0:	ec                   	in     (%dx),%al
801021f1:	83 e0 c0             	and    $0xffffffc0,%eax
801021f4:	3c 40                	cmp    $0x40,%al
801021f6:	75 f8                	jne    801021f0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021f8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801021fd:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102202:	ee                   	out    %al,(%dx)
80102203:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102208:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010220d:	eb 06                	jmp    80102215 <ideinit+0x55>
8010220f:	90                   	nop
  for(i=0; i<1000; i++){
80102210:	83 e9 01             	sub    $0x1,%ecx
80102213:	74 0f                	je     80102224 <ideinit+0x64>
80102215:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102216:	84 c0                	test   %al,%al
80102218:	74 f6                	je     80102210 <ideinit+0x50>
      havedisk1 = 1;
8010221a:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
80102221:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102224:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102229:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010222e:	ee                   	out    %al,(%dx)
}
8010222f:	c9                   	leave  
80102230:	c3                   	ret    
80102231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102238:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010223f:	90                   	nop

80102240 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102240:	55                   	push   %ebp
80102241:	89 e5                	mov    %esp,%ebp
80102243:	57                   	push   %edi
80102244:	56                   	push   %esi
80102245:	53                   	push   %ebx
80102246:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102249:	68 00 26 11 80       	push   $0x80112600
8010224e:	e8 8d 29 00 00       	call   80104be0 <acquire>

  if((b = idequeue) == 0){
80102253:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102259:	83 c4 10             	add    $0x10,%esp
8010225c:	85 db                	test   %ebx,%ebx
8010225e:	74 63                	je     801022c3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102260:	8b 43 58             	mov    0x58(%ebx),%eax
80102263:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102268:	8b 33                	mov    (%ebx),%esi
8010226a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102270:	75 2f                	jne    801022a1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102272:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227e:	66 90                	xchg   %ax,%ax
80102280:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102281:	89 c1                	mov    %eax,%ecx
80102283:	83 e1 c0             	and    $0xffffffc0,%ecx
80102286:	80 f9 40             	cmp    $0x40,%cl
80102289:	75 f5                	jne    80102280 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010228b:	a8 21                	test   $0x21,%al
8010228d:	75 12                	jne    801022a1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010228f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102292:	b9 80 00 00 00       	mov    $0x80,%ecx
80102297:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010229c:	fc                   	cld    
8010229d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010229f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801022a1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801022a4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801022a7:	83 ce 02             	or     $0x2,%esi
801022aa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801022ac:	53                   	push   %ebx
801022ad:	e8 ce 1d 00 00       	call   80104080 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801022b2:	a1 e4 25 11 80       	mov    0x801125e4,%eax
801022b7:	83 c4 10             	add    $0x10,%esp
801022ba:	85 c0                	test   %eax,%eax
801022bc:	74 05                	je     801022c3 <ideintr+0x83>
    idestart(idequeue);
801022be:	e8 1d fe ff ff       	call   801020e0 <idestart>
    release(&idelock);
801022c3:	83 ec 0c             	sub    $0xc,%esp
801022c6:	68 00 26 11 80       	push   $0x80112600
801022cb:	e8 b0 28 00 00       	call   80104b80 <release>

  release(&idelock);
}
801022d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022d3:	5b                   	pop    %ebx
801022d4:	5e                   	pop    %esi
801022d5:	5f                   	pop    %edi
801022d6:	5d                   	pop    %ebp
801022d7:	c3                   	ret    
801022d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022df:	90                   	nop

801022e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801022e0:	55                   	push   %ebp
801022e1:	89 e5                	mov    %esp,%ebp
801022e3:	53                   	push   %ebx
801022e4:	83 ec 10             	sub    $0x10,%esp
801022e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801022ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801022ed:	50                   	push   %eax
801022ee:	e8 cd 26 00 00       	call   801049c0 <holdingsleep>
801022f3:	83 c4 10             	add    $0x10,%esp
801022f6:	85 c0                	test   %eax,%eax
801022f8:	0f 84 c3 00 00 00    	je     801023c1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801022fe:	8b 03                	mov    (%ebx),%eax
80102300:	83 e0 06             	and    $0x6,%eax
80102303:	83 f8 02             	cmp    $0x2,%eax
80102306:	0f 84 a8 00 00 00    	je     801023b4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010230c:	8b 53 04             	mov    0x4(%ebx),%edx
8010230f:	85 d2                	test   %edx,%edx
80102311:	74 0d                	je     80102320 <iderw+0x40>
80102313:	a1 e0 25 11 80       	mov    0x801125e0,%eax
80102318:	85 c0                	test   %eax,%eax
8010231a:	0f 84 87 00 00 00    	je     801023a7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102320:	83 ec 0c             	sub    $0xc,%esp
80102323:	68 00 26 11 80       	push   $0x80112600
80102328:	e8 b3 28 00 00       	call   80104be0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010232d:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102332:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102339:	83 c4 10             	add    $0x10,%esp
8010233c:	85 c0                	test   %eax,%eax
8010233e:	74 60                	je     801023a0 <iderw+0xc0>
80102340:	89 c2                	mov    %eax,%edx
80102342:	8b 40 58             	mov    0x58(%eax),%eax
80102345:	85 c0                	test   %eax,%eax
80102347:	75 f7                	jne    80102340 <iderw+0x60>
80102349:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010234c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010234e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102354:	74 3a                	je     80102390 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102356:	8b 03                	mov    (%ebx),%eax
80102358:	83 e0 06             	and    $0x6,%eax
8010235b:	83 f8 02             	cmp    $0x2,%eax
8010235e:	74 1b                	je     8010237b <iderw+0x9b>
    sleep(b, &idelock);
80102360:	83 ec 08             	sub    $0x8,%esp
80102363:	68 00 26 11 80       	push   $0x80112600
80102368:	53                   	push   %ebx
80102369:	e8 52 1c 00 00       	call   80103fc0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010236e:	8b 03                	mov    (%ebx),%eax
80102370:	83 c4 10             	add    $0x10,%esp
80102373:	83 e0 06             	and    $0x6,%eax
80102376:	83 f8 02             	cmp    $0x2,%eax
80102379:	75 e5                	jne    80102360 <iderw+0x80>
  }


  release(&idelock);
8010237b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102382:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102385:	c9                   	leave  
  release(&idelock);
80102386:	e9 f5 27 00 00       	jmp    80104b80 <release>
8010238b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010238f:	90                   	nop
    idestart(b);
80102390:	89 d8                	mov    %ebx,%eax
80102392:	e8 49 fd ff ff       	call   801020e0 <idestart>
80102397:	eb bd                	jmp    80102356 <iderw+0x76>
80102399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023a0:	ba e4 25 11 80       	mov    $0x801125e4,%edx
801023a5:	eb a5                	jmp    8010234c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801023a7:	83 ec 0c             	sub    $0xc,%esp
801023aa:	68 f5 7a 10 80       	push   $0x80107af5
801023af:	e8 cc df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
801023b4:	83 ec 0c             	sub    $0xc,%esp
801023b7:	68 e0 7a 10 80       	push   $0x80107ae0
801023bc:	e8 bf df ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
801023c1:	83 ec 0c             	sub    $0xc,%esp
801023c4:	68 ca 7a 10 80       	push   $0x80107aca
801023c9:	e8 b2 df ff ff       	call   80100380 <panic>
801023ce:	66 90                	xchg   %ax,%ax

801023d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801023d0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801023d1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801023d8:	00 c0 fe 
{
801023db:	89 e5                	mov    %esp,%ebp
801023dd:	56                   	push   %esi
801023de:	53                   	push   %ebx
  ioapic->reg = reg;
801023df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801023e6:	00 00 00 
  return ioapic->data;
801023e9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023ef:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801023f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801023f8:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801023fe:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102405:	c1 ee 10             	shr    $0x10,%esi
80102408:	89 f0                	mov    %esi,%eax
8010240a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010240d:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
80102410:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102413:	39 c2                	cmp    %eax,%edx
80102415:	74 16                	je     8010242d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102417:	83 ec 0c             	sub    $0xc,%esp
8010241a:	68 14 7b 10 80       	push   $0x80107b14
8010241f:	e8 7c e2 ff ff       	call   801006a0 <cprintf>
  ioapic->reg = reg;
80102424:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
8010242a:	83 c4 10             	add    $0x10,%esp
8010242d:	83 c6 21             	add    $0x21,%esi
{
80102430:	ba 10 00 00 00       	mov    $0x10,%edx
80102435:	b8 20 00 00 00       	mov    $0x20,%eax
8010243a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102440:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102442:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102444:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010244a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010244d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102453:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102456:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102459:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010245c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010245e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102464:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010246b:	39 f0                	cmp    %esi,%eax
8010246d:	75 d1                	jne    80102440 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010246f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102472:	5b                   	pop    %ebx
80102473:	5e                   	pop    %esi
80102474:	5d                   	pop    %ebp
80102475:	c3                   	ret    
80102476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247d:	8d 76 00             	lea    0x0(%esi),%esi

80102480 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102480:	55                   	push   %ebp
  ioapic->reg = reg;
80102481:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102487:	89 e5                	mov    %esp,%ebp
80102489:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010248c:	8d 50 20             	lea    0x20(%eax),%edx
8010248f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102493:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102495:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010249b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010249e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801024a4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801024a6:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801024ab:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801024ae:	89 50 10             	mov    %edx,0x10(%eax)
}
801024b1:	5d                   	pop    %ebp
801024b2:	c3                   	ret    
801024b3:	66 90                	xchg   %ax,%ax
801024b5:	66 90                	xchg   %ax,%ax
801024b7:	66 90                	xchg   %ax,%ax
801024b9:	66 90                	xchg   %ax,%ax
801024bb:	66 90                	xchg   %ax,%ax
801024bd:	66 90                	xchg   %ax,%ax
801024bf:	90                   	nop

801024c0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801024c0:	55                   	push   %ebp
801024c1:	89 e5                	mov    %esp,%ebp
801024c3:	53                   	push   %ebx
801024c4:	83 ec 04             	sub    $0x4,%esp
801024c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801024ca:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801024d0:	75 76                	jne    80102548 <kfree+0x88>
801024d2:	81 fb d0 68 11 80    	cmp    $0x801168d0,%ebx
801024d8:	72 6e                	jb     80102548 <kfree+0x88>
801024da:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801024e0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801024e5:	77 61                	ja     80102548 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801024e7:	83 ec 04             	sub    $0x4,%esp
801024ea:	68 00 10 00 00       	push   $0x1000
801024ef:	6a 01                	push   $0x1
801024f1:	53                   	push   %ebx
801024f2:	e8 a9 27 00 00       	call   80104ca0 <memset>

  if(kmem.use_lock)
801024f7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801024fd:	83 c4 10             	add    $0x10,%esp
80102500:	85 d2                	test   %edx,%edx
80102502:	75 1c                	jne    80102520 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102504:	a1 78 26 11 80       	mov    0x80112678,%eax
80102509:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010250b:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
80102510:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
80102516:	85 c0                	test   %eax,%eax
80102518:	75 1e                	jne    80102538 <kfree+0x78>
    release(&kmem.lock);
}
8010251a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010251d:	c9                   	leave  
8010251e:	c3                   	ret    
8010251f:	90                   	nop
    acquire(&kmem.lock);
80102520:	83 ec 0c             	sub    $0xc,%esp
80102523:	68 40 26 11 80       	push   $0x80112640
80102528:	e8 b3 26 00 00       	call   80104be0 <acquire>
8010252d:	83 c4 10             	add    $0x10,%esp
80102530:	eb d2                	jmp    80102504 <kfree+0x44>
80102532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102538:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010253f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102542:	c9                   	leave  
    release(&kmem.lock);
80102543:	e9 38 26 00 00       	jmp    80104b80 <release>
    panic("kfree");
80102548:	83 ec 0c             	sub    $0xc,%esp
8010254b:	68 46 7b 10 80       	push   $0x80107b46
80102550:	e8 2b de ff ff       	call   80100380 <panic>
80102555:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010255c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102560 <freerange>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102564:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102567:	8b 75 0c             	mov    0xc(%ebp),%esi
8010256a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
8010256b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102571:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102577:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010257d:	39 de                	cmp    %ebx,%esi
8010257f:	72 23                	jb     801025a4 <freerange+0x44>
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102588:	83 ec 0c             	sub    $0xc,%esp
8010258b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102591:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102597:	50                   	push   %eax
80102598:	e8 23 ff ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010259d:	83 c4 10             	add    $0x10,%esp
801025a0:	39 f3                	cmp    %esi,%ebx
801025a2:	76 e4                	jbe    80102588 <freerange+0x28>
}
801025a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025a7:	5b                   	pop    %ebx
801025a8:	5e                   	pop    %esi
801025a9:	5d                   	pop    %ebp
801025aa:	c3                   	ret    
801025ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025af:	90                   	nop

801025b0 <kinit2>:
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801025b4:	8b 45 08             	mov    0x8(%ebp),%eax
{
801025b7:	8b 75 0c             	mov    0xc(%ebp),%esi
801025ba:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801025bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801025c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801025cd:	39 de                	cmp    %ebx,%esi
801025cf:	72 23                	jb     801025f4 <kinit2+0x44>
801025d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801025d8:	83 ec 0c             	sub    $0xc,%esp
801025db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801025e7:	50                   	push   %eax
801025e8:	e8 d3 fe ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801025ed:	83 c4 10             	add    $0x10,%esp
801025f0:	39 de                	cmp    %ebx,%esi
801025f2:	73 e4                	jae    801025d8 <kinit2+0x28>
  kmem.use_lock = 1;
801025f4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
801025fb:	00 00 00 
}
801025fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102601:	5b                   	pop    %ebx
80102602:	5e                   	pop    %esi
80102603:	5d                   	pop    %ebp
80102604:	c3                   	ret    
80102605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102610 <kinit1>:
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	56                   	push   %esi
80102614:	53                   	push   %ebx
80102615:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102618:	83 ec 08             	sub    $0x8,%esp
8010261b:	68 4c 7b 10 80       	push   $0x80107b4c
80102620:	68 40 26 11 80       	push   $0x80112640
80102625:	e8 e6 23 00 00       	call   80104a10 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010262a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010262d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102630:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102637:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010263a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102640:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102646:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010264c:	39 de                	cmp    %ebx,%esi
8010264e:	72 1c                	jb     8010266c <kinit1+0x5c>
    kfree(p);
80102650:	83 ec 0c             	sub    $0xc,%esp
80102653:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102659:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010265f:	50                   	push   %eax
80102660:	e8 5b fe ff ff       	call   801024c0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102665:	83 c4 10             	add    $0x10,%esp
80102668:	39 de                	cmp    %ebx,%esi
8010266a:	73 e4                	jae    80102650 <kinit1+0x40>
}
8010266c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010266f:	5b                   	pop    %ebx
80102670:	5e                   	pop    %esi
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret    
80102673:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010267a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102680 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102680:	a1 74 26 11 80       	mov    0x80112674,%eax
80102685:	85 c0                	test   %eax,%eax
80102687:	75 1f                	jne    801026a8 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102689:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
8010268e:	85 c0                	test   %eax,%eax
80102690:	74 0e                	je     801026a0 <kalloc+0x20>
    kmem.freelist = r->next;
80102692:	8b 10                	mov    (%eax),%edx
80102694:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
8010269a:	c3                   	ret    
8010269b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010269f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
801026a0:	c3                   	ret    
801026a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
801026a8:	55                   	push   %ebp
801026a9:	89 e5                	mov    %esp,%ebp
801026ab:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
801026ae:	68 40 26 11 80       	push   $0x80112640
801026b3:	e8 28 25 00 00       	call   80104be0 <acquire>
  r = kmem.freelist;
801026b8:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
801026bd:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
801026c3:	83 c4 10             	add    $0x10,%esp
801026c6:	85 c0                	test   %eax,%eax
801026c8:	74 08                	je     801026d2 <kalloc+0x52>
    kmem.freelist = r->next;
801026ca:	8b 08                	mov    (%eax),%ecx
801026cc:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
801026d2:	85 d2                	test   %edx,%edx
801026d4:	74 16                	je     801026ec <kalloc+0x6c>
    release(&kmem.lock);
801026d6:	83 ec 0c             	sub    $0xc,%esp
801026d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801026dc:	68 40 26 11 80       	push   $0x80112640
801026e1:	e8 9a 24 00 00       	call   80104b80 <release>
  return (char*)r;
801026e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
801026e9:	83 c4 10             	add    $0x10,%esp
}
801026ec:	c9                   	leave  
801026ed:	c3                   	ret    
801026ee:	66 90                	xchg   %ax,%ax

801026f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f0:	ba 64 00 00 00       	mov    $0x64,%edx
801026f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801026f6:	a8 01                	test   $0x1,%al
801026f8:	0f 84 c2 00 00 00    	je     801027c0 <kbdgetc+0xd0>
{
801026fe:	55                   	push   %ebp
801026ff:	ba 60 00 00 00       	mov    $0x60,%edx
80102704:	89 e5                	mov    %esp,%ebp
80102706:	53                   	push   %ebx
80102707:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102708:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
8010270e:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102711:	3c e0                	cmp    $0xe0,%al
80102713:	74 5b                	je     80102770 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102715:	89 da                	mov    %ebx,%edx
80102717:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
8010271a:	84 c0                	test   %al,%al
8010271c:	78 62                	js     80102780 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
8010271e:	85 d2                	test   %edx,%edx
80102720:	74 09                	je     8010272b <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102722:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102725:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102728:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
8010272b:	0f b6 91 80 7c 10 80 	movzbl -0x7fef8380(%ecx),%edx
  shift ^= togglecode[data];
80102732:	0f b6 81 80 7b 10 80 	movzbl -0x7fef8480(%ecx),%eax
  shift |= shiftcode[data];
80102739:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010273b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010273d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010273f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102745:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102748:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010274b:	8b 04 85 60 7b 10 80 	mov    -0x7fef84a0(,%eax,4),%eax
80102752:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102756:	74 0b                	je     80102763 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102758:	8d 50 9f             	lea    -0x61(%eax),%edx
8010275b:	83 fa 19             	cmp    $0x19,%edx
8010275e:	77 48                	ja     801027a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102760:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102763:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102766:	c9                   	leave  
80102767:	c3                   	ret    
80102768:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010276f:	90                   	nop
    shift |= E0ESC;
80102770:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102773:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102775:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
8010277b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010277e:	c9                   	leave  
8010277f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102780:	83 e0 7f             	and    $0x7f,%eax
80102783:	85 d2                	test   %edx,%edx
80102785:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102788:	0f b6 81 80 7c 10 80 	movzbl -0x7fef8380(%ecx),%eax
8010278f:	83 c8 40             	or     $0x40,%eax
80102792:	0f b6 c0             	movzbl %al,%eax
80102795:	f7 d0                	not    %eax
80102797:	21 d8                	and    %ebx,%eax
}
80102799:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
8010279c:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
801027a1:	31 c0                	xor    %eax,%eax
}
801027a3:	c9                   	leave  
801027a4:	c3                   	ret    
801027a5:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
801027a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801027ab:	8d 50 20             	lea    0x20(%eax),%edx
}
801027ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027b1:	c9                   	leave  
      c += 'a' - 'A';
801027b2:	83 f9 1a             	cmp    $0x1a,%ecx
801027b5:	0f 42 c2             	cmovb  %edx,%eax
}
801027b8:	c3                   	ret    
801027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801027c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801027c5:	c3                   	ret    
801027c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027cd:	8d 76 00             	lea    0x0(%esi),%esi

801027d0 <kbdintr>:

void
kbdintr(void)
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801027d6:	68 f0 26 10 80       	push   $0x801026f0
801027db:	e8 a0 e0 ff ff       	call   80100880 <consoleintr>
}
801027e0:	83 c4 10             	add    $0x10,%esp
801027e3:	c9                   	leave  
801027e4:	c3                   	ret    
801027e5:	66 90                	xchg   %ax,%ax
801027e7:	66 90                	xchg   %ax,%ax
801027e9:	66 90                	xchg   %ax,%ax
801027eb:	66 90                	xchg   %ax,%ax
801027ed:	66 90                	xchg   %ax,%ax
801027ef:	90                   	nop

801027f0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801027f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801027f5:	85 c0                	test   %eax,%eax
801027f7:	0f 84 cb 00 00 00    	je     801028c8 <lapicinit+0xd8>
  lapic[index] = value;
801027fd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102804:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102807:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010280a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102811:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102814:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102817:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010281e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102821:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102824:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010282b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010282e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102831:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102838:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010283b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010283e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102845:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102848:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010284b:	8b 50 30             	mov    0x30(%eax),%edx
8010284e:	c1 ea 10             	shr    $0x10,%edx
80102851:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102857:	75 77                	jne    801028d0 <lapicinit+0xe0>
  lapic[index] = value;
80102859:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102860:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102863:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102866:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010286d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102870:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102873:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010287a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010287d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102880:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102887:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010288a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010288d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102894:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102897:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010289a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801028a1:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801028a4:	8b 50 20             	mov    0x20(%eax),%edx
801028a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028ae:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801028b0:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801028b6:	80 e6 10             	and    $0x10,%dh
801028b9:	75 f5                	jne    801028b0 <lapicinit+0xc0>
  lapic[index] = value;
801028bb:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801028c2:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c5:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801028c8:	c3                   	ret    
801028c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801028d0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801028d7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028da:	8b 50 20             	mov    0x20(%eax),%edx
}
801028dd:	e9 77 ff ff ff       	jmp    80102859 <lapicinit+0x69>
801028e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801028e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801028f0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801028f0:	a1 80 26 11 80       	mov    0x80112680,%eax
801028f5:	85 c0                	test   %eax,%eax
801028f7:	74 07                	je     80102900 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801028f9:	8b 40 20             	mov    0x20(%eax),%eax
801028fc:	c1 e8 18             	shr    $0x18,%eax
801028ff:	c3                   	ret    
    return 0;
80102900:	31 c0                	xor    %eax,%eax
}
80102902:	c3                   	ret    
80102903:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102910 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102910:	a1 80 26 11 80       	mov    0x80112680,%eax
80102915:	85 c0                	test   %eax,%eax
80102917:	74 0d                	je     80102926 <lapiceoi+0x16>
  lapic[index] = value;
80102919:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102920:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102923:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102926:	c3                   	ret    
80102927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010292e:	66 90                	xchg   %ax,%ax

80102930 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102930:	c3                   	ret    
80102931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102938:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010293f:	90                   	nop

80102940 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102940:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102941:	b8 0f 00 00 00       	mov    $0xf,%eax
80102946:	ba 70 00 00 00       	mov    $0x70,%edx
8010294b:	89 e5                	mov    %esp,%ebp
8010294d:	53                   	push   %ebx
8010294e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102951:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102954:	ee                   	out    %al,(%dx)
80102955:	b8 0a 00 00 00       	mov    $0xa,%eax
8010295a:	ba 71 00 00 00       	mov    $0x71,%edx
8010295f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102960:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102962:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102965:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010296b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010296d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102970:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102972:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102975:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102978:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010297e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102983:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102989:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010298c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102993:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102996:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102999:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801029a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029a3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029ac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029b5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801029b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801029c7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801029ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029cd:	c9                   	leave  
801029ce:	c3                   	ret    
801029cf:	90                   	nop

801029d0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801029d0:	55                   	push   %ebp
801029d1:	b8 0b 00 00 00       	mov    $0xb,%eax
801029d6:	ba 70 00 00 00       	mov    $0x70,%edx
801029db:	89 e5                	mov    %esp,%ebp
801029dd:	57                   	push   %edi
801029de:	56                   	push   %esi
801029df:	53                   	push   %ebx
801029e0:	83 ec 4c             	sub    $0x4c,%esp
801029e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029e4:	ba 71 00 00 00       	mov    $0x71,%edx
801029e9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801029ea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029ed:	bb 70 00 00 00       	mov    $0x70,%ebx
801029f2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801029f5:	8d 76 00             	lea    0x0(%esi),%esi
801029f8:	31 c0                	xor    %eax,%eax
801029fa:	89 da                	mov    %ebx,%edx
801029fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029fd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102a02:	89 ca                	mov    %ecx,%edx
80102a04:	ec                   	in     (%dx),%al
80102a05:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a08:	89 da                	mov    %ebx,%edx
80102a0a:	b8 02 00 00 00       	mov    $0x2,%eax
80102a0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a10:	89 ca                	mov    %ecx,%edx
80102a12:	ec                   	in     (%dx),%al
80102a13:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a16:	89 da                	mov    %ebx,%edx
80102a18:	b8 04 00 00 00       	mov    $0x4,%eax
80102a1d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a1e:	89 ca                	mov    %ecx,%edx
80102a20:	ec                   	in     (%dx),%al
80102a21:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a24:	89 da                	mov    %ebx,%edx
80102a26:	b8 07 00 00 00       	mov    $0x7,%eax
80102a2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a2c:	89 ca                	mov    %ecx,%edx
80102a2e:	ec                   	in     (%dx),%al
80102a2f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a32:	89 da                	mov    %ebx,%edx
80102a34:	b8 08 00 00 00       	mov    $0x8,%eax
80102a39:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a3a:	89 ca                	mov    %ecx,%edx
80102a3c:	ec                   	in     (%dx),%al
80102a3d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a3f:	89 da                	mov    %ebx,%edx
80102a41:	b8 09 00 00 00       	mov    $0x9,%eax
80102a46:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a47:	89 ca                	mov    %ecx,%edx
80102a49:	ec                   	in     (%dx),%al
80102a4a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a4c:	89 da                	mov    %ebx,%edx
80102a4e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a53:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a54:	89 ca                	mov    %ecx,%edx
80102a56:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102a57:	84 c0                	test   %al,%al
80102a59:	78 9d                	js     801029f8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102a5b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102a5f:	89 fa                	mov    %edi,%edx
80102a61:	0f b6 fa             	movzbl %dl,%edi
80102a64:	89 f2                	mov    %esi,%edx
80102a66:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102a69:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102a6d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a70:	89 da                	mov    %ebx,%edx
80102a72:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102a75:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102a78:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102a7c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102a7f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102a82:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102a86:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102a89:	31 c0                	xor    %eax,%eax
80102a8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a8c:	89 ca                	mov    %ecx,%edx
80102a8e:	ec                   	in     (%dx),%al
80102a8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a92:	89 da                	mov    %ebx,%edx
80102a94:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102a97:	b8 02 00 00 00       	mov    $0x2,%eax
80102a9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a9d:	89 ca                	mov    %ecx,%edx
80102a9f:	ec                   	in     (%dx),%al
80102aa0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aa3:	89 da                	mov    %ebx,%edx
80102aa5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102aa8:	b8 04 00 00 00       	mov    $0x4,%eax
80102aad:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aae:	89 ca                	mov    %ecx,%edx
80102ab0:	ec                   	in     (%dx),%al
80102ab1:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab4:	89 da                	mov    %ebx,%edx
80102ab6:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102ab9:	b8 07 00 00 00       	mov    $0x7,%eax
80102abe:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102abf:	89 ca                	mov    %ecx,%edx
80102ac1:	ec                   	in     (%dx),%al
80102ac2:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac5:	89 da                	mov    %ebx,%edx
80102ac7:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102aca:	b8 08 00 00 00       	mov    $0x8,%eax
80102acf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ad0:	89 ca                	mov    %ecx,%edx
80102ad2:	ec                   	in     (%dx),%al
80102ad3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad6:	89 da                	mov    %ebx,%edx
80102ad8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102adb:	b8 09 00 00 00       	mov    $0x9,%eax
80102ae0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ae1:	89 ca                	mov    %ecx,%edx
80102ae3:	ec                   	in     (%dx),%al
80102ae4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ae7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102aea:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102aed:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102af0:	6a 18                	push   $0x18
80102af2:	50                   	push   %eax
80102af3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102af6:	50                   	push   %eax
80102af7:	e8 f4 21 00 00       	call   80104cf0 <memcmp>
80102afc:	83 c4 10             	add    $0x10,%esp
80102aff:	85 c0                	test   %eax,%eax
80102b01:	0f 85 f1 fe ff ff    	jne    801029f8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102b07:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102b0b:	75 78                	jne    80102b85 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102b0d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b10:	89 c2                	mov    %eax,%edx
80102b12:	83 e0 0f             	and    $0xf,%eax
80102b15:	c1 ea 04             	shr    $0x4,%edx
80102b18:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b1b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b1e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102b21:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b24:	89 c2                	mov    %eax,%edx
80102b26:	83 e0 0f             	and    $0xf,%eax
80102b29:	c1 ea 04             	shr    $0x4,%edx
80102b2c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b2f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b32:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102b35:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b38:	89 c2                	mov    %eax,%edx
80102b3a:	83 e0 0f             	and    $0xf,%eax
80102b3d:	c1 ea 04             	shr    $0x4,%edx
80102b40:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b43:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b46:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102b49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b4c:	89 c2                	mov    %eax,%edx
80102b4e:	83 e0 0f             	and    $0xf,%eax
80102b51:	c1 ea 04             	shr    $0x4,%edx
80102b54:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b57:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b5a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102b5d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102b60:	89 c2                	mov    %eax,%edx
80102b62:	83 e0 0f             	and    $0xf,%eax
80102b65:	c1 ea 04             	shr    $0x4,%edx
80102b68:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b6b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b6e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102b71:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102b74:	89 c2                	mov    %eax,%edx
80102b76:	83 e0 0f             	and    $0xf,%eax
80102b79:	c1 ea 04             	shr    $0x4,%edx
80102b7c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102b7f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102b82:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102b85:	8b 75 08             	mov    0x8(%ebp),%esi
80102b88:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102b8b:	89 06                	mov    %eax,(%esi)
80102b8d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102b90:	89 46 04             	mov    %eax,0x4(%esi)
80102b93:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102b96:	89 46 08             	mov    %eax,0x8(%esi)
80102b99:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102b9c:	89 46 0c             	mov    %eax,0xc(%esi)
80102b9f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ba2:	89 46 10             	mov    %eax,0x10(%esi)
80102ba5:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102ba8:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102bab:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102bb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102bb5:	5b                   	pop    %ebx
80102bb6:	5e                   	pop    %esi
80102bb7:	5f                   	pop    %edi
80102bb8:	5d                   	pop    %ebp
80102bb9:	c3                   	ret    
80102bba:	66 90                	xchg   %ax,%ax
80102bbc:	66 90                	xchg   %ax,%ax
80102bbe:	66 90                	xchg   %ax,%ax

80102bc0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102bc0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102bc6:	85 c9                	test   %ecx,%ecx
80102bc8:	0f 8e 8a 00 00 00    	jle    80102c58 <install_trans+0x98>
{
80102bce:	55                   	push   %ebp
80102bcf:	89 e5                	mov    %esp,%ebp
80102bd1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102bd2:	31 ff                	xor    %edi,%edi
{
80102bd4:	56                   	push   %esi
80102bd5:	53                   	push   %ebx
80102bd6:	83 ec 0c             	sub    $0xc,%esp
80102bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102be0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102be5:	83 ec 08             	sub    $0x8,%esp
80102be8:	01 f8                	add    %edi,%eax
80102bea:	83 c0 01             	add    $0x1,%eax
80102bed:	50                   	push   %eax
80102bee:	ff 35 e4 26 11 80    	push   0x801126e4
80102bf4:	e8 d7 d4 ff ff       	call   801000d0 <bread>
80102bf9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102bfb:	58                   	pop    %eax
80102bfc:	5a                   	pop    %edx
80102bfd:	ff 34 bd ec 26 11 80 	push   -0x7feed914(,%edi,4)
80102c04:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102c0a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c0d:	e8 be d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c12:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102c15:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102c17:	8d 46 5c             	lea    0x5c(%esi),%eax
80102c1a:	68 00 02 00 00       	push   $0x200
80102c1f:	50                   	push   %eax
80102c20:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102c23:	50                   	push   %eax
80102c24:	e8 17 21 00 00       	call   80104d40 <memmove>
    bwrite(dbuf);  // write dst to disk
80102c29:	89 1c 24             	mov    %ebx,(%esp)
80102c2c:	e8 7f d5 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102c31:	89 34 24             	mov    %esi,(%esp)
80102c34:	e8 b7 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102c39:	89 1c 24             	mov    %ebx,(%esp)
80102c3c:	e8 af d5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102c41:	83 c4 10             	add    $0x10,%esp
80102c44:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102c4a:	7f 94                	jg     80102be0 <install_trans+0x20>
  }
}
80102c4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c4f:	5b                   	pop    %ebx
80102c50:	5e                   	pop    %esi
80102c51:	5f                   	pop    %edi
80102c52:	5d                   	pop    %ebp
80102c53:	c3                   	ret    
80102c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c58:	c3                   	ret    
80102c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102c60:	55                   	push   %ebp
80102c61:	89 e5                	mov    %esp,%ebp
80102c63:	53                   	push   %ebx
80102c64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c67:	ff 35 d4 26 11 80    	push   0x801126d4
80102c6d:	ff 35 e4 26 11 80    	push   0x801126e4
80102c73:	e8 58 d4 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102c78:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102c7b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102c7d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80102c82:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102c85:	85 c0                	test   %eax,%eax
80102c87:	7e 19                	jle    80102ca2 <write_head+0x42>
80102c89:	31 d2                	xor    %edx,%edx
80102c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c8f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80102c90:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80102c97:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102c9b:	83 c2 01             	add    $0x1,%edx
80102c9e:	39 d0                	cmp    %edx,%eax
80102ca0:	75 ee                	jne    80102c90 <write_head+0x30>
  }
  bwrite(buf);
80102ca2:	83 ec 0c             	sub    $0xc,%esp
80102ca5:	53                   	push   %ebx
80102ca6:	e8 05 d5 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102cab:	89 1c 24             	mov    %ebx,(%esp)
80102cae:	e8 3d d5 ff ff       	call   801001f0 <brelse>
}
80102cb3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102cb6:	83 c4 10             	add    $0x10,%esp
80102cb9:	c9                   	leave  
80102cba:	c3                   	ret    
80102cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cbf:	90                   	nop

80102cc0 <initlog>:
{
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	53                   	push   %ebx
80102cc4:	83 ec 2c             	sub    $0x2c,%esp
80102cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102cca:	68 80 7d 10 80       	push   $0x80107d80
80102ccf:	68 a0 26 11 80       	push   $0x801126a0
80102cd4:	e8 37 1d 00 00       	call   80104a10 <initlock>
  readsb(dev, &sb);
80102cd9:	58                   	pop    %eax
80102cda:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102cdd:	5a                   	pop    %edx
80102cde:	50                   	push   %eax
80102cdf:	53                   	push   %ebx
80102ce0:	e8 3b e8 ff ff       	call   80101520 <readsb>
  log.start = sb.logstart;
80102ce5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102ce8:	59                   	pop    %ecx
  log.dev = dev;
80102ce9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
80102cef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102cf2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
80102cf7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
80102cfd:	5a                   	pop    %edx
80102cfe:	50                   	push   %eax
80102cff:	53                   	push   %ebx
80102d00:	e8 cb d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102d05:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102d08:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102d0b:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102d11:	85 db                	test   %ebx,%ebx
80102d13:	7e 1d                	jle    80102d32 <initlog+0x72>
80102d15:	31 d2                	xor    %edx,%edx
80102d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d1e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102d20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102d24:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d2b:	83 c2 01             	add    $0x1,%edx
80102d2e:	39 d3                	cmp    %edx,%ebx
80102d30:	75 ee                	jne    80102d20 <initlog+0x60>
  brelse(buf);
80102d32:	83 ec 0c             	sub    $0xc,%esp
80102d35:	50                   	push   %eax
80102d36:	e8 b5 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102d3b:	e8 80 fe ff ff       	call   80102bc0 <install_trans>
  log.lh.n = 0;
80102d40:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d47:	00 00 00 
  write_head(); // clear the log
80102d4a:	e8 11 ff ff ff       	call   80102c60 <write_head>
}
80102d4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d52:	83 c4 10             	add    $0x10,%esp
80102d55:	c9                   	leave  
80102d56:	c3                   	ret    
80102d57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d5e:	66 90                	xchg   %ax,%ax

80102d60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102d60:	55                   	push   %ebp
80102d61:	89 e5                	mov    %esp,%ebp
80102d63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102d66:	68 a0 26 11 80       	push   $0x801126a0
80102d6b:	e8 70 1e 00 00       	call   80104be0 <acquire>
80102d70:	83 c4 10             	add    $0x10,%esp
80102d73:	eb 18                	jmp    80102d8d <begin_op+0x2d>
80102d75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102d78:	83 ec 08             	sub    $0x8,%esp
80102d7b:	68 a0 26 11 80       	push   $0x801126a0
80102d80:	68 a0 26 11 80       	push   $0x801126a0
80102d85:	e8 36 12 00 00       	call   80103fc0 <sleep>
80102d8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102d8d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102d92:	85 c0                	test   %eax,%eax
80102d94:	75 e2                	jne    80102d78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102d96:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102d9b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102da1:	83 c0 01             	add    $0x1,%eax
80102da4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102da7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102daa:	83 fa 1e             	cmp    $0x1e,%edx
80102dad:	7f c9                	jg     80102d78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102daf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102db2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102db7:	68 a0 26 11 80       	push   $0x801126a0
80102dbc:	e8 bf 1d 00 00       	call   80104b80 <release>
      break;
    }
  }
}
80102dc1:	83 c4 10             	add    $0x10,%esp
80102dc4:	c9                   	leave  
80102dc5:	c3                   	ret    
80102dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dcd:	8d 76 00             	lea    0x0(%esi),%esi

80102dd0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	57                   	push   %edi
80102dd4:	56                   	push   %esi
80102dd5:	53                   	push   %ebx
80102dd6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102dd9:	68 a0 26 11 80       	push   $0x801126a0
80102dde:	e8 fd 1d 00 00       	call   80104be0 <acquire>
  log.outstanding -= 1;
80102de3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102de8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80102dee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102df1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102df4:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
80102dfa:	85 f6                	test   %esi,%esi
80102dfc:	0f 85 22 01 00 00    	jne    80102f24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102e02:	85 db                	test   %ebx,%ebx
80102e04:	0f 85 f6 00 00 00    	jne    80102f00 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102e0a:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102e11:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102e14:	83 ec 0c             	sub    $0xc,%esp
80102e17:	68 a0 26 11 80       	push   $0x801126a0
80102e1c:	e8 5f 1d 00 00       	call   80104b80 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102e21:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102e27:	83 c4 10             	add    $0x10,%esp
80102e2a:	85 c9                	test   %ecx,%ecx
80102e2c:	7f 42                	jg     80102e70 <end_op+0xa0>
    acquire(&log.lock);
80102e2e:	83 ec 0c             	sub    $0xc,%esp
80102e31:	68 a0 26 11 80       	push   $0x801126a0
80102e36:	e8 a5 1d 00 00       	call   80104be0 <acquire>
    wakeup(&log);
80102e3b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80102e42:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102e49:	00 00 00 
    wakeup(&log);
80102e4c:	e8 2f 12 00 00       	call   80104080 <wakeup>
    release(&log.lock);
80102e51:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e58:	e8 23 1d 00 00       	call   80104b80 <release>
80102e5d:	83 c4 10             	add    $0x10,%esp
}
80102e60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e63:	5b                   	pop    %ebx
80102e64:	5e                   	pop    %esi
80102e65:	5f                   	pop    %edi
80102e66:	5d                   	pop    %ebp
80102e67:	c3                   	ret    
80102e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102e70:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102e75:	83 ec 08             	sub    $0x8,%esp
80102e78:	01 d8                	add    %ebx,%eax
80102e7a:	83 c0 01             	add    $0x1,%eax
80102e7d:	50                   	push   %eax
80102e7e:	ff 35 e4 26 11 80    	push   0x801126e4
80102e84:	e8 47 d2 ff ff       	call   801000d0 <bread>
80102e89:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e8b:	58                   	pop    %eax
80102e8c:	5a                   	pop    %edx
80102e8d:	ff 34 9d ec 26 11 80 	push   -0x7feed914(,%ebx,4)
80102e94:	ff 35 e4 26 11 80    	push   0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102e9a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102e9d:	e8 2e d2 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102ea2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102ea5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102ea7:	8d 40 5c             	lea    0x5c(%eax),%eax
80102eaa:	68 00 02 00 00       	push   $0x200
80102eaf:	50                   	push   %eax
80102eb0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102eb3:	50                   	push   %eax
80102eb4:	e8 87 1e 00 00       	call   80104d40 <memmove>
    bwrite(to);  // write the log
80102eb9:	89 34 24             	mov    %esi,(%esp)
80102ebc:	e8 ef d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102ec1:	89 3c 24             	mov    %edi,(%esp)
80102ec4:	e8 27 d3 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102ec9:	89 34 24             	mov    %esi,(%esp)
80102ecc:	e8 1f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ed1:	83 c4 10             	add    $0x10,%esp
80102ed4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102eda:	7c 94                	jl     80102e70 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102edc:	e8 7f fd ff ff       	call   80102c60 <write_head>
    install_trans(); // Now install writes to home locations
80102ee1:	e8 da fc ff ff       	call   80102bc0 <install_trans>
    log.lh.n = 0;
80102ee6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102eed:	00 00 00 
    write_head();    // Erase the transaction from the log
80102ef0:	e8 6b fd ff ff       	call   80102c60 <write_head>
80102ef5:	e9 34 ff ff ff       	jmp    80102e2e <end_op+0x5e>
80102efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102f00:	83 ec 0c             	sub    $0xc,%esp
80102f03:	68 a0 26 11 80       	push   $0x801126a0
80102f08:	e8 73 11 00 00       	call   80104080 <wakeup>
  release(&log.lock);
80102f0d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102f14:	e8 67 1c 00 00       	call   80104b80 <release>
80102f19:	83 c4 10             	add    $0x10,%esp
}
80102f1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f1f:	5b                   	pop    %ebx
80102f20:	5e                   	pop    %esi
80102f21:	5f                   	pop    %edi
80102f22:	5d                   	pop    %ebp
80102f23:	c3                   	ret    
    panic("log.committing");
80102f24:	83 ec 0c             	sub    $0xc,%esp
80102f27:	68 84 7d 10 80       	push   $0x80107d84
80102f2c:	e8 4f d4 ff ff       	call   80100380 <panic>
80102f31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f3f:	90                   	nop

80102f40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
80102f43:	53                   	push   %ebx
80102f44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f47:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
80102f4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102f50:	83 fa 1d             	cmp    $0x1d,%edx
80102f53:	0f 8f 85 00 00 00    	jg     80102fde <log_write+0x9e>
80102f59:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102f5e:	83 e8 01             	sub    $0x1,%eax
80102f61:	39 c2                	cmp    %eax,%edx
80102f63:	7d 79                	jge    80102fde <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102f65:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102f6a:	85 c0                	test   %eax,%eax
80102f6c:	7e 7d                	jle    80102feb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102f6e:	83 ec 0c             	sub    $0xc,%esp
80102f71:	68 a0 26 11 80       	push   $0x801126a0
80102f76:	e8 65 1c 00 00       	call   80104be0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102f7b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	85 d2                	test   %edx,%edx
80102f86:	7e 4a                	jle    80102fd2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f88:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102f8b:	31 c0                	xor    %eax,%eax
80102f8d:	eb 08                	jmp    80102f97 <log_write+0x57>
80102f8f:	90                   	nop
80102f90:	83 c0 01             	add    $0x1,%eax
80102f93:	39 c2                	cmp    %eax,%edx
80102f95:	74 29                	je     80102fc0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102f97:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102f9e:	75 f0                	jne    80102f90 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80102fa0:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80102fa7:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80102faa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80102fad:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102fb4:	c9                   	leave  
  release(&log.lock);
80102fb5:	e9 c6 1b 00 00       	jmp    80104b80 <release>
80102fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102fc0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80102fc7:	83 c2 01             	add    $0x1,%edx
80102fca:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80102fd0:	eb d5                	jmp    80102fa7 <log_write+0x67>
  log.lh.block[i] = b->blockno;
80102fd2:	8b 43 08             	mov    0x8(%ebx),%eax
80102fd5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102fda:	75 cb                	jne    80102fa7 <log_write+0x67>
80102fdc:	eb e9                	jmp    80102fc7 <log_write+0x87>
    panic("too big a transaction");
80102fde:	83 ec 0c             	sub    $0xc,%esp
80102fe1:	68 93 7d 10 80       	push   $0x80107d93
80102fe6:	e8 95 d3 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
80102feb:	83 ec 0c             	sub    $0xc,%esp
80102fee:	68 a9 7d 10 80       	push   $0x80107da9
80102ff3:	e8 88 d3 ff ff       	call   80100380 <panic>
80102ff8:	66 90                	xchg   %ax,%ax
80102ffa:	66 90                	xchg   %ax,%ax
80102ffc:	66 90                	xchg   %ax,%ax
80102ffe:	66 90                	xchg   %ax,%ax

80103000 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103000:	55                   	push   %ebp
80103001:	89 e5                	mov    %esp,%ebp
80103003:	53                   	push   %ebx
80103004:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103007:	e8 64 09 00 00       	call   80103970 <cpuid>
8010300c:	89 c3                	mov    %eax,%ebx
8010300e:	e8 5d 09 00 00       	call   80103970 <cpuid>
80103013:	83 ec 04             	sub    $0x4,%esp
80103016:	53                   	push   %ebx
80103017:	50                   	push   %eax
80103018:	68 c4 7d 10 80       	push   $0x80107dc4
8010301d:	e8 7e d6 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
80103022:	e8 09 30 00 00       	call   80106030 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103027:	e8 e4 08 00 00       	call   80103910 <mycpu>
8010302c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010302e:	b8 01 00 00 00       	mov    $0x1,%eax
80103033:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010303a:	e8 a1 0c 00 00       	call   80103ce0 <scheduler>
8010303f:	90                   	nop

80103040 <mpenter>:
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103046:	e8 d5 40 00 00       	call   80107120 <switchkvm>
  seginit();
8010304b:	e8 40 40 00 00       	call   80107090 <seginit>
  lapicinit();
80103050:	e8 9b f7 ff ff       	call   801027f0 <lapicinit>
  mpmain();
80103055:	e8 a6 ff ff ff       	call   80103000 <mpmain>
8010305a:	66 90                	xchg   %ax,%ax
8010305c:	66 90                	xchg   %ax,%ax
8010305e:	66 90                	xchg   %ax,%ax

80103060 <main>:
{
80103060:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103064:	83 e4 f0             	and    $0xfffffff0,%esp
80103067:	ff 71 fc             	push   -0x4(%ecx)
8010306a:	55                   	push   %ebp
8010306b:	89 e5                	mov    %esp,%ebp
8010306d:	53                   	push   %ebx
8010306e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010306f:	83 ec 08             	sub    $0x8,%esp
80103072:	68 00 00 40 80       	push   $0x80400000
80103077:	68 d0 68 11 80       	push   $0x801168d0
8010307c:	e8 8f f5 ff ff       	call   80102610 <kinit1>
  kvmalloc();      // kernel page table
80103081:	e8 8a 45 00 00       	call   80107610 <kvmalloc>
  mpinit();        // detect other processors
80103086:	e8 85 01 00 00       	call   80103210 <mpinit>
  lapicinit();     // interrupt controller
8010308b:	e8 60 f7 ff ff       	call   801027f0 <lapicinit>
  seginit();       // segment descriptors
80103090:	e8 fb 3f 00 00       	call   80107090 <seginit>
  picinit();       // disable pic
80103095:	e8 76 03 00 00       	call   80103410 <picinit>
  ioapicinit();    // another interrupt controller
8010309a:	e8 31 f3 ff ff       	call   801023d0 <ioapicinit>
  consoleinit();   // console hardware
8010309f:	e8 bc d9 ff ff       	call   80100a60 <consoleinit>
  uartinit();      // serial port
801030a4:	e8 77 32 00 00       	call   80106320 <uartinit>
  pinit();         // process table
801030a9:	e8 42 08 00 00       	call   801038f0 <pinit>
  tvinit();        // trap vectors
801030ae:	e8 fd 2e 00 00       	call   80105fb0 <tvinit>
  binit();         // buffer cache
801030b3:	e8 88 cf ff ff       	call   80100040 <binit>
  fileinit();      // file table
801030b8:	e8 53 dd ff ff       	call   80100e10 <fileinit>
  ideinit();       // disk 
801030bd:	e8 fe f0 ff ff       	call   801021c0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801030c2:	83 c4 0c             	add    $0xc,%esp
801030c5:	68 8a 00 00 00       	push   $0x8a
801030ca:	68 8c b4 10 80       	push   $0x8010b48c
801030cf:	68 00 70 00 80       	push   $0x80007000
801030d4:	e8 67 1c 00 00       	call   80104d40 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801030d9:	83 c4 10             	add    $0x10,%esp
801030dc:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801030e3:	00 00 00 
801030e6:	05 a0 27 11 80       	add    $0x801127a0,%eax
801030eb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801030f0:	76 7e                	jbe    80103170 <main+0x110>
801030f2:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801030f7:	eb 20                	jmp    80103119 <main+0xb9>
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103100:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
80103107:	00 00 00 
8010310a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103110:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103115:	39 c3                	cmp    %eax,%ebx
80103117:	73 57                	jae    80103170 <main+0x110>
    if(c == mycpu())  // We've started already.
80103119:	e8 f2 07 00 00       	call   80103910 <mycpu>
8010311e:	39 c3                	cmp    %eax,%ebx
80103120:	74 de                	je     80103100 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103122:	e8 59 f5 ff ff       	call   80102680 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103127:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010312a:	c7 05 f8 6f 00 80 40 	movl   $0x80103040,0x80006ff8
80103131:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103134:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010313b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010313e:	05 00 10 00 00       	add    $0x1000,%eax
80103143:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103148:	0f b6 03             	movzbl (%ebx),%eax
8010314b:	68 00 70 00 00       	push   $0x7000
80103150:	50                   	push   %eax
80103151:	e8 ea f7 ff ff       	call   80102940 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103156:	83 c4 10             	add    $0x10,%esp
80103159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103160:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103166:	85 c0                	test   %eax,%eax
80103168:	74 f6                	je     80103160 <main+0x100>
8010316a:	eb 94                	jmp    80103100 <main+0xa0>
8010316c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103170:	83 ec 08             	sub    $0x8,%esp
80103173:	68 00 00 00 8e       	push   $0x8e000000
80103178:	68 00 00 40 80       	push   $0x80400000
8010317d:	e8 2e f4 ff ff       	call   801025b0 <kinit2>
  userinit();      // first user process
80103182:	e8 39 08 00 00       	call   801039c0 <userinit>
  mpmain();        // finish this processor's setup
80103187:	e8 74 fe ff ff       	call   80103000 <mpmain>
8010318c:	66 90                	xchg   %ax,%ax
8010318e:	66 90                	xchg   %ax,%ax

80103190 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	57                   	push   %edi
80103194:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103195:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010319b:	53                   	push   %ebx
  e = addr+len;
8010319c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010319f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801031a2:	39 de                	cmp    %ebx,%esi
801031a4:	72 10                	jb     801031b6 <mpsearch1+0x26>
801031a6:	eb 50                	jmp    801031f8 <mpsearch1+0x68>
801031a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031af:	90                   	nop
801031b0:	89 fe                	mov    %edi,%esi
801031b2:	39 fb                	cmp    %edi,%ebx
801031b4:	76 42                	jbe    801031f8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031b6:	83 ec 04             	sub    $0x4,%esp
801031b9:	8d 7e 10             	lea    0x10(%esi),%edi
801031bc:	6a 04                	push   $0x4
801031be:	68 d8 7d 10 80       	push   $0x80107dd8
801031c3:	56                   	push   %esi
801031c4:	e8 27 1b 00 00       	call   80104cf0 <memcmp>
801031c9:	83 c4 10             	add    $0x10,%esp
801031cc:	85 c0                	test   %eax,%eax
801031ce:	75 e0                	jne    801031b0 <mpsearch1+0x20>
801031d0:	89 f2                	mov    %esi,%edx
801031d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801031d8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801031db:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801031de:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801031e0:	39 fa                	cmp    %edi,%edx
801031e2:	75 f4                	jne    801031d8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801031e4:	84 c0                	test   %al,%al
801031e6:	75 c8                	jne    801031b0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801031e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031eb:	89 f0                	mov    %esi,%eax
801031ed:	5b                   	pop    %ebx
801031ee:	5e                   	pop    %esi
801031ef:	5f                   	pop    %edi
801031f0:	5d                   	pop    %ebp
801031f1:	c3                   	ret    
801031f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801031f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801031fb:	31 f6                	xor    %esi,%esi
}
801031fd:	5b                   	pop    %ebx
801031fe:	89 f0                	mov    %esi,%eax
80103200:	5e                   	pop    %esi
80103201:	5f                   	pop    %edi
80103202:	5d                   	pop    %ebp
80103203:	c3                   	ret    
80103204:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010320b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010320f:	90                   	nop

80103210 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103210:	55                   	push   %ebp
80103211:	89 e5                	mov    %esp,%ebp
80103213:	57                   	push   %edi
80103214:	56                   	push   %esi
80103215:	53                   	push   %ebx
80103216:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103219:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103220:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103227:	c1 e0 08             	shl    $0x8,%eax
8010322a:	09 d0                	or     %edx,%eax
8010322c:	c1 e0 04             	shl    $0x4,%eax
8010322f:	75 1b                	jne    8010324c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103231:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103238:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010323f:	c1 e0 08             	shl    $0x8,%eax
80103242:	09 d0                	or     %edx,%eax
80103244:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103247:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010324c:	ba 00 04 00 00       	mov    $0x400,%edx
80103251:	e8 3a ff ff ff       	call   80103190 <mpsearch1>
80103256:	89 c3                	mov    %eax,%ebx
80103258:	85 c0                	test   %eax,%eax
8010325a:	0f 84 40 01 00 00    	je     801033a0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103260:	8b 73 04             	mov    0x4(%ebx),%esi
80103263:	85 f6                	test   %esi,%esi
80103265:	0f 84 25 01 00 00    	je     80103390 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010326b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010326e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103274:	6a 04                	push   $0x4
80103276:	68 dd 7d 10 80       	push   $0x80107ddd
8010327b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010327c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010327f:	e8 6c 1a 00 00       	call   80104cf0 <memcmp>
80103284:	83 c4 10             	add    $0x10,%esp
80103287:	85 c0                	test   %eax,%eax
80103289:	0f 85 01 01 00 00    	jne    80103390 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010328f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103296:	3c 01                	cmp    $0x1,%al
80103298:	74 08                	je     801032a2 <mpinit+0x92>
8010329a:	3c 04                	cmp    $0x4,%al
8010329c:	0f 85 ee 00 00 00    	jne    80103390 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
801032a2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801032a9:	66 85 d2             	test   %dx,%dx
801032ac:	74 22                	je     801032d0 <mpinit+0xc0>
801032ae:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801032b1:	89 f0                	mov    %esi,%eax
  sum = 0;
801032b3:	31 d2                	xor    %edx,%edx
801032b5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801032b8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801032bf:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801032c2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801032c4:	39 c7                	cmp    %eax,%edi
801032c6:	75 f0                	jne    801032b8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801032c8:	84 d2                	test   %dl,%dl
801032ca:	0f 85 c0 00 00 00    	jne    80103390 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801032d0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801032d6:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032db:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801032e2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801032e8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801032ed:	03 55 e4             	add    -0x1c(%ebp),%edx
801032f0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801032f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801032f7:	90                   	nop
801032f8:	39 d0                	cmp    %edx,%eax
801032fa:	73 15                	jae    80103311 <mpinit+0x101>
    switch(*p){
801032fc:	0f b6 08             	movzbl (%eax),%ecx
801032ff:	80 f9 02             	cmp    $0x2,%cl
80103302:	74 4c                	je     80103350 <mpinit+0x140>
80103304:	77 3a                	ja     80103340 <mpinit+0x130>
80103306:	84 c9                	test   %cl,%cl
80103308:	74 56                	je     80103360 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
8010330a:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010330d:	39 d0                	cmp    %edx,%eax
8010330f:	72 eb                	jb     801032fc <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103311:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103314:	85 f6                	test   %esi,%esi
80103316:	0f 84 d9 00 00 00    	je     801033f5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010331c:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103320:	74 15                	je     80103337 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103322:	b8 70 00 00 00       	mov    $0x70,%eax
80103327:	ba 22 00 00 00       	mov    $0x22,%edx
8010332c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010332d:	ba 23 00 00 00       	mov    $0x23,%edx
80103332:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103333:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103336:	ee                   	out    %al,(%dx)
  }
}
80103337:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010333a:	5b                   	pop    %ebx
8010333b:	5e                   	pop    %esi
8010333c:	5f                   	pop    %edi
8010333d:	5d                   	pop    %ebp
8010333e:	c3                   	ret    
8010333f:	90                   	nop
    switch(*p){
80103340:	83 e9 03             	sub    $0x3,%ecx
80103343:	80 f9 01             	cmp    $0x1,%cl
80103346:	76 c2                	jbe    8010330a <mpinit+0xfa>
80103348:	31 f6                	xor    %esi,%esi
8010334a:	eb ac                	jmp    801032f8 <mpinit+0xe8>
8010334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103350:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103354:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103357:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010335d:	eb 99                	jmp    801032f8 <mpinit+0xe8>
8010335f:	90                   	nop
      if(ncpu < NCPU) {
80103360:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103366:	83 f9 07             	cmp    $0x7,%ecx
80103369:	7f 19                	jg     80103384 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010336b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103371:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103375:	83 c1 01             	add    $0x1,%ecx
80103378:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010337e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103384:	83 c0 14             	add    $0x14,%eax
      continue;
80103387:	e9 6c ff ff ff       	jmp    801032f8 <mpinit+0xe8>
8010338c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103390:	83 ec 0c             	sub    $0xc,%esp
80103393:	68 e2 7d 10 80       	push   $0x80107de2
80103398:	e8 e3 cf ff ff       	call   80100380 <panic>
8010339d:	8d 76 00             	lea    0x0(%esi),%esi
{
801033a0:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801033a5:	eb 13                	jmp    801033ba <mpinit+0x1aa>
801033a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ae:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
801033b0:	89 f3                	mov    %esi,%ebx
801033b2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801033b8:	74 d6                	je     80103390 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ba:	83 ec 04             	sub    $0x4,%esp
801033bd:	8d 73 10             	lea    0x10(%ebx),%esi
801033c0:	6a 04                	push   $0x4
801033c2:	68 d8 7d 10 80       	push   $0x80107dd8
801033c7:	53                   	push   %ebx
801033c8:	e8 23 19 00 00       	call   80104cf0 <memcmp>
801033cd:	83 c4 10             	add    $0x10,%esp
801033d0:	85 c0                	test   %eax,%eax
801033d2:	75 dc                	jne    801033b0 <mpinit+0x1a0>
801033d4:	89 da                	mov    %ebx,%edx
801033d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033dd:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801033e0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801033e3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801033e6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801033e8:	39 d6                	cmp    %edx,%esi
801033ea:	75 f4                	jne    801033e0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801033ec:	84 c0                	test   %al,%al
801033ee:	75 c0                	jne    801033b0 <mpinit+0x1a0>
801033f0:	e9 6b fe ff ff       	jmp    80103260 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801033f5:	83 ec 0c             	sub    $0xc,%esp
801033f8:	68 fc 7d 10 80       	push   $0x80107dfc
801033fd:	e8 7e cf ff ff       	call   80100380 <panic>
80103402:	66 90                	xchg   %ax,%ax
80103404:	66 90                	xchg   %ax,%ax
80103406:	66 90                	xchg   %ax,%ax
80103408:	66 90                	xchg   %ax,%ax
8010340a:	66 90                	xchg   %ax,%ax
8010340c:	66 90                	xchg   %ax,%ax
8010340e:	66 90                	xchg   %ax,%ax

80103410 <picinit>:
80103410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103415:	ba 21 00 00 00       	mov    $0x21,%edx
8010341a:	ee                   	out    %al,(%dx)
8010341b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103420:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103421:	c3                   	ret    
80103422:	66 90                	xchg   %ax,%ax
80103424:	66 90                	xchg   %ax,%ax
80103426:	66 90                	xchg   %ax,%ax
80103428:	66 90                	xchg   %ax,%ax
8010342a:	66 90                	xchg   %ax,%ax
8010342c:	66 90                	xchg   %ax,%ax
8010342e:	66 90                	xchg   %ax,%ax

80103430 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 0c             	sub    $0xc,%esp
80103439:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010343c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010343f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103445:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010344b:	e8 e0 d9 ff ff       	call   80100e30 <filealloc>
80103450:	89 03                	mov    %eax,(%ebx)
80103452:	85 c0                	test   %eax,%eax
80103454:	0f 84 a8 00 00 00    	je     80103502 <pipealloc+0xd2>
8010345a:	e8 d1 d9 ff ff       	call   80100e30 <filealloc>
8010345f:	89 06                	mov    %eax,(%esi)
80103461:	85 c0                	test   %eax,%eax
80103463:	0f 84 87 00 00 00    	je     801034f0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103469:	e8 12 f2 ff ff       	call   80102680 <kalloc>
8010346e:	89 c7                	mov    %eax,%edi
80103470:	85 c0                	test   %eax,%eax
80103472:	0f 84 b0 00 00 00    	je     80103528 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103478:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010347f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103482:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103485:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010348c:	00 00 00 
  p->nwrite = 0;
8010348f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103496:	00 00 00 
  p->nread = 0;
80103499:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801034a0:	00 00 00 
  initlock(&p->lock, "pipe");
801034a3:	68 1b 7e 10 80       	push   $0x80107e1b
801034a8:	50                   	push   %eax
801034a9:	e8 62 15 00 00       	call   80104a10 <initlock>
  (*f0)->type = FD_PIPE;
801034ae:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034b0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801034b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801034b9:	8b 03                	mov    (%ebx),%eax
801034bb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801034bf:	8b 03                	mov    (%ebx),%eax
801034c1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801034c5:	8b 03                	mov    (%ebx),%eax
801034c7:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
801034ca:	8b 06                	mov    (%esi),%eax
801034cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801034d2:	8b 06                	mov    (%esi),%eax
801034d4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801034d8:	8b 06                	mov    (%esi),%eax
801034da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801034de:	8b 06                	mov    (%esi),%eax
801034e0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801034e6:	31 c0                	xor    %eax,%eax
}
801034e8:	5b                   	pop    %ebx
801034e9:	5e                   	pop    %esi
801034ea:	5f                   	pop    %edi
801034eb:	5d                   	pop    %ebp
801034ec:	c3                   	ret    
801034ed:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801034f0:	8b 03                	mov    (%ebx),%eax
801034f2:	85 c0                	test   %eax,%eax
801034f4:	74 1e                	je     80103514 <pipealloc+0xe4>
    fileclose(*f0);
801034f6:	83 ec 0c             	sub    $0xc,%esp
801034f9:	50                   	push   %eax
801034fa:	e8 f1 d9 ff ff       	call   80100ef0 <fileclose>
801034ff:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103502:	8b 06                	mov    (%esi),%eax
80103504:	85 c0                	test   %eax,%eax
80103506:	74 0c                	je     80103514 <pipealloc+0xe4>
    fileclose(*f1);
80103508:	83 ec 0c             	sub    $0xc,%esp
8010350b:	50                   	push   %eax
8010350c:	e8 df d9 ff ff       	call   80100ef0 <fileclose>
80103511:	83 c4 10             	add    $0x10,%esp
}
80103514:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
80103517:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010351c:	5b                   	pop    %ebx
8010351d:	5e                   	pop    %esi
8010351e:	5f                   	pop    %edi
8010351f:	5d                   	pop    %ebp
80103520:	c3                   	ret    
80103521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103528:	8b 03                	mov    (%ebx),%eax
8010352a:	85 c0                	test   %eax,%eax
8010352c:	75 c8                	jne    801034f6 <pipealloc+0xc6>
8010352e:	eb d2                	jmp    80103502 <pipealloc+0xd2>

80103530 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	56                   	push   %esi
80103534:	53                   	push   %ebx
80103535:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103538:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010353b:	83 ec 0c             	sub    $0xc,%esp
8010353e:	53                   	push   %ebx
8010353f:	e8 9c 16 00 00       	call   80104be0 <acquire>
  if(writable){
80103544:	83 c4 10             	add    $0x10,%esp
80103547:	85 f6                	test   %esi,%esi
80103549:	74 65                	je     801035b0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010354b:	83 ec 0c             	sub    $0xc,%esp
8010354e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103554:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010355b:	00 00 00 
    wakeup(&p->nread);
8010355e:	50                   	push   %eax
8010355f:	e8 1c 0b 00 00       	call   80104080 <wakeup>
80103564:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103567:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010356d:	85 d2                	test   %edx,%edx
8010356f:	75 0a                	jne    8010357b <pipeclose+0x4b>
80103571:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103577:	85 c0                	test   %eax,%eax
80103579:	74 15                	je     80103590 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010357b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010357e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103581:	5b                   	pop    %ebx
80103582:	5e                   	pop    %esi
80103583:	5d                   	pop    %ebp
    release(&p->lock);
80103584:	e9 f7 15 00 00       	jmp    80104b80 <release>
80103589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103590:	83 ec 0c             	sub    $0xc,%esp
80103593:	53                   	push   %ebx
80103594:	e8 e7 15 00 00       	call   80104b80 <release>
    kfree((char*)p);
80103599:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010359c:	83 c4 10             	add    $0x10,%esp
}
8010359f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801035a2:	5b                   	pop    %ebx
801035a3:	5e                   	pop    %esi
801035a4:	5d                   	pop    %ebp
    kfree((char*)p);
801035a5:	e9 16 ef ff ff       	jmp    801024c0 <kfree>
801035aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801035b0:	83 ec 0c             	sub    $0xc,%esp
801035b3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801035b9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801035c0:	00 00 00 
    wakeup(&p->nwrite);
801035c3:	50                   	push   %eax
801035c4:	e8 b7 0a 00 00       	call   80104080 <wakeup>
801035c9:	83 c4 10             	add    $0x10,%esp
801035cc:	eb 99                	jmp    80103567 <pipeclose+0x37>
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	57                   	push   %edi
801035d4:	56                   	push   %esi
801035d5:	53                   	push   %ebx
801035d6:	83 ec 28             	sub    $0x28,%esp
801035d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801035dc:	53                   	push   %ebx
801035dd:	e8 fe 15 00 00       	call   80104be0 <acquire>
  for(i = 0; i < n; i++){
801035e2:	8b 45 10             	mov    0x10(%ebp),%eax
801035e5:	83 c4 10             	add    $0x10,%esp
801035e8:	85 c0                	test   %eax,%eax
801035ea:	0f 8e c0 00 00 00    	jle    801036b0 <pipewrite+0xe0>
801035f0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035f3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801035f9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801035ff:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103602:	03 45 10             	add    0x10(%ebp),%eax
80103605:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103608:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010360e:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103614:	89 ca                	mov    %ecx,%edx
80103616:	05 00 02 00 00       	add    $0x200,%eax
8010361b:	39 c1                	cmp    %eax,%ecx
8010361d:	74 3f                	je     8010365e <pipewrite+0x8e>
8010361f:	eb 67                	jmp    80103688 <pipewrite+0xb8>
80103621:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103628:	e8 63 03 00 00       	call   80103990 <myproc>
8010362d:	8b 48 24             	mov    0x24(%eax),%ecx
80103630:	85 c9                	test   %ecx,%ecx
80103632:	75 34                	jne    80103668 <pipewrite+0x98>
      wakeup(&p->nread);
80103634:	83 ec 0c             	sub    $0xc,%esp
80103637:	57                   	push   %edi
80103638:	e8 43 0a 00 00       	call   80104080 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010363d:	58                   	pop    %eax
8010363e:	5a                   	pop    %edx
8010363f:	53                   	push   %ebx
80103640:	56                   	push   %esi
80103641:	e8 7a 09 00 00       	call   80103fc0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103646:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
8010364c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103652:	83 c4 10             	add    $0x10,%esp
80103655:	05 00 02 00 00       	add    $0x200,%eax
8010365a:	39 c2                	cmp    %eax,%edx
8010365c:	75 2a                	jne    80103688 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
8010365e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103664:	85 c0                	test   %eax,%eax
80103666:	75 c0                	jne    80103628 <pipewrite+0x58>
        release(&p->lock);
80103668:	83 ec 0c             	sub    $0xc,%esp
8010366b:	53                   	push   %ebx
8010366c:	e8 0f 15 00 00       	call   80104b80 <release>
        return -1;
80103671:	83 c4 10             	add    $0x10,%esp
80103674:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103679:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010367c:	5b                   	pop    %ebx
8010367d:	5e                   	pop    %esi
8010367e:	5f                   	pop    %edi
8010367f:	5d                   	pop    %ebp
80103680:	c3                   	ret    
80103681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103688:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010368b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010368e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103694:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
8010369a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
8010369d:	83 c6 01             	add    $0x1,%esi
801036a0:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801036a3:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801036a7:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801036aa:	0f 85 58 ff ff ff    	jne    80103608 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801036b0:	83 ec 0c             	sub    $0xc,%esp
801036b3:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801036b9:	50                   	push   %eax
801036ba:	e8 c1 09 00 00       	call   80104080 <wakeup>
  release(&p->lock);
801036bf:	89 1c 24             	mov    %ebx,(%esp)
801036c2:	e8 b9 14 00 00       	call   80104b80 <release>
  return n;
801036c7:	8b 45 10             	mov    0x10(%ebp),%eax
801036ca:	83 c4 10             	add    $0x10,%esp
801036cd:	eb aa                	jmp    80103679 <pipewrite+0xa9>
801036cf:	90                   	nop

801036d0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801036d0:	55                   	push   %ebp
801036d1:	89 e5                	mov    %esp,%ebp
801036d3:	57                   	push   %edi
801036d4:	56                   	push   %esi
801036d5:	53                   	push   %ebx
801036d6:	83 ec 18             	sub    $0x18,%esp
801036d9:	8b 75 08             	mov    0x8(%ebp),%esi
801036dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036df:	56                   	push   %esi
801036e0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801036e6:	e8 f5 14 00 00       	call   80104be0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036eb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801036f1:	83 c4 10             	add    $0x10,%esp
801036f4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
801036fa:	74 2f                	je     8010372b <piperead+0x5b>
801036fc:	eb 37                	jmp    80103735 <piperead+0x65>
801036fe:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103700:	e8 8b 02 00 00       	call   80103990 <myproc>
80103705:	8b 48 24             	mov    0x24(%eax),%ecx
80103708:	85 c9                	test   %ecx,%ecx
8010370a:	0f 85 80 00 00 00    	jne    80103790 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103710:	83 ec 08             	sub    $0x8,%esp
80103713:	56                   	push   %esi
80103714:	53                   	push   %ebx
80103715:	e8 a6 08 00 00       	call   80103fc0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010371a:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103720:	83 c4 10             	add    $0x10,%esp
80103723:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103729:	75 0a                	jne    80103735 <piperead+0x65>
8010372b:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103731:	85 c0                	test   %eax,%eax
80103733:	75 cb                	jne    80103700 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103735:	8b 55 10             	mov    0x10(%ebp),%edx
80103738:	31 db                	xor    %ebx,%ebx
8010373a:	85 d2                	test   %edx,%edx
8010373c:	7f 20                	jg     8010375e <piperead+0x8e>
8010373e:	eb 2c                	jmp    8010376c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103740:	8d 48 01             	lea    0x1(%eax),%ecx
80103743:	25 ff 01 00 00       	and    $0x1ff,%eax
80103748:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010374e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103753:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103756:	83 c3 01             	add    $0x1,%ebx
80103759:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010375c:	74 0e                	je     8010376c <piperead+0x9c>
    if(p->nread == p->nwrite)
8010375e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103764:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010376a:	75 d4                	jne    80103740 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010376c:	83 ec 0c             	sub    $0xc,%esp
8010376f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103775:	50                   	push   %eax
80103776:	e8 05 09 00 00       	call   80104080 <wakeup>
  release(&p->lock);
8010377b:	89 34 24             	mov    %esi,(%esp)
8010377e:	e8 fd 13 00 00       	call   80104b80 <release>
  return i;
80103783:	83 c4 10             	add    $0x10,%esp
}
80103786:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103789:	89 d8                	mov    %ebx,%eax
8010378b:	5b                   	pop    %ebx
8010378c:	5e                   	pop    %esi
8010378d:	5f                   	pop    %edi
8010378e:	5d                   	pop    %ebp
8010378f:	c3                   	ret    
      release(&p->lock);
80103790:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103793:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103798:	56                   	push   %esi
80103799:	e8 e2 13 00 00       	call   80104b80 <release>
      return -1;
8010379e:	83 c4 10             	add    $0x10,%esp
}
801037a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037a4:	89 d8                	mov    %ebx,%eax
801037a6:	5b                   	pop    %ebx
801037a7:	5e                   	pop    %esi
801037a8:	5f                   	pop    %edi
801037a9:	5d                   	pop    %ebp
801037aa:	c3                   	ret    
801037ab:	66 90                	xchg   %ax,%ax
801037ad:	66 90                	xchg   %ax,%ax
801037af:	90                   	nop

801037b0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037b4:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
{
801037b9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801037bc:	68 20 2d 11 80       	push   $0x80112d20
801037c1:	e8 1a 14 00 00       	call   80104be0 <acquire>
801037c6:	83 c4 10             	add    $0x10,%esp
801037c9:	eb 17                	jmp    801037e2 <allocproc+0x32>
801037cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037cf:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037d0:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
801037d6:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
801037dc:	0f 84 8e 00 00 00    	je     80103870 <allocproc+0xc0>
    if(p->state == UNUSED)
801037e2:	8b 43 0c             	mov    0xc(%ebx),%eax
801037e5:	85 c0                	test   %eax,%eax
801037e7:	75 e7                	jne    801037d0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037e9:	a1 04 b0 10 80       	mov    0x8010b004,%eax

	p->nexttid = 0;
	p->tid = -1;

  release(&ptable.lock);
801037ee:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801037f1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
	p->nexttid = 0;
801037f8:	c7 83 80 00 00 00 00 	movl   $0x0,0x80(%ebx)
801037ff:	00 00 00 
  p->pid = nextpid++;
80103802:	89 43 10             	mov    %eax,0x10(%ebx)
80103805:	8d 50 01             	lea    0x1(%eax),%edx
	p->tid = -1;
80103808:	c7 43 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ebx)
  release(&ptable.lock);
8010380f:	68 20 2d 11 80       	push   $0x80112d20
  p->pid = nextpid++;
80103814:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
8010381a:	e8 61 13 00 00       	call   80104b80 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010381f:	e8 5c ee ff ff       	call   80102680 <kalloc>
80103824:	83 c4 10             	add    $0x10,%esp
80103827:	89 43 08             	mov    %eax,0x8(%ebx)
8010382a:	85 c0                	test   %eax,%eax
8010382c:	74 5b                	je     80103889 <allocproc+0xd9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010382e:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103834:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103837:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010383c:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
8010383f:	c7 40 14 97 5f 10 80 	movl   $0x80105f97,0x14(%eax)
  p->context = (struct context*)sp;
80103846:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103849:	6a 14                	push   $0x14
8010384b:	6a 00                	push   $0x0
8010384d:	50                   	push   %eax
8010384e:	e8 4d 14 00 00       	call   80104ca0 <memset>
  p->context->eip = (uint)forkret;
80103853:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103856:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103859:	c7 40 10 a0 38 10 80 	movl   $0x801038a0,0x10(%eax)
}
80103860:	89 d8                	mov    %ebx,%eax
80103862:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103865:	c9                   	leave  
80103866:	c3                   	ret    
80103867:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010386e:	66 90                	xchg   %ax,%ax
  release(&ptable.lock);
80103870:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103873:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103875:	68 20 2d 11 80       	push   $0x80112d20
8010387a:	e8 01 13 00 00       	call   80104b80 <release>
}
8010387f:	89 d8                	mov    %ebx,%eax
  return 0;
80103881:	83 c4 10             	add    $0x10,%esp
}
80103884:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103887:	c9                   	leave  
80103888:	c3                   	ret    
    p->state = UNUSED;
80103889:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103890:	31 db                	xor    %ebx,%ebx
}
80103892:	89 d8                	mov    %ebx,%eax
80103894:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103897:	c9                   	leave  
80103898:	c3                   	ret    
80103899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038a6:	68 20 2d 11 80       	push   $0x80112d20
801038ab:	e8 d0 12 00 00       	call   80104b80 <release>

  if (first) {
801038b0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
801038b5:	83 c4 10             	add    $0x10,%esp
801038b8:	85 c0                	test   %eax,%eax
801038ba:	75 04                	jne    801038c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038bc:	c9                   	leave  
801038bd:	c3                   	ret    
801038be:	66 90                	xchg   %ax,%ax
    first = 0;
801038c0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
801038c7:	00 00 00 
    iinit(ROOTDEV);
801038ca:	83 ec 0c             	sub    $0xc,%esp
801038cd:	6a 01                	push   $0x1
801038cf:	e8 8c dc ff ff       	call   80101560 <iinit>
    initlog(ROOTDEV);
801038d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038db:	e8 e0 f3 ff ff       	call   80102cc0 <initlog>
}
801038e0:	83 c4 10             	add    $0x10,%esp
801038e3:	c9                   	leave  
801038e4:	c3                   	ret    
801038e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801038f0 <pinit>:
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038f6:	68 20 7e 10 80       	push   $0x80107e20
801038fb:	68 20 2d 11 80       	push   $0x80112d20
80103900:	e8 0b 11 00 00       	call   80104a10 <initlock>
}
80103905:	83 c4 10             	add    $0x10,%esp
80103908:	c9                   	leave  
80103909:	c3                   	ret    
8010390a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103910 <mycpu>:
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	56                   	push   %esi
80103914:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103915:	9c                   	pushf  
80103916:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103917:	f6 c4 02             	test   $0x2,%ah
8010391a:	75 46                	jne    80103962 <mycpu+0x52>
  apicid = lapicid();
8010391c:	e8 cf ef ff ff       	call   801028f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103921:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103927:	85 f6                	test   %esi,%esi
80103929:	7e 2a                	jle    80103955 <mycpu+0x45>
8010392b:	31 d2                	xor    %edx,%edx
8010392d:	eb 08                	jmp    80103937 <mycpu+0x27>
8010392f:	90                   	nop
80103930:	83 c2 01             	add    $0x1,%edx
80103933:	39 f2                	cmp    %esi,%edx
80103935:	74 1e                	je     80103955 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103937:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010393d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103944:	39 c3                	cmp    %eax,%ebx
80103946:	75 e8                	jne    80103930 <mycpu+0x20>
}
80103948:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010394b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103951:	5b                   	pop    %ebx
80103952:	5e                   	pop    %esi
80103953:	5d                   	pop    %ebp
80103954:	c3                   	ret    
  panic("unknown apicid\n");
80103955:	83 ec 0c             	sub    $0xc,%esp
80103958:	68 27 7e 10 80       	push   $0x80107e27
8010395d:	e8 1e ca ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103962:	83 ec 0c             	sub    $0xc,%esp
80103965:	68 04 7f 10 80       	push   $0x80107f04
8010396a:	e8 11 ca ff ff       	call   80100380 <panic>
8010396f:	90                   	nop

80103970 <cpuid>:
cpuid() {
80103970:	55                   	push   %ebp
80103971:	89 e5                	mov    %esp,%ebp
80103973:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103976:	e8 95 ff ff ff       	call   80103910 <mycpu>
}
8010397b:	c9                   	leave  
  return mycpu()-cpus;
8010397c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103981:	c1 f8 04             	sar    $0x4,%eax
80103984:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010398a:	c3                   	ret    
8010398b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010398f:	90                   	nop

80103990 <myproc>:
myproc(void) {
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	53                   	push   %ebx
80103994:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103997:	e8 f4 10 00 00       	call   80104a90 <pushcli>
  c = mycpu();
8010399c:	e8 6f ff ff ff       	call   80103910 <mycpu>
  p = c->proc;
801039a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801039a7:	e8 34 11 00 00       	call   80104ae0 <popcli>
}
801039ac:	89 d8                	mov    %ebx,%eax
801039ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039b1:	c9                   	leave  
801039b2:	c3                   	ret    
801039b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801039c0 <userinit>:
{
801039c0:	55                   	push   %ebp
801039c1:	89 e5                	mov    %esp,%ebp
801039c3:	53                   	push   %ebx
801039c4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
801039c7:	e8 e4 fd ff ff       	call   801037b0 <allocproc>
801039cc:	89 c3                	mov    %eax,%ebx
  initproc = p;
801039ce:	a3 54 50 11 80       	mov    %eax,0x80115054
  if((p->pgdir = setupkvm()) == 0)
801039d3:	e8 b8 3b 00 00       	call   80107590 <setupkvm>
801039d8:	89 43 04             	mov    %eax,0x4(%ebx)
801039db:	85 c0                	test   %eax,%eax
801039dd:	0f 84 d4 00 00 00    	je     80103ab7 <userinit+0xf7>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039e3:	83 ec 04             	sub    $0x4,%esp
801039e6:	68 2c 00 00 00       	push   $0x2c
801039eb:	68 60 b4 10 80       	push   $0x8010b460
801039f0:	50                   	push   %eax
801039f1:	e8 4a 38 00 00       	call   80107240 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039f6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039f9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039ff:	6a 4c                	push   $0x4c
80103a01:	6a 00                	push   $0x0
80103a03:	ff 73 18             	push   0x18(%ebx)
80103a06:	e8 95 12 00 00       	call   80104ca0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a0b:	8b 43 18             	mov    0x18(%ebx),%eax
80103a0e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a13:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a16:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103a1b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103a1f:	8b 43 18             	mov    0x18(%ebx),%eax
80103a22:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103a26:	8b 43 18             	mov    0x18(%ebx),%eax
80103a29:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a2d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a31:	8b 43 18             	mov    0x18(%ebx),%eax
80103a34:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a38:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a3c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a3f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a46:	8b 43 18             	mov    0x18(%ebx),%eax
80103a49:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a50:	8b 43 18             	mov    0x18(%ebx),%eax
80103a53:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a5a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103a5d:	6a 10                	push   $0x10
80103a5f:	68 50 7e 10 80       	push   $0x80107e50
80103a64:	50                   	push   %eax
80103a65:	e8 f6 13 00 00       	call   80104e60 <safestrcpy>
  p->cwd = namei("/");
80103a6a:	c7 04 24 59 7e 10 80 	movl   $0x80107e59,(%esp)
80103a71:	e8 2a e6 ff ff       	call   801020a0 <namei>
	p->mthread = p;
80103a76:	89 9b 84 00 00 00    	mov    %ebx,0x84(%ebx)
  p->cwd = namei("/");
80103a7c:	89 43 68             	mov    %eax,0x68(%ebx)
	p->tid = 0;
80103a7f:	c7 43 7c 00 00 00 00 	movl   $0x0,0x7c(%ebx)
	p->nexttid = 1;
80103a86:	c7 83 80 00 00 00 01 	movl   $0x1,0x80(%ebx)
80103a8d:	00 00 00 
  acquire(&ptable.lock);
80103a90:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a97:	e8 44 11 00 00       	call   80104be0 <acquire>
  p->state = RUNNABLE;
80103a9c:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103aa3:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103aaa:	e8 d1 10 00 00       	call   80104b80 <release>
}
80103aaf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ab2:	83 c4 10             	add    $0x10,%esp
80103ab5:	c9                   	leave  
80103ab6:	c3                   	ret    
    panic("userinit: out of memory?");
80103ab7:	83 ec 0c             	sub    $0xc,%esp
80103aba:	68 37 7e 10 80       	push   $0x80107e37
80103abf:	e8 bc c8 ff ff       	call   80100380 <panic>
80103ac4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103acb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103acf:	90                   	nop

80103ad0 <growproc>:
{
80103ad0:	55                   	push   %ebp
80103ad1:	89 e5                	mov    %esp,%ebp
80103ad3:	57                   	push   %edi
80103ad4:	56                   	push   %esi
80103ad5:	53                   	push   %ebx
80103ad6:	83 ec 0c             	sub    $0xc,%esp
80103ad9:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
80103adc:	e8 af 0f 00 00       	call   80104a90 <pushcli>
  c = mycpu();
80103ae1:	e8 2a fe ff ff       	call   80103910 <mycpu>
  p = c->proc;
80103ae6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103aec:	e8 ef 0f 00 00       	call   80104ae0 <popcli>
	acquire(&ptable.lock);
80103af1:	83 ec 0c             	sub    $0xc,%esp
	struct proc *mthread = curproc->mthread;
80103af4:	8b 9e 84 00 00 00    	mov    0x84(%esi),%ebx
	acquire(&ptable.lock);
80103afa:	68 20 2d 11 80       	push   $0x80112d20
80103aff:	e8 dc 10 00 00       	call   80104be0 <acquire>
  sz = curproc->sz;
80103b04:	8b 06                	mov    (%esi),%eax
  if(n > 0){
80103b06:	83 c4 10             	add    $0x10,%esp
80103b09:	85 ff                	test   %edi,%edi
80103b0b:	7f 51                	jg     80103b5e <growproc+0x8e>
  } else if(n < 0){
80103b0d:	75 71                	jne    80103b80 <growproc+0xb0>
  mthread->sz = sz;
80103b0f:	89 03                	mov    %eax,(%ebx)

void 
updatesz(struct proc* mthread)
{
	struct proc* p;
	for(p=ptable.proc;p<&ptable.proc[NPROC]; p++){
80103b11:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103b16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b1d:	8d 76 00             	lea    0x0(%esi),%esi
		if(p->pid == mthread->pid && p != mthread){
80103b20:	8b 4b 10             	mov    0x10(%ebx),%ecx
80103b23:	39 48 10             	cmp    %ecx,0x10(%eax)
80103b26:	75 08                	jne    80103b30 <growproc+0x60>
80103b28:	39 c3                	cmp    %eax,%ebx
80103b2a:	74 04                	je     80103b30 <growproc+0x60>
			p->sz = mthread->sz;
80103b2c:	8b 13                	mov    (%ebx),%edx
80103b2e:	89 10                	mov    %edx,(%eax)
	for(p=ptable.proc;p<&ptable.proc[NPROC]; p++){
80103b30:	05 8c 00 00 00       	add    $0x8c,%eax
80103b35:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80103b3a:	75 e4                	jne    80103b20 <growproc+0x50>
	release(&ptable.lock);
80103b3c:	83 ec 0c             	sub    $0xc,%esp
80103b3f:	68 20 2d 11 80       	push   $0x80112d20
80103b44:	e8 37 10 00 00       	call   80104b80 <release>
	switchuvm(curproc);
80103b49:	89 34 24             	mov    %esi,(%esp)
80103b4c:	e8 df 35 00 00       	call   80107130 <switchuvm>
  return 0;
80103b51:	83 c4 10             	add    $0x10,%esp
80103b54:	31 c0                	xor    %eax,%eax
}
80103b56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b59:	5b                   	pop    %ebx
80103b5a:	5e                   	pop    %esi
80103b5b:	5f                   	pop    %edi
80103b5c:	5d                   	pop    %ebp
80103b5d:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b5e:	83 ec 04             	sub    $0x4,%esp
80103b61:	01 c7                	add    %eax,%edi
80103b63:	57                   	push   %edi
80103b64:	50                   	push   %eax
80103b65:	ff 76 04             	push   0x4(%esi)
80103b68:	e8 43 38 00 00       	call   801073b0 <allocuvm>
80103b6d:	83 c4 10             	add    $0x10,%esp
80103b70:	85 c0                	test   %eax,%eax
80103b72:	75 9b                	jne    80103b0f <growproc+0x3f>
      return -1;
80103b74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b79:	eb db                	jmp    80103b56 <growproc+0x86>
80103b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b7f:	90                   	nop
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b80:	83 ec 04             	sub    $0x4,%esp
80103b83:	01 c7                	add    %eax,%edi
80103b85:	57                   	push   %edi
80103b86:	50                   	push   %eax
80103b87:	ff 76 04             	push   0x4(%esi)
80103b8a:	e8 51 39 00 00       	call   801074e0 <deallocuvm>
80103b8f:	83 c4 10             	add    $0x10,%esp
80103b92:	85 c0                	test   %eax,%eax
80103b94:	0f 85 75 ff ff ff    	jne    80103b0f <growproc+0x3f>
80103b9a:	eb d8                	jmp    80103b74 <growproc+0xa4>
80103b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ba0 <fork>:
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	57                   	push   %edi
80103ba4:	56                   	push   %esi
80103ba5:	53                   	push   %ebx
80103ba6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ba9:	e8 e2 0e 00 00       	call   80104a90 <pushcli>
  c = mycpu();
80103bae:	e8 5d fd ff ff       	call   80103910 <mycpu>
  p = c->proc;
80103bb3:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80103bb9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  popcli();
80103bbc:	e8 1f 0f 00 00       	call   80104ae0 <popcli>
  if((np = allocproc()) == 0){
80103bc1:	e8 ea fb ff ff       	call   801037b0 <allocproc>
80103bc6:	85 c0                	test   %eax,%eax
80103bc8:	0f 84 dd 00 00 00    	je     80103cab <fork+0x10b>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bce:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103bd1:	83 ec 08             	sub    $0x8,%esp
80103bd4:	89 c3                	mov    %eax,%ebx
80103bd6:	ff 32                	push   (%edx)
80103bd8:	ff 72 04             	push   0x4(%edx)
80103bdb:	e8 a0 3a 00 00       	call   80107680 <copyuvm>
80103be0:	83 c4 10             	add    $0x10,%esp
80103be3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103be6:	85 c0                	test   %eax,%eax
80103be8:	89 43 04             	mov    %eax,0x4(%ebx)
80103beb:	0f 84 c1 00 00 00    	je     80103cb2 <fork+0x112>
  np->sz = curproc->sz;
80103bf1:	8b 02                	mov    (%edx),%eax
  *np->tf = *curproc->tf;
80103bf3:	8b 7b 18             	mov    0x18(%ebx),%edi
  np->parent = curproc;
80103bf6:	89 53 14             	mov    %edx,0x14(%ebx)
  *np->tf = *curproc->tf;
80103bf9:	b9 13 00 00 00       	mov    $0x13,%ecx
  np->sz = curproc->sz;
80103bfe:	89 03                	mov    %eax,(%ebx)
  *np->tf = *curproc->tf;
80103c00:	8b 72 18             	mov    0x18(%edx),%esi
80103c03:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	np->mthread = np;
80103c05:	89 9b 84 00 00 00    	mov    %ebx,0x84(%ebx)
  for(i = 0; i < NOFILE; i++)
80103c0b:	31 f6                	xor    %esi,%esi
	np->tid = np->nexttid++;
80103c0d:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
80103c13:	89 43 7c             	mov    %eax,0x7c(%ebx)
80103c16:	8d 48 01             	lea    0x1(%eax),%ecx
  np->tf->eax = 0;
80103c19:	8b 43 18             	mov    0x18(%ebx),%eax
	np->tid = np->nexttid++;
80103c1c:	89 8b 80 00 00 00    	mov    %ecx,0x80(%ebx)
  np->tf->eax = 0;
80103c22:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103c30:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103c34:	85 c0                	test   %eax,%eax
80103c36:	74 16                	je     80103c4e <fork+0xae>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c38:	83 ec 0c             	sub    $0xc,%esp
80103c3b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103c3e:	50                   	push   %eax
80103c3f:	e8 5c d2 ff ff       	call   80100ea0 <filedup>
80103c44:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c47:	83 c4 10             	add    $0x10,%esp
80103c4a:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103c4e:	83 c6 01             	add    $0x1,%esi
80103c51:	83 fe 10             	cmp    $0x10,%esi
80103c54:	75 da                	jne    80103c30 <fork+0x90>
  np->cwd = idup(curproc->cwd);
80103c56:	83 ec 0c             	sub    $0xc,%esp
80103c59:	ff 72 68             	push   0x68(%edx)
80103c5c:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80103c5f:	e8 ec da ff ff       	call   80101750 <idup>
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c64:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c67:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c6a:	89 43 68             	mov    %eax,0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c6d:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c70:	83 c2 6c             	add    $0x6c,%edx
80103c73:	6a 10                	push   $0x10
80103c75:	52                   	push   %edx
80103c76:	50                   	push   %eax
80103c77:	e8 e4 11 00 00       	call   80104e60 <safestrcpy>
  pid = np->pid;
80103c7c:	8b 73 10             	mov    0x10(%ebx),%esi
  acquire(&ptable.lock);
80103c7f:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c86:	e8 55 0f 00 00       	call   80104be0 <acquire>
  np->state = RUNNABLE;
80103c8b:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c92:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c99:	e8 e2 0e 00 00       	call   80104b80 <release>
  return pid;
80103c9e:	83 c4 10             	add    $0x10,%esp
}
80103ca1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ca4:	89 f0                	mov    %esi,%eax
80103ca6:	5b                   	pop    %ebx
80103ca7:	5e                   	pop    %esi
80103ca8:	5f                   	pop    %edi
80103ca9:	5d                   	pop    %ebp
80103caa:	c3                   	ret    
    return -1;
80103cab:	be ff ff ff ff       	mov    $0xffffffff,%esi
80103cb0:	eb ef                	jmp    80103ca1 <fork+0x101>
    kfree(np->kstack);
80103cb2:	83 ec 0c             	sub    $0xc,%esp
80103cb5:	ff 73 08             	push   0x8(%ebx)
    return -1;
80103cb8:	be ff ff ff ff       	mov    $0xffffffff,%esi
    kfree(np->kstack);
80103cbd:	e8 fe e7 ff ff       	call   801024c0 <kfree>
    np->kstack = 0;
80103cc2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103cc9:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103ccc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103cd3:	eb cc                	jmp    80103ca1 <fork+0x101>
80103cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ce0 <scheduler>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103ce9:	e8 22 fc ff ff       	call   80103910 <mycpu>
  c->proc = 0;
80103cee:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103cf5:	00 00 00 
  struct cpu *c = mycpu();
80103cf8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103cfa:	8d 78 04             	lea    0x4(%eax),%edi
80103cfd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103d00:	fb                   	sti    
    acquire(&ptable.lock);
80103d01:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d04:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
    acquire(&ptable.lock);
80103d09:	68 20 2d 11 80       	push   $0x80112d20
80103d0e:	e8 cd 0e 00 00       	call   80104be0 <acquire>
80103d13:	83 c4 10             	add    $0x10,%esp
80103d16:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d1d:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->state != RUNNABLE)
80103d20:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d24:	75 33                	jne    80103d59 <scheduler+0x79>
      switchuvm(p);
80103d26:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103d29:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d2f:	53                   	push   %ebx
80103d30:	e8 fb 33 00 00       	call   80107130 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d35:	58                   	pop    %eax
80103d36:	5a                   	pop    %edx
80103d37:	ff 73 1c             	push   0x1c(%ebx)
80103d3a:	57                   	push   %edi
      p->state = RUNNING;
80103d3b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103d42:	e8 74 11 00 00       	call   80104ebb <swtch>
      switchkvm();
80103d47:	e8 d4 33 00 00       	call   80107120 <switchkvm>
      c->proc = 0;
80103d4c:	83 c4 10             	add    $0x10,%esp
80103d4f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d56:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d59:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103d5f:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103d65:	75 b9                	jne    80103d20 <scheduler+0x40>
    release(&ptable.lock);
80103d67:	83 ec 0c             	sub    $0xc,%esp
80103d6a:	68 20 2d 11 80       	push   $0x80112d20
80103d6f:	e8 0c 0e 00 00       	call   80104b80 <release>
    sti();
80103d74:	83 c4 10             	add    $0x10,%esp
80103d77:	eb 87                	jmp    80103d00 <scheduler+0x20>
80103d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d80 <sched>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	56                   	push   %esi
80103d84:	53                   	push   %ebx
  pushcli();
80103d85:	e8 06 0d 00 00       	call   80104a90 <pushcli>
  c = mycpu();
80103d8a:	e8 81 fb ff ff       	call   80103910 <mycpu>
  p = c->proc;
80103d8f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d95:	e8 46 0d 00 00       	call   80104ae0 <popcli>
  if(!holding(&ptable.lock))
80103d9a:	83 ec 0c             	sub    $0xc,%esp
80103d9d:	68 20 2d 11 80       	push   $0x80112d20
80103da2:	e8 99 0d 00 00       	call   80104b40 <holding>
80103da7:	83 c4 10             	add    $0x10,%esp
80103daa:	85 c0                	test   %eax,%eax
80103dac:	74 4f                	je     80103dfd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dae:	e8 5d fb ff ff       	call   80103910 <mycpu>
80103db3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dba:	75 68                	jne    80103e24 <sched+0xa4>
  if(p->state == RUNNING)
80103dbc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103dc0:	74 55                	je     80103e17 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103dc2:	9c                   	pushf  
80103dc3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103dc4:	f6 c4 02             	test   $0x2,%ah
80103dc7:	75 41                	jne    80103e0a <sched+0x8a>
  intena = mycpu()->intena;
80103dc9:	e8 42 fb ff ff       	call   80103910 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103dce:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103dd1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103dd7:	e8 34 fb ff ff       	call   80103910 <mycpu>
80103ddc:	83 ec 08             	sub    $0x8,%esp
80103ddf:	ff 70 04             	push   0x4(%eax)
80103de2:	53                   	push   %ebx
80103de3:	e8 d3 10 00 00       	call   80104ebb <swtch>
  mycpu()->intena = intena;
80103de8:	e8 23 fb ff ff       	call   80103910 <mycpu>
}
80103ded:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103df0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103df6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103df9:	5b                   	pop    %ebx
80103dfa:	5e                   	pop    %esi
80103dfb:	5d                   	pop    %ebp
80103dfc:	c3                   	ret    
    panic("sched ptable.lock");
80103dfd:	83 ec 0c             	sub    $0xc,%esp
80103e00:	68 5b 7e 10 80       	push   $0x80107e5b
80103e05:	e8 76 c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 87 7e 10 80       	push   $0x80107e87
80103e12:	e8 69 c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	68 79 7e 10 80       	push   $0x80107e79
80103e1f:	e8 5c c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103e24:	83 ec 0c             	sub    $0xc,%esp
80103e27:	68 6d 7e 10 80       	push   $0x80107e6d
80103e2c:	e8 4f c5 ff ff       	call   80100380 <panic>
80103e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e3f:	90                   	nop

80103e40 <wait>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	56                   	push   %esi
80103e44:	53                   	push   %ebx
  pushcli();
80103e45:	e8 46 0c 00 00       	call   80104a90 <pushcli>
  c = mycpu();
80103e4a:	e8 c1 fa ff ff       	call   80103910 <mycpu>
  p = c->proc;
80103e4f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e55:	e8 86 0c 00 00       	call   80104ae0 <popcli>
  acquire(&ptable.lock);
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 20 2d 11 80       	push   $0x80112d20
80103e62:	e8 79 0d 00 00       	call   80104be0 <acquire>
80103e67:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103e6a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e6c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103e71:	eb 13                	jmp    80103e86 <wait+0x46>
80103e73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e77:	90                   	nop
80103e78:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80103e7e:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103e84:	74 1e                	je     80103ea4 <wait+0x64>
      if(p->parent != curproc)
80103e86:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e89:	75 ed                	jne    80103e78 <wait+0x38>
      if(p->state == ZOMBIE){
80103e8b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e8f:	74 5f                	je     80103ef0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e91:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
      havekids = 1;
80103e97:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e9c:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80103ea2:	75 e2                	jne    80103e86 <wait+0x46>
    if(!havekids || curproc->killed){
80103ea4:	85 c0                	test   %eax,%eax
80103ea6:	0f 84 9a 00 00 00    	je     80103f46 <wait+0x106>
80103eac:	8b 46 24             	mov    0x24(%esi),%eax
80103eaf:	85 c0                	test   %eax,%eax
80103eb1:	0f 85 8f 00 00 00    	jne    80103f46 <wait+0x106>
  pushcli();
80103eb7:	e8 d4 0b 00 00       	call   80104a90 <pushcli>
  c = mycpu();
80103ebc:	e8 4f fa ff ff       	call   80103910 <mycpu>
  p = c->proc;
80103ec1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ec7:	e8 14 0c 00 00       	call   80104ae0 <popcli>
  if(p == 0)
80103ecc:	85 db                	test   %ebx,%ebx
80103ece:	0f 84 89 00 00 00    	je     80103f5d <wait+0x11d>
  p->chan = chan;
80103ed4:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80103ed7:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80103ede:	e8 9d fe ff ff       	call   80103d80 <sched>
  p->chan = 0;
80103ee3:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80103eea:	e9 7b ff ff ff       	jmp    80103e6a <wait+0x2a>
80103eef:	90                   	nop
        kfree(p->kstack);
80103ef0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80103ef3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103ef6:	ff 73 08             	push   0x8(%ebx)
80103ef9:	e8 c2 e5 ff ff       	call   801024c0 <kfree>
        p->kstack = 0;
80103efe:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f05:	5a                   	pop    %edx
80103f06:	ff 73 04             	push   0x4(%ebx)
80103f09:	e8 02 36 00 00       	call   80107510 <freevm>
        p->pid = 0;
80103f0e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103f15:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103f1c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103f20:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103f27:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103f2e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f35:	e8 46 0c 00 00       	call   80104b80 <release>
        return pid;
80103f3a:	83 c4 10             	add    $0x10,%esp
}
80103f3d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f40:	89 f0                	mov    %esi,%eax
80103f42:	5b                   	pop    %ebx
80103f43:	5e                   	pop    %esi
80103f44:	5d                   	pop    %ebp
80103f45:	c3                   	ret    
      release(&ptable.lock);
80103f46:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103f49:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80103f4e:	68 20 2d 11 80       	push   $0x80112d20
80103f53:	e8 28 0c 00 00       	call   80104b80 <release>
      return -1;
80103f58:	83 c4 10             	add    $0x10,%esp
80103f5b:	eb e0                	jmp    80103f3d <wait+0xfd>
    panic("sleep");
80103f5d:	83 ec 0c             	sub    $0xc,%esp
80103f60:	68 9b 7e 10 80       	push   $0x80107e9b
80103f65:	e8 16 c4 ff ff       	call   80100380 <panic>
80103f6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103f70 <yield>:
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	53                   	push   %ebx
80103f74:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103f77:	68 20 2d 11 80       	push   $0x80112d20
80103f7c:	e8 5f 0c 00 00       	call   80104be0 <acquire>
  pushcli();
80103f81:	e8 0a 0b 00 00       	call   80104a90 <pushcli>
  c = mycpu();
80103f86:	e8 85 f9 ff ff       	call   80103910 <mycpu>
  p = c->proc;
80103f8b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f91:	e8 4a 0b 00 00       	call   80104ae0 <popcli>
  myproc()->state = RUNNABLE;
80103f96:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103f9d:	e8 de fd ff ff       	call   80103d80 <sched>
  release(&ptable.lock);
80103fa2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fa9:	e8 d2 0b 00 00       	call   80104b80 <release>
}
80103fae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fb1:	83 c4 10             	add    $0x10,%esp
80103fb4:	c9                   	leave  
80103fb5:	c3                   	ret    
80103fb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fbd:	8d 76 00             	lea    0x0(%esi),%esi

80103fc0 <sleep>:
{
80103fc0:	55                   	push   %ebp
80103fc1:	89 e5                	mov    %esp,%ebp
80103fc3:	57                   	push   %edi
80103fc4:	56                   	push   %esi
80103fc5:	53                   	push   %ebx
80103fc6:	83 ec 0c             	sub    $0xc,%esp
80103fc9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103fcc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103fcf:	e8 bc 0a 00 00       	call   80104a90 <pushcli>
  c = mycpu();
80103fd4:	e8 37 f9 ff ff       	call   80103910 <mycpu>
  p = c->proc;
80103fd9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fdf:	e8 fc 0a 00 00       	call   80104ae0 <popcli>
  if(p == 0)
80103fe4:	85 db                	test   %ebx,%ebx
80103fe6:	0f 84 87 00 00 00    	je     80104073 <sleep+0xb3>
  if(lk == 0)
80103fec:	85 f6                	test   %esi,%esi
80103fee:	74 76                	je     80104066 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103ff0:	81 fe 20 2d 11 80    	cmp    $0x80112d20,%esi
80103ff6:	74 50                	je     80104048 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103ff8:	83 ec 0c             	sub    $0xc,%esp
80103ffb:	68 20 2d 11 80       	push   $0x80112d20
80104000:	e8 db 0b 00 00       	call   80104be0 <acquire>
    release(lk);
80104005:	89 34 24             	mov    %esi,(%esp)
80104008:	e8 73 0b 00 00       	call   80104b80 <release>
  p->chan = chan;
8010400d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104010:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104017:	e8 64 fd ff ff       	call   80103d80 <sched>
  p->chan = 0;
8010401c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104023:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
8010402a:	e8 51 0b 00 00       	call   80104b80 <release>
    acquire(lk);
8010402f:	89 75 08             	mov    %esi,0x8(%ebp)
80104032:	83 c4 10             	add    $0x10,%esp
}
80104035:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104038:	5b                   	pop    %ebx
80104039:	5e                   	pop    %esi
8010403a:	5f                   	pop    %edi
8010403b:	5d                   	pop    %ebp
    acquire(lk);
8010403c:	e9 9f 0b 00 00       	jmp    80104be0 <acquire>
80104041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104048:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010404b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104052:	e8 29 fd ff ff       	call   80103d80 <sched>
  p->chan = 0;
80104057:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010405e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104061:	5b                   	pop    %ebx
80104062:	5e                   	pop    %esi
80104063:	5f                   	pop    %edi
80104064:	5d                   	pop    %ebp
80104065:	c3                   	ret    
    panic("sleep without lk");
80104066:	83 ec 0c             	sub    $0xc,%esp
80104069:	68 a1 7e 10 80       	push   $0x80107ea1
8010406e:	e8 0d c3 ff ff       	call   80100380 <panic>
    panic("sleep");
80104073:	83 ec 0c             	sub    $0xc,%esp
80104076:	68 9b 7e 10 80       	push   $0x80107e9b
8010407b:	e8 00 c3 ff ff       	call   80100380 <panic>

80104080 <wakeup>:
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	53                   	push   %ebx
80104084:	83 ec 10             	sub    $0x10,%esp
80104087:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010408a:	68 20 2d 11 80       	push   $0x80112d20
8010408f:	e8 4c 0b 00 00       	call   80104be0 <acquire>
80104094:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104097:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
8010409c:	eb 0e                	jmp    801040ac <wakeup+0x2c>
8010409e:	66 90                	xchg   %ax,%ax
801040a0:	05 8c 00 00 00       	add    $0x8c,%eax
801040a5:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801040aa:	74 1e                	je     801040ca <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801040ac:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040b0:	75 ee                	jne    801040a0 <wakeup+0x20>
801040b2:	3b 58 20             	cmp    0x20(%eax),%ebx
801040b5:	75 e9                	jne    801040a0 <wakeup+0x20>
      p->state = RUNNABLE;
801040b7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040be:	05 8c 00 00 00       	add    $0x8c,%eax
801040c3:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801040c8:	75 e2                	jne    801040ac <wakeup+0x2c>
  release(&ptable.lock);
801040ca:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
801040d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d4:	c9                   	leave  
  release(&ptable.lock);
801040d5:	e9 a6 0a 00 00       	jmp    80104b80 <release>
801040da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040e0 <kill>:
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	56                   	push   %esi
	int iskill = 0;
801040e4:	31 f6                	xor    %esi,%esi
{
801040e6:	53                   	push   %ebx
801040e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ea:	83 ec 0c             	sub    $0xc,%esp
801040ed:	68 20 2d 11 80       	push   $0x80112d20
801040f2:	e8 e9 0a 00 00       	call   80104be0 <acquire>
801040f7:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040fa:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801040ff:	eb 13                	jmp    80104114 <kill+0x34>
80104101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104108:	05 8c 00 00 00       	add    $0x8c,%eax
8010410d:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104112:	74 2a                	je     8010413e <kill+0x5e>
    if(p->pid == pid){
80104114:	39 58 10             	cmp    %ebx,0x10(%eax)
80104117:	75 ef                	jne    80104108 <kill+0x28>
      if(p->state == SLEEPING)
80104119:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
8010411d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      iskill = 1;
80104124:	be 01 00 00 00       	mov    $0x1,%esi
      if(p->state == SLEEPING)
80104129:	75 dd                	jne    80104108 <kill+0x28>
        p->state = RUNNABLE;
8010412b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104132:	05 8c 00 00 00       	add    $0x8c,%eax
80104137:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010413c:	75 d6                	jne    80104114 <kill+0x34>
	release(&ptable.lock);
8010413e:	83 ec 0c             	sub    $0xc,%esp
80104141:	68 20 2d 11 80       	push   $0x80112d20
80104146:	e8 35 0a 00 00       	call   80104b80 <release>
}
8010414b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(iskill)
8010414e:	8d 46 ff             	lea    -0x1(%esi),%eax
}
80104151:	5b                   	pop    %ebx
80104152:	5e                   	pop    %esi
80104153:	5d                   	pop    %ebp
80104154:	c3                   	ret    
80104155:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010415c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104160 <procdump>:
{
80104160:	55                   	push   %ebp
80104161:	89 e5                	mov    %esp,%ebp
80104163:	57                   	push   %edi
80104164:	56                   	push   %esi
80104165:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104168:	53                   	push   %ebx
80104169:	bb c0 2d 11 80       	mov    $0x80112dc0,%ebx
8010416e:	83 ec 3c             	sub    $0x3c,%esp
80104171:	eb 27                	jmp    8010419a <procdump+0x3a>
80104173:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104177:	90                   	nop
    cprintf("\n");
80104178:	83 ec 0c             	sub    $0xc,%esp
8010417b:	68 83 82 10 80       	push   $0x80108283
80104180:	e8 1b c5 ff ff       	call   801006a0 <cprintf>
80104185:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104188:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
8010418e:	81 fb c0 50 11 80    	cmp    $0x801150c0,%ebx
80104194:	0f 84 7e 00 00 00    	je     80104218 <procdump+0xb8>
    if(p->state == UNUSED)
8010419a:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010419d:	85 c0                	test   %eax,%eax
8010419f:	74 e7                	je     80104188 <procdump+0x28>
      state = "???";
801041a1:	ba b2 7e 10 80       	mov    $0x80107eb2,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801041a6:	83 f8 05             	cmp    $0x5,%eax
801041a9:	77 11                	ja     801041bc <procdump+0x5c>
801041ab:	8b 14 85 58 7f 10 80 	mov    -0x7fef80a8(,%eax,4),%edx
      state = "???";
801041b2:	b8 b2 7e 10 80       	mov    $0x80107eb2,%eax
801041b7:	85 d2                	test   %edx,%edx
801041b9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801041bc:	53                   	push   %ebx
801041bd:	52                   	push   %edx
801041be:	ff 73 a4             	push   -0x5c(%ebx)
801041c1:	68 b6 7e 10 80       	push   $0x80107eb6
801041c6:	e8 d5 c4 ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
801041cb:	83 c4 10             	add    $0x10,%esp
801041ce:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801041d2:	75 a4                	jne    80104178 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801041d4:	83 ec 08             	sub    $0x8,%esp
801041d7:	8d 45 c0             	lea    -0x40(%ebp),%eax
801041da:	8d 7d c0             	lea    -0x40(%ebp),%edi
801041dd:	50                   	push   %eax
801041de:	8b 43 b0             	mov    -0x50(%ebx),%eax
801041e1:	8b 40 0c             	mov    0xc(%eax),%eax
801041e4:	83 c0 08             	add    $0x8,%eax
801041e7:	50                   	push   %eax
801041e8:	e8 43 08 00 00       	call   80104a30 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801041ed:	83 c4 10             	add    $0x10,%esp
801041f0:	8b 17                	mov    (%edi),%edx
801041f2:	85 d2                	test   %edx,%edx
801041f4:	74 82                	je     80104178 <procdump+0x18>
        cprintf(" %p", pc[i]);
801041f6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801041f9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801041fc:	52                   	push   %edx
801041fd:	68 21 79 10 80       	push   $0x80107921
80104202:	e8 99 c4 ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104207:	83 c4 10             	add    $0x10,%esp
8010420a:	39 fe                	cmp    %edi,%esi
8010420c:	75 e2                	jne    801041f0 <procdump+0x90>
8010420e:	e9 65 ff ff ff       	jmp    80104178 <procdump+0x18>
80104213:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104217:	90                   	nop
}
80104218:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010421b:	5b                   	pop    %ebx
8010421c:	5e                   	pop    %esi
8010421d:	5f                   	pop    %edi
8010421e:	5d                   	pop    %ebp
8010421f:	c3                   	ret    

80104220 <thread_create>:
{
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	57                   	push   %edi
80104224:	56                   	push   %esi
80104225:	53                   	push   %ebx
80104226:	83 ec 2c             	sub    $0x2c,%esp
  pushcli();
80104229:	e8 62 08 00 00       	call   80104a90 <pushcli>
  c = mycpu();
8010422e:	e8 dd f6 ff ff       	call   80103910 <mycpu>
  p = c->proc;
80104233:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104239:	e8 a2 08 00 00       	call   80104ae0 <popcli>
	struct proc *mthread = curproc->mthread; // main thread
8010423e:	8b 9b 84 00 00 00    	mov    0x84(%ebx),%ebx
	if((nt = allocproc()) == 0){
80104244:	e8 67 f5 ff ff       	call   801037b0 <allocproc>
80104249:	89 45 d4             	mov    %eax,-0x2c(%ebp)
8010424c:	85 c0                	test   %eax,%eax
8010424e:	0f 84 6f 01 00 00    	je     801043c3 <thread_create+0x1a3>
	acquire(&ptable.lock);
80104254:	83 ec 0c             	sub    $0xc,%esp
80104257:	68 20 2d 11 80       	push   $0x80112d20
8010425c:	e8 7f 09 00 00       	call   80104be0 <acquire>
	sz = PGROUNDUP((mthread->sz));
80104261:	8b 03                	mov    (%ebx),%eax
	if((sz = allocuvm(mthread->pgdir, sz, sz + 2*PGSIZE)) == 0)
80104263:	83 c4 0c             	add    $0xc,%esp
	sz = PGROUNDUP((mthread->sz));
80104266:	05 ff 0f 00 00       	add    $0xfff,%eax
8010426b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
	if((sz = allocuvm(mthread->pgdir, sz, sz + 2*PGSIZE)) == 0)
80104270:	8d 88 00 20 00 00    	lea    0x2000(%eax),%ecx
80104276:	51                   	push   %ecx
80104277:	50                   	push   %eax
80104278:	ff 73 04             	push   0x4(%ebx)
8010427b:	e8 30 31 00 00       	call   801073b0 <allocuvm>
80104280:	83 c4 10             	add    $0x10,%esp
80104283:	89 c6                	mov    %eax,%esi
80104285:	85 c0                	test   %eax,%eax
80104287:	0f 84 36 01 00 00    	je     801043c3 <thread_create+0x1a3>
	clearpteu(mthread->pgdir, (char*)(sz - 2*PGSIZE));
8010428d:	83 ec 08             	sub    $0x8,%esp
80104290:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80104296:	50                   	push   %eax
80104297:	ff 73 04             	push   0x4(%ebx)
8010429a:	e8 91 33 00 00       	call   80107630 <clearpteu>
	nt->parent = mthread->parent;
8010429f:	8b 43 14             	mov    0x14(%ebx),%eax
801042a2:	8b 55 d4             	mov    -0x2c(%ebp),%edx
	mthread->sz = sz;
801042a5:	83 c4 10             	add    $0x10,%esp
	nt->parent = mthread->parent;
801042a8:	89 42 14             	mov    %eax,0x14(%edx)
	nt->pid = mthread->pid;
801042ab:	8b 43 10             	mov    0x10(%ebx),%eax
801042ae:	89 42 10             	mov    %eax,0x10(%edx)
	nt->tid = mthread->nexttid++;
801042b1:	8b 83 80 00 00 00    	mov    0x80(%ebx),%eax
801042b7:	8d 48 01             	lea    0x1(%eax),%ecx
801042ba:	89 8b 80 00 00 00    	mov    %ecx,0x80(%ebx)
	*thread = nt->tid;
801042c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
	nt->tid = mthread->nexttid++;
801042c3:	89 42 7c             	mov    %eax,0x7c(%edx)
	nt->mthread = mthread;
801042c6:	89 9a 84 00 00 00    	mov    %ebx,0x84(%edx)
	*thread = nt->tid;
801042cc:	89 01                	mov    %eax,(%ecx)
	for(p=ptable.proc;p<&ptable.proc[NPROC]; p++){
801042ce:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
	mthread->sz = sz;
801042d3:	89 33                	mov    %esi,(%ebx)
	for(p=ptable.proc;p<&ptable.proc[NPROC]; p++){
801042d5:	8d 76 00             	lea    0x0(%esi),%esi
		if(p->pid == mthread->pid && p != mthread){
801042d8:	8b 4b 10             	mov    0x10(%ebx),%ecx
801042db:	39 48 10             	cmp    %ecx,0x10(%eax)
801042de:	75 08                	jne    801042e8 <thread_create+0xc8>
801042e0:	39 c3                	cmp    %eax,%ebx
801042e2:	74 04                	je     801042e8 <thread_create+0xc8>
			p->sz = mthread->sz;
801042e4:	8b 13                	mov    (%ebx),%edx
801042e6:	89 10                	mov    %edx,(%eax)
	for(p=ptable.proc;p<&ptable.proc[NPROC]; p++){
801042e8:	05 8c 00 00 00       	add    $0x8c,%eax
801042ed:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801042f2:	75 e4                	jne    801042d8 <thread_create+0xb8>
	nt->pgdir = mthread->pgdir;
801042f4:	8b 43 04             	mov    0x4(%ebx),%eax
801042f7:	8b 7d d4             	mov    -0x2c(%ebp),%edi
	sp -= 8;
801042fa:	8d 56 f8             	lea    -0x8(%esi),%edx
	ustack[0] = 0xffffffff; // fake return PC
801042fd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
	if(copyout(nt->pgdir, sp, ustack, 8) < 0)
80104304:	89 55 d0             	mov    %edx,-0x30(%ebp)
	nt->pgdir = mthread->pgdir;
80104307:	89 47 04             	mov    %eax,0x4(%edi)
	ustack[1] = (uint)arg;  // argument
8010430a:	8b 45 10             	mov    0x10(%ebp),%eax
	if(copyout(nt->pgdir, sp, ustack, 8) < 0)
8010430d:	6a 08                	push   $0x8
	ustack[1] = (uint)arg;  // argument
8010430f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	if(copyout(nt->pgdir, sp, ustack, 8) < 0)
80104312:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104315:	50                   	push   %eax
80104316:	52                   	push   %edx
80104317:	ff 77 04             	push   0x4(%edi)
8010431a:	e8 e1 34 00 00       	call   80107800 <copyout>
8010431f:	83 c4 10             	add    $0x10,%esp
80104322:	85 c0                	test   %eax,%eax
80104324:	0f 88 99 00 00 00    	js     801043c3 <thread_create+0x1a3>
	*nt->tf = *mthread->tf;
8010432a:	8b 73 18             	mov    0x18(%ebx),%esi
8010432d:	89 f8                	mov    %edi,%eax
8010432f:	b9 13 00 00 00       	mov    $0x13,%ecx
80104334:	8b 7f 18             	mov    0x18(%edi),%edi
80104337:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
	nt->tf->esp = sp;
80104339:	8b 55 d0             	mov    -0x30(%ebp),%edx
8010433c:	89 c7                	mov    %eax,%edi
  nt->tf->eip = (uint)start_routine;
8010433e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
	for(i = 0; i < NOFILE; i++)
80104341:	31 f6                	xor    %esi,%esi
	nt->tf->esp = sp;
80104343:	8b 40 18             	mov    0x18(%eax),%eax
80104346:	89 50 44             	mov    %edx,0x44(%eax)
	nt->tf->eax = 0;
80104349:	8b 47 18             	mov    0x18(%edi),%eax
8010434c:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  nt->tf->eip = (uint)start_routine;
80104353:	8b 47 18             	mov    0x18(%edi),%eax
80104356:	89 48 38             	mov    %ecx,0x38(%eax)
	for(i = 0; i < NOFILE; i++)
80104359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if(mthread->ofile[i])
80104360:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104364:	85 c0                	test   %eax,%eax
80104366:	74 10                	je     80104378 <thread_create+0x158>
			nt->ofile[i] = filedup((mthread->ofile[i]));
80104368:	83 ec 0c             	sub    $0xc,%esp
8010436b:	50                   	push   %eax
8010436c:	e8 2f cb ff ff       	call   80100ea0 <filedup>
80104371:	83 c4 10             	add    $0x10,%esp
80104374:	89 44 b7 28          	mov    %eax,0x28(%edi,%esi,4)
	for(i = 0; i < NOFILE; i++)
80104378:	83 c6 01             	add    $0x1,%esi
8010437b:	83 fe 10             	cmp    $0x10,%esi
8010437e:	75 e0                	jne    80104360 <thread_create+0x140>
	nt->cwd = idup(mthread->cwd);
80104380:	83 ec 0c             	sub    $0xc,%esp
80104383:	ff 73 68             	push   0x68(%ebx)
	safestrcpy(nt->name, mthread->name, sizeof(mthread->name));
80104386:	83 c3 6c             	add    $0x6c,%ebx
	nt->cwd = idup(mthread->cwd);
80104389:	e8 c2 d3 ff ff       	call   80101750 <idup>
8010438e:	8b 7d d4             	mov    -0x2c(%ebp),%edi
	safestrcpy(nt->name, mthread->name, sizeof(mthread->name));
80104391:	83 c4 0c             	add    $0xc,%esp
	nt->cwd = idup(mthread->cwd);
80104394:	89 47 68             	mov    %eax,0x68(%edi)
	safestrcpy(nt->name, mthread->name, sizeof(mthread->name));
80104397:	8d 47 6c             	lea    0x6c(%edi),%eax
8010439a:	6a 10                	push   $0x10
8010439c:	53                   	push   %ebx
8010439d:	50                   	push   %eax
8010439e:	e8 bd 0a 00 00       	call   80104e60 <safestrcpy>
	nt->state = RUNNABLE;
801043a3:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
	release(&ptable.lock);
801043aa:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801043b1:	e8 ca 07 00 00       	call   80104b80 <release>
	return 0;
801043b6:	83 c4 10             	add    $0x10,%esp
801043b9:	31 c0                	xor    %eax,%eax
}
801043bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043be:	5b                   	pop    %ebx
801043bf:	5e                   	pop    %esi
801043c0:	5f                   	pop    %edi
801043c1:	5d                   	pop    %ebp
801043c2:	c3                   	ret    
		return -1;
801043c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043c8:	eb f1                	jmp    801043bb <thread_create+0x19b>
801043ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043d0 <thread_join>:
{
801043d0:	55                   	push   %ebp
801043d1:	89 e5                	mov    %esp,%ebp
801043d3:	57                   	push   %edi
801043d4:	56                   	push   %esi
801043d5:	53                   	push   %ebx
801043d6:	83 ec 0c             	sub    $0xc,%esp
801043d9:	8b 7d 08             	mov    0x8(%ebp),%edi
  pushcli();
801043dc:	e8 af 06 00 00       	call   80104a90 <pushcli>
  c = mycpu();
801043e1:	e8 2a f5 ff ff       	call   80103910 <mycpu>
  p = c->proc;
801043e6:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801043ec:	e8 ef 06 00 00       	call   80104ae0 <popcli>
	if(thread == 0)
801043f1:	85 ff                	test   %edi,%edi
801043f3:	0f 84 cd 00 00 00    	je     801044c6 <thread_join+0xf6>
	acquire(&ptable.lock);
801043f9:	83 ec 0c             	sub    $0xc,%esp
801043fc:	68 20 2d 11 80       	push   $0x80112d20
80104401:	e8 da 07 00 00       	call   80104be0 <acquire>
80104406:	83 c4 10             	add    $0x10,%esp
			if(p->pid != curthread->pid || p->tid != thread)
80104409:	8b 46 10             	mov    0x10(%esi),%eax
		for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010440c:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80104411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			if(p->pid != curthread->pid || p->tid != thread)
80104418:	39 43 10             	cmp    %eax,0x10(%ebx)
8010441b:	75 0b                	jne    80104428 <thread_join+0x58>
8010441d:	39 7b 7c             	cmp    %edi,0x7c(%ebx)
80104420:	75 06                	jne    80104428 <thread_join+0x58>
			if(p->state == ZOMBIE) {
80104422:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104426:	74 48                	je     80104470 <thread_join+0xa0>
		for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104428:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
8010442e:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
80104434:	75 e2                	jne    80104418 <thread_join+0x48>
  pushcli();
80104436:	e8 55 06 00 00       	call   80104a90 <pushcli>
  c = mycpu();
8010443b:	e8 d0 f4 ff ff       	call   80103910 <mycpu>
  p = c->proc;
80104440:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104446:	e8 95 06 00 00       	call   80104ae0 <popcli>
  if(p == 0)
8010444b:	85 db                	test   %ebx,%ebx
8010444d:	74 7e                	je     801044cd <thread_join+0xfd>
  p->chan = chan;
8010444f:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104452:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104459:	e8 22 f9 ff ff       	call   80103d80 <sched>
  p->chan = 0;
8010445e:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104465:	eb a2                	jmp    80104409 <thread_join+0x39>
80104467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010446e:	66 90                	xchg   %ax,%ax
				*retval = p->retval;
80104470:	8b 93 88 00 00 00    	mov    0x88(%ebx),%edx
80104476:	8b 45 0c             	mov    0xc(%ebp),%eax
				kfree(p->kstack);
80104479:	83 ec 0c             	sub    $0xc,%esp
				*retval = p->retval;
8010447c:	89 10                	mov    %edx,(%eax)
				kfree(p->kstack);
8010447e:	ff 73 08             	push   0x8(%ebx)
80104481:	e8 3a e0 ff ff       	call   801024c0 <kfree>
				p->kstack = 0;
80104486:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
				p->pid = 0;
8010448d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
				p->parent = 0;
80104494:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
				p->name[0] = 0;
8010449b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
				p->killed = 0;
8010449f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
				p->state = UNUSED;
801044a6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
				release(&ptable.lock);
801044ad:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801044b4:	e8 c7 06 00 00       	call   80104b80 <release>
				return 0;
801044b9:	83 c4 10             	add    $0x10,%esp
801044bc:	31 c0                	xor    %eax,%eax
}
801044be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044c1:	5b                   	pop    %ebx
801044c2:	5e                   	pop    %esi
801044c3:	5f                   	pop    %edi
801044c4:	5d                   	pop    %ebp
801044c5:	c3                   	ret    
		return -1;
801044c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044cb:	eb f1                	jmp    801044be <thread_join+0xee>
    panic("sleep");
801044cd:	83 ec 0c             	sub    $0xc,%esp
801044d0:	68 9b 7e 10 80       	push   $0x80107e9b
801044d5:	e8 a6 be ff ff       	call   80100380 <panic>
801044da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044e0 <updatesz>:
{
801044e0:	55                   	push   %ebp
	for(p=ptable.proc;p<&ptable.proc[NPROC]; p++){
801044e1:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
{
801044e6:	89 e5                	mov    %esp,%ebp
801044e8:	8b 55 08             	mov    0x8(%ebp),%edx
801044eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044ef:	90                   	nop
		if(p->pid == mthread->pid && p != mthread){
801044f0:	8b 4a 10             	mov    0x10(%edx),%ecx
801044f3:	39 48 10             	cmp    %ecx,0x10(%eax)
801044f6:	75 08                	jne    80104500 <updatesz+0x20>
801044f8:	39 c2                	cmp    %eax,%edx
801044fa:	74 04                	je     80104500 <updatesz+0x20>
			p->sz = mthread->sz;
801044fc:	8b 0a                	mov    (%edx),%ecx
801044fe:	89 08                	mov    %ecx,(%eax)
	for(p=ptable.proc;p<&ptable.proc[NPROC]; p++){
80104500:	05 8c 00 00 00       	add    $0x8c,%eax
80104505:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010450a:	75 e4                	jne    801044f0 <updatesz+0x10>
		}
	}
}
8010450c:	5d                   	pop    %ebp
8010450d:	c3                   	ret    
8010450e:	66 90                	xchg   %ax,%ax

80104510 <thread_exit_with_pointer>:

// exit thread in other thread.
void 
thread_exit_with_pointer(struct proc* thread)
{
80104510:	55                   	push   %ebp
80104511:	89 e5                	mov    %esp,%ebp
80104513:	57                   	push   %edi
80104514:	56                   	push   %esi
80104515:	53                   	push   %ebx
80104516:	83 ec 0c             	sub    $0xc,%esp
80104519:	8b 75 08             	mov    0x8(%ebp),%esi
	struct proc* p;
	int fd;

	if(thread == initproc)
8010451c:	39 35 54 50 11 80    	cmp    %esi,0x80115054
80104522:	0f 84 ff 00 00 00    	je     80104627 <thread_exit_with_pointer+0x117>
80104528:	8d 5e 28             	lea    0x28(%esi),%ebx
8010452b:	8d 7e 68             	lea    0x68(%esi),%edi
8010452e:	66 90                	xchg   %ax,%ax
		panic("init exiting");

	// Close all open files.
	for(fd = 0; fd < NOFILE; fd++){
		if(thread->ofile[fd]){
80104530:	8b 03                	mov    (%ebx),%eax
80104532:	85 c0                	test   %eax,%eax
80104534:	74 12                	je     80104548 <thread_exit_with_pointer+0x38>
			fileclose(thread->ofile[fd]);
80104536:	83 ec 0c             	sub    $0xc,%esp
80104539:	50                   	push   %eax
8010453a:	e8 b1 c9 ff ff       	call   80100ef0 <fileclose>
			thread->ofile[fd] = 0;
8010453f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104545:	83 c4 10             	add    $0x10,%esp
	for(fd = 0; fd < NOFILE; fd++){
80104548:	83 c3 04             	add    $0x4,%ebx
8010454b:	39 df                	cmp    %ebx,%edi
8010454d:	75 e1                	jne    80104530 <thread_exit_with_pointer+0x20>
		}
	}

	begin_op();
8010454f:	e8 0c e8 ff ff       	call   80102d60 <begin_op>
	iput(thread->cwd);
80104554:	83 ec 0c             	sub    $0xc,%esp
80104557:	ff 76 68             	push   0x68(%esi)
8010455a:	e8 51 d3 ff ff       	call   801018b0 <iput>
	end_op();
8010455f:	e8 6c e8 ff ff       	call   80102dd0 <end_op>
	thread->cwd = 0;
80104564:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
	
	acquire(&ptable.lock);
8010456b:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104572:	e8 69 06 00 00       	call   80104be0 <acquire>
	
	wakeup1(thread->mthread);
80104577:	8b 96 84 00 00 00    	mov    0x84(%esi),%edx
8010457d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104580:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104585:	eb 15                	jmp    8010459c <thread_exit_with_pointer+0x8c>
80104587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010458e:	66 90                	xchg   %ax,%ax
80104590:	05 8c 00 00 00       	add    $0x8c,%eax
80104595:	3d 54 50 11 80       	cmp    $0x80115054,%eax
8010459a:	74 1e                	je     801045ba <thread_exit_with_pointer+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
8010459c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801045a0:	75 ee                	jne    80104590 <thread_exit_with_pointer+0x80>
801045a2:	3b 50 20             	cmp    0x20(%eax),%edx
801045a5:	75 e9                	jne    80104590 <thread_exit_with_pointer+0x80>
      p->state = RUNNABLE;
801045a7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045ae:	05 8c 00 00 00       	add    $0x8c,%eax
801045b3:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801045b8:	75 e2                	jne    8010459c <thread_exit_with_pointer+0x8c>

	// Pass abandoned children to init.
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
		if(p->parent == thread){
			p->parent = initproc;
801045ba:	8b 0d 54 50 11 80    	mov    0x80115054,%ecx
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045c0:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
801045c5:	eb 17                	jmp    801045de <thread_exit_with_pointer+0xce>
801045c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045ce:	66 90                	xchg   %ax,%ax
801045d0:	81 c2 8c 00 00 00    	add    $0x8c,%edx
801045d6:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
801045dc:	74 3a                	je     80104618 <thread_exit_with_pointer+0x108>
		if(p->parent == thread){
801045de:	3b 72 14             	cmp    0x14(%edx),%esi
801045e1:	75 ed                	jne    801045d0 <thread_exit_with_pointer+0xc0>
			if(p->state == ZOMBIE)
801045e3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
			p->parent = initproc;
801045e7:	89 4a 14             	mov    %ecx,0x14(%edx)
			if(p->state == ZOMBIE)
801045ea:	75 e4                	jne    801045d0 <thread_exit_with_pointer+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045ec:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
801045f1:	eb 11                	jmp    80104604 <thread_exit_with_pointer+0xf4>
801045f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045f7:	90                   	nop
801045f8:	05 8c 00 00 00       	add    $0x8c,%eax
801045fd:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104602:	74 cc                	je     801045d0 <thread_exit_with_pointer+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
80104604:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104608:	75 ee                	jne    801045f8 <thread_exit_with_pointer+0xe8>
8010460a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010460d:	75 e9                	jne    801045f8 <thread_exit_with_pointer+0xe8>
      p->state = RUNNABLE;
8010460f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104616:	eb e0                	jmp    801045f8 <thread_exit_with_pointer+0xe8>
				wakeup1(initproc);
		}
	}
	// Jump into the scheduler, never to return.
	thread->state = ZOMBIE;
80104618:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
}
8010461f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104622:	5b                   	pop    %ebx
80104623:	5e                   	pop    %esi
80104624:	5f                   	pop    %edi
80104625:	5d                   	pop    %ebp
80104626:	c3                   	ret    
		panic("init exiting");
80104627:	83 ec 0c             	sub    $0xc,%esp
8010462a:	68 bf 7e 10 80       	push   $0x80107ebf
8010462f:	e8 4c bd ff ff       	call   80100380 <panic>
80104634:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010463b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010463f:	90                   	nop

80104640 <thread_exit>:
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
80104643:	83 ec 08             	sub    $0x8,%esp
	struct proc *curthread = myproc();
80104646:	e8 45 f3 ff ff       	call   80103990 <myproc>
	curthread->retval = retval;
8010464b:	8b 55 08             	mov    0x8(%ebp),%edx
	thread_exit_with_pointer(curthread);
8010464e:	83 ec 0c             	sub    $0xc,%esp
	curthread->retval = retval;
80104651:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
	thread_exit_with_pointer(curthread);
80104657:	50                   	push   %eax
80104658:	e8 b3 fe ff ff       	call   80104510 <thread_exit_with_pointer>
	sched();
8010465d:	e8 1e f7 ff ff       	call   80103d80 <sched>
	panic("zombie exit");
80104662:	c7 04 24 cc 7e 10 80 	movl   $0x80107ecc,(%esp)
80104669:	e8 12 bd ff ff       	call   80100380 <panic>
8010466e:	66 90                	xchg   %ax,%ax

80104670 <convert_main_thread>:
	release(&ptable.lock);

}

void convert_main_thread(struct proc *thread)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	53                   	push   %ebx
80104674:	83 ec 04             	sub    $0x4,%esp
80104677:	8b 4d 08             	mov    0x8(%ebp),%ecx
	struct proc *prevmthread = thread->mthread;
8010467a:	8b 91 84 00 00 00    	mov    0x84(%ecx),%edx
	if(thread == prevmthread)
80104680:	39 d1                	cmp    %edx,%ecx
80104682:	74 46                	je     801046ca <convert_main_thread+0x5a>
		return;
	if(thread->pid != prevmthread->pid) {
80104684:	8b 42 10             	mov    0x10(%edx),%eax
80104687:	39 41 10             	cmp    %eax,0x10(%ecx)
8010468a:	75 43                	jne    801046cf <convert_main_thread+0x5f>
		panic("can not convert if process are different");
	}
	struct proc* p;
	int tmptid = thread->tid;
8010468c:	8b 41 7c             	mov    0x7c(%ecx),%eax
	thread->tid = 0;
8010468f:	c7 41 7c 00 00 00 00 	movl   $0x0,0x7c(%ecx)
	prevmthread->tid = tmptid;
80104696:	89 42 7c             	mov    %eax,0x7c(%edx)
	thread->mthread = thread;
80104699:	89 89 84 00 00 00    	mov    %ecx,0x84(%ecx)
	thread->nexttid = prevmthread->nexttid;
8010469f:	8b 82 80 00 00 00    	mov    0x80(%edx),%eax
801046a5:	89 81 80 00 00 00    	mov    %eax,0x80(%ecx)
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046ab:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
		if(p->pid == prevmthread->pid){
801046b0:	8b 5a 10             	mov    0x10(%edx),%ebx
801046b3:	39 58 10             	cmp    %ebx,0x10(%eax)
801046b6:	75 06                	jne    801046be <convert_main_thread+0x4e>
			p->mthread = thread;
801046b8:	89 88 84 00 00 00    	mov    %ecx,0x84(%eax)
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046be:	05 8c 00 00 00       	add    $0x8c,%eax
801046c3:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801046c8:	75 e6                	jne    801046b0 <convert_main_thread+0x40>
		}
	}
}
801046ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046cd:	c9                   	leave  
801046ce:	c3                   	ret    
		panic("can not convert if process are different");
801046cf:	83 ec 0c             	sub    $0xc,%esp
801046d2:	68 2c 7f 10 80       	push   $0x80107f2c
801046d7:	e8 a4 bc ff ff       	call   80100380 <panic>
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <thread_exit_all>:
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
801046e5:	8b 75 08             	mov    0x8(%ebp),%esi
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046e8:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
	acquire(&ptable.lock);
801046ed:	83 ec 0c             	sub    $0xc,%esp
801046f0:	68 20 2d 11 80       	push   $0x80112d20
801046f5:	e8 e6 04 00 00       	call   80104be0 <acquire>
	convert_main_thread(mthread);
801046fa:	89 34 24             	mov    %esi,(%esp)
801046fd:	e8 6e ff ff ff       	call   80104670 <convert_main_thread>
80104702:	83 c4 10             	add    $0x10,%esp
80104705:	eb 17                	jmp    8010471e <thread_exit_all+0x3e>
80104707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010470e:	66 90                	xchg   %ax,%ax
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104710:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
80104716:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
8010471c:	74 72                	je     80104790 <thread_exit_all+0xb0>
		if(p->pid == mthread->pid && p != mthread){
8010471e:	8b 46 10             	mov    0x10(%esi),%eax
80104721:	39 43 10             	cmp    %eax,0x10(%ebx)
80104724:	75 ea                	jne    80104710 <thread_exit_all+0x30>
80104726:	39 de                	cmp    %ebx,%esi
80104728:	74 e6                	je     80104710 <thread_exit_all+0x30>
			release(&ptable.lock);
8010472a:	83 ec 0c             	sub    $0xc,%esp
8010472d:	68 20 2d 11 80       	push   $0x80112d20
80104732:	e8 49 04 00 00       	call   80104b80 <release>
			thread_exit_with_pointer(p);
80104737:	89 1c 24             	mov    %ebx,(%esp)
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010473a:	81 c3 8c 00 00 00    	add    $0x8c,%ebx
			thread_exit_with_pointer(p);
80104740:	e8 cb fd ff ff       	call   80104510 <thread_exit_with_pointer>
			kfree(p->kstack);
80104745:	58                   	pop    %eax
80104746:	ff b3 7c ff ff ff    	push   -0x84(%ebx)
8010474c:	e8 6f dd ff ff       	call   801024c0 <kfree>
			p->pid = 0;
80104751:	c7 43 84 00 00 00 00 	movl   $0x0,-0x7c(%ebx)
			p->sz = 0;
80104758:	83 c4 10             	add    $0x10,%esp
			p->kstack = 0;
8010475b:	c7 83 7c ff ff ff 00 	movl   $0x0,-0x84(%ebx)
80104762:	00 00 00 
			p->parent = 0;
80104765:	c7 43 88 00 00 00 00 	movl   $0x0,-0x78(%ebx)
			p->name[0] = 0;
8010476c:	c6 43 e0 00          	movb   $0x0,-0x20(%ebx)
			p->killed = 0;
80104770:	c7 43 98 00 00 00 00 	movl   $0x0,-0x68(%ebx)
			p->state = UNUSED;
80104777:	c7 43 80 00 00 00 00 	movl   $0x0,-0x80(%ebx)
			p->sz = 0;
8010477e:	c7 83 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebx)
80104785:	00 00 00 
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104788:	81 fb 54 50 11 80    	cmp    $0x80115054,%ebx
8010478e:	75 8e                	jne    8010471e <thread_exit_all+0x3e>
	release(&ptable.lock);
80104790:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80104797:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010479a:	5b                   	pop    %ebx
8010479b:	5e                   	pop    %esi
8010479c:	5d                   	pop    %ebp
	release(&ptable.lock);
8010479d:	e9 de 03 00 00       	jmp    80104b80 <release>
801047a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801047b0 <exit>:
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	57                   	push   %edi
801047b4:	56                   	push   %esi
801047b5:	53                   	push   %ebx
801047b6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801047b9:	e8 d2 f1 ff ff       	call   80103990 <myproc>
  if(curproc == initproc)
801047be:	39 05 54 50 11 80    	cmp    %eax,0x80115054
801047c4:	0f 84 07 01 00 00    	je     801048d1 <exit+0x121>
801047ca:	89 c3                	mov    %eax,%ebx
801047cc:	8d 70 28             	lea    0x28(%eax),%esi
801047cf:	8d 78 68             	lea    0x68(%eax),%edi
801047d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801047d8:	8b 06                	mov    (%esi),%eax
801047da:	85 c0                	test   %eax,%eax
801047dc:	74 12                	je     801047f0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
801047de:	83 ec 0c             	sub    $0xc,%esp
801047e1:	50                   	push   %eax
801047e2:	e8 09 c7 ff ff       	call   80100ef0 <fileclose>
      curproc->ofile[fd] = 0;
801047e7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801047ed:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801047f0:	83 c6 04             	add    $0x4,%esi
801047f3:	39 f7                	cmp    %esi,%edi
801047f5:	75 e1                	jne    801047d8 <exit+0x28>
	thread_exit_all(curproc);
801047f7:	83 ec 0c             	sub    $0xc,%esp
801047fa:	53                   	push   %ebx
801047fb:	e8 e0 fe ff ff       	call   801046e0 <thread_exit_all>
  begin_op();
80104800:	e8 5b e5 ff ff       	call   80102d60 <begin_op>
  iput(curproc->cwd);
80104805:	58                   	pop    %eax
80104806:	ff 73 68             	push   0x68(%ebx)
80104809:	e8 a2 d0 ff ff       	call   801018b0 <iput>
  end_op();
8010480e:	e8 bd e5 ff ff       	call   80102dd0 <end_op>
  curproc->cwd = 0;
80104813:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
8010481a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80104821:	e8 ba 03 00 00       	call   80104be0 <acquire>
  wakeup1(curproc->parent);
80104826:	8b 53 14             	mov    0x14(%ebx),%edx
80104829:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010482c:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104831:	eb 11                	jmp    80104844 <exit+0x94>
80104833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104837:	90                   	nop
80104838:	05 8c 00 00 00       	add    $0x8c,%eax
8010483d:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104842:	74 1e                	je     80104862 <exit+0xb2>
    if(p->state == SLEEPING && p->chan == chan)
80104844:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104848:	75 ee                	jne    80104838 <exit+0x88>
8010484a:	3b 50 20             	cmp    0x20(%eax),%edx
8010484d:	75 e9                	jne    80104838 <exit+0x88>
      p->state = RUNNABLE;
8010484f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104856:	05 8c 00 00 00       	add    $0x8c,%eax
8010485b:	3d 54 50 11 80       	cmp    $0x80115054,%eax
80104860:	75 e2                	jne    80104844 <exit+0x94>
      p->parent = initproc;
80104862:	8b 0d 54 50 11 80    	mov    0x80115054,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104868:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
8010486d:	eb 0f                	jmp    8010487e <exit+0xce>
8010486f:	90                   	nop
80104870:	81 c2 8c 00 00 00    	add    $0x8c,%edx
80104876:	81 fa 54 50 11 80    	cmp    $0x80115054,%edx
8010487c:	74 3a                	je     801048b8 <exit+0x108>
    if(p->parent == curproc){
8010487e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104881:	75 ed                	jne    80104870 <exit+0xc0>
      if(p->state == ZOMBIE)
80104883:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104887:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010488a:	75 e4                	jne    80104870 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010488c:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80104891:	eb 11                	jmp    801048a4 <exit+0xf4>
80104893:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104897:	90                   	nop
80104898:	05 8c 00 00 00       	add    $0x8c,%eax
8010489d:	3d 54 50 11 80       	cmp    $0x80115054,%eax
801048a2:	74 cc                	je     80104870 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
801048a4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801048a8:	75 ee                	jne    80104898 <exit+0xe8>
801048aa:	3b 48 20             	cmp    0x20(%eax),%ecx
801048ad:	75 e9                	jne    80104898 <exit+0xe8>
      p->state = RUNNABLE;
801048af:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801048b6:	eb e0                	jmp    80104898 <exit+0xe8>
  curproc->state = ZOMBIE;
801048b8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801048bf:	e8 bc f4 ff ff       	call   80103d80 <sched>
  panic("zombie exit");
801048c4:	83 ec 0c             	sub    $0xc,%esp
801048c7:	68 cc 7e 10 80       	push   $0x80107ecc
801048cc:	e8 af ba ff ff       	call   80100380 <panic>
    panic("init exiting");
801048d1:	83 ec 0c             	sub    $0xc,%esp
801048d4:	68 bf 7e 10 80       	push   $0x80107ebf
801048d9:	e8 a2 ba ff ff       	call   80100380 <panic>
801048de:	66 90                	xchg   %ax,%ax

801048e0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	53                   	push   %ebx
801048e4:	83 ec 0c             	sub    $0xc,%esp
801048e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801048ea:	68 70 7f 10 80       	push   $0x80107f70
801048ef:	8d 43 04             	lea    0x4(%ebx),%eax
801048f2:	50                   	push   %eax
801048f3:	e8 18 01 00 00       	call   80104a10 <initlock>
  lk->name = name;
801048f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801048fb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104901:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104904:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010490b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010490e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104911:	c9                   	leave  
80104912:	c3                   	ret    
80104913:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010491a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104920 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	56                   	push   %esi
80104924:	53                   	push   %ebx
80104925:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104928:	8d 73 04             	lea    0x4(%ebx),%esi
8010492b:	83 ec 0c             	sub    $0xc,%esp
8010492e:	56                   	push   %esi
8010492f:	e8 ac 02 00 00       	call   80104be0 <acquire>
  while (lk->locked) {
80104934:	8b 13                	mov    (%ebx),%edx
80104936:	83 c4 10             	add    $0x10,%esp
80104939:	85 d2                	test   %edx,%edx
8010493b:	74 16                	je     80104953 <acquiresleep+0x33>
8010493d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104940:	83 ec 08             	sub    $0x8,%esp
80104943:	56                   	push   %esi
80104944:	53                   	push   %ebx
80104945:	e8 76 f6 ff ff       	call   80103fc0 <sleep>
  while (lk->locked) {
8010494a:	8b 03                	mov    (%ebx),%eax
8010494c:	83 c4 10             	add    $0x10,%esp
8010494f:	85 c0                	test   %eax,%eax
80104951:	75 ed                	jne    80104940 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104953:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104959:	e8 32 f0 ff ff       	call   80103990 <myproc>
8010495e:	8b 40 10             	mov    0x10(%eax),%eax
80104961:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104964:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104967:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010496a:	5b                   	pop    %ebx
8010496b:	5e                   	pop    %esi
8010496c:	5d                   	pop    %ebp
  release(&lk->lk);
8010496d:	e9 0e 02 00 00       	jmp    80104b80 <release>
80104972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104980 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	56                   	push   %esi
80104984:	53                   	push   %ebx
80104985:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104988:	8d 73 04             	lea    0x4(%ebx),%esi
8010498b:	83 ec 0c             	sub    $0xc,%esp
8010498e:	56                   	push   %esi
8010498f:	e8 4c 02 00 00       	call   80104be0 <acquire>
  lk->locked = 0;
80104994:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010499a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801049a1:	89 1c 24             	mov    %ebx,(%esp)
801049a4:	e8 d7 f6 ff ff       	call   80104080 <wakeup>
  release(&lk->lk);
801049a9:	89 75 08             	mov    %esi,0x8(%ebp)
801049ac:	83 c4 10             	add    $0x10,%esp
}
801049af:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049b2:	5b                   	pop    %ebx
801049b3:	5e                   	pop    %esi
801049b4:	5d                   	pop    %ebp
  release(&lk->lk);
801049b5:	e9 c6 01 00 00       	jmp    80104b80 <release>
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049c0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801049c0:	55                   	push   %ebp
801049c1:	89 e5                	mov    %esp,%ebp
801049c3:	57                   	push   %edi
801049c4:	31 ff                	xor    %edi,%edi
801049c6:	56                   	push   %esi
801049c7:	53                   	push   %ebx
801049c8:	83 ec 18             	sub    $0x18,%esp
801049cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801049ce:	8d 73 04             	lea    0x4(%ebx),%esi
801049d1:	56                   	push   %esi
801049d2:	e8 09 02 00 00       	call   80104be0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801049d7:	8b 03                	mov    (%ebx),%eax
801049d9:	83 c4 10             	add    $0x10,%esp
801049dc:	85 c0                	test   %eax,%eax
801049de:	75 18                	jne    801049f8 <holdingsleep+0x38>
  release(&lk->lk);
801049e0:	83 ec 0c             	sub    $0xc,%esp
801049e3:	56                   	push   %esi
801049e4:	e8 97 01 00 00       	call   80104b80 <release>
  return r;
}
801049e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049ec:	89 f8                	mov    %edi,%eax
801049ee:	5b                   	pop    %ebx
801049ef:	5e                   	pop    %esi
801049f0:	5f                   	pop    %edi
801049f1:	5d                   	pop    %ebp
801049f2:	c3                   	ret    
801049f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801049f7:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
801049f8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801049fb:	e8 90 ef ff ff       	call   80103990 <myproc>
80104a00:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a03:	0f 94 c0             	sete   %al
80104a06:	0f b6 c0             	movzbl %al,%eax
80104a09:	89 c7                	mov    %eax,%edi
80104a0b:	eb d3                	jmp    801049e0 <holdingsleep+0x20>
80104a0d:	66 90                	xchg   %ax,%ax
80104a0f:	90                   	nop

80104a10 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104a10:	55                   	push   %ebp
80104a11:	89 e5                	mov    %esp,%ebp
80104a13:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104a16:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104a19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104a1f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104a22:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104a29:	5d                   	pop    %ebp
80104a2a:	c3                   	ret    
80104a2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a2f:	90                   	nop

80104a30 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104a30:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104a31:	31 d2                	xor    %edx,%edx
{
80104a33:	89 e5                	mov    %esp,%ebp
80104a35:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104a36:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104a39:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104a3c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104a3f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104a40:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104a46:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104a4c:	77 1a                	ja     80104a68 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104a4e:	8b 58 04             	mov    0x4(%eax),%ebx
80104a51:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104a54:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104a57:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104a59:	83 fa 0a             	cmp    $0xa,%edx
80104a5c:	75 e2                	jne    80104a40 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104a5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a61:	c9                   	leave  
80104a62:	c3                   	ret    
80104a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a67:	90                   	nop
  for(; i < 10; i++)
80104a68:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104a6b:	8d 51 28             	lea    0x28(%ecx),%edx
80104a6e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104a70:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104a76:	83 c0 04             	add    $0x4,%eax
80104a79:	39 d0                	cmp    %edx,%eax
80104a7b:	75 f3                	jne    80104a70 <getcallerpcs+0x40>
}
80104a7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a80:	c9                   	leave  
80104a81:	c3                   	ret    
80104a82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a90 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104a90:	55                   	push   %ebp
80104a91:	89 e5                	mov    %esp,%ebp
80104a93:	53                   	push   %ebx
80104a94:	83 ec 04             	sub    $0x4,%esp
80104a97:	9c                   	pushf  
80104a98:	5b                   	pop    %ebx
  asm volatile("cli");
80104a99:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104a9a:	e8 71 ee ff ff       	call   80103910 <mycpu>
80104a9f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104aa5:	85 c0                	test   %eax,%eax
80104aa7:	74 17                	je     80104ac0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104aa9:	e8 62 ee ff ff       	call   80103910 <mycpu>
80104aae:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104ab5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ab8:	c9                   	leave  
80104ab9:	c3                   	ret    
80104aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104ac0:	e8 4b ee ff ff       	call   80103910 <mycpu>
80104ac5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104acb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104ad1:	eb d6                	jmp    80104aa9 <pushcli+0x19>
80104ad3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ae0 <popcli>:

void
popcli(void)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104ae6:	9c                   	pushf  
80104ae7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104ae8:	f6 c4 02             	test   $0x2,%ah
80104aeb:	75 35                	jne    80104b22 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104aed:	e8 1e ee ff ff       	call   80103910 <mycpu>
80104af2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104af9:	78 34                	js     80104b2f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104afb:	e8 10 ee ff ff       	call   80103910 <mycpu>
80104b00:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b06:	85 d2                	test   %edx,%edx
80104b08:	74 06                	je     80104b10 <popcli+0x30>
    sti();
}
80104b0a:	c9                   	leave  
80104b0b:	c3                   	ret    
80104b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104b10:	e8 fb ed ff ff       	call   80103910 <mycpu>
80104b15:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b1b:	85 c0                	test   %eax,%eax
80104b1d:	74 eb                	je     80104b0a <popcli+0x2a>
  asm volatile("sti");
80104b1f:	fb                   	sti    
}
80104b20:	c9                   	leave  
80104b21:	c3                   	ret    
    panic("popcli - interruptible");
80104b22:	83 ec 0c             	sub    $0xc,%esp
80104b25:	68 7b 7f 10 80       	push   $0x80107f7b
80104b2a:	e8 51 b8 ff ff       	call   80100380 <panic>
    panic("popcli");
80104b2f:	83 ec 0c             	sub    $0xc,%esp
80104b32:	68 92 7f 10 80       	push   $0x80107f92
80104b37:	e8 44 b8 ff ff       	call   80100380 <panic>
80104b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b40 <holding>:
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	56                   	push   %esi
80104b44:	53                   	push   %ebx
80104b45:	8b 75 08             	mov    0x8(%ebp),%esi
80104b48:	31 db                	xor    %ebx,%ebx
  pushcli();
80104b4a:	e8 41 ff ff ff       	call   80104a90 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104b4f:	8b 06                	mov    (%esi),%eax
80104b51:	85 c0                	test   %eax,%eax
80104b53:	75 0b                	jne    80104b60 <holding+0x20>
  popcli();
80104b55:	e8 86 ff ff ff       	call   80104ae0 <popcli>
}
80104b5a:	89 d8                	mov    %ebx,%eax
80104b5c:	5b                   	pop    %ebx
80104b5d:	5e                   	pop    %esi
80104b5e:	5d                   	pop    %ebp
80104b5f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104b60:	8b 5e 08             	mov    0x8(%esi),%ebx
80104b63:	e8 a8 ed ff ff       	call   80103910 <mycpu>
80104b68:	39 c3                	cmp    %eax,%ebx
80104b6a:	0f 94 c3             	sete   %bl
  popcli();
80104b6d:	e8 6e ff ff ff       	call   80104ae0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104b72:	0f b6 db             	movzbl %bl,%ebx
}
80104b75:	89 d8                	mov    %ebx,%eax
80104b77:	5b                   	pop    %ebx
80104b78:	5e                   	pop    %esi
80104b79:	5d                   	pop    %ebp
80104b7a:	c3                   	ret    
80104b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b7f:	90                   	nop

80104b80 <release>:
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	56                   	push   %esi
80104b84:	53                   	push   %ebx
80104b85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104b88:	e8 03 ff ff ff       	call   80104a90 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104b8d:	8b 03                	mov    (%ebx),%eax
80104b8f:	85 c0                	test   %eax,%eax
80104b91:	75 15                	jne    80104ba8 <release+0x28>
  popcli();
80104b93:	e8 48 ff ff ff       	call   80104ae0 <popcli>
    panic("release");
80104b98:	83 ec 0c             	sub    $0xc,%esp
80104b9b:	68 99 7f 10 80       	push   $0x80107f99
80104ba0:	e8 db b7 ff ff       	call   80100380 <panic>
80104ba5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104ba8:	8b 73 08             	mov    0x8(%ebx),%esi
80104bab:	e8 60 ed ff ff       	call   80103910 <mycpu>
80104bb0:	39 c6                	cmp    %eax,%esi
80104bb2:	75 df                	jne    80104b93 <release+0x13>
  popcli();
80104bb4:	e8 27 ff ff ff       	call   80104ae0 <popcli>
  lk->pcs[0] = 0;
80104bb9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104bc0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104bc7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104bcc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104bd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bd5:	5b                   	pop    %ebx
80104bd6:	5e                   	pop    %esi
80104bd7:	5d                   	pop    %ebp
  popcli();
80104bd8:	e9 03 ff ff ff       	jmp    80104ae0 <popcli>
80104bdd:	8d 76 00             	lea    0x0(%esi),%esi

80104be0 <acquire>:
{
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	53                   	push   %ebx
80104be4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104be7:	e8 a4 fe ff ff       	call   80104a90 <pushcli>
  if(holding(lk))
80104bec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104bef:	e8 9c fe ff ff       	call   80104a90 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104bf4:	8b 03                	mov    (%ebx),%eax
80104bf6:	85 c0                	test   %eax,%eax
80104bf8:	75 7e                	jne    80104c78 <acquire+0x98>
  popcli();
80104bfa:	e8 e1 fe ff ff       	call   80104ae0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104bff:	b9 01 00 00 00       	mov    $0x1,%ecx
80104c04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80104c08:	8b 55 08             	mov    0x8(%ebp),%edx
80104c0b:	89 c8                	mov    %ecx,%eax
80104c0d:	f0 87 02             	lock xchg %eax,(%edx)
80104c10:	85 c0                	test   %eax,%eax
80104c12:	75 f4                	jne    80104c08 <acquire+0x28>
  __sync_synchronize();
80104c14:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104c19:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c1c:	e8 ef ec ff ff       	call   80103910 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104c21:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80104c24:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80104c26:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80104c29:	31 c0                	xor    %eax,%eax
80104c2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c2f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104c30:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104c36:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104c3c:	77 1a                	ja     80104c58 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
80104c3e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104c41:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104c45:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104c48:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104c4a:	83 f8 0a             	cmp    $0xa,%eax
80104c4d:	75 e1                	jne    80104c30 <acquire+0x50>
}
80104c4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c52:	c9                   	leave  
80104c53:	c3                   	ret    
80104c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104c58:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
80104c5c:	8d 51 34             	lea    0x34(%ecx),%edx
80104c5f:	90                   	nop
    pcs[i] = 0;
80104c60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104c66:	83 c0 04             	add    $0x4,%eax
80104c69:	39 c2                	cmp    %eax,%edx
80104c6b:	75 f3                	jne    80104c60 <acquire+0x80>
}
80104c6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c70:	c9                   	leave  
80104c71:	c3                   	ret    
80104c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104c78:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104c7b:	e8 90 ec ff ff       	call   80103910 <mycpu>
80104c80:	39 c3                	cmp    %eax,%ebx
80104c82:	0f 85 72 ff ff ff    	jne    80104bfa <acquire+0x1a>
  popcli();
80104c88:	e8 53 fe ff ff       	call   80104ae0 <popcli>
    panic("acquire");
80104c8d:	83 ec 0c             	sub    $0xc,%esp
80104c90:	68 a1 7f 10 80       	push   $0x80107fa1
80104c95:	e8 e6 b6 ff ff       	call   80100380 <panic>
80104c9a:	66 90                	xchg   %ax,%ax
80104c9c:	66 90                	xchg   %ax,%ax
80104c9e:	66 90                	xchg   %ax,%ax

80104ca0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104ca0:	55                   	push   %ebp
80104ca1:	89 e5                	mov    %esp,%ebp
80104ca3:	57                   	push   %edi
80104ca4:	8b 55 08             	mov    0x8(%ebp),%edx
80104ca7:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104caa:	53                   	push   %ebx
80104cab:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104cae:	89 d7                	mov    %edx,%edi
80104cb0:	09 cf                	or     %ecx,%edi
80104cb2:	83 e7 03             	and    $0x3,%edi
80104cb5:	75 29                	jne    80104ce0 <memset+0x40>
    c &= 0xFF;
80104cb7:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104cba:	c1 e0 18             	shl    $0x18,%eax
80104cbd:	89 fb                	mov    %edi,%ebx
80104cbf:	c1 e9 02             	shr    $0x2,%ecx
80104cc2:	c1 e3 10             	shl    $0x10,%ebx
80104cc5:	09 d8                	or     %ebx,%eax
80104cc7:	09 f8                	or     %edi,%eax
80104cc9:	c1 e7 08             	shl    $0x8,%edi
80104ccc:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104cce:	89 d7                	mov    %edx,%edi
80104cd0:	fc                   	cld    
80104cd1:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104cd3:	5b                   	pop    %ebx
80104cd4:	89 d0                	mov    %edx,%eax
80104cd6:	5f                   	pop    %edi
80104cd7:	5d                   	pop    %ebp
80104cd8:	c3                   	ret    
80104cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104ce0:	89 d7                	mov    %edx,%edi
80104ce2:	fc                   	cld    
80104ce3:	f3 aa                	rep stos %al,%es:(%edi)
80104ce5:	5b                   	pop    %ebx
80104ce6:	89 d0                	mov    %edx,%eax
80104ce8:	5f                   	pop    %edi
80104ce9:	5d                   	pop    %ebp
80104cea:	c3                   	ret    
80104ceb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cef:	90                   	nop

80104cf0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	8b 75 10             	mov    0x10(%ebp),%esi
80104cf7:	8b 55 08             	mov    0x8(%ebp),%edx
80104cfa:	53                   	push   %ebx
80104cfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104cfe:	85 f6                	test   %esi,%esi
80104d00:	74 2e                	je     80104d30 <memcmp+0x40>
80104d02:	01 c6                	add    %eax,%esi
80104d04:	eb 14                	jmp    80104d1a <memcmp+0x2a>
80104d06:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104d10:	83 c0 01             	add    $0x1,%eax
80104d13:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104d16:	39 f0                	cmp    %esi,%eax
80104d18:	74 16                	je     80104d30 <memcmp+0x40>
    if(*s1 != *s2)
80104d1a:	0f b6 0a             	movzbl (%edx),%ecx
80104d1d:	0f b6 18             	movzbl (%eax),%ebx
80104d20:	38 d9                	cmp    %bl,%cl
80104d22:	74 ec                	je     80104d10 <memcmp+0x20>
      return *s1 - *s2;
80104d24:	0f b6 c1             	movzbl %cl,%eax
80104d27:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104d29:	5b                   	pop    %ebx
80104d2a:	5e                   	pop    %esi
80104d2b:	5d                   	pop    %ebp
80104d2c:	c3                   	ret    
80104d2d:	8d 76 00             	lea    0x0(%esi),%esi
80104d30:	5b                   	pop    %ebx
  return 0;
80104d31:	31 c0                	xor    %eax,%eax
}
80104d33:	5e                   	pop    %esi
80104d34:	5d                   	pop    %ebp
80104d35:	c3                   	ret    
80104d36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d3d:	8d 76 00             	lea    0x0(%esi),%esi

80104d40 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	57                   	push   %edi
80104d44:	8b 55 08             	mov    0x8(%ebp),%edx
80104d47:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d4a:	56                   	push   %esi
80104d4b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104d4e:	39 d6                	cmp    %edx,%esi
80104d50:	73 26                	jae    80104d78 <memmove+0x38>
80104d52:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104d55:	39 fa                	cmp    %edi,%edx
80104d57:	73 1f                	jae    80104d78 <memmove+0x38>
80104d59:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80104d5c:	85 c9                	test   %ecx,%ecx
80104d5e:	74 0c                	je     80104d6c <memmove+0x2c>
      *--d = *--s;
80104d60:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104d64:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104d67:	83 e8 01             	sub    $0x1,%eax
80104d6a:	73 f4                	jae    80104d60 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104d6c:	5e                   	pop    %esi
80104d6d:	89 d0                	mov    %edx,%eax
80104d6f:	5f                   	pop    %edi
80104d70:	5d                   	pop    %ebp
80104d71:	c3                   	ret    
80104d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104d78:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104d7b:	89 d7                	mov    %edx,%edi
80104d7d:	85 c9                	test   %ecx,%ecx
80104d7f:	74 eb                	je     80104d6c <memmove+0x2c>
80104d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104d88:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104d89:	39 c6                	cmp    %eax,%esi
80104d8b:	75 fb                	jne    80104d88 <memmove+0x48>
}
80104d8d:	5e                   	pop    %esi
80104d8e:	89 d0                	mov    %edx,%eax
80104d90:	5f                   	pop    %edi
80104d91:	5d                   	pop    %ebp
80104d92:	c3                   	ret    
80104d93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104da0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104da0:	eb 9e                	jmp    80104d40 <memmove>
80104da2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104db0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104db0:	55                   	push   %ebp
80104db1:	89 e5                	mov    %esp,%ebp
80104db3:	56                   	push   %esi
80104db4:	8b 75 10             	mov    0x10(%ebp),%esi
80104db7:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104dba:	53                   	push   %ebx
80104dbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(n > 0 && *p && *p == *q)
80104dbe:	85 f6                	test   %esi,%esi
80104dc0:	74 2e                	je     80104df0 <strncmp+0x40>
80104dc2:	01 d6                	add    %edx,%esi
80104dc4:	eb 18                	jmp    80104dde <strncmp+0x2e>
80104dc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dcd:	8d 76 00             	lea    0x0(%esi),%esi
80104dd0:	38 d8                	cmp    %bl,%al
80104dd2:	75 14                	jne    80104de8 <strncmp+0x38>
    n--, p++, q++;
80104dd4:	83 c2 01             	add    $0x1,%edx
80104dd7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104dda:	39 f2                	cmp    %esi,%edx
80104ddc:	74 12                	je     80104df0 <strncmp+0x40>
80104dde:	0f b6 01             	movzbl (%ecx),%eax
80104de1:	0f b6 1a             	movzbl (%edx),%ebx
80104de4:	84 c0                	test   %al,%al
80104de6:	75 e8                	jne    80104dd0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104de8:	29 d8                	sub    %ebx,%eax
}
80104dea:	5b                   	pop    %ebx
80104deb:	5e                   	pop    %esi
80104dec:	5d                   	pop    %ebp
80104ded:	c3                   	ret    
80104dee:	66 90                	xchg   %ax,%ax
80104df0:	5b                   	pop    %ebx
    return 0;
80104df1:	31 c0                	xor    %eax,%eax
}
80104df3:	5e                   	pop    %esi
80104df4:	5d                   	pop    %ebp
80104df5:	c3                   	ret    
80104df6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfd:	8d 76 00             	lea    0x0(%esi),%esi

80104e00 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	56                   	push   %esi
80104e05:	8b 75 08             	mov    0x8(%ebp),%esi
80104e08:	53                   	push   %ebx
80104e09:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104e0c:	89 f0                	mov    %esi,%eax
80104e0e:	eb 15                	jmp    80104e25 <strncpy+0x25>
80104e10:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e14:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e17:	83 c0 01             	add    $0x1,%eax
80104e1a:	0f b6 57 ff          	movzbl -0x1(%edi),%edx
80104e1e:	88 50 ff             	mov    %dl,-0x1(%eax)
80104e21:	84 d2                	test   %dl,%dl
80104e23:	74 09                	je     80104e2e <strncpy+0x2e>
80104e25:	89 cb                	mov    %ecx,%ebx
80104e27:	83 e9 01             	sub    $0x1,%ecx
80104e2a:	85 db                	test   %ebx,%ebx
80104e2c:	7f e2                	jg     80104e10 <strncpy+0x10>
    ;
  while(n-- > 0)
80104e2e:	89 c2                	mov    %eax,%edx
80104e30:	85 c9                	test   %ecx,%ecx
80104e32:	7e 17                	jle    80104e4b <strncpy+0x4b>
80104e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104e38:	83 c2 01             	add    $0x1,%edx
80104e3b:	89 c1                	mov    %eax,%ecx
80104e3d:	c6 42 ff 00          	movb   $0x0,-0x1(%edx)
  while(n-- > 0)
80104e41:	29 d1                	sub    %edx,%ecx
80104e43:	8d 4c 0b ff          	lea    -0x1(%ebx,%ecx,1),%ecx
80104e47:	85 c9                	test   %ecx,%ecx
80104e49:	7f ed                	jg     80104e38 <strncpy+0x38>
  return os;
}
80104e4b:	5b                   	pop    %ebx
80104e4c:	89 f0                	mov    %esi,%eax
80104e4e:	5e                   	pop    %esi
80104e4f:	5f                   	pop    %edi
80104e50:	5d                   	pop    %ebp
80104e51:	c3                   	ret    
80104e52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104e60 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	56                   	push   %esi
80104e64:	8b 55 10             	mov    0x10(%ebp),%edx
80104e67:	8b 75 08             	mov    0x8(%ebp),%esi
80104e6a:	53                   	push   %ebx
80104e6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104e6e:	85 d2                	test   %edx,%edx
80104e70:	7e 25                	jle    80104e97 <safestrcpy+0x37>
80104e72:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104e76:	89 f2                	mov    %esi,%edx
80104e78:	eb 16                	jmp    80104e90 <safestrcpy+0x30>
80104e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104e80:	0f b6 08             	movzbl (%eax),%ecx
80104e83:	83 c0 01             	add    $0x1,%eax
80104e86:	83 c2 01             	add    $0x1,%edx
80104e89:	88 4a ff             	mov    %cl,-0x1(%edx)
80104e8c:	84 c9                	test   %cl,%cl
80104e8e:	74 04                	je     80104e94 <safestrcpy+0x34>
80104e90:	39 d8                	cmp    %ebx,%eax
80104e92:	75 ec                	jne    80104e80 <safestrcpy+0x20>
    ;
  *s = 0;
80104e94:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104e97:	89 f0                	mov    %esi,%eax
80104e99:	5b                   	pop    %ebx
80104e9a:	5e                   	pop    %esi
80104e9b:	5d                   	pop    %ebp
80104e9c:	c3                   	ret    
80104e9d:	8d 76 00             	lea    0x0(%esi),%esi

80104ea0 <strlen>:

int
strlen(const char *s)
{
80104ea0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104ea1:	31 c0                	xor    %eax,%eax
{
80104ea3:	89 e5                	mov    %esp,%ebp
80104ea5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104ea8:	80 3a 00             	cmpb   $0x0,(%edx)
80104eab:	74 0c                	je     80104eb9 <strlen+0x19>
80104ead:	8d 76 00             	lea    0x0(%esi),%esi
80104eb0:	83 c0 01             	add    $0x1,%eax
80104eb3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104eb7:	75 f7                	jne    80104eb0 <strlen+0x10>
    ;
  return n;
}
80104eb9:	5d                   	pop    %ebp
80104eba:	c3                   	ret    

80104ebb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104ebb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104ebf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104ec3:	55                   	push   %ebp
  pushl %ebx
80104ec4:	53                   	push   %ebx
  pushl %esi
80104ec5:	56                   	push   %esi
  pushl %edi
80104ec6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104ec7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104ec9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104ecb:	5f                   	pop    %edi
  popl %esi
80104ecc:	5e                   	pop    %esi
  popl %ebx
80104ecd:	5b                   	pop    %ebx
  popl %ebp
80104ece:	5d                   	pop    %ebp
  ret
80104ecf:	c3                   	ret    

80104ed0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	53                   	push   %ebx
80104ed4:	83 ec 04             	sub    $0x4,%esp
80104ed7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104eda:	e8 b1 ea ff ff       	call   80103990 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104edf:	8b 00                	mov    (%eax),%eax
80104ee1:	39 d8                	cmp    %ebx,%eax
80104ee3:	76 1b                	jbe    80104f00 <fetchint+0x30>
80104ee5:	8d 53 04             	lea    0x4(%ebx),%edx
80104ee8:	39 d0                	cmp    %edx,%eax
80104eea:	72 14                	jb     80104f00 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104eec:	8b 45 0c             	mov    0xc(%ebp),%eax
80104eef:	8b 13                	mov    (%ebx),%edx
80104ef1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ef3:	31 c0                	xor    %eax,%eax
}
80104ef5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ef8:	c9                   	leave  
80104ef9:	c3                   	ret    
80104efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f05:	eb ee                	jmp    80104ef5 <fetchint+0x25>
80104f07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f0e:	66 90                	xchg   %ax,%ax

80104f10 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104f10:	55                   	push   %ebp
80104f11:	89 e5                	mov    %esp,%ebp
80104f13:	53                   	push   %ebx
80104f14:	83 ec 04             	sub    $0x4,%esp
80104f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104f1a:	e8 71 ea ff ff       	call   80103990 <myproc>

  if(addr >= curproc->sz)
80104f1f:	39 18                	cmp    %ebx,(%eax)
80104f21:	76 2d                	jbe    80104f50 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104f23:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f26:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104f28:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104f2a:	39 d3                	cmp    %edx,%ebx
80104f2c:	73 22                	jae    80104f50 <fetchstr+0x40>
80104f2e:	89 d8                	mov    %ebx,%eax
80104f30:	eb 0d                	jmp    80104f3f <fetchstr+0x2f>
80104f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f38:	83 c0 01             	add    $0x1,%eax
80104f3b:	39 c2                	cmp    %eax,%edx
80104f3d:	76 11                	jbe    80104f50 <fetchstr+0x40>
    if(*s == 0)
80104f3f:	80 38 00             	cmpb   $0x0,(%eax)
80104f42:	75 f4                	jne    80104f38 <fetchstr+0x28>
      return s - *pp;
80104f44:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104f46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f49:	c9                   	leave  
80104f4a:	c3                   	ret    
80104f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f4f:	90                   	nop
80104f50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104f53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f58:	c9                   	leave  
80104f59:	c3                   	ret    
80104f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f60 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	56                   	push   %esi
80104f64:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f65:	e8 26 ea ff ff       	call   80103990 <myproc>
80104f6a:	8b 55 08             	mov    0x8(%ebp),%edx
80104f6d:	8b 40 18             	mov    0x18(%eax),%eax
80104f70:	8b 40 44             	mov    0x44(%eax),%eax
80104f73:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104f76:	e8 15 ea ff ff       	call   80103990 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104f7b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104f7e:	8b 00                	mov    (%eax),%eax
80104f80:	39 c6                	cmp    %eax,%esi
80104f82:	73 1c                	jae    80104fa0 <argint+0x40>
80104f84:	8d 53 08             	lea    0x8(%ebx),%edx
80104f87:	39 d0                	cmp    %edx,%eax
80104f89:	72 15                	jb     80104fa0 <argint+0x40>
  *ip = *(int*)(addr);
80104f8b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f8e:	8b 53 04             	mov    0x4(%ebx),%edx
80104f91:	89 10                	mov    %edx,(%eax)
  return 0;
80104f93:	31 c0                	xor    %eax,%eax
}
80104f95:	5b                   	pop    %ebx
80104f96:	5e                   	pop    %esi
80104f97:	5d                   	pop    %ebp
80104f98:	c3                   	ret    
80104f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104fa0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fa5:	eb ee                	jmp    80104f95 <argint+0x35>
80104fa7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fae:	66 90                	xchg   %ax,%ax

80104fb0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	57                   	push   %edi
80104fb4:	56                   	push   %esi
80104fb5:	53                   	push   %ebx
80104fb6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104fb9:	e8 d2 e9 ff ff       	call   80103990 <myproc>
80104fbe:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fc0:	e8 cb e9 ff ff       	call   80103990 <myproc>
80104fc5:	8b 55 08             	mov    0x8(%ebp),%edx
80104fc8:	8b 40 18             	mov    0x18(%eax),%eax
80104fcb:	8b 40 44             	mov    0x44(%eax),%eax
80104fce:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104fd1:	e8 ba e9 ff ff       	call   80103990 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104fd6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104fd9:	8b 00                	mov    (%eax),%eax
80104fdb:	39 c7                	cmp    %eax,%edi
80104fdd:	73 31                	jae    80105010 <argptr+0x60>
80104fdf:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104fe2:	39 c8                	cmp    %ecx,%eax
80104fe4:	72 2a                	jb     80105010 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104fe6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104fe9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104fec:	85 d2                	test   %edx,%edx
80104fee:	78 20                	js     80105010 <argptr+0x60>
80104ff0:	8b 16                	mov    (%esi),%edx
80104ff2:	39 c2                	cmp    %eax,%edx
80104ff4:	76 1a                	jbe    80105010 <argptr+0x60>
80104ff6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104ff9:	01 c3                	add    %eax,%ebx
80104ffb:	39 da                	cmp    %ebx,%edx
80104ffd:	72 11                	jb     80105010 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104fff:	8b 55 0c             	mov    0xc(%ebp),%edx
80105002:	89 02                	mov    %eax,(%edx)
  return 0;
80105004:	31 c0                	xor    %eax,%eax
}
80105006:	83 c4 0c             	add    $0xc,%esp
80105009:	5b                   	pop    %ebx
8010500a:	5e                   	pop    %esi
8010500b:	5f                   	pop    %edi
8010500c:	5d                   	pop    %ebp
8010500d:	c3                   	ret    
8010500e:	66 90                	xchg   %ax,%ax
    return -1;
80105010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105015:	eb ef                	jmp    80105006 <argptr+0x56>
80105017:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010501e:	66 90                	xchg   %ax,%ax

80105020 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	56                   	push   %esi
80105024:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105025:	e8 66 e9 ff ff       	call   80103990 <myproc>
8010502a:	8b 55 08             	mov    0x8(%ebp),%edx
8010502d:	8b 40 18             	mov    0x18(%eax),%eax
80105030:	8b 40 44             	mov    0x44(%eax),%eax
80105033:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105036:	e8 55 e9 ff ff       	call   80103990 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010503b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010503e:	8b 00                	mov    (%eax),%eax
80105040:	39 c6                	cmp    %eax,%esi
80105042:	73 44                	jae    80105088 <argstr+0x68>
80105044:	8d 53 08             	lea    0x8(%ebx),%edx
80105047:	39 d0                	cmp    %edx,%eax
80105049:	72 3d                	jb     80105088 <argstr+0x68>
  *ip = *(int*)(addr);
8010504b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010504e:	e8 3d e9 ff ff       	call   80103990 <myproc>
  if(addr >= curproc->sz)
80105053:	3b 18                	cmp    (%eax),%ebx
80105055:	73 31                	jae    80105088 <argstr+0x68>
  *pp = (char*)addr;
80105057:	8b 55 0c             	mov    0xc(%ebp),%edx
8010505a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010505c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010505e:	39 d3                	cmp    %edx,%ebx
80105060:	73 26                	jae    80105088 <argstr+0x68>
80105062:	89 d8                	mov    %ebx,%eax
80105064:	eb 11                	jmp    80105077 <argstr+0x57>
80105066:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010506d:	8d 76 00             	lea    0x0(%esi),%esi
80105070:	83 c0 01             	add    $0x1,%eax
80105073:	39 c2                	cmp    %eax,%edx
80105075:	76 11                	jbe    80105088 <argstr+0x68>
    if(*s == 0)
80105077:	80 38 00             	cmpb   $0x0,(%eax)
8010507a:	75 f4                	jne    80105070 <argstr+0x50>
      return s - *pp;
8010507c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010507e:	5b                   	pop    %ebx
8010507f:	5e                   	pop    %esi
80105080:	5d                   	pop    %ebp
80105081:	c3                   	ret    
80105082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105088:	5b                   	pop    %ebx
    return -1;
80105089:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010508e:	5e                   	pop    %esi
8010508f:	5d                   	pop    %ebp
80105090:	c3                   	ret    
80105091:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105098:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010509f:	90                   	nop

801050a0 <syscall>:

};

void
syscall(void)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	53                   	push   %ebx
801050a4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801050a7:	e8 e4 e8 ff ff       	call   80103990 <myproc>
801050ac:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801050ae:	8b 40 18             	mov    0x18(%eax),%eax
801050b1:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801050b4:	8d 50 ff             	lea    -0x1(%eax),%edx
801050b7:	83 fa 17             	cmp    $0x17,%edx
801050ba:	77 24                	ja     801050e0 <syscall+0x40>
801050bc:	8b 14 85 e0 7f 10 80 	mov    -0x7fef8020(,%eax,4),%edx
801050c3:	85 d2                	test   %edx,%edx
801050c5:	74 19                	je     801050e0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801050c7:	ff d2                	call   *%edx
801050c9:	89 c2                	mov    %eax,%edx
801050cb:	8b 43 18             	mov    0x18(%ebx),%eax
801050ce:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801050d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050d4:	c9                   	leave  
801050d5:	c3                   	ret    
801050d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050dd:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801050e0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801050e1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801050e4:	50                   	push   %eax
801050e5:	ff 73 10             	push   0x10(%ebx)
801050e8:	68 a9 7f 10 80       	push   $0x80107fa9
801050ed:	e8 ae b5 ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
801050f2:	8b 43 18             	mov    0x18(%ebx),%eax
801050f5:	83 c4 10             	add    $0x10,%esp
801050f8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801050ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105102:	c9                   	leave  
80105103:	c3                   	ret    
80105104:	66 90                	xchg   %ax,%ax
80105106:	66 90                	xchg   %ax,%ax
80105108:	66 90                	xchg   %ax,%ax
8010510a:	66 90                	xchg   %ax,%ax
8010510c:	66 90                	xchg   %ax,%ax
8010510e:	66 90                	xchg   %ax,%ax

80105110 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105110:	55                   	push   %ebp
80105111:	89 e5                	mov    %esp,%ebp
80105113:	57                   	push   %edi
80105114:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105115:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105118:	53                   	push   %ebx
80105119:	83 ec 34             	sub    $0x34,%esp
8010511c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010511f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105122:	57                   	push   %edi
80105123:	50                   	push   %eax
{
80105124:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105127:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010512a:	e8 91 cf ff ff       	call   801020c0 <nameiparent>
8010512f:	83 c4 10             	add    $0x10,%esp
80105132:	85 c0                	test   %eax,%eax
80105134:	0f 84 46 01 00 00    	je     80105280 <create+0x170>
    return 0;
  ilock(dp);
8010513a:	83 ec 0c             	sub    $0xc,%esp
8010513d:	89 c3                	mov    %eax,%ebx
8010513f:	50                   	push   %eax
80105140:	e8 3b c6 ff ff       	call   80101780 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105145:	83 c4 0c             	add    $0xc,%esp
80105148:	6a 00                	push   $0x0
8010514a:	57                   	push   %edi
8010514b:	53                   	push   %ebx
8010514c:	e8 8f cb ff ff       	call   80101ce0 <dirlookup>
80105151:	83 c4 10             	add    $0x10,%esp
80105154:	89 c6                	mov    %eax,%esi
80105156:	85 c0                	test   %eax,%eax
80105158:	74 56                	je     801051b0 <create+0xa0>
    iunlockput(dp);
8010515a:	83 ec 0c             	sub    $0xc,%esp
8010515d:	53                   	push   %ebx
8010515e:	e8 ad c8 ff ff       	call   80101a10 <iunlockput>
    ilock(ip);
80105163:	89 34 24             	mov    %esi,(%esp)
80105166:	e8 15 c6 ff ff       	call   80101780 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010516b:	83 c4 10             	add    $0x10,%esp
8010516e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105173:	75 1b                	jne    80105190 <create+0x80>
80105175:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010517a:	75 14                	jne    80105190 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010517c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010517f:	89 f0                	mov    %esi,%eax
80105181:	5b                   	pop    %ebx
80105182:	5e                   	pop    %esi
80105183:	5f                   	pop    %edi
80105184:	5d                   	pop    %ebp
80105185:	c3                   	ret    
80105186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010518d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105190:	83 ec 0c             	sub    $0xc,%esp
80105193:	56                   	push   %esi
    return 0;
80105194:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105196:	e8 75 c8 ff ff       	call   80101a10 <iunlockput>
    return 0;
8010519b:	83 c4 10             	add    $0x10,%esp
}
8010519e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051a1:	89 f0                	mov    %esi,%eax
801051a3:	5b                   	pop    %ebx
801051a4:	5e                   	pop    %esi
801051a5:	5f                   	pop    %edi
801051a6:	5d                   	pop    %ebp
801051a7:	c3                   	ret    
801051a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051af:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
801051b0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801051b4:	83 ec 08             	sub    $0x8,%esp
801051b7:	50                   	push   %eax
801051b8:	ff 33                	push   (%ebx)
801051ba:	e8 51 c4 ff ff       	call   80101610 <ialloc>
801051bf:	83 c4 10             	add    $0x10,%esp
801051c2:	89 c6                	mov    %eax,%esi
801051c4:	85 c0                	test   %eax,%eax
801051c6:	0f 84 cd 00 00 00    	je     80105299 <create+0x189>
  ilock(ip);
801051cc:	83 ec 0c             	sub    $0xc,%esp
801051cf:	50                   	push   %eax
801051d0:	e8 ab c5 ff ff       	call   80101780 <ilock>
  ip->major = major;
801051d5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801051d9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801051dd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801051e1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801051e5:	b8 01 00 00 00       	mov    $0x1,%eax
801051ea:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801051ee:	89 34 24             	mov    %esi,(%esp)
801051f1:	e8 da c4 ff ff       	call   801016d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801051f6:	83 c4 10             	add    $0x10,%esp
801051f9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801051fe:	74 30                	je     80105230 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105200:	83 ec 04             	sub    $0x4,%esp
80105203:	ff 76 04             	push   0x4(%esi)
80105206:	57                   	push   %edi
80105207:	53                   	push   %ebx
80105208:	e8 d3 cd ff ff       	call   80101fe0 <dirlink>
8010520d:	83 c4 10             	add    $0x10,%esp
80105210:	85 c0                	test   %eax,%eax
80105212:	78 78                	js     8010528c <create+0x17c>
  iunlockput(dp);
80105214:	83 ec 0c             	sub    $0xc,%esp
80105217:	53                   	push   %ebx
80105218:	e8 f3 c7 ff ff       	call   80101a10 <iunlockput>
  return ip;
8010521d:	83 c4 10             	add    $0x10,%esp
}
80105220:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105223:	89 f0                	mov    %esi,%eax
80105225:	5b                   	pop    %ebx
80105226:	5e                   	pop    %esi
80105227:	5f                   	pop    %edi
80105228:	5d                   	pop    %ebp
80105229:	c3                   	ret    
8010522a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105230:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105233:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105238:	53                   	push   %ebx
80105239:	e8 92 c4 ff ff       	call   801016d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010523e:	83 c4 0c             	add    $0xc,%esp
80105241:	ff 76 04             	push   0x4(%esi)
80105244:	68 60 80 10 80       	push   $0x80108060
80105249:	56                   	push   %esi
8010524a:	e8 91 cd ff ff       	call   80101fe0 <dirlink>
8010524f:	83 c4 10             	add    $0x10,%esp
80105252:	85 c0                	test   %eax,%eax
80105254:	78 18                	js     8010526e <create+0x15e>
80105256:	83 ec 04             	sub    $0x4,%esp
80105259:	ff 73 04             	push   0x4(%ebx)
8010525c:	68 5f 80 10 80       	push   $0x8010805f
80105261:	56                   	push   %esi
80105262:	e8 79 cd ff ff       	call   80101fe0 <dirlink>
80105267:	83 c4 10             	add    $0x10,%esp
8010526a:	85 c0                	test   %eax,%eax
8010526c:	79 92                	jns    80105200 <create+0xf0>
      panic("create dots");
8010526e:	83 ec 0c             	sub    $0xc,%esp
80105271:	68 53 80 10 80       	push   $0x80108053
80105276:	e8 05 b1 ff ff       	call   80100380 <panic>
8010527b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010527f:	90                   	nop
}
80105280:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105283:	31 f6                	xor    %esi,%esi
}
80105285:	5b                   	pop    %ebx
80105286:	89 f0                	mov    %esi,%eax
80105288:	5e                   	pop    %esi
80105289:	5f                   	pop    %edi
8010528a:	5d                   	pop    %ebp
8010528b:	c3                   	ret    
    panic("create: dirlink");
8010528c:	83 ec 0c             	sub    $0xc,%esp
8010528f:	68 62 80 10 80       	push   $0x80108062
80105294:	e8 e7 b0 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105299:	83 ec 0c             	sub    $0xc,%esp
8010529c:	68 44 80 10 80       	push   $0x80108044
801052a1:	e8 da b0 ff ff       	call   80100380 <panic>
801052a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ad:	8d 76 00             	lea    0x0(%esi),%esi

801052b0 <sys_dup>:
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	56                   	push   %esi
801052b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801052b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801052b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801052bb:	50                   	push   %eax
801052bc:	6a 00                	push   $0x0
801052be:	e8 9d fc ff ff       	call   80104f60 <argint>
801052c3:	83 c4 10             	add    $0x10,%esp
801052c6:	85 c0                	test   %eax,%eax
801052c8:	78 36                	js     80105300 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801052ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052ce:	77 30                	ja     80105300 <sys_dup+0x50>
801052d0:	e8 bb e6 ff ff       	call   80103990 <myproc>
801052d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052d8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801052dc:	85 f6                	test   %esi,%esi
801052de:	74 20                	je     80105300 <sys_dup+0x50>
  struct proc *curproc = myproc();
801052e0:	e8 ab e6 ff ff       	call   80103990 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801052e5:	31 db                	xor    %ebx,%ebx
801052e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ee:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801052f0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801052f4:	85 d2                	test   %edx,%edx
801052f6:	74 18                	je     80105310 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
801052f8:	83 c3 01             	add    $0x1,%ebx
801052fb:	83 fb 10             	cmp    $0x10,%ebx
801052fe:	75 f0                	jne    801052f0 <sys_dup+0x40>
}
80105300:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105303:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105308:	89 d8                	mov    %ebx,%eax
8010530a:	5b                   	pop    %ebx
8010530b:	5e                   	pop    %esi
8010530c:	5d                   	pop    %ebp
8010530d:	c3                   	ret    
8010530e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105310:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105313:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105317:	56                   	push   %esi
80105318:	e8 83 bb ff ff       	call   80100ea0 <filedup>
  return fd;
8010531d:	83 c4 10             	add    $0x10,%esp
}
80105320:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105323:	89 d8                	mov    %ebx,%eax
80105325:	5b                   	pop    %ebx
80105326:	5e                   	pop    %esi
80105327:	5d                   	pop    %ebp
80105328:	c3                   	ret    
80105329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105330 <sys_read>:
{
80105330:	55                   	push   %ebp
80105331:	89 e5                	mov    %esp,%ebp
80105333:	56                   	push   %esi
80105334:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105335:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105338:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010533b:	53                   	push   %ebx
8010533c:	6a 00                	push   $0x0
8010533e:	e8 1d fc ff ff       	call   80104f60 <argint>
80105343:	83 c4 10             	add    $0x10,%esp
80105346:	85 c0                	test   %eax,%eax
80105348:	78 5e                	js     801053a8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010534a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010534e:	77 58                	ja     801053a8 <sys_read+0x78>
80105350:	e8 3b e6 ff ff       	call   80103990 <myproc>
80105355:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105358:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010535c:	85 f6                	test   %esi,%esi
8010535e:	74 48                	je     801053a8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105360:	83 ec 08             	sub    $0x8,%esp
80105363:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105366:	50                   	push   %eax
80105367:	6a 02                	push   $0x2
80105369:	e8 f2 fb ff ff       	call   80104f60 <argint>
8010536e:	83 c4 10             	add    $0x10,%esp
80105371:	85 c0                	test   %eax,%eax
80105373:	78 33                	js     801053a8 <sys_read+0x78>
80105375:	83 ec 04             	sub    $0x4,%esp
80105378:	ff 75 f0             	push   -0x10(%ebp)
8010537b:	53                   	push   %ebx
8010537c:	6a 01                	push   $0x1
8010537e:	e8 2d fc ff ff       	call   80104fb0 <argptr>
80105383:	83 c4 10             	add    $0x10,%esp
80105386:	85 c0                	test   %eax,%eax
80105388:	78 1e                	js     801053a8 <sys_read+0x78>
  return fileread(f, p, n);
8010538a:	83 ec 04             	sub    $0x4,%esp
8010538d:	ff 75 f0             	push   -0x10(%ebp)
80105390:	ff 75 f4             	push   -0xc(%ebp)
80105393:	56                   	push   %esi
80105394:	e8 87 bc ff ff       	call   80101020 <fileread>
80105399:	83 c4 10             	add    $0x10,%esp
}
8010539c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010539f:	5b                   	pop    %ebx
801053a0:	5e                   	pop    %esi
801053a1:	5d                   	pop    %ebp
801053a2:	c3                   	ret    
801053a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053a7:	90                   	nop
    return -1;
801053a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053ad:	eb ed                	jmp    8010539c <sys_read+0x6c>
801053af:	90                   	nop

801053b0 <sys_write>:
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	56                   	push   %esi
801053b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801053b5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801053b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801053bb:	53                   	push   %ebx
801053bc:	6a 00                	push   $0x0
801053be:	e8 9d fb ff ff       	call   80104f60 <argint>
801053c3:	83 c4 10             	add    $0x10,%esp
801053c6:	85 c0                	test   %eax,%eax
801053c8:	78 5e                	js     80105428 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801053ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801053ce:	77 58                	ja     80105428 <sys_write+0x78>
801053d0:	e8 bb e5 ff ff       	call   80103990 <myproc>
801053d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801053d8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801053dc:	85 f6                	test   %esi,%esi
801053de:	74 48                	je     80105428 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053e0:	83 ec 08             	sub    $0x8,%esp
801053e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053e6:	50                   	push   %eax
801053e7:	6a 02                	push   $0x2
801053e9:	e8 72 fb ff ff       	call   80104f60 <argint>
801053ee:	83 c4 10             	add    $0x10,%esp
801053f1:	85 c0                	test   %eax,%eax
801053f3:	78 33                	js     80105428 <sys_write+0x78>
801053f5:	83 ec 04             	sub    $0x4,%esp
801053f8:	ff 75 f0             	push   -0x10(%ebp)
801053fb:	53                   	push   %ebx
801053fc:	6a 01                	push   $0x1
801053fe:	e8 ad fb ff ff       	call   80104fb0 <argptr>
80105403:	83 c4 10             	add    $0x10,%esp
80105406:	85 c0                	test   %eax,%eax
80105408:	78 1e                	js     80105428 <sys_write+0x78>
  return filewrite(f, p, n);
8010540a:	83 ec 04             	sub    $0x4,%esp
8010540d:	ff 75 f0             	push   -0x10(%ebp)
80105410:	ff 75 f4             	push   -0xc(%ebp)
80105413:	56                   	push   %esi
80105414:	e8 97 bc ff ff       	call   801010b0 <filewrite>
80105419:	83 c4 10             	add    $0x10,%esp
}
8010541c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010541f:	5b                   	pop    %ebx
80105420:	5e                   	pop    %esi
80105421:	5d                   	pop    %ebp
80105422:	c3                   	ret    
80105423:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105427:	90                   	nop
    return -1;
80105428:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010542d:	eb ed                	jmp    8010541c <sys_write+0x6c>
8010542f:	90                   	nop

80105430 <sys_close>:
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	56                   	push   %esi
80105434:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105435:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105438:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010543b:	50                   	push   %eax
8010543c:	6a 00                	push   $0x0
8010543e:	e8 1d fb ff ff       	call   80104f60 <argint>
80105443:	83 c4 10             	add    $0x10,%esp
80105446:	85 c0                	test   %eax,%eax
80105448:	78 3e                	js     80105488 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010544a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010544e:	77 38                	ja     80105488 <sys_close+0x58>
80105450:	e8 3b e5 ff ff       	call   80103990 <myproc>
80105455:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105458:	8d 5a 08             	lea    0x8(%edx),%ebx
8010545b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010545f:	85 f6                	test   %esi,%esi
80105461:	74 25                	je     80105488 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105463:	e8 28 e5 ff ff       	call   80103990 <myproc>
  fileclose(f);
80105468:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010546b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105472:	00 
  fileclose(f);
80105473:	56                   	push   %esi
80105474:	e8 77 ba ff ff       	call   80100ef0 <fileclose>
  return 0;
80105479:	83 c4 10             	add    $0x10,%esp
8010547c:	31 c0                	xor    %eax,%eax
}
8010547e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105481:	5b                   	pop    %ebx
80105482:	5e                   	pop    %esi
80105483:	5d                   	pop    %ebp
80105484:	c3                   	ret    
80105485:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105488:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010548d:	eb ef                	jmp    8010547e <sys_close+0x4e>
8010548f:	90                   	nop

80105490 <sys_fstat>:
{
80105490:	55                   	push   %ebp
80105491:	89 e5                	mov    %esp,%ebp
80105493:	56                   	push   %esi
80105494:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105495:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105498:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010549b:	53                   	push   %ebx
8010549c:	6a 00                	push   $0x0
8010549e:	e8 bd fa ff ff       	call   80104f60 <argint>
801054a3:	83 c4 10             	add    $0x10,%esp
801054a6:	85 c0                	test   %eax,%eax
801054a8:	78 46                	js     801054f0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801054aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801054ae:	77 40                	ja     801054f0 <sys_fstat+0x60>
801054b0:	e8 db e4 ff ff       	call   80103990 <myproc>
801054b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054b8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801054bc:	85 f6                	test   %esi,%esi
801054be:	74 30                	je     801054f0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054c0:	83 ec 04             	sub    $0x4,%esp
801054c3:	6a 14                	push   $0x14
801054c5:	53                   	push   %ebx
801054c6:	6a 01                	push   $0x1
801054c8:	e8 e3 fa ff ff       	call   80104fb0 <argptr>
801054cd:	83 c4 10             	add    $0x10,%esp
801054d0:	85 c0                	test   %eax,%eax
801054d2:	78 1c                	js     801054f0 <sys_fstat+0x60>
  return filestat(f, st);
801054d4:	83 ec 08             	sub    $0x8,%esp
801054d7:	ff 75 f4             	push   -0xc(%ebp)
801054da:	56                   	push   %esi
801054db:	e8 f0 ba ff ff       	call   80100fd0 <filestat>
801054e0:	83 c4 10             	add    $0x10,%esp
}
801054e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801054e6:	5b                   	pop    %ebx
801054e7:	5e                   	pop    %esi
801054e8:	5d                   	pop    %ebp
801054e9:	c3                   	ret    
801054ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801054f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054f5:	eb ec                	jmp    801054e3 <sys_fstat+0x53>
801054f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054fe:	66 90                	xchg   %ax,%ax

80105500 <sys_link>:
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	57                   	push   %edi
80105504:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105505:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105508:	53                   	push   %ebx
80105509:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010550c:	50                   	push   %eax
8010550d:	6a 00                	push   $0x0
8010550f:	e8 0c fb ff ff       	call   80105020 <argstr>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	85 c0                	test   %eax,%eax
80105519:	0f 88 fb 00 00 00    	js     8010561a <sys_link+0x11a>
8010551f:	83 ec 08             	sub    $0x8,%esp
80105522:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105525:	50                   	push   %eax
80105526:	6a 01                	push   $0x1
80105528:	e8 f3 fa ff ff       	call   80105020 <argstr>
8010552d:	83 c4 10             	add    $0x10,%esp
80105530:	85 c0                	test   %eax,%eax
80105532:	0f 88 e2 00 00 00    	js     8010561a <sys_link+0x11a>
  begin_op();
80105538:	e8 23 d8 ff ff       	call   80102d60 <begin_op>
  if((ip = namei(old)) == 0){
8010553d:	83 ec 0c             	sub    $0xc,%esp
80105540:	ff 75 d4             	push   -0x2c(%ebp)
80105543:	e8 58 cb ff ff       	call   801020a0 <namei>
80105548:	83 c4 10             	add    $0x10,%esp
8010554b:	89 c3                	mov    %eax,%ebx
8010554d:	85 c0                	test   %eax,%eax
8010554f:	0f 84 e4 00 00 00    	je     80105639 <sys_link+0x139>
  ilock(ip);
80105555:	83 ec 0c             	sub    $0xc,%esp
80105558:	50                   	push   %eax
80105559:	e8 22 c2 ff ff       	call   80101780 <ilock>
  if(ip->type == T_DIR){
8010555e:	83 c4 10             	add    $0x10,%esp
80105561:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105566:	0f 84 b5 00 00 00    	je     80105621 <sys_link+0x121>
  iupdate(ip);
8010556c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010556f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105574:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105577:	53                   	push   %ebx
80105578:	e8 53 c1 ff ff       	call   801016d0 <iupdate>
  iunlock(ip);
8010557d:	89 1c 24             	mov    %ebx,(%esp)
80105580:	e8 db c2 ff ff       	call   80101860 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105585:	58                   	pop    %eax
80105586:	5a                   	pop    %edx
80105587:	57                   	push   %edi
80105588:	ff 75 d0             	push   -0x30(%ebp)
8010558b:	e8 30 cb ff ff       	call   801020c0 <nameiparent>
80105590:	83 c4 10             	add    $0x10,%esp
80105593:	89 c6                	mov    %eax,%esi
80105595:	85 c0                	test   %eax,%eax
80105597:	74 5b                	je     801055f4 <sys_link+0xf4>
  ilock(dp);
80105599:	83 ec 0c             	sub    $0xc,%esp
8010559c:	50                   	push   %eax
8010559d:	e8 de c1 ff ff       	call   80101780 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801055a2:	8b 03                	mov    (%ebx),%eax
801055a4:	83 c4 10             	add    $0x10,%esp
801055a7:	39 06                	cmp    %eax,(%esi)
801055a9:	75 3d                	jne    801055e8 <sys_link+0xe8>
801055ab:	83 ec 04             	sub    $0x4,%esp
801055ae:	ff 73 04             	push   0x4(%ebx)
801055b1:	57                   	push   %edi
801055b2:	56                   	push   %esi
801055b3:	e8 28 ca ff ff       	call   80101fe0 <dirlink>
801055b8:	83 c4 10             	add    $0x10,%esp
801055bb:	85 c0                	test   %eax,%eax
801055bd:	78 29                	js     801055e8 <sys_link+0xe8>
  iunlockput(dp);
801055bf:	83 ec 0c             	sub    $0xc,%esp
801055c2:	56                   	push   %esi
801055c3:	e8 48 c4 ff ff       	call   80101a10 <iunlockput>
  iput(ip);
801055c8:	89 1c 24             	mov    %ebx,(%esp)
801055cb:	e8 e0 c2 ff ff       	call   801018b0 <iput>
  end_op();
801055d0:	e8 fb d7 ff ff       	call   80102dd0 <end_op>
  return 0;
801055d5:	83 c4 10             	add    $0x10,%esp
801055d8:	31 c0                	xor    %eax,%eax
}
801055da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055dd:	5b                   	pop    %ebx
801055de:	5e                   	pop    %esi
801055df:	5f                   	pop    %edi
801055e0:	5d                   	pop    %ebp
801055e1:	c3                   	ret    
801055e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
801055e8:	83 ec 0c             	sub    $0xc,%esp
801055eb:	56                   	push   %esi
801055ec:	e8 1f c4 ff ff       	call   80101a10 <iunlockput>
    goto bad;
801055f1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801055f4:	83 ec 0c             	sub    $0xc,%esp
801055f7:	53                   	push   %ebx
801055f8:	e8 83 c1 ff ff       	call   80101780 <ilock>
  ip->nlink--;
801055fd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105602:	89 1c 24             	mov    %ebx,(%esp)
80105605:	e8 c6 c0 ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
8010560a:	89 1c 24             	mov    %ebx,(%esp)
8010560d:	e8 fe c3 ff ff       	call   80101a10 <iunlockput>
  end_op();
80105612:	e8 b9 d7 ff ff       	call   80102dd0 <end_op>
  return -1;
80105617:	83 c4 10             	add    $0x10,%esp
8010561a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010561f:	eb b9                	jmp    801055da <sys_link+0xda>
    iunlockput(ip);
80105621:	83 ec 0c             	sub    $0xc,%esp
80105624:	53                   	push   %ebx
80105625:	e8 e6 c3 ff ff       	call   80101a10 <iunlockput>
    end_op();
8010562a:	e8 a1 d7 ff ff       	call   80102dd0 <end_op>
    return -1;
8010562f:	83 c4 10             	add    $0x10,%esp
80105632:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105637:	eb a1                	jmp    801055da <sys_link+0xda>
    end_op();
80105639:	e8 92 d7 ff ff       	call   80102dd0 <end_op>
    return -1;
8010563e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105643:	eb 95                	jmp    801055da <sys_link+0xda>
80105645:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105650 <sys_unlink>:
{
80105650:	55                   	push   %ebp
80105651:	89 e5                	mov    %esp,%ebp
80105653:	57                   	push   %edi
80105654:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105655:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105658:	53                   	push   %ebx
80105659:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010565c:	50                   	push   %eax
8010565d:	6a 00                	push   $0x0
8010565f:	e8 bc f9 ff ff       	call   80105020 <argstr>
80105664:	83 c4 10             	add    $0x10,%esp
80105667:	85 c0                	test   %eax,%eax
80105669:	0f 88 7a 01 00 00    	js     801057e9 <sys_unlink+0x199>
  begin_op();
8010566f:	e8 ec d6 ff ff       	call   80102d60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105674:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105677:	83 ec 08             	sub    $0x8,%esp
8010567a:	53                   	push   %ebx
8010567b:	ff 75 c0             	push   -0x40(%ebp)
8010567e:	e8 3d ca ff ff       	call   801020c0 <nameiparent>
80105683:	83 c4 10             	add    $0x10,%esp
80105686:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105689:	85 c0                	test   %eax,%eax
8010568b:	0f 84 62 01 00 00    	je     801057f3 <sys_unlink+0x1a3>
  ilock(dp);
80105691:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105694:	83 ec 0c             	sub    $0xc,%esp
80105697:	57                   	push   %edi
80105698:	e8 e3 c0 ff ff       	call   80101780 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010569d:	58                   	pop    %eax
8010569e:	5a                   	pop    %edx
8010569f:	68 60 80 10 80       	push   $0x80108060
801056a4:	53                   	push   %ebx
801056a5:	e8 16 c6 ff ff       	call   80101cc0 <namecmp>
801056aa:	83 c4 10             	add    $0x10,%esp
801056ad:	85 c0                	test   %eax,%eax
801056af:	0f 84 fb 00 00 00    	je     801057b0 <sys_unlink+0x160>
801056b5:	83 ec 08             	sub    $0x8,%esp
801056b8:	68 5f 80 10 80       	push   $0x8010805f
801056bd:	53                   	push   %ebx
801056be:	e8 fd c5 ff ff       	call   80101cc0 <namecmp>
801056c3:	83 c4 10             	add    $0x10,%esp
801056c6:	85 c0                	test   %eax,%eax
801056c8:	0f 84 e2 00 00 00    	je     801057b0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
801056ce:	83 ec 04             	sub    $0x4,%esp
801056d1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801056d4:	50                   	push   %eax
801056d5:	53                   	push   %ebx
801056d6:	57                   	push   %edi
801056d7:	e8 04 c6 ff ff       	call   80101ce0 <dirlookup>
801056dc:	83 c4 10             	add    $0x10,%esp
801056df:	89 c3                	mov    %eax,%ebx
801056e1:	85 c0                	test   %eax,%eax
801056e3:	0f 84 c7 00 00 00    	je     801057b0 <sys_unlink+0x160>
  ilock(ip);
801056e9:	83 ec 0c             	sub    $0xc,%esp
801056ec:	50                   	push   %eax
801056ed:	e8 8e c0 ff ff       	call   80101780 <ilock>
  if(ip->nlink < 1)
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801056fa:	0f 8e 1c 01 00 00    	jle    8010581c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105700:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105705:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105708:	74 66                	je     80105770 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010570a:	83 ec 04             	sub    $0x4,%esp
8010570d:	6a 10                	push   $0x10
8010570f:	6a 00                	push   $0x0
80105711:	57                   	push   %edi
80105712:	e8 89 f5 ff ff       	call   80104ca0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105717:	6a 10                	push   $0x10
80105719:	ff 75 c4             	push   -0x3c(%ebp)
8010571c:	57                   	push   %edi
8010571d:	ff 75 b4             	push   -0x4c(%ebp)
80105720:	e8 6b c4 ff ff       	call   80101b90 <writei>
80105725:	83 c4 20             	add    $0x20,%esp
80105728:	83 f8 10             	cmp    $0x10,%eax
8010572b:	0f 85 de 00 00 00    	jne    8010580f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105731:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105736:	0f 84 94 00 00 00    	je     801057d0 <sys_unlink+0x180>
  iunlockput(dp);
8010573c:	83 ec 0c             	sub    $0xc,%esp
8010573f:	ff 75 b4             	push   -0x4c(%ebp)
80105742:	e8 c9 c2 ff ff       	call   80101a10 <iunlockput>
  ip->nlink--;
80105747:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010574c:	89 1c 24             	mov    %ebx,(%esp)
8010574f:	e8 7c bf ff ff       	call   801016d0 <iupdate>
  iunlockput(ip);
80105754:	89 1c 24             	mov    %ebx,(%esp)
80105757:	e8 b4 c2 ff ff       	call   80101a10 <iunlockput>
  end_op();
8010575c:	e8 6f d6 ff ff       	call   80102dd0 <end_op>
  return 0;
80105761:	83 c4 10             	add    $0x10,%esp
80105764:	31 c0                	xor    %eax,%eax
}
80105766:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105769:	5b                   	pop    %ebx
8010576a:	5e                   	pop    %esi
8010576b:	5f                   	pop    %edi
8010576c:	5d                   	pop    %ebp
8010576d:	c3                   	ret    
8010576e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105770:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105774:	76 94                	jbe    8010570a <sys_unlink+0xba>
80105776:	be 20 00 00 00       	mov    $0x20,%esi
8010577b:	eb 0b                	jmp    80105788 <sys_unlink+0x138>
8010577d:	8d 76 00             	lea    0x0(%esi),%esi
80105780:	83 c6 10             	add    $0x10,%esi
80105783:	3b 73 58             	cmp    0x58(%ebx),%esi
80105786:	73 82                	jae    8010570a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105788:	6a 10                	push   $0x10
8010578a:	56                   	push   %esi
8010578b:	57                   	push   %edi
8010578c:	53                   	push   %ebx
8010578d:	e8 fe c2 ff ff       	call   80101a90 <readi>
80105792:	83 c4 10             	add    $0x10,%esp
80105795:	83 f8 10             	cmp    $0x10,%eax
80105798:	75 68                	jne    80105802 <sys_unlink+0x1b2>
    if(de.inum != 0)
8010579a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010579f:	74 df                	je     80105780 <sys_unlink+0x130>
    iunlockput(ip);
801057a1:	83 ec 0c             	sub    $0xc,%esp
801057a4:	53                   	push   %ebx
801057a5:	e8 66 c2 ff ff       	call   80101a10 <iunlockput>
    goto bad;
801057aa:	83 c4 10             	add    $0x10,%esp
801057ad:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801057b0:	83 ec 0c             	sub    $0xc,%esp
801057b3:	ff 75 b4             	push   -0x4c(%ebp)
801057b6:	e8 55 c2 ff ff       	call   80101a10 <iunlockput>
  end_op();
801057bb:	e8 10 d6 ff ff       	call   80102dd0 <end_op>
  return -1;
801057c0:	83 c4 10             	add    $0x10,%esp
801057c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057c8:	eb 9c                	jmp    80105766 <sys_unlink+0x116>
801057ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
801057d0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801057d3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
801057d6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801057db:	50                   	push   %eax
801057dc:	e8 ef be ff ff       	call   801016d0 <iupdate>
801057e1:	83 c4 10             	add    $0x10,%esp
801057e4:	e9 53 ff ff ff       	jmp    8010573c <sys_unlink+0xec>
    return -1;
801057e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ee:	e9 73 ff ff ff       	jmp    80105766 <sys_unlink+0x116>
    end_op();
801057f3:	e8 d8 d5 ff ff       	call   80102dd0 <end_op>
    return -1;
801057f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fd:	e9 64 ff ff ff       	jmp    80105766 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105802:	83 ec 0c             	sub    $0xc,%esp
80105805:	68 84 80 10 80       	push   $0x80108084
8010580a:	e8 71 ab ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010580f:	83 ec 0c             	sub    $0xc,%esp
80105812:	68 96 80 10 80       	push   $0x80108096
80105817:	e8 64 ab ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010581c:	83 ec 0c             	sub    $0xc,%esp
8010581f:	68 72 80 10 80       	push   $0x80108072
80105824:	e8 57 ab ff ff       	call   80100380 <panic>
80105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105830 <sys_open>:

int
sys_open(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	57                   	push   %edi
80105834:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105835:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105838:	53                   	push   %ebx
80105839:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010583c:	50                   	push   %eax
8010583d:	6a 00                	push   $0x0
8010583f:	e8 dc f7 ff ff       	call   80105020 <argstr>
80105844:	83 c4 10             	add    $0x10,%esp
80105847:	85 c0                	test   %eax,%eax
80105849:	0f 88 8e 00 00 00    	js     801058dd <sys_open+0xad>
8010584f:	83 ec 08             	sub    $0x8,%esp
80105852:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105855:	50                   	push   %eax
80105856:	6a 01                	push   $0x1
80105858:	e8 03 f7 ff ff       	call   80104f60 <argint>
8010585d:	83 c4 10             	add    $0x10,%esp
80105860:	85 c0                	test   %eax,%eax
80105862:	78 79                	js     801058dd <sys_open+0xad>
    return -1;

  begin_op();
80105864:	e8 f7 d4 ff ff       	call   80102d60 <begin_op>

  if(omode & O_CREATE){
80105869:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010586d:	75 79                	jne    801058e8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010586f:	83 ec 0c             	sub    $0xc,%esp
80105872:	ff 75 e0             	push   -0x20(%ebp)
80105875:	e8 26 c8 ff ff       	call   801020a0 <namei>
8010587a:	83 c4 10             	add    $0x10,%esp
8010587d:	89 c6                	mov    %eax,%esi
8010587f:	85 c0                	test   %eax,%eax
80105881:	0f 84 7e 00 00 00    	je     80105905 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105887:	83 ec 0c             	sub    $0xc,%esp
8010588a:	50                   	push   %eax
8010588b:	e8 f0 be ff ff       	call   80101780 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105890:	83 c4 10             	add    $0x10,%esp
80105893:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105898:	0f 84 c2 00 00 00    	je     80105960 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010589e:	e8 8d b5 ff ff       	call   80100e30 <filealloc>
801058a3:	89 c7                	mov    %eax,%edi
801058a5:	85 c0                	test   %eax,%eax
801058a7:	74 23                	je     801058cc <sys_open+0x9c>
  struct proc *curproc = myproc();
801058a9:	e8 e2 e0 ff ff       	call   80103990 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801058ae:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801058b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801058b4:	85 d2                	test   %edx,%edx
801058b6:	74 60                	je     80105918 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
801058b8:	83 c3 01             	add    $0x1,%ebx
801058bb:	83 fb 10             	cmp    $0x10,%ebx
801058be:	75 f0                	jne    801058b0 <sys_open+0x80>
    if(f)
      fileclose(f);
801058c0:	83 ec 0c             	sub    $0xc,%esp
801058c3:	57                   	push   %edi
801058c4:	e8 27 b6 ff ff       	call   80100ef0 <fileclose>
801058c9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801058cc:	83 ec 0c             	sub    $0xc,%esp
801058cf:	56                   	push   %esi
801058d0:	e8 3b c1 ff ff       	call   80101a10 <iunlockput>
    end_op();
801058d5:	e8 f6 d4 ff ff       	call   80102dd0 <end_op>
    return -1;
801058da:	83 c4 10             	add    $0x10,%esp
801058dd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801058e2:	eb 6d                	jmp    80105951 <sys_open+0x121>
801058e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801058e8:	83 ec 0c             	sub    $0xc,%esp
801058eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801058ee:	31 c9                	xor    %ecx,%ecx
801058f0:	ba 02 00 00 00       	mov    $0x2,%edx
801058f5:	6a 00                	push   $0x0
801058f7:	e8 14 f8 ff ff       	call   80105110 <create>
    if(ip == 0){
801058fc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801058ff:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105901:	85 c0                	test   %eax,%eax
80105903:	75 99                	jne    8010589e <sys_open+0x6e>
      end_op();
80105905:	e8 c6 d4 ff ff       	call   80102dd0 <end_op>
      return -1;
8010590a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010590f:	eb 40                	jmp    80105951 <sys_open+0x121>
80105911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105918:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010591b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010591f:	56                   	push   %esi
80105920:	e8 3b bf ff ff       	call   80101860 <iunlock>
  end_op();
80105925:	e8 a6 d4 ff ff       	call   80102dd0 <end_op>

  f->type = FD_INODE;
8010592a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105930:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105933:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105936:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105939:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010593b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105942:	f7 d0                	not    %eax
80105944:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105947:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010594a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010594d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105951:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105954:	89 d8                	mov    %ebx,%eax
80105956:	5b                   	pop    %ebx
80105957:	5e                   	pop    %esi
80105958:	5f                   	pop    %edi
80105959:	5d                   	pop    %ebp
8010595a:	c3                   	ret    
8010595b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010595f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105960:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105963:	85 c9                	test   %ecx,%ecx
80105965:	0f 84 33 ff ff ff    	je     8010589e <sys_open+0x6e>
8010596b:	e9 5c ff ff ff       	jmp    801058cc <sys_open+0x9c>

80105970 <sys_mkdir>:

int
sys_mkdir(void)
{
80105970:	55                   	push   %ebp
80105971:	89 e5                	mov    %esp,%ebp
80105973:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105976:	e8 e5 d3 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010597b:	83 ec 08             	sub    $0x8,%esp
8010597e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105981:	50                   	push   %eax
80105982:	6a 00                	push   $0x0
80105984:	e8 97 f6 ff ff       	call   80105020 <argstr>
80105989:	83 c4 10             	add    $0x10,%esp
8010598c:	85 c0                	test   %eax,%eax
8010598e:	78 30                	js     801059c0 <sys_mkdir+0x50>
80105990:	83 ec 0c             	sub    $0xc,%esp
80105993:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105996:	31 c9                	xor    %ecx,%ecx
80105998:	ba 01 00 00 00       	mov    $0x1,%edx
8010599d:	6a 00                	push   $0x0
8010599f:	e8 6c f7 ff ff       	call   80105110 <create>
801059a4:	83 c4 10             	add    $0x10,%esp
801059a7:	85 c0                	test   %eax,%eax
801059a9:	74 15                	je     801059c0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801059ab:	83 ec 0c             	sub    $0xc,%esp
801059ae:	50                   	push   %eax
801059af:	e8 5c c0 ff ff       	call   80101a10 <iunlockput>
  end_op();
801059b4:	e8 17 d4 ff ff       	call   80102dd0 <end_op>
  return 0;
801059b9:	83 c4 10             	add    $0x10,%esp
801059bc:	31 c0                	xor    %eax,%eax
}
801059be:	c9                   	leave  
801059bf:	c3                   	ret    
    end_op();
801059c0:	e8 0b d4 ff ff       	call   80102dd0 <end_op>
    return -1;
801059c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059ca:	c9                   	leave  
801059cb:	c3                   	ret    
801059cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059d0 <sys_mknod>:

int
sys_mknod(void)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801059d6:	e8 85 d3 ff ff       	call   80102d60 <begin_op>
  if((argstr(0, &path)) < 0 ||
801059db:	83 ec 08             	sub    $0x8,%esp
801059de:	8d 45 ec             	lea    -0x14(%ebp),%eax
801059e1:	50                   	push   %eax
801059e2:	6a 00                	push   $0x0
801059e4:	e8 37 f6 ff ff       	call   80105020 <argstr>
801059e9:	83 c4 10             	add    $0x10,%esp
801059ec:	85 c0                	test   %eax,%eax
801059ee:	78 60                	js     80105a50 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801059f0:	83 ec 08             	sub    $0x8,%esp
801059f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801059f6:	50                   	push   %eax
801059f7:	6a 01                	push   $0x1
801059f9:	e8 62 f5 ff ff       	call   80104f60 <argint>
  if((argstr(0, &path)) < 0 ||
801059fe:	83 c4 10             	add    $0x10,%esp
80105a01:	85 c0                	test   %eax,%eax
80105a03:	78 4b                	js     80105a50 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105a05:	83 ec 08             	sub    $0x8,%esp
80105a08:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a0b:	50                   	push   %eax
80105a0c:	6a 02                	push   $0x2
80105a0e:	e8 4d f5 ff ff       	call   80104f60 <argint>
     argint(1, &major) < 0 ||
80105a13:	83 c4 10             	add    $0x10,%esp
80105a16:	85 c0                	test   %eax,%eax
80105a18:	78 36                	js     80105a50 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105a1a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105a1e:	83 ec 0c             	sub    $0xc,%esp
80105a21:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105a25:	ba 03 00 00 00       	mov    $0x3,%edx
80105a2a:	50                   	push   %eax
80105a2b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105a2e:	e8 dd f6 ff ff       	call   80105110 <create>
     argint(2, &minor) < 0 ||
80105a33:	83 c4 10             	add    $0x10,%esp
80105a36:	85 c0                	test   %eax,%eax
80105a38:	74 16                	je     80105a50 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105a3a:	83 ec 0c             	sub    $0xc,%esp
80105a3d:	50                   	push   %eax
80105a3e:	e8 cd bf ff ff       	call   80101a10 <iunlockput>
  end_op();
80105a43:	e8 88 d3 ff ff       	call   80102dd0 <end_op>
  return 0;
80105a48:	83 c4 10             	add    $0x10,%esp
80105a4b:	31 c0                	xor    %eax,%eax
}
80105a4d:	c9                   	leave  
80105a4e:	c3                   	ret    
80105a4f:	90                   	nop
    end_op();
80105a50:	e8 7b d3 ff ff       	call   80102dd0 <end_op>
    return -1;
80105a55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a5a:	c9                   	leave  
80105a5b:	c3                   	ret    
80105a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105a60 <sys_chdir>:

int
sys_chdir(void)
{
80105a60:	55                   	push   %ebp
80105a61:	89 e5                	mov    %esp,%ebp
80105a63:	56                   	push   %esi
80105a64:	53                   	push   %ebx
80105a65:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105a68:	e8 23 df ff ff       	call   80103990 <myproc>
80105a6d:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105a6f:	e8 ec d2 ff ff       	call   80102d60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105a74:	83 ec 08             	sub    $0x8,%esp
80105a77:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a7a:	50                   	push   %eax
80105a7b:	6a 00                	push   $0x0
80105a7d:	e8 9e f5 ff ff       	call   80105020 <argstr>
80105a82:	83 c4 10             	add    $0x10,%esp
80105a85:	85 c0                	test   %eax,%eax
80105a87:	78 77                	js     80105b00 <sys_chdir+0xa0>
80105a89:	83 ec 0c             	sub    $0xc,%esp
80105a8c:	ff 75 f4             	push   -0xc(%ebp)
80105a8f:	e8 0c c6 ff ff       	call   801020a0 <namei>
80105a94:	83 c4 10             	add    $0x10,%esp
80105a97:	89 c3                	mov    %eax,%ebx
80105a99:	85 c0                	test   %eax,%eax
80105a9b:	74 63                	je     80105b00 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105a9d:	83 ec 0c             	sub    $0xc,%esp
80105aa0:	50                   	push   %eax
80105aa1:	e8 da bc ff ff       	call   80101780 <ilock>
  if(ip->type != T_DIR){
80105aa6:	83 c4 10             	add    $0x10,%esp
80105aa9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105aae:	75 30                	jne    80105ae0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105ab0:	83 ec 0c             	sub    $0xc,%esp
80105ab3:	53                   	push   %ebx
80105ab4:	e8 a7 bd ff ff       	call   80101860 <iunlock>
  iput(curproc->cwd);
80105ab9:	58                   	pop    %eax
80105aba:	ff 76 68             	push   0x68(%esi)
80105abd:	e8 ee bd ff ff       	call   801018b0 <iput>
  end_op();
80105ac2:	e8 09 d3 ff ff       	call   80102dd0 <end_op>
  curproc->cwd = ip;
80105ac7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105aca:	83 c4 10             	add    $0x10,%esp
80105acd:	31 c0                	xor    %eax,%eax
}
80105acf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ad2:	5b                   	pop    %ebx
80105ad3:	5e                   	pop    %esi
80105ad4:	5d                   	pop    %ebp
80105ad5:	c3                   	ret    
80105ad6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105add:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105ae0:	83 ec 0c             	sub    $0xc,%esp
80105ae3:	53                   	push   %ebx
80105ae4:	e8 27 bf ff ff       	call   80101a10 <iunlockput>
    end_op();
80105ae9:	e8 e2 d2 ff ff       	call   80102dd0 <end_op>
    return -1;
80105aee:	83 c4 10             	add    $0x10,%esp
80105af1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105af6:	eb d7                	jmp    80105acf <sys_chdir+0x6f>
80105af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aff:	90                   	nop
    end_op();
80105b00:	e8 cb d2 ff ff       	call   80102dd0 <end_op>
    return -1;
80105b05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b0a:	eb c3                	jmp    80105acf <sys_chdir+0x6f>
80105b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b10 <sys_exec>:

int
sys_exec(void)
{
80105b10:	55                   	push   %ebp
80105b11:	89 e5                	mov    %esp,%ebp
80105b13:	57                   	push   %edi
80105b14:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b15:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105b1b:	53                   	push   %ebx
80105b1c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105b22:	50                   	push   %eax
80105b23:	6a 00                	push   $0x0
80105b25:	e8 f6 f4 ff ff       	call   80105020 <argstr>
80105b2a:	83 c4 10             	add    $0x10,%esp
80105b2d:	85 c0                	test   %eax,%eax
80105b2f:	0f 88 87 00 00 00    	js     80105bbc <sys_exec+0xac>
80105b35:	83 ec 08             	sub    $0x8,%esp
80105b38:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b3e:	50                   	push   %eax
80105b3f:	6a 01                	push   $0x1
80105b41:	e8 1a f4 ff ff       	call   80104f60 <argint>
80105b46:	83 c4 10             	add    $0x10,%esp
80105b49:	85 c0                	test   %eax,%eax
80105b4b:	78 6f                	js     80105bbc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105b4d:	83 ec 04             	sub    $0x4,%esp
80105b50:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105b56:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105b58:	68 80 00 00 00       	push   $0x80
80105b5d:	6a 00                	push   $0x0
80105b5f:	56                   	push   %esi
80105b60:	e8 3b f1 ff ff       	call   80104ca0 <memset>
80105b65:	83 c4 10             	add    $0x10,%esp
80105b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b6f:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105b70:	83 ec 08             	sub    $0x8,%esp
80105b73:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105b79:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105b80:	50                   	push   %eax
80105b81:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105b87:	01 f8                	add    %edi,%eax
80105b89:	50                   	push   %eax
80105b8a:	e8 41 f3 ff ff       	call   80104ed0 <fetchint>
80105b8f:	83 c4 10             	add    $0x10,%esp
80105b92:	85 c0                	test   %eax,%eax
80105b94:	78 26                	js     80105bbc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105b96:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105b9c:	85 c0                	test   %eax,%eax
80105b9e:	74 30                	je     80105bd0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105ba0:	83 ec 08             	sub    $0x8,%esp
80105ba3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105ba6:	52                   	push   %edx
80105ba7:	50                   	push   %eax
80105ba8:	e8 63 f3 ff ff       	call   80104f10 <fetchstr>
80105bad:	83 c4 10             	add    $0x10,%esp
80105bb0:	85 c0                	test   %eax,%eax
80105bb2:	78 08                	js     80105bbc <sys_exec+0xac>
  for(i=0;; i++){
80105bb4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105bb7:	83 fb 20             	cmp    $0x20,%ebx
80105bba:	75 b4                	jne    80105b70 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
80105bbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105bbf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105bc4:	5b                   	pop    %ebx
80105bc5:	5e                   	pop    %esi
80105bc6:	5f                   	pop    %edi
80105bc7:	5d                   	pop    %ebp
80105bc8:	c3                   	ret    
80105bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105bd0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105bd7:	00 00 00 00 
  return exec(path, argv);
80105bdb:	83 ec 08             	sub    $0x8,%esp
80105bde:	56                   	push   %esi
80105bdf:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105be5:	e8 c6 ae ff ff       	call   80100ab0 <exec>
80105bea:	83 c4 10             	add    $0x10,%esp
}
80105bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bf0:	5b                   	pop    %ebx
80105bf1:	5e                   	pop    %esi
80105bf2:	5f                   	pop    %edi
80105bf3:	5d                   	pop    %ebp
80105bf4:	c3                   	ret    
80105bf5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c00 <sys_pipe>:

int
sys_pipe(void)
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	57                   	push   %edi
80105c04:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c05:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105c08:	53                   	push   %ebx
80105c09:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105c0c:	6a 08                	push   $0x8
80105c0e:	50                   	push   %eax
80105c0f:	6a 00                	push   $0x0
80105c11:	e8 9a f3 ff ff       	call   80104fb0 <argptr>
80105c16:	83 c4 10             	add    $0x10,%esp
80105c19:	85 c0                	test   %eax,%eax
80105c1b:	78 4a                	js     80105c67 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105c1d:	83 ec 08             	sub    $0x8,%esp
80105c20:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c23:	50                   	push   %eax
80105c24:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c27:	50                   	push   %eax
80105c28:	e8 03 d8 ff ff       	call   80103430 <pipealloc>
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	85 c0                	test   %eax,%eax
80105c32:	78 33                	js     80105c67 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c34:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105c37:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105c39:	e8 52 dd ff ff       	call   80103990 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105c3e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105c40:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105c44:	85 f6                	test   %esi,%esi
80105c46:	74 28                	je     80105c70 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80105c48:	83 c3 01             	add    $0x1,%ebx
80105c4b:	83 fb 10             	cmp    $0x10,%ebx
80105c4e:	75 f0                	jne    80105c40 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105c50:	83 ec 0c             	sub    $0xc,%esp
80105c53:	ff 75 e0             	push   -0x20(%ebp)
80105c56:	e8 95 b2 ff ff       	call   80100ef0 <fileclose>
    fileclose(wf);
80105c5b:	58                   	pop    %eax
80105c5c:	ff 75 e4             	push   -0x1c(%ebp)
80105c5f:	e8 8c b2 ff ff       	call   80100ef0 <fileclose>
    return -1;
80105c64:	83 c4 10             	add    $0x10,%esp
80105c67:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c6c:	eb 53                	jmp    80105cc1 <sys_pipe+0xc1>
80105c6e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105c70:	8d 73 08             	lea    0x8(%ebx),%esi
80105c73:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105c77:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105c7a:	e8 11 dd ff ff       	call   80103990 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105c7f:	31 d2                	xor    %edx,%edx
80105c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105c88:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105c8c:	85 c9                	test   %ecx,%ecx
80105c8e:	74 20                	je     80105cb0 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80105c90:	83 c2 01             	add    $0x1,%edx
80105c93:	83 fa 10             	cmp    $0x10,%edx
80105c96:	75 f0                	jne    80105c88 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80105c98:	e8 f3 dc ff ff       	call   80103990 <myproc>
80105c9d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105ca4:	00 
80105ca5:	eb a9                	jmp    80105c50 <sys_pipe+0x50>
80105ca7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cae:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105cb0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105cb4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cb7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105cb9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cbc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105cbf:	31 c0                	xor    %eax,%eax
}
80105cc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105cc4:	5b                   	pop    %ebx
80105cc5:	5e                   	pop    %esi
80105cc6:	5f                   	pop    %edi
80105cc7:	5d                   	pop    %ebp
80105cc8:	c3                   	ret    
80105cc9:	66 90                	xchg   %ax,%ax
80105ccb:	66 90                	xchg   %ax,%ax
80105ccd:	66 90                	xchg   %ax,%ax
80105ccf:	90                   	nop

80105cd0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105cd0:	e9 cb de ff ff       	jmp    80103ba0 <fork>
80105cd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ce0 <sys_exit>:
}

int
sys_exit(void)
{
80105ce0:	55                   	push   %ebp
80105ce1:	89 e5                	mov    %esp,%ebp
80105ce3:	83 ec 08             	sub    $0x8,%esp
  exit();
80105ce6:	e8 c5 ea ff ff       	call   801047b0 <exit>
  return 0;  // not reached
}
80105ceb:	31 c0                	xor    %eax,%eax
80105ced:	c9                   	leave  
80105cee:	c3                   	ret    
80105cef:	90                   	nop

80105cf0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105cf0:	e9 4b e1 ff ff       	jmp    80103e40 <wait>
80105cf5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105d00 <sys_kill>:
}

int
sys_kill(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105d06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d09:	50                   	push   %eax
80105d0a:	6a 00                	push   $0x0
80105d0c:	e8 4f f2 ff ff       	call   80104f60 <argint>
80105d11:	83 c4 10             	add    $0x10,%esp
80105d14:	85 c0                	test   %eax,%eax
80105d16:	78 18                	js     80105d30 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105d18:	83 ec 0c             	sub    $0xc,%esp
80105d1b:	ff 75 f4             	push   -0xc(%ebp)
80105d1e:	e8 bd e3 ff ff       	call   801040e0 <kill>
80105d23:	83 c4 10             	add    $0x10,%esp
}
80105d26:	c9                   	leave  
80105d27:	c3                   	ret    
80105d28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d2f:	90                   	nop
80105d30:	c9                   	leave  
    return -1;
80105d31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d36:	c3                   	ret    
80105d37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d3e:	66 90                	xchg   %ax,%ax

80105d40 <sys_getpid>:

int
sys_getpid(void)
{
80105d40:	55                   	push   %ebp
80105d41:	89 e5                	mov    %esp,%ebp
80105d43:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105d46:	e8 45 dc ff ff       	call   80103990 <myproc>
80105d4b:	8b 40 10             	mov    0x10(%eax),%eax
}
80105d4e:	c9                   	leave  
80105d4f:	c3                   	ret    

80105d50 <sys_sbrk>:

int
sys_sbrk(void)
{
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105d54:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105d57:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105d5a:	50                   	push   %eax
80105d5b:	6a 00                	push   $0x0
80105d5d:	e8 fe f1 ff ff       	call   80104f60 <argint>
80105d62:	83 c4 10             	add    $0x10,%esp
80105d65:	85 c0                	test   %eax,%eax
80105d67:	78 27                	js     80105d90 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105d69:	e8 22 dc ff ff       	call   80103990 <myproc>
  if(growproc(n) < 0)
80105d6e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105d71:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105d73:	ff 75 f4             	push   -0xc(%ebp)
80105d76:	e8 55 dd ff ff       	call   80103ad0 <growproc>
80105d7b:	83 c4 10             	add    $0x10,%esp
80105d7e:	85 c0                	test   %eax,%eax
80105d80:	78 0e                	js     80105d90 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105d82:	89 d8                	mov    %ebx,%eax
80105d84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d87:	c9                   	leave  
80105d88:	c3                   	ret    
80105d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105d90:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105d95:	eb eb                	jmp    80105d82 <sys_sbrk+0x32>
80105d97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d9e:	66 90                	xchg   %ax,%ax

80105da0 <sys_sleep>:

int
sys_sleep(void)
{
80105da0:	55                   	push   %ebp
80105da1:	89 e5                	mov    %esp,%ebp
80105da3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105da4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105da7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105daa:	50                   	push   %eax
80105dab:	6a 00                	push   $0x0
80105dad:	e8 ae f1 ff ff       	call   80104f60 <argint>
80105db2:	83 c4 10             	add    $0x10,%esp
80105db5:	85 c0                	test   %eax,%eax
80105db7:	0f 88 8a 00 00 00    	js     80105e47 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105dbd:	83 ec 0c             	sub    $0xc,%esp
80105dc0:	68 80 50 11 80       	push   $0x80115080
80105dc5:	e8 16 ee ff ff       	call   80104be0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105dca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105dcd:	8b 1d 60 50 11 80    	mov    0x80115060,%ebx
  while(ticks - ticks0 < n){
80105dd3:	83 c4 10             	add    $0x10,%esp
80105dd6:	85 d2                	test   %edx,%edx
80105dd8:	75 27                	jne    80105e01 <sys_sleep+0x61>
80105dda:	eb 54                	jmp    80105e30 <sys_sleep+0x90>
80105ddc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105de0:	83 ec 08             	sub    $0x8,%esp
80105de3:	68 80 50 11 80       	push   $0x80115080
80105de8:	68 60 50 11 80       	push   $0x80115060
80105ded:	e8 ce e1 ff ff       	call   80103fc0 <sleep>
  while(ticks - ticks0 < n){
80105df2:	a1 60 50 11 80       	mov    0x80115060,%eax
80105df7:	83 c4 10             	add    $0x10,%esp
80105dfa:	29 d8                	sub    %ebx,%eax
80105dfc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105dff:	73 2f                	jae    80105e30 <sys_sleep+0x90>
    if(myproc()->killed){
80105e01:	e8 8a db ff ff       	call   80103990 <myproc>
80105e06:	8b 40 24             	mov    0x24(%eax),%eax
80105e09:	85 c0                	test   %eax,%eax
80105e0b:	74 d3                	je     80105de0 <sys_sleep+0x40>
      release(&tickslock);
80105e0d:	83 ec 0c             	sub    $0xc,%esp
80105e10:	68 80 50 11 80       	push   $0x80115080
80105e15:	e8 66 ed ff ff       	call   80104b80 <release>
  }
  release(&tickslock);
  return 0;
}
80105e1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
80105e1d:	83 c4 10             	add    $0x10,%esp
80105e20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e25:	c9                   	leave  
80105e26:	c3                   	ret    
80105e27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80105e30:	83 ec 0c             	sub    $0xc,%esp
80105e33:	68 80 50 11 80       	push   $0x80115080
80105e38:	e8 43 ed ff ff       	call   80104b80 <release>
  return 0;
80105e3d:	83 c4 10             	add    $0x10,%esp
80105e40:	31 c0                	xor    %eax,%eax
}
80105e42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e45:	c9                   	leave  
80105e46:	c3                   	ret    
    return -1;
80105e47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e4c:	eb f4                	jmp    80105e42 <sys_sleep+0xa2>
80105e4e:	66 90                	xchg   %ax,%ax

80105e50 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	53                   	push   %ebx
80105e54:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105e57:	68 80 50 11 80       	push   $0x80115080
80105e5c:	e8 7f ed ff ff       	call   80104be0 <acquire>
  xticks = ticks;
80105e61:	8b 1d 60 50 11 80    	mov    0x80115060,%ebx
  release(&tickslock);
80105e67:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
80105e6e:	e8 0d ed ff ff       	call   80104b80 <release>
  return xticks;
}
80105e73:	89 d8                	mov    %ebx,%eax
80105e75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105e78:	c9                   	leave  
80105e79:	c3                   	ret    
80105e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e80 <sys_thread_create>:

int 
sys_thread_create(void)
{
80105e80:	55                   	push   %ebp
80105e81:	89 e5                	mov    %esp,%ebp
80105e83:	83 ec 1c             	sub    $0x1c,%esp
	thread_t *thread;
	void *(*start_routine)(void *);
	void *arg;

	if(argptr(0, (char**)&thread, sizeof(thread)) < 0 || argptr(1, (char**)&start_routine, sizeof(start_routine)) < 0 || argptr(2, (char**)&arg, sizeof(arg)) < 0)
80105e86:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e89:	6a 04                	push   $0x4
80105e8b:	50                   	push   %eax
80105e8c:	6a 00                	push   $0x0
80105e8e:	e8 1d f1 ff ff       	call   80104fb0 <argptr>
80105e93:	83 c4 10             	add    $0x10,%esp
80105e96:	85 c0                	test   %eax,%eax
80105e98:	78 46                	js     80105ee0 <sys_thread_create+0x60>
80105e9a:	83 ec 04             	sub    $0x4,%esp
80105e9d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105ea0:	6a 04                	push   $0x4
80105ea2:	50                   	push   %eax
80105ea3:	6a 01                	push   $0x1
80105ea5:	e8 06 f1 ff ff       	call   80104fb0 <argptr>
80105eaa:	83 c4 10             	add    $0x10,%esp
80105ead:	85 c0                	test   %eax,%eax
80105eaf:	78 2f                	js     80105ee0 <sys_thread_create+0x60>
80105eb1:	83 ec 04             	sub    $0x4,%esp
80105eb4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105eb7:	6a 04                	push   $0x4
80105eb9:	50                   	push   %eax
80105eba:	6a 02                	push   $0x2
80105ebc:	e8 ef f0 ff ff       	call   80104fb0 <argptr>
80105ec1:	83 c4 10             	add    $0x10,%esp
80105ec4:	85 c0                	test   %eax,%eax
80105ec6:	78 18                	js     80105ee0 <sys_thread_create+0x60>
		return -1;
	return thread_create(thread, start_routine, arg);
80105ec8:	83 ec 04             	sub    $0x4,%esp
80105ecb:	ff 75 f4             	push   -0xc(%ebp)
80105ece:	ff 75 f0             	push   -0x10(%ebp)
80105ed1:	ff 75 ec             	push   -0x14(%ebp)
80105ed4:	e8 47 e3 ff ff       	call   80104220 <thread_create>
80105ed9:	83 c4 10             	add    $0x10,%esp
}
80105edc:	c9                   	leave  
80105edd:	c3                   	ret    
80105ede:	66 90                	xchg   %ax,%ax
80105ee0:	c9                   	leave  
		return -1;
80105ee1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ee6:	c3                   	ret    
80105ee7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eee:	66 90                	xchg   %ax,%ax

80105ef0 <sys_thread_exit>:

int 
sys_thread_exit(void)
{
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	83 ec 1c             	sub    $0x1c,%esp
	void *retval;

	if(argptr(0, (char**)&retval, sizeof(retval)) <0)
80105ef6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ef9:	6a 04                	push   $0x4
80105efb:	50                   	push   %eax
80105efc:	6a 00                	push   $0x0
80105efe:	e8 ad f0 ff ff       	call   80104fb0 <argptr>
80105f03:	83 c4 10             	add    $0x10,%esp
80105f06:	85 c0                	test   %eax,%eax
80105f08:	78 16                	js     80105f20 <sys_thread_exit+0x30>
		return -1;
	thread_exit(retval);
80105f0a:	83 ec 0c             	sub    $0xc,%esp
80105f0d:	ff 75 f4             	push   -0xc(%ebp)
80105f10:	e8 2b e7 ff ff       	call   80104640 <thread_exit>
	return 0;
80105f15:	83 c4 10             	add    $0x10,%esp
80105f18:	31 c0                	xor    %eax,%eax
}
80105f1a:	c9                   	leave  
80105f1b:	c3                   	ret    
80105f1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f20:	c9                   	leave  
		return -1;
80105f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f26:	c3                   	ret    
80105f27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f2e:	66 90                	xchg   %ax,%ax

80105f30 <sys_thread_join>:

int
sys_thread_join(void)
{
80105f30:	55                   	push   %ebp
80105f31:	89 e5                	mov    %esp,%ebp
80105f33:	83 ec 20             	sub    $0x20,%esp
	thread_t thread;
	void **retval;

	if(argint(0, (int*)&thread) < 0 || argptr(1, (char**)&retval, sizeof(retval)) < 0)
80105f36:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f39:	50                   	push   %eax
80105f3a:	6a 00                	push   $0x0
80105f3c:	e8 1f f0 ff ff       	call   80104f60 <argint>
80105f41:	83 c4 10             	add    $0x10,%esp
80105f44:	85 c0                	test   %eax,%eax
80105f46:	78 30                	js     80105f78 <sys_thread_join+0x48>
80105f48:	83 ec 04             	sub    $0x4,%esp
80105f4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f4e:	6a 04                	push   $0x4
80105f50:	50                   	push   %eax
80105f51:	6a 01                	push   $0x1
80105f53:	e8 58 f0 ff ff       	call   80104fb0 <argptr>
80105f58:	83 c4 10             	add    $0x10,%esp
80105f5b:	85 c0                	test   %eax,%eax
80105f5d:	78 19                	js     80105f78 <sys_thread_join+0x48>
		return -1;
	return thread_join(thread, retval);
80105f5f:	83 ec 08             	sub    $0x8,%esp
80105f62:	ff 75 f4             	push   -0xc(%ebp)
80105f65:	ff 75 f0             	push   -0x10(%ebp)
80105f68:	e8 63 e4 ff ff       	call   801043d0 <thread_join>
80105f6d:	83 c4 10             	add    $0x10,%esp
}
80105f70:	c9                   	leave  
80105f71:	c3                   	ret    
80105f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f78:	c9                   	leave  
		return -1;
80105f79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f7e:	c3                   	ret    

80105f7f <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105f7f:	1e                   	push   %ds
  pushl %es
80105f80:	06                   	push   %es
  pushl %fs
80105f81:	0f a0                	push   %fs
  pushl %gs
80105f83:	0f a8                	push   %gs
  pushal
80105f85:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105f86:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105f8a:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105f8c:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105f8e:	54                   	push   %esp
  call trap
80105f8f:	e8 cc 00 00 00       	call   80106060 <trap>
  addl $4, %esp
80105f94:	83 c4 04             	add    $0x4,%esp

80105f97 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105f97:	61                   	popa   
  popl %gs
80105f98:	0f a9                	pop    %gs
  popl %fs
80105f9a:	0f a1                	pop    %fs
  popl %es
80105f9c:	07                   	pop    %es
  popl %ds
80105f9d:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105f9e:	83 c4 08             	add    $0x8,%esp
  iret
80105fa1:	cf                   	iret   
80105fa2:	66 90                	xchg   %ax,%ax
80105fa4:	66 90                	xchg   %ax,%ax
80105fa6:	66 90                	xchg   %ax,%ax
80105fa8:	66 90                	xchg   %ax,%ax
80105faa:	66 90                	xchg   %ax,%ax
80105fac:	66 90                	xchg   %ax,%ax
80105fae:	66 90                	xchg   %ax,%ax

80105fb0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105fb0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105fb1:	31 c0                	xor    %eax,%eax
{
80105fb3:	89 e5                	mov    %esp,%ebp
80105fb5:	83 ec 08             	sub    $0x8,%esp
80105fb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fbf:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105fc0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80105fc7:	c7 04 c5 c2 50 11 80 	movl   $0x8e000008,-0x7feeaf3e(,%eax,8)
80105fce:	08 00 00 8e 
80105fd2:	66 89 14 c5 c0 50 11 	mov    %dx,-0x7feeaf40(,%eax,8)
80105fd9:	80 
80105fda:	c1 ea 10             	shr    $0x10,%edx
80105fdd:	66 89 14 c5 c6 50 11 	mov    %dx,-0x7feeaf3a(,%eax,8)
80105fe4:	80 
  for(i = 0; i < 256; i++)
80105fe5:	83 c0 01             	add    $0x1,%eax
80105fe8:	3d 00 01 00 00       	cmp    $0x100,%eax
80105fed:	75 d1                	jne    80105fc0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105fef:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ff2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80105ff7:	c7 05 c2 52 11 80 08 	movl   $0xef000008,0x801152c2
80105ffe:	00 00 ef 
  initlock(&tickslock, "time");
80106001:	68 a5 80 10 80       	push   $0x801080a5
80106006:	68 80 50 11 80       	push   $0x80115080
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010600b:	66 a3 c0 52 11 80    	mov    %ax,0x801152c0
80106011:	c1 e8 10             	shr    $0x10,%eax
80106014:	66 a3 c6 52 11 80    	mov    %ax,0x801152c6
  initlock(&tickslock, "time");
8010601a:	e8 f1 e9 ff ff       	call   80104a10 <initlock>
}
8010601f:	83 c4 10             	add    $0x10,%esp
80106022:	c9                   	leave  
80106023:	c3                   	ret    
80106024:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010602b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010602f:	90                   	nop

80106030 <idtinit>:

void
idtinit(void)
{
80106030:	55                   	push   %ebp
  pd[0] = size-1;
80106031:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106036:	89 e5                	mov    %esp,%ebp
80106038:	83 ec 10             	sub    $0x10,%esp
8010603b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010603f:	b8 c0 50 11 80       	mov    $0x801150c0,%eax
80106044:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106048:	c1 e8 10             	shr    $0x10,%eax
8010604b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010604f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106052:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106055:	c9                   	leave  
80106056:	c3                   	ret    
80106057:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010605e:	66 90                	xchg   %ax,%ax

80106060 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106060:	55                   	push   %ebp
80106061:	89 e5                	mov    %esp,%ebp
80106063:	57                   	push   %edi
80106064:	56                   	push   %esi
80106065:	53                   	push   %ebx
80106066:	83 ec 1c             	sub    $0x1c,%esp
80106069:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010606c:	8b 43 30             	mov    0x30(%ebx),%eax
8010606f:	83 f8 40             	cmp    $0x40,%eax
80106072:	0f 84 68 01 00 00    	je     801061e0 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106078:	83 e8 20             	sub    $0x20,%eax
8010607b:	83 f8 1f             	cmp    $0x1f,%eax
8010607e:	0f 87 8c 00 00 00    	ja     80106110 <trap+0xb0>
80106084:	ff 24 85 4c 81 10 80 	jmp    *-0x7fef7eb4(,%eax,4)
8010608b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010608f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106090:	e8 ab c1 ff ff       	call   80102240 <ideintr>
    lapiceoi();
80106095:	e8 76 c8 ff ff       	call   80102910 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010609a:	e8 f1 d8 ff ff       	call   80103990 <myproc>
8010609f:	85 c0                	test   %eax,%eax
801060a1:	74 1d                	je     801060c0 <trap+0x60>
801060a3:	e8 e8 d8 ff ff       	call   80103990 <myproc>
801060a8:	8b 50 24             	mov    0x24(%eax),%edx
801060ab:	85 d2                	test   %edx,%edx
801060ad:	74 11                	je     801060c0 <trap+0x60>
801060af:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801060b3:	83 e0 03             	and    $0x3,%eax
801060b6:	66 83 f8 03          	cmp    $0x3,%ax
801060ba:	0f 84 e8 01 00 00    	je     801062a8 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801060c0:	e8 cb d8 ff ff       	call   80103990 <myproc>
801060c5:	85 c0                	test   %eax,%eax
801060c7:	74 0f                	je     801060d8 <trap+0x78>
801060c9:	e8 c2 d8 ff ff       	call   80103990 <myproc>
801060ce:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801060d2:	0f 84 b8 00 00 00    	je     80106190 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801060d8:	e8 b3 d8 ff ff       	call   80103990 <myproc>
801060dd:	85 c0                	test   %eax,%eax
801060df:	74 1d                	je     801060fe <trap+0x9e>
801060e1:	e8 aa d8 ff ff       	call   80103990 <myproc>
801060e6:	8b 40 24             	mov    0x24(%eax),%eax
801060e9:	85 c0                	test   %eax,%eax
801060eb:	74 11                	je     801060fe <trap+0x9e>
801060ed:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801060f1:	83 e0 03             	and    $0x3,%eax
801060f4:	66 83 f8 03          	cmp    $0x3,%ax
801060f8:	0f 84 0f 01 00 00    	je     8010620d <trap+0x1ad>
    exit();
}
801060fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106101:	5b                   	pop    %ebx
80106102:	5e                   	pop    %esi
80106103:	5f                   	pop    %edi
80106104:	5d                   	pop    %ebp
80106105:	c3                   	ret    
80106106:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010610d:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
80106110:	e8 7b d8 ff ff       	call   80103990 <myproc>
80106115:	8b 7b 38             	mov    0x38(%ebx),%edi
80106118:	85 c0                	test   %eax,%eax
8010611a:	0f 84 a2 01 00 00    	je     801062c2 <trap+0x262>
80106120:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106124:	0f 84 98 01 00 00    	je     801062c2 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010612a:	0f 20 d1             	mov    %cr2,%ecx
8010612d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106130:	e8 3b d8 ff ff       	call   80103970 <cpuid>
80106135:	8b 73 30             	mov    0x30(%ebx),%esi
80106138:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010613b:	8b 43 34             	mov    0x34(%ebx),%eax
8010613e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106141:	e8 4a d8 ff ff       	call   80103990 <myproc>
80106146:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106149:	e8 42 d8 ff ff       	call   80103990 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010614e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106151:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106154:	51                   	push   %ecx
80106155:	57                   	push   %edi
80106156:	52                   	push   %edx
80106157:	ff 75 e4             	push   -0x1c(%ebp)
8010615a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010615b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010615e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106161:	56                   	push   %esi
80106162:	ff 70 10             	push   0x10(%eax)
80106165:	68 08 81 10 80       	push   $0x80108108
8010616a:	e8 31 a5 ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
8010616f:	83 c4 20             	add    $0x20,%esp
80106172:	e8 19 d8 ff ff       	call   80103990 <myproc>
80106177:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010617e:	e8 0d d8 ff ff       	call   80103990 <myproc>
80106183:	85 c0                	test   %eax,%eax
80106185:	0f 85 18 ff ff ff    	jne    801060a3 <trap+0x43>
8010618b:	e9 30 ff ff ff       	jmp    801060c0 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80106190:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106194:	0f 85 3e ff ff ff    	jne    801060d8 <trap+0x78>
    yield();
8010619a:	e8 d1 dd ff ff       	call   80103f70 <yield>
8010619f:	e9 34 ff ff ff       	jmp    801060d8 <trap+0x78>
801061a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801061a8:	8b 7b 38             	mov    0x38(%ebx),%edi
801061ab:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801061af:	e8 bc d7 ff ff       	call   80103970 <cpuid>
801061b4:	57                   	push   %edi
801061b5:	56                   	push   %esi
801061b6:	50                   	push   %eax
801061b7:	68 b0 80 10 80       	push   $0x801080b0
801061bc:	e8 df a4 ff ff       	call   801006a0 <cprintf>
    lapiceoi();
801061c1:	e8 4a c7 ff ff       	call   80102910 <lapiceoi>
    break;
801061c6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061c9:	e8 c2 d7 ff ff       	call   80103990 <myproc>
801061ce:	85 c0                	test   %eax,%eax
801061d0:	0f 85 cd fe ff ff    	jne    801060a3 <trap+0x43>
801061d6:	e9 e5 fe ff ff       	jmp    801060c0 <trap+0x60>
801061db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801061df:	90                   	nop
    if(myproc()->killed)
801061e0:	e8 ab d7 ff ff       	call   80103990 <myproc>
801061e5:	8b 70 24             	mov    0x24(%eax),%esi
801061e8:	85 f6                	test   %esi,%esi
801061ea:	0f 85 c8 00 00 00    	jne    801062b8 <trap+0x258>
    myproc()->tf = tf;
801061f0:	e8 9b d7 ff ff       	call   80103990 <myproc>
801061f5:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
801061f8:	e8 a3 ee ff ff       	call   801050a0 <syscall>
    if(myproc()->killed)
801061fd:	e8 8e d7 ff ff       	call   80103990 <myproc>
80106202:	8b 48 24             	mov    0x24(%eax),%ecx
80106205:	85 c9                	test   %ecx,%ecx
80106207:	0f 84 f1 fe ff ff    	je     801060fe <trap+0x9e>
}
8010620d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106210:	5b                   	pop    %ebx
80106211:	5e                   	pop    %esi
80106212:	5f                   	pop    %edi
80106213:	5d                   	pop    %ebp
      exit();
80106214:	e9 97 e5 ff ff       	jmp    801047b0 <exit>
80106219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106220:	e8 3b 02 00 00       	call   80106460 <uartintr>
    lapiceoi();
80106225:	e8 e6 c6 ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010622a:	e8 61 d7 ff ff       	call   80103990 <myproc>
8010622f:	85 c0                	test   %eax,%eax
80106231:	0f 85 6c fe ff ff    	jne    801060a3 <trap+0x43>
80106237:	e9 84 fe ff ff       	jmp    801060c0 <trap+0x60>
8010623c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106240:	e8 8b c5 ff ff       	call   801027d0 <kbdintr>
    lapiceoi();
80106245:	e8 c6 c6 ff ff       	call   80102910 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010624a:	e8 41 d7 ff ff       	call   80103990 <myproc>
8010624f:	85 c0                	test   %eax,%eax
80106251:	0f 85 4c fe ff ff    	jne    801060a3 <trap+0x43>
80106257:	e9 64 fe ff ff       	jmp    801060c0 <trap+0x60>
8010625c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106260:	e8 0b d7 ff ff       	call   80103970 <cpuid>
80106265:	85 c0                	test   %eax,%eax
80106267:	0f 85 28 fe ff ff    	jne    80106095 <trap+0x35>
      acquire(&tickslock);
8010626d:	83 ec 0c             	sub    $0xc,%esp
80106270:	68 80 50 11 80       	push   $0x80115080
80106275:	e8 66 e9 ff ff       	call   80104be0 <acquire>
      wakeup(&ticks);
8010627a:	c7 04 24 60 50 11 80 	movl   $0x80115060,(%esp)
      ticks++;
80106281:	83 05 60 50 11 80 01 	addl   $0x1,0x80115060
      wakeup(&ticks);
80106288:	e8 f3 dd ff ff       	call   80104080 <wakeup>
      release(&tickslock);
8010628d:	c7 04 24 80 50 11 80 	movl   $0x80115080,(%esp)
80106294:	e8 e7 e8 ff ff       	call   80104b80 <release>
80106299:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010629c:	e9 f4 fd ff ff       	jmp    80106095 <trap+0x35>
801062a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
801062a8:	e8 03 e5 ff ff       	call   801047b0 <exit>
801062ad:	e9 0e fe ff ff       	jmp    801060c0 <trap+0x60>
801062b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801062b8:	e8 f3 e4 ff ff       	call   801047b0 <exit>
801062bd:	e9 2e ff ff ff       	jmp    801061f0 <trap+0x190>
801062c2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801062c5:	e8 a6 d6 ff ff       	call   80103970 <cpuid>
801062ca:	83 ec 0c             	sub    $0xc,%esp
801062cd:	56                   	push   %esi
801062ce:	57                   	push   %edi
801062cf:	50                   	push   %eax
801062d0:	ff 73 30             	push   0x30(%ebx)
801062d3:	68 d4 80 10 80       	push   $0x801080d4
801062d8:	e8 c3 a3 ff ff       	call   801006a0 <cprintf>
      panic("trap");
801062dd:	83 c4 14             	add    $0x14,%esp
801062e0:	68 aa 80 10 80       	push   $0x801080aa
801062e5:	e8 96 a0 ff ff       	call   80100380 <panic>
801062ea:	66 90                	xchg   %ax,%ax
801062ec:	66 90                	xchg   %ax,%ax
801062ee:	66 90                	xchg   %ax,%ax

801062f0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801062f0:	a1 c0 58 11 80       	mov    0x801158c0,%eax
801062f5:	85 c0                	test   %eax,%eax
801062f7:	74 17                	je     80106310 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801062f9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801062fe:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801062ff:	a8 01                	test   $0x1,%al
80106301:	74 0d                	je     80106310 <uartgetc+0x20>
80106303:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106308:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80106309:	0f b6 c0             	movzbl %al,%eax
8010630c:	c3                   	ret    
8010630d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106310:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106315:	c3                   	ret    
80106316:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010631d:	8d 76 00             	lea    0x0(%esi),%esi

80106320 <uartinit>:
{
80106320:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106321:	31 c9                	xor    %ecx,%ecx
80106323:	89 c8                	mov    %ecx,%eax
80106325:	89 e5                	mov    %esp,%ebp
80106327:	57                   	push   %edi
80106328:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010632d:	56                   	push   %esi
8010632e:	89 fa                	mov    %edi,%edx
80106330:	53                   	push   %ebx
80106331:	83 ec 1c             	sub    $0x1c,%esp
80106334:	ee                   	out    %al,(%dx)
80106335:	be fb 03 00 00       	mov    $0x3fb,%esi
8010633a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010633f:	89 f2                	mov    %esi,%edx
80106341:	ee                   	out    %al,(%dx)
80106342:	b8 0c 00 00 00       	mov    $0xc,%eax
80106347:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010634c:	ee                   	out    %al,(%dx)
8010634d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106352:	89 c8                	mov    %ecx,%eax
80106354:	89 da                	mov    %ebx,%edx
80106356:	ee                   	out    %al,(%dx)
80106357:	b8 03 00 00 00       	mov    $0x3,%eax
8010635c:	89 f2                	mov    %esi,%edx
8010635e:	ee                   	out    %al,(%dx)
8010635f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106364:	89 c8                	mov    %ecx,%eax
80106366:	ee                   	out    %al,(%dx)
80106367:	b8 01 00 00 00       	mov    $0x1,%eax
8010636c:	89 da                	mov    %ebx,%edx
8010636e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010636f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106374:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106375:	3c ff                	cmp    $0xff,%al
80106377:	74 78                	je     801063f1 <uartinit+0xd1>
  uart = 1;
80106379:	c7 05 c0 58 11 80 01 	movl   $0x1,0x801158c0
80106380:	00 00 00 
80106383:	89 fa                	mov    %edi,%edx
80106385:	ec                   	in     (%dx),%al
80106386:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010638b:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
8010638c:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
8010638f:	bf cc 81 10 80       	mov    $0x801081cc,%edi
80106394:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80106399:	6a 00                	push   $0x0
8010639b:	6a 04                	push   $0x4
8010639d:	e8 de c0 ff ff       	call   80102480 <ioapicenable>
  for(p="xv6...\n"; *p; p++)
801063a2:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
  ioapicenable(IRQ_COM1, 0);
801063a6:	83 c4 10             	add    $0x10,%esp
801063a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
801063b0:	a1 c0 58 11 80       	mov    0x801158c0,%eax
801063b5:	bb 80 00 00 00       	mov    $0x80,%ebx
801063ba:	85 c0                	test   %eax,%eax
801063bc:	75 14                	jne    801063d2 <uartinit+0xb2>
801063be:	eb 23                	jmp    801063e3 <uartinit+0xc3>
    microdelay(10);
801063c0:	83 ec 0c             	sub    $0xc,%esp
801063c3:	6a 0a                	push   $0xa
801063c5:	e8 66 c5 ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801063ca:	83 c4 10             	add    $0x10,%esp
801063cd:	83 eb 01             	sub    $0x1,%ebx
801063d0:	74 07                	je     801063d9 <uartinit+0xb9>
801063d2:	89 f2                	mov    %esi,%edx
801063d4:	ec                   	in     (%dx),%al
801063d5:	a8 20                	test   $0x20,%al
801063d7:	74 e7                	je     801063c0 <uartinit+0xa0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801063d9:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801063dd:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063e2:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801063e3:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801063e7:	83 c7 01             	add    $0x1,%edi
801063ea:	88 45 e7             	mov    %al,-0x19(%ebp)
801063ed:	84 c0                	test   %al,%al
801063ef:	75 bf                	jne    801063b0 <uartinit+0x90>
}
801063f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063f4:	5b                   	pop    %ebx
801063f5:	5e                   	pop    %esi
801063f6:	5f                   	pop    %edi
801063f7:	5d                   	pop    %ebp
801063f8:	c3                   	ret    
801063f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106400 <uartputc>:
  if(!uart)
80106400:	a1 c0 58 11 80       	mov    0x801158c0,%eax
80106405:	85 c0                	test   %eax,%eax
80106407:	74 47                	je     80106450 <uartputc+0x50>
{
80106409:	55                   	push   %ebp
8010640a:	89 e5                	mov    %esp,%ebp
8010640c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010640d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106412:	53                   	push   %ebx
80106413:	bb 80 00 00 00       	mov    $0x80,%ebx
80106418:	eb 18                	jmp    80106432 <uartputc+0x32>
8010641a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106420:	83 ec 0c             	sub    $0xc,%esp
80106423:	6a 0a                	push   $0xa
80106425:	e8 06 c5 ff ff       	call   80102930 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010642a:	83 c4 10             	add    $0x10,%esp
8010642d:	83 eb 01             	sub    $0x1,%ebx
80106430:	74 07                	je     80106439 <uartputc+0x39>
80106432:	89 f2                	mov    %esi,%edx
80106434:	ec                   	in     (%dx),%al
80106435:	a8 20                	test   $0x20,%al
80106437:	74 e7                	je     80106420 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106439:	8b 45 08             	mov    0x8(%ebp),%eax
8010643c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106441:	ee                   	out    %al,(%dx)
}
80106442:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106445:	5b                   	pop    %ebx
80106446:	5e                   	pop    %esi
80106447:	5d                   	pop    %ebp
80106448:	c3                   	ret    
80106449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106450:	c3                   	ret    
80106451:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010645f:	90                   	nop

80106460 <uartintr>:

void
uartintr(void)
{
80106460:	55                   	push   %ebp
80106461:	89 e5                	mov    %esp,%ebp
80106463:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106466:	68 f0 62 10 80       	push   $0x801062f0
8010646b:	e8 10 a4 ff ff       	call   80100880 <consoleintr>
}
80106470:	83 c4 10             	add    $0x10,%esp
80106473:	c9                   	leave  
80106474:	c3                   	ret    

80106475 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106475:	6a 00                	push   $0x0
  pushl $0
80106477:	6a 00                	push   $0x0
  jmp alltraps
80106479:	e9 01 fb ff ff       	jmp    80105f7f <alltraps>

8010647e <vector1>:
.globl vector1
vector1:
  pushl $0
8010647e:	6a 00                	push   $0x0
  pushl $1
80106480:	6a 01                	push   $0x1
  jmp alltraps
80106482:	e9 f8 fa ff ff       	jmp    80105f7f <alltraps>

80106487 <vector2>:
.globl vector2
vector2:
  pushl $0
80106487:	6a 00                	push   $0x0
  pushl $2
80106489:	6a 02                	push   $0x2
  jmp alltraps
8010648b:	e9 ef fa ff ff       	jmp    80105f7f <alltraps>

80106490 <vector3>:
.globl vector3
vector3:
  pushl $0
80106490:	6a 00                	push   $0x0
  pushl $3
80106492:	6a 03                	push   $0x3
  jmp alltraps
80106494:	e9 e6 fa ff ff       	jmp    80105f7f <alltraps>

80106499 <vector4>:
.globl vector4
vector4:
  pushl $0
80106499:	6a 00                	push   $0x0
  pushl $4
8010649b:	6a 04                	push   $0x4
  jmp alltraps
8010649d:	e9 dd fa ff ff       	jmp    80105f7f <alltraps>

801064a2 <vector5>:
.globl vector5
vector5:
  pushl $0
801064a2:	6a 00                	push   $0x0
  pushl $5
801064a4:	6a 05                	push   $0x5
  jmp alltraps
801064a6:	e9 d4 fa ff ff       	jmp    80105f7f <alltraps>

801064ab <vector6>:
.globl vector6
vector6:
  pushl $0
801064ab:	6a 00                	push   $0x0
  pushl $6
801064ad:	6a 06                	push   $0x6
  jmp alltraps
801064af:	e9 cb fa ff ff       	jmp    80105f7f <alltraps>

801064b4 <vector7>:
.globl vector7
vector7:
  pushl $0
801064b4:	6a 00                	push   $0x0
  pushl $7
801064b6:	6a 07                	push   $0x7
  jmp alltraps
801064b8:	e9 c2 fa ff ff       	jmp    80105f7f <alltraps>

801064bd <vector8>:
.globl vector8
vector8:
  pushl $8
801064bd:	6a 08                	push   $0x8
  jmp alltraps
801064bf:	e9 bb fa ff ff       	jmp    80105f7f <alltraps>

801064c4 <vector9>:
.globl vector9
vector9:
  pushl $0
801064c4:	6a 00                	push   $0x0
  pushl $9
801064c6:	6a 09                	push   $0x9
  jmp alltraps
801064c8:	e9 b2 fa ff ff       	jmp    80105f7f <alltraps>

801064cd <vector10>:
.globl vector10
vector10:
  pushl $10
801064cd:	6a 0a                	push   $0xa
  jmp alltraps
801064cf:	e9 ab fa ff ff       	jmp    80105f7f <alltraps>

801064d4 <vector11>:
.globl vector11
vector11:
  pushl $11
801064d4:	6a 0b                	push   $0xb
  jmp alltraps
801064d6:	e9 a4 fa ff ff       	jmp    80105f7f <alltraps>

801064db <vector12>:
.globl vector12
vector12:
  pushl $12
801064db:	6a 0c                	push   $0xc
  jmp alltraps
801064dd:	e9 9d fa ff ff       	jmp    80105f7f <alltraps>

801064e2 <vector13>:
.globl vector13
vector13:
  pushl $13
801064e2:	6a 0d                	push   $0xd
  jmp alltraps
801064e4:	e9 96 fa ff ff       	jmp    80105f7f <alltraps>

801064e9 <vector14>:
.globl vector14
vector14:
  pushl $14
801064e9:	6a 0e                	push   $0xe
  jmp alltraps
801064eb:	e9 8f fa ff ff       	jmp    80105f7f <alltraps>

801064f0 <vector15>:
.globl vector15
vector15:
  pushl $0
801064f0:	6a 00                	push   $0x0
  pushl $15
801064f2:	6a 0f                	push   $0xf
  jmp alltraps
801064f4:	e9 86 fa ff ff       	jmp    80105f7f <alltraps>

801064f9 <vector16>:
.globl vector16
vector16:
  pushl $0
801064f9:	6a 00                	push   $0x0
  pushl $16
801064fb:	6a 10                	push   $0x10
  jmp alltraps
801064fd:	e9 7d fa ff ff       	jmp    80105f7f <alltraps>

80106502 <vector17>:
.globl vector17
vector17:
  pushl $17
80106502:	6a 11                	push   $0x11
  jmp alltraps
80106504:	e9 76 fa ff ff       	jmp    80105f7f <alltraps>

80106509 <vector18>:
.globl vector18
vector18:
  pushl $0
80106509:	6a 00                	push   $0x0
  pushl $18
8010650b:	6a 12                	push   $0x12
  jmp alltraps
8010650d:	e9 6d fa ff ff       	jmp    80105f7f <alltraps>

80106512 <vector19>:
.globl vector19
vector19:
  pushl $0
80106512:	6a 00                	push   $0x0
  pushl $19
80106514:	6a 13                	push   $0x13
  jmp alltraps
80106516:	e9 64 fa ff ff       	jmp    80105f7f <alltraps>

8010651b <vector20>:
.globl vector20
vector20:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $20
8010651d:	6a 14                	push   $0x14
  jmp alltraps
8010651f:	e9 5b fa ff ff       	jmp    80105f7f <alltraps>

80106524 <vector21>:
.globl vector21
vector21:
  pushl $0
80106524:	6a 00                	push   $0x0
  pushl $21
80106526:	6a 15                	push   $0x15
  jmp alltraps
80106528:	e9 52 fa ff ff       	jmp    80105f7f <alltraps>

8010652d <vector22>:
.globl vector22
vector22:
  pushl $0
8010652d:	6a 00                	push   $0x0
  pushl $22
8010652f:	6a 16                	push   $0x16
  jmp alltraps
80106531:	e9 49 fa ff ff       	jmp    80105f7f <alltraps>

80106536 <vector23>:
.globl vector23
vector23:
  pushl $0
80106536:	6a 00                	push   $0x0
  pushl $23
80106538:	6a 17                	push   $0x17
  jmp alltraps
8010653a:	e9 40 fa ff ff       	jmp    80105f7f <alltraps>

8010653f <vector24>:
.globl vector24
vector24:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $24
80106541:	6a 18                	push   $0x18
  jmp alltraps
80106543:	e9 37 fa ff ff       	jmp    80105f7f <alltraps>

80106548 <vector25>:
.globl vector25
vector25:
  pushl $0
80106548:	6a 00                	push   $0x0
  pushl $25
8010654a:	6a 19                	push   $0x19
  jmp alltraps
8010654c:	e9 2e fa ff ff       	jmp    80105f7f <alltraps>

80106551 <vector26>:
.globl vector26
vector26:
  pushl $0
80106551:	6a 00                	push   $0x0
  pushl $26
80106553:	6a 1a                	push   $0x1a
  jmp alltraps
80106555:	e9 25 fa ff ff       	jmp    80105f7f <alltraps>

8010655a <vector27>:
.globl vector27
vector27:
  pushl $0
8010655a:	6a 00                	push   $0x0
  pushl $27
8010655c:	6a 1b                	push   $0x1b
  jmp alltraps
8010655e:	e9 1c fa ff ff       	jmp    80105f7f <alltraps>

80106563 <vector28>:
.globl vector28
vector28:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $28
80106565:	6a 1c                	push   $0x1c
  jmp alltraps
80106567:	e9 13 fa ff ff       	jmp    80105f7f <alltraps>

8010656c <vector29>:
.globl vector29
vector29:
  pushl $0
8010656c:	6a 00                	push   $0x0
  pushl $29
8010656e:	6a 1d                	push   $0x1d
  jmp alltraps
80106570:	e9 0a fa ff ff       	jmp    80105f7f <alltraps>

80106575 <vector30>:
.globl vector30
vector30:
  pushl $0
80106575:	6a 00                	push   $0x0
  pushl $30
80106577:	6a 1e                	push   $0x1e
  jmp alltraps
80106579:	e9 01 fa ff ff       	jmp    80105f7f <alltraps>

8010657e <vector31>:
.globl vector31
vector31:
  pushl $0
8010657e:	6a 00                	push   $0x0
  pushl $31
80106580:	6a 1f                	push   $0x1f
  jmp alltraps
80106582:	e9 f8 f9 ff ff       	jmp    80105f7f <alltraps>

80106587 <vector32>:
.globl vector32
vector32:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $32
80106589:	6a 20                	push   $0x20
  jmp alltraps
8010658b:	e9 ef f9 ff ff       	jmp    80105f7f <alltraps>

80106590 <vector33>:
.globl vector33
vector33:
  pushl $0
80106590:	6a 00                	push   $0x0
  pushl $33
80106592:	6a 21                	push   $0x21
  jmp alltraps
80106594:	e9 e6 f9 ff ff       	jmp    80105f7f <alltraps>

80106599 <vector34>:
.globl vector34
vector34:
  pushl $0
80106599:	6a 00                	push   $0x0
  pushl $34
8010659b:	6a 22                	push   $0x22
  jmp alltraps
8010659d:	e9 dd f9 ff ff       	jmp    80105f7f <alltraps>

801065a2 <vector35>:
.globl vector35
vector35:
  pushl $0
801065a2:	6a 00                	push   $0x0
  pushl $35
801065a4:	6a 23                	push   $0x23
  jmp alltraps
801065a6:	e9 d4 f9 ff ff       	jmp    80105f7f <alltraps>

801065ab <vector36>:
.globl vector36
vector36:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $36
801065ad:	6a 24                	push   $0x24
  jmp alltraps
801065af:	e9 cb f9 ff ff       	jmp    80105f7f <alltraps>

801065b4 <vector37>:
.globl vector37
vector37:
  pushl $0
801065b4:	6a 00                	push   $0x0
  pushl $37
801065b6:	6a 25                	push   $0x25
  jmp alltraps
801065b8:	e9 c2 f9 ff ff       	jmp    80105f7f <alltraps>

801065bd <vector38>:
.globl vector38
vector38:
  pushl $0
801065bd:	6a 00                	push   $0x0
  pushl $38
801065bf:	6a 26                	push   $0x26
  jmp alltraps
801065c1:	e9 b9 f9 ff ff       	jmp    80105f7f <alltraps>

801065c6 <vector39>:
.globl vector39
vector39:
  pushl $0
801065c6:	6a 00                	push   $0x0
  pushl $39
801065c8:	6a 27                	push   $0x27
  jmp alltraps
801065ca:	e9 b0 f9 ff ff       	jmp    80105f7f <alltraps>

801065cf <vector40>:
.globl vector40
vector40:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $40
801065d1:	6a 28                	push   $0x28
  jmp alltraps
801065d3:	e9 a7 f9 ff ff       	jmp    80105f7f <alltraps>

801065d8 <vector41>:
.globl vector41
vector41:
  pushl $0
801065d8:	6a 00                	push   $0x0
  pushl $41
801065da:	6a 29                	push   $0x29
  jmp alltraps
801065dc:	e9 9e f9 ff ff       	jmp    80105f7f <alltraps>

801065e1 <vector42>:
.globl vector42
vector42:
  pushl $0
801065e1:	6a 00                	push   $0x0
  pushl $42
801065e3:	6a 2a                	push   $0x2a
  jmp alltraps
801065e5:	e9 95 f9 ff ff       	jmp    80105f7f <alltraps>

801065ea <vector43>:
.globl vector43
vector43:
  pushl $0
801065ea:	6a 00                	push   $0x0
  pushl $43
801065ec:	6a 2b                	push   $0x2b
  jmp alltraps
801065ee:	e9 8c f9 ff ff       	jmp    80105f7f <alltraps>

801065f3 <vector44>:
.globl vector44
vector44:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $44
801065f5:	6a 2c                	push   $0x2c
  jmp alltraps
801065f7:	e9 83 f9 ff ff       	jmp    80105f7f <alltraps>

801065fc <vector45>:
.globl vector45
vector45:
  pushl $0
801065fc:	6a 00                	push   $0x0
  pushl $45
801065fe:	6a 2d                	push   $0x2d
  jmp alltraps
80106600:	e9 7a f9 ff ff       	jmp    80105f7f <alltraps>

80106605 <vector46>:
.globl vector46
vector46:
  pushl $0
80106605:	6a 00                	push   $0x0
  pushl $46
80106607:	6a 2e                	push   $0x2e
  jmp alltraps
80106609:	e9 71 f9 ff ff       	jmp    80105f7f <alltraps>

8010660e <vector47>:
.globl vector47
vector47:
  pushl $0
8010660e:	6a 00                	push   $0x0
  pushl $47
80106610:	6a 2f                	push   $0x2f
  jmp alltraps
80106612:	e9 68 f9 ff ff       	jmp    80105f7f <alltraps>

80106617 <vector48>:
.globl vector48
vector48:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $48
80106619:	6a 30                	push   $0x30
  jmp alltraps
8010661b:	e9 5f f9 ff ff       	jmp    80105f7f <alltraps>

80106620 <vector49>:
.globl vector49
vector49:
  pushl $0
80106620:	6a 00                	push   $0x0
  pushl $49
80106622:	6a 31                	push   $0x31
  jmp alltraps
80106624:	e9 56 f9 ff ff       	jmp    80105f7f <alltraps>

80106629 <vector50>:
.globl vector50
vector50:
  pushl $0
80106629:	6a 00                	push   $0x0
  pushl $50
8010662b:	6a 32                	push   $0x32
  jmp alltraps
8010662d:	e9 4d f9 ff ff       	jmp    80105f7f <alltraps>

80106632 <vector51>:
.globl vector51
vector51:
  pushl $0
80106632:	6a 00                	push   $0x0
  pushl $51
80106634:	6a 33                	push   $0x33
  jmp alltraps
80106636:	e9 44 f9 ff ff       	jmp    80105f7f <alltraps>

8010663b <vector52>:
.globl vector52
vector52:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $52
8010663d:	6a 34                	push   $0x34
  jmp alltraps
8010663f:	e9 3b f9 ff ff       	jmp    80105f7f <alltraps>

80106644 <vector53>:
.globl vector53
vector53:
  pushl $0
80106644:	6a 00                	push   $0x0
  pushl $53
80106646:	6a 35                	push   $0x35
  jmp alltraps
80106648:	e9 32 f9 ff ff       	jmp    80105f7f <alltraps>

8010664d <vector54>:
.globl vector54
vector54:
  pushl $0
8010664d:	6a 00                	push   $0x0
  pushl $54
8010664f:	6a 36                	push   $0x36
  jmp alltraps
80106651:	e9 29 f9 ff ff       	jmp    80105f7f <alltraps>

80106656 <vector55>:
.globl vector55
vector55:
  pushl $0
80106656:	6a 00                	push   $0x0
  pushl $55
80106658:	6a 37                	push   $0x37
  jmp alltraps
8010665a:	e9 20 f9 ff ff       	jmp    80105f7f <alltraps>

8010665f <vector56>:
.globl vector56
vector56:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $56
80106661:	6a 38                	push   $0x38
  jmp alltraps
80106663:	e9 17 f9 ff ff       	jmp    80105f7f <alltraps>

80106668 <vector57>:
.globl vector57
vector57:
  pushl $0
80106668:	6a 00                	push   $0x0
  pushl $57
8010666a:	6a 39                	push   $0x39
  jmp alltraps
8010666c:	e9 0e f9 ff ff       	jmp    80105f7f <alltraps>

80106671 <vector58>:
.globl vector58
vector58:
  pushl $0
80106671:	6a 00                	push   $0x0
  pushl $58
80106673:	6a 3a                	push   $0x3a
  jmp alltraps
80106675:	e9 05 f9 ff ff       	jmp    80105f7f <alltraps>

8010667a <vector59>:
.globl vector59
vector59:
  pushl $0
8010667a:	6a 00                	push   $0x0
  pushl $59
8010667c:	6a 3b                	push   $0x3b
  jmp alltraps
8010667e:	e9 fc f8 ff ff       	jmp    80105f7f <alltraps>

80106683 <vector60>:
.globl vector60
vector60:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $60
80106685:	6a 3c                	push   $0x3c
  jmp alltraps
80106687:	e9 f3 f8 ff ff       	jmp    80105f7f <alltraps>

8010668c <vector61>:
.globl vector61
vector61:
  pushl $0
8010668c:	6a 00                	push   $0x0
  pushl $61
8010668e:	6a 3d                	push   $0x3d
  jmp alltraps
80106690:	e9 ea f8 ff ff       	jmp    80105f7f <alltraps>

80106695 <vector62>:
.globl vector62
vector62:
  pushl $0
80106695:	6a 00                	push   $0x0
  pushl $62
80106697:	6a 3e                	push   $0x3e
  jmp alltraps
80106699:	e9 e1 f8 ff ff       	jmp    80105f7f <alltraps>

8010669e <vector63>:
.globl vector63
vector63:
  pushl $0
8010669e:	6a 00                	push   $0x0
  pushl $63
801066a0:	6a 3f                	push   $0x3f
  jmp alltraps
801066a2:	e9 d8 f8 ff ff       	jmp    80105f7f <alltraps>

801066a7 <vector64>:
.globl vector64
vector64:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $64
801066a9:	6a 40                	push   $0x40
  jmp alltraps
801066ab:	e9 cf f8 ff ff       	jmp    80105f7f <alltraps>

801066b0 <vector65>:
.globl vector65
vector65:
  pushl $0
801066b0:	6a 00                	push   $0x0
  pushl $65
801066b2:	6a 41                	push   $0x41
  jmp alltraps
801066b4:	e9 c6 f8 ff ff       	jmp    80105f7f <alltraps>

801066b9 <vector66>:
.globl vector66
vector66:
  pushl $0
801066b9:	6a 00                	push   $0x0
  pushl $66
801066bb:	6a 42                	push   $0x42
  jmp alltraps
801066bd:	e9 bd f8 ff ff       	jmp    80105f7f <alltraps>

801066c2 <vector67>:
.globl vector67
vector67:
  pushl $0
801066c2:	6a 00                	push   $0x0
  pushl $67
801066c4:	6a 43                	push   $0x43
  jmp alltraps
801066c6:	e9 b4 f8 ff ff       	jmp    80105f7f <alltraps>

801066cb <vector68>:
.globl vector68
vector68:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $68
801066cd:	6a 44                	push   $0x44
  jmp alltraps
801066cf:	e9 ab f8 ff ff       	jmp    80105f7f <alltraps>

801066d4 <vector69>:
.globl vector69
vector69:
  pushl $0
801066d4:	6a 00                	push   $0x0
  pushl $69
801066d6:	6a 45                	push   $0x45
  jmp alltraps
801066d8:	e9 a2 f8 ff ff       	jmp    80105f7f <alltraps>

801066dd <vector70>:
.globl vector70
vector70:
  pushl $0
801066dd:	6a 00                	push   $0x0
  pushl $70
801066df:	6a 46                	push   $0x46
  jmp alltraps
801066e1:	e9 99 f8 ff ff       	jmp    80105f7f <alltraps>

801066e6 <vector71>:
.globl vector71
vector71:
  pushl $0
801066e6:	6a 00                	push   $0x0
  pushl $71
801066e8:	6a 47                	push   $0x47
  jmp alltraps
801066ea:	e9 90 f8 ff ff       	jmp    80105f7f <alltraps>

801066ef <vector72>:
.globl vector72
vector72:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $72
801066f1:	6a 48                	push   $0x48
  jmp alltraps
801066f3:	e9 87 f8 ff ff       	jmp    80105f7f <alltraps>

801066f8 <vector73>:
.globl vector73
vector73:
  pushl $0
801066f8:	6a 00                	push   $0x0
  pushl $73
801066fa:	6a 49                	push   $0x49
  jmp alltraps
801066fc:	e9 7e f8 ff ff       	jmp    80105f7f <alltraps>

80106701 <vector74>:
.globl vector74
vector74:
  pushl $0
80106701:	6a 00                	push   $0x0
  pushl $74
80106703:	6a 4a                	push   $0x4a
  jmp alltraps
80106705:	e9 75 f8 ff ff       	jmp    80105f7f <alltraps>

8010670a <vector75>:
.globl vector75
vector75:
  pushl $0
8010670a:	6a 00                	push   $0x0
  pushl $75
8010670c:	6a 4b                	push   $0x4b
  jmp alltraps
8010670e:	e9 6c f8 ff ff       	jmp    80105f7f <alltraps>

80106713 <vector76>:
.globl vector76
vector76:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $76
80106715:	6a 4c                	push   $0x4c
  jmp alltraps
80106717:	e9 63 f8 ff ff       	jmp    80105f7f <alltraps>

8010671c <vector77>:
.globl vector77
vector77:
  pushl $0
8010671c:	6a 00                	push   $0x0
  pushl $77
8010671e:	6a 4d                	push   $0x4d
  jmp alltraps
80106720:	e9 5a f8 ff ff       	jmp    80105f7f <alltraps>

80106725 <vector78>:
.globl vector78
vector78:
  pushl $0
80106725:	6a 00                	push   $0x0
  pushl $78
80106727:	6a 4e                	push   $0x4e
  jmp alltraps
80106729:	e9 51 f8 ff ff       	jmp    80105f7f <alltraps>

8010672e <vector79>:
.globl vector79
vector79:
  pushl $0
8010672e:	6a 00                	push   $0x0
  pushl $79
80106730:	6a 4f                	push   $0x4f
  jmp alltraps
80106732:	e9 48 f8 ff ff       	jmp    80105f7f <alltraps>

80106737 <vector80>:
.globl vector80
vector80:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $80
80106739:	6a 50                	push   $0x50
  jmp alltraps
8010673b:	e9 3f f8 ff ff       	jmp    80105f7f <alltraps>

80106740 <vector81>:
.globl vector81
vector81:
  pushl $0
80106740:	6a 00                	push   $0x0
  pushl $81
80106742:	6a 51                	push   $0x51
  jmp alltraps
80106744:	e9 36 f8 ff ff       	jmp    80105f7f <alltraps>

80106749 <vector82>:
.globl vector82
vector82:
  pushl $0
80106749:	6a 00                	push   $0x0
  pushl $82
8010674b:	6a 52                	push   $0x52
  jmp alltraps
8010674d:	e9 2d f8 ff ff       	jmp    80105f7f <alltraps>

80106752 <vector83>:
.globl vector83
vector83:
  pushl $0
80106752:	6a 00                	push   $0x0
  pushl $83
80106754:	6a 53                	push   $0x53
  jmp alltraps
80106756:	e9 24 f8 ff ff       	jmp    80105f7f <alltraps>

8010675b <vector84>:
.globl vector84
vector84:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $84
8010675d:	6a 54                	push   $0x54
  jmp alltraps
8010675f:	e9 1b f8 ff ff       	jmp    80105f7f <alltraps>

80106764 <vector85>:
.globl vector85
vector85:
  pushl $0
80106764:	6a 00                	push   $0x0
  pushl $85
80106766:	6a 55                	push   $0x55
  jmp alltraps
80106768:	e9 12 f8 ff ff       	jmp    80105f7f <alltraps>

8010676d <vector86>:
.globl vector86
vector86:
  pushl $0
8010676d:	6a 00                	push   $0x0
  pushl $86
8010676f:	6a 56                	push   $0x56
  jmp alltraps
80106771:	e9 09 f8 ff ff       	jmp    80105f7f <alltraps>

80106776 <vector87>:
.globl vector87
vector87:
  pushl $0
80106776:	6a 00                	push   $0x0
  pushl $87
80106778:	6a 57                	push   $0x57
  jmp alltraps
8010677a:	e9 00 f8 ff ff       	jmp    80105f7f <alltraps>

8010677f <vector88>:
.globl vector88
vector88:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $88
80106781:	6a 58                	push   $0x58
  jmp alltraps
80106783:	e9 f7 f7 ff ff       	jmp    80105f7f <alltraps>

80106788 <vector89>:
.globl vector89
vector89:
  pushl $0
80106788:	6a 00                	push   $0x0
  pushl $89
8010678a:	6a 59                	push   $0x59
  jmp alltraps
8010678c:	e9 ee f7 ff ff       	jmp    80105f7f <alltraps>

80106791 <vector90>:
.globl vector90
vector90:
  pushl $0
80106791:	6a 00                	push   $0x0
  pushl $90
80106793:	6a 5a                	push   $0x5a
  jmp alltraps
80106795:	e9 e5 f7 ff ff       	jmp    80105f7f <alltraps>

8010679a <vector91>:
.globl vector91
vector91:
  pushl $0
8010679a:	6a 00                	push   $0x0
  pushl $91
8010679c:	6a 5b                	push   $0x5b
  jmp alltraps
8010679e:	e9 dc f7 ff ff       	jmp    80105f7f <alltraps>

801067a3 <vector92>:
.globl vector92
vector92:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $92
801067a5:	6a 5c                	push   $0x5c
  jmp alltraps
801067a7:	e9 d3 f7 ff ff       	jmp    80105f7f <alltraps>

801067ac <vector93>:
.globl vector93
vector93:
  pushl $0
801067ac:	6a 00                	push   $0x0
  pushl $93
801067ae:	6a 5d                	push   $0x5d
  jmp alltraps
801067b0:	e9 ca f7 ff ff       	jmp    80105f7f <alltraps>

801067b5 <vector94>:
.globl vector94
vector94:
  pushl $0
801067b5:	6a 00                	push   $0x0
  pushl $94
801067b7:	6a 5e                	push   $0x5e
  jmp alltraps
801067b9:	e9 c1 f7 ff ff       	jmp    80105f7f <alltraps>

801067be <vector95>:
.globl vector95
vector95:
  pushl $0
801067be:	6a 00                	push   $0x0
  pushl $95
801067c0:	6a 5f                	push   $0x5f
  jmp alltraps
801067c2:	e9 b8 f7 ff ff       	jmp    80105f7f <alltraps>

801067c7 <vector96>:
.globl vector96
vector96:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $96
801067c9:	6a 60                	push   $0x60
  jmp alltraps
801067cb:	e9 af f7 ff ff       	jmp    80105f7f <alltraps>

801067d0 <vector97>:
.globl vector97
vector97:
  pushl $0
801067d0:	6a 00                	push   $0x0
  pushl $97
801067d2:	6a 61                	push   $0x61
  jmp alltraps
801067d4:	e9 a6 f7 ff ff       	jmp    80105f7f <alltraps>

801067d9 <vector98>:
.globl vector98
vector98:
  pushl $0
801067d9:	6a 00                	push   $0x0
  pushl $98
801067db:	6a 62                	push   $0x62
  jmp alltraps
801067dd:	e9 9d f7 ff ff       	jmp    80105f7f <alltraps>

801067e2 <vector99>:
.globl vector99
vector99:
  pushl $0
801067e2:	6a 00                	push   $0x0
  pushl $99
801067e4:	6a 63                	push   $0x63
  jmp alltraps
801067e6:	e9 94 f7 ff ff       	jmp    80105f7f <alltraps>

801067eb <vector100>:
.globl vector100
vector100:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $100
801067ed:	6a 64                	push   $0x64
  jmp alltraps
801067ef:	e9 8b f7 ff ff       	jmp    80105f7f <alltraps>

801067f4 <vector101>:
.globl vector101
vector101:
  pushl $0
801067f4:	6a 00                	push   $0x0
  pushl $101
801067f6:	6a 65                	push   $0x65
  jmp alltraps
801067f8:	e9 82 f7 ff ff       	jmp    80105f7f <alltraps>

801067fd <vector102>:
.globl vector102
vector102:
  pushl $0
801067fd:	6a 00                	push   $0x0
  pushl $102
801067ff:	6a 66                	push   $0x66
  jmp alltraps
80106801:	e9 79 f7 ff ff       	jmp    80105f7f <alltraps>

80106806 <vector103>:
.globl vector103
vector103:
  pushl $0
80106806:	6a 00                	push   $0x0
  pushl $103
80106808:	6a 67                	push   $0x67
  jmp alltraps
8010680a:	e9 70 f7 ff ff       	jmp    80105f7f <alltraps>

8010680f <vector104>:
.globl vector104
vector104:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $104
80106811:	6a 68                	push   $0x68
  jmp alltraps
80106813:	e9 67 f7 ff ff       	jmp    80105f7f <alltraps>

80106818 <vector105>:
.globl vector105
vector105:
  pushl $0
80106818:	6a 00                	push   $0x0
  pushl $105
8010681a:	6a 69                	push   $0x69
  jmp alltraps
8010681c:	e9 5e f7 ff ff       	jmp    80105f7f <alltraps>

80106821 <vector106>:
.globl vector106
vector106:
  pushl $0
80106821:	6a 00                	push   $0x0
  pushl $106
80106823:	6a 6a                	push   $0x6a
  jmp alltraps
80106825:	e9 55 f7 ff ff       	jmp    80105f7f <alltraps>

8010682a <vector107>:
.globl vector107
vector107:
  pushl $0
8010682a:	6a 00                	push   $0x0
  pushl $107
8010682c:	6a 6b                	push   $0x6b
  jmp alltraps
8010682e:	e9 4c f7 ff ff       	jmp    80105f7f <alltraps>

80106833 <vector108>:
.globl vector108
vector108:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $108
80106835:	6a 6c                	push   $0x6c
  jmp alltraps
80106837:	e9 43 f7 ff ff       	jmp    80105f7f <alltraps>

8010683c <vector109>:
.globl vector109
vector109:
  pushl $0
8010683c:	6a 00                	push   $0x0
  pushl $109
8010683e:	6a 6d                	push   $0x6d
  jmp alltraps
80106840:	e9 3a f7 ff ff       	jmp    80105f7f <alltraps>

80106845 <vector110>:
.globl vector110
vector110:
  pushl $0
80106845:	6a 00                	push   $0x0
  pushl $110
80106847:	6a 6e                	push   $0x6e
  jmp alltraps
80106849:	e9 31 f7 ff ff       	jmp    80105f7f <alltraps>

8010684e <vector111>:
.globl vector111
vector111:
  pushl $0
8010684e:	6a 00                	push   $0x0
  pushl $111
80106850:	6a 6f                	push   $0x6f
  jmp alltraps
80106852:	e9 28 f7 ff ff       	jmp    80105f7f <alltraps>

80106857 <vector112>:
.globl vector112
vector112:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $112
80106859:	6a 70                	push   $0x70
  jmp alltraps
8010685b:	e9 1f f7 ff ff       	jmp    80105f7f <alltraps>

80106860 <vector113>:
.globl vector113
vector113:
  pushl $0
80106860:	6a 00                	push   $0x0
  pushl $113
80106862:	6a 71                	push   $0x71
  jmp alltraps
80106864:	e9 16 f7 ff ff       	jmp    80105f7f <alltraps>

80106869 <vector114>:
.globl vector114
vector114:
  pushl $0
80106869:	6a 00                	push   $0x0
  pushl $114
8010686b:	6a 72                	push   $0x72
  jmp alltraps
8010686d:	e9 0d f7 ff ff       	jmp    80105f7f <alltraps>

80106872 <vector115>:
.globl vector115
vector115:
  pushl $0
80106872:	6a 00                	push   $0x0
  pushl $115
80106874:	6a 73                	push   $0x73
  jmp alltraps
80106876:	e9 04 f7 ff ff       	jmp    80105f7f <alltraps>

8010687b <vector116>:
.globl vector116
vector116:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $116
8010687d:	6a 74                	push   $0x74
  jmp alltraps
8010687f:	e9 fb f6 ff ff       	jmp    80105f7f <alltraps>

80106884 <vector117>:
.globl vector117
vector117:
  pushl $0
80106884:	6a 00                	push   $0x0
  pushl $117
80106886:	6a 75                	push   $0x75
  jmp alltraps
80106888:	e9 f2 f6 ff ff       	jmp    80105f7f <alltraps>

8010688d <vector118>:
.globl vector118
vector118:
  pushl $0
8010688d:	6a 00                	push   $0x0
  pushl $118
8010688f:	6a 76                	push   $0x76
  jmp alltraps
80106891:	e9 e9 f6 ff ff       	jmp    80105f7f <alltraps>

80106896 <vector119>:
.globl vector119
vector119:
  pushl $0
80106896:	6a 00                	push   $0x0
  pushl $119
80106898:	6a 77                	push   $0x77
  jmp alltraps
8010689a:	e9 e0 f6 ff ff       	jmp    80105f7f <alltraps>

8010689f <vector120>:
.globl vector120
vector120:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $120
801068a1:	6a 78                	push   $0x78
  jmp alltraps
801068a3:	e9 d7 f6 ff ff       	jmp    80105f7f <alltraps>

801068a8 <vector121>:
.globl vector121
vector121:
  pushl $0
801068a8:	6a 00                	push   $0x0
  pushl $121
801068aa:	6a 79                	push   $0x79
  jmp alltraps
801068ac:	e9 ce f6 ff ff       	jmp    80105f7f <alltraps>

801068b1 <vector122>:
.globl vector122
vector122:
  pushl $0
801068b1:	6a 00                	push   $0x0
  pushl $122
801068b3:	6a 7a                	push   $0x7a
  jmp alltraps
801068b5:	e9 c5 f6 ff ff       	jmp    80105f7f <alltraps>

801068ba <vector123>:
.globl vector123
vector123:
  pushl $0
801068ba:	6a 00                	push   $0x0
  pushl $123
801068bc:	6a 7b                	push   $0x7b
  jmp alltraps
801068be:	e9 bc f6 ff ff       	jmp    80105f7f <alltraps>

801068c3 <vector124>:
.globl vector124
vector124:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $124
801068c5:	6a 7c                	push   $0x7c
  jmp alltraps
801068c7:	e9 b3 f6 ff ff       	jmp    80105f7f <alltraps>

801068cc <vector125>:
.globl vector125
vector125:
  pushl $0
801068cc:	6a 00                	push   $0x0
  pushl $125
801068ce:	6a 7d                	push   $0x7d
  jmp alltraps
801068d0:	e9 aa f6 ff ff       	jmp    80105f7f <alltraps>

801068d5 <vector126>:
.globl vector126
vector126:
  pushl $0
801068d5:	6a 00                	push   $0x0
  pushl $126
801068d7:	6a 7e                	push   $0x7e
  jmp alltraps
801068d9:	e9 a1 f6 ff ff       	jmp    80105f7f <alltraps>

801068de <vector127>:
.globl vector127
vector127:
  pushl $0
801068de:	6a 00                	push   $0x0
  pushl $127
801068e0:	6a 7f                	push   $0x7f
  jmp alltraps
801068e2:	e9 98 f6 ff ff       	jmp    80105f7f <alltraps>

801068e7 <vector128>:
.globl vector128
vector128:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $128
801068e9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801068ee:	e9 8c f6 ff ff       	jmp    80105f7f <alltraps>

801068f3 <vector129>:
.globl vector129
vector129:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $129
801068f5:	68 81 00 00 00       	push   $0x81
  jmp alltraps
801068fa:	e9 80 f6 ff ff       	jmp    80105f7f <alltraps>

801068ff <vector130>:
.globl vector130
vector130:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $130
80106901:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106906:	e9 74 f6 ff ff       	jmp    80105f7f <alltraps>

8010690b <vector131>:
.globl vector131
vector131:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $131
8010690d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106912:	e9 68 f6 ff ff       	jmp    80105f7f <alltraps>

80106917 <vector132>:
.globl vector132
vector132:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $132
80106919:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010691e:	e9 5c f6 ff ff       	jmp    80105f7f <alltraps>

80106923 <vector133>:
.globl vector133
vector133:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $133
80106925:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010692a:	e9 50 f6 ff ff       	jmp    80105f7f <alltraps>

8010692f <vector134>:
.globl vector134
vector134:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $134
80106931:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106936:	e9 44 f6 ff ff       	jmp    80105f7f <alltraps>

8010693b <vector135>:
.globl vector135
vector135:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $135
8010693d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106942:	e9 38 f6 ff ff       	jmp    80105f7f <alltraps>

80106947 <vector136>:
.globl vector136
vector136:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $136
80106949:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010694e:	e9 2c f6 ff ff       	jmp    80105f7f <alltraps>

80106953 <vector137>:
.globl vector137
vector137:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $137
80106955:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010695a:	e9 20 f6 ff ff       	jmp    80105f7f <alltraps>

8010695f <vector138>:
.globl vector138
vector138:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $138
80106961:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106966:	e9 14 f6 ff ff       	jmp    80105f7f <alltraps>

8010696b <vector139>:
.globl vector139
vector139:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $139
8010696d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106972:	e9 08 f6 ff ff       	jmp    80105f7f <alltraps>

80106977 <vector140>:
.globl vector140
vector140:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $140
80106979:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010697e:	e9 fc f5 ff ff       	jmp    80105f7f <alltraps>

80106983 <vector141>:
.globl vector141
vector141:
  pushl $0
80106983:	6a 00                	push   $0x0
  pushl $141
80106985:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010698a:	e9 f0 f5 ff ff       	jmp    80105f7f <alltraps>

8010698f <vector142>:
.globl vector142
vector142:
  pushl $0
8010698f:	6a 00                	push   $0x0
  pushl $142
80106991:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106996:	e9 e4 f5 ff ff       	jmp    80105f7f <alltraps>

8010699b <vector143>:
.globl vector143
vector143:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $143
8010699d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801069a2:	e9 d8 f5 ff ff       	jmp    80105f7f <alltraps>

801069a7 <vector144>:
.globl vector144
vector144:
  pushl $0
801069a7:	6a 00                	push   $0x0
  pushl $144
801069a9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801069ae:	e9 cc f5 ff ff       	jmp    80105f7f <alltraps>

801069b3 <vector145>:
.globl vector145
vector145:
  pushl $0
801069b3:	6a 00                	push   $0x0
  pushl $145
801069b5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801069ba:	e9 c0 f5 ff ff       	jmp    80105f7f <alltraps>

801069bf <vector146>:
.globl vector146
vector146:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $146
801069c1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801069c6:	e9 b4 f5 ff ff       	jmp    80105f7f <alltraps>

801069cb <vector147>:
.globl vector147
vector147:
  pushl $0
801069cb:	6a 00                	push   $0x0
  pushl $147
801069cd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801069d2:	e9 a8 f5 ff ff       	jmp    80105f7f <alltraps>

801069d7 <vector148>:
.globl vector148
vector148:
  pushl $0
801069d7:	6a 00                	push   $0x0
  pushl $148
801069d9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801069de:	e9 9c f5 ff ff       	jmp    80105f7f <alltraps>

801069e3 <vector149>:
.globl vector149
vector149:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $149
801069e5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801069ea:	e9 90 f5 ff ff       	jmp    80105f7f <alltraps>

801069ef <vector150>:
.globl vector150
vector150:
  pushl $0
801069ef:	6a 00                	push   $0x0
  pushl $150
801069f1:	68 96 00 00 00       	push   $0x96
  jmp alltraps
801069f6:	e9 84 f5 ff ff       	jmp    80105f7f <alltraps>

801069fb <vector151>:
.globl vector151
vector151:
  pushl $0
801069fb:	6a 00                	push   $0x0
  pushl $151
801069fd:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106a02:	e9 78 f5 ff ff       	jmp    80105f7f <alltraps>

80106a07 <vector152>:
.globl vector152
vector152:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $152
80106a09:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106a0e:	e9 6c f5 ff ff       	jmp    80105f7f <alltraps>

80106a13 <vector153>:
.globl vector153
vector153:
  pushl $0
80106a13:	6a 00                	push   $0x0
  pushl $153
80106a15:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106a1a:	e9 60 f5 ff ff       	jmp    80105f7f <alltraps>

80106a1f <vector154>:
.globl vector154
vector154:
  pushl $0
80106a1f:	6a 00                	push   $0x0
  pushl $154
80106a21:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106a26:	e9 54 f5 ff ff       	jmp    80105f7f <alltraps>

80106a2b <vector155>:
.globl vector155
vector155:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $155
80106a2d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106a32:	e9 48 f5 ff ff       	jmp    80105f7f <alltraps>

80106a37 <vector156>:
.globl vector156
vector156:
  pushl $0
80106a37:	6a 00                	push   $0x0
  pushl $156
80106a39:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106a3e:	e9 3c f5 ff ff       	jmp    80105f7f <alltraps>

80106a43 <vector157>:
.globl vector157
vector157:
  pushl $0
80106a43:	6a 00                	push   $0x0
  pushl $157
80106a45:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106a4a:	e9 30 f5 ff ff       	jmp    80105f7f <alltraps>

80106a4f <vector158>:
.globl vector158
vector158:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $158
80106a51:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106a56:	e9 24 f5 ff ff       	jmp    80105f7f <alltraps>

80106a5b <vector159>:
.globl vector159
vector159:
  pushl $0
80106a5b:	6a 00                	push   $0x0
  pushl $159
80106a5d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106a62:	e9 18 f5 ff ff       	jmp    80105f7f <alltraps>

80106a67 <vector160>:
.globl vector160
vector160:
  pushl $0
80106a67:	6a 00                	push   $0x0
  pushl $160
80106a69:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106a6e:	e9 0c f5 ff ff       	jmp    80105f7f <alltraps>

80106a73 <vector161>:
.globl vector161
vector161:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $161
80106a75:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106a7a:	e9 00 f5 ff ff       	jmp    80105f7f <alltraps>

80106a7f <vector162>:
.globl vector162
vector162:
  pushl $0
80106a7f:	6a 00                	push   $0x0
  pushl $162
80106a81:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106a86:	e9 f4 f4 ff ff       	jmp    80105f7f <alltraps>

80106a8b <vector163>:
.globl vector163
vector163:
  pushl $0
80106a8b:	6a 00                	push   $0x0
  pushl $163
80106a8d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106a92:	e9 e8 f4 ff ff       	jmp    80105f7f <alltraps>

80106a97 <vector164>:
.globl vector164
vector164:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $164
80106a99:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106a9e:	e9 dc f4 ff ff       	jmp    80105f7f <alltraps>

80106aa3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106aa3:	6a 00                	push   $0x0
  pushl $165
80106aa5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106aaa:	e9 d0 f4 ff ff       	jmp    80105f7f <alltraps>

80106aaf <vector166>:
.globl vector166
vector166:
  pushl $0
80106aaf:	6a 00                	push   $0x0
  pushl $166
80106ab1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106ab6:	e9 c4 f4 ff ff       	jmp    80105f7f <alltraps>

80106abb <vector167>:
.globl vector167
vector167:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $167
80106abd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106ac2:	e9 b8 f4 ff ff       	jmp    80105f7f <alltraps>

80106ac7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106ac7:	6a 00                	push   $0x0
  pushl $168
80106ac9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106ace:	e9 ac f4 ff ff       	jmp    80105f7f <alltraps>

80106ad3 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ad3:	6a 00                	push   $0x0
  pushl $169
80106ad5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106ada:	e9 a0 f4 ff ff       	jmp    80105f7f <alltraps>

80106adf <vector170>:
.globl vector170
vector170:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $170
80106ae1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106ae6:	e9 94 f4 ff ff       	jmp    80105f7f <alltraps>

80106aeb <vector171>:
.globl vector171
vector171:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $171
80106aed:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106af2:	e9 88 f4 ff ff       	jmp    80105f7f <alltraps>

80106af7 <vector172>:
.globl vector172
vector172:
  pushl $0
80106af7:	6a 00                	push   $0x0
  pushl $172
80106af9:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106afe:	e9 7c f4 ff ff       	jmp    80105f7f <alltraps>

80106b03 <vector173>:
.globl vector173
vector173:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $173
80106b05:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106b0a:	e9 70 f4 ff ff       	jmp    80105f7f <alltraps>

80106b0f <vector174>:
.globl vector174
vector174:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $174
80106b11:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106b16:	e9 64 f4 ff ff       	jmp    80105f7f <alltraps>

80106b1b <vector175>:
.globl vector175
vector175:
  pushl $0
80106b1b:	6a 00                	push   $0x0
  pushl $175
80106b1d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106b22:	e9 58 f4 ff ff       	jmp    80105f7f <alltraps>

80106b27 <vector176>:
.globl vector176
vector176:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $176
80106b29:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106b2e:	e9 4c f4 ff ff       	jmp    80105f7f <alltraps>

80106b33 <vector177>:
.globl vector177
vector177:
  pushl $0
80106b33:	6a 00                	push   $0x0
  pushl $177
80106b35:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106b3a:	e9 40 f4 ff ff       	jmp    80105f7f <alltraps>

80106b3f <vector178>:
.globl vector178
vector178:
  pushl $0
80106b3f:	6a 00                	push   $0x0
  pushl $178
80106b41:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106b46:	e9 34 f4 ff ff       	jmp    80105f7f <alltraps>

80106b4b <vector179>:
.globl vector179
vector179:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $179
80106b4d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106b52:	e9 28 f4 ff ff       	jmp    80105f7f <alltraps>

80106b57 <vector180>:
.globl vector180
vector180:
  pushl $0
80106b57:	6a 00                	push   $0x0
  pushl $180
80106b59:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106b5e:	e9 1c f4 ff ff       	jmp    80105f7f <alltraps>

80106b63 <vector181>:
.globl vector181
vector181:
  pushl $0
80106b63:	6a 00                	push   $0x0
  pushl $181
80106b65:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106b6a:	e9 10 f4 ff ff       	jmp    80105f7f <alltraps>

80106b6f <vector182>:
.globl vector182
vector182:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $182
80106b71:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106b76:	e9 04 f4 ff ff       	jmp    80105f7f <alltraps>

80106b7b <vector183>:
.globl vector183
vector183:
  pushl $0
80106b7b:	6a 00                	push   $0x0
  pushl $183
80106b7d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106b82:	e9 f8 f3 ff ff       	jmp    80105f7f <alltraps>

80106b87 <vector184>:
.globl vector184
vector184:
  pushl $0
80106b87:	6a 00                	push   $0x0
  pushl $184
80106b89:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106b8e:	e9 ec f3 ff ff       	jmp    80105f7f <alltraps>

80106b93 <vector185>:
.globl vector185
vector185:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $185
80106b95:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106b9a:	e9 e0 f3 ff ff       	jmp    80105f7f <alltraps>

80106b9f <vector186>:
.globl vector186
vector186:
  pushl $0
80106b9f:	6a 00                	push   $0x0
  pushl $186
80106ba1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106ba6:	e9 d4 f3 ff ff       	jmp    80105f7f <alltraps>

80106bab <vector187>:
.globl vector187
vector187:
  pushl $0
80106bab:	6a 00                	push   $0x0
  pushl $187
80106bad:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106bb2:	e9 c8 f3 ff ff       	jmp    80105f7f <alltraps>

80106bb7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $188
80106bb9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106bbe:	e9 bc f3 ff ff       	jmp    80105f7f <alltraps>

80106bc3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106bc3:	6a 00                	push   $0x0
  pushl $189
80106bc5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106bca:	e9 b0 f3 ff ff       	jmp    80105f7f <alltraps>

80106bcf <vector190>:
.globl vector190
vector190:
  pushl $0
80106bcf:	6a 00                	push   $0x0
  pushl $190
80106bd1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106bd6:	e9 a4 f3 ff ff       	jmp    80105f7f <alltraps>

80106bdb <vector191>:
.globl vector191
vector191:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $191
80106bdd:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106be2:	e9 98 f3 ff ff       	jmp    80105f7f <alltraps>

80106be7 <vector192>:
.globl vector192
vector192:
  pushl $0
80106be7:	6a 00                	push   $0x0
  pushl $192
80106be9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106bee:	e9 8c f3 ff ff       	jmp    80105f7f <alltraps>

80106bf3 <vector193>:
.globl vector193
vector193:
  pushl $0
80106bf3:	6a 00                	push   $0x0
  pushl $193
80106bf5:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106bfa:	e9 80 f3 ff ff       	jmp    80105f7f <alltraps>

80106bff <vector194>:
.globl vector194
vector194:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $194
80106c01:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106c06:	e9 74 f3 ff ff       	jmp    80105f7f <alltraps>

80106c0b <vector195>:
.globl vector195
vector195:
  pushl $0
80106c0b:	6a 00                	push   $0x0
  pushl $195
80106c0d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106c12:	e9 68 f3 ff ff       	jmp    80105f7f <alltraps>

80106c17 <vector196>:
.globl vector196
vector196:
  pushl $0
80106c17:	6a 00                	push   $0x0
  pushl $196
80106c19:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106c1e:	e9 5c f3 ff ff       	jmp    80105f7f <alltraps>

80106c23 <vector197>:
.globl vector197
vector197:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $197
80106c25:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106c2a:	e9 50 f3 ff ff       	jmp    80105f7f <alltraps>

80106c2f <vector198>:
.globl vector198
vector198:
  pushl $0
80106c2f:	6a 00                	push   $0x0
  pushl $198
80106c31:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106c36:	e9 44 f3 ff ff       	jmp    80105f7f <alltraps>

80106c3b <vector199>:
.globl vector199
vector199:
  pushl $0
80106c3b:	6a 00                	push   $0x0
  pushl $199
80106c3d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106c42:	e9 38 f3 ff ff       	jmp    80105f7f <alltraps>

80106c47 <vector200>:
.globl vector200
vector200:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $200
80106c49:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106c4e:	e9 2c f3 ff ff       	jmp    80105f7f <alltraps>

80106c53 <vector201>:
.globl vector201
vector201:
  pushl $0
80106c53:	6a 00                	push   $0x0
  pushl $201
80106c55:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106c5a:	e9 20 f3 ff ff       	jmp    80105f7f <alltraps>

80106c5f <vector202>:
.globl vector202
vector202:
  pushl $0
80106c5f:	6a 00                	push   $0x0
  pushl $202
80106c61:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106c66:	e9 14 f3 ff ff       	jmp    80105f7f <alltraps>

80106c6b <vector203>:
.globl vector203
vector203:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $203
80106c6d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106c72:	e9 08 f3 ff ff       	jmp    80105f7f <alltraps>

80106c77 <vector204>:
.globl vector204
vector204:
  pushl $0
80106c77:	6a 00                	push   $0x0
  pushl $204
80106c79:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106c7e:	e9 fc f2 ff ff       	jmp    80105f7f <alltraps>

80106c83 <vector205>:
.globl vector205
vector205:
  pushl $0
80106c83:	6a 00                	push   $0x0
  pushl $205
80106c85:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106c8a:	e9 f0 f2 ff ff       	jmp    80105f7f <alltraps>

80106c8f <vector206>:
.globl vector206
vector206:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $206
80106c91:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106c96:	e9 e4 f2 ff ff       	jmp    80105f7f <alltraps>

80106c9b <vector207>:
.globl vector207
vector207:
  pushl $0
80106c9b:	6a 00                	push   $0x0
  pushl $207
80106c9d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106ca2:	e9 d8 f2 ff ff       	jmp    80105f7f <alltraps>

80106ca7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106ca7:	6a 00                	push   $0x0
  pushl $208
80106ca9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106cae:	e9 cc f2 ff ff       	jmp    80105f7f <alltraps>

80106cb3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $209
80106cb5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106cba:	e9 c0 f2 ff ff       	jmp    80105f7f <alltraps>

80106cbf <vector210>:
.globl vector210
vector210:
  pushl $0
80106cbf:	6a 00                	push   $0x0
  pushl $210
80106cc1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106cc6:	e9 b4 f2 ff ff       	jmp    80105f7f <alltraps>

80106ccb <vector211>:
.globl vector211
vector211:
  pushl $0
80106ccb:	6a 00                	push   $0x0
  pushl $211
80106ccd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106cd2:	e9 a8 f2 ff ff       	jmp    80105f7f <alltraps>

80106cd7 <vector212>:
.globl vector212
vector212:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $212
80106cd9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106cde:	e9 9c f2 ff ff       	jmp    80105f7f <alltraps>

80106ce3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106ce3:	6a 00                	push   $0x0
  pushl $213
80106ce5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106cea:	e9 90 f2 ff ff       	jmp    80105f7f <alltraps>

80106cef <vector214>:
.globl vector214
vector214:
  pushl $0
80106cef:	6a 00                	push   $0x0
  pushl $214
80106cf1:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106cf6:	e9 84 f2 ff ff       	jmp    80105f7f <alltraps>

80106cfb <vector215>:
.globl vector215
vector215:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $215
80106cfd:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106d02:	e9 78 f2 ff ff       	jmp    80105f7f <alltraps>

80106d07 <vector216>:
.globl vector216
vector216:
  pushl $0
80106d07:	6a 00                	push   $0x0
  pushl $216
80106d09:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106d0e:	e9 6c f2 ff ff       	jmp    80105f7f <alltraps>

80106d13 <vector217>:
.globl vector217
vector217:
  pushl $0
80106d13:	6a 00                	push   $0x0
  pushl $217
80106d15:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106d1a:	e9 60 f2 ff ff       	jmp    80105f7f <alltraps>

80106d1f <vector218>:
.globl vector218
vector218:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $218
80106d21:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106d26:	e9 54 f2 ff ff       	jmp    80105f7f <alltraps>

80106d2b <vector219>:
.globl vector219
vector219:
  pushl $0
80106d2b:	6a 00                	push   $0x0
  pushl $219
80106d2d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106d32:	e9 48 f2 ff ff       	jmp    80105f7f <alltraps>

80106d37 <vector220>:
.globl vector220
vector220:
  pushl $0
80106d37:	6a 00                	push   $0x0
  pushl $220
80106d39:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106d3e:	e9 3c f2 ff ff       	jmp    80105f7f <alltraps>

80106d43 <vector221>:
.globl vector221
vector221:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $221
80106d45:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106d4a:	e9 30 f2 ff ff       	jmp    80105f7f <alltraps>

80106d4f <vector222>:
.globl vector222
vector222:
  pushl $0
80106d4f:	6a 00                	push   $0x0
  pushl $222
80106d51:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106d56:	e9 24 f2 ff ff       	jmp    80105f7f <alltraps>

80106d5b <vector223>:
.globl vector223
vector223:
  pushl $0
80106d5b:	6a 00                	push   $0x0
  pushl $223
80106d5d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106d62:	e9 18 f2 ff ff       	jmp    80105f7f <alltraps>

80106d67 <vector224>:
.globl vector224
vector224:
  pushl $0
80106d67:	6a 00                	push   $0x0
  pushl $224
80106d69:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106d6e:	e9 0c f2 ff ff       	jmp    80105f7f <alltraps>

80106d73 <vector225>:
.globl vector225
vector225:
  pushl $0
80106d73:	6a 00                	push   $0x0
  pushl $225
80106d75:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106d7a:	e9 00 f2 ff ff       	jmp    80105f7f <alltraps>

80106d7f <vector226>:
.globl vector226
vector226:
  pushl $0
80106d7f:	6a 00                	push   $0x0
  pushl $226
80106d81:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106d86:	e9 f4 f1 ff ff       	jmp    80105f7f <alltraps>

80106d8b <vector227>:
.globl vector227
vector227:
  pushl $0
80106d8b:	6a 00                	push   $0x0
  pushl $227
80106d8d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106d92:	e9 e8 f1 ff ff       	jmp    80105f7f <alltraps>

80106d97 <vector228>:
.globl vector228
vector228:
  pushl $0
80106d97:	6a 00                	push   $0x0
  pushl $228
80106d99:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106d9e:	e9 dc f1 ff ff       	jmp    80105f7f <alltraps>

80106da3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106da3:	6a 00                	push   $0x0
  pushl $229
80106da5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106daa:	e9 d0 f1 ff ff       	jmp    80105f7f <alltraps>

80106daf <vector230>:
.globl vector230
vector230:
  pushl $0
80106daf:	6a 00                	push   $0x0
  pushl $230
80106db1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106db6:	e9 c4 f1 ff ff       	jmp    80105f7f <alltraps>

80106dbb <vector231>:
.globl vector231
vector231:
  pushl $0
80106dbb:	6a 00                	push   $0x0
  pushl $231
80106dbd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106dc2:	e9 b8 f1 ff ff       	jmp    80105f7f <alltraps>

80106dc7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106dc7:	6a 00                	push   $0x0
  pushl $232
80106dc9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106dce:	e9 ac f1 ff ff       	jmp    80105f7f <alltraps>

80106dd3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106dd3:	6a 00                	push   $0x0
  pushl $233
80106dd5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106dda:	e9 a0 f1 ff ff       	jmp    80105f7f <alltraps>

80106ddf <vector234>:
.globl vector234
vector234:
  pushl $0
80106ddf:	6a 00                	push   $0x0
  pushl $234
80106de1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106de6:	e9 94 f1 ff ff       	jmp    80105f7f <alltraps>

80106deb <vector235>:
.globl vector235
vector235:
  pushl $0
80106deb:	6a 00                	push   $0x0
  pushl $235
80106ded:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106df2:	e9 88 f1 ff ff       	jmp    80105f7f <alltraps>

80106df7 <vector236>:
.globl vector236
vector236:
  pushl $0
80106df7:	6a 00                	push   $0x0
  pushl $236
80106df9:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106dfe:	e9 7c f1 ff ff       	jmp    80105f7f <alltraps>

80106e03 <vector237>:
.globl vector237
vector237:
  pushl $0
80106e03:	6a 00                	push   $0x0
  pushl $237
80106e05:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106e0a:	e9 70 f1 ff ff       	jmp    80105f7f <alltraps>

80106e0f <vector238>:
.globl vector238
vector238:
  pushl $0
80106e0f:	6a 00                	push   $0x0
  pushl $238
80106e11:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106e16:	e9 64 f1 ff ff       	jmp    80105f7f <alltraps>

80106e1b <vector239>:
.globl vector239
vector239:
  pushl $0
80106e1b:	6a 00                	push   $0x0
  pushl $239
80106e1d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106e22:	e9 58 f1 ff ff       	jmp    80105f7f <alltraps>

80106e27 <vector240>:
.globl vector240
vector240:
  pushl $0
80106e27:	6a 00                	push   $0x0
  pushl $240
80106e29:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106e2e:	e9 4c f1 ff ff       	jmp    80105f7f <alltraps>

80106e33 <vector241>:
.globl vector241
vector241:
  pushl $0
80106e33:	6a 00                	push   $0x0
  pushl $241
80106e35:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106e3a:	e9 40 f1 ff ff       	jmp    80105f7f <alltraps>

80106e3f <vector242>:
.globl vector242
vector242:
  pushl $0
80106e3f:	6a 00                	push   $0x0
  pushl $242
80106e41:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106e46:	e9 34 f1 ff ff       	jmp    80105f7f <alltraps>

80106e4b <vector243>:
.globl vector243
vector243:
  pushl $0
80106e4b:	6a 00                	push   $0x0
  pushl $243
80106e4d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106e52:	e9 28 f1 ff ff       	jmp    80105f7f <alltraps>

80106e57 <vector244>:
.globl vector244
vector244:
  pushl $0
80106e57:	6a 00                	push   $0x0
  pushl $244
80106e59:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106e5e:	e9 1c f1 ff ff       	jmp    80105f7f <alltraps>

80106e63 <vector245>:
.globl vector245
vector245:
  pushl $0
80106e63:	6a 00                	push   $0x0
  pushl $245
80106e65:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106e6a:	e9 10 f1 ff ff       	jmp    80105f7f <alltraps>

80106e6f <vector246>:
.globl vector246
vector246:
  pushl $0
80106e6f:	6a 00                	push   $0x0
  pushl $246
80106e71:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106e76:	e9 04 f1 ff ff       	jmp    80105f7f <alltraps>

80106e7b <vector247>:
.globl vector247
vector247:
  pushl $0
80106e7b:	6a 00                	push   $0x0
  pushl $247
80106e7d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106e82:	e9 f8 f0 ff ff       	jmp    80105f7f <alltraps>

80106e87 <vector248>:
.globl vector248
vector248:
  pushl $0
80106e87:	6a 00                	push   $0x0
  pushl $248
80106e89:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106e8e:	e9 ec f0 ff ff       	jmp    80105f7f <alltraps>

80106e93 <vector249>:
.globl vector249
vector249:
  pushl $0
80106e93:	6a 00                	push   $0x0
  pushl $249
80106e95:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106e9a:	e9 e0 f0 ff ff       	jmp    80105f7f <alltraps>

80106e9f <vector250>:
.globl vector250
vector250:
  pushl $0
80106e9f:	6a 00                	push   $0x0
  pushl $250
80106ea1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106ea6:	e9 d4 f0 ff ff       	jmp    80105f7f <alltraps>

80106eab <vector251>:
.globl vector251
vector251:
  pushl $0
80106eab:	6a 00                	push   $0x0
  pushl $251
80106ead:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106eb2:	e9 c8 f0 ff ff       	jmp    80105f7f <alltraps>

80106eb7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106eb7:	6a 00                	push   $0x0
  pushl $252
80106eb9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106ebe:	e9 bc f0 ff ff       	jmp    80105f7f <alltraps>

80106ec3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106ec3:	6a 00                	push   $0x0
  pushl $253
80106ec5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106eca:	e9 b0 f0 ff ff       	jmp    80105f7f <alltraps>

80106ecf <vector254>:
.globl vector254
vector254:
  pushl $0
80106ecf:	6a 00                	push   $0x0
  pushl $254
80106ed1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ed6:	e9 a4 f0 ff ff       	jmp    80105f7f <alltraps>

80106edb <vector255>:
.globl vector255
vector255:
  pushl $0
80106edb:	6a 00                	push   $0x0
  pushl $255
80106edd:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106ee2:	e9 98 f0 ff ff       	jmp    80105f7f <alltraps>
80106ee7:	66 90                	xchg   %ax,%ax
80106ee9:	66 90                	xchg   %ax,%ax
80106eeb:	66 90                	xchg   %ax,%ax
80106eed:	66 90                	xchg   %ax,%ax
80106eef:	90                   	nop

80106ef0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	57                   	push   %edi
80106ef4:	56                   	push   %esi
80106ef5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106ef6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106efc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106f02:	83 ec 1c             	sub    $0x1c,%esp
80106f05:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106f08:	39 d3                	cmp    %edx,%ebx
80106f0a:	73 49                	jae    80106f55 <deallocuvm.part.0+0x65>
80106f0c:	89 c7                	mov    %eax,%edi
80106f0e:	eb 0c                	jmp    80106f1c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106f10:	83 c0 01             	add    $0x1,%eax
80106f13:	c1 e0 16             	shl    $0x16,%eax
80106f16:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106f18:	39 da                	cmp    %ebx,%edx
80106f1a:	76 39                	jbe    80106f55 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
80106f1c:	89 d8                	mov    %ebx,%eax
80106f1e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80106f21:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80106f24:	f6 c1 01             	test   $0x1,%cl
80106f27:	74 e7                	je     80106f10 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80106f29:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f2b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106f31:	c1 ee 0a             	shr    $0xa,%esi
80106f34:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
80106f3a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80106f41:	85 f6                	test   %esi,%esi
80106f43:	74 cb                	je     80106f10 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80106f45:	8b 06                	mov    (%esi),%eax
80106f47:	a8 01                	test   $0x1,%al
80106f49:	75 15                	jne    80106f60 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
80106f4b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f51:	39 da                	cmp    %ebx,%edx
80106f53:	77 c7                	ja     80106f1c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106f55:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106f58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f5b:	5b                   	pop    %ebx
80106f5c:	5e                   	pop    %esi
80106f5d:	5f                   	pop    %edi
80106f5e:	5d                   	pop    %ebp
80106f5f:	c3                   	ret    
      if(pa == 0)
80106f60:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f65:	74 25                	je     80106f8c <deallocuvm.part.0+0x9c>
      kfree(v);
80106f67:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106f6a:	05 00 00 00 80       	add    $0x80000000,%eax
80106f6f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106f72:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106f78:	50                   	push   %eax
80106f79:	e8 42 b5 ff ff       	call   801024c0 <kfree>
      *pte = 0;
80106f7e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80106f84:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106f87:	83 c4 10             	add    $0x10,%esp
80106f8a:	eb 8c                	jmp    80106f18 <deallocuvm.part.0+0x28>
        panic("kfree");
80106f8c:	83 ec 0c             	sub    $0xc,%esp
80106f8f:	68 46 7b 10 80       	push   $0x80107b46
80106f94:	e8 e7 93 ff ff       	call   80100380 <panic>
80106f99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106fa0 <mappages>:
{
80106fa0:	55                   	push   %ebp
80106fa1:	89 e5                	mov    %esp,%ebp
80106fa3:	57                   	push   %edi
80106fa4:	56                   	push   %esi
80106fa5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106fa6:	89 d3                	mov    %edx,%ebx
80106fa8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106fae:	83 ec 1c             	sub    $0x1c,%esp
80106fb1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106fb4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106fb8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106fbd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106fc0:	8b 45 08             	mov    0x8(%ebp),%eax
80106fc3:	29 d8                	sub    %ebx,%eax
80106fc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106fc8:	eb 3d                	jmp    80107007 <mappages+0x67>
80106fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106fd0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fd2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106fd7:	c1 ea 0a             	shr    $0xa,%edx
80106fda:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106fe0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106fe7:	85 c0                	test   %eax,%eax
80106fe9:	74 75                	je     80107060 <mappages+0xc0>
    if(*pte & PTE_P)
80106feb:	f6 00 01             	testb  $0x1,(%eax)
80106fee:	0f 85 86 00 00 00    	jne    8010707a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106ff4:	0b 75 0c             	or     0xc(%ebp),%esi
80106ff7:	83 ce 01             	or     $0x1,%esi
80106ffa:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106ffc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
80106fff:	74 6f                	je     80107070 <mappages+0xd0>
    a += PGSIZE;
80107001:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107007:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010700a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010700d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107010:	89 d8                	mov    %ebx,%eax
80107012:	c1 e8 16             	shr    $0x16,%eax
80107015:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107018:	8b 07                	mov    (%edi),%eax
8010701a:	a8 01                	test   $0x1,%al
8010701c:	75 b2                	jne    80106fd0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010701e:	e8 5d b6 ff ff       	call   80102680 <kalloc>
80107023:	85 c0                	test   %eax,%eax
80107025:	74 39                	je     80107060 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107027:	83 ec 04             	sub    $0x4,%esp
8010702a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010702d:	68 00 10 00 00       	push   $0x1000
80107032:	6a 00                	push   $0x0
80107034:	50                   	push   %eax
80107035:	e8 66 dc ff ff       	call   80104ca0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010703a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010703d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107040:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107046:	83 c8 07             	or     $0x7,%eax
80107049:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010704b:	89 d8                	mov    %ebx,%eax
8010704d:	c1 e8 0a             	shr    $0xa,%eax
80107050:	25 fc 0f 00 00       	and    $0xffc,%eax
80107055:	01 d0                	add    %edx,%eax
80107057:	eb 92                	jmp    80106feb <mappages+0x4b>
80107059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80107060:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107063:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107068:	5b                   	pop    %ebx
80107069:	5e                   	pop    %esi
8010706a:	5f                   	pop    %edi
8010706b:	5d                   	pop    %ebp
8010706c:	c3                   	ret    
8010706d:	8d 76 00             	lea    0x0(%esi),%esi
80107070:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107073:	31 c0                	xor    %eax,%eax
}
80107075:	5b                   	pop    %ebx
80107076:	5e                   	pop    %esi
80107077:	5f                   	pop    %edi
80107078:	5d                   	pop    %ebp
80107079:	c3                   	ret    
      panic("remap");
8010707a:	83 ec 0c             	sub    $0xc,%esp
8010707d:	68 d4 81 10 80       	push   $0x801081d4
80107082:	e8 f9 92 ff ff       	call   80100380 <panic>
80107087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010708e:	66 90                	xchg   %ax,%ax

80107090 <seginit>:
{
80107090:	55                   	push   %ebp
80107091:	89 e5                	mov    %esp,%ebp
80107093:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107096:	e8 d5 c8 ff ff       	call   80103970 <cpuid>
  pd[0] = size-1;
8010709b:	ba 2f 00 00 00       	mov    $0x2f,%edx
801070a0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801070a6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070aa:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
801070b1:	ff 00 00 
801070b4:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
801070bb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070be:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
801070c5:	ff 00 00 
801070c8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
801070cf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801070d2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801070d9:	ff 00 00 
801070dc:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
801070e3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801070e6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
801070ed:	ff 00 00 
801070f0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
801070f7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801070fa:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
801070ff:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107103:	c1 e8 10             	shr    $0x10,%eax
80107106:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010710a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010710d:	0f 01 10             	lgdtl  (%eax)
}
80107110:	c9                   	leave  
80107111:	c3                   	ret    
80107112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107120 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107120:	a1 c4 58 11 80       	mov    0x801158c4,%eax
80107125:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010712a:	0f 22 d8             	mov    %eax,%cr3
}
8010712d:	c3                   	ret    
8010712e:	66 90                	xchg   %ax,%ax

80107130 <switchuvm>:
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	57                   	push   %edi
80107134:	56                   	push   %esi
80107135:	53                   	push   %ebx
80107136:	83 ec 1c             	sub    $0x1c,%esp
80107139:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010713c:	85 f6                	test   %esi,%esi
8010713e:	0f 84 cb 00 00 00    	je     8010720f <switchuvm+0xdf>
  if(p->kstack == 0)
80107144:	8b 46 08             	mov    0x8(%esi),%eax
80107147:	85 c0                	test   %eax,%eax
80107149:	0f 84 da 00 00 00    	je     80107229 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010714f:	8b 46 04             	mov    0x4(%esi),%eax
80107152:	85 c0                	test   %eax,%eax
80107154:	0f 84 c2 00 00 00    	je     8010721c <switchuvm+0xec>
  pushcli();
8010715a:	e8 31 d9 ff ff       	call   80104a90 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010715f:	e8 ac c7 ff ff       	call   80103910 <mycpu>
80107164:	89 c3                	mov    %eax,%ebx
80107166:	e8 a5 c7 ff ff       	call   80103910 <mycpu>
8010716b:	89 c7                	mov    %eax,%edi
8010716d:	e8 9e c7 ff ff       	call   80103910 <mycpu>
80107172:	83 c7 08             	add    $0x8,%edi
80107175:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107178:	e8 93 c7 ff ff       	call   80103910 <mycpu>
8010717d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107180:	ba 67 00 00 00       	mov    $0x67,%edx
80107185:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010718c:	83 c0 08             	add    $0x8,%eax
8010718f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107196:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010719b:	83 c1 08             	add    $0x8,%ecx
8010719e:	c1 e8 18             	shr    $0x18,%eax
801071a1:	c1 e9 10             	shr    $0x10,%ecx
801071a4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801071aa:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801071b0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801071b5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071bc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801071c1:	e8 4a c7 ff ff       	call   80103910 <mycpu>
801071c6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071cd:	e8 3e c7 ff ff       	call   80103910 <mycpu>
801071d2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801071d6:	8b 5e 08             	mov    0x8(%esi),%ebx
801071d9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801071df:	e8 2c c7 ff ff       	call   80103910 <mycpu>
801071e4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801071e7:	e8 24 c7 ff ff       	call   80103910 <mycpu>
801071ec:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801071f0:	b8 28 00 00 00       	mov    $0x28,%eax
801071f5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801071f8:	8b 46 04             	mov    0x4(%esi),%eax
801071fb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107200:	0f 22 d8             	mov    %eax,%cr3
}
80107203:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107206:	5b                   	pop    %ebx
80107207:	5e                   	pop    %esi
80107208:	5f                   	pop    %edi
80107209:	5d                   	pop    %ebp
  popcli();
8010720a:	e9 d1 d8 ff ff       	jmp    80104ae0 <popcli>
    panic("switchuvm: no process");
8010720f:	83 ec 0c             	sub    $0xc,%esp
80107212:	68 da 81 10 80       	push   $0x801081da
80107217:	e8 64 91 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
8010721c:	83 ec 0c             	sub    $0xc,%esp
8010721f:	68 05 82 10 80       	push   $0x80108205
80107224:	e8 57 91 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107229:	83 ec 0c             	sub    $0xc,%esp
8010722c:	68 f0 81 10 80       	push   $0x801081f0
80107231:	e8 4a 91 ff ff       	call   80100380 <panic>
80107236:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010723d:	8d 76 00             	lea    0x0(%esi),%esi

80107240 <inituvm>:
{
80107240:	55                   	push   %ebp
80107241:	89 e5                	mov    %esp,%ebp
80107243:	57                   	push   %edi
80107244:	56                   	push   %esi
80107245:	53                   	push   %ebx
80107246:	83 ec 1c             	sub    $0x1c,%esp
80107249:	8b 45 0c             	mov    0xc(%ebp),%eax
8010724c:	8b 75 10             	mov    0x10(%ebp),%esi
8010724f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107252:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107255:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010725b:	77 4b                	ja     801072a8 <inituvm+0x68>
  mem = kalloc();
8010725d:	e8 1e b4 ff ff       	call   80102680 <kalloc>
  memset(mem, 0, PGSIZE);
80107262:	83 ec 04             	sub    $0x4,%esp
80107265:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010726a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010726c:	6a 00                	push   $0x0
8010726e:	50                   	push   %eax
8010726f:	e8 2c da ff ff       	call   80104ca0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107274:	58                   	pop    %eax
80107275:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010727b:	5a                   	pop    %edx
8010727c:	6a 06                	push   $0x6
8010727e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107283:	31 d2                	xor    %edx,%edx
80107285:	50                   	push   %eax
80107286:	89 f8                	mov    %edi,%eax
80107288:	e8 13 fd ff ff       	call   80106fa0 <mappages>
  memmove(mem, init, sz);
8010728d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107290:	89 75 10             	mov    %esi,0x10(%ebp)
80107293:	83 c4 10             	add    $0x10,%esp
80107296:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107299:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010729c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010729f:	5b                   	pop    %ebx
801072a0:	5e                   	pop    %esi
801072a1:	5f                   	pop    %edi
801072a2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801072a3:	e9 98 da ff ff       	jmp    80104d40 <memmove>
    panic("inituvm: more than a page");
801072a8:	83 ec 0c             	sub    $0xc,%esp
801072ab:	68 19 82 10 80       	push   $0x80108219
801072b0:	e8 cb 90 ff ff       	call   80100380 <panic>
801072b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801072c0 <loaduvm>:
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	57                   	push   %edi
801072c4:	56                   	push   %esi
801072c5:	53                   	push   %ebx
801072c6:	83 ec 1c             	sub    $0x1c,%esp
801072c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801072cc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801072cf:	a9 ff 0f 00 00       	test   $0xfff,%eax
801072d4:	0f 85 bb 00 00 00    	jne    80107395 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
801072da:	01 f0                	add    %esi,%eax
801072dc:	89 f3                	mov    %esi,%ebx
801072de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801072e1:	8b 45 14             	mov    0x14(%ebp),%eax
801072e4:	01 f0                	add    %esi,%eax
801072e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801072e9:	85 f6                	test   %esi,%esi
801072eb:	0f 84 87 00 00 00    	je     80107378 <loaduvm+0xb8>
801072f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801072f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801072fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801072fe:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107300:	89 c2                	mov    %eax,%edx
80107302:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107305:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107308:	f6 c2 01             	test   $0x1,%dl
8010730b:	75 13                	jne    80107320 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010730d:	83 ec 0c             	sub    $0xc,%esp
80107310:	68 33 82 10 80       	push   $0x80108233
80107315:	e8 66 90 ff ff       	call   80100380 <panic>
8010731a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107320:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107323:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107329:	25 fc 0f 00 00       	and    $0xffc,%eax
8010732e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107335:	85 c0                	test   %eax,%eax
80107337:	74 d4                	je     8010730d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107339:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010733b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010733e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107343:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107348:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010734e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107351:	29 d9                	sub    %ebx,%ecx
80107353:	05 00 00 00 80       	add    $0x80000000,%eax
80107358:	57                   	push   %edi
80107359:	51                   	push   %ecx
8010735a:	50                   	push   %eax
8010735b:	ff 75 10             	push   0x10(%ebp)
8010735e:	e8 2d a7 ff ff       	call   80101a90 <readi>
80107363:	83 c4 10             	add    $0x10,%esp
80107366:	39 f8                	cmp    %edi,%eax
80107368:	75 1e                	jne    80107388 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010736a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107370:	89 f0                	mov    %esi,%eax
80107372:	29 d8                	sub    %ebx,%eax
80107374:	39 c6                	cmp    %eax,%esi
80107376:	77 80                	ja     801072f8 <loaduvm+0x38>
}
80107378:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010737b:	31 c0                	xor    %eax,%eax
}
8010737d:	5b                   	pop    %ebx
8010737e:	5e                   	pop    %esi
8010737f:	5f                   	pop    %edi
80107380:	5d                   	pop    %ebp
80107381:	c3                   	ret    
80107382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107388:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010738b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107390:	5b                   	pop    %ebx
80107391:	5e                   	pop    %esi
80107392:	5f                   	pop    %edi
80107393:	5d                   	pop    %ebp
80107394:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107395:	83 ec 0c             	sub    $0xc,%esp
80107398:	68 d4 82 10 80       	push   $0x801082d4
8010739d:	e8 de 8f ff ff       	call   80100380 <panic>
801073a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073b0 <allocuvm>:
{
801073b0:	55                   	push   %ebp
801073b1:	89 e5                	mov    %esp,%ebp
801073b3:	57                   	push   %edi
801073b4:	56                   	push   %esi
801073b5:	53                   	push   %ebx
801073b6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801073b9:	8b 45 10             	mov    0x10(%ebp),%eax
{
801073bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801073bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073c2:	85 c0                	test   %eax,%eax
801073c4:	0f 88 b6 00 00 00    	js     80107480 <allocuvm+0xd0>
  if(newsz < oldsz)
801073ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
801073cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801073d0:	0f 82 9a 00 00 00    	jb     80107470 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801073d6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801073dc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801073e2:	39 75 10             	cmp    %esi,0x10(%ebp)
801073e5:	77 44                	ja     8010742b <allocuvm+0x7b>
801073e7:	e9 87 00 00 00       	jmp    80107473 <allocuvm+0xc3>
801073ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801073f0:	83 ec 04             	sub    $0x4,%esp
801073f3:	68 00 10 00 00       	push   $0x1000
801073f8:	6a 00                	push   $0x0
801073fa:	50                   	push   %eax
801073fb:	e8 a0 d8 ff ff       	call   80104ca0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107400:	58                   	pop    %eax
80107401:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107407:	5a                   	pop    %edx
80107408:	6a 06                	push   $0x6
8010740a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010740f:	89 f2                	mov    %esi,%edx
80107411:	50                   	push   %eax
80107412:	89 f8                	mov    %edi,%eax
80107414:	e8 87 fb ff ff       	call   80106fa0 <mappages>
80107419:	83 c4 10             	add    $0x10,%esp
8010741c:	85 c0                	test   %eax,%eax
8010741e:	78 78                	js     80107498 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107420:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107426:	39 75 10             	cmp    %esi,0x10(%ebp)
80107429:	76 48                	jbe    80107473 <allocuvm+0xc3>
    mem = kalloc();
8010742b:	e8 50 b2 ff ff       	call   80102680 <kalloc>
80107430:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107432:	85 c0                	test   %eax,%eax
80107434:	75 ba                	jne    801073f0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107436:	83 ec 0c             	sub    $0xc,%esp
80107439:	68 51 82 10 80       	push   $0x80108251
8010743e:	e8 5d 92 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107443:	8b 45 0c             	mov    0xc(%ebp),%eax
80107446:	83 c4 10             	add    $0x10,%esp
80107449:	39 45 10             	cmp    %eax,0x10(%ebp)
8010744c:	74 32                	je     80107480 <allocuvm+0xd0>
8010744e:	8b 55 10             	mov    0x10(%ebp),%edx
80107451:	89 c1                	mov    %eax,%ecx
80107453:	89 f8                	mov    %edi,%eax
80107455:	e8 96 fa ff ff       	call   80106ef0 <deallocuvm.part.0>
      return 0;
8010745a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107461:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107464:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107467:	5b                   	pop    %ebx
80107468:	5e                   	pop    %esi
80107469:	5f                   	pop    %edi
8010746a:	5d                   	pop    %ebp
8010746b:	c3                   	ret    
8010746c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107470:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107473:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107476:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107479:	5b                   	pop    %ebx
8010747a:	5e                   	pop    %esi
8010747b:	5f                   	pop    %edi
8010747c:	5d                   	pop    %ebp
8010747d:	c3                   	ret    
8010747e:	66 90                	xchg   %ax,%ax
    return 0;
80107480:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107487:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010748a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010748d:	5b                   	pop    %ebx
8010748e:	5e                   	pop    %esi
8010748f:	5f                   	pop    %edi
80107490:	5d                   	pop    %ebp
80107491:	c3                   	ret    
80107492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107498:	83 ec 0c             	sub    $0xc,%esp
8010749b:	68 69 82 10 80       	push   $0x80108269
801074a0:	e8 fb 91 ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
801074a5:	8b 45 0c             	mov    0xc(%ebp),%eax
801074a8:	83 c4 10             	add    $0x10,%esp
801074ab:	39 45 10             	cmp    %eax,0x10(%ebp)
801074ae:	74 0c                	je     801074bc <allocuvm+0x10c>
801074b0:	8b 55 10             	mov    0x10(%ebp),%edx
801074b3:	89 c1                	mov    %eax,%ecx
801074b5:	89 f8                	mov    %edi,%eax
801074b7:	e8 34 fa ff ff       	call   80106ef0 <deallocuvm.part.0>
      kfree(mem);
801074bc:	83 ec 0c             	sub    $0xc,%esp
801074bf:	53                   	push   %ebx
801074c0:	e8 fb af ff ff       	call   801024c0 <kfree>
      return 0;
801074c5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801074cc:	83 c4 10             	add    $0x10,%esp
}
801074cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801074d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074d5:	5b                   	pop    %ebx
801074d6:	5e                   	pop    %esi
801074d7:	5f                   	pop    %edi
801074d8:	5d                   	pop    %ebp
801074d9:	c3                   	ret    
801074da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074e0 <deallocuvm>:
{
801074e0:	55                   	push   %ebp
801074e1:	89 e5                	mov    %esp,%ebp
801074e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801074e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801074e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801074ec:	39 d1                	cmp    %edx,%ecx
801074ee:	73 10                	jae    80107500 <deallocuvm+0x20>
}
801074f0:	5d                   	pop    %ebp
801074f1:	e9 fa f9 ff ff       	jmp    80106ef0 <deallocuvm.part.0>
801074f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074fd:	8d 76 00             	lea    0x0(%esi),%esi
80107500:	89 d0                	mov    %edx,%eax
80107502:	5d                   	pop    %ebp
80107503:	c3                   	ret    
80107504:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010750b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010750f:	90                   	nop

80107510 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107510:	55                   	push   %ebp
80107511:	89 e5                	mov    %esp,%ebp
80107513:	57                   	push   %edi
80107514:	56                   	push   %esi
80107515:	53                   	push   %ebx
80107516:	83 ec 0c             	sub    $0xc,%esp
80107519:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010751c:	85 f6                	test   %esi,%esi
8010751e:	74 59                	je     80107579 <freevm+0x69>
  if(newsz >= oldsz)
80107520:	31 c9                	xor    %ecx,%ecx
80107522:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107527:	89 f0                	mov    %esi,%eax
80107529:	89 f3                	mov    %esi,%ebx
8010752b:	e8 c0 f9 ff ff       	call   80106ef0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107530:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107536:	eb 0f                	jmp    80107547 <freevm+0x37>
80107538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010753f:	90                   	nop
80107540:	83 c3 04             	add    $0x4,%ebx
80107543:	39 df                	cmp    %ebx,%edi
80107545:	74 23                	je     8010756a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107547:	8b 03                	mov    (%ebx),%eax
80107549:	a8 01                	test   $0x1,%al
8010754b:	74 f3                	je     80107540 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010754d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107552:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107555:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107558:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010755d:	50                   	push   %eax
8010755e:	e8 5d af ff ff       	call   801024c0 <kfree>
80107563:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107566:	39 df                	cmp    %ebx,%edi
80107568:	75 dd                	jne    80107547 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010756a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010756d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107570:	5b                   	pop    %ebx
80107571:	5e                   	pop    %esi
80107572:	5f                   	pop    %edi
80107573:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107574:	e9 47 af ff ff       	jmp    801024c0 <kfree>
    panic("freevm: no pgdir");
80107579:	83 ec 0c             	sub    $0xc,%esp
8010757c:	68 85 82 10 80       	push   $0x80108285
80107581:	e8 fa 8d ff ff       	call   80100380 <panic>
80107586:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010758d:	8d 76 00             	lea    0x0(%esi),%esi

80107590 <setupkvm>:
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	56                   	push   %esi
80107594:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107595:	e8 e6 b0 ff ff       	call   80102680 <kalloc>
8010759a:	89 c6                	mov    %eax,%esi
8010759c:	85 c0                	test   %eax,%eax
8010759e:	74 42                	je     801075e2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801075a0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075a3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
801075a8:	68 00 10 00 00       	push   $0x1000
801075ad:	6a 00                	push   $0x0
801075af:	50                   	push   %eax
801075b0:	e8 eb d6 ff ff       	call   80104ca0 <memset>
801075b5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801075b8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801075bb:	83 ec 08             	sub    $0x8,%esp
801075be:	8b 4b 08             	mov    0x8(%ebx),%ecx
801075c1:	ff 73 0c             	push   0xc(%ebx)
801075c4:	8b 13                	mov    (%ebx),%edx
801075c6:	50                   	push   %eax
801075c7:	29 c1                	sub    %eax,%ecx
801075c9:	89 f0                	mov    %esi,%eax
801075cb:	e8 d0 f9 ff ff       	call   80106fa0 <mappages>
801075d0:	83 c4 10             	add    $0x10,%esp
801075d3:	85 c0                	test   %eax,%eax
801075d5:	78 19                	js     801075f0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075d7:	83 c3 10             	add    $0x10,%ebx
801075da:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801075e0:	75 d6                	jne    801075b8 <setupkvm+0x28>
}
801075e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801075e5:	89 f0                	mov    %esi,%eax
801075e7:	5b                   	pop    %ebx
801075e8:	5e                   	pop    %esi
801075e9:	5d                   	pop    %ebp
801075ea:	c3                   	ret    
801075eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075ef:	90                   	nop
      freevm(pgdir);
801075f0:	83 ec 0c             	sub    $0xc,%esp
801075f3:	56                   	push   %esi
      return 0;
801075f4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801075f6:	e8 15 ff ff ff       	call   80107510 <freevm>
      return 0;
801075fb:	83 c4 10             	add    $0x10,%esp
}
801075fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107601:	89 f0                	mov    %esi,%eax
80107603:	5b                   	pop    %ebx
80107604:	5e                   	pop    %esi
80107605:	5d                   	pop    %ebp
80107606:	c3                   	ret    
80107607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010760e:	66 90                	xchg   %ax,%ax

80107610 <kvmalloc>:
{
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107616:	e8 75 ff ff ff       	call   80107590 <setupkvm>
8010761b:	a3 c4 58 11 80       	mov    %eax,0x801158c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107620:	05 00 00 00 80       	add    $0x80000000,%eax
80107625:	0f 22 d8             	mov    %eax,%cr3
}
80107628:	c9                   	leave  
80107629:	c3                   	ret    
8010762a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107630 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	83 ec 08             	sub    $0x8,%esp
80107636:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107639:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010763c:	89 c1                	mov    %eax,%ecx
8010763e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107641:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107644:	f6 c2 01             	test   $0x1,%dl
80107647:	75 17                	jne    80107660 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107649:	83 ec 0c             	sub    $0xc,%esp
8010764c:	68 96 82 10 80       	push   $0x80108296
80107651:	e8 2a 8d ff ff       	call   80100380 <panic>
80107656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010765d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107660:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107663:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107669:	25 fc 0f 00 00       	and    $0xffc,%eax
8010766e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107675:	85 c0                	test   %eax,%eax
80107677:	74 d0                	je     80107649 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107679:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010767c:	c9                   	leave  
8010767d:	c3                   	ret    
8010767e:	66 90                	xchg   %ax,%ax

80107680 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107680:	55                   	push   %ebp
80107681:	89 e5                	mov    %esp,%ebp
80107683:	57                   	push   %edi
80107684:	56                   	push   %esi
80107685:	53                   	push   %ebx
80107686:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107689:	e8 02 ff ff ff       	call   80107590 <setupkvm>
8010768e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107691:	85 c0                	test   %eax,%eax
80107693:	0f 84 bd 00 00 00    	je     80107756 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107699:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010769c:	85 c9                	test   %ecx,%ecx
8010769e:	0f 84 b2 00 00 00    	je     80107756 <copyuvm+0xd6>
801076a4:	31 f6                	xor    %esi,%esi
801076a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076ad:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
801076b0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801076b3:	89 f0                	mov    %esi,%eax
801076b5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801076b8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801076bb:	a8 01                	test   $0x1,%al
801076bd:	75 11                	jne    801076d0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801076bf:	83 ec 0c             	sub    $0xc,%esp
801076c2:	68 a0 82 10 80       	push   $0x801082a0
801076c7:	e8 b4 8c ff ff       	call   80100380 <panic>
801076cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801076d0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801076d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801076d7:	c1 ea 0a             	shr    $0xa,%edx
801076da:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801076e0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801076e7:	85 c0                	test   %eax,%eax
801076e9:	74 d4                	je     801076bf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801076eb:	8b 00                	mov    (%eax),%eax
801076ed:	a8 01                	test   $0x1,%al
801076ef:	0f 84 9f 00 00 00    	je     80107794 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801076f5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
801076f7:	25 ff 0f 00 00       	and    $0xfff,%eax
801076fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801076ff:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107705:	e8 76 af ff ff       	call   80102680 <kalloc>
8010770a:	89 c3                	mov    %eax,%ebx
8010770c:	85 c0                	test   %eax,%eax
8010770e:	74 64                	je     80107774 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107710:	83 ec 04             	sub    $0x4,%esp
80107713:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107719:	68 00 10 00 00       	push   $0x1000
8010771e:	57                   	push   %edi
8010771f:	50                   	push   %eax
80107720:	e8 1b d6 ff ff       	call   80104d40 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107725:	58                   	pop    %eax
80107726:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010772c:	5a                   	pop    %edx
8010772d:	ff 75 e4             	push   -0x1c(%ebp)
80107730:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107735:	89 f2                	mov    %esi,%edx
80107737:	50                   	push   %eax
80107738:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010773b:	e8 60 f8 ff ff       	call   80106fa0 <mappages>
80107740:	83 c4 10             	add    $0x10,%esp
80107743:	85 c0                	test   %eax,%eax
80107745:	78 21                	js     80107768 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107747:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010774d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107750:	0f 87 5a ff ff ff    	ja     801076b0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107756:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107759:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010775c:	5b                   	pop    %ebx
8010775d:	5e                   	pop    %esi
8010775e:	5f                   	pop    %edi
8010775f:	5d                   	pop    %ebp
80107760:	c3                   	ret    
80107761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107768:	83 ec 0c             	sub    $0xc,%esp
8010776b:	53                   	push   %ebx
8010776c:	e8 4f ad ff ff       	call   801024c0 <kfree>
      goto bad;
80107771:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107774:	83 ec 0c             	sub    $0xc,%esp
80107777:	ff 75 e0             	push   -0x20(%ebp)
8010777a:	e8 91 fd ff ff       	call   80107510 <freevm>
  return 0;
8010777f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107786:	83 c4 10             	add    $0x10,%esp
}
80107789:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010778c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010778f:	5b                   	pop    %ebx
80107790:	5e                   	pop    %esi
80107791:	5f                   	pop    %edi
80107792:	5d                   	pop    %ebp
80107793:	c3                   	ret    
      panic("copyuvm: page not present");
80107794:	83 ec 0c             	sub    $0xc,%esp
80107797:	68 ba 82 10 80       	push   $0x801082ba
8010779c:	e8 df 8b ff ff       	call   80100380 <panic>
801077a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077af:	90                   	nop

801077b0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801077b0:	55                   	push   %ebp
801077b1:	89 e5                	mov    %esp,%ebp
801077b3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801077b6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801077b9:	89 c1                	mov    %eax,%ecx
801077bb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801077be:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801077c1:	f6 c2 01             	test   $0x1,%dl
801077c4:	0f 84 00 01 00 00    	je     801078ca <uva2ka.cold>
  return &pgtab[PTX(va)];
801077ca:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801077cd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801077d3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801077d4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801077d9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
801077e0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801077e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
801077e7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
801077ea:	05 00 00 00 80       	add    $0x80000000,%eax
801077ef:	83 fa 05             	cmp    $0x5,%edx
801077f2:	ba 00 00 00 00       	mov    $0x0,%edx
801077f7:	0f 45 c2             	cmovne %edx,%eax
}
801077fa:	c3                   	ret    
801077fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077ff:	90                   	nop

80107800 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107800:	55                   	push   %ebp
80107801:	89 e5                	mov    %esp,%ebp
80107803:	57                   	push   %edi
80107804:	56                   	push   %esi
80107805:	53                   	push   %ebx
80107806:	83 ec 0c             	sub    $0xc,%esp
80107809:	8b 75 14             	mov    0x14(%ebp),%esi
8010780c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010780f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107812:	85 f6                	test   %esi,%esi
80107814:	75 51                	jne    80107867 <copyout+0x67>
80107816:	e9 a5 00 00 00       	jmp    801078c0 <copyout+0xc0>
8010781b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010781f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107820:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107826:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010782c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107832:	74 75                	je     801078a9 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107834:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107836:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107839:	29 c3                	sub    %eax,%ebx
8010783b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107841:	39 f3                	cmp    %esi,%ebx
80107843:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107846:	29 f8                	sub    %edi,%eax
80107848:	83 ec 04             	sub    $0x4,%esp
8010784b:	01 c1                	add    %eax,%ecx
8010784d:	53                   	push   %ebx
8010784e:	52                   	push   %edx
8010784f:	51                   	push   %ecx
80107850:	e8 eb d4 ff ff       	call   80104d40 <memmove>
    len -= n;
    buf += n;
80107855:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107858:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010785e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107861:	01 da                	add    %ebx,%edx
  while(len > 0){
80107863:	29 de                	sub    %ebx,%esi
80107865:	74 59                	je     801078c0 <copyout+0xc0>
  if(*pde & PTE_P){
80107867:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010786a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010786c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010786e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107871:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107877:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010787a:	f6 c1 01             	test   $0x1,%cl
8010787d:	0f 84 4e 00 00 00    	je     801078d1 <copyout.cold>
  return &pgtab[PTX(va)];
80107883:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107885:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010788b:	c1 eb 0c             	shr    $0xc,%ebx
8010788e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107894:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010789b:	89 d9                	mov    %ebx,%ecx
8010789d:	83 e1 05             	and    $0x5,%ecx
801078a0:	83 f9 05             	cmp    $0x5,%ecx
801078a3:	0f 84 77 ff ff ff    	je     80107820 <copyout+0x20>
  }
  return 0;
}
801078a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801078ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801078b1:	5b                   	pop    %ebx
801078b2:	5e                   	pop    %esi
801078b3:	5f                   	pop    %edi
801078b4:	5d                   	pop    %ebp
801078b5:	c3                   	ret    
801078b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078bd:	8d 76 00             	lea    0x0(%esi),%esi
801078c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801078c3:	31 c0                	xor    %eax,%eax
}
801078c5:	5b                   	pop    %ebx
801078c6:	5e                   	pop    %esi
801078c7:	5f                   	pop    %edi
801078c8:	5d                   	pop    %ebp
801078c9:	c3                   	ret    

801078ca <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801078ca:	a1 00 00 00 00       	mov    0x0,%eax
801078cf:	0f 0b                	ud2    

801078d1 <copyout.cold>:
801078d1:	a1 00 00 00 00       	mov    0x0,%eax
801078d6:	0f 0b                	ud2    
