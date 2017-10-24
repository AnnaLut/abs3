

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F71SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F71SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F71SB (
   dat_     DATE,
   sheme_   VARCHAR2 DEFAULT 'G',
   prnk_    NUMBER DEFAULT NULL
)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #D8 для КБ (универсальная)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 25.11.2013 (09.12.2009,24.11.09,26.10.09)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
               sheme_ - схема формирования
               prnk_ - РНК контрагента
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
!!! Эта процедура только для расширенной таблицы или VIEW CUST_BUN (20
    полей и больше) и код клиента у которого есть связанные лица
    содержиться в поле RNKA (в RNKB участвующие клиенты нашего банка или
    пустое значение для не клиентов банка)
%25.11.2013 - Добавлено определение C_REG для C_REG=28
%01.07.2009 - выполнены несущественные изменения и добавлен комментарий
              с пометкой !!!
%04.06.2009 - Берем сумму резерва и для кода 123 (нач.проценты)
%26.08.2008 - общий процент участия вместо 20% с 29.08.2008 будет 10%
%10.07.2008 - Заполняем поле P040 в табл. OTCN_F71_HISTORY вместо табл.
%             OTCN_F71_CUST
%03.06.2008 - для показателя 150 не формируем код NNNN (условный код)
%             т.к. процент от рег.кап. должен быть общий по контрагенту
%07.05.2008 - добавил по замечанию банка Киев вычисление суммы обеспечения
%             всегда как sum_ob_ := Ca_Fq_Zalog(acc_, Dat_);
%             (должна быть общая сумма обеспечения, а не приведенная которая
%              выбиралась из табл. TMP_REZ_RISK)
%01.04.2008 - по счетам залогов дополнительно проверяем остаток на счете
%             на отчетную дату для правильного формирования кода 040.
%             Для погашенных кредитов проверяем остатки на основных счетах,
%             на счетах дисконта и премии и сумму резерва.
%17.03.2008 - при отсутствии проводок в табл.TMP_REZ_RISK вычисляем
%             сумму обеспечения и сумму резерва с помощью функций
%26.02.2008 - для ЦП код 110(общая сумма по договору) формировался не
%              учитывая знак остатка. Исправлено (строка 822-823).
%15.02.2008 - для формирования кода 125(сума резерву) по ЦБ в кл-р KL_F3_29
%             внесен бал.счет 3190 и остаток по этому счету включался
%             в общую сумму активов (показатель 110).
%             Теперь в показатель 110 не включаем код 123(сума нарах.доходiв)
%             и 125 (сума резерву)
%06.02.2008 - код подразделения формируем по значению поля
%             (Способ формирования файлов в разрезе кодов областей) в
%              каталоге отчетов для НБУ используя ф-цию F_CODOBL_TOBO
%              (в версии от 31.01.2008 было значение 5)
%             значение должно равняться значению как для файла "02" схема
%             "G" увеличенным на еденицу
%31.01.2008 - добавлен показатель
%             091ZZZZZZZZZZNNNN0000000 - код подразделения
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_        VARCHAR2 (2)          := '71';
   fmt_         VARCHAR2 (20)         := '9999999990D0000';
   fmtkap_      VARCHAR2 (30)         := '999G999G999G990D99';
   dfmt_        VARCHAR2 (8)          := 'ddmmyyyy';
   ved_         customer.ved%TYPE;
   k110_        VARCHAR2 (5);
   k111_        VARCHAR2 (2);
   reg_         customer.c_reg%TYPE;
   s031_        specparam.s031%TYPE;
   nkd_         specparam.nkd%TYPE;
   pdat_        DATE;
   sum_zd_      NUMBER;
   smax_        NUMBER                := 50000000;
   -- максимальна сума на одного контрагента
   tip_         accounts.tip%TYPE;
   dat1_        DATE;                               -- дата начала декады !!!
   dat2_        DATE;                      -- дата окончания пред. декады !!!
   dc_          INTEGER;
   pog_         BOOLEAN;          -- кредит погашен в течении отчетной декады
   kol_         NUMBER;
   kolvo_       NUMBER;
   ret_         NUMBER;
   nls_         VARCHAR2 (15);
   data_        DATE;
   datrez_      DATE;
   kv_          SMALLINT;
   cust_        SMALLINT;
   kodp_        VARCHAR2 (35);
   znap_        VARCHAR2 (70);
   mfo_         NUMBER;
   mfou_        NUMBER;
   rnk_         NUMBER;
   acc_         NUMBER;
   acc1_        NUMBER;
   vidd_        NUMBER;
   p010_        VARCHAR2 (70);
   p021_        CHAR (1);
   p030_        CHAR (14);
   kod_okpo     VARCHAR2 (10);
   rez_         SMALLINT;
   p040_        SMALLINT;
   p050_        SMALLINT;
   p060_        SMALLINT;
   p070_        VARCHAR2 (4);
   p080_        VARCHAR2 (70);
   p080f_       VARCHAR2 (2);
   p081_        VARCHAR2 (70);
   p085_        VARCHAR2 (70);
   p090k_       VARCHAR2 (20);
   p090_        VARCHAR2 (20);
   p100_        VARCHAR2 (1);
   p111_        DATE;
   p111p_       DATE;
   p112_        DATE;
   p112p_       DATE;
   p113_        DATE;
   f71k_        NUMBER;
   p120_        NUMBER;
   p125_        NUMBER;
   ndk_         NUMBER;
   nd_          NUMBER;
   nnnn_        NUMBER;
   kod_nnnn     VARCHAR2 (4);
   sum_k_       DECIMAL (24);
   sum_sk_      DECIMAL (24);                     -- сума статутного капiталу
   sum_ob_      NUMBER;
   sum_rez_     NUMBER;
   sum_71       DECIMAL (24);
   sum_71o      NUMBER;
   sum_lim      NUMBER;
   sum_proc     NUMBER                :=20;
   srez_        NUMBER;
   ek2_         DECIMAL (24);
   ek3d_        DECIMAL (24);
   ek3k_        DECIMAL (24);
   ek4_         DECIMAL (24);
   p130_        NUMBER;
   p140_        SMALLINT;
   p150_        VARCHAR2 (20);
   s181_        VARCHAR2 (1);
   s080_        VARCHAR2 (2);
   s081_        VARCHAR2 (2);
   s085_        VARCHAR2 (1);
   r013_        VARCHAR2 (1);
   kol_dz       NUMBER;
   pr_          NUMBER (10, 2);
   userid_      NUMBER;
   p_rnk_       NUMBER                := NULL;              -- предыдущий rnk
   p_nd_        NUMBER                := NULL;          -- предыдущий договор
   p_sum_zd_    NUMBER                := NULL;
   p_p111_      DATE                  := NULL;
   p_p112_      DATE                  := NULL;
   p_p090_      VARCHAR2 (20)         := '------';
   p_p080_      VARCHAR2 (20);
   p_p081_      NUMBER;
   p_p130_      NUMBER;
   doda_        VARCHAR2 (100);
   acck_        NUMBER;
   acco_        NUMBER;                                    -- счет овердрафта
   accn_        NUMBER;                                -- счет начисленных %%
   i_opl_       NUMBER                := 0;
   our_reg_     NUMBER;
   b040_        VARCHAR2 (20);
   nbuc_        VARCHAR2 (20);
   nbuc1_       VARCHAR2 (20);
   typ_         NUMBER;
   custtype_    NUMBER;
   sab_         VARCHAR2 (4);
   isp_         NUMBER;
   dbuf_        DATE;
   period_      kl_f00.period%TYPE;
   ddd_         VARCHAR2 (3);
   ncontr_      NUMBER                := 0;
   sum_contr_   NUMBER                := 0;
   sql_         VARCHAR2 (1000);
   f1502_       NUMBER;
   txt_sql      VARCHAR2 (10000);

   TYPE ref_type_curs IS REF CURSOR;

   rezid_       NUMBER;
   flag_over_   BOOLEAN               := FALSE;
   saldo        ref_type_curs;

   CURSOR saldo_ins
   IS
      SELECT   *
          FROM (SELECT a.acc, a.nls, c.nmk, c.rnk, TRIM (f.k081),
                       LPAD (TRIM (c.okpo), 10, '0') okpo,
                       2 - MOD (c.codcagent, 2), c.country, decode(c.c_reg,28,(select max(c_reg) from spr_reg where c_reg<28 and zip_code=(select max(zip_code) from spr_reg where c_reg=c.c_reg and c_dst=c.c_dst)),c.c_reg ) c_reg, c.ved,
                       DECODE (NVL (c.prinsider, 0), 0, 2, 99, 2, 1) prins,
                       a.nbs, a.daos, a.mdate,
                       gl.p_icurval (a.kv, a.lim, dat_), a.kv,
                       DECODE (c.custtype, 3, 2, 1), a.isp,
                       NVL (TRIM (k.ddd), '121') ddd, '1' s081, c.crisk
                  FROM (SELECT s.acc, '9129' nbs, s.nls, s.kv, s.daos,
                               s.mdate, s.lim, s.tip, s.isp
                          FROM accounts s
                         WHERE s.nbs = '8021'
                           AND s.lim > 0
                           AND s.acc NOT IN (SELECT acc
                                               FROM otcn_f71_temp_sb)
                        UNION
                        SELECT a.acc,
                               DECODE (SUBSTR (a.nbs, 1, 1),
                                       '8', SUBSTR (TRIM (doda_), 3, 4),
                                       a.nbs
                                      ) nbs,
                               a.nls, a.kv, a.daos, a.mdate, a.lim, a.tip,
                               a.isp
                          FROM acc_over o, accounts a
                         WHERE EXISTS (
                                  SELECT 1
                                    FROM otcn_f71_history_sb h
                                   WHERE h.datf = dat2_
                                     AND h.acc IN (o.acc, o.acco, o.acc_2067))
                           AND NOT EXISTS (
                                    SELECT 1
                                      FROM otcn_f71_temp_sb t
                                     WHERE t.acc IN
                                                  (o.acc, o.acco, o.acc_2067))
                           AND o.acc = a.acc
                           AND NVL (a.lim, 0) = 0) a,
                       cust_acc ca,
                       customer c,
                       kl_k080 f,
                       kl_f3_29 k
                 WHERE a.acc = ca.acc
                   AND k.kf = '71'
                   AND a.nbs = k.r020
                   AND c.rnk = ca.rnk
                   AND c.codcagent < 7
                   AND c.fs = f.k080(+)
                   AND (prnk_ IS NULL OR c.rnk = prnk_))
         WHERE prins = 1
      ORDER BY okpo, rnk, nbs;

--- виды залогов для кредитного счета
   CURSOR kredit
   IS
      SELECT   b.s031, a.nd                                 --, NVL(c.pawn,90)
          FROM cc_accp a, cc_pawn b, pawn_acc c, accounts d
         WHERE a.accs = acc_
           AND a.acc = c.acc
           AND a.acc = d.acc
           AND d.nbs <> '9031'
           AND (d.dazs IS NULL OR d.dazs > dat_)
           AND d.ostc <> 0
           AND                                           -- добавил 31.03.2008
               c.pawn = b.pawn
      GROUP BY b.s031, a.nd;

-- конртрагенты
   CURSOR c_cust
   IS
      SELECT   rnk, okpo, rez, custtype, p010, p020, p025, p040, p050, p055,
               p060, p085
          FROM otcn_f71_cust_sb
      ORDER BY okpo, rnk;

-- все договора по даному контрагенту
   CURSOR c_cust_dg
   IS
      SELECT   t.acc, t.nd, t.p090, t.p080, t.p081, t.p110, t.p111, t.p112,
               t.p113, t.p160, t.nbs, t.kv, t.ddd, t.p120, t.p125, t.p130,
               t.p150, t.nls, t.fdat, t.isp
          FROM otcn_f71_temp_sb t
         WHERE t.rnk = rnk_
      ORDER BY t.nd, t.p090, t.nbs, t.kv;

-- параметры контрагента и кредитного договора (константы)
   CURSOR basel
   IS
      SELECT DISTINCT kodp, znap
                 FROM rnbu_trace
                WHERE SUBSTR (kodp, 1, 3) IN
                         ('010',
                          '019',
                          '020',
                          '025',
                          '040',
                          '050',
                          '055',
                          '060',
                          '080',
                          '085',
                          '090',
                          '091',
                          '110',
                          '111',
                          '112',
                          '113',
                          '160'
                         )
             ORDER BY SUBSTR (kodp, 4, 10),
                      SUBSTR (kodp, 25),
                      SUBSTR (kodp, 1, 3);

-- процентная ставка
   CURSOR basel1
   IS
      SELECT   kodp, MAX (TO_NUMBER (znap) * 10000)
          FROM rnbu_trace
         WHERE SUBSTR (kodp, 1, 3) IN ('130')
      GROUP BY kodp
      ORDER BY SUBSTR (kodp, 4, 10), SUBSTR (kodp, 254), SUBSTR (kodp, 1, 3);

-- суммирующиеся реквизиты кред. договора
   CURSOR basel2
   IS
      SELECT   kodp, SUM (TO_NUMBER (znap))
          FROM rnbu_trace
         WHERE SUBSTR (kodp, 1, 3) IN
                     ('081', '119', '120','121', '122', '123', '124', '125', '150')
      GROUP BY kodp
      ORDER BY SUBSTR (kodp, 4, 10), SUBSTR (kodp, 25), SUBSTR (kodp, 1, 3);

-------------------------------------------------------------------
   PROCEDURE p_ins (
      p_kodp_   IN   VARCHAR2,
      p_znap_   IN   VARCHAR2,
      p_nls_    IN   VARCHAR2 DEFAULT NULL
   )
   IS
      l_isp_   NUMBER := isp_;
      l_acc_   NUMBER := acc_;
   BEGIN
      IF p_nls_ IS NULL
      THEN
         l_isp_ := NULL;
         l_acc_ := NULL;
      END IF;

      INSERT INTO rnbu_trace
                  (acc, nls, kv, odate, isp, rnk,
                   kodp, znap, nd
                  )
           VALUES (l_acc_, p_nls_, p140_, data_, l_isp_, rnk_,
                   SUBSTR (p_kodp_ || TO_CHAR (rnk_), 1, 35), p_znap_, nd_
                  );
   END;

-------------------------------------------------------------------
   PROCEDURE p_ins_contr
   IS
--- запись реквизитов контрагента
      kodp_   VARCHAR2 (30);
   BEGIN
      IF TRIM (kod_okpo) IN ('00000000', '000000000', '0000000000')
      THEN
         IF rez_ = 2
         THEN
            ncontr_ := ncontr_ + 1;
            kod_okpo := 'IN' || LPAD (TO_CHAR (ncontr_), 8, '0');
         ELSE
            IF custtype_ = 2
            THEN
               BEGIN
                  SELECT LPAD (SUBSTR (TRIM (ser) || TRIM (numdoc), 1, 10),
                               10,
                               '0'
                              )
                    INTO kod_okpo
                    FROM person
                   WHERE rnk = rnk_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kod_okpo := 'RNK' || LPAD (SUBSTR (rnk_, 1, 7), 7, '0');
               END;
            ELSE
               kod_okpo := 'RNK' || LPAD (SUBSTR (rnk_, 1, 7), 7, '0');
            END IF;
         END IF;
      ELSE
         kod_okpo := LPAD (kod_okpo, 10, '0');
      END IF;

      -- определение вида экономической деятельности
      k110_ := NVL (ved_, '00000');

      -- определение кода региона
      IF NVL (reg_, 0) > 0
      THEN
         BEGIN
            SELECT ko
              INTO reg_
              FROM kodobl_reg o
             WHERE o.c_reg = reg_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               reg_ := our_reg_;
         END;
      ELSE
         reg_ := our_reg_;
      END IF;

      -- для нерезидентов обнуляем
      IF rez_ = 2
      THEN
         k110_ := '00000';                        -- вид эконом. деятельности
         p021_ := '2';                             -- код формы собственности
         reg_ := 0;
      END IF;

      -- к_льк_сть у контрагента учасник_в, участь яких 20 та б_льше %% статутного фонду
      IF    (p060_ = 1 AND sum_contr_ < 8000000)
         OR (pog_ AND sum_zd_ = 0)
         OR (pog_ AND p120_ = 0 AND p125_ = 0)
      THEN                                   -- инсайдеры или закрытый договор
         p040_ := 0;
      ELSE
         BEGIN
            IF custtype_ = 2
            THEN                                         -- для ф_зичних ос_б
               SELECT COUNT (*)
                 INTO p040_
                 FROM (SELECT rnkb rnk
                         FROM cust_bun
                        WHERE rnka = rnk_ AND id_rel = 5
                       UNION
                       SELECT rnka rnk
                         FROM cust_bun
                        WHERE rnkb = rnk_ AND id_rel = 5) a;
--             SELECT COUNT(*)
--             into p040_
--             FROM V_CUST_RELPERSONS
--             WHERE rnk=rnk_ AND
--              rel_id = 5;
            ELSE
               SELECT COUNT (*)
                 INTO p040_
                 FROM cust_bun b
                WHERE b.rnka = rnk_
                  AND id_rel IN (1, 4)
                  AND NVL (vaga1, 0) + NVL (vaga2, 0) >= sum_proc;  --20;
--             select count(*)
--             into p040_
--             from V_CUST_RELPERSONS b
--             where b.rnk = rnk_ and
--                   rel_id in (1, 4) and
--                   nvl(VAGA1, 0) + nvl(VAGA2, 0) >= sum_proc;  --20;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p040_ := 0;
         END;
      END IF;

      INSERT INTO otcn_f71_cust_sb
                  (rnk, okpo, rez, custtype, p010, p020, p025,
                   p040, p050, p055,
                   p060, p085
                  )
           VALUES (rnk_, kod_okpo, rez_, custtype_, p010_, p021_, k110_,
                   TO_CHAR (p040_), TO_CHAR (p050_), TO_CHAR (reg_),
                   TO_CHAR (p060_), s085_
                  );

      p_rnk_ := rnk_;
   END;

   PROCEDURE p_ins_kredit (ptype_ IN NUMBER)
   IS
-- запись реквизитов кредитных договоров
   BEGIN
      --- реквизиты контрагента заполняются только при изменении контрагента
      IF p_rnk_ IS NULL OR p_rnk_ <> rnk_
      THEN
         p_ins_contr;
      END IF;

      -- вiдсоток суми фактичної заборгованостi контрагента
      IF ddd_ IN ('119', '120', '121', '123')
      THEN
--   if ddd_ in ( '119', '120', '121', '122', '123') then
         IF p060_ = 1
         THEN                                                    -- инсайдеры
            IF sum_sk_ <> 0
            THEN
               p150_ :=
                  LTRIM (TO_CHAR (ROUND ((ABS (p120_) / sum_sk_) * 100, 4),
                                  fmt_
                                 )
                        );
            ELSE
               p150_ := '0';
            END IF;
         ELSE
            IF sum_k_ <> 0
            THEN
               p150_ :=
                  LTRIM (TO_CHAR (ROUND ((ABS (p120_) / sum_k_) * 100, 4),
                                  fmt_)
                        );
            ELSE
               p150_ := '0';
            END IF;
         END IF;
--       if ddd_ = '122' then
--          p150_:=p150_*sign(0-p120_);
--       end if;
      ELSE
         p150_ := '0';
      END IF;

      -- вартiсть забезпечення кредиту
      IF p120_ <> 0 AND ddd_ IN ('121', '123', '119', '120') AND rezid_ IS NOT NULL
      THEN
         -- выбираем из расчета резерва на конец месяца
         BEGIN
            SELECT soq, szq
              INTO sum_ob_, sum_rez_
              FROM tmp_rez_risk
             WHERE acc = acc_ AND dat = dat_ AND ID = rezid_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sum_ob_ := 0;
               sum_rez_ := 0;
         END;
      -- sum_ob_ := Ca_Fq_Zalog(acc_, Dat_);
      ELSE
      -- добавил 17.03.2008 две нижние строки и закоментировал третью
--      sum_ob_ := Ca_Fq_Zalog(acc_, Dat_);
         sum_rez_ := gl.p_icurval (p140_, rez.ca_f_rezerv (acc_, dat_), dat_);
--       sum_ob_ := 0;
      END IF;

      --07.05.2008 добавил по замечанию банка Киев
      --(должна быть общая сумма обеспечения, а не приведенная)
      -- вартiсть забезпечення кредиту
      IF p120_ <> 0 AND ddd_ IN ('121', '123', '119', '120')
      THEN
         sum_ob_ := ca_fq_zalog (acc_, dat_);
      ELSE
         sum_ob_ := 0;
      END IF;

      p081_ := ROUND (ABS (sum_ob_), 0);

      -- сума резерву по даному рахунку
      IF p120_ <> 0 AND ddd_ IN ('121', '123', '119', '120') AND p070_ NOT LIKE '9%'
      THEN
         NULL;                                            -- уже выбрали выше
      -- sum_rez_ := gl.p_icurval(p140_, rez.ca_f_rezerv(acc_, Dat_), Dat_);
      ELSE
         sum_rez_ := 0;
      END IF;

      p125_ := ROUND (ABS (sum_rez_), 0);

      IF accn_ IS NOT NULL
      THEN
         acc_ := accn_;
      END IF;

      INSERT INTO otcn_f71_temp_sb
                  (rnk, acc, tp, nd, p090, p080, p081, p110,
                   p111, p112, p113, p160, nbs, kv, ddd,
                   p120, p125, p130, p150, nls, fdat, isp
                  )
           VALUES (rnk_, acc_, ptype_, nd_, p090_, p080_, p081_, sum_zd_,
                   p111p_, p112p_, p113_, s080_, p070_, p140_, ddd_,
                   p120_, p125_, p130_, p150_, nls_, data_, isp_
                  );

      INSERT INTO otcn_f71_history_sb
                  (datf, acc, ostf, nd, p080, p081, p090, p110,
                   p111, p112, p130, p040, rnk
                  )
           VALUES (dat_, acc_, p120_, nd_, p080_, p081_, p090_, sum_zd_,
                   p111p_, p112p_, p130_, p040_, rnk_
                  );
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20005,
                                     'rnk='
                                  || rnk_
                                  || ' acc='
                                  || acc_
                                  || ' Ошибка : '
                                  || SQLERRM
                                 );
   END;

---------------------------------------------------------------------------
   PROCEDURE p_over_1 (acc_ IN OUT NUMBER)
   IS
   BEGIN
      IF p070_ = '3578'
      THEN
         accn_ := acc_;

         SELECT COUNT (*)
           INTO kol_dz
           FROM accounts a, int_accn i, accounts b, acc_over c
          WHERE a.acc = accn_
            AND a.acc = i.acra
            AND i.acc = b.acc
            AND b.acc = c.acc_8000;

         IF kol_dz = 0
         THEN
            SELECT (-1) * COUNT (*)
              INTO kol_dz
              FROM accounts a, int_accn i, accounts b, acc_over_archive c
             WHERE a.acc = accn_
               AND a.acc = i.acra
               AND i.acc = b.acc
               AND b.acc = c.acc_8000;
         END IF;

         IF kol_dz > 0
         THEN
            SELECT c.acc, c.acc_9129
              INTO acc_, acco_
              FROM accounts a, int_accn i, accounts b, acc_over c
             WHERE a.acc = accn_
               AND a.acc = i.acra
               AND i.acc = b.acc
               AND b.acc = c.acc_8000;
         ELSIF kol_dz < 0
         THEN
            SELECT c.acc, c.acc_9129
              INTO acc_, acco_
              FROM accounts a, int_accn i, accounts b, acc_over_archive c
             WHERE a.acc = accn_
               AND a.acc = i.acra
               AND i.acc = b.acc
               AND b.acc = c.acc_8000;
         END IF;

         IF kol_dz <> 0
         THEN
            BEGIN
               SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, s.fdat)))
                 INTO sum_71
                 FROM sal s
                WHERE s.acc IN (acc_, acco_) AND s.ost < 0 AND s.fdat = pdat_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_71 := 0;
            END;
         END IF;
      ELSE
         sum_71 := ABS (p120_);

         IF p070_ IN ('2067', '2069', '2096')
         THEN
            BEGIN
               SELECT COUNT (*)
                 INTO kol_dz
                 FROM acc_over c
                WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096)
                  AND NVL (c.sos, 0) <> 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kol_dz := 0;
            END;

            IF kol_dz = 0
            THEN
               BEGIN
                  SELECT (-1) * COUNT (*)
                    INTO kol_dz
                    FROM acc_over_archive c
                   WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096);
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kol_dz := 0;
               END;
            END IF;

            IF kol_dz > 0
            THEN
               BEGIN
                  SELECT NVL (ABS (SUM (gl.p_icurval (s.kv, s.ost, s.fdat))),
                              0
                             )
                    INTO sum_71o
                    FROM sal s, acc_over c
                   WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096)
                     AND NVL (c.sos, 0) <> 1
                     AND s.acc = c.acc
                     AND s.ost < 0
                     AND s.fdat = pdat_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sum_71o := 0;
               END;
            END IF;
         ELSIF p070_ IN ('9129', '9100')
         THEN
            BEGIN
               SELECT COUNT (*)
                 INTO kol_dz
                 FROM acc_over c
                WHERE c.acc_9129 = acc_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kol_dz := 0;
            END;

            IF kol_dz = 0
            THEN
               BEGIN
                  SELECT (-1) * COUNT (*)
                    INTO kol_dz
                    FROM acc_over_archive c
                   WHERE c.acc_9129 = acc_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kol_dz := 0;
               END;
            END IF;

            IF kol_dz > 0
            THEN
               BEGIN
                  SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, s.fdat)))
                    INTO sum_71o
                    FROM sal s, acc_over c
                   WHERE c.acc_9129 = acc_
                     AND s.acc = c.acc
                     AND s.ost < 0
                     AND s.fdat = pdat_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sum_71o := 0;
               END;
            END IF;
         ELSE
            --          sum_71:=ABS(p120_);
            --
            BEGIN
               SELECT COUNT (*)
                 INTO kol_dz
                 FROM acc_over c
                WHERE c.acc = acc_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kol_dz := 0;
            END;

            IF kol_dz = 0
            THEN
               BEGIN
                  SELECT (-1) * COUNT (*)
                    INTO kol_dz
                    FROM acc_over_archive c
                   WHERE c.acc = acc_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     kol_dz := 0;
               END;
            END IF;

            IF kol_dz > 0
            THEN
               BEGIN
                  SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, s.fdat)))
                    INTO sum_71o
                    FROM sal s, acc_over c
                   WHERE c.acc = acc_ AND s.acc = c.acc_9129
                         AND s.fdat = pdat_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     sum_71o := 0;
               END;
            END IF;
         END IF;

         sum_71 := sum_71 + NVL (sum_71o, 0);
      END IF;
   END;

------------------------------------------------------------------
   PROCEDURE p_over_2 (acc_ IN NUMBER)
   IS
      proc_   NUMBER := 0;
   BEGIN
      IF p070_ IN ('2067', '2069', '2096')
      THEN
         IF kol_dz > 0
         THEN
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY), c.datd2, c.nd,
                   gl.p_icurval (p140_, c.sd, dat_)
              INTO p090_, p111p_, p112p_, nd_,
                   sum_71
              FROM acc_over c
             WHERE acc_ IN (c.acc_2067, c.acc_2069, c.acc_2096)
               AND NVL (c.sos, 0) <> 1
               AND ROWNUM = 1;
         ELSE
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY), c.datd2,
                   gl.p_icurval (p140_, c.sd, dat_), NVL (c.pr_9129, 0), c.nd
              INTO p090_, p111p_, p112p_,
                   sum_71, proc_, nd_
              FROM (SELECT   *
                        FROM acc_over_archive
                       WHERE acc_ IN (acc_2067, acc_2069, acc_2096)
                    ORDER BY datd DESC, ndoc DESC) c
             WHERE ROWNUM = 1;
         END IF;
      ELSIF p070_ IN ('9129', '9100')
      THEN
         IF kol_dz > 0
         THEN
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY), c.datd2, c.nd
              INTO p090_, p111p_, p112p_, nd_
              FROM acc_over c
             WHERE c.acc_9129 = acc_ AND NVL (c.sos, 0) <> 1 AND ROWNUM = 1;
         ELSE
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY), c.datd2,
                   gl.p_icurval (p140_, c.sd, dat_), NVL (c.pr_9129, 0), c.nd
              INTO p090_, p111p_, p112p_,
                   sum_71, proc_, nd_
              FROM (SELECT   *
                        FROM acc_over_archive
                       WHERE acc_9129 = acc_
                    ORDER BY datd DESC, ndoc DESC) c
             WHERE ROWNUM = 1;
         END IF;
      ELSE
         IF kol_dz > 0
         THEN
            SELECT c.ndoc, NVL (c.datd, p112_ - c.DAY), c.datd2, c.nd
              INTO p090_, p111p_, p112p_, nd_
              FROM acc_over c
             WHERE c.acc = acc_ AND NVL (c.sos, 0) <> 1;
         ELSE
            SELECT c.ndoc, DECODE (c.datd, NULL, p112_ - c.DAY, c.datd),
                   c.datd2, gl.p_icurval (p140_, c.sd, dat_),
                   NVL (c.pr_komis, 0), c.nd
              INTO p090_, p111p_,
                   p112p_, sum_71,
                   proc_, nd_
              FROM (SELECT   *
                        FROM acc_over_archive
                       WHERE acc = acc_
                    ORDER BY datd DESC, ndoc DESC) c
             WHERE ROWNUM = 1;
         END IF;
      END IF;

      IF kol_dz < 0 AND p130_ = 0
      THEN
         IF proc_ <> 0
         THEN
            p130_ := proc_;
         ELSE
            p130_ := acrn.fproc (acc_, data_ - 1);
         END IF;
      END IF;
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20011,
                                     'Счет овердрафта: acc='
                                  || acc_
                                  || ' ошибка: '
                                  || SQLERRM
                                 );
   END;

------------------------------------------------------------------
   PROCEDURE p_obrab_kd
   IS
-- определение основных параметров КД
   BEGIN
      sum_71 := 0;
      sum_71o := 0;
      sum_lim := 0;

      IF    TRIM (tip_) IN
               ('ODB',
                'SS',
                'SN',
                'SPN',
                'SP',
                'SL',
                'SLN',
                'SDI',
                'SPI',
                'SK0',
                'SK9'
               )
         OR p070_ = '9129'
      THEN
         BEGIN
            SELECT n.nd, NVL (c.cc_id, nkd_), c.sdate, c.wdate, c.vidd
              INTO nd_, p090_, p111p_, p112p_, vidd_
              FROM nd_acc n, cc_deal c
             WHERE n.acc = acc_
               AND n.nd = c.nd
               AND (c.sdate, c.nd) =
                      (SELECT MAX (p.sdate), MAX (p.nd)
                         FROM nd_acc a, cc_deal p
                        WHERE a.acc = acc_ AND a.nd = p.nd AND p.sdate <= dat_);

            -- проверка: включались ли какие-либо счета по этому договору в предыд. файл
            SELECT COUNT (*)
              INTO kolvo_
              FROM otcn_f71_history_sb
             WHERE nd = nd_ AND datf = dat2_ AND ostf <> 0;

            IF kolvo_ > 0
            THEN
               pog_ := TRUE;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               nd_ := NULL;
               p090_ := nkd_;
               p111p_ := p111_;
               p112p_ := p112_;
               vidd_ := 0;
            WHEN TOO_MANY_ROWS
            THEN
               raise_application_error
                         (-20008,
                             'Счет '''
                          || nls_
                          || ''' (acc='
                          || acc_
                          || ',rnk='
                          || rnk_
                          || ') используется в нескольких кредит. договорах!!! '
                         );
            WHEN OTHERS
            THEN
               raise_application_error (-20002,
                                        'acc=' || acc_ || ' Ошибка : '
                                        || SQLERRM
                                       );
         END;
      END IF;

--- виды кредитных линий (простая или мультивалютная)
      IF vidd_ IN (2, 3, 12, 13)
      THEN
         BEGIN
            SELECT DISTINCT acc
                       INTO acc1_
                       FROM cc_lim
                      WHERE nd = nd_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               acc1_ := NULL;
               sum_lim := 0;
         END;

         IF NVL (acc1_, 0) <> 0
         THEN
            BEGIN
               SELECT ABS (gl.p_icurval (kv, ostx, dat_))
                 INTO sum_lim
                 FROM accounts
                WHERE acc = acc1_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_lim := 0;
            END;
         END IF;
      ELSIF vidd_ IN (9, 19, 29, 39)
      THEN                                       -- если это гарантии клиентам
         BEGIN
            SELECT ABS (gl.p_icurval (p140_, a.LIMIT * 100, dat_))
              INTO sum_lim
              FROM cc_deal a
             WHERE a.nd = nd_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sum_lim := 0;
         END;
      ELSE
         IF mfo_ NOT IN (353575)
         THEN
            BEGIN                                            -- текущий лимит
               SELECT gl.p_icurval (a.kv, l.lim2, dat_), a.wdate
                 INTO sum_lim, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT   l2.nd, MAX (l2.fdat)
                             FROM cc_lim l2
                            WHERE l2.nd = nd_
                              AND l2.fdat <= dat_
                              AND l2.lim2 <> 0
                         GROUP BY l2.nd)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_lim := 0;
                  p111p_ := p111_;
            END;
         ELSE
            BEGIN                         -- первоначальная сумма по договору
               SELECT gl.p_icurval (a.kv, l.lim2, dat_), a.wdate
                 INTO sum_lim, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT   l2.nd, MIN (l2.fdat)
                             FROM cc_lim l2
                            WHERE l2.nd = nd_
                              AND l2.fdat <= dat_
                              AND l2.lim2 <> 0
                         GROUP BY l2.nd)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sum_lim := 0;
                  p111p_ := p111_;
            END;

            BEGIN
-- сумма по доп. соглашению (показатель 111 = дате увеличения лимита по доп. соглашению)
               SELECT gl.p_icurval (a.kv, l.lim2, dat_)             --, l.FDAT
                 INTO sum_lim                                       --, p111p_
                 FROM cc_lim l, cc_add a
                WHERE (l.nd, l.fdat) IN (
                         SELECT nd_, MAX (fdat)
                           FROM (SELECT nd, fdat, lim2 lim,
                                        LAG (lim2, 1, 0) OVER (PARTITION BY nd ORDER BY fdat)
                                                                  AS prev_lim
                                   FROM cc_lim
                                  WHERE nd = nd_ AND fdat <= dat_)
                          WHERE prev_lim <> 0 AND lim > prev_lim)
                  AND l.nd = a.nd
                  AND a.kv IS NOT NULL
                  AND a.adds = 0;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         END IF;
      END IF;

      sum_zd_ := sum_lim;

      --- общая сумма по одному договору
      BEGIN
         IF nd_ IS NOT NULL
         THEN
            -- в кредитном модуле
            SELECT ABS (SUM (gl.p_icurval (s.kv, a.ostf - a.dos + a.kos, dat_))
                       )
              INTO sum_71
              FROM nd_acc p, accounts s, kl_f3_29 k, saldoa a
             WHERE p.nd = nd_
               AND p.acc = s.acc
               AND s.nbs = k.r020
               AND k.kf = '71'
               AND NVL (k.ddd, '121') NOT IN ('123', '125')
               AND s.acc = a.acc
               AND (a.acc, a.fdat) = (SELECT   c.acc, MAX (c.fdat)
                                          FROM saldoa c
                                         WHERE a.acc = c.acc
                                               AND c.fdat <= dat_
                                      GROUP BY c.acc);
         ELSE
            -- реальная дата возникновения задолженности
            BEGIN
               SELECT NVL (MAX (fdat), p111_)
                 INTO p111p_
                 FROM saldoa
                WHERE acc = acc_
                  AND fdat <= dat_
                  AND (   ostf = 0
                       OR (    ostf < 0
                           AND kos >= ABS (ostf)
                           AND ostf - dos + kos < 0
                          )
                      );
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  p111p_ := p111_;
            END;

            IF nls_ LIKE '202%' OR nls_ LIKE '222%'
            THEN
               -- по учтенным векселям
               -- общая задолженность по векселям по данному контрагенту
               SELECT ABS (SUM (gl.p_icurval (s.kv, a.ost, dat_)))
                 INTO sum_71
                 FROM accounts s, cust_acc c, kl_f3_29 k, sal a
                WHERE s.nbs = k.r020
                  AND k.kf = '71'
                  AND s.acc = a.acc
                  AND a.fdat = dat_
                  AND (s.nbs LIKE '202%' OR s.nbs LIKE '222%')
                  AND NVL (k.ddd, '121') NOT IN ('123', '125')
                  AND s.acc = c.acc
                  AND c.rnk = rnk_;

               -- сумма по даному договору
--               BEGIN
                  SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, dat_)))
                    INTO sum_zd_
                    FROM kl_f3_29 k, sal s, cust_acc c, specparam r
                   WHERE k.kf = '71'
                     AND k.r020 = s.nbs
                     AND s.fdat = dat_
                     AND s.acc = c.acc
                     AND c.rnk = rnk_
                     AND s.acc = r.acc
                     AND (s.nbs LIKE '202%' OR s.nbs LIKE '222%')
                     AND NVL (k.ddd, '121') NOT IN ('123', '125')
                     AND r.nkd = nkd_;
--               EXCEPTION
--                  WHEN NO_DATA_FOUND
--                  THEN
--                     sum_zd_ := ABS (p120_);
               if NVL(sum_zd_,0) = 0 then
                  sum_zd_ := ABS (p120_);
               end if;
--               END;

            ELSE
               -- не рахунки Ц?нних папер?в
               IF SUBSTR (nls_, 1, 3) NOT IN
                                         ('300', '301', '310', '311', '321')
               THEN
                  -- не в кредитном модуле, но заполнены параметры
                  SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, dat_)))
                    INTO sum_zd_                                      --sum_71
                    FROM kl_f3_29 k, sal s, cust_acc c, specparam r
                   WHERE k.kf = '71'
                     AND NVL (k.ddd, '121') NOT IN ('123', '125')
                     AND k.r020 = s.nbs
                     AND s.fdat = dat_
                     AND s.acc = c.acc
                     AND c.rnk = rnk_
                     AND s.acc = r.acc
                     AND r.nkd = nkd_;

                  if NVL(sum_zd_,0) = 0 then
                     sum_zd_ := ABS (p120_);
                  end if;
               END IF;

               -- рахунки Ц?нних папер?в (боргов_ ц_нн_ папери)
               IF SUBSTR (nls_, 1, 3) IN ('300', '301', '310', '311', '321')
               THEN
                  -- сумма по даному договору
--                  BEGIN
                     SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, dat_)))
                       INTO sum_zd_
                       FROM kl_f3_29 k, sal s, cust_acc c, specparam r
                      WHERE k.kf = '71'
                        AND NVL (k.ddd, '121') NOT IN ('125')
                        AND k.r020 = s.nbs
                        AND s.fdat = dat_
                        AND s.acc = c.acc
                        AND c.rnk = rnk_
                        AND s.acc = r.acc
                        AND
--                        TO_NUMBER(SUBSTR(s.nbs, 4, 1)) < 5 AND -- без дисконт_в та переоц_нок
                            r.nkd = nkd_;
--                  EXCEPTION
--                     WHEN NO_DATA_FOUND
--                     THEN
                     if NVL(sum_zd_,0) = 0 then
                        sum_zd_ := ABS (p120_);
                     end if;
--                  END;
               END IF;
            END IF;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            sum_71 := ABS (p120_);
      END;

      sum_71 := NVL (sum_71, 0);
   END;

------------------------------------------------------------------
   PROCEDURE p_obrab_pkd (ptype_ IN NUMBER)
   IS
   BEGIN
      IF     pog_
         AND (   (nd_ IS NOT NULL AND nd_ <> p_nd_)
              OR (nd_ IS NULL AND p090_ <> p_p090_)
             )
      THEN
         p080_ := p_p080_;
         p081_ := p_p081_;
         p090_ := p_p090_;
         sum_zd_ := p_sum_zd_;
         p111p_ := p_p111_;
         p112p_ := p_p112_;
         p120_ := 0;
         p130_ := p_p130_;
         nd_ := p_nd_;

         SELECT MIN (c.fdat)
           INTO data_
           FROM saldoa c
          WHERE c.acc = acc_
            AND c.fdat > dat2_
            AND (   c.ostf - c.dos + c.kos = 0
                 OR (c.ostf < 0 AND c.kos >= ABS (c.ostf))
                );

         p_ins_kredit (ptype_);
      END IF;
   END;

   PROCEDURE p_ins_log (p_kod_ VARCHAR2, p_val_ NUMBER)
   IS
   BEGIN
      IF kodf_ IS NOT NULL AND userid_ IS NOT NULL
      THEN
         INSERT INTO otcn_log
                     (kodf, userid,
                      txt
                     )
              VALUES (kodf_, userid_,
                      p_kod_ || TO_CHAR (p_val_ / 100, fmtkap_)
                     );
      END IF;
   END;
-------------------------------------------------------------------
BEGIN
   SELECT ID
     INTO userid_
     FROM staff
    WHERE UPPER (logname) = UPPER (USER);

-------------------------------------------------------------------
   EXECUTE IMMEDIATE 'truncate table otcn_f71_rnk_sb';

   EXECUTE IMMEDIATE 'truncate table rnbu_trace';

-------------------------------------------------------------------
   DELETE FROM otcn_f71_history
         WHERE datf = dat_;

   EXECUTE IMMEDIATE 'truncate table OTCN_F71_TEMP_SB';

   EXECUTE IMMEDIATE 'truncate table OTCN_F71_CUST_SB';

-------------------------------------------------------------------
   EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';

   mfo_ := f_ourmfo ();

-- МФО "родителя"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   BEGIN
      SELECT SUBSTR (sab, 2, 3)
        INTO sab_
        FROM banks
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error
                         (-20009,
                             'В дов_днику банк_в немає запису з кодом MFO='''
                          || mfo_
                          || ''''
                         );
   END;

-- код области, где расположен банк
   BEGIN
      b040_ := LPAD (f_get_params ('OUR_TOBO', NULL), 12, 0);

      IF SUBSTR (b040_, 1, 1) IN ('0', '1')
      THEN
         our_reg_ := TO_NUMBER (SUBSTR (b040_, 2, 2));
      ELSE
         our_reg_ := TO_NUMBER (SUBSTR (b040_, 7, 2));
      END IF;

      our_reg_ := NVL (our_reg_, '00');
   END;

-- код подразделения определяем из PARAMS PAR='OUR_TOBO' (определено выше b040_)
-- определяем код области или МФО по коду файла #D8 и код формирования
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);
   nnnn_ := 0;
-- определение суммы регулятивного капитала
   sum_k_ := rkapital (dat_, kodf_, userid_);

   IF dat_ >= TO_DATE ('01072006', 'ddmmyyyy')
   THEN                                                        -- з 01.07.2006
      -- статутний капiтал
      BEGIN
         SELECT SUM (DECODE (SUBSTR (kodp, 1, 1), '1', -1, 1)
                     * TO_NUMBER (znap))
           INTO sum_sk_
           FROM v_banks_report
          WHERE datf = dat_
            AND kodf = '01'
            AND SUBSTR (kodp, 2, 5) IN ('05000', '05001', '05002');
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            sum_sk_ := 0;
      END;

      IF NVL (sum_sk_, 0) = 0
      THEN
         sum_sk_ := NVL (TRIM (f_get_params ('NORM_SK', 0)), 0);
      END IF;

      IF NVL (sum_sk_, 0) <> 0 AND sum_sk_ * 0.05 < smax_
      THEN
         smax_ := sum_sk_ * 0.05;
      END IF;
   ELSE
      sum_sk_ := sum_k_;
   END IF;

   -- общий процент участия изменяется с 20% на 10%
   if Dat_ >= to_date('29082008','ddmmyyyy') then
      sum_proc := 10;
   end if;

   p_ins_log
      (' -------------------------------- Формування #D8 файлу  --------------------------------- ',
       NULL
      );
   p_ins_log ('Регулятивний капiтал (РК1): ', sum_k_);
   p_ins_log ('Статутний капiтал: ', sum_sk_);

   BEGIN
      SELECT period
        INTO period_
        FROM kl_f00
       WHERE kodf = kodf_ AND ROWNUM = 1;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         period_ := 'T';
   END;

   IF period_ = 'T'
   THEN                                                       -- декадный файл
      -- определение даты начала декады
      dc_ := TO_NUMBER (LTRIM (TO_CHAR (dat_, 'DD'), '0'));

      FOR i IN 1 .. 3
      LOOP
         IF dc_ BETWEEN 10 * (i - 1) + 1
                    AND 10 * (i - 1) + 10 + iif (i, 3, 0, 1, 0)
         THEN
            dat1_ :=
               TO_DATE (   LPAD (10 * (i - 1) + 1, 2, '0')
                        || TO_CHAR (dat_, 'mmyyyy'),
                        'ddmmyyyy'
                       );
            EXIT;
         END IF;
      END LOOP;

      -- к_нець попередньої декади
      SELECT MAX (fdat)
        INTO dat2_
        FROM fdat
       WHERE fdat < dat1_;
   ELSIF period_ = 'M'
   THEN                                                       -- месячный файл
      dat1_ := TO_DATE ('01' || TO_CHAR (dat_, 'mmyyyy'), 'ddmmyyyy');

      -- к_нець попередньої м_сяця
      SELECT MAX (fdat)
        INTO dat2_
        FROM fdat
       WHERE fdat < dat1_;
   ELSE
      -- попередный день
      SELECT MAX (fdat)
        INTO dat2_
        FROM fdat
       WHERE fdat < dat_;
   END IF;

-- это выходной?
   SELECT COUNT (*)
     INTO kolvo_
     FROM holiday
    WHERE holiday = dat2_ AND kv = 980;

-- если да, то ищем не выходной
   IF kolvo_ <> 0
   THEN
      dbuf_ := calc_pdat (dat2_);
      dat2_ := dbuf_ - 1;
   END IF;

   SELECT MAX (fdat)
     INTO pdat_
     FROM fdat
    WHERE fdat <= dat_;

   ndk_ := 0;

----------

   -- код пользователя, данные по расчету резерву которого использовались
-- при формировании фонда
-- если фонд не формировался = код текущего пользователя
   BEGIN
      SELECT userid
        INTO rezid_
        FROM rez_protocol
       WHERE dat = dat_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezid_ := NULL;
   END;

   IF 300120 IN (mfo_, mfou_)
   THEN                                       -- пока только для Петрокоммерца
-- включаем в файл связанныхх по холдингу контрагентов (как в 42 файле)
-- если они в сумме дают 2 млн. грн. и больше
      INSERT INTO otcn_f71_rnk_sb
                  (rnk, ostf)
         SELECT rnk, ost
           FROM (SELECT   /*+index(v.s) index(v.s1)*/
                          DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
                          DECODE (c.prinsider,
                                  NULL, 2,
                                  0, 2,
                                  99, 2,
                                  1
                                 ) prins,
                          SUM (gl.p_icurval (v.kv,
                                             s.ostf - s.dos + s.kos,
                                             dat_
                                            )
                              ) ost
                     FROM saldoa s,
                          v_acc_d8 v,
                          kl_f3_29 k,
                          cust_acc ca,
                          customer c
                    WHERE s.fdat <= dat_
                      AND s.acc = v.acc
                      AND (v.acc, s.fdat) =
                                     (SELECT   c.acc, MAX (c.fdat)
                                          FROM saldoa c
                                         WHERE v.acc = c.acc
                                               AND c.fdat <= dat_
                                      GROUP BY c.acc)
                      AND k.kf = '71'
                      AND v.nls LIKE k.r020 || '%'
                      AND s.acc = ca.acc
                      AND c.rnk = ca.rnk
                      AND c.codcagent < 7
                      AND (   (    SUBSTR (v.nls, 1, 4) NOT IN
                                      ('1600',
                                       '2600',
                                       '2605',
                                       '2620',
                                       '2625',
                                       '2650',
                                       '2655'
                                      )
                               AND s.ostf - s.dos + s.kos <> 0
                              )
                           OR (    SUBSTR (v.nls, 1, 4) IN
                                      ('1600',
                                       '2600',
                                       '2605',
                                       '2620',
                                       '2625',
                                       '2650',
                                       '2655'
                                      )
                               AND s.ostf - s.dos + s.kos < 0
                              )
                           OR (    s.ostf - s.dos + s.kos = 0
                               AND s.fdat BETWEEN dat1_ AND dat_
                              )
                          )
                      -- and c.rnk in (726)
                      AND (prnk_ IS NULL OR c.rnk = prnk_)
                 GROUP BY DECODE (c.rnkp, NULL, c.rnk, c.rnkp),
                          DECODE (c.prinsider, NULL, 2, 0, 2, 99, 2, 1))
          WHERE prins = 1 OR ABS (ost) >= smax_;
--                OR rnk IN (SELECT rnk
--                             FROM otcn_f71_history_sb
--                            WHERE datf = dat2_);

      txt_sql :=
            'SELECT   a.acc, a.nls, c.nmk, c.rnk, trim(f.k081), '
         || 'LPAD (TRIM (c.okpo), 10, ''0'') okpo, 2 - MOD (c.codcagent, 2) codcagent, '
         || 'c.country, decode(c.c_reg,28,(select max(c_reg) from spr_reg where c_reg<28 and zip_code=(select max(zip_code) from spr_reg where c_reg=c.c_reg and c_dst=c.c_dst)),c.c_reg ) c_reg, c.ved, DECODE (c.prinsider, NULL, 2, 0, 2, 99, 2, 1) prins, '
         || 'a.nbs, a.daos, a.mdate, '
         || 'gl.p_icurval (a.kv, a.ostf - a.dos + a.kos, :dat_), '
         || 'acrn.fproc (a.acc, :dat_), a.kv, a.fdat, a.tip, a.txt, '
         || 'DECODE (c.custtype, 3, 2, 1) custtype, '
         || 'a.isp, a.ddd, a.s081, c.crisk, ABS (r.ostf) '
         || 'FROM (SELECT /*+index(s.s) index(s.s1)*/ '
         || 's.acc, s.nbs, s.nls, s.kv, s.daos, s.mdate, aa.fdat, aa.ostf, '
         || 'aa.dos, aa.kos, s.tip, s.isp, k.txt, NVL (TRIM (k.ddd), ''121'') ddd, '
         || 'NVL (TRIM (k.s240), ''1'') s081 '
         || 'FROM saldoa aa, v_acc_d8 s, kl_f3_29 k '
         || 'WHERE aa.acc = s.acc '
         || 'AND (s.acc, aa.fdat) = (SELECT   c.acc, MAX (c.fdat) '
         || 'FROM saldoa c '
         || 'WHERE s.acc = c.acc AND c.fdat <= :dat_ '
         || 'GROUP BY c.acc) '
         || 'and k.kf = ''71'' '
         || 'AND k.r020 = s.nbs '
         || 'AND (   (    s.nbs NOT IN '
         || '(''1600'', '
         || ' ''2600'', '
         || ' ''2605'', '
         || ' ''2620'', '
         || ' ''2625'', '
         || ' ''2650'', '
         || ' ''2655'' ) '
         || 'AND aa.ostf - aa.dos + aa.kos <> 0) '
         || 'OR (    s.nbs IN '
         || '(''1600'', '
         || ' ''2600'', '
         || ' ''2605'', '
         || ' ''2620'', '
         || ' ''2625'', '
         || ' ''2650'', '
         || ' ''2655'') '
         || 'AND aa.ostf - aa.dos + aa.kos < 0) '
         || 'OR (    aa.ostf - aa.dos + aa.kos = 0 '
         || 'AND aa.fdat BETWEEN :dat1_ AND :dat_))) a, '
         || 'cust_acc ca, '
         || 'customer c, '
         || 'otcn_f71_rnk_sb r, '
         || 'kl_k080 f '
         || ' WHERE a.acc = ca.acc '
         || '   AND ca.rnk = c.rnk '
         || '   AND DECODE (c.rnkp, NULL, c.rnk, c.rnkp) = r.rnk '
         || '   AND c.fs = f.k080(+) '
         || ' ORDER BY c.okpo, c.rnk, a.nbs ';
   ELSE
      INSERT INTO otcn_f71_rnk_sb
                  (rnk, nmk, okpo, codcagent, country, c_reg, ved, prins,
                   custtype, crisk, fs, ise, ostf)
         SELECT rnk, nmk, okpo, codcagent, country, c_reg, ved, prins,
                custtype, crisk, fs, ise, ost
           FROM (SELECT   /*+index(v.s) index(v.s1)*/
                          c.rnk, c.nmk, LPAD (TRIM (c.okpo), 10, '0') okpo,
                          2 - MOD (c.codcagent, 2) codcagent, c.country,
                          decode(c.c_reg,28,(select max(c_reg) from spr_reg where c_reg<28 and zip_code=(select max(zip_code) from spr_reg where c_reg=c.c_reg and c_dst=c.c_dst)),c.c_reg ) c_reg, c.ved,
                          DECODE (c.prinsider,
                                  NULL, 2,
                                  0, 2,
                                  99, 2,
                                  1
                                 ) prins,
                          DECODE (c.custtype, 3, 2, 1) custtype, c.crisk,
                          c.fs, c.ise,
                          SUM (gl.p_icurval (v.kv,
                                             s.ostf - s.dos + s.kos,
                                             dat_
                                            )
                              ) ost
                     FROM saldoa s,
                          v_acc_d8 v,
                          kl_f3_29 k,
                          cust_acc ca,
                          customer c
                    WHERE s.fdat <= dat_
                      AND s.acc = v.acc
                      AND (v.acc, s.fdat) =
                                     (SELECT   c.acc, MAX (c.fdat)
                                          FROM saldoa c
                                         WHERE v.acc = c.acc
                                               AND c.fdat <= dat_
                                      GROUP BY c.acc)
                      AND k.kf = '71'
                      AND v.nls LIKE k.r020 || '%'
                      AND s.acc = ca.acc
                      AND c.rnk = ca.rnk
                      AND c.codcagent < 7
                      AND (   (    SUBSTR (v.nls, 1, 4) NOT IN
                                      ('1600',
                                       '2600',
                                       '2605',
                                       '2620',
                                       '2625',
                                       '2650',
                                       '2655'
                                      )
                               AND s.ostf - s.dos + s.kos <> 0
                              )
                           OR (    SUBSTR (v.nls, 1, 4) IN
                                      ('1600',
                                       '2600',
                                       '2605',
                                       '2620',
                                       '2625',
                                       '2650',
                                       '2655'
                                      )
                               AND s.ostf - s.dos + s.kos < 0
                              )
                           OR (    s.ostf - s.dos + s.kos = 0
                               AND s.fdat BETWEEN dat1_ AND dat_
                              )
                          )
                      --and c.rnk in (726)
                      AND (prnk_ IS NULL OR c.rnk = prnk_)
                 GROUP BY c.rnk,
                          c.nmk,
                          LPAD (TRIM (c.okpo), 10, '0'),
                          2 - MOD (c.codcagent, 2),
                          c.country,
                          c.c_reg,
                          c.ved,
                          DECODE (c.prinsider, NULL, 2, 0, 2, 99, 2, 1),
                          DECODE (c.custtype, 3, 2, 1),
                          c.crisk,
                          c.fs,
                          c.ise)
          WHERE prins = 1 OR ABS (ost) >= smax_;
--                OR rnk IN (SELECT rnk
--                             FROM otcn_f71_history_sb
--                            WHERE datf = dat2_);

      txt_sql :=
            'SELECT   a.acc, a.nls, r.nmk, r.rnk, trim(f.k081), r.okpo, r.codcagent, '
         || 'r.country, r.c_reg, r.ved, r.prins, a.nbs, a.daos, a.mdate, '
         || 'gl.p_icurval (a.kv, a.ostf - a.dos + a.kos, :dat_), '
         || 'acrn.fproc (a.acc, :dat_), a.kv, a.fdat, a.tip, a.txt, r.custtype, '
         || 'a.isp, a.ddd, a.s081, r.crisk, ABS (r.ostf) '
         || 'FROM (SELECT /*+index(s.s) index(s.s1)*/ '
         || 's.acc, s.nbs, s.nls, s.kv, s.daos, s.mdate, aa.fdat, aa.ostf, '
         || 'aa.dos, aa.kos, s.tip, s.isp, k.txt, NVL (TRIM (k.ddd), ''121'') ddd, '
         || 'NVL (TRIM (k.s240), ''1'') s081 '
         || 'FROM saldoa aa, v_acc_d8 s, kl_f3_29 k '
         || 'WHERE aa.acc = s.acc '
         || 'AND (s.acc, aa.fdat) = (SELECT   c.acc, MAX (c.fdat) '
         || 'FROM saldoa c '
         || 'WHERE s.acc = c.acc AND c.fdat <= :dat_ '
         || 'GROUP BY c.acc) '
         || 'and k.kf = ''71'' '
         || 'AND k.r020 = s.nbs '
         || 'AND (   (    s.nbs NOT IN '
         || '(''1600'', '
         || ' ''2600'', '
         || ' ''2605'', '
         || ' ''2620'', '
         || ' ''2625'', '
         || ' ''2650'', '
         || ' ''2655'' ) '
         || 'AND aa.ostf - aa.dos + aa.kos <> 0) '
         || 'OR (    s.nbs IN '
         || '(''1600'', '
         || ' ''2600'', '
         || ' ''2605'', '
         || ' ''2620'', '
         || ' ''2625'', '
         || ' ''2650'', '
         || ' ''2655'') '
         || 'AND aa.ostf - aa.dos + aa.kos < 0) '
         || 'OR (    aa.ostf - aa.dos + aa.kos = 0 '
         || 'AND aa.fdat BETWEEN :dat1_ AND :dat_))) a, '
         || 'cust_acc ca, '
         || 'otcn_f71_rnk_sb r, '
         || 'kl_k080 f '
         || ' WHERE a.acc = ca.acc '
         || '   AND ca.rnk = r.rnk '
         || '   AND r.fs = f.k080(+) '
         || '  AND (:prnk_ IS NULL OR r.rnk = :prnk_) '
         || ' ORDER BY r.okpo, r.rnk, a.nbs ';
   END IF;

--------------------------------------------------------------------------
   IF 300120 IN (mfo_, mfou_)
   THEN                                       -- пока только для Петрокоммерца
      OPEN saldo FOR txt_sql USING dat_, dat_, dat_, dat1_, dat_;
   ELSE
      OPEN saldo FOR txt_sql USING dat_, dat_, dat_, dat1_, dat_, prnk_,
      prnk_;
   END IF;

   LOOP
      FETCH saldo
       INTO acc_, nls_, p010_, rnk_, p021_, p030_, rez_, p050_, reg_, ved_,
            p060_, p070_, p111_, p112_, p120_, p130_, p140_, data_, tip_,
            doda_, custtype_, isp_, ddd_, s081_, s085_, sum_contr_;

      EXIT WHEN saldo%NOTFOUND;
      nd_ := NULL;
      acco_ := NULL;
      accn_ := NULL;
      sum_zd_ := 0;

      BEGIN                                                       -- по счету
         SELECT NVL (nd, 0), p090, p110, p111, p112, p080,
                p081, p130
           INTO p_nd_, p_p090_, p_sum_zd_, p_p111_, p_p112_, p_p080_,
                p_p081_, p_p130_
           FROM otcn_f71_history_sb
          WHERE acc = acc_ AND datf = dat2_ AND ostf <> 0 AND ROWNUM=1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BEGIN                                       -- по номеру договора
               SELECT MAX (NVL (nd, -1))
                 INTO p_nd_
                 FROM nd_acc
                WHERE acc = acc_;

               SELECT NVL (nd, 0), p090, p110, p111, p112, p080,
                      p081, p130
                 INTO p_nd_, p_p090_, p_sum_zd_, p_p111_, p_p112_, p_p080_,
                      p_p081_, p_p130_
                 FROM otcn_f71_history_sb
                WHERE NVL (nd, 0) = p_nd_
                  AND datf = dat2_
                  AND ostf <> 0
                  AND ROWNUM = 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  p_nd_ := NULL;
            END;
      END;

      -- кредит погашен в течении отчетного месяца
      IF p_nd_ IS NOT NULL
      THEN
         pog_ := TRUE;
      ELSE
         pog_ := FALSE;
      END IF;

--- код контрагента
      kod_okpo := LPAD (TRIM (p030_), 10, '0');

      --kod_okpo:=sab_||LPAD(Trim(TO_CHAR(rnk_)),7,'0');
      IF p070_ IN ('2607', '2627')
      THEN
         BEGIN
            SELECT i.acc
              INTO acco_
              FROM int_accn i, accounts a
             WHERE i.acra = acc_
               AND ID = 0
               AND i.acc = a.acc
               AND a.nbs LIKE SUBSTR (p070_, 1, 3) || '%'
               AND a.nbs <> p070_;

            IF acco_ IS NOT NULL
            THEN
               accn_ := acc_;
               acc_ := acco_;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;

--- определяем кредитная линия или нет и категорию риска
      BEGIN
         SELECT NVL (s181, '0'), NVL (s080, '1'), NVL (s031, '90'),
                NVL (nkd, 'N дог.'), NVL (r013, '0')
           INTO s181_, s080_, s031_,
                nkd_, r013_
           FROM specparam
          WHERE acc = acc_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            s181_ := '0';
            s080_ := '1';
            s031_ := '90';
            nkd_ := 'N дог.';
            r013_ := '0';
      END;

      IF 380623 IN (mfo_, mfou_) AND nls_ LIKE '3%'
      THEN
         BEGIN
            sql_ :=
               'select nd
                    from cp_v
                    where acc in (select acc
                                from cp_deal
                                where :acc_ in (acc, accd, accp, accr, accs, accr2)) and
                                      rownum=1';

            EXECUTE IMMEDIATE sql_
                         INTO nkd_
                        USING acc_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;

      IF 300465 IN (mfo_, mfou_) AND substr(nls_,1,3) in ('311', '321') THEN
         nkd_ := to_char(rnk_);
      END IF;

      kol_dz := 0;
      p080_ := s031_;

      -- виды залогов
      OPEN kredit;

      LOOP
         FETCH kredit
          INTO p080f_, nd_;

         EXIT WHEN kredit%NOTFOUND;
         p080_ := NVL (p080f_, s031_);
         kol_dz := kol_dz + 1;
      END LOOP;

      CLOSE kredit;

--- если кол-во договоров залога больше 1, то вид залога p080_='40'
      IF kol_dz > 1
      THEN
         p080_ := '40';
      END IF;

      sum_71 := 0;

      -- исключаем счета начисленных процентов для корсчетов
      IF p070_ = '1508'
      THEN
         SELECT COUNT (*)
           INTO f1502_
           FROM accounts
          WHERE nls LIKE '1502_' || SUBSTR (nls_, 6);

         IF f1502_ = 0
         THEN
            p120_ := 0;
            pog_ := FALSE;
         END IF;
      END IF;

--- обработка счетов 1 класса (межбанковские кредиты)
      IF     SUBSTR (nls_, 1, 1) = '1'
         AND SUBSTR (nls_, 1, 4) NOT IN ('1600', '1607')
         AND p060_ = 2
         AND (ABS (p120_) <> 0 OR pog_)
      THEN
         BEGIN
            IF pog_ AND p120_ = 0
            THEN
               SELECT NVL (d.cc_id, nkd_), c.wdate, d.wdate, d.nd,
                      gl.p_icurval (a.kv, d.LIMIT, dat_) * 100
                 INTO p090_, p111p_, p112p_, nd_,
                      sum_zd_
                 FROM nd_acc n, cc_deal d, cc_add c, accounts a
                WHERE n.nd = d.nd
                  AND d.nd = c.nd
                  AND c.adds = 0
                  AND n.acc = a.acc
                  AND n.acc = acc_
                  AND d.nd = p_nd_;

               SELECT   MIN (c.fdat)
                   INTO data_
                   FROM saldoa c
                  WHERE c.acc = acc_
                    AND c.fdat > dat2_
                    AND c.ostf - c.dos + c.kos = 0
               GROUP BY c.acc;

               p130_ := acrn.fproc (acc_, data_);
            ELSE
               SELECT NVL (d.cc_id, nkd_), c.wdate, d.wdate, d.nd,
                      gl.p_icurval (a.kv, d.LIMIT, dat_) * 100
                 INTO p090_, p111p_, p112p_, nd_,
                      sum_zd_
                 FROM nd_acc n, cc_deal d, cc_add c, accounts a
                WHERE n.nd = d.nd
                  AND d.nd = c.nd
                  AND c.adds = 0
                  AND n.acc = a.acc
                  AND n.acc = acc_
                  AND (c.wdate, c.nd) =
                         (SELECT MAX (c1.wdate), MAX (c1.nd)
                            FROM nd_acc n1, cc_add c1
                           WHERE n1.nd = c1.nd
                             AND n1.acc = acc_
                             AND c1.wdate <= dat_);
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p090_ := nkd_;
               p111p_ := p111_;
               p112p_ := p112_;
               nd_ := NULL;
               sum_zd_ := 0;
            WHEN OTHERS
            THEN
               raise_application_error (-20001,
                                        'acc=' || acc_ || ' Ошибка : '
                                        || SQLERRM
                                       );
         END;

         -- сумма задолженности за договором
         IF nd_ IS NULL
         THEN
--            BEGIN
               -- не в кредитном модуле, но заполнены параметры
               SELECT ABS (SUM (gl.p_icurval (s.kv, s.ost, dat_)))
                 INTO sum_71
                 FROM kl_f3_29 k, sal s, cust_acc c, specparam r
                WHERE k.kf = '71'
                  AND NVL (k.ddd, '121') NOT IN ('123', '125')
                  AND k.r020 = s.nbs
                  AND s.fdat = dat_
                  AND s.acc = c.acc
                  AND c.rnk = rnk_
                  AND s.acc = r.acc
                  AND r.nkd = nkd_;
--            EXCEPTION
--               WHEN NO_DATA_FOUND
--               THEN
               if NVL(sum_71,0) = 0 then
                  sum_71 := ABS (p120_);
               end if;
--            END;

            --- если общая сумма по договору меньше суммы по счету
            IF sum_71 < ABS (p120_)
            THEN
               sum_71 := ABS (p120_);
            END IF;
         ELSE
            sum_71 := sum_zd_;
         END IF;

         -- если договор открылся и закрылся между отчетными датами, то его не учитываем
         IF p120_ = 0 AND (p111p_ >= dat1_ OR p_nd_ IS NULL)
         THEN
            pog_ := FALSE;
            sum_71 := 0;
         END IF;

--      IF (sum_71 >= smax_  OR pog_)
--      THEN
         IF NVL (sum_zd_, 0) = 0
         THEN
            sum_zd_ := sum_71;
         END IF;

         -- запись параметров кредитного договора
         p_ins_kredit (1);
         -- если в течении одного отчетного периода по одному счету был погашен кредит и выдан новый
         p_obrab_pkd (1);
      --      END IF;
      END IF;

--- обработка счетов 2 и 9 классов (кредиты заемщикам)
--- вычисляем общую сумму по 1 договору
      IF     (   SUBSTR (nls_, 1, 1) IN ('2', '3', '9')
              OR SUBSTR (nls_, 1, 4) IN ('1600', '1607')
             )
         AND p060_ = 2
         AND (   (p070_ IN ('3103', '3105') AND r013_ <> '2')
              OR p070_ NOT IN ('3103', '3105')
             )
         AND (ABS (p120_) <> 0 OR pog_)
      THEN
         kol_dz := 0;

         -- проверяем не являются ли эти счета, счетами овердрафта
         IF SUBSTR (nls_, 1, 4) IN ('2067', '2069', '2096')
         THEN
            SELECT COUNT (*)
              INTO kol_dz
              FROM acc_over o
             WHERE acc_ IN (o.acc_2067, o.acc_2069, o.acc_2096);

            IF kol_dz > 0
            THEN
               flag_over_ := TRUE;
               kol_dz := 0;
            ELSE
               flag_over_ := FALSE;
            END IF;
         ELSE
            flag_over_ := FALSE;
         END IF;

--- для счетов овердрафта определяем наличие в таблице ACC_OVER
         IF    p070_ IN
                  ('3578',
                   '9129',
                   '9100',
                   '1600',
                   '1607',
                   '2000',
                   '2600',
                   '2605',
                   '2620',
                   '2625',
                   '2607',
                   '2627',
                   '2650',
                   '2655',
                   '2657'
                  )
            OR p070_ IN ('2067', '2069', '2096') AND flag_over_
         THEN
            p_over_1 (acc_);
         END IF;

         IF (   p070_ NOT IN
                   ('2067',
                    '2069',
                    '2096',
                    '3578',
                    '9129',
                    '2000',
                    '2600',
                    '2605',
                    '2620',
                    '2625',
                    '2607',
                    '2627',
                    '2650',
                    '2655',
                    '2657'
                   )
             OR p070_ IN ('2067', '2069', '2096') AND NOT flag_over_
             OR (    p070_ IN
                        ('3578',
                         '9129',
                         '9100',
                         '1600',
                         '1607',
                         '2000',
                         '2600',
                         '2605',
                         '2620',
                         '2625',
                         '2607',
                         '2627',
                         '2650',
                         '2655',
                         '2657'
                        )
                 AND kol_dz = 0
                )
            )
         THEN
            -- определение параметров КД
            p_obrab_kd;
         END IF;

--- если общая сумма по договору меньше суммы по счету
-- убрал это присвоение т.к. дисконт уменшает сумму по договору 29.02.2008
--      IF sum_71 < ABS(p120_) THEN
--         sum_71:=ABS(p120_);
--      END IF;

         --      IF (sum_71 >= smax_  OR pog_) --AND
         IF p070_ <> '9129' OR (p070_ = '9129' AND r013_ <> '9')
         THEN
            IF NVL (sum_zd_, 0) = 0
            THEN
               sum_zd_ := sum_71;
            END IF;

            -- договора овердрафта
            IF    (    p070_ IN
                          ('3578',
                           '9129',
                           '9100',
                           '1600',
                           '1607',
                           '2000',
                           '2600',
                           '2605',
                           '2620',
                           '2625',
                           '2607',
                           '2627',
                           '2650',
                           '2655',
                           '2657'
                          )
                   AND kol_dz <> 0
                  )
               OR p070_ IN ('2067', '2069', '2096') AND flag_over_
            THEN
               p112p_ := p112_;
               p_over_2 (acc_);
               sum_zd_ := sum_71;
            END IF;

            -- запись параметров кредитного договора
            p_ins_kredit (2);
            -- проверка не было ли по этому счету другого договора на пред. отчетную дату
            p_obrab_pkd (2);
         END IF;
      END IF;

--- обработка счетов инсайдеров банка - выбираем все кредиты
      IF p060_ = 1 AND (ABS (p120_) > 0 OR pog_)
      THEN
         -- проверяем не являются ли эти счета, счетами овердрафта
         IF SUBSTR (nls_, 1, 4) IN ('2067', '2069', '2096')
         THEN
            SELECT COUNT (*)
              INTO kol_dz
              FROM acc_over o
             WHERE acc_ IN (o.acc_2067, o.acc_2069, o.acc_2096);

            IF kol_dz > 0
            THEN
               flag_over_ := TRUE;
               kol_dz := 0;
            ELSE
               flag_over_ := FALSE;
            END IF;
         ELSE
            flag_over_ := FALSE;
         END IF;

--- для банка УПБ не выбираем счета пластиковых карточек
         IF     (   (p070_ IN ('3103', '3105') AND r013_ <> '2')
                 OR p070_ NOT IN ('3103', '3105')
                )
            AND (   SUBSTR (p070_, 1, 1) <> '8'
                 OR (SUBSTR (p070_, 1, 1) = '8' AND mfo_ = 353575)
                 OR p070_ IN ('2067', '2069', '2096') AND flag_over_
                )
            AND (ABS (p120_) <> 0 OR pog_)
         THEN
            IF (mfo_ = 300205 AND rnk_ <> '2023') OR mfo_ <> 300205
            THEN
               --- для счетов овердрафта определяем наличие в таблице ACC_OVER
               IF    p070_ IN
                        ('3578',
                         '9129',
                         '9100',
                         '1600',
                         '1607',
                         '2000',
                         '2600',
                         '2605',
                         '2620',
                         '2625',
                         '2607',
                         '2627',
                         '2650',
                         '2655',
                         '2657'
                        )
                  OR p070_ IN ('2067', '2069', '2096') AND flag_over_
               THEN
                  p_over_1 (acc_);
               END IF;

               IF (   p070_ NOT IN
                         ('2067',
                          '2069',
                          '2096',
                          '3578',
                          '9129',
                          '9100',
                          '1600',
                          '1607',
                          '2000',
                          '2600',
                          '2605',
                          '2620',
                          '2625',
                          '2607',
                          '2627',
                          '2650',
                          '2655',
                          '2657'
                         )
                   OR p070_ IN ('2067', '2069', '2096') AND NOT flag_over_
                   OR (    p070_ IN
                              ('3578',
                               '9129',
                               '9100',
                               '1600',
                               '1607',
                               '2000',
                               '2600',
                               '2605',
                               '2620',
                               '2625',
                               '2607',
                               '2627',
                               '2650',
                               '2655',
                               '2657'
                              )
                       AND kol_dz = 0
                      )
                  )
               THEN
                  -- НЕ ОВЕРДРАФТЫ
                   -- определение параметров КД
                  p_obrab_kd;

                  IF NVL (sum_zd_, 0) = 0
                  THEN
                     sum_zd_ := sum_71;
                  END IF;
               ELSE                                               --ОВЕРДАРФТЫ
                  p112p_ := p112_;
                  p_over_2 (acc_);
                  sum_zd_ := sum_71;
               END IF;

               --- Для Демарка - обработка карточных счетов 8025 и 8027
               IF SUBSTR (p070_, 1, 1) = '8'
               THEN
                  IF p120_ <> 0
                  THEN
                     BEGIN
                        IF p070_ = '8025'
                        THEN                               -- счет овердрафта
                           SELECT acc, ndoc, datd, datd2, acco
                             INTO acck_, p090_, p111p_, p112p_, acco_
                             FROM acc_over
                            WHERE acco = acc_;
                        ELSIF p070_ = '8027'
                        THEN                  -- счет просроченного овердрафта
                           SELECT acc, ndoc, datd, datd2, acco
                             INTO acck_, p090_, p111p_, p112p_, acco_
                             FROM acc_over
                            WHERE acc_2067 = acc_;
                        ELSE
                           acck_ := NULL;
                        END IF;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           acck_ := NULL;
                           p090_ := NULL;
                     END;

                     IF acck_ IS NOT NULL
                     THEN
                        BEGIN                             -- лимит овердрафта
                           SELECT NVL (a.lim, 0), a.mdate, NVL (s.s080, '1')
                             INTO sum_lim, p112_, s080_
                             FROM accounts a, specparam s
                            WHERE a.acc = acck_ AND a.acc = s.acc(+);
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              sum_lim := 0;
                              p112_ := NULL;
                        END;

                        IF sum_lim > 0
                        THEN
                           sum_zd_ := sum_lim;
                        END IF;

                        IF p112p_ IS NULL
                        THEN
                           p112p_ := p112_;
                        END IF;
                     END IF;

--                      if acco_ is not null then
--                          p111p_ := f_get_p111_over(acco_, data_);
--                      end if;
                     i_opl_ := i_opl_ + 1;
                     p070_ := SUBSTR (TRIM (doda_), 3, 4);

                     IF p090_ IS NULL
                     THEN
                        p090_ := 'OVER_PLK' || TO_CHAR (i_opl_);
                     END IF;

                     -- запись параметров кредитного договора
                     p_ins_kredit (3);

                     IF sum_lim > 0
                     THEN
                        p070_ := '9129';
                        p120_ := ABS (sum_lim) - ABS (p120_);
                        ddd_ := '119';
                        acc_ := acck_;
                        p_ins_kredit (3);
                     END IF;
                  END IF;
               ELSE
                  IF p070_ <> '9129' OR (p070_ = '9129' AND r013_ <> '9')
                  THEN
                     -- запись параметров кредитного договора
                     p_ins_kredit (3);
                     -- проверка не было ли по этому счету другого договора на пред. отчетную дату
                     p_obrab_pkd (3);
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END LOOP;

   CLOSE saldo;

   IF mfo_ = 353575
   THEN
      OPEN saldo_ins;

      LOOP
         FETCH saldo_ins
          INTO acc_, nls_, p010_, rnk_, p021_, p030_, rez_, p050_, reg_,
               ved_, p060_, p070_, p111_, p112_, p120_, p140_, custtype_,
               isp_, ddd_, s081_, s085_;

         EXIT WHEN saldo_ins%NOTFOUND;
         nd_ := NULL;

         -- спецпараметры счета
         BEGIN
            SELECT NVL (s181, '0'), NVL (s080, '1'), NVL (s031, '90'),
                   NVL (nkd, 'N дог.'), NVL (r013, '0')
              INTO s181_, s080_, s031_,
                   nkd_, r013_
              FROM specparam
             WHERE acc = acc_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               s181_ := '0';
               s080_ := '1';
               s031_ := '90';
               nkd_ := 'N дог.';
               r013_ := '0';
         END;

         --- код контрагента
         kod_okpo := LPAD (TRIM (p030_), 10, '0');
         i_opl_ := i_opl_ + 1;
         sum_zd_ := p120_;

         -- параметры договора на овердрафт
         BEGIN
            SELECT ndoc, datd, datd2, acco
              INTO p090_, p111p_, p112p_, acck_
              FROM acc_over
             WHERE acc = acc_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p090_ := NULL;
               p111p_ := p111_;
               p112p_ := p112_;
               acck_ := NULL;
         END;

         IF p112p_ IS NULL
         THEN
            p112p_ := p112_;
         END IF;

         -- процентная ставка за пользование овердрафтом
         IF acck_ IS NOT NULL
         THEN
            p130_ := acrn.fproc (acck_, dat_);
         ELSE
            p130_ := 0;
         END IF;

         IF p090_ IS NULL
         THEN
            p090_ := 'OVER_PLK' || TO_CHAR (i_opl_);
         END IF;

         -- были ли уже договора по этому контрагенту?
         SELECT COUNT (*)
           INTO kol_dz
           FROM otcn_f71_cust_sb
          WHERE rnk = rnk_;

         IF kol_dz > 0
         THEN
            p_rnk_ := rnk_;
         END IF;

         p_ins_kredit (3);
      END LOOP;

      CLOSE saldo_ins;
   END IF;

   nnnn_ := 1;
   p_rnk_ := NULL;
   p_nd_ := NULL;
   p_p090_ := '------';

-- изменяем поле P040 в таблице OTCN_F71_HISTORY (было OTCN_F71_CUST)
/*
   FOR k IN (SELECT DISTINCT rnk, custtype, p060
                        FROM otcn_f71_cust
                       WHERE TRIM (p040) = '0')
   LOOP
      SELECT COUNT (*)
        INTO kol_
        FROM otcn_f71_temp
       WHERE rnk = k.rnk
         AND (   (TRIM (k.p060) = '1' AND p120 <> 0 AND p120 > 8000000)
              OR (TRIM (k.p060) <> '1' AND p120 + p125 <> 0)
             );

      IF kol_ <> 0
      THEN
         BEGIN
            IF k.custtype = 2
            THEN                                         -- для ф_зичних ос_б
               SELECT COUNT (*)
                 INTO p040_
                 FROM (SELECT rnkb rnk
                         FROM cust_bun
                        WHERE rnka = k.rnk AND id_rel = 5
                       UNION
                       SELECT rnka rnk
                         FROM cust_bun
                        WHERE rnkb = k.rnk AND id_rel = 5) a;
            ELSE
               SELECT COUNT (*)
                 INTO p040_
                 FROM cust_bun
                WHERE rnka = k.rnk
                  AND id_rel IN (1, 4)
                  AND NVL (vaga1, 0) + NVL (vaga2, 0) >= sum_proc;  --20;
            END IF;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               p040_ := 0;
         END;

         -- заменяем поле P040 не в табл. OTCN_F71_CUST и в табл. OTCN_F71_HISTORY
         -- т.к. формирование показателя 040 в файле #D8 выполняется по табл. OTCN_F71_CUST
         -- а расшифровка показателя 040 в файле #D9 выполняется по табл. OTCN_F71_HISTORY

         if p040_ <> 0 then
            update otcn_f71_history
               set p040=p040_
            where rnk=k.rnk
              and p040 = 0
              and datf=Dat_;
            UPDATE otcn_f71_cust
               SET p040 = p040_
             WHERE rnk = k.rnk AND TRIM (p040) = '0';
         end if;

      END IF;
   END LOOP;
*/

   OPEN c_cust;

   LOOP
      FETCH c_cust
       INTO rnk_, kod_okpo, rez_, custtype_, p010_, p021_, k110_, p040_,
            p050_, reg_, p060_, p085_;

      EXIT WHEN c_cust%NOTFOUND;
      p140_ := NULL;
      data_ := NULL;
      isp_ := NULL;
      kodp_ := kod_okpo || '0000' || '0000' || '000';
      -- название контрагента
      p_ins ('010' || kodp_, p010_);
      -- код формы собственности
      p_ins ('020' || kodp_, p021_);         --включили. начиная с 01.09.2007
      -- код сектора економики
--      p_ins ('021' || kodp_, p021_);         --включили. начиная с 01.09.2007
      -- вид экономической деятельности
      BEGIN
         select k111
            into k111_
         from kl_k110
         where k110=k110_ and d_close is null;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         k111_ := '00';
      END;
      p_ins ('025' || kodp_, k111_);
      -- количество участников, участие которых 20 и больше %% статутного фонда
--      p_ins ('040' || kodp_, p040_);
      -- код страны
      p_ins ('050' || kodp_, TO_CHAR (p050_));
      -- код региона
      p_ins ('055' || kodp_, TO_CHAR (NVL (lpad(reg_,2,'0'), lpad(our_reg_,2,'0'))));
      -- признак инсайдера
      p_ins ('060' || kodp_, TO_CHAR (p060_));

      OPEN c_cust_dg;

      LOOP
         FETCH c_cust_dg
          INTO acc_, nd_, p090_, p080_, p081_, sum_zd_, p111_, p112_, p113_,
               s080_, p070_, p140_, ddd_, p120_, p125_, p130_, p150_, nls_,
               data_, isp_;

         EXIT WHEN c_cust_dg%NOTFOUND;

      if mfo_ <> 300465 OR
        ((mfo_ = 300465 and substr(p070_,1,3) in ('311','321') and
          p120_+p125_<>0 ) OR
          (mfo_=300465 and substr(p070_,1,3) not in ('311','321')) )
      then

         IF    (p_nd_ IS NULL AND p_p090_ = '------')
            OR                                                   -- первый раз
               (    p_nd_ IS NULL
                AND nd_ IS NULL
                AND (   (p090_ <> p_p090_)
                     OR (p090_ = p_p090_ AND p_rnk_ <> rnk_)
                    )
               )
            OR (    p_nd_ IS NULL
                AND nd_ IS NULL
                AND p090_ = p_p090_
                AND p090_ = 'N дог.'
               )
            OR (p_nd_ IS NOT NULL AND nd_ IS NOT NULL AND p_nd_ <> nd_)
            OR (p_nd_ IS NULL AND nd_ IS NOT NULL)
            OR (p_nd_ IS NOT NULL AND nd_ IS NULL)
         THEN
            kod_nnnn := LPAD (TO_CHAR (nnnn_), 4, '0');

            -- 12 значный код подразделения
--            nbuc_ := nvl(substr(f_codobl_tobo(acc_,5),-12),b040_);
            IF sheme_ = 'G' AND typ_ > 0
            THEN
               nbuc_ := SUBSTR (NVL (f_codobl_tobo (acc_, typ_), b040_), -12);
            ELSE
               nbuc_ := SUBSTR (TRIM (b040_), -12);
            END IF;

            -- вид забезпечення кредит_в
            p_ins ('080' || kod_okpo || kod_nnnn || '0000' || '000', p080_);
            -- код класса контрагента/инсайдера
--            p_ins ('085' || kod_okpo || kod_nnnn || '0000' || '000', p085_);
            -- _дентиф_катор договору
            p_ins ('090' || kod_okpo || kod_nnnn || '0000' || '000', p090_);

--            IF dat_ > TO_DATE ('01012008', 'ddmmyyyy')
--            THEN
               -- 12 значний код п_дрозд_лу
--             p_ins ('091' || kod_okpo || kod_nnnn || '0000' || '000',
--                      nbuc_);
--            END IF;

            -- сума заборгованост_ зг_дно договору
            p_ins ('110' || kod_okpo || kod_nnnn || '0000' || p140_,
                   TO_CHAR (ABS (sum_zd_))
                  );
            -- дата виникнення заборгованост_
            p_ins ('111' || kod_okpo || kod_nnnn || '0000' || '000',
                   TO_CHAR (p111_, dfmt_)
                  );
            -- дата погашення заборгованост_ зг_дно з договором
            p_ins ('112' || kod_okpo || kod_nnnn || '0000' || '000',
                   TO_CHAR (p112_, dfmt_)
                  );

            -- дата фактичного погашення заборгованост_ зг_дно з договором
            p_ins ('113' || kod_okpo || kod_nnnn || '0000' || '000',
                   TO_CHAR (p112_, dfmt_)
                  );
            -- стан заборгованост_
            p_ins ('160' || kod_okpo || kod_nnnn || '0000' || '000', s080_);
            nnnn_ := nnnn_ + 1;
         END IF;

         IF mfo_ = 353575 AND p080_ = '33'
         THEN
            p081_ := '0';
         END IF;

         if p081_ <> 0 then
            -- вартiсть забезпечення кредиту
            p_ins ('081' || kod_okpo || kod_nnnn || '0000' || '000', p081_, nls_);
         end if;

         -- сума фактичної заборгованост_ контрагента
         IF ddd_ = '119'
         THEN
            ddd_ := '120';
            p_ins (ddd_ || kod_okpo || kod_nnnn || '0000' || p140_,
                   TO_CHAR (ABS (p120_)),
                   nls_
                  );
         ELSE
            IF ddd_ IN ('122', '124')
            THEN
               ddd_ := '120';
               -- дисконт та прем_ю показуємо з_ знаком
               p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                      TO_CHAR (0 - p120_),
                      nls_
                     );
            ELSE
               ddd_ := '120';
               p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || p140_,
                      TO_CHAR (ABS (p120_)),
                      nls_
                     );
            END IF;
         END IF;

         -- сума резерв_в
--         IF p125_ <> 0 AND p070_ NOT LIKE '9%'
--         THEN
--            p_ins ('125' || kod_okpo || kod_nnnn || p070_ || p140_,
--                   p125_,
--                   nls_
--                  );
--         END IF;

--         if p130_ <> 0 then
            -- процентна ставка за кредитом
            p_ins ('130' || kod_okpo || kod_nnnn || '0000' || p140_,
                   LTRIM (TO_CHAR (p130_, fmt_)),
                   nls_
                  );
--         end if;

        -- вiдсоток суми фактичної заборгованостi контрагента
--        p_ins('150' || kod_okpo || kod_nnnn || '0000' || '000', p150_, nls_);
-- 03.06.2008 убираем разбивку по договорам (вместо kod_nnnn заносим '0000')
--         if p150_ <> 0 then
            p_ins ('150' || kod_okpo || '0000' || '0000' || '000',
                   LTRIM (TO_CHAR (p150_, fmt_)), nls_);
--         end if;

         p_nd_ := nd_;
         p_sum_zd_ := sum_zd_;
         p_p111_ := p111_;
         p_p112_ := p112_;
         p_p090_ := p090_;
         p_rnk_ := rnk_;
      end if;

      END LOOP;

      CLOSE c_cust_dg;
   END LOOP;

   CLOSE c_cust;

----------------------------------------------------
   DELETE FROM tmp_irep
         WHERE kodf = kodf_ AND datf = dat_;

----------------------------------------------------
   OPEN basel;

   LOOP
      FETCH basel
       INTO kodp_, znap_;

      EXIT WHEN basel%NOTFOUND;

      BEGIN
         INSERT INTO tmp_irep
                     (kodf, datf, kodp, znap
                     )
              VALUES (kodf_, dat_, kodp_, znap_
                     );
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20004,
                                     'Ошибка: ' || SQLERRM || ' kodp:'
                                     || kodp_
                                    );
      END;
   END LOOP;

   CLOSE basel;

----------------------------------------
   OPEN basel1;

   LOOP
      FETCH basel1
       INTO kodp_, znap_;

      EXIT WHEN basel1%NOTFOUND;
      znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_) / 10000, fmt_));

      INSERT INTO tmp_irep
                  (kodf, datf, kodp, znap
                  )
           VALUES (kodf_, dat_, kodp_, znap_
                  );
   END LOOP;

   CLOSE basel1;

-----------------------------------------
   OPEN basel2;

   LOOP
      FETCH basel2
       INTO kodp_, znap_;

      EXIT WHEN basel2%NOTFOUND;

      IF SUBSTR (kodp_, 1, 3) = '150'
      THEN
         znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_), fmt_));
      END IF;

      INSERT INTO tmp_irep
                  (kodf, datf, kodp, znap
                  )
           VALUES (kodf_, dat_, kodp_, znap_
                  );
   END LOOP;

   CLOSE basel2;
----------------------------------------
END p_f71sb;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F71SB.sql =========*** End *** =
PROMPT ===================================================================================== 
