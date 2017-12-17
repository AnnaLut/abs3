
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/account_utl.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.ACCOUNT_UTL is
    function read_account(
        p_account_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return accounts%rowtype;

    function read_account(
        p_account_number in varchar2,
        p_currency in integer,
        p_branch in integer default sys_context('bars_context', 'user_mfo'),
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return accounts%rowtype;

    function get_account_number(
        p_account_id in integer)
    return varchar2;

    function get_account_name(
        p_account_id in integer)
    return varchar2;

    function get_account_rest(
        p_account_id in integer)
    return number;

    procedure check_account_before_close(
        p_account_row in accounts%rowtype);

    procedure set_account_close_date(
        p_account_id in integer,
        p_close_date in date);

    procedure set_specparam_int(
        p_account_id in integer,
        p_attribute_name in varchar2,
        p_value in varchar2);

    procedure set_specparam_int(
        p_account_id in integer,
        p_attribute_name in varchar2,
        p_value in date);

    procedure set_specparam_int(
        p_account_id in integer,
        p_attribute_name in varchar2,
        p_value in number);

    function lock_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'),
        p_lock_mode in integer default 0,
        p_raise_ndf in boolean default true)
    return accounts%rowtype;
    
    function lock_account(
        p_account_id in integer,
        p_lock_mode in integer default 0,
        p_raise_ndf in boolean default true)
    return accounts%rowtype;    
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.ACCOUNT_UTL as

    function read_account(
        p_account_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return accounts%rowtype
    is
        l_accounts_row accounts%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_accounts_row
            from   accounts a
            where  a.acc = p_account_id
            for update;
        else
            select *
            into   l_accounts_row
            from   accounts a
            where  a.acc = p_account_id;
        end if;

        return l_accounts_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Рахунок з ідентифікатором {' || p_account_id || '} не знайдено');
             else return null;
             end if;
    end;

    function read_account(
        p_account_number in varchar2,
        p_currency in integer,
        p_branch in integer default sys_context('bars_context', 'user_mfo'),
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return accounts%rowtype
    is
        l_accounts_row accounts%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_accounts_row
            from   accounts a
            where  (a.nls = p_account_number or
                    a.nlsalt = p_account_number and 
                    a.dat_alt is not null) and
                   a.kv = p_currency and
                   a.kf = p_branch
            for update;
        else
            select *
            into   l_accounts_row
            from   accounts a
            where  (a.nls = p_account_number or
                    a.nlsalt = p_account_number and
                    a.dat_alt is not null ) and
                   a.kv = p_currency and
                   a.kf = p_branch;
        end if;

        return l_accounts_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Рахунок з номером {' || p_account_number ||
                                        '} та кодом валюти {' || p_currency ||
                                        '} в філіалі {' || p_branch || '} не знайдений');
             else return null;
             end if;
    end;

    function get_account_number(
        p_account_id in integer)
    return varchar2
    is
    begin
        return read_account(p_account_id, p_raise_ndf => false).nls;
    end;

    function get_account_name(
        p_account_id in integer)
    return varchar2
    is
    begin
        return read_account(p_account_id, p_raise_ndf => false).nms;
    end;

    function get_account_rest(
        p_account_id in integer)
    return number
    is
    begin
        return read_account(p_account_id, p_raise_ndf => false).ostc;
    end;

    procedure check_account_before_close(
        p_account_row in accounts%rowtype)
    is
    begin
        if (p_account_row.ostc <> 0) then
            raise_application_error(-20000, 'Поточний залишок рахунку {' || p_account_row.nls || '} перед закриттям має бути нульовим');
        end if;
        if (p_account_row.ostb <> 0) then
            raise_application_error(-20000, 'Плановий залишок рахунку {' || p_account_row.nls || '} перед закриттям має бути нульовим');
        end if;
        if (p_account_row.ostf <> 0) then
            raise_application_error(-20000, 'Майбутній залишок рахунку {' || p_account_row.nls || '} перед закриттям має бути нульовим');
        end if;
    end;

    procedure set_account_close_date(p_account_id in integer, p_close_date in date)
    is
        l_account_row accounts%rowtype;
    begin
        if (p_close_date is not null) then
            l_account_row := read_account(p_account_id, p_lock => true);
            check_account_before_close(l_account_row);
        end if;

        update accounts a
        set    a.dazs = p_close_date
        where  a.acc = p_account_id;
    end;

    procedure set_specparam_int(
        p_account_id in integer,
        p_attribute_name in varchar2,
        p_value in varchar2)
    is
    begin
        execute immediate 'update specparam_int p set p.' || p_attribute_name || ' = :p_value where p.acc = :p_account_id'
        using p_value, p_account_id;
        if (sql%rowcount = 0) then
            execute immediate 'insert into specparam_int (acc, ' || p_attribute_name || ') ' ||
                              'values(:p_account_id, :p_value)'
            using p_account_id, p_value;
        end if;
    end;

    procedure set_specparam_int(
        p_account_id in integer,
        p_attribute_name in varchar2,
        p_value in date)
    is
    begin
        execute immediate 'update specparam_int p set p.' || p_attribute_name || ' = :p_value where p.acc = :p_account_id'
        using p_value, p_account_id;
        if (sql%rowcount = 0) then
            execute immediate 'insert into specparam_int (acc, ' || p_attribute_name || ') ' ||
                              'values(:p_account_id, :p_value)'
            using p_account_id, p_value;
        end if;
    end;

    procedure set_specparam_int(
        p_account_id in integer,
        p_attribute_name in varchar2,
        p_value in number)
    is
    begin
        execute immediate 'update specparam_int p set p.' || p_attribute_name || ' = :p_value where p.acc = :p_account_id'
        using p_value, p_account_id;
        if (sql%rowcount = 0) then
            execute immediate 'insert into specparam_int (acc, ' || p_attribute_name || ') ' ||
                              'values(:p_account_id, :p_value)'
            using p_account_id, p_value;
        end if;
    end;

    function lock_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'),
        p_lock_mode in integer default 0,
        p_raise_ndf in boolean default true)
    return accounts%rowtype
    /* p_lock_mode 0 - wait
                   1 - no wait
                   2 - skip locked
    */             
    is
        l_accounts_row accounts%rowtype;
        ora_lock exception;
        pragma exception_init(ora_lock, -54);        
    begin
        if  p_lock_mode = 0 then
            select *
            into   l_accounts_row
            from   accounts a
            where  a.nls = p_account_number and
                   a.kv = p_currency_id and
                   a.kf = p_mfo
            for update;
        elsif p_lock_mode = 1 then
            select *
            into   l_accounts_row
            from   accounts a
            where  a.nls = p_account_number and
                   a.kv = p_currency_id and
                   a.kf = p_mfo
            for update nowait;           
        elsif p_lock_mode = 2 then
            select *
            into   l_accounts_row
            from   accounts a
            where  a.nls = p_account_number and
                   a.kv = p_currency_id and
                   a.kf = p_mfo
            for update skip locked;           

        end if;

        return l_accounts_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Рахунок з номером {' || p_account_number ||
                                        '} та кодом валюти {' || p_currency_id ||
                                        '} в філіалі {' || p_mfo || '} не знайдений');
             else return null;
             end if;
    end;

    function lock_account(
        p_account_id in integer,
        p_lock_mode in integer default 0,
        p_raise_ndf in boolean default true)
    return accounts%rowtype
    is
        l_accounts_row accounts%rowtype;
    begin

        if  p_lock_mode = 0 then
            select *
            into   l_accounts_row
            from   accounts a
            where  a.acc = p_account_id
            for update;
        elsif p_lock_mode = 1 then
            select *
            into   l_accounts_row
            from   accounts a
            where  a.acc = p_account_id
            for update nowait;           
        elsif p_lock_mode = 2 then
            select *
            into   l_accounts_row
            from   accounts a
            where  a.acc = p_account_id
            for update skip locked;           
        end if;

        return l_accounts_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000,
                                        'Рахунок з ідентифікатором {' || p_account_id || '} не знайдено');
             else return null;
             end if;
    end;   
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/account_utl.sql =========*** End ***
 PROMPT ===================================================================================== 
 
