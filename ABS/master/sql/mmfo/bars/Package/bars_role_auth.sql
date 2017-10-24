
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_role_auth.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_ROLE_AUTH authid current_user
is

    --*************************************************************--
    --                                                             --
    --                                                             --
    --            Пакет управления ролями комплекса                --
    --                                                             --
    --                                                             --
    --*************************************************************--


    -------------------------------------------------------
    -- Константы                                         --
    -------------------------------------------------------

    VERSION_HEADER       constant varchar2(64)  := 'version 1.01 10.09.2007';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';



    --------------------------------------------------------
    -- GET_ROLE_DATA()
    --
    --     Функция получения данных для установки
    --     защищенной роли
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    function get_role_data(
                 p_role   in  varchar2 ) return varchar2;

    --------------------------------------------------------
    -- SET_ROLE_BY_DATA()
    --
    --     Установка защищенной роли
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    procedure set_role_by_data(
                  p_roledata   in  varchar2 );

    --------------------------------------------------------
    -- SET_ROLE()
    --
    --     Установка незащищенной роли
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    procedure set_role(
                  p_role   in  varchar2 );

    --------------------------------------------------------
    -- INTERNAL_()
    --
    --     Внутренняя процедура получения данных
    --
    --     Параметры:
    --
    --         p_buf1   Буфер 1
    --
    --         p_buf2   Буфер 2
    --
    function internal_(
                 p_buf1   in  varchar2,
                 p_buf2   in  varchar2 ) return varchar2;

    --------------------------------------------------------
    -- SET_ROLE_INT()
    --
    --     Внутренняя процедура установки роли
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    procedure set_role_int(
                  p_role   in  varchar2 );

    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция получения версии заголовка пакета
    --
    --
    --
    function header_version return varchar2;

    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция получения версии тела пакета
    --
    --
    --
    function body_version return varchar2;


end bars_role_auth;
 
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_ROLE_AUTH 
is

    --*************************************************************--
    --                                                             --
    --                                                             --
    --            Пакет управления ролями комплекса                --
    --                                                             --
    --                                                             --
    --*************************************************************--


    -------------------------------------------------------
    -- Константы                                         --
    -------------------------------------------------------

    VERSION_BODY       constant varchar2(64)  := 'version 1.05 10.10.2007';
    VERSION_BODY_DEFS  constant varchar2(512) := '';

    -- Имя конфигурационного параметра
    PARAM_ROLEAUTH     constant params.par%type := 'ROLEAUTH';

    -- Признаки аутентификации
    AUTH_OFF           constant number          := 0;
    AUTH_ON            constant number          := 1;

    -- Признак аутентификации приложением
    APPAUTH_OFF        constant number          := 0;
    APPAUTH_ON         constant number          := 1;


    -- Тип аутентификации роли
    ROLEAUTH_NONE      constant number          := 0;
    ROLEAUTH_APP       constant number          := 1;

    -- Код модуля для ошибок и сообщений
    MODCODE            constant varchar2(3)     := 'SVC';


    -------------------------------------------------------
    -- Глобальные переменные                             --
    -------------------------------------------------------

    g_roleauth     number;         /* признак аутентификации ролей */
    g_roles        varchar2(4000); /*        список активный ролей */

    g_currrole     varchar2(30);   /*                  роль буфера */
    g_currbuf      varchar2(48);   /*       сгенерированные данные */



    --------------------------------------------------------
    -- IGET_ROLES()
    --
    --     Функция получения списка активный ролей
    --
    --
    --
    function iget_roles return varchar2
    is

    l_res   varchar2(4000); /* список активных ролей (через запятую) */

    begin

        for c in (select role
                    from session_roles)
        loop

            if (l_res is null) then
                l_res := ' ' || c.role || ' ';
            else
                l_res := l_res || ', ' || c.role || ' ';
            end if;

        end loop;

        return l_res;

    end iget_roles;



    --------------------------------------------------------
    -- ISET_ROLE()
    --
    --     Процедура установки роли (обычной, защищенной,
    --     приложения)
    --
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    procedure iset_role(
                 p_role   in  varchar2 )
    is

    l_authflag    roles$base.authenticated%type;    /*        признак аутен. роли */
    l_appflag     roles$base.application_role%type; /* признак аутен. приложением */

    begin

        bars_audit.trace('roleauth.isetrole: entry point par[0]=>%s', p_role);

        -- Флаги для роли
        begin
            select nvl(authenticated, 0), nvl(application_role, 0)
              into l_authflag, l_appflag
              from roles$base
             where role_name = p_role;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'ROLE_NOT_FOUND', p_role);
        end;

        bars_audit.trace('roleauth.isetrole: got role req [%s][%s]', to_char(l_authflag), to_char(l_appflag));

        -- Проверяем список активных ролей
        if (g_roles is null) then
            bars_audit.trace('roleauth.isetrole: getting active role list...');
            g_roles := iget_roles;
        end if;

        bars_audit.trace('roleauth.isetrole: role list exists. %s', g_roles);

        -- Проверяем вхождение устанавливаемой роли
        if (instr(g_roles, ' ' || p_role || ' ') != 0) then
            -- роль уже активна
            bars_audit.trace('roleauth.isetrole: role already set.');
        else
            if (g_roles is not null) then
                g_roles := g_roles || ',';
            end if;

            g_roles := g_roles || ' ' || p_role || ' ';
        end if;

        -- Проверяем установлена ли умолчательная роль START1
        if (nvl(instr(g_roles, ' START1 '), 0) = 0) then

                if (g_roles is null) then
                    g_roles := ' START1 ';
                else
                    g_roles := g_roles || ', START1 ';
                end if;

        end if;

        bars_audit.trace('roleauth.isetrole: role list=>%s', g_roles);

        -- Активируем
        dbms_session.set_role(g_roles);

    end iset_role;


    --------------------------------------------------------
    -- GET_ROLE_DATA()
    --
    --     Функция получения данных для установки
    --     защищенной роли
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    function get_role_data(
                 p_role   in  varchar2 ) return varchar2
    is

    l_role        varchar2(30);                     /* имя роли в верхнем регистре */
    l_authflag    roles$base.authenticated%type;    /*         признак аутен. роли */
    l_databuf     varchar2(2048);                   /*        сформированный буфер */
    l_datahash    varchar2(2048);                   /*      хэш от сформир. буфера */

    begin

        bars_audit.trace('roleauth.getroledt: entry point par[0]=>%s', p_role);

        -- Приводим к верхнему регистру
        l_role := upper(p_role);

        -- Получаем описание роли
        begin
            select nvl(authenticated, 0)  into l_authflag
              from roles$base
             where role_name = l_role;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'ROLE_NOT_FOUND', l_role);
        end;

        -- Сохраняем имя роли
        g_currrole := l_role;
        g_currbuf  := null;

        -- Формируем буфер при включенной аутент. и установленном флаге аутен. роли
        if (g_roleauth = AUTH_ON and l_authflag = AUTH_ON) then

            -- Формируем буфер
            l_databuf := l_role || to_char(current_timestamp) || user_id;

            -- Получаем хэш от буфера
            l_datahash := bars_role_int.get_hash_value(l_databuf,           999,  1024) ||
                          bars_role_int.get_hash_value(l_databuf || '09', 99999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '08', 89999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '07', 79999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '06', 69999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '0-', 59999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '04', 49999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '03', 39999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '02', 29999, 16384) ||
                          bars_role_int.get_hash_value(l_databuf || '01', 19999, 16384);

            -- Сохраняем хэш
            g_currbuf  := substr(rpad(l_datahash, 48, '0'), 1, 48);

        end if;

        return g_currbuf;

    end get_role_data;


    --------------------------------------------------------
    -- SET_ROLE_BY_DATA()
    --
    --     Установка защищенной роли
    --
    --     Параметры:
    --
    --         p_roledata   Буфер данных для роли
    --
    --
    procedure set_role_by_data(
                  p_roledata   in  varchar2 )
    is

    APP_PASSWD  constant  varchar2(24) := '-B857^H!3D#uL3_Ke$(!s)*S';

    l_roledata   varchar2(2048);

    begin

        bars_audit.trace('roleauth.setrolebydt: entry point par[0]=><wrapped>');

        -- Проверяем что был вызов get_role_data()
        if (g_currrole is null) then
            bars_error.raise_nerror(MODCODE, 'ROLEAUTH_INVALID_CALL', 'ROLE_NAME');
        end if;

        -- Проверяем переданный буфер при включенной аутен.
        if (g_roleauth = AUTH_ON) then

            -- Если внутренний буфер хэша пуст, значит роль без аутен.
            if (g_currbuf is not null) then

                if (p_roledata is null) then
                    bars_error.raise_nerror(MODCODE, 'ROLEAUTH_INVALID_CALL', 'ROLE_DATA_NULL');
                end if;

                if (p_roledata != substr(internal_(g_currbuf, APP_PASSWD), 1, 100)) then
                    bars_error.raise_nerror(MODCODE, 'ROLEAUTH_INVALID_CALL', 'ROLE_DATA');
                end if;

            end if;

        end if;

        bars_audit.trace('roleauth.setrolebydt: app roledata check compeleted.');

        -- Активируем роль
        iset_role(g_currrole);

    end set_role_by_data;









    --------------------------------------------------------
    -- SET_ROLE()
    --
    --     Установка незащищенной роли или роли приложения
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    procedure set_role(
                  p_role   in  varchar2 )
    is

    l_role        varchar2(30);                     /* имя роли в верхнем регистре */
    l_authflag    roles$base.authenticated%type;    /*         признак аутен. роли */

    begin

        -- Имя роли в верхний регистр
        l_role := upper(trim(p_role));

        -- Получаем описание роли
        begin
            select nvl(authenticated, 0) into l_authflag
              from roles$base
             where role_name = l_role;
        exception
            when NO_DATA_FOUND then
                bars_error.raise_nerror(MODCODE, 'ROLE_NOT_FOUND', l_role);
        end;

        -- Если включ. аутент. и установлен флаг. аутент роли
        if (g_roleauth = AUTH_ON and l_authflag = AUTH_ON) then

            -- приложение соединяется через proxy-пользователя
            if (nvl(sys_context('userenv', 'proxy_user'), ' ') != 'APPSERVER') then
                bars_error.raise_nerror(MODCODE, 'APPAUTH_REQUIRED', l_role);
            end if;

        end if;

        -- Устанавливаем роль
        iset_role(l_role);

    end set_role;


    --------------------------------------------------------
    -- INTERNAL_()
    --
    --     Внутренняя процедура получения данных
    --
    --     Параметры:
    --
    --         p_buf1   Буфер 1
    --
    --         p_buf2   Буфер 2
    --
    function internal_(
                 p_buf1   in  varchar2,
                 p_buf2   in  varchar2 ) return varchar2
    is
    l_res    varchar2(2048) := null;
    begin

        if (g_roleauth = AUTH_ON) then
            bars_role_int.encrypt(p_buf1, p_buf2, l_res);
        end if;

        return l_res;

    end internal_;



    --------------------------------------------------------
    -- SET_ROLE_INT()
    --
    --     Внутренняя процедура установки роли
    --
    --     Параметры:
    --
    --         p_role   Имя роли
    --
    --
    procedure set_role_int(
                  p_role   in  varchar2 )
    is

    l_dbname  global_name.global_name%type;

    begin

        -- Получаем имя базы
        select global_name  into l_dbname
          from global_name;

        -- Установка роли возможна только на внутренних базах
        if (substr(l_dbname, -10, 10) != 'BARS.LOCAL') then
            return;
        end if;

        -- Устанавливаем роль
        iset_role(p_role);

    end set_role_int;


    --------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция получения версии заголовка пакета
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_ROLE_AUTH ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):'  || chr(10) || VERSION_HEADER_DEFS;
    end header_version;


    --------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция получения версии тела пакета
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_ROLE_AUTH ' || VERSION_BODY || chr(10) ||
               'package body definition(s):'  || chr(10) || VERSION_BODY_DEFS;
    end body_version;


begin
    --
    -- Блок инициализации пакета
    --
    g_roleauth := bars_role_int.get_role_auth;

end bars_role_auth;
/
 show err;
 
PROMPT *** Create  grants  BARS_ROLE_AUTH ***
grant EXECUTE                                                                on BARS_ROLE_AUTH  to ABS_ADMIN;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to BARS_CONNECT;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to BASIC_INFO;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to PUBLIC;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to START1;
grant EXECUTE                                                                on BARS_ROLE_AUTH  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_role_auth.sql =========*** End 
 PROMPT ===================================================================================== 
 