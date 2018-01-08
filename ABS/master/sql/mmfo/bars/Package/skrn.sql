 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/skrn.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
 CREATE OR REPLACE PACKAGE SKRN
IS
/*

  ����� ���������� ���������� ���������� ������
  version 6.1 25/04/2012

  ��������� � TOBO_PARAMS
  DEP_KAS - ���� �����
  DEP_S1  - ���� ���������� 9898
  DEP_S2  - ���� ���������� 9819
  DEP_S3  - ���� 6519 (�� ������� ����� ������ 6119)
  DEP_S4  - ���� 3600
  DEP_S5  - ������� 2909 ��� ��������� ���
  DEP_S6  - ������� 3579
  DEP_S7  - ������� ���� ��� �������� ��� 6519 (�� ������� ����� ������ 6119)
  DEP_S9  - ������� ��� ������������� ����� �� ��������� 2909
  DEP_S10  - ������� ��� ������������� ������ 6397

  ��������� � PARAMS
  SKRNPAR1=1 - �� ���������� ������ ����� �� ��� (�������������,������������)
  SKRNPAR2=1 - ������������ �������������� ���� ���������
  SKRNPAR3=1 - ��� �������� � ����� ��������� ���������
*/
   header_version_        VARCHAR2 (30)            := 'version 6.2 24/05/2017';

   skrnpar1_   NUMBER := 0;
   skrnpar2_   NUMBER := 0;
   skrnpar3_   NUMBER := 0;
   skrnpar4_   NUMBER := 0;

   FUNCTION header_version RETURN VARCHAR2;

   FUNCTION body_version RETURN VARCHAR2;

   -- ������� � �������� ������������� �����
   PROCEDURE operw_ul (ref_ NUMBER);

   -- ������� � �������� ������������� ������
   PROCEDURE operw_fl (ref_ NUMBER);

   -- ��������� ������� ������
   PROCEDURE p_tariff (tariff_code_ NUMBER, dat11_ DATE, dat12_ DATE, bdate_ DATE);

   -- �������� ������ �� �������������� ����� 8 ������
   PROCEDURE p_tariff2 (n_sk_ NUMBER, dat11_ DATE, dat12_ DATE, bdate_ DATE);

   -- ����� ����� ��� �������������� �������� �� ������
   PROCEDURE p_dep_skrn ( dat_    DATE, dat2_   DATE, n_sk_   NUMBER, mode_   NUMBER, par_    NUMBER DEFAULT NULL, p_userid NUMBER DEFAULT NULL, p_sum number default null, p_extnd varchar2 DEFAULT NULL);

   -- ������� ������������� �� ���������� 3600
   PROCEDURE p_cleanup (DUMMY NUMBER);

   -- ������ ������ �� ���������� �������� ����� (������ �������)
   PROCEDURE p_calc_tariff (n_sk_ NUMBER, par_ number default null);

   -- ������ ������ �� ������ ������ �� ����� ������ �� ���� ����
   PROCEDURE p_calcperiod_tariff (dat1_ DATE, dat2_ DATE, nd_ NUMBER, par_ number default null);

   --  ������ ����������
   PROCEDURE overdue_payment(  dat_    DATE,  dat2_   DATE,  n_sk_   NUMBER, mode_   NUMBER,  par_    NUMBER );

   --! ����� ������� ������� �� ������ (���, ������ �������� �������, ������ �������� ��������)
   FUNCTION f_get_opl_sum (nd_ NUMBER) RETURN NUMBER;

   --! ����� ����� ������� ������������� ������� (�����) = ���� ������ - ����� ������� �������
   FUNCTION f_get_borg_sum (nd_ NUMBER) RETURN NUMBER;

   --! �������� ����� ������ = ����� ������ �� ������ �������� �� ������� ����
   FUNCTION f_get_oplplan_sum (nd_ NUMBER) RETURN NUMBER;

   --! �������� ����� ������ = ����� ������ �� ������ �������� �� ������� ����
   FUNCTION f_get_oplplan_sum_4date (nd_ NUMBER, dt_term DATE) RETURN NUMBER;

   --! �������� ����� ������ = ����� ������ �� �� ������
   FUNCTION f_get_oplplan_sum_4period (nd_ NUMBER, dt_start DATE, dt_end DATE) RETURN NUMBER;

   --! ����� ������� �� ����� ������� �������� ��������
   FUNCTION f_get_3600_sum (nd_ NUMBER) RETURN NUMBER;

   --! ����� ������� �� ����� ���
   FUNCTION f_get_nds_sum (nd_ NUMBER) RETURN NUMBER;

   --! ����� ������� �� ����� ������� �������� �������
   FUNCTION f_get_curdoh_sum (nd_ NUMBER) RETURN NUMBER;

   --! ����� ���������������� ������� �������� ��������
   FUNCTION f_get_amort3600_sum (nd_ NUMBER) RETURN NUMBER;

   --! ������ ���� ������ �� ��������
   FUNCTION f_get_peny(nd_ NUMBER) RETURN NUMBER;

   -- 1 - ������� �������� �����������, 0 - �
   FUNCTION f_amort_needed RETURN NUMBER;

   --! ������ ���� ������ �� �������� ��������
   FUNCTION f_get_peny_literal(nd_ NUMBER) RETURN VARCHAR2;

   -- �������� ����������-���������� ������
   PROCEDURE initparams (par_ NUMBER);
   PROCEDURE setparams (par_ VARCHAR2, val_ VARCHAR2);

   -- ������������� ����������-���������� ������
   PROCEDURE init (parn_ NUMBER);

------------------------------------------------------------------------------------------------------------------------------
   -- �� ����������Ӫ����
   FUNCTION get_par (par_ NUMBER) RETURN VARCHAR2;
   -- �� ����������Ӫ����
   FUNCTION f_getnextdat (n_sk_ NUMBER, dat11_ DATE, s_ NUMBER) RETURN NUMBER;
   -- �� ����������Ӫ����
   PROCEDURE p_prepare_ptotocol (dat_ DATE, dat2_ DATE, n_sk_ NUMBER, mode_ NUMBER, par_ NUMBER DEFAULT NULL);
   -- �� ����������Ӫ����
   FUNCTION f_get_protocol_line RETURN VARCHAR2;

END skrn;
/
CREATE OR REPLACE PACKAGE BODY SKRN
-- *******************************************************************************
IS
   version_   constant  varchar2(30)   := 'version 6.15 24/05/2017';
   body_awk   constant  varchar2(512)  := ''
    ||'IND_ACC' ||chr(10)
    ||'M_AMORT' ||chr(10)
    ||'PRLNG' ||chr(10)
    ||'AMORT_NAZN' ||chr(10)
    ||'RENT' ||chr(10)
    ||'AUTO_PRLNG' ||chr(10)
    ||'FINAL_AMORT' ||chr(10)
    ||'UPB_PENALTY' ||chr(10)
    ||'FULL_AMORT' ||chr(10)
    ||'AMORT_DATE' ||chr(10)
    ||'SBER' ||chr(10)
    ||'OBU' ||chr(10)
  ;

   newnd_          NUMBER;
   oldnd_          NUMBER;
   tt_             CHAR (3);
   tt2_            CHAR (3);
   tt3_            CHAR (3);
   vob_            oper.vob%TYPE            := 6;
   vob2_           oper.vob%TYPE            := 6;
   vob3_           oper.vob%TYPE            := 6;
   itemname_       skrynka_menu.NAME%TYPE;
   s_              NUMBER;
   sz_             NUMBER;
   kv_             NUMBER                   := 980;
   userid_         NUMBER;
   okpok_          VARCHAR2 (14);
   -- ������� �������
   nls2909_        VARCHAR2 (15);
   nms2909_        accounts.nms%TYPE;
   nlss2909_       VARCHAR2 (15);
   nmss2909_       accounts.nms%TYPE;
   ostc2909_       NUMBER;

   nlss3579_       VARCHAR2 (15);
   nmss3579_       accounts.nms%TYPE;

   -- ������� ��� ������ ( ����������) - ���. ���
   nls6397_      accounts.nls%type;
   nms6397_      accounts.nms%type;

   nls9898_        VARCHAR2 (15);
   nms9898_        accounts.nms%TYPE;

   nls9819_        VARCHAR2 (15);
   nms9819_        accounts.nms%TYPE;
   -- ������� �������� ����������� ������ (�� ������� ����� ������ 6119)
   nls6519_        VARCHAR2 (15);
   nms6519_        accounts.nms%TYPE;
   -- ������� �������� ����������� ������
   nls3600_        VARCHAR2 (15);
   nms3600_        accounts.nms%TYPE;

   nls8_           VARCHAR2 (15);
   nms8_           accounts.nms%TYPE;

   nlss8_          VARCHAR2 (15);
   nmss8_          accounts.nms%TYPE;
   -- ������� ����
   nlskas_         VARCHAR2 (15);
   nmskas_         accounts.nms%TYPE;
   -- ������� ��� ���
   nlsnds_         VARCHAR2 (15);
   nmsnds_         accounts.nms%TYPE;
   -- ������� ��� ����� �� ���������
   nls_s9_       accounts.nls%type;
   nms_s9_       accounts.nms%type;

   nam_a_          oper.nam_a%TYPE;
   nam_b_          oper.nam_b%TYPE;
   nazn_           oper.nazn%TYPE;
   ref_            NUMBER;
   nd_             NUMBER;
   okpoa_          VARCHAR2 (14);
   okpob_          VARCHAR2 (14);
   mfoa_           oper.mfoa%TYPE;
   mfob_           oper.mfoa%TYPE;
   sk_             oper.sk%TYPE;
   bankdate_       DATE;
   dk_             NUMBER;
   dk2_            NUMBER;
   skrnd_          skrynka_nd%ROWTYPE;
   skr_            skrynka%ROWTYPE;
   mainacc_        accounts%ROWTYPE;
   accm_           NUMBER;
   def_rnk_        NUMBER;
   r1_             NUMBER;
   nls_            VARCHAR2 (15);
   nlsa_           VARCHAR2 (15);
   nlsb_           VARCHAR2 (15);
   dend_           DATE;
   del_            NUMBER                   := 0;
   -- ������ ������ ���� (������� ���� ������ - �����)
   proc_           NUMBER                   := 0;           -- ������� ������
   tariff_         NUMBER                   := 0;
   -- ���� ����� ��� ������ (� ���)
   tariff2_        NUMBER                   := 0;
   -- ���� ����� �� ������� (� ���)
   tariff3_        NUMBER                   := 0;
   -- ���� ����� �� ������� ��� ���
   daystariff_     NUMBER;
   sd_             NUMBER;
   monthstariff_   NUMBER;
   enddate_        DATE;
   nds_            NUMBER                   := 20;
   snds_           NUMBER;                                       -- ����� ���
   scperiod_       NUMBER;                          -- ����� �������� �������
   sfperiod_       NUMBER;                          -- ����� ������� ��������
   months_         NUMBER;
   days_           NUMBER;
   otcndat_        DATE;
   d1_             DATE;
   d2_             DATE;
   n_sk_old_       NUMBER;
   trf_            NUMBER;
   trf_old_        NUMBER;
   olddat_         DATE;                     -- ���� ������ ���������� ������
   olddat2_        DATE;                      -- ���� ����� ���������� ������
   otvisp_         NUMBER;                       --��� ��� �� �������� ������
   grp_            NUMBER;                   -- �� ������� �� �������� ������
   tcode_          NUMBER;
   -- ���������� ��� ������� ������ �� ������������ ������
   dni1_           NUMBER;                  -- ���������� ���� � ����� ������
   dni2_           NUMBER;                -- ���������� ���� �������� �������
   dni3_           NUMBER;                -- ���������� ���� �������� �������
   dni4_           NUMBER;                  -- ���������� ���� ������� ������
   sd1_            NUMBER;                                   -- ������� �����
   datp1_          DATE;                       -- ���� ����� �������� �������

   datp2_          DATE;                      -- ���� ������ �������� �������
   sb1_            NUMBER;                          -- ����� ������ �� ������
   sb2_            NUMBER;                          -- ����� ������ �� ������
   sc1_            NUMBER;                          -- ����� �������� �������
   sf1_            NUMBER;                          -- ����� �������� �������
   snds1_          NUMBER;                            -- ��� �� ������ ������
   sall1_          NUMBER;
   datk_           DATE;
   st_             NUMBER;
   prsc_           NUMBER                   := 0;           -- ������� ������
   peny_           NUMBER                   := 0;           -- ������� ������
   sopl_           NUMBER;
   l_monts_        NUMBER;                                  -- ������ ���� ��� ������ 1
   branch_         VARCHAR2 (30);
   -- ��� ������ ��� ����������� �������
   l_mod  constant varchar2(3) := 'SKR';
-- *******************************************************************************
   -- ��������
-- *******************************************************************************
   TYPE type_prot IS TABLE OF VARCHAR2 (100)
      INDEX BY BINARY_INTEGER;

   prot_           type_prot;
   proti_          NUMBER;
   proti2_         NUMBER;
----------------------------------------------------------------------------
   ern    CONSTANT POSITIVE                 := 208;
   err             EXCEPTION;
   erm             VARCHAR2 (80);

----------------------------------------------------------------------------
-- *******************************************************************************
   -- ������� � �������� ������������� ������
-- *******************************************************************************
   PROCEDURE operw_fl (ref_ NUMBER)
   IS
   l_s_ number;
   l_dk_ oper.dk%type;
   BEGIN

     select ( GL.P_NCURVAL(kv, S, vdat) )/100, dk into l_s_, l_dk_ from oper where ref =  ref_;


      FOR k IN (SELECT *
                  FROM op_field
                 WHERE tag IN
                          ('FIO','PASP','PASPN','ATRT','ADRES','SKR_D','POKPO'))
      LOOP
         IF k.tag = 'FIO'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'FIO', skrnd_.fio);
         ELSIF k.tag = 'PASP' and  (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASP', '�������');
         ELSIF k.tag = 'PASPN' and (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASPN', skrnd_.dokum);
         ELSIF k.tag = 'ATRT' and  (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ATRT', skrnd_.issued);
         ELSIF k.tag = 'ADRES' and  (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ADRES', skrnd_.adres);
         ELSIF k.tag = 'SKR_D' and  (l_s_ >= 150000 or l_dk_ = 1)
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'SKR_D',TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy'));
         ELSIF k.tag = 'POKPO'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'POKPO', skrnd_.okpo1);
         END IF;
      END LOOP;
   END;
-- *******************************************************************************
   -- ������� � �������� ������������� �����
-- *******************************************************************************
   PROCEDURE operw_ul (ref_ NUMBER)
   IS
   BEGIN
      FOR k IN (SELECT *
                  FROM op_field
                 WHERE tag IN
                          ('FIO', 'PASP', 'PASPN', 'ATRT', 'ADRES', 'SKR_D'))
      LOOP
         IF k.tag = 'FIO'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'FIO', skrnd_.fio2);
         ELSIF k.tag = 'PASP'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASP', '�������');
         ELSIF k.tag = 'PASPN'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PASPN', skrnd_.pasp2);
         ELSIF k.tag = 'ATRT'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ATRT', skrnd_.issued2);
         ELSIF k.tag = 'ADRES'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'ADRES', skrnd_.adres2);
         ELSIF k.tag = 'SKR_D'
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'SKR_D',TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy'));
         END IF;
      END LOOP;
   END;

-- *******************************************************************************
    -- ������� � �������� ������������� ��� ������ �������� ������ �����
-- *******************************************************************************
   PROCEDURE operw_vnebal (ref_ NUMBER)
   IS
   f_   skrynka_staff.fio%TYPE;
   BEGIN
      FOR k IN (SELECT *
                  FROM op_field
                 WHERE tag IN ('FIO','GOLD','SUMGD','VLASN','FIO1','FIO2','PO_N1','PO_K1','PO_S1','PO_KK','PO_OS'))
      LOOP
         IF k.tag = 'FIO'
         THEN
            -- ������������ ��� �������������
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'FIO', NVL (skrnd_.fio, skrnd_.fio2));
         ELSIF k.tag = 'GOLD'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'GOLD', '���� �� ����� � ' || skr_.snum);
         ELSIF k.tag = 'SUMGD'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'SUMGD', '1');
         ELSIF k.tag = 'VLASN'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'VLASN', '����� �����');
         ELSIF k.tag = 'FIO1'
         THEN
            -- ������������ ��� ����
            IF gl.amfo = '380214'
            THEN
               BEGIN
                  SELECT ss.fio
                    INTO f_
                    FROM skrynka_staff ss
                   WHERE tip = 1 AND ROWNUM = 1;

                  INSERT INTO operw(REF, tag, VALUE)
                       VALUES (ref_, 'FIO1', f_);
               EXCEPTION
                  WHEN OTHERS
                  THEN NULL;
               END;
            ELSE
               INSERT INTO operw(REF, tag, VALUE)
                    VALUES (ref_, 'FIO1', skrnd_.fio);
            END IF;
         ELSIF k.tag = 'FIO2'
         THEN
            -- ������������ ��� ����
            IF gl.amfo = '380214'
            THEN
               BEGIN
                  SELECT ss.fio
                    INTO f_
                    FROM skrynka_staff ss
                   WHERE tip = 1 AND ROWNUM = 1;

                  INSERT INTO operw(REF, tag, VALUE)
                       VALUES (ref_, 'FIO2', f_);
               EXCEPTION
                  WHEN OTHERS
                  THEN NULL;
               END;
            ELSE
               INSERT INTO operw(REF, tag, VALUE)
                    VALUES (ref_, 'FIO2', skrnd_.fio);
            END IF;
         ELSIF k.tag = 'PO_N1'
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'PO_N1',
                            '���� � '
                         || skr_.keynumber
                         || ' �� ���. ������ � '
                         || TO_CHAR (skr_.n_sk)
                         || '.'
                        );
         ELSIF k.tag = 'PO_K1'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PO_K1', '1');
         ELSIF k.tag = 'PO_S1'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PO_S1', '1.00');
         ELSIF k.tag = 'PO_KK'
         THEN
            INSERT INTO operw(REF, tag, VALUE)
                 VALUES (ref_, 'PO_KK', '1');
         ELSIF k.tag = 'PO_OS'
         THEN
            INSERT INTO operw(REF, tag,VALUE)
                 VALUES (ref_, 'PO_OS',
                            '����� ����� � '
                         || skrnd_.ndoc
                         || ' �� '
                         || skrnd_.docdate
                         || '.'
                        );
         END IF;
      END LOOP;
   END;


    Procedure p_nls_6519 (p_cust number)
    as
    l_nbs  accounts.nbs%type;
    l_ob22 accounts.ob22%type;
    BEGIN

      if p_cust in (3,2)
         then null;
         else return;
      end if;

     SELECT (CASE WHEN p_cust = 3 THEN ob22 ELSE ob22_u END), nbs
       INTO l_ob22, l_nbs
       FROM SKRYNKA_ACC_TIP
      WHERE tip = 'C';

      ------- �������� ��� ����� 6119 (���� 6519)
      if newnbs.g_state <> 1
        then l_nbs := 6119;
      end if;

     SELECT a.nls, a.nms
       INTO nls6519_, nms6519_
       FROM accounts a
      WHERE a.nls = nbs_ob22(l_nbs, l_ob22)
        and a.kv = 980;
    EXCEPTION WHEN NO_DATA_FOUND THEN NULL;
    END;


    -- ****************************************************
    --  ���������� ������� ������� ������
    -- ****************************************************
    function f_keyused (p_nd skrynka_nd.nd%type) return number
     as
    l_kol number;
    begin
     SELECT SUM (s / 100 * DECODE (dk, 0, -1, 1))
          INTO l_kol
          FROM SKRYNKA_ND_REF s, opldok p, accounts a
         WHERE     s.REF = p.REF
               AND p.acc = a.acc
               AND s.nd = p_nd
               AND a.nls LIKE '9819%'
               AND sos >= 0;
    return nvl(l_kol,0);
    end;


-- *******************************************************************************
   -- ��������� ������� ������
-- *******************************************************************************
PROCEDURE p_tariff (tariff_code_   IN NUMBER,
                    dat11_         IN DATE,
                    dat12_         IN DATE,
                    bdate_         IN DATE)
IS
  tip_      NUMBER;
  fl_       NUMBER;                                        -- ���� ������
  st_       NUMBER;                                       -- ����� ������
  mcount_   NUMBER;
  months3_  NUMBER;
  months6_  NUMBER;
  months9_  NUMBER;
  months12_ NUMBER;
  months15_ NUMBER;

   BEGIN
       -- ��������� ���� ������
      -- 1- ���������� ��� �������������
      -- 2- ����������� ��� ���� �� ����������� ����)
      BEGIN
         SELECT t.tip
           INTO tip_
           FROM skrynka_tariff t
          WHERE t.tariff = tariff_code_ AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN tip_ := NULL;
      END;

      tcode_ := tariff_code_;
      -- ���������� ���� ������
      del_ := dat12_ - dat11_ + 1;

      if del_ > 365
      then
        bars_error.raise_nerror(l_mod, 'RENT_TERM_INCORRECT', TO_CHAR(del_));
      end if;

      IF tip_ = 1
      THEN
         del_ := 0;
         proc_ := 0;
         tariff_ := 0;
         tariff2_ := 0;
         tariff3_ := 0;
         months_ := 0;
         days_ := 0;
         daystariff_ := 0;
         monthstariff_ := 0;

         IF dat11_ > dat12_ OR dat11_ IS NULL OR dat12_ IS NULL
         THEN
      bars_error.raise_nerror(l_mod, 'RENT_DATE_INCORRECT', TO_CHAR (dat11_,'dd/mm/yyyy'), TO_CHAR (dat12_,'dd/mm/yyyy'));
         END IF;

         -- ���������� ����������� ������� � ����� ������
         BEGIN
            d1_ := dat11_;
            d2_ := dat12_;
            dend_ := d1_;

            WHILE (ADD_MONTHS (d1_, months_ + 1) <= d2_)
            LOOP
               dend_ := ADD_MONTHS (d1_, months_ + 1);
               months_ := months_ + 1;
            END LOOP;

            IF months_ <> 0
            THEN days_ := d2_ - dend_;
            ELSE days_ := d2_ - dend_ + 1;
            END IF;
         END;

         BEGIN
            SELECT NVL (s.months, 0), NVL (s.days, 0), NVL(peny,0), months3, months6, months9, months12, months15
              INTO monthstariff_, daystariff_, peny_, months3_, months6_, months9_, months12_, months15_
              FROM skrynka_tariff1 s
             WHERE tariff = tariff_code_
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff1 ss
                        WHERE ss.tariff = tariff_code_
                          AND ss.tariff_date <= bdate_);

      --bars_audit.info('skrn: peny = '|| peny_);
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN bars_error.raise_nerror(l_mod, 'TARIF_NOT_FOUND', tariff_code_);
         END;

         BEGIN
            SELECT proc
              INTO proc_
              FROM (SELECT   ROWNUM, tariff, months, tariff_date, proc
                        FROM skrynka_tariff_skidka
                       WHERE tariff_date <= bdate_
                         AND tariff = tariff_code_
                         AND months =
                                (SELECT MAX (ss.months)
                                   FROM skrynka_tariff_skidka ss
                                  WHERE ss.tariff_date <= bdate_
                                    AND ss.tariff = tariff_code_
                                    AND ss.months <= months_
                                )
                    ORDER BY tariff_date DESC, months DESC)
             WHERE ROWNUM = 1;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN proc_ := 0;
         END;

         CASE
         WHEN months_ >= 12
         THEN tariff_  := months12_ * months_ + daystariff_ * days_;
              l_monts_ := months12_;
         WHEN months_ >= 9
         THEN tariff_  := months9_ * months_ + daystariff_ * days_;
              l_monts_ := months9_;
         WHEN months_ >= 6
         THEN tariff_  := months6_ * months_ + daystariff_ * days_;
              l_monts_ := months6_;
         WHEN months_ >= 3
         THEN tariff_  := months3_ * months_ + daystariff_ * days_;
              l_monts_ := months3_;
         ELSE tariff_  := monthstariff_ * months_ + daystariff_ * days_;
              l_monts_ := monthstariff_;
         END CASE;


         IF months_ >= 1
         THEN tariff3_ := ROUND (tariff_ * (1 - proc_ / 100), 2);
         ELSE tariff3_ := tariff_;
         END IF;

         -- ����� ��� ���
         IF skrnpar1_ = 0
         THEN tariff2_ := ROUND (tariff3_ * 5 / 6, 2);
         ELSE tariff2_ := tariff3_;
         END IF;

         tariff_ := 100 * tariff_;
         tariff2_ := 100 * tariff2_;
         tariff3_ := 100 * tariff3_;

         /* ����������� ����� �������� ������� */

         /* ���� ������ ������� � ��������� ������
              ��� ��� ������� = 0 */

         /*
            ������� ������ ������������

            1. ���� ���� ������ ����� �� ���� ����� 30(28-29 ��� �������) ����, ��
               ����� �� ������ 30 ���� ��� ��� ���� �� ������� ������(6 �����), �
               ��������� ��� �� ������� (3600).
            2. ���� ����������� � ���� ���������� ������� ������ ��� �� ���������,
               �� ��� ����� ��� ��� �� ������� ������(3600) - ����, ���� �� �����
               ������� ������ 1 ����;
            3. ���� ���� ���������� ������� ������ ������� � ����������� �������,
               �� ����� ��� ��� �� ������ ����� ����� ����������� �� ������� ������,
               � ��� ��������� ��� ��� �� �������;
            4. ���� ���� ������� ������ ������, �� �� ����������� ���� �������
               ��������� � ����� �� ��� ��� �� ������� ������, � ������������ ���
               �� �������� ����� ������ ������������ �������� �����.*/
         IF     olddat2_ IS NOT NULL
            AND (olddat2_ > bankdate OR dat11_ > LAST_DAY (bankdate))
         THEN                                                   -- �����������
            scperiod_ := 0;
         ELSIF     olddat2_ IS NULL
               AND dat11_ > LAST_DAY (bankdate)   -- ������ ������ ����� �����
         THEN
            scperiod_ := 0;
         ELSE
            IF ADD_MONTHS (d1_, 1) >= d2_
            THEN
               scperiod_ := tariff2_;
            ELSE
               scperiod_ := ROUND (  (1 - (1 - skrnpar1_) / 6)
                         --* monthstariff_
             * l_monts_
                         * 100 * (1 - proc_ / 100));
            END IF;
         END IF;
      ELSIF tip_ = 2
      THEN
         d1_ := dat11_;
         d2_ := dat12_;

         BEGIN
            SELECT NVL (s.s, 0) * 100, flag1, NVL (proc, 0), NVL (peny, 0)
              INTO st_, fl_, prsc_, peny_
              FROM skrynka_tariff2 s
             WHERE tariff = tariff_code_
               AND del_ >= s.daysfrom
               AND del_ <= s.daysto
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff2 ss
                        WHERE ss.tariff = tariff_code_
        AND del_ >= daysfrom
                          AND del_ <= daysto
                     AND ss.tariff_date <= bdate_);
         EXCEPTION WHEN NO_DATA_FOUND
                   THEN bars_error.raise_nerror(l_mod, 'TARIF_NOT_FOUND', tariff_code_);
         END;

         -- ���������� ����������� ������� (30 ��) � �����
         -- ���� ����������� ��������� ������� ������ �����
         months_ := CEIL (del_ / 30);
         days_ := del_;

         IF fl_ = 1
         THEN
            sd_ := st_;
            tariff3_ := ROUND (st_ * del_ * NVL (1 - prsc_ / 100, 1));
            tariff2_ := ROUND (tariff3_ * 100 / (100 + nds_));
         ELSIF fl_ = 2
         THEN
            sd_ := st_ / 30;
            tariff3_ := ROUND (sd_ * del_ * NVL (1 - prsc_ / 100, 1));
            tariff2_ := ROUND (tariff3_ * 100 / (100 + nds_));
         END IF;

         tariff_ := tariff3_;

         -- �������� ����� ��� ����������� �� ������ �������� � �������� ��������
         IF months_ = 0
         THEN scperiod_ := tariff2_;
         ELSE scperiod_ := ROUND (tariff2_ / months_);
         END IF;

    END IF;
   END p_tariff;

-- *******************************************************************************\
--        ��������� ���������� ������
--          �� ����������Ӫ����
-- *******************************************************************************
PROCEDURE p_tariff2 (n_sk_     NUMBER,
                     dat11_    DATE,
                     dat12_    DATE,
                     bdate_    DATE)
   IS
      trf_   NUMBER;
   BEGIN
      BEGIN
         SELECT tariff
           INTO trf_
           FROM skrynka_nd n
          WHERE n.sos = 0 AND n_sk = n_sk_;
      EXCEPTION WHEN NO_DATA_FOUND
                THEN trf_ := NULL;
      END;
      p_tariff (trf_, dat11_, dat12_, bankdate);
   END;

-- *******************************************************************************
--        ��� ������������ ����������� ������
--          �� ����������Ӫ����
-- *******************************************************************************
   FUNCTION f_getnextdat (n_sk_ NUMBER, dat11_ DATE, s_ NUMBER)
      RETURN NUMBER
   IS
      d_   NUMBER := 0;
   BEGIN
      IF n_sk_old_ IS NULL OR n_sk_old_ <> n_sk_
      THEN
         BEGIN
            SELECT tariff
              INTO trf_
              FROM skrynka_nd n
             WHERE n.sos = 0 AND n_sk = n_sk_;

            n_sk_old_ := n_sk_;
            trf_old_ := trf_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN trf_ := NULL;
         END;
      ELSE
         trf_ := trf_old_;
      END IF;

      LOOP
         p_tariff (trf_, dat11_, dat11_ + d_, bankdate);

         IF d_ >= 10000 OR s_ < skrn.get_par (10)
         THEN
            EXIT;
         END IF;

         d_ := d_ + 1;
      END LOOP;

      RETURN GREATEST (d_ - 1, 0);
   END f_getnextdat;

-- *******************************************************************************
--             ��� f_getnextdat
--            �� ����������Ӫ����
-- *******************************************************************************
   FUNCTION get_par (par_ NUMBER)
      RETURN VARCHAR2
   IS
   BEGIN
      IF par_ = 1
      THEN                                              -- ���� ������ ������
         RETURN TO_CHAR (d1_, 'dd.mm.yyyy');
      ELSIF par_ = 2
      THEN                                                -- ���� ����� ������
         RETURN TO_CHAR (d2_, 'dd.mm.yyyy');
      ELSIF par_ = 3
      THEN                                                             -- ����
         RETURN days_;
      ELSIF par_ = 4
      THEN                                                          -- �������
         RETURN months_;
      ELSIF par_ = 5
      THEN                                                   -- ������ �������
         RETURN monthstariff_;
      ELSIF par_ = 6
      THEN                                                      -- ������ ����
         RETURN daystariff_;
      ELSIF par_ = 7
      THEN                                                   -- ������� ������
         RETURN proc_;
      ELSIF par_ = 8
      THEN                                           -- ����� � ��� ��� ������
         RETURN tariff_;
      ELSIF par_ = 9
      THEN                                           -- ����� � ��� ��� ������
         RETURN tariff2_;
      ELSIF par_ = 10
      THEN                                           -- ����� � ��� �� �������
         RETURN tariff3_;
      ELSIF par_ = 11
      THEN                                           -- ����� �������� �������
         RETURN scperiod_;
      ELSIF par_ = 12
      THEN                                                       -- ��� ������
         RETURN tcode_;

    ELSIF par_ = 13
      THEN            -- ����
     RETURN branch_;
      END IF;

      RETURN 0;
   END get_par;

-- *******************************************************************************
--        ���������� ������ �� �������� �� �����
-- *******************************************************************************
   PROCEDURE p_calcperiod_tariff (dat1_ DATE, dat2_ DATE, nd_ NUMBER, par_ NUMBER default null)
   IS
   l_tarif_ number;
   tipt_ number;
   BEGIN

          SELECT n.s_arenda, n.sd, n.dat_end - n.dat_begin + 1, n.prskidka, n.peny, tariff
            INTO st_, sd1_, dni1_, prsc_, peny_, l_tarif_
            FROM skrynka_nd n
           WHERE nd = nd_;

        begin
           SELECT tip
            INTO tipt_
            FROM skrynka_tariff st
           WHERE st.tariff = l_tarif_;
        exception when no_data_found then tipt_ :=2;
        end;

        if tipt_ = 2
        then
          -- sopl_ := f_get_opl_sum (nd_);
          SELECT LAST_DAY (dat1_)
            INTO datk_
            FROM DUAL;

          -- ���� ������ � ����
          IF dat2_ < dat1_
          THEN
            dni4_ := 0;
             --dni4_ := 1;
          ELSE
             dni4_ := dat2_ - dat1_ + 1;
          END IF;

          -- ���� �� ������ ������� �� ���������� ������������ ��� � ������
          -- ���� ������ �������
          IF datk_ > dat2_
          THEN dni2_ := dni4_;
          ELSE dni2_ := datk_ - dat1_ + 1;
          END IF;

          -- ���� ���������� ���� <= ���� ������ ������� ��� ����� - ������ �������� ��������
          IF TO_CHAR (bankdate, 'YYYYMM') < TO_CHAR (dat1_, 'YYYYMM')
          THEN
             dni2_ := 0;
             datk_ := NULL;
          END IF;

          -- ���� �������� �������
          dni3_     := dni4_ - dni2_;
          sb1_      := ROUND (dni4_ * sd1_ * (1 - prsc_ / 100));
          snds1_    := ROUND (sb1_ * (1 - 1 / (1 + nds_ / 100)));
          sb2_      := sb1_ - snds1_;
          if dni4_ = 0
          then sc1_ := 0;
          else sc1_ := ROUND (sb2_ * dni2_ / dni4_);
          end if;
          sf1_ := sb1_ - snds1_ - sc1_;

        elsif tipt_ = 1
        then
          if nd_ is not null
          then
            select *
              into skrnd_
              from skrynka_nd
             where nd = nd_;
          end if;

         skrn.p_tariff (skrnd_.tariff, skrnd_.dat_begin, skrnd_.dat_end, skrnd_.dat_begin );

      sb1_:=round(l_monts_*100 *     (MONTHS_BETWEEN(dat2_,dat1_)));
        else null;
        end if;

   END;

-- *******************************************************************************
--                �������
--            ҳ���� �� �������� ���������
-- *******************************************************************************
   PROCEDURE p_oper_zalog (
      dat_    DATE,
      dat2_   DATE,
      n_sk_   NUMBER,
      mode_   NUMBER,
      par_    NUMBER DEFAULT NULL,
    p_userid NUMBER DEFAULT NULL,
    p_sum   NUMBER DEFAULT NULL
   )
   IS
    l_userid number;
   BEGIN
      if p_userid is null
      then l_userid := userid_;
    else  l_userid := p_userid;
    end if;
      -- c���� ������
      sz_ := NVL (skrnd_.sdoc, 0);

    if nvl(p_sum ,0) != 0
         then sz_ := nvl(p_sum ,0);
    end if;

      IF sz_ = 0
      THEN
     bars_error.raise_nerror(l_mod, 'ZERO_BAIL_SUM', n_sk_);
      END IF;

      IF skr_.keyused = 1 AND mode_ = 15
      THEN
     bars_error.raise_nerror(l_mod, 'KEY_GIVEN', n_sk_);
      ELSIF skr_.keyused = 0 AND mode_ = 16
      THEN
     bars_error.raise_nerror(l_mod, 'KEY_RETURNED', n_sk_);
      END IF;

    -- �������� � �������������� ��������� �� ������� �����
        /*
    select a.nms, a.nls, a.ostc
    into nms2909_, nls2909_,ostc2909_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'M' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;

    select a.nms, a.nls
    into nms6119_, nls6119_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'C' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;
        */
    select a.nms, a.nls
      into nms3600_, nls3600_
      from skrynka_nd_acc s, accounts a, skrynka_nd n
     where s.tip = 'D'
           and s.nd = n.nd
           and s.acc = a.acc
           and n.n_sk = n_sk_
           and n.sos = 0;
      -- �������� �������� �� ��, ��� �������� �� ����� ������ (��� ���������� ������ �������)
      -- ��������� ��������� ��
      IF mode_ = 10
      THEN
         --
         nam_a_     := SUBSTR (nms2909_, 1, 38);
         mfoa_      := gl.amfo;
         nlsa_      := nls2909_;
         nam_b_     := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);
         mfob_      := gl.amfo;
         nlsb_      := nlskas_;
         okpob_     := f_ourokpo;
         -- okpob_ := skrnd_.okpo1;
            --
         nazn_      := '�������� ������� �� ����, ���� � '  || TO_CHAR (skr_.snum)
                        || ' ����� �������� � '            || TO_CHAR (skrnd_.ndoc)
                        || ' �� '                          || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', ��� ���.';
         -- ����� ��������
         dk_ := 0;
      ELSIF mode_ = 12
      THEN
         nam_a_     := SUBSTR (nms2909_, 1, 38);
         nlsa_      := nls2909_;
         mfoa_      := gl.amfo;
         nam_b_     := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);
         nlsb_      := nlskas_;
         mfob_      := gl.amfo;
         okpob_     := f_ourokpo;
         -- okpob_ := skrnd_.okpo1;
         nazn_      := '���������� ������� �� ����, ���� � '        || TO_CHAR (skr_.snum)
                        || ' � ��''���� � ���������� �������� � '  || TO_CHAR (skrnd_.ndoc)
                        || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', ��� ���.';
         sz_        := ostc2909_;
         -- ������ ��������
         dk_        := 1;
      ELSIF mode_ = 13
      THEN
    BEGIN
         SELECT nms
           INTO nmskas_
           FROM accounts
          WHERE nls = skrnd_.nlsk AND kv = '980';
        EXCEPTION  WHEN NO_DATA_FOUND THEN
                    bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        -- ������� �볺��� �� ��������� ��� ��������� �� ����
        END;
         --
         nam_a_     := SUBSTR (nms2909_, 1, 38);
         nlsa_      := nls2909_;
         mfoa_      := gl.amfo;
         nlsb_      := skrnd_.nlsk;
         nam_b_     := SUBSTR (skrnd_.nmk, 1, 38);
         mfob_      := gl.amfo;
         --okpob_ := skrnd_.okpo1;
         okpob_     := f_ourokpo;
         nazn_      := '���������� ������� �� ����, ���� � '                    || TO_CHAR (skr_.snum)
                        || ' � ��''���� � ���������� ������ 䳿 �������� � '  || TO_CHAR (skrnd_.ndoc)
                        || ' �� '                                              || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', ��� ���.';
         nlskas_    := skrnd_.nlsk;
         sz_        := ostc2909_;
         dk_        := 1;
      ELSIF mode_ = 11
      THEN

     BEGIN
       SELECT nms,     ostc
         INTO nmskas_, sz_
         FROM accounts
        WHERE nls = skrnd_.nlsk
                AND kv = '980'
                AND kf = skrnd_.mfok;

       nlsa_  := skrnd_.nlsk;
       nam_a_ := nvl( SUBSTR (skrnd_.nmk, 1, 38) , substr(nmskas_,1,38) );
       mfoa_  := gl.amfo;
       okpoa_ := skrnd_.okpo1;
       sz_    := NVL (skrnd_.sdoc, 0);
     EXCEPTION WHEN NO_DATA_FOUND
                   THEN bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
                        -- ������� �볺��� �� ��������� ��� ��������� �� ����
                        -- �������� ������� ����� ����������!! ��� ������ ����� ������ �� �����.
                        -- ������� ������� ��� ������� ������ �����. �� ������????
                    sz_ := 0;
     END;

        --
         nam_b_     := SUBSTR (nms2909_, 1, 38);
         nlsb_      := nls2909_;
         mfob_      := gl.amfo;
         okpob_     := f_ourokpo;
         nazn_      := '�������� ������� �� ����, ���� � '          || TO_CHAR (skr_.snum)
                        || ' �����  �������� � '                   || TO_CHAR (skrnd_.ndoc)
                        || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || ', ��� ���.';
         nlskas_    := skrnd_.nlsk;
         dk_        := 1;
      END IF;


      -- �������� 1 �������� ������
      IF sz_ <> 0
      THEN
         gl.REF (ref_);

         INSERT INTO oper
                     (REF, tt, vob, nd, dk, pdat, vdat,
                      datd, datp, nam_a, nlsa, mfoa, kv, s,
                      nam_b, nlsb, mfob, kv2, s2, nazn, userid,
                      id_a, id_b, sk)
              VALUES (ref_, tt_, vob_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                      SYSDATE, bankdate_, nam_a_, nlsa_, mfoa_, kv_, sz_,
                      nam_b_, nlsb_, mfob_, kv_, sz_, nazn_, l_userid,
                      okpoa_, okpob_, sk_);

         -- �������� ������
         gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sz_,kv_,nlsb_,sz_);

         IF ref_ IS NOT NULL
         THEN
            INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                 VALUES (ref_, bankdate_, skrnd_.nd);
     END IF;

         IF NVL (skrnd_.custtype, 3) = 3
         THEN operw_fl (ref_);
         ELSE operw_ul (ref_);
         END IF;
      END IF;

        -- ���� ���������� ���� �������(������) �������� � ������ �� ���������.
    if nvl(p_sum ,0) != 0
         then return;
    end if;

      -- �������� 2 ������ �����
      IF NVL (skrnpar3_, 0) = 0
      THEN
         gl.REF (ref_);
      END IF;

      sk_ := NULL;

      IF mode_ = 10 OR  mode_ = 11
      THEN
         nam_a_     := SUBSTR (nms9898_, 1, 38);
         nlsa_      := nls9898_;
         mfoa_      := gl.amfo;
         nam_b_     := SUBSTR (nms9819_, 1, 38);
         nlsb_      := nls9819_;
         mfob_      := gl.amfo;
         nazn_      := '������ ����� � '        || skr_.keynumber
                        || ', ���� � '          || TO_CHAR (skr_.snum)
                        || ' ����� ����� � '   || TO_CHAR (skrnd_.ndoc)
                        || ' �� '              || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         dk_        := 1;
      ELSIF mode_ = 12
      THEN
         nam_b_     := SUBSTR (nms9898_, 1, 38);
         nam_a_     := SUBSTR (nms9819_, 1, 38);
         nlsb_      := nls9898_;
         nlsa_      := nls9819_;
         mfoa_      := gl.amfo;
         mfob_      := gl.amfo;
         nazn_      := '���������� ����� � '    || skr_.keynumber
                        || ', ���� � '          || TO_CHAR (skr_.snum)
                        || ' � ��''���� � ���������� ������ 䳿 ����� � ' || TO_CHAR (skrnd_.ndoc)
                        || ' �� '              || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         dk_        := 1;
      ELSIF mode_ = 13
      THEN
         nam_b_     := SUBSTR (nms9898_, 1, 38);
         nam_a_     := SUBSTR (nms9819_, 1, 38);
         nlsb_      := nls9898_;
         nlsa_      := nls9819_;
         mfoa_      := gl.amfo;
         mfob_      := gl.amfo;
         nazn_      := '���������� ����� � '            || skr_.keynumber
                        || ', ���� � '                  || TO_CHAR (skr_.snum)
                        || ' � ��''���� � ���������� ������ 䳿 ����� � '     || TO_CHAR (skrnd_.ndoc)
                        || ' �� '                      || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         dk_        := 1;
      END IF;

      -- ����� ���� ���� ������� ����� 1 ����
      IF skrnd_.keycount > 0 AND ref_ IS NOT NULL AND tt2_ is not null
      THEN
         IF NVL (skrnpar3_, 0) = 0
         THEN
            INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa, kv,
                         s, nam_b, nlsb, mfob, kv2, s2, nazn,
                         userid, id_a, id_b, sk)
                 VALUES (ref_, tt2_, vob2_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlsa_, mfoa_, kv_,
                         100 * skrnd_.keycount, nam_b_, nlsb_, mfob_, kv_, 100 * skrnd_.keycount, nazn_,
                         l_userid, okpoa_, okpob_, sk_);
         END IF;

         -- �������� ������
         gl.payv (0,ref_, bankdate_, tt2_, dk_, kv_, nlsa_, 100 * skrnd_.keycount, kv_, nlsb_, 100 * skrnd_.keycount);

         IF NVL (skrnpar3_, 0) = 0
         THEN
            operw_vnebal (ref_);
         END IF;
      END IF;

      IF     ref_ IS NOT NULL
        AND NVL (skrnpar3_, 0) = 0
        AND skrnd_.keycount > 0
        AND tt2_ is not null
      THEN
            INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                 VALUES (ref_, bankdate_, skrnd_.nd);
      END IF;

      IF mode_ IN ('10', '11') AND skrnd_.keycount > 0
      THEN
         UPDATE skrynka
            SET keyused = 1
          WHERE n_sk = n_sk_;
      ELSIF mode_ IN ('12', '13') AND skrnd_.keycount > 0
      THEN
         UPDATE skrynka
            SET keyused = 0
          WHERE n_sk = n_sk_;
      END IF;

--����������� � ��������� ��������� �� ��������� ���������� �� ���
    IF     mode_ IN ('12', '13')
        AND skrnd_.dat_end < gl.bdate
      THEN

        SELECT tt, tt2, tt3, NAME, sk, NVL (vob, 6), NVL (vob2, 6),NVL (vob3, 6)
          INTO tt_, tt2_, tt3_, itemname_, sk_, vob_, vob2_,vob3_
          FROM skrynka_menu
         WHERE item = decode(mode_, 12, 14, 13, 15, 14)
           and kf = sys_context('bars_context','user_mfo');

    overdue_payment(trunc(sysdate), trunc(sysdate)+(skrnd_.dat_end-skrnd_.dat_begin), n_sk_, (case when mode_= 12 then 14 else 15 end), par_);
      END IF;

   END;

-- *******************************************************************************
--          ������ ������� ����� �� �����
-- *******************************************************************************
  PROCEDURE p_oper_arenda_period (dat_    IN DATE,
                                  dat2_   IN DATE,
                                  n_sk_   IN NUMBER,
                                  mode_   IN NUMBER,
                                  par_    IN NUMBER DEFAULT NULL)
   IS
  new_ref_flag    NUMBER := 0;
  nmsnls_         accounts.nms%type;
   BEGIN
    -- �������� � �������������� ��������� �� ������� �����
        /*
    select a.nms, a.nls, a.ostc
    into nms2909_, nls2909_,ostc2909_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'M' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;

    select a.nms, a.nls
    into nms6119_, nls6119_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'C' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;
        */
    if par_ is not null
        then
      select a.nms, a.nls
          into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.nd = par_;
    else
      select a.nms, a.nls
        into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.n_sk = n_sk_
               and n.sos = 0;
    end if;

    -- ���� �������� ����. ����� �������� ��� �����������
    if par_ is not null
      then
        SELECT *
          INTO skrnd_
          FROM skrynka_nd
         WHERE nd = par_;
    end if;

      -- ������ ����� ������ ��������� ������������
      -- ������ ������ � �������� � ����������� ����������� ���� �����
      skrn.p_calcperiod_tariff (dat_, dat2_, skrnd_.nd, par_);

      -- ����� �������� ������� �������� �� ���������� ��������� �������
      IF sb1_ = 0
      THEN bars_error.raise_nerror(l_mod, 'ZERO_RENT_SKR', n_sk_);
      END IF;


      IF mode_ = 15
      THEN
        BEGIN
         SELECT nms
           INTO nmsnls_
           FROM accounts
          WHERE nls = skrnd_.nlsk
            AND kv = '980'
            AND kf = skrnd_.mfok;
        EXCEPTION WHEN NO_DATA_FOUND
                  THEN nmsnls_ := null;
                       bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        END;
      END IF;
     -- ��� 15 - ���� �������� �� ����
      IF mode_ != 15 or (skrnd_.mfok = f_ourmfo and nmsnls_ is not null)
      THEN
    -- �������� � 1 - �����

         gl.REF (ref_);
         nam_a_     := SUBSTR (nmss2909_, 1, 38);
         nlsa_      := nlss2909_;
       --nam_a_ := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);

     IF mode_ != 15
         THEN
        nam_a_    := SUBSTR (nmss2909_, 1, 38);
          nlsa_     := nlss2909_;
          nlsb_     := nlskas_;
          okpob_    := f_ourokpo;
          nam_b_    := SUBSTR (nmskas_, 1, 38);
          dk_       := 0;
       ELSE
          nlsa_     := skrnd_.nlsk;
          okpoa_    := skrnd_.okpo1;
          nam_a_    := SUBSTR(nmsnls_, 1, 38);
          nam_b_    := SUBSTR (nmss2909_, 1, 38);
          nlsb_     := nlss2909_;
          dk_       := 1;
     END IF;
     mfoa_  := gl.amfo;
     mfob_  := gl.amfo;

     nam_b_ := nvl(SUBSTR(skrnd_.fio, 1, 38),SUBSTR(skrnd_.nmk, 1, 38)) ;------ COBUSUPABS-6028 13.06.2017
     nazn_  := '������� ����� �� ������������ ������ � '    || TO_CHAR (skr_.snum)
              || ' �� ����� � '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
              || '�. �� '                                 || TO_CHAR (dat2_, 'dd.mm.yyyy')
              || '�., ����� �������� � '                 || skrnd_.ndoc
              || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
              || '�.';

         IF skrnpar1_ = 0
         THEN
             nazn_ := SUBSTR (   nazn_ || ' � �.�. ��� ' || TRIM (TO_CHAR (snds1_ / 100, '9999999990.00')) || ' ���.', 1, 160);
          ELSE
             nazn_ := nazn_ || '.';
         END IF;


        gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sb1_,kv_,sb1_,sk_,SYSDATE,bankdate_,
      nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

        -- ����� � ���
        gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sb1_,kv_,nlsb_,tariff3_);

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (ref_);
        ELSE operw_ul (ref_);
        END IF;

        IF ref_ IS NOT NULL
        THEN
        -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
        INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
           VALUES (ref_, bankdate_, skrnd_.nd, 1);
      END IF;
   END IF;

      -- �������� � 2 - ����� - ������ �������� �������
      -- ���� ���� �������� <= ���� ��������� �������� ��� �� ������� �������
      -- olddat2_ < bankdate ������� ����, ��� ��������� ������� ����� ������
      -- ������� �� ��������� ��������� �.�. ��� ������ ������ ����� ���������
      -- ����� ������ ������
     IF mode_ = 15 AND ref_ is null
     THEN new_ref_flag := 1;
   END IF;

   IF sc1_ IS NOT NULL AND sc1_ > 0 AND nls6519_ IS NOT NULL
     THEN
         IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
         THEN
            gl.REF (ref_);
         END IF;

         sk_    := NULL;
         nam_a_ := SUBSTR (nmss2909_, 1, 38);
         nam_b_ := SUBSTR (nms6519_, 1, 38);
     IF mode_ = 15
         then
      nazn_ := '������� ����� �� ������������ ������ � '      || TO_CHAR (skr_.snum)
                  || ' �� ����� � '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                  || '�. �� '                                 || TO_CHAR (dat2_, 'dd.mm.yyyy')
                  || '�., ����� �������� � '                 || skrnd_.ndoc
                  || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || '�.';
      IF skrnpar1_ = 0
      THEN nazn_ := SUBSTR (nazn_ || ' � �.�. ��� ' || TRIM (TO_CHAR (snds1_ / 100, '9999999990.00')) || ' ���.', 1, 160);
      ELSE nazn_ := nazn_ || '.';
      END IF;
     else
          nazn_ := '������� ����� �� ������������ ������ � '      || TO_CHAR (skr_.snum)
                      || ' �� ����� � '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                      || ' �� '                                   || TO_CHAR (datk_, 'dd.mm.yyyy')
                      || ', ����� �������� � '                 || TO_CHAR (skrnd_.ndoc)
                      || ' �� '                                || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                      || '.';
     end if;
         dk_    := 1;

         IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
         THEN
      new_ref_flag := 0;
            INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa,
                         kv, s, nam_b, nlsb, mfob, kv2, s2,
                         nazn, userid, id_a, id_b, sk)
                 VALUES (ref_, tt2_, vob2_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlss2909_, mfoa_,
                         kv_, sc1_, nam_b_, nls6519_, mfob_, kv_, sc1_,
                         nazn_, userid_, okpoa_, okpob_, sk_);
         END IF;

         gl.payv (0,ref_,bankdate_,tt2_,dk_,kv_,nlss2909_,sc1_,kv_,nls6519_,scperiod_);

         IF ref_ IS NOT NULL AND ((mode_ = 15 and nmsnls_ is null) OR NVL (skrnpar3_, 0) = 0)
         THEN
      -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
      INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
         VALUES (ref_, bankdate_, skrnd_.nd, 1);
     END IF;

     update skrynka_nd
            set amort_date = least(datk_,dat2_)
      where nd = par_;
      --ELSE
      --   scperiod_ := 0;
      END IF;

      --sfperiod_ := tariff2_ - scperiod_;

      -- �������� � 3 - ����� - ������ �������� �������
      IF sf1_ > 0 AND sf1_ IS NOT NULL AND nls3600_ IS NOT NULL
      THEN
         IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
         THEN
            gl.REF (ref_);
         END IF;

         sk_    := NULL;
         nam_a_ := SUBSTR (nmss2909_, 1, 38);
         nam_b_ := SUBSTR (nms3600_, 1, 38);

         IF scperiod_ <> 0
         THEN
            nazn_ := '������� ����� �� ������������ ������ � '      || TO_CHAR (skr_.snum)
                        || ' �� ����� � '                          || TO_CHAR (datk_ + 1, 'dd.mm.yyyy')
                        || ' �� '                                   || TO_CHAR (dat2_, 'dd.mm.yyyy')
                        || ', ����� �������� � '                   || TO_CHAR (skrnd_.ndoc)
                        || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         ELSE
            nazn_ := '������� ����� �� ������������ ������ � '      || TO_CHAR (skr_.snum)
                        || ' �� ����� � '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                        || ' �� '                                   || TO_CHAR (dat2_, 'dd.mm.yyyy')
                        || ', ����� �������� � '                   || TO_CHAR (skrnd_.ndoc)
                        || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                        || '.';
         END IF;

    if new_ref_flag = 1
        then
      nazn_ := '������� ����� �� ������������ ������ � '      || TO_CHAR (skr_.snum)
                  || ' �� ����� � '                          || TO_CHAR (dat_, 'dd.mm.yyyy')
                  || '�. �� '                                 || TO_CHAR (dat2_, 'dd.mm.yyyy')
                  || '�., ����� �������� � '                 || skrnd_.ndoc
                  || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || '�.';
      IF skrnpar1_ = 0
      THEN
       nazn_ := SUBSTR (nazn_ || ' � �.�. ��� ' || TRIM (TO_CHAR (snds1_ / 100, '9999999990.00'))|| ' ���.',1,160);
            ELSE
       nazn_ := nazn_ || '.';
      END IF;
    END IF;

        dk_ := 1;

        IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
        THEN
     new_ref_flag := 0;
           INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa,
                         kv, s, nam_b, nlsb, mfob, kv2, s2,
                         nazn, userid, id_a, id_b, sk)
                 VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlss2909_, mfoa_,
                         kv_, sf1_, nam_b_, nls3600_, mfob_, kv_, sf1_,
                         nazn_, userid_, okpoa_, okpob_, sk_);
        END IF;

        -- ������ �������� �������
         IF nvl(sf1_,0) > 0
         THEN  gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,sf1_,kv_,nls3600_,sfperiod_);
         END IF;

         IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
         THEN
            -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
            INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                 VALUES (ref_, bankdate_, skrnd_.nd, 1);
         END IF;
      --END IF;
      END IF;

      -- �������� � 4 - ����� - �������� ���
      IF nlsnds_ IS NOT NULL AND snds1_ IS NOT NULL AND snds1_ > 0
      THEN
         IF NVL (skrnpar3_, 0) = 0
         THEN
            gl.REF (ref_);
         END IF;

         sk_    := NULL;
         nam_a_ := SUBSTR (nmss2909_, 1, 38);
         nam_b_ := SUBSTR (nmsnds_, 1, 38);
         nazn_  := '��� �� ������������ ������ � '      || TO_CHAR (skr_.snum)
                    || ' �� ����� � '                  || TO_CHAR (dat_, 'dd.mm.yyyy')
                    || ' �� '                           || TO_CHAR (dat2_, 'dd.mm.yyyy')
                    || ', ����� �������� � '           || TO_CHAR (skrnd_.ndoc)
                    || ' ��� ������� � ������ ��������������  �� '    || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                    || '.';
         dk_   := 1;

         IF NVL (skrnpar3_, 0) = 0
         THEN
            INSERT INTO oper
                        (REF, tt, vob, nd, dk, pdat, vdat,
                         datd, datp, nam_a, nlsa, mfoa,
                         kv, s, nam_b, nlsb, mfob, kv2, s2,
                         nazn, userid, id_a, id_b, sk)
                 VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE, bankdate_,
                         bankdate_, bankdate_, nam_a_, nlss2909_, mfoa_,
                         kv_, snds1_, nam_b_, nlsnds_, mfob_, kv_, snds1_,
                         nazn_, userid_, okpoa_, okpob_, sk_);
         END IF;

         -- ������ �������� �������
         gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,snds1_,kv_,nlsnds_,snds1_);

         IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
         THEN
      -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
      INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
         VALUES (ref_, bankdate_, skrnd_.nd, 1);
     END IF;
      END IF;
   END;

-- *******************************************************************************
--            ������ ������� �����
--  par_ = 1 - �����������
-- *******************************************************************************
 PROCEDURE p_oper_arenda (dat_    IN DATE,
                          dat2_   IN DATE,
                          n_sk_   IN NUMBER,
                          mode_   IN NUMBER,
                          par_    IN NUMBER DEFAULT NULL)
   IS
      tipt_         NUMBER;
    new_ref_flag  NUMBER := 0;
    nmsnls_       accounts.nms%type;
   BEGIN
   -- �������� � �������������� ��������� �� ������� �����
        /*
    select a.nms, a.nls, a.ostc
    into nms2909_, nls2909_,ostc2909_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'M' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;

    select a.nms, a.nls
    into nms6119_, nls6119_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'C' and s.nd = n.nd and s.acc = a.acc and n.n_sk = n_sk_ and n.sos = 0;
        */
    if par_ is not null
        then
      select a.nms, a.nls
        into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.nd = par_;
    else
      select a.nms, a.nls
        into nms3600_, nls3600_
        from skrynka_nd_acc s, accounts a, skrynka_nd n
       where s.tip = 'D'
               and s.nd = n.nd
               and s.acc = a.acc
               and n.n_sk = n_sk_
               and n.sos = 0;
    end if;

    -- ���� �������� ����. ����� �������� ��� �����������
    if par_ is not null then
        SELECT *
          INTO skrnd_
          FROM skrynka_nd
         WHERE nd = par_;
    end if;

      SELECT tip
        INTO tipt_
        FROM skrynka_tariff st
       WHERE st.tariff = skrnd_.tariff;

      IF tipt_ = 2
      THEN
         p_calc_tariff (n_sk_, par_);
         p_oper_arenda_period (skrnd_.dat_begin,
                               skrnd_.dat_end,
                               n_sk_,
                               mode_,
                               par_);
      ELSE
         skrn.p_tariff (skrnd_.tariff,
                        skrnd_.dat_begin,
                        skrnd_.dat_end,
                        bankdate_);
         snds_ := tariff3_ - tariff2_;

         UPDATE skrynka_nd
            SET s_arenda = tariff3_,
                s_nds = snds_
          WHERE nd = skrnd_.nd;

         IF tariff3_ = 0
         THEN
      bars_error.raise_nerror(l_mod, 'ZERO_RENT', skrnd_.nd);
         END IF;

        BEGIN
           SELECT nms
             INTO nmsnls_
             FROM accounts
            WHERE nls = skrnd_.nlsk AND kv = '980' AND kf = skrnd_.mfok;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              nmsnls_ := NULL;
        END;

     IF mode_ = 15
         THEN
            BEGIN
                 SELECT nms
                   INTO nmsnls_
                   FROM accounts
                  WHERE nls = skrnd_.nlsk
                    AND kv = '980'
                    AND kf = skrnd_.mfok;
            EXCEPTION WHEN NO_DATA_FOUND
                      THEN nmsnls_ := null;
                           bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
            END;
     END IF;

     -- ��� 15 - ���� �������� �� ����
       IF mode_ != 15 or (skrnd_.mfok = f_ourmfo and nmsnls_ is not null)
         THEN
       -- �������� � 1 - �����
            gl.REF (ref_);
            nam_a_  := SUBSTR (nmss2909_, 1, 38);
            nlsa_   := nlss2909_;

      nam_b_  := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);

         if mode_ != 15
         then
            nlsb_  := nlskas_;
            okpob_ := f_ourokpo;
            dk_    := 0;
         else
            nlsa_  := skrnd_.nlsk;
            okpoa_ := skrnd_.okpo1;
            nam_a_ := SUBSTR(nmsnls_, 1, 38);
            nam_b_ := SUBSTR (nmss2909_, 1, 38);
            nlsb_  := nlss2909_;
            dk_    := 1;
         end if;
            mfoa_ := gl.amfo;
            mfob_ := gl.amfo;
            nazn_ := '������� ����� �� ������������ ������ � '     || TO_CHAR (skr_.snum)
                       || ' � '                                    || TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy')
                       || ' �� '                                   || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                       || ' , ����� �������� � '                  || TO_CHAR (skrnd_.ndoc)
                       || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy');
        IF skrnpar1_ = 0
        THEN nazn_ := nazn_ || ', � ���.';
        ELSE nazn_ := nazn_ || '.';
        END IF;

       --dk_ := 0;

      gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,tariff3_,kv_,tariff3_,sk_,SYSDATE,bankdate_,
            nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

           -- ����� � ���
           gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,tariff3_,kv_,nlsb_,tariff3_);

           IF NVL (skrnd_.custtype, 3) = 3
           THEN operw_fl (ref_);
           ELSE operw_ul (ref_);
           END IF;

           IF ref_ IS NOT NULL
           THEN
              INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                   VALUES (ref_, bankdate_, skrnd_.nd, 1);
           END IF;
       END IF;

         -- �������� � 2 - ����� - ������ �������� �������
         -- ���� ���� �������� <= ���� ��������� �������� ��� �� ������� �������
         -- olddat2_ < bankdate ������� ����, ��� ��������� ������� ����� ������
         -- ������� �� ��������� ��������� �.�. ��� ������ ������ ����� ���������
         -- ����� ������ ������
     if mode_ = 15 AND ref_ is null
         then
      new_ref_flag := 1;
     end if;

         IF olddat2_ <= bankdate OR olddat2_ IS NULL
         THEN
            IF scperiod_ <> 0
            THEN
               IF new_ref_flag = 1 OR NVL (skrnpar3_, 0) = 0
               THEN
                  gl.REF (ref_);
               END IF;

               --end if;
               sk_    := NULL;
               nam_a_ := SUBSTR (nmss2909_, 1, 38);
               nam_b_ := SUBSTR (nms6519_, 1, 38);
               okpob_ := f_ourokpo;
               nazn_  := '������� ����� �� ������������ ������ � '      || TO_CHAR (skr_.snum)
                            || ' � '                                    || TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy')
                            || ' �� '                                   || TO_CHAR (ADD_MONTHS (d1_, 1), 'dd.mm.yyyy')
                            || ' , ����� �������� � '                  || TO_CHAR (skrnd_.ndoc)
                            || ' �� '                                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                            || ', ��� ���.';
               dk_ := 1;

               IF (new_ref_flag = 1) OR  NVL (skrnpar3_, 0) = 0
               THEN
          new_ref_flag := 0;
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat,
                               vdat, datd, datp, nam_a,
                               nlsa, mfoa, kv, s, nam_b,
                               nlsb, mfob, kv2, s2, nazn,
                               userid, id_a, id_b, sk)
                       VALUES (ref_, tt2_, vob2_, substr(ref_,4,10), dk_, SYSDATE,
                               bankdate_, bankdate_, bankdate_, nam_a_,
                               nlss2909_, mfoa_, kv_, scperiod_, nam_b_,
                               nls6519_, mfob_, kv_, scperiod_, nazn_,
                               userid_, okpoa_, okpob_, sk_);
               END IF;

               gl.payv (0,ref_,bankdate_,tt2_,dk_,kv_,nlss2909_,scperiod_,kv_,nls6519_,scperiod_);

               IF ref_ IS NOT NULL AND ((mode_ = 15 and nmsnls_ is null) OR NVL (skrnpar3_, 0) = 0)
               THEN
          -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
                INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                     VALUES (ref_, bankdate_, skrnd_.nd, 1);
               END IF;
            END IF;
         ELSE
            scperiod_ := 0;
         END IF;

         sfperiod_ := tariff2_ - scperiod_;

         -- �������� � 3 - ����� - ������ �������� �������
         IF sfperiod_ > 0 or snds_ != 0
         THEN
            IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
            THEN
               gl.REF (ref_);
            END IF;

            sk_ := NULL;
            nam_a_ := SUBSTR (nmss2909_, 1, 38);
            nam_b_ := SUBSTR (nms3600_, 1, 38);
            okpob_ := f_ourokpo;

            IF scperiod_ <> 0
            THEN
               nazn_ :=
                     '������� ����� �� ������������ ������ � '
                  || TO_CHAR (skr_.snum)
                  || ' � '
                  || TO_CHAR (ADD_MONTHS (d1_, 1) + 1, 'dd.mm.yyyy')
                  || ' �� '
                  || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                  || ' , ����� �������� � '
                  || TO_CHAR (skrnd_.ndoc)
                  || ' �� '
                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || ', ��� ���.';
            ELSE
               nazn_ :=
                     '������� ����� �� ������������ ������ � '
                  || TO_CHAR (skr_.snum)
                  || ' � '
                  || TO_CHAR (skrnd_.dat_begin, 'dd.mm.yyyy')
                  || ' �� '
                  || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                  || ' , ����� �������� � '
                  || TO_CHAR (skrnd_.ndoc)
                  || ' �� '
                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || ', ��� ���.';
            END IF;

            dk_ := 1;

            IF (new_ref_flag = 1) OR NVL (skrnpar3_, 0) = 0
            THEN
         new_ref_flag := 0;
               INSERT INTO oper
                           (REF, tt, vob, nd, dk, pdat,
                            vdat, datd, datp, nam_a,
                            nlsa, mfoa, kv, s, nam_b,
                            nlsb, mfob, kv2, s2, nazn, userid,
                            id_a, id_b, sk
                           )
                    VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE,
                            bankdate_, bankdate_, bankdate_, nam_a_,
                            nlss2909_, mfoa_, kv_, sfperiod_, nam_b_,
                            nls3600_, mfob_, kv_, sfperiod_, nazn_, userid_,
                            okpoa_, okpob_, sk_
                           );
            END IF;

            -- ������ �������� �������
            gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,sfperiod_,kv_,nls3600_,sfperiod_);

            IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
            THEN
        -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
        INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
           VALUES (ref_, bankdate_, skrnd_.nd, 1);
      END IF;

            -- �������� � 4 - ����� - �������� ���
            IF (snds_ > 0)
            THEN
            IF nlsnds_ IS NOT NULL
            THEN
               IF NVL (skrnpar3_, 0) = 0
               THEN
                  gl.REF (ref_);
               END IF;

               sk_    := NULL;
               nam_a_ := SUBSTR (nmss2909_, 1, 38);
               nam_b_ := SUBSTR (nmsnds_, 1, 38);
               okpob_ := f_ourokpo;
               nazn_ :=
                     '��� �� ������������ ������ � '
                  || TO_CHAR (skr_.snum)
                  || ' � '
                  || TO_CHAR (ADD_MONTHS (d1_, 1) + 1, 'dd.mm.yyyy')
                  || ' �� '
                  || TO_CHAR (skrnd_.dat_end, 'dd.mm.yyyy')
                  || ' , ����� �������� � '
                  || TO_CHAR (skrnd_.ndoc)
                  || ' �� '
                  || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')
                  || '.';
               dk_ := 1;

               IF NVL (skrnpar3_, 0) = 0
               THEN
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat,
                               vdat, datd, datp, nam_a,
                               nlsa, mfoa, kv, s, nam_b,
                               nlsb, mfob, kv2, s2, nazn, userid,
                               id_a, id_b, sk
                              )
                       VALUES (ref_, tt3_, vob3_, substr(ref_,4,10), dk_, SYSDATE,
                               bankdate_, bankdate_, bankdate_, nam_a_,
                               nlss2909_, mfoa_, kv_, snds_, nam_b_,
                               nlsnds_, mfob_, kv_, snds_, nazn_, userid_,
                               okpoa_, okpob_, sk_
                              );
               END IF;

               -- ������ �������� �������
               gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,snds_,kv_,nlsnds_,snds_);

               IF ref_ IS NOT NULL AND NVL (skrnpar3_, 0) = 0
               THEN
          -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
                INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
                     VALUES (ref_, bankdate_, skrnd_.nd, 1);
                END IF;
              END IF;
            END IF;
         END IF;
      END IF;
   END;

-- *******************************************************************************
--            ������ ����������
--    par_ == nd
-- *******************************************************************************
PROCEDURE overdue_payment (dat_    IN DATE,
                           dat2_   IN DATE,
                           n_sk_   IN NUMBER,
                           mode_   IN NUMBER,
                           par_    IN NUMBER)
IS
      tipt_   NUMBER;
      dpr_    NUMBER;
    nTmp    INTEGER;
    nAcc    NUMBER(38);
    nSND    NUMBER(38);
    nlsk_  skrynka_nd.nlsk%type;
    mfok_  skrynka_nd.mfok%type;
    nmk_   skrynka_nd.nmk%type;
    nmsnls_  accounts.nms%type;
    l_count int;
      l_dat   date;
    ob22_ SPECPARAM_INT.OB22%type;      -- ob22
  begin
    -- ���� ��������� ���� - ����� �� ������
    IF dat_+1 <= skrnd_.dat_end OR dat2_ < dat_
      THEN
    bars_error.raise_nerror(l_mod, 'PROLONG_DATES_ERROR', par_);
      END IF;

    -- �������� � �������������� ��������� �� ������� �����

    SELECT a.nms,
           a.nls,
           n.nlsk,
           n.mfok,
           n.nmk
      INTO nms3600_,
           nls3600_,
           nlsk_,
           mfok_,
           nmk_
      FROM skrynka_nd_acc s, accounts a, skrynka_nd n
     WHERE s.tip = 'D' AND s.nd = n.nd AND s.acc = a.acc AND n.nd = par_;

     l_dat := skrnd_.dat_end;

    -- ���� ���� �������� ������� �� �������� ����, �� �� ������ �� ������ ������� ����
    SELECT COUNT (fdat), MIN (fdat)
      INTO l_count, l_dat
      FROM fdat
     WHERE fdat BETWEEN skrnd_.dat_end
       AND TRUNC (SYSDATE);

    IF l_count = 1
    THEN l_dat := l_dat;
    ELSE l_dat := skrnd_.dat_end;
    END IF;

    IF skrnd_.imported = 1
    then
    s_ := GREATEST ((1 + skrnd_.peny/100/365) * skrnd_.sd * (dat_ - l_dat ), 0);
  else
      SELECT tip
        INTO tipt_
        FROM skrynka_tariff st
       WHERE st.tariff = skrnd_.tariff;

      skrn.p_tariff (skrnd_.tariff, dat_, dat2_, bankdate_);

      -- ����� ���������
      IF tipt_ = 1
      THEN
         s_ := GREATEST (100 * peny_ * (dat_ - l_dat ), 0);
      ELSIF tipt_ = 2
      THEN


     -- ���� �� ������������ ����� SBER
    dpr_ := GREATEST (dat_ - l_dat , 0);
    s_ := skrnd_.sd* dpr_;

      END IF;

  END IF;

    if mode_ = 17
    then
     BEGIN
         SELECT nms
           INTO nmskas_
           FROM accounts
          WHERE nls = skrnd_.nlsk
            AND kv = '980'
            AND kf = skrnd_.mfok;
     EXCEPTION WHEN NO_DATA_FOUND
               THEN bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
                    -- ������� �볺��� �� ��������� ��� ��������� �� ����
     END;
    end if;


  IF NVL (s_, 0) > 0
  THEN
    -- �������� 1 ���������
    gl.REF (ref_);

    if mode_ = 17 and mfok_ = f_ourmfo
    then
     mfoa_  := gl.amfo;
   nlsa_  := nlsk_;
     nam_a_ := SUBSTR (nmk_, 1, 38);
     mfob_  := gl.amfo;
   nlsb_  := nls6397_;
   nam_b_ := SUBSTR (nms6397_, 1, 38);
   dk_    := 1;

    else     -- mode_ =  18
   mfoa_  := gl.amfo;
   nlsa_  := nls6397_;
     nam_a_ := SUBSTR (nms6397_, 1, 38);
   mfob_  := gl.amfo;
   nlsb_  := nlskas_;
   nam_b_ := SUBSTR (nmskas_, 1, 38);
     dk_    := 0;
  end if;

     nazn_ := '������ ������ �� ����� � '      || to_char(l_dat+1,'dd.mm.yyyy') || ' �� ' || to_char(dat_,'dd.mm.yyyy')
      --   || ' �����  ��� ���. ' || TO_CHAR (skrnd_.nd)  || '. ��� ��� (���� �'
      --   || TO_CHAR (skr_.snum) || ').';
                || ' , ����� �������� � '      || TO_CHAR (skrnd_.ndoc)
                || ' �� '                      || TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy');

     gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,s_,kv_,s_,sk_,SYSDATE,bankdate_,nam_a_,nlsa_,mfoa_,
          nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

     IF nlsa_ IS NOT NULL
     THEN
        gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,s_,kv_,nlsb_,s_);
     END IF;

     IF ref_ IS NOT NULL
     THEN
        INSERT INTO skrynka_nd_ref(REF, bdate, nd)
             VALUES (ref_, bankdate_, skrnd_.nd);
     END IF;

     IF NVL (skrnd_.custtype, 3) = 3
     THEN
        operw_fl (ref_);
     ELSE
        operw_ul (ref_);
     END IF;

  END IF;

   -- ������� ����� �� ������������ �����
   if  tipt_ != -1
   then
      p_calc_tariff (n_sk_, par_);
    /*      p_oper_arenda_period (skrnd_.dat_end + 1,
                               dat_,
                               n_sk_,
                               mode_,
                               par_);  */

      skrn.p_calcperiod_tariff (skrnd_.dat_end + 1, dat_, skrnd_.nd, par_);

      IF  mode_ = 15
      THEN
        BEGIN
           SELECT nms
             INTO nmsnls_
             FROM accounts
            WHERE nls = skrnd_.nlsk
              AND kv = '980'
              AND kf = skrnd_.mfok;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN nmsnls_ := NULL;
                bars_error.raise_nerror (l_mod, 'NOT_NLK_CLIENT', n_sk_);
        END;

      END IF;
     -- ��� 15 - ���� �������� �� ����
      IF mode_ != 15 or (skrnd_.mfok = f_ourmfo and nmsnls_ is not null)
      THEN
    -- �������� � 1 - �����
      gl.REF (ref_);
      nam_a_  := SUBSTR (nmss2909_, 1, 38);
    nlsa_   := nlss2909_;
        --nam_a_ := SUBSTR(COALESCE (skrnd_.fio, skrnd_.nmk), 1, 38);

         IF mode_ != 15 THEN
            nam_a_  := SUBSTR (nmss2909_, 1, 38);
            nlsa_   := nlss2909_;
            nlsb_   := nlskas_;
            okpob_  := f_ourokpo;
            nam_b_  := SUBSTR (nmskas_, 1, 38);
            dk_     := 0;
         ELSE
            nlsa_   := skrnd_.nlsk;
            okpoa_  := skrnd_.okpo1;
            nam_a_  := SUBSTR(nmsnls_, 1, 38);
            nam_b_  := SUBSTR (nmss2909_, 1, 38);
            nlsb_   := nlss2909_;
            dk_     := 1;
         END IF;
     mfoa_ := gl.amfo;
     mfob_ := gl.amfo;

     nam_b_ := SUBSTR(skrnd_.fio, 1, 38);
     nazn_  := '������� ����� �� ������������ ������ � '|| TO_CHAR (skr_.snum)|| ' �� ����� � '|| to_char(skrnd_.dat_end+1,'dd.mm.yyyy')|| '�. �� '
              || TO_CHAR (dat_, 'dd.mm.yyyy')|| '�., ����� �������� � '|| skrnd_.ndoc|| ' �� '|| TO_CHAR (skrnd_.docdate, 'dd.mm.yyyy')|| '�.';

        IF skrnpar1_ = 0
        THEN nazn_ :=SUBSTR (   nazn_|| ' � �.�. ��� '|| TRIM (TO_CHAR (snds1_ / 100, '9999999990.00'))|| ' ���.',1,160);
    ELSE nazn_ := nazn_ || '.';
    END IF;

    -- ���� ���� ������ ����� ���� 0 �� �������. ����� ���������� �� ���������.
    if  sb1_ <= 0 then return; else null; end if;

    gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sb1_,kv_,sb1_,sk_,SYSDATE,bankdate_,nam_a_,nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);
        -- ����� � ���
        gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sb1_,kv_,nlsb_,tariff3_);

    dk_ := 1;
         -- ������
        IF sc1_ IS NOT NULL AND sc1_ > 0 AND nls6519_ IS NOT NULL THEN
        gl.payv (0,ref_,bankdate_,tt2_,dk_,kv_,nlss2909_,sc1_+sf1_,kv_,nls6519_,scperiod_);
    end if;

      IF nlsnds_ IS NOT NULL AND snds1_ IS NOT NULL AND snds1_ > 0  THEN
    -- ���
         gl.payv (0,ref_,bankdate_,tt3_,dk_,kv_,nlss2909_,snds1_,kv_,nlsnds_,snds1_);
    end if;

    IF ref_ IS NOT NULL
      THEN
        -- ������������ ��� ����� ������, ��� �������� ������ � ��������� ���������
        INSERT INTO skrynka_nd_ref(REF, bdate, nd, rent)
           VALUES (ref_, bankdate_, skrnd_.nd, 1);
    END IF;

      IF NVL (skrnd_.custtype, 3) = 3
      THEN operw_fl (ref_);
      ELSE operw_ul (ref_);
      END IF;

      end if;
   end if;




end overdue_payment;

-- *******************************************************************************
--            �����������
--    par_ == nd
-- *******************************************************************************
   PROCEDURE p_oper_prolong (
      dat_    DATE,
      dat2_   DATE,
      n_sk_   NUMBER,
      mode_   NUMBER,
      par_    NUMBER,
    p_extnd varchar2)
   IS
      tipt_     NUMBER;
      dpr_      NUMBER;
    nTmp      INTEGER;
    nAcc      NUMBER(38);
    nSND      NUMBER(38);
    nlsk_     skrynka_nd.nlsk%type;
    mfok_     skrynka_nd.mfok%type;
    nmk_      skrynka_nd.nmk%type;
    ob22_     SPECPARAM_INT.OB22%type;      -- ob22
   BEGIN
    --����������� � ��������� ��������� �� ��������� ���������� �� ���
   overdue_payment(dat_-1, dat2_-1, n_sk_, mode_, par_);

    /*
    -- ���� ��������� ���� - ����� �� ������
    IF dat_ <= skrnd_.dat_end OR dat2_ < dat_
      THEN
    bars_error.raise_nerror(l_mod, 'PROLONG_DATES_ERROR', par_);
      END IF;

    -- �������� � �������������� ��������� �� ������� �����

    select a.nms,  a.nls,    n.nlsk, n.mfok,  n.nmk
    into nms3600_, nls3600_, nlsk_,  mfok_,   nmk_
    from skrynka_nd_acc s, accounts a, skrynka_nd n
    where s.tip = 'D' and s.nd = n.nd and s.acc = a.acc and n.nd = par_;


    if skrnd_.imported = 1 then
      s_ := GREATEST ((1 + skrnd_.peny/100/365) * skrnd_.sd * (dat_ - skrnd_.dat_end - 1), 0);
    else

      SELECT tip
        INTO tipt_
        FROM skrynka_tariff st
       WHERE st.tariff = skrnd_.tariff;

      skrn.p_tariff (skrnd_.tariff, dat_, dat2_, bankdate_);

      -- ����� ���������
      IF tipt_ = 1
      THEN
         s_ := GREATEST (100 * peny_ * (dat_ - skrnd_.dat_end - 1), 0);
      ELSIF tipt_ = 2
      THEN
         dpr_ := GREATEST (dat_ - skrnd_.dat_end - 1, 0);
         s_ := 100 * peny_ * dpr_;
      END IF;

    end if;

    if mode_ = 17 then
         Begin
             SELECT nms
               INTO nmskas_
               FROM accounts
              WHERE nls = skrnd_.nlsk AND kv = '980' and kf = skrnd_.mfok;
         EXCEPTION  WHEN NO_DATA_FOUND THEN
                    bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        -- ������� �볺��� �� ��������� ��� ��������� �� ����
        End;
     end if;


      IF NVL (s_, 0) > 0
      THEN
         -- �������� 1 ���������
         gl.REF (ref_);

    if mode_ = 17 and mfok_ = f_ourmfo then

       mfoa_ := gl.amfo;
     nlsa_ := nlsk_;
         nam_a_ := SUBSTR (nmk_, 1, 38);

     mfob_ := gl.amfo;
     nlsb_ := nls6397_;
     nam_b_ := SUBSTR (nms6397_, 1, 38);

      dk_ := 1;

    else     -- mode_ =  18
       mfoa_ := gl.amfo;
     nlsa_ := nls6397_;
     nam_a_ := SUBSTR (nms6397_, 1, 38);

     mfob_ := gl.amfo;
     nlsb_ := nlskas_;
     nam_b_ := SUBSTR (nmskas_, 1, 38);
         dk_ := 0;
  end if;

         nazn_ :=
               '������ ������ �� ����� � ' || to_char(skrnd_.dat_end+1,'dd.mm.yyyy') || ' �� ' || to_char(dat_-1,'dd.mm.yyyy')
         || ' �����  ��� ���. ' || TO_CHAR (skrnd_.nd)  || '. ��� ��� (���� �'
         || TO_CHAR (skr_.snum) || ').';

--         dk_ := 0;

         gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,s_,kv_,s_,sk_,SYSDATE,bankdate_,nam_a_,nlsa_,mfoa_,
            nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

         IF nlsa_ IS NOT NULL
         THEN
            gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,s_,kv_,nlsb_,s_);
         END IF;

         IF ref_ IS NOT NULL
         THEN
            INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                 VALUES (ref_, bankdate_, skrnd_.nd);
         END IF;

     IF NVL (skrnd_.custtype, 3) = 3
     THEN
      operw_fl (ref_);
     ELSE
      operw_ul (ref_);
     END IF;

   END IF;
*/

      IF dat_ > skrnd_.dat_end AND dat2_ >= dat_
      THEN
         IF dat2_ >= dat_
         THEN
      nSND :=bars_sqnc.get_nextval('s_cc_deal');
            SELECT rnk
              INTO def_rnk_
              FROM customer a
             WHERE a.rnk = (SELECT TO_NUMBER (val)
                              FROM branch_parameters
                             WHERE tag = 'DEP_SKRN' AND branch = branch_);

            SELECT TO_NUMBER (val)
              INTO otvisp_
              FROM branch_parameters
             WHERE tag = 'DEP_ISP' AND branch = branch_;

            SELECT TO_NUMBER (val)
              INTO grp_
              FROM branch_parameters
             WHERE tag = 'DEP_GRP' AND branch = branch_;

      Op_Reg_Ex(99, 0, 0, grp_, nTmp, def_rnk_,
        substr(f_newnls2(null,'SD_DR','3600',def_rnk_,null,null),1,14), 980,
        substr('���. ����. ����. ���. ��� ����. �����  �' || skrnd_.n_sk ,1, 70),
        'ODB', otvisp_, nAcc, '1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sys_context('bars_context','user_branch'),NULL);

            SELECT (CASE WHEN skrnd_.custtype = 3 THEN ob22 ELSE ob22_u END)
              INTO ob22_
              FROM SKRYNKA_ACC_TIP
             WHERE tip = 'D';

            accreg.setAccountSParam (nAcc, 'OB22', ob22_);


      INSERT into skrynka_nd_acc (acc,nd,tip)
      values (nAcc,nSND,'D');

      -- ����� ����� ����
      skrnd_.ndoc := nvl(p_extnd, skrnd_.ndoc);

      insert into skrynka_nd
         (nd, sos, n_sk, ndoc, dat_begin, dat_end, custtype,
        fio, dokum, issued, adres,
          tel, nmk, nlsk, mfok, fio2, pasp2,
        issued2, adres2, dov_dat1, dov_dat2,
          isp_dov, ndov, tariff, docdate, sdoc,
        okpo1, okpo2, keycount, datr,
          mr, datr2, mr2, rnk)
        values(nSND, 1, skrnd_.n_sk, skrnd_.ndoc, dat_,dat2_, skrnd_.custtype,
               skrnd_.fio, skrnd_.dokum, skrnd_.issued, skrnd_.adres,
               skrnd_.tel, skrnd_.nmk, skrnd_.nlsk, skrnd_.mfok, skrnd_.fio2, skrnd_.pasp2,
               skrnd_.issued2, skrnd_.adres2, skrnd_.dov_dat1, skrnd_.dov_dat2,
               skrnd_.isp_dov, skrnd_.ndov, skrnd_.tariff, sysdate , skrnd_.sdoc,
           skrnd_.okpo1, skrnd_.okpo2, skrnd_.keycount, skrnd_.datr,
           skrnd_.mr, skrnd_.datr2, skrnd_.mr2, skrnd_.rnk);

            UPDATE skrynka_nd
               SET sdoc =
                      (SELECT s * 100
                         FROM skrynka_tip t, skrynka s
                        WHERE t.o_sk = s.o_sk AND s.n_sk = skrnd_.n_sk)
             WHERE nd = nSND
       RETURNING  sdoc INTO  skrnd_.sdoc;

            UPDATE accounts
               SET mdate = dat2_
             WHERE acc = mainacc_.acc;

            UPDATE specparam
               SET R011 = (skrnd_.custtype - 1)
             WHERE acc = mainacc_.acc;
            IF SQL%ROWCOUNT = 0 then
        INSERT INTO SPECPARAM(acc,R011)
        values (mainacc_.acc, (skrnd_.custtype - 1));
      END IF;

      insert into cc_docs(id,nd,adds,version,state,comm,text,doneby)
            SELECT id,
                   nSND,
                   adds,
                   version,
                   state,
                   comm,
                   text,
                   doneby
              FROM cc_docs
             WHERE nd = skrnd_.nd;

      insert into nd_txt(nd,tag,txt)
            SELECT nSND, n.tag, SUBSTR (n.txt, 1, 254)
              FROM nd_txt n
             WHERE n.nd = skrnd_.nd;

         END IF;

         -- ������ ����� �������� �����

         -- ���������� ������ ���� ������
        olddat_    := skrnd_.dat_begin;
        olddat2_   := skrnd_.dat_end;
     --
        if mode_ = 17 and mfok_ = f_ourmfo
        then --������
          p_dep_skrn (dat_, dat2_, n_sk_, 15, nSND);
        else
              p_dep_skrn (dat_, dat2_, n_sk_, 14, nSND);
    end if;

    -- г����� �������� �����

    If ostc2909_ <  skrnd_.sdoc then
      If  mode_ = 18
         then  p_dep_skrn (dat_, dat2_, n_sk_, 10, nSND, null,  skrnd_.sdoc-ostc2909_);
         else  p_dep_skrn (dat_, dat2_, n_sk_, 11, nSND, null,  skrnd_.sdoc-ostc2909_);
      end if;
        end if;

    END IF;
   END;

--------------------------------------------------------------------------------------------------------------------------------------------------------
--            ����������� ��� ������� ��������
--------------------------------------------------------------------------------------------------------------------------------------------------------
   PROCEDURE p_final_amort ( nd_   IN NUMBER)
   IS
      splan_      NUMBER;
      sopl_       NUMBER;
      sdoc_       NUMBER;
    l_month     NUMBER;
    l_month_let varchar2(20);
   BEGIN
  FOR k IN (    SELECT n.n_sk, sk.snum, n.nd, a.nls, a.kv, n.dat_begin, n.dat_end,
                         a.ostc, ROUND (skrn.f_get_oplplan_sum (n.nd) * 5 / 6) s1,
                         skrn.f_get_curdoh_sum (n.nd) s2,
                         skrn.f_get_3600_sum (n.nd) s3,
                         skrn.f_get_3600_sum (n.nd) sp2, n.CUSTTYPE,
             a.branch
                    FROM skrynka_nd n, skrynka_acc s, accounts a, skrynka sk
                   WHERE n.n_sk = s.n_sk
           AND n.nd = nd_
                     AND a.ostc = a.ostb
                     AND s.acc = a.acc
                     AND s.tip = 'M'
                     AND n.n_sk = sk.n_sk)
      LOOP
     init(null);
     -- ��������� ������� 6519 �������� ���� �볺���
         p_nls_6519(k.CUSTTYPE);
         sdoc_ := k.sp2;

         IF sdoc_ > 0
         THEN
            nazn_ := '������ ������� ������ �� ����� � '
      || LPAD (TO_CHAR (k.snum), 3, '0') || ' (�������� ' || k.branch || ' )' ||
      ' ���.���. ' || TO_CHAR (k.nd) || '. ��� ���.';
            -- ��������� ���������
            gl.REF (ref_);

            SELECT SUBSTR (a.nms, 1, 38), a.nls
              INTO nms3600_, nls3600_
              FROM skrynka_nd_acc s, accounts a, skrynka_nd n
             WHERE s.tip = 'D' AND s.nd = n.nd AND s.acc = a.acc AND n.nd = k.nd;

      nlsa_   := nls3600_;
            nam_a_  := SUBSTR (nms3600_, 1, 38);
            --okpoa_ := skrnd_.okpo1;
            mfoa_   := gl.amfo;
            nlsb_   := nls6519_;
            nam_b_  := SUBSTR (nms6519_, 1, 38);
            --okpob_ := skrnd_.okpo1;
            okpob_  := f_ourokpo;
            mfob_   := gl.amfo;
            dk_     := 1;
            sk_     := NULL;
            kv_     := 980;
            gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sdoc_,kv_,sdoc_,sk_,bankdate_,bankdate_,nam_a_,
            nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);
            gl.payv (2,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sdoc_,kv_,nlsb_,sdoc_);

            IF ref_ IS NOT NULL
            THEN
              INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                   VALUES (ref_, bankdate_, k.nd);
            END IF;

      -- ������ ����������� ���� �������� �����������
            UPDATE skrynka_nd
               SET amort_date = dat_end
             WHERE nd = k.nd;
         END IF;
      END LOOP;
   END;
----------------------------------------------------------------------------
--    �����������
----------------------------------------------------------------------------
PROCEDURE p_oper_amort_doh (dat_    IN DATE,
                            dat2_   IN DATE,
                            n_sk_   IN NUMBER,
                            mode_   IN NUMBER,
                            par_    IN NUMBER DEFAULT NULL)
   IS
      splan_        NUMBER;
      sopl_         NUMBER;
      sdoc_         NUMBER;
    l_month     NUMBER;
    l_month_let varchar2(20);
   BEGIN
  FOR k IN (    SELECT n.n_sk, sk.snum, n.nd, a.nls, a.kv, n.dat_begin, n.dat_end,
                         a.ostc,n.amort_date,
                         ROUND (skrn.f_get_oplplan_sum (n.nd) * 5 / 6) s1,
                         skrn.f_get_curdoh_sum (n.nd) s2,
                         skrn.f_get_3600_sum (n.nd) s3,
                         LEAST (  ROUND (skrn.f_get_oplplan_sum_4date (n.nd, last_day(bankdate))  * 5 / 6)
                                - skrn.f_get_curdoh_sum (n.nd),
                                skrn.f_get_3600_sum (n.nd)
                               ) sp2,
             LEAST ( ROUND(f_get_oplplan_sum_4period(n.nd, n.amort_date+1, least(last_day(bankdate),n.dat_end)) * 5/6 ),
                                skrn.f_get_3600_sum (n.nd)) sp3, n.CUSTTYPE,
               a.branch
                    FROM skrynka_nd n, skrynka_acc s, accounts a, skrynka sk
                   WHERE n.n_sk = s.n_sk
                     AND s.acc = a.acc
                     AND s.tip = 'M'
                     AND n.sos <> 15
                     AND n.n_sk = sk.n_sk
           AND ((skrn.f_get_opl_sum (n.nd) > 0 AND
               ROUND (skrn.f_get_oplplan_sum_4date(n.nd,last_day(bankdate)) * 5 / 6) <> skrn.f_get_curdoh_sum (n.nd) )
               OR
              (n.amort_date is not null)
              )
                ORDER BY n_sk)
      LOOP
     init(null);
     -- ��������� ������� 6519 �������� ���� �볺���
         p_nls_6519(k.CUSTTYPE);

     IF k.amort_date is not null
     then
      sdoc_ := k.sp3;
         ELSE
            sdoc_ := k.sp2;
         END IF;

         IF sdoc_ > 0
         THEN
            nazn_ := '������ ������� ������ �� ����� � '
     || LPAD (TO_CHAR (k.snum), 3, '0') || ' (�������� ' || k.branch || ' )' ||
      ' ���.���. ' || TO_CHAR (k.nd) || '. ��� ���.';
            -- ��������� ���������
            gl.REF (ref_);

            SELECT SUBSTR (a.nms, 1, 38), a.nls
              INTO nms3600_, nls3600_
              FROM skrynka_nd_acc s, accounts a, skrynka_nd n
             WHERE s.tip = 'D' AND s.nd = n.nd AND s.acc = a.acc AND n.nd = k.nd;

      nlsa_   := nls3600_;
            nam_a_  := SUBSTR (nms3600_, 1, 38);
          --okpoa_  := skrnd_.okpo1;
            mfoa_   := gl.amfo;
            nlsb_   := nls6519_;
            nam_b_  := SUBSTR (nms6519_, 1, 38);
          --okpob_  := skrnd_.okpo1;
            okpob_  := f_ourokpo;
            mfob_   := gl.amfo;
            dk_     := 1;
            sk_     := NULL;
            kv_     := 980;
            gl.in_doc3 (ref_,tt_,vob_,substr(ref_,4,10),SYSDATE,bankdate_,dk_,kv_,sdoc_,kv_,sdoc_,sk_,bankdate_,bankdate_,nam_a_,
            nlsa_,mfoa_,nam_b_,nlsb_,mfob_,nazn_,NULL,okpoa_,okpob_,NULL,NULL,0,NULL,null);

            gl.payv (0,ref_,bankdate_,tt_,dk_,kv_,nlsa_,sdoc_,kv_,nlsb_,sdoc_);

            IF ref_ IS NOT NULL
            THEN
              INSERT INTO skrynka_nd_ref(REF, bdate, nd)
                   VALUES (ref_, bankdate_, k.nd);
            END IF;
      -- ������ ����������� ���� �������� �����������
            UPDATE skrynka_nd
               SET amort_date = LEAST (LAST_DAY (bankdate), dat_end)
             WHERE nd = k.nd;
         END IF;
      END LOOP;
-- �������� ����������� � �� �������� ���������. ����� �������� � ������� 3600
  FOR k IN (    SELECT n.nd
                    FROM skrynka_nd n, skrynka_nd_acc sa, accounts a
                   WHERE n.sos = 15
                     AND n.nd = sa.nd
                     AND sa.acc = a.acc
                     AND a.ostc = a.ostb
                     AND skrn.f_get_3600_sum (n.nd) > 0
                ORDER BY n.n_sk)
  LOOP
    p_final_amort(k.nd);
  END LOOP;


END;

/*
*    ����� ���� �� ���������� ��������� � ������� ����� �� ����� ������������ ������������� ������
*/
PROCEDURE p_commis_of_attorney (dat_    IN DATE,
                          dat2_   IN DATE,
                          n_sk_   IN NUMBER,
                          mode_   IN NUMBER,
                          par_    IN NUMBER,
                          ref_    IN NUMBER DEFAULT NULL)
 IS
  nls6397_    accounts.nls%type;
  nms6397_    accounts.nms%type;
  nls2600_    accounts.nls%type;
    nms2600_    accounts.nms%type;
    tax_        number;
  opr         oper%rowtype;
  l_ob22      accounts.ob22%type;
BEGIN
  /*
    ��������� ������������ ������ ��������� �����, � ����:
    �������� �������� ��� ������ ���� �� ���������� ��������� � ������� ����� �� ����� ������������ ������������� ������.
    ������������� ������ �� ��������� ��������:
    �� 1002/01, ������ ������� �볺��� �� 3739/03
    �� 3739/03 �� 6110/28,29 � ���� ���� ��� ���
    �� 3739/03 �� 3622/51 � ���.
  */

        IF NVL (skrnd_.custtype, 3) = 3
        THEN l_ob22 := '28';
        ELSE l_ob22 := '29';
        END IF;

     begin
     if newnbs.g_state = 0 then
     select nls,      substr(nms,1,38)
       into opr.nlsb, opr.nam_b
       from accounts
      where   nls =  NBS_OB22_NULL('6110', l_ob22);
     else
     select nls,      substr(nms,1,38)
       into opr.nlsb, opr.nam_b
       from accounts
      where   nls =  NBS_OB22_NULL('6510', l_ob22);
     end if;
     exception when no_data_found then bars_audit.info('������� ��������� ����� 3622/51 �� ��������');
     end;


     -- vob3_  ��������� ��� ������


   if mode_ = 29    -- ����� ����
     then
     opr.nlsa      := nlskas_;
       opr.nam_a     := substr(nmskas_,1,38) ;
     else           -- ������ 30
        BEGIN
         SELECT nms, nls
           INTO nms2600_, nls2600_
           FROM accounts
          WHERE nls = skrnd_.nlsk AND kv = '980';
        EXCEPTION  WHEN NO_DATA_FOUND THEN
                    bars_error.raise_nerror(l_mod, 'NOT_NLK_CLIENT', n_sk_);
        -- ������� �볺��� �� ��������� ��� ��������� �� ����
        END;
           opr.nlsa      := nls2600_;
           opr.nam_a     := substr(nms2600_,1,38) ;

   end if;



       opr.id_a      := skrnd_.okpo1;
     opr.id_b      := f_ourokpo;
     opr.tt        := tt_;
     opr.vob       := vob_;
     opr.sk        := sk_;
       opr.s         := case when par_ = 0 then f_tarif(KOD_ => vob3_, KV_ => 980, NLS_ => '', S_ => 0, KVK_ => null, DAT_ => gl.bd) else par_*100 end;
     opr.nazn      := '������ ���� �� ���������� ��������� �� ����� �'||skr_.snum||' (������ �'||skrnd_.ndoc||')';
     opr.sos       := 1;

     if opr.s <= 0
     then return;
     end if;

   if ref_ is null
     then
        gl.ref (opr.REF);

        gl.in_doc3( ref_   => opr.REF,                    tt_    => opr.tt ,    vob_   => opr.vob,     nd_    => substr(to_char(opr.REF),1,10),
          pdat_  => SYSDATE ,                   vdat_  => gl.BDATE,   dk_    => 1,
                kv_    => gl.baseval,   s_     => opr.s,      kv2_   => gl.baseval,  s2_    => opr.s,
          sk_    =>  opr.sk  ,                  data_  => gl.bdate ,  datp_  => gl.bdate ,
          nam_a_ => substr(opr.nam_a,1,38),     nlsa_  => opr.nlsa ,  mfoa_  => gl.aMfo  ,
          nam_b_ => substr(opr.nam_b,1,38),     nlsb_  => opr.nlsb ,  mfob_  => gl.aMfo  ,
                nazn_  => substr(opr.nazn,1,158),
                d_rec_ => null,                        id_a_  => opr.id_b ,     id_b_  => opr.id_a ,          id_o_  => null,
          sign_  => null,                       sos_   => opr.sos,          prty_  => null,        uid_   => null);

     else opr.ref  := ref_;
     end if;


        IF opr.REF IS NOT NULL     THEN

         insert into operw (ref, tag, value)  values ( opr.REF, 'PDV', '1' );

         GL.dyntt2(SOS_     => opr.sos,            MOD1_    => 1,            MOD2_    => 0,
             REF_     => opr.REF,        VDAT1_   => gl.BDATE,     VDAT2_   => gl.BDATE,
             TT0_     => opr.tt,         DK_      => 1,              SA_      => opr.s,
             KVA_     => gl.baseval,       MFOA_    => gl.aMfo,      NLSA_    => opr.nlsa,
             KVB_     => gl.baseval,       MFOB_    => gl.aMfo,      NLSB_    => opr.nlsb,
             SB_      => opr.s,          SQ_      => opr.s,        NOM_     => null);

            INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                 VALUES (opr.REF,  gl.bdate,  skrnd_.nd);

    END IF;

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (opr.REF);
        ELSE operw_ul (opr.REF);
        END IF;


end;

/*
*    �������� ����� � ��� ����������� ���� ��� �������� ������ �����
*/
PROCEDURE p_cost_of_bank (dat_    IN DATE,
                          dat2_   IN DATE,
                          n_sk_   IN NUMBER,
                          mode_   IN NUMBER,
                          par_    IN NUMBER,
                          ref_    IN NUMBER DEFAULT NULL)
 IS
  nls6397_    accounts.nls%type;
  nms6397_    accounts.nms%type;
  nls3622_    accounts.nls%type;
        nms3622_    accounts.nms%type;
        tax_        number;
  opr         oper%rowtype;
BEGIN
   BEGIN
        SELECT a.nls, SUBSTR (a.nms, 1, 38), f_ourokpo
             INTO   opr.nlsb, opr.nam_b, opr.id_b
             FROM accounts a
            WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S11' AND branch = branch_)
               AND a.kv = 980;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S11');
    END;

   nls3622_ := NBS_OB22_NULL('3622', '51');

    begin
     select substr(nms,1,38)
       into nms3622_
       from accounts
      where nbs = '3622'
        and nls = nls3622_;
    exception when no_data_found then bars_audit.info('������� ��������� ����� 3622/51 �� ��������');
    end;


       opr.id_a      := skrnd_.okpo1;
     opr.tt        := tt_;
     opr.vob       := vob_;
     opr.nlsa      := nlskas_;
       opr.nam_a     := substr(nmskas_,1,38) ;
       opr.s         := nvl(par_,0)*100;
     opr.nazn      := '�������� ����� � ��� ����������� ���� ��� �������� ������ ����� �� ����� �� ����� �'||skr_.snum||' � ��� �� ������ (������ �'||skrnd_.ndoc||')';

     if opr.s <= 0
     then return;
     end if;

   if ref_ is null
     then
        gl.ref (opr.REF);

        gl.in_doc3(ref_  => opr.REF,       tt_    => opr.tt ,    vob_   => opr.vob,     nd_    => substr(to_char(opr.REF),1,10),
                pdat_  => SYSDATE ,     vdat_  => gl.BDATE,   dk_    => 0,
                kv_    => gl.baseval,   s_     => opr.s,      kv2_   => gl.baseval,  s2_    => opr.s,
                sk_    =>  32 ,       data_  => gl.bdate ,   datp_  => gl.bdate ,
                nam_a_ => substr(opr.nam_b,1,38),     nlsa_  => opr.nlsb ,       mfoa_  => gl.aMfo  ,
                nam_b_ => substr(opr.nam_a,1,38),     nlsb_  => opr.nlsa ,       mfob_  => gl.aMfo  ,
                nazn_  => substr(opr.nazn,1,158),
                d_rec_ => null,                        id_a_  => opr.id_b ,     id_b_  => opr.id_a ,          id_o_  => null,
                sign_  => null,                        sos_   => 1,              prty_  => null,              uid_   => null);

       else opr.ref  := ref_;
       end if;


     if nvl(nms3622_,'') is not null and nvl(nls3622_,'') is not null
       then
        tax_ := round(opr.s/6);
        opr.s := opr.s - tax_;
    end if;

    paytt ( flg_  => 0,          -- ���� ������
            ref_  => opr.REF,    -- ����������
            datv_ => gl.bdate,   -- ���� ������������
            tt_   => opr.tt,     -- ��� ����������
            dk0_  => 1,          -- ������� �����-������
            kva_  => gl.baseval, -- ��� ������ �
            nls1_ => opr.nlsa,   -- ����� ����� �
            sa_   => opr.s,      -- ����� � ������ �
            kvb_  => gl.baseval, -- ��� ������ �
            nls2_ => opr.nlsb  , -- ����� ����� �
            sb_   => opr.s       -- ����� � ������ �
           );

     if tax_ >0
     then
         begin
          paytt (   flg_  => 0,          -- ���� ������
                    ref_  => opr.REF,    -- ����������
                    datv_ => gl.bdate,   -- ���� ������������
                    tt_   => opr.tt,     -- ��� ����������
                    dk0_  => 1,          -- ������� �����-������
                    kva_  => gl.baseval, -- ��� ������ �
                    nls1_ => opr.nlsa,   -- ����� ����� �
                    sa_   => tax_,      -- ����� � ������ �
                    kvb_  => gl.baseval, -- ��� ������ �
                    nls2_ => nls3622_ , -- ����� ����� �
                    sb_   => tax_       -- ����� � ������ �
                   );

          end;
     end if;

        IF opr.REF IS NOT NULL
        THEN
            INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                 VALUES (opr.REF,  gl.bdate,  skrnd_.nd);
    END IF;

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (opr.REF);
        ELSE operw_ul (opr.REF);
        END IF;

        UPDATE skrynka
          SET keyused = 0
        WHERE n_sk = skrnd_.n_sk;
end;

/*
*    �������� �������� �����  �� ������ �� ����������� �����.
--http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-4624
--��������� ������������ ������ ��������� ����� � ������ ���� ������������� ����� �� ��������� SN3 �������� ���� �� �������� ����� �� �����, � ��� �� ������.
--������������� ������ �� ��������� ��������:
--�� 2909/19 �� 3622/51 � �� ���� ���;
--�� 2909/19 �� 6399/02 � �������� ������ �� ���� �������� �� �������� ����� �� ������������ ���.
--(���������: ���� ��� �������� � 1000,00 ���; ���� ��� � 166,67 ���., ���� ������ �������� ����� � 833,33���.).
*/
    procedure p_mortgage_income(dat_    DATE,
                                dat2_   DATE,
                                n_sk_   NUMBER,
                                mode_   NUMBER,
                                par_    NUMBER,
                                ref_    NUMBER default null)
   IS
  nls6397_    accounts.nls%type;
  nms6397_    accounts.nms%type;
    nls3622_    accounts.nls%type;
    nms3622_    accounts.nms%type;
    tax_        number;
  opr         oper%rowtype;
   BEGIN
        BEGIN
           SELECT a.nls, SUBSTR (a.nms, 1, 38), f_ourokpo
             INTO opr.nlsb, opr.nam_b, opr.id_b
             FROM accounts a
         WHERE a.nls = (SELECT val
                          FROM branch_parameters
                         WHERE tag = 'DEP_S11'
                           AND branch = branch_)
           AND a.kv = 980;
    EXCEPTION WHEN NO_DATA_FOUND
              THEN bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S11');
    END;

    nls3622_ := NBS_OB22_NULL('3622', '51');

    begin
     select substr(nms,1,38)
       into nms3622_
       from accounts
      where nbs = '3622'
        and nls = nls3622_;
    exception when no_data_found then bars_audit.info('������� ��������� ����� 3622/51 �� ��������');
    end;

       opr.id_a      := skrnd_.okpo1;
     opr.tt        := tt_;
     opr.vob       := vob_;
     opr.nlsa      := nls2909_;
       opr.nam_a     := substr(nms2909_,1,38) ;

       if par_ * 100 <= ostc2909_
       then opr.s := par_ * 100;
     else raise_application_error (- (20777), '\.'|| '     �� ��������� ����� �� ������� �������', TRUE);
     end if;


     if mode_ = 25
       then opr.nazn := '�������������� �� ������� ������ ����� �������� ���� �� ����� �� ����� �'||skr_.snum||' � ��� �� ������ (������ �'||skrnd_.ndoc||')';
     else opr.nazn := '�������������� �� ������� ������ ����� �������� ���� �� ����� �� ����� �'||skr_.snum||' ������� ����� ��� ���������� �볺��� (������ �'||skrnd_.ndoc||')';
       end if;

       if opr.s <= 0 then return; end if;

     if ref_ is null then
        gl.ref (opr.REF);

        gl.in_doc3( ref_  => opr.REF,                   tt_    => opr.tt,   vob_   => opr.vob,     nd_    => SUBSTR(TO_CHAR(opr.REF),1,10),
                    pdat_  => SYSDATE,                  vdat_  => gl.BDATE, dk_    => 1,
                    kv_    => gl.baseval,               s_     => opr.s,    kv2_   => gl.baseval,  s2_    => opr.s,
                    sk_    => NULL,                     data_  => gl.bdate, datp_  => gl.bdate,
                    nam_a_ => SUBSTR(opr.nam_a,1,38),   nlsa_  => opr.nlsa, mfoa_  => gl.aMfo,
                    nam_b_ => SUBSTR(opr.nam_b,1,38),   nlsb_  => opr.nlsb, mfob_  => gl.aMfo,
                    nazn_  => SUBSTR(opr.nazn,1,158),
                    d_rec_ => NULL,                     id_a_  => opr.id_a, id_b_  => opr.id_b,     id_o_  => NULL,
                    sign_  => NULL,                     sos_   => 1,        prty_  => NULL,         uid_   => NULL);

       else opr.ref  := ref_;
       end if;

       if nvl(nms3622_,'') is not null and nvl(nls3622_,'') is not null
       then
        tax_ := round(opr.s/6);
        opr.s := opr.s - tax_;
       end if;


     paytt (    flg_  => 0,          -- ���� ������
                ref_  => opr.REF,    -- ����������
                datv_ => gl.bdate,   -- ���� ������������
                tt_   => opr.tt,     -- ��� ����������
                dk0_  => 1,          -- ������� �����-������
                kva_  => gl.baseval, -- ��� ������ �
                nls1_ => opr.nlsa,   -- ����� ����� �
                sa_   => opr.s,      -- ����� � ������ �
                kvb_  => gl.baseval, -- ��� ������ �
                nls2_ => opr.nlsb  , -- ����� ����� �
                sb_   => opr.s       -- ����� � ������ �
               );
     if tax_ >0
     then
         begin
          paytt (   flg_  => 0,          -- ���� ������
                    ref_  => opr.REF,    -- ����������
                    datv_ => gl.bdate,   -- ���� ������������
                    tt_   => opr.tt,     -- ��� ����������
                    dk0_  => 1,          -- ������� �����-������
                    kva_  => gl.baseval, -- ��� ������ �
                    nls1_ => opr.nlsa,   -- ����� ����� �
                    sa_   => tax_,       -- ����� � ������ �
                    kvb_  => gl.baseval, -- ��� ������ �
                    nls2_ => nls3622_  , -- ����� ����� �
                    sb_   => tax_        -- ����� � ������ �
                   );

          end;
     end if;

        IF opr.REF IS NOT NULL
        THEN
            INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                 VALUES (opr.REF,  gl.bdate,  skrnd_.nd);
    END IF;

        IF NVL (skrnd_.custtype, 3) = 3
        THEN operw_fl (opr.REF);
        ELSE operw_ul (opr.REF);
        END IF;

        UPDATE skrynka
          SET keyused = 0
        WHERE n_sk = skrnd_.n_sk;
   END;

    PROCEDURE add_package_repository (dat_    IN DATE,
                                      dat2_   IN DATE,
                                      n_sk_   IN NUMBER,
                                      mode_   IN NUMBER,
                                      par_    IN NUMBER)
    is
    nls6397_            accounts.nls%type;
    nms6397_            accounts.nms%type;
    opr                 oper%rowtype;
    l_skrynka_acc_tip   SKRYNKA_ACC_TIP%rowtype;
    l_nls               accounts.nls%type;
    l_nms               accounts.nms%type;

    i                   number := 0;
    dep_isp             branch_parameters.val%type; --  ����������
    dep_grp             branch_parameters.val%type; --  ����� �������
    our_rnk             branch_parameters.val%type; --  ��� �����
    macc                accounts.acc%type;        --  ��� �������
    nTmp                INTEGER;

  BEGIN
        /*
    begin
         SELECT a.nls, a.nms, f_ourokpo
         INTO   opr.nlsb, opr.nam_b, opr.id_b
         FROM accounts a
        WHERE a.nls = (SELECT val
                 FROM branch_parameters
                WHERE tag = 'DEP_S12' AND branch = branch_)
         and a.kv = 980;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S12');
        END;*/

    begin
       select *
         into l_skrynka_acc_tip
       from SKRYNKA_ACC_TIP
      where tip = 'P'
        and nbs  is not null
        and ob22 is not null;
    exception when no_data_found
                  then return;        --  �������������� ���� ������ �� �����������.
    end;

    if skrnd_.dat_end + 45 < gl.bd
        then raise_application_error(-20100,'��������� ����� ������ ��� �볺��� �� �������.');
    end if;

     if mode_ in(26)
       then
         -- ��������� �������

         while i < 10    -- 10 ������� ��������� �������
          loop
            l_nls := vkrzn(substr(f_ourmfo,1,5),  l_skrynka_acc_tip.nbs||'0'|| lpad(i,2,'0')||lpad(skrnd_.nd,7,'0'));

            begin
              SELECT acc
                INTO macc
                FROM accounts
               WHERE nls = l_nls AND kv = 980;
            exception when no_data_found then exit;
            end;
            i:= i+1;
          end loop;

            BEGIN
               SELECT a.acc                                    --, a.nls, a.nms, f_ourokpo
                 INTO macc                              --,  opr.nlsb, opr.nam_b, opr.id_b
                 FROM accounts a
                WHERE nls = l_nls AND kv = 980;

               bars_error.raise_nerror ('SKR', 'ACCOUNT_ALREADY_EXISTS', TO_CHAR (l_nls));
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;

            select val into dep_isp from branch_parameters where tag = 'DEP_ISP' and branch = sys_context('bars_context','user_branch');
            select val into our_rnk from branch_parameters where tag = 'DEP_SKRN' and branch = sys_context('bars_context','user_branch');
            select val into dep_grp from branch_parameters where tag = 'DEP_GRP' and branch = sys_context('bars_context','user_branch');

      l_nms:= '������� ������� ���� ���.�' || to_char(skrnd_.ndoc);

      Op_Reg_Ex(99, 0, 0, dep_grp, nTmp, our_rnk, l_nls, 980, l_nms,'ODB', dep_isp , macc,
        '1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,sys_context('bars_context','user_branch'),NULL);

      --INSERT into skrynka_acc (acc,n_sk,tip) values (macc,P_ND,'K');
        -- ������� ��������� ��22
      accreg.setAccountSParam (macc, 'OB22', l_skrynka_acc_tip.ob22);
     else return;
       end if;

        BEGIN
           SELECT a.nls, SUBSTR (a.nms, 1, 38), f_ourokpo
             INTO opr.nlsb, opr.nam_b, opr.id_b
             FROM accounts a
            WHERE a.nls = l_nls AND a.kv = 980;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN
              bars_error.raise_nerror (l_mod, 'PARAM_NOT_FOUND', l_nls);
        END;

       opr.id_a      := f_ourokpo;
     opr.tt        := tt_;
     opr.vob       := vob_;

     if substr(nls9819_,1,4) = '9910'
       then     opr.nlsa      := nls9819_;
                opr.nam_a     := substr(nms9819_,1,38) ;
       elsif    substr(nls9898_,1,4) = '9910'
       then     opr.nlsa      := nls9898_;
                opr.nam_a     := substr(nms9898_,1,38) ;
     end if;

     opr.s         :=  100;

       if mode_ = 26
       then opr.dk   :=1;
          opr.nazn := '��������  ��������� �� ���� �� ���������, �� ���� ������� ��� ������� ����� �'||skrnd_.n_sk||' ��� ���������� �볺���   (������ �'||skrnd_.ndoc||')';
     else opr.dk   :=0;
          opr.nazn := '���������� �볺��� ���������, �� ���� ������� ��� ������� ����� �'||skrnd_.n_sk||' ��� ���������� �볺���   (������ �'||skrnd_.ndoc||')';
       end if;

       if opr.s <= 0 then return; end if;

        gl.ref (opr.REF);

        gl.in_doc3(ref_  => opr.REF,       tt_    => opr.tt ,    vob_   => opr.vob,     nd_    => substr(to_char(opr.REF),1,10),
                pdat_  => SYSDATE ,     vdat_  => gl.BDATE,   dk_    => 1-opr.dk,
                kv_    => gl.baseval,   s_     => opr.s,      kv2_   => gl.baseval,  s2_    => opr.s,
                sk_    =>  null ,       data_  => gl.bdate ,   datp_  => gl.bdate ,
                nam_a_ => substr(opr.nam_a,1,38),     nlsa_  => opr.nlsa ,       mfoa_  => gl.aMfo  ,
                nam_b_ => substr(opr.nam_b,1,38),     nlsb_  => opr.nlsb ,       mfob_  => gl.aMfo  ,
                nazn_  => substr(opr.nazn,1,158),
                d_rec_ => null,                        id_a_  => opr.id_a ,     id_b_  => opr.id_b ,         id_o_  => null,
                sign_  => null,                        sos_   => 1,              prty_  => null,              uid_   => null);

        paytt ( flg_  => 0,          -- ���� ������
                ref_  => opr.REF,    -- ����������
                datv_ => gl.bdate,   -- ���� ������������
                tt_   => opr.tt,     -- ��� ����������
                dk0_  => 1-opr.dk,   -- ������� �����-������
                kva_  => gl.baseval, -- ��� ������ �
                nls1_ => opr.nlsa,   -- ����� ����� �
                sa_   => opr.s,      -- ����� � ������ �
                kvb_  => gl.baseval, -- ��� ������ �
                nls2_ => opr.nlsb  ,  -- ����� ����� �
                sb_   => opr.s        -- ����� � ������ �
               );

         p_mortgage_income(dat_, dat2_,n_sk_, mode_, par_, opr.ref);

         /*     IF opr.REF IS NOT NULL
                 THEN
                    INSERT INTO skrynka_nd_ref(REF, bdate,  nd)
                         VALUES (opr.REF,  gl.bdate,  skrnd_.nd);
                END IF;

                 IF NVL (skrnd_.custtype, 3) = 3
                 THEN
                    operw_fl (opr.REF);
                 ELSE
                    operw_ul (opr.REF);
                 END IF;         */

          UPDATE skrynka
            SET keyused = 0
          WHERE n_sk = skrnd_.n_sk;
  end;
   ----------------------------------------------------------------------------

    PROCEDURE p_dep_skrn (dat_       IN DATE,
                          dat2_      IN DATE,
                          n_sk_      IN NUMBER,
                          mode_      IN NUMBER,
                          par_       IN NUMBER DEFAULT NULL,
                          p_userid   IN NUMBER DEFAULT NULL,
                          p_sum      IN NUMBER DEFAULT NULL,
                          p_extnd    IN VARCHAR2 DEFAULT NULL)
    IS
        /*
        ���������:
        -----------------------------------
        dat_  - ���� �������� 1
        dat2_  - ���� �������� 2
        n_sk_ - ����� �����
        mode_ - ��������

        p_sum - ��� ��������� ��� numpar  - ����

        ���� ���������
        0 - �������� ������ ��������, ��������� ��������� �� S_CC_DEAL, ������� ������ � skrynka_nd
        1 - �������� ��������
        10 - �������� ������ �� ����� ����� (��� ���)
        11 - �������� ������ � �.�. ������� (��� ���)
        12 - ������� ������ �� ����� ����� (��� ���)
        14 - ������
        15 - ������ (������.)
        ----15,16 - ������� �����, ������ �����
        17 - ����������� ������ ( � �.�. ������� )  NVV extnd_ mandatory
        18 - ����������� ������ extnd_ mandatory
        19 - ���������
        20 - test ������� �������
        21 - ������ ��������� ������ (�������� ������ - ����� �������)
        22 - ����������� ����������� ������� ������� ��������, ����������� ����������� �� ����� ��������
        23 - ����� �� ���������
        25 -- �������������� �� ������� ������ ����� �������� ���� �� ����� �� ����� � ��� �� ������
        26 -- �������� �� ���� �� ��������� ���� ���, ���� ���� ������� ������ ��� ���������� �볺���
        27 -- ���������� �볺��� ���������, �� ���� ������� ��� ������� ����� ��� ���������� �볺���
        28 -- �������� ����� � ��� ����������� ���� ��� �������� ������ �����
        */
  prolong_nd      skrynka_nd.nd%type;
  n_acc           accounts.acc%type;
  oldnd_state_    skrynka_nd.sos%type;
  l_dealcreated   skrynka_nd.deal_created%type;
   BEGIN
      IF par_ IS NULL
      THEN
         olddat_ := NULL;
         olddat2_ := NULL;
      END IF;

      -- ����� ����������� ����������
      -- ��������
    -- ��� ������� ��������� ������� "��������" �����������
    if mode_ = 1 then
        SELECT tt, tt2, tt3, NAME, sk, NVL (vob, 6), NVL (vob2, 6),NVL (vob3, 6)
          INTO tt_, tt2_, tt3_, itemname_, sk_, vob_, vob2_,vob3_
          FROM skrynka_menu
         WHERE item = 22
             and kf = sys_context('bars_context','user_mfo');
       tt_ := 'SN6';
    else
      SELECT tt, tt2, tt3, NAME, sk, NVL (vob, 6), NVL (vob2, 6),NVL (vob3, 6)
          INTO tt_, tt2_, tt3_, itemname_, sk_, vob_, vob2_,vob3_
          FROM skrynka_menu
         WHERE item = mode_
             and kf = sys_context('bars_context','user_mfo');

    end if;
      -- ����������� �������� SK ��� �� �������� ��������
      IF mode_ NOT IN ('10', '12', '14', '15', '18', '19', '21','29')
      THEN
         sk_ := NULL;
      END IF;

    IF p_userid is not null
    then
         sk_ := NULL;
    end if;

      bankdate_ := bankdate;

      -- ��������� �������� �������� ����
      IF mode_ <> 0 AND mode_ <> 1 AND mode_ <> 22
      THEN
    if par_ is not null AND par_ <> 0 then
           BEGIN
              SELECT *
                INTO skrnd_
                FROM skrynka_nd
               WHERE nd = par_;
           EXCEPTION
              WHEN NO_DATA_FOUND
              THEN bars_error.raise_nerror(l_mod, 'DEAL_CLOSED_ND', par_);
           END;
    else
           BEGIN
              SELECT *
                INTO skrnd_
                FROM skrynka_nd
               WHERE n_sk = n_sk_ AND sos = 0;
           EXCEPTION
              WHEN NO_DATA_FOUND
              THEN bars_error.raise_nerror(l_mod, 'DEAL_CLOSED_NSK', n_sk_);
           END;
    end if;
      END IF;

-- ��������� ������� 6519 �������� ���� �볺���
   p_nls_6519(skrnd_.CUSTTYPE);




    IF mode_ <> 1 AND mode_ <> 12 AND mode_ <> 13 AND mode_ <> 25 AND mode_ <> 26 AND mode_ <> 28 AND mode_ <> 19 AND mode_ <> 22
      THEN
      if skrnd_.imported = 1
      then
        bars_error.raise_nerror(l_mod, 'IMPORTED_MODE_ERROR', skrnd_.nd);
      end if;
    END IF;
        /*
              IF mode_ = 22
              THEN
                    if sys_context('bars_context','user_branch') <> '/' || sys_context('bars_context','user_mfo') || '/'
                    then
                        bars_error.raise_nerror(l_mod, 'IMPORTED_MODE_ERROR', skrnd_.nd);
                    end if;
              END IF;
        */

    IF  mode_ != 22 then
        BEGIN
           SELECT *
             INTO skr_
             FROM skrynka
            WHERE n_sk = n_sk_;
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN bars_error.raise_nerror(l_mod, 'SAFE_NOT_FOUND', n_sk_);
      END;

        BEGIN
           SELECT a.*
             INTO mainacc_
             FROM skrynka_acc s, accounts a
            WHERE s.n_sk = n_sk_
                AND s.acc = a.acc
                AND s.tip = 'M';

           nls2909_  := mainacc_.nls;
           nms2909_  := mainacc_.nms;
           ostc2909_ := ABS (mainacc_.ostc);
        EXCEPTION
           WHEN NO_DATA_FOUND
           THEN bars_error.raise_nerror(l_mod, 'ACCOUNT_NOT_FOUND', nls2909_);
        END;
    END IF;

      -- ���
      mfoa_     := gl.amfo;
      mfob_     := gl.amfo;
      okpoa_    := f_ourokpo;
      okpob_    := f_ourokpo;

      SELECT ID
        INTO userid_
        FROM staff$base
       WHERE id = user_id;

     -- �������  �������� ��������������.
      IF mode_ in ( 17,18)
       THEN
            BEGIN
               SELECT nd
                 INTO prolong_nd
                 FROM skrynka_nd
                WHERE n_sk = n_sk_ AND sos = 1;

               bars_error.raise_nerror (l_mod, 'PROLONGED_CONTRACT', prolong_nd);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN NULL;
            END;
    End If;

      IF mode_ = 0
      THEN
         null;--skrn.p_dep_skrn (dat_, dat2_, n_sk_, 1, p_extnd);
    ELSIF mode_ = 1
      THEN
         -- �������� �� ������� ����������� ��������
     BEGIN
      SELECT nd, sos, deal_created
        INTO oldnd_, oldnd_state_, l_dealcreated
        FROM skrynka_nd
       WHERE nd = par_;
     EXCEPTION
      WHEN NO_DATA_FOUND
      THEN bars_error.raise_nerror(l_mod, 'DEAL_CLOSED_ND', par_);
     END;

         -- ������� ������ ���������
         BEGIN
      -- ���������� �� �����������
      prolong_nd := null;

      if oldnd_state_ = 0 then
        begin
          select min(nd)
                      into prolong_nd
            from skrynka_nd
           where n_sk = n_sk_
                       and sos = 1;
        exception when NO_DATA_FOUND then null;
        end;
      end if;

      if prolong_nd is null then
        if l_dealcreated is null or l_dealcreated <> bankdate or oldnd_state_ = 0 then
          begin
            SELECT a.ostc
              INTO s_
              FROM skrynka s, skrynka_acc g, accounts a
             WHERE s.n_sk = g.n_sk
               --AND s.o_sk = g.o_sk
               AND g.acc = a.acc
                           AND g.tip = 'M'
               AND a.ostc = 0
                           AND a.ostb = 0
               AND s.n_sk = n_sk_;
           EXCEPTION
            WHEN NO_DATA_FOUND
            THEN bars_error.raise_nerror(l_mod, 'BAIL_NOT_EMPTY', n_sk_);
          end;
        end if;
      end if;
         END;

     if prolong_nd is null then
      null;
     end if;

     -- �������� ����������� ����������� ��� ������� ��������
     p_final_amort(oldnd_);

         IF oldnd_ IS NOT NULL
         THEN
            UPDATE skrynka_nd
               SET sos = 15, dat_close = gl.bd
             WHERE nd = oldnd_;

      -- ��������� ������� ����� ���� ���� �����������
            UPDATE accounts
               SET mdate = NULL
             WHERE acc IN (SELECT acc
                             FROM skrynka_acc a
                            WHERE     a.n_sk = n_sk_
                                  AND NOT EXISTS
                                         (SELECT n_sk
                                            FROM skrynka_nd
                                           WHERE n_sk = n_sk_ AND sos = 1));
         END IF;
     -- ��������� ������, ���� ������ � ������ "�����������"
         IF prolong_nd IS NOT NULL and oldnd_state_ = 0
         THEN
            UPDATE skrynka_nd
               SET sos = 0
             WHERE nd = prolong_nd;
         END IF;
      ELSIF mode_ = 10 OR mode_ = 11 OR mode_ = 12 OR mode_ = 13
      THEN
         p_oper_zalog (dat_, dat2_, n_sk_, mode_, par_, p_userid, p_sum);
      ELSIF mode_ = 14                                    -- �������� ������
      THEN
         p_oper_arenda (dat_, dat2_, n_sk_, mode_, par_);
      ELSIF mode_ = 15                                    -- �������� ������
      THEN
         p_oper_arenda (dat_, dat2_, n_sk_, mode_, par_);
      ELSIF mode_ = 17                                 -- ����������� ������ ������
      THEN
         p_oper_prolong (dat_, dat2_, n_sk_, mode_, par_,p_extnd);
      ELSIF mode_ = 18                                 -- ����������� ������
      THEN
         p_oper_prolong (dat_, dat2_, n_sk_, mode_, par_,p_extnd);
      ELSIF mode_ = 19                                          -- ���������
      THEN
       p_oper_prolong (dat_+1, dat_+1, n_sk_, 18, par_,p_extnd);
      ELSIF mode_ = 20
      THEN
         p_tariff (skr_.o_sk, dat_, dat2_, bankdate_);
      ELSIF mode_ = 21                                            -- mode=21
      THEN
         p_oper_arenda_period (dat_, dat2_, n_sk_, mode_, par_);
      ELSIF mode_ = 22
      THEN
         p_oper_amort_doh (dat_, dat2_, n_sk_, mode_, par_);


    ELSIF mode_ = 25 -- �������������� �� ������� ������ ����� �������� ���� �� ����� �� ����� � ��� �� ������
      THEN
      p_mortgage_income(dat_, dat2_, n_sk_, mode_, p_sum);

    ELSIF mode_ = 26 -- �������� �� ���� �� ��������� ���� ���, ���� ���� ������� ������ ��� ���������� �볺���
      THEN
     --p_mortgage_income(dat_, dat2_, n_sk_, mode_, par_);
     add_package_repository(dat_, dat2_, n_sk_, mode_, par_);

    ELSIF mode_ = 27 -- ���������� �볺��� ���������, �� ���� ������� ��� ������� ����� ��� ���������� �볺���
      THEN
     add_package_repository(dat_, dat2_, n_sk_, mode_, par_);
    null;

      ELSIF mode_ = 28 -- �������� ����� � ��� ����������� ���� ��� �������� ������ �����
      THEN
     p_cost_of_bank(dat_, dat2_, n_sk_, mode_, p_sum);

      ELSIF mode_ = 29 -- ����� ���� �� ���������� ��������� � ������� ����� �� ����� ������������ ������������� ������
      THEN             -- � ������� skrynka_menu ���� vob3 ��������� ��� ������, ��� ���� ������ �� �������� ���� ��� �������� K21 (� ������������� ���)
     p_commis_of_attorney(dat_, dat2_, n_sk_, mode_, p_sum);
    ELSIF mode_ = 30 -- ����� ���� �� ���������� ��������� � ������� ����� �� ����� ������������ ������������� ������ �����������
      THEN             -- � ������� skrynka_menu ���� vob3 ��������� ��� ������, ��� ���� ������ �� �������� ���� ��� �������� K24 (� ������������� ���)
     p_commis_of_attorney(dat_, dat2_, n_sk_, mode_, p_sum);

      ELSE
            bars_error.raise_nerror(l_mod, 'MOD_NOT_FOUND', mode_);
      END IF;

      COMMIT;
   END;
---------------------------------------------------------------------------------------------------------
--        �������� ������������� 3600
---------------------------------------------------------------------------------------------------------
   PROCEDURE p_cleanup (DUMMY NUMBER)
   IS
   BEGIN
    FOR K IN (  SELECT n.n_sk,
                       n.nd,
                       n.dat_begin,
                       n.dat_end
                  FROM skrynka_nd n, skrynka s
                 WHERE     n.dat_end < bankdate
                       AND n.sos = 0
                       AND n.n_sk = s.n_sk
                       AND n.n_sk IN (SELECT n1.n_sk
                                        FROM skrynka_nd n1, skrynka s1
                                       WHERE     n1.n_sk = n.n_sk
                                             AND n1.sos = 1
                                             AND n1.n_sk = s1.n_sk))
    loop
        skrn.p_dep_skrn(k.dat_end, k.dat_end, k.n_sk, 1, k.nd);
    END LOOP;

    FOR K IN (  SELECT a.acc
                  FROM accounts A, skrynka_nd n, skrynka_nd_acc na
                 WHERE n.sos = 15
                   AND n.nd = na.nd
                   AND na.tip = 'D'
                   AND na.acc = a.acc
                   AND a.ostc = 0
                   AND a.ostb = 0
                   --AND a.ostf = 0
                   AND (a.dapp < bankdate OR a.dapp IS NULL)
                   AND a.dazs IS NULL)
    LOOP
        UPDATE accounts
           SET dazs = bankdate
         WHERE acc = k.acc;
    END LOOP;
   END;
-----------------------------------
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN header_version_;
   END;

-----------------------------------
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN version_ ||chr(10)|| body_awk;
   END;

-----------------------------------
   PROCEDURE initparams (par_ NUMBER)
   IS
      val_   branch_parameters.val%TYPE;
   BEGIN
      BEGIN
         SELECT val
           INTO skrnpar1_
           FROM params
          WHERE par = 'SKRNPAR1';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN skrnpar1_ := 0;

            INSERT INTO params(par, val, comm)
                 VALUES ('SKRNPAR1', '0', '���. ������, �� ���������� ��� ����� �� ��� (�������������)');
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO skrnpar2_
           FROM params
          WHERE par = 'SKRNPAR2';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN skrnpar2_ := 0;

            INSERT INTO params(par, val, comm)
                 VALUES ('SKRNPAR2', '0', '���. ������, ������������ �������������� ���� ���������');
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO skrnpar3_
           FROM params
          WHERE par = 'SKRNPAR3';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN skrnpar3_ := 1;

            INSERT INTO params(par, val, comm)
                 VALUES ('SKRNPAR3', '1', '���. ������, ��������� �����. ����� � ����� ���������');
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_KAS'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_KAS', '', branch_);     -- '���. ������, acc ����� �����'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S1'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S1', '', branch_);    -- '���. ������, acc ����� 9898'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S2'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S2', '', branch_);    -- '���. ������, acc ����� 9819'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S3'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S3', '', branch_);    --  '���. ������, acc ����� ��� ��� �������'
            COMMIT;
      END;


      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S5'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S5', '', branch_);    -- '���. ������, acc ����� 2909'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S6'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S6', '', branch_);    -- '���. ������, acc ����� 3579'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_S7'
            AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_S7', '', branch_);    --, '���. ������, acc ����� ��� ���'
            COMMIT;
      END;

      BEGIN
         SELECT val
           INTO val_
           FROM branch_parameters
          WHERE tag = 'DEP_SKRN' AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_SKRN', '', branch_);    --  '���. ������, RNK ������� ��� ����������� ������'
            COMMIT;
      END;

      BEGIN
         SELECT TO_NUMBER (val)
           INTO otvisp_
           FROM branch_parameters
          WHERE tag = 'DEP_ISP' AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_ISP', '', branch_);     --  '���. ������, RNK ������� ��� ����������� ������'
            COMMIT;
      END;

      BEGIN
         SELECT TO_NUMBER (val)
           INTO grp_
           FROM branch_parameters
          WHERE tag = 'DEP_GRP' AND branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO branch_parameters(tag, val, branch)
                 VALUES ('DEP_GRP', '', branch_);     --  '���. ������, ��� ������ ����� ��� ����������� ������'
            COMMIT;
      END;

      BEGIN
         SELECT '1'
           INTO val_
           FROM newnlsdescr
          WHERE typeid = '^';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO newnlsdescr(typeid, descr,sqlval)
                 VALUES ('^', '����� �����','select num from conductor where num=:ACC');
            COMMIT;
      END;

      BEGIN
         SELECT '1'
           INTO val_
           FROM nlsmask
          WHERE maskid = 'SCRN';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            INSERT INTO nlsmask(maskid, descr, MASK, masknms)
                 VALUES ('SCRN', '���������� ������', '_____^^^^', NULL);
            COMMIT;
      END;
   END;

-----------------------------------
   PROCEDURE setparams (par_ VARCHAR2, val_ VARCHAR2)
   IS
   BEGIN
      UPDATE branch_parameters
         SET val = val_
       WHERE tag = par_ AND branch = skrn.branch_;
      COMMIT;
   END;


--***********************************************************************************
-- �������� ������ �� ���������� �� ��������� ������� ������������� �� ���������
--***********************************************************************************
PROCEDURE control_tariff (p_tariff      IN SKRYNKA_TARIFF2.TARIFF%TYPE,
                          p_sd          IN SKRYNKA_TARIFF2.S%TYPE,
                          p_dat_begin   IN DATE,
                          p_dat_end     IN DATE)
is
    l_id    number;
    l_tarif number;
BEGIN
  begin
      select etalon_id
        into l_id
        from skrynka_tip s, SKRYNKA_TARIFF t
       where s.o_sk = T.O_SK
         and T.TARIFF = p_tariff;

     if nvl(l_id,0) = 0 then
       raise_application_error (- (20777), '\'|| '     ��� ���� ������ �� ��������� ��� �������� ������', TRUE);
     end if;
  exception when no_data_found then raise_application_error (- (20777), '\'|| '     ��� ���� ������ �� ��������� ��� �������� ������', TRUE);
  end;

    begin
        SELECT v.TARIFF_AMOUNT
          INTO l_tarif
          FROM SKRYNKA_TIP_ETALON s,
               SKRYNKA_ETALON_TARIFF p,
               SKRYNKA_ETALON_TARIFF_value v
         WHERE     S.id = P.etalon_id
               AND p.id = v.TARIFF_ID
               AND s.id = l_id
               AND (P.DAYS_COUNT, P.ID) IN (SELECT MIN (DAYS_COUNT), etalon_ID
                                              FROM SKRYNKA_ETALON_TARIFF
                                             WHERE days_count >=
                                                      (p_dat_end - p_dat_begin + 1) group by etalon_ID)
               AND (TARIFF_ID, APPLY_DATE) IN (  SELECT TARIFF_ID, MAX (APPLY_DATE)
                                                   FROM SKRYNKA_ETALON_TARIFF_value
                                                  WHERE APPLY_DATE <= p_dat_begin
                                               GROUP BY TARIFF_ID);
    exception when no_data_found then
      return;
    end;

    if l_tarif*100 > p_sd
    then raise_application_error (- (20777), '\'|| '     ������������ ������ ��� �������� ����� ̳��������� ������ � ������� � ������ ������������� ������ �� "��������" ����������', TRUE);
    else null;
    end if;
END;

--************************************************************************************************************************************
--  +  ���������� ������ �� ��������
--  par_ = 0  - "�����������"  ��� �������
--************************************************************************************************************************************
   PROCEDURE p_calc_tariff (n_sk_ NUMBER, par_ number default null)
   IS
      ttip_   NUMBER;
   BEGIN
      bankdate_ := bankdate;

      BEGIN
    if par_ is null or par_ = 0  then
         SELECT *
           INTO skrnd_
           FROM skrynka_nd
          WHERE n_sk = n_sk_;
    else
         SELECT *
           INTO skrnd_
           FROM skrynka_nd
          WHERE nd = par_;
    end if;
      END;

      BEGIN
         SELECT t.tip
           INTO ttip_
           FROM skrynka_tariff t
          WHERE t.tariff = skrnd_.tariff;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ttip_ := NULL;
      END;

      skrn.p_tariff (skrnd_.tariff,
                     skrnd_.dat_begin,
                     skrnd_.dat_end,
                     least(bankdate_, skrnd_.dat_begin)
                    );
      IF ttip_ = 1
      THEN
         UPDATE skrynka_nd sn
            SET sn.s_arenda = tariff3_,
                sn.s_nds = ROUND (tariff3_ / 6),
                sn.sd = sd_,
                sn.prskidka = prsc_,
                sn.peny = peny_
          WHERE sn.nd = skrnd_.nd;
      ELSE
    -- �������� ������ �� ���������� �� ��������� ������� ������������� �� ���������
    control_tariff (skrnd_.tariff,sd_, skrnd_.dat_begin, skrnd_.dat_end);
         UPDATE skrynka_nd sn
            SET sn.s_arenda = tariff3_,
                sn.s_nds = ROUND ((tariff3_) / 6),
                sn.sd = sd_,
                sn.prskidka = prsc_,
                sn.peny = peny_
          WHERE sn.nd = skrnd_.nd;
      END IF;
   END;

-----------------------------------
   PROCEDURE p_add_protocol (str_ VARCHAR2)
   IS
   BEGIN
      proti_ := proti_ + 1;
      prot_ (proti_) := SUBSTR (str_, 1, 100);
   END;

-----------------------------------
   PROCEDURE p_prepare_ptotocol (
      dat_    DATE,
      dat2_   DATE,
      n_sk_   NUMBER,
      mode_   NUMBER,
      par_    NUMBER DEFAULT NULL
   )
   IS
   BEGIN
      prot_.DELETE;
      proti_ := 0;
      proti2_ := 0;

      IF mode_ = 21
      THEN
         SELECT *
           INTO skrnd_
           FROM skrynka_nd
          WHERE n_sk = n_sk_ AND sos <> 15;

         p_calcperiod_tariff (dat_, dat2_, skrnd_.nd);
         p_add_protocol ('����� ���� ������ =' || TO_CHAR (st_));
         p_add_protocol ('���� ������ =' || TO_CHAR (dni1_));
         --p_add_protocol ('-------------------------------------' );
         p_add_protocol ('������� ����� =' || TO_CHAR (sd1_));
         --p_add_protocol ('=====================================' );
         p_add_protocol ('���� ��������� ���.���. =' || TO_CHAR (datk_));
         p_add_protocol ('���� ���.���. =' || TO_CHAR (dni2_));
         p_add_protocol ('���� ���.���. =' || TO_CHAR (dni3_));
         --p_add_protocol ('-------------------------------------' );
         p_add_protocol ('����� ������ �� ������  =' || TO_CHAR (sb1_));
         p_add_protocol ('��� =' || TO_CHAR (snds1_));
         p_add_protocol ('����� ���. ������� =' || TO_CHAR (sc1_));
         p_add_protocol ('����� ���. ������� =' || TO_CHAR (sf1_));
         p_add_protocol ('�������� �����     =' || TO_CHAR (st_ - sopl_ - sb1_));
      END IF;
   END;

   -----------------------------------
   FUNCTION f_get_protocol_line
      RETURN VARCHAR2
   IS
   BEGIN
      IF proti2_ <= proti_
      THEN
         proti2_ := proti2_ + 1;

         IF prot_.EXISTS (proti2_)
         THEN
            RETURN prot_ (proti2_);
         END IF;
      ELSE
         RETURN '';
      END IF;

      RETURN '';
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  ����, ��� ����� ���� � ������������ �� ������� bankdate
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_oplplan_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_      NUMBER;
      dat1_   DATE;
   BEGIN
      SELECT *
        INTO skrnd_
        FROM skrynka_nd n
       WHERE n.nd = nd_;

      p_calcperiod_tariff (skrnd_.dat_begin, bankdate, nd_);
      RETURN GREATEST (sb1_, 0);
   END;
--  %%%%%%%%%%%%%%%%%%%%%%%%
--  ����, ��� ����� ���� � ������������ �� ������ ����
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_oplplan_sum_4date (nd_ NUMBER, dt_term DATE)
      RETURN NUMBER
   IS
   BEGIN
      SELECT *
        INTO skrnd_
        FROM skrynka_nd n
       WHERE n.nd = nd_;

      p_calcperiod_tariff (skrnd_.dat_begin, dt_term, nd_);
      RETURN GREATEST (sb1_, 0);
   END;

   -- %%%%%%%%%%%%%%%%%%%%%%%%
--  ����, ��� ����� ���� � ������������ �� ������� ������� ����
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_oplplan_sum_4period (nd_ NUMBER, dt_start DATE, dt_end DATE)
      RETURN NUMBER
   IS
   BEGIN
      SELECT *
        INTO skrnd_
        FROM skrynka_nd n
       WHERE n.nd = nd_;

    if dt_start is not null then
    p_calcperiod_tariff (dt_start, dt_end, nd_);
    else
    p_calcperiod_tariff (skrnd_.dat_begin, dt_end, nd_);
    end if;

      RETURN GREATEST (sb1_, 0);
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  �� ����� ������ �볺����
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_opl_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      BEGIN
         SELECT a.nls, a.nms
           INTO nlsnds_, nmsnds_
           FROM accounts a
          WHERE a.nls = (SELECT val
               FROM branch_parameters
                          WHERE tag = 'DEP_S7' and branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nlsnds_ := NULL;
            nmsnds_ := NULL;
      END;

    -- �������� � �������������� ��������� �� ������� �����
    s_ := 0;

    BEGIN
     SELECT a.nls, a.nms
       INTO nls6519_, nms6519_
       FROM accounts a
      WHERE a.nls = (SELECT val
               FROM branch_parameters
                          WHERE tag = 'DEP_S3' and branch = branch_)
        and a.kv = 980;
    EXCEPTION
     WHEN NO_DATA_FOUND
     THEN
      nls6519_ := NULL;
      nms6519_ := NULL;
    END;

        SELECT s_ + ostc
          INTO s_
          FROM accounts a, skrynka_nd_acc n
         WHERE n.nd = nd_ AND n.tip = 'D' AND n.acc = a.acc;

        SELECT NVL (SUM (o.s * (2 * dk - 1)), 0) + s_
          INTO s_
          FROM opldok o, accounts a, skrynka_nd_ref r
         WHERE o.acc = a.acc
           AND a.nls IN (nls6519_, nlsnds_)
           AND o.s > 0
           AND o.sos = 5
           AND o.REF = r.REF
           AND r.nd = nd_
           AND a.kv = '980';

     return s_;
   END;

-----------------------------------
   FUNCTION f_get_borg_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT GREATEST (s_arenda - f_get_opl_sum (nd_), 0)
        INTO s_
        FROM skrynka_nd
       WHERE nd = nd_;

      RETURN s_;
   END;

-----------------------------------
-- ?????
-----------------------------------
   FUNCTION f_get_amort3600_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
    -- �������� � �������������� ��������� �� ������� �����
    select ostc
    into s_
    from accounts a, skrynka_nd_acc n
    where n.nd = nd_ and n.tip = 'D' and n.acc = a.acc;

    RETURN s_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  �������� �������� ������
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_3600_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
    -- �������� � �������������� ��������� �� ������� �����
    SELECT ostc
      INTO s_
      FROM accounts a, skrynka_nd_acc n
     WHERE n.nd = nd_
       AND n.tip = 'D'
       AND n.acc = a.acc;
    RETURN s_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  ���
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_nds_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
      BEGIN
         SELECT a.acc
           INTO acc_
           FROM branch_parameters t, accounts a
          WHERE t.tag = 'DEP_S7' and t.branch = branch_ and a.kv = 980 and a.nls = t.val /*and a.branch = t.branch*/;

      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            acc_ := NULL;
      END;

      SELECT NVL (SUM (o.s * (2*dk - 1)), 0)
        INTO s_
        FROM opldok o
       WHERE o.REF IN (SELECT r.REF
                         FROM skrynka_nd_ref r
                        WHERE r.nd = nd_)
         AND acc = acc_
         AND s > 0
         AND sos = 5;

     RETURN s_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  1 - ������� �������� �����������, 0 - �
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_amort_needed RETURN NUMBER
   is
  l_amort number(1) := 0;
  sdoc_   number := 0;
   begin
  FOR k IN (    SELECT n.n_sk, sk.snum, n.nd, a.nls, a.kv, n.dat_begin, n.dat_end,
                         a.ostc,n.amort_date,
                         ROUND (skrn.f_get_oplplan_sum (n.nd) * 5 / 6) s1,
                         skrn.f_get_curdoh_sum (n.nd) s2,
                         skrn.f_get_3600_sum (n.nd) s3,
                         LEAST (  ROUND (skrn.f_get_oplplan_sum_4date (n.nd, last_day(bankdate))  * 5 / 6)
                                - skrn.f_get_curdoh_sum (n.nd),
                                skrn.f_get_3600_sum (n.nd)
                               ) sp2,
             LEAST ( ROUND(f_get_oplplan_sum_4period(n.nd, n.amort_date+1, least(last_day(bankdate),n.dat_end)) * 5/6 ),
                                skrn.f_get_3600_sum (n.nd)) sp3,
               a.branch
                    FROM skrynka_nd n, skrynka_acc s, accounts a, skrynka sk
                   WHERE n.n_sk = s.n_sk and s.tip = 'M'
                     AND s.acc = a.acc
                     AND n.sos <> 15
                     AND n.n_sk = sk.n_sk
           AND  ( ( skrn.f_get_opl_sum (n.nd) > 0 AND
                ROUND (skrn.f_get_oplplan_sum_4date(n.nd,last_day(bankdate)) * 5 / 6) <> skrn.f_get_curdoh_sum (n.nd) )
              OR
              (n.amort_date is not null)
              )
                ORDER BY n_sk)
      LOOP
     init(null);

     IF k.amort_date is not null
     then
      sdoc_ := k.sp3;
         ELSE
            sdoc_ := k.sp2;
         END IF;

         IF sdoc_ > 0
     THEN
      l_amort := 1;
      EXIT;
     END IF;

    END LOOP;

    return l_amort;
   end;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  �������� ��������� ������
--  %%%%%%%%%%%%%%%%%%%%%%%%
   FUNCTION f_get_curdoh_sum (nd_ NUMBER)
      RETURN NUMBER
   IS
      s_     NUMBER;
      acc_   NUMBER;
   BEGIN
    /*
            -- �������� � �������������� ��������� �� ������� �����
            select ostc
            into s_
            from accounts a, skrynka_nd_acc n
            where n.nd = nd_ and n.tip = 'C' and n.acc = a.acc;
    */
      BEGIN
         SELECT a.acc
           INTO acc_
           FROM branch_parameters t, accounts a
          WHERE t.tag = 'DEP_S3'
            AND t.branch = branch_
            AND a.kv = 980
            AND a.nls = t.val /*and a.branch = t.branch*/;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN acc_ := NULL;
      END;
      SELECT NVL (SUM (o.s * (2*dk - 1)), 0)
        INTO s_
        FROM opldok o
       WHERE o.REF IN (SELECT r.REF
                         FROM skrynka_nd_ref r
                        WHERE r.nd = nd_
                          AND (rent = 1 or rent is null) )
         AND acc = acc_
         AND s > 0
         AND sos = 5;
   RETURN s_;
   END;

   --! ������ ���� ������ �� ��������
   FUNCTION f_get_peny(nd_ NUMBER)
  RETURN NUMBER
   IS
    res_ number;
   BEGIN
        WITH m
             AS (SELECT s.tariff, n.dat_begin, n.dat_end - n.dat_begin + 1 AS term
                   FROM skrynka_nd n, skrynka_tariff s
                  WHERE n.nd = nd_ AND s.o_sk = n.o_sk AND n.tariff = s.tariff)
        SELECT NVL (s.peny * 100, 0)
          INTO res_
          FROM skrynka_tariff2 s, m
         WHERE     s.tariff = m.tariff
               AND m.term >= s.daysfrom
               AND m.term <= s.daysto
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff2 ss
                        WHERE ss.tariff = m.tariff AND ss.tariff_date <= m.dat_begin);

    return res_;
   END;

   --! ������ ���� ������ �� �������� ��������
   FUNCTION f_get_peny_literal(nd_ NUMBER)
  RETURN VARCHAR2
   IS
    res_ varchar2(256);
   BEGIN
        WITH m
             AS (SELECT s.tariff, n.dat_begin, n.dat_end - n.dat_begin + 1 AS term
                   FROM skrynka_nd n, skrynka_tariff s
                  WHERE n.nd = nd_ AND s.o_sk = n.o_sk)
        SELECT f_sumpr (NVL (s.peny * 100, 0), 980, 'F')
          INTO res_
          FROM skrynka_tariff2 s, m
         WHERE     s.tariff = m.tariff
               AND m.term >= s.daysfrom
               AND m.term <= s.daysto
               AND s.tariff_date =
                      (SELECT MAX (ss.tariff_date)
                         FROM skrynka_tariff2 ss
                        WHERE ss.tariff = m.tariff AND ss.tariff_date <= m.dat_begin);
    return res_;
   END;

--  %%%%%%%%%%%%%%%%%%%%%%%%
--  ����������� ��������� ������
--  %%%%%%%%%%%%%%%%%%%%%%%%
   PROCEDURE init(parn_ NUMBER)
   IS
   BEGIN
      IF parn_ IS NULL
      THEN
    branch_ := sys_context('bars_context','user_branch');
      ELSE
        branch_ := parn_;
      END IF;

      BEGIN
         SELECT val
           INTO skrnpar1_
           FROM params
          WHERE par = 'SKRNPAR1';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skrnpar1_ := 0;
      END;

      BEGIN
         SELECT val
           INTO skrnpar2_
           FROM params
          WHERE par = 'SKRNPAR2';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skrnpar2_ := 0;
      END;

      BEGIN
         SELECT val
           INTO skrnpar3_
           FROM params
          WHERE par = 'SKRNPAR3';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            skrnpar3_ := 1;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nlskas_, nmskas_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_KAS' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_KAS');
      END;

      BEGIN
         SELECT rnk
           INTO def_rnk_
           FROM customer a
          WHERE a.rnk = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_SKRN' AND branch = branch_);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_SKRN');
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls9898_, nms9898_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S1' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nls9898_ := NULL;
            nms9898_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls9819_, nms9819_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S2' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nls9819_ := NULL;
            nms9819_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls6519_, nms6519_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S3' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN  null;
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S3');
      END;


      BEGIN
         SELECT a.nls, a.nms
           INTO nlss2909_, nmss2909_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S5' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      bars_error.raise_nerror(l_mod, 'PARAM_NOT_FOUND', 'DEP_S5');
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nlss3579_, nmss3579_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S6' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nlss3579_ := NULL;
            nmss3579_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nlsnds_, nmsnds_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S7' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nlsnds_ := NULL;
            nmsnds_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls_s9_, nms_s9_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S9' AND branch = branch_)
          and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            nls_s9_ := NULL;
            nms_s9_ := NULL;
      END;

      BEGIN
         SELECT a.nls, a.nms
           INTO nls6397_, nms6397_
           FROM accounts a
          WHERE a.nls = (SELECT val
                           FROM branch_parameters
                          WHERE tag = 'DEP_S10' AND branch = branch_)
        and a.kv = 980;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
      nls6397_ := null;
      nms6397_ := null;
      END;

      SELECT ID
        INTO userid_
        FROM staff$base
       WHERE id = user_id;

      -- ����
      BEGIN
         SELECT SUBSTR (val, 1, 14), SUBSTR (val, 1, 14)
           INTO okpoa_, okpob_
       FROM branch_parameters
      WHERE tag = 'OKPO' and branch = branch_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            okpoa_ := '';
            okpob_ := '';
      END;
   END;
-----------------------------------
BEGIN
   init(NULL);
END;
/
 show err;
 
PROMPT *** Create  grants  SKRN ***
grant EXECUTE                                                                on SKRN            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SKRN            to DEP_SKRN;
grant EXECUTE                                                                on SKRN            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/skrn.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 
