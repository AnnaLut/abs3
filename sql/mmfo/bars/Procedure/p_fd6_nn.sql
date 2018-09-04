CREATE OR REPLACE PROCEDURE BARS.P_FD6_NN (Dat_ DATE,
                                           sheme_ VARCHAR2 DEFAULT 'G',
                                           prnk_   number   DEFAULT null) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	#D6 for KB
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 01/09/2018 (03/08/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 03/08/2018 - для таблицы INT_ACCN добавлено условие ROWNUM=1 (строка 514)
% 08/02/2018 - для 2608 и R011 in ('5','7') и S180 in ('0','1' )
               изменяем S180 на "B"
% 06/02/2018 - для 2608 и R011='0' будем формировать R011 по основному счету
%              для Крыма по 262 и 263 группах K072='N8'
% 05/02/2018 - для 2630 и S183_='1' изменяем S183_ на "B"
% 22/01/2018 - выполнены изменения для параметров K071 и S180
% 12/01/2018 - новая структура показателя
%              (параметр K072 2-х значный вместо однозначного)
% 08/04/2014 - для МФО=300465 и бал.счета 2602 и S180_='1' будем формировать
%              S180_ := '6'
% 27/11/2013 - еквівалент по визнаним процентним доходам по валюті будуть
%              розраховуватись на дату нарахування
% 20/09/2013 - Зміна алгоритму розрахунку середньохронол.залишку (більше
%              наближено до правильної формули) та % ставки
% 11/09/2013 - доопрацювання по рахнках 2600, 2620, 2650 з R011 = '2' (ПКБ)
% 04/02/2013 - новые условия для даты закрытия в кл-ре KL_K110
%              и правильное (ненулевое) формирование K111
% 10/01/2013 - пробна тимчасова версія з KL_K110
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
           prnk_ - РНК контрагента
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_      VARCHAR2(2):='D6';
S180_      VARCHAR2(1);
S181_      VARCHAR2(1);
S183_      Varchar2(1);
sql_	   VARCHAR2(3000);
ks181_     VARCHAR2(1);

def_r011_  VARCHAR2(1);
def_s181_  VARCHAR2(1);

typ_       NUMBER;
kol_       Number;
kol1_      Number;
kol2_      Number;
kol_pr_    Number;
nbs_       VARCHAR2(4);
nbs1_      VARCHAR2(4);
nls_       VARCHAR2(15);
nls2_      VARCHAR2(15);
mfo_       VARCHAR2(12);
data_      DATE;
Dat1_      DATE;
Dat2_      DATE;
DatN_      DATE;
d_close_   DATE;
kv_        SMALLINT;
kv2_       SMALLINT;
isp_       NUMBER;
re_        SMALLINT;
codcagent_ SMALLINT;
sn1_       DECIMAL(24);
se_        DECIMAL(24);
Ostn_      DECIMAL(24);
Ostq_      DECIMAL(24);
Dos96_     DECIMAL(24);
Kos96_     DECIMAL(24);
Dosq96_    DECIMAL(24);
Kosq96_    DECIMAL(24);
koef_      NUMBER;
lim_       NUMBER;
rnk_       NUMBER;
acc_       NUMBER;
acc1_      NUMBER;
acc2_      NUMBER;
dk_        CHAR(1);
kodp_      VARCHAR2(35);
kodp1_     VARCHAR2(35);
znap_      VARCHAR2(70);
f14_       SMALLINT;
r011_      CHAR(1);
r011_1     CHAR(1);
r011_2_    CHAR(1);
r011_new_  CHAR(1);
r012_      CHAR(1);
r013_      VARCHAR2(1);
r013_1     VARCHAR2(1);
ob22_      VARCHAR2(2);
k071_      CHAR(1);
k072_      CHAR(2);
k072p_     CHAR(2);
k081_      CHAR(1);
k111_      CHAR(2);
r031_      CHAR(1);
k051_      CHAR(2);
country_   NUMBER;
countryh_  NUMBER;
userid_    NUMBER;
nbuc1_     VARCHAR2(12);
nbuc_      VARCHAR2(12);
sql_acc_   VARCHAR2(2000):='';
sql_doda_  VARCHAR2(200):='';
ret_	   NUMBER;
mfou_	   NUMBER;
kolvo_     number;
blkd_      Number;
blkk_      Number;
tobo_      accounts.tobo%TYPE;
nms_       accounts.nms%TYPE;
comm_      rnbu_trace.comm%TYPE;
spcnt_     NUMBER;
spcnt_old_ NUMBER;
spcnt1_    VARCHAR2 (10);
fmt_       VARCHAR2 (20)  := '999990D9999';
sob_       NUMBER;
sobpr_     NUMBER;
dat_kl_    date;
sn_        number;
recid_        number;

dat_izm1   date := to_date('01072011','ddmmyyyy');
dat_izm2   date := to_date('31082012','ddmmyyyy');
dat_izm3   date := to_date('29122017','ddmmyyyy');

b_yea      number;
accr_      NUMBER;
tips_      VARCHAR2(3);

dat_spr_   date := last_day(dat_)+1;
mdate_     date;

TYPE ref_type_curs IS REF CURSOR;

saldo        ref_type_curs;
cursor_sql   varchar2(20000);

FL_D8_   number := F_Get_Params('DPULINE8', -1);

type rec_type is record
    (rnk_       number,
     acc_       number,
     nls_       varchar2(15),
     kv_        integer,
     data_      date,
     nbs_       char(4),
     Ostn_      number,
     Ostq_      number,
     Dos96_     number,
     Kos96_     number,
     Dosq96_    number,
     Kosq96_    number,
     isp_       accounts.isp%TYPE,
     lim_       number,
     blkd_      Number,
     blkk_      Number,
     ob22_      accounts.ob22%TYPE,
     tobo_      accounts.tobo%TYPE,
     nms_       accounts.nms%TYPE,
     spcnt_     number,
     mdate_     date,
     re_        SMALLINT,
     k051_      CHAR(2),
     country_   CHAR(3),
     k111_      CHAR(2),
     k072_      CHAR(2),
     k081_      CHAR(1),
     k072p_     CHAR(2),
     acc1_      number,
     r011_      CHAR(1),
     r013_      CHAR(1),
     s180_      CHAR(1),
     acc2_      number,
     codcagent_ SMALLINT);

TYPE rec_t IS TABLE OF rec_type;
l_rec_t      rec_t := rec_t();

TYPE rnbu_trace_t IS TABLE OF rnbu_trace%rowtype;
l_rnbu_trace rnbu_trace_t := rnbu_trace_t();

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM (znap)
   FROM rnbu_trace
   GROUP BY kodp, nbuc;

CURSOR BaseL0 IS
   SELECT nbuc, kodp, SUM (TO_NUMBER (znap)),
            SUM (TO_NUMBER (znap_pr))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP, '0' ZNAP_PR
         FROM RNBU_TRACE a
         WHERE a.kodp like '4%'
           and exists (select 1 from kod_d6_1 where r020=substr(a.kodp,3,4))
         UNION ALL
         SELECT a.nbuc NBUC, '4'||substr(a.kodp,2) KODP, '0' ZNAP,
                a.znap ZNAP_PR
         FROM RNBU_TRACE a
         WHERE a.kodp like '3%'
           and exists (select 1 from kod_d6_1 where r020=substr(a.kodp,3,4)))
   GROUP BY nbuc, kodp;

CURSOR BaseL1 IS
   SELECT nbuc, kodp, SUM (TO_NUMBER (znap))
   FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP
         FROM RNBU_TRACE a
         WHERE a.kodp like '1%')
   GROUP BY nbuc, kodp;

procedure p_add_rec(p_recid rnbu_trace.recid%type, p_userid rnbu_trace.userid%type, p_nls rnbu_trace.nls%type,
                                p_kv rnbu_trace.kv%type, p_odate rnbu_trace.odate%type, p_kodp rnbu_trace.kodp%type,
                                p_znap rnbu_trace.znap%type, p_nbuc rnbu_trace.nbuc%type, p_isp rnbu_trace.isp%type,
                                p_rnk rnbu_trace.rnk%type, p_acc rnbu_trace.acc%type, p_comm rnbu_trace.comm%type,
                                p_tobo rnbu_trace.tobo%type, p_mdate rnbu_trace.mdate%type)
is
    lr_rnbu_trace rnbu_trace%rowtype;
begin
   lr_rnbu_trace.RECID := p_recid;
   lr_rnbu_trace.USERID := p_userid;
   lr_rnbu_trace.NLS := p_nls;
   lr_rnbu_trace.KV := p_kv;
   lr_rnbu_trace.ODATE := p_odate;
   lr_rnbu_trace.KODP := p_kodp;
   lr_rnbu_trace.ZNAP := p_znap;
   lr_rnbu_trace.NBUC := p_nbuc;
   lr_rnbu_trace.ISP := p_isp;
   lr_rnbu_trace.RNK := p_rnk;
   lr_rnbu_trace.ACC := p_acc;
   lr_rnbu_trace.REF := null;
   lr_rnbu_trace.COMM := p_comm;
   lr_rnbu_trace.ND := null;
   lr_rnbu_trace.MDATE := p_mdate;
   lr_rnbu_trace.TOBO := p_tobo;

   l_rnbu_trace.Extend;
   l_rnbu_trace(l_rnbu_trace.last) := lr_rnbu_trace;

   if l_rnbu_trace.COUNT >= 100000 then
      FORALL i IN 1 .. l_rnbu_trace.COUNT
           insert /*+ append */ into rnbu_trace values l_rnbu_trace(i);

      l_rnbu_trace.delete;
   end if;
end;

-------------------------------------------------------------------
PROCEDURE p_obrab_data(p_type_ IN NUMBER) IS
    nbs2_ varchar2(4) := (case when nbs_  not like '7%' then nbs_ else null end);
BEGIN
   if p_type_ = 1 then
      comm_ := '';
   elsif p_type_ = 2 then
      comm_ := 'Відсотки ';
   elsif p_type_ = 3 then
      comm_ := 'Середні залишки ';
   elsif p_type_ = 4 then
      comm_ := 'Визнані процентні витрати ';
   end if;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   if nbs2_ is null then
     select nbs
     into nbs2_
     from accounts
     where acc = acc_;
   end if;

   if p_type_ in (1, 2) then
       if nbs2_ in ('2601','2625','3652') and k072p_ <> '00' then
          k072_ := k072p_;
       end if;

       if acc1_ is null then
          kolvo_ := 0;
          acc1_:= 0;
          r011_:='0';
          s180_:= Fs180(acc_, SUBSTR(nbs2_,1,1), dat_);
       else
          kolvo_ := 1;

          if s180_ is null then
             s180_ := Fs180(acc_, SUBSTR(nbs2_,1,1), dat_);
          end if;
       end if;

       if country_ = '804' then
          re_ := 1;
       else
          re_ := 0;
       end if;
          
       IF re_=0 THEN
          if dat_ >= dat_Izm3
          then
             if codcagent_ in (2, 4, 6) and k072_ not like 'N_' then
                 if codcagent_ = 2 then
                    k072_ := 'N3';
                 elsif codcagent_ = 4 then
                    k072_ := 'N7';
                 elsif codcagent_ = 6 then
                    k072_ := 'N8';
                 else
                    null;
                 end if;
             end if;
          end if;
          k051_:='00';
          k111_:='00';
       END IF;
   else
       BEGIN
          sql_ := 'SELECT MOD(b.codcagent ,2), nvl(d.k111,''00''), '||
                         'nvl(trim(e.k071),''0''), nvl(trim(e.k072),''00''), '||
                         'nvl(f.k081,''0''), nvl(substr(ltrim(rtrim(b.sed)),1,2),''00''), '||
                         'nvl(b.country,804), nvl(trim(e.d_close),NULL), b.codcagent '||
                  'FROM  customer b, '||
                    '(select K110, K111, decode(D_CLOSE, to_date(''30042007'',''ddmmyyyy''), null, D_CLOSE) D_CLOSE '||
                    'from kl_k110 where d_open <= :dat_ and '||
                       ' (d_close is null or d_close > :dat_ or d_close = to_date(''30042007'',''ddmmyyyy''))) d,
                        (select K080, K081, D_CLOSE
                         from kl_k080
                         where d_open <= :dat_spr_ and
                              (d_close is null or d_close > :dat_spr_)) f,
                        (select K070, K071, K072, D_CLOSE
                         from kl_k070
                         where d_open <= :dat_spr_ and
                              (d_close is null or d_close > :dat_spr_)) e '||
                  'WHERE b.rnk=:rnk_       AND '||
                       ' b.ved=d.k110(+)  AND '||
                       ' b.ise=e.k070(+)  AND '||
                       ' b.fs=f.k080(+) ';

          EXECUTE IMMEDIATE sql_
          INTO re_, k111_, k071_, k072_, k081_, k051_, country_, d_close_, codcagent_
          USING dat_spr_, dat_spr_, dat_spr_, dat_spr_, dat_spr_, dat_spr_, rnk_;

          countryh_ := f_country_hist(rnk_, dat_);

          if countryh_ is not null then
             country_ := countryh_;
          end if;

          if country_ = '804' then
             re_ := 1;
          else
             re_ := 0;
          end if;
       END ;

       if (d_close_ is not null and d_close_ <= Dat_) OR nbs2_ in ('2601','2625','3652') then
          BEGIN
             SELECT NVL(lpad(trim(k072), 2, 'X'), k072_)
                INTO k072_
             FROM specparam
             WHERE acc=acc_ ;
          EXCEPTION WHEN NO_DATA_FOUND THEN
             null;
          END ;
       end if;

       BEGIN
          SELECT acc, NVL(Trim(r011),'0'), NVL(Trim(r013),'0'),
             DECODE(Trim(s180), NULL,
                    Fs180(acc_, SUBSTR(nbs2_,1,1), dat_),
                    s180)
          INTO acc1_, r011_, r013_, s180_
          FROM specparam
          WHERE acc=acc_ ;

          kolvo_ := 1;
       EXCEPTION WHEN NO_DATA_FOUND THEN
          kolvo_ := 0;
          acc1_:= 0;
          r011_:='0';
          s180_:= Fs180(acc_, SUBSTR(nbs2_,1,1), dat_);   --'0';
       END ;
   end if;
--------------------------------------------------------------------------
--   телеграмма НБУ от 23.03.2007 №62-212/324 - 3062
   IF nbs2_ in ('1600','1602','1608','2603','2604',
               '2606','2622','2625','2640',
               '2641','2642','2643','2655',
               '3650','3651','3652','3659') THEN
      s180_:='1';
   END IF;

   IF nbs2_ in ('2600','2605','2650','2655') AND r011_ = '1' THEN
      s180_:='1';
   END IF;

   IF nbs2_ in ('2620','2625')  AND r011_ in ('1', '2') THEN
      s180_:='1';
   END IF;

   IF nbs2_ = '2601' AND r011_ = '4' THEN
      s180_:='1';
   END IF;

   IF nbs2_ = '2602' AND r011_ = '6' THEN
      s180_:='1';
   END IF;

   IF nbs2_ = '2608' AND r011_ in ('5', '7') and s180_ in ('0', '1')
   THEN
      s180_:='B';
   END IF;

--------------------------------------------------------------------------
   BEGIN
      SELECT NVL(s183,'0')
      INTO S183_
      FROM kl_s180
      WHERE s180=s180_;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      s183_:='0';
   END ;

--------------------------------------------------------------------------
   if newnbs.g_state = 0 then
       --   телеграмма НБУ от 23.03.2007 №62-212/324 - 3062
       IF nbs2_ in ('1610','1612','2610','2630','2651') THEN
          s183_:='B';
       END IF;
   end if;

   if nbs2_ = '2630' AND s183_ = '1'
   then
      s183_ := 'B';
   end if;

   comm_ := comm_ || ' s180=' || s180_ || ' s183=' || s183_;
-------------------------------------------------------------------------

   IF re_=0 THEN
      if dat_ >= dat_Izm3
      then
         if codcagent_ in (2, 4, 6) and k072_ not like 'N_' then
             if codcagent_ = 2 then
                k072_ := 'N3';
             elsif codcagent_ = 4 then
                k072_ := 'N7';
             elsif codcagent_ = 6 then
                k072_ := 'N8';
             else
                null;
             end if;
         end if;
      end if;
      k051_:='00';
      k111_:='00';
   END IF;

   IF re_ <> 0 and codcagent_ = 5 and
      SUBSTR(nbs_,1,3) IN ('262','263','365','704') AND
      k072_ not in ('42','43')
   THEN
      k072_:='42';
   END IF;

   IF re_ = 0 and mfo_ = 324805 and SUBSTR(nbs_,1,3) IN ('262','263') AND
      k072_ <> 'N8'
   THEN
      k072_:='N8';
   END IF;

   IF SUBSTR(nbs_,1,3) IN ('262','263','365','704') AND k072_='42' THEN
      k051_:='00';
      k111_:='00';
   END IF;

   IF nbs_ like '7%' THEN
      r011_:='0';
   END IF;

   dk_:=(case when nbs_ like '7%' then '5' else Iif_N(se_,0,'1','2','2') end);

   -- визначаємо, повинен чи н? рахунок мати процентну ставку в файл?
   kol_pr_ := 0;

   if Dat_ >= dat_izm1 then
      select count(*)
         into kol_pr_
      from kod_d6_1
      where r020 = nbs_ and
            t020 = dk_ and
            nvl(D_CLOSE,dat_) >= dat_;
   end if;

   if nbs_ = '2615' then
      nbs_ := '2610';
   elsif nbs_ = '2635' then
      nbs_ := '2630';
   elsif nbs_ = '2652' then
      nbs_ := '2651';
   else
      null;
   end if;

   if nbs_ in ('2610','2630') and r011_ = '0'
   then
      r011_ := '1';
   end if;
   if nbs_ = '2651'
   then
      r011_ := '4';
   end if;

   if nbs_ = '2608' and r011_ = '0'
   then
      begin
         select NVL(sp.r011, '1')
            into r011_
         from int_accn i, specparam sp
         where i.acra = acc_
           and i.id = 1
           and i.acc = sp.acc
           and rownum  = 1;
      exception when no_data_found then
         null;
      end;
   end if;

   --- c 31.08.2007 вместо кода K081 будет формироваться код '9'
   if dat_ >= to_date('28082007','ddmmyyyy') then
      kodp_:= dk_ || nbs_ || r011_ || k111_ || k072_ || '9' || s183_ ||
              TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
   else
      kodp_:= dk_ || nbs_ || r011_ || k111_ || k072_ || k081_ || s183_ ||
              TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
   end if;

   if nbs_ in ('2600', '2605', '2620', '2625', '2650', '2655') and
      r011_ not in ('1', '2', '3')
   then
      kodp_:= dk_ || nbs_ || '1' || k111_ || k072_ || '9' || s183_ ||
              TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
   end if;

   if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
      kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
   end if;

   if dat_ > dat_izm2 then
      kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                               when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                               when p_type_ = '4' then '4' -- визнані процентні витрати
                               else ''
                          end);
   end if;

   kodp1_ := kodp_;

   -- только депозит Арсенал для 2620
   if nbs_='2620' and blkd_ = 0 and mfou_ = 300465 and ob22_='23'
   then

      BEGIN
         select limit
            into lim_
         from dpt_deposit_clos
         where acc=acc_
           and action_id = 0;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         lim_ := 0;
      END;

      lim_ := GL.P_ICURVAL(kv_, lim_, Dat_);

      kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || s183_ ||
              TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');

      if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
         kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
      end if;

      if dat_ > dat_izm2 then
         kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                   when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                   when p_type_ = '4' then '4' -- визнані процентні витрати
                                   else ''
                              end);
      end if;

      kodp1_ := kodp_;

      if dat_ >= dat_izm1 then
         kodp1_ := '1' || kodp_;
      end if;

      if ABS(se_) < ABS(lim_) and ABS(lim_) != 0 then
         znap_:= TO_CHAR(ABS(se_)) ;
         se_ := 0;

         p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
             nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

         -- процентна ставка i сума*процентну ставку код 2,3
         if dat_ >= dat_izm1 and dat_ <= dat_izm2 and kol_pr_ > 0 then
            kodp1_ := '2' || kodp_;
            znap_ := LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_,isp_,rnk_,acc_, comm_, tobo_, mdate_);

            kodp1_ := '3' || kodp_;
            znap_ := TO_CHAR (ABS(se_)*ROUND(spcnt_,4));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

            kodp1_ := '4' || kodp_;
            if spcnt_ = 0 then
               znap_ := '0';
            else
               znap_ := TO_CHAR (ABS(se_));
            end if;

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);
         end if;
      end if;

      if ABS(se_) >= ABS(lim_) and ABS(lim_) != 0 then
         znap_:= TO_CHAR(ABS(lim_)) ;
         se_ := se_ - lim_;

         p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
            nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

         -- процентна ставка ? сума*процентну ставку код 2,3
         if dat_ >= dat_izm1 and dat_ <= dat_izm2 and kol_pr_ > 0 then
            kodp1_ := '2' || kodp_;
            znap_ := LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_,isp_,rnk_,acc_, comm_, tobo_, mdate_);

            kodp1_ := '3' || kodp_;
            znap_ := TO_CHAR (ABS(lim_)*ROUND(spcnt_,4));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

            kodp1_ := '4' || kodp_;
            if spcnt_ = 0 then
               znap_ := '0';
            else
               znap_ := TO_CHAR (ABS(lim_));
            end if;

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);
         end if;

         -- 27.07.2010 вместо переменной S183_ заносим значение '1'
         kodp_:= dk_ || nbs_ || '2' || k111_ || k072_ || '9' || '1' ||
                 TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
         if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
            kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
         end if;

         if dat_ > dat_izm2 then
            kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                     when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                     when p_type_ = '4' then '4' -- визнані процентні витрати
                                     else ''
                                end);
         end if;

         kodp1_ := kodp_;
      end if;

   end if;

   if  (nbs_='2600' and r013_='7') or (nbs_='2650' and r013_='8')  --or  --(nbs_='2605' and r013_='1') or
       --(nbs_='2620' and r013_='1' and ob22_ != '23')
   then
      lim_ := GL.P_ICURVAL(kv_, lim_, Dat_);

      if ABS(se_) < ABS(lim_) and abs(lim_) != 0
      then
         kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || s183_ ||
                 TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
         if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
            kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
         end if;

         if dat_ > dat_izm2 then
            kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                     when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                     when p_type_ = '4' then '4' -- визнані процентні витрати
                                     else ''
                                end);
         end if;

         kodp1_ := kodp_;

         if dat_ >= dat_izm1 then
            kodp1_ := '1' || kodp_;
         end if;

         znap_:= TO_CHAR(ABS(se_)) ;

         p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
            nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

         -- процентна ставка ? сума*процентну ставку код 2,3
         if dat_ >= dat_izm1 and dat_ <= dat_izm2 and kol_pr_ > 0 then
            kodp1_ := '2' || kodp_;
            znap_ := LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_,isp_,rnk_,acc_, comm_, tobo_, mdate_);

            kodp1_ := '3' || kodp_;
            znap_ := TO_CHAR (ABS(se_)*ROUND(spcnt_,4));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

            kodp1_ := '4' || kodp_;
            if spcnt_ = 0 then
               znap_ := '0';
            else
               znap_ := TO_CHAR (ABS(se_));
            end if;

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);
         end if;

         se_ := 0;
      end if;

      if ABS(se_) >= ABS(lim_) and abs(lim_) != 0
      then

         kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || s183_ ||
                 TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
         if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
            kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
         end if;

         if dat_ > dat_izm2 then
            kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                     when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                     when p_type_ = '4' then '4' -- визнані процентні витрати
                                     else ''
                                end);
         end if;

         kodp1_ := kodp_;

         if dat_ >= dat_izm1 then
            kodp1_ := '1' || kodp_;
         end if;

         znap_:= TO_CHAR(ABS(lim_)) ;
         se_ := se_ + lim_;

         p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
            nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

         -- процентна ставка ? сума*процентну ставку код 2,3
         if dat_ >= dat_izm1 and dat_ <= dat_izm2 and kol_pr_ > 0 then
            kodp1_ := '2' || kodp_;
            znap_ := LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_,isp_,rnk_,acc_, comm_, tobo_, mdate_);

            kodp1_ := '3' || kodp_;
            znap_ := TO_CHAR (ABS(lim_)*ROUND(spcnt_,4));

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

            kodp1_ := '4' || kodp_;
            if spcnt_ = 0 then
               znap_ := '0';
            else
               znap_ := TO_CHAR (ABS(lim_));
            end if;

            p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);
         end if;

         -- 27.07.2010 вместо переменной S183_ заносим значение '1'
         kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                 TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');

         if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
            kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
         end if;

         if dat_ > dat_izm2 then
            kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                     when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                     when p_type_ = '4' then '4' -- визнані процентні витрати
                                     else ''
                                end);
         end if;

         kodp1_ := kodp_;

         if dat_ >= dat_izm1 then
            kodp1_ := '1' || kodp_;
         end if;

      end if;

      if ABS(se_) >= ABS(lim_) and abs(lim_) = 0
      then
         -- параметр R011 до 13.12.2010 устанавливали в "1" после консультаций будем формировать "2"
         kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || s183_ ||
                 TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');

         if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
            kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
         end if;

         if dat_ > dat_izm2 then
            kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                     when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                     when p_type_ = '4' then '4' -- визнані процентні витрати
                                     else ''
                                end);
         end if;

         -- изменяем параметр R011 с "1" на "9" для S183_='1'
         -- c 13.12.2010 не будем изменять параметр R011 c "1" на "9" т.к. парамтер R011="2"
         -- a будем изменять парамтер S183 с любого значения на "1"
         if s183_ != '1' then
            kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                    TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');

            if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
               kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
            end if;

            if dat_ > dat_izm2 then
                kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                         when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                         when p_type_ = '4' then '4' -- визнані процентні витрати
                                         else ''
                                    end);
            end if;

         end if;

         kodp1_ := kodp_;

         if dat_ >= dat_izm1 then
            kodp1_ := '1' || kodp_;
         end if;
      end if;
   end if;

   if nbs_ in ('2608', '2628', '2658')
   then
      IF (nbs_ = '2608' and r011_ in ('1','4','6','8','9','A')) OR
         (nbs_ = '2628' and r011_ in ('1','2','4'))             OR
         (nbs_ = '2658' and r011_ in ('1','5'))
      then
         kodp_:= dk_ || nbs_ || r011_ || k111_ || k072_ || '9' || '1' ||
                 TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');

         if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
            kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
         end if;

         if dat_ > dat_izm2 then
            kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                     when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                     when p_type_ = '4' then '4' -- визнані процентні витрати
                                     else ''
                                end);
         end if;

         kodp1_ := kodp_;

         if dat_ >= dat_izm1 then
            kodp1_ := '1' || kodp_;
         end if;
      END IF;

      begin
        select acc2
        into acc2_
        from (select acra acc, acc acc2, DENSE_RANK() over (partition by acra order by acc) rwn
              FROM int_accn
              WHERE ID = 1 and
                    (acra, acr_dat) in (select acra, max(acr_dat) acr_dat
                                        FROM int_accn
                                        WHERE ID = 1 and
                                            nvl(trim(acra),0)<>0 and
                                            acra = acc_
                                        group by acra))
        where rwn = 1;
      exception
        when no_data_found then
            acc2_ := null;
      end;

      acc1_ := acc2_;

      koef_ := 1;

      if acc1_ is not null
      then
         select ABS(a.lim), a.nbs, NVL(p.r013,'0'), NVL(p.r011,'0')
            into lim_, nbs1_, r013_1, r011_1
         from accounts a, specparam p
         where a.acc=acc1_
           and a.acc=p.acc(+);

         if ((nbs1_='2600' and r013_1='7') or (nbs1_='2650' and r013_1='8') or
             (nbs1_ in ('2605','2620') and r013_1='1') ) and
             (mfo_ <> 300120 or mfo_ = 300120 and r011_1 in ('1', '2'))
         then
            sn1_ := fostiq_snp(acc1_, f_snap_dati(dat_, 2));

            lim_ := GL.P_ICURVAL(kv_, lim_, Dat_);

            if sn1_ <> 0 then
               koef_ := ABS(lim_/sn1_);
            end if;

            if abs(sn1_) < abs(lim_) and abs(lim_) != 0 then
               if nbs_ = '2608' then
                  kodp_:= dk_ || nbs_ || '7' || k111_ || k072_ || '9' || s183_ ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2628' then
                  kodp_:= dk_ || nbs_ || '5' || k111_ || k072_ || '9' || s183_ ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2658' then
                  kodp_:= dk_ || nbs_ || '6' || k111_ || k072_ || '9' || s183_ ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               else
                  null;
               end if;

               if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
                  kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
               end if;

               if dat_ > dat_izm2 then
                  kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                           when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                           when p_type_ = '4' then '4' -- визнані процентні витрати
                                           else ''
                                      end);
               end if;

               znap_:= TO_CHAR(ABS(se_)) ;
               se_ := 0;

               kodp1_ := kodp_;

               if dat_ >= dat_izm1 then
                  kodp1_ := '1' || kodp_;
               end if;

               p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                    nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);
            end if;

            if abs(sn1_) >= abs(lim_) and abs(lim_) != 0 then
               if nbs_ = '2608' then
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || s183_ ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2628' then
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || s183_ ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2658' then
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || s183_ ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               else
                  null;
               end if;

               if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
                  kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
               end if;

               if dat_ > dat_izm2 then
                  kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                           when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                           when p_type_ = '4' then '4' -- визнані процентні витрати
                                           else ''
                                      end);
               end if;

               kodp1_ := kodp_;

               if dat_ >= dat_izm1 then
                  kodp1_ := '1' || kodp_;
               end if;

               znap_:= TO_CHAR(ROUND(se_*koef_,0)) ;
               se_ := se_ - to_number(znap_);

               p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
                    nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

               -- 27.07.2010 вместо переменной S183_ заносим значение '1'
               if nbs_ = '2608' then
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2628' then
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2658' then
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               else
                  null;
               end if;

               if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
                  kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
               end if;

               if dat_ > dat_izm2 then
                  kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                           when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                           when p_type_ = '4' then '4' -- визнані процентні витрати
                                           else ''
                                      end);
               end if;

               kodp1_ := kodp_;

               if dat_ >= dat_izm1 then
                  kodp1_ := '1' || kodp_;
               end if;
            end if;

            if abs(sn1_) >= abs(lim_) and abs(lim_) = 0 then
               if nbs_ = '2608' then
                  -- параметр R011 до 13.12.2010 устанавливали в "7" после консультаций будем формировать "8"
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2628' then
                  -- параметр R011 до 13.12.2010 устанавливали в "5" после консультаций будем формировать "6"
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               elsif nbs_ = '2658' then
                  -- параметр R011 до 13.12.2010 устанавливали в "6" после консультаций будем формировать "7"
                  kodp_:= dk_ || nbs_ || '3' || k111_ || k072_ || '9' || '1' ||
                          TO_CHAR(2-re_) || k051_ || LPAD(kv_, 3, '0') || LPAD(country_, 3, '0');
               else
                  null;
               end if;

               if dat_ >= to_date('01082011','ddmmyyyy') and dat_ <= dat_izm2 then
                  kodp_ :=  kodp_ || iif_n(spcnt_, 0, '1', '0', '1') ;
               end if;

               if dat_ > dat_izm2 then
                  kodp_ :=  kodp_ || (case when p_type_ = '1' then '2' -- звичайні залишки
                                           when p_type_ in ('2', '3') then '3' -- середні залишки та розрахована % ставка
                                           when p_type_ = '4' then '4' -- визнані процентні витрати
                                           else ''
                                      end);
               end if;

               kodp1_ := kodp_;

               if dat_ >= dat_izm1 then
                  kodp1_ := '1' || kodp_;
               end if;

            end if;
         end if;
      end if;

   end if;

   if se_ <> 0 then
      kodp1_ := kodp_;
      if dat_ >= dat_izm1 then
         kodp1_ := '1' || kodp_;
      end if;

      znap_:= TO_CHAR(ABS(se_)) ;

      p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
            nbuc_,isp_,rnk_,acc_, comm_, tobo_, mdate_);

      -- процентна ставка ? сума*процентну ставку код 2,3
      if dat_ >= dat_izm1 and dat_ <= dat_izm2 and kol_pr_ > 0 then
         kodp1_ := '2' || kodp_;
         znap_ := LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_));

         p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
            nbuc_,isp_,rnk_,acc_, comm_, tobo_, mdate_);

         kodp1_ := '3' || kodp_;
         znap_ := TO_CHAR (ABS(se_)*ROUND(spcnt_,4));

         p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
            nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);

         kodp1_ := '4' || kodp_;

         if spcnt_ = 0 then
            znap_ := '0';
         else
            znap_ := TO_CHAR (ABS(se_));
         end if;

         p_add_rec(s_rnbu_record.nextval, userid_, nls_, kv_, data_, kodp1_, znap_,
            nbuc_, isp_, rnk_, acc_, comm_, tobo_, mdate_);
      end if;
   end if;
END;
------------------------------------------------------------------
BEGIN
    commit;

    EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
    -------------------------------------------------------------------
    logger.info ('P_FD6_NN: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));
    -------------------------------------------------------------------
    userid_ := user_id;
    EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FD5_PROC';
    EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FD5_DOCS';

    -------------------------------------------------------------------
    -- определение кода МФО или кода области для выбранного файла и схемы
    P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

    -- вираховуємо зв_тну дату "станом на" для класиф_катора
    dat_kl_ := add_months(trunc(dat_, 'mm'), 1);

    if prnk_ is null then
        sql_acc_ := ' SELECT  /*+ parallel(a, 8) */ a.ACC, a.KF, a.NLS, a.KV, a.BRANCH, a.NLSALT, a.NBS, a.NBS2, a.DAOS, a.DAPP, 
                        a.ISP, a.NMS, a.LIM, a.OSTB, a.OSTC, a.OSTF, a.OSTQ, a.DOS, a.KOS, a.DOSQ, a.KOSQ, a.PAP, a.TIP, a.VID, 
                        a.TRCN, a.MDATE, a.DAZS, a.SEC, a.ACCC, a.BLKD, a.BLKK, a.POS, a.SECI, a.SECO, a.GRP, a.OSTX, a.RNK, 
                        a.NOTIFIER_REF, a.TOBO, a.BDATE, a.OPT, a.OB22, a.DAPPQ, a.SEND_SMS, a.DAT_ALT 
                      FROM ACCOUNTS a 
                      where nvl(a.nbs, SUBSTR (a.nls, 1, 4)) in (';
        sql_acc_ := sql_acc_ || 'select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''D6'' and r020 not like ''7%'' ';
        sql_acc_ := sql_acc_ || 'and d_open<=to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'') ';
        sql_acc_ := sql_acc_ || 'and (d_close is null or d_close>to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy''))) ';

        if FL_D8_ = '8' then
           sql_acc_ := sql_acc_ || ' and a.acc not in (SELECT GEN_ACC FROM V_DPU_REL_ACC_ALL) ';
           sql_acc_ := sql_acc_ || ' UNION ALL ';
           sql_acc_ := sql_acc_ || ' SELECT  /*+ parallel(v, 8) */ s.ACC, s.KF, s.NLS, s.KV, s.BRANCH, s.NLSALT, '||
                            'substr(s.NLSALT,1,4) NBS, s.NBS2, s.DAOS, s.DAPP, s.ISP, s.NMS,
                             s.LIM, s.OSTB, s.OSTC, s.OSTF, s.OSTQ, s.DOS, s.KOS, s.DOSQ, s.KOSQ, s.PAP, s.TIP, s.VID, s.TRCN,
                             s.MDATE, s.DAZS, s.SEC, s.ACCC, s.BLKD, s.BLKK, s.POS, s.SECI, s.SECO, s.GRP, s.OSTX, s.RNK,
                             s.NOTIFIER_REF, s.TOBO, s.BDATE, s.OPT, s.OB22, s.DAPPQ, s.SEND_SMS, s.DAT_ALT
                     FROM ACCOUNTS a, V_DPU_REL_ACC_ALL v, accounts s
                     where a.nbs IN (
                        SELECT r020
                          FROM kod_r020
                         WHERE a010 = ''D6''
                           AND trim(prem) = ''КБ''
                           AND d_open between TO_DATE (''01011997'', ''ddmmyyyy'') and
                               to_date('''||to_char(dat_kl_,'ddmmyyyy')||''',''ddmmyyyy'')
                           and (d_close is null or
                                d_close > to_date('''||to_char(dat_kl_,'ddmmyyyy')||''',''ddmmyyyy''))) and
                           a.acc = v.GEN_ACC and
                           v.DEP_ACC = s.acc ';
        end if;

        ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);
    else
        sql_acc_ := 'select ACC, KF, NLS, KV, BRANCH, NLSALT, NBS, NBS2, DAOS, DAPP, ISP, NMS, 
                LIM, OSTB, OSTC, OSTF, OSTQ, DOS, KOS, DOSQ, KOSQ, PAP, TIP, VID, TRCN, MDATE, DAZS, 
                SEC, ACCC, BLKD, BLKK, POS, SECI, SECO, GRP, OSTX, RNK, NOTIFIER_REF, TOBO, BDATE, OPT, 
                OB22, DAPPQ, SEND_SMS, DAT_ALT 
            from accounts where rnk = '||to_char(prnk_)||' and nbs in ';
        sql_acc_ := sql_acc_ || '(select r020 from kod_r020 where trim(prem)=''КБ'' and a010=''D6'' and r020 not like ''7%'' ';
        sql_acc_ := sql_acc_ || 'and d_open<=to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy'') ';
        sql_acc_ := sql_acc_ || 'and (d_close is null or d_close>to_date('''||to_char(dat_kl_, 'ddmmyyyy')||''',''ddmmyyyy''))) ';

        ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);
    end if;

    mfo_:=F_Ourmfo();

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

    logger.info ('P_FD6_NN: Etap1 for datf = '||to_char(dat_, 'dd/mm/yyyy'));
    ----------------------------------------------------------------------------
    -- все счета + корректирующие проводки и по счетам после отчетной даты
    cursor_sql := 'select b.rnk, b.acc, b.nls, b.kv, b.fdat, b.nbs, b.ost, b.ostq,
                        b.dos96, b.kos96, b.dosq96, b.kosq96, b.isp, b.lim, b.blkd,
                        b.blkk, b.ob22, b.tobo, b.nms, b.prc, b.mdate,
                        b.codc, b.sed, b.country,
                        nvl(d.k111,''00'') k111, nvl(e.k072,''00'') k072, nvl(g.k081,''0'') k081,
                        nvl(trim(p.k072), ''00'') k072p, p.acc acc1, NVL(Trim(p.r011),''0'') r011,
                        NVL(Trim(p.r013),''0'') r013, Trim(p.s180) s180, null acc2, b.codcagent
                    from (
                       SELECT  /*+ ordered */
                               a.rnk, a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ost, a.ostq,
                               a.dos96, a.kos96, a.dosq96, a.kosq96, s.isp, NVL(s.lim,0) lim,
                               NVL(s.blkd,0) blkd, NVL(s.blkk,0) blkk, NVL(s.ob22,''00'') ob22, s.tobo, s.nms,
                               0 prc, s.mdate, c.ved k110, c.ise k070, c.fs k080, MOD(c.codcagent ,2) codc,
                               nvl(substr(ltrim(rtrim(c.sed)),1,2),''00'') sed,
                               nvl(c.country,804) country, c.codcagent codcagent
                       FROM otcn_saldo a, accounts s, customer c
                       WHERE a.acc=s.acc
                         AND ((a.nbs NOT IN (''1500'',''2600'',''2605'',''2620'',''2625'',''2650'',''2655'') AND
                               a.ost-a.dos96+a.kos96<>0) OR
                              (a.nbs IN (''1500'',''2600'',''2605'',''2620'',''2625'',''2650'',''2655'') AND
                               a.ost-a.dos96+a.kos96>0))
                         and a.rnk = c.rnk) b
                    left outer join specparam p
                    on (b.acc = p.acc)
                    left outer join
                    (select K110, K111, decode(D_CLOSE, to_date(''30042007'',''ddmmyyyy''), null, D_CLOSE) D_CLOSE
                     from kl_k110
                     where d_open <= :dat_spr_ and
                          (d_close is null or
                           d_close > :dat_spr_ or
                           d_close = to_date(''30042007'',''ddmmyyyy''))) d
                    on (b.k110 = d.k110)
                    left outer join
                    (select K070, K072, D_CLOSE
                     from kl_k070
                     where d_open <= :dat_spr_ and
                          (d_close is null or d_close > :dat_spr_)) e
                    on (b.k070 = e.k070)
                    left outer join
                    (select K080, K081, D_CLOSE
                     from kl_k080
                     where d_open <= :dat_spr_ and
                          (d_close is null or d_close > :dat_spr_)) g
                    on (b.k080 = g.k080)
                    ORDER BY 6';

    OPEN saldo FOR cursor_sql USING dat_spr_, dat_spr_, dat_spr_, dat_spr_,
            dat_spr_, dat_spr_;
    LOOP
       FETCH saldo BULK COLLECT INTO l_rec_t LIMIT 100000;
       EXIT WHEN l_rec_t.count = 0;

       for i in 1..l_rec_t.count loop
           rnk_      := l_rec_t(i).rnk_;
           acc_      := l_rec_t(i).acc_;
           nls_      := l_rec_t(i).nls_;
           kv_       := l_rec_t(i).kv_;
           data_     := l_rec_t(i).data_;
           nbs_      := l_rec_t(i).nbs_;
           Ostn_     := l_rec_t(i).Ostn_;
           Ostq_     := l_rec_t(i).Ostq_;
           Dos96_    := l_rec_t(i).Dos96_;
           Kos96_    := l_rec_t(i).Kos96_;
           Dosq96_   := l_rec_t(i).Dosq96_;
           Kosq96_   := l_rec_t(i).Kosq96_;
           isp_      := l_rec_t(i).isp_;
           lim_      := l_rec_t(i).lim_;
           blkd_     := l_rec_t(i).blkd_;
           blkk_     := l_rec_t(i).blkk_;
           ob22_     := l_rec_t(i).ob22_;
           tobo_     := l_rec_t(i).tobo_;
           nms_      := l_rec_t(i).nms_;
           spcnt_    := l_rec_t(i).spcnt_;
           mdate_    := l_rec_t(i).mdate_;
           re_       := l_rec_t(i).re_;
           k051_     := l_rec_t(i).k051_;
           country_  := l_rec_t(i).country_;
           k111_     := l_rec_t(i).k111_;
           k072_     := l_rec_t(i).k072_;
           k081_     := l_rec_t(i).k081_;
           k072p_    := l_rec_t(i).k072p_;
           acc1_     := l_rec_t(i).acc1_;
           r011_     := l_rec_t(i).r011_;
           r013_     := l_rec_t(i).r013_;
           s180_     := l_rec_t(i).s180_;
           acc2_     := l_rec_t(i).acc2_;
           codcagent_  := l_rec_t(i).codcagent_;

           comm_ := '';

           if dat_ <= dat_izm2 then
              spcnt_ := acrn_otc.fproc (acc_, dat_);
           end if;

           IF kv_ <> 980 THEN
              se_:=Ostq_-Dosq96_+Kosq96_;
           ELSE
              se_:=Ostn_-Dos96_+Kos96_;
           END IF;

           IF se_<>0 THEN
              comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
              p_obrab_data(1);
           END IF;
       END LOOP;

       l_rec_t.delete;
    END LOOP;

    CLOSE saldo;

    FORALL i IN 1 .. l_rnbu_trace.COUNT
         insert /*+ append */  into rnbu_trace values l_rnbu_trace(i);

    l_rnbu_trace.delete;
    
    -- вирівнювання з 02 файлом
    for k in (select b.nbs, b.kv, 2-MOD(c.codcagent ,2) REZ, 
                           sum(a.Ost-a.crdos+a.crkos) Ostn, 
                           sum(a.Ostq-a.crdosq+a.crkosq) Ostq
                    from agg_monbals a, accounts b, customer c, specparam s
                    where a.fdat= TRUNC(DAT_, 'mm')
                      and a.acc = b.acc
                      and b.nbs in ('2600','2608','2610','2615','2618','2651','2652','2658') 
                      and a.rnk = c.rnk
                      and a.acc = s.acc(+)
                      and (a.Ost-a.crdos+a.crkos <> 0  or a.Ostq-a.crdosq+a.crkosq<>0)
                    group by b.nbs, b.kv, 2-MOD(c.codcagent ,2)
                    order by 1,2)
    loop
         IF k.kv <> 980 THEN
            se_:= k.Ostq;
         ELSE
            se_:= k.Ostn;
         END IF;
             
         select NVL(sum(to_number(r.znap)),0)
            into sn_
         from rnbu_trace r
         where r.kodp like '__' || k.nbs || '_______' || k.rez || '__' || k.kv || '___2'
               and substr(r.kodp,1,1) in ('1','2');

         -- формируем разницу остатков
         if se_ <> sn_ and ABS(se_ - sn_) <= 100 then
            znap_ := to_char(se_ - sn_);
            comm_ := 'Рiзниця залишкiв по бал.рах. ' || k.nbs || ' валюта = ' ||
                     lpad(to_char(k.kv),3,'0') || 
                     ' резидентність = ' || to_char(k.rez) ||
                     ' залишок по балансу = ' ||to_char(ABS(se_)) ||
                     ' сума в файлi =  ' || to_char(sn_);
          
            BEGIN
               select r.recid
                  INTO recid_
               from rnbu_trace r
               where r.kodp like '__'||k.nbs || '_______' || k.rez || '__' || k.kv || '___2'
                 and substr(r.kodp,1,1) in ('1', '2')
                 and rownum = 1;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               recid_ := null;
               kodp_:= null;
            END;

            if recid_ is not null then
               select kodp, nbuc
               into kodp_, nbuc_
               from rnbu_trace
               where recid = recid_;

               INSERT INTO rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, comm)
               VALUES
                   (k.nbs, k.kv, dat_, kodp_, znap_, nbuc_, comm_);
            end if;
         end if;    
    end loop;                        

    logger.info ('P_FD6_NN: Etap2 for datf = '||to_char(dat_, 'dd/mm/yyyy'));
    ------------------------------------------------------------------------------
    mdate_ := null;

    if dat_ > dat_izm2 then
       declare
           datp_       date;
           datr1_      date;
           datr2_      date;
           dat_kor_    date;

           dob_        number;
           dobp_       number;

           acca_       number;
           nlsa_       varchar2(15);
           sumh_       number;
           sumh_all_   number;
           sump_       number;
           zal_dob_    number;

           fl_kr_      number := 0;
           fl_         number := 0;
           fl_pob_     number := 0;
       begin
           dat1_ := trunc(dat_, 'mm');
           dat2_ := last_day(dat_);

           kol_ := dat2_ - dat1_ + 1;

           if MOD (TO_NUMBER (TO_CHAR (dat_, 'YYYY')), 4) = 0 then
              b_yea := 366; -- для високосних років
           else
              b_yea := 365;
           end if;

           -- дата закінчення періоду кориуючих проводок
           dat_kor_ := dat2_ + 7;

           select max(fdat)
           into datp_
           from fdat
           where fdat < dat1_;

           select min(fdat), max(fdat)
           into datr1_, datr2_
           from fdat
           where fdat between dat1_ and dat2_;

           -- визнані процентні доходи по нарахуванню відсотків та середні залишик по кредитах
           insert into OTCN_FD5_PROC (ACC, NLS, KV, RNK, ISP, ACCC, TIP, DOS,
                IACC, SUMH, CNT, RNUM, SH)
           select acc, nls, kv, rnk, isp, accc, tip, 0, iacc, sumh,
                count(z.acc) over (partition by z.acc) cnt,
                DENSE_RANK() over (partition by z.acc order by z.iacc) rnum,
                sum(z.sumh) over (partition by z.acc) sh
           from (
               select acc, nls, kv, rnk, isp, accc, tip, 0, iacc, 0 sumh
               from (select /*+ PARALLEL(a, 8) */
                        a.acc, a.nls, a.kv, a.rnk, a.isp, a.accc, a.tip, i.acc iacc
                     from accounts a, int_accn i
                     where a.nbs in ('1608','1618','2518','2528','2538','2548','2558','2568','2618','2608','2628','2638','2658') and
                           (prnk_ is null or a.rnk = prnk_) and
                           a.acc = i.acra and
                           i.id = 1 and
                           i.acr_dat >= datr1_ and 
                           exists (select 1
                                   from saldoa s
                                   where s.fdat between datr1_ and dat_kor_ and
                                         s.acc = a.acc and
                                         s.kos <> 0))
                where acc <> iacc) z
           where NOT EXISTS (SELECT 1 FROM V_DPU_REL_ACC_ALL WHERE GEN_ACC = Z.ACC);

           -- для рахунків, у яких нарахування % без відкриття віідсоткового рахунку
           insert into OTCN_FD5_PROC (ACC, NLS, KV, RNK, ISP, ACCC, TIP, DOS,
                IACC, SUMH, CNT, RNUM, SH)
           select acc, nls, kv, rnk, isp, accc, tip, 0, iacc, sumh,
                count(z.acc) over (partition by z.acc) cnt,
                DENSE_RANK() over (partition by z.acc order by z.iacc) rnum,
                sum(z.sumh) over (partition by z.acc) sh
           from (
               select acc, nls, kv, rnk, isp, accc, tip, 0, iacc, 0 sumh
               from (select a.acc, a.nls, a.kv, a.rnk, i.freq isp, a.accc, a.tip, i.acc iacc
                     from accounts a, int_accn i
                     where a.nbs in (select r020
                                     from kod_r020
                                     where a010 = 'D6' and
                                           (d_close is null or
                                            d_close > dat_kl_)
                                     ) and
                           a.acc not in (select acc from OTCN_FD5_PROC) and
                           (prnk_ is null or a.rnk = prnk_) and
                           a.acc = i.acra and
                           i.id = 1 and
                           i.acr_dat >= datr1_ and 
                           exists (select 1
                                   from saldoa s
                                   where s.fdat between datr1_ and dat_kor_ and
                                         s.acc = a.acc and
                                         s.kos <> 0))) z;

           insert into OTCN_FD5_DOCS (ACC, NBS, REF, FDAT, S, NAZN)
           select /*+ ordered */
            o.acc, decode(r.dk, 1, substr(r.nlsa,1,4), substr(r.nlsb,1,4)) nbs,
            o.REF, o.fdat, nvl(o.s, 0) s, r.NAZN
           from saldoa s, opldok o, opldok p, accounts a, oper r
           where s.fdat between datr1_ and dat_kor_ and
               s.acc in (select acc from OTCN_FD5_PROC where kv = 980) and
               s.kos > 0 AND
               s.fdat = o.fdat and
               s.acc = o.acc and
               o.dk = 1 and
               o.ref = p.ref and
               o.stmt = p.stmt and
               p.dk = 0 and
               p.acc = a.acc and
               a.nbs in ('7010','7011','7012','7013','7020','7021','7028','7030','7040','7041','7070','7071') and
               o.tt <> 'BAK' and
               o.ref = r.ref and
               r.sos = 5 and
               (r.vob <> 96 and o.fdat <= dat2_ or
                r.vob = 96 and  o.fdat > dat2_);

           insert into OTCN_FD5_DOCS (ACC, NBS, REF, FDAT, S, NAZN)
           select /*+ ordered*/
                o.acc, decode(r.dk, 1, substr(r.nlsa,1,4), substr(r.nlsb,1,4)) nbs, o.REF, o.fdat,
                decode(r.kv, 980, r.s, r.s2), r.NAZN
           from saldoa s, opldok o, opldok p, accounts a, oper r
           where s.fdat between datr1_ and dat_kor_ and
               s.acc in (select acc from OTCN_FD5_PROC where kv <> 980) and
               s.kos > 0 AND
               s.fdat = o.fdat and
               s.acc = o.acc and
               o.dk = 1 and
               o.ref = p.ref and
               o.stmt = p.stmt and
               p.dk = 0 and
               p.acc = a.acc and
               a.nbs = '3800' and
               o.tt <> 'BAK' and
               o.ref = r.ref and
               r.sos = 5 and
               (r.vob <> 96 and o.fdat <= dat2_ or
                r.vob = 96 and  o.fdat > dat2_) and
               exists (select 1
                       from opldok o1, opldok p1, accounts a1
                       where o1.ref = o.ref and
                            o1.ref = p1.ref and
                            p1.acc = a1.acc and
                            p1.dk = 0 and
                            a1.nbs in ('7010','7011','7012','7013','7020','7021',
                                '7028','7030','7040','7041','7070','7071'));

           logger.info ('P_FD6_NN: Etap3 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

           -- вибираэмо рахунки, де один процентний рахунок выдповыдаэ рахунку активу
           for k in (select *
                     from (select /*+parallel(b, 8) */
                                distinct b.ACC, b.NLS, b.KV, b.RNK, b.ISP, b.ACCC, b.TIP, b.DOS, b.IACC, b.ND,
                                ot_sumh (b.iacc, datr1_, datr2_, 1, dat_, b.kv) SUMH,
                                a.acc acca, a.nls nlsa, a.kv kva, a.isp ispa, a.rnk rnka, a.tip tipa, a.accc accca,
                                r.nd nda, r.kodp kodpa, c.kodp, nvl(c.nbuc, r.nbuc) nbuc,
                                count (*) over (partition by r.acc, substr(r.kodp,1,6)|| substr(r.kodp,8,4) || substr(r.kodp,13)) cnt,
                                DENSE_RANK() over (partition by r.acc, substr(r.kodp,1,6)|| substr(r.kodp,8,4) || substr(r.kodp,13) order by r.kodp) rnum
                             from OTCN_FD5_PROC b, rnbu_trace c, accounts a, rnbu_trace r
                             where b.CNT = 1 and
                                b.acc = c.acc(+) and
                                nvl(c.kodp(+), '__'||substr(b.nls,1,4)||'2') like '__'||substr(b.nls,1,4)||'%2' and
                                b.iacc = a.acc and
                                a.acc = r.acc(+) and
                                nvl(r.kodp, '__'||substr(a.nls,1,4)||'2') like '__'||substr(a.nls,1,4)||'%2')
                      where cnt = 1 or cnt > 1 and rnum = 1)
           loop
              fl_ := 0;

              if k.nbuc is null then
                 IF typ_>0 THEN
                    nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
                 ELSE
                    nbuc_ := nbuc1_;
                 END IF;
              else
                 nbuc_ := k.nbuc;
              end if;

              if k.sumh <> 0 then
                  for k1 in (select nbs, dob
                             from (
                                 select nbs, nvl(sum(s), 0) dob
                                 from OTCN_FD5_DOCS
                                 where acc = k.acc and
                                    nbs in ('7010','7011','7012','7013','7020','7021',
                                            '7028','7030','7040','7041','7070','7071')
                                 group by nbs
                                ))
                  loop
                      if k1.dob <> 0 then
                         fl_ := 1;

                          if k.kodp is not null then
                             kodp_ := '15'||k1.nbs||'0'||substr(k.kodp, 8, 9)||'980'||substr(k.kodp, 20, 3)||'4';
                             znap_ := to_char(k1.dob);

                             comm_ := 'Визнані процентні витрати ';

                             INSERT INTO rnbu_trace
                                   (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                             VALUES
                                   (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acca, k.rnk, k.isp, k.nd);
                          else
                             rnk_ := k.rnk;
                             acc_ := k.acca;
                             nbs_ := k1.nbs;
                             nls_ := k.nls;
                             kv_  := 980;
                             isp_ := k.isp;
                             accr_:= k.accc;
                             tips_:= k.tip;
                             se_ := k1.dob;

                             p_obrab_data(4);
                          end if;
                      end if;
                  end loop;

                  -- якщо є визнані проценті витрати, то формуємо середні залишки
                  if fl_ = 1 then
                      if k.kodpa is not null then
                         kodp_ := substr(k.kodpa, 1, 22)||'3';
                         znap_ := to_char(abs(k.sumh));

                         comm_ := 'Середні залишки ';

                         INSERT INTO rnbu_trace
                               (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                         VALUES
                               (k.nlsa, k.kva, dat_, kodp_, znap_, nbuc_, comm_, k.acca,
                                k.rnka, k.ispa, k.nda);
                      else
                         rnk_ := k.rnka;
                         acc_ := k.acca;
                         nbs_ := replace(substr(k.nlsa, 1,1), '8', '2')||substr(k.nlsa,2,3);
                         nls_ := k.nlsa;
                         kv_  := k.kva;
                         isp_ := k.ispa;
                         accr_:= k.accca;
                         tips_:= k.tipa;
                         se_  := k.sumh;

                         p_obrab_data(3);
                      end if;
                  end if;
              end if;
           end loop;


           logger.info ('P_FD6_NN: Etap4 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

           -- вибираэмо рахунки, де одному процентному рахунку выдповыдаэ більше одного рахунку активу
           for k in (select z.*, s2 - (sum(s1) over (partition by z.acc))  zal_sum,
                        r.nd nda, r.kodp kodpa, c.kodp, nvl(c.nbuc, r.nbuc) nbuc,
                        sum(sumh) over (partition by z.acc) sh
                    from (select distinct p.ACC, p.NLS, p.KV, p.RNK, p.ISP, p.ACCC, p.TIP, p.DOS, p.IACC, p.ND,
                              ot_sumh (p.iacc, datr1_, datr2_, 1, dat_, p.kv) SUMH,
                              p.CNT, p.RNUM,
                              a.acc acca, a.nls nlsa, a.kv kva, a.isp ispa, a.rnk rnka, a.tip tipa, a.accc accca,
                              (select nvl(sum(s),0) from OTCN_FD5_DOCS where acc = p.acc and instr(nazn, a.nls)>0) s1,
                              (select nvl(sum(s),0) from OTCN_FD5_DOCS where acc = p.acc) s2,
                              (select count(distinct nbs) from OTCN_FD5_DOCS where acc = p.acc) cnt_nbs,
                              (select max(nbs) from OTCN_FD5_DOCS where acc = p.acc) nbs
                          from OTCN_FD5_PROC p, accounts a
                          where p.cnt>1 and
                            p.iacc = a.acc) z, rnbu_trace c, rnbu_trace r
                     where z.s2 <> 0 and
                           z.acc = c.acc(+)  and
                           nvl(c.kodp(+), '__'||
                           replace(substr(z.nlsa,1,1),'8','2')||substr(z.nlsa,2,3)||'2') like '__'||
                           replace(substr(z.nlsa,1,1),'8','2')||substr(z.nlsa,2,3)||'%2' and
                           z.iacc = r.acc(+) and
                           nvl(r.kodp(+), '__'||substr(z.nls,1,4)||'2') like '__'||substr(z.nls,1,4)||'%2')
           loop
              fl_ := 0;

              if k.nbuc is null then
                 IF typ_>0 THEN
                    nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
                 ELSE
                    nbuc_ := nbuc1_;
                 END IF;
              else
                 nbuc_ := k.nbuc;
              end if;

              if k.sumh <> 0 and
                 k.nbs in('7010','7011','7012','7013','7020','7021',
                          '7028','7030','7040','7041','7070','7071')
              then
                  if k.s1 <> 0 then
                     fl_ := 1;

                      if k.kodp is not null then
                         kodp_ := '15'||k.nbs||'0'||substr(k.kodp, 8, 9)||'980'||substr(k.kodp, 20, 3)||'4';

                         znap_ := to_char(k.s1);

                         comm_ := 'Визнані процентні витрати ';

                         INSERT INTO rnbu_trace
                               (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                         VALUES
                               (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acca, k.rnk, k.isp, k.nd);
                      else
                         rnk_ := k.rnk;
                         acc_ := k.acca;
                         nbs_ := k.nbs;
                         nls_ := k.nls;
                         kv_  := 980;
                         isp_ := k.isp;
                         accr_:= k.accc;
                         tips_:= k.tip;
                         se_ := k.s1;

                         p_obrab_data(4);
                      end if;
                  end if;

                  if k.zal_sum <> 0 then
                     fl_ := 1;

                      if k.kodp is not null then
                         kodp_ := '15'||k.nbs||'0'||substr(k.kodp, 8, 9)||'980'||substr(k.kodp, 20, 3)||'4';

                         znap_ := to_char(ROUND(k.zal_sum * (K.sumh / K.sh)));

                         comm_ := 'Визнані процентні витрати ';

                         INSERT INTO rnbu_trace
                               (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                         VALUES
                               (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acca, k.rnk, k.isp, k.nd);
                      else
                         rnk_ := k.rnk;
                         acc_ := k.acca;
                         nbs_ := k.nbs;
                         nls_ := k.nls;
                         kv_  := 980;
                         isp_ := k.isp;
                         accr_:= k.accc;
                         tips_:= k.tip;
                         se_ := ROUND(k.zal_sum * (k.sumh / k.sh));

                         p_obrab_data(4);
                      end if;
                  end if;

                  -- якщо є визнані проценті доходи, то формуємо середні залишки
                  if fl_ = 1 then
                      if k.kodpa is not null then
                         kodp_ := substr(k.kodpa, 1, 22)||'3';
                         znap_ := to_char(abs(k.sumh));

                         comm_ := 'Середні залишки ';

                         INSERT INTO rnbu_trace
                               (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, isp, nd)
                         VALUES
                               (k.nlsa, k.kva, dat_, kodp_, znap_, nbuc_, comm_, k.acca,
                                k.rnka, k.ispa, k.nda);
                      else
                         rnk_ := k.rnka;
                         acc_ := k.acca;
                         nbs_ := replace(substr(k.nlsa, 1,1), '8', '2')||substr(k.nlsa,2,3);
                         nls_ := k.nlsa;
                         kv_  := k.kva;
                         isp_ := k.ispa;
                         accr_:= k.accca;
                         tips_:= k.tipa;
                         se_  := k.sumh;

                         p_obrab_data(3);
                      end if;
                  end if;
              end if;
           end loop;
       end;

       FORALL i IN 1 .. l_rnbu_trace.COUNT
             insert /*+ append */  into rnbu_trace values l_rnbu_trace(i);
    end if;

    logger.info ('P_FD6_NN: Etap5 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    ---------------------------------------------------
    DELETE FROM tmp_nbu WHERE kodf=kodf_ AND datf= dat_;
    ---------------------------------------------------

    if Dat_ < dat_izm1 then
       OPEN BaseL;
       LOOP
          FETCH BaseL INTO  kodp_, nbuc_, znap_;
          EXIT WHEN BaseL%NOTFOUND;
          INSERT INTO tmp_nbu
               (kodf, datf, kodp, znap, nbuc)
          VALUES
               (kodf_, Dat_, kodp_, znap_, nbuc_);
       END LOOP;
       CLOSE BaseL;
    elsif Dat_ >= dat_izm1 and Dat_ <= dat_izm2 then
       -- показники для рахунк?в з процентною ставкою
        OPEN BaseL0;

        LOOP
          FETCH BaseL0
           INTO nbuc_, kodp_, sob_, sobpr_;

          EXIT WHEN BaseL0%NOTFOUND;

          if sob_ <> 0 then
             spcnt1_ := LTRIM (TO_CHAR (ROUND (sobpr_ / sob_, 4), fmt_));
          else
             spcnt1_ := '0.0000';
          end if;

          if spcnt1_ <> '0.0000' then
             INSERT INTO TMP_NBU
                         ( kodf,  datf, kodp,                    znap,    nbuc )
                  VALUES ( kodf_, dat_, '2'||substr(kodp_,2), spcnt1_, nbuc_ );
          end if;

        END LOOP;

        CLOSE BaseL0;

        -- показники суми для вс?х рахунк?в
        OPEN BaseL1;

        LOOP
           FETCH BaseL1
            INTO nbuc_, kodp_, sob_;

           EXIT WHEN BaseL1%NOTFOUND;

           INSERT INTO TMP_NBU
                       ( kodf,  datf, kodp,  znap,           nbuc )
                VALUES ( kodf_, dat_, kodp_, TO_CHAR (sob_), nbuc_ );

        END LOOP;

        CLOSE BaseL1;

        DELETE FROM RNBU_TRACE
           WHERE userid = userid_ AND
                 (kodp like '3%' or kodp like '4%');
    end if;

    if dat_ > dat_izm2 then
        kol_ := dat2_ - dat1_ + 1;

        -- показники для залишків та оборотів
        OPEN BaseL1;
        LOOP
           FETCH BaseL1 INTO  nbuc_, kodp_, znap_;
           EXIT WHEN BaseL1%NOTFOUND;
           INSERT INTO tmp_nbu
                (kodf, datf, kodp, znap, nbuc)
           VALUES
                (kodf_, Dat_, kodp_, znap_, nbuc_);
        END LOOP;
        CLOSE BaseL1;

        -- формуэмо показники по розрахованим процентам
        for k in (SELECT b.nbuc, b.kodp,
                         abs(sum(b.znap)) zn1, abs(sum(c.znap)) zn2
                   FROM (SELECT a.nbuc NBUC, a.acc, kodp,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '1%3'
                         group by a.nbuc, a.acc, kodp) b,
                         (SELECT a.nbuc NBUC, a.acc,
                            sum(a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '1%4'
                         group by a.nbuc, a.acc) c
                   where b.acc = c.acc
                group by b.nbuc, b.kodp  )
        loop
           if k.zn1 <> 0 then
              nbuc_ := k.nbuc;

              kodp_ := '2'||substr(k.kodp,2);

              if dat_ < to_date('30092013','ddmmyyyy') then
                 znap_ := Trim(TO_CHAR (round(((k.zn2 / k.zn1) / kol_) * b_yea * 100, 4), fmt_));
              else
                 znap_ := Trim(TO_CHAR (round((k.zn2 / k.zn1) * 12 * 100, 4), fmt_));
              end if;

              INSERT INTO tmp_nbu
                   (kodf, datf, kodp, znap, nbuc)
              VALUES
                   (kodf_, Dat_, kodp_, znap_, nbuc_);
           end if;
        end loop;

        -- додаэмо записи в протокол
        for k in (SELECT b.acc, b.nls, b.kv, b.rnk, b.nd, b.kodp, b.nbuc,
                         abs(sum(b.znap)) zn1, abs(sum(c.znap)) zn2
                   FROM (SELECT a.acc, a.nls, a.kv, a.rnk, a.nd, a.kodp, a.nbuc,
                            sum(decode(substr(kodp,2,1), '1', 1, -1)*a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '1%3'
                         group by a.acc, a.nls, a.kv, a.rnk, a.nd, a.kodp, a.nbuc) b,
                         (SELECT a.nbuc NBUC, a.acc,
                            sum(a.znap) ZNAP
                         FROM RNBU_TRACE a
                         WHERE a.kodp like '1%4'
                         group by a.nbuc, a.acc) c
                   where b.acc = c.acc
                group by b.acc, b.nls, b.kv, b.rnk, b.nd, b.kodp, b.nbuc)
        loop
           if k.zn1 <> 0 then
              nbuc_ := k.nbuc;

              kodp_ := '2'||substr(k.kodp,2);

              if dat_ < to_date('30092013','ddmmyyyy') then
                 znap_ := Trim(TO_CHAR (round(((k.zn2 / k.zn1) / kol_) * b_yea * 100, 4), fmt_));
              else
                 znap_ := Trim(TO_CHAR (round((k.zn2 / k.zn1) * 12 * 100, 4), fmt_));
              end if;

              comm_ := 'Розрахована % ставка: середній залишок = '||to_char(k.zn1)||' процентні витрати = '||to_char(k.zn2) ||
                    ' днів = ' || to_char(kol_)|| ' рік = ' ||to_char(b_yea);

              INSERT INTO rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, comm, acc, rnk, nd)
              VALUES
                   (k.nls, k.kv, dat_, kodp_, znap_, nbuc_, comm_, k.acc,
                    k.rnk, k.nd);
           end if;
        end loop;
    end if;

    logger.info ('P_FD6_NN: Etap6 for datf = '||to_char(dat_, 'dd/mm/yyyy'));

    if prnk_ is null then
      --------------------------------------------------------
      --P_Ch_Filed5(kodf_,dat_,userid_);
      --------------------------------------------------------

      otc_del_arch(kodf_, dat_, 0);
      OTC_SAVE_ARCH(kodf_, dat_, 0);
      commit;
    end if;

    logger.info ('P_FD6_NN: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
END P_Fd6_Nn;
/
show err;

