
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_cur_rates.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_CUR_RATES is

  -- PRAVEX
  -------------------------------------------------
  -- Author  : Oleg
  -- Purpose : Установка и визирование курсов валют
  --
  -- Change log:
  --
  --  17.05.2007 Oleg  Создание
  --

  -----
  -- header_version - возвращает версию заголова пакета
  --
  function header_version return varchar2;

  -----
  -- body_version - возвращает версию тела пакета
  --
  function body_version return varchar2;

  -----
  -- set_rate - устанавливает курс покупки/продажи
  -- @p_kv - валюта
  -- @p_vdate - дата установки курса
  -- @p_branch - подразделение
  -- @p_rate_b - курс покупки
  -- @p_rate_s - курс продажи
  procedure set_rate(p_kv in number, p_vdate in date, p_branch in varchar2, p_rate_b in number, p_rate_s in number);

  -----
  -- set_visa - визирует курс
  -- @p_kv - валюта
  -- @p_vdate - дата установки курса
  -- @p_branch - подразделение
  -- @p_otm - отметка о визировании (Y-завизировано, N-нет)
  procedure set_visa(p_kv in number, p_vdate in date, p_branch in varchar2, p_otm in char);

end bars_cur_rates;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_CUR_RATES wrapped
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
42
2 :e:
1PACKAGE:
1BODY:
1BARS_CUR_RATES:
1G_HEADER_VERSION:
1VARCHAR2:
130:
1header version 1.0 17/05/2007:
1G_BODY_VERSION:
1body version 1.1 19/06/2009:
1G_MODULE_NAME:
13:
1BRS:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1BODY_VERSION:
1SET_RATE:
1P_KV:
1NUMBER:
1P_VDATE:
1DATE:
1P_BRANCH:
1P_RATE_B:
1P_RATE_S:
1L_CUR_BRANCH:
1BRANCH:
1TYPE:
1BRANCH_USR:
1GET_BRANCH:
1SUBSTR:
1!=:
11:
1LENGTH:
1BARS_ERROR:
1RAISE_ERROR:
118003:
1CUR_RATES$BASE:
1RATE_B:
1RATE_S:
1KV:
1VDATE:
1UPDATE cur_rates$base:n       set rate_b = p_rate_b, rate_s = p_rate_s :n    +
1 where kv = p_kv:n       and vdate = p_vdate:n       and branch = p_branch:
1ROWCOUNT:
1=:
10:
118002:
1TO_CHAR:
1dd.mm.yyyy:
1BARS_AUDIT:
1FINANCIAL:
1BARS_MSG:
1GET_MSG:
1RATES_ENTERED:
1USER_NAME:
1USER_ID:
1SET_VISA:
1P_OTM:
1CHAR:
1L_MSG_STR:
1100:
118004:
1OTM:
1UPDATE cur_rates$base:n       set otm = p_otm :n     where kv = p_kv:n       +
1and vdate = p_vdate:n       and branch = p_branch:
1Y:
1RATES_VISED:
1RATES_VISA_BACK:
0

0
0
16a
2
0 :2 a0 97 a3 a0 51 a5 1c
6e 81 b0 a3 a0 51 a5 1c
6e 81 b0 a3 a0 51 a5 1c
6e 81 b0 a0 8d a0 b4 a0
2c 6a :2 a0 65 b7 a4 b1 11
68 4f a0 8d a0 b4 a0 2c
6a :2 a0 65 b7 a4 b1 11 68
4f 9a 8f a0 b0 3d 8f a0
b0 3d 8f a0 b0 3d 8f a0
b0 3d 8f a0 b0 3d b4 55
6a a3 :2 a0 6b :2 a0 f 1c 81
b0 :3 a0 6b d :2 a0 7e a0 51
:2 a0 a5 b a5 b b4 2e :2 a0
6b a0 51 a5 57 b7 19 3c
:b a0 12a a0 f 7e 51 b4 2e
:2 a0 6b a0 51 :2 a0 a5 b :2 a0
6e a5 b a0 a5 57 b7 19
3c :2 a0 6b :2 a0 6b a0 6e :3 a0
a5 b :2 a0 a5 b :2 a0 a5 b
:2 a0 a5 b :3 a0 6e a5 b a5
b a5 57 b7 a4 b1 11 68
4f 9a 8f a0 b0 3d 8f a0
b0 3d 8f a0 b0 3d 8f a0
b0 3d b4 55 6a a3 a0 51
a5 1c 81 b0 a3 :2 a0 6b :2 a0
f 1c 81 b0 :3 a0 6b d :2 a0
7e a0 51 :2 a0 a5 b a5 b
b4 2e :2 a0 6b a0 51 a5 57
b7 19 3c :9 a0 12a a0 f 7e
51 b4 2e :2 a0 6b a0 51 :2 a0
a5 b :2 a0 6e a5 b a0 a5
57 b7 19 3c a0 7e 6e b4
2e a0 6e d b7 a0 6e d
b7 :2 19 3c :2 a0 6b :2 a0 6b :5 a0
a5 b :2 a0 a5 b :3 a0 6e a5
b a5 b a5 57 b7 a4 b1
11 68 4f b1 b7 a4 11 a0
b1 56 4f 1d 17 b5
16a
2
0 3 7 b 33 19 1d 20
21 29 2e 18 55 3e 15 42
43 4b 50 3d 77 60 3a 64
65 6d 72 5f 7e 82 96 5c
9a 9e a2 a6 aa ae b2 b4
b8 ba c6 ca cc d0 e4 e8
e9 ed f1 f5 f9 fd 101 103
107 109 115 119 11b 137 133 132
13f 14c 148 12f 154 15d 159 147
165 172 16e 144 17a 183 17f 16d
18b 16a 190 194 1c1 19c 1a0 1a4
1a7 1ab 1af 1b4 1bc 19b 1c8 1cc
1d0 198 1d4 1d8 1dc 1e0 1e3 1e7
1ea 1ee 1f2 1f3 1f5 1f6 1f8 1f9
1fe 202 206 209 20d 210 211 216
218 21c 21f 223 227 22b 22f 233
237 23b 23f 243 247 24b 257 25b
260 263 266 267 26c 270 274 277
27b 27e 282 286 287 289 28d 291
296 297 299 29d 29e 2a3 2a5 2a9
2ac 2b0 2b4 2b7 2bb 2bf 2c2 2c6
2cb 2cf 2d3 2d7 2d8 2da 2de 2e2
2e3 2e5 2e9 2ed 2ee 2f0 2f4 2f8
2f9 2fb 2ff 303 307 30c 30d 30f
310 312 313 318 31a 31e 320 32c
330 332 34e 34a 349 356 363 35f
346 36b 374 370 35e 37c 389 385
35b 391 384 396 39a 3b4 3a2 381
3a6 3a7 3af 3a1 3e1 3bf 3c3 39e
3c7 3cb 3cf 3d4 3dc 3be 3e8 3ec
3f0 3bb 3f4 3f8 3fc 400 403 407
40a 40e 412 413 415 416 418 419
41e 422 426 429 42d 430 431 436
438 43c 43f 443 447 44b 44f 453
457 45b 45f 463 46f 473 478 47b
47e 47f 484 488 48c 48f 493 496
49a 49e 49f 4a1 4a5 4a9 4ae 4af
4b1 4b5 4b6 4bb 4bd 4c1 4c4 4c8
4cb 4d0 4d1 4d6 4da 4df 4e3 4e5
4e9 4ee 4f2 4f4 4f8 4fc 4ff 503
507 50a 50e 512 515 519 51d 521
525 529 52a 52c 530 534 535 537
53b 53f 543 548 549 54b 54c 54e
54f 554 556 55a 55c 568 56c 56e
570 572 576 582 586 588 58b 58d
58e 597
16a
2
0 1 9 e 3 14 1d 1c
14 24 14 :2 3 12 1b 1a 12
22 12 :2 3 11 1a 19 11 20
11 :2 3 c 1b 0 22 :2 3 5
c 5 :7 3 c 19 0 20 :2 3
5 c 5 :6 3 d 16 1e :2 16
26 31 :2 26 37 43 :2 37 4d 59
:2 4d 61 6d :2 61 15 :2 3 5 12
19 12 :2 20 :3 12 :2 5 15 :2 20 5
8 18 15 1f 28 2a 31 :2 2a
:2 18 :2 15 7 :2 12 1e 2c :2 7 40
:2 5 :2 c 15 1f 28 c 11 c
14 c 15 5 c 8 14 15
:2 14 7 :2 12 1e 2d 34 3c :2 34
43 4b 53 :2 43 61 :2 7 17 :3 5
:2 10 7 :2 10 18 27 38 43 4b
:2 43 9 11 :2 9 18 20 :2 18 2b
33 :2 2b 3e 9 11 19 :2 9 :2 7
:2 5 :6 3 d 16 1e :2 16 26 31
:2 26 37 43 :2 37 4d 56 :2 4d 15
:2 3 5 f 18 17 :2 f :2 5 12
19 12 :2 20 :3 12 :2 5 15 :2 20 5
8 18 15 1f 28 2a 31 :2 2a
:2 18 :2 15 7 :2 12 1e 2c :2 7 40
:2 5 :2 c 12 c 11 c 14 c
15 5 c 8 14 15 :2 14 7
:2 12 1e 2d 34 3c :2 34 43 4b
53 :2 43 61 :2 7 17 :2 5 8 e
10 :2 e c 19 c 7 c 19
c 7 :4 5 :2 10 7 :2 10 18 27
32 3d 45 :2 3d 9 11 :2 9 18
22 2a 32 :2 22 :2 7 :2 5 :a 3 5
:6 1
16a
4
0 :3 1 :8 3 :8 4
:8 5 :3 a 0 :3 a
:3 c :2 b :4 a :3 12
0 :3 12 :3 14 :2 13
:4 12 :18 1e :a 1f :5 22
:d 24 :7 26 :3 24 29
:4 2a :2 2b :2 2c :2 2d
29 :6 2f :11 31 :3 2f
:3 34 :a 35 :d 36 :5 37
:2 35 :2 34 :2 20 :4 1e
:14 42 :7 43 :a 44 :5 47
:d 49 :7 4b :3 49 4e
:2 4f :2 50 :2 51 :2 52
4e :6 54 :11 56 :3 54
:5 59 :4 5a :4 5b :3 59
:3 5e :a 5f :a 60 :2 5f
:2 5e :2 45 :4 42 :4 a
65 :6 1
599
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 6 :2 0 :2 5
:3 0 6 :2 0 3
5 7 :6 0 7
:4 0 b 8 9
164 0 4 :6 0
b :2 0 9 5
:3 0 7 d f
:6 0 9 :4 0 13
10 11 164 0
8 :9 0 d 5
:3 0 b 15 17
:6 0 c :4 0 1b
18 19 164 0
a :6 0 d :3 0
e :a 0 2a 2
:7 0 f :3 0 5
:3 0 1f 20 0
2a 1d 21 :2 0
f :3 0 4 :3 0
24 :2 0 26 f
29 :3 0 29 0
29 28 26 27
:6 0 2a 1 0
1d 21 29 164
:2 0 d :3 0 10
:a 0 3a 3 :7 0
f :4 0 5 :3 0
2f 30 0 3a
2d 31 :2 0 f
:3 0 8 :3 0 34
:2 0 36 11 39
:3 0 39 0 39
38 36 37 :6 0
3a 1 0 2d
31 39 164 :2 0
11 :a 0 c7 4
:7 0 15 144 0
:2 13 :3 0 12 :7 0
3f 3e :3 0 19
16a 0 17 15
:3 0 14 :7 0 43
42 :3 0 5 :3 0
16 :7 0 47 46
:3 0 1d :2 0 1b
13 :3 0 17 :7 0
4b 4a :3 0 13
:3 0 18 :7 0 4f
4e :3 0 51 :2 0
c7 3c 52 :2 0
5f 60 0 23
1a :3 0 1a :2 0
4 55 56 0
1b :3 0 1b :2 0
1 57 59 :3 0
5a :7 0 5d 5b
0 c5 0 19
:6 0 19 :3 0 1c
:3 0 1d :3 0 5e
61 0 c3 19
:3 0 1e :3 0 1f
:2 0 16 :3 0 20
:2 0 21 :3 0 19
:3 0 25 68 6a
27 64 6c 2d
65 6e :3 0 22
:3 0 23 :3 0 70
71 0 a :3 0
24 :2 0 30 72
75 :2 0 77 33
78 6f 77 0
79 35 0 c3
25 :3 0 26 :3 0
17 :3 0 27 :3 0
18 :3 0 28 :3 0
12 :3 0 29 :3 0
14 :3 0 1a :3 0
16 :4 0 2a 1
:8 0 c3 2b :4 0
86 :3 0 2c :2 0
2d :2 0 39 88
8a :3 0 22 :3 0
23 :3 0 8c 8d
0 a :3 0 2e
:2 0 2f :3 0 12
:3 0 3c 91 93
2f :3 0 14 :3 0
30 :4 0 3e 95
98 16 :3 0 41
8e 9b :2 0 9d
47 9e 8b 9d
0 9f 49 0
c3 31 :3 0 32
:3 0 a0 a1 0
33 :3 0 34 :3 0
a3 a4 0 a
:3 0 35 :4 0 36
:3 0 2f :3 0 37
:3 0 4b a9 ab
2f :3 0 12 :3 0
4d ad af 2f
:3 0 17 :3 0 4f
b1 b3 2f :3 0
18 :3 0 51 b5
b7 16 :3 0 2f
:3 0 14 :3 0 30
:4 0 53 ba bd
56 a5 bf 60
a2 c1 :2 0 c3
62 c6 :3 0 c6
68 c6 c5 c3
c4 :6 0 c7 1
0 3c 52 c6
164 :2 0 38 :a 0
15d 5 :7 0 6c
35b 0 6a 13
:3 0 12 :7 0 cc
cb :3 0 70 381
0 6e 15 :3 0
14 :7 0 d0 cf
:3 0 5 :3 0 16
:7 0 d4 d3 :3 0
3c :2 0 72 3a
:3 0 39 :7 0 d8
d7 :3 0 da :2 0
15d c9 db :2 0
e5 e6 0 79
5 :3 0 77 de
e0 :6 0 e3 e1
0 15b 0 3b
:6 0 ef f0 0
7b 1a :3 0 1a
:2 0 4 1b :3 0
1b :2 0 1 e7
e9 :3 0 ea :7 0
ed eb 0 15b
0 19 :6 0 19
:3 0 1c :3 0 1d
:3 0 ee f1 0
159 19 :3 0 1e
:3 0 1f :2 0 16
:3 0 20 :2 0 21
:3 0 19 :3 0 7d
f8 fa 7f f4
fc 85 f5 fe
:3 0 22 :3 0 23
:3 0 100 101 0
a :3 0 3d :2 0
88 102 105 :2 0
107 8b 108 ff
107 0 109 8d
0 159 25 :3 0
3e :3 0 39 :3 0
28 :3 0 12 :3 0
29 :3 0 14 :3 0
1a :3 0 16 :4 0
3f 1 :8 0 159
2b :4 0 114 :3 0
2c :2 0 2d :2 0
91 116 118 :3 0
22 :3 0 23 :3 0
11a 11b 0 a
:3 0 2e :2 0 2f
:3 0 12 :3 0 94
11f 121 2f :3 0
14 :3 0 30 :4 0
96 123 126 16
:3 0 99 11c 129
:2 0 12b 9f 12c
119 12b 0 12d
a1 0 159 39
:3 0 2c :2 0 40
:4 0 a5 12f 131
:3 0 3b :3 0 41
:4 0 133 134 0
136 a8 13b 3b
:3 0 42 :4 0 137
138 0 13a aa
13c 132 136 0
13d 0 13a 0
13d ac 0 159
31 :3 0 32 :3 0
13e 13f 0 33
:3 0 34 :3 0 141
142 0 a :3 0
3b :3 0 36 :3 0
2f :3 0 37 :3 0
af 147 149 2f
:3 0 12 :3 0 b1
14b 14d 16 :3 0
2f :3 0 14 :3 0
30 :4 0 b3 150
153 b6 143 155
be 140 157 :2 0
159 c0 15c :3 0
15c c7 15c 15b
159 15a :6 0 15d
1 0 c9 db
15c 164 :3 0 162
0 162 :3 0 162
164 160 161 :6 0
165 :2 0 3 :3 0
ca 0 3 162
168 :3 0 167 165
169 :8 0
d2
4
:3 0 1 6 1
4 1 e 1
c 1 16 1
14 1 25 1
35 1 3d 1
41 1 45 1
49 1 4d 5
40 44 48 4c
50 1 54 1
69 3 66 67
6b 1 6d 2
63 6d 2 73
74 1 76 1
78 1 89 2
87 89 1 92
2 96 97 5
8f 90 94 99
9a 1 9c 1
9e 1 aa 1
ae 1 b2 1
b6 2 bb bc
9 a6 a7 a8
ac b0 b4 b8
b9 be 1 c0
5 62 79 85
9f c2 1 5c
1 ca 1 ce
1 d2 1 d6
4 cd d1 d5
d9 1 df 1
dd 1 e4 1
f9 3 f6 f7
fb 1 fd 2
f3 fd 2 103
104 1 106 1
108 1 117 2
115 117 1 120
2 124 125 5
11d 11e 122 127
128 1 12a 1
12c 1 130 2
12e 130 1 135
1 139 2 13b
13c 1 148 1
14c 2 151 152
7 144 145 146
14a 14e 14f 154
1 156 6 f2
109 113 12d 13d
158 2 e2 ec
7 a 12 1a
2a 3a c7 15d

1
4
0
168
0
1
14
5
14
0 1 1 1 1 0 0 0
0 0 0 0 0 0 0 0
0 0 0 0
d6 5 0
3c 1 4
4 1 0
4d 4 0
e4 5 0
54 4 0
2d 1 3
ca 5 0
3d 4 0
c9 1 5
14 1 0
ce 5 0
41 4 0
dd 5 0
d2 5 0
45 4 0
49 4 0
3 0 1
c 1 0
1d 1 2
0
/
 show err;
 
PROMPT *** Create  grants  BARS_CUR_RATES ***
grant EXECUTE                                                                on BARS_CUR_RATES  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_CUR_RATES  to WR_ALL_RIGHTS;
grant EXECUTE                                                                on BARS_CUR_RATES  to WR_RATES;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_cur_rates.sql =========*** End 
 PROMPT ===================================================================================== 
 