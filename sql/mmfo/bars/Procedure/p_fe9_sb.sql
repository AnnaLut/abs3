

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FE9_SB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FE9_SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_FE9_SB ( dat_     DATE,
                                       sheme_   VARCHAR2 DEFAULT 'C') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования #E9 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 05/04/2018 (14/03/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
05/04/2018 - для операций M37, MMV, CN3, CN4 
             (операции анулирования переводов)
             удаляем референс проводки анулирования и
             референс проводки перевода если эти проводки выполнены
             в одном отчетном месяце( ранее было в отчетном квартале)
13/03/2018 - доопрацювання по швидкій копійці (COBUMMFO-5136)
10.04.2017 - раскоментарил некоторые строки при наполнении
07.04.2017 - оптимизация наполнения временной табл. OTCN_PROV_TEMP
06.04.2017 - не включаем проводки комиссии по системе Швидка копійка 
             коды оперраций C55, C56, C57, CNC
03.04.2017 - не будем включать проводки для которых Кт 2809 и OB22='24'
             для проводок по системе "Швидка копійка" устанавливаем 
             код страны равным 804
02.02.2017 - на 01.02.2017 файл будет формироваться как месячный вместо 
             квартального 
09.06.2016 - для кода 42 будем включать проводки Дт 3739808 Кт 2809/24
             для ГОУ и для регионов Дт 3739 Кт 3739/10
01.04.2016 - добавлен блок для 42 системы
31.03.2016 - для 2909 изменил OB22 с 24 на 60 
23.04.2015 - изменено формирование начальной даты квартала (Dat1_) 
09.04.2015 - добавляются проводки по системе "Швидка копійка" KV=980
             только отправка (Кт 2909  OB22='60')
06.04.2015 - добавляются проводки по системе "Швидка копійка" KV=980
             OB22  IN ('24','60')
30.03.2015 - с 01.04.2015 новая структура показателя
12.01.2015 - закоментировал часть блока для OB22='75' т.к. изменялся код 
             системы переводов с 11 на другой (01,06 или другой)
             (замечание Хмельницкого РУ) 
09.12.2014 - добавлена обработка доп.реквизита D6#71
             (Код країни перерах/надход.переказу) аналог кода D6#70 
             для определения кода страны
08.10.2014 - изменен блок наполнения таблицы OTCN_PROV_TEMP
             для Запорожья 313957 удаляем операции I00, I05     
01.07.2014 - для операций I04,I05 будем обрабатывать доп.реквизит "F1"
01.04.2014 - с 31.03.2014 новая структура показателя (добавлен код "KKK"
             код региона)
05.02.2014 - в операциях M37,MMV,CN3,CN4 кроме доп.реквизита D_1PB, D_REF
             будем обрабатывать доп.реквизиты DATT (дата перевода),
             REFT (референс перевода) т.к. в некотрых РУ для операций
             CN3, CN4 существуют эти доп.реквизиты
11.01.2014 - в кл-р KL_FE9 добавляем запись Дт 2909 Кт 2900 и OB22=75
             (обязательная продажа суммы перевода больше 150 тыс грн)
             и такие проводки будем включать в файл для формирования
             начальной суммы перевода
             для операций M37, MMV, CN3, CN4
             (операции анулирования переводов)
             обрабатываем доп.параметры "D_1PB"-дата перевода и
             "D_REF"-референс перевода
             и затем удаляем референс проводки анулирования и
             референс проводки перевода если эти проводки выполнены
             в одном отчетном квартале
15.10.2013 - для определения кода систевы по проводкам Дт 100 Кт 2909
             (OB22=75) вместо VIEW PROVODKI используется VIEW OPL
             и добавил дополнительные условия для определения кода
             системы переводов - D060
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_      VARCHAR2 (2)   := 'E9';
   sql_z      VARCHAR2 (200);
   typ_       NUMBER;
   flag_      NUMBER;
   ko_        VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   ko_1       VARCHAR2 (2);      -- ознака операцii з безготiвковою iнвалютою
   kod_b_     VARCHAR2 (10);                          -- код банку
   nam_b      VARCHAR2 (70);                        -- назва банку
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
   nbs_k      VARCHAR2 (4);
   isp_       NUMBER;
   nbuc1_     VARCHAR2 (12);
   nbuc_      VARCHAR2 (12);
   country_   VARCHAR2 (3);
   d060_      NUMBER;
   rnk_       NUMBER;
   okpo_      VARCHAR2 (14);
   nmk_       VARCHAR2 (70);
   k040_      VARCHAR2 (3);
   val_       VARCHAR2 (70);
   tg_        VARCHAR2 (70);
   fdat_      DATE;
   data_      DATE;
   dat1_      DATE;
   sum0_      DECIMAL (24);
   sumk0_     DECIMAL (24);                            --ком_с_я по контракту
   kodp_      VARCHAR2 (33);

   znap_      VARCHAR2 (70);
   tag_       VARCHAR2 (5);
   userid_    NUMBER;
   ref_       NUMBER;
   mfo_       number;
   mfou_      number;
   tt_        varchar2 (3);
   comm_      varchar2 (200);

   formOk_    boolean;
   ttd_       varchar2 (3);
   nlsdd_     varchar2 (20);


   d1#E9_     VARCHAR2 (70);
   d2#E9_     VARCHAR2 (70);
   d3#E9_     VARCHAR2 (70);
   d4#E9_     VARCHAR2 (70);

   kolvo_     NUMBER;
   kod_g_     Varchar2 (3);
   kod_g_pb1  Varchar2 (3);
   nazn_      varchar2 (160);
   tobo_      varchar2 (30);
   dat2_      date;
   last_dayF  date;
   god_       varchar2 (4);
   one_day_   date;
   ob22_      Varchar2 (2);
   ob22_k     Varchar2 (2);
   ref_m37    number;
   dat_m37    date;
   our_reg_   NUMBER;
   b040_      VARCHAR2 (20);
   kkk_       VARCHAR2 (3);
   dat_izm1   date := to_date('31032014','ddmmyyyy');
   dat_izm2   date := to_date('31032015','ddmmyyyy');
   dat_izm3   date := to_date('31012017','ddmmyyyy');

   TYPE temp_rec_t IS TABLE OF OTCN_PROV_TEMP%rowtype;
   l_temp_rec temp_rec_t := temp_rec_t();
   
   TYPE ref_type_curs IS REF CURSOR;

   cur_temp        ref_type_curs;
   cursor_sql      clob;
   ppp_       VARCHAR2 (3);
   kod_w_     Varchar2 (1);
   kod_f_     Varchar2 (1);
   kod_a_     Varchar2 (1);
   glb_       Number;
   d060k030_  Varchar2 (1);
   po_kod_    Varchar2 (3);
   nn_        Number := 0;
   
   kol_       Number := 0;
   
   l_err      Number := 0;
   l_message  Varchar2 (255);

-- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   CURSOR opl_dok
   IS
      SELECT   t.ko, t.fdat, t.REF, t.TT, t.accd, t.nlsd, t.kv, t.acck, t.nlsk,
               max(t.s_nom), max(t.s_eqv), t.nazn, t.branch
      FROM OTCN_PROV_TEMP t
      WHERE t.nlsd is not null
        and t.nlsk is not null
      GROUP BY t.ko, t.fdat, t.REF, t.TT, t.accd, t.nlsd, t.kv, t.acck, t.nlsk, t.nazn, t.branch;

-------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ IN VARCHAR2, p_znap_ IN VARCHAR2)
   IS
      l_kodp_   VARCHAR2 (33);
   BEGIN
      l_kodp_ := p_kodp_ ;

      INSERT INTO rnbu_trace
         (nls, kv, odate, kodp, znap, nbuc, isp, rnk, ref, comm, tobo)
      VALUES
         (nls1_, kv_, fdat_, l_kodp_, p_znap_, nbuc_, isp_, rnk_, ref_, comm_, tobo_);

   END;
-------------------------------------------------------------------
-----------------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';

   logger.info ('P_FE9_SB: Begin ');

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_prov_temp';
   EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS=''.,''';
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
     god_  := TO_CHAR(Dat_,'YYYY');
   -- для месячного файла дата начала месяца
   --Dat1_ := TRUNC (Dat_, 'MM');

   -- для квартального файла дата начала квартала 
   -- (если отчетная дата конечная дата квартала - было)
   --Dat1_ := TRUNC (ADD_MONTHS (Dat_, -2), 'MM');
   -- первое число квартала для любой отчетной даты квартала
   if to_char(Dat_, 'MM') in ('01','02','03') 
   then 
      Dat1_ := to_date('0101' || god_, 'ddmmyyyy');
   elsif to_char(Dat_, 'MM') in ('04','05','06') then
      Dat1_ := to_date('0104' || god_, 'ddmmyyyy');
   elsif to_char(Dat_, 'MM') in ('07','08','09') then
      Dat1_ := to_date('0107' || god_, 'ddmmyyyy');
   else 
      Dat1_ := to_date('0110' || god_, 'ddmmyyyy');
   end if;
   
   if Dat_ >= dat_izm3
   then
      Dat1_ := TRUNC (Dat_, 'MM');
   end if;

   select min(fdat)
      into Dat1_
   from fdat
   where fdat >= Dat1_;

   if to_char(dat_,'MM')='12' then
      god_ := to_char(to_number(god_) + 1);
   end if;
   
   last_dayF := last_day(Dat_);
   one_day_ := to_date('01'||to_char(add_months(dat_,1),'MM')||god_,'ddmmyyyy');
   dat2_ := one_day_;

   -- это выходной?
   SELECT COUNT (*)
     INTO kolvo_
     FROM holiday
    WHERE holiday = dat2_ AND kv = 980;

   -- если да, то ищем не выходной
   IF kolvo_ <> 0
   THEN
      select min(fdat)
         into one_day_
      from fdat
      where fdat >= dat2_;
   END IF;

   -- код "KKK" - код региона с 31.03.2014
   kkk_ := '';

   -- код "GLB" из RCUKRU - код банка  с 31.03.2015 
   BEGIN
      select NVL(glb,0) 
         into glb_
      from rcukru
      where mfo = mfou_;
   EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
         glb_ := 0;
   END;

   -- параметры формирования файла
   p_proc_set (kodf_, sheme_, nbuc1_, typ_);

   -- отбор проводок, удовлетворяющих условию
   -- переказ коштiв по мiжнароднiй системi переказу коштiв або отримання переказу
   -- переказ коштiв нерезидентам (отримання коштiв вiд нерезидентiв)
   INSERT INTO OTCN_PROV_TEMP
   (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv, s_kom, nazn, branch)
   select /*+ FULL(k) LEADING(k) */
           k.d060, 1, od.fdat, od.ref, od.tt, 
           ad.acc accd, ad.nls nlsd, ad.kv, ak.acc acck, ak.nls nlsk, od.s  s_nom,
           gl.p_icurval (ad.kv, od.s, od.fdat) s_eqv, 
           0 S_KOM, p.nazn, p.branch
    from opldok od, accounts ad, kl_fe9 k, opldok ok, accounts ak, oper p
    where od.fdat between dat1_ and dat_ and
          od.acc = ad.acc and
          od.DK = 0 and
          ad.nls LIKE k.nlsd || '%' and
          od.ref = ok.ref and
          od.stmt = ok.stmt and
          ok.fdat between dat1_ and dat_ and
          ok.acc = ak.acc and
          ok.DK = 1 and
          ak.nls LIKE k.nlsk || '%' and
          (regexp_like(ad.NLS,'^((2809)|(2909))') and ad.OB22 = k.ob22 or
           regexp_like(ak.NLS,'^((2809)|(2909))') and ak.OB22 = k.ob22) and
          od.tt NOT IN ('C55', 'C56', 'C57', 'CNC', 'R01') and
          nvl(K.PR_DEL, 1) <> 0 and
          not (ad.NLS like '2909%' and ak.NLS like '2909%' and ak.ob22 <> '60') and
          not (ad.NLS  like '29091030046500%' and ak.NLS  like '29094030046530%') and 
          not (substr(ad.NLS,1,4) = substr(ak.NLS,1,4) and ad.ob22 = ak.ob22 and lower(p.nazn) like '%перенес%') and
          not (lower(p.nazn) like '%повернення%' and p.tt not in ('M37','MMV','CN3','CN4')) and  
          not (ad.kv = 980 and lower(od.txt) like '%ком_с_я%') and
          od.ref = p.ref and 
          lower(p.nazn) not like '%western%' and
          p.sos = 5;  

   -- если отчетный день не последний день месяца то выпоняем включение в файл проводок
   -- введенных в последние календарные дни и проведенные в балансе 1 рабочего дня след. месяца
   if mfou_ = 300465 then
      if last_dayF != Dat_ then
         INSERT /*+ APPEND */ INTO OTCN_PROV_TEMP
          (ko, rnk, fdat, REF, tt, accd, nlsd, kv, acck, nlsk, s_nom, s_eqv, nazn, branch)
         SELECT *
         FROM (
                -- ТIЛЬКИ ДЛЯ ВС?Х ОБЛУПРАВЛIННЬ ОЩАДБАНКУ    перерахування переказiв
                SELECT  /*+ PARALLEL(8) */
                     k.d060, ca.rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                     o.acck, o.nlsk,
                     o.s * 100 s_nom,
                     gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                FROM provodki_otc o, cust_acc ca, kl_fe9 k, oper p, specparam_int s
                WHERE o.fdat = one_day_
                  AND o.kv != 980
                  AND mfou_ = 300465
                  AND o.nlsd LIKE k.nlsd || '%'
                  AND o.nlsk LIKE k.nlsk || '%'
                  AND decode(substr(o.nlsd,1,4),'2809',o.accd,'2909',o.accd,o.acck) = ca.acc
                  AND decode(substr(o.nlsd,1,4),'2809',o.accd,'2909',o.accd,o.acck) = s.acc(+)
                  AND NVL(k.ob22,s.ob22) = s.ob22
                  AND o.ref = p.ref
                  AND p.pdat > Dat_
                  AND to_char(p.pdat,'MM') = to_char(dat_,'MM')
                  AND p.pdat < one_day_
                UNION
                -- надходження переказiв (видача переказiв)
                SELECT /*+ PARALLEL(8) */
                    k.d060, ca.rnk, o.fdat, o.ref, o.tt, o.accd, o.nlsd, o.kv,
                    o.acck, o.nlsk, o.s * 100 s_nom,
                    gl.p_icurval (o.kv, o.s * 100, o.fdat) s_eqv, o.nazn, o.branch
                FROM provodki_otc o, cust_acc ca, kl_fe9 k, oper p, specparam_int s
                WHERE o.fdat = one_day_
                  AND o.kv != 980
                  AND mfou_ = 300465
                  AND o.nlsd LIKE k.nlsd || '%'
                  AND o.nlsk LIKE k.nlsk || '%'
                  AND decode(substr(o.nlsd,1,4),'2809',o.accd,'2909',o.accd,o.acck) =  ca.acc
                  AND decode(substr(o.nlsd,1,4),'2809',o.accd,'2909',o.accd,o.acck) = s.acc(+)
                  AND NVL(k.ob22,s.ob22) = s.ob22
                  AND o.ref = p.ref
                  AND p.pdat > Dat_
                  AND to_char(p.pdat,'MM') = to_char(dat_,'MM')
                  AND p.pdat < one_day_ );
            commit;
      end if;
   end if;

   -- удаление док-тов принятых в предыдущем месяце и проведенных в первых числах отчетного месяца
   if mfou_ = 300465 then
      DELETE FROM otcn_prov_temp
      WHERE ref in ( select o.ref
                     from otcn_prov_temp o, oper p
                     where o.fdat >= dat1_  
                       and o.ref = p.ref
                       and p.pdat < dat1_
                       and to_char(p.pdat,'MM') != to_char(dat1_,'MM'));  
   end if;

   -- удаление проводок для проводок Дт 2909 Кт 2909 и OB22 != '60'
   -- 31.03.2016 поменял для OB22 со значения 24 на 60 
   for k in (select o.ref REF, trim(o.nlsd) NLSD, trim(o.nlsk) NLSK,
                    NVL(trim(s.ob22),'00') OB22
             from otcn_prov_temp o, specparam_int s
             where o.nlsd LIKE '2909%'
               and o.nlsk LIKE '2909%'
               and o.acck = s.acc(+) )
      loop

          if k.ob22 != '60' then
             DELETE FROM OTCN_PROV_TEMP
             WHERE ref = k.ref;
          end if;

      end loop;

   -- удаление проводок для проводок Дт 2809 Кт 2909 и OB22 = '75'
   for k in ( select o.ref REF, trim(o.nlsd) NLSD, trim(o.nlsk) NLSK,
                     o.s_nom S_NOM, NVL(trim(s.ob22),'00') OB22
              from otcn_prov_temp o, specparam_int s
              where o.nlsd LIKE '2809%'
                and o.nlsk LIKE '2909%'
                and o.acck = s.acc(+)
                and nvl(s.ob22,'00') = '75'
            )
      loop

          DELETE FROM OTCN_PROV_TEMP
          WHERE ref = k.ref and s_nom = k.s_nom and
                trim(nlsd) = k.nlsd and trim(nlsk) = k.nlsk;
   
      end loop;

   -- удаление проводок с назначением платежа "Повернення переказу"
   -- для проводок Дт 2909 Кт 100*
   for k in ( select o.ref, o.fdat, trim(o.nlsd) NLSD, trim(o.nlsk) NLSK, o.s_nom
              from otcn_prov_temp o
              where o.nlsd LIKE '2909%'
                and o.nlsk LIKE '100%'
                and LOWER(o.nazn) like '%повернення переказу%'
            )
      loop

          DELETE FROM OTCN_PROV_TEMP
          WHERE nlsk like k.nlsd||'%'
            and nlsd like k.nlsk||'%'
            and s_nom = k.s_nom
            and to_char(fdat,'MM') = to_char(k.fdat,'MM');

          DELETE FROM OTCN_PROV_TEMP
          WHERE ref = k.ref;

      end loop;

   -- удаление сторнированных проводок
   DELETE FROM otcn_prov_temp
   WHERE ref in ( select o.ref
                  from otcn_prov_temp o, oper p
                  where o.ref = p.ref
                    and p.sos <> 5);

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

            if to_char(k.fdat,'MM') = to_char(dat_m37,'MM') then
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

   -- для Запорожья 313957 убираем операции I00, I05
   if mfo_ = 313957 then
      delete from otcn_prov_temp
      where tt in ('I00', 'I05');
   end if;

   -- переказ коштiв нерезидентам (отримання коштiв вiд нерезидентiв)
   OPEN opl_dok;

   LOOP
      FETCH opl_dok
       INTO d060_, fdat_, ref_, tt_, acc_, nls_, kv_, acck_, nlsk_, sum0_, sumk0_, nazn_, tobo_;

      EXIT WHEN opl_dok%NOTFOUND;

      ttd_ := null;
      nlsdd_ := null;
      d1#E9_ := null;
      d2#E9_ := null;
      d3#E9_ := null;
      d4#E9_ := null;
      kod_b_ := null;

      kod_g_ := null;
      kod_g_pb1 := null;

      IF sum0_ <> 0 THEN

         formOk_ := true;

         if (nls_ like '2809%' or nls_ like '2909%') then
            acc1_ := acc_;
            nls1_ := nls_;
         else
            acc1_ := acck_;
            nls1_ := nlsk_;
         end if;

         if d060_ = '11' and nls_ like '2909%' then
            BEGIN
               select ob22
                  into ob22_
               from specparam_int
               where acc = acc_;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                ob22_ := null;
             END;
         end if;

         if d060_ = '11' and nls_ like '2909%' and ob22_ = '75' then
            BEGIN
               select substr(nlsd,1,4), NVL(ob22d,'00')
                 into  nbs_k, ob22_k
               from provodki_otc
               where ref = ref_  
                 and acck = acc_  
                 and nlsd LIKE '2809%' 
                 and rownum = 1;

               BEGIN
                  select kl.d060
                     into d060_
                  from kl_fe9 kl
                  where trim(kl.nlsd) = nbs_k
                    and kl.ob22 = ob22_k
                    and rownum = 1;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  d060_ := '99';
               END;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               null;
            END;
         end if;

         -- на 01.04.2014 файл будет консолидированній
         -- но в показатель добавлен код региона (код KKK)
         IF dat_ >= dat_izm1 then
            nbuc_ := nbuc1_;
            kkk_ :=  NVL (lpad (f_codobl_tobo (acc1_, 4), 3, '0'),'000');
         ELSE
            IF typ_ > 0 THEN
               nbuc_ := NVL (f_codobl_tobo (acc1_, typ_), nbuc1_);
            ELSE
               nbuc_ := nbuc1_;
            END IF;
         END IF;

         if Dat_ >= dat_izm2 then  
            kod_w_ := '1';
            kod_f_ := '2';
            kod_a_ := '3';
         end if;

         -- 31.03.2016 заменил для d060_ значение 11 на 42 
         if Dat_ >= dat_izm2 and d060_ = '42' and kv_ = 980 then
            kod_f_ := '1';
         end if;

         if formOk_ and d060_ <> '99' then
            -- додатковi параметри
            n_ := 2;

            for k in (select *
                      from operw k
                      where ref=ref_ and
                         (k.tag like 'n%' or k.tag like 'D6#7%' or k.tag like 'D6#E2%' or k.tag like 'F1%')
                     )
               loop
                  -- с 01.08.2012 добавляется код страны отправителя или получателя перевода
                  if k.tag like 'n%' and substr(trim(k.value),1,1) in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),2,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'n%' and substr(trim(k.value),1,1) not in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),1,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#7%' and substr(trim(k.value),1,1) in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),2,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#7%' and substr(trim(k.value),1,1) not in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),1,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),2,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D6#E2%' and substr(trim(k.value),1,1) not in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),1,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),2,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'D1#E9%' and substr(trim(k.value),1,1) not in ('O','P','О','П') then
                     kod_g_ := substr(trim(k.value),1,3);
                     exit;
                  end if;

                  if kod_g_ is null and k.tag like 'F1%' then
                     kod_g_ := substr(trim(k.value),8,3);
                  end if;

               end loop;

            if (kod_g_ is null or kod_g_ = '804') then
               begin
                  select max(substr(trim(k.value),1,3))
                  into kod_g_pb1
                  from operw k
                  where ref = ref_ 
                    and tag = 'KOD_G';
               exception
                  when others then kod_g_pb1 := null;
               end;
            end if;

            if (kod_g_ is null or kod_g_ = '804') and kod_g_pb1 is not null then
               kod_g_ := kod_g_pb1;
            end if;

            if kod_g_ is null then
               D1#E9_ := '000';
            else
               D1#E9_ := kod_g_;
            end if;

            if d060_ = '42' 
            then
               D1#E9_ := '804';
            end if; 

            comm_ := 'код країни отримувача(вiдправника) '||d1#e9_;
            d2#e9_ := '804';

            if (nls_ like '2809%' or nls_ like '2909%') then
               ppp_ := kkk_ ;
               kkk_ := '000';
            
               --01.04.2016
               if d060_ = '42' then
                  kkk_ := ppp_ ;
                  ppp_ := '000';
               end if;
               
               if Dat_ < dat_izm2 then 
                  kodp_ := '1'||lpad(to_char(d060_),2,'0')||
                                lpad(to_char(kv_),3,'0')||
                                lpad(d1#e9_,3,'0')||
                                lpad(d2#e9_,3,'0') || kkk_;
               else
                  kodp_ := '1'|| kod_w_ || lpad(to_char(d060_),2,'0') ||
                                kod_f_ || kod_a_ ||
                                lpad(to_char(glb_),10,'0') || 
                                lpad(to_char(nn_),2,'0') ||
                                lpad(to_char(kv_),3,'0') ||
                                lpad(d1#e9_,3,'0') || kkk_ ||
                                lpad(d2#e9_,3,'0') || ppp_;
               end if;
            else
               if (nls_ like '100%' or nls_ like '262%') and (nlsk_ like '2809%' or nlsk_ like '2909%') then
                  d2#e9_ := '804';
               end if;
               ppp_ := '000';

               if Dat_ < dat_izm2 then
                  kodp_ := '1'||lpad(to_char(d060_),2,'0')||
                                lpad(to_char(kv_),3,'0')||
                                lpad(d2#e9_,3,'0')||
                                lpad(d1#e9_,3,'0') || kkk_;
               else 
                  kodp_ := '1'|| kod_w_ || lpad(to_char(d060_),2,'0') ||
                                kod_f_ || kod_a_ ||
                                lpad(to_char(glb_),10,'0') || 
                                lpad(to_char(nn_),2,'0') ||
                                lpad(to_char(kv_),3,'0') ||
                                lpad(d2#e9_,3,'0') || kkk_ ||
                                lpad(d1#e9_,3,'0') || ppp_;
               end if;
            end if;

            -- запис показника суми
            p_ins (kodp_, to_char(sum0_) );

            -- запис показника кiлькостi
            if nlsk_ not like '2900%' then
               kodp_ := '3'||substr(kodp_,2);
               p_ins (kodp_, '1' );
            end if;

         end if;
      END IF;
   END LOOP;

   CLOSE opl_dok;
   
   if mfo_ = 300465 then
      begin
          select count(*)
          into kol_
          from NBUR_TMP_E9_CLOB
          where report_date = dat_;
          
          if kol_ = 0 then
             logger.info('P_FE9_SB: begin load data from SK');
             
             begin 
                p_nbur_get_sk_data(Dat1_, dat_, mfo_);
                
                select count(*)
                into kol_
                from NBUR_TMP_E9_CLOB
                where report_date = dat_;
                
                logger.info('P_FE9_SB: end load data from SK');
             exception
                when others then
                     logger.error('P_FE9_SB: ERRORS during load data from SK '||sqlerrm);
             end;
          end if;
          
          if kol_ <> 0 then
             p_nbur_xml_sk_parse(dat_, mfo_, l_err, l_message);  
          end if;
          
          INSERT INTO rnbu_trace
                 (odate, kodp, znap, nbuc, comm)
          select report_date, '11'||ctkod_d060_1||nvl(ctkod_f001, '1')||
              nvl(ctkod_k021, '3')||lpad(nvl(ctkod_k020, '0'), 10, '0')||
              '00'||lpad(nvl(ctkod_r030, '0'), 3, '0')||
              lpad(nvl(ctkod_k040_1, '0'), 3, '0')||
              lpad(nvl(ctkod_ku_1, '0'), 3, '0')||
              lpad(nvl(ctkod_k040_2, '0'), 3, '0')||
              lpad(nvl(ctkod_ku_2, '0'), 3, '0'),
              ctkod_t071, ctkod_ku_1, 'З XML по ШК'
          from NBUR_TMP_E9_SK
          where report_date = dat_ and 
                kf = mfo_ and
                ctkod_t071 <> 0 and 
                ctkod_t080 <> 0
                union all
          select report_date, '31'||ctkod_d060_1||nvl(ctkod_f001, '1')||
              nvl(ctkod_k021, '3')||lpad(nvl(ctkod_k020, '0'), 10, '0')||
              '00'||lpad(nvl(ctkod_r030, '0'), 3, '0')||
              lpad(nvl(ctkod_k040_1, '0'), 3, '0')||
              lpad(nvl(ctkod_ku_1, '0'), 3, '0')||
              lpad(nvl(ctkod_k040_2, '0'), 3, '0')||
              lpad(nvl(ctkod_ku_2, '0'), 3, '0'),
              ctkod_t080, ctkod_ku_1, 'З XML по ШК'
          from NBUR_TMP_E9_SK
          where report_date = dat_ and 
                kf = mfo_ and
                ctkod_t071 <> 0 and 
                ctkod_t080 <> 0;   
      exception
         when others then 
            logger.info('P_FE9_SB: error during load data from SK');
      end;     
   end if;
---------------------------------------------------
   DELETE FROM tmp_nbu
   WHERE kodf = kodf_ AND datf = dat_;
---------------------------------------------------
   INSERT INTO tmp_nbu (kodp, datf, kodf, znap, nbuc)
      SELECT kodp, dat_, kodf_, SUM(to_number(znap)), nbuc
        FROM rnbu_trace
      GROUP BY KODP,NBUC;
----------------------------------------
   logger.info ('P_FE9_SB: End ');
END p_fe9_sb;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FE9_SB.sql =========*** End *** 
PROMPT ===================================================================================== 
