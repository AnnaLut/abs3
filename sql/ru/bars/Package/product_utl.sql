
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/product_utl.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRODUCT_UTL is

  -- Author  : ARTEM YURCHENKO,  VITALII KHOMIDA
  -- Created : 11.03.2016 17:11:09
  -- Purpose : Головний інструментальний пакет для роботи з Продуктами.
    LT_PRODUCT_STATE               constant varchar2(30 char) := 'PRODUCT_STATE';
    PROD_STATE_UNDER_CONSTRUCTION  constant integer := 1;
    PROD_STATE_ACTIVE              constant integer := 2;
    PROD_STATE_BLOCKED             constant integer := 3;
    PROD_STATE_CLOSED              constant integer := 100;

    -- Static attributes for deal_product
    ATTR_CODE_NAME                 constant varchar2(30 char) := 'PROD_NAME';
    ATTR_CODE_PROD_CODE            constant varchar2(30 char) := 'PROD_CODE';
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

    procedure edit_product(
        p_product_row in deal_product%rowtype,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null);

    procedure create_deal_product_account(
        p_product_id in integer,
        p_deal_account_type_id in integer,
        p_gl_account_type_code in varchar2,
        p_balance_account in varchar2 ,
        p_ob22_code in varchar2,
        p_currency_id in integer,
        p_is_permanent in varchar2 default null,
        p_is_auto_open in varchar2 default null,
        p_account_number_func varchar2 default null);

    procedure create_deal_product_accounts(
        p_productid in integer,
        p_deal_product_account_list in t_deal_product_account_list);

    function get_deal_product_account(
        p_product_id in integer,
        p_deal_account_type_id in integer)
    return deal_product_account%rowtype;

    procedure edit_deal_product_account(
        p_product_id in integer,
        p_deal_account_type_id in integer,
        p_gl_account_type_code in varchar2,
        p_balance_account in varchar2 ,
        p_ob22_code in varchar2,
        p_currency_id in integer,
        p_is_permanent in varchar2,
        p_is_auto_open in varchar2,
        p_account_number_func varchar2);

    procedure activate_product(p_product_row in deal_product%rowtype);

    procedure block_product(p_product_row in deal_product%rowtype);

    procedure close_product(p_product_row in deal_product%rowtype);



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
        l_h varchar2(50) := 'product_utl.create_product. ';
    begin
        bars_audit.trace(l_h || 'p_deal_type_id=>' || p_deal_type_id||' p_product_code=>' || p_product_code||
                         ' p_product_name=>' || p_product_name||' p_segment_of_business_id=>' || p_segment_of_business_id||
                         ' p_valid_from=>' || p_valid_from||' p_valid_through=>' || p_valid_through||
                         ' p_parent_product_id=>' || p_parent_product_id);
        insert into deal_product (id, deal_type_id, product_code)
        values (deal_product_seq.nextval, p_deal_type_id, p_product_code)
        returning id
        into l_product_id;

        attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_PROD_CODE, p_product_code);
        attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_NAME, p_product_name);
        attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_SEGMENT_OF_BUSINESS, p_segment_of_business_id);
        attribute_utl.set_value(l_product_id, product_utl.ATTR_CODE_STATE, product_utl.prod_state_under_construction);
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

    procedure edit_product(
        p_product_row in deal_product%rowtype,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null)
    is
        l_h varchar2(50) := 'product_utl.edit_product. ';
    begin
        bars_audit.trace(l_h || 'p_product_id=>' || p_product_row.id||' p_product_code=>' || p_product_code||
                         ' p_product_name=>' || p_product_name||' p_segment_of_business_id=>' || p_segment_of_business_id||
                         ' p_valid_from=>' || p_valid_from||' p_valid_through=>' || p_valid_through||
                         ' p_parent_product_id=>' || p_parent_product_id);

        if (not tools.equals(p_product_row.product_code, p_product_code)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_PROD_CODE, p_product_code);
        end if;

        if (not tools.equals(p_product_row.product_name, p_product_name)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_NAME, p_product_name);
        end if;

        if (not tools.equals(p_product_row.segment_of_business_id, p_segment_of_business_id)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_SEGMENT_OF_BUSINESS, p_segment_of_business_id);
        end if;

        if (not tools.equals(p_product_row.valid_from, p_valid_from)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_VALID_FROM, p_valid_from);
        end if;

        if (not tools.equals(p_product_row.valid_through, p_valid_through)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_VALID_THROUGH, p_valid_through);
        end if;

        if (not tools.equals(p_product_row.parent_product_id, p_parent_product_id)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_PARENT_PRODUCT, p_parent_product_id);
        end if;

    end;

    procedure create_deal_product_account(
        p_product_id in integer,
        p_deal_account_type_id in integer,
        p_gl_account_type_code in varchar2,
        p_balance_account in varchar2 ,
        p_ob22_code in varchar2,
        p_currency_id in integer,
        p_is_permanent in varchar2 default null,
        p_is_auto_open in varchar2 default null,
        p_account_number_func varchar2 default null)
    is
        l_h varchar2(50) := 'product_utl.create_deal_product_account. ';
    begin
        bars_audit.trace(l_h || 'p_product_id=>' || p_product_id||' p_deal_account_type_id=>' || p_deal_account_type_id||
                         ' p_gl_account_type_code=>' || p_gl_account_type_code||' p_balance_account=>' || p_balance_account||
                         ' p_ob22_code=>' || p_ob22_code||' p_currency_id=>' || p_currency_id||
                         ' p_is_permanent=>' || p_is_permanent||' p_is_auto_open=>' || p_is_auto_open||
                         ' p_account_number_func=>' || p_account_number_func);

        insert into deal_product_account
          (product_id, deal_account_type_id, gl_account_type_code, balance_account,
           ob22_code, currency_id, is_permanent, is_auto_open, account_number_func)
        values
          (p_product_id, p_deal_account_type_id, p_gl_account_type_code,
           p_balance_account, p_ob22_code, p_currency_id, nvl(p_is_permanent,'N'),
           nvl(p_is_auto_open, 'N'), p_account_number_func);

    exception
        when dup_val_on_index then
          raise_application_error(-20000, 'Рахунок типу {'||p_deal_account_type_id||'} повинен бути один по продукту{'||p_product_id||'}');
    end;

    procedure create_deal_product_accounts(
        p_productid in integer,
        p_deal_product_account_list in t_deal_product_account_list)
    is
    begin
        delete deal_product_account t
        where t.product_id = p_productid;

        for c_dpa in p_deal_product_account_list.first .. p_deal_product_account_list.last
        loop
          create_deal_product_account(p_product_id => p_deal_product_account_list(c_dpa).product_id,
                                      p_deal_account_type_id => p_deal_product_account_list(c_dpa).deal_account_type_id,
                                      p_gl_account_type_code => p_deal_product_account_list(c_dpa).gl_account_type_code,
                                      p_balance_account => p_deal_product_account_list(c_dpa).balance_account,
                                      p_ob22_code => p_deal_product_account_list(c_dpa).ob22_code,
                                      p_currency_id => p_deal_product_account_list(c_dpa).currency_id,
                                      p_is_permanent => p_deal_product_account_list(c_dpa).is_permanent,
                                      p_is_auto_open => p_deal_product_account_list(c_dpa).is_auto_open,
                                      p_account_number_func => p_deal_product_account_list(c_dpa).account_number_func);
        end loop;
    end;

    function get_deal_product_account(
        p_product_id in integer,
        p_deal_account_type_id in integer)
    return deal_product_account%rowtype
    is
        l_product_acc_row deal_product_account%rowtype;
    begin

        select *
        into l_product_acc_row
        from deal_product_account t
        where t.product_id = p_product_id and t.deal_account_type_id = p_deal_account_type_id;

        return l_product_acc_row;

    exception
        when no_data_found then
             return null;
    end;

    procedure edit_deal_product_account(
        p_product_id in integer,
        p_deal_account_type_id in integer,
        p_gl_account_type_code in varchar2,
        p_balance_account in varchar2 ,
        p_ob22_code in varchar2,
        p_currency_id in integer,
        p_is_permanent in varchar2,
        p_is_auto_open in varchar2,
        p_account_number_func varchar2)
    is
        l_h varchar2(50) := 'product_utl.edit_deal_product_account. ';
    begin

        bars_audit.info(l_h || 'p_product_id=>' || p_product_id||' p_deal_account_type_id=>' || p_deal_account_type_id||
                        ' p_gl_account_type_code=>' || p_gl_account_type_code||' p_balance_account=>' || p_balance_account||
                        ' p_ob22_code=>' || p_ob22_code||' p_currency_id=>' || p_currency_id||
                        ' p_is_permanent=>' || p_is_permanent||' p_is_auto_open=>' || p_is_auto_open||
                        ' p_account_number_func=>' || p_account_number_func);

       update deal_product_account t
          set t.gl_account_type_code = p_gl_account_type_code,
              t.balance_account = p_balance_account,
              t.ob22_code = p_ob22_code,
              t.currency_id = p_currency_id,
              t.is_permanent = p_is_permanent,
              t.is_auto_open = p_is_auto_open,
              t.account_number_func = p_account_number_func
        where t.product_id = p_product_id and
              t.deal_account_type_id = p_deal_account_type_id;
    end;

    procedure activate_product(p_product_row in deal_product%rowtype)
    is
        l_h varchar2(50) := 'product_utl.activate_product. ';
    begin
        bars_audit.trace(l_h || 'p_product_id=>' || p_product_row.id);
        if (not tools.equals(p_product_row.state_id, product_utl.PROD_STATE_ACTIVE)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_STATE, product_utl.PROD_STATE_ACTIVE);
        end if;
    end;

    procedure block_product(p_product_row in deal_product%rowtype)
    is
        l_h varchar2(50) := 'product_utl.block_product. ';
    begin
        bars_audit.trace(l_h || 'p_product_id=>' || p_product_row.id);
        if (not tools.equals(p_product_row.state_id, product_utl.PROD_STATE_BLOCKED)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_STATE, product_utl.PROD_STATE_BLOCKED);
        end if;
    end;

    procedure close_product(p_product_row in deal_product%rowtype)
    is
        l_h varchar2(50) := 'product_utl.close_product. ';
    begin
        bars_audit.trace(l_h || 'p_product_id=>' || p_product_row.id);
        if (not tools.equals(p_product_row.state_id, product_utl.PROD_STATE_CLOSED)) then
            attribute_utl.set_value(p_product_row.id, product_utl.ATTR_CODE_STATE, product_utl.PROD_STATE_CLOSED);
        end if;
    end;

end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/product_utl.sql =========*** End ***
 PROMPT ===================================================================================== 
 