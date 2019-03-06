

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F12_NN_SB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F12_NN_SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F12_NN_SB (Dat_ DATE ,
                                      sheme_ VARCHAR2 DEFAULT 'G',
                                      p_kodf_ VARCHAR2 DEFAULT '12')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирование файла #12 для КБ
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 21/02/2018 (11/12/2012) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: Dat_ - отчетная дата
    sheme_ - схема формирования

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_    VARCHAR2(2):='12';
typ_ NUMBER;

nls_     VARCHAR2(15);
nls1_    VARCHAR2(15);
nlsd_    varchar2(15);
nlsk_    varchar2(15);
data_    DATE;
kv_      SMALLINT;
kodp_    VARCHAR2(10);
znap_    VARCHAR2(30);
sk_      SMALLINT;
t_sk_    SMALLINT;  -- з TTS
sk_o_    SMALLINT;  -- з OPER
sk1_     SMALLINT;
sk2_     SMALLINT;
s_       DECIMAL(24);
nbu_     SMALLINT;
ref_     NUMBER;
stmt_    Number;
userid_  NUMBER;
kol_sk_  NUMBER :=0;
tt_      Varchar2(3);  -- з OPLDOK
tt_pr    varchar2(3);
o_tt_    Varchar2(3);  -- з OPER
dat1_    DATE;        -- дата начала декады !!!
datp_    date;
dc_      INTEGER;
dk_      NUMBER;
dk1_     NUMBER;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
acc_     NUMBER;
nazn_    Varchar2(160);
comm_    Varchar2(200);
pr_bak   Number;
pr_doch  Number;
mfo_     number;
mfou_    Number;

-- исходящие остатки
CURSOR SALDO IS
   SELECT  o.acc, o.nls, o.kv, sa.FDAT, sa.ost
   FROM snap_balances sa, ACCOUNTS o
   WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT = Dat_;

-- входящие остатки
CURSOR SALDO2 IS
   SELECT  o.acc, o.nls, o.kv, sa.FDAT, sa.ost
   FROM snap_balances sa, ACCOUNTS o
   WHERE o.tip='KAS'    AND
         o.nbs in ('1001','1002','1003','1004') AND
         o.kv=980       AND
         o.acc=sa.acc   AND
         sa.FDAT  = datp_;

CURSOR BaseL IS
   SELECT kodp,nbuc, SUM (znap)
   FROM RNBU_TRACE
   GROUP BY kodp,nbuc
   ORDER BY kodp;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
nbu_:= Isnbubank();

mfo_ := F_OURMFO();

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

-- определение начальных параметров
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

IF p_kodf_ = '12' THEN
-- определение даты начала декады
   dc_:=TO_NUMBER(LTRIM(TO_CHAR(dat_,'DD'),'0'));

   FOR i IN 1..3
   LOOP
      IF dc_ BETWEEN 10*(i-1)+1 AND 10*(i-1)+10+Iif(i,3,0,1,0) THEN
         dat1_:=TO_DATE(LPAD(10*(i-1)+1,2,'0')||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
         EXIT;
      END IF;
   END LOOP;
ELSIF p_kodf_ = '13' THEN -- файл 13
-- определение даты начала месяца
   dat1_ := TO_DATE('01'||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
ELSIF p_kodf_ = '92' THEN
   dat1_:=Calc_Pdat(Dat_);
ELSE
   dat1_:=Dat_;
END IF;

-- если начало декады (или месяца) - след. день после выходных - то включить обороты за выходные
Dat1_:=Calc_Pdat(Dat1_);

select max(fdat)
into datp_ 
from fdat 
where fdat < dat1_; 

INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, acc, ref, comm) 
select '1XXX', 980, datf, kodp, znap, nbuc, null, null, 'З щоденного @12'
from tmp_irep
where kodf = '12' and
      datf between dat1_ and dat_ and
      kodp not in ('69', '70', '34', '35');

-- исходящие остатки
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_,nls_, kv_, data_, s_ ;
   EXIT WHEN SALDO%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF s_ <> 0 THEN
      IF nbu_ = 1 THEN
         kodp_:= '69';
      ELSE
         kodp_:= '70';
      END IF;

      znap_:= TO_CHAR(ABS(s_));
      INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, acc) VALUES
                             (nls_, kv_, data_, kodp_, znap_, nbuc_, acc_);
   END IF;
END LOOP;
CLOSE SALDO;

-- входящие остатки
OPEN SALDO2;
LOOP
   FETCH SALDO2 INTO acc_,nls_, kv_, data_, s_ ;
   EXIT WHEN SALDO2%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF s_ <> 0  THEN
      IF nbu_ = 1 THEN
         kodp_:= '34';
      ELSE
         kodp_:= '35';
      END IF;

      znap_:= TO_CHAR(ABS(s_)) ;
      INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, acc) VALUES
                             (nls_, kv_, data_, kodp_, znap_, nbuc_, acc_);
   END IF;

END LOOP;
CLOSE SALDO2;
---------------------------------------------------
DELETE FROM TMP_NBU WHERE datf=Dat_ AND kodf=p_kodf_ ;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;

   INSERT INTO TMP_NBU
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        (p_kodf_, Dat_, kodp_, znap_, nbuc_);
END LOOP;
CLOSE BaseL;

----------------------------------------
p_ch_sk('12',dat_,dat1_,userid_);
--p_ch_f12_kb('12',dat1_,dat_,userid_);
----------------------------------------
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F12_NN_SB.sql =========*** End *
PROMPT ===================================================================================== 
