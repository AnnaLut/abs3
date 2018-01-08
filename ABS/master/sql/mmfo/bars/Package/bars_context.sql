
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_context.sql =========*** Run **
 PROMPT ===================================================================================== 
 
create or replace package bars.bars_context
as

    -----------------------------------------------------------------
    --
    -- BARS_CONTEXT - пакет для установки значений
    --                контекста "BARS_CONTEXT"
    --

    -----------------------------------------------------------------

    -- Константы
    --
    --
    VERSION_HEADER       constant varchar2(64) := 'version 1.21 12.09.2012';
    VERSION_HEADER_DEFS  constant varchar2(512) := ''
               || 'KF                           Мультифилиальная схема с полем ''kf'''  || chr(10)
               || 'POLICY_GROUP                 Использование групп политик'  || chr(10)
               || 'BR_ACCESS                Возможность представления на основе V_BRANCH_ACCESS '  || chr(10)
            ;

    GLOBAL_CTX             constant varchar2(30) := 'bars_global';
    CONTEXT_CTX            constant varchar2(30) := 'bars_context';

    GROUP_WHOLE            constant varchar2(30) := 'WHOLE';
    GROUP_FILIAL           constant varchar2(30) := 'FILIAL';

    -- Параметры глобального контекста
    CTXPAR_USERID          constant varchar2(30) := 'user_id';
    CTXPAR_USERNAME        constant varchar2(30) := 'user_name';
    CTXPAR_APPSCHEMA       constant varchar2(30) := 'user_appschema';

    -- Параметры контекста
    CTXPAR_POLGRPDEF       constant varchar2(30) := 'policy_group_default';
    CTXPAR_POLGRP          constant varchar2(30) := 'policy_group';
    CTXPAR_SECALARM        constant varchar2(30) := 'sec_alarm';
    CTXPAR_MFO             constant varchar2(30) := 'mfo';
    CTXPAR_RFC             constant varchar2(30) := 'rfc';
    CTXPAR_USERMFOP        constant varchar2(30) := 'user_mfop';
    CTXPAR_GLOBAL_BANKDATE constant varchar2(30) := 'global_bankdate';
    CTXPAR_GLBMFO          constant varchar2(30) := 'glb_mfo';
    CTXPAR_USERBRANCH      constant varchar2(30) := 'user_branch';
    CTXPAR_USERBRANCH_MASK constant varchar2(30) := 'user_branch_mask';
    CTXPAR_USERMFO         constant varchar2(30) := 'user_mfo';
    CTXPAR_USERMFO_MASK    constant varchar2(30) := 'user_mfo_mask';
    CTXPAR_CSCHEMA         constant varchar2(30) := 'cschema';
    CTXPAR_LASTCALL        constant varchar2(30) := 'last_call';
    CTXPAR_DBID            constant varchar2(30) := 'db_id';
    CTXPAR_PARAMSMFO       constant varchar2(30) := 'params_mfo';
    CTXPAR_SELECTED_BRANCH constant varchar2(30) := 'selected_branch';


    ROOT_MFO               constant varchar2(6) := '000000';


    function current_branch_code
    return varchar2;

    function current_mfo
    return varchar2;

    function current_branch_name
    return varchar2;

    function current_policy_group
    return varchar2;

    -----------------------------------------------------------------
    -- SET_CONTEXT()
    --
    --    Установка умолчательного контекста пользователя
    --
    --
    procedure set_context;

    -----------------------------------------------------------------
    -- CLEAR_SESSION_CONTEXT()
    --
    --    Очистка пользовательского контекста
    --
    --
    procedure clear_session_context;

    -----------------------------------------------------------------
    -- RELOAD_CONTEXT()
    --
    --    Переинициализация пользовательского контекста
    --
    --
    procedure reload_context;



    -----------------------------------------------------------------
    -- CHECK_USER_PRIVS()
    --
    --     Функция проверки прав пользователя
    --
    --
    function check_user_privs return boolean;



    -----------------------------------------------------------------
    -- EXTRACT_MFO()
    --
    --     Функция для получения кода МФО по коду отделения
    --
    --
    --
    function extract_mfo(
                 p_branch in varchar2 default null) return varchar2;

    -----------------------------------------------------------------
    -- EXTRACT_RFC()
    --
    --     Функция для получения кода RFC(Root/Filial Code) по коду отделения
    --
    --
    --
    function extract_rfc(
                 p_branch in varchar2 default null) return varchar2;

    -----------------------------------------------------------------
    -- GET_PARENT_BRANCH()
    --
    --     Функция для получения кода родительского отделения
    --
    --
    --
    function get_parent_branch(
                 p_branch in varchar2 default null) return varchar2;

    -----------------------------------------------------------------
    -- IS_PARENT_BRANCH()
    --
    --     Функция проверяет является ли переданных код отделения
    --     (первый параметр) одним из родительских отделений по
    --     отношению к текущему отделению пользователя.
    --
    --     Параметры:
    --
    --         p_branch   Код отделения
    --
    --         p_level    Уровень
    --                        0 - проверка совпадения переданного
    --                            кода отделения и установленного
    --                            кода отделения у пользователя
    --                        <n> количество уровней вверх
    --
    --     Функция возвращает значение "1", если переданный код
    --     отделения является родительским, иначе значение "0"
    --
    function is_parent_branch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number;


    -----------------------------------------------------------------
    -- IS_PBRANCH()
    --
    --     Синоним функции is_parent_branch()
    --
    function is_pbranch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number;


    -----------------------------------------------------------------
    -- IS_MFO()
    --
    --     Функция определяет является ли BRANCH балансовым учреждением
    --     возвращает 0/1
    --
    --
    function is_mfo(
                 p_branch in varchar2 default null) return number;


    -----------------------------------------------------------------
    -- MAKE_BRANCH()
    --
    --     Функция возвращает бранч по МФО
    --
    --
    --
    function make_branch(
                 p_mfo in varchar2) return varchar2;


    -----------------------------------------------------------------
    -- MAKE_BRANCH_MASK()
    --
    --     Функция возвращает маску бранча по МФО
    --
    --
    --
    function make_branch_mask(
                 p_mfo in varchar2) return varchar2;

    -----------------------------------------------------------------
    -- SUBST_BRANCH()
    --
    --     Процедура представления пользователя другим подразделением
    --     @p_branch - код подразделения
    --     @p_policy_group - группа политик
    --     (если задана, то вызов процедуры с анонимного блока запрещен)
    --
    procedure subst_branch(
                  p_branch       in varchar2
                  ,p_policy_group in varchar2 default null
                  );

    -----------------------------------------------------------------
    -- SUBST_MFO()
    --
    --     Процедура представления пользователя другим MFO
    --
    --
    procedure subst_mfo(
                  p_mfo in varchar2);


    -----------------------------------------------------------------
    -- SET_POLICY_GROUP()
    --
    --     Процедура устанавливает активную группу политик
    --
    --
    procedure set_policy_group(
                  p_policy_group in varchar2);

    -----------------------------------------------------------------
    -- SELECT_BRANCH()
    --
    --    Выбор бранча из множества доступных
    --
    --
    procedure select_branch(p_branch in varchar2);



    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2;

    -----------------------------------------------------------------
    -- SET_CSCHEMA()
    --
    --    Установка текущей схемы
    --
    --
    procedure set_cschema(p_cschema varchar2);


    -----------------------------------------------------------------
    -- GO()
    --
    --     Процедура представления пользователя другим подразделением
    --     @p_branch - код подразделения или код МФО
    --     н-р,
    --     bc.go('/'); -- войти в корневой бранч
    --     bc.go('303398'); -- войти в МФО, то же, что и вызов
    --     bc.go('/303398/');
    --     bc.go('/303398/000120/060120/'); - войти в бранч /303398/000120/060120/
    --
    procedure go(p_branch in varchar2);

    -----------------------------------------------------------------
    -- HOME()
    --
    --    Возвращаемся домой в свой бранч
    --
    --
    procedure home;

end;
/
create or replace package body bars.bars_context 
is


    -----------------------------------------------------------------
    -- Константы
    --
    --
    VERSION_BODY          constant varchar2(64)  := 'version 1.43 23.11.2017';
    VERSION_BODY_DEFS     constant varchar2(512) := ''
                          || 'KF            Мультифилиальная схема с полем ''KF'''                   || chr(10)
                          || 'POLICY_GROUP  Использование групп политик'                             || chr(10)
                          || 'BR_ACCESS     Возможность представления на основе V_BRANCH_ACCESS '    || chr(10)
            ;

    RESOURCE_BUSY          exception;
    pragma exception_init(RESOURCE_BUSY,   -54  );


    -----------------------------------------------------------------
    -- Глобальные переменные
    --
    --
    g_polgrpdef       varchar2(30);    -- умолчательное значение групы политик

    function current_branch_code
    return varchar2
    is
    begin
        return sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERBRANCH);
    end;

    function current_mfo
    return varchar2
    is
    begin
        return sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_USERMFO);
    end;

    function current_branch_name
    return varchar2
    is
    begin
        return branch_utl.get_branch_name(current_branch_code());
    end;

    function current_policy_group
    return varchar2
    is
    begin
        return sys_context(bars_context.CONTEXT_CTX, bars_context.CTXPAR_POLGRP);
    end;

    -----------------------------------------------------------------
    --    Установка контекста пользователя в соответствии с
    --    указанным подразделением
    procedure set_context_ex(
                  p_branch in varchar2 default null)
    is
    --
    l_secalarm     params.val%type;     -- Признак мониторинга журнала аудита
    l_kf           banks.mfo%type;      -- Код филиала
    l_mfop         params.val%type;     -- Код МФО расч. палаты
    l_mfog         params.val%type;     -- Код МФО гл. банка
    l_bankdate     params.val%type;     -- Банковская дата
    l_clientid     varchar2(64);       -- клиентский идентификатор сессии
    --
    begin

        -- Проверяем каким подразделением мы сейчас представлены
        if (    sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH) is not null
            and sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH) = p_branch  ) then return; -- если текущим, выходим
        end if;

        -- Читаем глобальные параметры
        select max(decode(par, 'SECALARM', val)),
               max(decode(par, 'GLB-MFO',  val))
          into l_secalarm, l_mfog
          from params$global
         where par in ('SECALARM', 'GLB-MFO');

    -- Получаем код филиала из кода отделения
        l_kf := extract_mfo(p_branch);


        if (l_kf is not null) then

            -- Читаем параметры филиала
            select max(decode(par, 'MFOP',     val)) mfop,
                   max(decode(par, 'BANKDATE', val)) bankdate
              into l_mfop, l_bankdate
              from params$base
             where par in ('MFOP', 'BANKDATE')
               and kf = l_kf;
        end if;

        l_clientid := sys_context('userenv', 'client_identifier');

        -- Устанавливаем значения атрибутов контекста
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_SECALARM,        l_secalarm,      client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_MFO,             l_kf,            client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFOP,        l_mfop,          client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_GLOBAL_BANKDATE, l_bankdate,      client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERBRANCH,      p_branch,        client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERBRANCH_MASK, p_branch ||'%',  client_id=> l_clientid);
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_GLBMFO,          l_mfog,          client_id=> l_clientid);

        if (l_kf is not null) then
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_MFO,             l_kf,        client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFO,         l_kf,        client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_RFC,             l_kf,        client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFO_MASK,    '/' || l_kf || '/%', client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_USERMFOP,        l_mfop,      client_id=> l_clientid);
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_GLOBAL_BANKDATE, l_bankdate,  client_id=> l_clientid);
        else
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_MFO,             client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_USERMFO,         client_id=> l_clientid);
            sys.dbms_session.set_context  (CONTEXT_CTX, CTXPAR_RFC,           ROOT_MFO,    client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_USERMFO_MASK,    client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_USERMFOP,        client_id=> l_clientid);
            sys.dbms_session.clear_context(CONTEXT_CTX, attribute=>CTXPAR_GLOBAL_BANKDATE, client_id=> l_clientid);
        end if;
    end set_context_ex;

    -----------------------------------------------------------------
    --    Очистка пользовательского контекста
    procedure clear_session_context
    is
    begin
        sys.dbms_session.clear_context(CONTEXT_CTX, client_id=>sys_context('userenv', 'client_identifier'));
    end clear_session_context;

    -----------------------------------------------------------------
    --    Переинициализация пользовательского контекста
    procedure reload_context
    is
    begin
        for c in (select client_id from user_login_sessions)
        loop
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_LASTCALL, null, client_id=>c.client_id);
        end loop;
    end reload_context;

    -----------------------------------------------------------------
    --     Процедура устанавливает активную группу политик
    --     по соображениям безопасности процедуру в заголовок
    --     пакета НЕ ВЫНОСИТЬ !!!
    procedure set_policy_group_ex(
        p_policy_group in varchar2)
    is
        l_policy_group   varchar2(30);
    begin
        -- Проверяем существование такой группы политик
        begin
            select policy_group into l_policy_group
              from policy_groups
             where policy_group = p_policy_group;
        exception
            when NO_DATA_FOUND then
                raise_application_error(-20000, 'Недопустимая группа политик: ' || p_policy_group);
        end;

        -- Устанавливаем активную группу политик
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_POLGRP, p_policy_group, client_id=> sys_context('userenv', 'client_identifier'));
    end;

    -----------------------------------------------------------------
    --     Процедура устанавливает активную группу политик
    --     (с запретом вызова из анонимного блока)
    procedure set_policy_group(
        p_policy_group in varchar2)
    is
    begin
        -- Вызов данной функции из анонимного блока запрещен
        if (lower(get_caller_name) = 'anonymous block') then
            raise_application_error(-20000, 'Установка активной группы политик из анонимного блока запрещена');
        end if;

        -- Устанавливаем активную группу
        set_policy_group_ex(p_policy_group);
    end set_policy_group;

    -----------------------------------------------------------------
    --    Установка умолчательного контекста пользователя
    procedure set_context
    is
        l_branch   staff$base.branch%type; -- код отделения пользователя
        l_user_row staff$base%rowtype;
    begin
        -- Получаем реквизиты пользователя
        l_user_row := user_utl.read_user(to_number(sys_context(GLOBAL_CTX, CTXPAR_USERID)));

        if (sys_context(CONTEXT_CTX, CTXPAR_SELECTED_BRANCH) is not null) then
            -- пользователь явно выбрал одно из доступных отделений через веб-интерфейс?
            -- выбор пользователя имеет приоритет над его "домашним" подразделением из staff$base.branch
            l_branch := sys_context(CONTEXT_CTX, CTXPAR_SELECTED_BRANCH);
        else
            -- пользователь не указывал подразделения - устанавливаем подразделение "по умолчанию"
            l_branch := l_user_row.branch;
        end if;

        if (l_branch = l_user_row.branch) then
            -- Устанавливаем группу политик пользователя
            set_policy_group_ex(l_user_row.policy_group);
        else
            if (l_branch = '/') then
                set_policy_group_ex(GROUP_WHOLE); -- для корня группа политик WHOLE
            else
                set_policy_group_ex(g_polgrpdef); -- устанавливаем умолчательную
            end if;
        end if;

        set_context_ex(l_branch);

        -- Выполняем переинициализацию пакетов
        if (not tools.equals(sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH), l_branch)) then
            gl.param;
            sec.reinit;
        end if;

        -- при переключении МФО очищаем контекст BARS_SEC с масками доступа к счетам
        -- TODO : Доступ к счетам меняется от МФО к МФО?
        if (not tools.equals(sys_context(CONTEXT_CTX, CTXPAR_USERMFO), extract_mfo(l_branch))) then
            sec.clear_session_context();
        end if;

        -- Только для совместимости
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_CSCHEMA, sys_context(GLOBAL_CTX, CTXPAR_APPSCHEMA), client_id=> sys_context('userenv', 'client_identifier'));
    end;

    -----------------------------------------------------------------
    --     Функция проверки прав пользователя
    function check_user_privs return boolean
    is
    begin
        return true;
    end check_user_privs;

    -----------------------------------------------------------------
    --     Функция для получения кода МФО по коду отделения
    function extract_mfo(
        p_branch in varchar2 default null)
    return varchar2
    is
        l_branch varchar2(30 char) default p_branch;
    begin
        if (l_branch is null) then
            l_branch := current_branch_code();
        end if;

        return regexp_substr(l_branch, '\d{6}');
    end;

    -----------------------------------------------------------------
    --     Функция для получения кода RFC(Root/Filial Code) по коду отделения
    function extract_rfc(
        p_branch in varchar2 default null) return varchar2
    is
    begin
        return nvl(extract_mfo(p_branch), ROOT_MFO);
    end extract_rfc;

    -----------------------------------------------------------------
    --     Функция для получения кода родительского отделения
    function get_parent_branch(
        p_branch in varchar2 default null) return varchar2
    is
        l_branch branch.branch%type;
    begin
        l_branch := p_branch;

        if (l_branch is null) then
            l_branch := current_branch_code();
        end if;

        return substr(l_branch, 1, instr(l_branch, '/', -2));
    end get_parent_branch;


    -----------------------------------------------------------------
    -- IS_PARENT_BRANCH()
    --
    --     Функция проверяет является ли переданных код отделения
    --     (первый параметр) одним из родительских отделений по
    --     отношению к текущему отделению пользователя.
    --
    --     Параметры:
    --
    --         p_branch   Код отделения
    --
    --         p_level    Уровень
    --                        0 - проверка совпадения переданного
    --                            кода отделения и установленного
    --                            кода отделения у пользователя
    --                        <n> количество уровней вверх
    --
    --     Функция возвращает значение "1", если переданный код
    --     отделения является родительским, иначе значение "0"
    --
    function is_parent_branch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number
    is
    l_pbr       branch.branch%type;   -- код текущего отделения
    l_isparent  boolean := false;     -- признак вхождения
    --
    begin

        l_pbr := sys_context('bars_context', 'user_branch');

        -- Оптимизируем для нулевого уровня
        if (p_level = 0) then
            if (p_branch = l_pbr) then return 1;
            else return 0;
            end if;
        end if;

        -- Получаем код отделения максимального уровня по p_level
        for i in 0..p_level
        loop
            if (p_branch = l_pbr) then l_isparent := true;
            end if;
            l_pbr := substr(l_pbr, 1, greatest(instr(l_pbr, '/', -2), 1));
        end loop;

        if (l_isparent) then return 1;
        else                 return 0;
        end if;

    end is_parent_branch;


    -----------------------------------------------------------------
    --     Синоним функции is_parent_branch()
    function is_pbranch(
                 p_branch in varchar2,
                 p_level  in number  default 0) return number
    is
    begin
        return is_parent_branch(p_branch, p_level);
    end is_pbranch;


    -----------------------------------------------------------------
    --     Функция определяет является ли BRANCH балансовым
    --     учреждением (возвращает значение 0/1)
    function is_mfo(
        p_branch in varchar2 default null)
    return number
    is
        l_branch branch.branch%type;
    begin
        l_branch := p_branch;

        if (l_branch is null) then
            l_branch := current_branch_code();
        end if;

        if (l_branch like '/______/') then return 1;
        else return 0;
        end if;

    end is_mfo;


    -----------------------------------------------------------------
    --     Функция возвращает код отделения по МФО
    function make_branch(
        p_mfo in varchar2) return varchar2
    is
    begin
        return '/' || p_mfo || '/';
    end make_branch;


    -----------------------------------------------------------------
    --     Функция возвращает маску отделения по МФО
    function make_branch_mask(
        p_mfo in varchar2) return varchar2
    is
    begin
        return '/' || p_mfo || '/%';
    end make_branch_mask;

    -----------------------------------------------------------------
    --     Процедура представления пользователя другим подразделением
    --     @p_branch - код подразделения
    --     @p_policy_group - группа политик
    --     (если задана, то вызов процедуры с анонимного блока запрещен)
    procedure subst_branch(
        p_branch       in varchar2,
        p_policy_group in varchar2 default null)
    is
        l_old_mfo      varchar2(6) := nvl(sys_context(CONTEXT_CTX, CTXPAR_USERMFO), ROOT_MFO); -- установленное сейчас МФО
        l_new_mfo      varchar2(6); -- МФО, которое надо установить

        l_user_branch  staff$base.branch%type;
        l_branch_row   branch%rowtype;
    begin
        -- якщо бранч користувача не мінявся виходимо
        if (p_branch = sys_context(CONTEXT_CTX, CTXPAR_USERBRANCH)) then
            return;
        end if;	

        -- Проверяем существование подразделения в справочнике подразделений
        l_branch_row := branch_utl.read_branch(p_branch);

        l_user_branch := user_utl.get_user_branch(to_number(sys_context(GLOBAL_CTX, CTXPAR_USERID)));

        -- Меняем подразделение только если оно доступно данному пользователю - находится в иерархии 
        if (l_branch_row.branch like l_user_branch || '%') then
            -- Устанавливаем группу политик
            if (p_policy_group is not null) then
                set_policy_group(p_policy_group);  -- устанавливаем с проверкой вызова
            else
                if (l_branch_row.branch = '/') then
                    set_policy_group_ex(GROUP_WHOLE); -- для корня группа политик WHOLE
                else
                    set_policy_group_ex(g_polgrpdef); -- устанавливаем умолчательную
                end if;
            end if;

            -- МФО, которое мы должны установить
            l_new_mfo := nvl(extract_mfo(l_branch_row.branch), ROOT_MFO);

            -- Устанавливаем контекст отделения
            set_context_ex(l_branch_row.branch);

            -- Выполняем принудительную переинициализацию пакетов GL, SEC
            gl.param;
            sec.reinit;

            -- при переключении МФО очищаем контекст BARS_SEC с масками доступа к счетам
            if (l_old_mfo <> l_new_mfo) then
                sec.clear_session_context();
            end if;
        else
            -- Если пользователь не имеет права представиться заданым подразделением
            -- т.е. заданное подразделение не является его дочерним или основным, то
            -- выбрасываем соотв. сообщение
            raise_application_error(-20000, 'Пользователь ' || sys_context(GLOBAL_CTX, CTXPAR_USERNAME) || ' не имеет права представляться подразделением ' || p_branch);
        end if;
    end subst_branch;


    -----------------------------------------------------------------
    --     Процедура представления пользователя другим MFO
    procedure subst_mfo(
                  p_mfo  in  varchar2 )
    is
    begin
        subst_branch('/' || p_mfo || '/');
    end subst_mfo;

    -----------------------------------------------------------------
    --    Выбор бранча из множества доступных
    procedure select_branch(p_branch in varchar2)
    is
        l_branch varchar2(32767 byte) := trim(p_branch);
    begin
/*
        -- чистим атрибут selected_branch, тем самым делаем рабочим отделением самое верхнее
        sys.dbms_session.clear_context(CONTEXT_CTX, sys_context('userenv', 'client_identifier'), CTXPAR_SELECTED_BRANCH);
*/
        -- представляемся указанным отделением, чтобы понять, доступно ли оно нам
        subst_branch(l_branch);

        -- устанавливаем пользователю указанное отделение
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_SELECTED_BRANCH, l_branch, client_id => sys_context('userenv', 'client_identifier'));

        -- делаем запись в журнал, т.к. это важное действие
        bars_audit.info('Вибрано відділення ' || l_branch);
    exception
        when others then
             raise_application_error(-20000, dbms_utility.format_error_stack() || chr(10) || dbms_utility.format_error_backtrace());
    end select_branch;

    -----------------------------------------------------------------
    --    Установка текущей схемы пользовательской сессии
    procedure set_cschema(
                  p_cschema varchar2 )
    is
    begin
        bars_login.change_user_appschema(p_cschema);

        -- Только для совместимости
        sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_CSCHEMA, sys_context(GLOBAL_CTX, CTXPAR_APPSCHEMA));

    end set_cschema;


    -----------------------------------------------------------------
    --    Инициализация состояния пакета
    procedure init
    is
    l_tabname    varchar2(30);  -- имя таблицы политик
    l_defvalue   long;          -- умолчательное значение
    l_deflen     number;        -- длина умолчательного значения
    l_polgrp     varchar2(30);  -- умолчательное значение
    begin

        if (sys_context(CONTEXT_CTX, CTXPAR_POLGRPDEF) is null) then

            -- Определяем ведущую таблицу описания политик
            begin
                select table_name into l_tabname
                  from user_tables
                 where table_name = 'POLICY_TABLE';
            exception
                when NO_DATA_FOUND then l_tabname := 'POLICY_TABLE_LT';  -- таблица версионная
            end;

            -- получаем умолчательное значение поля POLICY_GROUP
            begin
                select data_default, default_length into l_defvalue, l_deflen
                  from user_tab_columns
                 where table_name  = l_tabname
                   and column_name = 'POLICY_GROUP';
                l_polgrp := trim(replace(substr(l_defvalue, 1, l_deflen),''''));
            exception
                when NO_DATA_FOUND then l_polgrp := 'WHOLE';
            end;

            -- Сохраняем значение в контексте и устанавливаем переменную
            sys.dbms_session.set_context(CONTEXT_CTX, CTXPAR_POLGRPDEF, l_polgrp, client_id=> sys_context('userenv', 'client_identifier'));
            g_polgrpdef := l_polgrp;
        else
            g_polgrpdef := sys_context(CONTEXT_CTX, CTXPAR_POLGRPDEF);
        end if;

    end init;


    -----------------------------------------------------------------
    --     Функция возвращает строку с версией заголовка пакета
    function header_version return varchar2
    is
    begin
        return 'package header BARS_CONTEXT ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;

    -----------------------------------------------------------------
    --     Функция возвращает строку с версией тела пакета
    function body_version return varchar2
    is
    begin
        return 'package body BARS_CONTEXT ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;

    -----------------------------------------------------------------
    -- GO()
    --
    --     Процедура представления пользователя другим подразделением
    --     @p_branch - код подразделения или код МФО
    --     н-р,
    --     bc.go('/'); -- войти в корневой бранч
    --     bc.go('303398'); -- войти в МФО, то же, что и вызов
    --     bc.go('/303398/');
    --     bc.go('/303398/000120/060120/'); - войти в бранч /303398/000120/060120/
    --
    procedure go(p_branch in varchar2)
    is
    begin
        if regexp_like(p_branch, '^\d{6}$') then
            subst_branch('/'||p_branch||'/');
        else
            subst_branch(p_branch);
        end if;
    end;

    -----------------------------------------------------------------
    --    Возвращаемся домой в свой бранч
    procedure home
    is
    begin
        bc.set_context;
    end home;

begin
    init;
end;
/
 show err;
 
PROMPT *** Create  grants  BARS_CONTEXT ***
grant EXECUTE                                                                on BARS_CONTEXT    to ABS_ADMIN;
grant EXECUTE                                                                on BARS_CONTEXT    to BARSAQ with grant option;
grant EXECUTE                                                                on BARS_CONTEXT    to BARSAQ_ADM with grant option;
grant EXECUTE                                                                on BARS_CONTEXT    to BARSUPL;
grant EXECUTE                                                                on BARS_CONTEXT    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BARS_CONTEXT    to BARS_CONNECT;
grant DEBUG,EXECUTE                                                          on BARS_CONTEXT    to BARS_DM;
grant EXECUTE                                                                on BARS_CONTEXT    to FINMON;
grant EXECUTE                                                                on BARS_CONTEXT    to JBOSS_USR;
grant EXECUTE                                                                on BARS_CONTEXT    to KLBX;
grant EXECUTE                                                                on BARS_CONTEXT    to PFU;
grant EXECUTE                                                                on BARS_CONTEXT    to RPBN001;
grant EXECUTE                                                                on BARS_CONTEXT    to RPBN002;
grant EXECUTE                                                                on BARS_CONTEXT    to TEST;
grant EXECUTE                                                                on BARS_CONTEXT    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_context.sql =========*** End **
 PROMPT ===================================================================================== 
 
