

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F38SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F38SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F38SB (Dat_ DATE ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :    ѕроцедура формировани¤ файла @38 дл¤ —Ѕ
% DESCRIPTION :    ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     :    07/04/2015 (30.04.2011)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 30.04.2011 - добавил†acc,tobo в протокол
% 17.03.2011 - в поле комментарий вносим код TOBO и название счета
% 19.03.2010 - закомментировал блок дл¤ Ћуцка в котором выбиралась часть
%              оборотов из табл.—карба до 18.09.2009 и часть оборотов из
%              Ѕарса больше 18.09.2009
% 26.01.2007 - с 01.01.2007 нова¤ структура показател¤ DDBBBBZZVVV
%              (дабавлен код бал.счета "BBBB")
% 17.01.2007 - добавлен дл¤ обработки бал.счет 9920
% 10.11.2008 - добавл¤ютс¤ счета дл¤ которых нет оборотов за мес¤ц и есть
%              только корректирующие проводки в курсорах дл¤ оборотов
% 09.10.2009 - дл¤ Ћуцка будем отбирать часть оборотов из табл.—карба
%              до 18.09.2009 и часть оборотов из Ѕарса больше 18.09.2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_    Number;
acc1_   Number;
dat1_   Date;
dat2_   Date;
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
Dosnk_  DECIMAL(24);
Kosnk_  DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
kodp_   varchar2(11);
znap_   varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    varchar2(4);
nls_    varchar2(15);
rnk_     Number;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Dos96p_  DECIMAL(24);
Dosq96p_ DECIMAL(24);
Kos96p_  DECIMAL(24);
Kosq96p_ DECIMAL(24);
Dos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kos96_   DECIMAL(24);
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
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
s0000_  varchar2(15);
s0009_  varchar2(15);
data_   date;
zz_     Varchar2(2);
dk_     char(1);
userid_ Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_     number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;


CURSOR Saldo IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tobo, a.nms, NVL(trim(sp.ob22),'00')
    FROM  otcn_saldo s, otcn_acc a, specparam_int sp
    WHERE s.acc=a.acc
      and s.acc=sp.acc(+);

CURSOR BaseL IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------

Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);

if f_ourmfo()=303398 and Dat_=to_date('30092009','ddmmyyyy') then
   dat1_ := to_date('18092009','ddmmyyyy');
end if;
-------------------------------------------------------------------
-- используем классификатор SB_R020
sql_acc_ := ' ''3800'',''9920'' ';

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    tobo_, nms_, zz_;
   EXIT WHEN Saldo%NOTFOUND;

   comm_ := '';

   sn_   := 0;
   se_   := 0;
   Dose_ := 0;
   Kose_ := 0;
   Dosn_ := 0;
   Kosn_ := 0;

   if kv_ = 980 then
      se_:=Ostn_-Dos96_+Kos96_;
      Dose_ := Dose_ + Dos_ - Dos96p_ + Dos96_;
      Kose_ := Kose_ + Kos_ - Kos96p_ + Kos96_;
   else
      sn_:=Ostn_-Dos96_+Kos96_;
      Dosn_ := Dosn_ + Dos_ - Dos96p_ + Dos96_;
      Kosn_ := Kosn_ + Kos_ - Kos96p_ + Kos96_;

      se_:=Ostq_-Dosq96_+Kosq96_;
      Dose_ := Dose_ + Dosq_ - Dosq96p_ + Dosq96_;
      Kose_ := Kose_ + Kosq_ - Kosq96p_ + Kosq96_;
   end if;

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   IF se_ <> 0 THEN
      dk_:=IIF_N(se_,0,'1','2','2');
      kodp_:= dk_ || '0' || nbs_ || zz_ || lpad(kv_,3,'0');
      znap_:= TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, acc, comm, tobo) VALUES
                             (nls_, kv_, data_, kodp_,znap_, 0, acc_, comm_, tobo_) ;
   END IF ;

   IF sn_ <> 0 THEN
      dk_:=IIF_N(sn_,0,'1','2','2');
      kodp_:= dk_ || '1' || nbs_ || zz_ || lpad(kv_,3,'0');
      znap_:= TO_CHAR(ABS(sn_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, acc, comm, tobo) VALUES
                             (nls_, kv_, data_, kodp_,znap_, 0, acc_, comm_, tobo_) ;
   END IF ;

   IF Dose_ <> 0 OR Kose_ <> 0 THEN
      IF Dose_ > 0 THEN
         kodp_:='50' || nbs_ || zz_ || SUBSTR(to_char(1000+Kv_),2,3) ;
         znap_:=TO_CHAR(Dose_);
         INSERT INTO rnbu_trace     -- ?б. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
     elsif Dose_ < 0 THEN
         kodp_:='60' || nbs_ || zz_ || SUBSTR(to_char(1000+Kv_),2,3) ;
         znap_:=TO_CHAR(-Dose_);
         INSERT INTO rnbu_trace     -- ?б. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
     END IF;

      IF Kose_ > 0 THEN
         kodp_:='60' || nbs_ || zz_ || SUBSTR(to_char(1000+Kv_),2,3) ;
         znap_:=TO_CHAR(Kose_) ;
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      elsif Kose_ < 0 THEN
         kodp_:='50' || nbs_ || zz_ || SUBSTR(to_char(1000+Kv_),2,3) ;
         znap_:=TO_CHAR(Kose_) ;
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF;
   END IF;

   IF Dosn_ > 0 OR Kosn_ > 0 THEN
      IF Dosn_ > 0 THEN
         kodp_:='51' || nbs_ || zz_ || SUBSTR(to_char(1000+Kv_),2,3) ;
         znap_:=TO_CHAR(Dosn_);
         INSERT INTO rnbu_trace     -- ?б. обороты в номинале валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF;

      IF Kosn_ > 0 THEN
         kodp_:='61' || nbs_ || zz_ || SUBSTR(to_char(1000+Kv_),2,3) ;
         znap_:=TO_CHAR(Kosn_) ;
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF;
   END IF;

END LOOP;
CLOSE Saldo;
------------------------------------------------------------------------------------------
-- дл¤ отчетной даты 30.09.2009 часть оборотов выбираем из таблиц —карба
/*
if f_ourmfo()=303398 and Dat_=to_date('30092009','ddmmyyyy') then
   for k in (select s.acc, a.nls_bars, a.kv,
                 sum(a.dos) dos, sum(a.kos) kos,
                 sum(a.dos_v) dosv, sum(a.kos_v) kosv
          from test_s6_obnls a, accounts s
          where a.fdat >= to_date('01092009','ddmmyyyy')
            and a.fdat <= to_date('18092009','ddmmyyyy')
            and a.nls_bars is not null
            and a.nls_bars=s.nls
            and s.nbs in ('3800','9920')
            and a.kv=s.kv
            group by s.acc, a.nls_bars, a.kv )

   loop

      BEGIN
         SELECT NVL(ob22,'00') into zz_
         FROM specparam_int
         WHERE acc=k.acc;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         zz_:='00';
      END ;

       nbs_ := substr(k.nls_bars,1,4);
       data_ := to_date('18092009','ddmmyyyy');

       if k.dos <> 0 then
          kodp_ := '50' || nbs_ || zz_ || lpad(to_char(k.kv),3,'0');
          znap_ := to_char(k.dos);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, acc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '303398', k.acc);
       end if;

       if k.kos <> 0 then
          kodp_ := '60' || nbs_ || zz_ || lpad(to_char(k.kv),3,'0');
          znap_ := to_char(k.kos);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, acc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '303398', k.acc);
       end if;

       if k.dosv <> 0 then
          kodp_ := '51' || nbs_ || zz_ || lpad(to_char(k.kv),3,'0');
          znap_ := to_char(k.dosv);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, acc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '303398', k.acc);
       end if;

       if k.kosv <> 0 then
          kodp_ := '61' || nbs_ || zz_ || lpad(to_char(k.kv),3,'0');
          znap_ := to_char(k.kosv);
          insert into rnbu_trace
                   (nls, kv, odate, kodp, znap, nbuc, acc)
           VALUES  (k.nls_bars, k.kv, data_, kodp_, znap_, '303398', k.acc);
       end if;

   end loop;
end if;
*/
---------------------------------------------------
DELETE FROM tmp_irep where kodf='38' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('38', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f38sb;
/
show err;

PROMPT *** Create  grants  P_F38SB ***
grant EXECUTE                                                                on P_F38SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F38SB         to RPBN002;
grant EXECUTE                                                                on P_F38SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F38SB.sql =========*** End *** =
PROMPT ===================================================================================== 
