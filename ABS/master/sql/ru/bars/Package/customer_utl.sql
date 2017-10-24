
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/customer_utl.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.CUSTOMER_UTL is

    TAG_MAIN_MOBILE_PHONE          constant varchar2(5 char) := 'MPNO';

    function read_customer(
        p_customer_id in integer,
        p_raise_ndf in boolean default true)
    return customer%rowtype;

    function read_person(
        p_customer_id in integer,
        p_raise_ndf in boolean default true)
    return person%rowtype;

    function read_bank(
        p_mfo_code in varchar2,
        p_raise_ndf in boolean default true)
    return banks$base%rowtype;

    function get_customer_address_row(
        p_customer_id in integer,
        p_address_type in integer default null)
    return customer_address%rowtype;

    function get_customer_address_line(
        p_customer_id in integer,
        p_address_type in integer default null)
    return varchar2;

    function get_element(
        p_customer_id in integer,
        p_element_code in varchar2)
    return varchar2;

    function get_customer_mobile_phone(
        p_customer_id in integer)
    return varchar2;
end;
/
CREATE OR REPLACE PACKAGE BODY BARS.CUSTOMER_UTL as

    function read_customer(
        p_customer_id in integer,
        p_raise_ndf in boolean default true)
    return customer%rowtype
    is
        l_customer_row customer%rowtype;
    begin
        select *
        into   l_customer_row
        from   customer c
        where  c.rnk = p_customer_id;

        return l_customer_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Клієнт з ідентифікатором {' || p_customer_id || '} не знайдений');
             else return null;
             end if;
    end;

    function read_person(
        p_customer_id in integer,
        p_raise_ndf in boolean default true)
    return person%rowtype
    is
        l_person_row person%rowtype;
    begin
        select *
        into   l_person_row
        from   person p
        where  p.rnk = p_customer_id;

        return l_person_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Фізична особа з ідентифікатором {' || p_customer_id || '} не знайдена');
             else return null;
             end if;
    end;

    function read_bank(
        p_mfo_code in varchar2,
        p_raise_ndf in boolean default true)
    return banks$base%rowtype
    is
        l_bank_row banks$base%rowtype;
    begin
        select *
        into   l_bank_row
        from   banks$base b
        where  b.mfo = p_mfo_code;

        return l_bank_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(-20000, 'Банк з кодом МФО {' || p_mfo_code || '} не знайдений');
             else return null;
             end if;
    end;

    function get_customer_address_row(
        p_customer_id in integer,
        p_address_type in integer default null)
    return customer_address%rowtype
    is
        l_address_row customer_address%rowtype;
    begin
        if (p_address_type is null) then
            select *
            into   l_address_row
            from   customer_address a
            where  a.rowid = (select min(ca.rowid) keep (dense_rank first order by ca.type_id)
                              from   customer_address ca
                              where  ca.rnk = p_customer_id);
        else
            select *
            into   l_address_row
            from   customer_address a
            where  a.rnk = p_customer_id and
                   a.type_id = p_address_type;
        end if;

        return l_address_row;
    exception
        when no_data_found then
             return null;
    end;

    function get_customer_address_line(
        p_customer_id in integer,
        p_address_type in integer default null)
    return varchar2
    is
        l_address_row customer_address%rowtype;
    begin
        l_address_row := get_customer_address_row(p_customer_id, p_address_type);

        if (l_address_row.rnk is null) then
            return null;
        end if;

        return trim(l_address_row.zip || ' ' ||
                    l_address_row.domain || ' ' ||
                    l_address_row.region || ' ' ||
                    l_address_row.locality || ' ' ||
                    l_address_row.address);
    end;

    function get_element(
        p_customer_id in integer,
        p_element_code in varchar2)
    return varchar2
    is
        l_value varchar2(4000 byte);
    begin
        select c.value
        into   l_value
        from   customerw c
        where  c.rnk = p_customer_id and
               c.tag = p_element_code;

        return l_value;
    exception
        when no_data_found then
             return null;
    end;

    function get_customer_mobile_phone(
        p_customer_id in integer)
    return varchar2
    is
    begin
        return get_element(p_customer_id, customer_utl.TAG_MAIN_MOBILE_PHONE);
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/customer_utl.sql =========*** End **
 PROMPT ===================================================================================== 
 