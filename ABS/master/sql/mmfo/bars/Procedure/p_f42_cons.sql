

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_F42_CONS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_F42_CONS ***

CREATE OR REPLACE PROCEDURE BARS.P_F42_CONS (dat_ DATE,  
                                             pkodf_    varchar2 default '#42', 
                                             type_ NUMBER DEFAULT 0,
                                             prnk_ NUMBER DEFAULT NULL,
                                             pmode_ number default 0)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  ��������� ���������� �������������� #42 ��� ��
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.All Rights Reserved.
% VERSION     : 15/02/2019 (18/01/2019)
%------------------------------------------------------------------------
% 17/01/2019 - �� ��������� 01, 02, 04 ��������� ����� �����������
%              � ���� ALT_BIC=('8260000013', '8400000053', '8400000054')
%              � � ���� ������� 'BBB', 'BBB+','BBB-','Baa1','Baa2','Baa3'
%              ��� ���������� �� 'A', 'T', 'F' 
%              � ��� ���� ���������� ������ ���.�������
%              ��������� ���������� ��������� B400000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   dat_Zm_    DATE := TO_DATE('21122005','ddmmyyyy'); -- ��������� � �i� ��i�� ��i��� ��������� ��� �24-622/212 �i� 30.11.2005
   dat_Zm1_   DATE := TO_DATE('01042006','ddmmyyyy'); -- ���������� ���i ��������� 61NNNN, 62NNNN, 630000
   dat_Zm2_   DATE := TO_DATE('19112009','ddmmyyyy'); -- ��������� ����� �������� 71NNNN
   dat_Zm3_   DATE := TO_DATE('19072010','ddmmyyyy'); -- ��������� ����� �������� 82NNNN
   dat_Zm4_   DATE := TO_DATE('24042015','ddmmyyyy'); -- ���������� ���_ ���������
                                                      -- 98NNNNVVV, 99NNNNVVV _ ����
                                                      -- ��������� ���������
   dat_Zm5_   DATE := TO_DATE('15062015','ddmmyyyy'); -- �� ������ ����������� ��������� 03NNNN000
                                                      --  41NNNN000,42NNNN000,43NNNN000,62NNNN000,
                                                      --  65NNNN000,66NNNN000,94NNNN000,96NNNN000
   dat_Zm6_   DATE := TO_DATE('12112015','ddmmyyyy'); -- ���������� ���_ ���������
                                                      -- A00000000, A10000000, A20000000
   dat_Zm7_   DATE := TO_DATE('02082018','ddmmyyyy'); -- ��������� ����� ��������
                                                      -- A90000000 

   datz_      date := Dat_Next_U(dat_, 1);
   pr_bank    VARCHAR2 (1);
   k041_      VARCHAR2 (1);
   k042_      VARCHAR2 (1);
   kodf_      VARCHAR2 (2):= '42';
   kf1_       VARCHAR2 (2):= '01';
   nls_       VARCHAR2 (15);
   nlsp_      VARCHAR2 (15);
   nlsi_      VARCHAR2 (15);
   nlsi1_     VARCHAR2 (15);
   nlspp_     VARCHAR2 (15);
   comm_pp_   VARCHAR2 (255);
   nlspp1_    VARCHAR2 (15);
   comm_pp1_  VARCHAR2 (255);
   nlsu_      VARCHAR2 (15);
   nlsu_72    VARCHAR2 (15);
   data_      DATE;
   dat1_      DATE;
   ddd_       VARCHAR2 (3);
   r012_      VARCHAR2 (1);
   r013_      VARCHAR2 (1);
   r011_      VARCHAR2 (1);   
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
   si1_       DECIMAL (24)   := 0;
   s02_       DECIMAL (24)   := 0;
   s03_       DECIMAL (24)   := 0;
   s04_       DECIMAL (24)   := 0;
   s05_       DECIMAL (24)   := 0;
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
   znapi1_    DECIMAL (24)   := 0;
   znapu_     DECIMAL (24)   := 0;
   znapu_72   DECIMAL (24)   := 0;
   mfo_       NUMBER;
   mfou_      NUMBER;
   rnk_       NUMBER;
   nmk_       Varchar2(70);
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
   nnnn00_    NUMBER         := 0;
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
   s_zali_    NUMBER := 0;
   prizn_     NUMBER;
   s_prizn_   NUMBER;
   fmt_       VARCHAR2(30):='999G999G999G990D99';
   p57_       NUMBER;
   p47_       NUMBER:=0;
   p71_       NUMBER:=0;
   ostc_      NUMBER:=0;
   p51_       NUMBER:=0;
   rnki_      NUMBER;
   rnki1_     NUMBER;
   rnku_      NUMBER;
   rnku_72    NUMBER;
   rnkp_      NUMBER;
   rnkp1_     NUMBER;
   vNKA_      NUMBER;
   sz_all_    number;
   sk_all_    number;
   sz0_       number;
   sz1_       number;
   rez_1      number;
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
   sql_acc_   clob;
   ret_       number;
   comm_      Varchar2(200);
   sum_proc_  number;
   sum_kor_   number;
   cnt_       number;
   pr_f8b_    number;

   link_code_     d8_cust_link_groups.link_code%type;
   link_codepp_   d8_cust_link_groups.link_code%type;
   link_codep1_   d8_cust_link_groups.link_code%type;

   link_name_     d8_cust_link_groups.groupname%type;

   ---������� ��� 01, 02, 03, 04, 06
   CURSOR saldo  IS
   select ddd, rnk, link_code, link_name, prins, znap
   from (select '001' ddd,
                NVL(o.link_group, o.rnk) rnk,
                o.link_code,
                o.link_name,
                o.fl_prins prins,
                abs(sum(decode(substr(o.kodp, 1, 1), '1', -1, 1)*o.znap)) znap
        from otc_c5_proc o
        where o.datf = dat_
        group by NVL(o.link_group, o.rnk),
                o.link_code,
                o.link_name,
                o.fl_prins
        having sum(decode(substr(o.kodp, 1, 1), '1', -1, 1)*o.znap)<0)
    where rnk <> 90092301 and (prins = 1 or znap >= ROUND (sum_k_ * 0.1, 0)) 
            union all
    select ddd, rnk, link_code, link_name, prins, sum(znap) znap
    from (
        select a.ddd, a.rnk, a.link_code, a.link_name, a.prins, a.znap
        from (
           SELECT  a.ddd, a.link_group as rnk, a.link_code, a.link_name,
                   a.fl_prins as prins, NVL(ABS (SUM (a.ost_eqv)), 0) znap
           FROM NBUR_TMP_42_DATA a
           WHERE a.report_date = dat_ and
                 a.ddd='006'
           GROUP BY a.ddd, a.link_group, a.link_code, a.link_name,
                    a.fl_prins) a
    ) s
    where s.rnk <> 90092301 
    group by  s.ddd, s.rnk, s.link_code, s.link_name, s.prins
    order by ddd, znap desc;

   CURSOR saldoost1 IS
   select b.acc, b.nbs, b.nls, b.kv, b.report_date as fdat, b.rnk, b.ost_eqv as ostq, b.ddd
   from NBUR_TMP_42_DATA b
   where report_date = dat_ and 
        ddd = '0A0';

---------------------------------------------------------------------------
---�������  ����  "73","74","75","76","77","78","79","80","81"
   CURSOR saldoost7 IS
   select b.acc, b.nls, b.kv, b.fdat, b.r013, b.s240, b.rnk,
          nvl(d.k042, '9') k042, b.ostq, nvl(c.ddd, '099'),
          nvl(e.mfo, '000000'), nvl(e.reestr, 'X')
   from (SELECT /*+ PARALLEL(8) */
                a.acc, a.nbs, a.nls, a.kv, a.FDAT,
                NVL (p.r013, '0') r013, NVL(p.s240, '1') s240,
                DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
                NVL(lpad(to_char(c.country),3,'0'),'804') k040,
                sum(decode(a.kv, 980, a.ost, a.ostq)) ostq
          FROM OTCN_SALDO a, CUSTOMER c, SPECPARAM p
          WHERE a.ost <> 0
            and a.rnk=c.rnk
            AND a.acc = p.acc(+)
            AND (prnk_ IS NULL OR DECODE (c.rnkp, NULL, c.rnk, c.rnkp)=prnk_)
          GROUP BY a.acc, a.nbs, a.nls, a.kv, a.FDAT, NVL (p.r013, '0'), NVL(p.s240, '1'),
                   DECODE (c.rnkp, NULL, c.rnk, c.rnkp),
                   NVL(lpad(to_char(c.country),3,'0'),'804')) b
   left outer join
       (SELECT ddd, r020
        FROM KL_F3_29
        WHERE kf = '42'
          AND ddd IN ('073', '076')) c
    on (b.nbs = c.r020)
    left outer join
        (select k040, k042
         from kl_k040) d
    on (b.k040 = d.k040)
    left outer join
        (select a.rnk, a.mfo, b.reestr
         from custbank a, rcukru b
         where a.mfo=b.mfo) e
    on (b.rnk = e.rnk);

---------------------------------------------------------------------------
---�������  ����  "47-51"
   CURSOR saldoost3 IS
        SELECT ACC, NLS, KV, FDAT, DDD, R012, ACCC, OST_EQV
        from OTCN_F42_TEMP
        where ap=0;

---------------------------------------------------------------------------
---�������  ����  "82", "83", "84"
   CURSOR saldoost8 IS
       SELECT a.acc, a.nls, a.kv, a.FDAT, NVL (p.r013, '0'), NVL(p.s180, '1'),
              DECODE (c.rnkp, NULL, c.rnk, c.rnkp) rnk,
              SUM ((case when a.kv = 980 then ost else gl.p_icurval(a.kv, a.ost, dat_zm3_) end))
      FROM (SELECT /*+ PARALLEL(8) */
                   s.acc, s.rnk, s.nls, s.kv, s.FDAT, s.nbs,
                   s.ost, (case when kv = 980 then s.ost else s.ostq end) ostq
            FROM OTCN_SALDO s
            WHERE s.ost <> 0) a, CUSTOMER c, SPECPARAM p
      WHERE a.rnk=c.rnk
        AND a.acc = p.acc(+)
      GROUP BY a.acc, a.nls, a.kv, a.FDAT,
               NVL (p.r013, '0'), NVL(p.s180,'1'),
               DECODE (c.rnkp, NULL, c.rnk, c.rnkp);
BEGIN
-------------------------------------------------------------------
   commit;

   execute immediate('alter session set nls_numeric_characters=''.,''');

   userid_ := user_id;

   logger.info ('P_F42_CONS: Begin ');

   EXECUTE IMMEDIATE 'truncate table RNBU_TRACE';

   EXECUTE IMMEDIATE 'truncate table otcn_f42_temp';
   EXECUTE IMMEDIATE 'truncate table otcn_f42_zalog';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE otcn_fa7_temp';
   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_KOD_R020';
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

   INSERT INTO otcn_fa7_temp
      SELECT r020
        FROM kl_r020
       WHERE trim(prem) = '��'
         AND LOWER (txt) LIKE '%����������_ �����%�����%'
         AND t020 = '1';

   -- ��� ����� (0 - ��_����������, 1 - ����_��_������� �������)
   flag_ := F_Get_Params ('NORM_TPB', 0);

   -- �_������ ��������� ������_������� �����_� � �_����_��_� ����_ �����_�
   IF flag_ > 0 THEN
         vNKA_ := F_Get_Params ('NOR_NKA', 0);
   ELSE  -- ��� ��_����������� ����� �� �� ��������
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

   -- ���� ������������� ���i���� ����� 
   rgk_ := Rkapital (dat_next_u(dat_, 1), kodf_, userid_, 1); -- ��_�� 27.12.2005 - ��� ���������� ��������_� ��������������� ���_������������ ���_���

   if rgk_ <= 0 then
      sum_k_ := 100;
      s_prizn_ := 1; -- ��� �� ���������� �������� 41
   else
      sum_k_ := rgk_;
   end if;

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

-- ������_� ������� ���� ��_����� ���_���
   SELECT MAX (FDAT)
      INTO pdat_
   FROM FDAT
   WHERE FDAT <= dat_;
   
   if f_nbur_check_for_42_cons(dat_, pkodf_) then
      bc.home;

    ---------------------------------------------------------------------------
       -- ������������ ����� 01, 02, 03, 04
       OPEN saldo;

       LOOP
          FETCH saldo
           INTO ddd_, rnk_, link_code_, link_name_, insider_, se_;

          EXIT WHEN saldo%NOTFOUND;

          comm_ := (case when link_code_ = '000' then '' else link_name_ end);
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

             pr_f8b_ := 0;

             if link_code_ <> '000' then
                 SELECT COUNT (*)
                    INTO pr_f8b_
                 FROM KL_F8B
                 WHERE nvl(link_group, rnk) = rnk_;
             end if;

             if rnk_ = 90092301 then
                pr_f8b_ := 1;
             end if;

             IF se_ <> 0 AND f42_ = 0
             THEN
                if se_ <> 0 then
                    nlsp_ := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
                    znap_ := TO_CHAR (ABS (se_));
                    s_zal_:= 0;

                    if rnk_ <> 90092301 then
                       nnnn00_ := nnnn00_ + 1;
                    end if;
                    
                    begin
                        select nvl(abs(sum(ost_eqv)), 0)
                        into p47_
                        from NBUR_TMP_42_DATA
                        where report_date = dat_ and
                              ddd like '47%' and
                              nvl(link_group, rnk) = rnk_; 
                    exception
                        when no_data_found then
                           p47_ := 0;
                    end;

                    begin
                        select nvl(abs(sum(ost_eqv)), 0)
                        into p51_
                        from NBUR_TMP_42_DATA
                        where report_date = dat_ and
                              ddd like '51%' and
                              nvl(link_group, rnk) = rnk_; 
                    exception
                        when no_data_found then
                           p51_ := 0;
                    end;
                    
                    -- 22/11/2016 �� ����� �������� ������������
                    -- ������� ��������� 25% �� �� � ������� ����� ���������� � ���� #8B
                    -- (����������� ��� ����� #8B ������������� KL_F8B)
                    -- ���� ��������� ������� "and pr_f8b_ = 0"
                    IF insider_ <> 1 and ABS (se_) > ROUND (sum_k_ * k1_, 0) and
                       rgk_ >= 0 and s_prizn_=0
                    THEN
                       if pr_f8b_ = 0 and link_code_ <> '000' then
                          insert into KL_F8B(DATF, LINK_GROUP, NMK, NNNN, OKPO, RNK)
                          select dat_, rnk_, max(groupname), LPAD (nnnn00_, 4, '0'), max(okpo), rnk_
                          from d8_cust_link_groups
                          where link_group = rnk_ and link_code = link_code_;

                          if sql%rowcount = 0 then
                             insert into KL_F8B(DATF, LINK_GROUP, NMK, NNNN, OKPO, RNK)
                             select dat_, null, nmk, LPAD (nnnn00_, 4, '0'), okpo, rnk
                             from customer
                             where rnk = rnk_;
                          end if;

                          pr_f8b_ := 1;
                       end if;
                       if pr_f8b_ = 0 then
                          nnnn01_ := nnnn01_ + 1;
                          if dat_ < dat_Zm4_ then
                             kodp_ := '01' || LPAD (nnnn01_, 4, '0');
                          else
                             kodp_ := '01' || LPAD (nnnn01_, 4, '0') || '000';
                          end if;

                          INSERT INTO RNBU_TRACE
                                      (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                                      )
                               VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_, comm_
                                      );

                          IF p47_ <> 0 OR p51_ <> 0 THEN
                             s_zal_ := p47_ + p51_;

                             IF s_zal_ > ABS (se_) THEN
                                s_zal_ := ABS (se_);
                             END IF;
                          END IF;

                          IF s_zal_ <> 0 THEN
                             if dat_ < dat_Zm4_ then
                                kodp_ := '05' || LPAD (nnnn01_, 4, '0');
                             else
                                kodp_ := '05' || LPAD (nnnn01_, 4, '0') || '000';
                             end if;

                             INSERT INTO RNBU_TRACE
                                      (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm)
                               VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), null, rnk_, link_code_, comm_);
                          END IF;

                          flag_inc_ := TRUE;
                       else
                          flag_inc_ := null;
                       end if;
                    ELSE
                       flag_inc_ := FALSE;
                    END IF;

                    -- ����� ������������ ����� ����� ���, ������� �� ��������. ������� ABS(se_)>ROUND(sum_k_*0.25,0)
                    IF insider_ <> 1 and NOT flag_inc_ AND (ABS (se_) >= sp_ or ABS (se_) >= sp1_) and se_ <> 0
                    THEN
                      IF p47_ <> 0 OR p51_ <> 0 THEN
                         s_zal_ := p47_ + p51_;

                         IF s_zal_ > ABS (se_) THEN
                            s_zal_ := ABS (se_);
                         END IF;
                      else
                          s_zal_ := 0;
                      END IF;

                      if s_zal_ <> 0 and ABS (se_) >= sp_ then
                         znapp_ := znap_;
                         nlspp_ := nlsp_;
                         comm_pp_ := comm_;
                         rnkp_  := rnk_;
                         link_codepp_ := link_code_;
                         s_zalp_:= s_zal_;
                         sp_ := ABS (se_);
                      elsif s_zal_ = 0 and ABS (se_) >= sp1_ then
                        -- ��� ����� �����������
                        -- ����� ������������ ����� ����� ���, ������� �� ��������. ������� ABS(se_)>ROUND(sum_k_*0.25,0)
                          znapp1_ := znap_;
                          nlspp1_ := nlsp_;
                          comm_pp1_ := comm_;
                          rnkp1_  := rnk_;
                          link_codep1_ := link_code_;
                          sp1_ := ABS (se_);
                      end if;
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

                      if dat_ >= dat_Zm4_ then
                         kodp_ := kodp_ || '000';
                      end if;

                      IF p47_ <> 0 OR p51_ <> 0 THEN
                         s_zal_ := p47_ + p51_;

                         IF s_zal_ > ABS (se_) THEN
                            s_zal_ := ABS (se_);
                         END IF;
                      END IF;

                      INSERT INTO RNBU_TRACE
                                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                                  )
                           VALUES (nlsp_, 0, dat_, kodp_, to_char(ABS (se_)), rnk_, rnk_, link_code_, comm_
                                  );

                      IF dat_ >= dat_Zm6_ and s_zal_ <> 0 THEN
                         kodp_ := 'A1' || '0000' || '000';
                          
                         INSERT INTO RNBU_TRACE
                                     (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm)
                         VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), null, rnk_, link_code_, comm_);
                      END IF;
                    END IF;

                    -- �������� 41
                    ksum_ := ROUND (sum_k_ * k1_, 0);

                    IF insider_ = 1
                    THEN
                       nlsp_ := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
                       znap_ := TO_CHAR (ABS (se_));
                       s_zal_ :=0;

                       IF type_ = 0
                       THEN
                          kodp_ := '040000';
                       ELSE
                          nnn2_ := nnn2_ + 1;
                          kodp_ := '04' || LPAD (nnn2_, 4, '0');
                       END IF;

                       if dat_ >= dat_Zm4_ then
                          kodp_ := kodp_ || '000';
                       end if;

                       IF p47_<>0 OR p51_ <> 0 THEN
                          s_zal_:= p47_ + p51_;

                          IF s_zal_ > ABS (se_) THEN
                             s_zal_ := ABS (se_);
                          END IF;
                       END IF;
     
                       INSERT INTO RNBU_TRACE
                                   (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm )
                       VALUES (nlsp_, 0, dat_, kodp_, to_char(ABS (se_)), rnk_, rnk_, link_code_, comm_);

                       IF dat_ >= dat_Zm6_ and s_zal_ <> 0 THEN
                          kodp_ := 'A2' || '0000' || '000';
                          
                          INSERT INTO RNBU_TRACE
                                      (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm)
                          VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), null, rnk_, link_code_, comm_);
                       END IF;

                       -- � 21.12.2005 ����������� 5% ���������� ���i���� �����
                       IF ((dat_ >= dat_Zm_ AND ABS (se_) > ROUND (sum_SK_ * k2_, 0)) OR
                           (dat_ < dat_Zm_ AND ABS (se_) > ROUND (sum_k_ * k2_, 0)))
                           and rgk_ >= 0
                       THEN
                          nnnn1_ := nnnn1_ + 1;
                          
                          -- ������������ ���������� 94NNNN
                          IF Dat_ >= to_date('31012014','ddmmyyyy') then
                             IF p47_<>0 OR p51_ <> 0 THEN
                                s_zal_:= p47_ + p51_;

                                IF s_zal_ > ABS (se_) THEN
                                   s_zal_ := ABS (se_);
                                END IF;
                             END IF;

                             IF s_zal_ <> 0 AND Dat_ < dat_Zm5_ THEN
                                if dat_ < dat_Zm4_ then
                                   kodp_ := '94' || LPAD (nnnn1_, 4, '0');
                                else
                                   kodp_ := '94' || LPAD (nnnn1_, 4, '0') || '000';
                                end if;
                                INSERT INTO RNBU_TRACE
                                         (nls, kv, odate, kodp, znap, rnk, ref, nbuc)
                                  VALUES (nlsp_, 0, dat_, kodp_,  TO_CHAR (s_zal_), rnk_, rnk_, link_code_);
                             END IF;
                          END IF;

                          IF dat_ >= dat_Zm_ THEN
                             BEGIN
                                SELECT  ABS (SUM (a.ost_eqv))
                                   INTO se54_
                             FROM NBUR_TMP_42_DATA a, OTCN_F42_PR o  
                             WHERE a.report_date = dat_ and
                                   a.rnk = rnk_  AND
                                   a.ddd = ddd_    AND
                                   a.acc = o.acc   AND
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

                                -- �� 16.06.2015 �������� �� ���������
                                IF Dat_ < dat_Zm5_
                                THEN

                                   if dat_ >= dat_Zm4_ then
                                      kodp_ := kodp_ || '000';
                                   end if;

                                   INSERT INTO RNBU_TRACE
                                       (nls, kv, odate, kodp, znap, rnk, ref, nbuc )
                                   VALUES (nlsp_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_ );
                                END IF;

                                -- ��������� � 18.01.2006
                                IF Dat_ < dat_Zm1_ OR flag_ = 0  THEN
                                   kodp_ := '570000';
                                ELSE
                                   -- � 01.04.2006
                                   kodp_ := '630000';
                                END IF;
                                if dat_ >= dat_Zm4_ then
                                   kodp_ := kodp_ || '000';
                                end if;

                                p57_  :=ABS (NVL(se54_, 0)) - ROUND (sum_SK_ * k2_, 0) ;

                                INSERT INTO RNBU_TRACE
                                    (nls, kv, odate, kodp, znap, rnk, ref, nbuc )
                                VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_, rnk_, link_code_ );
                             END IF;

                             -- � 01.04.2006 ����������� 10% ��� 20% ���������� ���i���� �����
                             -- ������� �i� ������ ���������-������i������� �����i�
                             IF flag_>0 AND k3_ > 0 AND ABS (NVL(se54_, 0)) > ROUND (sum_SK_ * k3_, 0)
                             THEN
                                -- � 01.04.2006
                                if dat_ < dat_Zm4_ then
                                   kodp_ := '630000';
                                else
                                   kodp_ := '630000' || '000';
                                end if;

                                p57_  :=ABS (NVL(se54_, 0)) - ROUND (sum_SK_ * k3_, 0) ;

                                INSERT INTO RNBU_TRACE
                                    (nls, kv, odate, kodp, znap, rnk, ref, nbuc )
                                VALUES (nlsp_, 0, dat_, kodp_, p57_, rnk_, rnk_, link_code_ );
                             END IF;
                          END IF;

                         flag_inc_ := TRUE;
                       ELSE
                         flag_inc_ := FALSE;
                       END IF;

                       -- ����� ������������ ����� ����� ���, ������� �� ��������. ������� ABS(se_)>ROUND(sum_k_*0.25,0)
                       IF insider_ = 1 and NOT flag_inc_ AND ABS (se_) >= si_
                       THEN
                         IF p47_<>0 OR p51_ <> 0 THEN
                            s_zal_:= p47_ + p51_;

                            IF s_zal_ > ABS (se_) THEN
                               s_zal_ := ABS (se_);
                            END IF;
                         END IF;

                         if s_zal_ <> 0 then
                            rnki_     := rnk_;
                            znapi_ := znap_;
                            nlsi_ := nlsp_;
                            s_zali_:= s_zal_;
                            si_ := ABS (se_);
                         end if;
                       END IF;

                       -- ��� ����� �����������
                       -- ����� ������������ ����� ����� ���, ������� �� ��������. ������� ABS(se_)>ROUND(sum_k_*0.25,0)
                       IF insider_ = 1 and NOT flag_inc_ AND ABS (se_) >= si1_
                       THEN
                          IF p47_+p51_ = 0 THEN
                             znapi1_ := znap_;
                             nlsi1_ := nlsp_;
                             rnki1_  := rnk_;
                             si1_ := ABS (se_);
                          END IF;
                       END IF;
                   END IF;
                end if;
             END IF;
          ELSE
             IF se_ <> 0
             THEN
                --- ������������ �����, ��� ������������� �� ������� ����� (��� 72)
                IF Dat_ > to_date('31032012','ddmmyyyy')
                THEN
                   IF ABS (se_) > ROUND (sum_SK_ * 0.15, 0) --and rgk_ >= 0
                   THEN
                      if substr(kodp_,1,2) <> '06' then
                         nnnn2_ := nnnn2_ + 1;
                      end if;
                      if dat_ < dat_Zm4_ then
                         kodp_ := '72' || LPAD (nnnn2_, 4, '0');
                      else
                         kodp_ := '72' || LPAD (nnnn2_, 4, '0') || '000';
                      end if;
                      nlsu_ := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
                      znap_ := TO_CHAR (abs(se_));

                      INSERT INTO RNBU_TRACE
                                  (nls, kv, odate, kodp, znap, rnk, ref, nbuc
                                  )
                           VALUES (nlsu_, 0, dat_, kodp_, znap_, rnk_, rnk_, link_code_
                                  );

                      spp_72 := se_;
                   END IF;

                   IF ABS (se_) < ROUND (sum_SK_ * 0.15, 0) AND ABS (se_) >= spp_72
                   THEN
                      znapu_72 := TO_CHAR (abs(se_));
                      nlsu_72 := (case when link_code_='000' then 'RNK =' else 'LINK_CODE =' end) || TO_CHAR (rnk_);
                      rnku_72 := rnk_;
                      spp_72 := se_;
                   END IF;
                END IF;
             END IF;
          END IF;
       END LOOP;

       CLOSE saldo;
    --------------------------------------------------------------------------
       --- 30.01.2014 - ��������� ���������� 03 ��� ������������� ��������,
       --- ������� ������ 5% � ���� �����������
       IF TO_NUMBER (znapi_) > 0
       THEN
          -- �� 16.06.2015 �������� �� ���������
          IF Dat_ < dat_Zm5_
          THEN

             kodpi_ := '03' || LPAD (TO_CHAR (nnnn1_ + 1), 4, '0');

             INSERT INTO RNBU_TRACE
                         (nls, kv, odate, kodp, znap, rnk, ref
                         )
                  VALUES (nlsi_, 0, dat_, kodpi_, znapi_, rnki_, rnki_
                         );

             IF Dat_ >= to_date('31012014','ddmmyyyy') and s_zali_ >= 0
             THEN
                kodpi_ := '94' || LPAD (TO_CHAR (nnnn1_ + 1), 4, '0');

                INSERT INTO RNBU_TRACE
                         (nls, kv, odate, kodp, znap, rnk, ref
                         )
                  VALUES (nlsi_, 0, dat_, kodpi_, to_char(s_zali_), rnki_, rnki_
                         );
             END IF;
          END IF;

       END IF;

       IF TO_NUMBER (znapp_) > 0
       THEN
          kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0') || '000';

          INSERT INTO RNBU_TRACE
                      (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                      )
               VALUES (nlspp_, 0, dat_, kodpp_, znapp_, rnkp_, rnkp_, link_codepp_, comm_pp_
                      );

        --- 03.11.2008 - �� ��������� ������������ �� ����� ����������� ���������� 05 ��� ������������� ��������,
        --- ������� ������ 25%

          IF s_zalp_ >= 0 THEN
             kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 1), 4, '0') || '000';

             INSERT INTO RNBU_TRACE
                      (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                      )
               VALUES (nlspp_, 0, dat_, kodpp_, to_char(s_zalp_), null, rnkp_, link_codepp_, comm_pp_
                      );
          END IF;

       END IF;

       --- 25.06.2011 - �� ��������� ������������ ��������� ���������� 01 ��� ������������� ��������,
       --- ������� ������ 25% � ��� �����������
       IF TO_NUMBER (znapp1_) > 0
       THEN
          kodpp_ := '01' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0') || '000';

          INSERT INTO RNBU_TRACE
                      (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                      )
               VALUES (nlspp1_, 0, dat_, kodpp_, znapp1_, rnkp1_, rnkp1_, link_codep1_, comm_pp1_
                      );

             kodpp_ := '05' || LPAD (TO_CHAR (nnnn01_ + 2), 4, '0') || '000';

             INSERT INTO RNBU_TRACE
                      (nls, kv, odate, kodp, znap, rnk, ref, nbuc, comm
                      )
               VALUES (nlspp1_, 0, dat_, kodpp_, '0', null, rnkp1_, link_codep1_, comm_pp1_
                      );
       END IF;

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
       if pmode_ = 0 then
           --------------------------------------------------------------------------
           ---- � 13.11.2015 (�� 12.11.2015) ����� ������������� ���������� A00000000
           ---- �/� 9110
           if dat_ >= dat_Zm6_
           then
              OPEN saldoost1;

              LOOP
                 FETCH saldoost1
                  INTO acc_, nbs_, nls_, kv_, data_, rnk_, se_, ddd_;

                 EXIT WHEN saldoost1%NOTFOUND;

                 IF se_ <> 0
                 THEN
                    kodp_ := SUBSTR (ddd_, 2, 2) || '0000' || '000';
                    znap_ := TO_CHAR (ABS (se_));

                    INSERT INTO RNBU_TRACE
                                (nls, kv, odate, kodp, znap, rnk, ref, acc
                                )
                         VALUES (nls_, kv_, data_, kodp_, znap_, rnk_, rnk_, acc_
                                );
                 END IF;
              END LOOP;

              CLOSE saldoost1;

           end if;
           --------------------------------------------------------------------------

          -- ������������ ������ ���� A90000000 � 03.08.2018
          if dat_ >= dat_Zm7_   
          then
             insert into rnbu_trace(nls, kv, odate, kodp, znap, rnk, acc, mdate)
             select d.nls, d.kv, report_date, 'A90000000', -1 * d.ost_eqv, d.rnk, d.acc, a.mdate
             from NBUR_TMP_42_DATA d, accounts a
             where d.report_date = dat_ and
                d.ddd like 'A9%' and
                d.acc = a.acc;
          end if;
          -----------------------------------------------------------------------
       end if;

       ------------------------------------------------------------------------------
        -- ��� ����� �� ������� �� ���� 01 ������� ��� �������� ����=20077720
        --              ������� �� ���� 01 ������� ��� �        ����=23167814
        delete from rnbu_trace
        where (kodp like '01%' or kodp like '02%' or kodp like '61%')
          and rnk = 90092301;

        -- ���� ��� �������� ������ ������������ � ������������ ���������� ALT_BIG 
        -- � � ������������ ���������� � � ���������� ���.�����
        delete from rnbu_trace
        where (kodp like '01%' or kodp like '02%' or kodp like '04%')
          and rnk in ( select rnk from customer 
                       where codcagent = 2  
                         and rnk in ( select rnk from custbank 
                                      where alt_bic in ('8260000013', '8400000053', '8400000054')
                                        and ( trim(rating) in ('BBB', 'BBB+','BBB-','Baa1','Baa2','Baa3')  or
                                              substr(trim(rating),1,1) in ('A', 'T', 'F') )
                                    )
                     ) 
          and rnk in ( select rnk from accounts where nbs in ('1502', '1508', '1509', '1510', '1513', '1516', '1518', '1519', 
                                                              '1520', '1521', '1522', '1524', '1526', '1528', '1529', 
                                                              '1532', '1533', '1535', '1536', '1538', 
                                                              '1542', '1543', '1545', '1546', '1548', '1549', 
                                                              '1600', '1607', '1609')
                     ) ;
        
        nnnn01_ := 0;
        rnk_ := 0;
        ddd_ := '00';

        for k in (select kodp, rnk, ref, trim(comm) comm
                  from rnbu_trace
                  where substr(kodp,1,2) not in ('05','R1', 'R2')
                  order by substr(kodp,1,2), to_number(znap) DESC, rnk )
        loop
            -- � ���� COMM (�����������) ��������� �������� �������
            update rnbu_trace
            set comm = substr((case when nvl(nbuc, '000') = '000'
                                    then (select c.nmk
                                          from customer c
                                          where c.rnk = k.rnk)||' '
                                    else ''
                               end) || k.comm,1,255)
            where rnk = k.rnk and kodp = k.kodp;

            if ddd_ = '00' OR ddd_ <> substr(k.kodp,1,2) OR rnk_ = 0 OR rnk_ <> k.rnk
            then
               if substr(k.kodp,1,2) = '01' then
                  nnnn01_ := nnnn01_ + 1;

                  if Dat_ < dat_Zm4_ then
                     update rnbu_trace set
                        kodp = substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn01_), 4, '0')
                     where rnk = k.rnk and kodp = k.kodp;
                  else
                     update rnbu_trace set
                        kodp = substr(k.kodp,1,2) || LPAD (TO_CHAR (nnnn01_), 4, '0') || '000'
                     where rnk = k.rnk and kodp = k.kodp;

                     update rnbu_trace set
                        kodp = '05' || LPAD (TO_CHAR (nnnn01_), 4, '0') || '000'
                     where ref = k.ref and substr(kodp,1,2)='05';
                  end if;
               else
                  if substr(k.kodp,3,4) <> '0000' then
                     BEGIN
                        select to_number(substr(kodp,3,4)) into nnnn1_
                        from rnbu_trace
                        where rnk = k.rnk and
                        substr(kodp,1,2) in ('01','03') and
                        substr(kodp,1,2) <> substr(k.kodp,1,2) and
                        rownum = 1 ;

                        if type_ <> 0 then
                           nnnn01_ := nnnn01_+1;
                           nnnn1_ := nnnn01_;
                        end if;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        nnnn01_ := nnnn01_+1;
                        nnnn1_ := nnnn01_;
                     END;

                     if Dat_ < dat_Zm4_ then
                        update rnbu_trace set
                           kodp=substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn1_), 4, '0')
                        where rnk = k.rnk and kodp=k.kodp;
                     else
                        update rnbu_trace set
                           kodp = substr(k.kodp,1,2)||LPAD (TO_CHAR (nnnn1_), 4, '0') || '000'
                        where rnk = k.rnk and kodp = k.kodp;
                     end if;
                  end if;
               end if;

               rnk_ := k.rnk;
               ddd_ := substr(k.kodp,1,2);
            end if;
        end loop;

        -- 17/01/2019  ���������� ������ ��������� "B4"
        IF dat_ >= to_date('18012019','ddmmyyyy') THEN
           select sum(znap)
              into s04_
           from rnbu_trace 
           where kodp like '04%';

           if s04_ > ROUND (sum_k_ * k1_, 0) then
              insert into rnbu_trace(nls, odate, kodp, znap )
              VALUES ('�������� B4', dat_, 'B400000', to_char(s04_ - ROUND (sum_k_ * k1_, 0)));
           end if; 
        END IF;
       
        bc.subst_mfo(mfo_);
       
        IF type_ = 0
        THEN
          DELETE FROM TMP_NBU
                WHERE kodf = kodf_ AND datf = dat_;

          INSERT INTO TMP_NBU (kodf, datf, kodp, znap)
          SELECT kodf_, dat_, kodp, SUM (znap)
          FROM RNBU_TRACE
          where substr(kodp,1,2) not in ('47','50','51','54','58','61','63','82','83','84','11') 
          GROUP BY kodf_, dat_, kodp;
        END IF;

       bc.home;
       
       -- ��������� ����������� ����������� 01 � 02 � ������� ������� ������
       -- ������� �� ������ � ������
       insert into rnbu_trace (odate, nls, kv, kodp, znap, rnk, nbuc, nd, ref, acc, comm)
        select /*+ leading(o) */
             dat_ odate, o.nls, o.kv, b.kodp,
             decode(substr(o.kodp,1,1),'1', -1, 1) * o.znap znap,
             o.rnk, nvl(o.link_code, '000'), o.nd, b.group_num ref, o.acc,
             'KF = '||o.kf||' '|| 
             (case when (substr(o.kodp,2,4) like '___9' or
                         substr(o.kodp,2,4) in ('1890','2890','3590','3690','3692')) and
                         substr(o.kodp,1,1) = '2'
                    then '(������ �� SNA � ����� #C5) '
                   else '(������� � ����� #C5) '
              end) || substr(o.kodp,2,4) ||
              ' / R011=' || substr(o.kodp,6,1) ||
              ' / R013=' || substr(o.kodp,7,1) ||
              ' / S245=' || substr(o.kodp,16,1) comm
        from otc_c5_proc o
        join (select distinct k.rnk, k.nbuc link_code,
                            (case when k.kodp like '01%' then 'R1'
                                 when k.kodp like '02%' then 'R2'
                                 else 'R4'
                            end)||substr(k.kodp,3) kodp,
                            k.ref group_num
            from rnbu_trace k
            where (kodp like '01%' or kodp like '02%' or kodp like '04%')
            order by substr(kodp,3,4), rnk, k.nbuc) b
        on (o.rnk = b.rnk and
            NVL(o.link_code, '000') = b.link_code)
        where o.datf = dat_;

       delete  from rnbu_trace where kodp like '01%' or kodp like '02%' or kodp like '04%';

       update rnbu_trace
       set kodp = replace(kodp, 'R', '0')
       where kodp like 'R1%' or kodp like 'R2%' or kodp like 'R4%';
   end if;
   
   bc.subst_mfo(mfo_);
   
   logger.info ('P_F42_CONS: End ');
   commit;
END;
/
show err;

PROMPT *** Create  grants  P_F42_CONS ***
grant EXECUTE                                                                on P_F42_CONS        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_F42_CONS        to RPBN002;
grant EXECUTE                                                                on P_F42_CONS        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_F42_CONS.sql =========*** End *** 
PROMPT ===================================================================================== 
/