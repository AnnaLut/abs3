PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mbk.sql =========*** Run *** =======
PROMPT ===================================================================================== 

create or replace package mbk
is
/*
 15.12.2017 ���� ������ - ����� Proc-dr
 08.12.2017 Sta ���������� � Proc-dr
 17.11.2017 ��������-2017 ������� ��������� ����.�����  �� ������ ���.������ - ��� ����� ��22 

*/
    MBK_HEAD_VERS  constant varchar2(64)  := 'version 55.0 02.01.2017';

    ATTR_AWAITING_MAIN_AMOUNT     constant varchar2(30 char) := 'MBDK_AWAITING_MAIN_AMOUNT';
    ATTR_AWAITING_INTEREST_AMOUNT constant varchar2(30 char) := 'MBDK_AWAITING_INTEREST_AMOUNT';

    ----------------------------------------------------------------------

-- 17.11.2017 ������ �. �������� ������� ������� ������ ���� ����� �������� �� ����� ��.������ �� ������ ���.�����, ������� - ������ ����
PROCEDURE op_reg_ex_2017(
          mod_       INTEGER,   -- Opening mode : 0, 1, 2, 3, 4, 9, 99, 77
          p1_        INTEGER,   -- 1st Par      : 0-inst_num   1-nd   2-nd   3-main acc   4-mfo
          p2_        INTEGER,   -- 2nd Par      : -    -    pawn   4-acc
          p3_        INTEGER,   -- 3rd Par (Grp): -    -    mpawn
          p4_ IN OUT INTEGER,   -- 4th Par      : -    -    ndz(O)
         rnk_        INTEGER,   -- Customer number
         NLS_        VARCHAR2,  -- Account  number
          kv_        SMALLINT,  -- Currency code
         nms_        VARCHAR2,  -- Account name
         tip_        CHAR,      -- Account type
         isp_        SMALLINT,
        accR_    OUT INTEGER,
     nbsnull_        VARCHAR2 DEFAULT '1',
     pap_            NUMBER   DEFAULT NULL,
     vid_            NUMBER   DEFAULT NULL,
     pos_            NUMBER   DEFAULT NULL,
     sec_            NUMBER   DEFAULT NULL,
     seci_           NUMBER   DEFAULT NULL,
     seco_           NUMBER   DEFAULT NULL,
     blkd_           NUMBER   DEFAULT NULL,
     blkk_           NUMBER   DEFAULT NULL,
     lim_            NUMBER   DEFAULT NULL,
     ostx_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
   nlsalt_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
     tobo_           VARCHAR2 DEFAULT NULL,
     accc_           NUMBER   DEFAULT NULL) ;
   ------------------------------------------------------


    procedure ro_deal (
        cc_id_new   in varchar2,
        nd_         in integer,
        nd_new      out integer,
        acc_new     out integer,
        nid_        in integer,
        nkv_        in integer,
        nls_old     in varchar2,
        nls_new     in varchar2,
        nls8_new    in varchar2,
        ns_old      in number,
        ns_new      in number,
        npr_old     in number,
        npr_new     in number,
        datk_old    in date,
        datk_new    in date,
        datn_old    in date,
        datn_new    in date,
        nlsb_new    in varchar2,
        mfob_new    in varchar2,
        nlsnb_new   in varchar2,
        mfonb_new   in varchar2,
        refp_new    in number,
        bica_       in varchar2,
        ssla_       in varchar2,
        bicb_       in varchar2,
        sslb_       in varchar2,
        altb_       in varchar2,
        interma_    in varchar2,
        intermb_    in varchar2,
        intpartya_  in varchar2,
        intpartyb_  in varchar2,
        intinterma_ in varchar2,
        intintermb_ in varchar2,
        intamount_  in number );

    ----------------------------------------------------------------------
    function f_nls_mb(
        nbs_    in  varchar2,
        rnk_    in  integer,
        acrb_   in  integer,
        kv_     in  integer,
        maskid_ varchar2)
    return varchar2;

    ----------------------------------------------------------------------
    procedure f_nls_mb(
        p_nbs        in accounts.nbs%type,
        p_rnk        in accounts.rnk%type,
        p_acrb       in accounts.acc%type,
        p_kv         in accounts.kv%type,
        p_maskid     in nlsmask.maskid%type ,
        p_initiator  in cp_ob_initiator.code%type,
        p_acc_num_1 out accounts.nls%type,
        p_acc_num_2 out accounts.nls%type);

    function get_pawn_account_number(
        p_main_account_number in varchar2,
        p_pawn_kind_id in integer,
        p_deal_kind_id in integer,
        p_customer_id in integer,
        p_currency_id in integer)
    return varchar2;

    ----------------------------------------------------------------------
    -- ���������� �������� �� �������������� �� �������� ������������ �� ��������
    --
    procedure collateral_payments(
        p_mbk_id         in     cc_deal.nd%type     -- ��.   �����
        , p_mbk_num        in     cc_deal.cc_id%type  -- ����� �����
        , p_beg_dt         in     cc_deal.sdate%type  -- ���� ����������
        , p_end_dt         in     cc_deal.wdate%type  -- ���� ����������
        , p_clt_amnt       in     oper.s%type         -- ����    ������������
        , p_acc_num        in     oper.nlsa%type      -- ������� ������������
        , p_ccy_id         in     oper.kv%type        -- ������  ������������
        , p_rnk            in     customer.nmk%type   -- ���
        , p_dk             in     oper.dk%type);        -- �/�

    ----------------------------------------------------------------------
    --    ��������� ���������� ���� ���������� ������
    --
    procedure upd_cc_deal (p_nd number, p_sdate date);
    ----------------------------------------------------------------------
    procedure inp_deal (
              cc_id_      varchar2,
              nvidd_      integer ,
              ntipd_      integer ,
              nkv_        integer ,
              rnkb_       integer ,
              dat2_       date    ,
              p_datv      date    ,
              dat4_       date    ,
              ir_         number  ,
              op_         number  ,
              br_         number  ,
              sum_        number  ,
              nbasey_     integer ,
              nio_        integer ,
              s1_         varchar2,
              s2_         varchar2,
              s3_         varchar2,
              s4_         varchar2,
              s5_         number  ,
              nlsa_       varchar2,
              nms_        varchar2,
              nlsna_      varchar2,
              nmsn_       varchar2,
              nlsnb_      varchar2,
              nmkb_       varchar2,
              nazn_       varchar2,
              nlsz_       varchar2,
              nkvz_       integer ,
              p_pawn      number  ,
              id_dcp_     integer ,
              s67_        varchar2,
              ngrp_       integer ,
              nisp_       integer ,
              bica_       varchar2,
              ssla_       varchar2,
              bicb_       varchar2,
              sslb_       varchar2,
              sump_       number  ,
              altb_       varchar2,
              intermb_    varchar2,
              intpartya_  varchar2,
              intpartyb_  varchar2,
              intinterma_ varchar2,
              intintermb_ varchar2,
              nd_    out  integer ,
              acc1_ out   integer ,
              serr_ out   varchar2) ;

    ----------------------------------------------------------------------
    procedure inp_deal_Ex (
              cc_id_        varchar2,
              nvidd_        integer ,
              ntipd_        integer ,
              nkv_          integer ,
              rnkb_         integer ,
              dat2_         date    ,
              p_datv        date    ,
              dat4_         date    ,
              ir_           number  ,
              op_           number  ,
              br_           number  ,
              sum_          number  ,
              nbasey_       integer ,
              nio_          integer ,
              s1_           varchar2,
              s2_           varchar2,
              s3_           varchar2,
              s4_           varchar2,
              s5_           number  ,
              nlsa_         varchar2,
              nms_          varchar2,
              nlsna_        varchar2,
              nmsn_         varchar2,
              nlsnb_        varchar2,
              nmkb_         varchar2,
              nazn_         varchar2,
              nlsz_         varchar2,
              nkvz_         integer ,
              p_pawn        number  ,
              id_dcp_       integer ,
              s67_          varchar2,
              ngrp_         integer ,
              nisp_         integer ,
              bica_         varchar2,
              ssla_         varchar2,
              bicb_         varchar2,
              sslb_         varchar2,
              sump_         number  ,
              altb_         varchar2,
              intermb_      varchar2,
              intpartya_    varchar2,
              intpartyb_    varchar2,
              intinterma_   varchar2,
              intintermb_   varchar2,
              nd_           out integer ,
              acc1_         out integer ,
              serr_         out varchar2,
              DDAte_        date     default null,  -- ���� ����������
              IRR_          number   default null,  -- ��. % ������
              code_product_ number   default null,  -- ��� ��������
              n_nbu_        varchar2 default null,   -- ����� �������� ���
			  d_nbu_        date     default null    -- ���� ��������� ���
) ;


    ----------------------------------------------------------------------
    procedure set_field58d (p_nd number, p_field58d varchar2);

    ----------------------------------------------------------------------
    PROCEDURE del_deal (ND_ integer)  ;

    ----------------------------------------------------------------------
    PROCEDURE clos_deal (ND_ integer)  ;

    ----------------------------------------------------------------------
    PROCEDURE del_Ro_deal (ND_ integer)  ;

    ----------------------------------------------------------------------
    FUNCTION F_GetNazn(MaskId_ varchar2, ND_ number) return varchar2;

    ----------------------------------------------------------------------
    --    ��������� ���������� ������ ���������� � �� �������� ��� ������ ������ ������
    --
    procedure get_print_value (
      p_nd         number,
      p_tic_name   varchar2,
      p_vars   out varchar2,
      p_vals   out varchar2 );

    ----------------------------------------------------------------------
    --    ��������� ��������� ���������� � ������ � ����������
    --
    procedure save_partner_trace(
      p_custCode   in cc_swtrace.rnk%type,
      p_currCode   in cc_swtrace.kv%type,
      p_swoBic     in cc_swtrace.swo_bic%type,
      p_swoAcc     in cc_swtrace.swo_acc%type,
      p_swoAlt     in cc_swtrace.swo_alt%type,
      p_intermb    in cc_swtrace.interm_b%type,
      p_field58d   in cc_swtrace.field_58d%type,
      p_nls        in cc_swtrace.nls%type );

    ----------------------------------------------------------------------
    --    ��������� ������� ������ ���
    --
    procedure unlink_dcp(p_nd number);

    ----------------------------------------------------------------------
    --    ��������� �������� ���������
    --
    procedure link_deal (p_nd number, p_ndi number);

    function get_deal_param (
      p_nd    nd_txt.nd%type,
      p_tag   nd_txt.tag%type)
    return varchar2;

    procedure set_deal_param
    ( p_nd    nd_txt.nd%type,
      p_tag   nd_txt.tag%type,
      p_val   nd_txt.txt%type
    );

/*    ----------------------------------------------------------------------
    --    ��������� �������� ��������� � ��������
    --
    procedure link_nd_ref (p_nd number, p_ref number);

    ----------------------------------------------------------------------
    --    ��������� �������� ���������� � ���������
    --
    procedure link_docs (p_dat date);
*/
    function check_if_deal_belong_to_mbdk(
        p_product_id in integer)
    return char;

    function check_if_deal_belong_to_crsour(
        p_product_id in integer)
    return char;

    function estimate_interest_amount(
        p_product_id in integer,
        p_deal_start_date in date,
        p_deal_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_base in number,
        p_interest_rate in number)
    return number;

    function get_income_account(
        p_balance_account in varchar2,
        p_customer_id in integer,
        p_currency_id in integer,
        p_branch in varchar2 default sys_context('bars_context', 'user_branch'))
    return varchar2;

    procedure edit_selected_reckoning(
        p_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2);

    procedure prepare_deal_interest(
        p_deal_id in integer,
        p_date_to in date);

    procedure prepare_portfolio_interest(
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_date_to in date);

    procedure pay_accrued_interest;

    procedure pay_selected_interest(
        p_id in integer);

    procedure remove_selected_reckoning(
        p_id in integer);

    procedure open_awaiting_amount(
        p_deal_id in integer,
        p_document_id in integer,
        p_main_amount_flag in char);

    procedure close_awaiting_amount(
        p_deal_id in integer,
        p_document_id in integer,
        p_main_amount_flag in char);

    function make_docinput(
        p_nd in integer)
    return cdb_mediator.t_make_document_urls
    pipelined;

    procedure create_pawn_contract(
        p_deal_id in integer,
        p_pawn_kind_id in integer,
        p_pawn_contract_number in varchar2,
        p_registry_number in varchar2,
        p_start_date in date,
        p_expiry_date in date,
        p_pawn_currency_id in integer,
        p_pawn_amount in number,
        p_pawn_fair_value in number,
        p_pawn_location_id in integer,
        p_deposit_id in integer);

    procedure add_lim_sb(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_limit_amount in number,
        p_limit_date in date);

    procedure edit_lim_sb(
        p_uk_value in varchar2,
        p_account_number in varchar2,
        p_currency_id in integer,
        p_limit_amount in number,
        p_limit_date in date);

    procedure delete_lim_sb(
        p_uk_value in varchar2);

    function check_if_42_visa_should_apply(
        p_nostro_document_id in integer)
    return integer;

    ----------------------------------------------------------------------
    --    ���������� ������ ��������� ������
    --
    function header_version return varchar2;

    ----------------------------------------------------------------------
    --    ���������� ������ ���� ������
    --
    function body_version return varchar2;
end;
/
create or replace package body mbk is

    MBK_BODY_VERS   CONSTANT VARCHAR2(64)  := 'version 1 15.12.2017';
/*
 15.12.2017 ���� ������ - ����� Proc-dr

    13.10.2016 Sta - ��� �� ��� ������ ���� �� �����

    28.09.2016 Sta - ������� ��� �������� ����� "��������" �� ��������
       v_pay_mbdk2 as select * from   table ( mbk.make_docinput (to_number(pul.get_mas_ini_val('ND')) )
       ������������ ������ ��� ���

    09.07.2016 BAA - ����� proc. COLLATERAL_PAYMENTS
    07.07.2016 BAA - ����� proc. F_NLS_MB
    04.07.2016 BAA - ����� �� ��������� ��������� � ����. INP_DEAL
                     ������� � ����. DEL_DEAL �� DEL_RO_DEAL
    12.05.2016 BAA - ������ ����� ������� ��������� ��� ��� �������� ��������
    29.09.2015 Sta - ��������� ���.���� ��� �������� �������� = PROCEDURE inp_deal
                     VNCRR �������� ���            \
                     VNCRP ��������=��������� ���  / �� �������� ��.
    12.12.2014 Artem Yurchenko ������� ������ ����������� �������� ���������� ��������� ��
               ��������� ��������
    24.11.2014 Artem Yurchenko ������� ������ ����������� �������� ������ ��������� �� ��������� ��������

    21.03.2014 qwa ������ �������� ���������� GOU �� ������������� (������� �� �������� �����)

    30.09.2013 qwa �������������� ��������� ������������� S180 (������ 1 �����)
                   ��� ����� ����� ������ � �����������, ������ �
                   Fs180_DEF.fnc �� 27-09-2013, FS180.fnc �� 30-09-2013

    10.07.2013 qwa 03.07.2013 qwa �����, ������������ (���������� �������� ������
                                  mbd_k_fi )
                                  ���� �������� ���������� �������
                                  patch179.ndr.mbk

    28.11.2012 qwa ����� �������� ���������� GOU (���������� � OB22, ��� KF)
               �������� ���������� ������� � ����� �� ���������� OB22+GOU -
               ������ ��� �������� �������� �� 39 -- ����� ��� ��������
*/

    DEAL_KIND_CRED_SOUR_LOAN    constant integer := 3902;
    DEAL_KIND_CRED_SOUR_DEPOSIT constant integer := 3903;

    ------------------------------------------------------------------
-- �������� ������� ������� ������ ���� ����� �������� �� ����� ��.������ �� ������ ���.�����, ������� - ������ ����
PROCEDURE op_reg_ex_2017(
          mod_       INTEGER,   -- Opening mode : 0, 1, 2, 3, 4, 9, 99, 77
          p1_        INTEGER,   -- 1st Par      : 0-inst_num   1-nd   2-nd   3-main acc   4-mfo
          p2_        INTEGER,   -- 2nd Par      : -    -    pawn   4-acc
          p3_        INTEGER,   -- 3rd Par (Grp): -    -    mpawn
          p4_ IN OUT INTEGER,   -- 4th Par      : -    -    ndz(O)
         rnk_        INTEGER,   -- Customer number
         NLS_        VARCHAR2,  -- Account  number
          kv_        SMALLINT,  -- Currency code
         nms_        VARCHAR2,  -- Account name
         tip_        CHAR,      -- Account type
         isp_        SMALLINT,
        accR_    OUT INTEGER,
     nbsnull_        VARCHAR2 DEFAULT '1',
     pap_            NUMBER   DEFAULT NULL,
     vid_            NUMBER   DEFAULT NULL,
     pos_            NUMBER   DEFAULT NULL,
     sec_            NUMBER   DEFAULT NULL,
     seci_           NUMBER   DEFAULT NULL,
     seco_           NUMBER   DEFAULT NULL,
     blkd_           NUMBER   DEFAULT NULL,
     blkk_           NUMBER   DEFAULT NULL,
     lim_            NUMBER   DEFAULT NULL,
     ostx_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
   nlsalt_           VARCHAR2 DEFAULT NULL,       -- 'NULL' for update
     tobo_           VARCHAR2 DEFAULT NULL,
     accc_           NUMBER   DEFAULT NULL)
IS  L_NLS accounts.nLs%type := NLS_ ;
    l_NBS accounts.nBs%type := Substr(NLS_,1,4) ;
begin 

  -- ������� ������� � "���" � �������� ������    |-----|
  begin op_reg_ex ( mod_, p1_, p2_, p3_, p4_, rnk_, L_NLS, kv_, nms_, tip_, isp_, accR_, nbsnull_, pap_, vid_, pos_, sec_, seci_, seco_, blkd_, blkk_, lim_ , ostx_,   nlsalt_, tobo_, accc_ ) ;
  exception when others then                 --   |-----|
        -- ��� ����� ��
        if  newnbs.g_state  = 1   then -- ���� ������� ������� ���_2017 , �� �������� ���������������� ����� ���� �������� ( ��� �������� ������ � �����. �.�. ��� ��������� �� ���, �� ��������) 
                                      -- select distinct r020_old, r020_new  from transfer_2017 where r020_old like '15%' or  r020_old like '16%'

           If    l_NBS = '1509'  then  l_NBS := '1508' ;
           ElsIf l_NBS = '1512'  then  l_NBS := '1513' ;
           ElsIf l_NBS = '1517'	 then  l_NBS := '1513' ;
           ElsIf l_NBS = '1527'  then  l_NBS := '1524' ;
           ElsIf l_NBS = '1529'	 then  l_NBS := '1528' ;
           ElsIf l_NBS = '1612'	 then  l_NBS := '1613' ;
           ElsIf l_NBS = '1523'	 then  l_NBS := '1524' ;
           ElsIf l_NBS = '1624'	 then  l_NBS := '1623' ;
           ElsIf l_NBS = '1627'	 then  l_NBS := '1623' ;

           end if;

       ----L_NLS := Vkrzn( Substr( gl.aMfo,1,5), L_NBS || '0' || Substr (l_NLS,6,9) );
           l_NLS := F_NEWNLS2(null, 'MBK', L_NBS , RNK_,null);

        end if; 
        ----------- ������� ������� � ������.��.  |-----|
        op_reg_ex( mod_, p1_, p2_, p3_, p4_, rnk_, L_NLS, kv_, nms_, tip_, isp_, accR_, nbsnull_, pap_, vid_, pos_, sec_, seci_, seco_, blkd_, blkk_, lim_ , ostx_,   nlsalt_, tobo_, accc_ ) ;                                    
                                             --   |-----|
  end;

END    op_reg_ex_2017;
----------------------------

    --    Rollover/�����������
    procedure ro_deal (
        cc_id_new   in varchar2,     /* ����� ����� ������    */
        nd_         in integer,     /* ������ ND             */
        nd_new      out integer,     /* ����� ND ��� �������� */
        acc_new     out integer,     /* ACC ������ �����      */
        nid_        in integer,
        nkv_        in integer,
        nls_old     in varchar2,
        nls_new     in varchar2,
        nls8_new    in varchar2,
        ns_old      in number,
        ns_new      in number,
        npr_old     in number,
        npr_new     in number,
        datk_old    in date,
        datk_new    in date,
        datn_old    in date,
        datn_new    in date,
        nlsb_new    in varchar2,
        mfob_new    in varchar2,
        nlsnb_new   in varchar2,
        mfonb_new   in varchar2,
        refp_new    in number,
        bica_       in varchar2,
        ssla_       in varchar2,
        bicb_       in varchar2,
        sslb_       in varchar2,
        altb_       in varchar2,
        interma_    in varchar2,
        intermb_    in varchar2,
        intpartya_  in varchar2,
        intpartyb_  in varchar2,
        intinterma_ in varchar2,
        intintermb_ in varchar2,
        intamount_  in number )
    is

     ACC_OLD     int;
     RNK_        int;
     VIDD_       int;
     NMK_        varchar2(38);
     ACRA_OLD    int;
     n_          int;
     DAT2_       date;
     sTXT_       varchar2(250);
     ACRA_NEW    int;
     GRP_        int;
     TIP_        char(3);
     KPROLOG_    int;
     ISP_        int;
     D020_       char(2);
     cc_id_      varchar2(20);
     NLSB_OLD    varchar2(34);
     NLSNB_OLD   varchar2(34);
     MFOB_OLD    varchar2(12);
     MFONB_OLD   varchar2(12);
     REFP_OLD    number;
     nG67_       number;
     ACC_SS      int;  /* ��� �������� ����� ��� ��������� ������� ������ */
     ACC_ZAL     int;  /* acc ����� ������                                */
     l_s180      specparam.s180%type;

   BEGIN

     ACC_NEW := to_number(NUll) ;
     VIDD_   := to_number(substr(NLS_NEW ,1,4));
     BEGIN
        -- ��������� ������ ������
        SELECT d.cc_id,   a.bDATE,   d.KPROLOG, c.RNK, c.nmkk, a.accs,
               a.acckred, a.mfokred, a.accperc, a.mfoperc,  a.refp
          INTO cc_id_ ,   DAT2_  ,   KPROLOG_,  RNK_, NMK_, ACC_OLD,
               NLSB_OLD,  MFOB_OLD,  NLSNB_OLD, MFONB_OLD,  REFP_OLD
          FROM cc_deal d,  customer c , cc_add a
         WHERE d.nd=ND_ AND d.rnk=c.rnk AND a.nd=d.nd AND a.adds=0 ;


        SELECT acra INTO ACRA_OLD FROM int_accn
         WHERE acc=ACC_OLD AND id=nID_ AND acra is not null ;

        IF nvl(CC_ID_NEW, cc_id_) = cc_id_ and DATN_NEW = DAT2_ THEN
           --������ ������ (�� ��������, � �����������), ������ ������  ��������� ������
           UPDATE cc_deal              SET KPROLOG=KPROLOG +1, vidd=VIDD_, limit= nS_NEW, wdate=DatK_NEW            WHERE nd= ND_;
           ND_NEW := ND_;
        ELSE
           -- ����� ������-���� (��������)
           nd_new := bars_sqnc.get_nextval('s_cc_deal');
           INSERT INTO cc_deal d (nd, vidd, rnk, d.user_id, cc_id, sos, wdate, sdate, limit, kprolog)
           SELECT ND_NEW, VIDD_, rnk, gl.aUID, CC_ID_NEW, 10, DatK_NEW, gl.BDATE, nS_NEW, 0  FROM cc_deal WHERE nd=ND_;

           INSERT INTO cc_add (
             nd,    adds, s, kv, bdate, wdate, sour, acckred, mfokred, freq, accperc, mfoperc, refp, int_amount,
             swi_bic, swi_acc, swi_ref, swo_bic, swo_acc, swo_ref, alt_partyb, interm_b,
             int_partya, int_partyb, int_interma, int_intermb )
           SELECT
             ND_NEW, 0,   s, kv, bdate, wdate, sour, acckred, mfokred, freq, accperc, mfoperc,refp, int_amount,
             swi_bic, swi_acc, null, swo_bic, swo_acc, null, alt_partyb, interm_b,
             int_partya, int_partyb, int_interma, int_intermb
           FROM cc_add WHERE nd=ND_ AND adds=0;

           insert into nd_acc (nd,acc) select ND_NEW, acc from nd_acc where nd=ND_;
        END IF;
       
     EXCEPTION WHEN NO_DATA_FOUND THEN return;
     END;

     IF NLS_OLD <> NLS_NEW THEN   -- ������ ���������� ����

        BEGIN SELECT acc, tip INTO ACC_NEW, TIP_ FROM accounts WHERE nls=NLS_NEW and kv=nKv_;     -- ���� ��� ������
              -- ����������� ��� � ������
              INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACC_NEW);
              BEGIN  SELECT acc INTO ACRA_NEW FROM accounts WHERE nls=NLS8_NEW and kv=nKv_;  -- ���� ���.%% ������
                     INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);                    -- ����������� ��� � ������
              EXCEPTION WHEN NO_DATA_FOUND THEN
                    -- ���� ���.%% �� ������, ��������� (Op_reg(1, ...) - c insert into nd_acc)
                    IF ACRA_OLD > 0 THEN   SELECT tip into TIP_ from accounts where acc=ACRA_OLD;   END IF;
                    MBK.op_reg_ex_2017 (1,ND_NEW,n_,GRP_,n_,RNK_,NLS8_NEW,nKv_,NMK_,TIP_,ISP_,ACRA_NEW,  '1',null,null,      null);   --  KB pos=1 --
                    p_setAccessByAccmask(ACRA_NEW,ACC_NEW);
                    BEGIN INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);  EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;   END;
              END;

        EXCEPTION WHEN NO_DATA_FOUND THEN     -- ��������� ����

             BEGIN  SELECT grp, isp, tip INTO GRP_, ISP_, TIP_  FROM accounts WHERE acc=ACC_OLD;
                    MBK.op_reg_ex_2017 (1,ND_NEW,n_,GRP_,n_,RNK_,NLS_NEW,nKv_,NMK_,TIP_,ISP_,ACC_NEW,      '1',null,null,     null);   --  KB pos=1
                    p_setAccessByAccmask(ACC_NEW,ACC_OLD);
                    BEGIN INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW, ACC_NEW);
                          If TIP_= 'SS ' THEN
                             INSERT INTO cc_accp(ACC, ACCS, nD)   SELECT acc, ACC_NEW, nd FROM cc_accp WHERE accs=ACC_OLD ;
                          END IF;
                   EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
                   END;
                   -- ��������� ���� ���.%%
                   IF ACRA_OLD > 0 THEN    SELECT tip INTO TIP_ FROM accounts WHERE acc=ACRA_OLD;    END IF;
                      MBK.op_reg_ex_2017 (1,ND_NEW,n_,GRP_,n_,RNK_,NLS8_NEW,nKv_,NMK_,TIP_,ISP_,ACRA_NEW,'1',null,null,  null);   --  KB pos=1
                      p_setAccessByAccmask(ACRA_NEW,ACC_NEW);
                      BEGIN   INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);  EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;   END;
             EXCEPTION WHEN NO_DATA_FOUND THEN  return;
             end;
        end;

        /* ��� ������ � ��������, �� ������� ����������� (�� ����) */
        /* �������� � ������ ����� ������� ������*/
        acc_ss:=ACC_OLD;
        begin
           /* ��������� �� ������� ����� ������� ������ ������� ������*/
           /* � ������ ������ ND_NEW=ND */
           select c.acc,c.accs into acc_zal,acc_ss    from cc_accp c, pawn_acc p       where c.acc=p.acc  and c.nd =ND_NEW;
        exception when no_data_found then acc_ss:='0';
        end;
        if acc_ss=ACC_OLD then
           update cc_accp set accs=ACC_NEW where nd=ND_NEW;
        end if;
        /* �������� ������� ������ �������� ��������� � �������� �� "������ �����"*/
        for k in (select c.nd from cc_accp c,cc_deal d
                   where c.accs=ACC_NEW and c.nd<>ND_NEW
                     and c.nd=d.nd  and d.sos=15
                     and c.acc<>ACC_ZAL)
        loop
           delete from cc_accp where nd=k.nd and accs=ACC_NEW;
        end loop;
     ELSE
        ACC_NEW  := ACC_OLD;
        ACRA_NEW := ACRA_OLD;
     END IF;

     if ND_ <> ND_NEW then
        -- ��������������� ����� � ������ ��������
        update cc_accp set accs = ACC_NEW, nd = ND_NEW where nd = ND_;
        -- ���������� ������ �� ������� �����
        delete from cc_accp where accs = ACC_OLD;
     end if;

     -- ��� ����������
     select substr(
       decode(nvl(CC_ID_NEW, cc_id_),cc_id_,
                 decode (DATN_NEW,DAT2_,'��i��:','��i��-����:'),'��i��-����:')||
       decode ( nS_OLD  , nS_NEW  , '',
              ' ���� � ' || trim(to_char(nS_OLD*100,'9999999999999,99')) ||
              ' �� '     || trim(to_char(nS_NEW*100,'9999999999999,99')) || '. ') ||
       decode ( nPr_OLD , nPr_NEW , '',
              ' % ��. � '|| nPr_OLD ||
              ' �� '     || nPr_NEW || '. ') ||
       decode ( DatK_OLD, DatK_NEW, '',
              ' ������ � ' || to_char(DatK_OLD,'dd/MM/yyyy') ||
              ' �� '       || to_char(DatK_NEW,'dd/MM/yyyy') || '. ') ||
       decode ( NLS_OLD , NLS_NEW , '',
              ' ������� � ' || Nls_OLD ||
              ' �� '        || NLS_NEW || '.') ||
       decode ( NLSB_OLD , NLSB_NEW , '',
              ' ������� ���. �������� � ' || NLSB_OLD || ' (��� ' || MFOB_OLD || ')' ||
              ' �� '                      || NLSB_NEW || ' (��� ' || MFOB_NEW || ').') ||
       decode ( NLSNB_OLD , NLSNB_NEW , '',
              ' ������� ���.% �������� � '|| NLSNB_OLD || ' (��� ' || MFONB_OLD || ')' ||
              ' �� '                      || NLSNB_NEW || ' (��� ' || MFONB_NEW || ').')
       , 1,250)
     into sTXT_  from dual ;

     BEGIN
        INSERT INTO cc_prol(nd,npp, FDAT, MDATE, TXT, ACC)
        VALUES(ND_NEW,KPROLOG_, gl.bdate, DatK_NEW, sTXT_, ACC_OLD);
     EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
     END;

     If DATK_OLD <> DATK_NEW OR ACC_OLD <> ACC_NEW then
        UPDATE accounts SET mdate=DatK_NEW, pap=nID_+1 WHERE acc=ACC_NEW;
        UPDATE accounts SET mdate=DatK_NEW
               --, pap=nID_+1            ������� � �����. � ������ ������
         WHERE acc=ACRA_NEW;
        UPDATE int_accn SET STP_DAT=DatK_NEW-1 WHERE acc=ACC_NEW and id=nID_;
        IF SQL%rowcount = 0 THEN     -- ��������� ��������� ��� ���� ��������
           BEGIN
              if to_number(to_char(gl.bdate,'MM')) = to_number(to_char(DatK_NEW-1,'MM')) then
                  select f_proc_dr(s.rnk, 4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_   -- �������������
                  from   cc_deal s, cc_add a
                  where  s.nd = ND_NEW and s.nd = a.nd;
              else
                  select f_proc_dr(s.rnk ,4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_  -- �����������
                  from   cc_deal s, cc_add a
                  where  s.nd = ND_NEW and s.nd = a.nd;
              end if;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              nG67_ := null;
           END;
           INSERT INTO int_accn (ACC, ID, METR, BASEM, BASEY, FREQ, STP_DAT, ACR_DAT, APL_DAT,
                  TT, ACRA, ACRB, S, TTB, KVB, NLSB, MFOB, NAMB, NAZN)
           SELECT ACC_NEW ,nID_,METR, BASEM, BASEY, FREQ, DatK_NEW-1, ACR_DAT, APL_DAT,
                  TT, ACRA_NEW, nvl(nG67_,ACRB), S, TTB, KVB, NLSB, MFOB, NAMB, NAZN
             FROM int_accn WHERE acc=ACC_OLD and id = nID_;
        END IF;
     END IF;

     IF nPr_OLD <> nPr_NEW OR ACC_OLD <> ACC_NEW THEN
        UPDATE int_ratn SET IR=nPr_NEW WHERE acc=ACC_NEW AND id=nID_ AND BDAT=gl.BDATE;
        IF SQL%rowcount = 0 THEN
           INSERT INTO int_ratn(ACC, ID, BDAT, IR)
           VALUES (ACC_NEW, nId_, gl.BDATE, nPr_NEW);
        END IF;
     END IF;

     IF ACC_OLD <> ACC_NEW THEN
        DELETE FROM nd_acc WHERE nd=ND_NEW AND acc in (ACC_OLD, ACRA_OLD);
     END IF;

     UPDATE cc_add
     SET accs=ACC_NEW, bdate=DATN_NEW, wdate=DATN_NEW, s=nS_NEW,
         acckred=NLSB_NEW,  mfokred=MFOB_NEW,
         accperc=NLSNB_NEW, mfoperc=MFONB_NEW, refp=REFP_NEW,
         swi_bic    = bica_,
         swi_acc    = ssla_,
         swo_bic    = bicb_,
         swo_acc    = sslb_,
         alt_partyb = altb_,
         interm_b   = intermb_,
         int_partya = intPartyA_,
         int_partyb = intPartyB_,
         int_interma= intIntermA_,
         int_intermb= intIntermB_,
         int_amount = intAmount_
     WHERE nd=ND_NEW and adds=0;

     -- ���� ��������� ����� �������, ��
     If ND_NEW <> ND_ then  D020_ := '01';
     else                   D020_ := '02';
     end if;

     UPDATE specparam set D020 = D020_ where acc = ACC_NEW ;
     if SQL%rowcount = 0 then
        INSERT INTO specparam ( ACC, D020 ) values ( ACC_NEW, D020_ );
     end if;

     -- ����� ��� ����� ������ ��� 1-�� ������
     if vidd_ like '1%' then
        l_s180 := FS180(ACC_NEW, '1', bankdate);
        update specparam set s180 = l_s180 where acc = ACC_NEW;
        if SQL%rowcount = 0 then
           INSERT INTO specparam (ACC, S180) values (ACC_NEW, l_s180);
        end if;
     end if;

   END RO_deal;


    procedure rollover_deal(
        p_deal_id                      in integer,      /* ������ nd             */
        p_deal_number                  in varchar2,     /* ����� ����� ������    */
        p_main_account_number          in varchar2,
        p_interest_account_number      in varchar2,
        p_deal_amount                  in number,
        p_interest_rate                in number,
        p_start_date                   in date,
        p_expiry_date                  in date,
        p_expected_interest_amount     in number,
        p_our_corresp_bank_nostro_acc  in number,
        p_our_corresp_bank_bic         in varchar2,
        p_our_corresp_bank_account     in varchar2,
        p_our_interest_corresp_bank    in varchar2,
        p_our_interest_interm_bank     in varchar2,
        p_partner_bic                  in varchar2,
        p_partner_account              in varchar2,
        p_partner_alt_requisites       in varchar2,
        p_partner_bank_bic             in varchar2,
        p_partner_bank_account         in varchar2,
        p_partner_bank_alt_requisites  in varchar2,
        p_partner_intermediary_bank    in varchar2,
        p_partner_interest_bic         in varchar2,
        p_partner_interest_account     in varchar2,
        p_partner_interest_bank        in varchar2,
        p_partner_interest_interm_bank in varchar2,
        p_new_deal_id                  out integer,     /* ����� nd ��� �������� */
        p_new_main_account_id          out integer)     /* acc ������ �����      */
    is
        l_old_cc_deal_row          cc_deal%rowtype;
        l_old_cc_add_row           cc_add%rowtype;
        l_old_cc_vidd_row          cc_vidd%rowtype;
        l_old_customer_row         customer%rowtype;
        l_old_int_accn_row         int_accn%rowtype;
        l_old_account_row          accounts%rowtype;
        l_old_interest_account_row accounts%rowtype;
        l_old_interest_rate        number;

        l_new_cc_vidd_row          cc_vidd%rowtype;
        l_new_account_row          accounts%rowtype;
        l_new_interest_account_row accounts%rowtype;

        l_new_deal_kind_id         integer;
        l_old_interest_kind_id     integer;

        l_redundant_pawn_accounts  number_list;
        l_dummy                    integer;
        stxt_                      varchar2(250);
        d020_                      char(2);
        ng67_                      number;
        l_s180                     specparam.s180%type;
    begin
        bars_audit.info('mbk.ro_deal' || chr(10) ||
                        'p_deal_id                      : ' || p_deal_id                     || chr(10) ||
                        'p_deal_number                  : ' || p_deal_number                 || chr(10) ||
                        'p_main_account_number          : ' || p_main_account_number         || chr(10) ||
                        'p_interest_account_number      : ' || p_interest_account_number     || chr(10) ||
                        'p_deal_amount                  : ' || p_deal_amount                 || chr(10) ||
                        'p_interest_rate                : ' || p_interest_rate               || chr(10) ||
                        'p_start_date                   : ' || p_start_date                  || chr(10) ||
                        'p_expiry_date                  : ' || p_expiry_date                 || chr(10) ||
                        'p_expected_interest_amount     : ' || p_expected_interest_amount    || chr(10) ||
                        'p_our_corresp_bank_nostro_acc  : ' || p_our_corresp_bank_nostro_acc || chr(10) ||
                        'p_our_corresp_bank_bic         : ' || p_our_corresp_bank_bic        || chr(10) ||
                        'p_our_corresp_bank_account     : ' || p_our_corresp_bank_account    || chr(10) ||
                        'p_our_interest_corresp_bank    : ' || p_our_interest_corresp_bank   || chr(10) ||
                        'p_our_interest_interm_bank     : ' || p_our_interest_interm_bank    || chr(10) ||
                        'p_partner_bic                  : ' || p_partner_bic                 || chr(10) ||
                        'p_partner_account              : ' || p_partner_account             || chr(10) ||
                        'p_partner_alt_requisites       : ' || p_partner_alt_requisites      || chr(10) ||
                        'p_partner_bank_bic             : ' || p_partner_bank_bic            || chr(10) ||
                        'p_partner_bank_account         : ' || p_partner_bank_account        || chr(10) ||
                        'p_partner_bank_alt_requisites  : ' || p_partner_bank_alt_requisites || chr(10) ||
                        'p_partner_intermediary_bank    : ' || p_partner_intermediary_bank   || chr(10) ||
                        'p_partner_interest_bic         : ' || p_partner_interest_bic        || chr(10) ||
                        'p_partner_interest_account     : ' || p_partner_interest_account    || chr(10) ||
                        'p_partner_interest_bank        : ' || p_partner_interest_bank       || chr(10) ||
                        'p_partner_interest_interm_bank : ' || p_partner_interest_interm_bank|| chr(10) ||
                        'p_new_deal_id                  : ' || p_new_deal_id                 || chr(10) ||
                        'p_new_main_account_id          : ' || p_new_main_account_id);

        l_old_cc_deal_row := cck_utl.read_cc_deal(p_deal_id);
        l_old_cc_add_row := cck_utl.read_cc_add(l_old_cc_deal_row.nd);
        l_old_cc_vidd_row := cck_utl.read_cc_vidd(l_old_cc_deal_row.vidd);
        l_old_customer_row := customer_utl.read_customer(l_old_cc_deal_row.rnk);
        l_old_account_row := account_utl.read_account(l_old_cc_add_row.accs);

        l_old_interest_kind_id := cck_utl.get_deal_interest_kind(l_old_cc_vidd_row.tipd);
        l_old_int_accn_row := interest_utl.read_int_accn(l_old_cc_add_row.accs, l_old_interest_kind_id, p_raise_ndf => false);
        l_old_interest_account_row := account_utl.read_account(l_old_int_accn_row.acra, p_raise_ndf => false);
        l_old_interest_rate := acrn.fprocn(l_old_account_row.acc, l_old_interest_kind_id, gl.bd());

        l_new_deal_kind_id := to_number(substr(p_main_account_number, 1, 4));
        l_new_cc_vidd_row := cck_utl.read_cc_vidd(l_new_deal_kind_id);

        if (nvl(p_deal_number, l_old_cc_deal_row.cc_id) = l_old_cc_deal_row.cc_id and p_start_date = l_old_cc_add_row.bdate) then
            -- ������ ������ (�� ��������, � �����������), ������ ������  ��������� ������
            update cc_deal t
            set    t.kprolog = t.kprolog + 1,
                   t.vidd    = l_new_deal_kind_id,
                   t.limit   = p_deal_amount,
                   t.wdate   = p_expiry_date
            where  t.nd = l_old_cc_deal_row.nd;

            update cc_add t
            set    t.bdate       = p_start_date,
                   t.wdate       = p_start_date,
                   t.s           = p_deal_amount,
                   t.acckred     = p_partner_account,
                   t.mfokred     = p_partner_bic,
                   t.accperc     = p_partner_interest_account,
                   t.mfoperc     = p_partner_interest_bic,
                   t.refp        = p_our_corresp_bank_nostro_acc,
                   t.swi_bic     = p_our_corresp_bank_bic,
                   t.swi_acc     = p_our_corresp_bank_account,
                   t.swo_bic     = p_partner_bank_bic,
                   t.swo_acc     = p_partner_bank_account,
                   t.alt_partyb  = p_partner_bank_alt_requisites,
                   t.interm_b    = p_partner_intermediary_bank,
                   t.int_partya  = p_our_interest_corresp_bank,
                   t.int_partyb  = p_partner_interest_bank,
                   t.int_interma = p_our_interest_interm_bank,
                   t.int_intermb = p_partner_interest_interm_bank,
                   t.int_amount  = p_expected_interest_amount,
                   t.field_58d   = p_partner_alt_requisites
            where  t.nd = l_old_cc_deal_row.nd and
                   t.adds = 0;

            p_new_deal_id := l_old_cc_deal_row.nd;
        else
            -- ����� ������-���� (��������)
            p_new_deal_id := cck_utl.create_cc_deal(p_deal_kind_id => l_new_deal_kind_id,
                                                    p_deal_number  => p_deal_number,
                                                    p_client_id    => l_old_customer_row.rnk,
                                                    p_deal_amount  => p_deal_amount,
                                                    p_expiry_date  => p_expiry_date);

            cck_utl.create_cc_add(p_deal_id                      => p_new_deal_id,
                                  p_deal_amount                  => nvl(p_deal_amount, l_old_cc_add_row.s),
                                  p_currency_id                  => l_old_cc_add_row.kv,
                                  p_start_date                   => p_start_date,
                                  p_payment_date                 => p_start_date,
                                  p_main_account_id              => null,
                                  p_our_corresp_bank_nostro_acc  => nvl(p_our_corresp_bank_nostro_acc , l_old_cc_add_row.refp),
                                  p_our_corresp_bank_bic         => nvl(p_our_corresp_bank_bic        , l_old_cc_add_row.swi_bic),
                                  p_our_corresp_bank_account     => nvl(p_our_corresp_bank_account    , l_old_cc_add_row.swi_acc),
                                  p_our_interest_corresp_bank    => nvl(p_our_interest_corresp_bank   , l_old_cc_add_row.int_partya),
                                  p_our_interest_interm_bank     => nvl(p_our_interest_interm_bank    , l_old_cc_add_row.int_interma),
                                  p_partner_bic                  => nvl(p_partner_bic                 , l_old_cc_add_row.mfokred),
                                  p_partner_account              => nvl(p_partner_account             , l_old_cc_add_row.acckred),    -- swift mt202.58a
                                  p_partner_alt_requisites       => nvl(p_partner_alt_requisites      , l_old_cc_add_row.field_58d),  -- swift mt202.58(a|d)
                                  p_partner_bank_bic             => nvl(p_partner_bank_bic            , l_old_cc_add_row.swo_bic),    -- swift mt202.57a
                                  p_partner_bank_account         => nvl(p_partner_bank_account        , l_old_cc_add_row.swo_acc),    -- swift mt202.57a
                                  p_partner_bank_alt_requisites  => nvl(p_partner_bank_alt_requisites , l_old_cc_add_row.alt_partyb), -- swift mt202.57(a|d)
                                  p_partner_intermediary_bank    => nvl(p_partner_intermediary_bank   , l_old_cc_add_row.interm_b),
                                  p_partner_interest_bic         => nvl(p_partner_interest_bic        , l_old_cc_add_row.mfoperc),
                                  p_partner_interest_account     => nvl(p_partner_interest_account    , l_old_cc_add_row.accperc),    -- swift mt202.58a
                                  p_partner_interest_bank        => nvl(p_partner_interest_bank       , l_old_cc_add_row.int_partyb),
                                  p_partner_interest_interm_bank => nvl(p_partner_interest_interm_bank, l_old_cc_add_row.int_intermb),
                                  p_transit_account              => l_old_cc_add_row.nls_1819,
                                  p_expected_interest_amount     => p_expected_interest_amount,
                                  p_event_frequency_id           => l_old_cc_add_row.freq,
                                  p_loan_aim_id                  => l_old_cc_add_row.aim,
                                  p_funds_source_id              => l_old_cc_add_row.sour,
                                  p_mfo                          => l_old_cc_deal_row.kf,
                                  p_application_id               => 0);

            -- ����'����� ������� ����� ����� �� ����
            -- (�� ����������� ��������� ������� �� ������� ����������� �������, ������� � ���� ����� ������ ���)
            for i in (select acc from nd_acc t
                      where  t.nd = p_deal_id
                      minus
                      -- ������� ������������� ������� ����������� ������� ���� ���� null, �� �� ������ �����������
                      -- ����������� "not in (l_old_interest_account_row.acc)" - � ����� ��� ������� �� ������� ������� �����
                      -- ���� ��������� �� � ������ �������, �� ����'�������� �� ���� ����� �� ��������� "minus"
                      select column_value
                      from   table(number_list(l_old_account_row.acc, l_old_interest_account_row.acc))) loop
                cck_utl.link_account_to_deal(p_new_deal_id, i.acc);
            end loop;
        end if;

        -- �������� ���� ��������� ������� �����
        if (l_old_account_row.nls = p_main_account_number) then
            -- ������� ��������� ��� ���
            p_new_main_account_id  := l_old_account_row.acc;
            -- � ������ ��� ������� ������� ����� �������� ��� ���
            l_new_interest_account_row.acc := l_old_interest_account_row.acc;
        else
            -- ����� ��������� ������� �� ���� �������
            l_new_account_row := account_utl.read_account(p_main_account_number, l_old_cc_add_row.kv, p_raise_ndf => false);

            if (l_new_account_row.acc is not null) then
                p_new_main_account_id := l_new_account_row.acc;
            else
                MBK.op_reg_ex_2017
                         (mod_     => 1,
                          p1_      => p_new_deal_id,
                          p2_      => l_dummy,
                          p3_      => l_old_account_row.grp,
                          p4_      => l_dummy,
                          rnk_     => l_old_cc_deal_row.rnk,
                          nls_     => p_main_account_number,
                          kv_      => l_old_cc_add_row.kv,
                          nms_     => l_old_customer_row.nmk,
                          tip_     => l_old_account_row.tip,
                          isp_     => user_id(),
                          accr_    => p_new_main_account_id,
                          nbsnull_ => '1');
            end if;

            update cc_add t
            set    t.accs = p_new_main_account_id
            where  t.nd   = p_new_deal_id and
                   t.adds = 0;

            -- ������� ����������� �������
            -- ������ ������� ����������� ������� �� �������, �� ��� ����������� � ���� ���� ��������� �����
            l_new_interest_account_row := account_utl.read_account(p_interest_account_number, l_old_cc_add_row.kv, p_raise_ndf => false);

            if (l_new_interest_account_row.acc is null) then
                -- �� ������� ������� ������� �� ������� - ��������� �����
                MBK.op_reg_ex_2017
                         (mod_     => 1,
                          p1_      => p_new_deal_id,
                          p2_      => l_dummy,
                          p3_      => l_old_account_row.grp,
                          p4_      => l_dummy,
                          rnk_     => l_old_cc_deal_row.rnk,
                          nls_     => p_interest_account_number,
                          kv_      => l_old_cc_add_row.kv,
                          nms_     => l_old_customer_row.nmk,
                          tip_     => nvl(l_old_interest_account_row.tip,
                                          case when l_new_cc_vidd_row.tipd = cck_utl.DEAL_TYPE_ALLOCATION_OF_FUNDS then 'SN '
                                               when l_new_cc_vidd_row.tipd = cck_utl.DEAL_TYPE_FUNDRAISING then 'DEN'
                                               else null -- �������� ��� ����
                                          end),
                          isp_     => user_id(),
                          accr_    => l_new_interest_account_row.acc,
                          nbsnull_ => '1');
            end if;

            -- ����������� ���� ������� � ��������� ������� ����� �����
            p_setaccessbyaccmask(p_new_main_account_id, l_old_cc_add_row.accs);
            p_setaccessbyaccmask(l_new_interest_account_row.acc, p_new_main_account_id);

            cck_utl.link_account_to_deal(p_new_deal_id, p_new_main_account_id);
            cck_utl.link_account_to_deal(p_new_deal_id, l_new_interest_account_row.acc);
        end if;

        -- ������ �� ���������
        -- �� ���� ����� ������������ �� ������� �������, �� ���� �������� �� �����
        merge into cc_accp a
        using (select t.acc, t.pr_12, t.idz, t.mpawn, t.pawn, t.rnk
               from   cc_accp t
               join   pawn_acc p on p.acc = t.acc -- ������������ � ����, �� ����� ������� �������� �� ������� �������
               where  t.accs in (l_old_account_row.acc, p_new_main_account_id)) s
        on (a.acc = s.acc and a.accs = p_new_main_account_id)
        when matched then update
             set a.nd = p_new_deal_id -- ��������� ������������� ����'����� �����
        when not matched then insert
             values (s.acc, p_new_main_account_id, p_new_deal_id, s.pr_12, s.idz, bars_context.current_mfo(), s.mpawn, s.pawn, s.rnk);

        -- �������� ������ ������ �� ����������� �������: ��������� ������ ������� �������, ��������� �������, ���������� ���� �� ������� ���� �����
        -- ����� ��������� �������, ��� ���� ������ ��������� �������� ������� (����� ���������� �� ������ ����)
        select t.acc
        bulk collect into l_redundant_pawn_accounts
        from   cc_accp t
        where  t.accs = p_new_main_account_id and
               (exists (select 1 from accounts a
                        where  a.acc = t.acc and
                               (a.dazs is not null or --
                                (l_new_cc_vidd_row.tipd = cck_utl.DEAL_TYPE_ALLOCATION_OF_FUNDS and a.nbs = '9510') or
                                (l_new_cc_vidd_row.tipd = cck_utl.DEAL_TYPE_FUNDRAISING and a.nbs <> '9510'))) or
                not exists (select 1 from pawn_acc p where p.acc = t.acc));

        delete cc_accp t
        where  t.accs = p_new_main_account_id and
               t.acc in (select column_value from table(l_redundant_pawn_accounts));

        -- ��'������ ������� �� ������� ������� �����
        delete cc_accp t where t.accs = l_old_account_row.acc;
        delete nd_acc t where t.nd = p_new_deal_id and t.acc in (select column_value from table(l_redundant_pawn_accounts));

        stxt_ := substr(case when p_deal_number is not null and p_deal_number <> l_old_cc_deal_row.cc_id then '�������� (����):'
                             else '����������� (����):'
                        end ||
                        case when p_main_account_number is not null and p_main_account_number <> l_old_account_row.nls then
                                  ' ������� � ' || l_old_account_row.nls || ' �� ' || p_main_account_number
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_add_row.s, p_deal_amount) then
                                  ' ���� � ' || trim(to_char(l_old_cc_add_row.s, '9999999999999,99')) ||
                                  ' �� '     || trim(to_char(p_deal_amount, '9999999999999,99'))
                             else ''
                        end ||
                        case when not tools.equals(l_old_interest_rate, p_interest_rate) then
                                  ' % ��. � '|| l_old_interest_rate ||
                                  ' �� '     || p_interest_rate
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_deal_row.wdate, p_expiry_date) then
                                  ' ������ � ' || to_char(l_old_cc_deal_row.wdate, 'dd/mm/yyyy') ||
                                  ' �� '       || to_char(p_expiry_date, 'dd/mm/yyyy')
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_add_row.acckred , p_partner_account) then
                                  ' ������� �������� � ' || l_old_cc_add_row.acckred || ' (��� ' || l_old_cc_add_row.mfokred || ')' ||
                                  ' �� '                || p_partner_account || ' (��� ' || p_partner_bic || ')'
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_add_row.accperc, p_partner_interest_account) then
                                  ' ������� ���.% �������� � '|| l_old_cc_add_row.accperc || ' (��� ' || l_old_cc_add_row.mfoperc || ')' ||
                                  ' �� '                      || p_partner_interest_account || ' (��� ' || p_partner_interest_bic || ')'
                             else ''
                        end, 1, 250);
     BEGIN
        INSERT INTO cc_prol(nd,npp, FDAT, MDATE, TXT, ACC)
        VALUES(p_new_deal_id,l_old_cc_deal_row.kprolog, gl.bdate, p_expiry_date, sTXT_, l_old_cc_add_row.accs);
     EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
     END;

     If l_old_cc_deal_row.wdate <> p_expiry_date OR l_old_cc_add_row.accs <> p_new_main_account_id then
        UPDATE accounts SET mdate=p_expiry_date, pap=l_old_interest_kind_id+1 WHERE acc=p_new_main_account_id;
        UPDATE accounts SET mdate=p_expiry_date
               --, pap=nID_+1            ������� � �����. � ������ ������
         WHERE acc=l_new_interest_account_row.acc;
        UPDATE int_accn SET STP_DAT=p_expiry_date-1 WHERE acc=p_new_main_account_id and id=l_old_interest_kind_id;
        IF SQL%rowcount = 0 THEN     -- ��������� ��������� ��� ���� ��������
           BEGIN
              if to_number(to_char(gl.bdate,'MM')) = to_number(to_char(p_expiry_date-1,'MM')) then
                  select f_proc_dr(s.rnk, 4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_   -- �������������
                  from   cc_deal s, cc_add a
                  where  s.nd = p_new_deal_id and s.nd = a.nd;
              else
                  select f_proc_dr(s.rnk ,4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_  -- �����������
                  from   cc_deal s, cc_add a
                  where  s.nd = p_new_deal_id and s.nd = a.nd;
              end if;
           EXCEPTION WHEN NO_DATA_FOUND THEN
              nG67_ := null;
           END;
           INSERT INTO int_accn (ACC, ID, METR, BASEM, BASEY, FREQ, STP_DAT, ACR_DAT, APL_DAT,
                  TT, ACRA, ACRB, S, TTB, KVB, NLSB, MFOB, NAMB, NAZN)
           SELECT p_new_main_account_id ,l_old_interest_kind_id,METR, BASEM, BASEY, FREQ, p_expiry_date-1, ACR_DAT, APL_DAT,
                  TT, l_new_interest_account_row.acc, nvl(nG67_,ACRB), S, TTB, KVB, NLSB, MFOB, NAMB, NAZN
             FROM int_accn WHERE acc=l_old_cc_add_row.accs and id = l_old_interest_kind_id;
        END IF;
     END IF;

     IF l_old_interest_rate <> p_interest_rate OR l_old_cc_add_row.accs <> p_new_main_account_id THEN
        UPDATE int_ratn SET IR=p_interest_rate WHERE acc=p_new_main_account_id AND id=l_old_interest_kind_id AND BDAT=gl.BDATE;
        IF SQL%rowcount = 0 THEN
           INSERT INTO int_ratn(ACC, ID, BDAT, IR)
           VALUES (p_new_main_account_id, l_old_interest_kind_id, gl.BDATE, p_interest_rate);
        END IF;
     END IF;

     IF l_old_cc_add_row.accs <> p_new_main_account_id THEN
        DELETE FROM nd_acc WHERE nd=p_new_deal_id AND acc in (l_old_cc_add_row.accs, l_old_int_accn_row.acra);
     END IF;

     -- ���� ��������� ����� �������, ��
     If p_new_deal_id <> p_deal_id then  D020_ := '01';
     else                   D020_ := '02';
     end if;

     UPDATE specparam set D020 = D020_ where acc = p_new_main_account_id ;
     if SQL%rowcount = 0 then
        INSERT INTO specparam ( ACC, D020 ) values ( p_new_main_account_id, D020_ );
     end if;

     -- ����� ��� ����� ������ ��� 1-�� ������
     if l_new_deal_kind_id like '1%' then
        l_s180 := FS180(p_new_main_account_id, '1', bankdate);
        update specparam set s180 = l_s180 where acc = p_new_main_account_id;
        if SQL%rowcount = 0 then
           INSERT INTO specparam (ACC, S180) values (p_new_main_account_id, l_s180);
        end if;
     end if;

   end;

   ------------------------------------------------------------------
   -- F_NLS_MB
   --
   --    ������� ���������� ������ ������ ������ (30 ����.)
   --
   --
   Function F_NLS_MB (
     nbs_     in varchar2,
     rnk_     in integer,
     ACRB_    in integer,
     kv_      in integer,
     maskid_     varchar2 ) return varchar2  IS

   nbsn_ char(4);                         -- �� ��� %%
   SS_   varchar2(14) := to_char(null);   -- ��� ���� ��� ���������
   SN_   varchar2(14) := to_char(null);   -- ��������� ��� % ��� ���������
   ACRA_ integer;
   acc_  integer;
   id_   integer;
   MASK_ VARCHAR2(10);

     -- 30.08.2010 Sta
     l_INITIATOR   varchar2(2);
   BEGIN

       bars_audit.info('mbk.f_nls_mb' || chr(10) ||
                       'nbs_    : ' || nbs_    || chr(10) ||
                       'rnk_    : ' || rnk_    || chr(10) ||
                       'ACRB_   : ' || ACRB_   || chr(10) ||
                       'kv_     : ' || kv_     || chr(10) ||
                       'maskid_ : ' || maskid_);
     BEGIN

        -- Sta 08.12.2017
        BEGIN SELECT nbsn INTO nbsn_ FROM proc_dr WHERE nbs=nbs_ and ROWNUM=1; -- ���� ��������� ������� - ����� ������
        exception when NO_DATA_FOUND THEN  nbsN_ := sUBSTR(nbs_,1,3) ||'8';
        end;
      
         BEGIN
            if nbs_ like '39%' then  MASK_ := 'MFK';
            else                     MASK_ := 'MBK';
            end if;

            -- 30.08.2010 Sta
            -- ������ ��� ��� ��

            l_INITIATOR := substr( pul.Get_Mas_Ini_Val('INITIATOR'), 1, 2 );

            If gl.aMfo = '300465' and l_INITIATOR is not null then

               EXECUTE IMMEDIATE
              'SELECT a.acc
                 FROM accounts a, int_accn i, accounts n,
                      (select acc from SPECPARAM_CP_OB where INITIATOR ='''|| l_INITIATOR || ''') o
                WHERE a.acc= o.acc (+)
                  and a.acc  = i.acc
                  AND a.kv   = '  || kv_  || '
                 AND a.nbs  = '''|| nbs_ || '''
                 AND a.rnk  = '  || rnk_ || '
                 AND a.ostc = 0 AND a.ostb = 0 AND a.ostf = 0
                 AND n.ostc = 0 AND n.ostb = 0 AND n.ostf = 0
                 AND i.acra = n.acc
                 AND (a.mdate < gl.BD OR a.mdate IS NULL) AND a.dazs is null
                 AND (n.mdate < gl.BD OR n.mdate IS NULL) AND n.dazs is null
                 and (a.dapp is null or a.dapp < bankdate-10)
                 and (n.dapp is null or n.dapp < bankdate-10)
                 AND ROWNUM=1 ' into ACC_ ;

              SELECT nls,pap-1  INTO SS_, id_ FROM accounts where acc=ACC_;

           else

              -- ��� ���� ������ ������
              -- ��� �� ���������  SS_
              SELECT a.nls, a.acc, a.pap-1
                INTO SS_,   acc_,  id_
                FROM accounts a, int_accn i, accounts n
               WHERE a.acc  = i.acc
                 AND a.kv   = kv_
                 AND a.nbs  = nbs_
                 AND a.rnk  = rnk_
                 AND a.ostc = 0 AND a.ostb = 0 AND a.ostf = 0
                 AND n.ostc = 0 AND n.ostb = 0 AND n.ostf = 0
                 AND i.acra = n.acc
                 AND (a.mdate < gl.BDATE OR a.mdate IS NULL) AND a.dazs is null
                 AND (n.mdate < gl.BDATE OR n.mdate IS NULL) AND n.dazs is null
                 and (a.dapp is null or a.dapp < bankdate-10)
                 and (n.dapp is null or n.dapp < bankdate-10)
                 AND ROWNUM=1 ;

           end if;

          -- � ��� ��� ����  SN ?
          SELECT a.nls, i.acra  INTO SN_, acra_  FROM int_accn i, accounts a   WHERE i.acc=acc_ AND i.id=id_ AND i.acra=a.acc AND a.dazs is null;
       exception when NO_DATA_FOUND THEN
          -- ���, ��� --����������� ��������� (������) �����
          SS_ := F_NEWNLS2(null, MASK_, nbs_ , RNK_,null);
          SN_ := F_NEWNLS2(null, MASK_, nbsn_, RNK_,null);
       END;
    exception when NO_DATA_FOUND THEN null;
    end;

    return (substr(SS_||'               ', 1, 15) ||      substr(SN_||'               ', 1, 15)        );
   

  END F_NLS_MB ;

  --
  --
  --
  procedure F_NLS_MB
  ( p_nbs            in     accounts.nbs%type
  , p_rnk            in     accounts.rnk%type
  , p_acrb           in     accounts.acc%type
  , p_kv             in     accounts.kv%type
  , p_maskid         in     nlsmask.maskid%type
  , p_initiator      in     cp_ob_initiator.code%type
  , p_acc_num_1      out    accounts.nls%type
  , p_acc_num_2      out    accounts.nls%type
  ) is
    l_sTmp     varchar2(30);
  begin

    bars_audit.info( 'MBK.F_NLS_MB: Entry with( p_nbs       => ' || p_nbs
                                          || ', p_rnk       => ' || p_rnk
                                          || ', p_acrb      => ' || p_acrb
                                          || ', p_kv        => ' || p_kv
                                          || ', p_maskid    => ' || p_maskid
                                          || ', p_initiator => ' || p_initiator
                                          || ' ).' );

    If ( gl.aMfo = '300465' )
    then
      pul.set_mas_ini( 'INITIATOR', p_initiator, '����� ���������� ��������' );
    end if;

    l_sTmp := SubStr( f_nls_mb( p_nbs, p_rnk, p_acrb, p_kv, p_maskid ), 1, 30 );

    p_acc_num_1 := BARS.VKRZN( gl.aMfo, trim( SubStr( l_sTmp,  1, 15 ) ) );
    p_acc_num_2 := BARS.VKRZN( gl.aMfo, trim( SubStr( l_sTmp, 16, 15 ) ) );

    bars_audit.trace( 'MBK.F_NLS_MB: Exit with( acc_num_1='|| p_acc_num_1 ||', acc_num_2='|| p_acc_num_2 ||' ).' );

  end;

    function get_pawn_account_number(
        p_main_account_number in varchar2,
        p_pawn_kind_id in integer,
        p_deal_kind_id in integer,
        p_customer_id in integer,
        p_currency_id in integer)
    return varchar2
    is
        l_pawn_kind_row cc_pawn%rowtype;
        l_pawn_account_row accounts%rowtype;

        l_pawn_account_number varchar2(15 char);
        l_pawn_balance_account varchar2(10 char);
    begin
        l_pawn_kind_row := cck_utl.read_cc_pawn(p_pawn_kind_id);

        if (p_main_account_number is not null) then
            l_pawn_account_number := vkrzn(bars_context.current_mfo(), l_pawn_kind_row.nbsz || substr(trim(p_main_account_number), 5, 10));
            l_pawn_account_row := account_utl.read_account(l_pawn_account_number, p_currency_id, p_raise_ndf => false);
        end if;

        if (l_pawn_account_row.acc is not null) then
            l_pawn_account_number := f_newnls2(null, 'MBK', l_pawn_kind_row.nbsz, p_customer_id, null);
        end if;

/*        if (l_pawn_account_number is null) then
            raise_application_error(-20000, '�� ������� ���������� ����� ������� ������� ��� ��������� ������� ����� {' || p_main_account_number ||
                                            '}, ���� ������� {' || l_pawn_kind_row.name ||
                                            '}, ���� ����� {' || cck_utl.get_deal_kind_name(p_deal_kind_id) ||
                                            '}, �볺��� {' ||  || '}');
        end if;
*/
        return l_pawn_account_number;
    end;

    function check_if_deal_belong_to_mbdk(
        p_product_id in integer)
    return char
    is
    begin
        return case when length(p_product_id) = 4 and (p_product_id like '1%' or p_product_id in (2700, 2701, 3660, 3661)) then 'Y'
                    else 'N'
               end;
    end;

    ------------------------------------------------------------------
    -- ��������, �� ���������� ����� �� ��������������� ��������� �������
    ---
    function check_if_deal_belong_to_crsour(
        p_product_id in integer)
    return char
    is
    begin
        return case when p_product_id in (DEAL_KIND_CRED_SOUR_LOAN, DEAL_KIND_CRED_SOUR_DEPOSIT) then 'Y' else 'N' end;
    end;

    ------------------------------------------------------------------
    -- ��������� ���������� �������� ��� ���� ����
    ---
    function get_proc_dr_row(
        p_balance_account in varchar2,
        p_customer_id in integer,
        p_branch in varchar2 default sys_context('bars_context', 'user_branch'))
    return proc_dr$base%rowtype
    is
        l_customer_mfo varchar2(6 char);
        l_notax integer;
        l_customerw_value varchar2(32767 byte);
        l_proc_dr_row proc_dr$base%rowtype;
    begin
        l_customer_mfo := customer_utl.get_customer_mfo(p_customer_id);

        -- TODO: ���� ��� �� ���'��� ��� ���� ���� ��� if, ��� ��� ������� �������, �� �� �� ������� - ���������, � ������� ����, ���� �� �������
        if (l_customer_mfo = 0) then
            l_customerw_value := kl.get_customerw(p_customer_id, 'NOTAX');
            l_notax := nvl(to_number(case when regexp_like(l_customerw_value, '^\d*$') then l_customerw_value else null end), 0);

            if (l_notax <> 0) then
                l_customer_mfo := l_notax;
            end if;
        end if;

        begin
            select *
            into   l_proc_dr_row
            from   proc_dr$base p
            where  p.rowid = (select min(t.rowid) keep (dense_rank last order by t.rezid)
                              from   proc_dr$base t
                              where  t.nbs = p_balance_account and
                                     t.sour = cck_utl.FUNDS_SOURCE_OWN and
                                     t.rezid in (l_customer_mfo, 0) and
                                     t.branch = p_branch);

            return l_proc_dr_row;
        exception
            when no_data_found then
                 return null;
        end;
    end;

    ------------------------------------------------------------------
    -- ��� �������, �� ���� ������������� ������� - ����������� �� �������� proc_dr$base, ����������� � ��� IO
    -- ������� ��������� ���� ������� - ������� int_ion
    -- ������� proc_dr$base ������ ��������� ������ ������� � ����� � ��� ����� ������� ����������� ������� �
    -- ����'������ �� ����� ����� �������. ��������� �����, � �� �������� ��������� ���� ������ � ��� �������,
    -- ������������ �� ��, �� ��� ������ ����������� ������� �� ����������� ����� IO � ������ ������-����� �����.
    -- ���������: If SqlPrepareAndExecute(hSql(), "select nvl(IO, 0) into :nIO from proc_dr where nbs=:nVidd and sour=4") and SqlFetchNext(hSql(), nFetchRes)
    -- ������ �������� ��� ���������� ���� ������� �� ����� ��� �� ���� - ���� ���������� ��������������� ��� ����� �����
    ---
    function get_acc_rest_type_for_interest(
        p_balance_account in integer)
    return integer
    is
        l_account_rest_type integer;
    begin
        select nvl(min(t.io), 0)
        into   l_account_rest_type
        from   proc_dr$base t
        where  t.nbs = p_balance_account and
               t.sour = cck_utl.FUNDS_SOURCE_OWN;

        return l_account_rest_type;
    end;

    --------------------------------------------------------------
    --  ������� ����� ������� ������/������ �� ����������� ������� � �����������
    --  ������� proc_dr$base, � ��������� �� ������ �����.
    --  ������� � ����� G67N �� V67N ��� ������ ���� �����������
    --
    function get_income_account(
        p_proc_dr_row in proc_dr$base%rowtype,
        p_currency_id in integer)
    return varchar2
    is
    begin
        return case when p_currency_id = gl.baseval then p_proc_dr_row.g67 else p_proc_dr_row.v67 end;
    end;

    function get_income_account(
        p_balance_account in varchar2,
        p_customer_id in integer,
        p_currency_id in integer,
        p_branch in varchar2 default sys_context('bars_context', 'user_branch'))
    return varchar2
    is
        l_proc_dr_row proc_dr$base%rowtype;
    begin
        l_proc_dr_row := get_proc_dr_row(p_balance_account, p_customer_id, p_branch => p_branch);

        return get_income_account(l_proc_dr_row, p_currency_id);
    end;

    ------------
    -- ���������� �������� �� �������������� �� �������� ������������ �� ��������
    --
    procedure collateral_payments(
        p_mbk_id   in cc_deal.nd%type,     -- ��.   �����
        p_mbk_num  in cc_deal.cc_id%type,  -- ����� �����
        p_beg_dt   in cc_deal.sdate%type,  -- ���� ����������
        p_end_dt   in cc_deal.wdate%type,  -- ���� ����������
        p_clt_amnt in oper.s%type,         -- ����    ������������
        p_acc_num  in oper.nlsa%type,      -- ������� ������������
        p_ccy_id   in oper.kv%type,        -- ������  ������������
        p_rnk      in customer.nmk%type,   -- ���
        p_dk       in oper.dk%type)        -- �/�
    is
        title         constant  varchar2(60) := 'mbk.collateral_payments';
        l_ref                   oper.ref%type;
        l_tt                    oper.tt%type := 'ZAL';
        l_nd                    oper.nd%type;
        l_dk                    oper.dk%type;
        l_vob                   oper.vob%type;
        l_nazn                  oper.nazn%type;
        l_9910_num              accounts.nls%type;
        l_9910_nm               accounts.nms%type;
        l_cust_num              customer.nmkk%type;
        l_cust_code             customer.okpo%type;
    begin

        bars_audit.trace( '%s: Entry with ( p_clt_amnt ).', title, to_char(p_clt_amnt) );

        begin
          select a.NLS, a.NMS
            into l_9910_num, l_9910_nm
            from BARS.ACCOUNTS a
           where a.NLS  = Substr(BARS.BRANCH_USR.GET_BRANCH_PARAM('NLS_9900'),1,14)
             and a.KV   = p_ccy_id
             and a.DAZS is Null;
        exception
          when NO_DATA_FOUND then
            raise_application_error( -20666, '�� �������� ��� �������� ������� 9910', true );
        end;

        begin

          select nvl(c.NMKK,SubStr(c.NMK,1,38)), c.OKPO
            into l_cust_num, l_cust_code
            from BARS.CUSTOMER c
           where c.RNK = p_rnk
             and c.DATE_OFF Is Null;

        exception
          when NO_DATA_FOUND then
            raise_application_error( -20666, '�� �������� ��� �������� �볺�� � ��� = ' || to_char(p_rnk), true );
        end;

        l_nd  := bars.GetGlobalOption('MBK_ND');

        l_vob := BARS.F_GET_PARAMS('MBK_VZAL',0);

        l_vob := case
                    when ( l_vob = 0 )
                    then 6
                    when ( p_ccy_id = gl.baseval )
                    then 6
                    else l_vob
                  end;

        --------------------

        l_nazn := '������� ����� ����� ' || p_mbk_num || ' �� ' || to_char(p_beg_dt,'dd/mm/yyyy');

        gl.ref( l_ref );

        l_nd := case when ( l_nd = 'REF' ) then SubStr(to_char(l_ref),-10)
                                           else SubStr(p_mbk_num,   1, 10)
                end;

        l_dk := 1 - p_dk;

        gl.in_doc3( ref_    => l_ref,                  mfoa_   => gl.aMFO,
                    tt_     => l_tt,                   nlsa_   => l_9910_num,
                    vob_    => l_vob,                  kv_     => p_ccy_id,
                    dk_     => l_dk,                   nam_a_  => l_9910_nm,
                    nd_     => l_nd,                   id_a_   => gl.aOKPO,
                    pdat_   => sysdate,                s_      => p_clt_amnt,
                    vdat_   => p_beg_dt,               mfob_   => gl.aMFO,
                    data_   => p_beg_dt,               nlsb_   => p_acc_num,
                    datp_   => p_beg_dt,               kv2_    => p_ccy_id,
                    sk_     => null,                   nam_b_  => l_cust_num,
                    d_rec_  => null,                   id_b_   => nvl( l_cust_code, gl.aOKPO ),
                    id_o_   => null,                   s2_     => p_clt_amnt,
                    sign_   => null,                   nazn_   => l_nazn,
                    sos_    => null,                   uid_    => null,
                    prty_   => 0 );

        paytt( null, l_ref, p_beg_dt, l_tt, l_dk,
                     p_ccy_id, l_9910_num, p_clt_amnt,
                     p_ccy_id, p_acc_num , p_clt_amnt );

        bars_audit.info( title || '������� ��. ZAL ���. ' || to_char(l_ref) || ' �� ���. ' || to_char(p_mbk_id) );

        cck_utl.link_document_to_deal(p_mbk_id, l_ref);

        --------------------

        l_ref  := null;

        l_nazn := '���������� ������� ����� ����� ' || p_mbk_num || ' �� ' || to_char(p_beg_dt,'dd/mm/yyyy');

        gl.ref( l_ref );

        l_nd := case when ( l_nd = 'REF' ) then SubStr(to_char(l_ref),-10)
                                           else SubStr(p_mbk_num,   1, 10)
                end;

        l_dk := p_dk;

        gl.in_doc3( ref_    => l_ref,                  mfoa_   => gl.aMFO,
                    tt_     => l_tt,                   nlsa_   => l_9910_num,
                    vob_    => l_vob,                  kv_     => p_ccy_id,
                    dk_     => l_dk,                   nam_a_  => l_9910_nm,
                    nd_     => l_nd,                   id_a_   => gl.aOKPO,
                    pdat_   => sysdate,                s_      => p_clt_amnt,
                    vdat_   => p_end_dt,               mfob_   => gl.aMFO,
                    data_   => p_end_dt,               nlsb_   => p_acc_num,
                    datp_   => p_end_dt,               kv2_    => p_ccy_id,
                    sk_     => null,                   nam_b_  => l_cust_num,
                    d_rec_  => null,                   id_b_   => nvl( l_cust_code, gl.aOKPO ),
                    id_o_   => null,                   s2_     => p_clt_amnt,
                    sign_   => null,                   nazn_   => l_nazn,
                    sos_    => null,                   uid_    => null,
                    prty_   => 0 );

        paytt( null, l_ref, p_end_dt, l_tt, l_dk,
                     p_ccy_id, l_9910_num, p_clt_amnt,
                     p_ccy_id, p_acc_num , p_clt_amnt );

        bars_audit.info( title || '������� ��. ZAL ���. ' || to_char(l_ref) || ' �� ���. ' || to_char(p_mbk_id) );

        cck_utl.link_document_to_deal(p_mbk_id, l_ref);

        --------------------

        bars_audit.trace( '%s: Exit with ( ref = %s ).', title, to_char(l_ref) );

    end;


    ------------------------------------------------------------------
    --    ���� ����� ������
    --
    procedure create_deal (
        p_deal_number varchar2,   -- N ������/��������
        p_deal_type   integer,        -- ��� ��������
        nkv_        integer,        -- ������
        rnkb_       integer,        -- ���.� ��������
        dat2_       date,       -- ���� ������
        p_datv      date,       -- ���� �������������
        dat4_       date,       -- ���� ���������
        ir_         number,     -- ����� ������
        op_         number,     -- �����.����
        br_         number,     -- ������� ������
        sum_        number,     -- ����� ������ (� ���.)
        nbasey_     integer,        -- % ����
        nio_        integer,        -- ���������� �� �������� ������� 1-��/0-���
        s1_         varchar2,   -- ���.���� ��� ����� �
        s2_         varchar2,   -- ��� ����� � (mfo/bic) ��� ���.��
        s3_         varchar2,   -- ���� ���.% ��� ����� �
        s4_         varchar2,   -- ��� ����� � (mfo/bic) ��� �� ���.%
        s5_         number,     -- ���� ��� ����� ������
        nlsa_       varchar2,   -- �������� ���� � ����� �����
        nms_        varchar2,   -- ������������ ��������� �����
        nlsna_      varchar2,   -- ���� ����������� % � ����� �����
        nmsn_       varchar2,   -- ������������ ����� ����������� %
        nlsnb_      varchar2,   -- ���� ���.% ��� ����� � = S3_
        nmkb_       varchar2,   -- ������������ �������
        nazn_       varchar2,   -- ���������� ������� (% �� ���. CC_ID)
        nlsz_       varchar2,   -- ���� �����������
        nkvz_       integer,        -- ������ �����������
        p_pawn      number,     -- ��� ���� �����������
        id_dcp_     integer,        -- Id from dcp_p.id -- �� ���������������
        s67_        varchar2,   -- ���� �������
        ngrp_       integer,        -- ������ ������� ������
        nisp_       integer,        -- �����������
        bica_       varchar2,   -- BIC ������ �����
        ssla_       varchar2,   -- ���� VOSTRO � ������ �����-����������
        bicb_       varchar2,   -- BIC ��������
        sslb_       varchar2,   -- ���� VOSTRO �������� � ��� �����-�������
        sump_       number,     -- ����� %%
        altb_       varchar2,
        intermb_    varchar2,
        intpartya_  varchar2,
        intpartyb_  varchar2,
        intinterma_ varchar2,
        intintermb_ varchar2,
        nd_         out integer,
        acc1_       out integer,
        sErr_       out varchar2)
    is
        title         constant  varchar2(60) := 'mbk.create_deal';
        stta_                   char(3);
        sttb_                   char(3);
        tip1_                   char(3);
        tip2_                   char(3);
        l_interest_account_id   integer;
        l_pawn_account_id       integer;
        nid_                    integer;
        ntmp_                   integer;
        l_initiator             varchar2(2);
        l_ob22                  specparam_int.ob22%type;
        l_txt                   customerw.value%type;
        l_io                    int_accn.io%type := nio_;
        l_isp                   accounts.isp%type := nvl(nisp_, user_id());
        l_grp                   accounts.grp%type := nvl(ngrp_, 33);
        l_clt_amnt              oper.s%type; -- ���� ������� � pul
        inr_err                 exception;   -- Internal error
        l_proc_dr_row           proc_dr$base%rowtype;
        l_income_account_number varchar2(15 char) := s67_;
        l_income_account_row    accounts%rowtype;
        l_cc_vidd_row           cc_vidd%rowtype;
        l_customer_row          customer%rowtype;
    begin
        bars_audit.info( substr( title || ': Entry with( CC_ID_ => ' || p_deal_number
             || chr(10) || ', nVidd_ => '      || p_deal_type
             || chr(10) || ', nKV_ => '        || nkv_
             || chr(10) || ', DAT2_ => '       || to_char(dat2_ ,'dd/mm/yyyy')
             || chr(10) || ', p_datv => '      || to_char(p_datv,'dd/mm/yyyy')
             || chr(10) || ', DAT4_ => '       || to_char(dat4_ ,'dd/mm/yyyy')
             || chr(10) || ', RNKB_ => '       || rnkb_      || ', IR_ => '         || ir_
             || chr(10) || ', OP_   => '       || op_        || ', BR_ => '         || br_
             || chr(10) || ', SUM_  => '       || sum_       || ', nBASEY_ => '     || nbasey_
             || chr(10) || ', nIO_  => '       || nio_       || ', S1_  => '        || s1_
             || chr(10) || ', S2_   => '       || s2_        || ', S3_  => '        || s3_
             || chr(10) || ', S4_   => '       || s4_        || ', S5_  => '        || s5_
             || chr(10) || ', NLSA_ => '       || nlsa_      || ', NMS_ => '        || nms_
             || chr(10) || ', NLSNA_ => '      || nlsna_     || ', NMSN_ => '       || nmsn_
             || chr(10) || ', NLSNB_ => '      || nlsnb_     || ', NMKB_ => '       || nmkb_
             || chr(10) || ', Nazn_  => '      || nazn_      || ', NLSZ_ => '       || nlsz_
             || chr(10) || ', nKVZ_  => '      || nkvz_      || ', p_pawn => '      || p_pawn
             || chr(10) || ', Id_DCP_ => '     || id_dcp_    || ', S67_ => '        || s67_
             || chr(10) || ', nGrp_   => '     || ngrp_      || ', nIsp_ => '       || nisp_
             || chr(10) || ', BICA_   => '     || bica_      || ', SSLA_ => '       || ssla_
             || chr(10) || ', BICB_   => '     || bicb_      || ', SSLB_ => '       || sslb_
             || chr(10) || ', SUMP_   => '     || sump_      || ', AltB_ => '       || altb_
             || chr(10) || ', IntermB_    => ' || intermb_   || ', IntPartyA_ => '  || intpartya_
             || chr(10) || ', IntPartyB_  => ' || intpartyb_ || ', IntIntermA_ => ' || intinterma_
             || chr(10) || ', IntIntermB_ => ' || intintermb_|| ').', 1, 4000 ) );

        l_cc_vidd_row := cck_utl.read_cc_vidd(p_deal_type);
        l_customer_row := customer_utl.read_customer(rnkb_);
        l_proc_dr_row := get_proc_dr_row(p_deal_type, rnkb_);

        -- ���� �������-��������
        if (l_income_account_number is null) then

            l_income_account_number := get_income_account(l_proc_dr_row, nkv_);

            if (l_income_account_number is null) then
                raise_application_error(-20000, '�� ������� ��������� ������� ������/������ ��� ���� �������� {' || l_cc_vidd_row.name ||
                                                '} �� �������� {' || customer_utl.get_customer_name(rnkb_) || '}');
            end if;
        end if;

        l_income_account_row := account_utl.read_account(l_income_account_number, gl.baseval);

        if (l_income_account_row.dazs is not null) then
            raise_application_error(-20000, '������� ������/������ {' || l_income_account_number || '/' || gl.baseval || '} ��������');
        end if;

        nd_ := bars_sqnc.rukey(s_cc_deal.nextval);

        if (l_cc_vidd_row.tipd = 1) then
            nid_ := 0;
            tip1_:= 'SS ';
            tip2_:= 'SN ';
        else
            nid_ := 1;
            tip1_:= 'DEP';
            tip2_:= 'DEN';
        end if ;

        -- �������� ��������� �����
        MBK.op_reg_ex_2017 (1, nd_, ntmp_, l_grp, ntmp_, rnkb_, nlsa_, nkv_, nms_, tip1_, l_isp, acc1_, '1', null, null, null);

        -- �������� ����� ���.%%
        MBK.op_reg_ex_2017(1, nd_, ntmp_, l_grp, ntmp_, rnkb_, nlsna_, nkv_, nmsn_, tip2_, l_isp, l_interest_account_id, '1', null, null, null);

        -- �������� insert � cc_deal
        insert into cc_deal (nd, vidd, rnk, user_id, cc_id, sos, wdate, sdate, limit, kprolog)
        values (nd_, p_deal_type, rnkb_, user_id(), p_deal_number, 10, dat4_, gl.bdate, sum_, 0);

        insert into cc_add
            (nd, adds, s, kv, bdate, wdate, accs, sour, acckred, mfokred, freq, accperc, mfoperc, refp,
             swi_bic, swi_acc, swo_bic, swo_acc, int_amount, alt_partyb, interm_b,
             int_partya, int_partyb, int_interma, int_intermb )
        values
            (nd_, 0, sum_, nkv_, dat2_, p_datv, acc1_, 4, s1_, s2_, 2, s3_, s4_, s5_,
             bica_, ssla_, bicb_, sslb_, sump_, altb_, intermb_,
             intpartya_, intpartyb_, intinterma_, intintermb_);

        -- 30.08.2010 Sta
        l_initiator := substr(pul.get_mas_ini_val('INITIATOR'), 1, 2);

        if (gl.amfo = '300465' and l_initiator is not null) then
            -- ���.��������� ����� SS
            update specparam_cp_ob
            set    initiator = l_initiator
            where  acc = acc1_;

            if (sql%rowcount = 0) then
                insert into specparam_cp_ob (acc, initiator)
                values (acc1_ , l_initiator);
            end if;

            update specparam_cp_ob
            set    initiator = l_initiator
            where  acc = l_interest_account_id;

            if (sql%rowcount = 0) then
                insert into specparam_cp_ob (acc, initiator)
                values (l_interest_account_id, l_initiator);
            end if;
        end if;

        update accounts
        set    mdate = dat4_,
               pap = l_cc_vidd_row.tipd
        where  acc = acc1_;

        update accounts
        set    mdate = dat4_
        where  acc = l_interest_account_id;

        -- Artem Yurchenko, 24.11.2014
        -- ��� ��������� �������� ���������� ������������ ������ ��������
        if (check_if_deal_belong_to_crsour(p_deal_type) = 'Y') then
            -- ��������� ��22
            l_ob22 := '02';
            accreg.setaccountsparam(acc1_, 'OB22', l_ob22);
            accreg.setaccountsparam(l_interest_account_id, 'OB22', l_ob22);

            -- ��������� ������������ ��� (����� ��� ������ 32, 33)
            accreg.setaccountsparam(acc1_, 'MFO', s2_);
            accreg.setaccountsparam(l_interest_account_id, 'MFO', s2_);

            --�������� �� ���������� ����
            stta_ := case when nkv_ = gl.baseval then l_proc_dr_row.tt
                          else l_proc_dr_row.ttv
                     end;

            sttb_ := 'PS2';
        else
            -- �������� �� ���������� ����
            stta_ := case when l_customer_row.codcagent = 1 then -- ����-��������
                               nvl(branch_attribute_utl.get_value('MBD_%%1'), '%%1')
                          else case when l_cc_vidd_row.tipd = 1 then '%00'
                                    else '%02'
                               end
                     end;

            sttb_ := case when nkv_ = gl.baseval then 'WD2' else 'WD3' end;
        end if;

        -- ��� �������� �������� D020 := '01'
        accreg.setAccountSParam(acc1_, 'D020', '01');

        if (l_io is null) then
            l_io := l_proc_dr_row.io;
        end if;

        update int_accn
        set    basey = nbasey_,
               tt = stta_,
               stp_dat = dat4_-1,
               acra = l_interest_account_id,
               acrb = l_income_account_row.acc,
               s = 0,
               io = l_io,
               acr_dat = decode(l_io, 1, gl.bdate, acr_dat)
         where acc = acc1_ and
               id  = nid_;

        if (sql%rowcount = 0) then
            insert into int_accn (acc, id, metr, basem, basey, freq, acra, acrb, kvb, tt, ttb, stp_dat, s, io, acr_dat)
            values (acc1_, nid_, 0, 0, nbasey_, 1, l_interest_account_id, l_income_account_row.acc, nkv_, stta_, sttb_, dat4_ - 1, 0, l_io, decode(l_io, 1, gl.bdate, null));
        end if;

        if (nid_ = 1 and nkv_ = gl.baseval) then
           update int_accn
           set    nlsb = nlsnb_,
                  mfob = s2_,
                  namb = substr(nmkb_, 1, 38),
                  nazn = nazn_
           where  acc = acc1_ and
                  id = 1;
        elsif (nid_ = 1 and nkv_ <> gl.baseval) then
            if (check_if_deal_belong_to_crsour(p_deal_type) = 'Y') then
                update int_accn
                set    nlsb = substr(nlsnb_, 1, 14),
                       mfob = s2_,
                       namb = substr(nmkb_, 1, 38),
                       nazn = nazn_
                where  acc = acc1_ and
                       id = 1;
            else
                update int_accn
                set    nlsb = substr(nlsnb_, 1, 14),
                       namb = substr(nmkb_, 1, 38),
                       nazn = nazn_
                where  acc = acc1_ and
                       id = 1;
            end if;
        end if;

        update int_ratn
        set    ir = ir_,
               op = op_,
               br = br_
        where  acc = acc1_ and
               id = nid_ and
               bdat = dat2_;

        if (sql%rowcount = 0) then
            insert into int_ratn (acc  , id ,bdat ,ir ,op ,br)
            values (acc1_, nid_, dat2_, ir_, op_, br_);
        end if;

        -- ����� ��� ����� ������ ��� 1-�� ������
        if (p_deal_type like '1%') then
            accreg.setAccountSParam(acc1_, 'S180', fs180(acc1_, '1', bankdate));
        end if;

        -- ��������� ��������� ��������� �� �������� ���
        l_txt := kl.get_customerw(rnkb_, 'VNCRR');

        -- �������� ���
        cck_utl.set_deal_attribute(nd_, 'VNCRR', l_txt);

        -- ��������� ���
        cck_utl.set_deal_attribute(nd_, 'VNCRP', l_txt);

        if (nlsz_ is not null) then
            -- �������� ����� ������
            MBK.op_reg_ex_2017 (2, nd_, p_pawn, 2, ntmp_, rnkb_, nlsz_, nkvz_, nms_, 'ZAL', l_isp, l_pawn_account_id, '1', null, null, null); -- KB  pos=1

            -- ����������� ������ ������� ��� ����� ������ ��� ��� ��������� �����
            p_setaccessbyaccmask(l_pawn_account_id, acc1_);

            insert into nd_acc (nd, acc)
            values (nd_, l_pawn_account_id);

            if (l_cc_vidd_row.tipd = 1) then
                update cc_accp
                set    nd = nd_
                where  acc = l_pawn_account_id and
                       accs = acc1_;

                if (sql%rowcount = 0) then
                    insert into cc_accp (acc, accs, nd)
                    values (l_pawn_account_id, acc1_, nd_);
                end if;
            end if;

            cck_utl.set_deal_attribute(nd_, 'PAWN', to_char(p_pawn));

            update accounts
            set    mdate = dat4_
            where  acc = l_pawn_account_id;

            l_clt_amnt := to_number(pul.get_mas_ini_val('COLLATERAL_AMOUNT'));

            if (l_clt_amnt > 0) then
                collateral_payments(p_mbk_id   => nd_,
                                    p_mbk_num  => p_deal_number,
                                    p_beg_dt   => dat2_,
                                    p_end_dt   => dat4_,
                                    p_clt_amnt => l_clt_amnt,
                                    p_acc_num  => nlsz_,
                                    p_ccy_id   => nkvz_,
                                    p_rnk      => rnkb_,
                                    p_dk       => case when l_cc_vidd_row.tipd = 1 then 1 else 0 end);
            end if;
        end if;
    end;
    ----------------------------------------------------------------------
    --    ��������� ���������� ���� ���������� ������
    --
    procedure upd_cc_deal (p_nd number, p_sdate date)
    is
    begin
      update cc_deal set sdate = p_sdate where nd = p_nd;
    end upd_cc_deal;

    ----------------------------------------------------------------------
    PROCEDURE inp_deal_Ex (
      CC_ID_        varchar2,   -- N ������/��������
      nVidd_        integer,        -- ��� ��������
      nTipd_        integer,        -- ��� ��������
      nKV_          integer,        -- ������
      RNKB_         integer,        -- ���.� ��������
      DAT2_         date,       -- ���� ������
      p_datv        date,       -- ���� �������������
      DAT4_         date,       -- ���� ���������
      IR_           number,     -- ����� ������
      OP_           number,     -- �����.����
      BR_           number,     -- ������� ������
      SUM_          number,     -- ����� ������ (� ���.)
      nBASEY_       integer,        -- % ����
      nIO_          integer,        -- ���������� �� �������� ������� 1-��/0-���
      S1_           varchar2,   -- ���.���� ��� ����� �
      S2_           varchar2,   -- ��� ����� � (mfo/bic) ��� ���.��
      S3_           varchar2,   -- ���� ���.% ��� ����� �
      S4_           varchar2,   -- ��� ����� � (mfo/bic) ��� �� ���.%
      S5_           number,     -- ���� ��� ����� ������
      NLSA_         varchar2,   -- �������� ���� � ����� �����
      NMS_          varchar2,   -- ������������ ��������� �����
      NLSNA_        varchar2,   -- ���� ����������� % � ����� �����
      NMSN_         varchar2,   -- ������������ ����� ����������� %
      NLSNB_        varchar2,   -- ���� ���.% ��� ����� � = S3_
      NMKB_         varchar2,   -- ������������ �������
      Nazn_         varchar2,   -- ���������� ������� (% �� ���. CC_ID)
      NLSZ_         varchar2,   -- ���� �����������
      nKVZ_         integer,        -- ������ �����������
      p_pawn        number,     -- ��� ���� �����������
      Id_DCP_       integer,        -- Id from dcp_p.id
      S67_          varchar2,   -- ���� �������
      nGrp_         integer,        -- ������ ������� ������
      nIsp_         integer,        -- �����������
      BICA_         varchar2,   -- BIC ������ �����
      SSLA_         varchar2,   -- ���� VOSTRO � ������ �����-����������
      BICB_         varchar2,   -- BIC ��������
      SSLB_         varchar2,   -- ���� VOSTRO �������� � ��� �����-�������
      SUMP_         number,     -- ����� %%
      AltB_         varchar2,
      IntermB_      varchar2,
      IntPartyA_    varchar2,
      IntPartyB_    varchar2,
      IntIntermA_   varchar2,
      IntIntermB_   varchar2,
      ND_           out integer,
      ACC1_         out integer,
      sErr_         out varchar2,
      DDAte_        date     default null,  -- ���� ����������
      IRR_          number   default null,  -- ��. % ������
      code_product_ number   default null,  -- ��� ��������
      n_nbu_        varchar2 default null,   -- ����� �������� ���
	  d_nbu_        date     default null   -- ���� ��������� ���
    ) IS

      title         constant  varchar2(60) := 'mbk.inp_deal';
      sTTA_                   char(3);
      sTTB_                   char(3);
      Tip1_                   char(3);
      Tip2_                   char(3);
      ACC2_                   accounts.acc%type;
      ACC3_                   accounts.acc%type;
      ACC4_                   accounts.acc%type;
      nID_                    integer;
      nUser_                  integer;
      nTmp_                   integer;
      l_s180                  specparam.s180%type;
      l_initiator             varchar2(2);
      l_ob22                  specparam_int.ob22%type;
      l_proc_dr_row           proc_dr$base%rowtype;
      l_txt                   customerw.value%type;
      l_tipd                  cc_vidd.tipd%type;
      l_io                    int_accn.io%type;
      l_isp                   accounts.isp%type;
      l_grp                   accounts.grp%type;
      l_clt_amnt              oper.s%type; -- ���� ������� � pul
      inr_err                 exception;   -- Internal error
	  l_nmkb                  int_accn.namb%type;


    BEGIN

	   
      bars_audit.info( SubStr( title || ': Entry with( CC_ID_ => ' || CC_ID_
           || chr(10) || ', nVidd_ => '      || nVidd_
           || chr(10) || ', nTipd_ => '      || nTipd_
           || chr(10) || ', nKV_ => '        || nKV_
           || chr(10) || ', DAT2_ => '       || to_char(DAT2_ ,'dd/mm/yyyy')
           || chr(10) || ', p_datv => '      || to_char(p_datv,'dd/mm/yyyy')
           || chr(10) || ', DAT4_ => '       || to_char(DAT4_ ,'dd/mm/yyyy')
           || chr(10) || ', RNKB_ => '       || RNKB_      || ', IR_ => '         || IR_
           || chr(10) || ', OP_   => '       || OP_        || ', BR_ => '         || BR_
           || chr(10) || ', SUM_  => '       || SUM_       || ', nBASEY_ => '     || nBASEY_
           || chr(10) || ', nIO_  => '       || nIO_       || ', S1_  => '        || S1_
           || chr(10) || ', S2_   => '       || S2_        || ', S3_  => '        || S3_
           || chr(10) || ', S4_   => '       || S4_        || ', S5_  => '        || S5_
           || chr(10) || ', NLSA_ => '       || NLSA_      || ', NMS_ => '        || NMS_
           || chr(10) || ', NLSNA_ => '      || NLSNA_     || ', NMSN_ => '       || NMSN_
           || chr(10) || ', NLSNB_ => '      || NLSNB_     || ', NMKB_ => '       || NMKB_
           || chr(10) || ', Nazn_  => '      || Nazn_      || ', NLSZ_ => '       || NLSZ_
           || chr(10) || ', nKVZ_  => '      || nKVZ_      || ', p_pawn => '      || p_pawn
           || chr(10) || ', Id_DCP_ => '     || Id_DCP_    || ', S67_ => '        || S67_
           || chr(10) || ', nGrp_   => '     || nGrp_      || ', nIsp_ => '       || nIsp_
           || chr(10) || ', BICA_   => '     || BICA_      || ', SSLA_ => '       || SSLA_
           || chr(10) || ', BICB_   => '     || BICB_      || ', SSLB_ => '       || SSLB_
           || chr(10) || ', SUMP_   => '     || SUMP_      || ', AltB_ => '       || AltB_
           || chr(10) || ', IntermB_    => ' || IntermB_   || ', IntPartyA_ => '  || IntPartyA_
           || chr(10) || ', IntPartyB_  => ' || IntPartyB_ || ', IntIntermA_ => ' || IntIntermA_
           || chr(10) || ', IntIntermB_ => ' || IntIntermB_|| ').', 1, 4000 ) );

      BEGIN

        l_nmkb := substr(NMKB_,1,38);
        nUser_ := USER_ID;
        ND_    := null;

        -- ���� �������-��������
        if ( S67_ Is Null )    then      ACC3_ := BARS.F_PROC_DR( RNKB_, 4, 0, 'MKD', nVidd_, nKv_ );
           if ( ACC3_ Is Null ) then     sERR_ := '�� �������� ������� ������/������';          raise inr_err;       end if;
        else  BEGIN  SELECT acc  INTO ACC3_  FROM accounts  WHERE kv=gl.baseval   and nls=S67_            and dazs is null;
              EXCEPTION  WHEN NO_DATA_FOUND THEN      sERR_ := '�� ������ ���� '||S67_;          raise inr_err;
              END;
        end if;
        nd_ := bars_sqnc.get_nextval('s_cc_deal');
        INSERT INTO cc_deal (nd , vidd  , rnk  , user_id, cc_id , sos, wdate, sdate                , limit, kprolog,ir  ,prod         )
                     VALUES (ND_, nVidd_, RNKB_, nUser_ , CC_ID_, 10 , DAT4_, nvl(DDAte_, gl.BDATE), SUM_ , 0      ,IRR_,code_product_);
        INSERT INTO cc_add (nd         , adds       , s      , kv     , bdate  , wdate  , sour      , acckred   , mfokred , freq      , accperc   ,
                            mfoperc    , refp       , swi_bic, swi_acc, swo_bic, swo_acc, int_amount, alt_partyb, interm_b, int_partya, int_partyb,
                            int_interma, int_intermb, n_nbu, d_nbu  )
                    VALUES (ND_        , 0          , Sum_   , nKv_   , DAT2_  , p_datv , 4         , S1_       , S2_     , 2         , S3_       ,
                            S4_        , S5_        , bica_  , ssla_  , bicb_  , sslb_  , sump_     , altb_     , intermb_, IntPartyA_, IntPartyB_,
                            IntIntermA_, IntIntermB_, n_nbu_ , d_nbu_ );

        if ( nTipd_ Is Null )  then select TIPD into l_tipd  from CC_VIDD where VIDD = nVidd_;   else  l_tipd := nTipd_; end if;
        if l_tipd = 1   then   nID_ :=0;  Tip1_:='SS ';  Tip2_:='SN '; else  nID_ :=1;  Tip1_:='DEP';  Tip2_  :='DEN'  ; end if ;
        l_isp := Nvl( nIsp_, gl.aUID) ;
        l_grp := Nvl(nGrp_, 33) ;

        -- �������� ��������� �����
        MBK.op_reg_ex_2017 (1,ND_,nTmp_, l_grp, nTmp_,RNKB_,NLSA_, nKv_,NMS_, Tip1_, l_isp, ACC1_, '1', null, null,  null);  -- KB  pos=1
        -- �������� ����� ���.%%
        MBK.op_reg_ex_2017 (1,ND_,nTmp_, l_grp, nTmp_,RNKB_,NLSNA_,nKv_,NMSN_,Tip2_, l_isp, ACC2_, '1', null, null,  null);  -- KB  pos=1

        UPDATE cc_add           SET accs=ACC1_         WHERE nd=ND_;
        l_INITIATOR := substr( pul.Get_Mas_Ini_Val('INITIATOR'), 1, 2 );

        If gl.aMfo = '300465' and l_INITIATOR is not null then
           -- ���.��������� ����� SS
           EXECUTE IMMEDIATE 'update SPECPARAM_CP_OB set INITIATOR =''' || l_INITIATOR || ''' where acc= '|| ACC1_ ;
           if SQL%rowcount = 0 then  EXECUTE IMMEDIATE 'insert into SPECPARAM_CP_OB (ACC,INITIATOR) '  ||   'values ( ' || ACC1_ || ', '''|| l_INITIATOR || ''' )';           end if;
           EXECUTE IMMEDIATE 'update SPECPARAM_CP_OB set INITIATOR =''' || l_INITIATOR || ''' where acc= '|| ACC2_ ;
           if SQL%rowcount = 0 then  EXECUTE IMMEDIATE 'insert into SPECPARAM_CP_OB (ACC,INITIATOR) ' ||    'values ( ' || ACC2_ || ', '''|| l_INITIATOR || ''' )';           end if;
        end if;
        -------------

        IF NLSZ_ is not null      then
           -- �������� ����� ������
           MBK.op_reg_ex_2017 ( 2, ND_, p_pawn  , 2, nTmp_, RNKB_, NLSZ_, nKVZ_, NMS_, 'ZAL', l_isp, ACC4_, '1', null, null, null                   ); -- KB  pos=1
           -- ����������� ������ ������� ��� ����� ������ ��� ��� ��������� �����
           p_setAccessByAccmask(ACC4_, ACC1_);
           insert into nd_acc (nd, acc) values (ND_, ACC4_);

           if l_tipd = 1 then update cc_accp set nd=ND_ where acc=ACC4_ and accs=ACC1_; IF SQL%rowcount = 0 then INSERT into cc_accp (ACC,ACCS,nd) values (ACC4_,ACC1_,ND_); END IF; END IF;
           cck_utl.set_deal_attribute(ND_, 'PAWN', to_char(p_pawn));
        END IF;

        IF Id_DCP_ is not null then            UPDATE dcp_p Set ref=-ND_, acc=ACC1_ WHERE id=Id_DCP_; END IF;          -- ����������� - ���
        UPDATE accounts SET mdate=DAT4_,PAP=l_tipd WHERE acc=ACC1_;
        UPDATE accounts SET mdate=DAT4_            WHERE acc=ACC2_;
        UPDATE accounts SET mdate=DAT4_            WHERE acc=ACC4_;

        -- Artem Yurchenko, 24.11.2014
        -- ��� ��������� �������� ���������� ������������ ������ ��������
        if (check_if_deal_belong_to_crsour(nVidd_) = 'Y') then
            -- ��������� ��22
            l_ob22 := '02';
            accreg.setAccountSParam(ACC1_, 'OB22', l_ob22);
            accreg.setAccountSParam(ACC2_, 'OB22', l_ob22);

            -- ��������� ������������ ��� (����� ��� ������ 32, 33)
            accreg.setAccountSParam(ACC1_, 'MFO', s2_);
            accreg.setAccountSParam(ACC2_, 'MFO', s2_);

            sTTB_ := 'PS2';

            --�������� �� ���������� ����
            l_proc_dr_row := get_proc_dr_row(to_char(nVidd_, 'FM9999'), rnkb_);
            sTTA_ := case when nKv_ = gl.baseval then l_proc_dr_row.tt
                          else l_proc_dr_row.ttv
                     end;
        else
            sTTB_ := case when nKv_ = gl.baseval then 'WD2' else 'WD3' end;
            --�������� �� ���������� ����
            BEGIN
              SELECT val INTO sTTA_ FROM params WHERE par='MBD_%%1';
            EXCEPTION WHEN NO_DATA_FOUND THEN sTTA_ := '%%1';
            END;
            BEGIN              -- ��������-����������
              SELECT decode (codcagent,1, sTTA_, decode(l_tipd,1,'%00','%02') ) INTO sTTA_ FROM customer WHERE rnk=RNKB_;
            EXCEPTION WHEN NO_DATA_FOUND THEN sERR_ := '�� ������ RNKB '||RNKB_; raise inr_err;
            END;
        end if;

--        sTTB_ := case when nKv_ = gl.baseval then 'WD2' else 'WD3' end;
 --      BEGIN        SELECT val INTO sTTA_ FROM params WHERE par='MBD_%%1';          --�������� �� ���������� ����
--        EXCEPTION WHEN NO_DATA_FOUND THEN sTTA_ := '%%1';
--        END;

--        BEGIN  SELECT decode (codcagent,1, sTTA_, decode(l_tipd,1,'%00','%02') )    INTO sTTA_     FROM customer WHERE rnk=RNKB_;
--        EXCEPTION   WHEN NO_DATA_FOUND THEN     sERR_ := '�� ������ RNKB '||RNKB_;  raise inr_err;
--        END;       -- ��������-����������

        l_io := NVL(nIO_,0);

        update BARS.INT_ACCN set BASEY = nBASEY_, TT = sTTA_, STP_DAT = DAT4_-1 , ACRA = ACC2_, ACRB = ACC3_, s = 0, IO = l_io , acr_dat = decode(l_io,1,gl.BDATE,acr_dat)   where acc = ACC1_  and id  = nID_;
        IF SQL%rowcount = 0  then  INSERT INTO int_accN ( acc, ID, metr, basem, BASEY, freq, ACRA, ACRB, KVB, TT, TTB, STP_DAT, s, IO, acr_dat )
                                                VALUES (ACC1_, nID_, 0, 0, nBASEY_, 1, ACC2_, ACC3_, nKv_, sTTA_, sTTB_, DAT4_-1, 0, l_io, decode(l_io,1,gl.BDATE,null));
        END IF;

        IF    nID_ = 1 and nKV_=gl.baseval  then UPDATE int_accN   Set NLSB=NLSNB_     , MFOB=S2_     , NAMB= l_nmkb     , NAZN=Nazn_ WHERE acc=ACC1_ AND id=1;
        ELSIF nID_ = 1 and nKV_<>gl.baseval then
            if (check_if_deal_belong_to_crsour(nVidd_) = 'Y') then
                update int_accn
                set    nlsb = substr(nlsnb_, 1, 14),
                       mfob = s2_,
                       namb = l_nmkb,
                       nazn = nazn_
                 where acc = acc1_ and
                       id = 1;
            else
                UPDATE int_accN   Set NLSB=substr(NLSNB_,1,14), NAMB=l_nmkb, NAZN=Nazn_              WHERE acc=ACC1_ AND id=1;
            end if;

        end if;

        update INT_ratn   SET ir=IR_, op=OP_, br=BR_ where acc=ACC1_ and id=nID_ and bdat=DAT2_;
        if SQL%rowcount = 0 then  INSERT INTO INT_ratn (acc  , ID ,bdat ,ir ,op ,br)     VALUES (ACC1_, nID_, DAT2_, IR_, OP_, BR_);  end if;

        -- ��� �������� �������� D020 := '01'
        UPDATE specparam set D020 = '01' where acc=ACC1_;         if SQL%rowcount = 0 then   INSERT INTO specparam (ACC, D020 ) values ( ACC1_, '01' );     end if;
        if nVidd_ like '1%' then   l_s180 := FS180(ACC1_, '1', bankdate);          -- ����� ��� ����� ������ ��� 1-�� ������
           update specparam set s180 = l_s180 where acc = acc1_;  if SQL%rowcount = 0 then  INSERT INTO specparam (ACC, S180) values (ACC1_, l_s180);       end if;
        end if;
        -- ��������� ��������� ��������� �� �������� ���
        begin  select VALUE    into l_txt    from BARS.CUSTOMERW   where RNK = RNKB_     and TAG = 'VNCRR';
        exception     when NO_DATA_FOUND then    bars_audit.info( title || ': not found "VNCRR" for RNK = ' || to_char(RNKB_) );      -- raise_application_error(-20666, '³����� �������� ��� � �볺��� � ��� = '||to_char(RNKB_), true);
        end;
        cck_utl.set_deal_attribute( ND_, 'VNCRR', l_txt );         -- �������� ���
        -- ��������� ���
        begin  insert   into BARS.ND_TXT       ( ND, TAG, TXT )    values    ( ND_, 'VNCRP', l_txt );
        exception  when DUP_VAL_ON_INDEX then   null;      -- ��� ��� ���������� ��������
        end;

        begin l_clt_amnt := to_number( bars.pul.get_mas_ini_val('COLLATERAL_AMOUNT') );
           if l_clt_amnt > 0  and  NLSZ_ is Not Null    then
              collateral_payments( p_mbk_id   => ND_   , p_mbk_num  => CC_ID_  , p_beg_dt   => DAT2_  , p_end_dt   => DAT4_  , p_clt_amnt => l_clt_amnt, 
                                   p_acc_num  => NLSZ_ , p_ccy_id   => nKVZ_   , p_rnk      => RNKB_  , p_dk       => case when l_tipd = 1 then 1 else 0 end   );
          end if;
------- exception  when OTHERS then      bars_audit.info( 'mbk.inp_deal: collateral_payments_error => '|| dbms_utility.format_error_stack()   || dbms_utility.format_error_backtrace() );
        end;

      EXCEPTION when INR_ERR then  null;
--------------- when OTHERS  then  bars_audit.info( 'mbk.inp_deal: error => '|| dbms_utility.format_error_stack() || dbms_utility.format_error_backtrace() );  sErr_ := dbms_utility.format_error_stack();
      END;

      bars_audit.info( 'mbk.inp_deal: Exit with( ND='|| to_char(ND_) ||', ACC1='|| to_char(ACC1_) || ').' );

    END inp_deal_Ex;
    ------------------------------------------------------------------
    -- inp_deal
    --
    --    ���� ����� ������
    --
    --
    PROCEDURE inp_deal (
      CC_ID_       varchar2,   -- N ������/��������
      nVidd_       integer,        -- ��� ��������
      nTipd_       integer,        -- ��� ��������
      nKV_         integer,        -- ������
      RNKB_        integer,        -- ���.� ��������
      DAT2_        date,       -- ���� ������
      p_datv       date,       -- ���� �������������
      DAT4_        date,       -- ���� ���������
      IR_          number,     -- ����� ������
      OP_          number,     -- �����.����
      BR_          number,     -- ������� ������
      SUM_         number,     -- ����� ������ (� ���.)
      nBASEY_      integer,        -- % ����
      nIO_         integer,        -- ���������� �� �������� ������� 1-��/0-���
      S1_          varchar2,   -- ���.���� ��� ����� �
      S2_          varchar2,   -- ��� ����� � (mfo/bic) ��� ���.��
      S3_          varchar2,   -- ���� ���.% ��� ����� �
      S4_          varchar2,   -- ��� ����� � (mfo/bic) ��� �� ���.%
      S5_          number,     -- ���� ��� ����� ������
      NLSA_        varchar2,   -- �������� ���� � ����� �����
      NMS_         varchar2,   -- ������������ ��������� �����
      NLSNA_       varchar2,   -- ���� ����������� % � ����� �����
      NMSN_        varchar2,   -- ������������ ����� ����������� %
      NLSNB_       varchar2,   -- ���� ���.% ��� ����� � = S3_
      NMKB_        varchar2,   -- ������������ �������
      Nazn_        varchar2,   -- ���������� ������� (% �� ���. CC_ID)
      NLSZ_        varchar2,   -- ���� �����������
      nKVZ_        integer,        -- ������ �����������
      p_pawn       number,     -- ��� ���� �����������
      Id_DCP_      integer,        -- Id from dcp_p.id
      S67_         varchar2,   -- ���� �������
      nGrp_        integer,        -- ������ ������� ������
      nIsp_        integer,        -- �����������
      BICA_        varchar2,   -- BIC ������ �����
      SSLA_        varchar2,   -- ���� VOSTRO � ������ �����-����������
      BICB_        varchar2,   -- BIC ��������
      SSLB_        varchar2,   -- ���� VOSTRO �������� � ��� �����-�������
      SUMP_        number,     -- ����� %%
      AltB_        varchar2,
      IntermB_     varchar2,
      IntPartyA_   varchar2,
      IntPartyB_   varchar2,
      IntIntermA_  varchar2,
      IntIntermB_  varchar2,
      ND_          out integer,
      ACC1_        out integer,
      sErr_        out varchar2
    ) IS


      BEGIN

         inp_deal_Ex (  CC_ID_       ,   -- N ������/��������
                        nVidd_       ,   -- ��� ��������
                        nTipd_       ,   -- ��� ��������
                        nKV_         ,   -- ������
                        RNKB_        ,   -- ���.� ��������
                        DAT2_        ,   -- ���� ������
                        p_datv       ,   -- ���� �������������
                        DAT4_        ,   -- ���� ���������
                        IR_          ,   -- ����� ������
                        OP_          ,   -- �����.����
                        BR_          ,   -- ������� ������
                        SUM_         ,   -- ����� ������ (� ���.)
                        nBASEY_      ,   -- % ����
                        nIO_         ,   -- ���������� �� �������� ������� 1-��/0-���
                        S1_          ,   -- ���.���� ��� ����� �
                        S2_          ,   -- ��� ����� � (mfo/bic) ��� ���.��
                        S3_          ,   -- ���� ���.% ��� ����� �
                        S4_          ,   -- ��� ����� � (mfo/bic) ��� �� ���.%
                        S5_          ,   -- ���� ��� ����� ������
                        NLSA_        ,   -- �������� ���� � ����� �����
                        NMS_         ,   -- ������������ ��������� �����
                        NLSNA_       ,   -- ���� ����������� % � ����� �����
                        NMSN_        ,   -- ������������ ����� ����������� %
                        NLSNB_       ,   -- ���� ���.% ��� ����� � = S3_
                        NMKB_        ,   -- ������������ �������
                        Nazn_        ,   -- ���������� ������� (% �� ���. CC_ID)
                        NLSZ_        ,   -- ���� �����������
                        nKVZ_        ,   -- ������ �����������
                        p_pawn       ,   -- ��� ���� �����������
                        Id_DCP_      ,   -- Id from dcp_p.id
                        S67_         ,   -- ���� �������
                        nGrp_        ,   -- ������ ������� ������
                        nIsp_        ,   -- �����������
                        BICA_        ,   -- BIC ������ �����
                        SSLA_        ,   -- ���� VOSTRO � ������ �����-����������
                        BICB_        ,   -- BIC ��������
                        SSLB_        ,   -- ���� VOSTRO �������� � ��� �����-�������
                        SUMP_        ,   -- ����� %%
                        AltB_        ,
                        IntermB_     ,
                        IntPartyA_   ,
                        IntPartyB_   ,
                        IntIntermA_  ,
                        IntIntermB_  ,
                        ND_          ,
                        ACC1_        ,
                        sErr_        ,
                        null         ,
                        null         ,
                        null         ,
						null         ,
                        null
                     );

      END inp_deal;


    ----------------------------------------------------------------------
    procedure set_field58d (p_nd number, p_field58d varchar2)
    is
    begin
      update cc_add set field_58d = p_field58d where nd = p_nd;
    end set_field58d;

    ------------------------------------------------------------------
    --    �������� ������
    --
    PROCEDURE del_deal
    ( ND_              integer
    ) is
      -- �������� ��.��������� ������
      DAT1_                 date;
      TIPD_                 integer;
      l_qty                 number(10);
      title       constant  varchar2(60) := 'mbk.del_deal';
    BEGIN

      bars_audit.trace( '%s: Entry with ( nd=%s ).', title, to_char(ND_) );

      -- ��������
      select count(m.ND)
        into l_qty
        from MBD_K_R m
       where m.ND = ND_
         and exists ( select 1 from OPER o where o.REF = m.REF and o.SOS > 0 );

      if ( l_qty > 0 )
      then
        raise_application_error( -20666, '�� �������� #' || to_char(ND_) || ' ����� ������� ���������!', TRUE );
      end if;

      BEGIN
        select d.SDATE, v.TIPD
          into DAT1_,TIPD_
          from cc_deal d , cc_vidd v
         where d.nd=ND_ and d.vidd=v.vidd ;

        for k in (select acc from nd_acc where nd=ND_)
        loop
          delete from int_ratn where acc=k.ACC and bdat >=DAT1_;
          update accounts SET mdate = null
           where acc=k.Acc
             and acc not in (select acc from mbd_k where nd<>ND_)   -- �� ���������� ����
             and ostc+ostb=0;                                       -- ���� ���� ����������� 2 ������
                                                                    -- ��� ��������� ������� �� �����
        end loop;

        delete from mbd_k_r
         where nd=ND_
           and ref in ( select ref from oper where sos<0 );
        DELETE FROM nd_acc  WHERE nd=ND_;
        DELETE FROM cc_add  WHERE nd=ND_;
        DELETE FROM cc_deal WHERE nd=ND_;
        DELETE FROM cc_docs WHERE nd=ND_;
        DELETE FROM cc_accp WHERE nd=ND_;

      EXCEPTION
        WHEN NO_DATA_FOUND THEN null;
      END;

      bars_audit.trace( '%s: Exit.', title );

    END del_deal;

    ------------------------------------------------------------------
    --    �������� ������
    --
    PROCEDURE clos_deal (ND_ integer ) is
    p_nd   number:=0;
    p_sos  number;
    -- �������� ������ �� ������ ���
    BEGIN
      for k in  -- �������� ������������ �� �������� (���� �������, �� �� �������)
      (select d.ND, d.WDATE, v.TIPD, d.SOS ,p.accs,p.accp ,
              a.ostc ostcs,a.ostb ostbs,a.ostf ostfs,
       n.ostc ostcp,n.ostb ostbp,n.ostf ostfp,
       i.acr_dat,a.mdate mdate_a,n.mdate mdate_n
         from cc_deal D, cc_vidd V,cc_add p,accounts a,accounts n,int_accn i
        where (ND_=0 or d.nd=ND_) and d.nd=p.nd
          and d.vidd=v.vidd and v.custtype=1
          and p.adds=0 and  p.accs=a.acc
          AND i.acc=a.acc AND i.acra=n.acc
         and d.sos<15 and d.WDATE <= gl.BDATE)
      LOOP
        /* ������ �� � �������� �� �������� �� SS SN � ���� ���%?   */
        begin  -- ��������� ������������ ����� ��������, ������� ����������� �����
          select max(nd) into p_nd from nd_acc  where acc in (k.accs,k.accp);
        EXCEPTION WHEN NO_DATA_FOUND THEN p_nd:=0;
        end;
        if ( k.ostcs=0 and k.ostbs=0 and k.ostfs=0
         and k.ostcp=0 and k.ostbp=0 and k.ostfp=0
         and k.acr_dat+1>=k.wdate and k.mdate_a=k.wdate
         and k.mdate_a=k.mdate_n )
        then
              p_sos:=15;
        elsif   -- ������� ���������, �� ����� ����������� ��� ����� ������ (�������� ��������)
           ( k.ostcs<>0 or k.ostbs<>0 or k.ostfs<>0
          or k.ostcp<>0 or k.ostbp<>0 or k.ostfp<>0 )
         and k.nd <p_nd and k.mdate_a=k.mdate_n and k.mdate_a>k.wdate
        then  p_sos:=15;
        else  p_sos:=k.sos;
        end if;
        update cc_deal set SOS=p_sos where nd=k.ND;
        -- ���������� ����� ������
        if p_sos = 15 then
           for z in ( select acc, accs from cc_accp where nd = k.nd )
           loop
              delete from nd_acc where nd = k.nd and acc in (z.acc, z.accs);
           end loop;
           delete from cc_accp where nd = k.nd;
        end if;
        commit;
      END LOOP;
      return;
    END clos_deal;

    ------------------------------------------------------------------
    --    ����� ����������� ������ ��������
    --
    PROCEDURE del_Ro_deal (ND_ integer )
    IS
    /* ����� ����������� ������ ��������
    */
      Ref_      number;
      Ref1_     number;
      Ref2_     number;
      Tipd_     number;
      ND_Old_   number;
      SDate_    date;
      WDate_    date;
      Dat1_     date;
      par2_     number;
      par3_     varchar2(30);
      ern       CONSTANT POSITIVE := 101;  -- error code
      err       EXCEPTION;
      erm       VARCHAR2(80);
      l_qty     number(10);
    BEGIN

      Ref1_:=0;
      Ref2_:=0;

      SELECT sdate
        INTO Dat1_
        FROM cc_deal WHERE nd=ND_ ;

      IF SDate_ <> gl.bdate
      THEN
        erm := '���������� �������� ������������� ������ RollOver!';
        raise err;
      END IF;
      -- ��� �������� 1- ������.,2-�������.
      begin
        select t.tipd into tipd_
          from cc_vidd t, cc_deal c
         where c.nd=ND_
           and c.vidd=t.vidd;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          erm := '�� ��������� ��� �������� ��� �������� ��� � �������';
          raise err;
      end;

      -- ND ������, �������� ��� �������� (����������)
      -- ����� ���������� �� ����
      -- 1. �������� ��������� ���� ������� ������
      begin

        SELECT nvl(min(m.ref),0)
          INTO Ref2_
          FROM mbd_k_r m, oper p
         WHERE m.nd=ND_ AND m.ref=p.ref AND p.tt='KV1'
           AND upper(p.nazn) like '%ROLLOVER%' ;

        IF  Ref2_=0
        THEN
          erm := '�� ����� ���. ��������� �������� ������� ������';
          raise err;
        END IF;

      end;

      begin
       select to_number(value) into ND_Old_
         from operw where ref=Ref2_ and tag='MBKND';
       EXCEPTION WHEN NO_DATA_FOUND THEN
         erm := '�����������  ����������� MBKND ��� ���.'||Ref2_;
       raise err;
      end;

      -- 2. ������������ Ref ��������� ���� ��������. ������ (���� ��������� ���� �� ������ �������)
      begin

        SELECT nvl(max(m.ref),0)
          INTO Ref1_
          FROM mbd_k_r m, oper p
         WHERE m.nd=ND_Old_ AND m.ref=p.ref AND p.tt='KV1'
           AND upper(p.nazn) like '%ROLLOVER%' ;

        IF Ref1_=0
        THEN
           erm := '�� ����� ���. ��������� �������� ���������� ������';
          raise err;
        END IF;

      end;

      -- �������� �� ������������� �������
      begin
        select count(1)
          into l_qty
          from ARC_RRP
         where ref in ( select ref from MBD_K_R where ND = ND_);

        if ( l_qty > 0 )
        then
          erm := '�� �������� ' || to_char(ND_) || ' ������������ ������������� �������!';
           raise err;
        end if;

      end;

      -- 3.����� ���� ����������, ������� ���� �� ����� ������, ����� ��������� ��������
      FOR k IN ( SELECT m.ref ref FROM mbd_k_r m, oper p
                  WHERE m.nd=ND_ AND m.ref=p.ref and p.ref<> Ref2_ AND p.sos>0
                  ORDER BY m.ref desc )
      LOOP

        p_back_dok(k.ref,5,null,par2_,par3_,1);

        update operw
           set value='RollOver. ����� �� ����'
         where ref=k.ref and tag='BACKR';

      END LOOP;

      -- 4. ���������� ����� KV1-��������
      -- 4.1 ������� ������ �� ������� ( �������� �� ����� ������ )
        if tipd_=1 then ref_:=Ref2_; else ref_:=Ref1_; end if;
        if Ref2_<>0 then   -- �������  �������� KV1, ���� �� ���� (����� ����� � ����)
           p_back_dok(ref_,5,null,par2_,par3_,1);
           update operw set value='RollOver. ����� �� ����' where ref=ref_ and tag='BACKR';
        end if;
      -- 4.2 ����� ������ �� ���� ��������
        if tipd_=1 then ref_:=Ref1_; else ref_:=Ref2_; end if;
         if Ref1_<>0 then -- ������� �������� KV1, ���� �� ���� (����� ����� � ����)
        p_back_dok(ref_,5,null,par2_,par3_,1);
           update operw set value='RollOver. ����� �� ����' where ref=ref_ and tag='BACKR';
         end if;
      -- SDate, WDate ��������. ������
      BEGIN      SELECT sdate, wdate INTO SDate_, WDate_ FROM cc_deal WHERE nd=ND_Old_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN        erm := '�� ����� ���� ��������. ������' ;        raise err;
      END;

      FOR k IN (SELECT acc FROM nd_acc WHERE nd=ND_)
      LOOP
        DELETE FROM int_ratn WHERE acc=k.ACC AND bdat>=Dat1_ AND bdat>SDate_ ;
        UPDATE accounts SET mdate=WDate_ WHERE acc=k.Acc
     and acc not in (select acc from mbd_k where nd<>ND_)   -- �� ���������� ����
     and ostc+ostb<>0;                                      -- ���� ���� ����������� 2 ������
                                                               -- ��� ��������� ������� �� �����
        UPDATE int_accn SET stp_dat=WDate_-1 WHERE acc=k.Acc ;
      END LOOP;
      DELETE FROM mbd_k_r WHERE nd=ND_;
      DELETE FROM mbd_k_r WHERE nd=ND_Old_ AND ref in (Ref1_,Ref2_);   -- ���� �� Ref1_,Ref2_ ����������� "������ ������"
      DELETE FROM nd_acc  WHERE nd=ND_;
      DELETE FROM cc_add  WHERE nd=ND_;
      DELETE FROM cc_prol WHERE nd=ND_;
      DELETE FROM cc_docs WHERE nd=ND_;
      DELETE FROM cc_deal WHERE nd=ND_;

    EXCEPTION  WHEN err THEN        raise_application_error(-(20000+ern),'\'||erm,TRUE);
               WHEN OTHERS THEN          raise_application_error(-(20000+ern),SQLERRM,TRUE);
    END del_Ro_deal;

    ------------------------------------------------------------------
    --    ������� ���������� ���������� �������
    --
    FUNCTION F_GetNazn(MaskId_ varchar2, ND_ number) return varchar2  IS
    Mask_   varchar2(250);
    n_      number;
    sStr_   varchar2(250);
    nLen_   number;
    sPar_   varchar2(10);
    sTmp_   varchar2(250);
    sNazn_  varchar2(250);
    SqlVal_ varchar2(2000);
    refcur SYS_REFCURSOR;
    acc_fi  number:=0;

    BEGIN
       begin
         execute immediate
                     'select   nvl(acc,0)
                        from   mbd_k_fi
                       where   ND='||ND_
                      into acc_fi;
         exception when no_data_found
                 then acc_fi:=0;
       end;

      if acc_fi<>0 then
         BEGIN  -- ����� ������������
           SELECT mask INTO Mask_ FROM mbk_mask WHERE upper(id)=upper('F'||MaskId_) ;
           EXCEPTION WHEN NO_DATA_FOUND THEN
           RETURN '' ;
         END;
      else
         BEGIN
           SELECT mask INTO Mask_ FROM mbk_mask WHERE upper(id)=upper(MaskId_) ;
           EXCEPTION WHEN NO_DATA_FOUND THEN
           RETURN '' ;
         END;
      end if;

      sNazn_ := Mask_ ;
      sStr_  := Mask_ ;
      n_     := InStr(sStr_,'#') ;

      WHILE n_ > 0 LOOP
        nLen_ := Length(sStr_);
        sStr_ := Substr(sStr_, n_+1, nLen_-n_) ;
        n_    := InStr(sStr_,'#') ;
        sPar_ := Substr(sStr_, 1, n_-1) ;
        sTmp_ := '';    -- ���� �� ����������  - ��������� ������ �����������
        BEGIN
          SELECT sqlval INTO SqlVal_ FROM mbk_descr WHERE id=sPar_ ;
          SqlVal_ := Replace(SqlVal_, ':ND', to_char(ND_)) ;
          OPEN refcur FOR SqlVal_ ;
          FETCH refcur INTO sTmp_;
          CLOSE refcur;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          sTmp_ := '' ;
        END;
        sNazn_ := Replace(sNazn_, '#'||sPar_||'#', sTmp_) ;
        sStr_  := sNazn_ ;
        n_     := InStr(sStr_,'#') ;
      END LOOP;

      RETURN sNazn_ ;

    END F_GetNazn;

    ----------------------------------------------------------------------
    --    ��������� ���������� ������ ���������� � �� �������� ��� ������ ������ ������
    procedure get_print_value (
      p_nd         number,
      p_tic_name   varchar2,
      p_vars   out varchar2,
      p_vals   out varchar2 )
    is
      l_sql    tickets_par.txt%type;
      l_value  varchar2(2000);
    begin

      for k in ( select b.par, b.txt
                   from ( select a.par, nvl(b.rep_prefix,'DEFAULT') rep_prefix
                            from ( select par from tickets_par
                                    where upper(rep_prefix) = upper(p_tic_name)
                                      and mod_code = 'MBK'
                                    union
                                   select par from tickets_par
                                    where upper(rep_prefix) = upper('DEFAULT')
                                      and mod_code = 'MBK' ) a, tickets_par b
                           where a.par = b.par(+)
                             and upper(b.rep_prefix(+)) = upper(p_tic_name) ) a, tickets_par b
                  where upper(a.rep_prefix) = upper(b.rep_prefix)
                    and a.par = b.par
                    and b.txt is not null )
      loop

         l_sql := replace( k.txt, ':ND', to_char(p_nd) ) ;
         execute immediate l_sql into l_value;
         p_vars := p_vars || k.par   || '~' ;
         p_vals := p_vals || l_value || '~' ;

      end loop;

    end get_print_value;

    ------------------------------------------------------------------
    --    ��������� ��������� ���������� � ������ � ����������
    --
    --
    procedure save_partner_trace(
        p_custCode   in cc_swtrace.rnk%type,
        p_currCode   in cc_swtrace.kv%type,
        p_swoBic     in cc_swtrace.swo_bic%type,
        p_swoAcc     in cc_swtrace.swo_acc%type,
        p_swoAlt     in cc_swtrace.swo_alt%type,
        p_intermb    in cc_swtrace.interm_b%type,
        p_field58d   in cc_swtrace.field_58d%type,
        p_nls        in cc_swtrace.nls%type )
    is
    begin

        update cc_swtrace
           set swo_bic   = p_swoBic,
               swo_acc   = p_swoAcc,
               swo_alt   = p_swoAlt,
               interm_b  = p_intermb,
               field_58d = p_field58d,
               nls       = p_nls
         where rnk = p_custCode
           and kv = p_currCode;

        if sql%rowcount = 0 then

            insert into cc_swtrace (rnk, kv, swo_bic, swo_acc, swo_alt, interm_b, field_58d, nls)
            values (p_custCode, p_currCode, p_swoBic, p_swoAcc, p_swoAlt, p_intermb, p_field58d, p_nls);

        end if;

    end save_partner_trace;

    ----------------------------------------------------------------------
    --    ��������� ������� ������ ���
    --
    procedure unlink_dcp(p_nd number)
    is
      l_pawn  varchar2(30);
    begin

      select substr(trim(n.txt),1,30) into l_pawn
        from nd_txt n, cc_pawn c
       where n.nd = p_nd and n.tag = 'PAWN'
         and substr(trim(n.txt),1,30) = to_char(c.pawn) and c.code = 'DCP';

      update dcp_p set ref = null, acc = null where ref = - p_nd;

      delete from nd_txt where nd = p_nd and tag = 'PAWN';

    exception when no_data_found then null;
    end unlink_dcp;

    ----------------------------------------------------------------------
    --    ��������� �������� ���������
    --
    procedure link_deal (p_nd number, p_ndi number)
    is
    begin
      update cc_deal set ndi = p_ndi where nd = p_nd;
    end link_deal;

/*    ----------------------------------------------------------------------
    --    ��������� �������� ��������� � ��������
    --
    procedure link_nd_ref (p_nd number, p_ref number)
    is
    begin
        insert into mbd_k_r (nd, ref) values (p_nd, p_ref);
    exception when dup_val_on_index then null;
    end link_nd_ref;
*//*
    ------------------------------------------------------------------
    --    ��������� �������� ���������� � ���������
    --
    procedure link_docs (p_dat date)
    is
    begin
      -- �������� ��������
      for z in ( select nd, b_acc from mbk_deal )
      loop
         -- �������� ��������� �� ��������:
         -- 1) ���. �� ���.%%
         for d in ( select unique o.ref
                      from opldok o
                     where o.acc  = z.b_acc
                       and o.fdat = p_dat
                       and not exists (select 1 from mbd_k_r where nd = z.nd and ref = o.ref) )
         loop
            link_nd_ref(z.nd, d.ref);
         end loop;
         -- 1) ���. �� �������
         for d in ( select unique o.ref
                      from nd_acc n, opldok o
                     where n.nd   = z.nd
                       and n.acc  = o.acc
                       and o.fdat = p_dat
                       and o.tt   = 'ZAL'
                       and not exists (select 1 from mbd_k_r where nd = z.nd and ref = o.ref) )
         loop
            link_nd_ref(z.nd, d.ref);
         end loop;
      end loop;
    end link_docs;
*/
    function get_deal_param (
      p_nd    nd_txt.nd%type,
      p_tag   nd_txt.tag%type) return varchar2
    is
      l_val   nd_txt.txt%type;
    begin
      begin
         select txt into l_val from nd_txt where nd = p_nd and tag = p_tag;
      exception when no_data_found then l_val := null;
      end;
      return l_val;
    end;
    procedure set_deal_param
    ( p_nd    nd_txt.nd%type,
      p_tag   nd_txt.tag%type,
      p_val   nd_txt.txt%type
    ) is
    begin

      if p_val is not null
      then

          update nd_txt
             set txt = p_val
           where nd  = p_nd
             and tag = p_tag;

          if ( sql%rowcount = 0 )
          then
            insert into nd_txt(nd, tag, txt)
            values ( p_nd, p_tag, p_val );
          end if;

      else
        delete from nd_txt
         where nd = p_nd and tag = p_tag;
      end if;

    end;

    function estimate_interest_amount(
        p_product_id in integer,
        p_deal_start_date in date,
        p_deal_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_base in number,
        p_interest_rate in number)
    return number
    is
        l_account_rest_type integer;
        l_date_from date := p_deal_start_date;
        l_date_through date := p_deal_expiry_date - 1; -- � ������� ���� ����� ������� �� �������������, � ��� ���� ����� ��� �� ������ (���� ���������� ��� ����� �����)
    begin
        bars_audit.trace('mbk.estimate_interest_amount' || chr(10) ||
                            'p_product_id       : ' || p_product_id       || chr(10) ||
                            'p_deal_start_date  : ' || p_deal_start_date  || chr(10) ||
                            'p_deal_expiry_date : ' || p_deal_expiry_date || chr(10) ||
                            'p_amount           : ' || p_amount           || chr(10) ||
                            'p_currency_id      : ' || p_currency_id      || chr(10) ||
                            'p_interest_base    : ' || p_interest_base    || chr(10) ||
                            'p_interest_rate    : ' || p_interest_rate);

        l_account_rest_type := get_acc_rest_type_for_interest(p_product_id);

        if (l_account_rest_type = interest_utl.BALANCE_KIND_BANK_DATE_IN) then
            l_date_from := l_date_from + 1;
        end if;

        return currency_utl.from_fractional_units(
                   round(calp_nr(currency_utl.to_fractional_units(p_amount, p_currency_id),
                           p_interest_rate,
                           l_date_from,
                           l_date_through,
                           p_interest_base), 0),
                   p_currency_id);
    end;

    procedure prepare_portfolio_interest(
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_date_to in date)
    is
        l_products number_list;
        l_partners number_list;
        l_currencies number_list;
        l_mismatch_list number_list;
        l_deals number_list;
        l_date_to date := case when p_date_to is null then least(bankdate(), trunc(sysdate)) - 1 else p_date_to end;
    begin
        bars_audit.info('mbk.prepare_portfolio_interest' || chr(10) ||
                         'p_product_id  : ' || p_product_id || chr(10) ||
                         'p_partner_id  : ' || p_partner_id || chr(10) ||
                         'p_currency_id : ' || p_currency_id || chr(10) ||
                         'p_date_to     : ' || p_date_to);

        l_products := tools.string_to_number_list(p_product_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_partners := tools.string_to_number_list(p_partner_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_currencies := tools.string_to_number_list(p_currency_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');

        if (l_partners is not null) then
            select t.column_value
            bulk collect into l_mismatch_list
            from   table(l_partners) t
            where  not exists (select 1
                               from   customer c
                               where  c.rnk = t.column_value and
                                      c.date_off is null);

            if (l_mismatch_list is not empty) then
                raise_application_error(-20000, '�볺�� � ��������������� {' ||
                                                tools.number_list_to_string(l_mismatch_list, p_splitting_symbol => ', ', p_ceiling_length => 100) ||
                                                '} �� ���� ��� ��������');
            end if;
        end if;

        select d.nd
        bulk collect into l_deals
        from   cc_deal d
        join   cc_add dd on dd.nd = d.nd
        where  check_if_deal_belong_to_mbdk(d.vidd) = 'Y' and
               (l_products is null or l_products is empty or d.vidd in (select column_value from table(l_products))) and
               (l_partners is null or l_partners is empty or d.rnk in (select column_value from table(l_partners))) and
               (l_currencies is null or l_currencies is empty or dd.kv in (select column_value from table(l_currencies))) and
               d.sos <> 15;

        tools.hide_hint(interest_utl.prepare_deal_interest(l_deals, l_date_to));
    end;

    procedure prepare_deal_interest(
        p_deal_id in integer,
        p_date_to in date)
    is
        l_cc_deal_row cc_deal%rowtype;
        l_cc_add_row cc_add%rowtype;
        l_date_to date := case when p_date_to is null then least(bankdate(), trunc(sysdate)) - 1 else p_date_to end;
    begin
        bars_audit.trace('mbk.prepare_deal_interest' || chr(10) ||
                         'p_deal_id : ' || p_deal_id || chr(10) ||
                         'p_date_to : ' || p_date_to);

        l_cc_deal_row := cck_utl.read_cc_deal(p_deal_id, p_lock => true);
        l_cc_add_row := cck_utl.read_cc_add(p_deal_id, p_lock => true);

        if (check_if_deal_belong_to_mbdk(l_cc_deal_row.vidd) = 'N') then
            raise_application_error(-20000, '����� ' || l_cc_deal_row.cc_id ||
                                            ' �� ' || to_char(l_cc_deal_row.sdate, 'dd.mm.yyyy') ||
                                            ' �� �������� �� ���� ����');
        end if;

        if (l_cc_deal_row.sos = 15) then
            raise_application_error(-20000, '����� ' || l_cc_deal_row.cc_id ||
                                            ' �� ' || to_char(l_cc_deal_row.sdate, 'dd.mm.yyyy') ||
                                            ' �������');
        end if;

        if (l_date_to < l_cc_add_row.bdate) then
            raise_application_error(-20000, '���� ���������� ������ ����������� ������� {' || to_char(l_date_to, 'dd.mm.yyyy') ||
                                            '} �� ���� ���� ������� �� ���� ������� 䳿 ����� {' || to_char(l_cc_add_row.bdate, 'dd.mm.yyyy') || '}');
        end if;

        tools.hide_hint(interest_utl.prepare_deal_interest(number_list(p_deal_id), l_date_to));
    end;

    procedure pay_accrued_interest
    is
    begin
        bars_audit.trace('mbk.pay_accrued_interest' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id'));

        interest_utl.pay_accrued_interest(p_do_not_store_interest_tails => true);
    end;

    procedure pay_selected_interest(
        p_id in integer)
    is
        l_int_reckoning_row int_reckoning%rowtype;
    begin
        bars_audit.trace('mbk.pay_selected_interest' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id') || chr(10) ||
                         'p_id : ' || p_id);

        l_int_reckoning_row := interest_utl.lock_reckoning_row(p_id, p_skip_locked => true);

        if (l_int_reckoning_row.id is not null) then
            interest_utl.pay_int_reckoning_row(l_int_reckoning_row, p_silent_mode => true, p_do_not_store_interest_tails => true);
        end if;
    end;

    procedure remove_selected_reckoning(
        p_id in integer)
    is
    begin
        bars_audit.trace('mbk.remove_selected_reckoning' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id') || chr(10) ||
                         'p_id : ' || p_id);

        interest_utl.remove_reckoning(p_id);
    end;

    procedure edit_selected_reckoning(
        p_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2)
    is
        l_int_reckoning_row int_reckoning%rowtype;
        l_account_row accounts%rowtype;
    begin
        bars_audit.trace('mbk.remove_selected_reckoning' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id') || chr(10) ||
                         'p_id                                    : ' || p_id || chr(10) ||
                         'p_interest_amount                       : ' || p_interest_amount || chr(10) ||
                         'p_purpose                               : ' || p_purpose);

        l_int_reckoning_row := interest_utl.lock_reckoning_row(p_id, p_skip_locked => false);
        l_account_row := account_utl.read_account(l_int_reckoning_row.account_id);

        interest_utl.edit_reckoning_row(p_id, currency_utl.to_fractional_units(p_interest_amount, l_account_row.kv), p_purpose);
    end;
/*
    function make_kv1(
        p_deal_id in integer,
        p_value_date in date,
        p_amount in number,
        p_purpose in varchar2)
    return varchar2
    is
        l_ref integer;
        l_deal_row cc_deal%rowtype;
        l_cc_add_row cc_add%rowtype;
        l_account_row accounts%rowtype;
        l_customer_row customer%rowtype;
        l_custbank_row custbank%rowtype;
    begin
        bars_audit.info('mbk.make_kv1' || chr(10) ||
                        'p_deal_id    : ' || p_deal_id || chr(10) ||
                        'p_value_date : ' || p_value_date || chr(10) ||
                        'p_amount     : ' || p_amount || chr(10) ||
                        'p_purpose    : ' || p_purpose);
\*
        gl.ref(l_ref);
        gl.in_doc3(l_ref,
                   tt_ => 'KV1',
                   vob_ => 6,
                   nd_ => null,
                   pdat_ => sysdate,
                   vdat_ => p_value_date,
                   dk_ => 1,
                   kv_ => l_cc_add_row.kv,
                   s_ => p_amount,
                   kv2_ => l_cc_add_row.kv,
                   s2_ => p_amount,
                   sk_ => null,
                   data_ => );*\


\*
Call cDoc.SetDoc(nRef, 'KV1', 1, nVob, sNd,
     GetBankDate(), GetBankDate(), DAT_VAL, DAT_VAL,
     DB_1819, NamA,    GetBankMfo(), '', KV, Sum_Deb*SalNumberPower(10,nDig), GetBankOkpoS(),
     nls,     sKlient, GetBankMfo(), '', KV, Sum_Deb*SalNumberPower(10,nDig), OkpoB,
     dfNazn, '', GetIdOper(), '', NUMBER_Null, 0)

DB_1819:
SELECT a.nls, a.ostc/power(10,:nDig) INTO :sDB_1819, :ost_DB_1819
   FROM exchange_of_resources r, accounts a
  WHERE r.mfo = :MFOB
    and r.nls_cck_source = a.nls and a.kv=:nKv
*\\*
        l_deal_row := cck_utl.read_cc_deal(p_deal_id\*, p_lock => true*\);
        l_cc_add_row := cck_utl.read_cc_add(p_deal_id);
        l_account_row := account_utl.read_account(l_cc_add_row.accs);
        l_customer_row := customer_utl.read_customer(l_deal_row.rnk);
        l_custbank_row := customer_utl.read_customer_bank(l_deal_row.rnk);

        return make_docinput_url('WD1',
                                 '��������',    -- 'DisR', '1',
                                 'Kv_A' , l_account_row.kv,
                                 'Nls_A', l_account_row.nls,
                                 'Mfo_b', l_cc_add_row.mfokred,
                                 'Nls_B', l_cc_add_row.acckred,
                                 'Id_B' , l_customer_row.okpo,
                                 'Nam_B', substr(l_customer_row.nmk, 1, 38),
                                 'SumC_t', p_amount,
                                 'Nazn' , p_purpose,
                                 'reqv_KOD_G', l_customer_row.country,
                                 'reqv_KOD_B', l_custbank_row.kod_b,
                                 'reqv_KOD_N', l_kodN  ,
                                 'reqv_56A', da1.INTERM_B,
                                 'reqv_57A', l_57 ,
                                 'reqv_58A', l_58 ,
                                 'reqv_72' , l_72 , 'Vob',oo1.vob,'flag_se',1,
                                 'APROC', 'begin null; end;@mbk.link_nd_ref(' || p_deal_id || ', gl.aRef); ');*\

        return '/barsroot/docinput/docinput.aspx?tt=KV1'||chr(38)||'DatV='||chr(38)||'Kv_A=840'||chr(38)||'Nls_A=37397005523'||chr(38)||'Id_A=00032129'||chr(38)||'Nam_B=%D0%A2%D1%80%D0%B0%D0%BD%D0%B7%' ||
               'D0%B8%D1%82%20%D0%BF%D0%BE%20%D0%9C%D0%91%D0%94%D0%9A'||chr(38)||'Dk=1'||chr(38)||'Mfo_b=300465'||chr(38)||'Nls_B=13276220002000'||chr(38)||'Id_B=1234567890'||chr(38)||'Nam_B=%D0%9A%D0' ||
               '%BB%D1%96%D1%94%D0%BD%D1%82%20RNK=20002001'||chr(38)||'SumC_t=3223500'||chr(38)||'Nazn=%D0%97%D0%B0%D0%BB%D1%83%D1%87%D0%B5%D0%BD%D0%BD%D1%8F%20%D0%' ||
               '97%D0%B0%D0%BB.%20%D0%93%D0%B5%D0%BD.%D1%83%D0%B3%D0%BE%D0%B4%D0%B0%20200020%20%D0%9A%D0%BB%D1%96%D1%94%D0%BD%D1%82%20RNK=20' ||
               '002001%20%D0%94%D0%BE%D0%B3%D0%BE%D0%B2i%D1%80%20565464654%20%D0%B2i%D0%B4%2012/10/2016'||chr(38)||'APROC=begin%20null;%20end;@mbk.link_' ||
               'nd_ref(14402774768,%20gl.aRef)';
    end;
*/
    function get_sending_transaction_code(
        p_deal_kind_id in integer,
        p_debit_account in varchar2,
        p_interest_account_number in varchar2)
    return varchar2
    is
    begin
        return case when (p_debit_account = p_interest_account_number and p_deal_kind_id > 1600) then '8444018' -- % �� ���
                    when (p_deal_kind_id = 1510)                           then '8444013' -- ����i����� ��������-�������� � �����-�����
                    when (p_deal_kind_id > 1510 and p_deal_kind_id < 1515) then '8444005' -- ����i����� ��� � �����-��������i
                    when (p_deal_kind_id = 1521)                           then '8444009' -- ������� �������-�������� �����-���������
                    when (p_deal_kind_id > 1521 and p_deal_kind_id < 1525) then '8444001' -- ������� ��� �����-���������
                    when (p_deal_kind_id = 1610)                           then '8444016' -- ���������� ��������-�������� �� �����-����
                    when (p_deal_kind_id > 1610 and p_deal_kind_id < 1615) then '8444008' -- ���������� ��� �� �����-���������
                    when (p_deal_kind_id = 1621)                           then '8444012' -- ���������� �������-�������� �� �����-�����
                    when (p_deal_kind_id > 1621 and p_deal_kind_id < 1625) then '8444004' -- ���������� ��� �� �����-���������
                    else null
               end;
    end;

    function get_receiving_transaction_code(
        p_deal_kind_id in integer,
        p_debit_account in varchar2,
        p_interest_account_number in varchar2)
    return varchar2
    is
    begin
        return case when (p_debit_account = p_interest_account_number and p_deal_kind_id < 1600) then '8444017' -- % �� ���
                    when (p_deal_kind_id = 1510)                           then '8444014' -- ���������� ��������-�������� �i� �����-���
                    when (p_deal_kind_id > 1510 and p_deal_kind_id < 1515) then '8444006' -- ���������� ��� �i� �����-���������
                    when (p_deal_kind_id = 1521)                           then '8444010' -- ���������� �������-�������� �i� �����-����
                    when (p_deal_kind_id > 1521 and p_deal_kind_id < 1525) then '8444002' -- ���������� ��� �i� �����-���������
                    when (p_deal_kind_id = 1610)                           then '8444015' -- ��������� ��������-�������� �i� �����-����
                    when (p_deal_kind_id > 1610 and p_deal_kind_id < 1615) then '8444007' -- ��������� ��� �i� �����-���������
                    when (p_deal_kind_id = 1621)                           then '8444011' -- ��������� �������-�������� �i� �����-�����
                    when (p_deal_kind_id > 1621 and p_deal_kind_id < 1625) then '8444003' -- ��������� ��� �i� �����-���������
                    else null
               end;
    end;

    function read_document(
        p_document_id in integer,
        p_raise_ndf in boolean default true)
    return oper%rowtype
    is
        l_document_row oper%rowtype;
    begin
        select *
        into   l_document_row
        from   oper t
        where  t.ref = p_document_id;

        return l_document_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '�������� � ��������������� {' || p_document_id || '} �� ���������');
             else return null;
             end if;
    end;

    procedure open_awaiting_amount(
        p_deal_id in integer,
        p_document_id in integer,
        p_main_amount_flag in char)
    is
        l_document_row oper%rowtype;
        l_awaiting_amount number;
    begin
        l_document_row := read_document(p_document_id);

        if (p_main_amount_flag = 'Y') then
            l_awaiting_amount := nvl(attribute_utl.get_number_value(p_deal_id, mbk.ATTR_AWAITING_MAIN_AMOUNT), 0);
            l_awaiting_amount := l_awaiting_amount + l_document_row.s2;
            attribute_utl.set_value(p_deal_id, mbk.ATTR_AWAITING_MAIN_AMOUNT, l_awaiting_amount);
        else
            l_awaiting_amount := nvl(attribute_utl.get_number_value(p_deal_id, mbk.ATTR_AWAITING_INTEREST_AMOUNT), 0);
            l_awaiting_amount := l_awaiting_amount + l_document_row.s2;
            attribute_utl.set_value(p_deal_id, mbk.ATTR_AWAITING_INTEREST_AMOUNT, l_awaiting_amount);
        end if;

        cck_utl.link_document_to_deal(p_deal_id, l_document_row.ref);
    end;

    procedure close_awaiting_amount(
        p_deal_id in integer,
        p_document_id in integer,
        p_main_amount_flag in char)
    is
        l_document_row oper%rowtype;
        l_awaiting_amount number;
    begin
        l_document_row := read_document(p_document_id);

        if (p_main_amount_flag = 'Y') then
            l_awaiting_amount := attribute_utl.get_number_value(p_deal_id, mbk.ATTR_AWAITING_MAIN_AMOUNT);
            if (l_awaiting_amount is not null) then
                l_awaiting_amount := greatest(l_awaiting_amount - l_document_row.s, 0);
                attribute_utl.set_value(p_deal_id, mbk.ATTR_AWAITING_MAIN_AMOUNT, l_awaiting_amount);
            end if;
        else
            l_awaiting_amount := attribute_utl.get_number_value(p_deal_id, mbk.ATTR_AWAITING_INTEREST_AMOUNT);
            if (l_awaiting_amount is not null) then
                l_awaiting_amount := greatest(l_awaiting_amount - l_document_row.s, 0);
                attribute_utl.set_value(p_deal_id, mbk.ATTR_AWAITING_INTEREST_AMOUNT, l_awaiting_amount);
            end if;
        end if;

        cck_utl.link_document_to_deal(p_deal_id, l_document_row.ref);
    end;

    function make_docinput(
        p_nd in integer)
    return cdb_mediator.t_make_document_urls
    pipelined
    is
        l_operation_item cdb_mediator.t_make_document_url;

        l_cc_deal_row              cc_deal%rowtype;
        l_cc_add_row               cc_add%rowtype;
        l_cc_vidd_row              cc_vidd%rowtype;
        l_main_account_row         accounts%rowtype;
        l_customer_row             customer%rowtype;
        l_int_accn_row             int_accn%rowtype;
        l_interest_account_row     accounts%rowtype;
        l_transit_account_row      accounts%rowtype;
        l_customer_bank_row        custbank%rowtype;

        l_deal_amount              number; -- ���� ����� ��������� �� �����/������ � �.�. ��� ��������� � ��������� �������
        l_document_amount          number;
        l_additional_requisites    varchar2(32767 byte);

        l_72 varchar2 (250);
        l_58 varchar2 (250);
        l_57 varchar2 (250);
        l_transaction_code varchar2(8);

        l_transit_account_number varchar2(15) := '37397005523';
        l_money_format varchar2(30 char) := 'FM999999999999999990.00';
    begin
        l_cc_deal_row := cck_utl.read_cc_deal(p_nd);
        l_cc_add_row := cck_utl.read_cc_add(p_nd, p_application_id => 0);
        l_main_account_row := account_utl.read_account(l_cc_add_row.accs);
        l_int_accn_row := interest_utl.read_int_accn(l_main_account_row.acc, l_main_account_row.pap - 1);
        l_interest_account_row := account_utl.read_account(l_int_accn_row.acra);
        l_cc_vidd_row := cck_utl.read_cc_vidd(l_cc_deal_row.vidd);
        l_customer_row := customer_utl.read_customer(l_cc_deal_row.rnk);
        l_customer_bank_row := customer_utl.read_customer_bank(l_cc_deal_row.rnk, p_raise_ndf => false);

        l_deal_amount := currency_utl.to_fractional_units(l_cc_add_row.s, l_cc_add_row.kv);

        -- ���������
        if (l_cc_vidd_row.tipd = 1) then

            -- ��������� ������� ����
            l_operation_item := null;
            -- ��'����� ������� ������� �������� �� �������� ���� �����, �.�. �������� ��������, �� ��� ���� ����� �������� ������� �������, � �� ��� ����� �������� ���������
            l_document_amount := greatest(l_deal_amount + l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := '��������� ������� ����';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_cc_add_row.kv;

            If (l_document_amount > 0 and          -- �������� ������� �� ������� ��������� ���� (�� ����������� ����������� �������) ������� �� ���� �����
                l_cc_deal_row.wdate > gl.bd() and  -- ����� �� ����������
                l_cc_add_row.wdate <= gl.bd() and  -- ���� ������� �������
                l_cc_deal_row.vidd <> 1526) then   -- ���������� "��������������� ������� �� ���������"

                l_operation_item.purpose := 'г����� �� ����� ����� ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' �� �������� �������� ������� ' ||
                                            to_char(currency_utl.from_fractional_units(abs(l_main_account_row.ostb), l_main_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                             ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>��������� ��������� �� ���� ������';

                if (l_main_account_row.kv = gl.baseval) then
                    begin
                        select '''#d' || mdoa || mdob || id_ug || to_char(dat_ug, 'yyyymmdd') || ozn_sp || '#'''
                        into   l_additional_requisites
                        from   dcp_p
                        where  ref = l_cc_deal_row.nd;
                    exception
                        when no_data_found then
                             l_additional_requisites := null;
                    end;

                    l_operation_item.url := make_docinput_url('KV2',
                                                              '��������',
                                                              'vob', 1, -- ��������� ����� �������� ����� ���
                                                              'nls_a', l_main_account_row.nls,
                                                              'nls_b', l_cc_add_row.acckred,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_a', gl.aMFO,
                                                              'mfo_b', l_cc_add_row.mfokred,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('RO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_�', l_additional_requisites,
                                                              'flag_se', '1',
                                                              -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal('||l_cc_deal_row.nd||', gl.aref);');
                else
                    l_transaction_code := get_sending_transaction_code(l_cc_deal_row.vidd, l_main_account_row.nls, l_interest_account_row.nls);

                    -- Field 72: Sender to Receiver Information
                    --
                    -- FORMAT
                    -- 6*35x (Narrative Structured Format)
                    -- The following line formats must be used:
                    -- Line 1 /8c/[additional information] (Code)(Narrative)
                    -- Lines 2-6 [//continuation of additional information]
                    -- or
                    -- [/8c/[additional information]]
                    -- (Narrative)
                    -- or
                    -- (Code)(Narrative)

                    if (length('/BNF/LEND RE AGR NO.' || l_cc_deal_row.cc_id) > 35) then
                        l_72  := '/BNF/LEND RE AGR NO.' || tools.crlf ||
                                 '//' || l_cc_deal_row.cc_id || tools.crlf ||
                                 '//DD.' || to_char(l_cc_deal_row.sdate,'dd.mm.yyyy');
                    else
                        l_72  := '/BNF/LEND RE AGR NO.' || l_cc_deal_row.cc_id || tools.crlf ||
                                 '//DD.' || to_char(l_cc_deal_row.sdate,'dd.mm.yyyy');
                    end if;

                    If (l_main_account_row.kv <> 643) then
                        l_58 := case when l_cc_add_row.acckred is null then ''
                                     else '/' || l_cc_add_row.acckred || tools.crlf
                                end ||
                                customer_utl.get_customer_bic(l_cc_deal_row.rnk);
                        l_57 := case when l_cc_add_row.swo_acc is null then ''
                                     else '/' || l_cc_add_row.swo_acc || tools.crlf || l_cc_add_row.swo_bic
                                end;
                    else
                        l_58 := l_cc_add_row.field_58d;
                        l_57 := l_cc_add_row.alt_partyb;
                    end if;

                    l_operation_item.url := make_docinput_url('KV3',
                                                              '��������',
                                                              'vob', 6, -- ��������� ������ ������ ����� ���������� ������� ����������� �������
                                                              'nls_a', l_main_account_row.nls,
                                                              'nls_b', l_cc_add_row.acckred,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_b', l_cc_add_row.mfokred,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('RO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_kod_g', l_customer_row.country,
                                                              'reqv_kod_b', l_customer_bank_row.kod_b,
                                                              'reqv_kod_n', l_transaction_code,
                                                              'reqv_56a', l_cc_add_row.interm_b,
                                                              'reqv_57a', l_57,
                                                              'reqv_58a', l_58,
                                                              'reqv_72', l_72,
                                                              'flag_se', 1,
                                                              -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal(' || l_cc_deal_row.nd || ', gl.aref);');
                end if;
            else
                l_operation_item.purpose := '���� ����� ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' ������ ��� ������� ��������� ������� ������� ' ||
                                            to_char(currency_utl.from_fractional_units(abs(l_main_account_row.ostb), l_main_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>���� ������� � �������� �����';
            end if;

            pipe row (l_operation_item);

            -- ��������� ��������� ������� ���� (��������� ���������� �������������)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_main_account_row.kv);
            l_document_amount := greatest(-l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := '��������� ������� ���� (��������� ���������� �������������)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := '��������� ���� ����� �������� - �������� ������� ������� ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>���� ���� �������� ��������� ������� ����';
                l_operation_item.url := make_docinput_url('KV1',
                                                          '��������',
                                                          'dk', '1',
                                                          'nls_a', l_transit_account_row.nls,
                                                          'nls_b', l_main_account_row.nls,
                                                          'nam_a', substr(l_transit_account_row.nms, 1, 38),
                                                          'nam_b', substr(l_main_account_row.nms, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'kv_a', l_main_account_row.kv,
                                                          'nazn', substr(f_getnazn('RP', l_cc_deal_row.nd), 1, 160),
                                                          'flag_se', '1',
                                                          -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                          'APROC', 'begin null; end;@mbk.open_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');');

            else
                l_operation_item.purpose := '���� ��������� ����� ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>���� ������� � �������� ������� ����';
            end if;

            pipe row (l_operation_item);

            -- ��������� ��������� ������� (��������� ���������� �������������)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_interest_account_row.kv);
            l_document_amount := greatest(-l_interest_account_row.ostb, 0);

            l_operation_item.operation_type_name := '��������� ������� (��������� ���������� �������������)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := '���� ����������� ������� ������ ' ||
                                            to_char(currency_utl.from_fractional_units(-l_interest_account_row.ostb, l_interest_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>������� �� ��������� ���� ����';

                l_operation_item.url := make_docinput_url('KV1',
                                                          '��������',
                                                          'dk', '1',
                                                          'nls_a', l_transit_account_row.nls,
                                                          'nls_b', l_interest_account_row.nls,
                                                          'nam_a', substr(l_transit_account_row.nms, 1, 38),
                                                          'nam_b', substr(l_interest_account_row.nms, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'kv_a', l_interest_account_row.kv,
                                                          'nazn', substr(f_getnazn('RPP', l_cc_deal_row.nd), 1, 160),
                                                          'flag_se', '1',
                                                          -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                          'APROC', 'begin null; end;@mbk.open_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''N'');');

            else
                l_operation_item.purpose := '���� ����������� ������� ������ ' ||
                                             to_char(currency_utl.from_fractional_units(l_operation_item.amount, l_interest_account_row.kv), l_money_format) ||
                                             ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                             '<br>���� ������� � �������� �������';
            end if;

            pipe row (l_operation_item);

            -- �������� ���������� ������������� (������� ����)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_main_account_row.kv);
            l_document_amount := nvl(attribute_utl.get_number_value(l_cc_deal_row.nd, mbk.ATTR_AWAITING_MAIN_AMOUNT), 0);

            l_operation_item.operation_type_name := '�������� ���������� ������������� (������� ����)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := '�������� ���������� ������������� �� ���� ' || to_char(l_operation_item.amount, l_money_format) || ' ' ||
                                            currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>��������� �������� ���������� �������������';
                l_operation_item.url := make_docinput_url('WD1',
                                                          '��������',
                                                          'dk', 1,
                                                          'nls_a', l_cc_add_row.refp,
                                                          'nls_b', l_transit_account_row.nls,
                                                          'kv_a' , l_main_account_row.kv,
                                                          'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'id_b', l_customer_row.okpo,
                                                          'nazn' , substr(f_getnazn('RP', l_cc_deal_row.nd), 1, 160),
                                                          'reqv_kod_g', l_customer_row.country,
                                                          'reqv_kod_b', l_customer_bank_row.kod_b,
                                                          'reqv_kod_n', get_receiving_transaction_code(l_cc_deal_row.vidd, l_cc_add_row.refp, l_interest_account_row.nls),
                                                          'flag_se', 1,
                                                          -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                          'APROC', 'begin null; end;@mbk.close_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');' );
            else
                l_operation_item.purpose := '���������� ������������� �� ������� ��� �� ��������<br>���� ������� � ������� ���������� �������������';
            end if;

            pipe row (l_operation_item);

            -- �������� ���������� ������������� (���� �������)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_interest_account_row.kv);
            l_document_amount := nvl(attribute_utl.get_number_value(l_cc_deal_row.nd, mbk.ATTR_AWAITING_INTEREST_AMOUNT), 0);

            l_operation_item.operation_type_name := '�������� ���������� ������������� (���� �������)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := '�������� ���������� ������������� �� ��������� �� ���� ' || to_char(l_operation_item.amount, l_money_format) || ' ' ||
                                            currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>��������� �������� ���������� �������������';
                l_operation_item.url := make_docinput_url('WD1',
                                                          '��������',
                                                          'dk', 1,
                                                          'nls_a', l_cc_add_row.refp,
                                                          'nls_b', l_transit_account_row.nls,
                                                          'kv_a' , l_interest_account_row.kv,
                                                          'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'id_b', l_customer_row.okpo,
                                                          'nazn' , substr(f_getnazn('RPP', l_cc_deal_row.nd), 1, 160),
                                                          'reqv_kod_g', l_customer_row.country,
                                                          'reqv_kod_b', l_customer_bank_row.kod_b,
                                                          'reqv_kod_n', get_receiving_transaction_code(l_cc_deal_row.vidd, l_cc_add_row.refp, l_interest_account_row.nls),
                                                          'flag_se', 1,
                                                          -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                          'APROC', 'begin null; end;@mbk.close_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''N'');' );
            else
                l_operation_item.purpose := '���������� ������������� ��� ���� ������� �� ��������<br>���� ������� � ������� ���������� �������������';
            end if;

            pipe row (l_operation_item);
        else
            -- ���������
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_main_account_row.kv);
            l_document_amount := l_deal_amount - greatest(l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := '��������� ������� ���� (�������� ���������� �������������)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0 and            -- �������� ������� ������� ������� �� ���� �����
                l_cc_deal_row.wdate > gl.bd() and    -- ����� �� ����������
                l_cc_add_row.wdate <= gl.bd()) then  -- ���� ������� �������


                l_operation_item.purpose := 'г����� �� ����� ����� ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' �� ������ �������� �������� ������� ' ||
                                            to_char(currency_utl.from_fractional_units(l_main_account_row.ostb, l_main_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                             ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>��������� ��������� �� ���� ������';

                l_operation_item.url := make_docinput_url('KV1',
                                                          '��������',
                                                          'dk', '1',
                                                          'nls_a', l_transit_account_row.nls,
                                                          'nls_b', l_main_account_row.nls,
                                                          'nam_a', substr(l_transit_account_row.nms, 1, 38),
                                                          'nam_b', substr(l_main_account_row.nms, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'kv_a', l_main_account_row.kv,
                                                          'nazn', substr(f_getnazn('PP', l_cc_deal_row.nd), 1, 160),
                                                          'flag_se', '1',
                                                          -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                          'APROC', 'begin null; end;@mbk.open_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');');

            else
                if (l_cc_deal_row.wdate <= gl.bd()) then
                    l_operation_item.purpose := '���� ���������� 䳿 ����� ' || to_char(l_cc_deal_row.wdate, 'dd.mm.yyyy') || ' ���������' ||
                                                '<br>��������� ����� ����������� �� ����';
                elsif (l_cc_add_row.wdate > gl.bd()) then
                    l_operation_item.purpose := '���� ������� 䳿 ����� ' || to_char(l_cc_deal_row.wdate, 'dd.mm.yyyy') || ' �� �� ���������' ||
                                                '<br>��������� ����� ����������� �� ����';
                elsif (l_document_amount <= 0) then
                    l_operation_item.purpose := '���� ����� ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_cc_add_row.kv) ||
                                                ' ������ ��� ������� ��������� ������� ������� ' ||
                                                to_char(currency_utl.from_fractional_units(l_main_account_row.ostb, l_main_account_row.kv), l_money_format) ||
                                                ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                                '<br>���� ������� � �������� �����';
                end if;
            end if;

            pipe row (l_operation_item);

            -- �������� ���������� ������������� (������� ����)
            l_operation_item := null;

            l_document_amount := nvl(attribute_utl.get_number_value(l_cc_deal_row.nd, mbk.ATTR_AWAITING_MAIN_AMOUNT), 0);

            l_operation_item.operation_type_name := '�������� ���������� �������������';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := '�������� ���������� ������������� �� ���� ' || to_char(l_operation_item.amount, l_money_format) || ' ' ||
                                            currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>��������� �������� ���������� �������������';
                l_operation_item.url := make_docinput_url('WD1',
                                                          '��������',
                                                          'dk', 1,
                                                          'nls_a', l_cc_add_row.refp,
                                                          'nls_b', l_transit_account_row.nls,
                                                          'kv_a' , l_main_account_row.kv,
                                                          'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'id_b', l_customer_row.okpo,
                                                          'nazn' , substr(f_getnazn('PP', l_cc_deal_row.nd), 1, 160),
                                                          'reqv_kod_g', l_customer_row.country,
                                                          'reqv_kod_b', l_customer_bank_row.kod_b,
                                                          'reqv_kod_n', get_receiving_transaction_code(l_cc_deal_row.vidd, l_cc_add_row.refp, l_interest_account_row.nls),
                                                          'flag_se', 1,
                                                          -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                          'APROC', 'begin null; end;@mbk.close_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');' );
            else
                l_operation_item.purpose := '���������� ������������� �� ������� ��� �� ��������<br>���� ������� � ������� ���������� �������������';
            end if;

            pipe row (l_operation_item);

            -- ���������� �������� ����
            l_operation_item := null;

            l_document_amount := greatest(l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := '���������� �������� ����';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := '�������� ������� ������� �������� ���� ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>���� ���� �������� ���������� ���� ���������';
                if (l_main_account_row.kv = gl.baseval) then
                    begin
                        select '''#d' || mdoa || mdob || id_ug || to_char(dat_ug, 'yyyymmdd') || ozn_sp || '#'''
                        into   l_additional_requisites
                        from   dcp_p
                        where  ref = l_cc_deal_row.nd;
                    exception
                        when no_data_found then
                             l_additional_requisites := null;
                    end;

                    l_operation_item.url := make_docinput_url('WD2',
                                                              '��������',
                                                              'vob', 1, -- ���������� ����� �������� ����� ���
                                                              'nls_a', l_main_account_row.nls,
                                                              'nls_b', l_cc_add_row.acckred,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_b', l_cc_add_row.mfokred,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('PO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_�', l_additional_requisites,
                                                              'flag_se', '1',
                                                              -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal('||l_cc_deal_row.nd||', gl.aref);');

                else
                    if (length('/BNF/RETURN FUNDS RE AGR NO.' || l_cc_deal_row.cc_id) > 35) then
                        l_72  := '/BNF/RETURN FUNDS RE AGR NO.' || tools.crlf ||
                                 '//' || l_cc_deal_row.cc_id || tools.crlf ||
                                 '//DD.' || to_char(l_cc_deal_row.sdate,'dd.mm.yyyy');
                    else
                        l_72  := '/BNF/RETURN FUNDS RE AGR NO.' || l_cc_deal_row.cc_id || tools.crlf ||
                                 '//DD.' || to_char(l_cc_deal_row.sdate,'dd.mm.yyyy');
                    end if;

                    If (l_main_account_row.kv <> 643) then
                        l_58 := case when l_cc_add_row.acckred is null then ''
                                     else '/' || l_cc_add_row.acckred || tools.crlf
                                end ||
                                customer_utl.get_customer_bic(l_cc_deal_row.rnk);
                        l_57 := case when l_cc_add_row.swo_acc is null then ''
                                     else '/' || l_cc_add_row.swo_acc || tools.crlf || l_cc_add_row.swo_bic
                                end;
                    else
                        l_58 := l_cc_add_row.field_58d;
                        l_57 := l_cc_add_row.alt_partyb;
                    end if;

                    l_operation_item.url := make_docinput_url('WD3',
                                                              '��������',
                                                              'vob', 6, -- �������� ������ ������ ����� ���������� ������� ����������� �������
                                                              'nls_a', l_main_account_row.nls,
                                                              'nls_b', l_cc_add_row.acckred,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_b', l_cc_add_row.mfokred,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('PO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_kod_g', l_customer_row.country,
                                                              'reqv_kod_b', l_customer_bank_row.kod_b,
                                                              'reqv_kod_n', get_sending_transaction_code(l_cc_deal_row.vidd, l_main_account_row.nls, l_interest_account_row.nls),
                                                              'reqv_56a', l_cc_add_row.interm_b,
                                                              'reqv_57a', l_57,
                                                              'reqv_58a', l_58,
                                                              'reqv_72', l_72,
                                                              'flag_se', 1,
                                                              -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal(' || l_cc_deal_row.nd || ', gl.aref);');
                end if;
            else
                l_operation_item.purpose := '���� ��������� ����� ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>���� ������� � �������� ������� ����';
            end if;

            pipe row (l_operation_item);

            -- ������� ����������� �������
            l_operation_item := null;

            l_document_amount := greatest(l_interest_account_row.ostb, 0);

            l_operation_item.operation_type_name := '������� ����������� �������';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := '���� ����������� ������� ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>���� ���� ���� ���� ��������� ���������';

                if (l_interest_account_row.kv = gl.baseval) then
                    begin
                        select '''#d' || mdoa || mdob || id_ug || to_char(dat_ug, 'yyyymmdd') || ozn_sp || '#'''
                        into   l_additional_requisites
                        from   dcp_p
                        where  ref = l_cc_deal_row.nd;
                    exception
                        when no_data_found then
                             l_additional_requisites := null;
                    end;

                    l_operation_item.url := make_docinput_url('WD2',
                                                              '��������',
                                                              'vob', 1, -- �������� ����� �������� ����� ���
                                                              'nls_a', l_interest_account_row.nls,
                                                              'nls_b', l_cc_add_row.accperc,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_b', l_cc_add_row.mfoperc,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('PPO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_�', l_additional_requisites,
                                                              'flag_se', '1',
                                                              -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal(' || l_cc_deal_row.nd || ', gl.aref);');

                else
                    if (length('/BNF/INTEREST RE AGR NO.' || l_cc_deal_row.cc_id) > 35) then
                        l_72  := '/BNF/INTEREST RE AGR NO.' || tools.crlf ||
                                 '//' || l_cc_deal_row.cc_id || tools.crlf ||
                                 '//DD.' || to_char(l_cc_deal_row.sdate,'dd.mm.yyyy');
                    else
                        l_72  := '/BNF/INTEREST RE AGR NO.' || l_cc_deal_row.cc_id || tools.crlf ||
                                 '//DD.' || to_char(l_cc_deal_row.sdate,'dd.mm.yyyy');
                    end if;

                    If (l_interest_account_row.kv <> 643) then
                        l_58 := case when l_cc_add_row.accperc is null then ''
                                     else '/' || l_cc_add_row.accperc || tools.crlf
                                end ||
                                customer_utl.get_customer_bic(l_cc_deal_row.rnk);
                        l_57 := case when l_cc_add_row.swo_acc is null then ''
                                     else '/' || l_cc_add_row.swo_acc || tools.crlf || l_cc_add_row.swo_bic
                                end;
                    else
                        l_58 := l_cc_add_row.field_58d;
                        l_57 := l_cc_add_row.alt_partyb;
                    end if;

                    l_operation_item.url := make_docinput_url('WD3',
                                                              '��������',
                                                              'vob', 6, -- �������� ������ ������ ����� ���������� ������� ����������� �������
                                                              'nls_a', l_interest_account_row.nls,
                                                              'nls_b', l_cc_add_row.accperc,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_b', l_cc_add_row.mfoperc,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('PPO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_kod_g', l_customer_row.country,
                                                              'reqv_kod_b', l_customer_bank_row.kod_b,
                                                              'reqv_kod_n', get_sending_transaction_code(l_cc_deal_row.vidd, l_interest_account_row.nls, l_interest_account_row.nls),
                                                              'reqv_56a', l_cc_add_row.interm_b,
                                                              'reqv_57a', l_57,
                                                              'reqv_58a', l_58,
                                                              'reqv_72', l_72,
                                                              'flag_se', 1,
                                                              -- ����'������ ������������ ��������� ������� ��� ����� ��������� � ����������, �� ����������� ���� ��������� ���������
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal(' || l_cc_deal_row.nd || ', gl.aref);');
                end if;
            else
                l_operation_item.purpose := '���� ����������� ������� ������ ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>���� ������� � �������� ������� ����';
            end if;

            pipe row (l_operation_item);
        end if;

        l_operation_item := null;
        l_operation_item.operation_type_name := '����������� �������';

        if (l_int_accn_row.acr_dat is null or l_int_accn_row.acr_dat < l_int_accn_row.stp_dat) then
            l_operation_item.purpose := '���� ���������� ����������� �������: <b>' || to_char(l_int_accn_row.acr_dat, 'dd.mm.yyyy') ||
                                        '</b><br>���� ���������� ����������� �������: <b>' || to_char(l_int_accn_row.stp_dat, 'dd.mm.yyyy');
            l_operation_item.url            := '<a href="'||
                                             '/barsroot/ndi/referencebook/GetRefBookData/?nsiTableId='|| bars_metabase.get_tabid('INT_HELP') ||chr(38)||'nsiFuncId=1'||
                                             '">�������� �����������</a>';
            pul.set_mas_ini('nd', l_cc_deal_row.nd, null);
        else
            l_operation_item.purpose := '���� ���������� ����������� �������: <b>' || to_char(l_int_accn_row.acr_dat, 'dd.mm.yyyy') ||
                                        '</b><br>���� ���������� ����������� �������: <b>' || to_char(l_int_accn_row.stp_dat, 'dd.mm.yyyy') ||
                                        '</b><br>³������ ��������� �� ���� ������';
        end if;

        pipe row (l_operation_item);
    end;

    procedure create_pawn_contract(
        p_deal_id in integer,
        p_pawn_kind_id in integer,
        p_pawn_contract_number in varchar2,
        p_registry_number in varchar2,
        p_start_date in date,
        p_expiry_date in date,
        p_pawn_currency_id in integer,
        p_pawn_amount in number,
        p_pawn_fair_value in number,
        p_pawn_location_id in integer,
        p_deposit_id in integer)
    is
        l_deal_row cc_deal%rowtype;
        l_cc_add_row cc_add%rowtype;
        l_customer_row customer%rowtype;
        l_account_row accounts%rowtype;
        l_cc_pawn_row cc_pawn%rowtype;
        l_dummy integer;
        l_account_number varchar2(30 char);
    begin
        l_deal_row := cck_utl.read_cc_deal(p_deal_id);
        l_cc_add_row := cck_utl.read_cc_add(p_deal_id);
        l_customer_row := customer_utl.read_customer(l_deal_row.rnk);

        l_cc_pawn_row := cck_utl.read_cc_pawn(p_pawn_kind_id);
        p_add_zal(p_nd     => l_deal_row.nd,
                  p_accs   => null, -- l_cc_add_row.accs,
                  p_rnk    => l_customer_row.rnk,
                  p_pawn   => p_pawn_kind_id,
                  p_acc    => null, -- l_account_row.acc,
                  p_kv     => l_cc_add_row.kv,
                  p_sv     => null, -- p_pawn_fair_value,
                  p_del    => p_pawn_amount,
                  p_cc_idz => p_pawn_contract_number,
                  p_sdatz  => p_start_date,
                  p_mdate  => p_expiry_date,
                  p_nree   => p_registry_number,
                  p_depid  => p_deposit_id,
                  p_mpawn  => p_pawn_location_id,
                  p_pr_12  => 1,
                  p_nazn   => '�������������� ������� ����� �������� � ' || p_pawn_contract_number || ' �� ' || to_char(p_start_date) ||
                              ' ��� ����� ' || l_deal_row.cc_id || ' �� ' || to_char(l_deal_row.sdate, 'dd.mm.yyyy'));
    end;

    procedure add_lim_sb(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_limit_amount in number,
        p_limit_date in date)
    is
        l_account_row accounts%rowtype;
    begin
        bars_audit.trace('mbk.add_lim_sb' || chr(10) ||
                         'p_account_number : ' || p_account_number || chr(10) ||
                         'p_currency_id    : ' || p_currency_id    || chr(10) ||
                         'p_limit_amount   : ' || p_limit_amount   || chr(10) ||
                         'p_limit_date     : ' || p_limit_date);

        l_account_row := account_utl.read_account(p_account_number, p_currency_id);
        begin
            insert into otcn_lim_sb
            values (l_account_row.acc, p_limit_date, p_limit_amount, sys_context('bars_context', 'user_mfo'));
        exception
            when dup_val_on_index then
                 raise_application_error(-20000, '�������� ���� ��� ������� {' || p_account_number ||
                                                 '} �� ���� {' || to_char(p_limit_date, 'dd.mm.yyyy') || '} ��� �������');
        end;
    end;

    procedure edit_lim_sb(
        p_uk_value in varchar2,
        p_account_number in varchar2,
        p_currency_id in integer,
        p_limit_amount in number,
        p_limit_date in date)
    is
        l_key_account_row accounts%rowtype;
        l_new_account_row accounts%rowtype;
        l_key_account_id integer;
        l_key_date date;
        l_key_values string_list;
    begin
        bars_audit.trace('mbk.edit_lim_sb' || chr(10) ||
                         'p_uk_value       : ' || p_uk_value       || chr(10) ||
                         'p_account_number : ' || p_account_number || chr(10) ||
                         'p_currency_id    : ' || p_currency_id    || chr(10) ||
                         'p_limit_amount   : ' || p_limit_amount   || chr(10) ||
                         'p_limit_date     : ' || p_limit_date);

        l_new_account_row := account_utl.read_account(p_account_number, p_currency_id);
        l_key_values := tools.string_to_words(p_uk_value, p_splitting_symbol => ';', p_trim_words => 'Y', p_ignore_nulls => 'Y');
        if (l_key_values is null or l_key_values.count <> 2) then
            raise_application_error(-20000, '��������� �������������� ����� ��� ��������� �����');
        else
            l_key_account_id := l_key_values(1);
            l_key_date := to_date(l_key_values(2), 'ddmmyyyy');
        end if;

        l_key_account_row := account_utl.read_account(l_key_account_id);

        update otcn_lim_sb t
        set    t.lim = p_limit_amount,
               t.acc = l_new_account_row.acc,
               t.fdat = p_limit_date
        where  t.acc = l_key_account_row.acc and
               t.fdat = l_key_date;
    end;

    procedure delete_lim_sb(
        p_uk_value in varchar2)
    is
        l_key_account_row accounts%rowtype;
        l_key_account_id integer;
        l_key_date date;
        l_key_values string_list;
    begin
        bars_audit.trace('mbk.delete_lim_sb' || chr(10) ||
                         'p_uk_value : ' || p_uk_value);

        l_key_values := tools.string_to_words(p_uk_value, p_splitting_symbol => ';', p_trim_words => 'Y', p_ignore_nulls => 'Y');
        if (l_key_values is null or l_key_values.count <> 2) then
            raise_application_error(-20000, '��������� �������������� ����� ��� ���������');
        else
            l_key_account_id := l_key_values(1);
            l_key_date := to_date(l_key_values(2), 'ddmmyyyy');
        end if;

        l_key_account_row := account_utl.read_account(l_key_account_id);

        delete otcn_lim_sb t
        where  t.acc = l_key_account_row.acc and
               t.fdat = l_key_date;
    end;

    function check_if_42_visa_should_apply(
        p_nostro_document_id in integer)
    return integer
    is
        l_original_document_id integer;
        l_original_document_row oper%rowtype;
    begin
        select to_number(t.value)
        into   l_original_document_id
        from   operw t
        where  t.ref = p_nostro_document_id and
               t.tag = 'NOS_R' and
               regexp_like(t.value, '^\d*$');

        l_original_document_row := read_document(l_original_document_id, p_raise_ndf => false);
        if (l_original_document_row.ref is null) then
            l_original_document_row := read_document(bars_sqnc.rukey(l_original_document_id), p_raise_ndf => false);
        end if;

        return case when l_original_document_row.tt in ('WD3', 'KV3') and (l_original_document_row.nlsa like '27%' or l_original_document_row.nlsa like '366%') then 0
                    else 1
               end;
    exception
        when no_data_found then
             return 1;
    end;

    function header_version return varchar2 is
    begin
        return 'Package header MBK ' || MBK_HEAD_VERS;
    end;

    function body_version return varchar2 is
    begin
        return 'Package body MBK ' || MBK_BODY_VERS;
    end;
end;
/
show err;
 
PROMPT *** Create  grants  MBK ***
grant EXECUTE                                                                on MBK             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MBK             to FOREX;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mbk.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 