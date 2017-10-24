

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F11SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F11SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F11SB (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : otcn.sql
% DESCRIPTION : ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 30.04.2011 (01.03.2011,23.02.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 30.04.2011 - добавил†acc,tobo в протокол
% 01.03.2011 - в поле комментарий вносим код TOBO и название счета
% 23.02.2009 - рахунки вибироЇмо iз SB_R020 F_11='1'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_     Number;
acc1_    Number;
acc3_    Number;
nbs_     Varchar2(4);
nls_     Varchar2(15);
data_    date;
dat1_    Date;
dat2_    Date;
sn_      DECIMAL(24);
se_      DECIMAL(24);
Dosn_    DECIMAL(24);
Kosn_    DECIMAL(24);
Dosek_   DECIMAL(24);
Kosek_   DECIMAL(24);
cust_    SMALLINT;
rnk_     Number;
dk_      char(1);
Kv_      Number;
kodp_    varchar2(11);
znap_    varchar2(30);
f_11n_   Varchar2(1);
f11_     SMALLINT;
s080_    char(1);
k081_    char(1);
k041_    char(1);
nbu_     SMALLINT;
prem_    char(3);
userid_  Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	 number;
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
          nvl(sp.s080,'0'), d.k041, NVL(f.k081,'1'), a.nms, a.tobo
    FROM  otcn_saldo s, customer c, accounts a, specparam sp, kl_k040 d,
          kl_k080 f
   WHERE s.acc = a.acc
     and a.daos >= to_date('01082000','ddmmyyyy')
     and s.rnk=c.rnk
     and s.acc=sp.acc(+)
     and c.country=TO_NUMBER(d.k040)
     and c.fs=f.k080;

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
-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where f_11=''1'' ';

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);

Dat1_ := TRUNC(Dat_,'MM'); -- початок попереднього м_с€ц€
Dat2_ := TRUNC(Dat_ + 28);
----------------------------------------------------------------------------
OPEN Saldo;
   LOOP
   FETCH Saldo INTO rnk_, acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    s080_, k041_, k081_, nms_, tobo_;
   EXIT WHEN Saldo%NOTFOUND;

   comm_ := '';

   if kv_ = 980 then
      se_:=Ostn_-Dos96_+Kos96_;
   else
      se_:=Ostq_-Dosq96_+Kosq96_;
   end if;

   f_11n_:='0' ;

   BEGIN
      SELECT NVL(f_11,'0') INTO f_11n_
      FROM  specparam_int
      WHERE acc=acc_ ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      f_11n_:='0' ;
   END ;

   IF se_ < 0 and f_11n_='0' THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      dk_:=IIF_N(se_,0,'1','2','2');
      kodp_:= dk_ || nbs_ || s080_ || k081_ || k041_ ||
              SUBSTR( to_char(1000+Kv_), 2, 3);
      znap_:= TO_CHAR(ABS(se_)) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, tobo) VALUES
                             (nls_, Kv_, data_, kodp_, znap_, acc_, comm_, tobo_);
   END IF;

END LOOP;
CLOSE SALDO;
-------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='11' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('11', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------
END p_f11sb;
/
show err;

PROMPT *** Create  grants  P_F11SB ***
grant EXECUTE                                                                on P_F11SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F11SB         to RPBN002;
grant EXECUTE                                                                on P_F11SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F11SB.sql =========*** End *** =
PROMPT ===================================================================================== 
