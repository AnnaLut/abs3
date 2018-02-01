CREATE OR REPLACE PROCEDURE BARS.p_fa7_nn (
   pdat_    DATE,
   pmode_   NUMBER DEFAULT 0,
   type_    NUMBER DEFAULT 1,
   pnd_     NUMBER DEFAULT NULL
)
IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :  ��������� ������������ #A7 ��� �� (�������������)
% COPYRIGHT   :  Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.002  30.01.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    ���������: Dat_ - �������� ����
               pmode_ = ����� (0 - ��� ����������, 1 - ��� ANI-�������, 2 - ��� @77)
               type_ = ��� �������� (0 - ��� �������� �� ������� �������,
                                     1 - �������� �� ������� ������� ���� ������,
                                         �� ������� ���� �������
                                     2 - �� ����������� �� �������� ������ ���������
                                         ����� (������ ��� �������), ��: ����� ��
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%/%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   ��������� ����������    D BBBB P X L R � VVV

 1     D          1/2  (������� ��/��)
 2     BBBB       R020 ���������� ����
 6     Z          R011
 7     P          R013
 8     X          S181 ��������� ���� ���������
 9     L          S240 ���� � ���������
10     R          K030 �������������  (1/2)
11     I          S190 ��� ����� ��������� ���������
12     VVV        R030 ��� ������

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 10.01.2018 ���������� �������� ������� S190
 29.12.2017 ��������� ��������� ����������� � ������ �� 26.12.2017
 24.11.2017 ��������� ����� ���� � dpu_vidd
 11.09.2017 ��� ������ 2701,3660 ����������� �� ������� � ����
 28.07.2017 ��������� ����������� r012 ��� ������ 1592
 15.05.2017 ����������� s240 ��� ������ 2924 �� ob22 (��� 322669)
 25.04.2017 ��� ������������ ������� �� ������ ����� ������� ��������������
            (dos99_, kos99_, dosq99_, kosq99_)
 21.03.2017 ��� 9129: ��� ���������� ��������� ���������� ���� � ���������
                      ������������ �� �������� ����������
 24.02.2017 ��� �������� �� �������� �� ������ ������� ���� ����������� ���
            ��������������� ������ 7 ������ (������ 3836 ��� 38..)
 23.01.2017 datp_ �� ������������� �� 1 ����
            (�������� �������� ������� ������� � �������� ������� � ���� ����)
 11.01.2017 ���:������ s240 ��� SNA ��� �������� �� �������� ������ (����� ����)
 09.12.2016 �������� �������� ����� ������� �������� ���������� � OTCN_FA7_REZ1
            ��� ������������� ��� ��������� ���������� ��������� ������
 22.09.2016 otcn_fa7_rez1 ����������� ������� 1__9,3119,3219
             � �������� � ��������� =0  (2-� ���� ����������� ��������)
 16.09.2016 -������� ���� ��������� ����������� s240 ��� "��������"
                ��������� �������� ����� 06.06.2015
 30.08.2016 -������ v_tmp_rez_risk_c5_new ������������� �������� ��������, ��������
             � �������� ������� � ��� ������� �������� -���������� ��� ����������
             ����������� ���������/������ ����������� � ����� ���������
 04.08.2016 - ����������������� R013 ��� ���������� ������� ��� �������
               �������� ��� ����.������ ��
 21/07/2016 - ��� ������ ������� �������� R013 ����� ������������ ��
               R013 ������� (����� ����������� ��������� �� 30, ������ 30)

 02/07/2016 - ��� ������ OPLDOK ������� ������� o.fdat = z.fdat
              ��� ���������� ������� ������������
              ��� ������ 974 (���������� �����) �� V_TMP_REZ_RISK_C5
              �������� �� �������� 933
 14/06/2016 - ��� ������ �������� ��� �������������� �������� �����
              �������� �� ���������  R012 �� 'A' � "B'
 10/06/2016 - �� 11.06.2016 � ���� ����� ���������� ����� ������� 1890, 2890,
              3590, 3599 � ������� ��� ��������� VIEW V_TMP_REZ_RISK_C5_NEW
              �� ��������� ������ ���.������ 181, 280, 351, 354, 355, 357
 14/07/2015 - ��� ����������� ����� @77 �� ����� ����������� ���������� � ����.
              RNBU_TRACE_ARCH
 13/07/2015 - ��� ����������� ����� @77 ���� ������� ������� �������� 1 �����
              ������ �� ��������
 02/07/2015 - ��� ����������� ����� @77 �� ����������� ������� TMP_IREP
 28/05/2015 - ��� ������ �������� � ������ ��� �������� ������� ��������� ����
              TOBO � RNBU_TRACE  (����� ��� �������� ���������� ���������)
 25/05/2015 - ��� pmode_ = 2 ����� ����������� ���� � ������ ��������
              �������������� �������� (������������ ����� @77 ��� ��)
              ������ VIEW sal ����� ������������ ������� OTCN_SALDO
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
   kodf_           VARCHAR2 (2)           := 'A7';
   sheme_          Varchar2(1) := 'G';

   ret_            NUMBER;
   add_            NUMBER;
   acc_            NUMBER;
   nbs_            VARCHAR2 (4);
   nbs1_           VARCHAR2 (4);
   nls_            VARCHAR2 (15);
   rnls_           VARCHAR2 (15);
   rez_            VARCHAR2 (1);
   kv_             SMALLINT;
   r011_           VARCHAR2 (1);
   r013_           VARCHAR2 (1);
   r013_1          VARCHAR2 (1);
   r013_30         NUMBER;
   dk_             VARCHAR2 (1);
   tips_           VARCHAR2 (3);
   r030_           VARCHAR2 (3);
   r031_           CHAR (1);
   datn_           DATE;
   data_           DATE;
   daos_           DATE;
   dapp_           DATE;
   mdate_          DATE;
   sdate_          DATE;
   d_open_         DATE;
   s_              NUMBER;
   freq_           NUMBER;
   apl_dat_        DATE;
   sn_             DECIMAL (24);
   se_             DECIMAL (24);
   se1_            DECIMAL (24);
   min_sum_        NUMBER;
   fa7d_           NUMBER;
   fa7k_           NUMBER;
   fa7p_           NUMBER;
   s180_           VARCHAR2 (1);
   s180_k          VARCHAR2 (1);
   s181_           VARCHAR2 (1);
   s190_           VARCHAR2 (1);
   s240_           VARCHAR2 (1);
   s242_           VARCHAR2 (1);
   p240_           VARCHAR2 (1);
   p240r_          VARCHAR2 (1);
   p242_           VARCHAR2 (1);
   s260_           VARCHAR2 (2);
   x_              VARCHAR2 (1);
   x1_             VARCHAR2 (1);
   kodp_           VARCHAR2 (20);
   userid_         NUMBER;
   sql_            VARCHAR2 (3000);
   mfo_            NUMBER;
   dc_             NUMBER;
   rnk_            NUMBER;
   isp_            NUMBER;
   nd_             NUMBER;
   zm_date_        DATE                  := TO_DATE ('01072006', 'ddmmyyyy');
   zm_date2_       DATE                  := TO_DATE ('21122012', 'ddmmyyyy');
   zm_date3_       DATE                  := TO_DATE ('30092013', 'ddmmyyyy');
   zm_date4_       DATE                  := TO_DATE ('26122017', 'ddmmyyyy');
   dp_date_        DATE                  := TO_DATE ('06062015', 'ddmmyyyy');
   dat23_          date;

   kol_nd_         number;
   kol_351_        number;
   ap_             NUMBER;
   comm_           rnbu_trace.comm%TYPE;
   comm1_          rnbu_trace.comm%TYPE;
   mfou_           NUMBER;
   exists_         NUMBER;
   mdater_         DATE;
   commb_          rnbu_trace.comm%TYPE;
   pr_             VARCHAR2 (1);
   dat_            DATE                   := pdat_;
   typ_            NUMBER;
   nbuc1_          accounts.tobo%TYPE;
   nbuc_           accounts.tobo%TYPE;

   -- ������� �������������� �������
   -- ������� ������� ��������� ������������������ �����
   exist_fakt      NUMBER                 := 0;
  -- ������� �������������� ������ ����������
   exist_sbb       NUMBER                 := 0;
   -- ������� ������ ������� �������
   exist_trans     NUMBER                 := 0;
   -- ������� ������� ��������� ������������������ ����� �� ������ �����
   exist_sbb_acc   NUMBER                 := 0;
   exist_trans_acc NUMBER                 := 0;
   exist_dop       NUMBER                 := 0;
   exist_cp        NUMBER                 := 0;
   exist_cp_acc    NUMBER                 := 0;
   exist_sno_gr    NUMBER                 := 0;
   exist_cclim_acc      NUMBER                 := 0;

   tobo_           accounts.tobo%TYPE;
   branch_         accounts.tobo%TYPE;
   branch_bars     accounts.tobo%TYPE;
   -- �� 30 ����
   o_r013_1        VARCHAR2 (1);
   o_se_1          DECIMAL (24);
   o_comm_1        rnbu_trace.comm%TYPE;
   -- ����� 30 ����
   o_r013_2        VARCHAR2 (1);
   o_se_2          DECIMAL (24);
   o_comm_2        rnbu_trace.comm%TYPE;
   pr_accc         NUMBER;

   o_se_all        DECIMAL (24);
   o_se_1z         DECIMAL (24);
   o_se_2z         DECIMAL (24);

   pr_graf         varchar2(1) := F_Get_Params ('OTC_GRAF', '1');
   tp_graf         BOOLEAN
      := (CASE
             WHEN type_ = 0 or pr_graf = '0'
                THEN FALSE             -- ������������ ��� �������� �� �������
             ELSE TRUE        -- ������������ � ��������� �� ������� ���������
          END
         );

   fl_mode_ char(8);
   pr_01    Number;

   sql_doda_ varchar2(2000);
   sql_acc_ clob;
   datz_    date := Dat_Next_U(dat_, 1);
   r012_    specparam.r012%type;
   TP_REZ   BOOLEAN := false;
   TP_SND   BOOLEAN := false;
   znap_    rnbu_trace.znap%type;

   type     t_otcn_log is table of number index by pls_integer;
   table_otcn_log3_ t_otcn_log;

   TYPE     t_otcn IS TABLE OF NUMBER(1) INDEX BY VARCHAR2(5);

   table_otcn_c5    t_otcn;
   table_otcn_a7    t_otcn;

   table_R011      t_otcn;
   table_R013_1    t_otcn;
   table_r013_2    t_otcn;

   cnt_     number;
   datr_    date;
   datb_    date;
   sum_     number;
   sumc_    number := 0;
   srez_    number := 0;
   srezp_   number := 0;
   sakt_    number := 0;

   nbs_r013_    varchar2(5);

   -- ���������� ����� ��������
   nbsdiscont_     VARCHAR2 (2000)
      := '2016,2026,2036,2066,2076,2086,2106,2116,2126,2136,2206,2216,2226,2236,2706,3666,1626';
   -- ���������� ����� ������
   nbspremiy_      VARCHAR2 (2000)
      := '2065,2075,2085,2105,2115,2125,2135,2205,2215,2235,';

   discont_ number := 0;
   premiy_  number := 0;

   -- ������� ���������� ������������������ ������ �����. ������������� � ���.�������
   FL_DO_   number;
   FL_D8_   number := F_Get_Params('DPULINE8', -1);

   datp_    date;
   kodp1_   varchar2(100);
   codc_    number;

   dathb_   date;
   dathe_   date;
   fl_cp_   number:=0;

   id_      NUMBER;
   accr_    number;
   nkd_     varchar2(100);

   s#_              NUMBER;
   freq#_           NUMBER;
   apl_dat#_        DATE;
    
   sum_zal          number:=0;

----------------------------------------------------------------------------
   TYPE ref_type_curs IS REF CURSOR;

   saldo        ref_type_curs;
   cursor_sql   clob;

   type rec_type is record
        (acc_   number,
         nls_   varchar2(15),
         kv_    integer,
         data_  date,
         nbs_   varchar2(4),
         tips_  varchar2(3),
         p240_  char(1),
         s180_  char(1),
         s181_  char(1),
         r011_  char(1),
         r013_  char(1),
         r031_  varchar2(2),
         mdate_ date,
         sn_    number,
         se_    number,
         rnk_   number,
         isp_   number,
         rez_   char(1),
         ap_    char(1),
         daos_  date,
         dapp_  date,
         pr_    VARCHAR2 (1),
         tobo_  accounts.tobo%TYPE,
         s260_  varchar2(2),
         r012_  char(1),
         r030_  number,
         codc_  number,
         nkd_   varchar2(100),
         s190_  varchar2(1),
         nd_    number,
         sdate_ date,
         freq#           NUMBER,
         s#              NUMBER,
         apl_dat#        DATE
        );

   TYPE rec_t IS TABLE OF rec_type;
   l_rec_t      rec_t := rec_t();

   TYPE rnbu_trace_t IS TABLE OF rnbu_trace%rowtype;
   l_rnbu_trace rnbu_trace_t := rnbu_trace_t();

   type rec_type8 is record
        (acc_   number,
         r013_1 char(1),
         ost_1  number,
         r013_2 char(1),
         ost_2  number
        );

   TYPE rec_t8 IS TABLE OF rec_type8;
   l_rec_t8      rec_t8 := rec_t8();

function f_get_r012_for_1508( p_acc in number )
     return varchar2
is
   l_r011     varchar2(1);
begin

    begin
       select nvl(trim(r011),'1')    into l_r011
         from specparam
        where acc =p_acc;

    exception
       when no_data_found  then  l_r011 :='1';
    end;

    if l_r011 ='1'  then
            return 'K';
    else
            return 'L';
    end if;

end;

    procedure p_add_rec(p_recid rnbu_trace.recid%type, p_userid rnbu_trace.userid%type, p_nls rnbu_trace.nls%type,
                        p_kv rnbu_trace.kv%type, p_odate rnbu_trace.odate%type, p_kodp rnbu_trace.kodp%type,
                        p_znap rnbu_trace.znap%type, p_acc rnbu_trace.acc%type, p_rnk rnbu_trace.rnk%type,
                        p_isp rnbu_trace.isp%type, p_mdate rnbu_trace.mdate%type, p_comm rnbu_trace.comm%type,
                        p_nd rnbu_trace.nd%type, p_nbuc rnbu_trace.nbuc%type, p_tobo rnbu_trace.tobo%type)
    is
        lr_rnbu_trace rnbu_trace%rowtype;
    begin
       lr_rnbu_trace.RECID := p_recid;
       lr_rnbu_trace.USERID := p_userid;
       lr_rnbu_trace.NLS := p_nls;
       lr_rnbu_trace.KV := p_kv;
       lr_rnbu_trace.ODATE := p_odate;
       lr_rnbu_trace.KODP := p_kodp;
       lr_rnbu_trace.ZNAP := p_znap;
       lr_rnbu_trace.NBUC := p_nbuc;
       lr_rnbu_trace.ISP := p_isp;
       lr_rnbu_trace.RNK := p_rnk;
       lr_rnbu_trace.ACC := p_acc;
       lr_rnbu_trace.ref := null;
       lr_rnbu_trace.COMM := p_comm;
       lr_rnbu_trace.ND := p_nd;
       lr_rnbu_trace.mdate := p_mdate;
       lr_rnbu_trace.TOBO := p_tobo;

       l_rnbu_trace.Extend;
       l_rnbu_trace(l_rnbu_trace.last) := lr_rnbu_trace;

       if l_rnbu_trace.COUNT >= 100000 then
          FORALL i IN 1 .. l_rnbu_trace.COUNT
               insert /*+ append */ into rnbu_trace values l_rnbu_trace(i);

          l_rnbu_trace.delete;
       end if;
    end;

-------------------------------------------------------------------
   PROCEDURE pp_doda
   IS
   BEGIN
      -- ��� ������� 05.05.2009
      IF nbs_ IN ('2608')
      THEN
         s180_ := '1';
         x_ := '1';
         s242_ := '1';
         comm_ :=
                SUBSTR (comm_ || ' +������ (S180=1, s181=1, s242=1)', 1, 200);
      END IF;

      IF mfou_ IN (300465)
           AND SUBSTR (nbs_, 1,3) IN ('140', '301')
      THEN
         IF  s180_ ='0'  THEN

            s180_ := '1';
         END IF;

         IF  s242_ ='0'  THEN

            s242_ := '1';
         END IF;
      END IF;

      IF 333368 IN (mfo_, mfou_)
      THEN                             --  11/09/2009 ��� �������� ����� (���)
         IF nbs_ IN ('2628') AND x_ = '0'
         THEN
            x_ := '1';
            comm_ := SUBSTR (comm_ || ' +������ (s181=1)', 1, 200);
         END IF;
      END IF;

      -- Virko �������� 18/08/2010
      IF mfou_ = 300465
      THEN         -- ����� ����� �31/5-05/171=1612 �� 12/03/2009 �� ������
         IF nbs_ LIKE '254%'
         THEN
            s242_ := '1';
         END IF;
      END IF;

      -- 11/07/2012 ������ + 20/06/2013 ��� ��������
--      if substr(nls_, 1, 4) in ('1410', '1420', '1430', '1435', '1436', '1437', '1440', '1446', '1447', '3040') or
--         substr(nls_, 1, 4) in ('1415', '1416', '1417', '1426', '1427') and
--         r013_ in ('2', '4', '5', '6', '7')     �� 26.12.2017
--         r011_ in ('2', 'D')
--      THEN                           
--         x_ := '1';
--         s242_ := '1';
--      END IF;

      -- ��� ��������� ����� 21/08/2012
      IF mfo_ = 328845
      THEN
         IF nbs_ in ('2620', '2628')
         THEN
            declare
                ob22_ varchar2(2);
            begin
                sql_doda_ := 'select ob22 from specparam_int where acc = '||to_char(acc_);
                execute immediate sql_doda_ into ob22_;

                if nbs_ = '2620' and ob22_ in ('15','23','24','25') or
                   nbs_ = '2628' and ob22_ in ('17','25','26','27')
                then
                    x_ := '1';
                    s242_ := '1';
                end if;
            exception
                when no_data_found then null;
            end;
         END IF;
      END IF;

      -- �������������� ��-����������
--      if nbs_ in ('2628', '2630', '2062', '2082', '2102',
--                  '2112', '2122', '2132', '2202', '2232') then
--         if x_ = '2' or s242_ >= 'C' and s242_ <> 'Z' then
--             if x_ = '2' then
--                x_ := '1';
--             end if;
--
--             if s242_ >= 'C' and s242_ <> 'Z' then
--                s242_ := 'B';
--             end if;
--
--             comm_ :=
--                    SUBSTR (comm_ || ' +����� (s181=1, s240<=B �� KL_R020)', 1, 200);
--         end if;
--      end if;


      -- 10.12.2015 ���������� �� (������) �������, ��� ��� ��������� ��� ��������
      -- � ������������ ���� ������ ����� �������
--      if nbs_ in ('2063','2071','2083','2103','2113','2123','2133','2203','2211','2233') and
--         x_ <> '2'
--      then
--         x_ := '2';
--         comm_ := SUBSTR (comm_ || ' +����� (s181=2 �� KL_R020)', 1, 200);
--      end if;

      -- ����� ����� �14/2-04/ ID 1259 �� 28.02.2014
      if    ( nbs_ in ('1600','2600','2605','2620','2625','2650','2655') and sn_ < 0
           or nbs_ = '1500' )
         and (x_ <> '1' or s242_ <> '1')
      then
        if x_ <> '1' then
           x_ := '1';
        end if;

        if s242_ <> '1' then
           s242_ := '1';
        end if;

        comm_ := SUBSTR (comm_ || ' +����� (�������� 1 ���)', 1, 200);
      end if;

      -- 10/12/2015 (23/11/2015)
      if (nbs_ in ('1600', '2605', '2600', '2620', '2625', '2650', '2655') and sn_ > 0)
      then
        if x_ <> '1' then
           x_ := '1';
        end if;

         if nbs_||r011_ in ('16001', '26003', '26053', '26203', '26253', '26503', '26553') and
            daos_ >= to_date('06062015','ddmmyyyy')
         then
             if s242_ not in ('1','2','3','4','5','I') then
                s242_ := 'I';
                comm_ := SUBSTR (comm_ || ' +����� (�������� 2 ���)', 1, 200);
             end if;
         else
            if s242_ <> '1' then
               s242_ := '1';
               comm_ := SUBSTR (comm_ || ' +����� (�������� 3 ���)', 1, 200);
            end if;
         end if;
      end if;
   END pp_doda;

-------------------------------------------------------------------
   PROCEDURE p_exist_fakt
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_fakt
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'FAK_INVOICE%';
   END;

-------------------------------------------------------------------
   PROCEDURE p_exist_sbb
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_sbb
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'OTCN_LIM_SB%';
   END;

   PROCEDURE p_exist_trans
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_trans
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CC_TRANS';
   END;

   PROCEDURE p_exist_cp
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_cp
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CP_DEAL';

      if exist_cp = 0 then return; end if;

      SELECT COUNT (*)
        INTO exist_cp
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CP_DAT';

      if exist_cp = 0 then return; end if;

      SELECT COUNT (*)
        INTO exist_cp
        FROM all_tables
       WHERE owner = 'BARS' AND table_name LIKE 'CP_KOD';
   END;

   PROCEDURE p_exist_sno_gr
   IS
   BEGIN
      SELECT COUNT (*)
        INTO exist_sno_gr
        FROM all_views
       WHERE owner = 'BARS' AND view_name LIKE 'VC_SNO';
   END;

   FUNCTION f_exist_sbb_acc (pacc_ IN NUMBER)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (100);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*) ' || 'from OTCN_LIM_SB ' || 'where acc=:acc_';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pacc_;

      RETURN cnt_;
   END;

   FUNCTION f_exist_cclim_acc (pacc_ IN NUMBER)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (100);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*) ' || 'from CC_LIM ' || 'where acc=:acc_';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pacc_;

      RETURN cnt_;
   END;

   FUNCTION f_exist_trans_acc (pacc_ IN NUMBER, pdat_ in date)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (1000);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*)
               from OTC_ARC_CC_TRANS
               where dat_otc = :dat_
                 and acc=:acc_
                 and (d_fakt is null or sv<>sz) ';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pdat_, pacc_;

      RETURN cnt_;
   END;

   FUNCTION f_exist_cp_acc (pacc_ IN NUMBER, pdat_ in date)
      RETURN NUMBER
   IS
      sql_   VARCHAR2 (1000);
      cnt_   NUMBER;
   BEGIN
      sql_ := 'select count(*) ' ||
              'from cp_deal d, cp_dat c, cp_kod k '||
              'where d.acc = :acc_ and d.id = c.id and d.id = k.id and'||
                    ' c.nom <> 0 and c.dok >= :dat_ and k.cena <> k.cena_start ';

      EXECUTE IMMEDIATE sql_
                   INTO cnt_
                  USING pacc_, pdat_;

      RETURN cnt_;
   END;
BEGIN
   if pmode_ = 2 then -- ��� ����� @77
      p_arc_otcn (dat_, 0);
   else
      p_arc_otcn (dat_, pmode_);
   end if;
   commit;

   EXECUTE IMMEDIATE 'ALTER SESSION ENABLE PARALLEL DML';
-------------------------------------------------------------------
   logger.info ('P_FA7_NN: Begin ');

   userid_ := user_id;

   EXECUTE IMMEDIATE 'TRUNCATE TABLE RNBU_TRACE';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ1';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_REZ2';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_KOD_R020';

   EXECUTE IMMEDIATE 'TRUNCATE TABLE OTCN_FA7_DAPP';
-------------------------------------------------------------------
-- ���� ���
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

   if 300465 in (mfo_, mfou_) then
      sheme_ := 'C';
   end if;

   -- ����������� ���� ������� ��� ���������� ����� � �����
   P_Proc_Set (kodf_, sheme_, nbuc1_, typ_);

   p_exist_fakt ();
   p_exist_sbb ();
   p_exist_cp ();
   p_exist_sno_gr();

   p_exist_trans ();

   -- ������� ���������� ������������������ ������ �����. ������������� � ���.�������
   FL_DO_ := F_Get_Params ('FLDO_A7', -1);

   IF pmode_ = 0
   THEN                                                      -- ��� ����������
      -- �� 18.04.2008 ��� ������ 300175 � 322498 ������� �������� S240 ����������
      -- �� ���� ��������� ������ (�������� � �������� ����) �� ���� ���������
      -- �������, � ��� ������ ������ �� ���� ������������ �����
      -- � 18.04.2008 ��� ���� ������ ����� ������� ����� ������ �� ���� ���������
      -- ������

      -- ����������� ���� ����� ������
      dc_ := TO_NUMBER (LTRIM (TO_CHAR (dat_, 'DD'), '0'));

      FOR i IN 1 .. 3
      LOOP
         IF dc_ BETWEEN 10 * (i - 1) + 1 AND 10 * i + iif (i, 3, 0, 1, 0)
         THEN
           IF i < 3
           THEN
              datp_ := TO_DATE (LPAD (10 * (i - 1) + 1, 2, '0')
                          || TO_CHAR (dat_, 'mmyyyy'),
                          'ddmmyyyy'
                         );
              datn_ :=
                 TO_DATE (LPAD (10 * i, 2, '0')
                          || TO_CHAR (dat_, 'mmyyyy'),
                          'ddmmyyyy'
                         );
           ELSE
              datp_ := to_date('21'|| TO_CHAR (dat_, 'mmyyyy'), 'ddmmyyyy');
              datn_ := LAST_DAY (dat_);
           END IF;

           EXIT;
         END IF;
      END LOOP;
   ELSE                                    -- ��� ANI-������� � ������ �������
      datp_ := dat_;
      datn_ := dat_;
   END IF;

   --  ���� ������ �������
    Dat23_ := TRUNC(add_months(Dat_,1),'MM');

   --  ������ ���� ������� ������
   select min(fdat), max(fdat)
   into datp_, datb_
   from fdat
   where  fdat between datp_ and datn_;

   datz_ := datn_ + 1;

   insert /*+append */
   into TMP_KOD_R020
   SELECT r020
      FROM kod_r020
     WHERE a010 = 'A7'
       AND trim(prem) = '��'
       AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
       and (d_close is null or
            d_close >= datz_);
    commit;

    insert/*+append */
    into otcn_fa7_dapp
    select s.acc, max(s.fdat) dapp
     from saldoa s, accounts a
     where s.fdat <= dat_ and
           s.kos <> 0 and
           (s.ostf >= 0 or s.ostf-s.dos+s.kos >= 0) and
           s.acc = a.acc and
           a.nbs in (select distinct t.r020
                     from tmp_kod_r020 t, kl_r020 r
                     WHERE trim(r.prem) = '��'
                      AND  (LOWER (r.txt) LIKE '%�����%�����%'
                         OR LOWER (txt) LIKE '%�����%����%') and
                      t.r020 = r.r020)
   group by s.acc;
   commit;

   declare
      cnt_ number;
   begin
       select count(*)
       into cnt_
       from holiday
       where holiday = datn_;

       dathb_ := null;
       dathe_ := null;

       if cnt_ > 0 then
          select max(fdat) + 1
          into dathb_
          from fdat
          where fdat < datn_;

          select min(fdat) - 1
          into dathe_
          from fdat
          where fdat > datn_;
       else
          select max(fdat) + 1
          into dathe_
          from fdat
          where fdat < datn_;

          if datn_ <> dathe_ then
             dathb_ := dathe_;

             select max(holiday)
             into dathe_
             from holiday
             where holiday < datn_;
          else
             dathb_ := null;
             dathe_ := null;
          end if;
       end if;
   end;

   for k in (SELECT r020
        FROM kl_r020
       WHERE trim(prem) = '��'
         AND (LOWER (txt) LIKE '%�����%�����%'
              OR LOWER (txt) LIKE '%�����%����%')
         AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
         and (d_close is null or
              d_close >= datz_))
   loop
       table_otcn_a7(k.r020) := 1;
   end loop;

   for k in (SELECT r020
              FROM kod_r020
                 WHERE trim(prem) = '��'
                   AND a010 = 'C5'
                   AND r020 NOT IN ('2628')
                   and (d_open between TO_DATE ('01011997', 'ddmmyyyy') and datz_
                        and (d_close is null or d_close >= datz_)))
   loop
       table_otcn_c5(k.r020) := 1;
   end loop;

   for k in (select distinct r020||r011 pok
             from kl_r011
             where trim(prem)='��'
                  and (d_close is null or
                       d_close >= datz_))
   loop
       table_r011(k.pok) := 1;
   end loop;

   for k in (select distinct r020||r013 pok
             from kl_r013
             where trim(prem)='��'
                  and (d_close is null or
                       d_close >= datz_))
   loop
       table_r013_1(k.pok) := 1;
   end loop;

   for k in (select distinct r020||r013 pok
             from kl_r013
             where trim(prem)='��'
                   and d_close is not null and d_close <= datz_)
   loop
       table_r013_2(k.pok) := 1;
   end loop;
   
   if mfo_ = 300465 then
         pul_dat(to_char(Dat_,'dd-mm-yyyy'), '');

         EXECUTE IMMEDIATE 'delete from otcn_f42_cp';

         sql_acc_ :=
                'insert into otcn_f42_cp (fdat, acc, nls, kv, sum_zal, dat_zal, rnk, kodp) '
              ||'select c.fdat, a.acc, a.nls, a.kv, nvl(c.sum_zal, 0), c.dat_zal, a.rnk, null '
              ||'from accounts a, cp_v_zal_acc c '
              ||'where a.acc = c.acc '
              ||'  and c.fdat = :dat_ '
              ||'  and substr(a.nls,1,4) like ''14__%''' ;

            EXECUTE IMMEDIATE sql_acc_ USING dat_;
   end if;

   if pnd_ is null then
      sql_acc_ := ' SELECT  /*+ parallel(a, 8) */ *
                    FROM ACCOUNTS a
                    WHERE ( '||to_char(mfou_)||' = 324805
                              AND (a.nbs LIKE ''262%'' OR a.nbs LIKE ''263%'')
                              AND NOT EXISTS (SELECT 1
                                               FROM kf91 K
                                              WHERE TRIM(K.NLS) = A.NBS AND
                                                    K.KV = A.KV AND
                                                    K.RNK = A.RNK AND
                                                    nms LIKE ''A7%'')
                          OR
                              '||to_char(mfou_)||' = 324805
                              AND (a.nbs NOT LIKE ''262%'' AND a.nbs NOT LIKE ''263%'')
                          OR
                             '||to_char(mfou_)||' <> 324805
                         )
                     AND  nvl(a.nbs, SUBSTR (a.nls, 1, 4)) in (
                            SELECT r020
                              FROM tmp_kod_r020
                              ) '||
                     (case when FL_D8_ = '8' then  ' and tip <> ''NL8'' ' else '' end)||
                     (case  when FL_DO_ = 1
                      then ' and nvl(a.nbs, SUBSTR (a.nls, 1, 4)) not in '||
                           '(select BBBB from A_TPK_A7ADD where fdat = '||
                           ' to_date('''||to_char(dat_,'ddmmyyyy')||''',''ddmmyyyy'')) '
                      else ''
                      end)  ||
                     (case when FL_D8_ = '8' then
                         ' union all
                            SELECT s.ACC, s.KF, s.NLS, s.KV, s.BRANCH, s.NLSALT, a.NBS, s.NBS2, s.DAOS,
                                s.DAPP, s.ISP, s.NMS, s.LIM, s.OSTB, s.OSTC, s.OSTF, s.OSTQ, s.DOS, s.KOS,
                                s.DOSQ, s.KOSQ, s.PAP, s.TIP, s.VID, s.TRCN, s.MDATE, s.DAZS, s.SEC, s.ACCC,
                                s.BLKD, s.BLKK, s.POS, s.SECI, s.SECO, s.GRP, s.OSTX, s.RNK, s.NOTIFIER_REF,
                                s.TOBO, s.BDATE, s.OPT, s.OB22, s.DAPPQ, s.SEND_SMS, s.DAT_ALT
                             FROM ACCOUNTS a, V_DPU_REL_ACC_ALL v, accounts s
                             where a.nbs IN (
                                SELECT r020
                                  FROM tmp_kod_r020 ) and
                                   a.tip = ''NL8''  and
                                   a.acc = v.GEN_ACC and
                                   v.DEP_ACC = s.acc 
              and (s.kf=337568 and s.nls!=''86103373103001'' or s.kf !=337568) '
                       else '' end);
   else
      sql_acc_ := 'SELECT *
                    FROM ACCOUNTS a
                    WHERE acc in (select acc from nd_acc where nd = '||to_char(pnd_)|| ' ) and
                        ( '||to_char(mfou_)||' in ( 324805,380764)
                              AND (a.nbs LIKE ''262%'' OR a.nbs LIKE ''263%'')
                              AND NOT EXISTS (SELECT TRIM (nls), rnk
                                               FROM kf91 K
                                              WHERE TRIM(K.NLS) = A.NBS AND
                                                    K.KV = A.KV AND
                                                    K.RNK = A.RNK AND
                                                    nms LIKE ''A7%'')
                          OR
                              '||to_char(mfou_)||' in( 324805,380764)
                              AND (a.nbs NOT LIKE ''262%'' AND a.nbs NOT LIKE ''263%'')
                          OR
                             '||to_char(mfou_)||' not in (324805,380764)
                         )
                     AND  nvl(a.nbs, SUBSTR (a.nls, 1, 4)) in (
                            SELECT r020
                              FROM tmp_kod_r020
                             )  and tip <> ''NL8'' ';
   end if;

   begin
      if pmode_ <> 2
      then
         ret_ := BARS.F_POP_OTCN( dat_, 1, sql_acc_, null, 0, 1);
      else
         -- ��� ��������� ����� � ������ ��������������
         if to_char(dat_, 'mm') = '12' then
            ret_ := BARS.F_POP_OTCN( dat_, 4, sql_acc_, null, 1, 1);
         else
            ret_ := BARS.F_POP_OTCN( dat_, 2, sql_acc_, null, 0, 1);
         end if;
      end if;
   end;

      select count(*)   into kol_nd_
        from kol_nd_dat
       where dat =pdat_;

      if kol_nd_ =0  then
           P_KOL_ND_OTC(pdat_);    -- ���������� ����. ���� ��������� �� ����
           commit; 
      end if;

--   p_upd_r012('A7', mfou_);

   cursor_sql := 'select t.*
                  from (select a.*, d.nd, d.sdate, v.freq, v.s, v.apl_dat
                       from (
                       SELECT a.acc, a.nls, a.kv, a.fdat, a.nbs, a.tip, p.s240, p.s180, p.s181,
                             p.r011, nvl(trim(p.r013), ''0'') r013, l.r031, a.mdate, a.ost, a.ostq, a.rnk, a.isp,
                             DECODE(f_ourmfo, 380764, 2-MOD(c.codcagent,2), NVL (DECODE (c.country, 804, ''1'', ''2''), ''1'')) k041,
                             a.pap, a.daos, a.dapp, a.pr, a.tobo, LPAD (NVL (TRIM (p.s260), ''00''), 2, ''0'') s260,
                             nvl(p.r012, ''0'') r012, lpad(l.r030, 3, ''0'') r030,
                             (case when c.codcagent = 5 and sed = ''91'' then 3 else c.codcagent end) codcagent,
                             p.nkd
                        FROM (SELECT /*+ parallel(8) */
                                     s.acc, s.nls, s.kv, s.mdate, aa.fdat, s.nbs, s.tip,
                                     aa.dos, aa.kos, s.rnk, s.isp, s.pap, s.daos,
                                     DECODE(:pmode_, 2, aa.ost - aa.dos96 + aa.kos96, aa.ost) ost,
                                     DECODE(:pmode_, 2,
                                         decode(aa.kv, 980, aa.ost - aa.dos96 + aa.kos96,
                                                            aa.ostq - aa.dosq96 + aa.kosq96),
                                         decode(aa.kv, 980, aa.ost, aa.ostq)) ostq,
                                     s.dapp, ''0'' pr, s.tobo
                                FROM otcn_saldo aa, otcn_acc s
                               WHERE aa.acc = s.acc and
                                     s.tip <> ''REZ'' ) a,
                             kl_r030 l,
                             specparam p,
                             customer c
                       WHERE a.ost <> 0
                         AND a.kv = TO_NUMBER (l.r030)
                         AND a.acc = p.acc(+)
                         AND a.rnk = c.rnk) a
                         left outer join (select n.acc, max(n.nd) nd, max(c.sdate) sdate
                                              from nd_acc n, cc_deal c
                                              where n.nd = c.nd and
                                                        c.sdate <= :dat_
                                               group by n.acc) d
                         on (a.acc = d.acc)
                         left outer join (SELECT i.freq, NVL (i.s, 0) s, i.apl_dat, n8.nd nd
                                           FROM nd_acc n8, accounts a8, int_accn i
                                           WHERE n8.acc = a8.acc
                                             AND a8.nls LIKE ''8999%''
                                             AND a8.acc = i.acc
                                             AND i.ID = 0) v
                         on (d.nd = v.nd) ) t
                         order by t.tobo ' ;

   OPEN saldo FOR cursor_sql USING pmode_, pmode_, Dat_;
   LOOP
      FETCH saldo BULK COLLECT INTO l_rec_t LIMIT 100000;
      EXIT WHEN l_rec_t.count = 0;

      for i in 1..l_rec_t.count loop
          acc_   :=     l_rec_t(i).acc_;
          nls_   :=     l_rec_t(i).nls_;
          kv_    :=     l_rec_t(i).kv_;
          data_  :=     l_rec_t(i).data_;
          nbs_   :=     l_rec_t(i).nbs_;
          tips_  :=     l_rec_t(i).tips_;
          p240_  :=     l_rec_t(i).p240_;
          s180_  :=     l_rec_t(i).s180_;
          s181_  :=     l_rec_t(i).s181_;
          r011_  :=     l_rec_t(i).r011_;
          r013_  :=     l_rec_t(i).r013_;
          r031_  :=     l_rec_t(i).r031_;
          mdate_ :=     l_rec_t(i).mdate_;
          sn_    :=     l_rec_t(i).sn_;
          se_    :=     l_rec_t(i).se_;
          rnk_   :=     l_rec_t(i).rnk_;
          isp_   :=     l_rec_t(i).isp_;
          rez_   :=     l_rec_t(i).rez_;
          ap_    :=     l_rec_t(i).ap_;
          daos_  :=     l_rec_t(i).daos_;
          dapp_  :=     l_rec_t(i).dapp_;
          pr_    :=     l_rec_t(i).pr_;
          tobo_  :=     l_rec_t(i).tobo_;
          s260_  :=     l_rec_t(i).s260_;
          r012_  :=     l_rec_t(i).r012_;
          r030_  :=     l_rec_t(i).r030_;
          codc_  :=     l_rec_t(i).codc_;
          nkd_   :=     l_rec_t(i).nkd_;
          s190_  :=     l_rec_t(i).s190_;
          nd_    :=     l_rec_t(i).nd_;
          sdate_  :=    l_rec_t(i).sdate_;
          freq#_  :=    l_rec_t(i).freq#;
          s#_     :=    l_rec_t(i).s#;
          apl_dat#_ :=    l_rec_t(i).apl_dat#;

          p240_ := NVL (TRIM (p240_), '0');
          s180_ := NVL (TRIM (s180_), '0');
          s181_ := NVL (TRIM (s181_), '0');
          r011_ := NVL (TRIM (r011_), '0');
          r013_ := NVL (TRIM (r013_), '0');

          r030_ := LPAD(r030_, 3, '0'); 
          
          s190_ :='0';

          tips_ := TRIM (tips_);

          pr_accc := 0;

          IF typ_ > 0 THEN
             nbuc_ := NVL (F_Codobl_branch (tobo_, typ_), nbuc1_);
          ELSE
             nbuc_ := nbuc1_;
          END IF;

          if r013_ <> '0' then
             BEGIN
                if table_r013_1(nbs_||r013_) = 1 then
                   r013_1 := r013_;
                end if;
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                BEGIN
                   if table_r013_2(nbs_||r013_) = 1 then
                      r013_1 := r013_;
                   end if;

                   r013_ := '0';
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                   null;
                END;
             END;
          end if;

          IF mfou_ IN (300465)
             AND (SUBSTR (nls_, 1, 3) IN
                    ('140', '141', '142', '143', '144', '300', '301', '310',
                     '311', '312', '313', '321', '330', '331') or SUBSTR (nls_, 1, 4) in ('3541', '4203'))
          THEN
             -- ������� ��� ����� ����� �� ��������� �������� ������ �� ��
             -- ������ �����������������
             IF     nbs_ IS NOT NULL
                AND (mfo_ = 300465 and nbs_ NOT IN ('1405', '1415', '1435', '3007', '3015', '3107', '3115') or
                     mfo_ <> 300465)
             THEN
                BEGIN
                   SELECT COUNT (*)
                     INTO pr_accc
                     FROM otcn_saldo a, accounts s
                    WHERE a.fdat = dat_
                      AND s.accc = acc_
                      AND s.accc = a.acc
                      AND s.nbs IS NULL;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      pr_accc := 0;
                END;
             END IF;
          END IF;

--------------------------------------- S190
          begin
              select nvl(kol,0)  into kol_351_
                from kol_nd_dat
               where dat =pdat_
                 and nd = nd_
                 and rownum = 1;

          exception
             when others  then  kol_351_ :=0;
          end;

          if kol_351_ = 0
          then
             s190_ := '0';
          elsif kol_351_ > 0 and kol_351_ < 8
          then
             s190_ := 'A';
          elsif kol_351_ < 31
          then
             s190_ := 'B';
          elsif kol_351_ < 61
          then
             s190_ := 'C';
          elsif kol_351_ < 91
          then
             s190_ := 'D';
          elsif kol_351_ < 181
          then
             s190_ := 'E';
          elsif kol_351_ < 361
          then
             s190_ := 'F';
          else
             s190_ := 'G';
          end if;

---------------------------------------
          IF    (    mfou_ IN (300465)
                 AND (   (    nbs_ IS NULL
                          AND (mfo_ = 300465 and SUBSTR (nls_, 1, 4) NOT IN
                                 ('1405', '1415', '1435', '3007', '3015', '3107','3115') or
                               mfo_ <> 300465)
                         )
                      OR (pr_accc = 0 AND nbs_ IS NOT NULL)
                     )
                )
             OR mfou_ NOT IN (300465)
          THEN
             IF nbs_ IS NULL
             THEN
                nbs_ := SUBSTR (nls_, 1, 4);
             END IF;

             BEGIN
                if table_otcn_c5(nbs_) = 1 then
                   pr_ := '1';
                else
                   pr_ := '0';
                end if;
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   pr_ := '0';
             END;

             exist_sbb_acc := 0;

             p240r_ := fs240 (datn_, acc_, dathb_, dathe_, mdate_, p240_);

             IF s180_ = '0'
             THEN
                s180_ := fs180 (acc_, SUBSTR (nbs_, 1, 1), dat_);
             END IF;

             IF s181_ = '0'
             THEN
                s181_ := fs181 (acc_, dat_, s180_);
             END IF;

             freq_ := NULL;
             x_ := s181_;
             fa7p_ := 0;
             s242_ := NULL;

             -- ���� ����������� ���������?
             BEGIN
                 if table_otcn_a7(nbs_) = 1 then
                    fa7p_ := 1;
                 else
                    fa7p_ := 0;
                 end if;
             EXCEPTION
                WHEN NO_DATA_FOUND
                THEN
                   fa7p_ := (case when substr(nls_,1,1) in ('1','2', '3') and
                        (substr(nls_,4,1) in ('8') or substr(nls_,1,4) in ('2607', '2627'))
                        then 1 else 0 end);
             END;

             IF fa7p_ > 0 and upper(nkd_) like '%���%' and nvl(trim(p240_), '0') <> '0' then
                mdate_ := null;
                s242_ := p240_;
                p240r_ := p240_;
             end if;

             comm_ :=
                   ' s180 = '
                || s180_
                || ' s181 = '
                || s181_
                || ' s240 = '
                || p240_
                || ' mdate='''
                || TO_CHAR (mdate_, 'dd/mm/yyyy')
                || ''' '
                || ' (r240 = '
                || p240r_
                || ') ';

             if exist_trans = 1 then
                exist_trans_acc := f_exist_trans_acc (acc_, datn_);
             else
                exist_trans_acc := 0;
             end if;

             if exist_cp = 1 and
                SUBSTR (nls_, 1, 4) IN ('3110','3111','3112','3113','3114',
                        '3210','3211','3212','3213','3214','3315')
             then
                exist_cp_acc := f_exist_cp_acc (acc_, dat_);
             else
                exist_cp_acc := 0;
             end if;

             IF fa7p_ = 0                                     -- �����./����. ����
             THEN
                IF mdate_ IS NOT NULL OR p240_ = '0'
                THEN
                   p240_ := p240r_;
                END IF;
             ELSE                                        -- ���� ������. ���������
                IF p240_ = '0'
                THEN
                   p240_ := p240r_;
                END IF;
             END IF;

             if instr(nbsdiscont_, nbs_) > 0 or
                instr(nbspremiy_, nbs_) > 0 or
                tips_ = 'SNA'
             then
--                if tips_ = 'SNA' then
--                   r012_ := '4';
--                elsif nbs_ not in ('2706','3666','1626')  then
--                   r012_ := 'D';
--                else NULL;
--                end if;

                if nd_ is null and nls_ like '3%'  then

                begin
                   select cp_ref   into nd_
                     from cp_accounts
                    where cp_acc = acc_;
                exception
                   when others  then NULL;
                end;

                end if;

                insert into OTCN_FA7_REZ2(ND, ACC, PR, SUM)
                values(nd_, acc_, (case when instr(nbsdiscont_, nbs_) > 0 then 1
                                        when instr(nbspremiy_, nbs_) > 0 then 2
                                        else 3 end), se_);
             end if;

             -- ����� ����������� ���������
             IF fa7p_ > 0 and tips_ <> 'SNO'
             THEN
                BEGIN
                   IF ap_ = 1
                   THEN
                      if nd_ is not null then  -- �������
                          freq_:=freq#_;
                          s_:=s#_;
                          apl_dat_:=apl_dat#_;

                          -- ���� � ���. ����������: �������� �� �������� ����������� ���
                          -- ��������� ��������� ����� � %%-�
                          -- �������� ������ ���� ������� %%-�
                          BEGIN
                             SELECT TO_DATE (TRIM (txt), 'dd/mm/yyyy')
                               INTO apl_dat_
                               FROM nd_txt
                              WHERE nd = nd_ AND tag = 'DATSN';
                          EXCEPTION
                             WHEN NO_DATA_FOUND
                             THEN
                                NULL;
                          END;

                          -- �������� ����� ������� %%-�
                          BEGIN
                             SELECT TO_NUMBER (TRIM (txt))
                               INTO s_
                               FROM nd_txt
                              WHERE nd = nd_ AND tag = 'DAYSN';
                          EXCEPTION
                             WHEN NO_DATA_FOUND
                             THEN
                                NULL;
                          END;
                      else
                          freq_ := null;
                          s_ := null;
                          apl_dat_ := null;
                      end if;
                   ELSE
                      -- ��������
                      declare
                         dapp_ date;
                      BEGIN
                         select dapp
                         into dapp_
                         from otcn_fa7_dapp
                         where acc = acc_;

                         -- �������� ��
                         SELECT NVL (c.freq, v.freq_k), 0, c.dat_begin
                           INTO freq_, s_, apl_dat_
                           FROM int_accn i, dpt_deposit c, dpt_vidd v
                          WHERE i.acra = acc_
                            AND i.ID = 1
                            AND i.acc = c.acc
                            AND c.vidd = v.vidd
                            and nvl(i.ACR_DAT, i.apl_DAT) >= dapp_
                            and i.ACR_DAT = (select min(ACR_DAT)
                                               from int_accn
                                               where acra=acc_ and
                                                     nvl(ACR_DAT, apl_DAT) >= dapp_);

                         comm_ := comm_ || ' (�� ��)';
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            -- 20.11.2006 �� ����� ���-��� �� �����. ������ ��
                            IF 1<>1 --300120 IN (mfo_, mfou_)
                            THEN
                               RAISE NO_DATA_FOUND;
                            ELSE
                               -- �������� ��
                               SELECT NVL (c.freqv, v.freq_v), 0, c.dat_begin
                                 INTO freq_, s_, apl_dat_
                                 FROM int_accn i, dpu_deal c, dpu_vidd v
                                WHERE i.acra = acc_
                                  AND i.ID = 1
                                  AND i.acc = c.acc
                                  AND c.vidd = v.vidd
                                  and nvl(i.ACR_DAT, i.apl_DAT) >= dapp_
                                  and i.ACR_DAT = (select min(ACR_DAT)
                                                   from int_accn
                                                   where acra=acc_ and
                                                         nvl(ACR_DAT, apl_DAT) >= dapp_)
                                  and rownum = 1;
                            END IF;

                            comm_ := comm_ || ' (�� ��)';
                      END;
                   END IF;

                   comm_ := comm_ || ' freq=' || freq_ || ' s=' || s_;
                   comm_ :=
                         comm_
                      || ' apl_dat='''
                      || TO_CHAR (apl_dat_, 'dd/mm/yyyy')
                      || '''';
                   comm_ :=
                       comm_ || ' daos=''' || TO_CHAR (daos_, 'dd/mm/yyyy')
                       || '''';

                   IF freq_ IN (2, 5)
                   THEN
                      add_ := 1;
                   ELSIF freq_ = 7
                   THEN
                      add_ := 3;
                   ELSIF freq_ = 180
                   THEN
                      add_ := 6;
                   ELSIF freq_ = 360
                   THEN
                      add_ := 12;
                   ELSE
                      add_ := 0;
                   END IF;

                   IF mdate_ <= datn_
                   THEN
                      add_ := 0;
                   END IF;

                   comm_ := comm_ || ' add=' || TO_CHAR (add_);

                   IF freq_ IS NULL OR freq_ = 400  --  �� ����� ��� � ����� �����
                   THEN
                      mdater_ := mdate_;
                   ELSIF freq_ = 1                                   --  ���������
                   THEN
                      mdater_ := datn_;
                   ELSE
                      IF s_ <> 0
                      THEN                                -- ����� ������� ������
                         IF     apl_dat_ IS NOT NULL
                            AND apl_dat_ >= datn_
                            AND apl_dat_ <= mdate_
                         THEN                      -- ������ ���� ��� �� ���������
                            mdater_ := apl_dat_;
                         ELSE    -- ������ ���� ��� ������ ��� ������ ���� �������
                            BEGIN
                               IF apl_dat_ IS NOT NULL AND apl_dat_ < datn_
                               THEN
                                  IF TO_NUMBER (TO_CHAR (LAST_DAY (apl_dat_),
                                                         'dd')
                                               ) < TO_NUMBER (s_)
                                  THEN
                                     s_ := TO_CHAR (LAST_DAY (apl_dat_), 'dd');
                                  END IF;

                                  mdater_ :=
                                     TO_DATE (TRIM (   LPAD (TRIM (TO_CHAR (s_)),
                                                             2,
                                                             '0'
                                                            )
                                                    || TO_CHAR (apl_dat_,
                                                                'mmyyyy')
                                                   ),
                                              'ddmmyyyy'
                                             );
                               ELSE                       -- ������ ���� �� ������
                                  IF TO_NUMBER (TO_CHAR (LAST_DAY (daos_), 'dd')) <
                                                                   TO_NUMBER (s_)
                                  THEN
                                     s_ := TO_CHAR (LAST_DAY (daos_), 'dd');
                                  END IF;

                                  mdater_ :=
                                     TO_DATE (TRIM (   LPAD (TRIM (TO_CHAR (s_)),
                                                             2,
                                                             '0'
                                                            )
                                                    || TO_CHAR (daos_, 'mmyyyy')
                                                   ),
                                              'ddmmyyyy'
                                             );
                               END IF;
                            EXCEPTION
                               WHEN OTHERS
                               THEN
                                  raise_application_error
                                               (-20001,
                                                   SQLERRM
                                                || ' ('''
                                                || TRIM (   LPAD
                                                                (TRIM (TO_CHAR (s_)
                                                                      ),
                                                                 2,
                                                                 '0'
                                                                )
                                                         || TO_CHAR (apl_dat_,
                                                                     'mmyyyy'
                                                                    )
                                                        )
                                                || '''), acc='
                                                || TO_CHAR (acc_)
                                               );
                            END;
                         END IF;
                      ELSE                              -- ����� ������� �� ������
                         IF apl_dat_ IS NOT NULL
                         THEN                               -- ������ ���� ������
                            mdater_ := apl_dat_;
                         ELSE
                            mdater_ := daos_;
                         END IF;
                      END IF;

                      IF mdater_ < datn_ AND add_ <> 0 and
                         (dathb_ is null or
                          dathb_ is not null and mdater_ < dathb_)
                      THEN
                         LOOP
                            mdater_ := ADD_MONTHS (mdater_, add_);

                            IF mdater_ >= datn_
                            THEN
                               EXIT;
                            elsif dathb_ is not null and
                                  dathe_ is not null and
                                  mdater_ between dathb_ and dathe_
                            THEN
                               mdater_ := dathe_ + 1;
                               EXIT;
                            END IF;
                         END LOOP;
                      END IF;
                   END IF;

                   IF mdater_ IS NOT NULL and mdate_ IS NOT NULL AND
                      mdater_ < mdate_ AND
                      mdater_ >= datn_
                      OR
                      mdater_ IS NOT NULL AND mdate_ IS NULL
                   THEN
                      mdate_ := mdater_;
                   END IF;

                   if mfou_ = 300120 and codc_ in (3, 4) and freq_ = 5 then
                      mdate_ := Dat_Next_U (mdate_, 5);
                   end if;

                   comm_ :=
                         comm_
                      || ' mdateR_='''
                      || TO_CHAR (mdate_, 'dd/mm/yyyy')
                      || '''';

                   ret_ :=
                      fs_180_242 (SUBSTR (nls_, 1, 4),
                                  -1,
                                  datn_,
                                  mdate_,
                                  daos_,
                                  x_,
                                  s242_,
                                  dathb_,
                                  dathe_
                                 );

                   IF NVL (s181_, '0') <> '0'
                   THEN
                      x_ := s181_;
                   END IF;

                   IF NVL (s242_, '0') = '0'
                   THEN
                      s242_ := p240_;
                   END IF;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                     if p240_ <> '0' then
                        s242_ := p240_;
                     else
                        begin
                            select nvl(trim(s240), '0')
                            into  s242_
                            from w4_acc a, specparam s
                            where a.acc_2208 = acc_ and
                                 a.acc_ovr = s.acc and
                                 rownum = 1;

                            comm_ := comm_ || ' (���� �� ������ BPK)';
                        exception
                            when no_data_found then
                                  comm_ := comm_ || ' (���� �� �� ������)';

                                  IF datn_ < zm_date_
                                  THEN
                                     s242_ := NVL (fs242 (NULL, NULL, p240_), '0');
                                  ELSE
                                     s242_ := p240_;
                                  END IF;
                        end;
                    end if;
                END;

                IF x_ NOT IN ('1', '2')
                THEN
                   x_ := fs181 (acc_, dat_, s180_);

                   IF NVL (x_, '0') = '0'
                   THEN
                      x_ := '1';
                   END IF;
                END IF;

                if x_ = '1' and s242_ > 'B' and s242_ <> 'Z' and
                   mdate_ is not null and nkd_ like '%���%'
                then
                   s242_ := 'B';
                end if;

             if s242_ !='Z'  then s190_ :='0';  end if;
             if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

    ------- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                IF    pr_ = '1' AND nbs_ LIKE '2%'
                   OR     300120 IN (mfo_, mfou_)
                      AND pr_ = '1'
                   OR     300120 NOT IN (mfo_, mfou_)
                      AND nbs_ IN ('1408','1418','1428','1438','1448','1508','1518','1528',
                            '3108','3118','3570','3578')
                      and not (mfo_ = 300465 and rnk_ = 907973 and nbs_ in ('1418', '3118'))
                      and not (nbs_ in ('1408', '1418', '1428') and nvl(r011_, '0') = 'D') 
                      and not (nbs_ in ('3118') and nvl(r011_, '0') in ('2', 'A')) 
                THEN
                   IF     dat_ >= TO_DATE ('01112008', 'ddmmyyyy')
                      AND nbs_ IN ('1518', '1528')
                      --and nvl(trim(r013_),'0') = '0'
                   THEN
                      declare
                         dapp_ date;
                      BEGIN
                         select dapp
                         into dapp_
                         from otcn_fa7_dapp
                         where acc = acc_;

                         SELECT a.nbs
                           INTO nbs1_
                           FROM accounts a, int_accn i
                          WHERE i.acra = acc_
                            AND i.acc = a.acc
                            AND i.ID = 0
                            AND a.daos = daos_
                            and nvl(i.ACR_DAT, i.apl_DAT) >= dapp_
                            and i.ACR_DAT = (select min(ACR_DAT)
                                             from int_accn
                                             where acra=acc_ and
                                                   nvl(ACR_DAT, apl_DAT) >= dapp_);

                         IF     nbs_ = '1518'
                            AND nbs1_ IN ('1510', '1512')
                            AND r013_ NOT IN ('5', '7')
                         THEN
                            r013_ := '5';
                         END IF;

                         IF     nbs_ = '1518'
                            AND nbs1_ NOT IN ('1510', '1512')
                            AND r013_ NOT IN ('6', '8')
                         THEN
                            r013_ := '6';
                         END IF;

                         IF     nbs_ = '1528'
                            AND nbs1_ = '1521'
                            AND r013_ NOT IN ('5', '7')
                         THEN
                            r013_ := '5';
                         END IF;

                         IF     nbs_ = '1528'
                            AND nbs1_ <> '1521'
                            AND r013_ NOT IN ('6', '8')
                         THEN
                            r013_ := '6';
                         END IF;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            NULL;
                      END;
                   END IF;

                   comm_ := comm_ || ' R013=' || r013_;

                   IF  se_ < 0
                   THEN
                      IF se_ <> 0
                      THEN
                         p_analiz_r013_calc ((case when pmode_ = 2 then 2 else 1 end),
                                            mfo_,
                                            mfou_,
                                            dat_,
                                            acc_,
                                            tips_,
                                            nbs_,
                                            kv_,
                                            r013_,
                                            se_,
                                            nd_,
                                            freq_,
                                            --------
                                            o_r013_1,
                                            o_se_1,
                                            o_comm_1,
                                            --------
                                            o_r013_2,
                                            o_se_2,
                                            o_comm_2
                                           );

                         -- �� 30 ����
                         IF o_se_1 <> 0
                         THEN
                            dk_ := iif_n (o_se_1, 0, '1', '2', '2');

                               pp_doda;

                               if datn_ < zm_date2_ then
                                 kodp_ :=
                                       dk_
                                    || nbs_
                                    || o_r013_1
                                    || x_
                                    || s242_
                                    || r031_
                                    || rez_
                                    || r012_;
                               elsif datn_ < zm_date3_ then
                                 kodp_ :=
                                       dk_
                                    || nbs_
                                    || o_r013_1
                                    || x_
                                    || s242_
                                    || rez_
                                    || r012_
                                    || r030_;
                               else
                                 kodp_ :=
                                       dk_
                                    || nbs_
                                    || r011_
                                    || o_r013_1
                                    || x_
                                    || s242_
                                    || rez_
                                    || s190_
                                    || r030_;
                               end if;

                            p_add_rec(s_rnbu_record.NEXTVAL, userid_,
                                        nls_, kv_, data_, kodp_,
                                        TO_CHAR (ABS (o_se_1)), acc_,
                                        rnk_, isp_, mdate_,
                                        SUBSTR (tobo_ || '  ' || comm_ || o_comm_1, 1, 200),
                                        nd_, nbuc_, tobo_);
                         END IF;

                         -- ����� 30 ����
                         IF o_se_2 <> 0
                         THEN
                            dk_ := iif_n (o_se_2, 0, '1', '2', '2');

                               pp_doda;

                               if datn_ < zm_date2_ then
                                 kodp_ :=
                                       dk_
                                    || nbs_
                                    || o_r013_2
                                    || x_
                                    || s242_
                                    || r031_
                                    || rez_
                                    || r012_;
                               elsif  datn_ < zm_date3_ then
                                 kodp_ :=
                                       dk_
                                    || nbs_
                                    || o_r013_2
                                    || x_
                                    || s242_
                                    || rez_
                                    || r012_
                                    || r030_;
                               else
                                 kodp_ :=
                                       dk_
                                    || nbs_
                                    || r011_
                                    || o_r013_2
                                    || x_
                                    || s242_
                                    || rez_
                                    || s190_
                                    || r030_;
                               end if;

                            p_add_rec(s_rnbu_record.NEXTVAL, userid_,
                                        nls_, kv_, data_, kodp_,
                                        TO_CHAR (ABS (o_se_2)), acc_,
                                        rnk_, isp_, mdate_,
                                        SUBSTR (tobo_ || '  ' || comm_ || o_comm_1, 1, 200),
                                        nd_, nbuc_, tobo_);
                         END IF;

                         se_ := 0;
                      END IF;
                   END IF;
                END IF;

                dk_ := iif_n (se_, 0, '1', '2', '2');

                   pp_doda;

                   if datn_ < zm_date2_ then
                     kodp_ :=
                           dk_
                        || nbs_
                        || r013_
                        || x_
                        || s242_
                        || r031_
                        || rez_
                        || r012_;
                   elsif datn_ < zm_date3_ then
                     kodp_ :=
                           dk_
                        || nbs_
                        || r013_
                        || x_
                        || s242_
                        || rez_
                        || r012_
                        || r030_;
                   else
                     kodp_ :=
                           dk_
                        || nbs_
                        || r011_
                        || r013_
                        || x_
                        || s242_
                        || rez_
                        || s190_
                        || r030_;
                   end if;

                IF se_ <> 0
                THEN
                   p_add_rec(s_rnbu_record.NEXTVAL, userid_, nls_, kv_,
                                data_, kodp_, TO_CHAR (ABS (se_)), acc_, rnk_,
                                isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                               );
                END IF;
             ELSE
                IF     SUBSTR (nls_, 1, 4) IN
                          ('1410', '1413', '1414', '1418', '2701', '3112', '3113', '3114', '3660', '3648')
                   AND exist_sbb = 1
                THEN
                   BEGIN
                      EXECUTE IMMEDIATE 'begin cp_a7(:pdat_,9); end;'
                                  USING pdat_;
                   EXCEPTION
                      WHEN OTHERS
                      THEN
                         null;
                   END;

                   exist_sbb_acc := f_exist_sbb_acc (acc_);
                ELSE
                   exist_sbb_acc := 0;
                END IF;
             END IF;


             exist_cclim_acc := 0;
             
             if substr(nls_,1,4) in ('1623','1624','2701','3660')  then
                exist_cclim_acc := f_exist_cclim_acc( acc_ );
             end if;

             -- �� ������� � �� ����� ����������� ��������� ���������� ������
             IF tips_ NOT IN ('SS', 'SP', 'SL')
                   and not (tips_ = 'DEP' and nls_ like '132%')
                   AND fa7p_ = 0
                   AND exist_sbb_acc =0 
                   and exist_cclim_acc =0
                   and exist_cp_acc =0
                OR                                -- ������� �����
                       pmode_ = 1
                   AND tips_ IN ('SS', 'SP', 'SL')
                   AND NOT tp_graf
                   AND fa7p_ = 0
                OR
                   pmode_  in (0, 2) AND
                   tips_ IN ('SS', 'SP', 'SL') and
                   exist_trans_acc = 0 and
                   NOT tp_graf
             THEN
                IF datn_ < zm_date_
                THEN
                   s242_ := NVL (fs242 (NULL, NULL, p240_), '0');
                ELSE
                   s242_ := p240_;
                END IF;

                IF tips_ = 'NL8'
                THEN
                   SELECT COUNT (*)
                     INTO fa7k_
                     FROM accounts
                    WHERE accc = acc_;
                END IF;

                IF tips_ = 'NL8' AND fa7k_ > 0
                THEN
                   FOR k IN (SELECT a.acc acc, a.nls nls, a.kv kv, s.dapp fdat,
                                    s.nbs nbs, s.tip tip,
                                    DECODE (s.mdate,
                                            NULL, NVL (TRIM (p.s240), '0'),
                                            fs240 (datn_, a.acc, dathb_, dathe_, s.mdate, p.s240)
                                           ) s240,
                                    DECODE (TRIM (p.s180),
                                            NULL, fs180 (a.acc),
                                            p.s180
                                           ) s180,
                                    NVL (p.s181, '0') s181,
                                    NVL (p.r011, '0') r011, NVL (p.r013, '0') r013, l.r031 r031,
                                    s.mdate mdate,
                                    DECODE (pmode_, 2,
                                    decode(s.kv, 980, a.ost - a.dos96 + a.kos96,
                                                      a.ostq - a.dosq96 + a.kosq96),
                                    decode(s.kv, 980, a.ost, a.ostq)) ost,
                                    s.rnk rnk, s.isp isp, s.branch
                               FROM otcn_saldo a,
                                    accounts s,
                                    kl_r030 l,
                                    specparam p
                              WHERE s.accc = acc_
                                AND a.acc = s.acc
                                AND a.fdat = dat_
                                AND a.kv = TO_NUMBER (l.r030)
                                AND a.acc = p.acc(+)
                                AND a.ost <> 0)
                   LOOP
                      mdate_ := k.mdate;
                      x_ := k.s181;

                      IF     x_ <> '2'
                         AND k.s180 IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                      THEN
                         x_ := '2';
                      END IF;

                      IF     x_ <> '1'
                         AND (    k.s180 IS NOT NULL
                              AND k.s180 NOT IN
                                              ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                             )
                      THEN
                         x_ := '1';
                      END IF;

                      min_sum_ := 0;

                      BEGIN
                         SELECT gl.p_icurval (v.kv, a.min_sum, dat_)
                           INTO min_sum_
                           FROM dpu_deal a, dpu_vidd v
                          WHERE a.acc = k.acc
                            AND a.vidd = v.vidd
                            AND a.dpu_id IN (SELECT MAX (dpu_id)
                                               FROM dpu_deal
                                              WHERE acc = k.acc);
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            min_sum_ := 0;
                      END;

                      IF datn_ < zm_date_
                      THEN
                         s242_ := fs242 (NULL, NULL, k.s240);
                      ELSE
                         s242_ := k.s240;
                      END IF;


                      IF typ_ > 0 THEN
                         nbuc_ := NVL (F_Codobl_branch (k.branch, typ_), nbuc1_);
                      ELSE
                         nbuc_ := nbuc1_;
                      END IF;

                      se_ := k.ost;

                      dk_ := iif_n (se_, 0, '1', '2', '2');

                      IF x_ = '3'
                      THEN
                         x_ := '1';
                      END IF;

                      rnls_ := k.nls;

                      IF s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M')
                         AND x_ = '1'
                      THEN
                         x_ := '2';
                      END IF;

             if s242_ !='Z'  then s190_ :='0';  end if;
             if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                         pp_doda;

                      if datn_ < zm_date2_ then
                        kodp_ :=
                           dk_
                        || nbs_
                        || r013_
                        || x_
                        || s242_
                        || r031_
                        || rez_
                        || r012_;
                      elsif datn_ < zm_date3_ then
                        kodp_ :=
                           dk_
                        || nbs_
                        || r013_
                        || x_
                        || s242_
                        || rez_
                        || r012_
                        || r030_;
                      else
                        kodp_ :=
                           dk_
                        || nbs_
                        || r011_
                        || r013_
                        || x_
                        || s242_
                        || rez_
                        || s190_
                        || r030_;
                      end if;

                      IF se_ <> 0
                      THEN
                         -- ��������� 30.10.2008 ��� �������� �������
                         -- �� ���� ��������������� ������� i
                         -- �i����i ������� �� ������� �i��� �������������� �������
                         IF     dat_ >= TO_DATE ('31102008', 'ddmmyyyy')
                            AND min_sum_ <> 0
                            AND se_ - min_sum_ > 0
                         THEN
                            comm1_ :=
                                  comm_
                               || '���� ��������������� �������'
                               || TO_CHAR (min_sum_);

                            p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_,
                                         k.kv, k.fdat, kodp_,
                                         TO_CHAR (ABS (min_sum_)), k.acc, k.rnk,
                                         k.isp, mdate_, substr(tobo_ || '  ' || comm1_,1,200), nd_, nbuc_, tobo_
                                        );

                            se_ := se_ - min_sum_;

                            if datn_ < zm_date2_ then
                               kodp_ := SUBSTR (kodp_, 1, 7) || '1'|| SUBSTR (kodp_, 9, 2) || r012_;
                            elsif datn_ < zm_date3_ then
                               kodp_ := SUBSTR (kodp_, 1, 7) || '1'|| SUBSTR (kodp_, 9, 1) || r012_ || substr(kodp_, 11, 3);
                            else
                               kodp_ := SUBSTR (kodp_, 1, 8) || '1'|| SUBSTR (kodp_, 10);
                            end if;
                         END IF;

                         p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_,
                                      k.kv, k.fdat, kodp_, TO_CHAR (ABS (se_)),
                                      k.acc, k.rnk, k.isp, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                                     );
                      END IF;
                   END LOOP;
                ELSE
                   min_sum_ := 0;

                   BEGIN
                      -- �������� ��
                      IF mfo_ = 300465
                      THEN
                         SELECT gl.p_icurval (v.kv, v.min_summ * 100, dat_)
                           INTO min_sum_
                           FROM dpt_deposit c, dpt_vidd v
                          WHERE c.acc = acc_
                            AND c.vidd = v.vidd
                            AND v.vidd IN (272, 338)
                            AND ROWNUM = 1;
                      END IF;
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         BEGIN
                            SELECT gl.p_icurval (v.kv, a.min_sum, dat_)
                              INTO min_sum_
                              FROM dpu_deal a, dpu_vidd v
                             WHERE a.acc = acc_
                               AND a.vidd = v.vidd
                               AND a.dpu_id IN (SELECT MAX (dpu_id)
                                                  FROM dpu_deal
                                                 WHERE acc = acc_);
                         EXCEPTION
                            WHEN NO_DATA_FOUND
                            THEN
                               min_sum_ := 0;
                         END;
                   END;

                   IF nbs_ = '9129'
                   THEN

                      BEGIN
                         FOR i IN (SELECT   DECODE (TRIM (s.s240),
                                                    NULL, fs240 (datn_, a.acc, dathb_, dathe_, a.mdate, s.s240),
                                                    s.s240
                                                   ) s240,
                                            a.mdate, o.nd, o.datd2 mdate_acco,
                                            nvl(fostq(o.acco, dat_), 0) ostq
                                       FROM acc_over o, accounts a, specparam s
                                      WHERE o.acc_9129 = acc_
                                        AND o.acco = a.acc
                                        AND a.acc = s.acc(+)
                                   ORDER BY a.mdate DESC)
                         LOOP
                            x_ := '1';
                            nd_ := i.nd;
                            if i.ostq <0  then
                                mdate_ := i.mdate;
                                s242_ := i.s240;
                            else
                                mdate_ := i.mdate_acco;
                                s242_ := f_srok(pdat_,mdate_,2);
                            end if;
                            EXIT;
                         END LOOP;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            NULL;
                      END;

                      if r013_ = '1'  then
                         x_ := '1';
                         s242_ := '1';
                      end if;
                   END IF;

--   ����������� s240 ��� ������ 2924 �� ob22 (���������)
                   if mfo_ =322669  and nbs_ ='2924'  then

                     declare
                         ob22_ varchar2(2);
                     begin
                         sql_doda_ := 'select ob22 from specparam_int where acc = '||to_char(acc_);
                         execute immediate sql_doda_ into ob22_;

                         if ob22_ = '23'
                         then
                             s242_ := '3';
                         elsif ob22_ in ('07','08','09','10')
                         then
                             s242_ := '7';
                         else
                             s242_ := '1';
                         end if;
                     exception
                         when no_data_found then s242_ :='1';
                     end;
                     x_ :='1';

                   end if;

                   dk_ := iif_n (se_, 0, '1', '2', '2');

                   IF x_ = '3'
                   THEN
                      x_ := '1';
                   END IF;

                   rnls_ := nls_;

                   IF     x_ = '1'
                      AND (   s180_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                           OR s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M')
                          )
                   THEN
                      rnls_ := nls_;
                   END IF;

                   IF x_ = '2'
                      AND s180_ NOT IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                   THEN
                      rnls_ := nls_;
                   END IF;

                   IF     (x_ IS NULL OR x_ <> '2')
                      AND s180_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                   THEN
                      x_ := '2';
                   END IF;

                   IF     x_ = '0'
                      AND (   s180_ IS NULL
                           OR s180_ = '0'
                           OR s180_ NOT IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                          )
                   THEN
                      x_ := '1';
                   END IF;


                   IF s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M') AND x_ = '1'
                   THEN
                      x_ := '2';
                   END IF;

                   IF (nbs_ IN ('1819', '2900', '2902', '2903', '2909') or
                       nbs_ IN ('2600', '2605', '2608', '2620', '2625', '2650') and sn_ < 0)
                      AND (s242_ = '0' OR NVL (x_, '0') = '0' OR x_ = '2')
                   THEN
                      IF     (   ((300120 IN (mfo_, mfou_)) AND nbs_ LIKE '290%'
                                 )
                              OR 300120 IN (mfo_, mfou_) AND nbs_ = '2625'
                             )
                         AND x_ = '2'
                      THEN
                         NULL;                                -- ������ �� ������
                      ELSE
                         x_ := '1';

                         IF datn_ < zm_date_
                         THEN
                            s242_ := '5';
                         ELSE
                            s242_ := '1';
                         END IF;
                      END IF;
                   END IF;

--                   IF nbs_ = '2600' AND r013_ = '0' and sn_ < 0
--                   THEN
--                      r013_ := '9';
--                   END IF;

                   IF nbs_ = '2620' AND r013_ = '0' and sn_ < 0
                   THEN
                      r013_ := '9';
                   END IF;

                   IF nbs_ = '2903' AND r013_ not in ('1','9')
                   THEN
                      r013_ := '1';
                   END IF;

                   pp_doda;

                   if ((substr(nls_,1,4) in ('1410','1420','1430','1435','1436','1437','1440','1446','1447')) or
                        (substr(nls_,1,4) in ('1415','1416','1417','1426','1427') and r013_ not in ('3','9'))) or
                       ((substr(nls_,1,4) in ('1412','1413','1414','1422','1423','1424')) or 
                         (substr(nls_,1,4) in ('1415','1416','1417','1426','1427') and r013_ in ('3','9'))) 
                         and s242_ <= '5' 
                   then
                        select nvl(sum(sum_zal), 0)
                        into sum_zal
                          from otcn_f42_cp
                          where fdat = dat_
                            and substr(nls,4,1)<>'8'
                            and acc = acc_;
                   else
                       sum_zal := 0;
                   end if;
                   
                   if datn_ < zm_date2_ then
                      kodp_ :=
                             dk_ || nbs_ || r013_ || x_ || s242_ || r031_ || rez_ || r012_;
                   elsif datn_ < zm_date3_ then
                      kodp_ :=
                             dk_ || nbs_ || r013_ || x_ || s242_ || rez_ || r012_ || r030_ ;
                   else
             if s242_ !='Z'  then s190_ :='0';  end if;
             if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                      kodp_ :=
                             dk_ || nbs_ || r011_||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                             
                      se_ := TO_CHAR (ABS (se_ - sum_zal));
                   end if;


                   IF (nbs_ = '1500' AND se_ > 0)
                      OR (    nbs_ NOT IN ('1500')
                          AND se_ <> 0
                         )
                   THEN
                      -- ��������� 30.10.2008 ��� �������� �������
                      -- �� ���� ��������������� ������� i
                      -- �i����i ������� �� ������� �i��� �������������� �������
                      IF     dat_ >= TO_DATE ('30102008', 'ddmmyyyy')
                         AND min_sum_ <> 0
                         AND se_ - min_sum_ > 0
                      THEN
                         comm1_ :=
                               comm_
                            || '���� ��������������� �������'
                            || TO_CHAR (min_sum_);

                         p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_, kv_,
                                      data_, kodp_, TO_CHAR (ABS (min_sum_)),
                                      acc_, rnk_, isp_, mdate_, substr(tobo_ || '  ' || comm1_,1,200), nd_, nbuc_, tobo_
                                     );

                         se_ := se_ - min_sum_;

                         if datn_ < zm_date2_ then
                            kodp_ :=
                                SUBSTR (kodp_, 1, 7) || '1'
                                || SUBSTR (kodp_, 9, 2) || r012_;
                         elsif datn_ < zm_date3_ then
                            kodp_ :=
                                SUBSTR (kodp_, 1, 7) || '1'
                                || SUBSTR (kodp_, 9, 1) || r012_||SUBSTR (kodp_, 11, 3);
                         else
                            kodp_ :=
                                SUBSTR (kodp_, 1, 8) || '1'
                                || SUBSTR (kodp_, 10);
                         end if;
                      END IF;

                      p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_, kv_,
                                   data_, kodp_, TO_CHAR (ABS (se_)), acc_, rnk_,
                                   isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                                  );
                      
                       if sum_zal <> 0 then
                           kodp_ :=
                             dk_ || nbs_ || '2' ||r013_ || x_ || s242_ ||rez_ || s190_ || r030_ ;
                             
                          p_add_rec (s_rnbu_record.NEXTVAL, userid_, rnls_, kv_,
                                       data_, kodp_, TO_CHAR (ABS (sum_zal)), acc_, rnk_,
                                       isp_, mdate_, substr(tobo_ || '  ' || comm_,1,200), nd_, nbuc_, tobo_
                                      );
                       end if;
                   END IF;
                END IF;
             END IF;

             IF pmode_ = 1
                   AND tips_ IN ('SS', 'SP', 'SL')
                   AND tp_graf      -- � ��������� �� �������
                   AND type_ = 1
                OR                            -- � ��������� �� ������� OTC_LIM_SB
                       tips_ NOT IN ('SS', 'SP', 'SL')
                   AND SUBSTR (nls_, 1, 4) IN
                          ('1410', '1413', '1414', '1418', '1623', '1624', '2701',
                           '3112', '3113', '3114', '3660', '3648')
                   AND ( exist_sbb_acc > 0 or exist_cclim_acc >0 )
                OR     pmode_ in (0, 2)
                   AND tips_ IN ('SS', 'SP', 'SL')
                   AND (exist_trans_acc > 0 or tp_graf)
                or
                    SUBSTR (nls_, 1, 4) IN ('1410','1412','1413','1414','1420','1422','1423',
                            '1424','1430','3110','3111','3112','3113','3114',
                            '3210','3211','3212','3213','3214','3315') and
                    exist_cp_acc > 0
                OR
                   fa7p_ > 0 and tips_ = 'SNO'
                OR
                   tips_ = 'DEP' and nls_ like '132%'
             THEN
                -- ������� ���. �������
                -- flag 1
                IF exist_fakt = 0 then
                   fl_mode_ := '0';
                else
                   fl_mode_ := '1';
                end if;

                -- flag 2
                if exist_sbb_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 3
                if exist_trans_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 4
                if exist_cp_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 5
                if not (fa7p_ > 0 and tips_ = 'SNO' ) or
                   exist_sno_gr = 1
                then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 6
                if not (tips_ = 'DEP' and nls_ like '132%') then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 7
                if not (fa7p_ > 0 and tips_ = 'SNO' and
                        exist_sno_gr = 1)
                then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                -- flag 8
                if exist_cclim_acc = 0 then
                   fl_mode_ := trim(fl_mode_)||'0';
                else
                   fl_mode_ := trim(fl_mode_)||'1';
                end if;

                IF fa7p_ > 0 and se_ < 0 and
                   not (substr(nbs_, 1, 3) in ('141','142','143','311','321''331') and
                        tips_ = 'SNO')
                THEN
                   p_analiz_r013_calc ((case when pmode_ = 2 then 2 else 1 end),
                                      mfo_,
                                      mfou_,
                                      dat_,
                                      acc_,
                                      tips_,
                                      nbs_,
                                      kv_,
                                      r013_,
                                      se_,
                                      nd_,
                                      null,
                                      --------
                                      o_r013_1,
                                      o_se_1,
                                      o_comm_1,
                                      --------
                                      o_r013_2,
                                      o_se_2,
                                      o_comm_2
                                     );

                   o_se_1z := abs(o_se_1);
                   o_se_2z := abs(o_se_2);
                else
                   o_se_1 := 0;
                   o_se_2 := 0;

                   o_se_1z := 0;
                   o_se_2z := 0;
                END IF;

                znap_ := null;
                se1_ := 0;

                FOR i IN (SELECT   s240, s242, ldate, nd,
                                   comm || DECODE (nd, null, '', ' (���=' || TO_CHAR (nd) || ')') comm_,
                                   SUM (ost) ost
                              FROM TABLE (CAST (f_cck_otcn (dat_,
                                                            acc_,
                                                            mdate_,
                                                            sn_,
                                                            fl_mode_,
                                                            datn_, 2,
                                                            dathb_, dathe_, nd_
                                                           ) AS tbl_240
                                               )
                                         )
                          GROUP BY s240,
                                   s242,
                                   ldate,
                                   nd,
                                   comm || DECODE (nd, null, '', ' (���=' || TO_CHAR (nd) || ')')
                          )
                LOOP
                   s240_ := i.s240;
                   s242_ := i.s242;
                   se_ := i.ost;
                   mdate_ := i.ldate;

                   if i.nd is not null then
                      nd_ := i.nd;
                   end if;

                   commb_ := substr(comm_ || TRIM (i.comm_),1,200);

                   IF datn_ < zm_date_
                   THEN
                      IF NVL (s242_, '0') = '0' AND p240_ <> '0'
                      THEN
                         s242_ := NVL (fs242 (NULL, NULL, p240_), '0');
                      END IF;
                   ELSE
                      s242_ := i.s240;

                      IF NVL (s240_, '0') = '0' AND p240_ <> '0'
                      THEN
                         s242_ := p240_;
                      END IF;
                   END IF;

                   dk_ := iif_n (se_, 0, '1', '2', '2');

                   IF x_ = '3'
                   THEN
                      x_ := '1';
                   END IF;

                   IF     x_ = '1'
                      AND (   s180_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                           OR s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M')
                          )
                   THEN
                      x_ := '2';
                      rnls_ := nls_;
                   END IF;

                   IF x_ = '2'
                      AND s180_ NOT IN ('9', 'C', 'D', 'E', 'F', 'G', 'H')
                   THEN
                      x_ := '1';
                      rnls_ := nls_;
                   END IF;

                   IF x_ NOT IN ('1', '2')
                   THEN
                      x_ := fs181 (acc_, dat_, s180_);

                      IF NVL (x_, '0') = '0'
                      THEN
                         x_ := '1';
                      END IF;
                   END IF;

                   IF s242_ IN ('9', 'C', 'D', 'E', 'F', 'G', 'H','K','L','M') AND x_ = '1'
                   THEN
                      x_ := '2';
                   END IF;

                   rnls_ := nls_;

                   IF (nbs_ IN ('1819', '2601', '2900', '2902', '2903', '2909') or
                       nbs_ IN ('2600', '2605', '2608', '2620', '2625', '2650') and sn_ < 0)
                      AND (s242_ = '0' OR x_ IS NULL OR x_ = '0' OR x_ = '2')
                   THEN
                      IF     (   (    (mfo_ = 322498 OR 300120 IN (mfo_, mfou_))
                                  AND nbs_ LIKE '290%'
                                 )
                              OR 300120 IN (mfo_, mfou_) AND nbs_ = '2625'
                             )
                         AND x_ = '2'
                      THEN
                         NULL;                                -- ������ �� ������
                      ELSE
                         x_ := '1';

                         IF datn_ < zm_date_
                         THEN
                            s242_ := '5';
                         ELSE
                            s242_ := '1';
                         END IF;
                      END IF;
                   END IF;

--                   IF nbs_ IN ('2600', '2620') AND r013_ = '0' and sn_ < 0
--                   THEN
--                      r013_ := '9';
--                   END IF;

      /*             IF     nbs_ IN ('2610', '2615')
                     AND (   r013_ IS NULL
                          OR r013_ = '0'
                          OR r013_ NOT IN ('1', '9')
                          OR mdate_ IS NOT NULL
                         )
                   THEN
                      IF mdate_ IS NULL OR mdate_ > dat_
                      THEN
                        r013_ := '9';
                      END IF;

                      IF mdate_ IS NOT NULL AND mdate_ <= dat_
                      THEN
                        r013_ := '1';
                      END IF;
                   END IF;
      */
                      pp_doda;

                      if datn_ < zm_date2_ then
                         kodp_ :=
                                 dk_ || nbs_ || r013_ || x_ || s242_ || r031_ || rez_ || r012_;
                      elsif datn_ < zm_date3_ then
                         kodp_ :=
                                 dk_ || nbs_ || r013_ || x_ || s242_ || rez_ || r012_ || r030_;
                      else
             if s242_ !='Z'  then s190_ :='0';  end if;
             if s242_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                         kodp_ :=
                                 dk_ || nbs_ || r011_||r013_ || x_ || s242_ || rez_ || s190_ || r030_;
                      end if;

                   znap_ := to_char (abs (se_));

                   commb_ :=
                         iif_n (LENGTH (commb_), 200, '', '', '!')
                      || SUBSTR (commb_, 1, 198);

                   IF (nbs_ = '1500' AND se_ > 0)
                      OR (    nbs_ NOT IN ('1500')
                          AND se_ <> 0
                         )
                   THEN
                      p_add_rec (s_rnbu_record.nextval, userid_, rnls_, kv_,
                                   data_, kodp_, znap_, acc_,
                                   rnk_, isp_, mdate_, substr(tobo_ || '  ' || commb_,1,200), nd_, nbuc_, tobo_
                                  );

                     --  ������� ������ ��� ����� ������� ��������
                     --          ��� ����������� ���������/��������� ������ ���� � _REZ1
                      if (tips_ = 'SS' and extract( day from sdate_) >1 and
                          trunc(sdate_,'mm') = trunc(pdat_,'mm') )
                                or
                          --  ��� ����������� ��������� �� ���� ���������
                          exist_cclim_acc >0  and
                          substr(nls_,1,4) in ('1623','1624','2701','3660')
                      then

                          insert into OTCN_FA7_REZ1
                                 ( ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
                          values (nd_, acc_, rnls_, kv_, kodp_, abs(se_), abs(se_), 0, 0);

                      end if;

                   END IF;
                END LOOP;

                if fa7p_ > 0 and
                   not (substr(nbs_, 1, 3) in ('141','142','143','311','321','331') and
                        tips_ = 'SNO')
                then
                   if o_se_1 <> 0 or o_se_2 <> 0 then
                      l_rec_t8.Extend;

                      l_rec_t8(l_rec_t8.last).acc_ := acc_;
                      l_rec_t8(l_rec_t8.last).r013_1 := o_r013_1;
                      l_rec_t8(l_rec_t8.last).ost_1 := o_se_1;
                      l_rec_t8(l_rec_t8.last).r013_2 := o_r013_2;
                      l_rec_t8(l_rec_t8.last).ost_2 := o_se_2;
                   end if;
                end if;
             END IF;
          END IF;
      end loop;

      l_rec_t.delete;
   END LOOP;

   CLOSE saldo;

   FORALL i IN 1 .. l_rnbu_trace.COUNT
       insert /*+ append */  into rnbu_trace values l_rnbu_trace(i);
   commit;

   znap_ := null;
   se1_ := 0;

   for i in 1..l_rec_t8.count loop
      acc_      := l_rec_t8(i).acc_;
      o_r013_1  := l_rec_t8(i).r013_1;
      o_se_1    := l_rec_t8(i).ost_1;
      o_r013_2  := l_rec_t8(i).r013_2;
      o_se_2    := l_rec_t8(i).ost_2;

      o_se_1z := abs(o_se_1);
      o_se_2z := abs(o_se_2);

      if o_se_1 <> 0 and o_se_2 <> 0 then
          for k in (select rowid, kodp, znap, comm, substr(kodp,7,1) r013
                     from rnbu_trace
                     where acc = acc_
                     order by recid)
          loop
              se1_ := 0;

              if o_se_1z <> 0 and k.r013 <> o_r013_1 then
                  if abs(o_se_1z) <= to_number(k.znap) then
                     znap_ := to_char(o_se_1z);
                     se1_ := to_number(k.znap) - o_se_1z;
                     o_se_1z := 0;
                     o_se_2z := o_se_2z - se1_;

                     insert into rnbu_trace
                     select null RECID, USERID, NLS, KV, ODATE,
                        substr(kodp,1,6)||o_r013_2||substr(kodp,8), to_char(se1_), NBUC,
                        ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
                     from rnbu_trace
                     where rowid = k.rowid;

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_1||substr(kodp,8),
                          znap = znap_
                      where rowid = k.rowid;
                  else
                     znap_ := k.znap;
                     o_se_1z := o_se_1z - to_number(k.znap);

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_1||substr(kodp,8)
                      where rowid = k.rowid;
                  end if;
              end if;

              if o_se_2z <> 0 and k.r013 <> o_r013_2 and se1_ = 0 then
                  if abs(o_se_2z) <= to_number(k.znap) then
                     znap_ := to_char(o_se_2z);
                     se1_ := to_number(k.znap) - o_se_2z;
                     o_se_2z := 0;

                     insert into rnbu_trace
                     select null RECID, USERID, NLS, KV, ODATE,
                        kodp, to_char(se1_), NBUC,
                        ISP, RNK, ACC, REF, COMM, ND, MDATE, TOBO
                     from rnbu_trace
                     where rowid = k.rowid;

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_2||substr(kodp,8),
                          znap = znap_
                      where rowid = k.rowid;
                  else
                     znap_ := k.znap;
                     o_se_2z := o_se_2z - to_number(k.znap);

                     update rnbu_trace
                      set kodp = substr(kodp,1,6)||o_r013_2||substr(kodp,8)
                      where rowid = k.rowid;
                  end if;
              end if;

              exit when o_se_1z = 0 and o_se_2z = 0;
          end loop;
      else
          r013_ := (case when o_se_1 <> 0 then o_r013_1
                         when o_se_2 <> 0 then o_r013_2
                         else r013_
                    end);

          update rnbu_trace
          set kodp = substr(kodp,1,6)||r013_||substr(kodp,8)
          where acc = acc_;
      end if;
   end loop;

   logger.info ('P_FA7_NN: End etap 1 for '||to_char(dat_,'dd.mm.yyyy'));

       -- ���� ���������� ������i�
       select  max(dat)
       into datb_
       from rez_protocol
       where dat_bank is not null and
             dat_bank <= dat_ and
             dat <= dat_;

       if datb_ is null then
          datr_ := add_months(last_day(dat_)+1,-1);

          datp_ := dat_;
       else
          datr_ := last_day(datb_) + 1;
       end if;

   select max(dat_bank)
   into datp_
   from rez_protocol
   where dat = datb_  and
         dat <= dat_;

   if   datp_ is null and dat_ between to_date('31012013', 'ddmmyyyy')
    and to_date('10022013', 'ddmmyyyy') then

      datp_ := to_date('15012013', 'ddmmyyyy');
--   else
--      datp_ := datp_ + 1;
   end if;

   IF pmode_ = 2
   THEN
      datr_  := TRUNC(add_months(Dat_,1),'MM');
   END IF;

   for k in (select acc, nls, kv, rnk, s080, szq, szq_30, isp, mdate, tobo, nbs, kodp, s240, sump, suma,
                    cnt, rnum, decode(suma, 0, 1, sump / suma) koef, r011, r013, rz, discont, prem,
                    round(discont * decode(suma, 0, 1, sump / suma)) discont_row,
                    round(prem * decode(suma, 0, 1, sump / suma)) prem_row,
                    nd, id, ob22, custtype, accr, accr_30, tip
             from (
                 select t.acc, t.nls, decode(t.kv, 974, 933, t.kv) kv, t.rnk, t.s080,
                        nvl(gl.p_icurval(t.kv, t.sz, dat_), 0) szq,
                        nvl(gl.p_icurval(t.kv, t.rez_30, dat_), 0) szq_30,
                        a.isp, a.mdate, a.tobo, nvl(a.nbs, substr(a.nls, 1,4)) nbs,
                        nvl(s.kodp, '00000000000') kodp, nvl(s.s240, '0') s240, nvl(s.sump, 0) sump,
                        nvl((sum(s.sump) over (partition by s.acc, t.s080)), 0) suma,
                        nvl((count(*) over (partition by s.acc)), 0) cnt,
                        DENSE_RANK() over (partition by s.acc order by s240, s.r013) rnum,
                        s.r011, s.r013, NVL (DECODE (c.country, 804, '1', '2'), '1') rz,
                        nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                        nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                        t.nd, t.id, a.ob22, c.custtype, t.accr, t.accr_30, a.tip
                 from v_tmp_rez_risk_c5_new t,
                      (select  /* parallel (8) */
                            acc, kodp, substr(kodp, 9, 1) s240,
                            substr(kodp, 6, 1) R011,
                            substr(kodp, 7, 1) R013,
                            sum(to_number(znap)) sump
                       from rnbu_trace r
                       where substr(kodp,1,5) not in ('21600', '22600', '22605', '22620', '22625', '22650', '22655',
                                                      '11419','11429','11519','11529',
                                                      '12039','12069','12089',
                                                      '12109','12119','12129','12139',
                                                      '12209','12239' )
                       group by acc, kodp, substr(kodp, 9, 1), substr(kodp, 6, 1), substr(kodp, 7, 1)) s,
                       accounts a, customer c
                  where t.dat = datr_ and
                      t.id not like 'NLO%' and
                      a.tip <> 'SNA' and
                      t.acc = s.acc and
                      t.acc = a.acc and
                      nvl(a.nbs, substr(a.nls, 1,4)) in (select r020
                                from tmp_kod_r020
                                WHERE r020 not in ('2924')
                                      and substr(r020,1,3) not in ('141','410','420')
                                ) and
                      t.rnk = c.rnk and
                      (mfo_ = 300465 and nvl(t.dat_mi, dat_)<= dat_ or
                       mfo_ <> 300465 and nvl(t.dat_mi, dat_+1) > dat_)
                        )
            where szq <> 0 or discont <> 0 or prem <> 0 or suma <> 0
            order by tobo, acc, s240, rnum)
   loop
      IF typ_ > 0 THEN
         if k.accr is not null and mfo_ = '322669' then
            nbuc_ := NVL (F_Codobl_Tobo_New(k.accr, dat_, typ_), nbuc1_);
         else
            nbuc_ := NVL (F_Codobl_branch (k.tobo, typ_), nbuc1_);
         end if;
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      -- ����� ������� ��� ����������� ���� R013=1 �� 30-� ����, 2 - ����� 30
      r013_30 := f_ret_type_r013 ( dat_, k.nbs, k.r013 );

      if k.accr = k.accr_30 or r013_30 = 1
      then
         nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);
      else
         nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr_30);
      end if;

      nbs_ := substr(nbs_r013_, 1, 4);
      r013_ := substr(nbs_r013_, 5, 1);

      BEGIN
         if table_otcn_a7(k.nbs) = 1 then
            cnt_ := 1;
         end if;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            cnt_ := 0;
      END;

      r011_ := substr(k.kodp,6,1);

--      if not table_r011.exists(nbs_)
--      then
--          r011_ :='0';
--      end if;  

      if nbs_ in ('2609','2629','2659') then
         r011_ :='0';
      end if;      

      if nbs_ in ('2029','2039','2079','2209','2219','2229') 
      then 
         r011_ :='1';
      elsif nbs_ = '3599' and substr(k.nls, 1, 4) in ('3710', '3548') then
         r011_ :='2';
      end if;

      if r011_ ='0' then
         if      nbs_ in ('2239','2249','3599')
         then
               r011_ :='1';
         elsif   nbs_ in ('2019','2089','2119','2139')
         then
               r011_ :='2';
         elsif   nbs_ in ('2069','2109','2129')
         then
               r011_ :='3';
         elsif   nbs_ in ('3692')
         then
               r011_ :='4';
         elsif   nbs_ in ('2890')
         then
               r011_ :='6';
         else
               NULL;
         end if;
      end if;
      
      -- ������ ������� ����������� �������
      TP_SND := (case when substr(k.nls, 1,1) in ('1','2','3') and
                           ( (substr(k.nls,1,4) in ('2607','2627') and k.tip = 'SNA') or
                             (substr(k.nls,4,1) = '8' and k.tip = 'SNA')
                           ) and
                           substr(k.nls, 1, 4) not in ('1818','1819','2809','3519','3559')
                      then true else false end);

      if k.szq <>0 then
          if TP_SND then
             r012_:='B';

             -- ��� ������� ����������� %, �� � �������� �� R013
             if datn_ < zm_date2_ then
                kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||k.rz||r012_;
             elsif datn_ < zm_date3_ then
                kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 2)||k.rz||r012_||substr(k.kodp, 11, 3);
             else
                kodp_ := '2'||nbs_||r011_||r013_||substr(k.kodp, 8,2)||k.rz||substr(k.kodp, 11, 4);
             end if;

             srez_ := k.szq;

             sum_ := round(srez_ * k.koef);

             if k.rnum = 1 then
                sumc_ := sum_;
             else
                sumc_ := sumc_ + sum_;
             end if;

             if k.cnt = k.rnum and sumc_ <> srez_ then
                sum_ := sum_ + (srez_ - sumc_);
             end if;

             znap_ := to_char(sum_);
             comm_ := SUBSTR (k.tobo || ' ������ �� ���c������ ������� �������� �� R012='||r012_, 1, 200);
          else
             r012_:='A';

             if datn_ < zm_date2_ then
                kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||k.rz||r012_;
             elsif datn_ < zm_date3_ then
                kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 2)||k.rz||r012_||substr(k.kodp, 11,3);
             else
                kodp_ := '2'||nbs_||r011_||r013_||substr(k.kodp, 8,2)||k.rz||substr(k.kodp, 11,4);
             end if;

             if k.rnum = 1 then
                 discont_ := k.discont;
                 premiy_ := k.prem;

                 if k.suma  - discont_ + premiy_ < 0 then
                    sakt_ := k.suma;
                 else
                    sakt_ := k.suma  - discont_ + premiy_;
                 end if;

                 srez_ := (case when k.szq <= sakt_ then k.szq else sakt_ end);
                 srezp_ := (case when k.szq <= sakt_ then 0 else k.szq - srez_ end);
             end if;

             if k.cnt = 1 then
                znap_ := to_char(srez_);
                comm_ := SUBSTR (k.tobo || ' ������ �� ���.���� �������� �� R012='||r012_, 1, 200);
             else
                sum_ := round(srez_ * k.koef);

                if k.rnum = 1 then
                   sumc_ := sum_;
                else
                   sumc_ := sumc_ + sum_;
                end if;

                if k.cnt = k.rnum and sumc_ <> srez_ then
                   sum_ := sum_ + (srez_ - sumc_);
                end if;

                znap_ := to_char(sum_);

                comm_ := SUBSTR (k.tobo || ' ������ �� ���. ���� �������� �� R012='||r012_||' (�������� �� S240='||k.s240||')' , 1, 200);
             end if;
          end if;

          if znap_ <> '0' then
             if (discont_ <> 0 or premiy_ <> 0) then
                se_ := nvl(abs(fostq(k.acc, dat_)), 0); -- ������� �� �������

                insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
                values(k.nd, k.acc, k.nls, k.kv, kodp_, k.sump, se_, k.discont_row, premiy_);
             end if;

             INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm, nd, nbuc, tobo
                          )
              VALUES (s_rnbu_record.NEXTVAL, userid_,
                     k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate,
                     comm_, k.nd, nbuc_, k.tobo);
          end if;

          if srezp_ <> 0 and not TP_SND and k.cnt = k.rnum then
             s181_ := substr(k.kodp, 8, 1);
             s242_ := (case when 300465 in (mfo_, mfou_) then (case when s181_ = '1' then 'B' else 'H' end) else '1' end);

-- ���������� ������� ��� ������� ������ ����� ������ ����.�����
             if k.cnt =1 and k.nls like '3118%' then

                if r013_30 = 1 then
--   rez_30 ����� �������� � R013=B
--        ���������� ���������������� ������:  R013=r013_,R012=B
                   nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr_30);
                   sum_ := least ( k.szq_30, srezp_ );

                   if datn_ < zm_date3_ then
                     kodp_ := '2'||nbs_||substr(nbs_r013_, 5,1)||s181_||s242_||k.rz||'B'||substr(k.kodp, 11, 3);
                   else
                     kodp_ := '2'||nbs_||r011_||substr(nbs_r013_, 5,1)||s181_||s242_||k.rz||substr(k.kodp, 11,4);
                   end if;

                   znap_ := sum_;

                      INSERT INTO rnbu_trace
                               ( recid, userid,
                                 nls, kv, odate, kodp,
                                 znap, acc, rnk, isp, mdate,
                                 comm, nd, nbuc, tobo )
                        VALUES ( s_rnbu_record.NEXTVAL, userid_,
                                 k.nls, k.kv, data_, kodp_,
                                 znap_, k.acc, k.rnk, k.isp, k.mdate,
                                 comm_, k.nd, nbuc_, k.tobo );

                   srezp_ := srezp_ - sum_;
                else
--   (rez_-rez_30) ����� �������� � R013=A,R012=B
--        ��������� ���������������� ������ � R013=r013_,R012=B
                   nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);
                   sum_ := least ( k.szq-k.szq_30, srezp_ );

                   if datn_ < zm_date3_ then
                   kodp_ := '2'||nbs_||substr(nbs_r013_, 5,1)||s181_||s242_||k.rz||'B'||substr(k.kodp, 11, 3);
                   else
                   kodp_ := '2'||nbs_||r011_||substr(nbs_r013_, 5,1)||s181_||s242_||k.rz||substr(k.kodp, 11,4);
                   end if;

                   znap_ := sum_;

                      insert into rnbu_trace
                               ( recid, userid,
                                 nls, kv, odate, kodp,
                                 znap, acc, rnk, isp, mdate,
                                 comm, nd, nbuc, tobo )
                        values ( s_rnbu_record.NEXTVAL, userid_,
                                 k.nls, k.kv, data_, kodp_,
                                 znap_, k.acc, k.rnk, k.isp, k.mdate,
                                 comm_, k.nd, nbuc_, k.tobo );

                   srezp_ := srezp_ - sum_;
                end if;
             end if;

             if srezp_ <> 0  then
               r012_:='B';

               if datn_ < zm_date2_ then
                  kodp_ := '2'||nbs_||r013_||s181_||s242_||substr(k.kodp, 9, 1)||k.rz||r012_;
               elsif datn_ < zm_date3_ then
                  kodp_ := '2'||nbs_||r013_||s181_||s242_||k.rz||r012_||substr(k.kodp, 11, 3);
               else
                  kodp_ := '2'||nbs_||r011_||r013_||s181_||s242_||k.rz||substr(k.kodp, 11,4);
               end if;

               znap_ := srezp_;
               comm_ := SUBSTR (k.tobo || ' ����������� ������� ��� ���. ������ �� R012='||r012_, 1, 200);

               INSERT INTO rnbu_trace
                        ( recid, userid,
                          nls, kv, odate, kodp,
                          znap, acc, rnk, isp, mdate,
                          comm, nd, nbuc, tobo )
                 VALUES ( s_rnbu_record.NEXTVAL, userid_,
                          k.nls, k.kv, data_, kodp_,
                          znap_, k.acc, k.rnk, k.isp, k.mdate,
                          comm_, k.nd, nbuc_, k.tobo );
             end if;

          end if;
      else
         if datn_ < zm_date2_ then
            kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 3)||k.rz||'B';
         elsif datn_ < zm_date3_ then
            kodp_ := '2'||nbs_||r013_||substr(k.kodp, 7, 2)||k.rz||'B'||substr(k.kodp, 11, 3);
         else
            kodp_ := '2'||nbs_||r011_||r013_||substr(k.kodp, 8,2)||k.rz||substr(k.kodp, 11,4);
         end if;

         if k.rnum = 1 then
            discont_ := k.discont;
            premiy_ := k.prem;
         end if;

         if discont_ <> 0 or premiy_ <> 0 then
            se_ := nvl(abs(fostq(k.acc, dat_)), 0);

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, k.kodp, k.sump, se_, k.discont_row, premiy_);
         end if;
--  ��� ����� ��������: � ����� ���� ��������, ���� �������,��������,���쳿
         if discont_ =0 and premiy_ =0 and k.suma !=0  then

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, k.kodp, k.sump, k.suma, 0, 0);
         end if;

      end if;
   end loop;

   for k in (select /* parallel(8) */
                    acc, nbs, nls, kv, rnk, s080, szq, isp, mdate, tobo, s240, s180, r031, r030,
                    r011, r013, rez, discont, prem, nd, id, ob22, custtype, accr, tip
             from (
                 SELECT
                 T.ACC,
                 T.NLS,
                 DECODE(T.KV, 974, 933, T.KV) KV,
                 T.RNK,
                 T.S080,
                 GL.P_ICURVAL (T.KV, T.SZ - T.REZ_30, dat_) SZQ,
                 A.ISP,
                 A.MDATE,
                 A.TOBO,
                 nvl(a.nbs, substr(a.nls, 1,4)) NBS,
                 NVL (S.S240, '0') S240,
                 NVL (S.S180, '0') S180,
                 L.R031,
                 DECODE(LPAD (L.R030, 3, '0'), '974', '933', LPAD (L.R030, 3, '0')) R030,
                 NVL (S.R011, '0') R011, NVL (S.R013, '0') R013,
                 NVL (DECODE (C.COUNTRY, 804, '1', '2'), '1') REZ,
                 nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                 nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                 T.ND,
                 T.ID,
                 a.ob22, c.custtype, t.accr, a.tip
            FROM V_TMP_REZ_RISK_C5_NEW T,
                 ACCOUNTS A,
                 SPECPARAM S,
                 CUSTOMER C,
                 KL_R030 L
           WHERE T.DAT = datr_
                 AND NOT exists (SELECT ACC FROM RNBU_TRACE r
                                  where r.acc = T.ACC and substr(kodp,1,5) not in ('21600', '22600', '22605', '22620', '22625', '22650', '22655',
                                                                         '11419','11429','11519','11529','12039',
                                                                         '12069','12089','12109','12119','12129',
                                                                         '12139','12209','12239') )
                 and T.ID not LIKE 'NLO%'
                 and a.tip <> 'SNA' 
                 AND T.ACC = A.ACC
                 AND T.ACC = S.ACC(+)
                 AND A.KV = TO_NUMBER (L.R030)
                 AND nvl(A.NBS, substr(a.nls,1,4)) NOT IN ('2924')
                 AND substr(nvl(a.nbs, substr(a.nls,1,4)),1,3) not in ('141','410','420')
                 AND A.RNK = C.RNK
                 and (mfo_ = 300465 and nvl(t.dat_mi, dat_)<= dat_ or
                      mfo_ <> 300465 and nvl(t.dat_mi, dat_+1) > dat_)
      union
             SELECT
                 T.ACC,
                 T.NLS,
                 DECODE(T.KV, 974, 933, T.KV) KV,
                 T.RNK,
                 T.S080,
                 GL.P_ICURVAL (T.KV, T.REZ_30, dat_) SZQ,
                 A.ISP,
                 A.MDATE,
                 A.TOBO,
                 nvl(a.nbs, substr(a.nls, 1,4)) NBS,
                 NVL (S.S240, '0') S240,
                 NVL (S.S180, '0') S180,
                 L.R031,
                 DECODE(LPAD (L.R030, 3, '0'), '974', '933', LPAD (L.R030, 3, '0')) R030,
                 NVL (S.R011, '0') R011, NVL (S.R013, '0') R013,
                 NVL (DECODE (C.COUNTRY, 804, '1', '2'), '1') REZ,
                 nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                 nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                 T.ND,
                 T.ID,
                 a.ob22, c.custtype, t.accr_30 accr, a.tip
            FROM V_TMP_REZ_RISK_C5_NEW T,
                 ACCOUNTS A,
                 SPECPARAM S,
                 CUSTOMER C,
                 KL_R030 L
           WHERE T.DAT = datr_
                 AND NOT exists (SELECT ACC FROM RNBU_TRACE r
                                  where r.acc = T.ACC and substr(kodp,1,5) not in ('21600', '22600', '22605', '22620', '22625', '22650', '22655',
                                                                         '11419','11429','11519','11529','12039',
                                                                         '12069','12089','12109','12119','12129',
                                                                         '12139','12209','12239') )
                 and T.ID not LIKE 'NLO%'
                 AND T.ACC = A.ACC
                 and a.tip <> 'SNA'
                 AND T.ACCR_30 = S.ACC(+)
                 AND A.KV = TO_NUMBER (L.R030)
                 AND nvl(A.NBS, substr(a.nls,1,4)) NOT IN ('2924')
                 AND substr(nvl(a.nbs, substr(a.nls,1,4)),1,3) not in ('141','410','420')
                 AND A.RNK = C.RNK
                 and (mfo_ = 300465 and nvl(t.dat_mi, dat_)<= dat_ or
                      mfo_ <> 300465 and nvl(t.dat_mi, dat_+1) > dat_)
      union
            SELECT
                T.ACC,
                 T.NLS,
                 DECODE(T.KV, 974, 933, T.KV) KV,
                 T.RNK,
                 T.S080,
                 GL.P_ICURVAL (T.KV, T.SZ, dat_) SZQ,
                 A.ISP,
                 A.MDATE,
                 A.TOBO,
                 nvl(a.nbs, substr(a.nls, 1,4)) NBS,
                 NVL (S.S240, '0') S240,
                 NVL (S.S180, '0') S180,
                 L.R031,
                 DECODE(LPAD (L.R030, 3, '0'), '974', '933', LPAD (L.R030, 3, '0')) R030,
                 NVL (S.R011, '0') R011, NVL (S.R013, '0') R013,
                 NVL (DECODE (C.COUNTRY, 804, '1', '2'), '1') REZ,
                 nvl(gl.p_icurval(t.kv, t.discont, dat_),0) discont,
                 nvl(gl.p_icurval(t.kv, t.prem, dat_),0) prem,
                 T.ND,
                 T.ID,
                 a.ob22, c.custtype, t.accr, a.tip
            FROM V_TMP_REZ_RISK_C5_NEW T,
                 ACCOUNTS A,
                 SPECPARAM S,
                 CUSTOMER C,
                 KL_R030 L
           WHERE T.DAT = datr_
                 and (T.ID LIKE 'NLO%')
                 AND T.ACC = A.ACC
                 and a.tip <> 'SNA' 
                 AND T.ACC = S.ACC(+)
                 AND A.KV = TO_NUMBER (L.R030)
                 AND nvl(A.NBS, substr(a.nls,1,4)) NOT IN ('2924')
                 AND substr(nvl(a.nbs, substr(a.nls,1,4)),1,3) not in ('141','410','420')
                 AND A.RNK = C.RNK
                 and (mfo_ = 300465 and nvl(t.dat_mi, dat_)<= dat_ or
                      mfo_ <> 300465 and nvl(t.dat_mi, dat_+1) > dat_)
                        )
            where szq <> 0 or discont <> 0 or prem <> 0
            order by tobo, acc, s240)
   loop
      IF typ_ > 0 THEN
         if k.accr is not null and mfo_ = '322669' then
            nbuc_ := NVL (F_Codobl_Tobo_New(k.accr, dat_, typ_), nbuc1_);
         else
            nbuc_ := NVL (F_Codobl_branch (k.tobo, typ_), nbuc1_);
         end if;
      ELSE
         nbuc_ := nbuc1_;
      END IF;

      s240_ := nvl(fs240 (datn_, k.acc, dathb_, dathe_, k.mdate, k.s240), '0');

      if s240_ = '0' then
         s240_ := '1';
      end if;

      if nvl(k.s180, '0') = '0' then
         s180_ := fs180 (k.acc, SUBSTR (k.nbs, 1, 1), dat_);
      else
         s180_ := k.s180;
      end if;

      s181_ := nvl(fs181(k.acc, datn_, nvl(s180_, '0')), '0');

      if s181_ = '1' and s240_ > 'B' and s240_ <> 'Z' then
         s240_ := 'B';
      end if;

--      if k.nbs in ('2605', '2607', '2625') then
--         begin
--             select kodp
--             into kodp1_
--             from rnbu_trace
--             where acc = k.acc and rownum = 1;
--         exception
--            when no_data_found then
--                kodp1_ := null;
--         end;
--
--         if kodp1_ is not null then
--            s181_ := substr(kodp1_, 8, 1);
--            s240_ := substr(kodp1_, 9, 1);
--         end if;
--      end if;

      if     k.tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN')
      then
         sakt_ := abs(k.szq);
      else
         sakt_ := nvl(fostq(k.acc, dat_), 0);

         sakt_ := (case when sakt_ < 0 then abs(sakt_) else 0 end);

         if sakt_ <> 0 then
             discont_ := k.discont;
             premiy_ := k.prem;

             if sakt_  - discont_ + premiy_ >= 0 then
                sakt_ := sakt_  - discont_ + premiy_;
             end if;
         end if;
      end if;

      srez_ := (case when k.szq <= sakt_ then k.szq else sakt_ end);
      srezp_ := (case when k.szq <= sakt_ then 0 else k.szq - srez_ end);

      nbs_r013_ := f_ret_nbsr_rez(k.nls, k.r013, k.s080, k.id, k.kv, k.ob22, k.custtype, k.accr);

      nbs_ := substr(nbs_r013_, 1, 4);
      r013_ := substr(nbs_r013_, 5, 1);

      r011_ := k.r011;
      
--   �������� ������� ��� ����� �������� R011
--      if not table_r011.exists(nbs_)
--      then
--          r011_ :='0';
--      end if;      

      if nbs_ in ('2609','2629','2659') then
         r011_ :='0';
      end if;
            
      if nbs_ in ('2029','2039','2079','2209','2219','2229') 
      then 
          r011_ :='1';
      elsif nbs_ = '3599' then
          if substr(k.nls, 1, 4) in ('3710', '3548') then
             r011_ := '2';
          else
             r011_ := '1';
          end if;
      end if;

      if r011_ ='0' then
         if      nbs_ in ('2239','2249','3599')
         then
               r011_ :='1';
         elsif   nbs_ in ('2019','2089','2119','2139')
         then
               r011_ :='2';
         elsif   nbs_ in ('2069','2109','2129')
         then
               r011_ :='3';
         elsif   nbs_ in ('3692')
         then
               r011_ :='4';
         elsif   nbs_ in ('2890')
         then
               r011_ :='6';
         else
               NULL;
         end if;

      end if;

--------------------------------------- S190
      begin
          select nvl(kol,0)  into kol_351_
            from kol_nd_dat
           where dat =pdat_
             and nd = nd_
             and rownum = 1;

      exception
         when others  then  kol_351_ :=0;
      end;

      if kol_351_ = 0
      then
         s190_ := '0';
      elsif kol_351_ > 0 and kol_351_ < 8
      then
         s190_ := 'A';
      elsif kol_351_ < 31
      then
         s190_ := 'B';
      elsif kol_351_ < 61
      then
         s190_ := 'C';
      elsif kol_351_ < 91
      then
         s190_ := 'D';
      elsif kol_351_ < 181
      then
         s190_ := 'E';
      elsif kol_351_ < 361
      then
         s190_ := 'F';
      else
         s190_ := 'G';
      end if;

---------------------------------------
      BEGIN
         if table_otcn_a7(k.nbs) = 1 then
            cnt_ := 1;
         end if;
      EXCEPTION
         WHEN NO_DATA_FOUND THEN
            cnt_ := 0;
      END;

      -- ������ ������� ����������� �������
      TP_SND := (case when substr(k.nls, 1,1) in ('1','2','3') and
                           ( (substr(k.nls,1,4) in ('2607','2627') and k.tip = 'SNA') or
                             (substr(k.nls,4,1) = '8' and k.tip = 'SNA')
                           )  and
                           substr(k.nls, 1, 4) not in ('1818')
                      then true else false end);

      if k.szq <> 0 then
          if TP_SND then
             -- ���������� �������
             if     k.tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN')  then
                s240_ := 'Z';
             end if;

             r012_:='B';

             if sakt_ = 0 then
                s240_ := '1';
                comm_ := SUBSTR (k.tobo || ' ������ �� ������� �������� (������� = 0) �������� �� R012='||r012_, 1, 200);
             else
                comm_ := SUBSTR (k.tobo || ' ������ �� ���������� �������� �������� �� R012='||r012_, 1, 200);
             end if;

             if s240_ !='Z'  then s190_ :='0';  end if;
             if s240_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

             if datn_ < zm_date2_ then
                kodp_ := '2'||nbs_||r013_||s181_||s240_||k.r031||k.rez||r012_;
             elsif datn_ < zm_date3_ then
                kodp_ := '2'||nbs_||r013_||s181_||s240_||k.rez||r012_||k.r030;
             else
                kodp_ := '2'||nbs_||r011_||r013_||s181_||s240_||k.rez||s190_||k.r030;
             end if;

             znap_ := to_char(k.szq);
          else
             if     k.tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN')
             then
                s240_ := 'Z';

                if datn_ < zm_date2_ then
                   kodp_ := '2'||nbs_||r013_||s181_||s240_||k.r031||k.rez||'B';
                elsif datn_ < zm_date3_ then
                   kodp_ := '2'||nbs_||r013_||s181_||s240_||k.rez||'B'||k.r030;
                else
                if s240_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                   kodp_ := '2'||nbs_||r011_||r013_||s181_||s240_||k.rez||s190_||k.r030;
                end if;

                znap_ := to_char(k.szq);

                comm_ := SUBSTR (k.tobo || ' ������ �� ���������� �� ���.����� �������� �� R012=B ' , 1, 200);
             else
                r012_:='A';

                if datn_ < zm_date2_ then
                   kodp_ := '2'||nbs_||r013_||s181_||s240_||k.r031||k.rez||r012_;
                elsif datn_ < zm_date3_ then
                   kodp_ := '2'||nbs_||r013_||s181_||s240_||k.rez||r012_||k.r030;
                else
                  if s240_ !='Z'  then s190_ :='0';  end if;
                  if s240_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                   kodp_ := '2'||nbs_||r011_||r013_||s181_||s240_||k.rez||s190_||k.r030;
                end if;

                if k.nls like '3710%'  then
                   if datn_ < zm_date3_ then
                   kodp_ := '2'||nbs_||r013_||s181_||s240_||k.rez||'B'||k.r030;
                   else
                   kodp_ := '2'||nbs_||r011_||r013_||s181_||s240_||k.rez||s190_||k.r030;
                   end if;
                end if;

                znap_ := to_char(srez_);

                comm_ := SUBSTR (k.tobo || ' ������ �� ���.���� �������� �� R012='||r012_, 1, 200);
             end if;
          end if;

          if znap_ <> '0' then
              INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm, nd, nbuc, tobo
                          )
              VALUES (s_rnbu_record.NEXTVAL, userid_,
                     k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate,
                     comm_, k.nd, nbuc_, k.tobo);
          end if;

          if srezp_ <> 0 and not TP_SND then
             if     k.tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN')
             then
                s240_ := 'Z';
             end if;

             r012_ :='B';

             if datn_ < zm_date2_ then
                kodp_ := '2'||nbs_||r013_||s181_||s240_||k.r031||k.rez||r012_;
             elsif datn_ < zm_date3_ then
                kodp_ := '2'||nbs_||r013_||s181_||s240_||k.rez||r012_||k.r030;
             else
                if s240_ !='Z'  then s190_ :='0';  end if;
                if s240_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

                kodp_ := '2'||nbs_||r011_||r013_||s181_||s240_||k.rez||s190_||k.r030;
             end if;

             znap_ := srezp_;

             if sakt_ = 0 then
                comm_ := SUBSTR (k.tobo || ' ������ �� ���.������, � ����� ������� = 0, �������� �� R012='||r012_, 1, 200);
             else
                comm_ := SUBSTR (k.tobo || ' ����������� ������� ��� ���.������ �� R012='||r012_ , 1, 200);
             end if;

             INSERT INTO rnbu_trace
                          (recid, userid,
                           nls, kv, odate, kodp,
                           znap, acc,
                           rnk, isp, mdate,
                           comm, nd, nbuc, tobo
                          )
             VALUES (s_rnbu_record.NEXTVAL, userid_,
                     k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate,
                     comm_, k.nd, nbuc_, k.tobo);
          end if;

         discont_ := k.discont;
         premiy_ := k.prem;

         if discont_ <> 0 or premiy_ <> 0
                       or substr(k.nls,1,4) in ('3119','3219')
                                            and discont_=0   --21.09.2016
         then
            se_ := nvl(abs(fostq(k.acc, dat_)), 0); -- ������� �� �������

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, kodp_, se_, se_, discont_, premiy_);
         end if;
      else
         if     k.tip in ('SK9','SP ','SPN','OFR','KSP','KK9','KPN') and
            substr(k.nls, 1, 4) not in ('2607','2627','1819','2809','3519','3559')
         then
            s240_ := 'Z';
         end if;

         r012_ := 'B';

         if datn_ < zm_date2_ then
            kodp_ := '2'||nbs_||r013_||s181_||s240_||k.r031||k.rez||r012_;
         elsif  datn_ < zm_date3_ then
            kodp_ := '2'||nbs_||r013_||s181_||s240_||k.rez||r012_||k.r030;
         else
             if s240_ !='Z'  then s190_ :='0';  end if;
             if s240_ ='Z' and s190_ ='0'  then  s190_ :='A';  end if;

            kodp_ := '2'||nbs_||r011_||r013_||s181_||s240_||k.rez||s190_||k.r030;
         end if;

         discont_ := k.discont;
         premiy_ := k.prem;

         if discont_ <> 0 or premiy_ <> 0
               or ( (substr(k.nls,1,4) like '1__9'
                       or substr(k.nls,1,4) in ('3119','3219'))
                                            and discont_=0 )  --21.09.2016
         then
            se_ := nvl(abs(fostq(k.acc, dat_)), 0);

            insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
            values(k.nd, k.acc, k.nls, k.kv, kodp_, se_, se_, discont_, premiy_);
         end if;
      end if;
   end loop;

   if datn_ < zm_date3_ then
      update rnbu_trace r
       set kodp = substr(kodp, 1, 9) || 'C' || substr(kodp, 11)
       where r.acc in (select acc
                       from OTCN_FA7_REZ2
                       where pr <> 3)
         and r.kodp like '%D___'
         and not exists (select 1
                         from OTCN_FA7_REZ1 p
                         where p.nd = r.nd and
                               substr(p.nls,1,3) = substr(r.nls,1,3) and
                               p.kv = r.kv and
                               substr(p.nls,4,1) in ('7', '9') and
                               to_number(p.znap) <> 0)
         and exists (select 1
                         from OTCN_FA7_REZ1 p
                         where p.nd = r.nd and
                               substr(p.nls,1,3) = substr(r.nls,1,3) and
                               p.kv = r.kv and
                               substr(p.nls,4,1) not in ('7', '9') and
                               to_number(p.znap) <> 0);

      update rnbu_trace r
       set kodp = substr(kodp, 1, 9) || 'C' || substr(kodp, 11)
       where r.kodp like '2___6%D___'
         and r.acc not in (select acc
                           from nbu23_rez
                           where fdat = datr_);

   end if;

   logger.info ('P_FA7_NN: End etap 2 for '||to_char(dat_,'dd.mm.yyyy'));

   if datn_ < zm_date3_ then
   declare
       over_    number := 0;
       rizn_    number := 0;
   begin
       -- ��������� ��������/���쳿 �� ���� C �� D � ��������� �� ������
       for k in (select /* PARALLEL(8) */ s.*,
                    s.znap sumdp_k,
                    s.suma / s.suma_all koef,
                    nvl((count(*) over (partition by s.acc, s.nd, s.kv)), 0) cnt,
                    row_number() over (partition by s.acc, s.nd, s.kv order by s.acca, s.kodp) rnum
                 from (
                    select a.tp, a.nd, a.acc, a.nls, a.kv, a.kodp, a.znap, a.comm, a.tobo,
                        a.rnk, a.mdate, a.isp, a.nbuc,
                        substr(a.kodp, 7, 2) s181_s240, substr(a.kodp,11,1) r012,
                        b.ACC acca, b.NLS nlsa, substr(b.kodp, 7, 2) s181_s240_a,
                        decode(a.tp, 1, b.SUMD, b.SUMP) sumdp,
                        (case when substr(b.nls,4,1) = '7' or
                                   substr(b.kodp,11,1) = 'B' and datn_ < zm_date2_ or
                                   substr(b.kodp,10,1) = 'B' and datn_ >= zm_date2_
                              then 'D' else 'C'
                        end) r012_a,
                        b.suma, b.sumk,
                        nvl((sum(b.suma) over (partition by a.acc, a.nd, a.kv)), 0) suma_all
                    from
                        (-- ��������
                         select 1 tp, nd, acc, nls, kv, rnk, mdate, isp, nbuc, kodp, znap, comm, tobo
                         from rnbu_trace
                         where acc in (select acc
                                       from OTCN_FA7_REZ2
                                       where pr = 1)
                        union
                        -- ���쳿
                        select 2 tp, nd, acc, nls, kv, rnk, mdate, isp, nbuc, kodp, znap, comm, tobo
                         from rnbu_trace
                         where acc in (select acc
                                       from OTCN_FA7_REZ2
                                       where pr = 2)
                                       ) a
                    join
                        (select ND, ACC, NLS, KV, KODP,
                            to_number(ZNAP) suma,
                            SUMA sumk, SUMD, SUMP
                         from OTCN_FA7_REZ1
                         where suma <> 0 and
                            substr(nls, 4, 1) not in ('7', '8', '9')) b
                     on (a.nd = b.nd and
                         substr(a.nls,1,3) = substr(b.nls,1,3) and
                         a.kv = b.kv)) s)
       loop
          if k.rnum = 1 then
             if k.znap > k.suma_all then
                over_ :=  k.znap - k.suma_all;
             else
                over_ := 0;
             end if;
          end if;

          k.sumdp_k := round((k.znap - over_) * k.koef);

          if k.rnum = 1 then
             sumc_ := k.sumdp_k + over_;
          else
             sumc_ := sumc_ + k.sumdp_k;
          end if;

          if k.rnum = k.cnt then
             rizn_ := to_number(k.znap) - sumc_;
          end if;

          if datn_ < zm_date2_ then
             kodp_ := substr(k.kodp, 1, 6) || k.s181_s240_a || substr(k.kodp, 9, 2) || k.r012_a;
          else
             kodp_ := substr(k.kodp, 1, 6) || k.s181_s240_a || substr(k.kodp, 9, 1) || k.r012_a || substr(k.kodp, 11, 3);
          end if;

          if k.rnum = 1 then
             znap_ := to_char(k.sumdp_k);
             comm_ := substr(k.comm || ' ����� �� ������� '||k.nlsa||'('||to_char(k.kv)||')',1,255);

             update rnbu_trace
             set kodp = kodp_,
                 znap = znap_,
                 comm = comm_
             where acc = k.acc and
                nd = k.nd and
                kodp =k.kodp;

             if over_ <> 0 then
                 if datn_ < zm_date2_ then
                    kodp_ := substr(k.kodp, 1, 6) || substr(k.s181_s240_a,1,1) || '1' || substr(k.kodp, 9, 2) || 'D';
                 else
                    kodp_ := substr(k.kodp, 1, 6) || substr(k.s181_s240_a,1,1) || '1' || substr(k.kodp, 9, 1) || 'D' || substr(k.kodp, 11, 3);
                 end if;

                 znap_ := to_char(over_);
                 comm_ := substr(k.comm || ' ����������� �������� (> �� ������� �� ������� '||k.nlsa||'('||to_char(k.kv)||') )',1,255);

                 insert into rnbu_trace(recid, userid, nls, kv, odate, kodp,
                           znap, acc,rnk, isp, mdate, comm, nd, nbuc, tobo)
                 values(s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv, data_, kodp_,
                     znap_, k.acc, k.rnk, k.isp, k.mdate, comm_, k.nd, k.nbuc, k.tobo);
             end if;
          else
             if k.rnum = k.cnt then
                znap_ := to_char(k.sumdp_k + rizn_);
             else
                znap_ := to_char(k.sumdp_k);
             end if;

             comm_ := substr(k.comm || ' �������� �������� �� ������� �� ������� '||k.nlsa||'('||to_char(k.kv)||')',1,255);

             insert into rnbu_trace(recid, userid, nls, kv, odate, kodp,
                       znap, acc,rnk, isp, mdate, comm, nd, nbuc, tobo )
             values(s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv, data_, kodp_,
                 znap_, k.acc, k.rnk, k.isp, k.mdate, comm_, k.nd, k.nbuc, k.tobo);
          end if;
       end loop;
   end;

   else

      declare
          over_    number := 0;
          rizn_    number := 0;
      begin
          -- ��������� ��������/���쳿 �� ���� C �� D � ��������� �� ������
          for k in (select /* PARALLEL(8) */ s.*,
                       s.znap sumdp_k,
                       s.suma / s.suma_all koef,
                       nvl((count(*) over (partition by s.acc, s.nd, s.kv)), 0) cnt,
                       row_number() over (partition by s.acc, s.nd, s.kv order by s.acca, s.kodp) rnum
                    from (
                       select a.tp, a.nd, a.acc, a.nls, a.kv, a.kodp, a.znap, a.comm, a.tobo,
                           a.rnk, a.mdate, a.isp, a.nbuc,
                           substr(a.kodp, 8,2) s181_s240, substr(a.kodp,11,1) s190,
                           b.ACC acca, b.NLS nlsa, substr(b.kodp, 8,2) s181_s240_a,
                           decode(a.tp, 1, b.SUMD, b.SUMP) sumdp,
                           substr(b.kodp,11,1) s190_a, b.suma, b.sumk,
                           nvl((sum(b.suma) over (partition by a.acc, a.nd, a.kv)), 0) suma_all
                       from
                           (-- ��������
                            select 1 tp, nd, acc, nls, kv, rnk, mdate, isp, nbuc, kodp, znap, comm, tobo
                            from rnbu_trace
                            where acc in (select acc
                                            from OTCN_FA7_REZ2
                                           where pr = 1)
                           union
                           -- ���쳿
                           select 2 tp, nd, acc, nls, kv, rnk, mdate, isp, nbuc, kodp, znap, comm, tobo
                            from rnbu_trace
                            where acc in (select acc
                                            from OTCN_FA7_REZ2
                                           where pr = 2)
                           ) a
                       join
                           (select ND, ACC, NLS, KV, KODP,
                               to_number(ZNAP) suma,
                               SUMA sumk, SUMD, SUMP
                            from OTCN_FA7_REZ1
                            where suma <> 0 and
                               substr(nls, 4, 1) not in ('7', '8', '9')) b
                        on (a.nd = b.nd and
                            substr(a.nls,1,3) = substr(b.nls,1,3) and
                            a.kv = b.kv)) s)
          loop
             if k.rnum = 1 then
                if k.znap > k.suma_all then
                   over_ :=  k.znap - k.suma_all;
                else
                   over_ := 0;
                end if;
             end if;
      
             k.sumdp_k := round((k.znap - over_) * k.koef);
      
             if k.rnum = 1 then
                sumc_ := k.sumdp_k + over_;
             else
                sumc_ := sumc_ + k.sumdp_k;
             end if;
      
             if k.rnum = k.cnt then
                rizn_ := to_number(k.znap) - sumc_;
             end if;

             kodp_ := substr(k.kodp, 1,7) || k.s181_s240_a || substr(k.kodp, 10,1) || k.s190_a || substr(k.kodp, 12,3);
      
             if k.rnum = 1 then
                znap_ := to_char(k.sumdp_k);
                comm_ := substr(k.comm || ' ����� �� ������� '||k.nlsa||'('||to_char(k.kv)||')',1,255);
      
                update rnbu_trace
                set kodp = kodp_,
                    znap = znap_,
                    comm = comm_
                where acc = k.acc and
                   nd = k.nd and
                   kodp =k.kodp;
      
                if over_ <> 0 then

                    kodp_ := substr(k.kodp, 1,7) || substr(k.s181_s240_a,1,1) || '1' || substr(k.kodp, 10,1) || k.s190_a || substr(k.kodp, 12,3);
      
                    znap_ := to_char(over_);
                    comm_ := substr(k.comm || ' ����������� �������� (> �� ������� �� ������� '||k.nlsa||'('||to_char(k.kv)||') )',1,255);
      
                    insert into rnbu_trace(recid, userid, nls, kv, odate, kodp,
                              znap, acc,rnk, isp, mdate, comm, nd, nbuc, tobo)
                    values(s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv, data_, kodp_,
                        znap_, k.acc, k.rnk, k.isp, k.mdate, comm_, k.nd, k.nbuc, k.tobo);
                end if;
             else
                if k.rnum = k.cnt then
                   znap_ := to_char(k.sumdp_k + rizn_);
                else
                   znap_ := to_char(k.sumdp_k);
                end if;
      
                comm_ := substr(k.comm || ' �������� �������� �� ������� �� ������� '||k.nlsa||'('||to_char(k.kv)||')',1,255);
      
                insert into rnbu_trace(recid, userid, nls, kv, odate, kodp,
                          znap, acc,rnk, isp, mdate, comm, nd, nbuc, tobo )
                values(s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv, data_, kodp_,
                    znap_, k.acc, k.rnk, k.isp, k.mdate, comm_, k.nd, k.nbuc, k.tobo);
             end if;
          end loop;
      end;

   end if;

   -- ������� SNA
   insert into OTCN_FA7_REZ1(ND, ACC, nls, kv, KODP, ZNAP, SUMA, SUMD, SUMP)
    select b.nd, b.acc, b.nls, b.kv, b.kodp, b.znap, b.suma,
        round(gl.p_icurval(t.kv, t.discont, dat_) * b.koef, 0) diskont, 0
    from (
    select a.*,
        (a.suma/nvl((sum(a.znap) over (partition by a.acc)), 0)) koef,
        nvl((count(*) over (partition by a.acc)), 0) cnt,
        DENSE_RANK() over (partition by a.acc order by a.kodp ) rnum
    from (
    select nd, acc, nls, kv, kodp, sum(to_number(znap)) znap, sum(to_number(znap)) suma
    from rnbu_trace r
    where substr(r.kodp,1,1) = '1' and
         (substr(r.kodp,5,1) in ('7','9') or
          substr(r.kodp,5,1) = '8' and substr(r.kodp,2,4) <> '1818' or
          substr(r.kodp,2,4) in ('2607','2627')) and
          nd is not null
    group by nd, acc, nls, kv, kodp) a) b, v_tmp_rez_risk_c5_new t
    where  b.acc = t.acc and
        t.dat = datr_ and
        t.discont <> 0 and
        b.acc not in (select acc from OTCN_FA7_REZ1);

----------------------------------------------------
   declare
       over_    number := 0;
       rizn_    number := 0;
   begin
       -- ��������� SNA ��������� �� ������
       for k in (select s.*,
                    (case when s.suma_all <> 0 then round(s.sumd * s.suma / s.suma_all, 0) else 0 end) sumdp_k,
                    (case when s.suma_all <> 0 then s.suma / s.suma_all else 0 end) koef,
                    nvl((count(*) over (partition by s.acc, s.nd, s.kv)), 0) cnt,
                    row_number() over (partition by s.acc, s.nd, s.kv order by s.acca, s.kodp) rnum
                 from (
                    select a.tp, a.nd, a.acc, a.nls, a.kv, a.kodp, a.znap, a.comm, a.tobo,
                        a.rnk, a.mdate, a.isp, a.nbuc,
                        substr(a.kodp, 8,2) s181_s240, '0' r012,
                        b.ACC acca, b.NLS nlsa, substr(b.kodp, 8,2) s181_s240_a,
                        substr(b.kodp, 11,1) s190_a,
                        decode(a.tp, 1, b.SUMD, b.SUMP) sumdp,
                        '4' r012_a,
                        b.suma, b.sumk, to_number(a.znap) sumd,
                        nvl((sum(b.suma) over (partition by a.acc, a.nd, a.kv)), 0) suma_all
                    from (        --  �������  SNA
                           select 1 tp, nd, acc, nls, kv, rnk, mdate, isp,
                                        nbuc, kodp, znap, comm, tobo
                             from rnbu_trace
                            where acc in ( select acc
                                             from OTCN_FA7_REZ2
                                            where pr =3 )
                         ) a
                    join
                        (select ND, ACC, NLS, KV, KODP,
                            to_number(ZNAP) suma,
                            SUMA sumk, SUMD, SUMP
                         from OTCN_FA7_REZ1
                         where znap<>0) b
                     on (a.nd = b.nd and
                         substr(a.nls,1,3) = substr(b.nls,1,3) and
                         a.kv = b.kv)) s)
       loop
          over_ := 0;

          if k.rnum = 1 then
             sumc_ := k.sumdp_k;
          else
             sumc_ := sumc_ + k.sumdp_k;
          end if;

          if k.rnum = k.cnt then
             rizn_ := to_number(k.znap) - sumc_;
          end if;

          if datn_ < zm_date2_ then
             kodp_ := substr(k.kodp, 1, 6) || k.s181_s240_a || substr(k.kodp, 9, 2) || k.r012_a;
          elsif datn_ < zm_date3_ then
             kodp_ := substr(k.kodp, 1, 6) ||
                substr(k.s181_s240_a, 1, 1) || (case when k.suma = '0' then 'Z' else substr(k.s181_s240_a, 2, 1) end)||
                substr(k.kodp, 9, 1) || k.r012_a || substr(k.kodp, 11, 3);
          else
             kodp_ := substr(k.kodp, 1,7) ||
                substr(k.s181_s240_a, 1,1) ||
                (case when k.suma = '0' then 'Z' else substr(k.s181_s240_a, 2,1) end)||
                substr(k.kodp, 10,1) ||
                (case when k.suma = '0' then 'B' else k.s190_a end)||
                substr(k.kodp, 12,3);
          end if;

          if k.rnum = 1 then
             znap_ := to_char(k.sumdp_k);
             comm_ := substr(k.comm || ' ����� �� ������� '||k.nlsa||'('||to_char(k.kv)||')',1,255);

             update rnbu_trace
             set kodp = kodp_,
                 znap = znap_,
                 comm = comm_
             where acc = k.acc and
                nd = k.nd and
                kodp =k.kodp;
          else
             if k.rnum = k.cnt then
                znap_ := to_char(k.sumdp_k + rizn_);
             else
                znap_ := to_char(k.sumdp_k);
             end if;

             comm_ := substr(k.comm || ' �������� SNA �� ������� �� ������� '||k.nlsa||'('||to_char(k.kv)||')',1,255);

             insert into rnbu_trace(recid, userid, nls, kv, odate, kodp,
                       znap, acc,rnk, isp, mdate, comm, nd, nbuc, tobo )
             values(s_rnbu_record.NEXTVAL, userid_, k.nls, k.kv, data_, kodp_,
                 znap_, k.acc, k.rnk, k.isp, k.mdate, comm_, k.nd, k.nbuc, k.tobo);
          end if;
       end loop;

       -- ����� s240 ��� SNA ��� ������i� �� ��������� ������� i ������� ����������

       update rnbu_trace
          set kodp = substr(kodp,1,8)||'Z'||substr(kodp,10,1)||'B'||substr(kodp,12),
              comm = comm||' ����������� S240=Z'
        where recid in (
                  select r.recid
                    from rnbu_trace r
                   where (r.kodp like '22068%' or
                          r.kodp like '22208%' or
                          r.kodp like '22238%')
                     and substr(r.kodp,9,1) !='Z'
                     and r.acc in (select acc from otcn_fa7_rez2
                                    where pr =3)
                     and not exists ( select 1
                                        from otcn_fa7_rez1 n
                                       where abs(n.znap) <> 0
                                         and abs(n.znap) >= abs(r.znap)
                                         and substr(n.nls,1,3) = substr(r.nls,1,3)
                                         and n.nd = r.nd
                                         and n.kv = r.kv )
                       );

       -- ����� s240 ��� SNA ��'������ � ��������.���������� ��� ������� � ��������

       update rnbu_trace
          set kodp = substr(kodp,1,8)||'Z'||substr(kodp,10,1)||'B'||substr(kodp,12),
              comm = comm||' update S240'
        where recid in (
                  select r.recid
                    from rnbu_trace r
                   where (r.kodp like '21508%' or r.kodp like '23118%')
                     and substr(r.kodp,9,1) !='Z'
                     and r.acc in (select acc from otcn_fa7_rez2
                                    where pr =3)
                     and exists ( select 1
                                    from nbu23_rez n
                                   where n.fdat = datr_
                                     and n.tip in ('SK9','SP ','SPN','KSP','KPN')
                                     and n.bv >0
                                     and n.diskont =0 and n.rez =0
                                     and n.nd = r.nd
                                     and n.acc not in (select acc from otcn_fa7_rez1)
                                     and substr(n.nls,1,3) = substr(r.nls,1,3) )
                       );
   end;

   logger.info ('P_FA7_NN: End etap 3 for '||to_char(dat_,'dd.mm.yyyy'));

   -- ������ �� ���������, �������� ��������� � ���
   if FL_DO_ = 1 then
      if datn_ < zm_date3_ then
          sql_doda_ := 'insert into rnbu_trace(recid, userid, nls, kv, odate, kodp, znap, '||
                                'mdate, comm, nbuc) '||
                       'select s_rnbu_record.NEXTVAL, :userid_, BBBB || ''XXX'', 980, :dat_, '||
                             ' D || BBBB || P || X || '||
                             ' (case when BBBB in (''4400'',''4409'',''4410'',''4419'',''4430'',''4431'',''4500'',''4509'')
                                          then (case when F_SROK(:dat_, MDATE,3) < ''C''
                                                        then ''C''
                                                        else F_SROK(:dat_, MDATE,3)
                                                end)
                                     else F_SROK(:dat_, MDATE,3)
                                end) || '||
                             ' R || SCHA || ''980'', to_char(suma), '||
                             ' MDATE, ''� ������� A_TPK_A7ADD'', :tobo_ '||
                       'from A_TPK_A7ADD where fdat = :dat_';

      execute immediate sql_doda_ using userid_, dat_, dat_, dat_, dat_, tobo_, dat_;
      else
          NULL;
--!!   ��������  ��� ����� ���������    � ������� A_TPK_A7ADD
      end if;

      execute immediate sql_doda_ using userid_, dat_, dat_, dat_, dat_, tobo_, dat_;
   end if;

   logger.info ('P_FA7_NN: End etap 4 for '||to_char(dat_,'dd.mm.yyyy'));

-- �������� �� ������� �������
   declare
      recid_    number;
      granica_  number := 100;
   begin
      for k in (select fdat, ref, acc, nls, kv, sq, nbs, acca,
                       sum(sq) over (partition by acc) sum_all
                from (select /*+ leading(a) index(o,IDX_OPLDOK_KF_FDAT_ACC)  */
                             o.fdat, o.ref, o.acc, a.nls, a.kv,
                             decode(o.dk, 0, -1, 1) * gl.p_icurval(a.kv, o.s, dat_) sq,
                             a.nbs, z.acc acca
                      from accounts a, opldok o, opldok z, accounts x, oper p
                      where o.fdat = any (select fdat from fdat
                                           where fdat between datp_ and dat_
                                             and fdat !=to_date('20171218','yyyymmdd')  ) and
                        o.acc = a.acc 
                        and a.tip = 'REZ' 
                        and o.tt not like 'AR%'
                        and o.ref = z.ref
                        and o.fdat = z.fdat
                        and o.stmt = z.stmt
                        and o.dk <> z.dk
                        and o.dk = 0 
                        and z.acc = x.acc
                        and x.nls not like '7%'
                        and x.nls not like '3800%'
                        and x.nbs is not null
                        and o.ref = p.ref
                        and p.sos in (-2, 5)
                        and p.vdat between datb_ and dat_
                       )
                   )
       loop
           if k.sum_all <> 0 then
               begin
                   select recid, kodp, znap
                   into recid_, kodp_, znap_
                   from rnbu_trace
                   where acc = k.acca and
                         kodp like '2'||substr(k.nls,1,4)||'%' and
                         rownum = 1;
               exception
                  when no_data_found then
                      recid_ := null;
               end;

               if recid_ is not null then
                  INSERT INTO rnbu_trace
                              (recid, userid, nls, kv, odate, kodp,
                               znap, acc, rnk, isp, mdate, ref,
                               comm, nbuc, tobo
                              )
                   select s_rnbu_record.NEXTVAL recid,
                          userid, nls, kv, odate, kodp,
                          to_char(k.sq), acc,
                          rnk, isp, mdate, k.ref,
                          '�������� �� ������� ������� ��� = '||to_char(k.ref) comm,
                          nbuc, tobo
                   from rnbu_trace
                   where recid = recid_;
               end if;
           end if;
       end loop;
   end;

   logger.info ('P_FA7_NN: End etap 5 for '||to_char(dat_,'dd.mm.yyyy'));

--------------
--  ����������� s240 ��� "��������" ��������� ����� 06.06.2015

   for k in ( select /*+ parallel(r,8) */
                     r.rowid, r.kodp, r.znap, r.comm, substr(r.kodp,9,1) s240
                from rnbu_trace r,
                    (   select da.accid
                          from dpu_deal dd, dpu_vidd dv, dpu_accounts da
                         where dd.dat_begin > dp_date_
                           and dd.dpu_id = da.dpuid
                           and dd.vidd = dv.vidd
                           and nvl(dv.IRVK,0) !=1
                        union all
                        select da.accid
                          from dpt_deposit dd, dpt_accounts da,
                              ( select vidd, tag, val
                                  from dpt_vidd_params
                                 where tag like 'FORB_EARLY%'
                              ) dp
                         where dd.dat_begin > dp_date_
                           and dd.deposit_id = da.dptid
                           and dd.vidd = dp.vidd
                           and (     dp.tag = 'FORB_EARLY'
                                 and nvl(dp.val,0) !=1
                               or
                                     dp.tag = 'FORB_EARLY_DATE'
                                 and dp.val is not null
                                 and to_date(dp.val,'dd/mm/yyyy') > dd.dat_begin
                                 and to_date(dp.val,'dd/mm/yyyy') <= dat_
                               )
                        union all
                        select da.accid
                          from dpt_deposit dd, dpt_accounts da
                         where dd.dat_begin > dp_date_
                           and dd.deposit_id = da.dptid
                           and not exists
                                  ( select 1
                                      from dpt_vidd_params dp
                                     where dp.vidd = dd.vidd
                                       and dp.tag like 'FORB%' )
                    ) d
               where r.acc = d.accid
                 and substr(r.kodp,2,4) in ('2630','2635','2636','2637',
                                            '2610','2615','2616','2617',
                                            '2651','2652','2656','2657')
            )
   loop

       if k.s240 not in ('0','1','2','I','Z')  then

            update rnbu_trace
               set kodp = substr(k.kodp,1,8)||'I'||substr(k.kodp,10),
                   comm = substr(k.comm || ' ����� S240 ' || substr(k.kodp,9,1) ||
                        ' � �������.����������', 1, 200)
             where rowid = k.rowid;
       end if;

   end loop;

-------------------
    declare
       recid_    number;
       granica_  number := 1000;
    begin
        for k in (select nvl(a.nbuc, b.nbuc) nbuc, nvl(a.t020, b.t020) t020,
                         nvl(a.nbs, b.nbs) nbs, nvl(a.kv, b.kv) kv, nvl(a.rez, b.rez) rez,
                         a.ostq ost1, b.ostq ost2, nvl(a.ostq, 0) - nvl(b.ostq, 0) rizn,
                         R013_s580, R013_s580_A
                 from (select nbuc, rez, t020, nbs, kv,
                             ostq +
                             (case when nbs not like '9%'
                                     then 0
                                     else f_ret_pereoc(dat_, '01',
                                            t020||'0'||nbs||lpad(kv, 3, '0'), nbuc, typ_)
                             end) ostq
                       from (
                           select nbuc, decode(t020, -1, '1', '2') t020, rez, nbs, kv, abs(ostq) ostq
                           from (
                             select  /*+ parallel(8) */
                                     (case when typ_ > 0
                                             THEN NVL (F_Codobl_branch (s.tobo, typ_), nbuc1_)
                                             else nbuc1_
                                     end) nbuc, 2-MOD(c.codcagent,2) rez,
                                 sign(decode(a.kv, 980, decode(pmode_, 2, a.ost - a.dos96 + a.kos96, a.ost),
                                                        decode(pmode_, 2, a.ostq - a.dosq96 + a.kosq96, a.ostq))) t020,
                                 a.nbs, a.kv,
                                 sum(decode(a.kv, 980, decode(pmode_, 2, a.ost - a.dos96 + a.kos96, a.ost),
                                                       decode(pmode_, 2, a.ostq - a.dosq96 + a.kosq96, a.ostq))) ostq
                             from otcn_saldo a, otcn_acc s, customer c
                             where  nvl(a.nbs, substr(a.nls,1,4)) in ('1410','1412','1415','1416','1417','1418',
                                           '1490','1491','1492','1493','1590','1592','1890',
                                           '2400','2401','2890','3190','3290','3590','3599','3690','3692',
                                           '9010','9015','9030','9031','9036','9500',
                                          '1419','1429','1509','1519','1529','2039','2069','2089','2109','2119','2129',
                                          '2139','2209','2239','2609','2610','2615','2629','2651','2652','2659','3119','3219')
                                and a.acc = s.acc
                                and a.rnk = c.rnk
                             group by (case when typ_ > 0
                                             THEN NVL (F_Codobl_branch (s.tobo, typ_), nbuc1_)
                                             else nbuc1_
                                     end), 2-MOD(c.codcagent,2),
                                     sign(decode(a.kv, 980, decode(pmode_, 2, a.ost - a.dos96 + a.kos96, a.ost),
                                                        decode(pmode_, 2, a.ostq - a.dosq96 + a.kosq96, a.ostq))),
                                      a.nbs, a.kv)
                           where t020 <> 0)) a
                     full outer join
                     (select nbuc,
                             substr(kodp, 1, 1) t020,
                             substr(kodp,10, 1) rez,
                             substr(kodp, 2, 4) nbs, kv,
                             sum(to_number(znap)) ostq,
                             min('1'||substr(kodp, 6, 2)) R013_s580,
                             min('1'||substr(kodp, 6, 2)) R013_s580_A
                         from rnbu_trace r
                         where substr(kodp, 2, 4) in ('1410','1412','1415','1416','1417','1418',
                                           '1490','1491','1492','1493','1590','1592','1890',
                                           '2400','2401','2890','3190','3290','3590','3599','3690','3692',
                                           '9010','9015','9030','9031','9036','9500',
                                          '1419','1429','1509','1519','1529','2039','2069','2089','2109','2119','2129',
                                          '2139','2209','2239','2609','2610','2615','2629','2651','2652',
                                          '2659','3119','3219')
                         group by nbuc, substr(kodp, 1, 1), substr(kodp,10,1), substr(kodp, 2, 4), kv) b
                     on (a.nbuc = b.nbuc and a.rez = b.rez and a.t020 = b.t020 and a.nbs = b.nbs and a.kv = b.kv)
                 where abs(nvl(a.ostq, 0) - nvl(b.ostq, 0)) between 1 and granica_
                 order by 1, 2 )
        loop
            begin
               if k.nbs not in ('2400','2401') then
                   begin
                      select recid
                       into recid_
                      from rnbu_trace
                      where nbuc = k.nbuc and
                            kodp like k.t020||k.nbs||'____'||k.rez||'_'||lpad(k.kv, 3,'0')||'%' and
                            substr(kodp, 6,2) = substr(k.R013_s580,2,2) and
                            (sign(k.rizn) = -1 and to_number(znap) >= abs(k.rizn) or
                            sign(k.rizn) = 1 and to_number(znap) > 0) and
                            rownum = 1;
                   exception
                      when no_data_found then
                           begin
                              select recid
                               into recid_
                              from rnbu_trace
                              where nbuc = k.nbuc and
                                    kodp like k.t020||k.nbs||'____'||k.rez||'_'||lpad(k.kv, 3,'0')||'%' and
                                    substr(kodp, 6,2) = substr(k.R013_s580_A,2,2) and
                                    (sign(k.rizn) = -1 and to_number(znap) >= abs(k.rizn) or
                                    sign(k.rizn) = 1 and to_number(znap) > 0) and
                                    rownum = 1;
                           exception
                              when no_data_found then
                                  begin
                                     select recid
                                      into recid_
                                     from rnbu_trace
                                     where nbuc = k.nbuc and
                                           kodp like k.t020||k.nbs||'____'||k.rez||'_'||lpad(k.kv, 3,'0')||'%' and
                                           substr(kodp, 6,2) = substr(k.R013_s580,2,2) and
                                           (sign(k.rizn) = -1 and to_number(znap) >= abs(k.rizn) or
                                           sign(k.rizn) = 1 and to_number(znap) > 0) and
                                           rownum = 1;
                                  exception
                                     when no_data_found then
                                       recid_ := null;
                                  end;
                           end;
                   end;
               else
                  begin
                     select recid
                      into recid_
                     from rnbu_trace
                     where nbuc = k.nbuc and
                           kodp like k.t020||k.nbs||'_2__'||k.rez||'_'||lpad(k.kv, 3,'0')||'%' and
                           substr(kodp, 6,2) = substr(k.R013_s580,2,2) and
                           (sign(k.rizn) = -1 and to_number(znap) >= abs(k.rizn) or
                           sign(k.rizn) = 1 and to_number(znap) > 0) and
                           rownum = 1;
                  exception
                     when no_data_found then
                        begin
                           select recid
                            into recid_
                           from rnbu_trace
                           where nbuc = k.nbuc and
                                 kodp like k.t020||k.nbs||'_3__'||k.rez||'_'||lpad(k.kv, 3,'0')||'%' and
                                 substr(kodp, 6,2) = substr(k.R013_s580,2,2) and
                                 (sign(k.rizn) = -1 and to_number(znap) >= abs(k.rizn) or
                                 sign(k.rizn) = 1 and to_number(znap) > 0) and
                                 rownum = 1;
                        exception
                           when no_data_found then
                              select recid
                               into recid_
                              from rnbu_trace
                              where nbuc = k.nbuc and
                                    kodp like k.t020||k.nbs||'____'||k.rez||'_'||lpad(k.kv, 3,'0')||'%' and
                                    substr(kodp, 6,2) = substr(k.R013_s580_A,2,2) and
                                    (sign(k.rizn) = -1 and to_number(znap) >= abs(k.rizn) or
                                    sign(k.rizn) = 1 and to_number(znap) > 0) and
                                    rownum = 1;
                        end;
                  end;
               end if;
            exception
               when no_data_found then
                  recid_ := null;
            end;

            if recid_ is not null then
               update rnbu_trace
               set znap = to_char(to_number(znap) + k.rizn),
                 comm = substr(comm || ' + ����-�� � �������� �� '||to_char(k.rizn), 1, 200)
               where recid = recid_;
            end if;
        end loop;
    end;

   --------------------------------------------------
   if dat_ <to_date('20171226','yyyymmdd')  then
       delete from rnbu_trace
        where substr(kodp, 2,4) not in (select r020 from TMP_KOD_R020 ) ;
   end if;

    update rnbu_trace
       set kodp =substr(kodp,1,8)||'M'||substr(kodp,10)
     where substr(kodp,9,1) in ('G','H');

    update rnbu_trace
       set kodp =substr(kodp,1,8)||'L'||substr(kodp,10)
     where substr(kodp,9,1) in ('E','F');

    update rnbu_trace
       set kodp =substr(kodp,1,8)||'K'||substr(kodp,10)
     where substr(kodp,9,1) in ('C','D');

    update rnbu_trace
       set kodp =substr(kodp,1,8)||'J'||substr(kodp,10)
     where substr(kodp,9,1) in ('6','7','8','A','B');

    update rnbu_trace
       set kodp =substr(kodp,1,8)||'I'||substr(kodp,10)
     where substr(kodp,9,1) in ('3','4','5');

--------------------------------------------------
   IF pmode_ = 0
   THEN
      DELETE FROM tmp_nbu
            WHERE kodf = kodf_ AND datf = dat_;

      INSERT INTO tmp_nbu
                  (kodf, datf, kodp, nbuc, znap)
         SELECT   kodf_, dat_, kodp, nbuc, SUM (TO_NUMBER (znap))
             FROM rnbu_trace
         GROUP BY kodp, nbuc
         having SUM (TO_NUMBER (znap))<>0;
   END IF;

   -- ��� ����������� ��������� ����� ���������� @77 (������ #A7)
   IF pmode_ = 2
   THEN
      DELETE FROM tmp_irep
            WHERE kodf = '77' AND datf = dat_;

      INSERT INTO tmp_irep
                  (kodf, datf, kodp, nbuc, znap)
         SELECT   '77', dat_, kodp, nbuc, SUM (TO_NUMBER (znap))
             FROM rnbu_trace
         GROUP BY kodp, nbuc;

         otc_del_arch('77', dat_, 1);
         OTC_SAVE_ARCH('77', dat_, 1);
         commit;
   END IF;
   commit;

   if pmode_ <> 2 and pnd_ is null then
      begin
          otc_del_arch(kodf_, dat_, 0);
          OTC_SAVE_ARCH(kodf_, dat_, 0);
          commit;
      exception
        when others then
            logger.info ('P_FA7_NN: Errors '||sqlerrm);
      end;
   end if;

   logger.info ('P_FA7_NN: END ');

------------------------------------------------------------------
--exception
--    when others then
--        logger.info ('P_FA7_NN: Error: '||sqlerrm);
END p_fa7_nn;
/