
_thread_exit:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}

thread_t thread[NUM_THREAD];

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
  int i;
  printf(1, "Thread exit test start\n");
  for (i = 0; i < NUM_THREAD; i++) {
   e:	31 db                	xor    %ebx,%ebx
{
  10:	51                   	push   %ecx
  printf(1, "Thread exit test start\n");
  11:	83 ec 08             	sub    $0x8,%esp
  14:	68 d5 07 00 00       	push   $0x7d5
  19:	6a 01                	push   $0x1
  1b:	e8 70 04 00 00       	call   490 <printf>
  20:	83 c4 10             	add    $0x10,%esp
    thread_create(&thread[i], thread_main, (void *)i);
  23:	83 ec 04             	sub    $0x4,%esp
  26:	8d 04 9d 3c 0b 00 00 	lea    0xb3c(,%ebx,4),%eax
  2d:	53                   	push   %ebx
  for (i = 0; i < NUM_THREAD; i++) {
  2e:	83 c3 01             	add    $0x1,%ebx
    thread_create(&thread[i], thread_main, (void *)i);
  31:	68 70 00 00 00       	push   $0x70
  36:	50                   	push   %eax
  37:	e8 87 03 00 00       	call   3c3 <thread_create>
  for (i = 0; i < NUM_THREAD; i++) {
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	83 fb 05             	cmp    $0x5,%ebx
  42:	75 df                	jne    23 <main+0x23>
  }
  sleep(200);
  44:	83 ec 0c             	sub    $0xc,%esp
  47:	68 c8 00 00 00       	push   $0xc8
  4c:	e8 62 03 00 00       	call   3b3 <sleep>
  printf(1, "This code shouldn't be executed!!\n");
  51:	58                   	pop    %eax
  52:	5a                   	pop    %edx
  53:	68 f0 07 00 00       	push   $0x7f0
  58:	6a 01                	push   $0x1
  5a:	e8 31 04 00 00       	call   490 <printf>
  exit();
  5f:	e8 bf 02 00 00       	call   323 <exit>
  64:	66 90                	xchg   %ax,%ax
  66:	66 90                	xchg   %ax,%ax
  68:	66 90                	xchg   %ax,%ax
  6a:	66 90                	xchg   %ax,%ax
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <thread_main>:
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	83 ec 08             	sub    $0x8,%esp
  77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(1, "Thread %d start\n", val);
  7a:	53                   	push   %ebx
  7b:	68 b8 07 00 00       	push   $0x7b8
  80:	6a 01                	push   $0x1
  82:	e8 09 04 00 00       	call   490 <printf>
  if (arg == 0) {
  87:	83 c4 10             	add    $0x10,%esp
  8a:	85 db                	test   %ebx,%ebx
  8c:	74 20                	je     ae <thread_main+0x3e>
    sleep(200);
  8e:	83 ec 0c             	sub    $0xc,%esp
  91:	68 c8 00 00 00       	push   $0xc8
  96:	e8 18 03 00 00       	call   3b3 <sleep>
  printf(1, "This code shouldn't be executed!!\n");
  9b:	58                   	pop    %eax
  9c:	5a                   	pop    %edx
  9d:	68 f0 07 00 00       	push   $0x7f0
  a2:	6a 01                	push   $0x1
  a4:	e8 e7 03 00 00       	call   490 <printf>
  exit();
  a9:	e8 75 02 00 00       	call   323 <exit>
    sleep(100);
  ae:	83 ec 0c             	sub    $0xc,%esp
  b1:	6a 64                	push   $0x64
  b3:	e8 fb 02 00 00       	call   3b3 <sleep>
    printf(1, "Exiting...\n");
  b8:	59                   	pop    %ecx
  b9:	5b                   	pop    %ebx
  ba:	68 c9 07 00 00       	push   $0x7c9
  bf:	6a 01                	push   $0x1
  c1:	e8 ca 03 00 00       	call   490 <printf>
    exit();
  c6:	e8 58 02 00 00       	call   323 <exit>
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  d0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d1:	31 c0                	xor    %eax,%eax
{
  d3:	89 e5                	mov    %esp,%ebp
  d5:	53                   	push   %ebx
  d6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
  e0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  e4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  e7:	83 c0 01             	add    $0x1,%eax
  ea:	84 d2                	test   %dl,%dl
  ec:	75 f2                	jne    e0 <strcpy+0x10>
    ;
  return os;
}
  ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  f1:	89 c8                	mov    %ecx,%eax
  f3:	c9                   	leave  
  f4:	c3                   	ret    
  f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000100 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 55 08             	mov    0x8(%ebp),%edx
 107:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 10a:	0f b6 02             	movzbl (%edx),%eax
 10d:	84 c0                	test   %al,%al
 10f:	75 17                	jne    128 <strcmp+0x28>
 111:	eb 3a                	jmp    14d <strcmp+0x4d>
 113:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 117:	90                   	nop
 118:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 11c:	83 c2 01             	add    $0x1,%edx
 11f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 122:	84 c0                	test   %al,%al
 124:	74 1a                	je     140 <strcmp+0x40>
    p++, q++;
 126:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 128:	0f b6 19             	movzbl (%ecx),%ebx
 12b:	38 c3                	cmp    %al,%bl
 12d:	74 e9                	je     118 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 12f:	29 d8                	sub    %ebx,%eax
}
 131:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 134:	c9                   	leave  
 135:	c3                   	ret    
 136:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 140:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 144:	31 c0                	xor    %eax,%eax
 146:	29 d8                	sub    %ebx,%eax
}
 148:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 14b:	c9                   	leave  
 14c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 14d:	0f b6 19             	movzbl (%ecx),%ebx
 150:	31 c0                	xor    %eax,%eax
 152:	eb db                	jmp    12f <strcmp+0x2f>
 154:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 15f:	90                   	nop

00000160 <strlen>:

uint
strlen(const char *s)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 166:	80 3a 00             	cmpb   $0x0,(%edx)
 169:	74 15                	je     180 <strlen+0x20>
 16b:	31 c0                	xor    %eax,%eax
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	83 c0 01             	add    $0x1,%eax
 173:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 177:	89 c1                	mov    %eax,%ecx
 179:	75 f5                	jne    170 <strlen+0x10>
    ;
  return n;
}
 17b:	89 c8                	mov    %ecx,%eax
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    
 17f:	90                   	nop
  for(n = 0; s[n]; n++)
 180:	31 c9                	xor    %ecx,%ecx
}
 182:	5d                   	pop    %ebp
 183:	89 c8                	mov    %ecx,%eax
 185:	c3                   	ret    
 186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18d:	8d 76 00             	lea    0x0(%esi),%esi

00000190 <memset>:

void*
memset(void *dst, int c, uint n)
{
 190:	55                   	push   %ebp
 191:	89 e5                	mov    %esp,%ebp
 193:	57                   	push   %edi
 194:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 197:	8b 4d 10             	mov    0x10(%ebp),%ecx
 19a:	8b 45 0c             	mov    0xc(%ebp),%eax
 19d:	89 d7                	mov    %edx,%edi
 19f:	fc                   	cld    
 1a0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1a2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1a5:	89 d0                	mov    %edx,%eax
 1a7:	c9                   	leave  
 1a8:	c3                   	ret    
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001b0 <strchr>:

char*
strchr(const char *s, char c)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1ba:	0f b6 10             	movzbl (%eax),%edx
 1bd:	84 d2                	test   %dl,%dl
 1bf:	75 12                	jne    1d3 <strchr+0x23>
 1c1:	eb 1d                	jmp    1e0 <strchr+0x30>
 1c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1c7:	90                   	nop
 1c8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1cc:	83 c0 01             	add    $0x1,%eax
 1cf:	84 d2                	test   %dl,%dl
 1d1:	74 0d                	je     1e0 <strchr+0x30>
    if(*s == c)
 1d3:	38 d1                	cmp    %dl,%cl
 1d5:	75 f1                	jne    1c8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret    
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1e0:	31 c0                	xor    %eax,%eax
}
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1ef:	90                   	nop

000001f0 <gets>:

char*
gets(char *buf, int max)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 1f5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 1f8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 1f9:	31 db                	xor    %ebx,%ebx
{
 1fb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 1fe:	eb 27                	jmp    227 <gets+0x37>
    cc = read(0, &c, 1);
 200:	83 ec 04             	sub    $0x4,%esp
 203:	6a 01                	push   $0x1
 205:	57                   	push   %edi
 206:	6a 00                	push   $0x0
 208:	e8 2e 01 00 00       	call   33b <read>
    if(cc < 1)
 20d:	83 c4 10             	add    $0x10,%esp
 210:	85 c0                	test   %eax,%eax
 212:	7e 1d                	jle    231 <gets+0x41>
      break;
    buf[i++] = c;
 214:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 218:	8b 55 08             	mov    0x8(%ebp),%edx
 21b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 21f:	3c 0a                	cmp    $0xa,%al
 221:	74 1d                	je     240 <gets+0x50>
 223:	3c 0d                	cmp    $0xd,%al
 225:	74 19                	je     240 <gets+0x50>
  for(i=0; i+1 < max; ){
 227:	89 de                	mov    %ebx,%esi
 229:	83 c3 01             	add    $0x1,%ebx
 22c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 22f:	7c cf                	jl     200 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 238:	8d 65 f4             	lea    -0xc(%ebp),%esp
 23b:	5b                   	pop    %ebx
 23c:	5e                   	pop    %esi
 23d:	5f                   	pop    %edi
 23e:	5d                   	pop    %ebp
 23f:	c3                   	ret    
  buf[i] = '\0';
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	89 de                	mov    %ebx,%esi
 245:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 249:	8d 65 f4             	lea    -0xc(%ebp),%esp
 24c:	5b                   	pop    %ebx
 24d:	5e                   	pop    %esi
 24e:	5f                   	pop    %edi
 24f:	5d                   	pop    %ebp
 250:	c3                   	ret    
 251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 258:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 25f:	90                   	nop

00000260 <stat>:

int
stat(const char *n, struct stat *st)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	56                   	push   %esi
 264:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 265:	83 ec 08             	sub    $0x8,%esp
 268:	6a 00                	push   $0x0
 26a:	ff 75 08             	push   0x8(%ebp)
 26d:	e8 f1 00 00 00       	call   363 <open>
  if(fd < 0)
 272:	83 c4 10             	add    $0x10,%esp
 275:	85 c0                	test   %eax,%eax
 277:	78 27                	js     2a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	ff 75 0c             	push   0xc(%ebp)
 27f:	89 c3                	mov    %eax,%ebx
 281:	50                   	push   %eax
 282:	e8 f4 00 00 00       	call   37b <fstat>
  close(fd);
 287:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 28a:	89 c6                	mov    %eax,%esi
  close(fd);
 28c:	e8 ba 00 00 00       	call   34b <close>
  return r;
 291:	83 c4 10             	add    $0x10,%esp
}
 294:	8d 65 f8             	lea    -0x8(%ebp),%esp
 297:	89 f0                	mov    %esi,%eax
 299:	5b                   	pop    %ebx
 29a:	5e                   	pop    %esi
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret    
 29d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2a5:	eb ed                	jmp    294 <stat+0x34>
 2a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ae:	66 90                	xchg   %ax,%ax

000002b0 <atoi>:

int
atoi(const char *s)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	53                   	push   %ebx
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2b7:	0f be 02             	movsbl (%edx),%eax
 2ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2bd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2c0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2c5:	77 1e                	ja     2e5 <atoi+0x35>
 2c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ce:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2da:	0f be 02             	movsbl (%edx),%eax
 2dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2e0:	80 fb 09             	cmp    $0x9,%bl
 2e3:	76 eb                	jbe    2d0 <atoi+0x20>
  return n;
}
 2e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 2e8:	89 c8                	mov    %ecx,%eax
 2ea:	c9                   	leave  
 2eb:	c3                   	ret    
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	57                   	push   %edi
 2f4:	8b 45 10             	mov    0x10(%ebp),%eax
 2f7:	8b 55 08             	mov    0x8(%ebp),%edx
 2fa:	56                   	push   %esi
 2fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2fe:	85 c0                	test   %eax,%eax
 300:	7e 13                	jle    315 <memmove+0x25>
 302:	01 d0                	add    %edx,%eax
  dst = vdst;
 304:	89 d7                	mov    %edx,%edi
 306:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 310:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 311:	39 f8                	cmp    %edi,%eax
 313:	75 fb                	jne    310 <memmove+0x20>
  return vdst;
}
 315:	5e                   	pop    %esi
 316:	89 d0                	mov    %edx,%eax
 318:	5f                   	pop    %edi
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret    

0000031b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31b:	b8 01 00 00 00       	mov    $0x1,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <exit>:
SYSCALL(exit)
 323:	b8 02 00 00 00       	mov    $0x2,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <wait>:
SYSCALL(wait)
 32b:	b8 03 00 00 00       	mov    $0x3,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <pipe>:
SYSCALL(pipe)
 333:	b8 04 00 00 00       	mov    $0x4,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <read>:
SYSCALL(read)
 33b:	b8 05 00 00 00       	mov    $0x5,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <write>:
SYSCALL(write)
 343:	b8 10 00 00 00       	mov    $0x10,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <close>:
SYSCALL(close)
 34b:	b8 15 00 00 00       	mov    $0x15,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <kill>:
SYSCALL(kill)
 353:	b8 06 00 00 00       	mov    $0x6,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <exec>:
SYSCALL(exec)
 35b:	b8 07 00 00 00       	mov    $0x7,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <open>:
SYSCALL(open)
 363:	b8 0f 00 00 00       	mov    $0xf,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <mknod>:
SYSCALL(mknod)
 36b:	b8 11 00 00 00       	mov    $0x11,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <unlink>:
SYSCALL(unlink)
 373:	b8 12 00 00 00       	mov    $0x12,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <fstat>:
SYSCALL(fstat)
 37b:	b8 08 00 00 00       	mov    $0x8,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <link>:
SYSCALL(link)
 383:	b8 13 00 00 00       	mov    $0x13,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <mkdir>:
SYSCALL(mkdir)
 38b:	b8 14 00 00 00       	mov    $0x14,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <chdir>:
SYSCALL(chdir)
 393:	b8 09 00 00 00       	mov    $0x9,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <dup>:
SYSCALL(dup)
 39b:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <getpid>:
SYSCALL(getpid)
 3a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <sbrk>:
SYSCALL(sbrk)
 3ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <sleep>:
SYSCALL(sleep)
 3b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <uptime>:
SYSCALL(uptime)
 3bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <thread_create>:
SYSCALL(thread_create)
 3c3:	b8 16 00 00 00       	mov    $0x16,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <thread_exit>:
SYSCALL(thread_exit)
 3cb:	b8 17 00 00 00       	mov    $0x17,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <thread_join>:
SYSCALL(thread_join)
 3d3:	b8 18 00 00 00       	mov    $0x18,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    
 3db:	66 90                	xchg   %ax,%ax
 3dd:	66 90                	xchg   %ax,%ax
 3df:	90                   	nop

000003e0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	57                   	push   %edi
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 3c             	sub    $0x3c,%esp
 3e9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3ec:	89 d1                	mov    %edx,%ecx
{
 3ee:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3f1:	85 d2                	test   %edx,%edx
 3f3:	0f 89 7f 00 00 00    	jns    478 <printint+0x98>
 3f9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3fd:	74 79                	je     478 <printint+0x98>
    neg = 1;
 3ff:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 406:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 408:	31 db                	xor    %ebx,%ebx
 40a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 40d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 410:	89 c8                	mov    %ecx,%eax
 412:	31 d2                	xor    %edx,%edx
 414:	89 cf                	mov    %ecx,%edi
 416:	f7 75 c4             	divl   -0x3c(%ebp)
 419:	0f b6 92 74 08 00 00 	movzbl 0x874(%edx),%edx
 420:	89 45 c0             	mov    %eax,-0x40(%ebp)
 423:	89 d8                	mov    %ebx,%eax
 425:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 428:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 42b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 42e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 431:	76 dd                	jbe    410 <printint+0x30>
  if(neg)
 433:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 436:	85 c9                	test   %ecx,%ecx
 438:	74 0c                	je     446 <printint+0x66>
    buf[i++] = '-';
 43a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 43f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 441:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 446:	8b 7d b8             	mov    -0x48(%ebp),%edi
 449:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 44d:	eb 07                	jmp    456 <printint+0x76>
 44f:	90                   	nop
    putc(fd, buf[i]);
 450:	0f b6 13             	movzbl (%ebx),%edx
 453:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 456:	83 ec 04             	sub    $0x4,%esp
 459:	88 55 d7             	mov    %dl,-0x29(%ebp)
 45c:	6a 01                	push   $0x1
 45e:	56                   	push   %esi
 45f:	57                   	push   %edi
 460:	e8 de fe ff ff       	call   343 <write>
  while(--i >= 0)
 465:	83 c4 10             	add    $0x10,%esp
 468:	39 de                	cmp    %ebx,%esi
 46a:	75 e4                	jne    450 <printint+0x70>
}
 46c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 46f:	5b                   	pop    %ebx
 470:	5e                   	pop    %esi
 471:	5f                   	pop    %edi
 472:	5d                   	pop    %ebp
 473:	c3                   	ret    
 474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 478:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 47f:	eb 87                	jmp    408 <printint+0x28>
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop

00000490 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	57                   	push   %edi
 494:	56                   	push   %esi
 495:	53                   	push   %ebx
 496:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 499:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 49c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 49f:	0f b6 13             	movzbl (%ebx),%edx
 4a2:	84 d2                	test   %dl,%dl
 4a4:	74 6a                	je     510 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 4a6:	8d 45 10             	lea    0x10(%ebp),%eax
 4a9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 4ac:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 4af:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 4b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4b4:	eb 36                	jmp    4ec <printf+0x5c>
 4b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4bd:	8d 76 00             	lea    0x0(%esi),%esi
 4c0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4c3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 4c8:	83 f8 25             	cmp    $0x25,%eax
 4cb:	74 15                	je     4e2 <printf+0x52>
  write(fd, &c, 1);
 4cd:	83 ec 04             	sub    $0x4,%esp
 4d0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 4d3:	6a 01                	push   $0x1
 4d5:	57                   	push   %edi
 4d6:	56                   	push   %esi
 4d7:	e8 67 fe ff ff       	call   343 <write>
 4dc:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 4df:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4e2:	0f b6 13             	movzbl (%ebx),%edx
 4e5:	83 c3 01             	add    $0x1,%ebx
 4e8:	84 d2                	test   %dl,%dl
 4ea:	74 24                	je     510 <printf+0x80>
    c = fmt[i] & 0xff;
 4ec:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 4ef:	85 c9                	test   %ecx,%ecx
 4f1:	74 cd                	je     4c0 <printf+0x30>
      }
    } else if(state == '%'){
 4f3:	83 f9 25             	cmp    $0x25,%ecx
 4f6:	75 ea                	jne    4e2 <printf+0x52>
      if(c == 'd'){
 4f8:	83 f8 25             	cmp    $0x25,%eax
 4fb:	0f 84 07 01 00 00    	je     608 <printf+0x178>
 501:	83 e8 63             	sub    $0x63,%eax
 504:	83 f8 15             	cmp    $0x15,%eax
 507:	77 17                	ja     520 <printf+0x90>
 509:	ff 24 85 1c 08 00 00 	jmp    *0x81c(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 510:	8d 65 f4             	lea    -0xc(%ebp),%esp
 513:	5b                   	pop    %ebx
 514:	5e                   	pop    %esi
 515:	5f                   	pop    %edi
 516:	5d                   	pop    %ebp
 517:	c3                   	ret    
 518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 51f:	90                   	nop
  write(fd, &c, 1);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 526:	6a 01                	push   $0x1
 528:	57                   	push   %edi
 529:	56                   	push   %esi
 52a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 52e:	e8 10 fe ff ff       	call   343 <write>
        putc(fd, c);
 533:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 537:	83 c4 0c             	add    $0xc,%esp
 53a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 53d:	6a 01                	push   $0x1
 53f:	57                   	push   %edi
 540:	56                   	push   %esi
 541:	e8 fd fd ff ff       	call   343 <write>
        putc(fd, c);
 546:	83 c4 10             	add    $0x10,%esp
      state = 0;
 549:	31 c9                	xor    %ecx,%ecx
 54b:	eb 95                	jmp    4e2 <printf+0x52>
 54d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	b9 10 00 00 00       	mov    $0x10,%ecx
 558:	6a 00                	push   $0x0
 55a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 55d:	8b 10                	mov    (%eax),%edx
 55f:	89 f0                	mov    %esi,%eax
 561:	e8 7a fe ff ff       	call   3e0 <printint>
        ap++;
 566:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 56a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 56d:	31 c9                	xor    %ecx,%ecx
 56f:	e9 6e ff ff ff       	jmp    4e2 <printf+0x52>
 574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 578:	8b 45 d0             	mov    -0x30(%ebp),%eax
 57b:	8b 10                	mov    (%eax),%edx
        ap++;
 57d:	83 c0 04             	add    $0x4,%eax
 580:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 583:	85 d2                	test   %edx,%edx
 585:	0f 84 8d 00 00 00    	je     618 <printf+0x188>
        while(*s != 0){
 58b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 58e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 590:	84 c0                	test   %al,%al
 592:	0f 84 4a ff ff ff    	je     4e2 <printf+0x52>
 598:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 59b:	89 d3                	mov    %edx,%ebx
 59d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5a3:	83 c3 01             	add    $0x1,%ebx
 5a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	57                   	push   %edi
 5ac:	56                   	push   %esi
 5ad:	e8 91 fd ff ff       	call   343 <write>
        while(*s != 0){
 5b2:	0f b6 03             	movzbl (%ebx),%eax
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	84 c0                	test   %al,%al
 5ba:	75 e4                	jne    5a0 <printf+0x110>
      state = 0;
 5bc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 5bf:	31 c9                	xor    %ecx,%ecx
 5c1:	e9 1c ff ff ff       	jmp    4e2 <printf+0x52>
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5d8:	6a 01                	push   $0x1
 5da:	e9 7b ff ff ff       	jmp    55a <printf+0xca>
 5df:	90                   	nop
        putc(fd, *ap);
 5e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 5e3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5e6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 5e8:	6a 01                	push   $0x1
 5ea:	57                   	push   %edi
 5eb:	56                   	push   %esi
        putc(fd, *ap);
 5ec:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5ef:	e8 4f fd ff ff       	call   343 <write>
        ap++;
 5f4:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 5f8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5fb:	31 c9                	xor    %ecx,%ecx
 5fd:	e9 e0 fe ff ff       	jmp    4e2 <printf+0x52>
 602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 608:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 60b:	83 ec 04             	sub    $0x4,%esp
 60e:	e9 2a ff ff ff       	jmp    53d <printf+0xad>
 613:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 617:	90                   	nop
          s = "(null)";
 618:	ba 13 08 00 00       	mov    $0x813,%edx
        while(*s != 0){
 61d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 620:	b8 28 00 00 00       	mov    $0x28,%eax
 625:	89 d3                	mov    %edx,%ebx
 627:	e9 74 ff ff ff       	jmp    5a0 <printf+0x110>
 62c:	66 90                	xchg   %ax,%ax
 62e:	66 90                	xchg   %ax,%ax

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 631:	a1 50 0b 00 00       	mov    0xb50,%eax
{
 636:	89 e5                	mov    %esp,%ebp
 638:	57                   	push   %edi
 639:	56                   	push   %esi
 63a:	53                   	push   %ebx
 63b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 63e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 648:	89 c2                	mov    %eax,%edx
 64a:	8b 00                	mov    (%eax),%eax
 64c:	39 ca                	cmp    %ecx,%edx
 64e:	73 30                	jae    680 <free+0x50>
 650:	39 c1                	cmp    %eax,%ecx
 652:	72 04                	jb     658 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 654:	39 c2                	cmp    %eax,%edx
 656:	72 f0                	jb     648 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 658:	8b 73 fc             	mov    -0x4(%ebx),%esi
 65b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65e:	39 f8                	cmp    %edi,%eax
 660:	74 30                	je     692 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 662:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 665:	8b 42 04             	mov    0x4(%edx),%eax
 668:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 66b:	39 f1                	cmp    %esi,%ecx
 66d:	74 3a                	je     6a9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 66f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 671:	5b                   	pop    %ebx
  freep = p;
 672:	89 15 50 0b 00 00    	mov    %edx,0xb50
}
 678:	5e                   	pop    %esi
 679:	5f                   	pop    %edi
 67a:	5d                   	pop    %ebp
 67b:	c3                   	ret    
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 680:	39 c2                	cmp    %eax,%edx
 682:	72 c4                	jb     648 <free+0x18>
 684:	39 c1                	cmp    %eax,%ecx
 686:	73 c0                	jae    648 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 688:	8b 73 fc             	mov    -0x4(%ebx),%esi
 68b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68e:	39 f8                	cmp    %edi,%eax
 690:	75 d0                	jne    662 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 692:	03 70 04             	add    0x4(%eax),%esi
 695:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 698:	8b 02                	mov    (%edx),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 69f:	8b 42 04             	mov    0x4(%edx),%eax
 6a2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 6a5:	39 f1                	cmp    %esi,%ecx
 6a7:	75 c6                	jne    66f <free+0x3f>
    p->s.size += bp->s.size;
 6a9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 6ac:	89 15 50 0b 00 00    	mov    %edx,0xb50
    p->s.size += bp->s.size;
 6b2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 6b5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6b8:	89 0a                	mov    %ecx,(%edx)
}
 6ba:	5b                   	pop    %ebx
 6bb:	5e                   	pop    %esi
 6bc:	5f                   	pop    %edi
 6bd:	5d                   	pop    %ebp
 6be:	c3                   	ret    
 6bf:	90                   	nop

000006c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c0:	55                   	push   %ebp
 6c1:	89 e5                	mov    %esp,%ebp
 6c3:	57                   	push   %edi
 6c4:	56                   	push   %esi
 6c5:	53                   	push   %ebx
 6c6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6cc:	8b 3d 50 0b 00 00    	mov    0xb50,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d2:	8d 70 07             	lea    0x7(%eax),%esi
 6d5:	c1 ee 03             	shr    $0x3,%esi
 6d8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6db:	85 ff                	test   %edi,%edi
 6dd:	0f 84 9d 00 00 00    	je     780 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 6e5:	8b 4a 04             	mov    0x4(%edx),%ecx
 6e8:	39 f1                	cmp    %esi,%ecx
 6ea:	73 6a                	jae    756 <malloc+0x96>
 6ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6f1:	39 de                	cmp    %ebx,%esi
 6f3:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 6f6:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 6fd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 700:	eb 17                	jmp    719 <malloc+0x59>
 702:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 708:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 70a:	8b 48 04             	mov    0x4(%eax),%ecx
 70d:	39 f1                	cmp    %esi,%ecx
 70f:	73 4f                	jae    760 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 711:	8b 3d 50 0b 00 00    	mov    0xb50,%edi
 717:	89 c2                	mov    %eax,%edx
 719:	39 d7                	cmp    %edx,%edi
 71b:	75 eb                	jne    708 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 71d:	83 ec 0c             	sub    $0xc,%esp
 720:	ff 75 e4             	push   -0x1c(%ebp)
 723:	e8 83 fc ff ff       	call   3ab <sbrk>
  if(p == (char*)-1)
 728:	83 c4 10             	add    $0x10,%esp
 72b:	83 f8 ff             	cmp    $0xffffffff,%eax
 72e:	74 1c                	je     74c <malloc+0x8c>
  hp->s.size = nu;
 730:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	83 c0 08             	add    $0x8,%eax
 739:	50                   	push   %eax
 73a:	e8 f1 fe ff ff       	call   630 <free>
  return freep;
 73f:	8b 15 50 0b 00 00    	mov    0xb50,%edx
      if((p = morecore(nunits)) == 0)
 745:	83 c4 10             	add    $0x10,%esp
 748:	85 d2                	test   %edx,%edx
 74a:	75 bc                	jne    708 <malloc+0x48>
        return 0;
  }
}
 74c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 74f:	31 c0                	xor    %eax,%eax
}
 751:	5b                   	pop    %ebx
 752:	5e                   	pop    %esi
 753:	5f                   	pop    %edi
 754:	5d                   	pop    %ebp
 755:	c3                   	ret    
    if(p->s.size >= nunits){
 756:	89 d0                	mov    %edx,%eax
 758:	89 fa                	mov    %edi,%edx
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 760:	39 ce                	cmp    %ecx,%esi
 762:	74 4c                	je     7b0 <malloc+0xf0>
        p->s.size -= nunits;
 764:	29 f1                	sub    %esi,%ecx
 766:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 769:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 76c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 76f:	89 15 50 0b 00 00    	mov    %edx,0xb50
}
 775:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 778:	83 c0 08             	add    $0x8,%eax
}
 77b:	5b                   	pop    %ebx
 77c:	5e                   	pop    %esi
 77d:	5f                   	pop    %edi
 77e:	5d                   	pop    %ebp
 77f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 780:	c7 05 50 0b 00 00 54 	movl   $0xb54,0xb50
 787:	0b 00 00 
    base.s.size = 0;
 78a:	bf 54 0b 00 00       	mov    $0xb54,%edi
    base.s.ptr = freep = prevp = &base;
 78f:	c7 05 54 0b 00 00 54 	movl   $0xb54,0xb54
 796:	0b 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 799:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 79b:	c7 05 58 0b 00 00 00 	movl   $0x0,0xb58
 7a2:	00 00 00 
    if(p->s.size >= nunits){
 7a5:	e9 42 ff ff ff       	jmp    6ec <malloc+0x2c>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7b0:	8b 08                	mov    (%eax),%ecx
 7b2:	89 0a                	mov    %ecx,(%edx)
 7b4:	eb b9                	jmp    76f <malloc+0xaf>
