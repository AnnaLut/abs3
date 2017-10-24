

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F7B.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F7B ***

  CREATE OR REPLACE PROCEDURE BARS.P_F7B (Dat_ DATE,
                                      sheme_ varchar2 default 'G') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования файла #7B для КБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 07/04/2012 (31/03/2012)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
параметры: Dat_ - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
07.04.2012 - формировался показатель длиной 6 символов, а необходимо 7.
             Исправлено.
31.03.2012 - первая версия
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2):='7B';
acc_     Number;
acc1_    Number;
id_      Number;
dk_      Varchar2(2);
nbs_     Varchar2(4);
nls_     Varchar2(15);
dd_      Varchar2(2);
Dat1_    Date;
Dat2_    Date;
Dat3_    Date;
Dat4_    Date;
data_    Date;
Datnp_   Date;
kv_      SMALLINT;
r013_    Varchar2(1);
r035_    Varchar2(1);
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Dos96_   DECIMAL(24);
Kos96_   DECIMAL(24);
Dosq96_  DECIMAL(24);
Kosq96_  DECIMAL(24);
Doszg_   DECIMAL(24);
Koszg_   DECIMAL(24);
Dos96zg_ DECIMAL(24);
Kos96zg_ DECIMAL(24);
Dos99zg_ DECIMAL(24);
Kos99zg_ DECIMAL(24);
sn_      DECIMAL(24);
se_      DECIMAL(24);
kodp_    Varchar2(14);
kodp1_   Varchar2(14);
znap_    Varchar2(30);
ddd_     Varchar(3);
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	 number;
rnk_     number;
nbuc1_   varchar2(20);
nbuc_    varchar2(20);
typ_     Number;
kolz_pg_ number;
mfo_     Number;
mfou_    Number;
tobo_    accounts.tobo%TYPE;
nms_     otcn_acc.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
daos_    Date;
add_     NUMBER;

--- остатки счетов+месячные корректирующие обороты+
CURSOR SALDO IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          NVL(k.ddd,'000'), NVL(r.r035,'1'), NVL(trim(sp.r013),'9'),
          a.tobo, a.nms
   FROM  otcn_saldo s, otcn_acc a, kl_f3_29 k, kl_r030 r, specparam sp
   WHERE a.acc=s.acc
     and s.nbs = k.r020
     and k.kf='7B'
     and s.kv = r.r030
     and s.acc = sp.acc(+);

--- остатки счетов+месячные корректирующие обороты прошлый год
CURSOR SALDOPG IS
   SELECT s.rnk, s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          NVL(k.ddd,'000'), NVL(r.r035,'1'), NVL(trim(sp.r013),'9'),
          a.tobo, a.nms
   FROM  otcn_saldo s, otcn_acc a, kl_f3_29 k, kl_r030 r, specparam sp
   WHERE a.acc=s.acc
     and s.nbs = k.r020
     and k.kf='7B'
     and s.kv = r.r030
     and s.acc = sp.acc(+);

CURSOR BaseL IS
   SELECT kodp, nbuc, SUM(znap)
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY kodp, nbuc;

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
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

Dat1_:= TRUNC(add_months(Dat_,1),'MM');
Datnp_ := TRUNC(Dat_,'MM');

data_:=to_date('31' || '12' ||
               to_char(to_number(to_char(Dat_,'YYYY'))-1),'DDMMYYYY');

SELECT max(Fdat) INTO Dat3_ FROM FDAT WHERE fdat<=data_;

Dat4_:=TRUNC(Dat3_ + 28);

-- кол-во счетов в SAL за прошлый год
kolz_pg_ :=0;

SELECT count(*) INTO kolz_pg_
FROM sal
WHERE fdat = Dat3_
  and nbs LIKE '100%'
  and (ost <> 0 OR dos+kos<>0);

-- определение кода МФО или кода области для выбранного файла и схемы
p_proc_set(kodf_,sheme_,nbuc1_,typ_);

sql_acc_ := 'select distinct r020 from kl_f3_29 where kf=''7B''';
ret_ := f_pop_otcn(Dat_, 2, sql_acc_);
-------------------------------------------------------------------
--- остатки
OPEN SALDO;
LOOP
   FETCH SALDO INTO   rnk_, acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos_, Dosq_, Kos_, Kosq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      ddd_, r035_, r013_, tobo_, nms_ ;
   EXIT WHEN SALDO%NOTFOUND;

   comm_ := '';

   if nbs_ in ('9129','3690') then
      comm_ := substr(comm_||tobo_||'  '||nms_||'  '||'R013='||r013_,1,200);
   else
      comm_ := substr(comm_||tobo_||'  '||nms_,1,200);
   end if;

   if kv_ = 980 then
      se_:=Ostn_-Dos96_+Kos96_;
   else
      se_:=Ostq_-Dosq96_+Kosq96_;
   end if;

   if nbs_ = '9129' and r013_ = '9' then
      ddd_ := '913';
   end if;

   IF se_ <> 0  THEN

      dk_:=IIF_N(se_,0,'1','2','2');

      if typ_>0 then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      kodp_:= dk_ || ddd_ || '1' || '0' || r035_ ;
      znap_:= TO_CHAR(ABS(se_));

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm)
      VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, comm_);

   end if;

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------------
IF to_number(to_char(Dat3_,'YYYY'))=to_number(to_char(Dat_,'YYYY'))-1
   and  kolz_pg_ <> 0 then

-- предыдущий год
ret_ := f_pop_otcn(Dat3_, 2, sql_acc_);

--- остатки последнего рабочего дня предыдущего года
OPEN SALDOPG;
LOOP
   FETCH SALDOPG INTO   rnk_, acc_, nls_, kv_, data_, nbs_, Ostn_, Ostq_,
                      Dos_, Dosq_, Kos_, Kosq_,
                      Dos96_, Dosq96_, Kos96_, Kosq96_,
                      ddd_, r035_, r013_, tobo_, nms_ ;
   EXIT WHEN SALDOPG%NOTFOUND;

   comm_ := '';

   if nbs_ in ('9129','3690') then
      comm_ := substr(comm_||tobo_||'  '||nms_||'  '||'R013='||r013_,1,200);
   else
      comm_ := substr(comm_||tobo_||'  '||nms_,1,200);
   end if;

   if kv_ = 980 then
      se_:=Ostn_-Dos96_+Kos96_;
   else
      se_:=Ostq_-Dosq96_+Kosq96_;
   end if;

   if nbs_ = '9129' and r013_ = '9' then
      ddd_ := '913';
   end if;

   IF se_ <> 0  THEN

      dk_:=IIF_N(se_,0,'1','2','2');

      if typ_>0 then
         nbuc_ := nvl(f_codobl_tobo(acc_,typ_),nbuc1_);
      else
         nbuc_ := nbuc1_;
      end if;

      kodp_:= dk_ || ddd_ || '2' || '0' || r035_ ;
      znap_:= TO_CHAR(ABS(se_));

      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, nbuc, rnk, comm)
      VALUES (nls_, kv_, data_, kodp_, znap_, nbuc_, rnk_, comm_);

   end if;

END LOOP;
CLOSE SALDOPG;
end if;
-----------------------------------------------------------------------------
DELETE FROM tmp_nbu where kodf=kodf_ and datf= dat_;
---------------------------------------------------
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
----------------------------------------
END p_f7b;
/
show err;

PROMPT *** Create  grants  P_F7B ***
grant EXECUTE                                                                on P_F7B           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F7B           to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F7B.sql =========*** End *** ===
PROMPT ===================================================================================== 
