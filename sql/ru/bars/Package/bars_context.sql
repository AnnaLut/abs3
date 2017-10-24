
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_context.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_CONTEXT 
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
               || 'SOC_SUBST                    Возможность представления для приема файлов зачислений '  || chr(10)
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

end bars_context;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_CONTEXT wrapped
a000000
ab
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
abcd
b
4b25 13f6
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

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
grant EXECUTE                                                                on BARS_CONTEXT    to BARS_SUP;
grant EXECUTE                                                                on BARS_CONTEXT    to JBOSS_USR;
grant EXECUTE                                                                on BARS_CONTEXT    to KLBX;
grant EXECUTE                                                                on BARS_CONTEXT    to RPBN001;
grant EXECUTE                                                                on BARS_CONTEXT    to RPBN002;
grant EXECUTE                                                                on BARS_CONTEXT    to TEST;
grant EXECUTE                                                                on BARS_CONTEXT    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_context.sql =========*** End **
 PROMPT ===================================================================================== 
 