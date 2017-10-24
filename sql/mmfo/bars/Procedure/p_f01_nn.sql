

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F01_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F01_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F01_NN (Dat_ DATE,
                                      sheme_ VARCHAR2 DEFAULT 'G',
                                      tipost_ VARCHAR2 DEFAULT 'S',
                                      kodf_    VARCHAR2 DEFAULT '01') IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    ��������� ������������ #01 ��� �� (�������������)
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     : 19.09.2012 (24.04.2012,20.07.2009,11.06.2009,03.06.2009)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������
           tipost_ - ��� �������� 6 � 7 �������
                     'S'-� ������ �������� ���������� �� 5040(5041)
                     'R'- ��� ����� �������� ���������� �� 5040(5041)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 19.09.2012 ����� ����� � ���������
%            (���������� ����������� ������ ��� �������)
%            ��� �������� �� ����������� ���������� �� ����� ���
%            ��������� � ����� ��� ��������� ����������� (������ BASEL)
%            ��������� P_OTC_VE9 ���������� ��� ������-��� ��������� �
%            ����� �����
% 24.04.2012 ������� ������������ ���� ACC � RNBU_TRACE � ��� ������� ��
%            ������������� ���-�� ��������� P_OTC_VE9
%            �������� �� ����� ���������� ����������� � ��� ����� "C"
% 20.07.2009 ��� ����� �� ������� ���� ���������� � OTCN_SALDO(�������
%            F_POP_OTCN) � � ������� SALDO ��������� ����. OTCN_ACC,
%            CUSTOMER
% 11.06.2009 ��� ����� �� �� ������ 9910_001% �������� ��������� �������
% 03.06.2009 ��� ����� �� �� ������ 9910_001% ����� ����� ������ �������
%            ���������� ("10","20").
% 26.02.2008 ����� �� ��� ������ ���.���������� � ����� ����� �� 643,840,
%            978 �������� ��� ������ �� 978 �.�. ��� ���� ����� ����
%            ���������� � ��� �������� (������ ��� ���������� ��������)
% 25.02.2008 � ��������� �� 22.09.2005 ����������� ���������� ��������
%            ������� � ���������� �������� �������� ������, � 17.01.2006
%            �� ���������. �� ������� ����� ������ ������� ����������.
%            �������� ���������� ��� ������ ���(300175), ���(300205),
%            ��������(300465)
%            ��� ������� SALDO ��������� "(*+ INDEX(cc) *)".
% 04.02.2008 ��� ��� ��� �� ������������ ���������� ���� F_01 � ��������-
%            ������ KL_R020, � �������� ���.������ ���������� � ����
%            ������� � KOD_R020, �� ����� ������������ KOD_R020 ������
%            KL_R020
% 24.01.2006 ��� ����������� ����������� ���=315568 �� �������� ��� ������
%            �� 980 �� ������ ���.���������� 3500 ��� 3600 (� ��� �����)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
--kodf_    VARCHAR2(2):='01';
typ_     NUMBER;
rnk_     NUMBER;
acc_     NUMBER;
nbs_     VARCHAR2(4);
kv_      SMALLINT;
nls_     VARCHAR2(15);
mfo_     VARCHAR2(12);
mfou_    Number;
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(20);
--s0000_   Varchar2(15);
--s3500_   Varchar2(15);
--s3600_   Varchar2(15);
--s0009_   Varchar2(15);
data_    DATE;
re_      SMALLINT;
Ostn_    DECIMAL(24);
Ostq_    DECIMAL(24);
Dose_    DECIMAL(24);
dk_      VARCHAR2(2);
kodp_    VARCHAR2(10);
znap_    VARCHAR2(30);
userid_  NUMBER;
dig_     NUMBER;
b_       VARCHAR2(30);
flag_    NUMBER;
pr_      NUMBER;
tips_    VARCHAR2(3);
tsql_    VARCHAR2(1000);
sql_acc_ VARCHAR2(2000):='';
ret_     NUMBER;
pr_accc  NUMBER;

--��� ������ �� ��������� 16.07.2009
CURSOR SALDO IS
   SELECT a.acc, a.nls, a.kv, a.nbs, s.FDAT, NVL(MOD(cc.CODCAGENT,2),1),
          NVL(s.ost,0), NVL(s.ostq,0), a.tip, cc.rnk
   FROM OTCN_SALDO s, OTCN_ACC a, CUSTOMER cc
   WHERE s.acc = a.acc
     AND a.rnk = cc.rnk;

-- ����� ��������� ��������� ����. OTCN_ACC, OTCN_SALDO
-- � OTCN_ACC ��������� CODCAGENT Number,
-- � OTCN_SALDO TIP Varchar2(3), CODCAGENT Number
--CURSOR SALDO IS
--   SELECT s.acc, s.nls, s.kv, s.nbs, s.FDAT, NVL(MOD(s.CODCAGENT,2),1),
--          NVL(s.ost,0), NVL(s.ostq,0), s.tip, s.rnk
--   FROM OTCN_SALDO s;

------------------------------------------------------------------
CURSOR BaseL IS
    SELECT kodp, nbuc, SUM(znap)
    FROM RNBU_TRACE
    WHERE userid=userid_
    GROUP BY kodp, nbuc;
-----------------------------------------------------------------------------
PROCEDURE p_ins(p_dat_ DATE, p_tp_ VARCHAR2, p_acc_ NUMBER, p_nls_ VARCHAR2,p_nbs_ VARCHAR2,
          p_kv_ SMALLINT, p_rez_ VARCHAR2, p_znap_ VARCHAR2, p_nbuc_ VARCHAR2, p_rnk_ number) IS
                kod_ VARCHAR2(10);

BEGIN
   IF LENGTH(Trim(p_tp_))=1 THEN
      IF p_kv_=980 THEN
         kod_:='0' ;
      ELSE
         kod_:='1' ;
      END IF ;
   ELSE
      kod_:= '';
   END IF;

   kod_:= p_tp_ || kod_ || p_nbs_ || LPAD(p_kv_,3,'0') || p_rez_ ;

   IF LENGTH(Trim(p_tp_))>1 THEN
      flag_ := F_Is_Est(p_nls_, p_kv_);
      IF flag_=1 AND mfo_<>315568 and mfou_<>300465 and mfou_<>380764 THEN
         kod_:= p_tp_ || p_nbs_ || '980' || p_rez_ ;
      END IF;
   END IF;

   INSERT INTO RNBU_TRACE
            (nls, kv, odate, kodp, znap, nbuc, acc, rnk)
   VALUES  (p_nls_, p_kv_, p_dat_, kod_, p_znap_, p_nbuc_, p_acc_, p_rnk_);
END;
-----------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
pr_:=0;
-- SERG:
mfo_:=gl.aMFO;
if mfo_ is null then
    mfo_ := f_ourmfo_g;
end if;

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
------------------------------------------------------------------------
--- ��������� ����� "����"  (c 11.03.2005 ��� ���� ������)
--   tsql_ := 'begin '||
--   'IF dat_next_u(:d,1) = bankdate '||
--   'AND to_char(:d,''MM'') <> to_char(bankdate,''MM'')  THEN '||
--   'delete from tmp_customer; '||
--   'insert into tmp_customer '||
--   'select RNK, CUSTTYPE, COUNTRY, NMK, CODCAGENT, PRINSIDER, '||
--   'OKPO, C_REG, C_DST, DATE_ON, DATE_OFF, CRISK, '||
--   'ISE, FS, OE, VED, SED, MB '||
--   'from customer; '||
--   'END IF; '||
--   'end; ';

--   EXECUTE IMMEDIATE tsql_ USING dat_;
------------------------------------------------------------------------
--gl.p_pvp(null,dat_);

--FOR c IN (SELECT kv FROM tabval WHERE kv<>980) LOOP
--   p_rev(c.kv,dat_);
--END LOOP;

-- � ��������� �� 22.09.2005 ����������� ���������� �������� ������� �
-- ���������� �������� �������� ������, � 17.01.2006 �� ���������
-- 21.02.2008
-- �������� ���������� �� ������� ����� ������ (353575)
-- ������ ���(300175), ���(300205), ��������(300465)

-- SERG: ���������������� �������� !!!

if mfo_ in (353575) then
   gl.p_pvp(null,dat_);

   FOR c IN (SELECT kv FROM tabval WHERE kv<>980) LOOP
      p_rev(c.kv,dat_);
   END LOOP;
end if;

-- ����������� ��������� ���������� (��� ������� ��� ��� ��� �������������)
P_Proc_Set(kodf_,sheme_,nbuc1_,typ_);

--sql_acc_ := 'select r020 from kl_r020 where prem=''�� '' and f_01=''1''';
-- 04.02.2008 ������ �������������� KL_R020 ����� ������������ KOD_R020
sql_acc_ := 'select r020 from kod_r020 where trim(prem)=''��'' and a010=''01'' ';

--sql_acc_ := 'select r020 from kl_r020 where prem=''�� '' and f_01=''1'') or '||
--            '(nbs is null and substr(nls,1,4) in
--             (select r020 from kl_r020 where prem=''�� '' and f_01=''1'')';

ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

--- ������������ ��������� � ����. RBNU_TRACE
OPEN SALDO;
LOOP
   FETCH SALDO INTO acc_, nls_, kv_, nbs_, data_, re_, Ostn_, Ostq_,
                    tips_, rnk_ ;
   EXIT WHEN SALDO%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   IF tipost_='R' THEN
      BEGIN
         SELECT NVL(SUM(p.s*DECODE(p.DK,0,-1,1,1,0)),0) INTO Dose_
         FROM OPER o, OPLDOK p
         WHERE o.REF  = p.REF  AND
               p.FDAT = dat_   AND
               o.SOS  = 5      AND
               p.acc  = acc_   AND
               (o.tt  LIKE  'ZG%' OR
               ((SUBSTR(o.nlsa,1,1) IN ('6','7') AND
                 SUBSTR(o.nlsb,1,4) IN ('5040','5041')) OR
                (SUBSTR(o.nlsa,1,4) IN ('5040','5041') AND
                SUBSTR(o.nlsb,1,1) IN ('6','7'))));
      EXCEPTION WHEN NO_DATA_FOUND THEN
         Dose_:=0;
      END;
      Ostn_:=Ostn_-Dose_;
   END IF;

   IF Ostn_<>0 THEN
      dk_:=Iif_N(Ostn_,0,'1','2','2');
      p_ins(data_, dk_, acc_, nls_, nbs_, kv_, TO_CHAR(2-re_), TO_CHAR(ABS(Ostn_)), nbuc_, rnk_);
   END IF;

   IF Ostq_<>0 THEN
      dk_:=Iif_N(Ostq_,0,'1','2','2')||'0';
      p_ins(data_, dk_, acc_, nls_, nbs_, kv_, TO_CHAR(2-re_), TO_CHAR(ABS(Ostq_)), nbuc_, rnk_);
   END IF;

END LOOP;
CLOSE SALDO;
---------------------------------------------------------------------
-- �� ������� ����� �� ��� ������ ���.���������� �������� ��� ������ �� 978
-- ��� ���������� �������� ��� ������ ������ � 01.03.2008
IF mfo_ in (300465) and Dat_ >= to_date('01032008','ddmmyyyy') then
   for k in (select nls, kv, kodp
             from rnbu_trace
             where nls LIKE '3800_000000000%' or nls LIKE '3800_000099999%'
               and kv not in (643, 840, 978) )
   loop

   IF substr(k.kodp,1,2) in ('10','20') THEN
      select count(*)
         into pr_
      from rnbu_trace
      where substr(kodp,1,2)=substr(k.kodp,1,1)||'1'
        and substr(kodp,3,8)=substr(k.kodp,3,8);

      IF pr_=0 then
         kodp_:= substr(k.kodp,1,6) || '978' || substr(k.kodp,-1) ;
         update rnbu_trace set kodp=kodp_
         where nls=k.nls
           and kv=k.kv;
      END IF;
   END IF;

   end loop;

END IF;

-- ����������� � ���������
if mfou_ in (300465,380764) then
   P_OTC_VE9 (dat_, kodf_);
end if;

-- ������� ����� � �������.
DELETE FROM TMP_NBU WHERE kodf=kodf_ AND datf= dat_;

if mfou_ in (300465, 380764) then
   INSERT INTO TMP_NBU (kodf, datf, kodp, nbuc, znap)
   select kodf_, dat_, kodp, nbuc, SUM(znap)
   from RNBU_TRACE  GROUP BY kodp, nbuc;
else
---------------------------------------------------
   --- ������������ ����� � ����. TMP_NBU
   OPEN BaseL;
   LOOP
      FETCH BaseL INTO  kodp_, nbuc_, znap_;
      EXIT WHEN BaseL%NOTFOUND;

      IF SUBSTR(kodp_,7,3)='980' OR SUBSTR(kodp_,2,1)<>'1' THEN
         b_:=znap_;
      ELSE
         dig_:=F_Ret_Dig(TO_NUMBER(SUBSTR(kodp_,7,3)));
         b_:=TO_CHAR(ROUND(TO_NUMBER(znap_)/dig_,0));
      END IF;

      INSERT INTO TMP_NBU
           (kodf, datf, kodp, znap, nbuc)
      VALUES
           (kodf_, Dat_, kodp_, b_, nbuc_);
   END LOOP;
   CLOSE BaseL;
end if;
------------------------------------------------------------------
P_Ch_File01('01',dat_,userid_);
--------------------------------------------------------
END P_F01_Nn;
/
show err;

PROMPT *** Create  grants  P_F01_NN ***
grant EXECUTE                                                                on P_F01_NN        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F01_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
