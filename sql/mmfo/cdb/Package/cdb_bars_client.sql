
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_bars_client.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_BARS_CLIENT is

    ET_TRANSACTION_STATE           constant integer := 401;
    TRAN_STATE_NEW                 constant integer := 1;
    TRAN_STATE_COMPLETED           constant integer := 2;
    TRAN_STATE_INVALID             constant integer := 3;
    TRAN_STATE_CANCELED            constant integer := 4;
    TRAN_STATE_WAIT_FOR_BARS       constant integer := 5;

    ET_TRANSACTION_TYPE            constant integer := 402;
    TRAN_TYPE_BARS_DEAL            constant integer := 1;
    TRAN_TYPE_BARS_ACCOUNT         constant integer := 2; -- зарезервовано
    TRAN_TYPE_BARS_DOCUMENT        constant integer := 3;
    TRAN_TYPE_CHANGE_DEAL_AMOUNT   constant integer := 4;
    TRAN_TYPE_CHANGE_INTEREST_RATE constant integer := 5;
    TRAN_TYPE_CHANGE_EXPIRY_DATE   constant integer := 6;
    TRAN_TYPE_CLOSE_ACCOUNT        constant integer := 7;
    TRAN_TYPE_ADD_DEAL_COMMENT     constant integer := 8;
    TRAN_TYPE_CLOSE_DEAL           constant integer := 9;

    ET_INTEREST_CALENDAR           constant integer := 403;

    ET_DEAL_TYPE                   constant integer := 404;
    BARS_DEAL_TYPE_LENDING         constant integer := 1;
    BARS_DEAL_TYPE_BORROWING       constant integer := 2;

    ET_DEAL_KIND                   constant integer := 405;
    BARS_DEAL_KIND_DEPOSIT         constant integer := 3903;
    BARS_DEAL_KIND_LOAN            constant integer := 3902;

    function read_bars_transaction(
        p_transaction_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return bars_transaction%rowtype;

    function create_bars_transaction(
        p_object_id in integer,
        p_operation_id in integer,
        p_transaction_type in integer,
        p_priority_group in integer)
    return integer;

    function create_interest_rate_tran(
        p_object_id in integer,
        p_operation_id in integer,
        p_priority_group in integer,
        p_rate_kind in integer,
        p_rate_date in date,
        p_rate_value in number)
    return integer;

    function create_deal_comment_tran(
        p_object_id in integer,
        p_operation_id in integer,
        p_priority_group in integer,
        p_deal_comment in varchar2)
    return integer;

    procedure generate_accounts(
        p_branch_id in integer,
        p_balance_account in varchar2,
        p_currency_code in integer,
        p_main_account_number out varchar2,
        p_interest_account_number out varchar2);

    function get_account_rest(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in integer)
    return number;

    function get_deal_amount(
        p_branch_id in integer,
        p_deal_id in integer)
    return number;

    function get_deal_expiry_date(
        p_branch_id in integer,
        p_deal_id in integer)
    return date;

    procedure check_deal_before_close(
        p_branch_id integer,
        p_deal_id in integer);

    procedure check_deal_interest_rate(
        p_branch_id integer,
        p_bars_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rates in t_date_number_pairs);

    procedure cancel_transaction(p_transaction_id in integer, p_comment in varchar2);

    procedure process_bars_transaction(
        p_transaction_id in integer,
        p_transaction_type in integer);

    procedure process_bars_transactions;
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_BARS_CLIENT as

    WEB_METH_GENERATE_ACCOUNTS     constant varchar2(256 char) := 'GenerateAccountNumbers';
    WEB_METH_OPEN_CREDIT_CONTRACTS constant varchar2(256 char) := 'OpenCreditContract';
    WEB_METH_MAKE_DOCUMENT         constant varchar2(256 char) := 'MakeDocument';
    WEB_METH_GET_ACCOUNT_REST      constant varchar2(256 char) := 'GetAccountRest';
    WEB_METH_GET_DEAL_AMOUNT       constant varchar2(256 char) := 'GetDealAmount';
    WEB_METH_GET_DEAL_EXPIRY_DATE  constant varchar2(256 char) := 'GetDealExpiryDate';
    WEB_METH_CHK_DEAL_FOR_CLOSE    constant varchar2(256 char) := 'CheckDealBeforeClose';
    WEB_METH_CHK_ACC_FOR_CLOSE     constant varchar2(256 char) := 'CheckAccountBeforeClose';
    WEB_METH_CHK_INTEREST_RATES    constant varchar2(256 char) := 'CheckDealInterestRate';
    WEB_METH_SET_DEAL_AMOUNT       constant varchar2(256 char) := 'SetDealAmount';
    WEB_METH_SET_INTEREST_RATE     constant varchar2(256 char) := 'SetDealInterestRate';
    WEB_METH_SET_EXPIRY_DATE       constant varchar2(256 char) := 'SetDealExpiryDate';
    WEB_METH_CLOSE_ACCOUNT         constant varchar2(256 char) := 'CloseAccount';
    WEB_METH_CLOSE_DEAL            constant varchar2(256 char) := 'CloseDeal';
    WEB_METH_ADD_DEAL_COMMENT      constant varchar2(256 char) := 'AddDealComment';

    MARGIN_ATTEMPTS_COUNT          constant integer := 5;

    function read_bars_transaction(
        p_transaction_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return bars_transaction%rowtype
    is
        l_transaction_row bars_transaction%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_transaction_row
            from   bars_transaction bt
            where  bt.id = p_transaction_id
            for update;
        else
            select *
            into   l_transaction_row
            from   bars_transaction bt
            where  bt.id = p_transaction_id;
        end if;

        return l_transaction_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Транзакція для АБС "Барс" з ідентифікатором {' || p_transaction_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_interest_rate_transaction(
        p_transaction_id in integer,
        p_raise_ndf in boolean default true)
    return bars_tran_interest_rate%rowtype
    is
        l_interest_rate_tran_row bars_tran_interest_rate%rowtype;
    begin
        select *
        into   l_interest_rate_tran_row
        from   bars_tran_interest_rate bt
        where  bt.transaction_id = p_transaction_id;

        return l_interest_rate_tran_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Транзакція зміни відсоткової ставки з ідентифікатором {' || p_transaction_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_deal_comment_transaction(
        p_transaction_id in integer,
        p_raise_ndf in boolean default true)
    return bars_tran_deal_comment%rowtype
    is
        l_deal_comment_tran_row bars_tran_deal_comment%rowtype;
    begin
        select *
        into   l_deal_comment_tran_row
        from   bars_tran_deal_comment bt
        where  bt.transaction_id = p_transaction_id;

        return l_deal_comment_tran_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Транзакція з коментарем по угоді з ідентифікатором {' || p_transaction_id || '} не знайдена');
             else return null;
             end if;
    end;

    procedure track_transaction(
        p_transaction_id in integer,
        p_transaction_state in integer,
        p_error_message in clob)
    is
    begin
        insert into transaction_tracking
        values (transaction_tracking_seq.nextval, p_transaction_id, p_transaction_state, sysdate, p_error_message);
    end;

    function create_bars_transaction(
        p_object_id in integer,
        p_operation_id in integer,
        p_transaction_type in integer,
        p_priority_group in integer)
    return integer
    is
        l_bars_transaction_id integer;
    begin
        insert into bars_transaction
        values (bars_transaction_seq.nextval,
                p_object_id,
                p_operation_id,
                p_transaction_type,
                cdb_bars_client.TRAN_STATE_NEW,
                p_priority_group,
                0,
                sysdate)
        returning id
        into l_bars_transaction_id;

        track_transaction(l_bars_transaction_id, cdb_bars_client.TRAN_STATE_NEW, null);

        return l_bars_transaction_id;
    end;

    function create_interest_rate_tran(
        p_object_id in integer,
        p_operation_id in integer,
        p_priority_group in integer,
        p_rate_kind in integer,
        p_rate_date in date,
        p_rate_value in number)
    return integer
    is
        l_transaction_id integer;
    begin
        l_transaction_id := create_bars_transaction(p_object_id, p_operation_id, cdb_bars_client.TRAN_TYPE_CHANGE_INTEREST_RATE, p_priority_group);

        insert into bars_tran_interest_rate
        values (l_transaction_id, p_rate_kind, p_rate_date, p_rate_value);

        return l_transaction_id;
    end;

    procedure set_transaction_state(
        p_transaction_id in integer,
        p_transaction_state in integer)
    is
    begin
        update bars_transaction bt
        set    bt.state = p_transaction_state
        where  bt.id = p_transaction_id;
    end;

    procedure notify_operation_about_state(
        p_operation_id in integer)
    is
        l_completed_trans_count integer;
        l_canceled_trans_count integer;
        l_other_trans_count integer;
    begin
        select sum(case when bt.state = cdb_bars_client.TRAN_STATE_COMPLETED then 1 else 0 end),
               sum(case when bt.state = cdb_bars_client.TRAN_STATE_CANCELED then 1 else 0 end),
               sum(case when bt.state in (cdb_bars_client.TRAN_STATE_COMPLETED, cdb_bars_client.TRAN_STATE_CANCELED) then 0 else 1 end)
        into   l_completed_trans_count, l_canceled_trans_count, l_other_trans_count
        from   bars_transaction bt
        where  bt.operation_id = p_operation_id;

        if (l_other_trans_count = 0) then
            if (l_completed_trans_count >= 0 and l_canceled_trans_count = 0) then
                cdb_dispatcher.set_operation_state(p_operation_id, cdb_dispatcher.OPERATION_STATE_COMPLETED);
            elsif (l_canceled_trans_count > 0 and l_completed_trans_count = 0) then
                cdb_dispatcher.set_operation_state(p_operation_id, cdb_dispatcher.OPERATION_STATE_CANCELED);
            else
                cdb_dispatcher.set_operation_state(p_operation_id, cdb_dispatcher.OPERATION_STATE_PART_COMPLETED);
            end if;
        end if;
    end;

    procedure complete_transaction(p_transaction_id in integer)
    is
        l_transaction_row bars_transaction%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, p_lock => true);

        set_transaction_state(p_transaction_id, cdb_bars_client.TRAN_STATE_COMPLETED);
        track_transaction(p_transaction_id, cdb_bars_client.TRAN_STATE_COMPLETED, null);

        notify_operation_about_state(l_transaction_row.operation_id);
    end;

    procedure cancel_transaction(p_transaction_id in integer, p_comment in varchar2)
    is
        l_transaction_row bars_transaction%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, p_lock => true);

        set_transaction_state(p_transaction_id, cdb_bars_client.TRAN_STATE_CANCELED);
        track_transaction(p_transaction_id, cdb_bars_client.TRAN_STATE_CANCELED, p_comment);

        notify_operation_about_state(l_transaction_row.operation_id);
    end;

    procedure track_transaction_error(p_transaction_id in integer, p_error_message in clob)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id);

        l_transaction_row.fail_counter := l_transaction_row.fail_counter + 1;

        if (l_transaction_row.fail_counter >= cdb_bars_client.MARGIN_ATTEMPTS_COUNT) then
            l_transaction_row.state := cdb_bars_client.TRAN_STATE_INVALID;
        end if;

        update bars_transaction bt
        set    bt.state = l_transaction_row.state,
               bt.fail_counter = l_transaction_row.fail_counter
        where  bt.id = p_transaction_id;

        track_transaction(p_transaction_id, cdb_bars_client.TRAN_STATE_INVALID, p_error_message);

        commit;
    end;

    function create_deal_comment_tran(
        p_object_id in integer,
        p_operation_id in integer,
        p_priority_group in integer,
        p_deal_comment in varchar2)
    return integer
    is
        l_transaction_id integer;
    begin
        l_transaction_id := create_bars_transaction(p_object_id, p_operation_id, cdb_bars_client.TRAN_TYPE_ADD_DEAL_COMMENT, p_priority_group);

        insert into bars_tran_deal_comment
        values (l_transaction_id, p_deal_comment);

        return l_transaction_id;
    end;

    function get_value_from_xml(p_xml in out nocopy xmltype, p_xml_path in varchar2)
    return varchar2
    is
        l_xml xmltype;
    begin
        l_xml := p_xml.extract(p_xml_path, 'xmlns="http://tempuri.org/"');

        if (l_xml is  not null) then
            return replace(replace(replace(l_xml.GetStringVal(), 'quot;', '"'), 'apos;', ''''), '&', '');
        end if;

        return null;
    end;

    function date_to_soap_date(p_date in date)
    return varchar2
    is
    begin
        return case when p_date is null then '0001-01-01'
                    else to_char(p_date, 'YYYY-MM-DD')
               end || 'T00:00:00';
    end;

    function soap_generate_accounts(
        p_branch_id in integer,
        p_customer_id in integer,
        p_balance_account in varchar2,
        p_currency_code in varchar2)
    return varchar2
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_account_numbers varchar2(32767 byte);
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_GENERATE_ACCOUNTS);

        soap_rpc.add_parameter(l_request, 'OurCustomerId', p_customer_id);
        soap_rpc.add_parameter(l_request, 'BalanceAccount', p_balance_account);
        soap_rpc.add_parameter(l_request, 'CurrencyCode', p_currency_code);

        l_responce := soap_rpc.invoke(l_request);
        l_account_numbers := get_value_from_xml(l_responce.doc,
                                                '/GenerateAccountNumbersResponse/GenerateAccountNumbersResult/' ||
                                                    'AccountNumber/AccountNumberValue/text()');

        l_error_message := trim(get_value_from_xml(l_responce.doc,
                                                   '/GenerateAccountNumbersResponse/GenerateAccountNumbersResult/' ||
                                                       'Error/ErrMessage/text()'));

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;

        return l_account_numbers;
    end;

    function soap_get_account_rest(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in varchar2)
    return varchar2
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_account_rest varchar2(32767 byte);
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_GET_ACCOUNT_REST);

        soap_rpc.add_parameter(l_request, 'AccountNumber', p_account_number);
        soap_rpc.add_parameter(l_request, 'CurrencyCode', p_currency_code);

        l_responce := soap_rpc.invoke(l_request);
        -- dbms_output.put_line(l_responce.doc.GetStringVal());
        l_account_rest := get_value_from_xml(l_responce.doc,
                                                '/GetAccountRestResponse/GetAccountRestResult/' ||
                                                    'Amount/AmountValue/text()');

        l_error_message := trim(get_value_from_xml(l_responce.doc,
                                                   '/GetAccountRestResponse/GetAccountRestResult/' ||
                                                       'Error/ErrMessage/text()'));

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;

        return l_account_rest;
    end;

    function soap_get_deal_amount(
        p_branch_id in integer,
        p_deal_id in integer)
    return varchar2
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_deal_amount varchar2(32767 byte);
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_GET_DEAL_AMOUNT);

        soap_rpc.add_parameter(l_request, 'DealId', p_deal_id);

        l_responce := soap_rpc.invoke(l_request);
        -- dbms_output.put_line(l_responce.doc.GetStringVal());
        l_deal_amount := get_value_from_xml(l_responce.doc,
                                                '/GetDealAmountResponse/GetDealAmountResult/' ||
                                                    'Amount/AmountValue/text()');

        l_error_message := trim(get_value_from_xml(l_responce.doc,
                                                   '/GetDealAmountResponse/GetDealAmountResult/' ||
                                                       'Error/ErrMessage/text()'));

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;

        return l_deal_amount;
    end;

    function soap_get_deal_expiry_date(
        p_branch_id in integer,
        p_bars_deal_id in integer)
    return varchar2
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_deal_expiry_date varchar2(32767 byte);
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_GET_DEAL_EXPIRY_DATE);

        soap_rpc.add_parameter(l_request, 'DealId', p_bars_deal_id);

        l_responce := soap_rpc.invoke(l_request);
        l_deal_expiry_date := get_value_from_xml(l_responce.doc,
                                                '/GetDealExpiryDateResponse/GetDealExpiryDateResult/' ||
                                                    'Date/DateValue/text()');

        l_error_message := trim(get_value_from_xml(l_responce.doc,
                                                   '/GetDealExpiryDateResponse/GetDealExpiryDateResult/' ||
                                                       'Error/ErrMessage/text()'));

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;

        return l_deal_expiry_date;
    end;

    procedure soap_set_deal_amount(
        p_branch_id in integer,
        p_deal_id in integer,
        p_deal_amount in number)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_SET_DEAL_AMOUNT);

        soap_rpc.add_parameter(l_request, 'DealId', p_deal_id);
        soap_rpc.add_parameter(l_request, 'DealAmount', p_deal_amount);

        l_responce := soap_rpc.invoke(l_request);
        -- dbms_output.put_line(l_responce.doc.GetStringVal());

        l_error_message := get_value_from_xml(l_responce.doc, '/SetDealAmountResponse/SetDealAmountResult/ErrMessage/text()');

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure soap_set_account_interest_rate(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in integer,
        p_rate_kind in integer,
        p_rate_date in date,
        p_rate_value in number)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_SET_INTEREST_RATE);

        soap_rpc.add_parameter(l_request, 'AccountNumber', p_account_number);
        soap_rpc.add_parameter(l_request, 'CurrencyCode', p_currency_code);
        soap_rpc.add_parameter(l_request, 'RateKind', p_rate_kind);
        soap_rpc.add_parameter(l_request, 'RateDate', date_to_soap_date(p_rate_date));
        soap_rpc.add_parameter(l_request, 'RateValue', to_char(p_rate_value, 'FM9999999999D999999999999'));

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := get_value_from_xml(l_responce.doc,
                                              '/SetDealInterestRateResponse/SetDealInterestRateResult' ||
                                                  '/ErrMessage/text()');

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure soap_set_deal_expiry_date(
        p_branch_id in integer,
        p_deal_id in integer,
        p_deal_expiry_date in date)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_SET_EXPIRY_DATE);

        soap_rpc.add_parameter(l_request, 'DealId', p_deal_id);
        soap_rpc.add_parameter(l_request, 'ExpiryDate', date_to_soap_date(p_deal_expiry_date));

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := get_value_from_xml(l_responce.doc, '/SetDealExpiryDateResponse/SetDealExpiryDateResult/ErrMessage/text()');

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure soap_check_deal_before_close(
        p_branch_id integer,
        p_deal_id in integer)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_CHK_DEAL_FOR_CLOSE);

        soap_rpc.add_parameter(l_request, 'DealId', p_deal_id);

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := trim(get_value_from_xml(l_responce.doc,
                                                   '/CheckDealBeforeCloseResponse/CheckDealBeforeCloseResult/' ||
                                                       'ErrMessage/text()'));

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS, l_error_message);
        end if;
    end;

    procedure soap_check_acc_before_close(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in integer)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_CHK_ACC_FOR_CLOSE);

        soap_rpc.add_parameter(l_request, 'AccountNumber', p_account_number);
        soap_rpc.add_parameter(l_request, 'CurrencyCode', p_currency_code);

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := trim(get_value_from_xml(l_responce.doc,
                                                   '/CheckAccountBeforeCloseResponse/CheckAccountBeforeCloseResult/' ||
                                                       'ErrMessage/text()'));

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS, l_error_message);
        end if;
    end;

    procedure soap_check_deal_interest_rate(
        p_branch_id in integer,
        p_bars_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rates in t_date_number_pairs)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
        l_interest_rates varchar2(32767 byte);
        l integer;
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_CHK_INTEREST_RATES);

        soap_rpc.add_parameter(l_request, 'DealId', p_bars_deal_id);
        soap_rpc.add_parameter(l_request, 'InterestKind', p_interest_kind);

        if (p_interest_rates is not null) then
            l := p_interest_rates.first;
            while (l is not null) loop
                -- TODO : знайти можливість не заміняти xml-символи на "?" та "!"
                l_interest_rates := l_interest_rates ||
                                    '?DateNumberPair!' ||
                                       '?DateValue!' || date_to_soap_date(p_interest_rates(l).date_value) || '?/DateValue!' ||
                                       '?NumberValue!' || to_char(p_interest_rates(l).number_value) || '?/NumberValue!' ||
                                    '?/DateNumberPair!';
                l := p_interest_rates.next(l);
            end loop;

            soap_rpc.add_parameter(l_request,
                                   'InterestRates',
                                   '?DateNumberPairs!' || l_interest_rates || '?/DateNumberPairs!');
        end if;

        soap_rpc.generate_envelope(l_request, l_error_message);
        soap_rpc.show_envelope(l_error_message);

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := trim(get_value_from_xml(l_responce.doc,
                                                   '/CheckDealInterestRateResponse/CheckDealInterestRateResult/' ||
                                                       'ErrMessage/text()'));

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.HAVE_TO_WAIT_FOR_BARS, l_error_message);
        end if;
    end;

    procedure soap_open_credit_contract(
       p_branch_id in integer,
       p_contract_number in varchar2,
       p_contract_type in integer,
       p_product_id in integer,
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
       p_interest_account_id out integer)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_OPEN_CREDIT_CONTRACTS);

        soap_rpc.add_parameter(l_request, 'ContractNumber', p_contract_number);
        soap_rpc.add_parameter(l_request, 'ProductId', p_product_id);
        soap_rpc.add_parameter(l_request, 'ContractType', p_contract_type);
        soap_rpc.add_parameter(l_request, 'CurrencyCode', p_currency_code);
        soap_rpc.add_parameter(l_request, 'PartyId', p_party_id);
        soap_rpc.add_parameter(l_request, 'PartyMfo', p_party_mfo);
        soap_rpc.add_parameter(l_request, 'PartyName', utl_encode.text_encode(p_party_name, encoding => utl_encode.base64));
        soap_rpc.add_parameter(l_request, 'ContractDate', date_to_soap_date(p_contract_date));
        soap_rpc.add_parameter(l_request, 'ExpiryDate', date_to_soap_date(p_expiry_date));
        soap_rpc.add_parameter(l_request, 'InterestRate', p_interest_rate);
        soap_rpc.add_parameter(l_request, 'Amount', p_amount);
        soap_rpc.add_parameter(l_request, 'BaseYear', p_base_year);
        soap_rpc.add_parameter(l_request, 'BalanceKind', p_balance_kind);
        soap_rpc.add_parameter(l_request, 'MainDebtAccount', p_main_debt_account);
        soap_rpc.add_parameter(l_request, 'InterestAccount', p_interest_account);
        soap_rpc.add_parameter(l_request, 'PartyMainDebtAccount', p_party_main_debt_account);
        soap_rpc.add_parameter(l_request, 'PartyInterestAccount', p_party_interest_account);
        soap_rpc.add_parameter(l_request, 'TransitAccount', p_transit_account);
        soap_rpc.add_parameter(l_request, 'PaymentPurpose', utl_encode.text_encode(p_payment_purpose, encoding => utl_encode.base64));

        l_responce := soap_rpc.invoke(l_request);

        p_deal_id := to_number(get_value_from_xml(l_responce.doc, '/OpenCreditContractResponse/OpenCreditContractResult/Deal/DealId/text()'));
        p_main_account_id := to_number(get_value_from_xml(l_responce.doc, '/OpenCreditContractResponse/OpenCreditContractResult/Deal/MainAccountId/text()'));
        p_interest_account_id := to_number(get_value_from_xml(l_responce.doc, '/OpenCreditContractResponse/OpenCreditContractResult/Deal/InterestAccountId/text()'));
        l_error_message := get_value_from_xml(l_responce.doc, '/OpenCreditContractResponse/OpenCreditContractResult/Error/ErrMessage/text()');

        -- dbms_output.put_line(p_deal_id || ' - ' || p_main_account_id || ' - ' || p_interest_account_id || ' - ' || l_error_message);

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure soap_make_document(
        p_branch_id in integer,
        p_deal_id in integer,
        p_operation_type in varchar2,
        p_document_kind in integer,
        p_party_a in integer,
        p_party_b in integer,
        p_mfo_a in varchar2,
        p_mfo_b in varchar2,
        p_account_a in varchar2,
        p_account_b in varchar2,
        p_document_date in date,
        p_amount in number,
        p_currency in integer,
        p_purpose in varchar2,
        p_operation_id out integer)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_MAKE_DOCUMENT);

        soap_rpc.add_parameter(l_request, 'DealId', p_deal_id);
        soap_rpc.add_parameter(l_request, 'OperationType', p_operation_type);
        soap_rpc.add_parameter(l_request, 'PartyA', p_party_a);
        soap_rpc.add_parameter(l_request, 'PartyB', p_party_b);
        soap_rpc.add_parameter(l_request, 'MfoA', p_mfo_a);
        soap_rpc.add_parameter(l_request, 'MfoB', p_mfo_b);
        soap_rpc.add_parameter(l_request, 'AccountA', p_account_a);
        soap_rpc.add_parameter(l_request, 'AccountB', p_account_b);
        soap_rpc.add_parameter(l_request, 'DocumentKindId', p_document_kind);
        soap_rpc.add_parameter(l_request, 'DocumentDate', date_to_soap_date(p_document_date));
        soap_rpc.add_parameter(l_request, 'Amount', p_amount);
        soap_rpc.add_parameter(l_request, 'Currency', p_currency);
        soap_rpc.add_parameter(l_request, 'Purpose', utl_encode.text_encode(p_purpose, encoding => utl_encode.base64));

        l_responce := soap_rpc.invoke(l_request);

        p_operation_id := to_number(get_value_from_xml(l_responce.doc, '/MakeDocumentResponse/MakeDocumentResult/Document/DocumentIdValue/text()'));
        l_error_message := get_value_from_xml(l_responce.doc, '/MakeDocumentResponse/MakeDocumentResult/Error/ErrMessage/text()');

        -- dbms_output.put_line(p_operation_id || ' - ' || l_error_message);

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure soap_close_account(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in integer,
        p_close_date in date)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_CLOSE_ACCOUNT);

        soap_rpc.add_parameter(l_request, 'AccountNumber', p_account_number);
        soap_rpc.add_parameter(l_request, 'CurrencyCode', p_currency_code);
        soap_rpc.add_parameter(l_request, 'CloseDate', date_to_soap_date(p_close_date));

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := get_value_from_xml(l_responce.doc, '/CloseAccountResponse/CloseAccountResult/ErrMessage/text()');

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure soap_close_deal(
        p_branch_id in integer,
        p_deal_id in integer,
        p_close_date in date)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        logger.log('cdb_bars_client.soap_close_deal',
                   'p_branch_id  : ' || p_branch_id  || chr(10) ||
                   'p_deal_id    : ' || p_deal_id    || chr(10) ||
                   'p_close_date : ' || p_close_date);
        l_request := soap_rpc.new_request(p_branch_id, cdb_bars_client.WEB_METH_CLOSE_DEAL);

        soap_rpc.add_parameter(l_request, 'DealId', p_deal_id);
        soap_rpc.add_parameter(l_request, 'CloseDate', date_to_soap_date(p_close_date));

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := get_value_from_xml(l_responce.doc, '/CloseDealResponse/CloseDealResult/ErrMessage/text()');

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure soap_add_deal_comment(
        p_branch_id in integer,
        p_deal_id in integer,
        p_comment in varchar2)
    is
        l_request soap_rpc.t_request;
        l_responce soap_rpc.t_response;
        l_error_message varchar2(32767 byte);
    begin
        l_request := soap_rpc.new_request(p_branch_id,
                                          cdb_bars_client.WEB_METH_ADD_DEAL_COMMENT);

        soap_rpc.add_parameter(l_request, 'DealId', p_deal_id);
        soap_rpc.add_parameter(l_request, 'Comment', utl_encode.text_encode(p_comment, encoding => utl_encode.base64));

        l_responce := soap_rpc.invoke(l_request);

        l_error_message := get_value_from_xml(l_responce.doc, '/AddDealCommentResponse/AddDealCommentResult/ErrMessage/text()');

        if (l_error_message is not null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, l_error_message);
        end if;
    end;

    procedure generate_accounts(
        p_branch_id in integer,
        p_balance_account in varchar2,
        p_currency_code in integer,
        p_main_account_number out varchar2,
        p_interest_account_number out varchar2)
    is
        l_branch_customer_id integer;
        l_account_numbers varchar2(30 char);
    begin
         -- ідентифікатор філіала в таблиці customer цього філіалу
        l_branch_customer_id := cdb_branch.get_branch_customer(p_branch_id, p_branch_id);
        if (l_branch_customer_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Не вдалося визначити ідентифікатор філіала {' || cdb_branch.get_branch_name(p_branch_id) ||
                                        '} в списку клієнтів філіалу');
        end if;

        -- звертаємось до web-сервісу
        l_account_numbers := soap_generate_accounts(p_branch_id, l_branch_customer_id, p_balance_account, p_currency_code);

        p_main_account_number := trim(substr(l_account_numbers, 1, 15));
        p_interest_account_number := trim(substr(l_account_numbers, 16));

        if (p_main_account_number is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Не вдалося сформувати номер рахунку основної суми договору для балансового {' || p_balance_account ||
                                    '} валюти {' || p_currency_code ||
                                    '} та філіалу {' || cdb_branch.get_branch_name(p_branch_id) || '}');
        end if;

        if (p_interest_account_number is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Не вдалося сформувати номер рахунку нарахованих відсотків для балансового {' || p_balance_account ||
                                    '} валюти {' || p_currency_code ||
                                    '} та філіалу {' || cdb_branch.get_branch_name(p_branch_id) || '}');
        end if;
    end;

    procedure open_credit_contract(
        p_branch_id in integer,
        p_contract_type in integer,
        p_product_id in integer,
        p_contract_number in varchar2,
        p_currency_code in integer,
        p_party_id in integer,
        p_party_mfo in varchar2,
        p_party_name in varchar2,
        p_contract_date in date,
        p_expiry_date in date,
        p_interest_rate in number,
        p_amount in number,
        p_base_year in integer,
        p_balance_kind in integer,
        p_main_account in varchar2,
        p_interest_account in varchar2,
        p_party_main_account in varchar2,
        p_party_interest_account in varchar2,
        p_transit_account in varchar2,
        p_payment_purpose in varchar2,
        p_deal_id out integer,
        p_main_account_id out integer,
        p_interest_account_id out integer)
    is
    begin
        soap_open_credit_contract(p_branch_id,
                                  p_contract_number,
                                  p_contract_type,
                                  p_product_id,
                                  p_currency_code,
                                  p_party_id,
                                  p_party_mfo,
                                  p_party_name,
                                  p_contract_date,
                                  p_expiry_date,
                                  p_interest_rate,
                                  p_amount,
                                  p_base_year,
                                  p_balance_kind,
                                  p_main_account,
                                  p_interest_account,
                                  p_party_main_account,
                                  p_party_interest_account,
                                  p_transit_account,
                                  p_payment_purpose,
                                  p_deal_id,
                                  p_main_account_id,
                                  p_interest_account_id);
    end;

    procedure make_document(
        p_branch_id in integer,
        p_deal_id in integer,
        p_operation_type in varchar2,
        p_document_kind in integer,
        p_party_a in integer,
        p_party_b in integer,
        p_mfo_a in varchar2,
        p_mfo_b in varchar2,
        p_account_a in varchar2,
        p_account_b in varchar2,
        p_document_date in date,
        p_amount in number,
        p_currency in integer,
        p_purpose in varchar2,
        p_operation_id out integer)
    is
    begin
        soap_make_document(p_branch_id,
                           p_deal_id,
                           p_operation_type,
                           p_document_kind,
                           p_party_a,
                           p_party_b,
                           p_mfo_a,
                           p_mfo_b,
                           p_account_a,
                           p_account_b,
                           p_document_date,
                           p_amount,
                           p_currency,
                           p_purpose,
                           p_operation_id);
    end;

    procedure close_account(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in integer,
        p_close_date in date)
    is
    begin
        soap_close_account(p_branch_id,
                           p_account_number,
                           p_currency_code,
                           p_close_date);
    end;

    procedure close_deal(
        p_branch_id in integer,
        p_deal_id in integer,
        p_close_date in date)
    is
    begin
        soap_close_deal(p_branch_id,
                        p_deal_id,
                        p_close_date);
    end;

    procedure add_deal_comment(
        p_branch_id in integer,
        p_deal_id in integer,
        p_comment in varchar2)
    is
    begin
        soap_add_deal_comment(p_branch_id,
                              p_deal_id,
                              p_comment);
    end;

    function get_account_rest(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in integer)
    return number
    is
    begin
        return to_number(soap_get_account_rest(p_branch_id,
                                               p_account_number,
                                               p_currency_code));
    end;

    function get_deal_amount(
        p_branch_id in integer,
        p_deal_id in integer)
    return number
    is
    begin
        return to_number(soap_get_deal_amount(p_branch_id, p_deal_id));
    end;

    function get_deal_expiry_date(
        p_branch_id in integer,
        p_deal_id in integer)
    return date
    is
    begin
        return to_date(substr(soap_get_deal_expiry_date(p_branch_id, p_deal_id), 1, 10), 'YYYY-MM-DD');
    end;

    procedure set_deal_amount(
        p_branch_id in integer,
        p_bars_deal_id in integer,
        p_deal_amount in number)
    is
    begin
        soap_set_deal_amount(p_branch_id, p_bars_deal_id, p_deal_amount);
    end;

    procedure set_deal_expiry_date(
        p_branch_id in integer,
        p_bars_deal_id in integer,
        p_deal_expiry_date in date)
    is
    begin
        soap_set_deal_expiry_date(p_branch_id, p_bars_deal_id, p_deal_expiry_date);
    end;

    procedure set_account_interest_rate(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_code in integer,
        p_rate_kind in integer,
        p_rate_date in date,
        p_rate_value in number)
    is
    begin
        soap_set_account_interest_rate(p_branch_id,
                                       p_account_number,
                                       p_currency_code,
                                       p_rate_kind,
                                       p_rate_date,
                                       p_rate_value);
    end;

    procedure check_deal_before_close(
        p_branch_id integer,
        p_deal_id in integer)
    is
    begin
        soap_check_deal_before_close(p_branch_id, p_deal_id);
    end;

    procedure check_account_before_close(
        p_branch_id integer,
        p_account_number in varchar2,
        p_currency_code in integer)
    is
    begin
        soap_check_acc_before_close(p_branch_id, p_account_number, p_currency_code);
    end;

    procedure check_deal_interest_rate(
        p_branch_id integer,
        p_bars_deal_id in integer,
        p_interest_kind in integer,
        p_interest_rates in t_date_number_pairs)
    is
    begin
        soap_check_deal_interest_rate(p_branch_id, p_bars_deal_id, p_interest_kind, p_interest_rates);
    end;

    procedure process_deal_transaction(p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_object_row bars_object%rowtype;
        l_bars_deal_row bars_deal%rowtype;
        l_deal_row deal%rowtype;
        l_main_account_row bars_account%rowtype;
        l_interest_account_row bars_account%rowtype;
        l_party_branch_row branch%rowtype;
        l_party_bars_object_row bars_object%rowtype;
        l_party_bars_deal_row bars_deal%rowtype;
        l_party_main_account_row bars_account%rowtype;
        l_party_interest_account_row bars_account%rowtype;
        l_transit_account_row bars_account%rowtype;
        l_party_customer_id integer;
        l_cc_deal_nd integer;
        l_main_account_acc integer;
        l_interest_account_acc integer;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id, true);
        l_bars_deal_row := cdb_bars_object.read_bars_deal(l_object_row.id);
        l_deal_row := cdb_deal.read_deal(l_object_row.deal_id);
        l_party_bars_object_row := cdb_bars_object.read_bars_object(l_bars_deal_row.party_bars_deal_id);
        l_party_bars_deal_row := cdb_bars_object.read_bars_deal(l_bars_deal_row.party_bars_deal_id);
        l_party_branch_row := cdb_branch.read_branch(l_party_bars_object_row.branch_id);
        l_party_customer_id := cdb_branch.get_branch_customer(l_object_row.branch_id, l_party_bars_object_row.branch_id);

        l_main_account_row := cdb_bars_object.read_bars_account(l_bars_deal_row.main_account_id);
        l_interest_account_row := cdb_bars_object.read_bars_account(l_bars_deal_row.interest_account_id);
        l_transit_account_row := cdb_bars_object.read_bars_account(l_bars_deal_row.transit_account_id);
        l_party_main_account_row := cdb_bars_object.read_bars_account(l_party_bars_deal_row.main_account_id);
        l_party_interest_account_row := cdb_bars_object.read_bars_account(l_party_bars_deal_row.interest_account_id);

        open_credit_contract(l_object_row.branch_id,
                             l_bars_deal_row.deal_type,
                             l_bars_deal_row.product,
                             l_deal_row.deal_number,
                             l_deal_row.currency_id,
                             l_party_customer_id,
                             l_party_branch_row.branch_code,
                             l_party_branch_row.branch_name,
                             l_deal_row.open_date,
                             l_deal_row.expiry_date,
                             cdb_deal.get_deal_interest_rate(l_deal_row.id, cdb_deal.RATE_KIND_MAIN),
                             l_deal_row.amount,
                             l_deal_row.base_year,
                             0,
                             l_main_account_row.account_number,
                             l_interest_account_row.account_number,
                             l_party_main_account_row.account_number,
                             l_party_interest_account_row.account_number,
                             l_transit_account_row.account_number,
                             '% по дог. ' || l_deal_row.deal_number,
                             l_cc_deal_nd,
                             l_main_account_acc,
                             l_interest_account_acc);

        cdb_bars_object.set_bars_object_id(l_bars_deal_row.id, l_cc_deal_nd);
        cdb_bars_object.set_bars_object_id(l_main_account_row.id, l_main_account_acc);
        cdb_bars_object.set_bars_object_id(l_interest_account_row.id, l_interest_account_acc);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_deal_transaction', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure process_document_transaction(p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_object_row bars_object%rowtype;
        l_bars_document_row bars_document%rowtype;

        l_account_a_row bars_account%rowtype;
        l_account_b_row bars_account%rowtype;
        l_account_a_obj_row bars_object%rowtype;
        l_account_b_obj_row bars_object%rowtype;
        l_branch_a_row branch%rowtype;
        l_branch_b_row branch%rowtype;

        l_party_a_id integer;
        l_party_b_id integer;

        l_document_id integer;

        l_deal_objects t_number_list;
        l_bars_deal_object_row bars_object%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id, true);
        l_bars_document_row := cdb_bars_object.read_bars_document(l_object_row.id);

        l_account_a_row := cdb_bars_object.read_bars_account(l_bars_document_row.account_a_id);
        l_account_b_row := cdb_bars_object.read_bars_account(l_bars_document_row.account_b_id);

        l_account_a_obj_row := cdb_bars_object.read_bars_object(l_bars_document_row.account_a_id);
        l_account_b_obj_row := cdb_bars_object.read_bars_object(l_bars_document_row.account_b_id);

        l_branch_a_row := cdb_branch.read_branch(l_account_a_obj_row.branch_id);
        l_branch_b_row := cdb_branch.read_branch(l_account_b_obj_row.branch_id);

        l_party_a_id := cdb_branch.get_branch_customer(l_object_row.branch_id, l_account_a_obj_row.branch_id);
        l_party_b_id := cdb_branch.get_branch_customer(l_object_row.branch_id, l_account_b_obj_row.branch_id);

        l_deal_row := cdb_deal.read_deal(l_object_row.deal_id, p_raise_ndf => false);
        if (l_deal_row.id is not null) then
            l_deal_objects := cdb_bars_object.get_deal_objects(l_object_row.deal_id,
                                                               t_number_list(cdb_bars_object.OBJ_TYPE_DEPOSIT, cdb_bars_object.OBJ_TYPE_LOAN),
                                                               t_number_list(l_object_row.branch_id));
            if (l_deal_objects is not null and l_deal_objects.count = 1) then
                l_bars_deal_object_row := cdb_bars_object.read_bars_object(l_deal_objects(1));
            end if;

            if (l_bars_deal_object_row.bars_object_id is null) then
                raise_application_error(cdb_exception.GENERAL_EXCEPTION, 'Не вдалося визначити ідентифікатор угоди {' || l_deal_row.deal_number || '} в АБС');
            end if;
        end if;

        make_document(l_object_row.branch_id,
                      l_bars_deal_object_row.bars_object_id,
                      l_bars_document_row.operation_type,
                      l_bars_document_row.document_kind,
                      l_party_a_id,
                      l_party_b_id,
                      l_branch_a_row.branch_code,
                      l_branch_b_row.branch_code,
                      l_account_a_row.account_number,
                      l_account_b_row.account_number,
                      null,
                      l_bars_document_row.amount,
                      l_bars_document_row.currency_id,
                      l_bars_document_row.purpose,
                      l_document_id);

        cdb_bars_object.set_bars_object_id(l_bars_document_row.id, l_document_id);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_document_transaction', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure process_close_account_trans(p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_object_row bars_object%rowtype;
        l_account_row bars_account%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id);
        l_account_row := cdb_bars_object.read_bars_account(l_transaction_row.object_id);
        l_deal_row := cdb_deal.read_deal(l_object_row.deal_id);

        begin
            check_account_before_close(l_object_row.branch_id, l_account_row.account_number, l_deal_row.currency_id);
        exception
            when others then
                 if (sqlcode = cdb_exception.HAVE_TO_WAIT_FOR_BARS) then
                     track_transaction(p_transaction_id,
                                       cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS,
                                       sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
                     set_transaction_state(p_transaction_id, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS);
                     commit;
                     return;
                 else raise;
                 end if;
        end;

        close_account(l_object_row.branch_id,
                      l_account_row.account_number,
                      l_deal_row.currency_id,
                      l_deal_row.close_date);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_close_account_transaction', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure process_close_deal_trans(p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_object_row bars_object%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id);
        l_deal_row := cdb_deal.read_deal(l_object_row.deal_id);

        if (l_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Не вдалося визначити ідентифікатор угоди {' || l_deal_row.deal_number ||
                                    '} в АБС {' || cdb_branch.get_branch_name(l_object_row.branch_id) || '}');
        end if;

        close_deal(l_object_row.branch_id,
                   l_object_row.bars_object_id,
                   l_deal_row.close_date);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_close_account_transaction', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure process_set_deal_amount_trans(
        p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_object_row bars_object%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id);
        l_deal_row := cdb_deal.read_deal(l_object_row.deal_id);

        set_deal_amount(l_object_row.branch_id,
                        l_object_row.bars_object_id,
                        l_deal_row.amount);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_set_deal_amount_trans', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure process_set_int_rate_trans(
        p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_interest_rate_tran_row bars_tran_interest_rate%rowtype;
        l_object_row bars_object%rowtype;
        l_account_row bars_account%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_interest_rate_tran_row := read_interest_rate_transaction(p_transaction_id);
        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id);
        l_account_row := cdb_bars_object.read_bars_account(l_object_row.id);
        l_deal_row := cdb_deal.read_deal(l_object_row.deal_id);

        set_account_interest_rate(l_object_row.branch_id,
                                  l_account_row.account_number,
                                  l_deal_row.currency_id,
                                  l_interest_rate_tran_row.rate_kind,
                                  l_interest_rate_tran_row.rate_date,
                                  l_interest_rate_tran_row.rate_value);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_set_deal_int_rate_trans', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure process_set_exp_date_trans(
        p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_object_row bars_object%rowtype;
        l_deal_row deal%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id);
        l_deal_row := cdb_deal.read_deal(l_object_row.deal_id);

        set_deal_expiry_date(l_object_row.branch_id,
                             l_object_row.bars_object_id,
                             l_deal_row.expiry_date);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_set_exp_date_trans', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure process_add_deal_comment_trans(
        p_transaction_id in integer)
    is
        pragma autonomous_transaction;
        l_transaction_row bars_transaction%rowtype;
        l_deal_comment_transaction_row bars_tran_deal_comment%rowtype;
        l_object_row bars_object%rowtype;
    begin
        l_transaction_row := read_bars_transaction(p_transaction_id, true);

        if (l_transaction_row.state not in (cdb_bars_client.TRAN_STATE_NEW, cdb_bars_client.TRAN_STATE_INVALID, cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS)) then
            rollback;
            return;
        end if;

        l_object_row := cdb_bars_object.read_bars_object(l_transaction_row.object_id);
        if (l_object_row.bars_object_id is null) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, 'Не визначений ідентифікатор угоди в АБС для об''єкта ЦБД {' || l_object_row.id || '}');
        end if;

        l_deal_comment_transaction_row := read_deal_comment_transaction(p_transaction_id);

        add_deal_comment(l_object_row.branch_id,
                         l_object_row.bars_object_id,
                         l_deal_comment_transaction_row.deal_comment);

        complete_transaction(p_transaction_id);

        commit;
    exception
        when others then
             rollback;
             logger.log('cdb_bars_client.process_set_exp_date_trans', logger.LOG_LEVEL_ERROR,
                        'p_transaction_id : ' || p_transaction_id || chr(10) ||
                            sqlerrm || chr(10) ||
                            dbms_utility.format_error_backtrace());
             track_transaction_error(p_transaction_id, sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
    end;

    procedure get_next_transaction(
        p_exception_list t_number_list,
        p_next_transaction_id out integer,
        p_next_transaction_type out integer)
    is
        l_exception_list t_number_list;
    begin
        select bt.id
        bulk collect into l_exception_list
        from   bars_transaction bt
        join   (select bt.operation_id, min(bt.priority_group) min_priority_group
                from   bars_transaction bt
                where  bt.state in (cdb_bars_client.TRAN_STATE_INVALID,
                                    cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS,
                                    cdb_bars_client.TRAN_STATE_NEW)
                group by bt.operation_id) d on d.operation_id = bt.operation_id and
                                               bt.priority_group > d.min_priority_group;

        l_exception_list := l_exception_list multiset union p_exception_list;

        select min(bt.id), min(bt.transaction_type) keep (dense_rank first order by bt.id)
        into   p_next_transaction_id, p_next_transaction_type
        from   bars_transaction bt
        where  bt.state = cdb_bars_client.TRAN_STATE_NEW and
               bt.id not in (select column_value from table(l_exception_list));
    end;

    procedure process_bars_transaction(
        p_transaction_id in integer,
        p_transaction_type in integer)
    is
    begin
        case(p_transaction_type)
        when cdb_bars_client.TRAN_TYPE_BARS_DEAL then
            process_deal_transaction(p_transaction_id);
        when cdb_bars_client.TRAN_TYPE_BARS_DOCUMENT then
            process_document_transaction(p_transaction_id);
        when cdb_bars_client.TRAN_TYPE_CLOSE_DEAL then
            process_close_deal_trans(p_transaction_id);
        when cdb_bars_client.TRAN_TYPE_CLOSE_ACCOUNT then
            process_close_account_trans(p_transaction_id);
        when cdb_bars_client.TRAN_TYPE_CHANGE_DEAL_AMOUNT then
            process_set_deal_amount_trans(p_transaction_id);
        when cdb_bars_client.TRAN_TYPE_CHANGE_INTEREST_RATE then
            process_set_int_rate_trans(p_transaction_id);
        when cdb_bars_client.TRAN_TYPE_CHANGE_EXPIRY_DATE then
            process_set_exp_date_trans(p_transaction_id);
        when cdb_bars_client.TRAN_TYPE_ADD_DEAL_COMMENT then
            process_add_deal_comment_trans(p_transaction_id);
        end case;
    end;

    procedure process_bars_transactions
    is
        l_next_transaction_id integer;
        l_next_transaction_type integer;
        l_processed_transactions t_number_list default t_number_list();
    begin
        get_next_transaction(l_processed_transactions, l_next_transaction_id, l_next_transaction_type);

        while (l_next_transaction_id is not null) loop
            process_bars_transaction(l_next_transaction_id, l_next_transaction_type);

            l_processed_transactions.extend(1);
            l_processed_transactions(l_processed_transactions.last) := l_next_transaction_id;
            get_next_transaction(l_processed_transactions, l_next_transaction_id, l_next_transaction_type);
        end loop;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_bars_client.sql =========*** End 
 PROMPT ===================================================================================== 
 