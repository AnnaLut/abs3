
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_login.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_LOGIN 
is

/**
 *
 * Пакет BARS_LOGIN содержит процедуры, выполняемые после
 * входа пользователя в систему
 *
 **/

/**
    Макросы для банков:
    --
    Пусто       - Ощадбанк Облуправления (мульти-мфо)
 */

    VERSION_HEADER       constant varchar2(64)  := 'version 1.3 10.03.2011';
    VERSION_HEADER_DEFS  constant varchar2(512) := ''
                    ;

    -----------------------------------------------------------------
    -- Типы данных
    --
    --
    --
    subtype t_sess_clientid is varchar2(64);




    -----------------------------------------------------------------
    -- LOGIN_USER()
    --
    --     Процедура входа пользователя в комплекс
    --
    --
    procedure login_user(
                  p_sessionid  in  varchar2,
                  p_userid     in  number,
                  p_hostname   in  varchar2,
                  p_appname    in  varchar2 );


    procedure login_user(
        p_session_id in varchar2,
        p_login_name in varchar2,
        p_authentication_mode in varchar2,
        p_host_name in varchar2,
        p_application_name in varchar2);

    -----------------------------------------------------------------
    -- LOGOUT_USER()
    --
    --     Процедура выхода пользователя из комплекса
    --
    --
    procedure logout_user;


    -----------------------------------------------------------------
    -- SET_USER_SESSION()
    --
    --     Процедура инициализации пользовательской сессии
    --
    --
    procedure set_user_session(
                  p_sessionid  in  varchar2 );


    -----------------------------------------------------------------
    -- SET_USER_BANKDATE()
    --
    --     Установка банковской даты пользователя
    --
    --
    procedure set_user_bankdate(
                  p_bankdate  in  date );


    -----------------------------------------------------------------
    -- CHANGE_USER_APPSCHEMA()
    --
    --    Смена текущей схемы пользовательской сессии
    --
    --
    procedure change_user_appschema(
                  p_appschema varchar2 );


    -----------------------------------------------------------------
    -- GET_SESSION_CLIENTID()
    --
    --    Получение кл. идентификатора текущей сессии
    --
    --
    function get_session_clientid return t_sess_clientid;


    -----------------------------------------------------------------
    -- CLEAR_EXPIRED_SESSION()
    --
    --    Очистка данных для истекших сессий
    --
    --
    procedure clear_expired_session;

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция получения версии заголовка пакета
    --
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция получения версии тела пакета
    --
    --
    function body_version return varchar2;

    -----------------------------------------------------------------
    -- RESTORE_SESSION()
    --
    --    Восстанавливает значение клиентского идентификатора сессии
    --    из локального контекста
    --    Используется для удаленного вызова после подключения по dblink
    --
    procedure restore_session;

/*
    -----------------------------------------------------------------
    -- SET_USER_LASTCALL_DEBUG()
    --
    --     Процедура даты/времени последнего обращения пользователя
    --
    --
    procedure set_user_lastcall_debug(p_date date);
*/

end bars_login;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_LOGIN 
is

/**
 *
 * Пакет BARS_LOGIN содержит процедуры, выполняемые после
 * входа пользователя в систему
 *
 **/

/**
    Макросы для банков:
    --
    WEB       - Ощадбанк Облуправления (мульти-мфо)
    WEB       - НБУ (мульти-мфо)
 */

    VERSION_BODY       constant varchar2(64)  := 'version 1.19 20.10.2012';
    VERSION_BODY_DEFS  constant varchar2(512) := ''
                    || 'WEB      - расширение BARSWEB'                  || chr(10)
                    ;


    LOCAL_CTX           constant varchar2(30) := 'bars_local';
    GLOBAL_CTX          constant varchar2(30) := 'bars_global';
    CONTEXT_CTX         constant varchar2(30) := 'bars_context';

    CTXPAR_USERID       constant varchar2(30) := 'user_id';
    CTXPAR_USERNAME     constant varchar2(30) := 'user_name';
    CTXPAR_APPSCHEMA    constant varchar2(30) := 'user_appschema';
    CTXPAR_USERSTMT     constant varchar2(30) := 'user_login_stmt';
    CTXPAR_APPNAME      constant varchar2(30) := 'application_name';
    CTXPAR_HOSTNAME     constant varchar2(30) := 'host_name';
    CTXPAR_LASTCALL     constant varchar2(30) := 'last_call';
    CTXPAR_SESSIONID    constant varchar2(30) := 'session_id';
    CTXPAR_USERBANKDATE constant varchar2(30) := 'user_bankdate';

    CTXPAR_GLOBALDATE   constant varchar2(30) := 'global_bankdate';

    USER_LOGINSTMT_EXEC constant number       := 1;

    CLIID_PREFIX        constant varchar2(4)  := 'BRS-';

    MAX_HOSTNAME_LEN    constant number       := 64;
    MAX_CLIENTID_LEN    constant number       := 64;
    MAX_SESSION_TIMEOUT constant number       := 60;  -- в минутах

    -- Константы для ошибок
    ERR_DUP_SESSION     constant number       := -20980;
    ERR_SESSION_NULL    constant number       := -20981;
    ERR_SESSION_EMPTY   constant number       := -20982;
    ERR_USER_NOTFOUND   constant number       := -20983;
    ERR_BANKDATE_CLOSED constant number       := -20984;
    ERR_USER_NOTALLOWED constant number       := -20985;
    ERR_INVALID_SCHEMA  constant number       := -20986;
    ERR_USER_IS_CLOSED  constant number       := -20987;

    DATETIME_FORMAT     constant varchar2(30) := 'dd.mm.yyyy hh24:mi:ss';
    DATE_FORMAT         constant varchar2(30) := 'mm/dd/yyyy';

    -----------------------------------------------------------------
    -- Глобальные переменные
    g_clientid   varchar2(64);   -- клиентский идентификатор для данной сессии

    -----------------------------------------------------------------
    -- RAISE_INTERNAL_ERROR()
    --
    --     Процедура выдачи сообщения об ошибки в момент, когда
    --     еще невозможно обращение к пакету bars_error
    --
    procedure raise_internal_error(
                  p_errcode in number )
    is
    --
    l_errtext  varchar2(2048);
    --
    begin

        l_errtext := (case
                          when (p_errcode = ERR_DUP_SESSION)     then 'Duplicate session registration'
                          when (p_errcode = ERR_SESSION_NULL)    then 'Session identifier is null'
                          when (p_errcode = ERR_SESSION_EMPTY)   then 'Session is not initialized'
                          when (p_errcode = ERR_USER_NOTFOUND)   then 'User not found'
                          when (p_errcode = ERR_BANKDATE_CLOSED) then 'Bankdate is closed'
                          when (p_errcode = ERR_USER_NOTALLOWED) then 'Schema change for this user not allowed'
                          when (p_errcode = ERR_INVALID_SCHEMA)  then 'Invalid application schema'
                          when (p_errcode = ERR_BANKDATE_CLOSED) then 'Bankdate is closed'
                          when (p_errcode = ERR_USER_IS_CLOSED)  then 'User is closed'
                          else 'Unhandled application error'
                      end);

        raise_application_error(p_errcode, l_errtext, true);

    end raise_internal_error;

    -----------------------------------------------------------------
    -- ADD_USER_SESSION()
    --
    --     Процедура регистрации сессии в таблице активных сессий
    --
    --
    procedure add_user_session(
        p_clientid  in varchar2,
        p_userid    in number,
        p_proxyuser in varchar2)
    is
    pragma autonomous_transaction;
    begin
        -- реєстрація активної сесії
        merge into user_login_sessions a
        using dual
        on (a.client_id = p_clientid)
        when matched then update
             set a.user_id = p_userid,
                 a.proxy_user = p_proxyuser
        when not matched then insert
             values (p_clientid, p_userid, p_proxyuser);

        commit;
    end add_user_session;


    -----------------------------------------------------------------
    -- DROP_USER_SESSION()
    --
    --     Процедура удаление сессии из списка активных сессий
    --
    --
    procedure drop_user_session(
        p_clientid in varchar2)
    is
    pragma autonomous_transaction;
    begin
        -- видаляємо з активних сесій
        delete user_login_sessions
        where  client_id = p_clientid;

        commit;
    end drop_user_session;





    -----------------------------------------------------------------
    -- EXEC_SESSION_LOGINSTMT()
    --
    --     Выполнение блока инициализации сессии пользователя
    --
    --
    procedure exec_session_loginstmt(
                  p_loginstmt  in  varchar2 )
    is
    begin
        if (p_loginstmt is not null) then execute immediate p_loginstmt;
        end if;
    end exec_session_loginstmt;


    -----------------------------------------------------------------
    -- GET_USER_CLIENTID()
    --
    --     Функция получения клиентского идент. по пользователю
    --
    --
    function get_user_clientid(
                  p_sessionid in  varchar2 ) return varchar2
    is
    begin
        return CLIID_PREFIX || p_sessionid;
    end get_user_clientid;


    -----------------------------------------------------------------
    -- SET_USER_CLIENTID()
    --
    --     Процедура установки клиентского идентификатора
    --
    --
    procedure set_user_clientid(
                  p_clientid  in  varchar2 )
    is
    begin
$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.set_user_clientid(p_clientid=>'||nvl(p_clientid,'null')||'), '||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')
        );
$end

        if (p_clientid is not null) then
            sys.dbms_session.set_identifier(p_clientid);
        end if;
    end set_user_clientid;


    -----------------------------------------------------------------
    -- SET_USER_APPSCHEMA()
    --
    --     Процедура установки схемы приложения для пользователя
    --
    --
    procedure set_user_appschema(
                  p_appschema  in  varchar2 )
    is
    begin
        if (p_appschema is not null) then
            execute immediate 'alter session set current_schema = ' || p_appschema;
        end if;
    end set_user_appschema;


    -----------------------------------------------------------------
    -- SET_USER_LASTCALL()
    --
    --     Процедура даты/времени последнего обращения пользователя
    --
    --
    procedure set_user_lastcall(
        p_client_identifier in varchar2 default null)
    is
    begin
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_LASTCALL, to_char(sysdate, DATETIME_FORMAT), client_id => nvl(p_client_identifier, g_clientid));
    end set_user_lastcall;

    -----------------------------------------------------------------
    -- INIT_USER_CONTEXT()
    --
    --     Инициализация пользовательского контекста
    --
    --
    procedure init_user_context
    is
    begin

        bars.bars_context.set_context;

        -- Проверяем доступность банковского дня
        if (bars.web_utl.is_bankdate_open = 0) then
                bars_context.clear_session_context;
                raise_internal_error(ERR_BANKDATE_CLOSED);
        end if;

    end init_user_context;




    -----------------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT()
    --
    --    Очистка глобальных контекстов текущей сессии
    --
    --
    procedure clear_session_context
    is
    begin
$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.clear_session_context() invoked, client_id='||sys_context('userenv','client_identifier'));
$end

        -- Проходим по всем глобальным контекстам
        for c in (select package
                    from dba_context
                   where schema     = 'BARS'
                     and type       = 'ACCESSED GLOBALLY'
                     and namespace != 'BARS_GLOBAL'      )
        loop
            begin
                execute immediate 'begin ' || c.package || '.clear_session_context; end;';
            exception
                when OTHERS then null;
            end;
        end loop;

        -- Выполняем очистку нашего контекста
        sys.dbms_session.clear_context(GLOBAL_CTX, client_id=> get_session_clientid);
    end clear_session_context;

    -----------------------------------------------------------------
    -- SET_USER_SESSION()
    --
    --     Процедура инициализации пользовательской сессии
    --
    --
    procedure set_user_session(
                  p_sessionid  in  varchar2 )
    is
    begin

        -- Проверяем переданный ид. сессии
        if (p_sessionid is null) then raise_internal_error(ERR_SESSION_NULL);
        end if;

        -- Пишем p_sessionid в локальный контекст,
        -- чтобы достать после сброса состояния пакетов
        sys.dbms_session.set_context(LOCAL_CTX, CTXPAR_SESSIONID, p_sessionid);

        -- Получаем клиент. идентификатор
        g_clientid := get_user_clientid(p_sessionid);

        -- Устанавливаем кл. идентификатор
        set_user_clientid(g_clientid);

        -- Если польз. сессия проходила через login_user
        if (sys_context(GLOBAL_CTX, CTXPAR_USERID) is not null) then

            -- Если нет времени последнего обращения, то выполняем переинициализацию
            if (sys_context(CONTEXT_CTX, CTXPAR_LASTCALL) is null) then

                -- Перечитываем контекст пользователя
                init_user_context;

            end if;

            -- Выполнение блока инициализации пользователя
            exec_session_loginstmt(sys_context(GLOBAL_CTX, CTXPAR_USERSTMT));

            -- Установка схемы пользователя
            set_user_appschema(sys_context(GLOBAL_CTX, CTXPAR_APPSCHEMA));

            -- Установка имени приложения
            dbms_application_info.set_client_info(sys_context(GLOBAL_CTX, CTXPAR_APPNAME));

            -- Обновляем дату последнего обращения
            set_user_lastcall;

            -- Очищаем состояние пакетов
            sys.dbms_session.reset_package;

        else
            raise_internal_error(ERR_SESSION_EMPTY);
        end if;

    end set_user_session;






    -----------------------------------------------------------------
    -- LOGIN_USER()
    --
    --     Процедура входа пользователя в комплекс
    --
    --
    procedure login_user(
                  p_sessionid  in  varchar2,
                  p_userid     in  number,
                  p_hostname   in  varchar2,
                  p_appname    in  varchar2 )
    is
    --
    l_userid       number;          -- идент. пользователя
    l_username     varchar2(30);    -- имя пользователя
    l_userstmt     varchar2(4000);  -- блок инициализации пользователя
    l_hostname     varchar2(64);    -- имя клиентского хоста
    l_sessionid    varchar2(32);    -- идент. сессии
    l_appschema    varchar2(30);    -- схема приложения
    l_proxyuser    varchar2(30);    -- имя прокси-пользователя
    --
    l_clientid     varchar2(64);    -- клиентский идентификатор
    --
    begin

$if $$trace2alert $then
        sys.dbms_system.ksdddt;
        sys.dbms_system.ksdwrt(3, 'bars_login.login_user('
            ||'p_sessionid=>'||nvl(p_sessionid,'null')||', '
            ||'p_userid=>'||nvl(to_char(p_userid),'null')||', '
            ||'p_hostname=>'||nvl(p_hostname,'null')||', '
            ||'p_appname=>'||nvl(p_appname,'null')
            ||') start, '||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')
        );
$end

        if (p_sessionid is null and p_userid is null) then -- Прямое соединение

            -- Получаем реквизиты пользователя
            begin
                select id, logname, cschema
                  into l_userid, l_username, l_appschema
                  from staff$base
                 where logname = ora_login_user;
            exception
                when NO_DATA_FOUND then return;   -- если пользователь не наш, выходим
            end;

            -- Имя хоста берем из окружения
            l_hostname := nvl(substr(nvl(p_hostname, sys_context('userenv', 'terminal')), 1, MAX_HOSTNAME_LEN), 'NOT AVAILABLE');

            -- Генерируем ид. сессии
            l_sessionid := substr(sys_guid(), 1, 32);

        else

            -- Проверяем переданный ид. сессии
            if (p_sessionid is null) then
                raise_internal_error(ERR_SESSION_NULL);
            end if;

            -- Получаем реквизиты пользователя
            begin
                select id, logname, cschema
                  into l_userid, l_username, l_appschema
                  from staff$base
                 where id = p_userid;
            exception
                when NO_DATA_FOUND then
                    raise_internal_error(ERR_USER_NOTFOUND);
            end;

            l_hostname  := nvl(p_hostname, 'NOT AVAILABLE');
            l_sessionid := substr(p_sessionid, 1, 32);

        end if;

        -- Получаем определенный для пользователя блок инициализации
        begin
            select stmt into l_userstmt
              from bars.user_login_stmt
             where id   = l_userid
               and exec = USER_LOGINSTMT_EXEC;
        exception
            when NO_DATA_FOUND then l_userstmt := null;
        end;

        -- Формируем кл. идентификатора
        l_clientid := get_user_clientid(l_sessionid);

        set_user_clientid(l_clientid);

        -- Очищаем глобальные контексты текущей сессии
        clear_session_context;

        l_proxyuser := sys_context('userenv', 'proxy_user');

        -- Регистрируем сессию
        add_user_session(l_clientid, l_userid, l_proxyuser);

        -- Устанавливаем значения в контекст
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERID,    to_char(l_userid), client_id=> l_clientid);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERNAME,  l_username,        client_id=> l_clientid);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_APPSCHEMA, l_appschema,       client_id=> l_clientid);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERSTMT,  l_userstmt,        client_id=> l_clientid);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_APPNAME,   p_appname,         client_id=> l_clientid);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_HOSTNAME,  l_hostname,        client_id=> l_clientid);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_SESSIONID, l_sessionid,       client_id=> l_clientid);
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERBANKDATE, null,           client_id=> l_clientid);

        -- Выполняем установку параметров в сессии
        set_user_session(l_sessionid);

        --Инициализация доступа к счетам
        -- SEC.CALL_GETMASK;

        -- Устанавливаем банковскую дату пользователя как глобальную
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERBANKDATE, sys_context(CONTEXT_CTX, CTXPAR_GLOBALDATE), client_id=> l_clientid);

        bars_audit.info('Користувач ' || l_username || ' увійшов до системи - відділення користувача: ' ||
                        sys_context('bars_context', 'user_branch') || ', банківська дата: ' || sys_context('bars_gl', 'bankdate'));
$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.login_user('
            ||'p_sessionid=>'||nvl(p_sessionid,'null')||', '
            ||'p_userid=>'||nvl(to_char(p_userid),'null')||', '
            ||'p_hostname=>'||nvl(p_hostname,'null')||', '
            ||'p_appname=>'||nvl(p_appname,'null')
            ||') finish, '||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')
        );
$end

    end login_user;

    procedure login_user(
        p_session_id in varchar2,
        p_login_name in varchar2,
        p_authentication_mode in varchar2,
        p_host_name in varchar2,
        p_application_name in varchar2)
    is
        l_user_id integer;
    begin
        begin
            if (p_authentication_mode = 'ORACLE') then
                select s.id
                into   l_user_id
                from   staff$base s
                where  s.logname = upper(p_login_name);
            elsif (p_authentication_mode = 'ACTIVE DIRECTORY') then
                select t.user_id
                into   l_user_id
                from   staff_ad_user t
                where  t.active_directory_name = upper(p_login_name);
            elsif (p_authentication_mode = 'BARSWEB') then
                select s.id
                into   l_user_id
                from   staff$base s
                where  s.logname = (select w.dbuser
                                    from   web_usermap w
                                    where  w.webuser = lower(p_login_name));
            else
                raise_application_error(-2000, 'Неочікуваний тип автентифікації {' || p_authentication_mode || '}');
            end if;
        exception
            when no_data_found then
                raise_application_error(-20000, 'Користувач з логіном {' || p_login_name || '} не знайдений');
        end;

        login_user(p_session_id, l_user_id, p_host_name, p_application_name);
    end;

    -----------------------------------------------------------------
    -- LOGOUT_USER()
    --
    --     Процедура выхода пользователя из комплекса
    --
    --
    procedure logout_user
    is
        l_login_name varchar2(32767 byte);
    begin

$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.logout_user() start'||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')||', '
            ||'client_id='||nvl(sys_context('userenv','client_identifier'),'null')
        );
$end

        if (get_session_clientid is null)
            then return;
        end if;

        l_login_name := sys_context('bars_global', 'user_name');

        -- Удаляем сессию
        drop_user_session(get_session_clientid);

        bars_audit.info('Користувач ' || l_login_name || ' завершив роботу в АБС');

$if $$trace2alert $then
        sys.dbms_system.ksdwrt(3, 'bars_login.logout_user() finish'||chr(10)
            ||'sid='||sys_context('userenv','sid')||', '
            ||'ora_login_user='||ora_login_user||', '
            ||'proxy_user='||nvl(sys_context('userenv','proxy_user'),'null')||', '
            ||'client_id='||nvl(sys_context('userenv','client_identifier'),'null')
        );
$end
        -- Очищаем глобальные контексты текущей сессии
        clear_session_context;

    end logout_user;


    -----------------------------------------------------------------
    --     Установка банковской даты пользователя
    procedure set_user_bankdate(
                  p_bankdate  in  date )
    is
    begin
        if (p_bankdate is not null) then
            sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_USERBANKDATE, to_char(p_bankdate, DATE_FORMAT), client_id=> get_session_clientid);
            sys.dbms_session.reset_package;
        end if;
    end set_user_bankdate;


    -----------------------------------------------------------------
    --    Смена текущей схемы пользовательской сессии
    procedure change_user_appschema(
                  p_appschema varchar2 )
    is
    begin

        -- Для пользователей BARS, HIST менять схему нельзя
        if (sys_context(GLOBAL_CTX, CTXPAR_USERNAME) in ('BARS', 'HIST')) then
            raise_internal_error(ERR_USER_NOTALLOWED);
        end if;

        -- Проверяем допустимую схему
        if (p_appschema not in ('BARS', 'HIST')) then
            raise_internal_error(ERR_INVALID_SCHEMA);
        end if;

        -- Изменяем схему в контексте
        sys.dbms_session.set_context(GLOBAL_CTX, CTXPAR_APPSCHEMA, p_appschema, client_id=> get_session_clientid);

        -- Изменяем схему в сессии
        set_user_appschema(p_appschema);

    end change_user_appschema;


    -----------------------------------------------------------------
    --    Получение кл. идентификатора текущей сессии
    function get_session_clientid return t_sess_clientid
    is
    begin
        return substr(sys_context('userenv', 'client_identifier'), 1, MAX_CLIENTID_LEN);
    end get_session_clientid;


    procedure clear_expired_session
    is
        l_clientid   t_sess_clientid;  -- кл. идентификатор текущей сессии
        l_cnt        number;
    begin
        $if $$trace2alert $then
            sys.dbms_system.ksdddt;
        $end

        -- Сохраняем свой кл. идентификатор
        l_clientid := get_session_clientid();

        -- Проходим по всем зарегистрир. сессиям, кроме собственной
        for c in (select client_id, proxy_user
                  from   user_login_sessions
                  where  client_id <> l_clientid) loop

            $if $$trace2alert $then
               sys.dbms_system.ksdwrt(3, 'bars_login.clear_expired_session: client_id='||c.client_id||', proxy_user='||nvl(c.proxy_user,'null'));
            $end

            -- Устанавливаем кл. идентификатор чужой сессии для доступа к ее контекстам
            set_user_clientid(c.client_id);

            $if $$trace2alert $then
                sys.dbms_system.ksdwrt(3, 'bars_login.clear_expired_session: lastcall='||sys_context(global_ctx, ctxpar_lastcall));
            $end

            -- Смотрим дату последнего обращения
            if (nvl(to_date(sys_context(global_ctx, ctxpar_lastcall), datetime_format), sysdate-10) < sysdate - max_session_timeout/60/24) then

                -- Для веб-сессий очищаем сразу, для клиент-сервер проверяем наличие такой сессии
                if (c.proxy_user = 'APPSERVER') then
                    -- Очищаем глобальные контексты
                    clear_session_context;
                else
                    -- определяем кол-во чужих сессий
                    select count(*)
                    into   l_cnt
                    from   v$session
                    where  client_identifier = c.client_id;

                    $if $$trace2alert $then
                         sys.dbms_system.ksdwrt(3, 'bars_login.clear_expired_session: '||to_char(l_cnt)||' sessions found');
                    $end

                    if (l_cnt = 1) then
                        clear_session_context;
                    end if;
                end if;
            end if;
        end loop;

        -- Восстанавливаем свой кл. идентификатор
        set_user_clientid(l_clientid);
    exception
         when others then
              -- Восстанавливаем свой кл. идентификатор
              set_user_clientid(l_clientid);
              -- Выпускаем ошибку
              raise;
    end clear_expired_session;

    -----------------------------------------------------------------
    --     Функция получения версии заголовка пакета
    function header_version return varchar2
    is
    begin
        return 'Package header BARS_LOGIN '  || VERSION_HEADER || '.' || chr(10) ||
               'package header definition: ' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;


    -----------------------------------------------------------------
    --     Функция получения версии тела пакета
    function body_version return varchar2
    is
    begin
        return 'Package body BARS_LOGIN '  || VERSION_BODY || '.' || chr(10) ||
               'package body definition: ' || chr(10) || VERSION_BODY_DEFS;
    end body_version;


    -----------------------------------------------------------------
    --    Восстанавливает значение клиентского идентификатора сессии
    --    из локального контекста
    --    Используется для удаленного вызова после подключения по dblink
    procedure restore_session is
    begin
        set_user_session( sys_context(LOCAL_CTX, CTXPAR_SESSIONID) );
    end restore_session;

end bars_login;
/
 show err;
 
PROMPT *** Create  grants  BARS_LOGIN ***
grant EXECUTE                                                                on BARS_LOGIN      to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_LOGIN      to BARSUPL;
grant EXECUTE                                                                on BARS_LOGIN      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_LOGIN      to BARS_SUP;
grant EXECUTE                                                                on BARS_LOGIN      to SYSTEM;
grant EXECUTE                                                                on BARS_LOGIN      to WCS_SYNC_USER;
grant EXECUTE                                                                on BARS_LOGIN      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_login.sql =========*** End *** 
 PROMPT ===================================================================================== 
 