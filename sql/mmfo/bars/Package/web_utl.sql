
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/web_utl.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.WEB_UTL 
is

G_HEADER_VERSION   constant varchar2(64)  := 'version 2.4 04.12.2013';
G_AWK_HEADER_DEFS  constant varchar2(512) := '';


-------------------------------------------------------------------
-- GET_USER_MARK()
--
-- Возвращает тип пользователя в виде числа (уровень привилегированности)
--
function get_user_mark return staff_class.mark%type;

-------------------------------------------------------------------
-- CAN_USER_CHANGE_DATE()
--
-- Возвращает 0/1 - флаг разрешения работы в нескольких банковских днях
--
function can_user_change_date return integer;


-------------------------------------------------------------------
-- GET_USER_FULLNAME()
--
--  Функция возвращает имя пользователя BARS
--
function get_user_fullname return staff.fio%type;


-------------------------------------------------------------------
-- GET_BANKDATE()
--
--  Функция возвращает локальную банковскую дату
--
function get_bankdate return date;

-------------------------------------------------------------------
-- GET_LOCALDATE()
--
--  Функция возвращает локальную банковскую дату
function get_localdate return date;

-------------------------------------------------------------------
-- SET_LOCALDATE()
--
--  Процедура устанавливает локальную дату для пользователя
--
procedure set_localdate(p_dt date);


-------------------------------------------------------------------
-- set_localdate_as_global()
--
--  Процедура устанавливает локальную дату для пользователя
--  равной значению глобальной даты
--
procedure set_localdate_as_global;


-------------------------------------------------------------------
-- IS_BANKDATE_OPEN
--
--  Функция возвращает 0/1 - признак закрыт/открыт банковский день
--
--
function is_bankdate_open return int;

-------------------------------------------------------------------
-- IS_BANKDATE_ACCESSIBLE
--
--  Функция возвращает 0/1 - признак доступности банковского дня для пользователя
--
function is_bankdate_accessible(p_dt date) return int;

------------------------------------------------------------------
-- CHECK_USER_ACCESS_FOR_PAGE()
--
--  Функция проверки заданого url на допустимость
--  для текущего пользователя, возвращает 0 (не разрешено) или 1 (разрешено)
--
function check_user_access_for_page (str_page varchar, str_query varchar )  return number;

------------------------------------------------------------------
-- IS_ROLE_GRANTED()
--
--  Функция проверки наличия указаной роли для текущего пользователя
--  возвращает 0 (не выдана) или 1 (выдана)
--
--  @p_role - имя проверяемой роли
--
function is_role_granted(p_role in varchar2) return number;

-------------------------------------------------------------------
-- SET_USER_CHANGEDATE()
--
--  Процедура устанавливает дату последнего изменения пароля пользователя
--
procedure set_user_changedate(p_webuser varchar, p_dt date);

-------------------------------------------------------------------
-- ADD_USER_ATEMPT()
--
--  Процедура увеличивает количество попыток неправильно введеного пароля
--
procedure add_user_atempt(p_webuser varchar);

-------------------------------------------------------------------
-- CLEAR_USER_ATEMPT()
--
--  Процедура сбрасывает количество попыток неправильно введеного пароля
--
procedure clear_user_atempt(p_webuser varchar);

-------------------------------------------------------------------
-- BLOCK_USER()
--
--  Процедура увеличивает количество попыток неправильно введеного пароля
--
procedure block_user(p_webuser varchar);

-------------------------------------------------------------------
-- CHANGE_PASSWORD()
--
--  Процедура меняет пароль пользователя в вебе
--
procedure change_password(p_webuser varchar, p_pswhash varchar);

--------------------------------------------------------
-- IS_WEB_USER()
--
--     Функція повертає 1 - якщо користувач є користувачем веб
--                      0 - якщо ні
--
function is_web_user return number;

------------------------------------------------------------------
-- SET_HOST_DATA()
--
--  устанавливает данные хоста
--
procedure set_host_data(p_host_data in varchar2);

--------------------------------------------------------
-- HEADER_VERSION()
--
--     Функция возвращает строку с версией заголовка пакета
--
function header_version return varchar2;

--------------------------------------------------------
-- BODY_VERSION()
--
--     Функция возвращает строку с версией тела пакета
--
function body_version return varchar2;

end;
/
CREATE OR REPLACE PACKAGE BODY BARS.WEB_UTL 
is


G_BODY_VERSION   constant varchar2(64)  := 'version 2.11 04.12.2013';
G_AWK_BODY_DEFS  constant varchar2(512) := '';

g_user_mark         staff_class.mark%type;
g_cucd_flag         integer;                -- can_user_change_date flag
g_host_data         varchar2(1024);

-------------------------------------------------------------------
-- get_user_mark()
--
-- Возвращает тип(класс) пользователя в виде числа (уровень привилегированности)
--
function get_user_mark return staff_class.mark%type
is
begin
  if g_user_mark is null then
    select mark into g_user_mark from staff_class where clsid=(select nvl(clsid,0) from staff$base where id=user_id);
  end if;
  return g_user_mark;
end get_user_mark;

-------------------------------------------------------------------
-- CAN_USER_CHANGE_DATE()
--
-- Возвращает 0/1 - флаг разрешения работы в нескольких банковских днях
--
function can_user_change_date return integer
is
    l_threshold  number;
begin
  if g_cucd_flag is null then
    select to_number(val) into l_threshold from params where par='MARKDATE';
    if web_utl.get_user_mark >= l_threshold then
        g_cucd_flag := 1;
    else
        g_cucd_flag := 0;
    end if;
  end if;
  return g_cucd_flag;
end can_user_change_date;

-------------------------------------------------------------------
-- GET_USER_FULLNAME()
--
--
function get_user_fullname return staff.fio%type
is
   l_user_fullname   staff.fio%type;
begin
   select fio  into l_user_fullname from staff$base where id=user_id;
   return l_user_fullname;
end get_user_fullname;

-------------------------------------------------------------------
-- GET_BANKDATE()
--
--  Функция возвращает локальную банковскую дату
function get_bankdate return date
is
begin
  return gl.bd;
end get_bankdate;

-------------------------------------------------------------------
-- GET_LOCALDATE()
--
--  Функция возвращает локальную банковскую дату
function get_localdate return date
is
begin
  return gl.bd;
end get_localdate;

-------------------------------------------------------------------
-- SET_LOCALDATE()
--
--  Процедура устанавливает локальную дату для пользователя
--
procedure set_localdate(p_dt date) is
begin
    gl.pl_dat(p_dt);
end set_localdate;

-------------------------------------------------------------------
-- set_localdate_as_global()
--
--  Процедура устанавливает локальную дату для пользователя
--  равной значению глобальной даты
--
procedure set_localdate_as_global is
begin
    set_localdate(bankdate_g);
end;

-------------------------------------------------------------------
-- IS_BANKDATE_OPEN
--
--  Функция возвращает 0/1 - признак закрыт/открыт банковский день
--
function is_bankdate_open return int
is
l_open   number;
l_bdg    date;    /* глобальная банковская дата */
l_cucd   number;  /*  признак выбора банк. даты */
begin

    -- Смотрим на признак открытого банковского дня
    begin
        select to_number(val) into l_open from params where par= 'RRPDAY';
    exception
        when NO_DATA_FOUND then l_open := 1;
    end;

    -- DG: Если закрыт, то чтобы открыть тоже кто-то должен зайти
    -- Если закрыт, выходим
    -- if (l_open = 0) then return l_open;
    -- end if;

    -- Проверяем может ли польз. выбирать банк. дату
    begin
        select (case when c.mark >= p.val then 1 else 0 end) into l_cucd
          from staff$base s, staff_class c,
               (select to_number(val) val
                  from params$global
                 where par = 'MARKDATE') p
         where s.id      = user_id
           and c.clsid   = nvl(s.clsid, 0);
    exception
        when NO_DATA_FOUND then l_cucd := 0;
    end;

    if (l_cucd = 0) then

        -- Получаем глобальную банк. дату
        begin
            l_bdg := nvl(to_date(sys_context('bars_context', 'global_bankdate'), 'mm/dd/yyyy'), bankdate_g);
        exception
            when OTHERS then l_bdg := bankdate_g;
        end;

        -- Сравниваем локальную дату пользователя
        if (bankdate != bankdate_g) then
            return 0;
        end if;
   else
       l_open := 1;
   end if;

   return l_open;

end is_bankdate_open;


-------------------------------------------------------------------
-- IS_BANKDATE_ACCESSIBLE
--
--  Функция возвращает 0/1 - признак доступности банковского дня для пользователя
--
function is_bankdate_accessible(p_dt date) return int is
    l_accessible      int;
begin
    if can_user_change_date=0 then  -- пользователь не может менять дату?
        if p_dt=bankdate_g then
            -- спрашивают про текущую дату, читаем из params
            select to_number(val) into l_accessible from params where par='RRPDAY';
        else
            l_accessible := 0;   -- если дата изменилась, значит старая автоматом недоступна
        end if;
    else
        -- пользователь может работать в нескольких банковских днях ==> смотрим в FDAT
        begin
            select decode(stat,9,0,1) into l_accessible from fdat where fdat=p_dt;
        exception when no_data_found then
            l_accessible := 0;
        end;
    end if;
    return l_accessible;
end is_bankdate_accessible;

-- Получение признака повышенной/пониженной безопасности
function get_secure_state return number is
  l_value params.val%type;
begin
  select val into l_value from params where par = 'LOSECURE';

  if (l_value = '1') then
    return 0;
  end if;

  return 1;
end get_secure_state;

------------------------------------------------------------------
-- SET_HOST_DATA()
--
--  устанавливает данные хоста
--
procedure set_host_data(p_host_data in varchar2)
is
begin
  g_host_data := substr(p_host_data, 1, 1024);
end;

------------------------------------------------------------------
-- CHECK_USER_ACCESS_FOR_PAGE()
--
--  Функция проверки заданого url на допустимость
--  для текущего пользователя, возвращает 0 (не разрешено) или 1 (разрешено)
--
function check_user_access_for_page(str_page varchar, str_query varchar)
return number
is
    l_cnt   number; -- буфер
    l_usrid number; -- ид. текущего пользователя
    l_state number := get_secure_state;
    l_url varchar2(32767 byte) := str_page || str_query;
    l_functions number_list;
    l_parent_functions number_list;
    l_function_arms string_list;
    l_users number_list;
    l_user_arms string_list;
    l_result integer;
begin
    -- журналируем вызов функции
    bars_web_ui.select_function(l_url, g_host_data);

    if (getglobaloption('LOSECURE') = '1') then
        return 1;
    end if;

    -- Смотрим на общедоступные функции
    select count(*)
    into   l_cnt
    from   operlist_acspub t
    where  t.frontend = 1 and
           t.funcname like str_page || '%' and
           regexp_like(l_url, '^' || replace(t.funcname, '?', '\?') || '$');

    if (l_cnt != 0) then
        return 1;
    end if;

    select t.codeoper
    bulk collect into l_functions
    from   operlist t
    where  t.funcname like str_page || '%' and
           regexp_like(l_url, '^' || replace(t.funcname, '?', '\?') || '$', 'i');

    if (l_functions is empty) then
        bars_audit.info('web_utl.check_user_access_for_page' || chr(10) ||
                        'str_page  : ' || str_page  || chr(10) ||
                        'str_query : ' || str_query || chr(10) ||
                        'l_functions is empty');
        return 1;
        return 0;
    end if;

    select d.id_parent
    bulk collect into l_parent_functions
    from   operlist_deps d
    connect by nocycle d.id_parent = prior d.id_child
    start with d.id_child in (select column_value from table(l_functions));

    l_functions := l_functions multiset union distinct l_parent_functions;

    select t.codeapp
    bulk collect into l_function_arms
    from   operapp t
    where  t.codeoper in (select column_value from table(l_functions));

    if (l_function_arms is empty) then
        bars_audit.info('web_utl.check_user_access_for_page' || chr(10) ||
                        'str_page    : ' || str_page  || chr(10) ||
                        'str_query   : ' || str_query || chr(10) ||
                        'l_functions : ' || tools.number_list_to_string(l_functions) || chr(10) ||
                        'l_function_arms is empty');
        return 1;
        return 0;
    end if;

    l_usrid := user_id;

    select id_whom
    bulk collect into l_users
    from   staff_substitute
    where  id_who = l_usrid and
           date_is_valid(date_start, date_finish, null, null) = 1;

    l_users.extend(1);
    l_users(l_users.last) := l_usrid;

    select t.codeapp
    bulk collect into l_user_arms
    from   applist_staff t
    where  t.id in (select column_value from table(l_users));

    l_result := case when l_user_arms multiset intersect l_function_arms is empty then 0 else 1 end;
    if (l_result = 0) then
        bars_audit.info('web_utl.check_user_access_for_page' || chr(10) ||
                        'str_page        : ' || str_page  || chr(10) ||
                        'str_query       : ' || str_query || chr(10) ||
                        'l_functions     : ' || tools.number_list_to_string(l_functions) || chr(10) ||
                        'l_function_arms : ' || tools.words_to_string(l_function_arms, p_ceiling_length => 2000) || chr(10) ||
                        'l_users         : ' || tools.number_list_to_string(l_users) || chr(10) ||
                        'l_user_arms     : ' || tools.words_to_string(l_user_arms, p_ceiling_length => 2000) || chr(10) ||
                        'case when l_user_arms multiset intersect l_function_arms is empty');
    end if;

    return 1;
    return l_result;
end check_user_access_for_page;


------------------------------------------------------------------
-- IS_ROLE_GRANTED()
--
--  Функция проверки наличия указаной роли для текущего пользователя
--  возвращает 0 (не выдана) или 1 (выдана)
--
--  @p_role - имя проверяемой роли
--

function is_role_granted(p_role in varchar2) return number is
  l_role user_role_privs.granted_role%type;
begin
  select /*+ FIRST_ROWS(1)*/
        granted_role
   into l_role
   from user_role_privs
  where granted_role = upper(p_role)
    and rownum=1;
  return 1;
exception when no_data_found then
  return 0;
end is_role_granted;

-------------------------------------------------------------------
-- SET_USER_CHANGEDATE()
--
--  Процедура устанавливает дату последнего изменения пароля пользователя
--
procedure set_user_changedate(p_webuser varchar, p_dt date)
is
begin
   update web_usermap set chgdate = p_dt where webuser = p_webuser;
end;

-------------------------------------------------------------------
-- ADD_USER_ATEMPT()
--
--  Процедура увеличивает количество попыток неправильно введеного пароля
--
procedure add_user_atempt(p_webuser varchar)
is
begin
   update web_usermap set attempts = attempts + 1 where webuser = p_webuser;
end;

-------------------------------------------------------------------
-- CLEAR_USER_ATEMPT()
--
--  Процедура сбрасывает количество попыток неправильно введеного пароля
--
procedure clear_user_atempt(p_webuser varchar)
is
begin
   update web_usermap set attempts = 0 where webuser = p_webuser;
end;

-------------------------------------------------------------------
-- BLOCK_USER()
--
--  Процедура увеличивает количество попыток неправильно введеного пароля
--
procedure block_user(p_webuser varchar)
is
begin
   update web_usermap set blocked = 1 where webuser = p_webuser;
end;

-------------------------------------------------------------------
-- CHANGE_PASSWORD()
--
--  Процедура меняет пароль пользователя в вебе
--
procedure change_password(p_webuser varchar, p_pswhash varchar)
is
begin
   update web_usermap set webpass = p_pswhash, adminpass = null, attempts = 0, chgdate=sysdate where webuser = p_webuser;
end;

--------------------------------------------------------
-- IS_WEB_USER()
--
--     Функція повертає 1 - якщо користувач є користувачем веб
--                      0 - якщо ні
--
function is_web_user return number
is
begin
	return
		case upper(nvl(sys_context('userenv', 'proxy_user'), ' '))
	        when 'APPSERVER' then 1
	        else 0
	       end;
end;

-----------------------------------------------------------------
-- HEADER_VERSION()
--
--     Функция возвращает строку с версией заголовка пакета
--
function header_version return varchar2
is
begin
    return 'package header WEB_UTL ' || G_HEADER_VERSION || chr(10) ||
           'package header definition(s):' || chr(10) || G_AWK_HEADER_DEFS;
end header_version;

-----------------------------------------------------------------
-- BODY_VERSION()
--
--     Функция возвращает строку с версией тела пакета
--
function body_version return varchar2
is
begin
    return 'package body WEB_UTL ' || G_BODY_VERSION || chr(10) ||
           'package body definition(s):' || chr(10) || G_AWK_BODY_DEFS;
end body_version;

end;
/
 show err;
 
PROMPT *** Create  grants  WEB_UTL ***
grant EXECUTE                                                                on WEB_UTL         to ABS_ADMIN;
grant EXECUTE                                                                on WEB_UTL         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on WEB_UTL         to BASIC_INFO;
grant EXECUTE                                                                on WEB_UTL         to WEBTECH;
grant EXECUTE                                                                on WEB_UTL         to WR_ADMIN;
grant EXECUTE                                                                on WEB_UTL         to WR_ALL_RIGHTS;
grant EXECUTE                                                                on WEB_UTL         to WR_CBIREP;
grant EXECUTE                                                                on WEB_UTL         to WR_CHCKINNR_ALL;
grant EXECUTE                                                                on WEB_UTL         to WR_CHCKINNR_CASH;
grant EXECUTE                                                                on WEB_UTL         to WR_CHCKINNR_SELF;
grant EXECUTE                                                                on WEB_UTL         to WR_CHCKINNR_SUBTOBO;
grant EXECUTE                                                                on WEB_UTL         to WR_CHCKINNR_TOBO;
grant EXECUTE                                                                on WEB_UTL         to WR_CREDIT;
grant EXECUTE                                                                on WEB_UTL         to WR_DOCVIEW;
grant EXECUTE                                                                on WEB_UTL         to WR_DOC_INPUT;
grant EXECUTE                                                                on WEB_UTL         to WR_IMPEXP;
grant EXECUTE                                                                on WEB_UTL         to WR_VERIFDOC;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/web_utl.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 