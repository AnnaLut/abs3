

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F56SB.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F56SB ***

  CREATE OR REPLACE PROCEDURE BARS.P_F56SB (Dat_ DATE, sheme_ VARCHAR2 DEFAULT 'C')  IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :	��������� ������������ ����� @56 ��� �������� �����
% COPYRIGHT   :	Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 26.05.2012 (30.04.11,10.03.11,15.02.11,19.03.10,25.08.09)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 26.05.2012 - ��������� � ������� ����� ����������
% 30.04.2011 - �������acc,tobo � ��������
% 10.03.2011 - � ���� ����������� ������ ��� TOBO � �������� �����
%              ��������� �������������� �������� ����������� ������ � 
%              �������� �������������� �������� ��������� ������
% 15.02.2011 - ������ ��-�� SB_OB22 ����� ������������ SB_OB22N �.�.
%              ���� A010 � ����. SB_OB22 �� ����� �����������. 
%              � ����. SB_OB22 ������ ���� ���� ������ �� ���.�� � OB22.
% 19.03.2010 - ����� ���� �������� ��������� OB22 � SPECPARAM_INT
% 24.04.2009 - �� ����� �������� 2909 � OB22='09'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
kodf_   varchar2(2) := '56';
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
typ_     Number; 
nbuc1_   VARCHAR2(12);
nbuc_    VARCHAR2(12);
sql_acc_ varchar2(2000):='';
sql_doda_ varchar2(200):='';
ret_    number;

---������� (�� ���. 2902)
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
    SELECT kodp, nbuc, SUM (znap)
    FROM rnbu_trace
    GROUP BY kodp, nbuc;

BEGIN
-------------------------------------------------------------------
userid_ := user_id;
EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';
-------------------------------------------------------------------
Dat1_ := TRUNC(Dat_, 'MM');
Dat2_ := TRUNC(Dat_ + 28);

-- ����������� ��������� ����������
P_Proc_Set_Int(kodf_,sheme_,nbuc1_,typ_);

-- ���������� ������������� SB_R020 
sql_acc_ := 'select r020 from sb_r020 where f_56=''1'' ';

ret_ := f_pop_otcn(Dat_, 2, sql_acc_,null,1);

-----------------------------------------------------------------------------
-- ������� ������� (���. + ���. �������� ) --
OPEN SaldoASeekOs;
LOOP
   FETCH SaldoASeekOs INTO acc_, nls_, kv_, Nbs_, Dosn_, Kosn_, tobo_, nms_, zz_;
   EXIT WHEN SaldoASeekOs%NOTFOUND;

   comm_ := '';

   IF typ_>0 THEN
      nbuc_ := NVL(F_Codobl_Tobo(acc_,typ_),nbuc1_);
   ELSE
      nbuc_ := nbuc1_;
   END IF;

--- ����� �������������� �������� ����������� ������
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

--- ����� �������������� �������� ��������� ������
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
         INSERT INTO rnbu_trace     -- ��. ������� � �������� ������ (���.+���.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
      END IF;

      IF f56_ > 0 AND Kosn_ > 0 THEN
         kodp_:='6' || nbs_ || zz_ ;
         znap_:=TO_CHAR(Kosn_);
         INSERT INTO rnbu_trace     -- ��. ������� � �������� ������ (���.+���.)
                 (nls, kv, odate, kodp, znap, acc, comm, tobo, nbuc)
         VALUES  (nls_, kv_, dat_, kodp_, znap_, acc_, comm_, tobo_, nbuc_) ;
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
   FETCH BaseL INTO  kodp_, nbuc_, znap_;
   EXIT WHEN BaseL%NOTFOUND;
   INSERT INTO tmp_irep
        (kodf, datf, kodp, znap, nbuc)
   VALUES
        ('56', Dat_, kodp_, znap_, nbuc_);
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
