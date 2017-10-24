

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F25SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F25SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F25SB (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   : otcn.sql
% DESCRIPTION : ќтчетность —берЅанка: формирование файла @25
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     :   05.02.2007
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% с 01.02.2007 вводитьс€ новий показник
% "17423" - зменшенн€ амортизацii за 2007 рiк
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
sDos_    Number(24);
sKos_    Number(24);
Dosnk_   Number(24);
Kosnk_   Number(24);
Kv_      SMALLINT;
Nbs_     Varchar2(4);
nls_     Varchar2(15);
Data_    Date;
Dat1_    Date;
Dat2_    Date;
kodp_    Varchar2(5);
znap_    Varchar2(30);
acc_     Number;
acc1_    Number;
userid_  Number;

--------------------------------------------------------------------------
CURSOR Saldo IS
    SELECT s.acc, s.nls, s.kv, a.fdat, a.dos, a.kos
    FROM accounts s, saldoa a, kl_f3_29_int k
    WHERE s.acc=a.acc                 AND
          s.nbs=k.r020                AND
          k.kf='25'                   AND
          a.fdat> Dat1_               AND
          a.fdat <= Dat_ ;

CURSOR BaseL IS
    SELECT kodp, SUM (znap)
    FROM rnbu_trace
        WHERE userid=userid_
    GROUP BY kodp
    ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
DELETE FROM RNBU_TRACE WHERE userid = userid_;
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_ - TO_NUMBER(TO_CHAR(Dat_,'DD')));
Dat2_ := TRUNC(Dat_ + 28);
----------------------------------------------------------------------------
---------------------  орректирующие проводки ---------------------
---TRUNCATE TABLE kor_prov ;
DELETE FROM ref_kor ;
IF to_char(Dat_,'MM')='12' THEN
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vob=96 and not (((substr(nlsa,1,1)='6' or substr(nlsa,1,1)='7')
          and substr(nlsb,1,4)='5040') or (substr(nlsa,1,4)='5040' and
          (substr(nlsb,1,1)='6' or substr(nlsb,1,1)='7'))) ;
ELSE
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT ref, vob, vdat
   FROM oper
   WHERE vob=96 ;
END IF ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     --- oper p
WHERE o.fdat>Dat1_     AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;
--------------------------------------------------------------------------
OPEN Saldo;
LOOP
    FETCH Saldo INTO acc_, nls_, Kv_, data_, sDos_, sKos_;
    EXIT WHEN Saldo%NOTFOUND;

    nbs_:=substr(nls_,1,4);

--- отбор корректирующих проводок отчетного мес€ца
    BEGIN
       SELECT acc,
          SUM(DECODE(dk, 0, s, 0)),
          SUM(DECODE(dk, 1, s, 0))
       INTO acc1_, Dosnk_, Kosnk_
       FROM  kor_prov
       WHERE acc=acc_                   AND
             fdat > Dat_                AND
             fdat <= Dat2_              AND
             vob = 96
       GROUP BY acc ;
    EXCEPTION WHEN NO_DATA_FOUND THEN
       Dosnk_ :=0 ;
       Kosnk_ :=0 ;
    END ;

    sDos_:=sDos_+Dosnk_;
    sKos_:=sKos_+Kosnk_;

    IF sDos_ > 0 THEN
       INSERT INTO rnbu_trace         -- ƒт. обороты
              (nls, kv, odate, kodp, znap)
       VALUES (nls_, Kv_, Data_, '5' || nbs_, TO_CHAR(sDos_));
    END IF;

    IF sKos_ > 0 THEN
       INSERT INTO rnbu_trace         --  р. обороты
              (nls, kv, odate, kodp, znap)
       VALUES (nls_, Kv_, Data_, '6' || nbs_, TO_CHAR(sKos_));
    END IF;

END LOOP;
CLOSE Saldo;
----------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep WHERE kodf='25' AND datf= Dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('25', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
----------------------------------------------------------------------
---с 01.02.2005 введен новый показатель, который заполн€етс€ вручную
--INSERT INTO tmp_irep
--   (kodf, datf, kodp, znap)
--VALUES
--   ('25', Dat_, '50000', '0');

---с 01.02.2007 введен новый показатель "17423", который заполн€етс€ вручную
INSERT INTO tmp_irep
   (kodf, datf, kodp, znap)
VALUES
   ('25', Dat_, '17423', '0');
END P_F25sb;
/
show err;

PROMPT *** Create  grants  P_F25SB ***
grant EXECUTE                                                                on P_F25SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F25SB         to RPBN002;
grant EXECUTE                                                                on P_F25SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F25SB.sql =========*** End *** =
PROMPT ===================================================================================== 
