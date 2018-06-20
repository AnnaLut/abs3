PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/crypto_utl.sql =========*** Run *** 
PROMPT ===================================================================================== 

CREATE OR REPLACE PACKAGE BARS.CRYPTO_UTL is

  -- Author  : VITALII.KHOMIDA
  -- Created : 04.06.2016 11:21:53
  -- Purpose :
  g_header_version constant varchar2(64) := 'version 1.00 04/06/2016';
  g_header_defs    constant varchar2(512) := '';

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  function create_keytype(p_name in varchar2, p_code in varchar2)return number;

  procedure create_key(p_key_value  in varchar2,
                       p_start_date in date,
                       p_end_date   in date,
                       p_code       in varchar2);

  procedure edit_key(p_key_id   in number,
                     p_end_date in date);

  procedure disable_key(p_key_id in number);

  function get_key_value(p_bday     in date,
                         p_code     in varchar2,
                         p_previous in boolean default false) return varchar2;

  function check_mac_sh1(p_src     in varchar2,
                         p_key     in varchar2,
                         p_sign    in raw,
                         p_charset in varchar2 default null) return boolean;
  function check_mac_sh1(p_src     in clob,
                         p_key     in varchar2,
                         p_sign    in raw,
                         p_charset in varchar2 default null)return boolean;

end crypto_utl;
/

show errors;

CREATE OR REPLACE PACKAGE BODY BARS.CRYPTO_UTL is

  g_body_version constant varchar2(64) := 'version 1.00 04/06/2016';
  g_body_defs    constant varchar2(512) := '';

  -------------------------------------------------------------------------------
  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2 is
  begin
    return 'Package header crypto_utl ' || g_header_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_header_defs;
  end header_version;

  -------------------------------------------------------------------------------
  -- body_version - возвращает версию тела пакета
  function body_version return varchar2 is
  begin
    return 'Package body crypto_utl ' || g_body_version || '.' || chr(10) || 'AWK definition: ' || chr(10) || g_body_defs;
  end body_version;

  function create_keytype(p_name in varchar2, p_code in varchar2) return number is
    l_id number;
  begin
    insert into keytypes
      (id, name, code)
    values
      (s_keytypes.nextval, p_name, p_code)
    returning id into l_id;

    return l_id;
  end;
  function get_keytypeid(p_code in varchar2) return number is
    l_id number;
  begin
    select id
      into l_id
      from keytypes t
     where upper(t.code) = upper(p_code);
    return l_id;
  exception
    when no_data_found then
      l_id := null;
      return l_id;

  end;
  procedure create_key(p_key_value  in varchar2,
                       p_start_date in date,
                       p_end_date   in date,
                       p_code       in varchar2) is
    l_h          varchar2(100) := 'crypto_utl.create_sign. ';
    l_start_date date := p_start_date;
    l_key_id     number;
    l_count      pls_integer;
    l_id         number := get_keytypeid(p_code);
  begin
    if l_start_date is null then
      l_start_date := sysdate;
    end if;

    if p_end_date is null then
      raise_application_error(-20000,
                              'Не задано термін дії ключа');
    end if;
    select count(*)
      into l_count
      from ow_keys t
     where (l_start_date between t.start_date and t.end_date or
           p_end_date between t.start_date and t.end_date) and
           t.is_active = 'Y' and t.type = l_id;

    if l_count > 0 then
      raise_application_error(-20000,
                              'Термін дії ключа пересікається з поточним');
    end if;
    if p_start_date >= p_end_date then
      raise_application_error(-20000,
                              'Термін закінчення ключа має бути більшим ніж термін початку дії ключа');
    end if;

    insert into ow_keys
      (key_id, key_value, start_date, end_date, type)
    values
      (s_ow_keys.nextval, p_key_value, trim(l_start_date), trim(p_end_date), l_id)
    returning key_id into l_key_id;

    bars_audit.info(l_h || 'Створено ключ з ідентифікатором ' ||
                    p_key_value);
  end;

  procedure edit_key(p_key_id   in number,
                     p_end_date in date) is
    l_h varchar2(100) := 'crypto_utl.edit_key. ';
  begin
    bars_audit.info(l_h || 'p_key_id => ' || p_key_id || ' p_end_date=> ' ||
                    p_end_date);

    if p_end_date < trunc(sysdate) then
      raise_application_error(-20000,
                              'Термін закінчення дії ключа менше поточної дати.');
    end if;
    update ow_keys t set t.end_date = p_end_date where t.key_id = p_key_id;
  end;

  procedure disable_key(p_key_id in number) is
    l_h varchar2(100) := 'crypto_utl.edit_key. ';
  begin
    bars_audit.info(l_h || 'p_key_id => ' || p_key_id || ' was disable');

    update ow_keys t set t.is_active = 'N' where t.key_id = p_key_id;
  end;

-- get_key_value
-- функция получения ключа.
function get_key_value(p_bday     in date,
                       p_code     in varchar2,
                       p_previous in boolean default false) return varchar2 is
  l_key_value ow_keys.key_value%type;
  l_id number;
begin
  l_id := get_keytypeid(p_code);
  if p_previous then
    select key_value
      into l_key_value
      from (select t.key_value, row_number() over(order by t.key_id desc) rn
               from ow_keys t
              where p_bday between t.start_date and t.end_date and
                    t.type = l_id)
     where rn = 1;
  else
    select t.key_value
      into l_key_value
      from ow_keys t
     where p_bday between t.start_date and t.end_date and t.is_active = 'Y' and
           t.type = l_id;
  end if;
  return l_key_value;
exception
  when no_data_found then
    l_key_value := null;
    return l_key_value;
end;

function check_mac_sh1(p_src     in varchar2,
                       p_key     in varchar2,
                       p_sign    in raw,
                       p_charset in varchar2 default null) return boolean is
  l_mac raw(4000);
begin
  l_mac := dbms_crypto.mac(src => utl_i18n.string_to_raw(p_src, p_charset),
                           typ => dbms_crypto.hmac_sh1,
                           key => utl_i18n.string_to_raw(p_key, p_charset));
  if l_mac = p_sign then
    return true;
  else
    return false;
  end if;
end;

function check_mac_sh1(p_src     in clob,
                       p_key     in varchar2,
                       p_sign    in raw,
                       p_charset in varchar2 default null) return boolean is
  l_mac raw(4000);
  l_src varchar2(32);
  l_scr clob;
begin
  l_mac := dbms_crypto.mac(src => l_scr,
                           typ => dbms_crypto.hmac_sh1,
                           key => utl_i18n.string_to_raw(p_key, p_charset));
  if l_mac = p_sign then
    return true;
  else
    return false;
  end if;
end;

end crypto_utl;
/

show err;

PROMPT *** Create  grants  CRYPTO_UTL ***

grant EXECUTE on CRYPTO_UTL to PFU;
grant EXECUTE on CRYPTO_UTL to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/crypto_utl.sql =========*** End *** 
PROMPT ===================================================================================== 
