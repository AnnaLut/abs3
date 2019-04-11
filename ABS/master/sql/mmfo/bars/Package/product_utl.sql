
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/product_utl.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRODUCT_UTL is

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
    return deal_product%rowtype
    result_cache;

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
CREATE OR REPLACE PACKAGE BODY BARS.PRODUCT_UTL as

    function read_product(
        p_product_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal_product%rowtype
    result_cache
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
        insert into deal_product (id, deal_type_id, product_code)
        values (deal_product_seq.nextval, p_deal_type_id, p_product_code)
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
/*
    function getglobaloption(par_ varchar2)
    return varchar2
    result_cache relies_on(params$global, params$base)
    is
        val_ params.val%type;
    begin
        dbms_output.put_line('getglobaloption called');
        select val into val_ from params where upper(par)=upper(par_) ;

        return val_ ;
    exception
        when no_data_found then
             return '';
    end;
*/
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/product_utl.sql =========*** End ***
 PROMPT ===================================================================================== 
 