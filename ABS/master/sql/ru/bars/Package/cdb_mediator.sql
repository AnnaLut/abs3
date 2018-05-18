
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cdb_mediator.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CDB_MEDIATOR is

    DEAL_TYPE_LENDING              constant integer := 1;
    DEAL_TYPE_BORROWING            constant integer := 2;

    -- вид залишку, на який нараховується відсоток
    BALANCE_KIND_OFF_BANK_DATE     constant integer := 0; -- вихідний на банківську дату
    BALANCE_KIND_OPENING_BANK_DATE constant integer := 1; -- вхідний на банківську дату
    BALANCE_KIND_OFF_CALENDAR      constant integer := 3; -- вихідний на календарну дату
    BALANCE_KIND_OPENING_CALENDAR  constant integer := 4; -- вхідний нв календарну дату

    ACCOUNT_NUMBER_ALG             constant char(3 char) := 'MFK';

    PRODUCT_ID_LENDING             constant integer := 3902;
    PRODUCT_ID_BORROWING           constant integer := 3903;

    BALANCE_ACC_LENT_FUNDS         constant varchar2(4 char) := '3902';
    BALANCE_ACC_BORROWED_FUNDS     constant varchar2(4 char) := '3903';
    BALANCE_ACC_DEPOSIT_INTEREST   constant varchar2(4 char) := '3904';
    BALANCE_ACC_LOAN_INTEREST      constant varchar2(4 char) := '3905';

    INTEREST_KIND_ASSETS           constant integer := 0;
    INTEREST_KIND_LIABILITIES      constant integer := 1;

    ACCOUNT_TYPE_ASSETS            constant integer := 1;
    ACCOUNT_TYPE_LIABILITIES       constant integer := 2;
    ACCOUNT_TYPE_NOMINAL           constant integer := 3;

    DEAL_STATE_NORMAL              constant integer := 10;
    DEAL_STATE_CLOSED              constant integer := 15;

    procedure generate_account_numbers(
        p_our_customer_id in integer,
        p_balance_account in varchar2,
        p_currency_code in integer,
        p_account_numbers out varchar2,
        p_error_message out varchar2);

    procedure get_account_rest(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_account_rest out number,
        p_error_message out varchar2);

    procedure get_deal_amount(
        p_deal_id in integer,
        p_deal_amount out number,
        p_error_message out varchar2);

    procedure get_deal_expiry_date(
        p_deal_id in integer,
        p_deal_expiry_date out date,
        p_error_message out varchar2);

    procedure open_credit_contract(
        p_contract_number in varchar2,
        p_product_id in integer,
        p_contract_type in integer,
        p_currency_code in integer,
        p_party_id in integer,
        p_party_mfo in varchar2,
        p_party_name varchar2,
        p_contract_date in date,
        p_expiry_date in date,
        p_interest_rate in number,
        p_amount in number,

        p_base_year in integer,
        p_balance_kind in integer,

        p_main_debt_account varchar2,
        p_interest_account varchar2,
        p_party_main_debt_account in varchar2,
        p_party_interest_account in varchar2,
        p_transit_account in varchar2,

        p_payment_purpose in varchar2,

        p_deal_id out integer,
        p_main_account_id out integer,
        p_interest_account_id out integer,
        p_error_message out varchar2);

    procedure make_document(
        p_deal_id in integer,
        p_operation_type in varchar2,
        p_party_a in integer,
        p_party_b in integer,
        p_mfo_a in varchar2,
        p_mfo_b in varchar2,
        p_account_a in varchar2,
        p_account_b in varchar2,
        p_document_kind_id in integer,
        p_document_date in date,
        p_amount in number,
        p_currency in integer,
        p_purpose in varchar2,
        p_operation_id out integer,
        p_error_message out varchar2);

    procedure check_deal_before_close(
        p_deal_id in integer,
        p_error_message out varchar2);

    procedure check_account_before_close(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_error_message out varchar2);

    procedure close_account(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_close_date in date,
        p_error_message out varchar2);

    procedure close_credit_deal(
        p_deal_id in integer,
        p_close_date in date,
        p_error_message out varchar2);

    procedure close_empty_accounts(p_date in date);

    procedure set_deal_amount(
        p_deal_id in integer,
        p_deal_amount in number,
        p_error_message out varchar2);

    procedure get_deal_interest_rate(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rate_date in date,
        p_rate_start_date out date,
        p_interest_rate out number,
        p_error_message out varchar2);

    procedure set_interest_rate(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_rate_kind in integer,
        p_rate_date in date,
        p_rate_value in number,
        p_error_message out varchar2);

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_error_message out varchar2);

    procedure check_deal_interest_rates(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rates in varchar2,
        p_error_message out varchar2);

    procedure add_deal_comment(
        p_deal_id in integer,
        p_deal_comment in varchar2,
        p_error_message out varchar2);
		
    procedure pay_selected_interest(
        p_reckoning_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.CDB_MEDIATOR as

    function read_exchange_of_resources(
        p_mfo in varchar2,
        p_raise_ndf in boolean default true)
    return exchange_of_resources%rowtype
    is
        l_exchange_of_resources_row exchange_of_resources%rowtype;
    begin
        select *
        into   l_exchange_of_resources_row
        from   exchange_of_resources er
        where  er.mfo = p_mfo;

        return l_exchange_of_resources_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Параметри рахунків кредитних ресурсів для філіалу {' || p_mfo || '} не знайдено');
             else return null;
             end if;
    end;

    function read_int_accn(
        p_account_id in integer,
        p_interest_kind integer,
        p_raise_ndf in boolean default true)
    return int_accn%rowtype
    is
        l_int_accn_row int_accn%rowtype;
    begin
        select *
        into   l_int_accn_row
        from   int_accn n
        where  n.acc = p_account_id and
               n.id = p_interest_kind;

        return l_int_accn_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000,
                                         'Параметри процентів для рахунку з ідентифікатором {' || p_account_id ||
                                         '} для виду {' || p_interest_kind ||
                                         '} не знайдені');
             else return null;
             end if;
    end;

    function read_operation_type(p_operation_type in varchar2, p_raise_ndf in boolean default true)
    return tts%rowtype
    is
        l_operation_type_row tts%rowtype;
    begin
        select *
        into   l_operation_type_row
        from   tts t
        where  t.tt = p_operation_type;

        return l_operation_type_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Тип операції з кодом {' || p_operation_type || '} не знайдений');
             else return null;
             end if;
    end;

    function read_credit_kind(p_kind_id in integer, p_raise_ndf in boolean default true)
    return cc_vidd%rowtype
    is
        l_credit_kind_row cc_vidd%rowtype;
    begin
        select *
        into   l_credit_kind_row
        from   cc_vidd k
        where  k.vidd = p_kind_id;

        return l_credit_kind_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Вид кредитних угод з ідентифікатором {' || p_kind_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_credit_deal(p_deal_id in integer, p_lock in boolean default false, p_raise_ndf in boolean default true)
    return cc_deal%rowtype
    is
        l_cc_deal_row cc_deal%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_cc_deal_row
            from   cc_deal d
            where  d.nd = p_deal_id
            for update;
        else
            select *
            into   l_cc_deal_row
            from   cc_deal d
            where  d.nd = p_deal_id;
        end if;

        return l_cc_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Кредитна угода з ідентифікатором {' || p_deal_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_cc_add(
        p_deal_id in integer,
        p_application_number in integer default 0,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_add%rowtype
    is
        l_cc_add_row cc_add%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_cc_add_row
            from   cc_add d
            where  d.nd = p_deal_id and
                   d.adds = p_application_number
            for update;
        else
            select *
            into   l_cc_add_row
            from   cc_add d
            where  d.nd = p_deal_id and
                   d.adds = p_application_number;
        end if;

        return l_cc_add_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Додаток {' || p_application_number ||
                                        '} до кредитної угоди з ідентифікатором {' || p_deal_id ||
                                        '} не знайдений');
             else return null;
             end if;
    end;

    function get_last_cc_add_row(
        p_deal_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return cc_add%rowtype
    is
        l_cc_add_row cc_add%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_cc_add_row
            from   cc_add c
            where  c.rowid = (select min(d.rowid) keep (dense_rank last order by d.adds)
                              from   cc_add d
                              where  d.nd = p_deal_id)
            for update;
        else
            select *
            into   l_cc_add_row
            from   cc_add c
            where  c.rowid = (select min(d.rowid) keep (dense_rank last order by d.adds)
                              from   cc_add d
                              where  d.nd = p_deal_id);
        end if;

        return l_cc_add_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Не вдалося знайти жодного додатку до угоди з ідентифікатором {' || p_deal_id || '}');
             else return null;
             end if;
    end;

    function get_accr_interest_account_id(p_account_id in integer, p_interest_kind in integer)
    return integer
    is
    begin
        return read_int_accn(p_account_id, p_interest_kind, false).acra;
    end;

    function get_income_account(
        p_client_id in integer,
        p_balance_account in varchar2,
        p_currency in integer)
    return varchar2
    is
        l_account_id integer;
    begin
        l_account_id := f_proc_dr(p_client_id, 4, 1, 'MKD', p_balance_account, p_currency);
        return account_utl.get_account_number(l_account_id);
    end;

    function get_transit_account(p_mfo in varchar2)
    return varchar2
    is
    begin
        return read_exchange_of_resources(p_mfo, false).nls_cck_source;
    end;

    procedure set_deal_transit_account(p_deal_id in integer, p_transit_account in varchar2)
    is
    begin
        update cc_add d
        set    d.nls_1819 = p_transit_account
        where  d.nd = p_deal_id;
    end;

    procedure set_deal_amount(
        p_deal_id in integer,
        p_deal_amount in number)
    is
        l_cc_deal_row cc_deal%rowtype;
        l_cc_add_row cc_add%rowtype;
        l_int_accn_row int_accn%rowtype;
    begin
        bars_audit.financial('CDB: set_deal_amount:' || chr(10) ||
                             'p_deal_id     : ' || p_deal_id || chr(10) ||
                             'p_deal_amount : ' || p_deal_amount);
/*
        l_cc_deal_row := read_credit_deal(p_deal_id, p_lock => true);
        l_cc_add_row := get_last_cc_add_row(p_deal_id, p_lock => true);

        l_int_accn_row := read_int_accn(get_interest_kind(read_credit_kind(l_cc_deal_row.vidd).tipd));

        mbk.ro_deal(CC_ID_NEW => l_cc_deal_row.cc_id,
                    ND_ => l_cc_deal_row.nd,
                    nd_new => l_cc_deal_row.nd,
                    ACC_NEW => l_cc_add_row.accs,
                    nID_ => );
*/
        update cc_add d
        set    d.s = p_deal_amount
        where  d.nd = p_deal_id and
               d.adds = 0;
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date)
    is
        l_deal_accounts number_list;
    begin
        select a.acc
        bulk collect into l_deal_accounts
        from   accounts a
        where  a.acc in (select n.acc
                         from   nd_acc n
                         where  n.nd = p_deal_id)
        for update;

        update cc_deal d
        set    d.wdate = p_expiry_date
        where  d.nd = p_deal_id;

        forall i in indices of l_deal_accounts
            update accounts a set a.mdate = p_expiry_date where a.acc = l_deal_accounts(i);

        forall i in indices of l_deal_accounts
            update int_accn a set a.stp_dat = p_expiry_date - 1 where a.acc = l_deal_accounts(i);
    end;

    procedure add_deal_comment(p_deal_id in integer, p_deal_comment in varchar2)
    is
    begin
        if (p_deal_comment is not null) then
            insert into cdb_deal_comment
            values (p_deal_id, sysdate, p_deal_comment);
        end if;
    end;

    procedure generate_account_numbers(
        p_our_customer_id in integer,
        p_balance_account in varchar2,
        p_currency_code in integer,
        p_account_numbers out varchar2,
        p_error_message out varchar2)
    is
        l_income_expense_account_id integer;
    begin
        l_income_expense_account_id := f_proc_dr(p_our_customer_id, 4, 1, 'MKD', p_balance_account, p_currency_code);
        p_account_numbers := mbk.f_nls_mb(p_balance_account, p_our_customer_id, l_income_expense_account_id, p_currency_code, cdb_mediator.ACCOUNT_NUMBER_ALG);
    exception
        when others then
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    function get_account_interest_rate(
        p_account_id in integer,
        p_interest_kind in integer,
        p_interest_rate_date in date default null)
    return number
    is
        l_interest_rate number;
    begin
        select min(r.ir) keep (dense_rank last order by r.bdat)
        into   l_interest_rate
        from   int_ratn r
        where  r.acc = p_account_id and
               r.id = p_interest_kind and
               (r.bdat <= p_interest_rate_date or p_interest_rate_date is null);

        return l_interest_rate;
    end;

    function get_deal_interest_rate(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rate_date in date default null)
    return number
    is
        l_cc_add_row cc_add%rowtype;
    begin
        l_cc_add_row := get_last_cc_add_row(p_deal_id);

        return get_account_interest_rate(l_cc_add_row.accs, p_interest_kind, p_interest_rate_date);
    end;

    procedure get_account_rest(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_account_rest out number,
        p_error_message out varchar2)
    is
    begin
        p_account_rest := account_utl.read_account(p_account_number, p_currency_code).ostc;
    exception
        when others then
             p_account_rest := 0;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure get_deal_amount(
        p_deal_id in integer,
        p_deal_amount out number,
        p_error_message out varchar2)
    is
    begin
        p_deal_amount := read_credit_deal(p_deal_id).limit;
    exception
        when others then
             p_deal_amount := 0;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure get_deal_expiry_date(
        p_deal_id in integer,
        p_deal_expiry_date out date,
        p_error_message out varchar2)
    is
    begin
        p_deal_expiry_date := read_credit_deal(p_deal_id).wdate;
    exception
        when others then
             p_deal_expiry_date := date '0001-01-01';
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure get_deal_interest_rate(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rate_date in date,
        p_rate_start_date out date,
        p_interest_rate out number,
        p_error_message out varchar2)
    is
        l_cc_add_row cc_add%rowtype;
    begin
        l_cc_add_row := get_last_cc_add_row(p_deal_id);

        select min(r.ir) keep (dense_rank last order by r.bdat), max(r.bdat)
        into   p_interest_rate, p_rate_start_date
        from   int_ratn r
        where  r.acc = l_cc_add_row.accs and
               r.id = p_interest_kind and
               (r.bdat <= p_interest_rate_date or p_interest_rate_date is null);

        p_interest_rate := nvl(p_interest_rate, 0);
    exception
        when others then
             p_interest_rate := 0;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure open_credit_contract(
        p_contract_number in varchar2,
        p_product_id in integer,
        p_contract_type in integer,
        p_currency_code in integer,
        p_party_id in integer,
        p_party_mfo in varchar2,
        p_party_name varchar2,
        p_contract_date in date,
        p_expiry_date in date,
        p_interest_rate in number,
        p_amount in number,

        p_base_year in integer,
        p_balance_kind in integer,

        p_main_debt_account in varchar2,
        p_interest_account in varchar2,
        p_party_main_debt_account in varchar2,
        p_party_interest_account in varchar2,
        p_transit_account in varchar2,

        p_payment_purpose in varchar2,

        p_deal_id out integer,
        p_main_account_id out integer,
        p_interest_account_id out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_income_account_number varchar2(30 char);
        l_balance_account varchar2(4 char);
        l_interest_kind integer;
        l_party_name varchar2(38 char);
        l_payment_purpose varchar2(160 char);
    begin
        l_party_name := utl_encode.text_decode(p_party_name, encoding => utl_encode.base64);
        l_payment_purpose := utl_encode.text_decode(p_payment_purpose, encoding => utl_encode.base64);

        bars_audit.financial('CDB.open_credit_contract  : ' || chr(10) ||
                             'p_contract_number         : ' || p_contract_number         || chr(10) ||
                             'p_product_id              : ' || p_product_id              || chr(10) ||
                             'p_contract_type           : ' || p_contract_type           || chr(10) ||
                             'p_currency_code           : ' || p_currency_code           || chr(10) ||
                             'p_party_id                : ' || p_party_id                || chr(10) ||
                             'p_party_mfo               : ' || p_party_mfo               || chr(10) ||
                             'p_party_name              : ' || l_party_name              || chr(10) ||
                             'p_contract_date           : ' || p_contract_date           || chr(10) ||
                             'p_expiry_date             : ' || p_expiry_date             || chr(10) ||
                             'p_interest_rate           : ' || p_interest_rate           || chr(10) ||
                             'p_amount                  : ' || p_amount                  || chr(10) ||
                             'p_base_year               : ' || p_base_year               || chr(10) ||
                             'p_balance_kind            : ' || p_balance_kind            || chr(10) ||
                             'p_main_debt_account       : ' || p_main_debt_account       || chr(10) ||
                             'p_interest_account        : ' || p_interest_account        || chr(10) ||
                             'p_party_main_debt_account : ' || p_party_main_debt_account || chr(10) ||
                             'p_party_interest_account  : ' || p_party_interest_account  || chr(10) ||
                             'p_transit_account         : ' || p_transit_account         || chr(10) ||
                             'p_payment_purpose         : ' || l_payment_purpose);

        if (p_contract_type = cdb_mediator.DEAL_TYPE_LENDING) then
            l_balance_account := cdb_mediator.BALANCE_ACC_LENT_FUNDS;
            l_interest_kind := cdb_mediator.INTEREST_KIND_ASSETS;
        elsif (p_contract_type = cdb_mediator.DEAL_TYPE_BORROWING) then
            l_balance_account := cdb_mediator.BALANCE_ACC_BORROWED_FUNDS;
            l_interest_kind := cdb_mediator.INTEREST_KIND_LIABILITIES;
        else
            raise_application_error(-20000, 'Неочікуваний тип контракту {' || p_contract_type || '}');
        end if;

        l_income_account_number := get_income_account(p_party_id, l_balance_account, p_currency_code);
        if (l_income_account_number is null) then
            raise_application_error(-20000,
                                    'Не вдалось визначити рахунок доходів/витрат за процентами для філіалу {' || p_party_mfo ||
                                    '} балансового {' || l_balance_account ||
                                    '} та коду валюти {' || p_currency_code || '}');
        end if;

        if (p_transit_account is null) then
            raise_application_error(-20000,
                                    'Не вдалося визначити транзитний рахунок для операцій за кредитними ресурсами ' ||
                                    'для філіалу {' || p_party_mfo || '}');
        end if;

        mbk.inp_deal(p_contract_number,
                     p_product_id,
                     p_contract_type,
                     p_currency_code,
                     p_party_id,
                     p_contract_date,
                     p_contract_date,
                     p_expiry_date,
                     p_interest_rate,
                     null,                                                  -- op_ - арифметическая операция над ставкой
                     null,                                                  -- br_ - базовая ставка
                     p_amount,
                     p_base_year,
                     nIO_ => p_balance_kind,
                     S1_ => p_party_main_debt_account,                      -- Осн.Счет для банка Б
                     S2_ => p_party_mfo,                                    -- Код банка Б (mfo/bic) для осн.сч
                     S3_ => p_party_interest_account,                       -- Счет нач.% для банка Б
                     S4_ => p_party_mfo,                                    -- Код банка Б (mfo/bic) для сч нач.%
                     S5_ => null,                                           -- Счет для входа валюты!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                     NLSA_ => p_main_debt_account,                          -- Основной счет в нашем банке
                     NMS_ => l_party_name || ' ' || p_main_debt_account,    -- Наименование основного счета
                     NLSNA_ => p_interest_account,                          -- Счет начисленных % в нашем банке
                     NMSN_ => l_party_name || ' ' || p_interest_account,    -- Наименование счета начисленных %
                     NLSNB_ => p_party_interest_account,                    -- Счет нач.% для банка Б = S3_
                     NMKB_ => l_party_name,                                 -- Наименование клиента
                     Nazn_ => l_payment_purpose,                            -- Назначение платежа (% по дог. CC_ID)
                     NLSZ_ => null,                                         -- Счет обеспечения
                     nKVZ_ => null,                                         -- Валюта обеспечения
                     p_pawn => null,                                        -- код вида обеспечения
                     Id_DCP_ => null,                                       -- Id from dcp_p.id
                     S67_ => l_income_account_number,                       -- Счет доходов
                     nGrp_ => 0,                                            -- Группа доступа счетов
                     nIsp_ => user_id(),                                    -- Исполнитель
                     BICA_ => '',                                           -- BIC нашего банка
                     SSLA_ => '',                                           -- Счет VOSTRO у нашего банка-корреспонд
                     BICB_ => '',                                           -- BIC партнера
                     SSLB_ => '',                                           -- Счет VOSTRO партнера у его банка-корресп
                     SUMP_ => null,                                         -- Сумма %%
                     AltB_ => null,
                     IntermB_    => null,
                     IntPartyA_  => null,
                     IntPartyB_  => null,
                     IntIntermA_ => null,
                     IntIntermB_ => null,
                     ND_ => p_deal_id,
                     ACC1_ => p_main_account_id,
                     sErr_ => p_error_message);

        if (p_error_message is null) then
            set_deal_transit_account(p_deal_id, p_transit_account);
            p_interest_account_id := get_accr_interest_account_id(p_main_account_id, l_interest_kind);
        end if;

        commit;
    exception
        when others then
             -- TODO : write log
             rollback;
             p_deal_id := 0;
             p_main_account_id := 0;
             p_interest_account_id := 0;
             p_error_message := sqlerrm || chr(13) || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure make_document(
        p_deal_id integer,
        p_operation_type varchar2,
        p_party_a in integer,
        p_party_b in integer,
        p_mfo_a in varchar2,
        p_mfo_b in varchar2,
        p_account_a in varchar2,
        p_account_b in varchar2,
        p_document_kind_id in integer,
        p_document_date in date,
        p_amount in number,
        p_currency in integer,
        p_purpose in varchar2,
        p_operation_id out integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_tts_row tts%rowtype;

        l_customer_a_row customer%rowtype;
        l_customer_b_row customer%rowtype;

        l_purpose varchar2(160 char);
        l_amount number default p_amount * 100;
    begin
        l_purpose := utl_encode.text_decode(p_purpose, encoding => utl_encode.base64);

        bars_audit.trace('CDB.make_document' || chr(10) ||
                         'p_deal_id          : ' || p_deal_id          || chr(10) ||
                         'p_operation_type   : ' || p_operation_type   || chr(10) ||
                         'p_party_a          : ' || p_party_a          || chr(10) ||
                         'p_party_b          : ' || p_party_b          || chr(10) ||
                         'p_mfo_a            : ' || p_mfo_a            || chr(10) ||
                         'p_mfo_b            : ' || p_mfo_b            || chr(10) ||
                         'p_account_a        : ' || p_account_a        || chr(10) ||
                         'p_account_b        : ' || p_account_b        || chr(10) ||
                         'p_document_kind_id : ' || p_document_kind_id || chr(10) ||
                         'p_document_date    : ' || p_document_date    || chr(10) ||
                         'p_amount           : ' || p_amount           || chr(10) ||
                         'p_currency         : ' || p_currency         || chr(10) ||
                         'p_purpose          : ' || l_purpose);

        l_tts_row := read_operation_type(p_operation_type);

        l_customer_a_row := customer_utl.read_customer(p_party_a);
        l_customer_b_row := customer_utl.read_customer(p_party_b);

        gl.ref(p_operation_id);
        gl.in_doc4(ref_ => p_operation_id,
                   tt_ => p_operation_type,
                   vob_ => p_document_kind_id,
                   nd_ => to_char(p_operation_id),
                   pdat_ => sysdate,
                   vdat_ => bankdate,
                   dk_ => l_tts_row.dk,
                   kv_ => p_currency,
                   s_ => l_amount,
                   kv2_ => p_currency,
                   s2_ => l_amount,
                   sq_ => l_amount,
                   sk_ => l_tts_row.sk,
                   sub_ => null,
                   data_ => bankdate,
                   datp_ => bankdate,
                   nam_a_ => substr(l_customer_a_row.nmk, 1, 38),
                   nlsa_ => p_account_a,
                   mfoa_ => p_mfo_a,
                   nam_b_ => substr(l_customer_b_row.nmk, 1, 38),
                   nlsb_ => p_account_b,
                   mfob_ => p_mfo_b,
                   nazn_ => l_purpose,
                   d_rec_ => null,
                   id_a_ => l_customer_a_row.okpo,
                   id_b_ => l_customer_b_row.okpo,
                   id_o_ => null,
                   sign_ => null,
                   sos_ => case when p_operation_type = 'KV1' then 5   -- оминаючи візи
                                else null
                           end,
                   prty_ => 0,
                   uid_ => user_id);

        paytt(null,
              p_operation_id,
              bankdate,
              p_operation_type,
              l_tts_row.dk,
              p_currency,
              p_account_a,
              l_amount,
              p_currency,
              p_account_b,
              l_amount);

        mbk.link_nd_ref(p_deal_id, p_operation_id);

        commit;
    exception
        when others then
             rollback;
             p_operation_id := 0;
             p_error_message := sqlerrm || chr(13) || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure check_deal_before_close(
        p_deal_id in integer,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_accrued_interest_amount number;
        l_deal_row cc_deal%rowtype;
    begin
        l_deal_row := read_credit_deal(p_deal_id);

        -- перевірки запозичено з cck.cc_close

        -- есть ли остатки и тек.обороты на счетах КД?
/*
        for k in (select a.nls, a.kv
                  from   accounts a,
                         nd_acc n
                  where  a.acc = n.acc and
                         n.nd = l_deal_row.nd and
                         a.tip not in ('DEP', 'DEN', 'SS ', 'SN ') and
                         (a.ostc <> 0 or a.ostb <> 0 or a.ostf <> 0)) loop

            p_error_message := p_error_message || ' Рахунок ' || k.nls || '/' || k.kv || ' має залишок.';
        end loop;
*/
        -- все ли проценты начислены ?
        for k in (select a.acc, a.nls, a.kv, i.id,
                         nvl(i.acr_dat + 1, a.daos) dat1,
                         i.stp_dat
                  from   int_accn i,
                         nd_acc n,
                         accounts a
                  where  i.acc = a.acc and
                         a.acc = n.acc and
                         a.tip in ('DEP', 'SS ', 'SL ', 'SP ') and
                         n.nd = l_deal_row.nd and
                         -- nvl(i.acr_dat + 1, a.daos) < a.dapp and
                         i.id in (0, 1, 2) and
                         a.dazs is null) loop

            -- acrn.p_int(k.acc, k.id, k.dat1, nvl(k.stp_dat, gl.bd - 1), l_accrued_interest_amount, null, 1);
            acrn.p_int(k.acc, k.id, k.dat1, least(k.stp_dat, gl.bd - 1), l_accrued_interest_amount, null, 1);

            BARS_AUDIT.FINANCIAL('CDB:Сума нарахованих відсотків по рахунку ' || k.nls || ' = ' || l_accrued_interest_amount);
            if (nvl(l_accrued_interest_amount, 0) <> 0) then
                p_error_message:= p_error_message || ' Не нарахован' || case when k.id = 0 then 'і %'
                                                                            else 'а пеня'
                                                                       end ||
                                                     ' по рахунку ' || k.nls || '/' || k.kv;
            end if;
        end loop;

        rollback;
    exception
        when others then
             rollback;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure check_account_before_close(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_error_message out varchar2)
    is
        l_account_row accounts%rowtype;
    begin
        l_account_row := account_utl.read_account(p_account_number, p_currency_code);

        account_utl.check_account_before_close(l_account_row);
    exception
        when others then
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure close_account(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_close_date in date,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_account_row accounts%rowtype;
        l_close_date date default p_close_date;
    begin
        l_account_row := account_utl.read_account(p_account_number, p_currency_code, p_lock => true);

        if (l_account_row.dazs is not null) then
            raise_application_error(-20000, 'Рахунок {' || l_account_row.nls || '} вже закритий - дата закриття {' || l_account_row.dazs || '}');
        end if;

        account_utl.check_account_before_close(l_account_row);

        if (l_close_date is null) then
            l_close_date := bankdate + 1;
        end if;

        account_utl.set_account_close_date(l_account_row.acc, l_close_date);

        commit;
    exception
        when others then
             rollback;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure close_empty_accounts(p_date in date)
    is
    begin
        bars_audit.info('cdb_mediator.close_empty_accounts (start) : ' || p_date);

        for i in (select f.nd
                  from   (select d.nd,
                                 sum(case when a.ostc <> 0 or a.ostb <> 0 or a.ostf <> 0 or a.dapp >= bankdate() then 1
                                          else 0
                                     end) active_accounts_count
                          from   cc_deal d
                          join   nd_acc n on n.nd = d.nd
                          join   accounts a on a.acc = n.acc and a.dazs is null
                          where  d.vidd in (cdb_mediator.PRODUCT_ID_LENDING, cdb_mediator.PRODUCT_ID_BORROWING) and
                                 (d.sos = cdb_mediator.DEAL_STATE_CLOSED or d.wdate < (bankdate() - 30))
                          group by d.nd) f
                  where f.active_accounts_count = 0) loop
            for j in (select a.acc
                      from   nd_acc a
                      where  a.nd = i.nd) loop
                account_utl.set_account_close_date(j.acc, bankdate());
                bars_audit.info('cdb_mediator.close_empty_accounts (close account):' || chr(10) ||
                                'cc_deal.nd   : ' || i.nd || chr(10) ||
                                'accounts.acc : ' || j.acc || chr(10) ||
                                'close date   : ' || bankdate());
            end loop;
        end loop;
    exception
        when others then
             bars_audit.error('cdb_mediator.close_empty_accounts (exception):' || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure close_credit_deal(
        p_deal_id in integer,
        p_close_date in date,
        p_error_message out varchar2)
    is
        l_deal_row cc_deal%rowtype;
        -- l_cc_add_row cc_add%rowtype;
        -- l_main_account_row accounts%rowtype;
        -- l_credit_kind_row cc_vidd%rowtype;
        -- l_interest_account_id integer;
        -- l_interest_kind_id integer;
        -- l_interest_account_row accounts%rowtype;
    begin
        bars_audit.financial('cdb_mediator.close_credit_deal' || chr(10) ||
                             'p_deal_id    : ' || p_deal_id || chr(10) ||
                             'p_close_date : ' || p_close_date);

        l_deal_row := read_credit_deal(p_deal_id, true);

        if (l_deal_row.sos = cdb_mediator.DEAL_STATE_CLOSED) then
            return;
        end if;
/*
        l_cc_add_row := get_last_cc_add_row(p_deal_id, p_lock => true);
        l_main_account_row := account_utl.read_account(l_cc_add_row.accs, true);

        l_credit_kind_row := read_credit_kind(l_deal_row.vidd);
        if (l_credit_kind_row.tipd = cdb_mediator.DEAL_TYPE_LENDING) then
            l_interest_kind_id := cdb_mediator.INTEREST_KIND_ASSETS;
        else
            l_interest_kind_id := cdb_mediator.INTEREST_KIND_LIABILITIES;
        end if;

        l_interest_account_id := get_accr_interest_account_id(l_main_account_row.acc, l_interest_kind_id);
        l_interest_account_row := account_utl.read_account(l_interest_account_id, true);

        if (l_main_account_row.ostc <> 0 or l_main_account_row.ostb <> 0) then
            raise_application_error(-20000, 'Плановий та фактичний залишки рахунку ' || l_main_account_row.nls || ' мають бути 0.00 перед закриттям');
        end if;
        if (l_interest_account_row.ostc <> 0 or l_interest_account_row.ostb <> 0) then
            raise_application_error(-20000, 'Плановий та фактичний залишки рахунку ' || l_interest_account_row.nls || ' мають бути 0.00 перед закриттям');
        end if;

        update accounts a
        set    a.dazs = p_close_date
        where  a.acc = l_main_account_row.acc;

        update accounts a
        set    a.dazs = p_close_date
        where  a.acc = l_interest_account_row.acc;
*/
        update cc_deal d
        set    d.sos = cdb_mediator.DEAL_STATE_CLOSED
        where  d.nd = p_deal_id;

    exception
        when others then
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure set_deal_amount(
        p_deal_id in integer,
        p_deal_amount in number,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_deal_row cc_deal%rowtype;
    begin
        bars_audit.financial('CDB: set_deal_amount (web-service):' || chr(10) ||
                             'p_deal_id       : ' || p_deal_id || chr(10) ||
                             'p_deal_amount   : ' || p_deal_amount);
        l_deal_row := read_credit_deal(p_deal_id, true);
        set_deal_amount(l_deal_row.nd, p_deal_amount);
        commit;
    exception
        when others then
             rollback;
             bars_audit.financial('CDB: set_deal_amount (exception):' || chr(10) ||
                                  'p_deal_id       : ' || p_deal_id || chr(10) ||
                                  'p_deal_amount   : ' || p_deal_amount || chr(10) ||
                                  'p_error_message : ' || sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure set_interest_rate(
        p_account_number in varchar2,
        p_currency_code in integer,
        p_rate_kind in integer,
        p_rate_date in date,
        p_rate_value in number,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_account_row accounts%rowtype;
    begin
        if (p_rate_date is null) then
            raise_application_error(-20000, 'Дата початку дії ставки не вказана');
        end if;

        l_account_row := account_utl.read_account(p_account_number, p_currency_code);

        if (p_rate_value is null) then
            bars_audit.financial('CDB: ' ||
                                 'Видалення процентної ставки виду {' || p_rate_kind ||
                                 '} по рахунку {' || l_account_row.acc ||
                                 '} на дату {' || p_rate_date || '}');

            delete int_ratn r
            where  r.acc = l_account_row.acc and
                   r.id = p_rate_kind and
                   r.bdat = p_rate_date;
        else

            bars_audit.financial('CDB: ' ||
                                 'Установка процентної ставки {' || p_rate_value || '%} виду {' || p_rate_kind ||
                                 '} по рахунку {' || l_account_row.acc ||
                                 '} на дату {' || p_rate_date || '}');

            merge into int_ratn r
            using (select l_account_row.acc acc,
                          p_rate_kind id,
                          p_rate_date bdat,
                          p_rate_value ir
                   from   DUAL) s
            on (r.acc = s.acc and r.id = s.id and r.bdat = s.bdat)
            when matched then
            update set r.ir = s.ir
            when not matched then
            insert (acc, id, bdat, ir, br, op, idu)
            values (s.acc, s.id, s.bdat, s.ir, null, null, user_id);

            -- при встановленні відсоткової ставки ми вважаємо, що встановлюємо останню діючу ставку, і після цієї ставки
            -- інших значень немає. Тобто ми не вставляємо значень "всередину" історії ставок.
            -- У разі, якщо ставки з більшою датою знайдені, видалимо "зайві" записи...
            for i in (select r.bdat, r.ir, r.rowid from int_ratn r
                      where r.acc = l_account_row.acc and
                            r.id = p_rate_kind and
                            r.bdat > p_rate_date) loop

                bars_audit.financial('CDB: ' ||
                                     'Видалення процентної ставки {' || i.ir || '%} виду {' || p_rate_kind ||
                                     '} по рахунку {' || l_account_row.acc ||
                                     '} на дату {' || i.bdat || '}');

                delete from int_ratn r where r.rowid = i.rowid;
            end loop;
        end if;

        commit;
    exception
        when others then
             rollback;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_error_message out varchar2)
    is
        pragma autonomous_transaction;
        l_deal_row cc_deal%rowtype;
    begin
        l_deal_row := read_credit_deal(p_deal_id, true);
        set_deal_expiry_date(l_deal_row.nd, p_expiry_date);
        commit;
    exception
        when others then
             rollback;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure check_deal_interest_rates(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rates in varchar2,
        p_error_message out varchar2)
    is
        l_interest_rates t_date_number_pairs;
        l_bars_interest_rates t_date_number_pairs;
        l_xmltext varchar2(32767 byte);
        l_distinct_interest_rates t_date_number_pairs;
        l_cc_add_row cc_add%rowtype;
    begin
        l_xmltext := translate(p_interest_rates, '?!', '<>');

        bars_audit.financial('CDB: ' || l_xmltext);
        select t_date_number_pair(to_date(substr(extractvalue(column_value, '/DateNumberPair/DateValue'), 1, 10), 'YYYY-MM-DD'),
                                  to_number(extractvalue(column_value, '/DateNumberPair/NumberValue'), '9999999999999999D999999999999'))
        bulk collect into l_interest_rates
        from table(XMLSequence(xmltype(l_xmltext).extract('/DateNumberPairs/DateNumberPair')));

        l_cc_add_row := get_last_cc_add_row(p_deal_id);

        select t_date_number_pair(r.bdat, r.ir)
        bulk collect into l_bars_interest_rates
        from   int_ratn r
        where  r.acc = l_cc_add_row.accs and
               r.id = p_interest_kind;

        l_distinct_interest_rates := l_bars_interest_rates multiset except distinct l_interest_rates;

        if (l_distinct_interest_rates is not empty) then
            raise_application_error(-20000,
                                    'Ставка {' || l_distinct_interest_rates(1).number_value ||
                                    '%} за дату {' || to_char(l_distinct_interest_rates(1).date_value, 'DD.MM.YYYY') ||
                                    '} присутня в АБС, але відсутня в ЦБД - налаштування ставок АБС і ЦБД повинні співпадати');
        end if;

        l_distinct_interest_rates := l_interest_rates multiset except distinct l_bars_interest_rates;

        if (l_distinct_interest_rates is not empty) then
            raise_application_error(-20000,
                                    'Ставка {' || l_distinct_interest_rates(1).number_value ||
                                    '%} за дату {' || to_char(l_distinct_interest_rates(1).date_value, 'DD.MM.YYYY') ||
                                    '} присутня в ЦБД, але відсутня в АБС - налаштування ставок АБС і ЦБД повинні співпадати');
        end if;
    exception
        when others then
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure add_deal_comment(
        p_deal_id in integer,
        p_deal_comment in varchar2,
        p_error_message out varchar2)
    is
        l_deal_comment varchar2(4000 byte);
    begin
        l_deal_comment := utl_encode.text_decode(p_deal_comment, encoding => utl_encode.base64);

        add_deal_comment(p_deal_id, l_deal_comment);
    exception
        when others then
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;
	
		    -- obsolete
    procedure pay_selected_interest(
        p_reckoning_id in integer)
    is
        l_int_reckoning_row int_reckoning%rowtype;
    begin
        --bars_audit.log_info('cdb_mediator.pay_selected_interest', 'p_reckoning_id : ' || p_reckoning_id);

        l_int_reckoning_row := interest_utl.lock_reckoning_row(p_reckoning_id, p_skip_locked => true);

        if (l_int_reckoning_row.id is not null) then
            interest_utl.pay_int_reckoning_row(l_int_reckoning_row, p_silent_mode => true, p_do_not_store_interest_tails => true);
        end if;
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  CDB_MEDIATOR ***
grant EXECUTE                                                                on CDB_MEDIATOR    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/cdb_mediator.sql =========*** End **
 PROMPT ===================================================================================== 
 