

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FF1_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FF1_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_FF1_NN(
                        dat_     DATE,
                        sheme_   VARCHAR2 DEFAULT 'G',
                        type_    varchar2 default ' ') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #F1 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 10/07/2017 (02/06/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
           type_  - ' '/'X' -обычный файл / подготовка xml
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
17.05.2018 для формирования xml -определение NBUC; не сохранение в TMP_NBU
02.03.2017 добавлена обработка TAG='52A' для определения кода страны 
           бенефициара
29.04.2015 не удаляем проводки Дт 2909 Кт 3739 и в кл-р KL_FF1 добавлены
           3 кода операций "CFB", "CFO", "CFC" для включения проводок
           Дт 2620,2625,2909   Кт 3739
12.03.2015 код 12 формировался для кода страны 804. Исправлено.
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
   kodf_      VARCHAR2 (2)   := 'F1';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   flag_      NUMBER;
   ko_        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1       VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b_     VARCHAR2 (10);                          -- код банку
   nam_b      VARCHAR2 (70);                        -- назва банку
   kod_g_     Varchar2 (3);
   kod_g_pb1  Varchar2 (3);
   n_         NUMBER         := 4;
   acc_       NUMBER;
   acc1_      NUMBER;
   acck_      NUMBER;
   kv_        NUMBER;
   kv1_       NUMBER;
   nls_       VARCHAR2 (15);
   nls1_      VARCHAR2 (15);
   nlsk_      VARCHAR2 (15);
   nlsk1_     VARCHAR2 (15);
   nbuc1_     VARCHAR2 (20);
   nbuc_      VARCHAR2 (20);
   nbuc_x     VARCHAR2 (20);
   country_   VARCHAR2 (3);
   d060_      NUMBER;
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   nmk_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   val_       VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   fdat_      DATE;
   fdat_CN3   DATE;
   data_      DATE;
   dat1_      DATE;
   dat2_      DATE;
   kolvo_     NUMBER;
   sum0_      DECIMAL (24);
   sumk0_     DECIMAL (24);
   kodp_      VARCHAR2 (12);
   znap_      VARCHAR2 (70);
   tag_       VARCHAR2 (5);
   d#73_      Varchar2(3);
   kodn_      Varchar2(7);
   userid_    NUMBER;
   ref_       NUMBER;
   rez_       number;
   rez1_      number;
   mfo_       number;
   mfou_      number;
   tt_        varchar2(3);

   ttd_       varchar2(3);
   nlsdd_     varchar2(20);
   formOk_    boolean;
   accdd_     number;
   nazn_      varchar2(160);
   comm_      varchar2(200);
   value_     varchar2(200);
   atrt_      varchar2(50);
   pasp_      varchar2(20);
   paspn_     varchar2(20);
   pr_pasp_   number;
   flag_f_    number := 0;
   last_dayF  date;
   god_       varchar2(4);
   one_day_   date;
   tobo_      varchar2(30);
   ref_m37    number;
   dat_m37    date;
   swift_k_   VARCHAR2 (12);
   ob22_      VARCHAR2 (2);

-- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   CURSOR opl_dok
   IS
      SELECT  t.ko, t.rnk, t.fdat, t.REF, t.tt, t.accd, t.nlsd, t.kv, t.acck, t.nlsk,
              t.s_nom, t.s_eqv, t.nazn, t.branch
      FROM OTCN_PROV_TEMP t
      WHERE t.nlsd is not null
        and t.nlsk is not null;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (12);
   BEGIN
      l_kodp_ := p_kodp_ ;

      comm_ := substr(trim('Резидентнiсть = '||rez_||
                          ' док. = '||trim(pasp_)||
                          ' N док. = '||trim(paspn_)||
                          ' ким виданий '||trim(atrt_)||
                          '   '||trim(nazn_) ) ,1 ,200);

      INSERT INTO rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, ref, rnk, comm, tobo )
      VALUES
         (nls1_, kv_, fdat_, l_kodp_, p_znap_, nbuc_, ref_, rnk_, comm_, tobo_ ) ;

   END;

-----------------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';

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
   Dat1_ := TRUNC(Dat_,'MM');

   select min(fdat)
      into Dat1_
   from fdat
   where fdat >= Dat1_;

   IF dat_ > to_date('22092014','ddmmyyyy')
   THEN
      Dat1_ := Dat_;
   END IF;

   god_  := TO_CHAR(Dat_,'YYYY');

   IF to_char(dat_,'MM')='12'
   THEN
      god_ := to_char(to_number(god_)+1);
   END IF;

   last_dayF := last_day(Dat_);
   one_day_ := to_date('01' || to_char(add_months(dat_,1),'MM') || god_,'ddmmyyyy');
   dat2_ := one_day_;

-- это выходной?
   SELECT COUNT (*)
     INTO kolvo_
     FROM holiday
    WHERE holiday = dat2_ AND kv = 980;

-- если да, то ищем не выходной
   IF kolvo_ <> 0
   THEN
      IF to_char(dat_,'MM') = '12'
      THEN
         select min(fdat)
            into one_day_
         from fdat
         where fdat > dat2_;
      ELSE
         select min(fdat)
            into one_day_
         from fdat
         where fdat >= dat2_;
      END IF;

   END IF;
   -- временно для проверки в Запорожье (за 08.09.2010)
   IF Dat_ = to_date('08092010','ddmmyyyy')
   THEN
      Dat1_ := Dat_;
   END IF;

   -- параметры формирования файла
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);
   nbuc_ := nbuc1_;

   if type_ ='X'  then
         begin
             select obl   into  nbuc_x
              from branch
             where branch ='/'||to_char(mfo_)||'/';
         exception
            when others  then  nbuc_x :='26';
         end;
         nbuc_ :=nbuc_x;
   end if;

   -- отбор проводок, удовлетворяющих условию
   -- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   -- переказ коштiв нерезидентам (отримання коштiв вiд нерезидентiв)
   IF mfou_ = 300465 and mfo_ = mfou_ then
      INSERT INTO OTCN_PROV_TEMP
       (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv, nazn, branch)
      SELECT *
        FROM ( -- перерахування переказiв
/*               SELECT   1 ko,
                       (case when o.nbsd IN ('2620','2902','2924') then o.rnkd else o.rnkk end) rnk,
                       o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    AND (o.nbsd IN ('2620','2902','2924')  AND
                         o.nbsk IN ('1500','1919','2909')
                         or
                         o.nbsd IN ('1001','1002') AND
                         o.nbsk IN ('1919','2909')
                         )
                    AND (LOWER (o.nazn) LIKE '%переказ%' OR
                         LOWER (o.nazn) LIKE '%перевод%' OR
                         LOWER (o.nazn) LIKE '%transfer%')
              UNION
                  SELECT   1 ko,
                       (case when o.nbsd IN ('2620','2902','2924') then o.rnkd else o.rnkk end) rnk,
                       o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o, kl_ff1 k
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    AND (o.nbsd IN ('1001','1002') AND
                         o.nbsk = '2909'
                            or
                         o.nbsd IN ('2620','2902','2924') AND
                         o.nbsk IN ('1500','1919','2909'))
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND trim(k.ob22) is null
              UNION     */
                  SELECT   1 ko, o.rnkk rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o, kl_ff1 k
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    AND o.nbsd IN ('1001','1002')
                    AND o.nbsk = '2909'
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND NVL(k.ob22, o.ob22k) = o.ob22k
              UNION
              -- надходження переказiв (видача переказiв)
/*              SELECT   2 ko, o.rnkk rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    AND (o.nbsd IN ('1500','1600','2603','3720','3739','3900',
                                    '2809','2909','1919')
                    AND o.nbsk IN ('2620','2625','2924') )
                    AND (LOWER (o.nazn) LIKE '%переказ%' OR
                         LOWER (o.nazn) LIKE '%перевод%' OR
                         LOWER (o.nazn) LIKE '%transfer%')
              UNION
              SELECT   2 ko, o.rnkd rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    AND (o.nbsd IN ('2809','2909') AND
                         o.nbsk IN ('1001','1002') )
                    AND (LOWER (o.nazn) LIKE '%переказ%'  OR
                         LOWER (o.nazn) LIKE '%перевод%' OR
                         LOWER (o.nazn) LIKE '%transfer%')
                    AND (LOWER (o.nazn) NOT LIKE '%ком__с__%' OR
                         LOWER (o.nazn) NOT LIKE '%ком_с__%')
              UNION
                  SELECT   2 ko, o.rnkd rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o, kl_ff1 k
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    AND o.nbsd IN ('2809', '2909')
                    AND o.nbsk IN ('1001','1002')
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND trim(k.ob22) is null
              UNION     */
                  SELECT   2 ko, o.rnkk rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o, kl_ff1 k
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    AND o.nbsd IN ('1500','1600','2603', '3720','3739','3900',
                                   '2809','2909','1919')
                    AND o.nbsk IN ('2620','2625','2924')
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND trim(k.ob22) is null
              UNION
                  SELECT   2 ko, o.rnkk rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o, kl_ff1 k
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    AND (mfou_ = 300465 and mfo_ = mfou_)
                    -- включаем проводки вида Дт 2809, 2909 Кт 1001,1002 по значению OB22 для СБ
                    AND o.nbsd IN ('2809', '2909')
                    AND o.nbsk IN ('1001','1002','2620','2625','2902','2909','2924')
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    AND NVL(k.ob22,o.ob22d) = o.ob22d)
      where upper(nazn) not like '%(VO70040)%';
   ELSIF (mfo_ <> mfou_ and mfou_ in (300465)) THEN
       INSERT  /*+APPEND */
        INTO OTCN_PROV_TEMP
            (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv, nazn, branch)
       SELECT  /*+noparallel*/  *
       FROM (-- ТIЛЬКИ ДЛЯ ВС?Х ОБЛУПРАВЛIННЬ ОЩАДБАНКУ    перерахування переказiв
                  SELECT   
                       1 ko, 
                       o.rnkd rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o, kl_ff1 k
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    -- включаем проводки вида Дт 1001,1002 Кт 2909 по параметру OB22 для СБ
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    and k.ob22 is not null
                    AND k.ob22 = o.ob22k
                    AND NVL(k.tt,o.tt) = o.tt
              UNION ALL
                  -- надходження переказiв (видача переказiв)
                  SELECT   2 ko, o.rnkk rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                       o.acck, o.nlsk,
                       o.s * 100 s_nom,
                       gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                  FROM provodki_otc o, kl_ff1 k
                  WHERE o.fdat = Dat_
                    AND o.kv != 980
                    -- включаем проводки вида Дт 2809, 2909 Кт 1001,1002 по значению OB22 для СБ
                    AND o.nlsd LIKE k.nlsd || '%'
                    AND o.nlsk LIKE k.nlsk || '%'
                    and k.ob22 is not null
                    AND k.ob22 = o.ob22d
                    AND NVL(k.tt,o.tt) = o.tt)
      where upper(nazn) not like '%(VO70040)%';
   END IF;
   commit;
   
   -- удаление типов проводок по кл-ру KL_FF1
   DELETE FROM OTCN_PROV_TEMP
   WHERE ref in (select o.ref
                 from otcn_prov_temp o, kl_ff1 f
                 where substr(trim(o.nlsd),1,length(trim(f.nlsd))) = trim(f.nlsd)
                   and substr(trim(o.nlsk),1,length(trim(f.nlsk))) = trim(f.nlsk)
                   and NVL(trim(f.tt),o.tt) = o.tt
                   and f.pr_del = 0);

   -- удаление проводок для проводок Дт 2909 Кт 2909 и OB22 != '24'
   for k in (select o.ref REF, trim(o.nlsd) NLSD, trim(o.nlsk) NLSK,
                    NVL(trim(s.ob22),'00') OB22
             from otcn_prov_temp o, specparam_int s
             where o.nlsd LIKE '2909%'
               and o.nlsk LIKE '2909%'
               and o.acck = s.acc(+) )
   loop
      if k.ob22 != '24' then
         DELETE FROM OTCN_PROV_TEMP
         WHERE ref = k.ref;
      end if;
   end loop;

   -- удаление сторнированных проводок
   DELETE FROM otcn_prov_temp
   WHERE ref in ( select o.ref
                  from otcn_prov_temp o, oper p
                  where o.ref = p.ref
                    and p.sos <> 5);

   -- удаление проводок Дт 2909 Кт 2900 и назначение платежа перераховано для продажу
   DELETE FROM otcn_prov_temp
   WHERE nlsd like '2909%'
     and nlsk like '2900%'
     and lower (nazn) like ('%перераховано%для продажу%');

   -- удаление проводок Дт 2620 Кт 2909 и назначение платежа з рах .... на рах ....
   DELETE FROM otcn_prov_temp
   WHERE nlsd like '2620%'
     and nlsk like '2909%'
     and tt like 'DP%'
     and lower (nazn) like ('%з рах%на рах%');

   if mfou_ = 300465 then
      -- анулювання відкликання переказів в IВ
      for k in ( select o.ref REF, o.nlsd, o.nlsk, o.fdat
                 from otcn_prov_temp o
                 where (o.nlsd LIKE '2809%' OR o.nlsd like '2909%')
                   and o.nlsk LIKE '100%'
                   and o.tt in ('M37','MMV','CN3','CN4') )
      loop
         begin
            select trim(w.value),
               to_date(substr(replace(replace(trim(w1.value), ',','/'),'.','/'),1,10), 'dd/mm/yyyy')
            into ref_m37, dat_m37
            from operw w, operw w1
            where w.ref = k.ref
              and (w.tag like 'D_REF%' or w.tag like 'REFT%')
              and w1.ref = k.ref
              and (w1.tag like 'D_1PB%' or w1.tag like 'DATT%');

            -- фактическая дата оплаты анулированной проводки
            BEGIN
               select fdat
                  into fdat_CN3
               from otcn_prov_temp
               where ref = ref_m37;
            EXCEPTION WHEN NO_DATA_FOUND THEN
                fdat_CN3 := dat_m37;
            end;

            -- 10/10/2014 т.к. файл ежедневный то удаляем первоначальные и
            -- анулированные переводы если они выполнены в одном банковском дне
            if (k.fdat = dat_m37) OR (k.fdat = fdat_CN3) then
               delete from otcn_prov_temp
               where ref in (k.ref, ref_m37);
            end if;
         EXCEPTION
            WHEN NO_DATA_FOUND THEN
                null;
            when others then
                raise_application_error(-20000, 'Помилка для РЕФ = '||to_char(k.ref)||
                                        ': перевірте доп.реквізити D_1PB(DATT) та D_REF(REFT)! '||sqlerrm);
         end;
      end loop;
   end if;

      -- переказ коштiв фiз. особами за межi України (отримання коштiв фiз. особами)
   OPEN opl_dok;

   LOOP
      FETCH opl_dok
      INTO d060_, rnk_, fdat_, ref_, tt_, acc_, nls_, kv_, acck_, nlsk_,
           sum0_, sumk0_, nazn_, tobo_;

      EXIT WHEN opl_dok%NOTFOUND;

      comm_ := '';
      pasp_ := '';
      paspn_ := '';
      pr_pasp_ := 0;
      atrt_ := '';
      d#73_ := null;

      BEGIN
         select 2 - mod(codcagent,2)
           INTO rez_
         from customer
         where rnk = rnk_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         rez_ := 1;
      END;

      BEGIN
         select substr(trim(value),1,50)
            INTO atrt_
         from operw
         where ref = ref_
           and trim(tag) = 'ATRT';
      EXCEPTION WHEN NO_DATA_FOUND THEN
         atrt_ := '';
      END;

      BEGIN
         select 1
            INTO rez1_
         from operw
         where ref = ref_
           and trim(tag) = 'ATRT'
           and (((UPPER(trim(value)) LIKE '%МВД%' OR
                UPPER(trim(value)) LIKE '%МВС%') AND
                UPPER(trim(value)) NOT LIKE '%РОС%') OR
                UPPER(trim(value)) LIKE '%УКРА%');

         pr_pasp_ := 1;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         BEGIN
            select 1
               INTO rez1_
            from operw
            where ref = ref_
              and trim(tag) = 'NATIO'
              and (UPPER(trim(value)) LIKE '%УКР%' OR
                   UPPER(trim(value)) LIKE '%804%');

            pr_pasp_ := 1;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
               select 1
                  INTO rez1_
               from operw
               where ref = ref_
                 and trim(tag) LIKE '%PASP%'
                 and substr(UPPER(trim(value)),1,1) in
                      ('А','В','С','Е','?','I','К','М','О','Р','Т','Х')
                 and ROWNUM = 1 ;

               pr_pasp_ := 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  select 2
                     INTO rez1_
                  from operw
                  where ref = ref_
                    and trim(tag) = 'ATRT'
                    and (((UPPER(trim(value)) LIKE '%МВД%' OR
                           UPPER(trim(value)) LIKE '%МВС%') AND
                           UPPER(trim(value)) LIKE '%РОС%') OR
                          (UPPER(trim(value)) NOT LIKE '%МВД%' and
                           UPPER(trim(value)) NOT LIKE '%МВС%'));
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  rez1_ := null;
               END;
            END;
         END;
      END;

      IF pr_pasp_ = 0
      THEN
         BEGIN
            select 2
               INTO rez1_
            from operw
            where ref = ref_
              and trim(tag) = 'NATIO'
              and trim(value) is not null
              and UPPER(trim(value)) NOT LIKE '%УКР%'
              and UPPER(trim(value)) NOT LIKE '%804%';
         EXCEPTION WHEN NO_DATA_FOUND THEN
            null;
         END;
      END IF;

      IF rez1_ is not null
      THEN
         rez_ := rez1_;
      END IF;

      d#73_ := null;
      kod_g_ := null;
      kod_g_pb1 := null;

      IF sum0_ <> 0 THEN

         for k in (select * from operw where ref=ref_ and tag like 'PASP%')

         loop
            if k.tag = 'PASP' then
               pasp_ := substr(trim(k.value),1,20);
            end if;

            if k.tag = 'PASPN' then
               paspn_ := substr(trim(k.value),1,20);
            end if;
         end loop;

         BEGIN
            select substr(trim(value),1,1), substr(trim(value),1,10)
              INTO D#73_, value_
            from operw
            where ref = ref_
              and tag = 'REZID' ;
              
            if D#73_ not in ('1','2') then
               if LOWER(value_) like '%нерез%' then
                 D#73_ := '2';
               else
                 D#73_ := '1';
               end if;
            end if;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN
              select '1'
                 INTO D#73_
              from operw
              where ref = ref_
                and tag  LIKE '%OKPO%'
                and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
              d#73_ := null;
            END;
         END;

         IF d060_ = 1 or ( d060_ = 2 and nls_ like '2909%' and nlsk_ like '3739%') THEN
            kod_g_ := f_nbur_get_kod_g(ref_, 2); 
            country_ := nvl(kod_g_, '000');
            
            if mfou_ = 300465 and d#73_ is not null then
               rez_ := d#73_;
            end if;

            if nls_ like '100%' or nls_ like '262%' or nls_ like '2900%' or nls_ like '2902%' or nls_ like '2924%' then
               acc1_ := acc_;
               nls1_ := nls_;
            else
               acc1_ := acck_;
               nls1_ := nlsk_;
            end if;

            IF typ_ > 0 THEN
               nbuc_ := NVL (f_codobl_tobo (acc1_, typ_), nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;
------------------------------------------------- для xml
            if type_ ='X'  then
                  begin
                      select obl   into  nbuc_
                       from branch
                      where branch = (select branch  from accounts
                                       where acc =acc1_);
                  exception
                     when others  then  nbuc_ :=nbuc_x;
                  end;
            end if;
-------------------------------------------------            

            if nls_ like '2909%' then
               select ob22
               into ob22_
               from accounts
               where acc = acc_;
            end if;

            IF nls_ not like '26%' and 
               nls_ not like '29%' or
               nls_ like '2909%' and ob22_ = '35' -- прийнято для переказів готівкою                
            THEN
               kodp_ := '1' || '11' || to_char(rez_) || lpad(to_char(kv_),3,'0') || country_;
 
               if kod_g_ is null or (kod_g_ is not null and kod_g_ != '804') then
                  -- запис показника суми
                  p_ins (kodp_, to_char(sum0_) );
               end if;
            ELSE
               if kod_g_ is null or (kod_g_ is not null and kod_g_ != '804') then
                 kodp_ := '1' || '12' || to_char(rez_) || lpad(to_char(kv_),3,'0') || country_;
                 -- запис показника суми
                 p_ins (kodp_, to_char(sum0_) );
               end if;
            END IF;
         ELSE
            kod_g_ := f_nbur_get_kod_g(ref_, 1); 
            country_ := nvl(kod_g_, '000');

            if d#73_ is not null then
               rez_ := d#73_;
            end if;

            if nlsk_ like '100%' or nlsk_ like '262%' or nlsk_ like '2902%' or nlsk_ like '2924%' then
               acc1_ := acck_;
               nls1_ := nlsk_;
            else
               acc1_ := acc_;
               nls1_ := nls_;
            end if;

            IF typ_ > 0 THEN
               nbuc_ := NVL (f_codobl_tobo (acc1_, typ_), nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;
------------------------------------------------- для xml
            if type_ ='X'  then
                  begin
                      select obl   into  nbuc_
                       from branch
                      where branch = (select branch  from accounts
                                       where acc =acc1_);
                  exception
                     when others  then  nbuc_ :=nbuc_x;
                  end;
            end if;
-------------------------------------------------            

            if kod_g_ is null or (kod_g_ is not null and kod_g_ != '804') then
               if nlsk_ like '262%' or nlsk_ like '2900%' or nlsk_ like '2924%' then
                  kodp_ := '1' || '42' || to_char(rez_) || lpad(to_char(kv_),3,'0') || country_;
                 -- запис показника суми
                  p_ins (kodp_, to_char(sum0_) );
               else
                  kodp_ := '1' || '41' || to_char(rez_) || lpad(to_char(kv_),3,'0') || country_;
                  -- запис показника суми
                  p_ins (kodp_, to_char(sum0_) );
               end if;
            end if;
         END IF;
      END IF;
   END LOOP;

   CLOSE opl_dok;
---------------------------------------------------
   if type_ != 'X'  then

        DELETE FROM tmp_nbu
              WHERE kodf = kodf_ AND datf = dat_;

        INSERT INTO tmp_nbu (kodp, datf, kodf, znap, nbuc)
           SELECT kodp, dat_, kodf_, SUM(to_number(znap)), nbuc
             FROM rnbu_trace
            WHERE userid = userid_
           GROUP BY KODP,NBUC;
   end if;
----------------------------------------
END p_ff1_nn;
/
show err;

PROMPT *** Create  grants  P_FF1_NN ***
grant EXECUTE                   on P_FF1_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                   on P_FF1_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FF1_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
