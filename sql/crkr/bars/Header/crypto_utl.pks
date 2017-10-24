create or replace package crypto_utl is

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