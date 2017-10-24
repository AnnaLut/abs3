
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_scheme_utils.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_SCHEME_UTILS 
is

    ----------------------------------------------------------
    -- GET_TABLE_PRIMARYKEY()
    --
    --
    --
    --
    --
     function get_table_primarykey(
         p_tabowner   in  varchar2,
         p_tabname    in  varchar2  ) return varchar2;

    ----------------------------------------------------------
    -- GET_TABLE_PKINDEX()
    --
    --   Return name of index for table primary key
    --
    --
    --
     function get_table_pkindex(
         p_tabowner   in  varchar2,
         p_tabname    in  varchar2  ) return varchar2;


    ----------------------------------------------------------
    -- DROP_TABLE_CONSTRAINTS()
    --
    --
    --
    --
    --
     procedure drop_table_constraints(
         p_tabowner   in  varchar2,
         p_tabname    in  varchar2,
         p_constype   in  varchar2  );


    ----------------------------------------------------------
    -- DROP_TABLE_INDEXES()
    --
    --     Drop all table indexes except index for primary key
    --
    --
    --
     procedure drop_table_indexes(
         p_tabowner   in  varchar2,
         p_tabname    in  varchar2  );


    ----------------------------------------------------------
    -- RENAME_TABLE_PRIMARYKEY()
    --
    --
    --
    --
    --
     procedure rename_table_primarykey(
         p_tabowner   in  varchar2,
         p_tabname    in  varchar2,
         p_consname   in  varchar2,
         p_tabcols    in  varchar2 );

    ----------------------------------------------------------
    -- RENAME_TABLE_PKINDEX()
    --
    --
    --
    --
    --
     procedure rename_table_pkindex(
         p_tabowner   in  varchar2,
         p_tabname    in  varchar2,
         p_idxname    in  varchar2,
         p_tabcols    in  varchar2,
         p_tbsname    in  varchar2  default null);

end bars_scheme_utils;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_SCHEME_UTILS wrapped
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
3f
2 :e:
1PACKAGE:
1BODY:
1BARS_SCHEME_UTILS:
1DROP_TABLE_CONSTRAINTS:
1P_TABOWNER:
1VARCHAR2:
1P_TABNAME:
1P_CONSTYPE:
1I:
1OWNER:
1CONSTRAINT_NAME:
1ALL_CONSTRAINTS:
1TABLE_NAME:
1CONSTRAINT_TYPE:
1LOOP:
1select owner, constraint_name:n                     from all_constraints:n   +
1                 where owner           = p_tabowner:n                      an+
1d table_name      = p_tabname:n                      and constraint_type = p_+
1constype:
1EXECUTE:
1IMMEDIATE:
1alter table :
1||:
1LOWER:
1.:
1 drop constraints :
1DROP_TABLE_INDEXES:
1INDEX_NAME:
1ALL_INDEXES:
1select owner, index_name:n                     from all_indexes:n            +
1        where owner      = p_tabowner:n                      and table_name =+
1 p_tabname:n                   minus:n                   select owner, index_+
1name :n                     from all_constraints:n                    where o+
1wner           = p_tabowner:n                      and table_name      = p_ta+
1bname:n                      and constraint_type = 'P'        :
1drop index :
1FUNCTION:
1GET_TABLE_PRIMARYKEY:
1RETURN:
1L_CONSNAME:
130:
1SELECT constraint_name:n           into l_consname:n           from all_const+
1raints:n          where owner           = p_tabowner:n            and table_n+
1ame      = p_tabname:n            and constraint_type = 'P':
1NO_DATA_FOUND:
1GET_TABLE_PKINDEX:
1L_INDEXNAME:
1SELECT index_name:n           into l_indexname:n           from all_constrain+
1ts:n          where owner           = p_tabowner:n            and table_name +
1     = p_tabname:n            and constraint_type = 'P':
1RENAME_TABLE_PRIMARYKEY:
1P_CONSNAME:
1P_TABCOLS:
1IS NULL:
1 add constraint :
1 primary key (:
1) using index:
1!=:
1 rename constraint :
1 to :
1RENAME_TABLE_PKINDEX:
1P_IDXNAME:
1P_TBSNAME:
1L_IDXNAME:
1create unique index :
1 on :
1(:
1) tablespace :
1alter index :
1 rename to :
1IS NOT NULL:
1RAISE_APPLICATION_ERROR:
1-:
120999:
1implementation restrictions - cannot get tablespace name:
0

0
0
219
2
0 :2 a0 97 9a 8f a0 b0 3d
8f a0 b0 3d 8f a0 b0 3d
b4 55 6a 91 :a a0 12a 37 :2 a0
6e 7e :2 a0 a5 b b4 2e 7e
6e b4 2e 7e :2 a0 a5 b b4
2e 7e 6e b4 2e 7e :2 a0 6b
b4 2e 11e 11d b7 a0 47 b7
a4 a0 b1 11 68 4f 9a 8f
a0 b0 3d 8f a0 b0 3d b4
55 6a 91 :10 a0 12a 37 :2 a0 6e
7e :3 a0 6b a5 b b4 2e 7e
6e b4 2e 7e :3 a0 6b a5 b
b4 2e 11e 11d b7 a0 47 b7
a4 a0 b1 11 68 4f a0 8d
8f a0 b0 3d 8f a0 b0 3d
b4 :2 a0 2c 6a a3 a0 51 a5
1c 81 b0 :8 a0 12a :2 a0 65 b7
:2 a0 4d 65 b7 a6 9 a4 a0
b1 11 68 4f a0 8d 8f a0
b0 3d 8f a0 b0 3d b4 :2 a0
2c 6a a3 a0 51 a5 1c 81
b0 :8 a0 12a :2 a0 65 b7 :2 a0 4d
65 b7 a6 9 a4 a0 b1 11
68 4f 9a 8f a0 b0 3d 8f
a0 b0 3d 8f a0 b0 3d 8f
a0 b0 3d b4 55 6a a3 a0
51 a5 1c 81 b0 :4 a0 a5 b
d a0 7e b4 2e 5a :2 a0 6e
7e a0 b4 2e 7e 6e b4 2e
7e a0 b4 2e 7e 6e b4 2e
7e a0 b4 2e 7e 6e b4 2e
7e a0 b4 2e 7e 6e b4 2e
11e 11d b7 :2 a0 7e b4 2e 5a
:2 a0 6e 7e a0 b4 2e 7e 6e
b4 2e 7e a0 b4 2e 7e 6e
b4 2e 7e a0 b4 2e 7e 6e
b4 2e 7e a0 b4 2e 11e 11d
b7 19 3c b7 :2 19 3c 4f b7
a4 a0 b1 11 68 4f 9a 8f
a0 b0 3d 8f a0 b0 3d 8f
a0 b0 3d 8f a0 b0 3d 8f
a0 4d b0 3d b4 55 6a a3
a0 51 a5 1c 81 b0 :4 a0 a5
b d a0 7e b4 2e 5a :2 a0
6e 7e a0 b4 2e 7e 6e b4
2e 7e a0 b4 2e 7e 6e b4
2e 7e a0 b4 2e 7e 6e b4
2e 7e a0 b4 2e 7e 6e b4
2e 7e a0 b4 2e 7e 6e b4
2e 7e a0 b4 2e 11e 11d b7
:2 a0 7e b4 2e 5a :2 a0 6e 7e
a0 b4 2e 7e 6e b4 2e 7e
a0 b4 2e 7e 6e b4 2e 7e
a0 b4 2e 11e 11d b7 19 3c
a0 7e b4 2e 5a a0 7e 51
b4 2e 6e a5 57 b7 19 3c
b7 :2 19 3c b7 a4 a0 b1 11
68 4f b1 b7 a4 11 a0 b1
56 4f 1d 17 b5
219
2
0 3 7 b 15 31 2d 2c
39 46 42 29 4e 57 53 41
5f 3e 64 68 6c 70 74 78
7c 80 84 88 8c 90 94 98
a4 a6 aa ae b3 b6 ba be
bf c1 c2 c7 ca cf d0 d5
d8 dc e0 e1 e3 e4 e9 ec
f1 f2 f7 fa fe 102 105 106
10b 110 114 116 11a 121 123 127
12b 12d 139 13d 13f 15b 157 156
163 170 16c 153 178 16b 17d 181
185 189 18d 191 195 199 19d 1a1
1a5 1a9 1ad 1b1 1b5 1b9 1bd 1c1
1c5 1c9 168 1d5 1d9 1dd 1e2 1e5
1e9 1ed 1f1 1f4 1f5 1f7 1f8 1fd
200 205 206 20b 20e 212 216 21a
21d 21e 220 221 226 22b 22f 231
235 23c 23e 242 246 248 254 258
25a 25e 27a 276 275 282 28f 28b
272 297 28a 29c 2a0 2a4 2a8 2c2
2b0 287 2b4 2b5 2bd 2af 2c9 2cd
2d1 2d5 2d9 2dd 2e1 2e5 2e9 2f5
2f9 2fd 2ac 301 305 309 30a 30e
310 311 316 31a 31e 320 32c 330
332 336 352 34e 34d 35a 367 363
34a 36f 362 374 378 37c 380 39a
388 35f 38c 38d 395 387 3a1 3a5
3a9 3ad 3b1 3b5 3b9 3bd 3c1 3cd
3d1 3d5 384 3d9 3dd 3e1 3e2 3e6
3e8 3e9 3ee 3f2 3f6 3f8 404 408
40a 426 422 421 42e 43b 437 41e
443 44c 448 436 454 461 45d 433
469 45c 46e 472 48c 47a 459 47e
47f 487 479 493 497 49b 49f 476
4a3 4a5 4a9 4ad 4b0 4b1 4b6 4b9
4bd 4c1 4c6 4c9 4cd 4ce 4d3 4d6
4db 4dc 4e1 4e4 4e8 4e9 4ee 4f1
4f6 4f7 4fc 4ff 503 504 509 50c
511 512 517 51a 51e 51f 524 527
52c 52d 532 537 53b 53d 541 545
548 549 54e 551 555 559 55e 561
565 566 56b 56e 573 574 579 57c
580 581 586 589 58e 58f 594 597
59b 59c 5a1 5a4 5a9 5aa 5af 5b2
5b6 5b7 5bc 5c1 5c5 5c7 5cb 5ce
5d0 5d4 5d8 5db 5dd 5df 5e3 5e7
5e9 5f5 5f9 5fb 617 613 612 61f
62c 628 60f 634 63d 639 627 645
652 64e 624 65a 664 65f 663 64d
66c 64a 671 675 692 67d 681 684
685 68d 67c 699 69d 6a1 6a5 679
6a9 6ab 6af 6b3 6b6 6b7 6bc 6bf
6c3 6c7 6cc 6cf 6d3 6d4 6d9 6dc
6e1 6e2 6e7 6ea 6ee 6ef 6f4 6f7
6fc 6fd 702 705 709 70a 70f 712
717 718 71d 720 724 725 72a 72d
732 733 738 73b 73f 740 745 748
74d 74e 753 756 75a 75b 760 765
769 76b 76f 773 776 777 77c 77f
783 787 78c 78f 793 794 799 79c
7a1 7a2 7a7 7aa 7ae 7af 7b4 7b7
7bc 7bd 7c2 7c5 7c9 7ca 7cf 7d4
7d8 7da 7de 7e1 7e5 7e8 7e9 7ee
7f1 7f5 7f8 7fb 7fc 801 806 807
80c 80e 812 815 817 81b 81f 822
824 828 82c 82e 83a 83e 840 842
844 848 854 858 85a 85d 85f 860
869
219
2
0 1 9 e 10 a 1b :3 a
1b :3 a 1b :2 a 26 :2 6 e 1b
22 :2 1b 2d 1b 2d 1b 2d a
13 a e 16 20 2f 32 38
:2 32 :2 20 44 47 :2 20 4b 20 26
:4 20 31 34 :2 20 49 4c :2 4e :2 20
:2 e a e a :2 6 a :4 6 10
a 1b :3 a 1b :2 a 22 :2 6 e
1b 22 :2 1b 28 1b 28 1b 22
:2 1b 2d 1b 2d 1b a 13 a
e 16 20 2e 31 37 :2 39 :2 31
:2 20 40 43 :2 20 47 4a 50 :2 52
:2 4a :2 20 :2 e a e a :2 6 a
:5 6 f a 1b :3 a 1b :2 a 23
27 2e :3 6 12 1b 1a :2 12 6
:4 11 23 11 23 11 :2 a 11 a
6 f 22 29 22 1d :2 a 6
a :5 6 f a 1b :3 a 1b :2 a
20 27 2e :3 6 13 1c 1b :2 13
6 :4 11 23 11 23 11 :2 a 11
a 6 f 22 29 22 1d :2 a
6 a :4 6 10 a 1b :3 a 1b
:3 a 1b :3 a 1b :2 a 27 :3 6 11
1a 19 :2 11 6 a 18 2d 39
:2 18 a :4 e d e 16 20 2f
32 :2 20 3d 40 :2 20 44 47 :3 20
23 :2 20 36 39 :2 20 44 47 :3 20
23 :2 20 2d 30 :2 20 :2 e 22 12
20 :3 1d 11 12 1a 24 33 36
:2 24 41 44 :2 24 48 4b :3 24 27
:2 24 3d 40 :2 24 4b 4e :2 24 55
58 :2 24 :2 12 2c :2 e :5 a :2 6 a
:4 6 10 a 1b :3 a 1b :3 a 1b
:3 a 1b :3 a 1b 2d :2 a 24 :3 6
10 19 18 :2 10 6 a 17 29
35 :2 17 a :4 e d e 16 20
37 3a :2 20 45 48 :2 20 4c 4f
:3 20 23 :2 20 2a 2d :2 20 38 3b
:2 20 3f 42 :2 20 4c 4f :3 20 23
:2 20 2d 30 :2 20 40 43 :2 20 :2 e
21 12 1f :3 1c 11 12 1a 24
33 36 :2 24 41 44 :2 24 48 4b
:3 24 27 :2 24 35 38 :2 24 :2 12 2a
:2 e :4 12 11 12 2a 2b :2 2a 32
:2 12 29 :2 e :4 a :2 6 a :8 6 5
:6 1
219
4
0 :3 1 b :4 c
:4 d :4 e :3 b :3 12
13 :2 14 :2 15 :2 16
17 :2 12 :f 19 :4 1a
:2 19 :2 1a :2 19 :4 1a
:4 19 17 1c 12
:2 10 1e :4 b 27
:4 28 :4 29 :3 27 :3 2d
2e :2 2f :2 30 :2 32
33 :2 34 :2 35 36
37 :2 2d :1b 38 37
39 2d :2 2b 3b
:4 27 :2 44 :4 45 :4 46
44 :2 46 :2 44 :7 49
4d 4e 4f :2 50
:2 51 52 4d :3 54
4b :7 57 56 58
:4 44 :2 62 :4 63 :4 64
62 :2 64 :2 62 :7 67
6b 6c 6d :2 6e
:2 6f 70 6b :3 72
69 :7 75 74 76
:4 62 80 :4 81 :4 82
:4 83 :4 84 :3 80 :7 87
:7 8b :5 8e :f 90 :2 91
:2 90 :2 91 :2 90 :2 91
:2 90 :2 92 :2 90 :2 92
:4 90 8e :6 96 :f 98
:2 99 :2 98 :2 99 :2 98
:2 99 :2 98 :2 99 :4 98
:3 96 93 :3 8e 9f
:2 89 a1 :4 80 ab
:4 ac :4 ad :4 ae :4 af
:5 b0 :3 ab :7 b3 :7 b7
:5 ba :f bc :2 bd :2 bc
:2 bd :2 bc :2 bd :2 bc
:2 bd :2 bc :2 bd :2 bc
:2 be :2 bc :2 be :2 bc
:2 be :4 bc ba :6 c2
:f c4 :2 c5 :2 c4 :2 c5
:4 c4 :3 c2 :5 c9 :8 ca
:3 c9 bf :3 ba :2 b5
cf :4 ab :4 b d1
:6 1
86b
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 4 :a 0 4a
2 :7 0 5 3e
0 3 6 :3 0
5 :7 0 7 6
:3 0 9 :2 0 7
6 :3 0 7 :7 0
b a :3 0 6
:3 0 8 :7 0 f
e :3 0 11 :2 0
4a 4 12 :2 0
9 :3 0 a :3 0
b :3 0 c :3 0
a :3 0 5 :3 0
d :3 0 7 :3 0
e :3 0 8 :3 0
f :4 0 10 1
:8 0 20 14 1f
11 :3 0 12 :3 0
13 :4 0 14 :2 0
15 :3 0 5 :3 0
d 25 27 f
24 29 :3 0 14
:2 0 16 :4 0 12
2b 2d :3 0 14
:2 0 15 :3 0 7
:3 0 15 30 32
17 2f 34 :3 0
14 :2 0 17 :4 0
1a 36 38 :3 0
14 :2 0 9 :3 0
b :3 0 3b 3c
0 1d 3a 3e
:3 0 3f :4 0 40
:2 0 42 20 44
f :3 0 20 42
:4 0 45 22 49
:3 0 49 4 :4 0
49 48 45 46
:6 0 4a 1 0
4 12 49 213
:2 0 18 :a 0 8e
4 :7 0 26 168
0 24 6 :3 0
5 :7 0 4f 4e
:3 0 58 69 0
28 6 :3 0 7
:7 0 53 52 :3 0
55 :2 0 8e 4c
56 :2 0 9 :3 0
a :3 0 19 :3 0
1a :3 0 a :3 0
5 :3 0 d :3 0
7 :3 0 a :3 0
19 :3 0 c :3 0
a :3 0 5 :3 0
d :3 0 7 :3 0
e :3 0 f :4 0
1b 1 :8 0 6a
11 :3 0 12 :3 0
1c :4 0 14 :2 0
15 :3 0 9 :3 0
a :3 0 70 71
0 2b 6f 73
2d 6e 75 :3 0
14 :2 0 16 :4 0
30 77 79 :3 0
14 :2 0 15 :3 0
9 :3 0 19 :3 0
7d 7e 0 33
7c 80 35 7b
82 :3 0 83 :4 0
84 :2 0 86 38
88 f :3 0 6a
86 :4 0 89 3a
8d :3 0 8d 18
:4 0 8d 8c 89
8a :6 0 8e 1
0 4c 56 8d
213 :2 0 1d :3 0
1e :a 0 be 6
:7 0 3e 287 0
3c 6 :3 0 5
:7 0 94 93 :3 0
21 :2 0 40 6
:3 0 7 :7 0 98
97 :3 0 1f :3 0
6 :3 0 9a 9c
0 be 91 9d
:2 0 47 bd 0
45 6 :3 0 43
a0 a2 :6 0 a5
a3 0 bc 0
20 :6 0 b :3 0
20 :3 0 c :3 0
a :3 0 5 :3 0
d :3 0 7 :3 0
e :4 0 22 1
:8 0 b2 1f :3 0
20 :3 0 b0 :2 0
b2 23 :3 0 1f
:4 0 b5 :2 0 b7
4a b9 4c b8
b7 :2 0 ba 4e
:2 0 bd 1e :3 0
50 bd bc b2
ba :6 0 be 1
0 91 9d bd
213 :2 0 1d :3 0
24 :a 0 ee 7
:7 0 54 35f 0
52 6 :3 0 5
:7 0 c4 c3 :3 0
21 :2 0 56 6
:3 0 7 :7 0 c8
c7 :3 0 1f :3 0
6 :3 0 ca cc
0 ee c1 cd
:2 0 5d ed 0
5b 6 :3 0 59
d0 d2 :6 0 d5
d3 0 ec 0
25 :6 0 19 :3 0
25 :3 0 c :3 0
a :3 0 5 :3 0
d :3 0 7 :3 0
e :4 0 26 1
:8 0 e2 1f :3 0
25 :3 0 e0 :2 0
e2 23 :3 0 1f
:4 0 e5 :2 0 e7
60 e9 62 e8
e7 :2 0 ea 64
:2 0 ed 24 :3 0
66 ed ec e2
ea :6 0 ee 1
0 c1 cd ed
213 :2 0 27 :a 0
171 8 :7 0 6a
433 0 68 6
:3 0 5 :7 0 f3
f2 :3 0 6e 459
0 6c 6 :3 0
7 :7 0 f7 f6
:3 0 6 :3 0 28
:7 0 fb fa :3 0
21 :2 0 70 6
:3 0 29 :7 0 ff
fe :3 0 101 :2 0
171 f0 102 :2 0
79 :2 0 77 6
:3 0 75 105 107
:6 0 10a 108 0
16f 0 20 :6 0
20 :3 0 1e :3 0
5 :3 0 7 :3 0
10c 10f 10b 110
0 16c 20 :3 0
2a :2 0 7c 113
114 :3 0 115 :2 0
11 :3 0 12 :3 0
13 :4 0 14 :2 0
5 :3 0 7e 11a
11c :3 0 14 :2 0
16 :4 0 81 11e
120 :3 0 14 :2 0
7 :3 0 84 122
124 :3 0 14 :2 0
2b :4 0 87 126
128 :3 0 14 :2 0
28 :3 0 8a 12a
12c :3 0 14 :2 0
2c :4 0 8d 12e
130 :3 0 14 :2 0
29 :3 0 90 132
134 :3 0 14 :2 0
2d :4 0 93 136
138 :3 0 139 :4 0
13a :2 0 13c 96
168 20 :3 0 28
:3 0 2e :2 0 9a
13f 140 :3 0 141
:2 0 11 :3 0 12
:3 0 13 :4 0 14
:2 0 5 :3 0 9d
146 148 :3 0 14
:2 0 16 :4 0 a0
14a 14c :3 0 14
:2 0 7 :3 0 a3
14e 150 :3 0 14
:2 0 2f :4 0 a6
152 154 :3 0 14
:2 0 20 :3 0 a9
156 158 :3 0 14
:2 0 30 :4 0 ac
15a 15c :3 0 14
:2 0 28 :3 0 af
15e 160 :3 0 161
:4 0 162 :2 0 164
b2 165 142 164
0 166 b4 0
167 b6 169 116
13c 0 16a 0
167 0 16a b8
0 16c 0 16c
bb 170 :3 0 170
27 :3 0 bf 170
16f 16c 16d :6 0
171 1 0 f0
102 170 213 :2 0
31 :a 0 20c 9
:7 0 c3 624 0
c1 6 :3 0 5
:7 0 176 175 :3 0
c7 64a 0 c5
6 :3 0 7 :7 0
17a 179 :3 0 6
:3 0 32 :7 0 17e
17d :3 0 cb :2 0
c9 6 :3 0 29
:7 0 182 181 :3 0
6 :4 0 33 :7 0
187 185 186 :2 0
189 :2 0 20c 173
18a :2 0 d5 :2 0
d3 6 :3 0 21
:2 0 d1 18d 18f
:6 0 192 190 0
20a 0 34 :6 0
34 :3 0 24 :3 0
5 :3 0 7 :3 0
194 197 193 198
0 207 34 :3 0
2a :2 0 d8 19b
19c :3 0 19d :2 0
11 :3 0 12 :3 0
35 :4 0 14 :2 0
5 :3 0 da 1a2
1a4 :3 0 14 :2 0
16 :4 0 dd 1a6
1a8 :3 0 14 :2 0
32 :3 0 e0 1aa
1ac :3 0 14 :2 0
36 :4 0 e3 1ae
1b0 :3 0 14 :2 0
5 :3 0 e6 1b2
1b4 :3 0 14 :2 0
16 :4 0 e9 1b6
1b8 :3 0 14 :2 0
7 :3 0 ec 1ba
1bc :3 0 14 :2 0
37 :4 0 ef 1be
1c0 :3 0 14 :2 0
29 :3 0 f2 1c2
1c4 :3 0 14 :2 0
38 :4 0 f5 1c6
1c8 :3 0 14 :2 0
33 :3 0 f8 1ca
1cc :3 0 1cd :4 0
1ce :2 0 1d0 fb
204 34 :3 0 32
:3 0 2e :2 0 ff
1d3 1d4 :3 0 1d5
:2 0 11 :3 0 12
:3 0 39 :4 0 14
:2 0 5 :3 0 102
1da 1dc :3 0 14
:2 0 16 :4 0 105
1de 1e0 :3 0 14
:2 0 34 :3 0 108
1e2 1e4 :3 0 14
:2 0 3a :4 0 10b
1e6 1e8 :3 0 14
:2 0 32 :3 0 10e
1ea 1ec :3 0 1ed
:4 0 1ee :2 0 1f0
111 1f1 1d6 1f0
0 1f2 113 0
203 33 :3 0 3b
:2 0 115 1f4 1f5
:3 0 1f6 :2 0 3c
:3 0 3d :2 0 3e
:2 0 117 1f9 1fb
:3 0 3f :4 0 119
1f8 1fe :2 0 200
11c 201 1f7 200
0 202 11e 0
203 120 205 19e
1d0 0 206 0
203 0 206 123
0 207 126 20b
:3 0 20b 31 :3 0
129 20b 20a 207
208 :6 0 20c 1
0 173 18a 20b
213 :3 0 211 0
211 :3 0 211 213
20f 210 :6 0 214
:2 0 3 :3 0 12b
0 3 211 217
:3 0 216 214 218
:8 0
132
4
:3 0 1 5 1
9 1 d 3
8 c 10 1
26 2 23 28
2 2a 2c 1
31 2 2e 33
2 35 37 2
39 3d 1 41
1 44 1 4d
1 51 2 50
54 1 72 2
6d 74 2 76
78 1 7f 2
7a 81 1 85
1 88 1 92
1 96 2 95
99 1 a1 1
9f 2 ae b1
1 b6 1 b3
1 b9 1 a4
1 c2 1 c6
2 c5 c9 1
d1 1 cf 2
de e1 1 e6
1 e3 1 e9
1 d4 1 f1
1 f5 1 f9
1 fd 4 f4
f8 fc 100 1
106 1 104 2
10d 10e 1 112
2 119 11b 2
11d 11f 2 121
123 2 125 127
2 129 12b 2
12d 12f 2 131
133 2 135 137
1 13b 1 13e
2 13d 13e 2
145 147 2 149
14b 2 14d 14f
2 151 153 2
155 157 2 159
15b 2 15d 15f
1 163 1 165
1 166 2 168
169 3 111 16a
16b 1 109 1
174 1 178 1
17c 1 180 1
184 5 177 17b
17f 183 188 1
18e 1 18c 2
195 196 1 19a
2 1a1 1a3 2
1a5 1a7 2 1a9
1ab 2 1ad 1af
2 1b1 1b3 2
1b5 1b7 2 1b9
1bb 2 1bd 1bf
2 1c1 1c3 2
1c5 1c7 2 1c9
1cb 1 1cf 1
1d2 2 1d1 1d2
2 1d9 1db 2
1dd 1df 2 1e1
1e3 2 1e5 1e7
2 1e9 1eb 1
1ef 1 1f1 1
1f3 1 1fa 2
1fc 1fd 1 1ff
1 201 2 1f2
202 2 204 205
2 199 206 1
191 6 4a 8e
be ee 171 20c

1
4
0
217
0
1
14
9
1f
0 1 2 1 4 1 1 1
1 0 0 0 0 0 0 0
0 0 0 0
17c 9 0
cf 7 0
f0 1 8
3 0 1
180 9 0
fd 8 0
91 1 6
f9 8 0
c1 1 7
178 9 0
f5 8 0
c6 7 0
96 6 0
51 4 0
9 2 0
184 9 0
4c 1 4
58 5 0
14 3 0
18c 9 0
4 1 2
d 2 0
173 1 9
104 8 0
9f 6 0
174 9 0
f1 8 0
c2 7 0
92 6 0
4d 4 0
5 2 0
0
/
 show err;
 
PROMPT *** Create  grants  BARS_SCHEME_UTILS ***
grant EXECUTE                                                                on BARS_SCHEME_UTILS to ABS_ADMIN;
grant EXECUTE                                                                on BARS_SCHEME_UTILS to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_SCHEME_UTILS to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_scheme_utils.sql =========*** E
 PROMPT ===================================================================================== 
 