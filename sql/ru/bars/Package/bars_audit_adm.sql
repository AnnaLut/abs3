
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_audit_adm.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_AUDIT_ADM 
is



   ------------------------------------------------------------------
   -- Константы
   --
   --
   g_headerVersion   constant varchar2(64)  := 'version 1.00 02.11.2005';
   g_headerDefs      constant varchar2(512) := '';


    -----------------------------------------------------------------
    -- CREATE_AUDIT_PARTITION()
    --
    --     Создание секции в таблице журнала аудита до указанной
    --     даты. В результате будут созданы секции для всех дат
    --     от последней созданной в таблице аудита до указанной
    --
    --
     procedure create_audit_partition(
         p_partEndDate   in  date  );


    -----------------------------------------------------------------
    -- SET_LOG_LEVEL()
    --
    --     Устанавливает уровень детализации протокола
    --     для указанного пользователя
    --
     procedure set_log_level(
         p_staffid       in  number,
         p_loglevel      in  varchar2 );


    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2;



    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2;



end bars_audit_adm;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_AUDIT_ADM wrapped
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
4d
2 :e:
1PACKAGE:
1BODY:
1BARS_AUDIT_ADM:
1G_BODYVERSION:
1CONSTANT:
1VARCHAR2:
164:
1version 1.00 02.11.2005:
1G_BODYDEFS:
1512:
1:
1MODULE_PREFIX:
13:
1SEC:
1CREATE_AUDIT_PARTITION:
1P_PARTENDDATE:
1DATE:
1L_PARTBEGINDATE:
1L_LASTPARTNAME:
130:
1L_CURRPARTDATE:
1L_CURRPARTNAME:
1PARTITION_NAME:
1USER_TAB_PARTITIONS:
1TABLE_NAME:
1=:
1SEC_AUDIT:
1PARTITION_POSITION:
1MAX:
1TO_DATE:
1SUBSTR:
12:
1yyyymmdd:
1OTHERS:
1BARS_ERROR:
1RAISE_ERROR:
1702:
1-:
1>:
1300:
1703:
1+:
1WHILE:
1TRUNC:
1<=:
1LOOP:
1P:
1||:
1TO_CHAR:
11:
1EXECUTE:
1IMMEDIATE:
1alter table sec_audit add partition :
1 values less than (to_date(':
1ddmmyyyy:
1', 'ddmmyyyy')):
1SET_LOG_LEVEL:
1P_STAFFID:
1NUMBER:
1P_LOGLEVEL:
1SEC_USERAUDIT:
1LOG_LEVEL:
1STAFF_ID:
1ROWCOUNT:
10:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1package header BARS_AUDIT_ADM :
1G_HEADERVERSION:
1CHR:
110:
1package header definition(s):::
1G_HEADERDEFS:
1BODY_VERSION:
1package body BARS_AUDIT_ADM :
1package body definition(s):::
0

0
0
175
2
0 :2 a0 97 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 9a 8f a0 b0 3d
b4 55 6a a3 a0 1c 81 b0
a3 a0 51 a5 1c 81 b0 a3
a0 1c 81 b0 a3 a0 51 a5
1c 81 b0 a0 ac :2 a0 b2 ee
a0 7e 6e b4 2e a0 7e a0
9f a0 d2 ac a0 b2 ee a0
7e 6e b4 2e ac d0 eb b4
2e a 10 ac e5 d0 b2 e9
:4 a0 51 a5 b 6e a5 b d
b7 a0 53 :2 a0 6b a0 51 a5
57 b7 a6 9 a4 b1 11 4f
a0 7e a0 b4 2e 7e 51 b4
2e 5a :2 a0 6b a0 51 a5 57
b7 19 3c :2 a0 7e 51 b4 2e
d :3 a0 7e a0 a5 b b4 2e
a0 5a 82 a0 6e 7e :2 a0 7e
51 b4 2e 6e a5 b b4 2e
d :2 a0 6e 7e a0 b4 2e 7e
6e b4 2e 7e :2 a0 6e a5 b
b4 2e 7e 6e b4 2e 11e 11d
:2 a0 7e 51 b4 2e d b7 a0
47 b7 a4 a0 b1 11 68 4f
9a 8f a0 b0 3d 8f a0 b0
3d b4 55 6a :3 a0 e7 :2 a0 7e
b4 2e ef f9 e9 a0 f 7e
51 b4 2e 5a :5 a0 5 d7 b2
5 e9 b7 19 3c b7 a4 a0
b1 11 68 4f a0 8d a0 b4
a0 2c 6a a0 6e 7e a0 b4
2e 7e a0 51 a5 b b4 2e
7e 6e b4 2e 7e a0 51 a5
b b4 2e 7e a0 b4 2e 65
b7 a4 a0 b1 11 68 4f a0
8d a0 b4 a0 2c 6a a0 6e
7e a0 b4 2e 7e a0 51 a5
b b4 2e 7e 6e b4 2e 7e
a0 51 a5 b b4 2e 7e a0
b4 2e 65 b7 a4 a0 b1 11
68 4f b1 b7 a4 11 a0 b1
56 4f 1d 17 b5
175
2
0 3 7 b 36 19 1d 21
24 25 2d 32 18 5b 41 45
15 49 4a 52 57 40 80 66
6a 3d 6e 6f 77 7c 65 87
a3 9f 62 ab 9e b0 b4 cd
bc c0 c8 9b e9 d4 d8 db
dc e4 bb 105 f4 f8 100 b8
121 10c 110 113 114 11c f3 128
f0 12c 130 134 135 13c 140 143
148 149 14e 152 155 159 15c 160
164 165 169 16a 171 175 178 17d
17e 183 184 188 18c 18d 1 192
197 198 19e 1a2 1a3 1a8 1ac 1b0
1b4 1b8 1bb 1bc 1be 1c3 1c4 1c6
1ca 1cc 1 1d0 1d4 1d8 1db 1df
1e2 1e3 1e8 1ea 1eb 1f0 1f4 1f6
202 204 208 20b 20f 210 215 218
21b 21c 221 224 228 22c 22f 233
236 237 23c 23e 242 245 249 24d
250 253 254 259 25d 261 265 269
26c 270 271 273 274 279 27d 280
282 286 28b 28e 292 296 299 29c
29d 2a2 2a7 2a8 2aa 2ab 2b0 2b4
2b8 2bc 2c1 2c4 2c8 2c9 2ce 2d1
2d6 2d7 2dc 2df 2e3 2e7 2ec 2ed
2ef 2f0 2f5 2f8 2fd 2fe 303 308
30c 310 314 317 31a 31b 320 324
326 32a 331 333 337 33b 33d 349
34d 34f 36b 367 366 373 380 37c
363 388 37b 38d 391 395 399 39d
378 3a1 3a5 3a9 3ac 3ad 3b2 3b8
3b9 3be 3c2 3c7 3ca 3cd 3ce 3d3
3d6 3da 3de 3e2 3e6 3ea 3ee 3f6
3f7 3fb 400 402 406 409 40b 40f
413 415 421 425 427 42b 43f 443
444 448 44c 450 454 459 45c 460
461 466 469 46d 470 471 473 474
479 47c 481 482 487 48a 48e 491
492 494 495 49a 49d 4a1 4a2 4a7
4ab 4ad 4b1 4b5 4b7 4c3 4c7 4c9
4cd 4e1 4e5 4e6 4ea 4ee 4f2 4f6
4fb 4fe 502 503 508 50b 50f 512
513 515 516 51b 51e 523 524 529
52c 530 533 534 536 537 53c 53f
543 544 549 54d 54f 553 557 559
565 569 56b 56d 56f 573 57f 583
585 588 58a 58b 594
175
2
0 1 9 e 6 16 1f 28
27 1f 30 16 :2 6 16 1f 28
27 1f 30 16 :2 6 16 1f 28
27 1f 30 16 6 10 a 1e
:2 a 26 :3 6 :3 17 :2 6 17 20 1f
:2 17 :2 6 :3 17 :2 6 17 20 1f :2 17
6 :4 11 c :2 11 1c 1e :2 1c 11
24 :2 2e 32 :3 2e 29 :2 2e 39 3b
:2 39 29 27 26 :4 11 c :4 a e
21 29 30 40 :2 29 44 :2 21 e
a :2 13 12 :2 1d 29 38 :2 12 1a
:2 e a :3 6 e 1c 1e :2 e 2e
30 :2 2e d e :2 19 25 34 :2 e
35 :3 a 1c 2c 2e :2 1c :2 a 11
23 20 29 :2 23 :2 20 a 10 a
e 20 24 27 2f 3d 3e :2 2f
41 :2 27 :2 20 :2 e 16 20 47 4a
:2 20 59 :3 20 40 43 4b 5b :2 43
:2 20 67 6a :2 20 :3 e 20 2f 31
:2 20 e a e a :2 6 a :4 6
10 a 1e :3 a 1e :2 a 1d :2 6
:2 11 1e :2 11 1c :3 1a :3 a 12 e
1b 1d :2 1b d 1a 29 33 16
21 15 :4 e 20 :2 a :2 6 a :4 6
5 e 1d 0 24 :2 5 9 10
31 34 :2 10 44 47 4b :2 47 :2 10
4f :3 10 30 33 37 :2 33 :2 10 3b
3e :2 10 9 :2 5 9 :5 5 e 1b
0 22 :2 5 9 10 2f 32 :2 10
40 43 47 :2 43 :2 10 4b :3 10 2e
31 35 :2 31 :2 10 39 3c :2 10 9
:2 5 9 :4 5 :4 6 5 :6 1
175
4
0 :3 1 :9 8 :9 9
:9 b 17 :4 18 :3 17
:5 1b :7 1c :5 1d :7 1e
:2 22 23 :3 24 :5 25
:7 26 :3 27 :5 28 27
:4 26 :2 25 24 :4 22
:b 2c 2a :2 2f :7 30
:3 2f 2e :3 20 :a 34
:7 35 :3 34 :7 38 :9 3a
3b :2 3a :f 3e :8 41
42 :2 41 :6 42 :2 41
:2 42 :4 41 :7 45 3b
47 3a :2 20 49
:4 17 51 :4 52 :4 53
:3 51 57 :3 58 :5 59
:3 57 :7 5b :3 5d :3 5e
:4 5d :3 5b :2 55 62
:4 51 :3 6c 0 :3 6c
:e 6f 70 :2 6f :5 70
:2 6f :2 70 :3 6f :2 6e
71 :4 6c :3 7c 0
:3 7c :e 7f 80 :2 7f
:5 80 :2 7f :2 80 :3 7f
:2 7e 81 :4 7c :4 17
84 :6 1
596
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 a :2 0 :2 5
:3 0 6 :3 0 7
:2 0 3 6 8
:6 0 8 :4 0 c
9 a 16f 4
:6 0 d :2 0 9
5 :3 0 6 :3 0
7 f 11 :6 0
b :4 0 15 12
13 16f 9 :6 0
f 9b 0 d
5 :3 0 6 :3 0
b 18 1a :6 0
e :4 0 1e 1b
1c 16f c :6 0
f :a 0 df 2
:7 0 13 b8 0
:2 11 :3 0 10 :7 0
22 21 :3 0 24
:2 0 df 1f 25
:2 0 19 f0 0
17 11 :3 0 28
:7 0 2b 29 0
dd 0 12 :6 0
6 :3 0 14 :2 0
15 2d 2f :6 0
32 30 0 dd
0 13 :6 0 1f
:2 0 1d 11 :3 0
34 :7 0 37 35
0 dd 0 15
:6 0 6 :3 0 14
:2 0 1b 39 3b
:6 0 3e 3c 0
dd 0 16 :6 0
17 :3 0 13 :3 0
18 :3 0 21 43
5f 0 60 :3 0
19 :3 0 1a :2 0
1b :4 0 25 46
48 :3 0 1c :3 0
1a :2 0 1d :3 0
1d :2 0 1c :3 0
4d 0 4e 0
28 18 :3 0 2a
52 58 0 59
:3 0 19 :3 0 1a
:2 0 1b :4 0 2e
55 57 :5 0 50
53 0 5a :3 0
31 4b 5c :3 0
49 5e 5d :3 0
62 63 :5 0 40
44 0 34 0
61 :2 0 da 12
:3 0 1e :3 0 1f
:3 0 13 :3 0 20
:2 0 36 67 6a
21 :4 0 39 66
6d 65 6e 0
70 3c 7f 22
:3 0 23 :3 0 24
:3 0 73 74 0
c :3 0 25 :2 0
3e 75 78 :2 0
7a 41 7c 43
7b 7a :2 0 7d
45 :2 0 7f 0
7f 7e 70 7d
:6 0 da 2 :3 0
10 :3 0 26 :2 0
12 :3 0 47 82
84 :3 0 27 :2 0
28 :2 0 4c 86
88 :3 0 89 :2 0
23 :3 0 24 :3 0
8b 8c 0 c
:3 0 29 :2 0 4f
8d 90 :2 0 92
52 93 8a 92
0 94 54 0
da 15 :3 0 12
:3 0 2a :2 0 20
:2 0 56 97 99
:3 0 95 9a 0
da 2b :3 0 15
:3 0 2c :3 0 2d
:2 0 10 :3 0 59
9e a1 5d 9f
a3 :3 0 2e :3 0
a4 :2 0 a6 d9
16 :3 0 2f :4 0
30 :2 0 31 :3 0
15 :3 0 26 :2 0
32 :2 0 60 ad
af :3 0 21 :4 0
63 ab b2 66
aa b4 :3 0 a8
b5 0 d7 33
:3 0 34 :3 0 35
:4 0 30 :2 0 16
:3 0 69 ba bc
:3 0 30 :2 0 36
:4 0 6c be c0
:3 0 30 :2 0 31
:3 0 15 :3 0 37
:4 0 6f c3 c6
72 c2 c8 :3 0
30 :2 0 38 :4 0
75 ca cc :3 0
cd :4 0 ce :2 0
d7 15 :3 0 15
:3 0 2a :2 0 32
:2 0 78 d2 d4
:3 0 d0 d5 0
d7 7b d9 2e
:3 0 a7 d7 :4 0
da 7f de :3 0
de f :3 0 85
de dd da db
:6 0 df 1 0
1f 25 de 16f
:2 0 39 :a 0 112
5 :7 0 8c 378
0 8a 3b :3 0
3a :7 0 e4 e3
:3 0 ee ef 0
8e 6 :3 0 3c
:7 0 e8 e7 :3 0
ea :2 0 112 e1
eb :2 0 3d :3 0
3e :3 0 3c :3 0
3f :3 0 3a :3 0
1a :2 0 93 f3
f4 :3 0 ed f7
f5 0 f8 0
96 0 f6 :2 0
10d 40 :4 0 f9
:3 0 1a :2 0 41
:2 0 9a fb fd
:3 0 fe :2 0 3d
:3 0 3f :3 0 3e
:3 0 3a :3 0 3c
:3 0 9d :3 0 100
107 108 109 :4 0
a0 a3 :4 0 106
:2 0 10a a5 10b
ff 10a 0 10c
a7 0 10d a9
111 :3 0 111 39
:4 0 111 110 10d
10e :6 0 112 1
0 e1 eb 111
16f :2 0 42 :3 0
43 :a 0 13d 6
:7 0 44 :4 0 6
:3 0 117 118 0
13d 115 119 :2 0
44 :3 0 45 :4 0
30 :2 0 46 :3 0
ac 11d 11f :3 0
30 :2 0 47 :3 0
48 :2 0 af 122
124 b1 121 126
:3 0 30 :2 0 49
:4 0 b4 128 12a
:3 0 30 :2 0 47
:3 0 48 :2 0 b7
12d 12f b9 12c
131 :3 0 30 :2 0
4a :3 0 bc 133
135 :3 0 136 :2 0
138 bf 13c :3 0
13c 43 :4 0 13c
13b 138 139 :6 0
13d 1 0 115
119 13c 16f :2 0
42 :3 0 4b :a 0
168 7 :7 0 44
:4 0 6 :3 0 142
143 0 168 140
144 :2 0 44 :3 0
4c :4 0 30 :2 0
4 :3 0 c1 148
14a :3 0 30 :2 0
47 :3 0 48 :2 0
c4 14d 14f c6
14c 151 :3 0 30
:2 0 4d :4 0 c9
153 155 :3 0 30
:2 0 47 :3 0 48
:2 0 cc 158 15a
ce 157 15c :3 0
30 :2 0 9 :3 0
d1 15e 160 :3 0
161 :2 0 163 d4
167 :3 0 167 4b
:4 0 167 166 163
164 :6 0 168 1
0 140 144 167
16f :3 0 16d 0
16d :3 0 16d 16f
16b 16c :6 0 170
:2 0 3 :3 0 d6
0 3 16d 173
:3 0 172 170 174
:8 0
de
4
:3 0 1 7 1
4 1 10 1
d 1 19 1
16 1 20 1
23 1 27 1
2e 1 2c 1
33 1 3a 1
38 1 3f 1
42 1 47 2
45 47 1 4f
1 51 1 56
2 54 56 2
4a 5b 1 41
2 68 69 2
6b 6c 1 6f
2 76 77 1
79 1 72 1
7c 2 81 83
1 87 2 85
87 2 8e 8f
1 91 1 93
2 96 98 1
a0 1 a2 2
9d a2 2 ac
ae 2 b0 b1
2 a9 b3 2
b9 bb 2 bd
bf 2 c4 c5
2 c1 c7 2
c9 cb 2 d1
d3 3 b6 cf
d6 5 64 7f
94 9b d9 4
2a 31 36 3d
1 e2 1 e6
2 e5 e9 1
f2 2 f1 f2
1 f0 1 fc
2 fa fc 2
103 104 2 101
102 1 105 1
109 1 10b 2
f8 10c 2 11c
11e 1 123 2
120 125 2 127
129 1 12e 2
12b 130 2 132
134 1 137 2
147 149 1 14e
2 14b 150 2
152 154 1 159
2 156 15b 2
15d 15f 1 162
7 b 14 1d
df 112 13d 168

1
4
0
173
0
1
14
7
f
0 1 2 2 1 1 1 0
0 0 0 0 0 0 0 0
0 0 0 0
1f 1 2
e1 1 5
38 2 0
d 1 0
4 1 0
20 2 0
e2 5 0
140 1 7
16 1 0
33 2 0
e6 5 0
3 0 1
2c 2 0
115 1 6
27 2 0
0
/
 show err;
 
PROMPT *** Create  grants  BARS_AUDIT_ADM ***
grant EXECUTE                                                                on BARS_AUDIT_ADM  to ABS_ADMIN;
grant EXECUTE                                                                on BARS_AUDIT_ADM  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_AUDIT_ADM  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_audit_adm.sql =========*** End 
 PROMPT ===================================================================================== 
 