create or replace package nbu_object_utl is

    OBJ_TYPE_PERSON                constant integer := 1;
    OBJ_TYPE_COMPANY               constant integer := 2;
    OBJ_TYPE_PLEDGE                constant integer := 3;
    OBJ_TYPE_LOAN                  constant integer := 4;

    OBJ_STATE_NEW                  constant integer := 1;
    OBJ_STATE_REPORTED             constant integer := 2;
    OBJ_STATE_REPORTING_FAILURE    constant integer := 3;
    OBJ_STATE_MODIFICATION_ARRANG  constant integer := 4;
    -- OBJ_STATE_MODIFIED             constant integer := 5;
    OBJ_STATE_MODIFICATION_FAILURE constant integer := 6;
    OBJ_STATE_DISMISSAL_ARRANGED   constant integer := 7;
    OBJ_STATE_DISMISSED            constant integer := 8;
    OBJ_STATE_DISMISSAL_FAILURE    constant integer := 9;

    function read_customer(
        p_customer_id in integer,
        p_raise_ndf in boolean default true)
    return nbu_reported_customer%rowtype;

    function read_customer(
        p_customer_code in varchar2,
        p_raise_ndf in boolean default true)
    return nbu_reported_customer%rowtype;

    procedure create_company(
        p_company in out nocopy t_core_company);

    procedure create_person(
        p_person in out nocopy t_core_person);

    procedure create_pledge(
        p_pledge in out nocopy t_core_pledge);

    procedure create_loan(
        p_loan in out nocopy t_core_loan);

    procedure alter_company(
        p_company in t_core_company);

    procedure alter_person(
        p_person in t_core_person);

    procedure alter_pledge(
        p_pledge in t_core_pledge);

    procedure alter_loan(
        p_loan in t_core_loan);

    procedure set_object_state(
        p_object_id in integer,
        p_object_state_id in integer,
        p_tracking_comment in varchar2);

    procedure set_customer_core_id(
        p_object_id in integer,
        p_core_customer_kf in varchar2,
        p_core_customer_id in integer);

    procedure set_pledge_core_id(
        p_object_id in integer,
        p_core_pledge_kf in varchar2,
        p_core_pledge_id in integer);

    procedure set_loan_core_id(
        p_object_id in integer,
        p_core_loan_kf in varchar2,
        p_core_loan_id in integer);

    procedure set_object_external_id(
        p_object_id in integer,
        p_external_object_id in varchar2);

    function read_object(
        p_object_id in integer,
        p_lock in boolean default false)
    return nbu_reported_object%rowtype;

    function read_pledge(
        p_pledge_id in integer)
    return nbu_reported_pledge%rowtype;

    function read_pledge(
        p_customer_id in integer,
        p_pledge_number in varchar2,
        p_pledge_date in date,
        p_raise_ndf in boolean default true)
    return nbu_reported_pledge%rowtype;

    function read_loan(
        p_load_id in integer)
    return nbu_reported_loan%rowtype;

    function read_loan(
        p_customer_id in integer,
        p_loan_number in varchar2,
        p_loan_date in date,
        p_raise_ndf in boolean default true)
    return nbu_reported_loan%rowtype;

    function get_object_code(
        p_object_row nbu_reported_object%rowtype)
    return varchar2;

    function get_customer_by_core_id(
        p_core_customer_id in integer,
        p_core_customer_kf in varchar2)
    return nbu_reported_customer%rowtype;

    function get_pledge_by_core_id(
        p_core_pledge_id in integer,
        p_core_pledge_kf in varchar2)
    return nbu_reported_pledge%rowtype;

    function get_loan_by_core_id(
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return nbu_reported_loan%rowtype;

    procedure dismiss_object(
        p_object_id in integer,
        p_dismissal_comment in varchar2);

    function get_object_json(
        p_object_id in integer,
        p_report_id in integer default null)
    return clob;

end;
/
create or replace package body nbu_object_utl as

    function read_object(
        p_object_id in integer,
        p_lock in boolean default false)
    return nbu_reported_object%rowtype
    is
        l_object_row nbu_reported_object%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_object_row
            from   nbu_reported_object t
            where  t.id = p_object_id
            for update;
        else
            select *
            into   l_object_row
            from   nbu_reported_object t
            where  t.id = p_object_id;
        end if;

        return l_object_row;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Об''єкт НБУ з ідентифікатором {' || p_object_id || '} не знайдений');
    end;

    function read_customer(
        p_customer_id in integer,
        p_raise_ndf in boolean default true)
    return nbu_reported_customer%rowtype
    is
        l_customer_row nbu_reported_customer%rowtype;
    begin
        select *
        into   l_customer_row
        from   nbu_reported_customer t
        where  t.id = p_customer_id;

        return l_customer_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Дані клієнта з ідентифікатором {' || p_customer_id || '} не знайдені');
             else return null;
             end if;
    end;

    function read_customer(
        p_customer_code in varchar2,
        p_raise_ndf in boolean default true)
    return nbu_reported_customer%rowtype
    is
        l_customer_row nbu_reported_customer%rowtype;
    begin
        select *
        into   l_customer_row
        from   nbu_reported_customer t
        where  t.customer_code = p_customer_code;

        return l_customer_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Дані клієнта з кодом {' || p_customer_code || '} не знайдені');
             else return null;
             end if;
    end;

    function read_pledge(
        p_pledge_id in integer)
    return nbu_reported_pledge%rowtype
    is
        l_pledge_row nbu_reported_pledge%rowtype;
    begin
        select *
        into   l_pledge_row
        from   nbu_reported_pledge t
        where  t.id = p_pledge_id;

        return l_pledge_row;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Дані застави з ідентифікатором {' || p_pledge_id || '} не знайдені');
    end;

    function read_pledge(
        p_customer_id in integer,
        p_pledge_number in varchar2,
        p_pledge_date in date,
        p_raise_ndf in boolean default true)
    return nbu_reported_pledge%rowtype
    is
        l_pledge_row nbu_reported_pledge%rowtype;
    begin
        select *
        into   l_pledge_row
        from   nbu_reported_pledge t
        where  t.customer_object_id = p_customer_id and
               t.pledge_number = p_pledge_number and
               t.pledge_date = p_pledge_date;

        return l_pledge_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Дані застави з номером {' || p_pledge_number ||
                                                 '} на дату {' || p_pledge_date ||
                                                 '} для клієнта {' || p_customer_id ||
                                                 '} не знайдені');
             else return null;
             end if;
    end;

    function read_loan(
        p_load_id in integer)
    return nbu_reported_loan%rowtype
    is
        l_loan_row nbu_reported_loan%rowtype;
    begin
        select *
        into   l_loan_row
        from   nbu_reported_loan t
        where  t.id = p_load_id;

        return l_loan_row;
    exception
        when no_data_found then
             raise_application_error(-20000, 'Дані кредиту з ідентифікатором {' || p_load_id || '} не знайдені');
    end;

    function read_loan(
        p_customer_id in integer,
        p_loan_number in varchar2,
        p_loan_date in date,
        p_raise_ndf in boolean default true)
    return nbu_reported_loan%rowtype
    is
        l_loan_row nbu_reported_loan%rowtype;
    begin
        select *
        into   l_loan_row
        from   nbu_reported_loan t
        where  t.customer_object_id = p_customer_id and
               t.loan_number = p_loan_number and
               t.loan_date = p_loan_date;

        return l_loan_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Дані кредитного договору з номером {' || p_loan_number ||
                                                 '} на дату {' || p_loan_date ||
                                                 '} для клієнта {' || p_customer_id ||
                                                 '} не знайдені');
             else return null;
             end if;
    end;

    function get_object_code(
        p_object_row nbu_reported_object%rowtype)
    return varchar2
    is
        l_pledge_row nbu_reported_pledge%rowtype;
        l_loan_row nbu_reported_loan%rowtype;
    begin
        if (p_object_row.object_type_id in (nbu_object_utl.OBJ_TYPE_COMPANY, nbu_object_utl.OBJ_TYPE_PERSON)) then
            return read_customer(p_object_row.id).customer_code;
        elsif (p_object_row.object_type_id = nbu_object_utl.OBJ_TYPE_PLEDGE) then
            l_pledge_row := read_pledge(p_object_row.id);
            return l_pledge_row.pledge_number || ' від ' || to_char(l_pledge_row.pledge_date, 'dd.mm.yyyy');
        elsif (p_object_row.object_type_id = nbu_object_utl.OBJ_TYPE_LOAN) then
            l_loan_row := read_loan(p_object_row.id);
            return l_loan_row.loan_number || ' від ' || l_loan_row.loan_date;
        end if;
    end;

    function get_object_comment(
        p_object_id in integer)
    return varchar2
    is
        l_comment varchar2(4000 byte);
    begin
        select min(t.tracking_comment) keep (dense_rank last order by t.sys_time)
        into   l_comment
        from   nbu_reported_object_tracking t
        where  t.reported_object_id = p_object_id;

        return l_comment;
    end;

    function get_customer_by_core_id(
        p_core_customer_id in integer,
        p_core_customer_kf in varchar2)
    return nbu_reported_customer%rowtype
    is
        l_customer_row nbu_reported_customer%rowtype;
    begin
        select t.*
        into   l_customer_row
        from   nbu_reported_customer t
        where  t.core_customer_kf = p_core_customer_kf and
               t.core_customer_id = p_core_customer_id;

        return l_customer_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_pledge_by_core_id(
        p_core_pledge_id in integer,
        p_core_pledge_kf in varchar2)
    return nbu_reported_pledge%rowtype
    is
        l_pledge_row nbu_reported_pledge%rowtype;
    begin
        select *
        into   l_pledge_row
        from   nbu_reported_pledge t
        where  t.core_pledge_id = p_core_pledge_id and
               t.core_pledge_kf = p_core_pledge_kf;

        return l_pledge_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_loan_by_core_id(
        p_core_loan_id in integer,
        p_core_loan_kf in varchar2)
    return nbu_reported_loan%rowtype
    is
        l_loan_row nbu_reported_loan%rowtype;
    begin
        select *
        into   l_loan_row
        from   nbu_reported_loan t
        where  t.core_loan_id = p_core_loan_id and
               t.core_loan_kf = p_core_loan_kf;

        return l_loan_row;
    exception
        when no_data_found then
             return null;
    end;

    procedure check_customer_code_uniqueness(
        p_customer_code in varchar2)
    is
    begin
        if (read_customer(p_customer_code, p_raise_ndf => false).id is not null) then
            raise_application_error(-20000, 'Клієнт з кодом {' || p_customer_code || '} вже існує');
        end if;
    end;

    procedure check_pledge_uniqueness(
        p_customer_id in integer,
        p_pledge_number in varchar2,
        p_pledge_date in date)
    is
        l_pledge_id integer;
    begin
        l_pledge_id := read_pledge(p_customer_id, p_pledge_number, p_pledge_date, p_raise_ndf => false).id;

        if (l_pledge_id is not null) then
            raise_application_error(-20000, 'Застава з номером {' || p_pledge_number ||
                                            '} на дату {' || p_pledge_date ||
                                            '} вже існує з ідентифікатором {' || l_pledge_id || '}');
        end if;
    end;

    procedure check_loan_uniqueness(
        p_customer_id in integer,
        p_loan_number in varchar2,
        p_loan_date in date)
    is
        l_loan_id integer;
    begin
        l_loan_id := read_loan(p_customer_id, p_loan_number, p_loan_date, p_raise_ndf => false).id;

        if (l_loan_id is not null) then
            raise_application_error(-20000, 'Кредитний договір з номером {' || p_loan_number ||
                                            '} на дату {' || p_loan_date ||
                                            '} вже існує з ідентифікатором {' || l_loan_id || '}');
        end if;
    end;

    procedure track_object(
        p_reported_object_id in integer,
        p_state_id in integer,
        p_tracking_comment in varchar2)
    is
    begin
        insert into nbu_reported_object_tracking
        values (p_reported_object_id, sysdate, p_state_id, p_tracking_comment);
    end;

    procedure set_customer_core_id(
        p_object_id in integer,
        p_core_customer_kf in varchar2,
        p_core_customer_id in integer)
    is
    begin
        update nbu_reported_customer t
        set    t.core_customer_kf = p_core_customer_kf,
               t.core_customer_id = p_core_customer_id
        where  t.id = p_object_id;
    end;

    procedure set_pledge_core_id(
        p_object_id in integer,
        p_core_pledge_kf in varchar2,
        p_core_pledge_id in integer)
    is
    begin
        update nbu_reported_pledge t
        set    t.core_pledge_kf = p_core_pledge_kf,
               t.core_pledge_id = p_core_pledge_id
        where  t.id = p_object_id;
    end;

    procedure set_loan_core_id(
        p_object_id in integer,
        p_core_loan_kf in varchar2,
        p_core_loan_id in integer)
    is
    begin
        update nbu_reported_loan t
        set    t.core_loan_kf = p_core_loan_kf,
               t.core_loan_id = p_core_loan_id
        where  t.id = p_object_id;
    end;

    procedure set_object_state(
        p_object_id in integer,
        p_object_state_id in integer,
        p_tracking_comment in varchar2)
    is
    begin
        update nbu_reported_object t
        set    t.state_id = p_object_state_id
        where  t.id = p_object_id;

        track_object(p_object_id, p_object_state_id, p_tracking_comment);
    end;

    function create_object(
        p_object_type_id in integer,
        p_state_id in integer default nbu_object_utl.OBJ_STATE_NEW)
    return integer
    is
        l_object_id integer;
    begin
        insert into nbu_reported_object
        values (s_nbu_reported_object.nextval, p_object_type_id, p_state_id, null)
        returning id
        into l_object_id;

        track_object(l_object_id, p_state_id, '');

        return l_object_id;
    end;

    procedure create_person(
        p_person in out nocopy t_core_person)
    is
        l_object_id integer;
    begin
        if (p_person.reported_object_id is not null) then
            raise_application_error(-20000, 'Фізична особа з кодом {' || p_person.person_code ||
                                            '} та ідентифікатором {' || p_person.reported_object_id || '} вже створена');
        end if;

        check_customer_code_uniqueness(p_person.person_code);

        l_object_id := create_object(nbu_object_utl.OBJ_TYPE_PERSON);

        insert into nbu_reported_customer
        values (l_object_id,
                p_person.person_code,
                trim(p_person.lastname || ' ' || p_person.firstname || ' ' || p_person.middlename),
                p_person.core_object_kf,
                p_person.core_object_id);

        p_person.reported_object_id := l_object_id;
    end;

    procedure create_company(
        p_company in out nocopy t_core_company)
    is
        l_object_id integer;
    begin
        if (p_company.reported_object_id is not null) then
            raise_application_error(-20000, 'Юридична особа з кодом {' || p_company.company_code ||
                                            '} та ідентифікатором {' || p_company.reported_object_id || '} вже створена');
        end if;

        check_customer_code_uniqueness(p_company.company_code);

        l_object_id := create_object(nbu_object_utl.OBJ_TYPE_COMPANY);

        insert into nbu_reported_customer
        values (l_object_id,
                p_company.company_code,
                p_company.nameur,
                p_company.core_object_kf,
                p_company.core_object_id);

        p_company.reported_object_id := l_object_id;
    end;

    procedure create_pledge(
        p_pledge in out nocopy t_core_pledge)
    is
        l_object_id integer;
    begin
        if (p_pledge.reported_object_id is not null) then
            raise_application_error(-20000, 'Застава з номером {' || p_pledge.numberpledge ||
                                            '} на дату {' || to_char(p_pledge.pledgeday, 'dd.mm.yyyy') ||
                                            '} та ідентифікатором {' || p_pledge.reported_object_id || '} вже створена');
        end if;

        check_pledge_uniqueness(p_pledge.customer_id, p_pledge.numberpledge, p_pledge.pledgeday);

        if (p_pledge.ordernum is null) then
             select nvl(max(t.order_number), 0) + 1
             into   p_pledge.ordernum
             from   nbu_reported_pledge t
             where  t.customer_object_id = p_pledge.customer_id and
                    t.pledge_number = p_pledge.numberpledge and
                    t.pledge_date = p_pledge.pledgeday;
        end if;

        l_object_id := create_object(nbu_object_utl.OBJ_TYPE_PLEDGE);

        insert into nbu_reported_pledge
        values (l_object_id,
                p_pledge.customer_id,
                p_pledge.ordernum,
                p_pledge.numberpledge,
                p_pledge.pledgeday,
                p_pledge.sumpledge,
                p_pledge.r030,
                p_pledge.core_object_kf,
                p_pledge.core_object_id,
                p_pledge.s031);

        p_pledge.reported_object_id := l_object_id;
    end;

    procedure create_loan(
        p_loan in out nocopy t_core_loan)
    is
        l_object_id integer;
    begin
        if (p_loan.reported_object_id is not null) then
            raise_application_error(-20000, 'Кредит з номером {' || p_loan.numberdog ||
                                            '} на дату {' || to_char(p_loan.dogday, 'dd.mm.yyyy') ||
                                            '} та ідентифікатором {' || p_loan.reported_object_id || '} вже створена');
        end if;

        check_loan_uniqueness(p_loan.customer_id, p_loan.numberdog, p_loan.dogday);

        l_object_id := create_object(nbu_object_utl.OBJ_TYPE_LOAN);

        insert into nbu_reported_loan
        values (l_object_id,
                p_loan.customer_id,
                p_loan.numberdog,
                p_loan.dogday,
                p_loan.sumzagal,
                p_loan.r030,
                p_loan.core_object_kf,
                p_loan.core_object_id);

        p_loan.reported_object_id := l_object_id;
    end;

    procedure alter_company(
        p_company in t_core_company)
    is
        l_object_row nbu_reported_object%rowtype;
    begin
        l_object_row := read_object(p_company.reported_object_id);

        update nbu_reported_customer t
        set    t.customer_name = p_company.nameur,
               t.core_customer_kf = p_company.core_object_kf,
               t.core_customer_id = p_company.core_object_id
        where  t.id = p_company.reported_object_id;

        if (l_object_row.state_id in (nbu_object_utl.OBJ_STATE_REPORTED, /*nbu_object_utl.OBJ_STATE_MODIFIED,*/ nbu_object_utl.OBJ_STATE_MODIFICATION_FAILURE)) then
            set_object_state(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        else
            track_object(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        end if;
    end;

    procedure alter_person(
        p_person in t_core_person)
    is
        l_object_row nbu_reported_object%rowtype;
    begin
        l_object_row := read_object(p_person.reported_object_id);

        update nbu_reported_customer t
        set    t.customer_name = p_person.lastname || ' ' || p_person.firstname || ' ' || p_person.middlename,
               t.core_customer_kf = p_person.core_object_kf,
               t.core_customer_id = p_person.core_object_id
        where  t.id = p_person.reported_object_id;

        if (l_object_row.state_id in (nbu_object_utl.OBJ_STATE_REPORTED, /*nbu_object_utl.OBJ_STATE_MODIFIED,*/ nbu_object_utl.OBJ_STATE_MODIFICATION_FAILURE)) then
            set_object_state(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        else
            track_object(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        end if;
    end;

    procedure alter_pledge(
        p_pledge in t_core_pledge)
    is
        l_object_row nbu_reported_object%rowtype;
    begin
        l_object_row := read_object(p_pledge.reported_object_id);

        update nbu_reported_pledge t
        set    t.customer_object_id = p_pledge.customer_id,
               t.pledge_amount = p_pledge.sumpledge,
               t.pledge_currency_id = p_pledge.r030,
               t.core_pledge_kf = p_pledge.core_object_kf,
               t.core_pledge_id = p_pledge.core_object_id
        where  t.id = p_pledge.reported_object_id;

        if (l_object_row.state_id in (nbu_object_utl.OBJ_STATE_REPORTED, /*nbu_object_utl.OBJ_STATE_MODIFIED,*/ nbu_object_utl.OBJ_STATE_MODIFICATION_FAILURE)) then
            set_object_state(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        else
            track_object(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        end if;
    end;

    procedure alter_loan(
        p_loan in t_core_loan)
    is
        l_object_row nbu_reported_object%rowtype;
    begin
        l_object_row := read_object(p_loan.reported_object_id);

        update nbu_reported_loan t
        set    t.customer_object_id = p_loan.customer_id,
               t.loan_amount = p_loan.sumzagal,
               t.loan_currency_id = p_loan.r030,
               t.core_loan_kf = p_loan.core_object_kf,
               t.core_loan_id = p_loan.core_object_id
        where  t.id = p_loan.reported_object_id;

        if (l_object_row.state_id in (nbu_object_utl.OBJ_STATE_REPORTED, /*nbu_object_utl.OBJ_STATE_MODIFIED,*/ nbu_object_utl.OBJ_STATE_MODIFICATION_FAILURE)) then
            set_object_state(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        else
            track_object(l_object_row.id, nbu_object_utl.OBJ_STATE_MODIFICATION_ARRANG, null);
        end if;
    end;

    procedure dismiss_object(
        p_object_id in integer,
        p_dismissal_comment in varchar2)
    is
        l_object_row nbu_reported_object%rowtype;
    begin
        if (l_object_row.state_id in (nbu_object_utl.OBJ_STATE_NEW, nbu_object_utl.OBJ_STATE_REPORTING_FAILURE)) then
            nbu_object_utl.set_object_state(p_object_id, nbu_object_utl.OBJ_STATE_DISMISSED, p_dismissal_comment);
        else
            -- nbu_object_utl.set_object_state(p_object_id, nbu_object_utl.OBJ_STATE_DISMISSAL_ARRANGED, p_dismissal_comment);
            -- оскільки на даний час не передбачається видалення даних в НБУ, просто відмічаємо у нас,
            -- що об'єкт "перестав існувати" в поточній версії нашої бази даних
            nbu_object_utl.set_object_state(p_object_id, nbu_object_utl.OBJ_STATE_DISMISSED, p_dismissal_comment);
        end if;

        nbu_object_utl.set_customer_core_id(p_object_id, null, null);
    end;

    procedure set_object_external_id(
        p_object_id in integer,
        p_external_object_id in varchar2)
    is
        l_object_row nbu_reported_object%rowtype;
    begin
        l_object_row := read_object(p_object_id, p_lock => true);

        if (l_object_row.external_id is null) then

            update nbu_reported_object t
            set    t.external_id = p_external_object_id
            where  t.id = p_object_id;

            set_object_state(p_object_id, nbu_object_utl.OBJ_STATE_REPORTED,
                             'Об''єкту встановлюється у відповідність код НБУ {' || p_external_object_id ||
                             '} - з цього часу об''єкт зареєстрований в НБУ');

        elsif (not bars.tools.equals(l_object_row.external_id, p_external_object_id)) then
            raise_application_error(-20000, 'Невідповідність кодів АБС та НБУ - спроба встановити код НБУ {' || p_external_object_id ||
                                            '} об''єкту з кодом {' || get_object_code(l_object_row) ||
                                            '}, в той час як для нього вже встановлено значення {' || l_object_row.external_id || '}');
        end if;
    end;

    function get_object_json(
        p_object_id in integer,
        p_report_id in integer default null)
    return clob
    is
        l_object_row nbu_reported_object%rowtype;
        l_customer_row nbu_reported_customer%rowtype;
        l_pledge_row nbu_reported_pledge%rowtype;
        l_loan_row nbu_reported_loan%rowtype;
        l_core_object t_core_object;
        l_json clob;
    begin
        l_object_row := read_object(p_object_id);

        if (l_object_row.object_type_id = nbu_object_utl.OBJ_TYPE_COMPANY) then
            l_customer_row := read_customer(p_object_id);
            if (l_customer_row.core_customer_id is not null) then
                l_core_object := t_core_company(p_report_id, l_customer_row.core_customer_id, l_customer_row.core_customer_kf);
            end if;
        elsif (l_object_row.object_type_id = nbu_object_utl.OBJ_TYPE_PERSON) then
            l_customer_row := read_customer(p_object_id);
            if (l_customer_row.core_customer_id is not null) then
                l_core_object := t_core_person(p_report_id, l_customer_row.core_customer_id, l_customer_row.core_customer_kf);
            end if;
        elsif (l_object_row.object_type_id = nbu_object_utl.OBJ_TYPE_PLEDGE) then
            l_pledge_row := read_pledge(p_object_id);
            dbms_output.put_line(l_pledge_row.core_pledge_id);
            if (l_pledge_row.core_pledge_id is not null) then
                l_core_object := t_core_pledge(p_report_id, l_pledge_row.core_pledge_id, l_pledge_row.core_pledge_kf);
            end if;
        elsif (l_object_row.object_type_id = nbu_object_utl.OBJ_TYPE_LOAN) then
            l_loan_row := read_loan(p_object_id);
            if (l_loan_row.core_loan_id is not null) then
                l_core_object := t_core_loan(p_report_id, l_loan_row.core_loan_id, l_loan_row.core_loan_kf);
            end if;
        end if;

        if (l_core_object is not null and l_core_object.core_object_id is not null) then
            l_json := l_core_object.get_json();
        end if;

        return l_json;
    end;
end;
/
