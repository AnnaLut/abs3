

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F87SBR.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F87SBR ***

  CREATE OR REPLACE PROCEDURE BARS.P_F87SBR (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ ����� @87 ��� ��
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 2009.All Rights Reserved.
% VERSION     : 10/08/2017 (05.03.2014)
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

---������� �� �������� ���� ���.
CURSOR SaldoASeekOstf IS
   SELECT  a.acc, a.nls, a.kv, a.fdat, a.nbs, a.ostf-a.dos+a.kos,
           a.tobo, a.nms
   FROM  (SELECT s.acc, s.nls, s.kv, aa.fdat, s.nbs, aa.ostf,
         aa.dos, aa.kos, s.tobo, s.nms
         FROM saldoa aa, accounts s
         WHERE aa.acc=s.acc     AND
              (s.acc,aa.fdat) in
               (select c.acc,max(c.fdat)
                from saldoa c
                where c.fdat <= dat_
                group by c.acc)) a   
   WHERE a.kv=980
     and a.nbs LIKE '8%'
     and a.nbs not in ('8605','8625','8999')
     and a.acc in (select accn from v_ob22nu_n
                       union
                     select accn from V_OB22NU80_OTC);

---������� ���.
CURSOR SaldoASeekOs IS
   SELECT  a.acc, a.nls, a.kv, a.nbs, NVL(SUM(s.dos),0), NVL(SUM(s.kos),0), a.tobo, a.nms
   FROM saldoa s, accounts a    
   WHERE s.fdat(+) >= Dat1_
     and s.fdat(+) <= dat_
     and a.acc=s.acc(+)
     and a.kv=980
     and a.nbs LIKE '8%'
     and a.nbs not in ('8605','8625','8999')
     and a.acc in (select accn from v_ob22nu_n
                   union
                   select accn from V_OB22NU80_OTC)
   GROUP BY a.acc, a.nls, a.kv, a.nbs, a.tobo, a.nms ;

CURSOR Saldo6_7 IS
   SELECT a.acc, a.accc, a.nls, a.kv, a.nbs
   FROM accounts a, v_ob22nu_n v
   WHERE a.acc = v.acc
     AND v.accn=acc_
     AND a.kv=980 ;

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
---�������������� ��������
DELETE FROM ref_kor ;
IF to_char(Dat_,'MM')='12' THEN
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT /*+ index(o,  IDX_OPER_VDAT_KF) */ 
        ref, vob, vdat
   FROM oper
   WHERE vdat>=Dat1_-3 and vdat<=Dat2_ and
         vob in (96,99) and not
         ((substr(nlsa,1,1) in ('6','7') and substr(nlsb,1,4) in ('5040','5041')) OR
          (substr(nlsa,1,4) in ('5040','5041') and substr(nlsb,1,1) in ('6','7'))) ;
ELSE
   INSERT INTO ref_kor (REF, VOB, VDAT)
   SELECT /*+ index(o,  IDX_OPER_VDAT_KF) */ 
        ref, vob, vdat
   FROM oper o
   WHERE vdat= Dat_ and
         (vob in (96,99) or tt = 'PO1');
END IF ;

DELETE FROM kor_prov ;
INSERT INTO KOR_PROV (REF,  DK,  ACC , S,  FDAT , VDAT, SOS,  VOB)
SELECT o.ref, o.dk, o.acc, o.s, o.fdat, p.vdat, o.sos, p.vob
FROM opldok o, ref_kor p     
WHERE o.fdat>Dat1_     AND
      o.fdat<=Dat2_    AND
      o.ref=p.ref      AND
      o.sos=5 ;

-- ������� ���. --
OPEN SaldoASeekOstf;
LOOP
   FETCH SaldoASeekOstf INTO acc_, nls_, kv_, data_, Nbs_, Ostn8_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOstf%NOTFOUND;

   SELECT count(*) INTO f87_ FROM sb_p0853 WHERE r020=nbs_ ;

   IF f87_ >0 and Ostn8_<>0 THEN

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      comm_ := '';

      BEGIN
         SELECT NVL(p080,'0000'), NVL(r020_fa,'0000'),  NVL(ob22,'00')
            INTO pp_, r020_fa_, zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_:='0000' ;
         r020_fa_ := '0000';
         zz_ := '00';
      END ;

     BEGIN
        SELECT d.acc, SUM(DECODE(d.dk, 0, d.s, 0)),
                      SUM(DECODE(d.dk, 1, d.s, 0))
        INTO acc1_, Dosnk_, Kosnk_
        FROM  kor_prov d
        WHERE d.acc=acc_  AND
              d.fdat > Dat_                AND
              d.fdat <= Dat2_              AND
              d.vob in (6, 96)
        GROUP BY d.acc ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        Dosnk_ :=0 ;
        Kosnk_ :=0 ;
     END ;
     
     Ostn8_:=Ostn8_-Dosnk_+Kosnk_;

     dk_:=IIF_N(Ostn8_,0,'1','2','2');

     kol6_7 := 0;

     comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

     IF kol6_7=0 THEN
        IF pp_ not in ('0000','FFFF') and Ostn8_ <> 0 THEN
           kodp_:=dk_ || pp_ || r020_fa_ || zz_;  --'000000' ;  --- nbs1_='0000',zz_='00'
           znap_:=TO_CHAR(ABS(Ostn8_));
           INSERT INTO rnbu_trace         -- ������� � �������� ������
                   (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
           VALUES  (nls_, kv_, data_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
        END IF ;
     END IF ;
   END IF;
END LOOP;
CLOSE SaldoASeekOstf;
--------------------------------------------------------------------
-- ������� ������� ���. --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn8_, Kosn8_, tobo_, nms_ ;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   SELECT count(*) INTO f87_ FROM sb_p0853 WHERE r020=nbs_ ;

   IF f87_>0 THEN    

      IF typ_>0 THEN
         nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      comm_ := '';

      BEGIN
         SELECT NVL(p080,'0000'), NVL(r020_fa,'0000'), NVL(ob22,'00')
            INTO pp_, r020_fa_, zz_
         FROM specparam_int
         WHERE acc=acc_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         pp_ := '0000' ;
         r020_fa_ := '0000';
         zz_ := '00';
      END ;

     --- �������������� �������� ��������� ������
     BEGIN
        SELECT d.acc,
               SUM(DECODE(d.dk, 0, d.s, 0)),
               SUM(DECODE(d.dk, 1, d.s, 0))
        INTO acc1_, Dosnk_, Kosnk_
        FROM  kor_prov d
        WHERE d.acc=acc_
          AND d.fdat > Dat_
          AND d.fdat <= Dat2_
          AND d.vob in (6, 96)
        GROUP BY d.acc ;
     EXCEPTION WHEN NO_DATA_FOUND THEN
        Dosnk_ :=0 ;
        Kosnk_ :=0 ;
     END ;
     Dosn8_:=Dosn8_+Dosnk_;
     Kosn8_:=Kosn8_+Kosnk_;

     kol6_7 := 0;
     comm_ := substr(comm_ || tobo_ || '  ' || nms_, 1, 200);

     IF kol6_7=0 THEN
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
     END IF;
   END IF;
END LOOP;
CLOSE SaldoASeekOs;
-------------------------------------------------------------------------
---------------------------------------------------
DELETE FROM tmp_irep where kodf='87' and datf= dat_;
---------------------------------------------------
OPEN BaseL;
LOOP
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, nbuc, znap)
   VALUES
        ('87', Dat_, kodp_, nbuc_, znap_);
END LOOP;
CLOSE BaseL;
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
