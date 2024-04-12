
_project02:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"


int main(int argc, char *argv[]){
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	83 e4 f0             	and    $0xfffffff0,%esp


	exit();
   a:	e8 64 02 00 00       	call   273 <exit>
   f:	90                   	nop

00000010 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  10:	f3 0f 1e fb          	endbr32 
  14:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  15:	31 c0                	xor    %eax,%eax
{
  17:	89 e5                	mov    %esp,%ebp
  19:	53                   	push   %ebx
  1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  1d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  20:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  24:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  27:	83 c0 01             	add    $0x1,%eax
  2a:	84 d2                	test   %dl,%dl
  2c:	75 f2                	jne    20 <strcpy+0x10>
    ;
  return os;
}
  2e:	89 c8                	mov    %ecx,%eax
  30:	5b                   	pop    %ebx
  31:	5d                   	pop    %ebp
  32:	c3                   	ret    
  33:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	f3 0f 1e fb          	endbr32 
  44:	55                   	push   %ebp
  45:	89 e5                	mov    %esp,%ebp
  47:	53                   	push   %ebx
  48:	8b 4d 08             	mov    0x8(%ebp),%ecx
  4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  4e:	0f b6 01             	movzbl (%ecx),%eax
  51:	0f b6 1a             	movzbl (%edx),%ebx
  54:	84 c0                	test   %al,%al
  56:	75 19                	jne    71 <strcmp+0x31>
  58:	eb 26                	jmp    80 <strcmp+0x40>
  5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  60:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
  64:	83 c1 01             	add    $0x1,%ecx
  67:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  6a:	0f b6 1a             	movzbl (%edx),%ebx
  6d:	84 c0                	test   %al,%al
  6f:	74 0f                	je     80 <strcmp+0x40>
  71:	38 d8                	cmp    %bl,%al
  73:	74 eb                	je     60 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  75:	29 d8                	sub    %ebx,%eax
}
  77:	5b                   	pop    %ebx
  78:	5d                   	pop    %ebp
  79:	c3                   	ret    
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  82:	29 d8                	sub    %ebx,%eax
}
  84:	5b                   	pop    %ebx
  85:	5d                   	pop    %ebp
  86:	c3                   	ret    
  87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8e:	66 90                	xchg   %ax,%ax

00000090 <strlen>:

uint
strlen(const char *s)
{
  90:	f3 0f 1e fb          	endbr32 
  94:	55                   	push   %ebp
  95:	89 e5                	mov    %esp,%ebp
  97:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  9a:	80 3a 00             	cmpb   $0x0,(%edx)
  9d:	74 21                	je     c0 <strlen+0x30>
  9f:	31 c0                	xor    %eax,%eax
  a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a8:	83 c0 01             	add    $0x1,%eax
  ab:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  af:	89 c1                	mov    %eax,%ecx
  b1:	75 f5                	jne    a8 <strlen+0x18>
    ;
  return n;
}
  b3:	89 c8                	mov    %ecx,%eax
  b5:	5d                   	pop    %ebp
  b6:	c3                   	ret    
  b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  be:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
  c0:	31 c9                	xor    %ecx,%ecx
}
  c2:	5d                   	pop    %ebp
  c3:	89 c8                	mov    %ecx,%eax
  c5:	c3                   	ret    
  c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  cd:	8d 76 00             	lea    0x0(%esi),%esi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	f3 0f 1e fb          	endbr32 
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  db:	8b 4d 10             	mov    0x10(%ebp),%ecx
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	89 d7                	mov    %edx,%edi
  e3:	fc                   	cld    
  e4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e6:	89 d0                	mov    %edx,%eax
  e8:	5f                   	pop    %edi
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ef:	90                   	nop

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
  fa:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  fe:	0f b6 10             	movzbl (%eax),%edx
 101:	84 d2                	test   %dl,%dl
 103:	75 16                	jne    11b <strchr+0x2b>
 105:	eb 21                	jmp    128 <strchr+0x38>
 107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 10e:	66 90                	xchg   %ax,%ax
 110:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 114:	83 c0 01             	add    $0x1,%eax
 117:	84 d2                	test   %dl,%dl
 119:	74 0d                	je     128 <strchr+0x38>
    if(*s == c)
 11b:	38 d1                	cmp    %dl,%cl
 11d:	75 f1                	jne    110 <strchr+0x20>
      return (char*)s;
  return 0;
}
 11f:	5d                   	pop    %ebp
 120:	c3                   	ret    
 121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 128:	31 c0                	xor    %eax,%eax
}
 12a:	5d                   	pop    %ebp
 12b:	c3                   	ret    
 12c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	f3 0f 1e fb          	endbr32 
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	57                   	push   %edi
 138:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 139:	31 f6                	xor    %esi,%esi
{
 13b:	53                   	push   %ebx
 13c:	89 f3                	mov    %esi,%ebx
 13e:	83 ec 1c             	sub    $0x1c,%esp
 141:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 144:	eb 33                	jmp    179 <gets+0x49>
 146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14d:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 150:	83 ec 04             	sub    $0x4,%esp
 153:	8d 45 e7             	lea    -0x19(%ebp),%eax
 156:	6a 01                	push   $0x1
 158:	50                   	push   %eax
 159:	6a 00                	push   $0x0
 15b:	e8 2b 01 00 00       	call   28b <read>
    if(cc < 1)
 160:	83 c4 10             	add    $0x10,%esp
 163:	85 c0                	test   %eax,%eax
 165:	7e 1c                	jle    183 <gets+0x53>
      break;
    buf[i++] = c;
 167:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 16b:	83 c7 01             	add    $0x1,%edi
 16e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 171:	3c 0a                	cmp    $0xa,%al
 173:	74 23                	je     198 <gets+0x68>
 175:	3c 0d                	cmp    $0xd,%al
 177:	74 1f                	je     198 <gets+0x68>
  for(i=0; i+1 < max; ){
 179:	83 c3 01             	add    $0x1,%ebx
 17c:	89 fe                	mov    %edi,%esi
 17e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 181:	7c cd                	jl     150 <gets+0x20>
 183:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 185:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 188:	c6 03 00             	movb   $0x0,(%ebx)
}
 18b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 18e:	5b                   	pop    %ebx
 18f:	5e                   	pop    %esi
 190:	5f                   	pop    %edi
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 197:	90                   	nop
 198:	8b 75 08             	mov    0x8(%ebp),%esi
 19b:	8b 45 08             	mov    0x8(%ebp),%eax
 19e:	01 de                	add    %ebx,%esi
 1a0:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1a2:	c6 03 00             	movb   $0x0,(%ebx)
}
 1a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1a8:	5b                   	pop    %ebx
 1a9:	5e                   	pop    %esi
 1aa:	5f                   	pop    %edi
 1ab:	5d                   	pop    %ebp
 1ac:	c3                   	ret    
 1ad:	8d 76 00             	lea    0x0(%esi),%esi

000001b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b0:	f3 0f 1e fb          	endbr32 
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	56                   	push   %esi
 1b8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b9:	83 ec 08             	sub    $0x8,%esp
 1bc:	6a 00                	push   $0x0
 1be:	ff 75 08             	pushl  0x8(%ebp)
 1c1:	e8 ed 00 00 00       	call   2b3 <open>
  if(fd < 0)
 1c6:	83 c4 10             	add    $0x10,%esp
 1c9:	85 c0                	test   %eax,%eax
 1cb:	78 2b                	js     1f8 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 1cd:	83 ec 08             	sub    $0x8,%esp
 1d0:	ff 75 0c             	pushl  0xc(%ebp)
 1d3:	89 c3                	mov    %eax,%ebx
 1d5:	50                   	push   %eax
 1d6:	e8 f0 00 00 00       	call   2cb <fstat>
  close(fd);
 1db:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1de:	89 c6                	mov    %eax,%esi
  close(fd);
 1e0:	e8 b6 00 00 00       	call   29b <close>
  return r;
 1e5:	83 c4 10             	add    $0x10,%esp
}
 1e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1eb:	89 f0                	mov    %esi,%eax
 1ed:	5b                   	pop    %ebx
 1ee:	5e                   	pop    %esi
 1ef:	5d                   	pop    %ebp
 1f0:	c3                   	ret    
 1f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 1f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1fd:	eb e9                	jmp    1e8 <stat+0x38>
 1ff:	90                   	nop

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	f3 0f 1e fb          	endbr32 
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	53                   	push   %ebx
 208:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 20b:	0f be 02             	movsbl (%edx),%eax
 20e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 211:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 214:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 219:	77 1a                	ja     235 <atoi+0x35>
 21b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 21f:	90                   	nop
    n = n*10 + *s++ - '0';
 220:	83 c2 01             	add    $0x1,%edx
 223:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 226:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 22a:	0f be 02             	movsbl (%edx),%eax
 22d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	89 c8                	mov    %ecx,%eax
 237:	5b                   	pop    %ebx
 238:	5d                   	pop    %ebp
 239:	c3                   	ret    
 23a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	f3 0f 1e fb          	endbr32 
 244:	55                   	push   %ebp
 245:	89 e5                	mov    %esp,%ebp
 247:	57                   	push   %edi
 248:	8b 45 10             	mov    0x10(%ebp),%eax
 24b:	8b 55 08             	mov    0x8(%ebp),%edx
 24e:	56                   	push   %esi
 24f:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 252:	85 c0                	test   %eax,%eax
 254:	7e 0f                	jle    265 <memmove+0x25>
 256:	01 d0                	add    %edx,%eax
  dst = vdst;
 258:	89 d7                	mov    %edx,%edi
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 260:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 261:	39 f8                	cmp    %edi,%eax
 263:	75 fb                	jne    260 <memmove+0x20>
  return vdst;
}
 265:	5e                   	pop    %esi
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    

0000026b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26b:	b8 01 00 00 00       	mov    $0x1,%eax
 270:	cd 40                	int    $0x40
 272:	c3                   	ret    

00000273 <exit>:
SYSCALL(exit)
 273:	b8 02 00 00 00       	mov    $0x2,%eax
 278:	cd 40                	int    $0x40
 27a:	c3                   	ret    

0000027b <wait>:
SYSCALL(wait)
 27b:	b8 03 00 00 00       	mov    $0x3,%eax
 280:	cd 40                	int    $0x40
 282:	c3                   	ret    

00000283 <pipe>:
SYSCALL(pipe)
 283:	b8 04 00 00 00       	mov    $0x4,%eax
 288:	cd 40                	int    $0x40
 28a:	c3                   	ret    

0000028b <read>:
SYSCALL(read)
 28b:	b8 05 00 00 00       	mov    $0x5,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <write>:
SYSCALL(write)
 293:	b8 10 00 00 00       	mov    $0x10,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <close>:
SYSCALL(close)
 29b:	b8 15 00 00 00       	mov    $0x15,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <kill>:
SYSCALL(kill)
 2a3:	b8 06 00 00 00       	mov    $0x6,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <exec>:
SYSCALL(exec)
 2ab:	b8 07 00 00 00       	mov    $0x7,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <open>:
SYSCALL(open)
 2b3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <mknod>:
SYSCALL(mknod)
 2bb:	b8 11 00 00 00       	mov    $0x11,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <unlink>:
SYSCALL(unlink)
 2c3:	b8 12 00 00 00       	mov    $0x12,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <fstat>:
SYSCALL(fstat)
 2cb:	b8 08 00 00 00       	mov    $0x8,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <link>:
SYSCALL(link)
 2d3:	b8 13 00 00 00       	mov    $0x13,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <mkdir>:
SYSCALL(mkdir)
 2db:	b8 14 00 00 00       	mov    $0x14,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <chdir>:
SYSCALL(chdir)
 2e3:	b8 09 00 00 00       	mov    $0x9,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <dup>:
SYSCALL(dup)
 2eb:	b8 0a 00 00 00       	mov    $0xa,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <getpid>:
SYSCALL(getpid)
 2f3:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <sbrk>:
SYSCALL(sbrk)
 2fb:	b8 0c 00 00 00       	mov    $0xc,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <sleep>:
SYSCALL(sleep)
 303:	b8 0d 00 00 00       	mov    $0xd,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <uptime>:
SYSCALL(uptime)
 30b:	b8 0e 00 00 00       	mov    $0xe,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <yield>:
SYSCALL(yield)
 313:	b8 16 00 00 00       	mov    $0x16,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <getlev>:
SYSCALL(getlev)
 31b:	b8 17 00 00 00       	mov    $0x17,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <setpriority>:
SYSCALL(setpriority)
 323:	b8 18 00 00 00       	mov    $0x18,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <setmonopoly>:
SYSCALL(setmonopoly)
 32b:	b8 19 00 00 00       	mov    $0x19,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <monopolize>:
SYSCALL(monopolize)
 333:	b8 1a 00 00 00       	mov    $0x1a,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <unmonopolize>:
SYSCALL(unmonopolize)
 33b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    
 343:	66 90                	xchg   %ax,%ax
 345:	66 90                	xchg   %ax,%ax
 347:	66 90                	xchg   %ax,%ax
 349:	66 90                	xchg   %ax,%ax
 34b:	66 90                	xchg   %ax,%ax
 34d:	66 90                	xchg   %ax,%ax
 34f:	90                   	nop

00000350 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 3c             	sub    $0x3c,%esp
 359:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 35c:	89 d1                	mov    %edx,%ecx
{
 35e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 361:	85 d2                	test   %edx,%edx
 363:	0f 89 7f 00 00 00    	jns    3e8 <printint+0x98>
 369:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 36d:	74 79                	je     3e8 <printint+0x98>
    neg = 1;
 36f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 376:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 378:	31 db                	xor    %ebx,%ebx
 37a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 380:	89 c8                	mov    %ecx,%eax
 382:	31 d2                	xor    %edx,%edx
 384:	89 cf                	mov    %ecx,%edi
 386:	f7 75 c4             	divl   -0x3c(%ebp)
 389:	0f b6 92 70 07 00 00 	movzbl 0x770(%edx),%edx
 390:	89 45 c0             	mov    %eax,-0x40(%ebp)
 393:	89 d8                	mov    %ebx,%eax
 395:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 398:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 39b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 39e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 3a1:	76 dd                	jbe    380 <printint+0x30>
  if(neg)
 3a3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 3a6:	85 c9                	test   %ecx,%ecx
 3a8:	74 0c                	je     3b6 <printint+0x66>
    buf[i++] = '-';
 3aa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 3af:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 3b1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 3b6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3b9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 3bd:	eb 07                	jmp    3c6 <printint+0x76>
 3bf:	90                   	nop
 3c0:	0f b6 13             	movzbl (%ebx),%edx
 3c3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 3c6:	83 ec 04             	sub    $0x4,%esp
 3c9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3cc:	6a 01                	push   $0x1
 3ce:	56                   	push   %esi
 3cf:	57                   	push   %edi
 3d0:	e8 be fe ff ff       	call   293 <write>
  while(--i >= 0)
 3d5:	83 c4 10             	add    $0x10,%esp
 3d8:	39 de                	cmp    %ebx,%esi
 3da:	75 e4                	jne    3c0 <printint+0x70>
    putc(fd, buf[i]);
}
 3dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3df:	5b                   	pop    %ebx
 3e0:	5e                   	pop    %esi
 3e1:	5f                   	pop    %edi
 3e2:	5d                   	pop    %ebp
 3e3:	c3                   	ret    
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 3e8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 3ef:	eb 87                	jmp    378 <printint+0x28>
 3f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ff:	90                   	nop

00000400 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 400:	f3 0f 1e fb          	endbr32 
 404:	55                   	push   %ebp
 405:	89 e5                	mov    %esp,%ebp
 407:	57                   	push   %edi
 408:	56                   	push   %esi
 409:	53                   	push   %ebx
 40a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 40d:	8b 75 0c             	mov    0xc(%ebp),%esi
 410:	0f b6 1e             	movzbl (%esi),%ebx
 413:	84 db                	test   %bl,%bl
 415:	0f 84 b4 00 00 00    	je     4cf <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 41b:	8d 45 10             	lea    0x10(%ebp),%eax
 41e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 421:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 424:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 426:	89 45 d0             	mov    %eax,-0x30(%ebp)
 429:	eb 33                	jmp    45e <printf+0x5e>
 42b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 42f:	90                   	nop
 430:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 433:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 438:	83 f8 25             	cmp    $0x25,%eax
 43b:	74 17                	je     454 <printf+0x54>
  write(fd, &c, 1);
 43d:	83 ec 04             	sub    $0x4,%esp
 440:	88 5d e7             	mov    %bl,-0x19(%ebp)
 443:	6a 01                	push   $0x1
 445:	57                   	push   %edi
 446:	ff 75 08             	pushl  0x8(%ebp)
 449:	e8 45 fe ff ff       	call   293 <write>
 44e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 451:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 454:	0f b6 1e             	movzbl (%esi),%ebx
 457:	83 c6 01             	add    $0x1,%esi
 45a:	84 db                	test   %bl,%bl
 45c:	74 71                	je     4cf <printf+0xcf>
    c = fmt[i] & 0xff;
 45e:	0f be cb             	movsbl %bl,%ecx
 461:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 464:	85 d2                	test   %edx,%edx
 466:	74 c8                	je     430 <printf+0x30>
      }
    } else if(state == '%'){
 468:	83 fa 25             	cmp    $0x25,%edx
 46b:	75 e7                	jne    454 <printf+0x54>
      if(c == 'd'){
 46d:	83 f8 64             	cmp    $0x64,%eax
 470:	0f 84 9a 00 00 00    	je     510 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 476:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 47c:	83 f9 70             	cmp    $0x70,%ecx
 47f:	74 5f                	je     4e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 481:	83 f8 73             	cmp    $0x73,%eax
 484:	0f 84 d6 00 00 00    	je     560 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 48a:	83 f8 63             	cmp    $0x63,%eax
 48d:	0f 84 8d 00 00 00    	je     520 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 493:	83 f8 25             	cmp    $0x25,%eax
 496:	0f 84 b4 00 00 00    	je     550 <printf+0x150>
  write(fd, &c, 1);
 49c:	83 ec 04             	sub    $0x4,%esp
 49f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4a3:	6a 01                	push   $0x1
 4a5:	57                   	push   %edi
 4a6:	ff 75 08             	pushl  0x8(%ebp)
 4a9:	e8 e5 fd ff ff       	call   293 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 4ae:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4b1:	83 c4 0c             	add    $0xc,%esp
 4b4:	6a 01                	push   $0x1
 4b6:	83 c6 01             	add    $0x1,%esi
 4b9:	57                   	push   %edi
 4ba:	ff 75 08             	pushl  0x8(%ebp)
 4bd:	e8 d1 fd ff ff       	call   293 <write>
  for(i = 0; fmt[i]; i++){
 4c2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 4c6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 4c9:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 4cb:	84 db                	test   %bl,%bl
 4cd:	75 8f                	jne    45e <printf+0x5e>
    }
  }
}
 4cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4d2:	5b                   	pop    %ebx
 4d3:	5e                   	pop    %esi
 4d4:	5f                   	pop    %edi
 4d5:	5d                   	pop    %ebp
 4d6:	c3                   	ret    
 4d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4de:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 4e0:	83 ec 0c             	sub    $0xc,%esp
 4e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4e8:	6a 00                	push   $0x0
 4ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4ed:	8b 45 08             	mov    0x8(%ebp),%eax
 4f0:	8b 13                	mov    (%ebx),%edx
 4f2:	e8 59 fe ff ff       	call   350 <printint>
        ap++;
 4f7:	89 d8                	mov    %ebx,%eax
 4f9:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4fc:	31 d2                	xor    %edx,%edx
        ap++;
 4fe:	83 c0 04             	add    $0x4,%eax
 501:	89 45 d0             	mov    %eax,-0x30(%ebp)
 504:	e9 4b ff ff ff       	jmp    454 <printf+0x54>
 509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 510:	83 ec 0c             	sub    $0xc,%esp
 513:	b9 0a 00 00 00       	mov    $0xa,%ecx
 518:	6a 01                	push   $0x1
 51a:	eb ce                	jmp    4ea <printf+0xea>
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 520:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 523:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 526:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 528:	6a 01                	push   $0x1
        ap++;
 52a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 52d:	57                   	push   %edi
 52e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 531:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 534:	e8 5a fd ff ff       	call   293 <write>
        ap++;
 539:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 53c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 53f:	31 d2                	xor    %edx,%edx
 541:	e9 0e ff ff ff       	jmp    454 <printf+0x54>
 546:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54d:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 550:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 553:	83 ec 04             	sub    $0x4,%esp
 556:	e9 59 ff ff ff       	jmp    4b4 <printf+0xb4>
 55b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 55f:	90                   	nop
        s = (char*)*ap;
 560:	8b 45 d0             	mov    -0x30(%ebp),%eax
 563:	8b 18                	mov    (%eax),%ebx
        ap++;
 565:	83 c0 04             	add    $0x4,%eax
 568:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 56b:	85 db                	test   %ebx,%ebx
 56d:	74 17                	je     586 <printf+0x186>
        while(*s != 0){
 56f:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 572:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 574:	84 c0                	test   %al,%al
 576:	0f 84 d8 fe ff ff    	je     454 <printf+0x54>
 57c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 57f:	89 de                	mov    %ebx,%esi
 581:	8b 5d 08             	mov    0x8(%ebp),%ebx
 584:	eb 1a                	jmp    5a0 <printf+0x1a0>
          s = "(null)";
 586:	bb 68 07 00 00       	mov    $0x768,%ebx
        while(*s != 0){
 58b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 58e:	b8 28 00 00 00       	mov    $0x28,%eax
 593:	89 de                	mov    %ebx,%esi
 595:	8b 5d 08             	mov    0x8(%ebp),%ebx
 598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59f:	90                   	nop
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
          s++;
 5a3:	83 c6 01             	add    $0x1,%esi
 5a6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a9:	6a 01                	push   $0x1
 5ab:	57                   	push   %edi
 5ac:	53                   	push   %ebx
 5ad:	e8 e1 fc ff ff       	call   293 <write>
        while(*s != 0){
 5b2:	0f b6 06             	movzbl (%esi),%eax
 5b5:	83 c4 10             	add    $0x10,%esp
 5b8:	84 c0                	test   %al,%al
 5ba:	75 e4                	jne    5a0 <printf+0x1a0>
 5bc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 5bf:	31 d2                	xor    %edx,%edx
 5c1:	e9 8e fe ff ff       	jmp    454 <printf+0x54>
 5c6:	66 90                	xchg   %ax,%ax
 5c8:	66 90                	xchg   %ax,%ax
 5ca:	66 90                	xchg   %ax,%ax
 5cc:	66 90                	xchg   %ax,%ax
 5ce:	66 90                	xchg   %ax,%ax

000005d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d0:	f3 0f 1e fb          	endbr32 
 5d4:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d5:	a1 10 0a 00 00       	mov    0xa10,%eax
{
 5da:	89 e5                	mov    %esp,%ebp
 5dc:	57                   	push   %edi
 5dd:	56                   	push   %esi
 5de:	53                   	push   %ebx
 5df:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5e2:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 5e4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e7:	39 c8                	cmp    %ecx,%eax
 5e9:	73 15                	jae    600 <free+0x30>
 5eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
 5f0:	39 d1                	cmp    %edx,%ecx
 5f2:	72 14                	jb     608 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f4:	39 d0                	cmp    %edx,%eax
 5f6:	73 10                	jae    608 <free+0x38>
{
 5f8:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5fa:	8b 10                	mov    (%eax),%edx
 5fc:	39 c8                	cmp    %ecx,%eax
 5fe:	72 f0                	jb     5f0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 600:	39 d0                	cmp    %edx,%eax
 602:	72 f4                	jb     5f8 <free+0x28>
 604:	39 d1                	cmp    %edx,%ecx
 606:	73 f0                	jae    5f8 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 608:	8b 73 fc             	mov    -0x4(%ebx),%esi
 60b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 60e:	39 fa                	cmp    %edi,%edx
 610:	74 1e                	je     630 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 612:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 615:	8b 50 04             	mov    0x4(%eax),%edx
 618:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 61b:	39 f1                	cmp    %esi,%ecx
 61d:	74 28                	je     647 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 61f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 621:	5b                   	pop    %ebx
  freep = p;
 622:	a3 10 0a 00 00       	mov    %eax,0xa10
}
 627:	5e                   	pop    %esi
 628:	5f                   	pop    %edi
 629:	5d                   	pop    %ebp
 62a:	c3                   	ret    
 62b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 62f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 630:	03 72 04             	add    0x4(%edx),%esi
 633:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 636:	8b 10                	mov    (%eax),%edx
 638:	8b 12                	mov    (%edx),%edx
 63a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 63d:	8b 50 04             	mov    0x4(%eax),%edx
 640:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 643:	39 f1                	cmp    %esi,%ecx
 645:	75 d8                	jne    61f <free+0x4f>
    p->s.size += bp->s.size;
 647:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 64a:	a3 10 0a 00 00       	mov    %eax,0xa10
    p->s.size += bp->s.size;
 64f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 652:	8b 53 f8             	mov    -0x8(%ebx),%edx
 655:	89 10                	mov    %edx,(%eax)
}
 657:	5b                   	pop    %ebx
 658:	5e                   	pop    %esi
 659:	5f                   	pop    %edi
 65a:	5d                   	pop    %ebp
 65b:	c3                   	ret    
 65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000660 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 660:	f3 0f 1e fb          	endbr32 
 664:	55                   	push   %ebp
 665:	89 e5                	mov    %esp,%ebp
 667:	57                   	push   %edi
 668:	56                   	push   %esi
 669:	53                   	push   %ebx
 66a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 66d:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 670:	8b 3d 10 0a 00 00    	mov    0xa10,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 676:	8d 70 07             	lea    0x7(%eax),%esi
 679:	c1 ee 03             	shr    $0x3,%esi
 67c:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 67f:	85 ff                	test   %edi,%edi
 681:	0f 84 a9 00 00 00    	je     730 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 687:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 689:	8b 48 04             	mov    0x4(%eax),%ecx
 68c:	39 f1                	cmp    %esi,%ecx
 68e:	73 6d                	jae    6fd <malloc+0x9d>
 690:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 696:	bb 00 10 00 00       	mov    $0x1000,%ebx
 69b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 69e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6a5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6a8:	eb 17                	jmp    6c1 <malloc+0x61>
 6aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6b0:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 6b2:	8b 4a 04             	mov    0x4(%edx),%ecx
 6b5:	39 f1                	cmp    %esi,%ecx
 6b7:	73 4f                	jae    708 <malloc+0xa8>
 6b9:	8b 3d 10 0a 00 00    	mov    0xa10,%edi
 6bf:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6c1:	39 c7                	cmp    %eax,%edi
 6c3:	75 eb                	jne    6b0 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 6c5:	83 ec 0c             	sub    $0xc,%esp
 6c8:	ff 75 e4             	pushl  -0x1c(%ebp)
 6cb:	e8 2b fc ff ff       	call   2fb <sbrk>
  if(p == (char*)-1)
 6d0:	83 c4 10             	add    $0x10,%esp
 6d3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6d6:	74 1b                	je     6f3 <malloc+0x93>
  hp->s.size = nu;
 6d8:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6db:	83 ec 0c             	sub    $0xc,%esp
 6de:	83 c0 08             	add    $0x8,%eax
 6e1:	50                   	push   %eax
 6e2:	e8 e9 fe ff ff       	call   5d0 <free>
  return freep;
 6e7:	a1 10 0a 00 00       	mov    0xa10,%eax
      if((p = morecore(nunits)) == 0)
 6ec:	83 c4 10             	add    $0x10,%esp
 6ef:	85 c0                	test   %eax,%eax
 6f1:	75 bd                	jne    6b0 <malloc+0x50>
        return 0;
  }
}
 6f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 6f6:	31 c0                	xor    %eax,%eax
}
 6f8:	5b                   	pop    %ebx
 6f9:	5e                   	pop    %esi
 6fa:	5f                   	pop    %edi
 6fb:	5d                   	pop    %ebp
 6fc:	c3                   	ret    
    if(p->s.size >= nunits){
 6fd:	89 c2                	mov    %eax,%edx
 6ff:	89 f8                	mov    %edi,%eax
 701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 708:	39 ce                	cmp    %ecx,%esi
 70a:	74 54                	je     760 <malloc+0x100>
        p->s.size -= nunits;
 70c:	29 f1                	sub    %esi,%ecx
 70e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 711:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 714:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 717:	a3 10 0a 00 00       	mov    %eax,0xa10
}
 71c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 71f:	8d 42 08             	lea    0x8(%edx),%eax
}
 722:	5b                   	pop    %ebx
 723:	5e                   	pop    %esi
 724:	5f                   	pop    %edi
 725:	5d                   	pop    %ebp
 726:	c3                   	ret    
 727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 72e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 730:	c7 05 10 0a 00 00 14 	movl   $0xa14,0xa10
 737:	0a 00 00 
    base.s.size = 0;
 73a:	bf 14 0a 00 00       	mov    $0xa14,%edi
    base.s.ptr = freep = prevp = &base;
 73f:	c7 05 14 0a 00 00 14 	movl   $0xa14,0xa14
 746:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 749:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 74b:	c7 05 18 0a 00 00 00 	movl   $0x0,0xa18
 752:	00 00 00 
    if(p->s.size >= nunits){
 755:	e9 36 ff ff ff       	jmp    690 <malloc+0x30>
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 760:	8b 0a                	mov    (%edx),%ecx
 762:	89 08                	mov    %ecx,(%eax)
 764:	eb b1                	jmp    717 <malloc+0xb7>
