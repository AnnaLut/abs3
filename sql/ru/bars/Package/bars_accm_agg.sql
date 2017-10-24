
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_accm_agg.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ACCM_AGG 
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             Пакет заполнения накопительных таблиц           --
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

    VERSION_HEADER       constant varchar2(64)  := 'version 0.2 06.01.2010';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';




    -----------------------------------------------------------------
    -- AGG_MONBAL()
    --
    --     Накопление месячного баланса с корректирующими проводками
    --
    --
    --
    procedure agg_monbal(
                  p_aggdate in date,
                  p_aggmode in number );


    -----------------------------------------------------------------
    -- AGG_YEARBAL()
    --
    --     Накопление годового баланса с оборотами перекрытия
    --
    --
    --
    procedure agg_yearbal(
                  p_aggdate in date,
                  p_aggmode in number );



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



end bars_accm_agg;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ACCM_AGG wrapped
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
bf
2 :e:
1PACKAGE:
1BODY:
1BARS_ACCM_AGG:
1VERSION_BODY:
1CONSTANT:
1VARCHAR2:
164:
1version 0.5 12.02.2010:
1VERSION_BODY_DEFS:
1512:
1:
1MODCODE:
13:
1ACM:
1PKG_CODE:
1100:
1accmagg:
1FMT_DATE:
120:
1dd.mm.yyyy:
1CREATE_MONBAL:
1P_BALDATE:
1DATE:
1P:
1||:
1.crmonbal:
1L_FIRSTDT:
1L_FIRSTDTID:
1NUMBER:
1L_LASTDT:
1L_LASTDTID:
1L_BALDTID:
1L_FIRSTDT2:
1L_FIRSTDTID2:
1PART_NOT_EXISTS:
1PRAGMA:
1EXCEPTION_INIT:
1-:
12149:
1BARS_AUDIT:
1TRACE:
1%s:: entry point par[0]=>%s:
1TO_CHAR:
1TRUNC:
1mon:
1ddmm:
1=:
10101:
1+:
11:
1BARS_ACCM_CALENDAR:
1GET_CALENDAR_ID:
1ADD_MONTHS:
1%s:: first date %s/%s (%s/%s), last date %s (%s):
1MAX:
1S:
1CALDT_ID:
1ACCM_STATE_SNAP:
1SNAP_BALANCE:
1SELECT max(s.caldt_id) into l_baldtid:n          from accm_state_snap s:n    +
1     where s.caldt_id between l_firstdtid2 and l_lastdtid:n           and s.s+
1nap_balance = 'Y':
1%s:: last balance date is %s:
1ACCM_STATE_AGG:
1AGG_MONBAL:
1UPDATE accm_state_agg:n           set agg_monbal = 'N':n         where caldt_+
1id = l_firstdtid:
1ROWCOUNT:
10:
1INSERT into accm_state_agg(caldt_id) values (l_firstdtid):
1EXECUTE:
1IMMEDIATE:
1alter table accm_agg_monbals truncate partition for (:
1):
1%s:: snap partition truncated:
1ACCM_AGG_MONBALS:
1ACC:
1RNK:
1OST:
1OSTQ:
1DOS:
1DOSQ:
1KOS:
1KOSQ:
1CRDOS:
1CRDOSQ:
1CRKOS:
1CRKOSQ:
1CUDOS:
1CUDOSQ:
1CUKOS:
1CUKOSQ:
1ABS:
1DECODE:
1SUM:
1ACCM_SNAP_BALANCES:
1B:
1INSERT into accm_agg_monbals(caldt_id, acc, rnk, ost, ostq, dos, dosq, kos, k+
1osq, crdos, crdosq, crkos, crkosq, cudos, cudosq, cukos, cukosq):n        sel+
1ect l_firstdtid, acc, :n               abs(max(decode(caldt_id, l_baldtid, rn+
1k, -rnk))), :n               sum(decode(caldt_id, l_baldtid, ost, 0)), :n    +
1           sum(decode(caldt_id, l_baldtid, ostq, 0)), :n               sum(do+
1s), sum(dosq), sum(kos), sum(kosq), :n               0, 0, 0, 0, 0, 0, 0, 0:n+
1          from accm_snap_balances b:n         where b.caldt_id between l_firs+
1tdtid2 and l_lastdtid:n        group by acc:
1%s:: month balance rest and turns collected:
1C:
1D:
1ACCM_LIST_CORRDOCS:
1COR_TYPE:
1ACCM_CALENDAR:
1CORDT_ID:
1CALDT_DATE:
1LOOP:
1select acc, sum(crdos) crdos,  sum(crdosq) crdosq, sum(crkos) crkos, sum(crko+
1sq) crkosq,:n                         sum(cudos) cudos,  sum(cudosq) cudosq, +
1sum(cukos) cukos, sum(cukosq) cukosq:n                    from (select d.acc,+
1 0 crdos, 0 crdosq, 0 crkos, 0 crkosq, d.dos cudos, d.dosq cudosq, d.kos cuko+
1s, d.kosq cukosq:n                            from accm_list_corrdocs d:n    +
1                       where d.caldt_id between l_firstdtid2 and l_lastdtid:n+
1                             and cor_type in (1, 2, 4):n                     +
1     union all:n                          select d.acc, d.dos, d.dosq, d.kos,+
1 d.kosq, 0, 0, 0, 0:n                            from accm_list_corrdocs d, a+
1ccm_calendar c:n                           where d.cordt_id = c.caldt_id:n   +
1                          and c.caldt_date between l_firstdt and l_lastdt:n  +
1                           and cor_type in (1, 2)):n                   group +
1by acc:
1UPDATE accm_agg_monbals:n               set crdos  = c.crdos,:n              +
1     crdosq = c.crdosq,:n                   crkos  = c.crkos,:n              +
1     crkosq = c.crkosq,:n                   cudos  = c.cudos,:n              +
1     cudosq = c.cudosq,:n                   cukos  = c.cukos,:n              +
1     cukosq = c.cukosq:n             where caldt_id = l_firstdtid:n          +
1     and acc      = c.acc:
1ACCOUNTS:
1INSERT into accm_agg_monbals(caldt_id, acc, rnk, ost, ostq, dos, dosq, kos, k+
1osq, :n                                             crdos, crdosq, crkos, crk+
1osq, cudos, cudosq, cukos, cukosq ):n                select l_firstdtid, acc,+
1 rnk, 0, 0, 0, 0, 0, 0,:n                       c.crdos, c.crdosq, c.crkos, c+
1.crkosq, c.cudos, c.cudosq, c.cukos, c.cukosq:n                  from account+
1s:n                 where acc = c.acc:
1%s:: month balance cr turns collected:
1UPDATE accm_state_agg:n           set agg_monbal = 'Y':n         where caldt_+
1id = l_firstdtid:
1COMMIT:
1%s:: succ end:
1CREATE_YEARBAL:
1.cryearbal:
1L_LASTDT2:
1L_LASTDTID2:
1year:
112:
1%s:: first date %s/%s (%s/%s), last date %s/%s (%s/%s):
1SELECT max(s.caldt_id) into l_baldtid:n          from accm_state_snap s:n    +
1     where s.caldt_id between l_firstdtid and l_lastdtid:n           and s.sn+
1ap_balance = 'Y':
1AGG_YEARBAL:
1UPDATE accm_state_agg:n           set agg_yearbal = 'N':n         where caldt+
1_id = l_firstdtid:
1alter table accm_agg_yearbals truncate partition for (:
1ACCM_AGG_YEARBALS:
1WSDOS:
1WSKOS:
1WCDOS:
1WCKOS:
1INSERT into accm_agg_yearbals(caldt_id, acc, rnk, ost, ostq, wsdos, wskos, wc+
1dos, wckos):n        select l_firstdtid, acc, rnk, ost, ostq, 0, 0, 0, 0:n   +
1       from accm_snap_balances b:n         where b.caldt_id = l_baldtid:
1%s:: year balance rest collected:
1NVL:
1select acc, nvl(sum(wsdos), 0) wsdos,  nvl(sum(wskos), 0) wskos, nvl(sum(wcdo+
1s), 0) wcdos, nvl(sum(wckos), 0) wckos:n                    from (select d.ac+
1c,  d.dos wsdos, d.kos wskos, 0 wcdos, 0 wckos:n                            f+
1rom accm_list_corrdocs d:n                           where d.caldt_id between+
1 l_firstdtid and l_lastdtid:n                             and cor_type = 3:n +
1                         union all:n                          select d.acc, 0+
1, 0, d.dos, d.kos:n                            from accm_list_corrdocs d, acc+
1m_calendar c:n                           where d.cordt_id = c.caldt_id:n     +
1                        and c.caldt_date between l_firstdt and l_lastdt:n    +
1                         and cor_type = 4):n                   group by acc:
1UPDATE accm_agg_yearbals:n               set wsdos  = c.wsdos,:n             +
1      wskos  = c.wskos,:n                   wcdos  = c.wcdos,:n              +
1     wckos  = c.wckos:n             where caldt_id = l_firstdtid:n           +
1    and acc      = c.acc:
1INSERT into accm_agg_yearbals(caldt_id, acc, rnk, ost, ostq, wsdos, wskos, wc+
1dos, wckos ):n                select l_firstdtid, acc, rnk, 0, 0, c.wsdos, c.+
1wskos, c.wcdos, c.wckos:n                  from accounts:n                 wh+
1ere acc = c.acc:
1%s:: year balance cr turns collected:
1UPDATE accm_state_agg:n           set agg_yearbal = 'Y':n         where caldt+
1_id = l_firstdtid:
1P_AGGDATE:
1P_AGGMODE:
1.aggmonbal:
1TYPE:
1T_LISTDATE:
1BINARY_INTEGER:
1L_LISTDATES:
1L_AGGDATE:
1L_AGGDTID:
1L_FAGGDTID:
1L_FAGGDATE:
1%s:: aggregate date %s (id is %s):
1FDAT:
1BULK:
1COLLECT:
1ACCM_QUEUE_MONBALS:
1SELECT distinct fdat bulk collect into l_listdates:n          from accm_queue+
1_monbals:n         where fdat <= l_aggdate:n        group by fdat:n        or+
1der by fdat:
1%s:: %s date(s) for refresh found:
1COUNT:
1>:
1MIN:
1SELECT min(caldt_id) into l_faggdtid :n              from accm_state_agg wher+
1e agg_monbal = 'Y':
1%s:: agg window begin at %s (by state):
1IS NULL:
1SYSDATE:
1%s:: agg window not defined, use pre-defined value %s:
1SELECT caldt_date into l_faggdate:n                  from accm_calendar:n    +
1             where caldt_id = l_faggdtid:
1%s:: agg window begin date is %s:
1%s:: use agg window at (%s, %s):
1IS NOT NULL:
1I:
1%s:: processing date %s...:
1DELETE from accm_queue_monbals:n                     where fdat = l_listdates+
1(i):
1%s:: queue record for date %s deleted.:
1>=:
1%s:: date %s processed.:
1%s:: monbal aggregate for date %s (re)created.:
1.aggyearbal:
1ACCM_QUEUE_YEARBALS:
1SELECT distinct fdat bulk collect into l_listdates:n          from accm_queue+
1_yearbals:n         where fdat <= l_aggdate:n        group by fdat:n        o+
1rder by fdat:
1SELECT min(caldt_id) into l_faggdtid :n              from accm_state_agg wher+
1e agg_yearbal = 'Y':
1DELETE from accm_queue_yearbals:n                     where fdat = l_listdate+
1s(i):
1%s:: yearbal aggregate for date %s (re)created.:
1FUNCTION:
1HEADER_VERSION:
1RETURN:
1package header BARS_ACCM_AGG :
1VERSION_HEADER:
1CHR:
110:
1package header definition(s):::
1VERSION_HEADER_DEFS:
1BODY_VERSION:
1package body BARS_ACCM_AGG :
1package body definition(s):::
0

0
0
726
2
0 :2 a0 97 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 87 :2 a0 51 a5 1c
6e 1b b0 9a 8f a0 b0 3d
b4 55 6a 87 :2 a0 51 a5 1c
a0 7e 6e b4 2e 1b b0 a3
a0 1c 81 b0 a3 a0 1c 81
b0 a3 a0 1c 81 b0 a3 a0
1c 81 b0 a3 a0 1c 81 b0
a3 a0 1c 81 b0 a3 a0 1c
81 b0 8b b0 2a :3 a0 7e 51
b4 2e b4 5d :2 a0 6b 6e :3 a0
6e a5 b a5 57 :3 a0 6e a5
b d :2 a0 6e a5 b 7e 6e
b4 2e 5a :2 a0 7e 51 b4 2e
d b7 :2 a0 d b7 :2 19 3c :3 a0
6b a0 a5 b d :3 a0 6b a0
a5 b d :4 a0 6e a5 b 51
a5 b 7e 51 b4 2e d :3 a0
6b a0 a5 b d :2 a0 6b 6e
:3 a0 6e a5 b :2 a0 6e a5 b
:2 a0 a5 b :2 a0 a5 b :2 a0 6e
a5 b :2 a0 a5 b a5 57 :c a0
12a :2 a0 6b 6e :3 a0 a5 b a5
57 :4 a0 12a a0 f 7e 51 b4
2e 5a :3 a0 12a b7 19 3c :2 a0
6e 7e :2 a0 a5 b b4 2e 7e
6e b4 2e 11e 11d b7 a0 4f
b7 a6 9 a4 b1 11 4f :2 a0
6b 6e a0 a5 57 :34 a0 12a :2 a0
6b 6e a0 a5 57 91 :4b a0 12a
37 :1e a0 12a a0 f 7e 51 b4
2e 5a :29 a0 12a b7 19 3c b7
a0 47 :2 a0 6b 6e a0 a5 57
:4 a0 12a a0 57 a0 b4 e9 :2 a0
6b 6e a0 a5 57 b7 a4 a0
b1 11 68 4f 9a 8f a0 b0
3d b4 55 6a 87 :2 a0 51 a5
1c a0 7e 6e b4 2e 1b b0
a3 a0 1c 81 b0 a3 a0 1c
81 b0 a3 a0 1c 81 b0 a3
a0 1c 81 b0 a3 a0 1c 81
b0 a3 a0 1c 81 b0 a3 a0
1c 81 b0 a3 a0 1c 81 b0
a3 a0 1c 81 b0 8b b0 2a
:3 a0 7e 51 b4 2e b4 5d :2 a0
6b 6e :3 a0 6e a5 b a5 57
:3 a0 6e a5 b d :3 a0 6b a0
a5 b d :3 a0 51 a5 b 7e
51 b4 2e d :3 a0 6b a0 a5
b d :3 a0 6e a5 b 7e 51
b4 2e d :3 a0 6b a0 a5 b
d :3 a0 51 a5 b d :3 a0 6b
a0 a5 b d :2 a0 6b 6e :3 a0
6e a5 b :2 a0 6e a5 b :2 a0
a5 b :2 a0 a5 b :2 a0 6e a5
b :2 a0 6e a5 b :2 a0 a5 b
:2 a0 a5 b a5 57 :c a0 12a :2 a0
6b 6e :3 a0 a5 b a5 57 :4 a0
12a a0 f 7e 51 b4 2e 5a
:3 a0 12a b7 19 3c :2 a0 6e 7e
:2 a0 a5 b b4 2e 7e 6e b4
2e 11e 11d b7 a0 4f b7 a6
9 a4 b1 11 4f :2 a0 6b 6e
a0 a5 57 :14 a0 12a :2 a0 6b 6e
a0 a5 57 91 :37 a0 12a 37 :12 a0
12a a0 f 7e 51 b4 2e 5a
:19 a0 12a b7 19 3c b7 a0 47
:2 a0 6b 6e a0 a5 57 :4 a0 12a
a0 57 a0 b4 e9 :2 a0 6b 6e
a0 a5 57 b7 a4 a0 b1 11
68 4f 9a 8f a0 b0 3d 8f
a0 b0 3d b4 55 6a 87 :2 a0
51 a5 1c a0 7e 6e b4 2e
1b b0 a0 9d a0 1c a0 40
a8 c 77 a3 a0 1c 81 b0
a3 a0 1c 81 b0 a3 a0 1c
81 b0 a3 a0 1c 81 b0 a3
a0 1c 81 b0 :2 a0 6b 6e :4 a0
a5 b a5 57 :3 a0 6e a5 b
d :3 a0 6b a0 a5 b d :2 a0
6b 6e :4 a0 a5 b :2 a0 a5 b
a5 57 :9 a0 12a :2 a0 6b 6e :4 a0
6b a5 b a5 57 :2 a0 6b 7e
51 b4 2e 5a :5 a0 12a :2 a0 6b
6e :3 a0 a5 b a5 57 a0 7e
b4 2e 5a :3 a0 6e a5 b d
:3 a0 6b a0 a5 b d :2 a0 6b
6e :4 a0 a5 b a5 57 b7 :5 a0
12a :2 a0 6b 6e :4 a0 a5 b a5
57 b7 :2 19 3c :2 a0 6b 6e :4 a0
a5 b :2 a0 a5 b a5 57 a0
7e b4 2e 5a 91 51 :2 a0 6b
a0 63 37 :2 a0 6b 6e :4 a0 a5
b a0 a5 b a5 57 :4 a0 12a
:2 a0 6b 6e :4 a0 a5 b a0 a5
b a5 57 :2 a0 a5 b a0 7e
b4 2e 5a :3 a0 a5 b a5 57
b7 a0 57 a0 b4 e9 b7 :2 19
3c :2 a0 6b 6e :4 a0 a5 b a0
a5 b a5 57 b7 a0 47 b7
19 3c b7 19 3c a0 7e 51
b4 2e 5a :2 a0 a5 57 :2 a0 6b
6e :4 a0 a5 b a5 57 b7 19
3c :2 a0 6b 6e a0 a5 57 b7
a4 a0 b1 11 68 4f 9a 8f
a0 b0 3d 8f a0 b0 3d b4
55 6a 87 :2 a0 51 a5 1c a0
7e 6e b4 2e 1b b0 a0 9d
a0 1c a0 40 a8 c 77 a3
a0 1c 81 b0 a3 a0 1c 81
b0 a3 a0 1c 81 b0 a3 a0
1c 81 b0 a3 a0 1c 81 b0
:2 a0 6b 6e :4 a0 a5 b a5 57
:3 a0 6e a5 b d :3 a0 6b a0
a5 b d :2 a0 6b 6e :4 a0 a5
b :2 a0 a5 b a5 57 :9 a0 12a
:2 a0 6b 6e :4 a0 6b a5 b a5
57 :2 a0 6b 7e 51 b4 2e 5a
:5 a0 12a :2 a0 6b 6e :3 a0 a5 b
a5 57 a0 7e b4 2e 5a :3 a0
6e a5 b d :3 a0 6b a0 a5
b d :2 a0 6b 6e :4 a0 a5 b
a5 57 b7 :5 a0 12a :2 a0 6b 6e
:4 a0 a5 b a5 57 b7 :2 19 3c
:2 a0 6b 6e :4 a0 a5 b :2 a0 a5
b a5 57 a0 7e b4 2e 5a
91 51 :2 a0 6b a0 63 37 :2 a0
6b 6e :4 a0 a5 b a0 a5 b
a5 57 :4 a0 12a :2 a0 6b 6e :4 a0
a5 b a0 a5 b a5 57 :2 a0
a5 b a0 7e b4 2e 5a :3 a0
a5 b a5 57 b7 a0 57 a0
b4 e9 b7 :2 19 3c :2 a0 6b 6e
:4 a0 a5 b a0 a5 b a5 57
b7 a0 47 b7 19 3c b7 19
3c a0 7e 51 b4 2e 5a :2 a0
a5 57 :2 a0 6b 6e :4 a0 a5 b
a5 57 b7 19 3c :2 a0 6b 6e
a0 a5 57 b7 a4 a0 b1 11
68 4f a0 8d a0 b4 a0 2c
6a a0 6e 7e a0 b4 2e 7e
a0 51 a5 b b4 2e 7e 6e
b4 2e 7e a0 51 a5 b b4
2e 7e a0 b4 2e 65 b7 a4
a0 b1 11 68 4f a0 8d a0
b4 a0 2c 6a a0 6e 7e a0
b4 2e 7e a0 51 a5 b b4
2e 7e 6e b4 2e 7e a0 51
a5 b b4 2e 7e a0 b4 2e
65 b7 a4 a0 b1 11 68 4f
b1 b7 a4 11 a0 b1 56 4f
1d 17 b5
726
2
0 3 7 b 36 19 1d 21
24 25 2d 32 18 5b 41 45
15 49 4a 52 57 40 80 66
6a 3d 6e 6f 77 7c 65 a5
8b 8f 62 93 94 9c a1 8a
ca b0 b4 87 b8 b9 c1 c6
af d1 ed e9 ac f5 e8 fa
fe 12d 106 10a e5 10e 10f 117
11b 11e 123 124 129 105 149 138
13c 144 102 161 150 154 15c 137
17d 16c 170 178 134 195 184 188
190 16b 1b1 1a0 1a4 1ac 168 1c9
1b8 1bc 1c4 19f 1e5 1d4 1d8 1e0
19c 1ec 1d3 1d0 1f3 1f7 1fb 1ff
202 205 206 20b 20c 20f 213 217
21a 21f 223 227 22b 230 231 233
234 239 23d 241 245 24a 24b 24d
251 255 259 25e 25f 261 264 269
26a 26f 272 276 27a 27d 280 281
286 28a 28c 290 294 298 29a 29e
2a2 2a5 2a9 2ad 2b1 2b4 2b8 2b9
2bb 2bf 2c3 2c7 2cb 2ce 2d2 2d3
2d5 2d9 2dd 2e1 2e5 2e9 2ee 2ef
2f1 2f4 2f5 2f7 2fa 2fd 2fe 303
307 30b 30f 313 316 31a 31b 31d
321 325 329 32c 331 335 339 33d
342 343 345 349 34d 352 353 355
359 35d 35e 360 364 368 369 36b
36f 373 378 379 37b 37f 383 384
386 387 38c 390 394 398 39c 3a0
3a4 3a8 3ac 3b0 3b4 3b8 3bc 3c8
3cc 3d0 3d3 3d8 3dc 3e0 3e4 3e5
3e7 3e8 3ed 3f1 3f5 3f9 3fd 409
40d 412 415 418 419 41e 421 425
429 42d 439 43b 43f 442 446 44a
44f 452 456 45a 45b 45d 45e 463
466 46b 46c 471 476 47a 47c 480
482 484 485 48a 48e 490 49c 49e
4a2 4a6 4a9 4ae 4b2 4b3 4b8 4bc
4c0 4c4 4c8 4cc 4d0 4d4 4d8 4dc
4e0 4e4 4e8 4ec 4f0 4f4 4f8 4fc
500 504 508 50c 510 514 518 51c
520 524 528 52c 530 534 538 53c
540 544 548 54c 550 554 558 55c
560 564 568 56c 570 574 578 57c
580 584 588 594 598 59c 59f 5a4
5a8 5a9 5ae 5b2 5b6 5ba 5be 5c2
5c6 5ca 5ce 5d2 5d6 5da 5de 5e2
5e6 5ea 5ee 5f2 5f6 5fa 5fe 602
606 60a 60e 612 616 61a 61e 622
626 62a 62e 632 636 63a 63e 642
646 64a 64e 652 656 65a 65e 662
666 66a 66e 672 676 67a 67e 682
686 68a 68e 692 696 69a 69e 6a2
6a6 6aa 6ae 6b2 6b6 6ba 6be 6c2
6c6 6ca 6ce 6d2 6d6 6da 6de 6ea
6ec 6f0 6f4 6f8 6fc 700 704 708
70c 710 714 718 71c 720 724 728
72c 730 734 738 73c 740 744 748
74c 750 754 758 75c 760 764 770
774 779 77c 77f 780 785 788 78c
790 794 798 79c 7a0 7a4 7a8 7ac
7b0 7b4 7b8 7bc 7c0 7c4 7c8 7cc
7d0 7d4 7d8 7dc 7e0 7e4 7e8 7ec
7f0 7f4 7f8 7fc 800 804 808 80c
810 814 818 81c 820 824 828 82c
838 83a 83e 841 843 847 84e 852
856 859 85e 862 863 868 86c 870
874 878 884 888 88d 891 892 897
89b 89f 8a2 8a7 8ab 8ac 8b1 8b3
8b7 8bb 8bd 8c9 8cd 8cf 8eb 8e7
8e6 8f3 8e3 8f8 8fc 92e 904 908
90c 90f 910 918 91c 91f 924 925
92a 903 94a 939 93d 945 900 962
951 955 95d 938 97e 96d 971 979
935 996 985 989 991 96c 9b2 9a1
9a5 9ad 969 9ca 9b9 9bd 9c5 9a0
9e6 9d5 9d9 9e1 99d 9fe 9ed 9f1
9f9 9d4 a1a a09 a0d a15 9d1 a21
a08 a05 a28 a2c a30 a34 a37 a3a
a3b a40 a41 a44 a48 a4c a4f a54
a58 a5c a60 a65 a66 a68 a69 a6e
a72 a76 a7a a7f a80 a82 a86 a8a
a8e a92 a95 a99 a9a a9c aa0 aa4
aa8 aac aaf ab0 ab2 ab5 ab8 ab9
abe ac2 ac6 aca ace ad1 ad5 ad6
ad8 adc ae0 ae4 ae8 aed aee af0
af3 af6 af7 afc b00 b04 b08 b0c
b0f b13 b14 b16 b1a b1e b22 b26
b29 b2a b2c b30 b34 b38 b3c b3f
b43 b44 b46 b4a b4e b52 b55 b5a
b5e b62 b66 b6b b6c b6e b72 b76
b7b b7c b7e b82 b86 b87 b89 b8d
b91 b92 b94 b98 b9c ba1 ba2 ba4
ba8 bac bb1 bb2 bb4 bb8 bbc bbd
bbf bc3 bc7 bc8 bca bcb bd0 bd4
bd8 bdc be0 be4 be8 bec bf0 bf4
bf8 bfc c00 c0c c10 c14 c17 c1c
c20 c24 c28 c29 c2b c2c c31 c35
c39 c3d c41 c4d c51 c56 c59 c5c
c5d c62 c65 c69 c6d c71 c7d c7f
c83 c86 c8a c8e c93 c96 c9a c9e
c9f ca1 ca2 ca7 caa caf cb0 cb5
cba cbe cc0 cc4 cc6 cc8 cc9 cce
cd2 cd4 ce0 ce2 ce6 cea ced cf2
cf6 cf7 cfc d00 d04 d08 d0c d10
d14 d18 d1c d20 d24 d28 d2c d30
d34 d38 d3c d40 d44 d48 d4c d58
d5c d60 d63 d68 d6c d6d d72 d76
d7a d7e d82 d86 d8a d8e d92 d96
d9a d9e da2 da6 daa dae db2 db6
dba dbe dc2 dc6 dca dce dd2 dd6
dda dde de2 de6 dea dee df2 df6
dfa dfe e02 e06 e0a e0e e12 e16
e1a e1e e22 e26 e2a e2e e32 e36
e3a e3e e42 e46 e4a e4e e52 e5e
e60 e64 e68 e6c e70 e74 e78 e7c
e80 e84 e88 e8c e90 e94 e98 e9c
ea0 ea4 ea8 eb4 eb8 ebd ec0 ec3
ec4 ec9 ecc ed0 ed4 ed8 edc ee0
ee4 ee8 eec ef0 ef4 ef8 efc f00
f04 f08 f0c f10 f14 f18 f1c f20
f24 f28 f2c f30 f3c f3e f42 f45
f47 f4b f52 f56 f5a f5d f62 f66
f67 f6c f70 f74 f78 f7c f88 f8c
f91 f95 f96 f9b f9f fa3 fa6 fab
faf fb0 fb5 fb7 fbb fbf fc1 fcd
fd1 fd3 fef feb fea ff7 1004 1000
fe7 100c fff 1011 1015 1044 101d 1021
ffc 1025 1026 102e 1032 1035 103a 103b
1040 101c 104b 1069 1053 1057 105f 1019
1063 1064 104f 1085 1074 1078 1080 1073
10a1 1090 1094 109c 1070 10b9 10a8 10ac
10b4 108f 10d5 10c4 10c8 10d0 108c 10ed
10dc 10e0 10e8 10c3 10f4 10f8 10c0 10fc
1101 1105 1109 110d 1111 1112 1114 1115
111a 111e 1122 1126 112b 112c 112e 1132
1136 113a 113e 1141 1145 1146 1148 114c
1150 1154 1157 115c 1160 1164 1168 116c
116d 116f 1173 1177 1178 117a 117b 1180
1184 1188 118c 1190 1194 1198 119c 11a0
11a4 11b0 11b4 11b8 11bb 11c0 11c4 11c8
11cc 11d0 11d3 11d4 11d6 11d7 11dc 11e0
11e4 11e7 11ea 11ed 11ee 11f3 11f6 11fa
11fe 1202 1206 120a 1216 121a 121e 1221
1226 122a 122e 1232 1233 1235 1236 123b
123f 1242 1243 1248 124b 124f 1253 1257
125c 125d 125f 1263 1267 126b 126f 1272
1276 1277 1279 127d 1281 1285 1288 128d
1291 1295 1299 129d 129e 12a0 12a1 12a6
12a8 12ac 12b0 12b4 12b8 12bc 12c8 12cc
12d0 12d3 12d8 12dc 12e0 12e4 12e8 12e9
12eb 12ec 12f1 12f3 12f7 12fb 12fe 1302
1306 1309 130e 1312 1316 131a 131e 131f
1321 1325 1329 132a 132c 132d 1332 1336
1339 133a 133f 1342 1346 1349 134d 1351
1354 1358 135c 135e 1362 1366 1369 136e
1372 1376 137a 137e 137f 1381 1385 1386
1388 1389 138e 1392 1396 139a 139e 13aa
13ae 13b2 13b5 13ba 13be 13c2 13c6 13ca
13cb 13cd 13d1 13d2 13d4 13d5 13da 13de
13e2 13e3 13e5 13e9 13ec 13ed 13f2 13f5
13f9 13fd 1401 1402 1404 1405 140a 140c
1410 1415 1419 141a 141f 1421 1425 1429
142c 1430 1434 1437 143c 1440 1444 1448
144c 144d 144f 1453 1454 1456 1457 145c
145e 1462 1469 146b 146f 1472 1474 1478
147b 147f 1482 1485 1486 148b 148e 1492
1496 1497 149c 14a0 14a4 14a7 14ac 14b0
14b4 14b8 14bc 14bd 14bf 14c0 14c5 14c7
14cb 14ce 14d2 14d6 14d9 14de 14e2 14e3
14e8 14ea 14ee 14f2 14f4 1500 1504 1506
1522 151e 151d 152a 1537 1533 151a 153f
1532 1544 1548 1577 1550 1554 152f 1558
1559 1561 1565 1568 156d 156e 1573 154f
157e 159c 1586 158a 1592 154c 1596 1597
1582 15b8 15a7 15ab 15b3 15a6 15d4 15c3
15c7 15cf 15a3 15ec 15db 15df 15e7 15c2
1608 15f7 15fb 1603 15bf 1620 160f 1613
161b 15f6 1627 162b 15f3 162f 1634 1638
163c 1640 1644 1645 1647 1648 164d 1651
1655 1659 165e 165f 1661 1665 1669 166d
1671 1674 1678 1679 167b 167f 1683 1687
168a 168f 1693 1697 169b 169f 16a0 16a2
16a6 16aa 16ab 16ad 16ae 16b3 16b7 16bb
16bf 16c3 16c7 16cb 16cf 16d3 16d7 16e3
16e7 16eb 16ee 16f3 16f7 16fb 16ff 1703
1706 1707 1709 170a 170f 1713 1717 171a
171d 1720 1721 1726 1729 172d 1731 1735
1739 173d 1749 174d 1751 1754 1759 175d
1761 1765 1766 1768 1769 176e 1772 1775
1776 177b 177e 1782 1786 178a 178f 1790
1792 1796 179a 179e 17a2 17a5 17a9 17aa
17ac 17b0 17b4 17b8 17bb 17c0 17c4 17c8
17cc 17d0 17d1 17d3 17d4 17d9 17db 17df
17e3 17e7 17eb 17ef 17fb 17ff 1803 1806
180b 180f 1813 1817 181b 181c 181e 181f
1824 1826 182a 182e 1831 1835 1839 183c
1841 1845 1849 184d 1851 1852 1854 1858
185c 185d 185f 1860 1865 1869 186c 186d
1872 1875 1879 187c 1880 1884 1887 188b
188f 1891 1895 1899 189c 18a1 18a5 18a9
18ad 18b1 18b2 18b4 18b8 18b9 18bb 18bc
18c1 18c5 18c9 18cd 18d1 18dd 18e1 18e5
18e8 18ed 18f1 18f5 18f9 18fd 18fe 1900
1904 1905 1907 1908 190d 1911 1915 1916
1918 191c 191f 1920 1925 1928 192c 1930
1934 1935 1937 1938 193d 193f 1943 1948
194c 194d 1952 1954 1958 195c 195f 1963
1967 196a 196f 1973 1977 197b 197f 1980
1982 1986 1987 1989 198a 198f 1991 1995
199c 199e 19a2 19a5 19a7 19ab 19ae 19b2
19b5 19b8 19b9 19be 19c1 19c5 19c9 19ca
19cf 19d3 19d7 19da 19df 19e3 19e7 19eb
19ef 19f0 19f2 19f3 19f8 19fa 19fe 1a01
1a05 1a09 1a0c 1a11 1a15 1a16 1a1b 1a1d
1a21 1a25 1a27 1a33 1a37 1a39 1a3d 1a51
1a55 1a56 1a5a 1a5e 1a62 1a66 1a6b 1a6e
1a72 1a73 1a78 1a7b 1a7f 1a82 1a83 1a85
1a86 1a8b 1a8e 1a93 1a94 1a99 1a9c 1aa0
1aa3 1aa4 1aa6 1aa7 1aac 1aaf 1ab3 1ab4
1ab9 1abd 1abf 1ac3 1ac7 1ac9 1ad5 1ad9
1adb 1adf 1af3 1af7 1af8 1afc 1b00 1b04
1b08 1b0d 1b10 1b14 1b15 1b1a 1b1d 1b21
1b24 1b25 1b27 1b28 1b2d 1b30 1b35 1b36
1b3b 1b3e 1b42 1b45 1b46 1b48 1b49 1b4e
1b51 1b55 1b56 1b5b 1b5f 1b61 1b65 1b69
1b6b 1b77 1b7b 1b7d 1b7f 1b81 1b85 1b91
1b95 1b97 1b9a 1b9c 1b9d 1ba6
726
2
0 1 9 e 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 :2 5 18 21 2a
29 21 32 18 5 f 13 20
:2 13 1c :3 5 16 1f 28 27 1f
30 39 3c :2 30 16 :2 5 :3 12 :2 5
:3 12 :2 5 :3 12 :2 5 :3 12 :2 5 :3 12 :2 5
:3 12 :2 5 :3 12 :5 5 c 1b :4 2c :2 5
9 :2 14 1a 38 3b 43 4e :2 3b
:3 9 18 1e 29 :2 18 9 d 15
20 :2 d 28 2a :2 28 c 37 45
4f 50 :2 45 37 32 e 1c e
:5 9 19 :2 2c 3c :2 19 :2 9 19 :2 2c
3c :2 19 :2 9 18 23 29 34 :2 23
3c :2 18 3f 40 :2 18 :2 9 18 :2 2b
3b :2 18 :2 9 :2 14 1a 4d 1c 24
2f :2 1c 3e 46 52 :2 3e 1c 24
:2 1c 32 3a :2 32 49 51 5b :2 49
6a 72 :2 6a :2 9 10 14 16 25
10 20 10 12 23 34 10 12
:2 9 :2 14 1a 39 3c 44 :2 3c :2 9
:3 10 1b 9 11 d 1a 1c :2 1a
c 19 28 3a d 1f :2 9 d
15 1f 57 5a 62 :2 5a :2 1f 6f
72 :2 1f :2 d 9 12 27 22 :2 d
9 :3 5 9 :2 14 1a 3a :2 9 15
26 30 35 3a 3f 45 4a 50
55 5b 62 6a 71 79 80 88
8f 10 1d 10 14 18 1f 29
34 3a 10 14 1b 25 30 10
14 1b 25 30 10 14 1a 1e
25 29 2f 33 10 23 10 12
23 34 12 :2 9 :2 14 1a 48 :2 9
d 1a 1f 23 2a 32 36 3e
46 4a 51 58 5c 64 1a 1e
25 2d 31 39 41 45 4c 53
57 5f 22 24 2b 34 3e 47
4f 51 55 5c 5e 63 6b 6d
71 78 7a 7f 22 35 22 24
35 46 :2 22 24 29 2b 30 32
38 3a 3f 41 22 35 38 46
22 24 2f 31 22 24 37 45
22 1d 9 12 9 :2 14 1d 1f
14 1d 1f 14 1d 1f 14 1d
1f 14 1d 1f 14 1d 1f 14
1d 1f 14 1d 1f 14 1f 14
1f 21 d 15 11 1e 20 :2 1e
10 1d 2e 38 3d 42 47 4d
52 58 5d 2e 35 3d 44 4c
53 5b 62 18 25 2a 18 1a
21 23 2b 2d 34 36 3e 40
47 49 51 53 5a 5c :2 18 1e
20 11 23 :2 d 9 d :2 9 :2 14
1a 42 :2 9 :3 10 1b :7 9 :2 14 1a
2a :2 9 :2 5 9 :4 5 f 13 20
:2 13 1d :3 5 16 1f 28 27 1f
30 39 3c :2 30 16 :2 5 :3 12 :2 5
:3 12 :2 5 :3 12 :2 5 :3 12 :2 5 :3 12 :2 5
:3 12 :2 5 :3 12 :2 5 :3 12 :2 5 :3 12 :5 5
c 1b :4 2c :2 5 9 :2 14 1a 38
3b 43 4e :2 3b :3 9 18 1e 29
:2 18 :2 9 18 :2 2b 3b :2 18 :2 9 18
23 2e :2 18 32 33 :2 18 :2 9 18
:2 2b 3b :2 18 :2 9 19 1f 2a :2 19
32 34 :2 19 :2 9 19 :2 2c 3c :2 19
:2 9 19 24 2f :2 19 :2 9 19 :2 2c
3c :2 19 :2 9 :2 14 1a 53 1c 24
2f :2 1c 3e 46 52 :2 3e 1c 24
:2 1c 32 3a :2 32 1c 24 2e :2 1c
3d 45 50 :2 3d 1c 24 :2 1c 31
39 :2 31 :2 9 10 14 16 25 10
20 10 12 23 33 10 12 :2 9
:2 14 1a 39 3c 44 :2 3c :2 9 :3 10
1b 9 11 d 1a 1c :2 1a c
19 28 3a d 1f :2 9 d 15
1f 58 5b 63 :2 5b :2 1f 70 73
:2 1f :2 d 9 12 27 22 :2 d 9
:3 5 9 :2 14 1a 3a :2 9 15 27
31 36 3b 40 46 4d 54 5b
10 1d 22 27 2c 10 23 10
12 1d :2 9 :2 14 1a 3d :2 9 d
1a 1f 23 27 32 3a 3e 42
4d 54 58 5c 67 6e 72 76
81 22 24 2a 2c 30 37 39
3d 46 4f 22 35 22 24 35
45 :2 22 24 2f 31 36 38 22
35 38 46 22 24 2f 31 22
24 37 45 22 1d 9 12 9
:2 14 1d 1f 14 1d 1f 14 1d
1f 14 1d 1f 14 1f 14 1f
21 d 15 11 1e 20 :2 1e 10
1d 2f 39 3e 43 48 4e 55
5c 63 18 25 2a 35 37 3e
40 47 49 50 52 :2 18 1e 20
11 23 :2 d 9 d :2 9 :2 14 1a
41 :2 9 :3 10 1b :7 9 :2 14 1a 2a
:2 9 :2 5 9 :4 5 f 13 20 :3 13
20 :2 13 19 :3 5 16 1f 28 27
1f 30 39 3c :2 30 16 :2 5 a
:2 21 :4 18 :2 5 :3 15 :2 5 :3 15 :2 5 :3 15
:2 5 :3 15 :2 5 :3 16 5 9 :2 14 1a
38 3b 43 4e :2 3b :3 9 16 1c
27 :2 16 :2 9 16 :2 29 39 :2 16 :2 9
:2 14 1a 3e 41 49 54 :2 41 5f
67 :2 5f :2 9 19 1e 23 30 :2 10
18 :2 12 :2 9 :2 14 1a 3e 41 49
:2 55 :2 41 :2 9 d :2 19 1f 21 :2 1f
c 14 18 27 14 29 :2 d :2 18
1e 47 4a 52 :2 4a :2 d :4 11 10
11 1f 25 2e :2 1f :2 11 1f :2 32
42 :2 1f :2 11 :2 1c 22 5a 5d 65
71 :2 5d :2 11 25 18 28 :2 18 23
:2 11 :2 1c 22 45 48 50 5c :2 48
:2 11 :5 d :2 18 1e 40 43 4b 57
:2 43 62 6a :2 62 :2 d :4 11 10 15
1a 1d :2 29 11 1a 11 15 :2 20
26 43 46 4e 5a :2 4e 5e :2 46
:2 15 21 1c 23 2f :2 15 :2 20 26
4f 52 5a 66 :2 5a 6a :2 52 :2 15
19 25 :2 19 2b :3 28 18 19 27
33 :2 27 :2 19 37 :5 19 :5 15 :2 20 26
40 43 4b 57 :2 4b 5b :2 43 :2 15
11 15 11 29 :2 d 24 :2 9 d
17 19 :2 17 c d 1b :3 d :2 18
1e 4f 52 5a 65 :2 52 :2 d 1c
:3 9 :2 14 1a 2a :2 9 :2 5 9 :4 5
f 13 20 :3 13 20 :2 13 1a :3 5
16 1f 28 27 1f 30 39 3c
:2 30 16 :2 5 a :2 21 :4 18 :2 5 :3 15
:2 5 :3 15 :2 5 :3 15 :2 5 :3 15 :2 5 :3 16
5 9 :2 14 1a 38 3b 43 4e
:2 3b :3 9 16 1c 27 :2 16 :2 9 16
:2 29 39 :2 16 :2 9 :2 14 1a 3e 41
49 54 :2 41 5f 67 :2 5f :2 9 19
1e 23 30 :2 10 18 :2 12 :2 9 :2 14
1a 3e 41 49 :2 55 :2 41 :2 9 d
:2 19 1f 21 :2 1f c 14 18 27
14 29 :2 d :2 18 1e 47 4a 52
:2 4a :2 d :4 11 10 11 1f 25 2e
:2 1f :2 11 1f :2 32 42 :2 1f :2 11 :2 1c
22 5a 5d 65 71 :2 5d :2 11 25
18 28 :2 18 23 :2 11 :2 1c 22 45
48 50 5c :2 48 :2 11 :5 d :2 18 1e
40 43 4b 57 :2 43 62 6a :2 62
:2 d :4 11 10 15 1a 1d :2 29 11
1a 11 15 :2 20 26 43 46 4e
5a :2 4e 5e :2 46 :2 15 21 1c 23
2f :2 15 :2 20 26 4f 52 5a 66
:2 5a 6a :2 52 :2 15 19 25 :2 19 2b
:3 28 18 19 28 34 :2 28 :2 19 37
:5 19 :5 15 :2 20 26 40 43 4b 57
:2 4b 5b :2 43 :2 15 11 15 11 29
:2 d 24 :2 9 d 17 19 :2 17 c
d 1c :3 d :2 18 1e 50 53 5b
66 :2 53 :2 d 1c :3 9 :2 14 1a 2a
:2 9 :2 5 9 :5 5 e 1d 0 24
:2 5 9 10 30 33 :2 10 42 45
49 :2 45 :2 10 4d :3 10 30 33 37
:2 33 :2 10 3b 3e :2 10 9 :2 5 9
:5 5 e 1b 0 22 :2 5 9 10
2e 31 :2 10 3e 41 45 :2 41 :2 10
49 :3 10 2e 31 35 :2 31 :2 10 39
3c :2 10 9 :2 5 9 :9 5 :6 1
726
4
0 :3 1 :9 16 :9 17
:9 1a :9 1d :9 20 2e
:4 2f :3 2e :d 31 :5 33
:5 34 :5 35 :5 36 :5 37
:5 38 :5 39 :3 3b :9 3c
:c 3f :7 42 :12 45 :4 46
:3 45 :8 49 :8 4a :f 4b
:8 4c :5 4d :a 4e :11 4f
:2 4d :4 52 :2 53 :4 54
:2 55 52 :b 56 59
5a :2 5b 59 :7 5d
:4 5e :3 5d :10 63 62
:5 65 64 :3 3e :7 67
:12 6a :2 6b :7 6c :5 6d
:5 6e :8 6f :2 71 :4 72
73 6a :7 74 :e 77
:c 78 :12 79 :2 7a :4 7b
7c :a 7e :4 7f :4 80
:4 81 82 83 84
:2 77 85 :3 86 :3 87
:3 88 :3 89 :3 8a :3 8b
:3 8c :3 8d :2 8e :3 8f
85 :7 91 :a 92 :8 93
:3 94 :10 95 96 :3 97
92 :3 91 84 9a
77 :7 9b 9e 9f
:2 a0 9e :5 a1 :7 a2
:2 3e a4 :4 2e b0
:4 b1 :3 b0 :d b3 :5 b5
:5 b6 :5 b7 :5 b8 :5 b9
:5 bb :5 bc :5 bd :5 be
:3 c0 :9 c1 :c c4 :7 c8
:8 c9 :b ca :8 cb :b cd
:8 ce :7 cf :8 d0 :5 d2
:a d3 :8 d4 :a d5 :8 d6
:2 d2 :4 d9 :2 da :4 db
:2 dc d9 :b dd e0
e1 :2 e2 e0 :7 e4
:4 e5 :3 e4 :10 ea e9
:5 ec eb :3 c3 :7 ee
:a f1 :5 f2 :2 f3 :3 f4
f1 :7 f5 :12 f8 :a f9
:2 fa :4 fb fc :6 fe
:4 ff :4 100 :4 101 102
103 104 :2 f8 105
:3 106 :3 107 :3 108 :3 109
:2 10a :3 10b 105 :7 10d
:a 10e :b 10f 110 :3 111
10e :3 10d 104 114
f8 :7 115 118 119
:2 11a 118 :5 11b :7 11c
:2 c3 11e :4 b0 12a
:4 12b :4 12c :3 12a :d 12e
:9 130 :5 132 :5 133 :5 134
:5 135 :5 136 :c 139 :7 13c
:8 13d :10 13e :4 141 142
:2 143 144 145 141
:d 146 :8 148 :3 14b :2 14c
14b :b 14d :5 153 :7 154
:8 155 :c 156 153 :2 159
15a :2 15b 159 :c 15c
157 :3 153 :10 15e :5 161
:5 164 165 :2 164 :f 166
169 :3 16a 169 :f 16b
:9 16e :7 16f 16e :5 171
170 :3 16e :f 173 165
174 164 :3 161 :3 148
:6 17b :4 17c :c 17d :3 17b
:7 17f :2 138 181 :4 12a
18b :4 18c :4 18d :3 18b
:d 18f :9 191 :5 193 :5 194
:5 195 :5 196 :5 197 :c 19a
:7 19d :8 19e :10 19f :4 1a2
1a3 :2 1a4 1a5 1a6
1a2 :d 1a7 :8 1a9 :3 1ac
:2 1ad 1ac :b 1ae :5 1b4
:7 1b5 :8 1b6 :c 1b7 1b4
:2 1ba 1bb :2 1bc 1ba
:c 1bd 1b8 :3 1b4 :10 1bf
:5 1c2 :5 1c5 1c6 :2 1c5
:f 1c7 1ca :3 1cb 1ca
:f 1cc :9 1cf :7 1d0 1cf
:5 1d2 1d1 :3 1cf :f 1d4
1c6 1d5 1c5 :3 1c2
:3 1a9 :6 1dc :4 1dd :c 1de
:3 1dc :7 1e0 :2 199 1e2
:4 18b :3 1f3 0 :3 1f3
:e 1f6 1f7 :2 1f6 :5 1f7
:2 1f6 :2 1f7 :3 1f6 :2 1f5
1f8 :4 1f3 :3 202 0
:3 202 :e 205 206 :2 205
:5 206 :2 205 :2 206 :3 205
:2 204 207 :4 202 :4 2e
20a :6 1
1ba8
4
:3 0 1 :3 0 2
:3 0 3 :6 0 1
:2 0 a :2 0 :2 5
:3 0 6 :3 0 7
:2 0 3 6 8
:6 0 8 :4 0 c
9 a 720 4
:6 0 d :2 0 9
5 :3 0 6 :3 0
7 f 11 :6 0
b :4 0 15 12
13 720 9 :6 0
10 :2 0 d 5
:3 0 6 :3 0 b
18 1a :6 0 e
:4 0 1e 1b 1c
720 c :6 0 13
:2 0 11 5 :3 0
6 :3 0 f 21
23 :6 0 11 :4 0
27 24 25 720
f :6 0 17 e5
0 15 5 :3 0
6 :3 0 13 2a
2c :6 0 14 :4 0
30 2d 2e 720
12 :6 0 15 :a 0
233 2 :7 0 10
:2 0 19 17 :3 0
16 :7 0 34 33
:3 0 36 :2 0 233
31 37 :2 0 22
134 0 20 5
:3 0 6 :3 0 1b
3b 3d :6 0 f
:3 0 19 :2 0 1a
:4 0 1d 40 42
:3 0 45 3e 43
231 18 :6 0 26
168 0 24 17
:3 0 47 :7 0 4a
48 0 231 0
1b :6 0 1d :3 0
4c :7 0 4f 4d
0 231 0 1c
:6 0 2a 19c 0
28 17 :3 0 51
:7 0 54 52 0
231 0 1e :6 0
1d :3 0 56 :7 0
59 57 0 231
0 1f :6 0 2e
1d0 0 2c 1d
:3 0 5b :7 0 5e
5c 0 231 0
20 :6 0 17 :3 0
60 :7 0 63 61
0 231 0 21
:6 0 6a 0 231
30 1d :3 0 65
:7 0 68 66 0
231 0 22 :6 0
23 :6 0 24 :3 0
25 :3 0 23 69
:2 0 26 :2 0 27
:2 0 32 6f 71
:3 0 34 6d 73
231 28 :3 0 29
:3 0 75 76 0
2a :4 0 18 :3 0
2b :3 0 16 :3 0
14 :4 0 37 7a
7d 3a 77 7f
:2 0 22e 1b :3 0
2c :3 0 16 :3 0
2d :4 0 3e 82
85 81 86 0
22e 2b :3 0 1b
:3 0 2e :4 0 41
88 8b 2f :2 0
30 :4 0 46 8d
8f :3 0 90 :2 0
21 :3 0 1b :3 0
31 :2 0 32 :2 0
49 94 96 :3 0
92 97 0 99
4c 9e 21 :3 0
1b :3 0 9a 9b
0 9d 4e 9f
91 99 0 a0
0 9d 0 a0
50 0 22e 1c
:3 0 33 :3 0 34
:3 0 a2 a3 0
1b :3 0 53 a4
a6 a1 a7 0
22e 22 :3 0 33
:3 0 34 :3 0 aa
ab 0 21 :3 0
55 ac ae a9
af 0 22e 1e
:3 0 35 :3 0 2c
:3 0 1b :3 0 2d
:4 0 57 b3 b6
32 :2 0 5a b2
b9 26 :2 0 32
:2 0 5d bb bd
:3 0 b1 be 0
22e 1f :3 0 33
:3 0 34 :3 0 c1
c2 0 1e :3 0
60 c3 c5 c0
c6 0 22e 28
:3 0 29 :3 0 c8
c9 0 36 :4 0
18 :3 0 2b :3 0
1b :3 0 14 :4 0
62 cd d0 2b
:3 0 21 :3 0 14
:4 0 65 d2 d5
2b :3 0 1c :3 0
68 d7 d9 2b
:3 0 22 :3 0 6a
db dd 2b :3 0
1e :3 0 14 :4 0
6c df e2 2b
:3 0 1f :3 0 6f
e4 e6 71 ca
e8 :2 0 22e 37
:3 0 38 :3 0 39
:3 0 20 :3 0 3a
:3 0 38 :3 0 38
:3 0 39 :3 0 22
:3 0 1f :3 0 38
:3 0 3b :4 0 3c
1 :8 0 22e 28
:3 0 29 :3 0 f7
f8 0 3d :4 0
18 :3 0 2b :3 0
20 :3 0 7a fc
fe 7c f9 100
:2 0 22e 3e :3 0
3f :3 0 39 :3 0
1c :4 0 40 1
:8 0 22e 41 :4 0
107 :3 0 2f :2 0
42 :2 0 82 109
10b :3 0 10c :2 0
3e :3 0 39 :3 0
1c :4 0 43 1
:8 0 112 85 113
10d 112 0 114
87 0 22e 44
:3 0 45 :3 0 46
:4 0 19 :2 0 2b
:3 0 1c :3 0 89
119 11b 8b 118
11d :3 0 19 :2 0
47 :4 0 8e 11f
121 :3 0 122 :4 0
123 :2 0 125 91
12d 23 :4 0 128
93 12a 95 129
128 :2 0 12b 97
:2 0 12d 0 12d
12c 125 12b :6 0
22e 2 :3 0 28
:3 0 29 :3 0 12f
130 0 48 :4 0
18 :3 0 99 131
134 :2 0 22e 49
:3 0 39 :3 0 4a
:3 0 4b :3 0 4c
:3 0 4d :3 0 4e
:3 0 4f :3 0 50
:3 0 51 :3 0 52
:3 0 53 :3 0 54
:3 0 55 :3 0 56
:3 0 57 :3 0 58
:3 0 59 :3 0 1c
:3 0 4a :3 0 5a
:3 0 37 :3 0 5b
:3 0 39 :3 0 20
:3 0 4b :3 0 4b
:3 0 5c :3 0 5b
:3 0 39 :3 0 20
:3 0 4c :3 0 5c
:3 0 5b :3 0 39
:3 0 20 :3 0 4d
:3 0 5c :3 0 4e
:3 0 5c :3 0 4f
:3 0 5c :3 0 50
:3 0 5c :3 0 51
:3 0 5d :3 0 5e
:3 0 5e :3 0 39
:3 0 22 :3 0 1f
:3 0 4a :4 0 5f
1 :8 0 22e 28
:3 0 29 :3 0 16b
16c 0 60 :4 0
18 :3 0 9c 16d
170 :2 0 22e 61
:3 0 4a :3 0 5c
:3 0 52 :3 0 52
:3 0 5c :3 0 53
:3 0 53 :3 0 5c
:3 0 54 :3 0 54
:3 0 5c :3 0 55
:3 0 55 :3 0 5c
:3 0 56 :3 0 56
:3 0 5c :3 0 57
:3 0 57 :3 0 5c
:3 0 58 :3 0 58
:3 0 5c :3 0 59
:3 0 59 :3 0 62
:3 0 4a :3 0 52
:3 0 53 :3 0 54
:3 0 55 :3 0 62
:3 0 4e :3 0 56
:3 0 62 :3 0 4f
:3 0 57 :3 0 62
:3 0 50 :3 0 58
:3 0 62 :3 0 51
:3 0 59 :3 0 63
:3 0 62 :3 0 62
:3 0 39 :3 0 22
:3 0 1f :3 0 64
:3 0 62 :3 0 4a
:3 0 62 :3 0 4e
:3 0 62 :3 0 4f
:3 0 62 :3 0 50
:3 0 62 :3 0 51
:3 0 63 :3 0 62
:3 0 65 :3 0 61
:3 0 62 :3 0 66
:3 0 61 :3 0 39
:3 0 61 :3 0 67
:3 0 1b :3 0 1e
:3 0 64 :3 0 4a
:3 0 68 :4 0 69
1 :8 0 1bf 172
1be 49 :3 0 52
:3 0 61 :3 0 52
:3 0 53 :3 0 61
:3 0 53 :3 0 54
:3 0 61 :3 0 54
:3 0 55 :3 0 61
:3 0 55 :3 0 56
:3 0 61 :3 0 56
:3 0 57 :3 0 61
:3 0 57 :3 0 58
:3 0 61 :3 0 58
:3 0 59 :3 0 61
:3 0 59 :3 0 39
:3 0 1c :3 0 4a
:3 0 61 :3 0 4a
:4 0 6a 1 :8 0
213 41 :4 0 1df
:3 0 2f :2 0 42
:2 0 a1 1e1 1e3
:3 0 1e4 :2 0 49
:3 0 39 :3 0 4a
:3 0 4b :3 0 4c
:3 0 4d :3 0 4e
:3 0 4f :3 0 50
:3 0 51 :3 0 52
:3 0 53 :3 0 54
:3 0 55 :3 0 56
:3 0 57 :3 0 58
:3 0 59 :3 0 1c
:3 0 4a :3 0 4b
:3 0 61 :3 0 52
:3 0 61 :3 0 53
:3 0 61 :3 0 54
:3 0 61 :3 0 55
:3 0 61 :3 0 56
:3 0 61 :3 0 57
:3 0 61 :3 0 58
:3 0 61 :3 0 59
:3 0 6b :3 0 4a
:3 0 61 :3 0 4a
:4 0 6c 1 :8 0
210 a4 211 1e5
210 0 212 a6
0 213 a8 215
68 :3 0 1bf 213
:4 0 22e 28 :3 0
29 :3 0 216 217
0 6d :4 0 18
:3 0 ab 218 21b
:2 0 22e 3e :3 0
3f :3 0 39 :3 0
1c :4 0 6e 1
:8 0 22e 6f :3 0
224 225 :2 0 226
6f :5 0 223 :2 0
22e 28 :3 0 29
:3 0 227 228 0
70 :4 0 18 :3 0
ae 229 22c :2 0
22e b1 232 :3 0
232 15 :3 0 c7
232 231 22e 22f
:6 0 233 1 0
31 37 232 720
:2 0 71 :a 0 3f7
5 :7 0 d4 :2 0
d2 17 :3 0 16
:7 0 238 237 :3 0
23a :2 0 3f7 235
23b :2 0 dd 935
0 db 5 :3 0
6 :3 0 10 :2 0
d6 23f 241 :6 0
f :3 0 19 :2 0
72 :4 0 d8 244
246 :3 0 249 242
247 3f5 18 :6 0
e1 969 0 df
17 :3 0 24b :7 0
24e 24c 0 3f5
0 1b :6 0 1d
:3 0 250 :7 0 253
251 0 3f5 0
1c :6 0 e5 99d
0 e3 17 :3 0
255 :7 0 258 256
0 3f5 0 1e
:6 0 1d :3 0 25a
:7 0 25d 25b 0
3f5 0 1f :6 0
e9 9d1 0 e7
1d :3 0 25f :7 0
262 260 0 3f5
0 20 :6 0 17
:3 0 264 :7 0 267
265 0 3f5 0
21 :6 0 ed a05
0 eb 1d :3 0
269 :7 0 26c 26a
0 3f5 0 22
:6 0 17 :3 0 26e
:7 0 271 26f 0
3f5 0 73 :6 0
278 0 3f5 ef
1d :3 0 273 :7 0
276 274 0 3f5
0 74 :6 0 23
:6 0 24 :3 0 25
:3 0 23 277 :2 0
26 :2 0 27 :2 0
f1 27d 27f :3 0
f3 27b 281 3f5
28 :3 0 29 :3 0
283 284 0 2a
:4 0 18 :3 0 2b
:3 0 16 :3 0 14
:4 0 f6 288 28b
f9 285 28d :2 0
3f2 1b :3 0 2c
:3 0 16 :3 0 75
:4 0 fd 290 293
28f 294 0 3f2
1c :3 0 33 :3 0
34 :3 0 297 298
0 1b :3 0 100
299 29b 296 29c
0 3f2 1e :3 0
35 :3 0 1b :3 0
76 :2 0 102 29f
2a2 26 :2 0 32
:2 0 105 2a4 2a6
:3 0 29e 2a7 0
3f2 1f :3 0 33
:3 0 34 :3 0 2aa
2ab 0 1e :3 0
108 2ac 2ae 2a9
2af 0 3f2 21
:3 0 2c :3 0 16
:3 0 75 :4 0 10a
2b2 2b5 31 :2 0
32 :2 0 10d 2b7
2b9 :3 0 2b1 2ba
0 3f2 22 :3 0
33 :3 0 34 :3 0
2bd 2be 0 21
:3 0 110 2bf 2c1
2bc 2c2 0 3f2
73 :3 0 35 :3 0
1b :3 0 76 :2 0
112 2c5 2c8 2c4
2c9 0 3f2 74
:3 0 33 :3 0 34
:3 0 2cc 2cd 0
73 :3 0 115 2ce
2d0 2cb 2d1 0
3f2 28 :3 0 29
:3 0 2d3 2d4 0
77 :4 0 18 :3 0
2b :3 0 1b :3 0
14 :4 0 117 2d8
2db 2b :3 0 21
:3 0 14 :4 0 11a
2dd 2e0 2b :3 0
1c :3 0 11d 2e2
2e4 2b :3 0 22
:3 0 11f 2e6 2e8
2b :3 0 1e :3 0
14 :4 0 121 2ea
2ed 2b :3 0 73
:3 0 14 :4 0 124
2ef 2f2 2b :3 0
1f :3 0 127 2f4
2f6 2b :3 0 74
:3 0 129 2f8 2fa
12b 2d5 2fc :2 0
3f2 37 :3 0 38
:3 0 39 :3 0 20
:3 0 3a :3 0 38
:3 0 38 :3 0 39
:3 0 1c :3 0 1f
:3 0 38 :3 0 3b
:4 0 78 1 :8 0
3f2 28 :3 0 29
:3 0 30b 30c 0
3d :4 0 18 :3 0
2b :3 0 20 :3 0
136 310 312 138
30d 314 :2 0 3f2
3e :3 0 79 :3 0
39 :3 0 1c :4 0
7a 1 :8 0 3f2
41 :4 0 31b :3 0
2f :2 0 42 :2 0
13e 31d 31f :3 0
320 :2 0 3e :3 0
39 :3 0 1c :4 0
43 1 :8 0 326
141 327 321 326
0 328 143 0
3f2 44 :3 0 45
:3 0 7b :4 0 19
:2 0 2b :3 0 1c
:3 0 145 32d 32f
147 32c 331 :3 0
19 :2 0 47 :4 0
14a 333 335 :3 0
336 :4 0 337 :2 0
339 14d 341 23
:4 0 33c 14f 33e
151 33d 33c :2 0
33f 153 :2 0 341
0 341 340 339
33f :6 0 3f2 5
:3 0 28 :3 0 29
:3 0 343 344 0
48 :4 0 18 :3 0
155 345 348 :2 0
3f2 7c :3 0 39
:3 0 4a :3 0 4b
:3 0 4c :3 0 4d
:3 0 7d :3 0 7e
:3 0 7f :3 0 80
:3 0 1c :3 0 4a
:3 0 4b :3 0 4c
:3 0 4d :3 0 5d
:3 0 5e :3 0 5e
:3 0 39 :3 0 20
:4 0 81 1 :8 0
3f2 28 :3 0 29
:3 0 35f 360 0
82 :4 0 18 :3 0
158 361 364 :2 0
3f2 61 :3 0 4a
:3 0 83 :3 0 5c
:3 0 7d :3 0 7d
:3 0 83 :3 0 5c
:3 0 7e :3 0 7e
:3 0 83 :3 0 5c
:3 0 7f :3 0 7f
:3 0 83 :3 0 5c
:3 0 80 :3 0 80
:3 0 62 :3 0 4a
:3 0 62 :3 0 4e
:3 0 7d :3 0 62
:3 0 50 :3 0 7e
:3 0 7f :3 0 80
:3 0 63 :3 0 62
:3 0 62 :3 0 39
:3 0 1c :3 0 1f
:3 0 64 :3 0 62
:3 0 4a :3 0 62
:3 0 4e :3 0 62
:3 0 50 :3 0 63
:3 0 62 :3 0 65
:3 0 61 :3 0 62
:3 0 66 :3 0 61
:3 0 39 :3 0 61
:3 0 67 :3 0 1b
:3 0 1e :3 0 64
:3 0 4a :3 0 68
:4 0 84 1 :8 0
39f 366 39e 7c
:3 0 7d :3 0 61
:3 0 7d :3 0 7e
:3 0 61 :3 0 7e
:3 0 7f :3 0 61
:3 0 7f :3 0 80
:3 0 61 :3 0 80
:3 0 39 :3 0 1c
:3 0 4a :3 0 61
:3 0 4a :4 0 85
1 :8 0 3d7 41
:4 0 3b3 :3 0 2f
:2 0 42 :2 0 15d
3b5 3b7 :3 0 3b8
:2 0 7c :3 0 39
:3 0 4a :3 0 4b
:3 0 4c :3 0 4d
:3 0 7d :3 0 7e
:3 0 7f :3 0 80
:3 0 1c :3 0 4a
:3 0 4b :3 0 61
:3 0 7d :3 0 61
:3 0 7e :3 0 61
:3 0 7f :3 0 61
:3 0 80 :3 0 6b
:3 0 4a :3 0 61
:3 0 4a :4 0 86
1 :8 0 3d4 160
3d5 3b9 3d4 0
3d6 162 0 3d7
164 3d9 68 :3 0
39f 3d7 :4 0 3f2
28 :3 0 29 :3 0
3da 3db 0 87
:4 0 18 :3 0 167
3dc 3df :2 0 3f2
3e :3 0 79 :3 0
39 :3 0 1c :4 0
88 1 :8 0 3f2
6f :3 0 3e8 3e9
:2 0 3ea 6f :5 0
3e7 :2 0 3f2 28
:3 0 29 :3 0 3eb
3ec 0 70 :4 0
18 :3 0 16a 3ed
3f0 :2 0 3f2 16d
3f6 :3 0 3f6 71
:3 0 185 3f6 3f5
3f2 3f3 :6 0 3f7
1 0 235 23b
3f6 720 :2 0 3f
:a 0 55d 8 :7 0
194 ffc 0 192
17 :3 0 89 :7 0
3fc 3fb :3 0 10
:2 0 196 1d :3 0
8a :7 0 400 3ff
:3 0 402 :2 0 55d
3f9 403 :2 0 416
:2 0 19e 5 :3 0
6 :3 0 199 407
409 :6 0 f :3 0
19 :2 0 8b :4 0
19b 40c 40e :3 0
411 40a 40f 55b
18 :6 0 8c :3 0
413 0 419 55b
17 :3 0 414 :7 0
8e :3 0 1a0 418
415 :2 0 1 8d
419 413 :4 0 1a4
108c 0 1a2 8d
:3 0 41c :7 0 41f
41d 0 55b 0
8f :6 0 1a8 10c0
0 1a6 17 :3 0
421 :7 0 424 422
0 55b 0 90
:6 0 1d :3 0 426
:7 0 429 427 0
55b 0 91 :6 0
434 435 0 1aa
1d :3 0 42b :7 0
42e 42c 0 55b
0 92 :6 0 17
:3 0 430 :7 0 433
431 0 55b 0
93 :6 0 28 :3 0
29 :3 0 2a :4 0
18 :3 0 2b :3 0
89 :3 0 12 :3 0
1ac 439 43c 1af
436 43e :2 0 558
90 :3 0 2c :3 0
89 :3 0 2d :4 0
1b3 441 444 440
445 0 558 91
:3 0 33 :3 0 34
:3 0 448 449 0
90 :3 0 1b6 44a
44c 447 44d 0
558 28 :3 0 29
:3 0 44f 450 0
94 :4 0 18 :3 0
2b :3 0 90 :3 0
12 :3 0 1b8 454
457 2b :3 0 91
:3 0 1bb 459 45b
1bd 451 45d :2 0
558 95 :3 0 96
:3 0 97 :3 0 8f
:3 0 98 :3 0 95
:3 0 90 :3 0 95
:3 0 95 :4 0 99
1 :8 0 558 28
:3 0 29 :3 0 469
46a 0 9a :4 0
18 :3 0 2b :3 0
8f :3 0 9b :3 0
46f 470 0 1c2
46e 472 1c4 46b
474 :2 0 558 8f
:3 0 9b :3 0 476
477 0 9c :2 0
42 :2 0 1ca 479
47b :3 0 47c :2 0
9d :3 0 39 :3 0
92 :3 0 3e :3 0
3f :4 0 9e 1
:8 0 535 28 :3 0
29 :3 0 484 485
0 9f :4 0 18
:3 0 2b :3 0 92
:3 0 1cd 489 48b
1cf 486 48d :2 0
535 92 :3 0 a0
:2 0 1d3 490 491
:3 0 492 :2 0 93
:3 0 2c :3 0 a1
:3 0 75 :4 0 1d5
495 498 494 499
0 4af 92 :3 0
33 :3 0 34 :3 0
49c 49d 0 93
:3 0 1d8 49e 4a0
49b 4a1 0 4af
28 :3 0 29 :3 0
4a3 4a4 0 a2
:4 0 18 :3 0 2b
:3 0 93 :3 0 12
:3 0 1da 4a8 4ab
1dd 4a5 4ad :2 0
4af 1e1 4c3 67
:3 0 93 :3 0 65
:3 0 39 :3 0 92
:4 0 a3 1 :8 0
4c2 28 :3 0 29
:3 0 4b6 4b7 0
a4 :4 0 18 :3 0
2b :3 0 93 :3 0
12 :3 0 1e5 4bb
4be 1e8 4b8 4c0
:2 0 4c2 1ec 4c4
493 4af 0 4c5
0 4c2 0 4c5
1ef 0 535 28
:3 0 29 :3 0 4c6
4c7 0 a5 :4 0
18 :3 0 2b :3 0
93 :3 0 12 :3 0
1f2 4cb 4ce 2b
:3 0 92 :3 0 1f5
4d0 4d2 1f7 4c8
4d4 :2 0 535 92
:3 0 a6 :2 0 1fc
4d7 4d8 :3 0 4d9
:2 0 a7 :3 0 32
:2 0 8f :3 0 9b
:3 0 4dd 4de 0
68 :3 0 4dc 4df
:2 0 4db 4e1 28
:3 0 29 :3 0 4e3
4e4 0 a8 :4 0
18 :3 0 2b :3 0
8f :3 0 a7 :3 0
1fe 4e9 4eb 12
:3 0 200 4e8 4ee
203 4e5 4f0 :2 0
52f 98 :3 0 95
:3 0 8f :3 0 a7
:4 0 a9 1 :8 0
52f 28 :3 0 29
:3 0 4f7 4f8 0
aa :4 0 18 :3 0
2b :3 0 8f :3 0
a7 :3 0 207 4fd
4ff 12 :3 0 209
4fc 502 20c 4f9
504 :2 0 52f 8f
:3 0 a7 :3 0 210
506 508 93 :3 0
ab :2 0 214 50b
50c :3 0 50d :2 0
15 :3 0 8f :3 0
a7 :3 0 217 510
512 219 50f 514
:2 0 516 21b 51d
6f :3 0 519 51a
:2 0 51b 6f :5 0
518 :2 0 51c 21d
51e 50e 516 0
51f 0 51c 0
51f 21f 0 52f
28 :3 0 29 :3 0
520 521 0 ac
:4 0 18 :3 0 2b
:3 0 8f :3 0 a7
:3 0 222 526 528
12 :3 0 224 525
52b 227 522 52d
:2 0 52f 22b 531
68 :3 0 4e2 52f
:4 0 532 231 533
4da 532 0 534
233 0 535 235
536 47d 535 0
537 23b 0 558
8a :3 0 2f :2 0
42 :2 0 23f 539
53b :3 0 53c :2 0
15 :3 0 90 :3 0
242 53e 540 :2 0
54e 28 :3 0 29
:3 0 542 543 0
ad :4 0 18 :3 0
2b :3 0 90 :3 0
12 :3 0 244 547
54a 247 544 54c
:2 0 54e 24b 54f
53d 54e 0 550
24e 0 558 28
:3 0 29 :3 0 551
552 0 70 :4 0
18 :3 0 250 553
556 :2 0 558 253
55c :3 0 55c 3f
:3 0 25d 55c 55b
558 559 :6 0 55d
1 0 3f9 403
55c 720 :2 0 79
:a 0 6c3 a :7 0
267 152f 0 265
17 :3 0 89 :7 0
562 561 :3 0 10
:2 0 269 1d :3 0
8a :7 0 566 565
:3 0 568 :2 0 6c3
55f 569 :2 0 57c
:2 0 271 5 :3 0
6 :3 0 26c 56d
56f :6 0 f :3 0
19 :2 0 ae :4 0
26e 572 574 :3 0
577 570 575 6c1
18 :6 0 8c :3 0
579 0 57f 6c1
17 :3 0 57a :7 0
8e :3 0 273 57e
57b :2 0 1 8d
57f 579 :4 0 277
15bf 0 275 8d
:3 0 582 :7 0 585
583 0 6c1 0
8f :6 0 27b 15f3
0 279 17 :3 0
587 :7 0 58a 588
0 6c1 0 90
:6 0 1d :3 0 58c
:7 0 58f 58d 0
6c1 0 91 :6 0
59a 59b 0 27d
1d :3 0 591 :7 0
594 592 0 6c1
0 92 :6 0 17
:3 0 596 :7 0 599
597 0 6c1 0
93 :6 0 28 :3 0
29 :3 0 2a :4 0
18 :3 0 2b :3 0
89 :3 0 12 :3 0
27f 59f 5a2 282
59c 5a4 :2 0 6be
90 :3 0 2c :3 0
89 :3 0 75 :4 0
286 5a7 5aa 5a6
5ab 0 6be 91
:3 0 33 :3 0 34
:3 0 5ae 5af 0
90 :3 0 289 5b0
5b2 5ad 5b3 0
6be 28 :3 0 29
:3 0 5b5 5b6 0
94 :4 0 18 :3 0
2b :3 0 90 :3 0
12 :3 0 28b 5ba
5bd 2b :3 0 91
:3 0 28e 5bf 5c1
290 5b7 5c3 :2 0
6be 95 :3 0 96
:3 0 97 :3 0 8f
:3 0 af :3 0 95
:3 0 90 :3 0 95
:3 0 95 :4 0 b0
1 :8 0 6be 28
:3 0 29 :3 0 5cf
5d0 0 9a :4 0
18 :3 0 2b :3 0
8f :3 0 9b :3 0
5d5 5d6 0 295
5d4 5d8 297 5d1
5da :2 0 6be 8f
:3 0 9b :3 0 5dc
5dd 0 9c :2 0
42 :2 0 29d 5df
5e1 :3 0 5e2 :2 0
9d :3 0 39 :3 0
92 :3 0 3e :3 0
79 :4 0 b1 1
:8 0 69b 28 :3 0
29 :3 0 5ea 5eb
0 9f :4 0 18
:3 0 2b :3 0 92
:3 0 2a0 5ef 5f1
2a2 5ec 5f3 :2 0
69b 92 :3 0 a0
:2 0 2a6 5f6 5f7
:3 0 5f8 :2 0 93
:3 0 2c :3 0 a1
:3 0 75 :4 0 2a8
5fb 5fe 5fa 5ff
0 615 92 :3 0
33 :3 0 34 :3 0
602 603 0 93
:3 0 2ab 604 606
601 607 0 615
28 :3 0 29 :3 0
609 60a 0 a2
:4 0 18 :3 0 2b
:3 0 93 :3 0 12
:3 0 2ad 60e 611
2b0 60b 613 :2 0
615 2b4 629 67
:3 0 93 :3 0 65
:3 0 39 :3 0 92
:4 0 a3 1 :8 0
628 28 :3 0 29
:3 0 61c 61d 0
a4 :4 0 18 :3 0
2b :3 0 93 :3 0
12 :3 0 2b8 621
624 2bb 61e 626
:2 0 628 2bf 62a
5f9 615 0 62b
0 628 0 62b
2c2 0 69b 28
:3 0 29 :3 0 62c
62d 0 a5 :4 0
18 :3 0 2b :3 0
93 :3 0 12 :3 0
2c5 631 634 2b
:3 0 92 :3 0 2c8
636 638 2ca 62e
63a :2 0 69b 92
:3 0 a6 :2 0 2cf
63d 63e :3 0 63f
:2 0 a7 :3 0 32
:2 0 8f :3 0 9b
:3 0 643 644 0
68 :3 0 642 645
:2 0 641 647 28
:3 0 29 :3 0 649
64a 0 a8 :4 0
18 :3 0 2b :3 0
8f :3 0 a7 :3 0
2d1 64f 651 12
:3 0 2d3 64e 654
2d6 64b 656 :2 0
695 af :3 0 95
:3 0 8f :3 0 a7
:4 0 b2 1 :8 0
695 28 :3 0 29
:3 0 65d 65e 0
aa :4 0 18 :3 0
2b :3 0 8f :3 0
a7 :3 0 2da 663
665 12 :3 0 2dc
662 668 2df 65f
66a :2 0 695 8f
:3 0 a7 :3 0 2e3
66c 66e 93 :3 0
ab :2 0 2e7 671
672 :3 0 673 :2 0
71 :3 0 8f :3 0
a7 :3 0 2ea 676
678 2ec 675 67a
:2 0 67c 2ee 683
6f :3 0 67f 680
:2 0 681 6f :5 0
67e :2 0 682 2f0
684 674 67c 0
685 0 682 0
685 2f2 0 695
28 :3 0 29 :3 0
686 687 0 ac
:4 0 18 :3 0 2b
:3 0 8f :3 0 a7
:3 0 2f5 68c 68e
12 :3 0 2f7 68b
691 2fa 688 693
:2 0 695 2fe 697
68 :3 0 648 695
:4 0 698 304 699
640 698 0 69a
306 0 69b 308
69c 5e3 69b 0
69d 30e 0 6be
8a :3 0 2f :2 0
42 :2 0 312 69f
6a1 :3 0 6a2 :2 0
71 :3 0 90 :3 0
315 6a4 6a6 :2 0
6b4 28 :3 0 29
:3 0 6a8 6a9 0
b3 :4 0 18 :3 0
2b :3 0 90 :3 0
12 :3 0 317 6ad
6b0 31a 6aa 6b2
:2 0 6b4 31e 6b5
6a3 6b4 0 6b6
321 0 6be 28
:3 0 29 :3 0 6b7
6b8 0 70 :4 0
18 :3 0 323 6b9
6bc :2 0 6be 326
6c2 :3 0 6c2 79
:3 0 330 6c2 6c1
6be 6bf :6 0 6c3
1 0 55f 569
6c2 720 :2 0 b4
:3 0 b5 :a 0 6ee
c :7 0 b6 :4 0
6 :3 0 6c8 6c9
0 6ee 6c6 6ca
:2 0 b6 :3 0 b7
:4 0 19 :2 0 b8
:3 0 338 6ce 6d0
:3 0 19 :2 0 b9
:3 0 ba :2 0 33b
6d3 6d5 33d 6d2
6d7 :3 0 19 :2 0
bb :4 0 340 6d9
6db :3 0 19 :2 0
b9 :3 0 ba :2 0
343 6de 6e0 345
6dd 6e2 :3 0 19
:2 0 bc :3 0 348
6e4 6e6 :3 0 6e7
:2 0 6e9 34b 6ed
:3 0 6ed b5 :4 0
6ed 6ec 6e9 6ea
:6 0 6ee 1 0
6c6 6ca 6ed 720
:2 0 b4 :3 0 bd
:a 0 719 d :7 0
b6 :4 0 6 :3 0
6f3 6f4 0 719
6f1 6f5 :2 0 b6
:3 0 be :4 0 19
:2 0 4 :3 0 34d
6f9 6fb :3 0 19
:2 0 b9 :3 0 ba
:2 0 350 6fe 700
352 6fd 702 :3 0
19 :2 0 bf :4 0
355 704 706 :3 0
19 :2 0 b9 :3 0
ba :2 0 358 709
70b 35a 708 70d
:3 0 19 :2 0 9
:3 0 35d 70f 711
:3 0 712 :2 0 714
360 718 :3 0 718
bd :4 0 718 717
714 715 :6 0 719
1 0 6f1 6f5
718 720 :3 0 71e
0 71e :3 0 71e
720 71c 71d :6 0
721 :2 0 3 :3 0
362 0 3 71e
724 :3 0 723 721
725 :8 0
36e
4
:3 0 1 7 1
4 1 10 1
d 1 19 1
16 1 22 1
1f 1 2b 1
28 1 32 1
35 1 3c 2
3f 41 1 39
1 46 1 4b
1 50 1 55
1 5a 1 5f
1 64 1 69
1 70 2 6e
72 2 7b 7c
3 78 79 7e
2 83 84 2
89 8a 1 8e
2 8c 8e 2
93 95 1 98
1 9c 2 9e
9f 1 a5 1
ad 2 b4 b5
2 b7 b8 2
ba bc 1 c4
2 ce cf 2
d3 d4 1 d8
1 dc 2 e0
e1 1 e5 8
cb cc d1 d6
da de e3 e7
1 fd 3 fa
fb ff 1 10a
2 108 10a 1
111 1 113 1
11a 2 117 11c
2 11e 120 1
124 1 127 1
126 1 12a 2
132 133 2 16e
16f 1 1e2 2
1e0 1e2 1 20f
1 211 2 1de
212 2 219 21a
2 22a 22b 15
80 87 a0 a8
b0 bf c7 e9
f6 101 106 114
12d 135 16a 171
215 21c 221 226
22d a 44 49
4e 53 58 5d
62 67 6b 74
1 236 1 239
1 240 2 243
245 1 23d 1
24a 1 24f 1
254 1 259 1
25e 1 263 1
268 1 26d 1
272 1 277 1
27e 2 27c 280
2 289 28a 3
286 287 28c 2
291 292 1 29a
2 2a0 2a1 2
2a3 2a5 1 2ad
2 2b3 2b4 2
2b6 2b8 1 2c0
2 2c6 2c7 1
2cf 2 2d9 2da
2 2de 2df 1
2e3 1 2e7 2
2eb 2ec 2 2f0
2f1 1 2f5 1
2f9 a 2d6 2d7
2dc 2e1 2e5 2e9
2ee 2f3 2f7 2fb
1 311 3 30e
30f 313 1 31e
2 31c 31e 1
325 1 327 1
32e 2 32b 330
2 332 334 1
338 1 33b 1
33a 1 33e 2
346 347 2 362
363 1 3b6 2
3b4 3b6 1 3d3
1 3d5 2 3b2
3d6 2 3dd 3de
2 3ee 3ef 17
28e 295 29d 2a8
2b0 2bb 2c3 2ca
2d2 2fd 30a 315
31a 328 341 349
35e 365 3d9 3e0
3e5 3ea 3f1 c
248 24d 252 257
25c 261 266 26b
270 275 279 282
1 3fa 1 3fe
2 3fd 401 1
408 2 40b 40d
1 405 1 417
1 41b 1 420
1 425 1 42a
1 42f 2 43a
43b 3 437 438
43d 2 442 443
1 44b 2 455
456 1 45a 4
452 453 458 45c
1 471 3 46c
46d 473 1 47a
2 478 47a 1
48a 3 487 488
48c 1 48f 2
496 497 1 49f
2 4a9 4aa 3
4a6 4a7 4ac 3
49a 4a2 4ae 2
4bc 4bd 3 4b9
4ba 4bf 2 4b5
4c1 2 4c3 4c4
2 4cc 4cd 1
4d1 4 4c9 4ca
4cf 4d3 1 4d6
1 4ea 2 4ec
4ed 3 4e6 4e7
4ef 1 4fe 2
500 501 3 4fa
4fb 503 1 507
1 50a 2 509
50a 1 511 1
513 1 515 1
51b 2 51d 51e
1 527 2 529
52a 3 523 524
52c 5 4f1 4f6
505 51f 52e 1
531 1 533 5
483 48e 4c5 4d5
534 1 536 1
53a 2 538 53a
1 53f 2 548
549 3 545 546
54b 2 541 54d
1 54f 2 554
555 9 43f 446
44e 45e 468 475
537 550 557 7
410 41a 41e 423
428 42d 432 1
560 1 564 2
563 567 1 56e
2 571 573 1
56b 1 57d 1
581 1 586 1
58b 1 590 1
595 2 5a0 5a1
3 59d 59e 5a3
2 5a8 5a9 1
5b1 2 5bb 5bc
1 5c0 4 5b8
5b9 5be 5c2 1
5d7 3 5d2 5d3
5d9 1 5e0 2
5de 5e0 1 5f0
3 5ed 5ee 5f2
1 5f5 2 5fc
5fd 1 605 2
60f 610 3 60c
60d 612 3 600
608 614 2 622
623 3 61f 620
625 2 61b 627
2 629 62a 2
632 633 1 637
4 62f 630 635
639 1 63c 1
650 2 652 653
3 64c 64d 655
1 664 2 666
667 3 660 661
669 1 66d 1
670 2 66f 670
1 677 1 679
1 67b 1 681
2 683 684 1
68d 2 68f 690
3 689 68a 692
5 657 65c 66b
685 694 1 697
1 699 5 5e9
5f4 62b 63b 69a
1 69c 1 6a0
2 69e 6a0 1
6a5 2 6ae 6af
3 6ab 6ac 6b1
2 6a7 6b3 1
6b5 2 6ba 6bb
9 5a5 5ac 5b4
5c4 5ce 5db 69d
6b6 6bd 7 576
580 584 589 58e
593 598 2 6cd
6cf 1 6d4 2
6d1 6d6 2 6d8
6da 1 6df 2
6dc 6e1 2 6e3
6e5 1 6e8 2
6f8 6fa 1 6ff
2 6fc 701 2
703 705 1 70a
2 707 70c 2
70e 710 1 713
:2 b 14 1d 26
2f 233 3f7 55d
6c3 6ee 719
1
4
0
724
0
1
14
d
38
0 1 2 2 1 5 5 1
8 1 a 1 1 0 0 0
0 0 0 0
254 5 0
50 2 0
595 a 0
42f 8 0
236 5 0
32 2 0
16 1 0
4 1 0
235 1 5
259 5 0
55 2 0
55f 1 a
586 a 0
420 8 0
581 a 0
41b 8 0
25e 5 0
5a 2 0
28 1 0
6f1 1 d
31 1 2
564 a 0
3fe 8 0
3f9 1 8
560 a 0
3fa 8 0
26d 5 0
590 a 0
42a 8 0
3 0 1
277 5 0
69 2 0
24a 5 0
46 2 0
366 7 0
172 4 0
579 a 0
413 8 0
24f 5 0
4b 2 0
641 b 0
4db 9 0
58b a 0
425 8 0
272 5 0
263 5 0
5f 2 0
56b a 0
405 8 0
23d 5 0
39 2 0
1f 1 0
268 5 0
64 2 0
d 1 0
6c6 1 c
0
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_accm_agg.sql =========*** End *
 PROMPT ===================================================================================== 
 