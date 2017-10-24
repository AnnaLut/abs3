

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F17SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F17SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F17SB (Dat_ DATE) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирования @17 для Ощадбанку
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.  All Rights Reserved.
% VERSION     : 15.01.2011 (11.05.2011,20.04.2011,01.03.2011,25.02.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% параметры: Dat_ - отчетная дата
% 15.01.2012 - изменил формирование файла по SNAP таблице
%              (проверил в Сумском облуправлении)
% 11.05.2011 - добавил acc,tobo в протокол
% 20.04.2011 - для кода процентов '3' изменил условие на >=0 вместо <>0
% 01.03.2011 - в поле комментарий вносим код TOBO и название счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
fmt_     varchar2(20):='999990D0000';
acc_    Number;
acc1_    Number;
acc2_    Number;
s_      Varchar2(1);
dat1_   Date;
dat2_   Date;
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
Dosnk_  DECIMAL(24);
Dosek_  DECIMAL(24);
Kosnk_  DECIMAL(24);
Kosek_  DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
sum1_    number;
sum0_    number;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Dosnkg_  DECIMAL(24);
Dosekg_  DECIMAL(24);
Kosnkg_  DECIMAL(24);
Kosekg_  DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
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
Ostq_    DECIMAL(24);
kodp_   varchar2(14);
kodp1_  varchar2(14);
tp_     varchar2(2);
znap_   varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    varchar2(4);
nls_    varchar2(15);
s0000_  varchar2(15);
s0009_  varchar2(15);
data_   date;
data1_  date;
dazs_   Date;
ob22_   Varchar2(2);
f17_    Number;
kod1_   Varchar2(1);
dk_     Varchar2(2);
sPCnt_   Number;
sPCnt1_  Varchar2(10);
S180_    Varchar2(1);
nbu_    SMALLINT;
prem_   char(3);
userid_ Number;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	 number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;

CURSOR Saldo IS
   SELECT a.acc, a.nls, a.kv, a.daos, a.dazs, a.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          DECODE(trim(p.s180), NULL, FS180(a.acc), p.s180),
          NVL(acrn.FPROC(a.acc, Dat_),0),
          a.tobo, a.nms, NVL(trim(sp.ob22),'00')
   FROM  otcn_saldo s, otcn_acc a, specparam p, specparam_int sp
   WHERE a.acc=s.acc
     and s.acc=p.acc(+)
     and s.acc=sp.acc(+) ;

CURSOR BaseL IS
    SELECT a.kodp, b.kodp, SUM(TO_NUMBER(a.znap)),
           SUM(TO_NUMBER(a.znap)*TO_NUMBER(b.znap))
    FROM rnbu_trace a, rnbu_trace b
    WHERE SUBSTR(a.kodp,2,13)=SUBSTR(b.kodp,2,13) AND
          SUBSTR(a.kodp,1,1)='1'            AND
          SUBSTR(b.kodp,1,1)='3'            AND
          a.nls = b.nls                     AND
          TO_NUMBER(b.znap)>=0              AND
          a.userid = userid_                AND
          b.userid = userid_                AND
          a.recid = b.recid-1               AND
--          a.nbuc = b.nbuc	            and
	  a.ODATE = b.ODATE
    GROUP BY a.kodp, b.kodp;

CURSOR BaseL1 IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
    WHERE substr(kodp,1,1)='2' and userid=userid_
    GROUP BY kodp;

procedure p_ins(p_dat_ date, p_tp_ varchar2, p_acc_ number, p_nls_ varchar2,
                p_nbs_ varchar2, p_ob22_ varchar2, p_kv_ smallint,
  		p_znap_ varchar2, p_s180_ varchar2, p_sPCnt_ varchar2,
                p_s_ varchar2, p_comm_ varchar2, p_tobo_ varchar2) IS
                kod_ varchar2(14);

begin

   --kodp_:='1' || tp_ || Nbs_ || ob22_ ||s180_ || SUBSTR(tochar(1000+Kv_),2,3) || s_;

   if length(trim(p_tp_))=1 then
      IF p_kv_=980 THEN
         kod1_:='0' ;
      ELSE
         kod1_:='1' ;
      END IF ;
   else
      kod1_:= '';
   end if;

   kod_:= '1' || p_tp_ || kod1_ || p_nbs_ || p_ob22_ || p_s180_ || lpad(p_kv_,3,'0') || p_s_;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, acc, comm, tobo)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_acc_, p_comm_, p_tobo_);

   kod_:= '3' || p_tp_ || kod1_ || p_nbs_ || p_ob22_ || p_s180_ || lpad(p_kv_,3,'0') || p_s_;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, acc, comm, tobo)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_sPCnt_, p_acc_, p_comm_, p_tobo_);

   kod_:= '2' || p_tp_ || kod1_ || p_nbs_ || p_ob22_ || p_s180_ || lpad(p_kv_,3,'0') || p_s_;

   INSERT INTO rnbu_trace
            (nls, kv, odate, kodp, znap, acc, comm, tobo)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, '1', p_acc_, p_comm_, p_tobo_);
end;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
---Dat1_:=TO_DATE('17-11-2000','DD-MM-YYYY');
Dat2_ := TRUNC(Dat_ + 28);
--------------------- Корректирующие проводки ---------------------
-- используем классификатор SB_R020
sql_acc_ := 'select r020 from sb_r020 where trim(f_17) is not null ';

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
-------------------------------------------------------------------
-- Остатки (грн. + валюта номиналы) --
OPEN Saldo;
   LOOP
   FETCH Saldo INTO acc_, nls_, kv_, data_, dazs_, Nbs_, Ostn_, Ostq_,
                    Dos_, Dosq_, Kos_, Kosq_,
                    Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                    Dos96_, Dosq96_, Kos96_, Kosq96_,
                    Dos99_, Dosq99_, Kos99_, Kosq99_,
                    Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                    s180_, sPCnt_, tobo_, nms_, ob22_;
   EXIT WHEN Saldo%NOTFOUND;


   comm_ := '';
   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
   s_ := '0';

   if data_ < dat1_ and dazs_ is null then
      s_:= '1';
   end if;
   if data_ >= dat1_ and data_ <= dat_ and dazs_ is null then
      s_:= '0';
   end if;
   if dazs_ is not null and dazs_ >= dat1_ and dazs_ <= dat_ then
      s_:= '3';
   end if;

   Dos_:=Dos_-Dos96p_-Dos99_;
   Dosq_:=Dosq_-Dosq96p_-Dosq99_;
   Kos_:=Kos_-Kos96p_-Kos99_;
   Kosq_:=Kosq_-Kosq96p_-Kosq99_;

-- начало ** вставил 28.09.2005
   IF Dos_ < 0 THEN
      Kos_:=Kos_+ABS(Dos_);
   END IF;

   IF Kos_ < 0 THEN
      Dos_:=Dos_+ABS(Kos_);
   END IF;
-- окончание **

   IF Dosq_ < 0 THEN
      Kosq_:=Kosq_+ABS(Dosq_);
   END IF;

   IF Kosq_ < 0 THEN
      Dosq_:=Dosq_+ABS(Kosq_);
   END IF;

   IF Dos_ > 0 THEN
      p_ins(data_, '5', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Dos_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Dosq_ > 0 THEN
      p_ins(data_, '50', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Dosq_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Kos_ > 0 THEN
      p_ins(data_, '6', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Kos_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Kosq_ > 0 THEN
      p_ins(data_, '60', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Kosq_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Dos96_ > 0 THEN
      p_ins(data_, '7', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Dos96_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Dosq96_ > 0 THEN
      p_ins(data_, '70', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Dosq96_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Kos96_ > 0 THEN
      p_ins(data_, '8', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Kos96_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Kosq96_ > 0 THEN
      p_ins(data_, '80', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Kosq96_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Dos99_ > 0 THEN
      p_ins(data_, '9', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Dos99_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Dosq99_ > 0 THEN
      p_ins(data_, '90', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Dosq99_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Kos99_ > 0 THEN
      p_ins(data_, '0', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Kos99_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   IF Kosq99_ > 0 THEN
      p_ins(data_, '00', acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(Kosq99_), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   Ostn_:=Ostn_-Dos96_+Kos96_;
   IF Ostn_<>0 THEN
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(ABS(Ostn_)), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

   Ostq_:=Ostq_-Dosq96_+Kosq96_;
   IF Ostq_<>0 THEN
      dk_:=IIF_N(Ostq_,0,'1','2','2')||'0';
      p_ins(data_, dk_ , acc_, nls_, nbs_, ob22_, kv_, TO_CHAR(ABS(Ostq_)), s180_, sPCnt_, s_, comm_, tobo_);
   END IF;

END LOOP;
CLOSE Saldo;
---------------------------------------------------
DELETE FROM tmp_irep where kodf='17' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, kodp1_, sum0_, sum1_ ;
   EXIT WHEN BaseL%NOTFOUND;

   IF sum0_<>0 then
      -- сумма
      znap_ := TO_CHAR(sum0_);

      INSERT INTO tmp_irep
           (kodf, datf, kodp, znap)
      VALUES
           ('17', Dat_, kodp_, znap_) ;

      --  %% ставка
      znap_ := LTRIM(TO_CHAR(ROUND(sum1_/sum0_,4),fmt_));

      INSERT INTO tmp_irep
           (kodf, datf, kodp, znap)
      VALUES
           ('17', Dat_, kodp1_, znap_) ;
   end if;
END LOOP;
CLOSE BaseL;

OPEN BaseL1;
LOOP
   FETCH BaseL1 INTO  kodp_, znap_;
   EXIT WHEN BaseL1%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('17', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL1;
------------------------------------------------------------------
END p_f17sb;
/
show err;

PROMPT *** Create  grants  P_F17SB ***
grant EXECUTE                                                                on P_F17SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F17SB         to RPBN002;
grant EXECUTE                                                                on P_F17SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F17SB.sql =========*** End *** =
PROMPT ===================================================================================== 
