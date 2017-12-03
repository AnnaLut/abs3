PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/mbk.sql =========*** Run *** =======
PROMPT ===================================================================================== 

create or replace package mbk
is

    MBK_HEAD_VERS  constant varchar2(64)  := 'version 55.0 02.01.2017';

    ATTR_AWAITING_MAIN_AMOUNT     constant varchar2(30 char) := 'MBDK_AWAITING_MAIN_AMOUNT';
    ATTR_AWAITING_INTEREST_AMOUNT constant varchar2(30 char) := 'MBDK_AWAITING_INTEREST_AMOUNT';

    ----------------------------------------------------------------------
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
              DDAte_        date     default null,  -- Дата заключення
              IRR_          number   default null,  -- Еф. % ставка
              code_product_ number   default null,  -- Код продукта
              n_nbu_        varchar2 default null   -- Номер свідоцтва НБУ
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
    --    Процедура отвязки залога ДЦП
    --
    procedure unlink_dcp(p_nd number);

    ----------------------------------------------------------------------
    --    Процедура привязки договоров
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
    --    Процедура привязки документа к договору
    --
    procedure link_nd_ref (p_nd number, p_ref number);

    ----------------------------------------------------------------------
    --    Процедура привязки документов к договорам
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
    --    Возвращает версию заголовка пакета
    --
    function header_version return varchar2;

    ----------------------------------------------------------------------
    --    Возвращает версию тела пакета
    --
    function body_version return varchar2;
end;
/
create or replace package body mbk is

    MBK_BODY_VERS   CONSTANT VARCHAR2(64)  := 'version 75.1 02.08.2017';
/*
    13.10.2016 Sta - код оп при приеме сумм на заход

    28.09.2016 Sta - Функция для создания вюшки "Операции" по договору
       v_pay_mbdk2 as select * from   table ( mbk.make_docinput (to_number(pul.get_mas_ini_val('ND')) )
       Используется только для ВЕБ

    09.07.2016 BAA - додав proc. COLLATERAL_PAYMENTS
    07.07.2016 BAA - додав proc. F_NLS_MB
    04.07.2016 BAA - Пошук не переданих параметрів в проц. INP_DEAL
                     Перевіки в проц. DEL_DEAL та DEL_RO_DEAL
    12.05.2016 BAA - змінено логіку вставки параметру ВКР при створенні договору
    29.09.2015 Sta - Добавлены доп.рекв при создании договора = PROCEDURE inp_deal
                     VNCRR Поточний ВКР            \
                     VNCRP Поточний=Первинний ВКР  / из карточки кл.
    12.12.2014 Artem Yurchenko Изменил способ определения операции начисления процентов по
               кредитным ресурсам
    24.11.2014 Artem Yurchenko Изменил способ определения операции оплаты процентов по кредитным ресурсам

    21.03.2014 qwa убрала параметр компиляции GOU за ненадобностью (перешли на ммфошную схему)

    30.09.2013 qwa автоматическая установка спецпараметра S180 (только 1 класс)
                   при вводе новой сделки и пролонгации, вместе с
                   Fs180_DEF.fnc от 27-09-2013, FS180.fnc от 30-09-2013

    10.07.2013 qwa 03.07.2013 qwa Надра, фининституты (используем косвенно вьюшку
                                  mbd_k_fi )
                                  свои варианты назначений платежа
                                  patch179.ndr.mbk

    28.11.2012 qwa Новый параметр компиляции GOU (дополнение к OB22, без KF)
               добавила логическое условие в блоке по параметрам OB22+GOU -
               только для договора похожего на 39 -- потом его отменили
*/

    DEAL_KIND_CRED_SOUR_LOAN    constant integer := 3902;
    DEAL_KIND_CRED_SOUR_DEPOSIT constant integer := 3903;

    ------------------------------------------------------------------
    --    Rollover/пролонгация
    procedure ro_deal (
        cc_id_new   in varchar2,     /* новый номер тикета    */
        nd_         in integer,     /* старый ND             */
        nd_new      out integer,     /* новый ND для ролловер */
        acc_new     out integer,     /* ACC нового счета      */
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
     ACC_SS      int;  /* асс ссудного счета для опредения наличия залога */
     ACC_ZAL     int;  /* acc счета залога                                */
     l_s180      specparam.s180%type;

   BEGIN

     ACC_NEW := to_number(NUll) ;
     VIDD_   := to_number(substr(NLS_NEW ,1,4));
     logger.info('MBDK in');
     BEGIN
        -- реквизиты старой сделки
        logger.info('MBDK реквизиты старой сделки');
        SELECT d.cc_id,   a.bDATE,   d.KPROLOG, c.RNK, c.nmkk, a.accs,
               a.acckred, a.mfokred, a.accperc, a.mfoperc,  a.refp
          INTO cc_id_ ,   DAT2_  ,   KPROLOG_,  RNK_, NMK_, ACC_OLD,
               NLSB_OLD,  MFOB_OLD,  NLSNB_OLD, MFONB_OLD,  REFP_OLD
          FROM cc_deal d,  customer c , cc_add a
         WHERE d.nd=ND_ AND d.rnk=c.rnk AND a.nd=d.nd AND a.adds=0 ;
        logger.info('MBDK ACC_OLD = '||ACC_OLD||' nID = '||nID_);
        SELECT acra INTO ACRA_OLD FROM int_accn
         WHERE acc=ACC_OLD AND id=nID_ AND acra is not null ;

        IF nvl(CC_ID_NEW, cc_id_) = cc_id_ and DATN_NEW = DAT2_ THEN
           --старая сделка (не ролловер, а пролонгация), просто меняем  реквизиты сделки
           UPDATE cc_deal
              SET KPROLOG=KPROLOG +1, vidd=VIDD_, limit= nS_NEW, wdate=DatK_NEW
            WHERE nd= ND_;
           ND_NEW := ND_;
        ELSE
           -- новая сделка-клон (ролловер)
           nd_new := bars_sqnc.get_nextval('s_cc_deal');
           INSERT INTO cc_deal d (nd, vidd, rnk, d.user_id, cc_id, sos, wdate, sdate, limit, kprolog)
           SELECT ND_NEW, VIDD_, rnk, gl.aUID, CC_ID_NEW, 10, DatK_NEW, gl.BDATE, nS_NEW, 0
             FROM cc_deal WHERE nd=ND_;

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
        logger.info('MBDK out');
     EXCEPTION WHEN NO_DATA_FOUND THEN return;
     END;

     IF NLS_OLD <> NLS_NEW THEN   -- другой балансовый счет
        BEGIN
           -- Счет уже открыт
           SELECT acc, tip INTO ACC_NEW, TIP_ FROM accounts WHERE nls=NLS_NEW and kv=nKv_;
           -- привязываем его к сделке
           INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACC_NEW);
           BEGIN
              -- Счет Нач.%% открыт
              SELECT acc INTO ACRA_NEW FROM accounts WHERE nls=NLS8_NEW and kv=nKv_;
              -- привязываем его к сделке
              INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);
           EXCEPTION WHEN NO_DATA_FOUND THEN
              -- Счет Нач.%% не открыт, открываем (Op_reg(1, ...) - c insert into nd_acc)
              IF ACRA_OLD > 0 THEN
                 SELECT tip into TIP_ from accounts where acc=ACRA_OLD;
              END IF;
              Op_Reg_ex(1,ND_NEW,n_,GRP_,n_,RNK_,NLS8_NEW,nKv_,NMK_,TIP_,ISP_,ACRA_NEW,
                 '1',null,null,
                 null);   --  KB pos=1
              p_setAccessByAccmask(ACRA_NEW,ACC_NEW);
              BEGIN
                 INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);
              EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
              END;
           END;
        EXCEPTION WHEN NO_DATA_FOUND THEN
           -- открываем счет
           BEGIN
              SELECT grp, isp, tip INTO GRP_, ISP_, TIP_
                FROM accounts WHERE acc=ACC_OLD;
              Op_Reg_ex(1,ND_NEW,n_,GRP_,n_,RNK_,NLS_NEW,nKv_,NMK_,TIP_,ISP_,ACC_NEW,
                 '1',null,null,
               null);   --  KB pos=1
              p_setAccessByAccmask(ACC_NEW,ACC_OLD);
              BEGIN
                 INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW, ACC_NEW);
                 If TIP_= 'SS ' THEN
                    INSERT INTO cc_accp(ACC, ACCS, nD)
                    SELECT acc, ACC_NEW, nd FROM cc_accp WHERE accs=ACC_OLD ;
                 END IF;
              EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
              END;
              -- открываем счет Нач.%%
              IF ACRA_OLD > 0 THEN
                SELECT tip INTO TIP_ FROM accounts WHERE acc=ACRA_OLD;
              END IF;
              Op_Reg_ex(1,ND_NEW,n_,GRP_,n_,RNK_,NLS8_NEW,nKv_,NMK_,TIP_,ISP_,ACRA_NEW,
                 '1',null,null,
                 null);   --  KB pos=1
              p_setAccessByAccmask(ACRA_NEW,ACC_NEW);
              BEGIN
                 INSERT INTO nd_ACC(nd, acc) VALUES(ND_NEW,ACRA_NEW);
              EXCEPTION WHEN DUP_VAL_ON_INDEX THEN NULL;
              END;
           EXCEPTION WHEN NO_DATA_FOUND THEN  return;
           end;
        end;
        /* Для сделок с залогами, по которым пролонгация (не ролл) */
        /* Привязка к новому счету старого залога*/
        acc_ss:=ACC_OLD;
        begin
           /* определим по старому счету текущей сделки наличие залога*/
           /* в данном случае ND_NEW=ND */
           select c.acc,c.accs into acc_zal,acc_ss
             from cc_accp c, pawn_acc p
            where c.acc=p.acc  and c.nd =ND_NEW;
        exception when no_data_found then acc_ss:='0';
        end;
        if acc_ss=ACC_OLD then
           update cc_accp set accs=ACC_NEW where nd=ND_NEW;
        end if;
        /* проверим наличие старых закрытых договоров с залогами по "новому счету"*/
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
        -- перепривязываем залог к новому договору
        update cc_accp set accs = ACC_NEW, nd = ND_NEW where nd = ND_;
        -- отвязываем залоги от старого счета
        delete from cc_accp where accs = ACC_OLD;
     end if;

     -- для остального
     select substr(
       decode(nvl(CC_ID_NEW, cc_id_),cc_id_,
                 decode (DATN_NEW,DAT2_,'Змiни:','Змiни-Ролл:'),'Змiни-Ролл:')||
       decode ( nS_OLD  , nS_NEW  , '',
              ' Суми з ' || trim(to_char(nS_OLD*100,'9999999999999,99')) ||
              ' до '     || trim(to_char(nS_NEW*100,'9999999999999,99')) || '. ') ||
       decode ( nPr_OLD , nPr_NEW , '',
              ' % Ст. з '|| nPr_OLD ||
              ' до '     || nPr_NEW || '. ') ||
       decode ( DatK_OLD, DatK_NEW, '',
              ' Строку з ' || to_char(DatK_OLD,'dd/MM/yyyy') ||
              ' до '       || to_char(DatK_NEW,'dd/MM/yyyy') || '. ') ||
       decode ( NLS_OLD , NLS_NEW , '',
              ' Рахунку з ' || Nls_OLD ||
              ' на '        || NLS_NEW || '.') ||
       decode ( NLSB_OLD , NLSB_NEW , '',
              ' Рахунку осн. партнера з ' || NLSB_OLD || ' (МФО ' || MFOB_OLD || ')' ||
              ' на '                      || NLSB_NEW || ' (МФО ' || MFOB_NEW || ').') ||
       decode ( NLSNB_OLD , NLSNB_NEW , '',
              ' Рахунку нар.% партнера з '|| NLSNB_OLD || ' (МФО ' || MFONB_OLD || ')' ||
              ' на '                      || NLSNB_NEW || ' (МФО ' || MFONB_NEW || ').')
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
               --, pap=nID_+1            оставим в соотв. с планом счетов
         WHERE acc=ACRA_NEW;
        UPDATE int_accn SET STP_DAT=DatK_NEW-1 WHERE acc=ACC_NEW and id=nID_;
        IF SQL%rowcount = 0 THEN     -- определим контрсчет для проц карточки
           BEGIN
              if to_number(to_char(gl.bdate,'MM')) = to_number(to_char(DatK_NEW-1,'MM')) then
                  select f_proc_dr(s.rnk, 4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_   -- непереходящие
                  from   cc_deal s, cc_add a
                  where  s.nd = ND_NEW and s.nd = a.nd;
              else
                  select f_proc_dr(s.rnk ,4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_  -- переходящие
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

     -- Если порождаем новый договор, то
     If ND_NEW <> ND_ then  D020_ := '01';
     else                   D020_ := '02';
     end if;

     UPDATE specparam set D020 = D020_ where acc = ACC_NEW ;
     if SQL%rowcount = 0 then
        INSERT INTO specparam ( ACC, D020 ) values ( ACC_NEW, D020_ );
     end if;

     -- новый код срока только для 1-го класса
     if vidd_ like '1%' then
        l_s180 := FS180(ACC_NEW, '1', bankdate);
        update specparam set s180 = l_s180 where acc = ACC_NEW;
        if SQL%rowcount = 0 then
           INSERT INTO specparam (ACC, S180) values (ACC_NEW, l_s180);
        end if;
     end if;

   END RO_deal;


    procedure rollover_deal(
        p_deal_id                      in integer,      /* старый nd             */
        p_deal_number                  in varchar2,     /* новый номер тикета    */
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
        p_new_deal_id                  out integer,     /* новый nd для ролловер */
        p_new_main_account_id          out integer)     /* acc нового счета      */
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
            -- старая сделка (не ролловер, а пролонгация), просто меняем  реквизиты сделки
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
            -- новая сделка-клон (ролловер)
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

            -- прив'язуємо рахунки старої угоди до нової
            -- (за виключенням основного рахунку та рахунку нарахованих відсотків, оскільки у нової угоди будуть свої)
            for i in (select acc from nd_acc t
                      where  t.nd = p_deal_id
                      minus
                      -- оскільки ідентифікатор рахунку нарахованих відсотків може бути null, ми не можемо використати
                      -- конструкцію "not in (l_old_interest_account_row.acc)" - в цьому разі виборка не поверне жодного рядка
                      -- тому виключаємо їх з набору рахунків, що прив'язуються до нової угоди за допомогою "minus"
                      select column_value
                      from   table(number_list(l_old_account_row.acc, l_old_interest_account_row.acc))) loop
                cck_utl.link_account_to_deal(p_new_deal_id, i.acc);
            end loop;
        end if;

        -- аналізуємо зміну основного рахунку угоди
        if (l_old_account_row.nls = p_main_account_number) then
            -- рахунок залишився без змін
            p_new_main_account_id  := l_old_account_row.acc;
            -- в такому разі рахунок відсотків також залишаємо без змін
            l_new_interest_account_row.acc := l_old_interest_account_row.acc;
        else
            -- номер основного рахунку по угоді змінився
            l_new_account_row := account_utl.read_account(p_main_account_number, l_old_cc_add_row.kv, p_raise_ndf => false);

            if (l_new_account_row.acc is not null) then
                p_new_main_account_id := l_new_account_row.acc;
            else
                op_reg_ex(mod_     => 1,
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

            -- рахунок нарахованих відсотків
            -- шукаємо рахунок нарахованих відсотків за номером, що був сформований в формі зміни параметрів угоди
            l_new_interest_account_row := account_utl.read_account(p_interest_account_number, l_old_cc_add_row.kv, p_raise_ndf => false);

            if (l_new_interest_account_row.acc is null) then
                -- не знайшли рахунок відсотків за номером - відкриваємо новий
                op_reg_ex(mod_     => 1,
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
                                               else null -- невідомий тип угод
                                          end),
                          isp_     => user_id(),
                          accr_    => l_new_interest_account_row.acc,
                          nbsnull_ => '1');
            end if;

            -- наслідування груп доступа з основного рахунку старої угоди
            p_setaccessbyaccmask(p_new_main_account_id, l_old_cc_add_row.accs);
            p_setaccessbyaccmask(l_new_interest_account_row.acc, p_new_main_account_id);

            cck_utl.link_account_to_deal(p_new_deal_id, p_new_main_account_id);
            cck_utl.link_account_to_deal(p_new_deal_id, l_new_interest_account_row.acc);
        end if;

        -- робота із заставами
        -- до нової угоди підключаються всі рахунки застави, що були підключені до старої
        merge into cc_accp a
        using (select t.acc, t.pr_12, t.idz, t.mpawn, t.pawn, t.rnk
               from   cc_accp t
               join   pawn_acc p on p.acc = t.acc -- переконаємось в тому, що даний рахунок належить до рахунків застави
               where  t.accs in (l_old_account_row.acc, p_new_main_account_id)) s
        on (a.acc = s.acc and a.accs = p_new_main_account_id)
        when matched then update
             set a.nd = p_new_deal_id -- оновлюємо ідентифікатор прив'язаної угоди
        when not matched then insert
             values (s.acc, p_new_main_account_id, p_new_deal_id, s.pr_12, s.idz, bars_context.current_mfo(), s.mpawn, s.pawn, s.rnk);

        -- очищення списку застав від некоректних значень: виключаємо закриті рахунки застави, виключаємо рахунки, балансовий яких не відповідає типу угоди
        -- також виключаємо рахунки, для яких відсутні параметри договору застави (могли залишитися від старих угод)
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

        -- від'єднуємо заставу від старого рахунку угоди
        delete cc_accp t where t.accs = l_old_account_row.acc;
        delete nd_acc t where t.nd = p_new_deal_id and t.acc in (select column_value from table(l_redundant_pawn_accounts));

        stxt_ := substr(case when p_deal_number is not null and p_deal_number <> l_old_cc_deal_row.cc_id then 'Ролловер (зміна):'
                             else 'Пролонгація (зміна):'
                        end ||
                        case when p_main_account_number is not null and p_main_account_number <> l_old_account_row.nls then
                                  ' Рахунку з ' || l_old_account_row.nls || ' на ' || p_main_account_number
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_add_row.s, p_deal_amount) then
                                  ' Суми з ' || trim(to_char(l_old_cc_add_row.s, '9999999999999,99')) ||
                                  ' до '     || trim(to_char(p_deal_amount, '9999999999999,99'))
                             else ''
                        end ||
                        case when not tools.equals(l_old_interest_rate, p_interest_rate) then
                                  ' % Ст. з '|| l_old_interest_rate ||
                                  ' до '     || p_interest_rate
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_deal_row.wdate, p_expiry_date) then
                                  ' Строку з ' || to_char(l_old_cc_deal_row.wdate, 'dd/mm/yyyy') ||
                                  ' до '       || to_char(p_expiry_date, 'dd/mm/yyyy')
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_add_row.acckred , p_partner_account) then
                                  ' Рахунку партнера з ' || l_old_cc_add_row.acckred || ' (МФО ' || l_old_cc_add_row.mfokred || ')' ||
                                  ' на '                || p_partner_account || ' (МФО ' || p_partner_bic || ')'
                             else ''
                        end ||
                        case when not tools.equals(l_old_cc_add_row.accperc, p_partner_interest_account) then
                                  ' Рахунку нар.% партнера з '|| l_old_cc_add_row.accperc || ' (МФО ' || l_old_cc_add_row.mfoperc || ')' ||
                                  ' на '                      || p_partner_interest_account || ' (МФО ' || p_partner_interest_bic || ')'
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
               --, pap=nID_+1            оставим в соотв. с планом счетов
         WHERE acc=l_new_interest_account_row.acc;
        UPDATE int_accn SET STP_DAT=p_expiry_date-1 WHERE acc=p_new_main_account_id and id=l_old_interest_kind_id;
        IF SQL%rowcount = 0 THEN     -- определим контрсчет для проц карточки
           BEGIN
              if to_number(to_char(gl.bdate,'MM')) = to_number(to_char(p_expiry_date-1,'MM')) then
                  select f_proc_dr(s.rnk, 4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_   -- непереходящие
                  from   cc_deal s, cc_add a
                  where  s.nd = p_new_deal_id and s.nd = a.nd;
              else
                  select f_proc_dr(s.rnk ,4,0,'MKD',s.Vidd,a.KV)
                  into   nG67_  -- переходящие
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

     -- Если порождаем новый договор, то
     If p_new_deal_id <> p_deal_id then  D020_ := '01';
     else                   D020_ := '02';
     end if;

     UPDATE specparam set D020 = D020_ where acc = p_new_main_account_id ;
     if SQL%rowcount = 0 then
        INSERT INTO specparam ( ACC, D020 ) values ( p_new_main_account_id, D020_ );
     end if;

     -- новый код срока только для 1-го класса
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
   --    Функция возвращает номера счетов сделки (30 симв.)
   --
   --
   Function F_NLS_MB (
     nbs_     in varchar2,
     rnk_     in integer,
     ACRB_    in integer,
     kv_      in integer,
     maskid_     varchar2 ) return varchar2  IS

   nbsn_ char(4);                         -- БС нач %%
   SS_   varchar2(14) := to_char(null);   -- осн счет как результат
   SN_   varchar2(14) := to_char(null);   -- предполож нач % как результат
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

        SELECT nbsn INTO nbsn_ FROM proc_dr WHERE nbs=nbs_ and ROWNUM=1; -- если несколько записей - берем первую

        BEGIN
            if nbs_ like '39%' then  MASK_ := 'MFK';
            else                     MASK_ := 'MBK';
            end if;

            -- 30.08.2010 Sta
            -- только для ГОУ ОБ

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

              -- Для всех других банков
              -- вот он свободный  SS_
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

          -- а как его счет  SN ?
          SELECT a.nls, i.acra  INTO SN_, acra_  FROM int_accn i, accounts a
          WHERE i.acc=acc_ AND i.id=id_ AND i.acra=a.acc AND a.dazs is null;

       exception when NO_DATA_FOUND THEN

          -- увы, нет --смоделируем следующий (первый) новый
          SS_ := F_NEWNLS2(null, MASK_, nbs_ , RNK_,null);
          SN_ := F_NEWNLS2(null, MASK_, nbsn_, RNK_,null);

       END;
    exception when NO_DATA_FOUND THEN null;
    end;

    return (substr(SS_||'               ', 1, 15) ||
            substr(SN_||'               ', 1, 15)
           );

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
      pul.set_mas_ini( 'INITIATOR', p_initiator, 'Центр инициатора операции' );
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
            raise_application_error(-20000, 'Не вдалось сформувати номер рахунку застави для основного рахунку угоди {' || p_main_account_number ||
                                            '}, виду застави {' || l_pawn_kind_row.name ||
                                            '}, виду угоди {' || cck_utl.get_deal_kind_name(p_deal_kind_id) ||
                                            '}, клієнта {' ||  || '}');
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
    -- перевірка, чи відноситься угода до функціональності Кредитних ресурсів
    ---
    function check_if_deal_belong_to_crsour(
        p_product_id in integer)
    return char
    is
    begin
        return case when p_product_id in (DEAL_KIND_CRED_SOUR_LOAN, DEAL_KIND_CRED_SOUR_DEPOSIT) then 'Y' else 'N' end;
    end;

    ------------------------------------------------------------------
    -- параметри розрахунку процентів для угод МБДК
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

        -- TODO: ніжто вже не пам'ятає для чого існує цей if, але всім страшно сказати, що він не потрібен - розберусь, і приберу його, якщо це можливо
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
    -- тип залишку, на який нараховуються відсотки - визначається за таблицею proc_dr$base, знаходиться в полі IO
    -- довідник доступних типів залишку - таблиця int_ion
    -- таблиця proc_dr$base зберігає одночасно багато значень з одним і тим самим номером балансового рахунку і
    -- прив'язаним до нього типом залишку. Предметна логіка, і всі попередні реалізації даної задачі в коді Центури,
    -- розраховують на те, що для одного балансового рахунку не зустрінеться різних IO і беруть перший-ліпший рядок.
    -- Наприклад: If SqlPrepareAndExecute(hSql(), "select nvl(IO, 0) into :nIO from proc_dr where nbs=:nVidd and sour=4") and SqlFetchNext(hSql(), nFetchRes)
    -- Іншого довідника для визначення типу залишку на даний час не існує - тому доведеться використовувати той самий підхід
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
    --  Повертає номер рахунку доходів/витрат по нарахуванню відсотків з налаштувань
    --  таблиці proc_dr$base, в залежності від валюти угоди.
    --  Рахунки в полях G67N та V67N для модуля МБДК ігноруються
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

        begin
          select a.NLS, a.NMS
            into l_9910_num, l_9910_nm
            from BARS.ACCOUNTS a
           where a.NLS  = Substr(BARS.BRANCH_USR.GET_BRANCH_PARAM('NLS_9900'),1,14)
             and a.KV   = p_ccy_id
             and a.DAZS is Null;
        exception
          when NO_DATA_FOUND then
            raise_application_error( -20666, 'Не знайдено або закритий рахунок 9910', true );
        end;

        begin

          select nvl(c.NMKK,SubStr(c.NMK,1,38)), c.OKPO
            into l_cust_num, l_cust_code
            from BARS.CUSTOMER c
           where c.RNK = p_rnk
             and c.DATE_OFF Is Null;

        exception
          when NO_DATA_FOUND then
            raise_application_error( -20666, 'Не знайдено або закритий клієнт з РНК = ' || to_char(p_rnk), true );
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

        l_nazn := 'Застава згідно угоди ' || p_mbk_num || ' від ' || to_char(p_beg_dt,'dd/mm/yyyy');

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

        bars_audit.info( title || 'Введена оп. ZAL реф. ' || to_char(l_ref) || ' по дог. ' || to_char(p_mbk_id) );

        cck_utl.link_document_to_deal(p_mbk_id, l_ref);

        --------------------

        l_ref  := null;

        l_nazn := 'Повернення застави згідно угоди ' || p_mbk_num || ' від ' || to_char(p_beg_dt,'dd/mm/yyyy');

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

        bars_audit.info( title || 'Введена оп. ZAL реф. ' || to_char(l_ref) || ' по дог. ' || to_char(p_mbk_id) );

        cck_utl.link_document_to_deal(p_mbk_id, l_ref);

        --------------------

        bars_audit.trace( '%s: Exit with ( ref = %s ).', title, to_char(l_ref) );

    end;


    ------------------------------------------------------------------
    --    Ввод новой сделки
    --
    procedure create_deal (
        p_deal_number varchar2,   -- N тикета/договора
        p_deal_type   integer,        -- Вид договора
        nkv_        integer,        -- Валюта
        rnkb_       integer,        -- Рег.№ партнера
        dat2_       date,       -- дата сделки
        p_datv      date,       -- дата валютирования
        dat4_       date,       -- дата окончания
        ir_         number,     -- индив ставка
        op_         number,     -- арифм.знак
        br_         number,     -- базовая ставки
        sum_        number,     -- Сумма сделки (в руб.)
        nbasey_     integer,        -- % база
        nio_        integer,        -- Начисление на входящий остаток 1-Да/0-Нет
        s1_         varchar2,   -- Осн.Счет для банка Б
        s2_         varchar2,   -- Код банка Б (mfo/bic) для осн.сч
        s3_         varchar2,   -- Счет нач.% для банка Б
        s4_         varchar2,   -- Код банка Б (mfo/bic) для сч нач.%
        s5_         number,     -- Счет для входа валюты
        nlsa_       varchar2,   -- Основной счет в нашем банке
        nms_        varchar2,   -- Наименование основного счета
        nlsna_      varchar2,   -- Счет начисленных % в нашем банке
        nmsn_       varchar2,   -- Наименование счета начисленных %
        nlsnb_      varchar2,   -- Счет нач.% для банка Б = S3_
        nmkb_       varchar2,   -- Наименование клиента
        nazn_       varchar2,   -- Назначение платежа (% по дог. CC_ID)
        nlsz_       varchar2,   -- Счет обеспечения
        nkvz_       integer,        -- Валюта обеспечения
        p_pawn      number,     -- код вида обеспечения
        id_dcp_     integer,        -- Id from dcp_p.id -- не використовується
        s67_        varchar2,   -- Счет доходов
        ngrp_       integer,        -- Группа доступа счетов
        nisp_       integer,        -- Исполнитель
        bica_       varchar2,   -- BIC нашего банка
        ssla_       varchar2,   -- Счет VOSTRO у нашего банка-корреспонд
        bicb_       varchar2,   -- BIC партнера
        sslb_       varchar2,   -- Счет VOSTRO партнера у его банка-корресп
        sump_       number,     -- Сумма %%
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
        l_clt_amnt              oper.s%type; -- сума застава з pul
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

        -- счет доходов-расходов
        if (l_income_account_number is null) then

            l_income_account_number := get_income_account(l_proc_dr_row, nkv_);

            if (l_income_account_number is null) then
                raise_application_error(-20000, 'Не вдалося визначити рахунок доходів/витрат для виду договору {' || l_cc_vidd_row.name ||
                                                '} та партнера {' || customer_utl.get_customer_name(rnkb_) || '}');
            end if;
        end if;

        l_income_account_row := account_utl.read_account(l_income_account_number, gl.baseval);

        if (l_income_account_row.dazs is not null) then
            raise_application_error(-20000, 'Рахунок доходів/витрат {' || l_income_account_number || '/' || gl.baseval || '} закритий');
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

        -- открытие основного счета
        op_reg_ex(1, nd_, ntmp_, l_grp, ntmp_, rnkb_, nlsa_, nkv_, nms_, tip1_, l_isp, acc1_, '1', null, null, null);

        -- открытие счета нач.%%
        op_reg_ex(1, nd_, ntmp_, l_grp, ntmp_, rnkb_, nlsna_, nkv_, nmsn_, tip2_, l_isp, l_interest_account_id, '1', null, null, null);

        -- основний insert в cc_deal
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
            -- Доп.реквизиты счета SS
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
        -- для кредитных ресурсов необходимо использовать другие операции
        if (check_if_deal_belong_to_crsour(p_deal_type) = 'Y') then
            -- установка ОБ22
            l_ob22 := '02';
            accreg.setaccountsparam(acc1_, 'OB22', l_ob22);
            accreg.setaccountsparam(l_interest_account_id, 'OB22', l_ob22);

            -- проставим спецпараметр МФО (нужно для файлов 32, 33)
            accreg.setaccountsparam(acc1_, 'MFO', s2_);
            accreg.setaccountsparam(l_interest_account_id, 'MFO', s2_);

            --операция по начислению проц
            stta_ := case when nkv_ = gl.baseval then l_proc_dr_row.tt
                          else l_proc_dr_row.ttv
                     end;

            sttb_ := 'PS2';
        else
            -- операция по начислению проц
            stta_ := case when l_customer_row.codcagent = 1 then -- банк-резидент
                               nvl(branch_attribute_utl.get_value('MBD_%%1'), '%%1')
                          else case when l_cc_vidd_row.tipd = 1 then '%00'
                                    else '%02'
                               end
                     end;

            sttb_ := case when nkv_ = gl.baseval then 'WD2' else 'WD3' end;
        end if;

        -- При открытии договора D020 := '01'
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
                  namb = nmkb_,
                  nazn = nazn_
           where  acc = acc1_ and
                  id = 1;
        elsif (nid_ = 1 and nkv_ <> gl.baseval) then
            if (check_if_deal_belong_to_crsour(p_deal_type) = 'Y') then
                update int_accn
                set    nlsb = substr(nlsnb_, 1, 14),
                       mfob = s2_,
                       namb = nmkb_,
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

        -- новый код срока только для 1-го класса
        if (p_deal_type like '1%') then
            accreg.setAccountSParam(acc1_, 'S180', fs180(acc1_, '1', bankdate));
        end if;

        -- установка параметрів Первинний та Поточний ВКР
        l_txt := kl.get_customerw(rnkb_, 'VNCRR');

        -- Поточний ВКР
        cck_utl.set_deal_attribute(nd_, 'VNCRR', l_txt);

        -- Первинний ВКР
        cck_utl.set_deal_attribute(nd_, 'VNCRP', l_txt);

        if (nlsz_ is not null) then
            -- открытие счета залога
            op_reg_ex(2, nd_, p_pawn, 2, ntmp_, rnkb_, nlsz_, nkvz_, nms_, 'ZAL', l_isp, l_pawn_account_id, '1', null, null, null); -- KB  pos=1

            -- проставляем группу доступа для счета залога как для основного счета
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
    --    Процедура обновления даты заключения сделки
    --
    procedure upd_cc_deal (p_nd number, p_sdate date)
    is
    begin
      update cc_deal set sdate = p_sdate where nd = p_nd;
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
      n_nbu_        varchar2 default null   -- Номер свідоцтва НБУ
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
      l_clt_amnt              oper.s%type; -- сума застава з pul
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

        -- счет доходов-расходов
        if ( S67_ Is Null )
        then

          ACC3_ := BARS.F_PROC_DR( RNKB_, 4, 0, 'MKD', nVidd_, nKv_ );

          if ( ACC3_ Is Null )
          then
            sERR_ := 'Не знайдено рахунок доходів/витрат';
            raise inr_err;
          end if;

        else

          BEGIN
            SELECT acc
              INTO ACC3_
              FROM accounts
             WHERE kv=gl.baseval
               and nls=S67_
               and dazs is null;
          EXCEPTION
            WHEN NO_DATA_FOUND THEN
              sERR_ := 'Не открыт счет '||S67_;
              raise inr_err;
          END;

        end if;

        --SELECT s_cc_deal.nextval into ND_  FROM dual;
        nd_ := bars_sqnc.get_nextval('s_cc_deal');

        INSERT INTO cc_deal (nd , vidd  , rnk  , user_id, cc_id , sos, wdate, sdate                , limit, kprolog,ir  ,prod         )
                     VALUES (ND_, nVidd_, RNKB_, nUser_ , CC_ID_, 10 , DAT4_, nvl(DDAte_, gl.BDATE), SUM_ , 0      ,IRR_,code_product_);

        INSERT INTO cc_add (nd         , adds       , s      , kv     , bdate  , wdate  , sour      , acckred   , mfokred , freq      , accperc   ,
                            mfoperc    , refp       , swi_bic, swi_acc, swo_bic, swo_acc, int_amount, alt_partyb, interm_b, int_partya, int_partyb,
                            int_interma, int_intermb, n_nbu  )
                    VALUES (ND_        , 0          , Sum_   , nKv_   , DAT2_  , p_datv , 4         , S1_       , S2_     , 2         , S3_       ,
                            S4_        , S5_        , bica_  , ssla_  , bicb_  , sslb_  , sump_     , altb_     , intermb_, IntPartyA_, IntPartyB_,
                            IntIntermA_, IntIntermB_, n_nbu_ );

        if ( nTipd_ Is Null )
        then
          select TIPD
            into l_tipd
            from CC_VIDD
           where VIDD = nVidd_;
        else
          l_tipd := nTipd_;
        end if;

        if l_tipd = 1
        then
          nID_ :=0;
          Tip1_:='SS ';
          Tip2_:='SN ';
        else
          nID_ :=1;
          Tip1_:='DEP';
          Tip2_:='DEN';
        end if ;

        if ( nIsp_ Is Null )
        then
          l_isp := gl.aUID;
        else
          l_isp := nIsp_;
        end if;

        if ( nGrp_ Is Null )
        then
          l_grp := 33;
        else
          l_grp := nGrp_;
        end if;

        bars_audit.info( title || ': tipd = ' || to_char(l_tipd)
                               || ', grp = '  || to_char(l_grp)
                               || ', isp = '  || to_char(l_isp) );

        -- открытие основного счета
        Op_Reg_ex(1,ND_,nTmp_, l_grp, nTmp_,RNKB_,NLSA_, nKv_,NMS_, Tip1_, l_isp, ACC1_, '1', null, null,
           null);  -- KB  pos=1

        bars_audit.info( title || ': ACC1_ = ' || ACC1_ );

        -- открытие счета нач.%%
        Op_Reg_ex(1,ND_,nTmp_, l_grp, nTmp_,RNKB_,NLSNA_,nKv_,NMSN_,Tip2_, l_isp, ACC2_, '1', null, null,
           null);  -- KB  pos=1

        UPDATE cc_add
           SET accs=ACC1_
         WHERE nd=ND_;

        -- 30.08.2010 Sta
        l_INITIATOR := substr( pul.Get_Mas_Ini_Val('INITIATOR'), 1, 2 );

        If gl.aMfo = '300465' and l_INITIATOR is not null then
           -- Доп.реквизиты счета SS
           EXECUTE IMMEDIATE 'update SPECPARAM_CP_OB set INITIATOR =''' || l_INITIATOR || ''' where acc= '|| ACC1_ ;
           if SQL%rowcount = 0 then
              EXECUTE IMMEDIATE 'insert into SPECPARAM_CP_OB (ACC,INITIATOR) ' ||
                                'values ( ' || ACC1_ || ', '''|| l_INITIATOR || ''' )';
           end if;

           EXECUTE IMMEDIATE 'update SPECPARAM_CP_OB set INITIATOR =''' || l_INITIATOR || ''' where acc= '|| ACC2_ ;
           if SQL%rowcount = 0 then
              EXECUTE IMMEDIATE 'insert into SPECPARAM_CP_OB (ACC,INITIATOR) ' ||
                                'values ( ' || ACC2_ || ', '''|| l_INITIATOR || ''' )';
           end if;
        end if;
        -------------

        IF NLSZ_ is not null
        then
          -- открытие счета залога
          op_reg_ex( 2, ND_, p_pawn -- case when ( l_tipd = 2 ) then 999999 else p_pawn end
                   , 2, nTmp_, RNKB_, NLSZ_, nKVZ_, NMS_, 'ZAL', l_isp, ACC4_, '1', null, null, null
                   ); -- KB  pos=1

          bars_audit.info( title || ': ZAL ACC4_ = ' || ACC4_ );

          -- проставляем группу доступа для счета залога как для основного счета
          p_setAccessByAccmask(ACC4_, ACC1_);

          insert into nd_acc (nd, acc) values (ND_, ACC4_);

           if ( l_tipd = 1 )
           then

              update cc_accp
                 set nd=ND_
                 where acc=ACC4_ and accs=ACC1_;

              IF SQL%rowcount = 0
              then
                 INSERT into cc_accp (ACC,ACCS,nd) values (ACC4_,ACC1_,ND_);
              END IF;
           END IF;

           cck_utl.set_deal_attribute(ND_, 'PAWN', to_char(p_pawn));

        END IF;

        IF Id_DCP_ is not null then
           -- обеспечение - ДЦП
           UPDATE dcp_p Set ref=-ND_, acc=ACC1_ WHERE id=Id_DCP_;
        END IF;

        UPDATE accounts SET mdate=DAT4_,PAP=l_tipd WHERE acc=ACC1_;
        UPDATE accounts SET mdate=DAT4_            WHERE acc=ACC2_;
        UPDATE accounts SET mdate=DAT4_            WHERE acc=ACC4_;
    /*
        if substr(nVidd_,1,2) = '39' then

           -- установка ОБ22
           l_ob22 := case when nKV_ = gl.baseval then '02' else '12' end;
           update specparam_int set ob22 = l_ob22 where acc = ACC1_ ;
           if SQL%rowcount = 0 then
              insert into specparam_int (acc, ob22)
              values (ACC1_, l_ob22);
           end if;
           update specparam_int set ob22 = '02' where acc = ACC2_ ;
           if SQL%rowcount = 0 then
              insert into specparam_int (acc, ob22)
              values (ACC2_, '02');
           end if;

           -- проставим спецпараметр МФО (нужно для файлов 32, 33)
           update specparam_int set mfo=S2_ where acc = ACC1_ ;
           if SQL%rowcount = 0 then
              insert into specparam_int (acc, mfo)
              values (ACC1_, S2_);
           end if;
           update specparam_int set mfo=S2_ where acc = ACC2_ ;
           if SQL%rowcount = 0 then
              insert into specparam_int (acc, mfo)
              values (ACC2_, S2_);
           end if;

        end if;
    */
        -- Artem Yurchenko, 24.11.2014
        -- для кредитных ресурсов необходимо использовать другие операции
        if (check_if_deal_belong_to_crsour(nVidd_) = 'Y') then
            -- установка ОБ22
            l_ob22 := '02';
            accreg.setAccountSParam(ACC1_, 'OB22', l_ob22);
            accreg.setAccountSParam(ACC2_, 'OB22', l_ob22);

            -- проставим спецпараметр МФО (нужно для файлов 32, 33)
            accreg.setAccountSParam(ACC1_, 'MFO', s2_);
            accreg.setAccountSParam(ACC2_, 'MFO', s2_);

            sTTB_ := 'PS2';

            --операция по начислению проц
            l_proc_dr_row := get_proc_dr_row(to_char(nVidd_, 'FM9999'), rnkb_);
            sTTA_ := case when nKv_ = gl.baseval then l_proc_dr_row.tt
                          else l_proc_dr_row.ttv
                     end;
        else
            sTTB_ := case when nKv_ = gl.baseval then 'WD2' else 'WD3' end;

            --операция по начислению проц
            BEGIN
               SELECT val INTO sTTA_ FROM params WHERE par='MBD_%%1';
            EXCEPTION WHEN NO_DATA_FOUND THEN sTTA_ := '%%1';
            END;
            BEGIN
              -- резидент-нерезидент
              SELECT decode (codcagent,1, sTTA_, decode(l_tipd,1,'%00','%02') )
                INTO sTTA_
                FROM customer WHERE rnk=RNKB_;
            EXCEPTION
              WHEN NO_DATA_FOUND THEN
                sERR_ := 'Не найден RNKB '||RNKB_;
                raise inr_err;
            END;
        end if;

        if ( nIO_ Is Null )
        then
          select IO
            into l_io
            from BARS.PROC_DR
           where NBS = nVidd_
             and sour = 4
             and rownum = 1;
        else
          l_io := nIO_;
        end if;

        update BARS.INT_ACCN
           set BASEY = nBASEY_
             , TT = sTTA_
             , STP_DAT = DAT4_-1
             , ACRA = ACC2_
             , ACRB = ACC3_
             , s = 0
             , IO = l_io
             , acr_dat = decode(l_io,1,gl.BDATE,acr_dat)
         where acc = ACC1_
           and id  = nID_;

        IF SQL%rowcount = 0
        then
          INSERT INTO int_accN ( acc, ID, metr, basem, BASEY, freq, ACRA, ACRB, KVB, TT, TTB, STP_DAT, s, IO, acr_dat )
          VALUES (ACC1_, nID_, 0, 0, nBASEY_, 1, ACC2_, ACC3_, nKv_, sTTA_, sTTB_, DAT4_-1, 0, l_io, decode(l_io,1,gl.BDATE,null));
        END IF;

        IF ( nID_ = 1 and nKV_=gl.baseval )
        then
           UPDATE int_accN
              Set NLSB=NLSNB_
                , MFOB=S2_
                , NAMB= l_nmkb
                , NAZN=Nazn_
            WHERE acc=ACC1_ AND id=1;
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
                UPDATE int_accN
                   Set NLSB=substr(NLSNB_,1,14), NAMB=l_nmkb, NAZN=Nazn_
                 WHERE acc=ACC1_ AND id=1;
            end if;
        END IF;

        update INT_ratn
           SET ir=IR_, op=OP_, br=BR_
         where acc=ACC1_ and id=nID_ and bdat=DAT2_;

        if SQL%rowcount = 0
        then
           INSERT INTO INT_ratn (acc  , ID ,bdat ,ir ,op ,br)
           VALUES (ACC1_, nID_, DAT2_, IR_, OP_, BR_);
        end if;

        -- При открытии договора D020 := '01'
        UPDATE specparam set D020 = '01' where acc=ACC1_;
        if SQL%rowcount = 0 then
           INSERT INTO specparam (ACC, D020 ) values ( ACC1_, '01' );
        end if;

        -- новый код срока только для 1-го класса
        if nVidd_ like '1%' then
           l_s180 := FS180(ACC1_, '1', bankdate);
           update specparam set s180 = l_s180 where acc = acc1_;
           if SQL%rowcount = 0 then
              INSERT INTO specparam (ACC, S180) values (ACC1_, l_s180);
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
            -- raise_application_error(-20666, 'Відсутнє занчення ВКР у клієнта з РНК = '||to_char(RNKB_), true);
        end;

        -- Поточний ВКР
        cck_utl.set_deal_attribute( ND_, 'VNCRR', l_txt );

        -- Первинний ВКР
        begin
          -- первинний ВКР не оновлюється тому юзаєм INSERT
          insert
            into BARS.ND_TXT
            ( ND, TAG, TXT )
          values
            ( ND_, 'VNCRP', l_txt );
        exception
          when DUP_VAL_ON_INDEX then
            -- вже був вставлений тригером
            null;
        end;

        begin

          l_clt_amnt := to_number( bars.pul.get_mas_ini_val('COLLATERAL_AMOUNT') );

          if ( ( l_clt_amnt > 0 ) and ( NLSZ_ is Not Null ) )
          then

            collateral_payments( p_mbk_id   => ND_
                               , p_mbk_num  => CC_ID_
                               , p_beg_dt   => DAT2_
                               , p_end_dt   => DAT4_
                               , p_clt_amnt => l_clt_amnt
                               , p_acc_num  => NLSZ_
                               , p_ccy_id   => nKVZ_
                               , p_rnk      => RNKB_
                               , p_dk       => case when l_tipd = 1 then 1 else 0 end
                               );

          end if;

        exception
          when OTHERS then
            bars_audit.info( 'mbk.inp_deal: collateral_payments_error => '
                          || dbms_utility.format_error_stack()
                          || dbms_utility.format_error_backtrace() );
        end;

      EXCEPTION
        when INR_ERR then
          null;
        when OTHERS then
          bars_audit.info( 'mbk.inp_deal: error => '|| dbms_utility.format_error_stack()
                                                    || dbms_utility.format_error_backtrace() );
          sErr_ := dbms_utility.format_error_stack();
      END;

      bars_audit.info( 'mbk.inp_deal: Exit with( ND='|| to_char(ND_) ||', ACC1='|| to_char(ACC1_) || ').' );

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
    --    Удаление сделки
    --
    PROCEDURE del_deal
    ( ND_              integer
    ) is
      -- удаление ош.введенной сделки
      DAT1_                 date;
      TIPD_                 integer;
      l_qty                 number(10);
      title       constant  varchar2(60) := 'mbk.del_deal';
    BEGIN

      bars_audit.trace( '%s: Entry with ( nd=%s ).', title, to_char(ND_) );

      -- перевірки
      select count(m.ND)
        into l_qty
        from MBD_K_R m
       where m.ND = ND_
         and exists ( select 1 from OPER o where o.REF = m.REF and o.SOS > 0 );

      if ( l_qty > 0 )
      then
        raise_application_error( -20666, 'По договору #' || to_char(ND_) || ' наявні оплачені документи!', TRUE );
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
             and acc not in (select acc from mbd_k where nd<>ND_)   -- не сбрасываем дату
             and ostc+ostb=0;                                       -- если счет обслуживает 2 сделки
                                                                    -- или ненулевые остатки по счету
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
    --    Закрытие сделки
    --
    PROCEDURE clos_deal (ND_ integer ) is
    p_nd   number:=0;
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
          and d.vidd=v.vidd and v.custtype=1
          and p.adds=0 and  p.accs=a.acc
          AND i.acc=a.acc AND i.acra=n.acc
         and d.sos<15 and d.WDATE <= gl.BDATE)
      LOOP
        /* Готовы ли к закрытию по остаткам на SS SN и дате нач%?   */
        begin  -- определим максимальный номер договора, который обслуживают счета
          select max(nd) into p_nd from nd_acc  where acc in (k.accs,k.accp);
        EXCEPTION WHEN NO_DATA_FOUND THEN p_nd:=0;
        end;
        if ( k.ostcs=0 and k.ostbs=0 and k.ostfs=0
         and k.ostcp=0 and k.ostbp=0 and k.ostfp=0
         and k.acr_dat+1>=k.wdate and k.mdate_a=k.wdate
         and k.mdate_a=k.mdate_n )
        then
              p_sos:=15;
        elsif   -- остатки ненулевые, но счета обслуживают уже новую сделку (возможно Ролловер)
           ( k.ostcs<>0 or k.ostbs<>0 or k.ostfs<>0
          or k.ostcp<>0 or k.ostbp<>0 or k.ostfp<>0 )
         and k.nd <p_nd and k.mdate_a=k.mdate_n and k.mdate_a>k.wdate
        then  p_sos:=15;
        else  p_sos:=k.sos;
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
    --    откат сегодняшней сделки Ролловер
    --
    PROCEDURE del_Ro_deal (ND_ integer )
    IS
    /* откат сегодняшней сделки Ролловер
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
        erm := 'Невозможно откатить несегодняшнюю сделку RollOver!';
        raise err;
      END IF;
      -- тип договора 1- размещ.,2-привлеч.
      begin
        select t.tipd into tipd_
          from cc_vidd t, cc_deal c
         where c.nd=ND_
           and c.vidd=t.vidd;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          erm := 'Не определен вид договора или договора нет в системе';
          raise err;
      end;

      -- ND сделки, исходной для Ролловер (предыдущей)
      -- Откат переброски по Ролл
      -- 1. референс документа Ролл текущей сделки
      begin

        SELECT nvl(min(m.ref),0)
          INTO Ref2_
          FROM mbd_k_r m, oper p
         WHERE m.nd=ND_ AND m.ref=p.ref AND p.tt='KV1'
           AND upper(p.nazn) like '%ROLLOVER%' ;

        IF  Ref2_=0
        THEN
          erm := 'Не нашли Реф. документа Ролловер текущей сделки';
          raise err;
        END IF;

      end;

      begin
       select to_number(value) into ND_Old_
         from operw where ref=Ref2_ and tag='MBKND';
       EXCEPTION WHEN NO_DATA_FOUND THEN
         erm := 'Отсутствует  допреквизит MBKND для реф.'||Ref2_;
       raise err;
      end;

      -- 2. Максимальный Ref документа Ролл предыдущ. сделки (если несколько Ролл по старым версиям)
      begin

        SELECT nvl(max(m.ref),0)
          INTO Ref1_
          FROM mbd_k_r m, oper p
         WHERE m.nd=ND_Old_ AND m.ref=p.ref AND p.tt='KV1'
           AND upper(p.nazn) like '%ROLLOVER%' ;

        IF Ref1_=0
        THEN
           erm := 'Не нашли Реф. документа Ролловер предыдущей сделки';
          raise err;
        END IF;

      end;

      -- Проверка на межбанковские платежи
      begin
        select count(1)
          into l_qty
          from ARC_RRP
         where ref in ( select ref from MBD_K_R where ND = ND_);

        if ( l_qty > 0 )
        then
          erm := 'По договору ' || to_char(ND_) || ' сформированы межбанковские платежи!';
           raise err;
        end if;

      end;

      -- 3.откат всех документов, которые были по новой сделке, кроме документа Ролловер
      FOR k IN ( SELECT m.ref ref FROM mbd_k_r m, oper p
                  WHERE m.nd=ND_ AND m.ref=p.ref and p.ref<> Ref2_ AND p.sos>0
                  ORDER BY m.ref desc )
      LOOP

        p_back_dok(k.ref,5,null,par2_,par3_,1);

        update operw
           set value='RollOver. Отказ от визы'
         where ref=k.ref and tag='BACKR';

      END LOOP;

      -- 4. собственно откат KV1-Ролловер
      -- 4.1 сначала вернем на транзит ( Активный по плану счетов )
      --logger.info ('MBK_Sel411 = Ref_1=2='||ref1_||'='||ref2_);
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
      BEGIN
      --logger.info ('MBK_Sel5 = sdate,wdate');
        SELECT sdate, wdate INTO SDate_, WDate_ FROM cc_deal WHERE nd=ND_Old_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN
        erm := 'Не нашли даты предыдущ. сделки';
        raise err;
      END;
      --logger.info ('MBK_Sel6 = acc_nd_acc');
      FOR k IN (SELECT acc FROM nd_acc WHERE nd=ND_)
      LOOP
        DELETE FROM int_ratn WHERE acc=k.ACC AND bdat>=Dat1_ AND bdat>SDate_ ;
        UPDATE accounts SET mdate=WDate_ WHERE acc=k.Acc
     and acc not in (select acc from mbd_k where nd<>ND_)   -- не сбрасываем дату
     and ostc+ostb<>0;                                      -- если счет обслуживает 2 сделки
                                                               -- или ненулевые остатки по счету
        UPDATE int_accn SET stp_dat=WDate_-1 WHERE acc=k.Acc ;
      END LOOP;
      DELETE FROM mbd_k_r WHERE nd=ND_;
      DELETE FROM mbd_k_r WHERE nd=ND_Old_ AND ref in (Ref1_,Ref2_);   -- один из Ref1_,Ref2_ принадлежит "старой сделке"
      DELETE FROM nd_acc  WHERE nd=ND_;
      DELETE FROM cc_add  WHERE nd=ND_;
      DELETE FROM cc_prol WHERE nd=ND_;
      DELETE FROM cc_docs WHERE nd=ND_;
      DELETE FROM cc_deal WHERE nd=ND_;

    EXCEPTION
      WHEN err THEN
        raise_application_error(-(20000+ern),'\'||erm,TRUE);
      WHEN OTHERS THEN
        raise_application_error(-(20000+ern),SQLERRM,TRUE);
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
      --logger.info ('MBK = F_GetNazn1 = MaskId_=ND_'||'старт'||'='||MaskId_||'='||ND_);

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
        BEGIN
          SELECT sqlval INTO SqlVal_ FROM mbk_descr WHERE id=sPar_ ;
          SqlVal_ := Replace(SqlVal_, ':ND', to_char(ND_)) ;
          OPEN refcur FOR SqlVal_ ;
          FETCH refcur INTO sTmp_;
          CLOSE refcur;
        EXCEPTION WHEN NO_DATA_FOUND THEN
          sTmp_ := '' ;
        END;
        --logger.info ('MBK = F_GetNazn2 =sTmp_='||sTmp_);
        sNazn_ := Replace(sNazn_, '#'||sPar_||'#', sTmp_) ;
        sStr_  := sNazn_ ;
        n_     := InStr(sStr_,'#') ;
      END LOOP;
      --logger.info ('MBK = F_GetNazn2 = sNazn_'||'='||sNazn_||'=конец');

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
    --    Процедура отвязки залога ДЦП
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
    --    Процедура привязки договоров
    --
    procedure link_deal (p_nd number, p_ndi number)
    is
    begin
      update cc_deal set ndi = p_ndi where nd = p_nd;
    end link_deal;

/*    ----------------------------------------------------------------------
    --    Процедура привязки документа к договору
    --
    procedure link_nd_ref (p_nd number, p_ref number)
    is
    begin
        insert into mbd_k_r (nd, ref) values (p_nd, p_ref);
    exception when dup_val_on_index then null;
    end link_nd_ref;
*//*
    ------------------------------------------------------------------
    --    Процедура привязки документов к договорам
    --
    procedure link_docs (p_dat date)
    is
    begin
      -- выбираем договора
      for z in ( select nd, b_acc from mbk_deal )
      loop
         -- выбираем документы по договору:
         -- 1) док. по нач.%%
         for d in ( select unique o.ref
                      from opldok o
                     where o.acc  = z.b_acc
                       and o.fdat = p_dat
                       and not exists (select 1 from mbd_k_r where nd = z.nd and ref = o.ref) )
         loop
            link_nd_ref(z.nd, d.ref);
         end loop;
         -- 1) док. по залогам
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
        l_date_through date := p_deal_expiry_date - 1; -- в останній день угоди відсотки не нараховуються, в цей день угода вже не працює (може відрізнятися для інших банків)
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
                raise_application_error(-20000, 'Клієнт з ідентифікатором {' ||
                                                tools.number_list_to_string(l_mismatch_list, p_splitting_symbol => ', ', p_ceiling_length => 100) ||
                                                '} не існує або закритий');
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
                                 'Виконати',    -- 'DisR', '1',
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

    function get_receiving_transaction_code(
        p_deal_kind_id in integer,
        p_debit_account in varchar2,
        p_interest_account_number in varchar2)
    return varchar2
    is
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
                 raise_application_error(-20000, 'Документ з ідентифікатором {' || p_document_id || '} не знайдений');
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
/*
        l_account_number := f_newnls2(acc2_ => null,
                                      descrname_ => 'ZAL',
                                      nbs2_ => l_cc_pawn_row.nbsz,
                                      rnk2_ => l_deal_row.rnk,
                                      idd2_ => null);

        op_reg(mod_ => 2,
               p1_ => p_deal_id,
               p2_ => p_pawn_kind_id,
               p3_ => p_pawn_location_id,
               p4_ => l_dummy,
               rnk_ => l_deal_row.rnk,
               nls_ => l_account_number,
               kv_ => l_cc_add_row.kv,
               nms_ => l_customer_row.nmk || ' Забезпечення',
               tip_ => 'ZAL',
               isp_ => user_id(),
               accR_ => l_account_row.acc);

        l_account_row := account_utl.read_account(l_account_row.acc);

        dbms_output.put_line('grp: ' || l_account_row.grp);
*/
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
/*
        p_pawn_nd(p_nd => l_deal_row.nd,
                  p_accZ => l_account_row.acc,
                  p_ob22 => l_cc_pawn_row.ob22_uo,
                  p_accS => l_cc_add_row.accs,
                  p_grp => null,
                  p_ree => p_registry_number,
                  p_cc_idz => p_pawn_contract_number,
                  p_sdatz => p_start_date,
                  p_mdatz => p_expiry_date,
                  p_idz => user_id(),
                  p_sv => p_pawn_fair_value,
                  p_dpt => p_deposit_id,
                  p_12 => 1);
*/
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
                 raise_application_error(-20000, 'Значення ліміту для рахунку {' || p_account_number ||
                                                 '} на дату {' || to_char(p_limit_date, 'dd.mm.yyyy') || '} вже вказано');
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
            raise_application_error(-20000, 'Неможливо ідентифікувати рядок для видалення');
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
 
