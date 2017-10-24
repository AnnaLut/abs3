
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_repl_ddbs.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_REPL_DDBS 
is

    g_headerVersion   constant varchar2(64)  := 'version 1.00 14.08.2006';
    g_headerDefs      constant varchar2(512) := '';


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
    -- GET_DDB_ID()
    --
    --    Функция получения идентификатора БД (ddb_id) по коду
    --    подразделения (branch)
    --
    --
    --
    function get_ddb_id(
                 p_branch  in branch.branch%type) return ddbs.ddb_id%type;


    -----------------------------------------------------------------
    -- GET_DDB_BRANCH()
    --
    --    Функция получения текущего кода подразделения для
    --    удаленной БД
    --
    --
    --
    function get_ddb_branch return ddbs.branch%type;

    -----------------------------------------------------------------
    -- GET_BRANCH_STATUS()
    --
    --    Функция определения статуса отделения в  текущей БД
    --    Если отделение обслуживается в этой БД,  то функция
    --    возвращает значение "0",  иначе функция  возвращает
    --    идентификатор удаленной БД, в которой обслуживается
    --    подразделение (возвращаемое значение больше 0)
    --
    --    Параметры:
    --
    --        p_branch    Код отделения (филиала)
    --
    --
    function get_branch_status(
                 p_branch  in branch.branch%type) return number;


    -----------------------------------------------------------------
    -- CHECK_ONLINE_BRANCH()
    --
    --    Процедура генерирует ошибку если указанное подразделение
    --    обслуживается удаленной БД
    --
    --
    --
    procedure check_online_branch(
                 p_branch  in branch.branch%type);

end bars_repl_ddbs;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_REPL_DDBS 
is

    -----------------------------------------------------------------
    -- Constants
    --
    --
    --
    g_bodyVersion   constant varchar2(64)  := 'version 1.00 14.08.2006';
    g_bodyDefs      constant varchar2(512) := '';

    REPL2_ERROR      constant number := -20911;


    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     Функция возвращает строку с версией заголовка пакета
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_REPL_DDBS ' || g_headerVersion || chr(10) ||
               'package header definition(s):' || chr(10) || g_headerDefs;
    end header_version;

    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     Функция возвращает строку с версией тела пакета
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_REPL_DDBS ' || g_bodyVersion || chr(10) ||
               'package body definition(s):' || chr(10) || g_bodyDefs;
    end body_version;


    -----------------------------------------------------------------
    -- GET_DDB_ID()
    --
    --    Функция получения идентификатора БД (ddb_id) по коду
    --    подразделения (branch)
    --
    --
    --
    function get_ddb_id(
                 p_branch  in branch.branch%type) return ddbs.ddb_id%type
    is

    l_ddbid   ddbs.ddb_id%type;    /* идентификатор базы */

    begin

        --
        -- Пробуем получить из контекста
        --
        if (sys_context('bars_context', 'user_branch') = p_branch) then

            -- Проверяем установлено ли значение
            if (sys_context('bars_context', 'db_id') is not null) then
                return sys_context('bars_context', 'db_id');
            end if;

        end if;

        --
        -- Получаем из справочника
        --
        begin

            select ddb_id into l_ddbid
              from ddbs
             where branch = p_branch;

        exception
            when NO_DATA_FOUND then

                --
                -- берем идентификатор основной БД
                --
                begin

                    select ddb_id into l_ddbid
                      from ddbs
                     where branch is null;

                exception
                    when NO_DATA_FOUND then
                        bars_audit.error('Некорректно заполнен справочник распределенных БД - не определена основная БД');
                        raise_application_error(REPL2_ERROR, '\0001 Некорректно заполнен справочник распределенных БД - не определена основная БД');
                    when TOO_MANY_ROWS then
                        bars_audit.error('Некорректно заполнен справочник распределенных БД - основная БД определена неоднозначно');
                        raise_application_error(REPL2_ERROR, '\0002 Некорректно заполнен справочник распределенных БД - основная БД определена неоднозначно');
                end;

        end;

        return l_ddbid;

    end get_ddb_id;


    -----------------------------------------------------------------
    -- GET_BRANCH_STATUS()
    --
    --    Функция определения статуса отделения в  текущей БД
    --    Если отделение обслуживается в этой БД,  то функция
    --    возвращает значение "0",  иначе функция  возвращает
    --    идентификатор удаленной БД, в которой обслуживается
    --    подразделение (возвращаемое значение больше 0)
    --
    --    Параметры:
    --
    --        p_branch    Код отделения (филиала)
    --
    --
    function get_branch_status(
                 p_branch  in branch.branch%type) return number
    is

    l_glname   global_name.global_name%type;  /* глобальное имя БД */
    l_br       ddbs.branch%type;
    l_brdbid   ddbs.ddb_id%type;
    l_brdbname ddbs.ddb_name%type;


    begin

        -- get database global name
        select global_name into l_glname
          from global_name;

        -- get database branch (null for main db)
        select branch into l_br
          from ddbs
         where ddb_name = l_glname;

        if (l_br is not null and l_br = p_branch) then
            return 0;
        else

            begin

                select ddb_id, ddb_name into l_brdbid, l_brdbname
                  from ddbs
                 where branch is not null
                   and branch = p_branch;

            exception
                when NO_DATA_FOUND then
                    l_brdbname := null;
                    l_brdbid   := null;
            end;

            if (l_br is null) then

                --
                -- Это основная БД и все обслуживаемые в ней
                -- отделения (филиалы) не описаны ddbs
                if (l_brdbid is null or l_brdbname = l_glname) then
                    return 0;
                else
                    return l_brdbid;
                end if;

            else
                --
                -- Это удаленная БД и не ее отделение (филиал)
                --
                if (l_brdbid is not null) then
                    return l_brdbid;
                else
                    --
                    -- Определяем DDB_ID основной БД
                    --
                    select ddb_id into l_brdbid
                      from ddbs
                     where branch is null;

                    return l_brdbid;

                end if;

            end if;

        end if;

    end get_branch_status;



    -----------------------------------------------------------------
    -- CHECK_ONLINE_BRANCH()
    --
    --    Процедура генерирует ошибку если указанное подразделение
    --    обслуживается удаленной БД
    --
    --
    --
    procedure check_online_branch(
                 p_branch  in branch.branch%type)
    is

    l_glname global_name.global_name%type;
    l_br     ddbs.branch%type;
    l_dummy  number;

    begin

        select global_name into l_glname
          from global_name;

        select branch into l_br
          from ddbs
         where ddb_name = l_glname;

        if (l_br is not null) then

            if (l_br != p_branch) then
                bars_audit.error('Попытка модификации данных offline-подразделения');
                raise_application_error(REPL2_ERROR, '\0003 Попытка модификации данных offline-подразделения');
            end if;

        else

            select count(*) into l_dummy
              from ddbs
             where branch = p_branch;

            if (l_dummy > 0) then
                bars_audit.error('Попытка модификации данных offline-подразделения');
                raise_application_error(REPL2_ERROR, '\0003 Попытка модификации данных offline-подразделения');
            end if;

        end if;

    end check_online_branch;

    -----------------------------------------------------------------
    -- GET_DDB_BRANCH()
    --
    --    Функция получения текущего кода подразделения для
    --    удаленной БД
    --
    --
    --
    function get_ddb_branch return ddbs.branch%type
    is

    l_glname   global_name.global_name%type;  /* глобальное имя БД */
    l_br   ddbs.branch%type;

    begin

        -- get database global name
        select global_name into l_glname
          from global_name;

        -- get database branch (null for main db)
        select branch into l_br
          from ddbs
         where ddb_name = l_glname;

        return l_br;

    end get_ddb_branch;


end bars_repl_ddbs;
/
 show err;
 
PROMPT *** Create  grants  BARS_REPL_DDBS ***
grant EXECUTE                                                                on BARS_REPL_DDBS  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_repl_ddbs.sql =========*** End 
 PROMPT ===================================================================================== 
 