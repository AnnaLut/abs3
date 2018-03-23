

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F2C_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F2C_NN ***

  CREATE OR REPLACE PROCEDURE BARS.p_f2c_nn (dat_      DATE,
                                           sheme_    VARCHAR2 DEFAULT 'G',
                                           pr_op_    NUMBER DEFAULT 1)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :   Процедура формирования #2C для КБ (универсальная)
% COPYRIGHT   :   Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   24/11/2017  (04/09/2017, 22/03/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
      sheme_ - схема формирования
      pr_op_ - признак операции (1 - данi про намiр )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
24/11/2017 Змінено умову вибірки платежiв у гривні на Дт 1919(OB22=04) Кт 1600, код операції 010 (SC-0133889)
           Реалізовано вибірку назви банку (P07) для платежів з довідника RC_BNK
           Для показника P73 генерується рядок з пустим значенням показника (SC-0507893)  
11/04/2017 Виключено заявки, у яких «Код купівлі за імпортом (#2C)»=0 і «Причина покупки»=3.1.a.1
           Включено платежі у гривні по опраціях '001', '002', '010', у яких «Код купівлі за імпортом (#2C)»=6, 7 і 
            рахунок а: '2520', '2530', '2541', '2542', '2544', '2545', '2600', '2650', рахунок Б ‘1919’
          Включено операції у валюті з 2062, 2063
22/03/2017 вилучено показник p11, p70.
           Змінено умову відбору документів та заявок у звіт. Відбираються:
           - документи, проведені у дату звіту (opldok.fdat=dat_);
           - заявки, виконані у дату звіту (zayavka.vdate=dat_).           
03/01/2017 Включено у звіт заявки та платежі за день формування звіту, які вже завізовані та 
           у яких значення показника p12=9
09/11/2016 Змінено алгоритм розрахунку p73 та винесено його в окрему функцію 
           f_cim_2c_p73, а саме:
           до суми показника включаються значення заборгованості по платежах,
           з датою валютування у поточнному місяці,які не закриті МД, або дата 
           закриваючих МД більша дати валютування платежу. 
           Значення заборгованості перераховуються у USD по курсу на дату 
           контракту відповідного платежу
05/09/2016 Уточнено алгоритм розрахунку p70 для заявок:
           - якщо на момент формування звіту на рахунку 2900 клієнта сума менша 
             за еквівалент заявки по курсу НБУ, то p70 = 0;
           - якщо протягом дня на рахунок 2900 (грн) клієнта надійшов (проведений) 
             1 платіж на суму в інтервалі (1 - 1.15) від еквіваленту заявки
             по курсу НБУ на дату заявки, то p70 = сумі, що надійшл;
           - в іншому випадку p70 = еквіваленту заявки по курсу НБУ на дату заявки.
02/09/2016 У звіті включено відображення усіх заявок та платежів окремими 
           стрічками (без консолідації та вилучення).
01/09/2016 Змінено алгоритм розрахунку p70 - для платежів=0, для заявок, якщо 
           протягом дня на рахунок 2900 (грн) клієнта надійшов 1 платіж на суму 
           в інтервалі (1 - 1.15) від еквіваленту заявки по курсу НБУ на дату 
           заявки, то p70 = сумі, що надійшла, в іншому випадку =  еквіваленту 
           заявки по курсу НБУ на дату заявки.
           Змінено алгоритм розрахунку p73: рівний сумі незакритих МД залишків 
           платежів за поточний місяць по контрактах даного резидента та 
           нерезидента, перетворених у USD по курсу НБУ на дату відкриття 
           контрактів, по яких надійшли ці платежі.
           Добавлено вибірку показників звіту також з "інших" контрактів.
01/07/2016 добавлено автозаповнення значень p05, p06, p07 при p04= '2.1.б.1',
           '2.1.б.2', '2.4','2.5'
01/06/2016 з 01.06.2016р p11 для заявок пустий, для платежів у грн. з L=6,7 має значення 
           дати валютування, в нінших випадках пустий  
15/04/2016 p73 розраховується як сума платежів передоплати за місяць між резедентом 
           та нерезидентом
16/03/2016 протокол формирования будет сохраняться в таблицу 
           OTCN_TRACE_70
26/11/2015 з 27.11.2015 відміна консоладації по заявках, обов'язкове
           заповнення показника 12 через додатковий реквізит,
           також включено вибірку інформації з кредитних контрактів
24/09/2015 с 24.09.2015 не будет формироваться код 72 и дополнительно будет
           формироваться код DD='12' (примітка)
23/06/2015 изменено формирование показателя 73 в соответствии со служебной
           запиской Рощиної В.М. от 19.06.2015 N 52-18/819
27/04/2015 изменения выполнены в соответствии с разъяснениями НБУ
           от 24.04.2015  № 25-04001/27935
15/04/2015 для консолидации включаем суммы меньше 5000000 (50 тыс)
24/03/2015 изменено формирование показателей DD='06', DD='07'
18/03/2015 изменено формирование показателя DD='11'
17/03/2015 для MFOU_=300465 новый вариант блока отбора данных
           из таблицы ZAYAVKA
04/03/2015 для MFOU_=300465 будем формировать файл из таблицы ZAYAVKA
03/03/2015 из V_ZAY выбираем не удаленные заявки SOS>=0 (SOS=-1 удалена)
27/02/2015 з 25.02.2015 будемо формувати показники 72, 73
30/09/2014 для 300120 сумму эквивалента P70 рассчитываем а не выбираем из
           поля OSTC0 VIEW V_ZAY
10/09/2014 будут включаться док-ты с суммой не менее 100000.00$
09/09/2014 для банка Петрокоммерц данные выбираем из V_ZAY и кол-во дней
           намерений 2 вместо 6
25/03/2014 для банка Петрокоммерц NBUC='26'
17/03/2014 для банка Петрокоммерц данные выбираем из V_ZAY
20/02/2014 код территории определялся по 2909 вместо 2600
17/02/2014 первый вариант
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_      VARCHAR2 (2) := '2C';
sql_z      VARCHAR2 (200);
typ_       NUMBER;
gr_sum_    NUMBER := 10000000;                 --5000000;     --для покупки
-- для продажу i надходження вiд нерезидентiв
flag_      NUMBER;
-- флаг для определение наличия поля BENEFCOUNTRY т.TOP_CONTRACTS
-- (из модуля биржевые операции)
pr_s3_     NUMBER;     -- флаг для определение наличия поля S3 табл.ZAYAVKA
-- (из модуля биржевые операции)
s3_        NUMBER;
ko_        VARCHAR2 (2);       -- ознака операцii з безготiвковою iнвалютою
ko_1       VARCHAR2 (2);       -- ознака операцii з безготiвковою iнвалютою
kod_b      VARCHAR2 (10);                           -- код iноземного банку
nam_b      VARCHAR2 (70);                         -- назва iноземного банку
n_         NUMBER := 10;
-- кол-во доп.параметров до 03.07.2006 после n_=11
acc_       NUMBER;
acck_      NUMBER;
kv_        NUMBER;
kv1_       NUMBER;
nls_       VARCHAR2 (15);
nlsk_      VARCHAR2 (15);
nlsk1_     VARCHAR2 (15);
nbuc1_     VARCHAR2 (12);
nbuc_      VARCHAR2 (12);
country_   VARCHAR2 (3);
b010_      VARCHAR2 (10);
bic_code   VARCHAR2 (14);
rnk_       NUMBER;
okpo_      VARCHAR2 (14);
ourOKPO_   VARCHAR2 (14);
ourGLB_    VARCHAR2 (3);
nmk_       VARCHAR2 (70);
adr_       VARCHAR2 (70);
k040_      VARCHAR2 (3);
k110_      VARCHAR2 (5);
val_       VARCHAR2 (70);
d1#70_     VARCHAR2 (70);
d6#70_     VARCHAR2 (70);
d7#70_     VARCHAR2 (70);
d1#D3_     VARCHAR2 (70);
nazn_      VARCHAR2 (160);
a1_        VARCHAR2 (70);
a2_        VARCHAR2 (70);
a3_        VARCHAR2 (70);
a4_        VARCHAR2 (70);
a5_        VARCHAR2 (70);
a6_        VARCHAR2 (70);
a7_        VARCHAR2 (70);
nb_        VARCHAR2 (70);
nb1_       VARCHAR2 (70);
tg_        VARCHAR2 (70);
data_      DATE;
dig_       NUMBER;
bsum_      NUMBER;
bsu_       NUMBER;
sum1_      DECIMAL (24);
sum0_      DECIMAL (24);
sumk1_     DECIMAL (24);                  --ком_с_я в ц_лому по контрагенту
sumk0_     DECIMAL (24);                             --ком_с_я по контракту
kodp_      VARCHAR2 (10);
znap_      VARCHAR2 (70);
kurs_      NUMBER;
kurs1_     NUMBER;
tag_       VARCHAR2 (5);
nnnn_      NUMBER := 0;
userid_    NUMBER;
ref_       NUMBER;
rez_       NUMBER;
codc_      NUMBER;
mfo_       NUMBER;
mfou_      NUMBER;
koldop_    NUMBER;
refd_      NUMBER;
s0_        VARCHAR2 (16);
kol_       NUMBER;
swift_k_   VARCHAR2 (12);
--branch_    customer.branch%TYPE;
branch_    customer.tobo%TYPE;
kod_obl_   VARCHAR2 (2);
l_         VARCHAR2 (1);

--курсор по контрагентам
CURSOR c_main
IS
     SELECT t.ko,
            NVL (
               DECODE (SUBSTR (b.b040, 9, 1),
                       '2', SUBSTR (b.b040, 15, 2),
                       SUBSTR (b.b040, 10, 2)),
               nbuc_),
            c.rnk,
            c.okpo,
            c.nmk,
            TO_CHAR (c.country),
            c.adr,
            NVL (c.ved, '00000'),
            c.codcagent,
            t.kv,
            SUM (t.s_eqv),
            NVL (SUM (gl.p_icurval (t.kv, t.s_kom, dat_)), 0)
       --сумма в формате грн.коп
       FROM OTCN_PROV_TEMP t, customer c, tobo b                 --branch b
      WHERE t.rnk = c.rnk AND c.tobo = b.tobo(+)      --c.branch = b.branch
   GROUP BY t.ko,
            NVL (
               DECODE (SUBSTR (b.b040, 9, 1),
                       '2', SUBSTR (b.b040, 15, 2),
                       SUBSTR (b.b040, 10, 2)),
               nbuc_),
            c.rnk,
            c.okpo,
            c.nmk,
            TO_CHAR (c.country),
            c.adr,
            NVL (c.ved, '00000'),
            c.codcagent,
            t.kv
   ORDER BY 2;

--- Намір покупки
CURSOR opl_dok
IS
     SELECT t.ko,
            t.REF,
            t.accd,
            t.nlsd,
            t.kv,
            t.acck,
            t.nlsk,
            t.nazn,
            SUM (t.s_nom),
            SUM (t.s_kom)
       FROM OTCN_PROV_TEMP t
      WHERE t.rnk = rnk_
   GROUP BY t.ko,
            t.REF,
            t.acck,
            t.nlsk,
            t.kv,
            t.accd,
            t.nlsd,
            t.nazn;

-------------------------------------------------------------------
PROCEDURE p_ins (p_np_     IN NUMBER,
                 p_kodp_   IN VARCHAR2,
                 p_znap_   IN VARCHAR2)
IS
   l_kodp_   VARCHAR2 (13);
BEGIN
   l_kodp_ := p_kodp_ || LPAD (TO_CHAR (p_np_), 4, '0');

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
                p_znap_,
                nbuc_,
                ref_,
                rnk_,
                TO_CHAR (refd_));
END;

-------------------------------------------------------------------
FUNCTION f_benef_country (p_ref_ IN NUMBER)
   RETURN VARCHAR2
IS
   code_     NUMBER;
   v_code_   VARCHAR2 (3) := NULL;
   sql_      VARCHAR2 (200);
BEGIN
   IF flag_ >= 1
   THEN
      sql_ :=
            'select t.benefcountry '
         || 'from zayavka z, TOP_CONTRACTS t '
         || 'where z.ref=:p_ref_ and '
         || '        z.dk=1 and '
         || '        z.pid=t.pid';

      EXECUTE IMMEDIATE sql_ INTO code_ USING p_ref_;

      v_code_ := LPAD (TRIM (code_), 3, '0');
   END IF;

   RETURN v_code_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END;

-------------------------------------------------------------------
FUNCTION f_benef_bic (p_ref_ IN NUMBER)
   RETURN VARCHAR2
IS
   bic_   VARCHAR2 (12) := NULL;
   sql_   VARCHAR2 (200);
BEGIN
   IF flag_ >= 1
   THEN
      sql_ :=
            'select t.benefbic '
         || 'from zayavka z, TOP_CONTRACTS t '
         || 'where z.ref=:p_ref_ and '
         || '      z.dk=1 and '
         || '      z.pid=t.pid';

      EXECUTE IMMEDIATE sql_ INTO bic_ USING p_ref_;
   END IF;

   RETURN bic_;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END;

-------------------------------------------------------------------
FUNCTION f_benef_bank (p_ref_ IN NUMBER)
   RETURN VARCHAR2
IS
   nam_b   VARCHAR2 (70) := NULL;
   sql_    VARCHAR2 (200);
BEGIN
   IF flag_ >= 1
   THEN
      sql_ :=
            'select t.benefbank '
         || 'from zayavka z, TOP_CONTRACTS t '
         || 'where z.ref=:p_ref_ and '
         || '      z.dk=1 and '
         || '      z.pid=t.pid';

      EXECUTE IMMEDIATE sql_ INTO nam_b USING p_ref_;
   END IF;

   RETURN nam_b;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      RETURN NULL;
END;

-------------------------------------------------------------------
PROCEDURE p_tag (p_i_       IN     NUMBER,
                 p_value_   IN OUT VARCHAR2,
                 p_kodp_       OUT VARCHAR2,
                 p_ref_     IN     NUMBER DEFAULT NULL)
IS
BEGIN
   IF p_i_ = 7
   THEN
      p_kodp_ := '04' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0');

      p_value_ :=
         NVL (SUBSTR (TRIM (p_value_), 1, 70),
              'пiдстава для придбання');

      d7#70_ := p_value_;
   ELSIF p_i_ = 2
   THEN
      p_kodp_ := '08' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0');
      p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'N контр.');
   ELSIF p_i_ = 3
   THEN
      p_kodp_ := '09' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0');
      p_value_ := NVL (SUBSTR (TRIM (p_value_), 1, 70), 'DDMMYYYY');
   --ELSIF p_i_ = 8
   --THEN
   --   p_kodp_ := '64';

   --   IF p_value_ IS NULL
   --   THEN
   --      p_value_ := f_benef_country (p_ref_);
   --   END IF;

   --   IF p_value_ IS NOT NULL
   --   THEN
   --      p_value_ := LPAD (p_value_, 3, '0');
   --   END IF;

   --   p_value_ :=
   --      NVL (SUBSTR (TRIM (p_value_), 1, 70),
   --           'код краiни клiєнта-бенефiцiара'
   --          );
   ELSIF p_i_ = 9
   THEN
      p_kodp_ := '06' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0');

      IF p_value_ IS NULL
      THEN
         p_value_ :=
            NVL (SUBSTR (TRIM (p_value_), 1, 70),
                 'код iноземного банку');
      END IF;
   ELSIF p_i_ = 10
   THEN
      p_kodp_ := '07' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0');

      IF p_value_ IS NULL
      THEN
         p_value_ :=
            NVL (SUBSTR (TRIM (nb_), 1, 70),
                 'назва iноземного банку');
      END IF;
   ELSE
      p_kodp_ := 'NN';
   END IF;
END;

--------------------------------------------------------------------------
BEGIN
   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';

-------------------------------------------------------------------
   logger.info ('P_F2C_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';


   DELETE FROM OTCN_PROV_TEMP;

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
   -- определение наличия поля BENEFCOUNTRY т.TOP_CONTRACTS
   SELECT COUNT (*)
     INTO flag_
     FROM all_tab_columns
    WHERE     owner = 'BARS'
          AND table_name = 'TOP_CONTRACTS'
          AND column_name = 'BENEFCOUNTRY';
   
   -- определение наличия поля S3 табл.ZAYAVKA
   SELECT COUNT (*)
     INTO pr_s3_
     FROM all_tab_columns
    WHERE owner = 'BARS' AND table_name = 'ZAYAVKA' AND column_name = 'S3';
   
   -- параметры формирования файла
   p_proc_set (kodf_,
               sheme_,
               nbuc1_,
               typ_);
   --- выбор курса долара для пересчета суммы
   kurs_ := f_ret_kurs (840, dat_);
   
   ourOKPO_ := LPAD (F_Get_Params ('OKPO', NULL), 8, '0');
   
   BEGIN
      SELECT LPAD (TO_CHAR (GLB), 3, '0')
        INTO ourGLB_
        FROM rcukru
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         ourGLB_ := NULL;
   END;
   
   IF dat_ >= TO_DATE ('25022015', 'ddmmyyyy')
   THEN
      gr_sum_ := 100;
   END IF;
   
   IF mfou_ NOT IN (300120, 300465)
   THEN
      -- отбор проводок, удовлетворяющих условию
      INSERT INTO OTCN_PROV_TEMP (ko,
                               rnk,
                               REF,
                               acck,
                               nlsk,
                               kv,
                               accd,
                               nlsd,
                               nazn,
                               s_nom,
                               s_eqv)
      SELECT *
        FROM (                                   --про намiр куп_влі валюти
              SELECT   '1' ko,
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn,
                       SUM (o.s * 100) s_nom,
                       SUM (gl.p_icurval (o.kv, o.s * 100, dat_)) s_eqv
                  FROM provodki o, cust_acc ca
                 WHERE     o.fdat = dat_
                       AND o.kv = 980
                       AND (   (    SUBSTR (o.nlsd, 1, 4) = '2600'
                                AND SUBSTR (o.nlsk, 1, 4) = '2900')
                            OR (    SUBSTR (o.nlsd, 1, 4) = '3929'
                                AND SUBSTR (o.nlsk, 1, 4) = '2900'))
                       AND o.accd = ca.acc
              GROUP BY '1',
                       ca.rnk,
                       o.REF,
                       o.acck,
                       o.nlsk,
                       o.kv,
                       o.accd,
                       o.nlsd,
                       o.nazn)
       WHERE ROUND (s_eqv / kurs_, 0) >= gr_sum_;
   END IF;

   IF pr_s3_ >= 1
   THEN
      sql_z :=
            'UPDATE OTCN_PROV_TEMP t '
         || 'SET t.s_kom=(SELECT z.s3 FROM ZAYAVKA z WHERE z.REF=t.REF) '
         || 'WHERE t.REF IN (SELECT REF FROM ZAYAVKA WHERE NVL(s3,0)<>0)';
   
      EXECUTE IMMEDIATE sql_z;
   END IF;
   
   OPEN c_main;
   
   LOOP
      FETCH c_main
         INTO ko_,
           kod_obl_,
           rnk_,
           okpo_,
           nmk_,
           k040_,
           adr_,
           k110_,
           codc_,
           kv1_,
           sum1_,
           sumk1_;

   EXIT WHEN c_main%NOTFOUND;

   sum1_ := sum1_ - NVL (sumk1_, 0);
   rez_ := MOD (codc_, 2);

   -- 10.06.2009 изменил на следующее
   IF LENGTH (TRIM (okpo_)) <= 8
   THEN
      okpo_ := LPAD (TRIM (okpo_), 8, '0');
   ELSE
      okpo_ := LPAD (TRIM (okpo_), 10, '0');
   END IF;

   -- для банков по коду ОКПО из RCUKRU(IKOD)
   -- определяем код банка поле GLB
   IF codc_ IN (1, 2)
   THEN
      BEGIN
         SELECT GLB
           INTO okpo_
           FROM rcukru
          WHERE TRIM (ikod) = TRIM (okpo_) AND ROWNUM = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            NULL;
      END;
   END IF;

   IF ( (pr_op_ = 1 AND ko_ = '1' AND sum1_ > gr_sum_))
   THEN
      ---Намір купівлі валюти
      OPEN opl_dok;

      LOOP
         FETCH opl_dok
            INTO ko_1,
                 ref_,
                 acc_,
                 nls_,
                 kv_,
                 acck_,
                 nlsk_,
                 nazn_,
                 sum0_,
                 sumk0_;

         EXIT WHEN opl_dok%NOTFOUND;

         --IF kodf_='2C'
         --THEN
         IF typ_ > 0
         THEN
            nbuc_ := NVL (f_codobl_tobo (acc_, typ_), nbuc1_);
         ELSE
            nbuc_ := nbuc1_;
         END IF;

         s0_ := TO_CHAR (sum0_ / 100, '999999999999.99');

         nnnn_ := nnnn_ + 1;
         sum0_ := sum0_ - NVL (sumk0_, 0);
         d1#D3_ := NULL;
         l_ := '0';

         -- проверка есть ли для данной проводки доп. реквизиты
         SELECT COUNT (*)
           INTO koldop_
           FROM operw
          WHERE REF = ref_ AND tag LIKE 'D_#70';

         IF koldop_ > 0
         THEN
            refd_ := ref_;
         ELSE
            IF ko_ = 2 AND nls_ LIKE '2600%' AND nlsk_ LIKE '2900%'
            THEN
               BEGIN
                  SELECT REF
                    INTO refd_
                    FROM provodki p
                   WHERE     fdat = dat_
                         AND accd = acck_
                         AND kv = kv_
                         AND s = s0_
                         AND EXISTS
                                (SELECT 1
                                   FROM operw o
                                  WHERE o.REF = p.REF AND tag LIKE 'D_#70')
                         AND ROWNUM = 1;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     refd_ := NULL;
               END;
            ELSE
               refd_ := NULL;
            END IF;
         END IF;

         d6#70_ := NULL;

         BEGIN
            SELECT SUBSTR (VALUE, 1, 3)
              INTO val_
              FROM operw
             WHERE REF = refd_ AND tag = 'D6#70';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               val_ := '000';
         END;

         k040_ := val_;

         IF INSTR (LOWER (nazn_), 'дол') > 0
         THEN
            kv_ := 840;
         ELSIF INSTR (LOWER (nazn_), 'евро') > 0
         THEN
            kv_ := 978;
         ELSIF INSTR (LOWER (nazn_), 'руб') > 0
         THEN
            kv_ := 643;
         ELSIF INSTR (LOWER (nazn_), 'фунт') > 0
         THEN
            kv_ := 826;
         ELSE
            kv_ := 999;
         END IF;

         IF (d6#70_ IS NULL OR d6#70_ <> '804')
         THEN                            --and ROUND (sum0_ / dig_, 0) >= 1
            -- сума в коп
            p_ins (
               nnnn_,
               '70' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
               TO_CHAR (sum0_));

            -- сума в валюте
            p_ins (
               nnnn_,
               '71' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
               '0');

            IF     dat_ >= TO_DATE ('25022015', 'ddmmyyyy')
               AND dat_ <= TO_DATE ('23092015', 'ddmmyyyy')
            THEN
               -- сума контракту
               p_ins (
                  nnnn_,
                  '72' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
                  '0');
            END IF;

            IF dat_ >= TO_DATE ('25022015', 'ddmmyyyy')
            THEN
               -- загальна сума платежів
               p_ins (
                  nnnn_,
                  '73' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
                  '0');
            END IF;

            -- ОКПО клiєнта
            IF rez_ = 0 AND TRIM (okpo_) IS NULL        -- для нерезидентiв
            THEN
               okpo_ := '0';
            END IF;

            IF okpo_ = ourOKPO_
            THEN
               okpo_ := ourGLB_;
               codc_ := 1;
            END IF;

            -- код ЄДРПОУ (ДРФО)
            p_ins (
               nnnn_,
               '01' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
               TRIM (okpo_));

            -- назва клiєнта
            p_ins (
               nnnn_,
               '02' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
               TRIM (nmk_));
            -- адреса клiєнта
            p_ins (
               nnnn_,
               '03' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
               TRIM (adr_));
         END IF;

         -- додатковi параметри
         IF dat_ >= TO_DATE ('03072006', 'ddmmyyyy')
         THEN
            n_ := 11;
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
            ELSE
               tag_ := 'DD#70';
            END IF;

            -- для покупки нужны все доп.реквизиты (D1#70 - DA#70)
            IF pr_op_ = 1 AND ko_ = 1 AND i IN (2, 3, 7, 9, 10)
            THEN
               BEGIN
                  SELECT SUBSTR (VALUE, 1, 70)
                    INTO val_
                    FROM operw
                   WHERE REF = refd_ AND tag = tag_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     val_ := NULL;
               END;

               IF dat_ >= TO_DATE ('14022014', 'ddmmyyyy')
               THEN
                  -- код показника та default-значення
                  p_tag (i,
                         val_,
                         kodp_,
                         ref_);
                  -- запис показника
                  p_ins (nnnn_, kodp_, val_);
               END IF;
            END IF;
         END LOOP;

         -- назва бенефіціара
         p_ins (nnnn_,
                '05' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
                'назва бенефіціара');

         -- дата заявки
         p_ins (nnnn_,
                '11' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
                'дата заявки');

         -- новий показник з 24.09.2015 (примітка)
         IF dat_ >= TO_DATE ('24092015', 'ddmmyyyy')
         THEN
            -- примітка
            p_ins (
               nnnn_,
               '12' || l_ || LPAD (kv_, 3, '0') || LPAD (k040_, 3, '0'),
               ' ');
         END IF;
      --END IF;
      END LOOP;

      CLOSE opl_dok;
   END IF;
END LOOP;

CLOSE c_main;

---------------------------------------------------
-- для всех РУ Сбербанка  300465
IF mfou_ = 300465
THEN
   nbuc_ := nbuc1_;
   nnnn_ := 0;

   FOR k
      IN (select d.t, d.l, d.vvv as kv, d.mmm, decode(d.n, -1, '0', c.okpo) as p01, 
                     decode(d.n, -1, to_char(d.p02, 'fm999999'), c.nmk) as p02,
                     decode(d.n, -1, '0', 
                      decode( (select count(*) from customer_address where type_id=1 and rnk=d.rnk), 1,
                                       (select nvl2(zip, zip || ', ', '') || case when lower(domain) not like '%місто%' then domain || ', ' else '' end ||
                                          case when lower(region) not like '%місто%' then region || ', ' else '' end ||locality || ', ' || address 
                                          from customer_address where type_id=1 and rnk=d.rnk),
                                       c.adr )) as p03,
                     d.p04, d.p05, d.p06, d.p07, d.p08, d.p09, 
                     nvl2(d.p11,to_char(d.p11,'ddmmyyyy'), '0') as p11, 
                     d.p70, d.p71, d.p72, d.p73, d.p12                               
              from
                   (select y.t, min(y.rnk) as rnk, y.n, nvl(y.l,'L') as l, y.vvv, 
                           decode(y.n, -1, '000', nvl(to_char(min(y.country_id),'fm009'), 'XXX')) as mmm, 
                           count(*) as p02, y.p04, 
                           decode(y.n, -1, '0', min(y.benef_name)) as p05, 
                           decode(y.n, -1, '0000000000', min(y.b010)) as p06, 
                           decode(y.n, -1, '0', min(y.bank_name)) as p07, 
                           decode(y.n, -1, '0', min(y.p08)) as p08, 
                           decode(y.n, -1, '0', to_char(min(y.p09),'ddmmyyyy')) as p09, 
                           min(y.p11) as p11, 
                           sum(y.p70) as p70 ,
                           sum(y.p71) as p71, 
                           decode(y.n, -1, '0', min(y.p72)) as p72, 
                           /*case when y.n = -1 or y.l in ('0', '1', '5', '6', '7', '8') then '0' else to_char(min(y.p73), 'fm999999999999') end*/ null as p73, min(y.p12) as p12           
                    from
                        (select --Умова консолідації
                               x.n, x.t, x.p11, x.l, x.vvv, x.p71, x.rnk, x.p04, x.p08, x.p09, k.num, k.open_date, k.benef_id, 
                                  case when x.p04 in ('3.1.а.1', '3.1.А.1', '3.1.a.1','3.1.A.1') 
                                         then (select name from cim_journal_num where branch = '/'||f_ourmfo||'/')
                                       when x.p04 in ('2.1.б.1', '2.1.Б.1', '2.1.б.2', '2.1.Б.2', '2.4','2.5') then '0'
                                       else k.benef_name end as benef_name, 
                                  case when x.p04 in ('3.1.а.1', '3.1.А.1', '3.1.a.1','3.1.A.1', '2.1.Б.1', '2.1.б.1', '2.1.Б.2', '2.1.б.2') then 804 else k.country_id end as country_id,  
                                  decode(x.t, 0, x.p06, k.b010) b010, decode(x.t, 0, x.p07, ( select name from rc_bnk r where r.b010=k.b010 )/*k.bank_name*/) as bank_name, 
                                  null as p73/*k.p73*/, k.p72, x.p12, x.p70 --k.sp,
                          from
                              ( select 0 as t, rownum as n, case when dat_<to_date('01/06/2016', 'dd/mm/yyyy') then z.fdat else to_date(null) end as p11, nvl(substr(z.code_2c,1,1),9) as l, 
                                       z.kv2 as vvv, z.s2 as p71, z.rnk, 
                                       z.basis as p04, z.contract as p08, z.dat2_vmd as p09,             
                                       case when z.basis in ('3.1.а.1', '3.1.А.1', '3.1.a.1','3.1.A.1',
                                                             '2.1.б.1', '2.1.Б.1', '2.1.б.2', '2.1.Б.2','2.4','2.5') then '0000000000' else z.bank_code end as p06,
                                       case when z.basis in ('3.1.а.1', '3.1.А.1', '3.1.a.1','3.1.A.1',
                                                             '2.1.б.1', '2.1.Б.1', '2.1.б.2', '2.1.Б.2','2.4','2.5') then '0' else z.bank_name end as p07, nvl(z.p12_2c,'?') as p12,
                                       round(z.s2*z.kurs_f, 0) as p70                         
                                from zayavka z
                                     join oper o on o.sos>-1 and o.ref=z.ref    
                                where not( substr(z.code_2c,1,1)=0 and z.basis in ('3.1.а.1', '3.1.А.1', '3.1.a.1','3.1.A.1') ) 
                                      and z.dk=1 and z.sos=2 and z.vdate=dat_
                                union all 
                                select 1 as t, rownum as n, 
                                       case when dat_>=to_date('01/06/2016', 'dd/mm/yyyy') and o.kv=980 and substr(w.value,1,1) in ('6', '7') 
                                         then o.vdat else to_date(null) end as p11, 
                                       substr(w.value,1,1) as l, o.kv as vvv, o.s as p71, a.rnk,
                                       '00000000000' as p04,
                                       (select value from operw where tag='D2#70' and ref=o.ref) as p08,
                                       (select (case when is_date(nvl2(regexp_substr(substr(value,1,2)||
                                                  substr(value,4,2)||substr(value,7,4),
                                                  '[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]'),
                                                   substr(value,1,2)||substr(value,4,2)||substr(value,7,4), null), 'ddmmyyyy') = 1 then
                                                  to_date(nvl2(regexp_substr(substr(value,1,2)||
                                                  substr(value,4,2)||substr(value,7,4),
                                                  '[[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]][[:digit:]]'),
                                                   substr(value,1,2)||substr(value,4,2)||substr(value,7,4), null), 'ddmmyyyy') else null end) 
                                        from operw where tag='D3#70' and ref=o.ref) as p09, null as p06, null as p07, nvl( www.value, '?') as p12, 0 as p70
                                from ( select kf, acc, nls, kv from accounts where dazs is null and (nls like '1919%' or nls like '3739%' and tip='T00') ) b  
                                     join opldok p on p.kf=b.kf and p.dk=1 and p.sos=5 and p.acc=b.acc and p.fdat=dat_ 
                                     left outer join operw w on w.tag='KOD2C' and w.ref=p.ref                                
                                     join oper o on case when /*o.tt in ('001', '002', '010') and w.value in ('6', '7') and 
                                                              substr(o.nlsa,1,4) in ( '2520', '2530', '2541', '2542', '2544', '2545', '2600', '2650' ) 
                                                              and o.nlsb like '1919%' and o.kv=980 */
                                                              o.tt='010' and w.value in ('6', '7') 
                                                              and case when o.nlsa like '1919%' then case when ( select ob22 from accounts a where kv=980 and a.nls=o.nlsa )= '04' then 1 else 0 end else 0 end = 1  
                                                              and o.nlsb like '1600%' and o.kv=980 then 1
                                                         when ( substr(o.nlsa,1,4) in ( '2062', '2063', '2600', '2602', '2620', '2625' ) or substr(o.nlsa,1,4)='2909' and w.value is not null )
                                                              and o.nlsb='191992' and o.kv<>980 then 1 
                                                         else 0 end = 1 
                                                    and o.dk=1 and o.sos=5 and o.ref=p.ref 
                                     left outer join operw www on www.tag in ('12#2C', '12_2C') and www.ref=p.ref             
                                     join accounts a on a.kf=o.kf and a.kv=o.kv and a.nls=o.nlsa ) x

                                left outer join 
                                (select rnk, num, open_date, benef_id, 
                                        min(country_id) as country_id, 
                                        min(contr_type) as contr_type,
                                        min(benef_name) as benef_name, 
                                        min(b010) as b010,  
                                        --min(bank_name) as bank_name,
                                        --min(f_cim_2c_p73(dat_, v.rnk, v.benef_id)) as p73,
                                        sum( decode(v.kv, 840, nvl((v.s-v.s_pl)*100,0), p_ncurval(840, p_icurval(v.kv, nvl((v.s-v.s_pl)*100,0), dat_), dat_) ) ) as p72,
                                        case when min(benef_id)=max(benef_id) and min(contr_type)=max(contr_type) then 1 else 0 end as cim_ok 
                                 from v_cim_trade_contracts v 
                                 where status_id != 1 and contr_type != 0 
                                 group by rnk, num, open_date, benef_id
                                 union all
                                 select rnk, num, open_date, min(benef_id) as benef_id, 
                                        min(country_id) as country_id, 
                                        min(contr_type) as contr_type,
                                        min(benef_name) as benef_name, 
                                        min(b010) as b010,  
                                        --min(bank_name) as bank_name,
                                        --0 as p73,
                                        sum( decode(v.kv, 840, nvl( (v.s-( select sum(s_vk) from v_cim_bound_payments b 
                                                                           where b.direct=1 and b.type_id in (0, 1, 4) and pay_flag=0 and b.contr_id=v.contr_id ))*100,0), 
                                                               p_ncurval(840, p_icurval(v.kv, nvl((v.s-( select sum(s_vk) from v_cim_bound_payments b 
                                                                                                          where b.direct=1 and b.type_id in (0, 1, 4) and pay_flag=0 and b.contr_id=v.contr_id ))*100,0), 
                                                                         dat_), dat_) ) ) as p72,
                                        case when min(benef_id)=max(benef_id) and min(contr_type)=max(contr_type) then 1 else 0 end as cim_ok  
                                  from v_cim_all_contracts v 
                                 where contr_type in (2, 3)
                                 group by rnk, num, open_date 
                               ) k
                                 on  k.cim_ok=1 and upper(k.num)=upper(x.p08) and k.open_date=x.p09 and k.rnk=x.rnk) y
                    where y.n>-9             
                    group by y.n, y.t, y.vvv, y.l, y.p04) d
              left outer join customer c on c.rnk=d.rnk
            ) 
   LOOP
      nnnn_ := nnnn_ + 1;

      -- сума в валюте
      p_ins (nnnn_,
             '71' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TO_CHAR (k.p71, 'fm99999999999999'));

      IF     dat_ >= TO_DATE ('25022015', 'ddmmyyyy')
         AND dat_ <= TO_DATE ('23092015', 'ddmmyyyy')
      THEN
         -- сума контракту
         p_ins (
            nnnn_,
            '72' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
            TO_CHAR (k.p72, 'fm99999999999999'));
      END IF;

      IF dat_ >= TO_DATE ('25022015', 'ddmmyyyy')
      THEN
         -- загальна сума платежів
         p_ins (
            nnnn_,
            '73' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
            TO_CHAR (k.p73, 'fm99999999999999'));
      END IF;

      -- код ЄДРПОУ (ДРФО)
      p_ins (nnnn_,
             '01' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (k.p01));

      -- назва клiєнта
      p_ins (nnnn_,
             '02' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (k.p02));

      -- адреса клiєнта
      p_ins (nnnn_,
             '03' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (SUBSTR (k.p03, 1, 70)));

      -- пiдстави для купiвлi валюти
      p_ins (nnnn_,
             '04' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (k.p04));

      -- назва бенефіціара
      p_ins (nnnn_,
             '05' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (SUBSTR (k.p05, 1, 70)));

      -- код iноземного банку
      p_ins (nnnn_,
             '06' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (k.p06));

      -- назва iноземного банку
      p_ins (nnnn_,
             '07' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (SUBSTR (k.p07, 1, 70)));

      -- номер контракту
      p_ins (nnnn_,
             '08' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (k.p08));

      -- дата укладення контракту
      p_ins (nnnn_,
             '09' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
             TRIM (k.p09));

/*      -- дата заявки
      IF dat_ < TO_DATE ('22032017', 'ddmmyyyy')
      THEN
         p_ins (nnnn_,
                '11' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
                TRIM (k.p11));
      END IF;          
*/
      -- новий показник з 24.09.2015 (примітка)
      IF dat_ >= TO_DATE ('24092015', 'ddmmyyyy')
      THEN
         -- примітка
         p_ins (
            nnnn_,
            '12' || k.l || LPAD (k.kv, 3, '0') || LPAD (k.mmm, 3, '0'),
            SUBSTR (TRIM (k.p12), 1, 3));
      END IF;
   --end if;

   END LOOP;
END IF;

--------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu
      WHERE kodf = kodf_ AND datf = dat_;

---------------------------------------------------
INSERT INTO tmp_nbu (kodf,
                     datf,
                     kodp,
                     znap,
                     nbuc)
   SELECT kodf_,
          dat_,
          kodp,
          znap,
          nbuc
     FROM rnbu_trace
    WHERE userid = userid_;
----------------------------------------

DELETE FROM OTCN_TRACE_70
         WHERE kodf = kodf_ and datf= dat_ ;

insert into OTCN_TRACE_70(KODF, DATF, USERID, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO)
select kodf_, dat_, USERID_, NLS, KV, ODATE, KODP, ZNAP, NBUC, ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
from rnbu_trace;

logger.info ('P_F2C_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));

END p_f2c_nn;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F2C_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
