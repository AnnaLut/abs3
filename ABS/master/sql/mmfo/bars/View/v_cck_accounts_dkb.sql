

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ACCOUNTS_DKB.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ACCOUNTS_DKB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ACCOUNTS_DKB ("DG", "DAT_START", "DAT_END", "VAL", "BRANCH", "NMKK", "RNK", "OKPO", "PAP", "NBS", "OB22", "ACC", "NLS", "NMS", "KV", "ISHQ", "AVGQ", "IR", "DAPP", "DOSQ", "DOSQ_PP", "DOSQ_CORP2", "DOSQ_POL", "SUM_NACASH", "KOSQ", "KOSQ_PP", "KOSQ_CORP2", "KOSQ_POL", "SUM_ACC", "COUNT_T", "COUNT_PP", "COUNT_M", "COUNT1", "COUNT2", "COUNT3", "COUNT4", "COUNT5", "COUNT6", "COUNT7", "COUNT8", "COUNT9", "COUNT10", "COUNT11", "NKD", "ND", "DAOS", "DAZS", "TRNK", "T2RNK", "T1", "T2", "T3", "T4", "T5") AS 
  SELECT TO_CHAR (dg, 'dd/mm/yyyy') dg,
          TO_CHAR (dat_start, 'dd/mm/yyyy') dat_start,
          TO_CHAR (dat_end, 'dd/mm/yyyy') dat_end,
          SUBSTR (val, 1, 6) val,
          "BRANCH",
          "NMKK",
          "RNK",
          "OKPO",
          "PAP",
          "NBS",
          "OB22",
          "ACC",
          "NLS",
          "NMS",
          "KV",
          TO_CHAR (ishq) ishq,
          TO_CHAR (avgq) avgq,
          TO_CHAR (ir) ir,
          TO_CHAR (dapp, 'dd/mm/yyyy') dapp,
          TO_CHAR (dosq) dosq,
          TO_CHAR (dosq_pp) dosq_pp,
          TO_CHAR (dosq_kb_corp2) dosq_kb_corp2,
          TO_CHAR (dosq_kb_pol) dosq_kb_pol,
          TO_CHAR (sum_nacash) sum_nacash,
          TO_CHAR (kosq) kosq,
          TO_CHAR (kosq_pp) kosq_pp,
          TO_CHAR (kosq_kb_corp2) kosq_kb_corp2,
          TO_CHAR (kosq_kb_pol) kosq_kb_pol,
          TO_CHAR (sum_natek_acc) sum_natek_acc,
          TO_CHAR (count_total) count_total,
          TO_CHAR (count_pp) count_pp,
          TO_CHAR (count_memord) count_memord,
          SUBSTR (TO_CHAR (count1), 1, 15) count1,
          SUBSTR (TO_CHAR (count2), 1, 15) count2,
          SUBSTR (TO_CHAR (count3), 1, 15) count3,
          SUBSTR (TO_CHAR (count4), 1, 15) count4,
          SUBSTR (TO_CHAR (count5), 1, 15) count5,
          SUBSTR (TO_CHAR (count6), 1, 15) count6,
          SUBSTR (TO_CHAR (count7), 1, 15) count7,
          SUBSTR (TO_CHAR (count8), 1, 15) count8,
          SUBSTR (TO_CHAR (count9), 1, 15) count9,
          SUBSTR (TO_CHAR (count10), 1, 15) count10,
          SUBSTR (TO_CHAR (count11), 1, 15) count11,
          SUBSTR (nkd, 1, 30) nkd,
          "ND",
          TO_CHAR (daos, 'dd/mm/yyyy') daos,
          TO_CHAR (dazs, 'dd/mm/yyyy') dazs,
          "TRNK",
          "T2RNK",
          SUBSTR (t1, 1, 15) t1,
          SUBSTR (t2, 1, 15) t2,
          TO_CHAR (t3, 'dd/mm/yyyy') t3,
          SUBSTR (t4, 1, 15) t4,
          SUBSTR (t5, 1, 140) t5
     FROM (WITH mymfo
                AS (SELECT val
                      FROM params
                     WHERE par = 'MFO'),
                d
                AS (SELECT TO_DATE (pul.get_mas_ini_val ('sFdat1'),
                                    'dd.mm.yyyy')
                              dat_start,
                           TO_DATE (pul.get_mas_ini_val ('sFdat2'),
                                    'dd.mm.yyyy')
                              dat_end
                      FROM DUAL),         -- дата  начала и дата конца периода
                casheopergroup --- операции Текущие счета Юр лиц - касса, снятие и зачисление налички
                AS (  SELECT rahunok_2600.branch_a,
                             rahunok_2600.rnk_a,
                             rahunok_2600.nbs_a,
                             rahunok_2600.acc_a,
                             rahunok_2600.nls_a,
                             rahunok_2600.kv_a,
                             -- Rahunok_2600.DK_A,
                             --Rahunok_2600.TypeOfOper,
                             SUM (rahunok_2600.cash_natekacc) sum_natek_acc,
                             SUM (rahunok_2600.tekacc_nacash) sum_nacash,
                             SUM (DECODE (rahunok_2600.dk_a, 1, 1, 0)) count_natek_acc,
                             SUM (DECODE (rahunok_2600.dk_a, 0, 1, 0)) count_nacash
                        FROM ( --- выборка всех операций по текущим счета Юр лиц и СПД  из бух модели с учетом даты
                              SELECT a_a.branch branch_a        -- "Код ТВБВ",
                                                        ,
                                     a_a.rnk rnk_a    --"РНК клиента в Барсе",
                                                  ,
                                     a_a.pap acctype_a --"Тип счета Дб-Кт",               -- PAP Тип залишку
                                                      ,
                                     a_a.nbs nbs_a --"Номер балансового счета А",
                                                  ,
                                     a_a.acc acc_a --"Идентификатор счёта А в Барсе",
                                                  ,
                                     a_a.nls nls_a --"Номер лицевого счета А",
                                                  ,
                                     a_a.nms nms_a         --"Название счета",
                                                  ,
                                     a_a.kv kv_a                   --"Валюта",
                                                ,
                                     opldoc_a.REF ref_a --"Внутренний номер документа",
                                                       ,
                                     opldoc_a.fdat fdat_a     --"Дата оплаты",
                                                         ,
                                     opldoc_a.dk dk_a,
                                     --NVL (OPLDOC_A.SQ / 100, 0) SumDoc,
                                     opldoc_a.txt naznach      --"Назначение",
                                                         ,
                                     opldoc_a.stmt,
                                     --   case when OPLDOC_A.DK = 1 then 'Пополнение счета' else 'Снятие со счета' end TypeOfOper,
                                     CASE
                                        WHEN opldoc_a.dk = 1
                                        THEN
                                           NVL (opldoc_a.sq / 100, 0)
                                        ELSE
                                           0
                                     END
                                        cash_natekacc,
                                     CASE
                                        WHEN opldoc_a.dk = 0
                                        THEN
                                           NVL (opldoc_a.sq / 100, 0)
                                        ELSE
                                           0
                                     END
                                        tekacc_nacash
                                FROM d, accounts a_a, opldok opldoc_a
                               WHERE     (    opldoc_a.fdat >= d.dat_start
                                          AND opldoc_a.fdat <= d.dat_end)
                                     AND (a_a.nbs IN
                                             ('2500',
                                              '2512',
                                              '2513',
                                              '2520',
                                              '2523',
                                              '2525',
                                              '2526',
                                              '2530',
                                              '2531',
                                              '2541',
                                              '2542',
                                              '2544',
                                              '2545',
                                              '2546',
                                              '2552',
                                              '2553',
                                              '2554',
                                              '2555',
                                              '2560',
                                              '2561',
                                              '2562',
                                              '2565',
                                              '2570',
                                              '2571',
                                              '2572',
                                              '2600',
                                              '2601',
                                              '2602',
                                              '2603',
                                              '2604',
                                              '2605',
                                              '2606',
                                              '2610',
                                              '2611',
                                              '2615',
                                              '2640',
                                              '2641',
                                              '2642',
                                              '2643',
                                              '2650',
                                              '2651',
                                              '2652',
                                              '2655'))
                                     AND (opldoc_a.acc = a_a.acc)
                                     AND (opldoc_a.kf = a_a.kf) --     AND  A_A.ACC = 1292673
                                     AND a_a.kf =
                                            SYS_CONTEXT ('bars_context',
                                                         'user_mfo')) rahunok_2600
                             INNER JOIN
                             ( --- выборка всех операций по счетам кассы  из бух модели с учетом даты
                              SELECT a_b.branch branch_b        -- "Код ТВБВ",
                                                        ,
                                     a_b.rnk rnk_b    --"РНК клиента в Барсе",
                                                  ,
                                     a_b.pap acctype_b --"Тип счета Дб-Кт",               -- PAP Тип залишку
                                                      ,
                                     a_b.nbs nbs_b --"Номер балансового счета А",
                                                  ,
                                     a_b.acc acc_b --"Идентификатор счёта А в Барсе",
                                                  ,
                                     a_b.nls nls_b --"Номер лицевого счета А",
                                                  ,
                                     a_b.nms nms_b         --"Название счета",
                                                  ,
                                     a_b.kv kv_b                   --"Валюта",
                                                ,
                                     opldoc_b.REF ref_b --"Внутренний номер документа",
                                                       ,
                                     opldoc_b.fdat fdat_b     --"Дата оплаты",
                                                         ,
                                     opldoc_b.dk dk_b,
                                     NVL (opldoc_b.sq / 100, 0) sumdoc,
                                     opldoc_b.txt naznach      --"Назначение",
                                                         ,
                                     opldoc_b.stmt
                                FROM d, accounts a_b, opldok opldoc_b
                               WHERE     (    opldoc_b.fdat >= d.dat_start
                                          AND opldoc_b.fdat <= d.dat_end)
                                     AND (SUBSTR (a_b.nbs, 1, 2) = '10')
                                     AND (opldoc_b.acc = a_b.acc)
                                     AND (opldoc_b.kf = a_b.kf)
                                     AND a_b.kf =
                                            SYS_CONTEXT ('bars_context',
                                                         'user_mfo')) rahunok_cash
                                ON rahunok_2600.stmt = rahunok_cash.stmt
                    GROUP BY rahunok_2600.branch_a,
                             rahunok_2600.rnk_a,
                             rahunok_2600.nbs_a,
                             rahunok_2600.acc_a,
                             rahunok_2600.nls_a,
                             rahunok_2600.kv_a                             --,
                                              ),
                metodizm
                AS (SELECT acc,
                           id_tarif,
                           rmr_1.name
                              "метод ув-я о изменении тарифов",
                           id_rate,
                           rmr_2.name
                              "метод ув-я о изменении ставки"
                      FROM rko_method rm,
                           rko_method_rate rmr_1,
                           rko_method_rate rmr_2
                     WHERE rm.id_tarif = rmr_1.id AND rm.id_rate = rmr_2.id),
                -- Типы тарифных пакетов и даты их установления в разрезе счетов
                tariftype
                AS (SELECT acc,
                           effectdate "БанкДатаУстанТариф",
                           paket "Тарифный пакет"
                      FROM (SELECT DENSE_RANK ()
                                   OVER (PARTITION BY w.acc
                                         ORDER BY chgdate DESC, idupd DESC)
                                      rownumb,
                                   w.acc,
                                   w.chgdate, -- реальные дата и время изменения
                                   w.effectdate,            --"БанковскаяДата"
                                   m.id || ' - ' || m.name paket -- код и название пакета
                              FROM d, accountsw_update w, tarif_scheme m
                             WHERE     w.tag = 'SHTAR'
                                   AND TRIM (w.VALUE) = TO_CHAR (m.id(+))
                                   AND effectdate <= d.dat_end
                                   AND w.kf =
                                          SYS_CONTEXT ('bars_context',
                                                       'user_mfo'))
                     WHERE rownumb = 1),
                -- доп информация касательно тарифов в разрезе АСС выводится одной строкой по счету
                tarif_dopinfo
                AS (  SELECT                                 -- доп инфориация
                            acc,
                             LISTAGG (
                                   indpar
                                || ';'
                                || NAME
                                || ';'
                                || date_open
                                || ';'
                                || date_close,
                                '---')
                             WITHIN GROUP (ORDER BY acc)
                                "ТарифыДопИнфо"
                        FROM (SELECT acc,
                                     indpar,
                                     org.name,
                                     date_open,
                                     date_close
                                FROM rko_tarif tr, rko_organ org
                               WHERE tr.organ(+) = org.id  -- and tr.acc=87464
                                                         )
                    GROUP BY acc),
                --  общая сводная информация по тарифным пакетам которая собирается из подзапросов  MetodIzm,  TarifType, Tarif_DopInfo
                tarif_allinfo
                AS (SELECT COALESCE (metodizm.acc,
                                     tariftype.acc,
                                     tarif_dopinfo.acc)
                              acc,
                           MetodIzm."метод ув-я о изменении тарифов",
                           MetodIzm."метод ув-я о изменении ставки",
                           TarifType."БанкДатаУстанТариф",
                           TarifType."Тарифный пакет",
                           Tarif_DopInfo."ТарифыДопИнфо"
                      FROM metodizm
                           FULL JOIN tariftype
                              ON metodizm.acc = tariftype.acc
                           FULL JOIN tarif_dopinfo
                              ON metodizm.acc = tarif_dopinfo.acc)
           -------   Основной запрос
           SELECT TO_DATE (SYSDATE) dg,
                  d.dat_start,
                  d.dat_end,
                  mymfo.val,
                  a.branch,
                  c.nmkk,
                  a.rnk,
                  c.okpo,
                  a.pap,                                    -- PAP Тип залишку
                  a.nbs,
                  si.ob22,                                             -- OB22
                  a.acc,
                  a.nls,
                  a.nms,
                  a.kv,
                  CASE
                     WHEN a.kv = 980
                     THEN
                        fost (a.acc, d.dat_end) / 100
                     ELSE
                          NVL (
                             gl.p_icurval (a.kv,
                                           fost (a.acc, d.dat_end),
                                           d.dat_end),
                             0)
                        / 100
                  END
                     ishq,
                  CASE
                     WHEN a.dapp IS NOT NULL
                     THEN
                        fostq_avg (a.acc, d.dat_start, d.dat_end) / 100 -- AVOSTQ
                     ELSE
                        0
                  END
                     avgq,
                  GREATEST (acrn.fprocn (a.acc, 0, d.dat_end),
                            acrn.fprocn (a.acc, 1, d.dat_end))
                     ir,
                  a.dapp,
                  NVL (oborot.dosq, 0) / 100 dosq,
                  NVL (oborot.dosq_pp, 0) / 100 dosq_pp,
                  NVL (oborot.dosq_kb_corp2, 0) / 100 dosq_kb_corp2,
                  NVL (oborot.dosq_kb_pol, 0) / 100 dosq_kb_pol,
                  NVL (casheopergroup.sum_nacash, 0) sum_nacash,
                  NVL (oborot.kosq, 0) / 100 kosq,
                  NVL (oborot.kosq_pp, 0) / 100 kosq_pp,
                  NVL (oborot.kosq_kb_corp2, 0) / 100 kosq_kb_corp2,
                  NVL (oborot.kosq_kb_pol, 0) / 100 kosq_kb_pol,
                  NVL (casheopergroup.sum_natek_acc, 0) sum_natek_acc,
                  amount.count_total count_total,
                  amount.count_pp count_pp,
                  amount.count_memord count_memord,
                  amount.count_outdocstoothermfo count1,
                  amount.count_outdocstoothermfo_corp2 count2,
                  amount.count_outdocstoothermfo_kb_pol count3,
                  amount.count_outdocstoyourmfo count4,
                  amount.count_outdocstoyourmfo_corp2 count5,
                  amount.count_outdocstoyourmfo_kb_pol count6,
                  casheopergroup.count_nacash count7,
                  amount.count_input_docs_from_othermfo count8,
                  amount.count_input_docs_from_yourmfo count9,
                  casheopergroup.count_natek_acc count10,
                  (SELECT ia.acra
                     FROM int_accn ia
                    WHERE     ia.acc = a.acc
                          AND ia.acra IS NOT NULL
                          AND ROWNUM = 1)
                     count11,
                  sparam.nkd,
                  --    NDACC.ND "Референс договора",                 -- REFDOG
                  CASE
                     WHEN ndacc.nd IS NOT NULL THEN ndacc.nd -- если счет приклеплен к кредитному договору ....
                     WHEN depozits.dpu_id IS NOT NULL THEN depozits.dpu_id -- если счет приклеплен к депозитному договору ....
                     ELSE NULL                               -- не  определено
                  END
                     nd,
                  a.daos,
                  a.dazs,                                                   --
                  f_get_typdist (c.rnk) trnk, -- TYPDIST "(0 - не исп.; 1 - обычный; 2 - CORP2)"
                  CASE
                     WHEN c.custtype = 2 THEN 1            --  юридична особа.
                     WHEN (c.custtype = 3 AND TRIM (c.sed) = '91') THEN 2 --фізична особа – пiдпр-ць,
                     ELSE -1                                  -- не определено
                  END
                     t2rnk,
                  ----   Блок информации касательно тарифных пакетов
                  Tarif_AllInfo."метод ув-я о изменении тарифов"
                     t1,
                  Tarif_AllInfo."метод ув-я о изменении ставки"
                     t2,
                  Tarif_AllInfo."БанкДатаУстанТариф" t3,
                  Tarif_AllInfo."Тарифный пакет" t4,
                  Tarif_AllInfo."ТарифыДопИнфо" t5
             FROM mymfo,
                  d,
                  customer c JOIN accounts a ON a.rnk = c.rnk LEFT JOIN specparam_int si ON si.acc =
                                                                                               a.acc LEFT JOIN specparam sparam ON sparam.acc =
                                                                                                                                      a.acc LEFT JOIN nd_acc ndacc ON ndacc.acc =
                                                                                                                                                                         a.acc LEFT JOIN dpu_deal depozits ON depozits.acc =
                                                                                                                                                                                                                 a.acc -- подключаем таблицу со списком депозитных договоров
                                                                                                                                                                                                                      LEFT JOIN tarif_allinfo ON a.acc =
                                                                                                                                                                                                                                                    tarif_allinfo.acc --общая сводная информация по тарифным пакетам которая собирается из подзапросов
                                                                                                                                                                                                                                                                     -----  Обороты
                                                                                                                                                                                                                                                                     LEFT JOIN(  SELECT -----  Обороты
                                                                                                                                                                                                                                                                                       opldok.acc,
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              CASE
                                                                                                                                                                                                                                                                                                 WHEN     opldok.dk =
                                                                                                                                                                                                                                                                                                             0
                                                                                                                                                                                                                                                                                                      AND NOT (    accounts.pap =
                                                                                                                                                                                                                                                                                                                      1
                                                                                                                                                                                                                                                                                                               AND SUBSTR (
                                                                                                                                                                                                                                                                                                                      oper.nlsa,
                                                                                                                                                                                                                                                                                                                      1,
                                                                                                                                                                                                                                                                                                                      1) =
                                                                                                                                                                                                                                                                                                                      2
                                                                                                                                                                                                                                                                                                               AND SUBSTR (
                                                                                                                                                                                                                                                                                                                      oper.nlsa,
                                                                                                                                                                                                                                                                                                                      4,
                                                                                                                                                                                                                                                                                                                      1) =
                                                                                                                                                                                                                                                                                                                      8
                                                                                                                                                                                                                                                                                                               AND SUBSTR (
                                                                                                                                                                                                                                                                                                                      oper.nlsb,
                                                                                                                                                                                                                                                                                                                      1,
                                                                                                                                                                                                                                                                                                                      1) IN
                                                                                                                                                                                                                                                                                                                      ('2'))
                                                                                                                                                                                                                                                                                                 THEN
                                                                                                                                                                                                                                                                                                    opldok.sq -- 26.04.13 если  это не операция со счета 2**8 на счет 2го класса то суммируем, таким образом фильтруем перенос с 2078 на 2068 итд
                                                                                                                                                                                                                                                                                              END),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           dosq,
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              CASE
                                                                                                                                                                                                                                                                                                 WHEN     opldok.dk =
                                                                                                                                                                                                                                                                                                             0
                                                                                                                                                                                                                                                                                                      AND oper.vob IN
                                                                                                                                                                                                                                                                                                             (1,
                                                                                                                                                                                                                                                                                                              20)
                                                                                                                                                                                                                                                                                                 THEN
                                                                                                                                                                                                                                                                                                    opldok.sq
                                                                                                                                                                                                                                                                                                 ELSE
                                                                                                                                                                                                                                                                                                    0
                                                                                                                                                                                                                                                                                              END),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           dosq_pp, -- сумма  дебетовых оборотов в эквиваленте  по платежкам
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              CASE
                                                                                                                                                                                                                                                                                                 WHEN     opldok.dk =
                                                                                                                                                                                                                                                                                                             0
                                                                                                                                                                                                                                                                                                      AND opldok.tt IN
                                                                                                                                                                                                                                                                                                             ('IB1',
                                                                                                                                                                                                                                                                                                              'IB2',
                                                                                                                                                                                                                                                                                                              'IBB',
                                                                                                                                                                                                                                                                                                              'IBO',
                                                                                                                                                                                                                                                                                                              'IBS')
                                                                                                                                                                                                                                                                                                 THEN
                                                                                                                                                                                                                                                                                                    opldok.sq
                                                                                                                                                                                                                                                                                                 ELSE
                                                                                                                                                                                                                                                                                                    0
                                                                                                                                                                                                                                                                                              END),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           dosq_kb_corp2, -- сумма  дебетовых оборотов в эквиваленте   по  корп 2
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              CASE
                                                                                                                                                                                                                                                                                                 WHEN     opldok.dk =
                                                                                                                                                                                                                                                                                                             0
                                                                                                                                                                                                                                                                                                      AND opldok.tt IN
                                                                                                                                                                                                                                                                                                             ('KL1',
                                                                                                                                                                                                                                                                                                              'KL2')
                                                                                                                                                                                                                                                                                                 THEN
                                                                                                                                                                                                                                                                                                    opldok.sq
                                                                                                                                                                                                                                                                                                 ELSE
                                                                                                                                                                                                                                                                                                    0
                                                                                                                                                                                                                                                                                              END),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           dosq_kb_pol, -- сумма  дебетовых оборотов в эквиваленте   по  КБ полисистема
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              DECODE (
                                                                                                                                                                                                                                                                                                 opldok.dk,
                                                                                                                                                                                                                                                                                                 1, opldok.sq,
                                                                                                                                                                                                                                                                                                 0)),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           kosq, -- сумма  кредитовых оборотов в эквиваленте
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              CASE
                                                                                                                                                                                                                                                                                                 WHEN     opldok.dk =
                                                                                                                                                                                                                                                                                                             1
                                                                                                                                                                                                                                                                                                      AND oper.vob IN
                                                                                                                                                                                                                                                                                                             (1,
                                                                                                                                                                                                                                                                                                              20)
                                                                                                                                                                                                                                                                                                 THEN
                                                                                                                                                                                                                                                                                                    opldok.sq
                                                                                                                                                                                                                                                                                                 ELSE
                                                                                                                                                                                                                                                                                                    0
                                                                                                                                                                                                                                                                                              END),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           kosq_pp, -- сумма  кредитовых оборотов в эквиваленте  по платежкам
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              CASE
                                                                                                                                                                                                                                                                                                 WHEN     opldok.dk =
                                                                                                                                                                                                                                                                                                             1
                                                                                                                                                                                                                                                                                                      AND opldok.tt IN
                                                                                                                                                                                                                                                                                                             ('IB1',
                                                                                                                                                                                                                                                                                                              'IB2',
                                                                                                                                                                                                                                                                                                              'IBB',
                                                                                                                                                                                                                                                                                                              'IBO',
                                                                                                                                                                                                                                                                                                              'IBS')
                                                                                                                                                                                                                                                                                                 THEN
                                                                                                                                                                                                                                                                                                    opldok.sq
                                                                                                                                                                                                                                                                                                 ELSE
                                                                                                                                                                                                                                                                                                    0
                                                                                                                                                                                                                                                                                              END),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           kosq_kb_corp2, -- сумма  кредитовых оборотов в эквиваленте   по  корп 2
                                                                                                                                                                                                                                                                                        NVL (
                                                                                                                                                                                                                                                                                           SUM (
                                                                                                                                                                                                                                                                                              CASE
                                                                                                                                                                                                                                                                                                 WHEN     opldok.dk =
                                                                                                                                                                                                                                                                                                             1
                                                                                                                                                                                                                                                                                                      AND opldok.tt IN
                                                                                                                                                                                                                                                                                                             ('KL1',
                                                                                                                                                                                                                                                                                                              'KL2')
                                                                                                                                                                                                                                                                                                 THEN
                                                                                                                                                                                                                                                                                                    opldok.sq
                                                                                                                                                                                                                                                                                                 ELSE
                                                                                                                                                                                                                                                                                                    0
                                                                                                                                                                                                                                                                                              END),
                                                                                                                                                                                                                                                                                           0)
                                                                                                                                                                                                                                                                                           kosq_kb_pol --,   -- сумма  кредитовых оборотов в эквиваленте   по  КБ полисистема
                                                                                                                                                                                                                                                                                   FROM d,
                                                                                                                                                                                                                                                                                        oper JOIN opldok ON opldok.REF =
                                                                                                                                                                                                                                                                                                               oper.REF JOIN accounts ON accounts.acc =
                                                                                                                                                                                                                                                                                                                                            opldok.acc JOIN customer ON customer.rnk =
                                                                                                                                                                                                                                                                                                                                                                           accounts.rnk
                                                                                                                                                                                                                                                                                  WHERE     oper.kf =
                                                                                                                                                                                                                                                                                               SYS_CONTEXT (
                                                                                                                                                                                                                                                                                                  'bars_context',
                                                                                                                                                                                                                                                                                                  'user_mfo')
                                                                                                                                                                                                                                                                                        AND accounts.kf =
                                                                                                                                                                                                                                                                                               SYS_CONTEXT (
                                                                                                                                                                                                                                                                                                  'bars_context',
                                                                                                                                                                                                                                                                                                  'user_mfo')
                                                                                                                                                                                                                                                                                        AND opldok.fdat >=
                                                                                                                                                                                                                                                                                               d.dat_start
                                                                                                                                                                                                                                                                                        AND opldok.fdat <=
                                                                                                                                                                                                                                                                                               d.dat_end
                                                                                                                                                                                                                                                                                        AND opldok.sos =
                                                                                                                                                                                                                                                                                               5
                                                                                                                                                                                                                                                                                        AND oper.dk IN
                                                                                                                                                                                                                                                                                               (0,
                                                                                                                                                                                                                                                                                                1)
                                                                                                                                                                                                                                                                                        AND (   customer.custtype =
                                                                                                                                                                                                                                                                                                   2
                                                                                                                                                                                                                                                                                             OR (    customer.custtype =
                                                                                                                                                                                                                                                                                                        3
                                                                                                                                                                                                                                                                                                 AND TRIM (
                                                                                                                                                                                                                                                                                                        customer.sed) =
                                                                                                                                                                                                                                                                                                        '91'))
                                                                                                                                                                                                                                                                                        AND accounts.nbs IN
                                                                                                                                                                                                                                                                                               ( -- '2600', '2062'
                                                                                                                                                                                                                                                                                                '2010',
                                                                                                                                                                                                                                                                                                '2016',
                                                                                                                                                                                                                                                                                                '2018',
                                                                                                                                                                                                                                                                                                '2020',
                                                                                                                                                                                                                                                                                                '2026',
                                                                                                                                                                                                                                                                                                '2027',
                                                                                                                                                                                                                                                                                                '2028',
                                                                                                                                                                                                                                                                                                '2029',
                                                                                                                                                                                                                                                                                                '2030',
                                                                                                                                                                                                                                                                                                '2036',
                                                                                                                                                                                                                                                                                                '2037',
                                                                                                                                                                                                                                                                                                '2038',
                                                                                                                                                                                                                                                                                                '2039',
                                                                                                                                                                                                                                                                                                '2062',
                                                                                                                                                                                                                                                                                                '2063',
                                                                                                                                                                                                                                                                                                '2065',
                                                                                                                                                                                                                                                                                                '2066',
                                                                                                                                                                                                                                                                                                '2067',
                                                                                                                                                                                                                                                                                                '2068',
                                                                                                                                                                                                                                                                                                '2069',
                                                                                                                                                                                                                                                                                                '2071',
                                                                                                                                                                                                                                                                                                '2072',
                                                                                                                                                                                                                                                                                                '2073',
                                                                                                                                                                                                                                                                                                '2074',
                                                                                                                                                                                                                                                                                                '2075',
                                                                                                                                                                                                                                                                                                '2076',
                                                                                                                                                                                                                                                                                                '2077',
                                                                                                                                                                                                                                                                                                '2078',
                                                                                                                                                                                                                                                                                                '2079',
                                                                                                                                                                                                                                                                                                '2082',
                                                                                                                                                                                                                                                                                                '2083',
                                                                                                                                                                                                                                                                                                '2085',
                                                                                                                                                                                                                                                                                                '2086',
                                                                                                                                                                                                                                                                                                '2087',
                                                                                                                                                                                                                                                                                                '2088',
                                                                                                                                                                                                                                                                                                '2089',
                                                                                                                                                                                                                                                                                                '2100',
                                                                                                                                                                                                                                                                                                '2102',
                                                                                                                                                                                                                                                                                                '2103',
                                                                                                                                                                                                                                                                                                '2105',
                                                                                                                                                                                                                                                                                                '2106',
                                                                                                                                                                                                                                                                                                '2107',
                                                                                                                                                                                                                                                                                                '2108',
                                                                                                                                                                                                                                                                                                '2109',
                                                                                                                                                                                                                                                                                                '2110',
                                                                                                                                                                                                                                                                                                '2112',
                                                                                                                                                                                                                                                                                                '2113',
                                                                                                                                                                                                                                                                                                '2115',
                                                                                                                                                                                                                                                                                                '2116',
                                                                                                                                                                                                                                                                                                '2117',
                                                                                                                                                                                                                                                                                                '2118',
                                                                                                                                                                                                                                                                                                '2119',
                                                                                                                                                                                                                                                                                                '2122',
                                                                                                                                                                                                                                                                                                '2123',
                                                                                                                                                                                                                                                                                                '2125',
                                                                                                                                                                                                                                                                                                '2126',
                                                                                                                                                                                                                                                                                               '2127',
                                                                                                                                                                                                                                                                                                '2128',
                                                                                                                                                                                                                                                                                                '2129',
                                                                                                                                                                                                                                                                                                '2132',
                                                                                                                                                                                                                                                                                                '2133',
                                                                                                                                                                                                                                                                                                '2135',
                                                                                                                                                                                                                                                                                                '2136',
                                                                                                                                                                                                                                                                                                '2137',
                                                                                                                                                                                                                                                                                                '2138',
                                                                                                                                                                                                                                                                                                '2139',
                                                                                                                                                                                                                                                                                                '2500',
                                                                                                                                                                                                                                                                                                '2512',
                                                                                                                                                                                                                                                                                                '2513',
                                                                                                                                                                                                                                                                                                '2518',
                                                                                                                                                                                                                                                                                                '2520',
                                                                                                                                                                                                                                                                                                '2523',
                                                                                                                                                                                                                                                                                                '2525',
                                                                                                                                                                                                                                                                                                '2526',
                                                                                                                                                                                                                                                                                                '2528',
                                                                                                                                                                                                                                                                                                '2530',
                                                                                                                                                                                                                                                                                                '2531',
                                                                                                                                                                                                                                                                                                '2538',
                                                                                                                                                                                                                                                                                                '2541',
                                                                                                                                                                                                                                                                                                '2542',
                                                                                                                                                                                                                                                                                                '2544',
                                                                                                                                                                                                                                                                                                '2545',
                                                                                                                                                                                                                                                                                                '2546',
                                                                                                                                                                                                                                                                                                '2548',
                                                                                                                                                                                                                                                                                                '2552',
                                                                                                                                                                                                                                                                                                '2553',
                                                                                                                                                                                                                                                                                                '2554',
                                                                                                                                                                                                                                                                                                '2555',
                                                                                                                                                                                                                                                                                                '2558',
                                                                                                                                                                                                                                                                                                '2560',
                                                                                                                                                                                                                                                                                                '2561',
                                                                                                                                                                                                                                                                                                '2562',
                                                                                                                                                                                                                                                                                                '2565',
                                                                                                                                                                                                                                                                                                '2568',
                                                                                                                                                                                                                                                                                                '2570',
                                                                                                                                                                                                                                                                                                '2571',
                                                                                                                                                                                                                                                                                                '2572',
                                                                                                                                                                                                                                                                                                '2600',
                                                                                                                                                                                                                                                                                                '2601',
                                                                                                                                                                                                                                                                                                '2602',
                                                                                                                                                                                                                                                                                                '2603',
                                                                                                                                                                                                                                                                                                '2604',
                                                                                                                                                                                                                                                                                                '2605',
                                                                                                                                                                                                                                                                                                '2606',
                                                                                                                                                                                                                                                                                                '2607',
                                                                                                                                                                                                                                                                                                '2608',
                                                                                                                                                                                                                                                                                                '2610',
                                                                                                                                                                                                                                                                                                '2611',
                                                                                                                                                                                                                                                                                                '2615',
                                                                                                                                                                                                                                                                                                '2616',
                                                                                                                                                                                                                                                                                                '2617',
                                                                                                                                                                                                                                                                                                '2618',
                                                                                                                                                                                                                                                                                                '2640',
                                                                                                                                                                                                                                                                                                '2641',
                                                                                                                                                                                                                                                                                                '2642',
                                                                                                                                                                                                                                                                                                '2643',
                                                                                                                                                                                                                                                                                                '2650',
                                                                                                                                                                                                                                                                                                '2651',
                                                                                                                                                                                                                                                                                                '2652',
                                                                                                                                                                                                                                                                                                '2653',
                                                                                                                                                                                                                                                                                                '2655',
                                                                                                                                                                                                                                                                                                '2656',
                                                                                                                                                                                                                                                                                                '2657',
                                                                                                                                                                                                                                                                                                '2658',
                                                                                                                                                                                                                                                                                                '2903',
                                                                                                                                                                                                                                                                                                '2909',
                                                                                                                                                                                                                                                                                                '3548',
                                                                                                                                                                                                                                                                                                '3570',
                                                                                                                                                                                                                                                                                                '3578',
                                                                                                                                                                                                                                                                                                '3579',
                                                                                                                                                                                                                                                                                                '9020',
                                                                                                                                                                                                                                                                                                '9023',
                                                                                                                                                                                                                                                                                                '9122',
                                                                                                                                                                                                                                                                                                '9129',
                                                                                                                                                                                                                                                                                                '9500',
                                                                                                                                                                                                                                                                                                '9501',
                                                                                                                                                                                                                                                                                                '9503',
                                                                                                                                                                                                                                                                                                '9520',
                                                                                                                                                                                                                                                                                                '9521',
                                                                                                                                                                                                                                                                                                '9523')
                                                                                                                                                                                                                                                                               GROUP BY opldok.acc) oborot ON oborot.acc =
                                                                                                                                                                                                                                                                                                                 a.acc -----------------------------------
                                                                                                                                                                                                                                                                                                                      ----  Общее количество документов
                                                                                                                                                                                                                                                                                                                      LEFT JOIN(  SELECT opldok.acc,
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               DECODE (
                                                                                                                                                                                                                                                                                                                                                  oper.vob,
                                                                                                                                                                                                                                                                                                                                                  0, 0,
                                                                                                                                                                                                                                                                                                                                                  1)),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_total, -- общее количество документов и по дебету и по кредиту
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN oper.vob IN
                                                                                                                                                                                                                                                                                                                                                          (1,
                                                                                                                                                                                                                                                                                                                                                           20)
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1 -- количество платежных поручений,  старый вариант:    NVL (SUM (DECODE (OPER.VOB, 1, 1, 0)), 0) COUNT_PP,             -- количество платежных поручений
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_pp,
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN oper.vob IN
                                                                                                                                                                                                                                                                                                                                                          (6,
                                                                                                                                                                                                                                                                                                                                                           44)
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1 -- список типов документов относящихся к мем ордерам возможно будет дополнен
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_memord, -- количество мем. ордеров
                                                                                                                                                                                                                                                                                                                                         ----  Исходящие документы
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob !=
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              0
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_outdocstoothermfo, -- количество исходящих документов  на другие МФО
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob !=
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              0
                                                                                                                                                                                                                                                                                                                                                       AND opldok.tt IN
                                                                                                                                                                                                                                                                                                                                                              ('IB1',
                                                                                                                                                                                                                                                                                                                                                               'IB2',
                                                                                                                                                                                                                                                                                                                                                               'IBB',
                                                                                                                                                                                                                                                                                                                                                               'IBO',
                                                                                                                                                                                                                                                                                                                                                               'IBS')
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_outdocstoothermfo_corp2, -- количество исходящих документов  на другие МФО  по  корп 2
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob !=
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              0
                                                                                                                                                                                                                                                                                                                                                       AND opldok.tt IN
                                                                                                                                                                                                                                                                                                                                                              ('KL1',
                                                                                                                                                                                                                                                                                                                                                               'KL2')
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_outdocstoothermfo_kb_pol, -- количество исходящих документов  на другие МФО  по  КБ полисистема
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              0
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_outdocstoyourmfo, -- количество исходящих документов  на тотже  МФО
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              0
                                                                                                                                                                                                                                                                                                                                                       AND opldok.tt IN
                                                                                                                                                                                                                                                                                                                                                              ('IB1',
                                                                                                                                                                                                                                                                                                                                                               'IB2',
                                                                                                                                                                                                                                                                                                                                                               'IBB',
                                                                                                                                                                                                                                                                                                                                                               'IBO',
                                                                                                                                                                                                                                                                                                                                                               'IBS')
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_outdocstoyourmfo_corp2, -- количество исходящих документов  на тотже  МФО      по  корп 2
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              0
                                                                                                                                                                                                                                                                                                                                                       AND opldok.tt IN
                                                                                                                                                                                                                                                                                                                                                              ('KL1',
                                                                                                                                                                                                                                                                                                                                                               'KL2')
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_outdocstoyourmfo_kb_pol, -- количество исходящих документов  на тотже  МФО    по  КБ полисистема
                                                                                                                                                                                                                                                                                                                                         ----  Входящие документы
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa !=
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              1
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_input_docs_from_othermfo, -- количество входящих документов  с других  МФО
                                                                                                                                                                                                                                                                                                                                         NVL (
                                                                                                                                                                                                                                                                                                                                            SUM (
                                                                                                                                                                                                                                                                                                                                               CASE
                                                                                                                                                                                                                                                                                                                                                  WHEN     oper.mfoa =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND oper.mfob =
                                                                                                                                                                                                                                                                                                                                                              mymfo.val
                                                                                                                                                                                                                                                                                                                                                       AND opldok.dk =
                                                                                                                                                                                                                                                                                                                                                              1
                                                                                                                                                                                                                                                                                                                                                  THEN
                                                                                                                                                                                                                                                                                                                                                     1
                                                                                                                                                                                                                                                                                                                                                  ELSE
                                                                                                                                                                                                                                                                                                                                                     0
                                                                                                                                                                                                                                                                                                                                               END),
                                                                                                                                                                                                                                                                                                                                            0)
                                                                                                                                                                                                                                                                                                                                            count_input_docs_from_yourmfo --,   -- количество входящих документов  с нашего МФО
                                                                                                                                                                                                                                                                                                                                    FROM mymfo,
                                                                                                                                                                                                                                                                                                                                         d,
                                                                                                                                                                                                                                                                                                                                         oper JOIN opldok ON opldok.REF =
                                                                                                                                                                                                                                                                                                                                                                oper.REF JOIN accounts ON accounts.acc =
                                                                                                                                                                                                                                                                                                                                                                                             opldok.acc JOIN customer ON customer.rnk =
                                                                                                                                                                                                                                                                                                                                                                                                                            accounts.rnk
                                                                                                                                                                                                                                                                                                                                   WHERE     accounts.kf =
                                                                                                                                                                                                                                                                                                                                                SYS_CONTEXT (
                                                                                                                                                                                                                                                                                                                                                   'bars_context',
                                                                                                                                                                                                                                                                                                                                                   'user_mfo')
                                                                                                                                                                                                                                                                                                                                         AND opldok.kf =
                                                                                                                                                                                                                                                                                                                                                SYS_CONTEXT (
                                                                                                                                                                                                                                                                                                                                                   'bars_context',
                                                                                                                                                                                                                                                                                                                                                   'user_mfo')
                                                                                                                                                                                                                                                                                                                                         AND opldok.fdat >=
                                                                                                                                                                                                                                                                                                                                                d.dat_start
                                                                                                                                                                                                                                                                                                                                         AND opldok.fdat <=
                                                                                                                                                                                                                                                                                                                                                d.dat_end
                                                                                                                                                                                                                                                                                                                                         AND opldok.sos =
                                                                                                                                                                                                                                                                                                                                                5
                                                                                                                                                                                                                                                                                                                                         AND oper.dk IN
                                                                                                                                                                                                                                                                                                                                                (0,
                                                                                                                                                                                                                                                                                                                                                 1)
                                                                                                                                                                                                                                                                                                                                         AND (   customer.custtype =
                                                                                                                                                                                                                                                                                                                                                    2
                                                                                                                                                                                                                                                                                                                                              OR (    customer.custtype =
                                                                                                                                                                                                                                                                                                                                                         3
                                                                                                                                                                                                                                                                                                                                                  AND TRIM (
                                                                                                                                                                                                                                                                                                                                                         customer.sed) =
                                                                                                                                                                                                                                                                                                                                                         '91'))
                                                                                                                                                                                                                                                                                                                                         AND accounts.nbs IN -- фильт счетов по которым считается количество операций
                                                                                                                                                                                                                                                                                                                                                ('2010',
                                                                                                                                                                                                                                                                                                                                                 '2016',
                                                                                                                                                                                                                                                                                                                                                 '2018',
                                                                                                                                                                                                                                                                                                                                                 '2020',
                                                                                                                                                                                                                                                                                                                                                 '2026',
                                                                                                                                                                                                                                                                                                                                                 '2027',
                                                                                                                                                                                                                                                                                                                                                 '2028',
                                                                                                                                                                                                                                                                                                                                                 '2029',
                                                                                                                                                                                                                                                                                                                                                 '2030',
                                                                                                                                                                                                                                                                                                                                                 '2036',
                                                                                                                                                                                                                                                                                                                                                 '2037',
                                                                                                                                                                                                                                                                                                                                                 '2038',
                                                                                                                                                                                                                                                                                                                                                 '2039',
                                                                                                                                                                                                                                                                                                                                                 '2062',
                                                                                                                                                                                                                                                                                                                                                 '2063',
                                                                                                                                                                                                                                                                                                                                                 '2065',
                                                                                                                                                                                                                                                                                                                                                 '2066',
                                                                                                                                                                                                                                                                                                                                                 '2067',
                                                                                                                                                                                                                                                                                                                                                 '2068',
                                                                                                                                                                                                                                                                                                                                                 '2069',
                                                                                                                                                                                                                                                                                                                                                 '2071',
                                                                                                                                                                                                                                                                                                                                                 '2072',
                                                                                                                                                                                                                                                                                                                                                 '2073',
                                                                                                                                                                                                                                                                                                                                                 '2074',
                                                                                                                                                                                                                                                                                                                                                 '2075',
                                                                                                                                                                                                                                                                                                                                                 '2076',
                                                                                                                                                                                                                                                                                                                                                 '2077',
                                                                                                                                                                                                                                                                                                                                                 '2078',
                                                                                                                                                                                                                                                                                                                                                 '2079',
                                                                                                                                                                                                                                                                                                                                                 '2082',
                                                                                                                                                                                                                                                                                                                                                 '2083',
                                                                                                                                                                                                                                                                                                                                                 '2085',
                                                                                                                                                                                                                                                                                                                                                 '2086',
                                                                                                                                                                                                                                                                                                                                                 '2087',
                                                                                                                                                                                                                                                                                                                                                 '2088',
                                                                                                                                                                                                                                                                                                                                                 '2089',
                                                                                                                                                                                                                                                                                                                                                 '2100',
                                                                                                                                                                                                                                                                                                                                                 '2102',
                                                                                                                                                                                                                                                                                                                                                 '2103',
                                                                                                                                                                                                                                                                                                                                                 '2105',
                                                                                                                                                                                                                                                                                                                                                 '2106',
                                                                                                                                                                                                                                                                                                                                                 '2107',
                                                                                                                                                                                                                                                                                                                                                 '2108',
                                                                                                                                                                                                                                                                                                                                                 '2109',
                                                                                                                                                                                                                                                                                                                                                 '2110',
                                                                                                                                                                                                                                                                                                                                                 '2112',
                                                                                                                                                                                                                                                                                                                                                 '2113',
                                                                                                                                                                                                                                                                                                                                                 '2115',
                                                                                                                                                                                                                                                                                                                                                 '2116',
                                                                                                                                                                                                                                                                                                                                                 '2117',
                                                                                                                                                                                                                                                                                                                                                 '2118',
                                                                                                                                                                                                                                                                                                                                                 '2119',
                                                                                                                                                                                                                                                                                                                                                 '2122',
                                                                                                                                                                                                                                                                                                                                                 '2123',
                                                                                                                                                                                                                                                                                                                                                 '2125',
                                                                                                                                                                                                                                                                                                                                                 '2126',
                                                                                                                                                                                                                                                                                                                                                 '2127',
                                                                                                                                                                                                                                                                                                                                                 '2128',
                                                                                                                                                                                                                                                                                                                                                 '2129',
                                                                                                                                                                                                                                                                                                                                                 '2132',
                                                                                                                                                                                                                                                                                                                                                 '2133',
                                                                                                                                                                                                                                                                                                                                                 '2135',
                                                                                                                                                                                                                                                                                                                                                 '2136',
                                                                                                                                                                                                                                                                                                                                                 '2137',
                                                                                                                                                                                                                                                                                                                                                 '2138',
                                                                                                                                                                                                                                                                                                                                                 '2139',
                                                                                                                                                                                                                                                                                                                                                 '2500',
                                                                                                                                                                                                                                                                                                                                                 '2512',
                                                                                                                                                                                                                                                                                                                                                 '2513',
                                                                                                                                                                                                                                                                                                                                                 '2518',
                                                                                                                                                                                                                                                                                                                                                 '2520',
                                                                                                                                                                                                                                                                                                                                                 '2523',
                                                                                                                                                                                                                                                                                                                                                 '2525',
                                                                                                                                                                                                                                                                                                                                                 '2526',
                                                                                                                                                                                                                                                                                                                                                 '2528',
                                                                                                                                                                                                                                                                                                                                                 '2530',
                                                                                                                                                                                                                                                                                                                                                 '2531',
                                                                                                                                                                                                                                                                                                                                                 '2538',
                                                                                                                                                                                                                                                                                                                                                 '2541',
                                                                                                                                                                                                                                                                                                                                                 '2542',
                                                                                                                                                                                                                                                                                                                                                 '2544',
                                                                                                                                                                                                                                                                                                                                                 '2545',
                                                                                                                                                                                                                                                                                                                                                 '2546',
                                                                                                                                                                                                                                                                                                                                                 '2548',
                                                                                                                                                                                                                                                                                                                                                 '2552',
                                                                                                                                                                                                                                                                                                                                                 '2553',
                                                                                                                                                                                                                                                                                                                                                 '2554',
                                                                                                                                                                                                                                                                                                                                                 '2555',
                                                                                                                                                                                                                                                                                                                                                 '2558',
                                                                                                                                                                                                                                                                                                                                                 '2560',
                                                                                                                                                                                                                                                                                                                                                 '2561',
                                                                                                                                                                                                                                                                                                                                                 '2562',
                                                                                                                                                                                                                                                                                                                                                 '2565',
                                                                                                                                                                                                                                                                                                                                                 '2568',
                                                                                                                                                                                                                                                                                                                                                 '2570',
                                                                                                                                                                                                                                                                                                                                                 '2571',
                                                                                                                                                                                                                                                                                                                                                 '2572',
                                                                                                                                                                                                                                                                                                                                                 '2600',
                                                                                                                                                                                                                                                                                                                                                 '2601',
                                                                                                                                                                                                                                                                                                                                                 '2602',
                                                                                                                                                                                                                                                                                                                                                 '2603',
                                                                                                                                                                                                                                                                                                                                                 '2604',
                                                                                                                                                                                                                                                                                                                                                 '2605',
                                                                                                                                                                                                                                                                                                                                                 '2606',
                                                                                                                                                                                                                                                                                                                                                 '2607',
                                                                                                                                                                                                                                                                                                                                                 '2608',
                                                                                                                                                                                                                                                                                                                                                 '2610',
                                                                                                                                                                                                                                                                                                                                                 '2611',
                                                                                                                                                                                                                                                                                                                                                 '2615',
                                                                                                                                                                                                                                                                                                                                                 '2616',
                                                                                                                                                                                                                                                                                                                                                 '2617',
                                                                                                                                                                                                                                                                                                                                                 '2618',
                                                                                                                                                                                                                                                                                                                                                 '2640',
                                                                                                                                                                                                                                                                                                                                                 '2641',
                                                                                                                                                                                                                                                                                                                                                 '2642',
                                                                                                                                                                                                                                                                                                                                                 '2643',
                                                                                                                                                                                                                                                                                                                                                 '2650',
                                                                                                                                                                                                                                                                                                                                                 '2651',
                                                                                                                                                                                                                                                                                                                                                 '2652',
                                                                                                                                                                                                                                                                                                                                                 '2653',
                                                                                                                                                                                                                                                                                                                                                 '2655',
                                                                                                                                                                                                                                                                                                                                                 '2656',
                                                                                                                                                                                                                                                                                                                                                 '2657',
                                                                                                                                                                                                                                                                                                                                                 '2658',
                                                                                                                                                                                                                                                                                                                                                 '2909',
                                                                                                                                                                                                                                                                                                                                                 '3548',
                                                                                                                                                                                                                                                                                                                                                 '3570',
                                                                                                                                                                                                                                                                                                                                                 '3578',
                                                                                                                                                                                                                                                                                                                                                 '3579')
                                                                                                                                                                                                                                                                                                                                GROUP BY opldok.acc) amount ON amount.acc =
                                                                                                                                                                                                                                                                                                                                                                  a.acc --- привязываем таблицу с данными по операциям текущие счета <-> касса
                                                                                                                                                                                                                                                                                                                                                                       LEFT JOIN casheopergroup ON casheopergroup.acc_a =
                                                                                                                                                                                                                                                                                                                                                                                                      a.acc
            ---  глобальное условие общего селекта
            WHERE     (a.dazs IS NULL OR a.dazs >= d.dat_start) -- фильтр по дате начала и конца
                  AND a.daos <= d.dat_end -- дата открытия счета должна быть меньшей или равной конечной дате запроса. Т.е счет должен быть открытым не позже чем в рассматриваемомо периоде
                  AND (a.dazs >= d.dat_start OR a.dazs IS NULL) -- дата закрытия счета должна быть большей чем начальная дата запроса или пустой. Т.е счет должен быть закрыт в том периоде который анализируется информация или оставаться открытым
                  AND (   c.custtype = 2
                       OR (c.custtype = 3 AND TRIM (c.sed) = '91')) -- отбираем юр. лиц и физ. лиц - предпринимателей
                  AND a.nbs IN     -- список высех выбираемых счетов в запросе
                         ('2010',
                          '2016',
                          '2018',
                          '2020',
                          '2026',
                          '2027',
                          '2028',
                          '2029',
                          '2030',
                          '2036',
                          '2037',
                          '2038',
                          '2039',
                          '2062',
                          '2063',
                          '2065',
                          '2066',
                          '2067',
                          '2068',
                          '2069',
                          '2071',
                          '2072',
                          '2073',
                          '2074',
                          '2075',
                          '2076',
                          '2077',
                          '2078',
                          '2079',
                          '2082',
                          '2083',
                          '2085',
                          '2086',
                          '2087',
                          '2088',
                          '2089',
                          '2100',
                          '2102',
                          '2103',
                          '2105',
                          '2106',
                          '2107',
                          '2108',
                          '2109',
                          '2110',
                          '2112',
                          '2113',
                          '2115',
                          '2116',
                          '2117',
                          '2118',
                          '2119',
                          '2122',
                          '2123',
                          '2125',
                          '2126',
                          '2127',
                          '2128',
                          '2129',
                          '2132',
                          '2133',
                          '2135',
                          '2136',
                          '2137',
                          '2138',
                          '2139',
                          '2500',
                          '2512',
                          '2513',
                          '2518',
                          '2520',
                          '2523',
                          '2525',
                          '2526',
                          '2528',
                          '2530',
                          '2531',
                          '2538',
                          '2541',
                          '2542',
                          '2544',
                          '2545',
                          '2546',
                          '2548',
                          '2552',
                          '2553',
                          '2554',
                          '2555',
                          '2558',
                          '2560',
                          '2561',
                          '2562',
                          '2565',
                          '2568',
                          '2570',
                          '2571',
                          '2572',
                          '2600',
                          '2601',
                          '2602',
                          '2603',
                          '2604',
                          '2605',
                          '2606',
                          '2607',
                          '2608',
                          '2610',
                          '2611',
                          '2615',
                          '2616',
                          '2617',
                          '2618',
                          '2640',
                          '2641',
                          '2642',
                          '2643',
                          '2650',
                          '2651',
                          '2652',
                          '2653',
                          '2655',
                          '2656',
                          '2657',
                          '2658',
                          '2909',
                          '3548',
                          '3570',
                          '3578',
                          '3579',
                          '3600',
                          '9020',
                          '9023',
                          '9122',
                          '9129',
                          '9500',
                          '9501',
                          '9503',
                          '9520',
                          '9521',
                          '9523',
                          '2903'));

PROMPT *** Create  grants  V_CCK_ACCOUNTS_DKB ***
grant SELECT                                                                 on V_CCK_ACCOUNTS_DKB to BARSREADER_ROLE;
grant SELECT                                                                 on V_CCK_ACCOUNTS_DKB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ACCOUNTS_DKB to RCC_DEAL;
grant SELECT                                                                 on V_CCK_ACCOUNTS_DKB to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ACCOUNTS_DKB.sql =========*** End
PROMPT ===================================================================================== 
