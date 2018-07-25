 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mbk.sql =========*** Run *** =======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.MBK is
/*
 20.12.2017 ввОДИМ СПРАВОЧНИК mbdk-OB22
----------------
 15.12.2017 ВВод сделки - снова Proc-dr
 08.12.2017 Sta ОТСутствие в Proc-dr
 17.11.2017 Трансфер-2017 ПОДМЕНА ПРОЦЕДУРЫ ОТКР.СЧЕТА  На уровне бал.счетов - без учета об22 

*/
    MBK_HEAD_VERS  constant varchar2(64)  := 'version 57.0 26.03.2018';
    ATTR_AWAITING_MAIN_AMOUNT     constant varchar2(30 char) := 'MBDK_AWAITING_MAIN_AMOUNT';
    ATTR_AWAITING_INTEREST_AMOUNT constant varchar2(30 char) := 'MBDK_AWAITING_INTEREST_AMOUNT';

----------------------------------------------------------------------
Function Get_MBDK    (p_Vidd int)            Return MBDK_ob22%rowtype ;
function ACC_DOX_RASX(p_vidd int, p_kv int ) Return number ;
function  f_nls_mb(nbs_  varchar2,            rnk_ integer,            acrb_ integer,            kv_  integer,           maskid_ varchar2)    return varchar2;
procedure f_nls_mb(p_nbs accounts.nbs%type, p_rnk accounts.rnk%type, p_acrb accounts.acc%type, p_kv  accounts.kv%type, p_maskid nlsmask.maskid%type , p_initiator cp_ob_initiator.code%type,
                   p_acc_num_1 out accounts.nls%type,
                   p_acc_num_2 out accounts.nls%type );
function get_pawn_account_number(
        p_main_account_number in varchar2,
        p_pawn_kind_id in integer,
        p_deal_kind_id in integer,
        p_customer_id in integer,
        p_currency_id in integer)
 return varchar2;
---------------------------------------------------------------
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
    -- Формування проводок на оприбуткування та списання забезпечення по договору
    --
    procedure collateral_payments(
        p_mbk_id         in     cc_deal.nd%type     -- Ід.   угоди
        , p_mbk_num        in     cc_deal.cc_id%type  -- Номер угоди
        , p_beg_dt         in     cc_deal.sdate%type  -- Дата заключення
        , p_end_dt         in     cc_deal.wdate%type  -- Дата завершення
        , p_clt_amnt       in     oper.s%type         -- Сума    забезпечення
        , p_acc_num        in     oper.nlsa%type      -- Рахунок забезпечення
        , p_ccy_id         in     oper.kv%type        -- Валюта  забезпечення
        , p_rnk            in     customer.nmk%type   -- РНК
        , p_dk             in     oper.dk%type);        -- Д/К

    ----------------------------------------------------------------------
    --    Процедура обновления даты заключения сделки
    procedure upd_cc_deal (p_nd number, p_sdate date, p_prod varchar2, p_n_nbu varchar2, p_d_nbu date);
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
              DDAte_        date     default null,  -- Дата заключення
              IRR_          number   default null,  -- Еф. % ставка
              code_product_ number   default null,  -- Код продукта
              n_nbu_        varchar2 default null,   -- Номер свідоцтва НБУ
			  d_nbu_        date     default null    -- Дата реєстрації НБУ
) ;


    ----------------------------------------------------------------------
    procedure set_field58d (p_nd number, p_field58d varchar2);
    PROCEDURE del_deal (ND_ integer)  ;
    PROCEDURE clos_deal (ND_ integer,p_fl integer default 0 )  ;
    PROCEDURE back_deal (ND_ integer)  ;
    PROCEDURE del_Ro_deal (ND_ integer)  ;
    FUNCTION F_GetNazn(MaskId_ varchar2, ND_ number) return varchar2;
    ----------------------------------------------------------------------
    --    Процедура определяет списки переменных и их значений для печати тикета сделки
    --
    procedure get_print_value (
      p_nd         number,
      p_tic_name   varchar2,
      p_vars   out varchar2,
      p_vals   out varchar2 );

    ----------------------------------------------------------------------
    --    Процедура сохраняет информацию о трассе и посреднике
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
    procedure unlink_dcp(p_nd number);     --    Процедура отвязки залога ДЦП
    procedure link_deal (p_nd number, p_ndi number);     --    Процедура привязки договоров
    function get_deal_param ( p_nd    nd_txt.nd%type, p_tag   nd_txt.tag%type)  return varchar2;
    procedure set_deal_param( p_nd    nd_txt.nd%type, p_tag   nd_txt.tag%type,  p_val   nd_txt.txt%type  );
    function check_if_deal_belong_to_mbdk  (        p_product_id in integer)    return char;
    function check_if_deal_belong_to_crsour(        p_product_id in integer)    return char;

    function estimate_interest_amount(
        p_product_id in integer,
        p_deal_start_date in date,
        p_deal_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_base in number,
        p_interest_rate in number)
    return number;

    procedure edit_selected_reckoning   ( p_id in integer,        p_interest_amount in number,        p_purpose in varchar2);
    procedure prepare_deal_interest     ( p_deal_id in integer,        p_date_to in date); 
    procedure prepare_portfolio_interest( p_product_id in varchar2,      p_partner_id in varchar2,    p_currency_id in varchar2,    p_date_to in date);
    procedure pay_accrued_interest;
    procedure pay_selected_interest     ( p_id in integer);
    procedure remove_selected_reckoning ( p_id in integer);
    procedure open_awaiting_amount      ( p_deal_id in integer,    p_document_id in integer,       p_main_amount_flag in char );
    procedure close_awaiting_amount     ( p_deal_id in integer,    p_document_id in integer,       p_main_amount_flag in char);
    function make_docinput              ( p_nd in integer)   return cdb_mediator.t_make_document_urls    pipelined;

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
    function header_version return varchar2;
    function body_version return varchar2;

end MBK;
/
CREATE OR REPLACE PACKAGE BODY BARS.MBK is    MBK_BODY_VERS   CONSTANT VARCHAR2(64)  := 'version 2.1 27.03.2018';

--27.03.2018 LMartseniuk Перенос в архів принудительно и назад в портфель
--27.03.2018 VPogoda изменено определение id для процентной карточки. Теперь определяется не по типу договора, а по типу (А/П) счета
--27.12.2017 Sta ВВодим справочник продуктов MBDK_ob22 -- по рез тестирования от Б.Загороднего
  DEAL_KIND_CRED_SOUR_LOAN    constant integer := 3902;
  DEAL_KIND_CRED_SOUR_DEPOSIT constant integer := 3903;

---------------------------------------------------------
Function Get_MBDK (p_Vidd  int) Return MBDK_ob22%rowtype is   mm MBDK_ob22%rowtype ;
begin 
    BEGIN select * into mm from mbdk_ob22  where VIDD = p_Vidd  
             and SS   is not null and SN   is not null 
             and Sp   is not null and SpN  is not null 
             and SD_N is not null and SD_i is not null 
             and d_close is  null and io   is not null ;
    exception when NO_DATA_FOUND THEN  raise_application_error( -20666, p_Vidd ||'.Не заповнено вид угоди в довіднику MBDK_ob22' );  
    end;
    Return MM ;
end Get_MBDK  ;
-------------------------------------------
function ACC_DOX_RASX(p_vidd int, p_kv int ) Return number is  l_acc6 number ; mm MBDK_ob22%rowtype ;
begin 
   mm := MBK.Get_MBDK (p_Vidd  => p_vidd ) ;

   If p_kv <> gl.baseval then MM.SD_N := MM.SD_I ; end if ;

   begin   select acc into l_acc6 from accounts where kv = gl.baseval and  nls = nbs_ob22( substr(mm.SD_N,1,4) , substr(mm.SD_N,5,2 ) ) ;
   exception when NO_DATA_FOUND THEN  raise_application_error( -20666, p_Vidd||'/'|| p_kv ||'.Не знайдено рах.дох.витрат по довіднику MBDK_ob22' );  
   end;
    Return l_acc6 ;
end  ACC_DOX_RASX ;

------------------------------------------------------------------
-- F_NLS_MB   --   Функция возвращает номера счетов сделки (30 симв.)
Function F_NLS_MB (
   nbs_     in varchar2,  -- вид сделки
   rnk_     in integer,
   ACRB_    in integer, -- резерв
   kv_      in integer,
   maskid_     varchar2 ) return varchar2  IS
   -------------------------------------------
   SS_   varchar2(14) := to_char(null);   -- осн счет как результат
   SN_   varchar2(14) := to_char(null);   -- предполож нач % как результат
   ACRA_ integer;
   acc_  integer;
   id_   integer;
   MASK_ VARCHAR2(10);
   l_INITIATOR   varchar2(2);
   mm MBDK_ob22%rowtype ;
   l_NBS_SS char(4) ; l_Ob22_SS char(2) ;    l_NBS_SN char(4) ; l_Ob22_SN char(2) ;  D10 date := gl.Bdate -10 ;  D11 date := gl.Bdate -10 ; 

BEGIN l_INITIATOR := substr( pul.Get_Mas_Ini_Val('INITIATOR'), 1, 2 );

   mm := MBK.Get_MBDK (p_Vidd => to_number(nbs_) ); 

   If maskid_ = 'SP' then
      l_NBS_SS  := Substr(mm.SP,1,4);  
      l_Ob22_SS := Substr(mm.SP,5,2);  
      l_NBS_SN  := Substr(mm.SPN,1,4); 
      l_Ob22_SN := Substr(mm.SPN,5,2);
   else 
      l_NBS_SS  := Substr(mm.SS,1,4);  
      l_Ob22_SS := Substr(mm.SS,5,2);  
      l_NBS_SN  := Substr(mm.SN,1,4); 
      l_Ob22_SN := Substr(mm.SN,5,2);
   end if;


   begin 
      SELECT a.Nls,  a.acc,  i.id, n.nls, n.acc 
      INTO     SS_,   acc_,  id_ , SN_  , acra_
      FROM (select * from accounts where kv=kv_ AND nbs=l_NBS_SS and ob22=l_OB22_SS AND rnk=rnk_ and NVL(mdate,D11)<gl.bDate and NVL(dapp,D11)<D10 and dazs is null AND ostc=0 AND ostb=0 AND ostf=0) a, 
           (select * from accounts where kv=kv_ AND nbs=l_NBS_SN and ob22=l_OB22_SN AND rnk=rnk_ and NVL(mdate,D11)<gl.bDate and NVL(dapp,D11)<D10 and dazs is null AND ostc=0 AND ostb=0 AND ostf=0) n, 
           int_accn i,
           (select acc from SPECPARAM_CP_OB where INITIATOR = l_INITIATOR ) o
      WHERE a.acc = i.acc AND i.acra = n.acc and i.id = a.pap-1  and rownum = 1 ;

   exception when NO_DATA_FOUND THEN -- увы, нет --смоделируем следующий (первый) новый

      if nbs_ like '39%' then  MASK_ := 'MFK';  else     MASK_ := 'MBK';       end if;
      SS_ := F_NEWNLS2(null, MASK_, l_NBS_SS, RNK_,null ); SN_ := F_NEWNLS2(null, MASK_, l_NBS_SN, RNK_,null );
   END;
   return (substr(SS_||'               ', 1, 15) ||      substr(SN_||'               ', 1, 15)        );
END F_NLS_MB ;
---------------------------------
procedure f_NLS_MB
  ( p_nbs            in     accounts.nbs%type
  , p_rnk            in     accounts.rnk%type
  , p_acrb           in     accounts.acc%type
  , p_kv             in     accounts.kv%type
  , p_maskid         in     nlsmask.maskid%type
  , p_initiator      in     cp_ob_initiator.code%type
  , p_acc_num_1      out    accounts.nls%type
  , p_acc_num_2      out    accounts.nls%type
  ) is  l_sTmp     varchar2(30);
  begin
    If ( gl.aMfo = '300465' )    then      pul.set_mas_ini( 'INITIATOR', p_initiator, 'Центр инициатора операции' );    end if;
    l_sTmp      := SubStr( f_nls_mb( p_nbs, p_rnk, p_acrb, p_kv, p_maskid ), 1, 30 );
    p_acc_num_1 := VKRZN ( gl.aMfo, trim( SubStr( l_sTmp,  1, 15 ) ) ) ;
    p_acc_num_2 := VKRZN ( gl.aMfo, trim( SubStr( l_sTmp, 16, 15 ) ) ) ;
    bars_audit.trace( 'MBK.F_NLS_MB: Exit with( acc_num_1='|| p_acc_num_1 ||', acc_num_2='|| p_acc_num_2 ||' ).' );
end f_NLS_MB;
-------------------------------
function get_pawn_account_number( p_main_account_number in varchar2, p_pawn_kind_id in integer,  p_deal_kind_id in integer,   p_customer_id in integer,  p_currency_id in integer)
  return varchar2    is
        l_pawn_kind_row cc_pawn%rowtype;
        l_pawn_account_row accounts%rowtype;
        l_pawn_account_number varchar2(15 char);
        l_pawn_balance_account varchar2(10 char);
begin l_pawn_kind_row := cck_utl.read_cc_pawn(p_pawn_kind_id);

        if (p_main_account_number is not null) then
            l_pawn_account_number := vkrzn(bars_context.current_mfo(), l_pawn_kind_row.nbsz || substr(trim(p_main_account_number), 5, 10));
            l_pawn_account_row := account_utl.read_account(l_pawn_account_number, p_currency_id, p_raise_ndf => false);
        end if;

        if (l_pawn_account_row.acc is not null) then
            l_pawn_account_number := f_newnls2(null, 'MBK', l_pawn_kind_row.nbsz, p_customer_id, null);
        end if;
        return l_pawn_account_number;

end get_pawn_account_number;

--    Rollover/пролонгация
procedure ro_deal (
        cc_id_new   in varchar2,    /* новый номер тикета    */
        nd_         in integer,     /* старый ND             */
        nd_new      out integer,    /* новый ND для ролловер */
        acc_new     out integer,    /* ACC нового счета      */
        nid_        in integer,
        nkv_        in integer,
        nls_old     in varchar2,
        nls_new     in varchar2,  -- Новый вид дог 
        nls8_new    in varchar2,  -- резерв
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
     l_s180      specparam.s180%type;
     ------------------------------
     vidd_old int;
     VIDD_new int;

     AA  accounts%rowtype;      -- Старый и Новый счет тела
     A8  accounts%rowtype;      -- Старый и Новый счет нач проц
     l_INITIATOR  SPECPARAM_CP_OB.INITIATOR%type;

BEGIN
logger.info ('RRR'  ||'*'
      ||cc_id_new   ||'*' 
      || nd_        ||'*'
      || nid_       ||'*'
      || nkv_       ||'*'
      ||  nls_old   ||'*'
      ||  nls_new   ||'*'
      ||  nls8_new  ||'*'
      ||  ns_old    ||'*'
      ||  ns_new    ||'*'
      ||  npr_old   ||'*'
      ||  npr_new   ||'*'
      ||  datk_old  ||'*'
      ||  datk_new  ||'*'
      ||  datn_old  ||'*'
      ||  datn_new  ||'*'
      ||  nlsb_new  ||'*'
      ||  mfob_new  ||'*'
      ||  nlsnb_new ||'*'
      ||  mfonb_new ||'*'
      ||  refp_new  ||'*'
      ||  bica_     ||'*' );

   ACC_NEW := to_number(NUll) ;
   VIDD_new  := to_number(substr(NLS_NEW ,1,4));

   BEGIN  -- реквизиты старой сделки
      SELECT d.vidd, d.cc_id, a.bDATE,  d.KPROLOG, c.RNK, c.nmkk, a.accs,     a.acckred, a.mfokred, a.accperc, a.mfoperc,  a.refp
      INTO vidd_old,  cc_id_ ,   DAT2_,   KPROLOG_,  RNK_, NMK_, ACC_OLD,     NLSB_OLD,  MFOB_OLD,  NLSNB_OLD, MFONB_OLD,  REFP_OLD
      FROM cc_deal d,  customer c, cc_add a          WHERE d.nd=ND_ AND d.rnk=c.rnk AND a.nd=d.nd AND a.adds=0 ;

      SELECT acra  INTO ACRA_OLD FROM    int_accn    WHERE acc=ACC_OLD AND id=nID_ AND acra is not null ;

      select * into AA from accounts where acc = ACC_OLD  ; 
      select * into A8 from accounts where acc = ACRA_OLD ; 

      begin  select INITIATOR  into l_INITIATOR  from SPECPARAM_CP_OB where  acc = ACC_OLD;
      EXCEPTION WHEN NO_DATA_FOUND THEN l_INITIATOR := null;
      end;
      pul.set_mas_ini( 'INITIATOR', l_initiator, 'Центр инициатора операции' );

   EXCEPTION WHEN NO_DATA_FOUND THEN raise_application_error( -20666, 'НЕ знайдено реквізити старої угоди='|| ND_ );
   end;


   IF vidd_old = vidd_new then ---- nvl(CC_ID_NEW, cc_id_) = cc_id_ and DATN_NEW = DAT2_ THEN         --старая сделка (не ролловер, а пролонгация), просто меняем  реквизиты сделки
      UPDATE cc_deal   SET KPROLOG = KPROLOG +1, limit= nS_NEW, wdate=DatK_NEW     WHERE nd= ND_;
      ND_NEW   := ND_;
      ACC_NEW  := ACC_OLD;     
      ACRA_NEW := ACRA_OLD;

   ElsIf trunc(vidd_old/100) <> trunc(vidd_new/100) then raise_application_error( -20666, 'НЕвідповідність видів угод: старої='|| Vidd_old ||' та нової='|| Vidd_new ) ;

   ELSE      -- новая сделка-клон (ролловер)
      declare   MM mbdk_OB22%ROWTYPE;    l_sTmp varchar2(30);
      begin     MM := Get_MBDK( p_Vidd => Vidd_new) ;
         -- счет доходов-расходов c превентивным открытием
         OP_BS_OB1 ( PP_BRANCH => Substr( sys_context('bars_context','user_branch'),1,15) , P_BBBOO  => MM.SD_N ) ;
         OP_BS_OB1 ( PP_BRANCH => Substr( sys_context('bars_context','user_branch'),1,15) , P_BBBOO  => MM.SD_I ) ;
         nd_new := bars_sqnc.get_nextval('s_cc_deal');
         INSERT INTO cc_deal d (nd, vidd, rnk, d.user_id, cc_id, sos, wdate, sdate, limit, kprolog)
                     SELECT ND_NEW, VIDD_new, rnk, gl.aUID, CC_ID_NEW, 10, DatK_NEW, gl.BDATE, nS_NEW, 0  FROM cc_deal WHERE nd=ND_;
         INSERT INTO cc_add (  nd,    adds, s, kv, bdate, wdate, sour, acckred, mfokred, freq, accperc, mfoperc, refp, int_amount,   swi_bic, swi_acc, swi_ref, swo_bic, swo_acc, swo_ref, alt_partyb, interm_b,
                             int_partya, int_partyb, int_interma, int_intermb )
                     SELECT ND_NEW, 0,   s, kv, bdate, wdate, sour, acckred, mfokred, freq, accperc, mfoperc,refp, int_amount,    swi_bic, swi_acc, null, swo_bic, swo_acc, null, alt_partyb, interm_b,
                            int_partya, int_partyb, int_interma, int_intermb
                     FROM cc_add WHERE nd=ND_ AND adds=0;

         l_sTmp := SubStr( MBK.f_nls_mb( VIDD_NEW, RNK_, null, nKv_, 'MBK'), 1, 30 );
         aa.NLS := VKRZN ( gl.aMfo, trim( SubStr( l_sTmp,  1, 15 ) ) ) ;
         a8.nls:= VKRZN ( gl.aMfo, trim( SubStr( l_sTmp, 16, 15 ) ) ) ;

         -- открытие основного счета +  открытие счета нач.%%
         op_reg_ex (1,ND_new ,n_, 33, n_,RNK_,aa.NLS, nKv_,NMk_, aa.tip, gl.aUid, acc_new, '1', null, null,  null);  accreg.setAccountSParam(acc_new, 'OB22', Substr(MM.ss,5,2)  );
         op_reg_ex (1,ND_new ,n_, 33, n_,RNK_,a8.NLS, nKv_,NMk_, a8.Tip, gl.aUid, ACRA_NEW,'1', null, null,  null);  accreg.setAccountSParam(ACRA_NEW, 'OB22', Substr(MM.sn,5,2)  );

         update accounts set mdate = DatK_NEW where acc = ACC_NEW ;
         update accounts set mdate = DatK_NEW where acc = ACRA_NEW;
         UPDATE cc_add   SET accs  = ACC_NEW  WHERE nd  = ND_new  ;


         update cc_accp set accs = ACC_NEW , nd = ND_NEW where nd = ND_ and accs = ACC_old ;   -- перепривязываем залог к новому договору
         update cc_accp set accs = ACra_NEW, nd = ND_NEW where nd = ND_ and accs = ACra_old;   -- перепривязываем залог к новому договору

      end;
   end if;

   --------------------------------------------------------------	   
   -- для остального
   select substr(
       decode ( nvl(CC_ID_NEW, cc_id_),cc_id_,  decode (DATN_NEW,DAT2_,'Змiни:','Змiни-Ролл:'),'Змiни-Ролл:')||
       decode ( nS_OLD  , nS_NEW  , '',  ' Суми з '   || trim(to_char(nS_OLD*100,'9999999999999,99')) ||  ' до '  || trim(to_char(nS_NEW*100,'9999999999999,99')) || '. ') ||
       decode ( nPr_OLD , nPr_NEW , '',  ' % Ст. з '  || nPr_OLD ||    ' до '     || nPr_NEW || '. ') ||
       decode ( DatK_OLD, DatK_NEW, '',  ' Строку з ' || to_char(DatK_OLD,'dd/MM/yyyy') || ' до '     || to_char(DatK_NEW,'dd/MM/yyyy') || '. ') ||
       decode ( NLS_OLD , aa.NLS  , '',  ' Рахунку з '|| Nls_OLD ||  ' на '       || aa.nLS || '.')  ||
       decode ( NLSB_OLD , NLSB_NEW ,'', ' Рахунку осн. партнера з ' || NLSB_OLD || ' (МФО ' || MFOB_OLD || ')' ||  ' на ' || NLSB_NEW || ' (МФО ' || MFOB_NEW || ').') ||
       decode ( NLSNB_OLD, NLSNB_NEW,'', ' Рахунку нар.% партнера з '|| NLSNB_OLD|| ' (МФО ' || MFONB_OLD|| ')' ||  ' на ' || NLSNB_NEW|| ' (МФО ' || MFONB_NEW|| ').')
                      , 1,250) into sTXT_ from dual;


   If DATK_OLD <> DATK_NEW OR ACC_OLD <> ACC_NEW then
      UPDATE accounts SET mdate=DatK_NEW     WHERE acc=ACC_NEW ;
      UPDATE accounts SET mdate=DatK_NEW     WHERE acc=ACRA_NEW;     --, pap=nID_+1            оставим в соотв. с планом счетов
      UPDATE int_accn SET STP_DAT=DatK_NEW-1 WHERE acc=ACC_NEW and id=nID_;
      IF SQL%rowcount = 0 THEN     -- определим контрсчет для проц карточки
         nG67_ := MBK.ACC_DOX_RASX( VIDD_new, nKv_);
         INSERT INTO int_accn (ACC, ID, METR, BASEM, BASEY, FREQ, STP_DAT   , ACR_DAT, APL_DAT, TT, ACRA    , ACRB , S, TTB, KVB, NLSB, MFOB, NAMB, NAZN)
                    SELECT ACC_NEW,nID_,METR, BASEM, BASEY, FREQ, DatK_NEW-1, ACR_DAT, APL_DAT, TT, ACRA_NEW, nG67_, S, TTB, KVB, NLSB, MFOB, NAMB, NAZN  
                    FROM int_accn WHERE acc = ACC_OLD and id = nID_;
      END IF;
   END IF;

   IF nPr_OLD <> nPr_NEW OR ACC_OLD <> ACC_NEW THEN
      UPDATE int_ratn SET IR=nPr_NEW WHERE acc=ACC_NEW AND id=nID_ AND BDAT=gl.BDATE;
      IF SQL%rowcount = 0 THEN    INSERT INTO int_ratn(ACC, ID, BDAT, IR)       VALUES (ACC_NEW, nId_, gl.BDATE, nPr_NEW);     END IF;
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

     -- Если порождаем новый договор, то
     If ND_NEW <> ND_ then  D020_ := '01';
     else                   D020_ := '02';
     end if;

     UPDATE specparam set D020 = D020_ where acc = ACC_NEW ;   if SQL%rowcount = 0 then      INSERT INTO specparam ( ACC, D020 ) values ( ACC_NEW, D020_ );   end if;

     -- новый код срока только для 1-го класса
     if aa.nls like '1%' then        l_s180 := FS180(ACC_NEW, '1', bankdate);
        update specparam set s180 = l_s180 where acc = ACC_NEW;        if SQL%rowcount = 0 then           INSERT INTO specparam (ACC, S180) values (ACC_NEW, l_s180);        end if;
     end if;

END RO_deal;
------------------------------------------------------------------
  function check_if_deal_belong_to_mbdk(        p_product_id in integer)    return char    is
  begin  return case when length(p_product_id) = 4 and (p_product_id like '1%' or p_product_id in (2700, 2701, 3660, 3661)) then 'Y'             else 'N'        end;  end;

    ------------------------------------------------------------------
    -- перевірка, чи відноситься угода до функціональності Кредитних ресурсів
    ---
    function check_if_deal_belong_to_crsour(
        p_product_id in integer)
    return char
    is
    begin        return case when p_product_id in (DEAL_KIND_CRED_SOUR_LOAN, DEAL_KIND_CRED_SOUR_DEPOSIT) then 'Y' else 'N' end;    end;


    ------------------------------------------------------------------

    -- Формування проводок на оприбуткування та списання забезпечення по договору
    --
    procedure collateral_payments(
        p_mbk_id   in cc_deal.nd%type,     -- Ід.   угоди
        p_mbk_num  in cc_deal.cc_id%type,  -- Номер угоди
        p_beg_dt   in cc_deal.sdate%type,  -- Дата заключення
        p_end_dt   in cc_deal.wdate%type,  -- Дата завершення
        p_clt_amnt in oper.s%type,         -- Сума    забезпечення
        p_acc_num  in oper.nlsa%type,      -- Рахунок забезпечення
        p_ccy_id   in oper.kv%type,        -- Валюта  забезпечення
        p_rnk      in customer.nmk%type,   -- РНК
        p_dk       in oper.dk%type)        -- Д/К
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

        begin select a.NLS, a.NMS    into l_9910_num, l_9910_nm     
              from BARS.ACCOUNTS a  where a.NLS  = Substr(BARS.BRANCH_USR.GET_BRANCH_PARAM('NLS_9900'),1,14)   and a.KV   = p_ccy_id    and a.DAZS is Null;
        exception  when NO_DATA_FOUND then   raise_application_error( -20666, 'Не знайдено або закритий рахунок 9910', true );
        end;

        begin   select nvl(c.NMKK,SubStr(c.NMK,1,38)), c.OKPO       into l_cust_num, l_cust_code      from BARS.CUSTOMER c    where c.RNK = p_rnk   and c.DATE_OFF Is Null;
        exception    when NO_DATA_FOUND then    raise_application_error( -20666, 'Не знайдено або закритий клієнт з РНК = ' || to_char(p_rnk), true );
        end;

        l_nd   := bars.GetGlobalOption('MBK_ND');
        l_vob  := BARS.F_GET_PARAMS('MBK_VZAL',0);

        l_vob  := case when ( l_vob = 0 ) then 6 when ( p_ccy_id = gl.baseval ) then 6 else l_vob end;
        l_nazn := 'Застава згідно угоди ' || p_mbk_num || ' від ' || to_char(p_beg_dt,'dd/mm/yyyy');

        gl.ref( l_ref );
        l_nd := case when ( l_nd = 'REF' ) then SubStr(to_char(l_ref),-10)   else SubStr(p_mbk_num,   1, 10) end;
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

        paytt( null, l_ref, p_beg_dt, l_tt, l_dk,   p_ccy_id, l_9910_num, p_clt_amnt,  p_ccy_id, p_acc_num , p_clt_amnt );
        cck_utl.link_document_to_deal(p_mbk_id, l_ref);
        --------------------
        l_ref  := null;
        l_nazn := 'Повернення застави згідно угоди ' || p_mbk_num || ' від ' || to_char(p_beg_dt,'dd/mm/yyyy');
        gl.ref( l_ref );
        l_nd := case when ( l_nd = 'REF' ) then SubStr(to_char(l_ref),-10)   else SubStr(p_mbk_num,   1, 10)   end;
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

        paytt( null, l_ref, p_end_dt, l_tt, l_dk,  p_ccy_id, l_9910_num, p_clt_amnt,   p_ccy_id, p_acc_num , p_clt_amnt );
        cck_utl.link_document_to_deal(p_mbk_id, l_ref);

    end;
    ----------------------------------------------------------------------
    --    Процедура обновления даты заключения сделки
    procedure upd_cc_deal (p_nd number, p_sdate date, p_prod varchar2, p_n_nbu varchar2, p_d_nbu date)
    is
    begin
      update cc_deal set sdate = p_sdate, prod  = p_prod  where nd = p_nd;
      update cc_add  set n_nbu = p_n_nbu, d_nbu = p_d_nbu where nd = p_nd and adds=0;
    end upd_cc_deal;
    ----------------------------------------------------------------------
    PROCEDURE inp_deal_Ex (
      CC_ID_        varchar2,   -- N тикета/договора
      nVidd_        integer,        -- Вид договора
      nTipd_        integer,        -- Тип договора
      nKV_          integer,        -- Валюта
      RNKB_         integer,        -- Рег.№ партнера
      DAT2_         date,       -- дата сделки
      p_datv        date,       -- дата валютирования
      DAT4_         date,       -- дата окончания
      IR_           number,     -- индив ставка
      OP_           number,     -- арифм.знак
      BR_           number,     -- базовая ставки
      SUM_          number,     -- Сумма сделки (в руб.)
      nBASEY_       integer,        -- % база
      nIO_          integer,        -- Начисление на входящий остаток 1-Да/0-Нет
      S1_           varchar2,   -- Осн.Счет для банка Б
      S2_           varchar2,   -- Код банка Б (mfo/bic) для осн.сч
      S3_           varchar2,   -- Счет нач.% для банка Б
      S4_           varchar2,   -- Код банка Б (mfo/bic) для сч нач.%
      S5_           number,     -- Счет для входа валюты
      NLSA_         varchar2,   -- Основной счет в нашем банке
      NMS_          varchar2,   -- Наименование основного счета
      NLSNA_        varchar2,   -- Счет начисленных % в нашем банке
      NMSN_         varchar2,   -- Наименование счета начисленных %
      NLSNB_        varchar2,   -- Счет нач.% для банка Б = S3_
      NMKB_         varchar2,   -- Наименование клиента
      Nazn_         varchar2,   -- Назначение платежа (% по дог. CC_ID)
      NLSZ_         varchar2,   -- Счет обеспечения
      nKVZ_         integer,        -- Валюта обеспечения
      p_pawn        number,     -- код вида обеспечения
      Id_DCP_       integer,        -- Id from dcp_p.id
      S67_          varchar2,   -- Счет доходов
      nGrp_         integer,        -- Группа доступа счетов
      nIsp_         integer,        -- Исполнитель
      BICA_         varchar2,   -- BIC нашего банка
      SSLA_         varchar2,   -- Счет VOSTRO у нашего банка-корреспонд
      BICB_         varchar2,   -- BIC партнера
      SSLB_         varchar2,   -- Счет VOSTRO партнера у его банка-корресп
      SUMP_         number,     -- Сумма %%
      AltB_         varchar2,
      IntermB_      varchar2,
      IntPartyA_    varchar2,
      IntPartyB_    varchar2,
      IntIntermA_   varchar2,
      IntIntermB_   varchar2,
      ND_           out integer,
      ACC1_         out integer,
      sErr_         out varchar2,
      DDAte_        date     default null,  -- Дата заключення
      IRR_          number   default null,  -- Еф. % ставка
      code_product_ number   default null,  -- Код продукта
      n_nbu_        varchar2 default null,   -- Номер свідоцтва НБУ
      d_nbu_        date     default null   -- Дата реєстрації НБУ
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
      nTmp_                   integer;
      l_s180                  specparam.s180%type;
      l_initiator             varchar2(2);
      l_ob22                  specparam_int.ob22%type;
      l_txt                   customerw.value%type;
      l_tipd                  cc_vidd.tipd%type;
      l_clt_amnt              oper.s%type; -- сума застава з pul
      inr_err                 exception;   -- Internal error
      l_nmkb                  int_accn.namb%type;

      MM mbdk_OB22%ROWTYPE;
    BEGIN
      MM := Get_MBDK( p_Vidd => nVidd_) ;

      -- счет доходов-расходов c превентивным открытием
      OP_BS_OB1 ( PP_BRANCH => Substr( sys_context('bars_context','user_branch'),1,15) , P_BBBOO  => MM.SD_N ) ;
      OP_BS_OB1 ( PP_BRANCH => Substr( sys_context('bars_context','user_branch'),1,15) , P_BBBOO  => MM.SD_I ) ;
      --------------------------------------------------------------	   
      If nKv_ <> gl.baseval then 
        MM.SD_N := MM.SD_I; 
      end if;

      Acc3_ := MBK.ACC_DOX_RASX(p_vidd => nVidd_, p_kv=>nKv_ ) ;
  
      nd_ := bars_sqnc.get_nextval('s_cc_deal');
      INSERT INTO cc_deal(nd, vidd, rnk, user_id, cc_id, sos, wdate, sdate, limit, kprolog,ir,prod) 
        VALUES (ND_,nVidd_,RNKB_,gl.aUid,CC_ID_,10,DAT4_,nvl(DDAte_, gl.BDATE), SUM_, 0, IRR_,code_product_);

      INSERT INTO cc_add (nd         , adds       , s      , kv     , bdate  , wdate  , sour      , acckred   , mfokred , freq      , accperc   ,
                          mfoperc    , refp       , swi_bic, swi_acc, swo_bic, swo_acc, int_amount, alt_partyb, interm_b, int_partya, int_partyb,
                          int_interma, int_intermb, n_nbu, d_nbu  )
                  VALUES (ND_        , 0          , Sum_   , nKv_   , DAT2_  , p_datv , 4         , S1_       , S2_     , 2         , S3_       ,
                          S4_        , S5_        , bica_  , ssla_  , bicb_  , sslb_  , sump_     , altb_     , intermb_, IntPartyA_, IntPartyB_,
                          IntIntermA_, IntIntermB_, n_nbu_ , d_nbu_ );

      if  nTipd_ Is Null then 
        select TIPD 
          into l_tipd  
          from CC_VIDD 
            where VIDD = nVidd_;   
      else  
        l_tipd := nTipd_; 
      end if ;
      
      if l_tipd = 1      then  
--        nID_:=0; 
        Tip1_:='SS '; 
        Tip2_:='SN '; 
      else  
--        nID_:=1; 
        Tip1_:='DEP'; 
        Tip2_  :='DEN'  ; 
      end if ;

      --
      

      -- открытие основного счета +  открытие счета нач.%%
      op_reg_ex (1,ND_,nTmp_, 33, nTmp_,RNKB_,NLSA_, nKv_,NMS_, Tip1_, gl.aUid, ACC1_, '1', null, null,  null);  
      accreg.setAccountSParam(ACC1_, 'OB22', Substr(MM.ss,5,2)  );
      begin
        select case pap 
                 when 1 then 0
                 when 2 then 1
                 else nid_
               end
          into nid_
          from accounts 
          where nls = nlsa_
            and kv = nkv_;
      exception 
        when others then
          nid_ := nid_;
      end;

      op_reg_ex (1,ND_,nTmp_, 33, nTmp_,RNKB_,NLSNA_,nKv_,NMSN_,Tip2_, gl.aUid, ACC2_, '1', null, null,  null);  
      accreg.setAccountSParam(ACC2_, 'OB22', Substr(MM.sn,5,2)  );

      update accounts set mdate = DAT4_ where acc = ACC1_;

      update accounts set mdate = DAT4_ where acc = ACC2_;

      -------------------------------------------------------------------------------------------------------------------------
      UPDATE cc_add          
        SET accs=ACC1_ 
        WHERE nd=ND_; 
      l_INITIATOR := substr( pul.Get_Mas_Ini_Val('INITIATOR'), 1, 2 );

      update SPECPARAM_CP_OB 
        set INITIATOR= l_INITIATOR 
        where acc=ACC1_; 

      if SQL%rowcount= 0 then 
        insert into SPECPARAM_CP_OB (ACC,INITIATOR) 
          values ( ACC1_,l_INITIATOR );  
      end if;

      update SPECPARAM_CP_OB 
        set INITIATOR= l_INITIATOR 
        where acc=ACC2_; 
      if SQL%rowcount= 0 then 
        insert into SPECPARAM_CP_OB (ACC,INITIATOR) 
          values ( ACC2_,l_INITIATOR );  
      end if;


      IF NLSZ_ is not null  then         -- открытие счета залога
         op_reg_ex ( 2, ND_, p_pawn  , 2, nTmp_, RNKB_, NLSZ_, nKVZ_, NMS_, 'ZAL', gl.aUid, ACC4_, '1', null, null, null                   ); -- KB  pos=1
         p_setAccessByAccmask(ACC4_, ACC1_);           -- проставляем группу доступа для счета залога как для основного счета
         insert into nd_acc (nd, acc) 
           values (ND_, ACC4_);
         if l_tipd = 1 then 
           update cc_accp 
             set nd=ND_ 
             where acc=ACC4_ 
               and accs=ACC1_; 
           IF SQL%rowcount = 0 then 
             INSERT into cc_accp (ACC,ACCS,nd) 
               values (ACC4_,ACC1_,ND_); 
           END IF;   
         END IF;
         cck_utl.set_deal_attribute(ND_, 'PAWN', to_char(p_pawn));

         IF Id_DCP_ is not null then   
           UPDATE dcp_p 
             Set ref=-ND_, 
                 acc=ACC1_ 
             WHERE id=Id_DCP_; 
         END IF;          -- обеспечение - ДЦП
         UPDATE accounts 
           SET mdate=DAT4_,
               PAP=l_tipd 
           WHERE acc=ACC1_;
         UPDATE accounts 
           SET mdate=DAT4_            
           WHERE acc=ACC2_;
         UPDATE accounts 
           SET mdate=DAT4_            
           WHERE acc=ACC4_;
      end if;
      -- Внесение РНК в CUSTBANK для сделок (2700,2701,3660)
      if mbdk_tip(nVidd_) = 1 THEN 
         update custbank set bki = 1 where rnk = RNKB_ ;
         if SQL%rowcount = 0 then
            insert into custbank (rnk, bki) values (RNKB_, 1);
         end if;
      end if;
      -- Artem Yurchenko, 24.11.2014
      -- для кредитных ресурсов необходимо использовать другие операции
      if (check_if_deal_belong_to_crsour(nVidd_) = 'Y') then           -- установка ОБ22 +     -- проставим спецпараметр МФО (нужно для файлов 32, 33)
           l_ob22 := '02';  
           accreg.setAccountSParam(ACC1_, 'OB22', l_ob22);    
           accreg.setAccountSParam(ACC2_, 'OB22', l_ob22);
           sTTB_ := 'PS2';  
           accreg.setAccountSParam(ACC1_, 'MFO' , s2_   );    
           accreg.setAccountSParam(ACC2_, 'MFO' , s2_   );
           sTTA_ := '%%1';
      else 
        sTTB_ := case 
                   when nKv_ = gl.baseval then 
                       'WD2' 
                   else 'WD3' 
                 end;
           --операция по начислению проц
           BEGIN 
             SELECT val 
               INTO sTTA_ 
               FROM params 
               WHERE par='MBD_%%1';      
           EXCEPTION 
             WHEN NO_DATA_FOUND THEN 
               sTTA_ := '%%1';       
           END;
           BEGIN 
             SELECT decode(codcagent,1, sTTA_, decode(l_tipd,1,'%00','%02') ) 
               INTO sTTA_ 
               FROM customer 
               WHERE rnk=RNKB_; 
           EXCEPTION 
             WHEN NO_DATA_FOUND THEN 
               sERR_ := 'Не найден RNKB '||RNKB_;   
               raise_application_error( -20666, sERR_ );  --raise inr_err; 
           END;
      end if;

      update INT_ACCN 
        set BASEY = nBASEY_, 
            TT = sTTA_, 
            STP_DAT = DAT4_-1, 
            ACRA = ACC2_, 
            ACRB = ACC3_, 
            s = 0, 
            IO = mm.io , 
            acr_dat = decode(mm.io,1,gl.BDATE,acr_dat)   
        where acc = ACC1_  
          and id  = nID_;
      IF SQL%rowcount = 0  then  
        INSERT INTO int_accN (acc, ID, metr, basem, BASEY, freq, ACRA, ACRB, KVB, TT, TTB, STP_DAT, s, IO, acr_dat )
          VALUES (ACC1_, nID_, 0, 0, nBASEY_, 1, ACC2_, ACC3_, nKv_, sTTA_, sTTB_, DAT4_-1, 0, mm.io, decode(mm.io,1,gl.BDATE,null));
      END IF;

      IF    nID_ = 1 and nKV_ =gl.baseval OR check_if_deal_belong_to_crsour(nVidd_) = 'Y'  then 
            UPDATE int_accN 
              Set NLSB=substr(nlsnb_, 1,14), 
                  NAMB= l_nmkb, 
                  NAZN=Nazn_, 
                  MFOB=S2_    
              WHERE acc=ACC1_ 
                AND id=1;
      ELSe  
        UPDATE int_accN 
          Set NLSB=substr(NLSNB_, 1,14), 
              NAMB= l_nmkb, 
              NAZN=Nazn_              
          WHERE acc=ACC1_ AND id=1;
      end if;

      update INT_ratn 
        SET ir=IR_, 
            op=OP_, 
            br=BR_ 
        where acc=ACC1_ 
          and id=nID_ 
          and bdat=DAT2_; 
      if SQL%rowcount=0 then 
        INSERT INTO INT_ratn(acc,ID,bdat,ir,op,br) 
           VALUES (ACC1_,nID_,DAT2_,IR_,OP_,BR_);  
      end if;

      -- При открытии договора D020 := '01'
      UPDATE specparam 
        set D020 = '01' 
        where acc=ACC1_;         
      if SQL%rowcount = 0 then   
        INSERT INTO specparam (ACC, D020 ) 
          values ( ACC1_, '01' );     
      end if;
      
      if nVidd_ like '1%' then   
        l_s180 := FS180(ACC1_, '1', bankdate);          -- новый код срока только для 1-го класса
        update specparam 
          set s180 = l_s180 
          where acc = acc1_;  
        if SQL%rowcount = 0 then  
          INSERT INTO specparam (ACC, S180) 
            values (ACC1_, l_s180);       
        end if;
      end if;

      -- установка параметрів Первинний та Поточний ВКР
      begin  
        select VALUE    
          into l_txt    
          from BARS.CUSTOMERW   
            where RNK = RNKB_     
              and TAG = 'VNCRR';          
      exception  
        when NO_DATA_FOUND then    
          bars_audit.info( title || ': not found "VNCRR" for RNK = ' || to_char(RNKB_) );    
      end;  
      cck_utl.set_deal_attribute( ND_, 'VNCRR', l_txt );         -- Поточний ВКР

      -- Первинний ВКР
      begin  
        insert into BARS.ND_TXT (ND, TAG, TXT )    
          values    ( ND_, 'VNCRP', l_txt );
      exception  
        when DUP_VAL_ON_INDEX then   null;      -- вже був вставлений тригером
      end;

      l_clt_amnt := to_number( bars.pul.get_mas_ini_val('COLLATERAL_AMOUNT') );
      if l_clt_amnt > 0  and  NLSZ_ is Not Null    then
         collateral_payments( p_mbk_id   => ND_  , p_mbk_num=> CC_ID_, p_beg_dt=> DAT2_, p_end_dt=> DAT4_, p_clt_amnt => l_clt_amnt, 
                              p_acc_num  => NLSZ_, p_ccy_id => nKVZ_ , p_rnk   => RNKB_, p_dk    => case when l_tipd = 1 then 1 else 0 end   );
      end if;

    END inp_deal_Ex;
    ------------------------------------------------------------------

    -- inp_deal
    --
    --    Ввод новой сделки
    --
    --
    PROCEDURE inp_deal (
      CC_ID_       varchar2,   -- N тикета/договора
      nVidd_       integer,        -- Вид договора
      nTipd_       integer,        -- Тип договора
      nKV_         integer,        -- Валюта
      RNKB_        integer,        -- Рег.№ партнера
      DAT2_        date,       -- дата сделки
      p_datv       date,       -- дата валютирования
      DAT4_        date,       -- дата окончания
      IR_          number,     -- индив ставка
      OP_          number,     -- арифм.знак
      BR_          number,     -- базовая ставки
      SUM_         number,     -- Сумма сделки (в руб.)
      nBASEY_      integer,        -- % база
      nIO_         integer,        -- Начисление на входящий остаток 1-Да/0-Нет
      S1_          varchar2,   -- Осн.Счет для банка Б
      S2_          varchar2,   -- Код банка Б (mfo/bic) для осн.сч
      S3_          varchar2,   -- Счет нач.% для банка Б
      S4_          varchar2,   -- Код банка Б (mfo/bic) для сч нач.%
      S5_          number,     -- Счет для входа валюты
      NLSA_        varchar2,   -- Основной счет в нашем банке
      NMS_         varchar2,   -- Наименование основного счета
      NLSNA_       varchar2,   -- Счет начисленных % в нашем банке
      NMSN_        varchar2,   -- Наименование счета начисленных %
      NLSNB_       varchar2,   -- Счет нач.% для банка Б = S3_
      NMKB_        varchar2,   -- Наименование клиента
      Nazn_        varchar2,   -- Назначение платежа (% по дог. CC_ID)
      NLSZ_        varchar2,   -- Счет обеспечения
      nKVZ_        integer,        -- Валюта обеспечения
      p_pawn       number,     -- код вида обеспечения
      Id_DCP_      integer,        -- Id from dcp_p.id
      S67_         varchar2,   -- Счет доходов
      nGrp_        integer,        -- Группа доступа счетов
      nIsp_        integer,        -- Исполнитель
      BICA_        varchar2,   -- BIC нашего банка
      SSLA_        varchar2,   -- Счет VOSTRO у нашего банка-корреспонд
      BICB_        varchar2,   -- BIC партнера
      SSLB_        varchar2,   -- Счет VOSTRO партнера у его банка-корресп
      SUMP_        number,     -- Сумма %%
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

         inp_deal_Ex (  CC_ID_       ,   -- N тикета/договора
                        nVidd_       ,   -- Вид договора
                        nTipd_       ,   -- Тип договора
                        nKV_         ,   -- Валюта
                        RNKB_        ,   -- Рег.№ партнера
                        DAT2_        ,   -- дата сделки
                        p_datv       ,   -- дата валютирования
                        DAT4_        ,   -- дата окончания
                        IR_          ,   -- индив ставка
                        OP_          ,   -- арифм.знак
                        BR_          ,   -- базовая ставки
                        SUM_         ,   -- Сумма сделки (в руб.)
                        nBASEY_      ,   -- % база
                        nIO_         ,   -- Начисление на входящий остаток 1-Да/0-Нет
                        S1_          ,   -- Осн.Счет для банка Б
                        S2_          ,   -- Код банка Б (mfo/bic) для осн.сч
                        S3_          ,   -- Счет нач.% для банка Б
                        S4_          ,   -- Код банка Б (mfo/bic) для сч нач.%
                        S5_          ,   -- Счет для входа валюты
                        NLSA_        ,   -- Основной счет в нашем банке
                        NMS_         ,   -- Наименование основного счета
                        NLSNA_       ,   -- Счет начисленных % в нашем банке
                        NMSN_        ,   -- Наименование счета начисленных %
                        NLSNB_       ,   -- Счет нач.% для банка Б = S3_
                        NMKB_        ,   -- Наименование клиента
                        Nazn_        ,   -- Назначение платежа (% по дог. CC_ID)
                        NLSZ_        ,   -- Счет обеспечения
                        nKVZ_        ,   -- Валюта обеспечения
                        p_pawn       ,   -- код вида обеспечения
                        Id_DCP_      ,   -- Id from dcp_p.id
                        S67_         ,   -- Счет доходов
                        nGrp_        ,   -- Группа доступа счетов
                        nIsp_        ,   -- Исполнитель
                        BICA_        ,   -- BIC нашего банка
                        SSLA_        ,   -- Счет VOSTRO у нашего банка-корреспонд
                        BICB_        ,   -- BIC партнера
                        SSLB_        ,   -- Счет VOSTRO партнера у его банка-корресп
                        SUMP_        ,   -- Сумма %%
                        AltB_        ,
                        IntermB_     ,
                        IntPartyA_   ,
                        IntPartyB_   ,
                        IntIntermA_  ,
                        IntIntermB_  ,
                        ND_          ,
                        ACC1_        ,
                        sErr_        ,
                        null         ,  null,  null, null, null );

      END inp_deal;
    ----------------------------------------------------------------------
    procedure set_field58d (p_nd number, p_field58d varchar2)    is
    begin      update cc_add set field_58d = p_field58d where nd = p_nd;    end set_field58d;
    ------------------------------------------------------------------
    --    Удаление сделки

    PROCEDURE del_deal    ( ND_              integer    ) is      -- удаление ош.введенной сделки
      DAT1_                 date;
      TIPD_                 integer;
      l_qty                 number(10);
      title       constant  varchar2(60) := 'mbk.del_deal';
    BEGIN
      select count(m.ND)    into l_qty     from MBD_K_R m     where m.ND = ND_     and exists ( select 1 from OPER o where o.REF = m.REF and o.SOS > 0 );
      if ( l_qty > 0 )   then      raise_application_error( -20666, 'По договору #' || to_char(ND_) || ' наявні оплачені документи!', TRUE );     end if;

      BEGIN
        select d.SDATE, v.TIPD   into DAT1_,TIPD_    from cc_deal d , cc_vidd v  where d.nd=ND_ and d.vidd=v.vidd ;
        for k in (select acc from nd_acc where nd=ND_)
        loop delete from int_ratn where acc=k.ACC and bdat >=DAT1_;
             update accounts SET mdate = null where acc=k.Acc  and acc not in (select acc from mbd_k where nd<>ND_) and ostc+ostb=0;   
        end loop;

        delete from mbd_k_r where nd=ND_     and ref in ( select ref from oper where sos<0 );
        DELETE FROM nd_acc  WHERE nd=ND_;
        DELETE FROM cc_add  WHERE nd=ND_;
        DELETE FROM cc_deal WHERE nd=ND_;
        DELETE FROM cc_docs WHERE nd=ND_;
        DELETE FROM cc_accp WHERE nd=ND_;

      EXCEPTION   WHEN NO_DATA_FOUND THEN null;
      END;

    END del_deal;

 ------------------------------------------------------------------
 --    Закрытие сделки
 --
    PROCEDURE clos_deal (ND_ integer, p_fl integer default 0 ) is
    p_nd   number:=0; l_txt  nd_txt.txt%type;
    p_sos  number;
    -- закрытие сделок на финише дня
    BEGIN
      for k in  -- проверка претендентов на закрытие (дата истекла, но не закрыты)
      (select d.ND, d.WDATE, v.TIPD, d.SOS ,p.accs,p.accp ,
              a.ostc ostcs,a.ostb ostbs,a.ostf ostfs,
       n.ostc ostcp,n.ostb ostbp,n.ostf ostfp,
       i.acr_dat,a.mdate mdate_a,n.mdate mdate_n
         from cc_deal D, cc_vidd V,cc_add p,accounts a,accounts n,int_accn i
        where (ND_=0 or d.nd=ND_) and d.nd=p.nd
          and d.vidd=v.vidd and ( v.custtype=1 or v.vidd in (2700,2701,3660) )
          and p.adds=0 and  p.accs=a.acc
          AND i.acc=a.acc AND i.acra=n.acc
         and d.sos<15 --and d.WDATE <= gl.BDATE
     )
      LOOP
        /* Готовы ли к закрытию по остаткам на SS SN и дате нач%?   */
        begin  -- определим максимальный номер договора, который обслуживают счета
          select max(nd) into p_nd from nd_acc  where acc in (k.accs,k.accp);
        EXCEPTION WHEN NO_DATA_FOUND THEN p_nd:=0;
        end; 
        if p_fl = 0 and k.WDATE <= gl.BDATE THEN
           if ( k.ostcs=0 and k.ostbs=0 and k.ostfs=0
            and k.ostcp=0 and k.ostbp=0 and k.ostfp=0
            and k.acr_dat+1>=k.wdate and k.mdate_a=k.wdate
            and k.mdate_a=k.mdate_n )
           then p_sos:=15;
           elsif   -- остатки ненулевые, но счета обслуживают уже новую сделку (возможно Ролловер)
              ( k.ostcs<>0 or k.ostbs<>0 or k.ostfs<>0
             or k.ostcp<>0 or k.ostbp<>0 or k.ostfp<>0 )
            and k.nd <p_nd and k.mdate_a=k.mdate_n and k.mdate_a>k.wdate
           then p_sos:=15;
           else p_sos:=k.sos;
           end if;
        else 
           if k.nd >= p_nd THEN
              if k.ostcs<>0 or k.ostbs<>0 or k.ostfs<>0 or k.ostcp<>0 or k.ostbp<>0 or k.ostfp<>0 THEN
                 l_txt := 'Неможливо перенести в архів! Існує залишок!';   raise_application_error( -20555, l_txt ); 
                 --l_TXT := cck_app.Get_ND_TXT (k.ND,'CL_ERR'); 
                 --cck_app.Set_ND_TXT (k.nd, 'CL_ERR', l_txt || ' є залишок /' );
              elsif  k.acr_dat+1 < k.wdate THEN
                 l_TXT := cck_app.Get_ND_TXT (k.ND,'CL_ERR'); 
                 cck_app.Set_ND_TXT (k.nd, 'CL_ERR', l_txt || ' дата нарахов.% < дати закін.дог./' );
              elsif k.mdate_a <> k.wdate THEN
                 l_TXT := cck_app.Get_ND_TXT (k.ND,'CL_ERR'); 
                 cck_app.Set_ND_TXT (k.nd, 'CL_ERR', l_txt || ' дата закін.дії рах.тіла<>даті закін.дог./' );
              elsif k.mdate_a <> k.mdate_n  THEN
                 l_TXT := cck_app.Get_ND_TXT (k.ND,'CL_ERR'); 
                 cck_app.Set_ND_TXT (k.nd, 'CL_ERR', l_txt || ' дата закін.дії рах.%<>дата закін.дії рах.тіла/' );
              end if;
           else
              if k.mdate_a <= k.wdate THEN
                 l_TXT := cck_app.Get_ND_TXT (k.ND,'CL_ERR'); 
                 cck_app.Set_ND_TXT (k.nd, 'CL_ERR', l_txt || ' дата закін.дії рах.тіла<=даті закін.дог./' );
              elsif k.mdate_a<>k.mdate_n  THEN
                 l_TXT := cck_app.Get_ND_TXT (k.ND,'CL_ERR'); 
                 cck_app.Set_ND_TXT (k.nd, 'CL_ERR', l_txt || ' дата закін.дії рах.%<>даті закін.дог./' );
              end if;
           end if;
           p_sos:=15;
        end if;
        update cc_deal set SOS=p_sos where nd=k.ND;
        -- отвязываем счета залога
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
    PROCEDURE back_deal (ND_ integer ) is
    begin
       update cc_deal set SOS = 10 where nd = ND_;
       cck_app.Set_ND_TXT (nd_, 'CL_ERR', 'Угода повернута в ПОРТФЕЛЬ:'||sysdate );
    end;
------------------------------------------------------------------
--    откат сегодняшней сделки Ролловер
--
PROCEDURE del_Ro_deal (ND_ integer ) IS  ---    откат сегодняшней сделки Ролловер
      Ref_      number ;
      Ref1_     number := 0; 
      Ref2_     number := 0;
      Tipd_     number ;
      ND_Old_   number ;
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
   SELECT sdate    INTO Dat1_   FROM cc_deal WHERE nd=ND_ ;
   IF SDate_ <> gl.bdate  THEN   erm := 'Невозможно откатить HEсегодняшнюю сделку RollOver!';   raise_application_error( -20666, erm );     END IF;

   begin   select t.tipd into tipd_      from cc_vidd t, cc_deal c      where c.nd=ND_   and c.vidd=t.vidd;
   EXCEPTION  WHEN NO_DATA_FOUND THEN    erm := 'Не определен вид договора или договора нет в системе';    raise_application_error( -20666, erm ); 
   end;

   -- ND сделки, исходной для Ролловер (предыдущей)   -- Откат переброски по Ролл
   -- 1. референс документа Ролл текущей сделки
   SELECT nvl(min(m.ref),0)    INTO Ref2_    FROM mbd_k_r m, oper p    WHERE m.nd=ND_ AND m.ref=p.ref AND p.tt='KV1'       AND upper(p.nazn) like '%ROLLOVER%' ;
   IF  Ref2_=0  THEN   erm := 'Не нашли Реф. документа Ролловер текущей сделки';     raise_application_error( -20666, erm ); end if ;  

   begin   select to_number(value) into ND_Old_    from operw where ref=Ref2_ and tag='MBKND';
   EXCEPTION WHEN NO_DATA_FOUND THEN   erm := 'Отсутствует  допреквизит MBKND для реф.'||Ref2_; raise_application_error( -20666, erm ); 
   end;

   -- 2. Максимальный Ref документа Ролл предыдущ. сделки (если несколько Ролл по старым версиям)
   SELECT nvl(max(m.ref),0)    INTO Ref1_   FROM mbd_k_r m, oper p   WHERE m.nd=ND_Old_ AND m.ref=p.ref AND p.tt='KV1'    AND upper(p.nazn) like '%ROLLOVER%' ;
   IF Ref1_=0   THEN    erm := 'Не нашли Реф. документа Ролловер предыдущей сделки';     raise_application_error( -20666, erm );    END IF;

   -- Проверка на межбанковские платежи
   select count(1)  into l_qty  from ARC_RRP  where ref in ( select ref from MBD_K_R where ND = ND_);
   if ( l_qty > 0 )   then   erm := 'По договору ' || to_char(ND_) || ' сформированы межбанковские платежи!'; raise_application_error( -20666, erm );    end if;

   -- 3.откат всех документов, которые были по новой сделке, кроме документа Ролловер
   FOR k IN ( SELECT m.ref ref FROM mbd_k_r m, oper p      WHERE m.nd=ND_ AND m.ref=p.ref and p.ref<> Ref2_ AND p.sos>0      ORDER BY m.ref desc )
   LOOP
      p_back_dok(k.ref,5,null,par2_,par3_,1);
      update operw set value='RollOver. Отказ от визы'  where ref=k.ref and tag='BACKR';
   END LOOP;

   -- 4. собственно откат KV1-Ролловер
   -- 4.1 сначала вернем на транзит ( Активный по плану счетов )
   if tipd_=1 then ref_:=Ref2_; else ref_:=Ref1_; end if;
   if Ref2_<>0 then   -- удаляем  документ KV1, если он есть (могли снять с визы)
      p_back_dok(ref_,5,null,par2_,par3_,1);
      update operw set value='RollOver. Отказ от визы' where ref=ref_ and tag='BACKR';
   end if;
   -- 4.2 затем вернем на счет договора
   if tipd_=1 then ref_:=Ref1_; else ref_:=Ref2_; end if;
   if Ref1_<>0 then -- удаляем документ KV1, если он есть (могли снять с визы)
      p_back_dok(ref_,5,null,par2_,par3_,1);
      update operw set value='RollOver. Отказ от визы' where ref=ref_ and tag='BACKR';
   end if;
   -- SDate, WDate предыдущ. сделки
   BEGIN      SELECT sdate, wdate INTO SDate_, WDate_ FROM cc_deal WHERE nd=ND_Old_ ;
   EXCEPTION WHEN NO_DATA_FOUND THEN        erm := 'Не нашли даты предыдущ. сделки' ;        raise_application_error( -20666, erm ); 
   END;

   FOR k IN (SELECT acc FROM nd_acc WHERE nd=ND_)
   LOOP DELETE FROM int_ratn WHERE acc=k.ACC AND bdat>=Dat1_ AND bdat>SDate_ ;
        UPDATE accounts SET mdate=WDate_ WHERE acc=k.Acc and acc not in (select acc from mbd_k where nd<>ND_) and ostc+ostb<>0;    -- если счет обслуживает 2 сделки или ненулевые остатки по счету
        UPDATE int_accn SET stp_dat=WDate_-1 WHERE acc=k.Acc ;
   END LOOP;

    DELETE FROM mbd_k_r WHERE nd=ND_;
    DELETE FROM mbd_k_r WHERE nd=ND_Old_ AND ref in (Ref1_,Ref2_);   -- один из Ref1_,Ref2_ принадлежит "старой сделке"
    DELETE FROM nd_acc  WHERE nd=ND_;
    DELETE FROM cc_add  WHERE nd=ND_;
    DELETE FROM cc_prol WHERE nd=ND_;
    DELETE FROM cc_docs WHERE nd=ND_;
    DELETE FROM cc_deal WHERE nd=ND_;

END del_Ro_deal;

------------------------------------------------------------------
    --    функция возвращает назначение платежа
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

       begin execute immediate 'select   nvl(acc,0) from   mbd_k_fi   where   ND='||ND_    into acc_fi;
       exception when no_data_found       then acc_fi:=0;
       end;

      if acc_fi<>0 then
         BEGIN  -- надра фининституты
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
        sTmp_ := '';    -- если не установить  - дублирует иногда подстановки

        BEGIN  SELECT sqlval INTO SqlVal_ FROM mbk_descr WHERE id=sPar_ ;
               SqlVal_ := Replace(SqlVal_, ':ND', to_char(ND_)) ;
               OPEN refcur FOR SqlVal_ ;   FETCH refcur INTO sTmp_;     CLOSE refcur;
        EXCEPTION WHEN NO_DATA_FOUND THEN    sTmp_ := '' ;
        END;
        sNazn_ := Replace(sNazn_, '#'||sPar_||'#', sTmp_) ;
        sStr_  := sNazn_ ;
        n_     := InStr(sStr_,'#') ;
      END LOOP;

      RETURN sNazn_ ;

    END F_GetNazn;
----------------------------------------------------------------------
--    Процедура определяет списки переменных и их значений для печати тикета сделки
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
                    from ( select par from tickets_par  where upper(rep_prefix) = upper(p_tic_name)    and mod_code = 'MBK'      union 
                           select par from tickets_par  where upper(rep_prefix) = upper('DEFAULT')     and mod_code = 'MBK' 
                         ) a, 
                         tickets_par b
                    where a.par = b.par(+)    and upper(b.rep_prefix(+)) = upper(p_tic_name) 
                  ) a, 
                 tickets_par b
             where upper(a.rep_prefix) = upper(b.rep_prefix)    and a.par = b.par and b.txt is not null 
            )
  loop
     l_sql := replace( k.txt, ':ND', to_char(p_nd) ) ;
     execute immediate l_sql into l_value;
     p_vars := p_vars || k.par   || '~' ;
     p_vals := p_vals || l_value || '~' ;
  end loop;

end get_print_value;
 ------------------------------------------------------------------
    --    Процедура сохраняет информацию о трассе и посреднике
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
        p_nls        in cc_swtrace.nls%type )    is
    begin
        update cc_swtrace set swo_bic = p_swoBic, swo_acc = p_swoAcc, swo_alt = p_swoAlt, interm_b= p_intermb, field_58d = p_field58d, nls = p_nls  where rnk = p_custCode and kv = p_currCode;
        if sql%rowcount = 0 then
            insert into cc_swtrace (rnk, kv, swo_bic, swo_acc, swo_alt, interm_b, field_58d, nls)
                     values (p_custCode, p_currCode, p_swoBic, p_swoAcc, p_swoAlt, p_intermb, p_field58d, p_nls);
        end if;
    end save_partner_trace;
 ----------------------------------------------------------------------
    --    Процедура отвязки залога ДЦП
    procedure unlink_dcp(p_nd number)    is      l_pawn  varchar2(30);
    begin
      select substr(trim(n.txt),1,30) into l_pawn        from nd_txt n, cc_pawn c     where n.nd = p_nd and n.tag = 'PAWN'     and substr(trim(n.txt),1,30) = to_char(c.pawn) and c.code = 'DCP';
      update dcp_p set ref = null, acc = null where ref = - p_nd;
      delete from nd_txt where nd = p_nd and tag = 'PAWN';
    exception when no_data_found then null;
    end unlink_dcp;

----------------------------------------------------------------------
    --    Процедура привязки договоров
    procedure link_deal (p_nd number, p_ndi number)    is
    begin      update cc_deal set ndi = p_ndi where nd = p_nd;    end link_deal;
 ----------------------------
    function get_deal_param (      p_nd    nd_txt.nd%type,      p_tag   nd_txt.tag%type) return varchar2    is      l_val   nd_txt.txt%type;
    begin
      begin   select txt into l_val from nd_txt where nd = p_nd and tag = p_tag;
      exception when no_data_found then l_val := null;
      end;
      return l_val;
    end;
-------------------------------------------------------
    procedure set_deal_param
    ( p_nd    nd_txt.nd%type,
      p_tag   nd_txt.tag%type,
      p_val   nd_txt.txt%type
    ) is
    begin

      if p_val is not null      then
          update nd_txt             set txt = p_val           where nd  = p_nd             and tag = p_tag;
          if ( sql%rowcount = 0 )          then            insert into nd_txt(nd, tag, txt)            values ( p_nd, p_tag, p_val );         end if;
      else delete from nd_txt    where nd = p_nd and tag = p_tag;
      end if;

    end;
 -------------------------------------------------------
function estimate_interest_amount(
        p_product_id in integer,
        p_deal_start_date in date,
        p_deal_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_base in number,
        p_interest_rate in number)
    return number    is  
        MM MBDK_ob22%rowtype;
        l_date_from   date := p_deal_start_date;
        l_date_through date := p_deal_expiry_date - 1; -- в останній день угоди відсотки не нараховуються, в цей день угода вже не працює (може відрізнятися для інших банків)
begin 
   MM := MBK.Get_MBDK (p_Vidd => p_product_id ); 
   if MM.IO = interest_utl.BALANCE_KIND_BANK_DATE_IN   then   l_date_from := l_date_from + 1;    end if;

   return currency_utl.from_fractional_units(
              round(calp_nr(currency_utl.to_fractional_units(p_amount, p_currency_id),
                      p_interest_rate,
                      l_date_from,
                      l_date_through,
                      p_interest_base), 0),
              p_currency_id) ;
end estimate_interest_amount ;
-------------------------------

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
                raise_application_error(-20000, 'Клієнт з ідентифікатором {' ||
                                                tools.number_list_to_string(l_mismatch_list, p_splitting_symbol => ', ', p_ceiling_length => 100) ||
                                                '} не існує або закритий');
            end if;
        end if;

        select d.nd     bulk collect into l_deals
        from   cc_deal d
        join   cc_add dd on dd.nd = d.nd
        where  check_if_deal_belong_to_mbdk(d.vidd) = 'Y' and
               (l_products is null or l_products is empty or d.vidd in (select column_value from table(l_products))) and
               (l_partners is null or l_partners is empty or d.rnk in (select column_value from table(l_partners))) and
               (l_currencies is null or l_currencies is empty or dd.kv in (select column_value from table(l_currencies))) and
               d.sos <> 15;

        tools.hide_hint(interest_utl.prepare_deal_interest(l_deals, l_date_to));
    end;
    -------------------------------------------------------
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
            raise_application_error(-20000, 'Угода ' || l_cc_deal_row.cc_id ||
                                            ' від ' || to_char(l_cc_deal_row.sdate, 'dd.mm.yyyy') ||
                                            ' не належить до угод МБДК');
        end if;

        if (l_cc_deal_row.sos = 15) then
            raise_application_error(-20000, 'Угода ' || l_cc_deal_row.cc_id ||
                                            ' від ' || to_char(l_cc_deal_row.sdate, 'dd.mm.yyyy') ||
                                            ' закрита');
        end if;

        if (l_date_to < l_cc_add_row.bdate) then
            raise_application_error(-20000, 'Дата завершення періоду нарахування відсотків {' || to_char(l_date_to, 'dd.mm.yyyy') ||
                                            '} не може бути меньшою за дату початку дії угоди {' || to_char(l_cc_add_row.bdate, 'dd.mm.yyyy') || '}');
        end if;

        tools.hide_hint(interest_utl.prepare_deal_interest(number_list(p_deal_id), l_date_to));
    end;
    -------------------------------------------------------
    procedure pay_accrued_interest
    is
    begin
        bars_audit.trace('mbk.pay_accrued_interest' || chr(10) ||
                         'sys_context(''bars_pul'', ''reckoning_id'') : ' || sys_context('bars_pul', 'reckoning_id'));

        interest_utl.pay_accrued_interest(p_do_not_store_interest_tails => true);
    end;
    -------------------------------------------------------
    procedure pay_selected_interest(    p_id in integer)  is
          l_int_reckoning_row int_reckoning%rowtype;
    begin l_int_reckoning_row := interest_utl.lock_reckoning_row(p_id, p_skip_locked => true);
        if (l_int_reckoning_row.id is not null) then      interest_utl.pay_int_reckoning_row(l_int_reckoning_row, p_silent_mode => true, p_do_not_store_interest_tails => true);     end if;
    end;
    -------------------------------------------------------
    procedure remove_selected_reckoning(   p_id in integer)  is
    begin   interest_utl.remove_reckoning(p_id);   end;
    ------------------------------------------
    procedure edit_selected_reckoning(
        p_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2)
    is
        l_int_reckoning_row int_reckoning%rowtype;
        l_account_row accounts%rowtype;
    begin
        l_int_reckoning_row := interest_utl.lock_reckoning_row(p_id, p_skip_locked => false);
        l_account_row := account_utl.read_account(l_int_reckoning_row.account_id);
        interest_utl.edit_reckoning_row(p_id, currency_utl.to_fractional_units(p_interest_amount, l_account_row.kv), p_purpose);
    end;
    --------------------------------------------
    function get_sending_transaction_code(
        p_deal_kind_id in integer,
        p_debit_account in varchar2,
        p_interest_account_number in varchar2)
    return varchar2    is
    begin
        return case when (p_debit_account = p_interest_account_number and p_deal_kind_id > 1600) then '8444018' -- % за МБД
                    when (p_deal_kind_id = 1510)                           then '8444013' -- розмiщення депозиту-овернайт в банку-резид
                    when (p_deal_kind_id > 1510 and p_deal_kind_id < 1515) then '8444005' -- розмiщення МБД в банку-резидентi
                    when (p_deal_kind_id = 1521)                           then '8444009' -- надання кредиту-овернайт банку-резиденту
                    when (p_deal_kind_id > 1521 and p_deal_kind_id < 1525) then '8444001' -- надання МБК банку-резиденту
                    when (p_deal_kind_id = 1610)                           then '8444016' -- повернення депозиту-овернайт до банку-рези
                    when (p_deal_kind_id > 1610 and p_deal_kind_id < 1615) then '8444008' -- повернення МБД до банку-резидента
                    when (p_deal_kind_id = 1621)                           then '8444012' -- повернення кредиту-овернайт до банку-резид
                    when (p_deal_kind_id > 1621 and p_deal_kind_id < 1625) then '8444004' -- повернення МБК до банку-резидента
                    else null
               end;
    end;
    ------------------------------------------
    function get_receiving_transaction_code(
        p_deal_kind_id in integer,
        p_debit_account in varchar2,
        p_interest_account_number in varchar2)
    return varchar2    is
    begin
        return case when (p_debit_account = p_interest_account_number and p_deal_kind_id < 1600) then '8444017' -- % за МБК
                    when (p_deal_kind_id = 1510)                           then '8444014' -- повернення депозиту-овернайт вiд банку-рез
                    when (p_deal_kind_id > 1510 and p_deal_kind_id < 1515) then '8444006' -- повернення МБД вiд банку-резидента
                    when (p_deal_kind_id = 1521)                           then '8444010' -- повернення кредиту-овернайт вiд банку-рези
                    when (p_deal_kind_id > 1521 and p_deal_kind_id < 1525) then '8444002' -- повернення МБК вiд банку-резидента
                    when (p_deal_kind_id = 1610)                           then '8444015' -- залучення депозиту-овернайт вiд банку-рези
                    when (p_deal_kind_id > 1610 and p_deal_kind_id < 1615) then '8444007' -- залучення МБД вiд банку-резидента
                    when (p_deal_kind_id = 1621)                           then '8444011' -- отримання кредиту-овернайт вiд банку-резид
                    when (p_deal_kind_id > 1621 and p_deal_kind_id < 1625) then '8444003' -- отримання МБК вiд банку-резидента
                    else null
               end;
    end;
    ------------------------------------
    function read_document(        p_document_id in integer,        p_raise_ndf in boolean default true)    return oper%rowtype    is
        l_document_row oper%rowtype;
    begin select *        into   l_document_row        from   oper t        where  t.ref = p_document_id;
        return l_document_row;
    exception  when no_data_found then
             if (p_raise_ndf) then    raise_application_error(-20000, 'Документ з ідентифікатором {' || p_document_id || '} не знайдений');
             else return null;
             end if;
    end;
    --------------------------------------------------------------
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
    ------------------------------------------------------
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
    ---------------------------------------------------------------------
    function make_docinput(     p_nd in integer)    return cdb_mediator.t_make_document_urls    pipelined    is
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

        l_deal_amount              number; -- сума угоди приведена до центів/копійок і т.п. для порівняння з залишками рахунків
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

        -- розміщення
        if (l_cc_vidd_row.tipd = 1) then

            -- розміщення основної суми
            l_operation_item := null;
            -- від'ємний залишок рахунку додається до додатньої суми угоди, т.ч. отримуємо величину, на яку сума угоди перевищує залишок рахунку, і на яку можна виконати розміщення
            l_document_amount := greatest(l_deal_amount + l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := 'Розміщення основної суми';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_cc_add_row.kv;

            If (l_document_amount > 0 and          -- плановий залишок на поточну банківську дату (за виключенням майбутнього залишку) меньший за суму угоди
                l_cc_deal_row.wdate > gl.bd() and  -- угода не просрочена
                l_cc_add_row.wdate <= gl.bd() and  -- дата виплати настала
                l_cc_deal_row.vidd <> 1526) then   -- пропускаємо "Неамортизований дисконт за кредитами"

                l_operation_item.purpose := 'Різниця між сумою угоди ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' та плановим залишком рахунку ' ||
                                            to_char(currency_utl.from_fractional_units(abs(l_main_account_row.ostb), l_main_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                             ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Очікується розміщення на суму різниці';

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
                                                              'Виконати',
                                                              'vob', 1, -- розміщення гривні платежем через СЕП
                                                              'nls_a', l_main_account_row.nls,
                                                              'nls_b', l_cc_add_row.acckred,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_a', gl.aMFO,
                                                              'mfo_b', l_cc_add_row.mfokred,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('RO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_п', l_additional_requisites,
                                                              'flag_se', '1',
                                                              -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
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
                                                              'Виконати',
                                                              'vob', 6, -- розміщення валюти завжди через транзитний рахунок меморіальним ордером
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
                                                              -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal(' || l_cc_deal_row.nd || ', gl.aref);');
                end if;
            else
                l_operation_item.purpose := 'Сума угоди ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' меньша або дорівнює плановому залишку рахунку ' ||
                                            to_char(currency_utl.from_fractional_units(abs(l_main_account_row.ostb), l_main_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Немає потреби в розміщенні коштів';
            end if;

            pipe row (l_operation_item);

            -- прийняття погашення основної суми (розкриття дебіторської заборгованості)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_main_account_row.kv);
            l_document_amount := greatest(-l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := 'Погашення основної суми (розкриття дебіторської заборгованості)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := 'Розміщення суми угоди виконано - плановий залишок рахунку складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Може бути виконано погашення основної суми';
                l_operation_item.url := make_docinput_url('KV1',
                                                          'Виконати',
                                                          'dk', '1',
                                                          'nls_a', l_transit_account_row.nls,
                                                          'nls_b', l_main_account_row.nls,
                                                          'nam_a', substr(l_transit_account_row.nms, 1, 38),
                                                          'nam_b', substr(l_main_account_row.nms, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'kv_a', l_main_account_row.kv,
                                                          'nazn', substr(f_getnazn('RP', l_cc_deal_row.nd), 1, 160),
                                                          'flag_se', '1',
                                                          -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                          'APROC', 'begin null; end;@mbk.open_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');');

            else
                l_operation_item.purpose := 'Сума розмішених коштів складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Немає потреби в погашенні основної суми';
            end if;

            pipe row (l_operation_item);

            -- прийняття погашення відсотків (розкриття дебіторської заборгованості)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_interest_account_row.kv);
            l_document_amount := greatest(-l_interest_account_row.ostb, 0);

            l_operation_item.operation_type_name := 'Погашення відсотків (розкриття дебіторської заборгованості)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := 'Сума нарахованих відсотків складає ' ||
                                            to_char(currency_utl.from_fractional_units(-l_interest_account_row.ostb, l_interest_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>Очікуємо на погашення даної суми';

                l_operation_item.url := make_docinput_url('KV1',
                                                          'Виконати',
                                                          'dk', '1',
                                                          'nls_a', l_transit_account_row.nls,
                                                          'nls_b', l_interest_account_row.nls,
                                                          'nam_a', substr(l_transit_account_row.nms, 1, 38),
                                                          'nam_b', substr(l_interest_account_row.nms, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'kv_a', l_interest_account_row.kv,
                                                          'nazn', substr(f_getnazn('RPP', l_cc_deal_row.nd), 1, 160),
                                                          'flag_se', '1',
                                                          -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                          'APROC', 'begin null; end;@mbk.open_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''N'');');

            else
                l_operation_item.purpose := 'Сума нарахованих відсотків складає ' ||
                                             to_char(currency_utl.from_fractional_units(l_operation_item.amount, l_interest_account_row.kv), l_money_format) ||
                                             ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                             '<br>Немає потреби в погашенні відсотків';
            end if;

            pipe row (l_operation_item);

            -- закриття дебіторської заборгованості (основна сума)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_main_account_row.kv);
            l_document_amount := nvl(attribute_utl.get_number_value(l_cc_deal_row.nd, mbk.ATTR_AWAITING_MAIN_AMOUNT), 0);

            l_operation_item.operation_type_name := 'Закриття дебіторської заборгованості (основна сума)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := 'Розкрита дебіторська заборгованість на суму ' || to_char(l_operation_item.amount, l_money_format) || ' ' ||
                                            currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Очікується закриття дебіторської заборгованості';
                l_operation_item.url := make_docinput_url('WD1',
                                                          'Виконати',
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
                                                          -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                          'APROC', 'begin null; end;@mbk.close_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');' );
            else
                l_operation_item.purpose := 'Дебіторська заборгованість по основній сумі не розкрита<br>Немає потреби в закритті дебіторської заборгованості';
            end if;

            pipe row (l_operation_item);

            -- закриття дебіторської заборгованості (сума відсотків)
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_interest_account_row.kv);
            l_document_amount := nvl(attribute_utl.get_number_value(l_cc_deal_row.nd, mbk.ATTR_AWAITING_INTEREST_AMOUNT), 0);

            l_operation_item.operation_type_name := 'Закриття дебіторської заборгованості (сума відсотків)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := 'Розкрита дебіторська заборгованість за відсотками на суму ' || to_char(l_operation_item.amount, l_money_format) || ' ' ||
                                            currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>Очікується закриття дебіторської заборгованості';
                l_operation_item.url := make_docinput_url('WD1',
                                                          'Виконати',
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
                                                          -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                          'APROC', 'begin null; end;@mbk.close_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''N'');' );
            else
                l_operation_item.purpose := 'Дебіторська заборгованість для суми відсотків не розкрита<br>Немає потреби в закритті дебіторської заборгованості';
            end if;

            pipe row (l_operation_item);
        else
            -- залучення
            l_operation_item := null;

            l_transit_account_row := account_utl.read_account(l_transit_account_number, l_main_account_row.kv);
            l_document_amount := l_deal_amount - greatest(l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := 'Залучення основної суми (розкрити дебіторську заборгованість)';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0 and            -- плановий залишок рахунку меньший за суму угоди
                l_cc_deal_row.wdate > gl.bd() and    -- угода не просрочена
                l_cc_add_row.wdate <= gl.bd()) then  -- дата виплати настала


                l_operation_item.purpose := 'Різниця між сумою угоди ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' та чистим плановим залишком рахунку ' ||
                                            to_char(currency_utl.from_fractional_units(l_main_account_row.ostb, l_main_account_row.kv), l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            ' складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                             ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Очікується залучення на суму різниці';

                l_operation_item.url := make_docinput_url('KV1',
                                                          'Виконати',
                                                          'dk', '1',
                                                          'nls_a', l_transit_account_row.nls,
                                                          'nls_b', l_main_account_row.nls,
                                                          'nam_a', substr(l_transit_account_row.nms, 1, 38),
                                                          'nam_b', substr(l_main_account_row.nms, 1, 38),
                                                          'sumc_t', l_document_amount,
                                                          'kv_a', l_main_account_row.kv,
                                                          'nazn', substr(f_getnazn('PP', l_cc_deal_row.nd), 1, 160),
                                                          'flag_se', '1',
                                                          -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                          'APROC', 'begin null; end;@mbk.open_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');');

            else
                if (l_cc_deal_row.wdate <= gl.bd()) then
                    l_operation_item.purpose := 'Дата завершення дії угоди ' || to_char(l_cc_deal_row.wdate, 'dd.mm.yyyy') || ' досягнута' ||
                                                '<br>Залучення коштів проводитись не може';
                elsif (l_cc_add_row.wdate > gl.bd()) then
                    l_operation_item.purpose := 'Дата початку дії угоди ' || to_char(l_cc_deal_row.wdate, 'dd.mm.yyyy') || ' ще не досягнута' ||
                                                '<br>Залучення коштів проводитись не може';
                elsif (l_document_amount <= 0) then
                    l_operation_item.purpose := 'Сума угоди ' || to_char(l_cc_add_row.s, l_money_format) || ' ' || currency_utl.get_currency_lcv(l_cc_add_row.kv) ||
                                                ' меньша або дорівнює плановому залишку рахунку ' ||
                                                to_char(currency_utl.from_fractional_units(l_main_account_row.ostb, l_main_account_row.kv), l_money_format) ||
                                                ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                                '<br>Немає потреби в розміщенні коштів';
                end if;
            end if;

            pipe row (l_operation_item);

            -- закриття дебіторської заборгованості (основна сума)
            l_operation_item := null;

            l_document_amount := nvl(attribute_utl.get_number_value(l_cc_deal_row.nd, mbk.ATTR_AWAITING_MAIN_AMOUNT), 0);

            l_operation_item.operation_type_name := 'Закриття дебіторської заборгованості';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := 'Розкрита дебіторська заборгованість на суму ' || to_char(l_operation_item.amount, l_money_format) || ' ' ||
                                            currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Очікується закриття дебіторської заборгованості';
                l_operation_item.url := make_docinput_url('WD1',
                                                          'Виконати',
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
                                                          -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                          'APROC', 'begin null; end;@mbk.close_awaiting_amount(' || l_cc_deal_row.nd || ', gl.aref, ''Y'');' );
            else
                l_operation_item.purpose := 'Дебіторська заборгованість по основній сумі не розкрита<br>Немає потреби в закритті дебіторської заборгованості';
            end if;

            pipe row (l_operation_item);

            -- повернення залученої суми
            l_operation_item := null;

            l_document_amount := greatest(l_main_account_row.ostb, 0);

            l_operation_item.operation_type_name := 'Повернення залученої суми';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_main_account_row.kv);
            l_operation_item.currency_code := l_main_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := 'Плановий залишок рахунку залученої суми складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>Може бути виконано повернення суми кредитору';
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
                                                              'Виконати',
                                                              'vob', 1, -- повернення гривні платежем через СЕП
                                                              'nls_a', l_main_account_row.nls,
                                                              'nls_b', l_cc_add_row.acckred,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_b', l_cc_add_row.mfokred,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('PO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_п', l_additional_requisites,
                                                              'flag_se', '1',
                                                              -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
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
                                                              'Виконати',
                                                              'vob', 6, -- відправка валюти завжди через транзитний рахунок меморіальним ордером
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
                                                              -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal(' || l_cc_deal_row.nd || ', gl.aref);');
                end if;
            else
                l_operation_item.purpose := 'Сума залучених коштів складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_main_account_row.kv) ||
                                            '<br>Немає потреби в погашенні основної суми';
            end if;

            pipe row (l_operation_item);

            -- виплата нарахованих відсотків
            l_operation_item := null;

            l_document_amount := greatest(l_interest_account_row.ostb, 0);

            l_operation_item.operation_type_name := 'Виплата нарахованих відсотків';
            l_operation_item.amount := currency_utl.from_fractional_units(l_document_amount, l_interest_account_row.kv);
            l_operation_item.currency_code := l_interest_account_row.kv;

            if (l_document_amount > 0) then
                l_operation_item.purpose := 'Сума нарахованих відсотків складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>Дана сума може бути виплачена кредитору';

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
                                                              'Виконати',
                                                              'vob', 1, -- відправка гривні платежем через СЕП
                                                              'nls_a', l_interest_account_row.nls,
                                                              'nls_b', l_cc_add_row.accperc,
                                                              'nam_b', substr(l_customer_row.nmk, 1, 38),
                                                              'mfo_b', l_cc_add_row.mfoperc,
                                                              'id_b', l_customer_row.okpo,
                                                              'sumc_t', l_document_amount,
                                                              'kv_a', l_main_account_row.kv,
                                                              'nazn', substr(f_getnazn('PPO', l_cc_deal_row.nd), 1, 160),
                                                              'reqv_п', l_additional_requisites,
                                                              'flag_se', '1',
                                                              -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
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
                                                              'Виконати',
                                                              'vob', 6, -- відправка валюти завжди через транзитний рахунок меморіальним ордером
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
                                                              -- обов'язкове використання верхнього регістру для назви параметра з процедурою, що викликається після створення документа
                                                              'APROC', 'begin null; end;@cck_utl.link_document_to_deal(' || l_cc_deal_row.nd || ', gl.aref);');
                end if;
            else
                l_operation_item.purpose := 'Сума нарахованих відсотків складає ' ||
                                            to_char(l_operation_item.amount, l_money_format) ||
                                            ' ' || currency_utl.get_currency_lcv(l_interest_account_row.kv) ||
                                            '<br>Немає потреби в погашенні основної суми';
            end if;

            pipe row (l_operation_item);
        end if;

        l_operation_item := null;
        l_operation_item.operation_type_name := 'Нарахування відсотків';

        if (l_int_accn_row.acr_dat is null or l_int_accn_row.acr_dat < l_int_accn_row.stp_dat) then
            l_operation_item.purpose := 'Дата останнього нарахування відсотків: <b>' || to_char(l_int_accn_row.acr_dat, 'dd.mm.yyyy') ||
                                        '</b><br>Дата завершення нарахування відсотків: <b>' || to_char(l_int_accn_row.stp_dat, 'dd.mm.yyyy');
            l_operation_item.url            := '<a href="'||
                                             '/barsroot/ndi/referencebook/GetRefBookData/?nsiTableId='|| bars_metabase.get_tabid('INT_HELP') ||chr(38)||'nsiFuncId=1'||
                                             '">Виконати нарахування</a>';
            pul.set_mas_ini('nd', l_cc_deal_row.nd, null);
        else
            l_operation_item.purpose := 'Дата останнього нарахування відсотків: <b>' || to_char(l_int_accn_row.acr_dat, 'dd.mm.yyyy') ||
                                        '</b><br>Дата завершення нарахування відсотків: <b>' || to_char(l_int_accn_row.stp_dat, 'dd.mm.yyyy') ||
                                        '</b><br>Відсотки нараховані до кінця періоду';
        end if;

        pipe row (l_operation_item);
    end;
   ------------------------------------
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
                  p_nazn   => 'Оприбуткування застави згідно договору № ' || p_pawn_contract_number || ' від ' || to_char(p_start_date) ||
                              ' для угоди ' || l_deal_row.cc_id || ' від ' || to_char(l_deal_row.sdate, 'dd.mm.yyyy'));
    end;
    ----------------------------------------------
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
        begin insert into otcn_lim_sb   values (l_account_row.acc, p_limit_date, p_limit_amount, sys_context('bars_context', 'user_mfo'));
        exception  when dup_val_on_index then
            raise_application_error(-20000, 'Значення ліміту для рахунку {' || p_account_number || '} на дату {' || to_char(p_limit_date, 'dd.mm.yyyy') || '} вже вказано');
        end;
    end;
    ---------------------------------------------
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
            raise_application_error(-20000, 'Неможливо ідентифікувати рядок для оновлення даних');
        else
            l_key_account_id := l_key_values(1);
            l_key_date := to_date(l_key_values(2), 'ddmmyyyy');
        end if;

        l_key_account_row := account_utl.read_account(l_key_account_id);

        update otcn_lim_sb t
        set    t.lim = p_limit_amount,
               t.acc = l_new_account_row.acc,
               t.fdat = p_limit_date
        where  t.acc = l_key_account_row.acc and  t.fdat = l_key_date;
    end;
   -----------------------------------------------------------
   procedure delete_lim_sb(     p_uk_value in varchar2)    is
        l_key_account_row accounts%rowtype;
        l_key_account_id integer;
        l_key_date date;
        l_key_values string_list;
    begin
        bars_audit.trace('mbk.delete_lim_sb' || chr(10) ||        'p_uk_value : ' || p_uk_value);

        l_key_values := tools.string_to_words(p_uk_value, p_splitting_symbol => ';', p_trim_words => 'Y', p_ignore_nulls => 'Y');
        if (l_key_values is null or l_key_values.count <> 2) then
            raise_application_error(-20000, 'Неможливо ідентифікувати рядок для видалення');
        else
            l_key_account_id := l_key_values(1);
            l_key_date := to_date(l_key_values(2), 'ddmmyyyy');
        end if;

        l_key_account_row := account_utl.read_account(l_key_account_id);
        delete otcn_lim_sb t     where  t.acc = l_key_account_row.acc and          t.fdat = l_key_date;
    end;
    -------------------------
    function check_if_42_visa_should_apply(        p_nostro_document_id in integer)    return integer    is
        l_original_document_id integer;
        l_original_document_row oper%rowtype;
    begin
        select to_number(t.value)   into   l_original_document_id  from   operw t  where  t.ref = p_nostro_document_id and   t.tag = 'NOS_R' and   regexp_like(t.value, '^\d*$');
        l_original_document_row := read_document(l_original_document_id, p_raise_ndf => false);
        if (l_original_document_row.ref is null) then    l_original_document_row := read_document(bars_sqnc.rukey(l_original_document_id), p_raise_ndf => false);       end if;

        return case when l_original_document_row.tt in ('WD3', 'KV3') and (l_original_document_row.nlsa like '27%' or l_original_document_row.nlsa like '366%') then 0    else 1       end;
    exception        when no_data_found then             return 1;
    end;
    -------------------------------------------
    function header_version return varchar2 is    begin        return 'Package header MBK ' || MBK_HEAD_VERS;    end;
    function body_version return varchar2   is    begin        return 'Package body MBK ' || MBK_BODY_VERS;    end;
end;
/
 show err;
 
PROMPT *** Create  grants  MBK ***
grant EXECUTE                                                                on MBK             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on MBK             to FOREX;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/mbk.sql =========*** End *** =======
 PROMPT ===================================================================================== 
 