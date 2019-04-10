create or replace package product_utl is

    LT_PRODUCT_STATE               constant varchar2(30 char) := 'PRODUCT_STATE';
    PROD_STATE_UNDER_CONSTRUCTION  constant integer := 1;
    PROD_STATE_ACTIVE              constant integer := 2;
    PROD_STATE_BLOCKED             constant integer := 3;
    PROD_STATE_CLOSED              constant integer := 100;

    ATTR_CODE_NAME                 constant varchar2(30 char) := 'PROD_NAME';
    ATTR_CODE_SEGMENT_OF_BUSINESS  constant varchar2(30 char) := 'PROD_SEGMENT_OF_BUSINESS';
    ATTR_CODE_VALID_FROM           constant varchar2(30 char) := 'PROD_VALID_FROM';
    ATTR_CODE_VALID_THROUGH        constant varchar2(30 char) := 'PROD_VALID_THROUGH';
    ATTR_CODE_STATE                constant varchar2(30 char) := 'PROD_STATE';
    ATTR_CODE_PARENT_PRODUCT       constant varchar2(30 char) := 'PROD_PARENT_PRODUCT';

    function read_product(
        p_product_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_product%rowtype;

    function read_product(
        p_product_type_id in number,
        p_product_code    in varchar2,
        p_lock            in boolean default false,
        p_raise_ndf       in boolean default true)
    return deal_product%rowtype;

    function get_product_id(
        p_product_type_code in varchar2,
        p_product_code in varchar2)
    return integer;

    function create_product(
        p_deal_type_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null)
    return integer;
end;
/
create or replace package body product_utl as

    function read_product(
        p_product_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_product%rowtype
    is
        l_product_row deal_product%rowtype;
    begin
        if (p_lock) then
            select *
            into   l_product_row
            from   deal_product t
            where  t.id = p_product_id
            for update wait 60;
        else
            select *
            into   l_product_row
            from   deal_product t
            where  t.id = p_product_id;
        end if;

        return l_product_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, 'Продукт з ідентифікатором {' || p_product_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_product(
        p_product_type_id in number,
        p_product_code    in varchar2,
        p_lock            in boolean default false,
        p_raise_ndf       in boolean default true)
    return deal_product%rowtype
    is
        l_product_row deal_product%rowtype;
    begin
        if (p_lock) then
            select *
              into l_product_row
              from deal_product t
             where t.deal_type_id = p_product_type_id
               and t.product_code = p_product_code
            for update wait 60;
        else
            select *
              into l_product_row
              from deal_product t
             where t.deal_type_id = p_product_type_id
               and t.product_code = p_product_code;
        end if;

        return l_product_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, q'[Продукт з типом об'єкту {]' || p_product_type_id ||
                                                  '} та кодом продукту {'||p_product_code||'} не знайдений');
             else return null;
             end if;
    end;

    function get_product_id(
        p_product_type_code in varchar2,
        p_product_code in varchar2)
    return integer
    is
        l_product_id integer;
    begin
        select min(p.id) keep (dense_rank first order by o.object_level)
        into   l_product_id
        from   deal_product p
        join   (select t.id, level object_level
                from   object_type t
                connect by t.id = prior t.parent_type_id
                start with t.type_code = p_product_type_code) o on p.deal_type_id = o.id
        where  p.product_code = p_product_code;

        return l_product_id;
    end;

    function create_product(
        p_deal_type_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null)
    return integer
    is
        l_product_id integer;
    begin
        insert into deal_product (id, deal_type_id, product_code, is_active)
        values (deal_product_seq.nextval, p_deal_type_id, p_product_code, 'Y')
        returning id
        into l_product_id;

        attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_NAME, p_product_name);
        attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_SEGMENT_OF_BUSINESS, p_segment_of_business_id);

        if (p_valid_from is not null) then
            attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_VALID_FROM, p_valid_from);
        end if;

        if (p_valid_through is not null) then
            attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_VALID_THROUGH, p_valid_through);
        end if;

        if (p_parent_product_id is not null) then
            attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_PARENT_PRODUCT, p_parent_product_id);
        end if;

        return l_product_id;
    end;

    procedure set_product_balance_accounts(
        p_product_id in integer,
        p_account_type_id in integer,
        p_balance_account in varchar2,
        p_ob22_code in varchar2)
    is
    begin
        null;
    end;
end;
/
 show err;
