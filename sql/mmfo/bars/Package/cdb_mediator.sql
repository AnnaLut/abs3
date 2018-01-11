
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/cdb_mediator.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CDB_MEDIATOR is

    DEAL_TYPE_LENDING              constant integer := 1;
    DEAL_TYPE_BORROWING            constant integer := 2;

    ACCOUNT_NUMBER_ALG             constant char(3 char) := 'MFK';

    PRODUCT_ID_LENDING             constant integer := 3902;
    PRODUCT_ID_BORROWING           constant integer := 3903;

    BALANCE_ACC_LENT_FUNDS         constant varchar2(4 char) := '3902';
    BALANCE_ACC_BORROWED_FUNDS     constant varchar2(4 char) := '3903';
    BALANCE_ACC_DEPOSIT_INTEREST   constant varchar2(4 char) := '3904';
    BALANCE_ACC_LOAN_INTEREST      constant varchar2(4 char) := '3905';

    DEAL_STATE_NORMAL              constant integer := 10;
    DEAL_STATE_CLOSED              constant integer := 15;

    type t_make_document_url is record
    (
         operation_type_name varchar2(4000 byte),
         debit_account varchar2(4000 byte),
         credit_account varchar2(4000 byte),
         debit_mfo varchar2(4000 byte),
         credit_mfo varchar2(4000 byte),
         amount number,
         currency_code integer,
         purpose varchar2(4000 byte),
         url varchar2(4000 byte),
         url_stp varchar2(4000 byte)
    );

    type t_make_document_urls is table of t_make_document_url;

    procedure generate_account_numbers(
        p_our_customer_id in integer,
        p_balance_account in varchar2,
        p_currency_code in integer,
        p_account_numbers out varchar2,
        p_error_message out varchar2);

    procedure generate_account_numbers(
        p_product_id in integer,
        p_currency_id in integer,
        p_main_account out varchar2,
        p_interest_account out varchar2);

    function get_expected_interest_amount(
        p_product_id in integer,
        p_open_date in date,
        p_expiry_date in date,
        p_deal_amount in number,
        p_currency_id in integer,
        p_interest_rate in number,
        p_interest_base in integer)
    return number;

    function get_mfo_customer_name(
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'))
    return varchar2;

    procedure get_mfo_customer_name(
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'),
        p_customer_id out integer,
        p_customer_name out varchar2);

    function get_customer_mfo(
        p_customer_id in integer)
    return varchar2;

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

    procedure open_credit_contract(
        p_contract_number in varchar2,
        p_product_id in integer,
        p_partner_id in integer,
        p_contract_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_code in integer,
        p_interest_rate in number,
        p_interest_base in integer,
        p_main_account in varchar2,
        p_interest_account in varchar2,
        p_party_main_account in varchar2,
        p_party_interest_account in varchar2);

    procedure edit_deal(
        p_deal_id in integer,
        p_expiry_date in date,
        p_deal_amount in number,
        p_interest_rate in number,
        p_partner_main_account in varchar2,
        p_partner_interest_account in varchar2);

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

    procedure close_deal(
        p_deal_id in integer);

    procedure close_deal_with_accounts(
        p_deal_id in integer,
        p_close_date in date);

    procedure reopen_deal(
        p_deal_id in integer);

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

    function make_docinput(
        p_deal_id in integer)
    return t_make_document_urls
    pipelined;

    procedure prepare_interest(
        p_deal_id in varchar2,
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_date_to in date);

    procedure prepare_portfolio_interest(
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_deal_expiry_date in date,
        p_deal_rest in number,
        p_date_to in date);

    procedure reckon_deal_interest(
        p_deal_id in integer,
        p_date_to in date,
        p_grouping_mode_id in integer);

    procedure reckon_portfolio_interest(
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_deal_expiry_date in date,
        p_deal_rest in number,
        p_date_to in date);

    procedure accrue_interest(
        p_reckoning_id in varchar2);

    procedure accrue_interest(
        p_dictionary_list in t_dictionary_list,
        l_message out varchar2);

    procedure accrue_interest(
        p_dictionary_list in t_dictionary_list);

    procedure accrue_deal_interest(
        p_deal_id in integer);

    procedure accrue_portfolio_interest(
        p_filter in varchar2);

    procedure pay_selected_interest(
        p_reckoning_id in integer);

    procedure pay_interest(
        p_reckoning_id in integer);

    procedure pay_interest(
        p_dictionary_list in t_dictionary_list);

    procedure pay_deal_interest(
        p_deal_id in integer);

    procedure pay_portfolio_interest(
        p_filter in varchar2);

    procedure redact_reckoning(
        p_reckoning_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2);

    procedure remove_reckoning(
        p_reckoning_id in integer);



    -- obsolete
    procedure pay_accrued_interest;

    -- obsolete
    procedure send_accrued_interest(
        p_filter_string varchar2);

    -- obsolete
    procedure remove_selected_reckoning(
        p_reckoning_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.CDB_MEDIATOR as

    function read_operation_type(
        p_operation_type in varchar2,
        p_raise_ndf in boolean default true)
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
    begin
        bars_audit.financial('CDB: set_deal_amount:' || chr(10) ||
                             'p_deal_id     : ' || p_deal_id || chr(10) ||
                             'p_deal_amount : ' || p_deal_amount);
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

    function get_branch_customer_id(
        p_branch in varchar2 default sys_context('bars_context', 'user_branch'))
    return integer
    is
    begin
        return branch_attribute_utl.get_value(p_branch, 'RNK');
    end;

    function get_mfo_customer_id(
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'))
    return integer
    is
    begin
        return get_branch_customer_id(bars_context.make_branch(p_mfo));
    end;

    function get_mfo_customer_name(
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'))
    return varchar2
    is
    begin
        return customer_utl.read_customer(get_mfo_customer_id(p_mfo), p_raise_ndf => false).nmk;
    end;

    procedure get_mfo_customer_name(
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'),
        p_customer_id out integer,
        p_customer_name out varchar2)
    is
    begin
        p_customer_id := get_mfo_customer_id(p_mfo);
        p_customer_name := customer_utl.read_customer(p_customer_id, p_raise_ndf => false).nmk;
    end;

    function get_customer_mfo(
        p_customer_id in integer)
    return varchar2
    is
    begin
        return customer_utl.get_customer_mfo(p_customer_id);
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
        bars_audit.info('cdb_mediator.generate_account_numbers' || chr(10) ||
                        'p_our_customer_id : ' || p_our_customer_id  || chr(10) ||
                        'p_balance_account : ' || p_balance_account  || chr(10) ||
                        'p_currency_code   : ' || p_currency_code);

        l_income_expense_account_id := f_proc_dr(p_our_customer_id, 4, 1, 'MKD', p_balance_account, p_currency_code);
        p_account_numbers := mbk.f_nls_mb(p_balance_account, p_our_customer_id, l_income_expense_account_id, p_currency_code, cdb_mediator.ACCOUNT_NUMBER_ALG);
    exception
        when others then
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
             bars_audit.error('cdb_mediator.generate_account_numbers (exception)' || chr(10) ||
                              p_error_message);
    end;

    procedure generate_account_numbers(
        p_product_id in integer,
        p_currency_id in integer,
        p_main_account out varchar2,
        p_interest_account out varchar2)
    is
        l_income_expense_account_id integer;
        l_account_numbers varchar2(30 char);
        l_our_customer_id integer;
    begin
        l_our_customer_id := get_mfo_customer_id();
        l_income_expense_account_id := f_proc_dr(l_our_customer_id, 4, 1, 'MKD', p_product_id, p_currency_id);
        l_account_numbers := mbk.f_nls_mb(p_product_id, l_our_customer_id, l_income_expense_account_id, p_currency_id, cdb_mediator.ACCOUNT_NUMBER_ALG);
        p_main_account := trim(substr(l_account_numbers, 1, 14));
        p_interest_account := trim(substr(l_account_numbers, 16));
    end;

    function get_expected_interest_amount(
        p_product_id in integer,
        p_open_date in date,
        p_expiry_date in date,
        p_deal_amount in number,
        p_currency_id in integer,
        p_interest_rate in number,
        p_interest_base in integer)
    return number
    is
        l_dig integer;
    begin
        select t.dig
        into   l_dig
        from   tabval t
        where  t.kv = p_currency_id;

        return round(calp_br(p_deal_amount * power(10, l_dig), p_interest_rate, p_open_date, p_expiry_date, p_interest_base) / 100, 2);
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
        l_cc_add_row := cck_utl.read_cc_add(p_deal_id);

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
        p_deal_amount := cck_utl.read_cc_deal(p_deal_id).limit;
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
        p_deal_expiry_date := cck_utl.read_cc_deal(p_deal_id).wdate;
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
        l_cc_add_row := cck_utl.read_cc_add(p_deal_id);

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

    procedure set_interest_rate_utl(
        p_account_row in accounts%rowtype,
        p_rate_kind in integer,
        p_rate_date in date,
        p_rate_value in number)
    is
    begin
        if (p_rate_date is null) then
            raise_application_error(-20000, 'Дата початку дії ставки не вказана');
        end if;

        if (p_rate_value is null) then
            bars_audit.financial('CDB: ' ||
                                 'Видалення процентної ставки виду {' || p_rate_kind ||
                                 '} по рахунку {' || p_account_row.acc ||
                                 '} на дату {' || p_rate_date || '}');

            delete int_ratn r
            where  r.acc = p_account_row.acc and
                   r.id = p_rate_kind and
                   r.bdat = p_rate_date;
        else

            bars_audit.financial('CDB: ' ||
                                 'Установка процентної ставки {' || p_rate_value || '%} виду {' || p_rate_kind ||
                                 '} по рахунку {' || p_account_row.acc ||
                                 '} на дату {' || p_rate_date || '}');

            merge into int_ratn r
            using (select p_account_row.acc acc,
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
                      where r.acc = p_account_row.acc and
                            r.id = p_rate_kind and
                            r.bdat > p_rate_date) loop

                bars_audit.financial('CDB: ' ||
                                     'Видалення процентної ставки {' || i.ir || '%} виду {' || p_rate_kind ||
                                     '} по рахунку {' || p_account_row.acc ||
                                     '} на дату {' || i.bdat || '}');

                delete from int_ratn r where r.rowid = i.rowid;
            end loop;
        end if;
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
            l_interest_kind := interest_utl.INTEREST_KIND_ASSETS;
        elsif (p_contract_type = cdb_mediator.DEAL_TYPE_BORROWING) then
            l_balance_account := cdb_mediator.BALANCE_ACC_BORROWED_FUNDS;
            l_interest_kind := interest_utl.INTEREST_KIND_LIABILITIES;
        else
            raise_application_error(-20000, 'Неочікуваний тип контракту {' || p_contract_type || '}');
        end if;

        l_income_account_number := mbk.get_income_account(l_balance_account, p_party_id, p_currency_code);
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
            p_interest_account_id := interest_utl.get_interest_account_id(p_main_account_id, l_interest_kind);
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

    procedure open_credit_contract(
        p_contract_number in varchar2,
        p_product_id in integer,
        p_partner_id in integer,
        p_contract_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_code in integer,
        p_interest_rate in number,
        p_interest_base in integer,
        p_main_account in varchar2,
        p_interest_account in varchar2,
        p_party_main_account in varchar2,
        p_party_interest_account in varchar2)
    is
        l_income_account_number varchar2(30 char);
        l_balance_account varchar2(4 char);
        l_payment_purpose varchar2(160 char);
        l_customer_row customer%rowtype;
        l_product_row cc_vidd%rowtype;
        l_custbank_row custbank%rowtype;
        p_transit_account varchar2(30 char);
        p_deal_id integer;
        p_main_account_id integer;
        p_error_message varchar2(32767 byte);
    begin
        bars_audit.info('cdb_mediator.open_credit_contract : ' || chr(10) ||
                        'p_contract_number        : ' || p_contract_number        || chr(10) ||
                        'p_product_id             : ' || p_product_id             || chr(10) ||
                        'p_partner_id             : ' || p_partner_id             || chr(10) ||
                        'p_contract_date          : ' || p_contract_date          || chr(10) ||
                        'p_expiry_date            : ' || p_expiry_date            || chr(10) ||
                        'p_amount                 : ' || p_amount                 || chr(10) ||
                        'p_currency_code          : ' || p_currency_code          || chr(10) ||
                        'p_interest_rate          : ' || p_interest_rate          || chr(10) ||
                        'p_interest_base          : ' || p_interest_base          || chr(10) ||
                        'p_main_account           : ' || p_main_account           || chr(10) ||
                        'p_interest_account       : ' || p_interest_account       || chr(10) ||
                        'p_party_main_account     : ' || p_party_main_account     || chr(10) ||
                        'p_party_interest_account : ' || p_party_interest_account);

        l_product_row := cck_utl.read_cc_vidd(p_product_id);

        if (l_product_row.tipd = cdb_mediator.DEAL_TYPE_LENDING) then
            l_balance_account := cdb_mediator.BALANCE_ACC_LENT_FUNDS;
            l_payment_purpose := 'Розміщення коштів згідно угоди ' || p_contract_number || ' від ' || to_char(p_contract_date, 'dd.mm.yyyy');
        elsif (l_product_row.tipd = cdb_mediator.DEAL_TYPE_BORROWING) then
            l_balance_account := cdb_mediator.BALANCE_ACC_BORROWED_FUNDS;
            l_payment_purpose := 'Залучення коштів згідно угоди ' || p_contract_number || ' від ' || to_char(p_contract_date, 'dd.mm.yyyy');
        else
            raise_application_error(-20000, 'Неочікуваний тип контракту {' || l_product_row.tipd || '}');
        end if;

        l_customer_row := customer_utl.read_customer(p_partner_id);

        l_income_account_number := mbk.get_income_account(l_balance_account, p_partner_id, p_currency_code);
        if (l_income_account_number is null) then
            raise_application_error(-20000,
                                    'Не вдалось визначити рахунок доходів/витрат за процентами для філіалу {' || l_custbank_row.mfo ||
                                    '} балансового {' || l_balance_account ||
                                    '} та коду валюти {' || p_currency_code || '}');
        end if;

        p_transit_account := '37390';
/*        if (p_transit_account is null) then
            raise_application_error(-20000,
                                    'Не вдалося визначити транзитний рахунок для операцій за кредитними ресурсами ' ||
                                    'для філіалу {' || p_party_mfo || '}');
        end if;
*/
        mbk.inp_deal(p_contract_number,
                     p_product_id,
                     l_product_row.tipd,
                     p_currency_code,
                     p_partner_id,
                     p_contract_date,
                     p_contract_date,
                     p_expiry_date,
                     p_interest_rate,
                     null,                                                  -- op_ - арифметическая операция над ставкой
                     null,                                                  -- br_ - базовая ставка
                     p_amount,
                     p_interest_base,
                     nIO_ => 0,
                     S1_ => p_party_main_account,                           -- Осн.Счет для банка Б
                     S2_ => l_custbank_row.mfo,                             -- Код банка Б (mfo/bic) для осн.сч
                     S3_ => p_party_interest_account,                       -- Счет нач.% для банка Б
                     S4_ => l_custbank_row.mfo,                             -- Код банка Б (mfo/bic) для сч нач.%
                     S5_ => null,                                           -- Счет для входа валюты!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                     NLSA_ => p_main_account,                               -- Основной счет в нашем банке
                     NMS_ => l_customer_row.nmk || ' ' || p_main_account,   -- Наименование основного счета
                     NLSNA_ => p_interest_account,                          -- Счет начисленных % в нашем банке
                     NMSN_ => l_customer_row.nmk || ' ' || p_interest_account,    -- Наименование счета начисленных %
                     NLSNB_ => p_party_interest_account,                    -- Счет нач.% для банка Б = S3_
                     NMKB_ => l_customer_row.nmk,                           -- Наименование клиента
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
        end if;
    exception
        when others then
             rollback;
             bars_audit.info('cdb_mediator.open_credit_contract' || chr(10) ||
                             sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
             raise;
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

        cck_utl.link_document_to_deal(p_deal_id, p_operation_id);

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
        l_deal_row := cck_utl.read_cc_deal(p_deal_id);

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

        p_error_message := account_utl.can_close_account(l_account_row);
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
        l_account_row accounts%rowtype;
        l_close_date date default p_close_date;
    begin
        l_account_row := account_utl.read_account(p_account_number, p_currency_code, p_lock => true);

        p_error_message := account_utl.can_close_account(l_account_row);
        if (p_error_message is not null) then
            return;
        end if;

        if (l_close_date is null) then
            l_close_date := bankdate() + 1;
        end if;

        account_utl.close_account(l_account_row, l_close_date);
    exception
        when others then
             rollback;
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure close_deal(
        p_deal_id in integer)
    is
        l_deal_row cc_deal%rowtype;
    begin
        bars_audit.trace('cdb_mediator.close_deal' || chr(10) ||
                         'p_deal_id    : ' || p_deal_id);

        l_deal_row := cck_utl.read_cc_deal(p_deal_id, true);

        if (l_deal_row.sos = cdb_mediator.DEAL_STATE_CLOSED) then
            return;
        end if;

        update cc_deal d
        set    d.sos = cdb_mediator.DEAL_STATE_CLOSED
        where  d.nd = p_deal_id;
    end;

    -- процедура для веб-сервісу кредитних ресурсів
    procedure close_credit_deal(
        p_deal_id in integer,
        p_close_date in date,
        -- в таблиці cc_deal відсутнє поле для дати фактичного закриття угоди, тому раніше це поле використовувалось для встановлення дати закриття рахунків по угоді
        -- в подальшому необхідність в закритті рахунків відпала, оскільки ними оперують окремо від угоди, а поле залишилось
        -- todo : прибрати параметр дати з процедури і з параметрів виклику на стороні веб-сервісу
        p_error_message out varchar2)
    is
    begin
        bars_audit.trace('cdb_mediator.close_credit_deal' || chr(10) ||
                         'p_deal_id    : ' || p_deal_id || chr(10) ||
                         'p_close_date : ' || p_close_date);

        close_deal(p_deal_id);
    exception
        when others then
             p_error_message := sqlerrm || chr(10) || dbms_utility.format_error_backtrace();
    end;

    procedure close_deal_with_accounts(
        p_deal_id in integer,
        p_close_date in date)
    is
        l_deal_row cc_deal%rowtype;
        l_cc_add_row cc_add%rowtype;
        l_main_account_row accounts%rowtype;
        l_credit_kind_row cc_vidd%rowtype;
        l_interest_account_id integer;
        l_interest_kind_id integer;
        l_interest_account_row accounts%rowtype;
    begin
        bars_audit.trace('cdb_mediator.close_deal_with_accounts' || chr(10) ||
                         'p_deal_id    : ' || p_deal_id || chr(10) ||
                         'p_close_date : ' || p_close_date);

        l_deal_row := cck_utl.read_cc_deal(p_deal_id, true);

        if (l_deal_row.sos = cdb_mediator.DEAL_STATE_CLOSED) then
            return;
        end if;

        l_cc_add_row := cck_utl.read_cc_add(p_deal_id, p_lock => true);
        l_main_account_row := account_utl.read_account(l_cc_add_row.accs, true);

        l_credit_kind_row := cck_utl.read_cc_vidd(l_deal_row.vidd);
        if (l_credit_kind_row.tipd = cdb_mediator.DEAL_TYPE_LENDING) then
            l_interest_kind_id := interest_utl.INTEREST_KIND_ASSETS;
        else
            l_interest_kind_id := interest_utl.INTEREST_KIND_LIABILITIES;
        end if;

        l_interest_account_id := interest_utl.get_interest_account_id(l_main_account_row.acc, l_interest_kind_id);
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

        update cc_deal d
        set    d.sos = cdb_mediator.DEAL_STATE_CLOSED
        where  d.nd = p_deal_id;
    end;

    procedure edit_deal(
        p_deal_id in integer,
        p_expiry_date in date,
        p_deal_amount in number,
        p_interest_rate in number,
        p_partner_main_account in varchar2,
        p_partner_interest_account in varchar2)
    is
        l_deal_row cc_deal%rowtype;
        l_deal_ext_row cc_add%rowtype;
        l_account_row accounts%rowtype;
    begin
        bars_audit.info('cdb_mediator.edit_deal' || chr(10) ||
                         'p_deal_id                  : ' || p_deal_id                  || chr(10) ||
                         'p_expiry_date              : ' || p_expiry_date              || chr(10) ||
                         'p_deal_amount              : ' || p_deal_amount              || chr(10) ||
                         'p_interest_rate            : ' || p_interest_rate            || chr(10) ||
                         'p_partner_main_account     : ' || p_partner_main_account     || chr(10) ||
                         'p_partner_interest_account : ' || p_partner_interest_account);

        l_deal_row := cck_utl.read_cc_deal(p_deal_id, p_lock => true);
        l_deal_ext_row := cck_utl.read_cc_add(p_deal_id, p_lock => true);

        l_account_row := account_utl.read_account(l_deal_ext_row.accs);

        set_interest_rate_utl(l_account_row, l_account_row.pap - 1, l_deal_row.sdate, p_interest_rate);

        if (l_deal_row.wdate <> p_expiry_date) then
            set_deal_expiry_date(p_deal_id, p_expiry_date);
        end if;

        -- l_deal_row.wdate := p_expiry_date;
        l_deal_row.ir := p_interest_rate;
        l_deal_ext_row.s := p_deal_amount;
        l_deal_ext_row.acckred := p_partner_main_account;
        l_deal_ext_row.accperc := p_partner_interest_account;

        update cc_deal t
        set row = l_deal_row
        where  t.nd = p_deal_id;

        update cc_add t
        set row = l_deal_ext_row
        where t.nd = p_deal_id and
              t.adds = 0;
    end;

    procedure reopen_deal(
        p_deal_id in integer)
    is
        l_deal_row cc_deal%rowtype;
    begin
        bars_audit.info('cdb_mediator.reopen_deal' || chr(10) ||
                        'p_deal_id    : ' || p_deal_id);

        l_deal_row := cck_utl.read_cc_deal(p_deal_id, true);

        if (l_deal_row.sos = cdb_mediator.DEAL_STATE_NORMAL) then
            return;
        end if;

        update cc_deal d
        set    d.sos = cdb_mediator.DEAL_STATE_NORMAL
        where  d.nd = p_deal_id;
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
        l_deal_row := cck_utl.read_cc_deal(p_deal_id, true);
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
        l_account_row := account_utl.read_account(p_account_number, p_currency_code);

        set_interest_rate_utl(l_account_row, p_rate_kind, p_rate_date, p_rate_value);

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
        l_deal_row := cck_utl.read_cc_deal(p_deal_id, true);
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

        l_cc_add_row := cck_utl.read_cc_add(p_deal_id);

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
    procedure prepare_interest(
        p_deal_id in varchar2,
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_date_to in date)
    is
        l_deals number_list;
        l_products number_list;
        l_partners number_list;
        l_currencies number_list;
        l_deals_set number_list;
        l_date_to date := case when p_date_to is null then least(bankdate(), trunc(sysdate)) - 1 else p_date_to end;
    begin
        bars_audit.info('cdb_mediator.prepare_interest' || chr(10) ||
                        'p_deal_id     : ' || p_deal_id     || chr(10) ||
                        'p_product_id  : ' || p_product_id  || chr(10) ||
                        'p_partner_id  : ' || p_partner_id  || chr(10) ||
                        'p_currency_id : ' || p_currency_id || chr(10) ||
                        'p_date_to     : ' || p_date_to);

        l_deals := tools.string_to_number_list(p_deal_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_products := tools.string_to_number_list(p_product_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_partners := tools.string_to_number_list(p_partner_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_currencies := tools.string_to_number_list(p_currency_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');

        select unique d.nd
        bulk collect into l_deals_set
        from cc_deal d
        join nd_acc na on na.nd = d.nd
        join accounts a on a.acc = na.acc and
                           a.dazs is null and
                           a.nbs is not null -- не начисляем проценты по управленческим счетам (несистемный учет)
        join int_accn i on i.acc = a.acc and
                           i.id = a.pap - 1 and
                           i.acr_dat < l_date_to
        join customer c on c.rnk = d.rnk
        where (l_deals is null or l_deals is empty or d.nd in (select column_value from table(l_deals))) and
              (l_products is null or l_products is empty or d.vidd in (select column_value from table(l_products))) and
              (l_partners is null or l_partners is empty or d.rnk in (select column_value from table(l_partners))) and
              (l_currencies is null or l_currencies is empty or a.kv in (select column_value from table(l_currencies))) and
              d.sos <> 15;

        tools.hide_hint(interest_utl.prepare_deal_interest(l_deals_set, l_date_to));
    end;

    -- obsolete
    procedure prepare_portfolio_interest(
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_deal_expiry_date in date,
        p_deal_rest in number,
        p_date_to in date)
    is
        l_products number_list;
        l_partners number_list;
        l_currencies number_list;
        l_mismatch_list number_list;
        l_deals number_list;
        l_date_to date := case when p_date_to is null then least(bankdate(), trunc(sysdate)) - 1 else p_date_to end;
    begin
        bars_audit.info('Розрахунок %% по портфелю угод кредитних ресурсів, що відповідають таким параметрам фільтру { ' ||
                        'Продукт: ' || nvl(p_product_id, 'всі') ||
                        ', партнер по угоді: ' || nvl(p_partner_id, 'всі') ||
                        ', валюта : ' || nvl(p_currency_id, 'всі')||
                        ', залишок рахунку : ' || p_deal_rest ||
                        '}. Дату по яку відбувається розрахунок: ' || to_char(p_date_to, 'dd.mm.yyyy'));

        l_products := tools.string_to_number_list(p_product_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_partners := tools.string_to_number_list(p_partner_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_currencies := tools.string_to_number_list(p_currency_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');

        if (l_products is not null) then
            l_mismatch_list := l_products multiset except number_list(3902, 3903);
            if (l_mismatch_list is not empty) then
                raise_application_error(-20000, 'Недопустимий вид угод {' || tools.number_list_to_string(l_mismatch_list) ||
                                                '} для нарахування відсотків по кредитних ресурсів - допускаються лише угоди виду 3902 та 3903');
            end if;
        end if;

        if (l_partners is not null) then
            select t.column_value
            bulk collect into l_mismatch_list
            from   table(l_partners) t
            where  not exists (select 1
                               from   customer c
                               where  c.rnk = t.column_value and
                                      c.custtype = 1 and -- банки
                                      c.codcagent = 9); -- внутрішні розрахунки

            if (l_mismatch_list is not empty) then
                raise_application_error(-20000, 'Недопустимий ідентифікатор партнера {' || tools.number_list_to_string(l_mismatch_list, 100) ||
                                                '} для нарахування відсотків - допускаються лише партнери з кодом контрагента 9 - "Внутрішні розрахунки"');
            end if;
        end if;

        select d.nd
        bulk collect into l_deals
        from   cc_deal d
        join   cc_add dd on dd.nd = d.nd and dd.adds = 0
        join   accounts a on a.acc = dd.accs and
                             a.dazs is null
        join   int_accn i on i.acc = a.acc and
                             i.id = a.pap - 1 and
                             i.acr_dat < l_date_to
        where  mbk.check_if_deal_belong_to_crsour(d.vidd) = 'Y' and
               (l_products is null or l_products is empty or d.vidd in (select column_value from table(l_products))) and
               (l_partners is null or l_partners is empty or d.rnk in (select column_value from table(l_partners))) and
               (l_currencies is null or l_currencies is empty or a.kv in (select column_value from table(l_currencies))) and
               (p_deal_expiry_date is null or p_deal_expiry_date = d.wdate) and
               (p_deal_rest is null or p_deal_rest = abs(a.ostc)) and
               d.sos <> 15;

        if (l_deals is not empty) then
            tools.hide_hint(interest_utl.prepare_deal_interest(l_deals, l_date_to));
        else
            interest_utl.end_reckoning();
        end if;
    end;

    function deal_list_to_account_list(
        p_deals in number_list)
    return number_list
    is
        l_accounts number_list;
    begin
        select distinct d.accs
        bulk collect into l_accounts
        from   cc_add d
        where  d.nd in (select column_value from table(p_deals)) and
               d.adds = 0;

        return l_accounts;
    end;

    procedure reckon_deal_interest(
        p_deal_id in integer,
        p_date_to in date,
        p_grouping_mode_id in integer)
    is
        l_deals number_list;
        l_date_to date := case when p_date_to is null then least(bankdate(), trunc(sysdate)) - 1 else p_date_to end;
    begin
        select d.nd
        bulk collect into l_deals
        from   cc_deal d
        join   cc_add dd on dd.nd = d.nd and dd.adds = 0
        join   accounts a on a.acc = dd.accs and
                             a.dazs is null
        join   int_accn i on i.acc = a.acc and
                             i.id = a.pap - 1 and
                             i.acr_dat < l_date_to
        where  d.nd = p_deal_id and
               mbk.check_if_deal_belong_to_crsour(d.vidd) = 'Y' and
               d.sos not in (cck_utl.DEAL_STATE_CLOSED, cck_utl.DEAL_STATE_DELETED);

        if (l_deals is not empty) then
            interest_utl.reckon_deal_interest(l_deals, l_date_to);
            interest_utl.group_reckonings(deal_list_to_account_list(l_deals), p_grouping_mode_id => p_grouping_mode_id);
        end if;
    end;

    procedure reckon_portfolio_interest(
        p_product_id in varchar2,
        p_partner_id in varchar2,
        p_currency_id in varchar2,
        p_deal_expiry_date in date,
        p_deal_rest in number,
        p_date_to in date)
    is
        l_products number_list;
        l_partners number_list;
        l_currencies number_list;
        l_mismatch_list number_list;
        l_deals number_list;
        l_date_to date := case when p_date_to is null then least(bankdate(), trunc(sysdate)) - 1 else p_date_to end;
    begin
        bars_audit.info('Прогноз %% по портфелю угод кредитних ресурсів, що відповідають таким параметрам фільтру { ' ||
                        'Продукт: ' || nvl(p_product_id, 'всі') ||
                        ', партнер по угоді: ' || nvl(p_partner_id, 'всі') ||
                        ', валюта : ' || nvl(p_currency_id, 'всі')||
                        ', залишок рахунку : ' || nvl(p_deal_rest, 'будь-який') ||
                        '}. Дату по яку відбувається розрахунок: ' || to_char(p_date_to, 'dd.mm.yyyy'));

        l_products := tools.string_to_number_list(p_product_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_partners := tools.string_to_number_list(p_partner_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');
        l_currencies := tools.string_to_number_list(p_currency_id, p_splitting_symbol => ',', p_ignore_nulls => 'Y');

        if (l_products is not null) then
            l_mismatch_list := l_products multiset except number_list(3902, 3903);
            if (l_mismatch_list is not empty) then
                raise_application_error(-20000, 'Недопустимий вид угод {' || tools.number_list_to_string(l_mismatch_list) ||
                                                '} для нарахування відсотків по кредитних ресурсів - допускаються лише угоди виду 3902 та 3903');
            end if;
        end if;

        if (l_partners is not null) then
            select t.column_value
            bulk collect into l_mismatch_list
            from   table(l_partners) t
            where  not exists (select 1
                               from   customer c
                               where  c.rnk = t.column_value and
                                      c.custtype = 1 and -- банки
                                      c.codcagent = 9); -- внутрішні розрахунки

            if (l_mismatch_list is not empty) then
                raise_application_error(-20000, 'Недопустимий ідентифікатор партнера {' || tools.number_list_to_string(l_mismatch_list, 100) ||
                                                '} для нарахування відсотків - допускаються лише партнери з кодом контрагента 9 - "Внутрішні розрахунки"');
            end if;
        end if;

        select d.nd
        bulk collect into l_deals
        from   cc_deal d
        join   cc_add dd on dd.nd = d.nd and dd.adds = 0
        join   accounts a on a.acc = dd.accs and
                             a.dazs is null
        join   int_accn i on i.acc = a.acc and
                             i.id = a.pap - 1 and
                             i.acr_dat < l_date_to
        where  mbk.check_if_deal_belong_to_crsour(d.vidd) = 'Y' and
               (l_products is null or l_products is empty or d.vidd in (select column_value from table(l_products))) and
               (l_partners is null or l_partners is empty or d.rnk in (select column_value from table(l_partners))) and
               (l_currencies is null or l_currencies is empty or a.kv in (select column_value from table(l_currencies))) and
               (p_deal_expiry_date is null or p_deal_expiry_date = d.wdate) and
               (p_deal_rest is null or p_deal_rest = abs(a.ostc)) and
               d.sos <> 15;

        if (l_deals is not empty) then
            interest_utl.reckon_deal_interest(l_deals, l_date_to);
        end if;
    end;

    procedure accrue_interest(
        p_reckoning_id in varchar2)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        bars_audit.log_info('cdb_mediator.accrue_interest', 'p_reckoning_id : ' || p_reckoning_id);

        l_reckoning_row := interest_utl.read_reckoning_row(p_reckoning_id, p_lock => true);

        interest_utl.accrue_interest(l_reckoning_row, p_silent_mode => true);
    end;

    procedure accrue_interest(
        p_dictionary_list in t_dictionary_list,
        l_message out varchar2)
    is
        -- l_message varchar2(32767 byte);
        i integer;
        j integer;
    begin
        if (p_dictionary_list is null) then
            l_message := l_message || 'dictionary list : null';
        elsif (p_dictionary_list is empty) then
            l_message := l_message || 'dictionary list : empty';
        else
            l_message := l_message || 'dictionary list contains ' || p_dictionary_list.count || ' item(s)' || tools.crlf;
            l_message := l_message || '------------------------------------------------------------------------------------' || tools.crlf;

            i := p_dictionary_list.first;
            while (i is not null) loop
                if (p_dictionary_list(i) is null) then
                    l_message := l_message || '    dictionary # ' || i || ' : null' || tools.crlf;
                elsif (p_dictionary_list(i) is empty) then
                    l_message := l_message || '    dictionary # ' || i || ' : empty' || tools.crlf;
                else
                    l_message := l_message || '    dictionary # ' || i || ' : ' || p_dictionary_list(i).count || ' item(s)' || tools.crlf;
                    j := p_dictionary_list(i).first;
                    while (j is not null) loop
                        if (p_dictionary_list(i)(j) is null) then
                            l_message := l_message || '          item # ' || j || ' : null' || tools.crlf;
                        else
                            l_message := l_message || '          item # ' || j || ' : { key : ' || p_dictionary_list(i)(j).key || ', value : ' || p_dictionary_list(i)(j).value || ' }' || tools.crlf;
                        end if;
                        j := p_dictionary_list(i).next(j);
                    end loop;
                end if;
                l_message := l_message || tools.crlf;
                i := p_dictionary_list.next(i);
            end loop;
        end if;

        bars_audit.log_info('cdb_mediator.accrue_interest', l_message);
    end;

    procedure accrue_interest(
        p_dictionary_list in t_dictionary_list)
    is
        l_message varchar2(32767 byte);
        i integer;
        j integer;
        l_reckoning_ids number_list;
    begin
        if (p_dictionary_list is null) then
            l_message := l_message || 'dictionary list : null';
        elsif (p_dictionary_list is empty) then
            l_message := l_message || 'dictionary list : empty';
        else
            l_message := l_message || 'dictionary list contains ' || p_dictionary_list.count || ' item(s)' || tools.crlf;
            l_message := l_message || '------------------------------------------------------------------------------------' || tools.crlf;

            i := p_dictionary_list.first;
            while (i is not null) loop
                if (p_dictionary_list(i) is null) then
                    l_message := l_message || '    dictionary # ' || i || ' : null' || tools.crlf;
                elsif (p_dictionary_list(i) is empty) then
                    l_message := l_message || '    dictionary # ' || i || ' : empty' || tools.crlf;
                else
                    l_message := l_message || '    dictionary # ' || i || ' : ' || p_dictionary_list(i).count || ' item(s)' || tools.crlf;
                    j := p_dictionary_list(i).first;
                    while (j is not null) loop
                        if (p_dictionary_list(i)(j) is null) then
                            l_message := l_message || '          item # ' || j || ' : null' || tools.crlf;
                        else
                            l_message := l_message || '          item # ' || j || ' : { key : ' || p_dictionary_list(i)(j).key || ', value : ' || p_dictionary_list(i)(j).value || ' }' || tools.crlf;
                        end if;
                        j := p_dictionary_list(i).next(j);
                    end loop;
                end if;
                l_message := l_message || tools.crlf;
                i := p_dictionary_list.next(i);
            end loop;
        end if;

        bars_audit.log_info('cdb_mediator.accrue_interest', l_message);

        if (p_dictionary_list is null or p_dictionary_list is empty) then
            return;
        end if;

        l_reckoning_ids := tools.string_list_to_number_list(
                               tools.varchar2_list_to_string_list(
                                   tools.dimension_from_dictionary_list(p_dictionary_list, 'ID', p_ignore_nulls => 'Y', p_trim_values => 'Y'),
                                   p_ignore_nulls => 'Y',
                                   p_truncate_long_values => 'N'));
        for i in (select r.*
                  from   int_reckonings r
                  where  r.id in (select column_value from table(l_reckoning_ids)) and
                         r.state_id in (interest_utl.RECKONING_STATE_RECKONED, interest_utl.RECKONING_STATE_ACCRUAL_FAILED, interest_utl.RECKONING_STATE_MODIFIED) and
                         r.grouping_line_id is null
                  order by r.account_id, r.interest_kind_id, r.date_from
                  for update) loop
            interest_utl.accrue_interest(i, p_silent_mode => true, p_do_not_store_interest_tail => true);
        end loop;
    end;

    procedure accrue_deal_interest(
        p_deal_id in integer)
    is
    begin
        bars_audit.log_info('cdb_mediator.accrue_deal_interest', 'p_deal_id : ' || p_deal_id);

        interest_utl.accrue_deal_interest(number_list(p_deal_id), p_do_not_store_interest_tail => true);
    end;

    procedure accrue_portfolio_interest(
        p_filter in varchar2)
    is
        l_interest_reckonings interest_utl.t_interest_reckonings;
        l_statement varchar2(32767 byte) := 'select * from int_reckonings r where r.interest_kind_id = 1 and ' ||
                                            'r.id in (select id from v_crsour_interest_to_accrual';
        l integer;
    begin
        bars_audit.log_trace('cdb_mediator.accrue_portfolio_interest', 'p_filter : ' || p_filter);

        if  (p_filter is not null) then
            l_statement := l_statement || ' and ' || p_filter;
        end if;

        l_statement := l_statement || ') order by account_id, interest_kind_id, date_from';

        execute immediate l_statement bulk collect into l_interest_reckonings;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            interest_utl.accrue_interest(l_interest_reckonings(l), p_silent_mode => true);

            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure pay_interest(
        p_reckoning_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        bars_audit.log_trace('cdb_mediator.send_accrual', 'p_reckoning_id : ' || p_reckoning_id);

        l_reckoning_row := interest_utl.read_reckoning_row(p_reckoning_id, p_lock => true);

        if (l_reckoning_row.interest_kind_id = interest_utl.INTEREST_KIND_LIABILITIES) then
            if (l_reckoning_row.state_id not in (interest_utl.RECKONING_STATE_ACCRUED, interest_utl.RECKONING_STATE_PAYMENT_FAILED)) then
                raise_application_error(-20000, 'Відсотки за період {' || to_char(l_reckoning_row.date_from, 'dd.mm.yyyy') || ' - ' || to_char(l_reckoning_row.date_through, 'dd.mm.yyyy') ||
                                                '} перебувають в стані {' || list_utl.get_item_name(interest_utl.LT_RECKONING_STATE, l_reckoning_row.state_id) ||
                                                '} і не підлягають виплаті');
            end if;

            interest_utl.pay_interest(l_reckoning_row, p_silent_mode => false);
        else
            raise_application_error(-20000, 'Виплата відсотків допускається лише для пасивних рахунків');
        end if;
    end;

    procedure pay_interest(
        p_dictionary_list in t_dictionary_list)
    is
        l_message varchar2(32767 byte);
        i integer;
        j integer;
        l_reckoning_row int_reckonings%rowtype;
    begin
        if (p_dictionary_list is null) then
            l_message := l_message || 'dictionary list : null';
        elsif (p_dictionary_list is empty) then
            l_message := l_message || 'dictionary list : empty';
        else
            l_message := l_message || 'dictionary list contains ' || p_dictionary_list.count || ' item(s)' || tools.crlf;
            l_message := l_message || '------------------------------------------------------------------------------------' || tools.crlf;

            i := p_dictionary_list.first;
            while (i is not null) loop
                if (p_dictionary_list(i) is null) then
                    l_message := l_message || '    dictionary # ' || i || ' : null' || tools.crlf;
                elsif (p_dictionary_list(i) is empty) then
                    l_message := l_message || '    dictionary # ' || i || ' : empty' || tools.crlf;
                else
                    l_message := l_message || '    dictionary # ' || i || ' : ' || p_dictionary_list(i).count || ' item(s)' || tools.crlf;
                    j := p_dictionary_list(i).first;
                    while (j is not null) loop
                        if (p_dictionary_list(i)(j) is null) then
                            l_message := l_message || '          item # ' || j || ' : null' || tools.crlf;
                        else
                            l_message := l_message || '          item # ' || j || ' : { key : ' || p_dictionary_list(i)(j).key || ', value : ' || p_dictionary_list(i)(j).value || ' }' || tools.crlf;
                        end if;
                        j := p_dictionary_list(i).next(j);
                    end loop;
                end if;
                l_message := l_message || tools.crlf;
                i := p_dictionary_list.next(i);
            end loop;
        end if;

        bars_audit.log_info('interest_utl.pay_interest', l_message);

        if (p_dictionary_list is null or p_dictionary_list is empty) then
            return;
        end if;

        i := p_dictionary_list.first;
        while (i is not null) loop
            j := p_dictionary_list(i).first;
            while (j is not null) loop
                if (upper(p_dictionary_list(i)(j).key) = 'ID') then
                    l_reckoning_row := interest_utl.read_reckoning_row(to_number(p_dictionary_list(i)(j).value), p_lock => true);
                    interest_utl.pay_interest(l_reckoning_row, p_silent_mode => true);
                end if;
                j := p_dictionary_list(i).next(j);
            end loop;
            i := p_dictionary_list.next(i);
        end loop;
    end;

    procedure pay_deal_interest(
        p_deal_id in integer)
    is
        l_interest_reckonings interest_utl.t_interest_reckonings;
        l integer;
    begin
        bars_audit.log_trace('cdb_mediator.pay_deal_accrual', 'p_deal_id : ' || p_deal_id);

        select *
        bulk collect into l_interest_reckonings
        from   int_reckonings t
        where  t.deal_id = p_deal_id and
               t.state_id in (interest_utl.RECKONING_STATE_ACCRUED, interest_utl.RECKONING_STATE_PAYMENT_FAILED)
        order by account_id, interest_kind_id, date_from
        for update skip locked;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            interest_utl.pay_interest(l_interest_reckonings(l), p_silent_mode => true);

            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure pay_portfolio_interest(
        p_filter in varchar2)
    is
        l_interest_reckonings interest_utl.t_interest_reckonings;
        l_statement varchar2(32767 byte) := 'select * from int_reckonings r where r.interest_kind_id = 1 and ' ||
                                            'r.id in (select id from v_crsour_interest where state_id in (5, 9)';
        l integer;
    begin
        bars_audit.log_trace('cdb_mediator.pay_portfolio_interest', 'p_filter : ' || p_filter);

        if (p_filter is not null) then
            l_statement := l_statement || ' and ' || p_filter;
        end if;

        l_statement := l_statement || ') order by account_id, interest_kind_id, date_from for update skip locked';

        execute immediate l_statement bulk collect into l_interest_reckonings;

        l := l_interest_reckonings.first;
        while (l is not null) loop
            interest_utl.pay_interest(l_interest_reckonings(l), p_silent_mode => true);

            l := l_interest_reckonings.next(l);
        end loop;
    end;

    procedure redact_reckoning(
        p_reckoning_id in integer,
        p_interest_amount in number,
        p_purpose in varchar2)
    is
        l_reckoning_row int_reckonings%rowtype;
        l_account_row accounts%rowtype;
    begin
        interest_utl.redact_reckoning(p_reckoning_id, p_interest_amount, p_purpose);
    end;

    procedure remove_reckoning(
        p_reckoning_id in integer)
    is
        l_reckoning_row int_reckonings%rowtype;
    begin
        bars_audit.log_trace('cdb_mediator.remove_reckoning', 'p_reckoning_id : ' || p_reckoning_id);

        l_reckoning_row := interest_utl.read_reckoning_row(p_reckoning_id, p_lock => true);

        interest_utl.clear_reckonings(l_reckoning_row.account_id, l_reckoning_row.interest_kind_id, l_reckoning_row.date_from);
    end;

    -- obsolete
    procedure pay_accrued_interest
    is
    begin
        bars_audit.log_info('cdb_mediator.pay_accrued_interest', '');

        interest_utl.pay_accrued_interest(p_do_not_store_interest_tails => true);
    end;

    -- obsolete
    procedure pay_selected_interest(
        p_reckoning_id in integer)
    is
        l_int_reckoning_row int_reckoning%rowtype;
    begin
        bars_audit.log_info('cdb_mediator.pay_selected_interest', 'p_reckoning_id : ' || p_reckoning_id);

        l_int_reckoning_row := interest_utl.lock_reckoning_row(p_reckoning_id, p_skip_locked => true);

        if (l_int_reckoning_row.id is not null) then
            interest_utl.pay_int_reckoning_row(l_int_reckoning_row, p_silent_mode => true, p_do_not_store_interest_tails => true);
        end if;
    end;

    -- obsolete
    procedure remove_selected_reckoning(
        p_reckoning_id in integer)
    is
    begin
        bars_audit.log_info('cdb_mediator.remove_selected_reckoning', 'p_reckoning_id : ' || p_reckoning_id);

        interest_utl.remove_reckoning(p_reckoning_id);
    end;

    function make_docinput(
        p_deal_id in integer)
    return t_make_document_urls
    pipelined
    is
        l_deal_row cc_deal%rowtype;
        l_deal_ext_row cc_add%rowtype;
        l_account_row accounts%rowtype;
        l_customer_row customer%rowtype;
        l_interest_row int_accn%rowtype;
        l_interest_account_row accounts%rowtype;

        l_credit_mfo varchar2(6 char);
        l_deal_amount number;
        l_document_row t_make_document_url;
    begin
        bars_audit.info('cdb_mediator.make_docinput (' || p_deal_id || ')');
        l_deal_row := cck_utl.read_cc_deal(p_deal_id);
        l_deal_ext_row := cck_utl.read_cc_add(p_deal_id);
        l_account_row := account_utl.read_account(l_deal_ext_row.accs);
        l_interest_row := interest_utl.read_int_accn(l_account_row.acc, l_account_row.pap - 1);
        l_customer_row := customer_utl.read_customer(l_deal_row.rnk);
        l_interest_account_row := account_utl.read_account(l_interest_row.acra);

        l_deal_amount := l_deal_ext_row.s * 100;
        l_credit_mfo := customer_utl.get_customer_mfo(l_deal_row.rnk);

        if (l_deal_row.vidd = 3902 and (-l_account_row.ostb < l_deal_amount or -l_account_row.ostc < l_deal_amount)) then
            l_document_row.operation_type_name := 'Відправка на розміщення осн.суми';
            l_document_row.debit_account       := l_account_row.nls;
            l_document_row.credit_account      := l_deal_ext_row.acckred;
            l_document_row.debit_mfo           := gl.amfo;
            l_document_row.credit_mfo          := l_credit_mfo;
            l_document_row.amount              := l_deal_amount - greatest(-l_account_row.ostb, -l_account_row.ostc);
            l_document_row.currency_code       := l_account_row.kv;
            l_document_row.purpose             := substr(mbk.f_getnazn('RO', p_deal_id), 1, 160);
            l_document_row.url                 := make_docinput_url('KV2', 'Відправка на розміщення осн.суми',
                                                                    'DisR', '1',
                                                                    'Kv_A', l_account_row.kv,
                                                                    'Nls_A', l_account_row.nls,
                                                                    'Mfo_b', l_credit_mfo,
                                                                    'Nls_B', l_deal_ext_row.acckred,
                                                                    'Id_B', l_customer_row.okpo,
                                                                    'Nam_B', substr(l_customer_row.nmk, 1, 38),
                                                                    'SumC_t', l_document_row.amount,
                                                                    'Nazn', l_document_row.purpose);
            l_document_row.url_stp              := make_docinput_url('KV7',
                                                                    'Відправка на розміщення осн.суми',
                                                                    'DisR', '1',
                                                                    'Kv_A', l_account_row.kv,
                                                                    'Nls_A', l_account_row.nls,
                                                                    'Mfo_b', l_credit_mfo,
                                                                    'Nls_B', l_deal_ext_row.acckred,
                                                                    'Id_B', l_customer_row.okpo,
                                                                    'Nam_B', substr(l_customer_row.nmk, 1, 38),
                                                                    'SumC_t', l_document_row.amount,
                                                                    'Nazn', l_document_row.purpose);
            pipe row (l_document_row);
        end if;

        if (l_deal_row.vidd = 3903 and (l_account_row.ostb > l_deal_amount or l_account_row.ostc > l_deal_amount)) then
            l_document_row.operation_type_name := 'Погашення основної суми';
            l_document_row.debit_account       := l_account_row.nls;
            l_document_row.credit_account      := l_deal_ext_row.acckred;
            l_document_row.debit_mfo           := gl.amfo;
            l_document_row.credit_mfo          := l_credit_mfo;
            l_document_row.amount              := greatest(l_account_row.ostb, l_account_row.ostc) - l_deal_amount;
            l_document_row.currency_code       := l_account_row.kv;
            l_document_row.purpose             := substr(mbk.f_getnazn('PO', p_deal_id), 1, 160);
            l_document_row.url                 := make_docinput_url('KV2', 'Погашення основної суми',
                                                                    'DisR', '1',
                                                                    'Kv_A', l_account_row.kv,
                                                                    'Nls_A', l_account_row.nls,
                                                                    'Mfo_b', l_credit_mfo,
                                                                    'Nls_B', l_deal_ext_row.acckred,
                                                                    'Id_B', l_customer_row.okpo,
                                                                    'Nam_B', substr(l_customer_row.nmk, 1, 38),
                                                                    'SumC_t', l_document_row.amount,
                                                                    'Nazn', l_document_row.purpose);
            l_document_row.url_stp              := make_docinput_url('KV7', 'Погашення основної суми',
                                                                    'DisR', '1',
                                                                    'Kv_A', l_account_row.kv,
                                                                    'Nls_A', l_account_row.nls,
                                                                    'Mfo_b', l_credit_mfo,
                                                                    'Nls_B', l_deal_ext_row.acckred,
                                                                    'Id_B', l_customer_row.okpo,
                                                                    'Nam_B', substr(l_customer_row.nmk, 1, 38),
                                                                    'SumC_t', l_document_row.amount,
                                                                    'Nazn', l_document_row.purpose);
            pipe row (l_document_row);
        end if;

        if (l_interest_account_row.ostb > 0 and l_interest_account_row.ostc = l_interest_account_row.ostb) then
            l_document_row.operation_type_name := 'Погашення відсотків за угодою';
            l_document_row.debit_account       := l_account_row.nls;
            l_document_row.credit_account      := l_deal_ext_row.acckred;
            l_document_row.debit_mfo           := gl.amfo;
            l_document_row.credit_mfo          := l_credit_mfo;
            l_document_row.amount              := l_interest_account_row.ostc;
            l_document_row.currency_code       := l_account_row.kv;
            l_document_row.purpose             := substr(mbk.f_getnazn('PO', p_deal_id), 1, 160);
            l_document_row.url                 := make_docinput_url('KV2', 'Погашення відсотків за угодою',
                                                                    'DisR', '1',
                                                                    'Kv_A', l_interest_account_row.kv,
                                                                    'Nls_A', l_interest_account_row.nls,
                                                                    'Mfo_b', l_credit_mfo,
                                                                    'Nls_B', l_deal_ext_row.accperc,
                                                                    'Id_B', l_customer_row.okpo,
                                                                    'Nam_B', substr(l_customer_row.nmk, 1, 38),
                                                                    'SumC_t', l_document_row.amount,
                                                                    'Nazn', l_document_row.purpose);
            l_document_row.url_stp              := make_docinput_url('KV7', 'Погашення відсотків за угодою',
                                                                    'DisR', '1',
                                                                    'Kv_A', l_interest_account_row.kv,
                                                                    'Nls_A', l_interest_account_row.nls,
                                                                    'Mfo_b', l_credit_mfo,
                                                                    'Nls_B', l_deal_ext_row.accperc,
                                                                    'Id_B', l_customer_row.okpo,
                                                                    'Nam_B', substr(l_customer_row.nmk, 1, 38),
                                                                    'SumC_t', l_document_row.amount,
                                                                    'Nazn', l_document_row.purpose);
            pipe row (l_document_row);
        end if;
    exception
        when others then
             bars_audit.error('cdb_mediator.make_docinput (exception)' || chr(10) ||
                              'p_deal_id : ' || p_deal_id || chr(10) ||
                              sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure send_accrued_interest(
        p_filter_string varchar2)
    is
        l_sql         varchar2(4000) := 'select * from  v_pay_interest_crsour ';
        l_cur         sys_refcursor;
        l_vpid        v_pay_interest_crsour%rowtype;
        l_seq         number;
        l_user_login  staff$base.logname%type;
        l_bad         pls_integer := 0;
        l_ok          pls_integer := 0;
        l_info        pay_int_acrpay_batch.info%type;
        l_err         varchar2(4000);
        l_err_summary varchar2(32000);

        ref_          oper.ref%type    ;

    begin
        bars_audit.info('start interest_acrpay with filter: '||p_filter_string);
        -- return;
        l_sql := l_sql || case when p_filter_string is null then '' else ' where '||p_filter_string end;

        select s.logname into l_user_login from staff$base s where s.id = user_id();
        l_seq := s_pay_int_acrpay_batch.nextval;
        insert into pay_int_acrpay_batch(batch_id, user_login, filter) values(l_seq, l_user_login, p_filter_string);
        open l_cur for l_sql;
        loop
         fetch l_cur into l_vpid;
         exit when l_cur%notfound;

         gl.ref (ref_);
         -----------------
         savepoint do_opl;  -- точка отката-1. оплата по плану
         -----------------
         update int_accn set apl_dat = gl.bdate where acc=l_vpid.acc and id=1;
         begin
            gl.in_doc3(ref_   => ref_,
                       tt_    => l_vpid.ttb ,
                       vob_   => l_vpid.vob ,
                       nd_    => substr(to_char(ref_),1,10),
                       pdat_  => sysdate ,
                       vdat_  => gl.bdate,
                       dk_    => l_vpid.dk,
                       kv_    => l_vpid.kv,
                       s_     => l_vpid.original_amount,
                       kv2_   => l_vpid.kvb,
                       s2_    => null,--l_vpid.original_amount,
                       sk_    => null,
                       data_  => gl.bdate,
                       datp_  => gl.bdate,
                       nam_a_ => substr(trim(l_vpid.nms), 1, 38),
                       nlsa_  => l_vpid.nls,
                       mfoa_  => gl.amfo,
                       nam_b_ => substr(trim(l_vpid.namb), 1, 38),
                       nlsb_  => l_vpid.nlsb,
                       mfob_  => l_vpid.mfob,
                       nazn_  => l_vpid.nazn,
                       d_rec_ => null,
                       id_a_  => f_ourokpo(),
                       id_b_  => l_vpid.okpo,
                       id_o_  => null, --trace from centura insert: cqkobc
                       sign_  => null,
                       sos_   => 1,    --trace from centura insert: 0
                       prty_  => null,
                       uid_   => null);

            paytt(flg_  => 0,
                  ref_  => ref_ ,
                  datv_ => gl.bdate ,
                  tt_   => l_vpid.ttb   ,
                  dk0_  => l_vpid.dk     ,
                  kva_  => l_vpid.kv  ,
                  nls1_ => l_vpid.nls,
                  sa_   => l_vpid.original_amount   ,
                  kvb_  => l_vpid.kvb ,
                  nls2_ => l_vpid.nlsb,
                  sb_   => null  );


            l_ok :=  l_ok + 1;
         exception
           when others then
             rollback to do_opl;
             l_err := sqlerrm;
             insert into pay_int_acrpay_log(batch_id,
                                            acc,
                                            id,
                                            nls,
                                            sumr,
                                            tts,
                                            info)
                    values(l_seq,
                           l_vpid.acc,
                           1,--група пасив/*l_vpid.id*/
                           l_vpid.nls,
                           l_vpid.original_amount,
                           l_vpid.ttb,
                           l_err);
            l_bad := l_bad + 1;
            if l_err_summary is null or length(l_err_summary) < 4000 then
              l_err_summary := l_err_summary ||chr(10)||'err'||l_bad||' '||l_err;
            end if;
          end;
        end loop;
        close l_cur;
        l_info := substr('створено виплат: '||l_ok||' помилок: '||l_bad||' ... '||l_err_summary, 1, 4000);
        update pay_int_acrpay_batch set info =  l_info where batch_id = l_seq;
        if l_bad > 0 then
          bars_audit.error('end interest_acrpay with filter: '||p_filter_string||' наявні помилки, подробиці в таблицях pay_int_acrpay_batch, pay_int_acrpay_log');
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
 