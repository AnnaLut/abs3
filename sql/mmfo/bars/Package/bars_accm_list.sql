
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_accm_list.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ACCM_LIST 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет заполнения таблиц списков                 --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    --                                                             --
    -- Константы                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- Идентификация версии
    --

    VERSION_HEADER       constant varchar2(64)  := 'version 0.1 15.07.2009';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';




    -----------------------------------------------------------------
    -- ADD_CORRDOCS()
    --
    --     Добавление/обновление списка корректирующих проводок
    --
    --
    --
    procedure add_corrdocs;





    -----------------------------------------------------------------
    --                                                             --
    --  Методы идентификации версии                                --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция получения версии заголовка пакета
    --
    --
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция получения версии тела пакета
    --
    --
    --
    function body_version return varchar2;



end bars_accm_list;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ACCM_LIST wrapped
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
77
2 :e:
1PACKAGE:
1BODY:
1BARS_ACCM_LIST:
1VERSION_BODY:
1CONSTANT:
1VARCHAR2:
164:
1version 0.2 06.01.2010:
1VERSION_BODY_DEFS:
1512:
1:
1MODCODE:
13:
1ACM:
1PKG_CODE:
1100:
1accmlst:
1ADD_CORRDOCS:
1P:
1||:
1.addcrdocs:
1TYPE:
1T_LISTNUM:
1NUMBER:
1BINARY_INTEGER:
1L_LISTREF:
1L_DUMMY:
1L_ROWCNT:
10:
1ROW_PROCESSED:
1BARS_AUDIT:
1TRACE:
1%s:: entry point:
1REF:
1BULK:
1COLLECT:
1ACCM_QUEUE_CORRDOCS:
1SELECT ref bulk collect into l_listref:n          from accm_queue_corrdocs:
1%s:: corr docs count in queue is %s:
1TO_CHAR:
1COUNT:
1I:
11:
1LOOP:
1%s:: processing document ref %s...:
1SELECT 1 into l_dummy:n                      from accm_queue_corrdocs:n      +
1               where ref = l_listref(i):n                    for update:
1NO_DATA_FOUND:
1RAISE:
1%s:: document ref %s locked in queue:
1ACCM_LIST_CORRDOCS:
1DELETE from accm_list_corrdocs:n                 where ref = l_listref(i):
1+:
1ROWCOUNT:
1%s:: document ref %s delete from list, row(s) count %s:
1CALDT_ID:
1CORDT_ID:
1COR_TYPE:
1ACC:
1DOS:
1DOSQ:
1KOS:
1KOSQ:
1S:
1TT:
1VOB:
1C2:
1BANKDT_DATE:
1BANKDT_ID:
1C1:
1DECODE:
1O:
1ADD_MONTHS:
1TRUNC:
1P2:
1FDAT:
1COR_DATE:
1P1:
1OPER:
1SUM:
1NVL:
1DK:
1SQ:
1OPLDOK:
1MAX:
1ACCM_CALENDAR:
1CALDT_DATE:
1INSERT into accm_list_corrdocs(caldt_id, cordt_id, cor_type, acc, dos, dosq, +
1kos, kosq, ref):n                select (case:n                         when +
1(s.tt like 'ZG%' and vob not in (96, 99) and to_char(c2.bankdt_date, 'ddmm') +
1= '0101')  then:n                              c2.bankdt_id - 1:n            +
1             else c2.bankdt_id:n                        end)                 +
1        caldt_id, :n                       (case:n                         wh+
1en (s.tt like 'ZG%' and vob not in (96, 99))  then:n                         +
1     c2.bankdt_id:n                         else c1.caldt_id:n               +
1         end)                         cordt_id,:n                       (case+
1:n                         when (s.tt like 'ZG%') then:n                     +
1         decode(s.vob, 96, 4, 99, 4, 3):n                         else decode+
1(s.vob, 96, 1, 99, 2):n                        end)                         c+
1or_type,:n                       s.acc                         acc,:n        +
1               s.dos                         dos,:n                       s.d+
1osq                        dosq,:n                       s.kos               +
1          kos, :n                       s.kosq                        kosq,:n+
1                       s.ref:n                  from (select o.ref, o.vob, o.+
1tt,:n                               add_months(add_months(trunc(p2.fdat, 'mon+
1th'), -1), 1)-1 cor_date, :n                               p1.fdat, p1.acc, p+
11.dos, p1.dosq, p1.kos, p1.kosq:n                          from oper o,:n    +
1                           (select p.fdat, p.acc, :n                         +
1              sum(nvl(decode(p.dk, 0, p.s),  0)) dos,:n                      +
1                 sum(nvl(decode(p.dk, 0, p.sq), 0)) dosq,:n                  +
1                     sum(nvl(decode(p.dk, 1, p.s),  0)) kos,:n               +
1                        sum(nvl(decode(p.dk, 1, p.sq), 0)) kosq:n            +
1                      from opldok p:n                                 where p+
1.ref = l_listref(i):n                                group by p.fdat, p.acc) +
1   p1,:n                               (select max(fdat) fdat:n              +
1                    from opldok:n                                 where ref =+
1 l_listref(i)) p2:n                         where o.ref = l_listref(i):n     +
1                      and (o.vob in (96, 99) or o.tt like 'ZG%')  ) s,:n     +
1                  accm_calendar c1, accm_calendar c2:n                 where +
1s.cor_date = c1.caldt_date:n                   and s.fdat = c2.caldt_date:
1%s:: document ref %s inserted in list, row(s) count %s:
1C:
1VALUE:
1CALDT_DATE1:
1CALDT_DATE2:
1D:
1UNPIVOT:
1COLNAME:
1select distinct value :n                            from (select c1.caldt_dat+
1e caldt_date1, c2.caldt_date caldt_date2 :n                                  +
1  from accm_list_corrdocs d, accm_calendar c1, accm_calendar c2:n            +
1                       where d.ref = l_listref(i):n                          +
1           and d.caldt_id = c1.caldt_id:n                                    +
1 and d.cordt_id = c2.caldt_id):n                                  unpivot (va+
1lue for colname in (caldt_date1, caldt_date2)):
1BARS_ACCM_SYNC:
1ENQUEUE_MONBAL:
1ENQUEUE_YEARBAL:
1%s:: cr dates inserted into monbal queue:
1DELETE from accm_queue_corrdocs:n                 where ref = l_listref(i):
1%s:: document ref %s deleted from queue.:
1%s:: document ref %s already processed, nothing to do:
1COMMIT:
1%s:: document ref %s processed.:
1%s:: corr docs queue processed.:
1%s:: succ end:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1package header BARS_ACCM_LIST :
1VERSION_HEADER:
1CHR:
110:
1package header definition(s):::
1VERSION_HEADER_DEFS:
1BODY_VERSION:
1package body BARS_ACCM_LIST :
1package body definition(s):::
0

0
0
270
2
0 :2 a0 97 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 9a b4 55 6a 87
:2 a0 51 a5 1c a0 7e 6e b4
2e 1b b0 a0 9d a0 1c a0
40 a8 c 77 a3 a0 1c 81
b0 a3 a0 1c 81 b0 a3 a0
1c 51 81 b0 8b b0 2a :2 a0
6b 6e a0 a5 57 :5 a0 12a :2 a0
6b 6e :4 a0 6b a5 b a5 57
91 51 :2 a0 6b a0 63 37 :2 a0
6b 6e :4 a0 a5 b a5 b a5
57 :5 a0 12a b7 :3 a0 62 b7 a6
9 a4 b1 11 4f :2 a0 6b 6e
:4 a0 a5 b a5 b a5 57 :4 a0
12a :2 a0 7e a0 f b4 2e d
:2 a0 6b 6e :4 a0 a5 b a5 b
:2 a0 f a5 b a5 57 :9d a0 12a
:2 a0 7e a0 f b4 2e d :2 a0
6b 6e :4 a0 a5 b a5 b :2 a0
f a5 b a5 57 91 :1f a0 12a
37 :2 a0 6b :2 a0 6b a5 57 :2 a0
6b :2 a0 6b a5 57 b7 a0 47
:2 a0 6b 6e a0 a5 57 :4 a0 12a
:2 a0 6b 6e :4 a0 a5 b a5 b
a5 57 b7 :3 a0 6b 6e :4 a0 a5
b a5 b a5 57 b7 a6 9
a4 b1 11 4f a0 57 a0 b4
e9 :2 a0 6b 6e :4 a0 a5 b a5
b a5 57 b7 a0 47 :2 a0 6b
6e a0 a5 57 :2 a0 6b 6e a0
a5 57 b7 a4 a0 b1 11 68
4f a0 8d a0 b4 a0 2c 6a
a0 6e 7e a0 b4 2e 7e a0
51 a5 b b4 2e 7e 6e b4
2e 7e a0 51 a5 b b4 2e
7e a0 b4 2e 65 b7 a4 a0
b1 11 68 4f a0 8d a0 b4
a0 2c 6a a0 6e 7e a0 b4
2e 7e a0 51 a5 b b4 2e
7e 6e b4 2e 7e a0 51 a5
b b4 2e 7e a0 b4 2e 65
b7 a4 a0 b1 11 68 4f b1
b7 a4 11 a0 b1 56 4f 1d
17 b5
270
2
0 3 7 b 36 19 1d 21
24 25 2d 32 18 5b 41 45
15 49 4a 52 57 40 80 66
6a 3d 6e 6f 77 7c 65 a5
8b 8f 62 93 94 9c a1 8a
ac 87 c0 c4 f6 cc d0 d4
d7 d8 e0 e4 e7 ec ed f2
cb fd 11b 105 109 111 c8 115
116 101 137 126 12a 132 125 153
142 146 14e 122 16e 15a 15e 166
169 141 175 13e 17c 17f 183 187
18a 18f 193 194 199 19d 1a1 1a5
1a9 1ad 1b9 1bd 1c1 1c4 1c9 1cd
1d1 1d5 1d9 1dc 1dd 1df 1e0 1e5
1e9 1ec 1f0 1f4 1f7 1fb 1ff 201
205 209 20c 211 215 219 21d 221
222 224 225 227 228 22d 231 235
239 23d 241 24d 24f 253 257 25b
25e 260 261 266 26a 26c 278 27a
27e 282 285 28a 28e 292 296 29a
29b 29d 29e 2a0 2a1 2a6 2aa 2ae
2b2 2b6 2c2 2c6 2ca 2cd 2d1 2d6
2d7 2dc 2e0 2e4 2e8 2eb 2f0 2f4
2f8 2fc 300 301 303 304 306 30a
30e 313 314 316 317 31c 320 324
328 32c 330 334 338 33c 340 344
348 34c 350 354 358 35c 360 364
368 36c 370 374 378 37c 380 384
388 38c 390 394 398 39c 3a0 3a4
3a8 3ac 3b0 3b4 3b8 3bc 3c0 3c4
3c8 3cc 3d0 3d4 3d8 3dc 3e0 3e4
3e8 3ec 3f0 3f4 3f8 3fc 400 404
408 40c 410 414 418 41c 420 424
428 42c 430 434 438 43c 440 444
448 44c 450 454 458 45c 460 464
468 46c 470 474 478 47c 480 484
488 48c 490 494 498 49c 4a0 4a4
4a8 4ac 4b0 4b4 4b8 4bc 4c0 4c4
4c8 4cc 4d0 4d4 4d8 4dc 4e0 4e4
4e8 4ec 4f0 4f4 4f8 4fc 500 504
508 50c 510 514 518 51c 520 524
528 52c 530 534 538 53c 540 544
548 54c 550 554 558 55c 560 564
568 56c 570 574 578 57c 580 584
588 58c 590 59c 5a0 5a4 5a7 5ab
5b0 5b1 5b6 5ba 5be 5c2 5c5 5ca
5ce 5d2 5d6 5da 5db 5dd 5de 5e0
5e4 5e8 5ed 5ee 5f0 5f1 5f6 5fa
5fe 602 606 60a 60e 612 616 61a
61e 622 626 62a 62e 632 636 63a
63e 642 646 64a 64e 652 656 65a
65e 662 666 66a 66e 672 676 682
684 688 68c 68f 693 697 69a 69b
6a0 6a4 6a8 6ab 6af 6b3 6b6 6b7
6bc 6be 6c2 6c9 6cd 6d1 6d4 6d9
6dd 6de 6e3 6e7 6eb 6ef 6f3 6ff
703 707 70a 70f 713 717 71b 71f
720 722 723 725 726 72b 72d 731
735 739 73c 741 745 749 74d 751
752 754 755 757 758 75d 75f 760
765 769 76b 777 779 77d 782 786
787 78c 790 794 797 79c 7a0 7a4
7a8 7ac 7ad 7af 7b0 7b2 7b3 7b8
7ba 7be 7c5 7c9 7cd 7d0 7d5 7d9
7da 7df 7e3 7e7 7ea 7ef 7f3 7f4
7f9 7fb 7ff 803 805 811 815 817
81b 82f 833 834 838 83c 840 844
849 84c 850 851 856 859 85d 860
861 863 864 869 86c 871 872 877
87a 87e 881 882 884 885 88a 88d
891 892 897 89b 89d 8a1 8a5 8a7
8b3 8b7 8b9 8bd 8d1 8d5 8d6 8da
8de 8e2 8e6 8eb 8ee 8f2 8f3 8f8
8fb 8ff 902 903 905 906 90b 90e
913 914 919 91c 920 923 924 926
927 92c 92f 933 934 939 93d 93f
943 947 949 955 959 95b 95d 95f
963 96f 973 975 978 97a 97b 984
270
2
0 1 9 e 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 5 f 0 :3 5
16 1f 28 27 1f 30 39 3c
:2 30 16 :2 5 a :2 21 :4 18 :2 5 :3 10
:2 5 :3 10 :2 5 :2 10 1a 10 :4 5 9
:2 14 1a 2d :2 9 10 14 19 26
10 :2 9 :2 14 1a 3f 42 4a :2 54
:2 42 :2 9 d 12 15 :2 1f 9 12
9 d :2 18 1e 43 46 4e 58
:2 4e :2 46 :2 d 23 :2 1c 22 2c 15
11 1a 2d 33 2d 28 :2 15 11
:3 d 11 :2 1c 22 49 4c 54 5e
:2 54 :2 4c :2 11 1d 18 1e 28 :2 11
1d 26 2c 28 :2 1d :2 11 :2 1c 22
5b 5e 66 70 :2 66 :2 5e 75 81
7d :2 75 :2 11 1d 30 3a 44 4e
53 58 5e 63 69 20 22 34
4c 54 57 1f 22 1f 22 36
20 22 34 1f 22 1f 22 36
20 22 1f 26 28 1f 26 28
36 18 1a 36 18 1a 36 18
1a 36 18 1a 36 18 1a 36
18 1a 20 22 27 29 2e 30
20 2b 36 3c 3f 59 20 23
29 2c 31 34 39 3c 42 45
4a 4d 20 25 28 2a 30 32
28 2c 30 37 39 40 42 4b
28 2c 30 37 39 40 42 4b
28 2c 30 37 39 40 42 4b
28 2c 30 37 39 40 42 4b
28 2f 28 2a 30 3a 2a 2c
32 34 3c 28 2c 32 :2 28 2e
38 3c 20 22 28 32 21 23
36 38 4a 18 26 2a 38 18
1a 25 28 18 1a 21 24 :2 11
1d 26 2c 28 :2 1d :2 11 :2 1c 22
5b 5e 66 70 :2 66 :2 5e 75 81
7d :2 75 :2 11 15 2b 2a 2d 38
45 48 53 2a 3d 40 4e 52
60 2a 2c 32 3c 2a 2c 37
3a 2a 2c 37 3a 23 2c 36
42 4f 11 1a 11 15 :2 24 33
:2 35 :3 15 :2 24 34 :2 36 :2 15 11 15
:2 11 :2 1c 22 4d :2 11 1d 18 1e
28 :2 11 :2 1c 22 4d 50 58 62
:2 58 :2 50 :2 11 d 16 15 :2 20 26
5e 61 69 73 :2 69 :2 61 :2 15 24
:2 11 d :3 9 :6 d :2 18 1e 40 43
4b 55 :2 4b :2 43 :2 d 9 d :2 9
:2 14 1a 3c :3 9 :2 14 1a 2a :2 9
:2 5 9 :5 5 e 1d 0 24 :2 5
9 10 31 34 :2 10 43 46 4a
:2 46 :2 10 4e :3 10 30 33 37 :2 33
:2 10 3b 3e :2 10 9 :2 5 9 :5 5
e 1b 0 22 :2 5 9 10 2f
32 :2 10 3f 42 46 :2 42 :2 10 4a
:3 10 2e 31 35 :2 31 :2 10 39 3c
:2 10 9 :2 5 9 :9 5 :6 1
270
4
0 :3 1 :9 16 :9 17
:9 1a :9 1d 27 0
:2 27 :d 29 :9 2b :5 2d
:5 2e :6 2f :3 31 :7 34
:4 37 38 37 :d 39
:5 3c 3d :2 3c :e 3e
43 44 :3 45 43
42 :7 48 47 :3 40
:e 4a 4d :3 4e 4d
:8 4f :13 50 :a 53 :6 55
:2 56 :2 57 58 :3 5a
:2 5b :2 5c 5d :2 5f
:3 60 :3 61 62 :3 63
:3 64 :3 65 :3 66 :3 67
:2 68 :6 69 :6 6a :c 6b
:2 6c :4 6d :8 6e :8 6f
:8 70 :8 71 :2 72 :4 73
:5 74 :3 75 76 :4 77
:4 78 :5 79 :4 7a :4 7b
:4 7c 53 :8 7d :13 7e
:2 81 :6 82 :6 83 :4 84
:4 85 :4 86 :5 87 88
:2 81 :8 89 :8 8a 88
8b 81 :7 8c 8f
:3 90 8f :e 91 40
94 :e 95 :3 94 93
:3 3d :5 97 :e 98 3d
9a 3c :7 9b :7 9c
:2 33 9e :4 27 :3 b1
0 :3 b1 :e b4 b5
:2 b4 :5 b5 :2 b4 :2 b5
:3 b4 :2 b3 b6 :4 b1
:3 c0 0 :3 c0 :e c3
c4 :2 c3 :5 c4 :2 c3
:2 c4 :3 c3 :2 c2 c5
:4 c0 :4 27 c8 :6 1

986
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 a :2 0 :2 5
:3 0 6 :3 0 7
:2 0 3 6 8
:6 0 8 :4 0 c
9 a 26a 4
:6 0 d :2 0 9
5 :3 0 6 :3 0
7 f 11 :6 0
b :4 0 15 12
13 26a 9 :6 0
10 :2 0 d 5
:3 0 6 :3 0 b
18 1a :6 0 e
:4 0 1e 1b 1c
26a c :9 0 11
5 :3 0 6 :3 0
f 21 23 :6 0
11 :4 0 27 24
25 26a f :6 0
12 :a 0 20d 2
:7 0 29 :2 0 20d
28 2a :2 0 3d
:2 0 18 5 :3 0
6 :3 0 10 :2 0
13 2e 30 :6 0
f :3 0 14 :2 0
15 :4 0 15 33
35 :3 0 38 31
36 20b 13 :6 0
16 :3 0 3a 0
40 20b 18 :3 0
3b :7 0 19 :3 0
1a 3f 3c :2 0
1 17 40 3a
:4 0 1e 13e 0
1c 17 :3 0 43
:7 0 46 44 0
20b 0 1a :6 0
22 :2 0 20 18
:3 0 48 :7 0 4b
49 0 20b 0
1b :6 0 18 :3 0
4d :7 0 1d :2 0
51 4e 4f 20b
0 1c :6 0 1e
:6 0 53 0 20b
1f :3 0 20 :3 0
55 56 0 21
:4 0 13 :3 0 24
57 5a :2 0 208
22 :3 0 23 :3 0
24 :3 0 1a :3 0
25 :4 0 26 1
:8 0 208 1f :3 0
20 :3 0 62 63
0 27 :4 0 13
:3 0 28 :3 0 1a
:3 0 29 :3 0 68
69 0 27 67
6b 29 64 6d
:2 0 208 2a :3 0
2b :2 0 1a :3 0
29 :3 0 71 72
0 2c :3 0 70
73 :2 0 6f 75
1f :3 0 20 :3 0
77 78 0 2d
:4 0 13 :3 0 28
:3 0 1a :3 0 2a
:3 0 2d 7d 7f
2f 7c 81 31
79 83 :2 0 1f7
1b :3 0 25 :3 0
22 :3 0 1a :3 0
2a :4 0 2e 1
:8 0 8b 35 95
2f :3 0 30 :3 0
1e :3 0 8e 0
90 37 92 39
91 90 :2 0 93
3b :2 0 95 0
95 94 8b 93
:6 0 1cd 4 :3 0
1f :3 0 20 :3 0
97 98 0 31
:4 0 13 :3 0 28
:3 0 1a :3 0 2a
:3 0 3d 9d 9f
3f 9c a1 41
99 a3 :2 0 1cd
32 :3 0 22 :3 0
1a :3 0 2a :4 0
33 1 :8 0 1cd
1c :3 0 1c :3 0
34 :2 0 35 :4 0
ad :3 0 45 ac
af :3 0 aa b0
0 1cd 1f :3 0
20 :3 0 b2 b3
0 36 :4 0 13
:3 0 28 :3 0 1a
:3 0 2a :3 0 48
b8 ba 4a b7
bc 28 :3 0 35
:4 0 bf :3 0 4c
be c1 4e b4
c3 :2 0 1cd 32
:3 0 37 :3 0 38
:3 0 39 :3 0 3a
:3 0 3b :3 0 3c
:3 0 3d :3 0 3e
:3 0 22 :3 0 3f
:3 0 40 :3 0 41
:3 0 28 :3 0 42
:3 0 43 :3 0 42
:3 0 44 :3 0 42
:3 0 44 :3 0 37
:3 0 3f :3 0 40
:3 0 41 :3 0 42
:3 0 44 :3 0 45
:3 0 37 :3 0 38
:3 0 3f :3 0 40
:3 0 46 :3 0 3f
:3 0 41 :3 0 46
:3 0 3f :3 0 41
:3 0 39 :3 0 3f
:3 0 3a :3 0 3a
:3 0 3f :3 0 3b
:3 0 3b :3 0 3f
:3 0 3c :3 0 3c
:3 0 3f :3 0 3d
:3 0 3d :3 0 3f
:3 0 3e :3 0 3e
:3 0 3f :3 0 22
:3 0 47 :3 0 22
:3 0 47 :3 0 41
:3 0 47 :3 0 40
:3 0 48 :3 0 48
:3 0 49 :3 0 4a
:3 0 4b :3 0 4c
:3 0 4d :3 0 4b
:3 0 4d :3 0 3a
:3 0 4d :3 0 3b
:3 0 4d :3 0 3c
:3 0 4d :3 0 3d
:3 0 4d :3 0 3e
:3 0 4e :3 0 47
:3 0 13 :3 0 4b
:3 0 13 :3 0 3a
:3 0 4f :3 0 50
:3 0 46 :3 0 13
:3 0 51 :3 0 13
:3 0 3f :3 0 3b
:3 0 4f :3 0 50
:3 0 46 :3 0 13
:3 0 51 :3 0 13
:3 0 52 :3 0 3c
:3 0 4f :3 0 50
:3 0 46 :3 0 13
:3 0 51 :3 0 13
:3 0 3f :3 0 3d
:3 0 4f :3 0 50
:3 0 46 :3 0 13
:3 0 51 :3 0 13
:3 0 52 :3 0 3e
:3 0 53 :3 0 13
:3 0 13 :3 0 22
:3 0 1a :3 0 2a
:3 0 13 :3 0 4b
:3 0 13 :3 0 3a
:3 0 4d :3 0 54
:3 0 4b :3 0 4b
:3 0 53 :3 0 22
:3 0 1a :3 0 2a
:3 0 4a :3 0 47
:3 0 22 :3 0 1a
:3 0 2a :3 0 47
:3 0 41 :3 0 47
:3 0 40 :3 0 3f
:3 0 55 :3 0 45
:3 0 55 :3 0 42
:3 0 3f :3 0 4c
:3 0 45 :3 0 56
:3 0 3f :3 0 4b
:3 0 42 :3 0 56
:4 0 57 1 :8 0
1cd 1c :3 0 1c
:3 0 34 :2 0 35
:4 0 166 :3 0 53
165 168 :3 0 163
169 0 1cd 1f
:3 0 20 :3 0 16b
16c 0 58 :4 0
13 :3 0 28 :3 0
1a :3 0 2a :3 0
56 171 173 58
170 175 28 :3 0
35 :4 0 178 :3 0
5a 177 17a 5c
16d 17c :2 0 1cd
59 :3 0 5a :3 0
45 :3 0 56 :3 0
5b :3 0 42 :3 0
56 :3 0 5c :3 0
32 :3 0 5d :3 0
55 :3 0 45 :3 0
55 :3 0 42 :3 0
5d :3 0 22 :3 0
1a :3 0 2a :3 0
5d :3 0 37 :3 0
45 :3 0 37 :3 0
5d :3 0 38 :3 0
42 :3 0 37 :3 0
5e :3 0 5a :3 0
5f :3 0 5b :3 0
5c :3 0 2c :4 0
60 1 :8 0 19f
17e 19e 61 :3 0
62 :3 0 1a0 1a1
0 59 :3 0 5a
:3 0 1a3 1a4 0
61 1a2 1a6 :2 0
1b0 61 :3 0 63
:3 0 1a8 1a9 0
59 :3 0 5a :3 0
1ab 1ac 0 63
1aa 1ae :2 0 1b0
65 1b2 2c :3 0
19f 1b0 :4 0 1cd
1f :3 0 20 :3 0
1b3 1b4 0 64
:4 0 13 :3 0 68
1b5 1b8 :2 0 1cd
25 :3 0 22 :3 0
1a :3 0 2a :4 0
65 1 :8 0 1cd
1f :3 0 20 :3 0
1bf 1c0 0 66
:4 0 13 :3 0 28
:3 0 1a :3 0 2a
:3 0 6b 1c5 1c7
6d 1c4 1c9 6f
1c1 1cb :2 0 1cd
73 1e2 1e :3 0
1f :3 0 20 :3 0
1cf 1d0 0 67
:4 0 13 :3 0 28
:3 0 1a :3 0 2a
:3 0 80 1d5 1d7
82 1d4 1d9 84
1d1 1db :2 0 1dd
88 1df 8a 1de
1dd :2 0 1e0 8c
:2 0 1e2 0 1e2
1e1 1cd 1e0 :6 0
1f7 3 :3 0 68
:3 0 1e6 1e7 :2 0
1e8 68 :5 0 1e5
:2 0 1f7 1f :3 0
20 :3 0 1e9 1ea
0 69 :4 0 13
:3 0 28 :3 0 1a
:3 0 2a :3 0 8e
1ef 1f1 90 1ee
1f3 92 1eb 1f5
:2 0 1f7 96 1f9
2c :3 0 76 1f7
:4 0 208 1f :3 0
20 :3 0 1fa 1fb
0 6a :4 0 13
:3 0 9b 1fc 1ff
:2 0 208 1f :3 0
20 :3 0 201 202
0 6b :4 0 13
:3 0 9e 203 206
:2 0 208 a1 20c
:3 0 20c 12 :3 0
a8 20c 20b 208
209 :6 0 20d 1
0 28 2a 20c
26a :2 0 6c :3 0
6d :a 0 238 7
:7 0 6e :4 0 6
:3 0 212 213 0
238 210 214 :2 0
6e :3 0 6f :4 0
14 :2 0 70 :3 0
af 218 21a :3 0
14 :2 0 71 :3 0
72 :2 0 b2 21d
21f b4 21c 221
:3 0 14 :2 0 73
:4 0 b7 223 225
:3 0 14 :2 0 71
:3 0 72 :2 0 ba
228 22a bc 227
22c :3 0 14 :2 0
74 :3 0 bf 22e
230 :3 0 231 :2 0
233 c2 237 :3 0
237 6d :4 0 237
236 233 234 :6 0
238 1 0 210
214 237 26a :2 0
6c :3 0 75 :a 0
263 8 :7 0 6e
:4 0 6 :3 0 23d
23e 0 263 23b
23f :2 0 6e :3 0
76 :4 0 14 :2 0
4 :3 0 c4 243
245 :3 0 14 :2 0
71 :3 0 72 :2 0
c7 248 24a c9
247 24c :3 0 14
:2 0 77 :4 0 cc
24e 250 :3 0 14
:2 0 71 :3 0 72
:2 0 cf 253 255
d1 252 257 :3 0
14 :2 0 9 :3 0
d4 259 25b :3 0
25c :2 0 25e d7
262 :3 0 262 75
:4 0 262 261 25e
25f :6 0 263 1
0 23b 23f 262
26a :3 0 268 0
268 :3 0 268 26a
266 267 :6 0 26b
:2 0 3 :3 0 d9
0 3 268 26e
:3 0 26d 26b 26f
:8 0
e1
4
:3 0 1 7 1
4 1 10 1
d 1 19 1
16 1 22 1
1f 1 2f 2
32 34 1 2c
1 3e 1 42
1 47 1 4c
1 52 2 58
59 1 6a 3
65 66 6c 1
7e 1 80 3
7a 7b 82 1
8a 1 8f 1
8c 1 92 1
9e 1 a0 3
9a 9b a2 2
ab ae 1 b9
1 bb 1 c0
4 b5 b6 bd
c2 2 164 167
1 172 1 174
1 179 4 16e
16f 176 17b 1
1a5 1 1ad 2
1a7 1af 2 1b6
1b7 1 1c6 1
1c8 3 1c2 1c3
1ca c 95 a4
a9 b1 c4 162
16a 17d 1b2 1b9
1be 1cc 1 1d6
1 1d8 3 1d2
1d3 1da 1 1dc
1 1ce 1 1df
1 1f0 1 1f2
3 1ec 1ed 1f4
4 84 1e2 1e8
1f6 2 1fd 1fe
2 204 205 6
5b 61 6e 1f9
200 207 6 37
41 45 4a 50
54 2 217 219
1 21e 2 21b
220 2 222 224
1 229 2 226
22b 2 22d 22f
1 232 2 242
244 1 249 2
246 24b 2 24d
24f 1 254 2
251 256 2 258
25a 1 25d 7
b 14 1d 26
20d 238 263
1
4
0
26e
0
1
14
8
10
0 1 2 3 4 4 1 1
0 0 0 0 0 0 0 0
0 0 0 0
4c 2 0
16 1 0
4 1 0
3 0 1
47 2 0
3a 2 0
28 1 2
23b 1 8
42 2 0
17e 6 0
6f 3 0
52 2 0
2c 2 0
1f 1 0
d 1 0
210 1 7
0
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_accm_list.sql =========*** End 
 PROMPT ===================================================================================== 
 