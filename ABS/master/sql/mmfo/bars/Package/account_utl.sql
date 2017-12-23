create or replace package account_utl is

    type t_saldo_lines is table of saldoa%rowtype;

    function read_account(
        p_account_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return accounts%rowtype;

    function read_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'),
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return accounts%rowtype;

    function get_account_id(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'))
    return integer;

    function get_account_number(
        p_account_id in integer)
    return varchar2;

    function get_account_currency_id(
        p_account_id in integer)
    return number;

    function get_account_mfo(
        p_account_id in integer)
    return varchar2;

    function get_account_name(
        p_account_id in integer)
    return varchar2;

    function get_account_rest(
        p_account_id in integer)
    return number;

    function get_account_planned_rest(
        p_account_id in integer)
    return number;

    function get_account_rest(
        p_account_number in varchar2,
        p_currency_id in integer)
    return number;

    function get_account_planned_rest(
        p_account_number in varchar2,
        p_currency_id in integer)
    return number;

    -- внутрішня процедура встановлення дати закриття (допускається значення null)
    -- без додаткових перевірок змінює дату закриття рахунку
    -- не повинна бути доступною користувачам через інтерфейс
    procedure set_close_date(
        p_account_row in accounts%rowtype,
        p_close_date in date);

    procedure set_close_date(
        p_account_id in integer,
        p_close_date in date);

    procedure set_close_date(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_close_date in date);

    function can_close_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_current_account_rest in number,
        p_planned_account_rest in number,
        p_future_account_rest in number,
        p_last_turnover_date in date)
    return varchar2;

    function can_close_account(
        p_account_row in accounts%rowtype)
    return varchar2;

    procedure close_account(
        p_account_row in accounts%rowtype,
        p_close_date in date,
        p_suppress_closed_account_warn in boolean default false);

    procedure close_account(
        p_account_id in integer,
        p_close_date in date,
        p_suppress_closed_account_warn in boolean default false);

    procedure close_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_close_date in date,
        p_suppress_closed_account_warn in boolean default false,
        p_mfo in varchar2 default sys_context('bars_cntext', 'user_mfo'));

    procedure reopen_account(
        p_account_row in accounts%rowtype);

    procedure reopen_account(
        p_account_id in integer);

    procedure reopen_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'));

    function pipe_saldo_line(
        p_account_id in integer,
        p_date in date default null)
    return t_saldo_lines
    pipelined;
  
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
create or replace package body account_utl as

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
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'),
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
                    a.dat_alt is not null ) and
                   a.kv = p_currency_id and
                   a.kf = p_mfo
            for update;
        else
            select *
            into   l_accounts_row
            from   accounts a
            where  (a.nls = p_account_number or
                    a.nlsalt = p_account_number and
                    a.dat_alt is not null )  and
                   a.kv = p_currency_id and
                   a.kf = p_mfo;
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

    function get_account_id(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'))
    return integer
    is
    begin
        return read_account(p_account_number, p_currency_id, p_mfo, p_raise_ndf => false).acc;
    end;

    function get_account_number(
        p_account_id in integer)
    return varchar2
    is
    begin
        return read_account(p_account_id, p_raise_ndf => false).nls;
    end;

    function get_account_currency_id(
        p_account_id in integer)
    return number
    is
    begin
        return read_account(p_account_id, p_raise_ndf => false).kv;
    end;

    function get_account_mfo(
        p_account_id in integer)
    return varchar2
    is
    begin
        return read_account(p_account_id, p_raise_ndf => false).kf;
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

    function get_account_planned_rest(
        p_account_id in integer)
    return number
    is
    begin
        return read_account(p_account_id, p_raise_ndf => false).ostb;
    end;

    function get_account_rest(
        p_account_number in varchar2,
        p_currency_id in integer)
    return number
    is
    begin
        return read_account(p_account_number, p_currency_id, p_raise_ndf => false).ostc;
    end;

    function get_account_planned_rest(
        p_account_number in varchar2,
        p_currency_id in integer)
    return number
    is
    begin
        return read_account(p_account_number, p_currency_id, p_raise_ndf => false).ostb;
    end;

    function can_close_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_current_account_rest in number,
        p_planned_account_rest in number,
        p_future_account_rest in number,
        p_last_turnover_date in date)
    return varchar2
    is
    begin
        if (p_current_account_rest <> 0) then
            return 'Поточний залишок рахунку ' || p_account_number || '(' || p_currency_id || ') перед закриттям має бути нульовим';
        end if;

        if (p_planned_account_rest <> 0) then
            return 'Плановий залишок рахунку ' || p_account_number || '(' || p_currency_id || ') перед закриттям має бути нульовим';
        end if;

        if (p_future_account_rest <> 0) then
            return 'Майбутній залишок рахунку ' || p_account_number || '(' || p_currency_id || ') перед закриттям має бути нульовим';
        end if;

        if (p_last_turnover_date >= bankdate()) then
            return 'Дата останнього руху коштів по рахунку ' || p_account_number || '(' || p_currency_id || ') - ' || to_char(p_last_turnover_date, 'dd.mm.yyyy') ||
                   ' повинна бути меньшою за поточну банківську дату: ' || to_char(bankdate(), 'dd.mm.yyyy');
        end if;

        return null;
    end;

    function can_close_account(
        p_account_row in accounts%rowtype)
    return varchar2
    is
    begin
        return can_close_account(p_account_row.nls,
                                 p_account_row.kv,
                                 p_account_row.ostc,
                                 p_account_row.ostb,
                                 p_account_row.ostf,
                                 p_account_row.dapp);
    end;

    procedure set_close_date(
        p_account_row in accounts%rowtype,
        p_close_date in date)
    is
    begin
        update accounts a
        set    a.dazs = p_close_date
        where  a.acc = p_account_row.acc;
    end;

    procedure set_close_date(
        p_account_id in integer,
        p_close_date in date)
    is
    begin
        set_close_date(read_account(p_account_id, p_lock => true), p_close_date);
    end;

    procedure set_close_date(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_close_date in date)
    is
    begin
        set_close_date(read_account(p_account_number, p_currency_id, p_lock => true), p_close_date);
    end;

    procedure close_account(
        p_account_row in accounts%rowtype,
        p_close_date in date,
        p_suppress_closed_account_warn in boolean default false) -- не повідомляти про те, що рахунок вже закритий
    is
        l_explanation varchar2(32767 byte);
    begin
        if (p_close_date is null) then
            raise_application_error(-20000, 'Дата закриття рахунку не вказана');
        end if;

        if (p_close_date < bankdate()) then
            raise_application_error(-20000, 'Дата закриття рахунку {' || to_char(p_close_date, 'dd.mm.yyyy') ||
                                            '} не може бути меньшою за поточну банківську дату {' || to_char(bankdate(), 'dd.mm.yyyy') || '}');
        end if;

        if (p_account_row.dazs is not null) then
            if (p_suppress_closed_account_warn) then
                -- виходимо і не продовжуємо виконання процедури - дата закриття рахунку в цьому випадку не змінюється
                -- для тих випадків, коли необхідно тільки встановити дату закриття без виконання перевірок, або змінити
                -- дату для вже закритого рахунку, необхідно використовувати внутрішню процедуру set_close_date
                return;
            else
                raise_application_error(-20000, 'Рахунок ' || p_account_row.nls || ' (' || p_account_row.kv ||
                                                ') закритий - дата закриття: ' || to_char(p_close_date, 'dd.mm.yyyy'));
            end if;
        end if;

        l_explanation := can_close_account(p_account_row);

        if (l_explanation is not null) then
            raise_application_error(-20000, l_explanation);
        end if;

        set_close_date(p_account_row, p_close_date);
    end;

    procedure close_account(
        p_account_id in integer,
        p_close_date in date,
        p_suppress_closed_account_warn in boolean default false)
    is
    begin
        close_account(read_account(p_account_id, p_lock => true), p_close_date, p_suppress_closed_account_warn);
    end;

    procedure close_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_close_date in date,
        p_suppress_closed_account_warn in boolean default false,
        p_mfo in varchar2 default sys_context('bars_cntext', 'user_mfo'))
    is
    begin
        close_account(read_account(p_account_number, p_currency_id, p_mfo => p_mfo, p_lock => true), p_close_date, p_suppress_closed_account_warn);
    end;

    procedure reopen_account(
        p_account_row in accounts%rowtype)
    is
    begin
        -- todo : перевірка прав виконавця на перевідкриття рахунку
        -- todo : формування повідомлення до ДПА про відкриття клієнтського рахунку і т.п.
        set_close_date(p_account_row, null);
    end;

    procedure reopen_account(
        p_account_id in integer)
    is
    begin
        reopen_account(read_account(p_account_id, p_lock => true));
    end;

    procedure reopen_account(
        p_account_number in varchar2,
        p_currency_id in integer,
        p_mfo in varchar2 default sys_context('bars_context', 'user_mfo'))
    is
    begin
        reopen_account(read_account(p_account_number, p_currency_id, p_mfo => p_mfo, p_lock => true));
    end;

    function pipe_saldo_line(
        p_account_id in integer,
        p_date in date default null)
    return t_saldo_lines
    pipelined
    is
    begin
        for i in (select s.*
                  from   saldoa s
                  where  s.acc = p_account_id and
                         s.fdat <= p_date
                  order by s.fdat desc) loop
            pipe row(i);
            exit;
        end loop;
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
 
