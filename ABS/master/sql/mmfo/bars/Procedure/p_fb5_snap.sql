

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_FB5_SNAP.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_FB5_SNAP ***

  CREATE OR REPLACE PROCEDURE BARS.P_FB5_SNAP (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла #B5 для КБ on SNAP
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 08.04.2011 (05.04.2011,18.02.2011 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
06.04.2011 для mfou_=300465 и бал.счета 2548 анализируем параметр OB22
           (если OB22=02 то в показатель поточнi (220811X,220821X)
            все остальные OB22 в показатель 220810Х,220820Х)
18.02.2011 для mfou_<>300465 и бал.счета 2658 анализируем параиетр R011
           (если R011=1,4,7 то на вимогу, если R011=5,6 то депозит)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='B5';
acc_     Number;
acc1_    Number;
dk_      Varchar2(1);
nbs_     Varchar2(4);
nls_     Varchar2(15);
r011_    Varchar2(1);
r012_    Varchar2(1);
r013_    Varchar2(1);
ob22_    Varchar2(2);
kod_11_  Varchar2(2);
dd_      Varchar2(2);
r034_    Varchar2(1);
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat4_    Date;
data_    Date;
kv_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Dos99_   DECIMAL(24);
Dosq99_  DECIMAL(24);
Kos99_   DECIMAL(24);
Kosq99_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
sn_      DECIMAL(24);
se_      DECIMAL(24);
kodp_    Varchar2(7);
kodp1_   Varchar2(7);
znap_    Varchar2(30);
ddd_     Varchar2(3);
txt1_    Varchar2(3);
flag_    number;
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ff_      number;
ret_	 number;
r114_    Varchar2(1);
cnt_     number;
rez_     number;
s180_	 varchar2(1);
rnk_     number;
custtype_ varchar2(1);
k072_     varchar2(1);
sed_      varchar2(4);
kolz_pg_  number;
mfo_      NUMBER;
mfou_     NUMBER;

l_DAT01d_ date      ;
l_DAT01t_ date      ;
Di_       number ;
Dip_       number ;

--- остатки счетов+месячные корректирующие обороты+
--- обороты перекрытия(6,7 класс на 5040(5041))+корр.обороты перекрытия
CURSOR SALDOOG IS
select s.acc, a.nls, a.kv, dat_ fdat, a.nbs,
       s.ost  OST,
       s.ostq OSTQ,
       CRdos  dos96, CRdosQ dos96q,
       CRkos kos96, CRkosQ kos96q,
       0 doszg,  0 koszg, 0 dos96zg, 0 kos96zg, 0 dos99zg, 0 kos99zg,
       nvl(p.R114,'0'), nvl(trim(p.r011),'0'), nvl(trim(p.r013),'0'), s.rnk,
       c.CODCAGENT, nvl(trim(p.s180), fs180(s.acc,substr(A.nls, 1, 1), dat_)),
       c.custtype, NVL(trim(c.sed),'00')
from ACCM_AGG_MONBALS s, accounts a, specparam p, customer c
where s.caldt_ID=Di_
  and s.acc = a.acc
  and EXISTS (select 1 from kod_r020_B5 WHERE r020 = a.nbs)
  and s.acc=p.acc(+)
  and s.rnk = c.rnk
  and s.ost - s.CRdos + s.CRkos + s.ostq - s.CRdosq + s.CRkosq <> 0;

CURSOR SALDOPG IS
select s.acc, a.nls, a.kv, dat3_ fdat, a.nbs,
       s.ost  OST,
       s.ostq OSTQ,
       CRdos  dos96, CRdosQ dos96q,
       CRkos kos96, CRkosQ kos96q,
       0 Dos99, 0 Dosq99, 0 Kos99, 0 Kosq99,
       0 doszg,  0 koszg, 0 dos96zg, 0 kos96zg, 0 dos99zg, 0 kos99zg,
       nvl(p.R114,'0'), nvl(trim(p.r011),'0'), nvl(trim(p.r013),'0'), s.rnk,
       c.CODCAGENT, nvl(trim(p.s180), fs180(s.acc,substr(A.nls, 1, 1), dat3_)),
       c.custtype, NVL(trim(c.sed),'00')
from ACCM_AGG_MONBALS s, accounts a, specparam p, customer c
where s.caldt_ID=Dip_
  and s.acc = a.acc
  and EXISTS (select 1 from kod_r020_B5 WHERE r020 = a.nbs)
  and s.acc=p.acc(+)
  and s.rnk = c.rnk
  and s.ost - s.CRdos + s.CRkos + s.ostq - s.CRdosq + s.CRkosq <> 0;

CURSOR BaseL IS
   SELECT kodp, SUM(znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;

EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
-- свой МФО
mfo_ := F_Ourmfo ();

-- МФО "родителя"
BEGIN
   SELECT NVL(trim(mfou), mfo_)
      INTO mfou_
   FROM BANKS
   WHERE mfo = mfo_;
EXCEPTION WHEN NO_DATA_FOUND THEN
   mfou_ := mfo_;
END;


l_DAT01t_ := last_day  (dat_) +  1 ; --01 число отчетного месяца   - ТОЛЯ
l_DAT01d_ := add_months(l_DAT01t_,-1); --01 число след.за отч месяца - ДИМА
select caldt_ID into Di_ from accm_calendar where caldt_DATE=l_DAT01d_;

bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);

data_:=to_date('31' || '12' ||
               to_char(to_number(to_char(Dat_,'YYYY'))-1),'DDMMYYYY');

SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

l_DAT01t_ := last_day  (dat3_) +  1 ; --01 число отчетного месяца   - ТОЛЯ
l_DAT01d_ := add_months(l_DAT01t_,-1); --01 число след.за отч месяца - ДИМА
select caldt_ID into Dip_ from accm_calendar where caldt_DATE=l_DAT01d_;

bars_accm_sync.sync_AGG('MONBAL', l_DAT01d_);

-- кол-во счетов в SAL за прошлый год
kolz_pg_ :=0;

SELECT count(*) INTO kolz_pg_
FROM sal
WHERE fdat = Dat3_
  and nbs LIKE '100%'
  and (ost <> 0 OR dos+kos<>0);
-------------------------------------------------------------------
--- остатки отчетного года
OPEN SALDOOG;
LOOP
   FETCH SALDOOG INTO acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      Doszg_, Koszg_, Dos96zg_, Kos96zg_, Dos99zg_, Kos99zg_,
                      r114_, r011_, r013_, rnk_, rez_, s180_,
                      custtype_, sed_ ;
   EXIT WHEN SALDOOG%NOTFOUND;

   kod_11_:='00';
   ddd_ := null;

   IF kv_ <> 980 THEN
      r034_ := '2';
      se_:=Ostq_-Dosq96_+Kosq96_;
   ELSE
      r034_ := '1';
      se_:=Ostn_-Dos96_+Kos96_;
   END IF;

   ---для балансовых счетов 6 и 7 классов вычитаем проводки перекрытия
   if to_char(Dat_,'MM')='12' and
         (substr(nbs_,1,1) in ('6','7') or nbs_ in ('5040','5041')) then
      se_:=se_+Doszg_-Koszg_; -- обороты перекрытия тип "ZG%"
   end if;

   IF se_ <> 0  THEN
      dk_:=IIF_N(se_,0,'1','2','2');

      if ddd_ is null then
         BEGIN
            if r114_ <> '0' then
               SELECT count(*)
                  INTO cnt_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_;

               if cnt_ = 0 then
                  r114_ := '0';
               end if;
            end if;

            if r114_ <> '0' then
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_;
            else
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_;
            end if;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            ddd_:='000';
         WHEN TOO_MANY_ROWS THEN
            if r114_ <> '0' then
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and r114=r114_
                 and rownum=1;
            else
               SELECT NVL(ddd,'000')
                  INTO ddd_
               FROM kod_r020_B5
               WHERE r020=nbs_
                 and t020=dk_
                 and rownum=1;
            end if;
         END;
      end if;

      IF nbs_='3190' THEN
         IF r013_='6' THEN
            ddd_:='127';
         END IF;
      END IF;

      if mfou_ = 300465 then
         IF nbs_ in ('1518','1519','1526','1527','1528','1529','1819',
                     '1890','1919','3578','3579','3590') THEN
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
            IF nbs_='1518' and ob22_ not in ('02','08') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1519' and ob22_ not in ('04','05','06') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1526' and ob22_ = '08' THEN
               ddd_:='101';
            END IF;
            IF nbs_='1527' and ob22_ not in ('02','04','05','07') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1528' and ob22_ in ('06','07') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1529' and ob22_ not in ('01','02','03','04','05','06',
                                             '07','08') THEN
               ddd_:='101';
            END IF;
            IF nbs_='1819' and ob22_ not in ('02','04') THEN
               ddd_:='108';
            END IF;
            IF nbs_='1890' and ob22_ not in ('01','02') THEN
               ddd_:='109';
            END IF;
            IF nbs_='1919' and ob22_ = '02' THEN
               ddd_:='207';
            END IF;
            IF nbs_='3578' and ob22_ not in ('19','20','21','22') THEN
               ddd_:='108';
            END IF;
            IF nbs_='3579' and ob22_ not in ('47','48','49','50','51','52') THEN
               ddd_:='108';
            END IF;
            IF nbs_='3590' and ob22_ not in ('01','02') THEN
               ddd_:='109';
            END IF;
         END IF;
      end if;

      if ddd_ in ('512') then   ---('512','514')
         kod_11_ := '11';
      else
         kod_11_ := '10';
      end if;

      if Dat_ >= to_date('31032009','ddmmyyyy') then
         kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
      else
         kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
      end if;

      znap_:= TO_CHAR(ABS(se_));

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                             (nls_, kv_, data_, kodp_, znap_);


      IF ddd_='120' THEN
         -- в старом варианте файла #B5 в код 121 кредиты ФЛ
         -- вкдлючались эти бал.счета
         if nbs_ like '22%' OR
            nbs_ in ('2620','2625','2627') or
            (nbs_ in ('3578','3579') and rez_ in (5,6) and sed_ != '91')
         then
            kod_11_ := '12';
         else
            kod_11_ := '11';
         end if;

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);
      END IF;

      IF ddd_='208' and nbs_ in ('2520','2523','2526','2528',
                                 '2530','2531','2538',
                                 '2541','2542','2544','2545','2548',
                                 '2553','2555','2558',
                                 '2560','2561','2562','2565','2568',
                                 '2571',
                                 '2600','2601','2602','2603','2604','2605','2606','2608',
                                 '2643','2650','2655','2658') THEN

         kod_11_ := '11';

         IF mfou_ = 300465 and nbs_ in ('2548','2568') THEN
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
         END IF;

         IF mfou_ = 300465 and nbs_ = '2548' THEN
            IF ob22_ not in ('02') THEN
               kod_11_ := '10';
            END IF;
         END IF;

         IF mfou_ = 300465 and nbs_ = '2658' THEN
            IF ob22_ not in ('01','04','21','24','25','26','27','28','29') THEN
               kod_11_ := '10';
            END IF;
         END IF;

         if mfou_ != 300465 then
            if r011_ in ('5','6') THEN
               KOD_11_ := '10';
            END IF;
         end if;

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         if kod_11_ = '11' then
            znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);
         end if;
      END IF;

      IF ddd_='209' and nbs_ in ('2620','2622','2625','2628') THEN

         kod_11_ := '11';

         if Dat_ >= to_date('31032009','ddmmyyyy') then
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
            kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);
      END IF;

      IF nbs_='5100' THEN
         IF r011_='1' and mfou_ != 300465 THEN
            ddd_:='514';
         END IF;

         if mfou_ = 300465 then
            BEGIN
               SELECT NVL(ob22,'00')
                  INTO ob22_
               FROM specparam_int
               WHERE acc=acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               ob22_:='00';
            END ;
            IF ob22_ in ('02','03','13','14','15','16') THEN
               ddd_:='514';
            END IF;
         end if;

         IF ddd_='514' then
            kod_11_ := '11';
            if Dat_ >= to_date('31032009','ddmmyyyy') then
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
            else
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
            end if;

            znap_:= TO_CHAR(ABS(se_));

            INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);

         END IF;
      END IF;

      IF nbs_='5101' THEN
         ddd_:='512';
         kod_11_ := '11';
         if Dat_ >= to_date('31032009','ddmmyyyy') then
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
         else
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
         end if;

         znap_:= TO_CHAR(ABS(se_));

         INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                (nls_, kv_, data_, kodp_, znap_);

      END IF;
   END IF;
END LOOP;
CLOSE SALDOOG;
-------------------------------------------------------------------------
IF to_number(to_char(Dat3_,'YYYY'))=to_number(to_char(Dat_,'YYYY'))-1
   and  kolz_pg_ <> 0 then
    --- остатки последнего рабочего дня предыдущего года
    OPEN SALDOPG;
    LOOP
       FETCH SALDOPG INTO acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                          Dos96_, Dosq96_, Kos96_, Kosq96_,
                          Dos99_, Dosq99_, Kos99_, Kosq99_,
                          Doszg_, Koszg_, Dos96zg_, Kos96zg_, Dos99zg_, Kos99zg_ ,
                          r114_, r011_, r013_, rnk_, rez_, s180_, custtype_, sed_ ;
       EXIT WHEN SALDOPG%NOTFOUND;

       kod_11_:='00';
       ddd_ := null;

       IF kv_ <> 980 THEN
          r034_ := '2';
          se_:=Ostq_-Dosq96_+Kosq96_-Dosq99_+Kosq99_;
       ELSE
          r034_ := '1';
          se_:=Ostn_-Dos96_+Kos96_-Dos99_+Kos99_;
       END IF;

       if substr(nbs_,1,1) in ('6','7') or nbs_ in ('5040','5041') then
          se_:=se_+Doszg_-Koszg_;     -- обороты перекрытия тип "ZG%"
       end if;

       IF se_ <> 0  THEN
          dk_:=IIF_N(se_,0,'1','2','2');

          if ddd_ is null then
             BEGIN
                if r114_ <> '0' then
                   SELECT count(*)
                      INTO cnt_
                   FROM kod_r020_B5
                   WHERE r020=nbs_
                     and t020=dk_
                     and r114=r114_;

                   if cnt_ = 0 then
                      r114_ := '0';
                   end if;
                end if;

                if r114_ <> '0' then
                   SELECT NVL(ddd,'000')
                      INTO ddd_
                   FROM kod_r020_B5
                   WHERE r020=nbs_
                     and t020=dk_
                     and r114=r114_;
                else
                   SELECT NVL(ddd,'000')
                      INTO ddd_
                   FROM kod_r020_B5
                   WHERE r020=nbs_
                     and t020=dk_;
                end if;
             EXCEPTION WHEN NO_DATA_FOUND THEN
                ddd_:='000';
         WHEN TOO_MANY_ROWS THEN
                if r114_ <> '0' then
                   SELECT NVL(ddd,'000')
                      INTO ddd_
                   FROM kod_r020_B5
                   WHERE r020=nbs_
                     and t020=dk_
                     and r114=r114_
                     and rownum=1;
                else
                   SELECT NVL(ddd,'000')
                      INTO ddd_
                   FROM kod_r020_B5
                   WHERE r020=nbs_
                     and t020=dk_
                     and rownum=1;
                end if;
             END;
          end if;

          IF nbs_='3190' THEN
             IF r013_='6' THEN
                ddd_:='127';
             END IF;
          END IF;

          if mfou_ = 300465 then
             IF nbs_ in ('1518','1519','1526','1527','1528','1529','1819',
                         '1890','1919','3578','3579','3590') THEN
                BEGIN
                   SELECT NVL(ob22,'00')
                      INTO ob22_
                   FROM specparam_int
                   WHERE acc=acc_;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   ob22_:='00';
                END ;
                IF nbs_='1518' and ob22_ not in ('02','08') THEN
                   ddd_:='101';
                END IF;
                IF nbs_='1519' and ob22_ not in ('04','05','06') THEN
                   ddd_:='101';
                END IF;
                IF nbs_='1526' and ob22_ = '08' THEN
                   ddd_:='101';
                END IF;
                IF nbs_='1527' and ob22_ not in ('02','04','05','07') THEN
                   ddd_:='101';
                END IF;
                IF nbs_='1528' and ob22_ in ('06','07') THEN
                   ddd_:='101';
                END IF;
                IF nbs_='1529' and ob22_ not in ('01','02','03','04','05','06',
                                                 '07','08') THEN
                   ddd_:='101';
                END IF;
                IF nbs_='1819' and ob22_ not in ('02','04') THEN
                   ddd_:='108';
                END IF;
                IF nbs_='1890' and ob22_ not in ('01','02') THEN
                   ddd_:='109';
                END IF;
                IF nbs_='1919' and ob22_ = '02' THEN
                   ddd_:='207';
                END IF;
                IF nbs_='3578' and ob22_ not in ('19','20','21','22') THEN
                   ddd_:='108';
                END IF;
                IF nbs_='3579' and ob22_ not in ('47','48','49','50','51','52') THEN
                   ddd_:='108';
                END IF;
                IF nbs_='3590' and ob22_ not in ('01','02') THEN
                   ddd_:='109';
                END IF;
             END IF;
          end if;

          if ddd_ in ('512') then   ---('512','514')
             kod_11_ := '21';
          else
             kod_11_ := '20';
          end if;

          if Dat_ >= to_date('31032009','ddmmyyyy') then
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
          else
             kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
          end if;

          znap_:= TO_CHAR(ABS(se_));

          INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                 (nls_, kv_, data_, kodp_, znap_);


          IF ddd_='120' THEN
             -- в старом варианте файла #B5 в код 121 кредиты ФЛ
             -- вкдлючались эти бал.счета
             if nbs_ like '22%' OR
                nbs_ in ('2620','2625','2627') or
                (nbs_ in ('3578','3579') and rez_ in (5,6) and sed_ != '91')
             then
                kod_11_ := '22';
             else
                kod_11_ := '21';
             end if;

             if Dat_ >= to_date('31032009','ddmmyyyy') then
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
             else
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
             end if;

             znap_:= TO_CHAR(ABS(se_));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);
          END IF;

          IF ddd_='208' and nbs_ in ('2520','2523','2526','2528',
                                     '2530','2531','2538',
                                     '2541','2542','2544','2545','2548',
                                     '2553','2555','2558',
                                     '2560','2561','2562','2565','2568',
                                     '2571',
                                     '2600','2601','2602','2603','2604','2605','2606','2608',
                                     '2643','2650','2655','2658') THEN

             kod_11_ := '21';

             IF mfou_ = 300465 and nbs_ in ('2548','2568') THEN
                BEGIN
                   SELECT NVL(ob22,'00')
                      INTO ob22_
                   FROM specparam_int
                   WHERE acc=acc_;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   ob22_:='00';
                END ;
             END IF;

             IF mfou_ = 300465 and nbs_ = '2548' THEN
                IF ob22_ not in ('02') THEN
                   kod_11_ := '20';
                END IF;
             END IF;

             IF mfou_ = 300465 and nbs_ = '2658' THEN
                IF ob22_ not in ('01','04','21','24','25','26','27','28','29') THEN
                   kod_11_ := '20';
                END IF;
             END IF;

             if mfou_ != 300465 then
                if r011_ in ('5','6') THEN
                   KOD_11_ := '20';
                END IF;
             end if;

             if Dat_ >= to_date('31032009','ddmmyyyy') then
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
             else
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
             end if;

             if kod_11_ = '21' then
                znap_:= TO_CHAR(ABS(se_));

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                        (nls_, kv_, data_, kodp_, znap_);
             end if;
          END IF;

          IF ddd_='209' and nbs_ in ('2620','2622','2625','2628') THEN

             kod_11_ := '21';

             if Dat_ >= to_date('31032009','ddmmyyyy') then
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
             else
                kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
             end if;

             znap_:= TO_CHAR(ABS(se_));

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                        (nls_, kv_, data_, kodp_, znap_);
          END IF;

          IF nbs_='5100' THEN
             IF r011_='1' and mfou_ != 300465 THEN
                ddd_:='514';
             END IF;

             if mfou_ = 300465 then
                BEGIN
                   SELECT NVL(ob22,'00')
                      INTO ob22_
                   FROM specparam_int
                   WHERE acc=acc_;
                EXCEPTION WHEN NO_DATA_FOUND THEN
                   ob22_:='00';
                END ;
                IF ob22_ in ('02','03','13','14','15','16') THEN
                   ddd_:='514';
                END IF;
             end if;

             IF ddd_='514' then
                kod_11_ := '21';
                if Dat_ >= to_date('31032009','ddmmyyyy') then
                    kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
                else
                    kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
                end if;

                znap_:= TO_CHAR(ABS(se_));

                INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                        (nls_, kv_, data_, kodp_, znap_);

             END IF;
          END IF;

          IF nbs_='5101' THEN
             ddd_:='512';
             kod_11_ := '21';
             if Dat_ >= to_date('31032009','ddmmyyyy') then
                 kodp_:= dk_ || RTRIM(ddd_) || kod_11_ || r034_;
             else
                 kodp_:= dk_ || RTRIM(ddd_) || kod_11_ ;
             end if;

             znap_:= TO_CHAR(ABS(se_));

             INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap) VALUES
                                    (nls_, kv_, data_, kodp_, znap_);

          END IF;
       END IF;

    END LOOP;
    CLOSE SALDOPG;
END IF;
-----------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_nbu
        (kodf, datf, kodp, znap)
   VALUES
        (kodf_, Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END;
/
show err;

PROMPT *** Create  grants  P_FB5_SNAP ***
grant EXECUTE                                                                on P_FB5_SNAP      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_FB5_SNAP      to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_FB5_SNAP.sql =========*** End **
PROMPT ===================================================================================== 
