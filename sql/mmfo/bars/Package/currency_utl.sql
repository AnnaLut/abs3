
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/currency_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CURRENCY_UTL is

    type t_currency_id_directory is table of tabval$global%rowtype index by pls_integer;
    type t_currency_code_directory is table of tabval$global%rowtype index by varchar2(3 char);

    g_currency_id_directory t_currency_id_directory;
    g_currency_code_directory t_currency_code_directory;

    function read_currency(
        p_currency_id in integer,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return tabval$global%rowtype;

    function read_currency(
        p_currency_code in varchar2,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return tabval$global%rowtype;

    function get_currency_lcv(
        p_currency_id in integer)
    return varchar2;

    function get_currency_scale(
        p_currency_id in integer)
    return integer;

    function get_currency_scale(
        p_currency_code in varchar2)
    return integer;

    -- ��������� ���� � ������� �������� ����� ������ (�����, ������, �����) �� ��������� ������� ����� (������, �����, ������ ��� ����� � �.�.)
    function to_fractional_units(
        p_amount in number,
        p_currency_id in integer)
    return integer;

    -- ��������� ���� � ��������� �������� ����� ������ (������, �����, ������ ��� �����) �� ������� ������� ����� (�����, ������, ����� � �.�.)
    function from_fractional_units(
        p_amount in integer,
        p_currency_id in integer)
    return number;

    -- �������� ���� � ���� ������ � ���� �� ��������� ������ ���
    -- �� �����������, ���� ���������� � ��������� �������� ����� (�������, ������, ����� � �������� ����� � �.�.)
    -- � ��� ����������� ������������ ���� � ������� �������� �����, ��������� ��������� ��� �� ������� �� ���������
    -- ��������� p_value_is_fractional = 'N', � ����� ������� ��������� ����� ���� ����������� � ������� ��������
    function convert_amount(
        p_amount in number,
        p_from_currency_id in integer,
        p_to_currency_id in integer,
        p_bank_date in date default bankdate(),
        p_value_is_fractional in char default 'Y')
    return number;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.CURRENCY_UTL as

    procedure flush_directories_cache
    is
    begin
        g_currency_id_directory.delete();
        g_currency_code_directory.delete();
    end;

    function read_currency(
        p_currency_id in integer,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return tabval$global%rowtype
    is
        l_currency_row tabval$global%rowtype;
    begin
        if (p_use_cache and g_currency_id_directory.exists(p_currency_id)) then
            return g_currency_id_directory(p_currency_id);
        end if;

        select *
        into   l_currency_row
        from   tabval$global t
        where  t.kv = p_currency_id;

        if (p_use_cache) then
            g_currency_id_directory(p_currency_id) := l_currency_row;
        end if;

        return l_currency_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '������ � ��������������� {' || p_currency_id || '} �� ��������');
             else return null;
             end if;
    end;

    function read_currency(
        p_currency_code in varchar2,
        p_raise_ndf in boolean default true,
        p_use_cache in boolean default true)
    return tabval$global%rowtype
    is
        l_currency_row tabval$global%rowtype;
        l_currency_code char(3);
    begin
        if (length(p_currency_code) > 3) then
            raise_application_error(-20000, '���������� ��� ������ �� ���� ������������ 3-� �������');
        else
            l_currency_code := upper(p_currency_code);
        end if;

        if (p_use_cache and g_currency_code_directory.exists(l_currency_code)) then
            return g_currency_code_directory(l_currency_code);
        end if;

        select *
        into   l_currency_row
        from   tabval$global t
        where  t.lcv = l_currency_code;

        if (p_use_cache) then
            g_currency_code_directory(l_currency_code) := l_currency_row;
        end if;

        return l_currency_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                 raise_application_error(-20000, '������ � ����� {' || p_currency_code || '} �� ��������');
             else return null;
             end if;
    end;

    function get_currency_scale(
        p_currency_id in integer)
    return integer
    is
    begin
        return read_currency(p_currency_id, p_raise_ndf => false).dig;
    end;

    function get_currency_scale(
        p_currency_code in varchar2)
    return integer
    is
    begin
        return read_currency(p_currency_code, p_raise_ndf => false).dig;
    end;

    function get_currency_lcv(
        p_currency_id in integer)
    return varchar2
    is
    begin
        return read_currency(p_currency_id, p_raise_ndf => false).lcv;
    end;

    function to_fractional_units(
        p_amount in number,
        p_currency_id in integer)
    return integer
    is
    begin
        return p_amount * power(10, get_currency_scale(p_currency_id));
    end;

    function from_fractional_units(
        p_amount in integer,
        p_currency_id in integer)
    return number
    is
    begin
        return p_amount * power(10, -get_currency_scale(p_currency_id));
    end;

    -- todo: ���������� �������� ��������� ����������� ��� ����-����� ���� ����� (��� ��� �����������)
    --     : � ����� ��� ����-����� �������� - ������� ��������� ����������� ���� ����� ���������
    --     : �������� (� ���������)
    function convert_amount(
        p_amount in number,
        p_from_currency_id in integer,
        p_to_currency_id in integer,
        p_bank_date in date default bankdate(),
        p_value_is_fractional in char default 'Y')
    return number
    is
        l_equivalent_amount number;
        l_amount number;
    begin
        if (p_amount is null) then
            return null;
        end if;

        if (p_amount = 0) then
            return 0;
        end if;

        if (p_from_currency_id = p_to_currency_id) then
            return p_amount;
        end if;

        if (p_from_currency_id = gl.baseval) then
            l_equivalent_amount := case when p_value_is_fractional = 'Y' then p_amount
                                        else to_fractional_units(p_amount, p_from_currency_id)
                                   end;
        else
            l_equivalent_amount := gl.p_icurval(p_from_currency_id,
                                                case when p_value_is_fractional = 'Y' then p_amount
                                                     else to_fractional_units(p_amount, p_from_currency_id)
                                                end, p_bank_date);
        end if;

        if (p_to_currency_id = gl.baseval) then
            l_amount := l_equivalent_amount;
        else
            l_amount := gl.p_ncurval(p_to_currency_id, l_equivalent_amount, p_bank_date);
        end if;

        return case when p_value_is_fractional = 'Y' then l_amount
                    else from_fractional_units(l_amount, p_to_currency_id)
               end;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/currency_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 