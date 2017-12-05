

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F83SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F83SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F83SB (Dat_ DATE )  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FILE NAME   :	otcn.sql
% DESCRIPTION :	ќтчетность —берЅанка: формирование файлов
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2001.  All Rights Reserved.
% VERSION     : 10.11.2017 (26.05.2012, 30.04.2011)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 10.11.2017 - изменил некоторые блоки формировани€ 
% 26.05.2012 - формируем в разрезе кодов территорий
% 30.04.2011 - добавил†acc,tobo в протокол
% 09.03.2011 - в поле комментарий вносим код TOBO и название счета
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   varchar2(2) := '83';
sheme_  varchar2(2) := 'C';
acc_    Number;
accd_   Number;
acck_   Number;
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
kodp_   Varchar2(11);
znap_   Varchar2(30);
Kv_     SMALLINT;
Nbs_    Varchar2(4);
nls_    Varchar2(15);
nlsk_   Varchar2(15);
s0000_  Varchar2(15);
s0009_  Varchar2(15);
data_   Date;
kk_     Varchar2(2);
dk_     Char(1);
userid_ Number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);

---ќбороты (по грн)
CURSOR OPL_DOK IS 
    SELECT o.accd, o.nlsd, o.kv, o.fdat, NVL(substr(a1.value,1,2),'00'),
           o.s*100, o.acck, o.nlsk, s.tobo, s.nms   
    FROM  provodki o, oper z, operw a1, accounts s 
    WHERE (substr(o.nlsd,1,4) in ('3522','3622') or 
           substr(o.nlsk,1,4) in ('3522','3622'))    
      and z.ref=o.ref                                
      and o.fdat between Dat1_+1 and Dat_                   
      and a1.tag (+)='D#83'                          
      and a1.ref (+) =o.ref 
      and o.accd = s.acc;
---          GROUP BY o.nlsd, o.kv, o.fdat, substr(a1.value,1,2)

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
-- ќбороты текущие (грн.) --
OPEN OPL_DOK;
LOOP
   FETCH OPL_DOK INTO accd_, nls_, kv_, data_, kk_, sn_, acck_, nlsk_, tobo_, nms_ ;
   EXIT WHEN OPL_DOK%NOTFOUND;

   comm_ := '';
   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   IF sn_>0 and (substr(nls_,1,4)='3522' or substr(nls_,1,4)='3622') THEN
    
      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(accd_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      kodp_:= '5' || SUBSTR(nls_,1,4) || kk_ ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, nbuc) VALUES
                             (nls_, kv_, data_, kodp_,znap_, accd_, comm_, nbuc_);
   END IF;

   IF sn_>0 and (substr(nlsk_,1,4)='3522' or substr(nlsk_,1,4)='3622') THEN

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acck_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      kodp_:= '6' || SUBSTR(nlsk_,1,4) || kk_ ;
      znap_:= TO_CHAR(SN_) ;
      INSERT INTO rnbu_trace (nls, kv, odate, kodp, znap, acc, comm, nbuc) VALUES
                             (nlsk_, kv_, data_, kodp_,znap_, acck_, comm_, nbuc_);
   END IF;
END LOOP;
CLOSE OPL_DOK;
---------------------------------------------------
DELETE FROM tmp_irep where kodf='83' and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, znap, nbuc)
select '83', Dat_, kodp, SUM (znap), nbuc
FROM rnbu_trace
GROUP BY kodp, nbuc;
------------------------------------------------------------------
END p_f83sb;
/
show err;

PROMPT *** Create  grants  P_F83SB ***
grant EXECUTE                                                                on P_F83SB         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F83SB         to RPBN002;
grant EXECUTE                                                                on P_F83SB         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F83SB.sql =========*** End *** =
PROMPT ===================================================================================== 
