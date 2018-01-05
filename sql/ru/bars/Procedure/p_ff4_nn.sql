CREATE OR REPLACE PROCEDURE BARS.P_FF4_NN (Dat_ DATE ,
                                      sheme_ varchar2 default 'G')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования #F4
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.  All Rights Reserved.
% VERSION     : 05/01/2018 (04/01/2018, 03/01/2018, 14/11/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
           sheme_ - схема формирования
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
05/01/2018 - перекодируем старые балансовые счета на новые и для 
             нерезидентов заполняем K072 значениями N3 или N7 или N8 
04/01/2018 - параметры K072 и D020 будут формироваться 2-х значными 
03/01/2018 - новая структура показателя (вместо R013 будет R011 и 
             параметр K072 уже 2-х значный вместо однозначного) 
14/11/2017 - изменил вызов процедуры P_POPULATE_KOR для разных отчетных 
             месяцев (было на ММФО)
06/07/2017 - для некоторых значений K072 устанавливаем K140='9'
             для показателя кредитовых оборотов  k140='9'                
12/06/2017 - с 30/06/2017 добавляется часть кода показателя 
             "Код розміру суб'єкта господарювання" (доп.параметр K140)
04/04/2017  добавлены исправления выполненные 26/11/2015
01/12/2015  при наличии двух записей в KL_R013 для одного бал.счета и 
            параметра R013 и заполненного значения D_CLOSE для одной из 
            записей параметр R013 формировался нулевым. Исправлено. 
26/11/2015  для деяких бал.рах. будемо включати новий перелік R013
            2600 (1,7,8,A), 2605 (1,3), 2620 (1,2,3), 2625 (2), 
            2650 (1,3,8), 2655 (3)
03/09/2015  добавлено включение счетов 8 класса (депозитные линии ЮЛ)
02/07/2015  изменения по KL_K070 (дата открытия и закрытия показателя)
08/01/2013  не включались обороти через пусту процентну ставку
07/02/2013  изменения по KL_K110 (дата открытия и закрытия показателя)
17/12/2012  доопрацювання по KL_K110 (прибиораємо подвійні записи)
01/11/2011  добавлено формирование поля RNK в таблице RNBU_TRACE
03/10/2011  не включались рахунки 8605. Підправила умову відбору.
23/06/2011  для ненулевого значения параметра R013 проверяем в кл-ре KL_R013
            дату закрытия данного значения и если она внесена и меньше
            отчетной даты то устанавливаем R013 в '0'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='F4';
typ_ 	 number;
fmt_     varchar2(20):='990D0000';

nls_     varchar2(15);
data_    date;
dat1_    date;
dat2_    date;
mdate_   date;
acc_     number;
sDos_    number;
sKos_    number;
se_      number;
sPCnt_   number;
sPCnt1_  varchar2(20);
Kv_      number;
Nbs_     varchar2(4);
codcagent_ number;
Cntr_    number;
Cntr1_   varchar2(1);
rnk_     number;
mfo_     number;
mfo1_    Varchar2(12);
f04_     number;
f04d_    number;
f04k_    number;
kolvo_   number;
K112_    char(1);
r011_    varchar2(1);
r011_1   varchar2(1);
r013_    varchar2(1);
r013_1   varchar2(1);
K071_    varchar2(1);
K072_    varchar2(2);
d020_    varchar2(2);
S180_    char(1);
S180R_   char(1);
kodp_    varchar2(70);
kodp2_   varchar2(70);
Sob_     number;
SobPr_   number;
userid_  number;
nbuc1_   varchar2(100);
nbuc_    varchar2(100);
sql_     VARCHAR2 (200);
dat_spr_ date := last_day(dat_)+1;
dat_Izm1 date := to_date('30062017','ddmmyyyy');
dat_Izm2 date := to_date('29122017','ddmmyyyy');
k140_    varchar2(1);

CURSOR SaldoAOd IS
  select b.acc, b.nls, b.kv, b.codc, b.odate, b.s180, NVL(trim(k.k112),'0') k112, 
         b.d020, b.ints, 
         b.r011, 
         (case when b.mb = '0' and b.r013 <> '0' then b.r013 else b.mb end) r013,
         NVL(trim(e.k072),'00') k072, 
         b.mdate, b.dos, b.kos, b.ost, b.nbs, b.rnk, b.s180R, b.codcagent  
  from (
    SELECT c.acc, a.nls, a.kv, mod(d.codcagent,2) codc, a.odate, NVL(a.s180,'0') s180,
           NVL(trim(a.k112),'0') k112, lpad(NVL(trim(a.d020),'1'),2,'0') d020, 
           nvl(a.ints,0) ints,
           NVL(trim(a.mb),'0') mb,
           NVL(trim(p.k072),'00') k072, c.mdate,
           a.dos, a.kos, a.ost, c.nbs, 
           d.rnk, nvl(trim(d.ise), '00000') k070, nvl(trim(d.ved), '00000') k110,
           nvl(trim(P.R011), '0') r011, 
           nvl(trim(P.R013), '0') r013, 
           fs180(c.acc, substr(c.nls,1,1), a.odate) s180R, d.codcagent
    FROM rnbu_history a, accounts c, specparam p, customer d
    WHERE a.odate between DAT1_ + 1 and Dat_
     AND (a.dos+a.kos != 0 OR a.ost != 0)
     AND nvl(a.ints,0) >= 0
     and a.acc = c.acc
     AND c.nbs in (select k.r020 from kod_r020 k where k.a010=kodf_ AND trim(k.prem) = 'КБ')
     AND c.acc = p.acc(+)
     and c.rnk = d.rnk
         UNION ALL
     SELECT c.acc, a.nls, a.kv, mod(d.codcagent,2) codc, a.odate, NVL(a.s180,'0') s180,
           NVL(a.k112,'0') k112, lpad(NVL(trim(a.d020),'1'),2,'0') d020, 
           nvl(a.ints,0) ints,
           NVL(trim(a.mb),'0') mb,
           NVL(trim(p.k072),'00') k072, c.mdate,
           a.dos, a.kos, a.ost, '2'||substr(c.nbs,2) nbs, 
           d.rnk, nvl(trim(d.ise), '00000') k070, nvl(trim(d.ved), '00000') k110,
           nvl(trim(P.R011), '0') r011, 
           nvl(trim(P.R013), '0') r013, 
           fs180(c.acc, substr(c.nls,1,1), a.odate) s180R, d.codcagent
    FROM rnbu_history a, accounts c, specparam p, customer d
    WHERE a.nls like '86%'
	 AND a.acc = c.acc
	 AND (a.dos+a.kos != 0  OR   a.ost != 0)
	 AND nvl(a.ints,0)>=0
	 AND a.odate between DAT1_ + 1 and Dat_
	 AND c.acc=p.acc(+) 
     and c.rnk = d.rnk) b
   left outer join 
   (select * from KL_K110 where d_open <= dat_ and (d_close is null or d_close > dat_)) k
   on (b.k110 = k.k110)
   left outer join 
   (select * from KL_K070 where d_open <= dat_ and (d_close is null or d_close > dat_)) e
   on (b.k070 = e.k070);

CURSOR SaldoKor IS
  select b.acc, b.nls, b.kv, b.fdat, b.nbs, b.s180, b.r011, b.r013,
         NVL(trim(e.k072),'00') k072, 
         b.codc, b.rnk, lpad(b.d020, 2, '0') d020, b.mdate, b.sdos, b.skos, 
         NVL(trim(k.k112),'0') k112, b.codcagent
  from (
    SELECT s.acc, s.nls, s.kv, a.fdat, s.nbs,
           DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180) s180,
           NVL(trim(p.r011),'0') r011,
           NVL(trim(p.r013),'0') r013, 
           NVL(trim(p.k072),'00') k072,
           MOD(c.codcagent, 2) codc, c.rnk, 
           nvl(trim(c.ise), '00000') k070, nvl(trim(c.ved), '00000') k110,
           NVL(to_char(to_number(p.d020)),'01') d020, s.mdate, 
           SUM(DECODE(a.dk, 0, GL.P_ICURVAL(s.kv, a.s, a.fdat), 0)) sdos,
           SUM(DECODE(a.dk, 1, GL.P_ICURVAL(s.kv, a.s, a.fdat), 0)) skos, 
           c.codcagent
    FROM kor_prov a, accounts s, customer c, specparam p, kod_r020 k
    WHERE s.nbs LIKE k.r020 || '%'
      AND k.a010 = kodf_
      AND trim(k.prem) = 'КБ'
      AND a.s != 0
      AND a.fdat between Dat_ + 1 and Dat2_
      AND s.acc=a.acc
      AND s.acc=p.acc(+)
      AND s.rnk=c.rnk
    GROUP BY s.acc, s.nls, s.kv, a.fdat, s.nbs,
             DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
             NVL(trim(p.r011),'0'), NVL(trim(p.r013),'0'), 
             NVL(trim(p.k072),'00'),
             MOD(c.codcagent, 2), c.rnk, nvl(trim(c.ise), '00000'),
             nvl(trim(c.ved), '00000'), NVL(to_char(to_number(p.d020)),'01'),
             s.mdate, c.codcagent) b
   left outer join 
   (select * from KL_K110 where d_open <= dat_ and (d_close is null or d_close > dat_)) k
   on (b.k110 = k.k110)
   left outer join 
   (select * from KL_K070 where d_open <= dat_ and (d_close is null or d_close > dat_)) e
   on (b.k070 = e.k070);

   CURSOR Basel IS
      SELECT nbuc, kodp, SUM (TO_NUMBER (znap)),
               SUM (TO_NUMBER (znap_pr)), count(*)
      FROM (SELECT a.nbuc NBUC, a.kodp KODP, a.znap ZNAP, '0' ZNAP_PR
            FROM RNBU_TRACE a
            WHERE SUBSTR (a.kodp, 1, 1) = '1'
            UNION ALL
            SELECT a.nbuc NBUC, '1'||substr(a.kodp,2,17) KODP, '0' ZNAP,
                   a.znap ZNAP_PR
            FROM RNBU_TRACE a
            WHERE SUBSTR (a.kodp, 1, 1) = '3')
      GROUP BY nbuc, kodp;
-------------------------------------------------------------------------------
   PROCEDURE p_ins (p_kodp_ VARCHAR2, p_znap_ VARCHAR2) IS
   BEGIN
      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, nbuc, rnk,
                   acc, mdate
                  )
           VALUES (nls_, kv_, data_, p_kodp_, p_znap_, nbuc_, rnk_,
                   acc_, mdate_
                  );

      kolvo_ := kolvo_ + 1;
   END;
------------------------------------------------------------------------------------------------------

BEGIN
-------------------------------------------------------------------
logger.info ('P_FF4_NN: Begin ');

userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_,'MM') - 1;
Dat2_ := TRUNC(Dat_ + 28);

p_proc_set(kodf_,sheme_,nbuc1_,typ_);

if to_char(Dat_,'MM') = '12' then
   p_populate_kor(Dat1_,Dat2_,'', 0);
else
   p_populate_kor(Dat1_,Dat2_,'', 3);
end if;      
-------------------------------------------------------------------
mfo_:=F_OURMFO();

OPEN SaldoAOd;
LOOP
    FETCH SaldoAOd INTO acc_, nls_, Kv_, Cntr_, data_, S180_, K112_, d020_,
                        sPCnt_, r011_, r013_, k072_, mdate_, sDos_, sKos_, se_, 
                        nbs_, rnk_, S180R_, codcagent_ ;
    EXIT WHEN SaldoAOd%NOTFOUND;

    if r011_ <> '0' then
       BEGIN
          select r011
             into r011_1
          from kl_r011
          where trim(prem)='КБ' and 
                r020=nbs_ and 
                r011=r011_ and
                d_open <= dat_ and
                (d_close is null or d_close > dat_);
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
               r011_ := '0';
       END;
    end if;

    if r013_ <> '0' then
       BEGIN
          select r013
             into r013_1
          from kl_r013
          where trim(prem)='КБ' and 
                r020=nbs_ and 
                r013=r013_ and
                d_open <= dat_ and
                (d_close is null or d_close > dat_);
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
               r013_ := '0';
       END;
    end if;

    if Data_ < to_date('26122017','ddmmyyyy') and 
      (nls_ like '2202%' and s180_ > 'B' or nls_ like '2203%' and s180_ <= 'B') then
        if nls_ like '2202%' and s180R_ <= 'B' or 
           nls_ like '2203%' and s180R_  > 'B'
        then   
           s180_ := S180R_; 
        else
           s180_ := (case when nls_ like '2202%' then 'B' else 'C' end);
        end if;
    end if;
    
    if cntr_ = 0 then 
       k072_ := '00';
       if dat_ >= dat_Izm2 
       then   
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

    k140_ := '9';

    if nls_ like '20%' or nls_ like '260%'
    then
       BEGIN
          select nvl(substr(trim(cw.value), 1, 1), '9')
             into k140_
          from customerw cw
          where cw.rnk = rnk_ 
            and cw.tag like 'K140%';
       EXCEPTION WHEN NO_DATA_FOUND THEN
          k140_ := '9';
       END;
    end if;
    
    -- было до 29.12.2017 ('0','5','6','7','H','I','J','K','N','R','Z','Y')
    if k072_ in ('00','21','22','23','30','31','31','32','41','42','43','51','5Y','1X','2X')
    then
       k140_ := '9';
    end if;
    
    if typ_ > 0 then
       nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
    else
       nbuc_ := nbuc1_;
    end if;

    IF nbs_ not in ('1600','2600','2605','2620','2625','2650','2655','8025') AND
       sDos_>0 AND sPCnt_>=0 THEN

       if nbs_ like '8%'
       then
          nbs_ := '2' || substr(nbs_, -3);
       end if; 

       SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf='03' AND
             nbs_=r020 AND r050='11';

       IF f04_ > 0 THEN
          if dat_ < dat_Izm1
          then
             kodp_ := '5' || nbs_ || r013_ || K112_ || K072_ ||
                       s180_ || to_char(2-Cntr_) || d020_ ||
                       lpad(Kv_, 3, '0');
          else 
             if dat_ < dat_Izm2 
             then
                kodp_ := '5' || nbs_ || r013_ || K112_ || K072_ ||
                          s180_ || to_char(2-Cntr_) || d020_ ||
                          lpad(Kv_, 3, '0') || k140_;
             else 
                if nbs_ = '2062' then 
                   nbs_ := '2063';
                elsif nbs_ = '2202' then
                   nbs_ := '2203';
                else
                   null;
                end if;
                if nbs_ = '2063' and r011_ = '0'
                then
                   r011_ := '3';
                end if;
                if nbs_ = '2203' and r011_ = '0'
                then
                   r011_ := '1';
                end if;

                kodp_ := '5' || nbs_ || r011_ || K112_ || K072_ ||
                          s180_ || to_char(2-Cntr_) || d020_ ||
                          lpad(Kv_, 3, '0') || k140_;
             end if; 
          end if;
 
          -- Дб. обороты
          p_ins ('1' || kodp_, TO_CHAR (sdos_));
          -- %% ставка
          p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
          -- Дт.обороты*%% ставка
          p_ins ('3' || kodp_, TO_CHAR (sdos_*ROUND(spcnt_,4)));
       END IF;

    END IF;

    IF (nbs_ not in ('1600','2600','2605','2650','2655','8025')
            OR
        (nbs_ = '2600' and r013_ in ('1','7','8','A') and dat_ < dat_Izm2)
            OR
        (nbs_ = '2600' and r011_ = '3' and dat_ >= dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2605' and r013_ in ( '1','3') and dat_ < dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2605' and r011_ = '3' and dat_ >= dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2655' and r013_ = '3' and dat_ < dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2655' and r011_ = '3' and dat_ >= dat_Izm2)
            OR
         mfo_ = 324805 and -- не включаем такие счета с нулевой проц. ставкой для Крыма
        ( (nbs_ = '2605' and r013_ in ('1','3') and skos_ > 0 and spcnt_ <> 0 and dat_ < dat_Izm2)  
            OR
          (nbs_ = '2605' and r011_ = '3' and skos_ > 0 and spcnt_ <> 0 and dat_ >= dat_Izm2)  
            OR
          (nbs_ = '2655' and r013_ = '3' and skos_ > 0 and dat_ < dat_Izm2)
            OR
          (nbs_ = '2655' and r011_ = '3' and skos_ > 0 and dat_ >= dat_Izm2)
        ) 
            OR
         (nbs_ = '2650' and r013_ in ('1','3','8') and dat_ < dat_Izm2)
            OR
         (nbs_ = '2650' and r011_ = '3' and dat_ >= dat_Izm2)
       ) AND
        sKos_>0 AND sPCnt_>=0
    THEN

       if nbs_ like '8%'
       then
          nbs_ := '2' || substr(nbs_, -3);
       end if; 

       SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf='03' AND
              nbs_=r020  AND r050='22';

       if nbs_ in ('2620','2625') and d020_='00' then
          d020_ := '01';
       end if;

       IF f04_ > 0 OR (nbs_ = '2600' and r013_ in ('1','7','8','A')and dat_ < dat_Izm2) OR
                      (nbs_ = '2600' and r011_ = '3' and dat_ >= dat_Izm2) OR 
                      (nbs_ = '2605' and r013_ in ('1','3') and dat_ < dat_Izm2)   OR
                      (nbs_ = '2605' and r011_ = '3' and dat_ >= dat_Izm2)   OR
                      (nbs_ = '2655' and r013_ = '3' and dat_ < dat_Izm2)   OR
                      (nbs_ = '2655' and r011_ = '3' and dat_ >= dat_Izm2)   OR
                      (nbs_ = '2650' and r013_ in ('1','3','8') and dat_ < dat_Izm2) OR
                      (nbs_ = '2650' and r011_ = '3' and dat_ >= dat_Izm2)
       THEN

          if dat_ < dat_Izm1 
          then
             kodp_ := '6' || nbs_ || r013_ || K112_ || K072_ ||
                       s180_ || to_char(2-Cntr_) || d020_ ||
                       lpad(Kv_, 3, '0');
          else 
             if dat_ < dat_Izm2
             then
                kodp_ := '6' || nbs_ || r013_ || K112_ || K072_ ||
                          s180_ || to_char(2-Cntr_) || d020_ ||
                          lpad(Kv_, 3, '0') || '9';
             else
                if nbs_ = '2615' then
                   nbs_ := '2610';
                elsif nbs_ = '2635' then
                   nbs_ := '2630';
                elsif nbs_ = '2652' then
                   nbs_ := '2651';
                else
                   null;
                end if;
                if nbs_ in ('2600','2605','2620','2625','2650','2655') and r011_ = '0'
                then
                   r011_ := '3';
                end if;
                if nbs_ in ('2610','2630') and r011_ = '0'
                then
                   r011_ := '1';
                end if;
                if nbs_ = '2620' and r011_ in ('1', '9')
                then
                   r011_ := '3';
                end if;
                if nbs_ = '2651' and r011_ = '0'
                then
                   r011_ := '4';
                end if;

                kodp_ := '6' || nbs_ || r011_ || K112_ || K072_ ||
                          s180_ || to_char(2-Cntr_) || d020_ ||
                          lpad(Kv_, 3, '0') || '9';
             end if;
          end if;

          -- Кт. обороты
          p_ins ('1' || kodp_, TO_CHAR (sKos_));
          -- %% ставка
          p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
          -- Кт.обороты*%% ставка
          p_ins ('3' || kodp_, TO_CHAR (sKos_*ROUND(spcnt_,4)));
       END IF;

    END IF;

    IF nbs_ in ('1600','2600','2605','2620','2625','2650','2655','8025') AND
       sDos_+sKos_ = 0 and se_ != 0 AND sPCnt_>=0 THEN

       SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf='03' AND
              nbs_=r020  AND r050='11';

       IF f04_ > 0 THEN
          IF 1=1  THEN

             if nbs_ = '8025' then
                nbs_ := '2625';
             end if;

             if nbs_ in ('2600','2605','2620','2625','2650','2655') then
                s180_ := '1';
             end if;

             if nbs_ in ('2600','2605','2620','2625','2650','2655') and r011_ = '0'
             then
                r011_ := '1';
             end if;

             if d020_ in ('00', '01', '02') then
                if d020_ = '00' then
                   d020_ := '01';
                end if;

                if dat_ < dat_Izm1 
                then
                   kodp_ := '5' || nbs_ || r013_ || K112_ || K072_ ||
                            s180_ || to_char(2-Cntr_) || d020_ ||
                            lpad(Kv_, 3, '0');
                else 
                   if dat_ < dat_Izm2
                   then
                      kodp_ := '5' || nbs_ || r013_ || K112_ || K072_ ||
                               s180_ || to_char(2-Cntr_) || d020_ ||
                               lpad(Kv_, 3, '0') || k140_;
                   else
                      kodp_ := '5' || nbs_ || r011_ || K112_ || K072_ ||
                               s180_ || to_char(2-Cntr_) || d020_ ||
                               lpad(Kv_, 3, '0') || k140_;
                   end if;
                end if;

                -- Дб. обороты
                p_ins ('1' || kodp_, TO_CHAR (ABS(se_)));
                -- %% ставка
                p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
                -- Дт.обороты*%% ставка
                p_ins ('3' || kodp_, TO_CHAR (ABS(se_)*ROUND(spcnt_,4)));
             end if;
          END IF;
       END IF;
    END IF;

    IF nbs_ ='1500' AND sDos_+sKos_ = 0 and se_ != 0 AND sPCnt_>=0 THEN

       SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf='03' AND
              nbs_=r020  AND r050='22';

       IF f04_ > 0 THEN
          if d020_ in ('00', '01', '02') then
             if d020_ = '00' then
                d020_ := '01';
             end if;

             if dat_ < dat_Izm1
             then
                kodp_ := '6' || nbs_ || r013_ || K112_ || K072_ ||
                         s180_ || to_char(2-Cntr_) || d020_ ||
                         lpad(Kv_, 3, '0');
             else
                if dat_ < dat_Izm2
                then 
                   kodp_ := '6' || nbs_ || r013_ || K112_ || K072_ ||
                            s180_ || to_char(2-Cntr_) || d020_ ||
                            lpad(Kv_, 3, '0') || '9';
                else
                   kodp_ := '6' || nbs_ || r011_ || K112_ || K072_ ||
                            s180_ || to_char(2-Cntr_) || d020_ ||
                            lpad(Kv_, 3, '0') || '9';
                end if;
             end if;

             -- Кт. обороты
             p_ins ('1' || kodp_, TO_CHAR (ABS(se_)));
             -- %% ставка
             p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
             -- Кт.обороты*%% ставка
             p_ins ('3' || kodp_, TO_CHAR (ABS(se_)*ROUND(spcnt_,4)));
          end if;
       END IF;
    END IF;

    IF nbs_ not in ('1500', '1600','2600','2605','2620','2625','2650','2655','8025') AND
       sDos_+sKos_ = 0 and se_ != 0 AND sPCnt_>=0 and d020_ = '03'
    THEN

       if nbs_ like '8%'
       then
          nbs_ := '2' || substr(nbs_, -3);
       end if; 

       SELECT count(*) INTO f04_ FROM kl_f3_29 WHERE kf='03' AND
              nbs_=r020  AND r050 = (case when se_ < 0 then '11' else '22' end) ;

       IF f04_ > 0 THEN
          if dat_ < dat_Izm1
          then
             kodp_ := (case when se_ < 0 then '5' else '6' end) ||
                      nbs_ || r013_ || K112_ || K072_ || s180_ ||
                      to_char(2-Cntr_) || d020_ || lpad(Kv_, 3, '0');
           else
             if dat_ < dat_Izm2
             then
                kodp_ := (case when se_ < 0 then '5' else '6' end) ||
                         nbs_ || r013_ || K112_ || K072_ || s180_ ||
                         to_char(2-Cntr_) || d020_ || lpad(Kv_, 3, '0') || 
                         (case when se_ < 0 then k140_ else '9' end);
              else
                kodp_ := (case when se_ < 0 then '5' else '6' end) ||
                         nbs_ || r011_ || K112_ || K072_ || s180_ ||
                         to_char(2-Cntr_) || d020_ || lpad(Kv_, 3, '0') || 
                         (case when se_ < 0 then k140_ else '9' end);
              end if; 
           end if;

           -- Кт. обороты
           p_ins ('1' || kodp_, TO_CHAR (ABS(se_)));
           -- %% ставка
           p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
           -- Кт.обороты*%% ставка
           p_ins ('3' || kodp_, TO_CHAR (ABS(se_)*ROUND(spcnt_,4)));
       END IF;
    END IF;
END LOOP;
CLOSE SaldoAOd;
---------------------------------------------------------------------
OPEN SaldoKor;
LOOP
    FETCH SaldoKor INTO acc_, nls_, Kv_, data_, nbs_, S180_, r011_, r013_,
                        k072_, Cntr_, rnk_, d020_, mdate_, sDos_, sKos_, k112_,
                        codcagent_;

    EXIT WHEN SaldoKor%NOTFOUND;

    f04k_ := 0 ;
    f04d_ := 0 ;

    if r011_ <> '0' then
       BEGIN
          select r011
             into r011_1
          from kl_r011
          where trim(prem)='КБ' and 
                r020=nbs_ and 
                r011=r011_ and
                d_open <= dat_ and
                (d_close is null or d_close > dat_);
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
               r011_ := '0';
       END;
    end if;

    if r013_ <> '0' then
       BEGIN
          select r013
             into r013_1
          from kl_r013
          where trim(prem)='КБ' and 
                r020=nbs_ and 
                r013=r013_ and
                d_open <= dat_ and
                (d_close is null or d_close > dat_);
       EXCEPTION
          WHEN NO_DATA_FOUND
          THEN
               r013_ := '0';
       END;
    end if;

    if typ_ > 0 then
       nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
    else
       nbuc_ := nbuc1_;
    end if;

    sPCnt_:= acrn.FPROC(acc_, data_) ;
    
    if cntr_ = 0 then 
       k072_ := '00';
       if dat_ >= dat_Izm2
       then
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

    IF nbs_ not in ('1600','2600','2605','2620','2625','2650','2655') AND sDos_>0 AND
       sPCnt_ >=0 THEN

       SELECT count(*) INTO f04d_ FROM kl_f3_29 WHERE kf='03' AND
              r020=nbs_ AND r050='11' ;

       IF f04d_ > 0 THEN

          if dat_ < dat_Izm1
          then
             kodp_ := '5' || nbs_ || r013_ || K112_ || K072_ ||
                      s180_ || to_char(2-Cntr_) || d020_ ||
                      lpad(Kv_, 3, '0');
          else
             if dat_ < dat_Izm2
             then
                kodp_ := '5' || nbs_ || r013_ || K112_ || K072_ ||
                         s180_ || to_char(2-Cntr_) || d020_ ||
                         lpad(Kv_, 3, '0') || k140_;
             else
                if nbs_ = '2062' then 
                   nbs_ := '2063';
                elsif nbs_ = '2202' then
                   nbs_ := '2203';
                else
                   null;
                end if;
                if nbs_ = '2063' and r011_ = '0'
                then
                   r011_ := '3';
                end if;
                if nbs_ = '2203' and r011_ = '0'
                then
                   r011_ := '1';
                end if;

                kodp_ := '5' || nbs_ || r011_ || K112_ || K072_ ||
                         s180_ || to_char(2-Cntr_) || d020_ ||
                         lpad(Kv_, 3, '0') || k140_;
             end if;
          end if;

          -- Дб. обороты
          p_ins ('1' || kodp_, TO_CHAR (sDos_));
          -- %% ставка
          p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
          -- Дт.обороты*%% ставка
          p_ins ('3' || kodp_, TO_CHAR (sdos_*ROUND(spcnt_,4)));
       END IF;

    END IF;

    IF (nbs_ not in ('1600','2600','2605','2650','2655')
            OR
        (nbs_ = '2600' and r013_ in ('1','7','8','A') and dat_ < dat_Izm2)
            OR
        (nbs_ = '2600' and r011_ = '3' and dat_ > dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2605' and r013_ in ('1','3') and dat_ < dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2605' and r011_ = '3' and dat_ >= dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2655' and r013_ = '3' and dat_ < dat_Izm2)
            OR
        (mfo_ <> 324805 and nbs_ = '2655' and r011_ = '3' and dat_ >= dat_Izm2)
            OR
         mfo_ = 324805 and -- не включаем такие счета с нулевой проц. ставкой для Крыма
        ((nbs_ = '2605' and r013_ in ('1','3') and skos_ > 0 and spcnt_ <> 0 and dat_ < dat_Izm2)  
            OR
         (nbs_ = '2605' and r011_ = '3' and skos_ > 0 and spcnt_ <> 0 and dat_ >= dat_Izm2)  
            OR
         (nbs_ = '2655' and r013_ = '3' and skos_ > 0 and dat_ < dat_Izm2)
            OR
         (nbs_ = '2655' and r011_ = '3' and skos_ > 0 and dat_ >= dat_Izm2)
        )
            OR
        (nbs_ = '2650' and r013_ in ('1','3','8') and dat_ < dat_Izm2) 
            OR
        (nbs_ = '2650' and r011_ =  '3' and dat_ >= dat_Izm2) 
       ) AND sKos_>0 AND sPCnt_>=0
    THEN

       SELECT count(*) INTO f04k_ FROM kl_f3_29 WHERE kf='03' AND
             r020=nbs_ AND r050='22' ;

       IF f04k_ > 0 OR (nbs_ = '2600' and r013_ in ('1','7','8','A') and dat_ < dat_Izm2) OR
                       (nbs_ = '2600' and r011_ = '3' and dat_ >= dat_Izm2) OR
                       (nbs_ = '2605' and r013_ in ('1','3') and dat_ < dat_Izm2)   OR
                       (nbs_ = '2605' and r011_ = '3' and dat_ >= dat_Izm2)   OR
                       (nbs_ = '2655' and r013_ = '3' and dat_ < dat_Izm2)   OR
                       (nbs_ = '2655' and r011_ = '3' and dat_ >= dat_Izm2)   OR
                       (nbs_ = '2650' and r013_ in ('1','3','8') and dat_ < dat_Izm2) OR
                       (nbs_ = '2650' and r011_ = '3' and dat_ >= dat_Izm2) 
       THEN

          if dat_ < dat_Izm1
          then
             kodp_ := '6' || nbs_ || r013_ || K112_ || K072_ ||
                      s180_ || to_char(2-Cntr_) || d020_ ||
                      lpad(Kv_, 3, '0');
          else
             if dat_ < dat_Izm2
             then
                kodp_ := '6' || nbs_ || r013_ || K112_ || K072_ ||
                         s180_ || to_char(2-Cntr_) || d020_ ||
                         lpad(Kv_, 3, '0') || '9';
             else
                if nbs_ = '2615' then
                   nbs_ := '2610';
                elsif nbs_ = '2635' then
                   nbs_ := '2630';
                elsif nbs_ = '2652' then
                   nbs_ := '2651';
                else
                   null;
                end if;
                if nbs_ in ('2600','2605','2620','2625','2650','2655') and r011_ = '0'
                then
                   r011_ := '3';
                end if;
                if nbs_ in ('2610','2630') and r011_ = '0'
                then
                   r011_ := '1';
                end if;
                if nbs_ = '2620' and r011_ in ('1', '9')
                then
                   r011_ := '3';
                end if;
                if nbs_ = '2651' and r011_ = '0'
                then
                   r011_ := '4';
                end if;

                kodp_ := '6' || nbs_ || r011_ || K112_ || K072_ ||
                         s180_ || to_char(2-Cntr_) || d020_ ||
                         lpad(Kv_, 3, '0') || '9';
             end if;
          end if;

          -- Кт. обороты
          p_ins ('1' || kodp_, TO_CHAR (sKos_));
          -- %% ставка
          p_ins ('2' || kodp_, LTRIM (TO_CHAR (ROUND (spcnt_, 4), fmt_)));
          -- Кт.обороты*%% ставка
          p_ins ('3' || kodp_, TO_CHAR (sKos_*ROUND(spcnt_,4)));
       END IF;

    END IF;

END LOOP;
CLOSE SaldoKor;
-------------------------------------------------
DELETE FROM tmp_nbu WHERE kodf=kodf_ AND datf= Dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO nbuc_, kodp_, Sob_, SobPr_, f04_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu  (kodf, datf, kodp, znap, nbuc) VALUES
                        (kodf_, Dat_, kodp_, TO_CHAR(Sob_), nbuc_);

   IF Sob_ != 0 THEN
      sPCnt1_:= LTRIM(TO_CHAR(ROUND(SobPr_/Sob_,4),fmt_));
   ELSE
      sPCnt1_:= LTRIM(TO_CHAR(Sob_,fmt_));
   END IF;

   INSERT INTO tmp_nbu (kodf, datf, kodp, znap, nbuc) VALUES
                      (kodf_, Dat_, '2'||substr(kodp_,2,17), sPCnt1_, nbuc_);

END LOOP;
CLOSE BaseL;

DELETE FROM RNBU_TRACE
   WHERE kodp like '3%';

logger.info ('P_FF4_NN: End ');
----------------------------------------------------------------------
END P_FF4_NN;
/