

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F1P_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F1P_NN ***

CREATE OR REPLACE PROCEDURE BARS.P_F1P_NN (dat_      DATE,
                                           sheme_    VARCHAR2 DEFAULT 'D')
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования файла 1P (ПБ-1)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :    03/05/2018 (01/03/2018, 02/02/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
03/05/20`8 - для проводок Дт 1811 Кт 3739 добавлено новое условие для отбора
01/03/2018 - для проводок Дт 100* Кт 3800 будет формироваться код 2343001
02/02/2018 - для проводок Дт 100 Кт 1811 будем изменять код банка (KOD_B)
             заполняем по проводке Дт 1811 Кт 3739
08/06/2017 - добавил parallel (8) для блока заполнения доп.реквизитов
06/06/2017 - изменил VIEW PROVODKI_OTC на OPLDOK для заполнения в OPERW
             доп.параметров KOD_N, KOD_B, KOD_G
25/04/2017 - добавлено обработку поля ID_B из VIEW PROVODKI_OTC
             (во VIEW PROVODKI_OTC добавлено поле ID_B из OPER)
09/12/2016 - для бал.счета 1500 изменяем значение показателя 03 на значение
             показателя 07 (не обрабатываем значение 6, 777)
             и значение 999 изменяем на 6
17/11/2016 - дополнительно выполняется перекодировка для полей NAM_A, NAM_B
16/11/2016 - в наименовании контрагентов изменяем символ '<<' или  '>>'
             на символ '"' т.к. перекодировка в DOS непонятна
22/09/2016 - при списании со счетов '2700','2701','2706','2708','3548',
                                    '3660','3666','3668','1624','1626'
                                    '1628' ,'37397005523','3739401901'
             при дикларировании будут формироваться следующие значения для
             кодов
             03=   6
             04=B
             05=0000032129
             06=АТ "Ощадбанк"
06.09.2016 - убрал перекодировку кода банка из кода для 1-ПБ на код для 1P
05.07.2016 - дополнительно будет выполняться перекодировка кода банка
             по табл. BOPBANK (поле REGNUM_N) для кода 03 и бал.счета 1600
17.06.2016 - для отбора сумм для декларирования расчет эквивалентов
             выполняется по курсу последнего рабочего дня предыдущего мес.
16.06.2016 - для кодов операций 1221,1251,1551,1721,1751 будем заполнять
             код "NNN" - умовний номер для формирования общей суммы по виду
             операции (есть различные коды 99)
15.06.2016 - для суммы показателей 715, 716 будем учитівать 7-и значній
             код назначения из поля "COMM" табл. RNBU_TRACE
07.06.2016 - изменил коды 2312002,2312003 на 2311002,2311003
26.05.2016 - для проводок Дт 1500 Кт 3739 которые декларируются будем
             искать проводкb за этот же день и за следующий
             где Дт 3739 Кт 2600 (2603) - (предложение ГОУ)
21.04.2016 - для коррсчетов будем отбирать банковские металлы
             для бал.счета 1600 всегда формируем показатель 07
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_       VARCHAR2 (2) := '1P';
   kodp_       VARCHAR2 (33);
   b010_       VARCHAR2 (10);
   nnn_        NUMBER;
   nnn1_       NUMBER;
   kol_        NUMBER;
   Dat1_       DATE;
   Dat2_       DATE;
   Datp_       DATE;

   S1_         NUMBER;
   S2_         NUMBER;

   BANK_       VARCHAR2 (4);
   bank_pb1    VARCHAR2 (4);
   KOD7_       VARCHAR2 (7);
   KOD7_N      VARCHAR2 (7);
   kod1_       VARCHAR2 (7);

   COUN_       VARCHAR2 (3);
   kod_g_      VARCHAR2 (3);
   kod_g_pb1   VARCHAR2 (3);
   OPER_       VARCHAR2 (110);
   OPER_99     VARCHAR2 (125);
   comm_       VARCHAR2 (200);
   KOD_        VARCHAR2 (4);
   KOD2_       VARCHAR2 (4);

   KL_         VARCHAR2 (2);

   asp_K_      VARCHAR2 (14);
   asp_N_      VARCHAR2 (38);
   asp_S_      VARCHAR2 (1);

   DECL_       VARCHAR2 (110);
   decl_r040   VARCHAR2 (1);
   sm_         VARCHAR2 (1);
   sNBSk_      VARCHAR2 (2);
   ACC_        INT;
   mfo_g       NUMBER;
   mfou_       NUMBER;
   kor_        VARCHAR2 (4);
   ob22_       VARCHAR2 (2);
   rezid_      NUMBER;
   rezid_o     VARCHAR2 (1);

   tt_         VARCHAR2 (3);
   tt1_        VARCHAR2 (3);
   nlsd1_      VARCHAR2 (15);
   accd1_      NUMBER;
   nlsk1_      VARCHAR2 (15);
   acck1_      NUMBER;
   pr_ob75     NUMBER;
   dat_m37     DATE;
   dat_mmv     DATE;
   ref_m37     NUMBER;
   ref_mmv     NUMBER;
   rnk_        NUMBER;
   nls_        VARCHAR2 (15);
   kv_         NUMBER;
   ref_        NUMBER;
   glb_        NUMBER;
   userid_     NUMBER;
   country_    VARCHAR2 (3);
   nbuc_       VARCHAR2 (20);
   nbuc1_      VARCHAR2 (20);
   typ_        NUMBER;
   nd_         NUMBER;
   znap_       VARCHAR2 (70);
   our_okpo_   Varchar2(10);

   -------------------------------------------------------------------
   -- параметры контрагента
   CURSOR basel
   IS
      SELECT kodp, znap
        FROM (  SELECT DISTINCT r.kodp, r.znap
                  FROM (  SELECT *
                            FROM rnbu_trace
                           WHERE SUBSTR (kodp, 1, 2) IN
                                    ('03', '04', '05', '06', '07', '10', '99')
                        ORDER BY SUBSTR (kodp, 3, 28),
                                 SUBSTR (kodp, 31),
                                 SUBSTR (kodp, 1, 2),
                                 recid) r
              ORDER BY SUBSTR (r.kodp, 3, 28),
                       SUBSTR (r.kodp, 31),
                       SUBSTR (r.kodp, 1, 2));

   -------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (33);
   BEGIN
      l_kodp_ := p_kodp_;

      INSERT INTO rnbu_trace (nls,
                              kv,
                              odate,
                              kodp,
                              znap,
                              REF,
                              rnk,
                              comm,
                              nd,
                              nbuc)
           VALUES (nls_,
                   kv_,
                   dat_,
                   l_kodp_,
                   SUBSTR (p_znap_, 1, 70),
                   ref_,
                   rnk_,
                   comm_,
                   nd_,
                   nbuc_);
   END;

-------------------------------------------------------------------
BEGIN
   COMMIT;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';

   -------------------------------------------------------------------
   logger.info ('P_F1P_NN: Begin for ' || TO_CHAR (Dat_, 'DD/MM/YYYY'));
   -------------------------------------------------------------------

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   -- свой МФО
   mfo_g := f_ourmfo ();

   -- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM BANKS
       WHERE mfo = mfo_g;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_g;
   END;

   -- определяем код области или МФО по коду файла #1P и код формирования
   p_proc_set (kodf_,
               sheme_,
               nbuc1_,
               typ_);
   nbuc_ := nbuc1_;

   bank_pb1 := F_Get_Params ('1_PB', -1);

   -- дата начала периода
   Dat1_ := TRUNC (Dat_, 'MM');

  select max(fdat)
      into Datp_
   from fdat
   where fdat < Dat1_;

   IF mfou_ = 300465 AND mfou_ != mfo_g
   THEN
      FOR k
         IN (SELECT /*+ leading(p.ad) */
                      p.pdat pdat,
                      p.fdat fdat,
                      p.REF REF,
                      p.tt tt,
                      p.accd accd,
                      p.nam_a name_a,
                      p.nlsd nlsd,
                      p.kv kv,
                      p.acck acck,
                      p.nam_b name_b,
                      p.nlsk nlsk,
                      p.nazn nazn,
                      p.ptt tt1
                 FROM provodki_otc p
                WHERE     p.fdat = any(select fdat from fdat where fdat BETWEEN Dat1_ AND Dat_)
                      AND p.kv <> 980
                      AND (p.nlsd LIKE '100%' OR p.nlsk LIKE '100%')
             ORDER BY 1, 2, 3)
      LOOP
         if k.kv NOT IN (959, 961, 962, 964, 980) then
             BEGIN
                INSERT INTO operw (REF, tag, VALUE)
                 VALUES (k.REF, 'KOD_N', '0000000');
             EXCEPTION
                WHEN OTHERS
                THEN
                   NULL;
             END;

             kod_g_ := NULL;
             kod_g_pb1 := NULL;

             FOR z IN (SELECT *
                         FROM operw
                        WHERE REF = k.REF)
             LOOP
                -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
                IF     z.tag LIKE 'n%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 2, 3);
                END IF;

                IF     kod_g_ IS NULL
                   AND z.tag LIKE 'n%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) NOT IN
                          ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 1, 3);
                END IF;

                IF     kod_g_ IS NULL
                   AND z.tag LIKE 'D6#70%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 2, 3);
                END IF;

                IF     kod_g_ IS NULL
                   AND z.tag LIKE 'D6#70%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) NOT IN
                          ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 1, 3);
                END IF;

                IF     kod_g_ IS NULL
                   AND z.tag LIKE 'D6#E2%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 2, 3);
                END IF;

                IF     kod_g_ IS NULL
                   AND z.tag LIKE 'D6#E2%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) NOT IN
                          ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 1, 3);
                END IF;

                IF     kod_g_ IS NULL
                   AND z.tag LIKE 'D1#E9%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 2, 3);
                END IF;

                IF     kod_g_ IS NULL
                   AND z.tag LIKE 'D1#E9%'
                   AND SUBSTR (TRIM (z.VALUE), 1, 1) NOT IN
                          ('O', 'P', 'О', 'П')
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 1, 3);
                END IF;

                IF kod_g_ IS NULL AND z.tag LIKE 'F1%'
                THEN
                   kod_g_ := SUBSTR (TRIM (z.VALUE), 8, 3);
                END IF;

                IF kod_g_ IS NULL AND z.tag = 'KOD_G'
                THEN
                   kod_g_pb1 := SUBSTR (TRIM (z.VALUE), 1, 3);
                END IF;
             END LOOP;

             IF kod_g_ IS NULL AND kod_g_pb1 IS NOT NULL
             THEN
                kod_g_ := kod_g_pb1;
             END IF;

             BEGIN
                INSERT INTO operw (REF, tag, VALUE)
                     VALUES (k.REF, 'KOD_G', kod_g_);
             EXCEPTION
                WHEN OTHERS
                THEN
                   UPDATE operw a
                      SET a.VALUE = kod_g_
                    WHERE a.tag = 'KOD_G' AND a.REF = k.REF;
             END;

             BEGIN
                INSERT INTO operw (REF, tag, VALUE)
                     VALUES (k.REF, 'KOD_B', '000');
             EXCEPTION
                WHEN OTHERS
                THEN
                   NULL;
             END;

             UPDATE operw a
                SET a.VALUE = '804'
              WHERE     a.tag = 'KOD_G'
                    AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) = '000')
                    AND a.REF = k.REF;

             UPDATE operw a
                SET a.VALUE = '6'
              WHERE     a.tag = 'KOD_B'
                    AND (   TRIM (a.VALUE) IS NULL
                         OR TRIM (a.VALUE) = '000'
                         OR TRIM (a.VALUE) = '4'
                         OR TRIM (a.VALUE) = '25')
                    AND a.REF = k.REF;
         end if;
      END LOOP;

      FOR k
         IN (  SELECT /*+parallel (8) */
                      p.pdat pdat,
                      od.fdat fdat,
                      od.REF REF,
                      decode(od.dk, 0, od.tt, ok.tt) tt,
                      od.acc accd,
                      p.nam_a name_a,
                      ad.nls nlsd,
                      p.kv kv,
                      ak.acc acck,
                      p.nam_b name_b,
                      ak.nls nlsk,
                      p.nazn nazn,
                      p.tt tt1,
                      p.s s
               from opldok od, accounts ad, opldok ok, accounts ak, oper p
               where od.fdat between dat1_ and dat_ and
                     od.acc = ad.acc and
                     od.DK = 0 and
                     ( regexp_like(ad.NLS,'^(100)') OR regexp_like(ak.NLS,'^(100)') ) and
                     --(ad.nls LIKE '100%' OR ak.nls LIKE '100%')and
                     ad.kv not like '980%' and
                     od.ref = ok.ref and
                     od.stmt = ok.stmt and
                     ok.fdat between dat1_ and dat_ and
                     ok.acc = ak.acc and
                     ok.DK = 1 and
                     od.ref = p.ref and
                     p.sos = 5
            )

      LOOP

         BEGIN
            SELECT SUBSTR (TRIM (VALUE), 1, 1)
              INTO rezid_o
              FROM operw
             WHERE REF = k.REF AND tag LIKE 'REZID%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               rezid_o := '1';
         END;

         rezid_ := 1;

         IF k.nlsd NOT LIKE '100%'
         THEN
            BEGIN
               SELECT NVL (TRIM (i.ob22), '00'), 2 - MOD (c.codcagent, 2)
                 INTO ob22_, rezid_
                 FROM specparam_int i, accounts a, customer c
                WHERE i.acc = k.accd AND i.acc = a.acc AND a.rnk = c.rnk;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  ob22_ := '00';
                  rezid_ := 1;
            END;
         ELSE
            BEGIN
               SELECT NVL (TRIM (i.ob22), '00'), 2 - MOD (c.codcagent, 2)
                 INTO ob22_, rezid_
                 FROM specparam_int i, accounts a, customer c
                WHERE i.acc = k.acck AND i.acc = a.acc AND a.rnk = c.rnk;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  ob22_ := '00';
                  rezid_ := 1;
            END;
         END IF;

         nlsd1_ := k.nlsd;
         nlsk1_ := k.nlsk;
         tt_ := NULL;
         pr_ob75 := 0;

         -- 02.01.2013 по счету 2909 и OB22='75' будем формировать код 8428001
         -- кошти для виплати за системними переказами фiзичних осiб в iноземнiй валютi
         IF k.nlsd LIKE '2909%' AND k.nlsk LIKE '100%' AND ob22_ IN ('75')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано на вiдрядження
         IF     k.nlsd LIKE '2600%'
            AND k.name_a NOT LIKE '%' || UPPER ('Укрпошт') || '%'
            AND k.name_a NOT LIKE '%УДППЗ%'
            AND k.name_a NOT LIKE '%ЦПЗ%' --По просьбе Максименко добавлено ЦПЗ
            AND k.nlsk LIKE '100%'
            AND UPPER (k.nazn) NOT LIKE
                   '%' || UPPER ('Укрпошт') || '%'
         THEN
            UPDATE operw a
               SET a.VALUE = '2311002'
             WHERE     a.tag = 'KOD_N'
                   AND (   TRIM (a.VALUE) IS NULL
                        OR TRIM (a.VALUE) = '0000000'
                        OR TRIM (a.VALUE) <> '2311002') --По просьбе Максименко принудительное проставление--<>'2311002')
                   AND a.REF = k.REF;
         END IF;

         -- повернення вiдрядження
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2600%'
            AND k.name_b NOT LIKE '%' || UPPER ('Укрпошт') || '%'
            AND k.name_b NOT LIKE '%УДППЗ%'
            AND k.name_b NOT LIKE '%ЦПЗ%' --По просьбе Максименко добавлено ЦПЗ
            AND UPPER (k.nazn) NOT LIKE
                   '%' || UPPER ('Укрпошт') || '%'
         THEN
            UPDATE operw a
               SET a.VALUE = '2311003'
             WHERE     a.tag = 'KOD_N'
                   AND (   TRIM (a.VALUE) IS NULL
                        OR TRIM (a.VALUE) = '0000000'
                        OR TRIM (a.VALUE) <> '2311003') --По просьбе Максименко принудительное проставление--<>'2311003')
                   AND a.REF = k.REF;
         END IF;

         -- видано з рах.юр.осiб (Укрпошта)
         IF     k.nlsd LIKE '2600%'
            AND k.nlsk LIKE '100%'
            AND (   k.name_a LIKE '%' || UPPER ('Укрпошт') || '%'
                 OR k.name_a LIKE '%УДППЗ%'
                 OR k.name_a LIKE '%ЦПЗ%' --По просьбе Максименко добавлено ЦПЗ
                 OR UPPER (k.nazn) LIKE
                       '%' || UPPER ('Укрпошт') || '%')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446015' --По просьбе Максименко с 8446023 на 8446015
             WHERE     a.tag = 'KOD_N'
                   AND (   TRIM (a.VALUE) IS NULL
                        OR TRIM (a.VALUE) = '0000000'
                        OR TRIM (a.VALUE) <> '8446015') --По просьбе Максименко принудительное проставление--<>'8446023')
                   AND a.REF = k.REF;
         END IF;

         -- видано на вiдрядження
         IF     k.nlsd LIKE '2600%'
            AND k.nlsk LIKE '100%'
            AND (   k.name_a LIKE '%' || UPPER ('Укрпошт') || '%'
                 OR k.name_a LIKE '%УДППЗ%'
                 OR k.name_a LIKE '%ЦПЗ%') --По просьбе Максименко добавлено ЦПЗ
            AND LOWER (k.nazn) LIKE '%в_дрядження%'
         THEN
            UPDATE operw a
               SET a.VALUE = '2311002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '2311002') --<>'2311002')
                   AND a.REF = k.REF;
         END IF;

         -- видано підкріплень (Укрпошта)
         IF     k.nlsd LIKE '2600%'
            AND k.nlsk LIKE '100%'
            AND (   k.name_a LIKE '%' || UPPER ('Укрпошт') || '%'
                 OR k.name_a LIKE '%УДППЗ%'
                 OR k.name_a LIKE '%ЦПЗ%' --По просьбе Максименко добавлено ЦПЗ
                 OR LOWER (k.nazn) LIKE '%видача п_дкр_плень%')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446015' --По просьбе Максименко с 8446018 на 8446015
             WHERE     a.tag = 'KOD_N'
                   AND (   TRIM (a.VALUE) IS NULL
                        OR TRIM (a.VALUE) = '0000000'
                        OR TRIM (a.VALUE) <> '8446015') --По просьбе Максименко принудительное проставление--<>'8446018')
                   AND a.REF = k.REF;
         END IF;

         -- видача по чеку інвалюти
         IF     SUBSTR (k.nlsd, 1, 4) IN ('2600', '2604')
            AND k.nlsk LIKE '100%'
            AND k.tt IN ('065', '067', '00H', '00F')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446008'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) = '0000000') --<>'8446008')
                   AND a.REF = k.REF;

            UPDATE operw a
               SET a.VALUE = '804'
             WHERE     a.tag = 'KOD_G'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) = '000') --<>'804')
                   AND a.REF = k.REF;

            UPDATE operw a
               SET a.VALUE = '6'
             WHERE     a.tag = 'KOD_B'
                   AND (   TRIM (a.VALUE) IS NULL
                        OR TRIM (a.VALUE) IN ('0', '000'))            --<>'4')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято на рах.юр.осiб (Укрпошта)
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2600%'
            AND (   k.name_b LIKE '%' || UPPER ('Укрпошт') || '%'
                 OR k.name_b LIKE '%УДППЗ%'
                 OR k.name_b LIKE '%ЦПЗ%' --По просьбе Максименко добавлено ЦПЗ
                 OR UPPER (k.nazn) LIKE
                       '%' || UPPER ('Укрпошт') || '%')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446014' --По просьбе Максименко с 8446022 на 8446014
             WHERE     a.tag = 'KOD_N'
                   AND (   TRIM (a.VALUE) IS NULL
                        OR TRIM (a.VALUE) = '0000000'
                        OR TRIM (a.VALUE) <> '8446014') --По просьбе Максименко принудительное проставление<>'8446022')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято (повернення) підкріпленя (Укрпошта)
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2600%'
            AND (   k.name_b LIKE '%' || UPPER ('Укрпошт') || '%'
                 OR k.name_b LIKE '%' || UPPER ('УДППЗ') || '%'
                 OR k.name_b LIKE '%' || UPPER ('ЦПЗ') || '%' --По просьбе Максименко добавлено ЦПЗ
                 OR LOWER (k.nazn) LIKE '%п_дкр_плен_%')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446017'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) = '0000000') --<>'8446017')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято на рах.юр.осiб
         IF     k.nlsd LIKE '100%'
            AND SUBSTR (k.nlsk, 1, 4) IN ('2600', '2603', '2604')
            AND LOWER (k.nazn) LIKE
                   '%внесення гот_вки на рахунки юо%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446017'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446017')
                   AND a.REF = k.REF;
         END IF;

         -- купiвля валюти
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '3800%'
            AND ob22_ IN ('07', '10')
            AND k.tt = k.tt1
         THEN
            UPDATE operw a
               SET a.VALUE = '2343001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '2343001')
                   AND a.REF = k.REF;
         END IF;
         -------------------------------------------------------------------------
         -- Викуп нерозмiнного залишку
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '3800%'
            AND ob22_ = '03'
            AND k.tt = k.tt1
            AND (   LOWER (k.nazn) LIKE
                       '%викуп нер_зм_нного залишку%'
                 OR LOWER (k.nazn) LIKE
                       '%викуп нер_зм_нно_ частини%')
         THEN
            UPDATE operw a
               SET a.VALUE = '2343001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '2343001')
                   AND a.REF = k.REF;
         END IF;
         -------------------------------------------------------------------------
         -- Оприбуткування надлишків
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '3800%'
            AND ob22_ = '03'
            AND k.tt = k.tt1
            AND LOWER (k.nazn) LIKE
                   '%оприбуткування надлишк_в%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446012'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446012')
                   AND a.REF = k.REF;
         END IF;

         -------------------------------------------------------------------------
         -- видано з рах. нерезидентiв
         IF k.nlsd LIKE '2620%' AND k.nlsk LIKE '100%' AND ob22_ = '05'
         THEN
            UPDATE operw a
               SET a.VALUE = '8427002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8427002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято на з рах. нерезидентiв
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2620%' AND ob22_ = '05'
         THEN
            UPDATE operw a
               SET a.VALUE = '8427001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8427001')
                   AND a.REF = k.REF;
         END IF;

         -- iншi казначейськi зобовязання
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2901%' AND ob22_ = '13'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446022'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446022')
                   AND a.REF = k.REF;
         END IF;

         -- виплачено iншi казначейськi зобовязання
         IF k.nlsd LIKE '2901%' AND ob22_ = '13' AND k.nlsk LIKE '100%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446023'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446023')
                   AND a.REF = k.REF;
         END IF;

         -- виплачено iншi казначейськi зобовязання
         IF     k.nlsd LIKE '2801%'
            AND ob22_ IN ('02', '03', '04')
            AND k.nlsk LIKE '100%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446023'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446023')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом WU
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ = '27'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом WU
         IF k.nlsd LIKE '2909%' AND k.nlsk LIKE '100%' AND ob22_ = '27'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом WU
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '15'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом BLIZKO
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ = '58'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'                             --'8428006'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за звичайним переказом BLIZKO
         IF k.nlsd LIKE '2909%' AND k.nlsk LIKE '100%' AND ob22_ = '58'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом BLIZKO
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '23'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом MIGOM
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ = '40'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'                             --'8428005'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом MIGOM
         IF k.nlsd LIKE '2909%' AND k.nlsk LIKE '100%' AND ob22_ = '40'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'                             --'8428004'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом Xpress Money (XM)
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ = '41'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом Xpress Money (XM)
         IF k.nlsd LIKE '2909%' AND k.nlsk LIKE '100%' AND ob22_ = '41'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готывку за перказом MIGOM
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2809%'
            AND ob22_ = '17'
            AND k.tt = k.tt1
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готівку за переказом MIGOM
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '17'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом TRAVELEX(COINSTAR)
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ = '46'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом TRAVELEX(COINSTAR)
         IF k.nlsd LIKE '2909%' AND k.nlsk LIKE '100%' AND ob22_ = '46'
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом TRAVELEX(COINSTAR)
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '20'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом Xpress Money (XM)
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '18'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом INTER EXPRES
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '19'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом Money Gram
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '30'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+Глобал Мані
         -- 12.02.2014 видано готiвку за переказом Анелик OB22='35'
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ IN ('32', '33', '34', '31', '35')
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+RIA+Глобал Мані
         -- 12.02.2014 прийнято готiвку за переказом Анелик OB22='35'
         -- 01.10.2015 прийнято готiвку за переказом Золота корона OB22='36'
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2809%'
            AND ob22_ IN ('32', '33', '34', '28', '31', '35', '36')
            AND k.tt = k.tt1
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом RIA
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '28'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом INTER EXPRES
         IF     k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ = '42'
            AND k.tt = k.tt1
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом VIGO
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ = '16'
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом INTER EXPRES
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2909%'
            AND ob22_ = '42'
            AND k.tt = k.tt1
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом Швидка копiйка+Контакт
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2909%'
            AND ob22_ IN ('60', '64')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом UNISTREAM + Золота корона
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2909%'
            AND ob22_ IN ('69', '79')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом Швидка копiйка+Контакт
         IF     k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('60', '64')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом UNISTREAM + Золота корона
         IF     k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('69', '79')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом (24 - Швидка копійка, 27 - Контакт)
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ IN ('24', '27')
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом UNISTREAM + Золота корона
         IF     nlsd1_ LIKE '2809%'
            AND nlsk1_ LIKE '100%'
            AND ob22_ IN ('29', '36')
            AND (k.tt = k.tt1 OR tt_ IS NOT NULL)
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом Money Gram
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ IN ('70')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом Money Gram
         IF     k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('70')
            AND k.tt = k.tt1
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+RIA+VIGO OB22='75'
         -- 12.02.2014 прийнято готiвку за переказом Анелик OB22='76'
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2909%'
            AND ob22_ IN ('72', '73', '74', '75', '65', '31', '76')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428001')
                   AND a.REF = k.REF;
         END IF;

         -- видано готiвку за переказом Лидер+Хазри+ИНТЕЛЄКСПРЕСС+RIA+VIGO
         -- 03.12.2012 по счету 2909 и OB22='19' будем формировать код 8428001
         -- 02.01.2013 по счету 2909 и OB22='75' будем формировать код 8428001
         -- 12.02.2014 по счету 2909 и OB22='76' (Анелик) будем формировать код 8428001
         IF     k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('19', '72', '73', '74', '65', '31', '76')
            AND k.tt = k.tt1
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- 02.01.2013 по счету 2909 и OB22='75' будем формировать код 8428001
         -- кошти для виплати за системними переказами фiзичних осiб в iноземнiй валютi
         IF     pr_ob75 = 0
            AND k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('75')
         THEN
            UPDATE operw a
               SET a.VALUE = '8428002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8428002')
                   AND a.REF = k.REF;
         END IF;

         -- продаж валюти
         IF     k.nlsd LIKE '3800%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('07', '10')
         THEN
            UPDATE operw a
               SET a.VALUE = '2343001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '2343001')
                   AND a.REF = k.REF;
         END IF;

         IF     k.tt = 'МГР'
            AND (   LOWER (k.nazn) LIKE 'видан%'
                 OR LOWER (k.nazn) LIKE 'передан%')
            AND k.nlsd LIKE '3800%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('07', '10')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446012'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446012')
                   AND a.REF = k.REF;
         END IF;

         IF     k.tt NOT IN ('МГР')
            AND (   LOWER (k.nazn) LIKE 'видан%'
                 OR LOWER (k.nazn) LIKE 'передан%'
                 OR LOWER (k.nazn) LIKE 'п_дкр_плення%'
                 OR LOWER (k.nazn) LIKE 'видан_%'
                 OR LOWER (k.nazn) LIKE 'в_везення%'
                 OR LOWER (k.nazn) LIKE 'вид. _нв%'
                 OR LOWER (k.nazn) LIKE 'п_дкр_пл.%')
            AND k.nlsd LIKE '3800%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('03', '07', '10')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446012'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446012')
                   AND a.REF = k.REF;
         END IF;

         -- куплено IВ у iншого банку-резидента
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '1811%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8445002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8445002')
                   AND a.REF = k.REF;

            -- определяем код банка по проводке Дт 1811 Кт 3739 в этот же день
            begin
               select trim(w.value)
                  into bank_
               from provodki_otc o, operw w
               where o.fdat = k.fdat
                 and o.nlsd like k.nlsk || '%'
                 and o.nlsk like '3739%'
                 and o.kv = k.kv 
                 and o.s*100 = k.s
                 and o.ref = w.ref(+)
                 and w.tag(+) like 'KOD_B%'
                 and instr(k.nazn, substr(o.nazn, instr(o.nazn, 'ТТ')+2,3)) > 0;

               UPDATE operw a
                  SET a.VALUE = bank_
                WHERE  a.tag = 'KOD_B'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> bank_)
                   AND a.REF = k.REF;
            exception when no_data_found then
               null;
            end;

         END IF;

         -- куплено IВ у iншого банку-резидента
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2809%' AND ob22_ IN ('13')
         THEN
            UPDATE operw a
               SET a.VALUE = '8445002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8445002')
                   AND a.REF = k.REF;
         END IF;

         -- продано IВ iншому банку-резиденту
         IF k.nlsd LIKE '1811%' AND k.nlsk LIKE '100%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8445001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8445001')
                   AND a.REF = k.REF;
         END IF;

         IF     k.nlsd LIKE '1911%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('00', '01')
         THEN
            UPDATE operw a
               SET a.VALUE = '8445001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8445001')
                   AND a.REF = k.REF;
         END IF;

         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '1911%'
            AND ob22_ IN ('00', '01')
         THEN
            UPDATE operw a
               SET a.VALUE = '8445002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8445002')
                   AND a.REF = k.REF;

            UPDATE operw a
               SET a.VALUE = '804'
             WHERE     a.tag = 'KOD_G'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '804')
                   AND a.REF = k.REF;
         END IF;

         -- зарахування на вклад
         IF     k.nlsd LIKE '100%'
            AND SUBSTR (k.nlsk, 1, 4) IN ('2620', '2625', '2630', '2635')
         THEN
            IF rezid_o = 1
            THEN
               UPDATE operw a
                  SET a.VALUE = '8446001'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8446001')
                      AND a.REF = k.REF;
            ELSE
               UPDATE operw a
                  SET a.VALUE = '8427001'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427001')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2809%'
            AND ob22_ IN ('09')
            AND LOWER (k.nazn) LIKE '%вкладные операции%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446001')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427001'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427001')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2909%'
            AND ob22_ IN ('18')
            AND LOWER (k.nazn) LIKE '%поповнення депоз%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446001'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446001')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427001'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427001')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- видача зi вкладу
         IF     SUBSTR (k.nlsd, 1, 4) IN
                   ('2620', '2625', '2630', '2635', '3500')
            AND k.nlsk LIKE '100%'
         THEN
            IF rezid_o = 1
            THEN
               UPDATE operw a
                  SET a.VALUE = '8446002'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8446002')
                      AND a.REF = k.REF;
            ELSE
               UPDATE operw a
                  SET a.VALUE = '8427002'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427002')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         IF nlsd1_ LIKE '2809%' AND nlsk1_ LIKE '100%' AND ob22_ IN ('09')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446002'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446002')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427004'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427004')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- прийнято готiвку за звичайним переказом
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ = '35'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446003'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446003')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427003'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427003')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- видано готiвку за звичайним переказом
         IF     k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('11', '24', '35', '55', '56')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446004'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446004')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427004'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427004')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- прийнято готiвку за звичайним переказом
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2909%'
            AND ob22_ IN ('11', '24', '35', '55', '56')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446003'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446003')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427003'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427003')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- прийнято на карт.рах-2924
         IF k.nlsd LIKE '100%' AND SUBSTR (k.nlsk, 1, 4) IN ('2924', '2625')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446005'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446005')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427005'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427005')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- видано з карт.рах-2924
         IF SUBSTR (k.nlsd, 1, 4) IN ('2924', '2625') AND k.nlsk LIKE '100%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446006'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446006')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427006'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427006')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- внутрiшньосистемнi операцii
         IF     k.nlsd LIKE '100%'
            AND SUBSTR (k.nlsk, 1, 4) IN
                   ('1001', '1002', '1003', '1007', '3906', '3907')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446012'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446012')
                   AND a.REF = k.REF;
         END IF;

         IF     SUBSTR (k.nlsd, 1, 4) IN
                   ('1001', '1002', '1003', '1007', '3906', '3907')
            AND k.nlsk LIKE '100%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446012'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446012')
                   AND a.REF = k.REF;
         END IF;

         -- внутрiшньосистемнi операцii
         IF k.nlsd LIKE '1007%' AND k.nlsk LIKE '1001%' and 
            LOWER (k.nazn) like '%видача гот_вки%через представника%'    
         THEN
            -- заміна коду банка із проводки Дт 1911 Кт 1007
            begin
               select trim(w.value)
                  into bank_
               from provodki_otc o, operw w
               where o.fdat = k.fdat
                 and o.nlsd like '1911%' 
                 and o.nlsk like k.nlsd || '%'
                 and o.s*100 = k.s
                 and o.ref = w.ref(+)
                 and w.tag(+) like 'KOD_B%';

               UPDATE operw a
                  SET a.VALUE = bank_
                WHERE  a.tag = 'KOD_B'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> bank_)
                   AND a.REF = k.REF;
            exception when no_data_found then
               null;
            end;
         END IF;

         -- прийнято за чеки
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '1919%' AND ob22_ = '01'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446007'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446007')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427007'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427007')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '2909%' AND ob22_ = '36'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446007'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446007')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427007'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427007')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- оплачено дорожнi чеки
         IF k.nlsd LIKE '1819%' AND k.nlsk LIKE '100%' AND ob22_ = '01'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446008'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446008')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427008'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427008')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         IF k.nlsd LIKE '2909%' AND k.nlsk LIKE '100%' AND ob22_ = '36'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446008'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446008')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427008'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427008')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         IF     k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ = '19'
            AND LOWER (k.nazn) LIKE '%чек%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446008'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446008')
                   AND a.REF = k.REF;

            IF rezid_o = '2'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8427008'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8427008')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- конверсiя валюти
         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '3800%' AND ob22_ = '07'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446016'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446016')
                   AND a.REF = k.REF;
         END IF;

         IF k.nlsd LIKE '3800%' AND k.nlsk LIKE '100%' AND ob22_ = '07'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446016'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446016')
                   AND a.REF = k.REF;
         END IF;

         -- комiсiя ОБУ
         IF     k.nlsd LIKE '100%'
            AND k.nlsk LIKE '3800%'
            AND ob22_ = '03'
            AND (   LOWER (k.nazn) LIKE '%ком_с_я%'
                 OR LOWER (k.nazn) LIKE '%коммисия'
                 OR LOWER (k.nazn) LIKE '%комисия')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446009'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446009')
                   AND a.REF = k.REF;
         END IF;

         -- заставнi + iнкасо (iншi надходження)
         IF     k.tt = k.tt1
            AND k.nlsd LIKE '100%'
            AND k.nlsk LIKE '2909%'
            AND ob22_ IN ('19', '34')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446017'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446017')
                   AND a.REF = k.REF;
         END IF;

         IF k.nlsd LIKE '100%' AND k.nlsk LIKE '3552%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446017'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446017')
                   AND a.REF = k.REF;
         END IF;

         -- заставнi+iнкасо+%% по вкладам (iншi видатки)
         -- 03.12.2012 по счету 2909 и OB22='19' будем формировать код 8428001
         IF     k.tt = k.tt1
            AND k.nlsd LIKE '2909%'
            AND k.nlsk LIKE '100%'
            AND ob22_ IN ('34')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446018'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446018')
                   AND a.REF = k.REF;
         END IF;

         IF     k.tt = k.tt1
            AND SUBSTR (k.nlsd, 1, 4) IN ('2628', '2638', '3500', '3552')
            AND k.nlsk LIKE '100%'
         THEN
            UPDATE operw a
               SET a.VALUE = '8446018'
             WHERE     a.tag = 'KOD_N'
                   AND (TRIM (a.VALUE) IS NULL OR TRIM (a.VALUE) <> '8446018')
                   AND a.REF = k.REF;
         END IF;

         -- прийнято IВ вiд ФО для погашення кредитiв та %%
         IF     k.nlsd LIKE '100%'
            AND (   SUBSTR (k.nlsk, 1, 3) IN
                       ('206', '207', '220', '221', '223')
                 OR SUBSTR (k.nlsk, 1, 4) IN
                       ('2290', '2480', '3578', '3579', '3600', '3739'))
         THEN
            IF    UPPER (k.nazn) LIKE
                     '%' || UPPER ('Розгорнен') || '%'
               OR UPPER (k.nazn) LIKE
                     '%' || UPPER ('Розгортан') || '%'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8446010'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8446010')
                      AND a.REF = k.REF;
            ELSE
               UPDATE operw a
                  SET a.VALUE = '8446021'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8446021')
                      AND a.REF = k.REF;
            END IF;

            IF k.tt IN ('024') AND k.nlsk LIKE '3739%'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8446010'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8446010')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- видано IВ ФО з каси уповноваженого банку як кредит
         IF     (   SUBSTR (k.nlsd, 1, 3) IN
                       ('206', '207', '220', '221', '223')
                 OR SUBSTR (k.nlsd, 1, 4) IN
                       ('2290', '2480', '3578', '3579', '3600', '3739'))
            AND k.nlsk LIKE '100%'
         THEN
            IF    UPPER (k.nazn) LIKE '%' || UPPER ('Згорнен') || '%'
               OR UPPER (k.nazn) LIKE '%' || UPPER ('Згортан') || '%'
            THEN
               UPDATE operw a
                  SET a.VALUE = '8446010'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8446010')
                      AND a.REF = k.REF;
            ELSE
               UPDATE operw a
                  SET a.VALUE = '8446021'
                WHERE     a.tag = 'KOD_N'
                      AND (   TRIM (a.VALUE) IS NULL
                           OR TRIM (a.VALUE) <> '8446021')
                      AND a.REF = k.REF;
            END IF;
         END IF;

         -- анулювання відкликааня переказів в IВ
         IF     (k.nlsd LIKE '2809%' OR k.nlsd LIKE '2909%')
            AND k.nlsk LIKE '100%'
            AND k.tt IN ('M37', 'MMV', 'CN3', 'CN4')
         THEN
            UPDATE operw a
               SET a.VALUE = '8446018'
             WHERE     a.tag = 'KOD_N'
                   AND (a.VALUE IS NULL OR a.VALUE NOT LIKE '8446018%')
                   AND a.REF = k.REF;

            BEGIN
               SELECT TRIM (w.VALUE),
                      TO_DATE (
                         SUBSTR (
                            REPLACE (REPLACE (TRIM (w1.VALUE), ',', '/'),
                                     '.',
                                     '/'),
                            1,
                            10),
                         'dd/mm/yyyy')
                 INTO ref_m37, dat_m37
                 FROM operw w, operw w1
                WHERE     w.REF = k.REF
                      AND (w.tag LIKE 'D_REF%' OR w.tag LIKE 'REFT%')
                      AND w1.REF = k.REF
                      AND (w1.tag LIKE 'D_1PB%' OR w1.tag LIKE 'DATT%');

               BEGIN
                  SELECT REF, fdat
                    INTO ref_mmv, dat_mmv
                    FROM provodki_otc
                   WHERE     REF = ref_m37
                         and fdat = any(select fdat from fdat where fdat BETWEEN Dat1_ AND Dat_+3) 
                         AND kv = k.kv
                         AND nlsd = k.nlsk
                         AND ROWNUM = 1;

                  IF TO_CHAR (k.fdat, 'MM') = TO_CHAR (dat_mmv, 'MM')
                  THEN
                     UPDATE operw
                        SET VALUE = '0000000'
                      WHERE REF = ref_m37 AND tag LIKE 'KOD_N%';

                     UPDATE operw
                        SET VALUE = '0000000'
                      WHERE REF = k.REF AND tag LIKE 'KOD_N%';
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               END;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
               WHEN OTHERS
               THEN
                  raise_application_error (
                     -20000,
                        'Помилка для РЕФ = '
                     || TO_CHAR (k.REF)
                     || ': перевірте доп.реквізити D_1PB(DATT) та D_REF(REFT)! '
                     || SQLERRM);
            END;
         END IF;
      END LOOP;
   END IF;

   --our_okpo_ := SUBSTR (LPAD (f_get_params ('OUR_TOBO', NULL), 10, '0'), -10);
   our_okpo_ := SUBSTR (LPAD (f_get_params ('OKPO', NULL), 10, '0'), -10);

   gl.param;

   IF gl.AMFO = '300001'
   THEN
      KL_ := '35';
   ELSE
      KL_ := '26';
   END IF;

   BEGIN
      SELECT NVL (rc.GLB, 0)
        INTO glb_
        FROM rcukru rc
       WHERE rc.mfo = mfou_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         glb_ := 999;
   END;

   nnn1_ := 0;
   nnn_ := 0;

   FOR g
      IN (SELECT DECODE (a.kv,
                         810, DECODE (a.pos, 2, ' N  ', ' K  '),
                         '    ')
                    KOR,
                 t.KV KV,
                 a.ACC ACC,
                 DECODE (a.pap, 1, 'N', 'L') LN,
                 DECODE (c.custtype,
                         1, 'B',
                         2, 'U',
                         DECODE (c.sed, '91', 'S', 'F'))
                    TK,
                 c.rnk RNK,
                 LPAD (TRIM (c.okpo), 10, '0') OKPO,
                 c.country COUNTRY,
                 SUBSTR (replace(replace(c.nmk, chr(171),'"'),chr(187),'"'), 1, 47) NMK,
                 t.LCV LCV,
                 a.NLS NLS,
                 NVL (fost (a.acc, dat_), 0) S2
            FROM accounts a, customer c, tabval t
           WHERE     (   (    a.nbs IN ('1500', '1505', '1600', '1605')
                          AND gl.AMFO <> 300001)
                      OR (    a.nbs IN ('1201', '1202', '1221', '3201')
                          AND gl.AMFO = 300001))
                 AND a.rnk = c.rnk
                 AND a.kv = t.kv
                 AND (c.codcagent = 2 OR c.rnk = 4001 AND gl.AMFO = 300001)
                 AND c.codcagent = 2
                 AND (a.dazs IS NULL OR a.dazs > dat1_)
          UNION ALL
          SELECT 'к  ',
                 t.kv,
                 a.acc,
                 'N' LN,
                 'U' TK,
                 c.rnk,
                 LPAD (TRIM (c.okpo), 10, '0') OKPO,
                 t.country,
                 'ГОТІВКА',
                 t.lcv,
                 a.nls,
                 NVL (fost (a.acc, dat_), 0)
            FROM accounts a, tabval t, customer c
           WHERE     (   (    a.nbs IN ('1001', '1002', '1003', '1007')
                          AND gl.AMFO <> 300001)
                      OR (a.nbs IN ('1011') AND gl.AMFO = 300001))
                 AND a.rnk = c.rnk
                 AND a.kv = t.kv
                 AND t.kv NOT IN (980)  --959, 961, 962, 964,
                 AND (a.dazs IS NULL OR a.dazs > dat1_))
   LOOP
      kor_ := g.KOR;
      rnk_ := g.rnk;
      nls_ := g.nls;
      kv_ := g.kv;
      country_ := LPAD (g.country, 3, '0');

      IF g.nls LIKE '100%'
      THEN
         b010_ := '0000000000';

         IF kv_ = 978
         THEN
            country_ := '000';
         END IF;
      ELSE
         b010_ := 'XXXXXXXXXX';

         -- для банк?в нерезидент?в
         BEGIN
            SELECT NVL (SUBSTR (cb.alt_bic, 1, 10), b010_)
              INTO b010_
              FROM custbank cb
             WHERE cb.rnk = g.rnk;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;

      FOR k
         IN (  SELECT /*+ index(o, IDX_OPLDOK_KF_FDAT_ACC) */
                      o.REF,
                      o.TT TT,
                      o.FDAT,
                      o.DK,
                      o.S,
                      p.TT TT1,
                      p.NLSA,
                      p.NLSB,
                      p.nazn,
                      P.MFOA,
                      P.MFOB,
                      DECODE (P.MFOA, gl.amfo, P.ID_B, p.ID_A) ASP_K,
                      DECODE (P.MFOA, gl.amfo, replace(replace(p.nam_b, chr(171),'"'),chr(187),'"'),
                                               replace(replace(p.nam_a, chr(171),'"'),chr(187),'"') ) ASP_N,
                      DECODE (o.dk, 0, '6', '5') kod_e,
                      p.kv,
                      p.vdat,
                      p.tt ptt
                 FROM opldok o, oper p
                WHERE     o.tt NOT IN ('BAK')
                      AND o.acc = g.ACC
                      AND o.REF = p.REF
                      AND p.sos = 5
                      AND o.fdat BETWEEN Dat1_ AND Dat_
                      AND o.S <> 0
             ORDER BY 3, 1)
      LOOP
         nd_ := 0;
         --курсор по документам
         kod7_ := SUBSTR (F_dop (k.REF, 'KOD_N'), 1, 7);
         BANK_ := SUBSTR (F_dop (k.REF, 'KOD_B'), 1, 4);
         coun_ := LPAD (SUBSTR (F_dop (k.REF, 'KOD_G'), 1, 3), 3, '0'); --SUBSTR(F_dop(k.REF,'KOD_G'),1,3);

         IF     ASCII (SUBSTR (coun_, 1, 1)) >= 48
            AND ASCII (SUBSTR (coun_, 1, 1)) <= 57
         THEN
            BEGIN
               SELECT NVL (ISO_COUNTR, 'EUZ')
                 INTO coun_
                 FROM bopcount
                WHERE TRIM (kodc) = TRIM (coun_); --to_number(kodc)=to_number(coun_);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  coun_ := 'EUZ';
            END;
         END IF;

         IF coun_ IS NULL
         THEN
            coun_ := '000';
         ELSE
            coun_ := LPAD (coun_, 3, '0');
         END IF;

         IF kod7_ IS NULL
         THEN
            kod7_ := '0000000';
         END IF;

         IF k.tt IN ('VPF', 'MVQ', 'MUQ')
         THEN
            BEGIN
               SELECT substr(TRIM (VALUE), 1, 7)
                 INTO kod1_
                 FROM operw
                WHERE REF = k.REF AND tag = '73' || k.tt;

               IF kod1_ = '261'
               THEN
                  kod7_ := '2343001';
                  bank_ := '    ';
                  coun_ := '804';
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;

         if k.ptt = '045' then
            if k.kv = 978 then
               coun_ := '000';
            else
                begin
                    select max(nvl(trim(k040), '000'))
                    into coun_
                    from kl_r030
                    where d_open <= k.fdat and
                         (d_close is null or d_close > k.fdat) and
                          r030 = lpad(k.kv, 3, '0');
                exception
                    when no_data_found then
                        null;
                end;
            end if;
         end if;

         IF mfou_ = 300465 AND k.tt IN ('151') AND kod7_ <> '8446018'
         THEN
            kod7_ := '8446018';
            bank_ := '6';
            coun_ := '804';
         END IF;

         --- OAB 22.09.2015
         IF     mfou_ = 300465
            AND SUBSTR (kod7_, 1, 4) IN
                   ('8442', '8443', '8444', '8445', '8446')
         THEN
            IF SUBSTR (kod7_, 1, 4) NOT IN ('8443', '8444', '8445')
            THEN
               bank_ := '6';
            END IF;

            coun_ := '804';
         END IF;

         --- OAB 03.02.2005
         IF     mfou_ <> 300465
            AND SUBSTR (kod7_, 1, 4) IN ('2314', '2343', '2344')
         THEN
            bank_ := '    ';
         END IF;

         IF ASCII (SUBSTR (UPPER (coun_), 1, 1)) > 64
         THEN
            BEGIN
               SELECT NVL (kodc, '000')
                 INTO coun_
                 FROM bopcount
                WHERE TRIM (iso_countr) = TRIM (UPPER (coun_));
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  coun_ := '000';
            END;
         END IF;

         IF gl.amfo = 300001
         THEN
            OPER_ := SUBSTR (k.nazn, 1, 60);
         ELSE
            BEGIN
               SELECT transdesc, NVL (transcode_n, '0')
                 INTO OPER_, kod7_n
                 FROM bopcode
                WHERE transcode = kod7_ AND ROWNUM = 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  OPER_ := '???';
                  kod7_n := '0';
            END;
         END IF;

         IF kod7_n <> '0'
         THEN
            kod7_ := kod7_n;
         END IF;

         comm_ := SUBSTR (kod7_ || '   ' || oper_, 1, 200);
         ref_ := k.REF;

         IF kod7_ IS NULL
         THEN
            KOD_ := '9999';
         ELSE
            KOD_ := SUBSTR (KOD7_, 1, 4);
         END IF;

         oper_99 := oper_;

         --- OAB 16.11.2015
         IF mfou_ = 300465 AND SUBSTR (kod7_, 1, 4) IN ('2343', '2344')
         THEN
            coun_ := g.COUNTRY;
         END IF;

         IF kod_ = '2343' AND kv_ = 978
         THEN
            coun_ := '000';
         END IF;

         BEGIN
            SELECT decl
              INTO decl_r040
              FROM kl_r040
             WHERE r040 = kod_ AND ROWNUM = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               decl_r040 := '0';
         END;

         -- Декларування коды DD='03','04','05','06'
         -- значна сума  (виключаемо нейтральнi операцii код 8444 )
         asp_S_ := 'U';
         asp_K_ := '0000000000';
         asp_N_ := 'XXXXXXXXXX';

         IF    (    decl_r040 = '2'
                AND gl.p_icurval (g.KV, k.S, Datp_) >=
                       gl.p_icurval (840, 5000000, Datp_)
                AND SUBSTR (g.NLS, 1, 2) <> '10')
            OR (    decl_r040 = '1'
                AND gl.p_icurval (g.KV, k.S, Datp_) >=
                       gl.p_icurval (840, 2000000, Datp_)
                AND SUBSTR (g.NLS, 1, 2) <> '10')
            OR (    gl.p_icurval (g.KV, k.S, k.fdat) >=
                       gl.p_icurval (840, 100000000, k.fdat)
                AND SUBSTR (g.NLS, 1, 2) = '10')
         THEN
            nd_ := k.REF;
            nnn1_ := nnn1_ + 1;
            if nnn1_  > 999
            then
               nnn1_ := 1;
            end if;

            -- deb.trace( 12, 'S', k.S );
            BEGIN
               SELECT c.NBS, c.ACC                   --SUBSTR(a.NBS,1,2),a.acc
                 INTO sNBSk_, ACC_
                 FROM (SELECT SUBSTR (a.NBS, 1, 2) NBS, a.acc ACC
                         FROM accounts a, opldok o
                        WHERE     o.REF = k.REF
                              AND k.dk = 1 - o.dk
                              AND o.acc = a.acc
                              AND ROWNUM = 1
                              AND o.REF NOT IN
                                     (SELECT REF
                                        FROM operw
                                       WHERE REF >= o.REF AND tag = 'NOS_R')
                       UNION ALL
                       SELECT SUBSTR (a.NBS, 1, 2) NBS, a.acc ACC
                         FROM accounts a, opldok o
                        WHERE     k.dk = 1 - o.dk
                              AND o.acc = a.acc
                              AND ROWNUM = 1
                              AND o.REF IN
                                     (SELECT TO_NUMBER (TRIM (VALUE))
                                        FROM operw
                                       WHERE REF = k.REF AND tag = 'NOS_R')) c;

               IF sNBSk_ = KL_
               THEN
                  -- клиент нашего банка
                  SELECT DECODE (c.custtype,
                                 1, 'U',
                                 2, 'U',
                                 DECODE (c.sed, 91, 'S', 'F')),
                         c.okpo,
                         DECODE (c.custtype, 2, SUBSTR (replace(replace(c.nmkk, chr(171),'"'),chr(187),'"'), 1, 38), ' ')
                    INTO asp_S_, asp_K_, asp_N_
                    FROM customer c, cust_acc u
                   WHERE     c.codcagent IN (2, 3, 5)
                         AND u.acc = ACC_
                         AND u.rnk = c.rnk
                         AND ROWNUM = 1;

                  OPER_ :=
                     SUBSTR (
                           sm_
                        || OPER_
                        || sm_
                        || bank_pb1
                        || sm_
                        || asp_S_
                        || sm_
                        || asp_K_
                        || sm_
                        || asp_N_,
                        1,
                        110);
               ELSIF gl.amfo <> 300001 AND sNBSk_ IN ('16', '39', '19', '37')
               THEN
                  --клиент лоро-банка
                  asp_S_ := SUBSTR (F_dop (k.REF, 'ASP_S'), 1, 1);
                  asp_K_ := SUBSTR (F_dop (k.REF, 'ASP_K'), 1, 14);
                  asp_N_ := SUBSTR (F_dop (k.REF, 'ASP_N'), 1, 38);

                  -- МУЛЬТИВАЛ.ВПС
                  IF K.mfoa <> K.mfob
                  THEN
                     IF asp_K_ IS NULL OR SUBSTR (asp_K_, 1, 1) = ' '
                     THEN
                        asp_K_ := k.ASP_K;
                     END IF;

                     IF asp_S_ IS NULL OR SUBSTR (asp_S_, 1, 1) = ' '
                     THEN
                        asp_S_ :=
                           IIF_S (TO_CHAR (LENGTH (asp_K_)),
                                  '8',
                                  'F',
                                  'U',
                                  'F');
                     END IF;

                     IF asp_N_ IS NULL OR SUBSTR (asp_N_, 1, 1) = ' '
                     THEN
                        asp_N_ := k.ASP_N;
                     END IF;
                  END IF;

                  IF asp_S_ = 'U'
                  THEN
                     OPER_ :=
                        SUBSTR (
                              sm_
                           || OPER_
                           || sm_
                           || bank_pb1
                           || sm_
                           || asp_S_
                           || sm_
                           || asp_K_
                           || sm_
                           || asp_N_,
                           1,
                           110);
                  ELSE
                     OPER_ :=
                        SUBSTR (
                              sm_
                           || OPER_
                           || sm_
                           || bank_pb1
                           || sm_
                           || asp_S_
                           || sm_
                           || asp_K_
                           || sm_,
                           1,
                           110);
                  END IF;
               END IF;

               -- для проводок Дт 1500  Кт 3739
               IF     K.nlsa LIKE '1500%'
                  AND K.nlsb LIKE '3739%'
                  AND K.mfoa = K.mfob
               THEN
                  BEGIN
                     SELECT P.ID_B, replace(replace(c.nmkk, chr(171),'"'),chr(187),'"')
                       INTO ASP_K_, ASP_N_
                     from provodki_otc p, customer c
                     where p.vdat between k.vdat and k.vdat + 3
                       AND p.tt NOT IN ('BAK')
                       AND p.kv = k.kv
                       AND p.nlsd = k.nlsb
                       AND p.s * 100 =  k.s
                       AND p.nlsk LIKE '260%'
                       and p.rnkk = c.rnk
                       AND ROWNUM = 1
                       AND TRIM (p.id_b) = TRIM (c.okpo);

                     asp_S_ :=
                        IIF_S (TO_CHAR (LENGTH (asp_K_)),
                               '8',
                               'F',
                               'U',
                               'F');

                     IF asp_S_ = 'U'
                     THEN
                        OPER_ :=
                           SUBSTR (
                                 sm_
                              || OPER_
                              || sm_
                              || bank_pb1
                              || sm_
                              || asp_S_
                              || sm_
                              || asp_K_
                              || sm_
                              || asp_N_,
                              1,
                              110);
                     ELSE
                        OPER_ :=
                           SUBSTR (
                                 sm_
                              || OPER_
                              || sm_
                              || bank_pb1
                              || sm_
                              || asp_S_
                              || sm_
                              || asp_K_
                              || sm_,
                              1,
                              110);
                     END IF;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                  ASP_K_ := '0000000000';
                  ASP_N_ := 'XXXXXXXXXX';
                  asp_S_ := 'U';
                        --NULL;
                  END;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  DECL_ := NULL;
            END;

            IF g.NLS NOT LIKE '10%'
            THEN
               -- выборка всех реквизитов для декларирования из V_CIM_1PB_DOC
               -- с 03.11.2015 выборка всех реквизитов для декларирования
               -- будет из CIM_1PB_RU_DOC
               BEGIN
                  SELECT p.cl_type, p.cl_ipn, replace(replace(p.cl_name, chr(171),'"'),chr(187),'"')
                    INTO ASP_S_, ASP_K_, ASP_N_
                    FROM cim_1pb_ru_doc p
                   WHERE p.ref_ca = k.REF AND p.kv = k.kv AND p.vdat = k.vdat;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
               END;
            END IF;

            -- коды 03, 04, 05, 06 для декларирования кроме счетов кассы
            -- код DD=03 код банка-декларанта
            IF g.NLS NOT LIKE '10%'
            THEN
               if trim(asp_S_) is null
               then
                  asp_S_ := 'U';
               end if;

               if trim(asp_K_) is null
               then
                  asp_K_ := '0000000000';
               end if;

               if trim(asp_N_) is null
               then
                  asp_N_ := 'XXXXXXXXXX';
               end if;

               if k.NLSA like '2700%' or k.NLSA like '2701%' or k.NLSA like '2706%' or
                  k.NLSA like '2708%' or k.NLSA like '3548%' or k.NLSA like '3660%' or
                  k.NLSA like '3666%' or k.NLSA like '3668%' or k.NLSA like '1624%' or
                  k.NLSA like '1626%' or k.NLSA like '1628%' or
                  k.NLSA like '37397005523%' or k.NLSA like '3739401901%'
               then
                  asp_S_ := 'B';
                  asp_K_ := our_okpo_;
                  asp_N_ := 'АТ Ощадбанк';
               end if;

               if k.NLSB like '2700%' or k.NLSB like '2701%' or k.NLSB like '2706%' or
                  k.NLSB like '2708%' or k.NLSB like '3548%' or k.NLSB like '3660%' or
                  k.NLSB like '3666%' or k.NLSB like '3668%' or k.NLSB like '1624%' or
                  k.NLSB like '1626%' or k.NLSB like '1628%'
               then
                  asp_S_ := 'B';
                  asp_K_ := our_okpo_;
                  asp_N_ := 'АТ Ощадбанк';
               end if;

               kodp_ :=
                     '03'
                  || k.kod_e
                  || country_
                  || b010_
                  || SUBSTR (g.nls, 1, 4)
                  || LPAD (TO_CHAR (g.kv), 3, '0')
                  || kod_
                  || LPAD (coun_, 3, '0')
                  || LPAD (TO_CHAR (nnn1_), 3, '0');

               if g.nls like '1600%'
               then
                  p_ins (kodp_, LPAD (TO_CHAR (bank_), 3, ' '));
               else
                  p_ins (kodp_, LPAD (TO_CHAR (glb_), 3, ' '));
               end if;

               -- код DD=04 код типу-клієнта
               kodp_ :=
                     '04'
                  || k.kod_e
                  || country_
                  || b010_
                  || SUBSTR (g.nls, 1, 4)
                  || LPAD (TO_CHAR (g.kv), 3, '0')
                  || kod_
                  || LPAD (coun_, 3, '0')
                  || LPAD (TO_CHAR (nnn1_), 3, '0');

               p_ins (kodp_, asp_S_);

               -- код DD=05 код за ЄДРПОУ (ДРФО) умовний номер
               kodp_ :=
                     '05'
                  || k.kod_e
                  || country_
                  || b010_
                  || SUBSTR (g.nls, 1, 4)
                  || LPAD (TO_CHAR (g.kv), 3, '0')
                  || kod_
                  || LPAD (coun_, 3, '0')
                  || LPAD (TO_CHAR (nnn1_), 3, '0');

               p_ins (kodp_, LPAD (TRIM (asp_K_), 10, '0'));

               -- код DD=06 назва клієнта
               if asp_S_ in ('F','S')
               then
                  asp_N_ := '';
               end if;
               kodp_ :=
                     '06'
                  || k.kod_e
                  || country_
                  || b010_
                  || SUBSTR (g.nls, 1, 4)
                  || LPAD (TO_CHAR (g.kv), 3, '0')
                  || kod_
                  || LPAD (coun_, 3, '0')
                  || LPAD (TO_CHAR (nnn1_), 3, '0');

               p_ins (kodp_, asp_N_);
            END IF;

            -- код DD=10 назва банка-кореспондента
            kodp_ :=
                  '10'
               || k.kod_e
               || country_
               || b010_
               || SUBSTR (g.nls, 1, 4)
               || LPAD (TO_CHAR (g.kv), 3, '0')
               || kod_
               || LPAD (coun_, 3, '0')
               || LPAD (TO_CHAR (nnn1_), 3, '0');

            p_ins (kodp_, g.nmk);

            IF (kod_ IN
                  ('1221',
                   '1251',
                   '1551',
                   '1721',
                   '1751',
                   '2443',
                   '2611',
                   '2625',
                   '2627',
                   '2673',
                   '2853',
                   '2869',
                   '2871',
                   '3461',
                   '3592',
                   '8424',
                   '8425',
                   '8426',
                   '8427',
                   '8428',
                   '8430',
                   '8441',
                   '8442',
                   '8443',
                   '8444',
                   '8445',
                   '8446',
                   '8466') AND g.NLS not like '1600%'
               ) OR g.NLS like '1600%'
            THEN
               -- код DD=07 код банка-учасника
               kodp_ :=
                     '07'
                  || k.kod_e
                  || country_
                  || b010_
                  || SUBSTR (g.nls, 1, 4)
                  || LPAD (TO_CHAR (g.kv), 3, '0')
                  || kod_
                  || LPAD (coun_, 3, '0')
                  || LPAD (TO_CHAR (nnn1_), 3, '0');

               IF TRIM (bank_) IS NULL
               THEN
                  bank_ := '777';
               END IF;

               p_ins (kodp_, LPAD (bank_, 3, ' '));
            END IF;

            -- код DD=71 сума
            kodp_ :=
                  '71'
               || k.kod_e
               || country_
               || b010_
               || SUBSTR (g.nls, 1, 4)
               || LPAD (TO_CHAR (g.kv), 3, '0')
               || kod_
               || LPAD (coun_, 3, '0')
               || LPAD (TO_CHAR (nnn1_), 3, '0');

            p_ins (kodp_, TO_CHAR (k.s));

            -- код DD=99 опис операції
            kodp_ :=
                  '99'
               || k.kod_e
               || country_
               || b010_
               || SUBSTR (g.nls, 1, 4)
               || LPAD (TO_CHAR (g.kv), 3, '0')
               || kod_
               || LPAD (coun_, 3, '0')
               || LPAD (TO_CHAR (nnn1_), 3, '0');

            p_ins (kodp_, SUBSTR (oper_99, 1, 125));
         ELSE
            -- код DD=10 назва банка-кореспондента
            kodp_ :=
                  '10'
               || k.kod_e
               || country_
               || b010_
               || SUBSTR (g.nls, 1, 4)
               || LPAD (TO_CHAR (g.kv), 3, '0')
               || kod_
               || LPAD (coun_, 3, '0')
               || LPAD (TO_CHAR (nnn_), 3, '0');

            p_ins (kodp_, g.nmk);

            IF (kod_ IN
                  ('1221',
                   '1251',
                   '1551',
                   '1721',
                   '1751',
                   '2443',
                   '2611',
                   '2625',
                   '2627',
                   '2673',
                   '2853',
                   '2869',
                   '2871',
                   '3461',
                   '3592',
                   '8424',
                   '8425',
                   '8426',
                   '8427',
                   '8428',
                   '8430',
                   '8441',
                   '8442',
                   '8443',
                   '8444',
                   '8445',
                   '8446',
                   '8466') AND g.NLS not like '1600%'
               ) OR g.NLS like '1600%'
            THEN
               -- код DD=07 код банка-учасника
               kodp_ :=
                     '07'
                  || k.kod_e
                  || country_
                  || b010_
                  || SUBSTR (g.nls, 1, 4)
                  || LPAD (TO_CHAR (g.kv), 3, '0')
                  || kod_
                  || LPAD (coun_, 3, '0')
                  || LPAD (TO_CHAR (nnn_), 3, '0');

               IF TRIM (bank_) IS NULL
               THEN
                  bank_ := '777';
               END IF;

               p_ins (kodp_, LPAD (bank_, 3, ' '));
            END IF;

            -- код DD=71 сума
            kodp_ :=
                  '71'
               || k.kod_e
               || country_
               || b010_
               || SUBSTR (g.nls, 1, 4)
               || LPAD (TO_CHAR (g.kv), 3, '0')
               || kod_
               || LPAD (coun_, 3, '0')
               || LPAD (TO_CHAR (nnn_), 3, '0');

            p_ins (kodp_, TO_CHAR (k.s));

            -- код DD=99 опис операції
            kodp_ :=
                  '99'
               || k.kod_e
               || country_
               || b010_
               || SUBSTR (g.nls, 1, 4)
               || LPAD (TO_CHAR (g.kv), 3, '0')
               || kod_
               || LPAD (coun_, 3, '0')
               || LPAD (TO_CHAR (nnn_), 3, '0');

            p_ins (kodp_, SUBSTR (oper_99, 1, 125));
         -- deb.trace( 17, 'OPER_', OPER_);
         END IF;

         -- анулювання відкликання переказів в IВ
         IF k.tt IN ('M37', 'MMV', 'CN3', 'CN4')
         THEN
            BEGIN
               SELECT TRIM (w.VALUE),
                      TO_DATE (
                         SUBSTR (
                            REPLACE (REPLACE (TRIM (w1.VALUE), ',', '/'),
                                     '.',
                                     '/'),
                            1,
                            10),
                         'dd/mm/yyyy')
                 INTO ref_m37, dat_m37
                 FROM operw w, operw w1
                WHERE     w.REF = k.REF
                      AND (w.tag LIKE 'D_REF%' OR w.tag LIKE 'REFT%')
                      AND w1.REF = k.REF
                      AND (w1.tag LIKE 'D_1PB%' OR w1.tag LIKE 'DATT%');

               BEGIN
                  SELECT REF, fdat
                    INTO ref_mmv, dat_mmv
                    FROM provodki_otc
                   WHERE     REF = ref_m37
                         AND fdat = any(select fdat from fdat where fdat BETWEEN Dat1_ AND Dat_+3) 
                         AND kv = g.kv
                         AND nlsd = g.nls
                         AND ROWNUM = 1;

                  IF TO_CHAR (k.fdat, 'MM') = TO_CHAR (dat_mmv, 'MM')
                  THEN
                     DELETE FROM rnbu_trace
                           WHERE REF = k.REF;

                     DELETE FROM rnbu_trace
                           WHERE REF = ref_m37;
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     NULL;
                  WHEN OTHERS
                  THEN
                     IF SQLCODE IN (-1830, -1858)
                     THEN
                        raise_application_error (
                           -20001,
                              'Перевірте доп.реквізит D_1PB для РЕФ = '
                           || TO_CHAR (k.REF)
                           || ' ! Дата повинна бути в форматі dd/mm/yyyy');
                     ELSE
                        RAISE;
                     END IF;
               END;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;
      END LOOP;

      ref_ := 0;
      oper_ := '';
      coun_ := g.country;

      IF (g.nls LIKE '15%' OR g.nls LIKE '100%') AND g.S2 <= 0
      THEN
         kod2_ := '9112';
         s2_ := -g.S2;

         IF g.nls LIKE '100%' AND kv_ = 978
         THEN
            coun_ := '000';
         END IF;

         -- код DD=71 сума залишку
         kodp_ :=
               '71'
            || '3'
            || country_
            || b010_
            || SUBSTR (g.nls, 1, 4)
            || LPAD (TO_CHAR (g.kv), 3, '0')
            || kod2_
            || LPAD (coun_, 3, '0')
            || '000';

         p_ins (kodp_, TO_CHAR (ABS (s2_)));
      ELSE
         kod2_ := '9222';
         S2_ := g.S2;
         -- код DD=71 сума залишку
         kodp_ :=
               '71'
            || '3'
            || country_
            || b010_
            || SUBSTR (g.nls, 1, 4)
            || LPAD (TO_CHAR (g.kv), 3, '0')
            || kod2_
            || LPAD (coun_, 3, '0')
            || '000';

         p_ins (kodp_, TO_CHAR (s2_));
      END IF;

      -- код DD=10 назва банка-кореспондента
      kodp_ :=
            '10'
         || '3'
         || country_
         || b010_
         || SUBSTR (g.nls, 1, 4)
         || LPAD (TO_CHAR (g.kv), 3, '0')
         || kod2_
         || LPAD (coun_, 3, '0')
         || '000';

      p_ins (kodp_, g.nmk);
   END LOOP;

   ----------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

   UPDATE rnbu_trace a
      SET a.znap = '777'
    WHERE a.kodp LIKE '07%' AND TRIM (a.znap) IS NULL;

--------------------------------------------------------------------------
   -- 08/12/2016
   -- дополнительно для бал.счета 1500 в кода показателя 03 изменяем код банка
   -- на такое значение как в показателе 07 (для значения 999 меняем на 6)
   FOR k IN ( SELECT kodp, DECODE(TRIM(znap), '999', '6', trim(znap)) znap, REF
              FROM rnbu_trace
              WHERE kodp LIKE '07%'
                AND SUBSTR (kodp, 17, 4) = '1500'
                AND TRIM(znap) not in ('6', '777')
              ORDER BY 1, 2, 3
            )
   LOOP

         UPDATE rnbu_trace
            SET znap = k.znap
          WHERE kodp like '03%'
            and substr(kodp,3) = substr(k.kodp,3)
            and REF = k.REF;
   END LOOP;
--------------------------------------------------------------------------
   DELETE FROM rnbu_trace
         WHERE     kodp LIKE '07%'
               AND SUBSTR (kodp, 24, 4) IN ('2314', '2343')
               AND TRIM (znap) IS NULL;

   SELECT MAX (TO_NUMBER (SUBSTR (kodp, -3))) INTO nnn_ FROM rnbu_trace;

   bank_ := NULL;
   kod7_ := NULL;

   FOR k IN (  SELECT kodp,
                      TRIM (znap) znap,
                      SUBSTR (comm, 1, 7) kod_n,
                      REF
                 FROM rnbu_trace
                WHERE kodp LIKE '07%' AND SUBSTR (kodp, 31, 3) = '000'
             ORDER BY 1, 2, 3)
   LOOP
      IF bank_ IS NULL AND kod7_ IS NULL
      THEN
         bank_ := k.znap;
         kod7_ := k.kod_n;
      END IF;

      IF bank_ <> k.znap OR kod7_ <> k.kod_n
      THEN
         nnn_ := nnn_ + 1;
         if nnn_ > 999
         then
            nnn_ := 1;
         end if;
         bank_ := k.znap;
         kod7_ := k.kod_n;
      END IF;

      UPDATE rnbu_trace
         SET kodp = SUBSTR (kodp, 1, 30) || LPAD (TO_CHAR (nnn_), 3, '0') --kodp_
       WHERE REF = k.REF;
   END LOOP;

   delete from rnbu_trace
   where kodp like '07%'
     and substr(kodp, 24, 4) IN ('1221', '1251', '1551', '1721', '1751',
                                 '2443', '2611', '2625', '2627', '2673',
                                 '2853', '2869', '2871', '3461', '3592'
                                )
     and substr(kodp, 17, 4) <> '1600';

   OPEN basel;

   LOOP
      FETCH basel
         INTO kodp_, znap_;

      EXIT WHEN basel%NOTFOUND;

      BEGIN
         IF TRIM (znap_) IS NOT NULL
         THEN
            SELECT COUNT (*)
              INTO kol_
              FROM tmp_nbu
             WHERE kodf = kodf_ AND datf = dat_ AND kodp = kodp_;

            IF kol_ = 0
            THEN
               INSERT INTO tmp_nbu (kodf,
                                    datf,
                                    kodp,
                                    znap,
                                    nbuc)
                    VALUES (kodf_,
                            dat_,
                            kodp_,
                            znap_,
                            nbuc_);
            END IF;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20004,
               'Ошибка: ' || SQLERRM || ' kodp:' || kodp_);
      END;
   END LOOP;

   CLOSE basel;

   -- формирование показателя DD='80' - кількість операцій
   nnn_ := 0;

   FOR k
      IN (  SELECT DISTINCT
                   kodp,
                   znap,
                   nbuc,
                   NVL (
                      COUNT (
                         *)
                      OVER (PARTITION BY kodp, znap, nbuc
                            ORDER BY kodp, znap, nbuc),
                      0)
                      p80
              FROM rnbu_trace
             WHERE SUBSTR (kodp, 1, 2) IN ('99')
          ORDER BY SUBSTR (kodp, 3, 28),
                   SUBSTR (kodp, 31),
                   SUBSTR (kodp, 1, 2))
   LOOP
      kodp_ := '80' || SUBSTR (k.kodp, 3, 31);

      BEGIN
         IF k.p80 IS NOT NULL
         THEN
            SELECT COUNT (*)
              INTO kol_
              FROM tmp_nbu
             WHERE kodf = kodf_ AND datf = dat_ AND kodp = kodp_;

            IF kol_ = 0
            THEN
               INSERT INTO tmp_nbu (kodf,
                                    datf,
                                    kodp,
                                    znap,
                                    nbuc)
                    VALUES (kodf_,
                            dat_,
                            kodp_,
                            k.p80,
                            nbuc_);
            END IF;
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (
               -20004,
               'Ошибка: ' || SQLERRM || ' kodp:' || kodp_);
      END;
   END LOOP;

   INSERT INTO tmp_nbu (kodf,
                        datf,
                        kodp,
                        znap,
                        nbuc)
        SELECT kodf_,
               dat_,
               kodp,
               SUM (NVL (znap, '0')),
               nbuc_
          FROM rnbu_trace
         WHERE SUBSTR (kodp, 1, 2) NOT IN
                  ('03', '04', '05', '06', '07', '10', '80', '99')
      GROUP BY kodf_,
               dat_,
               kodp,
               nbuc_;

   logger.info ('P_F1P_NN : End ');
END p_f1p_nn;
/
show err;

PROMPT *** Create  grants  P_F1P_NN ***
grant EXECUTE                                                                on P_F1P_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F1P_NN        to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F1P_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
