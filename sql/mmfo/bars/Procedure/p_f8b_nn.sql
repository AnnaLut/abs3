

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
% VERSION     :  03/01/2018 (26/10/2017)
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
   kodp1_      VARCHAR2 (10);
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
   fl_tp_5    number;
   fl_tp_6    number;
   fl_tp_7    number;
   rgk_       number;
   s180_      Varchar2(1);
   s240_      Varchar2(1);
   p240r_     Varchar2(1);
   vost_      number;
   poisk_     Varchar2(1000);
   sum_proc_  number;
   sum_kor_   number;   
   
   sql_acc_   clob;
   ret_       number;
   pr_f8b_    number;

   ---������� ��� 01, 02, 03, 04, 06
   CURSOR saldo  IS
    select ddd, rnk, prins, sum(znap) znap, sum(tp_1) tp_1, sum(tp_2) tp_2, 
                            sum(tp_3) tp_3, sum(tp_4) tp_4, sum(tp_5) tp_5, 
                            sum(tp_6) tp_6, sum(tp_7) tp_7,
           sum(sum_proc) sum_proc, 
           sum(sum_kor) sum_kor 
    from (
        select a.ddd, a.rnk, a.prins, a.znap, a.tp_1, a.tp_2, a.tp_3, 
               a.tp_4, a.tp_5, a.tp_6, a.tp_7, nvl(o.sum_proc, 0) sum_proc, 
            znap - a.tp_7 - (case when tp_6 > 0 then tp_6 else 0 end) -
            (case when a.prins = 1 then 0 else 
                (case when tp_1 > 0 then tp_1 else 0 end) - 
                (case when tp_2 > 0 then tp_2 else 0 end) - 
                (case when tp_3 > 0 then tp_3 else 0 end) - 
                (case when tp_4 > 0 then tp_4 else 0 end) -
                (case when tp_5 > 0 then tp_5 else 0 end)
             end) + 
            nvl(o.sum_proc, 0) sum_kor
        from (
           SELECT  a.ddd, NVL(d.link_group, c.rnk) rnk,  
                   DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1) prins,
                   NVL(ABS (SUM (a.ost_eqv)), 0) znap,
                   ABS (NVL (sum((case when a.r020 IN ('1502') and NVL (p.r013, '0') NOT IN ('1', '2', '9') or
                                            a.r020 IN ('1524') and NVL (p.r013, '0') NOT IN ('1', '3') 
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_1,
                   ABS (NVL (sum((case when a.r020 IN ('3003', '3005', '3007', '3010', '3011', '3015') AND NVL (p.r013, '0' ) NOT IN ('9') or
                                            a.r020 IN ('3006', '3106') AND NVL (p.r013, '0' ) NOT IN ('1') or
                                            a.r020 IN ('3012', '3014', '3040') AND NVL (p.r013, '0' ) NOT IN ('7', '9') or
                                            a.r020 IN ('3013') AND NVL (p.r013, '0') NOT IN ('5','6','9','A','B','C') or
                                            a.r020 IN ('3103', '3105', '3107') AND NVL (p.r013, '0') NOT IN ('1', '9')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_2,
                   ABS (NVL (sum((case when a.r020 = '3212' AND NVL (p.r013, '0') not in ('2', '3')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_3,
                   ABS (NVL (sum((case when a.r020 = '3540' and NVL (p.r013, '0') not in ('4','5','6','7')
                                    then a.ost_eqv
                                    else 0
                                  end)),0)) tp_4,
                                    0 tp_5,
                   ABS (NVL (sum((case when a.r020 IN ('9500') and NVL (p.r013, '0') = 3
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_6,
                   ABS (NVL (sum((case when a.r020 IN ('9129') and NVL (p.r013, '0') NOT IN ('0', '1')
                                    then a.ost_eqv
                                    else 0
                                   end)),0)) tp_7
           FROM OTCN_F42_TEMP a
           left outer join specparam p
           on (a.acc = p.acc)
           join CUSTOMER c
           on (a.rnk = c.rnk)
           left outer join d8_cust_link_groups d  
           on (trim(c.okpo) = trim(d.okpo))                     
           WHERE a.ap=a.r012 AND
                 NOT exists (SELECT 1
                             FROM OTCN_F42_TEMP b
                             WHERE  b.ap=b.r012        AND
                                    b.nbs IS NULL      AND
                                    b.ACCC = a.acc )   AND
                 ( ((our_rnk_ = -1 or c.rnk <> our_rnk_) and mfo_ <> 344443) or 
                            (c.rnk <> 0 and mfo_ = 344443) ) AND
                 (our_okpo_ = '0' or NVL(ltrim(c.okpo, '0'),'X') <> our_okpo_ or a.ddd='006' and (a.nls like '3%' or a.nls like '4%')) AND
                 (prnk_ IS NULL OR c.rnk = prnk_) /*and
                  (trim(c.okpo) in (select trim(okpo) from kl_f8b where trim(okpo) is not null) or
                  a.ddd='006' and (nls like '3%' or nls like '4%')) */
           GROUP BY a.ddd, NVL(d.link_group, c.rnk),  
                    DECODE (c.PRINSIDER, NULL, 2, 0, 2, 99, 2, 1)) a
       left outer join
       (select NVL(d.link_group, c.rnk) rnk, NVL(-1*sum(znap), 0) sum_proc
          from otc_c5_proc o
          join customer c
          on (c.rnk = o.rnk)
          left outer join d8_cust_link_groups d  
          on (trim(c.okpo) = trim(d.okpo))                     
          where o.datf = dat_
            and o.nls not like '3570%' 
          group by NVL(d.link_group, c.rnk)
        ) o
       on (a.rnk = o.rnk)
    ) s
    group by  s.ddd, s.rnk, s.prins
    order by ddd, abs(to_number(sum_kor)) desc;

---�������  ����  "47-51"
   CURSOR saldoost3 IS
        SELECT ACC, NLS, KV, FDAT, DDD, R012, ACCC, OST_EQV
        from OTCN_F42_TEMP
        where ap=0;
-------------------------------------------------------------------------
   CURSOR basel IS
      SELECT   kodp, abs(SUM (to_number(znap)))
      FROM RNBU_TRACE
      WHERE kodp like '01%' 
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
            --AND trim(c.okpo) not in (select trim(okpo) from kl_f8b where trim(okpo) is not null)
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

       sql_acc_ := 'SELECT r020 FROM KL_F3_29 WHERE kf = ''42'' AND ddd IN (''001'', ''006'') ';

       ret_ := F_Pop_Otcn(Dat_, 1, sql_acc_);

       if prnk_ IS NULL then
          INSERT INTO OTCN_F42_TEMP(ACC, KV, FDAT, NBS, NLS, OST_NOM, OST_EQV,
                                     AP, R012, DDD, R020, ACCC, ZAL, RNK)
           SELECT a.acc, a.kv, a.FDAT, a.nbs, a.nls,
                  a.ost_nom, a.ost_eqv,
                  DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012,
                  a.ddd, a.r020, a.accc, 0, a.rnk
           FROM (SELECT /*+ PARALLEL(8) use_hash(s a)  */
                        s.acc, s.nls, s.kv, s.FDAT, s.nbs,
                        s.ost ost_nom, decode(s.kv, 980, s.ost, s.ostq) ost_eqv, a.accc, 
                        s.rnk, k.r012, k.ddd, k.r020
                 FROM OTCN_SALDO s, otcn_acc a, KL_F3_29 k, customer r
                 WHERE s.acc = a.acc
                   and k.kf='42'
                   and k.ddd IN ('001', '006')
                   and a.nls LIKE k.r020||'%'
                   and (a.nbs is null or substr(a.nls,1,4)=a.nbs )
                   and a.rnk = r.rnk ) a
            where a.ost_nom<>0;
       else
          INSERT INTO OTCN_F42_TEMP(ACC, KV, FDAT, NBS, NLS, OST_NOM, OST_EQV,
                                     AP, R012, DDD, R020, ACCC, ZAL, RNK)
           SELECT a.acc, a.kv, a.FDAT, a.nbs, a.nls,
                  a.ost_nom, a.ost_eqv,
                  DECODE(SIGN(a.ost_nom),-1, 1, 2) ap, a.r012,
                  a.ddd, a.r020, a.accc, 0, a.rnk
           FROM (SELECT s.acc, s.nls, s.kv, s.FDAT, s.nbs,
                        s.ost ost_nom, decode(s.kv, 980, s.ost, s.ostq) ost_eqv, a.accc, 
                        s.rnk, k.r012, k.ddd, k.r020
                 FROM OTCN_SALDO s, otcn_acc a, KL_F3_29 k, customer r
                 WHERE s.acc = a.acc
                   and k.kf='42'
                   and k.ddd IN ('001', '006')
                   and s.nls LIKE k.r020||'%'
                   and (s.nbs is null or substr(s.nls,1,4)=s.nbs )
                   and a.rnk = r.rnk 
                   and DECODE (r.rnkp, NULL, r.rnk, r.rnkp)=prnk_) a
            where a.ost_nom<>0;
       end if;

       commit;

       -- ������������ ����� 01, 02, 03, 04
       OPEN saldo;

    LOOP
      FETCH saldo
       INTO ddd_, rnk_, insider_, se_, fl_tp_1, fl_tp_2, fl_tp_3, fl_tp_4, 
                           fl_tp_5, fl_tp_6, fl_tp_7, sum_proc_, sum_kor_ ;

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
                se_ := se_ - fl_tp_7;  -- ���������� 9129 (9)
                
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

                --- �������� �������� ����� (�������� R013 ������ ������������ ��������) 3540 R013 in (4,5,6)'
                if fl_tp_4 > 0 then
                   s05_ := fl_tp_4;
                end if;

                if fl_tp_5 > 0 then
                   s05_ := s05_ - fl_tp_5;
                end if;

                -- 01.07.2014 ��� ��������� �� �������� ����������� ��� ������� 
                -- ���������� ���
                IF insider_ <> 1 
                THEN
                   se_ := se_ - s02_ - s03_ - s04_ - s05_;
                end if;

                --- �������� �������� ����� (�������� R013 ������ ������������ ��������) �� 9500
                if fl_tp_6 > 0 then
                   se_ := se_ - fl_tp_6;
                end if;
                
                --- ������� ����� �������� ������ �� ������������� ������ ���������� R013
                if sum_proc_ <> 0 then
                   se_ := se_ + sum_proc_;
                   
                   if se_ < 0 then
                      se_ := 0;
                   end if;
                end if;

                nlsp_ := 'RNK =' || TO_CHAR (rnk_);
                znap_ := TO_CHAR (ABS (se_));
                s_zal_:= 0;
                
                if mfo_ = 300465 then
                   pr_f8b_ := 0;
                else
                    SELECT COUNT (*)
                      INTO pr_f8b_
                    FROM KL_F8B
                    WHERE nvl(link_group, rnk) = rnk_;
                end if;
     
                IF (ABS (se_) > ROUND (sum_k_ * k1_, 0) or pr_f8b_ = 1) and 
                   rgk_ >= 0 and s_prizn_=0
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
                           rnk in ( select c.rnk 
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo) 
                                      and d.link_group = rnk_
                                    union 
                                    select c.rnk 
                                    from customer c 
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_ 
                                  ); 
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
                           rnk in ( select c.rnk 
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo) 
                                      and d.link_group = rnk_
                                    union 
                                    select c.rnk 
                                    from customer c 
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_ 
                                  ); 
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
                           rnk in ( select c.rnk 
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo) 
                                      and d.link_group = rnk_
                                    union 
                                    select c.rnk 
                                    from customer c 
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_ 
                                  ); 
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
                           rnk in ( select c.rnk 
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo) 
                                      and d.link_group = rnk_
                                    union 
                                    select c.rnk 
                                    from customer c 
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_ 
                                  ); 
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
                           rnk in ( select c.rnk 
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo) 
                                      and d.link_group = rnk_
                                    union 
                                    select c.rnk 
                                    from customer c 
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_ 
                                  ); 
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
                           rnk in ( select c.rnk 
                                    from d8_cust_link_groups d, customer c
                                    where trim(d.okpo) = trim(c.okpo) 
                                      and d.link_group = rnk_
                                    union 
                                    select c.rnk 
                                    from customer c 
                                    where trim(c.okpo) not in ( select trim(d.okpo)
                                                                from d8_cust_link_groups d
                                                              )
                                      and c.rnk = rnk_ 
                                  ); 
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

   for k in ( select * from rnbu_trace 
              where (kodp like '01%' or kodp like '02%')
              order by substr(kodp,3,4), substr(nls,6,9)
            )
   loop
      kodp_ := (case when k.kodp like '01%' then 'R1' else 'R2' end)||substr(k.kodp,3);
      kodp1_ := k.kodp;

      insert into rnbu_trace (odate, nls, kv, kodp, znap, rnk, nd, ref, acc, comm)
      select dat_ odate, a.nls, a.kv, kodp_ kodp, 
             a.ost_eqv znap, a.rnk, n.nd, a.acc,
             to_number(substr(k.nls,6,9)), '����������� �� OTCN_F42_TEMP' comm
      from otcn_f42_temp a
      left outer join specparam p 
      on (a.acc = p.acc)
      join customer c
      on (a.rnk = c.rnk)
      left outer join d8_cust_link_groups d  
      on (trim(c.okpo) = trim(d.okpo))   
      left outer join (select n.acc, max(n.nd) nd
                       from nd_acc n, cc_deal e
                       WHERE e.sdate <= dat_
                         AND e.nd = n.nd
                       group by n.acc ) n
      on (a.acc = n.acc)               
      where NVL(d.link_group, c.rnk) = k.rnk
          AND a.ap = a.r012
          AND ((a.nbs = '9129' and NVL(p.r013,'9') = '1') or a.nbs <> '9129')
          AND NOT exists (SELECT 1
                          FROM OTCN_F42_TEMP b
                          WHERE  b.ap=b.r012        AND
                                 b.nbs IS NULL      AND
                                 b.ACCC = a.acc );
      
      insert into rnbu_trace (odate, nls, kv, kodp, znap, rnk, nd, ref, acc, comm)
      select dat_ odate, o.nls, o.kv, kodp_ kodp, 
             (case when abs(NVL(o.znap, 0)) >= abs(t.ost_eqv) then 0 else NVL(o.znap, 0) end) znap, 
             o.rnk, o.nd, o.acc,
             to_number(substr(k.nls,6,9)) ref,  
             decode( substr(o.kodp,2,4), '2400', '(������ ��� ������ �� #C5) ',
                                         '2401', '(������ ��� ������ �� #C5) ',
                                         '3590', '(������ ��� ������ �� #C5) ',
                                         '3599', '(������ ��� ������ �� #C5) ',
                                         '3690', '(������ ��� ������ �� #C5) ',
                                         '(���� �� ����� #C5) ' 
                   ) || substr(o.kodp,2,4) || '/' || substr(o.kodp,6,1) comm 
      from otc_c5_proc o
      join customer c
      on (o.rnk = c.rnk)
      left outer join d8_cust_link_groups d  
      on (trim(c.okpo) = trim(d.okpo))                     
      left outer join otcn_f42_temp t
      on (o.acc = t.acc)  
      where o.datf = dat_ 
        and o.nls not like '3570%'
        and NVL(d.link_group, c.rnk) = k.rnk;
   end loop;
   
   delete  from rnbu_trace where kodp like '01%' or kodp like '02%';
   update rnbu_trace 
   set kodp = replace(kodp, 'R', '0')
   where kodp like 'R1%' or kodp like 'R2%';

   for k in (select a.kodp, a.rnk, b.nnnn
             from rnbu_trace a, kl_f8b b
             where a.kodp like '01%' 
               and a.acc = nvl(b.link_group, b.rnk) 
             order by substr(a.kodp,1,2), to_number(a.znap) DESC, a.rnk )
   loop
      update rnbu_trace 
      set kodp=substr(k.kodp,1,2) || k.nnnn
      where rnk=k.rnk and kodp=k.kodp;
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
        
      if dat_ < to_date('27122017', 'ddmmyyyy') then
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
      else
          -- ��������� ������
          select sum(DECODE(substr(kodp,1,1),'1', znap, -znap)) 
             into s_nd
          from tmp_nbu 
          where kodf='C5' 
            and datf = dat_
            and ( (substr(kodp,2,4) like '14_8' and substr(kodp,6,1) in ('5','9','B') ) or 
                  (substr(kodp,2,4) in ('1508') and substr(kodp,6,1) in ('1','2','3','4','5','6') ) or
                  (substr(kodp,2,4) in ('1518') and substr(kodp,6,1) in ('1','2') ) or
                  (substr(kodp,2,4) in ('1528','2048','2248','2438','2458') and substr(kodp,6,1) in ('1','2','3','4','5','6') ) or 
                  (substr(kodp,2,4) in ('1538','1548') and substr(kodp,6,1) in ('1','2','3','4') ) or
                  (substr(kodp,2,4) in ('1607','2607','2627','2657') ) and substr(kodp,1,1) = '1' or
                  (substr(kodp,2,4) in ('2018','2088','2118','2138','2328','2338','2348','2408','2418','2428','3570','3578') and substr(kodp,6,1) in ('1','2') ) or
                  (substr(kodp,2,4) in ('2028','2038','2078','2208','2218','2228') and substr(kodp,6,1) in ('1') ) or 
                  (substr(kodp,2,4) in ('2068','2108','2128','2238','2318') and substr(kodp,6,1) in ('1','2','3') ) or
                  (substr(kodp,2,4) in ('2148','2388') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8','9','A') ) or 
                  (substr(kodp,2,4) in ('2308','2358') and substr(kodp,6,1) in ('1','2','3','4') ) or
                  (substr(kodp,2,4) in ('2368') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8','9','A','B','C') ) or
                  (substr(kodp,2,4) in ('2378') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8') ) or 
                  (substr(kodp,2,4) in ('2398') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8','9') ) or 
                  (substr(kodp,2,4) in ('3008') and substr(kodp,6,1) in ('6','B') ) or
                  (substr(kodp,2,4) in ('3018') and substr(kodp,6,1) in ('5','9','B','E','F','O') ) or
                  (substr(kodp,2,4) in ('3108') and substr(kodp,6,1) in ('2','5','6','9') ) or 
                  (substr(kodp,2,4) in ('3118') and substr(kodp,6,1) in ('5','7','B','E','F','L') ) or
                  (substr(kodp,2,4) in ('3218') and substr(kodp,6,1) in ('2','3','6','9','A','C') ) or
                  (substr(kodp,2,4) in ('3568') and substr(kodp,6,1) in ('1','3') ) 
                ) 
            and substr(kodp,7,1) = '3';

          -- ������
          select sum(znap) 
             into s_rez
          from tmp_nbu 
          where kodf='C5' 
            and datf = dat_
            and ( (substr(kodp,1,5) in ('21419','21429') and substr(kodp,6,1) in ('5','9','B') ) or 
                  (substr(kodp,1,5) in ('21509','21529','22249') and substr(kodp,6,1) in ('1','2','3','4','5','6') ) or
                  (substr(kodp,1,5) in ('21519','22019','22089','22119','22139','22329','22239','22249') and substr(kodp,6,1) in ('1','2') ) or
                  (substr(kodp,1,5) in ('21549') and substr(kodp,6,1) in ('1','2','3','4') ) or
                  (substr(kodp,1,5) in ('21609') ) and substr(kodp,6,1) = '3' or
                  (substr(kodp,1,5) in ('22029','22039','22079','22209','22219','22229','23599') ) and substr(kodp,6,1) = '1' or
                  (substr(kodp,1,5) in ('22049') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8','9') ) or 
                  (substr(kodp,1,5) in ('22069','22109','22129','22239','22319') and substr(kodp,6,1) in ('1','2','3') ) or
                  (substr(kodp,1,5) in ('22149','22389') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8','9','A') ) or 
                  (substr(kodp,1,5) in ('22309','22359') and substr(kodp,6,1) in ('1','2','3','4') ) or
                  (substr(kodp,1,5) in ('22369') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8','9','A','B','C') ) or
                  (substr(kodp,1,5) in ('22379') and substr(kodp,6,1) in ('1','2','3','4','5','6','7','8') ) or 
                  (substr(kodp,1,5) in ('22409','22419','22429') and substr(kodp,6,1) in ('1','2') ) or
                  (substr(kodp,1,5) in ('22439') and substr(kodp,6,1) in ('1','2','3','4','5','6') ) or 
                  (substr(kodp,1,5) in ('22609','22629','22659') ) or
                  (substr(kodp,1,5) in ('23119') and substr(kodp,6,1) in ('5','7','B','E','F','L') ) or
                  (substr(kodp,1,5) in ('23219') and substr(kodp,6,1) in ('2','3','6','9','A','C') ) or
                  (substr(kodp,1,5) in ('23569') and substr(kodp,6,1) in ('1','3') ) 
                ) 
                and substr(kodp,7,1) = '3';
                
           s_pnd := 0;
      end if;                                           
                                      
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
