 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/rez1.sql =========*** Run *** ======
 PROMPT ===================================================================================== 

  CREATE OR REPLACE PACKAGE BARS.REZ1 
IS
/*
DESCRIPTION : ������� � ��������� ��� ������� �������
VERSION     : 11.07.2011
�OMMENT     :


 ������ ���������� ��� AWK.exe ���  AW.bat
 -- SB  ��� ���������
 �����:   AWK REZ1.pks REZ.<xx> <���������>
 AWK REZ1.rez REZ1.sb  SB        * ��� ���������
 AWK REZ1.rez REZ1.sql           * ������
 ------------------------------------------------

 ������������ ������� ��������� � ������� PARAMS:

 'RZPRR013' = 1 - ��� ����������� ������������ > 31 ��� ��������� ������������ R013 (��� ����)
                (�� ��������� �������������� ���� ��������)
 'REZPAY2'  = 1 - ��� ������ ������������ ��������� ca_pay_rez2 (��� ����)
               (�� ������ ������ ��������������, ��������� ��������� �� ��� ��� �� ����� ����� )
 'REZPAR1'  = 1 - ���� - �� ��������� ��� ��������� ������� � ������ (��� ����)
 'REZPAR2'  = 1 - ���� - ��������� ��� ������� ������������ 26 ��� �������� > 2 ��� (��� ����)
 'REZPAR3'  = 1 - ���� - ����������� ��������� ������� 2071 (��� ����), ���� ������ �������
                  �������� ���������, ������������� ����� ���������� ��� ����������� � ����� 30,
              ���� ������� ������������ ��� ����� � ������� - ����������� ������� tmp_rez_risk2
 'REZPAR4'  = 1 - �� ��������� ��� ������� �������
 'REZPAR5'  = 1 - ������� �������������� �� 83 ��������� (��� �� ����� � ������, ���� � PARAMS !!!)
 'REZPAR6'  = 1 - ������ � ������ ���������� �������� (��� �� ����� � ������, ���� � PARAMS !!!)
 'REZPAR7'  = 1 - ���� - �������� �� ��������� ���� ������� ��� ������  (custtype=1) (��� ����)
 'REZPAR8'  = 1 - ��� ������� ������� �� ������ ������������ ��������� ������������ "��������� ��������"
                  �.�. ���� �������� R013 ��������
                       = 2 - ����������� 100 % ������� �� �������� ����,
                       = 1 - �� �����������
                  ���� �� �������� ����������� �� �������������� ��������
                  ����� ������� = �������(�� ���� �������� ���� - 31 ����) -
                                  ���������� ������� (� �������� ���� -31 ���� �� �������� ����)
 'REZPAR9'  = 1 - ������ ����������� �� ������������ ����� 30 ���� �������� ������������ ��
                  ����. ��������� � ����� � ����������� (������������� ������� - ��������� �����������)

 'REZPAR10'  = 1 - ����� ������������� �������� �� �������� ��������� ���� �� ���������� ����� ���
                   ������� ��� ����� ������� � ������� SREZERV.
                   ���� �� - �������� ��������� �� ������ � �������� �� �����������

 'REZPAR11'  = 1 - ��������� �������� S270 = 8 ��� ������� ������� �� ������������ %
                   (���� S270 = 8, �� ������������� ��� % - � �����������, � ������������ �� 31 ���
                   , � ������������ �����, � ������������)

*/

   -- pac������ S080 (�� ����������� fin_obs_s080)
   -- �� ������ ����������� ��������� ����������� � ��������� ������������ �����
   FUNCTION r_s080 (fin_ INT, obs_ INT)
      RETURN CHAR;

   -- ������� ���������� ��� ���� ������� �� ����������� �����
   FUNCTION id_nbs (nbs_ CHAR)
      RETURN NUMBER;

  FUNCTION id_specrez (p_dt date, p_istval number,p_kv varchar2, p_idr varchar2
                      , p_custtype varchar2  ) --T 13.01.2009
      RETURN NUMBER;

   -- ������� �� ����� � ������ ��.
   FUNCTION ostc96 (acc_ INT, dat_ DATE)
      RETURN NUMBER;

FUNCTION ostc96_3 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER;

   --  ������ ����� ����������� ���������� �� ���� DAT_
   --  6��-7�� ��� ������� (������ 7 ������ � SREZERV)
   FUNCTION fin (dat_ IN DATE)
      RETURN NUMBER;

   -- ������ ����� �������� � ��� �� ���� �� ��� �������� �����
   FUNCTION ca_fq_discont (
      acc_    IN   INT,
      dat_    IN   DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      p_nd         number DEFAULT NULL,
      p_skqall     number DEFAULT NULL,
      p_skq        number DEFAULT NULL
   )
      RETURN NUMBER;

   -- ������ ����� ������ � ��� �� ���� �� ��� �������� �����
   FUNCTION ca_fq_prem (
      acc_    IN   INT,
      dat_    IN   DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      p_nd         number DEFAULT NULL,
      p_skqall     number DEFAULT NULL,
      p_skq        number DEFAULT NULL
   )
      RETURN NUMBER;

/*
    ��������� ��� ������������� �� ������������� ������� ������������
    �����-�����������

    ��� ������� ����� ������ ���������� "����������� �����������" �.�.
   ����������� ������������ ��� ������� �������:

   1. ����������� ������� ��������������� ����� ����� ��������� �������
       ������������� ������ � ������� cc_accp. � ������ ����������� ������
       ������� ������� �������������� �������� ���������� ��� !!!
    2. ������� �� ����������� ������������ �� specparam.S080 � pawn_acc.pawn
       (��������� ����� � ��� ������) ����� ���������� cc_pawn_s080.
       ��������� ����� �� ��������� (���� �� ��������� � specparam) = 1.

     � ������ ���� �� ���������� ��� �����������, �� ������ ��� = 0
     ������� �� �����������, ��� ����� �� ������������� �������� ���������� ���
     (�������� nbs = 9129 � R013 = 9) ����������� �� ������ ���� ������ = 0 !!!
*/

/*

   ������ ����� ����������� � ��� �� ���� �� ��� �������� �����

   acc_      - ���� ������
   dat_      - ����
   mode_ = 0 - ������ ����������� � ������ �������� �� ������
         = 1 - ��� ����� �������� �� ������ (��� ca_fq_zalog)
         = 2 - ������ �������� �� ������ ��� ������ ���� "������_ ����� �� ������_ ��������" ������� �� pr (��� 42 �����)
         = 3 - ������ �������������� ����� ������� (��� ca_fq_rasch)
   par_  = 1 - �������� ���� ���� �������� ����� ����������� ���  ������ ����� ����������� (s031=33)
   pawn_     - ��� �����������, �������� ���� ���� �������� ����� �� ������ ���

*/
   FUNCTION ca_fq_obesp (
      acc_    IN   INT,
      dat_    IN   DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL
   )
      RETURN NUMBER;

  FUNCTION ca_fq_obesp (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL,
      zal_   out  number,
      vid_zal out  number ,
      disc_     number,
      prm_        number
   )
      RETURN NUMBER;

  FUNCTION ca_fq_obesp1 (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL,
      zal_   out  number,
      vid_zal out  number ,
      disc_     number,
      prm_        number,
      p_ostc        number,
      p_nd          number,
      p_wdate       date
   ) RETURN NUMBER;

        -- ������ ����� ����������� � ��� �� ���� �� ������ ���������� �������
   -- ��� ������ ����������� � ������ ���� SS, SP, SL, CR9
   FUNCTION ca_fq_obesp_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER;

   -- ������ ����� ������ � ��� �� ���� �� ��� �������� �����
   FUNCTION ca_fq_zalog (acc_ IN INT, dat_ IN DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER;

   -- ������ ����� ������ � ��� �� ���� �� ��� �������� ����� ��� #D8
   -- � ����� ���������� ������ ����������� ������������ ��� ������� �������
   -- ��������� ��� �.�. �� ���������� ������� s031 = 33, 90
   FUNCTION ca_fq_zalog_d8 (acc_ IN INT, dat_ IN DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER;

   -- ������ ����� ������ � ��� �� ���� �� ������ ���������� �������
   -- ��� ������ ����������� � ������ ���� SS, SP, SL, CR9
   FUNCTION ca_fq_zalog_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER;

   -- �������������� ����� ������ � ��� �� acc �������� �����
   FUNCTION ca_fq_rasch (acc_ IN INT, dat_ IN DATE)
      RETURN NUMBER;

   -- �������������� ����� ������ � ��� �� ������ ���������� �������
   -- ��� ������ ����������� � ������ ���� SS, SP, SL, CR9
   FUNCTION ca_fq_rasch_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER;

   -- ������ ����� ������� � ��� �� ���� �� ��� �������� �����
   FUNCTION ca_f_rezerv (acc_ IN INT, dat_ IN DATE)
      RETURN NUMBER;

   -- ������ ����� ������� � ��� �� ���� �� ������ ���������� �������
   -- ��� ������ ����������� � ������ ���� SS, SP, SL, CR9
   FUNCTION ca_f_rezerv_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER;

   -- ��������� ���� - ���� ������ (return 1 ���� ������, 0 ���� ���)
   FUNCTION f_nbs_is_prem (nbs_ VARCHAR2)
      RETURN NUMBER;

   -- ���������� ���� -  ���� ��������  (return 1 ���� �������, 0 ���� ���)
   FUNCTION f_nbs_is_disc (nbs_ VARCHAR2)
      RETURN NUMBER;

   -- ���������� ���� - ���� ���������� �����  (return 1 ���� ����, 0 ���� ���)
   FUNCTION f_nbs_is_fond (nbs_ VARCHAR2)
      RETURN NUMBER;

   function f_get_rest_over_30(acc_ number, last_work_date_ date, p_sz number default null) return number;

   -- ���������� ������ �������
   PROCEDURE rez_risk (id_ INT, dat_ DATE, mode_ IN INT DEFAULT 0, pr_ in int default null);

   -- ��������� �������� �� ������� �������� .
   -- ������������ ������� �� ��������� �� DAT_
   PROCEDURE ca_pay_rez (dat_ DATE, mode_ NUMBER DEFAULT 0);

   -- ������ ��������� ������ ��� �� ����
   PROCEDURE ca_pay_rez2 (dat_ DATE, mode_ NUMBER DEFAULT 0);

   -- ��������� ���������� ������� tmp_finrez.
   -- ������ ������� ������������ ����� ������������� ����� ��������� ��� ����� ����.
   -- ����� ������������ ����� ��������� ����� �� ���������� � ������� �������� ����,
   -- � ����� ����� �������������� ������� (�� ��������� ������).
   -- �������� ����� �������� � �������, ���������� ������� "������ � ������� ����� � ���������� ������ ���"
   PROCEDURE p_finrez (dat1_ DATE, dat2_ DATE);

   -- ��������� ���������� ������� tmp_finrez_SB (��� ���������).
   -- ������ ������� ������������ ����� ������������� ����� ��������� �� ������� �������.
   -- ����� ������������ ����� ��������� ����� �� ���������� � ������� �������� ����,
   -- � ����� ����� �������������� ������� (�� ��������� ������).
   -- �������� ����� �������� � �������, ���������� ������� "������ � ������� ����� � ���������� ������ ���"
   PROCEDURE p_finrez_SB (dat1_ DATE, dat2_ DATE);

   -- ��������� ������ 11 ����� � �������� ������� (����������,�� ������������)
   PROCEDURE p_check_file11 (dat_ DATE);

   -- ��������� ����������� ������ ��� ��������� ������������ > 30 ����.
    PROCEDURE p_perv_zal (dat_ DATE);

   -- ��������� ������ 30 ����� � �������� ������� (����������,�� ������������)
   PROCEDURE p_check_file30 (dat_ DATE);

   -- ��������� ������������ ������ ������ 30 � 11 ������ (����������, �� ������������)
   PROCEDURE p_check_file30_11 (dat_ DATE);

   -- ��������� ���������� ������� tmp_rez_risk2 ������� ������� � ������ ������� �������
   -- ������������ � �������� ������� "���������� � ������� �������"
   PROCEDURE delta (id_ INT, dat1_ DATE, dat2_ DATE);

--     ������� ���������� ������� �� ����� � ������ ��������������
--     ��������. ��� ������ ����� �������������� �������� ������-
--     ������ ��������� ������� TMP_CRTX
   FUNCTION get_restc (
      p_acccode    IN   accounts.acc%TYPE,
      p_restdate   IN   saldoa.fdat%TYPE
   )
      RETURN saldoa.ostf%TYPE;

   -- ��������� ��������� ������� ���.
   -- ������������ � ��������� �������.
   -- ��������������� ���������� ���������� ������
   -- dat1_ - ������� �������� ����
   -- dat2_ - ��������� �������� ����
   PROCEDURE set_date (dat1_ DATE, dat2_ DATE);

   -- ������� ���������� ������� �������� ����
   -- ������������� ���������� set_date
   FUNCTION curdate
      RETURN DATE;

   -- ������� ���������� ���������� �������� ����
   -- ������������� ���������� set_date
   FUNCTION prevdate
      RETURN DATE;

   -- ������� ��� ��������� ��������� ���������� ������ (������) �� ����� ���������.
   -- �������� ��������� ���������
   -- par_ = 'VERSION' - ������ ������
   --      = 'NBSDISCONT' - ������ � ����������� ������� ��������� (����������� �������)
   --      = 'NBSPREMIY'  - ������ � ����������� ������� ������ (����������� �������)
   --      = 'USELOG'     - 1 - ������������ ������ ������������� ������ � �������� (���. cp_rez_log)
   --                     - 0 - �������� �� ������������
   --      = 'CALCDOPPAR' - 1 - ��� ������� ����������� ������  � ���������� �������������� ���������� ���������
   --                     - 0 - ������� ���. ���������� ��������� �� ������������
   FUNCTION f_getpar (par_ VARCHAR2)
      RETURN VARCHAR2;


   -- ��������� ��� ��������� ���������� ������
   -- ����� ���������� ��� ���������
   --      = 'USELOG'     - 1 - ������������ ������ ������������� ������ � �������� (���. cp_rez_log)
   --                     - 0 - �������� �� ������������
   --      = 'CALCDOPPAR' - 1 - ��� ������� ����������� ������  � ���������� �������������� ���������� ���������
   --                     - 0 - ������� ���. ���������� ��������� �� ������������
   PROCEDURE p_setpar (par_ VARCHAR2, val_ VARCHAR2);

   -- ������ ��������� ������
   FUNCTION header_version
      RETURN VARCHAR2;

   -- ������ ���� ������
   FUNCTION body_version
      RETURN VARCHAR2;

   PROCEDURE set_log (acc_ number);

   PROCEDURE p_load_data (dat_ DATE, acc_ NUMBER DEFAULT NULL);
   PROCEDURE p_unload_data;

   Function f_get_nd(acc_ number) return number; --T 16.06.2009


END rez1;
/
CREATE OR REPLACE PACKAGE BODY BARS.rez1
/*
   VERSION : 15-11-2017  
 */

IS

/* 
 ������ ���������� ��� AWK.exe ���  AW.bat
 -- SB  ��� ���������  
 �����:   AWK REZ1.rez REZ.<xx> <���������> 
 AWK REZ1.rez REZ1.sb  SB        * ��� ���������     
 AWK REZ1.rez REZ1.sql           * ������      
*/


--21-12-2011 - 14.03.2012 ���������� �������� (2 ��������)
--           - ��������� ����� ��� �������
--11-10-2011 - ���.���� �� ���������� ��������
--           - p_load_data � ������� ������� �� ��� (���� �� ���)

   -- ������ ������
   ind_            VARCHAR2 (30);
   version_        VARCHAR2 (30)   := '22.11.2017';
   sss varchar2(1000);
   c_dt date := to_date('28122008','ddmmyyyy');
   curdate_        DATE;   -- ������� �������� ����
   prevdate_       DATE;   -- ���� ������ ��������� �������
   rownumber_      NUMBER; -- ����� ������ ��� �������� � ������� cp_rez_log
   userid_         NUMBER; -- ��� �������� ������������ �� STAFF
   curacc_         NUMBER; -- ������� �������� acc � �������� �� ��������� rez_risk
   n_              NUMBER          := 0;
   p               NUMBER          := 0;
   n1_             NUMBER          := 0;
   ndiscont_       NUMBER          := 0;
   ndiscont1_      NUMBER          := 0;
   nprem_          NUMBER          := 0;
   nprem1_         NUMBER          := 0;
   acckr_          NUMBER; -- ��� �����, ���� ������ ������� ������������ �� ������ ����� (����� rez_risk �� �-� ���� ca_..)
   rezerv_         NUMBER; -- ����� ������� �� ������ �����, ������������ ��� �������� ��� ������� ����. rez_risk
   i_              NUMBER          := 0;
   i2_             NUMBER          := 0;
   i3_             NUMBER          := 0;
   i4_             NUMBER          := 0;
   -- ���������� ����� ��������
   nbsdiscont_     VARCHAR2 (2000)
      := '2236,2226,2216,2206,2116,2106,2086,2076,2066,2036,2026,1626,1526,1326,1316,';
   -- ���������� ����� ������
   nbspremiy_      VARCHAR2 (2000)
      := '';
   -- ���������� ����� ���������� �����
   nbsfond_        VARCHAR2 (2000)
           := ',1492,1590,1591,1592,1593,1790,2400,2401,2490,3291,3599,3690,';
   uselog_         NUMBER          := 0; -- ���� - �������, ������ ��������� � ������� ��������� cp_rez_log
   calcdoppar_     NUMBER          := 0; -- ������� ������� �������������� ���������� ��������� ��� ������� �������
   acountry        NUMBER          DEFAULT 804; -- ��� ������ �� ���������
   -- ����� ����������� ���������� ������� �������
   rzprr013_       NUMBER          DEFAULT 0;
   rezpay2_        NUMBER          DEFAULT 0;
   rezpar1_        NUMBER          DEFAULT 0;
   rezpar2_        NUMBER          DEFAULT 0;
   rezpar3_        NUMBER          DEFAULT 0;
   rezpar4_        NUMBER          DEFAULT 0;
   rezpar5_        NUMBER          DEFAULT 1;
   rezpar6_        NUMBER          DEFAULT 1; -- ����������� ������������ �������
   rezpar7_        NUMBER          DEFAULT 0;
   rezpar8_        NUMBER          DEFAULT 0;
   rezpar9_        NUMBER          DEFAULT 0; -- ���� - ������ ����� ����� > 30 ���� ��������� �� ���� ���������
   rezpar10_       NUMBER          DEFAULT 0; --T 22.01.2009
   rezpar11_       NUMBER          DEFAULT 0; --T 07.04.2009
   zal_sp_         NUMBER          DEFAULT 0; -- �������� �� ������.������� ����������� ����.������������
   rez_disc_       NUMBER          DEFAULT 0; -- 1 - ������� ���������� � ������ � ������ ����������� ����� � ������
   -- ���� - �����. �� �������� ������������ >30 ���� �� ����. ���������
   flagallrez_     NUMBER          DEFAULT 0;
   par_ob22        number := nvl(GetGlobalOption('OB22'),0);
   rez_upz_        NUMBER          DEFAULT 0; -- ���� - ������������ �������� ���������� ������ (����� ������)

   TYPE type_zal IS TABLE OF tmp_rez_risk2%ROWTYPE
      INDEX BY BINARY_INTEGER;

   allzal_         type_zal;
   onezal_         type_zal;

   TYPE type_discont IS TABLE OF tmp_rez_risk3%ROWTYPE
      INDEX BY BINARY_INTEGER;

   alldisc_        type_discont;
   onedisc_        type_discont;

   TYPE type_prem IS TABLE OF tmp_rez_risk4%ROWTYPE
      INDEX BY BINARY_INTEGER;

   allprem_        type_prem;
   oneprem_        type_prem;

   TYPE type_korprov IS RECORD (
      ob     NUMBER,
      fdat   DATE
   );

   TYPE type_korprov1 IS TABLE OF type_korprov
      INDEX BY BINARY_INTEGER;

   korprov_        type_korprov1;

   TYPE type_saldo IS RECORD (
      ost    NUMBER,
      fdat   DATE
   );

   TYPE type_saldo1 IS TABLE OF type_saldo
      INDEX BY BINARY_INTEGER;

   salost_         type_saldo1;

   TYPE type_nd_acc IS TABLE OF NUMBER
      INDEX BY BINARY_INTEGER;

   ndacc_          type_nd_acc;

   TYPE type_odncre IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   dodncre_        type_odncre;

   TYPE type_prcrd IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   prcrd_          type_prcrd;

   TYPE type_przalkl IS TABLE OF VARCHAR2 (1)
      INDEX BY BINARY_INTEGER;

   przalkl_        type_przalkl;

   TYPE type_dnpr IS TABLE OF NUMBER
      INDEX BY BINARY_INTEGER;

   dnprcre_        type_dnpr;

   TYPE type_prcrezal IS TABLE OF VARCHAR2 (1)
      INDEX BY VARCHAR(30);

   prcrezal_       type_prcrezal;

   allzal_null_    type_zal;
   alldisc_null_   type_discont;
   allprem_null_   type_prem;
   korprov_null_   type_korprov1;
   salost_null_    type_saldo1;
   ndacc_null_     type_nd_acc;
   dodncre_null_   type_odncre;
   dnprcre_null_   type_dnpr;
   prcrd_null_     type_prcrd;
   przalkl_null    type_przalkl;
   prcrezal_null_       type_prcrezal;

   flagkorprov_    NUMBER          DEFAULT 0;
   g_restdate      DATE;            -- ���� ���������� �������������� ��������

   --zal_tbl       t_zal := t_zal(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);--T 16.06.2009


   -- ���������� ���������, ���� ��������� �����
   --PROCEDURE p_load_data (dat_ DATE, acc_ NUMBER DEFAULT NULL);

   -- ��������� ����������� ������ ��� ��������� ������������ > 30 ����.
    PROCEDURE p_perv_zal (dat_ DATE)
   IS

   datpr DATE;
   datn  DATE;
   dnpr_ NUMBER;
   priz_ NUMBER;
   pr_   NUMBER;
   rnk_  NUMBER:=0;
   l_acc NUMBER;

   BEGIN
      update cc_accp SET pr_12=2;

      FOR k IN  (SELECT d.rnk,d.nd,sum(a.ostc) s 
                 FROM   cc_deal d,accounts a,nd_acc n  
                 WHERE  vidd in (1,2,3,11,12,13) and d.sos >=10 and d.sos<15 
                        and d.nd=n.nd and n.acc=a.acc  
                        and a.tip in ('SS ','SP ','SL ')  
                 group by d.rnk,d.nd
                 order by d.rnk,s )

      LOOP

          IF rnk_<>k.rnk then
             rnk_ :=k.rnk;
             priz_:=0;
             pr_  :=0;
             dnpr_:=0;
          END IF;

          IF priz_=0 THEN

             BEGIN
                SELECT NVL (MAX (CASE WHEN ss.ostf = 0 AND ss.dos - ss.kos > 0
                                 THEN ss.fdat
                                 ELSE NULL
                                 END),dat_),
                            MAX (CASE WHEN ss.ostf - ss.dos + ss.kos = 0
                                 THEN ss.fdat
                                 ELSE NULL
                                 END) 
                INTO datpr,datn
                FROM (SELECT a.rnk, n.nd, s.fdat,SUM (s.dos) dos, 
                             SUM (s.kos) kos,SUM (s.ostf) ostf
                      FROM saldoa s,nd_acc n,accounts a,specparam p
                      WHERE s.acc = a.acc AND a.acc = n.acc and n.nd=k.nd
                            AND a.acc = p.acc AND a.tip in ('SP ','SPN','SK9','OFR')
                            AND a.rnk = k.rnk AND s.fdat <= dat_
                      GROUP BY a.rnk, n.nd, s.fdat) ss
                GROUP BY ss.rnk, ss.nd;
 
                EXCEPTION WHEN NO_DATA_FOUND THEN
                    datpr:=null;
                    datn :=null;
             END;

             IF datn IS NULL OR datpr > datn THEN

                dnpr_ := dat_ - datpr;
                -- ������� ������������ > 30 ����
                IF dnpr_ > 30 THEN

                   FOR kz IN (select c.acc,c.nd 
                              from cc_accp c,pawn_acc cp 
                              where nd=k.nd and c.acc=cp.acc -- and cp.pawn<>33  ���� �� ����� ����� ����� �����������
                              group by c.nd,c.acc)
                   LOOP
                      BEGIN
                         select acc into l_acc 
                         from cc_accp p,cc_deal d 
                         where p.acc=kz.acc and p.nd<>kz.nd and rownum=1 
                               and p.nd=d.nd and sos<>15; 
                      EXCEPTION WHEN NO_DATA_FOUND THEN l_acc:=null;
                      END;
                      IF l_acc is not null then 
                         UPDATE cc_accp SET pr_12=1 where nd=k.nd and acc=kz.acc;
                         priz_:=1;
                      END IF;  
                   END LOOP;
                END IF;
             END IF;
          END IF;
      END LOOP;
      BEGIN     
         FOR k IN  (select acc , count(*) cnt
                    from (select p.nd, p.acc,count(*) 
                          from cc_accp p,cc_deal d
         where p.nd=d.nd (+) and d.sos<>15
                          group by p.nd,p.acc )
                    group by acc


                   )
         LOOP
            IF k.cnt=1 THEN
               UPDATE cc_accp SET pr_12=3 where acc=k.acc;       
            END IF;  
         END LOOP;
      END;
   END;

   -- ��������� ������� ������ � �������� ������� ������� - ������� cp_rez_log
   PROCEDURE to_log (id_ NUMBER, txt_ VARCHAR2, val_ VARCHAR2)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      --  dbms_output.put_line(txt_||' '||val_);
      IF uselog_ = 1 AND curacc_ = id_
      THEN
         rownumber_ := rownumber_ + 1;

         INSERT INTO cp_rez_log
                     (userid, ID, rownumber, txt, val
                     )
              VALUES (userid_, id_, rownumber_, txt_, val_
                     );

         COMMIT;
      END IF;
   END;

   PROCEDURE set_log (acc_ number)
   IS
   BEGIN
--      uselog_ := 1;
      curacc_ := acc_;
      rownumber_ := 0;
   END;

  procedure p_error( p_error_type  NUMBER,
                     p_nbs         VARCHAR2,
                     p_s080        VARCHAR2,
                     p_custtype    VARCHAR2,
                     p_kv          VARCHAR2,
                     p_branch      VARCHAR2,
                     p_nbs_rez     VARCHAR2,
                     p_nbs_7f      VARCHAR2,
                     p_nbs_7r      VARCHAR2,
                     p_sz          NUMBER,
                     p_error_txt   VARCHAR2,
                     p_desrc       VARCHAR2)
  is
  PRAGMA AUTONOMOUS_TRANSACTION;
  begin
     insert into srezerv_errors
     ( dat,userid, error_type, nbs, s080, custtype, kv, branch,
      nbs_rez,nbs_7f,  nbs_7r, sz, error_txt, desrc)
     values (trunc(sysdate), user_id, p_error_type, p_nbs, p_s080, p_custtype, p_kv, p_branch,
            p_nbs_rez, p_nbs_7f, p_nbs_7r, p_sz, p_error_txt, p_desrc) ;
     COMMIT;
  end;

-----------------------------------
   PROCEDURE p_finrez (dat1_ DATE, dat2_ DATE)
   IS
      formuser_      NUMBER;
      formuserold_   NUMBER;
      txt_           VARCHAR2 (200);
   BEGIN
      BEGIN
         SELECT userid
           INTO formuser_
           FROM rez_protocol
          WHERE dat = dat2_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            rez1.rez_risk (userid_, dat2_);
            formuser_ := userid_;
      END;

      BEGIN
         SELECT userid
           INTO formuserold_
           FROM rez_protocol
          WHERE dat = dat1_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            formuserold_ := formuser_;
      END;

      DELETE FROM tmp_finrez;

      INSERT INTO tmp_finrez
                  (acc, fondid, kv, s080, s_oldf1, sq_oldf1, s_oldf2,
                   sq_oldf2, s_newf, sq_newf, s_del, sq_del, s_isp, sq_isp,
                   sq_curs)
         SELECT a.acc, '', a.kv, r.s080, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
           FROM srezerv r, v_gl a
          WHERE r.s_fond = a.nls;

      -- 1. ������� ����� �� ���������� ���� �� ����� ���� ����
      -- 2. ������� ����� �� ������� �������� ���� �� ����� ���. �������� ����
      -- 3. ������� ����� �� ������� �������� ���� �� ����� ����.�������� ����
      FOR k IN (SELECT a.nbs, a.nls, t.*
                  FROM tmp_finrez t, v_gl a
                 WHERE t.acc = a.acc)
      LOOP
         DECLARE
            sn1_   NUMBER := 0;
            -- ���������� ������� ����� � ������ �������������� ��������� ������
            sn2_   NUMBER := 0;
            -- ����� ������������� ����� �� ��������� �������
            sn3_   NUMBER := 0;
            -- ����������� ��������� ������� ����� �� �������� ����
            sn4_   NUMBER := 0;
            -- ������������� �������� ���������� �� �������� �������� ������
            sn5_   NUMBER := 0;
            -- ����������� ��������� ������� ����� �� �������� ���� (� ������ ��)
            sn6_   NUMBER := 0;     -- ��������� ����� ����� �� �������� ����
            sn7_   NUMBER := 0;         -- ������ ���� �� ������ tmp_rez_risk
         BEGIN
            -- 1.
            sn1_ := rez1.ostc96 (k.acc, dat1_);

            -- 2.
            FOR b IN (SELECT o.s, p.nlsa, p.nlsb
                        FROM opldok o, oper p
                       WHERE k.acc = o.acc
                         AND o.REF = p.REF
                         AND p.vob <> '096'
                         AND o.fdat > dat1_
                         AND o.fdat <= dat2_
                         AND o.s < 0)
            LOOP
               IF     b.nlsa NOT LIKE '7%'
                  AND b.nlsa NOT LIKE '7%'
                  AND (b.nlsa = k.nls OR b.nlsb = k.nls)
                  AND SUBSTR (b.nlsa, 1, 4) <> SUBSTR (b.nlsb, 1, 4)
               THEN
                  sn2_ := sn2_ + b.s;
               END IF;
            END LOOP;

            -- 3.
            BEGIN
               SELECT s.ostf - s.dos + s.kos
                 INTO sn3_
                 FROM saldoa s
                WHERE (acc, fdat) =
                                  (SELECT   ss.acc, MAX (ss.fdat)
                                       FROM saldoa ss
                                      WHERE ss.fdat <= dat2_
                                            AND ss.acc = s.acc
                                   GROUP BY ss.acc)
                  AND s.acc = k.acc;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sn3_ := 0;
            END;

            -- 4.
            sn4_ := 0;                                 -- ���� �� ������������
            -- 5.
            sn5_ := rez1.ostc96 (k.acc, dat2_);

            -- 6.
            BEGIN
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO sn6_
                 FROM tmp_rez_risk r, srezerv s
                WHERE r.s080 = s.s080
                  AND r.kv = k.kv
                  AND s.s_fond = k.nls
                  AND r.idr = s.ID
                  AND r.custtype = s.custtype
                  AND r.dat = dat2_
                  AND r.ID = formuser_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  sn6_ := 0;
            END;

            txt_ := '';

            IF k.nbs = '2400'
            THEN
               txt_ := '������� ������������� ';
            ELSIF k.nbs = '2401'
            THEN
               txt_ := '������� ����������� ';

               IF k.s080 = '2'
               THEN
                  txt_ := txt_ || ' (��� ���������)';
               ELSIF k.s080 = '3'
               THEN
                  txt_ := txt_ || ' (��������������)';
               ELSIF k.s080 = '4'
               THEN
                  txt_ := txt_ || ' (������������)';
               ELSIF k.s080 = '5'
               THEN
                  txt_ := txt_ || ' (�����������)';
               END IF;
            ELSIF k.nbs = '1590'
            THEN
               txt_ := '������� ������������� ';

               IF k.s080 = '2'
               THEN
                  txt_ := txt_ || ' (��� ���������)';
               ELSIF k.s080 = '3'
               THEN
                  txt_ := txt_ || ' (��������������)';
               ELSIF k.s080 = '4'
               THEN
                  txt_ := txt_ || ' (������������)';
               ELSIF k.s080 = '5'
               THEN
                  txt_ := txt_ || ' (�����������)';
               END IF;
            ELSIF k.nbs = '1591'
            THEN
               txt_ := '������� ����������� ';
            ELSIF k.nbs = '1592'
            THEN
               txt_ := '�������� ������������� ';
            ELSIF k.nbs = '1593'
            THEN
               txt_ := '�������� ����������� ';
            ELSIF k.nbs = '1790'
            THEN
               txt_ := '������� ������������ ������ ';
            ELSIF k.nbs = '2490'
            THEN
               txt_ := '������� ������������ ������ ';
            ELSIF k.nbs = '3599'
            THEN
               txt_ := '������� ������ ����������� ������ ';
            ELSIF k.nbs = '3690'
            THEN
               txt_ := '������� ��������� ';

               IF k.s080 = '1'
               THEN
                  txt_ := txt_ || '�����������';
               ELSE
                  txt_ := txt_ || '�������������';

                  IF k.s080 = '2'
                  THEN
                     txt_ := txt_ || ' (��� ���������)';
                  ELSIF k.s080 = '3'
                  THEN
                     txt_ := txt_ || ' (��������������)';
                  ELSIF k.s080 = '4'
                  THEN
                     txt_ := txt_ || ' (������������)';
                  ELSIF k.s080 = '5'
                  THEN
                     txt_ := txt_ || ' (�����������)';
                  END IF;
               END IF;
            END IF;

            UPDATE tmp_finrez
               SET s_oldf1 = sn1_ / 100,
                   sq_oldf1 = gl.p_icurval (k.kv, sn1_, dat1_) / 100,
                   s_oldf2 = sn5_ / 100,
                   sq_oldf2 = gl.p_icurval (k.kv, sn5_, dat2_) / 100,
                   s_newf = sn6_ / 100,
                   sq_newf = gl.p_icurval (k.kv, sn6_, dat2_) / 100,
                   s_isp = sn2_ / 100,
                   txt = txt_
             WHERE acc = k.acc;
         END;
      END LOOP;

      -- ������� ����� �� ������� �������� ���� �� ����� ���. �������� ����
      COMMIT;
   END p_finrez;
-----------------------------------

PROCEDURE p_finrez_SB (dat1_ DATE, dat2_ DATE)
IS
   formuser_      NUMBER;
   formuserold_   NUMBER;
   txt_           VARCHAR2 (200);

BEGIN
   BEGIN
      DELETE FROM tmp_finrez;
      commit;
   -- ���� �� ��������
      SELECT userid INTO formuser_
        FROM rez_protocol
       WHERE dat = dat2_ and branch=sys_context('bars_context','user_branch');
   EXCEPTION WHEN NO_DATA_FOUND THEN
      BEGIN
         -- ���� �� ������ �������
         SELECT id INTO formuser_
           FROM rez_form
          WHERE dat = dat2_ and id = userid_;
      EXCEPTION WHEN NO_DATA_FOUND THEN
         -- �� ���� ������� �� ����� ������
         rez1.rez_risk (userid_, dat2_);
         formuser_ := userid_;  -- ������������, ������� ��������� ������ ������
      END;
   END;

--   BEGIN
--      -- ���� �������� �� ���������� ������
--      SELECT userid INTO formuserold_
--      FROM rez_protocol
--      WHERE dat = dat1_;
--   EXCEPTION WHEN NO_DATA_FOUND THEN
      -- �� ����� ����� �������� ������������
--      formuserold_ := formuser_;
--   END;
                              
   FOR k IN (select t.NBS_REZ, t.OB22_REZ, t.kv, t.branch, t.sz,t.szq, 
                    t.s080,t.pr, t.r_s080, ConcatStr(ar.acc) r_acc,
                    ConcatStr(ar.nls) r_nls, count(*) cnt
             from (select o.NBS_REZ, o.OB22_REZ, o.pr, r.KV, 
                          rtrim(substr(r.tobo||'/',1, 
                          instr(r.tobo||'/','/',1,3)-1),'/')||'/' branch, 
                          sum(nvl(r.sz1, sz)) sz, gl.p_icurval (r.kv, 
                          sum(nvl(r.sz1, sz)), dat2_) SZQ, 
                          r.s080 s080,
                          decode(r.s080,1,0,9,0,r.s080) r_s080
                   from tmp_rez_risk r
                   join v_gl ac on r.acc = ac.acc
                   join srezerv_ob22 o on (ac.nbs = o.nbs and ac.ob22 = 
                                           decode(o.ob22,'0',ac.ob22,o.ob22) and 
                                           decode(r.s080,1,1,2) = 
                                           decode(o.s080,'0',
                                           decode(r.s080,1,1,2),o.s080) and 
                                           r.custtype = decode(o.custtype,'0',
                                           r.custtype,o.custtype) and 
                                           r.kv = decode(o.kv,'0',r.kv,o.kv) )
                   where id = nvl(formuser_, user_id) and dat = dat2_ 
                         and nvl(r.sz1, sz) <> 0   
                   group by o.NBS_REZ, o.OB22_REZ, o.pr, r.KV, 
                            rtrim(substr(r.tobo||'/',1,instr(r.tobo||'/','/',
                            1,3)-1),'/')||'/',decode(r.s080,1,1,9,9,2),
                            r.s080) t
             left join v_gl ar on (t.NBS_REZ = ar.nbs and t.OB22_REZ = ar.ob22
                                       and t.KV = ar.kv and t.branch = ar.BRANCH 
                                       and ar.dazs is null and t.r_s080 = 
                                       decode(t.r_s080,0,t.r_s080, 
                                      (select s080 from specparam s 
                                       where s.acc = ar.acc)))
             group by t.NBS_REZ, t.OB22_REZ, t.kv, t.branch, t.sz,t.szq,
                      t.s080,t.pr,t.r_s080)

   LOOP

   DECLARE
      r_old  NUMBER := 0; -- ������ ������������ ������ (���)
      r_oldq NUMBER := 0; -- ������ ������������ ������ (���)
      del    NUMBER := 0; -- ��������.������� (���)
      delq   NUMBER := 0; -- ��������.������� (���)
      r_t    NUMBER := 0; -- ������ ������� (���)
      r_tq   NUMBER := 0; -- ������ ������� (���)
   --   dd     date;

      BEGIN

       if not (k.r_acc is null or instr(k.r_acc,',') > 0) then 
          

         select SNP.fost (k.r_acc, (select caldt_ID from accm_calendar 
                                  where caldt_DATE=dat1_+1),1,7),
                SNP.fost (k.r_acc, (select caldt_ID from accm_calendar 
                                  where caldt_DATE=dat1_)+1,1,8),
                SNP.fost (k.r_acc, (select caldt_ID from accm_calendar 
                                  where caldt_DATE=dat2_),0,7),
                SNP.fost (k.r_acc, (select caldt_ID from accm_calendar 
                                  where caldt_DATE=dat2_),0,8), 
                k.sz  - SNP.fost (k.r_acc, (select caldt_ID from accm_calendar 
                                  where caldt_DATE=dat1_)+1,1,7),
                k.szq - SNP.fost (k.r_acc, (select caldt_ID from accm_calendar 
                                  where caldt_DATE=dat1_)+1,1,8)
         INTO r_old, r_oldq, r_t, r_tq, del, delq
         from dual;
        
         txt_ := '';
    
         IF k.nbs_rez = '2401' THEN
            txt_ := '������� ����������� ';
         ELSIF k.nbs_rez = '2400' THEN
            txt_ := '������� ������������� ';
            IF k.s080 = '2' THEN
               txt_ := txt_ || ' (��� ���������)';
            ELSIF k.s080 = '3' THEN
               txt_ := txt_ || ' (��������������)';
            ELSIF k.s080 = '4' THEN
               txt_ := txt_ || ' (������������)';
            ELSIF k.s080 = '5' THEN
               txt_ := txt_ || ' (�����������)';
            END IF;
         ELSIF k.nbs_rez = '1590' THEN
            txt_ := '������� ������������� ';
            IF k.s080 = '2' THEN
               txt_ := txt_ || ' (��� ���������)';
            ELSIF k.s080 = '3' THEN
               txt_ := txt_ || ' (��������������)';
            ELSIF k.s080 = '4' THEN
               txt_ := txt_ || ' (������������)';
            ELSIF k.s080 = '5' THEN
               txt_ := txt_ || ' (�����������)';
            END IF;
         ELSIF k.nbs_rez = '1591' THEN
            txt_ := '������� ����������� ';
         ELSIF k.nbs_rez = '1592' THEN
            txt_ := '�������� ������������� ';
         ELSIF k.nbs_rez = '1593' THEN
            txt_ := '�������� ����������� ';
         ELSIF k.nbs_rez = '1790' THEN
            txt_ := '������� ������������ ������ ';
         ELSIF k.nbs_rez = '2490' THEN
            txt_ := '������� ������������ ������ ';
         ELSIF k.nbs_rez = '3599' THEN
            txt_ := '������� ������ ����������� ������ ';
         ELSIF k.nbs_rez = '3690' THEN
            txt_ := '������� ��������� ';
            IF k.s080 = '1' THEN
               txt_ := txt_ || '�����������';
            ELSE
               txt_ := txt_ || '�������������';
               IF k.s080 = '2' THEN
                  txt_ := txt_ || ' (��� ���������)';
               ELSIF k.s080 = '3' THEN
                  txt_ := txt_ || ' (��������������)';
               ELSIF k.s080 = '4' THEN
                  txt_ := txt_ || ' (������������)';
               ELSIF k.s080 = '5' THEN
                  txt_ := txt_ || ' (�����������)';
               END IF;
            END IF;
         END IF;
   
         INSERT INTO tmp_finrez 
                 (branch, s080,    kv,     ob22,      nls_r,  acc,    fondid,
                  s_oldf1,sq_oldf1,s_oldf2,sq_oldf2,  s_newf, sq_newf,s_del, 
                  sq_del, txt,     s_isp,   sq_isp, sq_curs)
         VALUES  (k.branch,k.s080, k.kv,   k.ob22_rez,k.r_nls,k.r_acc,null,  
                  r_old,  r_oldq,  r_t,    r_tq,      k.sz,   k.szq,  del,   
                  delq,   txt_,    0,0,0);
       end if;
      END;
   END LOOP;
   INSERT INTO tmp_finrez (branch, s080,kv,  ob22,nls_r,  acc,fondid,
                  s_oldf1,sq_oldf1,s_oldf2,sq_oldf2,  s_newf, sq_newf,s_del, 
                  sq_del, txt,     s_isp,   sq_isp, sq_curs)
   (select rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),
           '/')||'/', sp.s080, a.kv,a.ob22,a.nls,a.acc,null,
           rez.ostc96(to_number(a.acc), dat1_),
           gl.p_icurval (a.kv, rez.ostc96(to_number(a.acc), dat1_), dat1_), 
           rez.ostc96(to_number(a.acc), dat2_),
           gl.p_icurval (a.kv, rez.ostc96(to_number(a.acc), dat2_), dat2_), 
           0,0,-rez.ostc96(to_number(a.acc), dat2_),
           -gl.p_icurval (a.kv, rez.ostc96(to_number(a.acc), dat2_), dat2_), 
           decode(a.nbs,'2400','������� ������������� ',
                        '2401','������� ����������� ',
                        '1590','������� ������������� ',
                        '1591','������� �����������',
                        '1592','�������� ������������� ',
                        '1593','�������� ����������� ',
                        '1790','������� ������������ ������ ',
                        '2490','������� ������������ ������ ',
                        '3599','������� ������ ����������� ������ ',
                        '3690','������� ��������� ','') || 
           decode(sp.s080,2,'��� ���������',
                          3,'��������������',
                          4,'������������',
                          5,'�����������','') ,0,0,0
    from v_gl a
    left join specparam sp on a.acc=sp.acc
    left join srezerv_ob22 o on a.nbs = o.nbs_rez and a.ob22 = o.ob22_rez 
    where a.nbs in ('2400','2401','3690','3599') and a.dazs is null 
          and rez.ostc96(to_number(a.acc), dat2_) <> 0 and 
          not exists (select 1 from tmp_finrez t where a.acc=t.acc )
    group by a.acc, a.ob22, a.nbs, rtrim(substr(a.branch||'/',1,instr(a.branch||'/','/',1,3)-1),'/')||'/' ,
          sp.s080,a.nls, a.kv); 
    COMMIT;
END p_finrez_SB;
----------------------------------------

   FUNCTION r_s080 (fin_ INT, obs_ INT)
      RETURN CHAR
   IS
--pac4. S080
      rs080_   CHAR (1);
   BEGIN
      BEGIN
         NULL;

         SELECT s080
           INTO rs080_
           FROM fin_obs_s080
          WHERE fin = fin_ AND obs = obs_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            rs080_ := NULL;
      END;

      RETURN rs080_;
   END;

   FUNCTION id_nbs (nbs_ CHAR)
      RETURN NUMBER
   IS
--������������� ���� ������� �� ��� ��.
      idr_   INT;
   BEGIN
      BEGIN
         SELECT ID
           INTO idr_
           FROM srez_id_nbs
          WHERE nbs = nbs_;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            idr_ := 0;
      END;

      RETURN idr_;
   END id_nbs;


  FUNCTION id_specrez (p_dt date, p_istval number,p_kv varchar2,
                       p_idr varchar2, p_custtype varchar2) --T 13.01.2009
      RETURN NUMBER
   IS
--������������� ���� ������� �� ��� ��.
      idr_   INT;
   BEGIN
      if p_kv = '980' then return 0; end if;
      --if p_custtype = '1' then return 0; end if;
      BEGIN
         SELECT i.ID
           INTO idr_
           FROM srez_specrez i
          WHERE p_dt between i.DT_BEGIN and i.DT_END and
                decode(p_istval,1,1,0) = i.ISTVAL and
                instr(','||trim(both ',' from trim(i.id_nbs))||',',','||p_idr||',') <> 0 and
                instr(','||trim(both ',' from trim(i.custtype))||',',','||p_custtype||',') <> 0
                and rownum = 1;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            idr_ := 0;
      END;

      RETURN idr_;
   END id_specrez;

   Function f_get_nd(acc_ number) return number is --T 16.06.2009
   nd_ number;
   begin
     nd_ := null;

     IF ndacc_.EXISTS (acc_)
     THEN
        nd_ := ndacc_ (acc_);
     ELSIF ndacc_.COUNT = 0 then --T 15.06.2009
        SELECT MAX (nd)
          INTO nd_
          FROM nd_acc n
         WHERE acc = acc_;

     END IF;

     return nd_;
   end;


-----------
   FUNCTION ostc96 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER
   IS
      ost_   NUMBER;
      ob_    NUMBER;
-- ������� � ������ ��
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      -- to_log (acc_, 'function ostc96', '');
      IF salost_.EXISTS (acc_)
      THEN
         IF salost_ (acc_).fdat = dat_
         THEN
            --     to_log (acc_, '..�������1=', TO_CHAR (salost_ (acc_).ost));
            dbms_output.put_line('..�������1= '|| TO_CHAR (salost_ (acc_).ost));
            RETURN salost_ (acc_).ost;
         END IF;
      END IF;

      BEGIN
         SELECT ostf - dos + kos
           INTO ost_
           FROM saldoa
          WHERE acc = acc_
            AND (acc, fdat) = (SELECT   acc, MAX (fdat)
                                   FROM saldoa
                                  WHERE acc = acc_ AND fdat <= dat_
                               GROUP BY acc);

         to_log (acc_, '..�������2=', TO_CHAR (ost_));
         dbms_output.put_line('..�������2= '|| TO_CHAR (ost_));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            to_log (acc_, '..�������2(������ � saldoa �� �������)=', '0');
            ost_ := 0;
            dbms_output.put_line('..�������2(������ � saldoa �� �������)='|| '0');
      END;

      IF flagkorprov_ = 0
      THEN
         SELECT NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
           INTO ob_
           FROM opldok o, oper p
          WHERE o.REF = p.REF
            AND o.sos = 5
            AND p.vob = 96
            AND o.acc = acc_
            AND o.fdat BETWEEN dat_ + 1 AND dat_ + 20
            --AND p.vdat <= dat_
            AND p.vdat = dat_;

         ost_ := ost_ + ob_;
         to_log (acc_, '..��������������1=', TO_CHAR (ob_));
         dbms_output.put_line('..��������������1='|| TO_CHAR (ob_));
      ELSE
         IF korprov_.EXISTS (acc_)
         THEN
            IF korprov_ (acc_).fdat = dat_
            THEN
               to_log (acc_,
                       '..��������������2=',
                       TO_CHAR (NVL (korprov_ (acc_).ob, 0))
                      );
              dbms_output.put_line('..��������������2='|| TO_CHAR (NVL (korprov_ (acc_).ob, 0)));
               ost_ := ost_ + NVL (korprov_ (acc_).ob, 0);
            ELSE
               SELECT NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
                 INTO ob_
                 FROM opldok o, oper p
                WHERE o.REF = p.REF
                  AND o.sos = 5
                  AND p.vob = 96
                  AND o.acc = acc_
                  AND o.fdat BETWEEN dat_ + 1 AND dat_ + 20
                  AND p.vdat = dat_;

               to_log (acc_, '..��������������3=', TO_CHAR (ob_));
                dbms_output.put_line('..��������������3='|| TO_CHAR (ob_));
               korprov_ (acc_).ob := ob_;
               korprov_ (acc_).fdat := dat_;
               ost_ := ost_ + ob_;
            END IF;
         END IF;
      END IF;

      salost_ (acc_).ost := ost_;
      salost_ (acc_).fdat := dat_;
      RETURN ost_;
   END ostc96;

-------------------------------------
   -- ��� ������������� �������� ������ ������� ������� ��������� ������� � ������ ��������������.
   -- ������� ���������� ������ ��. ����. tmp_crtx
   FUNCTION ostc96_2 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER
   IS
      ost_   NUMBER;
-- ������� � ������ ��
   BEGIN
      BEGIN
         SELECT ostf - dos + kos
           INTO ost_
           FROM saldoa
          WHERE acc = acc_
            AND (acc, fdat) = (SELECT   acc, MAX (fdat)
                                   FROM saldoa
                                  WHERE acc = acc_ AND fdat <= dat_
                               GROUP BY acc);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ost_ := 0;
      END;

      SELECT ost_ + NVL (SUM (DECODE (dk, 1, s, -s)), 0)
        INTO ost_
        FROM tmp_crtx
       WHERE vob = 96 AND acc = acc_ AND fdat > dat_ AND vdat <= dat_;

      RETURN ost_;
   END ostc96_2;

-------------------------------------
   -- ������� ���������� ������� �� ����� �� �������� ����.
   -- ������������ ��� ������ ������������ >31 ���.
   -- ������� �������� ��������, ��������� ��� ������ ������������
   -- ��������� ������ ���������� ������� (�� ���� -31) ����� ����������
   -- �� ������ ���������� ������� ��� ������� ��������.
   -- � ������ ������ ������� �� �������������� �������������� ��������.
   FUNCTION ostc96_3 (acc_ INT, dat_ IN DATE)
      RETURN NUMBER
   IS
      ost_     NUMBER;
      ldate_   DATE;
-- ������� � ������ ��
   BEGIN
      BEGIN
         SELECT ostf - dos + kos
           INTO ost_
           FROM saldoa
          WHERE acc = acc_
            AND (acc, fdat) = (SELECT   acc, MAX (fdat)
                                   FROM saldoa
                                  WHERE acc = acc_ AND fdat <= dat_
                               GROUP BY acc);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            ost_ := 0;
      END;

      ldate_ := LAST_DAY (dat_);
--       IF flagkorprov_ = 0
--       THEN
--          SELECT ost_ + NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0)
--            INTO ost_
--            FROM opldok o, oper p
--           WHERE o.REF = p.REF
--             AND o.sos = 5
--             AND p.vob = 96
--             AND o.acc = acc_
--             AND o.fdat > dat_
--             AND p.vdat <= ldate_;
--       ELSE
--          IF korprov_.EXISTS (acc_)
--          THEN
--             ost_ := ost_ + NVL (korprov_ (acc_), 0);
--          END IF;
--       END IF;

      /* select ost_+ nvl(sum(decode(dk,1,S,-S)),0)
       into ost_
       from tmp_crtx
       where vob = 96
         and acc = ACC_
        and fdat >  dat_
        and vdat <= dat_;*/
      RETURN ost_;
   END ostc96_3;


-------------------------------------
   FUNCTION fin (dat_ DATE)
      RETURN NUMBER
   IS
      sf1_           NUMBER;
      sf2_           NUMBER;
      dat1_          DATE;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      SELECT NVL (MAX (vdat), bankdate)
        INTO dat1_
        FROM oper
       WHERE tt IN ('ARE', 'AR*') AND sos = 5;

      sf1_ := 0;
      sf2_ := 0;

      SELECT NVL (SUM (rez1.ostc96 (acc, dat_)), 0)
        INTO sf1_
        FROM v_gl
       WHERE SUBSTR (nls, 1, 1) IN ('6', '7') AND kv = 980;

      SELECT NVL (SUM (gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_), dat1_)),
                  0
                 )
        INTO sf2_
        FROM v_gl a, srezerv s
       WHERE a.nls = s.s_fond;

      RETURN ((sf1_ + sf2_) / 100);
   END fin;

-----------------------------------
   FUNCTION f_getpar (par_ VARCHAR2)
      RETURN VARCHAR2
   IS
   BEGIN
      IF par_ = 'VERSION'
      THEN
         RETURN version_;
      ELSIF par_ = 'NBSDISCONT'
      THEN
         RETURN nbsdiscont_;
      ELSIF par_ = 'NBSPREMIY'
      THEN
         RETURN nbspremiy_;
      ELSIF par_ = 'USELOG'
      THEN
         RETURN TO_CHAR (uselog_);
      ELSIF par_ = 'CALCDOPPAR'
      THEN
         RETURN TO_CHAR (calcdoppar_);
      END IF;

      RETURN '';
   END f_getpar;

   PROCEDURE p_setpar (par_ VARCHAR2, val_ VARCHAR2)
   IS
   BEGIN
      IF par_ = 'USELOG'
      THEN
         uselog_ := TO_NUMBER (val_);
      ELSIF par_ = 'CALCDOPPAR'
      THEN
         calcdoppar_ := TO_NUMBER (val_);
      END IF;
   END;

-----------------------------------
   FUNCTION header_version
      RETURN VARCHAR2
   IS
   BEGIN
      RETURN f_getpar ('VERSION');
   END;

-----------------------------------
   FUNCTION body_version
      RETURN VARCHAR2
   IS
   BEGIN

      RETURN f_getpar ('VERSION');

   END;

    FUNCTION ca_fq_obesp (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL
   )
      RETURN NUMBER
   IS
      ret_                    NUMBER;
      zal_                   NUMBER;
      vid_zal                number;
   BEGIN
           ret_ := ca_fq_obesp (acc_,
                                dat_ ,
                                mode_,
                                par_ ,
                                pawn_,
                                zal_,
                                vid_zal,
                                null,
                                null
               );
      RETURN ret_;
   END ca_fq_obesp;
-----------------------------------
----������ ����������� (�����)
  FUNCTION ca_fq_obesp1 (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL,
      zal_   out  number,
      vid_zal out  number ,
      disc_     number,
      prm_        number,
      p_ostc        number,
      p_nd          number,
      p_wdate       date

   )
      RETURN NUMBER
   IS
      sk1_                   NUMBER;                -- suma 1 kredita   � ���
      sk2_                   NUMBER;
      sz_                    NUMBER;                -- suma zaloga all  � ���
      sz1_                   NUMBER;                -- suma 1 zaloga    � ���
      zal1_                  NUMBER;
      sk_                    NUMBER := 0;           -- suma kredita all � ���
      sk_s                   NUMBER := 0;
      s080_                  CHAR (1);
      s090_                  CHAR (1);
      r013_                  CHAR (5);
      r031_                  CHAR (1);
      istval_                NUMBER;
      pr_                    NUMBER;
      pr2_                   NUMBER;
      pr3_                   NUMBER;
      pr4_                   NUMBER;
      kvk_                   NUMBER;                        -- ������ �������
      dni_                   NUMBER;
      kk_                    NUMBER (20, 10);
      kk2_                   NUMBER;
      ostc_zo_               NUMBER;       --  ����� ����� ������ � ������ ��
      x9_                    VARCHAR2 (9);
      del_                   NUMBER;
      delq_                  NUMBER;
      nls_                   VARCHAR2 (15);
      kdate_                 DATE;
      wdate_                 DATE;
      k_                     NUMBER          := 1;
      onezals_               NUMBER          := 0;
      discont_               NUMBER          := 0;
      premiy_                NUMBER          := 0;
      datlizd_               DATE;
      datlizn_               NUMBER;
      prliz_                 NUMBER;
      nd_                    NUMBER;
      ret_                   NUMBER;
      sl_                    NUMBER;
      nbs_                   VARCHAR2 (4);
      rnk_                   NUMBER;
      fl_use_as_first_zal_   NUMBER          := 0;
      -- ���� ������������ � ������ ������� ��������� >30 ����
      ern           CONSTANT POSITIVE        := 208;
      err                    EXCEPTION;
      erm                    VARCHAR2 (80);
      cnt                    number;
      r013_2                 varchar2(10);
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;
--      if acc_=80727 then 
--         uselog_:=1; 
--      else 
--         uselog_:=0;
--      end if; 
      to_log (acc_, 'function ca_fq_obesp', '');
      sz_ := 0;
      zal_ := 0;
      vid_zal := null;
      n1_ := 0;
      onezal_.DELETE;

      IF flagallrez_ = 0
      THEN
         p_load_data (dat_, acc_);
      END IF;

     if mode_ = 3 then --������������ �������������� ����� �������
          -- ����� 1-�� ������� �� ���� dat_ (� ��)
          BEGIN
             --��������� �����, �������� �� ������ �����������
             SELECT gl.p_icurval (a.kv,p_ostc, dat_),
                    NVL (p.s080, '1') s080, p.s090, NVL (p.istval, '0') istval,
                    a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1'), a.kv,
                    a.nls, a.nbs, a.rnk, a.nbs || p.r013
               INTO sk1_,
                    s080_, s090_, istval_,
                    r013_, kvk_,
                    nls_, nbs_, rnk_, r013_2
               FROM v_gl a, specparam p
              WHERE a.acc = p.acc(+) AND a.acc = acc_;

             to_log (acc_, 'mod=3,sk1_ ������� �� '||acc_, TO_CHAR (sk1_));
             to_log (acc_, 's080_', s080_);
             to_log (acc_, 'istval_', istval_);
             to_log (acc_, 'r013_', r013_);
             to_log (acc_, 'kvk_', kvk_);
             to_log (acc_, 'nbs_', nbs_);

             IF dodncre_.EXISTS (rnk_) AND s090_ = '4'
             THEN
                to_log (acc_, '���������� ������', '');

                IF mode_ = '3'
                THEN
                   RETURN ABS (sk1_);
                ELSE
                   RETURN 0;
                END IF;
             END IF;

             nd_ := p_nd;
            -- dni_ := dat_ - nvl(p_wdate, dat_);
            if dat_ <= to_date('31122011','ddmmyyyy') then --� ������������ � ���������� �650 (�� 03,11,2009)
                dni_ := greatest(to_date('01102008','ddmmyyyy') - wdate_,0);
            else
                dni_ := dat_ - wdate_;
            end if;

             to_log (acc_, 'mod=3,dni_', dni_);
             
             --������������ ����� �������� �� ������� ����� (���� ��� �� �������� ��� �������� ��������)
             if disc_ is null then 
                discont_ := rez1.ca_fq_discont (acc_, dat_, 1);
             else 
                discont_ := disc_;
             end if;

             --������������ ����� ������ �� ������� ����� (���� ��� �� �������� ��� �������� ��������)
             if prm_ is null then premiy_ := rez1.ca_fq_prem (acc_, dat_, 1);
             else premiy_ := prm_;
             end if;

             to_log (acc_, 'mod=3,discont_', discont_);
             to_log (acc_, 'premiy_', premiy_);
             -- ��������� �� �������
             del_ := 0;
             delq_ := 0;

             IF r013_ = '91299' OR r013_ = '90031' OR sk1_ > 0
             THEN
                to_log (acc_, '���� ��� 9129, 9003 sk1_=0', '');
                sk1_ := 0;
             ELSIF SUBSTR (r013_, 1, 4) IN ('9100', '9129')
             THEN
                to_log (acc_, '���� ��� 9100, 9129 sk1_=50%sk1_', '');
                sk1_ := ROUND (0.5 * sk1_);
             ELSE
                sk1_ := sk1_ + delq_ + discont_ + premiy_; --������� � ������ �������� � ������
             END IF;
             to_log (acc_, 'mod=3,sk1_ ������� �� '||acc_||' +����. � ����.', sk1_);

          EXCEPTION
             WHEN NO_DATA_FOUND
             THEN
                RETURN 0;
          END;
          erm := '1';
     end if;


      -- ��������� ��� �������� ������ �� ���� ������ � ��
      --���� �� ���� ������ ������ ����������� � ������� ����� 
      --� ��� ������� ����� ������ - �� ���� ��������� ������
      FOR k IN (
                SELECT z.ACC,--���� ������
                             --��������� ���� ������ ����������� � ������� ����� 
                       lead(z.acc,1,-1) over(order by z.acc, z.ACCS1 ) next_acc,
                             --���������� ���� ������ ����������� � ������� ����� 
                       lag(z.acc,1,-1) over(order by z.acc, z.ACCS1 ) prev_acc,
                       z.KV,z.NLS,z.NBS,z.OSTC_Z ostc,z.PAWN,z.S031, z.R031,
                       z.PR_12, z.PWN cnt, z.OSTC_s s, z.ACCS1,z.nd, p.s090, 
                       a.kv kv_,a.nls nls_, 
                       a.acc acc_,--������ ��������� �����, ����������� � ������� ����� ������
                       a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1') r013,
                       sum(decode(nvl(dp.pr,'*'),'P',dp.rest,0)) prm,
                       sum(decode(nvl(dp.pr,'*'),'D',dp.rest,0)) dsc,
                       a_z.tobo,DECODE (TRIM (c_z.sed),'91', 
                                DECODE (c_z.custtype, 3, 2, c_z.custtype),
                                c_z.custtype) custtype,a.rnk
                 from REZ_ZAL z,v_gl a,v_gl a_z,customer c_z,specparam p,rez_dp dp
                 where z.accs = acc_ and a.acc = z.accs1 and
                       a_z.acc = z.acc and c_z.rnk = a_z.rnk and
                       a.acc = p.acc(+) and rez1.f_nbs_is_prem (a.nbs) = 0
                       and z.nd = dp.nd(+) and z.OSTC_s <> 0
                group by z.ACC,z.KV,z.NLS,z.NBS,z.OSTC_Z,z.PAWN,z.S031,z.R031,
                         z.PR_12,z.PWN,z.OSTC_s,z.ACCS1,z.nd,p.s090,a.kv,
                         a.nls,a.acc,a.nbs|| DECODE (NVL (p.r013, '1'), '9', 
                         '9', '1'),a_z.tobo,DECODE (TRIM (c_z.sed),'91', 
                         DECODE (c_z.custtype, 3, 2, c_z.custtype),
                         c_z.custtype),a.rnk
      order by z.acc, z.ACCS1
      )
      LOOP
         if erm is null then
              -- ����� 1-�� ������� �� ���� dat_ (� ��)
              BEGIN
                 --��������� �����, �������� �� ������ �����������
                 SELECT gl.p_icurval (a.kv,p_ostc, dat_),
                        NVL (p.s080, '1') s080, p.s090, NVL (p.istval, '0') istval,
                        a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1'), a.kv,
                        a.nls, a.nbs, a.rnk,a.nbs || p.r013
                   INTO sk1_,
                        s080_, s090_, istval_,
                        r013_, kvk_,
                        nls_, nbs_, rnk_, r013_2
                   FROM v_gl a, specparam p
                  WHERE a.acc = p.acc(+) AND a.acc = acc_;

                 to_log (acc_, 'erm null,sk1_ ������� �� '||acc_, TO_CHAR (sk1_));
                 to_log (acc_, 's080_', s080_);
                 to_log (acc_, 'istval_', istval_);
                 to_log (acc_, 'r013_', r013_);
                 to_log (acc_, 'kvk_', kvk_);
                 to_log (acc_, 'nbs_', nbs_);

                 IF dodncre_.EXISTS (rnk_) AND s090_ = '4'
                 THEN
                    to_log (acc_, '���������� ������', '');

                    IF mode_ = '3'
                    THEN
                       RETURN ABS (sk1_);
                    ELSE
                       RETURN 0;
                    END IF;
                 END IF;

                 nd_ := p_nd;
                 to_log (acc_, 'nd_', nd_);
                 --dni_ := dat_ - nvl(p_wdate, dat_);
                 if dat_ <= to_date('31122011','ddmmyyyy') then --� ������������ � ���������� �650 (�� 03,11,2009)
                    dni_ := greatest(to_date('01102008','ddmmyyyy') - wdate_,0);
                 else
                    dni_ := dat_ - wdate_;
                 end if;

                 to_log (acc_, 'dni_', dni_);
                 --������������ ����� �������� �� ������� ����� (���� ��� �� �������� ��� �������� ��������)
                 if disc_ is null then discont_ := rez1.ca_fq_discont (acc_, dat_, 1);
                 else discont_ := disc_;
                 end if;

                 --������������ ����� ������ �� ������� ����� (���� ��� �� �������� ��� �������� ��������)
                 if prm_ is null then premiy_ := rez1.ca_fq_prem (acc_, dat_, 1);
                 else premiy_ := prm_;
                 end if;

                 to_log (acc_, 'erm null,discont_', discont_);
                 to_log (acc_, 'premiy_', premiy_);
                 -- ��������� �� �������
                 del_ := 0;
                 delq_ := 0;

                 --���� ��������� 9129, 9003
                 IF r013_ = '91299' OR r013_ = '90031' OR sk1_ > 0
                 THEN
                    to_log (acc_, '���� ��� 9129, 9003 sk1_=0', '');
                    sk1_ := 0;
                 ELSIF SUBSTR (r013_, 1, 4) IN ('9100', '9129')
                 THEN
                    to_log (acc_, '���� ��� 9100, 9129 sk1_=50%sk1_', '');
                    sk1_ := ROUND (0.5 * sk1_);
                 ELSE
                    sk1_ := sk1_ + delq_ + discont_ + premiy_;--������� � ������ �������� � ������
                 END IF;
                 to_log (acc_, 'erm null,sk1_ ������� �� '||acc_||' +����. � ����.', sk1_);

              EXCEPTION
                 WHEN NO_DATA_FOUND
                 THEN
                    RETURN 0;
              END;
              erm := '1';
         end if;

         --������ ������������ ����� ���� ������
         --�.�. ���������� ���� ������ (k.prev_acc) ��������� �� �������� (k.acc)
         --1. ���������� ��� ������
         --2. ���������� ������� �� ����� ������
         if k.prev_acc <> k.acc then
             --1.
             if k.cnt > 1 then
               vid_zal :=  40;
             else
               vid_zal := k.pawn;
             end if;

             --2.
             IF k.s031 IN ('33', '90') AND par_ = 1
             THEN
                ostc_zo_ := 0;
             ELSE
                ostc_zo_ := gl.p_icurval (k.kv, k.ostc, dat_);
             END IF;

             -- ���� ������ ����������� �������� ���������, � ������ ��������� > 30 ����
             -- �� ���������� ������ ��� ������� �������
             fl_use_as_first_zal_ := 0;
             to_log (acc_, 'k.prev,fl_use_0', TO_CHAR ( fl_use_as_first_zal_));
             ind_:=to_number(TRIM(TO_CHAR(k.acc))||trim(TO_CHAR(nd_)));
             IF prcrezal_.EXISTS (ind_)
             THEN
                -- ���� acc_ �� ��������� � ������� ������������� > 30 ����
                -- ����������� �� �����������
                IF NOT prcrd_.EXISTS (nd_)
                THEN
                   ostc_zo_ := 0;
                   IF k.pr_12=3 THEN 
                      fl_use_as_first_zal_ := 3;
             to_log (acc_, 'k.prev,fl_use_1', TO_CHAR ( fl_use_as_first_zal_));
                   ELSE
                      fl_use_as_first_zal_ := 0;
             to_log (acc_, 'k.prev,fl_use_2', TO_CHAR ( fl_use_as_first_zal_));
                   END IF;
                ELSE
                   IF k.pr_12=3 THEN 
                      fl_use_as_first_zal_ := 3;
             to_log (acc_, 'k.prev,fl_use_3', TO_CHAR ( fl_use_as_first_zal_));
                   ELSE
                      fl_use_as_first_zal_ := 1;
             to_log (acc_, 'k.prev,fl_use_4', TO_CHAR ( fl_use_as_first_zal_));
                   END IF;
                END IF;
             ELSE 
                IF k.pr_12=3 THEN 
                   fl_use_as_first_zal_ := 3;
             to_log (acc_, 'k.prev,fl_use_5', TO_CHAR ( fl_use_as_first_zal_));
                ELSE
                   fl_use_as_first_zal_ := 0;
             to_log (acc_, 'k.prev,fl_use_6', TO_CHAR ( fl_use_as_first_zal_));
                END IF;
             END IF;
             to_log (acc_, 'fl_use_as_first_zal_', TO_CHAR (fl_use_as_first_zal_)||ind_);
             -- ����� ���� ��������, ������� ������� k.NDZ ����� ��� ������
             -- ������ �������������  �2600 �� ����� !
             sk_ := 0;
             discont_ := 0;
             premiy_ := 0;
             to_log (acc_, 'k.prev,ostc_zo_ ����� �������� ������ -'|| k.nls, TO_CHAR (ostc_zo_));
         end if;

           -- ����������� ���������� �� ��������� ������, ������� ��������� � �������� ����� ������
            IF k.s < 0 AND k.r013 <> '91299' AND k.r013 <> '90031'
            THEN
                  -- 1. ������������� ��� ������� ��� ����� ���������� ��������
                  -- 2. � ������� ��������� ��� ���������� ������ (cc_accp.pr_12 =1)
                  --    �� ��������� ����� ����������� � ������ ��������
               to_log (acc_, 'k.prev ������� ��' ||k.nls_||'('||k.acc_||') =', TO_CHAR (k.s));

               discont_ := 0;
               premiy_ := 0;
              
               if k.dsc <> 0 then
                     discont_ := rez1.ca_fq_discont (k.accs1, dat_, 1,999,k.nd,null,gl.p_icurval (k.kv_, k.s,dat_));
               end if;

               if k.prm <> 0 then
                     premiy_ := rez1.ca_fq_prem (k.accs1, dat_, 1,999,k.nd,null,gl.p_icurval (k.kv_, k.s,dat_));
               end if;

               to_log (acc_, 'k.prev,�������/������' ||k.nls_||'('||k.acc_||') =', TO_CHAR (discont_)||'/'||TO_CHAR (premiy_));

               -- ��������� del_ �� �������
               IF SUBSTR (k.nls_, 1, 4) = '2020'
               THEN
                  x9_ := SUBSTR (k.nls_, 6, 9);
                  del_ := 0;
                  delq_ := 0;
               ELSE
                  del_ := 0;
                  delq_ := 0;
               END IF;
               to_log (acc_, 'k.prev,k.acc_', TO_CHAR (k.acc_));
               to_log (acc_, 'k.prev,acc_', TO_CHAR (acc_));
               to_log (acc_, 'k.prev,k.nd', TO_CHAR (k.nd));
               to_log (acc_, 'k.prev,k.rnk', TO_CHAR (k.rnk));
               if prcrezal_.EXISTS (ind_) then
                  to_log (acc_, '������� prcrezal,ind', prcrezal_(ind_));
               end if;
               if przalkl_.EXISTS(k.rnk) then
                  to_log (acc_, '������� przalkl_,rnk', przalkl_(k.rnk));
               end if;

               IF    (k.s090 IS NULL OR k.s090 <> '4')
                  AND ((fl_use_as_first_zal_ = 1
                          AND (k.acc_ = acc_ OR k.nd = nd_))
                          OR  (fl_use_as_first_zal_ = 0
                          AND NOT przalkl_.EXISTS(k.rnk)
                          AND NOT prcrezal_.EXISTS (ind_)
                         ) or fl_use_as_first_zal_ = 3
                      )

               THEN
                  IF SUBSTR (k.r013, 1, 4) IN ('9100', '9129')
                  THEN
                     sk_s := 0.5 * gl.p_icurval (k.kv_, k.s, dat_);
                  ELSE
                     sk_s := gl.p_icurval (k.kv_, k.s, dat_);
                     sk_s := LEAST (sk_s + delq_ + discont_ + premiy_, 0);
                     to_log (acc_, 'k.prev,sk_s ��' ||k.nls_||'=', TO_CHAR (sk_s));
                  END IF;
               END IF;

               sk_ := sk_ + sk_s;
               to_log (acc_, 'k.prev,������� � �����������' ||k.nls_||'('||k.acc_||') =', TO_CHAR (sk_));
               sk_s:=0;   

            END IF;
         -- END IF;

         -- ��������� ������������ ���� ���� ������
         --�.�. ��������� ���� ������ (k.next_acc) ���������� �� �������� (k.acc)
         --������������ ����� ����������� �� ������� ����� ������
         if k.next_acc <> k.acc then

             IF sk_ <> 0
             THEN
                -- ��������� ����� ������
                BEGIN
                   SELECT pr, pr2, pr3, prold
                     INTO pr_, pr2_, pr3_, pr4_
                     FROM cc_pawn_s080
                    WHERE pawn = k.pawn AND s080 = s080_;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      pr_ := 0;
                      pr2_ := 0;
                      pr3_ := 0;
                      pr4_ := 0;
                   if trim(k.pawn) is not null then
                   --� ����������� cc_pawn_s080 �� ������� ������ �� ���� ������ � ��������� �����
                      p_error( 1, substr(k.nls,1,4),null, null, k.kv, k.tobo,
                         substr(k.nls,1,4), null, null, k.custtype*100,
                         k.nls||' (��� ������ ='||k.pawn||', S080 = '||s080_||')',
                         '���. �� = '||k.nd);
                   else
                      p_error( 10, substr(k.nls,1,4),null, null, k.kv, k.tobo,
                         substr(k.nls,1,4), null, null, k.custtype*100,
                         k.nls||' ( ��� ������ )',
                         '���. �� = '||k.nd);
                   end if;
                END;

                -- 15 ������� ����� �� ������_ ��������
                -- 25 �������� ����� �� �������� �� ��������� �����
                -- 26 ������� ����� �� �������� �������� �����
                IF k.s031 = '15'
                THEN
                   IF kvk_ <> k.kv AND k.r031 NOT IN ('2')
                   THEN
                      IF mode_ <> 2
                      THEN
                         pr_ := NVL (pr2_, pr_);
                      END IF;
                   END IF;
                ELSIF k.s031 = '25' or k.s031 = '31' 
                THEN
                   IF kvk_ <> '980'
                   THEN
                      pr_ := NVL (pr2_, pr_);
                   END IF;
                ELSIF k.s031 = '26' AND rezpar2_ <> 1
                THEN
                   IF dni_ / 365 > 2
                   THEN
                      pr_ := 0;
                   END IF;
                ELSIF k.s031 = '31' then
                   if dat_ <= to_date('31122011','ddmmyyyy') --� ������������ � ���������� �650 (�� 03,11,2009)
                   then
                     cnt := 0;
                     --���������������
                     select count(*)
                     into cnt
                     from kl_f3_29
                     where kf in ('00','42') and ddd = '071' and
                           r020 || R012 = r013_2
                     ;
                     if cnt <> 0 then
                     
                           --���� �������������� �����
                         select min(d.obs)
                         into cnt
                         from nd_acc n, cc_deal d
                         where n.acc = acc_ and n.nd = d.nd;
                         
                         if nvl(cnt,0) = 1 then --"������"
                           pr_ := NVL (pr2_, pr_) ;
                         end if;  
                     end if;
                    end if;
                END IF;

                IF mode_ = 1
                THEN
                   --IF k.nbs = '9031'
                   --THEN
                   --   pr_ := 0;
                   --ELSE
                   pr_ := 100;
                ---END IF;
                END IF;

                to_log (acc_, k.nls, '');
                to_log (acc_, 'k.next,pr_', pr_);

                kk_ := sk1_ / sk_;
                zal1_ := ostc_zo_ * kk_ ; --T 24.02.2009
                zal_ := zal_ + ROUND (ABS (zal1_)); --T 24.02.2009


                --������� ���������� �� �������� ����������� � ������
                IF pr_ <> 0
                THEN
                   --����������� ����� ������ �� ������� ����� ������
                   kk_ := sk1_ / sk_;
                   sz1_ := ostc_zo_ * kk_ * pr_ / 100;
                   n1_ := n1_ + 1;
                   onezal_ (n1_).dat := dat_;
                   onezal_ (n1_).userid := userid_;
                   onezal_ (n1_).accs := acc_;
                   onezal_ (n1_).accz := k.acc;
                   onezal_ (n1_).pawn := k.pawn;
                   onezal_ (n1_).s := ROUND (ABS (sz1_));
                   onezal_ (n1_).proc := pr_;
                   sz_ := sz_ + ROUND (ABS (sz1_));
                   to_log (acc_, 'k.next,ostc_zo_ ����� �������� ������ -'|| k.nls, ostc_zo_);
                   to_log (acc_, 'kk_ = sk1_(����)/sk_(����� ���� ������)', kk_);
                   to_log (acc_, 'sz1_ ����� �� �������� ����� ������ = ostc_zo_*kk_*pr_/100', sz1_);
                   to_log (acc_, 'sz_ ����� �� ���� �������', sz_);
                END IF;
             END IF;
         end if;
      END LOOP;

     --������ ��������� � ��������
      IF SUBSTR (nls_, 1, 4) = '2071' AND rezpar3_ = '1'
      THEN
         -- ���������� ������ ������� �� ���������� 411
         -- � ������ ������ ���� ������� ������� �������� ��������������

         -- ���� ������� - ���� �� ������������� ������� �� ����� ��
         -- �������� ����
         -- ��� - ������ 365 ����
         SELECT MIN (fdat)
           INTO datlizd_
           FROM saldoa
          WHERE acc = acc_ AND fdat <= dat_ AND dos <> 0;

         IF datlizd_ IS NULL OR dat_ - datlizd_ <= 365
         THEN
            datlizn_ := 0;
         ELSIF dat_ - datlizd_ <= 730
         THEN
            datlizn_ := 1;
         ELSIF dat_ - datlizd_ > 730
         THEN
            datlizn_ := 2;
         ELSE
            datlizn_ := NULL;
         END IF;

         prliz_ := 0;

         IF datlizn_ IS NOT NULL
         THEN
            IF s080_ = 1
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 80;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 65;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 50;
               END IF;
            ELSIF s080_ = 2
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 80;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 65;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 50;
               END IF;
            ELSIF s080_ = 3
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 60;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 50;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 35;
               END IF;
            ELSIF s080_ = 4
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 20;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 10;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 5;
               END IF;
            ELSIF s080_ = 5
            THEN
               prliz_ := 0;
            END IF;
         END IF;

         BEGIN
            SELECT gl.p_icurval (kvk_, s.dos, s.fdat)
              INTO sl_
              FROM saldoa s
             WHERE s.fdat = datlizd_ AND acc = acc_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sl_ := 0;
         END;

         n1_ := n1_ + 1;
         onezal_ (n1_).dat := dat_;
         onezal_ (n1_).userid := userid_;
         onezal_ (n1_).accs := acc_;
         onezal_ (n1_).accz := acc_;
         onezal_ (n1_).pawn := '30';
         onezal_ (n1_).s := ROUND (ABS (sl_ * prliz_ / 100));
         onezal_ (n1_).proc := prliz_;
         sz_ := sz_ + ROUND (ABS (sl_ * prliz_ / 100));
      END IF;

      -- ������ ������������ �����������
      IF ABS (sk1_) < ABS (sz_)
      THEN
         k_ := ABS (sk1_ / sz_);
      END IF;

      --������� ���������� �� ����������� � ������
      IF onezal_.COUNT > 0 AND mode_ IN (0, 1)
      THEN
         FOR p IN onezal_.FIRST .. onezal_.LAST
         LOOP
            n_ := n_ + 1;
            allzal_ (n_).dat := dat_;
            allzal_ (n_).userid := userid_;
            allzal_ (n_).accs := onezal_ (p).accs;
            allzal_ (n_).accz := onezal_ (p).accz;
            allzal_ (n_).pawn := onezal_ (p).pawn;
            allzal_ (n_).s := onezal_ (p).s;
            allzal_ (n_).proc := onezal_ (p).proc;
            onezals_ := onezals_ + ROUND (onezal_ (p).s * k_);

            IF p = onezal_.LAST AND k_ <> 1
            THEN
               allzal_ (n_).spriv :=
                            ROUND (onezal_ (p).s * k_)
                          + (onezals_ - ABS (sk1_));
            ELSE
               allzal_ (n_).spriv := ROUND (onezal_ (p).s * k_);
            END IF;

            onezal_ (p).spriv := allzal_ (n_).spriv;

            IF mode_ = 1
            THEN
               IF allzal_.COUNT > 0 AND allzal_.EXISTS (n_)
               THEN
                  allzal_.DELETE (n_);
               END IF;
            END IF;
         END LOOP;
      END IF;

      IF pawn_ IS NULL
      THEN
         to_log (acc_, 'if pawn is null ', ret_);

         IF mode_ = 3
         THEN
            ret_ := GREATEST (ABS (sk1_) - sz_, 0);
         ELSE
            ret_ := ABS (sz_);
         END IF;
      ELSE
         ret_ := 0;

         IF onezal_.COUNT > 0
         --AND mode_ = 0
         THEN
            to_log (acc_, 'onezal_ loop ', ret_);

            FOR p IN onezal_.FIRST .. onezal_.LAST
            LOOP
               to_log (acc_, 'p ', p);
               to_log (acc_, 'onezal_ (p).spriv', onezal_ (p).spriv);
               to_log (acc_, 'onezal_ (p).s', onezal_ (p).s);

               IF onezal_ (p).pawn = pawn_
               THEN
                  IF mode_ = 0
                  THEN
                     ret_ := ret_ + onezal_ (p).spriv;
                  ELSE
                     ret_ := ret_ + onezal_ (p).s;
                  END IF;

                  to_log (acc_, 'ret_', ret_);
               END IF;
            END LOOP;
         END IF;
      END IF;

      to_log (acc_, 'return ret_', ret_);
      RETURN ret_;
   END ca_fq_obesp1;


-----------------------------------
--������ ����������� (������)
  FUNCTION ca_fq_obesp (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      pawn_        NUMBER DEFAULT NULL,
      zal_   out  number,
      vid_zal out  number ,
      disc_     number,
      prm_        number
   )
      RETURN NUMBER
   IS
      sk1_                   NUMBER;                -- suma 1 kredita   � ���
      sk2_                   NUMBER;
      sz_                    NUMBER;                -- suma zaloga all  � ���
      sz1_                   NUMBER;                -- suma 1 zaloga    � ���
      zal1_                  NUMBER;
      sk_                    NUMBER:=0;                -- suma kredita all � ���
      s080_                  CHAR (1);
      s090_                  CHAR (1);
      r013_                  CHAR (5);
      r031_                  CHAR (1);
      istval_                NUMBER;
      pr_                    NUMBER;
      pr2_                   NUMBER;
      pr3_                   NUMBER;
      pr4_                   NUMBER;
      kvk_                   NUMBER;                        -- ������ �������
      dni_                   NUMBER;
      kk_                    NUMBER (20, 10);
      kk2_                   NUMBER;
      ostc_zo_               NUMBER;       --  ����� ����� ������ � ������ ��
      x9_                    VARCHAR2 (9);
      del_                   NUMBER;
      delq_                  NUMBER;
      nls_                   VARCHAR2 (15);
      kdate_                 DATE;
      wdate_                 DATE;
      k_                     NUMBER          := 1;
      onezals_               NUMBER          := 0;
      discont_               NUMBER          := 0;
      premiy_                NUMBER          := 0;
      datlizd_               DATE;
      datlizn_               NUMBER;
      prliz_                 NUMBER;
      nd_                    NUMBER;
      ret_                   NUMBER;
      sl_                    NUMBER;
      nbs_                   VARCHAR2 (4);
      rnk_                   NUMBER;
      fl_use_as_first_zal_   NUMBER          := 0;
      -- ���� ������������ � ������ ������� ��������� >30 ����
      ern           CONSTANT POSITIVE        := 208;
      err                    EXCEPTION;
      erm                    VARCHAR2 (80);
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      to_log (acc_, 'function ca_fq_obesp', '');
      sz_ := 0;
      zal_ := 0;
      vid_zal := null;
      n1_ := 0;
      onezal_.DELETE;

      IF flagallrez_ = 0
      THEN
         p_load_data (dat_, acc_);
      END IF;

     if mode_ = 3 then --������������ �������������� ����� �������
          -- ����� 1-�� ������� �� ���� dat_ (� ��)
          BEGIN
             SELECT gl.p_icurval (a.kv,
                                   rez1.ostc96 (a.acc, dat_),
                                  dat_
                                 ),
                    NVL (p.s080, '1') s080, p.s090, NVL (p.istval, '0') istval,
                    a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1'), a.kv,
                    a.nls, a.nbs, a.rnk
               INTO sk1_,
                    s080_, s090_, istval_,
                    r013_, kvk_,
                    nls_, nbs_, rnk_
               FROM v_gl a, specparam p
              WHERE a.acc = p.acc(+) AND a.acc = acc_;

             to_log (acc_, 'sk1_ ������� �� '||acc_, TO_CHAR (sk1_));
             to_log (acc_, 's080_', s080_);
             to_log (acc_, 'istval_', istval_);
             to_log (acc_, 'r013_', r013_);
             to_log (acc_, 'kvk_', kvk_);
             to_log (acc_, 'nbs_', nbs_);

             IF dodncre_.EXISTS (rnk_) AND s090_ = '4'
             THEN
                to_log (acc_, '���������� ������', '');

                IF mode_ = '3'
                THEN
                   RETURN ABS (sk1_);
                ELSE
                   RETURN 0;
                END IF;
             END IF;

             nd_ := null;
             BEGIN
                nd_ := f_get_nd(acc_); --T 16.06.2009
                /*IF ndacc_.EXISTS (acc_)
                THEN
                   nd_ := ndacc_ (acc_);
                ELSIF ndacc_.COUNT = 0 then --T 15.06.2009
                   SELECT MAX (nd)
                     INTO nd_
                     FROM nd_acc
                    WHERE acc = acc_;
                END IF;*/

                SELECT wdate
                  INTO wdate_
                  FROM cc_add
                 WHERE nd = nd_ AND adds = 0;

                dni_ := dat_ - wdate_;
             EXCEPTION
                WHEN OTHERS
                THEN
                   wdate_ := NULL;
                   dni_ := 0;
             END;

             to_log (acc_, 'dni_', dni_);
             if disc_ is null then discont_ := rez1.ca_fq_discont (acc_, dat_, 1);
             else discont_ := disc_;
             end if;

             if prm_ is null then premiy_ := rez1.ca_fq_prem (acc_, dat_, 1);
             else premiy_ := prm_;
             end if;

             to_log (acc_, 'discont_', discont_);
             to_log (acc_, 'premiy_', premiy_);
             -- ��������� �� �������
             del_ := 0;
             delq_ := 0;
             sk1_ := sk1_ + delq_ + discont_ + premiy_;
             to_log (acc_, 'sk1_ ������� �� '||acc_||' +����. � ����.', sk1_);

             IF r013_ = '91299' OR r013_ = '90031' OR sk1_ > 0
             THEN
                to_log (acc_, '���� ��� 9129, 9003 sk1_=0', '');
                sk1_ := 0;
             END IF;

             IF SUBSTR (r013_, 1, 4) IN ('9100', '9129')
             THEN
                to_log (acc_, '���� ��� 9100, 9129 sk1_=50%sk1_', '');
                sk1_ := ROUND (0.5 * sk1_);
             END IF;
          EXCEPTION
             WHEN NO_DATA_FOUND
             THEN
                RETURN 0;
          END;
          erm := '1';
     end if;


      -- ��������� ��� �������� ������ �� ���� ������ � ��
      FOR k IN (SELECT z.acc, a.kv, a.nls, a.nbs,
                        rez1.ostc96 (a.acc, dat_) ostc,
                       sz.pawn, c.s031, k.r031, z.pr_12
                       , count(distinct sz.pawn) over() cnt --T 10.06.2009
                  FROM cc_accp z,
                       v_gl a,
                       pawn_acc sz,
                       cc_pawn c,
                       kl_r030 k
                 WHERE z.accs = acc_
                   AND z.acc = a.acc
                   AND sz.acc = z.acc
                   AND c.pawn = sz.pawn
                   AND TO_NUMBER (k.r030) = a.kv
                   --T 19.03.2009
                   and (par_ob22 = 0 or
                        --��� ��������� �� ��������� �������� (9031)
                       (par_ob22 = 1 and a.nbs <> '9031')
                    -- and a.nbs <> '9031'
                      )
                  /* select t.*, rez1.ostc96 (t.acc, dat_) ostc
                   FROM TABLE (CAST (zal_tbl AS t_zal) ) t
                   where t.accs = acc_  */
                   )
      LOOP
         if erm is null then
              -- ����� 1-�� ������� �� ���� dat_ (� ��)
              BEGIN
                 SELECT gl.p_icurval (a.kv,
                                       rez1.ostc96 (a.acc, dat_),
                                      dat_
                                     ),
                        NVL (p.s080, '1') s080, p.s090, NVL (p.istval, '0') istval,
                        a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1'), a.kv,
                        a.nls, a.nbs, a.rnk
                   INTO sk1_,
                        s080_, s090_, istval_,
                        r013_, kvk_,
                        nls_, nbs_, rnk_
                   FROM v_gl a, specparam p
                  WHERE a.acc = p.acc(+) AND a.acc = acc_;

                 to_log (acc_, 'sk1_ ������� �� '||acc_, TO_CHAR (sk1_));
                 to_log (acc_, 's080_', s080_);
                 to_log (acc_, 'istval_', istval_);
                 to_log (acc_, 'r013_', r013_);
                 to_log (acc_, 'kvk_', kvk_);
                 to_log (acc_, 'nbs_', nbs_);

                 IF dodncre_.EXISTS (rnk_) AND s090_ = '4'
                 THEN
                    to_log (acc_, '���������� ������', '');

                    IF mode_ = '3'
                    THEN
                       RETURN ABS (sk1_);
                    ELSE
                       RETURN 0;
                    END IF;
                 END IF;

                 nd_ := null;
                 BEGIN
                    nd_ := f_get_nd(acc_); --T 16.06.2009
                    /*IF ndacc_.EXISTS (acc_)
                    THEN
                       nd_ := ndacc_ (acc_);
                    ELSIF ndacc_.COUNT = 0 then --T 15.06.2009
                       SELECT MAX (nd)
                         INTO nd_
                         FROM nd_acc
                        WHERE acc = acc_;
                    END IF;*/

                    SELECT wdate
                      INTO wdate_
                      FROM cc_add
                     WHERE nd = nd_ AND adds = 0;

                    dni_ := dat_ - wdate_;
                 EXCEPTION
                    WHEN OTHERS
                    THEN
                       wdate_ := NULL;
                       dni_ := 0;
                 END;

                 to_log (acc_, 'dni_', dni_);
                 if disc_ is null then discont_ := rez1.ca_fq_discont (acc_, dat_, 1);
                 else discont_ := disc_;
                 end if;

                 if prm_ is null then premiy_ := rez1.ca_fq_prem (acc_, dat_, 1);
                 else premiy_ := prm_;
                 end if;

                 to_log (acc_, 'discont_', discont_);
                 to_log (acc_, 'premiy_', premiy_);
                 -- ��������� �� �������
                 del_ := 0;
                 delq_ := 0;
                 sk1_ := sk1_ + delq_ + discont_ + premiy_;
                 to_log (acc_, 'sk1_ ������� �� '||acc_||' +����. � ����.', sk1_);

                 IF r013_ = '91299' OR r013_ = '90031' OR sk1_ > 0
                 THEN
                    to_log (acc_, '���� ��� 9129, 9003 sk1_=0', '');
                    sk1_ := 0;
                 END IF;

                 IF SUBSTR (r013_, 1, 4) IN ('9100', '9129')
                 THEN
                    to_log (acc_, '���� ��� 9100, 9129 sk1_=50%sk1_', '');
                    sk1_ := ROUND (0.5 * sk1_);
                 END IF;
              EXCEPTION
                 WHEN NO_DATA_FOUND
                 THEN
                    RETURN 0;
              END;
              erm := '1';
         end if;

         if k.cnt > 1 then
           vid_zal :=  40;
         else
           vid_zal := k.pawn;
         end if;

         IF k.s031 IN ('33', '90') AND par_ = 1
         THEN
            ostc_zo_ := 0;
         ELSE
            ostc_zo_ := gl.p_icurval (k.kv, k.ostc, dat_);
         END IF;

         -- ���� ������ ����������� �������� ���������, � ������ ��������� > 30 ����
         -- �� ���������� ������ ��� ������� �������
         fl_use_as_first_zal_ := 0;
         ind_:=to_number(TRIM(TO_CHAR(k.acc))||trim(TO_CHAR(nd_)));
         IF prcrezal_.EXISTS (ind_)
         THEN
            -- ���� acc_ �� ��������� � ������� ������������� > 30 ����
            -- ����������� �� �����������
            IF NOT prcrd_.EXISTS (nd_)
            THEN
               ostc_zo_ := 0;
               fl_use_as_first_zal_ := 0;
            ELSE
               fl_use_as_first_zal_ := 1;
            END IF;
         END IF;
           to_log (acc_, 'fl_use_as_first_zal_', TO_CHAR (fl_use_as_first_zal_)||ind_); 
         -- ����� ���� ��������, ������� ������� k.NDZ ����� ��� ������
         -- ������ �������������  �2600 �� ����� !
         sk_ := 0;
         discont_ := 0;
         premiy_ := 0;
         to_log (acc_, 'ostc_zo_ ����� �������� ������ -'|| k.nls, TO_CHAR (ostc_zo_));

         FOR k1 IN (SELECT rez1.ostc96 (a.acc, dat_) s,
                           --n.nd,
                           f_get_nd(a.acc) nd, --T 16.06.2009
                           p.s090, a.kv,
                           a.nls, a.acc,
                           a.nbs
                           || DECODE (NVL (p.r013, '1'), '9', '9', '1') r013
                      FROM v_gl a,
                           specparam p
                     WHERE a.acc IN (SELECT accs
                                       FROM cc_accp
                                      WHERE acc = k.acc)
                       AND a.acc = p.acc(+)
                       AND f_nbs_is_prem (a.nbs) = 0)
         LOOP
            -- IF    fl_use_as_first_zal_ = 1 AND (k1.acc = acc_ or k1.nd=nd_)
            --    OR fl_use_as_first_zal_ = 0 and not prcrezal_.EXISTS (k.acc,k.nd)
            -- THEN
                --       to_log (acc_, '*** 1', '');
            IF k1.s < 0 AND k1.r013 <> '91299' AND k1.r013 <> '90031'
            THEN                                                
--            to_log (acc_, '*** 1', '');
                  -- 1. ������������� ��� ������� ��� ����� ���������� ��������
                  -- 2. � ������� ��������� ��� ���������� ������ (cc_accp.pr_12 =1)
                  --    �� ��������� ����� ����������� � ������ ��������
               to_log (acc_, '  ������� ��' ||k1.nls||'('||k1.acc||') =', TO_CHAR (k1.s));
               IF     (k1.s090 IS NULL OR k1.s090 <> '4')
                  AND (       fl_use_as_first_zal_ = 1
                          AND (k1.acc = acc_ OR k1.nd = nd_)
--                       OR     fl_use_as_first_zal_ = 0
--                          AND NOT prcrezal_.EXISTS (k.acc,k.nd)
                      )
               THEN
                  IF SUBSTR (k1.r013, 1, 4) IN ('9100', '9129')
                  THEN
                     sk_ := sk_ + 0.5 * gl.p_icurval (k1.kv, k1.s, dat_);
                  ELSE
                     sk_ := sk_ + gl.p_icurval (k1.kv, k1.s, dat_);
                  END IF;
               END IF;

               to_log (acc_, '  ������� � �����������' ||k1.nls||'('||k1.acc||') =', TO_CHAR (sk_));

               discont_ := rez1.ca_fq_discont (k1.acc, dat_, 1);
               premiy_ := rez1.ca_fq_prem (k1.acc, dat_, 1);

               -- ��������� del_ �� �������
               IF SUBSTR (k1.nls, 1, 4) = '2020'
               THEN
                  x9_ := SUBSTR (k1.nls, 6, 9);
                  del_ := 0;
                  delq_ := 0;
               ELSE
                  del_ := 0;
                  delq_ := 0;
               END IF;

               sk_ := LEAST (sk_ + delq_ + discont_ + premiy_, 0);
               to_log (acc_, 'sk_ ��' ||k1.nls||'=', TO_CHAR (sk_));
            END IF;
         -- END IF;
         END LOOP;

         IF sk_ <> 0
         THEN
            -- ��������� ����� ������
            BEGIN
               SELECT pr, pr2, pr3, prold
                 INTO pr_, pr2_, pr3_, pr4_
                 FROM cc_pawn_s080
                WHERE pawn = k.pawn AND s080 = s080_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  pr_ := 0;
                  pr2_ := 0;
                  pr3_ := 0;
                  pr4_ := 0;
            END;

            -- 15 ������� ����� �� ������_ ��������
            -- 25 �������� ����� �� �������� �� ��������� �����
            -- 26 ������� ����� �� �������� �������� �����
            IF k.s031 = '15'
            THEN
               IF kvk_ <> k.kv AND k.r031 NOT IN ('2')
               THEN
                  IF mode_ <> 2
                  THEN
                     pr_ := NVL (pr2_, pr_);
                  END IF;
               END IF;
            ELSIF k.s031 = '25'
            THEN
               IF kvk_ <> '980'
               THEN
                  pr_ := NVL (pr2_, pr_);
               END IF;
            ELSIF k.s031 = '26' AND rezpar2_ <> 1
            THEN
               IF dni_ / 365 > 2
               THEN
                  pr_ := 0;
               END IF;
            END IF;

            IF mode_ = 1
            THEN
               --IF k.nbs = '9031'
               --THEN
               --   pr_ := 0;
               --ELSE
               pr_ := 100;
            ---END IF;
            END IF;

            to_log (acc_, k.nls, '');
            to_log (acc_, 'pr_', pr_);

            kk_ := sk1_ / sk_;
            zal1_ := ostc_zo_ * kk_ ; --T 24.02.2009
            zal_ := zal_ + ROUND (ABS (zal1_)); --T 24.02.2009


            IF pr_ <> 0
            THEN
               kk_ := sk1_ / sk_;
               sz1_ := ostc_zo_ * kk_ * pr_ / 100;
               n1_ := n1_ + 1;
               onezal_ (n1_).dat := dat_;
               onezal_ (n1_).userid := userid_;
               onezal_ (n1_).accs := acc_;
               onezal_ (n1_).accz := k.acc;
               onezal_ (n1_).pawn := k.pawn;
               onezal_ (n1_).s := ROUND (ABS (sz1_));
               onezal_ (n1_).proc := pr_;
               sz_ := sz_ + ROUND (ABS (sz1_));
               to_log (acc_, 'ostc_zo_ ����� �������� ������ -'|| k.nls, ostc_zo_);
               to_log (acc_, 'kk_ = sk1_(����)/sk_(����� ���� ������)', kk_);
               to_log (acc_, 'sz1_ ����� �� �������� ����� ������ = ostc_zo_*kk_*pr_/100', sz1_);
               to_log (acc_, 'sz_ ����� �� ���� �������', sz_);
            END IF;
         END IF;
      END LOOP;

      IF SUBSTR (nls_, 1, 4) = '2071' AND rezpar3_ = '1'
      THEN
         -- ���������� ������ ������� �� ���������� 411
         -- � ������ ������ ���� ������� ������� �������� ��������������

         -- ���� ������� - ���� �� ������������� ������� �� ����� ��
         -- �������� ����
         -- ��� - ������ 365 ����
         SELECT MIN (fdat)
           INTO datlizd_
           FROM saldoa
          WHERE acc = acc_ AND fdat <= dat_ AND dos <> 0;

         IF datlizd_ IS NULL OR dat_ - datlizd_ <= 365
         THEN
            datlizn_ := 0;
         ELSIF dat_ - datlizd_ <= 730
         THEN
            datlizn_ := 1;
         ELSIF dat_ - datlizd_ > 730
         THEN
            datlizn_ := 2;
         ELSE
            datlizn_ := NULL;
         END IF;

         prliz_ := 0;

         IF datlizn_ IS NOT NULL
         THEN
            IF s080_ = 1
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 80;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 65;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 50;
               END IF;
            ELSIF s080_ = 2
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 80;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 65;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 50;
               END IF;
            ELSIF s080_ = 3
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 60;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 50;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 35;
               END IF;
            ELSIF s080_ = 4
            THEN
               IF datlizn_ = 0
               THEN
                  prliz_ := 20;
               ELSIF datlizn_ = 1
               THEN
                  prliz_ := 10;
               ELSIF datlizn_ = 2
               THEN
                  prliz_ := 5;
               END IF;
            ELSIF s080_ = 5
            THEN
               prliz_ := 0;
            END IF;
         END IF;

         BEGIN
            SELECT gl.p_icurval (kvk_, s.dos, s.fdat)
              INTO sl_
              FROM saldoa s
             WHERE s.fdat = datlizd_ AND acc = acc_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sl_ := 0;
         END;

         n1_ := n1_ + 1;
         onezal_ (n1_).dat := dat_;
         onezal_ (n1_).userid := userid_;
         onezal_ (n1_).accs := acc_;
         onezal_ (n1_).accz := acc_;
         onezal_ (n1_).pawn := '30';
         onezal_ (n1_).s := ROUND (ABS (sl_ * prliz_ / 100));
         onezal_ (n1_).proc := prliz_;
         sz_ := sz_ + ROUND (ABS (sl_ * prliz_ / 100));
      END IF;

      -- ������ ������������ �����������
      IF ABS (sk1_) < ABS (sz_)
      THEN
         k_ := ABS (sk1_ / sz_);
      END IF;

      IF onezal_.COUNT > 0 AND mode_ IN (0, 1)
      THEN
         FOR p IN onezal_.FIRST .. onezal_.LAST
         LOOP
            n_ := n_ + 1;
            allzal_ (n_).dat := dat_;
            allzal_ (n_).userid := userid_;
            allzal_ (n_).accs := onezal_ (p).accs;
            allzal_ (n_).accz := onezal_ (p).accz;
            allzal_ (n_).pawn := onezal_ (p).pawn;
            allzal_ (n_).s := onezal_ (p).s;
            allzal_ (n_).proc := onezal_ (p).proc;
            onezals_ := onezals_ + ROUND (onezal_ (p).s * k_);

            IF p = onezal_.LAST AND k_ <> 1
            THEN
               allzal_ (n_).spriv :=
                            ROUND (onezal_ (p).s * k_)
                          + (onezals_ - ABS (sk1_));
            ELSE
               allzal_ (n_).spriv := ROUND (onezal_ (p).s * k_);
            END IF;

            onezal_ (p).spriv := allzal_ (n_).spriv;

            IF mode_ = 1
            THEN
               IF allzal_.COUNT > 0 AND allzal_.EXISTS (n_)
               THEN
                  allzal_.DELETE (n_);
               END IF;
            END IF;
         END LOOP;
      END IF;

      IF pawn_ IS NULL
      THEN
         to_log (acc_, 'if pawn is null ', ret_);

         IF mode_ = 3
         THEN
            ret_ := GREATEST (ABS (sk1_) - sz_, 0);
         ELSE
            ret_ := ABS (sz_);
         END IF;
      ELSE
         ret_ := 0;

         IF onezal_.COUNT > 0
         --AND mode_ = 0
         THEN
            to_log (acc_, 'onezal_ loop ', ret_);

            FOR p IN onezal_.FIRST .. onezal_.LAST
            LOOP
               to_log (acc_, 'p ', p);
               to_log (acc_, 'onezal_ (p).spriv', onezal_ (p).spriv);
               to_log (acc_, 'onezal_ (p).s', onezal_ (p).s);

               IF onezal_ (p).pawn = pawn_
               THEN
                  IF mode_ = 0
                  THEN
                     ret_ := ret_ + onezal_ (p).spriv;
                  ELSE
                     ret_ := ret_ + onezal_ (p).s;
                  END IF;

                  to_log (acc_, 'ret_', ret_);
               END IF;
            END LOOP;
         END IF;
      END IF;

      to_log (acc_, 'return ret_', ret_);
      RETURN ret_;
   END ca_fq_obesp;

-----------------------------------
   FUNCTION ca_fq_obesp_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT NVL (SUM (rez1.ca_fq_obesp (a.acc, dat_, 0, NULL, pawn_)), 0)
        INTO s_
        FROM v_gl a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      RETURN s_;
   END;

-----------------------------------
   FUNCTION ca_fq_discont (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL,
      p_nd         number DEFAULT NULL,
      p_skqall     number DEFAULT NULL,
      p_skq        number DEFAULT NULL

   )
      RETURN NUMBER
   IS
      skqall_        NUMBER;
      skq_           NUMBER;
      sdqall_        NUMBER;
      sdq_           NUMBER        := 0;
      nd_            NUMBER;
      n1_            NUMBER;
      kv_            NUMBER;
      x9_            VARCHAR2 (9);
      accd_          NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);

      TYPE CurTyp IS REF CURSOR;
      c0 CurTyp;

      BEGIN

      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      IF rezpar4_ = '1'
      THEN
         RETURN 0;
      END IF;

      ndiscont1_ := 0;
      onedisc_.DELETE;
      
      --1. ���������� ����� ����� �������� �� ���. ������ �������� - skqall_ 
      --   � ������� �� ������� ����� - skq_

      if par_ = 999 then
        --������� ������������� �� ������� REZ_ACC
        nd_ := p_nd;
        if skqall_ is null then
      if rez_disc_ = 1 then
          SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, a.lim,
                                              dat_)
                               )
                          ),
                      0
                     )
            INTO skqall_
            FROM REZ_ACC a,REZ_ACC a1
           WHERE a.rnk = nd_
                 AND a.tip IN ('SS', 'SP', 'SL')
                 AND f_nbs_is_disc (a.nbs) = 0 
                 and a1.acc=acc_ and substr(a1.nbs,1,3)=substr(a.nbs,1,3) 
                 and a1.kv=a.kv;
    to_log (acc_,'REZ_ACC1 ���.S �� ���.skqall_=', skqall_);
       else
          SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, a.lim,
                                              dat_)
                               )
                          ),
                      0
                     )
            INTO skqall_
            FROM REZ_ACC a
           WHERE a.rnk = nd_
                 AND a.tip IN ('SS', 'SP', 'SL')
                 AND f_nbs_is_disc (a.nbs) = 0;
    to_log (acc_,'REZ_ACC0 ���.S �� ���.skqall_=', skqall_);
        end if;
        else
          skqall_ := abs(p_skqall);
    to_log (acc_,'6 ���.���.S �� ���.skqall_=', skqall_);
        end if;
        skq_ := abs(p_skq);
    to_log (acc_,'7 ���.skq_=', skq_);
      else
          --������� ������������� �� ������� v_gl
          nd_ := f_get_nd(acc_); --T 16.06.2009

          --���� �� �� ������� ����� ��������
          SELECT count(*)
            INTO sdqall_
            FROM v_gl a, nd_acc n
           WHERE a.acc = n.acc AND f_nbs_is_disc (a.nbs) = 1 AND n.nd = nd_;
    to_log (acc_,'���� ������� sdqall_=', sdqall_);
          SELECT a.nbs INTO erm
          FROM v_gl a
          WHERE acc = acc_ ;

    to_log (acc_,'NBS �� acc_=', erm);
          --��� ������ ��������
          if sdqall_ = 0 and erm not in ('2020', '2026') then
    to_log (acc_,'��� ������ ��������',0);
             return 0;
          end if;

          erm :='';
          sdqall_ := 0;

          --���������� ����� ����� �������� �� ���. ������ �������� - skqall_
          if rez_disc_ = 1 then
             SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_),dat_))),0) 
             INTO skqall_
             FROM v_gl a, nd_acc n,v_gl a1
             WHERE a1.acc=acc_ and substr(a1.nbs,1,3)=substr(a.nbs,1,3) 
                   and a1.kv=a.kv and a.acc = n.acc 
                   AND a.tip IN ('SS', 'SP', 'SL') 
                   AND f_nbs_is_disc (a.nbs) = 0  AND n.nd = nd_;
   to_log (acc_,'v_gl1 ���.S �� ���.skqall_=', skqall_);
          else 
             SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_),dat_))),0)
             INTO skqall_
             FROM v_gl a, nd_acc n
             WHERE a.acc = n.acc AND a.tip IN ('SS', 'SP', 'SL')
                   AND f_nbs_is_disc (a.nbs) = 0 AND n.nd = nd_;
   to_log (acc_,'v_gl0 ���.S �� ���.skqall_=', skqall_);
          end if;

          if skqall_ = 0 then return 0;  end if;

          -- ������� �� ������� �����
          BEGIN
             SELECT ABS (gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_), dat_))
               INTO skq_
               FROM v_gl a
              WHERE acc = acc_ AND a.tip IN ('SS', 'SP', 'SL');
   to_log (acc_,'�� 999������� �� ������� �����skq_=', skq_);
          EXCEPTION
             WHEN NO_DATA_FOUND
             THEN
                skq_ := 0;
          END;
      end if;
      
      --2. ���� �� ���� ������ �������� ������� �������� (����� �� ���������)
      --    ������� ����� ����� ���� ��������� - sdqall_
      --    � ������� �� �������� ����� �������� - sdq 
--      FOR k IN

      DECLARE
         TYPE r0Typ IS RECORD (
           acc        accounts.acc%TYPE,
           sdq        accounts.ostf%TYPE,
           sdqall_    accounts.ostf%TYPE);

         k r0Typ;

      begin
      if rez_disc_=1 then
         OPEN c0 FOR 
           select s.acc acc, s.sdq sdq, sum(s.sdq) over() sdqall_
           from  (SELECT a.acc, 
                         gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_),dat_) sdq
                  FROM v_gl a, nd_acc n,v_gl a1
                  WHERE a1.acc=acc_ and substr(a1.nbs,1,3)=substr(a.nbs,1,3) 
                        and a1.kv=a.kv and a.acc = n.acc 
                        AND rez1.f_nbs_is_disc (a.nbs) = 1 
                        AND n.nd = nd_ and nvl(par_,0) <>999) s
           union all
           select r.acc, gl.p_icurval (r.kv, r.rest, dat_) sdq, 
                  sum(gl.p_icurval (r.kv, r.rest, dat_)) over() sdqall_
           from (SELECT a.acc,n.nd,a.kv,
                        decode(rez1.f_nbs_is_disc(r020),1,'D','P') pr,
                        (nvl(s.ostf,0)-nvl(s.dos,0)+nvl(s.kos,0)+ nvl(kp.s,0)) rest
                 FROM kl_r020 k
                 join v_gl a on k.r020 = a.nbs
                 join v_gl a1 on substr(a1.nbs,1,3)=substr(a.nbs,1,3) 
                                 and a1.kv=a.kv and a1.acc=acc_
                 join nd_acc n on a.acc = n.acc
                 left join saldoa s on s.acc = a.acc  
                      and (a.acc, s.fdat) in (SELECT ss.acc, MAX (ss.fdat) fdat FROM saldoa ss
                                         WHERE ss.fdat <= dat_ 
                                               and ss.acc = a.acc
                                         GROUP BY ss.acc)
                 left join rez_KOR_PROV kp on a.acc = kp.acc
                 WHERE rez1.f_nbs_is_prem(r020) = 1 or rez1.f_nbs_is_disc(r020) = 1) r
           where r.nd = nd_ and r.pr = 'D' and par_ = 999;
      else 
         OPEN c0 FOR 
           select s.*, sum(s.sdq) over() sdqall_
            from (SELECT a.acc,
                       gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_),
                             dat_) sdq
                  FROM v_gl a, nd_acc n
                  WHERE a.acc = n.acc AND f_nbs_is_disc (a.nbs) = 1
                        AND n.nd = nd_ and nvl(par_,0) <>999
                  ) s
            union all
            select r.acc, gl.p_icurval (r.kv, r.rest, dat_) sdq,
                   sum(gl.p_icurval (r.kv, r.rest, dat_)) over() sdqall_
            from rez_dp r
            where r.nd = nd_ and r.pr = 'D' and par_ = 999;
            
      END IF;

      LOOP
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;

   to_log (acc_,'k. acc=', k.acc); 
   to_log (acc_,'k. sdq=', k.sdq); 
   to_log (acc_,'k. sdqall_=', k.sdqall_); 

         sdqall_ := k.sdqall_;
         ndiscont1_ := ndiscont1_ + 1;

         --������������ ����� �� �������� ����� ��������
         IF skqall_ <> 0
         THEN
            sdq_ := sdq_ + ROUND (k.sdq * skq_ / skqall_);
         ELSE
            sdq_ := 0;
         END IF;

   to_log (acc_,'sdq_=', sdq_); 
         --���������� � ������ ���������� �� �������� ����� ��������
         IF mode_ = 0
         THEN
            onedisc_ (ndiscont1_).dat := dat_;
            onedisc_ (ndiscont1_).userid := userid_;
            onedisc_ (ndiscont1_).accs := acc_;
            onedisc_ (ndiscont1_).accd := k.acc;
            onedisc_ (ndiscont1_).nd := nd_;
            onedisc_ (ndiscont1_).sk := skq_;
            onedisc_ (ndiscont1_).skall := skqall_;
            onedisc_ (ndiscont1_).sd := ROUND (k.sdq * skq_ / skqall_);
            onedisc_ (ndiscont1_).sdall := sdqall_;
         END IF;
      END LOOP;
      CLOSE c0;
      END;

      -- ������� ��� ������ �� ���������� ��������� ���������
      -- ���� ������ ��� 2020 � 2026
      IF sdqall_ = 0
      THEN
         ndiscont1_ := ndiscont1_ + 1;

         BEGIN
            SELECT ABS (gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_), dat_)),
                   SUBSTR (a.nls, 6, 9), a.kv
              INTO skq_,
                   x9_, kv_
              FROM v_gl a
             WHERE acc = acc_ AND a.nbs = '2020';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               skq_ := 0;
         END;

         skqall_ := skq_;

         BEGIN
            SELECT gl.p_icurval (kv, rez1.ostc96 (acc, dat_), dat_), acc
              INTO sdqall_, accd_
              FROM v_gl
             WHERE nbs = '2026' AND SUBSTR (nls, 6, 9) = x9_ AND kv = kv_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
                  --sdqall_ := 0;
               --accd_:=null;
               RETURN 0;
         END;

         sdq_ := sdqall_;
         nd_ := NULL;

         IF mode_ = 0
         THEN
            onedisc_ (ndiscont1_).dat := dat_;
            onedisc_ (ndiscont1_).userid := userid_;
            onedisc_ (ndiscont1_).accs := acc_;
            onedisc_ (ndiscont1_).accd := accd_;
            onedisc_ (ndiscont1_).nd := nd_;
            onedisc_ (ndiscont1_).sk := skq_;
            onedisc_ (ndiscont1_).skall := skqall_;
            onedisc_ (ndiscont1_).sd := ROUND (sdq_ * skq_ / skqall_);
            onedisc_ (ndiscont1_).sdall := sdqall_;
         END IF;
      END IF;

      --���������� � ������ ���������� �� ���� ������ �������� ������� �����
      IF onedisc_.COUNT > 0 AND mode_ = 0
      THEN
         FOR p IN onedisc_.FIRST .. onedisc_.LAST
         LOOP
            ndiscont_ := ndiscont_ + 1;
            alldisc_ (ndiscont_) := onedisc_ (p);
         END LOOP;

      END IF;

      RETURN sdq_;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

-----------------------------------
   FUNCTION ca_fq_prem (
      acc_         INT,
      dat_         DATE,
      mode_   IN   INT DEFAULT 0,
      par_         NUMBER DEFAULT NULL, 
      p_nd         number DEFAULT NULL,
      p_skqall     number DEFAULT NULL,
      p_skq        number DEFAULT NULL
   )
      RETURN NUMBER
   IS
      skqall_        NUMBER;
      skq_           NUMBER;
      spqall_        NUMBER;
      spq_           NUMBER        := 0;
      nd_            NUMBER;
      n1_            NUMBER;
      kv_            NUMBER;
      x9_            VARCHAR2 (9);
      accd_          NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      IF acc_ IS NULL
      THEN
         RETURN 0;
      END IF;

      IF rezpar4_ = '1'
      THEN
         RETURN 0;
      END IF;

      nprem1_ := 0;
      oneprem_.DELETE;

      --1. ���������� ����� ����� �������� �� ���. ������ �������� - skqall_ 
      --   � ������� �� ������� ����� - skq_
      
      if par_ = 999 then
        --������� ������������� �� ������� REZ_ACC
        nd_ := p_nd;

        if skqall_ is null then
          SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, a.lim,
                                              dat_)
                               )
                          ),
                      0
                     )
            INTO skqall_
            FROM REZ_ACC a
           WHERE a.rnk = nd_
                 AND a.tip IN ('SS', 'SP', 'SL')
                 AND f_nbs_is_prem (a.nbs) = 0;
        else
          skqall_ := abs(p_skqall);
        end if;

        skq_ := abs(p_skq);
      else
         --������� ������������� �� ������� v_gl
          nd_ := f_get_nd(acc_); --T 16.06.2009

          --���� �� �� �������� ���� ������
          SELECT count(*)
            INTO spqall_
            FROM v_gl a, nd_acc n
           WHERE a.acc = n.acc AND /*f_nbs_is_disc/* */f_nbs_is_prem(a.nbs) = 1 AND n.nd = nd_;--T 15.06.2009


          if spqall_ = 0 then
             return 0;
          end if;

          spqall_ := 0;

          --���������� ����� ����� �������� �� ���. ������ �������� - skqall_
          SELECT NVL (ABS (SUM (gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_),
                                              dat_)
                               )
                          ),
                      0
                     )
            INTO skqall_
            FROM v_gl a, nd_acc n
           WHERE a.acc = n.acc
             AND a.tip IN ('SS', 'SP', 'SL')
             AND f_nbs_is_prem (a.nbs) = 0
             AND n.nd = nd_;


          if skqall_ = 0 then return 0; end if;

          -- ������� �� ������� �����
          BEGIN
             SELECT ABS (gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_), dat_))
               INTO skq_
               FROM v_gl a
              WHERE acc = acc_ AND a.tip IN ('SS', 'SP', 'SL');
          EXCEPTION
             WHEN NO_DATA_FOUND
             THEN
                skq_ := 0;
          END;
      end if;

      --2. ���� �� ���� ������ ������ ������� �������� (����� �� ���������)
      --    ������� ����� ����� ���� ������ - spqall_
      --    � ������� �� �������� ����� ������ - spq 
      FOR k IN
      (select s.*, sum(spq) over() spqall_
        from
         (SELECT a.acc,
               gl.p_icurval (a.kv, rez1.ostc96 (a.acc, dat_),
                             dat_) spq
          FROM v_gl a, nd_acc n
         WHERE a.acc = n.acc AND f_nbs_is_prem (a.nbs) = 1
               AND n.nd = nd_
               and nvl(par_,0) <>999
        ) s
         union all
         select r.acc, gl.p_icurval (r.kv, r.rest, dat_) sdq,
                sum(gl.p_icurval (r.kv, r.rest, dat_)) over() sdqall_
         from rez_dp r
         where r.nd = nd_ and
               r.pr = 'P' and
               par_ = 999
      )
      LOOP
         spqall_ := k.spqall_;
         nprem1_ := nprem1_ + 1;

         --������������ ����� �� �������� ����� ������
         IF skqall_ <> 0
         THEN
            spq_ := spq_ + ROUND (k.spq * skq_ / skqall_);
         ELSE
            spq_ := 0;
         END IF;

         --���������� � ������ ���������� �� �������� ����� ������
         IF mode_ = 0
         THEN
            oneprem_ (nprem1_).dat := dat_;
            oneprem_ (nprem1_).userid := userid_;
            oneprem_ (nprem1_).accs := acc_;
            oneprem_ (nprem1_).accp := k.acc;
            oneprem_ (nprem1_).nd := nd_;
            oneprem_ (nprem1_).sk := skq_;
            oneprem_ (nprem1_).skall := skqall_;
            oneprem_ (nprem1_).sp := ROUND (k.spq * skq_ / skqall_);
            oneprem_ (nprem1_).spall := spqall_;
         END IF;
      END LOOP;

      --���������� � ������ ���������� �� ���� ������ ������ ������� �����
      IF oneprem_.COUNT > 0 AND mode_ = 0
      THEN
         FOR p IN oneprem_.FIRST .. oneprem_.LAST
         LOOP
            nprem_ := nprem_ + 1;
            allprem_ (nprem_) := oneprem_ (p);
         END LOOP;
      END IF;

      RETURN spq_;
   EXCEPTION
      WHEN OTHERS
      THEN
         RETURN 0;
   END;

-----------------------------------
   FUNCTION ca_fq_rasch (acc_ INT, dat_ DATE)
      RETURN NUMBER
   IS
      sk1_           NUMBER;
      nls_           VARCHAR2 (15);
      kv_            NUMBER;
      x9_            VARCHAR2 (9);
      r013_          CHAR (5);
      del_           NUMBER;
      delq_          NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      RETURN ca_fq_obesp (acc_, dat_, 3);
   END ca_fq_rasch;

--------------------------------------
   FUNCTION ca_fq_rasch_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT NVL (SUM (rez1.ca_fq_rasch (a.acc, dat_)), 0)
        INTO s_
        FROM v_gl a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      RETURN s_;
   END;

--------------------------------------
   FUNCTION ca_f_rezerv (acc_ INT, dat_ DATE)
      RETURN NUMBER
   IS
      tip_           CHAR (3);
      r013_          CHAR (5);
      sk1_           NUMBER;
      sz_            NUMBER;
      uid_           NUMBER;
      ern   CONSTANT POSITIVE      := 208;
      err            EXCEPTION;
      erm            VARCHAR2 (80);
   BEGIN
      acckr_ := acc_;
      rezerv_ := 0;

      /*SELECT ID
        INTO uid_
        FROM staff
       WHERE UPPER (logname) = UPPER (USER);*/

       uid_ := user_id;

      rez1.rez_risk (uid_, dat_, 2);
      RETURN rezerv_;
   END ca_f_rezerv;

--------------------------------------
   FUNCTION ca_f_rezerv_nd (nd_ NUMBER, dat_ IN DATE)
      RETURN NUMBER
   IS
      s_   NUMBER;
   BEGIN
      SELECT NVL (SUM (gl.p_icurval (a.kv, rez1.ca_f_rezerv (a.acc, dat_),
                                     dat_)
                      ),
                  0
                 )
        INTO s_
        FROM v_gl a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      RETURN s_;
   END;

--------------------------------------
   FUNCTION ca_fq_zalog (acc_ INT, dat_ DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER
   IS
   BEGIN
      RETURN ca_fq_obesp (acc_, dat_, 1, NULL, pawn_);
   END ca_fq_zalog;

--------------------------------------
   FUNCTION ca_fq_zalog_d8 (acc_ INT, dat_ DATE, pawn_ NUMBER DEFAULT NULL)
      RETURN NUMBER
   IS
   BEGIN
      RETURN ca_fq_obesp (acc_, dat_, 1, 1, pawn_);
   END ca_fq_zalog_d8;

--------------------------------------
   FUNCTION ca_fq_zalog_nd (nd_ NUMBER, dat_ IN DATE, pawn_ NUMBER
            DEFAULT NULL)
      RETURN NUMBER
   IS
      s_   NUMBER := 0;
   BEGIN
      SELECT SUM (rez1.ca_fq_zalog (a.acc, dat_, pawn_))
        INTO s_
        FROM v_gl a, nd_acc n
       WHERE a.acc = n.acc
         AND a.tip IN ('SS ', 'SL ', 'SP ', 'CR9')
         AND n.nd = nd_;

      IF s_ IS NULL
      THEN
         SELECT   NVL (rez1.ca_fq_zalog (acc, dat_, pawn_), 0)
                + NVL (rez1.ca_fq_zalog (acc_9129, dat_, pawn_), 0)
                + NVL (rez1.ca_fq_zalog (acc_2067, dat_, pawn_), 0)
           INTO s_
           FROM acc_over
          WHERE nd = nd_
                and acco <> acc_2067; --T 04.02.2009
      END IF;

      RETURN s_;
   END;

--------------------------------------
--�������� �� ���������� ����, ������ ������
   FUNCTION f_nbs_is_prem (nbs_ VARCHAR2)
      RETURN NUMBER
   IS
      ret_   NUMBER;
   BEGIN
      IF INSTR (nbspremiy_, nbs_) > 0
      THEN
         ret_ := 1;
      ELSE
         ret_ := 0;
      END IF;

      RETURN ret_;
   END;

--------------------------------------
--�������� �� ���������� ����, ������ ��������
   FUNCTION f_nbs_is_disc (nbs_ VARCHAR2)
      RETURN NUMBER
   IS
      ret_   NUMBER;
   BEGIN
      IF INSTR (nbsdiscont_, nbs_) > 0
      THEN
         ret_ := 1;
      ELSE
         ret_ := 0;
      END IF;

      RETURN ret_;
   END;

--------------------------------------
--�������� �� ���������� ����, ������ ���������� �����
   FUNCTION f_nbs_is_fond (nbs_ VARCHAR2)
      RETURN NUMBER
   IS
      ret_   NUMBER;
   BEGIN
      IF INSTR (nbsfond_, nbs_) > 0
      THEN
         ret_ := 1;
      ELSE
         ret_ := 0;
      END IF;

      RETURN ret_;
   END;

   --T 24.03.2009
   --����������� ��������� ����� 30 ����
   function f_get_rest_over_30(acc_ number, last_work_date_ date, p_sz number default null) return number
   is

    sz_ number := 0;
    --last_work_date_ date;
    begin

      --T 02.12.2008
      --���� ������� �� ����� �� ������� � �������� ��������� - ������� ���
      if p_sz is null then
         sz_ := -rez1.ostc96 (acc_, last_work_date_);
to_log (acc_,'f_get(null) sz_=', sz_);
      else
         sz_ := p_sz;
to_log (acc_,'f_get(<>null) sz_=', sz_);
      end if;
        dbms_output.put_line('SZ = '||sz_);
       if sz_ <= 0 then return 0; end if;

       --������� �� 31 ���� ����� (��� ����� ��������������)
       sz_ := -ostc96_3 (acc_, last_work_date_ - 31);
to_log (acc_,'f_get(-ostc96_3) sz_=', sz_);

      --�� ������� �� 31 ���� ����� �������� ��� �������� �� ���������� �����
       SELECT sz_ -  NVL (SUM (k.s), 0)
        INTO sz_
       from rez_KOR_PROV k
       where k.acc = acc_ and
           k.vdat is not null;

to_log (acc_,'rez_KOR_PROV sz_=', sz_);
 dbms_output.put_line('SZ = '||sz_);

      IF sz_ >= 0
      THEN
        begin
          --�� ������� �������� ��������� �� ������ 
          SELECT sz_ -  NVL (SUM (o.s), 0)
             INTO sz_
             FROM opldok o, oper p, ref_back r
            WHERE o.acc = acc_
              AND o.fdat > last_work_date_ - 31
              AND o.fdat <= last_work_date_
              AND o.sos = 5
              AND o.dk = 1
              AND p.REF = o.REF
              AND (p.vob <> 96 AND o.fdat <= last_work_date_ )
              and p.REF = r.ref(+)
              --��������� �������� ������
              and o.tt <> 'BAK' 
              --��������� �������� ������� ���� ������������, ���� ���� ������������� ������ ��������
              and nvl(r.dt,to_date('01014000','ddmmyyyy')) >  last_work_date_
              ;

to_log (acc_,'OPLDOK sz_=', sz_);

            --�� ������� �������� ���������� ��� �������� �� ������� �����
            select sz_ - NVL (sum(dk), 0)
              INTO sz_
              from rez_KOR_PROV k
              where k.acc = acc_ and
                    k.vdat is  null ;
to_log (acc_,'������.�� sz_=', sz_);


        exception when others then
          sz_ := 0;
to_log (acc_,'exception when sz_=', sz_);
        end;
      end if;
      dbms_output.put_line('SZ = '||sz_);
      return sz_;
    end;
--------------------------------------
   -- ��������� ���������������� ���������� ������ � �������
   -- ������������ ���������� ������� ���������� ��������� REZ_RISK
   PROCEDURE p_load_data (dat_ DATE, acc_ NUMBER DEFAULT NULL)
   IS
      datkor1_   DATE;
      datkor2_   DATE;

   BEGIN
      allzal_.DELETE;
      alldisc_.DELETE;
      allprem_.DELETE;
      korprov_.DELETE;
      salost_.DELETE;
      ndacc_.DELETE;
      dodncre_.DELETE;
      dnprcre_.DELETE;
      prcrd_.DELETE;
      prcrezal_.DELETE;

      -- �������� ��������� �������� 
      -- ��� NBS '2202','2203','2207','2620','2625','2605'
      -- ������������ �� ����� s090 = '4'. 
      
      IF rezpar6_ = '1'
      THEN
         -- ���������� ������������ ��������� �� ���� RNK
         -- �� ��������� ��������� ����� = 1
         FOR k IN (SELECT DISTINCT a.rnk
                              FROM v_gl a, specparam s
                             WHERE a.acc = s.acc
                               AND a.nbs IN ('2203','2620')
                               AND s.s090 = '4'
                               --AND (   a.nbs <> '9129'
                               --     OR a.nbs = '9129' AND s.r013 <> '9'
                               --    )
                               AND a.acc = NVL (acc_, a.acc))
         LOOP
            dodncre_ (k.rnk) := '1';
         END LOOP;

         -- ���������� ���� ��������� �� ������� �� ��������� = 0
        /* FOR k IN (SELECT rnk
                     FROM customer)
         LOOP
            dnprcre_ (k.rnk) := 0;
         END LOOP;*/ --T 15.06.2009
      END IF;

      -- ���������� �������� ���������� �������
      -- dodncre_ - ��������� ����� ������� ���������� � �������� ���������� ��������,
      --            ��������� � ���������� ��������� ������������ �� ���������� �� ����������
      -- dnprcre_ - ���������� ���� ��������� �������
      -- prcrd_   - �������, ��� ������ ������ ��������� > 30 ����
      -- przalkl_ - ������ � ��������� �������
      -- ���� �������� ���������� ��������� �������� �� ���� ��� ����������� � �������
      -- datpr - ������������ ���� ������������� ���������� ��������� ������� �� ����� �� ������
      --         ��������� �������� �� ����������� �������� ����
      -- datn  - ������������ ���� ��������� ���������� ��������� ������� �� ���� ������
      --         ��������� �������� �� ����������� �������� ����
      -- prcrezal - ������� ����������� ����������� 
      -- ndacc_   - ����� �������� ��� ACC
      -- korprov_ - �������������� �������� �� ������� ����� �� ���� ������
      FOR k IN (SELECT   ss.s090, ss.rnk, ss.nd,
                         NVL (MAX (CASE
                                      WHEN ss.ostf = 0 AND ss.dos - ss.kos > 0
                                         THEN ss.fdat
                                      ELSE NULL
                                   END
                                  ),
                              dat_
                             ) datpr,
                         MAX (CASE
                                 WHEN ss.ostf - ss.dos + ss.kos = 0
                                    THEN ss.fdat
                                 ELSE NULL
                              END
                             ) datn
                    FROM (SELECT   p.s090, a.rnk, n.nd, s.fdat,a.acc,
                                   SUM (s.dos) dos, SUM (s.kos) kos,
                                   SUM (s.ostf) ostf
                              FROM saldoa s,
                                   nd_acc n,
                                   v_gl a,
                                   specparam p
                             WHERE s.acc = a.acc
                               AND a.acc = n.acc
                               AND a.acc = p.acc
                               AND a.tip in ('SP ','SPN','SK9','OFR')
                               AND a.rnk = (select rnk from accounts where acc=NVL (acc_, a.acc))
                               AND s.fdat <= dat_
                          GROUP BY p.s090, a.rnk, n.nd, s.fdat,a.acc) ss
                GROUP BY ss.s090, ss.rnk, ss.nd)
      LOOP
         DECLARE
            dnpr_    NUMBER       := 0;
            ts080_   VARCHAR2 (1) := '1';
         BEGIN
            IF k.datn IS NULL OR k.datpr > k.datn
            THEN
               dnpr_ := dat_ - k.datpr;

               IF k.s090 = '4'
               THEN
                  IF dnpr_ BETWEEN 1 AND 30 AND dodncre_ (k.rnk) < '2'
                  THEN
                     dodncre_ (k.rnk) := '2';
                  ELSIF dnpr_ BETWEEN 31 AND 60 AND dodncre_ (k.rnk) < '3'
                  THEN
                     dodncre_ (k.rnk) := '3';
                  ELSIF dnpr_ BETWEEN 61 AND 90 AND dodncre_ (k.rnk) < '4'
                  THEN
                     dodncre_ (k.rnk) := '4';
                  ELSIF dnpr_ > 90 AND dodncre_ (k.rnk) < '5'
                  THEN
                     dodncre_ (k.rnk) := '5';
                  END IF;
               END IF;

               -- ������� ������������ > 30 ����
               to_log (k.nd, 'rezpar9_', rezpar9_);
               IF rezpar9_ = '1'
               THEN
               to_log (k.nd, 'dnpr_', dnpr_);
                  IF dnpr_ > 30
                  THEN
                     prcrd_ (k.nd) := '1';
               to_log (k.nd, 'prcrd_(k.nd)', prcrd_(k.nd));
                  END IF;
               END IF;

               dnprcre_ (k.rnk) := dnpr_;
               to_log (k.rnk, 'dnprcre_ (k.rnk)', dnprcre_ (k.rnk));
            END IF;
         END;

         NULL;
      END LOOP;

      -- ��������� ����������� ����������� � �������� ������������ > 30 ����
      -- ��������� ����������� (cc_accp.pr_12 ='1')
      IF rezpar9_ = '1'
      THEN
         FOR k IN (SELECT c.acc, c.accs, n.nd, c.pr_12 perv,a.rnk
                     FROM nd_acc n, cc_accp c,v_gl a
                    WHERE n.acc = c.accs and c.accs=a.acc
                      AND n.nd IN (SELECT nd
                                     FROM nd_acc
                                    WHERE acc = NVL (acc_, acc)))
         LOOP
            IF k.perv = '1'
            THEN
               IF prcrd_.EXISTS (k.nd) AND prcrd_ (k.nd) = '1'
               THEN
                  ind_:=to_number(trim(TO_CHAR(k.acc))||trim(TO_CHAR(k.nd)));
                  to_log (k.acc, '���� ind', IND_);
                  prcrezal_(ind_):='1';
                  przalkl_(k.rnk):='1';
--                  prcrezal_(111):='1';
                  to_log (k.acc, '������� prcrezal,ind', prcrezal_(ind_));
               END IF;
            END IF;
         END LOOP;
      END IF;

      -- ������ ���������
      FOR k IN (SELECT   *
                    FROM nd_acc
                 --  WHERE acc = NVL (acc_, acc)
                ORDER BY nd
                )
      LOOP
         ndacc_ (k.acc) := k.nd;
      END LOOP;

      -- �������������� ��������
      datkor1_ := LAST_DAY (dat_) + 1;
      datkor2_ := LAST_DAY (dat_) + 21;

      --�������������� �������� �� ������� ����� �� ���� ������
      insert into rez_KOR_PROV (acc, s, dk)
      SELECT  o.acc, NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0) sm_kp
              ,NVL (SUM (DECODE (o.dk, 1, o.s, 0)), 0)
           FROM opldok o, oper p
          WHERE o.REF = p.REF
            AND o.sos = 5
            AND p.vob = 96
            --AND o.acc = acc_
            AND o.fdat BETWEEN LAST_DAY (dat_) + 1 AND LAST_DAY (dat_) + 20
            --AND p.vdat <= dat_
            AND p.vdat = dat_
            group by o.acc
      ;

      FOR k IN (select * from rez_KOR_PROV)
      LOOP
         korprov_ (k.acc).ob := k.s;
         korprov_ (k.acc).fdat := dat_;
      END LOOP;



     /* if zal_tbl.exists(1) then zal_tbl.delete;  end if; --T 16.06.2009
      SELECT --+   ordered use_nl(z a)
           t_zal_rec( z.acc, z.accs, a.kv, a.nls, a.nbs, sz.pawn, c.s031
           , k.r031, z.pr_12
           , count(distinct sz.pawn) over(partition by z.accs) --T 10.06.2009
           )
      bulk collect into zal_tbl
      FROM cc_pawn c,
           pawn_acc sz,
           cc_accp z,
           v_gl a,
           kl_r030 k
     WHERE --z.accs = acc_
       --AND
       z.acc = a.acc
       AND sz.acc = z.acc
       AND c.pawn = sz.pawn
       AND TO_NUMBER (k.r030) = a.kv
       --T 19.03.2009
       and (par_ob22 = 0 or
            --??? ????????? ?? ????????? ???????? (9031)
           (par_ob22 = 1 and a.nbs <> '9031')
        -- and a.nbs <> '9031'
          )
       ; */
   END;

--------------------------------------
   -- ��������� ������� �������������� ������������� �������� ������ ������
   -- ����� ���������� ��������� �� ������� �������.
   -- ��������� �� ������ �� ������ ������ ������ �.�. ��� �������������
   -- ����� ��������� ����� ���� ��������.
   PROCEDURE p_unload_data
   IS
   BEGIN
      allzal_ := allzal_null_;
      alldisc_ := alldisc_null_;
      allprem_ := allprem_null_;
      korprov_ := korprov_null_;
      salost_ := salost_null_;
      ndacc_ := ndacc_null_;
      dodncre_ := dodncre_null_;
      dnprcre_ := dnprcre_null_;
      prcrd_:=prcrd_null_;
      prcrezal_:=prcrezal_null_;
      --if zal_tbl.exists(1) then zal_tbl.delete;  end if;


      DBMS_SESSION.free_unused_user_memory;
   END;

--------------------------------------
-- ��������� ������� �������
   PROCEDURE rez_risk (id_ INT, dat_ DATE, mode_ IN INT DEFAULT 0, pr_ in int default null)
   IS
      ostq_            NUMBER;
      ostqold_         NUMBER;
      discont_         NUMBER;
      prem_            NUMBER;
      x9_              VARCHAR2 (9);
      del_             NUMBER;
      cc_id_           VARCHAR2 (20);
      s080_name_       VARCHAR2 (35);
      delq_            NUMBER;
      idr_             INT;
      soq_             NUMBER;
      obs_             INT;
      srq_             NUMBER;
      nd_              INT;
      szq_             NUMBER;
      szq2_            NUMBER;
      grp_             INT;
      sz_              NUMBER;
      sz_60_           NUMBER;
      wdate_           DATE;
      pr_rez_          NUMBER;
      kdate_           DATE;
      kprolog_         NUMBER;
      dat_prol_        DATE;
      sg_              NUMBER;
      sv_              NUMBER;
      zal_             NUMBER;
      kol_zal          NUMBER;
      vid_zal          NUMBER;
      otd_             NUMBER;
      form_            NUMBER;
      s080_            VARCHAR2 (1);
      s031_            VARCHAR2 (2);
      prliz_           NUMBER;
      sn_              NUMBER;
      datzo1_          DATE;
      datzo2_          DATE;
      custtype_        NUMBER;
      datlizd_         DATE;
      datlizn_         NUMBER;
      datkor1_         DATE;
      datkor2_         DATE;
      datpr_           DATE;
      last_work_date_  DATE;
      vidd_            NUMBER;
      istval_          VARCHAR2 (1);
      odncre_          VARCHAR2 (1);
      dnipr_           NUMBER;
      kvk_             NUMBER;
      ostc_            NUMBER;
      oldrez_userid_   NUMBER;     -- ������������, ������� ������ ������ � ������� ������
      oldrez_date_     DATE;       -- ��������� ������� ���� ����������� ������
      ern     CONSTANT POSITIVE      := 208;
      err              EXCEPTION;
      erm              VARCHAR2 (80);
      qnt_             number; 
      
      s270p_           VARCHAR2 (2);
      s270r_           VARCHAR2 (2);

      s370p_           VARCHAR2 (2);
      s370r_           VARCHAR2 (2);

   TYPE CurTyp IS REF CURSOR;
   c0 CurTyp;

   BEGIN

      execute immediate 'truncate table REZ_ACC';
      execute immediate 'truncate table rez_KOR_PROV';
      execute immediate 'truncate table rez_zal';
      execute immediate 'truncate table rez_dp';

--      logger.info ('REZ1.REZ_RISK');
    

     --�������� - ������ �� ������� ����
      for r in
         (SELECT holiday fdat
          FROM   holiday
          where  holiday = dat_
          )
      loop
         bars_error.raise_error('REZ',2);
      end loop;

      -- �� ������������� ������ ��� ������������ ������� ����� ��������
      -- �� ������������ �����
      BEGIN
         SELECT userid
         INTO   form_
         FROM   rez_protocol
         WHERE  dat = dat_ and userid=id_;

         IF form_ = id_
         THEN
            RETURN;
         END IF;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            form_ := NULL;
      END;

      -- ������������ � ���� ���������� �������
      -- ���� �������� ��������, ������� ������ ������������ �� REZ_PROTOCOL
      -- ���� ��� ������� ������ ���� �� ������������ �� ��������� ������� ���� ������

      -- ��������� ������� ���� ����������� ������
      SELECT MAX (fdat)
      INTO   oldrez_date_
      FROM   (SELECT fdat
              FROM   fdat
              MINUS
              SELECT holiday fdat
              FROM   holiday)
      WHERE  fdat <= LAST_DAY (ADD_MONTHS (dat_, -1));

      -- ������� ������������, ������� ����� �������� � ��������� ���� 
      -- ����������� ������. ���� �� ����� ����� �������� ������������.
      BEGIN
         SELECT userid
         INTO   oldrez_userid_
         FROM   rez_protocol
         WHERE 
                branch=sys_context('bars_context','user_branch') and 
                dat = oldrez_date_; 
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            oldrez_userid_ := id_;
      END;

      -- mode_ = 2 - ������ ������� �� ����������� �����
      IF mode_ <> 2
      THEN
         -- ���������� acc-����� - �� ���������
         acckr_ := NULL;
         
         --�������������� ������������ ������ � �������
         p_load_data (dat_);

         --������� ��� �������
         if uselog_ <> 0 then
             DELETE FROM cp_rez_log
             WHERE  userid = id_; -- �������� ��������� (������� ��� uselog_ ='1')  
         end if;

         -- �������� ������� ������� �������
         -- ������� �� ������� ����������� �� ��������� ����
         DELETE FROM tmp_rez_risk
         WHERE  ID = id_ AND dat = dat_; 

         -- ����������� ����������� � ������� ��������� ������
         DELETE FROM tmp_rez_risk2
         WHERE  userid = id_ AND dat = dat_;

         -- ����������� �������� � ������� ��������� ������
         DELETE FROM tmp_rez_risk3
         WHERE  userid = id_ AND dat = dat_;

         -- ����������� ������ � ������� ��������� ������
         DELETE FROM tmp_rez_risk4
         WHERE  userid = id_ AND dat = dat_;

         DELETE FROM tmp_rez_params
         WHERE  ID = id_ AND dat = dat_;

         delete from srezerv_errors s 
         where  s.userid = id_;

         -- ��� � ����� ������������ ������
         DELETE FROM  rez_form  WHERE ID = id_ AND dat = dat_;
         insert into rez_form(id, dat, dat_form ) values (id_, dat_, sysdate );



         -- ������� ������ ��������� ��������

         -- 1. ������ ��� ���������� ��������
         INSERT INTO pawn_acc
                     (acc)
            SELECT DISTINCT p.acc
                       FROM cc_accp p
                      WHERE NOT EXISTS (SELECT pp.acc
                                          FROM pawn_acc pp
                                         WHERE pp.acc = p.acc);

         -- 2. �������������� ����� �����-�����
--          INSERT INTO cc_accp
--                      (accs, acc)
--             SELECT z.accs, z.acc
--               FROM (SELECT DISTINCT k.accs, n.acc
--                                FROM (SELECT n.acc accs, n.nd
--                                        FROM nd_acc n, v_gl a
--                                       WHERE n.acc = a.acc
--                                         AND a.tip IN
--                                                  ('SS ', 'SL ', 'SP ', 'CR9')) k,
--                                     (SELECT DISTINCT p.acc, n.nd
--                                                 FROM cc_accp p, nd_acc n
--                                                WHERE p.accs = n.acc) n
--                               WHERE k.nd = n.nd
--                     MINUS
--                     SELECT accs, acc
--                       FROM cc_accp) z,
--                    v_gl az,
--                    v_gl ak
--              WHERE z.accs = ak.acc
--                AND z.acc = az.acc
--                AND (ak.dazs IS NULL OR ak.dazs > dat_)
--                AND (az.dazs IS NULL OR az.dazs > dat_);

-- ��� ��������� ������� SREZERV - ������ - ��������� ����� �� �������������
         -- 3. ����������� ���������  ����� �� ����������� ������ �����
         FOR k IN (SELECT a.acc, s.s080
                     FROM srezerv s, --������� ���������� � �������� ������ ���������� ����� (����� ���������)
                          v_gl a
                    WHERE (s.s_fond = a.nls OR s.s_fondnr = a.nls)
                          AND a.nbs IN ('2400', '2401', '3690')
                          AND s.s080 <> 9 --T 21.01.2009
                  )
         LOOP
            UPDATE specparam
               SET s080 = k.s080
             WHERE acc = k.acc;

        END LOOP;

        --��������� ������ �� ��������/������ 
        insert into rez_dp
        (
          ACC  , -- ���� ��������/������
          ND   , -- ��� ��������
          KV,    -- ������
          PR   , --������� 'D' - �������, 'P' - ������
          REST   --������� �� ����� ��������/������
        )
        SELECT  --+ ordered use_nl(k a)
        a.acc, n.nd, a.kv, decode(rez1.f_nbs_is_disc(r020),1,'D','P') pr, (nvl(s.ostf,0) - nvl(s.dos,0) + nvl(s.kos,0) +  nvl(kp.s,0))  rest
        FROM kl_r020 k
             join v_gl a on k.r020 = a.nbs
             join nd_acc n on a.acc = n.acc
             left join saldoa s on s.acc = a.acc  and (a.acc, s.fdat) in (SELECT
                                                                           ss.acc, MAX (ss.fdat) fdat
                                                                           FROM saldoa ss
                                                                          WHERE ss.fdat <= dat_
                                                                                and ss.acc = a.acc
                                                                        GROUP BY ss.acc)
             left join rez_KOR_PROV kp on a.acc = kp.acc
        WHERE rez1.f_nbs_is_prem(r020) = 1 or rez1.f_nbs_is_disc(r020) = 1
        ;

        --��������� ������ ��  ��������� ������
        --(�� ������� ����� ������� ������)
        insert into REZ_ACC
        ( ACC   , 
          NLS   , -- ��������� ����
          KV    , -- ��� ������
          NBS   , -- ����� ����������� �����
          RNK   , -- ���.��������
          DAOS  , -- ���� �������� �����
          DAPP  , --�� ������������
          ISP   , -- ����������� �� �����
          NMS   , --�� ������������
          LIM   , -- ������� �� ����� � ������ ��������������
          PAP   ,
          TIP   , -- ��� �����
          VID   , --�� ������������
          MDATE , --�� ������������
          DAZS  , --�� ������������
          ACCC  , -- ��� �������
          TOBO    -- 
         -- CODCAGENT
        )
        select *
        from ( with nb as ( select nbs r020, 11 a010 from rez_nls_23),
                    nd as ( select acc, max(nd) nd from nd_acc group by acc )
             --���������� �������� �� ������ � ������ ��������������
             select  --+ index(s PK_SALDOA) ordered full(a)
                        a.acc,
                        a.nls,  
                        a.kv, 
                        a.nbs ,
                        n.nd rnk,
                        a.DAOS, --T 09.01.2009
                        null dapp, 
                        a.isp, 
                        null nms,
                        (nvl(s.ostf,0) - nvl(s.dos,0) + nvl(s.kos,0) +  nvl(kp.s,0)) lim, 
                        null pap,
                        a.tip, 
                        null vid, 
                        null mdate, 
                        null dzs, 
                        a.rnk accc
                        , a.tobo--, null
            from       nb k,
                        v_gl a
                       ,(SELECT  -- +  index(s PK_SALDOA)
                                 acc, MAX ( case when fdat <= dat_ then fdat else null end ) fdat
                               FROM saldoa
                          -- WHERE fdat <= to_date('30062009','ddmmyyyy')
                           GROUP BY acc) sel
                       , saldoa s
                       , rez_KOR_PROV kp
                       , nd n
                    where a.nbs = k.r020
                          AND (a.dazs IS NULL OR a.dazs > dat_)
                          and a.acc = sel.acc
                          and s.acc = sel.acc
                          and s.fdat = sel. fdat
                          and a.acc = kp.acc(+)
                          and nvl(s.ostf,0) - nvl(s.dos,0) + nvl(s.kos,0) +  nvl(kp.s,0) < 0
                          and a.acc  = n.acc(+)
            union all
            --��������� �������� - �������������� ���� ������� �� ����, ����� ���� ��� �� ��� ������
            --(�.�. ��� ���������� � saldoa)
            --�������� - ���� ������� 05,05,2010 � ������� �������������� �� 30,04,2010
            --� saldoa �� 30,04,2010 ������ ���,
            -- ������� ������� �� 30,04,2010 - ��� ����� ��������������
            select --+ ordered no_merge(s)
                  a.acc,a.nls,  a.kv, a.nbs ,(n.nd),
                  a.DAOS, --T 09.01.2009
                  null, a.isp, null , s.sm sm, null,
                  a.tip, null, null, null, a.rnk
                  , a.tobo--, null*/
               from
               (
               select kp.acc, nvl(kp.s,0) sm
                 from   rez_KOR_PROV kp
                where  nvl(kp.s,0) < 0
                        and exists ( select 1 from
                                     (SELECT  -- +  index(s PK_SALDOA)
                                            acc, MIN (fdat) fdat
                                      FROM saldoa
                                      GROUP BY acc
                                      )  sel
                                     where  fdat > dat_ and kp.acc = sel.acc
                                    )
               ) s,
               v_gl a
               , nd n
               where (a.dazs IS NULL OR a.dazs > dat_)
                      and a.acc = s.acc
                              and a.nbs in  (SELECT r020 from nb where a010 || decode(a.acc,-1,'*','') = '11')
                              and a.acc  = n.acc(+));
        
        --������ ��� ������
        insert into rez_zal
        ( ACC   , -- ��� ����� ������
          ACCS  , -- ��� ����� ����������
          KV    , -- ��� ������
          NLS   , -- ���� ������
          NBS   , -- ���������� ����
          PAWN  , -- ��� ������
          S031  , -- ��� ������ ���
          R031  , -- ������ ����� (1-�� ���.������, 2- ��� �����-������������ 3-��� � ��������� ������������
          PR_12 , -- ������� ����������� �������
          PWN   , -- ���-�� ����� ������ �� ������ ��������� �����
          OSTC_Z, -- ������� �� ����� ������
          ACCS1 , -- ���� ���������, ������� ���� ��������� � ������� ����� ������ 
          OSTC_S, -- ������� �� ���������� �����
          ND      -- ��� �������
        )
        SELECT z.acc, z.accs, a.kv, a.nls, a.nbs, sz.pawn, c.s031, k.r031, z.pr_12, 
               count(distinct c.s031) over(partition by z.accs) pwn,
               decode(zal_sp_,1,
                      nvl(sz.sv,(nvl(s.ostf,0) - nvl(s.dos,0) + nvl(s.kos,0) +  nvl(kp.s,0))),
                     (nvl(s.ostf,0) - nvl(s.dos,0) + nvl(s.kos,0) +  nvl(kp.s,0))) ostc_z, 
               z1.accs accs1, nvl(o.lim,0) ostc_s, o.rnk
         FROM cc_pawn c, pawn_acc sz, cc_accp z, v_gl a, kl_r030 k,
              (SELECT   acc, MAX (fdat) fdat FROM saldoa WHERE fdat <= dat_
               GROUP BY acc) sel, 
               saldoa s, rez_KOR_PROV kp,cc_accp z1,REZ_ACC o
         WHERE z.acc = a.acc AND sz.acc = z.acc AND c.pawn(+) = sz.pawn
               AND TO_NUMBER (k.r030) = a.kv and (par_ob22 = 0 or
               (par_ob22 = 1 and a.nbs <> '9031')) and a.acc = sel.acc(+)
               and s.acc(+) = sel.acc and s.fdat(+) = sel. fdat
               and a.acc = kp.acc(+)  and z.acc  = z1.acc
               and z1.accs = o.acc(+) and nvl(o.lim,0)  <> 0
               and decode(zal_sp_,1,nvl(sz.sv,(nvl(s.ostf,0) - nvl(s.dos,0) + 
                          nvl(s.kos,0) +  nvl(kp.s,0))),(nvl(s.ostf,0) - 
                          nvl(s.dos,0) + nvl(s.kos,0) +  nvl(kp.s,0)))<>0 ;


--         COMMIT;
      ELSE  -- �� ����������� �����
         p_load_data (dat_, acckr_);
      END IF;

      IF rez_upz_=1 then
         p_perv_zal(dat_);
      ELSE
         update cc_accp set pr_12=0 where pr_12<>1;
      END IF;

      rownumber_ := 0;
      n_ := 0;
      ndiscont_ := 0;
      nprem_ := 0;
      n1_ := 0;
      ndiscont1_ := 0;
      nprem1_ := 0;
      flagkorprov_ := 1;
      flagallrez_ := 1;

      -- ������� �� �������� ������� �� F11_ = '1'
--    FOR k IN
--      (--�� ���� ������
      DECLARE
         TYPE r0Typ IS RECORD (
              s080     specparam.s080%TYPE,
              s090     specparam.s090%TYPE,
              isp      accounts.isp%TYPE,
              tobo     accounts.tobo%TYPE,
              r013     VARCHAR2(5),
              r013_2   specparam.r013%TYPE,
              istval   VARCHAR2(1),
              rnk      customer.rnk%TYPE,
              nmk      customer.nmk%TYPE,
              custtype customer.custtype%TYPE,
              acc      accounts.acc%TYPE,
              kv       accounts.kv%TYPE,
              nls      accounts.nls%TYPE,
              rez      crisk.rez%TYPE, 
              rez2     crisk.rez2%TYPE,
              rez3     crisk.rez3%TYPE,
              rez4     crisk.rez4%TYPE,
              rez5     crisk.rez5%TYPE,
              name     crisk.name%TYPE,
              nbs      accounts.nms%TYPE,
              fin      customer.crisk%TYPE,
              cc_id    cc_deal.cc_id%TYPE,
              country  customer.country%TYPE,
              rz       customer.codcagent%TYPE,
              corp     customerw.VALUE%TYPE,
              DAOS     DATE,
              s182     specparam.s182%TYPE,
              otd      otd_user.otd%TYPE,
              nd       nd_acc.nd%TYPE,
              prm      rez_dp.rest%TYPE,
              dsc      rez_dp.rest%TYPE,
              ostc     accounts.ostc%TYPE,
              wdate    DATE,
              sm_nd    accounts.ostc%TYPE,
              cc_id1   cc_deal.cc_id%TYPE, 
              obs      cc_deal.obs%TYPE,
              k_date   DATE, 
              n        cc_deal.nd%TYPE,
              tip      accounts.tip%TYPE,
              ob22     specparam_int.ob22%TYPE,
              nd_2     cc_deal.nd%TYPE);
      k r0Typ;


      BEGIN

      IF acckr_ is null THEN  -- ���������� ���� �� �����
         OPEN c0 FOR 
         select s080,    -- ��������� �����
                s090,    -- ��� ������������� �� ������.����.(�������.KL_S090)
                isp,     -- �����������
                tobo, 
                r013,    -- NBS+R013  
                r013_2,  -- �������� r013 (������ � ����������� KL_R013 � ����������� �� ���.�����), 
                istval,  -- �������� ���.�������
                rnk,     -- ��� �������
                nmk,     -- ������������ �������
                custtype,-- ��� ������� 
                acc,     -- ACC ���������� ����� 
                kv,      -- ��� ������
                nls,     -- ��������� ���� 
                rez,     -- % �������������� (CRISK)
                rez2, rez3, rez4, rez5,
                NAME,    -- ������������ ��������� ����� 
                nbs,     -- ���������� ����
                fin,     -- ���.����
                cc_id,   -- ����� ��������
                country, -- ��� ������
                rz,      -- 2 - ���������� 1 - ��������
                corp,   
                DAOS ,   -- ���� �������� ����� 
                s182,    -- ��� ������� (1-����������.2-���������.3-����.�����)
                otd ,    -- �����
                nd,      -- �������� ���������� ��������
                prm,     -- ������
                dsc,     -- �������
                ostc,    -- ������� �� �����
                wdate,   -- ���� ������ �������
                sum(decode(nvl(nd,-1), -1, 0, 
                    decode(tip,'SS ', ostc, 'SP ', ostc, 'SL ', ostc,0)))  
                    over(partition by nd) sm_nd,
                -- ����� �������� �� ������ ������� ���������� ��������  
                cc_id1,  -- ����� ���������� ��������  
                obs,     -- ������������ ����� (1-�����, 2-����.3-�������.)
                k_date,  -- ���� ���������� ���������� �������� 
                n,       -- �������� �������� ???? 
                tip,     -- ��� �����
                ob22,    -- OB22 ��� ��������� (sb_ob22 - �����������)
                nd_2     -- ��� �������� ����� ???
         from ( select NVL (p.s080, '1') s080, p.s090, a.isp, a.tobo,
                       a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1') r013,
                       p.r013 r013_2, NVL (p.istval, '0') istval, c.rnk,
                       decode(c.custtype,3,SUBSTR (c.nmk, 1, 35),
                              nvl(substr(c.nmkk,1,35),SUBSTR (c.nmk, 1, 35))) nmk,
                       DECODE (TRIM (c.sed), '91', DECODE (c.custtype, 3, 2, 
                               c.custtype),c.custtype) custtype,
                       a.acc, a.kv, a.nls, r.rez, r.rez2, r.rez3, r.rez4, 
                       r.rez5, r.NAME,a.nbs, 
                       nvl(dd.fin,c.crisk) fin, 
                       SUBSTR (c.nd, 1, 20) cc_id,
                       NVL (c.country, acountry) country,
                       DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 
                               2, 1) rz,MIN (cw.VALUE) corp,a.DAOS,p.s182,
                       min(o.otd) otd,a.rnk nd,
                       sum(decode(nvl(dp.pr,'*'),'P',dp.rest,0)) prm,
                       sum(decode(nvl(dp.pr,'*'),'D',dp.rest,0)) dsc,
                       a.LIM ostc,nvl(nvl(d.wdate, nvl((v.datd),(vv.datd))),
                       a.daos)  wdate, to_number(a.NMS) sm_nd,
                       SUBSTR (nvl(dd.cc_id,nvl((v.ndoc),(vv.ndoc))),1,20) cc_id1,
                       nvl(dd.obs,nvl(v.obs,vv.obs)) obs,
                       nvl(dd.wdate, nvl(v.datd2, vv.datd2)) k_date,
                       nvl(dd.nd,nvl(v.acc,vv.acc)) n,a.tip,
                       i.ob22, 
                       nvl(dd.nd,nvl(v.nd,vv.nd)) nd_2
                from REZ_ACC a
                left join specparam p on a.acc = p.acc
                left join specparam_int i on a.acc = i.acc
                join crisk r on NVL (p.s080, '1') = r.crisk
                join customer c on a.accc = c.rnk
                left join otd_user o on a.isp = o.userid
                left join customerw cw on c.rnk = cw.rnk and cw.tag = 'CORP'
                left join rez_dp dp on a.rnk = dp.nd
                left join cc_add d on a.rnk = d.nd  AND d.adds = 0
                left join acc_over v on a.acc = decode(a.nbs,'9129',v.acc_9129, v.acco) and v.sos is null
                left join acc_over_archive vv on a.acc = decode(a.nbs,'9129',vv.acc_9129, vv.acco) and vv.deldate >= dat_ and vv.sos is null
                left join cc_deal dd on a.rnk = dd.nd
                -- �� ������������� ����� REZ_N=1 - �� ���������� � ������ (L.09-09-2010)
                left join accountsw aw on a.acc=aw.acc and aw.tag='REZ_N'
       
                where not(a.nbs = '3548' and nvl(p.r011,'0') <> '1')
                      and NVL(aw.value,'0')<>'1'
                group by NVL (p.s080, '1') , p.s090, a.isp, a.tobo, a.nbs || 
                      DECODE (NVL (p.r013, '1'), '9', '9', '1'),p.r013 , 
                      NVL (p.istval, '0') , c.rnk,decode(c.custtype,3,
                      SUBSTR(c.nmk,1,35),nvl(substr(c.nmkk,1,35),
                      SUBSTR (c.nmk, 1, 35))),DECODE(TRIM (c.sed),'91', 
                      DECODE (c.custtype, 3, 2, c.custtype), c.custtype ) ,
                      a.acc, a.kv, a.nls, r.rez, r.rez2, r.rez3, r.rez4, 
                      r.rez5,r.NAME,a.nbs, 
                      nvl(dd.fin,c.crisk), 
                      SUBSTR (c.nd, 1, 20),NVL (c.country, acountry) ,
                      DECODE (NVL (c.codcagent, 1),'2',2,'4',2,'6',2,1),
                      a.DAOS,p.s182,a.LIM,d.wdate,a.accc,a.tip,dd.cc_id, 
                      dd.obs, dd.wdate,v.datd,vv.datd,v.ndoc, vv.ndoc, 
                      v.obs,vv.obs,v.datd2, vv.datd2, dd.nd,v.acc,vv.acc,
                      to_number(a.NMS),a.rnk,
                      i.ob22, 
                      nvl(dd.nd,nvl(v.nd,vv.nd))
        );
      ELSE    -- ����� ���������� ���� 
        OPEN c0 FOR
        --�� ���������� �����
        select NVL (p.s080, '1') s080, p.s090, a.isp, a.tobo,
                 a.nbs || DECODE (NVL (p.r013, '1'), '9', '9', '1') r013,
                 p.r013 r013_2, NVL (p.istval, '0') istval, c.rnk,
                 decode(c.custtype,3,SUBSTR (c.nmk, 1, 35),
                        nvl(substr(c.nmkk,1,35),SUBSTR (c.nmk, 1, 35))) nmk,
                 DECODE (TRIM (c.sed),
                         '91', DECODE (custtype, 3, 2, custtype),
                         c.custtype) custtype,
                 a.acc, a.kv, a.nls, r.rez, r.rez2, r.rez3, r.rez4, r.rez5,
                 r.NAME,a.nbs,
                 NVL((select FIN from cc_deal 
                      where nd=rez1.f_get_nd(a.acc)), c.CRISK ) fin, 
                 SUBSTR (c.nd, 1, 20) cc_id,NVL (c.country, acountry) country,
                 DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz,
                (select MIN (VALUE) from customerw cw
                  WHERE tag = 'CORP' and c.rnk = cw.rnk) corp,a.DAOS,p.s182,
                (select  min(o.otd) otd FROM otd_user o
                  where a.isp = o.userid) otd, f_get_nd(a.acc) nd, 1 prm,
                 1 dsc, null ostc,
                (select wdate from cc_add
                 where nd = f_get_nd(a.acc) and adds = 0) wdate,null sm_nd,
                 null cc_id1,  null obs, null k_date,null n,null tip,
                 null ob22, 
                 null nd_2
        from v_gl a, ( select nbs r020, 11 a010 from rez_nls_23) k,specparam p,crisk r,customer c
        where a.nbs = k.r020 AND (a.dazs IS NULL OR a.dazs > dat_)
              AND a.acc = p.acc(+) AND NVL (p.s080, '1') = r.crisk
              AND a.rnk = c.rnk and a.acc = acckr_
              and not(a.nbs = '3548' and nvl(p.r011,'0') <> '1');
      END IF;

      LOOP
         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;

         otd_ := nvl(k.otd,0);
         curacc_ := k.acc;
         s080_name_ := k.NAME;
         -- ������ � �������� ��������� (CP_REZ_LOG)
         to_log (k.acc,
                 '(nls)(kv)(���)(rnk)',
                    '('
                 || k.nls
                 || ')('
                 || TO_CHAR (k.kv)
                 || ')'
                 || '('
                 || TO_CHAR (k.acc)
                 || ')'
                 || '('
                 || TO_CHAR (k.rnk)
                 || ')'
                );
         s080_ := k.s080;

         nd_ := k.nd;
         wdate_ := k.wdate;
         if k.n is not null then
            cc_id_ := k.cc_id1;
         else
            cc_id_ := k.cc_id;
         end if;
        -- cc_id_ := nvl(k.cc_id1,k.cc_id);
         obs_ := k.obs;
         kdate_ := k.k_date;

         -- ���� - ���� ��������� �������� �������
         istval_ := k.istval;

         -- ���������� ���������� ���� ��������� ������� ��� ������� �������
         IF dnprcre_.EXISTS (k.rnk)
         THEN
            dnipr_ := dnprcre_ (k.rnk);
         else 
            dnipr_ := 0; --T 16.06.2009
         END IF;

         -- ���� - ���� ������� � �������� ���������� ��������
         IF     dodncre_.EXISTS (k.rnk)
            AND k.nbs IN ('2203','2620')
            AND k.s090 = '4'
         THEN
            odncre_ := 'y';
            s080_ := dodncre_ (k.rnk);

            -- dnipr_ := dnprcre_ (k.rnk);

            -- ���������� ��������� ����� ��������� ����� ��� ���������� ��������
            IF k.s080 <> s080_
            THEN
               UPDATE specparam
                  SET s080 = s080_
                WHERE acc = k.acc;

               IF SQL%ROWCOUNT = 0
               THEN
                  INSERT INTO specparam
                              (acc, s080
                              )
                       VALUES (k.acc, s080_
                              );
               END IF;

               COMMIT;
            END IF;

            -- ���������� ��������� ����� ����� ��������
            DECLARE
               accd_    NUMBER;
               s080d_   NUMBER;
            BEGIN
               SELECT a.acc, NVL (p.s080, '0')
                 INTO accd_, s080d_
                 FROM v_gl a, nd_acc n, specparam p
                WHERE a.acc = n.acc
                  AND n.nd = nd_
                  AND p.acc(+) = a.acc
                  AND ROWNUM = 1
                  AND a.tip = 'SDI'
                  AND a.dazs IS NULL;

               IF s080d_ <> s080_
               THEN
                  UPDATE specparam
                     SET s080 = s080_
                   WHERE acc = accd_;

                  IF SQL%ROWCOUNT = 0
                  THEN
                     INSERT INTO specparam
                                 (acc, s080
                                 )
                          VALUES (accd_, s080_
                                 );
                  END IF;

                  COMMIT;
               END IF;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  NULL;
            END;
         ELSE  -- �� ���������� ������
            odncre_ := NULL;
         -- dnipr_ := NULL;
         END IF;

         --���������� ������� �� �����
         if k.ostc is null then -- ������ ��������� �� ������ �����
            ostc_ := -rez1.ostc96 (k.acc, dat_);
         else ostc_ := -k.ostc;
         end if;
         --DBMS_OUTPUT.put_line ('1.ostc_=' || TO_CHAR (ostc_));

         --������ ������� ������ ��� �������� ��������
         IF ostc_ > 0
         THEN
            --������� � ������
            ostq_ := gl.p_icurval (k.kv, ostc_, dat_);
            ostqold_ := ostq_;

          /*  SELECT ABS (NVL (SUM (sd), 0))
              INTO discont_
              FROM tmp_rez_risk3
             WHERE userid = id_ AND dat = dat_ AND accs = k.acc;*/

            --��� '9100', '9129' ����� 50% �������
            IF SUBSTR (k.r013, 1, 4) IN ('9100', '9129')
            THEN
               ostq_ := ROUND (0.5 * ostq_);
            END IF;

            del_ := 0;
            delq_ := 0;
            zal_ := 0; --T 24.02.2009
            vid_zal := null;

            --������� ����� �������� �� ������� �����
            --���� �� �������� � �������� ��������� ���� ���� �������
            --����� ����� �������� = 0
            if nvl(k.dsc,0) <> 0 then  
               discont_ := NVL (rez1.ca_fq_discont (k.acc, dat_,0,999,k.nd,
                                                     gl.p_icurval (k.kv, k.sm_nd, dat_),
                                                     (case when instr('SS SP SL ', k.tip)= 0 then 0 else gl.p_icurval (k.kv, k.ostc, dat_) end)), 0);--T 26.02.2009
            else discont_ := 0;
            end if;

            --������� ����� ������ �� ������� �����
            --���� �� �������� � �������� ��������� ���� ���� ������
            --����� ����� �������� = 0
            if nvl(k.prm,0) <> 0 then
               prem_ :=  NVL (rez1.ca_fq_prem (k.acc, dat_,0,999,k.nd,
                                                gl.p_icurval (k.kv, k.sm_nd, dat_),
                                                ( case when instr('SS SP SL ', k.tip) = 0 then 0 else gl.p_icurval (k.kv, k.ostc, dat_) end)), 0);--T 26.02.2009
            else prem_ := 0;
            end if;

           --������� ����� �����������
            if acckr_ is null then
               soq_ := ca_fq_obesp1 (k.acc, dat_, 0, null, null, zal_,vid_zal,discont_,prem_, k.ostc, k.nd, k.wdate); --T 24.02.2009
            else
               --���� ������ ���������� ����
               soq_ := ca_fq_obesp (k.acc, dat_, 0, null, null, zal_,vid_zal,discont_,prem_); --T 24.02.2009
            end if;
            curacc_ := k.acc;

--            begin
--               select s031 into s031_
--               FROM cc_pawn where pawn=vid_zal;
--            EXCEPTION WHEN NO_DATA_FOUND THEN
--               s031_:='90';
--            end;

--            if vid_zal=40 THEN
--               vid_zal := f_rez_s031(dat_,id_,k.acc);
--               s031_   := vid_zal;
--               to_log (k.acc, 'f_get_s031',vid_zal); 
--            end if;

            --zal_ - ����� ����������� �� ����� ��� �������� �� �����������
            zal_ := zal_/100; --T 24.02.2009
            prem_ := ABS (prem_);--T 26.02.2009

            IF zal_=0 THEN
               vid_zal := null;
            END IF; 

            --����� ���������� �����
            srq_ := (ostq_ + del_) - discont_ + prem_ - soq_;
            --����� ���������� ����� ��� ����� ��������/������
            szq2_ := (ostq_ + del_) - soq_;

            IF szq2_ < 0
            THEN
               szq2_ := 0;
            END IF;

            IF srq_ < 0
            THEN
               srq_ := 0;
            END IF;

          --  vid_zal := null;
            calcdoppar_ := 0; -- ������� ������� �������������� ���������� ��������� ��� ������� �������

            --��������� ������ ������ ��� ����������� � ���������� ����� (��� ������� �� ������������)
            IF mode_ <> 2 AND calcdoppar_ = 1
            THEN
               BEGIN
                  --��������� ���������� ��������
                  SELECT SUBSTR (cc_id, 1, 20), obs, wdate, vidd
                    INTO cc_id_, obs_, kdate_, vidd_
                    FROM cc_deal
                   WHERE nd = nd_;

                  -- ���-�� �����������
                  BEGIN
                     SELECT COUNT (*)
                       INTO kprolog_
                       FROM cc_prol
                      WHERE nd = nd_ AND acc = k.acc;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        kprolog_ := 0;
                  END;

                  --�� ��, ��, ��� (���.���,����.,���� �����.��������)
                  kvk_ := k.kv;

                  IF vidd_ = 3
                  THEN
                     BEGIN
                        SELECT kv
                          INTO kvk_
                          FROM v_gl a, nd_acc n
                         WHERE a.acc = n.acc
                           AND a.nbs = '8999'
                           AND nd = nd_
                           AND ROWNUM = 1;
                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           kvk_ := k.kv;
                     END;
                  END IF;

                  -- ��������� ����� �� �������� � ���. � ���.
                  -- BEGIN
                  BEGIN

                     SELECT gl.p_icurval (kvk_, lim2 / 100, dat_), lim2 / 100
                       INTO sg_, sv_
                       FROM cc_lim c
                      WHERE nd = nd_ AND fdat = (SELECT MIN (fdat)
                                                   FROM cc_lim
                                                  WHERE nd = nd_);
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        sg_ := 0;
                        sv_ := 0;
                  END;

                  BEGIN
                    -- ���� �����������
                     SELECT DISTINCT fdat
                                INTO dat_prol_
                                FROM cc_prol
                               WHERE nd = nd_
                                 AND fdat = (SELECT MIN (fdat)
                                               FROM cc_prol
                                              WHERE nd = nd_ AND npp <> 0);
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        dat_prol_ := NULL;
                  END;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     --��������� ���������� �������� �� ��������� ���������
                     --(�.�. �� ������� ��� � nd_acc)
                     --����������� �������� ??? 
                     BEGIN
                        --�����
                        SELECT SUBSTR (ndoc, 1, 20), obs, datd, datd2,
                               gl.p_icurval (k.kv, sd, dat_) / 100, sd / 100
                          INTO cc_id_, obs_, wdate_, kdate_,
                               sg_, sv_
                          FROM acc_over
                         WHERE k.acc IN (acco, acc_9129) AND ROWNUM = 1;

                     EXCEPTION
                        WHEN NO_DATA_FOUND
                        THEN
                           -- ����� - �����
                           BEGIN
                              SELECT SUBSTR (ndoc, 1, 20), obs, datd, datd2,
                                     gl.p_icurval (k.kv, sd, dat_) / 100,
                                     sd / 100
                                INTO cc_id_, obs_, wdate_, kdate_,
                                     sg_,
                                     sv_
                                FROM acc_over_archive
                               WHERE k.acc IN (acco, acc_9129)
                                 AND ROWNUM = 1
                                 AND deldate >= dat_;

                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 --���������
                                 cc_id_ := k.cc_id;
                                 obs_ := TO_NUMBER (NULL);
                                 nd_ := TO_NUMBER (NULL);
                                 wdate_ := k.daos;--T 09.01.2009
                                 kdate_:= null;--T 09.01.2009
                                 sg_:= null;--T 09.01.2009
                                 sv_:= null;--T 09.01.2009
                           END;
                     END;
               END;
            END IF;

            --��� ������ ����������� � ��������� ��������� �����
            --������ ���� �������� �������� ����� ���� �������� ����� -
            -- �.�. ���� �������� ����� = ���� ������
            -- ����� ���������
            if nvl(k.s182,0) = 3 and par_ob22 <> 1 then
               wdate_ := k.daos;--T 23.01.2009
            end if;

            -- ����������� �������� ��������������
            pr_rez_ := 0;
            /* ������� �������������� � ����������� �� ������� ��������� �������� �������
               ��� �������� �� ����� ������, ��� ��������� � ������ ������ ������ ������������
               �� ������ ������ ����� */
            to_log (k.acc, '% ��������������', '');

            --���������� ���� �������� �������
            k.daos := nvl(wdate_,  k.daos);--T 09.01.2009
            
            -- ����������� �������� �������������� �� ��������� �����
            IF rezpar5_ = 0  --  ������� �������������� �� �������
            THEN                                
               IF    k.istval = 1
                  OR k.kv = 980
                  OR (SUBSTR (k.nbs, 1, 3) IN ('151', '152'))
                  OR k.nbs = '1502'
               THEN
                  pr_rez_ := k.rez;
               ELSIF k.nbs <> '1500'
               THEN
                  pr_rez_ := k.rez2;
               END IF;
            ELSIF rezpar5_ = 1  -- ������� �������������� �� 83 ���������
            THEN                                       
               --% ��� ������ � ������
               IF    k.kv = 980
                  OR (SUBSTR (k.nbs, 1, 3) IN ('151', --������� ������ (��������), �� ������� � ����� ������
                                               '152')) --�������, �� ����� ����� ������
                  OR k.nbs = '1502'--����� ����� � �����������
               THEN
                  to_log (k.acc, '..������� ��� �������', '');
                  pr_rez_ := k.rez;

               --��������� ������������� ������ ���� ��� ������� �� � ���������� ������
               --���  �� ������ ������ ������
               -- ������� �������������� ��� ��� ������������� ������ �� ������ ����� �����
               ELSIF k.nbs <> '1500'--��������������� �������, �� ������ � �����   ������
               THEN
                  --% ��� ������ � ������ (����� ����������)
                  IF k.istval = 1
                  THEN
                     to_log (k.acc, '..���� ��������� �������� �������', '');
                     pr_rez_ := k.rez3;
                  ELSE
                     to_log (k.acc, '..��� ���������� �������� �������', '');
                     pr_rez_ := k.rez2;

                     --��� ��������� ��� �������� ������� �������� ����� 28.12.2008
                     --������ % ��������������
                     if k.daos >= c_dt and k.nbs <> '9129'  --T 31.03.2009
                     then --T 09.01.2009
                       to_log (k.acc, '..����� % ��������������', '');
                       pr_rez_ := k.rez5;
                     end if;

                  END IF;
               END IF;
            END IF;

            -- ������� �������������� �� ������ ����� �����
            -- ������ ��� ��������� � ������������� ��������-���������
            IF k.country <> acountry AND k.nbs LIKE '1%'
            THEN
               to_log (k.acc,
                       '..������� �������������� �� ������ ������ �����',
                       ''
                      );

               BEGIN
                  SELECT GREATEST (NVL (g.pr, 0), NVL (pr_rez_, 0)),
                         NVL (y.grp, 1)
                    INTO pr_rez_,
                         grp_
                    FROM country y, rez_grp_country g
                   WHERE y.country = k.country AND y.grp = g.grp;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     to_log
                        (k.acc,
                         '..������ !!!, ��� ������ �� �������� ���. ��. ����� ����� ',
                         ''
                        );
                     pr_rez_ := k.rez;
               END;
            END IF;

            -- �� ����������� � ��������� �������
            -- k.istval = 2 - ���� �� ���� �������������, � � ��������� �������������
            -- ��� 1500 �� ����������� ���� ���� ���������� ��� ������ ������ ������
            IF k.istval = 2
            THEN
               to_log (k.acc, '..�� ����������� (istval=2)', '');
               pr_rez_ := 0;
            ELSIF k.nbs = '1500' AND (k.country = acountry OR grp_ = 1)
            THEN
               to_log
                  (k.acc,
                   '..�� ����������� (������� � ������� ��� � ������ 1 ������ ����� �����)',
                   ''
                  );
               pr_rez_ := 0;
            END IF;

            -- ������� �������������� ��� �������� ���������� ��������
            IF odncre_ = 'y'
            THEN
               to_log (k.acc, '..�������� ���������� ��������', '');
               --��� ���������� �������� � ������ ������ % ��������������
               IF  k.kv <> 980 and k.daos >= c_dt then --T 28.12.2008
                   to_log (k.acc, '..����� % ��������������', '');
                   IF s080_ = '1'
                   THEN
                      pr_rez_ := 50;
                   ELSIF s080_ = '2'
                   THEN
                      pr_rez_ := 100;
                   ELSIF s080_ = '3'
                   THEN
                      pr_rez_ := 100;
                   ELSIF s080_ = '4'
                   THEN
                      pr_rez_ := 100;
                   ELSIF s080_ = '5'
                   THEN
                      pr_rez_ := 100;
                   END IF;
                else
                   IF s080_ = '1'
                   THEN
                      pr_rez_ := 2;
                   ELSIF s080_ = '2'
                   THEN
                      pr_rez_ := 10;
                   ELSIF s080_ = '3'
                   THEN
                      pr_rez_ := 40;
                   ELSIF s080_ = '4'
                   THEN
                      pr_rez_ := 80;
                   ELSIF s080_ = '5'
                   THEN
                      pr_rez_ := 100;
                   END IF;
                end if;
            END IF;

            -- ����������� ����� �������
            szq_ := srq_ * pr_rez_ / 100; -- ����������
            szq2_ := szq2_ * pr_rez_ / 100;
            sz_ := gl.p_ncurval (k.kv, szq_, dat_);--�������

            -- ���� ������ ��� ����� ������� �� ��������
            -- ����������� �������� ��� ��������� � ������������ �������
            -- ������� ����������� � ����������� �������� � ���������
            -- ����� ���� ���� ������� �� �������
            IF soq_ = 0 AND k.nbs LIKE '1%'
            THEN
               sz_ := ostc_ * pr_rez_ / 100;
            END IF;

            --��� ��������� ������� (�� ����. SREZ_ID)
            --����� ��� ������������ �������� � ������������ ������
            idr_ := rez1.id_nbs (k.nbs);


            --1500 ���� ������������� ������ �� ���� ������ ����� -
            -- ��� ����������� ������ ����� � ������������� (1 � 2 ��������������)
            IF k.nbs = '1500'
            THEN
               IF grp_ = 1 OR grp_ = 2
               THEN
                  s080_ := '1';
               ELSE
                  s080_ := '2';
               END IF;
            END IF;

            --��������� �� ��� ��������� - ������������ � �������������
            --� ������� �� ��������� ������ ��� ����������
            IF k.country = '804'
            THEN
               IF s080_ = '1'
               THEN
                  sn_ := '1';
               ELSE
                  sn_ := '2';
               END IF;
            ELSE
               IF grp_ = 1 OR grp_ = 2
               THEN
                  sn_ := '1';
               ELSE
                  sn_ := '2';
               END IF;
            END IF;

            --��� ������������ �������� �� ������� �����. ����� ��� �������
            --(1 - ����, 2 - ��, 3 - ���)
            --������ �� ������� ���� ������� ���� �� ���� ���� �����
            -- ��� ������-�� ����� ��� � �� ���� �� ���� ����

            IF rezpar1_ = '1' AND k.custtype = '3'
            THEN
               custtype_ := '2';
            --����� ���� ����������������� ��������� ����� �������� �� ����
            --�� �� ���� ��� ����� �������
            elsif k.custtype = '1' and k.nbs in ('2620','2625') then
               custtype_:='3';
            ELSE
               custtype_ := k.custtype;
            END IF;

            -- ��������� ����������� ������ ������� �� �������������
            --1. �����'������ � ������������ �볺��� �� ���������� �����, �� ����� ���� ������ �� ����
            IF k.nbs = '9129' AND k.r013_2 = '9'
            THEN
               to_log
                    (k.acc,
                     '����������� ���������: nbs = 9129 r013=9. ������ = 0.',
                     ''
                    );
               sz_   := 0;
               szq_  := 0;
               szq2_ := 0;
               ostq_ := 0;
               srq_  := 0;
            --2. ����, �� ����� �볺���� �� ����������� ���������
            ELSIF k.nbs = '9003' AND k.r013_2 = '1'
            THEN
               to_log
                    (k.acc,
                     '����������� ���������: nbs = 9003 r013=1. ������ = 0.',
                     ''
                    );
               sz_   := 0;
               soq_  := srq_;
               szq_  := 0;
               szq2_ := 0;
             --stq_  := 0;
               srq_  := 0;

            --3.
            -- ������i��i �������� �� ������� �������� � i���� ������, ��� ��� (������i)
            -- ������i��i �������� �� ������� �������� � ���   (������i)
            ELSIF k.nbs = '1502' AND k.r013_2 IN ('1', '3')
            THEN
               to_log (k.acc,
                          '����������� ���������: nbs = 1502 r013='
                       || k.r013_2
                       || '. ������ = 0.',
                       ''
                      );
               sz_   := 0;
               szq_  := 0;
               szq2_ := 0;
               ostq_ := 0;
            END IF;

            rezerv_ := sz_;

            to_log (k.acc, '��������� �������:', '');
            to_log (k.acc, 's080', s080_ || '(' || s080_name_ || ')');
            to_log (k.acc, '������', k.country);
            --curacc_ := NULL;
           -- DBMS_OUTPUT.put_line (   'ostc_ + del_='
             --                     || TO_CHAR (ROUND (ostc_ + del_))
               --                  );
           
           --�������� ������������ ���������� OB22 � R013 �� ������ 9129
           --������ ��� �����
           if nvl(GetGlobalOption('OB22'),0) = 1 then
               if substr(k.nls ,1, 4) = '9129' then
--                  select count(*) into qnt_ 
--                  from srezerv_ob22 
--                  where nbs = '9129' and ob22 = k.OB22; 
                  
                  if ((k.r013_2 = '9' and (k.ob22 = '04' or
                                           k.ob22 = '05' or
                                           k.ob22 = '07' or
                                           k.ob22 = '03' or
                                           k.ob22 = '12' or
                                           k.ob22 = '13' or
                                           k.ob22 = '11')) 
                   or (k.r013_2 = '1' and (k.ob22 <> '04' and
                                           k.ob22 <> '05' and
                                           k.ob22 <> '07' and
                                           k.ob22 <> '03' and 
                                           k.ob22 <> '12' and
                                           k.ob22 <> '13' and
                                           k.ob22 <> '11'))
                      ) then
                    p_error( 4, substr(k.nls,1,4)||'/'||k.OB22,null, null, 
                             k.kv, k.tobo, substr(k.nls,1,4)||'/'||k.OB22, 
                             null, null, k.custtype*100, k.nls||' (R013='||
                             k.r013_2||', OB22='||k.OB22||')','���. �� = '||
                             k.nd_2||', � �� = '||cc_id_);
                  end if;
               end if;
           end if;      
            --���������� ������������ ������
            IF mode_ <> 2
            THEN
               INSERT INTO tmp_rez_risk
                           (dat,      -- ���� ������� �������
                            ID,       -- ������������ ����������� ������
                            s080,     -- ��������� �����
                            s080_name,-- ������������ ��������� �����
                            custtype, -- ��� �������
                            rnk,      -- ��� �������
                      -----------------------------     
                            nmk,      -- ������������ �������
                            kv,       -- ��� ������
                            nls,      -- ���� ��������� �����
                            sk,       -- ������� � �������� �� ����� ������ � 
                                      -- ������ �� �� �������� ����
                      ----------------------------- 
                            skq,      -- ������� � �����������
                            soq,      -- ����������� ����������� 
                      -----------------------------
                            srq,      -- ������ ��������� ���� = ������� �� 
                                      -- ����� ������� �������� � 
                                      -- ������ - ������� - ����������� 
                                      -- �����������
                            szq,      -- ������ � �����������
                            sz,       -- ������ � ��������
                            cc_id,    -- ����� ���������� ��������
                      -----------------------------
                            idr,      -- ��� ���� �������
                            fin,      -- ������� 
                            obs,      -- ������������ �����
                            rs080,    -- ��������� ��������� �����
                      -----------------------------
                            country,  -- ������ ����������� 
                            pr_rez,   -- % �������������� 
                            rz,       -- �������������
                            acc,      -- acc ����� ������
                            nd,       -- �������� ���������� ��������
                            wdate,    -- ��������� ���� ��������
                      -----------------------------
                            kdate,    -- ���� ���������� ��������
                            sg,       -- ��������� ����� ���������� ���.���.
                            sv,       -- ��������� ����� ���������� ���.���.
                            kprolog,  -- �-�� �����������
                            pawn,     -- ��� �����������, 40 - ��������� �����.
                            obesp,    -- ����������� ����������� ��� ����� %
                      -----------------------------
                            dat_prol, -- ���� �����������
                            isp,      -- ������������� ����������� �� �����
                            otd,      -- ����� ���.�����������
                            tobo,     -- ����
                      -----------------------------
                            skq2,     -- ������� �� ����� ������� �������� � 
                                      -- ������, ��� 9129 = 50% � �.�.
                      -----------------------------
                            discont,  -- ����������� �������
                            prem,     -- ������
                            sn,       -- ������� (�����������/�������������
                            szq2,     -- ������ � ����������� ��� ����� ��������
                            corp,     -- ������� �������������� ������� 
                      ----------------------------- 
                            istval,   -- ������� ������� ��������� ���.�������
                            odncre,   -- ������� ����������� �������
                            dnipr,    -- ��� ��������� ����������� �������
                            fl_newacc -- 'n'-�����,'i'-� ������� ���.��� � ���� - ���
                           )
                    VALUES (dat_, id_, s080_, s080_name_, custtype_, k.rnk,
                            k.nmk, k.kv, k.nls, ROUND (ostc_ + del_),
                            ROUND (ostqold_ + delq_), ROUND (soq_),
                            ROUND (srq_), ROUND (szq_), ROUND (sz_), cc_id_,
                            idr_, k.fin, obs_, rez1.r_s080 (k.fin, obs_),
                            k.country, pr_rez_, k.rz, k.acc, nd_, wdate_,
                            kdate_, sg_, sv_, kprolog_, vid_zal, zal_,
                            dat_prol_, k.isp, otd_, k.tobo,
                            GREATEST (ostq_ - discont_ + prem_, 0),
                            discont_, prem_, sn_, ROUND (szq2_), k.corp,
                            istval_, odncre_, dnipr_,'n'
                           );

              -- ������� ���������� ������������ ��� ������� �������
              insert into TMP_REZ_PARAMS
                    (dat , id , acc  , r013    , s270, istval  , s090  ,
                     ob22, s370)
              values(dat_, id_, k.acc, k.r013_2, null, k.istval, k.s090,
                     k.ob22, 
                     null);


            END IF;
         END IF;
      END LOOP;
      CLOSE c0;
      END;

      obs_ := 3;

   --��� ������ ������������ % ������� ��������������� �������� �� ���������� �����
      SELECT MAX (fdat) into datpr_
                        FROM fdat
                        WHERE fdat NOT IN (SELECT holiday
                                             FROM holiday) AND
                            fdat <= add_months(LAST_DAY (dat_),-1);

     IF (dat_ - 31) >=  datpr_ THEN   

        INSERT INTO rez_KOR_PROV (acc, s, vdat)
          SELECT o.acc, NVL (SUM (DECODE (o.dk, 1, o.s, -o.s)), 0), p.vdat
             FROM opldok o, oper p, v_gl a
            WHERE 
              o.fdat > datpr_ --dat_- 31
              AND o.fdat <= datpr_ + 15 --dat_
              AND o.sos = 5
              AND p.REF = o.REF
              AND p.vob = 96
              AND p.vdat = datpr_--dat_
--            AND (dat_ - 31) >=  datpr_
              and a.acc = o.acc AND a.tip in ('SPN','SK9','OFR')
              group by o.acc, p.vdat;
     END IF;

     vid_zal := null;
     zal_ := 0;


-- ������� �� ������������ ��������� � ������������ ���������
--1. �� ����������� �����������
--2. �������������  
     --2.1. ������������ ����� 30 ���� ������!!!!
     --2.2. ���� �������� S270 = 08 - ������������� ��� �������� 
     --     (� �����������, � ������������ �� 30, � ������������ �����)
     --      ����� �� ��������� S270 = 08 ������������ ���������� rezpar11_ = 1
--3. % �������������� ������ 100%
--4. ��������� ����� ���� - 9 � ������� CRISK
--***********************************************************
--    ������ MIK 08-12-2010
      DECLARE
         TYPE r0Typ IS RECORD (
              tip      accounts.tip%TYPE,
              rnk      customer.rnk%TYPE,
              nmk      customer.nmk%TYPE,
              custtype customer.custtype%TYPE,  
              tobo     accounts.tobo%TYPE,
              s080     specparam.s080%TYPE,
              r013     specparam.r013%TYPE,
              s370     specparam.s370%TYPE, 
              acc      accounts.acc%TYPE,
              kv       accounts.kv%TYPE,
              nls      accounts.nls%TYPE,
              isp      accounts.isp%TYPE,
              priz     VARCHAR2(2),
              nbs      accounts.nbs%TYPE,
              fin      customer.crisk%TYPE,
              country  customer.country%TYPE,
              rz       customer.codcagent%TYPE,
              corp     customerw.VALUE%TYPE,
              daos     accounts.daos%TYPE,
              s182     specparam.s182%TYPE,
              s270     specparam.s270%TYPE,
              otd      otd_user.otd%TYPE,
              ostc     accounts.ostc%TYPE,
              nd       nd_acc.nd%TYPE,
              wdate    DATE,
              cc_id    cc_deal.cc_id%TYPE,
              obs      cc_deal.obs%TYPE,
              k_date   DATE
   );
   k r0Typ;

      BEGIN

      IF acckr_ is null and rezpar11_ = 1 THEN
       --�� ���� ������ � ��������� S270 = 08 (�.�. ��������������� ����� ��� %)
         OPEN c0 FOR
         select t.tip,
                c.rnk,      -- ��� �������
                decode(c.custtype,3,SUBSTR (c.nmk, 1, 35),
                       nvl(substr(c.nmkk,1,35),SUBSTR (c.nmk, 1, 35))) nmk, --������������ �������
                DECODE (TRIM (c.sed),'91', DECODE (custtype, 3, 2, custtype),
                        c.custtype) custtype,   -- ��� �������
                t.tobo,     -- ����
                t.s080,     -- ��������� �����
                t.r013,     -- NBS+R013
                t.s370,     -- ������������ ���������(J)-�������� ��� ����� � ������
                t.acc,      -- ��� �����
                t.kv,       -- ��� ������
                t.nls,      -- ����� �����
                t.isp,      -- ������������� �����������
                t.priz,     -- SUBSTR (a.nbs, 3, 2) ='80'- ������������ �������������
                t.nbs,      -- ���������� ����
                NVL( dd.FIN, c.CRISK ) fin,-- �������
                NVL (c.country, acountry) country, -- ��� ������
                DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz, 
                            -- ������������� 2 - ���������� 1 - ��������
                MIN (cw.VALUE) corp, 
                t.daos,     -- ���� �������� �����
                t.s182,     -- ��� ������� (1-����������.2-���������.3-����.�����)
                t.s270,     -- '08' - �������� ����������� �������� � ������ �������
                min(o.otd) otd, -- ����� �������������� ����������� �� �����
                t.ostc,     -- ������� �� �����
                t.nd,       -- �������� ���������� ��������
                nvl(d.wdate,t.daos) wdate,      -- ���� ������ ��������
                SUBSTR (dd.cc_id, 1, 20) cc_id, -- ����� ��������
                dd.obs obs, -- ������������ ����� (1-�����, 2-����.3-�������.) 
                dd.wdate k_date  -- ���� ���������� ���������� �������� 
         from ( select a.tip, a.tobo,NVL (p.s080, '') s080, NVL (p.r013, '') r013,
                       p.s370,a.acc, a.rnk, a.kv,a.nls, a.isp, 
                       SUBSTR (a.nbs, 3, 2) priz, a.nbs,a.daos,p.s182,p.s270,
                      (nvl(s.ostf,0)-nvl(s.dos,0)+nvl(s.kos,0)+nvl(kp.s,0)) ostc,
                       n.nd
                from  v_gl a 
                left join specparam p on a.acc = p.acc
                left join (SELECT acc, MAX ( case when fdat <= dat_ 
                                                  then fdat 
                                             else null end ) fdat
                           FROM saldoa
                           GROUP BY acc) sel on a.acc = sel.acc
                left join saldoa s on s.acc = sel.acc and s.fdat = sel. fdat
                left join rez_KOR_PROV kp on a.acc = kp.acc and kp.vdat is null
                left join (select acc, max(nd) nd from nd_acc
                           group by acc)n on a.acc = n.acc
                -- �� ������������� ����� REZ_N=1 - �� ���������� � ������ (L.09-09-2010)
                left join accountsw aw on a.acc=aw.acc and aw.tag='REZ_N'
                where  (a.tip in ('SP ','SPN','SK9','OFR','SK0') or a.nbs='3570' ) and (a.dazs IS NULL OR a.dazs > dat_) 
                       and (nvl(s.ostf,0)-nvl(s.dos,0)+nvl(s.kos,0)+nvl(kp.s,0))<0 and NVL(aw.value,'0')<>'1') t
         join customer c on t.rnk = c.rnk
         left join customerw cw on c.rnk + t.ostc*0=cw.rnk and cw.tag = 'CORP'
         left join otd_user o on t.isp + t.ostc*0=o.userid
         left join cc_add d on t.nd = d.nd  AND d.adds = 0
         left join cc_deal dd on t.nd = dd.nd
       group by t.tip, c.rnk, decode(c.custtype,3,SUBSTR (c.nmk, 1, 35),
                nvl(substr(c.nmkk,1,35),SUBSTR (c.nmk, 1, 35))),
                DECODE (TRIM (c.sed),'91', DECODE (custtype, 3, 2, custtype),
                c.custtype),t.tobo,t.s080,t.r013,t.s370,t.acc, t.kv,t.nls, 
                t.isp, t.priz, t.nbs, 
                NVL( dd.FIN, c.CRISK ),
                NVL (c.country, acountry),DECODE (NVL (c.codcagent, 1), '2', 
                2, '4', 2, '6', 2, 1),t.daos,t.s182,t.s270,t.ostc,t.nd,
                nvl(d.wdate,t.daos),SUBSTR (dd.cc_id, 1, 20),dd.obs,dd.wdate;
      ELSIF acckr_ IS NULL AND rezpar11_ = 0 THEN 
--�� ���� ������ � �� ��������� S270 = 08 (�.�. ����������� ������ ������������ %)
         OPEN c0 FOR
         select a.tip, c.rnk, decode(c.custtype,3,SUBSTR (c.nmk, 1, 35),
                              nvl(substr(c.nmkk,1,35),SUBSTR (c.nmk, 1, 35))) nmk,
                 DECODE (TRIM (c.sed),
                         '91', DECODE (custtype, 3, 2, custtype),
                         c.custtype
                        ) custtype,  --T 02.12.2008
                 a.tobo,
                 NVL (p.s080, '') s080,
                 NVL (p.r013, '') r013,
                 p.s370, 
                 a.acc, a.kv,
                 a.nls, a.isp, SUBSTR (a.nbs, 3, 2) priz, a.nbs, 
                 NVL((select FIN from cc_deal where nd=rez1.f_get_nd(a.acc)), c.CRISK ) fin,
                 NVL (c.country, acountry) country,
                 DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz,
                 cw.corp,
                 a.daos,--T 23.01.2008
                 p.s182 --T 23.01.2008
                ,p.s270 --T 19.03.2009
                 ,o.otd --T 25.02.2009
                 ,null ostc
                ,null nd
                ,null  wdate
                 ,null cc_id,
                 null obs, null k_date
        from v_gl a, customer c, specparam p,
             (select rnk,MIN (VALUE) corp      from customerw cw  WHERE tag = 'CORP' group by rnk) cw,
             (select o.userid, min(o.otd) otd  FROM otd_user o    group by o.userid ) o
        where (a.tip in ('SP ','SPN','SK9','OFR','SK0') or a.nbs='3570' )
               AND (a.dazs IS NULL OR a.dazs > dat_)
               AND a.rnk = c.rnk
               AND a.acc = p.acc(+)
               AND c.rnk = cw.rnk(+)
               and a.isp = o.userid(+);
     ELSIF acckr_ IS NOT NULL THEN 
--�� ������ ����� 
        OPEN c0 FOR
        select a.tip, c.rnk, decode(c.custtype,3,SUBSTR (c.nmk, 1, 35),
                         nvl(substr(c.nmkk,1,35),SUBSTR (c.nmk, 1, 35))) nmk,
               DECODE (TRIM (c.sed),'91', DECODE (custtype, 3, 2, custtype),
                       c.custtype) custtype,  
               a.tobo, NVL (p.s080, '') s080, NVL (p.r013, '') r013, p.s370, 
               a.acc, a.kv, a.nls, a.isp, SUBSTR (a.nbs, 3, 2) priz, a.nbs, 
               NVL((select FIN from cc_deal 
                    where nd=rez1.f_get_nd(a.acc)),c.CRISK ) fin,
               NVL (c.country, acountry) country,
               DECODE (NVL (c.codcagent, 1), '2', 2, '4', 2, '6', 2, 1) rz,
               (select MIN (VALUE) from customerw cw
                WHERE tag = 'CORP' and c.rnk = cw.rnk) corp,
               a.daos,p.s182,p.s270,
               (select  min(o.otd) otd FROM otd_user o
                where a.isp = o.userid) otd,
               null ostc,null nd,null wdate,null cc_id,null obs, null k_date
        from v_gl a, customer c, specparam p
        where (a.tip in ('SP ','SPN','SK9','OFR','SK0') or a.nbs='3570' ) AND (a.dazs IS NULL OR a.dazs > dat_)
               AND a.rnk = c.rnk AND a.acc = p.acc(+) and a.acc = acckr_;
      ELSE
         NULL;
      END IF;

      LOOP

         FETCH c0 INTO k;
         EXIT WHEN c0%NOTFOUND;
--         logger.info ('REZZ1 - ���� ' || k.nls);
         curacc_ := k.acc;
         set_log(k.acc);
         to_log (k.acc,'����=', k.nls);
         to_log (k.acc,'k.R013=', k.r013);
         to_log (k.acc,'k.S270=', k.s270);      
         to_log (k.acc,'k.S370=', k.s370);
         to_log (k.acc,'k.PRIZ=', k.priz);
         to_log (k.acc,'k.OSTC=', k.ostc);  
         to_log (k.acc,'k.nd  =', k.nd);                      

         otd_ := nvl(k.otd,0);
         sz_ := 0;
         discont_ := 0;
         prem_ := 0;
         sn_ := 2;

         nd_ := k.nd;
         wdate_ := k.wdate;
         cc_id_ := k.cc_id;
        -- cc_id_ := nvl(k.cc_id1,k.cc_id);
         obs_ := k.obs;
         kdate_ := k.k_date;
         
         
         --���� �������� s270 �� ����� �� ����������, ������������ ��� �������������
         if k.s270 is null or trim(k.s270) = '00' then
            k.s270 := f_get_s270(dat_, k.s270, k.acc, k.nd);
         end if; 
         
         s370p_ := k.s370;
         s370r_ := f_get_s370(dat_, k.s370, k.acc, k.nd);

         k.s370 := s370r_;
         
         to_log (k.acc,' s270=',k.s270);
         to_log (k.acc,' s370=',k.s370);

         --���� s270 <> '08' �� ����� ����������� % �� ������������
         if not ((SUBSTR (k.nbs, 4, 1) = '8' 
                  or k.nbs='2607' 
                  or k.nbs='2627' 
                  or k.nbs='3570')  and k.s270 <> '08') or k.s370='J' then
          --������� ������� �� �����
             if k.ostc is not null then
                sz_ := -k.ostc;
             else
                sz_ := -rez1.ostc96 (k.acc, dat_);
             end if;

             to_log (k.acc, 'sz_=', sz_);
             to_log (k.acc, '2.k.R013=', k.r013);
             if (k.s270 = '08' and rezpar11_ = 1) or k.s370='J' then --T19.03.2009
                IF (k.r013 = '3' and 
                   (SUBSTR (k.nbs, 4, 1) <> '8' and 
                            k.nbs<>'2607' and 
                            k.nbs<>'2627' and
                            k.nbs<>'3570')) or k.s370='J' then 
                   s080_name_ := '������������ %';
             to_log (k.acc,'1 s080_name_=', s080_name_ );
                else
                   s080_name_ := ' % (S270 = 08)';
             to_log (k.acc,'2 s080_name_=', s080_name_ );
                end if;
             --IF k.priz = '80' OR k.nbs = '3589'
             elsIF k.priz = '80' OR k.nbs = '3589' or k.r013 = '3' --T 21.01.2009
             THEN
                --������������ %
                s080_name_ := '������������ %';
             to_log (k.acc,'3 s080_name_=', s080_name_ );
             elsIF k.r013 = '2' --T 24.03.2009
             THEN
                --������������ > 30
                s080_name_ := '�������.(>31�)';
             to_log (k.acc,'4 s080_name_=', s080_name_ );
             ELSE
                    --������������ ����� 31 ��� %
                    -- ������� 31 ���� ����� � ��
                IF    rzprr013_ = '0' AND rezpar8_ = '0'
                   OR (rezpar8_ = '1' AND (k.r013 IS NULL OR k.r013 <> '2'))
                THEN
                   last_work_date_ := dat_; --T  03.06.2009

                   --������� ��������� ����� 30 ����
                   sz_ := f_get_rest_over_30(k.acc, last_work_date_ , sz_); --T 24.03.2009
                   s080_name_ := '�������.(>31�) % (P)';
             to_log (k.acc,'4 s080_name_=', s080_name_ );
             to_log (k.acc,'4 sz_=', sz_);
                ELSIF rzprr013_ = '1'
                      OR (rezpar8_ = '1' AND k.r013 IN ('1', '2'))
                THEN
                   -- dbms_output.put_line('3');
                   IF k.r013 = '2'
                   THEN
                      --dbms_output.put_line('4');
                     -- sz_ := -rez1.ostc96 (k.acc, dat_);
                     null;
                   --   dbms_output.put_line('sz_='||to_char(sz_));
             to_log (k.acc,'5 sz_=', sz_);
                   ELSE
                      --dbms_output.put_line('41');
                      sz_ := 0;
             to_log (k.acc,'6 sz_=', sz_);
                   END IF;
                END IF;
             END IF;

             to_log (k.acc,'Itog sz_=', sz_);
             --������� ����� ������� ������ ���� ���� �������� �������
             IF sz_ > 0
             THEN
                -- dbms_output.put_line('5');
                idr_ := rez1.id_nbs (k.nbs); --��� ���������� ������
                szq_ := gl.p_icurval (k.kv, sz_, dat_); -- �������
                rezerv_ := sz_;
                IF    rezpar1_ = '1' AND k.custtype = '3'                                    THEN  custtype_ := '2';
                ELSIF rezpar7_ = '1' AND k.custtype IN ('2', '3') AND k.tip in ('SK9','OFR') THEN  custtype_ := '1';
                ELSE                                                                               custtype_ := k.custtype;
                END IF;

                --������� ��������� �������� (��� ������ �������)
                IF mode_ <> 2 AND calcdoppar_ = 1
                THEN
                   -- ��� �����������

                   --��� ���
                   BEGIN
                      SELECT SUBSTR (cc_id, 1, 20), obs, wdate, vidd
                        INTO cc_id_, obs_, kdate_, vidd_
                        FROM cc_deal
                       WHERE nd = nd_;
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         cc_id_ := NULL;
                         obs_ := NULL;
                         nd_ := NULL;
                         kdate_ := NULL;
                         vidd_ := NULL;
                   END;

                   -- ��� �� ������ ���������� �������
                      -- ������ �������� ��������
                   BEGIN
                      SELECT wdate
                        INTO wdate_
                        FROM cc_add
                       WHERE nd = nd_ AND adds = 0;
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         --wdate_ := NULL;
                         wdate_ := k.daos; --T 21.01.2009
                   END;

                   --��� ������ ����������� � ��������� ��������� �����
                   --������ ���� �������� �������� ����� ���� �������� ����� -
                   --�.�. ���� �������� ����� = ���� ������
                   if nvl(k.s182,0) = 3 then wdate_ := k.daos;--T 23.01.2009
                   end if;

                   -- ���-�� �����������
                   BEGIN
                      SELECT COUNT (*)
                        INTO kprolog_
                        FROM cc_prol
                       WHERE nd = nd_ AND acc = k.acc;
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         kprolog_ := 0;
                   END;

                   --�� ��, ��, ��� (���.���,����.,���� �����.��������)
                   kvk_ := k.kv;

                   IF vidd_ = 3
                   THEN
                      BEGIN
                         SELECT kv
                           INTO kvk_
                           FROM v_gl a, nd_acc n
                          WHERE a.acc = n.acc
                            AND a.nbs = '8999'
                            AND nd = nd_
                            AND ROWNUM = 1;
                      EXCEPTION
                         WHEN NO_DATA_FOUND
                         THEN
                            kvk_ := k.kv;
                      END;
                   END IF;

                   --  ��������� ����� � ���. � ���.
                   BEGIN
                      SELECT gl.p_icurval (kvk_, lim2 / 100, dat_), lim2 / 100
                        INTO sg_, sv_
                        FROM cc_lim c
                       WHERE nd = nd_ AND fdat = (SELECT MIN (fdat)
                                                    FROM cc_lim
                                                   WHERE nd = nd_);
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         sg_ := 0;
                         sv_ := 0;
                   END;

                   BEGIN
                      SELECT DISTINCT fdat
                                 INTO dat_prol_
                                 FROM cc_prol
                                WHERE nd = nd_
                                  AND fdat = (SELECT MIN (fdat)
                                                FROM cc_prol
                                               WHERE nd = nd_ AND npp <> 0);
                   EXCEPTION
                      WHEN NO_DATA_FOUND
                      THEN
                         dat_prol_ := NULL;
                   END;
                END IF;

--                curacc_ := NULL;

                --���������� ������������ ���������� 
                IF mode_ <> 2
                THEN
             to_log (k.acc,'INSERT',k.nls);
                   INSERT INTO tmp_rez_risk
                               (dat, ID, s080, s080_name, custtype, rnk,
                                nmk, kv, nls, sk, skq, soq, srq, szq,
                                sz, cc_id, idr, fin, obs,
                                rs080, country, pr_rez, rz,
                                acc, nd, wdate, kdate, sg, sv, kprolog,
                                pawn, obesp, dat_prol, isp, otd, tobo,
                                skq2, discont, prem, sn, szq2, corp
                                ,fl_newacc
                               )
                        VALUES (dat_, id_, decode(k.s080,'8','8','9'), s080_name_, custtype_, k.rnk,
                                k.nmk, k.kv, k.nls, sz_, szq_, 0, szq_, szq_,
                                sz_, cc_id_, idr_, k.fin, obs_,
                                rez1.r_s080 (k.fin, obs_), k.country, 100, k.rz,
                                k.acc, nd_, wdate_, kdate_, sg_, sv_, kprolog_,
                                vid_zal, zal_, dat_prol_, k.isp, otd_, k.tobo,
                                szq_, discont_, prem_, sn_, szq_, k.corp
                                ,'n'
                               );

--                     logger.info ('REZZ1 - INSERT ���� ' || k.nls || 'sz_ '|| sz_); 
             to_log (k.acc,'INSERT TMP_REZ_PARAMS', k.nls);
                     insert into TMP_REZ_PARAMS
                     (dat , id  , acc , r013 ,
                      s270 , istval , s090 ,ob22, s370
                      )
                      values(dat_, id_, k.acc, k.r013,
                      k.s270,null, null,
                     -- (select ob22 from specparam_int where acc = k.acc)
                      null, k.s370
                      );
                END IF;
--               curacc_ := NULL;
             END IF;
        end if;
      END LOOP;
      CLOSE c0;
      END;
   /*  if pr_ = 1 then
         for k in
         (select acc, min(sz1) sz1 from tmp_rez_risk
          where sz1 is not null
                and dat = dat_ and id <> userid_
          group by acc
          )
          loop
            update tmp_rez_risk r
            set r.sz1 = k.sz1
            where r.dat = dat_ and r.id = userid_ and r.acc = k.acc
            ;
          end loop;
      end if;
*/

      --������� ������ ������� �� ���������� ����� 
      --� �� ������� ����� ������� ������� ������� � ��������� � ���������� �������
      IF mode_ <> 2
      THEN
         MERGE INTO tmp_rez_risk n
            USING (SELECT t.ID, t.acc, dat_ dat, t.s080, t.s080_name, t.custtype, t.rnk,
                          t.nmk, t.kv, t.nls, t.sk, t.skq, t.soq, t.srq, t.szq, t.sz, t.cc_id,
                          t.idr, t.fin, t.obs, t.rs080, t.country, t.pr_rez, t.rz, t.nd,
                          t.wdate, t.kdate, t.sg, t.sv, t.kprolog, t.pawn, t.obesp,
                          t.dat_prol, t.isp, t.otd, t.tobo, t.skq2, t.discont, t.prem, t.sn,
                          t.szq2, t.corp, t.istval, t.odncre, t.dnipr
                     FROM tmp_rez_risk t,v_gl a
                    WHERE dat = oldrez_date_ and t.acc=a.acc
                      AND ID = oldrez_userid_ 
                      AND (t.sz <> 0 OR t.sz1 <> 0)) o
            ON (
            n.ID = userid_ and
            n.dat = dat_--o.dat --T 03.02.2009
            AND n.acc = o.acc)
            WHEN MATCHED THEN
               UPDATE
                  SET n.rezold = NVL (o.sz, 0),
                      n.delrez = NVL (n.sz, 0) - NVL (o.sz, 0),
                      n.rezoldq = NVL (o.szq, 0),
                      n.delrezq = NVL (n.szq, 0) - NVL (o.szq, 0),
                      n.delrezqcurs =
                           NVL (n.szq, 0)
                         - (  NVL (o.szq, 0)
                            + gl.p_icurval (COALESCE (n.kv, o.kv),
                                            NVL (n.sz, 0) - NVL (o.sz, 0),
                                            dat_
                                           )
                           ),
                      n.fl_newacc = 'u'
            WHEN NOT MATCHED THEN
               INSERT (n.ID, n.dat, n.acc, n.s080, n.s080_name, n.custtype,
                       n.rnk, n.nmk, n.kv, n.nls, n.sk, n.skq, n.soq, n.srq,
                       n.szq, n.sz, n.cc_id, n.idr, n.fin, n.obs, n.rs080,
                       n.country, n.pr_rez, n.rz, n.nd, n.wdate, n.kdate,
                       n.sg, n.sv, n.kprolog, n.obesp, 
--                     n.pawn, n.obesp, ������ � ����� � ���������������.
--                     ��� ������, �� ������� ��� ������� � ���� ������, 
--                     �� ���������� ����� (n.obesp=0)
                       n.dat_prol,
                       n.isp, n.otd, n.tobo, n.skq2, n.discont, n.prem, n.sn,
                       n.szq2, n.corp, n.istval, n.odncre, n.dnipr,
                       n.fl_newacc, n.rezold, n.delrez, n.rezoldq, n.delrezq,
                       n.delrezqcurs)
               VALUES (--o.ID, o.dat,
                       userid_,  dat_, --T 03.02.2009
                       o.acc, o.s080, o.s080_name, o.custtype,
                       o.rnk, o.nmk, o.kv, o.nls, 0, 0, 0, 0, 0, 0, o.cc_id,
                       o.idr,
                       o.fin, o.obs, o.rs080, o.country, o.pr_rez,
                       o.rz, o.nd, o.wdate, o.kdate, 0, 0, o.kprolog,0, 
--                     o.pawn,o.obesp, 
                       o.dat_prol, o.isp, o.otd, o.tobo, 0, 0, 0, 0,
                       0, o.corp, o.istval, o.odncre, o.dnipr, 'i',
                       NVL (o.sz, 0), -NVL (o.sz, 0), NVL (o.szq, 0),
                       -NVL (o.szq, 0),
                       - (  NVL (o.szq, 0)
                          + gl.p_icurval (o.kv, -NVL (o.sz, 0), dat_)
                         ));

--  Luda 03-09-2010 ����� ��������� �� �������!!! 
--                  (�������� ������ �� ������� �����, ���� ���������
--                   �������� �������������).
--         delete from tmp_rez_risk --T 03.02.2009
--         where ID = userid_ AND dat = dat_ AND fl_newacc = 'i';

         UPDATE tmp_rez_risk
            SET rezold = 0,
                delrez = NVL (sz, 0),
                rezoldq = 0,
                delrezq = NVL (szq, 0),
                delrezqcurs = 0
          WHERE ID = id_ AND dat = dat_ AND (fl_newacc IS NULL or fl_newacc='n');

         --����������� �� ������� ����� ����� ��������� �� ���� �������
         --(���� ��� ����)
         FOR k IN (SELECT   pc.acc, SUM (pc.s) s
                       FROM opldok pd, v_gl ad, opldok pc, v_gl ac
                      WHERE pd.REF = pc.REF
                        AND pd.dk = 0
                        AND pc.dk = 1
                        AND pd.s = pc.s
                        AND pd.acc = ad.acc
                        AND pc.acc = ac.acc
                        AND ad.nbs IN ('2401', '2400', '2490')
                        AND ac.nbs LIKE ('2%')
                        AND pd.sos = 5
                        AND pd.fdat BETWEEN TRUNC (dat_, 'MM') AND dat_
                   GROUP BY pc.acc)
         LOOP
            UPDATE tmp_rez_risk
               SET pogrez = k.s
             WHERE acc = k.acc AND dat = dat_ AND ID = id_;
         END LOOP;

         --������� ������ �� �����������
         IF allzal_.COUNT () <> 0
         THEN
              FORALL i IN allzal_.FIRST .. allzal_.LAST
                INSERT INTO tmp_rez_risk2 VALUES allzal_(i);
         END IF;

         --������� ������ �� ��������
         IF alldisc_.COUNT () <> 0
         THEN
            FORALL i IN alldisc_.FIRST .. alldisc_.LAST
                INSERT INTO tmp_rez_risk3 VALUES alldisc_(i);
         END IF;

         --������� ������ �� ������
         IF allprem_.COUNT () <> 0
         THEN
            FORALL i IN allprem_.FIRST .. allprem_.LAST
                INSERT INTO tmp_rez_risk4 VALUES allprem_(i);
         END IF;
      END IF;

      p_unload_data;
      flagkorprov_ := 0;
      flagallrez_ := 0;

      -- ������ � ����������� �������� (��� ������ � ��� ���������� � �������� ��. �����) 

      DECLARE
         TYPE r0Typ IS RECORD (
              S       number,
              DAT     tmp_rez_risk3.dat%TYPE,
              USERID  tmp_rez_risk3.userid%TYPE,
              ACCS    tmp_rez_risk3.accs%TYPE,
              ACCD    tmp_rez_risk3.accd%TYPE,
              ND      tmp_rez_risk3.nd%TYPE,
              SK      tmp_rez_risk3.sk%TYPE,    
              SDALL   tmp_rez_risk3.sdall%TYPE,
              SKALL   tmp_rez_risk3.skall%TYPE,
              SD      tmp_rez_risk3.sd%TYPE
          );

      k r0Typ;

      BEGIN

         IF rez_disc_=0 then

            -- ������� �� ���� ������ ��������           
            OPEN c0 FOR

            SELECT * 
            from  (select ROUND (sd ) + DECODE ((ROW_NUMBER () OVER 
                         (PARTITION BY nd,dat,userid ORDER BY t.SD DESC)),
                                    1, sdall - (SUM (sd) OVER 
                         (PARTITION BY nd,dat,userid ORDER BY t.SD) ),0) s, t.* 
                   from tmp_rez_risk3 t order by nd)
            where s<>sd and trunc(dat)=dat_;
         ELSE
            -- ������� � �������� ����������� ����� � ������
            OPEN c0 FOR

            SELECT *
            from  (select ROUND (sd ) + DECODE ((ROW_NUMBER () OVER 
                         (PARTITION BY nd,dat,userid ORDER BY t.SD DESC)),
                                    1, sdall - (SUM (sd) OVER 
                         (PARTITION BY nd,dat,userid,substr(ac.nls,1,3),ac.kv ORDER BY t.SD) ),0) s,
                                    t.* 
                   from tmp_rez_risk3 t, v_gl ac, v_gl ad 
                   where trunc(dat)=dat_ and t.accs=ac.acc and t.accd=ad.acc 
                   order by nd)
             where s<>sd and trunc(dat)=dat_;
         END IF;

         LOOP

            FETCH c0 INTO k;
            EXIT WHEN c0%NOTFOUND;
       
            UPDATE tmp_rez_risk3 SET sd = k.s 
            where nd=k.nd and accs=k.accs and accd=k.accd;
 
         END LOOP;

         CLOSE c0;

      END;

      -- ��������� � TMP_REZ_RISK, ����, ��� ���������� � TMP_REZ_RISK3
      FOR K IN (select t.discont,t.acc,d.ds,t.nls 
                from tmp_rez_risk t, 
                     (select sum(sd) ds,accs from tmp_rez_risk3 
                      where dat=dat_ and userid=id_ group by dat,userid,accs) d
                where t.dat=dat_ and t.id=id_ and t.acc = d.accs 
                      and t.discont<>d.ds)
      LOOP
         --logger.info ('DISK2 - k.nls ' || k.nls|| ' ���.='||k.discont || ' ����.='||k.ds);
         UPDATE tmp_rez_risk SET discont = k.ds 
         where acc=k.acc and dat=dat_ and id=id_;

      END LOOP;

      FOR K IN (select acc,pawn,s080 from tmp_rez_risk 
                where dat=dat_ and id=id_ and pawn is not null)
      LOOP
         if k.s080=5 THEN
            vid_zal := 90;
            s031_   := 90; 
         ELSE
         if k.pawn=40 then
            vid_zal := f_rez_s031(dat_,id_,k.acc);
            s031_   := vid_zal;
         ELSE
            begin
               select s031 into s031_
               FROM cc_pawn where pawn=k.pawn;
               vid_zal:=k.pawn;
            EXCEPTION WHEN NO_DATA_FOUND THEN
               s031_:='33';
               vid_zal:=k.pawn;
            end;   
         END IF;
         END IF;  

         to_log (k.acc, 'f_rez_s031',vid_zal); 
         UPDATE tmp_rez_risk SET pawn = vid_zal 
         where acc=k.acc and dat=dat_ and id=id_;

         -- �� �������� ����� ������������ ��� ������ 
         update specparam set s031=s031_ where acc=k.acc;
         IF SQL%ROWCOUNT=0 then 	
           Insert into specparam (acc,s031)
                       Values    (k.acc,s031_);
         END IF;

      END LOOP;
  
      IF mode_ = 10 then --T 04.12.2008 ������� ��� ������� �� ��������
                         -- ��������� ����� ������� ������ ����������� �-� ������� �������
                         --����� ���������� �� ��� ��� ���������
                         --�.�. ������ ������)))
         commit;
      end if;
      
   END rez_risk;

--------------------------------------
   PROCEDURE ca_pay_rez (dat_ DATE, mode_ NUMBER DEFAULT 0)
   IS
      dat_form       DATE;                        -- ���������� �������� ����
      dat2_          DATE;                         -- ������� ���������� ����
      s_old_         NUMBER;
      s_old_q        NUMBER;
      s_new_         NUMBER;
      s_new_q        NUMBER;
      ref_           INT;
      dk_            INT;
      ost_           NUMBER;
      tt_            CHAR (3);
      f7702_         VARCHAR2 (15);
      r7702_         VARCHAR2 (15);
      s6204_         VARCHAR2 (15);
      id_            INT;
      ret1_          INT;
      acc_           INT;
      rnk_           INT;
      nam_a_         VARCHAR2 (38);
      nam_b_         VARCHAR2 (38);
      nazn_          VARCHAR2 (160);
      vob_           NUMBER;
      kurs_          VARCHAR2 (30);
      okpoa_         VARCHAR2 (14);
      okpob_         VARCHAR2 (14);
      rezs_          VARCHAR2 (50);
      otvisp_        NUMBER;
      ern   CONSTANT POSITIVE       := 300;
      err            EXCEPTION;
      erm            VARCHAR2 (1000)
                      := '������� ���������� ���_����� ������_� ������������';
   BEGIN

      --��� ���������
      if nvl(GetGlobalOption('OB22'),0) = 1 then
          execute immediate 'begin REZ_PAY_OB22 (:dat_ , :mode_ ) ; end;'
          using dat_ , mode_;
          RETURN;
      end if;

      -- ��������� ��������� ������ 2
      IF rezpay2_ = 1
      THEN
         ca_pay_rez2 (dat_, mode_);
         RETURN;
      END IF;


      dat2_ := bankdate;

      /* SELECT NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt IN ('ARE', 'AR*') AND sos = 5 AND vdat <= dat_;*/

        SELECT -- + index(oper XIE_VDAT_OPER)
        NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt like 'AR_' AND sos = 5 AND vdat between (dat_-90) and dat_;


      -- ���������� ��� ���. ������������ STAFF.ID
      BEGIN
        /* SELECT ID
           INTO id_
           FROM staff
          WHERE UPPER (logname) = USER;*/
        id_ := user_id;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            id_ := 1;
      END;

      --�������� ���� �� ������ �� ������� �������� ������
      --������������� ����� ���������� �����
      --� 20.01.2009
      if rezpar10_ = 0 then
          for r in
          (select count(*) qnt
            from tmp_rez_risk r
            where r.dat = dat_ and r.id = id_
                  and nvl(r.sz,nvl(sz1, 0))<> 0
                  and not exists
                  (select 1
                   from srezerv s
                   where r.custtype = s.custtype and r.s080 = s.s080 and r.idr = s.id
                         and rez1.id_specrez(r.wdate, r.istval, r.kv, r.idr, r.custtype) = s.SPECREZ
                         and trim(nvl(s.s_fondnr, s.s_fond)) is not null
                  )
           ) loop
             if r.qnt <> 0 then
                bars_error.raise_error('REZ',1);
             end if;
           end loop;
      end if;

      -- ����
      BEGIN
         SELECT SUBSTR (val, 1, 14)
           INTO okpoa_
           FROM params
          WHERE par = 'OKPO';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            okpoa_ := '';
      END;

      IF mode_ = 1
      THEN
         DELETE FROM rez_doc_maket;
      --COMMIT;
      END IF;

      -- ��������������� �����
      FOR k IN (SELECT DISTINCT t.kv, s.s080, s.s_fond, s_fondnr, s.s_form,
                                s.s_formv, s.s_rasf, s.s_rasfv, 1 rz,
                                s.otvisp, s.otvispval
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                 where crisk not in ('9','8')
                                 UNION ALL
                                 SELECT '8', '��������',100 FROM DUAL
                                 UNION ALL
                                 SELECT '9', '�������.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL

                UNION
                SELECT DISTINCT t.kv, s.s080, NVL (s.s_fondnr, s.s_fond), '',
                                s.s_form, s.s_formv, s.s_rasf, s.s_rasfv,
                                2 rz, s.otvisp, s.otvispval
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                 where crisk not in ('9','8')
                                 UNION ALL
                                 SELECT '8', '��������',100 FROM DUAL
                                 UNION ALL
                                 SELECT '9', '�������.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL
                            AND s.s_fondnr IS NOT NULL
                            )
      LOOP
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

         IF k.s080 = '1' OR k.s080 = '9'
         THEN
            tt_ := 'ARE';                                   --��� �����������
         ELSE
            tt_ := 'AR*';                                 --��� �������������
         END IF;

         -- �������� � ��.��� ��� ���.���
         IF k.kv = 980
         THEN
            f7702_ := k.s_form;
            r7702_ := k.s_rasf;

            -- ���������� ����������� ��� VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 6;
            END IF;
         ELSE
            f7702_ := k.s_formv;
            r7702_ := k.s_rasfv;

            -- ���������� ����������� ��� VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 16;
            END IF;
         END IF;

         ----    ��������������� �������
         s_old_ := 0;

         -- ������ ���������� ������� � �� ������� ���.
         BEGIN
--             SELECT ost
--               INTO s_old_
--               FROM sal
--              WHERE fdat = dat_ AND nls = k.s_fond AND kv = k.kv;
            SELECT NVL (SUM (rez1.ostc96 (a.acc, dat_)), 0)
              INTO s_old_
              FROM v_gl a
             WHERE a.nls = k.s_fond AND a.kv = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               s_old_ := 0;
         END;

         IF s_old_ > 0
         THEN
            s_old_q := gl.p_icurval (k.kv, s_old_, dat_form);

--             IF deb.DEBUG
--             THEN
--                deb.TRACE (ern, '2.', s_old_ || ' ' || s_old_q);
--             END IF;

            -- ������ �������� ������ ������ ��� ������� � OPER
            BEGIN
               SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
                 INTO nam_a_, nam_b_
                 FROM v_gl a, v_gl b
                WHERE a.kv = k.kv
                  AND a.nls = k.s_fond
                  AND b.kv = 980
                  AND b.nls = r7702_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  nam_a_ := '��.�����';
                  nam_b_ := '��.��������������� �����';
            END;

            -- �������� �� ��������������� �������
            IF mode_ = 0
            THEN
               gl.REF (ref_);
            END IF;

            IF k.kv <> 980
            THEN
               SELECT ' �� ����� ' || TO_CHAR (cur.rate_o, '99999.0000')
                 INTO kurs_
                 FROM cur_rates cur
                WHERE cur.kv = k.kv
                  AND vdate = (SELECT MAX (vdate)
                                 FROM cur_rates
                                WHERE kv = k.kv AND vdate <= dat_form);
            ELSE
               kurs_ := '';
            END IF;

            IF vob_ <> 96
            THEN
               nazn_ :=
                     '������������� �������, ������������ ������ �� '
                  || TO_CHAR (dat_form, 'dd/mm/yyyy')
                  || kurs_;
            ELSE
               nazn_ :=
                     '��������� �������� �� ������������� �������, '
                  || '������������ ������ �� '
                  || TO_CHAR (dat_form, 'dd/mm/yyyy')
                  || kurs_;
            END IF;

            IF mode_ = 0
            THEN
               INSERT INTO oper
                           (REF, tt, vob, nd, dk, pdat, vdat, datd,
                            datp, nam_a, nlsa, mfoa, id_a,
                            nam_b, nlsb, mfob, id_b, kv, s,
                            kv2, s2, nazn, userid
                           )
                    VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_, dat2_,
                            dat2_, nam_a_, k.s_fond, gl.amfo, okpoa_,
                            nam_b_, r7702_, gl.amfo, okpoa_, k.kv, s_old_,
                            980, s_old_q, nazn_, otvisp_
                           );

               paytt (0,
                      ref_,
                      dat_,
                      tt_,
                      1,
                      k.kv,
                      k.s_fond,
                      s_old_,
                      980,
                      r7702_,
                      s_old_q
                     );
            ELSIF mode_ = 1
            THEN
               INSERT INTO rez_doc_maket
                           (tt, vob, pdat, vdat, datd, datp, nam_a,
                            nlsa, mfoa, id_a, nam_b, nlsb,
                            mfob, id_b, kv, s, kv2, s2,
                            nazn, userid
                           )
                    VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_, nam_a_,
                            k.s_fond, gl.amfo, okpoa_, nam_b_, r7702_,
                            gl.amfo, okpoa_, k.kv, s_old_q, 980, s_old_,
                            nazn_, otvisp_
                           );
            END IF;
         END IF;
      END LOOP;

      -- ������: �� ���� ����� ��������, �������������, ���������� ����� � �������
      FOR k IN (SELECT s.custtype, s.s080, r.NAME, t.kv, s.s_fond, s_fondnr,
                       s.s_form, s.s_formv, s.s_rasf, s.s_rasfv, s.ID, 1 rz,
                       s.otvisp, s.otvispval
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk
                        where crisk not in ('9','8')
                        UNION ALL
                        SELECT '8', '��������',100 FROM DUAL
                        UNION ALL
                        SELECT '9', '�������.%', 100
                          FROM DUAL) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
                UNION
                SELECT s.custtype, s.s080, r.NAME, t.kv,
                       NVL (s.s_fondnr, s.s_fond), '', s.s_form, s.s_formv,
                       s.s_rasf, s.s_rasfv, s.ID, 2 rz, s.otvisp, s.otvispval
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk
                        where crisk not in ('9','8')
                        UNION ALL
                        SELECT '8', '��������',100 FROM DUAL
                        UNION ALL
                        SELECT '9', '�������.%', 100
                          FROM DUAL) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
                   AND s.s_fondnr IS NOT NULL
                   )
      LOOP
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

--   IF deb.debug THEN
--     deb.trace(ern,'1.',k.S080||' '||k.CUSTTYPE||' '||k.kv);
--   END IF;
         IF k.s080 = '1' OR k.s080 = '9'
         THEN
            tt_ := 'ARE';                                   --��� �����������
         ELSE
            tt_ := 'AR*';                                 --��� �������������
         END IF;

         -- �������� � ��.��� ��� ���.���
         IF k.kv = 980
         THEN
            f7702_ := k.s_form;
            r7702_ := k.s_rasf;

            -- ���������� ����������� ��� VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 6;
            END IF;
         ELSE
            f7702_ := k.s_formv;
            r7702_ := k.s_rasfv;

            -- ���������� ����������� ��� VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 16;
            END IF;
         END IF;

         ----    ������������ �������
         s_new_ := 0;

         -- ������ ����� ����� �������
         IF k.rz = 1
         THEN                                       -- ��� ���������� ��� ����
            IF k.s_fondnr IS NULL
            THEN                                                       -- ���
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            ELSIF k.s_fondnr IS NOT NULL AND NVL (k.s_fondnr, 'x') <> k.s_fond
            THEN                                           -- ������ ���������
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  AND r.rz = 1
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            END IF;
         ELSIF k.rz = 2
         THEN                                              -- ��� ������������
            SELECT NVL (SUM (NVL (sz1, sz)), 0)
              INTO s_new_
              FROM tmp_rez_risk r
             WHERE r.s080 = k.s080
               AND r.custtype = k.custtype
               AND r.kv = k.kv
               AND r.dat = dat_
               AND ID = id_
               AND r.idr = k.ID
               AND r.rz = 2
               and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
               ;
         END IF;

         IF s_new_ > 0
         THEN
            -- ������� ���. ����� ����� �������
            s_new_q := gl.p_icurval (k.kv, s_new_, dat_);

--             IF deb.DEBUG
--             THEN
--                deb.TRACE (ern, '!!!3.', s_new_ || ' ' || s_new_q);
--             END IF;

            -- ������� ����� ��������������, ���� �� ���
            IF mode_ = 0
            THEN
               BEGIN
                  SELECT acc
                    INTO acc_
                    FROM v_gl
                   WHERE nls = k.s_fond AND kv = k.kv;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     BEGIN
                        BEGIN
                           SELECT val
                             INTO rnk_
                             FROM params
                            WHERE par = 'OUR_RNK';
                        EXCEPTION
                           WHEN NO_DATA_FOUND
                           THEN
                              rnk_ := 1;
                        END;

                        nam_a_ :=
                           SUBSTR (   '���.���� �� '
                                   || iif_s (k.custtype,
                                             2,
                                             '������',
                                             '��.��.',
                                             '�i�.��.'
                                            )
                                   || '. ���.'
                                   || k.NAME,
                                   1,
                                   38
                                  );
                        op_reg (99,
                                0,
                                0,
                                0,
                                ret1_,
                                rnk_,
                                k.s_fond,
                                k.kv,
                                nam_a_,
                                'ODB',
                                id_,
                                acc_
                               );
                     END;
               END;
            END IF;

            -- ������ �������� ������ ������ ��� ������� � OPER
            BEGIN
               SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
                 INTO nam_a_, nam_b_
                 FROM v_gl a, v_gl b
                WHERE a.kv = k.kv
                  AND a.nls = k.s_fond
                  AND b.kv = 980
                  AND b.nls = f7702_;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  nam_a_ := '��.�����';
                  nam_b_ := '��.������������ �����';
            END;

            -- �������� �� ������������ �������
            IF mode_ = 0
            THEN
               gl.REF (ref_);
            END IF;

            IF k.kv <> 980
            THEN
               SELECT ' �� ����� ' || TO_CHAR (cur.rate_o, '99999.0000')
                 INTO kurs_
                 FROM cur_rates cur
                WHERE cur.kv = k.kv
                  AND vdate = (SELECT MAX (vdate)
                                 FROM cur_rates
                                WHERE kv = k.kv AND vdate <= dat_);
            ELSE
               kurs_ := '';
            END IF;

            IF vob_ <> 96
            THEN
               nazn_ :=
                  SUBSTR (   '���������� ������� ������ �� '
                          || TO_CHAR (dat_, 'dd/mm/yyyy')
                          || kurs_
                          || ' ('
                          || k.NAME
                          || ')',
                          1,
                          160
                         );
            ELSE
               nazn_ :=
                  SUBSTR
                     (   '��������� �������� �� ���������� ������� ������ �� '
                      || TO_CHAR (dat_, 'dd/mm/yyyy')
                      || kurs_
                      || ' ('
                      || k.NAME
                      || ')',
                      1,
                      160
                     );
            END IF;

            IF mode_ = 0
            THEN
               INSERT INTO oper
                           (REF, tt, vob, nd, dk, pdat, vdat, datd,
                            datp, nam_a, nlsa, mfoa, id_a,
                            nam_b, nlsb, mfob, id_b, kv, s,
                            kv2, s2, nazn, userid
                           )
                    VALUES (ref_, tt_, vob_, ref_, 0, SYSDATE, dat_, dat2_,
                            dat2_, nam_a_, k.s_fond, gl.amfo, okpoa_,
                            nam_b_, f7702_, gl.amfo, okpoa_, k.kv, s_new_,
                            980, s_new_q, nazn_, otvisp_
                           );

               paytt (0,
                      ref_,
                      dat_,
                      tt_,
                      0,
                      k.kv,
                      k.s_fond,
                      s_new_,
                      980,
                      f7702_,
                      s_new_q
                     );
            ELSIF mode_ = 1
            THEN
               INSERT INTO rez_doc_maket
                           (tt, vob, pdat, vdat, datd, datp, nam_a,
                            nlsa, mfoa, id_a, nam_b, nlsb,
                            mfob, id_b, kv, s, kv2, s2,
                            nazn, userid
                           )
                    VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_, nam_b_,
                            f7702_, gl.amfo, okpoa_, nam_a_, k.s_fond,
                            gl.amfo, okpoa_, 980, s_new_q, k.kv, s_new_,
                            nazn_, otvisp_
                           );
            END IF;
         END IF;
      END LOOP;

      IF mode_ = 0
      THEN
         UPDATE rez_protocol
            SET userid = id_
          WHERE dat = dat_;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO rez_protocol
                        (userid, dat
                        )
                 VALUES (id_, dat_
                        );
         END IF;
      END IF;

   exception when others then
         rollback;
         erm := '';
         if instr(sqlerrm, 'REZ') = 0 then
           --���� ������ - ���� ��������� ������ ������
           begin
             execute immediate 'select substr(substr(dbms_utility.format_error_backtrace,instr(dbms_utility.format_error_backtrace,'':'')+1),1,900) from dual' into erm;
           exception when others then
              null;
           end;
           erm := substr(substr(sqlerrm,instr(sqlerrm,':')+1),1,99)||': '||erm;
           insert into cp_rez_log (USERID,ID,ROWNUMBER,TXT, VAL, DT)
           values (user_id, null, 1, erm, 'ca_pay_rez', sysdate);
           commit;
           bars_error.raise_error('REZ',5);
         else
           raise;
         end if;
   END ca_pay_rez;

--------------------------------------
   PROCEDURE ca_pay_rez2 (dat_ DATE, mode_ NUMBER DEFAULT 0)
   IS
      dat_form       DATE;                        -- ���������� �������� ����
      dat2_          DATE;                         -- ������� ���������� ����
      s_old_         NUMBER;
      s_old_q        NUMBER;
      s_new_         NUMBER;
      s_new_q        NUMBER;
      ref_           INT;
      dk_            INT;
      ost_           NUMBER;
      tt_            CHAR (3);
      f7702_         VARCHAR2 (15);
      r7702_         VARCHAR2 (15);
      s6204_         VARCHAR2 (15);
      id_            INT;
      id2_           INT;
      ret1_          INT;
      acc_           INT;
      rnk_           INT;
      nam_a_         VARCHAR2 (38);
      nam_b_         VARCHAR2 (38);
      nazn_          VARCHAR2 (160);
      vob_           NUMBER;
      kurs_          VARCHAR2 (30);
      okpoa_         VARCHAR2 (14);
      okpob_         VARCHAR2 (14);
      rezs_          VARCHAR2 (50);
      otvisp_        NUMBER;
      ern   CONSTANT POSITIVE       := 300;
      err            EXCEPTION;
      erm            VARCHAR2 (1000)
                      := '������� ���������� ���_����� ������_� ������������';

dummy number := 0;
s varchar2(100);

   BEGIN

       dat2_ := bankdate;

       /* SELECT NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt IN ('ARE', 'AR*') AND sos = 5 AND vdat < dat_;*/

        SELECT -- + index(oper XIE_VDAT_OPER)
        NVL (MAX (vdat), dat_)
        INTO dat_form
        FROM oper
       WHERE tt like 'AR_' AND sos = 5 AND vdat between (dat_-90) and dat_;

      -- ���������� ��� ���. ������������ STAFF.ID
      BEGIN
         /*SELECT ID
           INTO id_
           FROM staff
          WHERE UPPER (logname) = USER;*/
          id_ := user_id;
      END;

      --�������� ���� �� ������ �� ������� �������� ������
      --������������� ����� ���������� �����
      --� 20.01.2009
      if rezpar10_ = 0 then
          for r in
          (select count(*) qnt
            from tmp_rez_risk r
            where r.dat = dat_ and r.id = id_
                  and nvl(r.sz,nvl(sz1, 0))<> 0
                  and not exists
                  (select 1
                   from srezerv s
                   where r.custtype = s.custtype and r.s080 = s.s080 and r.idr = s.id
                         and rez1.id_specrez(r.wdate, r.istval, r.kv, r.idr, r.custtype) = s.SPECREZ
                         and trim(nvl(s.s_fondnr, s.s_fond)) is not null
                  )
           ) loop
             if r.qnt <> 0 then
                bars_error.raise_error('REZ',1);
             end if;
           end loop;
      end if;
      -- ����
      BEGIN
         SELECT SUBSTR (val, 1, 14)
           INTO okpoa_
           FROM params
          WHERE par = 'OKPO';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            okpoa_ := '';
      END;

      IF mode_ = 1
      THEN
         DELETE FROM rez_doc_maket;
      --COMMIT;
      END IF;

      -- ��������������� �����
      FOR k IN (SELECT DISTINCT s.ID, s.custtype, t.kv, s.s080, s.s_fond,
                                s_fondnr, s.s_form, s.s_formv, s.s_rasf,
                                s.s_rasfv, 1 rz, s.otvisp, s.otvispval
                                ,s.specrez --T 13.01.2009
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                where crisk not in ('9','8')
                                 UNION ALL
                                 SELECT '8', '��������',100 FROM DUAL
                                 UNION ALL
                                 SELECT '9', '�������.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL
                           -- and t.kv = '980'
                UNION
                SELECT DISTINCT s.ID, s.custtype, t.kv, s.s080,
                                NVL (s.s_fondnr, s.s_fond), '', s.s_form,
                                s.s_formv, s.s_rasf, s.s_rasfv, 2 rz,
                                s.otvisp, s.otvispval
                                ,s.specrez --T 13.01.2009
                           FROM srezerv s,
                                tabval t,
                                (SELECT crisk, NAME, rez
                                   FROM crisk
                                 where crisk not in ('9','8')
                                 UNION ALL
                                 SELECT '8', '��������',100 FROM DUAL
                                 UNION ALL
                                 SELECT '9', '�������.%', 100
                                   FROM DUAL) r
                          WHERE r.crisk = s.s080
                            AND s.s_fond IS NOT NULL
                            AND s.s_form IS NOT NULL
                            AND s.s_formv IS NOT NULL
                            AND s.s_rasf IS NOT NULL
                            AND s.s_rasfv IS NOT NULL
                            AND s.s_fondnr IS NOT NULL
                           -- and t.kv = '980'
                            )
      LOOP
dummy := 1;
s :=   k.s_fond;
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

         --if k.kv = '980' then
         IF k.s080 = '1' OR k.s080 = '9'
         THEN
            tt_ := 'ARE';                                   --��� �����������
         ELSE
            tt_ := 'AR*';                                 --��� �������������
         END IF;

         BEGIN
            SELECT isp
              INTO id2_
              FROM v_gl
             WHERE nls = k.s_fond AND kv = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               id2_ := NULL;
         END;

         -- �������� � ��.��� ��� ���.���
         IF k.kv = 980
         THEN
            f7702_ := k.s_form;
            r7702_ := k.s_rasf;

            -- ���������� ����������� ��� VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 6;
            END IF;
         ELSE
            f7702_ := k.s_formv;
            r7702_ := k.s_rasfv;

            -- ���������� ����������� ��� VOB
            IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
            THEN
               vob_ := 96;
            ELSE
               vob_ := 16;
            END IF;
         END IF;

         ----    ��������������� �������
         s_old_ := 0;
dummy := 100;
         -- ������ ���������� ������� � �� ������� ���.
         BEGIN
--            SELECT ost
--              INTO s_old_
--              FROM sal
--             WHERE fdat = dat_ AND nls = k.s_fond AND kv = k.kv;
            SELECT NVL (SUM (rez1.ostc96 (a.acc, dat_)), 0) --T 16.01.2009
              INTO s_old_
              FROM v_gl a
             WHERE a.nls = k.s_fond AND a.kv = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               s_old_ := 0;
         END;
dummy := 101;
         --IF s_old_ > 0
         --THEN
         s_old_q := gl.p_icurval (k.kv, s_old_, dat_form);

         -- ������ �������� ������ ������ ��� ������� � OPER
         BEGIN
            SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
              INTO nam_a_, nam_b_
              FROM v_gl a, v_gl b
             WHERE a.kv = k.kv
               AND a.nls = k.s_fond
               AND b.kv = 980
               AND b.nls = r7702_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               nam_a_ := '��.�����';
               nam_b_ := '��.��������������� �����';
         END;
dummy := 102;
         -- �������� �� ��������������� �������
         IF mode_ = 0
         THEN
            gl.REF (ref_);
         END IF;

         IF k.kv <> 980
            and s_old_ <> 0 --T 19.01.2009
         THEN
            SELECT ' �� ����� ' || TO_CHAR (cur.rate_o, '99999.0000')
              INTO kurs_
              FROM cur_rates cur
             WHERE cur.kv = k.kv
               AND vdate = (SELECT MAX (vdate)
                              FROM cur_rates
                             WHERE kv = k.kv AND vdate <= dat_form);
         ELSE
            kurs_ := '';
         END IF;
dummy := 103;
         IF vob_ <> 96
         THEN
            nazn_ :=
                  '������������� �������, ������������ ������ �� '
               || TO_CHAR (LAST_DAY (dat_form) + 1, 'dd/mm/yyyy')
               || kurs_;
         ELSE
            nazn_ :=
                  '��������� �������� �� ������������� �������, '
               || '������������ ������ �� '
               || TO_CHAR (LAST_DAY (dat_form) + 1, 'dd/mm/yyyy')
               || kurs_;
         END IF;

dummy := 2;
         IF k.kv <> 980
         THEN
            IF s_old_ <> 0
            THEN
dummy := 3;
               IF mode_ = 0
               THEN
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat, vdat,
                               datd, datp, nam_a, nlsa, mfoa,
                               id_a, nam_b, nlsb, mfob, id_b,
                               kv, s, kv2, s2, nazn, userid
                              )
                       VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_,
                               dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                               okpoa_, nam_b_, r7702_, gl.amfo, okpoa_,
                               k.kv, s_old_, 980, s_old_q, nazn_, otvisp_
                              );

                  paytt (0,
                         ref_,
                         dat_,
                         tt_,
                         1,
                         k.kv,
                         k.s_fond,
                         s_old_,
                         980,
                         r7702_,
                         s_old_q
                        );
               ELSIF mode_ = 1
               THEN
dummy := 4;
                  INSERT INTO rez_doc_maket
                              (tt, vob, pdat, vdat, datd, datp,
                               nam_a, nlsa, mfoa, id_a, nam_b,
                               nlsb, mfob, id_b, kv, s, kv2,
                               s2, nazn, userid
                              )
                       VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                               nam_a_, k.s_fond, gl.amfo, okpoa_, nam_b_,
                               r7702_, gl.amfo, okpoa_, k.kv, s_old_q, 980,
                               s_old_, nazn_, otvisp_
                              );


               END IF;
dummy := 5;
            END IF;
         ELSE                          -- ��� ������ ��������������� �� ������
            -- ����� ������ �������
            IF k.rz = 1
            THEN                                   -- ��� ���������� ��� ����
               IF k.s_fondnr IS NULL
               THEN                                                    -- ���
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               ELSIF     k.s_fondnr IS NOT NULL
                     AND NVL (k.s_fondnr, 'x') <> k.s_fond
               THEN                                        -- ������ ���������
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     AND r.rz = 1
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               END IF;
            ELSIF k.rz = 2
            THEN                                           -- ��� ������������
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  AND r.rz = 2
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            END IF;
dummy := 6;
            IF s_old_ <> s_new_
            THEN
               IF s_old_ < s_new_
               THEN                                         -- ��������������
                  nazn_ :=
                        '������������ ������� ��_��� ���������� ������ �� '
                     || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy');
dummy := 7;
                  IF mode_ = 0
                  THEN
                     INSERT INTO oper
                                 (REF, tt, vob, nd, dk, pdat, vdat,
                                  datd, datp, nam_a, nlsa, mfoa,
                                  id_a, nam_b, nlsb, mfob, id_b,
                                  kv, s, kv2,
                                  s2, nazn, userid
                                 )
                          VALUES (ref_, tt_, vob_, ref_, 0, SYSDATE, dat_,
                                  dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                                  okpoa_, nam_b_, f7702_, gl.amfo, okpoa_,
                                  k.kv, -s_old_ + s_new_, 980,
                                  -s_old_ + s_new_, nazn_, otvisp_
                                 );

                     paytt (0,
                            ref_,
                            dat_,
                            tt_,
                            0,
                            k.kv,
                            k.s_fond,
                            -s_old_ + s_new_,
                            980,
                            f7702_,
                            -s_old_ + s_new_
                           );
                  ELSIF mode_ = 1
                  THEN
dummy := 8;
--raise_application_error(-20001, k.s_fond||'  '||s_old_||'   '||s_new_);
                     INSERT INTO rez_doc_maket
                                 (tt, vob, pdat, vdat, datd, datp,
                                  nam_a, nlsa, mfoa, id_a, nam_b,
                                  nlsb, mfob, id_b, kv,
                                  s, kv2, s2,
                                  nazn, userid
                                 )
                          VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                                  nam_a_, k.s_fond, gl.amfo, okpoa_, nam_b_,
                                  r7702_, gl.amfo, okpoa_, 980,
                                  -s_old_ + s_new_,
                                                   --s_new_,
                                  980, -s_old_ + s_new_,
                                  --s_new_,
                                  nazn_, otvisp_
                                 );

                  END IF;
               ELSIF s_old_ > s_new_
               THEN                                         -- ���������������
                  nazn_ :=
                        '��������� ������� ��_��� ���������� ������ �� '
                     || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy');
dummy := 9;
                  IF mode_ = 0
                  THEN
                     INSERT INTO oper
                                 (REF, tt, vob, nd, dk, pdat, vdat,
                                  datd, datp, nam_a, nlsa, mfoa,
                                  id_a, nam_b, nlsb, mfob, id_b,
                                  kv, s, kv2,
                                  s2, nazn, userid
                                 )
                          VALUES (ref_, tt_, vob_, ref_, 1, SYSDATE, dat_,
                                  dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                                  okpoa_, nam_b_, r7702_, gl.amfo, okpoa_,
                                  980, s_old_ - s_new_, 980,
                                  s_old_ - s_new_, nazn_, otvisp_
                                 );

                     paytt (0,
                            ref_,
                            dat_,
                            tt_,
                            1,
                            k.kv,
                            k.s_fond,
                            s_old_ - s_new_,
                            980,
                            r7702_,
                            s_old_ - s_new_
                           );
                  ELSIF mode_ = 1
                  THEN
dummy := 10;
                     INSERT INTO rez_doc_maket
                                 (tt, vob, pdat, vdat, datd, datp,
                                  nam_a, nlsa, mfoa, id_a, nam_b,
                                  nlsb, mfob, id_b, kv,
                                  s, kv2, s2,
                                  nazn, userid
                                 )
                          VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                                  nam_a_, k.s_fond, gl.amfo, okpoa_, nam_b_,
                                  r7702_, gl.amfo, okpoa_, 980,
                                  s_old_ - s_new_, 980, s_old_ - s_new_,
                                  nazn_, otvisp_
                                 );

                  END IF;
               END IF;
            END IF;
         END IF;
dummy := 11;
      END LOOP;

      -- ������: �� ���� ����� ��������, �������������, ���������� ����� � �������
      FOR k IN (SELECT s.custtype, s.s080, r.NAME, t.kv, s.s_fond, s_fondnr,
                       s.s_form, s.s_formv, s.s_rasf, s.s_rasfv, s.ID, 1 rz,
                       s.otvisp, s.otvispval
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
               --    and t.kv = '980'
                UNION
                SELECT s.custtype, s.s080, r.NAME, t.kv,
                       NVL (s.s_fondnr, s.s_fond), '', s.s_form, s.s_formv,
                       s.s_rasf, s.s_rasfv, s.ID, 2 rz, s.otvisp, s.otvisp
                       ,s.specrez --T 13.01.2009
                  FROM srezerv s,
                       tabval t,
                       (SELECT crisk, NAME, rez
                          FROM crisk
                        where crisk not in ('9','8')
                        UNION ALL
                        SELECT '8', '��������',100 FROM DUAL
                        UNION ALL
                         SELECT '9', '�������.%', 100
                           FROM DUAL
                        ) r
                 WHERE r.crisk = s.s080
                   AND s.s_fond IS NOT NULL
                   AND s.s_form IS NOT NULL
                   AND s.s_formv IS NOT NULL
                   AND s.s_rasf IS NOT NULL
                   AND s.s_rasfv IS NOT NULL
                   AND s.s_fondnr IS NOT NULL
                 --  and t.kv = '980'
                   )
      LOOP
dummy := 12;
s :=   k.s_fond;
         IF k.kv = '980'
         THEN
            otvisp_ := NVL (k.otvisp, userid_);
         ELSE
            otvisp_ := NVL (k.otvispval, userid_);
         END IF;

         IF k.kv <> '980'
         THEN
            -- ��� ���.�����������
            BEGIN
               SELECT isp
                 INTO id2_
                 FROM v_gl
                WHERE nls = k.s_fond AND kv = k.kv;
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  id2_ := NULL;
            END;

            IF k.s080 = '1' OR k.s080 = '9'
            THEN
               tt_ := 'ARE';                                --��� �����������
            ELSE
               tt_ := 'AR*';                              --��� �������������
            END IF;

            -- �������� � ��.��� ��� ���.���
            IF k.kv = 980
            THEN
               f7702_ := k.s_form;
               r7702_ := k.s_rasf;

               -- ���������� ����������� ��� VOB
               IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
               THEN
                  vob_ := 96;
               ELSE
                  vob_ := 6;
               END IF;
            ELSE
               f7702_ := k.s_formv;
               r7702_ := k.s_rasfv;

               -- ���������� ����������� ��� VOB
               IF TO_CHAR (dat2_, 'YYYYMM') > TO_CHAR (dat_, 'YYYYMM')
               THEN
                  vob_ := 96;
               ELSE
                  vob_ := 16;
               END IF;
            END IF;

            ----    ������������ �������
            s_new_ := 0;
dummy := 13;
            -- ������ ����� ����� �������
            IF k.rz = 1
            THEN                                    -- ��� ���������� ��� ����
               IF k.s_fondnr IS NULL
               THEN                                                    -- ���
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               ELSIF     k.s_fondnr IS NOT NULL
                     AND NVL (k.s_fondnr, 'x') <> k.s_fond
               THEN                                        -- ������ ���������
                  SELECT NVL (SUM (NVL (sz1, sz)), 0)
                    INTO s_new_
                    FROM tmp_rez_risk r
                   WHERE r.s080 = k.s080
                     AND r.custtype = k.custtype
                     AND r.kv = k.kv
                     AND r.dat = dat_
                     AND ID = id_
                     AND r.idr = k.ID
                     AND r.rz = 1
                     and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                     ;
               END IF;
            ELSIF k.rz = 2
            THEN                                           -- ��� ������������
               SELECT NVL (SUM (NVL (sz1, sz)), 0)
                 INTO s_new_
                 FROM tmp_rez_risk r
                WHERE r.s080 = k.s080
                  AND r.custtype = k.custtype
                  AND r.kv = k.kv
                  AND r.dat = dat_
                  AND ID = id_
                  AND r.idr = k.ID
                  AND r.rz = 2
                  and id_specrez(r.wdate, r.istval,k.kv, r.idr,r.custtype) = k.specrez --T 13.01.2009
                  ;
            END IF;

dummy := 14;
            IF s_new_ > 0
            THEN
               -- ������� ���. ����� ����� �������
               s_new_q := gl.p_icurval (k.kv, s_new_, dat_);

               -- ������� ����� ��������������, ���� �� ���
               IF mode_ = 0
               THEN
                  BEGIN
                     SELECT acc
                       INTO acc_
                       FROM v_gl
                      WHERE nls = k.s_fond AND kv = k.kv;
                  EXCEPTION
                     WHEN NO_DATA_FOUND
                     THEN
                        BEGIN
                           BEGIN
                              SELECT val
                                INTO rnk_
                                FROM params
                               WHERE par = 'OUR_RNK';
                           EXCEPTION
                              WHEN NO_DATA_FOUND
                              THEN
                                 rnk_ := 1;
                           END;

                           nam_a_ :=
                              SUBSTR (   '���.���� �� '
                                      || iif_s (k.custtype,
                                                2,
                                                '������',
                                                '��.��.',
                                                '�i�.��.'
                                               )
                                      || '. ���.'
                                      || k.NAME,
                                      1,
                                      38
                                     );
                           op_reg (99,
                                   0,
                                   0,
                                   0,
                                   ret1_,
                                   rnk_,
                                   k.s_fond,
                                   k.kv,
                                   nam_a_,
                                   'ODB',
                                   id_,
                                   acc_
                                  );
                        END;
                  END;
               END IF;
dummy := 15;
               -- ������ �������� ������ ������ ��� ������� � OPER
               BEGIN
                  SELECT SUBSTR (a.nms, 1, 38), SUBSTR (b.nms, 1, 38)
                    INTO nam_a_, nam_b_
                    FROM v_gl a, v_gl b
                   WHERE a.kv = k.kv
                     AND a.nls = k.s_fond
                     AND b.kv = 980
                     AND b.nls = f7702_;
               EXCEPTION
                  WHEN NO_DATA_FOUND
                  THEN
                     nam_a_ := '��.�����';
                     nam_b_ := '��.������������ �����';
               END;

               -- �������� �� ������������ �������
               IF mode_ = 0
               THEN
                  gl.REF (ref_);
               END IF;

               IF k.kv <> 980
               THEN
                  SELECT ' �� ����� ' || TO_CHAR (cur.rate_o, '99999.0000')
                    INTO kurs_
                    FROM cur_rates cur
                   WHERE cur.kv = k.kv
                     AND vdate = (SELECT MAX (vdate)
                                    FROM cur_rates
                                   WHERE kv = k.kv AND vdate <= dat_);
               ELSE
                  kurs_ := '';
               END IF;

               IF vob_ <> 96
               THEN
                  nazn_ :=
                     SUBSTR (   '���������� ������� ������ �� '
                             || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy')
                             || kurs_
                             || ' ('
                             || k.NAME
                             || ')',
                             1,
                             160
                            );
               ELSE
                  nazn_ :=
                     SUBSTR
                        (   '��������� �������� �� ���������� ������� ������ �� '
                         || TO_CHAR (LAST_DAY (dat_) + 1, 'dd/mm/yyyy')
                         || kurs_
                         || ' ('
                         || k.NAME
                         || ')',
                         1,
                         160
                        );
               END IF;
dummy := 16;
               IF mode_ = 0
               THEN
                  INSERT INTO oper
                              (REF, tt, vob, nd, dk, pdat, vdat,
                               datd, datp, nam_a, nlsa, mfoa,
                               id_a, nam_b, nlsb, mfob, id_b,
                               kv, s, kv2, s2, nazn, userid
                              )
                       VALUES (ref_, tt_, vob_, ref_, 0, SYSDATE, dat_,
                               dat2_, dat2_, nam_a_, k.s_fond, gl.amfo,
                               okpoa_, nam_b_, f7702_, gl.amfo, okpoa_,
                               k.kv, s_new_, 980, s_new_q, nazn_, otvisp_
                              );

                  paytt (0,
                         ref_,
                         dat_,
                         tt_,
                         0,
                         k.kv,
                         k.s_fond,
                         s_new_,
                         980,
                         f7702_,
                         s_new_q
                        );
               ELSIF mode_ = 1
               THEN
dummy := 17;
                  INSERT INTO rez_doc_maket
                              (tt, vob, pdat, vdat, datd, datp,
                               nam_a, nlsa, mfoa, id_a, nam_b,
                               nlsb, mfob, id_b, kv, s,
                               kv2, s2, nazn, userid
                              )
                       VALUES (tt_, vob_, SYSDATE, dat_, dat2_, dat2_,
                               nam_b_, r7702_, gl.amfo, okpoa_, nam_a_,
                               k.s_fond, gl.amfo, okpoa_, 980, s_new_q,
                               k.kv, s_new_, nazn_, otvisp_
                              );

               END IF;
            END IF;
         END IF;
dummy := 18;
      END LOOP;

dummy := 19;
      IF mode_ = 0
      THEN
         UPDATE rez_protocol
            SET userid = id_
          WHERE dat = dat_;

         IF SQL%ROWCOUNT = 0
         THEN
            INSERT INTO rez_protocol
                        (userid, dat
                        )
                 VALUES (id_, dat_
                        );
         END IF;
      END IF;
dummy := 20;
      COMMIT;

     -- raise_application_error(-20001, 'dummy= '||dummy);

   exception when others then
         rollback;
         erm := '';
         if instr(sqlerrm, 'REZ') = 0 then
           --���� ������ - ���� ��������� ������ ������
           begin
             execute immediate 'select substr(substr(dbms_utility.format_error_backtrace,instr(dbms_utility.format_error_backtrace,'':'')+1),1,900) from dual' into erm;
           exception when others then
              null;
           end;
           erm := substr(substr(sqlerrm,instr(sqlerrm,':')+1),1,99)||': '||erm;
           insert into cp_rez_log (USERID,ID,ROWNUMBER,TXT, VAL, DT)
           values (user_id, null, 1, erm, 'ca_pay_rez2', sysdate);
           commit;
           bars_error.raise_error('REZ',5);
         else
           raise;
         end if;
   END ca_pay_rez2;

--------------------------------------
   PROCEDURE delta (id_ INT, dat1_ DATE, dat2_ DATE)
   IS
      sk_1     NUMBER;
      skq_1    NUMBER;
      soq_1    NUMBER;
      srq_1    NUMBER;
      szq_1    NUMBER;
      sz_1     NUMBER;
      sz1_1    NUMBER;
      sk_2     NUMBER;
      skq_2    NUMBER;
      soq_2    NUMBER;
      srq_2    NUMBER;
      szq_2    NUMBER;
      sz_2     NUMBER;
      sz1_2    NUMBER;
      fl_col   NUMBER;
   BEGIN
      DELETE FROM tmp_rez_risks
            WHERE dat = dat1_ AND dat_ = dat2_;

      COMMIT;

      FOR k IN (SELECT DISTINCT ID, s080, s080_name, custtype, rnk, nmk, kv,
                                nls, cc_id, fin, obs, idr, rs080
                           FROM tmp_rez_risk
                          WHERE ID = id_ AND (dat = dat1_ OR dat = dat2_)
                       ORDER BY kv, nls)
      LOOP
         BEGIN
            SELECT sk, skq, soq, srq, szq, sz, sz1
              INTO sk_1, skq_1, soq_1, srq_1, szq_1, sz_1, sz1_1
              FROM tmp_rez_risk
             WHERE dat = dat1_ AND nls = k.nls AND kv = k.kv AND ID = id_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sk_1 := 0;
               skq_1 := 0;
               soq_1 := 0;
               srq_1 := 0;
               szq_1 := 0;
               sz_1 := 0;
               sz1_1 := 0;
         END;

         BEGIN
            SELECT sk, skq, soq, srq, szq, sz, sz1
              INTO sk_2, skq_2, soq_2, srq_2, szq_2, sz_2, sz1_2
              FROM tmp_rez_risk
             WHERE dat = dat2_ AND nls = k.nls AND kv = k.kv AND ID = id_;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sk_2 := 0;
               skq_2 := 0;
               soq_2 := 0;
               srq_2 := 0;
               szq_2 := 0;
               sz_2 := 0;
               sz1_2 := 0;
         END;

         fl_col := 0;

         -- �������� (�����)
         IF sk_1 = 0 AND sk_2 <> 0
         THEN
            fl_col := 1;
         END IF;

         -- ��������
         IF sk_2 = 0 AND sk_1 <> 0
         THEN
            fl_col := 2;
         END IF;

         INSERT INTO tmp_rez_risks
                     (dat, dat_, ID, s080, s080_name, custtype,
                      rnk, nmk, kv, nls, sk, sk_, skq, skq_,
                      soq, soq_, srq, srq_, cc_id, szq, szq_,
                      sz, sz_, sz1, sz1_, fin, obs, idr, rs080,
                      fl
                     )
              VALUES (dat1_, dat2_, id_, k.s080, k.s080_name, k.custtype,
                      k.rnk, k.nmk, k.kv, k.nls, sk_1, sk_2, skq_1, skq_2,
                      soq_1, soq_2, srq_1, srq_2, k.cc_id, szq_1, szq_2,
                      sz_1, sz_2, sz1_1, sz1_2, k.fin, k.obs, k.idr, k.rs080,
                      fl_col
                     );
      END LOOP;

      COMMIT;
   END delta;

--------------------------------------
-- ��������� ���������� ������ �� ��������� ������� TMP_CRTX
-- ������������� ����� � �������������� ��������
-- � ������� ������ ������� ������� �� ������������
   PROCEDURE fill_crtx (p_restdate IN DATE)
   IS
      PRAGMA AUTONOMOUS_TRANSACTION;
   BEGIN
      -- ��������� ��������� �� ��� ������� ��
      -- ��� ����
      IF (g_restdate IS NOT NULL)
      THEN
         RETURN;
      END IF;

      -- ��������� �������
      EXECUTE IMMEDIATE 'truncate table tmp_crtx';

      INSERT INTO tmp_crtx
                  (REF, dk, acc, s, fdat, vdat, vob)
         SELECT /*+INDEX(o) */
                o.REF, o.dk, o.acc, o.s, o.fdat, p.vdat, p.vob
           FROM opldok o, oper p
          WHERE o.REF = p.REF AND o.sos = 5 AND p.vob = 96;

      COMMIT;
      g_restdate := TRUNC (p_restdate);
   END fill_crtx;

------------------------------------------------------------------
-- ������� ���������� ������� �� ����� � ������ ��������������
-- ��������. ��� ������ ����� �������������� �������� ������-
-- ������ ��������� ������� TMP_CRTX
-- � ������� ������ ������� ������� �� ������������
   FUNCTION get_restc (
      p_acccode    IN   accounts.acc%TYPE,
      p_restdate   IN   saldoa.fdat%TYPE
   )
      RETURN saldoa.ostf%TYPE
   IS
      l_rest   saldoa.ostf%TYPE   := 0;
   BEGIN
      -- ��������� �������
      fill_crtx (SYSDATE);

      BEGIN
         -- �������� ����������� ������� �� �����
         SELECT ostf - dos + kos
           INTO l_rest
           FROM saldoa
          WHERE acc = p_acccode
            AND fdat = (SELECT MAX (fdat)
                          FROM saldoa
                         WHERE acc = p_acccode AND fdat <= p_restdate);

         -- ������������ ������� ��������������� ����������
         SELECT l_rest + NVL (SUM (DECODE (t.dk, 1, t.s, -t.s)), 0)
           INTO l_rest
           FROM tmp_crtx t
          WHERE t.acc = p_acccode
            AND t.fdat > p_restdate
            AND t.vdat <= p_restdate;
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            RETURN l_rest;
      END;

      RETURN l_rest;
   END get_restc;

-- ��������� ��������� ��� ��� �������
   PROCEDURE set_date (dat1_ DATE, dat2_ DATE)
   IS
   BEGIN
      curdate_ := dat1_;
      prevdate_ := dat2_;
   END set_date;

-- ������� �������� ����
   FUNCTION curdate
      RETURN DATE
   IS
   BEGIN
      RETURN curdate_;
   END curdate;

-- ���������� �������� ����
   FUNCTION prevdate
      RETURN DATE
   IS
   BEGIN
      RETURN prevdate_;
   END prevdate;

   PROCEDURE p_check_file11 (dat_ DATE)
   IS
      disk1_   NUMBER;
      disk2_   NUMBER;
   BEGIN
      rownumber_ := 0;
--      uselog_ := 1;
      p_f11_nn (dat_);

      DELETE FROM cp_rez_log c
            WHERE c.userid = userid_;

      to_log (0, '������ ��������� ������ #11 � ������� ������� ', '');
      to_log (0, '', '');

       -- ����� ������� ���� � 11 ����� �� ����������� � ������� �������
      -- ������ ������
      FOR k IN (SELECT *
                  FROM rnbu_trace r
                 WHERE SUBSTR (r.kodp, 1, 1) = '1'
                   AND NOT EXISTS (
                          SELECT *
                            FROM tmp_rez_risk t
                           WHERE ID = userid
                             AND dat = dat_
                             AND t.nls = r.nls
                             AND t.kv = r.kv))
      LOOP
         to_log (0,
                 k.nls || '(' || k.kv || ') kodp=' || k.kodp || ' znap='
                 || k.znap,
                 '����������� � ������� �������'
                );
      END LOOP;

      -- ����� ������� ���� � 11 ����� �� ����������� � ������� �������
      FOR k IN (SELECT r.nls, r.kv, r.kodp, r.znap, t.s080, t.skq
                  FROM rnbu_trace r, tmp_rez_risk t
                 WHERE ID = userid
                   AND dat = dat_
                   AND t.nls = r.nls
                   AND t.kv = r.kv)
      LOOP
         IF TO_NUMBER (k.znap) <> k.skq
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #11='
                    || k.znap
                    || ' ���='
                    || TO_CHAR (k.skq),
                    '�� ��������� ������� �� �������� ����'
                   );
         END IF;

         IF SUBSTR (k.kodp, 6, 1) <> k.s080
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #11='
                    || SUBSTR (k.kodp, 6, 1)
                    || ' ���='
                    || k.s080,
                    '�� ��������� ��������� �����'
                   );
         END IF;
      END LOOP;

      -- ������ ��������� � #11 � ������� �������

      -- ����� ����� ��������
      SELECT NVL (SUM (znap), 0)
        INTO disk1_
        FROM rnbu_trace
       WHERE SUBSTR (kodp, 1, 1) = '2';

      SELECT NVL (SUM (discont), 0)
        INTO disk2_
        FROM tmp_rez_risk
       WHERE ID = userid_ AND dat = dat_;

      to_log (0, '', '');
      to_log (0, '������ �������� #11 � ������� ������� ', '');
      to_log (0, '', '');
      --IF disk1_ <> disk2_
      --THEN
      to_log (0,
                 '#11='
              || TO_CHAR (disk1_)
              || ' ���='
              || TO_CHAR (disk2_)
              || ' �����������='
              || TO_CHAR (disk1_ - disk2_),
              '����������� ����� ������ �������� #11 � ������� �������'
             );
      --END IF;
      to_log (0, '', '');

      FOR k IN (SELECT DISTINCT a.nls, a.kv
                           FROM v_gl a, tmp_rez_risk3 t
                          WHERE a.acc = t.accd
                            AND t.sd <> 0
                            AND t.userid = userid_
                            AND t.dat = dat_
                            AND NOT EXISTS (
                                           SELECT *
                                             FROM rnbu_trace r
                                            WHERE r.nls = a.nls
                                                  AND r.kv = a.kv))
      LOOP
         to_log (0, k.nls || '(' || k.kv || ')', '���� ����������� � #11');
      END LOOP;

      FOR k IN (select *
                from (
                    WITH d AS
                         (SELECT   t.accd, SUM (t.sd) sd
                              FROM tmp_rez_risk3 t
                             WHERE t.userid = userid_ AND t.dat = dat_
                          GROUP BY t.accd)
                    SELECT r.nls, r.kv, r.znap, NVL (d.sd, 0) sd
                      FROM d, rnbu_trace r, v_gl a
                     WHERE d.accd(+) = a.acc
                       AND r.nls = a.nls
                       AND r.kv = a.kv
                       AND SUBSTR (r.kodp, 1, 1) = '2'))
      LOOP
         IF k.sd <> k.znap
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #11='
                    || k.znap
                    || ' ���='
                    || TO_CHAR (k.sd),
                    '�� ��������� �������� �������� � #11 � ������� �������'
                   );
         END IF;
      END LOOP;

      FOR d IN (SELECT t.accd, t.accs, ad.nls nlsd, ad.kv kvd,
                       NVL (sd.s080, '?') s080d, ass.nls nlss, ass.kv kvs,
                       NVL (ss.s080, '?') s080s
                  FROM tmp_rez_risk3 t,
                       specparam sd,
                       specparam ss,
                       v_gl ass,
                       v_gl ad
                 WHERE ass.acc = ss.acc(+)
                   AND t.accs = ass.acc
                   AND ad.acc = sd.acc(+)
                   AND t.accd = ad.acc
                   AND t.userid = userid_
                   AND t.dat = dat_)
      LOOP
         IF d.s080d <> d.s080s OR d.s080d = '?' OR d.s080s = '?'
         THEN
            to_log (0,
                       d.nlsd
                    || '('
                    || d.kvd
                    || ')(s080='
                    || d.s080d
                    || ')='
                    || ' '
                    || d.nlss
                    || '('
                    || d.kvs
                    || ')(s080='
                    || d.s080s
                    || ')',
                    '����������� ��������� ����� ������ � ��������'
                   );
         --if d.s080s <> '?' then
         --  update specparam set s080 = d.s080s where acc=d.accd;
         --end if;
         END IF;
      END LOOP;

--      uselog_ := 0;
   END;

   PROCEDURE p_check_file30 (dat_ DATE)
   IS
      zal1_        NUMBER;
      zal2_        NUMBER;
      zalall30_    NUMBER := 0;
      zalallrez_   NUMBER := 0;
   BEGIN
      rownumber_ := 0;
      p_f30 (dat_);
--      uselog_ := 1;

      DELETE FROM cp_rez_log c
            WHERE c.userid = userid_;

      to_log (0, '������ ����������� ����������� #30 � ������� ������� ', '');
      to_log (0, '', '');

      FOR k IN (SELECT *
                  FROM rnbu_trace
                 WHERE (kodp LIKE '12%' OR kodp LIKE '13%')
                   AND kodp NOT LIKE ('128%'))
      LOOP
         zalall30_ := zalall30_ + TO_NUMBER (k.znap);

         SELECT NVL (SUM (t1.spriv), 0)
           INTO zal1_
           FROM tmp_rez_risk2 t1, v_gl a
          WHERE t1.userid = userid_
            AND t1.dat = dat_
            AND t1.accs = k.acc
            AND t1.accz = a.acc
            AND a.nls = k.nls
            AND k.kv = a.kv;

         IF TO_CHAR (k.znap) <> zal1_
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #30 kodp='
                    || k.kodp
                    || ' znap='
                    || TO_CHAR (k.znap)
                    || ' ���='
                    || TO_CHAR (zal1_),
                    '�� ��������� ����� ����������� � #30 � ������� �������'
                   );
         END IF;
      END LOOP;

      FOR k IN (SELECT *
                  FROM tmp_rez_risk t1
                 WHERE t1.ID = userid_ AND t1.dat = dat_)
      LOOP
         zal1_ := LEAST (k.soq, k.skq2);

         SELECT NVL (SUM (TO_NUMBER (znap)), 0)
           INTO zal2_
           FROM rnbu_trace
          WHERE k.acc = acc;

         IF zal1_ <> zal2_
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ') #30='
                    || TO_CHAR (zal2_)
                    || ' ���='
                    || TO_CHAR (zal1_),
                    '�� ��������� ����� ����������� � #30 � ������� �������'
                   );
         END IF;
      END LOOP;

      SELECT NVL (SUM (t1.spriv), 0)
        INTO zalallrez_
        FROM tmp_rez_risk2 t1
       WHERE t1.userid = userid_ AND t1.dat = dat_;

      --IF zalallrez_ <> zalall30_
      --THEN
      to_log
         (0,
          '#30=' || TO_CHAR (zalall30_) || ' ���=' || TO_CHAR (zalallrez_),
          '�� ��������� ����� ����� ������������ ����������� � #30 � ������� �������'
         );
      --END IF;
--      uselog_ := 0;
   END;

   PROCEDURE p_check_file30_11 (dat_ DATE)
   IS
      sr11_    NUMBER;
      sd11_    NUMBER;
      so30_    NUMBER;
      sn30_    NUMBER;
      szq_     NUMBER;
      szq2_    NUMBER;
      proc_    NUMBER;
      proc2_   NUMBER;
   BEGIN
      rownumber_ := 0;
      p_f30 (dat_);
      p_f11_nn (dat_);
--      uselog_ := 1;

      DELETE FROM cp_rez_log c
            WHERE c.userid = userid_;

      to_log (0,
              '������������ ������ #11 � #30 � ������� ���������� �����',
              ''
             );
      to_log (0, '', '');

      FOR k IN (SELECT r.kodp, r.znap, a.acc, a.nls, a.kv
                  FROM rnbu_trace r, v_gl a
                 WHERE SUBSTR (kodp, 1, 1) = '1'
                   AND r.nls = a.nls
                   AND r.kv = a.kv)
      LOOP
         sr11_ := TO_NUMBER (k.znap);

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sd11_
              FROM rnbu_trace
             WHERE kv = k.kv
               AND SUBSTR (nls, 6) = SUBSTR (k.nls, 6)
               AND kodp LIKE '2%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sd11_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO so30_
              FROM otcn_history
             WHERE kodf = '30'
               AND datf = dat_
               AND acc = k.acc
               AND SUBSTR (kodp, 1, 2) IN ('12', '13')
               AND SUBSTR (kodp, 1, 3) <> '128';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               so30_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sn30_
              FROM otcn_history
             WHERE kodf = '30'
               AND datf = dat_
               AND nls = k.nls
               AND kv = k.kv
               AND SUBSTR (kodp, 1, 3) = '128';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sn30_ := 0;
         END;

         BEGIN
            SELECT t.szq, t.pr_rez
              INTO szq_, proc2_
              FROM tmp_rez_risk t
             WHERE t.ID = userid_ AND t.dat = dat_ AND acc = k.acc;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               szq_ := 0;
         END;

         IF SUBSTR (k.kodp, 6, 1) = '1' AND k.kv = '980'
         THEN
            proc_ := 1;
         ELSIF SUBSTR (k.kodp, 6, 1) = '1' AND k.kv <> '980'
         THEN
            proc_ := 2;
         ELSIF SUBSTR (k.kodp, 6, 1) = '2' AND k.kv = '980'
         THEN
            proc_ := 5;
         ELSIF SUBSTR (k.kodp, 6, 1) = '2' AND k.kv <> '980'
         THEN
            proc_ := 7;
         ELSIF SUBSTR (k.kodp, 6, 1) = '3' AND k.kv = '980'
         THEN
            proc_ := 20;
         ELSIF SUBSTR (k.kodp, 6, 1) = '3' AND k.kv <> '980'
         THEN
            proc_ := 25;
         ELSIF SUBSTR (k.kodp, 6, 1) = '4' AND k.kv = '980'
         THEN
            proc_ := 50;
         ELSIF SUBSTR (k.kodp, 6, 1) = '4' AND k.kv <> '980'
         THEN
            proc_ := 60;
         ELSIF SUBSTR (k.kodp, 6, 1) = '5' AND k.kv = '980'
         THEN
            proc_ := 100;
         ELSIF SUBSTR (k.kodp, 6, 1) = '5' AND k.kv <> '980'
         THEN
            proc_ := 100;
         ELSE
            proc_ := 0;
         END IF;

         szq2_ :=
              ROUND (GREATEST (sr11_ - sd11_ - so30_ - sn30_, 0) * proc_ / 100);

         IF szq2_ <> szq_
         THEN
            to_log (0,
                       k.nls
                    || '('
                    || k.kv
                    || ')'
                    || ' �� ������='
                    || TO_CHAR (szq2_)
                    || ' �� �������='
                    || TO_CHAR (szq_),
                    '�� ��������� ������ �� ������ � �������'
                   );
            to_log (0, '�11=' || TO_CHAR (sr11_), '');
            to_log (0, '�11=' || TO_CHAR (sd11_), '');
            to_log (0, '�30=' || TO_CHAR (so30_), '');
            to_log (0, '�30=' || TO_CHAR (sn30_), '');
            to_log (0, '% ����=' || TO_CHAR (proc_), '');
            to_log (0, '% ��� =' || TO_CHAR (proc2_), '');
         END IF;
      END LOOP;

      to_log (0, '', '');
      to_log
           (0,
            '������������ ������ #11 � #30 � ������� ��������� �����, ������',
            ''
           );
      to_log (0, '', '');

      FOR k IN (SELECT DISTINCT SUBSTR (kodp, 6, 1) s080,
                                SUBSTR (kodp, 9, 3) kv
                           FROM tmp_nbu
                          WHERE kodf = '11' AND datf = dat_ AND kodp LIKE '1%'
                       ORDER BY SUBSTR (kodp, 9, 3), SUBSTR (kodp, 6, 1))
      LOOP
         IF k.s080 = '1' AND k.kv = '980'
         THEN
            proc_ := 1;
         ELSIF k.s080 = '1' AND k.kv <> '980'
         THEN
            proc_ := 2;
         ELSIF k.s080 = '2' AND k.kv = '980'
         THEN
            proc_ := 5;
         ELSIF k.s080 = '2' AND k.kv <> '980'
         THEN
            proc_ := 7;
         ELSIF k.s080 = '3' AND k.kv = '980'
         THEN
            proc_ := 20;
         ELSIF k.s080 = '3' AND k.kv <> '980'
         THEN
            proc_ := 25;
         ELSIF k.s080 = '4' AND k.kv = '980'
         THEN
            proc_ := 50;
         ELSIF k.s080 = '4' AND k.kv <> '980'
         THEN
            proc_ := 60;
         ELSIF k.s080 = '5' AND k.kv = '980'
         THEN
            proc_ := 100;
         ELSIF k.s080 = '5' AND k.kv <> '980'
         THEN
            proc_ := 100;
         ELSE
            proc_ := 0;
         END IF;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sr11_
              FROM tmp_nbu
             WHERE kodf = '11'
               AND datf = dat_
               AND SUBSTR (kodp, 6, 1) = k.s080
               AND SUBSTR (kodp, 9, 3) = k.kv
               AND kodp LIKE '1%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sr11_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sd11_
              FROM tmp_nbu
             WHERE kodf = '11'
               AND datf = dat_
               AND SUBSTR (kodp, 6, 1) = k.s080
               AND SUBSTR (kodp, 9, 3) = k.kv
               AND kodp LIKE '2%';
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sd11_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO so30_
              FROM tmp_nbu
             WHERE kodf = '30'
               AND datf = dat_
               AND (kodp LIKE '12%' OR kodp LIKE '13%')
               AND kodp NOT LIKE '128%'
               AND SUBSTR (kodp, 4, 1) = k.s080
               AND SUBSTR (kodp, 5, 3) = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               so30_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO sn30_
              FROM tmp_nbu
             WHERE kodf = '30'
               AND datf = dat_
               AND kodp LIKE '128%'
               AND SUBSTR (kodp, 4, 1) = k.s080
               AND SUBSTR (kodp, 5, 3) = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               sn30_ := 0;
         END;

         BEGIN
            SELECT NVL (SUM (TO_NUMBER (znap)), 0)
              INTO szq_
              FROM tmp_nbu
             WHERE kodf = '30'
               AND datf = dat_
               AND kodp LIKE '15%'
               AND SUBSTR (kodp, 4, 1) = k.s080
               AND SUBSTR (kodp, 5, 3) = k.kv;
         EXCEPTION
            WHEN NO_DATA_FOUND
            THEN
               szq_ := 0;
         END;

         szq2_ :=
              ROUND (GREATEST (sr11_ - sd11_ - so30_ - sn30_, 0) * proc_ / 100);

         IF szq_ <> 0 OR szq2_ <> 0
         THEN
            to_log (0, 's080=' || k.s080 || ' ' || 'kv=' || k.kv, '');
            to_log (0, '������ =' || TO_CHAR (szq2_), '');
            to_log (0, '����   =' || TO_CHAR (szq_), '');
            to_log (0, '�11=' || TO_CHAR (sr11_), '');
            to_log (0, '�11=' || TO_CHAR (sd11_), '');
            to_log (0, '�30=' || TO_CHAR (so30_), '');
            to_log (0, '�30=' || TO_CHAR (sn30_), '');
            to_log (0, '%=' || TO_CHAR (proc_), '');
         END IF;
      END LOOP;

--      uselog_ := 0;
   END;
BEGIN
   -- �������������� ���������� ����������
   g_restdate := NULL;

  /* SELECT ID
     INTO userid_
     FROM staff
    WHERE UPPER (logname) = UPPER (USER);*/
   userid_ := user_id;
   --userid_ := 20094;

   -- ���� - ������������ ��� ���. ����� > 31 % ������������ R013
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rzprr013_
        FROM params
       WHERE par = 'RZPRR013';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rzprr013_ := 0;
   END;

   -- ���� - �� ��������� ��� ��������� ������� � ������
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar1_
        FROM params
       WHERE par = 'REZPAR1';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar1_ := 0;
   END;

   -- ���� - �������� �� ������.������� ����������� ����.������������

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO zal_sp_
        FROM params
       WHERE par = 'ZAL_SP';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         zal_sp_ := 0;
   END;


   -- ���� - �������� ������� � ������ ����������� ����� � ������ 

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rez_disc_
        FROM params
       WHERE par = 'REZ_DISC';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rez_disc_ := 0;
   END;

   -- ���� - �����.������������ �������� ���������� ������ (����� ������)
   -- ���� � ������� ���� ����� ��� ��������� �������� � �� ������ 
   -- ��� ���������� �� ��� ���� ��������� > 30 ����, �� ���������
   -- ��������� ����� ��� ������� � ���������� ������ �������������
   -- �� ����� ������������.
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rez_upz_
        FROM params
       WHERE par = 'REZ_UPZ';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rez_upz_ := 0;
   END;

   -- ���� - ��������� ��� ������� ������������ 26 ��� �������� > 2 ��� (����)
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar2_
        FROM params
       WHERE par = 'REZPAR2';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar2_ := 0;
   END;

   -- ���� - ����������� ��������� ������� 2071 (��� ����)
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar3_
        FROM params
       WHERE par = 'REZPAR3';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar3_ := 0;
   END;

   -- ���� - �� ��������� ��� ������� �������
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar4_
        FROM params
       WHERE par = 'REZPAR4';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar4_ := 0;
   END;

   -- ���� - ������� SK9 ���������������� ������ (custtype=1)
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar7_
        FROM params
       WHERE par = 'REZPAR7';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar7_ := 0;
   END;

   -- ���� - ������ ������� ������������ ��������� �� ���������� ���������
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar8_
        FROM params
       WHERE par = 'REZPAR8';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar8_ := 0;
   END;

   -- ���� - ������ ����� ����� > 30 ���� ��������� �� ���� ���������
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar9_
        FROM params
       WHERE par = 'REZPAR9';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar9_ := 0;
   END;

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar10_
        FROM params
       WHERE par = 'REZPAR10';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar10_ := 0;
   END;

   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpar11_
        FROM params
       WHERE par = 'REZPAR11';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpar11_ := 0;
   END;


   -- ���� - ������� �������������� �� 83 ���������
--    BEGIN
--       SELECT TO_NUMBER (NVL (val, '0'))
--         INTO rezpar5_
--         FROM params
--        WHERE par = 'REZPAR5';
--    EXCEPTION
--       WHEN NO_DATA_FOUND
--       THEN
--          rezpar4_ := 0;
--    END;

   -- ���� - ����������� ��������� ������ ca_pay_rez2
   BEGIN
      SELECT TO_NUMBER (NVL (val, '0'))
        INTO rezpay2_
        FROM params
       WHERE par = 'REZPAY2';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         rezpay2_ := 0;
   END;
END rez1;
/
 show err;
 
PROMPT *** Create  grants  REZ1 ***
grant EXECUTE                                                                on REZ1            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REZ1            to RCC_DEAL;

 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/rez1.sql =========*** End *** ======
 PROMPT ===================================================================================== 
