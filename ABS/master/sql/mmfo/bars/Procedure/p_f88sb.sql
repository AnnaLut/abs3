

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F88SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F88SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F88SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C' )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :	otcn.sql
% DESCRIPTION :	ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 14/11/2017 (26.05.2012, 30.04.2011) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
14.11.2017 - удалил ненужные строки и изменил некоторые блоки формировани€ 
26.05.2012 - формируем в разрезе кодов территорий
30.04.2011 - добавил†acc,tobo в протокол
09.03.2011 - в поле комментарий вносим код TOBO и название счета
11.01.2010 - новый годовой файл 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   varchar2(2) := '88';
acc_    Number;
acc1_   Number;
acc2_   Number;
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
kodp_   Varchar2(19);
znap_   Varchar2(30);
Kv_     SMALLINT;
Vob_    SMALLINT;
Nbs_    Varchar2(4);
Nbs1_   Varchar2(4);
nls_    Varchar2(15);
s0000_  Varchar2(15);
s0009_  Varchar2(15);
data_   Date;
zz_     Varchar2(4);
pp_     Varchar2(4);
r020_   Varchar2(4);
ob22_   Varchar2(2);
dk_     Char(1);
f88_    Number;
userid_ Number;
mfo_    varchar2(12);
tobo_   accounts.tobo%TYPE;
nms_    accounts.nms%TYPE;
comm_   rnbu_trace.comm%TYPE;
typ_    Number; 
nbuc1_  VARCHAR2(12);
nbuc_   VARCHAR2(12);

---ќстатки на отчетную дату (грн. + валюта)
CURSOR SaldoASeekOstf IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
         a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
         a.tobo, a.nms, 
         NVL(trim(sp.r020_fa),'0000'), NVL(trim(sp.p080),'0000'), 
         NVL(trim(sp.ob88),'0000'), NVL(trim(sp.ob22),'00')
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms 
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) =
               (select c.acc,max(c.fdat)
                from saldoa c
                where s.acc=c.acc and c.fdat <= Dat_
                group by c.acc)) a,
              (select distinct r020
               from sb_p088
               where d_close is null) k, specparam_int sp 
   WHERE a.kv = 980           
     and a.nbs = k.r020 
     and a.acc = sp.acc(+);

---ќбороты (по грн. + по валюте номиналы)
CURSOR SaldoASeekOs IS
   SELECT /* + INDEX(L XIE_K040_KL_K040) INDEX (C XPK_CUSTOMER) */
          a.acc, a.nls, a.kv, a.nbs, SUM(s.dos), SUM(s.kos),
          a.tobo, a.nms, 
          NVL(trim(sp.r020_fa),'0000'), NVL(trim(sp.p080),'0000'), 
          NVL(trim(sp.ob88),'0000'), NVL(trim(sp.ob22),'00')
   FROM saldoa s, accounts a,
        (select distinct r020
         from sb_p088
         where d_close is null) k,
        specparam_int sp
   WHERE s.fdat between Dat1_ AND Dat_ 
     and a.acc = s.acc                   
     and a.kv = 980                      
     and a.nbs = k.r020
     and a.acc = sp.acc(+)
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms, sp.r020_fa, sp.p080, sp.ob88, sp.ob22 ;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
mfo_ := F_OURMFO();

Dat1_ := TRUNC(Dat_, 'MM');
-- установил 11.01.2010 т.к. оказалось что файл квартальный
Dat1_ := TRUNC(add_months(Dat_,-2),'MM');
Dat2_ := TRUNC(Dat_ + 28);

-- определение начальных параметров
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);
-------------------------------------------------------------------
-- ќстатки (грн. + валюта номиналы) --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn_, tobo_, nms_, 
                             r020_, pp_, zz_, ob22_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   f88_ := 1 ;
   comm_ := '';

   IF typ_ > 0 
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF f88_ > 0 and Ostn_ <> 0 
   THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);
      
      if mfo_ = 300465 
      then
         dk_ := IIF_N(Ostn_,0,'2','1','1');
      else
         dk_ := IIF_N(Ostn_,0,'1','2','2');
      end if;

      kodp_ := dk_ || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
      znap_ := TO_CHAR(ABS(Ostn_));
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
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn_, Kosn_, tobo_, nms_, r020_, pp_, zz_, ob22_;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   f88_ := 1 ;
   comm_ := '';

   IF typ_ > 0 
   THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF f88_ > 0 and (Dosn_ > 0 OR Kosn_ > 0) 
   THEN
      comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

      IF Kosn_ > 0 
      THEN

         if mfo_ = 300465 
         then
            kodp_ := '5' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         else
            kodp_ := '6' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         end if;

         znap_ := TO_CHAR(Kosn_) ;
         INSERT INTO rnbu_trace     -- ƒт. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;

      IF Dosn_ > 0 
      THEN

         if mfo_ = 300465 
         then
            kodp_ := '6' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         else
            kodp_ := '5' || nbs_ || pp_ || r020_ || ob22_ || zz_ ;
         end if;

         znap_ := TO_CHAR(Dosn_);
         INSERT INTO rnbu_trace     --  р. обороты в номинале валюты (грн.+вал.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='88' and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '88', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f88sb;
/
show err;

PROMPT *** Create  grants  P_F88SB ***
grant EXECUTE                                                                on P_F88SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F88SB         to RPBN002;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F88SB.sql =========*** End *** =
PROMPT ===================================================================================== 
