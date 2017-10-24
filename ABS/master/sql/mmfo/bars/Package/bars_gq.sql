
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_gq.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_GQ 
is


    -----------------------------------------------------------------
    -- Constants
    --
    --
    g_headerVersion   constant varchar2(64)  := 'version 1.03 03.11.2006';
    g_headerDefs      constant varchar2(512) := '';


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2;


    -----------------------------------------------------------------
    -- CREATE_QUERY()
    --
    --     Процедура создания запроса и установки его в очередь
    --
    --     Параметры:
    --
    --         p_querytype    Тип информационного запроса
    --
    --         p_query        Запрос
    --
    --         p_queryid      Идентификатор созданного запроса
    --
    --
    procedure create_query(
        p_querytype  in  gq_query_type.querytype_id%type,
        p_query      in  clob,
        p_queryid    out gq_query.query_id%type          );


    -----------------------------------------------------------------
    -- GET_QUERY_RESPONSE()
    --
    --     Процедура получения ответа на запрос
    --
    --     Параметры:
    --
    --         p_queryid     Идентификатор запроса
    --
    --         p_response    Ответ на запрос
    --
    procedure get_query_response(
        p_queryid    in  gq_query.query_id%type,
        p_status     out gq_query.query_status%type,
        p_response   out clob                        );


    -----------------------------------------------------------------
    -- PROCESS_QUERY_QUEUE()
    --
    --     Процедура обработки очереди запросов
    --
    --
    procedure process_query_queue;


    -----------------------------------------------------------------
    -- CLEAR_ACTIVE_QUERY()
    --
    --     Процедура удаления признака активного запроса
    --
    --
    procedure clear_active_query(
        p_queryid   in  number    );


end bars_gq;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_GQ wrapped
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
7a
2 :e:
1PACKAGE:
1BODY:
1BARS_GQ:
1G_BODYVERSION:
1CONSTANT:
1VARCHAR2:
164:
1version 1.04 19.06.2009:
1G_BODYDEFS:
1512:
1:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1package header BARS_GQ :
1||:
1G_HEADERVERSION:
1CHR:
110:
1package header definition(s):::
1G_HEADERDEFS:
1BODY_VERSION:
1package body BARS_GQ :
1package body definition(s):::
1CREATE_QUERY:
1P_QUERYTYPE:
1GQ_QUERY_TYPE:
1QUERYTYPE_ID:
1TYPE:
1P_QUERY:
1CLOB:
1P_QUERYID:
1OUT:
1GQ_QUERY:
1QUERY_ID:
1BARS_AUDIT:
1TRACE:
1bars_gq:: create_query entry point:
1bars_gq:: create_query par[0]=> %s:
1TO_CHAR:
1QUERY_STATUS:
1REQUEST_DATE:
1REQUEST:
1USER_ID:
1S_GQQUERY:
1NEXTVAL:
1SYSDATE:
1XMLTYPE:
1RETURNING:
1INSERT into gq_query(query_id, querytype_id, query_status, request_date, requ+
1est, user_id):n        values (s_gqquery.nextval, p_querytype, 0, sysdate, xm+
1ltype(p_query), user_id):n        returning query_id into p_queryid:
1GQ_QUERY_ACTIVE:
1INSERT into gq_query_active(query_id) values (p_queryid):
1bars_gq:: new query created, id =%s:
1INFO:
1GQ:: Создан информационный запрос типа :
1 с идентификатором :
1bars_gq:: create_query end:
1GET_QUERY_RESPONSE:
1P_STATUS:
1P_RESPONSE:
1L_RESPONSE:
1RESPONSE:
1bars_gq:: get_response entry point:
1bars_gq:: get_response par[0] => %s:
1SELECT response, query_status into l_response, p_status:n              from g+
1q_query:n             where query_id = p_queryid:
1NO_DATA_FOUND:
1RAISE_APPLICATION_ERROR:
1-:
120001:
1\0800 Запрос не найден:
1bars_gq:: get_response query status => %s:
1!=:
10:
1GETCLOBVAL:
1bars_gq:: get_response end:
1PROCESS_QUERY_QUEUE:
1L_ID:
1L_STATUS:
1bars_gq:: process_query_queue entry point:
1GQ:: Обработка очереди информационных сообщений:
1CURS_GQ:
1Q:
1QT:
1QUERYTYPE_PROC:
1V_GQQUERY_QUEUE:
1QUERYTYPE_STATUS:
1LOOP:
1select q.query_id, q.request, qt.querytype_proc:n                          fr+
1om v_gqquery_queue q, gq_query_type qt:n                         where q.quer+
1ytype_id = qt.querytype_id:n                           and qt.querytype_statu+
1s = 1  /* active type */:n                           and q.query_status      +
1= 0  /* for processing  */ :
1bars_gq:: process_query_queue attempt to lock query id=%s ...:
1SAVEPOINT:
1SP_BEFORELOCKQUERY:
1SELECT query_id into l_id :n                  from gq_query:n                +
1 where query_id = curs_gq.query_id:n                for update nowait:
1bars_gq:: process_query_queue query id=%s locked.:
1bars_gq:: process_query_queue processing query id=%s ...:
1EXECUTE:
1IMMEDIATE:
1begin :
1(::p_request, ::p_status, ::p_response); end;:
1USING:
1bars_gq:: process_query_queue query id=%s successfully processed.:
1RESPONSE_DATE:
1UPDATE gq_query:n                   set query_status  = l_status,:n          +
1             response      = l_response,:n                       response_dat+
1e = sysdate:n                 where query_id = curs_gq.query_id:
1bars_gq:: process_query_queue query id=%s response successfully saved.:
1COMMIT:
1OTHERS:
1SQLCODE:
1=:
154:
1bars_gq.process_query_queue can't lock query id=%s:
1ROLLBACK:
1ROLLBACK_SV:
1ERROR:
1GQ:: Ошибка при обработке запроса с идентификатором :
1 :::
1SQLERRM:
1GQ:: Очередь информационных сообщений успешно обработана.:
1bars_gq:: process_query_queue end:
1CLEAR_ACTIVE_QUERY:
1NUMBER:
1barsgq.clear_active_query:: entry point:
1DELETE from gq_query_active:n         where query_id = p_queryid:
1barsgq.clear_active_query:: end:
0

0
0
28d
2
0 :2 a0 97 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 a0 8d a0 b4 a0
2c 6a a0 6e 7e a0 b4 2e
7e a0 51 a5 b b4 2e 7e
6e b4 2e 7e a0 51 a5 b
b4 2e 7e a0 b4 2e 65 b7
a4 a0 b1 11 68 4f a0 8d
a0 b4 a0 2c 6a a0 6e 7e
a0 b4 2e 7e a0 51 a5 b
b4 2e 7e 6e b4 2e 7e a0
51 a5 b b4 2e 7e a0 b4
2e 65 b7 a4 a0 b1 11 68
4f 9a 8f :2 a0 6b :2 a0 f b0
3d 8f a0 b0 3d 96 :3 a0 6b
:2 a0 f b0 54 b4 55 6a :2 a0
6b 6e a5 57 :2 a0 6b 6e :2 a0
a5 b a5 57 :11 a0 12a :3 a0 12a
:2 a0 6b 6e :2 a0 a5 b a5 57
:2 a0 6b 6e 7e :2 a0 a5 b b4
2e 7e 6e b4 2e 7e :2 a0 a5
b b4 2e a5 57 :2 a0 6b 6e
a5 57 b7 a4 a0 b1 11 68
4f 9a 8f :2 a0 6b :2 a0 f b0
3d 96 :3 a0 6b :2 a0 f b0 54
96 :2 a0 b0 54 b4 55 6a a3
:2 a0 6b :2 a0 f 1c 81 b0 :2 a0
6b 6e a5 57 :2 a0 6b 6e :2 a0
a5 b a5 57 :7 a0 12a b7 :2 a0
7e 51 b4 2e 6e a5 57 b7
a6 9 a4 b1 11 4f :2 a0 6b
6e :2 a0 a5 b a5 57 a0 7e
51 b4 2e 5a :3 a0 6b d b7
19 3c :2 a0 6b 6e a5 57 b7
a4 a0 b1 11 68 4f 9a b4
55 6a a3 :2 a0 6b :2 a0 f 1c
81 b0 a3 :2 a0 6b :2 a0 f 1c
81 b0 a3 :2 a0 6b :2 a0 f 1c
81 b0 :2 a0 6b 6e a5 57 :2 a0
6b 6e a5 57 91 :13 a0 12a 37
:2 a0 6b 6e :3 a0 6b a5 b a5
57 :2 a0 57 a0 b4 a5 6e e9
:6 a0 12a :2 a0 6b 6e :3 a0 6b a5
b a5 57 :2 a0 6b 6e :3 a0 6b
a5 b a5 57 :2 a0 6e 7e :2 a0
6b b4 2e 7e 6e a0 b4 2e
:2 a0 6b 112 :2 a0 114 :2 a0 114 11e
11a 11d :2 a0 6b 6e :3 a0 6b a5
b a5 57 :a a0 12a :2 a0 6b 6e
:3 a0 6b a5 b a5 57 a0 57
a0 b4 e9 b7 a0 53 a0 :2 7e
51 b4 2e b4 2e 5a :2 a0 6b
6e :3 a0 6b a5 b a5 57 b7
:2 a0 57 a0 b4 a5 6e e9 :2 a0
6b 6e 7e :3 a0 6b a5 b b4
2e 7e 6e b4 2e 7e a0 b4
2e a5 57 b7 :2 19 3c b7 a6
9 a4 b1 11 4f b7 a0 47
:2 a0 6b 6e a5 57 :2 a0 6b 6e
a5 57 b7 a4 a0 b1 11 68
4f 9a 8f a0 b0 3d b4 55
6a :2 a0 6b 6e a5 57 :3 a0 12a
:2 a0 6b 6e a5 57 b7 a4 a0
b1 11 68 4f b1 b7 a4 11
a0 b1 56 4f 1d 17 b5
28d
2
0 3 7 b 36 19 1d 21
24 25 2d 32 18 5b 41 45
15 49 4a 52 57 40 62 66
7a 3d 7e 82 86 8a 8e 93
96 9a 9b a0 a3 a7 aa ab
ad ae b3 b6 bb bc c1 c4
c8 cb cc ce cf d4 d7 db
dc e1 e5 e7 eb ef f1 fd
101 103 107 11b 11f 120 124 128
12c 130 135 138 13c 13d 142 145
149 14c 14d 14f 150 155 158 15d
15e 163 166 16a 16d 16e 170 171
176 179 17d 17e 183 187 189 18d
191 193 19f 1a3 1a5 1d5 1bd 1c1
1c5 1c8 1cc 1d0 1bc 1dd 1ea 1e6
1b9 1f2 213 1f7 1fb 1ff 203 206
20a 20e 1e5 21a 1e2 21f 223 227
22b 22f 232 237 238 23d 241 245
248 24d 251 255 256 258 259 25e
262 266 26a 26e 272 276 27a 27e
282 286 28a 28e 292 296 29a 29e
2a2 2ae 2b2 2b6 2ba 2c6 2ca 2ce
2d1 2d6 2da 2de 2df 2e1 2e2 2e7
2eb 2ef 2f2 2f7 2fa 2fe 302 303
305 306 30b 30e 313 314 319 31c
320 324 325 327 328 32d 32e 333
337 33b 33e 343 344 349 34b 34f
353 355 361 365 367 397 37f 383
387 38a 38e 392 37e 39f 3c1 3a8
3ac 3b0 37b 3b4 3b8 3bc 3a7 3c8
3d9 3d1 3d5 3a4 3e0 3d0 3e5 3e9
413 3f1 3f5 3cd 3f9 3fd 401 406
40e 3f0 41a 41e 3ed 422 427 428
42d 431 435 438 43d 441 445 446
448 449 44e 452 456 45a 45e 462
466 46a 476 478 47c 480 483 486
487 48c 491 492 497 499 49a 49f
4a3 4a5 4b1 4b3 4b7 4bb 4be 4c3
4c7 4cb 4cc 4ce 4cf 4d4 4d8 4db
4de 4df 4e4 4e7 4eb 4ef 4f3 4f6
4fa 4fc 500 503 507 50b 50e 513
514 519 51b 51f 523 525 531 535
537 54b 54c 550 57d 558 55c 560
563 567 56b 570 578 557 5aa 588
58c 554 590 594 598 59d 5a5 587
5d7 5b5 5b9 584 5bd 5c1 5c5 5ca
5d2 5b4 5de 5e2 5b1 5e6 5eb 5ec
5f1 5f5 5f9 5fc 601 602 607 60b
60f 613 617 61b 61f 623 627 62b
62f 633 637 63b 63f 643 647 64b
64f 653 657 663 665 669 66d 670
675 679 67d 681 684 685 687 688
68d 691 695 69a 69e 69f 6a0 6a5
6aa 6ae 6b2 6b6 6ba 6be 6c2 6ce
6d2 6d6 6d9 6de 6e2 6e6 6ea 6ed
6ee 6f0 6f1 6f6 6fa 6fe 701 706
70a 70e 712 715 716 718 719 71e
722 726 72b 72e 732 736 739 73a
73f 742 747 74b 74c 751 755 759
75c 75d 761 765 766 76a 76e 76f
774 775 779 77d 781 784 789 78d
791 795 798 799 79b 79c 7a1 7a5
7a9 7ad 7b1 7b5 7b9 7bd 7c1 7c5
7c9 7d5 7d9 7dd 7e0 7e5 7e9 7ed
7f1 7f4 7f5 7f7 7f8 7fd 801 806
80a 80b 810 812 1 816 81a 81d
820 823 824 829 82a 82f 832 836
83a 83d 842 846 84a 84e 851 852
854 855 85a 85c 860 864 869 86d
86e 86f 874 879 87d 881 884 889
88c 890 894 898 89b 89c 89e 89f
8a4 8a7 8ac 8ad 8b2 8b5 8b9 8ba
8bf 8c0 8c5 8c7 8cb 8cf 8d2 8d4
8d5 8da 8de 8e0 8ec 8ee 8f0 8f4
8fb 8ff 903 906 90b 90c 911 915
919 91c 921 922 927 929 92d 931
933 93f 943 945 961 95d 95c 969
959 96e 972 976 97a 97e 981 986
987 98c 990 994 998 9a4 9a8 9ac
9af 9b4 9b5 9ba 9bc 9c0 9c4 9c6
9d2 9d6 9d8 9da 9dc 9e0 9ec 9f0
9f2 9f5 9f7 9f8 a01
28d
2
0 1 9 e 5 15 1e 27
26 1e 2f 15 :2 5 15 1e 27
26 1e 2f 15 :2 5 e 1d 0
24 :2 5 9 10 2a 2d :2 10 3d
40 44 :2 40 :2 10 48 :3 10 30 33
37 :2 33 :2 10 3b 3e :2 10 9 :2 5
9 :5 5 e 1b 0 22 :2 5 9
10 28 2b :2 10 39 3c 40 :2 3c
:2 10 44 :3 10 2e 31 35 :2 31 :2 10
39 3c :2 10 9 :2 5 9 :4 5 f
9 1a 28 1a :2 35 1a :3 9 1a
:3 9 16 1a 23 1a :2 2c 1a :2 9
1b :2 5 9 :2 14 1a :3 9 :2 14 1a
3f 47 :2 3f :2 9 15 1e 28 36
44 52 5b 11 1b 24 34 3d
45 4f 9 13 21 9 15 25
37 :2 9 :2 14 1a 40 48 :2 40 :3 9
:2 14 19 42 45 4d :2 45 :2 19 5a
5d :2 19 73 76 7e :2 76 :2 19 :3 9
:2 14 1a :2 9 :2 5 9 :4 5 f 9
1a 23 1a :2 2c 1a :3 9 16 1a
23 1a :2 30 1a :3 9 16 1b :2 9
21 :3 5 11 1a 11 :2 23 :3 11 5
9 :2 14 1a :3 9 :2 14 1a 40 48
:2 40 :2 9 14 1e 30 3c :2 14 1f
d 9 12 11 29 2a :2 29 31
:2 11 20 :2 d 9 :3 5 9 :2 14 1a
46 4e :2 46 :2 9 d 16 19 :2 16
c d 1b :2 26 d 1c :3 9 :2 14
1a :2 9 :2 5 9 :4 5 f 0 :3 5
11 1a 11 :2 23 :3 11 :2 5 11 1a
11 :2 27 :3 11 :2 5 11 1a 11 :2 23
:3 11 5 9 :2 14 1a :3 9 :2 14 19
:2 9 d 20 22 2c 2e 37 3a
20 30 33 41 20 22 31 34
20 23 20 22 9 18 9 d
:2 18 1e 5e 66 :2 6e :2 5e :3 d 17
:6 d 18 26 :2 18 23 2b :2 11 :2 1c
22 56 5e :2 66 :2 56 :3 11 :2 1c 22
5d 65 :2 6d :2 5d :3 11 19 23 2c
2f :2 37 :2 23 46 49 11 :2 23 1a
:2 22 17 2b 2f 2b 39 3d 39
:4 11 :2 1c 22 66 6e :2 76 :2 66 :2 11
:2 18 28 18 28 18 28 18 23
2b :2 11 :2 1c 22 6b 73 :2 7b :2 6b
:7 11 d :2 16 19 21 23 24 :2 23
:2 21 18 19 :2 24 2a 61 69 :2 71
:2 61 :2 19 28 19 25 :7 19 :2 24 2a
60 63 6b :2 73 :2 63 :2 2a 7d 80
:2 2a 85 88 :2 2a :2 19 :4 15 1d :2 11
d :4 9 d :2 9 :2 14 1a :3 9 :2 14
1a :2 9 :2 5 9 :4 5 f 9 19
:2 9 21 :2 5 9 :2 14 1a :2 9 15
10 1b :2 9 :2 14 1a :2 9 :2 5 9
:9 5 :6 1
28d
4
0 :3 1 :9 9 :9 a
:3 14 0 :3 14 :e 17
18 :2 17 :5 18 :2 17
:2 18 :3 17 :2 16 19
:4 14 :3 23 0 :3 23
:e 26 27 :2 26 :5 27
:2 26 :2 27 :3 26 :2 25
28 :4 23 39 :9 3a
:4 3b :a 3c :3 39 :6 40
:a 41 :7 43 :7 44 :3 45
43 :4 47 :a 49 :18 4a
:6 4b :2 3e 4d :4 39
5d :9 5e :a 5f :5 60
:3 5d :a 63 :6 67 :a 68
:4 6b 6c :2 6d 6b
6a 6f :8 70 :3 6f
6e :3 65 :a 73 :6 75
:5 76 :3 75 :6 79 :2 65
7b :4 5d 84 0
:2 84 :a 87 :a 88 :a 89
:6 8d :6 8e :7 90 :4 91
:4 92 :2 93 :2 94 95
:2 90 :c 97 :8 99 :2 9c
9d :3 9e 9c :c a1
:c a3 :b a5 a6 :2 a5
:a a6 :3 a5 :c a8 aa
:2 ab :2 ac :2 ad :3 ae
aa :c b0 :5 b1 9b
:2 b4 :9 b5 :c b6 b5
:8 b8 :17 b9 b7 :3 b5
:3 b4 b3 :4 95 bd
90 :6 bf :6 c0 :2 8b
c2 :4 84 cb :4 cc
:3 cb :6 d0 d2 :2 d3
d2 :6 d5 :2 ce d7
:4 cb :4 14 d9 :6 1

a03
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 a :2 0 :2 5
:3 0 6 :3 0 7
:2 0 3 6 8
:6 0 8 :4 0 c
9 a 287 4
:9 0 9 5 :3 0
6 :3 0 7 f
11 :6 0 b :4 0
15 12 13 287
9 :6 0 c :3 0
d :a 0 3f 2
:7 0 e :3 0 6
:3 0 19 1a 0
3f 17 1b :2 0
e :3 0 f :4 0
10 :2 0 11 :3 0
b 1f 21 :3 0
10 :2 0 12 :3 0
13 :2 0 e 24
26 10 23 28
:3 0 10 :2 0 14
:4 0 13 2a 2c
:3 0 10 :2 0 12
:3 0 13 :2 0 16
2f 31 18 2e
33 :3 0 10 :2 0
15 :3 0 1b 35
37 :3 0 38 :2 0
3a 1e 3e :3 0
3e d :4 0 3e
3d 3a 3b :6 0
3f 1 0 17
1b 3e 287 :2 0
c :3 0 16 :a 0
6a 3 :7 0 e
:4 0 6 :3 0 44
45 0 6a 42
46 :2 0 e :3 0
17 :4 0 10 :2 0
4 :3 0 20 4a
4c :3 0 10 :2 0
12 :3 0 13 :2 0
23 4f 51 25
4e 53 :3 0 10
:2 0 18 :4 0 28
55 57 :3 0 10
:2 0 12 :3 0 13
:2 0 2b 5a 5c
2d 59 5e :3 0
10 :2 0 9 :3 0
30 60 62 :3 0
63 :2 0 65 33
69 :3 0 69 16
:4 0 69 68 65
66 :6 0 6a 1
0 42 46 69
287 :2 0 19 :a 0
da 4 :7 0 37
1e2 0 35 1b
:3 0 1c :2 0 4
6e 6f 0 1d
:3 0 1d :2 0 1
70 72 :3 0 1a
:7 0 74 73 :3 0
3b :2 0 39 1f
:3 0 1e :7 0 78
77 :3 0 21 :3 0
22 :3 0 23 :2 0
4 7c 7d 0
1d :3 0 1d :2 0
1 7e 80 :3 0
20 :6 0 82 81
:3 0 84 :2 0 da
6c 85 :2 0 24
:3 0 25 :3 0 87
88 0 26 :4 0
3f 89 8b :2 0
d5 24 :3 0 25
:3 0 8d 8e 0
27 :4 0 28 :3 0
1a :3 0 41 91
93 43 8f 95
:2 0 d5 22 :3 0
23 :3 0 1c :3 0
29 :3 0 2a :3 0
2b :3 0 2c :3 0
2d :3 0 2e :3 0
1a :3 0 2f :3 0
30 :3 0 1e :3 0
2c :3 0 31 :3 0
23 :3 0 20 :4 0
32 1 :8 0 d5
33 :3 0 23 :3 0
20 :4 0 34 1
:8 0 d5 24 :3 0
25 :3 0 ad ae
0 35 :4 0 28
:3 0 20 :3 0 46
b1 b3 48 af
b5 :2 0 d5 24
:3 0 36 :3 0 b7
b8 0 37 :4 0
10 :2 0 28 :3 0
1a :3 0 4b bc
be 4d bb c0
:3 0 10 :2 0 38
:4 0 50 c2 c4
:3 0 10 :2 0 28
:3 0 20 :3 0 53
c7 c9 55 c6
cb :3 0 58 b9
cd :2 0 d5 24
:3 0 25 :3 0 cf
d0 0 39 :4 0
5a d1 d3 :2 0
d5 5c d9 :3 0
d9 19 :4 0 d9
d8 d5 d6 :6 0
da 1 0 6c
85 d9 287 :2 0
3a :a 0 14e 5
:7 0 e8 e9 0
64 22 :3 0 23
:2 0 4 de df
0 1d :3 0 1d
:2 0 1 e0 e2
:3 0 20 :7 0 e4
e3 :3 0 68 3cd
0 66 21 :3 0
22 :3 0 29 :2 0
4 1d :3 0 1d
:2 0 1 ea ec
:3 0 3b :6 0 ee
ed :3 0 f9 fa
0 6a 21 :3 0
1f :3 0 3c :6 0
f3 f2 :3 0 f5
:2 0 14e dc f6
:2 0 102 103 0
6e 22 :3 0 3e
:2 0 4 1d :3 0
1d :2 0 1 fb
fd :3 0 fe :7 0
101 ff 0 14c
0 3d :6 0 24
:3 0 25 :3 0 3f
:4 0 70 104 106
:2 0 149 24 :3 0
25 :3 0 108 109
0 40 :4 0 28
:3 0 20 :3 0 72
10c 10e 74 10a
110 :2 0 149 3e
:3 0 29 :3 0 3d
:3 0 3b :3 0 22
:3 0 23 :3 0 20
:4 0 41 1 :8 0
11a 77 129 42
:3 0 43 :3 0 44
:2 0 45 :2 0 79
11d 11f :3 0 46
:4 0 7b 11c 122
:2 0 124 7e 126
80 125 124 :2 0
127 82 :2 0 129
0 129 128 11a
127 :6 0 149 5
:3 0 24 :3 0 25
:3 0 12b 12c 0
47 :4 0 28 :3 0
3b :3 0 84 12f
131 86 12d 133
:2 0 149 3b :3 0
48 :2 0 49 :2 0
8b 136 138 :3 0
139 :2 0 3c :3 0
3d :3 0 4a :3 0
13c 13d 0 13b
13e 0 140 8e
141 13a 140 0
142 90 0 149
24 :3 0 25 :3 0
143 144 0 4b
:4 0 92 145 147
:2 0 149 94 14d
:3 0 14d 3a :3 0
9b 14d 14c 149
14a :6 0 14e 1
0 dc f6 14d
287 :2 0 4c :a 0
261 7 :8 0 151
:2 0 261 150 152
:2 0 15f 160 0
9d 22 :3 0 23
:2 0 4 155 156
0 1d :3 0 1d
:2 0 1 157 159
:3 0 15a :7 0 15d
15b 0 25f 0
4d :6 0 169 16a
0 9f 22 :3 0
29 :2 0 4 1d
:3 0 1d :2 0 1
161 163 :3 0 164
:7 0 167 165 0
25f 0 4e :6 0
172 173 0 a1
22 :3 0 3e :2 0
4 1d :3 0 1d
:2 0 1 16b 16d
:3 0 16e :7 0 171
16f 0 25f 0
3d :6 0 24 :3 0
25 :3 0 4f :4 0
a3 174 176 :2 0
25c 24 :3 0 36
:3 0 178 179 0
50 :4 0 a5 17a
17c :2 0 25c 51
:3 0 52 :3 0 23
:3 0 52 :3 0 2b
:3 0 53 :3 0 54
:3 0 55 :3 0 52
:3 0 1b :3 0 53
:3 0 52 :3 0 1c
:3 0 53 :3 0 1c
:3 0 53 :3 0 56
:3 0 52 :3 0 29
:3 0 57 :4 0 58
1 :8 0 193 17e
192 24 :3 0 25
:3 0 194 195 0
59 :4 0 28 :3 0
51 :3 0 23 :3 0
199 19a 0 a7
198 19c a9 196
19e :2 0 24d 5a
:3 0 5b :3 0 1a3
1a5 :2 0 1a7 5a
:4 0 ac 5b :5 0
1a2 :2 0 24d 23
:3 0 4d :3 0 22
:3 0 23 :3 0 51
:3 0 23 :4 0 5c
1 :8 0 20a 24
:3 0 25 :3 0 1af
1b0 0 5d :4 0
28 :3 0 51 :3 0
23 :3 0 1b4 1b5
0 ae 1b3 1b7
b0 1b1 1b9 :2 0
20a 24 :3 0 25
:3 0 1bb 1bc 0
5e :4 0 28 :3 0
51 :3 0 23 :3 0
1c0 1c1 0 b3
1bf 1c3 b5 1bd
1c5 :2 0 20a 5f
:3 0 60 :3 0 61
:4 0 10 :2 0 51
:3 0 54 :3 0 1cb
1cc 0 b8 1ca
1ce :3 0 10 :2 0
62 :4 0 63 :3 0
bb 1d0 1d3 :3 0
51 :3 0 2b :3 0
1d5 1d6 0 1d7
21 :3 0 4e :3 0
1da 21 :3 0 3d
:3 0 1dd 1d4 0
1e0 :2 0 be 1df
:2 0 20a 24 :3 0
25 :3 0 1e2 1e3
0 64 :4 0 28
:3 0 51 :3 0 23
:3 0 1e7 1e8 0
c2 1e6 1ea c4
1e4 1ec :2 0 20a
22 :3 0 29 :3 0
4e :3 0 3e :3 0
3d :3 0 65 :3 0
2f :3 0 23 :3 0
51 :3 0 23 :4 0
66 1 :8 0 20a
24 :3 0 25 :3 0
1f9 1fa 0 67
:4 0 28 :3 0 51
:3 0 23 :3 0 1fe
1ff 0 c7 1fd
201 c9 1fb 203
:2 0 20a 68 :3 0
207 208 :2 0 209
68 :5 0 206 :2 0
20a cc 24b 69
:3 0 6a :3 0 6b
:2 0 44 :2 0 6c
:2 0 d5 20f 211
:3 0 d9 20e 213
:3 0 214 :2 0 24
:3 0 25 :3 0 216
217 0 6d :4 0
28 :3 0 51 :3 0
23 :3 0 21b 21c
0 dc 21a 21e
de 218 220 :2 0
222 e1 243 6e
:3 0 5b :3 0 226
228 :2 0 22a 6f
:4 0 e3 5b :5 0
225 :2 0 242 24
:3 0 70 :3 0 22b
22c 0 71 :4 0
10 :2 0 28 :3 0
51 :3 0 23 :3 0
231 232 0 e5
230 234 e7 22f
236 :3 0 10 :2 0
72 :4 0 ea 238
23a :3 0 10 :2 0
73 :3 0 ed 23c
23e :3 0 f0 22d
240 :2 0 242 f2
244 215 222 0
245 0 242 0
245 f5 0 246
f8 248 fa 247
246 :2 0 249 fc
:2 0 24b 0 24b
24a 20a 249 :6 0
24d 8 :3 0 fe
24f 57 :3 0 193
24d :4 0 25c 24
:3 0 25 :3 0 250
251 0 74 :4 0
102 252 254 :2 0
25c 24 :3 0 25
:3 0 256 257 0
75 :4 0 104 258
25a :2 0 25c 106
260 :3 0 260 4c
:3 0 10c 260 25f
25c 25d :6 0 261
1 0 150 152
260 287 :2 0 76
:a 0 280 a :7 0
112 :2 0 110 77
:3 0 20 :7 0 266
265 :3 0 268 :2 0
280 263 269 :2 0
24 :3 0 25 :3 0
26b 26c 0 78
:4 0 114 26d 26f
:2 0 27b 33 :3 0
23 :3 0 20 :4 0
79 1 :8 0 27b
24 :3 0 25 :3 0
275 276 0 7a
:4 0 116 277 279
:2 0 27b 118 27f
:3 0 27f 76 :4 0
27f 27e 27b 27c
:6 0 280 1 0
263 269 27f 287
:3 0 285 0 285
:3 0 285 287 283
284 :6 0 288 :2 0
3 :3 0 11c 0
3 285 28b :3 0
28a 288 28c :8 0

125
4
:3 0 1 7 1
4 1 10 1
d 2 1e 20
1 25 2 22
27 2 29 2b
1 30 2 2d
32 2 34 36
1 39 2 49
4b 1 50 2
4d 52 2 54
56 1 5b 2
58 5d 2 5f
61 1 64 1
6d 1 76 1
7a 3 75 79
83 1 8a 1
92 2 90 94
1 b2 2 b0
b4 1 bd 2
ba bf 2 c1
c3 1 c8 2
c5 ca 1 cc
1 d2 7 8c
96 a8 ac b6
ce d4 1 dd
1 e6 1 f0
3 e5 ef f4
1 f8 1 105
1 10d 2 10b
10f 1 119 1
11e 2 120 121
1 123 1 11b
1 126 1 130
2 12e 132 1
137 2 135 137
1 13f 1 141
1 146 6 107
111 129 134 142
148 1 100 1
154 1 15e 1
168 1 175 1
17b 1 19b 2
197 19d 1 1a6
1 1b6 2 1b2
1b8 1 1c2 2
1be 1c4 2 1c9
1cd 2 1cf 1d1
3 1d8 1db 1de
1 1e9 2 1e5
1eb 1 200 2
1fc 202 8 1ae
1ba 1c6 1e1 1ed
1f8 204 209 1
210 1 212 2
20d 212 1 21d
2 219 21f 1
221 1 229 1
233 2 22e 235
2 237 239 2
23b 23d 1 23f
2 22a 241 2
243 244 1 245
1 20c 1 248
3 19f 1a7 24b
1 253 1 259
5 177 17d 24f
255 25b 3 15c
166 170 1 264
1 267 1 26e
1 278 3 270
274 27a 8 b
14 3f 6a da
14e 261 280
1
4
0
28b
0
1
14
a
15
0 1 1 1 1 5 1 7
8 1 0 0 0 0 0 0
0 0 0 0
154 7 0
f0 5 0
15e 7 0
d 1 0
4 1 0
e6 5 0
150 1 7
42 1 3
168 7 0
f8 5 0
76 4 0
6c 1 4
263 1 a
264 a 0
dd 5 0
7a 4 0
3 0 1
17e 8 0
dc 1 5
17 1 2
6d 4 0
0
/
 show err;
 
PROMPT *** Create  grants  BARS_GQ ***
grant EXECUTE                                                                on BARS_GQ         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_GQ         to DPT_ROLE;
grant EXECUTE                                                                on BARS_GQ         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_gq.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 