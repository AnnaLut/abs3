create or replace package json_utl is

    function make_json_value(
        p_key in varchar2,
        p_value in varchar2,
        p_mandatory in boolean default false)
    return varchar2;

    function make_json_string(
        p_key in varchar2,
        p_string in varchar2,
        p_mandatory in boolean default false)
    return varchar2;

    function make_json_date(
        p_key in varchar2,
        p_date in date,
        p_mandatory in boolean default false)
    return varchar2;

    function make_json_date_time(
        p_key in string,
        p_date_time in date,
        p_mandatory in boolean default false)
    return varchar2;

    function base64url_to_string(
        p_base64url in clob)
    return clob;
end;
/
create or replace package body json_utl as

    function make_json_value(
        p_key in varchar2,
        p_value in varchar2,
        p_mandatory in boolean default false)
    return varchar2
    is
    begin
        if (p_value is null) then
            return case when p_mandatory then '"' || p_key || '": null' else null end;
        end if;

        return '"' || p_key || '": ' || p_value;
    end;

    function make_json_string(
        p_key in varchar2,
        p_string in varchar2,
        p_mandatory in boolean default false)
    return varchar2
    is
    begin
        if (p_string is null) then
            return make_json_value(p_key, p_string, p_mandatory);
        else
            return make_json_value(p_key, '"' || replace(p_string, '"', '\"') || '"', p_mandatory);
            -- return make_json_value(p_key, '"' || replace(p_string, '"', '') || '"', p_mandatory);
        end if;
    end;

    function make_json_integer(
        p_key in varchar2,
        p_string in integer,
        p_mandatory in boolean default false)
    return varchar2
    is
    begin
        return make_json_value(p_key, replace(p_string, '"', '\"'), p_mandatory);
    end;

    function make_json_date(
        p_key in varchar2,
        p_date in date,
        p_mandatory in boolean default false)
    return varchar2
    is
    begin
        if (p_date is null) then
            return make_json_value(p_key, p_date, p_mandatory);
        else
            return make_json_value(p_key, '"' || to_char(p_date, 'yyyy-mm-dd') || '"', p_mandatory);
        end if;
    end;

    function make_json_date_time(
        p_key in string,
        p_date_time in date,
        p_mandatory in boolean default false)
    return varchar2
    is
    begin
        return make_json_value(p_key, '"' || replace(to_char(p_date_time, 'yyyy-mm-dd hh24:mi:ss'), ' ', 'T') || '"', p_mandatory);
    end;

    function base64url_to_string(
        p_base64url in clob)
    return clob
    is
        l_raw raw(2000);
        l_string clob;
        l_base64_string varchar2(32767 byte);
        l_blob blob;
        -- l_clob clob;
    begin
        if (p_base64url is null) then
            return null;
        end if;

        l_base64_string := translate(p_base64url, '-_', '+/');
        l_base64_string := rpad(l_base64_string, 4 * ceil(length(l_base64_string) / 4), '=');

        l_blob := bars.lob_utl.decode_base64(l_base64_string);
        
        l_string := bars.lob_utl.blob_to_clob(l_blob);
        l_string := convert(l_string, 'CL8MSWIN1251', 'AL32UTF8');
        -- l_raw := utl_encode.base64_decode(p_base64url);
        -- l_string := utl_raw.cast_to_varchar2(l_raw);
        return l_string; -- l_string;
    end;
end;
/
