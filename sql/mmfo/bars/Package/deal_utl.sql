
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/deal_utl.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.DEAL_UTL is

    -- Author  : Artem Yurchenko
    -- Date    : 2015-04-20
    -- Purpose : �������� ���������������� ����� ��� ��������� ��������, �� ������� ��� ����� ���� � ���

    OBJ_TYPE_DEAL                  constant varchar2(30 char) := 'DEAL';

    DEAL_STATE_ACTIVE              constant integer := 1;
    DEAL_STATE_CLOSED              constant integer := 1000;

    ATTR_CODE_DEAL_NUMBER          constant varchar2(30 char) := 'DEAL_NUMBER';
    ATTR_CODE_CUSTOMER_ID          constant varchar2(30 char) := 'DEAL_CUSTOMER';
    ATTR_CODE_PRODUCT_ID           constant varchar2(30 char) := 'DEAL_PRODUCT';
    ATTR_CODE_START_DATE           constant varchar2(30 char) := 'DEAL_START_DATE';
    ATTR_CODE_EXPIRY_DATE          constant varchar2(30 char) := 'DEAL_EXPIRY_DATE';
    ATTR_CODE_CLOSE_DATE           constant varchar2(30 char) := 'DEAL_CLOSE_DATE';
    ATTR_CODE_STATE_ID             constant varchar2(30 char) := 'OBJECT_STATE';
    ATTR_CODE_BRANCH_ID            constant varchar2(30 char) := 'DEAL_BRANCH';
    ATTR_CODE_CURATOR_ID           constant varchar2(30 char) := 'DEAL_CURATOR';

    ATTR_CODE_INT_CRED_RANK_INIT   constant varchar2(30 char) := 'DEAL_VNCRP';
    ATTR_CODE_INT_CRED_RANK_CURR   constant varchar2(30 char) := 'DEAL_VNCRR';

    ATTR_CODE_FIN_CONDITION        constant varchar2(30 char) := 'DEAL_FIN_CONDITION';           -- ���� ������������ (���.����)
    ATTR_CODE_OVERDUE_DAYS         constant varchar2(30 char) := 'DEAL_OVERDUE_DAYS';            -- ʳ������ ��� ���������� �� ������
    ATTR_CODE_PORTFOL_RESERVE_FLAG constant varchar2(30 char) := 'DEAL_PORTFOL_RESERVE_FLAG';    -- ������ ������������ ������ (8)
    ATTR_CODE_PORTFOL_RESERVE_GRP  constant varchar2(30 char) := 'DEAL_PORTFOL_RESERVE_GRP';     -- ����� ������ ������������ ������

    --> ��������� �������� ������������� ����� ������ �� 25.01.2012 �. � 23
    ATTR_CODE_FIN_CONDITION_23     constant varchar2(30 char) := 'DEAL_FIN_CONDITION_23';        -- ���� ������������ (class of borrower) � ���� ��������� ��� �������������� ������������ (����������� �����) �� ������������ ������ ���� ����������� �����

    ATTR_CODE_DEBT_SERV_CLASS_23   constant varchar2(30 char) := 'DEAL_DEBT_SERV_CLASS_23';      -- ���� �������������� ����� - ���� ��������� ��������� ���������� �� ���������
                                                                                                 -- ʳ������ ����������� ��� ������������ (�������) ���� �������������� �����
                                                                                                 -- �� 0 �� 7                                        ��������
                                                                                                 -- �� 8 �� 30                                       �������
                                                                                                 -- �� 31 �� 90                                      �����������
                                                                                                 -- �� 91 �� 180                                     ��������
                                                                                                 -- ����� 180                                         �������������

    ATTR_CODE_FIN_QUALITY_CATEG_23 constant varchar2(30 char) := 'DEAL_FIN_QUALITY_CATEGORY_23'; -- �������i� �����i �� ��������
                                                                                                 -- ���� �������� - �������� �����       ���� �������������� �����
                                                                                                 --                                       ��������    �������    �����������    ��������    �������������
                                                                                                 --                               1       �            �           I��              IV           V
                                                                                                 --                               2       �            �           I��              IV           V
                                                                                                 --                               3       �            ��          I��              IV           V
                                                                                                 --                               4       �            ��          I��              IV           V
                                                                                                 --                               5       ��           ��          I��              IV           V
                                                                                                 --                               6       ��           ���         IV               �V           V
                                                                                                 --                               7       ��           I��         IV               �V           V
                                                                                                 --                               8       I�           I��         �V               �V           V
                                                                                                 --                               9       ��           ���         �V               V            V

    ATTR_CODE_RISK_RATE_23         constant varchar2(30 char) := 'DEAL_RISK_RATE_23';            -- ���������� ������
                                                                                                 -- �������� ����� �� ��������   �������� ��������� ������ �������
                                                                                                 --                  � - �������                         0,01 - 0,06
                                                                                                 --                  ��                                  0,07 - 0,20
                                                                                                 --                  ���                                 0,21 - 0,50
                                                                                                 --                  �V                                  0,51 - 0,99
                                                                                                 --                  V - ��������                        1,0
    --< ��������� �������� ������������� ����� ������ �� 25.01.2012 �. � 23

    procedure check_deal_type(
        p_deal_type_row in object_type%rowtype);

    function create_deal(
        p_deal_type_id in integer,
        p_deal_number in varchar2,
        p_customer_id in integer,
        p_product_id in integer,
        p_start_date in date default bankdate(),
        p_expiry_date in date default null,
        p_curator_id in integer default user_id(),
        p_branch in varchar2 default sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH))
    return integer;

    function create_deal(
        p_deal_type_code in varchar2,
        p_deal_number in varchar2,
        p_customer_id in integer,
        p_product_id in integer,
        p_start_date in date default bankdate(),
        p_expiry_date in date default null,
        p_curator_id in integer default user_id(),
        p_branch in varchar2 default sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH))
    return integer;

    function read_deal(
        p_deal_id in integer,
        p_lock in boolean default false,
        p_raise_ndf in boolean default true)
    return deal%rowtype;

    function get_deal_type_id(
        p_deal_id in integer)
    return integer;

    function get_deal_number(
        p_deal_id in integer)
    return varchar2;

    function get_deal_customer_id(
        p_deal_id in integer)
    return integer;

    function get_deal_product_id(
        p_deal_id in integer)
    return integer;

    function get_deal_start_date(
        p_deal_id in integer)
    return date;

    function get_deal_expiry_date(
        p_deal_id in integer)
    return date;

    function get_deal_close_date(
        p_deal_id in integer)
    return date;

    function get_object_state_id(
        p_deal_id in integer)
    return integer;

    function get_deal_branch_id(
        p_deal_id in integer)
    return varchar2;

    function get_deal_curator_id(
        p_deal_id in integer)
    return integer;

    function get_deal_number(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2;

    function get_deal_customer_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;

    function get_deal_product_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;

    function get_deal_start_date(
        p_deal_id in integer,
        p_value_date in date)
    return date;

    function get_deal_expiry_date(
        p_deal_id in integer,
        p_value_date in date)
    return date;

    function get_deal_close_date(
        p_deal_id in integer,
        p_value_date in date)
    return date;

    function get_object_state_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;

    function get_deal_branch_id(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2;

    function get_deal_curator_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_comment in varchar2 default null);

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_comment in varchar2 default null);

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_comment in varchar2 default null);

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_object_state_id(
        p_deal_id in integer,
        p_state_id in integer,
        p_comment in varchar2 default null);

    procedure set_object_state_id(
        p_deal_id in integer,
        p_state_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_object_state_id(
        p_deal_id in integer,
        p_state_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_comment in varchar2 default null);

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_comment in varchar2 default null);

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null);

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null);
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.DEAL_UTL as

    procedure check_deal_type(
        p_deal_type_row in object_type%rowtype)
    is
    begin
        if (p_deal_type_row.id not member of object_utl.get_inheritance_tree(deal_utl.OBJ_TYPE_DEAL)) then
            raise_application_error(-20000, '��� ��''���� {' || object_utl.get_object_type_name(p_deal_type_row.type_name) ||
                                            '} �� �������� �� ��������� ��''���� ���� "�����"');
        end if;

        if (p_deal_type_row.state_id <> object_utl.OBJ_TYPE_STATE_ACTIVE) then
            raise_application_error(-20000, '��� ����� {' || p_deal_type_row.type_name ||
                                            '} �������� � ���� {' || list_utl.get_item_name(object_utl.LT_OBJECT_TYPE_STATE, p_deal_type_row.state_id) ||
                                            '} - ��������� ����� ���� ����������');
        end if;
    end;

    procedure check_deal_product(
        p_deal_type_id in integer,
        p_product_id in integer)
    is
        l_product_row deal_product%rowtype;
    begin
        if (p_product_id is not null) then
            l_product_row := product_utl.read_product(p_product_id);

            if (l_product_row.state_id <> product_utl.PROD_STATE_ACTIVE) then
                raise_application_error(-20000, '������� {' || l_product_row.product_name ||
                                                '} �������� � ���� {' || list_utl.get_item_name(product_utl.LT_PRODUCT_STATE, l_product_row.state_id) ||
                                                '} - ��������� ����� ���� ����������');
            end if;

            if (tools.compare_range_borders(l_product_row.valid_from, bankdate()) > 0 or
                tools.compare_range_borders(bankdate(), l_product_row.valid_through) > 0) then
                raise_application_error(-20000, '��������� ���� {' || to_char(bankdate(), 'dd.mm.yyyy') ||
                                                '} �� ������� � ����� 䳿 �������� {' || l_product_row.product_name ||
                                                '}: ' || nvl(to_char(l_product_row.valid_from, 'dd.mm.yyyy'), '�� ��������') || ' - ' ||
                                                         nvl(to_char(l_product_row.valid_through, 'dd.mm.yyyy'), '�� ��������'));
            end if;

            if (l_product_row.deal_type_id <> p_deal_type_id) then
                raise_application_error(-20000, '��� ���� ����� {' || object_utl.get_object_type_name(p_deal_type_id) ||
                                                '} �� ������� ���� ����� �������� {' || object_utl.get_object_type_name(l_product_row.deal_type_id) || '}');
            end if;
        end if;
    end;

    function create_deal(
        p_deal_type_row in object_type%rowtype,
        p_deal_number in varchar2,
        p_customer_id in integer,
        p_product_id in integer,
        p_start_date in date default bankdate(),
        p_expiry_date in date default null,
        p_curator_id in integer default user_id(),
        p_branch in varchar2 default sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH))
    return integer
    is
        l_deal_id integer;
        l_customer_row customer%rowtype;
    begin
        if (p_start_date is null) then
            raise_application_error(-20000, '���� ������� 䳿 ����� �� �������');
        end if;

        if (p_branch is null) then
            raise_application_error(-20000, 'Գ��� ����� �� ��������');
        end if;

        if (p_expiry_date is not null and p_start_date > p_expiry_date) then
            raise_application_error(-20000, '���� ������� 䳿 ����� {' || to_char(p_start_date, 'dd.mm.yyyy') ||
                                            '} �� ���� ������������ ���� �� ���������� {' || to_char(p_expiry_date, 'dd.mm.yyyy') || '}');
        end if;

        check_deal_type(p_deal_type_row);
        check_deal_product(p_deal_type_row.id, p_product_id);

        l_customer_row := customer_utl.read_customer(p_customer_id);

        if (l_customer_row.date_off is not null and l_customer_row.date_off <= bankdate()) then
            raise_application_error(-20000, '���������� {' || l_customer_row.nmk ||
                                            '} �������� (' || to_char(l_customer_row.date_off, 'dd.mm.yyyy') ||
                                            ') - ��������� ����� ���� ����������');
        end if;

        insert into deal (id, deal_type_id)
        values (bars_sqnc.get_nextval('deal_seq'),
                p_deal_type_row.id)
         returning id
         into l_deal_id;

         set_object_state_id(l_deal_id, deal_utl.DEAL_STATE_ACTIVE);
         set_deal_customer_id(l_deal_id, p_customer_id);
         set_deal_start_date(l_deal_id, p_start_date);
         set_deal_branch_id(l_deal_id, p_branch);

         if (p_deal_number is not null) then
             set_deal_number(l_deal_id, p_deal_number);
         end if;

         if (p_product_id is not null) then
             set_deal_product_id(l_deal_id, p_product_id);
         end if;

         if (p_expiry_date is not null) then
             set_deal_expiry_date(l_deal_id, p_expiry_date);
         end if;

         if (p_curator_id is not null) then
             set_deal_curator_id(l_deal_id, p_curator_id);
         end if;

         return l_deal_id;
    end;

    function create_deal(
        p_deal_type_id in integer,
        p_deal_number in varchar2,
        p_customer_id in integer,
        p_product_id in integer,
        p_start_date in date default bankdate(),
        p_expiry_date in date default null,
        p_curator_id in integer default user_id(),
        p_branch in varchar2 default sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH))
    return integer
    is
        l_object_type_row object_type%rowtype;
    begin
        l_object_type_row := object_utl.read_object_type(p_deal_type_id);

        return create_deal(l_object_type_row, p_deal_number, p_customer_id, p_product_id, p_start_date, p_expiry_date, p_curator_id, p_branch);
    end;

    function create_deal(
        p_deal_type_code in varchar2,
        p_deal_number in varchar2,
        p_customer_id in integer,
        p_product_id in integer,
        p_start_date in date default bankdate(),
        p_expiry_date in date default null,
        p_curator_id in integer default user_id(),
        p_branch in varchar2 default sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH))
    return integer
    is
        l_object_type_row object_type%rowtype;
    begin
        l_object_type_row := object_utl.read_object_type(p_deal_type_code);

        return create_deal(l_object_type_row.id, p_deal_number, p_customer_id, p_product_id, p_start_date, p_expiry_date, p_curator_id, p_branch);
    end;

    function read_deal(
        p_deal_id in integer,
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
            where  d.id = p_deal_id
            for update wait 60;
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
                 raise_application_error(-20000, '����� � ��������������� {' || p_deal_id || '} �� ��������');
             else return null;
             end if;
    end;

    function get_deal_type_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).deal_type_id;
    end;

    function get_deal_number(
        p_deal_id in integer)
    return varchar2
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).deal_number;
    end;

    function get_deal_customer_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).customer_id;
    end;

    function get_deal_product_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).product_id;
    end;

    function get_deal_start_date(
        p_deal_id in integer)
    return date
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).start_date;
    end;

    function get_deal_expiry_date(
        p_deal_id in integer)
    return date
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).expiry_date;
    end;

    function get_deal_close_date(
        p_deal_id in integer)
    return date
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).close_date;
    end;

    function get_object_state_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).state_id;
    end;

    function get_deal_branch_id(
        p_deal_id in integer)
    return varchar2
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).branch_id;
    end;

    function get_deal_curator_id(
        p_deal_id in integer)
    return integer
    is
    begin
        return read_deal(p_deal_id, p_raise_ndf => false).curator_id;
    end;

    function get_deal_number(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2
    is
    begin
        return attribute_utl.get_string_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_value_date);
    end;

    function get_deal_customer_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_value_date);
    end;

    function get_deal_product_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_value_date);
    end;

    function get_deal_start_date(
        p_deal_id in integer,
        p_value_date in date)
    return date
    is
    begin
        return attribute_utl.get_date_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_value_date);
    end;

    function get_deal_expiry_date(
        p_deal_id in integer,
        p_value_date in date)
    return date
    is
    begin
        return attribute_utl.get_date_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_value_date);
    end;

    function get_deal_close_date(
        p_deal_id in integer,
        p_value_date in date)
    return date
    is
    begin
        return attribute_utl.get_date_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_value_date);
    end;

    function get_object_state_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_STATE_ID, p_value_date);
    end;

    function get_deal_branch_id(
        p_deal_id in integer,
        p_value_date in date)
    return varchar2
    is
    begin
        return attribute_utl.get_string_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_value_date);
    end;

    function get_deal_curator_id(
        p_deal_id in integer,
        p_value_date in date)
    return integer
    is
    begin
        return attribute_utl.get_number_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_value_date);
    end;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_deal_number, p_comment);
    end;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_deal_number, p_value_date, p_comment);
    end;

    procedure set_deal_number(
        p_deal_id in integer,
        p_deal_number in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_DEAL_NUMBER, p_deal_number, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_customer_id, p_comment);
    end;

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_customer_id, p_value_date, p_comment);
    end;

    procedure set_deal_customer_id(
        p_deal_id in integer,
        p_customer_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CUSTOMER_ID, p_customer_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_product_id, p_comment);
    end;

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_product_id, p_value_date, p_comment);
    end;

    procedure set_deal_product_id(
        p_deal_id in integer,
        p_product_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_PRODUCT_ID, p_product_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_start_date, p_comment);
    end;

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_start_date, p_value_date, p_comment);
    end;

    procedure set_deal_start_date(
        p_deal_id in integer,
        p_start_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_START_DATE, p_start_date, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_expiry_date, p_comment);
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_expiry_date, p_value_date, p_comment);
    end;

    procedure set_deal_expiry_date(
        p_deal_id in integer,
        p_expiry_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_EXPIRY_DATE, p_expiry_date, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_close_date, p_comment);
    end;

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_close_date, p_value_date, p_comment);
    end;

    procedure set_deal_close_date(
        p_deal_id in integer,
        p_close_date in date,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CLOSE_DATE, p_close_date, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_object_state_id(
        p_deal_id in integer,
        p_state_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_STATE_ID, p_state_id, p_comment);
    end;

    procedure set_object_state_id(
        p_deal_id in integer,
        p_state_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_STATE_ID, p_state_id, p_value_date, p_comment);
    end;

    procedure set_object_state_id(
        p_deal_id in integer,
        p_state_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_STATE_ID, p_state_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_branch_id, p_comment);
    end;

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_branch_id, p_value_date, p_comment);
    end;

    procedure set_deal_branch_id(
        p_deal_id in integer,
        p_branch_id in varchar2,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_BRANCH_ID, p_branch_id, p_valid_from, p_valid_through, p_comment);
    end;

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_curator_id, p_comment);
    end;

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_value_date in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_curator_id, p_value_date, p_comment);
    end;

    procedure set_deal_curator_id(
        p_deal_id in integer,
        p_curator_id in integer,
        p_valid_from in date,
        p_valid_through in date,
        p_comment in varchar2 default null)
    is
    begin
        attribute_utl.set_value(p_deal_id, deal_utl.ATTR_CODE_CURATOR_ID, p_curator_id, p_valid_from, p_valid_through, p_comment);
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/deal_utl.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 