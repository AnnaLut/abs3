

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F81SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F81SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F81SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C' )  IS  
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :    otcn.sql
% DESCRIPTION :    ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 26.05.2012 (30.04.2011, 23.02.2009, 19.07.2001)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 26.05.2012 - формируем в разрезе кодов территорий
% 30.04.2011 - добавил†acc,tobo в протокол
% 09.03.2011 - в поле комментарий вносим код TOBO и название счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   varchar2(2) := '81';
acc_    Number;
acc1_    Number;
acc2_    Number;
dat1_   Date;
dat2_   Date;
Dosn_   DECIMAL(24);
Dose_   DECIMAL(24);
Kosn_   DECIMAL(24);
Kose_   DECIMAL(24);
se_     DECIMAL(24);
sn_     DECIMAL(24);
Ostn_   DECIMAL(24);
Oste_   DECIMAL(24);
kodp_   varchar2(10);
znap_   varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    varchar2(4);
nls_    varchar2(15);
s0000_  varchar2(15);
s0009_  varchar2(15);
data_   date;
pp_     Varchar2(4);
dk_     char(1);
userid_ Number;
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);


---ќстатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
         a.acc, a.nls, a.kv, a.fdat, a.nbs, NVL(trim(sp.p080),'0000'), a.ostf-a.dos+a.kos,
         a.tobo, a.nms 
---         GL.P_ICURVAL(a.kv, a.ostf-a.dos+a.kos, Dat_)
   FROM  (SELECT s.rnk, s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     
           and aa.fdat = (select max(c.fdat)
                          from saldoa c
                          where c.acc=aa.acc 
                            and c.fdat <= Dat_)) a,
         customer c, sb_r020 k, specparam_int sp
   WHERE a.rnk=c.rnk                  
     and a.kv=980                     
     and a.nbs=k.r020                 
     and k.f_81='1' 
     and a.acc=sp.acc(+);

---ќбороты (по грн. + по валюте номиналы)
CURSOR SaldoASeekOs IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.nbs, NVL(trim(sp.p080),'0000'),
          SUM(s.dos), SUM(s.kos), a.tobo, a.nms 
   FROM saldoa s, accounts a, 
        customer c, sb_r020 k, specparam_int sp
   WHERE s.fdat between Dat1_+1 AND Dat_                 
     and a.acc=s.acc                  
     and a.rnk=c.rnk                  
     and a.kv=980                     
     and a.nbs=k.r020                 
     and k.f_81='1' 
   GROUP BY a.acc, a.nls, a.kv, a.nbs, sp.p080, a.tobo, a.nms;

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    WHERE userid=userid_
    GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
--SELECT id INTO userid_ FROM staff WHERE upper(logname)=upper(USER);
userid_ := user_id;
--DELETE FROM RNBU_TRACE WHERE userid = userid_;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);
-------------------------------------------------------------------
-- ќстатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, pp_, Ostn_, tobo_, nms_ ; 
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   comm_ := '';

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Ostn_<>0 THEN
      --BEGIN
      --   SELECT NVL(p080,'0000') into pp_ 
      --   FROM specparam_int 
      --   WHERE acc=acc_ ;
      --   EXCEPTION WHEN NO_DATA_FOUND THEN
      --   pp_:='0000';
      --END ;
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
 
      dk_:=IIF_N(Ostn_,0,'1','2','2');
      kodp_:=dk_ || '0' || Nbs_ || pp_ ;
      znap_:=TO_CHAR(ABS(Ostn_));

      INSERT INTO rnbu_trace         -- ќстатки в номинале валюты
              (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- ќбороты текущие (грн. + вал. номиналы ) --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, pp_, Dosn_, Kosn_, tobo_, nms_ ; 
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   comm_ := '';

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF Dosn_ > 0 OR Kosn_ > 0 THEN
      BEGIN
         SELECT NVL(p080,'0000') into pp_ 
         FROM specparam_int 
         WHERE acc=acc_ ;
         EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_:='0000';
      END ;

      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      IF Dosn_ > 0 THEN
         kodp_:='50' || Nbs_ || pp_ ;
         znap_:=TO_CHAR(Dosn_);
         INSERT INTO rnbu_trace     -- ?б. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;

      IF Kosn_ > 0 THEN
         kodp_:='60' || Nbs_ || pp_ ;
         znap_:=TO_CHAR(Kosn_) ;
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='81' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        ('81', Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;
------------------------------------------------------------------
END p_f81sb;
/
show err;

PROMPT *** Create  grants  P_F81SB ***
grant EXECUTE                                                                on P_F81SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F81SB         to RPBN002;
grant EXECUTE                                                                on P_F81SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F81SB.sql =========*** End *** =
PROMPT ===================================================================================== 
