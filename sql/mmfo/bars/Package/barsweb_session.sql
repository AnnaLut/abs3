
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/barsweb_session.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARSWEB_SESSION is

  -- Company : UNITY-BARS
  -- Author  : OLEG
  -- Created : 17/10/2007 15:24:49
  -- Purpose : Пакет процедур для обслуживания состояния ceccии веб-браузера

  ----
  -- global vars
  --
  g_headerVersion constant varchar2(64)  := 'version 1.02 27.11.2007';

    ----
  -- Функция возвращает строку с версией заголовка пакета
  --
  function header_version return varchar2;

  ----
  -- Функция возвращает строку с версией тела пакета
  --
  function body_version return varchar2;

  ----
  -- функция возвращает SessionID web-browsera
  --
  function session_id return barsweb_session_data.session_id%type;

  ----
  -- процедура устанавливает SessionID web-browsera
  --
  -- @p_session_id - id сессии web-browsera
  --
  procedure set_session_id(p_session_id  barsweb_session_data.session_id%type);

  ----
  -- возвращает 0/1 - признак установленной веб-сессии
  --
  function is_session_established return integer;

  ----
  -- Процедура чистки данных сессии для текущего пользователя
  --
  procedure clean_up;

  ----
  -- Процедуа чистки данных сессии для job-а
  --
  procedure clean_up_job;

  ----
  -- функция возвращает значение переменной сессии в формате varchar2
  --
  -- @p_name: имя переменной
  --
  function get_varchar2(p_name in barsweb_session_data.var_name%type) return varchar2;

  ----
  -- функция возвращает значение переменной сессии в формате number
  --
  -- @p_name: имя переменной
  --
  function get_number(p_name in barsweb_session_data.var_name%type) return number;

  ----
  -- функция возвращает значение переменной сессии в формате date
  --
  -- @p_name: имя переменной
  --
  function get_date(p_name in barsweb_session_data.var_name%type) return date;

  ----
  -- Функция устанавливает значение переменной типа varchar2
  --
  procedure set_varchar2(
    p_name in barsweb_session_data.var_name%type,
    p_value in barsweb_session_data.var_value%type
  );

  ----
  -- Функция устанавливает значение переменной типа number
  --
  procedure set_number(
    p_name in barsweb_session_data.var_name%type,
    p_value in number
  );

  ----
  -- Функция устанавливает значение переменной типа date
  --
  procedure set_date(
    p_name in barsweb_session_data.var_name%type,
    p_value in date
  );

end barsweb_session;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARSWEB_SESSION is

  ----
  -- global vars
  --
  g_session_id barsweb_session_data.session_id%type;
  g_number_format_model varchar2(63) := '9999999999999999999999999999999D9999999999999999999999999999999';
  g_numeric_characters varchar2(31) := 'NLS_NUMERIC_CHARACTERS = ''. ''';
  g_date_format varchar2(21) := 'dd.mm.yyyy hh24:mi:ss';
  g_session_id_isnull varchar2(50) := 'Web-session ID is null';
  g_user_identifer_isnull varchar2(50) := 'CLIENT_IDENTIFIER is null';

  g_bodyVersion   constant varchar2(64)  := 'version 1.02 26.11.2007';

  ----
  -- Функция возвращает cтроку c верcией заголовка пакета
  --
  function header_version return varchar2
  is
  begin
      return 'package header BARSWEB_SESSION ' || g_headerVersion;
  end header_version;

  ----
  -- Функция возвращает cтроку c верcией тела пакета
  --
  function body_version return varchar2
  is
  begin
      return 'package body BARSWEB_SESSION ' || g_bodyVersion;
  end body_version;

  ----
  -- Функция возвращает SessionID web-browsera
  --
  function session_id return barsweb_session_data.session_id%type is
  begin
    if g_session_id is null then
      raise_application_error(-20001, g_session_id_isnull);
    end if;
    return g_session_id;
  end;

  ----
  -- Процедура устанавливает SessionID web-browsera
  --
  -- @p_session_id - id сессии web-browsera
  --
  procedure set_session_id(p_session_id  barsweb_session_data.session_id%type) is
  begin
    if p_session_id is null then
      raise_application_error(-20001, g_session_id_isnull);
    end if;
    g_session_id := p_session_id;
  end;

  ----
  -- возвращает 0/1 - признак установленной веб-сессии
  --
  function is_session_established return integer is
  begin
    if g_session_id is null then
        return 0;
    else
        return 1;
    end if;
  end is_session_established;

  ----
  -- Возвращает текущий пользовательский идентификатор
  --
  function get_staff_id return number is
    l_staff_id varchar2(4000);
  begin
    l_staff_id :=  user_id;
    if l_staff_id is null then
      raise_application_error(-20002, g_user_identifer_isnull);
    end if;
    return l_staff_id;
  end;

  ----
  -- Процедура вставки/обновления данных сессии
  --
  -- @p_var_name - имя переменной
  -- @p_val_str - значение переменной (varchar2)
  -- @p_val_date - значение переменной (date)
  -- @p_val_number - значение переменной (number)
  --
  procedure ins_or_upd(
    p_var_name in barsweb_session_data.var_name%type,
    p_var_value in barsweb_session_data.var_value%type
  ) is
    l_staff_id number;
    l_session_id barsweb_session_data.session_id%type;
  begin

    l_staff_id :=  get_staff_id;
    l_session_id := barsweb_session.session_id;

    update barsweb_session_data set
      var_value = p_var_value,
      modified = sysdate
    where session_id = l_session_id
      and var_name = p_var_name
      and staff_id = l_staff_id;

    if sql%rowcount = 0 then

      insert into barsweb_session_data
        (staff_id, session_id, var_name, var_value, modified)
      values
        (l_staff_id, l_session_id, p_var_name, p_var_value, sysdate);

    end if;

  end;

  ----
  -- Процедура чистки данных сессии
  --
  procedure clean_up is
  l_staff_id number;
  l_session_id barsweb_session_data.session_id%type;
  begin
    l_staff_id := get_staff_id;
    l_session_id := barsweb_session.session_id;
     -- удаляем все для текущего пользователя и идентификатора сессии
    delete from barsweb_session_data where session_id=l_session_id and staff_id=l_staff_id;
  end;

  ----
  -- Процедура чистки данных сессии
  --
  procedure clean_up_job is
  begin
    -- удаляем данные, которые не обновлялись на протяжении суток
    delete from barsweb_session_data where modified <= sysdate - 1;
  end;

  ----
  -- функция возвращает значение переменной сессии в формате varchar2
  --
  -- @p_name - имя переменной
  --
  function get_varchar2(p_name in  barsweb_session_data.var_name%type) return varchar2 is
    l_staff_id number;
    l_session_id barsweb_session_data.session_id%type;
    l_res barsweb_session_data.var_value%type;
  begin

    l_staff_id := get_staff_id;
    l_session_id := barsweb_session.session_id;

    select d.var_value
      into l_res
      from barsweb_session_data d
     where d.session_id = l_session_id
       and d.staff_id = l_staff_id
       and d.var_name = p_name;

     return l_res;

  exception when no_data_found then
    return null;
  end;

  ----
  -- функция возвращает значение переменной сессии в формате date
  --
  -- @p_name: имя переменной
  --
  function get_date(p_name in barsweb_session_data.var_name%type) return date is
  begin
    return to_date(get_varchar2(p_name), g_date_format);
  end;

  ----
  -- функция возвращает значение переменной сессии в формате number
  --
  -- @p_name: имя переменной
  --
  function get_number(p_name in barsweb_session_data.var_name%type) return number is
  begin
    return to_number(get_varchar2(p_name),g_number_format_model, g_numeric_characters);
  end;

  ----
  -- Функция устанавливает значение переменной типа varchar2
  --
  -- p_name - имя переменной
  -- p_value - значение переменной
  --
  procedure set_varchar2(
    p_name in barsweb_session_data.var_name%type,
    p_value in barsweb_session_data.var_value%type
  ) is
  begin
    ins_or_upd(p_name, p_value);
  end;

  ----
  -- Функция устанавливает значение переменной типа number
  --
  -- p_name - имя переменной
  -- p_value - значение переменной
  --
  procedure set_number(
    p_name in barsweb_session_data.var_name%type,
    p_value in number
  ) is
  begin
    ins_or_upd(p_name, to_char(p_value, g_number_format_model, g_numeric_characters));
  end;

  ----
  -- Функция устанавливает значение переменной типа date
  --
  -- p_name - имя переменной
  -- p_value - значение переменной
  --
  procedure set_date(
    p_name in barsweb_session_data.var_name%type,
    p_value in date
  ) is
  begin
    ins_or_upd(p_name, to_char(p_value, g_date_format));
  end;

begin
  -- initialization
  g_session_id := null;
end barsweb_session;
/
 show err;
 
PROMPT *** Create  grants  BARSWEB_SESSION ***
grant EXECUTE                                                                on BARSWEB_SESSION to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARSWEB_SESSION to BASIC_INFO;
grant EXECUTE                                                                on BARSWEB_SESSION to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/barsweb_session.sql =========*** End
 PROMPT ===================================================================================== 
 