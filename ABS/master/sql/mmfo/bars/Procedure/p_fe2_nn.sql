

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE2_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE2_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE2_NN (dat_      DATE,
                                           sheme_    VARCHAR2 DEFAULT 'G')
IS
   /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % DESCRIPTION : Процедура формирования #E2 для КБ
   % COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
   % VERSION     : 15/03/2016 (23/02/2016, 02/11/2015)
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   параметры: Dat_ - отчетная дата
              sheme_ - схема формирования
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   15.03.2016 с 21.03.2016 (на 22.03.2016) закрывается показатель 41NNN
   23.02.2016 протокол формирования будет сохраняться в таблицу
              OTCN_TRACE_70
   02.11.2015 для банка 300465 и проводок Дт 1600 Кт 1500 показатель 61 будем
              формировать как "переказ коштів з рахунку лоро банку-нерезидента"
   12.10.2015 для 300465 показатель 61 (відомості про операцію) будем
              формировать в зависимости от кода меты покупки
              (службова Рощиної 52-18/773 від 12.06.2015)
   21.09.2015 для РУ СБ проводки будут включаться только при наличии в
              ARC_RRP
   11.08.2015 для всех РУ СБ при формировании будут включаться проводки
              Дт 2520,2530,2541,2542,2544,2545
              Кт 1500, 1600, 3720, 3739, 3900, 2909
   22.06.2015 для 300465 показатель 61 (відомості про операцію) будем
              формировать в зависимости от кода меты покупки
              (службова Рощиної 52-18/773 від 12.06.2015)
   06.02.2015 для всех РУ СБ будут включаться проводки Дт 2600,2620 Кт 1919
              кроме ГОУ а для Дт 2909 Кт 1919 только для Ровно
   04.02.2015 для 300465 будут включаться проводки Дт 1600 Кт 1500
   22.01.2015 для всех РУ СБ будут включаться проводки Дт 2600,2620 Кт 1919
              Дт 2909 Кт 1919
   15.01.2015 для показателя 40ХХХ и Дт 1600 Кт 1500 формируем значение = '31'
   26.11.2014 дополнительно будем обрабатывать доп.реквизит 57A
              для определения кода банка (B010)
   25.11.2014 для определения кода страны дополнительно обрабатываем доп.
              реквизит "n"
   24.06.2014 вместо доп.реквизита 57A будем обрабатывать доп.реквизит 58A
              - SWIFT_CODE (после изменеия перечня доп.реквизитов)
   03.06.2014 для доп.реквизита tag like '59%' выбираем первых 3 символа
              из поля VALUE
   09.04.2014 включались суммы док-тов >=1001$ а необходимо 1000.01$ и больше
   03.04.2014 будут отбираться суммы документов строго больше 1000$
   27.02.2014 для ОПЕРУ СБ не будем включать проводки вида
              Дт '37396506' Кт '1500%' и назначение "розрахунки за чеками"
   19.02.2014 для физлиц резидентов не имеющих ОКРО определяем серию и номер
              паспорта
   13.02.2014 будут включаться док-ты с суммой не менее 1000.00$
   08.01.2014 для ОПЕРУ СБ будем включать проводки вида
              Дт '37396506' Кт '1500%' и назначение "розрахунки за чеками"
   26.07.2013 код страны поступления валюты еще будем определять
              по TAG='50F' и в значении проверяем символы 'UA'
              (не будем включать валютные переводы по Украине)
   22.07.2013 для ОПЕРУ СБ будем включать проводки вида
              Дт похож на '292430003718%', '292460003717%' Кт на '1500%'
   03.01.2013 для ОПЕРУ СБ будем включать проводки вида
              Дт похож на '292490204%', '292460205%' Кт на '1500%'
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_       VARCHAR2 (2) := 'E2';
   sql_z       VARCHAR2 (200);
   typ_        NUMBER;
   gr_sum_     NUMBER := 5000000;                               --для переказу
   sum_kom     NUMBER;                                         -- сума комiсiї
   flag_       NUMBER;
   ko_         VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b_      VARCHAR2 (10);                                     -- код банку
   nam_b       VARCHAR2 (70);                                   -- назва банку
   n_          NUMBER := 10;
   -- кол-во доп.параметров до 03.07.2006 после n_=11
   acc_        NUMBER;
   accd_       NUMBER;
   acck_       NUMBER;
   kv_         NUMBER;
   kv1_        NUMBER;
   nls_        VARCHAR2 (15);
   nlsk_       VARCHAR2 (15);
   nlsk1_      VARCHAR2 (15);
   nbuc1_      VARCHAR2 (12);
   nbuc_       VARCHAR2 (12);
   kod_g_      VARCHAR2 (3);
   country_    VARCHAR2 (3);
   b010_       VARCHAR2 (10);
   swift_k_    VARCHAR2 (12);
   bic_code    VARCHAR2 (14);
   rnk_        NUMBER;
   okpo_       VARCHAR2 (14);
   okpo1_      VARCHAR2 (14);
   nmk_        VARCHAR2 (70);
   adr_        VARCHAR2 (70);
   k040_       VARCHAR2 (3);
   k110_       VARCHAR2 (5);
   val_        VARCHAR2 (70);
   a1_         VARCHAR2 (70);
   a2_         VARCHAR2 (70);
   a3_         VARCHAR2 (70);
   a4_         VARCHAR2 (70);
   a5_         VARCHAR2 (70);
   a6_         VARCHAR2 (70);
   a7_         VARCHAR2 (70);
   nb_         VARCHAR2 (70);
   tg_         VARCHAR2 (70);
   data_       DATE;
   dig_        NUMBER;
   bsum_       NUMBER;
   bsu_        NUMBER;
   sum1_       DECIMAL (24);
   sum0_       DECIMAL (24);
   sumk1_      DECIMAL (24);                 --ком_с_я в ц_лому по контрагенту
   sumk0_      DECIMAL (24);                            --ком_с_я по контракту
   kodp_       VARCHAR2 (10);
   znap_       VARCHAR2 (70);
   kurs_       NUMBER;
   tag_        VARCHAR2 (5);
   nnnn_       NUMBER := 0;
   userid_     NUMBER;
   ref_        NUMBER;
   rez_        NUMBER;
   codc_       NUMBER;
   mfo_        NUMBER;
   mfou_       NUMBER;
   tt_         VARCHAR2 (3);

   kod_n_      VARCHAR2 (4);
   refd_       NUMBER;
   ttd_        VARCHAR2 (3);
   nlsdd_      VARCHAR2 (20);
   formOk_     BOOLEAN;
   s180_       VARCHAR2 (1);
   accdd_      NUMBER;

   d1#E2_      VARCHAR2 (70);
   d2#E2_      VARCHAR2 (70);
   d3#E2_      VARCHAR2 (70);
   d4#E2_      VARCHAR2 (70);
   d6#E2_      VARCHAR2 (70);
   d7#E2_      VARCHAR2 (70);
   d8#E2_      VARCHAR2 (70);
   db#E2_      VARCHAR2 (70);
   dc#E2_      VARCHAR2 (70);
   dc#E2_max   VARCHAR2 (70);
   d61#E2_     VARCHAR2 (170);
   kol_61      NUMBER;
   DC1#E2_     VARCHAR2 (70);
   DE#E2_      VARCHAR2 (3);
   nazn_       VARCHAR2 (160);
   mbkOK_      BOOLEAN;
   ourOKPO_    VARCHAR2 (14);
   ourGLB_     VARCHAR2 (3);
   pid_        NUMBER;
   id_         NUMBER;
   id_min_     NUMBER := 0;
   kol_ref_    NUMBER;
   kod_obl_    VARCHAR2 (2);
   ser_        person.ser%TYPE;
   numdoc_     person.numdoc%TYPE;
   dat_Izm1_   DATE := TO_DATE ('18032016', 'ddmmyyyy'); -- закривається показник
                                                                      -- 41000

   --курсор по контрагентам
   CURSOR c_main
   IS
        SELECT t.ko,
               DECODE (SUBSTR (b.b040, 9, 1),
                       '2', SUBSTR (b.b040, 15, 2),
                       SUBSTR (b.b040, 10, 2)),
               c.rnk,
               TRIM (c.okpo),
               c.nmk,
               TO_CHAR (c.country),
               c.adr,
               NVL (c.ved, '00000'),
               c.codcagent,
               NVL (SUM (t.s_eqv), 0),
               NVL (SUM (gl.p_icurval (t.kv, t.s_kom, dat_)), 0)
          --сумма в формате грн.коп
          FROM OTCN_PROV_TEMP t, customer c, tobo b                 --branch b
         WHERE t.rnk = c.rnk AND c.tobo = b.tobo         --c.branch = b.branch
      GROUP BY t.ko,
               DECODE (SUBSTR (b.b040, 9, 1),
                       '2', SUBSTR (b.b040, 15, 2),
                       SUBSTR (b.b040, 10, 2)),
               c.rnk,
               c.okpo,
               c.nmk,
               TO_CHAR (c.country),
               c.adr,
               NVL (c.ved, '00000'),
               c.codcagent
      ORDER BY 2;

   --- переказ безготiвковоi валюти
   CURSOR opl_dok
   IS
      SELECT t.ko,
             t.REF,
             t.tt,
             t.accd,
             t.nlsd,
             t.kv,
             t.acck,
             t.nlsk,
             t.nazn,
             t.s_nom,
             t.s_eqv
        FROM OTCN_PROV_TEMP t
       WHERE t.rnk = rnk_;

   -------------------------------------------------------------------
   PROCEDURE p_ins (p_np_     IN NUMBER,
                    p_kodp_   IN VARCHAR2,
                    p_znap_   IN VARCHAR2)
   IS
      l_kodp_    VARCHAR2 (10);
      p_znap1_   VARCHAR2 (70);
   BEGIN
      IF     p_kodp_ = '31'
         AND LENGTH (TRIM (p_znap_)) < 3
         AND TRIM (p_znap_) != '0'
      THEN
         p_znap1_ := LPAD (p_znap_, 3, '0');
      ELSE
         p_znap1_ := p_znap_;
      END IF;

      IF mfo_ = 300465 AND p_kodp_ = '31'
      THEN
         IF    (    nlsk_ LIKE '1500%'
                AND (   nls_ IN
                           ('29091000580557',
                            '29092000040557',
                            '29095000081557',
                            '29095000046547',
                            '29091927',
                            '2909003101',
                            '292460205',
                            '292490204')
                     OR SUBSTR (nls_, 1, 4) = '1502'))
            OR p_znap1_ = '6'
         THEN
            p_znap1_ := '006';
         END IF;
      END IF;

      l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 3, '0');

      IF SUBSTR (l_kodp_, 1, 2) = '64'
      THEN
         INSERT INTO rnbu_trace (nls,
                                 kv,
                                 odate,
                                 kodp,
                                 znap,
                                 nbuc,
                                 REF,
                                 rnk,
                                 comm)
              VALUES (nls_,
                      kv_,
                      dat_,
                      l_kodp_,
                      p_znap1_,
                      nbuc_,
                      ref_,
                      rnk_,
                      D6#E2_);
      ELSIF SUBSTR (l_kodp_, 1, 2) = '65'
      THEN
         INSERT INTO rnbu_trace (nls,
                                 kv,
                                 odate,
                                 kodp,
                                 znap,
                                 nbuc,
                                 REF,
                                 rnk,
                                 comm)
              VALUES (nls_,
                      kv_,
                      dat_,
                      l_kodp_,
                      p_znap1_,
                      nbuc_,
                      ref_,
                      rnk_,
                      NVL (D7#E2_, kod_b_ || ' ' || TO_CHAR (kv_)));
      ELSIF SUBSTR (l_kodp_, 1, 2) = '66'
      THEN
         INSERT INTO rnbu_trace (nls,
                                 kv,
                                 odate,
                                 kodp,
                                 znap,
                                 nbuc,
                                 REF,
                                 rnk,
                                 comm)
              VALUES (nls_,
                      kv_,
                      dat_,
                      l_kodp_,
                      p_znap1_,
                      nbuc_,
                      ref_,
                      rnk_,
                      D8#E2_);
      ELSE
         INSERT INTO rnbu_trace (nls,
                                 kv,
                                 odate,
                                 kodp,
                                 znap,
                                 nbuc,
                                 REF,
                                 rnk,
                                 comm,
                                 nd)
              VALUES (nls_,
                      kv_,
                      dat_,
                      l_kodp_,
                      p_znap1_,
                      nbuc_,
                      ref_,
                      rnk_,
                      TO_CHAR (refd_),
                      id_min_);
      END IF;
   END;

   -------------------------------------------------------------------
   PROCEDURE p_tag (p_i_       IN     NUMBER,
                    p_value_   IN OUT VARCHAR2,
                    p_kodp_       OUT VARCHAR2,
                    p_ref_     IN     NUMBER DEFAULT NULL)
   IS
   BEGIN
      BEGIN
         SELECT SUBSTR (TRIM (VALUE), 1, 4)
           INTO kod_n_
           FROM operw
          WHERE REF = p_ref_ AND tag = 'KOD_N';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            kod_n_ := NULL;
      END;

      IF p_i_ = 1
      THEN
         p_kodp_ := '40';

         IF mfo_ = 300465
         THEN
            IF     nlsk_ LIKE '1500%'
               AND nls_ IN
                      ('29091000580557',
                       '29092000040557',
                       '29095000081557',
                       '29095000046547',
                       '29091927',
                       '2909003101',
                       '292460205',
                       '292490204')
            THEN
               --d1#E2_ := '31';  -- было до 26.07.2012
               d1#E2_ := '37'; -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            END IF;

            IF nlsk_ LIKE '1500%' AND nls_ IN ('37394501547') --and  --,'37396506')
            --(instr(lower(nazn_),'розрахунки за чеками') > 0 or  instr(lower(nazn_),'розрахунки по чеках') > 0)
            THEN
               d1#E2_ := '31'; -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            END IF;

            IF nls_ LIKE '1600%' AND nlsk_ LIKE '1500%'
            THEN
               d1#E2_ := '31'; -- с 16.01.2015 согласно письма Рощиной от 15.01.2015
            END IF;
         END IF;

         IF TRIM (p_value_) IS NULL AND d1#E2_ IS NULL AND nazn_ IS NOT NULL
         THEN
            IF INSTR (LOWER (nazn_), 'грош') > 0
            THEN
               d1#E2_ := '38'; -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            END IF;

            IF mfo_ <> 300120 AND INSTR (LOWER (nazn_), 'комерц') > 0
            THEN
               d1#E2_ := '38'; -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            END IF;

            IF INSTR (LOWER (nazn_), 'соц_альний переказ') >
                  0
            THEN
               d1#E2_ := '38'; -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            END IF;

            IF     d1#E2_ IS NULL
               AND INSTR (LOWER (nazn_), 'переказ') > 0
               AND TRIM (nls_) LIKE '2620%'
            THEN
               d1#E2_ := '38'; -- с 26.07.2012 согласно письма Рощиной от 11.07.2012
            END IF;
         END IF;

         IF mfo_ = 353575
         THEN
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 2), '00');
         ELSE
            IF TRIM (p_value_) IS NULL AND d1#E2_ IS NOT NULL
            THEN
               p_value_ := NVL (SUBSTR (TRIM (d1#E2_), 1, 2), '00');
            ELSE
               p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 2), '00');

               IF p_value_ = '00'
               THEN
                  IF kod_n_ = '8445'
                  THEN
                     p_value_ := '30';
                  END IF;
               END IF;

               d1#E2_ := p_value_;
            END IF;
         END IF;
      ELSIF p_i_ = 2
      THEN
         p_kodp_ := '51';

         IF TRIM (p_value_) IS NULL AND d2#E2_ IS NOT NULL
         THEN
            p_value_ := NVL (SUBSTR (TRIM (d2#E2_), 1, 70), 'N контр.');
         ELSE
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'N контр.');
         END IF;

         -- для продажи валюты и межбанковских кредитов
         IF mbkOK_ OR d1#E2_ = '30'
         THEN
            p_value_ := '';
         END IF;
      ELSIF p_i_ = 3
      THEN
         p_kodp_ := '52';

         IF TRIM (p_value_) IS NULL AND d3#E2_ IS NOT NULL
         THEN
            p_value_ :=
               NVL (SUBSTR (TRIM (d3#E2_), 1, 70), 'дата контр.');
         ELSE
            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 70), 'дата контр.');
         END IF;

         -- для продажи валюты и межбанковских кредитов
         IF mbkOK_ OR d1#E2_ = '30'
         THEN
            p_value_ := '';
         END IF;
      ELSIF p_i_ = 4
      THEN
         p_kodp_ := '60';

         IF TRIM (p_value_) IS NULL AND d4#E2_ IS NOT NULL
         THEN
            p_value_ := NVL (SUBSTR (TRIM (d4#E2_), 1, 70), '');
         ELSE
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
         END IF;

         -- для продажи валюты и межбанковских кредитов
         IF mbkOK_ OR d1#E2_ = '30'
         THEN
            p_value_ := '';
         END IF;
      ELSIF p_i_ = 6
      THEN
         p_kodp_ := '64';

         IF p_value_ IS NOT NULL
         THEN
            p_value_ := LPAD (p_value_, 3, '0');
         ELSE
            p_value_ := TRIM (D6#E2_);
         END IF;

         IF     Dat_ >= TO_DATE ('01092011', 'ddmmyyyy')
            AND TRIM (kod_g_) IS NOT NULL
         THEN
            p_value_ := TRIM (kod_g_);
         END IF;

         IF mfo_ != 353575 AND p_value_ IS NULL
         THEN
            BEGIN
               SELECT SUBSTR (TRIM (VALUE), 1, 12)
                 INTO swift_k_
                 FROM OPERW
                WHERE REF = REF_ AND TAG LIKE '58A%' AND ROWNUM = 1;

               BEGIN
                  SELECT k040
                    INTO p_value_
                    FROM RC_BNK
                   WHERE SWIFT_CODE LIKE swift_k_ || '%' AND ROWNUM = 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     swift_k_ :=
                           SUBSTR (swift_k_, 1, 4)
                        || ' '
                        || SUBSTR (swift_k_, 5, 2)
                        || ' '
                        || SUBSTR (swift_k_, 7, 2);

                     BEGIN
                        SELECT k040
                          INTO p_value_
                          FROM RC_BNK
                         WHERE SWIFT_CODE LIKE swift_k_ || '%' AND ROWNUM = 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           NULL;
                     END;
               END;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BEGIN
                     SELECT SUBSTR (TRIM (VALUE), 1, 12)
                       INTO swift_k_
                       FROM OPERW
                      WHERE REF = REF_ AND TAG LIKE '57A%' AND ROWNUM = 1;

                     BEGIN
                        SELECT k040
                          INTO p_value_
                          FROM RC_BNK
                         WHERE SWIFT_CODE LIKE swift_k_ || '%' AND ROWNUM = 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           swift_k_ :=
                                 SUBSTR (swift_k_, 1, 4)
                              || ' '
                              || SUBSTR (swift_k_, 5, 2)
                              || ' '
                              || SUBSTR (swift_k_, 7, 2);

                           BEGIN
                              SELECT k040
                                INTO p_value_
                                FROM RC_BNK
                               WHERE     SWIFT_CODE LIKE swift_k_ || '%'
                                     AND ROWNUM = 1;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 NULL;
                           END;
                     END;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           SELECT SUBSTR (TRIM (VALUE), 1, 12)
                             INTO swift_k_
                             FROM OPERW
                            WHERE     REF = REF_
                                  AND TAG LIKE '57D%'
                                  AND ROWNUM = 1;

                           BEGIN
                              SELECT k040
                                INTO p_value_
                                FROM RC_BNK
                               WHERE     SWIFT_CODE LIKE swift_k_ || '%'
                                     AND ROWNUM = 1;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 swift_k_ :=
                                       SUBSTR (swift_k_, 1, 4)
                                    || ' '
                                    || SUBSTR (swift_k_, 5, 2)
                                    || ' '
                                    || SUBSTR (swift_k_, 7, 2);

                                 BEGIN
                                    SELECT k040
                                      INTO p_value_
                                      FROM RC_BNK
                                     WHERE     SWIFT_CODE LIKE
                                                  swift_k_ || '%'
                                           AND ROWNUM = 1;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       NULL;
                                 END;
                           END;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              BEGIN
                                 SELECT SUBSTR (TRIM (VALUE), 1, 12)
                                   INTO swift_k_
                                   FROM OPERW
                                  WHERE     REF = REF_
                                        AND TAG = '57'
                                        AND LENGTH (TRIM (VALUE)) > 3
                                        AND ROWNUM = 1;

                                 --swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                 --            ' '||substr(swift_k_,7,2);
                                 BEGIN
                                    SELECT k040
                                      INTO p_value_
                                      FROM RC_BNK
                                     WHERE     SWIFT_CODE LIKE
                                                  swift_k_ || '%'
                                           AND ROWNUM = 1;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       swift_k_ :=
                                             SUBSTR (swift_k_, 1, 4)
                                          || ' '
                                          || SUBSTR (swift_k_, 5, 2)
                                          || ' '
                                          || SUBSTR (swift_k_, 7, 2);

                                       BEGIN
                                          SELECT k040
                                            INTO p_value_
                                            FROM RC_BNK
                                           WHERE     SWIFT_CODE LIKE
                                                        swift_k_ || '%'
                                                 AND ROWNUM = 1;
                                       EXCEPTION
                                          WHEN NO_DATA_FOUND
                                          THEN
                                             NULL;
                                       END;
                                 END;
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    BEGIN
                                       SELECT SUBSTR (TRIM (VALUE), 1, 12)
                                         INTO swift_k_
                                         FROM OPERW
                                        WHERE     REF = REF_
                                              AND TAG = 'NOS_B'
                                              AND ROWNUM = 1;

                                       swift_k_ :=
                                             SUBSTR (swift_k_, 1, 4)
                                          || ' '
                                          || SUBSTR (swift_k_, 5, 2)
                                          || ' '
                                          || SUBSTR (swift_k_, 7, 2);

                                       BEGIN
                                          SELECT k040
                                            INTO p_value_
                                            FROM RC_BNK
                                           WHERE     SWIFT_CODE LIKE
                                                        swift_k_ || '%'
                                                 AND ROWNUM = 1;
                                       EXCEPTION
                                          WHEN NO_DATA_FOUND
                                          THEN
                                             NULL;
                                       END;
                                    EXCEPTION
                                       WHEN NO_DATA_FOUND
                                       THEN
                                          NULL;
                                    END;
                              END;
                        END;
                  END;
            END;
         END IF;

         country_ := NVL (SUBSTR (TRIM (p_value_), 1, 3), '000');
         p_value_ :=
            NVL (
               SUBSTR (TRIM (p_value_), 1, 70),
               'код краiни у яку переказана валюта');
      ELSIF p_i_ = 9
      THEN
         b010_ := NULL;
         p_kodp_ := '65';

         IF mfo_ = 353575
         THEN
            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 10), 'код банку');
         ELSE
            IF TRIM (p_value_) IS NULL AND d7#E2_ IS NOT NULL
            THEN
               p_value_ :=
                  NVL (SUBSTR (TRIM (d7#E2_), 1, 10), 'код банку');
            END IF;
         END IF;

         IF mfo_ != 353575 AND TRIM (p_value_) IS NULL AND d7#E2_ IS NULL
         THEN
            BEGIN
               SELECT SUBSTR (TRIM (VALUE), 1, 12)
                 INTO swift_k_
                 FROM OPERW
                WHERE REF = REF_ AND TAG LIKE '58A%' AND ROWNUM = 1;

               --swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
               --            ' '||substr(swift_k_,7,2);
               BEGIN
                  SELECT b010
                    INTO p_value_
                    FROM RC_BNK
                   WHERE SWIFT_CODE LIKE swift_k_ || '%' AND ROWNUM = 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     swift_k_ :=
                           SUBSTR (swift_k_, 1, 4)
                        || ' '
                        || SUBSTR (swift_k_, 5, 2)
                        || ' '
                        || SUBSTR (swift_k_, 7, 2);

                     BEGIN
                        SELECT b010
                          INTO p_value_
                          FROM RC_BNK
                         WHERE SWIFT_CODE LIKE swift_k_ || '%' AND ROWNUM = 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           NULL;
                     END;
               END;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BEGIN
                     SELECT SUBSTR (TRIM (VALUE), 1, 12)
                       INTO swift_k_
                       FROM OPERW
                      WHERE REF = REF_ AND TAG LIKE '57A%' AND ROWNUM = 1;

                     --swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                     --            ' '||substr(swift_k_,7,2);
                     BEGIN
                        SELECT b010
                          INTO p_value_
                          FROM RC_BNK
                         WHERE SWIFT_CODE LIKE swift_k_ || '%' AND ROWNUM = 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           swift_k_ :=
                                 SUBSTR (swift_k_, 1, 4)
                              || ' '
                              || SUBSTR (swift_k_, 5, 2)
                              || ' '
                              || SUBSTR (swift_k_, 7, 2);

                           BEGIN
                              SELECT b010
                                INTO p_value_
                                FROM RC_BNK
                               WHERE     SWIFT_CODE LIKE swift_k_ || '%'
                                     AND ROWNUM = 1;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 NULL;
                           END;
                     END;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           SELECT SUBSTR (TRIM (VALUE), 1, 12)
                             INTO swift_k_
                             FROM OPERW
                            WHERE     REF = REF_
                                  AND TAG LIKE '57D%'
                                  AND ROWNUM = 1;

                           --swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                           --            ' '||substr(swift_k_,7,2);
                           BEGIN
                              SELECT b010
                                INTO p_value_
                                FROM RC_BNK
                               WHERE     SWIFT_CODE LIKE swift_k_ || '%'
                                     AND ROWNUM = 1;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 swift_k_ :=
                                       SUBSTR (swift_k_, 1, 4)
                                    || ' '
                                    || SUBSTR (swift_k_, 5, 2)
                                    || ' '
                                    || SUBSTR (swift_k_, 7, 2);

                                 BEGIN
                                    SELECT b010
                                      INTO p_value_
                                      FROM RC_BNK
                                     WHERE     SWIFT_CODE LIKE
                                                  swift_k_ || '%'
                                           AND ROWNUM = 1;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       NULL;
                                 END;
                           END;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              BEGIN
                                 SELECT SUBSTR (TRIM (VALUE), 1, 12)
                                   INTO swift_k_
                                   FROM OPERW
                                  WHERE     REF = REF_
                                        AND TAG = '57'
                                        AND LENGTH (TRIM (VALUE)) > 3
                                        AND ROWNUM = 1;

                                 --swift_k_ := substr(swift_k_,1,4)||' '||substr(swift_k_,5,2)||
                                 --            ' '||substr(swift_k_,7,2);
                                 BEGIN
                                    SELECT b010
                                      INTO p_value_
                                      FROM RC_BNK
                                     WHERE     SWIFT_CODE LIKE
                                                  swift_k_ || '%'
                                           AND ROWNUM = 1;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       swift_k_ :=
                                             SUBSTR (swift_k_, 1, 4)
                                          || ' '
                                          || SUBSTR (swift_k_, 5, 2)
                                          || ' '
                                          || SUBSTR (swift_k_, 7, 2);

                                       BEGIN
                                          SELECT b010
                                            INTO p_value_
                                            FROM RC_BNK
                                           WHERE     SWIFT_CODE LIKE
                                                        swift_k_ || '%'
                                                 AND ROWNUM = 1;
                                       EXCEPTION
                                          WHEN NO_DATA_FOUND
                                          THEN
                                             NULL;
                                       END;
                                 END;
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    BEGIN
                                       SELECT SUBSTR (TRIM (VALUE), 1, 12)
                                         INTO swift_k_
                                         FROM OPERW
                                        WHERE     REF = REF_
                                              AND TAG = 'NOS_B'
                                              AND ROWNUM = 1;

                                       swift_k_ :=
                                             SUBSTR (swift_k_, 1, 4)
                                          || ' '
                                          || SUBSTR (swift_k_, 5, 2)
                                          || ' '
                                          || SUBSTR (swift_k_, 7, 2);

                                       BEGIN
                                          SELECT b010
                                            INTO p_value_
                                            FROM RC_BNK
                                           WHERE     SWIFT_CODE LIKE
                                                        swift_k_ || '%'
                                                 AND ROWNUM = 1;
                                       EXCEPTION
                                          WHEN NO_DATA_FOUND
                                          THEN
                                             NULL;
                                       END;
                                    EXCEPTION
                                       WHEN NO_DATA_FOUND
                                       THEN
                                          NULL;
                                    END;
                              END;
                        END;
                  END;
            END;

            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 10), 'код банку');
         END IF;

         IF mfo_ != 353575
         THEN
            IF TRIM (p_value_) != 'код банку'
            THEN
               b010_ := SUBSTR (TRIM (p_value_), 1, 10);
            ELSE
               p_value_ := country_ || '0000000';
            END IF;
         END IF;
      ELSIF p_i_ = 10
      THEN
         nb_ := NULL;
         p_kodp_ := '66';

         IF TRIM (p_value_) IS NULL
         THEN
            IF b010_ IS NOT NULL
            THEN
               IF LENGTH (b010_) = 3
               THEN
                  BEGIN
                     SELECT NVL (knb, 'назва банку')
                       INTO nb_
                       FROM rcukru
                      WHERE GLB = b010_ AND ROWNUM = 1;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        nb_ := 'назва банку';
                  END;
               ELSE
                  BEGIN
                     SELECT NVL (NAME, 'назва банку')
                       INTO nb_
                       FROM rc_bnk
                      WHERE b010 = b010_ AND ROWNUM = 1;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        nb_ := 'назва банку';
                  END;
               END IF;
            ELSE
               nb_ := 'назва банку';
            END IF;
         END IF;

         IF mfo_ != 353575 AND p_value_ IS NULL AND TRIM (d8#E2_) IS NOT NULL
         THEN          --nb_ = 'назва банку' and trim(d8#E2_) is not null then
            p_value_ :=
               NVL (SUBSTR (TRIM (d8#E2_), 1, 70), 'назва банку');
            nb_ := p_value_;
         END IF;

         IF     mfo_ != 353575
            AND p_value_ IS NULL
            AND nb_ != 'назва банку'
         THEN
            p_value_ :=
               NVL (SUBSTR (TRIM (nb_), 1, 70), 'назва банку');
         ELSE
            p_value_ :=
               NVL (SUBSTR (TRIM (p_value_), 1, 70), 'назва банку');
         END IF;
      ELSIF p_i_ = 11
      THEN
         p_kodp_ := '70';

         p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), '99');

         -- для продажи валюты и межбанковских кредитов
         IF mbkOK_ OR d1#E2_ = '30' OR d1#E2_ != '21'
         THEN
            p_value_ := '00';
         END IF;

         IF p_value_ = '99' AND kod_n_ NOT LIKE '1%'
         THEN
            p_value_ := '00';
         END IF;

         IF db#E2_ IS NOT NULL
         THEN
            p_value_ := NVL (SUBSTR (TRIM (db#E2_), 1, 70), '');
         END IF;
      --      ELSIF p_i_ = 10
      --      THEN
      --         p_kodp_ := '61';
      --         p_value_ :=
      --                  NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
      ELSIF p_i_ = 12
      THEN
         p_kodp_ := '59';

         IF TRIM (p_value_) IS NULL AND dc#E2_ IS NOT NULL
         THEN
            p_value_ := NVL (SUBSTR (TRIM (dc#E2_), 1, 70), '');
         ELSE
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
         END IF;

         -- для продажи валюты и межбанковских кредитов
         IF mbkOK_ OR d1#E2_ = '30'
         THEN
            p_value_ := '';
         END IF;
      ELSIF p_i_ = 13
      THEN
         p_kodp_ := '61';

         --для переказу валюти новий показник
         --        IF dat_ >= TO_DATE('13082007','ddmmyyyy') then

         IF TRIM (p_value_) IS NULL AND d61#E2_ IS NOT NULL
         THEN
            IF LENGTH (TRIM (d61#E2_)) > 70
            THEN
               n_ := 70;
            ELSE
               n_ := LENGTH (TRIM (d61#E2_)) - 1;
            END IF;

            p_value_ := NVL (SUBSTR (TRIM (d61#E2_), 1, n_), '');
         ELSE
            p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), '');
         END IF;

         IF TRIM (p_value_) IS NULL AND mfou_ IN (300465)
         THEN
            p_value_ := SUBSTR (nazn_, 1, 70);
         END IF;

         IF mfo_ = 300465 AND nls_ LIKE '1600%' AND nlsk_ LIKE '1500%'
         THEN
            p_value_ :=
               'переказ коштів з рахунку лоро банку-нерезидента'; -- с 16.01.2015 согласно письма Рощиной от 15.01.2015
         END IF;
      ELSIF p_i_ = 14
      THEN
         IF Dat_ <= dat_Izm1_
         THEN
            p_kodp_ := '41';

            -- з 01.06.2009 новий показник
            --  (код переказу валюти вiдповiдно до платiжного календаря)
            IF mfo_ = 353575
            THEN
               p_value_ :=
                  NVL (SUBSTR (TRIM (p_value_), 1, 3),
                       'код переказу');
            ELSE
               IF TRIM (p_value_) IS NULL AND de#E2_ IS NOT NULL
               THEN
                  p_value_ :=
                     NVL (SUBSTR (TRIM (de#E2_), 1, 3),
                          'код переказу');
               ELSE
                  p_value_ :=
                     NVL (SUBSTR (TRIM (p_value_), 1, 3),
                          'код переказу');
               END IF;
            END IF;

            IF     mfo_ != 353575
               AND TRIM (d1#E2_) NOT IN ('23', '24', '34', '35')
            THEN
               p_value_ := '999';
            END IF;

            IF     mfo_ != 353575
               AND TRIM (d1#E2_) IN ('23', '24', '34', '35')
               AND p_value_ = '999'
            THEN
               p_value_ := '000';
            END IF;
         END IF;
      ELSE
         p_kodp_ := 'NN';
      END IF;
   END;

-----------------------------------------------------------------------------
BEGIN
   logger.info (
      'P_FE2_NN: Begin for datf = ' || TO_CHAR (dat_, 'dd/mm/yyyy'));

   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';

   -------------------------------------------------------------------
   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_PROV_TEMP';

   -------------------------------------------------------------------
   -- свой МФО
   mfo_ := F_Ourmfo ();

   -- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM BANKS
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   -------------------------------------------------------------------
   -- параметры формирования файла
   p_proc_set (kodf_,
               sheme_,
               nbuc1_,
               typ_);
   --- выбор курса долара для пересчета суммы
   kurs_ := f_ret_kurs (840, dat_);
   ourOKPO_ := LPAD (F_Get_Params ('OKPO', NULL), 8, '0');

   BEGIN
      SELECT DECODE (GLB, 0, '0', LPAD (TO_CHAR (GLB), 3, '0'))
        INTO ourGLB_
        FROM rcukru
       WHERE mfo = mfo_ AND ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ourGLB_ := NULL;
   END;

   -- з 01.06.2009 для переказу безготiвковоi iнвалюти включаються операцii
   -- >=1000000$  (було 5000000$)
   IF dat_ >= TO_DATE ('01062009', 'ddmmyyyy')
   THEN
      gr_sum_ := 100;                                               --1000000;
   END IF;

   -- з 11.02.2014 для переказу безгот.iнвалюти включаються операцii >=1000.00$
   IF dat_ >= TO_DATE ('11022014', 'ddmmyyyy')
   THEN
      gr_sum_ := 100000;
   END IF;

   sum_kom := gl.p_icurval (840, 100000, dat_);                -- сума комiсiї

   kol_ref_ := 0;

   IF     mfou_ = 300465
      AND mfo_ != mfou_
      AND Dat_ > TO_DATE ('28072009', 'ddmmyyyy')
   THEN
      SELECT COUNT (*)
        INTO kol_ref_
        FROM arc_rrp
       WHERE     dat_a >= Dat_
             AND dk = 3
             AND nlsb LIKE '2909%'
             AND nazn LIKE '#E2;%'
             AND TRIM (d_rec) IS NOT NULL
             AND d_rec LIKE '%D' || TO_CHAR (Dat_, 'yymmdd') || '%';
   END IF;

   IF     ( (mfou_ = 300465 AND mfou_ = mfo_) OR mfou_ <> 300465)
      AND kol_ref_ = 0
   THEN
      -- отбор проводок, удовлетворяющих условию
      -- надходження вiд нерезидентiв
      INSERT INTO OTCN_PROV_TEMP (ko,
                                  rnk,
                                  REF,
                                  tt,
                                  accd,
                                  nlsd,
                                  kv,
                                  acck,
                                  nlsk,
                                  nazn,
                                  s_nom,
                                  s_eqv)
         SELECT *
           FROM (SELECT '3' ko,
                        ca.rnk,
                        o.REF,
                        tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.nazn,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
                   FROM provodki o, cust_acc ca
                  WHERE     o.fdat = dat_
                        AND o.kv NOT IN (959, 961, 962, 964, 980)
                        AND (   (    SUBSTR (o.nlsd, 1, 4) IN
                                        ('2600', '2620')
                                 AND SUBSTR (o.nlsk, 1, 4) IN
                                        ('1919', '2909', '3739')
                                 AND (   (mfou_ = 300465 AND mfou_ <> mfo_)
                                      OR mfou_ = 380764))               -- BAP
                             OR (    SUBSTR (o.nlsd, 1, 4) IN ('2909')
                                 AND SUBSTR (o.nlsk, 1, 4) IN
                                        ('1919', '3739')
                                 AND mfou_ = 333368)
                             OR (    o.nlsd LIKE '2809%'
                                 AND o.nlsk LIKE '1500%'
                                 AND mfo_ = 300120)
                             OR (    o.nlsd LIKE '3800%'
                                 AND                         -- 12.03.2010 OAB
                                    o.nlsk LIKE '1500%'
                                 AND mfo_ = 300120)
                             OR (    o.nlsd LIKE '3800%'
                                 AND                         -- 29.12.2010 OAB
                                    o.nlsk LIKE '1500%'
                                 AND mfo_ = 380623)
                             OR (    SUBSTR (o.nlsd, 1, 4) IN
                                        ('1502',
                                         '1511',
                                         '1512',
                                         '1515',
                                         '1516',
                                         '1522',
                                         '1523',
                                         '1524',
                                         '1525',
                                         '1600',
                                         '1602',
                                         '1623',
                                         '1624',
                                         '1811',
                                         '1819',
                                         '1911',
                                         '1919',
                                         '2520',
                                         '2530',
                                         '2541',
                                         '2542',
                                         '2544',
                                         '2545',
                                         '2600',
                                         '2602',
                                         '2620',
                                         '2625',
                                         '2650',
                                         '2901',
                                         '2909',
                                         '3510',
                                         '3519',
                                         '3660',           -- добавил 06.02.09
                                         '3661',             -- 3660,3661,3668
                                         '3668')
                                 -- исключил 18.08.2008                             '3720',
                                 --                                                 '3739'  )
                                 AND SUBSTR (o.nlsk, 1, 4) IN
                                        ('1500',
                                         '1600',
                                         '3720',
                                         '3739',
                                         '3900',
                                         '2909')
                                 AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) !=
                                        'конв')
                             OR (    o.nlsd LIKE '1919%'
                                 AND o.nlsk LIKE '1500%'
                                 AND mfo_ IN (300465, 300205, 380764)
                                 AND SUBSTR (LOWER (TRIM (o.nazn)), 1, 4) =
                                        'конв')
                             OR (    o.nlsd LIKE '191992%'
                                 AND (   o.nlsk LIKE '1500%'
                                      OR o.nlsk LIKE '1600%')
                                 AND mfo_ IN (300465))
                             OR (    o.nlsd IN ('37394501547')
                                 AND                            --,'37396506')
                                    o.nlsk LIKE '1500%'
                                 AND mfo_ IN (300465))
                             OR (    o.nlsd LIKE '15_8%'
                                 AND (   o.nlsk LIKE '1500%'
                                      OR o.nlsk LIKE '1600%')
                                 AND mfo_ IN (300465))
                             OR (    (   o.nlsd LIKE '292490204%'
                                      OR o.nlsd LIKE '292460205%')
                                 AND                             -- 03/01/2013
                                    o.nlsk LIKE '1500%'
                                 AND mfo_ IN (300465))
                             OR (    (   o.nlsd LIKE '292430003718%'
                                      OR o.nlsd LIKE '292460003717%')
                                 AND                             -- 22/07/2013
                                    o.nlsk LIKE '1500%'
                                 AND mfo_ IN (300465))
                             OR (    o.nlsd LIKE '3800%'         -- 29/07/2012
                                 AND SUBSTR (o.nlsk, 1, 4) IN
                                        ('1500', '1600')
                                 AND mfo_ IN (300465)
                                 AND REF IN
                                        (SELECT REF
                                           FROM oper
                                          WHERE (   (    (   nlsa LIKE '70%'
                                                          OR nlsa LIKE '71%')
                                                     AND (   nlsb LIKE
                                                                '1500%'
                                                          OR nlsb LIKE
                                                                '1600%'))
                                                 OR (    (   nlsa LIKE
                                                                '1500%'
                                                          OR nlsa LIKE
                                                                '1600%')
                                                     AND (   nlsb LIKE '70%'
                                                          OR nlsb LIKE '71%'))))
                                 AND gl.p_icurval (o.kv, o.s * 100, dat_) >
                                        sum_kom))
                        AND o.accd = ca.acc);

      -- удаляем проводки пополнения коррсчета (в OPER Дт 1500 Кт 1500)
      DELETE FROM otcn_prov_temp
            WHERE     REF IN (SELECT a.REF
                                FROM oper a
                               WHERE     a.REF IN (SELECT b.REF
                                                     FROM otcn_prov_temp b)
                                     AND a.nlsa LIKE '1500%'
                                     AND a.nlsb LIKE '1500%')
                  AND SUBSTR (LOWER (TRIM (nazn)), 1, 4) != 'конв';

      -- удаляем проводки пополнения коррсчета с ЛОРО счета(Дт 1600 Кт 1500)
      IF mfo_ <> 300465
      THEN
         DELETE FROM otcn_prov_temp
               WHERE REF IN (SELECT a.REF
                               FROM oper a
                              WHERE     a.REF IN (SELECT b.REF
                                                    FROM otcn_prov_temp b)
                                    AND a.nlsa LIKE '1600%'
                                    AND a.nlsb LIKE '1500%');
      END IF;

      -- для MFO=300465 удаляем проводки у которых MFOA<>MFOB проводки областей
      IF mfo_ = 300465
      THEN
         DELETE FROM otcn_prov_temp
               WHERE REF IN (SELECT a.REF
                               FROM oper a
                              WHERE     a.REF IN (SELECT b.REF
                                                    FROM otcn_prov_temp b)
                                    AND a.mfoa != a.mfob);
      END IF;

      -- для MFO=380764 удаляем проводки у которых назн.платежа "Списание средств согласно свифт"
      IF mfo_ = 380764
      THEN
         DELETE FROM otcn_prov_temp
               WHERE nlsd LIKE '1919%' AND nlsk LIKE '1500%'; -- and LOWER (nazn) like '%списание средств согласно свифт%';
      END IF;

      -- удаляем проводки Дт 1600 Кт 1500
      -- изменения от 04.02.2015
      -- по письму Рощиной от 15.01.2015 года будем включать такие проводки
      --if mfo_ = 300465 then
      --    delete from otcn_prov_temp
      --    where nlsd like '1600%'
      --    and nlsk like '1500%';
      --end if;

      -- удаляем проводки которые имеют код страны 804 Демарк
      IF mfo_ IN (353575, 380623)
      THEN
         DELETE FROM otcn_f70_temp
               WHERE     nlsd LIKE '3800%'
                     AND nlsk LIKE '1500%'
                     AND REF IN (SELECT a.REF
                                   FROM oper a, operw a1
                                  WHERE     a.REF IN (SELECT b.REF
                                                        FROM otcn_f70_temp b)
                                        AND a.nlsa LIKE '7%'
                                        AND a.nlsb LIKE '1500%'
                                        AND a.REF = a1.REF
                                        AND a1.tag = 'D6#70'
                                        AND TRIM (a1.VALUE) = '804');
      END IF;

      -- удаляем проводки комиссии (Дт 7100 Кт 1500)
      DELETE FROM otcn_prov_temp
            WHERE     REF IN (SELECT a.REF
                                FROM oper a
                               WHERE     a.REF IN (SELECT b.REF
                                                     FROM otcn_prov_temp b)
                                     AND a.nlsa LIKE '1500%'
                                     AND a.nlsb LIKE '7100%'
                                     AND a.dk = 0)
                  AND ROUND (s_eqv / kurs_, 0) < 100000;
   ELSE
      -- отбор проводок, удовлетворяющих условию
      -- надходження вiд нерезидентiв
      INSERT INTO OTCN_PROV_TEMP (ko,
                                  rnk,
                                  REF,
                                  tt,
                                  accd,
                                  nlsd,
                                  kv,
                                  acck,
                                  nlsk,
                                  nazn,
                                  s_nom,
                                  s_eqv)
         SELECT *
           FROM (SELECT /*+NO_MERGE(v) PUSH_PRED(v) */
                       '3' ko,
                        ca.rnk,
                        o.REF,
                        tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.nazn,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, dat_) s_eqv
                   FROM provodki o,
                        cust_acc ca,
                        (SELECT SUBSTR (
                                   d_rec,
                                   6 + INSTR (d_rec, '#CREF:'),
                                     INSTR (
                                        SUBSTR (d_rec,
                                                6 + INSTR (d_rec, '#CREF:')),
                                        '#')
                                   - 1)
                                   REF
                           FROM arc_rrp
                          WHERE     dat_a >= Dat_
                                AND dk = 3
                                AND nlsb LIKE '2909%'
                                AND nazn LIKE '#E2;%'
                                AND TRIM (d_rec) IS NOT NULL
                                AND d_rec LIKE
                                          '%D'
                                       || TO_CHAR (Dat_, 'yymmdd')
                                       || '%') v
                  WHERE     o.kv != 980
                        AND o.fdat BETWEEN Dat_ - 10 AND dat_
                        AND o.REF = v.REF
                        AND o.accd = ca.acc);
   END IF;

   OPEN c_main;

   LOOP
      FETCH c_main
         INTO ko_,
              kod_obl_,
              rnk_,
              okpo1_,
              nmk_,
              k040_,
              adr_,
              k110_,
              codc_,
              sum1_,
              sumk1_;

      EXIT WHEN c_main%NOTFOUND;
      rez_ := MOD (codc_, 2);

      -- 16.06.2009 изменил на следующее
      IF LENGTH (TRIM (okpo1_)) <= 8
      THEN
         okpo1_ := LPAD (TRIM (okpo1_), 8, '0');
      ELSE
         okpo1_ := LPAD (TRIM (okpo1_), 10, '0');
      END IF;

      -- для банков по коду ОКПО из RCUKRU(IKOD)
      -- определяем код банка поле GLB
      IF codc_ IN (1, 2)
      THEN
         BEGIN
            SELECT GLB
              INTO okpo1_
              FROM rcukru
             WHERE TRIM (ikod) = TRIM (okpo1_) AND ROWNUM = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;

      -- для физлиц резидентов не имеющих OKPO
      --определяем серию и номер паспорта из PERSON
      IF     codc_ = 5
         AND TRIM (okpo_) IN
                ('99999', '999999999', '00000', '000000000', '0000000000')
      THEN
         BEGIN
            SELECT ser, numdoc
              INTO ser_, numdoc_
              FROM person
             WHERE rnk = rnk_ AND ROWNUM = 1;

            okpo_ := TRIM (ser_) || ' ' || TRIM (numdoc_);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;

      ---переказ безготiвковоi валюти
      OPEN opl_dok;

      LOOP
         FETCH opl_dok
            INTO ko_1,
                 ref_,
                 tt_,
                 acc_,
                 nls_,
                 kv_,
                 acck_,
                 nlsk_,
                 nazn_,
                 sum0_,
                 sumk0_;

         EXIT WHEN opl_dok%NOTFOUND;

         okpo_ := okpo1_;
         ttd_ := NULL;
         nlsdd_ := NULL;
         d1#E2_ := NULL;
         d2#E2_ := NULL;
         d3#E2_ := NULL;
         d4#E2_ := NULL;
         d6#E2_ := NULL;
         d7#E2_ := NULL;
         d8#E2_ := NULL;
         db#E2_ := NULL;
         dc#E2_ := NULL;
         dc1#E2_ := '';
         d61#e2_ := NULL;
         de#E2_ := NULL;
         kol_61 := 0;

         mbkOK_ := FALSE;
         kod_b_ := NULL;

         IF ko_ = '3' AND ROUND (sumk0_ / kurs_, 0) > gr_sum_
         THEN
            formOk_ := TRUE;

            dig_ := f_ret_dig (kv_) * 100;

            -- сумма должна быть в единицах валюты

            IF ko_ = ko_1
            THEN
               IF typ_ > 0
               THEN
                  nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
               ELSE
                  nbuc_ := nbuc1_;
               END IF;

               refd_ := ref_;

               -- OAB добавил 18.08.08 по просьбе банка Петрокоммерц
               -- определяем код страны для перечисления валюты
               -- 25.07.2009 для всех банков определяем код страны
               -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
               BEGIN
                  SELECT SUBSTR (VALUE, 2, 3)
                    INTO d6#E2_
                    FROM operw
                   WHERE     REF = ref_
                         AND tag LIKE 'n%'
                         AND SUBSTR (TRIM (VALUE), 1, 1) IN
                                ('O', 'P', 'О', 'П');
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     BEGIN
                        SELECT SUBSTR (VALUE, 1, 3)
                          INTO d6#E2_
                          FROM operw
                         WHERE     REF = ref_
                               AND tag LIKE 'n%'
                               AND SUBSTR (TRIM (VALUE), 1, 1) NOT IN
                                      ('O', 'P', 'О', 'П');
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           BEGIN
                              SELECT SUBSTR (VALUE, 1, 70)
                                INTO d6#E2_
                                FROM operw
                               WHERE REF = ref_ AND tag = 'D6#70';
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 BEGIN
                                    SELECT SUBSTR (VALUE, 1, 70)
                                      INTO d6#E2_
                                      FROM operw
                                     WHERE REF = ref_ AND tag = 'D6#E2';
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       d6#E2_ := NULL;
                                 END;
                           END;
                     END;
               END;

               BEGIN
                  SELECT SUBSTR (VALUE, 1, 3)
                    INTO kod_g_
                    FROM OPERW
                   WHERE REF = ref_ AND tag = 'KOD_G';

                  IF    ASCII (SUBSTR (kod_g_, 1, 1)) < 48
                     OR ASCII (SUBSTR (kod_g_, 1, 1)) > 57
                  THEN
                     BEGIN
                        SELECT NVL (kodc, '000')
                          INTO kod_g_
                          FROM bopcount
                         WHERE TRIM (iso_countr) = TRIM (kod_g_);
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           kod_g_ := '000';
                     END;
                  END IF;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     BEGIN
                        SELECT '804'
                          INTO kod_g_
                          FROM OPERW
                         WHERE     REF = ref_
                               AND tag LIKE '59%'
                               AND SUBSTR (TRIM (VALUE), 1, 3) = '/UA';
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           BEGIN
                              SELECT '804'
                                INTO kod_g_
                                FROM OPERW
                               WHERE     REF = ref_
                                     AND tag LIKE '59%'
                                     AND INSTR (UPPER (TRIM (VALUE)),
                                                'UKRAINE') > 0;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 kod_g_ := NULL;
                           END;
                     END;
               END;

               IF d6#E2_ IS NULL AND TRIM (kod_g_) IS NOT NULL
               THEN
                  d6#E2_ := kod_g_;
               END IF;

               IF d6#E2_ IS NULL OR d6#E2_ NOT IN ('804', 'UKR')
               THEN
                  BEGIN
                       SELECT p.pid, MIN (p.id), MAX (p.id)
                         INTO pid_, id_min_, id_
                         FROM contract_p p
                        WHERE p.REF = ref_
                     GROUP BY p.pid;

                     SELECT 20 + t.id_oper,
                            t.name,
                            TO_CHAR (t.dateopen, 'ddmmyyyy'),
                            t.bankcountry,
                            t.bank_code,
                            t.benefbank,
                            TRIM (t.aim)
                       INTO D1#E2_,
                            D2#E2_,
                            D3#E2_,
                            D6#E2_,
                            D7#E2_,
                            D8#E2_,
                            DB#E2_
                       FROM top_contracts t
                      WHERE t.pid = pid_;                   -- and p.kv=t.kv ;

                     IF LENGTH (TRIM (D7#E2_)) = 3
                     THEN
                        D7#E2_ := D7#E2_ || '0000000';
                     END IF;

                     BEGIN
                        SELECT MAX (TRIM (name))
                          INTO DC#E2_max
                          FROM tamozhdoc
                         WHERE pid = pid_ AND id = id_;

                        SELECT COUNT (*)
                          INTO kol_61
                          FROM tamozhdoc
                         WHERE pid = pid_ AND id = id_;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           DC#E2_ := NULL;
                     END;

                     IF DC#E2_max IS NULL
                     THEN
                        BEGIN
                           SELECT MAX (TRIM (name))
                             INTO DC#E2_max
                             FROM tamozhdoc
                            WHERE pid = pid_ AND id = id_min_;

                           SELECT COUNT (*)
                             INTO kol_61
                             FROM tamozhdoc
                            WHERE pid = pid_ AND id = id_min_;

                           id_ := id_min_;
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              DC#E2_ := NULL;
                        END;
                     END IF;

                     IF DC#E2_max IS NOT NULL
                     THEN
                        BEGIN
                           SELECT TO_CHAR (t.datedoc, 'ddmmyyyy'),
                                     LPAD (TRIM (c.cnum_cst), 9, '#')
                                  || '/'
                                  || SUBSTR (c.cnum_year, -1)
                                  || '/'
                                  || LPAD (DC#E2_max, 6, '0')
                             INTO D4#E2_, DC#E2_
                             FROM tamozhdoc t, customs_decl c
                            WHERE     t.pid = pid_
                                  AND t.id = id_
                                  AND TRIM (t.name) = TRIM (DC#E2_max)
                                  AND TRIM (c.cnum_num) = TRIM (t.name)
                                  AND TRIM (c.f_okpo) = TRIM (okpo_);
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              NULL;
                        END;

                        IF kol_61 <= 3
                        THEN
                           FOR k
                              IN (SELECT name,
                                         TO_CHAR (datedoc, 'ddmmyyyy')
                                            DATEDOC
                                    FROM tamozhdoc
                                   WHERE     pid = pid_
                                         AND id = id_
                                         AND TRIM (name) != TRIM (DC#E2_max))
                           LOOP
                              SELECT    LPAD (TRIM (c.cnum_cst), 9, '#')
                                     || '/'
                                     || SUBSTR (c.cnum_year, -1)
                                     || '/'
                                INTO DC1#E2_
                                FROM customs_decl c
                               WHERE     TRIM (c.cnum_num) = TRIM (k.name)
                                     AND TRIM (c.f_okpo) = TRIM (okpo_);

                              D61#E2_ :=
                                    D61#E2_
                                 || DC1#E2_
                                 || TRIM (k.name)
                                 || ' '
                                 || k.datedoc
                                 || ',';
                           END LOOP;
                        ELSE
                           D61#E2_ :=
                                 'оплата за'
                              || TO_CHAR (kol_61)
                              || '-ма ВМД';
                        END IF;
                     END IF;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        NULL;
                     WHEN TOO_MANY_ROWS
                     THEN
                        NULL; -- если платеж по нескольким контрактам, то пусть разбивают сумму и вводят реквизиты сами
                  END;

                  IF nls_ LIKE '1919%' OR nls_ LIKE '3739%'
                  THEN
                     -- если это подбор корсчета
                     IF tt_ = 'NOS'
                     THEN
                        -- то ищем сязанную операцию, которая предшествовала NOS
                        refd_ := TO_NUMBER (TRIM (f_dop (ref_, 'NOS_R')));

                        IF refd_ IS NULL
                        THEN
                           BEGIN
                              SELECT REF
                                INTO refd_
                                FROM oper
                               WHERE     vdat BETWEEN TO_DATE (dat_) - 7
                                                  AND dat_
                                     AND nlsb = nls_
                                     AND kv = kv_
                                     AND refl IN (ref_);
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 refd_ := NULL;
                           END;
                        END IF;

                        -- если нашли предшествующую операцию, то выбираем рекизиты счетов
                        IF refd_ IS NULL
                        THEN
                           BEGIN
                              SELECT p.REF,
                                     p.tt,
                                     p.NLSD,
                                     p.accd
                                INTO refd_,
                                     ttd_,
                                     nlsdd_,
                                     accdd_
                                FROM provodki p
                               WHERE p.REF = ref_ AND p.acck = acc_;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 refd_ := NULL;
                           END;
                        END IF;

                        -- если нашли предшествующую операцию, то выбираем рекизиты клиентов
                        IF refd_ IS NOT NULL AND refd_ != ref_
                        THEN
                           BEGIN
                              SELECT c.rnk,
                                     TRIM (c.okpo),
                                     c.nmk,
                                     TO_CHAR (c.country),
                                     c.adr,
                                     NVL (c.ved, '00000'),
                                     c.codcagent,
                                     p.tt,
                                     p.NLSD,
                                     p.accd
                                INTO rnk_,
                                     okpo_,
                                     nmk_,
                                     k040_,
                                     adr_,
                                     k110_,
                                     codc_,
                                     ttd_,
                                     nlsdd_,
                                     accdd_
                                FROM provodki p, cust_acc ca, customer c
                               WHERE     p.REF = refd_
                                     AND p.acck = acc_
                                     AND p.accd = ca.acc --изменил на условие строкой выше 14.03.2008
                                     AND ca.rnk = c.rnk;

                              -- для банков по коду ОКПО из RCUKRU(IKOD)
                              -- определяем код банка поле GLB
                              IF codc_ IN (1, 2)
                              THEN
                                 okpo_ := ourGLB_;
                              END IF;

                              IF sheme_ = 'G' AND typ_ > 0
                              THEN
                                 nbuc_ :=
                                    NVL (f_codobl_tobo (accdd_, typ_),
                                         nbuc1_);
                              ELSE
                                 nbuc_ := nbuc1_;
                              END IF;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 NULL;
                           END;
                        END IF;

                        IF refd_ IS NOT NULL
                        THEN
                           -- если предшествующая операция - ФОРЕКС
                           IF NVL (ttd_, '***') LIKE 'FX%'
                           THEN
                              -- то инициатор проводки - сам банк, поэтому берем его код из RCUKRU
                              okpo_ := ourGLB_;
                              codc_ := 1;

                              BEGIN
                                 -- берем рекизиты из модуля ФОРЕКС
                                 SELECT DECODE (kva, 980, '30', '28'),
                                        ntik,
                                        TO_CHAR (dat, 'ddmmyyyy')
                                   INTO D1#E2_, D2#E2_, D3#E2_
                                   FROM fx_deal
                                  WHERE refb = refd_;
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    NULL;
                              END;

                              IF D1#E2_ = '30'
                              THEN
                                 formOk_ := FALSE;
                              END IF;
                           ELSE
                              -- если не ФОРЕКС, то возможно "поможет" модуль "Экпортно-Импортные контракты"
                              BEGIN
                                   SELECT p.pid, MIN (p.id), MAX (p.id)
                                     INTO pid_, id_min_, id_
                                     FROM contract_p p
                                    WHERE p.REF = refd_
                                 GROUP BY p.pid;

                                 SELECT 20 + t.id_oper,
                                        t.name,
                                        TO_CHAR (t.dateopen, 'ddmmyyyy'),
                                        t.bankcountry,
                                        t.bank_code,
                                        t.benefbank,
                                        TRIM (t.aim)
                                   INTO D1#E2_,
                                        D2#E2_,
                                        D3#E2_,
                                        D6#E2_,
                                        D7#E2_,
                                        D8#E2_,
                                        DB#E2_
                                   FROM top_contracts t
                                  WHERE t.pid = pid_; -- and p.kv=t.kv - Инна сказала, что это условие лишнее (платеж м.б. в другой валюте)

                                 IF LENGTH (TRIM (D7#E2_)) = 3
                                 THEN
                                    D7#E2_ := D7#E2_ || '0000000';
                                 END IF;

                                 BEGIN
                                    SELECT MAX (TRIM (name))
                                      INTO DC#E2_max
                                      FROM tamozhdoc
                                     WHERE pid = pid_ AND id = id_;

                                    SELECT COUNT (*)
                                      INTO kol_61
                                      FROM tamozhdoc
                                     WHERE pid = pid_ AND id = id_;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       DC#E2_ := NULL;
                                 END;

                                 IF DC#E2_max IS NULL
                                 THEN
                                    BEGIN
                                       SELECT MAX (TRIM (name))
                                         INTO DC#E2_max
                                         FROM tamozhdoc
                                        WHERE pid = pid_ AND id = id_min_;

                                       SELECT COUNT (*)
                                         INTO kol_61
                                         FROM tamozhdoc
                                        WHERE pid = pid_ AND id = id_min_;

                                       id_ := id_min_;
                                    EXCEPTION
                                       WHEN NO_DATA_FOUND
                                       THEN
                                          DC#E2_ := NULL;
                                    END;
                                 END IF;

                                 IF DC#E2_max IS NOT NULL
                                 THEN
                                    BEGIN
                                       SELECT TO_CHAR (t.datedoc, 'ddmmyyyy'),
                                                 LPAD (TRIM (c.cnum_cst),
                                                       9,
                                                       '#')
                                              || '/'
                                              || SUBSTR (c.cnum_year, -1)
                                              || '/'
                                              || LPAD (DC#E2_max, 6, '0')
                                         INTO D4#E2_, DC#E2_
                                         FROM tamozhdoc t, customs_decl c
                                        WHERE     t.pid = pid_
                                              AND t.id = id_
                                              AND TRIM (t.name) =
                                                     TRIM (DC#E2_max)
                                              AND TRIM (c.cnum_num) =
                                                     TRIM (t.name)
                                              AND TRIM (c.f_okpo) =
                                                     TRIM (okpo_);
                                    EXCEPTION
                                       WHEN NO_DATA_FOUND
                                       THEN
                                          NULL;
                                    END;

                                    IF kol_61 <= 3
                                    THEN
                                       FOR k
                                          IN (SELECT name,
                                                     TO_CHAR (datedoc,
                                                              'ddmmyyyy')
                                                        DATEDOC
                                                FROM tamozhdoc
                                               WHERE     pid = pid_
                                                     AND id = id_
                                                     AND TRIM (name) !=
                                                            TRIM (DC#E2_max))
                                       LOOP
                                          SELECT    LPAD (TRIM (c.cnum_cst),
                                                          9,
                                                          '#')
                                                 || '/'
                                                 || SUBSTR (c.cnum_year, -1)
                                                 || '/'
                                            INTO DC1#E2_
                                            FROM customs_decl c
                                           WHERE     TRIM (c.cnum_num) =
                                                        TRIM (k.name)
                                                 AND TRIM (c.f_okpo) =
                                                        TRIM (okpo_);

                                          D61#E2_ :=
                                                D61#E2_
                                             || DC1#E2_
                                             || TRIM (k.name)
                                             || ' '
                                             || k.datedoc
                                             || ',';
                                       END LOOP;
                                    ELSE
                                       D61#E2_ :=
                                             'оплата за '
                                          || TO_CHAR (kol_61)
                                          || '-ма ВМД';
                                    END IF;
                                 END IF;
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    NULL;
                                 WHEN TOO_MANY_ROWS
                                 THEN
                                    NULL; -- если платеж по нескольким контрактам, то пусть разбивают сумму и вводят реквизиты сами
                              END;
                           END IF;
                        ELSE
                           refd_ := ref_;
                        END IF;
                     ELSE
                        refd_ := ref_;
                     END IF;
                  END IF;

                  -- по межбанку нужно проверять срок кредита
                  IF    SUBSTR (nls_, 1, 3) IN ('151', '152', '161', '162')
                     OR SUBSTR (nlsdd_, 1, 3) IN ('151', '152', '161', '162')
                  THEN
                     IF nlsdd_ IS NOT NULL
                     THEN
                        s180_ := fs180 (accdd_, '1', dat_);
                     ELSE
                        s180_ := fs180 (acc_, '1', dat_);
                     END IF;

                     -- если срок кредита меньше месяца, то не берем его
                     IF s180_ IN ('1', '2', '3', '4', '5')
                     THEN
                        formOk_ := FALSE;
                     ELSE
                        mbkOK_ := TRUE;
                     END IF;
                  END IF;

                  IF formOk_
                  THEN
                     nnnn_ := nnnn_ + 1;
                     -- код валюти
                     p_ins (nnnn_, '10', LPAD (kv_, 3, '0'));

                     -- сума в единицах валюты (код 12)
                     p_ins (nnnn_, '20', TO_CHAR (ROUND (sum0_ / dig_, 0)));

                     IF okpo_ = ourOKPO_
                     THEN
                        okpo_ := ourGLB_;
                        codc_ := 1;
                     END IF;

                     p_ins (nnnn_, '31', TRIM (okpo_));

                     IF okpo_ = '0'
                     THEN
                        -- код резидентностi
                        p_ins (nnnn_, '62', '0');
                     ELSE
                        -- код резидентностi
                        p_ins (nnnn_, '62', TO_CHAR (2 - MOD (codc_, 2)));
                     END IF;

                     -- додатковi параметри
                     n_ := 13;

                     IF     dat_ >= TO_DATE ('01062009', 'ddmmyyyy')
                        AND dat_ <= dat_Izm1_
                     THEN
                        n_ := 14;
                     END IF;

                     FOR i IN 1 .. n_
                     LOOP
                        IF i < 10
                        THEN
                           tag_ := 'D' || TO_CHAR (i) || '#70';
                        ELSIF i = 10
                        THEN
                           tag_ := 'DA#70';
                        ELSIF i = 11
                        THEN
                           tag_ := 'DB#70';
                        ELSIF i = 12
                        THEN
                           tag_ := 'DC#70';
                        ELSIF i = 13
                        THEN
                           tag_ := 'DA#E2';                         --'DD#70';
                        ELSE
                           tag_ := 'DE#E2';
                        END IF;

                        IF i = 1
                        THEN
                           tag_ := 'D1#E2';
                        END IF;

                        -- были доп.реквизиты (D1#E2 - DA#E2)
                        -- изменил 27.08.2007 доп.реквизиты (D1#E2, D2#70 - DC#70)
                        -- изменил 20.11.2007 добавлен доп.реквизит 13 - DD#70
                        -- (вiдомостi про операцiю)
                        IF (   (    dat_ < TO_DATE ('01062009', 'ddmmyyyy')
                                AND ko_ = 3
                                AND i IN (1, 2, 3, 4, 6, 9, 10, 11, 12, 13))
                            OR (    dat_ >= TO_DATE ('01062009', 'ddmmyyyy')
                                AND ko_ = 3
                                AND i IN (1, 6, 9, 10, 13, 14)))
                        THEN
                           BEGIN
                              SELECT TRIM (SUBSTR (VALUE, 1, 70))
                                INTO val_
                                FROM operw
                               WHERE REF = refd_ AND tag = tag_;
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 IF i = 9
                                 THEN
                                    tag_ := 'D7#E2';
                                 ELSIF i = 10
                                 THEN
                                    tag_ := 'D8#E2';
                                 ELSIF i = 13
                                 THEN
                                    tag_ := 'DD#70';
                                 ELSE
                                    tag_ := SUBSTR (tag_, 1, 3) || 'E2';
                                 END IF;

                                 BEGIN
                                    SELECT TRIM (SUBSTR (VALUE, 1, 70))
                                      INTO val_
                                      FROM operw
                                     WHERE REF = refd_ AND tag = tag_;
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       val_ := NULL;
                                 END;
                           END;

                           IF i = 6 AND val_ IS NULL AND D6#E2_ IS NULL
                           THEN
                              BEGIN
                                 SELECT VALUE
                                   INTO D6#E2_
                                   FROM operw
                                  WHERE REF = refd_ AND tag = 'KOD_G';
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    D6#E2_ := NULL;
                              END;
                           END IF;

                           IF i = 9 AND val_ IS NULL AND D7#E2_ IS NULL
                           THEN
                              BEGIN
                                 SELECT TRIM (VALUE)
                                   INTO kod_b_
                                   FROM operw
                                  WHERE REF = refd_ AND tag = 'KOD_B';
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    kod_b_ := NULL;
                              END;

                              IF kod_b_ IS NOT NULL
                              THEN
                                 BEGIN
                                    SELECT DISTINCT r.GLB
                                      INTO D7#E2_
                                      FROM rcukru r
                                     WHERE r.mfo IN
                                              (SELECT DISTINCT f.mfo
                                                 FROM forex_alien f
                                                WHERE     TRIM (f.kod_b) =
                                                             kod_b_
                                                      AND ROWNUM = 1);
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       D7#E2_ := NULL;
                                 END;
                              END IF;
                           END IF;

                           IF i = 10 AND val_ IS NULL AND D8#E2_ IS NULL
                           THEN
                              BEGIN
                                 SELECT TRIM (VALUE)
                                   INTO kod_b_
                                   FROM operw
                                  WHERE REF = refd_ AND tag = 'KOD_B';
                              EXCEPTION
                                 WHEN NO_DATA_FOUND
                                 THEN
                                    kod_b_ := NULL;
                              END;

                              IF kod_b_ IS NOT NULL
                              THEN
                                 BEGIN
                                    SELECT DISTINCT r.knb
                                      INTO D8#E2_
                                      FROM rcukru r
                                     WHERE r.mfo IN
                                              (SELECT DISTINCT f.mfo
                                                 FROM forex_alien f
                                                WHERE     TRIM (f.kod_b) =
                                                             kod_b_
                                                      AND ROWNUM = 1);
                                 EXCEPTION
                                    WHEN NO_DATA_FOUND
                                    THEN
                                       D8#E2_ := NULL;
                                 END;
                              END IF;
                           END IF;

                           -- код показника та default-значення
                           p_tag (i,
                                  val_,
                                  kodp_,
                                  ref_);
                           -- запис показника
                           p_ins (nnnn_, kodp_, val_);
                        END IF;
                     END LOOP;
                  END IF;
               END IF;
            END IF;
         END IF;
      END LOOP;

      CLOSE opl_dok;
   END LOOP;

   CLOSE c_main;

   ---------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

   ---------------------------------------------------
   INSERT INTO tmp_nbu (kodp,
                        datf,
                        kodf,
                        znap,
                        nbuc)
      SELECT kodp,
             dat_,
             kodf_,
             znap,
             nbuc
        FROM rnbu_trace;

   ----------------------------------------
   DELETE FROM OTCN_TRACE_70
         WHERE kodf = kodf_ AND datf = dat_;

   INSERT INTO OTCN_TRACE_70 (KODF,
                              DATF,
                              USERID,
                              NLS,
                              KV,
                              ODATE,
                              KODP,
                              ZNAP,
                              NBUC,
                              ISP,
                              RNK,
                              ACC,
                              REF,
                              COMM,
                              ND,
                              MDATE,
                              TOBO)
      SELECT kodf_,
             dat_,
             USERID_,
             NLS,
             KV,
             ODATE,
             KODP,
             ZNAP,
             NBUC,
             ISP,
             RNK,
             ACC,
             REF,
             COMM,
             ND,
             MDATE,
             TOBO
        FROM rnbu_trace;

   logger.info ('P_FE2_NN: End for datf = ' || TO_CHAR (dat_, 'dd/mm/yyyy'));
END p_fe2_nn;
/
show err;

PROMPT *** Create  grants  P_FE2_NN ***
grant EXECUTE                                                                on P_FE2_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FE2_NN        to RPBN002;
grant EXECUTE                                                                on P_FE2_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE2_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
