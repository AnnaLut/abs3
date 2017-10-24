

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F56SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F56SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F56SB (Dat_ DATE)  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	ѕроцедура формирование файла @56 дл€ ќщадного Ѕанку
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 30.04.2011 (10.03.11,15.02.11,19.03.10,25.08.09,24.03.09,
%             :             23.02.09)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетна€ дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 30.04.2011 - добавил†acc,tobo в протокол
% 10.03.2011 - в поле комментарий вносим код TOBO и название счета
%              исключаем корректирующие проводки предыдущего мес€ца и
%              включаем корректирующие проводки отчетного мес€ца
% 15.02.2011 - вместо кл-ра SB_OB22 будем использовать SB_OB22N т.к.
%              поле A010 в табл. SB_OB22 не будет заполн€тьс€.
%              ¬ табл. SB_OB22 должна быть одна запись по бал.сч и OB22.
% 19.03.2010 - убрал блок внесени€ параметра OB22 в SPECPARAM_INT
% 24.04.2009 - не будем включать 2909 с OB22='09'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
acc_    Number;
acc1_   Number;
acc2_   Number;
dat1_   Date;
dat2_   Date;
se_     DECIMAL(24);
sn_     DECIMAL(24);
Dosn_   DECIMAL(24);
Kosn_   DECIMAL(24);
Dosnk_  DECIMAL(24);
Kosnk_  DECIMAL(24);
kodp_   Varchar2(11);
znap_   Varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    Varchar2(4);
Nbs1_   Varchar2(4);
nls_    Varchar2(15);
data_   Date;
zz_     Varchar2(2);
pp_     Varchar2(4);
dk_     Char(1);
f56_    Number;
f56k_   Number;
userid_ Number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;

---ќбороты (по грн. 2902)
CURSOR SaldoASeekOs IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos),
          a.tobo, a.nms, NVL(trim(sp.ob22),'00')
   FROM saldoa s, accounts a, sb_r020 k, specparam_int sp
   WHERE s.fdat between Dat1_ AND Dat_
     and a.acc=s.acc
     and a.kv=980
     and a.nbs=k.r020
     and k.f_56='1'
     and a.acc = sp.acc(+)
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms, sp.ob22;

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

DELETE FROM ref_kor ;

INSERT INTO ref_kor (REF, VOB, VDAT)
SELECT ref, vob, vdat
FROM oper
WHERE vdat between ADD_MONTHS(dat1_,-1) and ADD_MONTHS(dat_,1)
  and vob in (96,99) ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p
WHERE o.fdat between Dat1_ AND Dat2_
  and o.ref=p.ref
  and o.sos=5 ;
-----------------------------------------------------------------------------
-- ќбороты текущие (грн. + вал. номиналы ) --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn_, Kosn_, tobo_, nms_, zz_;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   comm_ := '';

--- отбор корректирующих проводок предыдущего мес€ца
   BEGIN
      SELECT d.acc,
         SUM(DECODE(d.dk, 0, d.s, 0)),
         SUM(DECODE(d.dk, 1, d.s, 0))
      INTO acc1_, Dosnk_, Kosnk_
      FROM  kor_prov d
      WHERE d.acc=acc_
        and d.fdat between Dat1_ AND Dat_
        and d.vob = 96
      GROUP BY d.acc ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      Dosnk_ :=0 ;
      Kosnk_ :=0 ;
   END ;

   Dosn_ := Dosn_ - Dosnk_;
   Kosn_ := Kosn_ - Kosnk_;

--- отбор корректирующих проводок отчетного мес€ца
   BEGIN
      SELECT d.acc,
         SUM(DECODE(d.dk, 0, d.s, 0)),
         SUM(DECODE(d.dk, 1, d.s, 0))
      INTO acc1_, Dosnk_, Kosnk_
      FROM  kor_prov d
      WHERE d.acc=acc_
        and d.fdat between Dat_+1 AND Dat2_
        and d.vob = 96
      GROUP BY d.acc ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
      Dosnk_ :=0 ;
      Kosnk_ :=0 ;
   END ;

   Dosn_ := Dosn_ + Dosnk_;
   Kosn_ := Kosn_ + Kosnk_;

   IF Dosn_ > 0 OR Kosn_ > 0 THEN

      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      f56_:=0;

      SELECT count(*)
         INTO f56_
      FROM sb_ob22n
      WHERE r020=nbs_
        and ob22=zz_
        and a010='56' ;

      IF f56_ > 0 AND Dosn_ > 0 THEN
         kodp_:='5' || nbs_ || zz_ ;
         znap_:=TO_CHAR(Dosn_) ;
         INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF;

      IF f56_ > 0 AND Kosn_ > 0 THEN
         kodp_:='6' || nbs_ || zz_ ;
         znap_:=TO_CHAR(Kosn_);
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_) ;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='56' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap)
   VALUES
        ('56', Dat_, kodp_, znap_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f56sb;
/
show err;

PROMPT *** Create  grants  P_F56SB ***
grant EXECUTE                                                                on P_F56SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F56SB         to RPBN002;
grant EXECUTE                                                                on P_F56SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F56SB.sql =========*** End *** =
PROMPT ===================================================================================== 
