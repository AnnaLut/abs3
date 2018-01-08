
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_deal.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_DEAL is

    ET_RATE_KIND                   constant integer := 501;
    RATE_KIND_MAIN                 constant integer := 1;
    RATE_KIND_PENALTY              constant integer := 2;

    function read_deal(
        p_deal_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype;

    function read_deal(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype;
/*
    function find_deal(
        p_deal_number in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype;
*/
    function create_deal(
        p_deal_number in varchar2,
        p_lender_id in varchar2,
        p_borrower_id in varchar2,
        p_open_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_base_year in integer)
    return integer;

    procedure set_deal_interest_rate(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_date in date,
        p_interest_rate in number,
        p_operation_id in integer);

    function get_deal_interest_rate(
        p_deal_id in integer,
        p_rate_kind in integer)
    return number;

    function get_deal_interest_rates(
        p_deal_id in integer,
        p_rate_kind in integer)
    return t_date_number_pairs;

    function get_region_branch_code(
        p_deal_id in integer)
    return varchar2;
end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_DEAL as

    function read_deal(p_deal_id in integer, p_lock in boolean default false, p_raise_ndf in boolean default true)
    return deal%rowtype
    is
        l_deal_row deal%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_deal_row
            from   deal d
            where  d.id = p_deal_id
            for update;
        else
            select *
            into   l_deal_row
            from   deal d
            where  d.id = p_deal_id;
        end if;

        return l_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Угода з ідентифікатором {' || p_deal_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_deal(
        p_deal_number in varchar2,
        p_currency_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype
    is
        l_deal_row deal%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_deal_row
            from   deal d
            where  d.deal_number = p_deal_number and
                   d.currency_id = p_currency_id
            for update;
        else
            select *
            into   l_deal_row
            from   deal d
            where  d.deal_number = p_deal_number and
                   d.currency_id = p_currency_id;
        end if;

        return l_deal_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Угода з номером {' || p_deal_number || '} в валюті {' || p_currency_id || '} не знайдена');
             else return null;
             end if;
    end;
/*
    function find_deal(
        p_deal_number in varchar2,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype
    is
        l_deal_row deal%rowtype;
        l_deal_number varchar2(30 char);
        l_slash_position integer;
    begin
        l_deal_number := p_deal_number;
        loop
            l_deal_row := read_deal(l_deal_number, p_lock, p_raise_ndf => false);

            if (l_deal_row.id is not null) then
                exit;
            end if;

            l_slash_position := instr(l_deal_number, '/', -1);
            if (l_slash_position is null or l_slash_position = 0) then
                exit;
            end if;

            l_deal_number := substr(l_deal_number, 1, l_slash_position - 1);
        end loop;

        if (p_raise_ndf and l_deal_row.id is null) then
            raise_application_error(cdb_exception.NO_DATA_FOUND,
                                    'Угода з номером {' || p_deal_number || '} не знайдена');
        end if;

        return l_deal_row;
    end;
*/
    function create_deal(
        p_deal_number in varchar2,
        p_lender_id in varchar2,
        p_borrower_id in varchar2,
        p_open_date in date,
        p_expiry_date in date,
        p_amount in number,
        p_currency_id in integer,
        p_base_year in integer)
    return integer
    is
        l_deal_id integer;
    begin
        insert into deal
        values (deal_seq.nextval,
                p_deal_number,
                p_lender_id,
                p_borrower_id,
                p_open_date,
                p_expiry_date,
                null,
                p_amount,
                p_currency_id,
                p_base_year)
        returning id into l_deal_id;

        return l_deal_id;
    end;

    procedure save_interest_rate_history(
        p_interest_rate_id in integer,
        p_operation_id in integer,
        p_interest_rate in number)
    is
    begin
        insert into deal_interest_rate_history
        values (p_interest_rate_id, p_operation_id, p_interest_rate, sysdate);
    end;

    procedure delete_deal_interest_rate(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_date in date)
    is
    begin
        delete deal_interest_rate r
        where  r.deal_id = p_deal_id and
               r.rate_kind = p_interest_kind and
               r.start_date = p_interest_date;
    end;

    function read_interest_rate(
        p_deal_id in integer,
        p_rate_kind in integer,
        p_start_date in date,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_interest_rate%rowtype
    is
        l_interest_rate_row deal_interest_rate%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_interest_rate_row
            from   deal_interest_rate r
            where  r.deal_id = p_deal_id and
                   r.rate_kind = p_rate_kind and
                   r.start_date = p_start_date
            for update;
        else
            select *
            into   l_interest_rate_row
            from   deal_interest_rate r
            where  r.deal_id = p_deal_id and
                   r.rate_kind = p_rate_kind and
                   r.start_date = p_start_date;
        end if;

        return l_interest_rate_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND,
                                        'Відсоткова ставка виду {' || p_rate_kind ||
                                        '} по угоді {' || p_deal_id ||
                                        '} на дату {' || p_start_date ||
                                        '} не знайдена');
             else return null;
             end if;
    end;

    procedure set_deal_interest_rate(
        p_deal_id in integer,
        p_interest_kind in integer,
        p_interest_date in date,
        p_interest_rate in number,
        p_operation_id in integer)
    is
        l_interest_rate_row deal_interest_rate%rowtype;
    begin
        logger.log('cdb_dispatcher.set_deal_interest_rate', logger.LOG_LEVEL_INFO,
                   'Встановлення відсоткової ставки {' || p_interest_rate ||
                   '%} виду {' || p_interest_kind ||
                   '} по угоді {' || p_deal_id ||
                   '} на дату {' || p_interest_date || '}');

        l_interest_rate_row := read_interest_rate(p_deal_id, p_interest_kind, p_interest_date, true, false);

        if (l_interest_rate_row.id is not null) then
            update deal_interest_rate r
            set    r.interest_rate = p_interest_rate
            where  r.id = l_interest_rate_row.id;
        else
            insert into deal_interest_rate
            values (deal_interest_rate_seq.nextval, p_deal_id, p_interest_kind, p_interest_date, p_interest_rate)
            returning id
            into l_interest_rate_row.id;
        end if;

        save_interest_rate_history(l_interest_rate_row.id, p_operation_id, p_interest_rate);

        for i in (select r.start_date, r.interest_rate
                  from   deal_interest_rate r
                  where  r.deal_id = p_deal_id and
                         r.rate_kind = p_interest_kind and
                         r.start_date > p_interest_date and
                         r.interest_rate is not null
                  for update) loop

            logger.log('cdb_dispatcher.set_deal_interest_rate', logger.LOG_LEVEL_INFO,
                       'Видалення відсоткової ставки {' || i.interest_rate ||
                       '%} виду {' || p_interest_kind ||
                       '} по угоді {' || p_deal_id ||
                       '} на дату {' || i.start_date || '}');

            set_deal_interest_rate(p_deal_id, p_interest_kind, i.start_date, null, p_operation_id);
        end loop;
    end;

    function get_deal_interest_rate(
        p_deal_id in integer,
        p_rate_kind in integer)
    return number
    is
        l_interest_rate number;
    begin
        select min(dir.interest_rate) keep (dense_rank last order by dir.start_date)
        into   l_interest_rate
        from   deal_interest_rate dir
        where  dir.deal_id = p_deal_id and
               dir.rate_kind = p_rate_kind;

        return l_interest_rate;
    end;

    function get_deal_interest_rates(
        p_deal_id in integer,
        p_rate_kind in integer)
    return t_date_number_pairs
    is
        l_interest_rates t_date_number_pairs;
    begin
        select t_date_number_pair(dir.start_date, dir.interest_rate)
        bulk collect into l_interest_rates
        from   deal_interest_rate dir
        where  dir.deal_id = p_deal_id and
               dir.rate_kind = p_rate_kind and
               dir.interest_rate is not null
        order by dir.start_date;

        return l_interest_rates;
    end;

    function get_region_branch_code(
        p_deal_id in integer)
    return varchar2
    is
        l_region_branch_code varchar2(30 char);
    begin
        select min(b.branch_code)
        into   l_region_branch_code
        from   deal d
        join   branch b on b.id = d.lender_id or b.id = d.borrower_id
        where  d.id = p_deal_id and
               b.branch_code <> cdb_branch.BRANCH_CODE_CENTRAL_APPARAT;

        return l_region_branch_code;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_deal.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 