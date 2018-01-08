
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/CDB/package/cdb_currency.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE CDB.CDB_CURRENCY is

    function read_currency(
        p_id in integer,
        p_raise_ndf in boolean default true)
    return currency%rowtype;

    procedure register_currency(
        p_id in integer,
        p_iso_code in varchar2,
        p_name in varchar2);

end;
/
CREATE OR REPLACE PACKAGE BODY CDB.CDB_CURRENCY as

    function read_currency(
        p_id in integer,
        p_raise_ndf in boolean default true)
    return currency%rowtype
    is
        l_currency_row currency%rowtype;
    begin
        select *
        into   l_currency_row
        from   currency c
        where  c.id = p_id;

        return l_currency_row;
    exception
        when no_data_found then
             if (p_raise_ndf) then
                raise_application_error(cdb_exception.NO_DATA_FOUND, 'Валюта з ідентифікатором {' || p_id || '} не знайдена');
             else return null;
             end if;
    end;

    procedure register_currency(p_id in integer, p_iso_code in varchar2, p_name in varchar2)
    is
        l_currency_row currency%rowtype;
    begin
        l_currency_row := read_currency(p_id, p_raise_ndf => false);
        if (l_currency_row.id is null) then
            insert into currency
            values (p_id, p_iso_code, p_name);
        else
            update currency c
            set    c.iso_code = p_iso_code,
                   c.name = p_name
            where  c.id = p_id;
        end if;
    end;
end;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/CDB/package/cdb_currency.sql =========*** End ***
 PROMPT ===================================================================================== 
 