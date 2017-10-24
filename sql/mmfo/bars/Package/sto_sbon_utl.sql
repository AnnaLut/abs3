
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/sto_sbon_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.STO_SBON_UTL is

 G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'version 2.0  01.05.2016';
 function header_version return varchar2;
 function body_version   return varchar2;

    SBON_WORK_MODE_FREE_PAYM       constant integer := 0;
    SBON_WORK_MODE_PAYM_CONTR      constant integer := 1;
    SBON_WORK_MODE_PAYM_NO_CONTR   constant integer := 2;

    function read_sbon_product(
        p_sbon_product_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_product%rowtype;

    function read_sbon_order_free(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_order_free%rowtype;

    function read_sbon_order_contr(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_order_contr%rowtype;

    function read_sbon_order_no_contr(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_order_no_contr%rowtype;

    function create_free_sbon_order(
        p_product_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    return integer;

    function create_sbon_order_with_contr(
        p_product_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_sendsms in varchar2)
    return integer;

    function create_sbon_order_with_nocontr(
        p_product_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_sendsms in varchar2)
    return integer;

    procedure update_free_sbon_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2);

    procedure update_sbon_order_with_contr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_sendsms in varchar2);

    procedure update_sbon_order_with_nocontr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_sendsms in varchar2);

    function get_order_type_for_work_mode(
        p_work_mode in integer)
    return integer;

    function parse_order_extra_attributes(
        p_order_id in integer)
    return varchar2;

    function add_sbon_provider(
        p_sbon_provider_id in integer,
        p_sbon_contract_number in varchar2,
        p_work_mode in integer,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_payment_name in varchar2,
        p_transit_account in varchar2,
        p_extra_attributes_metadata in clob default null,
        p_branch in varchar2 default null)
    return integer;

    procedure alter_sbon_provider(
        p_id in integer,
        p_work_mode in integer,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_payment_name in varchar2,
        p_transit_account in varchar2,
        p_extra_attributes_metadata in clob);

    procedure block_sbon_provider(
        p_id in integer);

    procedure unblock_sbon_provider(
        p_id in integer);

  procedure close_sbon_provider(
        p_id in integer);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.STO_SBON_UTL as

  G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=  'version 2.0 01.05.2016';

  FUNCTION header_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package header sto_sbon_utl ' || G_HEADER_VERSION;
  END header_version;

  FUNCTION body_version
     RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'Package body sto_sbon_utl ' || G_BODY_VERSION;
  END body_version;
  
    function get_all_sbon_order_types
    return number_list
    is
    begin
        return number_list(sto_utl.STO_TYPE_SBON_PAYMENT_FREE, sto_utl.STO_TYPE_SBON_PAYMENT_CONTR, sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR);
    end;

    function read_sbon_product(
        p_sbon_product_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_product%rowtype
    is
        l_sbon_product_row sto_sbon_product%rowtype;
    begin
        select *
        into   l_sbon_product_row
        from   sto_sbon_product p
        where  p.id = p_sbon_product_id;

        return l_sbon_product_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, '��������� ����+ � ��������������� {' || p_sbon_product_id || '} �� ���������');
             else return null;
             end if;
    end;

    function read_sbon_product_by_contr(
        p_sbon_contract_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_product%rowtype
    is
        l_sbon_product_row sto_sbon_product%rowtype;
    begin
        select *
        into   l_sbon_product_row
        from   sto_sbon_product p
        where  p.contract_id = p_sbon_contract_id and
               p.id in (select id from sto_payment);

        return l_sbon_product_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, '��������� ����+ � ��������������� �������� {' || p_sbon_contract_id || '} �� ���������');
             else return null;
             end if;
    end;

    function read_sbon_order_free(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_order_free%rowtype
    is
        l_sbon_order_free_row sto_sbon_order_free%rowtype;
    begin
        select *
        into   l_sbon_order_free_row
        from   sto_sbon_order_free osbonf
        where  osbonf.id = p_order_id;

        return l_sbon_order_free_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, '��������� ������������� � ��������������� {' || p_order_id ||
                                                '} ��� ������� ������� ����+ �� �������');
             else return null;
             end if;
    end;

    function read_sbon_order_contr(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_order_contr%rowtype
    is
        l_sbon_order_contr_row sto_sbon_order_contr%rowtype;
    begin
        select *
        into   l_sbon_order_contr_row
        from   sto_sbon_order_contr osbonc
        where  osbonc.id = p_order_id;

        return l_sbon_order_contr_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, '��������� ������������� � ��������������� {' || p_order_id ||
                                                '} ��� ������� ����+ � ��������� �� �������');
             else return null;
             end if;
    end;

    function read_sbon_order_no_contr(
        p_order_id in integer,
        p_raise_ndf in boolean default true)
    return sto_sbon_order_no_contr%rowtype
    is
        l_sbon_order_no_contr_row sto_sbon_order_no_contr%rowtype;
    begin
        select *
        into   l_sbon_order_no_contr_row
        from   sto_sbon_order_no_contr osbonc
        where  osbonc.id = p_order_id;

        return l_sbon_order_no_contr_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, '��������� ������������� � ��������������� {' || p_order_id ||
                                                '} ��� ������� ����+ ��� �������� �� �������');
             else return null;
             end if;
    end;

    procedure create_provider_sbon(
        p_product_id in integer,
        p_contract_id in integer,
        p_contract_number in varchar2,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_payment_name in varchar2,
        p_transit_account in varchar2)
    is
    begin
        insert into sto_sbon_product
        values (p_product_id,
                p_contract_id,
                p_contract_number,
                p_receiver_mfo,
                p_receiver_account,
                p_receiver_name,
                p_receiver_edrpou,
                p_payment_name,
                p_transit_account);
    end;

    procedure create_free_sbon_order(
        p_order_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2)
    is
    begin
        insert into sto_sbon_order_free
        values (p_order_id,
                p_regular_amount,
                p_receiver_mfo,
                p_receiver_account,
                p_receiver_name,
                p_receiver_edrpou,
                p_purpose);
    end;

    function create_free_sbon_order(
        p_product_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    return integer
    is
        l_order_id integer;
    begin
        l_order_id := sto_utl.create_order(sto_utl.STO_TYPE_SBON_PAYMENT_FREE,
                                           p_payer_account_id,
                                           p_product_id,
                                           p_start_date,
                                           p_stop_date,
                                           p_payment_frequency,
                                           p_holiday_shift,
                                           p_sendsms);

        create_free_sbon_order(l_order_id,
                               p_regular_amount,
                               p_receiver_mfo,
                               p_receiver_account,
                               p_receiver_name,
                               p_receiver_edrpou,
                               p_purpose);

        return l_order_id;
    end;

    procedure create_sbon_order_with_contr(
        p_order_id in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number)
    is
    begin
        insert into sto_sbon_order_contr
        values (p_order_id,
                p_customer_account,
                p_regular_amount,
                p_ceiling_amount);
    end;

    function create_sbon_order_with_contr(
        p_product_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_sendsms in varchar2)
    return integer
    is
        l_order_id integer;
    begin
        l_order_id := sto_utl.create_order(sto_utl.STO_TYPE_SBON_PAYMENT_CONTR,
                                           p_payer_account_id,
                                           p_product_id,
                                           p_start_date,
                                           p_stop_date,
                                           p_payment_frequency,
                                           p_holiday_shift,
                                           p_sendsms);

        create_sbon_order_with_contr(l_order_id,
                                     p_customer_account,
                                     p_regular_amount,
                                     p_ceiling_amount);

        return l_order_id;
    end;

    procedure create_sbon_order_with_nocontr(
        p_order_id in integer,
        p_customer_account in varchar2,
        p_regular_amount in number)
    is
    begin
        insert into sto_sbon_order_no_contr
        values (p_order_id,
                p_customer_account,
                p_regular_amount);
    end;

    function create_sbon_order_with_nocontr(
        p_product_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_sendsms in varchar2)
    return integer
    is
        l_order_id integer;
    begin
        l_order_id := sto_utl.create_order(sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR,
                                           p_payer_account_id,
                                           p_product_id,
                                           p_start_date,
                                           p_stop_date,
                                           p_payment_frequency,
                                           p_holiday_shift,
                                           p_sendsms);

        create_sbon_order_with_nocontr(l_order_id,
                                       p_customer_account,
                                       p_regular_amount);

        return l_order_id;
    end;

    procedure check_active_payments(
        p_order_id in integer)
    is
    begin
        for i in (select p.*
                  from   sto_payment p
                  where  p.order_id = p_order_id and
                         p.state not in (sto_payment_utl.STO_PM_STATE_DECLINED_BY_SBON, sto_payment_utl.STO_PM_STATE_DECLINED_BY_BARS,
                                         sto_payment_utl.STO_PM_STATE_SENT, sto_payment_utl.STO_PM_STATE_CANCEL_BY_CLIENT)) loop
            raise_application_error(-20000, '�� ������������� ����������� ����� �� ���� ' || to_char(i.value_date, 'dd.mm.yyyy') ||
                                            ', �� �������� �� ���䳿 ��������� - ����� ����� ���������� ��������� ��������� ������ ������, ��� ������� ��');
        end loop;
    end;

    procedure change_sbon_order_type(
        p_order_row in sto_order%rowtype,
        p_new_sbon_type_id in integer)
    is
        l_all_sbon_order_types number_list;
    begin
        l_all_sbon_order_types := get_all_sbon_order_types();

        if (p_order_row.order_type_id not member of l_all_sbon_order_types) then
            raise_application_error(-20000, '�������� ��� ������������� {' || sto_utl.get_order_type_name(p_order_row.order_type_id) ||
                                            '} �� ���������� �� ����� ���� - �������� ��� ������������� ����������');
        end if;

        if (p_new_sbon_type_id not member of l_all_sbon_order_types) then
            raise_application_error(-20000, '������������� ���� {' || sto_utl.get_order_type_name(p_new_sbon_type_id) ||
                                            '} �� ���������� �� ����� ���� - �������� ��� ������������� ����������');
        end if;
      
        sto_utl.update_order_type(p_order_row.id,
                                  p_new_sbon_type_id);         
        
    end;

    procedure change_sbon_order_product(
        p_order_row in sto_order%rowtype,
        p_new_sbon_product_id in integer)
    is
        l_new_product_row sto_product%rowtype;
    begin
        l_new_product_row := sto_utl.read_product(p_new_sbon_product_id);
        if (l_new_product_row.order_type_id not member of (get_all_sbon_order_types())) then
            raise_application_error(-20000, '������� ' || l_new_product_row.product_name || ' �� �������� �� ����� ���������� ���� - ���� �������� ����������');
        end if;

        check_active_payments(p_order_row.id);
        
        sto_utl.update_order_product(p_order_row.id,
                                     l_new_product_row.id);        
    end;

    procedure clear_sbon_order_details(
        p_order_row in sto_order%rowtype)
    is
    begin
        case (p_order_row.order_type_id)
        when sto_utl.STO_TYPE_SBON_PAYMENT_FREE then
             delete sto_sbon_order_free s where s.id = p_order_row.id;
        when sto_utl.STO_TYPE_SBON_PAYMENT_CONTR then
             delete sto_sbon_order_contr s where s.id = p_order_row.id;
        when sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR then
             delete sto_sbon_order_no_contr s where s.id = p_order_row.id;
        else
             raise_application_error(-20000, '������������ ��� �������� {' || sto_utl.get_order_type_name(p_order_row.order_type_id) || '}');
        end case;
    end;

    procedure update_free_sbon_order(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_regular_amount in number,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_purpose in varchar2,
        p_sendsms in varchar2)
    is
        l_order_row sto_order%rowtype;
    begin
        l_order_row := sto_utl.read_order(p_order_id, p_lock => true);

        sto_utl.update_order(l_order_row.id,
                             p_payer_account_id,
                             p_start_date,
                             p_stop_date,
                             p_payment_frequency,
                             p_holiday_shift,
                             p_sendsms);

        if (l_order_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_FREE) then
            change_sbon_order_type(l_order_row, sto_utl.STO_TYPE_SBON_PAYMENT_FREE);

            clear_sbon_order_details(l_order_row);
            create_free_sbon_order(l_order_row.id,
                                   p_regular_amount,
                                   p_receiver_mfo,
                                   p_receiver_account,
                                   p_receiver_name,
                                   p_receiver_edrpou,
                                   p_purpose);
        else
            update sto_sbon_order_free t
            set    t.regular_amount = p_regular_amount,
                   t.receiver_mfo = p_receiver_mfo,
                   t.receiver_account = p_receiver_account,
                   t.receiver_name = p_receiver_name,
                   t.receiver_edrpou = p_receiver_edrpou,
                   t.purpose = p_purpose
            where  t.id = l_order_row.id;
        end if;

        if (l_order_row.product_id <> p_provider_id) then
            change_sbon_order_product(l_order_row, p_provider_id);
        end if;
    end;

    procedure update_sbon_order_with_contr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_ceiling_amount in number,
        p_sendsms in varchar2)
    is
        l_order_row sto_order%rowtype;
    begin
        l_order_row := sto_utl.read_order(p_order_id, p_lock => true);

        sto_utl.update_order(l_order_row.id,
                             p_payer_account_id,
                             p_start_date,
                             p_stop_date,
                             p_payment_frequency,
                             p_holiday_shift,
                             p_sendsms);

        if (l_order_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_CONTR) then
            change_sbon_order_type(l_order_row, sto_utl.STO_TYPE_SBON_PAYMENT_CONTR);

            clear_sbon_order_details(l_order_row);
            create_sbon_order_with_contr(l_order_row.id,
                                         p_customer_account,
                                         p_regular_amount,
                                         p_ceiling_amount);
        else
            update sto_sbon_order_contr t
            set    t.customer_account = p_customer_account,
                   t.regular_amount = p_regular_amount,
                   t.ceiling_amount = p_ceiling_amount
            where  t.id = l_order_row.id;
        end if;

        if (l_order_row.product_id <> p_provider_id) then
            change_sbon_order_product(l_order_row, p_provider_id);
        end if;
    end;

    procedure update_sbon_order_with_nocontr(
        p_order_id in integer,
        p_payer_account_id in integer,
        p_start_date in date,
        p_stop_date in date,
        p_payment_frequency in integer,
        p_holiday_shift in integer,
        p_provider_id in integer,
        p_customer_account in varchar2,
        p_regular_amount in number,
        p_sendsms in varchar2)
    is
        l_order_row sto_order%rowtype;
    begin
        l_order_row := sto_utl.read_order(p_order_id, p_lock => true);

        sto_utl.update_order(l_order_row.id,
                             p_payer_account_id,
                             p_start_date,
                             p_stop_date,
                             p_payment_frequency,
                             p_holiday_shift,
                             p_sendsms);

        if (l_order_row.order_type_id <> sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR) then
            change_sbon_order_type(l_order_row, sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR);

            clear_sbon_order_details(l_order_row);
            create_sbon_order_with_nocontr(l_order_row.id,
                                           p_customer_account,
                                           p_regular_amount);
        else
            update sto_sbon_order_no_contr t
            set    t.customer_account = p_customer_account,
                   t.regular_amount = p_regular_amount
            where  t.id = l_order_row.id;
        end if;

        if (l_order_row.product_id <> p_provider_id) then
            change_sbon_order_product(l_order_row, p_provider_id);
        end if;
    end;

    function parse_order_extra_attributes(
        p_order_id in integer)
    return varchar2
    is
        l_product_extra_attributes clob;
        l_order_extra_attributes clob;
        l_order_row sto_order%rowtype;
        l_result_value varchar2(32767 byte);
    begin
        l_order_row := sto_utl.read_order(p_order_id);
        l_product_extra_attributes := sto_utl.get_product_extra_attributes(l_order_row.product_id);
        l_order_extra_attributes := sto_utl.get_order_extra_info(p_order_id);

        if (l_product_extra_attributes is null or l_order_extra_attributes is null) then
            return null;
        end if;

        for i in (select ExtractValue(column_value, '/Attribute/UserFriendlyName') attribute_friendly_name,
                         ExtractValue(column_value, '/Attribute/AttributeCode') attribute_code
                  from table(XMLSequence(XMLType(l_product_extra_attributes).extract('/Attributes/Attribute'))))
        loop
            for j in (select ExtractValue(column_value, '/Attributes/' || i.attribute_code) attribute_value
                      from   table(XMLSequence(XMLType(l_order_extra_attributes))))
            loop
                if (j.attribute_value is not null) then
                    l_result_value := l_result_value || i.attribute_friendly_name || ' : ' || j.attribute_value || chr(13) || chr(10);
                end if;
            end loop;
        end loop;

        return l_result_value;
    exception
        when others then
             return null;
    end;

    procedure check_sbon_product_uniqueness(
        p_contract_id in integer)
    is
        l_provider_row sto_sbon_product%rowtype;
    begin
        l_provider_row := read_sbon_product_by_contr(p_contract_id, p_raise_ndf => false);

        if (l_provider_row.id is not null) then
            raise_application_error(-20000, '��������� � ��������������� {' || p_contract_id ||
                                            '} ��� ������������� - ' || l_provider_row.payment_name ||
                                            ' (' || l_provider_row.contract_number || ')');
        end if;
    end;

    procedure check_provider_closure(
        p_id in integer)
    is
        l_provider_row sto_sbon_product%rowtype;
        l_product_row sto_product%rowtype;
    begin
        l_provider_row := read_sbon_product_by_contr(p_id);

        l_product_row := sto_utl.read_product(l_provider_row.id);
        if (l_product_row.state = sto_utl.STO_PRODUCT_STATE_CLOSED) then
            raise_application_error(-20000, '��������� �������� - �������� �� ���� ���� ���������');
        end if;
    end;

    procedure check_existing_orders(
        p_provider_id in integer)
    is
        l_bank_date date default bankdate();
        l_order_id integer;
        l_provider_row sto_sbon_product%rowtype;
    begin
        l_provider_row := read_sbon_product_by_contr(p_provider_id);

        select min(o.id)
        into   l_order_id
        from   sto_order o
         where o.product_id = l_provider_row.id and
               o.cancel_date is null and
               (o.stop_date is null or o.stop_date >= l_bank_date);

        if (l_order_id is not null) then
            raise_application_error(-20000, '�� ���������� {' || l_provider_row.receiver_name ||
                                                                 case when l_provider_row.payment_name is null then null
                                                                      else ' - ' || l_provider_row.payment_name
                                                                 end ||
                                            '} ������ ������ ������������� - ���� ������ ������ �� ������������');
        end if;
    end;

    function is_branch(p_branch in varchar2)
    return boolean
    is
    begin
        return regexp_like(p_branch, '^/\d{6}/\d{1,}');
    end;

    function get_order_type_for_work_mode(
        p_work_mode in integer)
    return integer
    is
    begin
        case (p_work_mode)
        when sto_sbon_utl.SBON_WORK_MODE_FREE_PAYM then
            return sto_utl.STO_TYPE_SBON_PAYMENT_FREE;
        when sto_sbon_utl.SBON_WORK_MODE_PAYM_CONTR then
            return sto_utl.STO_TYPE_SBON_PAYMENT_CONTR;
        when sto_sbon_utl.SBON_WORK_MODE_PAYM_NO_CONTR then
            return sto_utl.STO_TYPE_SBON_PAYMENT_NOCONTR;
        else
            raise_application_error(-20000, '������������ ����� ������ ���������� {' || p_work_mode || '}');
        end case;
    end;

    function add_sbon_provider(
        p_sbon_provider_id in integer,
        p_sbon_contract_number in varchar2,
        p_work_mode in integer,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_payment_name in varchar2,
        p_transit_account in varchar2,
        p_extra_attributes_metadata in clob default null,
        p_branch in varchar2 default null)
    return integer
    is
        l_product_id integer;
        l_order_type_id integer;
        l_branch varchar2(30 char) default trim(p_branch);
    begin
        l_order_type_id := get_order_type_for_work_mode(p_work_mode);

        check_sbon_product_uniqueness(p_sbon_provider_id);

        if (p_work_mode <> sto_sbon_utl.SBON_WORK_MODE_FREE_PAYM) then
            sto_utl.check_receiver(p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou);
        end if;

        if (l_branch is null) then
             -- ������ � ������������ ���� ���������� �� ��� ���
            -- �� �������� �� ������-���, ������� ��� ����������� � ���������,
             -- ���� �������� �� ������-���, ����+ ������� ���� ���������� ��� ������, �� ����� ���������� ���������
             -- ��� �� ���������� ������ ������������ �� ��� ������� "���� ����"
            l_branch := branch_usr.get_branch();
            if (is_branch(l_branch)) then
                l_branch := bars_context.make_branch(bars_context.extract_mfo(l_branch));
            end if;
        end if;

        l_product_id := sto_utl.create_product(l_order_type_id,
                                               p_sbon_provider_id,
                                               p_receiver_name,
                                               sto_utl.PROD_ACCESS_MODE_WHOLE_MFO,
                                               l_branch);

         create_provider_sbon(l_product_id,
                              p_sbon_provider_id,
                              p_sbon_contract_number,
                              p_receiver_mfo,
                              p_receiver_account,
                              p_receiver_name,
                              p_receiver_edrpou,
                              p_payment_name,
                              p_transit_account);

        if (p_extra_attributes_metadata is not null) then
            sto_utl.set_product_extra_attributes(l_product_id, p_extra_attributes_metadata);
        end if;

        return l_product_id;
    end;

    procedure alter_sbon_provider(
        p_id in integer,
        p_work_mode in integer,
        p_receiver_mfo in varchar2,
        p_receiver_account in varchar2,
        p_receiver_name in varchar2,
        p_receiver_edrpou in varchar2,
        p_payment_name in varchar2,
        p_transit_account in varchar2,
        p_extra_attributes_metadata in clob)
    is
        l_provider_row sto_sbon_product%rowtype;
        l_product_row sto_product%rowtype;
        l_order_type_id integer;
    begin
        l_provider_row := read_sbon_product_by_contr(p_id);
        l_product_row := sto_utl.read_product(l_provider_row.id, p_lock => true);
        l_order_type_id := get_order_type_for_work_mode(p_work_mode);

        -- check_sbon_product_uniqueness(p_id);
        check_provider_closure(p_id);

        if (p_work_mode <> sto_sbon_utl.SBON_WORK_MODE_FREE_PAYM) then
            sto_utl.check_receiver(p_receiver_mfo, p_receiver_account, p_receiver_name, p_receiver_edrpou);
        end if;

        if (l_product_row.order_type_id <> l_order_type_id) then
            check_existing_orders(p_id);

            update sto_product p
            set    p.order_type_id = l_order_type_id
            where  p.id = l_product_row.id;
        end if;

        update sto_sbon_product p
        set    p.receiver_mfo = p_receiver_mfo,
               p.receiver_account = p_receiver_account,
               p.receiver_name = p_receiver_name,
               p.receiver_edrpou = p_receiver_edrpou,
               p.payment_name = p_payment_name,
               p.transit_account = p_transit_account
        where p.id = l_product_row.id;

        sto_utl.set_product_extra_attributes(l_product_row.id, p_extra_attributes_metadata);
    end;

    procedure block_sbon_provider(
        p_id in integer)
    is
        l_provider_row sto_sbon_product%rowtype;
        l_product_row sto_product%rowtype;
    begin
        l_provider_row := read_sbon_product_by_contr(p_id);
        l_product_row := sto_utl.read_product(l_provider_row.id, p_lock => true);

        check_provider_closure(p_id);

        update sto_product p
        set    p.state = sto_utl.STO_PRODUCT_STATE_BLOCKED
        where  p.id = l_product_row.id;
        -- ��� ����� ��������� �볺��� ��� ����������� ���������� �� ������������
    end;

    procedure unblock_sbon_provider(
        p_id in integer)
    is
        l_provider_row sto_sbon_product%rowtype;
        l_product_row sto_product%rowtype;
    begin
        l_provider_row := read_sbon_product_by_contr(p_id);
        l_product_row := sto_utl.read_product(l_provider_row.id, p_lock => true);

        check_provider_closure(p_id);

        update sto_product p
        set    p.state = sto_utl.STO_PRODUCT_STATE_ACTIVE
        where  p.id = l_product_row.id;
        -- ��� ����� ��������� �볺��� ��� ����������� ���������� �� ������������
    end;

    procedure close_sbon_provider(
        p_id in integer)
    is
        l_provider_row sto_sbon_product%rowtype;
        l_product_row sto_product%rowtype;
    begin
        l_provider_row := read_sbon_product_by_contr(p_id);
        l_product_row := sto_utl.read_product(l_provider_row.id, p_lock => true);

        check_provider_closure(p_id);

        update sto_product p
        set    p.state = sto_utl.STO_PRODUCT_STATE_CLOSED
        where  p.id = l_product_row.id;
        -- ��� ����� ��������� �볺��� ��� ����������� ���������� �� ������������
    end;
end;
/
 show err;
 
PROMPT *** Create  grants  STO_SBON_UTL ***
grant DEBUG,EXECUTE                                                          on STO_SBON_UTL    to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/sto_sbon_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 