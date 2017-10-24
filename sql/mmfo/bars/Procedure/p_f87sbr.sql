

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F87SBR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F87SBR ***

  CREATE OR REPLACE PROCEDURE BARS.P_F87SBR (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ ����� @87 ��� ��
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     : 07/04/2017 (05.03.2014)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
���������: Dat_ - �������� ����
           sheme_ - ����� ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 05.03.2014 - ��� ���������� Dat2_ �������� ����� � 28 �� 25
% 04.12.2013 - �� ���������� ����� �� ������� �� ����� ������������
%              �� � �� �������. ���� ���� ������ ������������� �������
%              �� ��� �� ���������� � ���� (��������� ��������)
% 15.09.2012 - ��������� � ������� ����� ����������
% 30.04.2011 - �������acc,tobo � ��������
% 15.03.2011 - � ���� ����������� ������ ��� TOBO � �������� �����
% 19.01.2011 �� ��������� ����������� ���� �.�. 18.05.2010 ���������
%            ��������� ����������� ��� ����� 18.05.2010
%            (����� ���� ���������� �������������� � SPECPARAM_INT)
% 18.05.2010 qwa �������� ������ �����, �� ������� ����������� ���������
%            ������������� ��� ������ � 87 ����
%            ������ "������" �����
%            OAB ����� ���� ���������� �������������� � SPECPARAM_INT
% 26.01.2010 ����� ���������� Dat1_='31122008' � � ������� ������ ��������
%            ������ ����� ������� Dat1_ >= (���� Dat1_ > )
% 12.07.2009 ����� ORDER BY ��� ����. RNBU_TRACE
% 07.07.2009 ������� ������� substr(nbs,1,1)='8%' �� nbs LIKE '8%'
% 02.07.2009 ��������� ���������� ���� p080<>'0000' � 'FFFF'
% 25.03.2009 ������ VIEW V_OB22NU ����� ������������ V_OB22nu_N
% 19.03.2009 �������� �������� �� �������� ������ ��� ������ 8 ������
%            � ��� ������ 6,7 �������
% 28.02.2009 ��� ����� ��������� ���i��� ������ ACCC � ACCOUNTS
%            �������� ������� i� VIEW V_OB22NU �i����i��i ����
%
% ������� 30.01.2009 �� ���������� ������ ��������� �� 10.01.2008
% ��� ���������� Dat1_ ��������� ���� '31122008' ������ '30122008'
% ������� 10.01.2008 �� ���������� ����� �������� ������ �� 30.01.2007
% ������ �� 30.01.2007 ���������� �� 12.01.2006, 26.12.2006
% ������� ������� ������ �������������� �������� � 31-12-2005 �� 31-12-2006
% ��� ������� ������ ������ ���������� ������� ���������� 6,7 �������
% ������� ����������� 31.12.2006
% ����������� ����� �������
% IF to_char(Dat_,'MM')='01' THEN
%   -- �������� ��� ��������
%    Dat1_:=to_date('30122007','DDMMYYYY');
%    Dat1_:=to_date('01' || '01' || to_char(Dat_,'YYYY'),'DDMMYYYY');
% END IF;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   varchar2(2) := '87';
acc_     Number;
acc1_    Number;
acc2_    Number;
accc_    Number;
accc6_   Number;
acc6_    Number;
acc8_    Number;
kol8_    Number;
kol6_7   Number;
sum6_7   Number;
Dosn6_7  Number;
Kosn6_7  Number;
dat1_    Date;
dat2_    Date;
Dose_    DECIMAL(24);
Kose_    DECIMAL(24);
Dosn_    DECIMAL(24);
Kosn_    DECIMAL(24);
Dosn6_   DECIMAL(24);
Kosn6_   DECIMAL(24);
Dosn8_   DECIMAL(24);
Kosn8_   DECIMAL(24);
Dosnk_   DECIMAL(24);
Kosnk_   DECIMAL(24);
Dosnkp_  DECIMAL(24);
Kosnkp_  DECIMAL(24);
se_      DECIMAL(24);
sn_      DECIMAL(24);
Ostn_    DECIMAL(24);
Ostn6_   DECIMAL(24);
Ostn8_   DECIMAL(24);
Oste_    DECIMAL(24);
kodp_    Varchar2(11);
znap_    Varchar2(30);
Kv_      SMALLINT;
Kv6_     SMALLINT;
Kv8_     SMALLINT;
Vob_     SMALLINT;
Nbs_     Varchar2(4);
Nbs1_    Varchar2(4);
Nbs8_    Varchar2(4);
Nbs6_    Varchar2(4);
nls_     Varchar2(15);
nls6_    Varchar2(15);
nls8_    Varchar2(15);
data_    Date;
data1_   Date;
data6_   Date;
data8_   Date;
zz_      Varchar2(2);
pp_      Varchar2(4);
r020_fa_ Varchar2(4);
dk_      Char(1);
f87_     Number;
f87k_    Number;
userid_  Number;
tobo_    accounts.tobo%TYPE;
nms_     accounts.nms%TYPE;
comm_    rnbu_trace.comm%TYPE;
typ_    Number;
nbuc1_  VARCHAR2(12);
nbuc_   VARCHAR2(12);

sql_acc_ VARCHAR2(1000) := '';
ret_     number := 0;

---������� �� �������� ���� ���.
CURSOR SaldoASeekOstf IS
   SELECT  a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ost, a.dos, a.kos,
           a.dos96, a.kos96, a.tobo, a.nms, nvl(sp.ob22, '00'),
           NVL(sp.p080,'0000'), NVL(sp.r020_fa,'0000')
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, 
                 aa.dos, aa.kos, aa.ost, 
                 aa.dos96, aa.kos96,
                 s.tobo, s.nms
          FROM otcn_saldo aa, otcn_acc s 
          WHERE aa.acc=s.acc) a, specparam_int sp   
   WHERE a.kv=980
     and a.acc in (select accn from v_ob22nu_n
                   union
                   select accn from v_ob22nu80)
     and (a.ost <> 0 or a.dos + a.kos <> 0)
     and a.acc = sp.acc(+);

CURSOR BaseL IS
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    GROUP BY kodp,nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_,'MM');

Dat2_ := TRUNC(Dat_ + 25);

-- ����������� ��������� ����������
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);
-------------------------------------------------------------------
sql_acc_ := 'select unique r020 FROM sb_p0853 ';

if to_char(Dat_,'MM') = '12' then
   ret_ := f_pop_otcn(Dat_, 4, sql_acc_, null, 1);
else
   ret_ := f_pop_otcn(Dat_, 3, sql_acc_);
end if;

-- ������� ���. --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn8_, Dosn8_, Kosn8_,
              Dosnk_, Kosnk_, tobo_, nms_, zz_, pp_, r020_fa_;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

   comm_ := '';

   Ostn8_:=Ostn8_ - Dosnk_ + Kosnk_;

   dk_:=IIF_N(Ostn8_,0,'1','2','2');

   comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

   IF pp_ not in ('0000','FFFF') and Ostn8_ <> 0 THEN
      kodp_:=dk_ || pp_ || r020_fa_ || zz_; 
      znap_:=TO_CHAR(ABS(Ostn8_));
               
      INSERT INTO rnbu_trace         -- ������� � �������� ������
               (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF ;

   Dosn8_:=Dosn8_+Dosnk_;
   Kosn8_:=Kosn8_+Kosnk_;

   IF pp_ not in ('0000','FFFF') and Kosn8_ > 0 THEN
      kodp_:='6' || pp_ || r020_fa_ || zz_; 
      znap_:=TO_CHAR(Kosn8_) ;
     
      INSERT INTO rnbu_trace     -- ��. ������� � �������� ������ (���.+���.)
             (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
      VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
   END IF;

    IF pp_ not in ('0000','FFFF') and Dosn8_ > 0 THEN
       kodp_:='5' || pp_ || r020_fa_ || zz_;  
       znap_:=TO_CHAR(Dosn8_);
       
       INSERT INTO rnbu_trace     -- ��. ������� � �������� ������ (���.+���.)
               (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
       VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
    END IF;
END LOOP;
CLOSE SaldoASeekOstf;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='87' and datf= dat_;
---------------------------------------------------
INSERT INTO tmp_irep (kodf, datf, kodp, nbuc, znap)
SELECT '87', Dat_, kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    GROUP BY kodp,nbuc;
------------------------------------------------------------------
END p_f87sbr;
/
show err;

PROMPT *** Create  grants  P_F87SBR ***
grant EXECUTE                                                                on P_F87SBR        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F87SBR        to RPBN002;
grant EXECUTE                                                                on P_F87SBR        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F87SBR.sql =========*** End *** 
PROMPT ===================================================================================== 
