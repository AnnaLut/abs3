

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F8B_NN.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F8B_NN ***

  CREATE OR REPLACE PROCEDURE BARS.P_F8B_NN (dat_ DATE, type_ NUMBER DEFAULT 0,
                                      prnk_ NUMBER DEFAULT NULL,
                                      pmode_ number default 0)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  ��������� ������������ ����� #8B ��� ��      (����)
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     :  16/05/2016 (09/03/2016, 02/03/2016, 25/06/2014)
%------------------------------------------------------------------------------
% 16.05.2016 - ����� �������� � ��������� ������� ��� ����������� � 
%              ������������ ������ ���������
% 09.03.2016 - �� ������� ���������-����������� ������������  
%              ���������� 970000000 � 09.03.2016 ����� ������������� �������
% 02.03.2016 - ��� 3018,3118,3218 ����� ����� R013='E' (������ 'e')
%              ��� 3190 ����� ����� R013='B'(������ 'b')
%              ��������� 2068, 2088 R013='6' 2088 R013='8'
%                        2108, 2128 R013='A'
% 25.06.2014 - �������� ���.���� 2089
% 19.06.2014 - ��� ����� ��������� ���������� 970000 (��������� ������) 
% 05.05.2014 - ��� ������ ���� ���� (20077720,23167814) ������� � ��-� KL_F8B
%              � � ���������� � ������ ���� ����� ���������� ������ ���� ����
%              ��������� � KL_F8B 
% 30.04.2014 - �������� ����� ��� ���� 23167814 
% 04.09.2012 - ������� ��� ���� � 2007720 �� 20077720
% 03.09.2012 - ��� ��� �� ��������� ����� ���� �� ������� ��� ��������
%              ����� ����������� ������ ���� ���������� "01NNNN"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   dat_Zm_    DATE := TO_DATE('21122005','ddmmyyyy'); -- ��������� � �i� ��i�� ��i��� ��������� ��� �24-622/212 �i� 30.11.2005
   dat_Zm1_   DATE := TO_DATE('01042006','ddmmyyyy'); -- ���������� ���i ��������� 61NNNN, 62NNNN, 630000
   dat_Zm2_   DATE := TO_DATE('19112009','ddmmyyyy'); -- ��������� ����� �������� 71NNNN
   dat_Zm3_   DATE := TO_DATE('19072010','ddmmyyyy'); -- ��������� ����� �������� 82NNNN

   pr_bank    VARCHAR2 (1);
   k041_      VARCHAR2 (1);
   k042_      VARCHAR2 (1);
   kodf_      VARCHAR2 (2):= '42';
   kf1_       VARCHAR2 (2):= '01';
   nls_       VARCHAR2 (15);
   nlsp_      VARCHAR2 (15);
   nlsi_      VARCHAR2 (15);
   nlspp_     VARCHAR2 (15);
   nlspp1_    VARCHAR2 (15);
   nlsu_      VARCHAR2 (15);
   nlsu_72    VARCHAR2 (15);
   data_      DATE;
   dat1_      DATE;
   ddd_       VARCHAR2 (3);
   r012_      VARCHAR2 (1);
   r013_      VARCHAR2 (1);
   r050_      VARCHAR2 (2);
   kv_        SMALLINT;
   kvp_       SMALLINT;
   se_        DECIMAL (24);
   se54_      DECIMAL (24);
   sp_        DECIMAL (24)   := 0;
   sp1_       DECIMAL (24)   := 0;
   spp_       DECIMAL (24)   := 0;
   spp_72     DECIMAL (24)   := 0;
   si_        DECIMAL (24)   := 0;
   s02_       DECIMAL (24)   := 0;
   s03_       DECIMAL (24)   := 0;
   s04_       DECIMAL (24)   := 0;
   s05_       DECIMAL (24)   := 0;
   s_nd       DECIMAL (24)   := 0;
   s_pnd      DECIMAL (24)   := 0;
   s_rez      DECIMAL (24)   := 0;
   ek2_       DECIMAL (24)   := 0;
   ek3d_      DECIMAL (24);
   ek3k_      DECIMAL (24);
   ek4_       DECIMAL (24)   := 0;

   sum_k_     DECIMAL (24); -- ���� ������������� ���i����
   sum_k_19   DECIMAL (24); -- ���� ������������� ���i���� �� 19.07.2010
   sum_SK_    DECIMAL (24); -- ���� ���������� ���i����

   kodp_      VARCHAR2 (10);
   kodpp_     VARCHAR2 (10);
   kodpp1_    VARCHAR2 (10);
   kodpi_     VARCHAR2 (10);
   znap_      VARCHAR2 (30);
   znapp_     DECIMAL (24)   := 0;
   znapp1_    DECIMAL (24)   := 0;
   znapi_     DECIMAL (24)   := 0;
   znapu_     DECIMAL (24)   := 0;
   znapu_72   DECIMAL (24)   := 0;
   mfo_       NUMBER;
   mfou_      NUMBER;
   rnk_       NUMBER;
   rnka_      NUMBER;
   rnk1_      NUMBER;
   rnk2_      NUMBER;
   nnnn_      NUMBER         := 0;
   nnn1_      NUMBER         := 0;
   nnn2_      NUMBER         := 0;
   nnnn1_     NUMBER         := 0;
   nnnn2_     NUMBER         := 0;
   nnnn41_    NUMBER         := 0;
   nnnn42_    NUMBER         := 0;
   nnnn54_    NUMBER         := 0;
   nnnn01_    NUMBER         := 0;
   f42_       NUMBER;
   insider_   SMALLINT;
   userid_    NUMBER;
   pdat_      DATE;
   pacc_      NUMBER;
   ksum_      NUMBER         := 0;
   sql_       VARCHAR2 (3000);
   flag_      NUMBER;
   k1_        NUMBER;
   k2_        NUMBER;
   k3_        NUMBER;
   sz_        NUMBER;
   acc_       NUMBER;
   accs_      NUMBER;
   sk_        NUMBER;
   kk_        NUMBER;
   nbs_       VARCHAR2 (5);
   s080_      VARCHAR2 (20);
   pr_        NUMBER;
   our_okpo_  varchar2(10);
   our_rnk_   NUMBER;
   flag_inc_  BOOLEAN := FALSE;
   s_zal_     NUMBER;
   s_zalp_    NUMBER := 0;
   prizn_     NUMBER;
   s_prizn_   NUMBER;
   fmt_       VARCHAR2(30):='999G999G999G990D99';
   p57_       NUMBER;
   p47_       NUMBER:=0;
   p71_       NUMBER:=0;
   ostc_      NUMBER:=0;
   p51_       NUMBER:=0;
   rnki_      NUMBER;
   rnku_      NUMBER;
   rnku_72    NUMBER;
   rnkp_      NUMBER;
   rnkp1_     NUMBER;
   vNKA_      NUMBER;
   sz_all_    number;
   sk_all_    number;
   sz0_       number;
   sz1_       number;
   fl_tp_1    number;
   fl_tp_2    number;
   fl_tp_3    number;
   fl_tp_4    number;
   rgk_       number;
   s180_      Varchar2(1);
   s240_      Varchar2(1);
   p240r_     Varchar2(1);
   vost_      number;
   poisk_     Varchar2(1000);

   pragma     AUTONOMOUS_TRANSACTION;

   ---������� ��� 01, 02, 03, 04, 06
CURSOR saldo  IS
    select ddd, rnk, prins, znap, tp_1, tp_2, tp_3, tp_4
    from (
        select ddd, rnk, prins, znap, tp_1, tp_2, tp_3, tp_4, znap - tp_1 - tp_2 - tp_3 - tp_4 sum_kor
        from (
           SELECT  /*index(a) index(c)*/
                   a.ddd, DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
                   DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1) prins,
                   ABS (SUM (a.ost_eqv)) znap,
                   ABS (NVL (sum((case when a.r020 IN ('1524', '9129') and NVL (p.r013, '0') NOT IN ('0', '1') 
                                    then a.ost_eqv 
                                    else 0 
                                   end)),0)) tp_1,
                   ABS (NVL (sum((case when a.r020 IN ('3103', '3105') AND NVL (p.r013, '0') = '2' 
                                    then a.ost_eqv 
                                    else 0 
                                  end)),0)) tp_2,
                   ABS (NVL (sum((case when a.r020 = '3212' AND NVL (p.r013, '0') <> '2' 
                                    then a.ost_eqv 
                                    else 0 
                                  end)),0)) tp_3,
                   ABS (NVL (sum((case when a.r020 = '3540' AND NVL (p.r013, '0') = '9' 
                                    then a.ost_eqv 
                                    else 0 
                                  end)),0)) tp_4
           FROM OTCN_F42_TEMP a, CUSTOMER c, specparam p
           WHERE a.ap=a.r012 AND
                 NOT exists (SELECT 1
                             FROM OTCN_F42_TEMP b
                             WHERE  b.ap=b.r012        AND
                                    b.nbs IS NULL      AND
                                    b.ACCC = a.acc ) AND
                 a.rnk=c.rnk      AND
                 (trim(c.okpo) in (select trim(okpo) from kl_f8b where trim(okpo) is not null) or
                  a.ddd='006' and (nls like '3%' or nls like '4%')) AND
                 (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_) and
                 a.acc = p.acc(+)
           GROUP BY a.ddd, DECODE (c.rnkp, NULL, c.rnk, c.rnkp),
                    DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1)
           union all
           SELECT /*index(a) index(c)*/
                   a.ddd, a.accc rnk,
                   DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1) prins,
                   ABS (SUM (a.ost_eqv)) znap,
                   ABS (NVL (sum((case when a.r020 IN ('1524', '9129') and NVL (p.r013, '0') NOT IN ('0', '1') 
                                    then a.ost_eqv 
                                    else 0 
                                   end)),0)) tp_1,
                   ABS (NVL (sum((case when a.r020 IN ('3103', '3105') AND NVL (p.r013, '0') = '2' 
                                    then a.ost_eqv 
                                    else 0 
                                  end)),0)) tp_2,
                   ABS (NVL (sum((case when a.r020 = '3212' AND NVL (p.r013, '0') <> '2' 
                                    then a.ost_eqv 
                                    else 0 
                                  end)),0)) tp_3,
                   ABS (NVL (sum((case when a.r020 = '3540' AND NVL (p.r013, '0') = '9' 
                                    then a.ost_eqv 
                                    else 0 
                                  end)),0)) tp_4
           FROM OTCN_F42_TEMP a, CUSTOMER c, specparam p
           where a.acc is null and
             a.accc=c.rnk AND
             (trim(c.okpo) in (select trim(okpo) from kl_f8b where trim(okpo) is not null) or 
              a.ddd='006' and (nls like '3%' or nls like '4%')) AND
             (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_) and
             a.acc = p.acc(+)
           group by a.ddd, a.accc,
                    DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1)))
   order by ddd, abs(to_number(sum_kor)) desc;

---�������  ����  "47-51"
   CURSOR saldoost3 IS
        SELECT ACC, NLS, KV, FDAT, DDD, R012, ACCC, OST_EQV
        from OTCN_F42_TEMP
        where ap=0;
-------------------------------------------------------------------------
   CURSOR basel IS
      SELECT   kodp, SUM (znap)
      FROM RNBU_TRACE
      WHERE userid = userid_
        and kodp like '01%' 
      GROUP BY kodp;

    PROCEDURE p_ins(p_kod_ VARCHAR2, p_val_ NUMBER) IS
    BEGIN
       IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
           INSERT INTO OTCN_LOG (kodf, userid, txt)
           VALUES(kodf_,userid_,p_kod_||TO_CHAR(p_val_/100, fmt_));
       END IF;
    END;
---------------------------------------------------------------------------
BEGIN
-------------------------------------------------------------------
   execute immediate('alter session set nls_numeric_characters=''.,''');

   userid_ := user_id;

   EXECUTE IMMEDIATE 'DELETE FROM otcn_f42_history WHERE fdat = :dat_ ' using dat_;

   EXECUTE IMMEDIATE 'truncate table RNBU_TRACE';

   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';
   EXECUTE IMMEDIATE 'truncate table otcn_f42_zalog';

-------------------------------------------------------------------
-- ���� ���
   mfo_ := F_Ourmfo ();

-- ��� "��������"
   BEGIN
      SELECT mfou
        INTO mfou_
        FROM BANKS
       WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   -- ��� ����� (0 - ������������, 1 - �������������� �������)
   flag_ := F_Get_Params ('NORM_TPB', 0);

   -- ������� ��������� �������������� ������ � �������� ���� ������
   IF flag_ > 0 THEN
         vNKA_ := F_Get_Params ('NOR_NKA', 0);
   ELSE  -- ��� ������������� ����� �� �� ��������
         vNKA_ := 0;
   END IF;

   --������ �i����i�����i ����� ��. 2.5-2.7 ����� 2 ����i�� VI I�������i� ��� ������� ����������� �i�������i ����i� ������
   -- � ���� - ������i��� ���������� �������������i, �� �������� 25% ������������� ���i����
   s_prizn_:= F_Get_Params ('NORM_OP', 0);

   IF flag_ = 0
   THEN
      k1_ := 0.25; -- ��� ��������� �7
      k2_ := 0.05; -- ��� ��������� �9
      k3_ := 0; -- ��� ��������� �10
   ELSE
      IF vNKA_ = 0 THEN
         k1_ := 0.05;
         k2_ := 0.02;
         k3_ := 0;
      ELSE
         k3_ := 0;
         k2_ := 0.02;

         -- ��� ��������� �9
         CASE
            WHEN vNKA_ <= 10 THEN
               k1_ := 0.2;

               -- ��� ��������� �10
               CASE
                  WHEN vNKA_ <= 7 THEN k3_ := 0.2;
                  WHEN vNKA_ <= 10 THEN k3_ := 0.1;
               ELSE
                  k3_ := 0;
               END CASE;

            WHEN vNKA_ <= 20 THEN k1_ := 0.15;
            WHEN vNKA_ <= 30 THEN k1_ := 0.1;
         ELSE
            k1_ := 0.5;
         END CASE;

      END IF;
   END IF;

   our_rnk_ := F_Get_Params ('OUR_RNK', -1);
   our_okpo_ := nvl(to_char(F_Get_Params ('OKPO', 0)), '0');
   
---���� ������������� ���i���� ����� (�i����������� ��i��� ��������� ���)
--- �i� � 01.10.2004 �������� ��������� ���� 5999 ���������� (����������)
--- �� ���� [(��+���+���)-���]*0.2.    ��� ������������ � �����ii.
--- ���� ���� ���.���i���� < 0 , �� �������� ����=1000000000 (10 ���.)
--- ��������� ���� #42 �i���� �i��� ���������� ����� #01

   rgk_ := Rkapital (dat_+1, kodf_, userid_, 1); -- ��_�� 27.12.2005 - ��� ���������� ��������_� ��������������� ���_������������ ���_���

   if rgk_ <= 0 then
      sum_k_ := 100;
      s_prizn_ := 1; -- ��� �� ���������� �������� 41
   else
      sum_k_ := rgk_;
   end if;

   IF dat_ >= dat_Zm_ THEN    -- � 21.12.2005
      -- ��������� ���i���
      BEGIN
         SELECT SUM(ost)
         INTO   sum_SK_
         FROM   sal
         WHERE  fdat=Dat_ AND
                nbs IN ('5000','5001', '5002');
      EXCEPTION WHEN NO_DATA_FOUND THEN
         sum_SK_:=0 ;
      END ;

      IF NVL(sum_SK_, 0) = 0 THEN
         sum_sk_:= NVL(Trim(F_Get_Params ('NORM_SK', 0)), 0);
      END IF;

      IF kodf_ IS NOT NULL AND userid_ IS NOT NULL THEN
         p_ins(' -------------------------------- ���������� #42 �����  --------------------------------- ', NULL);

         p_ins('��� ����� -  '|| (CASE flag_ WHEN 0 THEN  '������������' ELSE '�������' END), NULL);

         IF vNKA_ > 0 THEN
             p_ins('³������ ���������-�������������� ������: '||TO_CHAR(vNKA_), NULL);
         END IF;

         p_ins(' --------------------------------- ��������� --------------------------------- ',NULL);

         p_ins('������������ ���i��� (��1): ', sum_k_);

         p_ins('�������� 01 �� 41 ('||TO_CHAR(k1_*100)||'% �� ��1): ',sum_k_ * k1_);

         p_ins('�������� 02 (10% �� ��1): ',sum_k_ * 0.1);

         p_ins('�������� 42 ('||TO_CHAR(k2_*100)||'% �� ��1): ',sum_k_ * k2_);

         p_ins('�������� 06  (15% �� ��1): ',sum_k_ * 0.15);

         IF flag_>0 THEN
           p_ins('�������� 61 (20% �� ��1): ',sum_k_ * 0.2);
         END IF;

         p_ins(' ----------------------------------------------------------------------------------------- ',NULL);

         p_ins('��������� ���i���: ', sum_SK_);

         p_ins('�������� 03 ('||TO_CHAR(k2_*100)||'% �� ���������� ���i����): ',sum_SK_ * k2_);

         IF k3_ <> 0 THEN
            p_ins('�������� 63 ('||TO_CHAR(k3_*100)||'% �� ���������� ���i����): ',sum_SK_ * k3_);
         END IF;

         p_ins('�������� 72  (15% �_� ���������� ���i����): ',sum_SK_ * 0.15);

      END IF;
   ELSE
      sum_SK_:= sum_k_ ;
   END IF;

-- ������_� ������� ���� ��_����� ���_���
   SELECT MAX (FDAT)
      INTO pdat_
   FROM FDAT
   WHERE FDAT <= dat_;

---------------------------------------------------------------------------
if mfo_ <> 324805 
then
   if pmode_ = 0 and s_prizn_ = 0 then
       insert into otcn_f42_temp(ACC, NLS, KV, FDAT, DDD, R012, ACCC, OST_EQV, ap)
       SELECT /*+index(a.s)*/
                 a.acc, a.nls, a.kv, a.FDAT, k.ddd, NVL (p.r013, '0'),
                 DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
                 ABS (SUM (Gl.P_Icurval (a.kv, a.ost, dat_))), 0
          FROM (SELECT AA.acc, s.nls, s.kv, AA.FDAT, s.nbs,
                       AA.ostf - AA.dos + AA.kos ost,
                       DECODE(SIGN(AA.ostf - AA.dos + AA.kos), -1, '11', '22') r050
                FROM SALDOA AA, ACCOUNTS s
                WHERE AA.acc = s.acc
                  AND (s.acc, AA.FDAT) =
                     (SELECT c.acc, MAX(c.FDAT)
                      FROM SALDOA c
                      WHERE s.acc = c.acc
                        AND c.FDAT <= dat_
                      GROUP BY c.acc)
                  AND AA.ostf - AA.dos + AA.kos <> 0
                  AND s.nbs in (select distinct r020
                                from kl_f3_29
                                where kf=kodf_ and ddd in ('047','051')) ) a,
                              KL_F3_29 k, SPECPARAM p, CUST_ACC ca, CUSTOMER c
          WHERE a.acc=ca.acc
            AND ca.rnk=c.rnk
            AND a.nbs = k.r020
            AND k.kf = kodf_
            AND k.ddd IN  ('047', '051')
            AND a.acc = p.acc
            AND NVL (p.r013, '0') = k.r012
            AND k.r050 = a.r050
        AND (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_)
        AND trim(c.okpo) not in (select trim(okpo) from kl_f8b where trim(okpo) is not null)
          GROUP BY a.acc, a.nls, a.kv, a.FDAT, k.ddd, NVL (p.r013, '0'),
                   DECODE (c.rnkp, NULL, c.rnk, c.rnkp);

        insert into otcn_f42_zalog(ACC, ACCS, ND, NBS, R013, OST)
        SELECT z.acc, z.accs, z.nd, a.nbs, p.r013,
               gl.p_icurval (a.kv, a.ost, dat_) ost
          FROM cc_accp z, sal a, specparam p
         WHERE z.acc in (select acc from otcn_f42_temp where ap = 0)
           AND z.accs = a.acc
           and a.fdat=dat_
           AND a.acc = p.acc
           AND a.nbs || p.r013 <> '91299'
           and a.ost<0;
       
       
       ---- ������������ ����� 47-51
       OPEN saldoost3;

       LOOP
          FETCH saldoost3
           INTO acc_, nls_, kv_, data_, ddd_, r013_, rnk_, se_;
          EXIT WHEN saldoost3%NOTFOUND;

          IF r013_ = '0'
          THEN
             ddd_ := '098'; -- ��� ��������
          END IF;

          IF ddd_ IN ('047', '051') THEN
             -- ����� �������������, ���. ��������� ������ �����
             sk_ := 0;
             sz_ := 0;
             se_ := abs(se_);
                
             -- ����� �������, ������� ������������ ������ ����� (�.�. � ������� �� ""��������")
             begin
                select sum(OST)
                   into sk_all_
                from otcn_f42_zalog
                where acc=acc_;
             exception
                       WHEN NO_DATA_FOUND THEN
                sk_all_ := 0;
             end;
            
             -- �������� ��� ������, � ������� "��������" ������ ����� 
             For k in (select z.ACC, z.ACCS, z.ND, z.NBS, z.R013, z.OST, 
                            DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk
                       from OTCN_F42_ZALOG z, cust_acc ca, customer c
                       WHERE z.ACC = acc_ and
                             z.accs = ca.acc and
                             ca.rnk = c.rnk)
             loop
                 ostc_:=0;
                 
                 -- ��������� ������� ������ �� ������ �����
                 if abs(k.ost) < abs(sk_all_) then -- �� ���� �����
                    sz1_ := round(abs(k.ost / sk_all_) * se_, 0);
                 else
                    sz1_ :=  se_;
                 end if;

                -- ��� ������������� �� ������������ ����� ������������� �� ����� ��������/������
                -- ������ �� ������ �. (01/10/2007)
                 if mfou_ NOT IN (300120, 353575) THEN  -- 300120 NOT IN (mfo_, mfou_)
                    -- ���������� ������� ������ �������� ��� ������
                    BEGIN
                       select SUM(NVL(Gl.P_Icurval( s.KV, s.ost, dat_ ) ,0))
                          INTO s04_
                       from sal s
                       where s.fdat=dat_
                         AND s.acc in (select d.acc
                                       from nd_acc d, accounts s
                                       where d.acc<>acc_ and
                                             d.nd = k.nd and
                                             d.acc=s.acc and
                                             s.rnk=rnk_  and 
                                             substr(s.nbs,4,1) in ('5','6','9')
                                             and substr(s.nbs,1,3)=substr(k.nbs,1,3));
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                       s04_ := 0;
                    END;

                    ostc_ := abs(k.ost + NVL(s04_,0));
                 else
                    ostc_ := abs(k.ost);
                 end if;
                                     
                 -- ��������, ������� ��������� ��������, ��������� � ������ ���
                 if k.rnk <> rnk_ then
                    rnk_ := k.rnk;
                 end if;

                 -- �� ��������, �.�. ������ ����������� ������ �� ��� ����� (��� � �5) - ������������
                 if nls_ like '9010%' and k.nbs='9023' and k.r013='1' then
                    null;
                 else
                    BEGIN
                        select nvl(SUM(ost_eqv),0)
                        INTO s02_
                        from otcn_f42_temp
                        where accc=k.accs
                          AND ap=1;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                        s02_ := 0;
                    END;

                    if s02_ < ostc_ then
                       if s02_ + sz1_ >= ostc_ then
                          sz0_ := ostc_ - s02_;
                       else
                          sz0_ := sz1_;
                       end if;
                        
                       if sz0_ <> 0 then
                          sz_ := sz_ + sz0_;
                          sk_ := sk_ + abs(ostc_);
                          
                          insert into otcn_f42_temp(ACC, ACCC, OST_EQV, ap, kv)
                          values(acc_, k.accs, sz0_, 1, kv_);

                          kodp_ := SUBSTR (ddd_, 2, 2) || '0000';
                          znap_ := TO_CHAR (sz0_);

                          INSERT INTO RNBU_TRACE(nls, kv, odate, kodp, znap, rnk, acc)
                          VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, acc_);
                       end if;
                    end if;
                 end if;
             end loop;
          END IF;
       END LOOP;

       CLOSE saldoost3;
   end if;
   
   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';

   if prnk_ IS NULL then
      INSERT INTO OTCN_F42_TEMP(ACC, KV, FDAT, NBS, NLS, OST_NOM, OST_EQV,
                                 AP, R012, DDD, R020, ACCC, ZAL, RNK)
       SELECT a.acc, a.kv, a.FDAT, a.nbs, a.nls, a.ost_nom,
              Gl.P_Icurval (a.kv, a.ost_nom, dat_) ost_eqv,
              DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012,
              a.ddd, a.r020, a.accc, 0, a.rnk
       FROM (SELECT s.acc, s.nls, s.kv, AA.FDAT, s.nbs,
                    AA.ostf-AA.dos+AA.kos ost_nom, s.accc, s.rnk,
                    k.r012, k.ddd, k.r020
             FROM SALDOA AA, ACCOUNTS s, KL_F3_29 k, customer r 
             WHERE AA.acc=s.acc            
               AND (s.acc, AA.FDAT) =
                  (SELECT c.acc, MAX(c.FDAT)
                   FROM SALDOA c
                   WHERE s.acc = c.acc
                     AND c.FDAT <= dat_
                   GROUP BY c.acc)
               and k.kf='42'              
               and k.ddd IN ('001', '006') 
               and s.nls LIKE k.r020||'%'  
               and (s.nbs is null or substr(s.nls,1,4)=s.nbs ) 
               and s.rnk = r.rnk 
               and trim(r.okpo) in (select trim(okpo) from kl_f8b where trim(okpo) is not null) ) a
        where a.ost_nom<>0;
   else
      INSERT INTO OTCN_F42_TEMP(ACC, KV, FDAT, NBS, NLS, OST_NOM, OST_EQV,
                                 AP, R012, DDD, R020, ACCC, ZAL, RNK)
       SELECT /*+INDEX(a.s)*/
                 a.acc, a.kv, a.FDAT, a.nbs, a.nls, a.ost_nom,
              Gl.P_Icurval (a.kv, a.ost_nom, dat_) ost_eqv,
              DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, k.r012,
              k.ddd, k.r020, a.accc, 0, a.rnk
       FROM (SELECT s.acc, s.nls, s.kv, AA.FDAT, s.nbs,
                    AA.ostf-AA.dos+AA.kos ost_nom, s.accc, s.rnk
             FROM SALDOA AA, ACCOUNTS s, CUSTOMER r
             WHERE AA.acc = s.acc     
               AND (s.acc, AA.FDAT) =
                  (SELECT c.acc, MAX(c.FDAT)
                   FROM SALDOA c
                   WHERE s.acc = c.acc
                     AND c.FDAT <= dat_
                   GROUP BY c.acc)
               and s.rnk = r.rnk 
               and trim(r.okpo) in (select trim(okpo) from kl_f8b where trim(okpo) is not null) 
               and DECODE (r.rnkp, NULL, r.rnk, r.rnkp)=prnk_) a, KL_F3_29 k
      WHERE ((a.nbs IS NOT NULL AND a.nbs=k.r020)   OR
              (a.nbs IS NULL AND a.nls LIKE k.r020||'%'))  AND
              k.kf='42' AND
              k.ddd IN ('001', '006');
   end if;

   -- ������������ ����� 01, 02, 03, 04
   OPEN saldo;

   LOOP
      FETCH saldo
       INTO ddd_, rnk_, insider_, se_, fl_tp_1, fl_tp_2, fl_tp_3, fl_tp_4;

      EXIT WHEN saldo%NOTFOUND;
      
      s_zal_ := 0;
      
      s02_ := 0;
      s03_ := 0;
      s04_ := 0;
      s05_ := 0;
      p71_ := 0;

      IF ddd_ = '001'
      THEN
         f42_ := 0;

         SELECT COUNT (*)
            INTO f42_
         FROM KL_F3_29
         WHERE txt IS NOT NULL AND
           kf = kodf_ AND
           txt = TO_CHAR (rnk_);

         IF se_ <> 0 AND f42_ = 0
         THEN
            --- ������������ ����� �������� �� ������ �������� (��� 01)
            --- �������� �������� ����� (�������� R013 ������ ������������ ��������)
            if fl_tp_1 > 0 then
               s02_ := fl_tp_1;
            end if;

            if fl_tp_2 > 0 then
               s03_ := fl_tp_2;
            end if;

            --- �������� �������� ����� (�������� R013 ������ ������������ ��������)
            if fl_tp_3 > 0 then
               s04_ := fl_tp_3;
            end if;

            --- �������� �������� ����� (�������� R013 ������ ������������ ��������) 3540 R013='9'
            if fl_tp_4 > 0 then
               s05_ := fl_tp_4;
            end if;

            se_ := se_ - s02_ - s03_ - s04_ - s05_;

            nlsp_ := 'RNK =' || TO_CHAR (rnk_);
            znap_ := TO_CHAR (ABS (se_));
            s_zal_:= 0;
 
            IF ABS (se_) > ROUND (sum_k_ * k1_, 0) and rgk_ >= 0 and s_prizn_=0
            THEN
              nnnn01_ := nnnn01_ + 1;
              kodp_ := '01' || LPAD (nnnn01_, 4, '0');

              INSERT INTO RNBU_TRACE
                          (nls, kv, odate, kodp, znap, rnk
                          )
                   VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                          );

              -- ������������ 61 ���������� � 01.04.2006
              -- (�����.������.�� ���������� � ����������.NNNN,�� >20%�� �� ������� ������� ��� � �/��.� <=10%)
              IF flag_>0 AND dat_>=dat_Zm1_ AND vNKA_<=10 AND ABS(se_)>ROUND(sum_k_*0.2, 0) THEN
                 kodp_ := '61' || LPAD (nnnn01_, 4, '0');

                 INSERT INTO RNBU_TRACE
                             (nls, kv, odate, kodp, znap, rnk) VALUES
                             (nlsp_, 0, dat_, kodp_, znap_, rnk_);
              END IF;

              -- ���������� 47 ����������
              begin
                 select nvl(sum(to_number(znap)), 0)
                 into p47_
                 from rnbu_trace 
                 where kodp like '47%' and
                       rnk = rnk_;
              exception
                 when no_data_found then
                    p47_ := 0;
              end;

              -- ���������� 51 ����������
              begin
                 select nvl(sum(to_number(znap)), 0)
                 into p51_
                 from rnbu_trace 
                 where kodp like '51%' and
                       rnk = rnk_;
              exception
                 when no_data_found then
                    p51_ := 0;
              end;
                 
              IF p47_<>0 OR p51_ <> 0 THEN
                 s_zal_:= p47_ + p51_;

                 IF s_zal_ > ABS (se_) THEN
                    s_zal_ := ABS (se_);
                 END IF;
              END IF;

              IF s_zal_ <> 0 THEN
                 kodp_ := '05' || LPAD (nnnn01_, 4, '0');
                 INSERT INTO RNBU_TRACE
                          (nls, kv, odate, kodp, znap, rnk)
                   VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), rnk_);
              END IF;

              if dat_ > dat_Zm2_ then
                 SELECT ABS (NVL (SUM (s.ost_eqv), 0))
                    INTO p71_
                 FROM OTCN_F42_TEMP s, CUSTOMER c, SPECPARAM p,
                      KL_F3_29 k
                 WHERE s.rnk = c.rnk
                   AND s.acc = p.acc(+)
                   AND NVL (c.rnkp, c.rnk) = rnk_
                   AND s.nbs=k.r020
                   AND k.kf='42'
                   AND k.ddd='071'
                   AND p.r013=k.r012 ;

                 -- �������� 71
                 ksum_ := ROUND (sum_k_ * k1_, 0);  --ROUND (sum_k_ * 0.2, 0)

                 IF ABS(p71_) > ksum_ and rgk_ >= 0
                 THEN
                    insert into otcn_log (kodf, userid, txt)
                    values (kodf_, userid_, '�������� 71 rnk = '||
                       to_char(rnk_)||'  p71 = '||to_char(p71_-ksum_));

                    kodp_ := '71' || LPAD (nnnn01_, 4, '0');
                    INSERT INTO RNBU_TRACE
                      (nls, kv, odate, kodp, znap, rnk)
                    VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (p71_-ksum_), rnk_);
                 END IF;

              end if;

              flag_inc_ := TRUE;
            ELSE
              flag_inc_ := FALSE;
            END IF;

           -- ����� ������������ ����� ����� ���, ������� �� ��������. ������� ABS(se_)>ROUND(sum_k_*0.25,0)
            IF NOT flag_inc_ AND ABS (se_) >= sp_ 
            THEN
             -- ���������� 47 ����������
              begin
                 select nvl(sum(to_number(znap)), 0)
                  into p47_
                 from rnbu_trace 
                 where kodp like '47%' and
                       rnk = rnk_;
              exception
                when no_data_found then
                     p47_ := 0;
              end;

              -- ���������� 51 ����������
              begin
                 select nvl(sum(to_number(znap)), 0)
                 into p51_
                 from rnbu_trace 
                 where kodp like '51%' and
                       rnk = rnk_;
              exception
                 when no_data_found then
                    p51_ := 0;
              end;

              IF p47_<>0 OR p51_ <> 0 THEN
                 s_zal_:= p47_ + p51_;

                 IF s_zal_ > ABS (se_) THEN
                    s_zal_ := ABS (se_);
                 END IF;
              END IF;
                  
              if s_zal_ <> 0 then   
                 znapp_ := znap_;
                 nlspp_ := nlsp_;
                 rnkp_  := rnk_;
                 s_zalp_:= s_zal_;
                 sp_ := ABS (se_);
              end if;
            END IF;

           -- ��� ����� �����������
           -- ����� ������������ ����� ����� ���, ������� �� ��������. ������� ABS(se_)>ROUND(sum_k_*0.25,0)
            IF NOT flag_inc_ AND ABS (se_) >= sp1_ 
            THEN
              -- ���������� 47 ����������
               begin
                  select nvl(sum(to_number(znap)), 0)
                   into p47_
                  from rnbu_trace 
                  where kodp like '47%' and
                        rnk = rnk_;
               exception
                  when no_data_found then
                     p47_ := 0;
               end;

              -- ���������� 51 ����������
               begin
                 select nvl(sum(to_number(znap)), 0)
                 into p51_
                 from rnbu_trace 
                 where kodp like '51%' and
                       rnk = rnk_;
               exception
                 when no_data_found then
                    p51_ := 0;
               end;

               IF p47_+p51_ = 0 THEN
                  znapp1_ := znap_;
                  nlspp1_ := nlsp_;
                  rnkp1_  := rnk_;
                  sp1_ := ABS (se_);
               END IF;
            END IF;

            IF ABS (se_) > ROUND (sum_k_ * 0.1, 0)
            THEN
              IF type_ = 0
              THEN
                 kodp_ := '020000';
              ELSE
                 nnn1_ := nnn1_ + 1;
                 kodp_ := '02' || LPAD (nnn1_, 4, '0');
              END IF;

              INSERT INTO RNBU_TRACE
                          (nls, kv, odate, kodp, znap, rnk
                          )
                   VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                          );
            END IF;

            -- �������� 41
            ksum_ := ROUND (sum_k_ * k1_, 0);

            -- �������� 41 ������� ���� ���_, ���� ���. ���� �������������_ �� ���� ������_� �_���� 25% �_� ��
            IF ABS (se_) - s_zal_ > ksum_ AND s_prizn_=0  --ABS (se_) - ABS(p47_) > ksum_ AND s_prizn_=0
            THEN
              nnnn41_ := nnnn41_ + 1;
              kodp_ := '41' || LPAD (nnnn41_, 4, '0');
              znap_ := TO_CHAR (ABS (se_) - ksum_);

              INSERT INTO RNBU_TRACE
                          (nls, kv, odate, kodp, znap, rnk
                          )
                   VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                          );
            END IF;

            IF insider_ = 1
            THEN
               nlsp_ := 'RNK =' || TO_CHAR (rnk_);
               znap_ := TO_CHAR (ABS (se_));

               IF type_ = 0
               THEN
                  kodp_ := '040000';
               ELSE
                  nnn2_ := nnn2_ + 1;
                  kodp_ := '04' || LPAD (nnn2_, 4, '0');
               END IF;

               insert into otcn_f42_history(FDAT, RNK, SUM, USERID)
               values (dat_, rnk_, ABS (se_), userid_);

               INSERT INTO RNBU_TRACE
                           (nls, kv, odate, kodp, znap, rnk )
               VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_ );

               -- � 21.12.2005 ����������� 5% ���������� ���i���� �����
               IF ((dat_ >= dat_Zm_ AND ABS (se_) > ROUND (sum_SK_ * k2_, 0)) OR
                   (dat_ < dat_Zm_ AND ABS (se_) > ROUND (sum_k_ * k2_, 0)))
                   and rgk_ >= 0
               THEN
                  nnnn1_ := nnnn1_ + 1;
                  kodp_ := '03' || LPAD (nnnn1_, 4, '0');

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk
                              )
                       VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                              );

                  -- ������������ 62 ���������� � 01.04.2006
                  IF flag_>0 AND dat_>=dat_Zm1_ AND ABS(se_)>ROUND(sum_sk_* k2_, 0) THEN
                     kodp_ := '62' || LPAD (nnnn1_, 4, '0');

                     INSERT INTO RNBU_TRACE
                                 (nls, kv, odate, kodp, znap, rnk) VALUES
                                 (nlsp_, 0, dat_, kodp_, znap_, rnk_);
                  END IF;

                  --si_ := ABS (se_);

                  IF dat_ >= dat_Zm_ THEN
                     BEGIN
                        SELECT  ABS (SUM (a.ost_eqv))
                           INTO se54_
                     FROM OTCN_F42_TEMP a, CUSTOMER c, OTCN_F42_PR o  --CUST_ACC ca,
                     WHERE a.ap=a.r012 AND
                           NOT EXISTS (SELECT 1
                                       FROM OTCN_F42_TEMP b
                                       WHERE  b.ap=b.r012        AND
                                              b.nbs IS NULL      AND
                                              b.ACCC = a.acc AND
                                              b.nls LIKE '3%') AND
                           a.rnk = c.rnk AND
                           DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=rnk_ AND
                           a.ddd=ddd_ AND
                           a.acc=o.acc AND
                           o.F42P54=1;
                     EXCEPTION
                         WHEN NO_DATA_FOUND THEN
                        se54_ := 0;
                     END;

                     IF ABS (NVL(se54_, 0)) > ROUND (sum_SK_ * k2_, 0) -- � 21.12.2005 ����������� 5% ���������� ���i���� �����
                     THEN
                        nnnn54_ := nnnn1_;
                        IF Dat_ < dat_Zm1_ OR flag_ = 0 THEN
                           kodp_ := '54' || LPAD (nnnn54_, 4, '0');
                        ELSE
                           -- � 01.04.2006
                           kodp_ := '62' || LPAD (nnnn54_, 4, '0');
                        END IF;

                        INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk )
                        VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_ );

                        -- ��������� � 18.01.2006
                        IF Dat_ < dat_Zm1_ OR flag_ = 0  THEN
                           kodp_ := '570000';
                        ELSE
                           -- � 01.04.2006
                           kodp_ := '630000';
                        END IF;

                        p57_  :=ABS (NVL(se54_, 0)) - ROUND (sum_SK_ * k2_, 0) ;

                        INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk )
                        VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_ );
                     END IF;

                     -- � 01.04.2006 ����������� 10% ��� 20% ���������� ���i���� �����
                     -- ������� �i� ������ ���������-������i������� �����i�
                     IF flag_>0 AND k3_ > 0 AND ABS (NVL(se54_, 0)) > ROUND (sum_SK_ * k3_, 0)
                     THEN
                        -- � 01.04.2006
                        kodp_ := '630000';

                        p57_  :=ABS (NVL(se54_, 0)) - ROUND (sum_SK_ * k3_, 0) ;

                        INSERT INTO RNBU_TRACE
                            (nls, kv, odate, kodp, znap, rnk )
                        VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_ );
                     END IF;
                  END IF;
               END IF;

               -- �������� 42
               ksum_ := ROUND (sum_SK_ * k2_, 0);

               IF ABS (se_) > ksum_ and rgk_ >= 0
               THEN
                  nnnn42_ := nnnn42_ + 1;
                  kodp_ := '42' || LPAD (nnnn42_, 4, '0');
                  znap_ := TO_CHAR (ABS (se_) - ksum_);

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk
                              )
                       VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_
                              );
               END IF;

               -- ����� ������������ ����� ����� ���, ������� �� ��������. ������� ABS(se_)>ROUND(sum_k_*0.05,0)
               IF ABS (se_) > si_
               THEN
                  rnki_     := rnk_;
                  znapi_ := znap_;
                  nlsi_ := nlsp_;
                  si_ := ABS (se_);
               END IF;
            END IF;
         END IF;
      ELSE
         dbms_output.put_line('RNK = '||to_char(rnk_)||' se='||to_char(se_));
         IF se_ <> 0
         THEN

            --- ������������ �����, ��� ������������� �� ������� ����� (��� 06)
            IF Dat_ < to_date('31032012','ddmmyyyy') 
            THEN

               IF ABS (se_) > ROUND (sum_k_ * 0.15, 0) and rgk_ >= 0
               THEN
                  nnnn2_ := nnnn2_ + 1;
                  kodp_ := '06' || LPAD (nnnn2_, 4, '0');
                  nlsu_ := 'RNK =' || TO_CHAR (rnk_);
                  znap_ := TO_CHAR (abs(se_));

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk
                              )
                       VALUES (nlsu_, 0, dat_, kodp_, znap_, rnk_
                              );

                  spp_ := se_;
               END IF;

               IF ABS (se_) < ROUND (sum_k_ * 0.15, 0) AND ABS (se_) >= spp_
               THEN
                  znapu_ := TO_CHAR (abs(se_));
                  nlsu_ := 'RNK =' || TO_CHAR (rnk_);
                  rnku_ := rnk_;
                  spp_ := se_;
               END IF;
            END IF;

            --- ������������ �����, ��� ������������� �� ������� ����� (��� 72)
            IF Dat_ > to_date('31032012','ddmmyyyy') 
            THEN

               IF ABS (se_) > ROUND (sum_SK_ * 0.15, 0) --and rgk_ >= 0
               THEN
                  if substr(kodp_,1,2) <> '06' then   
                     nnnn2_ := nnnn2_ + 1;
                  end if;

                  kodp_ := '72' || LPAD (nnnn2_, 4, '0');
                  nlsu_ := 'RNK =' || TO_CHAR (rnk_);
                  znap_ := TO_CHAR (abs(se_));

                  INSERT INTO RNBU_TRACE
                              (nls, kv, odate, kodp, znap, rnk, ref 
                              )
                       VALUES (nlsu_, 0, dat_, kodp_, znap_, rnk_, rnk_ 
                              );

                  spp_72 := se_;
               END IF;

               IF ABS (se_) < ROUND (sum_SK_ * 0.15, 0) AND ABS (se_) >= spp_72
               THEN
                  znapu_72 := TO_CHAR (abs(se_));
                  nlsu_72 := 'RNK =' || TO_CHAR (rnk_);
                  rnku_72 := rnk_;
                  spp_72 := se_;
               END IF;
            END IF;
         END IF;
      END IF;
   END LOOP;

   CLOSE saldo;
end if;
--------------------------------------------------------------------------
--------------------------------------------------------------------------
   IF TO_NUMBER (znapi_) > 0
   THEN
      kodpi_ := '03' || LPAD (TO_CHAR (nnnn1_ + 1), 4, '0');

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlsi_, 0, dat_, kodpi_, znapi_, rnki_
                  );
   END IF;

   IF TO_NUMBER (znapp_) > 0
   THEN
      kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0');

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlspp_, 0, dat_, kodpp_, znapp_, rnkp_
                  );
    --- 03.11.2008 - �� ��������� ������������ �� ����� ����������� ���������� 05 ��� ������������� ��������,
    --- ������� ������ 25%

      IF s_zalp_ >= 0 THEN
         kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0');

         INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlspp_, 0, dat_, kodpp_, to_char(s_zalp_), rnkp_
                  );
      END IF;

   END IF;

   --- 25.06.2011 - �� ��������� ������������ ��������� ���������� 01 ��� ������������� ��������,
   --- ������� ������ 25% � ��� ����������� 
   IF TO_NUMBER (znapp1_) > 0
   THEN
      kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0');

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk
                  )
           VALUES (nlspp1_, 0, dat_, kodpp_, znapp1_, rnkp1_
                  );

   --      kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0');

   --      INSERT INTO RNBU_TRACE
   --               (nls, kv, odate, kodp, znap, rnk
   --               )
   --        VALUES (nlspp1_, 0, dat_, kodpp_, '0', rnkp1_
   --               );
   END IF;

   --IF TO_NUMBER (znapu_) > 0
   --THEN
   --   kodpp_ := '060001';

   --   INSERT INTO RNBU_TRACE
   --               (nls, kv, odate, kodp, znap, rnk
   --               )
   --        VALUES (nlsu_, 0, dat_, kodpp_, znapu_, rnku_
   --               );
   --END IF;

   IF TO_NUMBER (znapu_72) > 0
   THEN
      kodpp_ := '720001';

      INSERT INTO RNBU_TRACE
                  (nls, kv, odate, kodp, znap, rnk, ref 
                  )
           VALUES (nlsu_72, 0, dat_, kodpp_, znapu_72, rnku_72, rnku_72 
                  );
   END IF;

   ---------------------------------------------------------------------------
   ------------------------------------------------------------------------------
    nnnn01_ := 0;
    rnk_ := 0;
    ddd_ := '00';

    for k in (select a.kodp, a.rnk, b.nnnn
              from rnbu_trace a, kl_f8b b
              where a.kodp like '01%' 
                and a.rnk = b.rnk 
              order by substr(a.kodp,1,2), to_number(a.znap) DESC, a.rnk )
    loop

       update rnbu_trace set
              kodp=substr(k.kodp,1,2) || k.nnnn
              where rnk=k.rnk and kodp=k.kodp;
        /*
        if ddd_='00' OR ddd_<>substr(k.kodp,1,2) OR rnk_=0 OR rnk_<>k.rnk then

           if substr(k.kodp,1,2)='01' then
              nnnn01_ := k.nnnn;  --nnnn01_+1;
              update rnbu_trace set
                 kodp=substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn01_), 4, '0')
              where rnk=k.rnk and kodp=k.kodp;
           else
              if substr(k.kodp,3,4)<>'0000' then

                 BEGIN
                    select to_number(substr(kodp,3,4)) into nnnn1_
                    from rnbu_trace
                    where rnk=k.rnk and
                    substr(kodp,1,2) in ('01','03') and
                    substr(kodp,1,2)<>substr(k.kodp,1,2) and
                    rownum=1 ;
                    if type_<>0 then
                       nnnn01_ := nnnn01_+1;
                       nnnn1_ := nnnn01_;
                    end if;
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    nnnn01_ := nnnn01_+1;
                    nnnn1_ := nnnn01_;
                 END;

                 update rnbu_trace set
                    kodp=substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn1_), 4, '0')
                 where rnk=k.rnk and kodp=k.kodp;
              end if;
           end if;

           rnk_:=k.rnk;
           ddd_:=substr(k.kodp,1,2);
        end if;
        */

    end loop;

   IF type_ = 0
   THEN

      DELETE FROM RNBU_TRACE 
            WHERE kodp NOT LIKE '01%';

      DELETE FROM TMP_NBU
            WHERE kodf = '8B' AND datf = dat_;

      OPEN basel;

      LOOP
         FETCH basel
          INTO kodp_, znap_;

         EXIT WHEN basel%NOTFOUND;

         INSERT INTO TMP_NBU
                     (kodf, datf, kodp, znap
                     )
              VALUES ('8B', dat_, kodp_, znap_
                     );
      END LOOP;

      CLOSE basel;
   END IF;

   -- ��� �����   ( 19.06.2014 )
   if mfo_ = 324805 then
      delete from tmp_nbu where kodf=kodf_ and datf = dat_;

      -- ��������� ������
      select sum(DECODE(substr(kodp,1,1),'1', znap, -znap)) 
         into s_nd
      from tmp_nbu 
      where kodf='C5' 
        and datf = dat_
        and ( (substr(kodp,2,4) like '14_8%' and substr(kodp,6,1) in ('3','9') ) or 
              (substr(kodp,2,4) like '3__8%' and substr(kodp,6,1) in ('4','8','C','E') ) or 
              (substr(kodp,2,4) like '4__8%' and substr(kodp,6,1) in ('4') ) or 
              (substr(kodp,2,4) like '20_8%' and substr(kodp,6,1) in ('4','6','8') ) or 
              (substr(kodp,2,4) like '21_8%' and substr(kodp,6,1) in ('6','8','A') ) or 
              (substr(kodp,2,4) in ('2208','2218','2228') and substr(kodp,6,1) in ('4') ) or 
              (substr(kodp,2,4) in ('2238') and substr(kodp,6,1) in ('4','6','9') ) or 
              (substr(kodp,2,4) in ('2607','2627','2657') and substr(kodp,6,1) in ('4') ) or               
              (substr(kodp,2,4) in ('3570','3578') and substr(kodp,6,1) in ('4') ) 
            ) ;

      -- ������
      select sum(znap) 
         into s_rez
      from tmp_nbu 
      where kodf='C5' 
        and datf = dat_
        and ( substr(kodp,2,5) in ('14905','14915','3190B','31915',
                                   '32905','32915','14925','14935',
                                   '24005','24015','35995' )
            ) ;

      -- ����������� ��������� ������
      select sum(decode(substr(FIELD_CODE,1,2),'10', FIELD_VALUE, -FIELD_VALUE)) 
         into s_pnd
      from V_NBUR_#01
      where REPORT_DATE = dat_
        and substr(FIELD_CODE,1,2) in ('10','20') 
        and substr(FIELD_CODE,3,4) in ('1419','1429','3119','3219',
                                   '2029','2039','2069','2079','2089',
                                   '2109','2119','2129','2139',
                                   '2209','2219','2229','2239',
                                   '3579' );
                                      
      if Dat_ >= to_date('09032016','ddmmyyyy') and 
         Dat_ <= to_date('10052016','ddmmyyyy')
      then
         insert into tmp_nbu (kodf, datf, kodp, znap)
                      values ('8B', dat_, '970000', '0');
      else 
         insert into tmp_nbu (kodf, datf, kodp, znap)
                      values ('8B', dat_, '970000',to_char(s_nd + s_pnd - s_rez));
      end if; 
   end if;

   commit;
END P_F8b_Nn;
/
show err;

PROMPT *** Create  grants  P_F8B_NN ***
grant EXECUTE                                                                on P_F8B_NN        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F8B_NN        to RPBN002;
grant EXECUTE                                                                on P_F8B_NN        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F8B_NN.sql =========*** End *** 
PROMPT ===================================================================================== 
