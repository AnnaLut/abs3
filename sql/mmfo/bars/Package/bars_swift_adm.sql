
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_swift_adm.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SWIFT_ADM wrapped
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
3
9
9200000
1
4
0
10
2 :e:
1PACKAGE:
1BARS_SWIFT_ADM:
1SETSWTKEY:
1PKEY:
1VARCHAR2:
1SETABSKEY:
1FUNCTION:
1SET_LAU_POLICY:
1P_SCHEMA:
1P_OBJECT:
1RETURN:
1GET_LAU_CHECK:
1NUMBER:
1SET_LAU_CHECK:
1P_CODE:
1P_STATUS:
0

0
0
3d
2
0 a0 97 9a 8f a0 b0 3d
b4 55 6a 9a 8f a0 b0 3d
b4 55 6a a0 8d 8f a0 b0
3d 8f a0 b0 3d b4 :2 a0 2c
6a a0 8d a0 b4 a0 2c 6a
9a 8f a0 b0 3d 8f a0 b0
3d b4 55 6a a0 :2 aa 59 58
1d 17 b5
3d
2
0 3 7 11 2d 29 28 35
25 3a 3e 42 5e 5a 59 66
56 6b 6f 73 77 93 8f 8e
9b a8 a4 8b b0 a3 b5 b9
bd c1 c5 c9 dd a0 e1 e5
e9 ed 109 105 104 111 11e 11a
101 126 119 12b 12f 133 116 137
139 13c 13f 140 149
3d
2
0 1 9 b 15 1d :2 15 14
:2 1 b 15 1d :2 15 14 :2 1 5
e 10 1f :3 10 1f :2 10 1c 2a
31 :3 5 e 1c 0 23 :2 5 f
13 20 :3 13 20 :2 13 1c :3 5 :7 1

3d
4
0 :2 1 :8 12 :8 16
:2 1f :4 20 :4 21 1f
:2 21 :2 1f :3 2a 0
:3 2a 32 :4 33 :4 34
:3 32 36 :7 1
14b
4
:3 0 1 :3 0 2
:6 0 1 :2 0 3
:a 0 a 2 :7 0
5 :2 0 3 5
:3 0 4 :7 0 6
5 :3 0 8 :2 0
a 3 9 0
36 6 :a 0 12
3 :7 0 9 :2 0
7 5 :3 0 4
:7 0 e d :3 0
10 :2 0 12 b
11 0 36 7
:3 0 8 :a 0 21
4 :7 0 d a0
0 b 5 :3 0
9 :7 0 17 16
:6 0 f 5 :3 0
a :7 0 1b 1a
:3 0 b :3 0 5
:3 0 1d 1f 0
21 14 20 0
36 7 :3 0 c
:a 0 28 5 :7 0
b :3 0 d :3 0
25 26 0 28
23 27 0 36
e :a 0 34 6
:7 0 14 116 0
12 5 :3 0 f
:7 0 2c 2b :3 0
19 38 0 16
d :3 0 10 :7 0
30 2f :3 0 32
:2 0 34 29 33
0 36 2 :4 0
38 36 37 39
2 38 3b 0
3a 39 3c :8 0

1f
4
:3 0 1 4 1
7 1 c 1
f 1 15 1
19 2 18 1c
1 2a 1 2e
2 2d 31 5
a 12 21 28
34
1
4
0
3b
0
1
14
6
c
0 1 1 1 1 1 0 0
0 0 0 0 0 0 0 0
0 0 0 0
3 1 2
15 4 0
29 1 6
2e 6 0
14 1 4
2a 6 0
2 0 1
c 3 0
4 2 0
23 1 5
b 1 3
19 4 0
0

 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SWIFT_ADM wrapped
0
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
3
b
9200000
1
4
0
45
2 :e:
1PACKAGE:
1BODY:
1BARS_SWIFT_ADM:
1G_LAUCHK:
1NUMBER:
11:
1FUNCTION:
1ENCRYPTSTR:
1INPUT_STRING:
1VARCHAR2:
1RETURN:
1STR_KEY:
116:
1RAW_INPUT:
1RAW:
1RAW_ENCRYPTED:
1RAW_KEY:
1STR_ENCRYPTED:
132:
1RPAD:
1SUBSTR:
1VAL:
1PARAMS:
1PAR:
1SELECT rpad(substr(val,1,6),16) into str_key :n  from params where par='MFO':
1HEXTORAW:
1UTL_RAW:
1CAST_TO_RAW:
1DBMS_OBFUSCATION_TOOLKIT:
1DES3ENCRYPT:
1INPUT:
1KEY:
1RAWTOHEX:
1SETSWTKEY:
1PKEY:
1ESTR:
1UPDATE params set val=estr where par='SWT_KEY':
1ROWCOUNT:
1=:
10:
1COMM:
1INSERT into params(par,val,comm):n    values('SWT_KEY',estr,'���� SWIFT-�����+
1����'):
1SETABSKEY:
1UPDATE params set val=estr where par='ABS_KEY':
1INSERT into params(par,val,comm):n    values('ABS_KEY',estr,'���� ��� ��� SWI+
1FT'):
1SET_LAU_POLICY:
1P_SCHEMA:
1P_OBJECT:
11=1:
1imported = 'N' or lau_act=1:
1INIT_LAU_CHECK:
1L_VALUE:
1TYPE:
1SELECT val into l_value:n             from params:n            where par = 'S+
1WTLAUC':
1NO_DATA_FOUND:
1GET_LAU_CHECK:
1SET_LAU_CHECK:
1P_CODE:
1P_STATUS:
1!=:
1ejGBlgewrB@:
1RAISE_APPLICATION_ERROR:
1-:
120999:
1\SWTSEC:: ���������� �������� ���������:
1BARS_AUDIT:
1SECURITY:
1��������� �������! ������� ���������� �������� ���� LAU ��� ��������� SWIFT:
1cannot validate lau check status:
0

0
0
19d
2
0 :2 a0 97 a3 a0 51 a5 1c
81 b0 a0 8d 8f a0 b0 3d
b4 :2 a0 2c 6a a3 a0 51 a5
1c 81 b0 a3 a0 51 a5 1c
81 b0 a3 a0 51 a5 1c 81
b0 a3 a0 51 a5 1c 81 b0
a3 a0 51 a5 1c 81 b0 :6 a0
12a :3 a0 a5 b d :3 a0 6b a0
a5 b d :3 a0 6b :2 a0 e :2 a0
e a5 b d :3 a0 a5 b d
:2 a0 65 b7 a4 b1 11 68 4f
9a 8f a0 b0 3d b4 55 6a
a3 a0 51 a5 1c 81 b0 :3 a0
a5 b d :4 a0 12a a0 f 7e
51 b4 2e :5 a0 12a b7 19 3c
b7 a4 b1 11 68 4f 9a 8f
a0 b0 3d b4 55 6a a3 a0
51 a5 1c 81 b0 :3 a0 a5 b
d :4 a0 12a a0 f 7e 51 b4
2e :5 a0 12a b7 19 3c b7 a4
b1 11 68 4f a0 8d 8f a0
b0 3d 8f a0 b0 3d b4 :2 a0
2c 6a a0 7e 51 b4 2e 5a
a0 6e 65 b7 19 3c a0 6e
65 b7 a4 a0 b1 11 68 4f
9a b4 55 6a a3 :2 a0 6b :2 a0
f 1c 81 b0 :4 a0 12a a0 4c
:2 6e 5 48 5a a0 6e d b7
19 3c b7 :2 a0 6e d b7 a6
9 a4 b1 11 4f a0 7e 6e
b4 2e 5a a0 51 d b7 a0
51 d b7 :2 19 3c b7 a4 a0
b1 11 68 4f a0 8d a0 b4
a0 2c 6a :2 a0 65 b7 a4 a0
b1 11 68 4f 9a 8f a0 b0
3d 8f a0 b0 3d b4 55 6a
a0 7e 6e b4 2e 5a a0 7e
51 b4 2e 6e a5 57 :2 a0 6b
6e a5 57 b7 19 3c a0 4c
:2 51 5 48 5a a0 7e 51 b4
2e 6e a5 57 b7 19 3c a0
7e 51 b4 2e 5a :2 a0 d b7
a0 57 b3 b7 :2 19 3c b7 a4
a0 b1 11 68 4f a0 57 b3
b7 a4 b1 11 a0 b1 56 4f
1d 17 b5
19d
2
0 3 7 b 2e 19 1d 20
21 29 18 35 39 55 51 15
5d 50 62 66 6a 6e 88 76
4d 7a 7b 83 75 a5 93 72
97 98 a0 92 c2 b0 8f b4
b5 bd af df cd ac d1 d2
da cc fc ea c9 ee ef f7
e9 103 107 10b 10f 113 117 11b
127 12b 12f e6 133 135 139 13d
141 145 148 14c 14d 14f 153 157
15b 15f 162 166 16a 16c 170 174
176 177 179 17d 181 185 189 18a
18c 190 194 198 19c 19e 1a2 1a4
1b0 1b4 1b6 1d2 1ce 1cd 1da 1ca
1df 1e3 200 1eb 1ef 1f2 1f3 1fb
1ea 207 20b 20f 1e7 213 215 219
21d 221 225 229 235 239 23e 241
244 245 24a 24e 252 256 25a 25e
26a 26c 270 273 275 279 27b 287
28b 28d 2a9 2a5 2a4 2b1 2a1 2b6
2ba 2d7 2c2 2c6 2c9 2ca 2d2 2c1
2de 2e2 2e6 2be 2ea 2ec 2f0 2f4
2f8 2fc 300 30c 310 315 318 31b
31c 321 325 329 32d 331 335 341
343 347 34a 34c 350 352 35e 362
364 368 384 380 37f 38c 399 395
37c 3a1 394 3a6 3aa 3ae 3b2 3b6
391 3ba 3bd 3be 3c3 3c6 3ca 3cf
3d3 3d5 3d9 3dc 3e0 3e5 3e9 3eb
3ef 3f3 3f5 401 405 407 41b 41c
420 44d 428 42c 430 433 437 43b
440 448 427 454 458 45c 460 464
470 1 474 479 47e 424 482 485
489 48e 492 494 498 49b 49d 4a1
4a5 4aa 4ae 4b0 4b1 4b6 4ba 4bc
4c8 4ca 4ce 4d1 4d6 4d7 4dc 4df
4e3 4e6 4ea 4ec 4f0 4f3 4f7 4f9
4fd 501 504 506 50a 50e 510 51c
520 522 526 53a 53e 53f 543 547
54b 54f 553 557 559 55d 561 563
56f 573 575 591 58d 58c 599 5a6
5a2 589 5ae 5a1 5b3 5b7 5bb 59e
5bf 5c4 5c5 5ca 5cd 5d1 5d4 5d7
5d8 5dd 5e2 5e3 5e8 5ec 5f0 5f3
5f8 5f9 5fe 600 604 607 1 60b
60e 611 615 618 61b 61f 622 625
626 62b 630 631 636 638 63c 63f
643 646 649 64a 64f 652 656 65a
65e 660 664 669 66a 66c 670 674
677 679 67d 681 683 68f 693 695
699 69e 69f 6a1 6a5 6a7 6b3 6b7
6b9 6bc 6be 6bf 6c8
19d
2
0 1 9 e 5 10 17 16
:2 10 5 1 a 15 25 :2 15 14
2f 36 :2 1 3 15 1e 1d :2 15
:2 3 15 19 18 :2 15 :2 3 12 16
15 :2 12 :2 3 15 19 18 :2 15 :2 3
12 1b 1a :2 12 3 a f 16
28 8 15 :2 3 10 19 :2 10 :2 3
e :2 16 22 :2 e :2 3 14 :2 2d 4
d 4 a 13 a :2 14 :2 3 14
1d :2 14 :2 3 a 3 :6 1 b 15
1d :2 15 14 :2 1 3 9 12 11
:2 9 :2 3 b 16 :2 b 3 a 15
19 24 3 a 6 12 13 :2 12
11 18 1c 20 16 5 15 :2 3
:6 1 b 15 1d :2 15 14 :2 1 3
9 12 11 :2 9 :2 3 b 16 :2 b
3 a 15 19 24 3 a 6
12 13 :2 12 11 18 1c 20 16
5 15 :2 3 :6 1 5 e 10 1f
:3 10 1f :2 10 1c 2a 31 :2 5 d
16 18 :2 16 c d 14 d 1b
:3 9 10 9 :2 5 9 :4 5 f 0
:3 5 e 15 e :2 19 :3 e 5 13
1c :2 13 c 10 18 20 25 :2 10
f 10 1b 10 2b :2 c 8 11
24 2f 24 1f :2 c 8 :3 5 c
14 16 :2 14 b c 18 c 1b
c 18 c :4 8 :2 5 9 :5 5 e
1c 0 23 :2 5 9 10 9 :2 5
9 :4 5 f 13 20 :3 13 20 :2 13
1c :2 5 d 14 17 :2 14 c d
25 26 :2 25 2d :3 d :2 18 21 :2 d
26 :2 9 d 16 1e 20 :2 d c
d 25 26 :2 25 2d :2 d 24 :3 9
12 14 :2 12 8 9 15 9 17
:3 9 :6 5 9 :7 5 :4 1 5 :6 1
19d
4
0 :3 1 :7 13 :b 18
:7 19 :7 1a :7 1b :7 1c
:7 1d :4 1f :2 20 1f
:6 21 :8 22 :4 23 :3 24
:3 25 :3 23 :6 26 :3 27
:2 1e :4 18 :8 2d :7 2e
:6 30 :5 31 :6 32 :4 33
34 33 :3 32 :2 2f
:4 2d :8 3a :7 3b :6 3d
:5 3e :6 3f :4 40 41
40 :3 3f :2 3c :4 3a
:2 4d :4 4e :4 4f 4d
:2 4f :2 4d :6 54 :3 55
:3 54 :3 59 :2 51 5b
:4 4d 65 0 :2 65
:a 68 :2 6d 6e 6f
6d :7 71 :3 72 :3 71
6c :7 75 74 :3 6a
:6 78 :3 79 78 :3 7b
7a :3 78 :2 6a 7e
:4 65 :3 87 0 :3 87
:3 8a :2 89 8b :4 87
93 :4 94 :4 95 :3 93
:6 99 :8 9a :6 9b :3 99
:7 9e :8 9f :3 9e :6 a5
:3 a6 a5 :3 a8 a7
:3 a5 :2 97 ab :4 93
:3 ae :4 ad af :6 1

6ca
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 7 4d 0
:2 5 :3 0 6 :2 0
3 5 7 :6 0
a 8 0 197
0 4 :6 0 7
:3 0 8 :a 0 68
2 :7 0 d :2 0
9 a :3 0 9
:7 0 f e :3 0
b :3 0 a :3 0
11 13 0 68
c 14 :2 0 d
:2 0 d a :3 0
b 17 19 :6 0
1c 1a 0 66
0 c :6 0 d
:2 0 11 f :3 0
f 1e 20 :6 0
23 21 0 66
0 e :6 0 d
:2 0 15 f :3 0
13 25 27 :6 0
2a 28 0 66
0 10 :6 0 13
:2 0 19 f :3 0
17 2c 2e :6 0
31 2f 0 66
0 11 :6 0 1f
:2 0 1d a :3 0
1b 33 35 :6 0
38 36 0 66
0 12 :6 0 14
:3 0 15 :3 0 16
:3 0 c :3 0 17
:3 0 18 :4 0 19
1 :8 0 64 e
:3 0 1a :3 0 9
:3 0 41 43 40
44 0 64 11
:3 0 1b :3 0 1c
:3 0 47 48 0
c :3 0 21 49
4b 46 4c 0
64 10 :3 0 1d
:3 0 1e :3 0 4f
50 0 1f :3 0
e :3 0 52 53
20 :3 0 11 :3 0
55 56 23 51
58 4e 59 0
64 12 :3 0 21
:3 0 10 :3 0 26
5c 5e 5b 5f
0 64 b :3 0
12 :3 0 62 :2 0
64 28 67 :3 0
67 2f 67 66
64 65 :6 0 68
1 0 c 14
67 197 :2 0 22
:a 0 97 3 :7 0
37 :2 0 35 a
:3 0 23 :7 0 6d
6c :3 0 6f :2 0
97 6a 70 :2 0
3d :2 0 3b a
:3 0 13 :2 0 39
73 75 :6 0 78
76 0 95 0
24 :6 0 24 :3 0
8 :3 0 23 :3 0
7a 7c 79 7d
0 93 17 :3 0
16 :3 0 24 :3 0
18 :4 0 25 1
:8 0 93 26 :4 0
84 :3 0 27 :2 0
28 :2 0 41 86
88 :3 0 17 :3 0
18 :3 0 16 :3 0
29 :3 0 24 :4 0
2a 1 :8 0 90
44 91 89 90
0 92 46 0
93 48 96 :3 0
96 4c 96 95
93 94 :6 0 97
1 0 6a 70
96 197 :2 0 2b
:a 0 c6 4 :7 0
50 :2 0 4e a
:3 0 23 :7 0 9c
9b :3 0 9e :2 0
c6 99 9f :2 0
56 :2 0 54 a
:3 0 13 :2 0 52
a2 a4 :6 0 a7
a5 0 c4 0
24 :6 0 24 :3 0
8 :3 0 23 :3 0
a9 ab a8 ac
0 c2 17 :3 0
16 :3 0 24 :3 0
18 :4 0 2c 1
:8 0 c2 26 :4 0
b3 :3 0 27 :2 0
28 :2 0 5a b5
b7 :3 0 17 :3 0
18 :3 0 16 :3 0
29 :3 0 24 :4 0
2d 1 :8 0 bf
5d c0 b8 bf
0 c1 5f 0
c2 61 c5 :3 0
c5 65 c5 c4
c2 c3 :6 0 c6
1 0 99 9f
c5 197 :2 0 7
:3 0 2e :a 0 eb
5 :7 0 69 391
0 67 a :3 0
2f :7 0 cc cb
:3 0 27 :2 0 6b
a :3 0 30 :7 0
d0 cf :3 0 b
:3 0 a :3 0 d2
d4 0 eb c9
d5 :2 0 4 :3 0
28 :2 0 70 d8
da :3 0 db :2 0
b :3 0 31 :4 0
de :2 0 e0 73
e1 dc e0 0
e2 75 0 e6
b :3 0 32 :4 0
e4 :2 0 e6 77
ea :3 0 ea 2e
:4 0 ea e9 e6
e7 :6 0 eb 1
0 c9 d5 ea
197 :2 0 33 :a 0
12f 6 :8 0 ee
:2 0 12f ed ef
:2 0 100 101 104
7a 17 :3 0 16
:2 0 4 f2 f3
0 35 :3 0 35
:2 0 1 f4 f6
:3 0 f7 :7 0 fa
f8 0 12d 0
34 :6 0 16 :3 0
34 :3 0 17 :3 0
18 :4 0 36 1
:8 0 10d 34 :3 0
28 :4 0 6 :4 0
7c :3 0 105 :2 0
34 :3 0 28 :4 0
107 108 0 10a
7f 10b 106 10a
0 10c 81 0
10d 83 117 37
:3 0 34 :3 0 28
:4 0 10f 110 0
112 86 114 88
113 112 :2 0 115
8a :2 0 117 0
117 116 10d 115
:6 0 12a 6 :3 0
34 :3 0 27 :2 0
28 :4 0 8e 11a
11c :3 0 11d :2 0
4 :3 0 28 :2 0
11f 120 0 122
91 127 4 :3 0
6 :2 0 123 124
0 126 93 128
11e 122 0 129
0 126 0 129
95 0 12a 98
12e :3 0 12e 33
:3 0 9b 12e 12d
12a 12b :6 0 12f
1 0 ed ef
12e 197 :2 0 7
:3 0 38 :a 0 140
8 :7 0 b :4 0
5 :3 0 134 135
0 140 132 136
:2 0 b :3 0 4
:3 0 139 :2 0 13b
9d 13f :3 0 13f
38 :4 0 13f 13e
13b 13c :6 0 140
1 0 132 136
13f 197 :2 0 39
:a 0 18d 9 :7 0
a1 59e 0 9f
a :3 0 3a :7 0
145 144 :3 0 3c
:2 0 a3 5 :3 0
3b :7 0 149 148
:3 0 14b :2 0 18d
142 14c :2 0 3a
:3 0 3d :4 0 a8
14f 151 :3 0 152
:2 0 3e :3 0 3f
:2 0 40 :2 0 ab
155 157 :3 0 41
:4 0 ad 154 15a
:2 0 162 42 :3 0
43 :3 0 15c 15d
0 44 :4 0 b0
15e 160 :2 0 162
b2 163 153 162
0 164 b5 0
188 3b :3 0 28
:2 0 6 :2 0 b7
:3 0 165 166 169
16a :2 0 3e :3 0
3f :2 0 40 :2 0
ba 16d 16f :3 0
45 :4 0 bc 16c
172 :2 0 174 bf
175 16b 174 0
176 c1 0 188
3b :3 0 27 :2 0
28 :2 0 c5 178
17a :3 0 17b :2 0
4 :3 0 3b :3 0
17d 17e 0 180
c8 185 33 :3 0
181 183 :2 0 184
0 ca 186 17c
180 0 187 0
184 0 187 cc
0 188 cf 18c
:3 0 18c 39 :4 0
18c 18b 188 189
:6 0 18d 1 0
142 14c 18c 197
:2 0 33 :3 0 18f
191 :2 0 192 0
d3 195 :3 0 195
0 195 197 192
193 :6 0 198 :2 0
3 :3 0 d5 0
3 195 19b :3 0
19a 198 19c :8 0

de
4
:3 0 1 6 1
4 1 d 1
10 1 18 1
16 1 1f 1
1d 1 26 1
24 1 2d 1
2b 1 34 1
32 1 42 1
4a 2 54 57
1 5d 6 3f
45 4d 5a 60
63 5 1b 22
29 30 37 1
6b 1 6e 1
74 1 72 1
7b 1 87 2
85 87 1 8f
1 91 3 7e
83 92 1 77
1 9a 1 9d
1 a3 1 a1
1 aa 1 b6
2 b4 b6 1
be 1 c0 3
ad b2 c1 1
a6 1 ca 1
ce 2 cd d1
1 d9 2 d7
d9 1 df 1
e1 2 e2 e5
1 f1 2 102
103 1 109 1
10b 2 ff 10c
1 111 1 10e
1 114 1 11b
2 119 11b 1
121 1 125 2
127 128 2 117
129 1 f9 1
13a 1 143 1
147 2 146 14a
1 150 2 14e
150 1 156 2
158 159 1 15f
2 15b 161 1
163 2 167 168
1 16e 2 170
171 1 173 1
175 1 179 2
177 179 1 17f
1 182 2 185
186 3 164 176
187 1 190 8
9 68 97 c6
eb 12f 140 18d

1
4
0
19b
0
1
14
9
18
0 1 1 1 1 1 6 1
1 0 0 0 0 0 0 0
0 0 0 0
c 1 2
d 2 0
6a 1 3
2b 2 0
4 1 0
ca 5 0
142 1 9
147 9 0
c9 1 5
a1 4 0
72 3 0
143 9 0
f1 6 0
ed 1 6
3 0 1
9a 4 0
6b 3 0
132 1 8
32 2 0
99 1 4
24 2 0
1d 2 0
ce 5 0
16 2 0
0
/
 show err;
 
PROMPT *** Create  grants  BARS_SWIFT_ADM ***
grant EXECUTE                                                                on BARS_SWIFT_ADM  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_swift_adm.sql =========*** End 
 PROMPT ===================================================================================== 
 