

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F26SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F26SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F26SB (Dat_ DATE ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	Процедура формирование файла @26 для СБ
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 13/11/2017 (26/05/2012) для Сбербанка
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 13.11.2017 - удалил ненужные строки и изменил некоторые блоки формирования 
% 26.05.2012 - формируем в разрезе кодов территорий
% 11.05.2011 - включаем корректирующие проводки
% 30.04.2011 - добавил acc,tobo в протокол
% 26.02.2011 - в поле комментарий вносим код TOBO и название счета
% 17.03.2009 - обороти включались тiльки за один день а потрiбно за 
%              мiсяць. Виправлено.       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    varchar2(2) := '26'; 
sheme_   varchar2(1) := 'С';    
acc_     Number;
Dos_     DECIMAL(24);
Dosq_    DECIMAL(24);
Dosn_    DECIMAL(24);
Dose_    DECIMAL(24);
Kos_     DECIMAL(24);
Kosq_    DECIMAL(24);
Kosn_    DECIMAL(24);
Kose_    DECIMAL(24);
Dosnk_   DECIMAL(24);
Kosnk_   DECIMAL(24);
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
Oste_    DECIMAL(24);
kodp_    Varchar2(10);
znap_    Varchar2(30);
Kv_      SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
mfo_     Varchar2(12);
ob22_    Varchar2(2);
data_    Date;
Dat1_    Date;
Dat2_    Date;
f01_     Number;
dk_      Char(1);
nbu_     SMALLINT;
prem_    Char(3);
userid_  Number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_	 number;
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);


CURSOR SaldoASeekOstf IS
   SELECT s.acc, s.nls, s.kv, s.fdat, s.nbs, s.ost, s.ostq,
          s.dos, s.dosq, s.kos, s.kosq,
          s.dos96p, s.dosq96p, s.kos96p, s.kosq96p,
          s.dos96, s.dosq96, s.kos96, s.kosq96,
          s.dos99, s.dosq99, s.kos99, s.kosq99,
          s.doszg, s.koszg, s.dos96zg, s.kos96zg,
          a.tobo, a.nms, NVL(trim(sp.ob22),'00') 
   FROM  otcn_saldo s, otcn_acc a, specparam_int sp
   WHERE s.acc=a.acc      
     and s.kv=980 
     and a.acc=sp.acc(+);

CURSOR KOL_NLS IS
   SELECT acc, nls, kv, nbuc, substr(kodp,2,6), count(*), comm, tobo
   FROM rnbu_trace
   WHERE userid=userid_
   GROUP BY acc, nls, kv, nbuc, substr(kodp,2,6), comm, tobo;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
sql_acc_ := 'select r020 from kl_f3_29_int where kf=''26'' ';

ret_ := f_pop_otcn(Dat_, 3, sql_acc_);

Dat1_ := TRUNC(Dat_,'MM');
Dat2_ := TRUNC(Dat_ + 28);

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);
-------------------------------------------------------------------
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO  acc_, nls_, kv_, data_, Nbs_, Ostn_, Ostq_,
                        Dos_, Dosq_, Kos_, Kosq_,
                        Dos96p_, Dosq96p_, Kos96p_, Kosq96p_,
                        Dos96_, Dosq96_, Kos96_, Kosq96_,
                        Dos99_, Dosq99_, Kos99_, Kosq99_,
                        Doszg_, Koszg_, Dos96zg_, Kos96zg_,
                        tobo_, nms_, ob22_;

   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   Ostn_:=Ostn_-Dos96_+Kos96_;
   Dos_ := Dos_ + Dos96_;
   Kos_ := Kos_ + Kos96_;

   comm_ := '';

   IF typ_ > 0 
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Ostn_ <> 0 
   THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      dk_ := IIF_N(Ostn_,0,'1','2','2');
      kodp_ := dk_ || Nbs_ || ob22_ ;
      znap_ := TO_CHAR(ABS(Ostn_));

      INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
        VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

   IF Dos_ > 0 OR Kos_ > 0 
   THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      IF Dos_ > 0 
      THEN
         kodp_ := '5' || Nbs_ || ob22_ ;
         znap_ := TO_CHAR(Dos_);
         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;

      IF Kos_ > 0 
      THEN
         kodp_ := '6' || Nbs_ || ob22_ ;
         znap_ := TO_CHAR(Kos_) ;
         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;
   END IF;

END LOOP;
CLOSE SaldoASeekOstf;
-----------------------------------------------------------------------------
--- кол-во счетов
OPEN KOL_NLS;
LOOP
   FETCH KOL_NLS INTO  acc_, nls_, kv_, nbuc_, kodp_, Ostn_, comm_, tobo_;
   EXIT WHEN KOL_NLS%NOTFOUND;
   IF Ostn_ > 0 
   THEN
      kodp_ := '3' || substr(nls_,1,4) || substr(kodp_,5,2) ;
      znap_ := TO_CHAR(Ostn_);
      INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, dat_, kodp_, '1', acc_, comm_, tobo_, nbuc_) ;
   END IF;
END LOOP;
CLOSE KOL_NLS;
------------------------------------------------------------------
DELETE FROM tmp_irep where kodf='26' and datf= dat_;
------------------------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '26', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f26sb;
/
show err;

PROMPT *** Create  grants  P_F26SB ***
grant EXECUTE                                                                on P_F26SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F26SB         to RPBN002;
grant EXECUTE                                                                on P_F26SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F26SB.sql =========*** End *** =
PROMPT ===================================================================================== 
