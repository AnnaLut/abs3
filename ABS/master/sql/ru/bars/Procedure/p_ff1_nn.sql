

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FF1_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FF1_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FF1_NN (dat_ DATE, sheme_ VARCHAR2 DEFAULT 'G')
IS
   /*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   % DESCRIPTION : Процедура формирования #F1 для КБ
   % COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
   % VERSION     : 08/01/2015 (09/12/2014,29/10/2014,10/10/2014,19/09/2014)
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   параметры: Dat_ - отчетная дата
              sheme_ - схема формирования
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   08.01.2015 добавлена обработка доп.параметра 59 по которому определяем
              код страны 804
   09.12.2014 добавлена обработка доп.реквизита D6#71
              (Код країни перерах/надход.переказу) аналог кода D6#70
              для определения кода страны
   29.10.2014 удаляем анулированные переводы если они выполнены в одном
              банковском дне (дополнительно определяем фактическую дату
              оплаты анулированной проводки и при совпадении удаляем)
   10.10.2014 удаляем анулированные переводы если они выполнены в одном
              банковском дне
              доп.параметр "F1" будем обрабатывать для всех операций не
              только для "I04","I05"
   19.09.2014 c 23.09.2014 файл будет ежедневным и поэтому переменной Dat1_
              (дата начала месяца) будем присваивать отчетную дату
              (Dat1_ := Dat_)
   08.07.2014 вместо VIEW PROVODKI будем использовать PROVODKI_OTC в блоке
              где отчетная дата не совпадает с датой конца месяца
   27.06.2014 для операций "I04","I05" будет обрабатываться доп.ревизит "F1"
   30.04.2014 для проводок Дт 2620 Кт 3739 будем включать те операции которые
              внесены в KL_FF1
   04.02.2014 в операциях M37, MMV, CN3, CN4 кроме доп.реквизита D_1PB, D_REF
              будем обрабатывать доп.реквизиты DATT (дата перевода),
              REFT (референс перевода) т.к. в некотрых РУ для операций
              CN3, CN4 существуют эти доп.реквизиты
   13.12.2013 для доп.реквизита D_1PB изменяем формат даты как в #F1
              и для неверных значений D_1PB, D_REF формируется
              сообщение об ошибке
   02.12.2013 - добавлены изменения выполненные 15.11.2013 и не включенные
                в этот вариант процедуры
   15.11.2014 - в кл-р KL_FF1 добавлена строка NLSD='2909' NLSK='3739'
                OB22='18' и в файл будем включать такие типы проводок
                только с назначением платежа  "помощь родственнику"
   27.09.2013 - для операций CN3, CN4 (опрерации анулирования переводов)
                обрабатываем доп.параметры "D_1PB"-дата перевода и
                "D_REF"-референс перевода
                и затем удаляем референс проводки анулирования и
                референс проводки перевода если эти проводки выполнены
                в одном отчетном месяце
   31.07.2013 - для операций M37, MMV (опрерации анулирования переводов)
                обрабатываем доп.параметры "D_1PB"-дата перевода и
                "D_REF"-референс перевода
                и затем удаляем референс проводки анулирования и
                референс проводки перевода если эти проводки выполнены
                в одном отчетном месяце
   29.04.2013 - для проводок Дт 2909400129 Кт 2620 либо Кт 2924
                "код країни" выбираем из доп.параметра KOD_G
                (замечание/предложение банка Петрокоммерц)
   17.04.2013 - будут включаться проводки Дт 2924 Кт 1919 и назначение
                ('%переказ%','%перевод%','%transfer%')
   03.01.2013 - для декабря месяца первый рабочий день за отчетным выбираем
                не 01.01.201Х (хотя он как рабочий) т.к. проводки
                по валюте в этот день не выполняются
   24.12.2012 - для проводок Дт 2909 Кт 2900 - "обовязковий продаж" будем
                формировать код 42 вместо кода 41  (замечание Сбербанка)
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_       VARCHAR2 (2) := 'F1';
   sql_z       VARCHAR2 (200);
   typ_        NUMBER;
   flag_       NUMBER;
   ko_         VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b_      VARCHAR2 (10);                                     -- код банку
   nam_b       VARCHAR2 (70);                                   -- назва банку
   kod_g_      VARCHAR2 (3);
   kod_g_pb1   VARCHAR2 (3);
   n_          NUMBER := 4;
   acc_        NUMBER;
   acc1_       NUMBER;
   acck_       NUMBER;
   kv_         NUMBER;
   kv1_        NUMBER;
   nls_        VARCHAR2 (15);
   nls1_       VARCHAR2 (15);
   nlsk_       VARCHAR2 (15);
   nlsk1_      VARCHAR2 (15);
   nbuc1_      VARCHAR2 (20);
   nbuc_       VARCHAR2 (20);
   country_    VARCHAR2 (3);
   d060_       NUMBER;
   rnk_        NUMBER;
   okpo_       VARCHAR2 (14);
   nmk_        VARCHAR2 (70);
   k040_       VARCHAR2 (3);
   val_        VARCHAR2 (70);
   tg_         VARCHAR2 (70);
   fdat_       DATE;
   fdat_CN3    DATE;
   data_       DATE;
   dat1_       DATE;
   dat2_       DATE;
   kolvo_      NUMBER;
   sum0_       DECIMAL (24);
   sumk0_      DECIMAL (24);
   kodp_       VARCHAR2 (12);
   znap_       VARCHAR2 (70);
   tag_        VARCHAR2 (5);
   d#73_       VARCHAR2 (3);
   kodn_       VARCHAR2 (7);
   userid_     NUMBER;
   ref_        NUMBER;
   rez_        NUMBER;
   rez1_       NUMBER;
   mfo_        NUMBER;
   mfou_       NUMBER;
   tt_         VARCHAR2 (3);

   ttd_        VARCHAR2 (3);
   nlsdd_      VARCHAR2 (20);
   formOk_     BOOLEAN;
   accdd_      NUMBER;
   nazn_       VARCHAR2 (160);
   comm_       VARCHAR2 (200);
   value_      VARCHAR2 (200);
   atrt_       VARCHAR2 (50);
   pasp_       VARCHAR2 (20);
   paspn_      VARCHAR2 (20);
   pr_pasp_    NUMBER;
   flag_f_     NUMBER := 0;
   last_dayF   DATE;
   god_        VARCHAR2 (4);
   one_day_    DATE;
   tobo_       VARCHAR2 (30);
   ref_m37     NUMBER;
   dat_m37     DATE;

   -- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   CURSOR opl_dok
   IS
      SELECT t.ko,
             t.rnk,
             t.fdat,
             t.REF,
             t.tt,
             t.accd,
             t.nlsd,
             t.kv,
             t.acck,
             t.nlsk,
             t.s_nom,
             t.s_eqv,
             t.nazn,
             t.branch
        FROM OTCN_PROV_TEMP t
       WHERE t.nlsd IS NOT NULL AND t.nlsk IS NOT NULL;

   -------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (12);
   BEGIN
      l_kodp_ := p_kodp_;

      IF mfo_ = 353575
      THEN
         comm_ :=
            SUBSTR (
               TRIM (
                     'Резидентнiсть = '
                  || d#73_
                  || ' док. = '
                  || TRIM (pasp_)
                  || ' N док. = '
                  || TRIM (paspn_)
                  || ' ким виданий '
                  || TRIM (atrt_)),
               1,
               200);
      ELSE
         comm_ :=
            SUBSTR (
               TRIM (
                     'Резидентнiсть = '
                  || rez_
                  || ' док. = '
                  || TRIM (pasp_)
                  || ' N док. = '
                  || TRIM (paspn_)
                  || ' ким виданий '
                  || TRIM (atrt_)
                  || '   '
                  || TRIM (nazn_)),
               1,
               200);
      END IF;

      INSERT INTO rnbu_trace (nls,
                              kv,
                              odate,
                              kodp,
                              znap,
                              nbuc,
                              REF,
                              rnk,
                              comm,
                              tobo)
           VALUES (nls1_,
                   kv_,
                   fdat_,
                   l_kodp_,
                   p_znap_,
                   nbuc_,
                   ref_,
                   rnk_,
                   comm_,
                   tobo_);
   END;

-------------------------------------------------------------------
-----------------------------------------------------------------------------
BEGIN
   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';

   -------------------------------------------------------------------
   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_prov_temp';

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
   Dat1_ := TRUNC (Dat_, 'MM');

   SELECT MIN (fdat)
     INTO Dat1_
     FROM fdat
    WHERE fdat >= Dat1_;

   IF dat_ > TO_DATE ('22092014', 'ddmmyyyy')
   THEN
      Dat1_ := Dat_;
   END IF;

   god_ := TO_CHAR (Dat_, 'YYYY');

   IF TO_CHAR (dat_, 'MM') = '12'
   THEN
      god_ := TO_CHAR (TO_NUMBER (god_) + 1);
   END IF;

   last_dayF := LAST_DAY (Dat_);
   one_day_ :=
      TO_DATE ('01' || TO_CHAR (ADD_MONTHS (dat_, 1), 'MM') || god_,
               'ddmmyyyy');
   dat2_ := one_day_;

   -- это выходной?
   SELECT COUNT (*)
     INTO kolvo_
     FROM holiday
    WHERE holiday = dat2_ AND kv = 980;

   -- если да, то ищем не выходной
   IF kolvo_ <> 0
   THEN
      IF TO_CHAR (dat_, 'MM') = '12'
      THEN
         SELECT MIN (fdat)
           INTO one_day_
           FROM fdat
          WHERE fdat > dat2_;
      ELSE
         SELECT MIN (fdat)
           INTO one_day_
           FROM fdat
          WHERE fdat >= dat2_;
      END IF;
   END IF;

   -- временно для проверки в Запорожье (за 08.09.2010)
   IF Dat_ = TO_DATE ('08092010', 'ddmmyyyy')
   THEN
      Dat1_ := Dat_;
   END IF;


   -- параметры формирования файла
   p_proc_set (kodf_,
               sheme_,
               nbuc1_,
               typ_);
   nbuc_ := nbuc1_;

   -- отбор проводок, удовлетворяющих условию
   -- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   -- переказ коштiв нерезидентам (отримання коштiв вiд нерезидентiв)
   IF mfou_ NOT IN (300465, 380764) OR (mfou_ = 300465 AND mfo_ = mfou_)
   THEN
      INSERT INTO OTCN_PROV_TEMP (ko,
                                  rnk,
                                  fdat,
                                  REF,
                                  tt,
                                  accd,
                                  nlsd,
                                  kv,
                                  acck,
                                  nlsk,
                                  s_nom,
                                  s_eqv,
                                  nazn,
                                  branch)
         SELECT *
           FROM (                                   -- перерахування переказiв
                 SELECT 1 ko,
                        (CASE
                            WHEN o.nbsd IN ('2620', '2902', '2924')
                            THEN
                               o.rnkd
                            ELSE
                               o.rnkk
                         END)
                           rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (   mfou_ NOT IN (300465, 380764)
                             OR (mfou_ = 300465 AND mfo_ = mfou_))
                        AND (       o.nbsd IN ('2620', '2902', '2924')
                                AND o.nbsk IN ('1500', '1919', '2909')
                             OR     o.nbsd IN ('1001', '1002')
                                AND o.nbsk IN ('1919', '2909'))
                        AND (   LOWER (o.nazn) LIKE '%переказ%'
                             OR LOWER (o.nazn) LIKE '%перевод%'
                             OR LOWER (o.nazn) LIKE '%transfer%')
                 UNION
                 SELECT 1 ko,
                        (CASE
                            WHEN o.nbsd IN ('2620', '2902', '2924')
                            THEN
                               o.rnkd
                            ELSE
                               o.rnkk
                         END)
                           rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o, kl_ff1 k
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (   mfou_ NOT IN (300465, 380764)
                             OR (mfou_ = 300465 AND mfo_ = mfou_))
                        AND (       o.nbsd IN ('1001', '1002')
                                AND o.nbsk = '2909'
                             OR     o.nbsd IN ('2620', '2902', '2924')
                                AND o.nbsk IN ('1500', '1919', '2909'))
                        AND o.nlsd LIKE k.nlsd || '%'
                        AND o.nlsk LIKE k.nlsk || '%'
                        AND TRIM (k.ob22) IS NULL
                 UNION
                 SELECT 1 ko,
                        o.rnkk rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o, kl_ff1 k
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (mfou_ = 300465 AND mfo_ = mfou_)
                        AND o.nbsd IN ('1001', '1002')
                        AND o.nbsk = '2909'
                        AND o.nlsd LIKE k.nlsd || '%'
                        AND o.nlsk LIKE k.nlsk || '%'
                        AND NVL (k.ob22, o.ob22k) = o.ob22k
                 UNION
                 -- надходження переказiв (видача переказiв)
                 SELECT 2 ko,
                        o.rnkk rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (   mfou_ NOT IN (300465, 380764)
                             OR (mfou_ = 300465 AND mfo_ = mfou_))
                        AND (    o.nbsd IN
                                    ('1500',
                                     '1600',
                                     '2603',
                                     '3720',
                                     '3739',
                                     '3900',
                                     '2809',
                                     '2909',
                                     '1919')
                             AND o.nbsk IN ('2620', '2625', '2924'))
                        AND (   LOWER (o.nazn) LIKE '%переказ%'
                             OR LOWER (o.nazn) LIKE '%перевод%'
                             OR LOWER (o.nazn) LIKE '%transfer%')
                 UNION
                 SELECT 2 ko,
                        o.rnkd rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (   mfou_ NOT IN (300465, 380764)
                             OR (mfou_ = 300465 AND mfo_ = mfou_))
                        AND (    o.nbsd IN ('2809', '2909')
                             AND o.nbsk IN ('1001', '1002'))
                        AND (   LOWER (o.nazn) LIKE '%переказ%'
                             OR LOWER (o.nazn) LIKE '%перевод%'
                             OR LOWER (o.nazn) LIKE '%transfer%')
                        AND (   LOWER (o.nazn) NOT LIKE '%ком__с__%'
                             OR LOWER (o.nazn) NOT LIKE '%ком_с__%')
                 UNION
                 SELECT 2 ko,
                        o.rnkd rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o, kl_ff1 k
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (   mfou_ NOT IN (300465, 380764)
                             OR (mfou_ = 300465 AND mfo_ = mfou_))
                        AND o.nbsd IN ('2809', '2909')
                        AND o.nbsk IN ('1001', '1002')
                        AND o.nlsd LIKE k.nlsd || '%'
                        AND o.nlsk LIKE k.nlsk || '%'
                        AND TRIM (k.ob22) IS NULL
                 UNION
                 SELECT 2 ko,
                        o.rnkk rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o, kl_ff1 k
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (   mfou_ NOT IN (300465, 380764)
                             OR (mfou_ = 300465 AND mfo_ = mfou_))
                        AND o.nbsd IN
                               ('1500',
                                '1600',
                                '2603',
                                '3720',
                                '3739',
                                '3900',
                                '2809',
                                '2909',
                                '1919')
                        AND o.nbsk IN ('2620', '2625', '2924')
                        AND o.nlsd LIKE k.nlsd || '%'
                        AND o.nlsk LIKE k.nlsk || '%'
                        AND TRIM (k.ob22) IS NULL
                 UNION
                 SELECT 2 ko,
                        o.rnkk rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o, kl_ff1 k
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        AND (mfou_ = 300465 AND mfo_ = mfou_)
                        -- включаем проводки вида Дт 2809, 2909 Кт 1001,1002 по значению OB22 для СБ
                        AND o.nbsd IN ('2809', '2909')
                        AND o.nbsk IN
                               ('1001',
                                '1002',
                                '2620',
                                '2625',
                                '2902',
                                '2909',
                                '2924')
                        AND o.nlsd LIKE k.nlsd || '%'
                        AND o.nlsk LIKE k.nlsk || '%'
                        AND NVL (k.ob22, o.ob22d) = o.ob22d);
   ELSIF (mfo_ <> mfou_ AND mfou_ IN (300465)) OR (mfou_ = 380764)
   THEN
      INSERT INTO OTCN_PROV_TEMP (ko,
                                  rnk,
                                  fdat,
                                  REF,
                                  tt,
                                  accd,
                                  nlsd,
                                  kv,
                                  acck,
                                  nlsk,
                                  s_nom,
                                  s_eqv,
                                  nazn,
                                  branch)
         SELECT *
           FROM ( -- ТIЛЬКИ ДЛЯ ВС?Х ОБЛУПРАВЛIННЬ ОЩАДБАНКУ    перерахування переказiв
                 SELECT 1 ko,
                        o.rnkd rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o, kl_ff1 k
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        -- включаем проводки вида Дт 1001,1002 Кт 2909 по параметру OB22 для СБ
                        AND (   (mfo_ <> mfou_ AND mfou_ IN (300465))
                             OR (mfou_ = 380764))
                        AND o.nlsd LIKE k.nlsd || '%'
                        AND o.nlsk LIKE k.nlsk || '%'
                        AND k.ob22 IS NOT NULL
                        AND k.ob22 = o.ob22k
                        AND NVL (k.tt, o.tt) = o.tt
                 UNION ALL
                 -- надходження переказiв (видача переказiв)
                 SELECT 2 ko,
                        o.rnkk rnk,
                        o.fdat,
                        o.REF,
                        o.tt,
                        o.accd,
                        o.nlsd,
                        o.kv,
                        o.acck,
                        o.nlsk,
                        o.s * 100 s_nom,
                        gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                        o.nazn,
                        o.branch
                   FROM provodki_otc o, kl_ff1 k
                  WHERE     o.fdat BETWEEN Dat1_ AND Dat_
                        AND o.kv != 980
                        -- включаем проводки вида Дт 2809, 2909 Кт 1001,1002 по значению OB22 для СБ
                        AND (   (mfo_ <> mfou_ AND mfou_ IN (300465))
                             OR (mfou_ = 380764))
                        AND o.nlsd LIKE k.nlsd || '%'
                        AND o.nlsk LIKE k.nlsk || '%'
                        AND k.ob22 IS NOT NULL
                        AND k.ob22 = o.ob22d
                        AND NVL (k.tt, o.tt) = o.tt);
   END IF;

   -- если отчетный день не последний день месяца то выпоняем включение в файл проводок
   -- введенных в последние календарные дни и проведенные в балансе 1 рабочего дня след. месяца
   IF Dat_ < TO_DATE ('23092014', 'ddmmyyyy') AND mfou_ = 300465
   THEN
      IF last_dayF != Dat_
      THEN
         IF    mfou_ NOT IN (300465, 380764)
            OR (mfou_ = 300465 AND mfo_ = mfou_)
         THEN
            INSERT INTO OTCN_PROV_TEMP (ko,
                                        rnk,
                                        fdat,
                                        REF,
                                        tt,
                                        accd,
                                        nlsd,
                                        kv,
                                        acck,
                                        nlsk,
                                        s_nom,
                                        s_eqv,
                                        nazn,
                                        branch)
               SELECT *
                 FROM (SELECT 1 ko,
                              o.rnkk,
                              o.fdat,
                              o.REF,
                              o.tt,
                              o.accd,
                              o.nlsd,
                              o.kv,
                              o.acck,
                              o.nlsk,
                              o.s * 100 s_nom,
                              gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                              o.nazn,
                              o.branch
                         FROM provodki_otc o, kl_ff1 k
                        WHERE     o.fdat = one_day_
                              AND o.kv != 980
                              AND (   mfou_ <> 300465
                                   OR (mfou_ = 300465 AND mfo_ = mfou_))
                              AND SUBSTR (o.nlsd, 1, 4) IN ('1001', '1002')
                              AND SUBSTR (o.nlsk, 1, 4) IN ('2909')
                              AND o.nlsd LIKE k.nlsd || '%'
                              AND o.nlsk LIKE k.nlsk || '%'
                              AND TO_CHAR (o.pdat, 'MM') =
                                     TO_CHAR (dat_, 'MM')
                              AND o.pdat < one_day_
                       UNION
                       SELECT 1 ko,
                              o.rnkk,
                              o.fdat,
                              o.REF,
                              o.tt,
                              o.accd,
                              o.nlsd,
                              o.kv,
                              o.acck,
                              o.nlsk,
                              o.s * 100 s_nom,
                              gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                              o.nazn,
                              o.branch
                         FROM provodki_otc o, kl_ff1 k
                        WHERE     o.fdat = one_day_
                              AND o.kv != 980
                              AND (   mfou_ <> 300465
                                   OR (mfou_ = 300465 AND mfo_ = mfou_))
                              AND SUBSTR (o.nlsd, 1, 4) IN
                                     ('2620', '2902', '2924')
                              AND SUBSTR (o.nlsk, 1, 4) IN
                                     ('1500', '1919', '2909')
                              AND o.nlsd LIKE k.nlsd || '%'
                              AND o.nlsk LIKE k.nlsk || '%'
                              AND TO_CHAR (o.pdat, 'MM') =
                                     TO_CHAR (dat_, 'MM')
                              AND o.pdat < one_day_
                       UNION
                       SELECT 2 ko,
                              o.rnkd,
                              o.fdat,
                              o.REF,
                              o.tt,
                              o.accd,
                              o.nlsd,
                              o.kv,
                              o.acck,
                              o.nlsk,
                              o.s * 100 s_nom,
                              gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                              o.nazn,
                              o.branch
                         FROM provodki_otc o,
                              cust_acc ca,
                              kl_ff1 k,
                              oper p
                        WHERE     o.fdat = one_day_
                              AND o.kv != 980
                              AND (   mfou_ <> 300465
                                   OR (mfou_ = 300465 AND mfo_ = mfou_))
                              AND SUBSTR (o.nlsd, 1, 4) IN ('2809', '2909')
                              AND SUBSTR (o.nlsk, 1, 4) IN ('1001', '1002')
                              AND o.nlsd LIKE k.nlsd || '%'
                              AND o.nlsk LIKE k.nlsk || '%'
                              AND TO_CHAR (o.pdat, 'MM') =
                                     TO_CHAR (dat_, 'MM')
                              AND o.pdat < one_day_
                       UNION
                       SELECT 2 ko,
                              o.rnkd,
                              o.fdat,
                              o.REF,
                              o.tt,
                              o.accd,
                              o.nlsd,
                              o.kv,
                              o.acck,
                              o.nlsk,
                              o.s * 100 s_nom,
                              gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                              o.nazn,
                              o.branch
                         FROM provodki_otc o, kl_ff1 k
                        WHERE     o.fdat = one_day_
                              AND o.kv != 980
                              AND (   mfou_ <> 300465
                                   OR (mfou_ = 300465 AND mfo_ = mfou_))
                              AND SUBSTR (o.nlsd, 1, 4) IN
                                     ('1500',
                                      '1600',
                                      '2603',
                                      '3720',
                                      '3739',
                                      '3900',
                                      '2809',
                                      '2909')
                              AND o.nlsd LIKE k.nlsd || '%'
                              AND o.nlsk LIKE k.nlsk || '%'
                              AND TO_CHAR (o.pdat, 'MM') =
                                     TO_CHAR (dat_, 'MM')
                              AND o.pdat < one_day_);
         ELSIF mfo_ <> mfou_ AND mfou_ IN (300465)
         THEN
            INSERT INTO OTCN_PROV_TEMP (ko,
                                        rnk,
                                        fdat,
                                        REF,
                                        tt,
                                        accd,
                                        nlsd,
                                        kv,
                                        acck,
                                        nlsk,
                                        s_nom,
                                        s_eqv,
                                        nazn,
                                        branch)
               SELECT *
                 FROM ( -- ТIЛЬКИ ДЛЯ ВС?Х ОБЛУПРАВЛIННЬ ОЩАДБАНКУ    перерахування переказiв
                       SELECT 1 ko,
                              o.rnkk,
                              o.fdat,
                              o.REF,
                              o.tt,
                              o.accd,
                              o.nlsd,
                              o.kv,
                              o.acck,
                              o.nlsk,
                              o.s * 100 s_nom,
                              gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                              o.nazn,
                              o.branch
                         FROM provodki_otc o, kl_ff1 k, specparam_int s
                        WHERE     o.fdat = one_day_
                              AND o.kv != 980
                              AND mfo_ <> mfou_
                              AND mfou_ IN (300465)
                              AND o.nlsd LIKE k.nlsd || '%'
                              AND o.nlsk LIKE k.nlsk || '%'
                              AND o.acck = s.acc(+)
                              AND NVL (k.ob22, s.ob22) = s.ob22
                              AND NVL (k.tt, o.tt) = o.tt
                              AND TO_CHAR (o.pdat, 'MM') =
                                     TO_CHAR (dat_, 'MM')
                              AND o.pdat < one_day_
                       UNION
                       -- надходження переказiв (видача переказiв)
                       SELECT 2 ko,
                              o.rnkd,
                              o.fdat,
                              o.REF,
                              o.tt,
                              o.accd,
                              o.nlsd,
                              o.kv,
                              o.acck,
                              o.nlsk,
                              o.s * 100 s_nom,
                              gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv,
                              o.nazn,
                              o.branch
                         FROM provodki_otc o, kl_ff1 k, specparam_int s
                        WHERE     o.fdat = one_day_
                              AND o.kv != 980
                              AND mfo_ <> mfou_
                              AND mfou_ IN (300465)
                              AND o.nlsd LIKE k.nlsd || '%'
                              AND o.nlsk LIKE k.nlsk || '%'
                              AND o.accd = s.acc(+)
                              AND NVL (k.ob22, s.ob22) = s.ob22
                              AND NVL (k.tt, o.tt) = o.tt
                              AND TO_CHAR (o.pdat, 'MM') =
                                     TO_CHAR (dat_, 'MM')
                              AND o.pdat < one_day_);
         END IF;
      END IF;
   END IF;

   -- удаление типов проводок по кл-ру KL_FF1
   DELETE FROM OTCN_PROV_TEMP
         WHERE REF IN
                  (SELECT o.REF
                     FROM otcn_prov_temp o, kl_ff1 f
                    WHERE     SUBSTR (TRIM (o.nlsd),
                                      1,
                                      LENGTH (TRIM (f.nlsd))) = TRIM (f.nlsd)
                          AND SUBSTR (TRIM (o.nlsk),
                                      1,
                                      LENGTH (TRIM (f.nlsk))) = TRIM (f.nlsk)
                          AND NVL (TRIM (f.tt), o.tt) = o.tt
                          AND f.pr_del = 0);

   -- удаление типов проводок по кл-ру KL_FF1
   --DELETE FROM OTCN_PROV_TEMP
   --WHERE ref in (select o.ref
   --              from otcn_prov_temp o, kl_ff1 f
   --              where substr(trim(o.nlsd),1,length(trim(f.nlsd)))=trim(f.nlsd)
   --                and substr(trim(o.nlsk),1,length(trim(f.nlsk)))=trim(f.nlsk)
   --                and f.tt is not null
   --                and f.tt <> o.tt
   --                and f.pr_del=1);

   -- удаление док-тов принятых в предыдущем месяце и проведенных в первых числах отчетного месяца
   IF Dat_ < TO_DATE ('23092014', 'ddmmyyyy') AND mfou_ = 300465
   THEN
      DELETE FROM otcn_prov_temp
            WHERE REF IN
                     (SELECT o.REF
                        FROM otcn_prov_temp o, oper p
                       WHERE     o.fdat >= dat1_           --one_day_  --dat1_
                             AND o.REF = p.REF
                             AND p.pdat < dat1_
                             AND TO_CHAR (p.pdat, 'MM') !=
                                    TO_CHAR (dat1_, 'MM')); --(p.pdat < dat1_ or p.datd < dat1_) );
   END IF;

   -- удаление проводок для проводок Дт 2909 Кт 2909 и OB22 != '24'
   FOR k
      IN (SELECT o.REF REF,
                 TRIM (o.nlsd) NLSD,
                 TRIM (o.nlsk) NLSK,
                 NVL (TRIM (s.ob22), '00') OB22
            FROM otcn_prov_temp o, specparam_int s
           WHERE     o.nlsd LIKE '2909%'
                 AND o.nlsk LIKE '2909%'
                 AND o.acck = s.acc(+))
   LOOP
      IF k.ob22 != '24'
      THEN
         DELETE FROM OTCN_PROV_TEMP
               WHERE REF = k.REF;
      END IF;
   END LOOP;

   -- удаление сторнированных проводок
   DELETE FROM otcn_prov_temp
         WHERE REF IN (SELECT o.REF
                         FROM otcn_prov_temp o, oper p
                        WHERE o.REF = p.REF AND p.sos <> 5);

   -- удаление проводок Дт 2909 Кт 3739 и назначение платежа не Помощь родственнику
   --   DELETE FROM otcn_prov_temp
   --  WHERE nlsd like '2909%'
   --   and nlsk like '3739%'
   --   and ( lower (nazn) not like '%помощь родственнику%' and
   --        lower (nazn) not like '%за л_кування%'
   --     );

   -- удаление проводок Дт 2909 Кт 2900 и назначение платежа перераховано для продажу
   DELETE FROM otcn_prov_temp
         WHERE     nlsd LIKE '2909%'
               AND nlsk LIKE '2900%'
               AND LOWER (nazn) LIKE
                      ('%перераховано%для продажу%');

   -- удаление проводок Дт 2620 Кт 2909 и назначение платежа з рах .... на рах ....
   DELETE FROM otcn_prov_temp
         WHERE     nlsd LIKE '2620%'
               AND nlsk LIKE '2909%'
               AND tt LIKE 'DP%'
               AND LOWER (nazn) LIKE ('%з рах%на рах%');

   IF mfou_ = 300465
   THEN
      -- анулювання відкликання переказів в IВ
      FOR k
         IN (SELECT o.REF REF,
                    o.nlsd,
                    o.nlsk,
                    o.fdat
               FROM otcn_prov_temp o
              WHERE     (o.nlsd LIKE '2809%' OR o.nlsd LIKE '2909%')
                    AND o.nlsk LIKE '100%'
                    AND o.tt IN ('M37', 'MMV', 'CN3', 'CN4'))
      LOOP
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

            -- фактическая дата оплаты анулированной проводки
            BEGIN
               SELECT fdat
                 INTO fdat_CN3
                 FROM otcn_prov_temp
                WHERE REF = ref_m37;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  fdat_CN3 := dat_m37;
            END;

            -- 10/10/2014 т.к. файл ежедневный то удаляем первоначальные и
            -- анулированные переводы если они выполнены в одном банковском дне
            --if to_char(k.fdat,'MM') = to_char(dat_m37,'MM') then
            IF (k.fdat = dat_m37) OR (k.fdat = fdat_CN3)
            THEN
               DELETE FROM otcn_prov_temp
                     WHERE REF IN (k.REF, ref_m37);
            END IF;
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
      END LOOP;
   END IF;

   -- переказ коштiв фiз. особами за межi України (отримання коштiв фiз. особами)
   OPEN opl_dok;

   LOOP
      FETCH opl_dok
         INTO d060_,
              rnk_,
              fdat_,
              ref_,
              tt_,
              acc_,
              nls_,
              kv_,
              acck_,
              nlsk_,
              sum0_,
              sumk0_,
              nazn_,
              tobo_;

      EXIT WHEN opl_dok%NOTFOUND;

      comm_ := '';
      pasp_ := '';
      paspn_ := '';
      pr_pasp_ := 0;
      atrt_ := '';
      d#73_ := NULL;

      BEGIN
         SELECT 2 - MOD (codcagent, 2)
           INTO rez_
           FROM customer
          WHERE rnk = rnk_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            rez_ := 1;
      END;

      BEGIN
         SELECT SUBSTR (TRIM (VALUE), 1, 50)
           INTO atrt_
           FROM operw
          WHERE REF = ref_ AND TRIM (tag) = 'ATRT';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            atrt_ := '';
      END;

      BEGIN
         SELECT 1
           INTO rez1_
           FROM operw
          WHERE     REF = ref_
                AND TRIM (tag) = 'ATRT'
                AND (   (    (   UPPER (TRIM (VALUE)) LIKE '%МВД%'
                              OR UPPER (TRIM (VALUE)) LIKE '%МВС%')
                         AND UPPER (TRIM (VALUE)) NOT LIKE '%РОС%')
                     OR UPPER (TRIM (VALUE)) LIKE '%УКРА%');

         pr_pasp_ := 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            BEGIN
               SELECT 1
                 INTO rez1_
                 FROM operw
                WHERE     REF = ref_
                      AND TRIM (tag) = 'NATIO'
                      AND (   UPPER (TRIM (VALUE)) LIKE '%УКР%'
                           OR UPPER (TRIM (VALUE)) LIKE '%804%');

               pr_pasp_ := 1;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BEGIN
                     SELECT 1
                       INTO rez1_
                       FROM operw
                      WHERE     REF = ref_
                            AND TRIM (tag) LIKE '%PASP%'
                            AND SUBSTR (UPPER (TRIM (VALUE)), 1, 1) IN
                                   ('А',
                                    'В',
                                    'С',
                                    'Е',
                                    '?',
                                    'I',
                                    'К',
                                    'М',
                                    'О',
                                    'Р',
                                    'Т',
                                    'Х')
                            AND ROWNUM = 1;

                     pr_pasp_ := 1;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           SELECT 2
                             INTO rez1_
                             FROM operw
                            WHERE     REF = ref_
                                  AND TRIM (tag) = 'ATRT'
                                  AND (   (    (   UPPER (TRIM (VALUE)) LIKE
                                                      '%МВД%'
                                                OR UPPER (TRIM (VALUE)) LIKE
                                                      '%МВС%')
                                           AND UPPER (TRIM (VALUE)) LIKE
                                                  '%РОС%')
                                       OR (    UPPER (TRIM (VALUE)) NOT LIKE
                                                  '%МВД%'
                                           AND UPPER (TRIM (VALUE)) NOT LIKE
                                                  '%МВС%'));
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              rez1_ := NULL;
                        END;
                  END;
            END;
      END;

      IF pr_pasp_ = 0
      THEN
         BEGIN
            SELECT 2
              INTO rez1_
              FROM operw
             WHERE     REF = ref_
                   AND TRIM (tag) = 'NATIO'
                   AND TRIM (VALUE) IS NOT NULL
                   AND UPPER (TRIM (VALUE)) NOT LIKE '%УКР%'
                   AND UPPER (TRIM (VALUE)) NOT LIKE '%804%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               NULL;
         END;
      END IF;

      IF rez1_ IS NOT NULL
      THEN
         rez_ := rez1_;
      END IF;

      d#73_ := NULL;
      kod_g_ := NULL;
      kod_g_pb1 := NULL;

      IF sum0_ <> 0
      THEN
         FOR k IN (SELECT *
                     FROM operw
                    WHERE REF = ref_)
         LOOP
            IF k.tag = 'PASP'
            THEN
               pasp_ := SUBSTR (TRIM (k.VALUE), 1, 20);
            END IF;

            IF k.tag = 'PASPN'
            THEN
               paspn_ := SUBSTR (TRIM (k.VALUE), 1, 20);
            END IF;

            IF mfo_ IN (300205, 353575, 300120) AND k.tag = 'KOD_G'
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 1, 3);
            END IF;

            -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
            IF     k.tag LIKE 'n%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 2, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND k.tag LIKE 'n%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) NOT IN
                      ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 1, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND k.tag LIKE 'D6#7%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 2, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND k.tag LIKE 'D6#7%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) NOT IN
                      ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 1, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND k.tag LIKE 'D6#E2%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 2, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND k.tag LIKE 'D6#E2%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) NOT IN
                      ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 1, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND k.tag LIKE 'D1#E9%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) IN ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 2, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND k.tag LIKE 'D1#E9%'
               AND SUBSTR (TRIM (k.VALUE), 1, 1) NOT IN
                      ('O', 'P', 'О', 'П')
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 1, 3);
            END IF;

            IF kod_g_ IS NULL AND k.tag LIKE 'F1%'
            THEN
               kod_g_ := SUBSTR (TRIM (k.VALUE), 8, 3);
            END IF;

            IF kod_g_ IS NULL AND mfo_ NOT IN (300120) AND --in (300205, 353575, 325815, 333432, 306566, 315568, 315568) and
                                                          k.tag = 'KOD_G'
            THEN
               kod_g_pb1 := SUBSTR (TRIM (k.VALUE), 1, 3);
            END IF;

            IF     kod_g_ IS NULL
               AND mfo_ = 300120
               AND (   (    nls_ LIKE '1919%'
                        AND (nlsk_ LIKE '2620%' OR nlsk_ LIKE '2924%'))
                    OR (nls_ LIKE '2924%' AND nlsk_ LIKE '1919%')
                    OR (    nls_ LIKE '2909400129%'
                        AND (nlsk_ LIKE '2620%' OR nlsk_ LIKE '2924%'))
                    OR (nls_ LIKE '3720%' AND nlsk_ LIKE '2620%'))
               AND k.tag = 'KOD_G'
            THEN
               kod_g_pb1 := SUBSTR (TRIM (k.VALUE), 1, 3);
            END IF;
         END LOOP;

         IF mfo_ = 380764 AND kod_g_pb1 IS NOT NULL AND kod_g_pb1 = '804'
         THEN
            kod_g_pb1 := '000';
         END IF;

         IF kod_g_ IS NULL AND kod_g_pb1 IS NOT NULL
         THEN
            kod_g_ := kod_g_pb1;
         END IF;

         IF kod_g_ IS NULL
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
                            AND INSTR (UPPER (TRIM (VALUE)), 'UKRAINE') > 0;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        kod_g_ := NULL;
                  END;
            END;
         END IF;

         IF kod_g_ IS NULL
         THEN
            country_ := '000';
         ELSE
            country_ := kod_g_;
         END IF;

         IF mfo_ = 300120
         THEN
            BEGIN
               SELECT SUBSTR (TRIM (VALUE), 1, 3)
                 INTO D#73_
                 FROM operw
                WHERE     REF = ref_
                      AND (tag LIKE 'D#73%' OR tag LIKE '73' || tt_ || '%');
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  d#73_ := NULL;
            END;

            BEGIN
               SELECT SUBSTR (TRIM (VALUE), 1, 7)
                 INTO kodn_
                 FROM operw
                WHERE REF = ref_ AND tag = 'KOD_N';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kodn_ := NULL;
            END;
         END IF;

         IF mfou_ IN (300205, 380623, 300465)
         THEN                                         -- and pr_pasp_ = 0 then
            BEGIN
               SELECT SUBSTR (TRIM (VALUE), 1, 1),
                      SUBSTR (TRIM (VALUE), 1, 10)
                 INTO D#73_, value_
                 FROM operw
                WHERE REF = ref_ AND tag = 'REZID';

               IF D#73_ NOT IN ('1', '2')
               THEN
                  IF LOWER (value_) LIKE '%нерез%'
                  THEN
                     D#73_ := '2';
                  ELSE
                     D#73_ := '1';
                  END IF;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  BEGIN
                     SELECT '1'
                       INTO D#73_
                       FROM operw
                      WHERE REF = ref_ AND tag LIKE '%OKPO%' AND ROWNUM = 1;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        d#73_ := NULL;
                  END;
            END;
         END IF;

         IF mfo_ = 353575
         THEN
            BEGIN
               SELECT SUBSTR (TRIM (VALUE), 1, 3)
                 INTO D#73_
                 FROM operw
                WHERE REF = ref_ AND tag = 'REZ_D';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  d#73_ := NULL;
            END;
         END IF;

         IF d060_ = 1
         THEN
            IF     mfo_ = 300120
               AND d#73_ = '232'
               AND kodn_ IN ('8427003', '8428003')
            THEN
               rez_ := 2;
            END IF;

            IF     mfo_ = 300120
               AND d#73_ = '232'
               AND kodn_ IN ('8428001', '8446003')
            THEN
               rez_ := 1;
            END IF;

            IF mfou_ IN (300205, 380623, 300465) AND d#73_ IS NOT NULL
            THEN
               rez_ := d#73_;
            END IF;

            IF mfo_ = 353575 AND d#73_ = '804'
            THEN
               rez_ := 1;
            END IF;

            IF mfo_ = 353575 AND d#73_ IS NOT NULL AND d#73_ <> '804'
            THEN
               rez_ := 2;
            END IF;

            IF    nls_ LIKE '100%'
               OR nls_ LIKE '262%'
               OR nls_ LIKE '2900%'
               OR nls_ LIKE '2902%'
               OR nls_ LIKE '2924%'
            THEN
               acc1_ := acc_;
               nls1_ := nls_;
            ELSE
               acc1_ := acck_;
               nls1_ := nlsk_;
            END IF;

            IF typ_ > 0
            THEN
               nbuc_ := NVL (f_codobl_tobo (acc1_, typ_), nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;

            IF nls_ NOT LIKE '26%' AND nls_ NOT LIKE '29%'
            THEN                  --nls_ like '100%' OR nls_ like '2902%' then
               IF dat_ <= TO_DATE ('30062012', 'ddmmyyyy')
               THEN
                  kodp_ :=
                        '1'
                     || '10'
                     || TO_CHAR (rez_)
                     || LPAD (TO_CHAR (kv_), 3, '0');
               ELSE
                  kodp_ :=
                        '1'
                     || '11'
                     || TO_CHAR (rez_)
                     || LPAD (TO_CHAR (kv_), 3, '0')
                     || country_;
               END IF;

               IF kod_g_ IS NULL OR (kod_g_ IS NOT NULL AND kod_g_ != '804')
               THEN
                  -- запис показника суми
                  p_ins (kodp_, TO_CHAR (sum0_));

                  -- запис показника кiлькостi
                  IF dat_ <= TO_DATE ('30062012', 'ddmmyyyy')
                  THEN
                     kodp_ := '3' || SUBSTR (kodp_, 2);
                     p_ins (kodp_, '1');
                  END IF;
               END IF;
            ELSE
               IF dat_ <= TO_DATE ('30062012', 'ddmmyyyy')
               THEN
                  IF sumk0_ <= 1500000
                  THEN
                     IF    kod_g_ IS NULL
                        OR (kod_g_ IS NOT NULL AND kod_g_ != '804')
                     THEN
                        kodp_ :=
                              '1'
                           || '21'
                           || TO_CHAR (rez_)
                           || LPAD (TO_CHAR (kv_), 3, '0');
                        -- запис показника суми
                        p_ins (kodp_, TO_CHAR (sum0_));
                        -- запис показника кiлькостi
                        kodp_ := '3' || SUBSTR (kodp_, 2);
                        p_ins (kodp_, '1');
                     END IF;
                  ELSE
                     IF    kod_g_ IS NULL
                        OR (kod_g_ IS NOT NULL AND kod_g_ != '804')
                     THEN
                        kodp_ :=
                              '1'
                           || '22'
                           || TO_CHAR (rez_)
                           || LPAD (TO_CHAR (kv_), 3, '0');
                        -- запис показника суми
                        p_ins (kodp_, TO_CHAR (sum0_));
                        -- запис показника кiлькостi
                        kodp_ := '3' || SUBSTR (kodp_, 2);
                        p_ins (kodp_, '1');
                     END IF;
                  END IF;
               ELSE
                  kodp_ :=
                        '1'
                     || '12'
                     || TO_CHAR (rez_)
                     || LPAD (TO_CHAR (kv_), 3, '0')
                     || country_;
                  -- запис показника суми
                  p_ins (kodp_, TO_CHAR (sum0_));
               END IF;
            END IF;
         ELSE
            IF     mfo_ = 300120
               AND d#73_ = '342'
               AND kodn_ IN ('8427004', '8428004')
            THEN
               rez_ := 2;
            END IF;

            IF     mfo_ = 300120
               AND d#73_ = '342'
               AND kodn_ IN ('8428002', '8446004')
            THEN
               rez_ := 1;
            END IF;

            IF mfou_ IN (300205, 380623, 300465) AND d#73_ IS NOT NULL
            THEN
               rez_ := d#73_;
            END IF;

            IF mfo_ = 353575 AND d#73_ = '804'
            THEN
               rez_ := 1;
            END IF;

            IF mfo_ = 353575 AND d#73_ IS NOT NULL AND d#73_ <> '804'
            THEN
               rez_ := 2;
            END IF;

            IF    nlsk_ LIKE '100%'
               OR nlsk_ LIKE '262%'
               OR nlsk_ LIKE '2902%'
               OR nlsk_ LIKE '2924%'
            THEN
               acc1_ := acck_;
               nls1_ := nlsk_;
            ELSE
               acc1_ := acc_;
               nls1_ := nls_;
            END IF;

            IF typ_ > 0
            THEN
               nbuc_ := NVL (f_codobl_tobo (acc1_, typ_), nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;

            IF kod_g_ IS NULL OR (kod_g_ IS NOT NULL AND kod_g_ != '804')
            THEN
               IF dat_ <= TO_DATE ('30062012', 'ddmmyyyy')
               THEN
                  kodp_ :=
                        '1'
                     || '40'
                     || TO_CHAR (rez_)
                     || LPAD (TO_CHAR (kv_), 3, '0');
                  -- запис показника суми
                  p_ins (kodp_, TO_CHAR (sum0_));
                  -- запис показника кiлькостi
                  kodp_ := '3' || SUBSTR (kodp_, 2);
                  p_ins (kodp_, '1');
               END IF;

               IF dat_ > TO_DATE ('30062012', 'ddmmyyyy')
               THEN
                  IF    nlsk_ LIKE '262%'
                     OR nlsk_ LIKE '2900%'
                     OR nlsk_ LIKE '2924%'
                  THEN
                     kodp_ :=
                           '1'
                        || '42'
                        || TO_CHAR (rez_)
                        || LPAD (TO_CHAR (kv_), 3, '0')
                        || country_;
                     -- запис показника суми
                     p_ins (kodp_, TO_CHAR (sum0_));
                  ELSE
                     IF nls_ LIKE '2909%' AND nlsk_ LIKE '3739%'
                     THEN
                        kodp_ :=
                              '1'
                           || '12'
                           || TO_CHAR (rez_)
                           || LPAD (TO_CHAR (kv_), 3, '0')
                           || country_;
                        -- запис показника суми
                        p_ins (kodp_, TO_CHAR (sum0_));
                     ELSE
                        kodp_ :=
                              '1'
                           || '41'
                           || TO_CHAR (rez_)
                           || LPAD (TO_CHAR (kv_), 3, '0')
                           || country_;
                        -- запис показника суми
                        p_ins (kodp_, TO_CHAR (sum0_));
                     END IF;
                  END IF;
               END IF;
            END IF;
         END IF;
      END IF;
   END LOOP;

   CLOSE opl_dok;

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
               SUM (TO_NUMBER (znap)),
               nbuc
          FROM rnbu_trace
         WHERE userid = userid_
      GROUP BY KODP, NBUC;
----------------------------------------
END p_ff1_nn;
/
show err;

PROMPT *** Create  grants  P_FF1_NN ***
grant EXECUTE                                                                on P_FF1_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FF1_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
