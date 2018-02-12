CREATE OR REPLACE PROCEDURE BARS.p_fe8_nn (dat_     DATE,
                                      sheme_   VARCHAR2 DEFAULT 'G',
                                      prnk_    NUMBER DEFAULT NULL ) IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : ��������� ������������ #E8 ��� �� (�������������)
% COPYRIGHT   : Copyright UNITY-BARS Limited, 2008.  All Rights Reserved.
% VERSION     : 30/01/2018 (26/01/2018, 11/10/2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
               sheme_ - ����� ������������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
30.01.2018 - ������ ���������� ���� K021
25.01.2018 - ������ ���������� ���� ZZZZZZZZZZ �� K021
11.10.2017 - ��� ����� ���.������ 270, 366 ���� ������ �������� �������� ��
             ���� SDATE ����. CC_DEAL  ������ bdate ����. CC_ADD
12.09.2017 - ��� ����� ���.������ 270, 366 ����� ��������, �������������
             ��������, ���� ������ � ���� ��������� �������� �������� ��
             CC_DEAL
02.08.2017 - ������� ���� ��� ��������� %% ������ ��� ������ �����������
             � �������� ���� ��������� ���� ������ ������
             (�� 01/01/2000 - ��������� � ������)
25.01.2017 - �������� %% ������ ��� ������ ����������� ���� �� ����� ������
             ������� �������� �� � ������ �������������� ��������
             ���� ���������
27.12.2016 -��� ���������� ���� ������� � ���������� �� ���������� �� ���
            �� rcukru
06.12.2016 - ��� ������������ � ���� ZZZZZZZZZZ ������ �������� ���������
             ����� ��� ������� ���� �������� ����� (4 ��������� �������)
09.11.2016 - ��� ���.����� 3351 �� ����� ����������� ����������� � �������
             ������������ ������ �.�. ������ ����� ������� � �������
             ������������.
13.05.2016 - ��� ������ ������������ ����� ����������� K021='4' ������ '9'
06.05.2016 - ��� ���.����� 3351 ����� ����������� ����������� � �������
             ������������ ������
26.04.2016 - ��� �� ������������ ��� ZZZZZZZZZZ ����� ����������� ���
             'CC' || <����� + ����� ��������>
21.04.2016 - ��� ���.����� 2658 � Ob22='01' �� ����� �������������
             ���������� 112 (���� ��������� ��������)
14.04.2016 - ������ ��������� ������� ���������/�����������(1,2) �����
             ����������� �������� ���� K060 (PRINSIDER � CUSTOMER)
11.04.2016 - ������� ��������� ������������ ���� �� CUSTOMERW �� TAG='RKO_D'
05.04.2016 - �� ����� ����������� ���������� DDD='150'
18.03.2016 - �� 01.04.2016 ����� ������������� ����� ����� ����������
             "������ ����������������� ����" (�������� K021 �� KOD_K021)
             � ���� P085 (����.OTCN_F71_CUST) ��������� K021
03.03.2016 - ��� ��������� �� �� ����� �������� �������� � ������� �����
             ��������� �������� ������ ����� 50 000.00 � ������ ��� ������
             �� ���������������� ����� ������ ���� ������ ����� 2000000.00
             (��� MFO in (322669, 311647, 300465, 302076, 303398, 305482))
             ������� �������� ���������� ���� ���� ��� �� � ���
             (��������� ����������)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_        VARCHAR2 (2)          := 'E8';
   s04_         NUMBER;
   f91_         NUMBER;
   sum_d_       NUMBER;
   ostq_no96_   NUMBER;
   kos_         NUMBER;
   fmt_         VARCHAR2 (20)         := '9999999990D0000';
   dfmt_        VARCHAR2 (8)          := 'ddmmyyyy';
   ved_         customer.ved%TYPE;
   sed_         VARCHAR2 (2);
   k110_        VARCHAR2 (5);
   k111_        VARCHAR2 (2);
   reg_         customer.c_reg%TYPE;
   s031_        specparam.s031%TYPE;
   nkd_         specparam.nkd%TYPE;
   pdat_        DATE;
   our_reg_     NUMBER;
   our_rnk_     NUMBER;
   kol_rnk      NUMBER;
   max_rnk      NUMBER;
   pasp_sn1_    VARCHAR2 (20);
   b040_        VARCHAR2 (20);
   sab_         VARCHAR2 (3);
   custtype_    NUMBER;
   sum_zd_      NUMBER;
   sum_sk_      DECIMAL (24);         -- ���� ���������� ���i����
   smax_        NUMBER                := 200000000;
   -- ����������� ���� �� ������ �����������
   tip_         accounts.tip%TYPE;
   dat1_        DATE;                 -- ���� ������ ������ !!!
   dat2_        DATE;                 -- ���� ������ ������ !!!
   dc_          INTEGER;
   pog_         BOOLEAN;          -- ������� ������� � ������� ��������� ������
   kolz_        NUMBER;
   kolvo_       NUMBER;
   nls_         VARCHAR2 (15);
   nbs_         VARCHAR2 (4);
   data_        DATE;
   kv_          SMALLINT;
   rez_         SMALLINT;
   kodp_        VARCHAR2 (35);
   znap_        VARCHAR2 (70);
   mfo_         NUMBER;
   mfou_        NUMBER;
   glb_         Number;
   kb_          Varchar2(12);
   rnk_         NUMBER;
   rnk_3351     NUMBER;
   rnk1_        NUMBER;
   acc_         NUMBER;
   acc1_        NUMBER;
   vidd_        NUMBER;
   p010_        VARCHAR2 (70);
   p020_        VARCHAR2 (1);
   p030_        VARCHAR2 (14);
   okpo_        VARCHAR2 (14);
   okpo1_       VARCHAR2 (14);
   kod_okpo     VARCHAR2 (10);
   our_okpo_    VARCHAR2 (50);
   okpo_nerez   VARCHAR2 (14);
   p021_        VARCHAR2 (1);
   p040_        SMALLINT;
   p050_        SMALLINT;
   p060_        SMALLINT;
   p070_        VARCHAR2 (4);
   p080_        VARCHAR2 (70);
   p080f_       VARCHAR2 (2);
   p081_        VARCHAR2 (70);
   p090k_       specparam.nkd%TYPE;  --VARCHAR2 (20);
   p090_        cc_deal.cc_id%TYPE;  --VARCHAR2 (20);
   p100_        VARCHAR2 (1);
   p111_        DATE;
   p111p_       DATE;
   p112_        DATE;
   p112p_       DATE;
   p113_        DATE;
   f71k_        NUMBER;
   p120_        NUMBER;
   ndk_         NUMBER;
   nd_          NUMBER;
   nnnn_        NUMBER;
   kod_nnnn     VARCHAR2 (4);
   sum_k_       DECIMAL (24);
   sum_71       DECIMAL (24);
   sum_71o      NUMBER;
   sum_lim      NUMBER;
   p130_        NUMBER;
   p130_BCZ     NUMBER;
   p140_        SMALLINT;
   p150_        VARCHAR2 (20);
   s080_        VARCHAR2 (1);
   k021_        VARCHAR2 (1);
   r013_        VARCHAR2 (1);
   kol_dz       NUMBER;
   userid_      NUMBER;
   p_rnk_       NUMBER                := NULL;          -- ���������� rnk
   p_okpo_      VARCHAR2(14)          := NULL;          -- ���������� ����
   p_nd_        NUMBER                := NULL;          -- ���������� �������
   p_sum_zd_    NUMBER                := NULL;
   p_p111_      DATE                  := NULL;
   p_p112_      DATE                  := NULL;
   p_p090_      cc_deal.cc_id%TYPE         := '------'; --VARCHAR2 (20)
   p_p130_      NUMBER;
   doda_        VARCHAR2 (10);
   acck_        NUMBER;
   isp_         NUMBER;
   i_opl_       NUMBER                := 0;
   period_      kl_f00.period%TYPE;
   ddd_         VARCHAR2 (3);
   ob22_        VARCHAR2 (2);
   ncontr_      NUMBER                := 0;
   ncontru_     NUMBER                := 0;
   sum_contr_   NUMBER                := 0;
   sql_    varchar2(1000);
   dat_izm1     date := to_date('31/08/2013','dd/mm/yyyy');
   dat_izm2     date := to_date('31/03/2016','dd/mm/yyyy');
   dat_izm3     date := to_date('31/01/2017','dd/mm/yyyy');
   ret_         NUMBER;
   sql_acc_     clob:='';

   FL_D8_       number := F_Get_Params('DPULINE8', -1);

--�������
   CURSOR saldo
   IS
      SELECT   a.acc, a.nls,
               a.nbs,
               a.nmk, a.rnk, NVL (f.k074, '0'), a.okpo, a.codc,
               a.country, a.c_reg, a.ved, a.prins,
               (case when a.nbs like '8%' then '2'||substr(a.nbs,2) else a.nbs end) nbs,
               a.daos, a.mdate,
               decode(a.kv, 980, a.ost, a.ostq) ostq,
               a.kv, a.fdat, a.tip, a.custtype, NVL (TRIM (k.ddd), '121'), a.ostf,
               a.glb, a.kb, a.vost, a.ostq_no96
          FROM (SELECT /*+ordered */
                       s.acc, s.nls, s.nbs, s.kv, s.daos, s.mdate, aa.fdat,
                       aa.ost - aa.dos96 + aa.kos96 ost,
                       aa.ostq - aa.dosq96 + aa.kosq96 ostq, s.tip, s.isp,
                       DECODE(mfou_, 300465, DECODE(mfo_, 300465, c.rnk, DECODE(c.rnkp, NULL, c.rnk, c.rnkp)), c.rnk) RNK,
                       c.nmk, LPAD (TRIM (c.okpo), 10, '0') okpo, 2 - MOD (c.codcagent, 2) codc, c.country, c.c_reg,
                       NVL (c.ved, '00000') ved,
                       c.prinsider prins,
                       DECODE (c.custtype, 1, 2, 2, 2, DECODE (sed, 91, 3, 1)) custtype,
                       c.ise, d.ostf,
                       NVL(rc.glb,0) glb, NVL(cb.alt_bic,'0') kb, aa.vost,
                       decode(aa.kv, 980, aa.ost, aa.ostq) ostq_no96
                  FROM otcn_f71_rnk d, customer c, otcn_saldo aa, otcn_acc s,
                       custbank cb, rcukru rc
                 WHERE DECODE(mfou_, 300465, DECODE(mfo_, 300465, c.rnk, DECODE(c.rnkp, NULL, c.rnk, c.rnkp)), c.rnk) = d.rnk
                   and aa.rnk = c.rnk
                   and c.rnk = cb.rnk(+)
                   and cb.mfo=rc.mfo(+)
                   AND aa.acc = s.acc
                   AND aa.rnk = s.rnk
                   AND aa.ost - aa.dos96 + aa.kos96 <> 0 ) a,
               kl_k070 f,
               kl_f3_29 k
         WHERE a.ise = f.k070(+)
           AND replace(substr(a.nbs,1,1),'8','2')||substr(a.nbs,2) = k.r020
           AND k.kf = 'E8'
           AND ( (NVL(k.ddd,'121') = '122' and a.nbs like '___6%' and a.ost < 0) OR
                 (NVL(k.ddd,'121') = '122' and a.nbs not like '___6%' and a.ost > 0) OR
                 (NVL(k.ddd,'121') <> '122' and a.ost > 0)
               )
           AND nvl(f.d_close, dat_ + 1) > dat_
      ORDER BY a.okpo, a.rnk, a.nbs;

-- ������������
   CURSOR c_cust
   IS
      SELECT   rnk, okpo, rez, custtype, p010, p020, p025,
               p050, p055, p060, p085
          FROM otcn_f71_cust
      ORDER BY okpo, rnk;

-- ��� �������� �� ������ �����������
   CURSOR c_cust_dg
   IS
      SELECT   acc, nd, p090, p110, p111, p112, p113, nbs, nls, kv, ddd, p120,
               p130, p150
          FROM otcn_f71_temp
         WHERE rnk = rnk_
           and p120 != 0
      ORDER BY nd, p090, nbs, kv;

-- ��������� ����������� � ����������� �������� (���������)
   CURSOR basel
   IS
      SELECT DISTINCT kodp, znap
      FROM rnbu_trace
      WHERE SUBSTR (kodp, 1, 3) IN
                         ('010',
                          '021',
                          '025',
                          '050',
                          '055',
                          '060',
                          '090',
                          '111',
                          '112',
                          '113',
                          '019',
                          '206' )
      ORDER BY SUBSTR (kodp, 4, 10) || SUBSTR (kodp, 1, 3) || SUBSTR (kodp, 26);

-- ���������� ������
   CURSOR basel1
   IS
      SELECT   kodp, MAX (TO_NUMBER (znap) * 10000)
      FROM rnbu_trace
      WHERE SUBSTR (kodp, 1, 3) IN ('130')
      GROUP BY kodp
      ORDER BY SUBSTR (kodp, 4, 10) || SUBSTR (kodp, 1, 3);

-- ������������� ��������� ����������� ��������
   CURSOR basel2
   IS
      SELECT   kodp, SUM (znap)
      FROM rnbu_trace
      WHERE SUBSTR (kodp, 1, 3) IN ('121', '122', '123', '150')
      GROUP BY kodp
      ORDER BY SUBSTR (kodp, 4, 10) || SUBSTR (kodp, 1, 3);

-------------------------------------------------------------------
-------------------------------------------------------------------
   PROCEDURE p_ins (
      p_kodp_   IN   VARCHAR2,
      p_znap_   IN   VARCHAR2,
      p_nls_    IN   VARCHAR2 DEFAULT NULL
   )
   IS
      l_isp_   NUMBER := isp_;
      l_acc_   NUMBER := acc_;
   BEGIN
      IF p_nls_ IS NULL
      THEN
         l_isp_ := NULL;
         l_acc_ := NULL;
      END IF;

      INSERT INTO rnbu_trace
                  (acc, nls, kv, odate, isp, rnk,
                   kodp, znap, nd
                  )
           VALUES (l_acc_, p_nls_, p140_, data_, l_isp_, rnk_,
                   SUBSTR (p_kodp_ || TO_CHAR (rnk_), 1, 35), p_znap_, nd_
                  );
   END;

-------------------------------------------------------------------
   PROCEDURE p_ins_contr
   IS
--- ������ ���������� �����������
      kodp_   VARCHAR2 (30);
   BEGIN

      okpo_ := kod_okpo;

      -- ������� ��������� � �����������
      IF custtype_ in (1, 3)  and okpo_ in ('00000','000000000','0000000000','99999','999999999')
      THEN
         IF custtype_ = 1 and rez_ = 2
         THEN
            kod_okpo := 'I' || LPAD (to_char(rnk_), 9,'0');

            --BEGIN
            --   SELECT 'CC' || LPAD (SUBSTR (TRIM (ser) || TRIM (numdoc), 1, 8),
            --                        8,
            --                        '0'
            --                       )
            --      INTO kod_okpo
            --   FROM person
            --   WHERE rnk = rnk_;
            --EXCEPTION
            --   WHEN NO_DATA_FOUND
            --   THEN
            --   ncontr_ := ncontr_ + 1;
            --   if mfo_ = 300465
            --   then
            --      kod_okpo := 'IN' || LPAD (TO_CHAR (ncontr_), 8, '0');
            --   else
            --      kod_okpo := 'IN' || LPAD (TO_CHAR(our_reg_) || substr(TO_CHAR (100+ncontr_), 2, 2), 8, '0');
            --   end if;
            --END;
            k021_ := '9';
         END IF;

         IF custtype_ in (1, 3) and rez_ = 1
         THEN
            BEGIN
               SELECT LPAD (SUBSTR (TRIM (ser) || TRIM (numdoc), 1, 10),
                            10,
                            '0'
                           )
                  INTO kod_okpo
               FROM person
               WHERE rnk = rnk_;
               k021_ := '6';
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  kod_okpo := 'RNK' || LPAD (SUBSTR (rnk_, 1, 7), 7, '0');
                  k021_ := 'E';
            END;
         END IF;
      END IF;

      IF custtype_ in (1, 3) and okpo_ not in ('00000','000000000','0000000000','99999','999999999')
      THEN
         IF mfo_ <> 324805 and custtype_ = 1 and rez_ = 2
         THEN
            --BEGIN
            --   SELECT 'CC' || LPAD (SUBSTR (TRIM (ser) || TRIM (numdoc), 1, 8),
            --                        8,
            --                        '0'
            --                       )
            --      INTO kod_okpo
            --   FROM person
            --   WHERE rnk = rnk_;
            --EXCEPTION
            --   WHEN NO_DATA_FOUND
            --   THEN
            --   ncontr_ := ncontr_ + 1;
            --   if mfo_ = 300465
            --   then
            --      kod_okpo := 'IN' || LPAD (TO_CHAR (ncontr_), 8, '0');
            --   else
            --      kod_okpo := 'IN' || LPAD (TO_CHAR(our_reg_) || substr(TO_CHAR (100+ncontr_), 2, 2), 8, '0');
            --   end if;
            --END;
            kod_okpo := 'I' || LPAD (to_char(rnk_), 9,'0');
            k021_ := '9';
         END IF;

         if mfo_ = 324805 and custtype_ = 1 and rez_ = 2
         then
            kod_okpo := trim(kod_okpo);
            k021_ := '9';
         end if;

         IF custtype_ in (1, 3) and rez_ = 1
         THEN
            kod_okpo := LPAD (kod_okpo, 10, '0');
            k021_ := '2';
         END IF;

      END IF;

      -- �� ���������������
      --IF custtype_ = 3
      --THEN
      --   kod_okpo := LPAD (kod_okpo, 10, '0');
      --end if;

      -- ������ ���������, �����������
      IF custtype_ =2 and okpo_ in ('00000','000000000','0000000000','99999','999999999')
      THEN
         IF custtype_ = 2 and rez_ = 2 and glb_ = 0 and kb_ = '0'
         THEN
            ncontr_ := ncontr_ + 1;
            if mfo_ = 300465
            then
               --kod_okpo := 'IN' || LPAD (TO_CHAR (ncontr_), 8, '0');
               kod_okpo := 'I' || LPAD (TO_CHAR (rnk_), 9, '0');
            else
               --kod_okpo := 'IN' || LPAD (TO_CHAR(our_reg_) || substr(TO_CHAR (100+ncontr_), 2, 2), 8, '0');
               kod_okpo := 'I' || LPAD (TO_CHAR(rnk_), 9, '0');
            end if;
            k021_ := '9';
         END IF;

         -- ������ ���������
         IF custtype_ = 2 and rez_ = 1 and glb_ = 0 and kb_ = '0'
         THEN
            ncontr_ := ncontr_ + 1;
            --kod_okpo := 'D' || LPAD (TO_CHAR (ncontr_), 9, '0');
            kod_okpo :=  LPAD (TO_CHAR (rnk_), 10, '0');
            k021_ := 'E';
         END IF;
      END IF;

      IF custtype_ = 2 and okpo_ not in ('00000','000000000','0000000000','99999','999999999')
      THEN
         IF custtype_ = 2 and rez_ = 1 and glb_ = 0 and kb_ = '0'
         THEN
            kod_okpo := LPAD (kod_okpo, 10, '0');
            k021_ := '1';
         end if;
         IF mfo_ <> 324805 and custtype_ = 2 and rez_ = 2 and glb_ = 0 and kb_ = '0'
         THEN
            ncontr_ := ncontr_ + 1;
            if mfo_ = 300465
            then
               --kod_okpo := 'IN' || LPAD (TO_CHAR (ncontr_), 8, '0');
               kod_okpo := 'I' || LPAD (TO_CHAR (rnk_), 9, '0');
            else
               --kod_okpo := 'IN' || LPAD (TO_CHAR(our_reg_) || substr(TO_CHAR (100+ncontr_), 2, 2), 8, '0');
               kod_okpo := 'I' || LPAD (TO_CHAR(rnk_), 9, '0');
            end if;
            k021_ := '9';
         END IF;
         IF mfo_ = 324805 and custtype_ = 2 and rez_ = 2 and glb_ = 0 and kb_ = '0'
         THEN
            kod_okpo := TRIM(kod_okpo);
            k021_ := '1';
         END IF;
      END IF;

      -- ����� ���������
      IF custtype_ = 2 and rez_ = 1 and glb_ <> 0
      THEN
         kod_okpo := LPAD ( glb_, 10, '0');
         k021_ := '3';
      end if;
      -- ����� �����������
      IF custtype_ = 2 and rez_ = 2 and kb_ <> '0'
      THEN
         kod_okpo := LPAD ( kb_, 10, '0');
         k021_ := '4';
      end if;

      -- ��� �� �� � ���(���) �� ������ ���������� NMK, OKPO, CUSTTYPE, VED, C_REG
      -- �.� ��� ����������� RNKP �� ������ �������� ����������� ��� ���������
      if custtype_ in (1, 2, 3) and rez_ = 1 then
         begin
            select nmk,
                   --LPAD(trim(okpo), 10, '0'),
                   DECODE (custtype, 1, 2, 2, 2, DECODE (sed, 91, 3, 1)),
                   ved, c_reg
               into p010_, custtype_, ved_, reg_  -- kod_okpo,
            from customer
            where rnk=rnk_;
         exception when no_data_found then
            null;
         end;
      end if;

      -- ����������� ���� ������������� ������������
      k110_ := NVL (ved_, '00000');

      -- ����������� ���� �������
      IF NVL (reg_, 0) > 0
      THEN
         BEGIN
            SELECT ko
              INTO reg_
              FROM kodobl_reg o
             WHERE o.c_reg = reg_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               reg_ := our_reg_;
         END;
      ELSE
         reg_ := our_reg_;
      END IF;

      -- ��� ������������ ��������
      IF rez_ = 2
      THEN
         k110_ := '00000';                        -- ��� ������. ������������
         p021_ := '2';                            -- ��� ����� �������������
         reg_ := 0;
      END IF;

      select count(*)
         into kol_rnk
      from otcn_f71_cust
      where rnk = rnk_;

      if kol_rnk = 0 then
         INSERT INTO otcn_f71_cust
                     (rnk, okpo, rez, custtype, p010, p020, p025, p040,
                      p050, p055, p060, p085
                     )
              VALUES (rnk_, kod_okpo, rez_, custtype_, p010_, p021_, k110_, '0',
                      TO_CHAR (p050_), TO_CHAR (reg_), LPAD(TO_CHAR (p060_), 2, '0'), k021_
                     );
      end if;

      p_rnk_ := rnk_;
      p_okpo_ := kod_okpo;
   END;

   PROCEDURE p_ins_depozit (ptype_ IN NUMBER)
   IS
-- ������ ���������� ���������� ���������
   BEGIN
      --- ��������� ����������� ����������� ������ ��� ��������� �����������
      IF p_rnk_ IS NULL OR p_rnk_ <> rnk_   --and p_okpo_ <> kod_okpo
      THEN
         p_ins_contr;
      END IF;

      -- �i������ ���� ���������� �����'������ ����� (��������) �����������
      IF sum_k_ <> 0
      THEN
         p150_ :=
              LTRIM (TO_CHAR (ROUND ((ABS (sum_d_) / sum_k_) * 100, 4), fmt_));
      ELSE
         p150_ := '0';
      END IF;

      -- ����������� 3351
      if substr(nls_,1,4) in ('3351')
      then
         begin
            select fx.deal_tag, fx.dat_a
               into p090_, p111p_
            from fx_deal fx
            where fx.ref = ( select min(t.ref)
                             from TMP_VPKLB t
                             where t.sk = rnk_
                             group by t.sk);
         exception when no_data_found then
            null;
         end;

         begin
            select fx.dat_a
               into p112p_
            from fx_deal fx
            where fx.ref = ( select max(t.ref)
                             from TMP_VPKLB t
                             where t.sk = rnk_
                             group by t.sk);
         exception when no_data_found then
            null;
         end;

         --begin
         --   select fx.rnk, min(fx.deal_tag), min(fx.dat_a), max(fx.dat_a)
         --      into rnk_3351, p090_, p111p_, p112p_
         --   from TMP_VPKLB t, fx_deal fx
         --   where t.sk = rnk_
         --      and t.sk = fx.rnk
         --      and t.ref = fx.ref
         --   group by fx.rnk;
         --exception when no_data_found then
         --   null;
         --end;
      end if;

      INSERT INTO otcn_f71_temp
                   (rnk, acc, tp, nd, p090, p080, p081, p110, p111,
                   p112, p113, p160, nbs, kv, ddd, p120, p125, p130,
                   p150, nls, fdat, isp
                  )
        VALUES (rnk_, acc_, ptype_, nd_, p090_, '0', 0, sum_zd_, p111p_,
                   p112p_, p113_, '0', p070_, p140_, ddd_, p120_, 0, p130_,
                   p150_, nls_, data_, isp_
                  );

      --INSERT INTO otcn_fe8_history
      --            (datf, acc, ostf, nd, p090, p110, p111, p112,
      --             p130, rnk
      --            )
      --  VALUES (dat_, acc_, p120_, nd_, p090_, sum_zd_, p111p_, p112p_,
      --             p130_, rnk_
      --            );
   EXCEPTION
      WHEN OTHERS
      THEN
         raise_application_error (-20005,
                                     'rnk='
                                  || rnk_
                                  || ' acc='
                                  || acc_
                                  || ' ������ : '
                                  || SQLERRM
                                 );
   END;
-------------------------------------------------------------------
BEGIN
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_FE8: Begin for datf = '||to_char(dat_, 'dd/mm/yyyy'));

   userid_ := user_id;

   EXECUTE IMMEDIATE 'truncate table otcn_f71_rnk';

   EXECUTE IMMEDIATE 'truncate table rnbu_trace';

-------------------------------------------------------------------
   DELETE FROM otcn_fe8_history WHERE datf = dat_;

   EXECUTE IMMEDIATE 'truncate table OTCN_F71_TEMP';

   EXECUTE IMMEDIATE 'truncate table OTCN_F71_CUST';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_ACC';
-------------------------------------------------------------------
   EXECUTE IMMEDIATE 'alter session set NLS_NUMERIC_CHARACTERS=''.,''';

   dat1_ := TRUNC (dat_, 'MM');

-- �i���� ������������ �i����
   SELECT MAX (fdat)
      INTO dat2_
   FROM fdat
   WHERE fdat < dat1_;

   mfo_ := f_ourmfo ();

-- ��� "��������"
   BEGIN
      SELECT mfou
        INTO mfou_
      FROM banks
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         mfou_ := mfo_;
   END;

   BEGIN
      SELECT SUBSTR (sab, 2, 3)
         INTO sab_
      FROM banks
      WHERE mfo = mfo_;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error
                         (-20009,
                             '� ���_����� ����_� ���� ������ � ����� MFO='''
                          || mfo_
                          || ''''
                         );
   END;

-- ��� �������, ��� ���������� ����
   BEGIN
      b040_ := LPAD (f_get_params ('OUR_TOBO', NULL), 12, 0);

      IF SUBSTR (b040_, 1, 1) IN ('0', '1')
      THEN
         our_reg_ := TO_NUMBER (SUBSTR (b040_, 2, 2));
      ELSE
         our_reg_ := TO_NUMBER (SUBSTR (b040_, 7, 2));
      END IF;

      our_reg_ := NVL (our_reg_, '00');

      if our_reg_ = '00'  then
          begin
           select lpad(to_char(ku),2,'0')   into our_reg_
             from rcukru
            where mfo = mfo_;
          exception
             when others  then  our_reg_ := '00';
          end;
      end if;
   END;

   -- ��� ���� �����
   our_okpo_ :=TRIM (f_get_params ('OKPO', NULL));
   -- ��� RNK �����
   our_rnk_ :=to_number(TRIM (f_get_params ('OUR_RNK', NULL)));

   nnnn_ := 0;
-- ����������� ����� ������������� ��������
   sum_k_ := rkapital (dat_, kodf_, userid_);

-- ��������� ���i���
   BEGIN
      SELECT SUM (DECODE (SUBSTR (kodp, 1, 1), '1', -1, 1) * TO_NUMBER (znap))
         INTO sum_sk_
      FROM v_banks_report
      WHERE datf = dat_
        AND kodf = '01'
        AND SUBSTR (kodp, 2, 5) IN ('05000', '05001', '05002');
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         sum_sk_ := 0;
   END;

   IF NVL (sum_sk_, 0) = 0
   THEN
      sum_sk_ := NVL (TRIM (f_get_params ('NORM_SK', 0)), 0);
   END IF;

   IF NVL (sum_sk_, 0) <> 0 AND sum_sk_ * 0.01 < smax_
   THEN
      smax_ := sum_sk_ * 0.01;
   END IF;

   -- ��� ��������� �� ��������� ������� �������� ���� ��������
   -- � ������� ����� �������� ������ ����� 50000.00
   -- � ����� ��������� �������� ������� � ������� ����� < 200000000 (2 ���.)
   if dat_ >= to_date('30052014','ddmmyyyy') and
      mfo_ in (322669, 311647, 300465, 302076, 303398, 305482)
   then
      smax_ := 5000000;
   end if;


   if prnk_ is null then
       sql_acc_ := 'with tab as (SELECT *
                                 FROM accounts a
                                WHERE     NVL (nbs, SUBSTR (nls, 1, 4)) IN (SELECT r020
                                                                              FROM kl_f3_29
                                                                             WHERE kf = ''E8'')
                                      AND (nls, kv) NOT IN (SELECT nls, kv FROM kf91)) 
                    ';

       if FL_D8_ = '8' then
          sql_acc_ := sql_acc_ || ' select *
                                    from tab
                                    where acc NOT IN (SELECT gen_acc
                                                      FROM v_dpu_rel_acc_all
                                                      WHERE gen_acc IS NOT NULL)   
                                    union all
                                    select *
                                    from tab
                                    WHERE acc = any (SELECT dep_acc
                                                     FROM v_dpu_rel_acc_all
                                                     WHERE gen_acc IS NOT NULL) ';
       else
           sql_acc_ := sql_acc_ || 'select * from tab ';
       end if;

       ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);
   else
       sql_acc_ := 'select * from accounts where rnk = '||to_char(prnk_)||' and nbs in ';
       sql_acc_ := sql_acc_ || '(select r020 from kl_f3_29 where kf=''E8'') ';

       if FL_D8_ = '8' then
          sql_acc_ := sql_acc_ || ' and acc not in (select gen_acc
                                                    from v_dpu_rel_acc_all
                                                    where gen_acc is not null ) ';

          sql_acc_ := sql_acc_ || ' UNION ALL ';

          sql_acc_ := sql_acc_ || ' select distinct a.acc, a.nls, a.kv, substr(a.nlsalt,1,4) nbs,
                                           a.rnk, a.daos, a.dapp, a.isp, a.nms, a.lim, a.pap, a.tip,
                                           a.vid, a.mdate, a.dazs, a.accc, a.tobo
                                    from (select  /*+PARALLEL(8) */ *
                                         from accounts
                                         where rnk = '||to_char(prnk_)||' and
                                               acc in (select dep_acc
                                                        from v_dpu_rel_acc_all
                                                        where gen_acc is not null
                                                       )
                                         ) a ';
       end if;

       ret_ := F_Pop_Otcn(Dat_, 2, sql_acc_, null, 0, 1);
   end if;

   -- ��������� ���� ������ ������ (�� 01/01/2000 - ��������� � ������)
   delete from otcn_saldo where acc in (select acc from accounts where daos < to_date('01012000','ddmmyyyy'));

   INSERT INTO otcn_f71_rnk
                (rnk, ostf)
       SELECT
              rnk, ost
         FROM (SELECT   rnk, SUM (ost) ost
               FROM (SELECT
                            DECODE(mfou_, 300465, DECODE(mfo_, 300465, c.rnk, DECODE(c.rnkp, NULL, c.rnk, c.rnkp)),
                                          353575, DECODE(c.rnkp, NULL, c.rnk, c.rnkp), c.rnk) RNK,
                            decode(v.kv, 980, s.ost - s.dos96 + s.kos96, s.ostq - s.dosq96 + s.kosq96) ost
                           FROM otcn_saldo s, otcn_acc v, customer c
                          WHERE s.acc = v.acc
                            AND s.rnk = v.rnk
                            AND c.rnk = v.rnk
                            AND ( (c.rnk <> our_rnk_ and mfo_ <> 300465) OR
                                  (c.rnk <> 0 and mfo_ = 300465) )
                             AND c.codcagent < 7
                            AND s.ost - s.dos96 + s.kos96 > 0)
            GROUP BY rnk)
         WHERE ABS (ost) >= smax_ ;

   -- ��� ���� �� ��������� ������� �������� ���� ��������
   -- � ������� ����� �������� ������ ����� 2000.00
   -- � ����� ��������� �������� ������� � ������� ����� < 200000000 (2 ���.)
   if dat_ >= to_date('30052014','ddmmyyyy') and mfou_ = 300465 then
      delete from otcn_f71_rnk o
      where o.ostf < 200000000
        and exists (select 1
                    from customer c
                    where c.rnk = o.rnk
                      and c.codcagent in (5,6)
                      and NVL(trim(c.sed),'00')<>'91');
   end if;

   --20,07,2017  �� ����� ��������� ����������� ������� ������
   if mfo_ = 324805 then
      delete from otcn_f71_rnk o where rnk in (29992702, 35051702, 45427002);
   end if;
--------------------------------------------------------------------------
   OPEN saldo;

   LOOP
      FETCH saldo
       INTO acc_, nls_, nbs_, p010_, rnk_, p021_, p030_, rez_, p050_, reg_, ved_,
            p060_, p070_, p111_, p112_, p120_, p140_, data_, tip_,
            custtype_, ddd_, sum_d_, glb_, kb_, p130_BCZ, ostq_no96_;

      EXIT WHEN saldo%NOTFOUND;

      nd_ := NULL;
      nkd_ := 'N ���.';
      p090_ := nkd_;

      begin
        p130_ := acrn_otc.fproc (acc_, dat_);
      exception
        when others then
            p130_ := 0;
            logger.info('NBUR P_FE8_NN acc = '||acc_);
      end;

      -- ����� ���� ��� ����������� ������� �� ����� ������ ��������
      -- �� � ������ �������������� �������� ���� ���������
      if nbs_ in ('2600','2605','2620','2625','2650','2655') and
         p120_ > 0 and ostq_no96_ < 0
      then
         begin
         select i.ir
            into p130_
         from int_ratn i
         where i.acc = acc_
           and i.id = 1
           and i.bdat = ( select max(bdat)
                          from int_ratn
                          where acc=acc_
                            and id =1
                            and bdat <= dat_
                         );
         exception
            when others  then p130_ := 0;
         end;
      end if;

      if mfo_ = 324485 then
         glb_ := 81;
      end if;

      if mfo_ = 325569 then
         glb_ := 93;
      end if;

      -- ���������� ���� ������� �������� �� ����� ������ ���� �������� �����
      if mfo_ <> 302076 then
         BEGIN
            SELECT min(fdat)
               INTO p111_
            FROM saldoa
            WHERE acc=acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            null;
         END;
      end if;

      -- �� ������ ��������
      IF nls_ LIKE '1%' THEN
        BEGIN
           SELECT NVL (nd, -1)
           INTO p_nd_
           FROM mbd_k_a
           WHERE acc = acc_
             AND (sdate, nd) = (SELECT MAX (sdate), MAX (nd)
                                FROM mbd_k_a
                                WHERE acc = acc_ AND sdate <= dat_);
        EXCEPTION WHEN NO_DATA_FOUND THEN
          p_nd_ := NULL;
        END;
      ELSE
         BEGIN                  -- �� ������ ��������
           SELECT MAX (NVL (deposit_id, -1))
             INTO p_nd_
           FROM dpt_deposit
           WHERE acc = acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            BEGIN            -- �� ������ ��������
               SELECT MAX (NVL (dpu_id, -1))
                INTO p_nd_
               FROM dpu_deal
               WHERE acc = acc_;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               p_nd_ := NULL;
            END;
         END;
      END IF;

      if Dat_ > dat_izm3 and (nls_ like '270%' or nls_ like '366%')
      then
         BEGIN
            select nd
               into p_nd_
            from nd_acc
            where acc = acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            null;
         END;
      end if;

      s04_ := 0;
      f91_ := 0;

      IF f91_ = 0
      THEN
         pog_ := FALSE;

         -- ��� �����������
         kod_okpo := LPAD (TRIM (p030_), 10, '0');

         -- ���������� N �������� �� SPECPARAM nkd
         BEGIN
            SELECT NVL(nkd, 'N ���.'), NVL(r013, '0')
               INTO nkd_, r013_
            FROM specparam
            WHERE acc = acc_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            nkd_ := 'N ���.';
            r013_ := '0';
         END;

        -- ��������� ������ ��������� ��������
        -- ��������� ����� ����� �� 1 ��������
         sum_71 := 0;
         sum_71o:= 0;
         sum_lim:= 0;

         --- ��������� ������ 1 ������ (������������� ��������)
         IF nls_ LIKE '1%' THEN  --AND p060_ in ('1','2')
            BEGIN
               IF pog_ AND p120_ = 0 THEN
                  SELECT NVL (cc_id, nkd_), sdate, wdate, nd,
                         gl.p_icurval (kv, LIMIT, dat_) * 100
                     INTO p090_, p111p_, p112p_, nd_,
                          sum_zd_
                  FROM mbd_k_a
                  WHERE acc = acc_ AND nd = p_nd_;
               ELSE
                  SELECT n.nd, NVL (n.cc_id, nkd_), n.vidd
                     INTO nd_, p090_, vidd_
                  FROM mbd_k_a n
                  WHERE n.acc = acc_
                    AND (n.sdate, n.nd) =
                                         (SELECT MAX (sdate), MAX (nd)
                                          FROM mbd_k_a
                                          WHERE acc = acc_ AND sdate <= dat_);

                  --- ����� ����� �� ������ ��������
                  BEGIN
                     SELECT NVL(SUM(ABS(decode(s.kv, 980, s.ost - s.dos96 + s.kos96,
                                                          s.ostq - s.dosq96 + s.kosq96))),0)
                        INTO sum_71
                     FROM mbd_k_a p, otcn_saldo s
                     WHERE p.nd = nd_
                       AND p.acc = s.acc;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     sum_71 := ABS (p120_);
                  END;

               END IF;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               nd_ := NULL;
            WHEN OTHERS THEN
               raise_application_error (-20001,
                                              'acc='
                                           || acc_
                                           || ' ������ : '
                                           || SQLERRM
                                          );
            END;
         elsif nls_ LIKE '3%' then
            sum_71 := ABS (p120_);
            nd_ := NULL;
            p090_ := nkd_;
            vidd_ := NULL;
         ELSE
            BEGIN
               IF p120_ = 0 THEN
                  SELECT n.deposit_id, nvl(TRIM (n.nd), nkd_), n.vidd
                     INTO nd_, p090_, vidd_
                  FROM dpt_deposit n
                  WHERE n.acc = acc_
                    AND n.acc NOT IN (SELECT acc
                                      FROM dpt_deposit_clos a
                                      WHERE a.deposit_id = n.deposit_id);
               ELSE
                  BEGIN
                     SELECT n.deposit_id, nvl(TRIM (n.nd), nkd_), n.vidd
                        INTO nd_, p090_, vidd_
                     FROM dpt_deposit n
                     WHERE n.acc = acc_;

                     --- ����� ����� �� ������ ��������
                     BEGIN
                        SELECT NVL(SUM(ABS(decode(s.kv, 980, s.ost - s.dos96 + s.kos96,
                                                          s.ostq - s.dosq96 + s.kosq96))),0)
                           INTO sum_71
                        FROM dpt_deposit p, otcn_saldo s
                        WHERE p.deposit_id = nd_
                          AND p.acc = s.acc;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        sum_71 := ABS (p120_);
                     END;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     SELECT n.deposit_id, nvl(TRIM (n.nd), nkd_), n.vidd
                        INTO nd_, p090_, vidd_
                     FROM dpt_deposit_clos n
                     WHERE n.acc = acc_
                       and n.action_id in (1,2);

                     --- ����� ����� �� ������ ��������
                     BEGIN
                        SELECT NVL(SUM(ABS(decode(s.kv, 980, s.ost - s.dos96 + s.kos96,
                                                          s.ostq - s.dosq96 + s.kosq96))),0)
                           INTO sum_71
                        FROM dpt_deposit_clos p, otcn_saldo s
                        WHERE p.deposit_id = nd_
                          AND p.action_id in (1,2)
                          AND p.acc = s.acc;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        sum_71 := ABS (p120_);
                     END;
                  END;
               END IF;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               BEGIN
                  -- �������� ��
                  IF p120_ = 0 THEN
                     SELECT n.dpu_id, nvl(TRIM (n.nd), nkd_), n.vidd
                        INTO nd_, p090_, vidd_
                     FROM dpu_deal n
                     WHERE n.acc = acc_ AND n.closed = 1 AND rownum = 1;
                  ELSE
                     SELECT n.dpu_id, nvl(TRIM (n.nd), nkd_), n.vidd
                        INTO nd_, p090_, vidd_
                     FROM dpu_deal n
                     WHERE n.acc = acc_ AND rownum = 1;

                     --- ����� ����� �� ������ ��������
                     BEGIN
                        SELECT NVL(SUM(ABS(decode(s.kv, 980, s.ost - s.dos96 + s.kos96,
                                                          s.ostq - s.dosq96 + s.kosq96))),0)
                           INTO sum_71
                        FROM dpu_deal p, otcn_saldo s
                        WHERE p.dpu_id = nd_
                          AND p.acc = s.acc;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        sum_71 := ABS (p120_);
                     END;

                  END IF;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  nd_ := NULL;
               WHEN OTHERS THEN
                  raise_application_error (-20002,
                                           'acc='
                                                 || acc_
                                                 || ' ������ : '
                                                 || SQLERRM
                                                );
               END;
            END;
         END IF;

         sum_71 := NVL (sum_71, 0);

        -- ���� ����� ����� �� �������� ������ ����� �� �����
         IF sum_71 < ABS (p120_)
         THEN
            sum_71 := ABS (p120_);
         END IF;

        -- ��������� ������ ���������� � ������������ ����� �������� ��� ��������
         IF (sum_71 >= 0 OR pog_)   --p060_ in ('1','2') AND
         THEN
            IF nls_ LIKE '1%' THEN
               BEGIN
                  SELECT NVL (cc_id, nkd_), sdate, wdate
                    INTO p090_, p111p_, p112p_
                    FROM mbd_k_a
                   WHERE acc = acc_ AND nd = nd_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                  p090_ := nkd_;
                  p111p_ := p111_;
                  p112p_ := p112_;
               END;
            elsif nls_ LIKE '3%' THEN
                if nbs_ in ('3660','3661') then
                   -- ���� ��������� �����
                   begin
                       SELECT to_date(SUBSTR (trim(VALUE), 1, 8), 'ddmmyyyy')
                          INTO p111p_
                       FROM accountsw c
                       WHERE c.acc = acc_ and
                            trim(tag) = 'D#79_02';
                   exception
                       WHEN NO_DATA_FOUND THEN
                          p111p_ := p111_;
                   end;

                   -- ���� ���_������ �_� �����
                   begin
                       SELECT to_date(SUBSTR (trim(VALUE), 1, 8), 'ddmmyyyy')
                          INTO p112p_
                       FROM accountsw c
                       WHERE c.acc = acc_ and
                            trim(tag) = 'D#79_03';
                   exception
                       WHEN NO_DATA_FOUND THEN
                          p112p_ := p112_;
                   end;
                else
                    SELECT c.daos, c.mdate
                       INTO p111p_, p112p_
                    FROM accounts c
                    WHERE c.acc = acc_;
                end if;

                if Dat_ > dat_izm3 and nls_ like '366%'
                then
                   BEGIN
                      SELECT c.nd, NVL (c.cc_id, nkd_), c.sdate, c.wdate
                         INTO nd_, p090_, p111p_, p112p_
                      FROM cc_deal c
                      WHERE c.nd = p_nd_;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      null;
                   END;
                end if;
            ELSE
               BEGIN
                 SELECT NVL (c.nd, nkd_), c.datz, c.dat_end  --c.dat_begin, c.dat_end
                    INTO p090_, p111p_, p112p_
                 FROM dpt_deposit c
                 WHERE c.deposit_id = nd_;
               EXCEPTION WHEN NO_DATA_FOUND THEN
                 BEGIN
                    SELECT NVL (c.nd, nkd_), c.datz, c.dat_end  --c.dat_begin, c.dat_end
                       INTO p090_, p111p_, p112p_
                    FROM dpt_deposit_clos c
                    WHERE c.deposit_id = nd_
                      and c.action_id in (1,2);
                 EXCEPTION WHEN NO_DATA_FOUND THEN
                    BEGIN
                       SELECT NVL (c.nd, nkd_), c.datz, c.dat_end
                          INTO p090_, p111p_, p112p_
                       FROM dpu_deal c
                       WHERE c.dpu_id = nd_;
                    EXCEPTION WHEN NO_DATA_FOUND THEN
                       BEGIN
                          SELECT NVL (trim(c.value), nkd_)
                             INTO p090_
                          FROM customerw c
                          WHERE c.rnk = rnk_
                            and c.tag='RKO_N';
                       EXCEPTION WHEN NO_DATA_FOUND THEN
                          p090_ := nkd_;
                       END;

                       BEGIN
                          SELECT NVL (to_date(substr(replace(replace(trim(c.value), ',','/'),'.','/'),1,10), 'dd/mm/yyyy'), p111_),
                                 null
                             INTO p111p_, p112p_
                           FROM customerw c
                           WHERE c.rnk = rnk_
                             and c.tag='RKO_D';
                       EXCEPTION WHEN NO_DATA_FOUND THEN
                          BEGIN
                             SELECT c.daos, c.mdate
                                INTO p111p_, p112p_
                             FROM accounts c
                             WHERE c.acc = acc_;
                          EXCEPTION WHEN NO_DATA_FOUND THEN
                             p111p_ := p111_;
                             p112p_ := p112_;  --null;
                          END;
                       WHEN OTHERS THEN
                       raise_application_error (-20001,
                                                   'RNK = '
                                                 || rnk_
                                                 || ' ������ : '
                                                 || SQLERRM
                                          );
                       END;
                    END;
                 END;
               END;

               if Dat_ > dat_izm3 and nls_ like '270%'
               then
                  BEGIN
                     SELECT c.nd, NVL (c.cc_id, nkd_), c.sdate, c.wdate
                        INTO nd_, p090_, p111p_, p112p_
                     FROM cc_deal c
                     WHERE c.nd = p_nd_;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     null;
                  END;
               end if;

               if nls_ LIKE '260%' OR (nls_ like '2650%' and r013_ !='8')
                 OR (nls_ like '2655%' and r013_ != '1')
               then
                 p112p_ := null;
               end if;

            END IF;

            IF SUBSTR (nls_, 4, 1) = '8'  AND SUBSTR (nbs_, 4, 1) = '8' THEN
               IF nls_ LIKE '1%' THEN
                  BEGIN
                     SELECT n.nd, NVL (n.cc_id, nkd_), n.sdate, n.wdate
                        INTO nd_, p090_, p111p_, p112p_
                     FROM mbd_k_a n, int_accn r
                     WHERE r.ID = 1
                       AND r.acra = acc_
                       AND n.acc = r.acc
                       AND (n.sdate, n.nd) = (SELECT MAX (sdate), MAX (nd)
                                              FROM mbd_k_a
                                              WHERE acc = n.acc
                                                AND sdate <= dat_)
                       AND rownum = 1;
                  EXCEPTION WHEN NO_DATA_FOUND THEN
                     nd_ := NULL;
                     p090_ := nkd_;
                     p111p_ := p111_;
                     p112p_ := p112_;
                  END;
               ELSE
                  if nls_ not like '260%' AND nls_ not like '2650%' AND
                     nls_ not like '2655%'
                  then
                     BEGIN
                        SELECT n.deposit_id, NVL (n.nd, nkd_), n.datz,
                               n.dat_end
                           INTO nd_, p090_, p111p_,
                                p112p_
                        FROM dpt_deposit n, int_accn r
                        WHERE r.ID = 1
                          AND r.acra = acc_
                          AND n.acc = r.acc
                          AND ROWNUM = 1;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        BEGIN
                           SELECT n.deposit_id, NVL (n.nd, nkd_), n.datz,
                                  n.dat_end
                              INTO nd_, p090_, p111p_,
                                  p112p_
                           FROM dpt_deposit_clos n, int_accn r
                           WHERE r.ID = 1
                             AND r.acra = acc_
                             AND n.acc = r.acc
                             AND n.action_id in (1,2)
                             AND ROWNUM = 1;
                        EXCEPTION WHEN NO_DATA_FOUND THEN
                           BEGIN
                              SELECT n.dpu_id, NVL (n.nd, nkd_), n.datz,
                                     n.dat_end
                                 INTO nd_, p090_, p111p_,
                                     p112p_
                              FROM dpu_deal n, int_accn r
                              WHERE r.ID = 1
                                AND r.acra = acc_
                                AND n.acc = r.acc
                                AND ROWNUM = 1;
                           EXCEPTION WHEN NO_DATA_FOUND THEN
                              BEGIN
                                 SELECT NVL (c.nd, nkd_), c.datz, c.dat_end
                                    INTO p090_, p111p_, p112p_
                                 FROM dpu_deal c
                                 WHERE c.dpu_id = nd_;
                              EXCEPTION WHEN NO_DATA_FOUND THEN
                                 nd_ := NULL;
                                 p090_ := nkd_;
                                 p111p_ := p111_;
                                 p112p_ := p112_;
                              END;
                           END;
                        END;
                     END;
                  end if;

                  if nls_ like '260%' OR nls_ like '2650%' OR nls_ like '2655%' then
                     BEGIN
                        SELECT NVL (trim(c.value), nkd_)
                           INTO p090_
                        FROM customerw c, int_accn r, otcn_acc k
                        WHERE r.id=1
                          and r.acra = acc_
                          and k.acc=r.acc
                          and k.rnk=c.rnk
                          and c.rnk = rnk_
                          and c.tag='RKO_N'
                          and rownum=1 ;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        p090_ := nkd_;
                     END;

                     BEGIN
                        SELECT NVL (to_date(trim(c.value),'dd.mm.yyyy'), p111_),
                               null
                           INTO p111p_, p112p_
                        FROM customerw c, int_accn r, otcn_acc k
                        WHERE r.id = 1
                          and r.acra = acc_
                          and k.acc=r.acc
                          and k.rnk=c.rnk
                          and c.rnk = rnk_
                          and c.tag='RKO_D'
                          and rownum=1 ;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        p111p_ := p111_;
                        p112p_ := null;
                     END;
                  end if;

                  if Dat_ > dat_izm3 and (nls_ like '270%' or nls_ like '366%')
                  then
                     BEGIN
                        SELECT c.nd, NVL (c.cc_id, nkd_), c.sdate, c.wdate
                           INTO nd_, p090_, p111p_, p112p_
                        FROM cc_deal c
                        WHERE c.nd = p_nd_;
                     EXCEPTION WHEN NO_DATA_FOUND THEN
                        null;
                     END;
                  end if;

               END IF;
            END IF;

            -- ������ ���������� ����������� ��������
            p_ins_depozit (2);
         END IF;
      END IF;
   END LOOP;

   CLOSE saldo;

   nnnn_ := 1;

   OPEN c_cust;

   LOOP
      FETCH c_cust
       INTO rnk_, kod_okpo, rez_, custtype_, p010_, p020_, k110_, p050_,
            reg_, p060_, k021_;

      EXIT WHEN c_cust%NOTFOUND;

      p_rnk_ := NULL;
      p_nd_ := NULL;
      p_p090_ := '------';

      sum_d_ := 0;

      select count(*)
         into kolz_
      from rnbu_trace
      where substr(kodp,4,10)=kod_okpo;

      if kolz_ = 0 then
         BEGIN
            select 1
               into glb_
            from custbank
            where rnk = rnk_;
         EXCEPTION WHEN NO_DATA_FOUND THEN
            glb_ := 0;
         END;

          if rez_ in (2,4,6) then  --and substr(kod_okpo,1,1) != 'I' then
             okpo_nerez := trim(kod_okpo);
             if mfo_ = 324805 and substr(kod_okpo,1,1) <> 'I' then
                kod_okpo := 'I'||LPAD (to_char(rnk_), 9, '0');
             end if;

             if length(okpo_nerez) > 8 then
                kodp_ := kod_okpo || '0000' || '0000' || '000' || k021_;
                -- ��� ���� �����������
                p_ins ('019' || kodp_, okpo_nerez);
             end if;
          end if;

          -- ��� ����?� ��������?�
          IF custtype_ = 2 and rez_ = 1 then
             BEGIN
                select NVL(rc.nb, p010_)
                   into p010_
                from custbank cb, rcukru rc
                where cb.rnk = rnk_
                  and cb.mfo = rc.mfo;
                k021_ := '3';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                null;
             END;
          END IF;

          -- ��� ����?� ����������?�
          IF custtype_ = 2 and rez_ = 2 then
             BEGIN
                select NVL(rc.name, p010_)
                   into p010_
                from custbank cb, rc_bnk rc
                where cb.rnk = rnk_
                  and cb.alt_bic = rc.b010;
                k021_ := '4';
             EXCEPTION WHEN NO_DATA_FOUND THEN
                null;
             END;
          END IF;

          kodp_ := kod_okpo || '0000' || '0000' || '000' || k021_;

          -- �������� �����������
          -- �������� ��������� 434 �� 18.12.2008 ��� �� � �� ����������������
          -- �������� ����������� �� �����������
          if custtype_ in (1, 3) then
             if 300465 in (mfo_, mfou_) then
                p_ins ('010' || kodp_, '�_����� �����');
             else
                p_ins ('010' || kodp_, '');
             end if;
          else
             p_ins ('010' || kodp_, p010_);
          end if;

          -- ����������� �� 01.10.2013
          -- �� 01.10.2014 ����� ����� �������������
          if dat_ <= dat_izm1 OR dat_ > to_date('29092014','ddmmyyyy')
          then
             -- ��� ������� ��������� K074
             p_ins ('021' || kodp_, p020_);
          end if;
          -- ��� ������������� ������������
          p_ins ('025' || kodp_, k110_);
          -- ��� ������
          p_ins ('050' || kodp_, LPAD (TO_CHAR (p050_),3,'0'));

          -- ��� �������
          if custtype_ in (1, 3) then
             p_ins ('055' || kodp_, '0');
          else
             p_ins ('055' || kodp_, TO_CHAR (reg_));
          end if;

          -- ������� ���������
          p_ins ('060' || kodp_, LPAD (TO_CHAR (p060_), 2, '0'));
          -- ������ �����������/i��������
          p_ins ('206' || kod_okpo || '0000' || '0000' || '000' || k021_,
                 TO_CHAR (custtype_));
      end if;

      OPEN c_cust_dg;

      LOOP
         FETCH c_cust_dg
          INTO acc_, nd_, p090_, sum_zd_, p111_, p112_, p113_, p070_, nls_,
               p140_, ddd_, p120_, p130_, p150_;

         EXIT WHEN c_cust_dg%NOTFOUND;

         if mfo_=333368 and ddd_='123' then
            select NVL(sum(GL.P_ICURVAL(p140_, s.kos, s.fdat)),0)
               into kos_
            from sal s
            where s.acc=acc_
              and fdat BETWEEN Dat1_ and Dat_;

            if kos_ <> 0 then
               p120_ := kos_;
            end if;
         end if;

         if p120_ <> 0 then
             IF    (p_nd_ IS NULL AND p_p090_ = '------')
                OR (p_nd_ IS NULL AND nd_ IS NULL AND p090_ <> p_p090_)
                OR (    p_nd_ IS NULL
                    AND nd_ IS NULL
                    AND p090_ = p_p090_
                    AND p090_ = 'N ���.'
                   )
                OR (p_nd_ IS NOT NULL AND nd_ IS NOT NULL AND p_nd_ <> nd_)
                OR (p_nd_ IS NULL AND nd_ IS NOT NULL)
                OR (p_nd_ IS NOT NULL AND nd_ IS NULL)
             THEN
                kod_nnnn := LPAD (TO_CHAR (nnnn_), 4, '0');

                if custtype_ in (1, 2) then
                   BEGIN
                      select NVL(deb02, p111_), NVL(deb03, p112_), NVL(ob22,'00')
                         into p111_, p112_, ob22_
                      from specparam_int
                      where acc=acc_;
                   EXCEPTION WHEN NO_DATA_FOUND THEN
                      null;
                   END;
                end if;

                if p070_ = '8021' then
                   p070_ := '2620';
                   p112_ := null;
                end if;

                if p070_ = '8022' then
                   p070_ := '2625';
                end if;

                if mfou_ = 300465 and ((p070_ like '25%' and p070_ not in ('2525','2546')) or
                                       (p070_='2600' and ob22_='01') or
                                       (p070_ in ('2560','2561','2562','2565','2568','2601',
                                                  '2602','2603','2604','2605','2608','2625',
                                                  '2628','2655')) or
                                       ((p070_='2650' or p070_='2658') and ob22_='01') or
                                       (p070_='2620' and ob22_ in ('05','07','17','20','21','22','28','29')))
                then
                   p112_ := null;
                end if;

                -- _������_����� ��������
                p_ins ('090' || kod_okpo || kod_nnnn || '0000' || '000' || k021_, p090_,
                       nls_
                      );

                -- ���� ���������� �����'������ ����� (��������)
                p_ins ('111' || kod_okpo || kod_nnnn || '0000' || '000' || k021_,
                       TO_CHAR (p111_, dfmt_),
                       nls_
                      );

                if mfou_ = 300465 and ( ( p070_ like '25%' and p070_ not in ('2525','2546')) or
                                        ( p070_ in ('1600','1919','2525','2546','2600',
                                                    '2602','2603','2604','2605','2608',
                                                    '2620','2625','2628','2650','2655','2658')
                                        )
                                      )
                   and p112_ is not null then

                   -- ���� ��������� �����'������ ����� (��������) ��i��� � ���������
                   p_ins ('112' || kod_okpo || kod_nnnn || '0000' || '000' || k021_,
                          TO_CHAR (p112_, dfmt_),
                          nls_
                         );
                end if;
                if mfou_ <> 300465 or
                   ( mfou_ = 300465 and p070_ not like '25%'
                                    and p070_ not in ('1600','1919','2600','2601',
                                                      '2602','2603','2604','2605',
                                                      '2608','2620','2625','2628',
                                                      '2650','2655','2658') ) or
                   (mfou_ = 300465 and p070_ in ('2525','2546') )
                then
                   -- ���� ��������� �����'������ ����� (��������) ��i��� � ���������
                   p_ins ('112' || kod_okpo || kod_nnnn || '0000' || '000' || k021_,
                          TO_CHAR (p112_, dfmt_),
                          nls_
                         );
                end if;

                nnnn_ := nnnn_ + 1;

             END IF;

             IF ddd_ = '122'
             THEN
                -- ������� �� ����_� �������� �_ ������
                p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || LPAD (TO_CHAR (p140_), 3, '0') || k021_,
                       TO_CHAR (p120_),
                       nls_
                      );
                sum_d_ := sum_d_ + p120_;
             ELSE
                 p_ins (ddd_ || kod_okpo || kod_nnnn || p070_ || LPAD (TO_CHAR (p140_), 3, '0') || k021_,
                       TO_CHAR (ABS (p120_)),
                       nls_
                      );
                 sum_d_ := sum_d_ + ABS(p120_);
             END IF;

             -- ��������� ������ �� ���������
             p_ins ('130' || kod_okpo || kod_nnnn || '0000' || LPAD (TO_CHAR (p140_), 3, '0') || k021_,
                    LTRIM (TO_CHAR (p130_, fmt_)),
                    nls_
                    );
         end if;

         p_nd_ := nd_;
         p_sum_zd_ := sum_zd_;
         p_p111_ := p111_;
         p_p112_ := p112_;
         p_p090_ := p090_;

      END LOOP;

      CLOSE c_cust_dg;

      if dat_ < dat_izm2
      then
         p150_ :=
                 LTRIM (TO_CHAR (ROUND ((ABS (sum_d_) / sum_k_) * 100, 4), fmt_));
         -- �i������ ���� ���������� �����'������ ����� (��������) �����������
         p_ins ('150' || kod_okpo || '0000' || '0000' || '000' || k021_, p150_);
      end if;
   END LOOP;

       p_rnk_ := rnk_;

   CLOSE c_cust;

----------------------------------------------------
   DELETE FROM tmp_nbu
         WHERE kodf = kodf_ AND datf = dat_;

----------------------------------------------------
   OPEN basel;

   LOOP
      FETCH basel
       INTO kodp_, znap_;

      EXIT WHEN basel%NOTFOUND;

      BEGIN
         INSERT INTO tmp_nbu
                     (kodf, datf, kodp, znap
                     )
              VALUES (kodf_, dat_, kodp_, znap_
                     );
      EXCEPTION
         WHEN OTHERS
         THEN
            raise_application_error (-20002,
                                     '������: ' || SQLERRM || ' kodp:'
                                     || kodp_
                                    );
      END;
   END LOOP;

   CLOSE basel;
----------------------------------------
   if mfou_ = 300120 then
      for k in ( select acc, znap
                 from rnbu_trace
                 where kodp like '130%'
                   and substr(nls,1,3) in ('261','262','263')
               )

         loop

            select nvl(sum(ostq*(ndat - bdat)*ir)/sum(decode(ostq,0,(ndat - bdat),ostq*(ndat - bdat))), k.znap)
               into znap_
            from (
                  select fost(i.acc,i.bdat-1) ostq, dat1_ bdat, i.bdat ndat, acrn_otc.fprocn(i.acc, i.id, i.bdat-1) ir
                  from int_ratn i
                  where i.acc = k.acc and
                        i.id = 1 and
                        i.bdat in (select min(bdat)
                                   from int_ratn
                                   where acc=i.acc and
                                         to_char(bdat,'MMYYYY')=to_char(dat_,'MMYYYY') )
                  UNION ALL
                  select ostq, decode(bdat, daos, bdat+1, bdat) bdat,
                         nvl(lead(bdat) over (partition by acc order by bdat), dat_+1) ndat, ir
                  from (select fost(i.acc,i.bdat) ostq, i.acc, i.bdat,
                               acrn_otc.fprocn(i.acc, i.id, i.bdat) ir,
                               a.daos daos
                        from int_ratn i, accounts a
                        where i.acc = k.acc and
                              i.id = 1 and
                              i.bdat between dat1_ and dat_ and
                              i.acc = a.acc
                       )
                 );

            update rnbu_trace set znap = znap_
            where acc = k.acc and
                  kodp like '130%';

         end loop;

   end if;

   OPEN basel1;

   LOOP
      FETCH basel1
       INTO kodp_, znap_;

      EXIT WHEN basel1%NOTFOUND;
      znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_) / 10000, fmt_));

      INSERT INTO tmp_nbu
                  (kodf, datf, kodp, znap
                  )
           VALUES (kodf_, dat_, kodp_, znap_
                  );
   END LOOP;

   CLOSE basel1;
-----------------------------------------
   OPEN basel2;

   LOOP
      FETCH basel2
       INTO kodp_, znap_;

      EXIT WHEN basel2%NOTFOUND;

      IF SUBSTR (kodp_, 1, 3) = '150'
      THEN
         znap_ := LTRIM (TO_CHAR (TO_NUMBER (znap_), fmt_));
      END IF;

      INSERT INTO tmp_nbu
                  (kodf, datf, kodp, znap
                  )
           VALUES (kodf_, dat_, kodp_, znap_
                  );
   END LOOP;

   CLOSE basel2;

   logger.info ('P_FE8: End for datf = '||to_char(dat_, 'dd/mm/yyyy'));
----------------------------------------
END p_fe8_nn;
/