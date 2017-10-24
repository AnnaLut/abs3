

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F12_NN_SB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F12_NN_SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F12_NN_SB (Dat_ DATE ,
                                      sheme_ VARCHAR2 DEFAULT 'G',
                                      p_kodf_ VARCHAR2 DEFAULT '12')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ ����� #12 ��� ��
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION      12/08/2014 (07/08/2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
    sheme_ - ����� ������������
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
t_sk_    SMALLINT;  -- � TTS
sk_o_    SMALLINT;  -- � OPER
sk1_     SMALLINT;
sk2_     SMALLINT;
s_       DECIMAL(24);
nbu_     SMALLINT;
ref_     NUMBER;
stmt_    Number;
userid_  NUMBER;
kol_sk_  NUMBER :=0;
tt_      Varchar2(3);  -- � OPLDOK
tt_pr    varchar2(3);
o_tt_    Varchar2(3);  -- � OPER
dat1_    DATE;        -- ���� ������ ������ !!!
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

-- ����������� ��������� ����������
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

IF p_kodf_ = '12' THEN
-- ����������� ���� ������ ������
   dc_:=TO_NUMBER(LTRIM(TO_CHAR(dat_,'DD'),'0'));

   FOR i IN 1..3
   LOOP
      IF dc_ BETWEEN 10*(i-1)+1 AND 10*(i-1)+10+Iif(i,3,0,1,0) THEN
         dat1_:=TO_DATE(LPAD(10*(i-1)+1,2,'0')||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
         EXIT;
      END IF;
   END LOOP;
ELSIF p_kodf_ = '13' THEN -- ���� 13
-- ����������� ���� ������ ������
   dat1_ := TO_DATE('01'||TO_CHAR(dat_,'mmyyyy'),'ddmmyyyy');
ELSIF p_kodf_ = '92' THEN
   dat1_:=Calc_Pdat(Dat_);
ELSE
   dat1_:=Dat_;
END IF;

-- ���� ������ ������ (��� ������) - ����. ���� ����� �������� - �� �������� ������� �� ��������
Dat1_:=Calc_Pdat(Dat1_);

INSERT INTO RNBU_TRACE (nls, kv, odate, kodp, znap, nbuc, acc, ref, comm)
select '1XXX', 980, datf, kodp, znap, nbuc, null, null, '� ��������� @12'
from tmp_irep
where kodf = '12' and
      datf between dat1_ and dat_ and
      kodp not in ('69', '70', '34', '35');

-- ��������� �������
INSERT INTO RNBU_TRACE (acc, nls, kv, odate, kodp, znap, nbuc)
SELECT  o.acc, o.nls, o.kv, sa.FDAT,
        (case when nbu_ = 1 then '69' else '70' end) kodp,
        to_char(abs(sa.ostf-sa.dos+sa.kos)) s,
        (case when typ_>0
              then NVL(F_Codobl_Tobo(sa.acc, typ_), nbuc1_)
              else nbuc1_
        end) nbuc
FROM SALDOA sa, ACCOUNTS o
WHERE o.tip='KAS'    AND
     o.nbs in ('1001','1002','1003','1004') AND
     o.kv=980       AND
     o.acc=sa.acc   AND
     sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
              FROM  SALDOA bb
              WHERE o.acc = bb.acc AND bb.FDAT  <= Dat_) and
     sa.ostf-sa.dos+sa.kos <> 0;

-- �������� �������
INSERT INTO RNBU_TRACE (acc, nls, kv, odate, kodp, znap, nbuc)
SELECT  o.acc, o.nls, o.kv, sa.FDAT,
        (case when nbu_ = 1 then '34' else '35' end) kodp,
        to_char(abs(sa.ostf-sa.dos+sa.kos)) s,
        (case when typ_>0
              then NVL(F_Codobl_Tobo(sa.acc, typ_), nbuc1_)
              else nbuc1_
        end) nbuc
FROM SALDOA sa, ACCOUNTS o
WHERE o.tip='KAS'    AND
     o.nbs in ('1001','1002','1003','1004') AND
     o.kv=980       AND
     o.acc=sa.acc   AND
     sa.FDAT  IN ( SELECT MAX ( bb.FDAT )
              FROM  SALDOA bb
              WHERE o.acc = bb.acc AND bb.FDAT  < Dat1_) and
     sa.ostf-sa.dos+sa.kos <> 0;
---------------------------------------------------
DELETE FROM TMP_NBU WHERE datf=Dat_ AND kodf=p_kodf_ ;
---------------------------------------------------
INSERT INTO TMP_NBU
    (kodf, datf, kodp, znap, nbuc)
SELECT p_kodf_, Dat_, kodp, SUM (znap), nbuc
FROM RNBU_TRACE
GROUP BY kodp, nbuc;
----------------------------------------
--p_ch_sk('12',dat_,dat1_,userid_);
----------------------------------------
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F12_NN_SB.sql =========*** End *
PROMPT ===================================================================================== 
