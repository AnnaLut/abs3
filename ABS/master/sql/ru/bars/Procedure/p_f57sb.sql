

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F57SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F57SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F57SB (Dat_ DATE ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ ����� #57 ��� ��
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 30.04.2011 (20.04.11,01.03.11,26/08/04) ��� ���������)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 30.04.2011 - �������tobo � ��������
% 20.04.2011 - �������� ��� � ��������
% 01.03.2011 - � ���� ����������� ������ ��� TOBO � �������� �����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_    Number;
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   Varchar2(10);
znap_   Varchar2(30);
Kv_     SMALLINT;
Nbs_    Varchar2(4);
nls_    Varchar2(15);
mfo_    Varchar2(12);
data_   Date;
f01_    Number;
dk_     Char(1);
nbu_    SMALLINT;
prem_   Char(3);
userid_ Number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;

CURSOR SaldoASeekOstf IS
   SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf-aa.dos+aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s, kl_f3_29_int k
         WHERE aa.acc= s.acc
           AND s.NBS = k.R020
           AND s.kv  = 980
           AND k.kf  = '57'
           AND aa.fdat = (select max(c.fdat)
                          from saldoa c
                          where c.acc=aa.acc and c.fdat <= Dat_) ;

CURSOR OBOROTY IS
   SELECT a.acc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos), a.tobo, a.nms
   FROM saldoa s, accounts a, kl_f3_29_int k
   WHERE s.fdat = Dat_
     AND a.NBS  = k.R020
     AND a.kv   = 980
     AND k.kf   = '57'
     AND s.acc  = a.acc
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms;

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
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn_, tobo_, nms_;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   comm_ := '';
   IF Ostn_<>0 THEN

     comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
     dk_:=IIF_N(Ostn_,0,'1','2','2');
     kodp_:=dk_||'0'||Nbs_ ;
     znap_:=TO_CHAR(ABS(Ostn_));

     INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, comm, tobo)
       VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_) ;

    END IF;

END LOOP;
CLOSE SaldoASeekOstf;
-----------------------------------------------------------------------------
OPEN OBOROTY;
LOOP
    FETCH OBOROTY INTO acc_, nls_, kv_, Nbs_, Dosn_, Kosn_, tobo_, nms_;
    EXIT WHEN OBOROTY%NOTFOUND;

   comm_ := '';
   IF Dosn_ > 0 OR Kosn_ > 0 THEN

      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      IF Dosn_ > 0 THEN

         kodp_:='50' || Nbs_  ;
         znap_:=TO_CHAR(Dosn_);
         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

      END IF;

      IF Kosn_ > 0 THEN

         kodp_:='60' || Nbs_  ;
         znap_:=TO_CHAR(Kosn_) ;
         INSERT INTO rnbu_trace(nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;

      END IF;
   END IF;

END LOOP;
CLOSE OBOROTY;
------------------------------------------------------------------
DELETE FROM tmp_irep where kodf='57' and datf= dat_;
------------------------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('57', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f57sb;
/
show err;

PROMPT *** Create  grants  P_F57SB ***
grant EXECUTE                                                                on P_F57SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F57SB         to RPBN002;
grant EXECUTE                                                                on P_F57SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F57SB.sql =========*** End *** =
PROMPT ===================================================================================== 
