
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/product_ui.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.PRODUCT_UI is

  -- Author  : VITALII.KHOMIDA
  -- Created : 11.03.2016 17:11:09
  -- Purpose : Пакет інтерфейсних процедур і функцій для WEB

    function create_product(
        p_deal_type_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null,
        p_deal_product_account_list in t_deal_product_account_list
        )
    return integer;

    procedure edit_product(
        p_product_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null,
        p_deal_product_account_list in t_deal_product_account_list);

    procedure activate_product(p_product_id in integer);

    procedure block_product(p_product_id in integer);

    procedure close_product(p_product_id in integer);


end product_ui;
/
CREATE OR REPLACE PACKAGE BODY BARS.PRODUCT_UI is

    function create_product(
        p_deal_type_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null,
        p_deal_product_account_list in t_deal_product_account_list
        )
    return integer
    is
        l_product_id integer;
    begin
        l_product_id := product_utl.create_product(p_deal_type_id,
                                                   p_product_code,
                                                   p_product_name,
                                                   p_segment_of_business_id,
                                                   p_valid_from,
                                                   p_valid_through,
                                                   p_parent_product_id);

        product_utl.create_deal_product_accounts(l_product_id, p_deal_product_account_list);

        return l_product_id;
    end;

    procedure edit_product(
        p_product_id in integer,
        p_product_code in varchar2,
        p_product_name in varchar2,
        p_segment_of_business_id in integer,
        p_valid_from in date default null,
        p_valid_through in date default null,
        p_parent_product_id in integer default null,
        p_deal_product_account_list in t_deal_product_account_list)
    is
        l_product_row deal_product%rowtype;
    begin
        l_product_row := product_utl.read_product(p_product_id, true);

        product_utl.edit_product(l_product_row,
                                 p_product_code,
                                 p_product_name,
                                 p_segment_of_business_id,
                                 p_valid_from,
                                 p_valid_through,
                                 p_parent_product_id);

        product_utl.create_deal_product_accounts(p_product_id, p_deal_product_account_list);

    end;

    procedure activate_product(p_product_id in integer)
    is
        l_product_row deal_product%rowtype;
    begin
        l_product_row := product_utl.read_product(p_product_id, true);

        product_utl.activate_product(l_product_row);

    end;

    procedure block_product(p_product_id in integer)
    is
        l_product_row deal_product%rowtype;
    begin
        l_product_row := product_utl.read_product(p_product_id, true);

        product_utl.block_product(l_product_row);

    end;

    procedure close_product(p_product_id in integer)
    is
        l_product_row deal_product%rowtype;
    begin
        l_product_row := product_utl.read_product(p_product_id, true);

        product_utl.close_product(l_product_row);

    end;

end product_ui;
/
 show err;
 
PROMPT *** Create  grants  PRODUCT_UI ***
grant EXECUTE                                                                on PRODUCT_UI      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/product_ui.sql =========*** End *** 
 PROMPT ===================================================================================== 
 