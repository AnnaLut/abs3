
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_bars_object.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_BARS_OBJECT is

    ET_OBJECT_TYPE                 constant integer := 201;
    OBJ_TYPE_ACCOUNT               constant integer := 1;
    OBJ_TYPE_DEPOSIT               constant integer := 2;
    OBJ_TYPE_LOAN                  constant integer := 3;
    OBJ_TYPE_OPERATION             constant integer := 4;

    BALANCE_ACC_LENT_FUNDS         constant varchar2(4 char) := '3902';
    BALANCE_ACC_BORROWED_FUNDS     constant varchar2(4 char) := '3903';
    BALANCE_ACC_LENDER_INTEREST    constant varchar2(4 char) := '3904';
    BALANCE_ACC_BORROWER_INTEREST  constant varchar2(4 char) := '3905';

    function read_bars_object(
        p_object_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return bars_object%rowtype;

    function read_bars_deal(
        p_object_id in integer,
        p_raise_ndf in boolean default true)
    return bars_deal%rowtype;

    function read_bars_account(
        p_account_id in integer,
        p_raise_ndf in boolean default true)
    return bars_account%rowtype;

    function read_bars_document(
        p_document_id in integer,
        p_raise_ndf in boolean default true)
    return bars_document%rowtype;

    function create_bars_object(
        p_object_type in integer,
        p_deal_id in integer,
        p_branch_id in integer)
    return integer;

    function create_account(
        p_deal_id in integer,
        p_balance_account in varchar2,
        p_account_number in varchar2,
        p_branch_id in integer)
    return integer;

    function create_bars_deposit(
        p_deal_id in integer,
        p_deal_type in integer,
        p_product in integer,
        p_main_account_id in integer,
        p_interest_account_id in integer,
        p_transit_account_id in integer,
        p_branch_id in integer)
    return integer;

    function create_bars_loan(
        p_deal_id in integer,
        p_deal_type in integer,
        p_product in integer,
        p_main_account_id in integer,
        p_interest_account_id in integer,
        p_transit_account_id in integer,
        p_branch_id in integer)
    return integer;

    function create_bars_document(
        p_deal_id in integer,
        p_operation_type in varchar2,
        p_document_kind in integer,
        p_account_a_id in integer,
        p_account_b_id in integer,
        p_amount in number,
        p_currency_code in integer,
        p_purpose in varchar2,
        p_branch_id in integer)
    return integer;

    function get_deal_objects(
        p_deal_id in integer,
        p_object_type in t_number_list default null,
        p_branch_id in t_number_list default null)
    return t_number_list;

    function get_deal_loan_id(
        p_deal_id in integer,
        p_raise_ndf in boolean default true)
    return integer;

    function get_deal_deposit_id(
        p_deal_id in integer,
        p_raise_ndf in boolean default true)
    return integer;

    procedure set_bars_object_id(
        p_object_id in integer,
        p_bars_object_id in integer);

    procedure set_deal_party(
        p_deal_id in integer,
        p_party_deal_id in integer);

    procedure check_account_number_uniquness(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_BARS_OBJECT as
    function read_bars_object(
        p_object_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return bars_object%rowtype
    is
        l_object_row bars_object%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_row
            from   bars_object bt
            where  bt.id = p_object_id
            for update;
        else
            select *
            into   l_object_row
            from   bars_object bt
            where  bt.id = p_object_id;
        end if;

        return l_object_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Об''єкт АБС "Барс" з ідентифікатором {' || p_object_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_bars_deal(
        p_object_id in integer,
        p_raise_ndf in boolean default true)
    return bars_deal%rowtype
    is
        l_deal_row bars_deal%rowtype;
    begin
        select *
        into   l_deal_row
        from   bars_deal bd
        where  bd.id = p_object_id;

        return l_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Угода АБС "Барс" з ідентифікатором {' || p_object_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_bars_account(
        p_account_id in integer,
        p_raise_ndf in boolean default true)
    return bars_account%rowtype
    is
        l_account_row bars_account%rowtype;
    begin
        select *
        into   l_account_row
        from   bars_account ba
        where  ba.id = p_account_id;

        return l_account_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Рахунок АБС "Барс" з ідентифікатором {' || p_account_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_bars_document(
        p_document_id in integer,
        p_raise_ndf in boolean default true)
    return bars_document%rowtype
    is
        l_bars_document_row bars_document%rowtype;
    begin
        select *
        into   l_bars_document_row
        from   bars_document ba
        where  ba.id = p_document_id;

        return l_bars_document_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Документ АБС "Барс" з ідентифікатором {' || p_document_id || '} не знайдений');
             else return null;
             end if;
    end;

    function create_bars_object(p_object_type in integer, p_deal_id in integer, p_branch_id in integer)
    return integer
    is
        l_object_id integer;
    begin
        insert into bars_object
        values (bars_object_seq.nextval, p_object_type, p_deal_id, p_branch_id, null)
        returning id into l_object_id;

        return l_object_id;
    end;

    function create_bars_deposit(
        p_deal_id in integer,
        p_deal_type in integer,
        p_product in integer,
        p_main_account_id in integer,
        p_interest_account_id in integer,
        p_transit_account_id in integer,
        p_branch_id in integer)
    return integer
    is
        l_bars_deal_id integer;
    begin
        l_bars_deal_id := create_bars_object(cdb_bars_object.OBJ_TYPE_DEPOSIT, p_deal_id, p_branch_id);

        insert into bars_deal
        values (l_bars_deal_id, p_deal_type, p_product, p_main_account_id, p_interest_account_id, p_transit_account_id, null);

        return l_bars_deal_id;
    end;

    function create_bars_loan(
        p_deal_id in integer,
        p_deal_type in integer,
        p_product in integer,
        p_main_account_id in integer,
        p_interest_account_id in integer,
        p_transit_account_id in integer,
        p_branch_id in integer)
    return integer
    is
        l_bars_deal_id integer;
    begin
        l_bars_deal_id := create_bars_object(cdb_bars_object.OBJ_TYPE_LOAN, p_deal_id, p_branch_id);

        insert into bars_deal
        values (l_bars_deal_id, p_deal_type, p_product, p_main_account_id, p_interest_account_id, p_transit_account_id, null);

        return l_bars_deal_id;
    end;

    function create_account(
        p_deal_id in integer,
        p_balance_account in varchar2,
        p_account_number in varchar2,
        p_branch_id in integer)
    return integer
    is
        l_account_id integer;
    begin
        l_account_id := create_bars_object(cdb_bars_object.OBJ_TYPE_ACCOUNT, p_deal_id, p_branch_id);

        insert into bars_account
        values (l_account_id, p_balance_account, p_account_number);

        return l_account_id;
    end;

    function create_bars_document(
        p_deal_id in integer,
        p_operation_type in varchar2,
        p_document_kind in integer,
        p_account_a_id in integer,
        p_account_b_id in integer,
        p_amount in number,
        p_currency_code in integer,
        p_purpose in varchar2,
        p_branch_id in integer)
    return integer
    is
        l_operation_id integer;
    begin
        l_operation_id := create_bars_object(cdb_bars_object.OBJ_TYPE_OPERATION, p_deal_id, p_branch_id);

        insert into bars_document
        values (l_operation_id,
                p_operation_type,
                p_document_kind,
                p_account_a_id,
                p_account_b_id,
                p_amount,
                p_currency_code,
                p_purpose,
                sysdate);

        return l_operation_id;
    end;

    function get_deal_objects(
        p_deal_id in integer,
        p_object_type in t_number_list default null,
        p_branch_id in t_number_list default null)
    return t_number_list
    is
        l_objects t_number_list;
    begin
        select id
        bulk collect into l_objects
        from   bars_object bo
        where  bo.deal_id = p_deal_id and
               (p_object_type is null or bo.object_type member of p_object_type) and
               (p_branch_id is null or bo.branch_id member of p_branch_id);

        return l_objects;
    end;

    function get_deal_loan_id(
        p_deal_id in integer,
        p_raise_ndf in boolean default true)
    return integer
    is
        l_loan_id integer;
    begin
        select id
        into   l_loan_id
        from   bars_object bo
        where  bo.deal_id = p_deal_id and
               bo.object_type = cdb_bars_object.OBJ_TYPE_LOAN;

        return l_loan_id;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Кредитна частина для угоди з ідентифікатором {' || p_deal_id || '} не знайдена');
             else return null;
             end if;
        when too_many_rows then
             raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                     'Порушена цілістність данних по угоді з ідентифікатором {' || p_deal_id ||
                                     '} - з угодою пов''язано більше однієї кредитної частини');
    end;

    function get_deal_deposit_id(
        p_deal_id in integer,
        p_raise_ndf in boolean default true)
    return integer
    is
        l_deposit_id integer;
    begin
        select id
        into   l_deposit_id
        from   bars_object bo
        where  bo.deal_id = p_deal_id and
               bo.object_type = cdb_bars_object.OBJ_TYPE_DEPOSIT;

        return l_deposit_id;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Депозитна частина для угоди з ідентифікатором {' || p_deal_id || '} не знайдена');
             else return null;
             end if;
        when too_many_rows then
             raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                     'Порушена цілістність данних по угоді з ідентифікатором {' || p_deal_id ||
                                     '} - з угодою пов''язано більше однієї депозитної частини');
    end;

    procedure set_bars_object_id(
        p_object_id in integer,
        p_bars_object_id in integer)
    is
    begin
        update bars_object bo
        set    bo.bars_object_id = p_bars_object_id
        where  bo.id = p_object_id;
    end;

    procedure set_deal_party(
        p_deal_id in integer,
        p_party_deal_id in integer)
    is
    begin
        update bars_deal bd
        set    bd.party_bars_deal_id = p_party_deal_id
        where  bd.id = p_deal_id;
    end;

    procedure check_account_number_uniquness(
        p_branch_id in integer,
        p_account_number in varchar2,
        p_currency_id in integer)
    is
        l_deals t_varchar2_list;
    begin
        select d.deal_number
        bulk collect into l_deals
        from   bars_account ba
        join   bars_object bo on bo.id = ba.id
        join   deal d on d.id = bo.deal_id
        where  ba.account_number = p_account_number and
               d.currency_id = p_currency_id and
               bo.branch_id = p_branch_id and
               exists (select 1
                       from   bars_transaction bt
                       where  bt.object_id = ba.id and
                              bt.state <> cdb_bars_client.TRAN_STATE_CANCELED);

        if (l_deals is not empty) then
            raise_application_error(cdb_exception.GENERAL_EXCEPTION,
                                    'Номер рахунку {' || p_account_number ||
                                    '} з валютою {' || p_currency_id ||
                                    '} в філіалі {' || cdb_branch.get_branch_name(p_branch_id) ||
                                    '} вже зареєстрований для угоди {' || l_deals(1) || '}');
        end if;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_bars_object.sql =========*** End 
 PROMPT ===================================================================================== 
 