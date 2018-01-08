
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_claim.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_CLAIM is

    -- стани заявок
    ET_CLAIM_STATE                 constant integer := 101;
    CLAIM_STATE_NEW                constant integer :=  1;
    CLAIM_STATE_CHECK_FAILED       constant integer :=  2;
    CLAIM_STATE_WAIT_FOR_BARS      constant integer :=  3;
    CLAIM_STATE_CHECKED            constant integer :=  4;
    CLAIM_STATE_ACCEPTED           constant integer :=  5;
    CLAIM_STATE_INVALID            constant integer :=  6;
    CLAIM_STATE_PREPARED           constant integer :=  7;
    CLAIM_STATE_CANCELED           constant integer :=  8;
    CLAIM_STATE_COMPLETED          constant integer :=  9;
    CLAIM_STATE_PARTIAL_COMPLETED  constant integer := 10;

    -- типи заявок
    ET_CLAIM_TYPE                  constant integer := 102;
    CLAIM_TYPE_NEW_DEAL            constant integer := 1;
    CLAIM_TYPE_CHANGE_AMOUNT       constant integer := 2;
    CLAIM_TYPE_SET_INTEREST_RATE   constant integer := 3;
    CLAIM_TYPE_SET_EXPIRY_DATE     constant integer := 4;
    CLAIM_TYPE_CLOSE_DEAL          constant integer := 5;

    -- типи операцій взаємодії з АБС БАРС
    BARS_TRAN_TYPE_NEW             constant integer := 1;
    BARS_TRAN_TYPE_COMPLETED       constant integer := 2;

    BALANCE_ACC_LENT_FUNDS         constant varchar2(4 char) := '3902';
    BALANCE_ACC_BORROWED_FUNDS     constant varchar2(4 char) := '3903';
    BALANCE_ACC_LENDER_INTEREST    constant varchar2(4 char) := '3904';
    BALANCE_ACC_BORROWER_INTEREST  constant varchar2(4 char) := '3905';

    function read_claim(
        p_claim_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return claim%rowtype;

    function get_claim_by_external_id(
        p_external_claim_id in varchar2)
    return integer;

    function read_claim_new_deal(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_new_deal%rowtype;

    function read_claim_close_deal(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_close_deal%rowtype;

    function read_claim_change_amount(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_change_amount%rowtype;

    function read_claim_change_int_rate(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_change_interest_rate%rowtype;

    function read_claim_change_exp_date(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_change_expiry_date%rowtype;

    function create_new_deal_claim(
        p_deal_number in varchar2,
        p_lender_code in varchar2,
        p_borrower_code in varchar2,
        p_open_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_rate in number,
        p_base_year in integer)
    return integer;

    function create_close_deal_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_close_date in date)
    return integer;

    function create_change_amount_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_amount_delta in number)
    return integer;

    function create_set_interest_rate_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_interest_rate in number,
        p_interest_rate_date in date)
    return integer;

    function create_set_expiry_date_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_new_expiry_date in date)
    return integer;

    function get_claim_type_name(
        p_claim_type_id in integer)
    return varchar2;

    function get_claim_deal_number(
        p_claim_id in integer,
        p_claim_type in integer)
    return varchar2;

    function get_claim_comment(
        p_claim_id in integer)
    return varchar2;

    function get_claim_region_code(
        p_claim_id in integer,
        p_claim_type in integer)
    return varchar2;

    procedure set_claim_external_id(
        p_claim_id in integer,
        p_external_id in varchar2);

    procedure set_claim_comment(
        p_claim_id in integer,
        p_comment_text in varchar2);

    procedure set_claim_state_checked(
        p_claim_id in integer,
        p_comment in varchar2 default null);

    procedure set_claim_state_check_failed(
        p_claim_id in integer,
        p_claim_state in integer,
        p_comment in varchar2,
        p_stack_trace in clob);

    procedure set_claim_state_canceled(
        p_claim_id in integer,
        p_comment in varchar2);

    procedure set_claim_state_accepted(
        p_claim_id in integer,
        p_comment in varchar2 default null);

    procedure set_claim_state_invalid(
        p_claim_id in integer,
        p_comment in varchar2,
        p_stack_trace in clob);

    procedure set_claim_state_prepared(
        p_claim_id in integer,
        p_comment in varchar2 default null);

    procedure set_claim_state_completed(
        p_claim_id in integer,
        p_comment in varchar2 default null);

    procedure set_claim_state_part_completed(
        p_claim_id in integer,
        p_comment in varchar2 default null);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_CLAIM as

    function read_claim(
        p_claim_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return claim%rowtype
    is
        l_in_transaction_row claim%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_in_transaction_row
            from   claim t
            where  t.id = p_claim_id
            for update;
        else
            select *
            into   l_in_transaction_row
            from   claim t
            where  t.id = p_claim_id;
        end if;

        return l_in_transaction_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(cdb_exception.NO_DATA_FOUND,
                                         'Вхідна заявка з ідентифікатором {' || p_claim_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_claim_new_deal(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_new_deal%rowtype
    is
        l_claim_new_deal_row claim_new_deal%rowtype;
    begin
        select *
        into   l_claim_new_deal_row
        from   claim_new_deal cnc
        where  cnc.claim_id = p_claim_id;

        return l_claim_new_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Заявка на відкриття нового договору з ідентифікатором {' || p_claim_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_claim_close_deal(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_close_deal%rowtype
    is
        l_claim_close_deal_row claim_close_deal%rowtype;
    begin
        select *
        into   l_claim_close_deal_row
        from   claim_close_deal cnc
        where  cnc.claim_id = p_claim_id;

        return l_claim_close_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Заявка на закриття договору з ідентифікатором {' || p_claim_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_claim_change_amount(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_change_amount%rowtype
    is
        l_claim_change_amount_row claim_change_amount%rowtype;
    begin
        select *
        into   l_claim_change_amount_row
        from   claim_change_amount cnc
        where  cnc.claim_id = p_claim_id;

        return l_claim_change_amount_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Заявка на зміну суми угоди з ідентифікатором {' || p_claim_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_claim_change_int_rate(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_change_interest_rate%rowtype
    is
        l_claim_change_int_rate_row claim_change_interest_rate%rowtype;
    begin
        select *
        into   l_claim_change_int_rate_row
        from   claim_change_interest_rate cnc
        where  cnc.claim_id = p_claim_id;

        return l_claim_change_int_rate_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Заявка на зміну відсоткової ставки з ідентифікатором {' || p_claim_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_claim_change_exp_date(
        p_claim_id in integer,
        p_raise_ndf in boolean default true)
    return claim_change_expiry_date%rowtype
    is
        l_claim_change_exp_date_row claim_change_expiry_date%rowtype;
    begin
        select *
        into   l_claim_change_exp_date_row
        from   claim_change_expiry_date cnc
        where  cnc.claim_id = p_claim_id;

        return l_claim_change_exp_date_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Заявка на зміну дати завершення угоди з ідентифікатором {' || p_claim_id || '} не знайдена');
             else return null;
             end if;
    end;

    function create_claim(
        p_claim_type in integer)
    return integer
    is
        l_claim_id integer;
    begin
        insert into claim
        values (claim_seq.nextval, p_claim_type, cdb_claim.CLAIM_STATE_NEW, sysdate)
        returning id into l_claim_id;

        return l_claim_id;
    end;

    function create_new_deal_claim(
        p_deal_number in varchar2,
        p_lender_code in varchar2,
        p_borrower_code in varchar2,
        p_open_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_interest_rate in number,
        p_base_year in integer)
    return integer
    is
        l_claim_id integer;
    begin
        l_claim_id := create_claim(cdb_claim.CLAIM_TYPE_NEW_DEAL);

        insert into claim_new_deal
        values (l_claim_id,
                p_deal_number,
                p_open_date,
                p_expiry_date,
                p_lender_code,
                p_borrower_code,
                p_amount,
                p_currency_id,
                p_interest_rate,
                p_base_year);

        return l_claim_id;
    end;

    function create_close_deal_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_close_date in date)
    return integer
    is
        l_claim_id integer;
    begin
        l_claim_id := create_claim(cdb_claim.CLAIM_TYPE_CLOSE_DEAL);

        insert into claim_close_deal
        values (l_claim_id, p_deal_number, p_close_date, p_currency_id);

        return l_claim_id;
    end;

    function create_change_amount_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_amount_delta in number)
    return integer
    is
        l_claim_id integer;
    begin
        l_claim_id := create_claim(cdb_claim.CLAIM_TYPE_CHANGE_AMOUNT);

        insert into claim_change_amount
        values (l_claim_id, p_deal_number, p_amount_delta, p_currency_id);

        return l_claim_id;
    end;

    function create_set_interest_rate_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_interest_rate in number,
        p_interest_rate_date in date)
    return integer
    is
        l_claim_id integer;
    begin
        l_claim_id := create_claim(cdb_claim.CLAIM_TYPE_SET_INTEREST_RATE);

        insert into claim_change_interest_rate
        values (l_claim_id, p_deal_number, p_interest_rate_date, p_interest_rate, p_currency_id);

        return l_claim_id;
    end;

    function create_set_expiry_date_claim(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_new_expiry_date in date)
    return integer
    is
        l_claim_id integer;
    begin
        l_claim_id := create_claim(cdb_claim.CLAIM_TYPE_SET_EXPIRY_DATE);

        insert into claim_change_expiry_date
        values (l_claim_id, p_deal_number, p_new_expiry_date, p_currency_id);

        return l_claim_id;
    end;

    function get_claim_by_external_id(
        p_external_claim_id in varchar2)
    return integer
    is
        l_claim_id integer;
    begin
        select t.claim_id
        into   l_claim_id
        from   claim_external_id t
        where  t.external_id = p_external_claim_id;


        return l_claim_id;
    exception
        when no_data_found then
             return null;
    end;

    function get_claim_type_name(
        p_claim_type_id in integer)
    return varchar2
    is
    begin
        return cdb_enumeration.get_enumeration_name(cdb_claim.ET_CLAIM_TYPE, p_claim_type_id);
    end;

    procedure get_claim_deal_number(
        p_claim_id in integer,
        p_claim_type in integer,
        p_deal_number out varchar2,
        p_deal_currency_id out integer)
    is
        l_claim_new_deal_row claim_new_deal%rowtype;
        l_claim_change_expiry_date_row claim_change_expiry_date%rowtype;
        l_claim_change_int_rate_row claim_change_interest_rate%rowtype;
        l_claim_change_amount_row claim_change_amount%rowtype;
        l_claim_close_deal_row claim_close_deal%rowtype;
    begin
        case (p_claim_type)
        when cdb_claim.CLAIM_TYPE_NEW_DEAL then
             l_claim_new_deal_row := read_claim_new_deal(p_claim_id, false);
             p_deal_number := l_claim_new_deal_row.deal_number;
             p_deal_currency_id := l_claim_new_deal_row.currency_id;
        when cdb_claim.CLAIM_TYPE_CHANGE_AMOUNT then
             l_claim_change_amount_row := read_claim_change_amount(p_claim_id, false);
             p_deal_number := l_claim_change_amount_row.deal_number;
             p_deal_currency_id := l_claim_change_amount_row.currency_id;
        when cdb_claim.CLAIM_TYPE_SET_INTEREST_RATE then
             l_claim_change_int_rate_row := read_claim_change_int_rate(p_claim_id, false);
             p_deal_number := l_claim_change_int_rate_row.deal_number;
             p_deal_currency_id := l_claim_change_int_rate_row.currency_id;
        when cdb_claim.CLAIM_TYPE_SET_EXPIRY_DATE then
             l_claim_change_expiry_date_row := read_claim_change_exp_date(p_claim_id, false);
             p_deal_number := l_claim_change_expiry_date_row.deal_number;
             p_deal_currency_id := l_claim_change_expiry_date_row.currency_id;
        when cdb_claim.CLAIM_TYPE_CLOSE_DEAL then
             l_claim_close_deal_row := read_claim_close_deal(p_claim_id, false);
             p_deal_number := l_claim_close_deal_row.deal_number;
             p_deal_currency_id := l_claim_close_deal_row.currency_id;
        end case;
    end;

    function get_claim_deal_number(
        p_claim_id in integer,
        p_claim_type in integer)
    return varchar2
    is
        l_deal_number varchar2(30 char);
        l_currency_id integer;
    begin
        get_claim_deal_number(p_claim_id, p_claim_type, l_deal_number, l_currency_id);
        return case when l_deal_number is null then null
                    else l_deal_number || '\' || l_currency_id
               end;
    end;

    function get_claim_transactions(
        p_claim_id in integer,
        p_transaction_types in t_number_list default null,
        p_transaction_states in t_number_list default null,
        p_transaction_branches in t_number_list default null)
    return t_number_list
    is
        l_claim_transactions t_number_list;
    begin
        select bt.id
        bulk collect into l_claim_transactions
        from   bars_transaction bt
        where  bt.operation_id in (select o.id
                                   from   operation o
                                   where  o.claim_id = p_claim_id) and
               (p_transaction_types is null or bt.transaction_type member of p_transaction_types) and
               (p_transaction_states is null or bt.state member of p_transaction_states) and
               (p_transaction_branches is null or (select bo.branch_id
                                                   from   bars_object bo
                                                   where  bo.id = bt.object_id) member of p_transaction_branches);

        return l_claim_transactions;
    end;

    function get_claim_comment(p_claim_id in integer)
    return varchar2
    is
        l_comment_text varchar2(4000 byte);
    begin
        select cc.comment_text
        into   l_comment_text
        from   claim_comment cc
        where  cc.claim_id = p_claim_id;

        return l_comment_text;
    exception
        when no_data_found then
             return null;
    end;

    function get_claim_region_code(
        p_claim_id in integer,
        p_claim_type in integer)
    return varchar2
    is
        l_deal_number varchar2(30 char);
        l_currency_id integer;
        l_deal_row deal%rowtype;
        l_claim_new_deal_row claim_new_deal%rowtype;
    begin
        case (p_claim_type)
        when cdb_claim.CLAIM_TYPE_NEW_DEAL then
             l_claim_new_deal_row := read_claim_new_deal(p_claim_id, false);
             return case when l_claim_new_deal_row.lender_code = cdb_branch.BRANCH_CODE_CENTRAL_APPARAT then l_claim_new_deal_row.borrower_code
                         else l_claim_new_deal_row.lender_code
                    end;
        else
             get_claim_deal_number(p_claim_id, p_claim_type, l_deal_number, l_currency_id);
             l_deal_row := cdb_deal.read_deal(l_deal_number, l_currency_id, p_raise_ndf => false);
             if (l_deal_row.id is not null) then
                 return cdb_deal.get_region_branch_code(l_deal_row.id);
             else return null;
             end if;
        end case;
    end;

    procedure set_claim_external_id(
        p_claim_id in integer,
        p_external_id in varchar2)
    is
    begin
        if (p_external_id is not null) then
            insert into claim_external_id
            values (p_claim_id, p_external_id);
        end if;
    end;

    procedure set_claim_comment(
        p_claim_id in integer,
        p_comment_text in varchar2)
    is
    begin
        if (p_comment_text is not null) then
            insert into claim_comment
            values (p_claim_id, p_comment_text);
        end if;
    end;

    procedure set_claim_state(
        p_claim_id in integer,
        p_claim_state in integer,
        p_comment in varchar2 default null,
        p_stack_trace in clob default null)
    is
    begin
        update claim c
        set    c.state = p_claim_state
        where  c.id = p_claim_id;

        insert into claim_tracking
        values (claim_tracking_seq.nextval, p_claim_id, p_claim_state, sysdate, p_comment, p_stack_trace);
    end;

    procedure set_claim_state_checked(
        p_claim_id in integer,
        p_comment in varchar2 default null)
    is
        l_claim_row claim%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW,
                                      cdb_claim.CLAIM_STATE_CHECK_FAILED,
                                      cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка перебуває в стані {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} і не потребує перевірки');
        end if;
        set_claim_state(p_claim_id, cdb_claim.CLAIM_STATE_CHECKED, nvl(p_comment, 'Автоматичні перевірки пройшли успішно'));
    end;

    procedure set_claim_state_check_failed(
        p_claim_id in integer,
        p_claim_state in integer,
        p_comment in varchar2,
        p_stack_trace in clob)
    is
        l_claim_row claim%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW,
                                      cdb_claim.CLAIM_STATE_CHECK_FAILED,
                                      cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка перебуває в стані {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} і не потребує перевірки');
        end if;

        if (p_claim_state not in (cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Недопустимий статус заявки при непроходженні перевірок {' ||
                                        cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, p_claim_state) || '}');
        end if;

        set_claim_state(p_claim_id, p_claim_state, p_comment, p_stack_trace);
    end;

    procedure set_claim_state_canceled(
        p_claim_id in integer,
        p_comment in varchar2)
    is
        l_claim_row claim%rowtype;
        l_claim_transactions t_number_list;
    begin
        l_claim_row := read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state = cdb_claim.CLAIM_STATE_ACCEPTED) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, 'Акцептована заявка не може бути відмінена');
        end if;
        if (l_claim_row.state = cdb_claim.CLAIM_STATE_COMPLETED) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION, 'Заявка, з завершеним циклом обробки, не може бути відмінена');
        end if;
        if (l_claim_row.state = cdb_claim.CLAIM_STATE_PREPARED) then
            l_claim_transactions := get_claim_transactions(p_claim_id,
                                                           p_transaction_states => t_number_list(cdb_bars_client.TRAN_STATE_NEW,
                                                                                                 cdb_bars_client.TRAN_STATE_INVALID,
                                                                                                 cdb_bars_client.TRAN_STATE_WAIT_FOR_BARS));
            if (l_claim_transactions is not null and l_claim_transactions is not empty) then
                raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                        'Для заявки залишаються відкритими одна або більше транзакцій до АБС - ' ||
                                            'перед відміною заявки всі транзакції мають бути відмінені');
            end if;
        end if;
        set_claim_state(p_claim_id, cdb_claim.CLAIM_STATE_CANCELED, p_comment);
    end;

    procedure set_claim_state_accepted(
        p_claim_id in integer,
        p_comment in varchar2 default null)
    is
        l_claim_row claim%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_NEW, cdb_claim.CLAIM_STATE_CHECK_FAILED, cdb_claim.CLAIM_STATE_WAIT_FOR_BARS, cdb_claim.CLAIM_STATE_CHECKED)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка перебуває в стані {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} і не може бути акцептована');
        end if;
        set_claim_state(p_claim_id, cdb_claim.CLAIM_STATE_ACCEPTED, nvl(p_comment, 'Завізована казначейством'));
    end;

    procedure set_claim_state_invalid(
        p_claim_id in integer,
        p_comment in varchar2,
        p_stack_trace in clob)
    is
        l_claim_row claim%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка перебуває в стані {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} і не може бути інвалідована');
        end if;

        set_claim_state(p_claim_id, cdb_claim.CLAIM_STATE_INVALID, p_comment, p_stack_trace);
    end;

    procedure set_claim_state_prepared(
        p_claim_id in integer,
        p_comment in varchar2 default null)
    is
        l_claim_row claim%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_CHECKED, cdb_claim.CLAIM_STATE_ACCEPTED, cdb_claim.CLAIM_STATE_INVALID)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка перебуває в стані {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} і не може бути підготовлена до передачі в АБС');
        end if;
        set_claim_state(p_claim_id, cdb_claim.CLAIM_STATE_PREPARED, nvl(p_comment, 'Виконана в ЦБД - виконується передача даних до АБС'));
    end;

    procedure set_claim_state_completed(
        p_claim_id in integer,
        p_comment in varchar2 default null)
    is
        l_claim_row claim%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_PREPARED)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка перебуває в стані {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} і її обробку не можна завершити на даному етапі');
        end if;
        set_claim_state(p_claim_id, cdb_claim.CLAIM_STATE_COMPLETED, nvl(p_comment, 'Обробку завершено успішно'));
    end;

    procedure set_claim_state_part_completed(
        p_claim_id in integer,
        p_comment in varchar2 default null)
    is
        l_claim_row claim%rowtype;
    begin
        l_claim_row := cdb_claim.read_claim(p_claim_id, p_lock => true);
        if (l_claim_row.state not in (cdb_claim.CLAIM_STATE_PREPARED)) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Заявка перебуває в стані {' || cdb_enumeration.get_enumeration_code(cdb_claim.ET_CLAIM_STATE, l_claim_row.state) ||
                                    '} і її обробку не можна завершити на даному етапі');
        end if;
        set_claim_state(p_claim_id, cdb_claim.CLAIM_STATE_PARTIAL_COMPLETED, nvl(p_comment, 'Обробку завершено - деякі транзакції були відхилені'));
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_claim.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 