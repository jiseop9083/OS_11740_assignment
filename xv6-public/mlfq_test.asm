
_mlfq_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
		exit();
	while(wait() != -1);
}

int main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
   e:	53                   	push   %ebx
   f:	51                   	push   %ecx
  10:	83 ec 2c             	sub    $0x2c,%esp
	int i, pid;
	int count[MAX_LEVEL] = {0};
  13:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  1a:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
  21:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  28:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  2f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)

	parent = getpid();
  36:	e8 58 07 00 00       	call   793 <getpid>

	printf(1, "MLFQ test start\n");
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	68 fa 0b 00 00       	push   $0xbfa
  43:	6a 01                	push   $0x1
	parent = getpid();
  45:	a3 b0 10 00 00       	mov    %eax,0x10b0
	printf(1, "MLFQ test start\n");
  4a:	e8 51 08 00 00       	call   8a0 <printf>

	printf(1, "[Test 1] default\n");
  4f:	5e                   	pop    %esi
  50:	58                   	pop    %eax
  51:	68 0b 0c 00 00       	push   $0xc0b
  56:	6a 01                	push   $0x1
  58:	e8 43 08 00 00       	call   8a0 <printf>
	pid = fork_children();
  5d:	e8 ce 02 00 00       	call   330 <fork_children>

	if(pid != parent)
  62:	83 c4 10             	add    $0x10,%esp
  65:	39 05 b0 10 00 00    	cmp    %eax,0x10b0
  6b:	74 7d                	je     ea <main+0xea>
  6d:	89 c6                	mov    %eax,%esi
  6f:	bb a0 86 01 00       	mov    $0x186a0,%ebx
  74:	eb 1c                	jmp    92 <main+0x92>
  76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  7d:	8d 76 00             	lea    0x0(%esi),%esi
		for(i = 0; i < NUM_LOOP; i++)
		{
			int x = getlev();
			if(x < 0 || x > 3)
			{
				if(x != 99){
  80:	83 f8 63             	cmp    $0x63,%eax
  83:	0f 85 c7 00 00 00    	jne    150 <main+0x150>
					printf(1, "Wrong level: %d\n", x);
					exit();
				}
			}
			if(x == 99) count[4]++;
  89:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
		for(i = 0; i < NUM_LOOP; i++)
  8d:	83 eb 01             	sub    $0x1,%ebx
  90:	74 14                	je     a6 <main+0xa6>
			int x = getlev();
  92:	e8 24 07 00 00       	call   7bb <getlev>
			if(x < 0 || x > 3)
  97:	83 f8 03             	cmp    $0x3,%eax
  9a:	77 e4                	ja     80 <main+0x80>
			else count[x]++;
  9c:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
		for(i = 0; i < NUM_LOOP; i++)
  a1:	83 eb 01             	sub    $0x1,%ebx
  a4:	75 ec                	jne    92 <main+0x92>
		}
		printf(1, "Process %d\n", pid);
  a6:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
  a7:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
  a9:	56                   	push   %esi
  aa:	8d 75 d4             	lea    -0x2c(%ebp),%esi
  ad:	68 2e 0c 00 00       	push   $0xc2e
  b2:	6a 01                	push   $0x1
  b4:	e8 e7 07 00 00       	call   8a0 <printf>
  b9:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
  bc:	ff 34 9e             	push   (%esi,%ebx,4)
  bf:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
  c0:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
  c3:	68 3a 0c 00 00       	push   $0xc3a
  c8:	6a 01                	push   $0x1
  ca:	e8 d1 07 00 00       	call   8a0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
  cf:	83 c4 10             	add    $0x10,%esp
  d2:	83 fb 04             	cmp    $0x4,%ebx
  d5:	75 e5                	jne    bc <main+0xbc>
		printf(1, "MoQ: %d\n", count[4]);
  d7:	51                   	push   %ecx
  d8:	ff 75 e4             	push   -0x1c(%ebp)
  db:	68 43 0c 00 00       	push   $0xc43
  e0:	6a 01                	push   $0x1
  e2:	e8 b9 07 00 00       	call   8a0 <printf>
  e7:	83 c4 10             	add    $0x10,%esp
	}
	exit_children();
  ea:	e8 a1 03 00 00       	call   490 <exit_children>
	printf(1, "[Test 1] finished\n");
  ef:	56                   	push   %esi
  f0:	56                   	push   %esi
  f1:	68 4c 0c 00 00       	push   $0xc4c
  f6:	6a 01                	push   $0x1
  f8:	e8 a3 07 00 00       	call   8a0 <printf>

	printf(1, "[Test 2] priorities\n");
  fd:	58                   	pop    %eax
  fe:	5a                   	pop    %edx
  ff:	68 5f 0c 00 00       	push   $0xc5f
 104:	6a 01                	push   $0x1
 106:	e8 95 07 00 00       	call   8a0 <printf>
	pid = fork_children2();
 10b:	e8 70 02 00 00       	call   380 <fork_children2>

	if(pid != parent)
 110:	83 c4 10             	add    $0x10,%esp
	pid = fork_children2();
 113:	89 c6                	mov    %eax,%esi
	if(pid != parent)
 115:	39 05 b0 10 00 00    	cmp    %eax,0x10b0
 11b:	0f 84 88 00 00 00    	je     1a9 <main+0x1a9>
 121:	bb a0 86 01 00       	mov    $0x186a0,%ebx
 126:	eb 16                	jmp    13e <main+0x13e>
 128:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12f:	90                   	nop
		for(i = 0; i < NUM_LOOP; i++)
		{
			int x = getlev();
			if(x < 0 || x > 3)
			{
				if(x != 99){
 130:	83 f8 63             	cmp    $0x63,%eax
 133:	75 1b                	jne    150 <main+0x150>
					printf(1, "Wrong level: %d\n", x);
					exit();
				}
			}
			if(x == 99) count[4]++;
 135:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
		for(i = 0; i < NUM_LOOP; i++)
 139:	83 eb 01             	sub    $0x1,%ebx
 13c:	74 27                	je     165 <main+0x165>
			int x = getlev();
 13e:	e8 78 06 00 00       	call   7bb <getlev>
			if(x < 0 || x > 3)
 143:	83 f8 03             	cmp    $0x3,%eax
 146:	77 e8                	ja     130 <main+0x130>
			else count[x]++;
 148:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
 14d:	eb ea                	jmp    139 <main+0x139>
 14f:	90                   	nop
			int x = getlev();
			if(x < 0 || x > 3)
			{
				if(x != 99)
				{
					printf(1, "Wrong level: %d\n", x);
 150:	83 ec 04             	sub    $0x4,%esp
 153:	50                   	push   %eax
 154:	68 1d 0c 00 00       	push   $0xc1d
 159:	6a 01                	push   $0x1
 15b:	e8 40 07 00 00       	call   8a0 <printf>
					exit();
 160:	e8 ae 05 00 00       	call   713 <exit>
		printf(1, "Process %d\n", pid);
 165:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 166:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
 168:	56                   	push   %esi
 169:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 16c:	68 2e 0c 00 00       	push   $0xc2e
 171:	6a 01                	push   $0x1
 173:	e8 28 07 00 00       	call   8a0 <printf>
 178:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
 17b:	ff 34 9e             	push   (%esi,%ebx,4)
 17e:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 17f:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
 182:	68 3a 0c 00 00       	push   $0xc3a
 187:	6a 01                	push   $0x1
 189:	e8 12 07 00 00       	call   8a0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
 18e:	83 c4 10             	add    $0x10,%esp
 191:	83 fb 04             	cmp    $0x4,%ebx
 194:	75 e5                	jne    17b <main+0x17b>
		printf(1, "MoQ: %d\n", count[4]);
 196:	51                   	push   %ecx
 197:	ff 75 e4             	push   -0x1c(%ebp)
 19a:	68 43 0c 00 00       	push   $0xc43
 19f:	6a 01                	push   $0x1
 1a1:	e8 fa 06 00 00       	call   8a0 <printf>
 1a6:	83 c4 10             	add    $0x10,%esp
	exit_children();
 1a9:	e8 e2 02 00 00       	call   490 <exit_children>
	printf(1, "[Test 2] finished\n");
 1ae:	50                   	push   %eax
 1af:	50                   	push   %eax
 1b0:	68 74 0c 00 00       	push   $0xc74
 1b5:	6a 01                	push   $0x1
 1b7:	e8 e4 06 00 00       	call   8a0 <printf>
	printf(1, "[Test 3] sleep\n");
 1bc:	58                   	pop    %eax
 1bd:	5a                   	pop    %edx
 1be:	68 87 0c 00 00       	push   $0xc87
 1c3:	6a 01                	push   $0x1
 1c5:	e8 d6 06 00 00       	call   8a0 <printf>
	pid = fork_children2();
 1ca:	e8 b1 01 00 00       	call   380 <fork_children2>
	if(pid != parent)
 1cf:	83 c4 10             	add    $0x10,%esp
	pid = fork_children2();
 1d2:	89 c6                	mov    %eax,%esi
	if(pid != parent)
 1d4:	39 05 b0 10 00 00    	cmp    %eax,0x10b0
 1da:	0f 84 84 00 00 00    	je     264 <main+0x264>
 1e0:	bb f4 01 00 00       	mov    $0x1f4,%ebx
 1e5:	eb 28                	jmp    20f <main+0x20f>
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax
				if(x != 99){
 1f0:	83 f8 63             	cmp    $0x63,%eax
 1f3:	0f 85 57 ff ff ff    	jne    150 <main+0x150>
			if(x == 99) count[4]++;
 1f9:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
			sleep(1);
 1fd:	83 ec 0c             	sub    $0xc,%esp
 200:	6a 01                	push   $0x1
 202:	e8 9c 05 00 00       	call   7a3 <sleep>
		for(i = 0; i < NUM_SLEEP; i++)
 207:	83 c4 10             	add    $0x10,%esp
 20a:	83 eb 01             	sub    $0x1,%ebx
 20d:	74 11                	je     220 <main+0x220>
			int x = getlev();
 20f:	e8 a7 05 00 00       	call   7bb <getlev>
			if(x < 0 || x > 3)
 214:	83 f8 03             	cmp    $0x3,%eax
 217:	77 d7                	ja     1f0 <main+0x1f0>
			else count[x]++;
 219:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
 21e:	eb dd                	jmp    1fd <main+0x1fd>
		printf(1, "Process %d\n", pid);
 220:	50                   	push   %eax
		for(i = 0; i < MAX_LEVEL - 1; i++)
 221:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
 223:	56                   	push   %esi
 224:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 227:	68 2e 0c 00 00       	push   $0xc2e
 22c:	6a 01                	push   $0x1
 22e:	e8 6d 06 00 00       	call   8a0 <printf>
 233:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
 236:	ff 34 9e             	push   (%esi,%ebx,4)
 239:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 23a:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
 23d:	68 3a 0c 00 00       	push   $0xc3a
 242:	6a 01                	push   $0x1
 244:	e8 57 06 00 00       	call   8a0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
 249:	83 c4 10             	add    $0x10,%esp
 24c:	83 fb 04             	cmp    $0x4,%ebx
 24f:	75 e5                	jne    236 <main+0x236>
		printf(1, "MoQ: %d\n", count[4]);
 251:	50                   	push   %eax
 252:	ff 75 e4             	push   -0x1c(%ebp)
 255:	68 43 0c 00 00       	push   $0xc43
 25a:	6a 01                	push   $0x1
 25c:	e8 3f 06 00 00       	call   8a0 <printf>
 261:	83 c4 10             	add    $0x10,%esp
	exit_children();
 264:	e8 27 02 00 00       	call   490 <exit_children>
	printf(1, "[Test 3] finished\n");
 269:	53                   	push   %ebx
 26a:	53                   	push   %ebx
 26b:	68 97 0c 00 00       	push   $0xc97
 270:	6a 01                	push   $0x1
 272:	e8 29 06 00 00       	call   8a0 <printf>
	printf(1, "[Test 4] MoQ\n");
 277:	5e                   	pop    %esi
 278:	58                   	pop    %eax
 279:	68 aa 0c 00 00       	push   $0xcaa
 27e:	6a 01                	push   $0x1
 280:	e8 1b 06 00 00       	call   8a0 <printf>
	pid = fork_children3();
 285:	e8 66 01 00 00       	call   3f0 <fork_children3>
	if(pid != parent)
 28a:	83 c4 10             	add    $0x10,%esp
	pid = fork_children3();
 28d:	89 c6                	mov    %eax,%esi
	if(pid != parent)
 28f:	39 05 b0 10 00 00    	cmp    %eax,0x10b0
 295:	74 7b                	je     312 <main+0x312>
		if(pid == 36)
 297:	bb a0 86 01 00       	mov    $0x186a0,%ebx
 29c:	83 f8 24             	cmp    $0x24,%eax
 29f:	75 1c                	jne    2bd <main+0x2bd>
			monopolize();
 2a1:	e8 2d 05 00 00       	call   7d3 <monopolize>
			exit();
 2a6:	e8 68 04 00 00       	call   713 <exit>
				if(x != 99)
 2ab:	83 f8 63             	cmp    $0x63,%eax
 2ae:	0f 85 9c fe ff ff    	jne    150 <main+0x150>
				}
			}
			if(x == 99) count[4]++;
 2b4:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
		for(i = 0; i < NUM_LOOP; i++)
 2b8:	83 eb 01             	sub    $0x1,%ebx
 2bb:	74 11                	je     2ce <main+0x2ce>
			int x = getlev();
 2bd:	e8 f9 04 00 00       	call   7bb <getlev>
			if(x < 0 || x > 3)
 2c2:	83 f8 03             	cmp    $0x3,%eax
 2c5:	77 e4                	ja     2ab <main+0x2ab>
			else count[x]++;
 2c7:	83 44 85 d4 01       	addl   $0x1,-0x2c(%ebp,%eax,4)
 2cc:	eb ea                	jmp    2b8 <main+0x2b8>
		}
		printf(1, "Process %d\n", pid);
 2ce:	51                   	push   %ecx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 2cf:	31 db                	xor    %ebx,%ebx
		printf(1, "Process %d\n", pid);
 2d1:	56                   	push   %esi
 2d2:	8d 75 d4             	lea    -0x2c(%ebp),%esi
 2d5:	68 2e 0c 00 00       	push   $0xc2e
 2da:	6a 01                	push   $0x1
 2dc:	e8 bf 05 00 00       	call   8a0 <printf>
 2e1:	83 c4 10             	add    $0x10,%esp
			printf(1, "L%d: %d\n", i, count[i]);
 2e4:	ff 34 9e             	push   (%esi,%ebx,4)
 2e7:	53                   	push   %ebx
		for(i = 0; i < MAX_LEVEL - 1; i++)
 2e8:	83 c3 01             	add    $0x1,%ebx
			printf(1, "L%d: %d\n", i, count[i]);
 2eb:	68 3a 0c 00 00       	push   $0xc3a
 2f0:	6a 01                	push   $0x1
 2f2:	e8 a9 05 00 00       	call   8a0 <printf>
		for(i = 0; i < MAX_LEVEL - 1; i++)
 2f7:	83 c4 10             	add    $0x10,%esp
 2fa:	83 fb 04             	cmp    $0x4,%ebx
 2fd:	75 e5                	jne    2e4 <main+0x2e4>
		printf(1, "MoQ: %d\n", count[i]);
 2ff:	52                   	push   %edx
 300:	ff 75 e4             	push   -0x1c(%ebp)
 303:	68 43 0c 00 00       	push   $0xc43
 308:	6a 01                	push   $0x1
 30a:	e8 91 05 00 00       	call   8a0 <printf>
 30f:	83 c4 10             	add    $0x10,%esp
	}
	exit_children();
 312:	e8 79 01 00 00       	call   490 <exit_children>
	printf(1, "[Test 4] finished\n");
 317:	50                   	push   %eax
 318:	50                   	push   %eax
 319:	68 b8 0c 00 00       	push   $0xcb8
 31e:	6a 01                	push   $0x1
 320:	e8 7b 05 00 00       	call   8a0 <printf>

	exit();
 325:	e8 e9 03 00 00       	call   713 <exit>
 32a:	66 90                	xchg   %ax,%ax
 32c:	66 90                	xchg   %ax,%ax
 32e:	66 90                	xchg   %ax,%ax

00000330 <fork_children>:
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	bb 08 00 00 00       	mov    $0x8,%ebx
 339:	83 ec 04             	sub    $0x4,%esp
 33c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		if((p = fork()) == 0)
 340:	e8 c6 03 00 00       	call   70b <fork>
 345:	85 c0                	test   %eax,%eax
 347:	74 17                	je     360 <fork_children+0x30>
	for(i = 0; i < NUM_THREAD; i++){
 349:	83 eb 01             	sub    $0x1,%ebx
 34c:	75 f2                	jne    340 <fork_children+0x10>
}
 34e:	a1 b0 10 00 00       	mov    0x10b0,%eax
 353:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 356:	c9                   	leave  
 357:	c3                   	ret    
 358:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 35f:	90                   	nop
			sleep(10);
 360:	83 ec 0c             	sub    $0xc,%esp
 363:	6a 0a                	push   $0xa
 365:	e8 39 04 00 00       	call   7a3 <sleep>
}
 36a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
			return getpid();
 36d:	83 c4 10             	add    $0x10,%esp
}
 370:	c9                   	leave  
			return getpid();
 371:	e9 1d 04 00 00       	jmp    793 <getpid>
 376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 37d:	8d 76 00             	lea    0x0(%esi),%esi

00000380 <fork_children2>:
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	53                   	push   %ebx
	for(i = 0; i < NUM_THREAD; i++)
 384:	31 db                	xor    %ebx,%ebx
{
 386:	83 ec 04             	sub    $0x4,%esp
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		if((p = fork()) == 0)
 390:	e8 76 03 00 00       	call   70b <fork>
 395:	85 c0                	test   %eax,%eax
 397:	74 27                	je     3c0 <fork_children2+0x40>
			int r = setpriority(p, i + 1);
 399:	83 ec 08             	sub    $0x8,%esp
 39c:	83 c3 01             	add    $0x1,%ebx
 39f:	53                   	push   %ebx
 3a0:	50                   	push   %eax
 3a1:	e8 1d 04 00 00       	call   7c3 <setpriority>
			if(r < 0)
 3a6:	83 c4 10             	add    $0x10,%esp
 3a9:	85 c0                	test   %eax,%eax
 3ab:	78 29                	js     3d6 <fork_children2+0x56>
	for(i = 0; i < NUM_THREAD; i++)
 3ad:	83 fb 08             	cmp    $0x8,%ebx
 3b0:	75 de                	jne    390 <fork_children2+0x10>
}
 3b2:	a1 b0 10 00 00       	mov    0x10b0,%eax
 3b7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3ba:	c9                   	leave  
 3bb:	c3                   	ret    
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			sleep(10);
 3c0:	83 ec 0c             	sub    $0xc,%esp
 3c3:	6a 0a                	push   $0xa
 3c5:	e8 d9 03 00 00       	call   7a3 <sleep>
}
 3ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
			return getpid();
 3cd:	83 c4 10             	add    $0x10,%esp
}
 3d0:	c9                   	leave  
			return getpid();
 3d1:	e9 bd 03 00 00       	jmp    793 <getpid>
				printf(1, "setpriority returned %d\n", r);
 3d6:	83 ec 04             	sub    $0x4,%esp
 3d9:	50                   	push   %eax
 3da:	68 c8 0b 00 00       	push   $0xbc8
 3df:	6a 01                	push   $0x1
 3e1:	e8 ba 04 00 00       	call   8a0 <printf>
				exit();
 3e6:	e8 28 03 00 00       	call   713 <exit>
 3eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3ef:	90                   	nop

000003f0 <fork_children3>:
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	56                   	push   %esi
 3f4:	53                   	push   %ebx
 3f5:	bb 09 00 00 00       	mov    $0x9,%ebx
 3fa:	eb 09                	jmp    405 <fork_children3+0x15>
 3fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	for(i = 0; i <= NUM_THREAD; i++){
 400:	83 eb 01             	sub    $0x1,%ebx
 403:	74 5b                	je     460 <fork_children3+0x70>
		if((p = fork()) == 0)
 405:	e8 01 03 00 00       	call   70b <fork>
 40a:	85 c0                	test   %eax,%eax
 40c:	74 62                	je     470 <fork_children3+0x80>
			if(p % 2 == 1)
 40e:	89 c1                	mov    %eax,%ecx
 410:	c1 e9 1f             	shr    $0x1f,%ecx
 413:	8d 14 08             	lea    (%eax,%ecx,1),%edx
 416:	83 e2 01             	and    $0x1,%edx
 419:	29 ca                	sub    %ecx,%edx
 41b:	83 fa 01             	cmp    $0x1,%edx
 41e:	75 e0                	jne    400 <fork_children3+0x10>
				r = setmonopoly(p, 2020052633);
 420:	83 ec 08             	sub    $0x8,%esp
 423:	68 99 8e 67 78       	push   $0x78678e99
 428:	50                   	push   %eax
 429:	e8 9d 03 00 00       	call   7cb <setmonopoly>
				printf(1, "Number of processes in MoQ: %d\n", r);
 42e:	83 c4 0c             	add    $0xc,%esp
 431:	50                   	push   %eax
				r = setmonopoly(p, 2020052633);
 432:	89 c6                	mov    %eax,%esi
				printf(1, "Number of processes in MoQ: %d\n", r);
 434:	68 cc 0c 00 00       	push   $0xccc
 439:	6a 01                	push   $0x1
 43b:	e8 60 04 00 00       	call   8a0 <printf>
			if(r < 0)
 440:	83 c4 10             	add    $0x10,%esp
 443:	85 f6                	test   %esi,%esi
 445:	79 b9                	jns    400 <fork_children3+0x10>
				printf(1, "setmonopoly returned %d\n", r);
 447:	50                   	push   %eax
 448:	56                   	push   %esi
 449:	68 e1 0b 00 00       	push   $0xbe1
 44e:	6a 01                	push   $0x1
 450:	e8 4b 04 00 00       	call   8a0 <printf>
				exit();
 455:	e8 b9 02 00 00       	call   713 <exit>
 45a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
 460:	a1 b0 10 00 00       	mov    0x10b0,%eax
 465:	8d 65 f8             	lea    -0x8(%ebp),%esp
 468:	5b                   	pop    %ebx
 469:	5e                   	pop    %esi
 46a:	5d                   	pop    %ebp
 46b:	c3                   	ret    
 46c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			sleep(10);
 470:	83 ec 0c             	sub    $0xc,%esp
 473:	6a 0a                	push   $0xa
 475:	e8 29 03 00 00       	call   7a3 <sleep>
			return getpid();
 47a:	83 c4 10             	add    $0x10,%esp
}
 47d:	8d 65 f8             	lea    -0x8(%ebp),%esp
 480:	5b                   	pop    %ebx
 481:	5e                   	pop    %esi
 482:	5d                   	pop    %ebp
			return getpid();
 483:	e9 0b 03 00 00       	jmp    793 <getpid>
 488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 48f:	90                   	nop

00000490 <exit_children>:
{
 490:	55                   	push   %ebp
 491:	89 e5                	mov    %esp,%ebp
 493:	83 ec 08             	sub    $0x8,%esp
	if(getpid() != parent)
 496:	e8 f8 02 00 00       	call   793 <getpid>
 49b:	3b 05 b0 10 00 00    	cmp    0x10b0,%eax
 4a1:	75 11                	jne    4b4 <exit_children+0x24>
 4a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4a7:	90                   	nop
	while(wait() != -1);
 4a8:	e8 6e 02 00 00       	call   71b <wait>
 4ad:	83 f8 ff             	cmp    $0xffffffff,%eax
 4b0:	75 f6                	jne    4a8 <exit_children+0x18>
}
 4b2:	c9                   	leave  
 4b3:	c3                   	ret    
		exit();
 4b4:	e8 5a 02 00 00       	call   713 <exit>
 4b9:	66 90                	xchg   %ax,%ax
 4bb:	66 90                	xchg   %ax,%ax
 4bd:	66 90                	xchg   %ax,%ax
 4bf:	90                   	nop

000004c0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 4c0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 4c1:	31 c0                	xor    %eax,%eax
{
 4c3:	89 e5                	mov    %esp,%ebp
 4c5:	53                   	push   %ebx
 4c6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 4c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 4d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 4d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 4d7:	83 c0 01             	add    $0x1,%eax
 4da:	84 d2                	test   %dl,%dl
 4dc:	75 f2                	jne    4d0 <strcpy+0x10>
    ;
  return os;
}
 4de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4e1:	89 c8                	mov    %ecx,%eax
 4e3:	c9                   	leave  
 4e4:	c3                   	ret    
 4e5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	53                   	push   %ebx
 4f4:	8b 55 08             	mov    0x8(%ebp),%edx
 4f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 4fa:	0f b6 02             	movzbl (%edx),%eax
 4fd:	84 c0                	test   %al,%al
 4ff:	75 17                	jne    518 <strcmp+0x28>
 501:	eb 3a                	jmp    53d <strcmp+0x4d>
 503:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 507:	90                   	nop
 508:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 50c:	83 c2 01             	add    $0x1,%edx
 50f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 512:	84 c0                	test   %al,%al
 514:	74 1a                	je     530 <strcmp+0x40>
    p++, q++;
 516:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
 518:	0f b6 19             	movzbl (%ecx),%ebx
 51b:	38 c3                	cmp    %al,%bl
 51d:	74 e9                	je     508 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 51f:	29 d8                	sub    %ebx,%eax
}
 521:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 524:	c9                   	leave  
 525:	c3                   	ret    
 526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
 530:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 534:	31 c0                	xor    %eax,%eax
 536:	29 d8                	sub    %ebx,%eax
}
 538:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 53b:	c9                   	leave  
 53c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
 53d:	0f b6 19             	movzbl (%ecx),%ebx
 540:	31 c0                	xor    %eax,%eax
 542:	eb db                	jmp    51f <strcmp+0x2f>
 544:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop

00000550 <strlen>:

uint
strlen(const char *s)
{
 550:	55                   	push   %ebp
 551:	89 e5                	mov    %esp,%ebp
 553:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 556:	80 3a 00             	cmpb   $0x0,(%edx)
 559:	74 15                	je     570 <strlen+0x20>
 55b:	31 c0                	xor    %eax,%eax
 55d:	8d 76 00             	lea    0x0(%esi),%esi
 560:	83 c0 01             	add    $0x1,%eax
 563:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 567:	89 c1                	mov    %eax,%ecx
 569:	75 f5                	jne    560 <strlen+0x10>
    ;
  return n;
}
 56b:	89 c8                	mov    %ecx,%eax
 56d:	5d                   	pop    %ebp
 56e:	c3                   	ret    
 56f:	90                   	nop
  for(n = 0; s[n]; n++)
 570:	31 c9                	xor    %ecx,%ecx
}
 572:	5d                   	pop    %ebp
 573:	89 c8                	mov    %ecx,%eax
 575:	c3                   	ret    
 576:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57d:	8d 76 00             	lea    0x0(%esi),%esi

00000580 <memset>:

void*
memset(void *dst, int c, uint n)
{
 580:	55                   	push   %ebp
 581:	89 e5                	mov    %esp,%ebp
 583:	57                   	push   %edi
 584:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 587:	8b 4d 10             	mov    0x10(%ebp),%ecx
 58a:	8b 45 0c             	mov    0xc(%ebp),%eax
 58d:	89 d7                	mov    %edx,%edi
 58f:	fc                   	cld    
 590:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 592:	8b 7d fc             	mov    -0x4(%ebp),%edi
 595:	89 d0                	mov    %edx,%eax
 597:	c9                   	leave  
 598:	c3                   	ret    
 599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005a0 <strchr>:

char*
strchr(const char *s, char c)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	8b 45 08             	mov    0x8(%ebp),%eax
 5a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 5aa:	0f b6 10             	movzbl (%eax),%edx
 5ad:	84 d2                	test   %dl,%dl
 5af:	75 12                	jne    5c3 <strchr+0x23>
 5b1:	eb 1d                	jmp    5d0 <strchr+0x30>
 5b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5b7:	90                   	nop
 5b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 5bc:	83 c0 01             	add    $0x1,%eax
 5bf:	84 d2                	test   %dl,%dl
 5c1:	74 0d                	je     5d0 <strchr+0x30>
    if(*s == c)
 5c3:	38 d1                	cmp    %dl,%cl
 5c5:	75 f1                	jne    5b8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 5c7:	5d                   	pop    %ebp
 5c8:	c3                   	ret    
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 5d0:	31 c0                	xor    %eax,%eax
}
 5d2:	5d                   	pop    %ebp
 5d3:	c3                   	ret    
 5d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5df:	90                   	nop

000005e0 <gets>:

char*
gets(char *buf, int max)
{
 5e0:	55                   	push   %ebp
 5e1:	89 e5                	mov    %esp,%ebp
 5e3:	57                   	push   %edi
 5e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 5e5:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
 5e8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 5e9:	31 db                	xor    %ebx,%ebx
{
 5eb:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 5ee:	eb 27                	jmp    617 <gets+0x37>
    cc = read(0, &c, 1);
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	6a 01                	push   $0x1
 5f5:	57                   	push   %edi
 5f6:	6a 00                	push   $0x0
 5f8:	e8 2e 01 00 00       	call   72b <read>
    if(cc < 1)
 5fd:	83 c4 10             	add    $0x10,%esp
 600:	85 c0                	test   %eax,%eax
 602:	7e 1d                	jle    621 <gets+0x41>
      break;
    buf[i++] = c;
 604:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 608:	8b 55 08             	mov    0x8(%ebp),%edx
 60b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 60f:	3c 0a                	cmp    $0xa,%al
 611:	74 1d                	je     630 <gets+0x50>
 613:	3c 0d                	cmp    $0xd,%al
 615:	74 19                	je     630 <gets+0x50>
  for(i=0; i+1 < max; ){
 617:	89 de                	mov    %ebx,%esi
 619:	83 c3 01             	add    $0x1,%ebx
 61c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 61f:	7c cf                	jl     5f0 <gets+0x10>
      break;
  }
  buf[i] = '\0';
 621:	8b 45 08             	mov    0x8(%ebp),%eax
 624:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 628:	8d 65 f4             	lea    -0xc(%ebp),%esp
 62b:	5b                   	pop    %ebx
 62c:	5e                   	pop    %esi
 62d:	5f                   	pop    %edi
 62e:	5d                   	pop    %ebp
 62f:	c3                   	ret    
  buf[i] = '\0';
 630:	8b 45 08             	mov    0x8(%ebp),%eax
 633:	89 de                	mov    %ebx,%esi
 635:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
 639:	8d 65 f4             	lea    -0xc(%ebp),%esp
 63c:	5b                   	pop    %ebx
 63d:	5e                   	pop    %esi
 63e:	5f                   	pop    %edi
 63f:	5d                   	pop    %ebp
 640:	c3                   	ret    
 641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop

00000650 <stat>:

int
stat(const char *n, struct stat *st)
{
 650:	55                   	push   %ebp
 651:	89 e5                	mov    %esp,%ebp
 653:	56                   	push   %esi
 654:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 655:	83 ec 08             	sub    $0x8,%esp
 658:	6a 00                	push   $0x0
 65a:	ff 75 08             	push   0x8(%ebp)
 65d:	e8 f1 00 00 00       	call   753 <open>
  if(fd < 0)
 662:	83 c4 10             	add    $0x10,%esp
 665:	85 c0                	test   %eax,%eax
 667:	78 27                	js     690 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 669:	83 ec 08             	sub    $0x8,%esp
 66c:	ff 75 0c             	push   0xc(%ebp)
 66f:	89 c3                	mov    %eax,%ebx
 671:	50                   	push   %eax
 672:	e8 f4 00 00 00       	call   76b <fstat>
  close(fd);
 677:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 67a:	89 c6                	mov    %eax,%esi
  close(fd);
 67c:	e8 ba 00 00 00       	call   73b <close>
  return r;
 681:	83 c4 10             	add    $0x10,%esp
}
 684:	8d 65 f8             	lea    -0x8(%ebp),%esp
 687:	89 f0                	mov    %esi,%eax
 689:	5b                   	pop    %ebx
 68a:	5e                   	pop    %esi
 68b:	5d                   	pop    %ebp
 68c:	c3                   	ret    
 68d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 690:	be ff ff ff ff       	mov    $0xffffffff,%esi
 695:	eb ed                	jmp    684 <stat+0x34>
 697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69e:	66 90                	xchg   %ax,%ax

000006a0 <atoi>:

int
atoi(const char *s)
{
 6a0:	55                   	push   %ebp
 6a1:	89 e5                	mov    %esp,%ebp
 6a3:	53                   	push   %ebx
 6a4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 6a7:	0f be 02             	movsbl (%edx),%eax
 6aa:	8d 48 d0             	lea    -0x30(%eax),%ecx
 6ad:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 6b0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 6b5:	77 1e                	ja     6d5 <atoi+0x35>
 6b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6be:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 6c0:	83 c2 01             	add    $0x1,%edx
 6c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 6c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 6ca:	0f be 02             	movsbl (%edx),%eax
 6cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 6d0:	80 fb 09             	cmp    $0x9,%bl
 6d3:	76 eb                	jbe    6c0 <atoi+0x20>
  return n;
}
 6d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6d8:	89 c8                	mov    %ecx,%eax
 6da:	c9                   	leave  
 6db:	c3                   	ret    
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	57                   	push   %edi
 6e4:	8b 45 10             	mov    0x10(%ebp),%eax
 6e7:	8b 55 08             	mov    0x8(%ebp),%edx
 6ea:	56                   	push   %esi
 6eb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 6ee:	85 c0                	test   %eax,%eax
 6f0:	7e 13                	jle    705 <memmove+0x25>
 6f2:	01 d0                	add    %edx,%eax
  dst = vdst;
 6f4:	89 d7                	mov    %edx,%edi
 6f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6fd:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
 700:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 701:	39 f8                	cmp    %edi,%eax
 703:	75 fb                	jne    700 <memmove+0x20>
  return vdst;
}
 705:	5e                   	pop    %esi
 706:	89 d0                	mov    %edx,%eax
 708:	5f                   	pop    %edi
 709:	5d                   	pop    %ebp
 70a:	c3                   	ret    

0000070b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 70b:	b8 01 00 00 00       	mov    $0x1,%eax
 710:	cd 40                	int    $0x40
 712:	c3                   	ret    

00000713 <exit>:
SYSCALL(exit)
 713:	b8 02 00 00 00       	mov    $0x2,%eax
 718:	cd 40                	int    $0x40
 71a:	c3                   	ret    

0000071b <wait>:
SYSCALL(wait)
 71b:	b8 03 00 00 00       	mov    $0x3,%eax
 720:	cd 40                	int    $0x40
 722:	c3                   	ret    

00000723 <pipe>:
SYSCALL(pipe)
 723:	b8 04 00 00 00       	mov    $0x4,%eax
 728:	cd 40                	int    $0x40
 72a:	c3                   	ret    

0000072b <read>:
SYSCALL(read)
 72b:	b8 05 00 00 00       	mov    $0x5,%eax
 730:	cd 40                	int    $0x40
 732:	c3                   	ret    

00000733 <write>:
SYSCALL(write)
 733:	b8 10 00 00 00       	mov    $0x10,%eax
 738:	cd 40                	int    $0x40
 73a:	c3                   	ret    

0000073b <close>:
SYSCALL(close)
 73b:	b8 15 00 00 00       	mov    $0x15,%eax
 740:	cd 40                	int    $0x40
 742:	c3                   	ret    

00000743 <kill>:
SYSCALL(kill)
 743:	b8 06 00 00 00       	mov    $0x6,%eax
 748:	cd 40                	int    $0x40
 74a:	c3                   	ret    

0000074b <exec>:
SYSCALL(exec)
 74b:	b8 07 00 00 00       	mov    $0x7,%eax
 750:	cd 40                	int    $0x40
 752:	c3                   	ret    

00000753 <open>:
SYSCALL(open)
 753:	b8 0f 00 00 00       	mov    $0xf,%eax
 758:	cd 40                	int    $0x40
 75a:	c3                   	ret    

0000075b <mknod>:
SYSCALL(mknod)
 75b:	b8 11 00 00 00       	mov    $0x11,%eax
 760:	cd 40                	int    $0x40
 762:	c3                   	ret    

00000763 <unlink>:
SYSCALL(unlink)
 763:	b8 12 00 00 00       	mov    $0x12,%eax
 768:	cd 40                	int    $0x40
 76a:	c3                   	ret    

0000076b <fstat>:
SYSCALL(fstat)
 76b:	b8 08 00 00 00       	mov    $0x8,%eax
 770:	cd 40                	int    $0x40
 772:	c3                   	ret    

00000773 <link>:
SYSCALL(link)
 773:	b8 13 00 00 00       	mov    $0x13,%eax
 778:	cd 40                	int    $0x40
 77a:	c3                   	ret    

0000077b <mkdir>:
SYSCALL(mkdir)
 77b:	b8 14 00 00 00       	mov    $0x14,%eax
 780:	cd 40                	int    $0x40
 782:	c3                   	ret    

00000783 <chdir>:
SYSCALL(chdir)
 783:	b8 09 00 00 00       	mov    $0x9,%eax
 788:	cd 40                	int    $0x40
 78a:	c3                   	ret    

0000078b <dup>:
SYSCALL(dup)
 78b:	b8 0a 00 00 00       	mov    $0xa,%eax
 790:	cd 40                	int    $0x40
 792:	c3                   	ret    

00000793 <getpid>:
SYSCALL(getpid)
 793:	b8 0b 00 00 00       	mov    $0xb,%eax
 798:	cd 40                	int    $0x40
 79a:	c3                   	ret    

0000079b <sbrk>:
SYSCALL(sbrk)
 79b:	b8 0c 00 00 00       	mov    $0xc,%eax
 7a0:	cd 40                	int    $0x40
 7a2:	c3                   	ret    

000007a3 <sleep>:
SYSCALL(sleep)
 7a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 7a8:	cd 40                	int    $0x40
 7aa:	c3                   	ret    

000007ab <uptime>:
SYSCALL(uptime)
 7ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 7b0:	cd 40                	int    $0x40
 7b2:	c3                   	ret    

000007b3 <yield>:
SYSCALL(yield)
 7b3:	b8 16 00 00 00       	mov    $0x16,%eax
 7b8:	cd 40                	int    $0x40
 7ba:	c3                   	ret    

000007bb <getlev>:
SYSCALL(getlev)
 7bb:	b8 17 00 00 00       	mov    $0x17,%eax
 7c0:	cd 40                	int    $0x40
 7c2:	c3                   	ret    

000007c3 <setpriority>:
SYSCALL(setpriority)
 7c3:	b8 18 00 00 00       	mov    $0x18,%eax
 7c8:	cd 40                	int    $0x40
 7ca:	c3                   	ret    

000007cb <setmonopoly>:
SYSCALL(setmonopoly)
 7cb:	b8 19 00 00 00       	mov    $0x19,%eax
 7d0:	cd 40                	int    $0x40
 7d2:	c3                   	ret    

000007d3 <monopolize>:
SYSCALL(monopolize)
 7d3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 7d8:	cd 40                	int    $0x40
 7da:	c3                   	ret    

000007db <unmonopolize>:
SYSCALL(unmonopolize)
 7db:	b8 1b 00 00 00       	mov    $0x1b,%eax
 7e0:	cd 40                	int    $0x40
 7e2:	c3                   	ret    
 7e3:	66 90                	xchg   %ax,%ax
 7e5:	66 90                	xchg   %ax,%ax
 7e7:	66 90                	xchg   %ax,%ax
 7e9:	66 90                	xchg   %ax,%ax
 7eb:	66 90                	xchg   %ax,%ax
 7ed:	66 90                	xchg   %ax,%ax
 7ef:	90                   	nop

000007f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 3c             	sub    $0x3c,%esp
 7f9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 7fc:	89 d1                	mov    %edx,%ecx
{
 7fe:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 801:	85 d2                	test   %edx,%edx
 803:	0f 89 7f 00 00 00    	jns    888 <printint+0x98>
 809:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 80d:	74 79                	je     888 <printint+0x98>
    neg = 1;
 80f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 816:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 818:	31 db                	xor    %ebx,%ebx
 81a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 81d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 820:	89 c8                	mov    %ecx,%eax
 822:	31 d2                	xor    %edx,%edx
 824:	89 cf                	mov    %ecx,%edi
 826:	f7 75 c4             	divl   -0x3c(%ebp)
 829:	0f b6 92 4c 0d 00 00 	movzbl 0xd4c(%edx),%edx
 830:	89 45 c0             	mov    %eax,-0x40(%ebp)
 833:	89 d8                	mov    %ebx,%eax
 835:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 838:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 83b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 83e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 841:	76 dd                	jbe    820 <printint+0x30>
  if(neg)
 843:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 846:	85 c9                	test   %ecx,%ecx
 848:	74 0c                	je     856 <printint+0x66>
    buf[i++] = '-';
 84a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 84f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 851:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 856:	8b 7d b8             	mov    -0x48(%ebp),%edi
 859:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 85d:	eb 07                	jmp    866 <printint+0x76>
 85f:	90                   	nop
    putc(fd, buf[i]);
 860:	0f b6 13             	movzbl (%ebx),%edx
 863:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 866:	83 ec 04             	sub    $0x4,%esp
 869:	88 55 d7             	mov    %dl,-0x29(%ebp)
 86c:	6a 01                	push   $0x1
 86e:	56                   	push   %esi
 86f:	57                   	push   %edi
 870:	e8 be fe ff ff       	call   733 <write>
  while(--i >= 0)
 875:	83 c4 10             	add    $0x10,%esp
 878:	39 de                	cmp    %ebx,%esi
 87a:	75 e4                	jne    860 <printint+0x70>
}
 87c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 87f:	5b                   	pop    %ebx
 880:	5e                   	pop    %esi
 881:	5f                   	pop    %edi
 882:	5d                   	pop    %ebp
 883:	c3                   	ret    
 884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 888:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 88f:	eb 87                	jmp    818 <printint+0x28>
 891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 898:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 89f:	90                   	nop

000008a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8a0:	55                   	push   %ebp
 8a1:	89 e5                	mov    %esp,%ebp
 8a3:	57                   	push   %edi
 8a4:	56                   	push   %esi
 8a5:	53                   	push   %ebx
 8a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
 8ac:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
 8af:	0f b6 13             	movzbl (%ebx),%edx
 8b2:	84 d2                	test   %dl,%dl
 8b4:	74 6a                	je     920 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
 8b6:	8d 45 10             	lea    0x10(%ebp),%eax
 8b9:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
 8bc:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 8bf:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
 8c1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 8c4:	eb 36                	jmp    8fc <printf+0x5c>
 8c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8cd:	8d 76 00             	lea    0x0(%esi),%esi
 8d0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 8d3:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
 8d8:	83 f8 25             	cmp    $0x25,%eax
 8db:	74 15                	je     8f2 <printf+0x52>
  write(fd, &c, 1);
 8dd:	83 ec 04             	sub    $0x4,%esp
 8e0:	88 55 e7             	mov    %dl,-0x19(%ebp)
 8e3:	6a 01                	push   $0x1
 8e5:	57                   	push   %edi
 8e6:	56                   	push   %esi
 8e7:	e8 47 fe ff ff       	call   733 <write>
 8ec:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
 8ef:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8f2:	0f b6 13             	movzbl (%ebx),%edx
 8f5:	83 c3 01             	add    $0x1,%ebx
 8f8:	84 d2                	test   %dl,%dl
 8fa:	74 24                	je     920 <printf+0x80>
    c = fmt[i] & 0xff;
 8fc:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
 8ff:	85 c9                	test   %ecx,%ecx
 901:	74 cd                	je     8d0 <printf+0x30>
      }
    } else if(state == '%'){
 903:	83 f9 25             	cmp    $0x25,%ecx
 906:	75 ea                	jne    8f2 <printf+0x52>
      if(c == 'd'){
 908:	83 f8 25             	cmp    $0x25,%eax
 90b:	0f 84 07 01 00 00    	je     a18 <printf+0x178>
 911:	83 e8 63             	sub    $0x63,%eax
 914:	83 f8 15             	cmp    $0x15,%eax
 917:	77 17                	ja     930 <printf+0x90>
 919:	ff 24 85 f4 0c 00 00 	jmp    *0xcf4(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 920:	8d 65 f4             	lea    -0xc(%ebp),%esp
 923:	5b                   	pop    %ebx
 924:	5e                   	pop    %esi
 925:	5f                   	pop    %edi
 926:	5d                   	pop    %ebp
 927:	c3                   	ret    
 928:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 92f:	90                   	nop
  write(fd, &c, 1);
 930:	83 ec 04             	sub    $0x4,%esp
 933:	88 55 d4             	mov    %dl,-0x2c(%ebp)
 936:	6a 01                	push   $0x1
 938:	57                   	push   %edi
 939:	56                   	push   %esi
 93a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 93e:	e8 f0 fd ff ff       	call   733 <write>
        putc(fd, c);
 943:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
 947:	83 c4 0c             	add    $0xc,%esp
 94a:	88 55 e7             	mov    %dl,-0x19(%ebp)
 94d:	6a 01                	push   $0x1
 94f:	57                   	push   %edi
 950:	56                   	push   %esi
 951:	e8 dd fd ff ff       	call   733 <write>
        putc(fd, c);
 956:	83 c4 10             	add    $0x10,%esp
      state = 0;
 959:	31 c9                	xor    %ecx,%ecx
 95b:	eb 95                	jmp    8f2 <printf+0x52>
 95d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 960:	83 ec 0c             	sub    $0xc,%esp
 963:	b9 10 00 00 00       	mov    $0x10,%ecx
 968:	6a 00                	push   $0x0
 96a:	8b 45 d0             	mov    -0x30(%ebp),%eax
 96d:	8b 10                	mov    (%eax),%edx
 96f:	89 f0                	mov    %esi,%eax
 971:	e8 7a fe ff ff       	call   7f0 <printint>
        ap++;
 976:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 97a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 97d:	31 c9                	xor    %ecx,%ecx
 97f:	e9 6e ff ff ff       	jmp    8f2 <printf+0x52>
 984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 988:	8b 45 d0             	mov    -0x30(%ebp),%eax
 98b:	8b 10                	mov    (%eax),%edx
        ap++;
 98d:	83 c0 04             	add    $0x4,%eax
 990:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 993:	85 d2                	test   %edx,%edx
 995:	0f 84 8d 00 00 00    	je     a28 <printf+0x188>
        while(*s != 0){
 99b:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
 99e:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
 9a0:	84 c0                	test   %al,%al
 9a2:	0f 84 4a ff ff ff    	je     8f2 <printf+0x52>
 9a8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 9ab:	89 d3                	mov    %edx,%ebx
 9ad:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9b0:	83 ec 04             	sub    $0x4,%esp
          s++;
 9b3:	83 c3 01             	add    $0x1,%ebx
 9b6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9b9:	6a 01                	push   $0x1
 9bb:	57                   	push   %edi
 9bc:	56                   	push   %esi
 9bd:	e8 71 fd ff ff       	call   733 <write>
        while(*s != 0){
 9c2:	0f b6 03             	movzbl (%ebx),%eax
 9c5:	83 c4 10             	add    $0x10,%esp
 9c8:	84 c0                	test   %al,%al
 9ca:	75 e4                	jne    9b0 <printf+0x110>
      state = 0;
 9cc:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
 9cf:	31 c9                	xor    %ecx,%ecx
 9d1:	e9 1c ff ff ff       	jmp    8f2 <printf+0x52>
 9d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 9dd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
 9e0:	83 ec 0c             	sub    $0xc,%esp
 9e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9e8:	6a 01                	push   $0x1
 9ea:	e9 7b ff ff ff       	jmp    96a <printf+0xca>
 9ef:	90                   	nop
        putc(fd, *ap);
 9f0:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
 9f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9f6:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
 9f8:	6a 01                	push   $0x1
 9fa:	57                   	push   %edi
 9fb:	56                   	push   %esi
        putc(fd, *ap);
 9fc:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 9ff:	e8 2f fd ff ff       	call   733 <write>
        ap++;
 a04:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
 a08:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a0b:	31 c9                	xor    %ecx,%ecx
 a0d:	e9 e0 fe ff ff       	jmp    8f2 <printf+0x52>
 a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
 a18:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
 a1b:	83 ec 04             	sub    $0x4,%esp
 a1e:	e9 2a ff ff ff       	jmp    94d <printf+0xad>
 a23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 a27:	90                   	nop
          s = "(null)";
 a28:	ba ec 0c 00 00       	mov    $0xcec,%edx
        while(*s != 0){
 a2d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 a30:	b8 28 00 00 00       	mov    $0x28,%eax
 a35:	89 d3                	mov    %edx,%ebx
 a37:	e9 74 ff ff ff       	jmp    9b0 <printf+0x110>
 a3c:	66 90                	xchg   %ax,%ax
 a3e:	66 90                	xchg   %ax,%ax

00000a40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a40:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a41:	a1 b4 10 00 00       	mov    0x10b4,%eax
{
 a46:	89 e5                	mov    %esp,%ebp
 a48:	57                   	push   %edi
 a49:	56                   	push   %esi
 a4a:	53                   	push   %ebx
 a4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a4e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a58:	89 c2                	mov    %eax,%edx
 a5a:	8b 00                	mov    (%eax),%eax
 a5c:	39 ca                	cmp    %ecx,%edx
 a5e:	73 30                	jae    a90 <free+0x50>
 a60:	39 c1                	cmp    %eax,%ecx
 a62:	72 04                	jb     a68 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a64:	39 c2                	cmp    %eax,%edx
 a66:	72 f0                	jb     a58 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a68:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a6b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a6e:	39 f8                	cmp    %edi,%eax
 a70:	74 30                	je     aa2 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 a72:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 a75:	8b 42 04             	mov    0x4(%edx),%eax
 a78:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 a7b:	39 f1                	cmp    %esi,%ecx
 a7d:	74 3a                	je     ab9 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 a7f:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
 a81:	5b                   	pop    %ebx
  freep = p;
 a82:	89 15 b4 10 00 00    	mov    %edx,0x10b4
}
 a88:	5e                   	pop    %esi
 a89:	5f                   	pop    %edi
 a8a:	5d                   	pop    %ebp
 a8b:	c3                   	ret    
 a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a90:	39 c2                	cmp    %eax,%edx
 a92:	72 c4                	jb     a58 <free+0x18>
 a94:	39 c1                	cmp    %eax,%ecx
 a96:	73 c0                	jae    a58 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
 a98:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a9b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a9e:	39 f8                	cmp    %edi,%eax
 aa0:	75 d0                	jne    a72 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
 aa2:	03 70 04             	add    0x4(%eax),%esi
 aa5:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 aa8:	8b 02                	mov    (%edx),%eax
 aaa:	8b 00                	mov    (%eax),%eax
 aac:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
 aaf:	8b 42 04             	mov    0x4(%edx),%eax
 ab2:	8d 34 c2             	lea    (%edx,%eax,8),%esi
 ab5:	39 f1                	cmp    %esi,%ecx
 ab7:	75 c6                	jne    a7f <free+0x3f>
    p->s.size += bp->s.size;
 ab9:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
 abc:	89 15 b4 10 00 00    	mov    %edx,0x10b4
    p->s.size += bp->s.size;
 ac2:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
 ac5:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 ac8:	89 0a                	mov    %ecx,(%edx)
}
 aca:	5b                   	pop    %ebx
 acb:	5e                   	pop    %esi
 acc:	5f                   	pop    %edi
 acd:	5d                   	pop    %ebp
 ace:	c3                   	ret    
 acf:	90                   	nop

00000ad0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 ad0:	55                   	push   %ebp
 ad1:	89 e5                	mov    %esp,%ebp
 ad3:	57                   	push   %edi
 ad4:	56                   	push   %esi
 ad5:	53                   	push   %ebx
 ad6:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 adc:	8b 3d b4 10 00 00    	mov    0x10b4,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 ae2:	8d 70 07             	lea    0x7(%eax),%esi
 ae5:	c1 ee 03             	shr    $0x3,%esi
 ae8:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 aeb:	85 ff                	test   %edi,%edi
 aed:	0f 84 9d 00 00 00    	je     b90 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 af3:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
 af5:	8b 4a 04             	mov    0x4(%edx),%ecx
 af8:	39 f1                	cmp    %esi,%ecx
 afa:	73 6a                	jae    b66 <malloc+0x96>
 afc:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b01:	39 de                	cmp    %ebx,%esi
 b03:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 b06:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
 b0d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 b10:	eb 17                	jmp    b29 <malloc+0x59>
 b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b18:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b1a:	8b 48 04             	mov    0x4(%eax),%ecx
 b1d:	39 f1                	cmp    %esi,%ecx
 b1f:	73 4f                	jae    b70 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b21:	8b 3d b4 10 00 00    	mov    0x10b4,%edi
 b27:	89 c2                	mov    %eax,%edx
 b29:	39 d7                	cmp    %edx,%edi
 b2b:	75 eb                	jne    b18 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b2d:	83 ec 0c             	sub    $0xc,%esp
 b30:	ff 75 e4             	push   -0x1c(%ebp)
 b33:	e8 63 fc ff ff       	call   79b <sbrk>
  if(p == (char*)-1)
 b38:	83 c4 10             	add    $0x10,%esp
 b3b:	83 f8 ff             	cmp    $0xffffffff,%eax
 b3e:	74 1c                	je     b5c <malloc+0x8c>
  hp->s.size = nu;
 b40:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b43:	83 ec 0c             	sub    $0xc,%esp
 b46:	83 c0 08             	add    $0x8,%eax
 b49:	50                   	push   %eax
 b4a:	e8 f1 fe ff ff       	call   a40 <free>
  return freep;
 b4f:	8b 15 b4 10 00 00    	mov    0x10b4,%edx
      if((p = morecore(nunits)) == 0)
 b55:	83 c4 10             	add    $0x10,%esp
 b58:	85 d2                	test   %edx,%edx
 b5a:	75 bc                	jne    b18 <malloc+0x48>
        return 0;
  }
}
 b5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b5f:	31 c0                	xor    %eax,%eax
}
 b61:	5b                   	pop    %ebx
 b62:	5e                   	pop    %esi
 b63:	5f                   	pop    %edi
 b64:	5d                   	pop    %ebp
 b65:	c3                   	ret    
    if(p->s.size >= nunits){
 b66:	89 d0                	mov    %edx,%eax
 b68:	89 fa                	mov    %edi,%edx
 b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b70:	39 ce                	cmp    %ecx,%esi
 b72:	74 4c                	je     bc0 <malloc+0xf0>
        p->s.size -= nunits;
 b74:	29 f1                	sub    %esi,%ecx
 b76:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b79:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b7c:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
 b7f:	89 15 b4 10 00 00    	mov    %edx,0x10b4
}
 b85:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b88:	83 c0 08             	add    $0x8,%eax
}
 b8b:	5b                   	pop    %ebx
 b8c:	5e                   	pop    %esi
 b8d:	5f                   	pop    %edi
 b8e:	5d                   	pop    %ebp
 b8f:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
 b90:	c7 05 b4 10 00 00 b8 	movl   $0x10b8,0x10b4
 b97:	10 00 00 
    base.s.size = 0;
 b9a:	bf b8 10 00 00       	mov    $0x10b8,%edi
    base.s.ptr = freep = prevp = &base;
 b9f:	c7 05 b8 10 00 00 b8 	movl   $0x10b8,0x10b8
 ba6:	10 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ba9:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
 bab:	c7 05 bc 10 00 00 00 	movl   $0x0,0x10bc
 bb2:	00 00 00 
    if(p->s.size >= nunits){
 bb5:	e9 42 ff ff ff       	jmp    afc <malloc+0x2c>
 bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 bc0:	8b 08                	mov    (%eax),%ecx
 bc2:	89 0a                	mov    %ecx,(%edx)
 bc4:	eb b9                	jmp    b7f <malloc+0xaf>
