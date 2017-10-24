

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F84.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F84 ***

  CREATE OR REPLACE PROCEDURE BARS.P_F84 (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :#84 for KB
% COPYRIGHT   :Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :20/01/2016 (16/01/2016, 10/01/2016, 17/12/2014)
%             :
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
20/01/2016 отменяем все условия для даты 31.12.2015
           будем формировать файл как было ранее
15/01/2016 - сумму резерва для даты 31.12.2015 выбираем из даты 01.12.2015
             для суммы резерва берем поле REZQ
10.01.2016 - сумму резерва выбираем не из поля REZQ а из поля REZQ23
17.12.2014 - для формирования кода 02327 будем включать поле PV только по
             основным счетам (исключаем премию, дисконт, проценты)
11.12.2014 - в поле COMM вместо кода ID будем формировать код CC_ID
02.12.2014 - для кода PP='40' категория якості будет '0'
14.11.2014 - не определялся код МФО головного банка (MFOU_) но использовался
             определения признака включается или нет в биржевой реестр
             (актуально для ГОУ СБ)
07.10.2014 - для ГОУ обрабатываем новое поле IN_BR в CP_KOD (включено до
             біржового реєстру). Если значение '1' то формируем
             показатели 24, 26 ЦП внесенi до бiржового реєстру
06.08.2014 - для показателя 023РРХ убираем ограничение для бал.счетов
             (было только для бал.счетов "___4")
21.07.2014 - для счетов премии (1415,3115) и K=0 выбираем суммы из BVQ
             и для К <> 0 не выбираем если они отрицательны
24.02.2014 - на 01.03.2014 добавлено формирование кода 024РР1
09.10.2013 - не включались бал.счета 1410, 1411 которые должны
             включаться на 01.10.2013
10.04.2013 - теперішню вартість вибираем только по счетам 3114
             (пока временно)
             Должна быть пропорциональная разбивка в NBU23_REZ
09.04.2013 - для PP='14' не вычитаем сумму резерва
08.04.2013 - если поле QUOT_SIGN в CP_KOD равен '1' то формируем
             показатели 24, 26 ЦП внесенi до бiржового реєстру
08.02.2013 - для дисконта показатели должны быть отрицательными
12.01.2013 - новая структура показателя с 01.01.2013 и новые показатели
04.04.2012 - добавил МФО=300205 для негативно класифiкованих активiв
15.06.2011 - добавил бал.счет 1502 для Дт проводки т.к. в УПБ
             была проводка Дт1502 Кт3005
10.05.2011 - добавил для корреспонденции бал.счет 1502 т.к. в УПБ
             была проводка Дт3005 Кт1502
05.07.2010 - для определения суммы резерва в показателе "12" бал.
             стоимость будем использовать табл. TMP_REZ_RISK
08.04.2010 - для счетов резерва не анализируем параметр R013
             т.к. изменялся код вида ЦБ с 23 на 22 (курсор SALDO)
21.01.2010 - для банка Столица убрал коды (011,018) для "негативно
             класифiкованi активи" (происходило задвоение)
20.01.2010 - для счетов имеющих дату гашения добавлены бал. счета
             3017, 3117
18.01.2010 - для амортизации премии исключаем счет 6393 кроме 6203
09.01.2010 - для банка Столица "негативно класифiкованi активи"
             определяем по параметру S080<>'1'
05.06.2009 - будем выбирать проводки Дт 6052 Кт 3116,3117 а было
             Дт 3116 3117 Кт 6052
10.05.2009 - вместо кодов 81223 будем формировать код 81221 и вместо
             кода 81523 будем формировать код 81521
25.03.2009 - заменил в строке 1075 условие Ostn_=0 на Ostn_>=0
11.07.2008 - для строки 862 было условие if kol_<>0 THEN
             заменил на if kol_<>0 and substr(nls_,1,1)<>'6' THEN
06.12.2007 - для строки 716 изменен блок определения параметра R013
             (добавил BEGIN .... EXCEPTION .... END)
07.11.2007 - для боргових ЦП на продаж группа 140,300,301 код "10"
             изменяем на код "05"
03.10.2007 - в строке 811 добавил в перечне '7' кроме '6','8','9'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    VARCHAR2 (2)   := '84';
acc_     Number;
accc_    Number;
acc1_    Number;
accd_    Number;
acck_    Number;
proc_    Number;
pp_      Varchar2(2);
nbs_     Varchar2(4);
nbs1_    Varchar2(4);
nls_     Varchar2(15);
nlsk_    Varchar2(15);
nls1_    Varchar2(15);
nls1n_   Varchar2(15);
nls6_    Varchar2(15);
nls7_    Varchar2(15);
nls8_    Varchar2(15);
r012_    Varchar2(1);
r012d_   Varchar2(1);
r012k_   Varchar2(1);
s080_    varchar2(1);
s240_    Varchar2(1);
s240d_   Varchar2(1);
s240k_   Varchar2(1);
r013_    Varchar2(1);
r013d_   Varchar2(1);
r013k_   Varchar2(1);
d020_    Varchar2(2);
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat6_    Date;
Dat7_    Date;
Dat8_    Date;
data_    Date;
data1_   Date;
data1n_  Date;
mdate_   Date;
kv_      SMALLINT;
kv1_     SMALLINT;
kv2_     SMALLINT;
kv1n_    SMALLINT;
kv6_     SMALLINT;
kv7_     SMALLINT;
kv8_     SMALLINT;
se_      DECIMAL(24);
Dos_     DECIMAL(24);
Kos_     DECIMAL(24);
sn_      DECIMAL(24);
sn6_     DECIMAL(24);
se6_     DECIMAL(24);
ostn_    DECIMAL(24);
ostnp_   DECIMAL(24);
Dosnk_   DECIMAL(24);
Kosnk_   DECIMAL(24);
s_per_   DECIMAL(24);
s_ns_    DECIMAL(24);
s_rs_    DECIMAL(24);
s_rsk_   DECIMAL(24);
s_rrs_   DECIMAL(24);
s_si_    DECIMAL(24);
s_n4_    DECIMAL(24);
s_n6_    DECIMAL(24);
s_n6n_   DECIMAL(24);
s_n7_    DECIMAL(24);
s_n7n_   DECIMAL(24);
s_n8_    DECIMAL(24);
s_n8n_   DECIMAL(24);
kodp_    Varchar2(10);
kodp1_   Varchar2(10);
znap_    Varchar2(30);
znap1_   Varchar2(30);
dd_      Varchar2(2);
ddd_     Varchar(3);
ddd1_    Varchar2(3);
ddd2_    Varchar2(3);
nnd_     Varchar2(2);
nnk_     Varchar2(2);
f84_     SMALLINT;
kol_     Number;
kolsp_   Number;
pr_cb    Number;
userid_  Number;
nkd_     Varchar2(20);  -- номер договора для ЦБ или номер пакета(аукциона ЦБ)
rezid_   Number;
comm_    Varchar2(200);
typ_     number;
nbuc1_   varchar2(30);
nbuc_    varchar2(30);
sum_o_   Number;
quot_sign_ Number;
mfo_     NUMBER;
mfou_    NUMBER;
pr_form_ NUMBER;

CURSOR BaseL IS
   SELECT kodp, SUM (znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
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

-- определение начальных параметров (код области или МФО или подразделение)
P_Proc_Set('84','G', nbuc1_, typ_);

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_сяця
Dat2_ := TRUNC(Dat_ + 28);

-- код пользователя, данные по расчету резерву которого использовались
-- при формировании фонда
-- если фонд не формировался = код текущего пользователя
if Dat_ <= to_date('30112012','ddmmyyyy') then
   BEGIN
      SELECT userid
         INTO rezid_
      FROM rez_protocol
      WHERE dat = dat_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
      rezid_ := userid_;
      rez.rez_risk (userid_, dat_);
   END;
end if;

SELECT max(fdat) INTO Dat3_ FROM fdat WHERE fdat<Dat1_ ;
-------------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_nbu where kodf = '84' and datf = dat_;
---------------------------------------------------
-- за грудень мiсяць формуємо по новiй структурi показника i iз табл. NBU23_REZ
-- с 01.01.2012 новая структура показателя и новая таблица для формирования NBU23_REZ
if Dat_ > to_date('30112012','ddmmyyyy') then

   DELETE FROM OTCN_LOG
         WHERE userid = userid_ AND kodf = kodf_;

   Dat1_  := TRUNC(add_months(Dat_,1),'MM');

   for k in (select nb.rnk, nb.nmk, nb.acc, nb.nbs, nb.nls, nb.kv, NVL(nb.nd,0) nd,
                 nb.id, NVL(nb.k,'0') kk, NVL(trim(nb.kat),'1') kat,
                 NVL(trim(nb.dd),'2') dd, NVL(round(nb.bvq*100,0),0) BV,
                 NVL(round(nb.pvq*100,0),0) PV,
                 NVL(round(nb.rezq*100,0),0) rezq,
                 NVL(nb.ddd,'000') DDD, 2-MOD(c.codcagent,2) REZ, sp.s080,
                 nb.cc_id
          from nbu23_rez nb, customer c, specparam sp, kl_f3_29 kl
          where nb.fdat = dat1_
            and (nb.ddd like '21%' or trim(nb.ddd) is null)
            and nb.nbs = kl.r020
            and kl.kf = '84'
            --and nb.id not like 'NLO%'
            and nb.bv <> 0
            and nb.rnk = c.rnk
            and nb.acc = sp.acc(+)
         )

    loop

       pr_form_ := 0;

       if Dat_ <= to_date('31082013','ddmmyyyy') and substr(k.nls,1,3) = '141' then
          BEGIN
             select 1
                into pr_form_
             from nbu23_rez
             where rnk = k.rnk
               and fdat = dat1_
               and NVL(nd,0) = k.nd
               and substr(nls,1,4) in ('1410','1411')
               and kv = k.kv
               and rownum = 1;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             pr_form_ := 0;
          END;
       end if;

       if pr_form_ =  0 then

          BEGIN
             select substr(trim(txt),1,2)
                into pp_
             from kl_f3_29
             where kf='84'
               and r020 = k.nbs;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             pp_ := '00';
          END;

          if pp_ = '23' then
             pp_ := '27';
          end if;

          if pp_  in ('21','22') then
             pp_ := '25';
          end if;

          -- определяем признак внесен или не внесен до "бiржового реєстру"
          if pp_ in ('23','27','21','22','25') then
             -- для ГОУ добавлено новое поле IN_BR  (07.10.2014)
             -- (включено до біржового реєстру) в табл.CP_KOD
             if mfou_ = 300465 then
                BEGIN
                   select NVL(in_br,0)
                      into quot_sign_
                   from cp_kod
                   where cp_id = k.cc_id;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   quot_sign_ := 0;
                END;
             else
                BEGIN
                   select NVL(quot_sign,0)
                      into quot_sign_
                   from cp_kod
                   where cp_id = k.cc_id;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   quot_sign_ := 0;
                END;
             end if;
          end if;

          if pp_  in ('21','22','25') and quot_sign_ = 1 then
             pp_ := '24';
          end if;

          if pp_ in ('23','27') and quot_sign_ = 1 then
             pp_ := '26';
          end if;

          if mfou_ in (/*300465,*/ 380764) and k.nbs like '14%' and pp_ in ('23','27') then
             pp_ := '26';
          end if;

          comm_ := ' RNK='||k.rnk||' '||k.nmk||'  CC_ID='||k.cc_id||' ND='||k.nd||' DDD='||k.ddd;

          s080_ := to_char(k.kat);

          if pp_ = '40' then
             s080_ := '0';
          end if;

          --if k.BV <> 0  and (pp_ = '10' and s080_ = '5' or pp_ <> '10') then
          if ( (k.nbs in ('1415','3115') and k.kk=0 and k.BV <> 0) OR
               (k.nbs in ('1415','3115') and k.kk<>0 and k.BV > 0) OR
              (k.nbs not in ('1415','3115') and k.BV <> 0 )
             )  and (pp_ = '10' and s080_ = '5' or pp_ <> '10') then

             if pp_ = '10' then
                s080_ := '0';
                kodp_:= '7' || '12' || pp_ || '0';  --s080_ ;
             else
                kodp_:= '0' || '12' || PP_ || S080_ ;
             end if;

             if (pp_ = '10' and k.nbs not in ('1405','3007','3015')) or pp_ <> '10' then
                select NVL(sum(BVQ*100),0)
                   into sum_o_
                from nbu23_rez
                where fdat = dat1_
                  and NVL(nd,0) = k.nd
                  and rnk = k.rnk;
                if sum_o_ <> 0 then
                   znap_:= TO_CHAR(k.BV);

                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
                   VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);
                end if;

             end if;

             if K.BV <> 0 and pp_ in ('24','26') then
                znap_:= TO_CHAR(k.bv - k.rezq);  -- включил 02.12.2014
                --znap_:= TO_CHAR(k.bv);  -- - k.rezq);  -- исключил 02.12.2014
                kodp_:= '0' || '14' || pp_ || '0';  --s080_ ;
                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
                VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);
             end if;

             if k.BV <> 0 and pp_ = '10' then
                znap_:= TO_CHAR(k.BV);
                kodp_:= '7' || '14' || pp_ || '0';  --s080_ ;
                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
                VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);
             end if;

             if pp_ = '10' and k.nbs in ('1405','3007','3015') then

                select NVL(sum(BVQ*100),0)
                   into sum_o_
                from nbu23_rez
                where fdat = dat1_
                  and NVL(nd,0) = k.nd
                  and rnk = k.rnk;
                if sum_o_ <> 0 then
                   znap_:= TO_CHAR(ABS(k.BV));
                   kodp_:= '7' || '21' || pp_ || '0';
                   INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
                   VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);
                end if;
             end if;
          end if;

          if k.PV <> 0 and pp_ not in ('10','24','26') then

             INSERT INTO OTCN_LOG(kodf, userid, txt)
                  VALUES (kodf_, userid_, 'PV = ' || to_char(k.PV) || ' NLS = ' || k.nls);

             INSERT INTO OTCN_LOG(kodf, userid, txt)
                  VALUES (kodf_, userid_, ' ');

             if ( substr(k.nls,4,1) not in ('5','6','7','8','9') or
                  substr(k.nls,1,4) in ('3005','3105','3125','3135','3205',
                                        '3305','3315','4105','4205')
                )
             then
                kodp_:= '0' || '23' || pp_ || '0';  --s080_ ;
                znap_:= TO_CHAR(k.pv);  --TO_CHAR(ABS(k.pv));

                INSERT INTO OTCN_LOG(kodf, userid, txt)
                     VALUES (kodf_, userid_, 'KODP = ' || kodp_ || ' NLS = ' || k.nls);

                INSERT INTO OTCN_LOG(kodf, userid, txt)
                     VALUES (kodf_, userid_, ' ');

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
                VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);
             end if;
          end if;

          if Dat_ >= to_date('28022014','ddmmyyyy') and k.BV <> 0 and
             k.nbs like '310%' and pp_ = '25' and k.pv = 0  and k.rezq = 0
          then

             kodp_:= '0' || '23' || PP_ || '0' ;

             znap_:= TO_CHAR(k.bv);
             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);
          end if;

          if k.rezq <> 0 then
             kodp_:= '0' || '16' || pp_ || '0' ;
             znap_:= TO_CHAR(ABS(k.rezq));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);

             kodp_:= '0' || '17' || pp_ || s080_ ;
             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);

          end if;

          -- с 01.03.2014 новый код 24 (балансова вартість ЦП за якими
          --                            формування резерву не вимагається
          if Dat_ >= to_date('28022014','ddmmyyyy') and k.BV <> 0
             --and (k.nbs like '141%' or k.nbs like '310%')
             and pp_ in ('24','25','26','27','28','30')
             and k.rezq = 0 and s080_ = '1'
          then

             s080_ := '1';
             kodp_:= '0' || '24' || PP_ || S080_ ;

             if K.BV <> 0 then
                znap_:= TO_CHAR(k.bv);
                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
                VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);
             end if;
          end if;

       end if;

    end loop;
end if;
-- за грудень мiсяць формуємо по новiй структурi показника i iз табл. NBU23_REZ
-------------------------------------------------------------------------------
-- только для 31.12.2015 года расчет суммы резерва из
-- даты 01.12.2015 (нет данных из FINEVERE на 01.01.2016)
--if Dat_ = to_date('31122015','ddmmyyyy') then

--   delete from rnbu_trace where ( kodp like '016%' or kodp like '017%' );

--   dat1_ := trunc (Dat_, 'MM');

--   for k in (select nb.rnk, nb.nmk, nb.acc, nb.nbs, nb.nls, nb.kv, NVL(nb.nd,0) nd,
--                 nb.id, NVL(nb.k,'0') kk, NVL(trim(nb.kat),'1') kat,
--                 NVL(trim(nb.dd),'2') dd, NVL(round(nb.bvq*100,0),0) BV,
--                 NVL(round(nb.pvq*100,0),0) PV,
--                 --NVL(round(nb.rezq*100,0),0) rezq,
--                 NVL(GL.P_ICURVAL(nb.kv, nb.rez*100, Dat_),0) rezq,
--                 NVL(nb.ddd,'000') DDD, 2-MOD(c.codcagent,2) REZ, sp.s080,
--                 nb.cc_id
--          from nbu23_rez nb, customer c, specparam sp, kl_f3_29 kl
--          where nb.fdat = dat1_
--            and (nb.ddd like '21%' or trim(nb.ddd) is null)
--            and nb.nbs = kl.r020
--            and kl.kf = '84'
--            --and nb.id not like 'NLO%'
--            and nb.bv <> 0
--            and nb.rnk = c.rnk
--            and nb.acc = sp.acc(+)
--         )

--    loop

--       pr_form_ := 0;
--
--       if Dat_ <= to_date('31082013','ddmmyyyy') and substr(k.nls,1,3) = '141' then
--          BEGIN
--             select 1
--                into pr_form_
--             from nbu23_rez
--             where rnk = k.rnk
--               and fdat = dat1_
--               and NVL(nd,0) = k.nd
--               and substr(nls,1,4) in ('1410','1411')
--               and kv = k.kv
--               and rownum = 1;
--          EXCEPTION WHEN NO_DATA_FOUND THEN
--             pr_form_ := 0;
--          END;
--       end if;

--       if pr_form_ =  0 then

--          BEGIN
--             select substr(trim(txt),1,2)
--                into pp_
--             from kl_f3_29
--             where kf='84'
--               and r020 = k.nbs;
--          EXCEPTION WHEN NO_DATA_FOUND THEN
--             pp_ := '00';
--          END;

--          if pp_ = '23' then
--             pp_ := '27';
--          end if;

--          if pp_  in ('21','22') then
--             pp_ := '25';
--          end if;

--          -- определяем признак внесен или не внесен до "бiржового реєстру"
--          if pp_ in ('23','27','21','22','25') then
--             -- для ГОУ добавлено новое поле IN_BR  (07.10.2014)
--             -- (включено до біржового реєстру) в табл.CP_KOD
--             if mfou_ = 300465 then
--                BEGIN
--                   select NVL(in_br,0)
--                      into quot_sign_
--                   from cp_kod
--                   where cp_id = k.cc_id;
--                EXCEPTION WHEN NO_DATA_FOUND THEN
--                   quot_sign_ := 0;
--                END;
--             else
--                BEGIN
--                   select NVL(quot_sign,0)
--                      into quot_sign_
--                   from cp_kod
--                   where cp_id = k.cc_id;
--                EXCEPTION WHEN NO_DATA_FOUND THEN
--                   quot_sign_ := 0;
--                END;
--             end if;
--          end if;

--          if pp_  in ('21','22','25') and quot_sign_ = 1 then
--             pp_ := '24';
--          end if;

--          if pp_ in ('23','27') and quot_sign_ = 1 then
--             pp_ := '26';
--          end if;

--          if mfou_ in (/*300465,*/ 380764) and k.nbs like '14%' and pp_ in ('23','27') then
--             pp_ := '26';
--          end if;

--          comm_ := ' RNK='||k.rnk||' '||k.nmk||'  CC_ID='||k.cc_id||' ND='||k.nd||' DDD='||k.ddd;

--          s080_ := to_char(k.kat);

--          if pp_ = '40' then
--             s080_ := '0';
--          end if;

--          if k.rezq <> 0 then
--             kodp_:= '0' || '16' || pp_ || '0' ;
--             znap_:= TO_CHAR(ABS(k.rezq));

--             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
--             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);

--             kodp_:= '0' || '17' || pp_ || s080_ ;
--             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, nd, comm)
--             VALUES (k.nls, k.kv, dat_, kodp_, znap_, nbuc1_, k.rnk, k.nd, comm_);

--          end if;
--       end if;
--   end loop;
--end if;

OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        ('84', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------
END p_f84;
/
show err;

PROMPT *** Create  grants  P_F84 ***
grant EXECUTE                                                                on P_F84           to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F84.sql =========*** End *** ===
PROMPT ===================================================================================== 
