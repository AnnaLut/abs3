

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CCK_ACCOUNTS_DKB.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CCK_ACCOUNTS_DKB ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CCK_ACCOUNTS_DKB ("DG", "DAT_START", "DAT_END", "VAL", "BRANCH", "NMKK", "RNK", "OKPO", "PAP", "NBS", "OB22", "ACC", "NLS", "NMS", "KV", "ISHQ", "AVGQ", "IR", "DAPP", "DOSQ", "DOSQ_PP", "DOSQ_CORP2", "DOSQ_POL", "SUM_NACASH", "KOSQ", "KOSQ_PP", "KOSQ_CORP2", "KOSQ_POL", "SUM_ACC", "COUNT_T", "COUNT_PP", "COUNT_M", "COUNT1", "COUNT2", "COUNT3", "COUNT4", "COUNT5", "COUNT6", "COUNT7", "COUNT8", "COUNT9", "COUNT10", "COUNT11", "NKD", "ND", "DAOS", "DAZS", "TRNK", "T2RNK", "T1", "T2", "T3", "T4", "T5") AS 
  SELECT TO_CHAR (DG, 'dd/mm/yyyy') dg,
          TO_CHAR (DAT_START, 'dd/mm/yyyy') DAT_START,
          TO_CHAR (DAT_END, 'dd/mm/yyyy') DAT_END,
          SUBSTR (VAL, 1, 6) VAL,
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
          to_char(ISHQ) ISHQ,
          to_char(AVGQ) AVGQ,
          to_char(ir) IR,
          TO_CHAR (DAPP, 'dd/mm/yyyy') dapp,
          to_char(DOSQ) DOSQ,
          to_char(DOSQ_PP)DOSQ_PP,
          to_char(DOSQ_KB_CORP2) DOSQ_KB_CORP2,
          to_char(DOSQ_KB_POL) DOSQ_KB_POL,
          to_char(SUM_NACASH) SUM_NACASH,
          to_char(KOSQ) KOSQ,
          to_char(KOSQ_PP) KOSQ_PP,
          to_char(KOSQ_KB_CORP2) KOSQ_KB_CORP2,
          to_char(KOSQ_KB_POL) KOSQ_KB_POL,
          to_char(SUM_NATEK_ACC) SUM_NATEK_ACC,
          to_char(COUNT_TOTAL) COUNT_TOTAL,
          to_char(COUNT_PP) COUNT_PP,
          to_char(COUNT_MEMORD) COUNT_MEMORD,
          substr(to_char(COUNT1),1,15) COUNT1,
          substr(to_char(COUNT2),1,15) COUNT2,
          substr(to_char(COUNT3),1,15) COUNT3,
          substr(to_char(COUNT4),1,15) COUNT4,
          substr(to_char(COUNT5),1,15) COUNT5,
          substr(to_char(COUNT6),1,15) COUNT6,
          substr(to_char(COUNT7),1,15) COUNT7,
          substr(to_char(COUNT8),1,15) COUNT8,
          substr(to_char(COUNT9),1,15) COUNT9,
          substr(to_char(COUNT10),1,15) COUNT10,
          substr(to_char(COUNT11),1,15) COUNT11,
          SUBSTR (NKD, 1, 30) NKD,
          "ND",
          TO_CHAR (DAOS, 'dd/mm/yyyy') DAOS,
          TO_CHAR (DAZS, 'dd/mm/yyyy') DAZS,
          "TRNK",
          "T2RNK",
           substr(t1,1,15)t1,
           substr(t2,1,15) t2,
           TO_CHAR (t3, 'dd/mm/yyyy') t3,
           substr(t4,1,15) t4,
           substr(t5,1,140) t5
           from (
WITH MyMFO
                AS (SELECT VAL
                      FROM PARAMS
                     WHERE PAR = 'MFO'),
                D
                AS (SELECT TO_DATE (pul.Get_Mas_Ini_Val ('sFdat1'),
                                    'dd.mm.yyyy')
                              DAT_START,
                           TO_DATE (pul.Get_Mas_Ini_Val ('sFdat2'),
                                    'dd.mm.yyyy')
                              DAT_END
                      FROM DUAL),         -- дата  начала и дата конца периода
    CasheOperGroup   --- операции Текущие счета Юр лиц - касса, снятие и зачисление налички
   as (
  Select
       Rahunok_2600.BRANCH_A,
       Rahunok_2600.RNK_A,
       Rahunok_2600.NBS_A,
       Rahunok_2600.ACC_A,
       Rahunok_2600.NLS_A,
       Rahunok_2600.KV_A,
       -- Rahunok_2600.DK_A,
       --Rahunok_2600.TypeOfOper,
       SUM(Rahunok_2600.Cash_NaTekACC) SUM_NaTek_ACC,
       SUM(Rahunok_2600.TekACC_NaCash) SUM_NaCash,
       SUM (DECODE (Rahunok_2600.DK_A ,1,1,0)) COUNT_NaTek_ACC,
       SUM (DECODE (Rahunok_2600.DK_A ,0,1,0)) COUNT_NaCash
 from
                      (   SELECT    --- выборка всех операций по текущим счета Юр лиц и СПД  из бух модели с учетом даты
                           A_A.BRANCH BRANCH_A, -- "Код ТВБВ",
                           A_A.RNK RNK_A, --"РНК клиента в Барсе",
                           A_A.PAP AccType_A, --"Тип счета Дб-Кт",               -- PAP Тип залишку
                           A_A.NBS NBS_A, --"Номер балансового счета А",
                           A_A.ACC ACC_A, --"Идентификатор счёта А в Барсе",
                           A_A.NLS NLS_A, --"Номер лицевого счета А",
                           A_A.NMS NMS_A, --"Название счета",
                           A_A.KV  KV_A, --"Валюта",
                           OPLDOC_A.REF    REF_A, --"Внутренний номер документа",
                           OPLDOC_A.FDAT FDAT_A, --"Дата оплаты",
                           OPLDOC_A.DK DK_A,
                           --NVL (OPLDOC_A.SQ / 100, 0) SumDoc,
                           OPLDOC_A.txt Naznach, --"Назначение",
                           OPLDOC_A.STMT,
                        --   case when OPLDOC_A.DK = 1 then 'Пополнение счета' else 'Снятие со счета' end TypeOfOper,
                           case  when OPLDOC_A.DK = 1 then NVL (OPLDOC_A.SQ / 100, 0) else 0 end Cash_NaTekACC,
                           case  when OPLDOC_A.DK = 0 then NVL (OPLDOC_A.SQ / 100, 0) else 0 end TekACC_NaCash
                    from
                            D,
                           ACCOUNTS A_A,
                           OPLDOK OPLDOC_A
                    where
                                   (OPLDOC_A.FDAT >= D.DAT_START   and OPLDOC_A.FDAT <= D.DAT_END)
                           AND ( A_A.NBS in  (2500, 2512, 2513, 2520, 2523, 2525, 2526, 2530, 2531, 2541, 2542, 2544, 2545, 2546, 2552, 2553, 2554, 2555, 2560, 2561, 2562,
                                                       2565, 2570, 2571, 2572, 2600, 2601, 2602, 2603, 2604, 2605, 2606, 2610, 2611, 2615, 2640, 2641, 2642, 2643, 2650, 2651, 2652, 2655 ))
                           AND  (OPLDOC_A.ACC = A_A.ACC)
                           AND (OPLDOC_A.KF = A_A.KF)
                      --     AND  A_A.ACC = 1292673
                           )  Rahunok_2600
 Inner join
                       ( SELECT --- выборка всех операций по счетам кассы  из бух модели с учетом даты
                           A_B.BRANCH BRANCH_B, -- "Код ТВБВ",
                           A_B.RNK RNK_B, --"РНК клиента в Барсе",
                           A_B.PAP AccType_B, --"Тип счета Дб-Кт",               -- PAP Тип залишку
                           A_B.NBS NBS_B, --"Номер балансового счета А",
                           A_B.ACC ACC_B, --"Идентификатор счёта А в Барсе",
                           A_B.NLS NLS_B, --"Номер лицевого счета А",
                           A_B.NMS NMS_B, --"Название счета",
                           A_B.KV  KV_B, --"Валюта",
                           OPLDOC_B.REF    REF_B, --"Внутренний номер документа",
                           OPLDOC_B.FDAT FDAT_B, --"Дата оплаты",
                           OPLDOC_B.DK DK_B,
                           NVL (OPLDOC_B.SQ / 100, 0) SumDoc,
                           OPLDOC_B.txt Naznach, --"Назначение",
                           OPLDOC_B.STMT
                    from
                              D,
                              ACCOUNTS A_B,
                              OPLDOK OPLDOC_B
                    where
                               (OPLDOC_B.FDAT >= D.DAT_START   and OPLDOC_B.FDAT <= D.DAT_END)
                               AND ( SUBSTR (A_B.NBS,1,2) = '10')
                               AND  (OPLDOC_B.ACC = A_B.ACC)
                               AND (OPLDOC_B.KF = A_B.KF)) Rahunok_Cash
    ON    Rahunok_2600.STMT = Rahunok_Cash.STMT
    group by
       Rahunok_2600.BRANCH_A,
       Rahunok_2600.RNK_A,
       Rahunok_2600.NBS_A,
       Rahunok_2600.ACC_A,
       Rahunok_2600.NLS_A,
       Rahunok_2600.KV_A--,
    ),
MetodIzm as (SELECT acc,
       ID_TARIF,
       rmr_1.NAME "метод ув-я о изменении тарифов",
       ID_RATE,
       rmr_2.NAME  "метод ув-я о изменении ставки"
  FROM rko_method rm, RKO_METHOD_RATE rmr_1, RKO_METHOD_RATE rmr_2
 WHERE rm.ID_TARIF = rmr_1.ID AND rm.ID_RATE = rmr_2.ID),
     -- Типы тарифных пакетов и даты их установления в разрезе счетов
TarifType as (select ACC,  EFFECTDATE "БанкДатаУстанТариф", paket "Тарифный пакет" from
 (SELECT dense_rank() over(partition by w.acc order by CHGDATE DESC, IDUPD DESC ) RowNumb,
                    w.acc,
                     w.CHGDATE,  -- реальные дата и время изменения
                     w.EFFECTDATE ,  --"БанковскаяДата"
                     m.id || ' - ' || m.name paket  -- код и название пакета
                FROM D, accountsw_update w, tarif_scheme m
               WHERE
                      w.tag = 'SHTAR'
                     AND TRIM (w.VALUE) = TO_CHAR (m.id(+))
                     AND EFFECTDATE <= d.DAT_END)
where     RowNumb=1 ),
-- доп информация касательно тарифов в разрезе АСС выводится одной строкой по счету
Tarif_DopInfo as (select    -- доп инфориация
   acc, LISTAGG(INDPAR||';'|| NAME ||';'|| DATE_OPEN ||';'|| DATE_CLOSE,'---') WITHIN GROUP (ORDER BY ACC) "ТарифыДопИнфо"
from
(
select acc, INDPAR, org.NAME, DATE_OPEN,DATE_CLOSE
from rko_tarif tr, rko_organ org
  where tr.ORGAN(+) = org.ID
 -- and tr.acc=87464
  ) group by acc),
  --  общая сводная информация по тарифным пакетам которая собирается из подзапросов  MetodIzm,  TarifType, Tarif_DopInfo
  Tarif_AllInfo
                    as (select COALESCE (MetodIzm.acc,TarifType.acc,Tarif_DopInfo.acc ) acc,
                     MetodIzm."метод ув-я о изменении тарифов",
                     MetodIzm."метод ув-я о изменении ставки",
                     TarifType."БанкДатаУстанТариф",
                     TarifType."Тарифный пакет",
                     Tarif_DopInfo."ТарифыДопИнфо"
                     from MetodIzm
                     full join    TarifType
                        on MetodIzm.ACC = TarifType.ACC
                     full join  Tarif_DopInfo
                        on MetodIzm.ACC = Tarif_DopInfo.ACC)
 -------   Основной запрос
SELECT
       TO_DATE (SYSDATE) dg ,
       D.DAT_START ,
       D.DAT_END ,
       MyMFO.VAL  ,
       A.BRANCH ,
       C.NMKK ,
       A.RNK ,
       C.OKPO ,
       A.PAP ,                      -- PAP Тип залишку
       A.NBS ,
       SI.OB22 ,                           -- OB22
       A.ACC ,
       A.NLS ,
       A.NMS,
       A.KV ,
       CASE
          WHEN A.KV = 980 THEN FOST (A.ACC, D.DAT_END)/100
          ELSE  NVL ( gl.p_icurval (a.kv, fost (a.acc, D.DAT_END), D.DAT_END), 0)/ 100
       END
          ISHQ,
     case
       WHEN A.DAPP is not null THEN   FOSTQ_AVG (A.ACC, D.DAT_START, D.DAT_END)/100   -- AVOSTQ
       ELSE 0
       END
       AVGQ,
       GREATEST (ACRN.FPROCN (A.ACC, 0, D.DAT_END),
                          ACRN.FPROCN (A.ACC, 1, D.DAT_END))  IR,
       A.DAPP ,
        NVL (OBOROT.DOSQ, 0)/100 DOSQ,
        NVL (OBOROT.DOSQ_PP, 0)/100 DOSQ_PP,
        NVL (OBOROT.DOSQ_KB_CORP2, 0)/100 DOSQ_KB_CORP2,
        NVL (OBOROT.DOSQ_KB_POL, 0)/100 DOSQ_KB_POL,
        NVL (CasheOperGroup.SUM_NaCash, 0)   SUM_NaCash,
        NVL (OBOROT.KOSQ, 0)/100 KOSQ,
        NVL (OBOROT.KOSQ_PP, 0)/100 KOSQ_PP,
        NVL (OBOROT.KOSQ_KB_CORP2, 0)/100 KOSQ_KB_CORP2,
        NVL (OBOROT.KOSQ_KB_POL, 0)/100 KOSQ_KB_POL,
        NVL (CasheOperGroup.SUM_NaTek_ACC, 0)  SUM_NaTek_ACC,
        AMOUNT.COUNT_TOTAL COUNT_TOTAL,
        AMOUNT.COUNT_PP  COUNT_PP,
        AMOUNT.COUNT_MEMORD COUNT_MEMORD,
        AMOUNT.COUNT_OUTDOCSTOOTHERMFO  COUNT1,
        AMOUNT.COUNT_OUTDOCSTOOTHERMFO_CORP2  COUNT2,
        AMOUNT.COUNT_OUTDOCSTOOTHERMFO_KB_POL  COUNT3,
        AMOUNT.COUNT_OUTDOCSTOYOURMFO  COUNT4,
        AMOUNT.COUNT_OUTDOCSTOYOURMFO_CORP2  COUNT5,
        AMOUNT.COUNT_OUTDOCSTOYOURMFO_KB_POL  COUNT6,
        CasheOperGroup.COUNT_NaCash   COUNT7,
        AMOUNT.COUNT_INPUT_DOCS_FROM_OTHERMFO  COUNT8,
        AMOUNT.COUNT_INPUT_DOCS_FROM_YOURMFO  COUNT9,
        CasheOperGroup.COUNT_NaTek_ACC COUNT10,
         (SELECT IA.ACRA FROM INT_ACCN IA  WHERE IA.ACC=A.ACC AND IA.ACRA IS NOT NULL AND ROWNUM = 1)     COUNT11,
         Sparam.NKD ,
     --    NDACC.ND "Референс договора",                 -- REFDOG
         case
            when  NDACC.ND is not null then NDACC.ND                            -- если счет приклеплен к кредитному договору ....
            when  Depozits.DPU_ID is not null then Depozits.DPU_ID          -- если счет приклеплен к депозитному договору ....
            else null                                                                        -- не  определено
         end  ND,
         A.DAOS ,
         A.DAZS ,                       --
         F_GET_TYPDIST (C.RNK)          TRNK, -- TYPDIST "(0 - не исп.; 1 - обычный; 2 - CORP2)"
        case
            when C.CUSTTYPE = 2 THEN 1  --  юридична особа.
            when (C.CUSTTYPE = 3 AND TRIM (C.SED) = '91') THEN 2 --фізична особа – пiдпр-ць,
           else -1 -- не определено
         end  T2RNK ,
        ----   Блок информации касательно тарифных пакетов
         Tarif_AllInfo."метод ув-я о изменении тарифов" t1,
         Tarif_AllInfo."метод ув-я о изменении ставки" t2,
         Tarif_AllInfo."БанкДатаУстанТариф" t3,
         Tarif_AllInfo."Тарифный пакет" t4,
         Tarif_AllInfo."ТарифыДопИнфо" t5
  FROM
      MyMFO,
      D,
      CUSTOMER C
      JOIN ACCOUNTS A          ON A.RNK = C.RNK
      LEFT JOIN SPECPARAM_INT SI         ON SI.ACC = A.ACC
      LEFT JOIN SPECPARAM Sparam        ON Sparam.ACC = A.ACC
      LEFT JOIN ND_ACC NDACC               ON NDACC.ACC = A.ACC
      LEFT JOIN DPU_DEAL Depozits          ON Depozits.ACC = A.ACC            -- подключаем таблицу со списком депозитных договоров
      LEFT JOIN  Tarif_AllInfo                   ON  A.ACC = Tarif_AllInfo.ACC      --общая сводная информация по тарифным пакетам которая собирается из подзапросов
       -----  Обороты
       LEFT JOIN (  SELECT     -----  Обороты
                          OPLDOK.ACC,
                          NVL( sum(
                              case
                                when
                                     OPLDOK.DK = 0 and not ( ACCOUNTS.Pap =1 and substr(OPER.nlsa,1,1)=2 and substr(OPER.nlsa,4,1)=8 and substr(OPER.nlsb,1,1) in ('2')) then OPLDOK.SQ  -- 26.04.13 если  это не операция со счета 2**8 на счет 2го класса то суммируем, таким образом фильтруем перенос с 2078 на 2068 итд
                                     end),0) DOSQ,
                                                  NVL (
                                                  SUM(CASE
                                                         WHEN   OPLDOK.DK = 0 AND OPER.VOB in (1, 20)  THEN OPLDOK.SQ
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  DOSQ_PP,   -- сумма  дебетовых оборотов в эквиваленте  по платежкам
                                                  NVL (
                                                  SUM(CASE
                                                         WHEN   OPLDOK.DK = 0 AND OPLDOK.TT IN ('IB1', 'IB2', 'IBB', 'IBO', 'IBS')  THEN OPLDOK.SQ
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  DOSQ_KB_Corp2,   -- сумма  дебетовых оборотов в эквиваленте   по  корп 2
                                                  NVL (
                                                  SUM(CASE
                                                         WHEN  OPLDOK.DK = 0 AND OPLDOK.TT IN ('KL1', 'KL2')  THEN OPLDOK.SQ
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  DOSQ_KB_Pol,   -- сумма  дебетовых оборотов в эквиваленте   по  КБ полисистема
                           NVL (SUM (DECODE (OPLDOK.DK, 1, OPLDOK.SQ, 0)), 0) KOSQ,  -- сумма  кредитовых оборотов в эквиваленте
                                                NVL (
                                                  SUM(CASE
                                                         WHEN   OPLDOK.DK = 1 AND OPER.VOB in (1, 20)  THEN OPLDOK.SQ
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  KOSQ_PP,   -- сумма  кредитовых оборотов в эквиваленте  по платежкам
                                                  NVL (
                                                  SUM(CASE
                                                         WHEN   OPLDOK.DK = 1 AND OPLDOK.TT IN ('IB1', 'IB2', 'IBB', 'IBO', 'IBS')  THEN OPLDOK.SQ
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  KOSQ_KB_Corp2,   -- сумма  кредитовых оборотов в эквиваленте   по  корп 2
                                                  NVL (
                                                  SUM(CASE
                                                         WHEN  OPLDOK.DK = 1 AND OPLDOK.TT IN ('KL1', 'KL2')  THEN OPLDOK.SQ
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  KOSQ_KB_Pol--,   -- сумма  кредитовых оборотов в эквиваленте   по  КБ полисистема
     FROM
     D,
     OPER
                           JOIN OPLDOK      ON OPLDOK.REF = OPER.REF
                           JOIN ACCOUNTS ON ACCOUNTS.ACC = OPLDOK.ACC
                           JOIN CUSTOMER ON CUSTOMER.RNK = ACCOUNTS.RNK
   WHERE             OPLDOK.FDAT >= D.DAT_START
                           AND OPLDOK.FDAT <= D.DAT_END
                           AND OPLDOK.SOS = 5
                           AND OPER.DK IN (0, 1)
                           AND (CUSTOMER.CUSTTYPE = 2
                                    OR (CUSTOMER.CUSTTYPE = 3
                                    AND TRIM (CUSTOMER.SED) = '91'))
                           AND ACCOUNTS.NBS IN
                                    (
                                   -- 2600, 2062
                                            2010,2016,2018,2020,2026,2027,2028,2029,2030,2036,2037,2038,2039,2062,2063,2065,2066,2067,2068,2069,
                                            2071,2072,2073,2074,2075,2076,2077,2078,2079,2082,2083,2085,2086,2087,2088,2089,2100,2102,2103,2105,
                                            2106,2107,2108,2109,2110,2112,2113,2115,2116,2117,2118,2119,2122,2123,2125,2126,2127,2128,2129,2132,
                                            2133,2135,2136,2137,2138,2139,2500,2512,2513,2518,2520,2523,2525,2526,2528,2530,2531,2538,2541,2542,
                                            2544,2545,2546,2548,2552,2553,2554,2555,2558,2560,2561,2562,2565,2568,2570,2571,2572,2600,2601,2602,
                                            2603,2604,2605,2606,2607,2608,2610,2611,2615,2616,2617,2618,2640,2641,2642,2643,2650,2651,2652,2653,
                                            2655,2656,2657,2658,2903, 2909,3548,3570,3578,3579,9020,9023,9122,9129,9500,9501,9503,9520,9521,9523
                                      )
      GROUP BY OPLDOK.ACC) OBOROT    ON OBOROT.ACC = A.ACC
     -----------------------------------
     ----  Общее количество документов
       LEFT JOIN ( SELECT
                         OPLDOK.ACC,
                         NVL (SUM (DECODE (OPER.VOB, 0, 0, 1)), 0)    COUNT_TOTAL,     -- общее количество документов и по дебету и по кредиту
                         NVL (
                              SUM(CASE
                                     WHEN OPER.VOB IN (1, 20) THEN 1   -- количество платежных поручений,  старый вариант:    NVL (SUM (DECODE (OPER.VOB, 1, 1, 0)), 0) COUNT_PP,             -- количество платежных поручений
                                     ELSE 0
                                  END),
                              0)
                              COUNT_PP,
                           NVL (
                              SUM(CASE
                                     WHEN OPER.VOB IN (6, 44) THEN 1   -- список типов документов относящихся к мем ордерам возможно будет дополнен
                                     ELSE 0
                                  END),
                              0)
                              COUNT_MEMORD,                                     -- количество мем. ордеров
           ----  Исходящие документы
                           NVL (
                              SUM(CASE
                                     WHEN OPER.MFOA = MyMFO.VAL  AND OPER.MFOB != MyMFO.VAL AND OPLDOK.DK = 0 THEN 1
                                     ELSE 0
                                  END),
                              0)
                              COUNT_OutDocsToOtherMFO,   -- количество исходящих документов  на другие МФО
                                                NVL (
                                                  SUM(CASE
                                                         WHEN OPER.MFOA = MyMFO.VAL AND OPER.MFOB != MyMFO.VAL AND OPLDOK.DK = 0 AND OPLDOK.TT IN ('IB1', 'IB2', 'IBB', 'IBO', 'IBS')  THEN 1
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  COUNT_OutDocsToOtherMFO_Corp2,   -- количество исходящих документов  на другие МФО  по  корп 2
                                                   NVL (
                                                  SUM(CASE
                                                         WHEN OPER.MFOA = MyMFO.VAL AND OPER.MFOB != MyMFO.VAL AND OPLDOK.DK = 0 AND OPLDOK.TT IN ('KL1', 'KL2')  THEN 1
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  COUNT_OutDocsToOtherMFO_KB_Pol,   -- количество исходящих документов  на другие МФО  по  КБ полисистема
                              NVL (
                              SUM(CASE
                                     WHEN OPER.MFOA = MyMFO.VAL AND OPER.MFOB = MyMFO.VAL AND  OPLDOK.DK = 0 THEN 1
                                     ELSE 0
                                  END),
                              0)
                              COUNT_OutDocsToYourMFO,   -- количество исходящих документов  на тотже  МФО
                                                    NVL (
                                                  SUM(CASE
                                                         WHEN OPER.MFOA = MyMFO.VAL AND OPER.MFOB = MyMFO.VAL AND  OPLDOK.DK = 0 AND OPLDOK.TT IN ('IB1', 'IB2', 'IBB', 'IBO', 'IBS')  THEN 1
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  COUNT_OutDocsToYourMFO_Corp2,   -- количество исходящих документов  на тотже  МФО      по  корп 2
                                                   NVL (
                                                  SUM(CASE
                                                         WHEN OPER.MFOA = MyMFO.VAL AND OPER.MFOB = MyMFO.VAL AND  OPLDOK.DK = 0 AND OPLDOK.TT IN ('KL1', 'KL2')  THEN 1
                                                         ELSE 0
                                                      END),
                                                  0)
                                                  COUNT_OutDocsToYourMFO_KB_Pol,   -- количество исходящих документов  на тотже  МФО    по  КБ полисистема
         ----  Входящие документы
                               NVL (
                              SUM(CASE
                                     WHEN OPER.MFOA != MyMFO.VAL AND OPER.MFOB = MyMFO.VAL AND OPLDOK.DK = 1 THEN 1
                                     ELSE 0
                                  END),
                              0)
                              COUNT_Input_Docs_From_OtherMFO,   -- количество входящих документов  с других  МФО
                              NVL (
                              SUM(CASE
                                     WHEN OPER.MFOA = MyMFO.VAL AND OPER.MFOB = MyMFO.VAL AND  OPLDOK.DK = 1 THEN 1
                                     ELSE 0
                                  END),
                              0)
                              COUNT_Input_Docs_From_YourMFO--,   -- количество входящих документов  с нашего МФО
  FROM
                           MyMFO,
                           D,
                           OPER
                           JOIN OPLDOK      ON OPLDOK.REF = OPER.REF
                           JOIN ACCOUNTS ON ACCOUNTS.ACC = OPLDOK.ACC
                           JOIN CUSTOMER ON CUSTOMER.RNK = ACCOUNTS.RNK
   WHERE              OPLDOK.FDAT >= D.DAT_START
                           AND OPLDOK.FDAT <= D.DAT_END
                           AND OPLDOK.SOS = 5
                           AND OPER.DK IN (0, 1)
                           AND (CUSTOMER.CUSTTYPE = 2
                                OR (CUSTOMER.CUSTTYPE = 3
                                    AND TRIM (CUSTOMER.SED) = '91'))
                           AND ACCOUNTS.NBS IN    -- фильт счетов по которым считается количество операций
                                    (
                                           2010,2016,2018,2020,2026,2027,2028,2029,2030,2036,2037,2038,2039,2062,2063,2065,2066,2067,2068,2069,
                                            2071,2072,2073,2074,2075,2076,2077,2078,2079,2082,2083,2085,2086,2087,2088,2089,2100,2102,2103,2105,
                                            2106,2107,2108,2109,2110,2112,2113,2115,2116,2117,2118,2119,2122,2123,2125,2126,2127,2128,2129,2132,
                                            2133,2135,2136,2137,2138,2139,2500,2512,2513,2518,2520,2523,2525,2526,2528,2530,2531,2538,2541,2542,
                                            2544,2545,2546,2548,2552,2553,2554,2555,2558,2560,2561,2562,2565,2568,2570,2571,2572,2600,2601,2602,
                                            2603,2604,2605,2606,2607,2608,2610,2611,2615,2616,2617,2618,2640,2641,2642,2643,2650,2651,2652,2653,
                                            2655,2656,2657,2658,2909,3548,3570,3578,3579
                                    )
GROUP BY OPLDOK.ACC) AMOUNT    ON AMOUNT.ACC = A.ACC
       --- привязываем таблицу с данными по операциям текущие счета <-> касса
       LEFT JOIN  CasheOperGroup ON   CasheOperGroup.ACC_A=A.ACC
 ---  глобальное условие общего селекта
   WHERE
        (A.DAZS IS NULL OR A.DAZS >= D.DAT_START)                                           -- фильтр по дате начала и конца
       AND A.DAOS <= D.DAT_END                                                                       -- дата открытия счета должна быть меньшей или равной конечной дате запроса. Т.е счет должен быть открытым не позже чем в рассматриваемомо периоде
       AND (A.DAZS >= D.DAT_START or A.DAZS is null)                                        -- дата закрытия счета должна быть большей чем начальная дата запроса или пустой. Т.е счет должен быть закрыт в том периоде который анализируется информация или оставаться открытым
       AND (C.CUSTTYPE = 2 OR (C.CUSTTYPE = 3 AND TRIM (C.SED) = '91'))         -- отбираем юр. лиц и физ. лиц - предпринимателей
       AND A.NBS IN                                                                                             -- список высех выбираемых счетов в запросе
                (
                                            2010,2016,2018,2020,2026,2027,2028,2029,2030,2036,2037,2038,2039,2062,2063,2065,2066,2067,2068,2069,
                                            2071,2072,2073,2074,2075,2076,2077,2078,2079,2082,2083,2085,2086,2087,2088,2089,2100,2102,2103,2105,
                                            2106,2107,2108,2109,2110,2112,2113,2115,2116,2117,2118,2119,2122,2123,2125,2126,2127,2128,2129,2132,
                                            2133,2135,2136,2137,2138,2139,2500,2512,2513,2518,2520,2523,2525,2526,2528,2530,2531,2538,2541,2542,
                                            2544,2545,2546,2548,2552,2553,2554,2555,2558,2560,2561,2562,2565,2568,2570,2571,2572,2600,2601,2602,
                                            2603,2604,2605,2606,2607,2608,2610,2611,2615,2616,2617,2618,2640,2641,2642,2643,2650,2651,2652,2653,
                                            2655,2656,2657,2658,2909,3548,3570,3578,3579,3600, 9020,9023,9122,9129,9500,9501,9503,9520,9521,9523, 2903
                 )
);

PROMPT *** Create  grants  V_CCK_ACCOUNTS_DKB ***
grant SELECT                                                                 on V_CCK_ACCOUNTS_DKB to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CCK_ACCOUNTS_DKB to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CCK_ACCOUNTS_DKB.sql =========*** End
PROMPT ===================================================================================== 
